#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/ctf;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/teams/_teams;
#using scripts/shared/ai/archetype_robot;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_heatseekingmissile;

#namespace escort;

// Namespace escort
// Params 0, eflags: 0x2
// Checksum 0x4d084b27, Offset: 0xdc8
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("escort", &__init__, undefined, undefined);
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x62b440dd, Offset: 0xe00
// Size: 0x4a
function __init__() {
    clientfield::register("actor", "robot_state", 1, 2, "int");
    callback::on_spawned(&on_player_spawned);
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x90e5f30, Offset: 0xe58
// Size: 0x47a
function main() {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerroundscorelimit(0, 2000);
    util::registerscorelimit(0, 5000);
    util::registerroundlimit(0, 12);
    util::registerroundswitch(0, 9);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    level.boottime = getgametypesetting("bootTime");
    level.reboottime = getgametypesetting("rebootTime");
    level.rebootplayers = getgametypesetting("rebootPlayers");
    level.moveplayers = getgametypesetting("movePlayers");
    level.robotshield = getgametypesetting("robotShield");
    switch (getgametypesetting("shutdownDamage")) {
    case 1:
        level.escortrobotkillstreakbundle = "escort_robot_low";
        break;
    case 2:
        level.escortrobotkillstreakbundle = "escort_robot";
        break;
    case 3:
        level.escortrobotkillstreakbundle = "escort_robot_high";
    case 0:
    default:
        level.shutdowndamage = 0;
        break;
    }
    if (isdefined(level.escortrobotkillstreakbundle)) {
        killstreak_bundles::register_killstreak_bundle(level.escortrobotkillstreakbundle);
        level.shutdowndamage = killstreak_bundles::get_max_health(level.escortrobotkillstreakbundle);
    }
    switch (getgametypesetting("robotSpeed")) {
    case 1:
        level.robotspeed = "run";
        break;
    case 2:
        level.robotspeed = "sprint";
        break;
    case 0:
    default:
        level.robotspeed = "walk";
        break;
    }
    globallogic_audio::set_leader_gametype_dialog("startSafeguard", "hcStartSafeguard", "sfgStartAttack", "sfgStartDefend");
    if (!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen()) {
        globallogic::setvisiblescoreboardcolumns("score", "kills", "escorts", "disables", "deaths");
    } else {
        globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "escorts", "disables");
    }
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.scoreroundwinbased = 1;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    level.ontimelimit = &ontimelimit;
    level.onroundswitch = &onroundswitch;
    level.onendgame = &onendgame;
    level.shouldplayovertimeround = &shouldplayovertimeround;
    level.onroundendgame = &onroundendgame;
    gameobjects::register_allowed_gameobject(level.gametype);
    killstreak_bundles::register_killstreak_bundle("escort_robot");
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x12e0
// Size: 0x2
function onprecachegametype() {
    
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x1cc26a43, Offset: 0x12f0
// Size: 0x31
function onstartgametype() {
    level.usestartspawns = 1;
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace escort
// Params 1, eflags: 0x0
// Checksum 0x6fe8378b, Offset: 0x1730
// Size: 0x1a
function onspawnplayer(predictedspawn) {
    spawning::onspawnplayer(predictedspawn);
}

// Namespace escort
// Params 9, eflags: 0x0
// Checksum 0x31d9462, Offset: 0x1758
// Size: 0x91
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (!isdefined(attacker) || attacker == self || !isplayer(attacker) || attacker.team == self.team) {
        return;
    }
    InvalidOpCode(0x54, "defenders", self.team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x32445721, Offset: 0x18a8
// Size: 0x11
function ontimelimit() {
    InvalidOpCode(0x54, "defenders");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x41d2354d, Offset: 0x1900
// Size: 0x11
function function_944eb829() {
    InvalidOpCode(0x54, "defenders");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0xf3f74c6b, Offset: 0x1948
// Size: 0x19
function function_ba513292() {
    InvalidOpCode(0x54, "defenders");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x89fea2db, Offset: 0x19d0
// Size: 0x9
function onroundswitch() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace escort
// Params 1, eflags: 0x0
// Checksum 0xcafb5c38, Offset: 0x19f0
// Size: 0x11
function onendgame(winningteam) {
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x6ce3b413, Offset: 0x1a88
// Size: 0x19
function shouldplayovertimeround() {
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace escort
// Params 1, eflags: 0x0
// Checksum 0x9c0ae74d, Offset: 0x1b20
// Size: 0x11
function onroundendgame(winningteam) {
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x5e1420fc, Offset: 0x1b58
// Size: 0x9
function on_player_spawned() {
    self.escortingrobot = undefined;
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x17e7b240, Offset: 0x1b70
// Size: 0xd9
function function_f76782b5() {
    globallogic::waitforplayers();
    movetrigger = getent("escort_robot_move_trig", "targetname");
    patharray = get_robot_path_array();
    startdir = patharray[0] - movetrigger.origin;
    startangles = vectortoangles(startdir);
    /#
        calc_robot_path_length(movetrigger.origin, patharray);
    #/
    level.robot = spawn_robot(movetrigger.origin, (0, startangles[1], 0));
    InvalidOpCode(0x54, "attackers");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x75e9e0e8, Offset: 0x1ef0
// Size: 0x4d
function wait_robot_moving() {
    level endon(#"game_ended");
    while (true) {
        self waittill(#"robot_moving");
        self clientfield::set("robot_state", 1);
        level.moveobject gameobjects::set_flags(1);
    }
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x180c11bc, Offset: 0x1f48
// Size: 0x55
function wait_robot_stopped() {
    level endon(#"game_ended");
    while (true) {
        self waittill(#"robot_stopped");
        if (self.active) {
            self clientfield::set("robot_state", 0);
            level.moveobject gameobjects::set_flags(0);
        }
    }
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x230e809a, Offset: 0x1fa8
// Size: 0x14d
function wait_robot_shutdown() {
    level endon(#"game_ended");
    while (true) {
        self waittill(#"robot_shutdown");
        level.moveobject gameobjects::allow_use("none");
        objective_setprogress(level.moveobject.objectiveid, -0.05);
        self clientfield::set("robot_state", 2);
        level.moveobject gameobjects::set_flags(2);
        otherteam = util::getotherteam(self.team);
        globallogic_audio::leader_dialog("sfgRobotDisabledAttacker", self.team, undefined, "robot");
        globallogic_audio::leader_dialog("sfgRobotDisabledDefender", otherteam, undefined, "robot");
        globallogic_audio::play_2d_on_team("mpl_safeguard_disabled_sting_friend", self.team);
        globallogic_audio::play_2d_on_team("mpl_safeguard_disabled_sting_enemy", otherteam);
        self thread auto_reboot_robot(level.reboottime);
    }
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x6d6e0af0, Offset: 0x2100
// Size: 0x175
function wait_robot_reboot() {
    level endon(#"game_ended");
    while (true) {
        self waittill(#"robot_reboot");
        level.moveobject gameobjects::allow_use("friendly");
        otherteam = util::getotherteam(self.team);
        globallogic_audio::leader_dialog("sfgRobotRebootedAttacker", self.team, undefined, "robot");
        globallogic_audio::leader_dialog("sfgRobotRebootedDefender", otherteam, undefined, "robot");
        globallogic_audio::play_2d_on_team("mpl_safeguard_reboot_sting_friend", self.team);
        globallogic_audio::play_2d_on_team("mpl_safeguard_reboot_sting_enemy", otherteam);
        objective_setprogress(level.moveobject.objectiveid, 1);
        if (level.moveplayers == 0) {
            self move_robot();
            continue;
        }
        if (level.moveobject.numtouching[level.moveobject.ownerteam] == 0) {
            self clientfield::set("robot_state", 0);
            level.moveobject gameobjects::set_flags(0);
        }
    }
}

// Namespace escort
// Params 1, eflags: 0x0
// Checksum 0xaac9d5a9, Offset: 0x2280
// Size: 0x1b2
function auto_reboot_robot(time) {
    self endon(#"robot_reboot");
    self endon(#"game_ended");
    shutdowntime = 0;
    while (shutdowntime < time) {
        rate = 0;
        friendlycount = level.moveobject.numtouching[level.moveobject.ownerteam];
        if (!level.rebootplayers) {
            rate = 0.05;
        } else if (friendlycount > 0) {
            rate = 0.05;
            if (friendlycount > 1) {
                bonusrate = (friendlycount - 1) * 0.05 * 0;
                rate += bonusrate;
            }
        }
        if (rate > 0) {
            shutdowntime += rate;
            percent = min(1, shutdowntime / time);
            objective_setprogress(level.moveobject.objectiveid, percent);
        }
        wait 0.05;
    }
    if (level.rebootplayers > 0) {
        InvalidOpCode(0x54, "attackers");
        // Unknown operator (0x54, t7_1b, PC)
    }
    self thread reboot_robot();
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0xc92abee5, Offset: 0x2440
// Size: 0x111
function watch_robot_damaged() {
    level endon(#"game_ended");
    while (true) {
        self waittill(#"robot_damaged");
        percent = min(1, self.shutdowndamage / level.shutdowndamage);
        objective_setprogress(level.moveobject.objectiveid, 1 - percent);
        health = level.shutdowndamage - self.shutdowndamage;
        lowhealth = killstreak_bundles::get_low_health(level.escortrobotkillstreakbundle);
        if (!(isdefined(self.playeddamage) && self.playeddamage) && health <= lowhealth) {
            globallogic_audio::leader_dialog("sfgRobotUnderFire", self.team, undefined, "robot");
            self.playeddamage = 1;
            continue;
        }
        if (health > lowhealth) {
            self.playeddamage = 0;
        }
    }
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x35e0abf8, Offset: 0x2560
// Size: 0x22
function delete_on_endgame_sequence() {
    self endon(#"death");
    level waittill(#"hash_6c5f97fe");
    self delete();
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x7270cae6, Offset: 0x2590
// Size: 0xd1
function get_robot_path_array() {
    if (isdefined(level.escortrobotpath)) {
        println("<dev string:x28>");
        return level.escortrobotpath;
    }
    println("<dev string:x4b>");
    patharray = [];
    currnode = getnode("escort_robot_path_start", "targetname");
    patharray[patharray.size] = currnode.origin;
    while (isdefined(currnode.target)) {
        currnode = getnode(currnode.target, "targetname");
        patharray[patharray.size] = currnode.origin;
    }
    return patharray;
}

/#

    // Namespace escort
    // Params 2, eflags: 0x0
    // Checksum 0x112a2424, Offset: 0x2670
    // Size: 0x82
    function calc_robot_path_length(robotorigin, patharray) {
        distance = 0;
        lastpoint = robotorigin;
        for (i = 0; i < patharray.size; i++) {
            distance += distance(lastpoint, patharray[i]);
            lastpoint = patharray[i];
        }
        println("<dev string:x5f>" + distance);
    }

#/

// Namespace escort
// Params 2, eflags: 0x0
// Checksum 0xe3df7f48, Offset: 0x2700
// Size: 0x314
function spawn_robot(position, angles) {
    robot = spawnactor("spawner_bo3_robot_grunt_assault_mp_escort", position, angles, "", 1);
    robot ai::set_behavior_attribute("rogue_allow_pregib", 0);
    robot ai::set_behavior_attribute("rogue_allow_predestruct", 0);
    robot ai::set_behavior_attribute("rogue_control", "forced_level_2");
    robot ai::set_behavior_attribute("rogue_control_speed", level.robotspeed);
    robot ai::set_ignoreall(1);
    robot.allowdeath = 0;
    robot ai::set_behavior_attribute("can_become_crawler", 0);
    robot ai::set_behavior_attribute("can_be_meleed", 0);
    robot ai::set_behavior_attribute("can_initiateaivsaimelee", 0);
    robot ai::set_behavior_attribute("traversals", "procedural");
    aiutility::clearaioverridedamagecallbacks(robot);
    robot.active = 1;
    robot.moving = 0;
    robot.shutdowndamage = 0;
    robot.propername = "";
    robot.ignoretriggerdamage = 1;
    robot clientfield::set("robot_mind_control", 0);
    robot ai::set_behavior_attribute("robot_lights", 3);
    robot.pushable = 0;
    robot function_1762804b(1);
    robot pushplayer(1);
    robot setavoidancemask("avoid none");
    robot disableaimassist();
    robot setsteeringmode("slow steering");
    blackboard::setblackboardattribute(robot, "_robot_locomotion_type", "alt1");
    if (level.robotshield) {
        aiutility::attachriotshield(robot, getweapon("riotshield"), "wpn_t7_shield_riot_world_lh", "tag_stowed_back");
    }
    robot asmsetanimationrate(1.1);
    if (isdefined(level.shutdowndamage) && level.shutdowndamage) {
        target_set(robot, (0, 0, 50));
    }
    robot.overrideactordamage = &robot_damage;
    robot thread robot_move_chatter();
    robot.missiletargetmissdistance = 64;
    robot thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile();
    return robot;
}

// Namespace escort
// Params 12, eflags: 0x0
// Checksum 0xd87b4741, Offset: 0x2a20
// Size: 0x344
function robot_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
    InvalidOpCode(0x54, "attackers", eattacker.team);
    // Unknown operator (0x54, t7_1b, PC)
LOC_000000c3:
    if (level.shutdowndamage <= 0 || !self.active || level.shutdowndamage <= 0 || !self.active) {
        return false;
    }
    level.usestartspawns = 0;
    weapon_damage = killstreak_bundles::get_weapon_damage(level.escortrobotkillstreakbundle, level.shutdowndamage, eattacker, weapon, smeansofdeath, idamage, idflags, undefined);
    if (!isdefined(weapon_damage)) {
        weapon_damage = idamage;
    }
    if (!weapon_damage) {
        return false;
    }
    self.shutdowndamage = self.shutdowndamage + weapon_damage;
    self notify(#"robot_damaged");
    if (!isdefined(eattacker.damagerobot)) {
        eattacker.damagerobot = 0;
    }
    eattacker.damagerobot += weapon_damage;
    if (self.shutdowndamage >= level.shutdowndamage) {
        origin = (0, 0, 0);
        if (isplayer(eattacker)) {
            level thread popups::displayteammessagetoall(%MP_ESCORT_ROBOT_DISABLED, eattacker);
            scoreevents::processscoreevent("escort_robot_disable", eattacker);
            if (isdefined(eattacker.pers["disables"])) {
                eattacker.pers["disables"]++;
                eattacker.disables = eattacker.pers["disables"];
            }
            eattacker addplayerstatwithgametype("DISABLES", 1);
            eattacker recordgameevent("return");
            origin = eattacker.origin;
        }
        foreach (player in level.players) {
            if (player == eattacker || player.team == self.team || !isdefined(player.damagerobot)) {
                continue;
            }
            damagepercent = player.damagerobot / level.shutdowndamage;
            if (damagepercent >= 0.5) {
                scoreevents::processscoreevent("escort_robot_disable_assist_50", player);
            } else if (damagepercent >= 0.25) {
                scoreevents::processscoreevent("escort_robot_disable_assist_25", player);
            }
            player.damagerobot = undefined;
        }
        InvalidOpCode(0x54, "defenders", origin);
        // Unknown operator (0x54, t7_1b, PC)
    }
    self.health = self.health + 1;
    return true;
}

// Namespace escort
// Params 12, eflags: 0x0
// Checksum 0x5d4f77ce, Offset: 0x2d70
// Size: 0x63
function robot_damage_none(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
    return false;
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0xcc9b92a2, Offset: 0x2de0
// Size: 0xf2
function shutdown_robot() {
    self.active = 0;
    self ai::set_ignoreme(1);
    self stop_robot();
    self notify(#"robot_shutdown");
    if (target_istarget(self)) {
        target_remove(self);
    }
    if (isdefined(self.riotshield)) {
        self asmchangeanimmappingtable(1);
        self detach(self.riotshield.model, self.riotshield.tag);
        aiutility::attachriotshield(self, getweapon("riotshield"), "wpn_t7_shield_riot_world_lh", "tag_weapon_left");
    }
    self ai::set_behavior_attribute("shutdown", 1);
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x6f5ee1f0, Offset: 0x2ee0
// Size: 0xfa
function reboot_robot() {
    self.active = 1;
    self.shutdowndamage = 0;
    self ai::set_ignoreme(0);
    self notify(#"robot_reboot");
    if (isdefined(level.shutdowndamage) && level.shutdowndamage) {
        target_set(self, (0, 0, 50));
    }
    if (isdefined(self.riotshield)) {
        self asmchangeanimmappingtable(0);
        self detach(self.riotshield.model, self.riotshield.tag);
        aiutility::attachriotshield(self, getweapon("riotshield"), "wpn_t7_shield_riot_world_lh", "tag_stowed_back");
    }
    self ai::set_behavior_attribute("shutdown", 0);
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x357d49c6, Offset: 0x2fe8
// Size: 0x72
function move_robot() {
    if (self.active == 0 || self.moving || !isdefined(self.pathindex)) {
        return;
    }
    self notify(#"robot_moving");
    self.moving = 1;
    self setgoal(self.patharray[self.pathindex], 0, 30);
    self thread robot_wait_next_point();
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0xe8d6a4d1, Offset: 0x3068
// Size: 0x33
function stop_robot() {
    if (!self.moving) {
        return;
    }
    self.moving = 0;
    self setgoal(self.origin, 0);
    self notify(#"robot_stopped");
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x64b41cc4, Offset: 0x30a8
// Size: 0x45
function update_stop_position() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        self waittill(#"traverse_end");
        if (!self.moving) {
            self setgoal(self.origin, 1);
        }
    }
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0xfddcd46, Offset: 0x30f8
// Size: 0xed
function robot_wait_next_point() {
    self endon(#"robot_stopped");
    level endon(#"game_ended");
    while (true) {
        self waittill(#"goal");
        self.pathindex++;
        if (self.pathindex >= self.patharray.size) {
            self.pathindex = undefined;
            self stop_robot();
            return;
        }
        if (self.pathindex + 1 >= self.patharray.size) {
            otherteam = util::getotherteam(self.team);
            globallogic_audio::leader_dialog("sfgRobotCloseAttacker", self.team, undefined, "robot");
            globallogic_audio::leader_dialog("sfgRobotCloseDefender", otherteam, undefined, "robot");
        }
        self setgoal(self.patharray[self.pathindex], 0, 30);
    }
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0x6b3ae60a, Offset: 0x31f0
// Size: 0x1c2
function explode_robot() {
    self clientfield::set("arch_actor_fire_fx", 1);
    clientfield::set("robot_mind_control_explosion", 1);
    self thread wait_robot_corpse();
    if (randomint(100) >= 50) {
        gibserverutils::gibleftarm(self);
    } else {
        gibserverutils::gibrightarm(self);
    }
    gibserverutils::giblegs(self);
    gibserverutils::gibhead(self);
    velocity = self getvelocity() * 0.125;
    self startragdoll();
    self launchragdoll((velocity[0] + randomfloatrange(-20, 20), velocity[1] + randomfloatrange(-20, 20), randomfloatrange(60, 80)), "j_mainroot");
    playfxontag("weapon/fx_c4_exp_metal", self, "tag_origin");
    if (target_istarget(self)) {
        target_remove(self);
    }
    physicsexplosionsphere(self.origin, -56, 1, 1, 1, 1);
    radiusdamage(self.origin, -56, 1, 1, undefined, "MOD_EXPLOSIVE");
    playrumbleonposition("grenade_rumble", self.origin);
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0xe9f3efb8, Offset: 0x33c0
// Size: 0x42
function wait_robot_corpse() {
    archetype = self.archetype;
    self waittill(#"actor_corpse", corpse);
    corpse clientfield::set("arch_actor_fire_fx", 3);
}

// Namespace escort
// Params 0, eflags: 0x0
// Checksum 0xe127c33a, Offset: 0x3410
// Size: 0x5d
function robot_move_chatter() {
    level endon(#"game_ended");
    while (true) {
        if (self.moving) {
            self playsoundontag("vox_robot_chatter", "J_Head");
        }
        wait randomfloatrange(1.5, 2.5);
    }
}

// Namespace escort
// Params 2, eflags: 0x0
// Checksum 0xd999dddc, Offset: 0x3478
// Size: 0x51
function setup_move_object(robot, triggername) {
    trigger = getent(triggername, "targetname");
    InvalidOpCode(0x54, "attackers", trigger, [], (0, 0, 0), %escort_robot);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace escort
// Params 1, eflags: 0x0
// Checksum 0x55254d78, Offset: 0x3598
// Size: 0x9a
function on_use_robot_move(player) {
    level.usestartspawns = 0;
    if (!(isdefined(player.escortingrobot) && player.escortingrobot)) {
        self thread track_escort_time(player);
    }
    if (self.robot.moving || !self.robot.active || self.numtouching[self.ownerteam] < level.moveplayers) {
        return;
    }
    self.robot move_robot();
}

// Namespace escort
// Params 3, eflags: 0x0
// Checksum 0x29f9d90f, Offset: 0x3640
// Size: 0x5a
function on_update_use_rate_robot_move(team, progress, change) {
    numowners = self.numtouching[self.ownerteam];
    if (numowners < level.moveplayers) {
        self.robot stop_robot();
    }
}

// Namespace escort
// Params 1, eflags: 0x0
// Checksum 0x5d2739b7, Offset: 0x36a8
// Size: 0x167
function track_escort_time(player) {
    player endon(#"death");
    level endon(#"game_ended");
    player.escortingrobot = 1;
    consecutiveescorts = 0;
    while (true) {
        wait 1;
        if (!self.robot.active) {
            continue;
        }
        touching = 0;
        foreach (struct in self.touchlist[self.team]) {
            if (struct.player == player) {
                touching = 1;
                break;
            }
        }
        if (touching) {
            if (isdefined(player.pers["escorts"])) {
                player.pers["escorts"]++;
                player.escorts = player.pers["escorts"];
                consecutiveescorts++;
                if (consecutiveescorts % 3 == 0) {
                    scoreevents::processscoreevent("escort_robot_escort", player);
                }
            }
            player addplayerstatwithgametype("ESCORTS", 1);
            continue;
        }
        player.escortingrobot = 0;
        return;
    }
}

// Namespace escort
// Params 2, eflags: 0x0
// Checksum 0xad68c9fa, Offset: 0x3818
// Size: 0x4a
function setup_reboot_object(robot, triggername) {
    trigger = getent(triggername, "targetname");
    if (isdefined(trigger)) {
        trigger delete();
    }
}

// Namespace escort
// Params 2, eflags: 0x0
// Checksum 0x5a48740b, Offset: 0x3870
// Size: 0x61
function setup_goal_object(robot, triggername) {
    trigger = getent(triggername, "targetname");
    InvalidOpCode(0x54, "defenders", trigger, [], (0, 0, 0), %escort_goal);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace escort
// Params 1, eflags: 0x0
// Checksum 0x511efb35, Offset: 0x39b0
// Size: 0x1e5
function watch_robot_enter(robot) {
    robot endon(#"death");
    level endon(#"game_ended");
    var_ad7fe3c5 = self.trigger.radius * self.trigger.radius;
    while (true) {
        if (robot.moving === 1 && distance2dsquared(self.trigger.origin, robot.origin) < var_ad7fe3c5) {
            level.moveplayers = 0;
            robot.overrideactordamage = &robot_damage_none;
            if (target_istarget(self)) {
                target_remove(self);
            }
            InvalidOpCode(0x54, "attackers");
            // Unknown operator (0x54, t7_1b, PC)
        }
        wait 0.05;
    }
}

