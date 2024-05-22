#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace autoturret;

// Namespace autoturret
// Params 0, eflags: 0x2
// Checksum 0x3f4e8149, Offset: 0x1d8
// Size: 0x34
function function_2dc19561() {
    system::register("autoturret", &__init__, undefined, undefined);
}

// Namespace autoturret
// Params 0, eflags: 0x1 linked
// Checksum 0xc95b1f34, Offset: 0x218
// Size: 0x104
function __init__() {
    clientfield::register("vehicle", "auto_turret_open", 1, 1, "int", &turret_open, 0, 0);
    clientfield::register("scriptmover", "auto_turret_init", 1, 1, "int", &turret_init_anim, 0, 0);
    clientfield::register("scriptmover", "auto_turret_close", 1, 1, "int", &turret_close_anim, 0, 0);
    visionset_mgr::register_visionset_info("turret_visionset", 1, 16, undefined, "mp_vehicles_turret");
}

// Namespace autoturret
// Params 7, eflags: 0x1 linked
// Checksum 0x56c9f524, Offset: 0x328
// Size: 0xc4
function turret_init_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self useanimtree(#mp_autoturret);
    self setanimrestart(mp_autoturret%o_turret_sentry_close, 1, 0, 1);
    self setanimtime(mp_autoturret%o_turret_sentry_close, 1);
}

// Namespace autoturret
// Params 7, eflags: 0x1 linked
// Checksum 0x9d508bd6, Offset: 0x3f8
// Size: 0x9c
function turret_open(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self useanimtree(#mp_autoturret);
    self setanimrestart(mp_autoturret%o_turret_sentry_deploy, 1, 0, 1);
}

// Namespace autoturret
// Params 7, eflags: 0x1 linked
// Checksum 0xa01ff616, Offset: 0x4a0
// Size: 0x9c
function turret_close_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self useanimtree(#mp_autoturret);
    self setanimrestart(mp_autoturret%o_turret_sentry_close, 1, 0, 1);
}

