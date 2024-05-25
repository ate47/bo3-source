#using scripts/zm/zm_zod_util;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_e2600f27;

// Namespace namespace_e2600f27
// Params 0, eflags: 0x2
// Checksum 0xed352723, Offset: 0x3e8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_zod_achievements", &__init__, undefined, undefined);
}

// Namespace namespace_e2600f27
// Params 0, eflags: 0x1 linked
// Checksum 0x1f1fe2e7, Offset: 0x428
// Size: 0x3c
function __init__() {
    level thread function_36ffe1d1();
    callback::on_connect(&on_player_connect);
}

// Namespace namespace_e2600f27
// Params 0, eflags: 0x1 linked
// Checksum 0xa33c22a7, Offset: 0x470
// Size: 0xc4
function on_player_connect() {
    self thread function_ea06cc8c();
    self thread function_f50b1960();
    self thread function_46ea87bb();
    self thread function_b9e36150();
    self thread function_f10a087d();
    self thread function_47cc3ddf();
    self thread function_1f3cbfd1();
    self thread function_d7f7b38b();
}

// Namespace namespace_e2600f27
// Params 0, eflags: 0x0
// Checksum 0x11ffe48b, Offset: 0x540
// Size: 0x96
function function_fc2e6576() {
    level endon(#"end_game");
    level flag::wait_till("ritual_pap_complete");
    a_players = getplayers();
    for (i = 0; i < a_players.size; i++) {
        a_players[i] giveachievement("ZM_HELP_OTHERS");
    }
}

// Namespace namespace_e2600f27
// Params 0, eflags: 0x1 linked
// Checksum 0xc537034a, Offset: 0x5e0
// Size: 0xce
function function_36ffe1d1() {
    level endon(#"end_game");
    var_4c4fcdb0 = array("ritual_boxer_complete", "ritual_detective_complete", "ritual_femme_complete", "ritual_magician_complete");
    level flag::wait_till_all(var_4c4fcdb0);
    a_players = getplayers();
    for (i = 0; i < a_players.size; i++) {
        a_players[i] giveachievement("ZM_COMPLETE_RITUALS");
    }
}

// Namespace namespace_e2600f27
// Params 0, eflags: 0x1 linked
// Checksum 0xf0876c1b, Offset: 0x6b8
// Size: 0x6c
function function_ea06cc8c() {
    level endon(#"end_game");
    self endon(#"disconnect");
    for (var_66f8342 = 0; var_66f8342 < 5; var_66f8342++) {
        self waittill(#"hash_86ef5199");
    }
    self giveachievement("ZM_SPOT_SHADOWMAN");
}

// Namespace namespace_e2600f27
// Params 0, eflags: 0x1 linked
// Checksum 0xe1a8aebc, Offset: 0x730
// Size: 0xfc
function function_f50b1960() {
    level endon(#"end_game");
    self endon(#"disconnect");
    var_a49e2257 = [];
    while (var_a49e2257.size < 5) {
        self waittill(#"bgb_update");
        str_name = self.bgb;
        found = 0;
        for (i = 0; i < var_a49e2257.size; i++) {
            if (var_a49e2257[i] == str_name) {
                found = 1;
                break;
            }
        }
        if (!found) {
            array::add(var_a49e2257, str_name);
        }
    }
    self giveachievement("ZM_GOBBLE_GUM");
}

// Namespace namespace_e2600f27
// Params 0, eflags: 0x1 linked
// Checksum 0xf78cb1f9, Offset: 0x838
// Size: 0xbc
function function_46ea87bb() {
    level endon(#"end_game");
    self endon(#"disconnect");
    for (var_fce7f186 = 0; var_fce7f186 < 10; var_fce7f186++) {
        var_7ef6d493, var_c3f7e0ed = self waittill(#"zombie_death_params");
        if (isdefined(var_7ef6d493) && isstring(var_7ef6d493) && var_7ef6d493 == "zod_store") {
            if (!var_c3f7e0ed) {
            }
        }
    }
    self giveachievement("ZM_STORE_KILL");
}

// Namespace namespace_e2600f27
// Params 0, eflags: 0x1 linked
// Checksum 0xb62628cb, Offset: 0x900
// Size: 0x6c
function function_b9e36150() {
    level endon(#"end_game");
    self endon(#"disconnect");
    while (true) {
        var_c2faf069 = self waittill(#"hash_4438d786");
        if (var_c2faf069 >= 10) {
            break;
        }
    }
    self giveachievement("ZM_ROCKET_SHIELD_KILL");
}

// Namespace namespace_e2600f27
// Params 0, eflags: 0x1 linked
// Checksum 0x7568dcd, Offset: 0x978
// Size: 0x18c
function function_f10a087d() {
    level endon(#"end_game");
    self endon(#"disconnect");
    var_edf7e9c1 = 0;
    var_5c366274 = 0;
    var_6ca52f65 = 0;
    var_aa482c3 = 0;
    var_2c8c3602 = 0;
    while (var_edf7e9c1 < 4) {
        self waittill(#"hash_b7f8e77c");
        var_9b0b20f3 = level.zones[self.zone_name].district;
        if (!var_5c366274 && var_9b0b20f3 == "junction") {
            var_5c366274 = 1;
            var_edf7e9c1++;
            continue;
        }
        if (!var_6ca52f65 && var_9b0b20f3 == "canal") {
            var_6ca52f65 = 1;
            var_edf7e9c1++;
            continue;
        }
        if (!var_aa482c3 && var_9b0b20f3 == "theater") {
            var_aa482c3 = 1;
            var_edf7e9c1++;
            continue;
        }
        if (!var_2c8c3602 && var_9b0b20f3 == "slums") {
            var_2c8c3602 = 1;
            var_edf7e9c1++;
        }
    }
    self giveachievement("ZM_CIVIL_PROTECTOR");
}

// Namespace namespace_e2600f27
// Params 0, eflags: 0x1 linked
// Checksum 0x607acdc4, Offset: 0xb10
// Size: 0x8c
function function_47cc3ddf() {
    level endon(#"end_game");
    self endon(#"disconnect");
    for (var_fce7f186 = 0; var_fce7f186 < 10; var_fce7f186++) {
        var_190c9827 = self waittill(#"widows_wine_kill");
        if (isdefined(var_190c9827) && var_190c9827 == self) {
        }
    }
    self giveachievement("ZM_WINE_GRENADE_KILL");
}

// Namespace namespace_e2600f27
// Params 0, eflags: 0x1 linked
// Checksum 0x8b9ff6c1, Offset: 0xba8
// Size: 0xc4
function function_1f3cbfd1() {
    level endon(#"end_game");
    self endon(#"disconnect");
    var_b8ac8cce = 0;
    while (true) {
        self waittill(#"hash_cdef60d1");
        if (var_b8ac8cce == 0) {
            var_a07758ed = level.round_number;
        } else if (var_a07758ed != level.round_number) {
            var_a07758ed = level.round_number;
            var_b8ac8cce = 0;
        }
        var_b8ac8cce++;
        if (var_b8ac8cce == 2) {
            break;
        }
    }
    self giveachievement("ZM_MARGWA_KILL");
}

// Namespace namespace_e2600f27
// Params 0, eflags: 0x1 linked
// Checksum 0xe08ce765, Offset: 0xc78
// Size: 0x6c
function function_d7f7b38b() {
    level endon(#"end_game");
    self endon(#"disconnect");
    for (var_fce7f186 = 0; var_fce7f186 < 5; var_fce7f186++) {
        self waittill(#"hash_7cbe31f2");
    }
    self giveachievement("ZM_PARASITE_KILL");
}

