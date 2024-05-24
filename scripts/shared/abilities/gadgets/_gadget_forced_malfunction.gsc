#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_5fcefdef;

// Namespace namespace_5fcefdef
// Params 0, eflags: 0x2
// Checksum 0xe82cb185, Offset: 0x210
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_forced_malfunction", &__init__, undefined, undefined);
}

// Namespace namespace_5fcefdef
// Params 0, eflags: 0x1 linked
// Checksum 0x6c35a947, Offset: 0x250
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(26, &function_9b45e254, &function_2d460862);
    ability_player::register_gadget_possession_callbacks(26, &function_d23df6e8, &function_197921fe);
    ability_player::register_gadget_flicker_callbacks(26, &function_7fa5f639);
    ability_player::register_gadget_is_inuse_callbacks(26, &function_dffae3dc);
    ability_player::register_gadget_is_flickering_callbacks(26, &function_d1d17a92);
    ability_player::register_gadget_primed_callbacks(26, &function_7f26eafd);
    callback::on_connect(&function_bd256077);
}

// Namespace namespace_5fcefdef
// Params 1, eflags: 0x1 linked
// Checksum 0x16e431eb, Offset: 0x360
// Size: 0x2a
function function_dffae3dc(slot) {
    return self flagsys::get("gadget_forced_malfunction_on");
}

// Namespace namespace_5fcefdef
// Params 1, eflags: 0x1 linked
// Checksum 0xde2d8b7b, Offset: 0x398
// Size: 0x52
function function_d1d17a92(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        return self [[ level.cybercom.forced_malfunction.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_5fcefdef
// Params 2, eflags: 0x1 linked
// Checksum 0xf1a12940, Offset: 0x3f8
// Size: 0x5c
function function_7fa5f639(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_5fcefdef
// Params 2, eflags: 0x1 linked
// Checksum 0x2c427bf9, Offset: 0x460
// Size: 0x5c
function function_d23df6e8(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_5fcefdef
// Params 2, eflags: 0x1 linked
// Checksum 0x919a5368, Offset: 0x4c8
// Size: 0x5c
function function_197921fe(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_5fcefdef
// Params 0, eflags: 0x1 linked
// Checksum 0x3f4a58b0, Offset: 0x530
// Size: 0x44
function function_bd256077() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction.var_5d2fec30 ]]();
    }
}

// Namespace namespace_5fcefdef
// Params 2, eflags: 0x1 linked
// Checksum 0x538e7c3f, Offset: 0x580
// Size: 0x7c
function function_9b45e254(slot, weapon) {
    self flagsys::set("gadget_forced_malfunction_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction._on ]](slot, weapon);
    }
}

// Namespace namespace_5fcefdef
// Params 2, eflags: 0x1 linked
// Checksum 0x568bc55, Offset: 0x608
// Size: 0x7c
function function_2d460862(slot, weapon) {
    self flagsys::clear("gadget_forced_malfunction_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction._off ]](slot, weapon);
    }
}

// Namespace namespace_5fcefdef
// Params 2, eflags: 0x1 linked
// Checksum 0x72655020, Offset: 0x690
// Size: 0x5c
function function_7f26eafd(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.forced_malfunction)) {
        self [[ level.cybercom.forced_malfunction.var_4135a1c4 ]](slot, weapon);
    }
}

