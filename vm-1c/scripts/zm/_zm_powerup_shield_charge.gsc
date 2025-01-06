#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_melee_weapon;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_powerup_shield_charge;

// Namespace zm_powerup_shield_charge
// Params 0, eflags: 0x2
// Checksum 0xc94a413c, Offset: 0x3a0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_shield_charge", &__init__, undefined, undefined);
}

// Namespace zm_powerup_shield_charge
// Params 0, eflags: 0x0
// Checksum 0x32f6674d, Offset: 0x3e0
// Size: 0xd4
function __init__() {
    zm_powerups::register_powerup("shield_charge", &grab_shield_charge);
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("shield_charge", "p7_zm_zod_nitrous_tank", %ZOMBIE_POWERUP_SHIELD_CHARGE, &func_drop_when_players_own, 1, 0, 0);
        zm_powerups::powerup_set_statless_powerup("shield_charge");
    }
    /#
        thread shield_devgui();
    #/
}

// Namespace zm_powerup_shield_charge
// Params 0, eflags: 0x0
// Checksum 0xf9a21f03, Offset: 0x4c0
// Size: 0x6
function func_drop_when_players_own() {
    return false;
}

// Namespace zm_powerup_shield_charge
// Params 1, eflags: 0x0
// Checksum 0xd7ca6655, Offset: 0x4d0
// Size: 0x44
function grab_shield_charge(player) {
    level thread shield_charge_powerup(self, player);
    player thread zm_powerups::powerup_vo("bonus_points_solo");
}

// Namespace zm_powerup_shield_charge
// Params 2, eflags: 0x0
// Checksum 0xe3ca5a8b, Offset: 0x520
// Size: 0x84
function shield_charge_powerup(item, player) {
    if (isdefined(player.hasriotshield) && player.hasriotshield) {
        player givestartammo(player.weaponriotshield);
    }
    level thread shield_on_hud(item, player.team);
}

// Namespace zm_powerup_shield_charge
// Params 2, eflags: 0x0
// Checksum 0x8f8c061e, Offset: 0x5b0
// Size: 0x124
function shield_on_hud(drop_item, player_team) {
    self endon(#"disconnect");
    hudelem = hud::createserverfontstring("objective", 2, player_team);
    hudelem hud::setpoint("TOP", undefined, 0, level.zombie_vars["zombie_timer_offset"] - level.zombie_vars["zombie_timer_offset_interval"] * 2);
    hudelem.sort = 0.5;
    hudelem.alpha = 0;
    hudelem fadeovertime(0.5);
    hudelem.alpha = 1;
    if (isdefined(drop_item)) {
        hudelem.label = drop_item.hint;
    }
    hudelem thread full_ammo_move_hud(player_team);
}

// Namespace zm_powerup_shield_charge
// Params 1, eflags: 0x0
// Checksum 0x23574ac5, Offset: 0x6e0
// Size: 0xd4
function full_ammo_move_hud(player_team) {
    players = getplayers(player_team);
    players[0] playsoundtoteam("zmb_full_ammo", player_team);
    wait 0.5;
    move_fade_time = 1.5;
    self fadeovertime(move_fade_time);
    self moveovertime(move_fade_time);
    self.y = 270;
    self.alpha = 0;
    wait move_fade_time;
    self destroy();
}

/#

    // Namespace zm_powerup_shield_charge
    // Params 0, eflags: 0x0
    // Checksum 0xc15a4fb5, Offset: 0x7c0
    // Size: 0x7c
    function shield_devgui() {
        level flagsys::wait_till("<dev string:x28>");
        wait 1;
        zm_devgui::add_custom_devgui_callback(&shield_devgui_callback);
        adddebugcommand("<dev string:x41>");
        adddebugcommand("<dev string:x92>");
    }

    // Namespace zm_powerup_shield_charge
    // Params 1, eflags: 0x0
    // Checksum 0x250f4890, Offset: 0x848
    // Size: 0xb4
    function shield_devgui_callback(cmd) {
        players = getplayers();
        retval = 0;
        switch (cmd) {
        case "<dev string:xeb>":
            zm_devgui::zombie_devgui_give_powerup(cmd, 1);
            break;
        case "<dev string:xf9>":
            zm_devgui::zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
            break;
        }
        return retval;
    }

#/
