#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_f2401394;

// Namespace namespace_f2401394
// Params 0, eflags: 0x2
// Checksum 0xd576f1c2, Offset: 0x1f8
// Size: 0x34
function function_2dc19561() {
    system::register("gadget_es_strike", &__init__, undefined, undefined);
}

// Namespace namespace_f2401394
// Params 0, eflags: 0x1 linked
// Checksum 0xc609e697, Offset: 0x238
// Size: 0xe4
function __init__() {
    ability_player::register_gadget_activation_callbacks(33, &function_3211462f, &function_ec5008e3);
    ability_player::register_gadget_possession_callbacks(33, &function_16de280d, &function_8a49b72f);
    ability_player::register_gadget_flicker_callbacks(33, &function_f4c32d3a);
    ability_player::register_gadget_is_inuse_callbacks(33, &function_411e6e2f);
    ability_player::register_gadget_is_flickering_callbacks(33, &function_91b1b897);
    callback::on_connect(&function_b61a584);
}

// Namespace namespace_f2401394
// Params 1, eflags: 0x1 linked
// Checksum 0xfe413ea2, Offset: 0x328
// Size: 0x2a
function function_411e6e2f(slot) {
    return self flagsys::get("gadget_es_strike_on");
}

// Namespace namespace_f2401394
// Params 1, eflags: 0x1 linked
// Checksum 0x4870a517, Offset: 0x360
// Size: 0x50
function function_91b1b897(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_e3b77070)) {
        return self [[ level.cybercom.var_e3b77070.var_875da84b ]](slot);
    }
}

// Namespace namespace_f2401394
// Params 2, eflags: 0x1 linked
// Checksum 0x47145958, Offset: 0x3b8
// Size: 0x5c
function function_f4c32d3a(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_e3b77070)) {
        self [[ level.cybercom.var_e3b77070.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_f2401394
// Params 2, eflags: 0x1 linked
// Checksum 0x1102e94, Offset: 0x420
// Size: 0x5c
function function_16de280d(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_e3b77070)) {
        self [[ level.cybercom.var_e3b77070.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_f2401394
// Params 2, eflags: 0x1 linked
// Checksum 0x2e144acd, Offset: 0x488
// Size: 0x5c
function function_8a49b72f(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_e3b77070)) {
        self [[ level.cybercom.var_e3b77070.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_f2401394
// Params 0, eflags: 0x1 linked
// Checksum 0xe898dd73, Offset: 0x4f0
// Size: 0x44
function function_b61a584() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_e3b77070)) {
        self [[ level.cybercom.var_e3b77070.var_5d2fec30 ]]();
    }
}

// Namespace namespace_f2401394
// Params 2, eflags: 0x1 linked
// Checksum 0x5932273a, Offset: 0x540
// Size: 0x7c
function function_3211462f(slot, weapon) {
    self flagsys::set("gadget_es_strike_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_e3b77070)) {
        self [[ level.cybercom.var_e3b77070._on ]](slot, weapon);
    }
}

// Namespace namespace_f2401394
// Params 2, eflags: 0x1 linked
// Checksum 0xfa3d8db, Offset: 0x5c8
// Size: 0x7c
function function_ec5008e3(slot, weapon) {
    self flagsys::clear("gadget_es_strike_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.var_e3b77070)) {
        self [[ level.cybercom.var_e3b77070._off ]](slot, weapon);
    }
}

