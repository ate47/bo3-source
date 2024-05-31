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

#namespace namespace_767a4e90;

// Namespace namespace_767a4e90
// Params 0, eflags: 0x2
// namespace_767a4e90<file_0>::function_2dc19561
// Checksum 0x68dac2c3, Offset: 0x3f8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_castle_achievements", &__init__, undefined, undefined);
}

// Namespace namespace_767a4e90
// Params 0, eflags: 0x1 linked
// namespace_767a4e90<file_0>::function_8c87d8eb
// Checksum 0xe01b4a82, Offset: 0x438
// Size: 0x74
function __init__() {
    level thread function_c190d113();
    level thread function_a7a00809();
    callback::on_connect(&on_player_connect);
    zm_spawner::register_zombie_death_event_callback(&function_1abfde35);
}

// Namespace namespace_767a4e90
// Params 0, eflags: 0x1 linked
// namespace_767a4e90<file_0>::function_fb4f96b5
// Checksum 0x309766f3, Offset: 0x4b8
// Size: 0xc4
function on_player_connect() {
    self thread function_a54c1d45();
    self thread function_abd6b408();
    self thread function_2ac65a0e();
    self thread function_2aca0270();
    self thread function_763e50f3();
    self thread function_ed9679c1();
    self thread function_fd055c44();
    self thread function_2ec19399();
}

// Namespace namespace_767a4e90
// Params 0, eflags: 0x1 linked
// namespace_767a4e90<file_0>::function_c190d113
// Checksum 0xc0a8abe8, Offset: 0x588
// Size: 0x44
function function_c190d113() {
    level waittill(#"hash_b39ccbbf");
    array::run_all(level.players, &giveachievement, "ZM_CASTLE_EE");
}

// Namespace namespace_767a4e90
// Params 0, eflags: 0x1 linked
// namespace_767a4e90<file_0>::function_a7a00809
// Checksum 0xfe219ccf, Offset: 0x5d8
// Size: 0x6c
function function_a7a00809() {
    for (i = 0; i < 4; i++) {
        level waittill(#"hash_ea0c887b");
    }
    array::run_all(level.players, &giveachievement, "ZM_CASTLE_ALL_BOWS");
}

// Namespace namespace_767a4e90
// Params 0, eflags: 0x1 linked
// namespace_767a4e90<file_0>::function_a54c1d45
// Checksum 0xc8f1d473, Offset: 0x650
// Size: 0x144
function function_a54c1d45() {
    level endon(#"end_game");
    self endon(#"disconnect");
    var_16939907 = [];
    var_16939907["lower_courtyard_flinger"] = 0;
    var_16939907["v10_rocket_pad_flinger"] = 0;
    var_16939907["roof_flinger"] = 0;
    var_16939907["upper_courtyard_flinger"] = 0;
    while (true) {
        str_notify = util::waittill_any_return("disconnect", "lower_courtyard_flinger", "v10_rocket_pad_flinger", "roof_flinger", "upper_courtyard_flinger");
        var_16939907[str_notify]++;
        if (var_16939907["lower_courtyard_flinger"] > 1 && var_16939907["v10_rocket_pad_flinger"] > 1 && var_16939907["roof_flinger"] > 1 && var_16939907["upper_courtyard_flinger"] > 1) {
            break;
        }
    }
    self giveachievement("ZM_CASTLE_WUNDER_TOURIST");
}

// Namespace namespace_767a4e90
// Params 0, eflags: 0x1 linked
// namespace_767a4e90<file_0>::function_abd6b408
// Checksum 0x21e1ab6b, Offset: 0x7a0
// Size: 0x44
function function_abd6b408() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"hash_f00d390e");
    self giveachievement("ZM_CASTLE_WUNDER_SNIPER");
}

// Namespace namespace_767a4e90
// Params 0, eflags: 0x1 linked
// namespace_767a4e90<file_0>::function_2ac65a0e
// Checksum 0x82a77276, Offset: 0x7f0
// Size: 0x94
function function_2ac65a0e() {
    level endon(#"end_game");
    self endon(#"disconnect");
    while (true) {
        player, weapon = level waittill(#"weapon_bought");
        if (player == self && weapon.name == "lmg_light") {
            break;
        }
    }
    self giveachievement("ZM_CASTLE_WALL_RUNNER");
}

// Namespace namespace_767a4e90
// Params 0, eflags: 0x1 linked
// namespace_767a4e90<file_0>::function_2aca0270
// Checksum 0xdb3e7bfd, Offset: 0x890
// Size: 0x64
function function_2aca0270() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self.var_83a6b1fd = 0;
    while (self.var_83a6b1fd < 121) {
        self waittill(#"zombie_zapped");
    }
    self giveachievement("ZM_CASTLE_ELECTROCUTIONER");
}

// Namespace namespace_767a4e90
// Params 0, eflags: 0x1 linked
// namespace_767a4e90<file_0>::function_763e50f3
// Checksum 0x2acd5755, Offset: 0x900
// Size: 0x44
function function_763e50f3() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"hash_a72ebab5");
    self giveachievement("ZM_CASTLE_MECH_TRAPPER");
}

// Namespace namespace_767a4e90
// Params 0, eflags: 0x1 linked
// namespace_767a4e90<file_0>::function_ed9679c1
// Checksum 0xbb595704, Offset: 0x950
// Size: 0x44
function function_ed9679c1() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"hash_ea0c887b");
    self giveachievement("ZM_CASTLE_UPGRADED_BOW");
}

// Namespace namespace_767a4e90
// Params 0, eflags: 0x1 linked
// namespace_767a4e90<file_0>::function_fd055c44
// Checksum 0x5d865042, Offset: 0x9a0
// Size: 0x174
function function_fd055c44() {
    level endon(#"end_game");
    self endon(#"disconnect");
    var_8a655363 = 0;
    while (true) {
        self waittill(#"player_did_a_revive");
        foreach (e_player in level.players) {
            if (isdefined(e_player.b_gravity_trap_spikes_in_ground) && e_player.b_gravity_trap_spikes_in_ground && e_player.var_887585ba === 3) {
                var_d0dad0be = distance(self.origin, e_player.mdl_gravity_trap_fx_source.origin);
                if (var_d0dad0be <= 256) {
                    var_8a655363++;
                    break;
                }
            }
        }
        if (var_8a655363 > 1) {
            break;
        }
    }
    self giveachievement("ZM_CASTLE_SPIKE_REVIVE");
}

// Namespace namespace_767a4e90
// Params 0, eflags: 0x1 linked
// namespace_767a4e90<file_0>::function_2ec19399
// Checksum 0xf8c75c72, Offset: 0xb20
// Size: 0x94
function function_2ec19399() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self.var_544cf8c7 = [];
    self.var_544cf8c7[0] = "mechz";
    self.var_544cf8c7[1] = "zombie";
    self.var_544cf8c7[2] = "sparky";
    self.var_544cf8c7[3] = "napalm";
    self thread function_a0e4a574();
}

// Namespace namespace_767a4e90
// Params 0, eflags: 0x1 linked
// namespace_767a4e90<file_0>::function_a0e4a574
// Checksum 0x7710d64a, Offset: 0xbc0
// Size: 0x3c
function function_a0e4a574() {
    do {
        self waittill(#"hash_430cbeac");
    } while (self.var_544cf8c7.size > 0);
    self giveachievement("ZM_CASTLE_MINIGUN_MURDER");
}

// Namespace namespace_767a4e90
// Params 1, eflags: 0x1 linked
// namespace_767a4e90<file_0>::function_1abfde35
// Checksum 0x11ec1ee, Offset: 0xc08
// Size: 0xec
function function_1abfde35(e_attacker) {
    if (isdefined(e_attacker.is_flung) && e_attacker.is_flung) {
        e_attacker notify(#"hash_f00d390e");
    }
    if (issubstr(self.damageweapon.name, "minigun") && isdefined(e_attacker.var_544cf8c7)) {
        if (isdefined(self.var_9a02a614)) {
            arrayremovevalue(e_attacker.var_544cf8c7, self.var_9a02a614);
        } else {
            arrayremovevalue(e_attacker.var_544cf8c7, self.archetype);
        }
        e_attacker notify(#"hash_430cbeac");
    }
}

