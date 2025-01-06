#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/cp_doa_bo3_enemy;
#using scripts/cp/cp_doa_bo3_fx;
#using scripts/cp/cp_doa_bo3_player_challenge;
#using scripts/cp/cp_doa_bo3_silverback_battle;
#using scripts/cp/cp_doa_bo3_sound;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_gibs;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/ai/systems/ai_blackboard;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_doa_bo3;

// Namespace cp_doa_bo3
// Params 0, eflags: 0x0
// Checksum 0x5b7f08b7, Offset: 0x910
// Size: 0x1a
function function_243693d4() {
    util::add_gametype("doa");
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x0
// Checksum 0x71a4bc78, Offset: 0x938
// Size: 0x172
function main() {
    setdvar("ui_allowDisplayContinue", 0);
    clientfield::register("world", "redinsExploder", 1, 2, "int");
    clientfield::register("world", "activateBanner", 1, 3, "int");
    clientfield::register("world", "pumpBannerBar", 1, 8, "float");
    clientfield::register("scriptmover", "runcowanim", 1, 1, "int");
    clientfield::register("world", "redinstutorial", 1, 1, "int");
    clientfield::register("world", "redinsinstruct", 1, 12, "int");
    setsharedviewport(1);
    settopdowncamerayaw(0);
    level.var_7ed6996d = &init;
    level thread namespace_693feb87::main();
    level thread cp_doa_bo3_fx::main();
    level thread cp_doa_bo3_sound::main();
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x0
// Checksum 0x12a7696d, Offset: 0xab8
// Size: 0x3a3
function init() {
    level.doa.var_d18af0d = &function_957373c6;
    level.doa.var_aeeb3a0e = &function_5ee7262b;
    level.doa.var_62423327 = &arenainit;
    level.doa.var_cefa8799 = &function_87092704;
    level.doa.var_c95041ea = &function_165c9bd0;
    level.doa.var_5ddb204f = &function_aab05139;
    namespace_51bd792::init();
    namespace_a3646565::init();
    function_d1c7245c();
    /#
        level.doa.var_e6fd0e17 = &namespace_51bd792::function_3e45b9db;
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
            /#
                adddebugcommand(cmd);
            #/
        }
    }
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x0
// Checksum 0x989f05f8, Offset: 0xe68
// Size: 0x4d
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
// Params 0, eflags: 0x0
// Checksum 0x5208aa1c, Offset: 0xec0
// Size: 0x14b
function function_d1c7245c() {
    level.doa.var_af875fb7 = [];
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
// Params 1, eflags: 0x0
// Checksum 0xfdc45b20, Offset: 0x1018
// Size: 0x29d
function function_75772673(player) {
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
    self thread function_cd6da677();
    self thread function_cef7f9fd();
    self thread function_8e619e60(player);
    color = namespace_831a4a7c::function_ee495f41(player.entnum);
    trail = "gem_trail_" + color;
    self namespace_51bd792::droptoground(self.origin, trail, "turret_impact", 0, 0);
    self namespace_1a381543::function_90118d8c("evt_robot_land");
    self namespace_eaa992c::function_285a2999("player_trail_" + color);
    self endon(#"death");
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
// Params 3, eflags: 0x0
// Checksum 0x3ca7ec3, Offset: 0x12c0
// Size: 0xc2
function function_e1cd643e(projectile, weapon, player) {
    self endon(#"death");
    while (isdefined(projectile)) {
        self waittill(#"trigger", guy);
        if (!isdefined(guy.boss) && isalive(guy)) {
            guy dodamage(guy.health, self.origin, isdefined(player) ? player : undefined, isdefined(player) ? player : undefined, "torso_lower", "MOD_EXPLOSIVE", 0, weapon, -1, 1);
        }
    }
    self delete();
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x0
// Checksum 0xc83ac3a7, Offset: 0x1390
// Size: 0xdd
function function_8e619e60(player) {
    self endon(#"death");
    while (true) {
        self waittill(#"missile_fire", projectile, weapon);
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
// Params 1, eflags: 0x0
// Checksum 0x99466fd4, Offset: 0x1478
// Size: 0x1d2
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
    self notify(#"hash_6e8326fc");
    self cleartargetentity();
    if (!isdefined(player.doa)) {
        self kill();
    }
    self namespace_1a381543::function_90118d8c("evt_skel_rise");
    if (!isdefined(player.doa.var_af875fb7)) {
        player.doa.var_af875fb7 = [];
    }
    if (player.doa.var_af875fb7.size) {
        player.doa.var_af875fb7 = array::remove_undefined(player.doa.var_af875fb7);
    }
    player.doa.var_af875fb7[player.doa.var_af875fb7.size] = self;
    self thread function_cd6da677();
    self thread function_5633d485();
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x0
// Checksum 0xa048f81a, Offset: 0x1658
// Size: 0x9a
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
// Params 0, eflags: 0x0
// Checksum 0x51e6235d, Offset: 0x1700
// Size: 0x3a
function function_cd6da677() {
    self waittill(#"death");
    if (isdefined(self.owner)) {
        arrayremovevalue(self.owner.doa.var_af875fb7, self, 0);
    }
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x0
// Checksum 0x3b365a9, Offset: 0x1748
// Size: 0x82
function function_5633d485() {
    self endon(#"death");
    lifetime = self.owner namespace_49107f3a::function_1ded48e6(level.doa.rules.var_109b458d);
    level util::waittill_any_timeout(lifetime, "doa_game_is_over", "doa_game_restart", "kill_guardians");
    self kill();
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x0
// Checksum 0x3fc8d480, Offset: 0x17d8
// Size: 0x1d2
function function_cef7f9fd() {
    self endon(#"death");
    lifetime = self.owner namespace_49107f3a::function_1ded48e6(level.doa.rules.var_109b458d);
    level util::waittill_any_timeout(lifetime, "doa_game_is_over", "doa_game_restart", "kill_guardians");
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
// Params 0, eflags: 0x0
// Checksum 0x6b3d3573, Offset: 0x19b8
// Size: 0x21d
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
// Params 1, eflags: 0x0
// Checksum 0xf8e247d9, Offset: 0x1be0
// Size: 0x65
function function_1de9db1b(name) {
    switch (name) {
    case "margwa":
        namespace_51bd792::function_4ce6d0ea();
        level notify(#"bossEventComplete");
        break;
    case "silverback":
        namespace_a3646565::function_fc48f9f3();
        level notify(#"bossEventComplete");
        break;
    }
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x0
// Checksum 0xae211a8a, Offset: 0x1c50
// Size: 0x359
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
// Params 1, eflags: 0x0
// Checksum 0x263c2613, Offset: 0x1fb8
// Size: 0x6a
function arenainit(arena) {
    if (arena.name == "blood") {
        arena.var_f06f27e8 = &function_9d32f5d;
    }
    if (arena.name == "sgen") {
        arena.var_f06f27e8 = &function_b8aa2b56;
    }
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x0
// Checksum 0x5bc45b3e, Offset: 0x2030
// Size: 0x63d
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
        def.var_83bae1f8 = 1000;
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
    case 8:
        def.round = -1;
        def.var_84aef63e = 5;
        def.var_83bae1f8 = 1000;
        def.var_3eea3245 = 1000;
        def.spawnfunc = &namespace_51bd792::function_1631202b;
        def.spawnchance = 1;
        def.var_3ceda880 = 1;
        level.doa.var_83a65bc6 = def;
        def.cooldown = 0;
        def.var_759562f7 = 5000;
        break;
    default:
        assert(0);
        break;
    }
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x0
// Checksum 0x127e16d9, Offset: 0x2678
// Size: 0x1a
function function_aab05139() {
    videostart("cp_doa_bo3_endgame");
}

// Namespace cp_doa_bo3
// Params 1, eflags: 0x0
// Checksum 0x9b899f39, Offset: 0x26a0
// Size: 0xc
function function_ceb822db(var_fed4dbb3) {
    return var_fed4dbb3;
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x0
// Checksum 0xdde38bd4, Offset: 0x26b8
// Size: 0x61
function function_9d32f5d() {
    if (!isdefined(level.doa.blood_riser_spawner)) {
        level.doa.blood_riser_spawner = getent("blood_riser_spawner", "targetname");
    }
    return namespace_51bd792::function_17de14f1(level.doa.blood_riser_spawner);
}

// Namespace cp_doa_bo3
// Params 0, eflags: 0x0
// Checksum 0xbe8f2054, Offset: 0x2728
// Size: 0x61
function function_b8aa2b56() {
    if (!isdefined(level.doa.var_8fb5dd7d)) {
        level.doa.var_8fb5dd7d = getent("zombie_riser", "targetname");
    }
    return namespace_51bd792::function_45849d81(level.doa.var_8fb5dd7d);
}

