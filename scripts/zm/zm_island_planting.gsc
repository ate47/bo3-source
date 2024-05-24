#using scripts/zm/_zm_weap_keeper_skull;
#using scripts/zm/zm_island_takeo_fight;
#using scripts/zm/zm_island_skullweapon_quest;
#using scripts/zm/zm_island_vo;
#using scripts/zm/zm_island_util;
#using scripts/zm/zm_island_main_ee_quest;
#using scripts/zm/zm_island_power;
#using scripts/zm/_zm_powerup_island_seed;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_attackables;
#using scripts/zm/_util;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/ai/archetype_thrasher;
#using scripts/shared/aat_shared;
#using scripts/codescripts/struct;

#namespace namespace_7550a904;

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x3d1054a9, Offset: 0x19e0
// Size: 0xbc
function main() {
    register_clientfields();
    level.bonus_points_powerup_override = &function_bb96e04a;
    level thread function_84f89441();
    function_54af12e9();
    function_72298dfd();
    function_cd4b5ba1();
    function_349e17a5();
    function_869faee7();
    function_1b391116();
    /#
        function_e851ad39();
    #/
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0xd52190cc, Offset: 0x1aa8
// Size: 0x214
function register_clientfields() {
    clientfield::register("scriptmover", "plant_growth_siege_anims", 9000, 2, "int");
    clientfield::register("scriptmover", "cache_plant_interact_fx", 9000, 1, "int");
    clientfield::register("scriptmover", "plant_hit_with_ww_fx", 9000, 1, "int");
    clientfield::register("scriptmover", "plant_watered_fx", 9000, 1, "int");
    clientfield::register("scriptmover", "planter_model_watered", 9000, 1, "int");
    clientfield::register("scriptmover", "babysitter_plant_fx", 9000, 1, "int");
    clientfield::register("scriptmover", "trap_plant_fx", 9000, 1, "int");
    clientfield::register("toplayer", "player_spawned_from_clone_plant", 9000, 1, "int");
    clientfield::register("toplayer", "player_cloned_fx", 9000, 1, "int");
    clientfield::register("scriptmover", "zombie_or_grenade_spawned_from_minor_cache_plant", 9000, 2, "int");
    clientfield::register("allplayers", "player_vomit_fx", 9000, 1, "int");
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0xb8f0b392, Offset: 0x1cc8
// Size: 0x8
function function_bb96e04a() {
    return 500;
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x37e9701c, Offset: 0x1cd8
// Size: 0xc0
function function_84f89441() {
    var_ac51aa3c = struct::get_array("planting_spot", "targetname");
    foreach (var_a87feedd in var_ac51aa3c) {
        var_a87feedd function_fedc998b();
    }
    level.var_ac51aa3c = var_ac51aa3c;
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x4e2caa31, Offset: 0x1da0
// Size: 0x2ac
function function_fedc998b(var_e7abf7d0) {
    if (!isdefined(var_e7abf7d0)) {
        var_e7abf7d0 = 0;
    }
    if (var_e7abf7d0 == 0) {
        self.model = util::spawn_model("p7_zm_isl_plant_planter", self.origin, self.angles);
    }
    var_c27b0ccb = spawnstruct();
    var_c27b0ccb.origin = self.origin + (0, 0, 8);
    var_c27b0ccb.angles = self.angles;
    var_c27b0ccb.s_parent = self;
    var_c27b0ccb.script_unitrigger_type = "unitrigger_box_use";
    var_c27b0ccb.cursor_hint = "HINT_NOICON";
    var_c27b0ccb.require_look_at = 0;
    var_c27b0ccb.script_width = 100;
    var_c27b0ccb.script_length = 100;
    var_c27b0ccb.script_height = -106;
    var_c27b0ccb.prompt_and_visibility_func = &function_ecd16539;
    zm_unitrigger::register_static_unitrigger(var_c27b0ccb, &function_c3c6c68d);
    self.var_c27b0ccb = var_c27b0ccb;
    self.var_75c7a97e = 0;
    self.var_594609f9 = 0;
    self.var_e7abf7d0 = var_e7abf7d0;
    self.var_f2a52ffa = spawnstruct();
    self.var_f2a52ffa.model = util::spawn_model("tag_origin", self.origin, self.angles);
    self.var_f2a52ffa.var_75bf845a = [];
    self.var_f2a52ffa.var_49d71b32 = 0;
    self.var_f2a52ffa.var_198c12a1 = 0;
    self.var_f2a52ffa.var_8d8becb0 = 0;
    self.var_f2a52ffa.var_5a41bc99 = 0;
    self.var_f2a52ffa.var_4d34f582 = 0;
    self.var_f2a52ffa flag::init("plant_interact_trigger_used");
    self thread function_ae64b39a(undefined, self.var_e7abf7d0);
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x12f40f01, Offset: 0x2058
// Size: 0x2c0
function function_ecd16539(e_player) {
    if (e_player zm_utility::in_revive_trigger()) {
        self sethintstring(%);
        return 0;
    }
    if (e_player.is_drinking > 0) {
        self sethintstring(%);
        return 0;
    }
    if (!zm_utility::is_player_valid(e_player)) {
        self sethintstring(%);
        return 0;
    }
    if (self.stub.s_parent.var_f2a52ffa.var_198c12a1 == 1) {
        self sethintstring(%);
        return 0;
    }
    if (self.stub.s_parent.var_75c7a97e == 0) {
        if (e_player clientfield::get_to_player("has_island_seed")) {
            self sethintstring(%ZM_ISLAND_PLANT_SEED);
            return 1;
        } else {
            self sethintstring(%);
            return 0;
        }
        return;
    }
    if (self.stub.s_parent.var_594609f9 == 0 && self.stub.s_parent.var_f2a52ffa.var_4d34f582 == 0 && self.stub.s_parent.var_f2a52ffa.var_5a41bc99 == 0 && self.stub.s_parent.var_e7abf7d0 == 0) {
        if (isdefined(e_player.var_6fd3d65c) && e_player.var_6fd3d65c && e_player.var_bb2fd41c > 0) {
            self sethintstring(%ZM_ISLAND_WATER_PLANT);
            return 1;
        } else {
            self sethintstring(%);
            return 0;
        }
        return;
    }
    self sethintstring(%);
    return 0;
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x4505a040, Offset: 0x2320
// Size: 0x1c8
function function_c3c6c68d() {
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
        if (self.stub.s_parent.var_75c7a97e == 0) {
            if (e_who clientfield::get_to_player("has_island_seed")) {
                self.stub.s_parent notify(#"hash_fa482f7", e_who);
            }
            continue;
        }
        if (self.stub.s_parent.var_f2a52ffa.var_4d34f582 == 0 && self.stub.s_parent.var_f2a52ffa.var_5a41bc99 == 0 && self.stub.s_parent.var_e7abf7d0 == 0) {
            if (isdefined(e_who.var_6fd3d65c) && e_who.var_6fd3d65c && isdefined(e_who.var_bb2fd41c) && e_who.var_bb2fd41c > 0 && isdefined(e_who.var_c6cad973)) {
                self.stub.s_parent notify(#"hash_8626f7f1", e_who);
            }
        }
    }
}

// Namespace namespace_7550a904
// Params 3, eflags: 0x0
// Checksum 0x1889da28, Offset: 0x24f0
// Size: 0x258
function function_ae64b39a(var_9636d237, var_f40460f5, var_895cb900) {
    if (!isdefined(var_895cb900)) {
        var_895cb900 = 0;
    }
    self endon(#"hash_378095a2");
    self endon(#"hash_7a0cef7b");
    while (true) {
        if (!isdefined(var_9636d237) && !var_895cb900) {
            e_who = self waittill(#"hash_fa482f7");
            if (!e_who clientfield::get_to_player("has_island_seed")) {
                continue;
            }
            self.var_561a9c48 = e_who;
            level thread namespace_e37c032f::function_58b6724f(e_who);
            e_who playsound("evt_island_seed_plant");
            e_who namespace_f333593c::function_7f4cb4c("plant", "seed", 1);
        } else {
            self.var_561a9c48 = level.activeplayers[0];
        }
        self.var_75c7a97e = 1;
        self.var_f2a52ffa.var_198c12a1 = 1;
        self thread function_18d2ce8b();
        self thread function_447658c7(var_9636d237, var_f40460f5);
        self thread function_4357491f();
        self waittill(#"hash_98cf252f");
        if (isdefined(var_f40460f5) && var_f40460f5) {
            wait(2);
        } else if (!isdefined(var_9636d237)) {
            level waittill(#"end_of_round");
        }
        self scene::play("p7_fxanim_zm_island_plant_dead_bundle", self.var_f2a52ffa.model);
        self.var_f2a52ffa.model ghost();
        self.var_75c7a97e = 0;
        self.var_561a9c48 = undefined;
        if (isdefined(var_9636d237)) {
            var_9636d237 = undefined;
        }
    }
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0xe64543f7, Offset: 0x2750
// Size: 0x20
function function_18d2ce8b() {
    wait(1);
    self.var_f2a52ffa.var_198c12a1 = 0;
}

// Namespace namespace_7550a904
// Params 2, eflags: 0x0
// Checksum 0x4c21d68f, Offset: 0x2778
// Size: 0x638
function function_447658c7(var_9636d237, var_f40460f5) {
    if (!isdefined(var_9636d237)) {
        self thread function_ffa65395(var_f40460f5);
        self thread function_5026698c(var_f40460f5);
        self.var_f2a52ffa.var_8d8becb0 = 0;
        self.var_f2a52ffa.var_5a41bc99 = 0;
        for (n_round = 0; n_round < 3; n_round++) {
            switch (n_round) {
            case 0:
                self.var_f2a52ffa.model setmodel("p7_fxanim_zm_island_plant_seed_mod");
                self.var_f2a52ffa.model show();
                self.var_f2a52ffa.model notsolid();
                self scene::init("p7_fxanim_zm_island_plant_stage1_bundle", self.var_f2a52ffa.model);
                self.var_f2a52ffa.model playsound("evt_island_seed_grow_stage_1");
                break;
            case 1:
                self.var_f2a52ffa.model clientfield::set("plant_growth_siege_anims", 1);
                self scene::play("p7_fxanim_zm_island_plant_stage1_bundle", self.var_f2a52ffa.model);
                self.var_f2a52ffa.model playsound("evt_island_seed_grow_stage_2");
                break;
            case 2:
                self.var_f2a52ffa.model solid();
                self.var_f2a52ffa.model disconnectpaths();
                self.var_f2a52ffa.model clientfield::set("plant_growth_siege_anims", 2);
                self scene::play("p7_fxanim_zm_island_plant_stage2_bundle", self.var_f2a52ffa.model);
                self.var_f2a52ffa.model playsound("evt_island_seed_grow_stage_3");
                self thread function_4357491f();
                break;
            default:
                break;
            }
            if (isdefined(var_f40460f5) && var_f40460f5) {
                wait(2);
                self notify(#"hash_67f478bd");
                continue;
            }
            if (self.var_f2a52ffa.var_5a41bc99 == 1) {
                util::wait_network_frame();
                continue;
            }
            level waittill(#"end_of_round");
            if (isdefined(self.var_f2a52ffa.var_8d8becb0) && self.var_f2a52ffa.var_8d8becb0) {
                self.var_f2a52ffa.var_8d8becb0 = 0;
                continue;
            }
            self notify(#"hash_70cb3a5f");
            self.var_f2a52ffa.var_5a41bc99 = 1;
        }
    }
    if (isdefined(var_f40460f5) && var_f40460f5) {
        self.var_f2a52ffa.model clientfield::set("plant_hit_with_ww_fx", 0);
    }
    self.var_f2a52ffa.model clientfield::set("plant_growth_siege_anims", 3);
    self thread scene::play("p7_fxanim_zm_island_plant_stage3_bundle", self.var_f2a52ffa.model);
    self.var_f2a52ffa.model waittill(#"hash_116e737b");
    self.var_594609f9 = 1;
    self.var_f2a52ffa.model clientfield::set("plant_hit_with_ww_fx", 0);
    self.var_f2a52ffa.model clientfield::set("plant_watered_fx", 0);
    /#
        println("collision_player_cylinder_32x256");
    #/
    self function_26651461(self.var_f2a52ffa.var_75bf845a, self.var_f2a52ffa.var_49d71b32, var_9636d237, var_f40460f5);
    self.var_f2a52ffa.model clientfield::set("cache_plant_interact_fx", 0);
    if (!isdefined(var_9636d237)) {
        self.var_f2a52ffa.model setmodel("p7_fxanim_zm_island_plant_dead_mod");
        self scene::init("p7_fxanim_zm_island_plant_dead_bundle", self.var_f2a52ffa.model);
    }
    self.var_f2a52ffa.model notsolid();
    self.var_f2a52ffa.model connectpaths();
    self notify(#"hash_98cf252f");
    self.var_594609f9 = 0;
    self.var_f2a52ffa.var_75bf845a = [];
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0xd576862b, Offset: 0x2db8
// Size: 0x22c
function function_49a83594() {
    self endon(#"hash_98cf252f");
    var_793f092a = 5;
    var_2bbd3ff9 = 40;
    var_66ee586a = spawn("trigger_radius", self.origin + (0, 0, 50), 0, var_793f092a, var_2bbd3ff9);
    self thread function_b88d99d(var_66ee586a);
    while (true) {
        foreach (player in level.activeplayers) {
            if (player istouching(var_66ee586a) && zm_utility::is_player_valid(player)) {
                wait(2);
                if (player istouching(var_66ee586a) && zm_utility::is_player_valid(player)) {
                    v_moveto = undefined;
                    while (!isdefined(v_moveto)) {
                        v_moveto = getclosestpointonnavmesh(self.origin, 64);
                        wait(0.05);
                    }
                    player playlocalsound(level.zmb_laugh_alias);
                    player setorigin(v_moveto);
                    player dodamage(player.health, self.origin);
                }
            }
        }
        wait(2);
    }
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0xdb15fe35, Offset: 0x2ff0
// Size: 0x2c
function function_b88d99d(var_66ee586a) {
    self waittill(#"hash_98cf252f");
    var_66ee586a delete();
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x5ad4e8ba, Offset: 0x3028
// Size: 0x74
function function_4357491f() {
    mdl_clip = spawncollision("collision_player_cylinder_32x256", "collider", self.origin + (0, 0, 125), (0, 0, 0));
    self waittill(#"hash_98cf252f");
    mdl_clip delete();
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x107ff683, Offset: 0x30a8
// Size: 0x36e
function function_ffa65395(var_f40460f5) {
    self endon(#"hash_70cb3a5f");
    if (isdefined(var_f40460f5) && var_f40460f5) {
        return;
    }
    self.var_f2a52ffa.var_75bf845a = [];
    self.var_f2a52ffa.var_2a1e031c = [];
    wait(1);
    for (n_round = 0; n_round < 3; n_round++) {
        self.var_f2a52ffa.var_4d34f582 = 0;
        user = self waittill(#"hash_8626f7f1");
        /#
            if (isdefined(user.playernum)) {
                println("minigun" + user.playernum + "trilogy_released" + user.var_c6cad973);
            }
        #/
        self.var_f2a52ffa.var_4d34f582 = 1;
        user notify(#"hash_d7d3166");
        user playsound("evt_island_seed_water");
        if (!isdefined(user.var_f6130406)) {
            user.var_f6130406 = 1;
            user notify(#"hash_b570ac9b");
        } else {
            n_rand = randomintrange(1, 101);
            if (n_rand <= 20) {
                user notify(#"hash_b570ac9b");
            }
        }
        self.var_f2a52ffa.var_75bf845a[self.var_f2a52ffa.var_75bf845a.size] = user.var_c6cad973;
        user thread namespace_f3e3de78::function_a84a1aec();
        array::add(self.var_f2a52ffa.var_2a1e031c, user, 1);
        if (n_round == 2) {
            if (self.var_f2a52ffa.var_2a1e031c[0] === self.var_f2a52ffa.var_2a1e031c[1] && self.var_f2a52ffa.var_2a1e031c[1] === self.var_f2a52ffa.var_2a1e031c[2]) {
                user notify(#"hash_c1783c94");
            }
        }
        self.var_f2a52ffa.var_8d8becb0 = 1;
        self.var_f2a52ffa.model clientfield::set("plant_watered_fx", 1);
        self.model clientfield::set("planter_model_watered", 1);
        level waittill(#"end_of_round");
        self.var_f2a52ffa.model clientfield::set("plant_watered_fx", 0);
        self.model clientfield::set("planter_model_watered", 0);
    }
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0xf037d983, Offset: 0x3420
// Size: 0xfe
function function_5026698c(var_f40460f5) {
    self endon(#"hash_70cb3a5f");
    self.var_f2a52ffa.var_49d71b32 = 0;
    for (n_round = 0; n_round < 3; n_round++) {
        self waittill(#"hash_8dfde2c8");
        self.var_f2a52ffa.var_49d71b32++;
        self.var_f2a52ffa.var_8d8becb0 = 1;
        self.var_f2a52ffa.model clientfield::set("plant_hit_with_ww_fx", 1);
        if (isdefined(var_f40460f5) && var_f40460f5) {
            return;
        } else {
            level waittill(#"end_of_round");
        }
        self.var_f2a52ffa.model clientfield::set("plant_hit_with_ww_fx", 0);
    }
}

// Namespace namespace_7550a904
// Params 4, eflags: 0x0
// Checksum 0xe3c31dc7, Offset: 0x3528
// Size: 0x9ba
function function_26651461(var_75bf845a, var_49d71b32, var_9636d237, var_f40460f5) {
    var_b47da5df = [];
    var_b47da5df[0] = 0;
    var_b47da5df[1] = 0;
    var_b47da5df[2] = 0;
    var_b47da5df[3] = 0;
    var_b47da5df[4] = 0;
    var_b47da5df[5] = 0;
    var_b47da5df[6] = 0;
    var_b47da5df[7] = 0;
    var_b47da5df[8] = 0;
    var_b47da5df[9] = 0;
    var_b47da5df[10] = 0;
    var_1e67e37 = 0;
    var_34c1ce60 = 0;
    var_eaa9733b = 0;
    var_98b687fa = 0;
    if (self.script_noteworthy === "ee_planting_spot") {
        var_76a58077 = 1;
    } else {
        var_76a58077 = 0;
    }
    for (i = 0; i < var_75bf845a.size; i++) {
        if (var_75bf845a[i] == 4) {
            if (var_76a58077 && !level flag::get("ww_upgrade_spawned_from_plant")) {
                continue;
            }
            var_75bf845a[i] = randomintrange(1, 4);
        }
    }
    foreach (var_1153caa9 in var_75bf845a) {
        if (var_1153caa9 == 1) {
            var_1e67e37++;
            continue;
        }
        if (var_1153caa9 == 2) {
            var_34c1ce60++;
            continue;
        }
        if (var_1153caa9 == 3) {
            var_eaa9733b++;
            continue;
        }
        if (var_1153caa9 == 4) {
            var_98b687fa++;
        }
    }
    if (self.script_noteworthy === "ee_planting_spot") {
        self function_5726c670(var_98b687fa);
        return;
    }
    n_total = 0;
    if (level.var_50d5cc84 < 4) {
        if (var_49d71b32 == 3) {
            var_b47da5df[10] = 20;
        } else {
            var_b47da5df[10] = 5 * var_49d71b32;
        }
    }
    var_a476b929 = 100 - var_b47da5df[10];
    n_total += var_b47da5df[10];
    if (var_1e67e37 == 1 && var_34c1ce60 == 1 && var_eaa9733b == 1) {
        var_b47da5df[8] = var_a476b929 / 2;
        var_b47da5df[2] = var_a476b929 / 2 / 3;
        var_b47da5df[4] = var_a476b929 / 2 / 3;
        var_b47da5df[6] = var_a476b929 / 2 / 3;
        var_b47da5df[0] = 0;
        var_b47da5df[1] = 0;
    } else {
        var_b47da5df[2] = var_a476b929 * var_1e67e37 / 3;
        var_b47da5df[4] = var_a476b929 * var_eaa9733b / 3;
        var_b47da5df[6] = var_a476b929 * var_34c1ce60 / 3;
        n_total += var_b47da5df[2] + var_b47da5df[4] + var_b47da5df[6];
        if (var_75bf845a.size === 0 && var_49d71b32 === 0) {
            var_b47da5df[0] = 100 - n_total;
            var_b47da5df[1] = 0;
        } else {
            var_b47da5df[0] = 0;
            var_b47da5df[1] = 100 - n_total;
        }
    }
    var_b47da5df[3] = var_b47da5df[2] * var_49d71b32 / 3;
    var_b47da5df[2] = abs(var_b47da5df[2] - var_b47da5df[3]);
    var_b47da5df[5] = var_b47da5df[4] * var_49d71b32 / 3;
    var_b47da5df[4] = abs(var_b47da5df[4] - var_b47da5df[5]);
    var_b47da5df[7] = var_b47da5df[6] * var_49d71b32 / 3;
    var_b47da5df[6] = abs(var_b47da5df[6] - var_b47da5df[7]);
    var_b47da5df[9] = var_b47da5df[8] * var_49d71b32 / 3;
    var_b47da5df[8] = abs(var_b47da5df[8] - var_b47da5df[9]);
    if (isdefined(var_f40460f5) && var_f40460f5) {
        var_b47da5df = [];
        if (var_49d71b32 > 0) {
            var_b47da5df[5] = 100;
        } else {
            var_b47da5df[4] = 100;
        }
    }
    var_f48f47cc = [];
    var_29cc53bd = 0;
    foreach (plant, n_score in var_b47da5df) {
        if (n_score > 0) {
            var_f48f47cc[plant] = var_29cc53bd + n_score;
            var_29cc53bd += n_score;
        }
    }
    n_random = randomfloatrange(0, 100);
    foreach (plant, n_score in var_f48f47cc) {
        if (n_random <= n_score) {
            break;
        }
    }
    if (isdefined(var_9636d237)) {
        plant = var_9636d237;
    }
    switch (plant) {
    case 0:
        self function_41663231();
        break;
    case 1:
        self function_41663231(1);
        break;
    case 2:
        self function_a6084535(0, var_98b687fa);
        break;
    case 3:
        self function_a6084535(1, var_98b687fa);
        break;
    case 4:
        self function_5d62716(0, var_f40460f5);
        break;
    case 5:
        self function_5d62716(1, var_f40460f5);
        break;
    case 6:
        self function_12c8548e();
        break;
    case 7:
        self function_12c8548e(1);
        break;
    case 8:
        self function_fd098f17();
        break;
    case 9:
        self function_fd098f17(1);
        break;
    case 10:
        self function_3e429652();
        break;
    default:
        break;
    }
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0xce999eef, Offset: 0x3ef0
// Size: 0x2d4
function function_54af12e9() {
    level.var_3f5e92d = getweapon("pistol_standard");
    level.var_f3798849 = getweapon("sniper_fastbolt");
    level.var_c29d7558 = getweapon("launcher_standard");
    level.var_b00f35c1 = getweapon("ar_marksman");
    var_b0612bf3 = [];
    var_b0612bf3["points"] = 10;
    var_b0612bf3["pistol"] = 10;
    var_b0612bf3["sniper"] = 10;
    var_b0612bf3["launcher"] = 10;
    var_b0612bf3["ar"] = 10;
    var_b0612bf3["zombie"] = 25;
    var_b0612bf3["grenade"] = 25;
    var_29cc53bd = 0;
    level.var_349b9c58 = [];
    foreach (str_reward, n_chance in var_b0612bf3) {
        level.var_349b9c58[str_reward] = n_chance + var_29cc53bd;
        var_29cc53bd += n_chance;
    }
    var_ec35bcf6 = [];
    var_ec35bcf6["points"] = 35;
    var_ec35bcf6["pistol"] = 35;
    var_ec35bcf6["sniper"] = 10;
    var_ec35bcf6["launcher"] = 10;
    var_ec35bcf6["ar"] = 10;
    var_29cc53bd = 0;
    level.var_9d5349d = [];
    foreach (str_reward, n_chance in var_ec35bcf6) {
        level.var_9d5349d[str_reward] = n_chance + var_29cc53bd;
        var_29cc53bd += n_chance;
    }
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0xd1b1abad, Offset: 0x41d0
// Size: 0x874
function function_41663231(b_upgraded) {
    if (!isdefined(b_upgraded)) {
        b_upgraded = 0;
    }
    /#
        if (b_upgraded == 1) {
            println("zm_dlc2_plant_trap_attack_no_target_front");
        } else {
            println("p7_fxanim_zm_island_plant_clone_grow1_bundle");
        }
    #/
    if (isdefined(self.var_561a9c48)) {
        self.var_561a9c48 notify(#"hash_32cabc36");
    }
    level notify(#"hash_32cabc36");
    self.var_f2a52ffa.model stopanimscripted();
    self.var_f2a52ffa.model setmodel("p7_fxanim_zm_island_plant_cache_minor_mod");
    self.var_f2a52ffa.model show();
    self.var_f2a52ffa.model solid();
    self.var_f2a52ffa.model disconnectpaths();
    self.var_f2a52ffa.model clientfield::set("cache_plant_interact_fx", 1);
    self thread scene::init("p7_fxanim_zm_island_plant_cache_minor_bundle", self.var_f2a52ffa.model);
    self.var_f2a52ffa.model waittill(#"hash_1879b5e4");
    self thread function_a6ebbe13();
    e_who = self waittill(#"hash_ebe5cad7");
    /#
        println("player_downed");
    #/
    zm_unitrigger::unregister_unitrigger(self.var_23c5e7a6);
    self.var_23c5e7a6 = undefined;
    self.var_f2a52ffa.model clientfield::set("cache_plant_interact_fx", 0);
    self scene::play("p7_fxanim_zm_island_plant_cache_minor_bundle", self.var_f2a52ffa.model);
    if (b_upgraded == 1) {
        var_3d9ef8e9 = level.var_9d5349d;
    } else {
        var_3d9ef8e9 = level.var_349b9c58;
    }
    n_reward = randomfloatrange(0, 100);
    foreach (str_reward, n_chance in var_3d9ef8e9) {
        if (n_reward <= n_chance) {
            break;
        }
    }
    switch (str_reward) {
    case 48:
        e_powerup = zm_powerups::specific_powerup_drop("bonus_points_player", self.origin + (0, 0, 8), undefined, undefined, 1);
        e_who notify(#"hash_dd398494");
        e_powerup util::waittill_any("powerup_grabbed", "death", "powerup_reset", "powerup_timedout");
        break;
    case 49:
        e_who notify(#"hash_133a2934");
        self function_e07a8850(e_who, level.var_3f5e92d);
        break;
    case 50:
        e_who notify(#"hash_133a2934");
        self function_e07a8850(e_who, level.var_f3798849);
        break;
    case 51:
        e_who notify(#"hash_133a2934");
        self function_e07a8850(e_who, level.var_c29d7558);
        break;
    case 52:
        e_who notify(#"hash_133a2934");
        self function_e07a8850(e_who, level.var_b00f35c1);
        break;
    case 53:
        self.var_f2a52ffa.model notsolid();
        self.var_f2a52ffa.model connectpaths();
        wait(0.05);
        s_temp = spawnstruct();
        s_temp.origin = function_15c62ca8(self.origin, 20);
        if (!isdefined(s_temp.origin)) {
            s_temp.origin = self.origin;
        }
        s_temp.script_noteworthy = "custom_spawner_entry quick_riser_location";
        s_temp.script_string = "find_flesh";
        zombie_utility::spawn_zombie(level.zombie_spawners[0], "aether_zombie", s_temp);
        util::wait_network_frame();
        s_temp struct::delete();
        self.var_f2a52ffa.model clientfield::set("zombie_or_grenade_spawned_from_minor_cache_plant", 1);
        self.var_f2a52ffa.model util::delay(3, undefined, &clientfield::set, "zombie_or_grenade_spawned_from_minor_cache_plant", 0);
        e_who notify(#"hash_133a2934");
        break;
    case 54:
        self.var_f2a52ffa.model notsolid();
        self.var_f2a52ffa.model connectpaths();
        wait(0.05);
        v_spawnpt = self.origin;
        grenade = getweapon("frag_grenade");
        e_who magicgrenadetype(grenade, v_spawnpt, (0, 0, 300), 3);
        self.var_f2a52ffa.model clientfield::set("zombie_or_grenade_spawned_from_minor_cache_plant", 2);
        self.var_f2a52ffa.model util::delay(3, undefined, &clientfield::set, "zombie_or_grenade_spawned_from_minor_cache_plant", 0);
        e_who notify(#"hash_133a2934");
        break;
    default:
        break;
    }
    self.var_f2a52ffa.model clientfield::set("plant_growth_siege_anims", 0);
    self scene::play("p7_fxanim_zm_island_plant_cache_minor_death_bundle", self.var_f2a52ffa.model);
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x79a6ef4d, Offset: 0x4a50
// Size: 0x14c
function function_a6ebbe13() {
    var_c27b0ccb = spawnstruct();
    var_c27b0ccb.origin = self.origin + (0, 0, 8);
    var_c27b0ccb.angles = self.angles;
    var_c27b0ccb.s_parent = self;
    var_c27b0ccb.script_unitrigger_type = "unitrigger_box_use";
    var_c27b0ccb.cursor_hint = "HINT_NOICON";
    var_c27b0ccb.require_look_at = 1;
    var_c27b0ccb.script_width = 100;
    var_c27b0ccb.script_length = 100;
    var_c27b0ccb.script_height = -106;
    var_c27b0ccb.prompt_and_visibility_func = &function_be57d4be;
    zm_unitrigger::register_static_unitrigger(var_c27b0ccb, &function_241f6a3e);
    self.var_23c5e7a6 = var_c27b0ccb;
    self.var_f2a52ffa flag::clear("plant_interact_trigger_used");
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x4ba0e8b5, Offset: 0x4ba8
// Size: 0x13a
function function_be57d4be(e_player) {
    if (e_player zm_utility::in_revive_trigger()) {
        self sethintstring(%);
        return 0;
    }
    if (e_player.is_drinking > 0) {
        self sethintstring(%);
        return 0;
    }
    if (!zm_utility::is_player_valid(e_player)) {
        self sethintstring(%);
        return 0;
    }
    if (self.stub.s_parent.var_f2a52ffa flag::get("plant_interact_trigger_used")) {
        self sethintstring(%);
        return 0;
    }
    self sethintstring(%ZM_ISLAND_CACHE_PLANT);
    return 1;
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x588c2482, Offset: 0x4cf0
// Size: 0xd2
function function_241f6a3e() {
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
        self.stub.s_parent notify(#"hash_ebe5cad7", e_who);
        self.stub.s_parent.var_f2a52ffa flag::set("plant_interact_trigger_used");
        return;
    }
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0xd1a9245d, Offset: 0x4dd0
// Size: 0x514
function function_72298dfd() {
    level.var_df105f37 = 50;
    var_b2846cef = getweapon("smg_mp40");
    var_f27e0342 = getweapon("shotgun_semiauto");
    var_6b0419bd = getweapon("ar_damage");
    var_1a2b2be0 = getweapon("lmg_slowfire");
    var_8847e925 = getweapon("ar_garand");
    var_21057d5f = getweapon("smg_longrange");
    level.var_b39227d1 = array(var_b2846cef, var_f27e0342, var_6b0419bd, var_1a2b2be0, var_8847e925, var_21057d5f);
    level.var_c88b32a2 = array("full_ammo", "nuke", "insta_kill", "double_points", "fire_sale", "carpenter", "minigun");
    var_56b02536 = getweapon("pistol_shotgun_dw");
    var_722e06cb = getweapon("shotgun_fullauto");
    var_d6376f9e = getweapon("sniper_fastsemi");
    var_4fa7d135 = getweapon("ray_gun");
    var_c71381ba = getweapon("bowie_knife");
    var_b4550164 = getweapon("cymbal_monkey");
    level.var_8aee1d4 = array(var_56b02536, var_722e06cb, var_d6376f9e, var_4fa7d135, var_c71381ba, var_b4550164);
    level.var_1a1ac6dd = array("full_ammo", "nuke", "insta_kill", "double_points", "fire_sale", "minigun");
    var_b0612bf3 = [];
    var_c6f9cb70 = 100;
    var_b0612bf3["points"] = var_c6f9cb70 / 3;
    var_b0612bf3["weapon"] = var_c6f9cb70 / 3;
    var_b0612bf3["powerup"] = var_c6f9cb70 / 3;
    var_29cc53bd = 0;
    level.var_170b1e5c = [];
    foreach (str_reward, n_chance in var_b0612bf3) {
        level.var_170b1e5c[str_reward] = n_chance + var_29cc53bd;
        var_29cc53bd += n_chance;
    }
    level.var_e6d4b4ec = var_29cc53bd;
    var_ec35bcf6 = [];
    var_ec35bcf6["points"] = 30;
    var_ec35bcf6["weapon"] = 25;
    var_ec35bcf6["powerup"] = 25;
    var_ec35bcf6["perk_bottle"] = 20;
    var_29cc53bd = 0;
    level.var_ff3b49 = [];
    foreach (str_reward, n_chance in var_ec35bcf6) {
        level.var_ff3b49[str_reward] = n_chance + var_29cc53bd;
        var_29cc53bd += n_chance;
    }
    level.var_2afecb6f = var_29cc53bd;
}

// Namespace namespace_7550a904
// Params 2, eflags: 0x0
// Checksum 0x139976d6, Offset: 0x52f0
// Size: 0x834
function function_a6084535(b_upgraded, var_98b687fa) {
    if (!isdefined(b_upgraded)) {
        b_upgraded = 0;
    }
    /#
        if (b_upgraded == 1) {
            println("<unknown string>");
        } else {
            println("<unknown string>");
        }
    #/
    if (isdefined(self.var_561a9c48)) {
        self.var_561a9c48 notify(#"hash_1f9ae8b2");
    }
    level notify(#"hash_1f9ae8b2");
    self.var_f2a52ffa.model stopanimscripted();
    if (b_upgraded == 1) {
        self.var_f2a52ffa.model setmodel("p7_fxanim_zm_island_plant_cache_major_glow_mod");
    } else {
        self.var_f2a52ffa.model setmodel("p7_fxanim_zm_island_plant_cache_major_mod");
    }
    self.var_f2a52ffa.model clientfield::set("cache_plant_interact_fx", 1);
    self.var_f2a52ffa.model show();
    self.var_f2a52ffa.model solid();
    self.var_f2a52ffa.model disconnectpaths();
    self thread scene::init("p7_fxanim_zm_island_plant_cache_major_bundle", self.var_f2a52ffa.model);
    self.var_f2a52ffa.model waittill(#"hash_aa2731d8");
    self thread function_192bd777();
    e_who = self waittill(#"hash_983c15d3");
    /#
        println("<unknown string>");
    #/
    zm_unitrigger::unregister_unitrigger(self.var_23c5e7a6);
    self.var_23c5e7a6 = undefined;
    self.var_f2a52ffa.model clientfield::set("cache_plant_interact_fx", 0);
    self scene::play("p7_fxanim_zm_island_plant_cache_major_bundle", self.var_f2a52ffa.model);
    if (b_upgraded == 1) {
        var_3d9ef8e9 = level.var_ff3b49;
        var_582b5c62 = level.var_2afecb6f;
    } else {
        var_3d9ef8e9 = level.var_170b1e5c;
        var_582b5c62 = level.var_e6d4b4ec;
    }
    n_reward = randomfloatrange(0, var_582b5c62);
    foreach (str_reward, n_chance in var_3d9ef8e9) {
        if (n_reward <= n_chance) {
            break;
        }
    }
    if (b_upgraded == 1) {
        if (level flag::get("trilogy_released") && !level flag::get("aa_gun_ee_complete") && !level flag::get("player_has_aa_gun_ammo") && !level flag::get("aa_gun_ammo_loaded")) {
            n_chance = randomfloatrange(0, 100);
            if (n_chance <= level.var_df105f37) {
                str_reward = "aa_gun_ammo";
            } else {
                level.var_df105f37 += 10;
            }
        }
    }
    switch (str_reward) {
    case 48:
        e_powerup = zm_powerups::specific_powerup_drop("bonus_points_team", self.origin + (0, 0, 8), undefined, undefined, 1);
        e_powerup thread function_61d38f32();
        e_who notify(#"hash_dd398494");
        e_powerup util::waittill_any("powerup_grabbed", "death", "powerup_reset", "powerup_timedout");
        break;
    case 87:
        if (b_upgraded == 1) {
            e_who notify(#"hash_dd398494");
            self function_e07a8850(e_who, array::random(level.var_8aee1d4));
        } else {
            e_who notify(#"hash_dd398494");
            self function_e07a8850(e_who, array::random(level.var_b39227d1));
        }
        break;
    case 88:
        if (b_upgraded == 1) {
            str_powerup = array::random(level.var_1a1ac6dd);
        } else {
            str_powerup = array::random(level.var_c88b32a2);
        }
        e_powerup = zm_powerups::specific_powerup_drop(str_powerup, self.origin + (0, 0, 8), undefined, undefined, 1);
        e_powerup thread function_61d38f32();
        e_who notify(#"hash_dd398494");
        e_powerup util::waittill_any("powerup_grabbed", "death", "powerup_reset", "powerup_timedout");
        break;
    case 89:
        e_powerup = zm_powerups::specific_powerup_drop("empty_perk", self.origin + (0, 0, 8), undefined, undefined, 1);
        e_powerup thread function_61d38f32();
        e_who notify(#"hash_dd398494");
        e_powerup util::waittill_any("powerup_grabbed", "death", "powerup_reset", "powerup_timedout");
        break;
    case 97:
        self main_quest::function_1f4e6abd();
        break;
    }
    self.var_f2a52ffa.model clientfield::set("plant_growth_siege_anims", 0);
    self scene::play("p7_fxanim_zm_island_plant_cache_major_death_bundle", self.var_f2a52ffa.model);
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0xe41830b3, Offset: 0x5b30
// Size: 0x14c
function function_192bd777() {
    var_c27b0ccb = spawnstruct();
    var_c27b0ccb.origin = self.origin + (0, 0, 8);
    var_c27b0ccb.angles = self.angles;
    var_c27b0ccb.s_parent = self;
    var_c27b0ccb.script_unitrigger_type = "unitrigger_box_use";
    var_c27b0ccb.cursor_hint = "HINT_NOICON";
    var_c27b0ccb.require_look_at = 1;
    var_c27b0ccb.script_width = 100;
    var_c27b0ccb.script_length = 100;
    var_c27b0ccb.script_height = -106;
    var_c27b0ccb.prompt_and_visibility_func = &function_4fdc4f62;
    zm_unitrigger::register_static_unitrigger(var_c27b0ccb, &function_a5e6439a);
    self.var_23c5e7a6 = var_c27b0ccb;
    self.var_f2a52ffa flag::clear("plant_interact_trigger_used");
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x1042a1e9, Offset: 0x5c88
// Size: 0x13a
function function_4fdc4f62(e_player) {
    if (e_player zm_utility::in_revive_trigger()) {
        self sethintstring(%);
        return 0;
    }
    if (e_player.is_drinking > 0) {
        self sethintstring(%);
        return 0;
    }
    if (!zm_utility::is_player_valid(e_player)) {
        self sethintstring(%);
        return 0;
    }
    if (self.stub.s_parent.var_f2a52ffa flag::get("plant_interact_trigger_used")) {
        self sethintstring(%);
        return 0;
    }
    self sethintstring(%ZM_ISLAND_CACHE_PLANT);
    return 1;
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0xd3d9cb5, Offset: 0x5dd0
// Size: 0xd2
function function_a5e6439a() {
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
        self.stub.s_parent notify(#"hash_983c15d3", e_who);
        self.stub.s_parent.var_f2a52ffa flag::set("plant_interact_trigger_used");
        return;
    }
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x80f4b8cd, Offset: 0x5eb0
// Size: 0xc4
function function_cd4b5ba1() {
    scene::add_scene_func("zm_dlc2_plant_babysitter_gib_zombie", &function_389c8477, "play");
    scene::add_scene_func("zm_dlc2_plant_babysitter_grab_zombie_crawler", &function_a4a048a1, "play");
    scene::add_scene_func("zm_dlc2_plant_babysitter_grab_spider", &function_6d8761e4, "play");
    scene::add_scene_func("zm_dlc2_plant_babysitter_outro", &function_7a4276be, "done");
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0xfddaeba1, Offset: 0x5f80
// Size: 0x90c
function function_12c8548e(b_upgraded) {
    if (!isdefined(b_upgraded)) {
        b_upgraded = 0;
    }
    /#
        if (b_upgraded == 1) {
            println("<unknown string>");
        } else {
            println("<unknown string>");
        }
    #/
    if (isdefined(self.var_561a9c48)) {
        self.var_561a9c48 notify(#"hash_4b955a91");
    }
    level notify(#"hash_4b955a91");
    if (b_upgraded == 1) {
        self.var_f2a52ffa.model setmodel("p7_zm_isl_plant_babysitter_glow");
    } else {
        self.var_f2a52ffa.model setmodel("p7_zm_isl_plant_babysitter");
    }
    self.var_f2a52ffa.model show();
    self.var_f2a52ffa.model solid();
    self.var_f2a52ffa.model disconnectpaths();
    self.model clientfield::set("babysitter_plant_fx", 1);
    self scene::init("zm_dlc2_plant_babysitter_intro", self.var_f2a52ffa.model);
    self.var_f2a52ffa.model waittill(#"hash_fca5370b");
    self.var_f2a52ffa.trigger = spawn("trigger_radius", self.origin, 17, -106, -106);
    while (true) {
        e_who = self.var_f2a52ffa.trigger waittill(#"trigger");
        if (isdefined(e_who.var_61f7b3a0) && e_who.var_61f7b3a0) {
            continue;
        }
        if (isplayer(e_who)) {
            continue;
        }
        if (!(isdefined(e_who.var_3940f450) && e_who.var_3940f450) && e_who.completed_emerging_into_playable_area !== 1) {
            continue;
        }
        var_b28a4a84 = 0;
        str_zone = self.var_f2a52ffa.model zm_utility::get_current_zone();
        foreach (player in level.players) {
            str_player_zone = player zm_utility::get_current_zone();
            if (str_zone === str_player_zone) {
                var_b28a4a84 = 1;
                break;
            }
        }
        if (var_b28a4a84 == 0) {
            continue;
        }
        if (isalive(e_who)) {
            if (isdefined(e_who.missinglegs) && e_who.missinglegs) {
                e_who thread function_160d5071(self, "ai_zm_dlc2_zombie_crawl_grabbed_by_babysitter");
            } else if (isdefined(e_who.var_3940f450) && e_who.var_3940f450) {
                e_who thread function_40428876(self, "ai_zm_dlc2_spider_grabbed_by_babysitter");
            } else {
                e_who thread function_8be57636(self);
                e_who thread function_160d5071(self, "ai_zm_dlc2_zombie_gibbed_by_babysitter");
            }
            e_who util::waittill_any("death", "zombie_reached_anim_spot");
            if (!isalive(e_who)) {
                continue;
            }
            e_who.b_ignore_cleanup = 1;
            e_who.is_inert = 1;
            var_73dc61d6 = array(self.var_f2a52ffa.model, e_who);
            break;
        }
    }
    if (!(isdefined(e_who.missinglegs) && e_who.missinglegs) && !(isdefined(e_who.var_3940f450) && e_who.var_3940f450)) {
        e_who.var_2ff6aa22 = 1;
        e_who thread util::delay(1, "death", &function_9a107da1);
        self scene::play("zm_dlc2_plant_babysitter_gib_zombie", var_73dc61d6);
    }
    if (isdefined(e_who.var_3940f450) && e_who.var_3940f450) {
        self scene::play("zm_dlc2_plant_babysitter_grab_spider", var_73dc61d6);
    } else {
        self scene::play("zm_dlc2_plant_babysitter_grab_zombie_crawler", var_73dc61d6);
    }
    /#
        println("<unknown string>");
    #/
    level thread namespace_f333593c::function_1e767f71(self.var_f2a52ffa.model, 600, "babysitter", "grab", 120, 0, -1);
    if (b_upgraded == 1) {
        e_who util::waittill_any_timeout(3600, "death");
    } else {
        e_who util::waittill_any_timeout(480, "death");
    }
    self.var_f2a52ffa.model notify(#"hash_9ed7f404");
    if (isdefined(e_who) && isalive(e_who)) {
        if (isdefined(e_who.var_3940f450) && e_who.var_3940f450) {
            self scene::play("zm_dlc2_plant_babysitter_drop_spider", var_73dc61d6);
            e_who vehicle_ai::stop_scripted();
        } else {
            self scene::play("zm_dlc2_plant_babysitter_drop_zombie_crawler", var_73dc61d6);
        }
        e_who.b_ignore_cleanup = 0;
        e_who.is_inert = 0;
    }
    wait(1);
    self.var_f2a52ffa.model clientfield::set("plant_growth_siege_anims", 0);
    self thread scene::play("zm_dlc2_plant_babysitter_outro", self.var_f2a52ffa.model);
    self.var_f2a52ffa.model waittill(#"hash_7a4276be");
    self.model clientfield::set("babysitter_plant_fx", 0);
    self.var_f2a52ffa.trigger delete();
    wait(0.05);
    self.var_f2a52ffa.model stopanimscripted();
    wait(0.05);
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0xf27b6f38, Offset: 0x6898
// Size: 0x7c
function function_8be57636(var_f2a52ffa) {
    self endon(#"death");
    self endon(#"hash_d668a33b");
    while (true) {
        if (isdefined(self.missinglegs) && self.missinglegs) {
            self notify(#"hash_e9a97726");
            self thread function_160d5071(var_f2a52ffa, "ai_zm_dlc2_zombie_crawl_grabbed_by_babysitter");
            break;
        }
        wait(0.05);
    }
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x80d12d17, Offset: 0x6920
// Size: 0x7c
function function_389c8477(a_ents) {
    level thread function_14ae573d(a_ents);
    ai_zombie = a_ents["zombie"];
    ai_zombie setcandamage(0);
    ai_zombie waittill(#"gibbed");
    ai_zombie zombie_utility::makezombiecrawler(1);
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x20e119d6, Offset: 0x69a8
// Size: 0x3aa
function function_14ae573d(a_ents) {
    a_ents["babysitter"] waittill(#"hash_c75436ca");
    v_org = a_ents["babysitter"] gettagorigin("j_claw_1_anim");
    foreach (player in level.players) {
        if (!isalive(player)) {
            continue;
        }
        n_dist = distance2dsquared(player.origin, v_org);
        if (n_dist < 2304) {
            player dodamage(50, player.origin);
            player playrumbleonentity("damage_light");
        }
    }
    var_da0978dc = getaiteamarray("axis");
    foreach (ai in var_da0978dc) {
        if (isdefined(ai.var_2ff6aa22) && (!isalive(ai) || ai.var_2ff6aa22)) {
            continue;
        }
        n_dist = distance2dsquared(ai.origin, v_org);
        if (n_dist < 2304) {
            if (isdefined(ai.var_61f7b3a0) && ai.var_61f7b3a0) {
                n_damage = ai.maxhealth * 0.25;
                ai dodamage(n_damage, ai.origin);
                continue;
            }
            if (isdefined(ai.var_3940f450) && ai.var_3940f450) {
                ai dodamage(ai.health, ai.origin);
                continue;
            }
            if (isdefined(ai.missinglegs) && ai.missinglegs) {
                ai dodamage(ai.health, ai.origin);
                continue;
            }
            ai zombie_utility::makezombiecrawler();
        }
    }
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0xd47012bf, Offset: 0x6d60
// Size: 0x10
function function_9a107da1() {
    self.var_2ff6aa22 = 0;
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0xec86af65, Offset: 0x6d78
// Size: 0x6c
function function_a4a048a1(a_ents) {
    a_ents["zombie"] setcandamage(0);
    a_ents["zombie"] waittill(#"hash_58f0843e");
    a_ents["zombie"] setcandamage(1);
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x548e1ad2, Offset: 0x6df0
// Size: 0x6c
function function_6d8761e4(a_ents) {
    a_ents["spider"] setcandamage(0);
    a_ents["spider"] waittill(#"hash_dfabd1fb");
    a_ents["spider"] setcandamage(1);
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0xfb910075, Offset: 0x6e68
// Size: 0x26
function function_7a4276be(a_ents) {
    a_ents["babysitter"] notify(#"hash_7a4276be");
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x86132f6f, Offset: 0x6e98
// Size: 0x334
function function_349e17a5() {
    scene::add_scene_func("zm_dlc2_plant_trap_outro", &function_2df6714, "done");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_front", &function_9e124689, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_back", &function_9e124689, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_left", &function_9e124689, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_right", &function_9e124689, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_no_target_front", &function_9e124689, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_no_target_back", &function_9e124689, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_no_target_left", &function_9e124689, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_no_target_right", &function_9e124689, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_crawler_front", &function_9e124689, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_crawler_back", &function_9e124689, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_crawler_left", &function_9e124689, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_crawler_right", &function_9e124689, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_spider_front", &function_b1a9e247, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_spider_back", &function_b1a9e247, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_spider_left", &function_b1a9e247, "play");
    scene::add_scene_func("zm_dlc2_plant_trap_attack_spider_right", &function_b1a9e247, "play");
}

// Namespace namespace_7550a904
// Params 2, eflags: 0x0
// Checksum 0x42aad5eb, Offset: 0x71d8
// Size: 0x41c
function function_5d62716(b_upgraded, var_f40460f5) {
    if (!isdefined(b_upgraded)) {
        b_upgraded = 0;
    }
    /#
        if (b_upgraded == 1) {
            println("<unknown string>");
        } else {
            println("<unknown string>");
        }
    #/
    if (isdefined(self.var_561a9c48)) {
        self.var_561a9c48 notify(#"hash_36abe879");
    }
    level notify(#"hash_36abe879");
    if (isdefined(var_f40460f5) && var_f40460f5) {
        level notify(#"hash_35728d0b");
    }
    if (!self.var_f2a52ffa.model flag::exists("trap_plant_attacking")) {
        self.var_f2a52ffa.model flag::init("trap_plant_attacking");
    }
    if (b_upgraded == 1) {
        self.var_f2a52ffa.model setmodel("p7_zm_isl_plant_trap_glow");
    } else {
        self.var_f2a52ffa.model setmodel("p7_zm_isl_plant_trap");
    }
    self.var_f2a52ffa.model show();
    self.var_f2a52ffa.model solid();
    self.var_f2a52ffa.model disconnectpaths();
    self.model clientfield::set("trap_plant_fx", 1);
    self scene::init("zm_dlc2_plant_trap_intro", self.var_f2a52ffa.model);
    self.var_f2a52ffa.model waittill(#"hash_73ada233");
    level thread namespace_f333593c::function_1e767f71(self.var_f2a52ffa.model, 600, "trap", "plant_encounter", 60, 1, -1);
    self.var_f2a52ffa.trigger = spawn("trigger_radius", self.origin, 0, 75, -106);
    self thread function_ff90a1ba(b_upgraded);
    self thread function_2870d1b8(var_f40460f5);
    self waittill(#"hash_4729ad2");
    self.model clientfield::set("trap_plant_fx", 0);
    self.var_f2a52ffa.trigger delete();
    self.var_f2a52ffa.model flag::wait_till_clear("trap_plant_attacking");
    self.var_f2a52ffa.model clientfield::set("plant_growth_siege_anims", 0);
    self thread scene::play("zm_dlc2_plant_trap_outro", self.var_f2a52ffa.model);
    self.var_f2a52ffa.model waittill(#"hash_2df6714");
    wait(0.05);
    self.var_f2a52ffa.model stopanimscripted();
    wait(0.05);
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0xd18bf0ef, Offset: 0x7600
// Size: 0x1fa
function function_ff90a1ba(b_upgraded) {
    var_c746b61a = struct::get_array(self.target, "targetname");
    foreach (var_b454101b in var_c746b61a) {
        if (b_upgraded == 1 && var_b454101b.script_noteworthy === "attackable_upgraded") {
            break;
        }
        if (var_b454101b.script_noteworthy === "attackable") {
            break;
        }
    }
    var_b454101b zm_attackables::activate();
    self.var_f2a52ffa.var_b454101b = var_b454101b;
    var_b454101b.b_deferred_deactivation = 1;
    self thread function_813b723b();
    self thread function_4bc7c145(b_upgraded);
    var_b454101b waittill(#"attackable_deactivated");
    self notify(#"hash_4729ad2");
    self.var_f2a52ffa.model notify(#"hash_9ed7f404");
    self.var_f2a52ffa.model waittill(#"hash_cf8d499a");
    self.var_f2a52ffa.var_b454101b zm_attackables::deactivate();
    self.var_f2a52ffa.var_b454101b.b_deferred_deactivation = undefined;
    self.var_f2a52ffa.var_b454101b = undefined;
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x7d07d32d, Offset: 0x7808
// Size: 0x78
function function_813b723b() {
    self endon(#"hash_4729ad2");
    var_53973ac6 = self.var_f2a52ffa.var_b454101b.health / 5;
    while (true) {
        level waittill(#"end_of_round");
        self.var_f2a52ffa.var_b454101b zm_attackables::do_damage(var_53973ac6);
    }
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x25be3ab1, Offset: 0x7888
// Size: 0x90
function function_4bc7c145(b_upgraded) {
    if (b_upgraded) {
        var_922fc340 = 1280;
    } else {
        var_922fc340 = 1180;
    }
    if (level.round_number <= 30) {
        self.var_f2a52ffa.var_b454101b.health = var_922fc340 * level.round_number;
        return;
    }
    self.var_f2a52ffa.var_b454101b.health = var_922fc340 * 30;
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0xc65364e6, Offset: 0x7920
// Size: 0x670
function function_2870d1b8(var_f40460f5) {
    self endon(#"hash_4729ad2");
    if (!isdefined(self.var_b17878ae)) {
        var_99098466 = [];
        var_70e1ee03 = getstartorigin(self.origin, self.angles, "ai_zm_dlc2_zombie_dth_plant_trap_front");
        var_99098466["front"] = var_70e1ee03;
        var_ce06045f = getstartorigin(self.origin, self.angles, "ai_zm_dlc2_zombie_dth_plant_trap_back");
        var_99098466["back"] = var_ce06045f;
        var_778b0569 = getstartorigin(self.origin, self.angles, "ai_zm_dlc2_zombie_dth_plant_trap_left");
        var_99098466["left"] = var_778b0569;
        var_9d6b7614 = getstartorigin(self.origin, self.angles, "ai_zm_dlc2_zombie_dth_plant_trap_right");
        var_99098466["right"] = var_9d6b7614;
        var_e7fb417b = [];
        foreach (key, v_pos in var_99098466) {
            if (ispointonnavmesh(v_pos)) {
                var_e7fb417b[key] = v_pos;
            }
        }
        /#
            assert(var_e7fb417b.size > 0);
        #/
        self.var_b17878ae = var_e7fb417b;
    }
    while (true) {
        var_f19144da = [];
        var_566f2991 = undefined;
        var_da0978dc = getaiteamarray("axis");
        foreach (ai in var_da0978dc) {
            if (isalive(ai) && ai istouching(self.var_f2a52ffa.trigger)) {
                var_f19144da[var_f19144da.size] = ai;
            }
        }
        foreach (player in level.activeplayers) {
            if (isdefined(player) && player istouching(self.var_f2a52ffa.trigger)) {
                var_f19144da[var_f19144da.size] = player;
            }
        }
        if (var_f19144da.size == 0) {
            wait(0.1);
            continue;
        }
        var_f41cf130 = undefined;
        var_d0aaf7a2 = undefined;
        var_121609e = undefined;
        foreach (key, v_pos in self.var_b17878ae) {
            e_target = arraygetclosest(v_pos, var_f19144da);
            n_dist = distance2dsquared(v_pos, e_target.origin);
            if (!isdefined(var_f41cf130)) {
                var_f41cf130 = n_dist;
                var_d0aaf7a2 = e_target;
                var_121609e = key;
                continue;
            }
            if (n_dist < var_f41cf130) {
                var_f41cf130 = n_dist;
                var_d0aaf7a2 = e_target;
                var_121609e = key;
            }
        }
        var_566f2991 = var_d0aaf7a2;
        if (isdefined(var_566f2991)) {
            if (isdefined(var_566f2991.var_61f7b3a0) && (isplayer(var_566f2991) || var_566f2991.var_61f7b3a0)) {
                self function_fa3e7444(var_121609e);
            } else if (isdefined(var_566f2991.var_3940f450) && var_566f2991.var_3940f450) {
                var_2202a6b5 = self function_32c5773c(var_566f2991, var_121609e);
                if (var_2202a6b5 == 0) {
                    wait(0.05);
                    continue;
                }
            } else {
                var_2202a6b5 = self function_6b938a09(var_566f2991, var_121609e);
                if (var_2202a6b5 == 0) {
                    wait(0.05);
                    continue;
                }
            }
            wait(0.5);
            continue;
        }
        wait(0.05);
    }
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x98cdb12f, Offset: 0x7f98
// Size: 0x12e
function function_fa3e7444(var_121609e) {
    switch (var_121609e) {
    case 148:
        self thread scene::play("zm_dlc2_plant_trap_attack_no_target_front", self.var_f2a52ffa.model);
        break;
    case 150:
        self thread scene::play("zm_dlc2_plant_trap_attack_no_target_back", self.var_f2a52ffa.model);
        break;
    case 152:
        self thread scene::play("zm_dlc2_plant_trap_attack_no_target_left", self.var_f2a52ffa.model);
        break;
    case 154:
        self thread scene::play("zm_dlc2_plant_trap_attack_no_target_right", self.var_f2a52ffa.model);
        break;
    }
    self thread function_7f34488a(var_121609e);
    self.var_f2a52ffa.model waittill(#"hash_4ce89178");
}

// Namespace namespace_7550a904
// Params 2, eflags: 0x0
// Checksum 0x917ed995, Offset: 0x80d0
// Size: 0x376
function function_6b938a09(var_d0aaf7a2, var_121609e) {
    var_73dc61d6 = array(self.var_f2a52ffa.model, var_d0aaf7a2);
    var_d0aaf7a2.var_7d79a6 = 1;
    var_d0aaf7a2 thread function_79faa463(self);
    var_d0aaf7a2 function_1762804b(0);
    var_ea0c0e00 = 0;
    if (isdefined(var_d0aaf7a2.missinglegs) && var_d0aaf7a2.missinglegs) {
        var_ea0c0e00 = 1;
    }
    b_attack = 1;
    switch (var_121609e) {
    case 148:
        var_ac23a74d = "ai_zm_dlc2_zombie_crawl_dth_plant_trap_front";
        var_636cd52c = "ai_zm_dlc2_zombie_dth_plant_trap_front";
        var_ed5489f4 = "zm_dlc2_plant_trap_attack_crawler_front";
        str_scene_name = "zm_dlc2_plant_trap_attack_front";
        break;
    case 150:
        var_ac23a74d = "ai_zm_dlc2_zombie_crawl_dth_plant_trap_back";
        var_636cd52c = "ai_zm_dlc2_zombie_dth_plant_trap_back";
        var_ed5489f4 = "zm_dlc2_plant_trap_attack_crawler_back";
        str_scene_name = "zm_dlc2_plant_trap_attack_back";
        break;
    case 152:
        var_ac23a74d = "ai_zm_dlc2_zombie_crawl_dth_plant_trap_left";
        var_636cd52c = "ai_zm_dlc2_zombie_dth_plant_trap_left";
        var_ed5489f4 = "zm_dlc2_plant_trap_attack_crawler_left";
        str_scene_name = "zm_dlc2_plant_trap_attack_left";
        break;
    case 154:
        var_ac23a74d = "ai_zm_dlc2_zombie_crawl_dth_plant_trap_right";
        var_636cd52c = "ai_zm_dlc2_zombie_dth_plant_trap_right";
        var_ed5489f4 = "zm_dlc2_plant_trap_attack_crawler_right";
        str_scene_name = "zm_dlc2_plant_trap_attack_right";
        break;
    }
    if (var_ea0c0e00 == 1) {
        var_d0aaf7a2 thread function_160d5071(self, var_ac23a74d);
    } else {
        var_d0aaf7a2 thread function_374f973e(self, var_ac23a74d);
        var_d0aaf7a2 thread function_160d5071(self, var_636cd52c);
    }
    var_d0aaf7a2 util::waittill_any("death", "zombie_reached_anim_spot");
    if (isalive(var_d0aaf7a2)) {
        if (isdefined(var_d0aaf7a2.missinglegs) && var_d0aaf7a2.missinglegs) {
            self thread scene::play(var_ed5489f4, var_73dc61d6);
            self thread function_7f34488a(var_121609e, 1);
        } else {
            self thread scene::play(str_scene_name, var_73dc61d6);
            self thread function_7f34488a(var_121609e);
        }
    } else {
        b_attack = 0;
        return b_attack;
    }
    self.var_f2a52ffa.model waittill(#"hash_4ce89178");
    return b_attack;
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x639eb625, Offset: 0x8450
// Size: 0x48
function function_79faa463(var_f2a52ffa) {
    self endon(#"death");
    var_f2a52ffa waittill(#"hash_4729ad2");
    if (isalive(self)) {
        self.var_7d79a6 = 0;
    }
}

// Namespace namespace_7550a904
// Params 2, eflags: 0x0
// Checksum 0x24f12ce9, Offset: 0x84a0
// Size: 0x8c
function function_374f973e(var_f2a52ffa, var_ac23a74d) {
    self endon(#"death");
    self endon(#"hash_d668a33b");
    var_f2a52ffa endon(#"hash_4729ad2");
    while (true) {
        if (isdefined(self.missinglegs) && self.missinglegs) {
            self notify(#"hash_e9a97726");
            self thread function_160d5071(var_f2a52ffa, var_ac23a74d);
            break;
        }
        wait(0.05);
    }
}

// Namespace namespace_7550a904
// Params 2, eflags: 0x0
// Checksum 0x73a6f9bc, Offset: 0x8538
// Size: 0x1de
function function_32c5773c(var_d0aaf7a2, var_121609e) {
    var_73dc61d6 = array(self.var_f2a52ffa.model, var_d0aaf7a2);
    var_d0aaf7a2.var_7d79a6 = 1;
    var_d0aaf7a2 thread function_79faa463(self);
    b_attack = 1;
    switch (var_121609e) {
    case 148:
        var_636cd52c = "ai_zm_dlc2_spider_dth_plant_trap_front";
        str_scene_name = "zm_dlc2_plant_trap_attack_spider_front";
        break;
    case 150:
        var_636cd52c = "ai_zm_dlc2_spider_dth_plant_trap_back";
        str_scene_name = "zm_dlc2_plant_trap_attack_spider_back";
        break;
    case 152:
        var_636cd52c = "ai_zm_dlc2_spider_dth_plant_trap_left";
        str_scene_name = "zm_dlc2_plant_trap_attack_spider_left";
        break;
    case 154:
        var_636cd52c = "ai_zm_dlc2_spider_dth_plant_trap_right";
        str_scene_name = "zm_dlc2_plant_trap_attack_spider_right";
        break;
    }
    var_d0aaf7a2 function_40428876(self, var_636cd52c);
    if (isalive(var_d0aaf7a2)) {
        self thread scene::play(str_scene_name, var_73dc61d6);
        self thread function_7f34488a(var_121609e, 1);
    } else {
        b_attack = 0;
        return b_attack;
    }
    self.var_f2a52ffa.model waittill(#"hash_4ce89178");
    return b_attack;
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x11794351, Offset: 0x8720
// Size: 0x224
function function_9e124689(a_ents) {
    e_target = a_ents["zombie"];
    var_31678178 = a_ents["plant_trap"];
    var_31678178 flag::set("trap_plant_attacking");
    var_31678178 util::waittill_any("spawn_head", "plant_melee");
    if (isalive(e_target)) {
        self thread function_e6f615b3(e_target);
        var_fdbb0645 = e_target.head + "_prop";
        gibserverutils::gibhead(e_target);
        e_target dodamage(e_target.health, e_target.origin);
        v_org = var_31678178 gettagorigin("tag_plant_grab");
        v_angles = var_31678178 gettagangles("tag_plant_grab");
        var_c40b12dc = util::spawn_model(var_fdbb0645, v_org, v_angles);
        var_c40b12dc linkto(var_31678178, "tag_plant_grab");
        var_31678178 waittill(#"hash_af56254a");
        var_c40b12dc delete();
    }
    var_31678178 waittill(#"hash_350a84f");
    var_31678178 flag::clear("trap_plant_attacking");
    var_31678178 notify(#"hash_4ce89178");
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0xf627844a, Offset: 0x8950
// Size: 0x104
function function_b1a9e247(a_ents) {
    e_target = a_ents["spider"];
    var_31678178 = a_ents["plant_trap"];
    var_31678178 flag::set("trap_plant_attacking");
    var_31678178 waittill(#"hash_90b60e0f");
    if (isalive(e_target)) {
        self thread function_e6f615b3(e_target);
        e_target dodamage(e_target.health, e_target.origin);
    }
    var_31678178 waittill(#"hash_350a84f");
    var_31678178 flag::clear("trap_plant_attacking");
    var_31678178 notify(#"hash_4ce89178");
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x4199e8ea, Offset: 0x8a60
// Size: 0xba
function function_e6f615b3(e_target) {
    level thread namespace_f333593c::function_1e767f71(self.var_f2a52ffa.model, 600, "trap", "plant_kill", 60, 0, 2);
    if (zm_utility::is_player_valid(self.var_561a9c48)) {
        self.var_561a9c48 notify(#"hash_e6f615b3");
        self.var_561a9c48 notify("trap_plant_killed_" + e_target.archetype);
    }
    if (isdefined(self.var_e7abf7d0) && self.var_e7abf7d0) {
        level notify(#"hash_8c54f723");
    }
}

// Namespace namespace_7550a904
// Params 2, eflags: 0x0
// Checksum 0xac28cbc0, Offset: 0x8b28
// Size: 0x312
function function_7f34488a(str_loc, var_23237415) {
    if (!isdefined(var_23237415)) {
        var_23237415 = 0;
    }
    self.var_f2a52ffa.model util::waittill_any("spawn_head", "plant_melee");
    v_org = self.var_b17878ae[str_loc];
    foreach (player in level.players) {
        if (var_23237415 == 0) {
            str_stance = player getstance();
            if (str_stance != "stand") {
                continue;
            }
        }
        n_dist = distance2dsquared(player.origin, v_org);
        if (n_dist < 2304) {
            player dodamage(50, player.origin);
            player playrumbleonentity("damage_light");
            player namespace_f333593c::function_1881817("trap", "plant_attacked", 10, 3);
        }
    }
    var_da0978dc = getaiteamarray("axis");
    foreach (ai in var_da0978dc) {
        if (isdefined(ai.var_61f7b3a0) && ai.var_61f7b3a0) {
            n_dist = distance2dsquared(ai.origin, v_org);
            if (n_dist < 2304) {
                n_damage = ai.maxhealth * 0.25;
                ai dodamage(n_damage, ai.origin);
            }
        }
    }
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x826c0f7b, Offset: 0x8e48
// Size: 0x26
function function_2df6714(a_ents) {
    a_ents["plant_trap"] notify(#"hash_2df6714");
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x6c3e1af3, Offset: 0x8e78
// Size: 0x40
function function_869faee7() {
    level.func_clone_plant_respawn = &func_clone_plant_respawn;
    level.var_4cf8bbbd = &function_4cf8bbbd;
    level.var_50d5cc84 = 0;
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0xf12a8874, Offset: 0x8ec0
// Size: 0x414
function function_3e429652() {
    /#
        println("<unknown string>");
    #/
    level.var_50d5cc84++;
    if (isdefined(self.var_561a9c48)) {
        self.var_561a9c48 notify(#"hash_aa62194d");
    }
    level notify(#"hash_aa62194d");
    self.var_f2a52ffa.model setmodel("p7_fxanim_zm_island_plant_clone_grow_mod");
    self.var_f2a52ffa.model show();
    self.var_f2a52ffa.model solid();
    self.var_f2a52ffa.model disconnectpaths();
    self thread scene::init("p7_fxanim_zm_island_plant_clone_grow1_bundle", self.var_f2a52ffa.model);
    self.var_f2a52ffa.model waittill(#"hash_83d08c0f");
    self thread function_b78c42da();
    e_player = self waittill(#"hash_f7fd4ace");
    zm_unitrigger::unregister_unitrigger(self.var_23c5e7a6);
    self.var_23c5e7a6 = undefined;
    level zm_utility::function_fb450820();
    e_player thread function_15142bc5(self);
    e_player namespace_f333593c::function_7f4cb4c("clone", "imprint", 1);
    self thread scene::play("p7_fxanim_zm_island_plant_clone_grow1_bundle", self.var_f2a52ffa.model);
    str_notify = e_player util::waittill_any_return("player_clone_spawned", "clone_plant_overwritten", "disconnect");
    level zm_utility::function_53d28288();
    if (isdefined(e_player) && str_notify == "player_clone_spawned") {
        self function_14d216b1(e_player);
    }
    self.var_f2a52ffa.model clientfield::set("plant_growth_siege_anims", 0);
    self.var_f2a52ffa.model setmodel("p7_fxanim_zm_island_plant_clone_pop_mod");
    self.var_f2a52ffa.model notsolid();
    self scene::play("p7_fxanim_zm_island_plant_clone_pop_bundle", self.var_f2a52ffa.model);
    if (isdefined(e_player) && str_notify == "player_clone_spawned") {
        visionset_mgr::deactivate("visionset", "zm_isl_thrasher_stomach_visionset", e_player);
        e_player clientfield::set_to_player("player_spawned_from_clone_plant", 0);
        e_player clientfield::set_to_player("player_cloned_fx", 0);
        wait(3);
        if (isdefined(e_player)) {
            e_player zm_utility::function_36f941b3();
            e_player.var_6e61a720 = undefined;
        }
    }
    wait(0.05);
    self.var_f2a52ffa.model stopanimscripted();
    wait(0.05);
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x84d3171e, Offset: 0x92e0
// Size: 0x26c
function function_14d216b1(e_player) {
    e_player endon(#"disconnect");
    e_player.var_6e61a720 = 1;
    e_player lui::screen_fade_out(0.1);
    e_player zm_utility::function_139befeb();
    e_player clientfield::set_to_player("player_spawned_from_clone_plant", 1);
    e_player clientfield::set_to_player("player_cloned_fx", 1);
    visionset_mgr::activate("visionset", "zm_isl_thrasher_stomach_visionset", e_player, 2);
    e_player ghost();
    self thread scene::play("p_zom_plant_exit_bundle", e_player);
    wait(0.1);
    self.var_f2a52ffa.model hidepart("clone_body_jnt", "p7_fxanim_zm_island_plant_clone_grow_mod", 1);
    e_player show();
    e_player lui::screen_fade_in(1);
    e_player util::waittill_any_timeout(5, "disconnect", "player_emerge_from_clone_plant");
    e_player thread function_cbb90d18();
    self.var_f2a52ffa.model showpart("clone_body_jnt", "p7_fxanim_zm_island_plant_clone_grow_mod", 1);
    if (isdefined(level.var_5258ba34) && isdefined(e_player) && level.var_5258ba34) {
        if (zm_utility::is_player_valid(e_player) && e_player zm_zonemgr::entity_in_active_zone()) {
            e_player waittill(#"hash_84fb0f4d");
            e_player namespace_4e4a096c::function_75275516();
        }
    }
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x2e740ff5, Offset: 0x9558
// Size: 0x5c
function function_cbb90d18() {
    self endon(#"disconnect");
    self waittill(#"hash_84fb0f4d");
    self namespace_f333593c::function_cf8fccfe(0);
    self namespace_f333593c::function_7f4cb4c("clone", "cloned", 1);
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0xe967366c, Offset: 0x95c0
// Size: 0x14c
function function_b78c42da() {
    var_c27b0ccb = spawnstruct();
    var_c27b0ccb.origin = self.origin + (0, 0, 8);
    var_c27b0ccb.angles = self.angles;
    var_c27b0ccb.s_parent = self;
    var_c27b0ccb.script_unitrigger_type = "unitrigger_box_use";
    var_c27b0ccb.cursor_hint = "HINT_NOICON";
    var_c27b0ccb.require_look_at = 1;
    var_c27b0ccb.script_width = 100;
    var_c27b0ccb.script_length = 100;
    var_c27b0ccb.script_height = -106;
    var_c27b0ccb.prompt_and_visibility_func = &function_d4d40251;
    zm_unitrigger::register_static_unitrigger(var_c27b0ccb, &function_7756fe45);
    self.var_23c5e7a6 = var_c27b0ccb;
    self.var_f2a52ffa flag::clear("plant_interact_trigger_used");
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x608a5066, Offset: 0x9718
// Size: 0x172
function function_d4d40251(e_player) {
    if (e_player zm_utility::in_revive_trigger()) {
        self sethintstring(%);
        return 0;
    }
    if (e_player.is_drinking > 0) {
        self sethintstring(%);
        return 0;
    }
    if (!zm_utility::is_player_valid(e_player)) {
        self sethintstring(%);
        return 0;
    }
    if (!e_player zm_magicbox::can_buy_weapon()) {
        self sethintstring(%);
        return 0;
    }
    if (self.stub.s_parent.var_f2a52ffa flag::get("plant_interact_trigger_used")) {
        self sethintstring(%);
        return 0;
    }
    self sethintstring(%ZM_ISLAND_CLONE_PLANT);
    return 1;
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x2375bc9e, Offset: 0x9898
// Size: 0xf2
function function_7756fe45() {
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
        if (!e_who zm_magicbox::can_buy_weapon()) {
            continue;
        }
        self.stub.s_parent notify(#"hash_f7fd4ace", e_who);
        self.stub.s_parent.var_f2a52ffa flag::set("plant_interact_trigger_used");
        return;
    }
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x3790853d, Offset: 0x9998
// Size: 0x57c
function function_15142bc5(var_f2a52ffa) {
    self endon(#"disconnect");
    if (isdefined(self.s_clone_plant)) {
        self notify(#"hash_7114186c");
    }
    self.s_clone_plant = var_f2a52ffa;
    self.var_5942b967 = spawnstruct();
    if (isdefined(self.perks_active)) {
        self.var_5942b967.a_perks = [];
        foreach (perk in self.perks_active) {
            array::add(self.var_5942b967.a_perks, perk, 0);
        }
    }
    if (bgb::is_enabled("zm_bgb_disorderly_combat") && isdefined(self.var_fe555a38)) {
        self.var_5942b967.w_current_weapon = self.var_fe555a38;
    } else {
        self.var_5942b967.w_current_weapon = self getcurrentweapon();
    }
    self.var_5942b967.aat = self.aat;
    self.var_5942b967.var_6a4d6d26 = 0;
    var_c5716cdc = self getweaponslist(1);
    self.var_5942b967.a_weapons = [];
    foreach (weapon in var_c5716cdc) {
        if (bgb::is_enabled("zm_bgb_disorderly_combat")) {
            if (self.var_8cee13f3 === weapon) {
                continue;
            }
        }
        var_e59ac7e4 = zm_weapons::get_nonalternate_weapon(weapon);
        if (weapon != var_e59ac7e4) {
            continue;
        }
        if (weapon == level.var_c003f5b) {
            self.var_5942b967.var_6a4d6d26 = 1;
            self.var_5942b967.var_64d58722 = self gadgetpowerget(0);
            continue;
        }
        n_index = self.var_5942b967.a_weapons.size;
        self.var_5942b967.a_weapons[n_index] = spawnstruct();
        self.var_5942b967.a_weapons[n_index].weapon = weapon;
        self.var_5942b967.a_weapons[n_index].var_588c8ca8 = self getweaponammoclip(weapon);
        self.var_5942b967.a_weapons[n_index].var_570f77cc = 0;
        var_bc62c240 = weapon.dualwieldweapon;
        if (level.weaponnone != var_bc62c240) {
            self.var_5942b967.a_weapons[n_index].var_570f77cc = self getweaponammoclip(var_bc62c240);
        }
        self.var_5942b967.a_weapons[n_index].var_c9dc24c2 = self getweaponammostock(weapon);
    }
    self.var_5942b967.n_score = self.score;
    self.var_5942b967.bgb = self.bgb;
    self.var_5942b967.var_2ecea42d = self clientfield::get_to_player("bucket_held");
    if (!self.var_5942b967.var_2ecea42d) {
        self.var_5942b967.var_bb2fd41c = 0;
        self.var_5942b967.var_c6cad973 = 0;
    } else {
        self.var_5942b967.var_bb2fd41c = self.var_bb2fd41c;
        self.var_5942b967.var_c6cad973 = self.var_c6cad973;
    }
    self.var_5942b967.var_f65b973 = namespace_e37c032f::function_735cfef2(self);
    self.var_5942b967.var_1493e376 = self.var_df4182b1;
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x54aaec76, Offset: 0x9f20
// Size: 0x862
function func_clone_plant_respawn() {
    self endon(#"disconnect");
    self thread namespace_f333593c::function_cf8fccfe(1);
    if (isdefined(self.var_9d35623c) && self.var_9d35623c) {
        namespace_5d6075c6::function_9e2a4fa2(self.thrasher, self);
    }
    self notify(#"stop_revive_trigger");
    wait(0.05);
    self setorigin(self.s_clone_plant.origin);
    self setplayerangles(self.s_clone_plant.angles);
    self.s_clone_plant = undefined;
    self zm_laststand::auto_revive(self);
    wait(0.05);
    /#
        assert(isdefined(self.var_5942b967));
    #/
    if (isdefined(self.var_5942b967.a_perks)) {
        foreach (perk in self.var_5942b967.a_perks) {
            self zm_perks::give_perk(perk);
        }
    }
    /#
        assert(isdefined(self.var_5942b967.a_weapons));
    #/
    /#
        assert(isdefined(self.var_5942b967.w_current_weapon));
    #/
    var_c5716cdc = self getweaponslist(1);
    foreach (weapon in var_c5716cdc) {
        if (weapon == level.var_c003f5b) {
            self zm_weapons::weapon_take(weapon);
            self zm_hero_weapon::function_eca1a7bb(level.var_c003f5b, 0);
            self thread namespace_5f2c95ae::function_29d2aa0e(0, undefined, 0);
            self notify(#"hash_6026b04e");
            self notify(#"hash_ca7b8f26");
            self notify(#"hash_a3acc0f8");
            self notify(#"hash_554fa98b");
            self notify(#"hash_ebde8383");
            self notify(#"hash_8851ed94");
            self zm_hero_weapon::on_player_spawned();
            continue;
        }
        self zm_weapons::weapon_take(weapon);
    }
    foreach (s_info in self.var_5942b967.a_weapons) {
        if (s_info.weapon.isriotshield) {
            self.do_not_display_equipment_pickup_hint = 1;
            self thread function_da2cdc7f();
            self zm_equipment::give(s_info.weapon);
            if (isdefined(self.player_shield_reset_health)) {
                self [[ self.player_shield_reset_health ]]();
            }
            continue;
        }
        weapon = self zm_weapons::give_build_kit_weapon(s_info.weapon.rootweapon);
        self setweaponammoclip(weapon, s_info.var_588c8ca8);
        var_bc62c240 = weapon.dualwieldweapon;
        if (level.weaponnone != var_bc62c240) {
            self setweaponammoclip(var_bc62c240, s_info.var_570f77cc);
        }
        self setweaponammostock(weapon, s_info.var_c9dc24c2);
        a_keys = getarraykeys(self.var_5942b967.aat);
        if (isinarray(a_keys, weapon)) {
            self aat::acquire(weapon, self.var_5942b967.aat[weapon]);
        }
    }
    if (self.var_5942b967.var_6a4d6d26 == 1) {
        self thread function_a0e11c4();
    }
    self switchtoweapon(self.var_5942b967.w_current_weapon);
    /#
        assert(isdefined(self.var_5942b967.n_score));
    #/
    self.score = self.var_5942b967.n_score;
    self.pers["score"] = self.score;
    function_594d2bdf(1);
    self bgb::function_d35f60a1(self.var_5942b967.bgb);
    function_594d2bdf(0);
    /#
        assert(isdefined(self.var_5942b967.var_2ecea42d));
    #/
    if (!self.var_5942b967.var_2ecea42d && self clientfield::get_to_player("bucket_held")) {
        self notify(#"hash_529dcae8");
    } else {
        self.var_bb2fd41c = self.var_5942b967.var_bb2fd41c;
        self.var_c6cad973 = self.var_5942b967.var_c6cad973;
        self namespace_f3e3de78::function_ef097ea(self.var_c6cad973, self.var_bb2fd41c, self namespace_f3e3de78::function_89538fbb(), 1);
    }
    /#
        assert(isdefined(self.var_5942b967.var_f65b973));
    #/
    self namespace_e37c032f::function_aeda54f6(self.var_5942b967.var_f65b973);
    /#
        assert(isdefined(self.var_5942b967.var_1493e376));
    #/
    self.var_df4182b1 = self.var_5942b967.var_1493e376;
    if (!self.var_df4182b1) {
        self notify(#"hash_7cbf7e55");
    } else {
        self notify(#"hash_b5ecf1dd");
    }
    self notify(#"hash_146f25b");
    self notify(#"hash_6c52e305");
    self.var_5942b967 = undefined;
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0xe18e7c56, Offset: 0xa790
// Size: 0x24
function function_da2cdc7f() {
    self endon(#"disconnect");
    wait(1);
    self.do_not_display_equipment_pickup_hint = 0;
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x39f8ab85, Offset: 0xa7c0
// Size: 0x12c
function function_a0e11c4() {
    self endon(#"disconnect");
    self zm_weapons::weapon_give(level.var_c003f5b, undefined, undefined, 1);
    self gadgetpowerset(0, self.var_5942b967.var_64d58722);
    self setweaponammoclip(level.var_c003f5b, 0);
    power = self gadgetpowerget(0);
    if (power < 100) {
        self zm_hero_weapon::function_eca1a7bb(level.var_c003f5b, 1);
    } else {
        self zm_hero_weapon::function_eca1a7bb(level.var_c003f5b, 2);
    }
    self thread namespace_5f2c95ae::function_29d2aa0e(3, undefined, 0);
    self thread zm_hero_weapon::function_6026b04e();
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x7333fb15, Offset: 0xa8f8
// Size: 0x1e
function function_4cf8bbbd() {
    if (isdefined(self.s_clone_plant)) {
        return 1;
    }
    return 0;
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0xe4fe915e, Offset: 0xa920
// Size: 0x5c
function function_1b391116() {
    level.var_5ef907c8 = getweapon("fruit_eat_success");
    level.var_8a542f3f = getweapon("fruit_eat_fail");
    level thread function_a823cd4e();
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x5d9ae887, Offset: 0xa988
// Size: 0xdc
function function_a823cd4e() {
    zm_perk_random::include_perk_in_random_rotation("specialty_armorvest");
    zm_perk_random::include_perk_in_random_rotation("specialty_quickrevive");
    zm_perk_random::include_perk_in_random_rotation("specialty_fastreload");
    zm_perk_random::include_perk_in_random_rotation("specialty_doubletap2");
    zm_perk_random::include_perk_in_random_rotation("specialty_staminup");
    zm_perk_random::include_perk_in_random_rotation("specialty_additionalprimaryweapon");
    zm_perk_random::include_perk_in_random_rotation("specialty_deadshot");
    zm_perk_random::include_perk_in_random_rotation("specialty_electriccherry");
    zm_perk_random::include_perk_in_random_rotation("specialty_widowswine");
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x7fd194b4, Offset: 0xaa70
// Size: 0x3bc
function function_fd098f17(b_upgraded) {
    if (!isdefined(b_upgraded)) {
        b_upgraded = 0;
    }
    /#
        if (b_upgraded == 1) {
            println("<unknown string>");
        } else {
            println("<unknown string>");
        }
    #/
    if (isdefined(self.var_561a9c48)) {
        self.var_561a9c48 notify(#"hash_d4406954");
    }
    level notify(#"hash_d4406954");
    if (b_upgraded == 1) {
        var_d583f9d = "p7_fxanim_zm_island_plant_fruit_glow_mod";
    } else {
        var_d583f9d = "p7_fxanim_zm_island_plant_fruit_mod";
    }
    self.var_f2a52ffa.model setmodel(var_d583f9d);
    self.var_f2a52ffa.model show();
    self.var_f2a52ffa.model solid();
    self.var_f2a52ffa.model disconnectpaths();
    self thread scene::init("p7_fxanim_zm_island_plant_fruit_bundle", self.var_f2a52ffa.model);
    self.var_f2a52ffa.model waittill(#"hash_334ee3df");
    self thread function_bf89dc95();
    e_player = self waittill(#"hash_f224e16d");
    zm_unitrigger::unregister_unitrigger(self.var_23c5e7a6);
    self.var_23c5e7a6 = undefined;
    e_player notify(#"hash_3e1e1a8");
    if (b_upgraded == 1) {
        if (e_player zm_utility::can_player_purchase_perk()) {
            level thread function_cccc72b3(e_player);
        } else {
            level thread function_cc0c1582(e_player);
        }
    } else {
        n_chance = randomfloatrange(0, 100);
        if (n_chance <= 75) {
            if (e_player zm_utility::can_player_purchase_perk()) {
                level thread function_cccc72b3(e_player);
            } else {
                level thread function_cc0c1582(e_player);
            }
        } else {
            level thread function_cc0c1582(e_player);
        }
    }
    self.var_f2a52ffa.model clientfield::set("plant_growth_siege_anims", 0);
    self.var_f2a52ffa.model hidepart("plant_fruit_stalk_egg_hide_jnt", var_d583f9d);
    self scene::play("p7_fxanim_zm_island_plant_fruit_bundle", self.var_f2a52ffa.model);
    self.var_f2a52ffa.model showpart("plant_fruit_stalk_egg_hide_jnt", var_d583f9d);
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0xbe1e2dad, Offset: 0xae38
// Size: 0x14c
function function_bf89dc95() {
    var_c27b0ccb = spawnstruct();
    var_c27b0ccb.origin = self.origin + (0, 0, 8);
    var_c27b0ccb.angles = self.angles;
    var_c27b0ccb.s_parent = self;
    var_c27b0ccb.script_unitrigger_type = "unitrigger_box_use";
    var_c27b0ccb.cursor_hint = "HINT_NOICON";
    var_c27b0ccb.require_look_at = 1;
    var_c27b0ccb.script_width = 100;
    var_c27b0ccb.script_length = 100;
    var_c27b0ccb.script_height = -106;
    var_c27b0ccb.prompt_and_visibility_func = &function_7187558;
    zm_unitrigger::register_static_unitrigger(var_c27b0ccb, &function_c31605a8);
    self.var_23c5e7a6 = var_c27b0ccb;
    self.var_f2a52ffa flag::clear("plant_interact_trigger_used");
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x3078b88, Offset: 0xaf90
// Size: 0x13a
function function_7187558(e_player) {
    if (e_player zm_utility::in_revive_trigger()) {
        self sethintstring(%);
        return 0;
    }
    if (e_player.is_drinking > 0) {
        self sethintstring(%);
        return 0;
    }
    if (!zm_utility::is_player_valid(e_player)) {
        self sethintstring(%);
        return 0;
    }
    if (self.stub.s_parent.var_f2a52ffa flag::get("plant_interact_trigger_used")) {
        self sethintstring(%);
        return 0;
    }
    self sethintstring(%ZM_ISLAND_FRUIT_PLANT);
    return 1;
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x6a0ecd42, Offset: 0xb0d8
// Size: 0xd2
function function_c31605a8() {
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
        self.stub.s_parent notify(#"hash_f224e16d", e_who);
        self.stub.s_parent.var_f2a52ffa flag::set("plant_interact_trigger_used");
        return;
    }
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x848d92f, Offset: 0xb1b8
// Size: 0xd0
function function_cccc72b3(e_player) {
    e_player endon(#"disconnect");
    e_player function_3d33e23e(1);
    random_perk = zm_perk_random::get_weighted_random_perk(e_player);
    e_player thread zm_perks::wait_give_perk(random_perk);
    e_player notify(#"hash_7285e7d");
    /#
        println("<unknown string>" + random_perk);
    #/
    e_player notify(#"hash_c66c9950");
    e_player notify(#"perk_purchased", random_perk);
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x5b204824, Offset: 0xb290
// Size: 0x84
function function_cc0c1582(e_player) {
    e_player endon(#"disconnect");
    /#
        println("<unknown string>");
    #/
    e_player thread function_3d33e23e(0);
    e_player thread namespace_f333593c::function_6fc10b64();
    e_player giveachievement("ZM_ISLAND_EAT_FRUIT");
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x69c98371, Offset: 0xb320
// Size: 0xe6
function function_3d33e23e(b_success) {
    if (!isdefined(b_success)) {
        b_success = 1;
    }
    self endon(#"disconnect");
    self thread function_afacd209();
    self.var_db9c1f55 = 0;
    self thread function_7a0f914c(b_success);
    self util::waittill_any("fake_death", "death", "player_downed", "weapon_change_complete", "player_cancel_fruit_eat");
    self function_37e9f650(b_success);
    var_7cf98153 = undefined;
    self.var_db9c1f55 = 0;
    self notify(#"hash_68922ea0");
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x14f0aedb, Offset: 0xb410
// Size: 0x5a
function function_afacd209() {
    self endon(#"disconnect");
    self endon(#"hash_68922ea0");
    self waittill(#"hash_89eb445c");
    if (self.is_drinking > 0) {
        self zm_utility::decrement_is_drinking();
    }
    self notify(#"hash_68922ea0");
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x438e861d, Offset: 0xb478
// Size: 0x1c4
function function_7a0f914c(b_success) {
    self endon(#"disconnect");
    if (!(self.is_drinking > 0)) {
        self zm_utility::increment_is_drinking();
    }
    w_original = self getcurrentweapon();
    var_c9d7dbd3 = function_d60b4013(b_success);
    if (w_original != level.weaponnone && !(isdefined(zm_utility::is_placeable_mine(w_original)) && zm_utility::is_placeable_mine(w_original)) && !(isdefined(zm_equipment::is_equipment(w_original)) && zm_equipment::is_equipment(w_original)) && !(isdefined(self zm_laststand::is_reviving_any()) && self zm_laststand::is_reviving_any()) && !(isdefined(self laststand::player_is_in_laststand()) && self laststand::player_is_in_laststand())) {
        self.original_weapon = w_original;
    } else {
        self notify(#"hash_506d980b");
        return;
    }
    self.var_db9c1f55 = 1;
    self zm_utility::disable_player_move_states(1);
    self giveweapon(var_c9d7dbd3);
    self switchtoweapon(var_c9d7dbd3);
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x49a6513c, Offset: 0xb648
// Size: 0x1cc
function function_37e9f650(b_success) {
    self endon(#"disconnect");
    self zm_utility::enable_player_move_states();
    var_c9d7dbd3 = function_d60b4013(b_success);
    if (isdefined(self.intermission) && (self laststand::player_is_in_laststand() || self.intermission)) {
        self takeweapon(var_c9d7dbd3);
        return;
    }
    if (self.is_drinking > 0) {
        self zm_utility::decrement_is_drinking();
    }
    a_primaries = self getweaponslistprimaries();
    self takeweapon(var_c9d7dbd3);
    if (self.is_drinking > 0) {
        return;
    }
    if (isdefined(self.original_weapon)) {
        self switchtoweapon(self.original_weapon);
        return;
    }
    if (isdefined(a_primaries) && a_primaries.size > 0) {
        self switchtoweapon(a_primaries[0]);
        return;
    }
    if (self hasweapon(level.laststandpistol)) {
        self switchtoweapon(level.laststandpistol);
        return;
    }
    self zm_weapons::give_fallback_weapon();
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0xa7c656d6, Offset: 0xb820
// Size: 0x44
function function_d60b4013(b_success) {
    if (b_success == 1) {
        var_c9d7dbd3 = level.var_5ef907c8;
    } else {
        var_c9d7dbd3 = level.var_8a542f3f;
    }
    return var_c9d7dbd3;
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x1e5885ff, Offset: 0xb870
// Size: 0x184
function function_5726c670(var_98b687fa) {
    if (level flag::get("ww_obtained") && !level flag::get("ww_upgrade_spawned_from_plant") && var_98b687fa == 3) {
        self.var_f2a52ffa.model setmodel("p7_fxanim_zm_island_plant_underwater_teal_mod");
        self.var_f2a52ffa.model show();
        self.var_f2a52ffa.model solid();
        self.var_f2a52ffa.model disconnectpaths();
        self scene::play("p7_fxanim_zm_island_plant_underwater_bundle", self.var_f2a52ffa.model);
        level flag::set("ww_upgrade_spawned_from_plant");
        level flag::wait_till("wwup3_found");
        self.var_f2a52ffa.model clientfield::set("plant_growth_siege_anims", 0);
        return;
    }
    return;
}

// Namespace namespace_7550a904
// Params 3, eflags: 0x0
// Checksum 0x43b1911a, Offset: 0xba00
// Size: 0x2a8
function function_e07a8850(var_6413b107, var_c74eff46, var_c6fcdf22) {
    if (!isdefined(var_c6fcdf22)) {
        var_c6fcdf22 = undefined;
    }
    v_spawnpt = self.origin + (0, 0, 40);
    var_f8c6b1d7 = (0, 0, 0);
    v_angles = var_6413b107 getplayerangles();
    v_angles = (0, v_angles[1], 0) + (0, 90, 0) + var_f8c6b1d7;
    m_weapon = zm_utility::spawn_buildkit_weapon_model(var_6413b107, var_c74eff46, undefined, v_spawnpt, v_angles);
    m_weapon.angles = v_angles;
    m_weapon thread timer_til_despawn(v_spawnpt, 40 * -1);
    m_weapon endon(#"hash_8bc1969d");
    m_weapon.trigger = namespace_8aed53c9::function_d095318(v_spawnpt, 100, 1);
    m_weapon.trigger.wpn = var_c74eff46;
    m_weapon.trigger.prompt_and_visibility_func = &function_3674f451;
    m_weapon.trigger flag::init("weapon_grabbed_or_timed_out");
    player = m_weapon.trigger waittill(#"trigger");
    m_weapon notify(#"weapon_grabbed");
    player thread namespace_8aed53c9::swap_weapon(var_c74eff46);
    if (isdefined(m_weapon.trigger)) {
        m_weapon.trigger flag::set("weapon_grabbed_or_timed_out");
        zm_unitrigger::unregister_unitrigger(m_weapon.trigger);
        m_weapon.trigger = undefined;
    }
    if (isdefined(m_weapon)) {
        m_weapon delete();
    }
    if (player != var_6413b107) {
        var_6413b107 notify(#"hash_f8352f34");
    }
}

// Namespace namespace_7550a904
// Params 2, eflags: 0x0
// Checksum 0xc25fb6a6, Offset: 0xbcb0
// Size: 0x14c
function timer_til_despawn(v_float, n_dist) {
    self endon(#"weapon_grabbed");
    wait(15);
    for (i = 0; i < 40; i++) {
        if (i % 2) {
            self weapon_show(0);
        } else {
            self weapon_show(1);
        }
        if (i < 15) {
            wait(0.5);
            continue;
        }
        if (i < 25) {
            wait(0.25);
            continue;
        }
        wait(0.1);
    }
    self notify(#"hash_8bc1969d");
    if (isdefined(self.trigger)) {
        self.trigger flag::set("weapon_grabbed_or_timed_out");
        zm_unitrigger::unregister_unitrigger(self.trigger);
        self.trigger = undefined;
    }
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x5736ab70, Offset: 0xbe08
// Size: 0x94
function weapon_show(visible) {
    if (!visible) {
        self ghost();
        if (isdefined(self.worldgundw)) {
            self.worldgundw ghost();
        }
        return;
    }
    self show();
    if (isdefined(self.worldgundw)) {
        self.worldgundw show();
    }
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x6d5b9cf8, Offset: 0xbea8
// Size: 0x130
function function_3674f451(player) {
    if (!zm_utility::is_player_valid(player) || player.is_drinking > 0 || !player zm_magicbox::can_buy_weapon() || player bgb::is_enabled("zm_bgb_disorderly_combat")) {
        self sethintstring(%);
        return false;
    }
    if (self.stub flag::get("weapon_grabbed_or_timed_out")) {
        self sethintstring(%);
        return false;
    }
    self setcursorhint("HINT_WEAPON", self.stub.wpn);
    self sethintstring(%ZOMBIE_TRADE_WEAPON_FILL);
    return true;
}

// Namespace namespace_7550a904
// Params 2, eflags: 0x0
// Checksum 0xcf197fd0, Offset: 0xbfe0
// Size: 0xa8
function function_15c62ca8(v_pos, radius) {
    v_origin = getclosestpointonnavmesh(v_pos, radius);
    if (!isdefined(v_origin)) {
        e_player = zm_utility::get_closest_player(v_pos);
        v_origin = getclosestpointonnavmesh(e_player.origin, radius);
    }
    if (!isdefined(v_origin)) {
        v_origin = v_pos;
    }
    return v_origin;
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x72c63c09, Offset: 0xc090
// Size: 0x84
function function_688119e4() {
    self endon(#"death");
    a_perks = self getperks();
    n_perks = a_perks.size;
    if (isdefined(self.var_53690301) && n_perks < self.var_53690301) {
        return true;
    } else if (n_perks < level.perk_purchase_limit) {
        return true;
    }
    return false;
}

// Namespace namespace_7550a904
// Params 0, eflags: 0x0
// Checksum 0x21b0ad31, Offset: 0xc120
// Size: 0x48
function function_61d38f32() {
    self endon(#"powerup_timedout");
    self waittill(#"powerup_grabbed");
    if (zm_utility::is_player_valid(self.power_up_grab_player)) {
        self.power_up_grab_player notify(#"hash_61bbe625");
    }
}

// Namespace namespace_7550a904
// Params 2, eflags: 0x0
// Checksum 0xf6ff7d13, Offset: 0xc170
// Size: 0x176
function function_160d5071(var_f2a52ffa, str_anim) {
    self endon(#"death");
    self endon(#"hash_e9a97726");
    var_f2a52ffa endon(#"hash_4729ad2");
    v_goal = getstartorigin(var_f2a52ffa.origin, var_f2a52ffa.angles, str_anim);
    v_goal = getclosestpointonnavmesh(v_goal);
    /#
        assert(isdefined(v_goal), "<unknown string>" + var_f2a52ffa.origin + "<unknown string>" + str_anim);
    #/
    self.v_zombie_custom_goal_pos = v_goal;
    self.n_zombie_custom_goal_radius = 8;
    self thread function_b0fddaee(var_f2a52ffa);
    while (true) {
        n_delta = distancesquared(v_goal, self.origin);
        if (n_delta > 256) {
            wait(0.05);
            continue;
        }
        break;
    }
    self.v_zombie_custom_goal_pos = undefined;
    wait(0.05);
    self notify(#"hash_d668a33b");
}

// Namespace namespace_7550a904
// Params 1, eflags: 0x0
// Checksum 0x4cefe81b, Offset: 0xc2f0
// Size: 0x3e
function function_b0fddaee(var_f2a52ffa) {
    self endon(#"death");
    var_f2a52ffa waittill(#"hash_4729ad2");
    if (isdefined(self.v_zombie_custom_goal_pos)) {
        self.v_zombie_custom_goal_pos = undefined;
    }
}

// Namespace namespace_7550a904
// Params 2, eflags: 0x0
// Checksum 0xf9dcedc, Offset: 0xc338
// Size: 0x9e
function function_40428876(var_f2a52ffa, str_anim) {
    self endon(#"death");
    v_goal = getstartorigin(var_f2a52ffa.origin, var_f2a52ffa.angles, str_anim);
    self vehicle_ai::start_scripted();
    self setvehgoalpos(v_goal);
    self waittill(#"goal");
    self notify(#"hash_d668a33b");
}

/#

    // Namespace namespace_7550a904
    // Params 0, eflags: 0x0
    // Checksum 0x8449de0a, Offset: 0xc3e0
    // Size: 0x14c
    function function_e851ad39() {
        zm_devgui::add_custom_devgui_callback(&function_2dbcc8ad);
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
    }

    // Namespace namespace_7550a904
    // Params 1, eflags: 0x0
    // Checksum 0x45f2d7c9, Offset: 0xc538
    // Size: 0x182
    function function_2dbcc8ad(cmd) {
        switch (cmd) {
        case 0:
        case 0:
        case 0:
        case 0:
        case 0:
        case 0:
        case 0:
        case 0:
        case 0:
        case 0:
        case 0:
            level thread function_b529e6f4(cmd);
            return 1;
        default:
            foreach (var_a68e9e1 in level.var_ac51aa3c) {
                if (!(isdefined(var_a68e9e1.var_75c7a97e) && var_a68e9e1.var_75c7a97e)) {
                    var_a68e9e1.var_75c7a97e = 1;
                    var_a68e9e1 notify(#"hash_378095a2");
                    var_a68e9e1 thread function_ae64b39a(undefined, undefined, 1);
                }
            }
            return 1;
        }
        return 0;
    }

    // Namespace namespace_7550a904
    // Params 1, eflags: 0x0
    // Checksum 0x9b4e8c7d, Offset: 0xc6c8
    // Size: 0x44e
    function function_b529e6f4(cmd) {
        switch (cmd) {
        case 0:
            var_a68e9e1 = level.players[0] function_c3cee22e();
            if (isdefined(var_a68e9e1)) {
                var_a68e9e1 notify(#"hash_378095a2");
                var_a68e9e1 thread function_ae64b39a(0);
            }
            break;
        case 0:
            var_a68e9e1 = level.players[0] function_c3cee22e();
            if (isdefined(var_a68e9e1)) {
                var_a68e9e1 notify(#"hash_378095a2");
                var_a68e9e1 thread function_ae64b39a(1);
            }
            break;
        case 0:
            var_a68e9e1 = level.players[0] function_c3cee22e();
            if (isdefined(var_a68e9e1)) {
                var_a68e9e1 notify(#"hash_378095a2");
                var_a68e9e1 thread function_ae64b39a(2);
            }
            break;
        case 0:
            var_a68e9e1 = level.players[0] function_c3cee22e();
            if (isdefined(var_a68e9e1)) {
                var_a68e9e1 notify(#"hash_378095a2");
                var_a68e9e1 thread function_ae64b39a(3);
            }
            break;
        case 0:
            var_a68e9e1 = level.players[0] function_c3cee22e();
            if (isdefined(var_a68e9e1)) {
                var_a68e9e1 notify(#"hash_378095a2");
                var_a68e9e1 thread function_ae64b39a(4);
            }
            break;
        default:
            var_a68e9e1 = level.players[0] function_c3cee22e();
            if (isdefined(var_a68e9e1)) {
                var_a68e9e1 notify(#"hash_378095a2");
                var_a68e9e1 thread function_ae64b39a(5);
            }
            break;
        case 0:
            var_a68e9e1 = level.players[0] function_c3cee22e();
            if (isdefined(var_a68e9e1)) {
                var_a68e9e1 notify(#"hash_378095a2");
                var_a68e9e1 thread function_ae64b39a(6);
            }
            break;
        case 0:
            var_a68e9e1 = level.players[0] function_c3cee22e();
            if (isdefined(var_a68e9e1)) {
                var_a68e9e1 notify(#"hash_378095a2");
                var_a68e9e1 thread function_ae64b39a(7);
            }
            break;
        case 0:
            var_a68e9e1 = level.players[0] function_c3cee22e();
            if (isdefined(var_a68e9e1)) {
                var_a68e9e1 notify(#"hash_378095a2");
                var_a68e9e1 thread function_ae64b39a(8);
            }
            break;
        case 0:
            var_a68e9e1 = level.players[0] function_c3cee22e();
            if (isdefined(var_a68e9e1)) {
                var_a68e9e1 notify(#"hash_378095a2");
                var_a68e9e1 thread function_ae64b39a(9);
            }
            break;
        case 0:
            var_a68e9e1 = level.players[0] function_c3cee22e();
            if (isdefined(var_a68e9e1)) {
                var_a68e9e1 notify(#"hash_378095a2");
                var_a68e9e1 thread function_ae64b39a(10);
            }
            break;
        }
    }

    // Namespace namespace_7550a904
    // Params 0, eflags: 0x0
    // Checksum 0x26af77dc, Offset: 0xcb20
    // Size: 0xa6
    function function_c3cee22e() {
        var_5eaa768a = level.var_ac51aa3c;
        n_index = zm_utility::get_closest_index(self.origin, var_5eaa768a);
        s_spot = var_5eaa768a[n_index];
        if (!(isdefined(s_spot.var_75c7a97e) && s_spot.var_75c7a97e)) {
            s_spot.var_75c7a97e = 1;
            return s_spot;
        }
        return undefined;
    }

#/
