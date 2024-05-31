#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/postfx_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_c93e4c32;

// Namespace namespace_c93e4c32
// Params 0, eflags: 0x1 linked
// Checksum 0x865b57d3, Offset: 0x340
// Size: 0x7a
function main() {
    register_clientfields();
    duplicate_render::set_dr_filter_framebuffer("zod_ghost", 90, "zod_ghost", undefined, 0, "mc/hud_zod_ghost", 0);
    level._effect["plunger_charge_1p"] = "dlc1/zmb_weapon/fx_ee_plunger_trail_1p";
    level._effect["plunger_charge_3p"] = "dlc1/zmb_weapon/fx_ee_plunger_trail_3p";
}

// Namespace namespace_c93e4c32
// Params 0, eflags: 0x1 linked
// Checksum 0x12d87735, Offset: 0x3c8
// Size: 0x264
function register_clientfields() {
    n_bits = getminbitcountfornum(4);
    clientfield::register("toplayer", "player_ee_cs_circle", 5000, n_bits, "int", &function_2a1f20f9, 0, 0);
    clientfield::register("actor", "ghost_actor", 1, 1, "int", &function_b48f294, 0, 0);
    clientfield::register("scriptmover", "channeling_stone_glow", 5000, 2, "int", &function_e23bc630, 0, 0);
    clientfield::register("world", "flip_skybox", 5000, 1, "int", &flip_skybox, 0, 0);
    clientfield::register("scriptmover", "pod_monitor_enable", 5000, 1, "int", &function_3c1114e8, 0, 0);
    clientfield::register("world", "sndDeathRayToMoon", 5000, 1, "int", &function_2145e814, 0, 0);
    clientfield::register("toplayer", "outro_lighting_banks", 5000, 1, "int", &function_12c888d5, 0, 0);
    clientfield::register("toplayer", "moon_explosion_bank", 5000, 1, "int", &function_890770df, 0, 0);
}

// Namespace namespace_c93e4c32
// Params 7, eflags: 0x1 linked
// Checksum 0xff6ca0c8, Offset: 0x638
// Size: 0x74
function function_b48f294(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self duplicate_render::set_dr_flag("zod_ghost", newval);
    self duplicate_render::update_dr_filters(localclientnum);
}

// Namespace namespace_c93e4c32
// Params 7, eflags: 0x1 linked
// Checksum 0x3c4c1426, Offset: 0x6b8
// Size: 0x1ac
function function_2a1f20f9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread postfx::playpostfxbundle("pstfx_arrow_demongate");
        playsound(0, "zmb_ee_resurrect_enter_circle", (0, 0, 0));
        return;
    }
    if (newval == 2) {
        self thread postfx::playpostfxbundle("pstfx_arrow_rune");
        playsound(0, "zmb_ee_resurrect_enter_circle", (0, 0, 0));
        return;
    }
    if (newval == 3) {
        self thread postfx::playpostfxbundle("pstfx_arrow_elemental");
        playsound(0, "zmb_ee_resurrect_enter_circle", (0, 0, 0));
        return;
    }
    if (newval == 4) {
        self thread postfx::playpostfxbundle("pstfx_arrow_wolf");
        playsound(0, "zmb_ee_resurrect_enter_circle", (0, 0, 0));
        return;
    }
    self thread postfx::stoppostfxbundle();
    playsound(0, "zmb_ee_resurrect_leave_circle", (0, 0, 0));
}

// Namespace namespace_c93e4c32
// Params 7, eflags: 0x1 linked
// Checksum 0xdcf41dcb, Offset: 0x870
// Size: 0x23c
function function_e23bc630(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self notify(#"hash_a1e4f5f1");
    self endon(#"hash_a1e4f5f1");
    if (newval == 1) {
        n_start_time = gettime();
        var_b1382f05 = n_start_time + 0.85 * 1000;
        var_c8a6e70a = 0;
        var_2be3abbd = 1;
        n_shader_value = 0;
        while (true) {
            n_time = gettime();
            if (n_time >= var_b1382f05) {
                n_start_time = gettime();
                var_b1382f05 = n_start_time + 0.85 * 1000;
                var_c8a6e70a = n_shader_value;
                var_2be3abbd = var_2be3abbd == 1 ? 0 : 1;
            }
            n_shader_value = mapfloat(n_start_time, var_b1382f05, var_c8a6e70a, var_2be3abbd, n_time);
            self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
            wait(0.01);
        }
        return;
    }
    if (newval == 2) {
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 0);
        return;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0);
}

// Namespace namespace_c93e4c32
// Params 7, eflags: 0x1 linked
// Checksum 0x3386fe12, Offset: 0xab8
// Size: 0x64
function function_3c1114e8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, newval, 0);
}

// Namespace namespace_c93e4c32
// Params 7, eflags: 0x1 linked
// Checksum 0xad443d69, Offset: 0xb28
// Size: 0x64
function flip_skybox(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setdvar("r_skyTransition", 1);
    }
}

// Namespace namespace_c93e4c32
// Params 7, eflags: 0x1 linked
// Checksum 0x72fdfad2, Offset: 0xb98
// Size: 0xfc
function function_2145e814(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playsound(0, "zmb_ee_rocketcrash_ray_start", (-271, 2196, 1338));
        wait(0.05);
        playsound(0, "zmb_ee_rocketcrash_ray_start", (552, 2201, 1344));
        return;
    }
    playsound(0, "zmb_ee_rocketcrash_ray_end", (-271, 2196, 1348));
    wait(0.05);
    playsound(0, "zmb_ee_rocketcrash_ray_end", (552, 2201, 1344));
}

// Namespace namespace_c93e4c32
// Params 7, eflags: 0x1 linked
// Checksum 0x9518b936, Offset: 0xca0
// Size: 0xb4
function function_12c888d5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setpbgactivebank(localclientnum, 2);
        setexposureactivebank(localclientnum, 2);
        return;
    }
    setpbgactivebank(localclientnum, 1);
    setexposureactivebank(localclientnum, 1);
}

// Namespace namespace_c93e4c32
// Params 7, eflags: 0x1 linked
// Checksum 0xda5e6685, Offset: 0xd60
// Size: 0x84
function function_890770df(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setexposureactivebank(localclientnum, 4);
        return;
    }
    setexposureactivebank(localclientnum, 1);
}

