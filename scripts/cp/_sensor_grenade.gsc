#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_sensor_grenade;

#namespace sensor_grenade;

// Namespace sensor_grenade
// Params 0, eflags: 0x2
// Checksum 0xb8ce0f4, Offset: 0x138
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "sensor_grenade", &__init__, undefined, undefined );
}

// Namespace sensor_grenade
// Params 0
// Checksum 0x2da8a354, Offset: 0x178
// Size: 0x14
function __init__()
{
    init_shared();
}

