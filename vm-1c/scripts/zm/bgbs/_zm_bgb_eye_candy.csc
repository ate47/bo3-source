#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_128a1bda;

// Namespace namespace_128a1bda
// Params 0, eflags: 0x2
// Checksum 0xb32c977, Offset: 0x418
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_eye_candy", &__init__, undefined, undefined);
}

// Namespace namespace_128a1bda
// Params 0, eflags: 0x1 linked
// Checksum 0x3a707045, Offset: 0x458
// Size: 0x334
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_eye_candy", "activated");
    visionset_mgr::register_visionset_info("zm_bgb_eye_candy_vs_1", 21000, 31, undefined, "zm_bgb_candy_yellowz");
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_bgb_eye_candy_vs_1", 21000, 1, "pstfx_zm_bgb_eye_candy_yellow");
    duplicate_render::set_dr_filter_framebuffer("e_c_1", 35, "eye_candy_1", undefined, 0, "mc/zombie_candy_mode_yellow", 0);
    visionset_mgr::register_visionset_info("zm_bgb_eye_candy_vs_2", 21000, 31, undefined, "zm_bgb_candy_greenz");
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_bgb_eye_candy_vs_2", 21000, 1, "pstfx_zm_bgb_eye_candy_green");
    duplicate_render::set_dr_filter_framebuffer("e_c_2", 35, "eye_candy_2", undefined, 0, "mc/zombie_candy_mode_green", 0);
    visionset_mgr::register_visionset_info("zm_bgb_eye_candy_vs_3", 21000, 31, undefined, "zm_bgb_candy_purplez");
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_bgb_eye_candy_vs_3", 21000, 1, "pstfx_zm_bgb_eye_candy_purple");
    duplicate_render::set_dr_filter_framebuffer("e_c_3", 35, "eye_candy_3", undefined, 0, "mc/zombie_candy_mode_purple", 0);
    visionset_mgr::register_visionset_info("zm_bgb_eye_candy_vs_4", 21000, 31, undefined, "zm_bgb_candy_bluez");
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_bgb_eye_candy_vs_4", 21000, 1, "pstfx_zm_bgb_eye_candy_blue");
    duplicate_render::set_dr_filter_framebuffer("e_c_4", 35, "eye_candy_4", undefined, 0, "mc/zombie_candy_mode_blue", 0);
    n_bits = getminbitcountfornum(5);
    clientfield::register("toplayer", "eye_candy_render", 21000, n_bits, "int", &function_7021da92, 0, 0);
    clientfield::register("actor", "eye_candy_active", 21000, 1, "int", &function_697cc62, 0, 0);
    clientfield::register("vehicle", "eye_candy_active", 21000, 1, "int", &function_697cc62, 0, 0);
}

// Namespace namespace_128a1bda
// Params 7, eflags: 0x1 linked
// Checksum 0x84ac0683, Offset: 0x798
// Size: 0x94
function function_7021da92(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval > 0) {
        self.var_73021e86 = "eye_candy_" + newval;
        self function_a358ec33(localclientnum);
        return;
    }
    self function_c1a20a24(localclientnum);
}

// Namespace namespace_128a1bda
// Params 1, eflags: 0x1 linked
// Checksum 0xd4bee5d, Offset: 0x838
// Size: 0xfa
function function_a358ec33(localclientnum) {
    var_307a62d0 = getentarray(localclientnum);
    foreach (entity in var_307a62d0) {
        if (isdefined(entity.var_d8bd114f) && entity.var_d8bd114f && isdefined(self.var_73021e86)) {
            entity function_56029f33(localclientnum, 1, self.var_73021e86);
        }
    }
}

// Namespace namespace_128a1bda
// Params 1, eflags: 0x1 linked
// Checksum 0xb88f3161, Offset: 0x940
// Size: 0xea
function function_c1a20a24(localclientnum) {
    var_307a62d0 = getentarray(localclientnum);
    foreach (entity in var_307a62d0) {
        if (isdefined(entity.var_d8bd114f) && entity.var_d8bd114f) {
            entity function_56029f33(localclientnum, 0);
        }
    }
    self.var_73021e86 = undefined;
}

// Namespace namespace_128a1bda
// Params 7, eflags: 0x1 linked
// Checksum 0x722d2435, Offset: 0xa38
// Size: 0x124
function function_697cc62(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    level flagsys::wait_till("duplicaterender_registry_ready");
    assert(isdefined(self), "zm_bgb_candy_greenz");
    if (newval == 0) {
        self.var_d8bd114f = 0;
        self function_56029f33(localclientnum, 0);
        return;
    }
    self.var_d8bd114f = 1;
    player = getlocalplayer(localclientnum);
    if (isdefined(player.var_73021e86)) {
        self function_56029f33(localclientnum, 1, player.var_73021e86);
    }
}

// Namespace namespace_128a1bda
// Params 3, eflags: 0x1 linked
// Checksum 0x743fdb2f, Offset: 0xb68
// Size: 0xac
function function_56029f33(localclientnum, b_enabled, var_73021e86) {
    if (isdefined(self.var_73021e86)) {
        self duplicate_render::set_dr_flag(self.var_73021e86, 0);
        self.var_73021e86 = undefined;
    }
    if (isdefined(b_enabled) && b_enabled && isdefined(var_73021e86)) {
        self duplicate_render::set_dr_flag(var_73021e86, 1);
        self.var_73021e86 = var_73021e86;
    }
    self duplicate_render::update_dr_filters(localclientnum);
}

