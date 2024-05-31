#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_4566f62;

// Namespace namespace_4566f62
// Params 0, eflags: 0x2
// namespace_4566f62<file_0>::function_2dc19561
// Checksum 0x3327b3a5, Offset: 0x198
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_im_feelin_lucky", &__init__, undefined, "bgb");
}

// Namespace namespace_4566f62
// Params 0, eflags: 0x1 linked
// namespace_4566f62<file_0>::function_8c87d8eb
// Checksum 0x618abac6, Offset: 0x1d8
// Size: 0x54
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_im_feelin_lucky", "activated", 2, undefined, undefined, undefined, &activation);
}

// Namespace namespace_4566f62
// Params 0, eflags: 0x1 linked
// namespace_4566f62<file_0>::function_7afbf7cd
// Checksum 0x13e16015, Offset: 0x238
// Size: 0x1bc
function activation() {
    powerup_origin = self bgb::get_player_dropped_powerup_origin();
    var_a8c63b5d = 0.75;
    n_roll = randomfloatrange(0, 1);
    if (n_roll < var_a8c63b5d) {
        e_powerup = zm_powerups::specific_powerup_drop(zm_powerups::get_regular_random_powerup_name(), powerup_origin);
    } else {
        if (isdefined(level.var_2d0e5eb6)) {
            str_powerup = [[ level.var_2d0e5eb6 ]]();
        } else {
            str_powerup = function_29a9b9b8();
        }
        if (str_powerup === "free_perk") {
            if (isdefined(level.var_2d0e5eb6)) {
                str_powerup = [[ level.var_2d0e5eb6 ]]();
            } else {
                str_powerup = function_29a9b9b8();
            }
        }
        e_powerup = zm_powerups::specific_powerup_drop(str_powerup, powerup_origin, undefined, undefined, undefined, self);
    }
    var_bc1994bd = zm_utility::check_point_in_enabled_zone(e_powerup.origin, undefined, undefined);
    wait(1);
    if (!var_bc1994bd) {
        level thread bgb::function_434235f9(e_powerup);
    }
}

// Namespace namespace_4566f62
// Params 0, eflags: 0x1 linked
// namespace_4566f62<file_0>::function_29a9b9b8
// Checksum 0x43562edc, Offset: 0x400
// Size: 0xf2
function function_29a9b9b8() {
    var_d7a75a6e = getarraykeys(level.zombie_powerups);
    var_d7a75a6e = array::randomize(var_d7a75a6e);
    foreach (str_key in var_d7a75a6e) {
        if (level.zombie_powerups[str_key].player_specific === 1) {
            arrayremovevalue(var_d7a75a6e, str_key);
        }
    }
    return var_d7a75a6e[0];
}

