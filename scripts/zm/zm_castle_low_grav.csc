#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/postfx_shared;
#using scripts/codescripts/struct;

#namespace namespace_8e89abe3;

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x0
// Checksum 0x7987337, Offset: 0x330
// Size: 0x84
function main() {
    register_clientfields();
    level.var_51541120 = [];
    level._effect["low_grav_player_jump"] = "dlc1/castle/fx_plyr_115_liquid_trail";
    level._effect["low_grav_screen_fx"] = "dlc1/castle/fx_plyr_screen_115_liquid";
    level._effect["wall_dust"] = "dlc1/castle/fx_zombie_spawn_wallrun_castle";
    level thread function_554db684();
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x0
// Checksum 0xdeca780d, Offset: 0x3c0
// Size: 0x1fc
function register_clientfields() {
    clientfield::register("scriptmover", "low_grav_powerup_triggered", 5000, 1, "counter", &function_69e96b4d, 0, 0);
    clientfield::register("scriptmover", "zombie_wall_dust", 5000, 1, "counter", &function_c9ee5588, 0, 0);
    clientfield::register("toplayer", "player_postfx", 5000, 1, "int", &function_df81c23d, 0, 0);
    clientfield::register("toplayer", "player_screen_fx", 5000, 1, "int", &function_e6fd161a, 0, 1);
    clientfield::register("scriptmover", "undercroft_emissives", 5000, 1, "int", &function_9a8a19ab, 0, 0);
    clientfield::register("scriptmover", "undercroft_wall_panel_shutdown", 5000, 1, "counter", &mm_katana_male_runjump_land_1f_l, 0, 0);
    clientfield::register("scriptmover", "floor_panel_emissives_glow", 5000, 1, "int", &function_23861dfe, 0, 0);
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x0
// Checksum 0x1d968c68, Offset: 0x5c8
// Size: 0xdc
function function_554db684() {
    setdvar("wallrun_enabled", 1);
    setdvar("doublejump_enabled", 1);
    setdvar("playerEnergy_enabled", 1);
    setdvar("bg_lowGravity", 300);
    setdvar("wallRun_maxTimeMs_zm", 10000);
    setdvar("playerEnergy_maxReserve_zm", -56);
    setdvar("wallRun_peakTest_zm", 0);
}

// Namespace namespace_8e89abe3
// Params 7, eflags: 0x0
// Checksum 0xcbabf263, Offset: 0x6b0
// Size: 0x64
function function_69e96b4d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playsound(0, "zmb_cha_ching", self.origin);
}

// Namespace namespace_8e89abe3
// Params 7, eflags: 0x0
// Checksum 0xa74dd69c, Offset: 0x720
// Size: 0x6c
function function_c9ee5588(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, level._effect["wall_dust"], self.origin);
}

// Namespace namespace_8e89abe3
// Params 7, eflags: 0x0
// Checksum 0x411c80d6, Offset: 0x798
// Size: 0xfc
function function_e6fd161a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (isdefined(level.var_51541120[localclientnum])) {
            deletefx(localclientnum, level.var_51541120[localclientnum], 1);
        }
        level.var_51541120[localclientnum] = playfxoncamera(localclientnum, level._effect["low_grav_screen_fx"]);
        return;
    }
    if (isdefined(level.var_51541120[localclientnum])) {
        deletefx(localclientnum, level.var_51541120[localclientnum], 1);
    }
}

// Namespace namespace_8e89abe3
// Params 7, eflags: 0x0
// Checksum 0xee657748, Offset: 0x8a0
// Size: 0xbc
function function_df81c23d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setpbgactivebank(localclientnum, 2);
        self thread postfx::playpostfxbundle("pstfx_115_castle_loop");
        return;
    }
    setpbgactivebank(localclientnum, 1);
    self thread postfx::exitpostfxbundle();
}

// Namespace namespace_8e89abe3
// Params 7, eflags: 0x0
// Checksum 0xc106ec90, Offset: 0x968
// Size: 0x278
function function_9a8a19ab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self notify(#"hash_67a9e087");
    self endon(#"hash_67a9e087");
    if (newval == 1) {
        n_start_time = gettime();
        n_end_time = n_start_time + 1 * 1000;
        b_is_updating = 1;
        while (b_is_updating) {
            n_time = gettime();
            if (n_time >= n_end_time) {
                n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_end_time);
                b_is_updating = 0;
            } else {
                n_shader_value = mapfloat(n_start_time, n_end_time, 0, 1, n_time);
            }
            self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
            wait(0.01);
        }
        return;
    }
    n_start_time = gettime();
    n_end_time = n_start_time + 2 * 1000;
    b_is_updating = 1;
    while (b_is_updating) {
        n_time = gettime();
        if (n_time >= n_end_time) {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_end_time);
            b_is_updating = 0;
        } else {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
        wait(0.01);
    }
}

// Namespace namespace_8e89abe3
// Params 7, eflags: 0x0
// Checksum 0x1b95a9c8, Offset: 0xbe8
// Size: 0x188
function mm_katana_male_runjump_land_1f_l(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self notify(#"hash_67a9e087");
    self endon(#"hash_67a9e087");
    n_start_time = gettime();
    n_end_time = n_start_time + 1 * 1000;
    b_is_updating = 1;
    while (b_is_updating) {
        n_time = gettime();
        if (n_time >= n_end_time) {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_end_time);
            b_is_updating = 0;
        } else {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0, n_time);
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
        wait(0.01);
    }
}

// Namespace namespace_8e89abe3
// Params 7, eflags: 0x0
// Checksum 0x95efa40, Offset: 0xd78
// Size: 0x288
function function_23861dfe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self notify(#"hash_67a9e087");
    self endon(#"hash_67a9e087");
    if (newval == 1) {
        n_start_time = gettime();
        n_end_time = n_start_time + 1 * 1000;
        b_is_updating = 1;
        while (b_is_updating) {
            n_time = gettime();
            if (n_time >= n_end_time) {
                n_shader_value = mapfloat(n_start_time, n_end_time, 0.3, 1, n_end_time);
                b_is_updating = 0;
            } else {
                n_shader_value = mapfloat(n_start_time, n_end_time, 0.3, 1, n_time);
            }
            self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
            wait(0.01);
        }
        return;
    }
    n_start_time = gettime();
    n_end_time = n_start_time + 2 * 1000;
    b_is_updating = 1;
    while (b_is_updating) {
        n_time = gettime();
        if (n_time >= n_end_time) {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0.3, n_end_time);
            b_is_updating = 0;
        } else {
            n_shader_value = mapfloat(n_start_time, n_end_time, 1, 0.3, n_time);
        }
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, n_shader_value, 0);
        wait(0.01);
    }
}

// Namespace namespace_8e89abe3
// Params 7, eflags: 0x0
// Checksum 0x8b05507f, Offset: 0x1008
// Size: 0xa4
function function_a81107fc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!isdefined(newval)) {
        return;
    }
    if (newval) {
        fxobj = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
        fxobj thread function_10dcbf51(localclientnum, fxobj);
    }
}

// Namespace namespace_8e89abe3
// Params 2, eflags: 0x4
// Checksum 0x76ac8a47, Offset: 0x10b8
// Size: 0x54
function private function_10dcbf51(localclientnum, fxobj) {
    fxobj playsound(localclientnum, "evt_ai_explode");
    wait(1);
    fxobj delete();
}

