#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_placeable_mine;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_powerup_full_ammo;

// Namespace zm_powerup_full_ammo
// Params 0, eflags: 0x2
// Checksum 0x6ed8010c, Offset: 0x2a8
// Size: 0x34
function function_2dc19561() {
    system::register("zm_powerup_full_ammo", &__init__, undefined, undefined);
}

// Namespace zm_powerup_full_ammo
// Params 0, eflags: 0x1 linked
// Checksum 0x90ebec37, Offset: 0x2e8
// Size: 0x9c
function __init__() {
    zm_powerups::register_powerup("full_ammo", &grab_full_ammo);
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("full_ammo", "p7_zm_power_up_max_ammo", %ZOMBIE_POWERUP_MAX_AMMO, &zm_powerups::func_should_always_drop, 0, 0, 0);
    }
}

// Namespace zm_powerup_full_ammo
// Params 1, eflags: 0x1 linked
// Checksum 0xb8dd8c8a, Offset: 0x390
// Size: 0x44
function grab_full_ammo(player) {
    level thread full_ammo_powerup(self, player);
    player thread zm_powerups::powerup_vo("full_ammo");
}

// Namespace zm_powerup_full_ammo
// Params 2, eflags: 0x1 linked
// Checksum 0x9f494860, Offset: 0x3e0
// Size: 0x2f4
function full_ammo_powerup(drop_item, player) {
    players = getplayers(player.team);
    if (isdefined(level.var_d925b1ef)) {
        players = [[ level.var_d925b1ef ]](player);
    }
    level notify(#"zmb_max_ammo_level");
    for (i = 0; i < players.size; i++) {
        if (players[i] laststand::player_is_in_laststand()) {
            continue;
        }
        if (isdefined(level.check_player_is_ready_for_ammo)) {
            if ([[ level.check_player_is_ready_for_ammo ]](players[i]) == 0) {
                continue;
            }
        }
        primary_weapons = players[i] getweaponslist(1);
        players[i] notify(#"zmb_max_ammo");
        players[i] notify(#"hash_987c489b");
        players[i] zm_placeable_mine::disable_all_prompts_for_player();
        for (x = 0; x < primary_weapons.size; x++) {
            if (level.headshots_only && zm_utility::is_lethal_grenade(primary_weapons[x])) {
                continue;
            }
            if (isdefined(level.zombie_include_equipment) && isdefined(level.zombie_include_equipment[primary_weapons[x]]) && !(isdefined(level.zombie_equipment[primary_weapons[x]].refill_max_ammo) && level.zombie_equipment[primary_weapons[x]].refill_max_ammo)) {
                continue;
            }
            if (isdefined(level.zombie_weapons_no_max_ammo) && isdefined(level.zombie_weapons_no_max_ammo[primary_weapons[x].name])) {
                continue;
            }
            if (zm_utility::is_hero_weapon(primary_weapons[x])) {
                continue;
            }
            if (players[i] hasweapon(primary_weapons[x])) {
                players[i] givemaxammo(primary_weapons[x]);
            }
        }
    }
    level thread full_ammo_on_hud(drop_item, player.team);
}

// Namespace zm_powerup_full_ammo
// Params 2, eflags: 0x1 linked
// Checksum 0xad819033, Offset: 0x6e0
// Size: 0x94
function full_ammo_on_hud(drop_item, player_team) {
    players = getplayers(player_team);
    players[0] playsoundtoteam("zmb_full_ammo", player_team);
    if (isdefined(drop_item)) {
        luinotifyevent(%zombie_notification, 1, drop_item.hint);
    }
}

