#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_lotus2_fx;
#using scripts/cp/cp_mi_cairo_lotus2_patch_c;
#using scripts/cp/cp_mi_cairo_lotus2_sound;
#using scripts/cp/lotus_util;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace cp_mi_cairo_lotus2;

// Namespace cp_mi_cairo_lotus2
// Params 0, eflags: 0x0
// Checksum 0x3a2071c3, Offset: 0x910
// Size: 0x114
function main() {
    util::function_57b966c8(&force_streamer, 3);
    init_clientfields();
    setsaveddvar("enable_global_wind", 1);
    setsaveddvar("wind_global_vector", "0 -50 -30");
    cp_mi_cairo_lotus2_fx::main();
    cp_mi_cairo_lotus2_sound::main();
    function_673254cc();
    lotus_util::function_84d3f32a();
    load::main();
    callback::on_spawned(&on_player_spawned);
    util::waitforclient(0);
    cp_mi_cairo_lotus2_patch_c::function_7403e82b();
}

// Namespace cp_mi_cairo_lotus2
// Params 0, eflags: 0x0
// Checksum 0x94f6266d, Offset: 0xa30
// Size: 0x46c
function init_clientfields() {
    visionset_mgr::register_visionset_info("cp_raven_hallucination", 1, 1, "cp_raven_hallucination", "cp_raven_hallucination");
    clientfield::register("world", "vtol_hallway_destruction_cleanup", 1, 1, "int", &function_d2e9cebe, 0, 0);
    clientfield::register("vehicle", "mobile_shop_link_ents", 1, 1, "int", &mobile_shop_link_ents, 0, 0);
    clientfield::register("toplayer", "snow_fog", 1, 1, "int", &lotus_util::snow_fog, 0, 0);
    clientfield::register("toplayer", "frost_post_fx", 1, 1, "int", &lotus_util::frost_post_fx, 0, 0);
    clientfield::register("toplayer", "skybridge_sand_fx", 1, 1, "int", &function_25c42a9e, 0, 0);
    clientfield::register("toplayer", "player_dust_fx", 1, 1, "int", &lotus_util::function_b33fd8cd, 0, 0);
    clientfield::register("toplayer", "postfx_futz", 1, 1, "counter", &lotus_util::postfx_futz, 0, 0);
    clientfield::register("toplayer", "postfx_ravens", 1, 1, "counter", &lotus_util::postfx_ravens, 0, 0);
    clientfield::register("toplayer", "postfx_frozen_forest", 1, 1, "counter", &lotus_util::postfx_frozen_forest, 0, 0);
    clientfield::register("toplayer", "siegebot_fans", 1, 1, "int", &siegebot_fans, 0, 0);
    clientfield::register("toplayer", "hide_pursuit_decals", 1, 1, "counter", &hide_pursuit_decals, 0, 0);
    clientfield::register("allplayers", "player_frost_breath", 1, 1, "int", &lotus_util::player_frost_breath, 0, 0);
    clientfield::register("actor", "hendricks_frost_breath", 1, 1, "int", &lotus_util::hendricks_frost_breath, 0, 0);
    clientfield::register("scriptmover", "rogue_bot_fx", 1, 1, "int", &lotus_util::function_536a14db, 0, 0);
    clientfield::register("scriptmover", "mobile_shop_fxanims", 1, 3, "int", &lotus_util::mobile_shop_fxanims, 0, 0);
}

// Namespace cp_mi_cairo_lotus2
// Params 0, eflags: 0x0
// Checksum 0x2cad71c6, Offset: 0xea8
// Size: 0x2b4
function function_673254cc() {
    skipto::add("prometheus_otr", &function_6a18d1d4, "Prometheus OTR");
    skipto::add("vtol_hallway", &function_6a18d1d4, "VTOL Hallway");
    skipto::add("mobile_shop_ride2", &function_2980c418, "Mobile Shop Ride 2");
    skipto::add("bridge_battle", &function_441f2e2c, "Get to the Detention Center");
    skipto::add("up_to_detention_center", &function_441f2e2c, "Get to the Detention Center");
    skipto::add("detention_center", &function_c1e7454e, "Detention Center");
    skipto::add("stand_down", &function_6a18d1d4, "Stand Down");
    skipto::add("pursuit", &function_5342496, "Pursuit");
    skipto::add("industrial_zone", &industrial_zone, "Industrial Zone");
    skipto::add("sky_bridge1", &sky_bridge1, "Sky Bridge1");
    skipto::add("sky_bridge2", &sky_bridge2, "Sky Bridge2");
    skipto::add("tower_2_ascent", &function_6a18d1d4);
    skipto::add("prometheus_intro", &function_6a18d1d4);
    skipto::add("boss_battle", &function_6a18d1d4);
    skipto::add("old_friend", &function_6a18d1d4);
}

// Namespace cp_mi_cairo_lotus2
// Params 2, eflags: 0x0
// Checksum 0xf673dfdb, Offset: 0x1168
// Size: 0x14
function function_6a18d1d4(str_objective, var_74cd64bc) {
    
}

// Namespace cp_mi_cairo_lotus2
// Params 2, eflags: 0x0
// Checksum 0x137e325, Offset: 0x1188
// Size: 0x4c
function function_2980c418(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level scene::add_scene_func("p7_fxanim_cp_lotus_vtol_hallway_destruction_01_bundle", &function_d0cca429, "play");
    }
}

// Namespace cp_mi_cairo_lotus2
// Params 1, eflags: 0x0
// Checksum 0x68c005f7, Offset: 0x11e0
// Size: 0x64
function function_d0cca429(a_ents) {
    wait 0.5;
    a_ents["lotus_vtol_hallway_destruction02"] siegecmd("set_anim", "p7_fxanim_cp_lotus_vtol_hallway_destruction_02_sanim", "set_shot", "default", "pause", "goto_end");
}

// Namespace cp_mi_cairo_lotus2
// Params 2, eflags: 0x0
// Checksum 0x8fab8cf9, Offset: 0x1250
// Size: 0xb4
function function_441f2e2c(str_objective, var_74cd64bc) {
    if (var_74cd64bc || str_objective == "bridge_battle") {
        var_58e8d0ae = struct::get("siege_anim_bridge_crowd_1");
        var_32e65645 = struct::get("siege_anim_bridge_crowd_2");
        var_58e8d0ae thread scene::play("cin_lot_03_01_hakim_crowd_new");
        var_32e65645 thread scene::play("cin_lot_03_01_hakim_crowd_new");
    }
}

// Namespace cp_mi_cairo_lotus2
// Params 2, eflags: 0x0
// Checksum 0xf06c0c8f, Offset: 0x1310
// Size: 0xa4
function function_c1e7454e(str_objective, var_74cd64bc) {
    if (!var_74cd64bc) {
        var_58e8d0ae = struct::get("siege_anim_bridge_crowd_1");
        var_32e65645 = struct::get("siege_anim_bridge_crowd_2");
        var_58e8d0ae thread scene::stop("cin_lot_03_01_hakim_crowd_new");
        var_32e65645 thread scene::stop("cin_lot_03_01_hakim_crowd_new");
    }
}

// Namespace cp_mi_cairo_lotus2
// Params 2, eflags: 0x0
// Checksum 0xae303e70, Offset: 0x13c0
// Size: 0x9c
function function_5342496(str_objective, var_74cd64bc) {
    var_58e8d0ae = struct::get("siege_anim_pursuit_crowd_1");
    var_32e65645 = struct::get("siege_anim_pursuit_crowd_2");
    var_58e8d0ae thread scene::play("cin_lot_03_01_hakim_crowd_new");
    var_32e65645 thread scene::play("cin_lot_03_01_hakim_crowd_new");
}

// Namespace cp_mi_cairo_lotus2
// Params 2, eflags: 0x0
// Checksum 0xd7bf4cb, Offset: 0x1468
// Size: 0xcc
function industrial_zone(str_objective, var_74cd64bc) {
    if (!var_74cd64bc) {
        var_58e8d0ae = struct::get("siege_anim_pursuit_crowd_1");
        var_32e65645 = struct::get("siege_anim_pursuit_crowd_2");
        var_58e8d0ae thread scene::stop("cin_lot_03_01_hakim_crowd_new");
        var_32e65645 thread scene::stop("cin_lot_03_01_hakim_crowd_new");
    }
    level thread scene::init("p7_fxanim_cp_lotus_dogfight_lrg_bundle", "scriptbundlename");
}

// Namespace cp_mi_cairo_lotus2
// Params 2, eflags: 0x0
// Checksum 0x8ef8f4ff, Offset: 0x1540
// Size: 0x44
function sky_bridge1(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread scene::init("p7_fxanim_cp_lotus_dogfight_lrg_bundle", "scriptbundlename");
    }
}

// Namespace cp_mi_cairo_lotus2
// Params 2, eflags: 0x0
// Checksum 0xb77f6d9f, Offset: 0x1590
// Size: 0x74
function sky_bridge2(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread scene::init("p7_fxanim_cp_lotus_dogfight_lrg_bundle", "scriptbundlename");
        level scene::add_scene_func("p7_fxanim_cp_lotus_skybridge_vtol_crash_bundle", &function_614af0bc, "play");
    }
}

// Namespace cp_mi_cairo_lotus2
// Params 1, eflags: 0x0
// Checksum 0x1776e34e, Offset: 0x1610
// Size: 0x64
function function_614af0bc(a_ents) {
    wait 0.5;
    a_ents["fxanim_skybridge_vtol_debris"] siegecmd("set_anim", "p7_fxanim_cp_lotus_skybridge_vtol_debris_sanim", "set_shot", "default", "pause", "goto_end");
}

// Namespace cp_mi_cairo_lotus2
// Params 1, eflags: 0x0
// Checksum 0x4adaadc5, Offset: 0x1680
// Size: 0xac
function on_player_spawned(localclientnum) {
    level thread function_7c5fff02(localclientnum);
    self thread function_70f4b03d(localclientnum);
    self thread lotus_util::function_74fb8848(localclientnum);
    var_8a357b77 = getentarray(localclientnum, "ventilation_fan", "targetname");
    array::thread_all(var_8a357b77, &lotus_util::function_a62110e9);
}

// Namespace cp_mi_cairo_lotus2
// Params 7, eflags: 0x0
// Checksum 0x40aaca7d, Offset: 0x1738
// Size: 0x9c
function function_d2e9cebe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        var_cf815e6b = getent(localclientnum, "lotus_vtol_hallway_destruction02", "targetname");
        if (isdefined(var_cf815e6b)) {
            var_cf815e6b delete();
        }
    }
}

// Namespace cp_mi_cairo_lotus2
// Params 7, eflags: 0x0
// Checksum 0xe75bf33f, Offset: 0x17e0
// Size: 0x142
function siegebot_fans(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_d596fadb = getentarray(localclientnum, "siegebot_fan", "targetname");
    foreach (var_5606c964 in var_d596fadb) {
        if (newval) {
            var_5606c964 sethighdetail(1);
            var_5606c964 thread lotus_util::function_a62110e9();
            continue;
        }
        var_5606c964 notify(#"hash_b1727ec2");
        var_5606c964 delete();
    }
}

// Namespace cp_mi_cairo_lotus2
// Params 1, eflags: 0x0
// Checksum 0x7f0bfee7, Offset: 0x1930
// Size: 0xd8
function function_7c5fff02(localclientnum) {
    for (i = -121; i <= -91; i += 5) {
        var_d72a94c2 = "mobile_shop_2_floor_" + i;
        e_trigger = getent(localclientnum, var_d72a94c2, "targetname");
        if (!isdefined(e_trigger)) {
            continue;
        }
        e_trigger._localclientnum = localclientnum;
        e_trigger waittill(#"trigger", trigplayer);
        level thread function_babb7bd8(e_trigger);
    }
}

// Namespace cp_mi_cairo_lotus2
// Params 1, eflags: 0x0
// Checksum 0x41d431c4, Offset: 0x1a10
// Size: 0x64
function function_babb7bd8(e_trigger) {
    level thread scene::play(e_trigger.targetname, "targetname");
    wait 5;
    level thread scene::stop(e_trigger.targetname, "targetname");
}

// Namespace cp_mi_cairo_lotus2
// Params 7, eflags: 0x0
// Checksum 0x62e48e52, Offset: 0x1a80
// Size: 0x118
function mobile_shop_link_ents(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self.var_64ad3bc2 !== 1) {
        var_a7327e9a = getentarray(localclientnum, self.script_string, "targetname");
        foreach (var_7c71a3fa in var_a7327e9a) {
            var_7c71a3fa linkto(self);
        }
        self.var_64ad3bc2 = 1;
    }
}

// Namespace cp_mi_cairo_lotus2
// Params 7, eflags: 0x0
// Checksum 0x28ae849b, Offset: 0x1ba0
// Size: 0xa4
function function_25c42a9e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread function_c70785ee(localclientnum);
        return;
    }
    self notify(#"hash_614dea17");
    if (isdefined(self.n_fx_id)) {
        deletefx(localclientnum, self.n_fx_id, 1);
    }
}

// Namespace cp_mi_cairo_lotus2
// Params 1, eflags: 0x0
// Checksum 0x4fa155ed, Offset: 0x1c50
// Size: 0x80
function function_c70785ee(localclientnum) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    self endon(#"hash_614dea17");
    while (true) {
        self.n_fx_id = playfxoncamera(localclientnum, level._effect["player_sand_skybridge"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        wait 0.1;
    }
}

// Namespace cp_mi_cairo_lotus2
// Params 1, eflags: 0x0
// Checksum 0x658e005c, Offset: 0x1cd8
// Size: 0x128
function function_70f4b03d(localclientnum) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    var_59579cf9 = getent(localclientnum, "turn_off_sand_fx", "targetname");
    var_c866fc0d = getent(localclientnum, "turn_on_sand_fx", "targetname");
    while (true) {
        if (!isdefined(var_59579cf9) || !isdefined(var_c866fc0d)) {
            break;
        }
        if (isdefined(var_59579cf9)) {
            var_59579cf9 waittill(#"trigger");
        }
        self function_25c42a9e(localclientnum, 1, 0, 0, 0, undefined, 0);
        if (isdefined(var_c866fc0d)) {
            var_c866fc0d waittill(#"trigger");
        }
        self function_25c42a9e(localclientnum, 0, 1, 0, 0, undefined, 0);
    }
}

// Namespace cp_mi_cairo_lotus2
// Params 7, eflags: 0x0
// Checksum 0xbce4a775, Offset: 0x1e08
// Size: 0xf2
function hide_pursuit_decals(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        var_1f716b64 = findvolumedecalindexarray("pursuit_snow_decals");
        foreach (n_index in var_1f716b64) {
            hidevolumedecal(n_index);
        }
    }
}

// Namespace cp_mi_cairo_lotus2
// Params 1, eflags: 0x0
// Checksum 0x799f1aff, Offset: 0x1f08
// Size: 0x142
function force_streamer(n_index) {
    switch (n_index) {
    case 1:
        forcestreamxmodel("c_hro_hendricks_egypt_fb");
        forcestreambundle("cin_lot_05_01_hack_system_1st_breach_player");
        forcestreambundle("p7_fxanim_cp_lotus_monitor_security_bundle");
        streamtexturelist("cp_mi_cairo_lotus2");
        break;
    case 2:
        forcestreamxmodel("c_hro_taylor_base_fb");
        forcestreamxmodel("c_hro_hendricks_egypt_fb");
        forcestreamxmodel("p7_cai_lotus_security_double_door_rt");
        forcestreamxmodel("p7_cai_lotus_security_double_door_lt");
        forcestreamxmodel("c_nrc_robot_grunt");
        break;
    case 3:
        forcestreambundle("cin_lot_10_01_skybridge_1st_push");
        break;
    default:
        break;
    }
}

