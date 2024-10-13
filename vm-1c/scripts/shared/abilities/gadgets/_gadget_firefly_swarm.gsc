#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace _gadget_firefly_swarm;

// Namespace _gadget_firefly_swarm
// Params 0, eflags: 0x2
// Checksum 0xed6c97b6, Offset: 0x200
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_firefly_swarm", &__init__, undefined, undefined);
}

// Namespace _gadget_firefly_swarm
// Params 0, eflags: 0x1 linked
// Checksum 0xb4f0f09d, Offset: 0x240
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(35, &gadget_firefly_swarm_on, &function_b1976484);
    ability_player::register_gadget_possession_callbacks(35, &function_74f27faa, &function_db0a7244);
    ability_player::register_gadget_flicker_callbacks(35, &function_d4552077);
    ability_player::register_gadget_is_inuse_callbacks(35, &function_6194b7e);
    ability_player::register_gadget_is_flickering_callbacks(35, &function_e1e64030);
    ability_player::register_gadget_primed_callbacks(35, &function_9d2a518e);
    callback::on_connect(&function_4a3aa959);
}

// Namespace _gadget_firefly_swarm
// Params 1, eflags: 0x1 linked
// Checksum 0xc4f078d8, Offset: 0x350
// Size: 0x2a
function function_6194b7e(slot) {
    return self flagsys::get("gadget_firefly_swarm_on");
}

// Namespace _gadget_firefly_swarm
// Params 1, eflags: 0x1 linked
// Checksum 0x1279f92d, Offset: 0x388
// Size: 0x52
function function_e1e64030(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        return self [[ level.cybercom.firefly_swarm.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace _gadget_firefly_swarm
// Params 2, eflags: 0x1 linked
// Checksum 0xf7620f68, Offset: 0x3e8
// Size: 0x5c
function function_d4552077(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace _gadget_firefly_swarm
// Params 2, eflags: 0x1 linked
// Checksum 0xbf0287b7, Offset: 0x450
// Size: 0x5c
function function_74f27faa(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace _gadget_firefly_swarm
// Params 2, eflags: 0x1 linked
// Checksum 0xd9bcdef9, Offset: 0x4b8
// Size: 0x5c
function function_db0a7244(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace _gadget_firefly_swarm
// Params 0, eflags: 0x1 linked
// Checksum 0xe438e0c7, Offset: 0x520
// Size: 0x44
function function_4a3aa959() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm.var_5d2fec30 ]]();
    }
}

// Namespace _gadget_firefly_swarm
// Params 2, eflags: 0x1 linked
// Checksum 0xeb4fd8e, Offset: 0x570
// Size: 0x7c
function gadget_firefly_swarm_on(slot, weapon) {
    self flagsys::set("gadget_firefly_swarm_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm._on ]](slot, weapon);
    }
}

// Namespace _gadget_firefly_swarm
// Params 2, eflags: 0x1 linked
// Checksum 0x4fc65ed3, Offset: 0x5f8
// Size: 0x7c
function function_b1976484(slot, weapon) {
    self flagsys::clear("gadget_firefly_swarm_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm._off ]](slot, weapon);
    }
}

// Namespace _gadget_firefly_swarm
// Params 2, eflags: 0x1 linked
// Checksum 0xe7bee8a2, Offset: 0x680
// Size: 0x5c
function function_9d2a518e(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.firefly_swarm)) {
        self [[ level.cybercom.firefly_swarm.var_4135a1c4 ]](slot, weapon);
    }
}

