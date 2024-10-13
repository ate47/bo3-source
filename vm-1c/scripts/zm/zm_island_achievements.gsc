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
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_e5adcfd5;

// Namespace namespace_e5adcfd5
// Params 0, eflags: 0x2
// Checksum 0xc885a439, Offset: 0x358
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_island_achievements", &__init__, undefined, undefined);
}

// Namespace namespace_e5adcfd5
// Params 0, eflags: 0x1 linked
// Checksum 0xa8bb2575, Offset: 0x398
// Size: 0x24
function __init__() {
    callback::on_connect(&on_player_connect);
}

// Namespace namespace_e5adcfd5
// Params 0, eflags: 0x1 linked
// Checksum 0xba0add96, Offset: 0x3c8
// Size: 0xac
function on_player_connect() {
    self thread function_5efc5a29();
    self thread function_47538b42();
    self thread function_cdd905fd();
    self thread function_4a12afed();
    self thread function_d6e0957d();
    self thread function_ed8c7d0f();
    self thread function_53f54d29();
}

// Namespace namespace_e5adcfd5
// Params 0, eflags: 0x1 linked
// Checksum 0x6e4c08ce, Offset: 0x480
// Size: 0x44
function function_5efc5a29() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"hash_6c52e305");
    self giveachievement("ZM_ISLAND_CLONE_REVIVE");
}

// Namespace namespace_e5adcfd5
// Params 0, eflags: 0x1 linked
// Checksum 0x1a6422b7, Offset: 0x4d0
// Size: 0x44
function function_47538b42() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"hash_aacf862e");
    self giveachievement("ZM_ISLAND_ELECTRIC_SHIELD");
}

// Namespace namespace_e5adcfd5
// Params 0, eflags: 0x1 linked
// Checksum 0xaf1e6e6a, Offset: 0x520
// Size: 0x44
function function_cdd905fd() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"hash_7afd1ce2");
    self giveachievement("ZM_ISLAND_THRASHER_RESCUE");
}

// Namespace namespace_e5adcfd5
// Params 0, eflags: 0x1 linked
// Checksum 0x942e9146, Offset: 0x570
// Size: 0x44
function function_ed8c7d0f() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"hash_6c020c33");
    self giveachievement("ZM_ISLAND_DRINK_WINE");
}

// Namespace namespace_e5adcfd5
// Params 0, eflags: 0x1 linked
// Checksum 0xe2d75702, Offset: 0x5c0
// Size: 0xe0
function function_53f54d29() {
    level endon(#"end_game");
    self endon(#"disconnect");
    b_done = 0;
    while (!b_done) {
        var_8379db89 = 0;
        while (!self laststand::player_is_in_laststand() && self isplayerunderwater() && zombie_utility::is_player_valid(self) && !b_done) {
            wait 1;
            var_8379db89++;
            if (var_8379db89 >= 60) {
                self giveachievement("ZM_ISLAND_STAY_UNDERWATER");
                b_done = 1;
            }
        }
        wait 0.1;
    }
}

// Namespace namespace_e5adcfd5
// Params 0, eflags: 0x1 linked
// Checksum 0xf5fcd452, Offset: 0x6a8
// Size: 0x44
function function_4a12afed() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"hash_1327d1d5");
    self giveachievement("ZM_ISLAND_DESTROY_WEBS");
}

// Namespace namespace_e5adcfd5
// Params 0, eflags: 0x1 linked
// Checksum 0xb7460fab, Offset: 0x6f8
// Size: 0x44
function function_d6e0957d() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"hash_cf72c127");
    self giveachievement("ZM_ISLAND_WONDER_KILL");
}

