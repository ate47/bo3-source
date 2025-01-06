#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_proximity_grenade;

#namespace proximity_grenade;

// Namespace proximity_grenade
// Params 0, eflags: 0x2
// Checksum 0x26388e13, Offset: 0x140
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("proximity_grenade", &__init__, undefined, undefined);
}

// Namespace proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0xc2457c3e, Offset: 0x178
// Size: 0x12
function __init__() {
    init_shared();
}

