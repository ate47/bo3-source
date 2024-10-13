#using scripts/zm/zm_island_ww_quest;
#using scripts/zm/zm_island_util;
#using scripts/zm/_zm_weap_mirg2000;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_ai_spiders;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/laststand_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/math_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/codescripts/struct;

#namespace zm_island_spider_quest;

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x85729da2, Offset: 0x1228
// Size: 0x104
function init() {
    level flag::init("spider_lair_webs_destroyed");
    if (!level flag::exists("spider_queen_dead")) {
        level flag::init("spider_queen_dead");
    }
    level thread function_83b9f02b();
    level thread function_2ff7183();
    level thread function_9c86c1bb();
    array::thread_all(getentarray("spider_lair_entrance_webs", "targetname"), &spider_lair_entrance_webs);
    /#
        function_4f46a12();
    #/
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x87b28b31, Offset: 0x1338
// Size: 0x454
function function_83b9f02b() {
    trigger::wait_till("spider_queen_start_fight");
    level.var_4e5986ea = 2;
    level.var_e18ab0f2 = 0;
    level flag::init("spider_queen_spawn_babies");
    level flag::init("spider_queen_weak_spot_exposed");
    level flag::init("spider_queen_perform_leg_attack");
    level flag::init("spider_attack_done");
    level flag::init("spider_baby_round_done");
    level flag::init("spider_baby_round_timeout");
    level flag::init("spider_baby_hit_react");
    level flag::init("spider_queen_perform_spit_attack");
    level flag::init("spider_queen_stage_1");
    level flag::init("spider_queen_stage_2");
    level flag::init("spider_queen_stage_3");
    level flag::init("spider_queen_set_idle");
    level thread function_bccbf63c();
    if (level.players.size > 2) {
        level.var_5bb615cd = 100000;
        level.var_dd315d9c = 80000;
        level.var_f6f57e72 = 40000;
        level.var_7dc3717a = 6;
    } else {
        level.var_5bb615cd = 25000;
        level.var_dd315d9c = 20000;
        level.var_f6f57e72 = 10000;
        level.var_7dc3717a = 3;
    }
    level flag::clear("zombie_drop_powerups");
    var_85683d05 = util::spawn_anim_model("c_zom_dlc2_queen_spider");
    var_85683d05 clientfield::set("spider_queen_emissive_material", 1);
    var_85683d05 thread function_2a9d57ae();
    array::thread_all(getentarray("spider_leg_damage", "targetname"), &function_9d6e8018);
    array::thread_all(getentarray("spider_spit_damage", "targetname"), &function_1b11ad0);
    array::thread_all(getentarray("spider_spit_damage", "targetname"), &function_9ee2204c, var_85683d05);
    var_85683d05 function_c225d3aa();
    var_85683d05 thread function_f0c6c167();
    var_85683d05 thread function_7b31e716();
    var_85683d05 thread function_9b964659();
    var_85683d05 thread function_e2b5f12f();
    var_85683d05 thread function_b6ea5d0d();
    var_85683d05 thread function_e949d1d7();
    level thread function_65c52965();
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xeaaf8c27, Offset: 0x1798
// Size: 0x24
function function_2a9d57ae() {
    self clientfield::set("spider_queen_mouth_weakspot", 2);
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xb92233f0, Offset: 0x17c8
// Size: 0x74
function function_9c86c1bb() {
    level flag::wait_till("spider_lair_webs_destroyed");
    getent("clip_spider_lair_entrance", "targetname") delete();
    level scene::init("p7_fxanim_zm_island_spider_queen_lair_rocks_bundle");
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x1e155d2d, Offset: 0x1848
// Size: 0xc4
function spider_lair_entrance_webs() {
    self setcandamage(1);
    self clientfield::set("set_heavy_web_fade_material", 1);
    self thread function_83953ff7();
    level flag::wait_till("spider_lair_webs_destroyed");
    self clientfield::set("set_heavy_web_fade_material", 0);
    self notsolid();
    wait 3;
    self delete();
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x2eb7ea77, Offset: 0x1918
// Size: 0x158
function function_83953ff7() {
    level endon(#"spider_lair_webs_destroyed");
    while (true) {
        damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags = self waittill(#"damage");
        if (namespace_7cee2b44::is_wonder_weapon(weapon)) {
            if (namespace_7cee2b44::is_wonder_weapon(weapon, "upgraded")) {
                self thread fx::play("special_web_dissolve_ug", self.origin, self.angles);
            } else {
                self thread fx::play("special_web_dissolve", self.origin, self.angles);
            }
            level flag::set("spider_lair_webs_destroyed");
        }
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x43cd6359, Offset: 0x1a78
// Size: 0xf4
function function_c225d3aa() {
    wait 1.5;
    level thread function_f7244a06(1);
    playsoundatposition("zmb_vocals_squeen_roar_start", (-5000, 932, -157));
    wait 1.5;
    level util::delay(1, undefined, &function_f7244a06, 2);
    level util::delay(5.23, undefined, &function_f7244a06, 3);
    level scene::play("cin_t7_ai_zm_dlc2_spider_queen_entrance", self);
    level thread scene::play("cin_t7_ai_zm_dlc2_spider_queen_idle", self);
}

// Namespace zm_island_spider_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x8853e1e5, Offset: 0x1b78
// Size: 0x162
function function_f7244a06(n_index) {
    var_297c6282 = getent("spider_queen_start_fight", "targetname");
    foreach (player in level.players) {
        if (zm_utility::is_player_valid(player) && player istouching(var_297c6282)) {
            if (n_index == 1) {
                player playrumbleonentity("zm_island_rumble_spider_queen_intro_01");
                continue;
            }
            if (n_index == 2) {
                player playrumbleonentity("zm_island_rumble_spider_queen_intro_02");
                continue;
            }
            player playrumbleonentity("zm_island_rumble_spider_queen_intro_03");
        }
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x8e12b9f9, Offset: 0x1ce8
// Size: 0x54
function function_65c52965() {
    level endon(#"hash_2dc546da");
    /#
        level endon(#"hash_9a8b82c3");
    #/
    function_4af05c8a();
    function_24ede221();
    function_feeb67b8();
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xb213480c, Offset: 0x1d48
// Size: 0xf8
function function_4af05c8a() {
    level endon(#"hash_2dc546da");
    /#
        level endon(#"hash_9a8b82c3");
    #/
    while (level flag::get("spider_queen_stage_1")) {
        function_f033c56a();
        function_f033c56a();
        function_3f6b6cb4();
        function_f033c56a();
        function_57b6770a();
        function_f033c56a();
        function_f033c56a();
        function_3f6b6cb4();
        function_3f6b6cb4();
        function_f033c56a();
        function_57b6770a();
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x85384662, Offset: 0x1e48
// Size: 0xf8
function function_24ede221() {
    level endon(#"hash_2dc546da");
    /#
        level endon(#"hash_9a8b82c3");
    #/
    while (level flag::get("spider_queen_stage_2")) {
        function_3f6b6cb4();
        function_3f6b6cb4();
        function_f033c56a();
        function_f033c56a();
        function_57b6770a();
        function_f033c56a();
        function_3f6b6cb4();
        function_3f6b6cb4();
        function_f033c56a();
        function_f033c56a();
        function_57b6770a();
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x885fd846, Offset: 0x1f48
// Size: 0x128
function function_feeb67b8() {
    level endon(#"hash_2dc546da");
    /#
        level endon(#"hash_9a8b82c3");
    #/
    while (level flag::get("spider_queen_stage_3")) {
        function_f033c56a();
        function_f033c56a();
        function_3f6b6cb4();
        function_3f6b6cb4();
        function_f033c56a();
        function_3f6b6cb4();
        function_57b6770a();
        function_f033c56a();
        function_f033c56a();
        function_3f6b6cb4();
        function_3f6b6cb4();
        function_3f6b6cb4();
        function_f033c56a();
        function_57b6770a();
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x85dcbba4, Offset: 0x2078
// Size: 0x54
function function_f033c56a() {
    level flag::wait_till_clear("spider_queen_set_idle");
    level flag::set("spider_queen_perform_leg_attack");
    function_2152712c();
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xff8c9094, Offset: 0x20d8
// Size: 0x54
function function_3f6b6cb4() {
    level flag::wait_till_clear("spider_queen_set_idle");
    level flag::set("spider_queen_perform_spit_attack");
    function_2152712c();
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x5b7b1fb7, Offset: 0x2138
// Size: 0x64
function function_57b6770a() {
    level flag::wait_till_clear("spider_queen_set_idle");
    if (level.var_e18ab0f2 < level.var_7dc3717a) {
        level flag::set("spider_queen_spawn_babies");
        function_2152712c();
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x33527da0, Offset: 0x21a8
// Size: 0x64
function function_2152712c() {
    level flag::wait_till("spider_attack_done");
    wait randomfloatrange(0.5, 1.5);
    level flag::clear("spider_attack_done");
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x9b418d08, Offset: 0x2218
// Size: 0x164
function function_7b31e716() {
    self thread function_5a50e7f();
    level flag::set("spider_queen_stage_1");
    while (level.var_5bb615cd > level.var_dd315d9c) {
        wait 0.05;
    }
    level flag::clear("spider_queen_stage_1");
    level flag::set("spider_queen_stage_2");
    self function_82ae321c(2);
    while (level.var_5bb615cd > level.var_f6f57e72) {
        wait 0.05;
    }
    level flag::clear("spider_queen_stage_2");
    level flag::set("spider_queen_stage_3");
    self function_82ae321c(3);
    while (level.var_5bb615cd > 0) {
        wait 0.05;
    }
    level flag::set("spider_queen_dead");
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x22e4f2d8, Offset: 0x2388
// Size: 0x1b6
function function_e949d1d7() {
    level endon(#"hash_2dc546da");
    var_297c6282 = getent("spider_queen_start_fight", "targetname");
    while (true) {
        var_c0d42e55 = [];
        foreach (player in level.players) {
            if (zm_utility::is_player_valid(player) && player istouching(var_297c6282)) {
                array::add(var_c0d42e55, player);
            }
        }
        if (var_c0d42e55.size == 0) {
            if (!level flag::get("spider_queen_set_idle")) {
                level flag::set("spider_queen_set_idle");
            }
        } else if (level flag::get("spider_queen_set_idle")) {
            level flag::clear("spider_queen_set_idle");
        }
        var_c0d42e55 = undefined;
        wait 5;
    }
}

// Namespace zm_island_spider_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x7b975dc0, Offset: 0x2548
// Size: 0x2ec
function function_82ae321c(n_stage) {
    /#
        level endon(#"hash_9a8b82c3");
    #/
    level notify(#"hash_c69c8ddc");
    self clientfield::set("spider_queen_stage_bleed", n_stage);
    level flag::clear("spider_queen_weak_spot_exposed");
    if (level flag::get("spider_queen_spawn_babies")) {
        level flag::set("spider_baby_hit_react");
        if (n_stage == 2) {
            level scene::play("cin_t7_ai_zm_dlc2_spider_queen_baby_drop_pain_react_phase_2", self);
        } else {
            level scene::play("cin_t7_ai_zm_dlc2_spider_queen_baby_drop_pain_react_phase_3", self);
        }
        level flag::clear("spider_queen_spawn_babies");
        if (!level flag::get("spider_baby_round_done") || !level flag::get("spider_baby_round_timeout")) {
            level scene::play("cin_t7_ai_zm_dlc2_spider_queen_baby_drop_outro", self);
            level thread scene::play("cin_t7_ai_zm_dlc2_spider_queen_backwall_idle", self);
            level flag::wait_till_any(array("spider_baby_round_done", "spider_baby_round_timeout"));
            level scene::play("cin_t7_ai_zm_dlc2_spider_queen_backwall_outro", self);
        }
    } else {
        if (n_stage == 2) {
            level scene::play("cin_t7_ai_zm_dlc2_spider_queen_arm_attack_pain_react_phase_2", self);
        } else {
            level scene::play("cin_t7_ai_zm_dlc2_spider_queen_arm_attack_pain_react_phase_3", self);
        }
        level flag::clear("spider_queen_perform_leg_attack");
    }
    self thread function_9b964659();
    self thread function_b6ea5d0d();
    level thread scene::play("cin_t7_ai_zm_dlc2_spider_queen_idle", self);
    if (n_stage == 2) {
        level.var_4e5986ea = 3;
    } else {
        level.var_4e5986ea = 4;
    }
    level flag::set("spider_attack_done");
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xf9ff3fbe, Offset: 0x2840
// Size: 0x254
function function_f0c6c167() {
    level flag::wait_till("spider_queen_dead");
    self clientfield::set("spider_queen_stage_bleed", 1);
    level flag::clear("spider_queen_weak_spot_exposed");
    level notify(#"hash_2dc546da");
    level util::clientnotify("sndLair");
    level thread function_7ed6256d();
    self thread function_a38800f6();
    if (level flag::get("spider_queen_spawn_babies")) {
        level scene::play("cin_t7_ai_zm_dlc2_spider_queen_death_from_baby_drop", self);
    } else {
        level scene::play("cin_t7_ai_zm_dlc2_spider_queen_death_from_arm_attack", self);
    }
    self clientfield::set("spider_queen_mouth_weakspot", 0);
    level flag::set("zombie_drop_powerups");
    var_8b5cd120 = getent("volume_thrasher_non_teleport_spider_boss", "targetname");
    var_8b5cd120 delete();
    var_794ac17c = getent("clip_monster_spider_queen_entrance", "targetname");
    var_794ac17c delete();
    level thread function_199d01b5();
    self thread zm_island_ww_quest::function_bc717528();
    self notsolid();
    self notify(#"hash_aaf78b5");
    self clientfield::set("spider_queen_emissive_material", 0);
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x9b45ee2e, Offset: 0x2aa0
// Size: 0x150
function function_a38800f6() {
    self endon(#"hash_aaf78b5");
    var_297c6282 = getent("spider_queen_start_fight", "targetname");
    while (true) {
        foreach (player in level.players) {
            if (zm_utility::is_player_valid(player) && player istouching(var_297c6282)) {
                player playrumbleonentity("tank_damage_heavy_mp");
                earthquake(0.35, 0.5, player.origin, 325);
            }
        }
        wait 0.15;
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xf2829744, Offset: 0x2bf8
// Size: 0x5c
function function_7ed6256d() {
    level thread scene::play("p7_fxanim_zm_island_spider_queen_lair_rocks_bundle");
    wait 4;
    getent("spiderlair_pathblocker", "targetname") notsolid();
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x706a2a70, Offset: 0x2c60
// Size: 0x184
function function_5a50e7f() {
    level endon(#"hash_2dc546da");
    self setcandamage(1);
    while (true) {
        n_damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags = self waittill(#"damage");
        if (partname == "tag_mouth_hit") {
            if (level flag::get("spider_queen_weak_spot_exposed")) {
                if (namespace_7cee2b44::is_wonder_weapon(weapon, "upgraded")) {
                    n_damage = 750;
                } else if (namespace_7cee2b44::is_wonder_weapon(weapon, "default")) {
                    n_damage = 500;
                }
                self clientfield::increment("spider_queen_bleed");
                attacker damagefeedback::update();
                level.var_5bb615cd -= n_damage;
            }
        }
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xb69e6143, Offset: 0x2df0
// Size: 0x64
function spider_queen_weakspot() {
    self clientfield::set("spider_queen_mouth_weakspot", 1);
    level flag::wait_till_clear("spider_queen_weak_spot_exposed");
    self clientfield::set("spider_queen_mouth_weakspot", 2);
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x6b92ffb9, Offset: 0x2e60
// Size: 0xd4
function function_9b964659() {
    level endon(#"hash_2dc546da");
    var_a857d88e = [];
    var_27730eaa = [];
    for (i = 0; i < 5; i++) {
        var_a857d88e[i] = getent("spider_queen_arm_0" + i, "targetname");
        var_27730eaa[i] = getent("spider_leg_damage_0" + i, "targetname");
    }
    self thread function_291b262e(var_a857d88e, var_27730eaa);
}

// Namespace zm_island_spider_quest
// Params 2, eflags: 0x1 linked
// Checksum 0x962500ae, Offset: 0x2f40
// Size: 0x420
function function_291b262e(var_a857d88e, var_27730eaa) {
    level endon(#"hash_2dc546da");
    level endon(#"hash_c69c8ddc");
    var_dc084637 = [];
    var_6a00d6fc = [];
    var_90035165 = [];
    array::add(var_dc084637, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_a_1_3");
    array::add(var_dc084637, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_a_1_4");
    array::add(var_dc084637, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_a_2_3");
    array::add(var_dc084637, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_a_3_1");
    array::add(var_dc084637, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_a_4_2");
    array::add(var_6a00d6fc, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_b_1_4_2");
    array::add(var_6a00d6fc, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_b_2_3_1");
    array::add(var_6a00d6fc, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_b_3_1_4");
    array::add(var_6a00d6fc, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_b_3_4_2");
    array::add(var_6a00d6fc, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_b_4_1_3");
    array::add(var_90035165, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_c_1_3_4_2");
    array::add(var_90035165, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_c_2_3_1_4");
    array::add(var_90035165, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_c_3_1_2_4");
    array::add(var_90035165, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_c_4_1_3_2");
    array::add(var_90035165, "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_c_4_2_1_3");
    while (true) {
        level flag::wait_till("spider_queen_perform_leg_attack");
        level scene::play("cin_t7_ai_zm_dlc2_spider_queen_arm_attack_intro", self);
        level thread scene::play("cin_t7_ai_zm_dlc2_spider_queen_arm_attack_loop", self);
        level flag::set("spider_queen_weak_spot_exposed");
        self thread spider_queen_weakspot();
        if (level.var_4e5986ea == 2) {
            var_679258c3 = array::random(var_dc084637);
        } else if (level.var_4e5986ea == 3) {
            var_679258c3 = array::random(var_6a00d6fc);
        } else {
            var_679258c3 = array::random(var_90035165);
        }
        level scene::play(var_679258c3, self);
        level scene::play("cin_t7_ai_zm_dlc2_spider_queen_arm_attack_outro", self);
        level thread scene::play("cin_t7_ai_zm_dlc2_spider_queen_idle", self);
        level flag::set("spider_attack_done");
        level flag::clear("spider_queen_weak_spot_exposed");
        level flag::clear("spider_queen_perform_leg_attack");
        wait 0.05;
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x2b4eebe0, Offset: 0x3368
// Size: 0x98
function function_9d6e8018() {
    level endon(#"hash_2dc546da");
    while (true) {
        level waittill(self.script_noteworthy + "_hitground");
        self thread function_9d331ff6();
        a_e_players = self array::get_touching(level.players);
        array::thread_all(a_e_players, &function_8e1549bd);
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x513ac9e, Offset: 0x3408
// Size: 0xec
function function_9d331ff6() {
    s_org = struct::get("spider_leg_hit_" + self.script_noteworthy);
    var_9866f6f9 = util::spawn_model("tag_origin", s_org.origin);
    var_9866f6f9 playrumbleonentity("tank_damage_heavy_mp");
    screenshake(var_9866f6f9.origin, 5, 2, 2, 0.5, 0, -1, -106, 7, 1, 1, 1);
    wait 3;
    var_9866f6f9 delete();
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xb3a3048d, Offset: 0x3500
// Size: 0x54
function function_8e1549bd() {
    self dodamage(90, self.origin, undefined, undefined, undefined, "MOD_MELEE");
    self playrumbleonentity("tank_damage_heavy_mp");
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xaf749f29, Offset: 0x3560
// Size: 0x1e0
function function_e2b5f12f() {
    level endon(#"hash_2dc546da");
    level.var_1bf7f6a1 = [];
    array::add(level.var_1bf7f6a1, "cin_t7_ai_zm_dlc2_spider_queen_attack_spit_straight");
    array::add(level.var_1bf7f6a1, "cin_t7_ai_zm_dlc2_spider_queen_attack_spit_left");
    array::add(level.var_1bf7f6a1, "cin_t7_ai_zm_dlc2_spider_queen_attack_spit_right");
    while (true) {
        level flag::wait_till("spider_queen_perform_spit_attack");
        level flag::set("spider_queen_weak_spot_exposed");
        self thread spider_queen_weakspot();
        var_9c85831c = array::random(level.var_1bf7f6a1);
        level thread function_29454161(var_9c85831c);
        level scene::play(var_9c85831c, self);
        level scene::play("cin_t7_ai_zm_dlc2_spider_queen_arm_attack_outro", self);
        level thread scene::play("cin_t7_ai_zm_dlc2_spider_queen_idle", self);
        level flag::set("spider_attack_done");
        level flag::clear("spider_queen_perform_spit_attack");
        level flag::clear("spider_queen_weak_spot_exposed");
        wait 0.05;
    }
}

// Namespace zm_island_spider_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x3d03abc, Offset: 0x3748
// Size: 0x54
function function_29454161(var_e2556d9e) {
    level endon(#"hash_2dc546da");
    arrayremovevalue(level.var_1bf7f6a1, var_e2556d9e);
    wait 8;
    array::add(level.var_1bf7f6a1, var_e2556d9e);
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x247d0c1, Offset: 0x37a8
// Size: 0xd2
function function_1b11ad0() {
    level endon(#"hash_2dc546da");
    while (true) {
        var_4c01b049 = 8;
        level waittill(self.script_noteworthy + "_spit");
        self playsound("zmb_foley_squeen_spit_impact");
        while (var_4c01b049 > 0) {
            a_e_players = self array::get_touching(level.players);
            array::thread_all(a_e_players, &function_ae6c3ac5);
            var_4c01b049 -= 1;
            wait 1;
        }
    }
}

// Namespace zm_island_spider_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x81528e51, Offset: 0x3888
// Size: 0x188
function function_9ee2204c(var_85683d05) {
    level endon(#"hash_2dc546da");
    var_5ea789b4 = struct::get("spider_spit_org_left");
    s_center = struct::get("spider_spit_org_center");
    var_4ea92c6b = struct::get("spider_spit_org_right");
    while (true) {
        level waittill(self.script_noteworthy + "_spit");
        if (self.script_noteworthy == "left") {
            var_e70fce50 = "fxexp_712";
            var_e066ed22 = var_5ea789b4;
        } else if (self.script_noteworthy == "center") {
            var_e70fce50 = "fxexp_711";
            var_e066ed22 = s_center;
        } else {
            var_e70fce50 = "fxexp_710";
            var_e066ed22 = var_4ea92c6b;
        }
        var_e066ed22 function_bcafc53d(var_85683d05);
        exploder::exploder(var_e70fce50);
        level thread function_fcb8aed2(var_e70fce50);
        var_e066ed22 = undefined;
    }
}

// Namespace zm_island_spider_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x20014c46, Offset: 0x3a18
// Size: 0x1b4
function function_bcafc53d(var_85683d05) {
    s_org = spawn("script_model", var_85683d05 gettagorigin("tag_turret"));
    s_org setmodel("tag_origin");
    s_org enablelinkto();
    s_org fx::play("spider_queen_spit_attack", s_org.origin, undefined, 0.5, 1, "tag_origin");
    s_org moveto(self.origin, 0.5);
    s_org util::waittill_any_timeout(0.5, "movedone");
    self fx::play("spider_queen_spit_impact", self.origin, undefined);
    s_org playrumbleonentity("tank_damage_heavy_mp");
    earthquake(0.35, 0.5, s_org.origin, 325);
    wait 1;
    s_org delete();
}

// Namespace zm_island_spider_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x410d765d, Offset: 0x3bd8
// Size: 0x2c
function function_fcb8aed2(var_e70fce50) {
    wait 8;
    exploder::stop_exploder(var_e70fce50);
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x2f9f1de1, Offset: 0x3c10
// Size: 0x7c
function function_ae6c3ac5() {
    self dodamage(40, self.origin, undefined, undefined, undefined, "MOD_MELEE");
    self shellshock("default", 2);
    self playrumbleonentity("tank_damage_heavy_mp");
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x9d47804, Offset: 0x3c98
// Size: 0x408
function function_b6ea5d0d() {
    level endon(#"hash_2dc546da");
    level endon(#"hash_c69c8ddc");
    level thread function_9a7e7358();
    while (true) {
        level flag::wait_till("spider_queen_spawn_babies");
        level scene::play("cin_t7_ai_zm_dlc2_spider_queen_baby_drop_intro", self);
        level thread scene::play("cin_t7_ai_zm_dlc2_spider_queen_baby_drop_loop", self);
        level flag::set("spider_queen_weak_spot_exposed");
        level flag::clear("spider_baby_round_done");
        level flag::clear("spider_baby_round_timeout");
        level flag::clear("spider_baby_hit_react");
        self thread spider_queen_weakspot();
        n_count = 0;
        if (level.players.size > 2) {
            n_count = 10;
        } else {
            n_count = 5;
        }
        level thread function_fb907799(n_count);
        level thread spider_baby_round_timeout(n_count);
        level thread function_dd902934();
        var_cc724e2d = struct::get_array("spider_body_spawn_point");
        var_4e46d51e = struct::get_array("spider_env_spawn_point");
        for (i = 0; i < n_count; i++) {
            if (var_cc724e2d.size != 0) {
                var_54219006 = array::random(var_cc724e2d);
                arrayremovevalue(var_cc724e2d, var_54219006);
            } else {
                var_54219006 = array::random(var_4e46d51e);
                arrayremovevalue(var_4e46d51e, var_54219006);
            }
            var_54219006 thread function_3d4c345d();
            wait randomfloatrange(0.5, 1);
        }
        var_cc724e2d = undefined;
        var_4e46d51e = undefined;
        level scene::play("cin_t7_ai_zm_dlc2_spider_queen_baby_drop_outro", self);
        level thread scene::play("cin_t7_ai_zm_dlc2_spider_queen_backwall_idle", self);
        level flag::clear("spider_queen_weak_spot_exposed");
        level flag::wait_till_any(array("spider_baby_round_done", "spider_baby_round_timeout"));
        level scene::play("cin_t7_ai_zm_dlc2_spider_queen_backwall_outro", self);
        level thread scene::play("cin_t7_ai_zm_dlc2_spider_queen_idle", self);
        level flag::set("spider_attack_done");
        level flag::clear("spider_queen_spawn_babies");
        wait 0.05;
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xb328ca70, Offset: 0x40a8
// Size: 0x38
function function_9a7e7358() {
    level endon(#"hash_2dc546da");
    level.var_e18ab0f2 = 0;
    while (true) {
        level waittill(#"hash_7e0a837a");
        level.var_e18ab0f2--;
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x1334d729, Offset: 0x40e8
// Size: 0x80
function function_dd902934() {
    level endon(#"spider_baby_round_timeout");
    level endon(#"spider_baby_round_done");
    while (true) {
        level waittill(#"hash_7e0a837a");
        if (level flag::get("spider_baby_hit_react")) {
            if (level.var_e18ab0f2 == 0) {
                level flag::set("spider_baby_round_done");
            }
        }
    }
}

// Namespace zm_island_spider_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x427e05c, Offset: 0x4170
// Size: 0x7c
function function_fb907799(n_count) {
    level endon(#"spider_baby_round_timeout");
    level endon(#"hash_c69c8ddc");
    for (var_d67f0d95 = 0; var_d67f0d95 != n_count; var_d67f0d95 += 1) {
        level waittill(#"hash_7e0a837a");
    }
    level flag::set("spider_baby_round_done");
}

// Namespace zm_island_spider_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x943ca725, Offset: 0x41f8
// Size: 0x54
function spider_baby_round_timeout(n_count) {
    level endon(#"spider_baby_round_done");
    if (n_count > 5) {
        wait 15;
    } else {
        wait 10;
    }
    level flag::set("spider_baby_round_timeout");
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x75b1024e, Offset: 0x4258
// Size: 0xcc
function function_3d4c345d() {
    level endon(#"hash_2dc546da");
    var_c79d3f71 = zombie_utility::spawn_zombie(level.var_c38a4fee[0], "spider_baby", self);
    var_c79d3f71 thread function_5d1bd65f();
    var_c79d3f71.favoriteenemy = namespace_27f8b154::get_favorite_enemy();
    self thread namespace_27f8b154::function_49e57a3b(var_c79d3f71, self);
    var_c79d3f71 thread function_46c109d1();
    playsoundatposition("zmb_foley_squeen_birth_spider", self.origin);
    level.var_e18ab0f2++;
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xb992eb78, Offset: 0x4330
// Size: 0x2a
function function_5d1bd65f() {
    level endon(#"hash_2dc546da");
    self waittill(#"death");
    level notify(#"hash_7e0a837a");
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xd949a390, Offset: 0x4368
// Size: 0xb4
function function_46c109d1() {
    self waittill(#"death");
    if (!isdefined(level.var_ce29fb51)) {
        level.var_ce29fb51 = 0;
    }
    if (!isdefined(level.var_511c2e79)) {
        level.var_511c2e79 = 5;
    }
    if (randomint(100) < 20 && !level.var_ce29fb51 && level.var_511c2e79 > 0) {
        level thread function_81898ad7();
        level thread zm_powerups::specific_powerup_drop("full_ammo", self.origin);
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x63d36067, Offset: 0x4428
// Size: 0x28
function function_81898ad7() {
    level.var_ce29fb51 = 1;
    wait 25;
    level.var_ce29fb51 = 0;
    level.var_511c2e79--;
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x16ef3013, Offset: 0x4458
// Size: 0xc8
function function_2ff7183() {
    level endon(#"hash_2dc546da");
    trigger = getent("sndEnterLair", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        who = trigger waittill(#"trigger");
        if (isdefined(who) && isplayer(who)) {
            if (zm_audio::sndmusicsystem_isabletoplay()) {
                who playsoundtoplayer("mus_island_lair_entry_oneshot", who);
            }
        }
        wait 0.05;
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x9bd8cb65, Offset: 0x4528
// Size: 0x444
function function_199d01b5() {
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_a_1_3");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_a_1_4");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_a_2_3");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_a_3_1");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_a_4_2");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_b_1_4_2");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_b_2_3_1");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_b_3_1_4");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_b_3_4_2");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_b_4_1_3");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_c_1_3_4_2");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_c_2_3_1_4");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_c_3_1_2_4");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_c_4_1_3_2");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_phase_c_4_2_1_3");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_entrance");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_idle");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_intro");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_loop");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_outro");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_baby_drop_intro");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_baby_drop_loop");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_baby_drop_outro");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_backwall_idle");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_backwall_outro");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_pain_react_phase_1");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_pain_react_phase_2");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_arm_attack_pain_react_phase_3");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_baby_drop_pain_react_phase_1");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_baby_drop_pain_react_phase_2");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_baby_drop_pain_react_phase_3");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_attack_spit_straight");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_attack_spit_left");
    struct::function_368120a1("scene", "cin_t7_ai_zm_dlc2_spider_queen_attack_spit_right");
}

/#

    // Namespace zm_island_spider_quest
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4918da50, Offset: 0x4978
    // Size: 0x104
    function function_4f46a12() {
        zm_devgui::add_custom_devgui_callback(&function_a4e9dacc);
        adddebugcommand("<dev string:x28>");
        adddebugcommand("<dev string:x7c>");
        adddebugcommand("<dev string:xd0>");
        adddebugcommand("<dev string:x124>");
        adddebugcommand("<dev string:x17a>");
        adddebugcommand("<dev string:x1d2>");
        adddebugcommand("<dev string:x22a>");
        adddebugcommand("<dev string:x282>");
        adddebugcommand("<dev string:x2cc>");
    }

    // Namespace zm_island_spider_quest
    // Params 1, eflags: 0x1 linked
    // Checksum 0x23312076, Offset: 0x4a88
    // Size: 0x1ae
    function function_a4e9dacc(cmd) {
        switch (cmd) {
        case "<dev string:x328>":
            level flag::set("<dev string:x33f>");
            return 1;
        case "<dev string:x35a>":
            level.var_5bb615cd = level.var_dd315d9c;
            return 1;
        case "<dev string:x36f>":
            level.var_5bb615cd = level.var_f6f57e72;
            return 1;
        case "<dev string:x384>":
            level notify(#"hash_9a8b82c3");
            level thread function_bd62f75b();
            return 1;
        case "<dev string:x39c>":
            level notify(#"hash_9a8b82c3");
            level thread function_31e22463();
            return 1;
        case "<dev string:x3b5>":
            level notify(#"hash_9a8b82c3");
            level thread function_11d7e2b1();
            return 1;
        case "<dev string:x3ce>":
            level notify(#"hash_9a8b82c3");
            level thread function_14f05ea8();
            return 1;
        case "<dev string:x3e7>":
            level flag::set("<dev string:x3f9>");
            return 1;
        case "<dev string:x40b>":
            array::thread_all(level.players, &function_10abb15e);
            return 1;
        }
        return 0;
    }

    // Namespace zm_island_spider_quest
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2ba3cd53, Offset: 0x4c40
    // Size: 0x40
    function function_bd62f75b() {
        level endon(#"hash_2dc546da");
        level endon(#"hash_9a8b82c3");
        while (true) {
            function_f033c56a();
        }
    }

    // Namespace zm_island_spider_quest
    // Params 0, eflags: 0x1 linked
    // Checksum 0x29aa6348, Offset: 0x4c88
    // Size: 0x40
    function function_11d7e2b1() {
        level endon(#"hash_2dc546da");
        level endon(#"hash_9a8b82c3");
        while (true) {
            function_3f6b6cb4();
        }
    }

    // Namespace zm_island_spider_quest
    // Params 0, eflags: 0x1 linked
    // Checksum 0xcb679e5e, Offset: 0x4cd0
    // Size: 0x40
    function function_31e22463() {
        level endon(#"hash_2dc546da");
        level endon(#"hash_9a8b82c3");
        while (true) {
            function_57b6770a();
        }
    }

    // Namespace zm_island_spider_quest
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1313f2b9, Offset: 0x4d18
    // Size: 0x60
    function function_14f05ea8() {
        level endon(#"hash_2dc546da");
        level endon(#"hash_9a8b82c3");
        while (true) {
            function_f033c56a();
            function_3f6b6cb4();
            function_57b6770a();
        }
    }

    // Namespace zm_island_spider_quest
    // Params 0, eflags: 0x1 linked
    // Checksum 0x54bc5ece, Offset: 0x4d80
    // Size: 0x7c
    function function_10abb15e() {
        e_weapon = getweapon("<dev string:x426>");
        self swap_weapon(e_weapon);
        wait 2;
        self upgrade_weapon();
        wait 2;
        self thread function_f77f0da9();
    }

    // Namespace zm_island_spider_quest
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3f8e138e, Offset: 0x4e08
    // Size: 0x154
    function swap_weapon(var_9f85aad5) {
        wpn_current = self getcurrentweapon();
        if (!zm_utility::is_player_valid(self)) {
            return;
        }
        if (self.is_drinking > 0) {
            return;
        }
        if (zm_utility::is_placeable_mine(wpn_current) || zm_equipment::is_equipment(wpn_current) || wpn_current == level.weaponnone) {
            return;
        }
        if (!self hasweapon(var_9f85aad5.rootweapon, 1)) {
            if (var_9f85aad5.type === "<dev string:x432>") {
                self function_3420bc2f(var_9f85aad5);
            } else {
                self function_dcfc8bde(wpn_current, var_9f85aad5);
            }
        } else {
            self givemaxammo(var_9f85aad5);
        }
        self switchtoweaponimmediate(var_9f85aad5);
    }

    // Namespace zm_island_spider_quest
    // Params 2, eflags: 0x1 linked
    // Checksum 0x18824c74, Offset: 0x4f68
    // Size: 0xd4
    function function_dcfc8bde(current_weapon, weapon) {
        a_weapons = self getweaponslistprimaries();
        if (isdefined(a_weapons) && a_weapons.size >= zm_utility::get_player_weapon_limit(self)) {
            self takeweapon(current_weapon);
        }
        var_7b9ca68 = self zm_weapons::give_build_kit_weapon(weapon);
        self giveweapon(var_7b9ca68);
        self switchtoweapon(var_7b9ca68);
    }

    // Namespace zm_island_spider_quest
    // Params 1, eflags: 0x1 linked
    // Checksum 0x27880c63, Offset: 0x5048
    // Size: 0x11c
    function function_3420bc2f(var_9f85aad5) {
        var_c5716cdc = self getweaponslist(1);
        foreach (weapon in var_c5716cdc) {
            if (weapon.type === "<dev string:x432>") {
                self takeweapon(weapon);
                break;
            }
        }
        var_7b9ca68 = self zm_weapons::give_build_kit_weapon(var_9f85aad5);
        self giveweapon(var_7b9ca68);
    }

    // Namespace zm_island_spider_quest
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8b9c4d7a, Offset: 0x5170
    // Size: 0x10c
    function upgrade_weapon() {
        var_1d94ca2b = self getcurrentweapon();
        var_a08320d8 = self getweaponammoclip(var_1d94ca2b);
        var_7298c138 = self getweaponammostock(var_1d94ca2b);
        var_19dc14f6 = zm_weapons::get_upgrade_weapon(var_1d94ca2b);
        var_19dc14f6 = self zm_weapons::give_build_kit_weapon(var_19dc14f6);
        self givestartammo(var_19dc14f6);
        self switchtoweaponimmediate(var_19dc14f6);
        self takeweapon(var_1d94ca2b, 1);
    }

    // Namespace zm_island_spider_quest
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4232f756, Offset: 0x5288
    // Size: 0xd4
    function function_f77f0da9() {
        self endon(#"disconnect");
        var_6c9b76cd = self zm_perks::perk_give_bottle_begin("<dev string:x438>");
        str_notify = self util::waittill_any_return("<dev string:x44c>", "<dev string:x457>", "<dev string:x45d>", "<dev string:x46b>", "<dev string:x482>");
        if (str_notify == "<dev string:x46b>") {
            self thread zm_perks::wait_give_perk("<dev string:x438>", 1);
        }
        self zm_perks::function_938ed54c(var_6c9b76cd, "<dev string:x438>");
    }

#/

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x1feb6d6e, Offset: 0x5368
// Size: 0x6c
function function_bccbf63c() {
    level.var_86ceb983 = struct::get("s_utrig_spiderqueen_free_ww", "targetname");
    level.var_86ceb983 zm_unitrigger::create_unitrigger(%ZM_ISLAND_SPIDER_QUEEN_WINE, 96, &function_65f4b50, &function_3039a61d);
}

// Namespace zm_island_spider_quest
// Params 1, eflags: 0x1 linked
// Checksum 0x592199d1, Offset: 0x53e0
// Size: 0x10a
function function_65f4b50(player) {
    if (player hasperk("specialty_widowswine")) {
        self sethintstring("");
        player zm_audio::create_and_play_dialog("general", "sigh");
        return 0;
    }
    if (!player zm_utility::can_player_purchase_perk()) {
        self sethintstring("");
        player zm_audio::create_and_play_dialog("general", "sigh");
        return 0;
    }
    self sethintstring(%ZM_ISLAND_SPIDER_QUEEN_WINE);
    return 1;
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0xf108ffdb, Offset: 0x54f8
// Size: 0x86
function function_3039a61d() {
    while (true) {
        player = self waittill(#"trigger");
        if (zm_utility::is_player_valid(player)) {
            player thread function_25762e4();
            player notify(#"hash_6c020c33");
            player notify(#"perk_purchased", "specialty_widowswine");
        }
        wait 60;
    }
}

// Namespace zm_island_spider_quest
// Params 0, eflags: 0x1 linked
// Checksum 0x7d5a283, Offset: 0x5588
// Size: 0x10c
function function_25762e4() {
    self endon(#"disconnect");
    if (!(isdefined(self.var_9b95533e) && self.var_9b95533e)) {
        self.var_9b95533e = 1;
        var_6c9b76cd = self zm_perks::perk_give_bottle_begin("specialty_widowswine");
        str_notify = self util::waittill_any_return("fake_death", "death", "player_downed", "weapon_change_complete", "disconnect");
        if (str_notify == "weapon_change_complete") {
            self thread zm_perks::wait_give_perk("specialty_widowswine", 1);
        }
        self zm_perks::function_938ed54c(var_6c9b76cd, "specialty_widowswine");
        wait 15;
        self.var_9b95533e = 0;
    }
}

