#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_509b4eb;

// Namespace namespace_509b4eb
// Params 0, eflags: 0x2
// namespace_509b4eb<file_0>::function_2dc19561
// Checksum 0xeeddcbc6, Offset: 0x250
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_overdrive", &__init__, undefined, undefined);
}

// Namespace namespace_509b4eb
// Params 0, eflags: 0x1 linked
// namespace_509b4eb<file_0>::function_8c87d8eb
// Checksum 0xabbc3641, Offset: 0x290
// Size: 0x16c
function __init__() {
    ability_player::register_gadget_activation_callbacks(28, &function_372c774a, &function_a0a9dd0);
    ability_player::register_gadget_possession_callbacks(28, &function_6f36bade, &function_96f861b0);
    ability_player::register_gadget_flicker_callbacks(28, &function_8b256b93);
    ability_player::register_gadget_is_inuse_callbacks(28, &function_99c38cca);
    ability_player::register_gadget_is_flickering_callbacks(28, &function_fdada264);
    if (!isdefined(level.var_ec5c8ef9)) {
        level.var_ec5c8ef9 = 65;
    }
    visionset_mgr::register_info("visionset", "overdrive", 1, level.var_ec5c8ef9, 15, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
    callback::on_connect(&function_f40798b5);
    clientfield::register("toplayer", "overdrive_state", 1, 1, "int");
}

// Namespace namespace_509b4eb
// Params 1, eflags: 0x1 linked
// namespace_509b4eb<file_0>::function_99c38cca
// Checksum 0x51505205, Offset: 0x408
// Size: 0x2a
function function_99c38cca(slot) {
    return self flagsys::get("gadget_overdrive_on");
}

// Namespace namespace_509b4eb
// Params 1, eflags: 0x1 linked
// namespace_509b4eb<file_0>::function_fdada264
// Checksum 0x5c698b63, Offset: 0x440
// Size: 0xc
function function_fdada264(slot) {
    
}

// Namespace namespace_509b4eb
// Params 2, eflags: 0x1 linked
// namespace_509b4eb<file_0>::function_8b256b93
// Checksum 0x56cc9f2, Offset: 0x458
// Size: 0x14
function function_8b256b93(slot, weapon) {
    
}

// Namespace namespace_509b4eb
// Params 2, eflags: 0x1 linked
// namespace_509b4eb<file_0>::function_6f36bade
// Checksum 0xa2d7e72e, Offset: 0x478
// Size: 0x5c
function function_6f36bade(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
        self [[ level.cybercom.overdrive.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_509b4eb
// Params 2, eflags: 0x1 linked
// namespace_509b4eb<file_0>::function_96f861b0
// Checksum 0x12fee31a, Offset: 0x4e0
// Size: 0x5c
function function_96f861b0(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
        self [[ level.cybercom.overdrive.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_509b4eb
// Params 0, eflags: 0x1 linked
// namespace_509b4eb<file_0>::function_f40798b5
// Checksum 0x99ec1590, Offset: 0x548
// Size: 0x4
function function_f40798b5() {
    
}

// Namespace namespace_509b4eb
// Params 2, eflags: 0x1 linked
// namespace_509b4eb<file_0>::function_372c774a
// Checksum 0xb972e8a2, Offset: 0x558
// Size: 0x7c
function function_372c774a(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
        self thread [[ level.cybercom.overdrive._on ]](slot, weapon);
        self flagsys::set("gadget_overdrive_on");
    }
}

// Namespace namespace_509b4eb
// Params 2, eflags: 0x1 linked
// namespace_509b4eb<file_0>::function_a0a9dd0
// Checksum 0xec528c8, Offset: 0x5e0
// Size: 0x7c
function function_a0a9dd0(slot, weapon) {
    self flagsys::clear("gadget_overdrive_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.overdrive)) {
        self thread [[ level.cybercom.overdrive._off ]](slot, weapon);
    }
}

