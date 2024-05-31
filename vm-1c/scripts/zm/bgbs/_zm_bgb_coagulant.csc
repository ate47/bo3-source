#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_4e2ad0b7;

// Namespace namespace_4e2ad0b7
// Params 0, eflags: 0x2
// namespace_4e2ad0b7<file_0>::function_2dc19561
// Checksum 0x5417e983, Offset: 0x140
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_coagulant", &__init__, undefined, undefined);
}

// Namespace namespace_4e2ad0b7
// Params 0, eflags: 0x1 linked
// namespace_4e2ad0b7<file_0>::function_8c87d8eb
// Checksum 0x96699459, Offset: 0x180
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_coagulant", "time");
}

