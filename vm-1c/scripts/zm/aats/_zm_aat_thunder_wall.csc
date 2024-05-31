#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/aat_shared;

#namespace namespace_2ffd891d;

// Namespace namespace_2ffd891d
// Params 0, eflags: 0x2
// Checksum 0x15edfc, Offset: 0x128
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_aat_thunder_wall", &__init__, undefined, undefined);
}

// Namespace namespace_2ffd891d
// Params 0, eflags: 0x1 linked
// Checksum 0x66732e47, Offset: 0x168
// Size: 0x44
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_thunder_wall", "zmui_zm_aat_thunder_wall", "t7_icon_zm_aat_thunder_wall");
}

