#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_riotshield;

#namespace riotshield;

// Namespace riotshield
// Params 0, eflags: 0x2
// Checksum 0xcb69a1b5, Offset: 0x188
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("riotshield", &__init__, undefined, undefined);
}

// Namespace riotshield
// Params 0, eflags: 0x0
// Checksum 0xa7ac3186, Offset: 0x1c8
// Size: 0x14
function __init__() {
    init_shared();
}

