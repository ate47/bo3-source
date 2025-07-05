#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_exo_breakdown;

// Namespace _gadget_exo_breakdown
// Params 0, eflags: 0x2
// Checksum 0x9c7487b6, Offset: 0x200
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("gadget_exo_breakdown", &__init__, undefined, undefined);
}

// Namespace _gadget_exo_breakdown
// Params 0, eflags: 0x0
// Checksum 0xa95c1bc1, Offset: 0x240
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(20, &gadget_exo_breakdown_on, &function_ead04890);
    ability_player::register_gadget_possession_callbacks(20, &function_7bbc329e, &function_a37dd970);
    ability_player::register_gadget_flicker_callbacks(20, &function_fdf21253);
    ability_player::register_gadget_is_inuse_callbacks(20, &function_10ced8a);
    ability_player::register_gadget_is_flickering_callbacks(20, &function_9ea7a824);
    ability_player::register_gadget_primed_callbacks(20, &function_eef5315b);
    callback::on_connect(&function_126f0e75);
}

// Namespace _gadget_exo_breakdown
// Params 1, eflags: 0x0
// Checksum 0x5ce3502e, Offset: 0x350
// Size: 0x2a
function function_10ced8a(slot) {
    return self flagsys::get("gadget_exo_breakdown_on");
}

// Namespace _gadget_exo_breakdown
// Params 1, eflags: 0x0
// Checksum 0xf27c9b01, Offset: 0x388
// Size: 0x52
function function_9ea7a824(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        return self [[ level.cybercom.exo_breakdown.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace _gadget_exo_breakdown
// Params 2, eflags: 0x0
// Checksum 0x8a842248, Offset: 0x3e8
// Size: 0x5c
function function_fdf21253(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace _gadget_exo_breakdown
// Params 2, eflags: 0x0
// Checksum 0x560d446c, Offset: 0x450
// Size: 0x5c
function function_7bbc329e(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace _gadget_exo_breakdown
// Params 2, eflags: 0x0
// Checksum 0xcc9dfa1f, Offset: 0x4b8
// Size: 0x5c
function function_a37dd970(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace _gadget_exo_breakdown
// Params 0, eflags: 0x0
// Checksum 0x1db99d0e, Offset: 0x520
// Size: 0x44
function function_126f0e75() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown.var_5d2fec30 ]]();
    }
}

// Namespace _gadget_exo_breakdown
// Params 2, eflags: 0x0
// Checksum 0x54ac308b, Offset: 0x570
// Size: 0x7c
function gadget_exo_breakdown_on(slot, weapon) {
    self flagsys::set("gadget_exo_breakdown_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown._on ]](slot, weapon);
    }
}

// Namespace _gadget_exo_breakdown
// Params 2, eflags: 0x0
// Checksum 0x1456bb05, Offset: 0x5f8
// Size: 0x7c
function function_ead04890(slot, weapon) {
    self flagsys::clear("gadget_exo_breakdown_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown._off ]](slot, weapon);
    }
}

// Namespace _gadget_exo_breakdown
// Params 2, eflags: 0x0
// Checksum 0x5d2e5cae, Offset: 0x680
// Size: 0x5c
function function_eef5315b(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.exo_breakdown)) {
        self [[ level.cybercom.exo_breakdown.var_4135a1c4 ]](slot, weapon);
    }
}

