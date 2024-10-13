#using scripts/cp/cp_mi_sing_blackstation_patch_c;
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
// Params 0, eflags: 0x1 linked
// Checksum 0xf9067d84, Offset: 0x1450
// Size: 0x25c
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
    cp_mi_sing_blackstation_patch_c::function_7403e82b();
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x1 linked
// Checksum 0x17dfe76e, Offset: 0x16b8
// Size: 0x82c
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
// Params 0, eflags: 0x1 linked
// Checksum 0x30055ac9, Offset: 0x1ef0
// Size: 0x24
function flag_init() {
    level flag::init("building_break");
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0x522a1493, Offset: 0x1f20
// Size: 0xd4
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
// Params 7, eflags: 0x1 linked
// Checksum 0x779665e, Offset: 0x2000
// Size: 0x84
function function_f6681c64(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setexposureactivebank(localclientnum, 2);
        return;
    }
    setexposureactivebank(localclientnum, 1);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0x86437616, Offset: 0x2090
// Size: 0x9c
function function_c1835b73(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setexposureactivebank(localclientnum, 3);
        setworldfogactivebank(localclientnum, 2);
        return;
    }
    setexposureactivebank(localclientnum, 1);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0x5e397f0d, Offset: 0x2138
// Size: 0x7c
function function_58e931d1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_6e954d4(localclientnum);
        return;
    }
    self thread function_6fb5501(localclientnum);
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x1 linked
// Checksum 0x7e473e5c, Offset: 0x21c0
// Size: 0xac
function function_6e954d4(localclientnum) {
    self endon(#"death");
    self.var_b5e2500e = playfxoncamera(localclientnum, level._effect["bubbles"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
    self.var_35da2bd6 = playfxoncamera(localclientnum, level._effect["water_debris"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
    self thread function_738868d4(localclientnum);
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x1 linked
// Checksum 0x8e0a5de2, Offset: 0x2278
// Size: 0x6a
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
// Params 1, eflags: 0x1 linked
// Checksum 0xacc676cd, Offset: 0x22f0
// Size: 0x3c
function function_738868d4(localclientnum) {
    self endon(#"hash_a48959b9");
    self waittill(#"death");
    self function_6fb5501(localclientnum);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0xea2a0e3c, Offset: 0x2338
// Size: 0x94
function function_4a01cc4e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        enablespeedblur(localclientnum, 0.07, 0.55, 0.9, 0, 100, 100);
        return;
    }
    disablespeedblur(localclientnum);
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x1 linked
// Checksum 0xffe25ca7, Offset: 0x23d8
// Size: 0x64
function function_967477f8(localclientnum, var_2d166751) {
    localplayer = getlocalplayer(localclientnum);
    localplayer.rainopacity = var_2d166751;
    filter::function_e4987221(localplayer);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0x8a95db85, Offset: 0x2448
// Size: 0x104
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
// Params 2, eflags: 0x1 linked
// Checksum 0x57f8137d, Offset: 0x2558
// Size: 0x140
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
        self.rainopacity += 0.001;
        if (self.rainopacity > 1) {
            self.rainopacity = n_opacity;
        }
        filter::set_filter_sprite_rain_opacity(self, 0, self.rainopacity);
        filter::set_filter_sprite_rain_elapsed(self, 0, self getclienttime());
        wait 0.016;
    }
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x1 linked
// Checksum 0xef8cd74e, Offset: 0x26a0
// Size: 0xd4
function function_643ad70d(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"death");
    if (isdefined(self.rainopacity)) {
        while (self.rainopacity > 0) {
            self.rainopacity -= 0.005;
            filter::set_filter_sprite_rain_opacity(self, 0, self.rainopacity);
            filter::set_filter_sprite_rain_elapsed(self, 0, self getclienttime());
            wait 0.016;
        }
    }
    self.rainopacity = 0;
    filter::disable_filter_sprite_rain(self, 0);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0x43b5378b, Offset: 0x2780
// Size: 0x7c
function function_fd89a017(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread postfx::playpostfxbundle("pstfx_watertransition");
        return;
    }
    self thread postfx::stoppostfxbundle();
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0x6257102e, Offset: 0x2808
// Size: 0x94
function function_85392f32(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self playrumblelooponentity(localclientnum, "cp_blackstation_zipline_loop_rumble");
        return;
    }
    self stoprumble(localclientnum, "cp_blackstation_zipline_loop_rumble");
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x1 linked
// Checksum 0x11525aa8, Offset: 0x28a8
// Size: 0x7e
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
// Params 7, eflags: 0x1 linked
// Checksum 0xc5c390a2, Offset: 0x2930
// Size: 0x20c
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
        self.var_88aec2ed = undefined;
    }
    if (isdefined(self.e_link)) {
        self.e_link delete();
    }
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x1 linked
// Checksum 0x62462a5f, Offset: 0x2b48
// Size: 0x16e
function player_rain(localclientnum, str_fx) {
    if (isdefined(self.var_88aec2ed)) {
        stopfx(localclientnum, self.var_88aec2ed);
        self.var_88aec2ed = undefined;
    }
    if (isdefined(self.e_link)) {
        self.e_link delete();
    }
    self.e_link = spawn(localclientnum, self.origin, "script_model");
    self.e_link setmodel("tag_origin");
    self.e_link.angles = self.angles;
    self.e_link linkto(self);
    self.var_88aec2ed = playfxontag(localclientnum, level._effect[str_fx], self.e_link, "tag_origin");
    self waittill(#"entityshutdown");
    if (isdefined(self.var_88aec2ed)) {
        stopfx(localclientnum, self.var_88aec2ed);
        self.var_88aec2ed = undefined;
    }
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0x1bc5dd66, Offset: 0x2cc0
// Size: 0x84
function function_59e9894a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::init("p7_fxanim_cp_blackstation_tin_roof_panels_01_bundle");
        level thread scene::init("p7_fxanim_cp_blackstation_tin_roof_panels_02_bundle");
    }
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0xbc52ea96, Offset: 0x2d50
// Size: 0x84
function function_db90ecbe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_blackstation_tin_roof_panels_01_bundle");
        level thread scene::play("p7_fxanim_cp_blackstation_tin_roof_panels_02_bundle");
    }
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0x8b4cdd34, Offset: 0x2de0
// Size: 0x64
function function_33d0325b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_blackstation_subway_tiles_bundle");
    }
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0xd2ce386e, Offset: 0x2e50
// Size: 0x124
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
// Params 7, eflags: 0x1 linked
// Checksum 0x31b1e701, Offset: 0x2f80
// Size: 0xce
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
// Checksum 0xf6b4e8ef, Offset: 0x3058
// Size: 0xd0
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
// Checksum 0xab212f62, Offset: 0x3130
// Size: 0xbc
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
// Params 1, eflags: 0x1 linked
// Checksum 0x79104fca, Offset: 0x31f8
// Size: 0x24
function on_player_spawned(localclientnum) {
    filter::function_5c4aeccd(self);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0xf5c32704, Offset: 0x3228
// Size: 0x8c
function function_982d4d35(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self playloopsound("evt_zipline_move", 0.5);
        return;
    }
    self stopallloopsounds(0.5);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0xf643a27c, Offset: 0x32c0
// Size: 0x8c
function function_989f7c26(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self playrumblelooponentity(localclientnum, "tank_rumble");
        return;
    }
    self stoprumble(localclientnum, "tank_rumble");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x1 linked
// Checksum 0x2e290628, Offset: 0x3358
// Size: 0x2fc
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
// Params 2, eflags: 0x1 linked
// Checksum 0x83fc7edb, Offset: 0x3660
// Size: 0x94
function function_a796eb5e(str_objective, var_74cd64bc) {
    level thread function_42c55e18();
    level thread function_9570c674();
    setwavewaterenabled("frogger_water", 0);
    setwavewaterenabled("port_water", 0);
    level scene::init("p7_fxanim_cp_blackstation_qzone_ground_debris_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x1 linked
// Checksum 0x21770523, Offset: 0x3700
// Size: 0x34
function function_40b9b738(str_objective, var_74cd64bc) {
    level thread scene::play("p7_fxanim_gp_lamp_hanging_sin_lamppost_02_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x1 linked
// Checksum 0xc28f310d, Offset: 0x3740
// Size: 0x9c
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
// Params 2, eflags: 0x1 linked
// Checksum 0xfb0b3b5, Offset: 0x37e8
// Size: 0x64
function function_bb306d90(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_42c55e18();
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x1 linked
// Checksum 0x99d1810f, Offset: 0x3858
// Size: 0x7c
function function_4c07b70a(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_42c55e18();
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
    level thread function_3802e537();
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x1 linked
// Checksum 0x8a8691f9, Offset: 0x38e0
// Size: 0x9c
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
// Params 2, eflags: 0x1 linked
// Checksum 0x11672b18, Offset: 0x3988
// Size: 0xe4
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
// Params 2, eflags: 0x1 linked
// Checksum 0x99ac4ae7, Offset: 0x3a78
// Size: 0x234
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
// Params 2, eflags: 0x1 linked
// Checksum 0x2ab16242, Offset: 0x3cb8
// Size: 0x9c
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
// Params 2, eflags: 0x1 linked
// Checksum 0x4c51908, Offset: 0x3d60
// Size: 0xd4
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
// Params 2, eflags: 0x1 linked
// Checksum 0x686c31f6, Offset: 0x3e40
// Size: 0x234
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
// Params 2, eflags: 0x1 linked
// Checksum 0xb0e3c2aa, Offset: 0x4080
// Size: 0x64
function function_ec466e32(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        setwavewaterenabled("frogger_water", 0);
    }
    level thread function_5005007a();
    setwavewaterenabled("port_water", 0);
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x1 linked
// Checksum 0xc80be1a3, Offset: 0x40f0
// Size: 0x84
function function_f3a694a6(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level thread function_5005007a();
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
    level thread scene::play("p7_fxanim_gp_rope_scaffold_01_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x1 linked
// Checksum 0x63d517a4, Offset: 0x4180
// Size: 0x4c
function function_4fbcb062(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x1 linked
// Checksum 0x187a66fa, Offset: 0x41d8
// Size: 0xcc
function function_d96d8db5(str_objective, var_74cd64bc) {
    level thread function_96838a27();
    level thread scene::play("cin_bla_12_01_cross_debris_hanging_shortrope");
    level thread scene::play("cin_bla_12_01_cross_debris_hanging_medrope");
    level thread scene::play("p7_fxanim_gp_wire_sparking_med_thick_bundle");
    level thread scene::play("p7_fxanim_gp_wire_sparking_sml_bundle");
    level thread scene::play("p7_fxanim_gp_rope_scaffold_01_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x1 linked
// Checksum 0x7471d98f, Offset: 0x42b0
// Size: 0x54
function function_4cdd3a9a(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        setwavewaterenabled("port_water", 0);
    }
    setwavewaterenabled("frogger_water", 1);
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x1 linked
// Checksum 0xea9d1968, Offset: 0x4310
// Size: 0x4c
function function_9ba92728(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x1 linked
// Checksum 0xfbdc1974, Offset: 0x4368
// Size: 0x4c
function function_f3ba72a4(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x1 linked
// Checksum 0x99a047c6, Offset: 0x43c0
// Size: 0x34
function function_4d38ae0f(str_objective, var_74cd64bc) {
    level thread scene::stop("p7_fxanim_gp_rope_scaffold_01_bundle", 1);
}

// Namespace cp_mi_sing_blackstation
// Params 2, eflags: 0x1 linked
// Checksum 0xc79d449c, Offset: 0x4400
// Size: 0x15c
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
// Params 2, eflags: 0x1 linked
// Checksum 0xca1fe322, Offset: 0x4568
// Size: 0x4c
function function_6a18d1d4(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        setwavewaterenabled("frogger_water", 0);
        setwavewaterenabled("port_water", 0);
    }
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x1 linked
// Checksum 0xfc48e597, Offset: 0x45c0
// Size: 0x8c
function function_9570c674() {
    level thread scene::play("p7_fxanim_cp_blackstation_medical_divider_01_s5_bundle");
    level thread scene::play("p7_fxanim_cp_blackstation_medical_divider_02_s5_bundle");
    wait 0.016;
    level thread scene::play("p7_fxanim_gp_trash_cardboard_box_04_bundle");
    level thread scene::play("p7_fxanim_gp_trash_cardboard_box_03_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x1 linked
// Checksum 0xdc8609a9, Offset: 0x4658
// Size: 0x164
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
// Params 0, eflags: 0x1 linked
// Checksum 0x539c1279, Offset: 0x47c8
// Size: 0x64
function function_d2829c38() {
    level thread scene::play("p7_fxanim_gp_floating_buoy_02_upright_fast_bundle");
    level thread scene::play("p7_fxanim_gp_floating_buoy_03_roll_bundle");
    level thread scene::play("p7_fxanim_gp_floating_buoy_03_upright_fast_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x1 linked
// Checksum 0xe4163080, Offset: 0x4838
// Size: 0x9c
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
// Params 0, eflags: 0x1 linked
// Checksum 0xffe1adae, Offset: 0x48e0
// Size: 0x44
function function_5005007a() {
    level thread scene::play("p7_fxanim_gp_wire_sparking_sml_bundle");
    level thread scene::play("p7_fxanim_gp_wire_sparking_med_thick_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x1 linked
// Checksum 0xbf11efae, Offset: 0x4930
// Size: 0x44
function function_96838a27() {
    level thread scene::play("p7_fxanim_cp_blackstation_river_debris01_bundle");
    level thread scene::play("p7_fxanim_cp_blackstation_river_debris02_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x1 linked
// Checksum 0xffe11d20, Offset: 0x4980
// Size: 0x24
function function_13a8d1c5() {
    level thread scene::play("blackstation_exterior_shutters");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x1 linked
// Checksum 0x29c95a65, Offset: 0x49b0
// Size: 0x12c
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
// Params 7, eflags: 0x1 linked
// Checksum 0x53f8251e, Offset: 0x4ae8
// Size: 0xec
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
// Params 2, eflags: 0x1 linked
// Checksum 0x37a7b375, Offset: 0x4be0
// Size: 0x6c
function function_fbc6b3e8(localclientnum, str_fx) {
    self endon(#"death");
    self.n_fx_id = playfxoncamera(localclientnum, level._effect[str_fx], (0, 0, 0), (1, 0, 0), (0, 0, 1));
    self thread function_82b37a9c(localclientnum);
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x1 linked
// Checksum 0xad607d3, Offset: 0x4c58
// Size: 0x42
function function_26d7266e(localclientnum) {
    if (isdefined(self.n_fx_id)) {
        stopfx(localclientnum, self.n_fx_id);
    }
    self notify(#"hash_944ec624");
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x1 linked
// Checksum 0x56b681c9, Offset: 0x4ca8
// Size: 0x3c
function function_82b37a9c(localclientnum) {
    self endon(#"hash_944ec624");
    self waittill(#"death");
    self function_26d7266e(localclientnum);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0x55b94807, Offset: 0x4cf0
// Size: 0x7c
function function_c170b293(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("subway_underwater_volumetric");
        return;
    }
    exploder::stop_exploder("subway_underwater_volumetric");
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0x2be3cdd1, Offset: 0x4d78
// Size: 0x7c
function subway_entrance_crash(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        exploder::exploder("subway_entrance_crash");
        return;
    }
    exploder::stop_exploder("subway_entrance_crash");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x1 linked
// Checksum 0x91d5b736, Offset: 0x4e00
// Size: 0x44
function function_6f3570de() {
    level flag::wait_till("building_break");
    level scene::play("p7_fxanim_cp_blackstation_tanker_building_smash_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0x44759ecd, Offset: 0x4e50
// Size: 0x138
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
// Params 7, eflags: 0x1 linked
// Checksum 0x8991963c, Offset: 0x4f90
// Size: 0x6c
function function_fedbe3ab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfxontag(localclientnum, level._effect["water_spash_lrg"], self, "tag_origin");
}

// Namespace cp_mi_sing_blackstation
// Params 1, eflags: 0x1 linked
// Checksum 0x9a46ce0a, Offset: 0x5008
// Size: 0x5c
function function_a3efe3eb(a_ents) {
    a_ents["boat_room_glass"] siegecmd("set_anim", "p7_fxanim_cp_blackstation_boatroom_glass_sanim", "set_shot", "default", "pause", "goto_end");
}

// Namespace cp_mi_sing_blackstation
// Params 0, eflags: 0x1 linked
// Checksum 0x903c2d09, Offset: 0x5070
// Size: 0x522
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
// Params 7, eflags: 0x1 linked
// Checksum 0x3bd60dbf, Offset: 0x55a0
// Size: 0x84
function function_5d2e29ca(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        setdvar("phys_buoyancy", 1);
        return;
    }
    setdvar("phys_buoyancy", 0);
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0x75acf0eb, Offset: 0x5630
// Size: 0x5c
function function_dadc58c3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level scene::play("p7_fxanim_cp_blackstation_qzone_ground_debris_bundle");
}

// Namespace cp_mi_sing_blackstation
// Params 7, eflags: 0x1 linked
// Checksum 0x558a1d02, Offset: 0x5698
// Size: 0x8c
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
// Params 7, eflags: 0x1 linked
// Checksum 0x632d1f1b, Offset: 0x5730
// Size: 0xc4
function function_40788165(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread water_surface::underwaterbegin();
        enablespeedblur(localclientnum, 1, 0.15, 0.9, 0, 100, 100);
        return;
    }
    self thread water_surface::underwaterend();
    disablespeedblur(localclientnum);
}

