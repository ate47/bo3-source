#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_10ab61ba;

// Namespace namespace_10ab61ba
// Params 0, eflags: 0x2
// namespace_10ab61ba<file_0>::function_2dc19561
// Checksum 0x7386a8e4, Offset: 0x1f8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_immolation", &__init__, undefined, undefined);
}

// Namespace namespace_10ab61ba
// Params 0, eflags: 0x1 linked
// namespace_10ab61ba<file_0>::function_8c87d8eb
// Checksum 0x59833e95, Offset: 0x238
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(34, &function_7c43428b, &function_43d6ec7f);
    ability_player::register_gadget_possession_callbacks(34, &function_f4ff64c1, &function_6947e88b);
    ability_player::register_gadget_flicker_callbacks(34, &function_51e92cc6);
    ability_player::register_gadget_is_inuse_callbacks(34, &function_b024aecb);
    ability_player::register_gadget_is_flickering_callbacks(34, &function_a881191b);
    ability_player::register_gadget_primed_callbacks(34, &function_77bcc634);
    callback::on_connect(&function_44821bc0);
}

// Namespace namespace_10ab61ba
// Params 1, eflags: 0x1 linked
// namespace_10ab61ba<file_0>::function_b024aecb
// Checksum 0x1e575ea3, Offset: 0x348
// Size: 0x2a
function function_b024aecb(slot) {
    return self flagsys::get("gadget_immolation_on");
}

// Namespace namespace_10ab61ba
// Params 1, eflags: 0x1 linked
// namespace_10ab61ba<file_0>::function_a881191b
// Checksum 0x820d46fb, Offset: 0x380
// Size: 0x52
function function_a881191b(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        return self [[ level.cybercom.immolation.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_10ab61ba
// Params 2, eflags: 0x1 linked
// namespace_10ab61ba<file_0>::function_51e92cc6
// Checksum 0x531734ba, Offset: 0x3e0
// Size: 0x5c
function function_51e92cc6(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_10ab61ba
// Params 2, eflags: 0x1 linked
// namespace_10ab61ba<file_0>::function_f4ff64c1
// Checksum 0xa6f7de5c, Offset: 0x448
// Size: 0x5c
function function_f4ff64c1(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_10ab61ba
// Params 2, eflags: 0x1 linked
// namespace_10ab61ba<file_0>::function_6947e88b
// Checksum 0xb09f633c, Offset: 0x4b0
// Size: 0x5c
function function_6947e88b(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_10ab61ba
// Params 0, eflags: 0x1 linked
// namespace_10ab61ba<file_0>::function_44821bc0
// Checksum 0x628157dd, Offset: 0x518
// Size: 0x44
function function_44821bc0() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation.var_5d2fec30 ]]();
    }
}

// Namespace namespace_10ab61ba
// Params 2, eflags: 0x1 linked
// namespace_10ab61ba<file_0>::function_7c43428b
// Checksum 0x42c86d5e, Offset: 0x568
// Size: 0x7c
function function_7c43428b(slot, weapon) {
    self flagsys::set("gadget_immolation_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation._on ]](slot, weapon);
    }
}

// Namespace namespace_10ab61ba
// Params 2, eflags: 0x1 linked
// namespace_10ab61ba<file_0>::function_43d6ec7f
// Checksum 0xd44c22cd, Offset: 0x5f0
// Size: 0x7c
function function_43d6ec7f(slot, weapon) {
    self flagsys::clear("gadget_immolation_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation._off ]](slot, weapon);
    }
}

// Namespace namespace_10ab61ba
// Params 2, eflags: 0x1 linked
// namespace_10ab61ba<file_0>::function_77bcc634
// Checksum 0x77610fcb, Offset: 0x678
// Size: 0x5c
function function_77bcc634(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.immolation)) {
        self [[ level.cybercom.immolation.var_4135a1c4 ]](slot, weapon);
    }
}

