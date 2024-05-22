#using scripts/shared/duplicaterender_mgr;
#using scripts/mp/_util;
#using scripts/mp/_helicopter_sounds;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace flak_drone;

// Namespace flak_drone
// Params 0, eflags: 0x2
// Checksum 0x26a39a67, Offset: 0x208
// Size: 0x34
function function_2dc19561() {
    system::register("flak_drone", &__init__, undefined, undefined);
}

// Namespace flak_drone
// Params 0, eflags: 0x1 linked
// Checksum 0x5030f90b, Offset: 0x248
// Size: 0x4c
function __init__() {
    clientfield::register("vehicle", "flak_drone_camo", 1, 3, "int", &active_camo_changed, 0, 0);
}

// Namespace flak_drone
// Params 7, eflags: 0x1 linked
// Checksum 0x1901f080, Offset: 0x2a0
// Size: 0x11c
function active_camo_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    flags_changed = self duplicate_render::set_dr_flag("active_camo_flicker", newval == 2);
    flags_changed = self duplicate_render::set_dr_flag("active_camo_on", 0) || flags_changed;
    flags_changed = self duplicate_render::set_dr_flag("active_camo_reveal", 1) || flags_changed;
    if (flags_changed) {
        self duplicate_render::update_dr_filters(localclientnum);
    }
    self notify(#"endtest");
    self thread doreveal(localclientnum, newval != 0);
}

// Namespace flak_drone
// Params 2, eflags: 0x1 linked
// Checksum 0xe68d7dc8, Offset: 0x3c8
// Size: 0x164
function doreveal(localclientnum, direction) {
    self notify(#"endtest");
    self endon(#"endtest");
    self endon(#"entityshutdown");
    if (direction) {
        startval = 1;
    } else {
        startval = 0;
    }
    while (startval >= 0 && startval <= 1) {
        self mapshaderconstant(localclientnum, 0, "scriptVector0", startval, 0, 0, 0);
        if (direction) {
            startval -= 0.032;
        } else {
            startval += 0.032;
        }
        wait(0.016);
    }
    flags_changed = self duplicate_render::set_dr_flag("active_camo_reveal", 0);
    flags_changed = self duplicate_render::set_dr_flag("active_camo_on", direction) || flags_changed;
    if (flags_changed) {
        self duplicate_render::update_dr_filters(localclientnum);
    }
}

