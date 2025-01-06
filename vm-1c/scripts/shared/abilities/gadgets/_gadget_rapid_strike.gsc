#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_rapid_strike;

// Namespace _gadget_rapid_strike
// Params 0, eflags: 0x2
// Checksum 0xe6b83de2, Offset: 0x200
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_rapid_strike", &__init__, undefined, undefined);
}

// Namespace _gadget_rapid_strike
// Params 0, eflags: 0x0
// Checksum 0x7985c51e, Offset: 0x240
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(30, &gadget_rapid_strike_on, &function_5b9296a9);
    ability_player::register_gadget_possession_callbacks(30, &function_d7b6939b, &function_d2114e79);
    ability_player::register_gadget_flicker_callbacks(30, &function_dec6547c);
    ability_player::register_gadget_is_inuse_callbacks(30, &function_96b27bbd);
    ability_player::register_gadget_is_flickering_callbacks(30, &function_f168e6c9);
    callback::on_connect(&function_672b2d72);
}

// Namespace _gadget_rapid_strike
// Params 1, eflags: 0x0
// Checksum 0xf7353bf6, Offset: 0x330
// Size: 0x2a
function function_96b27bbd(slot) {
    return self flagsys::get("gadget_rapid_strike_on");
}

// Namespace _gadget_rapid_strike
// Params 1, eflags: 0x0
// Checksum 0xde7ab590, Offset: 0x368
// Size: 0x50
function function_f168e6c9(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        return self [[ level.cybercom.rapid_strike.var_875da84b ]](slot);
    }
}

// Namespace _gadget_rapid_strike
// Params 2, eflags: 0x0
// Checksum 0x646aadfd, Offset: 0x3c0
// Size: 0x5c
function function_dec6547c(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace _gadget_rapid_strike
// Params 2, eflags: 0x0
// Checksum 0x432496c4, Offset: 0x428
// Size: 0x5c
function function_d7b6939b(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace _gadget_rapid_strike
// Params 2, eflags: 0x0
// Checksum 0x14bdae33, Offset: 0x490
// Size: 0x5c
function function_d2114e79(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace _gadget_rapid_strike
// Params 0, eflags: 0x0
// Checksum 0xcb5c1245, Offset: 0x4f8
// Size: 0x44
function function_672b2d72() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike.var_5d2fec30 ]]();
    }
}

// Namespace _gadget_rapid_strike
// Params 2, eflags: 0x0
// Checksum 0xbbadd973, Offset: 0x548
// Size: 0x7c
function gadget_rapid_strike_on(slot, weapon) {
    self flagsys::set("gadget_rapid_strike_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike._on ]](slot, weapon);
    }
}

// Namespace _gadget_rapid_strike
// Params 2, eflags: 0x0
// Checksum 0xf8ddfb82, Offset: 0x5d0
// Size: 0x7c
function function_5b9296a9(slot, weapon) {
    self flagsys::clear("gadget_rapid_strike_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.rapid_strike)) {
        self [[ level.cybercom.rapid_strike._off ]](slot, weapon);
    }
}

