#using scripts/mp/killstreaks/_supplydrop;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreak_detect;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/_challenges;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/weapons/_heatseekingmissile;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/util_shared;
#using scripts/shared/entityheadicons_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/ai_puppeteer_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace combat_robot;

// Namespace combat_robot
// Params 0, eflags: 0x1 linked
// Checksum 0xcce5922a, Offset: 0x9e8
// Size: 0x174
function init() {
    killstreaks::register("combat_robot", "combat_robot_marker", "killstreak_" + "combat_robot", "combat_robot" + "_used", &function_337618ce, undefined, 1);
    killstreaks::register_alt_weapon("combat_robot", "lmg_light_robot");
    killstreaks::function_f79fd1e9("combat_robot", %KILLSTREAK_COMBAT_ROBOT_EARNED, %KILLSTREAK_COMBAT_ROBOT_NOT_AVAILABLE, %KILLSTREAK_COMBAT_ROBOT_INBOUND, undefined, %KILLSTREAK_COMBAT_ROBOT_HACKED);
    killstreaks::register_dialog("combat_robot", "mpl_killstreak_combat_robot", "combatRobotDialogBundle", "combatRobotPilotDialogBundle", "friendlyCombatRobot", "enemyCombatRobot", "enemyCombatRobotMultiple", "friendlyCombatRobotHacked", "enemyCombatRobotHacked", "requestCombatRobot", "threatCombatRobot");
    level.killstreaks["inventory_combat_robot"].threatonkill = 1;
    level.killstreaks["combat_robot"].threatonkill = 1;
    level thread function_d975d303();
}

// Namespace combat_robot
// Params 1, eflags: 0x5 linked
// Checksum 0xed9cce1f, Offset: 0xb68
// Size: 0x2a
function function_8335360e(player) {
    return getclosestpointonnavmesh(player.origin, 48);
}

// Namespace combat_robot
// Params 1, eflags: 0x4
// Checksum 0xb0d63a62, Offset: 0xba0
// Size: 0x6a
function function_dbe9b2f0(player) {
    var_c7db1a1b = anglestoforward(player.angles) * 72 + player.origin;
    return getclosestpointonnavmesh(var_c7db1a1b, 48);
}

// Namespace combat_robot
// Params 0, eflags: 0x5 linked
// Checksum 0x1f8aea73, Offset: 0xc18
// Size: 0x17c
function function_d975d303() {
    var_c55cca1f = 15000;
    while (true) {
        var_d96f8b8b = [];
        foreach (corpse in getcorpsearray()) {
            if (isdefined(corpse.birthtime) && isdefined(corpse.archetype) && corpse.archetype == "robot" && corpse.birthtime + var_c55cca1f < gettime()) {
                var_d96f8b8b[var_d96f8b8b.size] = corpse;
            }
        }
        for (index = 0; index < var_d96f8b8b.size; index++) {
            var_d96f8b8b[index] delete();
        }
        wait(var_c55cca1f / 1000 / 2);
    }
}

// Namespace combat_robot
// Params 2, eflags: 0x1 linked
// Checksum 0x55e894b8, Offset: 0xda0
// Size: 0x21c
function configureteampost(player, ishacked) {
    robot = self;
    robot.propername = "";
    robot.ignoretriggerdamage = 1;
    robot.empshutdowntime = 750;
    robot.minwalkdistance = 60;
    robot.supersprintdistance = -76;
    robot.robotrusherminradius = 64;
    robot.robotrushermaxradius = 120;
    robot.var_e44890d6 = 0;
    robot.chargemeleedistance = 0;
    robot.fovcosine = 0;
    robot.fovcosinebusy = 0;
    robot.maxsightdistsqrd = 2000 * 2000;
    blackboard::setblackboardattribute(robot, "_robot_mode", "combat");
    robot.gib_state = 0 | 8 & 512 - 1;
    robot clientfield::set("gib_state", robot.gib_state);
    function_3ce9bd07(robot, player, ishacked);
    robot ai::set_behavior_attribute("can_become_crawler", 0);
    robot ai::set_behavior_attribute("can_be_meleed", 0);
    robot ai::set_behavior_attribute("can_initiateaivsaimelee", 0);
    robot ai::set_behavior_attribute("supports_super_sprint", 1);
}

// Namespace combat_robot
// Params 3, eflags: 0x5 linked
// Checksum 0xadb4d1ff, Offset: 0xfc8
// Size: 0xfc
function function_3ce9bd07(robot, player, ishacked) {
    if (ishacked) {
        var_ed68e6c9 = 3;
    } else {
        var_ed68e6c9 = 0;
    }
    robot ai::set_behavior_attribute("robot_lights", var_ed68e6c9);
    robot thread function_d4f822d5(player);
    if (!isdefined(robot.objective)) {
        robot.objective = getequipmentheadobjective(getweapon("combat_robot_marker"));
    }
    robot thread function_122e3e3d(robot, player);
    robot thread function_b63444c3(robot);
}

// Namespace combat_robot
// Params 2, eflags: 0x5 linked
// Checksum 0x85d73383, Offset: 0x10d0
// Size: 0xa8
function function_1aab11c1(robot, position) {
    owner = robot.owner;
    var_15f22fd2 = spawn("script_model", (0, 0, 0));
    var_15f22fd2.origin = position;
    var_15f22fd2 entityheadicons::setentityheadicon(owner.pers["team"], owner, undefined, %airdrop_combatrobot);
    return var_15f22fd2;
}

// Namespace combat_robot
// Params 1, eflags: 0x5 linked
// Checksum 0x7f6199e9, Offset: 0x1180
// Size: 0x3c
function function_8ba2a33(robot) {
    if (isdefined(robot.var_15f22fd2)) {
        robot.var_15f22fd2 delete();
    }
}

// Namespace combat_robot
// Params 1, eflags: 0x5 linked
// Checksum 0x3e8a6d29, Offset: 0x11c8
// Size: 0xa8
function function_b63444c3(robot) {
    robot endon(#"death");
    while (true) {
        if (robot.origin[2] + 36 <= getwaterheight(robot.origin)) {
            robot asmsetanimationrate(0.85);
        } else {
            robot asmsetanimationrate(1);
        }
        wait(0.1);
    }
}

// Namespace combat_robot
// Params 1, eflags: 0x5 linked
// Checksum 0x5071ce34, Offset: 0x1278
// Size: 0x20e
function function_fdcdff00(robot) {
    robot endon(#"death");
    robot.var_104d7d6b = 1;
    robot.var_98424714 = 0;
    function_8ba2a33(robot);
    while (robot.var_104d7d6b) {
        var_3d3be3d = 0;
        if (isdefined(robot.enemy) && isalive(robot.enemy)) {
            if (robot lastknowntime(robot.enemy) + 10000 >= gettime()) {
                robot ai::set_behavior_attribute("move_mode", "rusher");
                var_3d3be3d = 1;
            } else {
                robot clearenemy();
            }
        }
        if (!var_3d3be3d && isdefined(robot.owner) && isalive(robot.owner)) {
            lookaheadtime = 1;
            predicitedposition = robot.owner.origin + vectorscale(robot.owner getvelocity(), lookaheadtime);
            robot ai::set_behavior_attribute("escort_position", predicitedposition);
            robot ai::set_behavior_attribute("move_mode", "escort");
        }
        wait(1);
    }
}

// Namespace combat_robot
// Params 2, eflags: 0x4
// Checksum 0x1929a29d, Offset: 0x1490
// Size: 0x64
function function_3620ca05(robot, enemy) {
    robot endon(#"death");
    robot setignoreent(enemy, 1);
    wait(5);
    robot setignoreent(enemy, 0);
}

// Namespace combat_robot
// Params 2, eflags: 0x5 linked
// Checksum 0x3ebd7a05, Offset: 0x1500
// Size: 0x1b6
function function_8dd17cee(robot, position) {
    robot endon(#"death");
    robot.goalradius = 1000;
    robot setgoal(position);
    robot.var_104d7d6b = 0;
    robot.var_98424714 = 1;
    function_8ba2a33(robot);
    robot.var_15f22fd2 = function_1aab11c1(robot, position);
    while (robot.var_98424714) {
        var_3d3be3d = 0;
        if (isdefined(robot.enemy) && isalive(robot.enemy)) {
            if (robot lastknowntime(robot.enemy) + 10000 >= gettime()) {
                robot ai::set_behavior_attribute("move_mode", "rusher");
                var_3d3be3d = 1;
            } else {
                robot clearenemy();
            }
        }
        if (!var_3d3be3d) {
            robot ai::set_behavior_attribute("move_mode", "guard");
        }
        wait(1);
    }
}

// Namespace combat_robot
// Params 2, eflags: 0x1 linked
// Checksum 0x8247011, Offset: 0x16c0
// Size: 0x3ee
function function_122e3e3d(robot, player) {
    robot endon(#"death");
    for (var_62dc55bd = gettime(); true; var_62dc55bd = gettime() + 1000) {
        wait(0.05);
        if (!isdefined(robot.usetrigger)) {
            continue;
        }
        robot.usetrigger waittill(#"trigger");
        if (var_62dc55bd <= gettime() && isalive(player)) {
            if (isdefined(robot.var_98424714) && robot.var_98424714) {
                robot.var_98424714 = 0;
                robot.var_104d7d6b = 1;
                player playsoundtoplayer("uin_mp_combat_bot_escort", player);
                robot thread function_fdcdff00(robot);
                if (isdefined(robot.usetrigger)) {
                    robot.usetrigger sethintstring(%KILLSTREAK_COMBAT_ROBOT_GUARD_HINT);
                }
                if (isdefined(robot.markerfxhandle)) {
                    robot.markerfxhandle delete();
                }
            } else {
                var_f42a3d7e = function_8335360e(player);
                if (isdefined(var_f42a3d7e)) {
                    robot.var_98424714 = 1;
                    robot.var_104d7d6b = 0;
                    player playsoundtoplayer("uin_mp_combat_bot_guard", player);
                    robot thread function_8dd17cee(robot, var_f42a3d7e);
                    if (isdefined(robot.usetrigger)) {
                        robot.usetrigger sethintstring(%KILLSTREAK_COMBAT_ROBOT_ESCORT_HINT);
                    }
                    if (isdefined(robot.markerfxhandle)) {
                        robot.markerfxhandle delete();
                    }
                    params = level.killstreakbundle["combat_robot"];
                    if (isdefined(params.var_68299ed5)) {
                        point = player.origin;
                        if (!isdefined(point)) {
                            point = var_f42a3d7e;
                        }
                        robot.markerfxhandle = spawnfx(params.var_68299ed5, point + (0, 0, 3), (0, 0, 1), (1, 0, 0));
                        robot.markerfxhandle.team = player.team;
                        triggerfx(robot.markerfxhandle);
                        robot.markerfxhandle setinvisibletoall();
                        robot.markerfxhandle setvisibletoplayer(player);
                    }
                } else {
                    player iprintlnbold(%KILLSTREAK_COMBAT_ROBOT_PATROL_FAIL);
                }
            }
            robot notify(#"bhtn_action_notify", "modeSwap");
        }
    }
}

// Namespace combat_robot
// Params 1, eflags: 0x1 linked
// Checksum 0x920d3e7e, Offset: 0x1ab8
// Size: 0x300
function function_337618ce(killstreak) {
    player = self;
    team = self.team;
    if (!self supplydrop::issupplydropgrenadeallowed(killstreak)) {
        return 0;
    }
    killstreak_id = self killstreakrules::killstreakstart(killstreak, team, 0, 0);
    if (killstreak_id == -1) {
        return 0;
    }
    context = spawnstruct();
    context.prolog = &prolog;
    context.epilog = &epilog;
    context.hasflares = 1;
    context.radius = level.killstreakcorebundle.ksairdroprobotradius;
    context.dist_from_boundary = 18;
    context.max_dist_from_location = 4;
    context.perform_physics_trace = 1;
    context.var_c1344433 = 96;
    context.islocationgood = &supplydrop::islocationgood;
    context.objective = %airdrop_combatrobot;
    context.killstreakref = killstreak;
    context.validlocationsound = level.killstreakcorebundle.ksvalidcombatrobotlocationsound;
    context.vehiclename = "combat_robot_dropship";
    context.killstreak_id = killstreak_id;
    context.tracemask = 1 | 4;
    context.dropoffset = (0, -120, 0);
    result = self supplydrop::usesupplydropmarker(killstreak_id, context);
    if (!isdefined(result) || !result) {
        killstreakrules::killstreakstop(killstreak, team, killstreak_id);
        return 0;
    }
    self killstreaks::play_killstreak_start_dialog("combat_robot", self.team, killstreak_id);
    self killstreakrules::displaykillstreakstartteammessagetoall("combat_robot");
    self addweaponstat(getweapon("combat_robot_marker"), "used", 1);
    return result;
}

// Namespace combat_robot
// Params 0, eflags: 0x1 linked
// Checksum 0xc6096bb7, Offset: 0x1dc0
// Size: 0x70
function function_71cf3d3a() {
    robot = self;
    robot endon(#"death");
    robot endon(#"combat_robot_land");
    while (true) {
        robot supplydrop::is_touching_crate();
        robot supplydrop::is_clone_touching_crate();
        wait(0.05);
    }
}

// Namespace combat_robot
// Params 1, eflags: 0x1 linked
// Checksum 0xe61dc09e, Offset: 0x1e38
// Size: 0xe4
function function_682f8d05(context) {
    helicopter = self;
    helicopter waittill(#"death");
    callback::callback(#"hash_acb66515");
    if (isdefined(context.marker)) {
        context.marker delete();
        context.marker = undefined;
        if (isdefined(context.markerfxhandle)) {
            context.markerfxhandle delete();
            context.markerfxhandle = undefined;
        }
        supplydrop::deldroplocation(context.killstreak_id);
    }
}

// Namespace combat_robot
// Params 1, eflags: 0x1 linked
// Checksum 0xe610b521, Offset: 0x1f28
// Size: 0x508
function prolog(context) {
    helicopter = self;
    player = helicopter.owner;
    spawnposition = (0, 0, 0);
    spawnangles = (0, 0, 0);
    combatrobot = spawnactor("spawner_bo3_robot_grunt_assault_mp", spawnposition, spawnangles, "", 1);
    combatrobot.missiletrackdamage = 0;
    combatrobot killstreaks::configure_team("combat_robot", context.killstreak_id, player, "small_vehicle", undefined, &configureteampost);
    combatrobot killstreak_hacking::enable_hacking("combat_robot", undefined, &hackedcallbackpost);
    combatrobot thread function_fdcdff00(combatrobot);
    combatrobot thread function_f298031d(helicopter);
    combatrobot thread function_e4b3aaa0();
    combatrobot thread function_8ce7b744();
    combatrobot thread killstreaks::waitfortimeout("combat_robot", 90000, &function_772b64d7, "combat_robot_shutdown");
    combatrobot thread function_7d3ed5b7();
    helicopter thread function_682f8d05(context);
    helicopter.unloadtimeout = 6;
    killstreak_detect::killstreaktargetset(combatrobot, (0, 0, 50));
    combatrobot.maxhealth = combatrobot.health;
    tablehealth = killstreak_bundles::get_max_health("combat_robot");
    if (isdefined(tablehealth)) {
        combatrobot.maxhealth = tablehealth;
    }
    combatrobot.health = combatrobot.maxhealth;
    combatrobot.treat_owner_damage_as_friendly_fire = 1;
    combatrobot.ignore_team_kills = 1;
    combatrobot.remotemissiledamage = combatrobot.maxhealth + 1;
    combatrobot.rocketdamage = combatrobot.maxhealth / 2 + 1;
    combatrobot thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("death");
    combatrobot clientfield::set("enemyvehicle", 1);
    combatrobot.soundmod = "drone_land";
    aiutility::addaioverridedamagecallback(combatrobot, &function_864f528);
    combatrobot.vehicle = helicopter;
    combatrobot.vehicle.var_58a89d24 = 1;
    combatrobot vehicle::get_in(helicopter, "driver", 1);
    combatrobot.overridedropposition = player.markerposition;
    combatrobot thread function_6ebc9ffb();
    combatrobot thread function_b610d7e7();
    combatrobot thread function_bf49f6cc();
    combatrobot thread function_888d5088();
    foreach (player in level.players) {
        combatrobot function_74f7f285(player);
    }
    callback::on_spawned(&function_74f7f285, combatrobot);
    context.robot = combatrobot;
}

// Namespace combat_robot
// Params 1, eflags: 0x1 linked
// Checksum 0x96cba5c9, Offset: 0x2438
// Size: 0x54
function function_74f7f285(player) {
    combatrobot = self;
    combatrobot setignoreent(player, player hasperk("specialty_nottargetedbyrobot"));
}

// Namespace combat_robot
// Params 1, eflags: 0x1 linked
// Checksum 0x4cc68b08, Offset: 0x2498
// Size: 0xf4
function epilog(context) {
    helicopter = self;
    context.robot thread function_71cf3d3a();
    context.robot.starttime = gettime() + 750;
    thread function_f91732d7(context);
    /#
        function_5ce7891f();
    #/
    helicopter function_99494c4a(0.8, (isdefined(self.unloadtimeout) ? self.unloadtimeout : 0) + 0.1);
    helicopter vehicle::unload("all", undefined, 1, 0.8);
}

/#

    // Namespace combat_robot
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5f2834fb, Offset: 0x2598
    // Size: 0x90
    function function_5ce7891f() {
        var_1171cea0 = getdvarint("KILLSTREAK_COMBAT_ROBOT_EARNED", 0);
        while (var_1171cea0 > 0) {
            iprintlnbold("KILLSTREAK_COMBAT_ROBOT_EARNED" + var_1171cea0);
            wait(1);
            var_1171cea0--;
            if (var_1171cea0 == 0) {
                iprintlnbold("KILLSTREAK_COMBAT_ROBOT_EARNED");
            }
        }
    }

#/

// Namespace combat_robot
// Params 2, eflags: 0x1 linked
// Checksum 0x7437dbeb, Offset: 0x2630
// Size: 0x30
function function_99494c4a(var_f191039f, delete_after_destruction_wait_time) {
    wait(var_f191039f);
    if (isdefined(self)) {
        self.delete_after_destruction_wait_time = delete_after_destruction_wait_time;
    }
}

// Namespace combat_robot
// Params 1, eflags: 0x1 linked
// Checksum 0x32095855, Offset: 0x2668
// Size: 0x4c
function hackedcallbackpost(hacker) {
    robot = self;
    robot clearenemy();
    robot function_dfd80445(hacker);
}

// Namespace combat_robot
// Params 1, eflags: 0x1 linked
// Checksum 0x1beeaef0, Offset: 0x26c0
// Size: 0xa8
function function_f298031d(helicopter) {
    robot = self;
    robot endon(#"death");
    robot endon(#"killstreak_hacked");
    robot endon(#"combat_robot_land");
    helicopter endon(#"death");
    hacker = helicopter waittill(#"killstreak_hacked");
    if (robot flagsys::get("in_vehicle") == 0) {
        return;
    }
    robot [[ robot.killstreak_hackedcallback ]](hacker);
}

// Namespace combat_robot
// Params 1, eflags: 0x1 linked
// Checksum 0xb840d1fb, Offset: 0x2770
// Size: 0x114
function function_f91732d7(context) {
    robot = context.robot;
    while (isdefined(robot) && isdefined(context.marker) && robot flagsys::get("in_vehicle")) {
        wait(1);
    }
    if (isdefined(context.marker)) {
        context.marker delete();
        context.marker = undefined;
        if (isdefined(context.markerfxhandle)) {
            context.markerfxhandle delete();
            context.markerfxhandle = undefined;
        }
        supplydrop::deldroplocation(context.killstreak_id);
    }
}

// Namespace combat_robot
// Params 0, eflags: 0x1 linked
// Checksum 0xd2b6976a, Offset: 0x2890
// Size: 0x1bc
function function_8ce7b744() {
    combatrobot = self;
    combatrobot endon(#"hash_8afbc8b9");
    callback::remove_on_spawned(&function_74f7f285, combatrobot);
    attacker, damagefromunderneath, weapon = combatrobot waittill(#"death");
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (!isdefined(combatrobot.owner) || isdefined(attacker) && isplayer(attacker) && combatrobot.owner util::isenemyplayer(attacker)) {
        attacker challenges::destroyscorestreak(weapon, 0, 1);
        attacker challenges::function_90c432bd(weapon);
        scoreevents::processscoreevent("destroyed_combat_robot", attacker, combatrobot.owner, weapon);
        luinotifyevent(%player_callout, 2, %KILLSTREAK_DESTROYED_COMBAT_ROBOT, attacker.entnum);
    }
    combatrobot killstreaks::play_destroyed_dialog_on_owner("combat_robot", combatrobot.killstreak_id);
    combatrobot notify(#"hash_8afbc8b9");
}

// Namespace combat_robot
// Params 0, eflags: 0x1 linked
// Checksum 0x95d76796, Offset: 0x2a58
// Size: 0x120
function function_6ebc9ffb() {
    robot = self;
    robot endon(#"death");
    robot endon(#"hash_8afbc8b9");
    while (robot flagsys::get("in_vehicle")) {
        wait(1);
    }
    robot notify(#"combat_robot_land");
    robot.ignoretriggerdamage = 0;
    while (isdefined(robot.traversestartnode)) {
        robot waittill(#"traverse_end");
    }
    v_on_navmesh = getclosestpointonnavmesh(robot.origin, 50, 20);
    if (isdefined(v_on_navmesh)) {
        player = robot.owner;
        robot function_dfd80445(player);
        return;
    }
    robot notify(#"hash_8afbc8b9");
}

// Namespace combat_robot
// Params 1, eflags: 0x1 linked
// Checksum 0xe322b6df, Offset: 0x2b80
// Size: 0x1dc
function function_dfd80445(player) {
    robot = self;
    if (isdefined(robot.usetrigger)) {
        robot.usetrigger delete();
    }
    robot.usetrigger = spawn("trigger_radius_use", player.origin, 32, 32);
    robot.usetrigger enablelinkto();
    robot.usetrigger linkto(player);
    robot.usetrigger sethintlowpriority(1);
    robot.usetrigger setcursorhint("HINT_NOICON");
    robot.usetrigger sethintstring(%KILLSTREAK_COMBAT_ROBOT_GUARD_HINT);
    robot.usetrigger setteamfortrigger(player.team);
    robot.usetrigger.team = player.team;
    player clientclaimtrigger(robot.usetrigger);
    player.remotecontroltrigger = robot.usetrigger;
    robot.usetrigger.claimedby = player;
}

// Namespace combat_robot
// Params 1, eflags: 0x1 linked
// Checksum 0x9e4e51e9, Offset: 0x2d68
// Size: 0x84
function function_d4f822d5(player) {
    combatrobot = self;
    combatrobot notify(#"hash_7b2f894b");
    combatrobot endon(#"hash_7b2f894b");
    combatrobot endon(#"hash_8afbc8b9");
    player util::waittill_any("joined_team", "disconnect", "joined_spectators");
    combatrobot notify(#"hash_8afbc8b9");
}

// Namespace combat_robot
// Params 0, eflags: 0x5 linked
// Checksum 0xa055f172, Offset: 0x2df8
// Size: 0x54
function function_369d3494() {
    archetype = self.archetype;
    corpse = self waittill(#"actor_corpse");
    corpse clientfield::set("arch_actor_fire_fx", 3);
}

// Namespace combat_robot
// Params 1, eflags: 0x5 linked
// Checksum 0x376610d0, Offset: 0x2e58
// Size: 0x1ac
function function_39f8e7ed(combatrobot) {
    combatrobot clientfield::set("arch_actor_fire_fx", 1);
    clientfield::set("robot_mind_control_explosion", 1);
    combatrobot thread function_369d3494();
    if (randomint(100) >= 50) {
        gibserverutils::gibleftarm(combatrobot);
    } else {
        gibserverutils::gibrightarm(combatrobot);
    }
    gibserverutils::giblegs(combatrobot);
    gibserverutils::gibhead(combatrobot);
    velocity = combatrobot getvelocity() * 0.125;
    combatrobot startragdoll();
    combatrobot launchragdoll((velocity[0] + randomfloatrange(-20, 20), velocity[1] + randomfloatrange(-20, 20), randomfloatrange(60, 80)), "j_mainroot");
}

// Namespace combat_robot
// Params 0, eflags: 0x1 linked
// Checksum 0xe6dde25b, Offset: 0x3010
// Size: 0x2fc
function function_772b64d7() {
    combatrobot = self;
    combatrobot killstreaks::play_pilot_dialog_on_owner("timeout", "combat_robot");
    combatrobot ai::set_behavior_attribute("shutdown", 1);
    wait(randomfloatrange(3, 4.5));
    function_39f8e7ed(combatrobot);
    params = level.killstreakbundle["combat_robot"];
    if (isdefined(params.ksexplosionfx)) {
        playfxontag(params.ksexplosionfx, combatrobot, "tag_origin");
    }
    target_remove(combatrobot);
    if (!isdefined(params.ksexplosionouterradius)) {
        params.ksexplosionouterradius = -56;
    }
    if (!isdefined(params.ksexplosioninnerradius)) {
        params.ksexplosioninnerradius = 1;
    }
    if (!isdefined(params.ksexplosionouterdamage)) {
        params.ksexplosionouterdamage = 25;
    }
    if (!isdefined(params.ksexplosioninnerdamage)) {
        params.ksexplosioninnerdamage = 350;
    }
    if (!isdefined(params.ksexplosionmagnitude)) {
        params.ksexplosionmagnitude = 1;
    }
    physicsexplosionsphere(combatrobot.origin, params.ksexplosionouterradius, params.ksexplosioninnerradius, params.ksexplosionmagnitude, params.ksexplosionouterdamage, params.ksexplosioninnerdamage);
    if (isdefined(combatrobot.owner)) {
        radiusdamage(combatrobot.origin, params.ksexplosionouterradius, params.ksexplosioninnerdamage, params.ksexplosionouterdamage, combatrobot.owner, "MOD_EXPLOSIVE", getweapon("combat_robot_marker"));
        if (isdefined(params.ksexplosionrumble)) {
            combatrobot.owner playrumbleonentity(params.ksexplosionrumble);
        }
    }
    wait(0.2);
    combatrobot notify(#"hash_8afbc8b9");
}

// Namespace combat_robot
// Params 0, eflags: 0x1 linked
// Checksum 0x981dddb4, Offset: 0x3318
// Size: 0x19c
function function_e4b3aaa0() {
    combatrobot = self;
    var_5bf4a57c = combatrobot.originalteam;
    var_90ede466 = combatrobot.killstreak_id;
    combatrobot waittill(#"hash_8afbc8b9");
    combatrobot playsound("evt_combat_bot_mech_fail_explode");
    if (isdefined(combatrobot.usetrigger)) {
        combatrobot.usetrigger delete();
    }
    if (isdefined(combatrobot.markerfxhandle)) {
        combatrobot.markerfxhandle delete();
    }
    function_8ba2a33(combatrobot);
    killstreakrules::killstreakstop("combat_robot", var_5bf4a57c, var_90ede466);
    if (isdefined(combatrobot)) {
        if (target_istarget(combatrobot)) {
            target_remove(combatrobot);
        }
        if (!level.gameended) {
            if (combatrobot flagsys::get("in_vehicle")) {
                combatrobot unlink();
            }
            combatrobot kill();
        }
    }
}

// Namespace combat_robot
// Params 0, eflags: 0x1 linked
// Checksum 0xaf043e63, Offset: 0x34c0
// Size: 0x100
function function_7d3ed5b7() {
    combatrobot = self;
    combatrobot endon(#"hash_8afbc8b9");
    combatrobot endon(#"death");
    combatrobot playsoundontag("vox_robot_chatter", "j_head");
    while (true) {
        soundalias = undefined;
        notify_string = combatrobot waittill(#"bhtn_action_notify");
        switch (notify_string) {
        case 74:
        case 75:
        case 76:
        case 43:
            soundalias = "vox_robot_chatter";
            break;
        }
        if (isdefined(soundalias)) {
            combatrobot playsoundontag(soundalias, "j_head");
            wait(1.2);
        }
    }
}

// Namespace combat_robot
// Params 0, eflags: 0x1 linked
// Checksum 0x45b5b559, Offset: 0x35c8
// Size: 0x54
function function_b610d7e7() {
    combatrobot = self;
    combatrobot endon(#"hash_8afbc8b9");
    combatrobot endon(#"death");
    combatrobot waittill(#"exiting_vehicle");
    combatrobot playsound("veh_vtol_supply_robot_launch");
}

// Namespace combat_robot
// Params 0, eflags: 0x1 linked
// Checksum 0xaee064b6, Offset: 0x3628
// Size: 0x94
function function_bf49f6cc() {
    combatrobot = self;
    combatrobot endon(#"hash_8afbc8b9");
    combatrobot endon(#"death");
    falltime = combatrobot waittill(#"falling");
    wait_time = falltime - 0.5;
    if (wait_time > 0) {
        wait(wait_time);
    }
    combatrobot playsound("veh_vtol_supply_robot_land");
}

// Namespace combat_robot
// Params 0, eflags: 0x1 linked
// Checksum 0x2d7295b4, Offset: 0x36c8
// Size: 0x64
function function_888d5088() {
    combatrobot = self;
    combatrobot endon(#"hash_8afbc8b9");
    combatrobot endon(#"death");
    combatrobot waittill(#"landing");
    wait(0.1);
    combatrobot playsound("veh_vtol_supply_robot_activate");
}

// Namespace combat_robot
// Params 12, eflags: 0x1 linked
// Checksum 0x5e2702de, Offset: 0x3738
// Size: 0x1a0
function function_864f528(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
    combatrobot = self;
    if (combatrobot flagsys::get("in_vehicle") && smeansofdeath == "MOD_TRIGGER_HURT") {
        idamage = 0;
    } else {
        idamage = killstreaks::ondamageperweapon("combat_robot", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
    }
    combatrobot.missiletrackdamage += idamage;
    if (idamage > 0 && isdefined(eattacker)) {
        if (isplayer(eattacker)) {
            if (isdefined(combatrobot.owner)) {
                challenges::combat_robot_damage(eattacker, combatrobot.owner);
            }
        }
    }
    return idamage;
}

