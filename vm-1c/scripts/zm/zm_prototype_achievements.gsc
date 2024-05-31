#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/shared/ai/zombie_utility;
#using scripts/zm/_zm_zonemgr;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_12b4f23c;

// Namespace namespace_12b4f23c
// Params 0, eflags: 0x2
// namespace_12b4f23c<file_0>::function_2dc19561
// Checksum 0xe8455936, Offset: 0x2a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_theater_achievements", &__init__, undefined, undefined);
}

// Namespace namespace_12b4f23c
// Params 0, eflags: 0x1 linked
// namespace_12b4f23c<file_0>::function_8c87d8eb
// Checksum 0xdc4a2704, Offset: 0x2e8
// Size: 0x8c
function __init__() {
    level.achievement_sound_func = &achievement_sound_func;
    level thread function_dab290f5();
    level thread function_94bb4bfb();
    zm_spawner::register_zombie_death_event_callback(&function_1abfde35);
    callback::on_connect(&onplayerconnect);
}

// Namespace namespace_12b4f23c
// Params 1, eflags: 0x1 linked
// namespace_12b4f23c<file_0>::function_6b8f2b53
// Checksum 0x17ed5f, Offset: 0x380
// Size: 0xac
function achievement_sound_func(var_43e4662) {
    self endon(#"disconnect");
    if (!sessionmodeisonlinegame()) {
        return;
    }
    for (i = 0; i < self getentitynumber() + 1; i++) {
        util::wait_network_frame();
    }
    self thread zm_utility::do_player_general_vox("general", "achievement");
}

// Namespace namespace_12b4f23c
// Params 0, eflags: 0x1 linked
// namespace_12b4f23c<file_0>::function_603848d5
// Checksum 0xc19ebc29, Offset: 0x438
// Size: 0x1c
function onplayerconnect() {
    self thread function_405cf907();
}

// Namespace namespace_12b4f23c
// Params 0, eflags: 0x1 linked
// namespace_12b4f23c<file_0>::function_dab290f5
// Checksum 0xeceedbd1, Offset: 0x460
// Size: 0x92
function function_dab290f5() {
    level endon(#"end_game");
    level endon(#"hash_634c6ab7");
    level waittill(#"start_zombie_round_logic");
    level thread function_2d04250a();
    while (level.round_number < 3) {
        level waittill(#"end_of_round");
    }
    /#
    #/
    level zm_utility::giveachievement_wrapper("ZM_PROTOTYPE_I_SAID_WERE_CLOSED", 1);
    level notify(#"hash_41c22693");
}

// Namespace namespace_12b4f23c
// Params 0, eflags: 0x1 linked
// namespace_12b4f23c<file_0>::function_2d04250a
// Checksum 0xb9fd093a, Offset: 0x500
// Size: 0xc4
function function_2d04250a() {
    assert(isdefined(level.zombie_spawners), "origin");
    array::thread_all(level.zombie_spawners, &spawner::add_spawn_function, &function_c97e69a9);
    level util::waittill_any("i_said_were_closed_failed", "i_said_were_closed_completed");
    array::run_all(level.zombie_spawners, &spawner::remove_spawn_function, &function_c97e69a9);
}

// Namespace namespace_12b4f23c
// Params 0, eflags: 0x1 linked
// namespace_12b4f23c<file_0>::function_c97e69a9
// Checksum 0xd6420b5f, Offset: 0x5d0
// Size: 0x6e
function function_c97e69a9() {
    self endon(#"death");
    level endon(#"hash_634c6ab7");
    level endon(#"hash_41c22693");
    if (self.archetype !== "zombie") {
        return;
    }
    self waittill(#"completed_emerging_into_playable_area");
    if (self.zone_name === "start_zone") {
        level notify(#"hash_634c6ab7");
    }
}

// Namespace namespace_12b4f23c
// Params 0, eflags: 0x1 linked
// namespace_12b4f23c<file_0>::function_94bb4bfb
// Checksum 0xe9efb006, Offset: 0x648
// Size: 0x4c
function function_94bb4bfb() {
    level endon(#"end_game");
    level endon(#"door_opened");
    level waittill(#"start_of_round");
    while (level.round_number <= 10) {
        level waittill(#"end_of_round");
    }
    /#
    #/
}

// Namespace namespace_12b4f23c
// Params 0, eflags: 0x1 linked
// namespace_12b4f23c<file_0>::function_405cf907
// Checksum 0x387f9bd5, Offset: 0x6a0
// Size: 0x7a
function function_405cf907() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self.var_dc48525e = 0;
    while (self.var_dc48525e < 5) {
        self thread function_b32b243f();
        self function_7ea87222();
    }
    self notify(#"hash_7227b667");
    /#
    #/
}

// Namespace namespace_12b4f23c
// Params 0, eflags: 0x1 linked
// namespace_12b4f23c<file_0>::function_7ea87222
// Checksum 0x28b4e190, Offset: 0x728
// Size: 0x50
function function_7ea87222() {
    level endon(#"end_game");
    level endon(#"end_of_round");
    self endon(#"disconnect");
    while (self.var_dc48525e < 5) {
        self waittill(#"hash_abf05fe4");
        self.var_dc48525e++;
    }
}

// Namespace namespace_12b4f23c
// Params 0, eflags: 0x1 linked
// namespace_12b4f23c<file_0>::function_b32b243f
// Checksum 0xefa45e6d, Offset: 0x780
// Size: 0x40
function function_b32b243f() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self endon(#"hash_7227b667");
    level waittill(#"end_of_round");
    self.var_dc48525e = 0;
}

// Namespace namespace_12b4f23c
// Params 1, eflags: 0x1 linked
// namespace_12b4f23c<file_0>::function_1abfde35
// Checksum 0x43cf3520, Offset: 0x7c8
// Size: 0xec
function function_1abfde35(e_attacker) {
    if (isdefined(e_attacker) && isdefined(self.damagemod) && isdefined(level.var_6572d801) && isdefined(level.var_6572d801["origin"])) {
        if (self.damagemod != "MOD_EXPLOSIVE") {
            return;
        }
        var_d67079b2 = 62500;
        var_6522294b = level.var_6572d801["origin"];
        var_2145bd89 = self.origin + (0, 0, 30);
        if (distancesquared(var_2145bd89, var_6522294b) <= var_d67079b2) {
            e_attacker notify(#"hash_abf05fe4");
        }
    }
}

