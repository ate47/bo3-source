#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_misdirection;

// Namespace _gadget_misdirection
// Params 0, eflags: 0x2
// Checksum 0x366f72b5, Offset: 0x200
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_misdirection", &__init__, undefined, undefined);
}

// Namespace _gadget_misdirection
// Params 0, eflags: 0x0
// Checksum 0xba529d87, Offset: 0x240
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(37, &gadget_misdirection_on, &function_53a55062);
    ability_player::register_gadget_possession_callbacks(37, &function_3149bee8, &function_7884e9fe);
    ability_player::register_gadget_flicker_callbacks(37, &function_44f18e39);
    ability_player::register_gadget_is_inuse_callbacks(37, &function_7f86bbdc);
    ability_player::register_gadget_is_flickering_callbacks(37, &function_a3f0292);
    ability_player::register_gadget_primed_callbacks(37, &function_a84bf2fd);
    callback::on_connect(&function_8270f877);
}

// Namespace _gadget_misdirection
// Params 1, eflags: 0x0
// Checksum 0x810594ca, Offset: 0x350
// Size: 0x2a
function function_7f86bbdc(slot) {
    return self flagsys::get("gadget_misdirection_on");
}

// Namespace _gadget_misdirection
// Params 1, eflags: 0x0
// Checksum 0xb6ba7d7e, Offset: 0x388
// Size: 0x52
function function_a3f0292(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        return self [[ level.cybercom.misdirection.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace _gadget_misdirection
// Params 2, eflags: 0x0
// Checksum 0xd2b46ed1, Offset: 0x3e8
// Size: 0x5c
function function_44f18e39(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace _gadget_misdirection
// Params 2, eflags: 0x0
// Checksum 0xcd4741d1, Offset: 0x450
// Size: 0x5c
function function_3149bee8(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace _gadget_misdirection
// Params 2, eflags: 0x0
// Checksum 0x77169789, Offset: 0x4b8
// Size: 0x5c
function function_7884e9fe(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace _gadget_misdirection
// Params 0, eflags: 0x0
// Checksum 0xa5f3ae98, Offset: 0x520
// Size: 0x44
function function_8270f877() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection.var_5d2fec30 ]]();
    }
}

// Namespace _gadget_misdirection
// Params 2, eflags: 0x0
// Checksum 0xc4a7ca46, Offset: 0x570
// Size: 0x7c
function gadget_misdirection_on(slot, weapon) {
    self flagsys::set("gadget_misdirection_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection._on ]](slot, weapon);
    }
}

// Namespace _gadget_misdirection
// Params 2, eflags: 0x0
// Checksum 0xdbba940, Offset: 0x5f8
// Size: 0x7c
function function_53a55062(slot, weapon) {
    self flagsys::clear("gadget_misdirection_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection._off ]](slot, weapon);
    }
}

// Namespace _gadget_misdirection
// Params 2, eflags: 0x0
// Checksum 0x852be4f8, Offset: 0x680
// Size: 0x5c
function function_a84bf2fd(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.misdirection)) {
        self [[ level.cybercom.misdirection.var_4135a1c4 ]](slot, weapon);
    }
}

