#using scripts/zm/zm_cosmodrome_fx;
#using scripts/zm/zm_cosmodrome_ffotd;
#using scripts/zm/zm_cosmodrome_amb;
#using scripts/zm/_zm_trap_fire;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_ai_monkey;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_weap_thundergun;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weap_black_hole_bomb;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_670cb61;

// Namespace namespace_670cb61
// Params 0, eflags: 0x2
// Checksum 0xbc6fd27b, Offset: 0x1e08
// Size: 0x1c
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0x1d5a3d1a, Offset: 0x1e30
// Size: 0x28c
function main() {
    namespace_79efb23f::main_start();
    level.default_game_mode = "zclassic";
    level.default_start_location = "default";
    level._power_on = 0;
    level.var_c00f5950 = 0;
    level.var_f2fba834 = 0;
    level.var_90e9447c = 0;
    level.intro_done = 0;
    include_weapons();
    callback::on_localclient_connect(&function_82a94b2c);
    function_b8cff764();
    namespace_eb3fb2b6::main();
    level thread namespace_9dd378ec::main();
    level.setupcustomcharacterexerts = &setup_personality_character_exerts;
    visionset_mgr::register_visionset_info("zm_cosmodrome_no_power", 21000, 31, undefined, "zombie_cosmodrome_nopower");
    visionset_mgr::register_visionset_info("zm_cosmodrome_power_antic", 21000, 31, undefined, "zombie_cosmodrome_power_antic");
    visionset_mgr::register_visionset_info("zm_cosmodrome_power_flare", 21000, 31, undefined, "zombie_cosmodrome_power_flare");
    visionset_mgr::register_visionset_info("zm_cosmodrome_monkey_on", 21000, 31, undefined, "zombie_cosmodrome_monkey");
    visionset_mgr::register_visionset_info("zm_cosmodrome_monkey_off", 21000, 31, undefined, "zombie_cosmodrome_monkey");
    load::main();
    level thread function_f2fe3cf5();
    level function_548074ba();
    util::waitforclient(0);
    level thread function_c4880303();
    level.var_150bea26 = struct::get("nml_spark_pull", "targetname");
    function_6ac83719();
    level thread function_d87a7dcc();
    namespace_79efb23f::main_end();
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0x1bf86409, Offset: 0x20c8
// Size: 0x44
function function_82a94b2c(localclientnum) {
    setsaveddvar("phys_buoyancy", 1);
    level thread function_85c8e13c(localclientnum);
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0x5dacb551, Offset: 0x2118
// Size: 0xa32
function function_85c8e13c(localclientnum) {
    self endon(#"disconnect");
    while (true) {
        var_f4570d42 = randomint(5);
        switch (var_f4570d42) {
        case 0:
            exploder::exploder("fxexp_4100", localclientnum);
            setukkoscriptindex(localclientnum, 2, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 3, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 4, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 5, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 4, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 3, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 4, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 3, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 4, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 6, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 4, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 5, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 6, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 7, 1);
            wait(0.05);
            break;
        case 1:
            exploder::exploder("fxexp_4200", localclientnum);
            setukkoscriptindex(localclientnum, 8, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 9, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 10, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 11, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 10, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 11, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 12, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 13, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 14, 1);
            wait(0.1);
            break;
        case 2:
            exploder::exploder("fxexp_4300", localclientnum);
            setukkoscriptindex(localclientnum, 15, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 16, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 17, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 18, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 19, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 20, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 21, 1);
            wait(0.1);
            break;
        case 3:
            exploder::exploder("fxexp_4400", localclientnum);
            setukkoscriptindex(localclientnum, 22, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 23, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 24, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 25, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 26, 1);
            wait(0.1);
            break;
        case 4:
            exploder::exploder("fxexp_4500", localclientnum);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.15);
            setukkoscriptindex(localclientnum, 30, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 31, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 30, 1);
            wait(0.15);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 30, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 31, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 27, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 28, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 30, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 31, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 30, 1);
            wait(0.15);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 30, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 29, 1);
            wait(0.1);
            setukkoscriptindex(localclientnum, 31, 1);
            wait(0.05);
            setukkoscriptindex(localclientnum, 32, 1);
            wait(0.05);
            break;
        default:
            break;
        }
        setukkoscriptindex(localclientnum, 1, 1);
        n_wait_time = randomintrange(2, 4);
        wait(n_wait_time);
    }
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0x3ad0c86, Offset: 0x2b58
// Size: 0x5c
function function_6ac83719() {
    visionset_mgr::function_980ca37e("zombie_cosmodrome", 0.01);
    visionset_mgr::function_a95252c1("");
    visionset_mgr::function_3aea3c1a(0, "zombie_cosmodrome");
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0x713cfb03, Offset: 0x2bc0
// Size: 0xd0
function function_c07d3f2c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        player = getlocalplayers()[localclientnum];
        player function_5e3814b2("normal");
        visionset_mgr::function_a95252c1("_nopower");
        visionset_mgr::function_3aea3c1a(0, "zombie_cosmodrome", 8.5);
        level.intro_done = 1;
    }
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0xc240c67a, Offset: 0x2c98
// Size: 0xec
function function_d0429093(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        if (isdefined(level.intro_done) && !level.intro_done) {
            level.intro_done = 1;
            player = getlocalplayers()[localclientnum];
            player function_5e3814b2("normal");
            wait(0.01);
            visionset_mgr::function_a95252c1("_nopower");
            visionset_mgr::function_3aea3c1a(0, "zombie_cosmodrome", 0.01);
        }
    }
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0xc71c2ead, Offset: 0x2d90
// Size: 0x16c
function function_e470dce(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        level.var_f2fba834 = 1;
        if (isdefined(level._power_on) && !level._power_on) {
            level._power_on = 1;
            level thread function_a79732cb(localclientnum);
        }
        player = getlocalplayers()[localclientnum];
        player earthquake(0.2, 5, player.origin, 20000);
        playsound(0, "zmb_ape_intro_sonicboom_fnt", (0, 0, 0));
        level._effect["eye_glow"] = level._effect["monkey_eye_glow"];
        e_player = getlocalplayers()[localclientnum];
        e_player function_5e3814b2("monkey");
    }
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0xae75706d, Offset: 0x2f08
// Size: 0x136
function function_87f08b47(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        level.var_f2fba834 = 0;
        if (isdefined(level._power_on) && !level._power_on) {
            level._power_on = 1;
            level thread function_a79732cb(localclientnum);
        }
        player = getlocalplayers()[localclientnum];
        player function_5e3814b2("normal");
        wait(0.01);
        visionset_mgr::function_a95252c1("_poweron");
        visionset_mgr::function_3aea3c1a(0, "zombie_cosmodrome", 0.01);
        level._effect["eye_glow"] = level._effect["zombie_eye_glow"];
    }
}

// Namespace namespace_670cb61
// Params 5, eflags: 0x1 linked
// Checksum 0x88099171, Offset: 0x3048
// Size: 0xa4
function function_2f143630(var_54168c72, var_f8308617, n_wait, var_2e141209, var_862916dc) {
    visionset_mgr::function_a95252c1(var_54168c72);
    visionset_mgr::function_3aea3c1a(0, "zombie_cosmodrome", var_f8308617);
    wait(n_wait);
    visionset_mgr::function_a95252c1(var_2e141209);
    visionset_mgr::function_3aea3c1a(0, "zombie_cosmodrome", var_862916dc);
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0x79fa4513, Offset: 0x30f8
// Size: 0x88
function function_ea758913() {
    if (isdefined(level.var_f2fba834) && level.var_f2fba834 && isdefined(level.var_90e9447c) && !level.var_90e9447c) {
        level.var_90e9447c = 1;
        self function_2f143630("_monkey_flare", 0.5, 0.5, "_monkey", 3);
        level.var_90e9447c = 0;
    }
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0x85555357, Offset: 0x3188
// Size: 0x754
function function_b8cff764() {
    clientfield::register("scriptmover", "zombie_has_eyes", 21000, 1, "int", &zm::zombie_eyes_clientfield_cb, 0, 0);
    clientfield::register("actor", "COSMO_SOULPULL", 21000, 1, "int", &function_7c919649, 0, 0);
    clientfield::register("scriptmover", "COSMO_ROCKET_FX", 21000, 1, "int", &function_81e5578a, 0, 0);
    clientfield::register("scriptmover", "COSMO_MONKEY_LANDER_FX", 21000, 1, "int", &function_5fcc9c4c, 0, 0);
    clientfield::register("world", "COSMO_EGG_SAM_ANGRY", 21000, 1, "int", &function_28a46c0d, 0, 0);
    clientfield::register("scriptmover", "COSMO_LANDER_ENGINE_FX", 21000, 1, "int", &function_5dd9df7d, 0, 0);
    clientfield::register("allplayers", "COSMO_PLAYER_LANDER_FOG", 21000, 1, "int", &function_8062d0ce, 0, 0);
    clientfield::register("scriptmover", "COSMO_LANDER_MOVE_FX", 21000, 1, "int", &function_576cc7e6, 0, 0);
    clientfield::register("scriptmover", "COSMO_LANDER_RUMBLE_AND_QUAKE", 21000, 1, "int", &function_85394ca5, 0, 0);
    clientfield::register("world", "COSMO_LANDER_STATUS_LIGHTS", 21000, 2, "int", &function_32db5393, 0, 0);
    clientfield::register("world", "COSMO_LANDER_STATION", 21000, 3, "int", &function_446c53e5, 0, 0);
    clientfield::register("world", "COSMO_LANDER_DEST", 21000, 3, "int", &function_f6ffc831, 0, 0);
    clientfield::register("world", "COSMO_LANDER_CATWALK_BAY", 21000, 3, "int", &function_89e03497, 0, 0);
    clientfield::register("world", "COSMO_LANDER_BASE_ENTRY_BAY", 21000, 3, "int", &function_429d7872, 0, 0);
    clientfield::register("world", "COSMO_LANDER_CENTRIFUGE_BAY", 21000, 3, "int", &function_7eaa1812, 0, 0);
    clientfield::register("world", "COSMO_LANDER_STORAGE_BAY", 21000, 3, "int", &function_686d40af, 0, 0);
    clientfield::register("scriptmover", "COSMO_LAUNCH_PANEL_CENTRIFUGE_STATUS", 21000, 1, "int", &function_aefe04dd, 0, 0);
    clientfield::register("scriptmover", "COSMO_LAUNCH_PANEL_BASEENTRY_STATUS", 21000, 1, "int", &function_dad35a90, 0, 0);
    clientfield::register("scriptmover", "COSMO_LAUNCH_PANEL_STORAGE_STATUS", 21000, 1, "int", &function_418c677a, 0, 0);
    clientfield::register("scriptmover", "COSMO_LAUNCH_PANEL_CATWALK_STATUS", 21000, 1, "int", &function_9685a78a, 0, 0);
    clientfield::register("scriptmover", "COSMO_CENTRIFUGE_RUMBLE", 21000, 1, "int", &function_b73a8cd7, 0, 0);
    clientfield::register("scriptmover", "COSMO_CENTRIFUGE_LIGHTS", 21000, 1, "int", &function_222e9433, 0, 0);
    clientfield::register("world", "COSMO_VISIONSET_BEGIN", 21000, 1, "int", &function_c07d3f2c, 0, 0);
    clientfield::register("world", "COSMO_VISIONSET_NOPOWER", 21000, 1, "int", &function_d0429093, 0, 0);
    clientfield::register("world", "COSMO_VISIONSET_POWERON", 21000, 1, "int", &function_87f08b47, 0, 0);
    clientfield::register("world", "COSMO_VISIONSET_MONKEY", 21000, 1, "int", &function_e470dce, 0, 0);
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0xc4372349, Offset: 0x38e8
// Size: 0x16a
function function_d87a7dcc() {
    for (var_bd7ba30 = 0; true; var_bd7ba30 = 1) {
        if (!level clientfield::get("zombie_power_on")) {
            if (var_bd7ba30) {
                level notify(#"hash_dc853f6c");
            }
            level util::waittill_any("power_on", "pwr", "ZPO");
        }
        level._power_on = 1;
        level notify(#"hash_dc853f6c");
        players = getlocalplayers();
        for (i = 0; i < players.size; i++) {
            level thread function_a79732cb(i);
        }
        level function_2f143630("_powerup", 0.1, 1, "_poweron", 2.5);
        level util::waittill_any("pwo", "ZPOff");
    }
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0x6bd479ab, Offset: 0x3a60
// Size: 0x24
function include_weapons() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_cosmodrome_weapons.csv", 1);
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0x43888848, Offset: 0x3a90
// Size: 0x86
function function_c4880303() {
    var_63463246 = getentarray(0, "zombie_cosmodrome_radar_dish", "targetname");
    if (isdefined(var_63463246)) {
        for (i = 0; i < var_63463246.size; i++) {
            var_63463246[i] thread function_6f89184c();
        }
    }
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0xff82d4b5, Offset: 0x3b20
// Size: 0x44
function function_6f89184c() {
    wait(0.1);
    while (true) {
        self rotateyaw(360, 10);
        self waittill(#"rotatedone");
    }
}

// Namespace namespace_670cb61
// Params 2, eflags: 0x0
// Checksum 0x1b4bd602, Offset: 0x3b70
// Size: 0x20e
function function_f5f47a62(client_num, var_947e05f) {
    println("zombie_cosmodrome_monkey" + client_num);
    targ = struct::get(self.target, "targetname");
    if (!isdefined(targ)) {
        return;
    }
    mover = spawn(client_num, targ.origin, "script_model");
    mover setmodel("tag_origin");
    fx = playfxontag(client_num, level._effect["wire_spark"], mover, "tag_origin");
    while (isdefined(targ)) {
        if (isdefined(targ.target)) {
            println("zombie_cosmodrome_monkey" + client_num + "zombie_cosmodrome_monkey" + targ.target);
            target = struct::get(targ.target, "targetname");
            mover moveto(target.origin, 0.5);
            wait(0.5);
            targ = target;
            continue;
        }
        break;
    }
    level notify(#"hash_f78a45bf");
    mover delete();
    level notify(var_947e05f);
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x0
// Checksum 0x2ad100bd, Offset: 0x3d88
// Size: 0x2c
function function_c26d28ae(fake_ent) {
    level endon(#"hash_f78a45bf");
    while (true) {
        wait(0.05);
    }
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0xe15cc649, Offset: 0x3dc0
// Size: 0x5c
function function_7c919649(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self thread function_b5e96222(localclientnum);
    }
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0xf1ec976f, Offset: 0x3e28
// Size: 0x134
function function_b5e96222(client_num) {
    println("zombie_cosmodrome_monkey" + self.origin + "zombie_cosmodrome_monkey" + level.var_150bea26.origin);
    mover = spawn(client_num, self.origin, "script_model");
    mover setmodel("tag_origin");
    fx = playfxontag(client_num, level._effect["soul_spark"], mover, "tag_origin");
    wait(1);
    mover moveto(level.var_150bea26.origin, 3);
    wait(3);
    mover delete();
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0xbb09fe26, Offset: 0x3f68
// Size: 0x1fc
function function_548074ba() {
    level.var_8f49e1f3 = array("p7_zm_asc_cam_monitor_screen_fsale1", "p7_zm_asc_cam_monitor_screen_fsale2");
    level.var_ddaf0687 = array("p7_zm_asc_cam_monitor_screen_off");
    level.var_6e0c0273 = array("p7_zm_asc_cam_monitor_screen_on");
    level.var_7a6412d0 = array("p7_zm_asc_cam_monitor_screen_obsdeck");
    level.var_abac8222 = array("p7_zm_asc_cam_monitor_screen_labs");
    level.var_7b911622 = array("p7_zm_asc_cam_monitor_screen_centrifuge");
    level.var_189489fa = array("p7_zm_asc_cam_monitor_screen_enter");
    level.var_205f3bb = array("p7_zm_asc_cam_monitor_screen_storage");
    level.var_47a76e8e = array("p7_zm_asc_cam_monitor_screen_catwalk");
    level.var_2f68eb7f = array("p7_zm_asc_cam_monitor_screen_topack");
    level.var_ff7aa211 = array("p7_zm_asc_cam_monitor_screen_warehouse");
    level.var_8565fcfd = array("p7_zm_asc_cam_monitor_screen_logo");
    level.var_bea700d2 = array(level.var_7a6412d0, level.var_abac8222, level.var_7b911622, level.var_189489fa, level.var_205f3bb, level.var_47a76e8e, level.var_2f68eb7f, level.var_ff7aa211);
    level._custom_box_monitor = &function_c1096c8f;
}

// Namespace namespace_670cb61
// Params 3, eflags: 0x1 linked
// Checksum 0x42d04c78, Offset: 0x4170
// Size: 0x186
function function_c1096c8f(client_num, state, oldstate) {
    function_85e41f6f(client_num);
    if (state == "n") {
        if (level._power_on == 0) {
            screen_to_display = level.var_ddaf0687;
        } else {
            screen_to_display = level.var_6e0c0273;
        }
    } else if (state == "f") {
        screen_to_display = level.var_8f49e1f3;
    } else {
        array_number = int(state);
        screen_to_display = level.var_bea700d2[array_number];
    }
    stop_notify = "stop_tv_swap";
    for (i = 0; i < level.var_fb0ed8ad[client_num].size; i++) {
        tele = level.var_fb0ed8ad[client_num][i];
        tele notify(stop_notify);
        wait(0.2);
        tele thread function_a5e9d88f(screen_to_display, "stop_tv_swap");
        tele thread function_49995a21(state);
    }
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0xbd2c2496, Offset: 0x4300
// Size: 0xe6
function function_85e41f6f(client_num) {
    if (!isdefined(level.var_fb0ed8ad)) {
        level.var_fb0ed8ad = [];
    }
    if (isdefined(level.var_fb0ed8ad[client_num])) {
        return;
    }
    level.var_fb0ed8ad[client_num] = getentarray(client_num, "model_cosmodrome_box_screens", "targetname");
    for (i = 0; i < level.var_fb0ed8ad[client_num].size; i++) {
        tele = level.var_fb0ed8ad[client_num][i];
        tele setmodel(level.var_ddaf0687[0]);
        wait(0.1);
    }
}

// Namespace namespace_670cb61
// Params 2, eflags: 0x1 linked
// Checksum 0xc3b74bfb, Offset: 0x43f0
// Size: 0xf0
function function_a5e9d88f(var_1ca815f6, endon_notify) {
    self endon(endon_notify);
    while (true) {
        for (i = 0; i < var_1ca815f6.size; i++) {
            self setmodel(var_1ca815f6[i]);
            wait(3);
        }
        if (3 > randomint(100) && isdefined(level.var_8565fcfd)) {
            self setmodel(level.var_8565fcfd[randomint(level.var_8565fcfd.size)]);
            wait(2);
        }
        wait(1);
    }
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0xdd23b5a4, Offset: 0x44e8
// Size: 0xb4
function function_49995a21(state) {
    self.alias = "amb_tv_static";
    if (state == "n") {
        if (level._power_on == 0) {
            self.alias = undefined;
        } else {
            self.alias = "amb_tv_static";
        }
    } else if (state == "f") {
    } else {
        self.alias = "amb_tv_static";
    }
    if (!isdefined(self.alias)) {
        return;
    }
    self playloopsound(self.alias, 0.5);
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0xa80dded4, Offset: 0x45a8
// Size: 0x64
function function_89e03497(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level function_18769931(localclientnum, newval, "catwalk_zip_door");
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0xf82369d3, Offset: 0x4618
// Size: 0x64
function function_429d7872(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level function_18769931(localclientnum, newval, "base_entry_zip_door");
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0x75a39d3e, Offset: 0x4688
// Size: 0x64
function function_7eaa1812(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level function_18769931(localclientnum, newval, "centrifuge_zip_door");
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0x9e4f3075, Offset: 0x46f8
// Size: 0x64
function function_686d40af(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level function_18769931(localclientnum, newval, "storage_zip_door");
}

// Namespace namespace_670cb61
// Params 3, eflags: 0x1 linked
// Checksum 0x929f070a, Offset: 0x4768
// Size: 0x18c
function function_18769931(localclientnum, n_state, door_name) {
    sound_count = 0;
    doors = getentarray(localclientnum, door_name, "targetname");
    for (i = 0; i < doors.size; i++) {
        var_1f9cab23 = doors[i] function_b2c64ce4(n_state);
        var_fd0b5358 = doors[i] function_b27e98c0(var_1f9cab23);
        b_move = doors[i] function_53c16d30(var_fd0b5358);
        if (b_move) {
            doors[i] moveto(var_fd0b5358, 1);
            if (sound_count == 0) {
                playsound(0, "zmb_lander_door", doors[i].origin);
                sound_count++;
            }
        }
    }
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0xd7589c4c, Offset: 0x4900
// Size: 0x7e
function function_b2c64ce4(n_state) {
    switch (n_state) {
    case 1:
        return 1;
    case 2:
        if (!isdefined(self.script_noteworthy)) {
            return 0;
        } else {
            return 1;
        }
    case 3:
        return 0;
    case 0:
        if (!isdefined(self.script_noteworthy)) {
            return 1;
        } else {
            return 0;
        }
        break;
    }
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0x9c4d7931, Offset: 0x4988
// Size: 0xd0
function function_b27e98c0(var_2291984a) {
    open_pos = struct::get(self.target, "targetname");
    start_pos = struct::get(open_pos.target, "targetname");
    if (!isdefined(self.script_noteworthy)) {
        if (var_2291984a) {
            return start_pos.origin;
        } else {
            return open_pos.origin;
        }
        return;
    }
    if (var_2291984a) {
        return open_pos.origin;
    }
    return start_pos.origin;
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0xbecaf23c, Offset: 0x4a60
// Size: 0x2a
function function_53c16d30(v_pos) {
    if (self.origin != v_pos) {
        return 1;
    }
    return 0;
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0x476904e8, Offset: 0x4a98
// Size: 0xac
function function_81e5578a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self.var_a13e8509 = playfxontag(localclientnum, level._effect["rocket_blast_trail"], self, "tag_engine");
        return;
    }
    if (isdefined(self.var_a13e8509)) {
        killfx(localclientnum, self.var_a13e8509);
    }
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0xbe5a646, Offset: 0x4b50
// Size: 0x3cc
function function_5dd9df7d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    player = getlocalplayers()[localclientnum];
    if (newval) {
        if (isdefined(player.var_554e8590)) {
            stopfx(localclientnum, player.var_554e8590);
            stopfx(localclientnum, player.var_e027c869);
            stopfx(localclientnum, player.var_62a42d2);
            stopfx(localclientnum, player.var_2c2cbd3b);
            stopfx(localclientnum, player.var_522f37a4);
        }
        player.var_554e8590 = playfxontag(localclientnum, level._effect["lunar_lander_thruster_leg"], self, "tag_engine01");
        setfxignorepause(localclientnum, player.var_554e8590, 1);
        player.var_e027c869 = playfxontag(localclientnum, level._effect["lunar_lander_thruster_leg"], self, "tag_engine02");
        setfxignorepause(localclientnum, player.var_e027c869, 1);
        player.var_62a42d2 = playfxontag(localclientnum, level._effect["lunar_lander_thruster_leg"], self, "tag_engine03");
        setfxignorepause(localclientnum, player.var_62a42d2, 1);
        player.var_2c2cbd3b = playfxontag(localclientnum, level._effect["lunar_lander_thruster_leg"], self, "tag_engine04");
        setfxignorepause(localclientnum, player.var_2c2cbd3b, 1);
        player.var_522f37a4 = playfxontag(localclientnum, level._effect["lunar_lander_thruster_bellow"], self, "tag_bellow");
        setfxignorepause(localclientnum, player.var_522f37a4, 1);
        self thread function_c4fa6b12();
        return;
    }
    if (isdefined(player.var_554e8590)) {
        stopfx(localclientnum, player.var_554e8590);
        stopfx(localclientnum, player.var_e027c869);
        stopfx(localclientnum, player.var_62a42d2);
        stopfx(localclientnum, player.var_2c2cbd3b);
        stopfx(localclientnum, player.var_522f37a4);
    }
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0xa3cff149, Offset: 0x4f28
// Size: 0x248
function function_c4fa6b12() {
    self endon(#"entityshutdown");
    level endon(#"save_restore");
    self notify(#"hash_c4fa6b12");
    self.var_e73939a8 = 0;
    trace = undefined;
    self.var_9050f13a = spawn(0, (0, 0, 0), "script_origin");
    self.var_9050f13a thread function_fb377b79();
    pre_origin = (100000, 100000, 100000);
    while (isdefined(self)) {
        wait(0.15);
        if (isdefined(self.var_e73939a8) && self.var_e73939a8) {
            if (isdefined(self.var_9050f13a)) {
                self.var_9050f13a stoploopsound(2);
            }
            return;
        }
        if (distancesquared(pre_origin, self gettagorigin("tag_bellow")) < -112) {
            continue;
        }
        pre_origin = self gettagorigin("tag_bellow");
        trace = bullettrace(self gettagorigin("tag_bellow"), self gettagorigin("tag_bellow") - (0, 0, 100000), 0, undefined);
        if (!isdefined(trace)) {
            continue;
        }
        if (!isdefined(trace["position"])) {
            self.var_9050f13a stoploopsound(2);
            continue;
        }
        self.var_9050f13a.origin = trace["position"] + (0, 0, 30);
        self.var_9050f13a playloopsound("zmb_lander_ground_sounds", 3);
    }
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0x91f5669c, Offset: 0x5178
// Size: 0x34
function function_fb377b79() {
    self endon(#"entityshutdown");
    level waittill(#"demo_jump");
    self delete();
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0x87ef6250, Offset: 0x51b8
// Size: 0x54
function function_46e0eded() {
    self endon(#"hash_c4fa6b12");
    self.var_e73939a8 = 1;
    wait(3);
    if (isdefined(self) && isdefined(self.var_9050f13a)) {
        self.var_9050f13a delete();
    }
}

// Namespace namespace_670cb61
// Params 4, eflags: 0x0
// Checksum 0xc2265fa3, Offset: 0x5218
// Size: 0x1cc
function function_e1966260(var_ac1da75d, var_29326553, var_d1bb8a11, var_3cb8ff6f) {
    fwd = anglestoforward(self.angles);
    scale = randomintrange(var_ac1da75d, var_29326553);
    fwd = (fwd[0] * scale, fwd[1] * scale, fwd[2] * scale);
    if (randomint(100) > 50) {
        side = anglestoright(self.angles);
    } else {
        side = anglestoright(self.angles) * -1;
    }
    scale = randomintrange(var_d1bb8a11, var_3cb8ff6f);
    side = (side[0] * scale, side[1] * scale, side[2] * scale);
    point = self.origin + fwd + side;
    trace = bullettrace(point, point + (0, 0, -10000), 0, undefined);
    return trace["position"];
}

// Namespace namespace_670cb61
// Params 3, eflags: 0x0
// Checksum 0xc6274aa4, Offset: 0x53f0
// Size: 0x184
function function_dd99a44e(spot, client, player) {
    playfxontag(client, level._effect["debris_trail"], self, "tag_origin");
    self moveto(spot, 3.1);
    for (i = 0; i < 10; i++) {
        self rotateto((randomint(360), randomint(360), randomint(360)), 0.3);
        wait(0.3);
    }
    wait(3.1);
    player earthquake(0.4, 0.5, self.origin, 1200);
    playfx(client, level._effect["debris_hit"], self.origin);
    wait(1);
    self delete();
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0x5eee3233, Offset: 0x5580
// Size: 0xa6
function function_a79732cb(clientnum) {
    screens = getentarray(clientnum, "lander_screens", "targetname");
    for (i = 0; i < screens.size; i++) {
        if (isdefined(screens[i].model)) {
            screens[i] setmodel("p7_zm_asc_control_panel_lunar");
        }
    }
}

// Namespace namespace_670cb61
// Params 2, eflags: 0x1 linked
// Checksum 0xfa38bb0e, Offset: 0x5630
// Size: 0x366
function function_c4585a90(station, clientnum) {
    self util::waittill_dobj(clientnum);
    if (isdefined(self.var_50435f12)) {
        stopfx(clientnum, self.var_50435f12);
    }
    if (isdefined(self.var_554e8590)) {
        stopfx(clientnum, self.var_554e8590);
    }
    switch (station) {
    case 3:
        self.var_50435f12 = playfxontag(clientnum, level._effect["panel_green"], self, "tag_location_3");
        self.var_e2e3906f = self gettagorigin("tag_location_3");
        self.var_7e8defe6 = self gettagangles("tag_location_3");
        setfxignorepause(clientnum, self.var_50435f12, 1);
        break;
    case 1:
        self.var_50435f12 = playfxontag(clientnum, level._effect["panel_green"], self, "tag_location_1");
        self.var_e2e3906f = self gettagorigin("tag_location_1");
        self.var_7e8defe6 = self gettagangles("tag_location_1");
        setfxignorepause(clientnum, self.var_50435f12, 1);
        break;
    case 2:
        self.var_50435f12 = playfxontag(clientnum, level._effect["panel_green"], self, "tag_location_2");
        self.var_e2e3906f = self gettagorigin("tag_location_2");
        self.var_7e8defe6 = self gettagangles("tag_location_2");
        setfxignorepause(clientnum, self.var_50435f12, 1);
        break;
    case 4:
        self.var_50435f12 = playfxontag(clientnum, level._effect["panel_green"], self, "tag_home");
        self.var_e2e3906f = self gettagorigin("tag_home");
        self.var_7e8defe6 = self gettagangles("tag_home");
        setfxignorepause(clientnum, self.var_50435f12, 1);
        break;
    }
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0x36a6b08f, Offset: 0x59a0
// Size: 0x84
function function_576cc7e6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        player = getlocalplayers()[localclientnum];
        player thread function_ddf62718(localclientnum);
    }
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0x7938d34e, Offset: 0x5a30
// Size: 0x306
function function_ddf62718(localclientnum) {
    dest = undefined;
    x = localclientnum;
    screens = getentarray(x, "lander_screens", "targetname");
    for (i = 0; i < screens.size; i++) {
        screen = screens[i];
        if (isdefined(screen.var_554e8590)) {
            stopfx(x, screen.var_554e8590);
        }
        if (isdefined(screen.var_50435f12)) {
            stopfx(x, screen.var_50435f12);
        }
        if (!isdefined(screen.var_5b309e56)) {
            screen.var_5b309e56 = spawn(x, screen.var_e2e3906f, "script_origin");
            screen.var_5b309e56 setmodel("tag_origin");
            screen.var_5b309e56.angles = screen.var_7e8defe6;
        }
        screen.var_554e8590 = playfxontag(x, level._effect["panel_green"], screen.var_5b309e56, "tag_origin");
        setfxignorepause(x, screen.var_554e8590, 1);
        switch (level.var_5fbb9ff3) {
        case 119:
            dest = screen gettagorigin("tag_location_3");
            break;
        case 122:
            dest = screen gettagorigin("tag_location_1");
            break;
        case 121:
            dest = screen gettagorigin("tag_home");
            break;
        case 120:
            dest = screen gettagorigin("tag_location_2");
            break;
        }
        screen.var_5b309e56 moveto(dest, 10);
    }
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0xd10401bb, Offset: 0x5d40
// Size: 0xbe
function function_446c53e5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    screens = getentarray(localclientnum, "lander_screens", "targetname");
    for (i = 0; i < screens.size; i++) {
        screens[i] thread function_c4585a90(newval, localclientnum);
    }
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0xbb11744c, Offset: 0x5e08
// Size: 0x9c
function function_32db5393(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        level namespace_eb3fb2b6::function_3b3f16da("red", localclientnum);
        return;
    }
    if (newval == 2) {
        level namespace_eb3fb2b6::function_3b3f16da("green", localclientnum);
    }
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0xa7c6a36f, Offset: 0x5eb0
// Size: 0xbe
function function_f6ffc831(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    switch (newval) {
    case 2:
        level.var_5fbb9ff3 = "catwalk";
        break;
    case 3:
        level.var_5fbb9ff3 = "base";
        break;
    case 4:
        level.var_5fbb9ff3 = "centrifuge";
        break;
    case 1:
        level.var_5fbb9ff3 = "storage";
        break;
    }
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0x259f582c, Offset: 0x5f78
// Size: 0x14c
function function_aefe04dd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        if (isdefined(self.var_c7265f3c)) {
            stopfx(localclientnum, self.var_c7265f3c);
        }
        self.var_c7265f3c = playfxontag(localclientnum, level._effect["panel_red"], self, "tag_home");
        setfxignorepause(localclientnum, self.var_c7265f3c, 1);
        return;
    }
    if (isdefined(self.var_c7265f3c)) {
        stopfx(localclientnum, self.var_c7265f3c);
    }
    self.var_c7265f3c = playfxontag(localclientnum, level._effect["panel_green"], self, "tag_home");
    setfxignorepause(localclientnum, self.var_c7265f3c, 1);
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0xd9a399a, Offset: 0x60d0
// Size: 0x74
function function_418c677a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        if (localclientnum == 0) {
            level.var_c00f5950++;
        }
        level thread function_46fad70e(localclientnum);
    }
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0x760147dc, Offset: 0x6150
// Size: 0x74
function function_dad35a90(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        if (localclientnum == 0) {
            level.var_c00f5950++;
        }
        level thread function_46fad70e(localclientnum);
    }
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0xd33b1d3b, Offset: 0x61d0
// Size: 0x74
function function_9685a78a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        if (localclientnum == 0) {
            level.var_c00f5950++;
        }
        level thread function_46fad70e(localclientnum);
    }
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0xecff03a, Offset: 0x6250
// Size: 0xec
function function_46fad70e(localclientnum) {
    wait(1);
    var_eceee9f = getentarray(localclientnum, "rocket_launch_sign", "targetname");
    model = var_eceee9f[0].model;
    switch (level.var_c00f5950) {
    case 1:
        model = "p7_zm_asc_sign_rocket_02";
        break;
    case 2:
        model = "p7_zm_asc_sign_rocket_03";
        break;
    case 3:
        model = "p7_zm_asc_sign_rocket_04";
        break;
    }
    array::thread_all(var_eceee9f, &function_3e4964b6, model);
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0x1409f8e6, Offset: 0x6348
// Size: 0x9c
function function_3e4964b6(on_model) {
    old_model = self.model;
    for (i = 0; i < 3; i++) {
        self setmodel(on_model);
        wait(0.35);
        self setmodel(old_model);
        wait(0.35);
    }
    self setmodel(on_model);
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0xa55e390, Offset: 0x63f0
// Size: 0x232
function function_85394ca5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    player = getlocalplayers()[localclientnum];
    player endon(#"death");
    player endon(#"disconnect");
    if (isspectating(localclientnum, 0)) {
        return;
    }
    if (newval) {
        player earthquake(randomfloatrange(0.2, 0.3), randomfloatrange(2, 2.5), player.origin, -106);
        player playrumbleonentity(localclientnum, "artillery_rumble");
        self thread function_d7a2e87(localclientnum);
        return;
    }
    self thread function_46e0eded();
    player earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.5, 0.6), self.origin, -106);
    wait(0.6);
    if (isdefined(player) && isdefined(self)) {
        player earthquake(randomfloatrange(0.1, 0.2), randomfloatrange(0.2, 0.3), self.origin, -106);
    }
    level notify(#"hash_baf19166");
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0x7bd758c6, Offset: 0x6630
// Size: 0x218
function function_d7a2e87(localclientnum) {
    level endon(#"hash_baf19166");
    player = getlocalplayers()[localclientnum];
    player endon(#"entityshutdown");
    player endon(#"disconnect");
    while (true) {
        if (!isdefined(self.origin) || !isdefined(player.origin)) {
            wait(0.05);
            continue;
        }
        if (distancesquared(player.origin, self.origin) > 2250000) {
            wait(0.1);
            continue;
        }
        dist = distancesquared(player.origin, self.origin);
        if (dist > 562500) {
            player earthquake(randomfloatrange(0.1, 0.15), randomfloatrange(0.15, 0.16), self.origin, 1000);
            rumble = "slide_rumble";
        } else {
            player earthquake(randomfloatrange(0.15, 0.2), randomfloatrange(0.15, 0.16), self.origin, 750);
            rumble = "damage_light";
        }
        player playrumbleonentity(localclientnum, rumble);
        wait(0.1);
    }
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0xc654bee3, Offset: 0x6850
// Size: 0xce
function function_b73a8cd7(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (local_client_num != 0) {
        return;
    }
    if (newval) {
        players = getlocalplayers();
        for (i = 0; i < players.size; i++) {
            players[i] thread function_702c8dd1(self, i);
        }
        return;
    }
    level notify(#"hash_418af938");
}

// Namespace namespace_670cb61
// Params 2, eflags: 0x1 linked
// Checksum 0x38b7ca80, Offset: 0x6928
// Size: 0x130
function function_702c8dd1(var_c0ba7915, var_7343ea0b) {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"hash_418af938");
    var_3cd638f8 = 360000;
    var_732dbe95 = "damage_heavy";
    client_num = undefined;
    while (isdefined(self)) {
        var_5c429dad = distancesquared(self.origin, var_c0ba7915.origin);
        if (var_5c429dad < var_3cd638f8 && isdefined(self)) {
            if (isdefined(var_7343ea0b)) {
                self playrumbleonentity(var_7343ea0b, var_732dbe95);
            }
        }
        if (var_5c429dad > var_3cd638f8) {
            if (isdefined(var_7343ea0b) && isdefined(self)) {
                self stoprumble(var_7343ea0b, var_732dbe95);
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x0
// Checksum 0x45b603f, Offset: 0x6a60
// Size: 0x44
function function_a8ecabd7(var_7343ea0b) {
    self endon(#"death");
    self endon(#"disconnect");
    self stoprumble(var_7343ea0b, "damage_heavy");
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0x989af7c1, Offset: 0x6ab0
// Size: 0x14e
function function_222e9433(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    while (!self hasdobj(local_client_num)) {
        wait(0.1);
    }
    if (local_client_num != 0) {
        return;
    }
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        self function_b09899ec(i);
    }
    if (newval) {
        players = getlocalplayers();
        for (i = 0; i < players.size; i++) {
            self function_5aeadc28(i);
            self function_4b04a296(i);
        }
    }
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0x620c3b69, Offset: 0x6c08
// Size: 0x1c6
function function_657048a4() {
    self endon(#"hash_61aa1dcb");
    playsound(0, "zmb_ape_intro_whoosh", self.origin);
    wait(2.5);
    if (isdefined(self)) {
        self.fx = [];
        players = getlocalplayers();
        ent_num = self getentitynumber();
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (!isdefined(player.var_f559ae39)) {
                player.var_f559ae39 = [];
            }
            if (isdefined(player.var_f559ae39[ent_num])) {
                deletefx(i, player.var_f559ae39[ent_num]);
                player.var_f559ae39[ent_num] = undefined;
            }
            player.var_f559ae39[ent_num] = playfxontag(i, level._effect["monkey_trail"], self, "tag_origin");
            setfxignorepause(i, player.var_f559ae39[ent_num], 1);
        }
    }
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0xcbfa65bb, Offset: 0x6dd8
// Size: 0x13c
function function_be051852() {
    players = getlocalplayers();
    ent_num = self getentitynumber();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        playfx(i, level._effect["monkey_spawn"], self.origin);
        playrumbleonposition(i, "explosion_generic", self.origin);
        player earthquake(0.5, 0.5, player.origin, 1000);
    }
    playsound(0, "zmb_ape_intro_land", self.origin);
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0x88624c57, Offset: 0x6f20
// Size: 0xc4
function function_5fcc9c4c(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (local_client_num != 0) {
        return;
    }
    while (!self hasdobj(local_client_num)) {
        wait(0.1);
    }
    if (newval) {
        self thread function_657048a4();
        level thread function_ea758913();
        return;
    }
    self thread function_be051852();
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0x16ae9243, Offset: 0x6ff0
// Size: 0x5c
function function_28a46c0d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        namespace_9dd378ec::function_84e46cfe(localclientnum);
    }
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0xeab403ba, Offset: 0x7058
// Size: 0x220
function function_5aeadc28(var_7343ea0b) {
    self.var_4c8fb5ad[var_7343ea0b] = [];
    self.var_4c8fb5ad[var_7343ea0b] = array::add(self.var_4c8fb5ad[var_7343ea0b], "tag_light_bk_top", 0);
    self.var_4c8fb5ad[var_7343ea0b] = array::add(self.var_4c8fb5ad[var_7343ea0b], "tag_light_fnt_top", 0);
    self.var_4c8fb5ad[var_7343ea0b] = array::add(self.var_4c8fb5ad[var_7343ea0b], "tag_light_fnt_bttm", 0);
    self.var_4c8fb5ad[var_7343ea0b] = array::add(self.var_4c8fb5ad[var_7343ea0b], "tag_light_bk_bttm", 0);
    self.var_919d0d6e[var_7343ea0b] = [];
    self.var_919d0d6e[var_7343ea0b] = array::add(self.var_919d0d6e[var_7343ea0b], "tag_light_bk_bttm", 0);
    self.var_919d0d6e[var_7343ea0b] = array::add(self.var_919d0d6e[var_7343ea0b], "tag_light_fnt_bttm", 0);
    self.var_8b0dc099[var_7343ea0b] = [];
    self.var_8b0dc099[var_7343ea0b] = array::add(self.var_8b0dc099[var_7343ea0b], "tag_vent_bk_btm", 0);
    self.var_8b0dc099[var_7343ea0b] = array::add(self.var_8b0dc099[var_7343ea0b], "tag_vent_top_btm", 0);
    self.var_38890519[var_7343ea0b] = [];
    self.var_26291911 = 1;
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0xae25f620, Offset: 0x7280
// Size: 0x34c
function function_4b04a296(client_num) {
    for (i = 0; i < self.var_4c8fb5ad[client_num].size; i++) {
        var_cfe666ff = spawn(client_num, self gettagorigin(self.var_4c8fb5ad[client_num][i]), "script_model");
        var_cfe666ff.angles = self gettagangles(self.var_4c8fb5ad[client_num][i]);
        if (issubstr(self.var_4c8fb5ad[client_num][i], "_bttm")) {
            var_cfe666ff.angles += (180, 0, 0);
        }
        var_cfe666ff setmodel("tag_origin");
        var_cfe666ff linkto(self, self.var_4c8fb5ad[client_num][i]);
        playfxontag(client_num, level._effect["centrifuge_warning_light"], var_cfe666ff, "tag_origin");
        self.var_38890519[client_num] = array::add(self.var_38890519[client_num], var_cfe666ff, 0);
    }
    for (i = 0; i < self.var_919d0d6e[client_num].size; i++) {
        var_cfe666ff = spawn(client_num, self gettagorigin(self.var_919d0d6e[client_num][i]), "script_model");
        var_cfe666ff.angles = self gettagangles(self.var_919d0d6e[client_num][i]);
        var_cfe666ff setmodel("tag_origin");
        var_cfe666ff linkto(self, self.var_919d0d6e[client_num][i]);
        playfxontag(client_num, level._effect["centrifuge_light_spark"], var_cfe666ff, "tag_origin");
        self.var_38890519[client_num] = array::add(self.var_38890519[client_num], var_cfe666ff, 0);
    }
    self thread function_7164c703(client_num);
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0xfc9c33cb, Offset: 0x75d8
// Size: 0x8e
function function_7164c703(client_num) {
    self endon(#"entityshutdown");
    wait(1);
    for (i = 0; i < self.var_8b0dc099[client_num].size; i++) {
        playfxontag(client_num, level._effect["centrifuge_start_steam"], self, self.var_8b0dc099[client_num][i]);
    }
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0x60f8a9e3, Offset: 0x7670
// Size: 0xc6
function function_b09899ec(client_num) {
    if (!isdefined(self.var_26291911)) {
        return;
    }
    wait(0.2);
    for (i = 0; i < self.var_38890519[client_num].size; i++) {
        if (isdefined(self.var_38890519[client_num][i])) {
            self.var_38890519[client_num][i] unlink();
        }
    }
    array::delete_all(self.var_38890519[client_num]);
    self.var_38890519[client_num] = [];
}

// Namespace namespace_670cb61
// Params 2, eflags: 0x1 linked
// Checksum 0x2884c846, Offset: 0x7740
// Size: 0x1dc
function function_9cf661e6(var_17287487, int_priority) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(self.var_b23121ea)) {
        self.var_b23121ea = [];
    }
    if (!isdefined(var_17287487) || !isdefined(int_priority)) {
        return;
    }
    already_in_array = 0;
    if (self.var_b23121ea.size != 0) {
        for (i = 0; i < self.var_b23121ea.size; i++) {
            if (isdefined(self.var_b23121ea[i].var_ebea88f2) && self.var_b23121ea[i].var_ebea88f2 == var_17287487) {
                already_in_array = 1;
                if (self.var_b23121ea[i].priority != int_priority) {
                    self.var_b23121ea[i].priority = int_priority;
                }
                break;
            }
        }
    }
    if (!already_in_array) {
        temp_struct = spawnstruct();
        temp_struct.var_ebea88f2 = var_17287487;
        temp_struct.priority = int_priority;
        self.var_b23121ea = array::add(self.var_b23121ea, temp_struct, 0);
    }
    var_be17b820 = function_b5416805();
    function_5e3814b2(var_be17b820);
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0x730742d1, Offset: 0x7928
// Size: 0x174
function function_3164820a(var_17287487) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!isdefined(var_17287487)) {
        return;
    }
    if (!isdefined(self.var_b23121ea)) {
        self.var_b23121ea = [];
    }
    temp_struct = undefined;
    for (i = 0; i < self.var_b23121ea.size; i++) {
        if (isdefined(self.var_b23121ea[i].var_ebea88f2) && self.var_b23121ea[i].var_ebea88f2 == var_17287487) {
            temp_struct = self.var_b23121ea[i];
        }
    }
    if (isdefined(temp_struct)) {
        for (i = 0; i < self.var_b23121ea.size; i++) {
            if (self.var_b23121ea[i] == temp_struct) {
                self.var_b23121ea[i] = undefined;
            }
        }
        array::remove_undefined(self.var_b23121ea);
    }
    var_be17b820 = function_b5416805();
    function_5e3814b2(var_be17b820);
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0x555917e8, Offset: 0x7aa8
// Size: 0xda
function function_b5416805() {
    if (!isdefined(self.var_b23121ea)) {
        return;
    }
    highest_score = 0;
    var_47fd6f89 = undefined;
    for (i = 0; i < self.var_b23121ea.size; i++) {
        if (isdefined(self.var_b23121ea[i].priority) && self.var_b23121ea[i].priority > highest_score) {
            highest_score = self.var_b23121ea[i].priority;
            var_47fd6f89 = self.var_b23121ea[i].var_ebea88f2;
        }
    }
    return var_47fd6f89;
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0xa0a37002, Offset: 0x7b90
// Size: 0x96
function function_f2fe3cf5() {
    util::waitforclient(0);
    wait(1);
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        players[i] function_9cf661e6("normal", level.var_8fdfd0d9);
    }
}

// Namespace namespace_670cb61
// Params 1, eflags: 0x1 linked
// Checksum 0x8bfd1cf6, Offset: 0x7c30
// Size: 0xba
function function_5e3814b2(var_506c623e) {
    util::waitforclient(0);
    if (!isdefined(var_506c623e)) {
        return;
    }
    switch (var_506c623e) {
    case 21:
        setworldfogactivebank(self getlocalclientnumber(), 1);
        break;
    case 26:
        setworldfogactivebank(self getlocalclientnumber(), 2);
        break;
    case 149:
        break;
    }
}

// Namespace namespace_670cb61
// Params 7, eflags: 0x1 linked
// Checksum 0x312bacc1, Offset: 0x7cf8
// Size: 0xac
function function_8062d0ce(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    player = getlocalplayers()[local_client_num];
    if (newval) {
        player thread function_9cf661e6("lander", level.var_5c490de4);
        return;
    }
    player thread function_3164820a("lander");
}

// Namespace namespace_670cb61
// Params 0, eflags: 0x1 linked
// Checksum 0xd318a0ff, Offset: 0x7db0
// Size: 0x1482
function setup_personality_character_exerts() {
    level.exert_sounds[1]["playerbreathinsound"][0] = "vox_plr_0_exert_inhale_0";
    level.exert_sounds[1]["playerbreathinsound"][1] = "vox_plr_0_exert_inhale_1";
    level.exert_sounds[1]["playerbreathinsound"][2] = "vox_plr_0_exert_inhale_2";
    level.exert_sounds[2]["playerbreathinsound"][0] = "vox_plr_1_exert_inhale_0";
    level.exert_sounds[2]["playerbreathinsound"][1] = "vox_plr_1_exert_inhale_1";
    level.exert_sounds[2]["playerbreathinsound"][2] = "vox_plr_1_exert_inhale_2";
    level.exert_sounds[3]["playerbreathinsound"][0] = "vox_plr_2_exert_inhale_0";
    level.exert_sounds[3]["playerbreathinsound"][1] = "vox_plr_2_exert_inhale_1";
    level.exert_sounds[3]["playerbreathinsound"][2] = "vox_plr_2_exert_inhale_2";
    level.exert_sounds[4]["playerbreathinsound"][0] = "vox_plr_3_exert_inhale_0";
    level.exert_sounds[4]["playerbreathinsound"][1] = "vox_plr_3_exert_inhale_1";
    level.exert_sounds[4]["playerbreathinsound"][2] = "vox_plr_3_exert_inhale_2";
    level.exert_sounds[1]["playerbreathoutsound"][0] = "vox_plr_0_exert_exhale_0";
    level.exert_sounds[1]["playerbreathoutsound"][1] = "vox_plr_0_exert_exhale_1";
    level.exert_sounds[1]["playerbreathoutsound"][2] = "vox_plr_0_exert_exhale_2";
    level.exert_sounds[2]["playerbreathoutsound"][0] = "vox_plr_1_exert_exhale_0";
    level.exert_sounds[2]["playerbreathoutsound"][1] = "vox_plr_1_exert_exhale_1";
    level.exert_sounds[2]["playerbreathoutsound"][2] = "vox_plr_1_exert_exhale_2";
    level.exert_sounds[3]["playerbreathoutsound"][0] = "vox_plr_2_exert_exhale_0";
    level.exert_sounds[3]["playerbreathoutsound"][1] = "vox_plr_2_exert_exhale_1";
    level.exert_sounds[3]["playerbreathoutsound"][2] = "vox_plr_2_exert_exhale_2";
    level.exert_sounds[4]["playerbreathoutsound"][0] = "vox_plr_3_exert_exhale_0";
    level.exert_sounds[4]["playerbreathoutsound"][1] = "vox_plr_3_exert_exhale_1";
    level.exert_sounds[4]["playerbreathoutsound"][2] = "vox_plr_3_exert_exhale_2";
    level.exert_sounds[1]["playerbreathgaspsound"][0] = "vox_plr_0_exert_exhale_0";
    level.exert_sounds[1]["playerbreathgaspsound"][1] = "vox_plr_0_exert_exhale_1";
    level.exert_sounds[1]["playerbreathgaspsound"][2] = "vox_plr_0_exert_exhale_2";
    level.exert_sounds[2]["playerbreathgaspsound"][0] = "vox_plr_1_exert_exhale_0";
    level.exert_sounds[2]["playerbreathgaspsound"][1] = "vox_plr_1_exert_exhale_1";
    level.exert_sounds[2]["playerbreathgaspsound"][2] = "vox_plr_1_exert_exhale_2";
    level.exert_sounds[3]["playerbreathgaspsound"][0] = "vox_plr_2_exert_exhale_0";
    level.exert_sounds[3]["playerbreathgaspsound"][1] = "vox_plr_2_exert_exhale_1";
    level.exert_sounds[3]["playerbreathgaspsound"][2] = "vox_plr_2_exert_exhale_2";
    level.exert_sounds[4]["playerbreathgaspsound"][0] = "vox_plr_3_exert_exhale_0";
    level.exert_sounds[4]["playerbreathgaspsound"][1] = "vox_plr_3_exert_exhale_1";
    level.exert_sounds[4]["playerbreathgaspsound"][2] = "vox_plr_3_exert_exhale_2";
    level.exert_sounds[1]["falldamage"][0] = "vox_plr_0_exert_pain_low_0";
    level.exert_sounds[1]["falldamage"][1] = "vox_plr_0_exert_pain_low_1";
    level.exert_sounds[1]["falldamage"][2] = "vox_plr_0_exert_pain_low_2";
    level.exert_sounds[1]["falldamage"][3] = "vox_plr_0_exert_pain_low_3";
    level.exert_sounds[1]["falldamage"][4] = "vox_plr_0_exert_pain_low_4";
    level.exert_sounds[1]["falldamage"][5] = "vox_plr_0_exert_pain_low_5";
    level.exert_sounds[1]["falldamage"][6] = "vox_plr_0_exert_pain_low_6";
    level.exert_sounds[1]["falldamage"][7] = "vox_plr_0_exert_pain_low_7";
    level.exert_sounds[2]["falldamage"][0] = "vox_plr_1_exert_pain_low_0";
    level.exert_sounds[2]["falldamage"][1] = "vox_plr_1_exert_pain_low_1";
    level.exert_sounds[2]["falldamage"][2] = "vox_plr_1_exert_pain_low_2";
    level.exert_sounds[2]["falldamage"][3] = "vox_plr_1_exert_pain_low_3";
    level.exert_sounds[2]["falldamage"][4] = "vox_plr_1_exert_pain_low_4";
    level.exert_sounds[2]["falldamage"][5] = "vox_plr_1_exert_pain_low_5";
    level.exert_sounds[2]["falldamage"][6] = "vox_plr_1_exert_pain_low_6";
    level.exert_sounds[2]["falldamage"][7] = "vox_plr_1_exert_pain_low_7";
    level.exert_sounds[3]["falldamage"][0] = "vox_plr_2_exert_pain_low_0";
    level.exert_sounds[3]["falldamage"][1] = "vox_plr_2_exert_pain_low_1";
    level.exert_sounds[3]["falldamage"][2] = "vox_plr_2_exert_pain_low_2";
    level.exert_sounds[3]["falldamage"][3] = "vox_plr_2_exert_pain_low_3";
    level.exert_sounds[3]["falldamage"][4] = "vox_plr_2_exert_pain_low_4";
    level.exert_sounds[3]["falldamage"][5] = "vox_plr_2_exert_pain_low_5";
    level.exert_sounds[3]["falldamage"][6] = "vox_plr_2_exert_pain_low_6";
    level.exert_sounds[3]["falldamage"][7] = "vox_plr_2_exert_pain_low_7";
    level.exert_sounds[4]["falldamage"][0] = "vox_plr_3_exert_pain_low_0";
    level.exert_sounds[4]["falldamage"][1] = "vox_plr_3_exert_pain_low_1";
    level.exert_sounds[4]["falldamage"][2] = "vox_plr_3_exert_pain_low_2";
    level.exert_sounds[4]["falldamage"][3] = "vox_plr_3_exert_pain_low_3";
    level.exert_sounds[4]["falldamage"][4] = "vox_plr_3_exert_pain_low_4";
    level.exert_sounds[4]["falldamage"][5] = "vox_plr_3_exert_pain_low_5";
    level.exert_sounds[4]["falldamage"][6] = "vox_plr_3_exert_pain_low_6";
    level.exert_sounds[4]["falldamage"][7] = "vox_plr_3_exert_pain_low_7";
    level.exert_sounds[1]["mantlesoundplayer"][0] = "vox_plr_0_exert_grunt_0";
    level.exert_sounds[1]["mantlesoundplayer"][1] = "vox_plr_0_exert_grunt_1";
    level.exert_sounds[1]["mantlesoundplayer"][2] = "vox_plr_0_exert_grunt_2";
    level.exert_sounds[1]["mantlesoundplayer"][3] = "vox_plr_0_exert_grunt_3";
    level.exert_sounds[1]["mantlesoundplayer"][4] = "vox_plr_0_exert_grunt_4";
    level.exert_sounds[1]["mantlesoundplayer"][5] = "vox_plr_0_exert_grunt_5";
    level.exert_sounds[1]["mantlesoundplayer"][6] = "vox_plr_0_exert_grunt_6";
    level.exert_sounds[2]["mantlesoundplayer"][0] = "vox_plr_1_exert_grunt_0";
    level.exert_sounds[2]["mantlesoundplayer"][1] = "vox_plr_1_exert_grunt_1";
    level.exert_sounds[2]["mantlesoundplayer"][2] = "vox_plr_1_exert_grunt_2";
    level.exert_sounds[2]["mantlesoundplayer"][3] = "vox_plr_1_exert_grunt_3";
    level.exert_sounds[2]["mantlesoundplayer"][4] = "vox_plr_1_exert_grunt_4";
    level.exert_sounds[2]["mantlesoundplayer"][5] = "vox_plr_1_exert_grunt_5";
    level.exert_sounds[3]["mantlesoundplayer"][0] = "vox_plr_2_exert_grunt_0";
    level.exert_sounds[3]["mantlesoundplayer"][1] = "vox_plr_2_exert_grunt_1";
    level.exert_sounds[3]["mantlesoundplayer"][2] = "vox_plr_2_exert_grunt_2";
    level.exert_sounds[3]["mantlesoundplayer"][3] = "vox_plr_2_exert_grunt_3";
    level.exert_sounds[3]["mantlesoundplayer"][4] = "vox_plr_2_exert_grunt_4";
    level.exert_sounds[3]["mantlesoundplayer"][5] = "vox_plr_2_exert_grunt_5";
    level.exert_sounds[3]["mantlesoundplayer"][6] = "vox_plr_2_exert_grunt_6";
    level.exert_sounds[4]["mantlesoundplayer"][0] = "vox_plr_3_exert_grunt_0";
    level.exert_sounds[4]["mantlesoundplayer"][1] = "vox_plr_3_exert_grunt_1";
    level.exert_sounds[4]["mantlesoundplayer"][2] = "vox_plr_3_exert_grunt_2";
    level.exert_sounds[4]["mantlesoundplayer"][3] = "vox_plr_3_exert_grunt_4";
    level.exert_sounds[4]["mantlesoundplayer"][4] = "vox_plr_3_exert_grunt_5";
    level.exert_sounds[4]["mantlesoundplayer"][5] = "vox_plr_3_exert_grunt_6";
    level.exert_sounds[1]["meleeswipesoundplayer"][0] = "vox_plr_0_exert_knife_swipe_0";
    level.exert_sounds[1]["meleeswipesoundplayer"][1] = "vox_plr_0_exert_knife_swipe_1";
    level.exert_sounds[1]["meleeswipesoundplayer"][2] = "vox_plr_0_exert_knife_swipe_2";
    level.exert_sounds[1]["meleeswipesoundplayer"][3] = "vox_plr_0_exert_knife_swipe_3";
    level.exert_sounds[1]["meleeswipesoundplayer"][4] = "vox_plr_0_exert_knife_swipe_4";
    level.exert_sounds[1]["meleeswipesoundplayer"][5] = "vox_plr_0_exert_knife_swipe_5";
    level.exert_sounds[2]["meleeswipesoundplayer"][0] = "vox_plr_1_exert_knife_swipe_0";
    level.exert_sounds[2]["meleeswipesoundplayer"][1] = "vox_plr_1_exert_knife_swipe_1";
    level.exert_sounds[2]["meleeswipesoundplayer"][2] = "vox_plr_1_exert_knife_swipe_2";
    level.exert_sounds[2]["meleeswipesoundplayer"][3] = "vox_plr_1_exert_knife_swipe_3";
    level.exert_sounds[2]["meleeswipesoundplayer"][4] = "vox_plr_1_exert_knife_swipe_4";
    level.exert_sounds[2]["meleeswipesoundplayer"][5] = "vox_plr_1_exert_knife_swipe_5";
    level.exert_sounds[3]["meleeswipesoundplayer"][0] = "vox_plr_2_exert_knife_swipe_0";
    level.exert_sounds[3]["meleeswipesoundplayer"][1] = "vox_plr_2_exert_knife_swipe_1";
    level.exert_sounds[3]["meleeswipesoundplayer"][2] = "vox_plr_2_exert_knife_swipe_2";
    level.exert_sounds[3]["meleeswipesoundplayer"][3] = "vox_plr_2_exert_knife_swipe_3";
    level.exert_sounds[3]["meleeswipesoundplayer"][4] = "vox_plr_2_exert_knife_swipe_4";
    level.exert_sounds[3]["meleeswipesoundplayer"][5] = "vox_plr_2_exert_knife_swipe_5";
    level.exert_sounds[4]["meleeswipesoundplayer"][0] = "vox_plr_3_exert_knife_swipe_0";
    level.exert_sounds[4]["meleeswipesoundplayer"][1] = "vox_plr_3_exert_knife_swipe_1";
    level.exert_sounds[4]["meleeswipesoundplayer"][2] = "vox_plr_3_exert_knife_swipe_2";
    level.exert_sounds[4]["meleeswipesoundplayer"][3] = "vox_plr_3_exert_knife_swipe_3";
    level.exert_sounds[4]["meleeswipesoundplayer"][4] = "vox_plr_3_exert_knife_swipe_4";
    level.exert_sounds[4]["meleeswipesoundplayer"][5] = "vox_plr_3_exert_knife_swipe_5";
    level.exert_sounds[1]["dtplandsoundplayer"][0] = "vox_plr_0_exert_pain_medium_0";
    level.exert_sounds[1]["dtplandsoundplayer"][1] = "vox_plr_0_exert_pain_medium_1";
    level.exert_sounds[1]["dtplandsoundplayer"][2] = "vox_plr_0_exert_pain_medium_2";
    level.exert_sounds[1]["dtplandsoundplayer"][3] = "vox_plr_0_exert_pain_medium_3";
    level.exert_sounds[2]["dtplandsoundplayer"][0] = "vox_plr_1_exert_pain_medium_0";
    level.exert_sounds[2]["dtplandsoundplayer"][1] = "vox_plr_1_exert_pain_medium_1";
    level.exert_sounds[2]["dtplandsoundplayer"][2] = "vox_plr_1_exert_pain_medium_2";
    level.exert_sounds[2]["dtplandsoundplayer"][3] = "vox_plr_1_exert_pain_medium_3";
    level.exert_sounds[3]["dtplandsoundplayer"][0] = "vox_plr_2_exert_pain_medium_0";
    level.exert_sounds[3]["dtplandsoundplayer"][1] = "vox_plr_2_exert_pain_medium_1";
    level.exert_sounds[3]["dtplandsoundplayer"][2] = "vox_plr_2_exert_pain_medium_2";
    level.exert_sounds[3]["dtplandsoundplayer"][3] = "vox_plr_2_exert_pain_medium_3";
    level.exert_sounds[4]["dtplandsoundplayer"][0] = "vox_plr_3_exert_pain_medium_0";
    level.exert_sounds[4]["dtplandsoundplayer"][1] = "vox_plr_3_exert_pain_medium_1";
    level.exert_sounds[4]["dtplandsoundplayer"][2] = "vox_plr_3_exert_pain_medium_2";
    level.exert_sounds[4]["dtplandsoundplayer"][3] = "vox_plr_3_exert_pain_medium_3";
}

