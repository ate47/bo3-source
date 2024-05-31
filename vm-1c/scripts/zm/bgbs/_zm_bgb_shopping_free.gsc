#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_shopping_free;

// Namespace zm_bgb_shopping_free
// Params 0, eflags: 0x2
// namespace_18c49b5a<file_0>::function_2dc19561
// Checksum 0xea3a306b, Offset: 0x148
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_shopping_free", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_shopping_free
// Params 0, eflags: 0x1 linked
// namespace_18c49b5a<file_0>::function_8c87d8eb
// Checksum 0x517dde6, Offset: 0x188
// Size: 0x64
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_shopping_free", "time", 60, &enable, &disable, undefined, undefined);
}

// Namespace zm_bgb_shopping_free
// Params 0, eflags: 0x1 linked
// namespace_18c49b5a<file_0>::function_bae40a28
// Checksum 0xbf0ac0e8, Offset: 0x1f8
// Size: 0x26
function enable() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
}

// Namespace zm_bgb_shopping_free
// Params 0, eflags: 0x1 linked
// namespace_18c49b5a<file_0>::function_54bdb053
// Checksum 0x99ec1590, Offset: 0x228
// Size: 0x4
function disable() {
    
}

