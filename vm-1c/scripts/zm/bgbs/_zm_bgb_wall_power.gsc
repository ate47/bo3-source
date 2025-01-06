#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_wall_power;

// Namespace zm_bgb_wall_power
// Params 0, eflags: 0x2
// Checksum 0xcb3de2e1, Offset: 0x188
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_wall_power", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_wall_power
// Params 0, eflags: 0x0
// Checksum 0x740b41f8, Offset: 0x1c8
// Size: 0x54
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_wall_power", "event", &event, undefined, undefined, undefined);
}

// Namespace zm_bgb_wall_power
// Params 0, eflags: 0x0
// Checksum 0x2db4a56c, Offset: 0x228
// Size: 0x7c
function event() {
    self endon(#"disconnect");
    self endon(#"bgb_update");
    self waittill(#"zm_bgb_wall_power_used");
    self playsoundtoplayer("zmb_bgb_wall_power", self);
    self zm_stats::increment_challenge_stat("GUM_GOBBLER_WALL_POWER");
    self bgb::do_one_shot_use();
}

