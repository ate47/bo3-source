#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_lotus_fx;
#using scripts/cp/cp_mi_cairo_lotus_sound;
#using scripts/cp/lotus_util;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace cp_mi_cairo_lotus;

// Namespace cp_mi_cairo_lotus
// Params 0, eflags: 0x0
// Checksum 0xc16a0261, Offset: 0x930
// Size: 0xb2
function main() {
    util::function_57b966c8(&force_streamer, 3);
    init_clientfields();
    cp_mi_cairo_lotus_fx::main();
    cp_mi_cairo_lotus_sound::main();
    function_673254cc();
    lotus_util::function_84d3f32a();
    load::main();
    callback::on_spawned(&on_player_spawned);
    util::waitforclient(0);
}

// Namespace cp_mi_cairo_lotus
// Params 1, eflags: 0x0
// Checksum 0xa5d030ae, Offset: 0x9f0
// Size: 0x8a
function on_player_spawned(localclientnum) {
    player = getlocalplayer(localclientnum);
    var_8a357b77 = getentarray(localclientnum, "ventilation_fan", "targetname");
    array::thread_all(var_8a357b77, &lotus_util::function_a62110e9);
    player thread lotus_util::function_74fb8848(localclientnum);
    player thread function_f61f00f(localclientnum);
}

// Namespace cp_mi_cairo_lotus
// Params 1, eflags: 0x0
// Checksum 0x4dea98cd, Offset: 0xa88
// Size: 0x9a
function function_f61f00f(localclientnum) {
    self notify(#"hash_78bd6500");
    self endon(#"hash_78bd6500");
    e_trigger = getent(localclientnum, "mobile_shop_1_final_ascent", "targetname");
    if (sessionmodeiscampaignzombiesgame() && !isdefined(e_trigger)) {
        return;
    }
    e_trigger._localclientnum = localclientnum;
    e_trigger waittill(#"trigger", trigplayer);
    e_trigger thread trigger::function_thread(trigplayer, &function_df453073);
}

// Namespace cp_mi_cairo_lotus
// Params 0, eflags: 0x0
// Checksum 0xa4668a61, Offset: 0xb30
// Size: 0x3aa
function init_clientfields() {
    visionset_mgr::register_visionset_info("cp_raven_hallucination", 1, 1, "cp_raven_hallucination", "cp_raven_hallucination");
    clientfield::register("world", "hs_fxinit_vent", 1, 1, "int", &hs_fxinit_vent, 0, 0);
    clientfield::register("world", "hs_fxanim_vent", 1, 1, "int", &hs_fxanim_vent, 0, 0);
    clientfield::register("world", "swap_crowd_to_riot", 1, 1, "int", &swap_crowd_to_riot, 0, 0);
    clientfield::register("world", "crowd_anims_off", 1, 1, "int", &crowd_anims_off, 0, 0);
    clientfield::register("scriptmover", "mobile_shop_fxanims", 1, 3, "int", &lotus_util::mobile_shop_fxanims, 0, 0);
    clientfield::register("scriptmover", "raven_decal", 1, 1, "int", &lotus_util::function_ace9894c, 0, 0);
    clientfield::register("toplayer", "pickup_hakim_rumble_loop", 1, 1, "int", &function_448b79a2, 0, 0);
    clientfield::register("toplayer", "mobile_shop_rumble_loop", 1, 1, "int", &function_29c8893e, 0, 0);
    clientfield::register("toplayer", "player_dust_fx", 1, 1, "int", &lotus_util::function_b33fd8cd, 0, 0);
    clientfield::register("toplayer", "snow_fog", 1, 1, "int", &lotus_util::snow_fog, 0, 0);
    clientfield::register("toplayer", "frost_post_fx", 1, 1, "int", &lotus_util::frost_post_fx, 0, 0);
    clientfield::register("toplayer", "postfx_futz", 1, 1, "counter", &lotus_util::postfx_futz, 0, 0);
    clientfield::register("toplayer", "postfx_ravens", 1, 1, "counter", &lotus_util::postfx_ravens, 0, 0);
    clientfield::register("toplayer", "postfx_frozen_forest", 1, 1, "counter", &lotus_util::postfx_frozen_forest, 0, 0);
    clientfield::register("allplayers", "player_frost_breath", 1, 1, "int", &lotus_util::player_frost_breath, 0, 0);
    clientfield::register("actor", "hendricks_frost_breath", 1, 1, "int", &lotus_util::hendricks_frost_breath, 0, 0);
}

// Namespace cp_mi_cairo_lotus
// Params 7, eflags: 0x0
// Checksum 0xb885daa1, Offset: 0xee8
// Size: 0x7a
function function_448b79a2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self playrumblelooponentity(localclientnum, "cp_prologue_rumble_dropship");
        return;
    }
    self stoprumble(localclientnum, "cp_prologue_rumble_dropship");
}

// Namespace cp_mi_cairo_lotus
// Params 7, eflags: 0x0
// Checksum 0x354b2ae8, Offset: 0xf70
// Size: 0xaa
function function_29c8893e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self playrumbleonentity(localclientnum, "cp_lotus_rumble_mobile_shop_shift");
        self playrumblelooponentity(localclientnum, "cp_lotus_rumble_mobile_shop_ride");
        return;
    }
    self stoprumble(localclientnum, "cp_lotus_rumble_mobile_shop_ride");
    self playrumbleonentity(localclientnum, "cp_lotus_rumble_mobile_shop_shift");
}

// Namespace cp_mi_cairo_lotus
// Params 1, eflags: 0x0
// Checksum 0x8de5299, Offset: 0x1028
// Size: 0x1c9
function force_streamer(n_index) {
    switch (n_index) {
    case 1:
        forcestreambundle("cin_lot_01_planb_3rd_sh020");
        forcestreambundle("cin_lot_01_planb_3rd_sh030");
        forcestreambundle("cin_lot_01_planb_3rd_sh040");
        forcestreambundle("cin_lot_01_planb_3rd_sh050");
        forcestreambundle("cin_lot_01_planb_3rd_sh060");
        forcestreambundle("cin_lot_01_planb_3rd_sh070");
        forcestreambundle("cin_lot_01_planb_3rd_sh080");
        forcestreambundle("cin_lot_01_planb_3rd_sh090");
        forcestreambundle("cin_lot_01_planb_3rd_sh100");
        forcestreambundle("cin_lot_01_planb_3rd_sh120");
        forcestreambundle("cin_lot_01_planb_3rd_sh130");
        forcestreambundle("cin_lot_01_planb_3rd_sh140");
        forcestreambundle("cin_lot_01_planb_3rd_sh150");
        forcestreambundle("cin_lot_01_planb_3rd_sh160");
        break;
    case 2:
        break;
    case 3:
        forcestreambundle("p7_fxanim_cp_lotus_monitor_security_bundle");
        forcestreambundle("cin_lot_05_01_hack_system_1st_security_station");
        break;
    default:
        break;
    }
}

// Namespace cp_mi_cairo_lotus
// Params 0, eflags: 0x0
// Checksum 0x734404e5, Offset: 0x1200
// Size: 0x412
function function_673254cc() {
    skipto::add("plan_b", &function_6a18d1d4, "Plan B");
    skipto::add("start_the_riots", &start_the_riots, "Start the Riots");
    skipto::add("general_hakim", &general_hakim, "General Hakim");
    skipto::add("apartments", &function_6a18d1d4, "Apartments");
    skipto::add("atrium_battle", &atrium_battle, "Atrium Battle");
    skipto::add("to_security_station", &to_security_station, "To Security Station");
    skipto::add("hack_the_system", &function_6a18d1d4, "Hack the System");
    skipto::add("prometheus_otr", &function_6a18d1d4, "Prometheus OTR");
    skipto::add("vtol_hallway", &function_6a18d1d4, "VTOL Hallway");
    skipto::add("mobile_shop_ride2", &function_6a18d1d4, "Mobile Shop Ride 2");
    skipto::add("to_detention_center3", &function_6a18d1d4, "Get to the Detention Center");
    skipto::add("to_detention_center4", &function_6a18d1d4, "Get to the Detention Center");
    skipto::add("detention_center", &function_6a18d1d4, "Detention Center");
    skipto::add("stand_down", &function_6a18d1d4, "Stand Down");
    skipto::add("pursuit", &function_6a18d1d4, "Pursuit");
    skipto::add("sky_bridge", &function_6a18d1d4);
    skipto::add("tower_2_ascent", &function_6a18d1d4);
    skipto::add("minigun_platform", &function_6a18d1d4);
    skipto::add("platform_fall", &function_6a18d1d4);
    skipto::add("hunter", &function_6a18d1d4);
    skipto::add("prometheus_intro", &function_6a18d1d4);
    skipto::add("boss_battle", &function_6a18d1d4);
    skipto::add("old_friend", &function_6a18d1d4);
}

// Namespace cp_mi_cairo_lotus
// Params 2, eflags: 0x0
// Checksum 0x4b10963b, Offset: 0x1620
// Size: 0x12
function function_6a18d1d4(str_objective, var_74cd64bc) {
    
}

// Namespace cp_mi_cairo_lotus
// Params 2, eflags: 0x0
// Checksum 0x638321a7, Offset: 0x1640
// Size: 0x52
function start_the_riots(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
    }
    level thread scene::play("crowds_early", "script_noteworthy");
    level thread scene::play("crowds_hakim", "script_noteworthy");
}

// Namespace cp_mi_cairo_lotus
// Params 2, eflags: 0x0
// Checksum 0x878e477e, Offset: 0x16a0
// Size: 0x72
function general_hakim(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread scene::play("crowds_hakim", "script_noteworthy");
    }
    level thread scene::stop("crowds_early", "script_noteworthy");
    level thread scene::play("crowds_atrium", "script_noteworthy");
}

// Namespace cp_mi_cairo_lotus
// Params 7, eflags: 0x0
// Checksum 0x18eb9de9, Offset: 0x1720
// Size: 0x213
function swap_crowd_to_riot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level scene::stop("crowds_atrium", "script_noteworthy");
    level scene::stop("cin_lot_03_01_hakim_crowd_riot");
    var_70f028db = struct::get_array("crowds_hakim", "script_noteworthy");
    foreach (scriptbundle in var_70f028db) {
        if (scriptbundle.script_string !== "do_not_swap") {
            scriptbundle scene::stop();
            s_scene = struct::spawn(scriptbundle.origin, scriptbundle.angles);
            s_scene thread scene::play("cin_lot_03_01_hakim_crowd_riot");
        }
    }
    var_70f028db = struct::get_array("crowds_atrium", "script_noteworthy");
    foreach (scriptbundle in var_70f028db) {
        s_scene = struct::spawn(scriptbundle.origin, scriptbundle.angles);
        n_delay = randomfloat(10);
        s_scene thread util::delay(n_delay, undefined, &scene::play, "cin_lot_03_01_hakim_crowd_riot");
    }
}

// Namespace cp_mi_cairo_lotus
// Params 7, eflags: 0x0
// Checksum 0xad8bbc15, Offset: 0x1940
// Size: 0xd2
function crowd_anims_off(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level scene::stop("crowds_atrium", "script_noteworthy");
    level scene::stop("crowds_mobile_shop_1", "script_noteworthy");
    level scene::stop("crowds_hakim", "script_noteworthy");
    level scene::stop("crowds_to_security_station", "script_noteworthy");
    level scene::stop("cin_lot_03_01_hakim_crowd_riot");
}

// Namespace cp_mi_cairo_lotus
// Params 2, eflags: 0x0
// Checksum 0x73495951, Offset: 0x1a20
// Size: 0x72
function atrium_battle(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread scene::play("crowds_atrium", "script_noteworthy");
        level thread scene::play("crowds_hakim", "script_noteworthy");
    }
    level thread scene::play("crowds_mobile_shop_1", "script_noteworthy");
}

// Namespace cp_mi_cairo_lotus
// Params 1, eflags: 0x0
// Checksum 0xf81067e6, Offset: 0x1aa0
// Size: 0x6a
function function_df453073(trigplayer) {
    level thread scene::play("crowds_to_security_station", "script_noteworthy");
    level thread scene::stop("crowds_hakim", "script_noteworthy");
    level thread scene::stop("crowds_atrium", "script_noteworthy");
}

// Namespace cp_mi_cairo_lotus
// Params 2, eflags: 0x0
// Checksum 0x689aa4b2, Offset: 0x1b18
// Size: 0x72
function to_security_station(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread scene::play("crowds_to_security_station", "script_noteworthy");
        level thread scene::stop("crowds_hakim", "script_noteworthy");
        level thread scene::stop("crowds_atrium", "script_noteworthy");
    }
}

// Namespace cp_mi_cairo_lotus
// Params 7, eflags: 0x0
// Checksum 0x59f02cd0, Offset: 0x1b98
// Size: 0x52
function hs_fxinit_vent(var_6575414d, var_d5fa7963, var_3a04fa7e, var_3a8c4f80, var_406ad39b, str_field, var_f9aa8824) {
    level thread scene::init("p7_fxanim_cp_lotus_vents_bundle");
}

// Namespace cp_mi_cairo_lotus
// Params 7, eflags: 0x0
// Checksum 0xb3b6816d, Offset: 0x1bf8
// Size: 0x6a
function hs_fxanim_vent(var_6575414d, var_d5fa7963, var_3a04fa7e, var_3a8c4f80, var_406ad39b, str_field, var_f9aa8824) {
    if (var_3a04fa7e) {
        level thread scene::play("p7_fxanim_cp_lotus_vents_bundle");
        level thread scene::play("p7_fxanim_gp_trash_paper_burst_up_01_bundle");
    }
}

