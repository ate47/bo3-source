#using scripts/codescripts/struct;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreak_detect;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_supplydrop;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_puppeteer_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/entityheadicons_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/weapons/_heatseekingmissile;

#namespace combat_robot;

// Namespace combat_robot
// Params 0, eflags: 0x0
// Checksum 0x193f30c8, Offset: 0x9a8
// Size: 0x152
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
// Params 1, eflags: 0x4
// Checksum 0x7fd8d0be, Offset: 0xb08
// Size: 0x21
function private function_8335360e(player) {
    return getclosestpointonnavmesh(player.origin, 48);
}

// Namespace combat_robot
// Params 1, eflags: 0x4
// Checksum 0x79f56991, Offset: 0xb38
// Size: 0x49
function private function_dbe9b2f0(player) {
    var_c7db1a1b = anglestoforward(player.angles) * 72 + player.origin;
    return getclosestpointonnavmesh(var_c7db1a1b, 48);
}

// Namespace combat_robot
// Params 0, eflags: 0x4
// Checksum 0x46bf66fa, Offset: 0xb90
// Size: 0xff
function private function_d975d303() {
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
        wait var_c55cca1f / 1000 / 2;
    }
}

// Namespace combat_robot
// Params 2, eflags: 0x0
// Checksum 0xd1c7faa6, Offset: 0xc98
// Size: 0xe5
function configureteampost(player, ishacked) {
    robot = self;
    robot.propername = "";
    robot.ignoretriggerdamage = 1;
    robot.empshutdowntime = 1000;
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
    InvalidOpCode(0xb9, !(512 - 1), 8, 0);
    // Unknown operator (0xb9, t7_1b, PC)
}

// Namespace combat_robot
// Params 3, eflags: 0x4
// Checksum 0x8064581b, Offset: 0xe30
// Size: 0xc2
function private function_3ce9bd07(robot, player, ishacked) {
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
// Params 2, eflags: 0x4
// Checksum 0xd116f3dc, Offset: 0xf00
// Size: 0xa4
function private function_1aab11c1(robot, position) {
    var_15f22fd2 = newclienthudelem(robot.owner);
    var_15f22fd2.x = position[0];
    var_15f22fd2.y = position[1];
    var_15f22fd2.z = position[2] + 15;
    var_15f22fd2.alpha = 0.8;
    var_15f22fd2 setshader("t7_hud_ks_c54i_drop", 12, 12);
    var_15f22fd2 setwaypoint(1);
    return var_15f22fd2;
}

// Namespace combat_robot
// Params 1, eflags: 0x4
// Checksum 0x40a71d36, Offset: 0xfb0
// Size: 0x32
function private function_8ba2a33(robot) {
    if (isdefined(robot.var_15f22fd2)) {
        robot.var_15f22fd2 destroy();
    }
}

// Namespace combat_robot
// Params 1, eflags: 0x4
// Checksum 0xa4bbd6bc, Offset: 0xff0
// Size: 0x85
function private function_b63444c3(robot) {
    robot endon(#"death");
    while (true) {
        if (robot.origin[2] + 36 <= getwaterheight(robot.origin)) {
            robot asmsetanimationrate(0.85);
        } else {
            robot asmsetanimationrate(1);
        }
        wait 0.1;
    }
}

// Namespace combat_robot
// Params 1, eflags: 0x4
// Checksum 0xecead086, Offset: 0x1080
// Size: 0x1a1
function private function_fdcdff00(robot) {
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
        wait 1;
    }
}

// Namespace combat_robot
// Params 2, eflags: 0x4
// Checksum 0x960e6001, Offset: 0x1230
// Size: 0x52
function private function_3620ca05(robot, enemy) {
    robot endon(#"death");
    robot setignoreent(enemy, 1);
    wait 5;
    robot setignoreent(enemy, 0);
}

// Namespace combat_robot
// Params 2, eflags: 0x4
// Checksum 0x846ba0eb, Offset: 0x1290
// Size: 0x141
function private function_8dd17cee(robot, position) {
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
        wait 1;
    }
}

// Namespace combat_robot
// Params 2, eflags: 0x0
// Checksum 0xaf4372a2, Offset: 0x13e0
// Size: 0x309
function function_122e3e3d(robot, player) {
    robot endon(#"death");
    for (var_62dc55bd = gettime(); true; var_62dc55bd = gettime() + 1000) {
        wait 0.05;
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
// Params 1, eflags: 0x0
// Checksum 0x177a64e6, Offset: 0x16f8
// Size: 0x176
function function_337618ce(killstreak) {
    player = self;
    team = self.team;
    if (!self supplydrop::issupplydropgrenadeallowed(killstreak)) {
        return false;
    }
    killstreak_id = self killstreakrules::killstreakstart(killstreak, team, 0, 0);
    if (killstreak_id == -1) {
        return false;
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
    InvalidOpCode(0xb9, 4, 1);
    // Unknown operator (0xb9, t7_1b, PC)
}

// Namespace combat_robot
// Params 0, eflags: 0x0
// Checksum 0xa284dcf0, Offset: 0x1910
// Size: 0x55
function function_71cf3d3a() {
    robot = self;
    robot endon(#"death");
    robot endon(#"combat_robot_land");
    while (true) {
        robot supplydrop::is_touching_crate();
        robot supplydrop::is_clone_touching_crate();
        wait 0.05;
    }
}

// Namespace combat_robot
// Params 1, eflags: 0x0
// Checksum 0x93f0aade, Offset: 0x1970
// Size: 0xba
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
// Params 1, eflags: 0x0
// Checksum 0x184c568a, Offset: 0x1a38
// Size: 0x356
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
    combatrobot thread killstreaks::waitfortimeout("combat_robot", 60000, &function_772b64d7, "combat_robot_shutdown");
    combatrobot thread function_7d3ed5b7();
    helicopter thread function_682f8d05(context);
    killstreak_detect::killstreaktargetset(combatrobot, (0, 0, 50));
    combatrobot.maxhealth = combatrobot.health;
    tablehealth = killstreak_bundles::get_max_health("combat_robot");
    if (isdefined(tablehealth)) {
        combatrobot.maxhealth = tablehealth;
    }
    combatrobot.health = combatrobot.maxhealth;
    combatrobot.remotemissiledamage = combatrobot.maxhealth + 1;
    combatrobot.rocketdamage = combatrobot.maxhealth / 2 + 1;
    combatrobot thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("death");
    combatrobot clientfield::set("enemyvehicle", 1);
    combatrobot.soundmod = "drone_land";
    aiutility::addaioverridedamagecallback(combatrobot, &function_864f528);
    combatrobot vehicle::get_in(helicopter, "driver", 1);
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
// Params 1, eflags: 0x0
// Checksum 0xc1a00849, Offset: 0x1d98
// Size: 0x3a
function function_74f7f285(player) {
    combatrobot = self;
    combatrobot setignoreent(player, player hasperk("specialty_nottargetedbyrobot"));
}

// Namespace combat_robot
// Params 1, eflags: 0x0
// Checksum 0x10a382fa, Offset: 0x1de0
// Size: 0x5a
function epilog(context) {
    helicopter = self;
    context.robot thread function_71cf3d3a();
    thread function_f91732d7(context);
    helicopter vehicle::unload("all");
}

// Namespace combat_robot
// Params 1, eflags: 0x0
// Checksum 0x7ab0aafd, Offset: 0x1e48
// Size: 0x3a
function hackedcallbackpost(hacker) {
    robot = self;
    robot clearenemy();
    robot function_dfd80445(hacker);
}

// Namespace combat_robot
// Params 1, eflags: 0x0
// Checksum 0x51d1e564, Offset: 0x1e90
// Size: 0x78
function function_f298031d(helicopter) {
    robot = self;
    robot endon(#"death");
    robot endon(#"killstreak_hacked");
    robot endon(#"combat_robot_land");
    helicopter endon(#"death");
    helicopter waittill(#"killstreak_hacked", hacker);
    if (robot flagsys::get("in_vehicle") == 0) {
        return;
    }
    robot [[ robot.killstreak_hackedcallback ]](hacker);
}

// Namespace combat_robot
// Params 1, eflags: 0x0
// Checksum 0xfad982d1, Offset: 0x1f10
// Size: 0xd2
function function_f91732d7(context) {
    robot = context.robot;
    while (isdefined(robot) && isdefined(context.marker) && robot flagsys::get("in_vehicle")) {
        wait 1;
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
// Params 0, eflags: 0x0
// Checksum 0x51ae3ebe, Offset: 0x1ff0
// Size: 0xfc
function function_8ce7b744() {
    combatrobot = self;
    combatrobot endon(#"combat_robot_shutdown");
    callback::remove_on_spawned(&function_74f7f285, combatrobot);
    combatrobot waittill(#"death", attacker, type, weapon);
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (isplayer(attacker)) {
        scoreevents::processscoreevent("destroyed_combat_robot", attacker, combatrobot.owner, weapon);
        luinotifyevent(%player_callout, 2, %KILLSTREAK_DESTROYED_COMBAT_ROBOT, attacker.entnum);
    }
    combatrobot killstreaks::play_destroyed_dialog_on_owner("combat_robot", combatrobot.killstreak_id);
    combatrobot notify(#"combat_robot_shutdown");
}

// Namespace combat_robot
// Params 0, eflags: 0x0
// Checksum 0x36f255ef, Offset: 0x20f8
// Size: 0xb8
function function_6ebc9ffb() {
    robot = self;
    robot endon(#"death");
    robot endon(#"combat_robot_shutdown");
    while (robot flagsys::get("in_vehicle")) {
        wait 1;
    }
    robot notify(#"combat_robot_land");
    robot.ignoretriggerdamage = 0;
    v_on_navmesh = getclosestpointonnavmesh(robot.origin, 50, 20);
    if (isdefined(v_on_navmesh)) {
        player = robot.owner;
        robot function_dfd80445(player);
        return;
    }
    robot notify(#"combat_robot_shutdown");
}

// Namespace combat_robot
// Params 1, eflags: 0x0
// Checksum 0x9cdb1198, Offset: 0x21b8
// Size: 0x18a
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
    if (level.teambased) {
        robot.usetrigger setteamfortrigger(player.team);
        robot.usetrigger.team = player.team;
    }
    player clientclaimtrigger(robot.usetrigger);
    player.remotecontroltrigger = robot.usetrigger;
    robot.usetrigger.claimedby = player;
}

// Namespace combat_robot
// Params 1, eflags: 0x0
// Checksum 0x3aaada0e, Offset: 0x2350
// Size: 0x64
function function_d4f822d5(player) {
    combatrobot = self;
    combatrobot notify(#"hash_7b2f894b");
    combatrobot endon(#"hash_7b2f894b");
    combatrobot endon(#"combat_robot_shutdown");
    player util::waittill_any("joined_team", "disconnect", "joined_spectators");
    combatrobot notify(#"combat_robot_shutdown");
}

// Namespace combat_robot
// Params 0, eflags: 0x4
// Checksum 0x4b112680, Offset: 0x23c0
// Size: 0x42
function private function_369d3494() {
    archetype = self.archetype;
    self waittill(#"actor_corpse", corpse);
    corpse clientfield::set("arch_actor_fire_fx", 3);
}

// Namespace combat_robot
// Params 1, eflags: 0x4
// Checksum 0xe670bfea, Offset: 0x2410
// Size: 0x13a
function private function_39f8e7ed(combatrobot) {
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
// Params 0, eflags: 0x0
// Checksum 0xc5b80c9, Offset: 0x2558
// Size: 0x244
function function_772b64d7() {
    combatrobot = self;
    combatrobot killstreaks::play_pilot_dialog_on_owner("timeout", "combat_robot");
    combatrobot ai::set_behavior_attribute("shutdown", 1);
    wait randomfloatrange(3, 4.5);
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
    wait 0.2;
    combatrobot notify(#"combat_robot_shutdown");
}

// Namespace combat_robot
// Params 0, eflags: 0x0
// Checksum 0xd6cefc95, Offset: 0x27a8
// Size: 0x14a
function function_e4b3aaa0() {
    combatrobot = self;
    var_5bf4a57c = combatrobot.originalteam;
    var_90ede466 = combatrobot.killstreak_id;
    combatrobot waittill(#"combat_robot_shutdown");
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
// Params 0, eflags: 0x0
// Checksum 0x781cd101, Offset: 0x2900
// Size: 0xcd
function function_7d3ed5b7() {
    combatrobot = self;
    combatrobot endon(#"combat_robot_shutdown");
    combatrobot endon(#"death");
    combatrobot playsoundontag("vox_robot_chatter", "j_head");
    while (true) {
        soundalias = undefined;
        combatrobot waittill(#"bhtn_action_notify", notify_string);
        switch (notify_string) {
        case "attack_kill":
        case "attack_melee":
        case "charge":
        case "modeSwap":
            soundalias = "vox_robot_chatter";
            break;
        }
        if (isdefined(soundalias)) {
            combatrobot playsoundontag(soundalias, "j_head");
            wait 1.2;
        }
    }
}

// Namespace combat_robot
// Params 0, eflags: 0x0
// Checksum 0x5732adc, Offset: 0x29d8
// Size: 0x42
function function_b610d7e7() {
    combatrobot = self;
    combatrobot endon(#"combat_robot_shutdown");
    combatrobot endon(#"death");
    combatrobot waittill(#"exiting_vehicle");
    combatrobot playsound("veh_vtol_supply_robot_launch");
}

// Namespace combat_robot
// Params 0, eflags: 0x0
// Checksum 0x19583d2e, Offset: 0x2a28
// Size: 0x6a
function function_bf49f6cc() {
    combatrobot = self;
    combatrobot endon(#"combat_robot_shutdown");
    combatrobot endon(#"death");
    combatrobot waittill(#"falling", falltime);
    wait_time = falltime - 0.5;
    if (wait_time > 0) {
        wait wait_time;
    }
    combatrobot playsound("veh_vtol_supply_robot_land");
}

// Namespace combat_robot
// Params 0, eflags: 0x0
// Checksum 0x8c5a35d5, Offset: 0x2aa0
// Size: 0x4a
function function_888d5088() {
    combatrobot = self;
    combatrobot endon(#"combat_robot_shutdown");
    combatrobot endon(#"death");
    combatrobot waittill(#"landing");
    wait 0.1;
    combatrobot playsound("veh_vtol_supply_robot_activate");
}

// Namespace combat_robot
// Params 12, eflags: 0x0
// Checksum 0xbd750cb, Offset: 0x2af8
// Size: 0xf4
function function_864f528(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
    combatrobot = self;
    if (combatrobot flagsys::get("in_vehicle") && smeansofdeath == "MOD_TRIGGER_HURT") {
        idamage = 0;
    } else {
        idamage = killstreaks::ondamageperweapon("combat_robot", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
    }
    combatrobot.missiletrackdamage += idamage;
    return idamage;
}

