#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_fx;
#using scripts/cp/cp_mi_zurich_coalescence_patch_c;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_street;
#using scripts/cp/cp_mi_zurich_coalescence_root_cairo;
#using scripts/cp/cp_mi_zurich_coalescence_root_zurich;
#using scripts/cp/cp_mi_zurich_coalescence_root_singapore;
#using scripts/cp/cp_mi_zurich_coalescence_root_cinematics;
#using scripts/cp/cp_mi_zurich_coalescence_clearing;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_util;
#using scripts/cp/_load;
#using scripts/shared/filter_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_f165e60d;

// Namespace namespace_f165e60d
// Params 0, eflags: 0x0
// Checksum 0xbdf99673, Offset: 0xb00
// Size: 0x12c
function main() {
    init_clientfields();
    util::function_57b966c8(&function_71f88fc, 9);
    namespace_2ebd997a::main();
    namespace_b301a1fd::main();
    namespace_bbb4ee72::main();
    namespace_3d19ef22::main();
    namespace_6a04e6cd::main();
    namespace_73dbe018::main();
    namespace_29799936::main();
    namespace_1beb9396::main();
    function_673254cc();
    load::main();
    level.oob_timelimit_ms = getdvarint("oob_timelimit_ms", 3000);
    util::waitforclient(0);
    namespace_3a5b90::function_7403e82b();
}

// Namespace namespace_f165e60d
// Params 0, eflags: 0x0
// Checksum 0x7b827073, Offset: 0xc38
// Size: 0x1b4
function init_clientfields() {
    clientfield::register("world", "intro_ambience", 1, 1, "int", &function_ba3ef194, 0, 0);
    clientfield::register("world", "plaza_battle_amb_wasps", 1, 1, "int", &function_87d2cd22, 0, 0);
    clientfield::register("world", "hq_amb", 1, 1, "int", &function_5cd74265, 0, 0);
    clientfield::register("world", "decon_spray", 1, 1, "int", &function_5080f69e, 0, 0);
    clientfield::register("world", "clearing_hide_lotus_tower", 1, 1, "int", &function_cb32c615, 0, 0);
    clientfield::register("world", "clearing_hide_ferris_wheel", 1, 1, "int", &function_9d9bb681, 0, 0);
}

// Namespace namespace_f165e60d
// Params 0, eflags: 0x0
// Checksum 0x2e55871b, Offset: 0xdf8
// Size: 0x3ec
function function_673254cc() {
    skipto::add("zurich", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("intro_igc", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("intro_pacing", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("street", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("garage", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("rails", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("plaza_battle", &namespace_8e9083ff::function_5bcd68f2, undefined, &namespace_8e9083ff::function_3bf27f88);
    skipto::add("hq", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("sacrifice", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("clearing_start", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("clearing_waterfall", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("clearing_path_choice", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("clearing_hub", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("root_zurich_start", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("root_zurich_vortex", &namespace_8e9083ff::function_5bcd68f2, undefined, &namespace_8e9083ff::function_3bf27f88);
    skipto::add("clearing_hub_2", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("root_cairo_start", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("root_cairo_vortex", &namespace_8e9083ff::function_5bcd68f2, undefined, &namespace_8e9083ff::function_3bf27f88);
    skipto::add("clearing_hub_3", &namespace_8e9083ff::function_5bcd68f2, undefined, &namespace_8e9083ff::function_3bf27f88);
    skipto::add("root_singapore_start", &namespace_3d19ef22::function_5bcd68f2);
    skipto::add("root_singapore_vortex", &namespace_3d19ef22::function_95b88092, undefined, &namespace_3d19ef22::skipto_end);
    skipto::add("outro_movie", &namespace_8e9083ff::function_5bcd68f2);
    skipto::add("server_interior", &namespace_8e9083ff::function_5bcd68f2);
}

// Namespace namespace_f165e60d
// Params 1, eflags: 0x0
// Checksum 0x82924721, Offset: 0x11f0
// Size: 0x32a
function function_71f88fc(n_zone) {
    switch (n_zone) {
    case 1:
        break;
    case 2:
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh010");
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh020");
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh030");
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh040");
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh050");
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh060");
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh070");
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh080");
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh090");
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh100");
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh110");
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh120");
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh130");
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh140");
        forcestreambundle("cin_zur_06_sacrifice_3rd_sh150");
        break;
    case 3:
        forcestreambundle("cin_zur_09_02_standoff_1st_forest");
        forcestreamxmodel("p7_foliage_tree_redwood_xlrg_base_02");
        forcestreamxmodel("p7_foliage_tree_redwood_med_base_01");
        forcestreamxmodel("p7_foliage_tree_redwood_lrg_mid");
        forcestreamxmodel("p7_foliage_tree_redwood_lrg_top");
        break;
    case 4:
        break;
    case 5:
        forcestreambundle("cin_zur_09_01_standoff_vign_far_as_i_go");
        forcestreambundle("p7_fxanim_cp_zurich_tree_krueger_split_rt_bundle");
        forcestreambundle("cin_zur_11_01_paths_1st_still_chance");
        break;
    case 6:
        break;
    case 7:
        break;
    case 8:
        forcestreambundle("p7_fxanim_cp_zurich_roots_water01_bundle");
        forcestreambundle("p7_fxanim_cp_zurich_roots_water02_bundle");
        break;
    case 9:
        forcestreambundle("cin_zur_20_01_plaza_1st_fight_it");
        forcestreambundle("cin_zur_20_01_plaza_1st_fight_it_player_start");
        break;
    default:
        break;
    }
}

// Namespace namespace_f165e60d
// Params 7, eflags: 0x0
// Checksum 0x1f7c346e, Offset: 0x1528
// Size: 0xee
function function_ba3ef194(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (isdefined(level.var_f5d22b9a) && level.var_f5d22b9a) {
            return;
        }
        level.var_f5d22b9a = 1;
        level thread function_12bc9caf(localclientnum);
        level thread function_be3b9c8(localclientnum);
        return;
    }
    if (!(isdefined(level.var_f5d22b9a) && level.var_f5d22b9a)) {
        return;
    }
    level.var_f5d22b9a = undefined;
    array::delete_all(level.var_1fce2949);
    level.var_1fce2949 = undefined;
}

// Namespace namespace_f165e60d
// Params 1, eflags: 0x0
// Checksum 0xd4b76223, Offset: 0x1620
// Size: 0x150
function function_12bc9caf(localclientnum) {
    a_s_start = struct::get_array("street_ambient_wasp_start");
    if (!isdefined(a_s_start) || a_s_start.size == 0) {
        return;
    }
    while (isdefined(level.var_f5d22b9a) && level.var_f5d22b9a) {
        s_start = array::random(a_s_start);
        var_da8d98bc = function_bcde9a83(localclientnum, s_start);
        for (var_bda430d5 = randomintrange(1, 4); var_bda430d5 > 1; var_bda430d5--) {
            wait(0.6);
            var_da8d98bc = function_bcde9a83(localclientnum, s_start);
        }
        wait(randomfloatrange(1, 4));
    }
}

// Namespace namespace_f165e60d
// Params 2, eflags: 0x0
// Checksum 0x9d7cd5dd, Offset: 0x1778
// Size: 0x130
function function_bcde9a83(localclientnum, s_position) {
    level._effect["wasp_lights"] = "light/fx_light_veh_wasp";
    var_da8d98bc = util::spawn_model(localclientnum, "veh_t7_drone_attack_gun_zdf", s_position.origin, s_position.angles);
    var_da8d98bc.var_60c8714b = [];
    var_da8d98bc.var_fdcf75a9 = s_position;
    var_da8d98bc.n_speed = 750;
    var_75743dbd = playfxontag(localclientnum, level._effect["wasp_lights"], var_da8d98bc, "tag_origin");
    var_da8d98bc.var_60c8714b = array(var_75743dbd);
    var_da8d98bc thread function_ffeb5fe9(localclientnum);
    return var_da8d98bc;
}

// Namespace namespace_f165e60d
// Params 1, eflags: 0x0
// Checksum 0xcdf92e3d, Offset: 0x18b0
// Size: 0x24c
function function_ffeb5fe9(localclientnum) {
    if (!isdefined(self.n_speed)) {
        self.n_speed = 500;
    }
    s_start = self.var_fdcf75a9;
    for (s_next = struct::get(s_start.target, "targetname"); isdefined(s_next); s_next = struct::get(s_start.target, "targetname")) {
        n_distance = distance(s_start.origin, s_next.origin);
        n_time = n_distance / self.n_speed;
        self moveto(s_next.origin, n_time);
        self rotateto(s_next.angles, n_time);
        self waittill(#"movedone");
        s_start = s_next;
        s_next = undefined;
        if (isdefined(s_start.target)) {
        }
    }
    if (isdefined(self.var_60c8714b)) {
        self.var_60c8714b = array::remove_undefined(self.var_60c8714b);
        foreach (fx in self.var_60c8714b) {
            deletefx(localclientnum, fx, 0);
        }
        self.var_60c8714b = undefined;
    }
    self delete();
}

// Namespace namespace_f165e60d
// Params 7, eflags: 0x0
// Checksum 0x4aaf213c, Offset: 0x1b08
// Size: 0x22a
function function_87d2cd22(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (isdefined(level.var_3e64f16b) && level.var_3e64f16b) {
            return;
        }
        level.var_3e64f16b = 1;
        a_s_start = struct::get_array("plaza_battle_ambient_wasp_start");
        if (!isdefined(a_s_start) || a_s_start.size == 0) {
            return;
        }
        while (isdefined(level.var_3e64f16b) && level.var_3e64f16b) {
            a_s_start = array::randomize(a_s_start);
            foreach (s_start in a_s_start) {
                var_da8d98bc = function_bcde9a83(localclientnum, s_start);
                for (var_bda430d5 = randomintrange(1, 8); var_bda430d5 > 1; var_bda430d5--) {
                    wait(0.2);
                    var_da8d98bc = function_bcde9a83(localclientnum, s_start);
                }
                wait(randomfloatrange(15, 30));
            }
        }
        return;
    }
    level.var_3e64f16b = undefined;
}

// Namespace namespace_f165e60d
// Params 1, eflags: 0x0
// Checksum 0xbb9a3a78, Offset: 0x1d40
// Size: 0x11e
function function_be3b9c8(localclientnum) {
    s_start = struct::get("street_train_start");
    s_end = struct::get("street_train_end");
    level.var_1fce2949 = [];
    for (i = 0; i < 13; i++) {
        level.var_1fce2949[i] = util::spawn_model(localclientnum, "p7_zur_train_subway_01", s_start.origin, s_start.angles);
        level.var_1fce2949[i] thread function_94a8aac7(s_start, s_end, 3);
        wait(0.14);
    }
}

// Namespace namespace_f165e60d
// Params 3, eflags: 0x0
// Checksum 0xc15521f3, Offset: 0x1e68
// Size: 0x84
function function_94a8aac7(s_start, s_end, n_move_time) {
    while (isdefined(level.var_f5d22b9a) && level.var_f5d22b9a) {
        self moveto(s_end.origin, n_move_time);
        self waittill(#"movedone");
        self.origin = s_start.origin;
    }
}

// Namespace namespace_f165e60d
// Params 7, eflags: 0x0
// Checksum 0xe2e0e3cb, Offset: 0x1ef8
// Size: 0xf2
function function_cb32c615(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        var_201606f3 = findstaticmodelindexarray("forest_vista_lotus_tower");
        foreach (model in var_201606f3) {
            hidestaticmodel(model);
        }
    }
}

// Namespace namespace_f165e60d
// Params 7, eflags: 0x0
// Checksum 0x34c5d674, Offset: 0x1ff8
// Size: 0xf2
function function_9d9bb681(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        var_6d3190a3 = findstaticmodelindexarray("forest_vista_ferris_wheel");
        foreach (model in var_6d3190a3) {
            hidestaticmodel(model);
        }
    }
}

// Namespace namespace_f165e60d
// Params 7, eflags: 0x0
// Checksum 0xe8cd169f, Offset: 0x20f8
// Size: 0x1a2
function function_b230d19c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    /#
        assert(isdefined(level.var_10d89562), "cin_zur_06_sacrifice_3rd_sh090");
    #/
    if (newval == 1) {
        foreach (i, model in level.var_10d89562) {
            hidestaticmodel(model);
            if (i % 25 == 0) {
                wait(0.016);
            }
        }
        return;
    }
    foreach (model in level.var_10d89562) {
        unhidestaticmodel(model);
    }
}

// Namespace namespace_f165e60d
// Params 2, eflags: 0x0
// Checksum 0x489eeff0, Offset: 0x22a8
// Size: 0x22
function function_e3c5be62(str_objective, var_74cd64bc) {
    level notify(#"hash_6774bf18");
}

// Namespace namespace_f165e60d
// Params 7, eflags: 0x0
// Checksum 0x44a4652a, Offset: 0x22d8
// Size: 0x17e
function function_5cd74265(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (isdefined(level.var_f97ee69) && level.var_f97ee69) {
            return;
        }
        level.var_f97ee69 = 1;
        scene::add_scene_func("p7_fxanim_gp_trash_paper_blowing_01_bundle", &function_923c5fd7, "play");
        scene::add_scene_func("p7_fxanim_gp_trash_paper_burst_up_01_bundle", &function_923c5fd7, "play");
        scene::add_scene_func("p7_fxanim_gp_trash_paper_burst_out_01_bundle", &function_923c5fd7, "play");
        level thread scene::play("p7_fxanim_gp_trash_paper_blowing_01_bundle");
        level thread scene::play("p7_fxanim_gp_trash_paper_burst_up_01_bundle");
        level thread scene::play("p7_fxanim_gp_trash_paper_burst_out_01_bundle");
        return;
    }
    level.var_f97ee69 = undefined;
    level notify(#"hash_5266ce6e");
}

// Namespace namespace_f165e60d
// Params 1, eflags: 0x0
// Checksum 0x9b09785b, Offset: 0x2460
// Size: 0xea
function function_923c5fd7(a_ents) {
    level waittill(#"hash_5266ce6e");
    if (isdefined(a_ents) && isarray(a_ents)) {
        a_ents = array::remove_undefined(a_ents);
        if (a_ents.size) {
            foreach (e_ent in a_ents) {
                e_ent delete();
            }
        }
    }
}

// Namespace namespace_f165e60d
// Params 7, eflags: 0x0
// Checksum 0x7531fbbf, Offset: 0x2558
// Size: 0x196
function function_5080f69e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        level.var_aafa350b = [];
        playsound(0, "evt_decon_alarm", (-9457, 42594, 16));
        var_1e806caa = struct::get_array("s_hq_decon_spray", "targetname");
        for (i = 0; i < var_1e806caa.size; i++) {
            level.var_aafa350b[i] = playfx(localclientnum, "steam/fx_steam_decon_mist_spray_lg_sgen", var_1e806caa[i].origin, anglestoforward(var_1e806caa[i].angles), (0, 0, 1));
        }
        return;
    }
    for (i = 0; i < level.var_aafa350b.size; i++) {
        stopfx(localclientnum, level.var_aafa350b[i]);
    }
    level.var_aafa350b = undefined;
}

