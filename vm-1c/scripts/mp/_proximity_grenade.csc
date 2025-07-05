#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_proximity_grenade;

#namespace proximity_grenade;

// Namespace proximity_grenade
// Params 0, eflags: 0x2
// Checksum 0x51127d02, Offset: 0x170
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("proximity_grenade", &__init__, undefined, undefined);
}

// Namespace proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x6b9e9a20, Offset: 0x1b0
// Size: 0x14
function __init__() {
    init_shared();
}

