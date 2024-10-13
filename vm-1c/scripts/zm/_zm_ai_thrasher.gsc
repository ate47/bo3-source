#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/archetype_thrasher;
#using scripts/zm/_zm_devgui;
#using scripts/shared/flagsys_shared;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_behavior;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/aat_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace zm_ai_thrasher;

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x2
// Checksum 0xc76a15fe, Offset: 0x730
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_ai_thrasher", &__init__, &__main__, undefined);
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0x28b1477c, Offset: 0x778
// Size: 0x64
function __init__() {
    level flag::init("thrasher_round");
    /#
        execdevgui("<dev string:x28>");
        thread function_ae069b1c();
    #/
    init();
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0xf502a7d6, Offset: 0x7e8
// Size: 0x14
function __main__() {
    register_clientfields();
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0x6f795645, Offset: 0x808
// Size: 0x34
function register_clientfields() {
    clientfield::register("actor", "thrasher_mouth_cf", 9000, 8, "int");
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0xa0968e02, Offset: 0x848
// Size: 0x354
function init() {
    precache();
    level.can_revive = &namespace_5d6075c6::function_8259f2c4;
    level.var_11b06c2f = &function_6f6d7a0b;
    level.var_82212ebb = 1;
    level.var_f51fb588 = 0;
    level.var_175273f2 = 1;
    level.var_35a5aa88 = [];
    level.var_b5799c7c = 1;
    level.var_1f0937ce = 1;
    level.var_2f83d088 = 0;
    level.aat["zm_aat_blast_furnace"].immune_result_direct["thrasher"] = 1;
    level.aat["zm_aat_blast_furnace"].immune_result_indirect["thrasher"] = 1;
    level.aat["zm_aat_turned"].immune_trigger["thrasher"] = 1;
    level.aat["zm_aat_fire_works"].immune_trigger["thrasher"] = 1;
    level.aat["zm_aat_thunder_wall"].immune_result_direct["thrasher"] = 1;
    level.aat["zm_aat_thunder_wall"].immune_result_indirect["thrasher"] = 1;
    level.var_feebf312 = [];
    level.var_feebf312 = getentarray("zombie_thrasher_spawner", "script_noteworthy");
    if (level.var_feebf312.size == 0) {
        return;
    }
    array::thread_all(level.var_feebf312, &spawner::add_spawn_function, &function_a716de1f);
    scene::add_scene_func("scene_zm_dlc2_thrasher_transform_thrasher", &function_1c624caf, "done");
    scene::add_scene_func("scene_zm_dlc2_thrasher_transform_zombie", &function_1c624caf, "done");
    scene::add_scene_func("scene_zm_dlc2_thrasher_transform_zombie_friendly", &function_1c624caf, "done");
    scene::add_scene_func("scene_zm_dlc2_thrasher_teleport_out", &function_1c624caf, "done");
    scene::add_scene_func("scene_zm_dlc2_thrasher_teleport_in_v1", &function_1c624caf, "done");
    scene::add_scene_func("scene_zm_dlc2_thrasher_attack_swing_swipe", &function_1c624caf, "done");
    level thread function_10d1beae();
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0xab176f81, Offset: 0xba8
// Size: 0x34
function function_10d1beae() {
    level endon(#"end_game");
    while (true) {
        level waittill(#"end_of_round");
        level.var_2f83d088 = 0;
    }
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0x6d962e8d, Offset: 0xbe8
// Size: 0x58
function function_e2049637(var_5d1c220e) {
    if (!isdefined(var_5d1c220e)) {
        var_5d1c220e = 30;
    }
    level notify(#"hash_5e591bf9");
    level endon(#"hash_5e591bf9");
    level.var_b5799c7c = 0;
    wait var_5d1c220e;
    level.var_b5799c7c = 1;
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xc48
// Size: 0x4
function precache() {
    
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0xe2378bd6, Offset: 0xc58
// Size: 0x44
function function_5e5433d8() {
    level.var_f51fb588 = 1;
    if (!isdefined(level.var_fc6fe2e6)) {
        level.var_fc6fe2e6 = &function_8aac3fe;
    }
    level thread [[ level.var_fc6fe2e6 ]]();
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0xa1384080, Offset: 0xca8
// Size: 0x210
function function_8aac3fe() {
    level.var_175273f2 = 1;
    level.var_e51f5b82 = 0;
    level.var_ebc4830 = level.round_number + randomintrange(4, 7);
    while (true) {
        level waittill(#"between_round_over");
        level.var_e51f5b82 = 0;
        if (isdefined(level.var_3013498) && level.round_number == level.var_3013498) {
            level.var_ebc4830 += 1;
            continue;
        }
        if (level flag::exists("connect_bunker_exterior_to_bunker_interior")) {
            if (level.round_number === level.var_ebc4830 && !level flag::get("connect_bunker_exterior_to_bunker_interior")) {
                level.var_ebc4830 += 1;
                continue;
            }
        }
        if (level.round_number === level.var_ebc4830 && level.round_number - level.var_1f0937ce <= 3) {
            level.var_ebc4830 += 1;
            continue;
        }
        if (level.round_number == level.var_ebc4830) {
            level.var_ebc4830 = level.round_number + 3;
            level thread function_8b7e4b15();
            level flag::set("thrasher_round");
            level waittill(#"end_of_round");
            level flag::clear("thrasher_round");
            level.var_175273f2++;
            /#
                iprintln("<dev string:x48>" + level.var_ebc4830);
            #/
        }
    }
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0x7d352790, Offset: 0xec0
// Size: 0x134
function function_8b7e4b15() {
    level endon(#"end_of_round");
    var_d1cba433 = [];
    while (true) {
        var_d1cba433 = zombie_utility::get_zombie_array();
        if (var_d1cba433.size >= 4) {
            break;
        }
        wait 0.5;
    }
    switch (level.players.size) {
    case 1:
        var_30227ea9 = 2;
        break;
    case 2:
        var_30227ea9 = 2;
        break;
    case 3:
        var_30227ea9 = 3;
        break;
    case 4:
        var_30227ea9 = 4;
        break;
    default:
        var_30227ea9 = 2;
        break;
    }
    for (i = 0; i < var_30227ea9; i++) {
        spawn_thrasher();
        wait 30;
    }
}

// Namespace zm_ai_thrasher
// Params 3, eflags: 0x1 linked
// Checksum 0xf46a3e79, Offset: 0x1000
// Size: 0xa2
function function_6f6d7a0b(e_revivee, ignore_sight_checks, ignore_touch_checks) {
    if (!isdefined(ignore_sight_checks)) {
        ignore_sight_checks = 0;
    }
    if (!isdefined(ignore_touch_checks)) {
        ignore_touch_checks = 0;
    }
    if (isdefined(e_revivee.var_9d35623c) && e_revivee.var_9d35623c) {
        if (!isdefined(e_revivee.revivetrigger)) {
            return 0;
        }
        return 1;
    }
    return self zm_laststand::can_revive(e_revivee, ignore_sight_checks, ignore_touch_checks);
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0xaa3544e, Offset: 0x10b0
// Size: 0x1a0
function function_6d24956b(v_origin) {
    if (isdefined(v_origin)) {
        if (!zm_utility::check_point_in_playable_area(v_origin)) {
            return false;
        }
    }
    if (level.var_2f83d088 >= 2 && level.players.size == 1 && level.round_number < 20) {
        return false;
    }
    if (level.round_number < 4) {
        return false;
    }
    if (level.round_number < 7) {
        if (level flag::exists("connect_bunker_exterior_to_bunker_interior") && !level flag::get("connect_bunker_exterior_to_bunker_interior")) {
            if (level.var_35a5aa88.size >= 1) {
                return false;
            }
        }
    }
    switch (level.players.size) {
    case 1:
        if (level.var_35a5aa88.size < 2) {
            return true;
        }
        break;
    case 2:
        if (level.var_35a5aa88.size < 2) {
            return true;
        }
        break;
    case 3:
        if (level.var_35a5aa88.size < 3) {
            return true;
        }
        break;
    case 4:
        if (level.var_35a5aa88.size < 4) {
            return true;
        }
        break;
    default:
        return false;
    }
    return false;
}

// Namespace zm_ai_thrasher
// Params 2, eflags: 0x0
// Checksum 0xd194928c, Offset: 0x1258
// Size: 0x1ae
function function_68ee76ee(var_d1cba433, var_48cf4a3d) {
    if (!isdefined(var_48cf4a3d)) {
        var_48cf4a3d = 1;
    }
    level endon(#"end_of_round");
    assert(var_d1cba433.size >= var_48cf4a3d, "<dev string:x5e>");
    for (i = 0; i < var_48cf4a3d; i++) {
        var_a4ef4373 = undefined;
        while (!isdefined(var_a4ef4373)) {
            foreach (ai in var_d1cba433) {
                if (function_cb4aac76(ai)) {
                    var_a4ef4373 = ai;
                    break;
                }
            }
            wait 0.5;
        }
        if (isalive(var_a4ef4373)) {
            if (function_6d24956b()) {
                var_e3372b59 = function_8b323113(var_a4ef4373);
                arrayremovevalue(var_d1cba433, var_a4ef4373);
            }
        }
    }
}

// Namespace zm_ai_thrasher
// Params 4, eflags: 0x1 linked
// Checksum 0x46516ec0, Offset: 0x1410
// Size: 0x51a
function function_8b323113(var_a4ef4373, var_42fbb5b1, var_ab0dd5e8, var_be10dc4f) {
    if (!isdefined(var_42fbb5b1)) {
        var_42fbb5b1 = 1;
    }
    if (!isdefined(var_ab0dd5e8)) {
        var_ab0dd5e8 = 1;
    }
    if (!isdefined(var_be10dc4f)) {
        var_be10dc4f = 0;
    }
    level endon(#"end_of_round");
    var_30f9e367 = "scene_zm_dlc2_thrasher_transform_zombie";
    if (var_be10dc4f) {
        var_30f9e367 = "scene_zm_dlc2_thrasher_transform_zombie_friendly";
    }
    while (!(isdefined(var_a4ef4373.zombie_init_done) && var_a4ef4373.zombie_init_done)) {
        wait 0.05;
    }
    if (isdefined(var_a4ef4373.var_61f7b3a0) && var_a4ef4373.var_61f7b3a0) {
        return;
    }
    if (isdefined(var_a4ef4373.var_cbbe29a9) && var_a4ef4373.var_cbbe29a9) {
        return;
    }
    if (var_ab0dd5e8) {
        if (!level.var_b5799c7c) {
            return;
        }
    }
    if (!function_6d24956b(var_a4ef4373.origin) && var_42fbb5b1) {
        return;
    }
    if (isalive(var_a4ef4373)) {
        var_a4ef4373.var_34d00e7 = 1;
        if (var_be10dc4f == 0) {
            level notify(#"hash_49c2b21f", var_a4ef4373);
        } else {
            level notify(#"hash_de7b8073", var_a4ef4373);
        }
        e_align = util::spawn_model("tag_origin", var_a4ef4373.origin, var_a4ef4373.angles);
        e_align thread scene::play(var_30f9e367, var_a4ef4373);
        var_a4ef4373 util::waittill_notify_or_timeout("spawn_thrasher", 4);
    }
    if (isalive(var_a4ef4373)) {
        if (!function_6d24956b(var_a4ef4373.origin) && var_42fbb5b1) {
            return;
        }
        var_e3372b59 = zombie_utility::spawn_zombie(level.var_feebf312[0], "thrasher");
        if (!isdefined(var_e3372b59)) {
            return;
        }
        v_origin = var_a4ef4373.origin;
        v_angles = var_a4ef4373.angles;
        var_e3372b59 forceteleport(v_origin, v_angles, 1, 1);
        if (var_be10dc4f) {
            var_e3372b59 ai::set_behavior_attribute("move_mode", "friendly");
        }
        a_ai_zombies = getaiarchetypearray("zombie", "axis");
        foreach (ai_zombie in a_ai_zombies) {
            if (isalive(ai_zombie) && !(isdefined(ai_zombie.var_3f6ea790) && ai_zombie.var_3f6ea790) && ai_zombie != var_a4ef4373) {
                var_ee9aed61 = 60 * 60;
                if (distancesquared(ai_zombie.origin, var_e3372b59.origin) <= var_ee9aed61) {
                    namespace_5d6075c6::function_6f5adf20(var_e3372b59, ai_zombie);
                }
            }
        }
        var_ab201dd8 = util::spawn_model("tag_origin", var_e3372b59.origin, var_e3372b59.angles);
        var_ab201dd8 thread scene::play("scene_zm_dlc2_thrasher_transform_thrasher", var_e3372b59);
        level.var_1f0937ce = level.round_number;
        level thread function_e2049637();
        return var_e3372b59;
    }
}

// Namespace zm_ai_thrasher
// Params 2, eflags: 0x1 linked
// Checksum 0xca2ed3b6, Offset: 0x1938
// Size: 0x2c
function function_1c624caf(a_ents, e_align) {
    self zm_utility::self_delete();
}

// Namespace zm_ai_thrasher
// Params 3, eflags: 0x1 linked
// Checksum 0x1eeeecb6, Offset: 0x1970
// Size: 0x260
function function_bf8a850e(v_origin, weapon, e_attacker) {
    if (isdefined(level.var_d6539691)) {
        self thread [[ level.var_d6539691 ]](v_origin, weapon, e_attacker);
        return;
    }
    var_d454b8fe = 0;
    var_29d3165e = gettime();
    var_94f86cd2 = 60 * 60;
    var_5ce805c5 = 36;
    while (var_29d3165e + 5000 > gettime()) {
        if (level.var_e51f5b82 < 2) {
            zombies = getaiarchetypearray("zombie", "axis");
            foreach (zombie in zombies) {
                if (isdefined(zombie) && isalive(zombie)) {
                    var_c494d994 = (zombie.origin[0], zombie.origin[1], zombie.origin[2] + var_5ce805c5);
                    if (distancesquared(var_c494d994, v_origin) <= var_94f86cd2) {
                        if (0.2 >= randomfloat(1) && function_cb4aac76(zombie)) {
                            level.var_e51f5b82++;
                            var_d454b8fe++;
                            function_8b323113(zombie);
                        }
                    }
                    if (var_d454b8fe >= 2) {
                        return;
                    }
                }
            }
        }
        wait 0.5;
    }
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0x25516a5f, Offset: 0x1bd8
// Size: 0x18a
function spawn_thrasher(var_42fbb5b1) {
    if (!isdefined(var_42fbb5b1)) {
        var_42fbb5b1 = 1;
    }
    if (!function_6d24956b() && var_42fbb5b1) {
        return;
    }
    s_loc = function_22338aad();
    var_e3372b59 = zombie_utility::spawn_zombie(level.var_feebf312[0], "thrasher", s_loc);
    if (isdefined(var_e3372b59) && isdefined(s_loc)) {
        var_e3372b59 forceteleport(s_loc.origin, s_loc.angles);
        playsoundatposition("zmb_vocals_thrash_spawn", var_e3372b59.origin);
        if (!var_e3372b59 zm_utility::in_playable_area()) {
            player = array::random(level.players);
            if (zm_utility::is_player_valid(player, 0, 1)) {
                var_e3372b59 thread function_89976d94(player.origin);
            }
        }
        return var_e3372b59;
    }
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0xb226b203, Offset: 0x1d70
// Size: 0x23c
function function_89976d94(v_pos) {
    self endon(#"death");
    var_2e57f81c = util::spawn_model("tag_origin", self.origin, self.angles);
    var_2e57f81c thread scene::play("scene_zm_dlc2_thrasher_teleport_out", self);
    self util::waittill_notify_or_timeout("thrasher_teleport_out_done", 4);
    a_v_points = util::positionquery_pointarray(v_pos, -128, 750, 32, 64, self);
    if (isdefined(self.var_466626c4)) {
        a_v_points = self [[ self.var_466626c4 ]](a_v_points);
    }
    var_72436e1a = arraygetfarthest(v_pos, a_v_points);
    if (isdefined(var_72436e1a)) {
        v_dir = v_pos - var_72436e1a;
        v_dir = vectornormalize(v_dir);
        v_angles = vectortoangles(v_dir);
        var_948d85e3 = util::spawn_model("tag_origin", var_72436e1a, v_angles);
        var_2e57f81c scene::stop("scene_zm_dlc2_thrasher_teleport_out");
        var_948d85e3 thread scene::play("scene_zm_dlc2_thrasher_teleport_in_v1", self);
        return;
    }
    var_948d85e3 = util::spawn_model("tag_origin", v_pos, (0, 0, 0));
    var_2e57f81c scene::stop("scene_zm_dlc2_thrasher_teleport_out");
    var_948d85e3 thread scene::play("scene_zm_dlc2_thrasher_teleport_in_v1", self);
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0x4ab3f3b9, Offset: 0x1fb8
// Size: 0xc0
function function_22338aad() {
    var_38efd13c = level.zm_loc_types["thrasher_location"];
    for (i = 0; i < var_38efd13c.size; i++) {
        if (isdefined(level.var_46a39590) && level.var_46a39590 == var_38efd13c[i]) {
            continue;
        }
        s_spawn_loc = var_38efd13c[i];
        level.var_46a39590 = s_spawn_loc;
        return s_spawn_loc;
    }
    s_spawn_loc = var_38efd13c[0];
    level.var_46a39590 = s_spawn_loc;
    return s_spawn_loc;
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0x8886d955, Offset: 0x2080
// Size: 0x574
function function_a716de1f() {
    self.var_61f7b3a0 = 1;
    zombiehealth = level.zombie_health;
    if (!isdefined(zombiehealth)) {
        zombiehealth = level.zombie_vars["zombie_health_start"];
    }
    if (level.round_number <= 50) {
        self.maxhealth = zombiehealth * 10;
    } else if (level.round_number <= 70) {
        n_round = level.round_number;
        var_84e68afa = 10 - (n_round - 50) * 0.35;
        self.maxhealth = int(zombiehealth * var_84e68afa);
    } else {
        self.maxhealth = zombiehealth * 3;
    }
    if (!isdefined(self.maxhealth) || self.maxhealth <= 0 || self.maxhealth > 2147483647 || self.maxhealth != self.maxhealth) {
        self.maxhealth = zombiehealth;
    }
    self.health = self.maxhealth;
    self.var_e1f82635 = level.round_number;
    self.var_9b2031fc = &zm_utility::get_closest_valid_player;
    self.var_c1f12967 = &function_5185e56a;
    self.var_fc6aa17 = &function_7febcbb3;
    self.var_b3800086 = &function_bf8a850e;
    self.var_f39a7dbc = &function_70622dc9;
    self.nuke_damage_func = &function_7cec0046;
    self.var_362e85a0 = &function_4912c054;
    self.var_5622f976 = &function_565fed9e;
    self.var_69262db7 = &function_eeeff8b3;
    self.var_61d546f4 = &function_7a8dca06;
    self.var_e4e88c0d = &function_fb5d97db;
    self.var_5e066a4e = &function_bda057d1;
    self.var_87097485 = &function_a2c48487;
    self.var_8c38eef8 = &function_d95f74d1;
    self.var_67a1573a = &zm_behavior::zombieattackableobjectservice;
    self.var_7ee63f72 = &function_a7b4c742;
    self.var_7430d3e0 = &function_a7b4c742;
    self.tesla_damage_func = &function_bd6d26aa;
    self.var_466626c4 = &function_82522cfc;
    self zombie_utility::zombie_eye_glow_stop();
    self thread zm::update_zone_name();
    foreach (var_278bf215 in self.var_64d28ed0) {
        var_278bf215.health = zombiehealth * 2;
        if (!isdefined(var_278bf215.health) || var_278bf215.health <= 0 || var_278bf215.health > 2147483647 || var_278bf215.health != var_278bf215.health) {
            var_278bf215.health = zombiehealth;
        }
        var_278bf215.maxhealth = var_278bf215.health;
    }
    self.no_gib = 1;
    self.head_gibbed = 1;
    self.missinglegs = 0;
    self.b_ignore_cleanup = 1;
    self thread function_871a3bd5();
    self thread function_632dead();
    if (!isdefined(level.var_35a5aa88)) {
        level.var_35a5aa88 = [];
    } else if (!isarray(level.var_35a5aa88)) {
        level.var_35a5aa88 = array(level.var_35a5aa88);
    }
    level.var_35a5aa88[level.var_35a5aa88.size] = self;
    level.var_2f83d088++;
    level thread zm_spawner::zombie_death_event(self);
}

// Namespace zm_ai_thrasher
// Params 2, eflags: 0x1 linked
// Checksum 0x6368fd94, Offset: 0x2600
// Size: 0x14
function function_bd6d26aa(v_origin, player) {
    
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0x2d86c7b, Offset: 0x2620
// Size: 0xbe
function function_cb4aac76(zombie) {
    if (isdefined(zombie) && isalive(zombie) && zombie isonground() && zombie.archetype == "zombie" && !zombie isplayinganimscripted() && zm_utility::check_point_in_playable_area(zombie.origin) && function_eeeff8b3(zombie.origin)) {
        return true;
    }
    return false;
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0x2f9248f4, Offset: 0x26e8
// Size: 0x11c
function function_82522cfc(a_v_points) {
    var_ba9cdbc3 = [];
    foreach (v_point in a_v_points) {
        if (zm_utility::check_point_in_enabled_zone(v_point, 1) && function_eeeff8b3(v_point)) {
            if (!isdefined(var_ba9cdbc3)) {
                var_ba9cdbc3 = [];
            } else if (!isarray(var_ba9cdbc3)) {
                var_ba9cdbc3 = array(var_ba9cdbc3);
            }
            var_ba9cdbc3[var_ba9cdbc3.size] = v_point;
        }
    }
    return var_ba9cdbc3;
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0xda3fe283, Offset: 0x2810
// Size: 0x5c
function function_7cec0046() {
    if (!zm_utility::is_magic_bullet_shield_enabled(self)) {
        self dodamage(self.health / 2, self.origin);
        namespace_5d6075c6::function_6c2bbf66(self);
    }
}

// Namespace zm_ai_thrasher
// Params 2, eflags: 0x1 linked
// Checksum 0x171c61a0, Offset: 0x2878
// Size: 0x9c
function function_a7b4c742(player, gib) {
    if (!zm_utility::is_magic_bullet_shield_enabled(self)) {
        self dodamage(10, player.origin, player, player, "head", "MOD_IMPACT");
        self dodamage(3000, player.origin, player, player);
    }
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0xc4c9c89f, Offset: 0x2920
// Size: 0x332
function function_74b91821(entity) {
    var_6a9eb5b0 = zombie_utility::get_zombie_array();
    var_e38f15ea = arraysortclosest(var_6a9eb5b0, entity.origin, 5, 50, 96);
    foreach (zombie in var_e38f15ea) {
        if (isdefined(zombie.var_9d35623c) && (isdefined(zombie.missinglegs) && (isdefined(zombie.var_3f6ea790) && (isdefined(zombie.knockdown) && (!isdefined(zombie) || zombie.knockdown) || zombie.var_3f6ea790) || zombie.missinglegs) || zombie.var_9d35623c) || zombie isragdoll()) {
            continue;
        }
        if (abs(zombie.origin[2] - entity.origin[2]) > 18) {
            continue;
        }
        forward = anglestoforward(entity.angles);
        forward = (forward[0], forward[1], 0);
        forward = vectornormalize(forward);
        var_537120b8 = zombie.origin - entity.origin;
        var_537120b8 = (var_537120b8[0], var_537120b8[1], 0);
        var_537120b8 = vectornormalize(var_537120b8);
        if (isalive(zombie) && zombie.archetype == "zombie" && zombie !== entity && !zombie isplayinganimscripted() && vectordot(forward, var_537120b8) >= 0.9063 && zm_utility::check_point_in_playable_area(zombie.origin)) {
            return zombie;
        }
    }
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0xb9a31009, Offset: 0x2c60
// Size: 0x4c
function function_7febcbb3(entity) {
    if (isdefined(entity.var_9aee6feb) && entity.var_9aee6feb) {
        return false;
    }
    return isdefined(function_74b91821(entity));
}

// Namespace zm_ai_thrasher
// Params 2, eflags: 0x1 linked
// Checksum 0xa4bc204a, Offset: 0x2cb8
// Size: 0x1ac
function function_7dfa2cf1(entity, zombie) {
    zombie.allowdeath = 0;
    zombie.b_ignore_cleanup = 1;
    zombie.var_9d35623c = 1;
    var_d30f1cde = anglestoforward(zombie.angles);
    entityforward = anglestoforward(entity.angles);
    if (vectordot(var_d30f1cde, entityforward) > 0) {
        entity thread scene::play("scene_zm_dlc2_thrasher_eat_f_zombie", array(entity, zombie));
    } else {
        entity thread scene::play("scene_zm_dlc2_thrasher_eat_b_zombie", array(entity, zombie));
    }
    zombie util::waittill_notify_or_timeout("hide_zombie", 5);
    if (isdefined(zombie)) {
        zombie.allowdeath = 1;
        zombie hide();
        zombie kill();
        entity namespace_5d6075c6::function_15256ff0(entity);
    }
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0x8a6896f6, Offset: 0x2e70
// Size: 0x64
function function_5185e56a(entity) {
    var_650c1f8b = function_74b91821(entity);
    if (isdefined(var_650c1f8b)) {
        entity thread function_7dfa2cf1(entity, var_650c1f8b);
        return true;
    }
    return false;
}

// Namespace zm_ai_thrasher
// Params 3, eflags: 0x1 linked
// Checksum 0x87622972, Offset: 0x2ee0
// Size: 0xd4
function function_d2ac7b69(entity, player, state) {
    if (isdefined(entity) && isdefined(player)) {
        entitynumber = player getentitynumber();
        var_4b5ca201 = entity clientfield::get("thrasher_mouth_cf");
        var_4b5ca201 &= ~(3 << entitynumber * 2);
        var_4b5ca201 |= state << entitynumber * 2;
        entity clientfield::set("thrasher_mouth_cf", var_4b5ca201);
    }
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0x6c37455, Offset: 0x2fc0
// Size: 0x34
function function_a2c48487(entity) {
    function_d2ac7b69(entity, entity.var_49fb81d5, 3);
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0x38ee31f1, Offset: 0x3000
// Size: 0x34
function function_d95f74d1(entity) {
    function_d2ac7b69(entity, entity.var_49fb81d5, 2);
}

// Namespace zm_ai_thrasher
// Params 2, eflags: 0x1 linked
// Checksum 0xddd3eee6, Offset: 0x3040
// Size: 0x34
function function_fb5d97db(entity, player) {
    function_d2ac7b69(entity, player, 2);
}

// Namespace zm_ai_thrasher
// Params 2, eflags: 0x1 linked
// Checksum 0xbff37645, Offset: 0x3080
// Size: 0x34
function function_bda057d1(entity, player) {
    function_d2ac7b69(entity, player, 0);
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0x588da4ac, Offset: 0x30c0
// Size: 0x36
function function_7a8dca06(entity) {
    if (!zm_utility::check_point_in_playable_area(entity.origin)) {
        return false;
    }
    return true;
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0xd5f32cc, Offset: 0x3100
// Size: 0x8c
function function_4912c054(hitentity) {
    entity = self;
    if (isdefined(hitentity) && isactor(hitentity) && entity.team == "allies") {
        hitentity clientfield::increment("zm_nuked");
        hitentity kill();
    }
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0xecb02358, Offset: 0x3198
// Size: 0x29c
function function_565fed9e(entity) {
    entity endon(#"death");
    if (isdefined(entity) && isalive(entity)) {
        entity.var_a5db58c6 = 1;
        function_d2ac7b69(entity, entity.var_49fb81d5, 3);
        if (isdefined(entity.var_49fb81d5)) {
            entity.var_49fb81d5 thread lui::screen_fade_out(1.5);
        }
        var_f40f14b3 = util::spawn_model("tag_origin", entity.origin, entity.angles);
        var_f40f14b3 thread scene::play("scene_zm_dlc2_thrasher_teleport_out", entity);
        entity util::waittill_notify_or_timeout("hide_ai", 4);
        entity hide();
    }
    if (isdefined(entity) && isalive(entity)) {
        namespace_5d6075c6::thrasherTeleport(entity);
        var_f40f14b3 = util::spawn_model("tag_origin", entity.origin, entity.angles);
        var_f40f14b3 thread scene::play("scene_zm_dlc2_thrasher_teleport_in_v1", entity);
        entity util::waittill_notify_or_timeout("show_ai", 4);
        entity show();
        entity util::waittill_notify_or_timeout("show_player", 4);
        function_d2ac7b69(entity, entity.var_49fb81d5, 2);
        if (isdefined(entity.var_49fb81d5)) {
            entity.var_49fb81d5 thread lui::screen_fade_in(2);
        }
        entity.var_a5db58c6 = 0;
    }
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0xae82088b, Offset: 0x3440
// Size: 0xcc
function function_70622dc9() {
    zm_behavior::findzombieenemy();
    if (!isdefined(self.favoriteenemy) && isdefined(self.owner)) {
        if (isdefined(self.owner)) {
            queryresult = positionquery_source_navigation(self.owner.origin, -128, 256, -128, 20);
            if (isdefined(queryresult) && queryresult.data.size > 0) {
                self setgoal(queryresult.data[0].origin);
            }
        }
    }
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0xfbcfdddb, Offset: 0x3518
// Size: 0x170
function function_871a3bd5() {
    e_attacker = self waittill(#"death");
    arrayremovevalue(level.var_35a5aa88, self);
    if (isplayer(e_attacker)) {
        if (!(isdefined(self.deathpoints_already_given) && self.deathpoints_already_given)) {
            e_attacker zm_score::player_add_points("death_thrasher", self.damagemod, self.damagelocation, 1);
        }
        if (isdefined(level.hero_power_update)) {
            [[ level.hero_power_update ]](e_attacker, self);
        }
        if (randomintrange(0, 100) >= 80) {
            e_attacker zm_audio::create_and_play_dialog("kill", "thrashers");
        }
        e_attacker zm_stats::increment_client_stat("zthrashers_killed");
        e_attacker zm_stats::increment_player_stat("zthrashers_killed");
    }
    if (isdefined(e_attacker) && isai(e_attacker)) {
        e_attacker notify(#"killed", self);
    }
}

// Namespace zm_ai_thrasher
// Params 0, eflags: 0x1 linked
// Checksum 0xf6ed57db, Offset: 0x3690
// Size: 0xa0
function function_632dead() {
    self endon(#"death");
    self playloopsound("zmb_thrasher_lp_close", 2);
    wait randomintrange(2, 5);
    while (true) {
        self playsoundontag("zmb_vocals_thrash_ambient", "j_head");
        level notify(#"hash_9b1446c2", self);
        wait randomintrange(3, 9);
    }
}

// Namespace zm_ai_thrasher
// Params 1, eflags: 0x1 linked
// Checksum 0x4917826c, Offset: 0x3738
// Size: 0xd8
function function_eeeff8b3(origin) {
    no_teleport_area = getentarray("no_teleport_area", "script_noteworthy");
    if (!isdefined(level.check_model)) {
        level.check_model = spawn("script_model", origin);
    } else {
        level.check_model.origin = origin;
    }
    for (i = 0; i < no_teleport_area.size; i++) {
        if (level.check_model istouching(no_teleport_area[i])) {
            return false;
        }
    }
    return true;
}

/#

    // Namespace zm_ai_thrasher
    // Params 0, eflags: 0x1 linked
    // Checksum 0x12ee92d5, Offset: 0x3818
    // Size: 0x44
    function function_ae069b1c() {
        level flagsys::wait_till("<dev string:x9f>");
        zm_devgui::add_custom_devgui_callback(&function_da954e93);
    }

    // Namespace zm_ai_thrasher
    // Params 1, eflags: 0x1 linked
    // Checksum 0xeaadc62f, Offset: 0x3868
    // Size: 0x1f6
    function function_11d343a5(thrasher) {
        thrasher notify(#"hash_eafe225a");
        thrasher endon(#"hash_eafe225a");
        thrasher endon(#"death");
        thrasher.ignoreall = 1;
        while (true) {
            queryresult = positionquery_source_navigation(thrasher.origin, 1024, 2024, -128, 20, thrasher);
            var_46b60716 = thrasher.origin;
            var_f749ad3e = 0;
            var_6ab55afd = queryresult.data;
            foreach (point in var_6ab55afd) {
                disttopointsq = distancesquared(point.origin, thrasher.origin);
                if (disttopointsq > var_f749ad3e && zm_utility::check_point_in_playable_area(point.origin)) {
                    var_f749ad3e = disttopointsq;
                    var_46b60716 = point.origin;
                }
            }
            thrasher setgoal(var_46b60716);
            thrasher waittill(#"goal");
        }
    }

    // Namespace zm_ai_thrasher
    // Params 1, eflags: 0x1 linked
    // Checksum 0x9a71b758, Offset: 0x3a68
    // Size: 0x30
    function function_eafe225a(thrasher) {
        thrasher.ignoreall = 0;
        thrasher notify(#"hash_eafe225a");
    }

    // Namespace zm_ai_thrasher
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd9467036, Offset: 0x3aa0
    // Size: 0xd4
    function function_13a79919() {
        thrashers = getaiarchetypearray("<dev string:xb8>");
        players = getplayers();
        if (players.size > 0 && thrashers.size > 0) {
            thrasher = arraygetclosest(players[0].origin, thrashers);
            if (isdefined(thrasher) && zm_utility::check_point_in_playable_area(thrasher.origin)) {
                return thrasher;
            }
        }
    }

    // Namespace zm_ai_thrasher
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1f22ffa2, Offset: 0x3b80
    // Size: 0x726
    function function_da954e93(cmd) {
        switch (cmd) {
        case "<dev string:xc1>":
            players = getplayers();
            queryresult = positionquery_source_navigation(players[0].origin, -128, 256, -128, 20);
            spot = spawnstruct();
            spot.origin = players[0].origin;
            if (isdefined(queryresult) && queryresult.data.size > 0) {
                spot.origin = queryresult.data[0].origin;
            }
            thrasher = zombie_utility::spawn_zombie(level.var_feebf312[0], "<dev string:xb8>", spot);
            if (isdefined(thrasher)) {
                e_player = zm_utility::get_closest_player(spot.origin);
                v_dir = e_player.origin - spot.origin;
                v_dir = vectornormalize(v_dir);
                v_angles = vectortoangles(v_dir);
                trace = bullettrace(spot.origin, spot.origin + (0, 0, -256), 0, spot);
                var_80f08819 = trace["<dev string:xd0>"];
                var_a6621bfd = var_80f08819;
                thrasher forceteleport(var_a6621bfd, v_angles);
            }
            break;
        case "<dev string:xd9>":
            var_5613e8c5 = getaiarchetypearray("<dev string:xb8>");
            if (var_5613e8c5.size > 0) {
                foreach (thrasher in var_5613e8c5) {
                    thrasher kill();
                }
            }
            break;
        case "<dev string:xe7>":
        case "<dev string:xfa>":
            zombies = getaiarchetypearray("<dev string:x116>");
            players = getplayers();
            if (players.size > 0 && zombies.size > 0) {
                zombie = arraygetclosest(players[0].origin, zombies);
                if (function_cb4aac76(zombie)) {
                    function_8b323113(zombie, 0, 0, cmd == "<dev string:xfa>");
                } else {
                    /#
                        iprintln("<dev string:x11d>");
                    #/
                }
            } else {
                /#
                    iprintln("<dev string:x153>");
                #/
            }
            break;
        case "<dev string:x18c>":
            thrasher = function_13a79919();
            if (isdefined(thrasher)) {
                namespace_5d6075c6::function_6c2bbf66(thrasher);
            }
            break;
        case "<dev string:x19c>":
            thrasher = function_13a79919();
            if (isdefined(thrasher)) {
                thrasher ai::set_behavior_attribute("<dev string:x1b3>", "<dev string:x1bd>");
                players = getplayers();
                if (players.size > 0) {
                    thrasher.owner = players[0];
                }
            }
            break;
        case "<dev string:x1c6>":
            thrasher = function_13a79919();
            players = getplayers();
            if (isdefined(thrasher)) {
                thrasher thread namespace_5d6075c6::function_aaaf7923(thrasher, players[0]);
            }
            break;
        case "<dev string:x1d5>":
            var_5613e8c5 = getaiarchetypearray("<dev string:xb8>");
            if (var_5613e8c5.size > 0) {
                foreach (thrasher in var_5613e8c5) {
                    thrasher thread function_11d343a5(thrasher);
                }
            }
            break;
        case "<dev string:x1ec>":
            var_5613e8c5 = getaiarchetypearray("<dev string:xb8>");
            if (var_5613e8c5.size > 0) {
                foreach (thrasher in var_5613e8c5) {
                    function_eafe225a(thrasher);
                }
            }
            break;
        case "<dev string:x208>":
            spawn_thrasher(0);
            break;
        }
    }

#/
