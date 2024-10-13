#using scripts/cp/cp_mi_sing_blackstation_sound;
#using scripts/cp/cp_mi_sing_blackstation_fx;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/shared/water_surface;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace cp_mi_sing_blackstation;

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0x607e9d62, Offset: 0x1420
// Size: 0x202
function main() {
    util::function_57b966c8(&function_71f88fc, 5);
    register_clientfields();
    flag_init();
    level._effect["rain_light_ne"] = "weather/fx_rain_system_lite_ne_runner_blackstation";
    level._effect["rain_light_se"] = "weather/fx_rain_system_lite_se_runner_blackstation";
    level._effect["rain_med_ne"] = "weather/fx_rain_system_med_ne_runner_blackstation";
    level._effect["rain_med_se"] = "weather/fx_rain_system_med_se_runner_blackstation";
    level._effect["rain_drench_ne"] = "weather/fx_rain_system_drench_ne_runner_blackstation";
    level._effect["rain_drench_se"] = "weather/fx_rain_system_drench_se_runner_blackstation";
    level._effect["wave_pier"] = "water/fx_water_splash_xlg";
    level._effect["wind_effects_anchor"] = "player/fx_plyr_screen_wind_blkstn_anchor_runner";
    level._effect["wind_effects"] = "player/fx_plyr_screen_wind_blkstn_se_runner";
    level._effect["bubbles"] = "player/fx_plyr_swim_bubbles_body";
    level._effect["water_spash_lrg"] = "water/fx_water_splash_xlg";
    level._effect["water_debris"] = "water/fx_underwater_debris_player_loop_blkstn";
    duplicate_render::set_dr_filter_offscreen("sitrep_keyline_red", 25, "keyline_active_red", "keyfill_active_red", 2, "mc/hud_outline_model_red", 0);
    callback::on_spawned(&on_player_spawned);
    cp_mi_sing_blackstation_fx::main();
    cp_mi_sing_blackstation_sound::main();
    function_673254cc();
    load::main();
    util::waitforclient(0);
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0xf47001b5, Offset: 0x1630
// Size: 0x65a
function register_clientfields() {
    clientfield::register("actor", "kill_target_keyline", 1, 4, "int", &function_e722258b, 0, 0);
    clientfield::register("allplayers", "zipline_sound_loop", 1, 1, "int", &function_982d4d35, 0, 0);
    clientfield::register("scriptmover", "water_disturbance", 1, 1, "int", &water_disturbance, 0, 0);
    clientfield::register("scriptmover", "water_splash_lrg", 1, 1, "counter", &function_fedbe3ab, 0, 0);
    clientfield::register("toplayer", "player_rain", 1, 3, "int", &function_42998a0f, 0, 0);
    clientfield::register("toplayer", "rumble_loop", 1, 1, "int", &function_989f7c26, 0, 0);
    clientfield::register("toplayer", "sndWindSystem", 1, 2, "int", &cp_mi_sing_blackstation_sound::sndWindSystem, 0, 1);
    clientfield::register("toplayer", "zipline_rumble_loop", 1, 1, "int", &function_85392f32, 0, 0);
    clientfield::register("toplayer", "player_water_swept", 1, 1, "int", &function_fd89a017, 0, 0);
    clientfield::register("toplayer", "toggle_ukko", 1, 2, "int", &function_983b5ccf, 0, 0);
    clientfield::register("toplayer", "toggle_rain_sprite", 1, 2, "int", &toggle_rain_sprite, 0, 0);
    clientfield::register("toplayer", "wind_blur", 1, 1, "int", &function_4a01cc4e, 0, 0);
    clientfield::register("toplayer", "wind_effects", 1, 2, "int", &function_ffa95b91, 0, 0);
    clientfield::register("toplayer", "subway_water", 1, 1, "int", &function_c170b293, 0, 0);
    clientfield::register("toplayer", "play_bubbles", 1, 1, "int", &function_58e931d1, 0, 0);
    clientfield::register("toplayer", "toggle_water_fx", 1, 1, "int", &toggle_water_fx, 0, 0);
    clientfield::register("toplayer", "wave_hit", 1, 1, "int", &function_40788165, 0, 0);
    clientfield::register("world", "subway_entrance_crash", 1, 1, "int", &subway_entrance_crash, 0, 0);
    clientfield::register("world", "water_level", 1, 3, "int", &function_ec1c5731, 0, 0);
    clientfield::register("world", "roof_panels_init", 1, 1, "int", &function_59e9894a, 0, 0);
    clientfield::register("world", "roof_panels_play", 1, 1, "int", &function_db90ecbe, 0, 0);
    clientfield::register("world", "subway_tiles", 1, 1, "int", &function_33d0325b, 0, 0);
    clientfield::register("world", "warlord_exposure", 1, 1, "int", &function_f6681c64, 0, 0);
    clientfield::register("world", "outro_exposure", 1, 1, "int", &function_c1835b73, 0, 0);
    clientfield::register("world", "sndDrillWalla", 1, 2, "int", &cp_mi_sing_blackstation_sound::sndDrillWalla, 0, 0);
    clientfield::register("world", "sndBlackStationSounds", 1, 1, "int", &cp_mi_sing_blackstation_sound::sndBlackStationSounds, 0, 0);
    clientfield::register("world", "flotsam", 1, 1, "int", &function_5d2e29ca, 0, 0);
    clientfield::register("world", "sndStationWalla", 1, 1, "int", &cp_mi_sing_blackstation_sound::sndStationWalla, 0, 0);
    clientfield::register("world", "qzone_debris", 1, 1, "counter", &function_dadc58c3, 0, 0);
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0x89e8f901, Offset: 0x1c98
// Size: 0x1a
function flag_init() {
    level flag::init("building_break");
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0xfb3828c0, Offset: 0x1cc0
// Size: 0xb2
function function_983b5ccf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        switch (newval) {
        case 1:
            n_index = 31;
            break;
        case 2:
            n_index = 32;
            break;
        }
        setukkoscriptindex(localclientnum, n_index, 1);
        wait 0.1;
        setukkoscriptindex(localclientnum, 2, 1);
    }
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0x53448043, Offset: 0x1d80
// Size: 0x72
function function_f6681c64(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setexposureactivebank(localclientnum, 2);
        return;
    }
    setexposureactivebank(localclientnum, 1);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0xbc60d794, Offset: 0x1e00
// Size: 0x82
function function_c1835b73(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setexposureactivebank(localclientnum, 3);
        setworldfogactivebank(localclientnum, 2);
        return;
    }
    setexposureactivebank(localclientnum, 1);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0xdd40bff4, Offset: 0x1e90
// Size: 0x6a
function function_58e931d1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_6e954d4(localclientnum);
        return;
    }
    self thread function_6fb5501(localclientnum);
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x0
// Checksum 0x21f13083, Offset: 0x1f08
// Size: 0x82
function function_6e954d4(localclientnum) {
    self endon(#"death");
    self.var_b5e2500e = playfxoncamera(localclientnum, level._effect["bubbles"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
    self.var_35da2bd6 = playfxoncamera(localclientnum, level._effect["water_debris"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
    self thread function_738868d4(localclientnum);
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x0
// Checksum 0x1a3460be, Offset: 0x1f98
// Size: 0x53
function function_6fb5501(localclientnum) {
    if (isdefined(self.var_b5e2500e)) {
        stopfx(localclientnum, self.var_b5e2500e);
    }
    if (isdefined(self.var_35da2bd6)) {
        killfx(localclientnum, self.var_35da2bd6);
    }
    self notify(#"hash_a48959b9");
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x0
// Checksum 0x2b3c7db, Offset: 0x1ff8
// Size: 0x32
function function_738868d4(localclientnum) {
    self endon(#"hash_a48959b9");
    self waittill(#"death");
    self function_6fb5501(localclientnum);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0x169c23f1, Offset: 0x2038
// Size: 0x82
function function_4a01cc4e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        enablespeedblur(localclientnum, 0.07, 0.55, 0.9, 0, 100, 100);
        return;
    }
    disablespeedblur(localclientnum);
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0xf0ecf0ae, Offset: 0x20c8
// Size: 0x4a
function function_967477f8(localclientnum, var_2d166751) {
    localplayer = getlocalplayer(localclientnum);
    localplayer.rainopacity = var_2d166751;
    filter::function_e4987221(localplayer);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0xb9cc13fb, Offset: 0x2120
// Size: 0xc2
function toggle_rain_sprite(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        var_2d166751 = 0.1;
    } else if (newval == 2) {
        var_2d166751 = 0.4;
    } else if (newval == 3) {
        var_2d166751 = 0.8;
    } else {
        var_2d166751 = 0;
        self thread function_643ad70d(localclientnum);
    }
    if (var_2d166751) {
        function_967477f8(localclientnum, var_2d166751);
        self thread function_f26e8536(localclientnum, var_2d166751);
    }
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0xc61676, Offset: 0x21f0
// Size: 0xfd
function function_f26e8536(localclientnum, n_opacity) {
    self notify(#"hash_10c60859");
    self endon(#"entityshutdown");
    self endon(#"death");
    self endon(#"hash_10c60859");
    filter::disable_filter_sprite_rain(self, 0);
    if (!isdefined(self.rainopacity)) {
        self.rainopacity = n_opacity;
    }
    if (self.rainopacity == 0) {
        filter::set_filter_sprite_rain_seed_offset(self, 0, n_opacity);
    }
    filter::function_cd327356(self, 0);
    while (true) {
        self.rainopacity = self.rainopacity + 0.001;
        if (self.rainopacity > 1) {
            self.rainopacity = n_opacity;
        }
        filter::set_filter_sprite_rain_opacity(self, 0, self.rainopacity);
        filter::set_filter_sprite_rain_elapsed(self, 0, self getclienttime());
        wait 0.016;
    }
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x0
// Checksum 0x6204e68b, Offset: 0x22f8
// Size: 0xb2
function function_643ad70d(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"death");
    if (isdefined(self.rainopacity)) {
        while (self.rainopacity > 0) {
            self.rainopacity = self.rainopacity - 0.005;
            filter::set_filter_sprite_rain_opacity(self, 0, self.rainopacity);
            filter::set_filter_sprite_rain_elapsed(self, 0, self getclienttime());
            wait 0.016;
        }
    }
    self.rainopacity = 0;
    filter::disable_filter_sprite_rain(self, 0);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0xfa62c577, Offset: 0x23b8
// Size: 0x62
function function_fd89a017(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_watertransition");
        return;
    }
    self thread postfx::stoppostfxbundle();
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0x3713ea3e, Offset: 0x2428
// Size: 0x7a
function function_85392f32(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self playrumblelooponentity(localclientnum, "cp_blackstation_zipline_loop_rumble");
        return;
    }
    self stoprumble(localclientnum, "cp_blackstation_zipline_loop_rumble");
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x0
// Checksum 0x33b690a8, Offset: 0x24b0
// Size: 0x75
function function_71f88fc(n_index) {
    switch (n_index) {
    case 1:
        forcestreambundle("cin_bla_01_01_intro_1st");
        break;
    case 2:
        break;
    case 3:
        break;
    case 4:
        forcestreambundle("p7_fxanim_cp_blackstation_apartment_collapse_bundle");
        break;
    }
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0x31453ce0, Offset: 0x2530
// Size: 0x192
function function_42998a0f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        switch (newval) {
        case 1:
            str_fx = "rain_light_se";
            self thread player_rain(localclientnum, str_fx);
            break;
        case 2:
            str_fx = "rain_med_se";
            self thread player_rain(localclientnum, str_fx);
            break;
        case 3:
            str_fx = "rain_drench_se";
            self thread player_rain(localclientnum, str_fx);
            break;
        case 4:
            str_fx = "rain_light_ne";
            self thread player_rain(localclientnum, str_fx);
            break;
        case 5:
            str_fx = "rain_med_ne";
            self thread player_rain(localclientnum, str_fx);
            break;
        case 6:
            str_fx = "rain_drench_ne";
            self thread player_rain(localclientnum, str_fx);
            break;
        }
        return;
    }
    if (isdefined(self.var_88aec2ed)) {
        stopfx(localclientnum, self.var_88aec2ed);
    }
    if (isdefined(self.e_link)) {
        self.e_link delete();
    }
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x92cb6a18, Offset: 0x26d0
// Size: 0xfa
function player_rain(localclientnum, str_fx) {
    if (isdefined(self.var_88aec2ed)) {
        stopfx(localclientnum, self.var_88aec2ed);
    }
    if (isdefined(self.e_link)) {
        self.e_link delete();
    }
    self.e_link = spawn(localclientnum, self.origin, "script_model");
    self.e_link setmodel("tag_origin");
    self.e_link.angles = self.angles;
    self.e_link linkto(self);
    self.var_88aec2ed = playfxontag(localclientnum, level._effect[str_fx], self.e_link, "tag_origin");
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0xfa1fc981, Offset: 0x27d8
// Size: 0x6a
function function_59e9894a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::init("p7_fxanim_cp_blackstation_tin_roof_panels_01_bundle");
        level thread scene::init("p7_fxanim_cp_blackstation_tin_roof_panels_02_bundle");
    }
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0x36166892, Offset: 0x2850
// Size: 0x6a
function function_db90ecbe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_blackstation_tin_roof_panels_01_bundle");
        level thread scene::play("p7_fxanim_cp_blackstation_tin_roof_panels_02_bundle");
    }
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0x8f23da72, Offset: 0x28c8
// Size: 0x52
function function_33d0325b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_blackstation_subway_tiles_bundle");
    }
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0x63b86f6b, Offset: 0x2928
// Size: 0xea
function function_e722258b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    e_player = getlocalplayer(localclientnum);
    if (!isdefined(e_player) || newval != e_player getentitynumber() + 1) {
        return;
    }
    assert(isdefined(self), "<dev string:x28>");
    level flagsys::wait_till("duplicaterender_registry_ready");
    assert(isdefined(self), "<dev string:x4e>");
    self duplicate_render::change_dr_flags(localclientnum, "keyline_active_red", "keyfill_active_red");
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0x47da98e3, Offset: 0x2a20
// Size: 0xb5
function function_ec1c5731(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
    case 2:
        setwavewaterheight("port_water", 20);
        break;
    case 3:
        setwavewaterheight("frogger_water", 64);
        break;
    default:
        setwavewaterheight("port_water", 0);
        break;
    }
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0x1248d3ab, Offset: 0x2ae0
// Size: 0x91
function function_218d833() {
    level notify(#"hash_39c6460f");
    level endon(#"hash_215ac037");
    var_55fa7b94 = 20;
    n_drop = 0.15;
    n_rate = 0.05;
    var_416478aa = 0;
    while (!var_416478aa) {
        setwavewaterheight("port_water", var_55fa7b94);
        if (var_55fa7b94 > n_drop) {
            var_55fa7b94 -= n_drop;
            if (var_55fa7b94 <= n_drop) {
                var_416478aa = 1;
            }
        }
        wait 0.01;
    }
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0x504562cc, Offset: 0x2b80
// Size: 0x81
function function_176dacb() {
    level notify(#"hash_215ac037");
    level endon(#"hash_39c6460f");
    var_55fa7b94 = 0;
    var_7b6b0a5b = 0.25;
    var_416478aa = 1;
    while (var_416478aa) {
        setwavewaterheight("port_water", var_55fa7b94);
        if (var_55fa7b94 < 20) {
            var_55fa7b94 += var_7b6b0a5b;
            if (var_55fa7b94 >= 20) {
                var_416478aa = 0;
            }
        }
        wait 0.01;
    }
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x0
// Checksum 0x121e0cac, Offset: 0x2c10
// Size: 0x1a
function on_player_spawned(localclientnum) {
    filter::function_5c4aeccd(self);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0x2acc08c7, Offset: 0x2c38
// Size: 0x7a
function function_982d4d35(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self playloopsound("evt_zipline_move", 0.5);
        return;
    }
    self stopallloopsounds(0.5);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0xf5c9ea8f, Offset: 0x2cc0
// Size: 0x7a
function function_989f7c26(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playrumblelooponentity(localclientnum, "tank_rumble");
        return;
    }
    self stoprumble(localclientnum, "tank_rumble");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0xcf4a1164, Offset: 0x2d48
// Size: 0x2fa
function function_673254cc() {
    skipto::add("objective_igc", &function_a796eb5e, undefined, &function_40b9b738);
    skipto::add("objective_qzone", &function_39bffbde);
    skipto::add("objective_warlord_igc", &function_bb306d90);
    skipto::add("objective_warlord", &function_4c07b70a);
    skipto::add("objective_anchor_intro", &function_3cf0ef2b);
    skipto::add("objective_port_assault", &function_f5ac779c, undefined, &function_3aec2);
    skipto::add("objective_barge_assault", &function_def9d38e);
    skipto::add("objective_storm_surge", &function_68e5c597, undefined, &function_d78cf96d);
    skipto::add("objective_subway", &function_ec466e32);
    skipto::add("objective_police_station", &function_f3a694a6);
    skipto::add("objective_kane_intro", &function_4fbcb062, undefined, &function_d96d8db5);
    skipto::add("objective_comm_relay_traverse", &function_4cdd3a9a);
    skipto::add("objective_comm_relay", &function_9ba92728);
    skipto::add("objective_cross_debris", &function_f3ba72a4, undefined, &function_4d38ae0f);
    skipto::add("objective_blackstation_exterior", &function_112a3f23);
    skipto::add("objective_blackstation_interior", &function_6a18d1d4);
    skipto::add("objective_end_igc", &function_6a18d1d4);
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x863110e4, Offset: 0x3050
// Size: 0x7a
function function_a796eb5e(str_objective, var_74cd64bc) {
    level thread function_42c55e18();
    level thread function_9570c674();
    setwavewaterenabled("frogger_water", 0);
    setwavewaterenabled("port_water", 0);
    level scene::init("p7_fxanim_cp_blackstation_qzone_ground_debris_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0xd51dd2dc, Offset: 0x30d8
// Size: 0x2a
function function_40b9b738(str_objective, var_74cd64bc) {
    level thread scene::play("p7_fxanim_gp_lamp_hanging_sin_lamppost_02_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x67d55c9b, Offset: 0x3110
// Size: 0x82
function function_39bffbde(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_42c55e18();
        level thread function_9570c674();
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
        level scene::play("p7_fxanim_cp_blackstation_qzone_ground_debris_bundle");
    }
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0xb32bc059, Offset: 0x31a0
// Size: 0x5a
function function_bb306d90(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_42c55e18();
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x892de496, Offset: 0x3208
// Size: 0x6a
function function_4c07b70a(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_42c55e18();
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
    level thread function_3802e537();
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x11ffb354, Offset: 0x3280
// Size: 0x7a
function function_3cf0ef2b(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_42c55e18();
        level thread function_3802e537();
        setwavewaterenabled("frogger_water", 0);
    }
    setwavewaterenabled("port_water", 1);
    level thread function_d2829c38();
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x8e272c83, Offset: 0x3308
// Size: 0xba
function function_f5ac779c(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_42c55e18();
        level thread function_d2829c38();
        level thread function_3802e537();
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 1);
        level scene::add_scene_func("p7_fxanim_cp_blackstation_boatroom_bundle", &function_a3efe3eb, "play");
    }
    level thread function_f8ff4031();
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x2abd587b, Offset: 0x33d0
// Size: 0x1aa
function function_3aec2(str_objective, var_74cd64bc) {
    level thread scene::stop("p7_fxanim_cp_blackstation_tents_military_end_l_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_tents_military_end_l_dbl_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_tents_military_end_r_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_tents_military_end_r_dbl_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_tents_military_end_r_open_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_tents_military_end_side_dbl_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_tents_white_military_end_l_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_tents_white_military_end_r_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_tents_white_military_end_side_dbl_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_medical_divider_01_s5_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_medical_divider_02_s5_bundle", 1);
    level thread scene::stop("p7_fxanim_gp_trash_cardboard_box_04_bundle", 1);
    level thread scene::stop("p7_fxanim_gp_trash_cardboard_box_03_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_anchor_beginning_idle_01_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_anchor_beginning_idle_02_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_anchor_beginning_idle_03_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_anchor_beginning_idle_04_bundle", 1);
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0xc8574a73, Offset: 0x3588
// Size: 0x7a
function function_def9d38e(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_d2829c38();
        level thread function_f8ff4031();
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 1);
    }
    level thread function_1bbce270();
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0xf18f389b, Offset: 0x3610
// Size: 0xa2
function function_68e5c597(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_d2829c38();
        level thread function_1bbce270();
        level thread function_f8ff4031();
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 1);
    }
    level scene::init("p7_fxanim_cp_blackstation_tanker_building_smash_bundle");
    level thread function_6f3570de();
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x53cd12cf, Offset: 0x36c0
// Size: 0x1aa
function function_d78cf96d(str_objective, var_74cd64bc) {
    level thread scene::stop("p7_fxanim_gp_floating_buoy_02_upright_fast_bundle", 1);
    level thread scene::stop("p7_fxanim_gp_floating_buoy_03_roll_bundle", 1);
    level thread scene::stop("p7_fxanim_gp_floating_buoy_03_upright_fast_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_boatroom_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_tanker_building_smash_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_pier_board_kit_02_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_pier_board_kit_03_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_pier_board_kit_04_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_pier_wire_rt_01_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_pier_wire_rt_02_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_pier_wire_rt_03_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_pier_wire_rt_04_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_pier_wire_lt_01_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_pier_wire_lt_02_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_pier_wire_lt_03_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_pier_wire_lt_04_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_pier_container_bundle", 1);
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x3992a39d, Offset: 0x3878
// Size: 0x5a
function function_ec466e32(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        setwavewaterenabled("frogger_water", 0);
    }
    level thread function_5005007a();
    setwavewaterenabled("port_water", 0);
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x22da2e9b, Offset: 0x38e0
// Size: 0x72
function function_f3a694a6(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_5005007a();
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
    level thread scene::play("p7_fxanim_gp_rope_scaffold_01_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0xd2d3e171, Offset: 0x3960
// Size: 0x4a
function function_4fbcb062(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0xf6069c2e, Offset: 0x39b8
// Size: 0x9a
function function_d96d8db5(str_objective, var_74cd64bc) {
    level thread function_96838a27();
    level thread scene::play("cin_bla_12_01_cross_debris_hanging_shortrope");
    level thread scene::play("cin_bla_12_01_cross_debris_hanging_medrope");
    level thread scene::play("p7_fxanim_gp_wire_sparking_med_thick_bundle");
    level thread scene::play("p7_fxanim_gp_wire_sparking_sml_bundle");
    level thread scene::play("p7_fxanim_gp_rope_scaffold_01_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x236d9fe6, Offset: 0x3a60
// Size: 0x4a
function function_4cdd3a9a(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        setwavewaterenabled("port_water", 0);
    }
    setwavewaterenabled("frogger_water", 1);
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0xf84ec328, Offset: 0x3ab8
// Size: 0x4a
function function_9ba92728(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0xeb1665f7, Offset: 0x3b10
// Size: 0x4a
function function_f3ba72a4(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x54401d8a, Offset: 0x3b68
// Size: 0x2a
function function_4d38ae0f(str_objective, var_74cd64bc) {
    level thread scene::stop("p7_fxanim_gp_rope_scaffold_01_bundle", 1);
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x93928ae9, Offset: 0x3ba0
// Size: 0x112
function function_112a3f23(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
    level thread function_42c55e18();
    level thread function_13a8d1c5();
    level thread scene::stop("cin_bla_12_01_cross_debris_hanging_shortrope", 1);
    level thread scene::stop("cin_bla_12_01_cross_debris_hanging_medrope", 1);
    level thread scene::stop("p7_fxanim_gp_wire_sparking_med_thick_bundle", 1);
    level thread scene::stop("p7_fxanim_gp_wire_sparking_sml_bundle", 1);
    level thread scene::stop("p7_fxanim_gp_rope_scaffold_01_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_river_debris01_bundle", 1);
    level thread scene::stop("p7_fxanim_cp_blackstation_river_debris02_bundle", 1);
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x9c47aad3, Offset: 0x3cc0
// Size: 0x4a
function function_6a18d1d4(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0xa5c48294, Offset: 0x3d18
// Size: 0x6a
function function_9570c674() {
    level thread scene::play("p7_fxanim_cp_blackstation_medical_divider_01_s5_bundle");
    level thread scene::play("p7_fxanim_cp_blackstation_medical_divider_02_s5_bundle");
    wait 0.016;
    level thread scene::play("p7_fxanim_gp_trash_cardboard_box_04_bundle");
    level thread scene::play("p7_fxanim_gp_trash_cardboard_box_03_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0x6dea57bc, Offset: 0x3d90
// Size: 0x11a
function function_42c55e18() {
    level thread scene::init("p7_fxanim_cp_blackstation_tents_military_end_l_bundle");
    wait 0.016;
    level thread scene::init("p7_fxanim_cp_blackstation_tents_military_end_l_dbl_bundle");
    wait 0.016;
    level thread scene::init("p7_fxanim_cp_blackstation_tents_military_end_r_bundle");
    wait 0.016;
    level thread scene::init("p7_fxanim_cp_blackstation_tents_military_end_r_dbl_bundle");
    wait 0.016;
    level thread scene::init("p7_fxanim_cp_blackstation_tents_military_end_r_open_bundle");
    wait 0.016;
    level thread scene::init("p7_fxanim_cp_blackstation_tents_military_end_side_dbl_bundle");
    wait 0.016;
    level thread scene::init("p7_fxanim_cp_blackstation_tents_white_military_end_l_bundle");
    wait 0.016;
    level thread scene::init("p7_fxanim_cp_blackstation_tents_white_military_end_r_bundle");
    wait 0.016;
    level thread scene::init("p7_fxanim_cp_blackstation_tents_white_military_end_side_dbl_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0xfb93ce4a, Offset: 0x3eb8
// Size: 0x4a
function function_d2829c38() {
    level thread scene::play("p7_fxanim_gp_floating_buoy_02_upright_fast_bundle");
    level thread scene::play("p7_fxanim_gp_floating_buoy_03_roll_bundle");
    level thread scene::play("p7_fxanim_gp_floating_buoy_03_upright_fast_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0x50c57708, Offset: 0x3f10
// Size: 0x7a
function function_3802e537() {
    level thread scene::play("p7_fxanim_cp_blackstation_anchor_beginning_idle_01_bundle");
    wait 0.016;
    level thread scene::play("p7_fxanim_cp_blackstation_anchor_beginning_idle_02_bundle");
    wait 0.016;
    level thread scene::play("p7_fxanim_cp_blackstation_anchor_beginning_idle_03_bundle");
    wait 0.016;
    level thread scene::play("p7_fxanim_cp_blackstation_anchor_beginning_idle_04_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0xad29fed9, Offset: 0x3f98
// Size: 0x32
function function_5005007a() {
    level thread scene::play("p7_fxanim_gp_wire_sparking_sml_bundle");
    level thread scene::play("p7_fxanim_gp_wire_sparking_med_thick_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0xb65c36d7, Offset: 0x3fd8
// Size: 0x32
function function_96838a27() {
    level thread scene::play("p7_fxanim_cp_blackstation_river_debris01_bundle");
    level thread scene::play("p7_fxanim_cp_blackstation_river_debris02_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0x494f8b53, Offset: 0x4018
// Size: 0x1a
function function_13a8d1c5() {
    level thread scene::play("blackstation_exterior_shutters");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0x16817572, Offset: 0x4040
// Size: 0xe9
function function_1bbce270() {
    level endon(#"hash_9bfd16b7");
    var_10ec3c1e = struct::get_array("pulse_barge", "targetname");
    while (true) {
        foreach (s_pulse in var_10ec3c1e) {
            physicsexplosionsphere(0, s_pulse.origin, 400, 0, 0.01, 0, 0, 0, 1);
        }
        wait 1;
    }
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0x9338d16b, Offset: 0x4138
// Size: 0xca
function function_ffa95b91(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isspectating(localclientnum)) {
            self thread function_fbc6b3e8(localclientnum, "wind_effects");
        }
        return;
    }
    if (newval == 2) {
        if (!isspectating(localclientnum)) {
            self thread function_fbc6b3e8(localclientnum, "wind_effects_anchor");
        }
        return;
    }
    self thread function_26d7266e(localclientnum);
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x0
// Checksum 0x1b852182, Offset: 0x4210
// Size: 0x52
function function_fbc6b3e8(localclientnum, str_fx) {
    self endon(#"death");
    self.n_fx_id = playfxoncamera(localclientnum, level._effect[str_fx], (0, 0, 0), (1, 0, 0), (0, 0, 1));
    self thread function_82b37a9c(localclientnum);
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x0
// Checksum 0xd7e2c4b0, Offset: 0x4270
// Size: 0x33
function function_26d7266e(localclientnum) {
    if (isdefined(self.n_fx_id)) {
        stopfx(localclientnum, self.n_fx_id);
    }
    self notify(#"hash_944ec624");
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x0
// Checksum 0x474900f6, Offset: 0x42b0
// Size: 0x32
function function_82b37a9c(localclientnum) {
    self endon(#"hash_944ec624");
    self waittill(#"death");
    self function_26d7266e(localclientnum);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0xba0a10fc, Offset: 0x42f0
// Size: 0x6a
function function_c170b293(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("subway_underwater_volumetric");
        return;
    }
    exploder::stop_exploder("subway_underwater_volumetric");
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0x998db71b, Offset: 0x4368
// Size: 0x6a
function subway_entrance_crash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("subway_entrance_crash");
        return;
    }
    exploder::stop_exploder("subway_entrance_crash");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0xa58cf8c9, Offset: 0x43e0
// Size: 0x32
function function_6f3570de() {
    level flag::wait_till("building_break");
    level scene::play("p7_fxanim_cp_blackstation_tanker_building_smash_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0xf6efb58d, Offset: 0x4420
// Size: 0x10e
function water_disturbance(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(self.var_2e7c1306)) {
        str_tag = "wave_trigger_jnt";
        self.var_2e7c1306 = util::spawn_model(localclientnum, "tag_origin", self gettagorigin(str_tag), self gettagangles(str_tag));
        self.var_2e7c1306 linkto(self, str_tag);
        self.var_2e7c1306 setwaterdisturbanceparams(0.5, 500, 1500, 1, 80);
    }
    if (newval) {
        self.var_2e7c1306.waterdisturbance = 1;
        return;
    }
    self.var_2e7c1306.waterdisturbance = 0;
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0x1e8ccc3b, Offset: 0x4538
// Size: 0x62
function function_fedbe3ab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["water_spash_lrg"], self, "tag_origin");
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x0
// Checksum 0x3fb0f6d4, Offset: 0x45a8
// Size: 0x52
function function_a3efe3eb(a_ents) {
    a_ents["boat_room_glass"] siegecmd("set_anim", "p7_fxanim_cp_blackstation_boatroom_glass_sanim", "set_shot", "default", "pause", "goto_end");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x0
// Checksum 0x9d87803e, Offset: 0x4608
// Size: 0x3d3
function function_f8ff4031() {
    var_179127c2 = [];
    if (!isdefined(var_179127c2)) {
        var_179127c2 = [];
    } else if (!isarray(var_179127c2)) {
        var_179127c2 = array(var_179127c2);
    }
    var_179127c2[var_179127c2.size] = "p7_fxanim_cp_blackstation_pier_board_kit_02_bundle";
    if (!isdefined(var_179127c2)) {
        var_179127c2 = [];
    } else if (!isarray(var_179127c2)) {
        var_179127c2 = array(var_179127c2);
    }
    var_179127c2[var_179127c2.size] = "p7_fxanim_cp_blackstation_pier_board_kit_03_bundle";
    if (!isdefined(var_179127c2)) {
        var_179127c2 = [];
    } else if (!isarray(var_179127c2)) {
        var_179127c2 = array(var_179127c2);
    }
    var_179127c2[var_179127c2.size] = "p7_fxanim_cp_blackstation_pier_board_kit_04_bundle";
    if (!isdefined(var_179127c2)) {
        var_179127c2 = [];
    } else if (!isarray(var_179127c2)) {
        var_179127c2 = array(var_179127c2);
    }
    var_179127c2[var_179127c2.size] = "p7_fxanim_cp_blackstation_pier_wire_rt_01_bundle";
    if (!isdefined(var_179127c2)) {
        var_179127c2 = [];
    } else if (!isarray(var_179127c2)) {
        var_179127c2 = array(var_179127c2);
    }
    var_179127c2[var_179127c2.size] = "p7_fxanim_cp_blackstation_pier_wire_rt_02_bundle";
    if (!isdefined(var_179127c2)) {
        var_179127c2 = [];
    } else if (!isarray(var_179127c2)) {
        var_179127c2 = array(var_179127c2);
    }
    var_179127c2[var_179127c2.size] = "p7_fxanim_cp_blackstation_pier_wire_rt_03_bundle";
    if (!isdefined(var_179127c2)) {
        var_179127c2 = [];
    } else if (!isarray(var_179127c2)) {
        var_179127c2 = array(var_179127c2);
    }
    var_179127c2[var_179127c2.size] = "p7_fxanim_cp_blackstation_pier_wire_rt_04_bundle";
    if (!isdefined(var_179127c2)) {
        var_179127c2 = [];
    } else if (!isarray(var_179127c2)) {
        var_179127c2 = array(var_179127c2);
    }
    var_179127c2[var_179127c2.size] = "p7_fxanim_cp_blackstation_pier_wire_lt_01_bundle";
    if (!isdefined(var_179127c2)) {
        var_179127c2 = [];
    } else if (!isarray(var_179127c2)) {
        var_179127c2 = array(var_179127c2);
    }
    var_179127c2[var_179127c2.size] = "p7_fxanim_cp_blackstation_pier_wire_lt_02_bundle";
    if (!isdefined(var_179127c2)) {
        var_179127c2 = [];
    } else if (!isarray(var_179127c2)) {
        var_179127c2 = array(var_179127c2);
    }
    var_179127c2[var_179127c2.size] = "p7_fxanim_cp_blackstation_pier_wire_lt_03_bundle";
    if (!isdefined(var_179127c2)) {
        var_179127c2 = [];
    } else if (!isarray(var_179127c2)) {
        var_179127c2 = array(var_179127c2);
    }
    var_179127c2[var_179127c2.size] = "p7_fxanim_cp_blackstation_pier_wire_lt_04_bundle";
    if (!isdefined(var_179127c2)) {
        var_179127c2 = [];
    } else if (!isarray(var_179127c2)) {
        var_179127c2 = array(var_179127c2);
    }
    var_179127c2[var_179127c2.size] = "p7_fxanim_cp_blackstation_pier_container_bundle";
    foreach (str_bundle in var_179127c2) {
        level thread scene::play(str_bundle);
        wait 0.016;
    }
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0x771968a, Offset: 0x49e8
// Size: 0x72
function function_5d2e29ca(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        setdvar("phys_buoyancy", 1);
        return;
    }
    setdvar("phys_buoyancy", 0);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0x18b4283f, Offset: 0x4a68
// Size: 0x52
function function_dadc58c3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level scene::play("p7_fxanim_cp_blackstation_qzone_ground_debris_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0xfd4a2ff4, Offset: 0x4ac8
// Size: 0x72
function toggle_water_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self notify(#"underwaterwatchbegin");
        self notify(#"underwaterwatchend");
        return;
    }
    self thread water_surface::underwaterwatchbegin();
    self thread water_surface::underwaterwatchend();
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x0
// Checksum 0xc2f407fe, Offset: 0x4b48
// Size: 0x9a
function function_40788165(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread water_surface::underwaterbegin();
        enablespeedblur(localclientnum, 1, 0.15, 0.9, 0, 100, 100);
        return;
    }
    self thread water_surface::underwaterend();
    disablespeedblur(localclientnum);
}

