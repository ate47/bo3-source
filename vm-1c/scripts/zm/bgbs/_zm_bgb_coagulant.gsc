#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_lightning_chain;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_coagulant;

// Namespace zm_bgb_coagulant
// Params 0, eflags: 0x2
// Checksum 0xa8c7af2d, Offset: 0x1a8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_bgb_coagulant", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_coagulant
// Params 0, eflags: 0x0
// Checksum 0x2dd2054a, Offset: 0x1e8
// Size: 0x64
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_coagulant", "time", 1200, &enable, &disable, undefined, undefined);
}

// Namespace zm_bgb_coagulant
// Params 0, eflags: 0x0
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

// Namespace zm_bgb_coagulant
// Params 0, eflags: 0x0
// Checksum 0x62d30f54, Offset: 0x2c8
// Size: 0xe
function disable() {
    self.n_bleedout_time_multiplier = undefined;
}

