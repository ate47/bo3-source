#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace _gadget_cacophany;

// Namespace _gadget_cacophany
// Params 0, eflags: 0x2
// Checksum 0xe4f7c4a2, Offset: 0x1f8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_cacophany", &__init__, undefined, undefined);
}

// Namespace _gadget_cacophany
// Params 0, eflags: 0x1 linked
// Checksum 0xdade025c, Offset: 0x238
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(25, &gadget_cacophany_on, &function_120f3c62);
    ability_player::register_gadget_possession_callbacks(25, &function_77666ae8, &function_bea195fe);
    ability_player::register_gadget_flicker_callbacks(25, &function_639bf239);
    ability_player::register_gadget_is_inuse_callbacks(25, &function_dea97fdc);
    ability_player::register_gadget_is_flickering_callbacks(25, &function_2164e92);
    ability_player::register_gadget_primed_callbacks(25, &function_6c067efd);
    callback::on_connect(&function_a11b5c77);
}

// Namespace _gadget_cacophany
// Params 1, eflags: 0x1 linked
// Checksum 0x140b76fb, Offset: 0x348
// Size: 0x2a
function function_dea97fdc(slot) {
    return self flagsys::get("gadget_cacophany_on");
}

// Namespace _gadget_cacophany
// Params 1, eflags: 0x1 linked
// Checksum 0xe45529d, Offset: 0x380
// Size: 0x50
function function_2164e92(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        return self [[ level.cybercom.cacophany.var_875da84b ]](slot);
    }
}

// Namespace _gadget_cacophany
// Params 2, eflags: 0x1 linked
// Checksum 0x62a53a39, Offset: 0x3d8
// Size: 0x5c
function function_639bf239(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace _gadget_cacophany
// Params 2, eflags: 0x1 linked
// Checksum 0xf34173e7, Offset: 0x440
// Size: 0x5c
function function_77666ae8(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace _gadget_cacophany
// Params 2, eflags: 0x1 linked
// Checksum 0xa18b2384, Offset: 0x4a8
// Size: 0x5c
function function_bea195fe(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace _gadget_cacophany
// Params 0, eflags: 0x1 linked
// Checksum 0xbdd3ca4b, Offset: 0x510
// Size: 0x44
function function_a11b5c77() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany.var_5d2fec30 ]]();
    }
}

// Namespace _gadget_cacophany
// Params 2, eflags: 0x1 linked
// Checksum 0x814517fd, Offset: 0x560
// Size: 0x7c
function gadget_cacophany_on(slot, weapon) {
    self flagsys::set("gadget_cacophany_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany._on ]](slot, weapon);
    }
}

// Namespace _gadget_cacophany
// Params 2, eflags: 0x1 linked
// Checksum 0x8afb5c82, Offset: 0x5e8
// Size: 0x7c
function function_120f3c62(slot, weapon) {
    self flagsys::clear("gadget_cacophany_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany._off ]](slot, weapon);
    }
}

// Namespace _gadget_cacophany
// Params 2, eflags: 0x1 linked
// Checksum 0xeb357b7b, Offset: 0x670
// Size: 0x5c
function function_6c067efd(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.cacophany)) {
        self [[ level.cybercom.cacophany.var_4135a1c4 ]](slot, weapon);
    }
}

