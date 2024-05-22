#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_gadgets;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_897c340c;

// Namespace namespace_897c340c
// Params 0, eflags: 0x2
// Checksum 0x7d4c23dd, Offset: 0x1e8
// Size: 0x34
function function_2dc19561() {
    system::register("gadget_active_camo", &__init__, undefined, undefined);
}

// Namespace namespace_897c340c
// Params 0, eflags: 0x1 linked
// Checksum 0x3682d3b3, Offset: 0x228
// Size: 0x124
function __init__() {
    ability_player::register_gadget_activation_callbacks(31, &function_700380c0, &function_3078d9ee);
    ability_player::register_gadget_possession_callbacks(31, &function_58efbfed, &function_9da1d50f);
    ability_player::register_gadget_flicker_callbacks(31, &function_63b9579a);
    ability_player::register_gadget_is_inuse_callbacks(31, &function_6b246a0f);
    ability_player::register_gadget_is_flickering_callbacks(31, &function_558ba1f7);
    callback::on_connect(&function_7af2cde4);
    callback::on_spawned(&function_2fd91ec7);
    callback::on_disconnect(&function_3f5bf600);
}

// Namespace namespace_897c340c
// Params 0, eflags: 0x1 linked
// Checksum 0xcac32374, Offset: 0x358
// Size: 0x44
function function_7af2cde4() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo.var_5d2fec30 ]]();
    }
}

// Namespace namespace_897c340c
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x3a8
// Size: 0x4
function function_3f5bf600() {
    
}

// Namespace namespace_897c340c
// Params 0, eflags: 0x1 linked
// Checksum 0x42ac512d, Offset: 0x3b8
// Size: 0x54
function function_2fd91ec7() {
    self flagsys::clear("camo_suit_on");
    self notify(#"hash_af133c03");
    self clientfield::set("camo_shader", 0);
}

// Namespace namespace_897c340c
// Params 1, eflags: 0x1 linked
// Checksum 0x6acba577, Offset: 0x418
// Size: 0x2a
function function_6b246a0f(slot) {
    return self flagsys::get("camo_suit_on");
}

// Namespace namespace_897c340c
// Params 1, eflags: 0x1 linked
// Checksum 0xa4d695d2, Offset: 0x450
// Size: 0x22
function function_558ba1f7(slot) {
    return self gadgetflickering(slot);
}

// Namespace namespace_897c340c
// Params 2, eflags: 0x1 linked
// Checksum 0x8c7edc40, Offset: 0x480
// Size: 0x5c
function function_58efbfed(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_897c340c
// Params 2, eflags: 0x1 linked
// Checksum 0x9a713e1c, Offset: 0x4e8
// Size: 0x6c
function function_9da1d50f(slot, weapon) {
    self notify(#"hash_6adca138");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self [[ level.cybercom.active_camo.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_897c340c
// Params 2, eflags: 0x1 linked
// Checksum 0x770e5f3b, Offset: 0x560
// Size: 0x7c
function function_63b9579a(slot, weapon) {
    self thread function_a68d6bbe(slot, weapon);
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_897c340c
// Params 2, eflags: 0x1 linked
// Checksum 0x8c79d2e8, Offset: 0x5e8
// Size: 0xa4
function function_700380c0(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo._on ]](slot, weapon);
    } else {
        self clientfield::set("camo_shader", 1);
    }
    self flagsys::set("camo_suit_on");
}

// Namespace namespace_897c340c
// Params 2, eflags: 0x1 linked
// Checksum 0x901995f2, Offset: 0x698
// Size: 0xac
function function_3078d9ee(slot, weapon) {
    self flagsys::clear("camo_suit_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.active_camo)) {
        self thread [[ level.cybercom.active_camo._off ]](slot, weapon);
    }
    self notify(#"hash_af133c03");
    self clientfield::set("camo_shader", 0);
}

// Namespace namespace_897c340c
// Params 2, eflags: 0x1 linked
// Checksum 0x99e18047, Offset: 0x750
// Size: 0x9c
function function_a68d6bbe(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"hash_af133c03");
    self clientfield::set("camo_shader", 2);
    function_f93698a2(slot, weapon);
    if (self function_6b246a0f(slot)) {
        self clientfield::set("camo_shader", 1);
    }
}

// Namespace namespace_897c340c
// Params 2, eflags: 0x1 linked
// Checksum 0x24113e8a, Offset: 0x7f8
// Size: 0x54
function function_f93698a2(slot, weapon) {
    self endon(#"death");
    self endon(#"hash_af133c03");
    while (self function_558ba1f7(slot)) {
        wait(0.5);
    }
}

