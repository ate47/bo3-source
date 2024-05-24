#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_blockers;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_free_perk;

// Namespace zm_powerup_free_perk
// Params 0, eflags: 0x2
// Checksum 0xff24fb40, Offset: 0x310
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_free_perk", &__init__, undefined, undefined);
}

// Namespace zm_powerup_free_perk
// Params 0, eflags: 0x1 linked
// Checksum 0xba19622e, Offset: 0x350
// Size: 0x9c
function __init__() {
    zm_powerups::register_powerup("free_perk", &grab_free_perk);
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("free_perk", "zombie_pickup_perk_bottle", %ZOMBIE_POWERUP_FREE_PERK, &zm_powerups::func_should_never_drop, 0, 0, 0);
    }
}

// Namespace zm_powerup_free_perk
// Params 1, eflags: 0x1 linked
// Checksum 0x96523314, Offset: 0x3f8
// Size: 0x24
function grab_free_perk(player) {
    level thread function_bce49437(self);
}

// Namespace zm_powerup_free_perk
// Params 1, eflags: 0x1 linked
// Checksum 0xf3252f3, Offset: 0x428
// Size: 0x196
function function_bce49437(item) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (!players[i] laststand::player_is_in_laststand() && !(players[i].sessionstate == "spectator")) {
            player = players[i];
            if (isdefined(item.var_5bf4e157)) {
                player zm_stats::increment_client_stat("buried_ghost_perk_acquired", 0);
                player zm_stats::increment_player_stat("buried_ghost_perk_acquired");
                player notify(#"hash_df146601");
            }
            free_perk = player zm_perks::function_57435073();
            if (isdefined(level.var_1f6708ea) && level.var_1f6708ea) {
                player thread function_6754a666(free_perk);
            }
            if (isdefined(free_perk) && isdefined(level.var_7b162f9e)) {
                player [[ level.var_7b162f9e ]](free_perk);
            }
        }
    }
}

// Namespace zm_powerup_free_perk
// Params 1, eflags: 0x1 linked
// Checksum 0xcdf32e41, Offset: 0x5c8
// Size: 0xe4
function function_6754a666(perk) {
    self endon(#"disconnect");
    if (isdefined(perk)) {
        wait(0.1);
        if (!level flag::get("power_on")) {
            a_players = getplayers();
            if (isdefined(a_players) && a_players.size == 1 && perk == "specialty_quickrevive") {
                return;
            }
            self zm_perks::perk_pause(perk);
            level flag::wait_till("power_on");
            self zm_perks::perk_unpause(perk);
        }
    }
}

