#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace _gadget_smokescreen;

// Namespace _gadget_smokescreen
// Params 0, eflags: 0x2
// Checksum 0x950ef401, Offset: 0x1f8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_smokescreen", &__init__, undefined, undefined);
}

// Namespace _gadget_smokescreen
// Params 0, eflags: 0x1 linked
// Checksum 0x542e3f35, Offset: 0x238
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(36, &gadget_smokescreen_on, &function_89901879);
    ability_player::register_gadget_possession_callbacks(36, &function_a17871ab, &function_70f70b89);
    ability_player::register_gadget_flicker_callbacks(36, &function_bfb84b6c);
    ability_player::register_gadget_is_inuse_callbacks(36, &function_ceb5552d);
    ability_player::register_gadget_is_flickering_callbacks(36, &function_43a90939);
    ability_player::register_gadget_primed_callbacks(36, &function_e11cf076);
    callback::on_connect(&function_53ff0722);
}

// Namespace _gadget_smokescreen
// Params 1, eflags: 0x1 linked
// Checksum 0x64d4ad85, Offset: 0x348
// Size: 0x2a
function function_ceb5552d(slot) {
    return self flagsys::get("gadget_smokescreen_on");
}

// Namespace _gadget_smokescreen
// Params 1, eflags: 0x1 linked
// Checksum 0x3162b952, Offset: 0x380
// Size: 0x52
function function_43a90939(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        return self [[ level.cybercom.smokescreen.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace _gadget_smokescreen
// Params 2, eflags: 0x1 linked
// Checksum 0xfce089fb, Offset: 0x3e0
// Size: 0x5c
function function_bfb84b6c(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        self [[ level.cybercom.smokescreen.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace _gadget_smokescreen
// Params 2, eflags: 0x1 linked
// Checksum 0xfee3f793, Offset: 0x448
// Size: 0x5c
function function_a17871ab(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        self [[ level.cybercom.smokescreen.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace _gadget_smokescreen
// Params 2, eflags: 0x1 linked
// Checksum 0x475fc9d3, Offset: 0x4b0
// Size: 0x5c
function function_70f70b89(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        self [[ level.cybercom.smokescreen.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace _gadget_smokescreen
// Params 0, eflags: 0x1 linked
// Checksum 0xe9880bca, Offset: 0x518
// Size: 0x44
function function_53ff0722() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        self [[ level.cybercom.smokescreen.var_5d2fec30 ]]();
    }
}

// Namespace _gadget_smokescreen
// Params 2, eflags: 0x1 linked
// Checksum 0xa7c80e55, Offset: 0x568
// Size: 0x7c
function gadget_smokescreen_on(slot, weapon) {
    self flagsys::set("gadget_smokescreen_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        self [[ level.cybercom.smokescreen._on ]](slot, weapon);
    }
}

// Namespace _gadget_smokescreen
// Params 2, eflags: 0x1 linked
// Checksum 0xfc69ed78, Offset: 0x5f0
// Size: 0x7c
function function_89901879(slot, weapon) {
    self flagsys::clear("gadget_smokescreen_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        self [[ level.cybercom.smokescreen._off ]](slot, weapon);
    }
}

// Namespace _gadget_smokescreen
// Params 2, eflags: 0x1 linked
// Checksum 0x7c07e269, Offset: 0x678
// Size: 0x5c
function function_e11cf076(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.smokescreen)) {
        self [[ level.cybercom.smokescreen.var_4135a1c4 ]](slot, weapon);
    }
}

