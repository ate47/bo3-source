#using scripts/cp/_hacking;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_hazard;
#using scripts/cp/_dialog;
#using scripts/cp/_debug;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/gametypes/_save;
#using scripts/codescripts/struct;

#namespace zurich_util;

// Namespace zurich_util
// Params 0, eflags: 0x2
// Checksum 0x4befddbc, Offset: 0x1a18
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zurich_util", &__init__, undefined, undefined);
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x9aa39399, Offset: 0x1a58
// Size: 0x16a
function __init__() {
    level.lighting_state = 0;
    callback::on_spawned(&on_player_spawned);
    callback::on_disconnect(&on_player_disconnect);
    callback::on_actor_killed(&function_c3e494e3);
    spawner::add_global_spawn_function("axis", &function_dc8f9fa6);
    spawner::add_global_spawn_function("axis", &function_c412aad5);
    spawner::add_global_spawn_function("team3", &function_dc8f9fa6);
    spawner::add_global_spawn_function("axis", &function_b2c5d91c);
    util::function_b499f765();
    init_client_field_callback_funcs();
    level._effect["root_heart_fire"] = "fire/fx_fire_heart_burn_zurich";
    level._effect["hand_vine_fire"] = "fire/fx_fire_ai_human_hand_vm";
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x9edefb4b, Offset: 0x1bd0
// Size: 0x61c
function init_client_field_callback_funcs() {
    var_2d20335b = getminbitcountfornum(5);
    var_a9ef5da3 = getminbitcountfornum(6);
    visionset_mgr::register_info("visionset", "cp_zurich_hallucination", 1, 100, 1, 1);
    clientfield::register("actor", "exploding_ai_deaths", 1, 1, "int");
    clientfield::register("actor", "hero_spawn_fx", 1, 1, "int");
    clientfield::register("scriptmover", "hero_spawn_fx", 1, 1, "int");
    clientfield::register("scriptmover", "vehicle_spawn_fx", 1, 1, "int");
    clientfield::register("toplayer", "set_world_fog", 1, 1, "int");
    clientfield::register("scriptmover", "raven_juke_effect", 1, 1, "counter");
    clientfield::register("actor", "raven_juke_limb_effect", 1, 1, "counter");
    clientfield::register("scriptmover", "raven_teleport_effect", 1, 1, "counter");
    clientfield::register("actor", "raven_teleport_limb_effect", 1, 1, "counter");
    clientfield::register("scriptmover", "raven_teleport_in_effect", 1, 1, "counter");
    clientfield::register("toplayer", "player_weather", 1, var_2d20335b, "int");
    clientfield::register("toplayer", "vortex_teleport", 1, 1, "counter");
    clientfield::register("toplayer", "postfx_futz", 1, 1, "counter");
    clientfield::register("toplayer", "postfx_futz_mild", 1, 1, "counter");
    clientfield::register("toplayer", "postfx_transition", 1, 1, "counter");
    clientfield::register("world", "zurich_city_ambience", 1, 1, "int");
    clientfield::register("actor", "skin_transition_melt", 1, 1, "int");
    clientfield::register("scriptmover", "corvus_body_fx", 1, 1, "int");
    clientfield::register("actor", "raven_ai_rez", 1, 1, "int");
    clientfield::register("scriptmover", "raven_ai_rez", 1, 1, "int");
    clientfield::register("toplayer", "zurich_server_cam", 1, 1, "int");
    clientfield::register("world", "set_exposure_bank", 1, 1, "int");
    clientfield::register("scriptmover", "corvus_tree_shader", 1, 1, "int");
    clientfield::register("actor", "hero_cold_breath", 1, 1, "int");
    clientfield::register("world", "set_post_color_grade_bank", 1, 1, "int");
    clientfield::register("toplayer", "postfx_hallucinations", 1, 1, "counter");
    clientfield::register("toplayer", "player_water_transition", 1, 1, "int");
    clientfield::register("toplayer", "raven_hallucinations", 1, 1, "int");
    clientfield::register("scriptmover", "quadtank_raven_explosion", 1, 1, "int");
    clientfield::register("scriptmover", "raven_fade_out", 1, 1, "int");
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x9f1cfe71, Offset: 0x21f8
// Size: 0x4ca
function on_player_spawned() {
    var_aace7bde = skipto::function_8b19ec5d();
    /#
        self thread function_e8b99762();
    #/
    if (isdefined(var_aace7bde)) {
        switch (var_aace7bde[0]) {
        case "zurich":
            self player_weather(1, "regular_snow");
            break;
        case "street":
            self player_weather(1, "regular_snow");
            self thread util::player_frost_breath(1);
            break;
        case "rails":
            self player_weather(1, "regular_snow");
            self thread util::player_frost_breath(1);
            break;
        case "plaza_battle":
            self player_weather(1, "regular_snow");
            self thread util::player_frost_breath(1);
            level thread function_df1fc23b(0);
            break;
        case "hq":
            level thread function_2504fb31(0);
            level thread function_df1fc23b(0);
            break;
        case "sacrifice_igc":
            level thread function_2504fb31(0);
            break;
        case "server_room":
            self thread set_world_fog(1);
            break;
        case "clearing_start":
            self player_weather(1, "light_snow");
            self thread util::player_frost_breath(1);
            break;
        case "clearing_waterfall":
            self player_weather(1, "light_snow");
            self thread function_39af75ef("clearing_path_selected");
            self thread util::player_frost_breath(1);
            break;
        case "clearing_path_choice":
            self function_11b424e5();
            self player_weather(1, "light_snow");
            self thread util::player_frost_breath(1);
            break;
        case "clearing_end":
            self function_11b424e5();
            self player_weather(1, "light_snow");
            self thread util::player_frost_breath(1);
            break;
        case "root_cairo_start":
            break;
        case "root_cairo_vortex":
            break;
        case "root_singapore_start":
            self thread function_39af75ef("singapore_root_completed");
            break;
        case "root_singapore_vortex":
            self thread function_39af75ef("singapore_root_completed");
            break;
        case "root_zurich_start":
            self player_weather(1, "regular_snow");
            self thread util::player_frost_breath(1);
            break;
        case "root_zurich_vortex":
            self thread util::player_frost_breath(1);
            break;
        case "frozen_forest":
            self player_weather(1, "red_rain");
            break;
        case "server_interior":
            break;
        case "zurich_outro":
            level thread function_2504fb31(1);
            level thread function_df1fc23b(0);
            self function_11b424e5();
            break;
        default:
            break;
        }
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x26d0
// Size: 0x4
function on_player_disconnect() {
    
}

// Namespace zurich_util
// Params 0, eflags: 0x0
// Checksum 0x64be46ee, Offset: 0x26e0
// Size: 0xc4
function function_83bed3e4() {
    scene::add_scene_func("p7_fxanim_cp_sgen_charging_station_open_01_bundle", &function_38b7a56, "init");
    scene::add_scene_func("p7_fxanim_cp_sgen_charging_station_break_01_bundle", &function_38b7a56, "init");
    scene::add_scene_func("p7_fxanim_cp_sgen_charging_station_break_02_bundle", &function_38b7a56, "init");
    scene::add_scene_func("p7_fxanim_cp_sgen_charging_station_break_03_bundle", &function_38b7a56, "init");
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x3ad8a07b, Offset: 0x27b0
// Size: 0x2c
function function_38b7a56(a_ents) {
    array::run_all(a_ents, &notsolid);
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x7d9ef654, Offset: 0x27e8
// Size: 0x1c
function function_a7b5b565() {
    hidemiscmodels("zurich_umbra_gate");
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x14e83202, Offset: 0x2810
// Size: 0x9a
function function_5f63b2f1(n_state) {
    foreach (e_player in level.players) {
        e_player thread function_78e8c8b4(n_state);
    }
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x4699fa36, Offset: 0x28b8
// Size: 0x1b4
function function_78e8c8b4(n_state) {
    self endon(#"disconnect");
    self endon(#"death");
    self notify(#"hash_6ae1015d");
    if (n_state == 1) {
        self endon(#"hash_6ae1015d");
        while (true) {
            if (math::cointoss()) {
                self util::show_hud(0);
            }
            if (math::cointoss()) {
                self setclientuivisibilityflag("weapon_hud_visible", 0);
            }
            self thread clientfield::increment_to_player("postfx_futz");
            wait randomfloatrange(2, 8);
            if (math::cointoss()) {
                self util::show_hud(1);
            }
            if (math::cointoss()) {
                self setclientuivisibilityflag("weapon_hud_visible", 1);
            }
            self thread clientfield::increment_to_player("postfx_futz");
            wait randomfloatrange(2, 8);
        }
        return;
    }
    self util::show_hud(0);
    self setclientuivisibilityflag("weapon_hud_visible", 0);
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xaec62123, Offset: 0x2a78
// Size: 0xc2
function function_d0e3bb4(b_on) {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    if (b_on) {
        foreach (player in level.players) {
            player thread function_d6b3e7b5();
        }
        return;
    }
    level notify(#"hash_bdee213c");
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x67d7460f, Offset: 0x2b48
// Size: 0x78
function function_d6b3e7b5() {
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"hash_bdee213c");
    while (true) {
        self clientfield::increment_to_player("postfx_futz_mild");
        wait 2.7;
        wait randomfloatrange(2, 3);
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x16a61064, Offset: 0x2bc8
// Size: 0x54
function function_be06d646() {
    var_4e3140b1 = getentarray("trig_falling_death", "targetname");
    array::thread_all(var_4e3140b1, &function_c8049804);
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xa0cde367, Offset: 0x2c28
// Size: 0x90
function function_c8049804() {
    while (true) {
        who = self waittill(#"trigger");
        if (isplayer(who) && !(isdefined(who.var_e7c2cbb4) && who.var_e7c2cbb4)) {
            who thread function_2f645114();
        }
        util::wait_network_frame();
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x6f69999b, Offset: 0x2cc0
// Size: 0x110
function function_2f645114() {
    self.var_e7c2cbb4 = 1;
    var_5cbd0572 = "black";
    self enableinvulnerability();
    self thread hud::fade_to_black_for_x_sec(0, 2, 0.5, 1, var_5cbd0572);
    wait 0 + 2;
    self thread function_173f6520();
    wait 0.5;
    self.var_e7c2cbb4 = 0;
    self disableinvulnerability();
    self dodamage(self.health / 10, self.origin);
    if (self.health < 1) {
        self.health = 1;
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xd693be42, Offset: 0x2dd8
// Size: 0xfc
function function_173f6520() {
    var_6194780b = level.var_31aefea8;
    var_624a0b0b = spawnlogic::get_spawnpoint_array("cp_coop_respawn");
    var_24307637 = skipto::function_c13ce5f8(self, var_624a0b0b, var_6194780b);
    assert(var_24307637.size, "<dev string:x28>");
    var_1e20ee79 = arraygetclosest(self.origin, var_24307637);
    self setorigin(var_1e20ee79.origin);
    self setplayerangles(var_1e20ee79.angles);
}

// Namespace zurich_util
// Params 2, eflags: 0x1 linked
// Checksum 0xc33b597a, Offset: 0x2ee0
// Size: 0x170
function function_39af75ef(str_endon, str_exploder) {
    self endon(#"disconnect");
    self endon(#"death");
    level endon(str_endon);
    if (!isdefined(str_exploder)) {
        str_exploder = "ex_underwater_lights";
    }
    while (true) {
        if (self isplayerunderwater() && !(isdefined(self.var_5ea9c8b7) && self.var_5ea9c8b7)) {
            self clientfield::set_to_player("player_water_transition", 1);
            self.var_5ea9c8b7 = 1;
            exploder::exploder(str_exploder);
            self thread set_world_fog(1);
        } else if (isdefined(self.var_5ea9c8b7) && !self isplayerunderwater() && self.var_5ea9c8b7) {
            self clientfield::set_to_player("player_water_transition", 0);
            self.var_5ea9c8b7 = undefined;
            exploder::kill_exploder(str_exploder);
            self thread set_world_fog(0);
        }
        wait 0.05;
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x46b983f1, Offset: 0x3058
// Size: 0x36c
function function_c412aad5() {
    self endon(#"death");
    n_min_dist = 256;
    if (self function_de29b250()) {
        if (sessionmodeiscampaignzombiesgame() && self.script_noteworthy === "zombie_spawner") {
            return;
        }
        self thread function_8f40ede();
        if (self.script_string === "in_water") {
            if (math::cointoss()) {
                self scene::play("cin_zur_11_01_paths_aie_water01", self);
            } else {
                self scene::play("cin_zur_11_01_paths_aie_water02", self);
            }
        } else if (self.script_string === "in_ground") {
            if (math::cointoss()) {
                self scene::play("cin_zur_12_01_root_aie_ground01", self);
            } else {
                self scene::play("cin_zur_12_01_root_aie_ground02", self);
            }
        } else if (isdefined(self.type) && self.type == "human") {
            self.holdfire = 1;
            self disableaimassist();
            self ai::set_ignoreme(1);
            util::magic_bullet_shield(self);
            self ghost();
            util::wait_network_frame();
            self clientfield::set("raven_ai_rez", 1);
            wait 0.5;
            self enableaimassist();
            self ai::set_ignoreme(0);
            util::stop_magic_bullet_shield(self);
            self show();
            self.holdfire = 0;
        } else {
            self.var_b1a4293e = util::spawn_model("tag_origin", self.origin, self.angles);
            self linkto(self.var_b1a4293e);
            self thread function_c9e8f95a(self.var_b1a4293e);
            self.var_b1a4293e clientfield::set("vehicle_spawn_fx", 1);
            wait 0.15;
        }
        self notify(#"spawned");
        if (self.archetype === "robot") {
            self ai::set_behavior_attribute("robot_lights", 3);
        }
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xde5ca1c5, Offset: 0x33d0
// Size: 0x28
function function_b2c5d91c() {
    if (self.weaponclass === "rocketlauncher") {
        self.accuracy = 0.4;
    }
}

// Namespace zurich_util
// Params 2, eflags: 0x1 linked
// Checksum 0x85a9b1d5, Offset: 0x3400
// Size: 0x224
function function_c90e23b6(str_objective, var_d29f1d08) {
    level.var_1c26230b = util::function_740f8516("taylor_hero");
    level.var_1c26230b thread function_f5f0fcce(str_objective, var_d29f1d08);
    if (issubstr(str_objective, "_vortex")) {
        level.var_1c26230b thread function_11726ad(str_objective);
        return;
    }
    var_2b8f773a = function_c30d095(str_objective);
    level.var_1c26230b forceteleport(var_2b8f773a.origin, var_2b8f773a.angles);
    level.var_1c26230b ai::set_ignoreme(1);
    level.var_1c26230b ai::set_ignoreall(1);
    level.var_1c26230b ghost();
    wait 0.5;
    level.var_1c26230b clientfield::set("hero_spawn_fx", 1);
    wait 0.5;
    level.var_1c26230b ai::set_ignoreme(0);
    level.var_1c26230b ai::set_ignoreall(0);
    level.var_1c26230b show();
    level.var_1c26230b thread function_53fd6e96(str_objective);
    level.var_1c26230b thread function_f7f909b0(str_objective);
    level.var_1c26230b thread function_11726ad(str_objective);
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xb31422e8, Offset: 0x3630
// Size: 0x278
function function_53fd6e96(str_objective) {
    level endon(str_objective + "_done");
    level endon(#"root_scene_completed");
    level endon(str_objective + "enter_vortex");
    level endon(#"hash_8b1e8360");
    self endon(#"death");
    while (true) {
        e_player = arraygetclosest(self.origin, level.activeplayers);
        if (isdefined(e_player)) {
            self.var_b6fdfd82 = undefined;
            while (isalive(e_player)) {
                var_974cc07 = self function_843d0ed6(e_player);
                if (self.ignoreall) {
                    self.var_b6fdfd82 = undefined;
                } else if (isdefined(var_974cc07)) {
                    setenablenode(var_974cc07, 1);
                    self setgoal(var_974cc07, 1);
                    var_974cc07 function_47f5a8d2(e_player);
                    self.var_b6fdfd82 = undefined;
                } else if (ispointonnavmesh(e_player.origin, self)) {
                    self setgoal(e_player, 0, 256);
                    self.var_b6fdfd82 = 1;
                } else {
                    v_pos = getclosestpointonnavmesh(e_player.origin, 256, 64);
                    if (isdefined(v_pos)) {
                        self setgoal(v_pos, 0, 256);
                    } else {
                        self setgoal(self.origin, 0, 256);
                        self.var_b6fdfd82 = undefined;
                    }
                }
                wait 0.5;
            }
        }
        self setgoal(self.origin);
        wait 0.1;
    }
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xa19c3e79, Offset: 0x38b0
// Size: 0x186
function function_f7f909b0(str_objective) {
    level endon(str_objective + "_done");
    level endon(str_objective + "enter_vortex");
    while (true) {
        e_player = arraygetclosest(self.origin, level.activeplayers);
        if (isdefined(e_player) && distance(e_player.origin, self.origin) > 2500) {
            v_pos = e_player.origin + anglestoforward(e_player.angles) * 256;
            v_teleport = getclosestpointonnavmesh(v_pos, 100, 30);
            if (isdefined(v_teleport)) {
                self clientfield::set("hero_spawn_fx", 0);
                wait 0.5;
                level.var_1c26230b forceteleport(v_teleport, e_player.angles);
                self clientfield::set("hero_spawn_fx", 1);
            }
        }
        wait 3;
    }
}

// Namespace zurich_util
// Params 2, eflags: 0x1 linked
// Checksum 0x625171e9, Offset: 0x3a40
// Size: 0x254
function function_f5f0fcce(str_objective, var_d29f1d08) {
    level endon(#"root_scene_completed");
    if (issubstr(str_objective, "_start")) {
        level waittill(str_objective + "enter_vortex");
    }
    if (isdefined(var_d29f1d08)) {
        s_end = struct::get(var_d29f1d08, "targetname");
    }
    if (issubstr(str_objective, "root_cairo")) {
        var_8839ea8c = "root_cairo_vortex";
    } else if (issubstr(str_objective, "root_singapore")) {
        var_8839ea8c = "root_singapore_vortex";
    } else {
        var_8839ea8c = "root_zurich_vortex";
    }
    var_d476a8cc = function_c30d095(var_8839ea8c);
    var_fa33caf9 = util::spawn_model("tag_origin", var_d476a8cc.origin, var_d476a8cc.angles);
    if (level.activeplayers.size > 1 && isdefined(s_end)) {
        self setgoal(s_end.origin, 0, 64);
        self util::waittill_any_timeout(15, "goal");
        self clientfield::set("hero_spawn_fx", 0);
    } else {
        wait 1;
    }
    self forceteleport(var_d476a8cc.origin, var_d476a8cc.angles);
    self clientfield::set("hero_spawn_fx", 1);
    self thread function_53fd6e96(str_objective);
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x7c18ff22, Offset: 0x3ca0
// Size: 0x4c
function function_11726ad(str_objective) {
    level waittill(#"root_scene_completed");
    self util::unmake_hero("taylor_hero");
    self util::self_delete();
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xae7e2ff9, Offset: 0x3cf8
// Size: 0xe4
function function_c30d095(str_objective) {
    switch (str_objective) {
    case "root_zurich_start":
        str_pos = "root_zurich_end_taylor_start";
        break;
    case "root_zurich_vortex":
        str_pos = "root_zurich_end_taylor_vortex";
        break;
    case "root_cairo_start":
        str_pos = "root_cairo_end_taylor_start";
        break;
    case "root_cairo_vortex":
        str_pos = "root_cairo_end_taylor_vortex";
        break;
    case "root_singapore_start":
        str_pos = "root_singapore_end_taylor_start";
        break;
    case "root_singapore_vortex":
        str_pos = "root_singapore_end_taylor_vortex";
        break;
    }
    s_pos = struct::get(str_pos, "targetname");
    return s_pos;
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x6a9c994c, Offset: 0x3de8
// Size: 0x21c
function function_843d0ed6(e_player) {
    if (!isdefined(level.var_6b5304af)) {
        return undefined;
    }
    foreach (var_974cc07 in level.var_6b5304af) {
        setenablenode(var_974cc07, 0);
    }
    var_a8a64a67 = arraysortclosest(level.var_6b5304af, e_player.origin, 8, 90, 512);
    for (i = 0; i < var_a8a64a67.size; i++) {
        if (!(var_a8a64a67[i].script_noteworthy === "ai_taylor_cover")) {
            arrayremovevalue(var_a8a64a67, var_a8a64a67[i]);
        }
    }
    for (i = 0; i < var_a8a64a67.size; i++) {
        v_player_pos = e_player geteye();
        if (sighttracepassed(v_player_pos, var_a8a64a67[i].origin + (0, 0, 32), 0, e_player)) {
            return var_a8a64a67[i];
        }
    }
    for (i = 0; i < var_a8a64a67.size; i++) {
        return var_a8a64a67[i];
    }
    return undefined;
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x76cd65e6, Offset: 0x4010
// Size: 0x12c
function function_47f5a8d2(e_player) {
    level.var_1c26230b endon(#"death");
    e_player endon(#"disconnect");
    e_player endon(#"death");
    var_c3adecbb = 0;
    n_starttime = gettime();
    while (distance(e_player.origin, self.origin) < 256 && distance(e_player.origin, self.origin) > 64 && isalive(e_player) && var_c3adecbb < 15) {
        wait 1;
        var_c3adecbb = (gettime() - n_starttime) / 1000;
    }
    level.var_1c26230b clearforcedgoal();
}

// Namespace zurich_util
// Params 0, eflags: 0x0
// Checksum 0xf719dc62, Offset: 0x4148
// Size: 0x15e
function function_d93e481f() {
    self endon(#"death");
    self endon(#"disconnect");
    level.var_1c26230b endon(#"death");
    self.var_df6d1c12 = self.origin;
    while (true) {
        if (distance(self.origin, self.var_df6d1c12) < 16) {
            var_c37d2cb3 = level.var_1c26230b geteye();
            if (self util::is_player_looking_at(var_c37d2cb3, 0.8, 1, self) && !(isdefined(level.var_aec67b62) && level.var_aec67b62)) {
                level.var_aec67b62 = 1;
                if (!level.var_1c26230b scene::is_playing()) {
                    level.var_1c26230b thread scene::play("cin_gen_ambient_idle_nag", level.var_1c26230b);
                }
                level.var_1c26230b thread function_15d5331f();
            }
        }
        self.var_df6d1c12 = self.origin;
        wait 5;
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x279be8ba, Offset: 0x42b0
// Size: 0x1a
function function_15d5331f() {
    wait 30;
    level.var_aec67b62 = undefined;
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xa9dde1c3, Offset: 0x42d8
// Size: 0x1ec
function function_dc8f9fa6() {
    if (!self function_de29b250()) {
        if (self.archetype === "human" && !self util::is_hero()) {
            var_72875649 = 0;
            if (isdefined(self.script_int)) {
                var_72875649 = self.script_int;
            }
            self.grenadeammo = var_72875649;
        }
        if (self.archetype === "robot") {
            str_level = "forced_level_1";
            if (self.script_noteworthy === "forced_level_2" || self.script_noteworthy === "forced_level_3") {
                str_level = self.script_noteworthy;
                if (self.script_noteworthy === "forced_level_3") {
                    self ai::set_behavior_attribute("rogue_control_speed", "run");
                }
            }
            self ai::set_behavior_attribute("rogue_control", str_level);
            self.team = "axis";
            self util::function_e218424d();
            if (self.script_noteworthy === "has_mini_raps" || self.script_string === "has_mini_raps") {
                self ai::set_behavior_attribute("robot_mini_raps", 1);
            }
            return;
        }
        if (isvehicle(self)) {
            self util::function_e218424d();
            self.team = "axis";
        }
    }
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x90888f1a, Offset: 0x44d0
// Size: 0x6c
function function_c3e494e3(params) {
    if (self function_de29b250()) {
        if (isvehicle(self)) {
            return;
        }
        self thread function_1f77a211();
        self thread function_99af4b5d();
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xd3b2691f, Offset: 0x4548
// Size: 0x28
function function_de29b250() {
    return function_5060d1c8() && self.team != "allies";
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xa6018833, Offset: 0x4578
// Size: 0x22
function function_5060d1c8() {
    if (!isdefined(level.var_eadfc2aa)) {
        level.var_eadfc2aa = 0;
    }
    return level.var_eadfc2aa;
}

// Namespace zurich_util
// Params 2, eflags: 0x1 linked
// Checksum 0x9059d625, Offset: 0x45a8
// Size: 0x54
function function_4d032f25(b_enabled, n_delay_time) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    if (!isdefined(n_delay_time)) {
        n_delay_time = 0;
    }
    level.var_eadfc2aa = b_enabled;
    level.var_56f93473 = n_delay_time;
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xdaf93588, Offset: 0x4608
// Size: 0xd2
function function_99af4b5d() {
    self endon(#"hash_b1975c04");
    self waittill(#"start_ragdoll");
    if (isdefined(self)) {
        self clientfield::set("raven_ai_rez", 0);
    }
    function_151fb8bf();
    if (isdefined(self)) {
        self ghost();
        self clientfield::set("exploding_ai_deaths", 1);
    }
    util::wait_network_frame();
    if (isdefined(self)) {
        self delete();
        self notify(#"hash_b1975c04");
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x66e75b1, Offset: 0x46e8
// Size: 0xaa
function function_1f77a211() {
    self endon(#"hash_b1975c04");
    e_corpse = self waittill(#"actor_corpse");
    function_151fb8bf();
    if (isdefined(e_corpse)) {
        e_corpse clientfield::set("exploding_ai_deaths", 1);
    }
    util::wait_network_frame();
    if (isdefined(e_corpse)) {
        e_corpse delete();
    }
    if (isdefined(self)) {
        self notify(#"hash_b1975c04");
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xda68a49, Offset: 0x47a0
// Size: 0x18
function function_151fb8bf() {
    if (isdefined(level.var_56f93473)) {
        wait level.var_56f93473;
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x9c8fb76b, Offset: 0x47c0
// Size: 0x498
function function_b1d28dc8() {
    self endon(#"death");
    self waittill(#"spawned");
    if (isdefined(self.type) && self.type == "human") {
        while (true) {
            self ai::disable_pain();
            self waittill(#"damage");
            if (self.var_5e7a3967 === 1 && (randomint(10) > 2 || !(isdefined(self.var_de36196f) && self.var_de36196f))) {
                if (self isatcovernodestrict()) {
                    var_dd98891d = self.node.type;
                }
                if (var_dd98891d === "Cover Right" || var_dd98891d === "Cover Left") {
                    var_c9111550 = self.origin + anglestoforward(self.angles) * -76;
                    var_f473fe28 = self function_c550e7be(var_c9111550);
                    var_e45d5caa = self.origin + anglestoforward(self.angles) * -1 * -76;
                    var_667b6d63 = self function_c550e7be(var_e45d5caa);
                } else {
                    var_dac99ad = self.origin + anglestoright(self.angles) * -76;
                    var_f473fe28 = self function_c550e7be(var_dac99ad);
                    var_33219fd6 = self.origin + anglestoright(self.angles) * -1 * -76;
                    var_667b6d63 = self function_c550e7be(var_33219fd6);
                }
                if (math::cointoss()) {
                    var_d3fd0a78 = var_f473fe28;
                    var_460479b3 = var_667b6d63;
                } else {
                    var_d3fd0a78 = var_667b6d63;
                    var_460479b3 = var_f473fe28;
                }
                if (isdefined(var_d3fd0a78)) {
                    if (isdefined(self.attacker)) {
                        if (self.attacker.classname != "worldspawn" && self.attacker.classname != "trigger_radius_hurt") {
                            if (sighttracepassed(self.attacker geteye(), var_d3fd0a78 + (0, 0, 72), 0, self.attacker)) {
                                self function_f5b7f741(var_d3fd0a78);
                            }
                        }
                    }
                } else if (isdefined(var_460479b3)) {
                    if (isdefined(self.attacker)) {
                        if (self.attacker.classname != "worldspawn" && self.attacker.classname != "trigger_radius_hurt") {
                            if (sighttracepassed(self.attacker geteye(), var_460479b3 + (0, 0, 72), 0, self.attacker)) {
                                self function_f5b7f741(var_460479b3);
                            }
                        }
                    }
                } else if (isdefined(var_d3fd0a78)) {
                    self function_f5b7f741(var_d3fd0a78);
                } else if (isdefined(var_460479b3)) {
                    self function_f5b7f741(var_460479b3);
                }
            }
            self ai::enable_pain();
            wait randomintrange(5, 10);
        }
    }
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xaac5ab14, Offset: 0x4c60
// Size: 0x148
function function_c550e7be(var_f19447c4) {
    var_f19447c4 = getclosestpointonnavmesh(var_f19447c4, -128, 32);
    if (!isdefined(var_f19447c4) || distance(self.origin, var_f19447c4) < 50) {
        return undefined;
    }
    foreach (e_player in level.activeplayers) {
        if (distance(e_player.origin, var_f19447c4) < -128) {
            return undefined;
        }
    }
    if (!positionwouldtelefrag(var_f19447c4) && !self isposinclaimedlocation(var_f19447c4)) {
        return var_f19447c4;
    }
    return undefined;
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x5c34b681, Offset: 0x4db0
// Size: 0x3cc
function function_f5b7f741(var_f19447c4) {
    self endon(#"hash_a30f8b");
    if (isdefined(var_f19447c4)) {
        n_distance = distance(self.origin, var_f19447c4);
        n_time = n_distance / 400;
        self thread function_8f40ede();
        self clientfield::increment("raven_juke_limb_effect");
        self.holdfire = 1;
        self disableaimassist();
        self ai::set_ignoreme(1);
        util::magic_bullet_shield(self);
        self ghost();
        var_fb20f2e1 = self.angles;
        var_4fa09666 = vectortoangles(var_f19447c4 - self.origin);
        self.var_b1a4293e = util::spawn_model("tag_origin", self gettagorigin("J_Spine4"), var_4fa09666);
        wait 0.05;
        self.var_b1a4293e clientfield::increment("raven_juke_effect");
        self linkto(self.var_b1a4293e);
        self thread function_c9e8f95a(self.var_b1a4293e);
        self.var_b1a4293e moveto(var_f19447c4 + (0, 0, 25), n_time);
        self.var_b1a4293e waittill(#"movedone");
        self unlink();
        self forceteleport(var_f19447c4, var_fb20f2e1, 1, 0);
        self setgoalpos(var_f19447c4, 1);
        self.var_b1a4293e moveto(self gettagorigin("J_Spine4"), 0.05);
        self.var_b1a4293e clientfield::increment("raven_teleport_in_effect");
        wait 1.4;
        self forceteleport(var_f19447c4, var_fb20f2e1, 1, 0);
        self setgoalpos(var_f19447c4, 1);
        self enableaimassist();
        self ai::set_ignoreme(0);
        util::stop_magic_bullet_shield(self);
        self show();
        self.holdfire = 0;
        self notify(#"teleport_done");
        wait 2;
        self clearforcedgoal();
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xadf7f345, Offset: 0x5188
// Size: 0x32
function function_8f40ede() {
    self endon(#"death");
    self.var_de36196f = 1;
    wait 6;
    self.var_de36196f = undefined;
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x7c87d0d0, Offset: 0x51c8
// Size: 0x256
function function_90de3a76() {
    self endon(#"death");
    self waittill(#"spawned");
    wait 1;
    if (isdefined(self.type) && self.type == "human") {
        if (!isdefined(self.var_48772f67) || !self.var_48772f67) {
            var_8fb5e5da = undefined;
            n_move_time = 3;
            while (true) {
                self waittill(#"new_cover");
                for (var_974cc07 = self.node; !isdefined(var_974cc07); var_974cc07 = self.node) {
                    wait 1.5;
                }
                b_close = undefined;
                foreach (e_player in level.activeplayers) {
                    if (distance(e_player.origin, var_974cc07.origin) < -128) {
                        b_close = 1;
                    }
                }
                if (distance(self.origin, var_974cc07.origin) < -128) {
                    b_close = 1;
                }
                if (randomint(10) > 4 && var_974cc07 !== var_8fb5e5da && !(isdefined(self.var_de36196f) && self.var_de36196f) && !(isdefined(b_close) && b_close)) {
                    var_8fb5e5da = var_974cc07;
                    self thread function_bfc7e6a6(var_974cc07.origin);
                }
                wait 2;
            }
        }
    }
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xb5add382, Offset: 0x5428
// Size: 0x454
function function_bfc7e6a6(v_pos) {
    self endon(#"death");
    n_distance = distance(self.origin, v_pos);
    n_time = n_distance / 400;
    self thread function_8f40ede();
    if (n_time > 0.6) {
        self clientfield::increment("raven_teleport_limb_effect");
        n_time = 1;
    } else {
        self clientfield::increment("raven_juke_limb_effect");
        n_time = 0.45;
    }
    self.holdfire = 1;
    self disableaimassist();
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    util::magic_bullet_shield(self);
    self ghost();
    var_fb20f2e1 = self.angles;
    var_f8a383f8 = vectortoangles(v_pos - self.origin);
    self.var_b1a4293e = util::spawn_model("tag_origin", self gettagorigin("J_Spine4"), var_f8a383f8);
    wait 0.05;
    if (n_time == 1) {
        self.var_b1a4293e clientfield::increment("raven_teleport_effect");
    } else {
        self.var_b1a4293e clientfield::increment("raven_juke_effect");
    }
    self linkto(self.var_b1a4293e);
    self thread function_c9e8f95a(self.var_b1a4293e);
    self.var_b1a4293e moveto(v_pos + (0, 0, 25), n_time);
    self.var_b1a4293e waittill(#"movedone");
    self unlink();
    self forceteleport(v_pos, var_fb20f2e1, 0, 0);
    self setgoalpos(v_pos, 1);
    self.var_b1a4293e moveto(self gettagorigin("J_Spine4"), 0.05);
    self.var_b1a4293e clientfield::increment("raven_teleport_in_effect");
    wait 1.4;
    self forceteleport(v_pos, var_fb20f2e1, 0, 0);
    self enableaimassist();
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    util::stop_magic_bullet_shield(self);
    self show();
    self.holdfire = 0;
    self notify(#"teleport_done");
    wait 2;
    self clearforcedgoal();
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x5c510278, Offset: 0x5888
// Size: 0x94
function function_c9e8f95a(var_b1a4293e) {
    self util::waittill_any("death", "teleport_done", "spawned");
    if (isalive(self)) {
        self unlink();
    }
    wait 3;
    if (isdefined(var_b1a4293e)) {
        var_b1a4293e delete();
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xf4e9af3c, Offset: 0x5928
// Size: 0x4b2
function raven_spawn_teleport() {
    self endon(#"death");
    if (isdefined(self.target) && self.script_parameters === "raven_spawn_teleport") {
        var_f5cd6771 = getnode(self.target, "targetname");
        if (!isdefined(var_f5cd6771)) {
            var_f5cd6771 = struct::get(self.target, "targetname");
        }
        if (!isdefined(var_f5cd6771)) {
            return;
        }
        self waittill(#"spawned");
        wait 0.5;
        n_distance = distance(self.origin, var_f5cd6771.origin);
        n_move_time = n_distance / 400;
        if (n_move_time > 0.6) {
            self clientfield::increment("raven_teleport_limb_effect");
            n_move_time = 1;
        } else {
            self clientfield::increment("raven_juke_limb_effect");
            n_move_time = 0.45;
        }
        self ghost();
        self ai::set_ignoreall(1);
        self ai::set_ignoreme(1);
        util::magic_bullet_shield(self);
        self disableaimassist();
        var_fb20f2e1 = self.angles;
        var_4fa09666 = vectortoangles(var_f5cd6771.origin - self.origin);
        self.var_b1a4293e = util::spawn_model("tag_origin", self gettagorigin("J_Spine4"), var_4fa09666);
        util::wait_network_frame();
        if (n_move_time == 1) {
            self.var_b1a4293e clientfield::increment("raven_teleport_effect");
        } else {
            self.var_b1a4293e clientfield::increment("raven_juke_effect");
        }
        self linkto(self.var_b1a4293e);
        self thread function_c9e8f95a(self.var_b1a4293e);
        self.var_b1a4293e moveto(var_f5cd6771.origin + (0, 0, 25), n_move_time);
        self.var_b1a4293e waittill(#"movedone");
        self unlink();
        self forceteleport(var_f5cd6771.origin, var_fb20f2e1, 1, 0);
        self setgoalpos(var_f5cd6771.origin, 1);
        self.var_b1a4293e moveto(self gettagorigin("J_Spine4"), 0.05);
        self.var_b1a4293e clientfield::increment("raven_teleport_in_effect");
        wait 1.4;
        self ai::set_ignoreall(0);
        self ai::set_ignoreme(0);
        util::stop_magic_bullet_shield(self);
        self enableaimassist();
        self show();
        self notify(#"teleport_done");
    }
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xee26f2ba, Offset: 0x5de8
// Size: 0x412
function function_ff6b67ed(target) {
    self endon(#"death");
    n_distance = distance(self.origin, target.origin);
    n_move_time = n_distance / 400;
    if (n_move_time > 0.6) {
        self clientfield::increment("raven_teleport_limb_effect");
        n_move_time = 1;
    } else {
        self clientfield::increment("raven_juke_limb_effect");
        n_move_time = 0.45;
    }
    self ghost();
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    util::magic_bullet_shield(self);
    self disableaimassist();
    var_fb20f2e1 = self.angles;
    var_4fa09666 = vectortoangles(target.origin - self.origin);
    self.var_b1a4293e = util::spawn_model("tag_origin", self gettagorigin("J_Spine4"), var_4fa09666);
    wait 0.05;
    if (n_move_time == 1) {
        self.var_b1a4293e clientfield::increment("raven_teleport_effect");
    } else {
        self.var_b1a4293e clientfield::increment("raven_juke_effect");
    }
    self linkto(self.var_b1a4293e);
    self thread function_c9e8f95a(self.var_b1a4293e);
    self.var_b1a4293e moveto(target.origin + (0, 0, 25), n_move_time);
    self.var_b1a4293e waittill(#"movedone");
    self unlink();
    self forceteleport(target.origin, var_fb20f2e1, 1, 0);
    self setgoalpos(target.origin, 1);
    self.var_b1a4293e moveto(self gettagorigin("J_Spine4"), 0.05);
    self.var_b1a4293e clientfield::increment("raven_teleport_in_effect");
    wait 1.4;
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    util::stop_magic_bullet_shield(self);
    self enableaimassist();
    self show();
    self notify(#"teleport_done");
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xf1f50678, Offset: 0x6208
// Size: 0xd6
function function_d8c91e6b(n_dist) {
    self endon(#"death");
    if (!isdefined(n_dist)) {
        n_dist = 4000;
    }
    while (true) {
        if (!(isdefined(self player_can_see_me(n_dist)) && self player_can_see_me(n_dist))) {
            if (isalive(self) && !self util::is_hero()) {
                self util::stop_magic_bullet_shield();
                self kill();
            }
        }
        wait 5;
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x32b7c024, Offset: 0x62e8
// Size: 0x5c
function function_674ecd85() {
    a_ai = getaiteamarray("axis", "allies", "team3");
    array::spread_all(a_ai, &function_914c331d);
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xeed857bb, Offset: 0x6350
// Size: 0x64
function function_914c331d() {
    if (isalive(self) && !self util::is_hero()) {
        self util::stop_magic_bullet_shield();
        self delete();
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x65abc60f, Offset: 0x63c0
// Size: 0x64
function function_48463818() {
    if (isalive(self) && !self util::is_hero()) {
        self util::stop_magic_bullet_shield();
        self kill();
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x0
// Checksum 0x6607ebf8, Offset: 0x6430
// Size: 0x146
function function_289902e8() {
    self endon(#"death");
    self waittill(#"spawned");
    self thread function_d8c91e6b(4000);
    while (true) {
        e_player = arraygetclosest(self.origin, level.activeplayers);
        if (isdefined(e_player) && distance(e_player.origin, self.origin) > 2000) {
            v_pos = e_player.origin + anglestoforward(e_player.angles) * 512;
            v_teleport = getclosestpointonnavmesh(v_pos, 100, 30);
            if (isdefined(v_teleport)) {
                self thread function_bfc7e6a6(v_teleport);
            }
        }
        wait 5;
    }
}

// Namespace zurich_util
// Params 13, eflags: 0x1 linked
// Checksum 0xe581593b, Offset: 0x6580
// Size: 0x134
function function_8ac3f026(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
    if (isai(eattacker)) {
        if (self.team == "axis" && (self.team == "allies" && eattacker.team == "axis" || eattacker.team == "allies")) {
            n_scale = function_411dc61b(5, -1);
            idamage = int(idamage * n_scale);
        }
    }
    return idamage;
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x980ca28d, Offset: 0x66c0
// Size: 0x130
function player_can_see_me(n_dist) {
    if (!isdefined(n_dist)) {
        n_dist = 512;
    }
    for (i = 0; i < level.players.size; i++) {
        v_player_pos = level.players[i] geteye();
        if (sighttracepassed(v_player_pos, self.origin + (0, 0, 32), 0, level.players[i])) {
            return true;
        }
        var_b08b4a3b = distance2dsquared(self.origin, level.players[i] geteye());
        n_dist_sq = n_dist * n_dist;
        if (var_b08b4a3b < n_dist_sq) {
            return true;
        }
    }
    return false;
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xbb80f95e, Offset: 0x67f8
// Size: 0x294
function function_2361541e(str_location) {
    switch (str_location) {
    case "street":
        level thread function_8d10b109();
        break;
    case "rails":
        level thread function_c27f6351();
        break;
    }
    var_cf560aad = struct::get_array(str_location + "_oneshot_bodies", "targetname");
    if (var_cf560aad.size) {
        foreach (s_oneshot in var_cf560aad) {
            var_5db4d3e4 = getentarray("zurich_ambient_civ", "targetname");
            var_d10a8335 = array::random(var_5db4d3e4);
            var_14c918e8 = spawner::simple_spawn_single(var_d10a8335);
            var_14c918e8 ai::set_ignoreme(1);
            var_14c918e8 forceteleport(s_oneshot.origin, s_oneshot.angles);
            var_14c918e8 thread scene::init(s_oneshot.scriptbundlename, var_14c918e8);
        }
    }
    var_f201bfb1 = struct::get_array(str_location + "_dead_bodies", "targetname");
    if (!var_f201bfb1.size) {
        return;
    }
    level thread scene::play(str_location + "_dead_bodies", "targetname");
    level waittill(str_location + "_ambient_cleanup");
    level scene::stop(str_location + "_dead_bodies", "targetname", 1);
}

// Namespace zurich_util
// Params 2, eflags: 0x1 linked
// Checksum 0x5c468067, Offset: 0x6a98
// Size: 0x9c
function function_1eb6ea27(trigger, str_location) {
    var_f201bfb1 = struct::get_array(str_location + "_dead_bodies", "targetname");
    if (!var_f201bfb1.size) {
        return;
    }
    trigger::wait_till(trigger);
    level scene::stop(str_location + "_dead_bodies", "targetname", 1);
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x58fda82f, Offset: 0x6b40
// Size: 0xa4
function function_8d10b109() {
    level.var_71aac273 = 0;
    scene::add_scene_func("cin_zur_vign_conversation", &function_6a0676d9, "play");
    scene::add_scene_func("cin_zur_vign_seizure_soldier", &function_6a0676d9, "play");
    scene::add_scene_func("cin_zur_m_floor_stomach_wounded_zsf", &function_6a0676d9, "play");
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x9e7ae192, Offset: 0x6bf0
// Size: 0xda
function function_6a0676d9(a_ents) {
    foreach (e_ent in a_ents) {
        e_ent setcandamage(1);
        e_ent.health = 100000;
        e_ent thread function_16f4964d();
        e_ent thread util::auto_delete(16, 0, 1000);
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xe4bcb052, Offset: 0x6cd8
// Size: 0x9e
function function_16f4964d() {
    self endon(#"death");
    while (isdefined(self)) {
        n_damage, e_attacker = self waittill(#"damage");
        if (isplayer(e_attacker)) {
            level.var_71aac273++;
        }
        if (level.var_71aac273 >= 4) {
            level.var_71aac273 = 0;
            util::function_207f8667(%SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN);
        }
        wait 1;
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xe7c4e243, Offset: 0x6d80
// Size: 0x94
function function_c27f6351() {
    scene::add_scene_func("p7_fxanim_cp_zurich_train_seats_bundle", &function_9f90bc0f, "play", "rails_ambient_cleanup");
    level scene::init("p7_fxanim_cp_zurich_train_seats_bundle");
    trigger::wait_till("t_enter_train");
    level thread scene::play("p7_fxanim_cp_zurich_train_seats_bundle");
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x4b9bbb56, Offset: 0x6e20
// Size: 0x54
function function_4e396e71() {
    var_4239eb0b = getentarray("zurich_skipto", "targetname");
    array::thread_all(var_4239eb0b, &function_ca33eb60);
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xa52354e6, Offset: 0x6e80
// Size: 0x98
function function_ca33eb60() {
    while (true) {
        who = self waittill(#"trigger");
        if (isplayer(who)) {
            str_objective = self.script_objective;
            if (!isdefined(str_objective)) {
                str_objective = "zurich";
            }
            level notify(str_objective + "_done");
            skipto::function_be8adfb8(str_objective);
        }
    }
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xfccbaf82, Offset: 0x6f20
// Size: 0xe0
function function_a1851f86(str_objective) {
    var_e061e0f4 = getentarray("root_end_skipto", "targetname");
    foreach (var_8fb0849a in var_e061e0f4) {
        if (var_8fb0849a.script_string === str_objective) {
            var_8fb0849a thread function_3da5d43b(str_objective);
            return var_8fb0849a;
        }
    }
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x31ef65c6, Offset: 0x7008
// Size: 0x10c
function function_3da5d43b(str_objective) {
    if (!isdefined(str_objective)) {
        assert(isdefined(str_objective), "<dev string:x5e>");
    }
    var_779fea3 = getent(self.target, "targetname");
    level thread function_8bd6820f(str_objective);
    self thread function_61f7fc15();
    self.var_afacae68 = 0;
    self function_17b739e2(var_779fea3);
    level notify(str_objective + "_done");
    wait 1;
    self delete();
    var_779fea3 delete();
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x7f5c8572, Offset: 0x7120
// Size: 0xdc
function function_8bd6820f(str_objective) {
    switch (str_objective) {
    case "root_zurich_vortex":
        var_9e7910c3 = "zurich_fxanim_heart";
        break;
    case "root_cairo_vortex":
        var_9e7910c3 = "cairo_fxanim_heart";
        break;
    case "root_singapore_vortex":
        var_9e7910c3 = "singapore_fxanim_heart";
        break;
    }
    level thread scene::play(var_9e7910c3, "targetname");
    level waittill(str_objective + "_done");
    level thread scene::stop(var_9e7910c3, "targetname");
    playsoundatposition("evt_heart_burn", (0, 0, 0));
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xb61e534f, Offset: 0x7208
// Size: 0x46
function function_17b739e2(var_779fea3) {
    self function_30a6b901(1, var_779fea3);
    self.var_afacae68 = 1;
    self notify(#"hash_40b1a9d9");
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x50a4433f, Offset: 0x7258
// Size: 0x2c
function function_61f7fc15() {
    self waittill(#"hash_40b1a9d9");
    level util::clientnotify("stp_mus");
}

// Namespace zurich_util
// Params 3, eflags: 0x1 linked
// Checksum 0xc8bc90c0, Offset: 0x7290
// Size: 0x110
function function_dd842585(str_objective, var_ed1d0e16, str_trig) {
    level endon(str_objective + "_done");
    level endon(var_ed1d0e16 + "_done");
    var_50f524fe = getent(str_trig, "targetname");
    while (true) {
        who = var_50f524fe waittill(#"trigger");
        if (isplayer(who) && !(isdefined(who.teleporting) && who.teleporting)) {
            who thread function_c51939f4(str_objective, var_ed1d0e16);
            who player_weather(0);
        }
        wait 0.25;
    }
}

// Namespace zurich_util
// Params 2, eflags: 0x1 linked
// Checksum 0xf4e17383, Offset: 0x73a8
// Size: 0x1ca
function function_c51939f4(str_objective, var_ed1d0e16) {
    level notify(str_objective + "enter_vortex");
    var_5cbd0572 = "black";
    self playrumbleonentity("damage_heavy");
    self.teleporting = 1;
    self enableinvulnerability();
    self thread hud::fade_to_black_for_x_sec(0, 2, 0.5, 1, var_5cbd0572);
    self playsoundtoplayer("evt_teleport", self);
    wait 0 + 2;
    a_s_spots = skipto::function_3529c409(var_ed1d0e16, 0);
    s_spot = array::random(a_s_spots);
    self setorigin(s_spot.origin);
    self setplayerangles(s_spot.angles);
    wait 0.5;
    self.teleporting = undefined;
    self disableinvulnerability();
    self clientfield::increment_to_player("vortex_teleport");
    self notify(#"hash_a71a53c4");
}

// Namespace zurich_util
// Params 3, eflags: 0x1 linked
// Checksum 0xe8f7b178, Offset: 0x7580
// Size: 0x74
function function_a03f30f2(str_objective, var_ed1d0e16, str_trig) {
    trigger::wait_till(str_trig);
    level flag::set(var_ed1d0e16);
    level notify(str_objective + "_done");
    level player_weather(0);
}

// Namespace zurich_util
// Params 2, eflags: 0x1 linked
// Checksum 0x8fccaaed, Offset: 0x7600
// Size: 0x23a
function function_30a6b901(var_929e1778, var_de2c41d4) {
    if (isdefined(self.target)) {
        var_5e4d2a14 = struct::get_array(self.target, "targetname");
        if (var_5e4d2a14.size) {
            for (i = 0; i < var_5e4d2a14.size; i++) {
                if (var_5e4d2a14[i].script_noteworthy === "burn_pos") {
                    self.burn_pos = var_5e4d2a14[i];
                }
            }
        }
    }
    if (var_929e1778) {
        var_376507c0 = %cp_level_zurich_burn_heart;
    } else {
        var_376507c0 = %cp_level_zurich_burn_vines;
    }
    self.var_90971f20 = util::function_14518e76(self, var_376507c0, %CP_MI_ZURICH_COALESCENCE_BURN, &function_64158e74);
    self triggerenable(1);
    level waittill(#"hash_914d02c2");
    self notify(#"hash_3600bf2b");
    e_player = self.var_90971f20.e_player;
    self.var_90971f20 gameobjects::disable_object();
    if (isdefined(e_player)) {
        e_player thread function_4a447e94();
        var_9866f6f9 = e_player;
        if (!var_929e1778) {
            if (isdefined(self.burn_pos)) {
                var_9866f6f9 = self.burn_pos;
            }
            var_9866f6f9 scene::play("p_zur_burn_vines_bundle", e_player);
        }
        if (isdefined(self.target)) {
            util::function_93831e79(self.target);
        }
    }
    level notify(#"hash_87560491");
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x4a8b6af8, Offset: 0x7848
// Size: 0x26
function function_64158e74(e_player) {
    self.e_player = e_player;
    level notify(#"hash_914d02c2");
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x8b8d5c28, Offset: 0x7878
// Size: 0x24
function function_4a447e94() {
    wait 1;
    self cybercom::function_f8669cbf(1);
}

// Namespace zurich_util
// Params 2, eflags: 0x0
// Checksum 0x53c37362, Offset: 0x78a8
// Size: 0x6c
function function_cdd5119b(e_attacker, var_2f950561) {
    var_19fd2f7 = vectortoangles(e_attacker.origin - var_2f950561);
    self fx::play("corvus_blood", var_2f950561, var_19fd2f7);
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xd7386a4e, Offset: 0x7920
// Size: 0x54
function function_91d852fa() {
    var_2cfeb5a9 = getentarray("zurich_vinewalls", "targetname");
    array::thread_all(var_2cfeb5a9, &function_ff5e6201);
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xb70232eb, Offset: 0x7980
// Size: 0x1dc
function function_ff5e6201(var_8d6d1339) {
    if (isdefined(self.script_string)) {
        var_8d6d1339 = self.script_string;
    }
    a_e_parts = getentarray(self.target, "targetname");
    for (i = 0; i < a_e_parts.size; i++) {
        if (a_e_parts[i].script_noteworthy === "vinewall_clip") {
            var_9d50b546 = a_e_parts[i];
            continue;
        }
        if (a_e_parts[i].script_noteworthy === "vinewall_vine") {
            var_ecf05dd0 = a_e_parts[i];
        }
    }
    if (isdefined(self.script_flag_true)) {
        level flag::wait_till(self.script_flag_true);
    } else if (isdefined(var_8d6d1339)) {
        self setinvisibletoall();
        level waittill(var_8d6d1339);
        self setvisibletoall();
    }
    self function_30a6b901(0, var_ecf05dd0);
    var_9d50b546 notsolid();
    var_9d50b546 connectpaths();
    var_ecf05dd0 delete();
    wait 0.1;
    var_9d50b546 delete();
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x66e5575e, Offset: 0x7b68
// Size: 0x2c
function set_world_fog(bank) {
    self clientfield::set_to_player("set_world_fog", bank);
}

// Namespace zurich_util
// Params 2, eflags: 0x1 linked
// Checksum 0x8c8e0a7b, Offset: 0x7ba0
// Size: 0xb0
function function_411dc61b(n_base, var_df47d27) {
    n_num = n_base - var_df47d27;
    foreach (e_player in level.players) {
        n_num += var_df47d27;
    }
    return n_num;
}

// Namespace zurich_util
// Params 7, eflags: 0x1 linked
// Checksum 0x981d351a, Offset: 0x7c58
// Size: 0x184
function function_e7fdcb95(var_2c34daa1, var_6fc1c7c6, var_f67c8a8e, var_bf7b0d42, var_7b2612a, var_6f456ea4, var_42e6f5b4) {
    if (!isdefined(var_bf7b0d42)) {
        var_bf7b0d42 = 0;
    }
    if (!isdefined(var_7b2612a)) {
        var_7b2612a = 0;
    }
    s_start = struct::get(var_2c34daa1 + "_start");
    s_end = struct::get(s_start.target);
    var_a3decff = new robotphalanx();
    [[ var_a3decff ]]->initialize(var_6fc1c7c6, s_start.origin, s_end.origin, var_f67c8a8e, var_42e6f5b4);
    wait var_7b2612a;
    if (isdefined(var_6f456ea4) && level flag::exists(var_6f456ea4)) {
        level flag::wait_till(var_6f456ea4);
    }
    if (var_bf7b0d42 && var_a3decff.scattered_ == 0) {
        var_a3decff thread robotphalanx::scatterphalanx();
    }
}

// Namespace zurich_util
// Params 2, eflags: 0x1 linked
// Checksum 0xb645eb5b, Offset: 0x7de8
// Size: 0x7c
function function_da579a5d(str_objective, var_d44e356e) {
    level.var_3d556bcd = util::function_740f8516("kane");
    if (var_d44e356e) {
        level.var_3d556bcd thread function_fe5160df(1);
    }
    skipto::teleport_ai(str_objective, level.heroes);
}

// Namespace zurich_util
// Params 2, eflags: 0x1 linked
// Checksum 0xba58440e, Offset: 0x7e70
// Size: 0x3b0
function function_d0103e8d(var_95fca89b, var_62320a5b) {
    if (!isdefined(var_95fca89b)) {
        var_95fca89b = 395;
    }
    if (!isdefined(var_62320a5b)) {
        var_62320a5b = 0.7;
    }
    self notify(#"hash_2f673cce");
    self endon(#"hash_2f673cce");
    while (true) {
        a_players = arraycopy(level.activeplayers);
        array::randomize(a_players);
        a_enemies = getaiteamarray("axis", "team3");
        a_enemies = arraysort(a_enemies, self.origin, 0);
        foreach (player in a_players) {
            for (i = 0; i < a_enemies.size; i++) {
                var_10b4a7a6 = a_enemies[i] geteye();
                var_b8f6e26f = player util::is_player_looking_at(var_10b4a7a6, var_62320a5b, 1, player);
                in_range = distancesquared(self.origin, a_enemies[i].origin) >= var_95fca89b * var_95fca89b;
                var_7792c65f = sighttracepassed(self geteye(), var_10b4a7a6, 0, a_enemies[i]);
                var_39e0fee4 = isalive(a_enemies[i]) && a_enemies[i].allowdeath !== 0 && a_enemies[i].magic_bullet_shield !== 1 && a_enemies[i].ignoreme == 0;
                if (var_b8f6e26f && var_7792c65f && var_39e0fee4 && in_range && a_enemies[i] function_50c2e8b0()) {
                    self thread function_fc91db35(a_enemies[i]);
                    break;
                }
            }
        }
        var_ec24660 = function_411dc61b(5, 2);
        var_39dd968a = function_411dc61b(10, 2);
        wait randomintrange(var_ec24660, var_39dd968a);
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xffb6fceb, Offset: 0x8228
// Size: 0x18
function function_50c2e8b0() {
    if (isdefined(self.scriptvehicletype)) {
        return false;
    }
    return true;
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xf7682e18, Offset: 0x8248
// Size: 0x34
function function_121ba443() {
    self notify(#"hash_2f673cce");
    self notify(#"hash_65af34bc");
    self ai::stop_shoot_at_target();
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xa84cc5b2, Offset: 0x8288
// Size: 0x134
function function_fc91db35(ai_enemy) {
    self notify(#"hash_65af34bc");
    self endon(#"hash_65af34bc");
    self ai::stop_shoot_at_target();
    str_mode = "kill_within_time";
    str_tag = "j_head";
    var_9b192fc6 = ai_enemy.scriptvehicletype;
    if (isdefined(var_9b192fc6)) {
        switch (var_9b192fc6) {
        case "quadtank":
            str_mode = "shoot_until_target_dead";
            str_tag = undefined;
            break;
        default:
            str_mode = "normal";
            str_tag = undefined;
            break;
        }
    }
    self ai::set_ignoreme(1);
    self ai::shoot_at_target(str_mode, ai_enemy, str_tag, 5);
    self ai::set_ignoreme(0);
}

// Namespace zurich_util
// Params 1, eflags: 0x0
// Checksum 0xf9153651, Offset: 0x83c8
// Size: 0xbe
function function_deebcec2(var_51d0e2ea) {
    self endon(#"hash_65af34bc");
    if (isalive(var_51d0e2ea) && isdefined(var_51d0e2ea.scriptvehicletype)) {
        switch (var_51d0e2ea.scriptvehicletype) {
        case "quadtank":
            self waittill(#"shoot");
            if (var_51d0e2ea function_51590606()) {
            } else if (var_51d0e2ea quadtank::trophy_destroyed()) {
            }
            break;
        default:
            break;
        }
    }
}

// Namespace zurich_util
// Params 1, eflags: 0x0
// Checksum 0xdcad62c0, Offset: 0x8490
// Size: 0x94
function function_c000269f(var_51d0e2ea) {
    self endon(#"hash_65af34bc");
    e_attacker = var_51d0e2ea waittill(#"death");
    if (self === e_attacker) {
        if (isdefined(var_51d0e2ea.scriptvehicletype)) {
            switch (var_51d0e2ea.scriptvehicletype) {
            case "siegebot":
                return;
            default:
                break;
            }
        }
        self function_738e77ab();
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x332593f0, Offset: 0x8530
// Size: 0x42
function function_738e77ab() {
    switch (randomint(2)) {
    case 0:
        break;
    case 1:
        break;
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x9e6aee99, Offset: 0x8580
// Size: 0x2e6
function function_2a6e38e() {
    self notify(#"hash_e2457c05");
    self endon(#"hash_e2457c05");
    self endon(#"death");
    while (true) {
        while (self haspath() || self function_f8645b6(-128, self geteye(), 0.65)) {
            wait 2;
        }
        var_8dc746d1 = undefined;
        var_1f5a4954 = distance2dsquared(self.goalpos, self geteye());
        var_564617aa = arraysortclosest(level.activeplayers, self.origin, 1);
        foreach (e_player in var_564617aa) {
            var_8dc746d1 = distance2dsquared(self.origin, e_player.origin);
        }
        var_10dc781e = self.goalradius * self.goalradius;
        var_1535123f = !self player_can_see_me(256) && !self function_f8645b6(-128, self.goalpos + (0, 0, 72), 0.65);
        var_63f4e3a5 = isdefined(var_8dc746d1) && var_8dc746d1 > 360 * 360 && var_1f5a4954 > var_10dc781e;
        var_92315b88 = !self haspath() && var_1f5a4954 > var_10dc781e;
        if (var_63f4e3a5 || var_1535123f && var_92315b88) {
            /#
                iprintln("<dev string:x7e>");
            #/
            self forceteleport(self.goalpos);
        }
        wait 2;
    }
}

// Namespace zurich_util
// Params 3, eflags: 0x1 linked
// Checksum 0x7d1eb471, Offset: 0x8870
// Size: 0x150
function function_f8645b6(n_dist, v_pos, n_dot) {
    if (!isdefined(n_dot)) {
        n_dot = 0.7;
    }
    if (!isdefined(n_dist)) {
        n_dist = 320;
    }
    for (i = 0; i < level.players.size; i++) {
        v_player_pos = level.players[i] geteye();
        if (level.players[i] util::is_player_looking_at(v_pos, n_dot, 1, level.players[i])) {
            return true;
        }
        var_b08b4a3b = distance2dsquared(v_pos, level.players[i] geteye());
        n_dist_sq = n_dist * n_dist;
        if (var_b08b4a3b < n_dist_sq) {
            return true;
        }
    }
    return false;
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xcc907cd9, Offset: 0x89c8
// Size: 0x12
function function_4fb68dd5() {
    self notify(#"hash_e2457c05");
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x8818f814, Offset: 0x89e8
// Size: 0x2e
function function_51590606() {
    if (!self vehicle_ai::iscooldownready("trophy_down")) {
        return true;
    }
    return false;
}

// Namespace zurich_util
// Params 3, eflags: 0x0
// Checksum 0xe47fb789, Offset: 0x8a20
// Size: 0x104
function function_d404d588(n_multiplier, str_start, var_bd62ea22) {
    if (!isdefined(n_multiplier)) {
        n_multiplier = 1;
    }
    self endon(#"death");
    s_start = self;
    if (isdefined(str_start)) {
        s_start = struct::get(str_start);
    }
    do {
        s_next = struct::get(s_start.target);
        self function_2153e0ef(s_start, s_next, n_multiplier, var_bd62ea22);
        s_start = s_next;
    } while (isdefined(s_start.target));
    self rotateto(s_next.angles, 0.05);
}

// Namespace zurich_util
// Params 4, eflags: 0x1 linked
// Checksum 0x50b2296b, Offset: 0x8b30
// Size: 0x10a
function function_2153e0ef(s_start, s_next, n_multiplier, var_bd62ea22) {
    if (!isdefined(s_start)) {
        s_start = self;
    }
    if (!isdefined(var_bd62ea22)) {
        var_bd62ea22 = 1;
    }
    var_387f863 = distance(s_next.origin, s_start.origin) / 72 / n_multiplier;
    self moveto(s_next.origin, var_387f863);
    if (var_bd62ea22) {
        var_d9f4bdfd = s_next.origin - s_start.origin;
        self.angles = vectortoangles(var_d9f4bdfd);
    }
    wait var_387f863;
}

// Namespace zurich_util
// Params 3, eflags: 0x1 linked
// Checksum 0x790c3759, Offset: 0x8c48
// Size: 0x100
function function_f9afa212(str_key, str_val, var_d646fb81) {
    if (!isdefined(str_val)) {
        str_val = "targetname";
    }
    var_33b370d9 = getspawnerarray(str_key, str_val);
    foreach (n_index, var_907b6d46 in var_33b370d9) {
        var_d697d6e2[n_index] = spawner::simple_spawn_single(var_907b6d46, &function_12141c31);
    }
    return var_d697d6e2;
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x65c66f12, Offset: 0x8d50
// Size: 0x64
function function_12141c31() {
    self vehicle::lights_off();
    self disableaimassist();
    self ai::set_ignoreme(1);
    self cybercom::function_58c312f2();
}

// Namespace zurich_util
// Params 3, eflags: 0x1 linked
// Checksum 0xe7874482, Offset: 0x8dc0
// Size: 0x12c
function function_3adbd846(str_val, str_key, b_once) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (!isdefined(b_once)) {
        b_once = 0;
    }
    t_trig = getent(str_val, str_key);
    if (isdefined(t_trig)) {
        t_trig endon(#"death");
        while (true) {
            e_triggerer = t_trig waittill(#"trigger");
            var_ccf2685a = isdefined(e_triggerer.owner) && isplayer(e_triggerer.owner);
            if (isplayer(e_triggerer) || var_ccf2685a) {
                break;
            }
        }
        if (b_once) {
            t_trig delete();
        }
    }
}

// Namespace zurich_util
// Params 7, eflags: 0x1 linked
// Checksum 0xd432b35, Offset: 0x8ef8
// Size: 0x11c
function function_1b3dfa61(str_name, str_type, n_width, n_height, n_length, var_88090aa5, str_objective) {
    if (!isdefined(str_type)) {
        str_type = "trigger_radius";
    }
    if (!isdefined(n_width)) {
        n_width = -128;
    }
    if (!isdefined(n_height)) {
        n_height = -128;
    }
    if (!isdefined(var_88090aa5)) {
        var_88090aa5 = 1;
    }
    t_trig = getent(str_name, "targename");
    if (var_88090aa5) {
        t_trig = function_3789d4db(str_name, str_type, n_width, n_height, n_length, str_objective);
    }
    t_trig waittill(#"trigger");
    if (isdefined(t_trig)) {
        t_trig delete();
    }
}

// Namespace zurich_util
// Params 6, eflags: 0x1 linked
// Checksum 0x59453607, Offset: 0x9020
// Size: 0x1c0
function function_3789d4db(str_name, str_type, n_width, n_height, n_length, str_objective) {
    if (!isdefined(str_type)) {
        str_type = "trigger_radius";
    }
    if (!isdefined(n_height)) {
        n_height = -128;
    }
    if (!isdefined(n_length)) {
        n_length = 0;
    }
    s_spot = struct::get(str_name);
    if (!isdefined(s_spot)) {
        s_spot = getent(str_name, "targetname");
    }
    if (!isdefined(n_width)) {
        n_width = -128;
        if (isdefined(s_spot.radius)) {
            n_width = s_spot.radius;
        }
    }
    t_trig = spawn(str_type, s_spot.origin, 0, n_width, n_height, n_length);
    t_trig.angles = s_spot.angles;
    t_trig.targetname = s_spot.targetname;
    t_trig.target = s_spot.target;
    t_trig.script_noteworthy = s_spot.script_noteworthy;
    t_trig.script_objective = str_objective;
    return t_trig;
}

// Namespace zurich_util
// Params 4, eflags: 0x0
// Checksum 0xf79de60d, Offset: 0x91e8
// Size: 0xf2
function function_5bb4d484(str_val, str_key, n_count, var_a3e7056a) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (!isdefined(var_a3e7056a)) {
        var_a3e7056a = 0.05;
    }
    sp_spawner = self;
    if (sp_spawner == level) {
        sp_spawner = getent(str_val, str_key);
    }
    a_ai = [];
    for (i = 0; i < n_count; i++) {
        a_ai[i] = spawner::simple_spawn_single(sp_spawner);
        wait var_a3e7056a;
    }
    return a_ai;
}

// Namespace zurich_util
// Params 3, eflags: 0x1 linked
// Checksum 0xfa5310e2, Offset: 0x92e8
// Size: 0x146
function function_b0dd51f4(str_spawner, str_key, var_a3e7056a) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (!isdefined(var_a3e7056a)) {
        var_a3e7056a = 0.05;
    }
    var_fe3db664 = getspawnerarray(str_spawner, str_key);
    if (var_fe3db664.size == 0) {
        var_fe3db664 = getvehiclespawnerarray(str_spawner, str_key);
    }
    a_ents = [];
    foreach (n_index, sp in var_fe3db664) {
        a_ents[n_index] = spawner::simple_spawn_single(sp);
        wait var_a3e7056a;
    }
    return a_ents;
}

// Namespace zurich_util
// Params 9, eflags: 0x1 linked
// Checksum 0xd6c25295, Offset: 0x9438
// Size: 0x332
function function_33ec653f(str_val, str_key, var_a3e7056a, spawn_func, param1, param2, param3, param4, param5) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (!isdefined(var_a3e7056a)) {
        var_a3e7056a = 0.05;
    }
    var_3979e78 = struct::get(str_val, str_key);
    var_3979e78 endon(#"stop");
    var_3979e78.a_ai = [];
    var_3979e78.n_spawned = 0;
    assert(isdefined(var_3979e78.target), "<dev string:xa0>" + var_3979e78.origin + "<dev string:xb9>" + var_3979e78.targetname + "<dev string:xcb>");
    var_3979e78.var_431a4b23 = getnodearray(var_3979e78.target, "targetname");
    if (var_3979e78.var_431a4b23.size == 0) {
        var_3979e78.var_431a4b23 = getvehiclenodearray(var_3979e78.target, "targetname");
    }
    if (var_3979e78.var_431a4b23.size == 0) {
        var_3979e78.var_431a4b23 = struct::get_array(var_3979e78.target);
    }
    var_3979e78.var_431a4b23 = array::randomize(var_3979e78.var_431a4b23);
    foreach (i, var_90eafbd0 in var_3979e78.var_431a4b23) {
        if (isdefined(var_90eafbd0.script_int) && var_90eafbd0.script_int > level.players.size) {
            continue;
        }
        var_3979e78.a_ai[i] = var_3979e78 function_a569867c(var_90eafbd0, spawn_func, i, param1, param2, param3, param4, param5);
        if (i === var_3979e78.script_int) {
            break;
        }
        wait var_a3e7056a;
    }
    return var_3979e78.a_ai;
}

// Namespace zurich_util
// Params 8, eflags: 0x1 linked
// Checksum 0xf792ecbb, Offset: 0x9778
// Size: 0x370
function function_a569867c(var_90eafbd0, spawn_func, i, param1, param2, param3, param4, param5) {
    if (!isdefined(var_90eafbd0)) {
        var_90eafbd0 = self;
    }
    if (!isdefined(i)) {
        i = 0;
    }
    assert(isdefined(var_90eafbd0.script_noteworthy), "<dev string:xeb>" + var_90eafbd0.origin + "<dev string:x102>" + self.targetname + "<dev string:x117>");
    var_2a999a2c = getent(var_90eafbd0.script_noteworthy, "targetname");
    assert(isdefined(var_2a999a2c), "<dev string:x154>" + var_90eafbd0.script_noteworthy);
    self.a_ai[i] = spawner::simple_spawn_single(var_2a999a2c);
    if (!isalive(self.a_ai[i])) {
        return;
    }
    if (!isdefined(self.n_spawned)) {
        self.n_spawned = 0;
    }
    self.n_spawned++;
    if (isactor(self.a_ai[i])) {
        self.a_ai[i] forceteleport(var_90eafbd0.origin, var_90eafbd0.angles);
    }
    self.a_ai[i].var_cdb0be8 = var_90eafbd0;
    self.a_ai[i].script_string = var_90eafbd0.script_string;
    self.a_ai[i].script_parameters = var_90eafbd0.script_parameters;
    if (isdefined(self.a_ai[i].var_cdb0be8.radius)) {
        self.a_ai[i].goalradius = self.a_ai[i].var_cdb0be8.radius;
    }
    if (isdefined(spawn_func)) {
        util::single_thread(self.a_ai[i], spawn_func, param1, param2, param3, param4, param5);
    }
    if (isvehicle(self.a_ai[i])) {
        self.a_ai[i] thread function_e8d7d9();
    } else {
        self.a_ai[i] thread function_dea7f09f();
    }
    return self.a_ai[i];
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x7739c795, Offset: 0x9af0
// Size: 0x23c
function function_dea7f09f() {
    self endon(#"death");
    target = self.var_cdb0be8;
    if (!isdefined(target.target)) {
        return;
    }
    a_s_scene = struct::get_array(target.target);
    s_scene = array::random(a_s_scene);
    wait 0.05;
    while (isdefined(s_scene) && isdefined(s_scene.scriptbundlename)) {
        level scene::play(s_scene.targetname, "targetname", self);
        target = s_scene;
        if (!isdefined(target.target)) {
            break;
        }
        s_scene = struct::get(target.target, "targetname");
    }
    if (!isdefined(target.target) || isdefined(self.scriptvehicletype)) {
        return;
    }
    goals = getnodearray(target.target, "targetname");
    if (goals.size == 0) {
        goals = getentarray(target.target, "targetname");
    }
    if (goals.size == 0) {
        goal = target;
    } else {
        goal = array::random(goals);
    }
    if (isdefined(goal) && !ispointonnavmesh(goal.origin)) {
        return;
    }
    self setgoal(goal);
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x5b8816b1, Offset: 0x9d38
// Size: 0xac
function function_e8d7d9() {
    self endon(#"death");
    if (isdefined(self.scriptvehicletype)) {
        self ai::set_ignoreme(1);
        self vehicle_ai::start_scripted();
    }
    self vehicle::get_on_and_go_path(self.var_cdb0be8);
    if (!isdefined(self.scriptvehicletype)) {
        return;
    }
    self ai::set_ignoreme(0);
    self vehicle_ai::stop_scripted();
}

// Namespace zurich_util
// Params 2, eflags: 0x0
// Checksum 0xc1a6e44e, Offset: 0x9df0
// Size: 0x10c
function function_3ee4a3b3(str_triggers, str_objective) {
    a_trigs = [];
    var_aba4ba44 = struct::get_array(str_triggers);
    foreach (i, s_trig in var_aba4ba44) {
        a_trigs[i] = function_3789d4db(s_trig.targetname, undefined, undefined, undefined, 768, str_objective);
    }
    array::thread_all(a_trigs, &function_1fb1b1c4);
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xa24466cb, Offset: 0x9f08
// Size: 0x44
function function_1fb1b1c4() {
    self endon(#"death");
    self waittill(#"trigger");
    function_33ec653f(self.target, undefined, undefined, &function_d065a580);
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xd456d94a, Offset: 0x9f58
// Size: 0x134
function function_d065a580() {
    self endon(#"death");
    wait 0.05;
    for (var_5f2b7673 = self.var_cdb0be8; isdefined(var_5f2b7673); var_5f2b7673 = array::random(var_b3a8bd53)) {
        self function_ff6b67ed(var_5f2b7673);
        if (!isdefined(var_5f2b7673.target)) {
            break;
        }
        wait randomfloatrange(0.25, 0.38);
        var_b3a8bd53 = getnodearray(var_5f2b7673.target, "targetname");
        if (var_b3a8bd53.size < 1) {
            var_b3a8bd53 = struct::get_array(var_5f2b7673.target);
        }
        if (var_b3a8bd53.size < 1) {
            break;
        }
    }
    self delete();
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x4c922b65, Offset: 0xa098
// Size: 0x1fa
function function_a00fa665(str_objective) {
    if (isdefined(level.var_65070634)) {
        level.var_65070634 notify(#"hash_11a8c313");
    }
    switch (str_objective) {
    case "clearing_hub":
        var_ef5507a6 = "clearing_start";
        break;
    case "clearing_hub_2":
        var_ef5507a6 = "clearing_start";
        var_9636f088 = "p7_fxanim_cp_zurich_dni_tree_broken01_mod";
        break;
    case "clearing_hub_3":
        var_ef5507a6 = "clearing_start";
        var_9636f088 = "p7_fxanim_cp_zurich_dni_tree_broken02_mod";
        break;
    default:
        var_ef5507a6 = str_objective;
        break;
    }
    s_tree = struct::get(var_ef5507a6, "script_noteworthy");
    if (isdefined(var_9636f088)) {
        var_814bdb75 = var_9636f088;
    } else {
        var_814bdb75 = s_tree.model;
    }
    if (!isdefined(var_814bdb75)) {
        var_814bdb75 = "p7_zur_coalescence_dni_tree";
    }
    level.var_65070634 = util::spawn_model(var_814bdb75, s_tree.origin, s_tree.angles);
    if (!isdefined(s_tree.script_float)) {
        s_tree.script_float = 1;
    }
    level.var_65070634 setscale(s_tree.script_float);
    level.var_65070634.shadow_casting = 0;
    level.var_65070634 thread function_17fdda66();
    return level.var_65070634;
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xb914065c, Offset: 0xa2a0
// Size: 0xa4
function function_17fdda66() {
    wait 0.1;
    self clientfield::set("corvus_tree_shader", 1);
    self waittill(#"hash_11a8c313");
    self clientfield::set("corvus_tree_shader", 0);
    if (isdefined(self.var_73c84646)) {
        self.var_73c84646 delete();
    }
    util::wait_network_frame();
    self delete();
}

// Namespace zurich_util
// Params 2, eflags: 0x1 linked
// Checksum 0x2526ada0, Offset: 0xa350
// Size: 0x442
function player_weather(is_on, str_effect) {
    if (is_on && isdefined(str_effect)) {
        switch (str_effect) {
        case "regular_snow":
            if (isplayer(self)) {
                self clientfield::set_to_player("player_weather", 1);
            } else {
                foreach (player in level.players) {
                    player clientfield::set_to_player("player_weather", 1);
                }
            }
            break;
        case "light_snow":
            if (isplayer(self)) {
                self clientfield::set_to_player("player_weather", 4);
            } else {
                foreach (player in level.players) {
                    player clientfield::set_to_player("player_weather", 4);
                }
            }
            break;
        case "red_rain":
            if (isplayer(self)) {
                self clientfield::set_to_player("player_weather", 2);
            } else {
                foreach (player in level.players) {
                    player clientfield::set_to_player("player_weather", 2);
                }
            }
            break;
        case "reverse_snow":
            if (isplayer(self)) {
                self clientfield::set_to_player("player_weather", 3);
            } else {
                foreach (player in level.players) {
                    player clientfield::set_to_player("player_weather", 3);
                }
            }
            break;
        }
        return;
    }
    if (isplayer(self)) {
        self clientfield::set_to_player("player_weather", 0);
        return;
    }
    foreach (player in level.players) {
        player clientfield::set_to_player("player_weather", 0);
    }
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xac43f66, Offset: 0xa7a0
// Size: 0xbc
function function_7be427b1(n_damage) {
    if (!isdefined(n_damage)) {
        n_damage = 5;
    }
    self endon(#"stop_radiation_monitor");
    self endon(#"death");
    var_dd075cd2 = 1;
    self hazard::function_459e5eff("biohazard", 0);
    level.overrideplayerdamage = &function_6255dfdc;
    while (true) {
        wait 1;
        var_dd075cd2 = self hazard::do_damage("biohazard", n_damage);
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x1cb082f1, Offset: 0xa868
// Size: 0x2c
function function_61bb5738() {
    level.overrideplayerdamage = undefined;
    self hazard::function_459e5eff("biohazard", 1);
}

// Namespace zurich_util
// Params 11, eflags: 0x1 linked
// Checksum 0xd7f15165, Offset: 0xa8a0
// Size: 0x5e
function function_6255dfdc(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    return false;
}

// Namespace zurich_util
// Params 0, eflags: 0x0
// Checksum 0x53b03e40, Offset: 0xa908
// Size: 0x9c
function mobile_armory_in_use() {
    foreach (e_player in level.activeplayers) {
        if (e_player flagsys::get("mobile_armory_in_use")) {
            return true;
        }
    }
    return false;
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x92214ae3, Offset: 0xa9b0
// Size: 0x9c
function function_41753e77(var_8907c2b8) {
    var_b14c1a2c = [];
    var_b14c1a2c["dni_futz"] = "postfx_futz";
    assert(isdefined(var_b14c1a2c[var_8907c2b8]), "<dev string:x177>" + var_8907c2b8);
    wait randomfloat(0.25);
    self thread clientfield::increment_to_player(var_b14c1a2c[var_8907c2b8]);
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x815b41ca, Offset: 0xaa58
// Size: 0x104
function function_11b424e5(is_on) {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    if (isdefined(is_on) && !isplayer(self)) {
        if (is_on) {
            level.var_60bad7a5 = 1;
            array::run_all(level.players, &util::function_16c71b8, 1);
        } else {
            level.var_60bad7a5 = 0;
            array::run_all(level.players, &util::function_16c71b8, 0);
        }
        return;
    }
    if (isdefined(level.var_60bad7a5)) {
        if (level.var_60bad7a5) {
            self util::function_16c71b8(1);
            return;
        }
        self util::function_16c71b8(0);
    }
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xf4b90335, Offset: 0xab68
// Size: 0x74
function function_c049667c(is_true) {
    if (is_true) {
        var_cc4031e3 = getweapon("smg_standard_hero");
    } else {
        var_cc4031e3 = level.var_3d556bcd.primaryweapon;
    }
    level.var_3d556bcd ai::gun_switchto(var_cc4031e3, "right");
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x8fe552c5, Offset: 0xabe8
// Size: 0x90
function function_d1996775() {
    var_376507c0 = %cp_level_zurich_hack_lobby_door;
    str_hint = %CP_MI_ZURICH_COALESCENCE_HACK;
    self hacking::function_68df65d8(3, var_376507c0, str_hint);
    e_who = self hacking::trigger_wait();
    self triggerenable(0);
    return e_who;
}

// Namespace zurich_util
// Params 1, eflags: 0x0
// Checksum 0xf9ed03b0, Offset: 0xac80
// Size: 0x1a
function function_9bb12e2f(params) {
    level notify(#"hash_9bb12e2f");
}

// Namespace zurich_util
// Params 0, eflags: 0x0
// Checksum 0x70520d2, Offset: 0xaca8
// Size: 0x78
function function_74c09be7() {
    var_376507c0 = %cp_level_zurich_hack_lobby_door;
    str_hint = %CP_MI_ZURICH_COALESCENCE_HACK;
    util::function_14518e76(self, var_376507c0, str_hint, &function_89a1383e);
    self triggerenable(1);
    level waittill(#"hash_a271fdb7");
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xc329021a, Offset: 0xad28
// Size: 0x5a
function function_89a1383e(e_player) {
    self gameobjects::disable_object();
    self.e_player = e_player;
    e_player cybercom::function_f8669cbf(1);
    level notify(#"hash_a271fdb7");
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x66980811, Offset: 0xad90
// Size: 0x78
function function_f3bcbbb1() {
    var_376507c0 = %cp_level_zurich_burn_vines;
    str_hint = %CP_MI_ZURICH_COALESCENCE_BURN;
    util::function_14518e76(self, var_376507c0, str_hint, &function_b6a9fc24);
    self triggerenable(1);
    level waittill(#"hash_e9197af7");
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x71bc4ac6, Offset: 0xae10
// Size: 0x4a
function function_b6a9fc24(e_player) {
    self gameobjects::disable_object();
    e_player thread function_4a447e94();
    level notify(#"hash_e9197af7");
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x52facad9, Offset: 0xae68
// Size: 0xc6
function function_aceff870() {
    self endon(#"death");
    self.var_48772f67 = 1;
    while (true) {
        e_player = util::get_closest_player(self.origin, "allies");
        if (isdefined(e_player)) {
            var_eb23928c = getclosestpointonnavmesh(e_player.origin, -128, 32);
            if (isdefined(var_eb23928c)) {
                self ai::force_goal(var_eb23928c, -128, 1);
            }
        }
        wait 3;
    }
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xa1a447c6, Offset: 0xaf38
// Size: 0x4c
function function_f3e247d6(a_ents) {
    if (isdefined(a_ents["corvus"])) {
        a_ents["corvus"] clientfield::set("corvus_body_fx", 1);
    }
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0x10ccd1ac, Offset: 0xaf90
// Size: 0x74
function function_c83720c9() {
    var_347ccc07 = getent("garage_bounds", "targetname");
    var_347ccc07 setinvisibletoall();
    trigger::wait_till("triage_regroup");
    var_347ccc07 setvisibletoall();
}

// Namespace zurich_util
// Params 2, eflags: 0x1 linked
// Checksum 0xb7064fc0, Offset: 0xb010
// Size: 0x2f0
function function_2e1830eb(var_c7d3f5b3, str_objective) {
    s_scene = undefined;
    a_mdl_parts = [];
    mdl_origin = undefined;
    var_3ecdb245 = struct::get_array(var_c7d3f5b3);
    foreach (i, s_part in var_3ecdb245) {
        if (isdefined(s_part.scriptbundlename)) {
            s_scene = s_part;
            continue;
        }
        wait 0.05;
        if (s_part.script_noteworthy === "origin") {
            mdl_origin = util::spawn_model("tag_origin", s_part.origin, s_part.angles);
            mdl_origin.targetname = s_part.targetname;
            mdl_origin.script_objective = str_objective;
            /#
                recordent(mdl_origin);
            #/
            continue;
        }
        if (!isdefined(s_part.model)) {
            continue;
        }
        a_mdl_parts[i] = util::spawn_model("p7_sgen_charging_station_pod_white", s_part.origin, s_part.angles);
        a_mdl_parts[i].script_objective = str_objective;
        /#
            recordent(a_mdl_parts[i]);
        #/
    }
    foreach (j, mdl_part in a_mdl_parts) {
        mdl_part linkto(mdl_origin);
        mdl_origin.a_mdl_parts[j] = mdl_part;
    }
    mdl_origin.s_scene = s_scene;
}

// Namespace zurich_util
// Params 6, eflags: 0x1 linked
// Checksum 0xc8c2284, Offset: 0xb308
// Size: 0x73e
function function_27904cd4(var_c7d3f5b3, str_objective, n_count, var_31561fde, n_min_time, n_max_time) {
    if (!isdefined(n_count)) {
        n_count = 0;
    }
    if (!isdefined(var_31561fde)) {
        var_31561fde = 1;
    }
    if (!isdefined(n_min_time)) {
        n_min_time = 1;
    }
    if (!isdefined(n_max_time)) {
        n_max_time = 4;
    }
    level endon(str_objective + "_completed");
    str_scenedef = "cin_zur_02_01_climb_aie_charging_station";
    var_18dfedfa = array("sec_assault_ar", "sec_suppressor_ar", "sec_cqb_shotgun", "sec_rpg_rocket", "sec_suppressor_mg", "sec_sniper", "sec_rusher", "sec_exploder");
    var_ce83537c = getent(var_c7d3f5b3, "targetname");
    var_ce83537c endon(#"death");
    var_ce83537c endon(#"disable");
    if (!isdefined(var_ce83537c.mdl_origin)) {
        var_ce83537c.mdl_origin = util::spawn_model("tag_origin", var_ce83537c.s_scene.origin, var_ce83537c.s_scene.angles);
    }
    var_ce83537c.v_start_angles = var_ce83537c.angles;
    var_ce83537c.mdl_origin.script_objective = str_objective;
    var_ce83537c.a_ai = [];
    var_ce83537c.n_spawned = 0;
    var_ce83537c.b_active = 1;
    wait 0.05;
    do {
        var_ce83537c.a_ai = array::remove_dead(var_ce83537c.a_ai);
        if (var_ce83537c.a_ai.size >= var_31561fde) {
            wait 2;
            continue;
        }
        str_spawner = array::random(var_18dfedfa);
        var_ce83537c.ai_spawned = spawner::simple_spawn_single(str_spawner);
        var_ce83537c.mdl_origin linkto(var_ce83537c);
        if (!isalive(var_ce83537c.ai_spawned)) {
            wait 0.05;
            continue;
        }
        var_ce83537c.ai_spawned ai::set_ignoreme(1);
        if (isdefined(var_ce83537c.s_scene.script_label)) {
            var_ce83537c.ai_spawned colors::set_force_color(var_ce83537c.s_scene.script_label);
        }
        if (!isdefined(var_ce83537c.a_ai)) {
            var_ce83537c.a_ai = [];
        } else if (!isarray(var_ce83537c.a_ai)) {
            var_ce83537c.a_ai = array(var_ce83537c.a_ai);
        }
        var_ce83537c.a_ai[var_ce83537c.a_ai.size] = var_ce83537c.ai_spawned;
        var_ce83537c.n_spawned++;
        var_ce83537c.ai_spawned forceteleport(var_ce83537c.mdl_origin.origin, var_ce83537c.mdl_origin.angles);
        var_ce83537c.ai_spawned linkto(var_ce83537c.mdl_origin);
        var_ce83537c.mdl_origin scene::init(str_scenedef, var_ce83537c.ai_spawned);
        var_ce83537c rotateyaw(-76, randomfloatrange(0.89, 1.4));
        var_ce83537c waittill(#"rotatedone");
        if (!isalive(var_ce83537c.ai_spawned)) {
            var_ce83537c.mdl_origin unlink();
            var_ce83537c.mdl_origin.origin = var_ce83537c.s_scene.origin;
            var_ce83537c.mdl_origin.angles = var_ce83537c.s_scene.angles;
            continue;
        }
        var_ce83537c.mdl_origin scene::play(str_scenedef, var_ce83537c.ai_spawned);
        if (isalive(var_ce83537c.ai_spawned)) {
            var_ce83537c.ai_spawned ai::set_ignoreme(0);
            var_ce83537c.ai_spawned unlink();
        }
        var_ce83537c.ai_spawned = undefined;
        var_ce83537c.mdl_origin unlink();
        var_ce83537c.mdl_origin.origin = var_ce83537c.s_scene.origin;
        var_ce83537c.mdl_origin.angles = var_ce83537c.s_scene.angles;
        wait randomfloatrange(n_min_time, n_max_time);
        if (n_count != 0 && var_ce83537c.n_spawned >= n_count) {
            b_active = 0;
        }
    } while (isdefined(var_ce83537c.b_active) && var_ce83537c.b_active);
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x72494aeb, Offset: 0xba50
// Size: 0xf4
function function_5b0d9c63(var_c7d3f5b3) {
    var_ce83537c = getent(var_c7d3f5b3, "targetname");
    if (!isdefined(var_ce83537c)) {
        /#
            iprintln("<dev string:x1ba>" + var_c7d3f5b3 + "<dev string:x1dc>");
        #/
        return;
    }
    var_ce83537c notify(#"disable");
    var_ce83537c.b_active = 0;
    if (isalive(var_ce83537c.ai_spawned)) {
        var_ce83537c.ai_spawned kill();
    }
    var_ce83537c rotateto(var_ce83537c.v_start_angles, 1);
}

// Namespace zurich_util
// Params 0, eflags: 0x1 linked
// Checksum 0xbf69ee31, Offset: 0xbb50
// Size: 0x1f8
function function_6d571441() {
    self endon(#"death");
    while (true) {
        n_damage, e_attacker, _, _, str_damage_type = self waittill(#"damage");
        self.health += n_damage;
        var_a4a673a9 = str_damage_type == "MOD_PROJECTILE" || str_damage_type === "MOD_EXPLOSIVE";
        if (isplayer(e_attacker) && var_a4a673a9) {
            self.var_7a04481c -= n_damage;
        }
        if (self.var_7a04481c <= 0) {
            var_6c5bbb3f = array::random(self.var_90937e6);
            self vehicle::god_on();
            self vehicle::get_off_path();
            self setspeed(42, 18, 12);
            self setvehgoalpos(var_6c5bbb3f.origin);
            self waittill(#"goal");
            self vehicle::god_off();
            array::run_all(self.riders, &kill);
            self dodamage(self.health + 100, self.origin, e_attacker);
        }
    }
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x4de3c355, Offset: 0xbd50
// Size: 0x7c
function function_fe5160df(var_f553b6d0) {
    self endon(#"death");
    if (var_f553b6d0) {
        wait randomfloatrange(1, 3);
        self clientfield::set("hero_cold_breath", 1);
        return;
    }
    self clientfield::set("hero_cold_breath", 0);
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x426838f1, Offset: 0xbdd8
// Size: 0x5c
function function_e547724d(a_ents) {
    a_ents["raven"] hide();
    level waittill(#"hash_755edaa4");
    a_ents["raven"] show();
}

// Namespace zurich_util
// Params 1, eflags: 0x0
// Checksum 0xa0486690, Offset: 0xbe40
// Size: 0x2c
function function_3f6f483d(a_ents) {
    a_ents["raven"] show();
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x13b78efb, Offset: 0xbe78
// Size: 0xec
function function_86b1cd8a(a_ents) {
    a_ents["raven"] endon(#"death");
    a_ents["raven"] hide();
    a_ents["raven"] waittill(#"hash_db8335ba");
    a_ents["raven"] show();
    a_ents["raven"] waittill(#"hash_c03e8e55");
    a_ents["raven"] clientfield::set("raven_fade_out", 1);
    wait 0.5;
    a_ents["raven"] hide();
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x6d0bddd3, Offset: 0xbf70
// Size: 0x8c
function function_2504fb31(b_on) {
    a_clip = getentarray("hq_atrium_player_clip", "targetname");
    if (b_on) {
        array::run_all(a_clip, &solid);
        return;
    }
    array::run_all(a_clip, &notsolid);
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x61716575, Offset: 0xc008
// Size: 0x7c
function function_df1fc23b(var_350533f8) {
    if (var_350533f8) {
        hidemiscmodels("hq_exit_panel_outro");
        showmiscmodels("hq_exit_panel_hacked_outro");
        return;
    }
    hidemiscmodels("hq_exit_panel_hacked_outro");
    showmiscmodels("hq_exit_panel_outro");
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0xab5f011e, Offset: 0xc090
// Size: 0x4c
function function_162b9ea0(a_ents) {
    e_door = a_ents["tower_door"];
    level waittill(#"hash_1851c43a");
    e_door delete();
}

// Namespace zurich_util
// Params 1, eflags: 0x1 linked
// Checksum 0x1704147a, Offset: 0xc0e8
// Size: 0x8e8
function function_4a00a473(str_location) {
    if (str_location == "street") {
        level struct::function_368120a1("scene", "cin_zur_01_01_intro_1st_lost_contact");
        return;
    }
    if (str_location == "garage") {
        level struct::function_368120a1("scene", "cin_zur_melee_robot_choke_throw");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_car_crash_stuck_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_parking_wall_explode_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_truck_crash_01_bundle");
        return;
    }
    if (str_location == "plaza_battle") {
        level struct::function_368120a1("scene", "cin_zur_02_01_climb_aie_charging_station");
        level struct::function_368120a1("scene", "cin_zur_03_01_train_vign_bodies02");
        level struct::function_368120a1("scene", "cin_zur_03_01_train_vign_bodies03");
        level struct::function_368120a1("scene", "cin_zur_03_01_train_vign_bodies04");
        level struct::function_368120a1("scene", "cin_zur_03_01_train_vign_strapped");
        level struct::function_368120a1("scene", "cin_zur_04_01_ext_vign_lockdown");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_car_crash_01_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_car_crash_02_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_car_crash_03_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_car_crash_04_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_car_crash_05_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_hunter_start_01_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_hunter_start_02_bundle");
        return;
    }
    if (str_location == "server_room") {
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_train_seats_bundle");
        level struct::function_368120a1("scene", "cin_zur_06_02_decontamination_vign_schematic");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh010");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh020");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh030");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh040");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh050");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh060");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh070");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh080");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh090");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh100");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh110");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh120");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh130");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh140");
        level struct::function_368120a1("scene", "cin_zur_06_sacrifice_3rd_sh150");
        return;
    }
    if (str_location == "clearing_hub") {
        level struct::function_368120a1("scene", "cin_zur_09_01_standoff_1st_hostage");
        level struct::function_368120a1("scene", "cin_zur_09_02_standoff_1st_forest");
        level struct::function_368120a1("scene", "cin_zur_09_02_standoff_3rd_forest_part2_sh010");
        level struct::function_368120a1("scene", "cin_zur_09_01_standoff_vign_far_as_i_go");
        level struct::function_368120a1("scene", "cin_zur_10_01_kruger_3rd_questioned_sh010");
        level struct::function_368120a1("scene", "cin_zur_10_01_kruger_3rd_questioned_sh020");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_rock_slide_bundle");
        return;
    }
    if (str_location == "root_zurich") {
        level struct::function_368120a1("scene", "cin_zur_12_01_root_1st_mirror_01");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_roots_train_bundle");
        return;
    }
    if (str_location == "root_cairo") {
        level struct::function_368120a1("scene", "cin_zur_14_01_cairo_root_1st_fall");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_checkpoint_wall_01_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_wall_drop_bundle");
        return;
    }
    if (str_location == "clearing_hub_3") {
        level struct::function_368120a1("scene", "cin_zur_12_01_root_1st_crumble");
        level struct::function_368120a1("scene", "cin_zur_12_01_root_1st_crumble3");
        return;
    }
    if (str_location == "root_singapore") {
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_ferris_wheel_wave_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_container_collapse_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_ferris_wheel_bundle");
        level struct::function_368120a1("scene", "p7_fxanim_cp_zurich_car_slide_bundle");
    }
}

// Namespace zurich_util
// Params 2, eflags: 0x1 linked
// Checksum 0x949ecb5e, Offset: 0xc9d8
// Size: 0x122
function function_9f90bc0f(a_ents, str_notify) {
    if (isdefined(str_notify)) {
        level waittill(str_notify);
    }
    if (isdefined(self.scriptbundlename)) {
        level struct::function_368120a1("scene", self.scriptbundlename);
    }
    a_ents = array::remove_undefined(a_ents);
    if (a_ents.size) {
        foreach (e_ent in a_ents) {
            if (!isplayer(e_ent)) {
                e_ent delete();
            }
        }
    }
}

// Namespace zurich_util
// Params 3, eflags: 0x1 linked
// Checksum 0x4ae0212, Offset: 0xcb08
// Size: 0xfa
function function_3f4f84e(str_key, str_val, b_enable) {
    if (!isdefined(str_val)) {
        str_val = "targetname";
    }
    if (!isdefined(b_enable)) {
        b_enable = 1;
    }
    a_nodes = getnodearray(str_key, str_val);
    foreach (nd in a_nodes) {
        setenablenode(nd, b_enable);
    }
}

/#

    // Namespace zurich_util
    // Params 7, eflags: 0x1 linked
    // Checksum 0x81d5cf5, Offset: 0xcc10
    // Size: 0xd8
    function function_c7d0d818(var_eff163a9, var_15f3de12, str_endon, v_color, var_a12eb64b, str_tag1, str_tag2) {
        if (!isdefined(str_endon)) {
            str_endon = "<dev string:x1e4>";
        }
        if (!isdefined(v_color)) {
            v_color = (0, 1, 0);
        }
        var_eff163a9 endon(str_endon);
        var_15f3de12 endon(str_endon);
        self endon(var_a12eb64b);
        while (true) {
            recordline(var_eff163a9.origin, var_15f3de12.origin, v_color, "<dev string:x1ea>", var_eff163a9);
            wait 0.05;
        }
    }

    // Namespace zurich_util
    // Params 3, eflags: 0x1 linked
    // Checksum 0xf7c21938, Offset: 0xccf0
    // Size: 0xa8
    function function_9ff5370d(n_radius, v_color, e_owner) {
        if (!isdefined(n_radius)) {
            n_radius = 64;
        }
        if (!isdefined(v_color)) {
            v_color = (0, 1, 0);
        }
        if (!isdefined(e_owner)) {
            e_owner = self;
        }
        self endon(#"hash_dc898c8");
        while (isdefined(self)) {
            recordcircle(self.origin, n_radius, v_color, "<dev string:x1ea>", e_owner);
            wait 0.05;
        }
    }

    // Namespace zurich_util
    // Params 3, eflags: 0x1 linked
    // Checksum 0x22aa1268, Offset: 0xcda0
    // Size: 0xa8
    function function_68a764f6(n_radius, v_color, e_owner) {
        if (!isdefined(n_radius)) {
            n_radius = 64;
        }
        if (!isdefined(v_color)) {
            v_color = (0, 1, 0);
        }
        if (!isdefined(e_owner)) {
            e_owner = self;
        }
        self endon(#"hash_5322c93b");
        while (isdefined(self)) {
            recordsphere(self.origin, n_radius, v_color, "<dev string:x1ea>", e_owner);
            wait 0.05;
        }
    }

    // Namespace zurich_util
    // Params 3, eflags: 0x1 linked
    // Checksum 0x62d186c, Offset: 0xce50
    // Size: 0x90
    function function_ff016910(str_text, v_color, e_owner) {
        if (!isdefined(v_color)) {
            v_color = (0, 1, 0);
        }
        if (!isdefined(e_owner)) {
            e_owner = self;
        }
        self endon(#"hash_8fba9");
        while (isdefined(self)) {
            record3dtext(str_text, self.origin, v_color, "<dev string:x1ea>", e_owner);
            wait 0.05;
        }
    }

    // Namespace zurich_util
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa4caec46, Offset: 0xcee8
    // Size: 0x12
    function function_e8b99762() {
        self endon(#"death");
    }

    // Namespace zurich_util
    // Params 0, eflags: 0x0
    // Checksum 0xbecebfde, Offset: 0xcf08
    // Size: 0x198
    function function_c118d07d() {
        self endon(#"death");
        while (true) {
            n_damage, e_attacker, v_direction, v_point, str_type, str_tagname, str_modelname, var_2be8aff, w_weapon = self waittill(#"damage");
            var_e548f607 = "<dev string:x1f1>";
            if (!isdefined(str_type)) {
                str_type = "<dev string:x1f1>";
            }
            if (isentity(e_attacker)) {
                var_e548f607 = e_attacker.classname;
                if (var_e548f607 === "<dev string:x1f9>") {
                    var_e548f607 = e_attacker.scriptvehicletype;
                }
                self thread function_4363773d(e_attacker, v_point, n_damage, var_e548f607, str_type);
            }
            iprintln("<dev string:x208>" + n_damage);
            iprintln("<dev string:x211>" + var_e548f607);
            iprintln("<dev string:x21c>" + str_type);
        }
    }

    // Namespace zurich_util
    // Params 5, eflags: 0x1 linked
    // Checksum 0x5ca686cf, Offset: 0xd0a8
    // Size: 0x318
    function function_4363773d(e_attacker, v_hit, n_damage, var_e548f607, str_type) {
        self endon(#"damage");
        self endon(#"death");
        var_7cc4d7ae = e_attacker.origin;
        v_player_pos = self.origin;
        var_ba43239b = e_attacker gettagorigin("<dev string:x223>");
        if (!isdefined(var_ba43239b)) {
            var_ba43239b = e_attacker.origin;
        }
        var_b19349be = distance(var_ba43239b, v_hit);
        while (true) {
            record3dtext("<dev string:x211>" + var_e548f607, var_ba43239b + (0, 0, 8), (1, 0, 0), "<dev string:x1ea>", self);
            record3dtext("<dev string:x208>" + n_damage, var_ba43239b, (1, 0, 0), "<dev string:x1ea>", self);
            record3dtext("<dev string:x21c>" + str_type, var_ba43239b + (0, 0, -8), (1, 0, 0), "<dev string:x1ea>", self);
            record3dtext("<dev string:x22d>" + var_b19349be, var_ba43239b + (0, 0, -16), (1, 0, 0), "<dev string:x1ea>", self);
            recordcircle(var_7cc4d7ae, 32, (1, 0, 0), "<dev string:x1ea>", self);
            recordcircle(v_player_pos, 32, (0, 1, 0), "<dev string:x1ea>", self);
            recordsphere(var_ba43239b, 6, (1, 0, 0), "<dev string:x1ea>", self);
            recordsphere(v_hit, 6, (1, 1, 0), "<dev string:x1ea>", self);
            recordline(var_ba43239b, v_hit, (1, 0, 0), "<dev string:x1ea>", self);
            if (isdefined(e_attacker)) {
                recordcircle(e_attacker.origin, 24, (1, 1, 0), "<dev string:x1ea>", self);
                recordline(var_7cc4d7ae, e_attacker.origin, (1, 1, 0), "<dev string:x1ea>", self);
            }
            wait 0.05;
        }
    }

#/
