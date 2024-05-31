#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_3ecfcb30;

// Namespace namespace_3ecfcb30
// Params 0, eflags: 0x2
// namespace_3ecfcb30<file_0>::function_2dc19561
// Checksum 0xd48d2f3e, Offset: 0x170
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_flavor_hexed", &__init__, undefined, undefined);
}

// Namespace namespace_3ecfcb30
// Params 0, eflags: 0x1 linked
// namespace_3ecfcb30<file_0>::function_8c87d8eb
// Checksum 0x156dda0c, Offset: 0x1b0
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_flavor_hexed", "event");
}

