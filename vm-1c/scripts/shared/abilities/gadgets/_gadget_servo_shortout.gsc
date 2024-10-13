#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace _gadget_servo_shortout;

// Namespace _gadget_servo_shortout
// Params 0, eflags: 0x2
// Checksum 0xfc351738, Offset: 0x200
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_servo_shortout", &__init__, undefined, undefined);
}

// Namespace _gadget_servo_shortout
// Params 0, eflags: 0x1 linked
// Checksum 0xf5ac2b60, Offset: 0x240
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(19, &gadget_servo_shortout_on, &function_c1ce069e);
    ability_player::register_gadget_possession_callbacks(19, &function_fc4fe7cc, &function_3e88bf7a);
    ability_player::register_gadget_flicker_callbacks(19, &function_2b96d045);
    ability_player::register_gadget_is_inuse_callbacks(19, &function_d0064a78);
    ability_player::register_gadget_is_flickering_callbacks(19, &function_a850a436);
    ability_player::register_gadget_primed_callbacks(19, &function_2be7b311);
    callback::on_connect(&function_901d2323);
}

// Namespace _gadget_servo_shortout
// Params 1, eflags: 0x1 linked
// Checksum 0xa1947ce, Offset: 0x350
// Size: 0x2a
function function_d0064a78(slot) {
    return self flagsys::get("gadget_servo_shortout_on");
}

// Namespace _gadget_servo_shortout
// Params 1, eflags: 0x1 linked
// Checksum 0x7ce502bd, Offset: 0x388
// Size: 0x52
function function_a850a436(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        return self [[ level.cybercom.servo_shortout.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace _gadget_servo_shortout
// Params 2, eflags: 0x1 linked
// Checksum 0x3ecd3087, Offset: 0x3e8
// Size: 0x5c
function function_2b96d045(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace _gadget_servo_shortout
// Params 2, eflags: 0x1 linked
// Checksum 0x8f975b93, Offset: 0x450
// Size: 0x5c
function function_fc4fe7cc(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace _gadget_servo_shortout
// Params 2, eflags: 0x1 linked
// Checksum 0xa7719e19, Offset: 0x4b8
// Size: 0x5c
function function_3e88bf7a(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace _gadget_servo_shortout
// Params 0, eflags: 0x1 linked
// Checksum 0x1ab08158, Offset: 0x520
// Size: 0x44
function function_901d2323() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout.var_5d2fec30 ]]();
    }
}

// Namespace _gadget_servo_shortout
// Params 2, eflags: 0x1 linked
// Checksum 0xfe610ab3, Offset: 0x570
// Size: 0x7c
function gadget_servo_shortout_on(slot, weapon) {
    self flagsys::set("gadget_servo_shortout_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout._on ]](slot, weapon);
    }
}

// Namespace _gadget_servo_shortout
// Params 2, eflags: 0x1 linked
// Checksum 0x8e79dd3c, Offset: 0x5f8
// Size: 0x7c
function function_c1ce069e(slot, weapon) {
    self flagsys::clear("gadget_servo_shortout_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout._off ]](slot, weapon);
    }
}

// Namespace _gadget_servo_shortout
// Params 2, eflags: 0x1 linked
// Checksum 0x634bf8a0, Offset: 0x680
// Size: 0x5c
function function_2be7b311(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.servo_shortout)) {
        self [[ level.cybercom.servo_shortout.var_4135a1c4 ]](slot, weapon);
    }
}

