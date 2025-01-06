#using scripts/codescripts/struct;
#using scripts/mp/_challenges;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_dev;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/killstreaks/_dogs;
#using scripts/mp/killstreaks/_emp;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreak_detect;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_remote_weapons;
#using scripts/mp/killstreaks/_satellite;
#using scripts/mp/killstreaks/_supplydrop;
#using scripts/mp/killstreaks/_uav;
#using scripts/shared/_oob;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_amws;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/weapons/_weapons;

#using_animtree("mp_vehicles");

#namespace ai_tank;

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0xb37e3d73, Offset: 0xcc8
// Size: 0x432
function init() {
    bundle = struct::get_script_bundle("killstreak", "killstreak_" + "ai_tank_drop");
    level.var_23dea926 = 2;
    level.var_d52bca11 = "killstreaks/fx_agr_rocket_flash_3p";
    killstreaks::register("ai_tank_drop", "ai_tank_marker", "killstreak_ai_tank_drop", "ai_tank_drop_used", &usekillstreakaitankdrop);
    if (level.var_23dea926 == 1) {
        killstreaks::register_alt_weapon("ai_tank_drop", "ai_tank_drone_gun");
        killstreaks::register_alt_weapon("ai_tank_drop", "amws_launcher_turret");
    } else {
        killstreaks::register_alt_weapon("ai_tank_drop", "amws_gun_turret");
        killstreaks::register_alt_weapon("ai_tank_drop", "amws_launcher_turret");
        killstreaks::register_alt_weapon("ai_tank_drop", "amws_gun_turret_mp_player");
        killstreaks::register_alt_weapon("ai_tank_drop", "amws_launcher_turret_mp_player");
    }
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
// Params 0, eflags: 0x0
// Checksum 0x578c19e, Offset: 0x1108
// Size: 0xa2
function register() {
    clientfield::register("vehicle", "ai_tank_death", 1, 1, "int");
    clientfield::register("vehicle", "ai_tank_missile_fire", 1, 2, "int");
    clientfield::register("vehicle", "ai_tank_stun", 1, 1, "int");
    clientfield::register("toplayer", "ai_tank_update_hud", 1, 1, "counter");
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0x929fb9a9, Offset: 0x11b8
// Size: 0x11a
function usekillstreakaitankdrop(hardpointtype) {
    team = self.team;
    if (!self supplydrop::issupplydropgrenadeallowed(hardpointtype)) {
        return false;
    }
    killstreak_id = self killstreakrules::killstreakstart(hardpointtype, team, 0, 0);
    if (killstreak_id == -1) {
        return false;
    }
    context = spawnstruct();
    context.radius = level.killstreakcorebundle.ksairdropaitankradius;
    context.dist_from_boundary = 16;
    context.max_dist_from_location = 4;
    context.perform_physics_trace = 1;
    context.check_same_floor = 1;
    context.islocationgood = &is_location_good;
    context.objective = %airdrop_aitank;
    context.killstreakref = hardpointtype;
    context.validlocationsound = level.killstreakcorebundle.ksvalidaitanklocationsound;
    InvalidOpCode(0xb9, 4, 1);
    // Unknown operator (0xb9, t7_1b, PC)
}

// Namespace ai_tank
// Params 5, eflags: 0x0
// Checksum 0x4534386a, Offset: 0x1388
// Size: 0x1b2
function crateland(crate, category, owner, team, context) {
    context.perform_physics_trace = 0;
    context.dist_from_boundary = 24;
    context.max_dist_from_location = 96;
    if (owner emp::enemyempactive() && (!crate is_location_good(crate.origin, context) || !isdefined(owner) || team != owner.team || !owner hasperk("specialty_immuneemp"))) {
        killstreakrules::killstreakstop(category, team, crate.package_contents_id);
        wait 10;
        crate delete();
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
// Params 2, eflags: 0x0
// Checksum 0x89141e51, Offset: 0x1548
// Size: 0x39
function is_location_good(location, context) {
    return supplydrop::islocationgood(location, context) && function_150cbb51(location);
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0xbb96de58, Offset: 0x1590
// Size: 0xa9
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
// Params 1, eflags: 0x0
// Checksum 0xe04d6aa3, Offset: 0x1648
// Size: 0xf2
function hackedcallbackpre(hacker) {
    drone = self;
    drone clientfield::set("enemyvehicle", 2);
    drone.owner stop_remote();
    drone.owner clientfield::set_to_player("static_postfx", 0);
    visionset_mgr::deactivate("visionset", "agr_visionset", drone.owner);
    drone.owner remote_weapons::removeandassignnewremotecontroltrigger(drone.usetrigger);
    drone remote_weapons::endremotecontrolweaponuse(1);
    drone.owner unlink();
    drone clientfield::set("vehicletransition", 0);
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0xee0301bd, Offset: 0x1748
// Size: 0x5a
function hackedcallbackpost(hacker) {
    drone = self;
    hacker remote_weapons::useremoteweapon(drone, "killstreak_ai_tank", 0);
    drone notify(#"watchremotecontroldeactivate_remoteweapons");
    drone.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(drone);
}

// Namespace ai_tank
// Params 2, eflags: 0x0
// Checksum 0x607e2559, Offset: 0x17b0
// Size: 0x32
function configureteampost(owner, ishacked) {
    drone = self;
    drone thread tank_watch_owner_events();
}

// Namespace ai_tank
// Params 4, eflags: 0x0
// Checksum 0x9e44b595, Offset: 0x17f0
// Size: 0x37d
function ai_tank_killstreak_start(owner, origin, killstreak_id, category) {
    waittillframeend();
    drone = spawnvehicle(function_89166848(level.var_23dea926), origin, (0, 0, 0), "talon");
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
    drone function_347ef800(level.var_23dea926);
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
// Checksum 0xf6951d10, Offset: 0x1b78
// Size: 0x49
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
// Params 1, eflags: 0x0
// Checksum 0xe44cdf62, Offset: 0x1bd0
// Size: 0x95
function function_347ef800(var_ef327ae6) {
    drone = self;
    switch (var_ef327ae6) {
    case 2:
    default:
        break;
    case 1:
        drone thread function_228838c2();
        drone thread function_75f7093e();
        drone thread function_b072f745();
        drone thread function_d3b7f5b0();
        drone thread function_7ab24105();
        break;
    }
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0x35f8d9f9, Offset: 0x1c70
// Size: 0x7a
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
// Params 0, eflags: 0x0
// Checksum 0xa22d4176, Offset: 0x1cf8
// Size: 0x4e5
function function_9e843a04() {
    self endon(#"death");
    var_30632b02 = 1;
    text_scale = 0.5;
    var_c4286b71 = 1;
    var_5be12bc8 = (1, 1, 1);
    while (true) {
        if (getdvarint("scr_ai_tank_think_debug") == 0) {
            wait 5;
            continue;
        }
        target_name = "unknown";
        target_entity = undefined;
        if (level.var_23dea926 == 1) {
            var_b0a0260d = self function_b0a0260d();
            target_entity = self.target_entity;
        } else {
            var_b0a0260d = !isdefined(self.enemy);
            target_entity = self.enemy;
        }
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
        wait 0.05;
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x3bedb104, Offset: 0x21e8
// Size: 0x23
function tank_team_kill() {
    self endon(#"death");
    self.owner waittill(#"teamkillkicked");
    self notify(#"death");
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0xe574fa18, Offset: 0x2218
// Size: 0xd1
function kill_monitor() {
    self endon(#"death");
    last_kill_vo = 0;
    kill_vo_spacing = 4000;
    while (true) {
        self waittill(#"killed", victim);
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
// Params 0, eflags: 0x0
// Checksum 0xb5819149, Offset: 0x22f8
// Size: 0x4a
function tank_abort_think() {
    tank = self;
    tank thread killstreaks::waitfortimeout("ai_tank_drop", 120000, &tank_timeout_callback, "death", "emp_jammed");
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x97dff40f, Offset: 0x2350
// Size: 0x33
function tank_timeout_callback() {
    self killstreaks::play_pilot_dialog_on_owner("timeout", "ai_tank_drop");
    self.timed_out = 1;
    self notify(#"death");
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x2dc46a62, Offset: 0x2390
// Size: 0x103
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
    if (isdefined(self.owner)) {
        visionset_mgr::deactivate("visionset", "agr_visionset", self.owner);
        self.owner stop_remote();
    }
    self.abandoned = 1;
    self notify(#"death");
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0xbd56a088, Offset: 0x24a0
// Size: 0x28
function function_955831f9(drone) {
    drone endon(#"death");
    level waittill(#"game_ended");
    drone notify(#"death");
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0xcdd0aa07, Offset: 0x24d0
// Size: 0x42
function stop_remote() {
    if (!isdefined(self)) {
        return;
    }
    self killstreaks::clear_using_remote();
    self remote_weapons::destroyremotehud();
    self util::clientnotify("nofutz");
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0xac7a0bed, Offset: 0x2520
// Size: 0x66
function tank_hacked_health_update(hacker) {
    tank = self;
    hackeddamagetaken = tank.defaultmaxhealth - tank.hackedhealth;
    assert(hackeddamagetaken > 0);
    if (hackeddamagetaken > tank.damagetaken) {
        tank.damagetaken = hackeddamagetaken;
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x3410e67, Offset: 0x2590
// Size: 0x52f
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
        self waittill(#"damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags, inflictor, chargelevel);
        self.maxhealth = 999999;
        self.health = self.maxhealth;
        /#
            self.damage_debug = damage + "<dev string:x28>" + weapon.name + "<dev string:x2b>";
        #/
        if (weapon.isemp && mod == "MOD_GRENADE_SPLASH") {
            emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage("ai_tank_drop", maxhealth);
            if (!isdefined(emp_damage_to_apply)) {
                emp_damage_to_apply = maxhealth / 2;
            }
            self.damagetaken = self.damagetaken + emp_damage_to_apply;
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
        self.damagetaken = self.damagetaken + weapon_damage;
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
        if (level.var_23dea926 == 1) {
            if (isdefined(attacker) && isplayer(attacker) && self function_b0a0260d() && !self.isstunned) {
                self.aim_entity.origin = attacker getcentroid();
                self.aim_entity.delay = 8;
                self notify(#"aim_updated");
            }
        }
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0xa80ae6c7, Offset: 0x2ac8
// Size: 0xc2
function tank_low_health_fx() {
    self endon(#"death");
    self.damage_fx = spawn("script_model", self gettagorigin("tag_origin") + (0, 0, -14));
    self.damage_fx setmodel("tag_origin");
    self.damage_fx linkto(self, "tag_turret", (0, 0, -14), (0, 0, 0));
    wait 0.1;
    playfxontag(level.ai_tank_damage_fx, self.damage_fx, "tag_origin");
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0xaefdef55, Offset: 0x2b98
// Size: 0x9d
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
        wait 0.1;
    }
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0x306ee3ec, Offset: 0x2c40
// Size: 0x1f2
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
    wait duration;
    self clientfield::set("ai_tank_stun", 0);
    if (self.controlled) {
        self.owner clientfield::set_to_player("static_postfx", 0);
    }
    if (self.controlled) {
        self.owner freezecontrols(0);
    }
    if (self.controlled == 0) {
        self thread function_228838c2();
        self thread function_75f7093e();
        self thread function_b072f745();
    }
    self disablegunnerfiring(0, 0);
    self.isstunned = 0;
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x8b4cf481, Offset: 0x2e40
// Size: 0x19a
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
        wait 0.05;
    }
    self clientfield::set("ai_tank_death", 1);
    playfx(level.ai_tank_explode_fx, self.origin, (0, 0, 1));
    playsoundatposition("wpn_agr_explode", self.origin);
    wait 0.05;
    self hide();
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0xe50eea8b, Offset: 0x2fe8
// Size: 0x3fa
function tank_death_think(hardpointname) {
    team = self.team;
    self waittill(#"death", attacker, type, weapon);
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
            if (isdefined(self.var_94bc1b48) && self.var_94bc1b48) {
                attacker addweaponstat(weapon, "destroyed_controlled_killstreak", 1);
            }
            self killstreaks::play_destroyed_dialog_on_owner("ai_tank_drop", self.killstreak_id);
        }
    }
    if (not_abandoned) {
        self util::waittill_any_timeout(2, "remote_weapon_end");
    }
    killstreakrules::killstreakstop(hardpointname, team, self.killstreak_id);
    if (isdefined(self.aim_entity)) {
        self.aim_entity delete();
    }
    self delete();
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x115b6765, Offset: 0x33f0
// Size: 0x2e5
function function_228838c2() {
    self endon(#"death");
    self endon(#"stunned");
    self endon(#"remote_start");
    level endon(#"game_ended");
    /#
        self endon(#"hash_9d163ef3");
    #/
    bundle = level.killstreakbundle["ai_tank_drop"];
    do_wait = 1;
    for (;;) {
        if (do_wait) {
            wait randomfloatrange(bundle.var_25b09bfa, bundle.var_f8a427b4);
        }
        do_wait = 1;
        if (!function_b0a0260d()) {
            enemy = function_91802df0();
            if (valid_target(enemy, self.team, self.owner)) {
                if (distancesquared(self.origin, enemy.origin) < 65536) {
                    self clearvehgoalpos();
                    wait 0.2;
                } else {
                    self setvehgoalpos(enemy.origin, 1, 1);
                    self util::wait_endon(3, "reached_end_node");
                }
                if (valid_target(enemy, self.team, self.owner)) {
                    do_wait = 0;
                }
                continue;
            }
        }
        nodes = [];
        var_13cea8c7 = function_2efae724();
        if (isdefined(var_13cea8c7)) {
            nodes = util::positionquery_pointarray(var_13cea8c7, 0, 256, 70, 40);
        }
        if (nodes.size == 0) {
            nodes = util::positionquery_pointarray(self.owner.origin, 256, 1024, 70, -128);
        }
        if (nodes.size > 0) {
            node = nodes[randomintrange(0, nodes.size)];
        } else {
            continue;
        }
        var_19f3aff6 = pathdistance(self.origin, node);
        if (!isdefined(var_19f3aff6)) {
            var_19f3aff6 = 999999;
        }
        var_a0a5cee4 = var_19f3aff6 > 256;
        if (var_a0a5cee4 && self setvehgoalpos(node, 1, 1)) {
            event = self util::waittill_any_timeout(45, "reached_end_node", "force_movement_wake");
            if (event != "reached_end_node") {
                do_wait = 0;
            }
            continue;
        }
        self clearvehgoalpos();
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0xff5652d3, Offset: 0x36e0
// Size: 0x8f
function function_d3b7f5b0() {
    self endon(#"death");
    self endon(#"remote_start");
    for (;;) {
        level waittill(#"riotshield_planted", owner);
        if (owner == self.owner || owner.team == self.team) {
            if (distancesquared(owner.riotshieldentity.origin, self.origin) < 262144) {
                self clearvehgoalpos();
            }
            self notify(#"force_movement_wake");
        }
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0xb76a64a0, Offset: 0x3778
// Size: 0x57
function tank_too_far_from_nav_mesh_abort_think() {
    self endon(#"death");
    not_on_nav_mesh_count = 0;
    for (;;) {
        wait 1;
        not_on_nav_mesh_count = isdefined(getclosestpointonnavmesh(self.origin, 480)) ? 0 : not_on_nav_mesh_count + 1;
        if (not_on_nav_mesh_count >= 4) {
            self notify(#"death");
        }
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x31d82596, Offset: 0x37d8
// Size: 0x249
function function_75f7093e() {
    self endon(#"death");
    self endon(#"stunned");
    self endon(#"remote_start");
    if (!isdefined(self.aim_entity)) {
        self.aim_entity = spawn("script_model", (0, 0, 0));
    }
    self.aim_entity.delay = 0;
    self function_a003ad2a();
    for (;;) {
        self util::wait_endon(randomfloatrange(0.5, 1.5), "aim_updated", "force_aim_wake");
        if (self.aim_entity.delay > 0) {
            wait self.aim_entity.delay;
            self.aim_entity.delay = 0;
        }
        if (!function_b0a0260d()) {
            continue;
        }
        if (self getspeed() <= 1) {
            enemies = function_c975281(0);
            if (enemies.size > 0) {
                var_f303338c = 3;
                var_47763762 = 0;
                while (!var_47763762 && var_f303338c > 0) {
                    enemy = enemies[randomintrange(0, enemies.size)];
                    if (self function_4246bc05(enemy)) {
                        self.aim_entity.origin = enemy getcentroid();
                        var_47763762 = 1;
                        self notify(#"hash_ec7c1371");
                    }
                    var_f303338c--;
                }
                if (var_47763762) {
                    continue;
                }
            }
        }
        yaw = (0, self.angles[1] + randomintrange(-75, 75), 0);
        forward = anglestoforward(yaw);
        origin = self.origin + forward * 1024;
        self.aim_entity.origin = (origin[0], origin[1], origin[2] + 20);
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x460ea433, Offset: 0x3a30
// Size: 0x1fd
function function_b072f745() {
    self endon(#"death");
    self endon(#"stunned");
    self endon(#"remote_start");
    level endon(#"game_ended");
    for (;;) {
        wait 0.5;
        self laseroff();
        origin = self.origin + (0, 0, 32);
        forward = vectornormalize(self.target_entity.origin - self.origin);
        players = function_c975281(0);
        self function_208e1c3f(players, origin, forward);
        if (level.gametype != "hack") {
            dogs = dogs::function_b944b696();
            self function_208e1c3f(dogs, origin, forward);
            tanks = getentarray("talon", "targetname");
            self function_208e1c3f(tanks, origin, forward);
            var_9621cb67 = getentarray("rcbomb", "targetname");
            self function_208e1c3f(var_9621cb67, origin, forward);
            turrets = getentarray("auto_turret", "classname");
            self function_208e1c3f(turrets, origin, forward);
            var_a49abda5 = getentarray("riotshield_mp", "targetname");
            self function_208e1c3f(var_a49abda5, origin, forward);
        }
    }
}

// Namespace ai_tank
// Params 3, eflags: 0x0
// Checksum 0x86235b17, Offset: 0x3c38
// Size: 0x132
function function_208e1c3f(targets, origin, forward) {
    foreach (target in targets) {
        if (!valid_target(target, self.team, self.owner)) {
            continue;
        }
        delta = target.origin - origin;
        delta = vectornormalize(delta);
        dot = vectordot(forward, delta);
        if (dot < level.var_bb4c5d8a) {
            continue;
        }
        if (!bullettracepassed(origin, target getcentroid(), 0, self, target)) {
            continue;
        }
        self function_d6635801(target);
        break;
    }
    self function_a003ad2a();
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0xc4655138, Offset: 0x3d78
// Size: 0x335
function function_d6635801(enemy) {
    var_9d2ed501 = 1;
    var_8a127801 = self.warningshots;
    bundle = level.killstreakbundle["ai_tank_drop"];
    self laseron();
    for (;;) {
        if (!valid_target(enemy, self.team, self.owner)) {
            return;
        }
        var_28eee57c = var_8a127801 <= 2 && self function_51af996b(enemy);
        self function_fd199534(enemy, var_28eee57c);
        if (var_28eee57c) {
            self clearvehgoalpos();
        }
        can_see_enemy = self function_4246bc05(enemy);
        if (!valid_target(enemy, self.team, self.owner)) {
            return;
        }
        self.aim_entity.origin = enemy getcentroid();
        distsq = distancesquared(self.origin, enemy.origin);
        if (distsq > 4096 && !can_see_enemy) {
            self function_3f6edad4();
            if (self function_b0a0260d()) {
                return;
            }
            continue;
        } else {
            self notify(#"force_movement_wake");
            self notify(#"force_aim_wake");
        }
        if (!can_see_enemy) {
            var_8a127801 = self.warningshots;
        }
        if (var_9d2ed501) {
            self playsound("wpn_metalstorm_lock_on");
            wait randomfloatrange(bundle.var_1bd33ab5, bundle.var_6b4931b);
            var_9d2ed501 = 0;
            if (!valid_target(enemy, self.team, self.owner)) {
                return;
            }
        }
        if (var_28eee57c) {
            rocket = self fireweapon(0, undefined, undefined, self.owner);
            self notify(#"missile_fire");
            if (isdefined(rocket)) {
                rocket.from_ai = 1;
                rocket.killcament = self;
                rocket util::wait_endon(randomfloatrange(0.5, 1), "death");
                continue;
            }
        }
        self fireweapon(1, enemy);
        var_8a127801--;
        wait level.var_466bc1b3;
        if (isdefined(enemy) && !isalive(enemy)) {
            bullets = randomintrange(8, 15);
            for (i = 0; i < bullets; i++) {
                self fireweapon(1, enemy);
                wait level.var_466bc1b3;
            }
        }
        self stopfireweapon();
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x9f8450df, Offset: 0x40b8
// Size: 0x7a
function function_3f6edad4() {
    self endon(#"turret_on_vistarget");
    self endon(#"hash_ec7c1371");
    self endon(#"death");
    var_bfa418bf = gettime() + 5000;
    while (gettime() < var_bfa418bf && !self function_b0a0260d()) {
        if (self function_4246bc05(self.target_entity)) {
            return;
        }
        wait 0.1;
    }
    self function_a003ad2a();
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0x557aebe1, Offset: 0x4140
// Size: 0x91
function function_51af996b(enemy) {
    if (self.numberrockets <= 0) {
        return false;
    }
    if (distancesquared(self.origin, enemy.origin) < 147456) {
        return false;
    }
    origin = self gettagorigin("tag_flash");
    if (!bullettracepassed(origin, enemy.origin + (0, 0, 10), 0, enemy)) {
        return false;
    }
    return true;
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x23c63dd7, Offset: 0x41e0
// Size: 0x145
function function_7ab24105() {
    self endon(#"death");
    self endon(#"remote_start");
    bundle = level.killstreakbundle["ai_tank_drop"];
    if (self.numberrockets <= 0) {
        self disabledriverfiring(1);
        wait bundle.ksweaponreloadtime;
        self.numberrockets = 3;
        self update_client_ammo(self.numberrockets);
        wait 0.4;
        if (!self.isstunned) {
            self disabledriverfiring(0);
        }
    }
    while (true) {
        self waittill(#"missile_fire");
        self.numberrockets--;
        self update_client_ammo(self.numberrockets);
        self perform_recoil_missile_turret();
        if (self.numberrockets <= 0) {
            self disabledriverfiring(1);
            wait bundle.ksweaponreloadtime;
            self.numberrockets = 3;
            self update_client_ammo(self.numberrockets);
            wait 0.4;
            if (!self.isstunned) {
                self disabledriverfiring(0);
            }
        }
    }
}

// Namespace ai_tank
// Params 2, eflags: 0x0
// Checksum 0xa444d4f9, Offset: 0x4330
// Size: 0x202
function function_fd199534(entity, var_35620989) {
    if (!isdefined(var_35620989)) {
        var_35620989 = 0;
    }
    self.target_entity = entity;
    if (var_35620989) {
        angles = self gettagangles("tag_barrel");
        right = anglestoright(angles);
        offset = vectorscale(right, 8);
        velocity = entity getvelocity();
        speed = length(velocity);
        forward = anglestoforward(entity.angles);
        origin = offset + vectorscale(forward, speed);
        self clearturrettarget(1);
        self setturrettargetent(entity, origin);
        return;
    }
    var_2bae697c = (entity.origin[0] - self.origin[0], entity.origin[1] - self.origin[1], 0);
    if (abs(var_2bae697c[0]) > 0.01 || abs(var_2bae697c[1]) > 0.01) {
        var_c384d1ae = vectornormalize(var_2bae697c);
        var_8d22da43 = vectorcross(var_c384d1ae, (0, 0, 1));
        aim_offset = vectorscale(var_8d22da43, -24);
    } else {
        aim_offset = (0, 0, 0);
    }
    self setturrettargetent(entity, aim_offset);
    self function_9af49228(entity, (0, 0, 0), 0);
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x2aba6ba3, Offset: 0x4540
// Size: 0x9
function function_91802df0() {
    return self.target_entity;
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x7d88c560, Offset: 0x4558
// Size: 0x1a
function function_a003ad2a() {
    function_fd199534(self.aim_entity);
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x197d679a, Offset: 0x4580
// Size: 0x1a
function function_b0a0260d() {
    return function_91802df0() == self.aim_entity;
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x1095a5a8, Offset: 0x45a8
// Size: 0x69
function function_83a8d785() {
    if (level.teambased) {
        return (uav::hasuav(self.team) || satellite::hassatellite(self.team));
    }
    return uav::hasuav(self.entnum) || satellite::hassatellite(self.entnum);
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0xc8f5289, Offset: 0x4620
// Size: 0x145
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
// Checksum 0x1d83de32, Offset: 0x4770
// Size: 0xfe
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
// Params 3, eflags: 0x0
// Checksum 0x5b40141f, Offset: 0x4878
// Size: 0x1a1
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
            if (target isinmovemode("<dev string:x2d>", "<dev string:x31>")) {
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
// Params 1, eflags: 0x0
// Checksum 0x1466786d, Offset: 0x4a28
// Size: 0x182
function starttankremotecontrol(drone) {
    drone makevehicleusable();
    drone clearvehgoalpos();
    drone clearturrettarget();
    drone laseroff();
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
// Params 2, eflags: 0x0
// Checksum 0x8ce9d7a1, Offset: 0x4bb8
// Size: 0x1d2
function endtankremotecontrol(drone, exitrequestedbyowner) {
    not_dead = !(isdefined(drone.dead) && drone.dead);
    if (isdefined(drone.owner)) {
        drone.owner remote_weapons::destroyremotehud();
    }
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
        if (level.var_23dea926 == 1) {
            drone thread function_228838c2();
            drone thread function_d3b7f5b0();
            drone thread function_75f7093e();
            drone thread function_b072f745();
            drone thread function_7ab24105();
        } else {
            drone vehicle_ai::set_state("combat");
        }
    }
    if (drone.cobra === 1 && not_dead) {
        drone thread amws::cobra_retract();
    }
    if (isdefined(drone.owner)) {
        visionset_mgr::deactivate("visionset", "agr_visionset", drone.owner);
    }
    drone clientfield::set("vehicletransition", 0);
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0xb0d0aba3, Offset: 0x4d98
// Size: 0x222
function function_564c0cf7(drone) {
    if (!isdefined(drone.dead) || !drone.dead) {
        self thread hud::fade_to_black_for_x_sec(0, 0.25, 0.1, 0.25);
        wait 0.3;
    } else {
        wait 0.75;
        self thread hud::fade_to_black_for_x_sec(0, 0.25, 0.1, 0.25);
        wait 0.3;
    }
    drone makevehicleusable();
    drone.controlled = 0;
    drone notify(#"hash_a00abcca");
    self unlink();
    drone clientfield::set("vehicletransition", 0);
    drone makevehicleunusable();
    self stop_remote();
    if (!isdefined(drone.dead) || isdefined(self.var_1b691447) && !drone.dead) {
        self.var_1b691447 settext("HOLD [{+activate}] TO CONTROL A.G.R.");
        self.var_b8714ea8 settext("");
    }
    self killstreaks::switch_to_last_non_killstreak_weapon();
    wait 0.5;
    self takeweapon(level.var_a2c31962);
    if (!isdefined(drone.dead) || !drone.dead) {
        if (level.var_23dea926 == 1) {
            drone thread function_228838c2();
            drone thread function_d3b7f5b0();
            drone thread function_75f7093e();
            drone thread function_b072f745();
            return;
        }
        drone vehicle_ai::set_state("combat");
    }
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0x2dea9034, Offset: 0x4fc8
// Size: 0xc2
function perform_recoil_missile_turret(player) {
    bundle = level.killstreakbundle["ai_tank_drop"];
    earthquake(0.4, 0.5, self.origin, -56);
    self perform_recoil("tag_barrel", isdefined(self.controlled) && self.controlled ? bundle.ksmainturretrecoilforcecontrolled : bundle.ksmainturretrecoilforce, bundle.ksmainturretrecoilforcezoffset);
    if (self.controlled && isdefined(player)) {
        player playrumbleonentity("sniper_fire");
    }
}

// Namespace ai_tank
// Params 3, eflags: 0x0
// Checksum 0xe1d5975, Offset: 0x5098
// Size: 0x72
function perform_recoil(recoil_tag, force_scale_factor, force_z_offset) {
    angles = self gettagangles(recoil_tag);
    dir = anglestoforward(angles);
    self launchvehicle(dir * force_scale_factor, self.origin + (0, 0, force_z_offset), 0);
}

// Namespace ai_tank
// Params 2, eflags: 0x0
// Checksum 0xdf85ff57, Offset: 0x5118
// Size: 0x62
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
// Params 1, eflags: 0x0
// Checksum 0x9eeabd6b, Offset: 0x5188
// Size: 0xc5
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
        player waittill(#"missile_fire", missile);
        self.numberrockets--;
        self update_client_ammo(self.numberrockets);
        self perform_recoil_missile_turret(player);
        if (self.numberrockets <= 0) {
            self reload_rockets(player);
        }
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0x88129865, Offset: 0x5258
// Size: 0x35
function tank_rocket_watch_ai() {
    self endon(#"death");
    while (true) {
        self waittill(#"missile_fire", missile);
        missile.killcament = self;
    }
}

// Namespace ai_tank
// Params 1, eflags: 0x0
// Checksum 0x48e59e20, Offset: 0x5298
// Size: 0xe2
function reload_rockets(player) {
    bundle = level.killstreakbundle["ai_tank_drop"];
    self disabledriverfiring(1);
    weapon_wait_duration_ms = int(bundle.ksweaponreloadtime * 1000);
    player setvehicleweaponwaitduration(weapon_wait_duration_ms);
    player setvehicleweaponwaitendtime(gettime() + weapon_wait_duration_ms);
    wait bundle.ksweaponreloadtime;
    self.numberrockets = 3;
    self update_client_ammo(self.numberrockets);
    wait 0.4;
    if (!self.isstunned) {
        self disabledriverfiring(0);
    }
}

// Namespace ai_tank
// Params 0, eflags: 0x0
// Checksum 0xf3e12b1d, Offset: 0x5388
// Size: 0x14b
function watchwater() {
    self endon(#"death");
    inwater = 0;
    while (!inwater) {
        wait 0.3;
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
    // Params 0, eflags: 0x0
    // Checksum 0x8e8b1175, Offset: 0x54e0
    // Size: 0x95
    function function_56aef0f() {
        setdvar("<dev string:x38>", "<dev string:x44>");
        for (;;) {
            wait 0.25;
            level.var_466bc1b3 = level.var_551d9a16.firetime;
            if (getdvarstring("<dev string:x38>") == "<dev string:x45>") {
                function_d20cb955();
                setdvar("<dev string:x38>", "<dev string:x44>");
            }
        }
    }

    // Namespace ai_tank
    // Params 2, eflags: 0x0
    // Checksum 0xbb36286f, Offset: 0x5580
    // Size: 0x7b
    function function_a06e2866(node1, node2) {
        self endon(#"death");
        self endon(#"hash_9d163ef3");
        for (;;) {
            self setvehgoalpos(node1.origin, 1);
            self waittill(#"reached_end_node");
            wait 1;
            self setvehgoalpos(node2.origin, 1);
            self waittill(#"reached_end_node");
            wait 1;
        }
    }

    // Namespace ai_tank
    // Params 0, eflags: 0x0
    // Checksum 0xb078e16e, Offset: 0x5608
    // Size: 0x103
    function function_d20cb955() {
        iprintln("<dev string:x4c>");
        nodes = dev::dev_get_node_pair();
        if (!isdefined(nodes)) {
            iprintln("<dev string:x79>");
            return;
        }
        iprintln("<dev string:x8f>");
        tanks = getentarray("<dev string:xae>", "<dev string:xb4>");
        foreach (tank in tanks) {
            tank notify(#"hash_9d163ef3");
            tank thread function_a06e2866(nodes[0], nodes[1]);
        }
    }

    // Namespace ai_tank
    // Params 0, eflags: 0x0
    // Checksum 0x63efca05, Offset: 0x5718
    // Size: 0x206
    function function_cd2a55ac() {
        for (host = util::gethostplayer(); !isdefined(host); host = util::gethostplayer()) {
            wait 0.25;
        }
        x = 80;
        y = 40;
        level.var_816d4dd0 = newclienthudelem(host);
        level.var_816d4dd0.x = x + 80;
        level.var_816d4dd0.y = y + 2;
        level.var_816d4dd0.alignx = "<dev string:xbf>";
        level.var_816d4dd0.aligny = "<dev string:xc4>";
        level.var_816d4dd0.horzalign = "<dev string:xc8>";
        level.var_816d4dd0.vertalign = "<dev string:xc8>";
        level.var_816d4dd0.alpha = 0;
        level.var_816d4dd0.foreground = 0;
        level.var_816d4dd0 setshader("<dev string:xd3>", 1, 8);
        level.var_a8366348 = newclienthudelem(host);
        level.var_a8366348.x = x + 80;
        level.var_a8366348.y = y;
        level.var_a8366348.alignx = "<dev string:xbf>";
        level.var_a8366348.aligny = "<dev string:xc4>";
        level.var_a8366348.horzalign = "<dev string:xc8>";
        level.var_a8366348.vertalign = "<dev string:xc8>";
        level.var_a8366348.alpha = 0;
        level.var_a8366348.fontscale = 1;
        level.var_a8366348.foreground = 1;
    }

    // Namespace ai_tank
    // Params 0, eflags: 0x0
    // Checksum 0xde9688f3, Offset: 0x5928
    // Size: 0x11d
    function function_11381be6() {
        self.damage_debug = "<dev string:x44>";
        level.var_816d4dd0.alpha = 1;
        level.var_a8366348.alpha = 1;
        for (;;) {
            wait 0.05;
            if (!isdefined(self) || !isalive(self)) {
                level.var_816d4dd0.alpha = 0;
                level.var_a8366348.alpha = 0;
                return;
            }
            width = self.health / self.maxhealth * 300;
            width = int(max(width, 1));
            level.var_816d4dd0 setshader("<dev string:xd3>", width, 8);
            str = self.health + "<dev string:xd9>" + self.damage_debug;
            level.var_a8366348 settext(str);
        }
    }

#/
