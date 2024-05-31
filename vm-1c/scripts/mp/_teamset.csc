#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace teamset;

// Namespace teamset
// Params 0, eflags: 0x2
// namespace_22d37ea2<file_0>::function_2dc19561
// Checksum 0x7cd5ffcd, Offset: 0xc8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("teamset_seals", &__init__, undefined, undefined);
}

// Namespace teamset
// Params 0, eflags: 0x0
// namespace_22d37ea2<file_0>::function_8c87d8eb
// Checksum 0xbbe3b745, Offset: 0x108
// Size: 0x24
function __init__() {
    level.allies_team = "allies";
    level.axis_team = "axis";
}

