#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_bgb;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_burned_out;

// Namespace zm_bgb_burned_out
// Params 0, eflags: 0x2
// namespace_403823cc<file_0>::function_2dc19561
// Checksum 0x4741742b, Offset: 0x260
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_burned_out", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_burned_out
// Params 0, eflags: 0x1 linked
// namespace_403823cc<file_0>::function_8c87d8eb
// Checksum 0x867604fe, Offset: 0x2a0
// Size: 0x154
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_burned_out", "event", &event, undefined, undefined, undefined);
    clientfield::register("toplayer", "zm_bgb_burned_out" + "_1p" + "toplayer", 1, 1, "counter");
    clientfield::register("allplayers", "zm_bgb_burned_out" + "_3p" + "_allplayers", 1, 1, "counter");
    clientfield::register("actor", "zm_bgb_burned_out" + "_fire_torso" + "_actor", 1, 1, "counter");
    clientfield::register("vehicle", "zm_bgb_burned_out" + "_fire_torso" + "_vehicle", 1, 1, "counter");
}

// Namespace zm_bgb_burned_out
// Params 0, eflags: 0x1 linked
// namespace_403823cc<file_0>::function_279e4e97
// Checksum 0x46f389b1, Offset: 0x400
// Size: 0x150
function event() {
    self endon(#"disconnect");
    self endon(#"bgb_update");
    var_63a08f52 = 0;
    self thread bgb::set_timer(2, 2);
    for (;;) {
        amount, attacker, direction_vec, point, type = self waittill(#"damage");
        if ("MOD_MELEE" != type || !isai(attacker)) {
            continue;
        }
        self thread result();
        self playsound("zmb_bgb_powerup_burnedout");
        var_63a08f52++;
        self thread bgb::set_timer(2 - var_63a08f52, 2);
        self bgb::do_one_shot_use();
        if (2 <= var_63a08f52) {
            return;
        }
        wait(1.5);
    }
}

// Namespace zm_bgb_burned_out
// Params 0, eflags: 0x1 linked
// namespace_403823cc<file_0>::function_3c61bfc2
// Checksum 0xd3104a3f, Offset: 0x558
// Size: 0x326
function result() {
    self clientfield::increment_to_player("zm_bgb_burned_out" + "_1p" + "toplayer");
    self clientfield::increment("zm_bgb_burned_out" + "_3p" + "_allplayers");
    zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 720);
    if (!isdefined(zombies)) {
        return;
    }
    dist_sq = 720 * 720;
    var_c8f67e5c = [];
    for (i = 0; i < zombies.size; i++) {
        if (isdefined(zombies[i].ignore_nuke) && zombies[i].ignore_nuke) {
            continue;
        }
        if (isdefined(zombies[i].marked_for_death) && zombies[i].marked_for_death) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
            continue;
        }
        zombies[i].marked_for_death = 1;
        if (isvehicle(zombies[i])) {
            zombies[i] clientfield::increment("zm_bgb_burned_out" + "_fire_torso" + "_vehicle");
        } else {
            zombies[i] clientfield::increment("zm_bgb_burned_out" + "_fire_torso" + "_actor");
        }
        var_c8f67e5c[var_c8f67e5c.size] = zombies[i];
    }
    for (i = 0; i < var_c8f67e5c.size; i++) {
        util::wait_network_frame();
        if (!isdefined(var_c8f67e5c[i])) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(var_c8f67e5c[i])) {
            continue;
        }
        var_c8f67e5c[i] dodamage(var_c8f67e5c[i].health + 666, var_c8f67e5c[i].origin);
        self zm_stats::increment_challenge_stat("GUM_GOBBLER_BURNED_OUT");
    }
}

