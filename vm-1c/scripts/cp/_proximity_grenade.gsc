#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_proximity_grenade;

#namespace proximity_grenade;

// Namespace proximity_grenade
// Params 0, eflags: 0x2
// Checksum 0x5f78da6, Offset: 0x140
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("proximity_grenade", &__init__, undefined, undefined);
}

// Namespace proximity_grenade
// Params 0, eflags: 0x0
// Checksum 0x5c689880, Offset: 0x180
// Size: 0x14
function __init__() {
    init_shared();
}

