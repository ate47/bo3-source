#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_e34d2245;

// Namespace namespace_e34d2245
// Params 0, eflags: 0x2
// Checksum 0x304a131a, Offset: 0x468
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_raygun_mark3", &__init__, undefined, undefined);
}

// Namespace namespace_e34d2245
// Params 0, eflags: 0x0
// Checksum 0xeaa6cf0, Offset: 0x4a8
// Size: 0x2c4
function __init__() {
    level.var_b0d33e26 = getweapon("raygun_mark3");
    level.var_f0cf2cc9 = getweapon("raygun_mark3_upgraded");
    level._effect["raygun_ai_slow_vortex_small"] = "dlc3/stalingrad/fx_raygun_l_projectile_blackhole_sm_hit";
    level._effect["raygun_ai_slow_vortex_large"] = "dlc3/stalingrad/fx_raygun_l_projectile_blackhole_lg_hit";
    level._effect["raygun_slow_vortex_small"] = "dlc3/stalingrad/fx_raygun_l_projectile_blackhole_sm";
    level._effect["raygun_slow_vortex_large"] = "dlc3/stalingrad/fx_raygun_l_projectile_blackhole_lg";
    clientfield::register("scriptmover", "slow_vortex_fx", 12000, 2, "int", &function_7e6d2736, 0, 0);
    clientfield::register("actor", "ai_disintegrate", 12000, 1, "int", &ai_disintegrate, 0, 0);
    clientfield::register("vehicle", "ai_disintegrate", 12000, 1, "int", &ai_disintegrate, 0, 0);
    clientfield::register("actor", "ai_slow_vortex_fx", 12000, 2, "int", &function_ac52bee1, 0, 0);
    clientfield::register("vehicle", "ai_slow_vortex_fx", 12000, 2, "int", &function_ac52bee1, 0, 0);
    visionset_mgr::register_visionset_info("raygun_mark3_vortex_visionset", 1, 30, undefined, "zm_idgun_vortex");
    visionset_mgr::register_overlay_info_style_speed_blur("raygun_mark3_vortex_blur", 1, 30, 0.08, 0.75, 0.9);
    duplicate_render::set_dr_filter_framebuffer("dissolve", 10, "dissolve_on", undefined, 0, "mc/mtl_c_zom_dlc3_zombie_dissolve_base", 0);
    callback::on_localclient_connect(&function_b6be5f5d);
}

// Namespace namespace_e34d2245
// Params 1, eflags: 0x0
// Checksum 0x8322bb81, Offset: 0x778
// Size: 0x34
function function_b08b743e(weapon) {
    if (weapon === level.var_b0d33e26 || weapon === level.var_f0cf2cc9) {
        return true;
    }
    return false;
}

// Namespace namespace_e34d2245
// Params 1, eflags: 0x0
// Checksum 0xe800478a, Offset: 0x7b8
// Size: 0x100
function function_b6be5f5d(var_6575414d) {
    player = getlocalplayer(var_6575414d);
    player endon(#"death");
    while (true) {
        weapon = player waittill(#"weapon_change");
        if (function_b08b743e(weapon)) {
            player mapshaderconstant(var_6575414d, 0, "scriptVector2", 0, 1, 0, 0);
            player thread function_e6f6c7dd(var_6575414d);
            continue;
        }
        player notify(#"hash_e6f6c7dd");
        player mapshaderconstant(var_6575414d, 0, "scriptVector2", 0, 0, 0, 0);
    }
}

// Namespace namespace_e34d2245
// Params 1, eflags: 0x0
// Checksum 0xb9a9b102, Offset: 0x8c0
// Size: 0xc8
function function_e6f6c7dd(var_6575414d) {
    self notify(#"hash_e6f6c7dd");
    self endon(#"hash_e6f6c7dd");
    self endon(#"death");
    while (true) {
        self function_2797cc03("clamps_open");
        self mapshaderconstant(var_6575414d, 0, "scriptVector2", 0, 0, 0, 0);
        self function_2797cc03("clamps_close");
        self mapshaderconstant(var_6575414d, 0, "scriptVector2", 0, 1, 0, 0);
    }
}

// Namespace namespace_e34d2245
// Params 1, eflags: 0x0
// Checksum 0x6f4bed28, Offset: 0x990
// Size: 0x58
function function_2797cc03(str_notetrack) {
    self endon(#"hash_e6f6c7dd");
    self endon(#"death");
    while (true) {
        str_note = self waittill(#"notetrack");
        if (str_note == str_notetrack) {
            return;
        }
    }
}

// Namespace namespace_e34d2245
// Params 7, eflags: 0x0
// Checksum 0x6714f73, Offset: 0x9f0
// Size: 0x134
function function_7e6d2736(var_6575414d, var_a53f7c1b, var_143c4e26, var_f16ed138, var_406ad39b, str_field, var_ffbb7dc) {
    if (isdefined(self.var_591fb640)) {
        killfx(var_6575414d, self.var_591fb640);
    }
    if (var_143c4e26) {
        if (var_143c4e26 == 1) {
            self.var_591fb640 = playfxontag(var_6575414d, level._effect["raygun_slow_vortex_small"], self, "tag_origin");
        } else {
            self.var_591fb640 = playfxontag(var_6575414d, level._effect["raygun_slow_vortex_large"], self, "tag_origin");
            self playrumbleonentity(var_6575414d, "artillery_rumble");
        }
        self thread vortex_shake_and_rumble(var_6575414d, var_143c4e26);
    }
}

// Namespace namespace_e34d2245
// Params 7, eflags: 0x0
// Checksum 0x71253cc3, Offset: 0xb30
// Size: 0x154
function function_ac52bee1(var_6575414d, var_a53f7c1b, var_143c4e26, var_f16ed138, var_406ad39b, str_field, var_ffbb7dc) {
    if (var_143c4e26) {
        if (var_143c4e26 == 1) {
            self.var_3776f8a3 = playfxontag(var_6575414d, level._effect["raygun_ai_slow_vortex_small"], self, "J_SpineUpper");
            self thread function_cfe69f7a(var_6575414d, 1);
        } else {
            self.var_3776f8a3 = playfxontag(var_6575414d, level._effect["raygun_ai_slow_vortex_large"], self, "J_SpineUpper");
            self thread function_cfe69f7a(var_6575414d, 1);
        }
        return;
    }
    if (isdefined(self.var_3776f8a3)) {
        killfx(var_6575414d, self.var_3776f8a3);
        self thread function_cfe69f7a(var_6575414d, 0);
    }
}

// Namespace namespace_e34d2245
// Params 2, eflags: 0x0
// Checksum 0xe0070e9f, Offset: 0xc90
// Size: 0xa0
function vortex_shake_and_rumble(var_6575414d, var_fbdacb94) {
    self notify(#"vortex_shake_and_rumble");
    self endon(#"vortex_shake_and_rumble");
    self endon(#"entity_shutdown");
    if (var_fbdacb94 == 1) {
        str_rumble = "raygun_mark3_vortex_sm";
    } else {
        str_rumble = "raygun_mark3_vortex_lg";
    }
    while (isdefined(self)) {
        self playrumbleonentity(var_6575414d, str_rumble);
        wait(0.083);
    }
}

// Namespace namespace_e34d2245
// Params 2, eflags: 0x0
// Checksum 0x921731ec, Offset: 0xd38
// Size: 0x120
function function_cfe69f7a(var_6575414d, var_dfd13974) {
    self endon(#"entity_shutdown");
    if (!isdefined(self.var_67fc1a58)) {
        self.var_67fc1a58 = 0;
    }
    if (var_dfd13974) {
        while (isdefined(self) && self.var_67fc1a58 < 1) {
            self.var_67fc1a58 += 0.2;
            self mapshaderconstant(var_6575414d, 0, "scriptVector0", self.var_67fc1a58);
            wait(0.05);
        }
        return;
    }
    while (isdefined(self) && self.var_67fc1a58 > 0) {
        self.var_67fc1a58 -= 0.2;
        self mapshaderconstant(var_6575414d, 0, "scriptVector0", self.var_67fc1a58);
        wait(0.05);
    }
}

// Namespace namespace_e34d2245
// Params 7, eflags: 0x0
// Checksum 0xfc9f7296, Offset: 0xe60
// Size: 0x124
function ai_disintegrate(var_6575414d, var_a53f7c1b, var_143c4e26, var_f16ed138, var_406ad39b, str_field, var_ffbb7dc) {
    self endon(#"entity_shutdown");
    self duplicate_render::set_dr_flag("dissolve_on", var_143c4e26);
    self duplicate_render::update_dr_filters(var_6575414d);
    self.var_c7c18751 = 1;
    while (isdefined(self) && self.var_c7c18751 > 0) {
        self mapshaderconstant(var_6575414d, 0, "scriptVector0", self.var_c7c18751);
        self.var_c7c18751 -= 0.0166;
        wait(0.0166);
    }
    if (isdefined(self)) {
        self mapshaderconstant(var_6575414d, 0, "scriptVector0", 0);
    }
}

