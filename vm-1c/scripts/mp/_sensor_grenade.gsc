#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_sensor_grenade;

#namespace sensor_grenade;

// Namespace sensor_grenade
// Params 0, eflags: 0x2
// Checksum 0xfb4a9b6b, Offset: 0x138
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("sensor_grenade", &__init__, undefined, undefined);
}

// Namespace sensor_grenade
// Params 0, eflags: 0x0
// Checksum 0x24d5a14c, Offset: 0x178
// Size: 0x14
function __init__() {
    init_shared();
}

