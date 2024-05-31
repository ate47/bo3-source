#using scripts/shared/weapons/_sensor_grenade;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace sensor_grenade;

// Namespace sensor_grenade
// Params 0, eflags: 0x2
// namespace_d357f370<file_0>::function_2dc19561
// Checksum 0xb8ce0f4, Offset: 0x138
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("sensor_grenade", &__init__, undefined, undefined);
}

// Namespace sensor_grenade
// Params 0, eflags: 0x1 linked
// namespace_d357f370<file_0>::function_8c87d8eb
// Checksum 0x2da8a354, Offset: 0x178
// Size: 0x14
function __init__() {
    init_shared();
}

