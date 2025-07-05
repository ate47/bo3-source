#using scripts/shared/aat_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace zm_aat_thunder_wall;

// Namespace zm_aat_thunder_wall
// Params 0, eflags: 0x2
// Checksum 0x15edfc, Offset: 0x128
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_aat_thunder_wall", &__init__, undefined, undefined);
}

// Namespace zm_aat_thunder_wall
// Params 0, eflags: 0x0
// Checksum 0x66732e47, Offset: 0x168
// Size: 0x44
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_thunder_wall", "zmui_zm_aat_thunder_wall", "t7_icon_zm_aat_thunder_wall");
}

