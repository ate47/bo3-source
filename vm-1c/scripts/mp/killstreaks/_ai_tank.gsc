#using scripts/shared/visionset_mgr_shared;
#using scripts/mp/killstreaks/_uav;
#using scripts/mp/killstreaks/_supplydrop;
#using scripts/mp/killstreaks/_satellite;
#using scripts/mp/killstreaks/_remote_weapons;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreak_detect;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_emp;
#using scripts/mp/killstreaks/_dogs;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_dev;
#using scripts/mp/_util;
#using scripts/mp/_challenges;
#using scripts/shared/vehicles/_amws;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/_oob;
#using scripts/codescripts/struct;

#using_animtree("mp_vehicles");

#namespace ai_tank;

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_c35e6aab
// Checksum 0x374b2fd4, Offset: 0xcd0
// Size: 0x444
function init() {
    bundle = struct::get_script_bundle("killstreak", "killstreak_" + "ai_tank_drop");
    level.var_d52bca11 = "killstreaks/fx_agr_rocket_flash_3p";
    killstreaks::register("ai_tank_drop", "ai_tank_marker", "killstreak_ai_tank_drop", "ai_tank_drop_used", &usekillstreakaitankdrop);
    killstreaks::register_alt_weapon("ai_tank_drop", "amws_gun_turret");
    killstreaks::register_alt_weapon("ai_tank_drop", "amws_launcher_turret");
    killstreaks::register_alt_weapon("ai_tank_drop", "amws_gun_turret_mp_player");
    killstreaks::register_alt_weapon("ai_tank_drop", "amws_launcher_turret_mp_player");
    killstreaks::register_remote_override_weapon("ai_tank_drop", "killstreak_ai_tank");
    killstreaks::function_f79fd1e9("ai_tank_drop", %KILLSTREAK_EARNED_AI_TANK_DROP, %KILLSTREAK_AI_TANK_NOT_AVAILABLE, %KILLSTREAK_AI_TANK_INBOUND, undefined, %KILLSTREAK_AI_TANK_HACKED);
    killstreaks::register_dialog("ai_tank_drop", "mpl_killstreak_ai_tank", "aiTankDialogBundle", "aiTankPilotDialogBundle", "friendlyAiTank", "enemyAiTank", "enemyAiTankMultiple", "friendlyAiTankHacked", "enemyAiTankHacked", "requestAiTank", "threatAiTank");
    killstreaks::devgui_scorestreak_command("ai_tank_drop", "Debug Routes", "set devgui_tank routes");
    level.killstreaks["ai_tank_drop"].threatonkill = 1;
    remote_weapons::registerremoteweapon("killstreak_ai_tank", %MP_REMOTE_USE_TANK, &starttankremotecontrol, &endtankremotecontrol, 0);
    level.var_bb4c5d8a = cos(-96);
    level.var_551d9a16 = getweapon("ai_tank_drone_gun");
    level.var_466bc1b3 = level.var_551d9a16.firetime;
    level.var_a2c31962 = getweapon("killstreak_ai_tank");
    spawns = spawnlogic::get_spawnpoint_array("mp_tdm_spawn");
    level.ai_tank_damage_fx = "killstreaks/fx_agr_damage_state";
    level.ai_tank_explode_fx = "killstreaks/fx_agr_explosion";
    level.ai_tank_crate_explode_fx = "killstreaks/fx_agr_drop_box";
    anims = [];
    anims[anims.size] = mp_vehicles%o_drone_tank_missile1_fire;
    anims[anims.size] = mp_vehicles%o_drone_tank_missile2_fire;
    anims[anims.size] = mp_vehicles%o_drone_tank_missile3_fire;
    anims[anims.size] = mp_vehicles%o_drone_tank_missile_full_reload;
    if (!isdefined(bundle.ksmainturretrecoilforcezoffset)) {
        bundle.ksmainturretrecoilforcezoffset = 0;
    }
    if (!isdefined(bundle.ksweaponreloadtime)) {
        bundle.ksweaponreloadtime = 0.5;
    }
    visionset_mgr::register_info("visionset", "agr_visionset", 1, 80, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
    /#
        level thread function_56aef0f();
    #/
    thread register();
}

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_50f16166
// Checksum 0x86303678, Offset: 0x1120
// Size: 0xc4
function register() {
    clientfield::register("vehicle", "ai_tank_death", 1, 1, "int");
    clientfield::register("vehicle", "ai_tank_missile_fire", 1, 2, "int");
    clientfield::register("vehicle", "ai_tank_stun", 1, 1, "int");
    clientfield::register("toplayer", "ai_tank_update_hud", 1, 1, "counter");
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_5b6da341
// Checksum 0xeb0bee1, Offset: 0x11f0
// Size: 0x2e0
function usekillstreakaitankdrop(hardpointtype) {
    team = self.team;
    if (!self supplydrop::issupplydropgrenadeallowed(hardpointtype)) {
        return 0;
    }
    killstreak_id = self killstreakrules::killstreakstart(hardpointtype, team, 0, 0);
    if (killstreak_id == -1) {
        return 0;
    }
    context = spawnstruct();
    if (!isdefined(context)) {
        killstreak_stop_and_assert(hardpointtype, team, killstreak_id, "Failed to spawn struct for ai tank.");
        return 0;
    }
    context.radius = level.killstreakcorebundle.ksairdropaitankradius;
    context.dist_from_boundary = 16;
    context.max_dist_from_location = 4;
    context.perform_physics_trace = 1;
    context.check_same_floor = 1;
    context.islocationgood = &is_location_good;
    context.objective = %airdrop_aitank;
    context.killstreakref = hardpointtype;
    context.validlocationsound = level.killstreakcorebundle.ksvalidaitanklocationsound;
    context.tracemask = 1 | 4;
    context.droptag = "tag_attach";
    context.droptagoffset = (-35, 0, 10);
    result = self supplydrop::usesupplydropmarker(killstreak_id, context);
    self notify(#"supply_drop_marker_done");
    if (!isdefined(result) || !result) {
        killstreakrules::killstreakstop(hardpointtype, team, killstreak_id);
        return 0;
    }
    self killstreaks::play_killstreak_start_dialog("ai_tank_drop", self.team, killstreak_id);
    self killstreakrules::displaykillstreakstartteammessagetoall("ai_tank_drop");
    self addweaponstat(getweapon("ai_tank_marker"), "used", 1);
    return result;
}

// Namespace ai_tank
// Params 5, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_8c212895
// Checksum 0x2f56f40, Offset: 0x14d8
// Size: 0x24c
function crateland(crate, category, owner, team, context) {
    context.perform_physics_trace = 0;
    context.dist_from_boundary = 24;
    context.max_dist_from_location = 96;
    if (owner emp::enemyempactive() && (!crate is_location_good(crate.origin, context) || !isdefined(owner) || team != owner.team || !owner hasperk("specialty_immuneemp"))) {
        killstreakrules::killstreakstop(category, team, crate.package_contents_id);
        wait(10);
        if (isdefined(crate)) {
            crate delete();
        }
        return;
    }
    origin = crate.origin;
    cratebottom = bullettrace(origin, origin + (0, 0, -50), 0, crate);
    if (isdefined(cratebottom)) {
        origin = cratebottom["position"] + (0, 0, 1);
    }
    playfx(level.ai_tank_crate_explode_fx, origin, (1, 0, 0), (0, 0, 1));
    playsoundatposition("veh_talon_crate_exp", crate.origin);
    level thread ai_tank_killstreak_start(owner, origin, crate.package_contents_id, category);
    crate delete();
}

// Namespace ai_tank
// Params 2, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_59189d4b
// Checksum 0xbc61d07a, Offset: 0x1730
// Size: 0x42
function is_location_good(location, context) {
    return supplydrop::islocationgood(location, context) && function_150cbb51(location);
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_150cbb51
// Checksum 0x8b7b206b, Offset: 0x1780
// Size: 0xee
function function_150cbb51(location) {
    if (!isdefined(location)) {
        location = self.origin;
    }
    if (!isplayer(self)) {
        start = self getcentroid();
        end = location + (0, 0, 16);
        trace = physicstrace(start, end, (0, 0, 0), (0, 0, 0), self, 16);
        if (trace["fraction"] < 1) {
            return false;
        }
    }
    if (self oob::istouchinganyoobtrigger()) {
        return false;
    }
    return true;
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_c18de8cf
// Checksum 0xb97972ad, Offset: 0x1878
// Size: 0x14c
function hackedcallbackpre(hacker) {
    drone = self;
    drone clientfield::set("enemyvehicle", 2);
    drone.owner stop_remote();
    drone.owner clientfield::set_to_player("static_postfx", 0);
    if (drone.controlled === 1) {
        visionset_mgr::deactivate("visionset", "agr_visionset", drone.owner);
    }
    drone.owner remote_weapons::removeandassignnewremotecontroltrigger(drone.usetrigger);
    drone remote_weapons::endremotecontrolweaponuse(1);
    drone.owner unlink();
    drone clientfield::set("vehicletransition", 0);
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_96e69632
// Checksum 0x2dcdde62, Offset: 0x19d0
// Size: 0x70
function hackedcallbackpost(hacker) {
    drone = self;
    hacker remote_weapons::useremoteweapon(drone, "killstreak_ai_tank", 0);
    drone notify(#"watchremotecontroldeactivate_remoteweapons");
    drone.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(drone);
}

// Namespace ai_tank
// Params 2, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_d92ac79e
// Checksum 0xbf109e51, Offset: 0x1a48
// Size: 0x3c
function configureteampost(owner, ishacked) {
    drone = self;
    drone thread tank_watch_owner_events();
}

// Namespace ai_tank
// Params 4, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_b74a2f7e
// Checksum 0xfb758726, Offset: 0x1a90
// Size: 0x4f0
function ai_tank_killstreak_start(owner, origin, killstreak_id, category) {
    team = owner.team;
    waittillframeend();
    if (level.gameended) {
        return;
    }
    drone = spawnvehicle("spawner_bo3_ai_tank_mp", origin, (0, 0, 0), "talon");
    if (!isdefined(drone)) {
        killstreak_stop_and_assert(category, team, killstreak_id, "Failed to spawn ai tank vehicle.");
        return;
    }
    drone.settings = struct::get_script_bundle("vehiclecustomsettings", drone.scriptbundlesettings);
    drone.customdamagemonitor = 1;
    drone.avoid_shooting_owner = 1;
    drone.avoid_shooting_owner_ref_tag = "tag_flash_gunner1";
    drone killstreaks::configure_team("ai_tank_drop", killstreak_id, owner, "small_vehicle", undefined, &configureteampost);
    drone killstreak_hacking::enable_hacking("ai_tank_drop", &hackedcallbackpre, &hackedcallbackpost);
    drone killstreaks::setup_health("ai_tank_drop", 1500, 0);
    drone.original_vehicle_type = drone.vehicletype;
    drone clientfield::set("enemyvehicle", 1);
    drone setvehicleavoidance(1);
    drone clientfield::set("ai_tank_missile_fire", 3);
    drone.killstreak_id = killstreak_id;
    drone.type = "tank_drone";
    drone.dontdisconnectpaths = 1;
    drone.isstunned = 0;
    drone.soundmod = "drone_land";
    drone.ignore_vehicle_underneath_splash_scalar = 1;
    drone.treat_owner_damage_as_friendly_fire = 1;
    drone.ignore_team_kills = 1;
    drone.controlled = 0;
    drone makevehicleunusable();
    drone.numberrockets = 3;
    drone.warningshots = 3;
    drone setdrawinfrared(1);
    if (!isdefined(drone.owner.var_d450ce86)) {
        drone.owner.var_d450ce86 = 1;
    } else {
        drone.owner.var_d450ce86++;
    }
    drone.var_bed2fbe5 = drone.owner.var_d450ce86;
    target_set(drone, (0, 0, 20));
    function_38a2c2c2(drone, 0);
    drone vehicle::init_target_group();
    drone vehicle::add_to_target_group(drone);
    drone setup_gameplay_think(category);
    drone.killstreak_end_time = gettime() + 120000;
    owner remote_weapons::useremoteweapon(drone, "killstreak_ai_tank", 0);
    drone thread kill_monitor();
    drone thread deleteonkillbrush(drone.owner);
    drone thread tank_rocket_watch_ai();
    level thread function_955831f9(drone);
    /#
        drone thread function_9e843a04();
    #/
    /#
    #/
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// namespace_e4c2b65e<file_0>::function_89166848
// Checksum 0x9b0a5e26, Offset: 0x1f88
// Size: 0x4e
function function_89166848(var_ef327ae6) {
    switch (var_ef327ae6) {
    case 2:
    default:
        return "spawner_bo3_ai_tank_mp";
    case 1:
        return "ai_tank_drone_mp";
    }
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_7e504ffe
// Checksum 0xb3d10147, Offset: 0x1fe0
// Size: 0xac
function setup_gameplay_think(category) {
    drone = self;
    drone thread tank_abort_think();
    drone thread tank_team_kill();
    drone thread tank_too_far_from_nav_mesh_abort_think();
    drone thread tank_death_think(category);
    drone thread tank_damage_think();
    drone thread watchwater();
}

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_9e843a04
// Checksum 0x73275696, Offset: 0x2098
// Size: 0x638
function function_9e843a04() {
    self endon(#"death");
    var_30632b02 = 1;
    text_scale = 0.5;
    var_c4286b71 = 1;
    var_5be12bc8 = (1, 1, 1);
    while (true) {
        if (getdvarint("scr_ai_tank_think_debug") == 0) {
            wait(5);
            continue;
        }
        target_name = "unknown";
        target_entity = undefined;
        var_b0a0260d = !isdefined(self.enemy);
        target_entity = self.enemy;
        if (isdefined(target_entity) && !var_b0a0260d) {
            if (isdefined(target_entity.name)) {
                target_name = target_entity.name;
            } else if (isdefined(target_entity.remotename)) {
                target_name = target_entity.remotename;
            }
        }
        var_68e6cb10 = var_b0a0260d ? "Target: none" : "Target: " + target_name;
        /#
            print3d(self.origin, var_68e6cb10, var_5be12bc8, var_c4286b71, text_scale, var_30632b02);
        #/
        var_3165e2a1 = "Duration: " + (self.killstreak_end_time - gettime()) * 0.001;
        /#
            print3d(self.origin + (0, 0, 12), var_3165e2a1, var_5be12bc8, var_c4286b71, text_scale, var_30632b02);
        #/
        var_2b0cb2d5 = "Can see: ";
        if (var_b0a0260d) {
            var_2b0cb2d5 += "---";
        } else {
            var_2b0cb2d5 += self function_4246bc05(target_entity) ? "yes" : "no";
        }
        /#
            print3d(self.origin + (0, 0, -12), var_2b0cb2d5, var_5be12bc8, var_c4286b71, text_scale, var_30632b02);
        #/
        var_79cdafd9 = "Movement: ";
        if (isdefined(self.debug_ai_movement_type)) {
            var_79cdafd9 += self.debug_ai_movement_type;
        } else {
            var_79cdafd9 += "---";
        }
        /#
            print3d(self.origin + (0, 0, -24), var_79cdafd9, var_5be12bc8, var_c4286b71, text_scale, var_30632b02);
        #/
        if (isdefined(self.debug_ai_move_to_point)) {
            /#
                util::debug_sphere(self.debug_ai_move_to_point + (0, 0, 16), 10, (0.1, 0.95, 0.1), 0.9, var_30632b02);
            #/
            if (isdefined(self.debug_ai_move_to_points_considered)) {
                foreach (point in self.debug_ai_move_to_points_considered) {
                    point_color = (0.65, 0.65, 0.65);
                    if (isdefined(point.score)) {
                        if (point.score != 0) {
                            if (point.score < 0) {
                                point_color = (0.65, 0.1, 0.1);
                            } else if (point.score > 50) {
                                point_color = (0.1, 0.65, 0.1);
                            } else {
                                point_color = (0.95, 0.95, 0.1);
                            }
                            var_2e715b0a = text_scale;
                            var_8a3aabe1 = var_5be12bc8;
                            if (point.origin != self.debug_ai_move_to_point) {
                                var_2e715b0a *= 0.67;
                            } else {
                                var_2e715b0a *= 1.5;
                                var_8a3aabe1 = (0.05, 0.98, 0.05);
                            }
                            /#
                                print3d(point.origin + (0, 0, 16), point.score, var_8a3aabe1, var_c4286b71, var_2e715b0a, var_30632b02);
                            #/
                        }
                    }
                    if (point.origin != self.debug_ai_move_to_point) {
                        /#
                            util::debug_sphere(point.origin + (0, 0, 16), 3, point_color, 0.5, var_30632b02);
                        #/
                    }
                }
            }
        }
        wait(0.05);
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_358c796
// Checksum 0xc3f65bcf, Offset: 0x26d8
// Size: 0x2e
function tank_team_kill() {
    self endon(#"death");
    self.owner waittill(#"teamkillkicked");
    self notify(#"death");
}

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_b2682202
// Checksum 0x687b8174, Offset: 0x2710
// Size: 0x108
function kill_monitor() {
    self endon(#"death");
    last_kill_vo = 0;
    kill_vo_spacing = 4000;
    while (true) {
        victim = self waittill(#"killed");
        if (!isdefined(self.owner) || !isdefined(victim)) {
            continue;
        }
        if (self.owner == victim) {
            continue;
        }
        if (level.teambased && self.owner.team == victim.team) {
            continue;
        }
        if (!self.controlled && last_kill_vo + kill_vo_spacing < gettime()) {
            self killstreaks::play_pilot_dialog_on_owner("kill", "ai_tank_drop", self.killstreak_id);
            last_kill_vo = gettime();
        }
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_dc7f776f
// Checksum 0x2f0cc8a5, Offset: 0x2820
// Size: 0x54
function tank_abort_think() {
    tank = self;
    tank thread killstreaks::waitfortimeout("ai_tank_drop", 120000, &tank_timeout_callback, "death", "emp_jammed");
}

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_2d730fe1
// Checksum 0xeb1859e4, Offset: 0x2880
// Size: 0x46
function tank_timeout_callback() {
    self killstreaks::play_pilot_dialog_on_owner("timeout", "ai_tank_drop");
    self.timed_out = 1;
    self notify(#"death");
}

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_4cfcf823
// Checksum 0xd682fd17, Offset: 0x28d0
// Size: 0x156
function tank_watch_owner_events() {
    self notify(#"tank_watch_owner_events_singleton");
    self endon(#"tank_watch_owner_events_singleton");
    self endon(#"death");
    self.owner util::waittill_any("joined_team", "disconnect", "joined_spectators");
    self makevehicleusable();
    self.controlled = 0;
    if (isdefined(self.owner)) {
        self.owner unlink();
        self clientfield::set("vehicletransition", 0);
    }
    self makevehicleunusable();
    if (isdefined(self.owner) && self.controlled === 1) {
        visionset_mgr::deactivate("visionset", "agr_visionset", self.owner);
        self.owner stop_remote();
    }
    self.abandoned = 1;
    self notify(#"death");
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_955831f9
// Checksum 0xf37741ef, Offset: 0x2a30
// Size: 0x34
function function_955831f9(drone) {
    drone endon(#"death");
    level waittill(#"game_ended");
    drone notify(#"death");
}

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_462873aa
// Checksum 0xd0c8f2c2, Offset: 0x2a70
// Size: 0x5c
function stop_remote() {
    if (!isdefined(self)) {
        return;
    }
    self killstreaks::clear_using_remote();
    self remote_weapons::destroyremotehud();
    self util::clientnotify("nofutz");
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_de096b2f
// Checksum 0xc5f31269, Offset: 0x2ad8
// Size: 0x90
function tank_hacked_health_update(hacker) {
    tank = self;
    hackeddamagetaken = tank.defaultmaxhealth - tank.hackedhealth;
    assert(hackeddamagetaken > 0);
    if (hackeddamagetaken > tank.damagetaken) {
        tank.damagetaken = hackeddamagetaken;
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_bef55a96
// Checksum 0xcaaa38d5, Offset: 0x2b70
// Size: 0x622
function tank_damage_think() {
    self endon(#"death");
    assert(isdefined(self.maxhealth));
    self.defaultmaxhealth = self.maxhealth;
    maxhealth = self.maxhealth;
    self.maxhealth = 999999;
    self.health = self.maxhealth;
    self.isstunned = 0;
    self.hackedhealthupdatecallback = &tank_hacked_health_update;
    self.hackedhealth = killstreak_bundles::get_hacked_health("ai_tank_drop");
    low_health = 0;
    self.damagetaken = 0;
    for (;;) {
        damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargelevel = self waittill(#"damage");
        self.maxhealth = 999999;
        self.health = self.maxhealth;
        /#
            self.damage_debug = damage + "amws_launcher_turret" + weapon.name + "amws_launcher_turret";
        #/
        if (weapon.isemp && mod == "MOD_GRENADE_SPLASH") {
            emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage("ai_tank_drop", maxhealth);
            if (!isdefined(emp_damage_to_apply)) {
                emp_damage_to_apply = maxhealth / 2;
            }
            self.damagetaken += emp_damage_to_apply;
            damage = 0;
            if (!self.isstunned && emp_damage_to_apply > 0) {
                self.isstunned = 1;
                challenges::stunnedtankwithempgrenade(attacker);
                self thread tank_stun(4);
            }
        }
        if (!self.isstunned) {
            if (mod == "MOD_GRENADE_SPLASH" || weapon.dostun && mod == "MOD_GAS") {
                self.isstunned = 1;
                self thread tank_stun(1.5);
            }
        }
        weapon_damage = killstreak_bundles::get_weapon_damage("ai_tank_drop", maxhealth, attacker, weapon, mod, damage, flags, chargelevel);
        if (!isdefined(weapon_damage)) {
            if (mod == "MOD_PROJECTILE_SPLASH" && (mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET" || weapon.name == "hatchet" || weapon.bulletimpactexplode)) {
                if (isplayer(attacker)) {
                    if (attacker hasperk("specialty_armorpiercing")) {
                        damage += int(damage * level.cac_armorpiercing_data);
                    }
                }
                if (weapon.weapclass == "spread") {
                    damage *= 1.5;
                }
                weapon_damage = damage * 0.8;
            }
            if ((mod == "MOD_PROJECTILE" || mod == "MOD_GRENADE_SPLASH" || mod == "MOD_PROJECTILE_SPLASH") && damage != 0 && !weapon.isemp && !weapon.bulletimpactexplode) {
                weapon_damage = damage * 1;
            }
            if (!isdefined(weapon_damage)) {
                weapon_damage = damage;
            }
        }
        self.damagetaken += weapon_damage;
        if (self.controlled) {
            self.owner sendkillstreakdamageevent(int(weapon_damage));
            self.owner vehicle::update_damage_as_occupant(self.damagetaken, maxhealth);
        }
        if (self.damagetaken >= maxhealth) {
            if (isdefined(self.owner)) {
                self.owner.dofutz = 1;
            }
            self.health = 0;
            self notify(#"death", attacker, mod, weapon);
            return;
        }
        if (!low_health && self.damagetaken > maxhealth / 1.8) {
            self killstreaks::play_pilot_dialog_on_owner("damaged", "ai_tank_drop", self.killstreak_id);
            self thread tank_low_health_fx();
            low_health = 1;
        }
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_e4a16458
// Checksum 0x8af86660, Offset: 0x31a0
// Size: 0xec
function tank_low_health_fx() {
    self endon(#"death");
    self.damage_fx = spawn("script_model", self gettagorigin("tag_origin") + (0, 0, -14));
    if (!isdefined(self.damage_fx)) {
        return;
    }
    self.damage_fx setmodel("tag_origin");
    self.damage_fx linkto(self, "tag_turret", (0, 0, -14), (0, 0, 0));
    wait(0.1);
    playfxontag(level.ai_tank_damage_fx, self.damage_fx, "tag_origin");
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_6d14ab65
// Checksum 0x59434629, Offset: 0x3298
// Size: 0xcc
function deleteonkillbrush(player) {
    player endon(#"disconnect");
    self endon(#"death");
    killbrushes = getentarray("trigger_hurt", "classname");
    while (true) {
        for (i = 0; i < killbrushes.size; i++) {
            if (self istouching(killbrushes[i])) {
                if (isdefined(self)) {
                    self notify(#"death", self.owner);
                }
                return;
            }
        }
        wait(0.1);
    }
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_20ab677c
// Checksum 0x378637f7, Offset: 0x3370
// Size: 0x240
function tank_stun(duration) {
    self endon(#"death");
    self notify(#"stunned");
    self clearvehgoalpos();
    forward = anglestoforward(self.angles);
    forward = self.origin + forward * -128;
    forward -= (0, 0, 64);
    self setturrettargetvec(forward);
    self disablegunnerfiring(0, 1);
    self laseroff();
    if (self.controlled) {
        self.owner freezecontrols(1);
        self.owner sendkillstreakdamageevent(400);
    }
    if (isdefined(self.owner.var_f04f433)) {
        self.owner thread remote_weapons::stunstaticfx(duration);
    }
    self clientfield::set("ai_tank_stun", 1);
    if (self.controlled) {
        self.owner clientfield::set_to_player("static_postfx", 1);
    }
    wait(duration);
    self clientfield::set("ai_tank_stun", 0);
    if (self.controlled) {
        self.owner clientfield::set_to_player("static_postfx", 0);
    }
    if (self.controlled) {
        self.owner freezecontrols(0);
    }
    self disablegunnerfiring(0, 0);
    self.isstunned = 0;
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// namespace_e4c2b65e<file_0>::function_51851270
// Checksum 0xe7cdb907, Offset: 0x35b8
// Size: 0x21c
function emp_crazy_death() {
    self clientfield::set("ai_tank_stun", 1);
    self notify(#"death");
    time = 0;
    randomangle = randomint(360);
    while (time < 1.45) {
        self setturrettargetvec(self.origin + anglestoforward((randomintrange(305, 315), int(randomangle + time * -76), 0)) * 100);
        if (time > 0.2) {
            self fireweapon(1);
            if (randomint(100) > 85) {
                rocket = self fireweapon(0);
                if (isdefined(rocket)) {
                    rocket.from_ai = 1;
                }
            }
        }
        time += 0.05;
        wait(0.05);
    }
    self clientfield::set("ai_tank_death", 1);
    playfx(level.ai_tank_explode_fx, self.origin, (0, 0, 1));
    playsoundatposition("wpn_agr_explode", self.origin);
    wait(0.05);
    self hide();
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_a6660bd7
// Checksum 0x54c50b43, Offset: 0x37e0
// Size: 0x62c
function tank_death_think(hardpointname) {
    team = self.team;
    killstreak_id = self.killstreak_id;
    attacker, damagefromunderneath, weapon = self waittill(#"death");
    if (!isdefined(self)) {
        killstreak_stop_and_assert(hardpointname, team, killstreak_id, "Failed to handle death. A.");
        return;
    }
    self.dead = 1;
    self laseroff();
    self clearvehgoalpos();
    not_abandoned = !isdefined(self.abandoned) || !self.abandoned;
    if (self.controlled == 1) {
        self.owner sendkillstreakdamageevent(600);
        self.owner remote_weapons::destroyremotehud();
    }
    self clientfield::set("ai_tank_death", 1);
    stunned = 0;
    settings = self.settings;
    if (self.timed_out === 1 || isdefined(settings) && self.abandoned === 1) {
        fx_origin = self gettagorigin(isdefined(settings.timed_out_death_tag_1) ? settings.timed_out_death_tag_1 : "tag_origin");
        playfx(isdefined(settings.timed_out_death_fx_1) ? settings.timed_out_death_fx_1 : level.ai_tank_explode_fx, isdefined(fx_origin) ? fx_origin : self.origin, (0, 0, 1));
        playsoundatposition(isdefined(settings.timed_out_death_sound_1) ? settings.timed_out_death_sound_1 : "wpn_agr_explode", self.origin);
    } else {
        playfx(level.ai_tank_explode_fx, self.origin, (0, 0, 1));
        playsoundatposition("wpn_agr_explode", self.origin);
    }
    if (not_abandoned) {
        util::wait_network_frame();
        if (!isdefined(self)) {
            killstreak_stop_and_assert(hardpointname, team, killstreak_id, "Failed to handle death. B.");
            return;
        }
    }
    if (self.controlled) {
        self ghost();
    } else {
        self hide();
    }
    if (isdefined(self.damage_fx)) {
        self.damage_fx delete();
    }
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (isdefined(attacker) && isplayer(attacker) && isdefined(self.owner) && attacker != self.owner) {
        if (self.owner util::isenemyplayer(attacker)) {
            scoreevents::processscoreevent("destroyed_aitank", attacker, self.owner, weapon);
            luinotifyevent(%player_callout, 2, %KILLSTREAK_DESTROYED_AI_TANK, attacker.entnum);
            attacker addweaponstat(weapon, "destroyed_aitank", 1);
            controlled = 0;
            if (isdefined(self.var_94bc1b48) && self.var_94bc1b48) {
                attacker addweaponstat(weapon, "destroyed_controlled_killstreak", 1);
                controlled = 1;
            }
            attacker challenges::destroyscorestreak(weapon, controlled, 1);
            attacker challenges::function_90c432bd(weapon);
            attacker addweaponstat(weapon, "destroy_aitank_or_setinel", 1);
            self killstreaks::play_destroyed_dialog_on_owner("ai_tank_drop", self.killstreak_id);
        }
    }
    if (not_abandoned) {
        self util::waittill_any_timeout(2, "remote_weapon_end");
        if (!isdefined(self)) {
            killstreak_stop_and_assert(hardpointname, team, killstreak_id, "Failed to handle death. C.");
            return;
        }
    }
    killstreakrules::killstreakstop(hardpointname, team, self.killstreak_id);
    if (isdefined(self.aim_entity)) {
        self.aim_entity delete();
    }
    self delete();
}

// Namespace ai_tank
// Params 4, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_7acf3be1
// Checksum 0xc1ad44e9, Offset: 0x3e18
// Size: 0x5c
function killstreak_stop_and_assert(hardpoint_name, team, killstreak_id, assert_msg) {
    killstreakrules::killstreakstop(hardpoint_name, team, killstreak_id);
    assertmsg(assert_msg);
}

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_23c0c1c9
// Checksum 0xe25a31cc, Offset: 0x3e80
// Size: 0x7e
function tank_too_far_from_nav_mesh_abort_think() {
    self endon(#"death");
    not_on_nav_mesh_count = 0;
    for (;;) {
        wait(1);
        not_on_nav_mesh_count = isdefined(getclosestpointonnavmesh(self.origin, 480)) ? 0 : not_on_nav_mesh_count + 1;
        if (not_on_nav_mesh_count >= 4) {
            self notify(#"death");
        }
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_83a8d785
// Checksum 0x496c51c2, Offset: 0x3f08
// Size: 0x6a
function function_83a8d785() {
    if (level.teambased) {
        return (uav::hasuav(self.team) || satellite::hassatellite(self.team));
    }
    return uav::hasuav(self.entnum) || satellite::hassatellite(self.entnum);
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_c975281
// Checksum 0x52917d3b, Offset: 0x3f80
// Size: 0x1ce
function function_c975281(var_f9e0a43) {
    enemies = [];
    if (!isdefined(var_f9e0a43)) {
        var_f9e0a43 = 0;
    }
    if (var_f9e0a43) {
        time = gettime();
    }
    foreach (var_da4b384f, team in level.aliveplayers) {
        if (level.teambased && var_da4b384f == self.team) {
            continue;
        }
        foreach (player in team) {
            if (!valid_target(player, self.team, self.owner)) {
                continue;
            }
            if (var_f9e0a43) {
                if (time - player.lastfiretime > 3000 && !function_83a8d785()) {
                    continue;
                }
            }
            enemies[enemies.size] = player;
        }
    }
    return enemies;
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// namespace_e4c2b65e<file_0>::function_2efae724
// Checksum 0x1770f54f, Offset: 0x4158
// Size: 0x18c
function function_2efae724() {
    enemies = function_c975281(0);
    position = undefined;
    if (enemies.size) {
        x = 0;
        y = 0;
        z = 0;
        foreach (enemy in enemies) {
            x += enemy.origin[0];
            y += enemy.origin[1];
            z += enemy.origin[2];
        }
        x /= enemies.size;
        y /= enemies.size;
        z /= enemies.size;
        position = (x, y, z);
    }
    return position;
}

// Namespace ai_tank
// Params 3, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_546e90f
// Checksum 0xf9d99e04, Offset: 0x42f0
// Size: 0x250
function valid_target(target, team, owner) {
    if (!isdefined(target)) {
        return false;
    }
    if (!isalive(target)) {
        return false;
    }
    if (target == owner) {
        return false;
    }
    if (isplayer(target)) {
        if (target.sessionstate != "playing") {
            return false;
        }
        if (isdefined(target.lastspawntime) && gettime() - target.lastspawntime < 3000) {
            return false;
        }
        if (target hasperk("specialty_nottargetedbyaitank")) {
            return false;
        }
        /#
            if (target isinmovemode("amws_launcher_turret", "amws_launcher_turret")) {
                return false;
            }
        #/
    }
    if (level.teambased) {
        if (isdefined(target.team) && team == target.team) {
            return false;
        }
    }
    if (isdefined(target.owner) && target.owner == owner) {
        return false;
    }
    if (isdefined(target.script_owner) && target.script_owner == owner) {
        return false;
    }
    if (isdefined(target.dead) && target.dead) {
        return false;
    }
    if (isdefined(target.targetname) && target.targetname == "riotshield_mp") {
        if (isdefined(target.damagetaken) && target.damagetaken >= getdvarint("riotshield_deployed_health")) {
            return false;
        }
    }
    return true;
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_414a9fb0
// Checksum 0xec7a2ec1, Offset: 0x4548
// Size: 0x23c
function starttankremotecontrol(drone) {
    drone makevehicleusable();
    drone clearvehgoalpos();
    drone clearturrettarget();
    drone laseroff();
    drone.treat_owner_damage_as_friendly_fire = 0;
    drone.ignore_team_kills = 0;
    if (isdefined(drone.playerdrivenversion)) {
        drone setvehicletype(drone.playerdrivenversion);
    }
    drone usevehicle(self, 0);
    drone clientfield::set("vehicletransition", 1);
    drone makevehicleunusable();
    drone setbrake(0);
    drone thread tank_rocket_watch(self);
    drone thread vehicle::monitor_missiles_locked_on_to_me(self);
    self vehicle::set_vehicle_drivable_time(120000, drone.killstreak_end_time);
    self vehicle::update_damage_as_occupant(isdefined(drone.damagetaken) ? drone.damagetaken : 0, isdefined(drone.defaultmaxhealth) ? drone.defaultmaxhealth : 100);
    drone update_client_ammo(drone.numberrockets, 1);
    visionset_mgr::activate("visionset", "agr_visionset", self, 1, 90000, 1);
}

// Namespace ai_tank
// Params 2, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_69f947bd
// Checksum 0x5e9bf515, Offset: 0x4790
// Size: 0x21c
function endtankremotecontrol(drone, exitrequestedbyowner) {
    not_dead = !(isdefined(drone.dead) && drone.dead);
    if (isdefined(drone.owner)) {
        drone.owner remote_weapons::destroyremotehud();
    }
    drone.treat_owner_damage_as_friendly_fire = 1;
    drone.ignore_team_kills = 1;
    if (drone.classname == "script_vehicle") {
        drone makevehicleunusable();
    }
    if (isdefined(drone.original_vehicle_type) && not_dead) {
        drone setvehicletype(drone.original_vehicle_type);
    }
    if (isdefined(drone.owner)) {
        drone.owner vehicle::stop_monitor_missiles_locked_on_to_me();
    }
    if (exitrequestedbyowner && not_dead) {
        drone vehicle_ai::set_state("combat");
    }
    if (drone.cobra === 1 && not_dead) {
        drone thread amws::cobra_retract();
    }
    if (isdefined(drone.owner) && drone.controlled === 1) {
        visionset_mgr::deactivate("visionset", "agr_visionset", drone.owner);
    }
    drone clientfield::set("vehicletransition", 0);
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_926d969d
// Checksum 0x4f51dbd, Offset: 0x49b8
// Size: 0xe4
function perform_recoil_missile_turret(player) {
    bundle = level.killstreakbundle["ai_tank_drop"];
    earthquake(0.4, 0.5, self.origin, -56);
    self perform_recoil("tag_barrel", isdefined(self.controlled) && self.controlled ? bundle.ksmainturretrecoilforcecontrolled : bundle.ksmainturretrecoilforce, bundle.ksmainturretrecoilforcezoffset);
    if (self.controlled && isdefined(player)) {
        player playrumbleonentity("sniper_fire");
    }
}

// Namespace ai_tank
// Params 3, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_f6dae745
// Checksum 0x29de3f74, Offset: 0x4aa8
// Size: 0x94
function perform_recoil(recoil_tag, force_scale_factor, force_z_offset) {
    angles = self gettagangles(recoil_tag);
    dir = anglestoforward(angles);
    self launchvehicle(dir * force_scale_factor, self.origin + (0, 0, force_z_offset), 0);
}

// Namespace ai_tank
// Params 2, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_847aec89
// Checksum 0xca77c55b, Offset: 0x4b48
// Size: 0x7c
function update_client_ammo(ammo_count, driver_only_update) {
    if (!isdefined(driver_only_update)) {
        driver_only_update = 0;
    }
    if (!driver_only_update) {
        self clientfield::set("ai_tank_missile_fire", ammo_count);
    }
    if (self.controlled) {
        self.owner clientfield::increment_to_player("ai_tank_update_hud", 1);
    }
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_aa0d75cc
// Checksum 0xbdbe79cb, Offset: 0x4bd0
// Size: 0x110
function tank_rocket_watch(player) {
    self endon(#"death");
    player endon(#"stopped_using_remote");
    if (self.numberrockets <= 0) {
        self reload_rockets(player);
    }
    if (!self.isstunned) {
        self disabledriverfiring(0);
    }
    while (true) {
        missile = player waittill(#"missile_fire");
        missile.ignore_team_kills = self.ignore_team_kills;
        self.numberrockets--;
        self update_client_ammo(self.numberrockets);
        self perform_recoil_missile_turret(player);
        if (self.numberrockets <= 0) {
            self reload_rockets(player);
        }
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_b10bdf31
// Checksum 0x8a74a70b, Offset: 0x4ce8
// Size: 0x58
function tank_rocket_watch_ai() {
    self endon(#"death");
    while (true) {
        missile = self waittill(#"missile_fire");
        missile.ignore_team_kills = self.ignore_team_kills;
        missile.killcament = self;
    }
}

// Namespace ai_tank
// Params 1, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_9178feb0
// Checksum 0x29a4a5b9, Offset: 0x4d48
// Size: 0x114
function reload_rockets(player) {
    bundle = level.killstreakbundle["ai_tank_drop"];
    self disabledriverfiring(1);
    weapon_wait_duration_ms = int(bundle.ksweaponreloadtime * 1000);
    player setvehicleweaponwaitduration(weapon_wait_duration_ms);
    player setvehicleweaponwaitendtime(gettime() + weapon_wait_duration_ms);
    wait(bundle.ksweaponreloadtime);
    self.numberrockets = 3;
    self update_client_ammo(self.numberrockets);
    wait(0.4);
    if (!self.isstunned) {
        self disabledriverfiring(0);
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x1 linked
// namespace_e4c2b65e<file_0>::function_42767f73
// Checksum 0x46a9f2e4, Offset: 0x4e68
// Size: 0x1be
function watchwater() {
    self endon(#"death");
    inwater = 0;
    while (!inwater) {
        wait(0.3);
        trace = physicstrace(self.origin + (0, 0, 42), self.origin + (0, 0, 12), (-2, -2, -2), (2, 2, 2), self, 4);
        inwater = trace["fraction"] < (42 - 36) / (42 - 12) && trace["fraction"] != 1;
        var_8e1f933b = 42 - 12 - trace["fraction"] * (42 - 12);
        var_b8acdf42 = min(1, var_8e1f933b / (36 - 12));
        if (isdefined(self.owner) && self.controlled) {
            self.owner clientfield::set_to_player("static_postfx", var_b8acdf42 > 0 ? 1 : 0);
        }
    }
    if (isdefined(self.owner)) {
        self.owner.dofutz = 1;
    }
    self notify(#"death");
}

/#

    // Namespace ai_tank
    // Params 0, eflags: 0x1 linked
    // namespace_e4c2b65e<file_0>::function_56aef0f
    // Checksum 0x8e0ebc57, Offset: 0x5030
    // Size: 0xa8
    function function_56aef0f() {
        setdvar("amws_launcher_turret", "amws_launcher_turret");
        for (;;) {
            wait(0.25);
            level.var_466bc1b3 = level.var_551d9a16.firetime;
            if (getdvarstring("amws_launcher_turret") == "amws_launcher_turret") {
                function_d20cb955();
                setdvar("amws_launcher_turret", "amws_launcher_turret");
            }
        }
    }

    // Namespace ai_tank
    // Params 2, eflags: 0x1 linked
    // namespace_e4c2b65e<file_0>::function_a06e2866
    // Checksum 0xfb2c6ee6, Offset: 0x50e0
    // Size: 0xa2
    function function_a06e2866(node1, node2) {
        self endon(#"death");
        self endon(#"hash_9d163ef3");
        for (;;) {
            self setvehgoalpos(node1.origin, 1);
            self waittill(#"reached_end_node");
            wait(1);
            self setvehgoalpos(node2.origin, 1);
            self waittill(#"reached_end_node");
            wait(1);
        }
    }

    // Namespace ai_tank
    // Params 0, eflags: 0x1 linked
    // namespace_e4c2b65e<file_0>::function_d20cb955
    // Checksum 0x8f8fedae, Offset: 0x5190
    // Size: 0x152
    function function_d20cb955() {
        iprintln("amws_launcher_turret");
        nodes = dev::dev_get_node_pair();
        if (!isdefined(nodes)) {
            iprintln("amws_launcher_turret");
            return;
        }
        iprintln("amws_launcher_turret");
        tanks = getentarray("amws_launcher_turret", "amws_launcher_turret");
        foreach (tank in tanks) {
            tank notify(#"hash_9d163ef3");
            tank thread function_a06e2866(nodes[0], nodes[1]);
        }
    }

    // Namespace ai_tank
    // Params 0, eflags: 0x0
    // namespace_e4c2b65e<file_0>::function_cd2a55ac
    // Checksum 0xb9f02065, Offset: 0x52f0
    // Size: 0x268
    function function_cd2a55ac() {
                for (host = util::gethostplayer(); !isdefined(host); host = util::gethostplayer()) {
            wait(0.25);
        }
        x = 80;
        y = 40;
        level.var_816d4dd0 = newclienthudelem(host);
        level.var_816d4dd0.x = x + 80;
        level.var_816d4dd0.y = y + 2;
        level.var_816d4dd0.alignx = "amws_launcher_turret";
        level.var_816d4dd0.aligny = "amws_launcher_turret";
        level.var_816d4dd0.horzalign = "amws_launcher_turret";
        level.var_816d4dd0.vertalign = "amws_launcher_turret";
        level.var_816d4dd0.alpha = 0;
        level.var_816d4dd0.foreground = 0;
        level.var_816d4dd0 setshader("amws_launcher_turret", 1, 8);
        level.var_a8366348 = newclienthudelem(host);
        level.var_a8366348.x = x + 80;
        level.var_a8366348.y = y;
        level.var_a8366348.alignx = "amws_launcher_turret";
        level.var_a8366348.aligny = "amws_launcher_turret";
        level.var_a8366348.horzalign = "amws_launcher_turret";
        level.var_a8366348.vertalign = "amws_launcher_turret";
        level.var_a8366348.alpha = 0;
        level.var_a8366348.fontscale = 1;
        level.var_a8366348.foreground = 1;
    }

    // Namespace ai_tank
    // Params 0, eflags: 0x0
    // namespace_e4c2b65e<file_0>::function_11381be6
    // Checksum 0x15b8a2af, Offset: 0x5560
    // Size: 0x158
    function function_11381be6() {
        self.damage_debug = "amws_launcher_turret";
        level.var_816d4dd0.alpha = 1;
        level.var_a8366348.alpha = 1;
        for (;;) {
            wait(0.05);
            if (!isdefined(self) || !isalive(self)) {
                level.var_816d4dd0.alpha = 0;
                level.var_a8366348.alpha = 0;
                return;
            }
            width = self.health / self.maxhealth * 300;
            width = int(max(width, 1));
            level.var_816d4dd0 setshader("amws_launcher_turret", width, 8);
            str = self.health + "amws_launcher_turret" + self.damage_debug;
            level.var_a8366348 settext(str);
        }
    }

#/
