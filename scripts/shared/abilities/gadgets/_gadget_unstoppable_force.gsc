#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_11c3c67a;

// Namespace namespace_11c3c67a
// Params 0, eflags: 0x2
// Checksum 0x67136c8f, Offset: 0x230
// Size: 0x34
function function_2dc19561() {
    system::register("gadget_unstoppable_force", &__init__, undefined, undefined);
}

// Namespace namespace_11c3c67a
// Params 0, eflags: 0x1 linked
// Checksum 0x1fe5976a, Offset: 0x270
// Size: 0x114
function __init__() {
    ability_player::register_gadget_activation_callbacks(29, &function_d693cc29, &function_f5f70c55);
    ability_player::register_gadget_possession_callbacks(29, &function_b94ad56f, &function_4f4c1f25);
    ability_player::register_gadget_flicker_callbacks(29, &function_c6dc2378);
    ability_player::register_gadget_is_inuse_callbacks(29, &function_ae33369);
    ability_player::register_gadget_is_flickering_callbacks(29, &function_e70192cd);
    callback::on_connect(&function_23dd24ee);
    clientfield::register("toplayer", "unstoppableforce_state", 1, 1, "int");
}

// Namespace namespace_11c3c67a
// Params 1, eflags: 0x1 linked
// Checksum 0x8b370a0d, Offset: 0x390
// Size: 0x2a
function function_ae33369(slot) {
    return self flagsys::get("gadget_unstoppable_force_on");
}

// Namespace namespace_11c3c67a
// Params 1, eflags: 0x1 linked
// Checksum 0x5269cb30, Offset: 0x3c8
// Size: 0x52
function function_e70192cd(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        return self [[ level.cybercom.unstoppable_force.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_11c3c67a
// Params 2, eflags: 0x1 linked
// Checksum 0xed6d25cc, Offset: 0x428
// Size: 0x5c
function function_c6dc2378(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_11c3c67a
// Params 2, eflags: 0x1 linked
// Checksum 0x8be54724, Offset: 0x490
// Size: 0x5c
function function_b94ad56f(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_11c3c67a
// Params 2, eflags: 0x1 linked
// Checksum 0x8f8ed0df, Offset: 0x4f8
// Size: 0x5c
function function_4f4c1f25(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_11c3c67a
// Params 0, eflags: 0x1 linked
// Checksum 0x9033941a, Offset: 0x560
// Size: 0x44
function function_23dd24ee() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force.var_5d2fec30 ]]();
    }
}

// Namespace namespace_11c3c67a
// Params 2, eflags: 0x1 linked
// Checksum 0xeac59acb, Offset: 0x5b0
// Size: 0x7c
function function_d693cc29(slot, weapon) {
    self flagsys::set("gadget_unstoppable_force_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force._on ]](slot, weapon);
    }
}

// Namespace namespace_11c3c67a
// Params 2, eflags: 0x1 linked
// Checksum 0x2be1b544, Offset: 0x638
// Size: 0x7c
function function_f5f70c55(slot, weapon) {
    self flagsys::clear("gadget_unstoppable_force_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force._off ]](slot, weapon);
    }
}

// Namespace namespace_11c3c67a
// Params 2, eflags: 0x0
// Checksum 0xae7fc097, Offset: 0x6c0
// Size: 0x5c
function function_9d2a518e(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.unstoppable_force)) {
        self [[ level.cybercom.unstoppable_force.var_4135a1c4 ]](slot, weapon);
    }
}

