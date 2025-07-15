#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/weapons/_proximity_grenade;

#namespace proximity_grenade;

// Namespace proximity_grenade
// Params 0, eflags: 0x2
// Checksum 0x22380bd, Offset: 0x140
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "proximity_grenade", &__init__, undefined, undefined );
}

// Namespace proximity_grenade
// Params 0
// Checksum 0xf09300e8, Offset: 0x180
// Size: 0x20
function __init__()
{
    init_shared();
    level.trackproximitygrenadesonowner = 1;
}

