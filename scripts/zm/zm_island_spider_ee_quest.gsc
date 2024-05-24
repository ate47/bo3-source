#using scripts/zm/zm_island_vo;
#using scripts/zm/zm_island_util;
#using scripts/zm/zm_island_perks;
#using scripts/zm/_zm_weap_controllable_spider;
#using scripts/zm/_zm_weap_keeper_skull;
#using scripts/zm/_zm_ai_spiders;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/player_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_1aa6bd0c;

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0x5fede29a, Offset: 0x798
// Size: 0x14
function init() {
    register_clientfields();
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0xd968d242, Offset: 0x7b8
// Size: 0x94
function register_clientfields() {
    clientfield::register("vehicle", "spider_glow_fx", 9000, 1, "int");
    clientfield::register("vehicle", "spider_drinks_fx", 9000, 2, "int");
    clientfield::register("scriptmover", "jungle_cage_charged_fx", 9000, 1, "int");
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0xb50a51ee, Offset: 0x858
// Size: 0xbc
function main() {
    level flag::init("spider_from_mars_trapped_in_raised_cage");
    level flag::init("spiders_from_mars_round");
    level flag::init("spider_ee_quest_complete");
    level flag::init("charged_spider_cage_powerup");
    level.var_335f95e4 = undefined;
    level thread function_b27f5ad5();
    /#
        function_315620f9();
    #/
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0xeaf7d466, Offset: 0x920
// Size: 0xa6
function function_b27f5ad5() {
    level thread function_89826011();
    level flag::wait_till("skull_quest_complete");
    level flag::wait_till("ww3_found");
    level.var_1821d194 = 0;
    level.var_2aacffb1 = &function_78b57752;
    level flag::wait_till("spiders_from_mars_round");
    level.var_2aacffb1 = undefined;
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0x7d8a1d80, Offset: 0x9d0
// Size: 0xe4
function function_78b57752() {
    if (!(isdefined(level.var_1821d194) && level.var_1821d194) && !(isdefined(level.var_8c36ad2d) && level.var_8c36ad2d) && self.archetype === "spider" && math::cointoss()) {
        self.var_b4e06d32 = 1;
        self.b_ignore_cleanup = 1;
        self flag::init("spider_from_mars_identified");
        level.var_1821d194 = 1;
        level thread function_f163b5b5();
        self thread function_ed878303();
        self thread function_241013f7();
    }
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0x73940f04, Offset: 0xac0
// Size: 0x26
function function_f163b5b5() {
    level.var_8c36ad2d = 1;
    level waittill(#"between_round_over");
    level.var_8c36ad2d = undefined;
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0x12c98a67, Offset: 0xaf0
// Size: 0x1c
function function_ed878303() {
    self waittill(#"death");
    level.var_1821d194 = 0;
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0x17b3ce52, Offset: 0xb18
// Size: 0x17c
function function_241013f7() {
    self endon(#"death");
    self flag::wait_till("spider_from_mars_identified");
    self.var_75bf845a = [];
    while (true) {
        foreach (var_c80d3f8f in level.var_4a0060c0) {
            if (!isinarray(self.var_75bf845a, var_c80d3f8f.script_int) && self istouching(var_c80d3f8f)) {
                self.var_75bf845a[self.var_75bf845a.size] = var_c80d3f8f.script_int;
                self thread function_60b06e98(var_c80d3f8f.script_int);
            }
        }
        if (self.var_75bf845a.size == 3) {
            self thread function_c8ca27d0();
            break;
        }
        wait(1);
    }
}

// Namespace namespace_1aa6bd0c
// Params 1, eflags: 0x0
// Checksum 0x60abcef6, Offset: 0xca0
// Size: 0x15c
function function_60b06e98(var_c6cad973) {
    self endon(#"death");
    self vehicle_ai::set_state("scripted");
    self clientfield::set("spider_drinks_fx", var_c6cad973);
    var_be2ea7e9 = spawn("script_origin", self.origin);
    var_be2ea7e9 playloopsound("zmb_spider_drinking", 0.5);
    level thread namespace_f333593c::function_1e767f71(self, 600, "ee", "spider_lure", 10, 1, 3);
    wait(3);
    self clientfield::set("spider_drinks_fx", 0);
    self vehicle_ai::set_state("combat");
    var_be2ea7e9 stoploopsound(0.5);
    var_be2ea7e9 delete();
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0x60b26643, Offset: 0xe08
// Size: 0x30
function function_c8ca27d0() {
    self clientfield::set("spider_glow_fx", 1);
    self.var_f7522faa = 1;
}

// Namespace namespace_1aa6bd0c
// Params 1, eflags: 0x0
// Checksum 0x6ad8b4df, Offset: 0xe40
// Size: 0x3c
function function_aa515242(var_c79d3f71) {
    var_c79d3f71 thread function_6dff284c();
    level.var_18ddef1f = 1;
    level.var_335f95e4 = var_c79d3f71;
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0xdcf011c, Offset: 0xe88
// Size: 0xe4
function function_6dff284c() {
    self util::waittill_notify_or_timeout("death", -106);
    if (isalive(self)) {
        if (!(isdefined(level.var_3ef945d6) && level.var_3ef945d6)) {
            self util::stop_magic_bullet_shield();
            self dodamage(self.health, self.origin);
        } else {
            self waittill(#"death");
        }
    }
    level.var_67359403 = 0;
    level.var_18ddef1f = 0;
    level.var_335f95e4 = undefined;
    level flag::clear("spider_from_mars_trapped_in_raised_cage");
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0x3a368e, Offset: 0xf78
// Size: 0x258
function function_89826011() {
    level endon(#"hash_d8d0f829");
    e_clip = getent("clip_spider_cage", "targetname");
    e_clip setcandamage(1);
    e_clip.health = 100000;
    var_a2176993 = getent("jungle_lab_ee_control_panel_elf", "targetname");
    while (true) {
        n_damage, e_attacker, v_direction, v_point, str_mod, str_tag_name, str_model_name, var_829b9480, w_weapon = e_clip waittill(#"damage");
        if (!level.var_1dbad94a && !level flag::get("power_on")) {
            continue;
        }
        if (isdefined(e_attacker.var_36c3d64a) && w_weapon.name === "island_riotshield" && e_attacker.var_36c3d64a && !(isdefined(level.var_1deeff56) && level.var_1deeff56) && !(isdefined(level.var_90e478e7) && level.var_90e478e7) && !(isdefined(level.var_48762d0c) && level.var_48762d0c)) {
            e_attacker notify(#"hash_6bef9736");
            level.var_1deeff56 = 1;
            var_a2176993 clientfield::set("jungle_cage_charged_fx", 1);
            level waittill(#"hash_59a385d1");
            var_a2176993 clientfield::set("jungle_cage_charged_fx", 0);
            level waittill(#"hash_35cee1df");
            level.var_1deeff56 = 0;
        }
    }
}

// Namespace namespace_1aa6bd0c
// Params 1, eflags: 0x0
// Checksum 0x1c813087, Offset: 0x11d8
// Size: 0xec
function function_69f5a9c5(var_1cdfa0f4) {
    level notify(#"hash_59a385d1");
    if (isdefined(level.var_18ddef1f) && level.var_18ddef1f) {
        level.var_335f95e4.allowdeath = 1;
        level.var_335f95e4 dodamage(level.var_335f95e4.health, level.var_335f95e4.origin);
        function_edf712e5();
        return;
    }
    if (!level flag::get("charged_spider_cage_powerup")) {
        level flag::set("charged_spider_cage_powerup");
        level thread function_901514b1();
    }
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0x8e221f0d, Offset: 0x12d0
// Size: 0x86
function function_901514b1() {
    level.var_f1e9e5aa = &function_3321a018;
    e_powerup = zm_powerups::specific_powerup_drop(undefined, level.var_1a139831.origin - (0, 0, 110));
    e_powerup linkto(level.var_1a139831);
    level.var_f1e9e5aa = undefined;
}

// Namespace namespace_1aa6bd0c
// Params 1, eflags: 0x0
// Checksum 0xba31b339, Offset: 0x1360
// Size: 0x10
function function_3321a018(e_powerup) {
    return 90;
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0x39bb58d5, Offset: 0x1378
// Size: 0x3a
function function_c9e92f7b() {
    if (level.var_67359403) {
        level flag::set("spider_from_mars_trapped_in_raised_cage");
    }
    level notify(#"hash_35cee1df");
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0x6790c5a5, Offset: 0x13c0
// Size: 0x3c
function function_49fac1ac() {
    if (self.archetype === "spider") {
        self clientfield::set("spider_glow_fx", 1);
    }
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0xff8e8d7f, Offset: 0x1408
// Size: 0x12c
function function_edf712e5() {
    function_7855f232();
    if (level flag::get("spider_round_in_progress")) {
        level flag::wait_till_clear("spider_round_in_progress");
        level.var_3013498 = level.round_number + 2;
    } else {
        level.var_3013498 = level.round_number + 1;
    }
    while (true) {
        level flag::wait_till("spider_round_in_progress");
        if (level flag::get("spider_round")) {
            level flag::set("spiders_from_mars_round");
            callback::on_ai_spawned(&function_49fac1ac);
            level waittill(#"end_of_round");
            level thread function_2176e192();
            break;
        }
    }
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0xfe6cc327, Offset: 0x1540
// Size: 0x144
function function_7855f232() {
    level.var_39b24700 = getentarray("spiders_from_mars_spawner", "script_noteworthy");
    if (level.var_39b24700.size == 0) {
        return;
    }
    for (i = 0; i < level.var_39b24700.size; i++) {
        if (zm_spawner::is_spawner_targeted_by_blocker(level.var_39b24700[i])) {
            level.var_39b24700[i].is_enabled = 0;
            continue;
        }
        level.var_39b24700[i].is_enabled = 1;
        level.var_39b24700[i].script_forcespawn = 1;
    }
    /#
        assert(level.var_39b24700.size > 0);
    #/
    array::thread_all(level.var_39b24700, &spawner::add_spawn_function, &namespace_27f8b154::function_7c1ef59b);
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0x3c65ecc8, Offset: 0x1690
// Size: 0x2ca
function function_2176e192() {
    level flag::set("spider_ee_quest_complete");
    level flag::clear("spiders_from_mars_round");
    callback::remove_on_ai_spawned(&function_49fac1ac);
    mdl_reward = util::spawn_model("p7_zm_isl_cocoon_standing", level.var_1a139831.origin - (0, 0, 110), level.var_1a139831.angles);
    mdl_reward linkto(level.var_1a139831);
    level.var_f5ad590f = undefined;
    level waittill(#"hash_35cee1df");
    var_db6efb17 = getent("venom_extractor", "targetname");
    var_db6efb17 thread scene::play("p7_fxanim_zm_island_venom_extractor_red_bundle", var_db6efb17);
    level waittill(#"hash_e48828c5");
    var_1f71eb1 = struct::get("spider_ee_quest_reward", "targetname");
    var_1f71eb1.origin = var_1f71eb1.origin;
    var_1f71eb1.angles = var_1f71eb1.angles;
    var_1f71eb1.e_parent = mdl_reward;
    var_1f71eb1.script_unitrigger_type = "unitrigger_box_use";
    var_1f71eb1.cursor_hint = "HINT_NOICON";
    var_1f71eb1.require_look_at = 1;
    var_1f71eb1.script_width = -128;
    var_1f71eb1.script_length = -126;
    var_1f71eb1.script_height = 100;
    var_1f71eb1.prompt_and_visibility_func = &function_bf0f2293;
    zm_unitrigger::register_static_unitrigger(var_1f71eb1, &function_2818665b);
    var_f78dfee = struct::get("spider_cage_control");
    zm_unitrigger::unregister_unitrigger(var_f78dfee.trigger);
    level notify(#"hash_d8d0f829");
}

// Namespace namespace_1aa6bd0c
// Params 1, eflags: 0x0
// Checksum 0x18dd547, Offset: 0x1968
// Size: 0x7a
function function_bf0f2293(player) {
    if (player hasweapon(level.var_99f2368e)) {
        self sethintstring("");
        return 0;
    }
    self sethintstring("ZM_ISLAND_SPIDER_EQUIPMENT_PICKUP");
    return 1;
}

// Namespace namespace_1aa6bd0c
// Params 0, eflags: 0x0
// Checksum 0x2dc91bc2, Offset: 0x19f0
// Size: 0xc0
function function_2818665b() {
    while (true) {
        e_who = self waittill(#"trigger");
        if (e_who zm_utility::in_revive_trigger()) {
            continue;
        }
        if (e_who.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(e_who)) {
            continue;
        }
        if (e_who hasweapon(level.var_99f2368e)) {
            continue;
        }
        e_who notify(#"hash_2f64f5cf");
        e_who thread namespace_7b165194::function_468b927();
    }
}

/#

    // Namespace namespace_1aa6bd0c
    // Params 0, eflags: 0x0
    // Checksum 0xdc3a257f, Offset: 0x1ab8
    // Size: 0x74
    function function_315620f9() {
        zm_devgui::add_custom_devgui_callback(&function_acbe4aed);
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
    }

    // Namespace namespace_1aa6bd0c
    // Params 1, eflags: 0x0
    // Checksum 0x59985297, Offset: 0x1b38
    // Size: 0x386
    function function_acbe4aed(cmd) {
        switch (cmd) {
        case 0:
            var_c79d3f71 = undefined;
            a_ai = getaiteamarray("<unknown string>");
            foreach (ai in a_ai) {
                if (isdefined(ai.var_b4e06d32) && isdefined(ai.var_3940f450) && ai.var_3940f450 && ai.var_b4e06d32) {
                    var_c79d3f71 = ai;
                    break;
                }
            }
            if (!isdefined(var_c79d3f71)) {
                var_19764360 = namespace_27f8b154::get_favorite_enemy();
                s_spawn_point = namespace_27f8b154::function_570247b9(var_19764360);
                var_c79d3f71 = zombie_utility::spawn_zombie(level.var_c38a4fee[0]);
                if (isdefined(var_c79d3f71)) {
                    s_spawn_point thread namespace_27f8b154::function_49e57a3b(var_c79d3f71, s_spawn_point);
                }
            }
            var_c79d3f71 clientfield::set("<unknown string>", 1);
            var_c79d3f71.var_f7522faa = 1;
            return 1;
        default:
            level thread function_edf712e5();
            return 1;
        case 0:
            if (!isdefined(var_c79d3f71)) {
                var_19764360 = namespace_27f8b154::get_favorite_enemy();
                s_spawn_point = namespace_27f8b154::function_570247b9(var_19764360);
                var_c79d3f71 = zombie_utility::spawn_zombie(level.var_c38a4fee[0]);
                if (isdefined(var_c79d3f71)) {
                    s_spawn_point thread namespace_27f8b154::function_49e57a3b(var_c79d3f71, s_spawn_point);
                }
            }
            var_c79d3f71 clientfield::set("<unknown string>", 1);
            var_c79d3f71.var_b4e06d32 = 1;
            var_c79d3f71.b_ignore_cleanup = 1;
            var_c79d3f71 flag::init("<unknown string>");
            var_c79d3f71 flag::set("<unknown string>");
            level.var_1821d194 = 1;
            level thread function_f163b5b5();
            var_c79d3f71 thread function_ed878303();
            var_c79d3f71 thread function_241013f7();
            return 1;
        }
        return 0;
    }

#/
