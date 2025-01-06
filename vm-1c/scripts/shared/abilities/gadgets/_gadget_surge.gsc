#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_surge;

// Namespace _gadget_surge
// Params 0, eflags: 0x2
// Checksum 0x5054829d, Offset: 0x1e8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_surge", &__init__, undefined, undefined);
}

// Namespace _gadget_surge
// Params 0, eflags: 0x0
// Checksum 0x4e01d168, Offset: 0x228
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(21, &gadget_surge_on, &function_ebb88a60);
    ability_player::register_gadget_possession_callbacks(21, &function_113a0c6e, &function_aa2b0180);
    ability_player::register_gadget_flicker_callbacks(21, &function_3f2d883);
    ability_player::register_gadget_is_inuse_callbacks(21, &function_8721bfa);
    ability_player::register_gadget_is_flickering_callbacks(21, &function_e4b7ee54);
    ability_player::register_gadget_primed_callbacks(21, &function_5ff9a66b);
    callback::on_connect(&function_e8723625);
}

// Namespace _gadget_surge
// Params 1, eflags: 0x0
// Checksum 0x479ba9b7, Offset: 0x338
// Size: 0x2a
function function_8721bfa(slot) {
    return self flagsys::get("gadget_surge_on");
}

// Namespace _gadget_surge
// Params 1, eflags: 0x0
// Checksum 0xa3440021, Offset: 0x370
// Size: 0x50
function function_e4b7ee54(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        return self [[ level.cybercom.surge.var_875da84b ]](slot);
    }
}

// Namespace _gadget_surge
// Params 2, eflags: 0x0
// Checksum 0xa3f92999, Offset: 0x3c8
// Size: 0x5c
function function_3f2d883(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace _gadget_surge
// Params 2, eflags: 0x0
// Checksum 0xbd42d0e6, Offset: 0x430
// Size: 0x5c
function function_113a0c6e(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace _gadget_surge
// Params 2, eflags: 0x0
// Checksum 0x7aab1492, Offset: 0x498
// Size: 0x5c
function function_aa2b0180(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace _gadget_surge
// Params 0, eflags: 0x0
// Checksum 0xbe74f5e1, Offset: 0x500
// Size: 0x44
function function_e8723625() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge.var_5d2fec30 ]]();
    }
}

// Namespace _gadget_surge
// Params 2, eflags: 0x0
// Checksum 0xd4d2a9ec, Offset: 0x550
// Size: 0x7c
function gadget_surge_on(slot, weapon) {
    self flagsys::set("gadget_surge_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge._on ]](slot, weapon);
    }
}

// Namespace _gadget_surge
// Params 2, eflags: 0x0
// Checksum 0xba460725, Offset: 0x5d8
// Size: 0x7c
function function_ebb88a60(slot, weapon) {
    self flagsys::clear("gadget_surge_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge._off ]](slot, weapon);
    }
}

// Namespace _gadget_surge
// Params 2, eflags: 0x0
// Checksum 0x53fe9c60, Offset: 0x660
// Size: 0x5c
function function_5ff9a66b(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.surge)) {
        self [[ level.cybercom.surge.var_4135a1c4 ]](slot, weapon);
    }
}

