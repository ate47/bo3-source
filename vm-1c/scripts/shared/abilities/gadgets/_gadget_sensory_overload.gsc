#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_a0549db3;

// Namespace namespace_a0549db3
// Params 0, eflags: 0x2
// Checksum 0xf277f895, Offset: 0x208
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_sensory_overload", &__init__, undefined, undefined);
}

// Namespace namespace_a0549db3
// Params 0, eflags: 0x1 linked
// Checksum 0x43aef0c1, Offset: 0x248
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(32, &function_15e437b0, &function_c1d76ffe);
    ability_player::register_gadget_possession_callbacks(32, &function_b0d7efec, &function_d9c4129a);
    ability_player::register_gadget_flicker_callbacks(32, &function_ceab21e5);
    ability_player::register_gadget_is_inuse_callbacks(32, &function_1a766e18);
    ability_player::register_gadget_is_flickering_callbacks(32, &function_d34dd456);
    ability_player::register_gadget_primed_callbacks(32, &function_ce8bf231);
    callback::on_connect(&function_e100d1c3);
}

// Namespace namespace_a0549db3
// Params 1, eflags: 0x1 linked
// Checksum 0x7e9dcdfa, Offset: 0x358
// Size: 0x2a
function function_1a766e18(slot) {
    return self flagsys::get("gadget_sensory_overload_on");
}

// Namespace namespace_a0549db3
// Params 1, eflags: 0x1 linked
// Checksum 0x439f93ed, Offset: 0x390
// Size: 0x50
function function_d34dd456(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        return self [[ level.cybercom.sensory_overload.var_875da84b ]](slot);
    }
}

// Namespace namespace_a0549db3
// Params 2, eflags: 0x1 linked
// Checksum 0x703c057d, Offset: 0x3e8
// Size: 0x5c
function function_ceab21e5(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_a0549db3
// Params 2, eflags: 0x1 linked
// Checksum 0x52cb46d2, Offset: 0x450
// Size: 0x5c
function function_b0d7efec(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_a0549db3
// Params 2, eflags: 0x1 linked
// Checksum 0xd0450bbe, Offset: 0x4b8
// Size: 0x5c
function function_d9c4129a(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_a0549db3
// Params 0, eflags: 0x1 linked
// Checksum 0xa60e45dd, Offset: 0x520
// Size: 0x44
function function_e100d1c3() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload.var_5d2fec30 ]]();
    }
}

// Namespace namespace_a0549db3
// Params 2, eflags: 0x1 linked
// Checksum 0xac573097, Offset: 0x570
// Size: 0x7c
function function_15e437b0(slot, weapon) {
    self flagsys::set("gadget_sensory_overload_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload._on ]](slot, weapon);
    }
}

// Namespace namespace_a0549db3
// Params 2, eflags: 0x1 linked
// Checksum 0xfbc541f9, Offset: 0x5f8
// Size: 0x7c
function function_c1d76ffe(slot, weapon) {
    self flagsys::clear("gadget_sensory_overload_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload._off ]](slot, weapon);
    }
}

// Namespace namespace_a0549db3
// Params 2, eflags: 0x1 linked
// Checksum 0xfd203c50, Offset: 0x680
// Size: 0x5c
function function_ce8bf231(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.sensory_overload)) {
        self [[ level.cybercom.sensory_overload.var_4135a1c4 ]](slot, weapon);
    }
}

