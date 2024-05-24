#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_fa1b0620;

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x2
// Checksum 0x513ef45d, Offset: 0x3e0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_castle_teleporter", &__init__, undefined, undefined);
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0x5814976e, Offset: 0x420
// Size: 0x20c
function __init__() {
    visionset_mgr::register_overlay_info_style_transported("zm_castle", 1, 15, 2);
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_factory_teleport", 5000, 1, "pstfx_zm_castle_teleport");
    level thread function_29d1f2fd();
    level thread function_c8f25330();
    level thread function_80009f4();
    level._effect["ee_quest_time_travel_ready"] = "dlc1/castle/fx_demon_gate_rune_glow";
    duplicate_render::set_dr_filter_framebuffer("flashback", 90, "flashback_on", "", 0, "mc/mtl_glitch", 0);
    clientfield::register("world", "ee_quest_time_travel_ready", 5000, 1, "int", &function_ddac47c8, 0, 0);
    clientfield::register("toplayer", "ee_quest_back_in_time_teleport_fx", 5000, 1, "int", &function_f5cfa4d7, 0, 0);
    clientfield::register("toplayer", "ee_quest_back_in_time_postfx", 5000, 1, "int", &function_aa99fd7b, 0, 0);
    clientfield::register("toplayer", "ee_quest_back_in_time_sfx", 5000, 1, "int", &function_a932c4c, 0, 0);
}

// Namespace namespace_fa1b0620
// Params 7, eflags: 0x0
// Checksum 0x9f36df67, Offset: 0x638
// Size: 0x9c
function function_f5cfa4d7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!oldval || !isdemoplaying()) {
            self thread postfx::playpostfxbundle("pstfx_zm_wormhole");
        }
        return;
    }
    self postfx::exitpostfxbundle();
}

// Namespace namespace_fa1b0620
// Params 7, eflags: 0x0
// Checksum 0x8cd1628c, Offset: 0x6e0
// Size: 0xd4
function function_aa99fd7b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!oldval || !isdemoplaying()) {
            self thread postfx::playpostfxbundle("pstfx_backintime");
        }
    } else {
        self postfx::exitpostfxbundle();
    }
    self duplicate_render::set_dr_flag("flashback_on", newval);
    self duplicate_render::update_dr_filters(localclientnum);
}

// Namespace namespace_fa1b0620
// Params 7, eflags: 0x0
// Checksum 0xf96b8119, Offset: 0x7c0
// Size: 0x10a
function function_a932c4c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        playsound(0, "zmb_ee_timetravel_start", (0, 0, 0));
        self.var_6e4d8282 = self playloopsound("zmb_ee_timetravel_lp", 3);
        level notify(#"hash_51d7bc7c", "null");
        return;
    }
    if (isdefined(self.var_6e4d8282)) {
        self stoploopsound(self.var_6e4d8282, 1);
        playsound(0, "zmb_ee_timetravel_end", (0, 0, 0));
        level notify(#"hash_51d7bc7c", "rocket");
    }
}

// Namespace namespace_fa1b0620
// Params 7, eflags: 0x0
// Checksum 0x8ac53d21, Offset: 0x8d8
// Size: 0xf2
function function_ddac47c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_55ff1a9f = struct::get_array("teleport_pad_center_effect", "targetname");
    foreach (var_f92e157f in var_55ff1a9f) {
        var_f92e157f thread function_74eb9e6a(localclientnum, newval);
    }
}

// Namespace namespace_fa1b0620
// Params 2, eflags: 0x0
// Checksum 0x185eb609, Offset: 0x9d8
// Size: 0xd4
function function_74eb9e6a(localclientnum, newval) {
    if (newval == 1) {
        self.var_83ef00ec = playfx(localclientnum, level._effect["ee_quest_time_travel_ready"], self.origin);
        audio::playloopat("zmb_ee_timetravel_tele_lp", self.origin);
        return;
    }
    if (isdefined(self.var_83ef00ec)) {
        stopfx(localclientnum, self.var_83ef00ec);
        self.var_83ef00ec = undefined;
    }
    audio::stoploopat("zmb_ee_timetravel_tele_lp", self.origin);
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0xb42d522b, Offset: 0xab8
// Size: 0x126
function function_29d1f2fd() {
    util::waitforclient(0);
    level.teleport_ae_funcs = [];
    if (getlocalplayers().size == 1) {
        level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_f710e21c;
    }
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_ef0e774f;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_fd27ac1b;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_340c1c45;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_2c0612f7;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_5716654b;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_9fcee6e8;
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0x259e4b73, Offset: 0xbe8
// Size: 0x100
function function_c8f25330() {
    var_80e1b4d8 = -1;
    while (true) {
        localclientnum = level waittill(#"hash_2dcc7301");
        /#
            assert(isdefined(localclientnum));
        #/
        var_438e3d44 = getvisionsetnaked(localclientnum);
        playsound(0, "evt_teleport_2d_fnt", (0, 0, 0));
        visionsetnaked(localclientnum, "default", 0);
        while (var_80e1b4d8 != localclientnum) {
            var_80e1b4d8 = level waittill(#"hash_cee28fa");
        }
        visionsetnaked(localclientnum, var_438e3d44, 0);
    }
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0x1e36cdc0, Offset: 0xcf0
// Size: 0xc6
function function_80009f4() {
    while (true) {
        localclientnum = level waittill(#"hash_6715790d");
        if (getdvarstring("castleAftereffectOverride") == "-1") {
            self thread [[ level.teleport_ae_funcs[randomint(level.teleport_ae_funcs.size)] ]](localclientnum);
            continue;
        }
        self thread [[ level.teleport_ae_funcs[int(getdvarstring("castleAftereffectOverride"))] ]](localclientnum);
    }
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0xe47f144f, Offset: 0xdc0
// Size: 0x14
function function_ef0e774f(localclientnum) {
    wait(0.05);
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0xd0540e6a, Offset: 0xde0
// Size: 0x14
function function_fd27ac1b(localclientnum) {
    wait(0.05);
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0xb268d3be, Offset: 0xe00
// Size: 0xda
function function_f710e21c(localclientnum) {
    /#
        println("<unknown string>");
    #/
    var_27bb5e5b = 30;
    var_400a1590 = getdvarfloat("cg_fov_default");
    duration = 0.5;
    for (i = 0; i < duration; i += 0.017) {
        fov = var_27bb5e5b + (var_400a1590 - var_27bb5e5b) * i / duration;
        wait(0.017);
    }
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0x28504cb0, Offset: 0xee8
// Size: 0x9c
function function_340c1c45(localclientnum) {
    /#
        println("<unknown string>");
    #/
    var_438e3d44 = getvisionsetnaked(localclientnum);
    visionsetnaked(localclientnum, "cheat_bw_invert_contrast", 0.4);
    wait(1.25);
    visionsetnaked(localclientnum, var_438e3d44, 1);
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0xff6e298c, Offset: 0xf90
// Size: 0x9c
function function_2c0612f7(localclientnum) {
    /#
        println("<unknown string>");
    #/
    var_438e3d44 = getvisionsetnaked(localclientnum);
    visionsetnaked(localclientnum, "zombie_turned", 0.4);
    wait(1.25);
    visionsetnaked(localclientnum, var_438e3d44, 1);
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0xed265c6d, Offset: 0x1038
// Size: 0xdc
function function_5716654b(localclientnum) {
    /#
        println("<unknown string>");
    #/
    var_438e3d44 = getvisionsetnaked(localclientnum);
    visionsetnaked(localclientnum, "cheat_bw_invert_contrast", 0.1);
    wait(0.4);
    visionsetnaked(localclientnum, "cheat_bw_contrast", 0.1);
    wait(0.4);
    wait(0.4);
    wait(0.4);
    visionsetnaked(localclientnum, var_438e3d44, 5);
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0xbb23a473, Offset: 0x1120
// Size: 0x9c
function function_9fcee6e8(localclientnum) {
    /#
        println("<unknown string>");
    #/
    var_438e3d44 = getvisionsetnaked(localclientnum);
    visionsetnaked(localclientnum, "flare", 0.4);
    wait(1.25);
    visionsetnaked(localclientnum, var_438e3d44, 1);
}

