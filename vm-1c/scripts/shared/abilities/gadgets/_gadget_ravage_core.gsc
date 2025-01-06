#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_ravage_core;

// Namespace _gadget_ravage_core
// Params 0, eflags: 0x2
// Checksum 0x8f62af98, Offset: 0x1f8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_ravage_core", &__init__, undefined, undefined);
}

// Namespace _gadget_ravage_core
// Params 0, eflags: 0x0
// Checksum 0xefc8145a, Offset: 0x238
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(22, &gadget_ravage_core_on, &function_38d64430);
    ability_player::register_gadget_possession_callbacks(22, &function_5f263c7e, &function_5aa8d250);
    ability_player::register_gadget_flicker_callbacks(22, &function_f2c75eb3);
    ability_player::register_gadget_is_inuse_callbacks(22, &function_9b19b36a);
    ability_player::register_gadget_is_flickering_callbacks(22, &function_7f87be84);
    callback::on_connect(&function_882e77d5);
}

// Namespace _gadget_ravage_core
// Params 1, eflags: 0x0
// Checksum 0x8e262b77, Offset: 0x328
// Size: 0x2a
function function_9b19b36a(slot) {
    return self flagsys::get("gadget_ravage_core_on");
}

// Namespace _gadget_ravage_core
// Params 1, eflags: 0x0
// Checksum 0x7c3b204d, Offset: 0x360
// Size: 0x50
function function_7f87be84(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        return self [[ level.cybercom.ravage_core.var_875da84b ]](slot);
    }
}

// Namespace _gadget_ravage_core
// Params 2, eflags: 0x0
// Checksum 0x4c97342e, Offset: 0x3b8
// Size: 0x5c
function function_f2c75eb3(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace _gadget_ravage_core
// Params 2, eflags: 0x0
// Checksum 0xc79ca8ce, Offset: 0x420
// Size: 0x5c
function function_5f263c7e(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace _gadget_ravage_core
// Params 2, eflags: 0x0
// Checksum 0x1bd19af8, Offset: 0x488
// Size: 0x5c
function function_5aa8d250(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace _gadget_ravage_core
// Params 0, eflags: 0x0
// Checksum 0x8c1cb25a, Offset: 0x4f0
// Size: 0x44
function function_882e77d5() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core.var_5d2fec30 ]]();
    }
}

// Namespace _gadget_ravage_core
// Params 2, eflags: 0x0
// Checksum 0x28f4c4a5, Offset: 0x540
// Size: 0x7c
function gadget_ravage_core_on(slot, weapon) {
    self flagsys::set("gadget_ravage_core_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core._on ]](slot, weapon);
    }
}

// Namespace _gadget_ravage_core
// Params 2, eflags: 0x0
// Checksum 0x8121cbd1, Offset: 0x5c8
// Size: 0x7c
function function_38d64430(slot, weapon) {
    self flagsys::clear("gadget_ravage_core_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.ravage_core)) {
        self [[ level.cybercom.ravage_core._off ]](slot, weapon);
    }
}

