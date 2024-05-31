#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace namespace_4c372a0;

// Namespace namespace_4c372a0
// Params 0, eflags: 0x2
// Checksum 0x2c0dc174, Offset: 0x1b0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_factory_teleporter", &__init__, undefined, undefined);
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// Checksum 0x3dfbb13e, Offset: 0x1f0
// Size: 0x74
function __init__() {
    visionset_mgr::register_overlay_info_style_postfx_bundle("zm_factory_teleport", 1, 1, "pstfx_zm_der_teleport");
    level thread function_29d1f2fd();
    level thread function_c8f25330();
    level thread function_80009f4();
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// Checksum 0x85db533d, Offset: 0x270
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

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// Checksum 0xbb9a0535, Offset: 0x3a0
// Size: 0xd8
function function_c8f25330() {
    var_80e1b4d8 = -1;
    while (true) {
        localclientnum = level waittill(#"hash_2dcc7301");
        assert(isdefined(localclientnum));
        var_438e3d44 = getvisionsetnaked(localclientnum);
        visionsetnaked(localclientnum, "default", 0);
        while (var_80e1b4d8 != localclientnum) {
            var_80e1b4d8 = level waittill(#"hash_cee28fa");
        }
        visionsetnaked(localclientnum, var_438e3d44, 0);
    }
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// Checksum 0xd5c5543f, Offset: 0x480
// Size: 0xc6
function function_80009f4() {
    while (true) {
        localclientnum = level waittill(#"hash_6715790d");
        if (getdvarstring("factoryAftereffectOverride") == "-1") {
            self thread [[ level.teleport_ae_funcs[randomint(level.teleport_ae_funcs.size)] ]](localclientnum);
            continue;
        }
        self thread [[ level.teleport_ae_funcs[int(getdvarstring("factoryAftereffectOverride"))] ]](localclientnum);
    }
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// Checksum 0xe2575983, Offset: 0x550
// Size: 0x14
function function_ef0e774f(localclientnum) {
    wait(0.05);
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// Checksum 0xcac0e792, Offset: 0x570
// Size: 0x14
function function_fd27ac1b(localclientnum) {
    wait(0.05);
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// Checksum 0x16725859, Offset: 0x590
// Size: 0xda
function function_f710e21c(localclientnum) {
    println("zombie_turned");
    var_27bb5e5b = 30;
    var_400a1590 = getdvarfloat("cg_fov_default");
    duration = 0.5;
    for (i = 0; i < duration; i += 0.017) {
        fov = var_27bb5e5b + (var_400a1590 - var_27bb5e5b) * i / duration;
        wait(0.017);
    }
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// Checksum 0xad5d515, Offset: 0x678
// Size: 0x9c
function function_340c1c45(localclientnum) {
    println("zombie_turned");
    var_438e3d44 = getvisionsetnaked(localclientnum);
    visionsetnaked(localclientnum, "cheat_bw_invert_contrast", 0.4);
    wait(1.25);
    visionsetnaked(localclientnum, var_438e3d44, 1);
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// Checksum 0x1a38c860, Offset: 0x720
// Size: 0x9c
function function_2c0612f7(localclientnum) {
    println("zombie_turned");
    var_438e3d44 = getvisionsetnaked(localclientnum);
    visionsetnaked(localclientnum, "zombie_turned", 0.4);
    wait(1.25);
    visionsetnaked(localclientnum, var_438e3d44, 1);
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// Checksum 0x840a0575, Offset: 0x7c8
// Size: 0xdc
function function_5716654b(localclientnum) {
    println("zombie_turned");
    var_438e3d44 = getvisionsetnaked(localclientnum);
    visionsetnaked(localclientnum, "cheat_bw_invert_contrast", 0.1);
    wait(0.4);
    visionsetnaked(localclientnum, "cheat_bw_contrast", 0.1);
    wait(0.4);
    wait(0.4);
    wait(0.4);
    visionsetnaked(localclientnum, var_438e3d44, 5);
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// Checksum 0xc483d9cf, Offset: 0x8b0
// Size: 0x9c
function function_9fcee6e8(localclientnum) {
    println("zombie_turned");
    var_438e3d44 = getvisionsetnaked(localclientnum);
    visionsetnaked(localclientnum, "flare", 0.4);
    wait(1.25);
    visionsetnaked(localclientnum, var_438e3d44, 1);
}

