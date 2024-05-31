#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_phoenix_up;

// Namespace zm_bgb_phoenix_up
// Params 0, eflags: 0x2
// namespace_7ffac71e<file_0>::function_2dc19561
// Checksum 0x1a7644a8, Offset: 0x1e8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_phoenix_up", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_phoenix_up
// Params 0, eflags: 0x1 linked
// namespace_7ffac71e<file_0>::function_8c87d8eb
// Checksum 0x74fcaac7, Offset: 0x228
// Size: 0x94
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_phoenix_up", "activated", 1, undefined, undefined, &validation, &activation);
    bgb::register_lost_perk_override("zm_bgb_phoenix_up", &lost_perk_override, 1);
}

// Namespace zm_bgb_phoenix_up
// Params 0, eflags: 0x1 linked
// namespace_7ffac71e<file_0>::function_e4776d0
// Checksum 0xcc00651f, Offset: 0x2c8
// Size: 0x114
function validation() {
    players = level.players;
    foreach (player in players) {
        if (isdefined(player.var_df0decf1) && player.var_df0decf1) {
            return false;
        }
        if (isdefined(level.var_11b06c2f) && self [[ level.var_11b06c2f ]](player, 1, 1)) {
            return true;
        }
        if (self zm_laststand::can_revive(player, 1, 1)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_bgb_phoenix_up
// Params 0, eflags: 0x1 linked
// namespace_7ffac71e<file_0>::function_7afbf7cd
// Checksum 0xb1aa846b, Offset: 0x3e8
// Size: 0x172
function activation() {
    playsoundatposition("zmb_bgb_phoenix_activate", (0, 0, 0));
    players = level.players;
    foreach (player in players) {
        can_revive = 0;
        if (isdefined(level.var_11b06c2f) && self [[ level.var_11b06c2f ]](player, 1, 1)) {
            can_revive = 1;
        } else if (self zm_laststand::can_revive(player, 1, 1)) {
            can_revive = 1;
        }
        if (can_revive) {
            player thread bgb::bgb_revive_watcher();
            player zm_laststand::auto_revive(self, 0);
            self zm_stats::increment_challenge_stat("GUM_GOBBLER_PHOENIX_UP");
        }
    }
}

// Namespace zm_bgb_phoenix_up
// Params 3, eflags: 0x1 linked
// namespace_7ffac71e<file_0>::function_229a2615
// Checksum 0xd209b7eb, Offset: 0x568
// Size: 0x5e
function lost_perk_override(perk, var_2488e46a, var_24df4040) {
    if (!isdefined(var_2488e46a)) {
        var_2488e46a = undefined;
    }
    if (!isdefined(var_24df4040)) {
        var_24df4040 = undefined;
    }
    self thread bgb::function_41ed378b(perk);
    return false;
}

