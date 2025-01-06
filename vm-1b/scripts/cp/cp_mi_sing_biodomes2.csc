#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/cp_mi_sing_biodomes2_fx;
#using scripts/cp/cp_mi_sing_biodomes2_sound;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_sing_biodomes2;

// Namespace cp_mi_sing_biodomes2
// Params 0, eflags: 0x0
// Checksum 0x9e4c3fb8, Offset: 0x618
// Size: 0x52
function main() {
    function_b37230e4();
    cp_mi_sing_biodomes2_fx::main();
    cp_mi_sing_biodomes2_sound::main();
    load::main();
    util::waitforclient(0);
}

// Namespace cp_mi_sing_biodomes2
// Params 0, eflags: 0x0
// Checksum 0x355b6b4b, Offset: 0x678
// Size: 0x50a
function function_b37230e4() {
    clientfield::register("toplayer", "zipline_rumble_loop", 1, 1, "int", &function_85392f32, 0, 0);
    clientfield::register("toplayer", "dive_wind_rumble_loop", 1, 1, "int", &function_fdbd490e, 0, 0);
    clientfield::register("toplayer", "set_underwater_fx", 1, 1, "int", &function_16baac7c, 0, 0);
    clientfield::register("toplayer", "sound_evt_boat_rattle", 1, 1, "counter", &sound_evt_boat_rattle, 0, 0);
    clientfield::register("toplayer", "supertree_jump_debris_play", 1, 1, "int", &supertree_jump_debris_play, 0, 0);
    clientfield::register("toplayer", "zipline_speed_blur", 1, 1, "int", &zipline_speed_blur, 0, 0);
    clientfield::register("world", "boat_explosion_play", 1, 1, "int", &boat_explosion_play, 0, 0);
    clientfield::register("world", "elevator_top_debris_play", 1, 1, "int", &elevator_top_debris_play, 0, 0);
    clientfield::register("world", "elevator_bottom_debris_play", 1, 1, "int", &elevator_bottom_debris_play, 0, 0);
    clientfield::register("world", "tall_grass_init", 1, 1, "int", &function_e4cf15f9, 0, 0);
    clientfield::register("world", "tall_grass_play", 1, 1, "int", &function_17337465, 0, 0);
    clientfield::register("world", "supertree_fall_init", 1, 1, "counter", &function_ac881e7, 0, 0);
    clientfield::register("world", "supertree_fall_play", 1, 1, "counter", &function_339650bb, 0, 0);
    clientfield::register("world", "ferriswheel_fall_play", 1, 1, "int", &function_221ecea4, 0, 0);
    clientfield::register("vehicle", "boat_disable_sfx", 1, 1, "int", &function_c2c3fb69, 0, 0);
    clientfield::register("vehicle", "sound_evt_boat_scrape_impact", 1, 1, "counter", &sound_evt_boat_scrape_impact, 0, 0);
    clientfield::register("vehicle", "sound_veh_airboat_jump", 1, 1, "counter", &sound_veh_airboat_jump, 0, 0);
    clientfield::register("vehicle", "sound_veh_airboat_jump_air", 1, 1, "counter", &sound_veh_airboat_jump_air, 0, 0);
    clientfield::register("vehicle", "sound_veh_airboat_land", 1, 1, "counter", &sound_veh_airboat_land, 0, 0);
    clientfield::register("vehicle", "sound_veh_airboat_ramp_hit", 1, 1, "counter", &sound_veh_airboat_ramp_hit, 0, 0);
    clientfield::register("vehicle", "sound_veh_airboat_start", 1, 1, "counter", &sound_veh_airboat_start, 0, 0);
    clientfield::register("allplayers", "zipline_sound_loop", 1, 1, "int", &function_982d4d35, 0, 0);
    clientfield::register("scriptmover", "clone_control", 1, 1, "int", &function_d7b78660, 0, 0);
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0xbe8294f3, Offset: 0xb90
// Size: 0x52
function sound_evt_boat_rattle(var_6575414d, var_d5fa7963, var_3a04fa7e, var_3a8c4f80, var_406ad39b, str_field, var_a5d31326) {
    self playsound(var_6575414d, "evt_boat_rattle");
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0xbee402ae, Offset: 0xbf0
// Size: 0x52
function sound_evt_boat_scrape_impact(var_6575414d, var_d5fa7963, var_3a04fa7e, var_3a8c4f80, var_406ad39b, str_field, var_a5d31326) {
    self playsound(var_6575414d, "evt_boat_scrape_impact");
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0xd5accae7, Offset: 0xc50
// Size: 0x52
function sound_veh_airboat_jump(var_6575414d, var_d5fa7963, var_3a04fa7e, var_3a8c4f80, var_406ad39b, str_field, var_a5d31326) {
    self playsound(var_6575414d, "veh_airboat_jump");
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0xb3136ff4, Offset: 0xcb0
// Size: 0x52
function sound_veh_airboat_jump_air(var_6575414d, var_d5fa7963, var_3a04fa7e, var_3a8c4f80, var_406ad39b, str_field, var_a5d31326) {
    self playsound(var_6575414d, "veh_airboat_jump_air");
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0xcc321039, Offset: 0xd10
// Size: 0x52
function sound_veh_airboat_land(var_6575414d, var_d5fa7963, var_3a04fa7e, var_3a8c4f80, var_406ad39b, str_field, var_a5d31326) {
    self playsound(var_6575414d, "veh_airboat_land");
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x3ccfb83a, Offset: 0xd70
// Size: 0x52
function sound_veh_airboat_ramp_hit(var_6575414d, var_d5fa7963, var_3a04fa7e, var_3a8c4f80, var_406ad39b, str_field, var_a5d31326) {
    self playsound(var_6575414d, "veh_airboat_ramp_hit");
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x6b79d55b, Offset: 0xdd0
// Size: 0x52
function sound_veh_airboat_start(var_6575414d, var_d5fa7963, var_3a04fa7e, var_3a8c4f80, var_406ad39b, str_field, var_a5d31326) {
    self playsound(var_6575414d, "veh_airboat_start");
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x88adb7ce, Offset: 0xe30
// Size: 0x82
function zipline_speed_blur(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        enablespeedblur(localclientnum, 0.07, 0.55, 0.9, 0, 100, 100);
        return;
    }
    disablespeedblur(localclientnum);
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x3ede3e57, Offset: 0xec0
// Size: 0x52
function boat_explosion_play(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_biodomes_boat_explosion_debris_bundle");
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x610cfab0, Offset: 0xf20
// Size: 0x52
function elevator_top_debris_play(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_biodomes_cafe_roof_01_bundle");
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x72300125, Offset: 0xf80
// Size: 0x52
function elevator_bottom_debris_play(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_biodomes_cafe_roof_02_bundle");
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x2ca3b7fd, Offset: 0xfe0
// Size: 0x52
function supertree_jump_debris_play(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_biodomes_super_tree_jump_01_bundle");
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x28cd54c0, Offset: 0x1040
// Size: 0x52
function function_e4cf15f9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::init("p7_fxanim_cp_biodomes_boat_grass_bundle");
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0xdb382279, Offset: 0x10a0
// Size: 0x52
function function_17337465(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_biodomes_boat_grass_bundle");
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0xe70e0161, Offset: 0x1100
// Size: 0x52
function function_ac881e7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::init("p7_fxanim_cp_biodomes_super_tree_collapse_bundle");
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x839c791e, Offset: 0x1160
// Size: 0x6a
function function_339650bb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_biodomes_super_tree_collapse_bundle");
        level thread scene::play("p7_fxanim_cp_biodomes_super_tree_collapse_catwalk_bundle");
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x74041eb3, Offset: 0x11d8
// Size: 0x52
function function_221ecea4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        level thread scene::play("p7_fxanim_cp_biodomes_ferris_wheel_bundle");
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0xc529c6a0, Offset: 0x1238
// Size: 0x62
function function_c2c3fb69(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self disablevehiclesounds();
        return;
    }
    self enablevehiclesounds();
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x4d1ce14e, Offset: 0x12a8
// Size: 0x7a
function function_85392f32(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self playrumblelooponentity(localclientnum, "cp_biodomes_zipline_loop_rumble");
        return;
    }
    self stoprumble(localclientnum, "cp_biodomes_zipline_loop_rumble");
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x1270d555, Offset: 0x1330
// Size: 0x7a
function function_982d4d35(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self playloopsound("evt_zipline_move", 0.5);
        return;
    }
    self stopallloopsounds(0.5);
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x7fb9731f, Offset: 0x13b8
// Size: 0x7a
function function_fdbd490e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self playrumblelooponentity(localclientnum, "fallwind_loop_rapid");
        return;
    }
    self stoprumble(localclientnum, "fallwind_loop_rapid");
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x46c04778, Offset: 0x1440
// Size: 0x132
function function_16baac7c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setlitfogbank(localclientnum, -1, 1, 1);
        setworldfogactivebank(localclientnum, 2);
        if (isdefined(self.n_fx_id)) {
            deletefx(localclientnum, self.n_fx_id, 1);
        }
        self.n_fx_id = playfxoncamera(localclientnum, level._effect["underwater_motes"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        exploder::exploder("exp_underwater_lights");
        return;
    }
    setlitfogbank(localclientnum, -1, 0, 1);
    setworldfogactivebank(localclientnum, 1);
    if (isdefined(self.n_fx_id)) {
        deletefx(localclientnum, self.n_fx_id, 1);
    }
    exploder::kill_exploder("exp_underwater_lights");
}

// Namespace cp_mi_sing_biodomes2
// Params 7, eflags: 0x0
// Checksum 0x329869bc, Offset: 0x1580
// Size: 0x72
function function_d7b78660(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (self.owner == getlocalplayer(localclientnum)) {
            self thread function_6ec31df1(localclientnum);
        }
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 1, eflags: 0x0
// Checksum 0xf7112add, Offset: 0x1600
// Size: 0xbd
function function_6ec31df1(localclientnum) {
    self endon(#"entityshutdown");
    while (true) {
        if (self clientfield::get("clone_control")) {
            player = getlocalplayer(localclientnum);
            if (isdefined(player)) {
                if (isthirdperson(localclientnum)) {
                    self show();
                    player hide();
                } else {
                    player show();
                    self hide();
                }
            }
        }
        wait 0.016;
    }
}

