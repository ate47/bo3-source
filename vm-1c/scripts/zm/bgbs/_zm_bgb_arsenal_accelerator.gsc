#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_arsenal_accelerator;

// Namespace zm_bgb_arsenal_accelerator
// Params 0, eflags: 0x2
// Checksum 0x69b661c3, Offset: 0x188
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_arsenal_accelerator", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_arsenal_accelerator
// Params 0, eflags: 0x1 linked
// Checksum 0x34697311, Offset: 0x1c8
// Size: 0x5c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_arsenal_accelerator", "time", 600, &enable, &disable, undefined);
}

// Namespace zm_bgb_arsenal_accelerator
// Params 0, eflags: 0x1 linked
// Checksum 0xbaff06, Offset: 0x230
// Size: 0x24
function enable() {
    self setperk("specialty_overcharge");
}

// Namespace zm_bgb_arsenal_accelerator
// Params 0, eflags: 0x1 linked
// Checksum 0x5e37be27, Offset: 0x260
// Size: 0x24
function disable() {
    self unsetperk("specialty_overcharge");
}

