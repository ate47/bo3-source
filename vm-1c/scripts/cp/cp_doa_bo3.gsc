#using scripts/shared/vehicles/_quadtank;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_gibs;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/util_shared;
#using scripts/cp/_util;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/cp_doa_bo3_silverback_battle;
#using scripts/cp/cp_doa_bo3_sound;
#using scripts/cp/cp_doa_bo3_fx;
#using scripts/cp/cp_doa_bo3_player_challenge;
#using scripts/cp/cp_doa_bo3_enemy;
#using scripts/shared/vehicles/_spider;
#using scripts/shared/math_shared;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/ai_blackboard;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai_shared;

#namespace cp_doa_bo3;

// Namespace cp_doa_bo3
// Params 0, eflags: 0x0
// Checksum 0x2e28129, Offset: 0xb78
// Size: 0x1c
function function_243693d4() {
    util::add_gametype("doa");
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x1 linked
// Checksum 0x62f115d8, Offset: 0xba0
// Size: 0x4c
function function_30fd2139() {
    if (sessionmodeisonlinegame()) {
        /#
            namespace_49107f3a::debugmsg("<dev string:x28>");
        #/
        precacheleaderboards("LB_CP_DOA_BO3_ROUND LB_CP_DOA_BO3_SCORE LB_CP_DOA_BO3_SILVERBACKS LB_CP_DOA_BO3_GEMS LB_CP_DOA_BO3_SKULLS LB_CP_DOA_BO3_SCORE_1PLAYER LB_CP_DOA_BO3_SCORE_2PLAYER LB_CP_DOA_BO3_SCORE_3PLAYER LB_CP_DOA_BO3_SCORE_4PLAYER LB_CP_DOA_BO3_ROUND_1PLAYER LB_CP_DOA_BO3_ROUND_2PLAYER LB_CP_DOA_BO3_ROUND_3PLAYER LB_CP_DOA_BO3_ROUND_4PLAYER");
    }
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x1 linked
// Checksum 0x28026e3f, Offset: 0xbf8
// Size: 0x23c
function main() {
    setdvar("ui_allowDisplayContinue", 0);
    clientfield::register("world", "redinsExploder", 1, 2, "int");
    clientfield::register("world", "activateBanner", 1, 3, "int");
    clientfield::register("world", "pumpBannerBar", 1, 8, "float");
    clientfield::register("scriptmover", "runcowanim", 1, 1, "int");
    clientfield::register("world", "redinstutorial", 1, 1, "int");
    clientfield::register("world", "redinsinstruct", 1, 12, "int");
    clientfield::register("scriptmover", "runsiegechickenanim", 8000, 2, "int");
    setsharedviewport(1);
    settopdowncamerayaw(0);
    function_30fd2139();
    setdvar("bg_friendlyFireMode", 0);
    level.var_7ed6996d = &init;
    level.var_fd84aa1f = &function_56600114;
    level thread namespace_693feb87::main();
    level thread cp_doa_bo3_fx::main();
    level thread cp_doa_bo3_sound::main();
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x1 linked
// Checksum 0x3c0c3cdf, Offset: 0xe40
// Size: 0x522
function init() {
    level.doa.var_d18af0d = &function_957373c6;
    level.doa.var_fdc1fa6b = &function_dbb56674;
    level.doa.var_aeeb3a0e = &function_5ee7262b;
    level.doa.var_62423327 = &arenainit;
    level.doa.var_cefa8799 = &function_87092704;
    level.doa.var_c95041ea = &function_165c9bd0;
    level.doa.var_5ddb204f = &function_aab05139;
    level.doa.var_771e3915 = &namespace_51bd792::function_771e3915;
    namespace_51bd792::init();
    namespace_a3646565::init();
    function_d1c7245c();
    level.doa.enemyspawners = [];
    /#
        level.doa.var_e6fd0e17 = &namespace_51bd792::function_65762352;
    #/
    var_fcdf780c = "devgui_cmd \"Zombietron/Spawn/Enemy/";
    spawners = getspawnerarray();
    setdvar("scr_spawn_name", "");
    type = undefined;
    foreach (spawner in spawners) {
        if (isdefined(spawner.team) && spawner.team != "axis") {
            continue;
        }
        if (isdefined(spawner.script_team) && spawner.script_team != "axis") {
            continue;
        }
        if (spawner.classname == "script_vehicle" && isdefined(spawner.archetype)) {
            if (issubstr(spawner.vehicletype, "_zombietron_")) {
                type = strtok2(spawner.vehicletype, "_zombietron_");
                name = type[1];
            } else {
                name = spawner.archetype;
            }
            cmd = var_fcdf780c + name + "\" \"zombie_devgui aispawn; scr_spawn_name " + name + "\" \n";
            level.doa.enemyspawners[name] = spawner;
            /#
                adddebugcommand(cmd);
            #/
            continue;
        }
        if (!issubstr(spawner.classname, "_zombietron_")) {
            continue;
        }
        type = strtok2(spawner.classname, "_zombietron_");
        name = type[1];
        if (isdefined(type) && type.size == 2) {
            classname = spawner.classname;
            if (isdefined(spawner.script_parameters)) {
                type = strtok(spawner.script_parameters, ":");
                classname = type[1];
                name = "zombie_" + classname;
            }
            cmd = var_fcdf780c + name + "\" \"zombie_devgui aispawn; scr_spawn_name " + classname + "\" \n";
            level.doa.enemyspawners[name] = spawner;
            /#
                adddebugcommand(cmd);
            #/
        }
    }
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x1 linked
// Checksum 0xe5c83bd6, Offset: 0x1370
// Size: 0x72
function function_dbb56674() {
    if (getplayers().size > 1) {
        mapname = namespace_3ca3c537::function_d2d75f5d();
        if (mapname == "vengeance") {
            return 8;
        }
        if (mapname == "clearing") {
            return 6;
        }
    }
    return -1;
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0xb36cb384, Offset: 0x13f0
// Size: 0x56
function function_5ee7262b(def) {
    switch (def.type) {
    case "type_electric_mine":
        break;
    default:
        assert(0);
        break;
    }
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x1 linked
// Checksum 0x347f17a3, Offset: 0x1450
// Size: 0x18e
function function_d1c7245c() {
    level.doa.var_af875fb7 = [];
    level.doa.var_1332e37a = [];
    guardian = spawnstruct();
    guardian.type = 30;
    guardian.spawner = getent("spawner_zombietron_skeleton", "targetname");
    guardian.spawnfunction = &namespace_51bd792::function_862e15fa;
    guardian.initfunction = &function_89a2ffc4;
    level.doa.var_af875fb7[level.doa.var_af875fb7.size] = guardian;
    guardian = spawnstruct();
    guardian.type = 31;
    guardian.spawner = getent("zombietron_guardian_robot", "targetname");
    guardian.spawnfunction = &namespace_51bd792::function_575e3933;
    guardian.initfunction = &function_75772673;
    level.doa.var_af875fb7[level.doa.var_af875fb7.size] = guardian;
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0x447350f3, Offset: 0x15e8
// Size: 0x390
function function_75772673(player) {
    self endon(#"death");
    self ai::set_behavior_attribute("rogue_control", "forced_level_1");
    self.health = 15000;
    self.team = player.team;
    self.owner = player;
    self.goalradius = 100;
    self.holdfire = 0;
    self.updatesight = 1;
    self.allowpain = 0;
    self setthreatbiasgroup("players");
    self ai::set_behavior_attribute("rogue_control_speed", "run");
    if (!isdefined(player.doa)) {
        self kill();
    }
    player.doa.var_af875fb7 = array::remove_undefined(player.doa.var_af875fb7);
    player.doa.var_af875fb7[player.doa.var_af875fb7.size] = self;
    blackboard::setblackboardattribute(self, "_desired_stance", "crouch");
    self thread function_cd6da677(player);
    self thread function_cef7f9fd();
    self thread function_8e619e60(player);
    color = namespace_831a4a7c::function_ee495f41(player.entnum);
    trail = "gem_trail_" + color;
    self setplayercollision(0);
    self namespace_51bd792::droptoground(self.origin, trail, "turret_impact", 0, 0);
    self namespace_1a381543::function_90118d8c("evt_robot_land");
    self namespace_eaa992c::function_285a2999("player_trail_" + color);
    while (isdefined(player)) {
        self clearforcedgoal();
        nodes = getnodesinradius(player.origin, 512, -128);
        if (isdefined(nodes) && nodes.size > 0) {
            goto = nodes[randomint(nodes.size)].origin;
            self useposition(goto);
        }
        wait randomintrange(5, 12);
    }
}

// Namespace cp_doa_bo3
// Params 3, eflags: 0x1 linked
// Checksum 0xfe5a1155, Offset: 0x1980
// Size: 0xfc
function function_e1cd643e(projectile, weapon, player) {
    self endon(#"death");
    while (isdefined(projectile)) {
        guy = self waittill(#"trigger");
        if (!isdefined(guy.boss) && isalive(guy)) {
            guy dodamage(guy.health, self.origin, isdefined(player) ? player : undefined, isdefined(player) ? player : undefined, "torso_lower", "MOD_EXPLOSIVE", 0, weapon, -1, 1);
        }
    }
    self delete();
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0xa4b45d19, Offset: 0x1a88
// Size: 0x120
function function_8e619e60(player) {
    self endon(#"death");
    while (true) {
        projectile, weapon = self waittill(#"missile_fire");
        trigger = spawn("trigger_radius", projectile.origin, 9, 16, 24);
        trigger.targetname = "sawBladeProjectile";
        trigger enablelinkto();
        trigger linkto(projectile);
        trigger thread function_e1cd643e(projectile, weapon, player);
        trigger thread namespace_49107f3a::function_1bd67aef(3);
        trigger thread namespace_49107f3a::function_75e76155(projectile, "death");
    }
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0x6954a683, Offset: 0x1bb0
// Size: 0x25c
function function_89a2ffc4(player) {
    self.zombie_move_speed = "super_sprint";
    self.health = 15000;
    self.team = player.team;
    self.owner = player;
    self.goalradius = 100;
    self.allowpain = 0;
    self.var_688f2d0c = &function_f45d4afc;
    self namespace_eaa992c::function_285a2999("player_trail_" + namespace_831a4a7c::function_ee495f41(player.entnum));
    self.holdfire = 0;
    self.updatesight = 1;
    self setthreatbiasgroup("players");
    self setplayercollision(0);
    self notify(#"hash_6e8326fc");
    self cleartargetentity();
    if (!isdefined(player.doa)) {
        self kill();
        return;
    }
    self namespace_1a381543::function_90118d8c("evt_skel_rise");
    if (!isdefined(player.doa.var_af875fb7)) {
        player.doa.var_af875fb7 = [];
    }
    if (player.doa.var_af875fb7.size) {
        player.doa.var_af875fb7 = array::remove_undefined(player.doa.var_af875fb7);
    }
    player.doa.var_af875fb7[player.doa.var_af875fb7.size] = self;
    self thread function_cd6da677(player);
    self thread function_5633d485();
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0xc22a792b, Offset: 0x1e18
// Size: 0xcc
function function_f45d4afc(target) {
    if (self.team == target.team) {
        return;
    }
    vel = vectorscale(self.origin - target.origin, 0.2);
    target namespace_fba031c8::function_ddf685e8(vel, self);
    if (isdefined(target)) {
        target dodamage(1100, target.origin, self, self);
        self namespace_1a381543::function_90118d8c("evt_skel_attack");
    }
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0x263e7f4c, Offset: 0x1ef0
// Size: 0x84
function function_cd6da677(owner) {
    self waittill(#"death");
    if (isdefined(owner)) {
        if (isdefined(self)) {
            arrayremovevalue(owner.doa.var_af875fb7, self, 0);
            return;
        }
        array::remove_undefined(owner.doa.var_af875fb7, 0);
    }
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x1 linked
// Checksum 0x6450786, Offset: 0x1f80
// Size: 0xc4
function function_5633d485() {
    self endon(#"death");
    lifetime = self.owner namespace_49107f3a::function_1ded48e6(level.doa.rules.var_109b458d);
    self thread namespace_49107f3a::function_783519c1("doa_game_is_over", 1);
    self thread namespace_49107f3a::function_783519c1("doa_game_restart", 1);
    self thread namespace_49107f3a::function_783519c1("kill_guardians", 1);
    wait lifetime;
    self kill();
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x1 linked
// Checksum 0xe48330a4, Offset: 0x2050
// Size: 0x264
function function_cef7f9fd() {
    self endon(#"death");
    lifetime = self.owner namespace_49107f3a::function_1ded48e6(level.doa.rules.var_109b458d);
    self thread namespace_49107f3a::function_783519c1("doa_game_is_over", 1);
    self thread namespace_49107f3a::function_783519c1("doa_game_restart", 1);
    self thread namespace_49107f3a::function_783519c1("kill_guardians", 1);
    wait lifetime;
    self clientfield::increment("burnZombie");
    self.ignoreall = 1;
    self namespace_1a381543::function_90118d8c("gdt_immolation_robot_countdown");
    var_989e36b3 = 2000 + gettime();
    while (gettime() < var_989e36b3) {
        self dodamage(5, self.origin, undefined, undefined, "none", "MOD_RIFLE_BULLET", 0, getweapon("gadget_immolation"), -1, 1);
        self waittillmatch(#"bhtn_action_terminate", "specialpain");
    }
    self namespace_1a381543::function_90118d8c("wpn_incendiary_explode");
    playfxontag("explosions/fx_ability_exp_immolation", self, "j_spinelower");
    physicsexplosionsphere(self.origin, -56, 32, 2);
    util::wait_network_frame();
    radiusdamage(self.origin, -128, 1500, 1500);
    wait 0.1;
    if (isdefined(self) && isalive(self)) {
        self kill();
    }
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x1 linked
// Checksum 0x8f53391b, Offset: 0x22c0
// Size: 0x242
function function_165c9bd0() {
    curmapname = namespace_3ca3c537::function_d2d75f5d();
    if (isdefined(level.doa.var_602737ab) && (curmapname == "boss" && level.doa.var_458c27d == 3 || level.doa.var_602737ab)) {
        if (isdefined(level.doa.var_602737ab) && level.doa.var_602737ab) {
            namespace_3ca3c537::function_5af67667(namespace_3ca3c537::function_5835533a("boss"), 1);
            namespace_3ca3c537::function_ba9c838e();
            level thread util::set_lighting_state(3);
            namespace_cdb9a8fe::function_55762a85();
            namespace_831a4a7c::function_82e3b1cb();
        }
        level.doa.var_602737ab = undefined;
        level thread function_1de9db1b("silverback");
        return true;
    }
    if (isdefined(level.doa.var_bae65231) && (curmapname == "cave" && level.doa.var_458c27d == 0 || level.doa.var_bae65231)) {
        if (isdefined(level.doa.var_bae65231) && level.doa.var_bae65231) {
            namespace_3ca3c537::function_5af67667(namespace_3ca3c537::function_5835533a("cave"), 1);
            namespace_3ca3c537::function_ba9c838e();
            namespace_cdb9a8fe::function_55762a85();
            namespace_831a4a7c::function_82e3b1cb();
        }
        level.doa.var_bae65231 = undefined;
        level thread function_1de9db1b("margwa");
        return false;
    }
    return false;
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0x2e0b43e3, Offset: 0x2510
// Size: 0x186
function function_1de9db1b(name) {
    switch (name) {
    case "margwa":
        namespace_51bd792::function_4ce6d0ea();
        level notify(#"hash_593b80cb");
        foreach (player in getplayers()) {
            player notify(#"hash_593b80cb");
        }
        break;
    case "silverback":
        namespace_a3646565::function_fc48f9f3();
        level notify(#"hash_593b80cb");
        foreach (player in getplayers()) {
            player notify(#"hash_593b80cb");
        }
        break;
    }
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0xfd2f38f0, Offset: 0x26a0
// Size: 0x472
function function_87092704(room) {
    switch (room.name) {
    case "tankmaze":
        room.var_6f369ab4 = 99;
        room.var_45da785b = &namespace_df93fc7c::function_6aa91f48;
        room.var_58e293a2 = &namespace_df93fc7c::function_5f0b67a9;
        room.var_c64606ef = &namespace_df93fc7c::function_f1915ffb;
        room.var_1cd9eda = &namespace_df93fc7c::function_9e5e0a15;
        room.var_2530dc89 = &namespace_df93fc7c::function_a25fc96;
        room.minround = 47;
        room.var_2b9a70de = 47;
        room.timeout = 90;
        room.var_a90de2a1 = 30;
        room.random = 15;
        room.banner = 3;
        room.var_ac3f2368 = 0;
        break;
    case "redins":
        room.var_6f369ab4 = 99;
        room.var_45da785b = &namespace_df93fc7c::function_ba487e2a;
        room.var_58e293a2 = &namespace_df93fc7c::function_f14ef72f;
        room.var_c64606ef = &namespace_df93fc7c::function_ce5fc0d;
        room.var_1cd9eda = &namespace_df93fc7c::function_9d1b24f7;
        room.var_2530dc89 = &namespace_df93fc7c::function_e13abd74;
        room.minround = 11;
        room.var_2b9a70de = 11;
        room.var_a90de2a1 = 30;
        room.timeout = -1;
        room.random = 15;
        room.var_ac3f2368 = 0;
        break;
    case "spiral":
        room.var_6f369ab4 = 1;
        room.var_45da785b = &namespace_df93fc7c::function_31c377e;
        room.var_58e293a2 = &namespace_df93fc7c::function_8e0e22bb;
        room.var_1cd9eda = &namespace_df93fc7c::function_47a3686b;
        room.var_c64606ef = &namespace_df93fc7c::function_eee6e911;
        room.var_2530dc89 = &namespace_df93fc7c::function_7823dbb8;
        room.minround = 19;
        room.maxround = 19;
        room.var_2b9a70de = 19;
        room.timeout = -1;
        room.var_ac3f2368 = 0;
        break;
    case "truck_soccer":
        room.var_6f369ab4 = 99;
        room.var_45da785b = &namespace_df93fc7c::function_c7e4d911;
        room.var_58e293a2 = &namespace_df93fc7c::function_2ea4cb82;
        room.var_c64606ef = &namespace_df93fc7c::function_b3939e94;
        room.var_1cd9eda = &namespace_df93fc7c::function_92349eb6;
        room.var_2530dc89 = &namespace_df93fc7c::function_fd4f5419;
        room.banner = 2;
        room.minround = 26;
        room.var_2b9a70de = 26;
        room.timeout = 120;
        room.var_a90de2a1 = 30;
        room.random = 15;
        room.var_ac3f2368 = 0;
        break;
    }
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0x679a7877, Offset: 0x2b20
// Size: 0x78
function arenainit(arena) {
    if (arena.name == "blood") {
        arena.var_f06f27e8 = &function_9d32f5d;
    }
    if (arena.name == "sgen") {
        arena.var_f06f27e8 = &function_b8aa2b56;
    }
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0xb8d66199, Offset: 0x2ba0
// Size: 0xb7e
function function_957373c6(def) {
    switch (def.number) {
    case 5:
        def.round = 5;
        def.title = %CP_DOA_BO3_CHALLENGE_COLLECTOR;
        def.var_84aef63e = 5;
        def.var_83bae1f8 = 1000;
        def.spawnfunc = &namespace_51bd792::function_53b44cb7;
        def.spawnchance = 1;
        def.cooldown = 0;
        def.var_759562f7 = 5000;
        break;
    case 9:
        def.round = 9;
        def.title = %CP_DOA_BO3_ITS_MY_FARM;
        def.var_84aef63e = 40;
        def.var_83bae1f8 = 1000;
        def.spawnfunc = &namespace_51bd792::function_ce9bce16;
        def.spawnchance = 1;
        def.var_3ceda880 = 1;
        def.var_965be9 = &namespace_df93fc7c::function_c0485deb;
        def.var_474e643b = 36;
        break;
    case 6:
        def.round = 13;
        def.title = %CP_DOA_BO3_CHALLENGE_RISERS;
        def.var_84aef63e = 40;
        def.var_83bae1f8 = 1000;
        def.spawnfunc = &namespace_51bd792::function_45849d81;
        def.spawnchance = 1;
        def.var_3ceda880 = 1;
        def.var_474e643b = 36;
        break;
    case 11:
        def.round = 17;
        def.var_84aef63e = 8;
        def.title = %CP_DOA_BO3_CHALLENGE_SHADOW;
        def.var_83bae1f8 = 1000;
        def.var_3eea3245 = 1000;
        def.spawnfunc = &namespace_51bd792::function_b9980eda;
        def.spawnchance = 1;
        break;
    case 12:
        def.round = 25;
        def.title = %CP_DOA_BO3_CHALLENGE_BLOOD_RISERS;
        def.var_84aef63e = 40;
        def.spawnfunc = &namespace_51bd792::function_17de14f1;
        def.var_83bae1f8 = 1000;
        def.var_3eea3245 = 1000;
        def.spawnchance = 1;
        def.var_3ceda880 = 1;
        def.var_474e643b = 50;
        def.var_a0b2e897 = "blood";
        def.var_79c72134 = 1;
        break;
    case 2:
        def.round = 26;
        def.title = %CP_DOA_BO3_CHALLENGE_MEATBALLS;
        def.var_84aef63e = 6;
        def.spawnfunc = &namespace_51bd792::function_fb051310;
        def.var_83bae1f8 = 1000;
        def.var_3eea3245 = 1000;
        def.var_3ceda880 = 1;
        def.spawnchance = 0.5;
        def.cooldown = 0;
        def.var_759562f7 = 30000;
        def.initfunc = &function_45c28296;
        def.endfunc = &function_f8fa5dcf;
        break;
    case 4:
        def.round = 33;
        def.title = %CP_DOA_BO3_CHALLENGE_WARLORD;
        def.var_84aef63e = 5;
        def.var_83bae1f8 = 1000;
        def.spawnfunc = &namespace_51bd792::function_a0d7d949;
        def.spawnchance = 1;
        break;
    case 10:
        def.round = 40;
        def.title = %CP_DOA_BO3_CHALLENGE_BLOODSUCKER;
        def.var_84aef63e = 20;
        def.var_83bae1f8 = 1000;
        def.var_3eea3245 = 1000;
        def.spawnfunc = &namespace_51bd792::function_33525e11;
        def.spawnchance = 0.1;
        def.var_3ceda880 = 0;
        def.cooldown = 0;
        def.var_759562f7 = 10000;
        break;
    case 1:
        def.round = 45;
        def.title = %CP_DOA_BO3_CHALLENGE_ROBOTS;
        def.var_84aef63e = 10;
        def.spawnfunc = &namespace_51bd792::function_4d2a4a76;
        def.var_83bae1f8 = 1000;
        def.spawnchance = 1;
        break;
    case 7:
        def.round = 49;
        def.title = %CP_DOA_BO3_CHALLENGE_CELLBREAK;
        def.var_84aef63e = 10;
        def.var_83bae1f8 = 2000;
        def.spawnfunc = &namespace_51bd792::function_5e86b6fa;
        def.spawnchance = 1;
        break;
    case 3:
        def.round = 53;
        def.title = %CP_DOA_BO3_CHALLENGE_DOGS;
        def.var_84aef63e = 6;
        def.var_83bae1f8 = 1000;
        def.var_3eea3245 = 1000;
        def.spawnfunc = &namespace_51bd792::function_bb3b0416;
        def.spawnchance = 1;
        def.var_3ceda880 = 1;
        break;
    case 13:
        def.round = 60;
        def.title = %CP_DOA_BO3_CHALLENGE_FURY;
        def.var_84aef63e = 6;
        def.var_83bae1f8 = 1000;
        def.var_3eea3245 = 1000;
        def.spawnfunc = &namespace_51bd792::function_92159541;
        def.spawnchance = 0.5;
        def.var_3ceda880 = 0;
        def.cooldown = 0;
        def.var_759562f7 = 300000;
        def.var_965be9 = &function_dd708257;
        break;
    case 8:
        def.round = -1;
        def.var_84aef63e = 5;
        def.var_83bae1f8 = 1000;
        def.var_3eea3245 = 1000;
        def.spawnfunc = &namespace_51bd792::function_1631202b;
        def.spawnchance = 1;
        def.var_3ceda880 = 0;
        level.doa.var_83a65bc6 = def;
        def.cooldown = 0;
        def.var_759562f7 = 5000;
        break;
    case 14:
        def.round = 37;
        def.title = %CP_DOA_BO3_CHALLENGE_SPIDER0;
        def.var_7f46fadf = array(%CP_DOA_BO3_CHALLENGE_SPIDER0, %CP_DOA_BO3_CHALLENGE_SPIDER2, %CP_DOA_BO3_CHALLENGE_SPIDER3, %CP_DOA_BO3_CHALLENGE_SPIDER1);
        def.var_84aef63e = 10;
        def.var_83bae1f8 = 1000;
        def.var_3eea3245 = 1000;
        def.spawnfunc = &namespace_51bd792::function_7512c5ee;
        def.endfunc = &function_7ea6d638;
        def.spawnchance = 1;
        def.var_3ceda880 = 0;
        def.cooldown = 0;
        def.var_759562f7 = 5000;
        def.var_474e643b = 20;
        def.var_75f2c952 = 24;
        def.var_9cf005d1 = 0;
        def.var_bb9ff15b = 2;
        level.doa.var_afdb45da = def;
        break;
    default:
        assert(0);
        break;
    }
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0xf3bec92, Offset: 0x3728
// Size: 0xf0
function function_7ea6d638(def) {
    def.round += 64;
    def.var_474e643b += 4;
    def.var_75f2c952 += 12;
    if (def.var_75f2c952 > 64) {
        def.var_75f2c952 = 64;
    }
    def.var_9cf005d1++;
    def.title = def.var_7f46fadf[def.var_9cf005d1 % def.var_7f46fadf.size];
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0x95ee55eb, Offset: 0x3820
// Size: 0x20
function function_45c28296(def) {
    level.doa.var_9a1cbf58 = 0;
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0x28719132, Offset: 0x3848
// Size: 0x20
function function_f8fa5dcf(def) {
    level.doa.var_9a1cbf58 = 1;
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0xd18c0989, Offset: 0x3870
// Size: 0x20
function function_dd708257(def) {
    level.doa.var_2f019708 = 0;
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x1 linked
// Checksum 0x31060c1a, Offset: 0x3898
// Size: 0x1c
function function_aab05139() {
    videostart("cp_doa_bo3_endgame");
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x0
// Checksum 0x43c2af38, Offset: 0x38c0
// Size: 0x10
function function_ceb822db(var_fed4dbb3) {
    return var_fed4dbb3;
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x1 linked
// Checksum 0x3411383e, Offset: 0x38d8
// Size: 0x6a
function function_9d32f5d() {
    if (!isdefined(level.doa.blood_riser_spawner)) {
        level.doa.blood_riser_spawner = getent("blood_riser_spawner", "targetname");
    }
    return namespace_51bd792::function_17de14f1(level.doa.blood_riser_spawner);
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x1 linked
// Checksum 0xb8fd3c3, Offset: 0x3950
// Size: 0x6a
function function_b8aa2b56() {
    if (!isdefined(level.doa.var_8fb5dd7d)) {
        level.doa.var_8fb5dd7d = getent("zombie_riser", "targetname");
    }
    return namespace_51bd792::function_45849d81(level.doa.var_8fb5dd7d);
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x1 linked
// Checksum 0xe164f14d, Offset: 0x39c8
// Size: 0x56
function function_56600114(name) {
    level notify(#"hash_56600114");
    level endon(#"hash_56600114");
    switch (name) {
    case "boss":
        level thread function_2fb9e83f();
        break;
    }
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x1 linked
// Checksum 0x1170786d, Offset: 0x3a28
// Size: 0x184
function function_2fb9e83f() {
    level notify(#"hash_2fb9e83f");
    level endon(#"hash_2fb9e83f");
    level endon(#"hash_ec7ca67b");
    wait 60;
    var_2c8bf5cd = math::clamp(level.doa.var_da96f13c + 1, 0, 3);
    level.doa.var_2c8bf5cd = [];
    while (var_2c8bf5cd > 0) {
        loc = namespace_49107f3a::function_ada6d90();
        level.doa.var_2c8bf5cd[level.doa.var_2c8bf5cd.size] = namespace_51bd792::function_6a6776cf(loc);
        var_2c8bf5cd--;
        wait 30;
    }
    while (level.doa.var_2c8bf5cd.size > 0) {
        level.doa.var_2c8bf5cd = array::remove_undefined(level.doa.var_2c8bf5cd);
        if (level.doa.var_2c8bf5cd.size == 0) {
            level flag::clear("doa_round_active");
            break;
        }
        wait 0.05;
    }
}

