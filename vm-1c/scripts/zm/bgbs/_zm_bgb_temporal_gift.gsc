#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_temporal_gift;

// Namespace zm_bgb_temporal_gift
// Params 0, eflags: 0x2
// namespace_906c7034<file_0>::function_2dc19561
// Checksum 0xec834b91, Offset: 0x150
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_temporal_gift", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_temporal_gift
// Params 0, eflags: 0x1 linked
// namespace_906c7034<file_0>::function_8c87d8eb
// Checksum 0xb7c1473f, Offset: 0x190
// Size: 0x5c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_temporal_gift", "rounds", 1, &enable, &disable, undefined);
}

// Namespace zm_bgb_temporal_gift
// Params 0, eflags: 0x1 linked
// namespace_906c7034<file_0>::function_bae40a28
// Checksum 0x99ec1590, Offset: 0x1f8
// Size: 0x4
function enable() {
    
}

// Namespace zm_bgb_temporal_gift
// Params 0, eflags: 0x1 linked
// namespace_906c7034<file_0>::function_54bdb053
// Checksum 0x99ec1590, Offset: 0x208
// Size: 0x4
function disable() {
    
}

