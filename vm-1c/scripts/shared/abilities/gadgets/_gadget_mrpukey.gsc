#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace _gadget_mrpukey;

// Namespace _gadget_mrpukey
// Params 0, eflags: 0x2
// Checksum 0x3059694e, Offset: 0x1f0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_mrpukey", &__init__, undefined, undefined);
}

// Namespace _gadget_mrpukey
// Params 0, eflags: 0x1 linked
// Checksum 0xc3277878, Offset: 0x230
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(38, &gadget_mrpukey_on, &function_a21f6e7);
    ability_player::register_gadget_possession_callbacks(38, &function_70600839, &function_86cffd43);
    ability_player::register_gadget_flicker_callbacks(38, &function_37c482e);
    ability_player::register_gadget_is_inuse_callbacks(38, &function_ec5153d3);
    ability_player::register_gadget_is_flickering_callbacks(38, &function_f1409fc3);
    ability_player::register_gadget_primed_callbacks(38, &function_a05ccc6c);
}

// Namespace _gadget_mrpukey
// Params 1, eflags: 0x1 linked
// Checksum 0x5320560f, Offset: 0x320
// Size: 0x2a
function function_ec5153d3(slot) {
    return self flagsys::get("gadget_mrpukey_on");
}

// Namespace _gadget_mrpukey
// Params 1, eflags: 0x1 linked
// Checksum 0xc50c3ca2, Offset: 0x358
// Size: 0x50
function function_f1409fc3(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        return self [[ level.cybercom.var_9b2c750e.var_875da84b ]](slot);
    }
}

// Namespace _gadget_mrpukey
// Params 2, eflags: 0x1 linked
// Checksum 0xc810ad, Offset: 0x3b0
// Size: 0x5c
function function_37c482e(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        self [[ level.cybercom.var_9b2c750e.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace _gadget_mrpukey
// Params 2, eflags: 0x1 linked
// Checksum 0xab1ccd16, Offset: 0x418
// Size: 0x5c
function function_70600839(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        self [[ level.cybercom.var_9b2c750e.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace _gadget_mrpukey
// Params 2, eflags: 0x1 linked
// Checksum 0xe9fe21a9, Offset: 0x480
// Size: 0x5c
function function_86cffd43(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        self [[ level.cybercom.var_9b2c750e.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace _gadget_mrpukey
// Params 0, eflags: 0x0
// Checksum 0x3662da1b, Offset: 0x4e8
// Size: 0x44
function function_6f66c54a() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        self [[ level.cybercom.var_9b2c750e.var_5d2fec30 ]]();
    }
}

// Namespace _gadget_mrpukey
// Params 2, eflags: 0x1 linked
// Checksum 0x262da596, Offset: 0x538
// Size: 0x7c
function gadget_mrpukey_on(slot, weapon) {
    self flagsys::set("gadget_mrpukey_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        self [[ level.cybercom.var_9b2c750e._on ]](slot, weapon);
    }
}

// Namespace _gadget_mrpukey
// Params 2, eflags: 0x1 linked
// Checksum 0xee2cd722, Offset: 0x5c0
// Size: 0x7c
function function_a21f6e7(slot, weapon) {
    self flagsys::clear("gadget_mrpukey_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        self [[ level.cybercom.var_9b2c750e._off ]](slot, weapon);
    }
}

// Namespace _gadget_mrpukey
// Params 2, eflags: 0x1 linked
// Checksum 0x65f01284, Offset: 0x648
// Size: 0x5c
function function_a05ccc6c(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_9b2c750e)) {
        self [[ level.cybercom.var_9b2c750e.var_4135a1c4 ]](slot, weapon);
    }
}

