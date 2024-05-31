#using scripts/shared/ai/systems/gib;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_lightning_chain;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_4e2ad0b7;

// Namespace namespace_4e2ad0b7
// Params 0, eflags: 0x2
// namespace_4e2ad0b7<file_0>::function_2dc19561
// Checksum 0xa8c7af2d, Offset: 0x1a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_coagulant", &__init__, undefined, "bgb");
}

// Namespace namespace_4e2ad0b7
// Params 0, eflags: 0x1 linked
// namespace_4e2ad0b7<file_0>::function_8c87d8eb
// Checksum 0x2dd2054a, Offset: 0x1e8
// Size: 0x64
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_coagulant", "time", 1200, &enable, &disable, undefined, undefined);
}

// Namespace namespace_4e2ad0b7
// Params 0, eflags: 0x1 linked
// namespace_4e2ad0b7<file_0>::function_bae40a28
// Checksum 0x7c9767ba, Offset: 0x258
// Size: 0x68
function enable() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    self.n_bleedout_time_multiplier = 3;
    while (true) {
        self waittill(#"player_downed");
        self bgb::do_one_shot_use(1);
    }
}

// Namespace namespace_4e2ad0b7
// Params 0, eflags: 0x1 linked
// namespace_4e2ad0b7<file_0>::function_54bdb053
// Checksum 0x62d30f54, Offset: 0x2c8
// Size: 0xe
function disable() {
    self.n_bleedout_time_multiplier = undefined;
}

