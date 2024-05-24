#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/audio_shared;
#using scripts/codescripts/struct;

#namespace namespace_b2e08b6c;

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x2
// Checksum 0xe154829c, Offset: 0x2b8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_genesis_teleporter", &__init__, undefined, undefined);
}

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x0
// Checksum 0x34fc89d8, Offset: 0x2f8
// Size: 0xe4
function __init__() {
    visionset_mgr::register_overlay_info_style_transported("zm_genesis", 15000, 15, 2);
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_factory_teleport", 15000, 1, "pstfx_zm_wormhole");
    clientfield::register("toplayer", "player_shadowman_teleport_hijack_fx", 15000, 1, "int", &function_4131ca6b, 0, 0);
    level thread function_29d1f2fd();
    level thread function_c8f25330();
    level thread function_80009f4();
}

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x0
// Checksum 0x1fe45154, Offset: 0x3e8
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

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x0
// Checksum 0x912d161a, Offset: 0x518
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

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x0
// Checksum 0xc454fcd8, Offset: 0x620
// Size: 0xc6
function function_80009f4() {
    while (true) {
        localclientnum = level waittill(#"hash_6715790d");
        if (getdvarstring("genesisAftereffectOverride") == "-1") {
            self thread [[ level.teleport_ae_funcs[randomint(level.teleport_ae_funcs.size)] ]](localclientnum);
            continue;
        }
        self thread [[ level.teleport_ae_funcs[int(getdvarstring("genesisAftereffectOverride"))] ]](localclientnum);
    }
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x0
// Checksum 0xa60904fe, Offset: 0x6f0
// Size: 0x14
function function_ef0e774f(localclientnum) {
    wait(0.05);
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x0
// Checksum 0x2ea1af97, Offset: 0x710
// Size: 0x14
function function_fd27ac1b(localclientnum) {
    wait(0.05);
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x0
// Checksum 0x86c61373, Offset: 0x730
// Size: 0xda
function function_f710e21c(localclientnum) {
    /#
        println("<unknown string>");
    #/
    var_bd22d384 = 30;
    var_b27ddf7 = getdvarfloat("cg_fov_default");
    n_duration = 0.5;
    for (i = 0; i < n_duration; i += 0.017) {
        var_199c7fe5 = var_bd22d384 + (var_b27ddf7 - var_bd22d384) * i / n_duration;
        wait(0.017);
    }
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x0
// Checksum 0x41a1454, Offset: 0x818
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

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x0
// Checksum 0x16e56de9, Offset: 0x8c0
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

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x0
// Checksum 0xd7c7fc32, Offset: 0x968
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

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x0
// Checksum 0x97ae5704, Offset: 0xa50
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

// Namespace namespace_b2e08b6c
// Params 7, eflags: 0x0
// Checksum 0xfa4265bd, Offset: 0xaf8
// Size: 0xde
function function_4131ca6b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_4131ca6b");
    self endon(#"hash_4131ca6b");
    if (newval) {
        if (isdemoplaying() && demoisanyfreemovecamera()) {
            return;
        }
        self thread function_bad0a94c(localclientnum);
        self thread postfx::playpostfxbundle("pstfx_zm_wormhole");
        return;
    }
    self notify(#"hash_1530bfe");
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x0
// Checksum 0xb1c6acf3, Offset: 0xbe0
// Size: 0x4c
function function_bad0a94c(localclientnum) {
    self util::waittill_any("player_shadowman_teleport_hijack_fx", "player_shadowman_teleport_hijack_fx_done");
    self postfx::exitpostfxbundle();
}

