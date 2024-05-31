#using scripts/shared/ai/zombie_utility;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_98efd7b6;

// Namespace namespace_98efd7b6
// Params 0, eflags: 0x2
// namespace_98efd7b6<file_0>::function_2dc19561
// Checksum 0x23f7aa0a, Offset: 0x1c8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_round_robbin", &__init__, undefined, "bgb");
}

// Namespace namespace_98efd7b6
// Params 0, eflags: 0x1 linked
// namespace_98efd7b6<file_0>::function_8c87d8eb
// Checksum 0x25faec89, Offset: 0x208
// Size: 0x64
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_round_robbin", "activated", 1, undefined, undefined, &validation, &activation);
}

// Namespace namespace_98efd7b6
// Params 0, eflags: 0x1 linked
// namespace_98efd7b6<file_0>::function_e4776d0
// Checksum 0x8b874073, Offset: 0x278
// Size: 0xb2
function validation() {
    if (!level flag::get("spawn_zombies")) {
        return false;
    }
    zombies = getaiteamarray(level.zombie_team);
    if (!isdefined(zombies) || zombies.size < 1) {
        return false;
    }
    if (isdefined(level.var_35efa94c)) {
        if (![[ level.var_35efa94c ]]()) {
            return false;
        }
    }
    if (isdefined(level.var_dfd95560) && level.var_dfd95560) {
        return false;
    }
    return true;
}

// Namespace namespace_98efd7b6
// Params 0, eflags: 0x1 linked
// namespace_98efd7b6<file_0>::function_7afbf7cd
// Checksum 0xfa8fa683, Offset: 0x338
// Size: 0x102
function activation() {
    level.var_dfd95560 = 1;
    function_8824774d(level.round_number + 1);
    foreach (player in level.players) {
        if (zm_utility::is_player_valid(player)) {
            multiplier = zm_score::get_points_multiplier(player);
            player zm_score::add_to_player_score(multiplier * 1600);
        }
    }
}

// Namespace namespace_98efd7b6
// Params 1, eflags: 0x1 linked
// namespace_98efd7b6<file_0>::function_b10a9b0c
// Checksum 0x5ade134f, Offset: 0x448
// Size: 0x86
function function_b10a9b0c(zombie) {
    if (!isdefined(zombie)) {
        return false;
    }
    if (isdefined(zombie.marked_for_death) && (isdefined(zombie.var_833cfbae) && zombie.var_833cfbae || zombie.marked_for_death) || zm_utility::is_magic_bullet_shield_enabled(zombie)) {
        return false;
    }
    return true;
}

// Namespace namespace_98efd7b6
// Params 1, eflags: 0x1 linked
// namespace_98efd7b6<file_0>::function_8824774d
// Checksum 0x4adbd36b, Offset: 0x4d8
// Size: 0x2e2
function function_8824774d(target_round) {
    if (target_round < 1) {
        target_round = 1;
    }
    level.zombie_total = 0;
    zombie_utility::ai_calculate_health(target_round);
    level.round_number = target_round - 1;
    level notify(#"kill_round");
    playsoundatposition("zmb_bgb_round_robbin", (0, 0, 0));
    wait(0.1);
    zombies = getaiteamarray(level.zombie_team);
    for (i = 0; i < zombies.size; i++) {
        if (isdefined(zombies[i].var_833cfbae) && zombies[i].var_833cfbae) {
            arrayremovevalue(zombies, zombies[i]);
        }
    }
    if (isdefined(zombies)) {
        var_30af5449 = undefined;
        foreach (zombie in zombies) {
            if (function_b10a9b0c(zombie)) {
                var_30af5449 = zombie;
            }
        }
        if (isdefined(var_30af5449)) {
            level.var_1414f4e7 = var_30af5449.origin;
            level notify(#"hash_ddc0a71d", var_30af5449);
        }
    }
    util::wait_network_frame();
    if (isdefined(zombies)) {
        foreach (zombie in zombies) {
            if (!function_b10a9b0c(zombie)) {
                continue;
            }
            zombie dodamage(zombie.health + 666, zombie.origin);
        }
    }
    level.var_dfd95560 = undefined;
}

