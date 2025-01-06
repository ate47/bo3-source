#using scripts/codescripts/struct;
#using scripts/mp/_helicopter_sounds;
#using scripts/mp/_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace flak_drone;

// Namespace flak_drone
// Params 0, eflags: 0x2
// Checksum 0x1bd3cb57, Offset: 0x208
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("flak_drone", &__init__, undefined, undefined);
}

// Namespace flak_drone
// Params 0, eflags: 0x0
// Checksum 0x44767850, Offset: 0x240
// Size: 0x3a
function __init__() {
    clientfield::register("vehicle", "flak_drone_camo", 1, 3, "int", &active_camo_changed, 0, 0);
}

// Namespace flak_drone
// Params 7, eflags: 0x0
// Checksum 0x62d62992, Offset: 0x288
// Size: 0xd2
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
// Params 2, eflags: 0x0
// Checksum 0xd181ab9f, Offset: 0x368
// Size: 0xfa
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
        wait 0.016;
    }
    flags_changed = self duplicate_render::set_dr_flag("active_camo_reveal", 0);
    flags_changed = self duplicate_render::set_dr_flag("active_camo_on", direction) || flags_changed;
    if (flags_changed) {
        self duplicate_render::update_dr_filters(localclientnum);
    }
}

