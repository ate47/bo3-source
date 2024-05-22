#using scripts/cp/voice/voice_prologue;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_objectives;
#using scripts/cp/_dialog;
#using scripts/codescripts/struct;
#using scripts/cp/gametypes/_spawning;
#using scripts/shared/weapons_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/player_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;

#namespace namespace_2cb3876f;

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0x78e1aaab, Offset: 0x638
// Size: 0xda
function give_max_ammo() {
    a_w_weapons = self getweaponslist();
    foreach (w_weapon in a_w_weapons) {
        self givemaxammo(w_weapon);
        self setweaponammoclip(w_weapon, w_weapon.clipsize);
    }
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x1 linked
// Checksum 0xc2501119, Offset: 0x720
// Size: 0x112
function function_b50f5d52(var_76cb0c72) {
    if (!isdefined(var_76cb0c72)) {
        var_76cb0c72 = 0;
    }
    a_ai_enemies = getaiteamarray("axis");
    foreach (ai_enemy in a_ai_enemies) {
        if (isalive(ai_enemy)) {
            if (var_76cb0c72) {
                ai_enemy ai::bloody_death(randomfloat(0.25));
                continue;
            }
            ai_enemy delete();
        }
    }
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0xb46e4171, Offset: 0x840
// Size: 0x84
function function_2f943869() {
    self endon(#"death");
    wait(randomfloatrange(0.1, 0.6));
    self vehicle::get_out();
    if (isdefined(self.script_noteworthy)) {
        self setgoal(getnode(self.script_noteworthy, "targetname"), 1);
    }
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0x7feec538, Offset: 0x8d0
// Size: 0xfc
function function_77308ba7() {
    level.var_5d5055db = 1;
    level flag::set_val("is_base_alerted", 1);
    /#
        println("ally_03");
    #/
    level util::clientnotify("alarm_on");
    playsoundatposition("evt_base_alarm", (-1546, 287, 461));
    wait(2);
    playsoundatposition("evt_base_alarm", (-1546, 287, 461));
    wait(2);
    playsoundatposition("evt_base_alarm", (-1546, 287, 461));
}

// Namespace namespace_2cb3876f
// Params 2, eflags: 0x1 linked
// Checksum 0xfaa7b9e0, Offset: 0x9d8
// Size: 0x4d8
function function_6a5f89cb(skipto, var_de2f1b3) {
    if (!isdefined(var_de2f1b3)) {
        var_de2f1b3 = 1;
    }
    flag::wait_till("all_players_spawned");
    primary_weapon = getweapon("ar_standard_hero");
    var_5178c24b = getdvarint("scene_debug_player", 0);
    if (!isdefined(level.var_681ad194)) {
        level.var_681ad194 = [];
    }
    if (var_de2f1b3) {
        if (level.players.size <= 3 && !isdefined(level.var_681ad194[1]) && var_5178c24b != 2) {
            level.var_681ad194[1] = util::function_740f8516("ally_03");
            s_struct = struct::get(skipto + "_ally_03", "targetname");
            level.var_681ad194[1] forceteleport(s_struct.origin, s_struct.angles);
            level.var_681ad194[1] ai::gun_switchto(primary_weapon, "right");
            level.var_681ad194[1].var_a89679b6 = 3;
        }
        if (level.players.size <= 2 && !isdefined(level.var_681ad194[2]) && var_5178c24b != 3) {
            level.var_681ad194[2] = util::function_740f8516("ally_02");
            s_struct = struct::get(skipto + "_ally_02", "targetname");
            level.var_681ad194[2] forceteleport(s_struct.origin, s_struct.angles);
            level.var_681ad194[2] ai::gun_switchto(primary_weapon, "right");
            level.var_681ad194[2].var_a89679b6 = 2;
        }
        if (level.players.size == 1 && !isdefined(level.var_681ad194[3]) && var_5178c24b != 4) {
            level.var_681ad194[3] = util::function_740f8516("ally_01");
            s_struct = struct::get(skipto + "_ally_01", "targetname");
            level.var_681ad194[3] forceteleport(s_struct.origin, s_struct.angles);
            level.var_681ad194[3] ai::gun_switchto(primary_weapon, "right");
            level.var_681ad194[3].var_a89679b6 = 1;
        }
    }
    if (level.players.size >= 2 && isdefined(level.var_681ad194[3])) {
        level.var_681ad194[3] delete();
        level.var_681ad194[3] = undefined;
    }
    if (level.players.size >= 3 && isdefined(level.var_681ad194[2])) {
        level.var_681ad194[2] delete();
        level.var_681ad194[2] = undefined;
    }
    if (level.players.size >= 4 && isdefined(level.var_681ad194[1])) {
        level.var_681ad194[1] delete();
        level.var_681ad194[1] = undefined;
    }
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0xe9d943fc, Offset: 0xeb8
// Size: 0x26c
function function_4e6a4d54() {
    self flag::clear("custom_loadout");
    self takeallweapons();
    self.primaryloadoutweapon = getweapon("smg_standard", "grip", "fastreload", "reflex");
    self.secondaryloadoutweapon = getweapon("pistol_standard", "fastreload");
    self giveweapon(self.primaryloadoutweapon);
    self giveweapon(self.secondaryloadoutweapon);
    self.grenadetypeprimary = getweapon("frag_grenade");
    self.grenadetypesecondary = getweapon("concussion_grenade");
    self giveweapon(self.grenadetypeprimary);
    self giveweapon(self.grenadetypesecondary);
    a_w_weapons = self getweaponslist();
    foreach (w_weapon in a_w_weapons) {
        self givemaxammo(w_weapon);
        self setweaponammoclip(w_weapon, w_weapon.clipsize);
    }
    self switchtoweapon(self.primaryloadoutweapon);
    self flag::set("custom_loadout");
}

// Namespace namespace_2cb3876f
// Params 2, eflags: 0x0
// Checksum 0x2c3ef8b9, Offset: 0x1130
// Size: 0x54
function function_bee23a9e(vehicle, var_f3a8e7d6) {
    vehicle waittill(#"reached_end_node");
    vehicle disconnectpaths();
    spawn_manager::enable(var_f3a8e7d6);
}

// Namespace namespace_2cb3876f
// Params 2, eflags: 0x1 linked
// Checksum 0x68f83483, Offset: 0x1190
// Size: 0x178
function function_35be2939(var_5d370658, var_4afdd260) {
    self endon(#"death");
    self.goalradius = 8;
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self setgoal(self.origin);
    level flag::wait_till(var_5d370658);
    self.goalradius = 32;
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    if (isdefined(self.target)) {
        node = getnodearray(self.target, "targetname");
        index = randomintrange(0, node.size);
        self setgoal(node[index], 1);
    }
    if (isdefined(var_4afdd260)) {
        self waittill(#"goal");
        self.goalradius = var_4afdd260;
    }
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0x55db82bc, Offset: 0x1310
// Size: 0x9a
function function_6ee0e1a5() {
    if (!isdefined(level.var_681ad194)) {
        return [];
    }
    for (i = 1; i < 4; i++) {
        if (!isdefined(level.var_681ad194[i]) || !isalive(level.var_681ad194[i])) {
            level.var_681ad194[i] = undefined;
        }
    }
    return arraycopy(level.var_681ad194);
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0x41f55383, Offset: 0x13b8
// Size: 0x44
function function_125042c0() {
    var_2a04238a = arraycombine(getplayers(), level.var_681ad194, 0, 0);
    return var_2a04238a;
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0xfb51d0fd, Offset: 0x1408
// Size: 0xd4
function function_8abaca05() {
    self endon(#"death");
    self.goalradius = 64;
    self.ignoreall = 1;
    for (var_22752fde = getnode(self.script_string, "targetname"); true; var_22752fde = getnode(var_22752fde.script_string, "targetname")) {
        self setgoal(var_22752fde.origin);
        self waittill(#"goal");
        if (!isdefined(var_22752fde.script_string)) {
            break;
        }
    }
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x0
// Checksum 0x65c8ba8f, Offset: 0x14e8
// Size: 0x60
function function_67877d47(goal) {
    var_22752fde = getnode(goal, "targetname");
    self setgoal(var_22752fde, 1);
    self waittill(#"goal");
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x0
// Checksum 0xffdf55ce, Offset: 0x1550
// Size: 0x10
function function_94d4d33b() {
    self.goalradius = 512;
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x0
// Checksum 0xc656dab5, Offset: 0x1568
// Size: 0x10
function function_45a98c2a() {
    self.goalradius = 16;
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x1 linked
// Checksum 0xddf05e53, Offset: 0x1580
// Size: 0x24
function set_goal_volume(var_ab891f49) {
    self setgoalvolume(var_ab891f49);
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0x5d0f7f48, Offset: 0x15b0
// Size: 0xcc
function function_29c76f59() {
    var_ffdd18ce = self getteam();
    self ai::set_behavior_attribute("rogue_control", "forced_level_2");
    self ai::set_behavior_attribute("rogue_control_speed", "run");
    self setteam(var_ffdd18ce);
    if (level.players.size > 1) {
        self.health = int(self.health * 1.4);
    }
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x1 linked
// Checksum 0x1399fcea, Offset: 0x1688
// Size: 0x64
function function_bd761fba(str_flag) {
    self endon(#"death");
    self turret::enable(1, 0);
    level flag::wait_till(str_flag);
    self thread function_3a642801();
}

// Namespace namespace_2cb3876f
// Params 2, eflags: 0x1 linked
// Checksum 0xec12a697, Offset: 0x16f8
// Size: 0xdc
function function_9af14b02(str_flag, n_time) {
    self endon(#"death");
    self thread vehicle::get_on_and_go_path(getvehiclenode(self.target, "targetname"));
    self waittill(#"hash_12513ad8");
    self turret::shoot_at_target(level.apc, n_time, undefined, 1, 0);
    self turret::enable(1, 1);
    level flag::wait_till(str_flag);
    self thread function_3a642801();
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x1 linked
// Checksum 0x44911c51, Offset: 0x17e0
// Size: 0x44
function function_1db6047f(var_5dfe8937) {
    self endon(#"death");
    trigger::wait_till(var_5dfe8937);
    self delete();
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0x7545fa71, Offset: 0x1830
// Size: 0x13c
function function_3a642801() {
    foreach (ai_rider in self.riders) {
        if (isdefined(ai_rider)) {
            ai_rider delete();
        }
    }
    level flag::wait_till_clear("deleting_havok_object");
    level flag::set("deleting_havok_object");
    self.delete_on_death = 1;
    self notify(#"death");
    if (!isalive(self)) {
        self delete();
    }
    wait(0.05);
    level flag::clear("deleting_havok_object");
}

// Namespace namespace_2cb3876f
// Params 2, eflags: 0x1 linked
// Checksum 0x7c0d79ed, Offset: 0x1978
// Size: 0x8e
function function_73acb160(var_a9ea049a, start_func) {
    a_spawners = getentarray(var_a9ea049a, "targetname");
    for (i = 0; i < a_spawners.size; i++) {
        level thread function_1f89893f(a_spawners[i], start_func);
    }
}

// Namespace namespace_2cb3876f
// Params 2, eflags: 0x1 linked
// Checksum 0x4e7812ae, Offset: 0x1a10
// Size: 0x72
function function_1f89893f(e_spawner, start_func) {
    if (isdefined(e_spawner.script_delay)) {
        wait(e_spawner.script_delay);
    }
    e_ent = e_spawner spawner::spawn();
    if (isdefined(start_func)) {
        e_ent thread [[ start_func ]]();
    }
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0xe4ad8b64, Offset: 0x1a90
// Size: 0x10
function remove_grenades() {
    self.grenadeammo = 0;
}

// Namespace namespace_2cb3876f
// Params 3, eflags: 0x1 linked
// Checksum 0x3ed4d89f, Offset: 0x1aa8
// Size: 0x11c
function function_40e4b0cf(var_f3a8e7d6, var_a9ea049a, var_c5690501) {
    a_spawners = getentarray(var_a9ea049a, "targetname");
    e_volume = getent(var_c5690501, "targetname");
    foreach (sp_spawner in a_spawners) {
        sp_spawner spawner::add_spawn_function(&set_goal_volume, e_volume);
    }
    spawn_manager::enable(var_f3a8e7d6);
}

// Namespace namespace_2cb3876f
// Params 4, eflags: 0x1 linked
// Checksum 0xfa4a8e40, Offset: 0x1bd0
// Size: 0xde
function function_a7eac508(str_spawner, var_4ac59d48, var_84fffedf, var_a4652398) {
    a_ents = getentarray(str_spawner, "targetname");
    for (i = 0; i < a_ents.size; i++) {
        e_ent = a_ents[i] spawner::spawn();
        if (isdefined(var_4ac59d48)) {
            e_ent.goalradius = 64;
        }
        e_ent thread function_8e9f617f(var_84fffedf, var_a4652398);
    }
}

// Namespace namespace_2cb3876f
// Params 2, eflags: 0x1 linked
// Checksum 0x168577ce, Offset: 0x1cb8
// Size: 0x60
function function_8e9f617f(var_84fffedf, var_a4652398) {
    self endon(#"death");
    if (isdefined(var_a4652398) && var_a4652398) {
        self.var_a4652398 = 1;
    }
    self waittill(#"goal");
    if (isdefined(var_84fffedf)) {
        self.goalradius = var_84fffedf;
    }
}

// Namespace namespace_2cb3876f
// Params 3, eflags: 0x1 linked
// Checksum 0x82a25a05, Offset: 0x1d20
// Size: 0x16e
function function_8f7b1e06(str_trigger, var_390543cc, var_9d774f5d) {
    if (isdefined(str_trigger)) {
        e_trigger = getent(str_trigger, "targetname");
        e_trigger waittill(#"trigger");
    }
    var_441bd962 = getent(var_390543cc, "targetname");
    var_ee2fd889 = getent(var_9d774f5d, "targetname");
    a_ai = getaiteamarray("axis");
    for (i = 0; i < a_ai.size; i++) {
        e_ent = a_ai[i];
        if (e_ent istouching(var_441bd962)) {
            e_ent setgoal(var_ee2fd889);
            e_ent thread function_8e9f617f(undefined, 0);
        }
    }
}

// Namespace namespace_2cb3876f
// Params 2, eflags: 0x1 linked
// Checksum 0x9f4bf0c8, Offset: 0x1e98
// Size: 0x198
function function_9d611fab(str_struct, var_e209da48) {
    s_struct = struct::get(str_struct, "targetname");
    var_d91de807 = anglestoforward(s_struct.angles);
    while (true) {
        var_226231f3 = 0;
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            e_player = a_players[i];
            v_dir = vectornormalize(e_player.origin - s_struct.origin);
            dp = vectordot(v_dir, var_d91de807);
            if (dp > 0.3) {
                var_226231f3++;
            }
        }
        if (isdefined(var_e209da48) && var_226231f3 >= a_players.size) {
            break;
        }
        if (var_226231f3 == a_players.size) {
            break;
        }
        wait(0.05);
    }
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0x9f2b3a9, Offset: 0x2038
// Size: 0xbc
function function_12ce22ee() {
    level.a_ai_allies = [];
    if (isdefined(level.var_681ad194[1])) {
        arrayinsert(level.a_ai_allies, level.var_681ad194[1], 0);
    }
    if (isdefined(level.var_681ad194[2])) {
        arrayinsert(level.a_ai_allies, level.var_681ad194[2], 0);
    }
    if (isdefined(level.var_681ad194[3])) {
        arrayinsert(level.a_ai_allies, level.var_681ad194[3], 0);
    }
}

// Namespace namespace_2cb3876f
// Params 2, eflags: 0x1 linked
// Checksum 0x9a4b819a, Offset: 0x2100
// Size: 0x76
function function_520255e3(str_trigger, time) {
    str_notify = "mufc_" + str_trigger;
    level thread function_901793d(str_trigger, str_notify);
    level thread function_2ffbaa00(time, str_notify);
    level waittill(str_notify);
}

// Namespace namespace_2cb3876f
// Params 2, eflags: 0x1 linked
// Checksum 0x2f242981, Offset: 0x2180
// Size: 0x6c
function function_901793d(str_trigger, str_notify) {
    level endon(str_notify);
    e_trigger = getent(str_trigger, "targetname");
    if (isdefined(e_trigger)) {
        e_trigger waittill(#"trigger");
    }
    level notify(str_notify);
}

// Namespace namespace_2cb3876f
// Params 2, eflags: 0x1 linked
// Checksum 0x25b5a3a8, Offset: 0x21f8
// Size: 0x2c
function function_2ffbaa00(time, str_notify) {
    level endon(str_notify);
    wait(time);
    level notify(str_notify);
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x0
// Checksum 0x422fade6, Offset: 0x2230
// Size: 0x44
function groundpos_ignore_water(origin) {
    return groundtrace(origin, origin + (0, 0, -100000), 0, undefined, 1)["position"];
}

// Namespace namespace_2cb3876f
// Params 2, eflags: 0x1 linked
// Checksum 0x8d9fd110, Offset: 0x2280
// Size: 0x14e
function function_609c412a(str_volume, var_3dd53e00) {
    e_volume = getent(str_volume, "targetname");
    var_f04bd8f5 = 0;
    a_ai = getaiteamarray("axis");
    for (i = 0; i < a_ai.size; i++) {
        if (a_ai[i] istouching(e_volume)) {
            var_f04bd8f5++;
        }
    }
    if (var_3dd53e00) {
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            if (a_players[i] istouching(e_volume)) {
                var_f04bd8f5++;
                break;
            }
        }
    }
    return var_f04bd8f5;
}

// Namespace namespace_2cb3876f
// Params 6, eflags: 0x0
// Checksum 0x9645485a, Offset: 0x23d8
// Size: 0xa6
function function_15823dab(v_pos, shake_size, shake_time, var_e64e30a6, rumble_num, e_player) {
    if (shake_size) {
        earthquake(shake_size, shake_time, v_pos, var_e64e30a6);
    }
    for (i = 0; i < rumble_num; i++) {
        e_player playrumbleonentity("damage_heavy");
        wait(0.1);
    }
}

// Namespace namespace_2cb3876f
// Params 4, eflags: 0x1 linked
// Checksum 0x8ef2b3e2, Offset: 0x2488
// Size: 0x6c
function function_2747b8e1(str_type, var_5d22719a, n_iterations, e_ent) {
    for (i = 0; i < n_iterations; i++) {
        e_ent playrumbleonentity(str_type);
        wait(var_5d22719a);
    }
}

// Namespace namespace_2cb3876f
// Params 7, eflags: 0x1 linked
// Checksum 0x56a27373, Offset: 0x2500
// Size: 0x152
function function_2a0bc326(v_pos, var_48f82942, var_51fbdea, var_644bf6a7, var_8f4ca4be, var_11fed455, var_183c13ad) {
    if (!isdefined(var_11fed455)) {
        var_11fed455 = "damage_heavy";
    }
    if (var_48f82942) {
        earthquake(var_48f82942, var_51fbdea, v_pos, var_644bf6a7);
    }
    var_5ca58060 = var_644bf6a7 * var_644bf6a7;
    foreach (player in level.activeplayers) {
        if (isdefined(var_183c13ad)) {
            player shellshock(var_183c13ad, var_51fbdea);
        }
        player thread function_e42cebb6(v_pos, var_5ca58060, var_8f4ca4be, var_11fed455);
    }
}

// Namespace namespace_2cb3876f
// Params 4, eflags: 0x1 linked
// Checksum 0x8b6f6e0, Offset: 0x2660
// Size: 0x9e
function function_e42cebb6(v_pos, var_5ca58060, var_8f4ca4be, var_11fed455) {
    self endon(#"death");
    for (i = 0; i < var_8f4ca4be; i++) {
        if (distancesquared(v_pos, self.origin) <= var_5ca58060) {
            self playrumbleonentity(var_11fed455);
        }
        wait(0.1);
    }
}

// Namespace namespace_2cb3876f
// Params 6, eflags: 0x1 linked
// Checksum 0xaeebda79, Offset: 0x2708
// Size: 0x154
function vehicle_rumble(var_11fed455, var_74584a64, var_48f82942, n_period, n_radius, n_timeout) {
    if (!isdefined(var_11fed455)) {
        var_11fed455 = "damage_light";
    }
    if (!isdefined(var_48f82942)) {
        var_48f82942 = 0.1;
    }
    if (!isdefined(n_period)) {
        n_period = 0.1;
    }
    if (!isdefined(n_radius)) {
        n_radius = 2000;
    }
    if (isdefined(var_74584a64)) {
        self endon(var_74584a64);
    }
    self endon(#"death");
    var_c3adecbb = 0;
    for (b_done = 0; !b_done; b_done = var_c3adecbb >= n_timeout) {
        self playrumbleonentity(var_11fed455);
        earthquake(var_48f82942, n_period, self.origin, n_radius);
        wait(n_period);
        if (isdefined(n_timeout) && n_timeout > 0) {
            var_c3adecbb += n_period;
        }
    }
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x1 linked
// Checksum 0x34f94ee5, Offset: 0x2868
// Size: 0xe2
function function_47a62798(var_de243c2) {
    level.var_2fd26037 ai::set_behavior_attribute("cqb", var_de243c2);
    var_3ced446f = function_6ee0e1a5();
    foreach (var_3b8db917 in var_3ced446f) {
        var_3b8db917 ai::set_behavior_attribute("cqb", var_de243c2);
    }
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x1 linked
// Checksum 0x63ce418d, Offset: 0x2958
// Size: 0x132
function function_a5398264(str_mode) {
    level.var_2fd26037 ai::set_behavior_attribute("move_mode", str_mode);
    level.var_9db406db ai::set_behavior_attribute("move_mode", str_mode);
    level.var_4d5a4697 ai::set_behavior_attribute("move_mode", str_mode);
    var_3ced446f = function_6ee0e1a5();
    foreach (var_3b8db917 in var_3ced446f) {
        var_3b8db917 ai::set_behavior_attribute("move_mode", str_mode);
    }
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x1 linked
// Checksum 0x8122f065, Offset: 0x2a98
// Size: 0xea
function function_db027040(var_eb6e3c93) {
    level.var_2fd26037.perfectaim = var_eb6e3c93;
    level.var_9db406db.perfectaim = var_eb6e3c93;
    level.var_4d5a4697.perfectaim = var_eb6e3c93;
    var_3ced446f = function_6ee0e1a5();
    foreach (var_3b8db917 in var_3ced446f) {
        var_3b8db917.perfectaim = var_eb6e3c93;
    }
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x1 linked
// Checksum 0x9b8c579e, Offset: 0x2b90
// Size: 0x92
function function_fcb42941(e_volume) {
    a_players = getplayers();
    var_f04bd8f5 = 0;
    for (i = 0; i < a_players.size; i++) {
        if (a_players[i] istouching(e_volume)) {
            var_f04bd8f5++;
        }
    }
    return var_f04bd8f5;
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x1 linked
// Checksum 0xc5b61d73, Offset: 0x2c30
// Size: 0xac
function function_68b8f4af(e_volume) {
    a_ai = getaiteamarray("axis");
    a_touching = [];
    for (i = 0; i < a_ai.size; i++) {
        if (a_ai[i] istouching(e_volume)) {
            a_touching[a_touching.size] = a_ai[i];
        }
    }
    return a_touching;
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x1 linked
// Checksum 0x9bb4fe63, Offset: 0x2ce8
// Size: 0x52
function function_d1f1caad(str_trigger) {
    e_trigger = getent(str_trigger, "targetname");
    if (isdefined(e_trigger)) {
        e_trigger waittill(#"trigger");
    }
}

// Namespace namespace_2cb3876f
// Params 8, eflags: 0x1 linked
// Checksum 0x603f00d9, Offset: 0x2d48
// Size: 0x414
function function_e0fb6da9(str_struct, close_dist, wait_time, var_d1b83750, max_ai, var_a70db4af, var_1813646e, var_98e9bc46) {
    a_players = getplayers();
    if (a_players.size > 1) {
        return;
    }
    s_struct = struct::get(str_struct, "targetname");
    var_37124366 = getent(var_1813646e, "targetname");
    var_7d22b48e = getent(var_98e9bc46, "targetname");
    v_forward = anglestoforward(s_struct.angles);
    s_struct.start_time = undefined;
    var_cc06a93d = 0;
    while (true) {
        e_player = getplayers()[0];
        v_dir = s_struct.origin - e_player.origin;
        var_989d1f7c = vectordot(v_dir, v_forward);
        if (var_989d1f7c < -100) {
            return;
        }
        dist = distance(s_struct.origin, e_player.origin);
        if (dist < close_dist) {
            if (!isdefined(s_struct.start_time)) {
                s_struct.start_time = gettime();
            }
        } else {
            s_struct.start_time = undefined;
        }
        if (isdefined(s_struct.start_time)) {
            time = gettime();
            dt = (time - s_struct.start_time) / 1000;
            if (dt > wait_time) {
                a_ai = getaiteamarray("axis");
                a_touching = [];
                for (i = 0; i < a_ai.size; i++) {
                    e_ent = a_ai[i];
                    if (!isdefined(e_ent.var_db552f4)) {
                        if (e_ent istouching(var_37124366)) {
                            a_touching[a_touching.size] = e_ent;
                        }
                    }
                }
                var_d6f9eed8 = randomintrange(var_d1b83750, max_ai + 1);
                if (var_d6f9eed8 > a_touching.size) {
                    var_d6f9eed8 = a_touching.size;
                }
                for (i = 0; i < var_d6f9eed8; i++) {
                    a_touching[i] setgoal(var_7d22b48e);
                    a_touching[i].var_db552f4 = 1;
                }
                s_struct.start_time = undefined;
                var_cc06a93d++;
                if (var_cc06a93d >= var_a70db4af) {
                    return;
                }
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x0
// Checksum 0xc814afd3, Offset: 0x3168
// Size: 0xa8
function function_f5363f47(str_trigger) {
    a_triggers = getentarray(str_trigger, "targetname");
    str_notify = str_trigger + "_waiting";
    for (i = 0; i < a_triggers.size; i++) {
        level thread function_7eb8a7ab(a_triggers[i], str_notify);
    }
    level waittill(str_notify);
}

// Namespace namespace_2cb3876f
// Params 2, eflags: 0x1 linked
// Checksum 0x20f40bd9, Offset: 0x3218
// Size: 0x34
function function_7eb8a7ab(e_trigger, str_notify) {
    level endon(str_notify);
    e_trigger waittill(#"trigger");
    level notify(str_notify);
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0xaf85b09, Offset: 0x3258
// Size: 0x1c
function function_25e841ea() {
    if (!isdefined(level.var_c6c69fca)) {
        level.var_c6c69fca = 1;
    }
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x0
// Checksum 0x89790420, Offset: 0x3280
// Size: 0x76
function function_92d5b013(var_dea13075) {
    a_players = getplayers();
    for (i = 0; i < a_players.size; i++) {
        a_players[i] setmovespeedscale(var_dea13075);
    }
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x0
// Checksum 0x8f74d4be, Offset: 0x3300
// Size: 0xa0
function debug_line(e_ent) {
    e_ent endon(#"death");
    while (true) {
        v_start = e_ent.origin;
        v_end = v_start + (0, 0, 1000);
        v_col = (1, 1, 1);
        /#
            line(v_start, v_end, v_col);
        #/
        wait(0.1);
    }
}

// Namespace namespace_2cb3876f
// Params 4, eflags: 0x1 linked
// Checksum 0x9a1f4332, Offset: 0x33a8
// Size: 0x1fc
function function_42da021e(var_c335265b, var_4c026543, var_61e0b19a, var_e3f49331) {
    if (!isdefined(var_e3f49331)) {
        var_e3f49331 = 0;
    }
    var_28290004 = var_c335265b + "_end";
    var_2ef9d306 = vehicle::simple_spawn_single(var_c335265b);
    var_2ef9d306 endon(#"death");
    var_2ef9d306 thread vehicle_rumble("buzz_high", var_28290004, 0.05, 0.1, 5000);
    nd_start = getvehiclenode(var_2ef9d306.target, "targetname");
    var_2ef9d306 attachpath(nd_start);
    if (isdefined(var_4c026543)) {
        if (!isdefined(var_61e0b19a)) {
            var_2ef9d306 setspeed(var_4c026543);
        } else {
            var_2ef9d306 setspeed(var_4c026543, var_61e0b19a);
        }
    }
    if (var_e3f49331) {
        var_2ef9d306 thread function_c56034b7();
    }
    var_2ef9d306 startpath();
    var_2ef9d306 waittill(#"reached_end_node");
    var_2ef9d306 notify(var_28290004);
    var_2ef9d306.delete_on_death = 1;
    var_2ef9d306 notify(#"death");
    if (!isalive(var_2ef9d306)) {
        var_2ef9d306 delete();
    }
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0x51593ea8, Offset: 0x35b0
// Size: 0x64
function function_c56034b7() {
    playfxontag(level._effect["vtol_rotorwash"], self, "tag_engine_left");
    playfxontag(level._effect["vtol_rotorwash"], self, "tag_engine_right");
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x1 linked
// Checksum 0x17055e82, Offset: 0x3620
// Size: 0xd2
function function_950d1c3b(b_enable) {
    if (!isdefined(b_enable)) {
        b_enable = 1;
    }
    var_9dff5377 = b_enable ? 1 : 0;
    foreach (player in level.players) {
        player clientfield::set_to_player("player_tunnel_dust_fx", var_9dff5377);
    }
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0x618401ca, Offset: 0x3700
// Size: 0x34
function function_34acbf2() {
    objectives::complete("cp_level_prologue_locate_the_security_room");
    objectives::complete("cp_level_prologue_security_camera");
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0xf592198c, Offset: 0x3740
// Size: 0x1c
function function_df278013() {
    objectives::complete("cp_level_prologue_free_the_minister");
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0x8c2a8f46, Offset: 0x3768
// Size: 0x1c
function function_9d35b20d() {
    objectives::complete("cp_level_prologue_free_khalil");
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0xd5b75e0a, Offset: 0x3790
// Size: 0x7c
function function_cfabe921() {
    function_34acbf2();
    function_df278013();
    function_9d35b20d();
    objectives::complete("cp_level_prologue_find_vehicle");
    objectives::complete("cp_level_prologue_defend_theia");
    objectives::set("cp_level_prologue_goto_exfil");
}

// Namespace namespace_2cb3876f
// Params 3, eflags: 0x1 linked
// Checksum 0x7957a931, Offset: 0x3818
// Size: 0x214
function function_21f52196(str_door_name, var_b3268be4, var_13aabd08) {
    /#
        assert(isdefined(var_b3268be4), "ally_03");
    #/
    /#
        assert(isdefined(var_b3268be4.target), "ally_03");
    #/
    level endon("stop_door_" + str_door_name);
    t_exit = getent(var_b3268be4.target, "targetname");
    var_b3268be4 thread function_e0f9fe98(str_door_name, 0);
    t_exit thread function_e0f9fe98(str_door_name, 1);
    if (isdefined(var_13aabd08)) {
        var_dee3d10a = getent(var_13aabd08, "targetname");
        /#
            assert(isdefined(var_dee3d10a), "ally_03");
        #/
        var_dee3d10a endon(#"death");
        var_dee3d10a waittill(#"hash_c0b9931e");
        foreach (player in level.players) {
            if (!isdefined(player.a_doors)) {
                player.a_doors = [];
            }
            player.a_doors[str_door_name] = 1;
        }
    }
}

// Namespace namespace_2cb3876f
// Params 3, eflags: 0x1 linked
// Checksum 0x8e318dd5, Offset: 0x3a38
// Size: 0x172
function function_2e61b3e8(str_door_name, var_b3268be4, a_ai) {
    /#
        assert(isdefined(var_b3268be4), "ally_03");
    #/
    /#
        assert(isdefined(var_b3268be4.target), "ally_03");
    #/
    level endon("stop_door_" + str_door_name);
    t_exit = getent(var_b3268be4.target, "targetname");
    if (!isdefined(level.var_40c4c9da)) {
        level.var_40c4c9da = [];
    }
    level.var_40c4c9da[str_door_name] = a_ai;
    foreach (var_5abbae22 in a_ai) {
        t_exit thread function_e010251d(str_door_name, 1, var_5abbae22);
    }
}

// Namespace namespace_2cb3876f
// Params 2, eflags: 0x1 linked
// Checksum 0x7d7abc3b, Offset: 0x3bb8
// Size: 0xa6
function function_e0f9fe98(str_door_name, b_state) {
    level endon("stop_door_" + str_door_name);
    self endon(#"death");
    while (true) {
        e_who = self waittill(#"trigger");
        if (isplayer(e_who)) {
            if (!isdefined(e_who.a_doors)) {
                e_who.a_doors = [];
            }
            e_who.a_doors[str_door_name] = b_state;
        }
    }
}

// Namespace namespace_2cb3876f
// Params 3, eflags: 0x1 linked
// Checksum 0xe1160cc3, Offset: 0x3c68
// Size: 0xf6
function function_e010251d(str_door_name, b_state, var_5abbae22) {
    level endon("stop_door_" + str_door_name);
    self endon(#"death");
    if (!isdefined(var_5abbae22.a_doors)) {
        var_5abbae22.a_doors = [];
    }
    var_5abbae22.a_doors[str_door_name] = 0;
    while (true) {
        e_who = self waittill(#"trigger");
        if (isai(e_who) && e_who == var_5abbae22) {
            if (!isdefined(e_who.a_doors)) {
                e_who.a_doors = [];
            }
            e_who.a_doors[str_door_name] = b_state;
        }
    }
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x1 linked
// Checksum 0xc46a2e05, Offset: 0x3d68
// Size: 0x1e0
function function_cdd726fb(str_door_name) {
    var_83b77796 = 1;
    foreach (player in level.activeplayers) {
        if (!isdefined(player.a_doors) || !isdefined(player.a_doors[str_door_name]) || !player.a_doors[str_door_name]) {
            var_83b77796 = 0;
        }
    }
    if (isdefined(level.var_40c4c9da) && isdefined(level.var_40c4c9da[str_door_name])) {
        foreach (var_5abbae22 in level.var_40c4c9da[str_door_name]) {
            if (!isdefined(var_5abbae22.a_doors) || !isdefined(var_5abbae22.a_doors[str_door_name]) || isalive(var_5abbae22) && !var_5abbae22.a_doors[str_door_name]) {
                var_83b77796 = 0;
            }
        }
    }
    return var_83b77796;
}

// Namespace namespace_2cb3876f
// Params 1, eflags: 0x0
// Checksum 0x53789e04, Offset: 0x3f50
// Size: 0x6c
function function_d990de5a(var_b3268be4) {
    t_exit = getent(var_b3268be4.target, "targetname");
    var_b3268be4 delete();
    t_exit delete();
}

// Namespace namespace_2cb3876f
// Params 3, eflags: 0x1 linked
// Checksum 0x7a6832d0, Offset: 0x3fc8
// Size: 0x5c
function function_d723979e(str_notify, str_model, str_endon) {
    self endon(#"death");
    if (isdefined(str_endon)) {
        level endon(str_endon);
    }
    self waittill(str_notify);
    self setmodel(str_model);
}

// Namespace namespace_2cb3876f
// Params 0, eflags: 0x1 linked
// Checksum 0x628f057d, Offset: 0x4030
// Size: 0x74
function function_72e9bdb8() {
    if (self ishost()) {
        return (self getdstat("highestMapReached") > 0);
    }
    return self getdstat("PlayerStatsByMap", "cp_mi_eth_prologue", "hasBeenCompleted");
}

