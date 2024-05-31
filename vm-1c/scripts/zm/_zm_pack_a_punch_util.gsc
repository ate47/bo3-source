#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_pap_util;

// Namespace zm_pap_util
// Params 0, eflags: 0x1 linked
// namespace_b1e4b463<file_0>::function_36a637d6
// Checksum 0x3957c30, Offset: 0x1c8
// Size: 0xd0
function init_parameters() {
    if (!isdefined(level.pack_a_punch)) {
        level.pack_a_punch = spawnstruct();
        level.pack_a_punch.timeout = 15;
        level.pack_a_punch.interaction_height = 35;
        level.pack_a_punch.var_1a77f755 = &function_3fe26769;
        level.pack_a_punch.var_78a3b3e0 = &function_f65ac400;
        level.pack_a_punch.grabbable_by_anyone = 0;
        level.pack_a_punch.var_3c0894ac = 0;
        level.pack_a_punch.triggers = [];
    }
}

// Namespace zm_pap_util
// Params 1, eflags: 0x0
// namespace_b1e4b463<file_0>::function_5eb0e12b
// Checksum 0xc5406ee, Offset: 0x2a0
// Size: 0x30
function set_timeout(n_timeout_s) {
    init_parameters();
    level.pack_a_punch.timeout = n_timeout_s;
}

// Namespace zm_pap_util
// Params 1, eflags: 0x1 linked
// namespace_b1e4b463<file_0>::function_dea0d47c
// Checksum 0x96194044, Offset: 0x2d8
// Size: 0x30
function set_interaction_height(n_height) {
    init_parameters();
    level.pack_a_punch.interaction_height = n_height;
}

// Namespace zm_pap_util
// Params 1, eflags: 0x1 linked
// namespace_b1e4b463<file_0>::function_5e0cf34
// Checksum 0x4c8f716f, Offset: 0x310
// Size: 0x30
function function_5e0cf34(n_radius) {
    init_parameters();
    level.pack_a_punch.var_1adcb0d3 = n_radius;
}

// Namespace zm_pap_util
// Params 1, eflags: 0x0
// namespace_b1e4b463<file_0>::function_fd8189f
// Checksum 0x886743a0, Offset: 0x348
// Size: 0x30
function set_interaction_trigger_height(n_height) {
    init_parameters();
    level.pack_a_punch.set_interaction_trigger_height = n_height;
}

// Namespace zm_pap_util
// Params 1, eflags: 0x0
// namespace_b1e4b463<file_0>::function_82c7ef16
// Checksum 0xedbb23f2, Offset: 0x380
// Size: 0x30
function function_82c7ef16(var_f4786758) {
    init_parameters();
    level.pack_a_punch.var_1a77f755 = var_f4786758;
}

// Namespace zm_pap_util
// Params 1, eflags: 0x0
// namespace_b1e4b463<file_0>::function_b92a53ad
// Checksum 0xe67b1492, Offset: 0x3b8
// Size: 0x30
function function_b92a53ad(var_ddf33d7) {
    init_parameters();
    level.pack_a_punch.var_78a3b3e0 = var_ddf33d7;
}

// Namespace zm_pap_util
// Params 0, eflags: 0x0
// namespace_b1e4b463<file_0>::function_f92c925b
// Checksum 0x7810669, Offset: 0x3f0
// Size: 0x28
function set_grabbable_by_anyone() {
    init_parameters();
    level.pack_a_punch.grabbable_by_anyone = 1;
}

// Namespace zm_pap_util
// Params 0, eflags: 0x1 linked
// namespace_b1e4b463<file_0>::function_f925b7b9
// Checksum 0xc46c6dc2, Offset: 0x420
// Size: 0x5a
function function_f925b7b9() {
    init_parameters();
    /#
        if (level.pack_a_punch.triggers.size == 0) {
            println("<unknown string>");
        }
    #/
    return level.pack_a_punch.triggers;
}

// Namespace zm_pap_util
// Params 0, eflags: 0x0
// namespace_b1e4b463<file_0>::function_cb7546b2
// Checksum 0xe345596f, Offset: 0x488
// Size: 0x20
function function_cb7546b2() {
    return isdefined(self.script_noteworthy) && self.script_noteworthy == "pack_a_punch";
}

// Namespace zm_pap_util
// Params 0, eflags: 0x1 linked
// namespace_b1e4b463<file_0>::function_def6ee85
// Checksum 0xcb916bec, Offset: 0x4b0
// Size: 0x28
function function_def6ee85() {
    init_parameters();
    level.pack_a_punch.var_3c0894ac = 1;
}

// Namespace zm_pap_util
// Params 0, eflags: 0x1 linked
// namespace_b1e4b463<file_0>::function_53616d7e
// Checksum 0x1612c03a, Offset: 0x4e0
// Size: 0x22
function function_53616d7e() {
    if (!isdefined(level.pack_a_punch)) {
        return 0;
    }
    return level.pack_a_punch.var_3c0894ac;
}

// Namespace zm_pap_util
// Params 1, eflags: 0x1 linked
// namespace_b1e4b463<file_0>::function_7e1f2196
// Checksum 0x19b2f724, Offset: 0x510
// Size: 0xd4
function update_hint_string(player) {
    if (self flag::get("pap_offering_gun")) {
        self sethintstring(%ZOMBIE_GET_UPGRADED_FILL);
        return;
    }
    var_49c68f74 = player getcurrentweapon();
    if (zm_weapons::is_weapon_upgraded(var_49c68f74)) {
        self sethintstring(%ZOMBIE_PERK_PACKAPUNCH_AAT, self.var_ebe0c72f);
        return;
    }
    self sethintstring(%ZOMBIE_PERK_PACKAPUNCH, self.cost);
}

// Namespace zm_pap_util
// Params 4, eflags: 0x5 linked
// namespace_b1e4b463<file_0>::function_3fe26769
// Checksum 0xbd47d2ac, Offset: 0x5f0
// Size: 0x3c
function private function_3fe26769(player, trigger, origin_offset, angles_offset) {
    level endon(#"pack_a_punch_off");
    trigger endon(#"pap_player_disconnected");
}

// Namespace zm_pap_util
// Params 4, eflags: 0x5 linked
// namespace_b1e4b463<file_0>::function_f65ac400
// Checksum 0xfd97fa57, Offset: 0x638
// Size: 0x3c
function private function_f65ac400(player, trigger, origin_offset, interact_offset) {
    level endon(#"pack_a_punch_off");
    trigger endon(#"pap_player_disconnected");
}

