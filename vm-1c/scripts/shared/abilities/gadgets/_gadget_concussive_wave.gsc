#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_618f1205;

// Namespace namespace_618f1205
// Params 0, eflags: 0x2
// namespace_618f1205<file_0>::function_2dc19561
// Checksum 0x64d5294a, Offset: 0x208
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("gadget_concussive_wave", &__init__, undefined, undefined);
}

// Namespace namespace_618f1205
// Params 0, eflags: 0x1 linked
// namespace_618f1205<file_0>::function_8c87d8eb
// Checksum 0xb71919aa, Offset: 0x248
// Size: 0x104
function __init__() {
    ability_player::register_gadget_activation_callbacks(27, &function_34dd1440, &function_92fc0c6e);
    ability_player::register_gadget_possession_callbacks(27, &function_6418a4dc, &function_1d94dc8a);
    ability_player::register_gadget_flicker_callbacks(27, &function_52e40575);
    ability_player::register_gadget_is_inuse_callbacks(27, &function_9b3f10a8);
    ability_player::register_gadget_is_flickering_callbacks(27, &function_52a16de6);
    ability_player::register_gadget_primed_callbacks(27, &function_96c5b0e1);
    callback::on_connect(&function_1d1db9d3);
}

// Namespace namespace_618f1205
// Params 1, eflags: 0x1 linked
// namespace_618f1205<file_0>::function_9b3f10a8
// Checksum 0xa1f9988a, Offset: 0x358
// Size: 0x2a
function function_9b3f10a8(slot) {
    return self flagsys::get("gadget_concussive_wave_on");
}

// Namespace namespace_618f1205
// Params 1, eflags: 0x1 linked
// namespace_618f1205<file_0>::function_52a16de6
// Checksum 0x49c1803, Offset: 0x390
// Size: 0x52
function function_52a16de6(slot) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        return self [[ level.cybercom.concussive_wave.var_875da84b ]](slot);
    }
    return 0;
}

// Namespace namespace_618f1205
// Params 2, eflags: 0x1 linked
// namespace_618f1205<file_0>::function_52e40575
// Checksum 0x9a0380ce, Offset: 0x3f0
// Size: 0x5c
function function_52e40575(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave.var_8d01efb6 ]](slot, weapon);
    }
}

// Namespace namespace_618f1205
// Params 2, eflags: 0x1 linked
// namespace_618f1205<file_0>::function_6418a4dc
// Checksum 0xc9b81509, Offset: 0x458
// Size: 0x5c
function function_6418a4dc(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave.var_bdb47551 ]](slot, weapon);
    }
}

// Namespace namespace_618f1205
// Params 2, eflags: 0x1 linked
// namespace_618f1205<file_0>::function_1d94dc8a
// Checksum 0x6c92f5f8, Offset: 0x4c0
// Size: 0x5c
function function_1d94dc8a(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave.var_39ea6a1b ]](slot, weapon);
    }
}

// Namespace namespace_618f1205
// Params 0, eflags: 0x1 linked
// namespace_618f1205<file_0>::function_1d1db9d3
// Checksum 0xdd2c0e16, Offset: 0x528
// Size: 0x44
function function_1d1db9d3() {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave.var_5d2fec30 ]]();
    }
}

// Namespace namespace_618f1205
// Params 2, eflags: 0x1 linked
// namespace_618f1205<file_0>::function_34dd1440
// Checksum 0x236d6dd8, Offset: 0x578
// Size: 0x7c
function function_34dd1440(slot, weapon) {
    self flagsys::set("gadget_concussive_wave_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave._on ]](slot, weapon);
    }
}

// Namespace namespace_618f1205
// Params 2, eflags: 0x1 linked
// namespace_618f1205<file_0>::function_92fc0c6e
// Checksum 0x1f32f8a9, Offset: 0x600
// Size: 0x7c
function function_92fc0c6e(slot, weapon) {
    self flagsys::clear("gadget_concussive_wave_on");
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave._off ]](slot, weapon);
    }
}

// Namespace namespace_618f1205
// Params 2, eflags: 0x1 linked
// namespace_618f1205<file_0>::function_96c5b0e1
// Checksum 0xaa8b8870, Offset: 0x688
// Size: 0x5c
function function_96c5b0e1(slot, weapon) {
    if (isdefined(level.cybercom) && isdefined(level.cybercom.concussive_wave)) {
        self [[ level.cybercom.concussive_wave.var_4135a1c4 ]](slot, weapon);
    }
}

