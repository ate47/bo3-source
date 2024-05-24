#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_extra_credit;

// Namespace zm_bgb_extra_credit
// Params 0, eflags: 0x2
// Checksum 0xed280d97, Offset: 0x190
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_extra_credit", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_extra_credit
// Params 0, eflags: 0x1 linked
// Checksum 0x86932f6, Offset: 0x1d0
// Size: 0x54
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_extra_credit", "activated", 4, undefined, undefined, undefined, &activation);
}

// Namespace zm_bgb_extra_credit
// Params 0, eflags: 0x1 linked
// Checksum 0xf80a50fa, Offset: 0x230
// Size: 0x44
function activation() {
    powerup_origin = self bgb::get_player_dropped_powerup_origin();
    self thread function_b18c3b2d(powerup_origin);
}

// Namespace zm_bgb_extra_credit
// Params 1, eflags: 0x1 linked
// Checksum 0xd8283fff, Offset: 0x280
// Size: 0xd4
function function_b18c3b2d(origin) {
    self endon(#"disconnect");
    self endon(#"bled_out");
    e_powerup = zm_powerups::specific_powerup_drop("bonus_points_player", origin, undefined, undefined, 0.1);
    e_powerup.bonus_points_powerup_override = &function_3258dd42;
    wait(1);
    if (!e_powerup zm::in_enabled_playable_area() && isdefined(e_powerup) && !e_powerup zm::in_life_brush()) {
        level thread bgb::function_434235f9(e_powerup);
    }
}

// Namespace zm_bgb_extra_credit
// Params 0, eflags: 0x1 linked
// Checksum 0xf150569d, Offset: 0x360
// Size: 0x8
function function_3258dd42() {
    return 1250;
}

