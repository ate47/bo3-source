#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#using_animtree("mp_autoturret");

#namespace autoturret;

// Namespace autoturret
// Params 0, eflags: 0x2
// Checksum 0x26a2a585, Offset: 0x1d8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("autoturret", &__init__, undefined, undefined);
}

// Namespace autoturret
// Params 0, eflags: 0x0
// Checksum 0x295d5edd, Offset: 0x210
// Size: 0xca
function __init__() {
    clientfield::register("vehicle", "auto_turret_open", 1, 1, "int", &turret_open, 0, 0);
    clientfield::register("scriptmover", "auto_turret_init", 1, 1, "int", &turret_init_anim, 0, 0);
    clientfield::register("scriptmover", "auto_turret_close", 1, 1, "int", &turret_close_anim, 0, 0);
    visionset_mgr::register_visionset_info("turret_visionset", 1, 16, undefined, "mp_vehicles_turret");
}

// Namespace autoturret
// Params 7, eflags: 0x0
// Checksum 0xfa0096d9, Offset: 0x2e8
// Size: 0xba
function turret_init_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self useanimtree(#mp_autoturret);
    self setanimrestart(mp_autoturret%o_turret_sentry_close, 1, 0, 1);
    self setanimtime(mp_autoturret%o_turret_sentry_close, 1);
}

// Namespace autoturret
// Params 7, eflags: 0x0
// Checksum 0x2be72f70, Offset: 0x3b0
// Size: 0x92
function turret_open(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self useanimtree(#mp_autoturret);
    self setanimrestart(mp_autoturret%o_turret_sentry_deploy, 1, 0, 1);
}

// Namespace autoturret
// Params 7, eflags: 0x0
// Checksum 0xd0eee03d, Offset: 0x450
// Size: 0x92
function turret_close_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self useanimtree(#mp_autoturret);
    self setanimrestart(mp_autoturret%o_turret_sentry_close, 1, 0, 1);
}

