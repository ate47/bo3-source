#using scripts/codescripts/struct;
#using scripts/shared/system_shared;

#namespace teamset;

// Namespace teamset
// Params 0, eflags: 0x2
// Checksum 0xd6528da3, Offset: 0xc8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("teamset_seals", &__init__, undefined, undefined);
}

// Namespace teamset
// Params 0, eflags: 0x0
// Checksum 0x90c17534, Offset: 0x100
// Size: 0x22
function __init__() {
    level.allies_team = "allies";
    level.axis_team = "axis";
}

