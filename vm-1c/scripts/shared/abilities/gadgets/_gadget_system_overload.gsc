#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_system_overload;

// Namespace _gadget_system_overload
// Params 0, eflags: 0x2
// Checksum 0x80829828, Offset: 0x208
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_system_overload", &__init__, undefined, undefined);
}

// Namespace _gadget_system_overload
// Params 0, eflags: 0x0
// Checksum 0x674f32d3, Offset: 0x248
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(18, &gadget_system_overload_on, &function_7eb9a812);
    ability_player::register_gadget_possession_callbacks(18, &function_88154e18, &function_319ce16e);
    ability_player::register_gadget_flicker_callbacks(18, &function_d25b7289);
    ability_player::register_gadget_is_inuse_callbacks(18, &function_d7934bec);
    ability_player::register_gadget_is_flickering_callbacks(18, &function_a0a61e62);
    ability_player::register_gadget_primed_callbacks(18, &function_a7a30eed);
    callback::on_connect(&function_613dce47);
}

// Namespace _gadget_system_overload
// Params 1, eflags: 0x0
// Checksum 0xca51d928, Offset: 0x358
// Size: 0x2a
function function_d7934bec(slot) {
    return self flagsys::get("gadget_system_overload_on");
}

// Namespace _gadget_system_overload
// Params 1, eflags: 0x0
// Checksum 0xb4212d92, Offset: 0x390
// Size: 0x52
function function_a0a61e62(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        return self [[ level.cybercom.system_overload.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace _gadget_system_overload
// Params 2, eflags: 0x0
// Checksum 0xdbb89c1e, Offset: 0x3f0
// Size: 0x5c
function function_d25b7289(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace _gadget_system_overload
// Params 2, eflags: 0x0
// Checksum 0xbe9d298b, Offset: 0x458
// Size: 0x5c
function function_88154e18(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace _gadget_system_overload
// Params 2, eflags: 0x0
// Checksum 0x440b04b6, Offset: 0x4c0
// Size: 0x5c
function function_319ce16e(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace _gadget_system_overload
// Params 0, eflags: 0x0
// Checksum 0x56153669, Offset: 0x528
// Size: 0x44
function function_613dce47() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload.var_5d2fec30 ]]();
    }
}

// Namespace _gadget_system_overload
// Params 2, eflags: 0x0
// Checksum 0x22446c2a, Offset: 0x578
// Size: 0x7c
function gadget_system_overload_on(slot, weapon) {
    self flagsys::set("gadget_system_overload_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload._on ]](slot, weapon);
    }
}

// Namespace _gadget_system_overload
// Params 2, eflags: 0x0
// Checksum 0x1fed9d77, Offset: 0x600
// Size: 0x7c
function function_7eb9a812(slot, weapon) {
    self flagsys::clear("gadget_system_overload_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload._off ]](slot, weapon);
    }
}

// Namespace _gadget_system_overload
// Params 2, eflags: 0x0
// Checksum 0x2b8350a7, Offset: 0x688
// Size: 0x5c
function function_a7a30eed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.system_overload)) {
        self [[ level.cybercom.system_overload.var_4135a1c4 ]](slot, weapon);
    }
}

