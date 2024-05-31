#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_arsenal_accelerator;

// Namespace zm_bgb_arsenal_accelerator
// Params 0, eflags: 0x2
// namespace_3ab5ff91<file_0>::function_2dc19561
// Checksum 0x2fa212e5, Offset: 0x150
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_arsenal_accelerator", &__init__, undefined, undefined);
}

// Namespace zm_bgb_arsenal_accelerator
// Params 0, eflags: 0x1 linked
// namespace_3ab5ff91<file_0>::function_8c87d8eb
// Checksum 0xf11e229, Offset: 0x190
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_arsenal_accelerator", "time");
}

