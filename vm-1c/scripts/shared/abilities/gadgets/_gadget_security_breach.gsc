#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace _gadget_security_breach;

// Namespace _gadget_security_breach
// Params 0, eflags: 0x2
// Checksum 0x325425cd, Offset: 0x208
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_security_breach", &__init__, undefined, undefined);
}

// Namespace _gadget_security_breach
// Params 0, eflags: 0x1 linked
// Checksum 0x261418fb, Offset: 0x248
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(23, &gadget_security_breach_on, &function_ae24e944);
    ability_player::register_gadget_possession_callbacks(23, &function_2f62c66a, &function_957ab904);
    ability_player::register_gadget_flicker_callbacks(23, &function_612f0337);
    ability_player::register_gadget_is_inuse_callbacks(23, &function_439b773e);
    ability_player::register_gadget_is_flickering_callbacks(23, &function_aab070f0);
    ability_player::register_gadget_primed_callbacks(23, &function_bbd467e7);
    callback::on_connect(&function_3ee9b19);
}

// Namespace _gadget_security_breach
// Params 1, eflags: 0x1 linked
// Checksum 0x59b207ff, Offset: 0x358
// Size: 0x2a
function function_439b773e(slot) {
    return self flagsys::get("gadget_security_breach_on");
}

// Namespace _gadget_security_breach
// Params 1, eflags: 0x1 linked
// Checksum 0xe942b942, Offset: 0x390
// Size: 0x50
function function_aab070f0(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        return self [[ level.cybercom.var_76af92c1.var_875da84b ]](slot);
    }
}

// Namespace _gadget_security_breach
// Params 2, eflags: 0x1 linked
// Checksum 0xb4356e45, Offset: 0x3e8
// Size: 0x5c
function function_612f0337(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        self [[ level.cybercom.var_76af92c1.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace _gadget_security_breach
// Params 2, eflags: 0x1 linked
// Checksum 0x5b44aba4, Offset: 0x450
// Size: 0x5c
function function_2f62c66a(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        return self [[ level.cybercom.var_76af92c1.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace _gadget_security_breach
// Params 2, eflags: 0x1 linked
// Checksum 0x1e55dfb7, Offset: 0x4b8
// Size: 0x5c
function function_957ab904(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        return self [[ level.cybercom.var_76af92c1.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace _gadget_security_breach
// Params 0, eflags: 0x1 linked
// Checksum 0x60f5fc23, Offset: 0x520
// Size: 0x44
function function_3ee9b19() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        return self [[ level.cybercom.var_76af92c1.var_5d2fec30 ]]();
    }
}

// Namespace _gadget_security_breach
// Params 2, eflags: 0x1 linked
// Checksum 0xe829d52c, Offset: 0x570
// Size: 0x7c
function gadget_security_breach_on(slot, weapon) {
    self flagsys::set("gadget_security_breach_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        return self [[ level.cybercom.var_76af92c1._on ]](slot, weapon);
    }
}

// Namespace _gadget_security_breach
// Params 2, eflags: 0x1 linked
// Checksum 0x233804a1, Offset: 0x5f8
// Size: 0x7c
function function_ae24e944(slot, weapon) {
    self flagsys::clear("gadget_security_breach_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        return self [[ level.cybercom.var_76af92c1._off ]](slot, weapon);
    }
}

// Namespace _gadget_security_breach
// Params 2, eflags: 0x1 linked
// Checksum 0xfc9f1239, Offset: 0x680
// Size: 0x5c
function function_bbd467e7(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_76af92c1)) {
        self [[ level.cybercom.var_76af92c1.var_4135a1c4 ]](slot, weapon);
    }
}

