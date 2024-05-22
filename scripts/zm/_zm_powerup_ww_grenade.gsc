#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_melee_weapon;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_blockers;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_e0df0f6f;

// Namespace namespace_e0df0f6f
// Params 0, eflags: 0x2
// Checksum 0x470d412a, Offset: 0x368
// Size: 0x34
function function_2dc19561() {
    system::register("zm_powerup_ww_grenade", &__init__, undefined, undefined);
}

// Namespace namespace_e0df0f6f
// Params 0, eflags: 0x1 linked
// Checksum 0x8a3d045d, Offset: 0x3a8
// Size: 0xdc
function __init__() {
    zm_powerups::register_powerup("ww_grenade", &function_61dfda23);
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("ww_grenade", "p7_zm_power_up_widows_wine", %ZOMBIE_POWERUP_WW_GRENADE, &zm_powerups::func_should_never_drop, 1, 0, 0);
        zm_powerups::powerup_set_player_specific("ww_grenade", 1);
    }
    /#
        level thread function_39ac3091();
    #/
}

// Namespace namespace_e0df0f6f
// Params 1, eflags: 0x1 linked
// Checksum 0x6a09c1e3, Offset: 0x490
// Size: 0x44
function function_61dfda23(player) {
    level thread function_13ccb255(self, player);
    player thread zm_powerups::powerup_vo("bonus_points_solo");
}

// Namespace namespace_e0df0f6f
// Params 2, eflags: 0x1 linked
// Checksum 0x55fb1d02, Offset: 0x4e0
// Size: 0x144
function function_13ccb255(item, player) {
    if (!player laststand::player_is_in_laststand() && !(player.sessionstate == "spectator")) {
        if (player hasperk("specialty_widowswine")) {
            change = 1;
            oldammo = player getweaponammoclip(player.var_8980476);
            maxammo = player.var_8980476.startammo;
            newammo = int(min(maxammo, max(0, oldammo + change)));
            player setweaponammoclip(player.var_8980476, newammo);
        }
    }
}

/#

    // Namespace namespace_e0df0f6f
    // Params 0, eflags: 0x1 linked
    // Checksum 0x909aabdd, Offset: 0x630
    // Size: 0x7c
    function function_39ac3091() {
        level flagsys::wait_till("specialty_widowswine");
        wait(1);
        zm_devgui::add_custom_devgui_callback(&function_dcedd7b5);
        adddebugcommand("specialty_widowswine");
        adddebugcommand("specialty_widowswine");
    }

    // Namespace namespace_e0df0f6f
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd90921b8, Offset: 0x6b8
    // Size: 0x38
    function function_2449723c() {
        if (isdefined(self.var_2654b40c)) {
            if (self.var_2654b40c == gettime()) {
                return 1;
            }
        }
        self.var_2654b40c = gettime();
        return 0;
    }

    // Namespace namespace_e0df0f6f
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3ef104c3, Offset: 0x6f8
    // Size: 0x110
    function function_dcedd7b5(cmd) {
        players = getplayers();
        retval = 0;
        switch (cmd) {
        case 8:
            if (level function_2449723c()) {
                return 1;
            }
            array::thread_all(players, &zm_devgui::zombie_devgui_give_powerup_player, cmd, 1);
            return 1;
        case 8:
            if (level function_2449723c()) {
                return 1;
            }
            array::thread_all(players, &zm_devgui::zombie_devgui_give_powerup_player, getsubstr(cmd, 5), 0);
            return 1;
        }
        return retval;
    }

#/
