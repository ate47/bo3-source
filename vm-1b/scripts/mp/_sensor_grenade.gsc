#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_sensor_grenade;

#namespace sensor_grenade;

// Namespace sensor_grenade
// Params 0, eflags: 0x2
// Checksum 0x653858ee, Offset: 0x138
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("sensor_grenade", &__init__, undefined, undefined);
}

// Namespace sensor_grenade
// Params 0, eflags: 0x0
// Checksum 0xa6bfe883, Offset: 0x170
// Size: 0x12
function __init__() {
    init_shared();
}

