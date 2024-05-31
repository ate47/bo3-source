#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_blockers;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_ac1a876c;

// Namespace namespace_ac1a876c
// Params 0, eflags: 0x2
// Checksum 0xb25eb9fa, Offset: 0x2f8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_empty_perk", &__init__, undefined, undefined);
}

// Namespace namespace_ac1a876c
// Params 0, eflags: 0x1 linked
// Checksum 0x92939947, Offset: 0x338
// Size: 0xec
function __init__() {
    zm_powerups::register_powerup("empty_perk", &function_59e7b1f8);
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("empty_perk", "zombie_pickup_perk_bottle", %, &zm_powerups::func_should_never_drop, 1, 0, 0);
        zm_powerups::powerup_set_statless_powerup("empty_perk");
    }
    level.get_player_perk_purchase_limit = &function_c396add0;
    /#
        thread function_ac499d74();
    #/
}

// Namespace namespace_ac1a876c
// Params 1, eflags: 0x1 linked
// Checksum 0xe59ec9fa, Offset: 0x430
// Size: 0x24
function function_59e7b1f8(player) {
    player thread function_ba8751f2();
}

// Namespace namespace_ac1a876c
// Params 0, eflags: 0x1 linked
// Checksum 0xd20565be, Offset: 0x460
// Size: 0x3c
function function_ba8751f2() {
    if (!isdefined(self.var_53690301)) {
        self.var_53690301 = level.perk_purchase_limit;
    }
    if (self.var_53690301 < level.var_1eddc9ee) {
        self.var_53690301++;
    }
}

// Namespace namespace_ac1a876c
// Params 0, eflags: 0x1 linked
// Checksum 0x7648fc35, Offset: 0x4a8
// Size: 0x26
function function_c396add0() {
    if (!isdefined(self.var_53690301)) {
        self.var_53690301 = level.perk_purchase_limit;
    }
    return self.var_53690301;
}

/#

    // Namespace namespace_ac1a876c
    // Params 0, eflags: 0x1 linked
    // Checksum 0x310c5fd1, Offset: 0x4d8
    // Size: 0x7c
    function function_ac499d74() {
        level flagsys::wait_till("<unknown string>");
        wait(1);
        zm_devgui::add_custom_devgui_callback(&function_5d69c3e);
        adddebugcommand("<unknown string>");
        adddebugcommand("<unknown string>");
    }

    // Namespace namespace_ac1a876c
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf3ace2cd, Offset: 0x560
    // Size: 0xb4
    function function_5d69c3e(cmd) {
        players = getplayers();
        retval = 0;
        switch (cmd) {
        case 8:
            zm_devgui::zombie_devgui_give_powerup(cmd, 1);
            break;
        case 8:
            zm_devgui::zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
            break;
        }
        return retval;
    }

#/
