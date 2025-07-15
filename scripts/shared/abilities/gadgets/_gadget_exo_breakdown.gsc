#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_exo_breakdown;

// Namespace _gadget_exo_breakdown
// Params 0, eflags: 0x2
// Checksum 0x9c7487b6, Offset: 0x200
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_exo_breakdown", &__init__, undefined, undefined );
}

// Namespace _gadget_exo_breakdown
// Params 0
// Checksum 0xa95c1bc1, Offset: 0x240
// Size: 0x104
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 20, &gadget_exo_breakdown_on, &gadget_exo_breakdown_off );
    ability_player::register_gadget_possession_callbacks( 20, &gadget_exo_breakdown_on_give, &gadget_exo_breakdown_on_take );
    ability_player::register_gadget_flicker_callbacks( 20, &gadget_exo_breakdown_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 20, &gadget_exo_breakdown_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 20, &gadget_exo_breakdown_is_flickering );
    ability_player::register_gadget_primed_callbacks( 20, &gadget_exo_breakdown_is_primed );
    callback::on_connect( &gadget_exo_breakdown_on_connect );
}

// Namespace _gadget_exo_breakdown
// Params 1
// Checksum 0x5ce3502e, Offset: 0x350
// Size: 0x2a
function gadget_exo_breakdown_is_inuse( slot )
{
    return self flagsys::get( "gadget_exo_breakdown_on" );
}

// Namespace _gadget_exo_breakdown
// Params 1
// Checksum 0xf27c9b01, Offset: 0x388
// Size: 0x52
function gadget_exo_breakdown_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.exo_breakdown ) )
    {
        return self [[ level.cybercom.exo_breakdown._is_flickering ]]( slot );
    }
    
    return 0;
}

// Namespace _gadget_exo_breakdown
// Params 2
// Checksum 0x8a842248, Offset: 0x3e8
// Size: 0x5c
function gadget_exo_breakdown_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.exo_breakdown ) )
    {
        self [[ level.cybercom.exo_breakdown._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_exo_breakdown
// Params 2
// Checksum 0x560d446c, Offset: 0x450
// Size: 0x5c
function gadget_exo_breakdown_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.exo_breakdown ) )
    {
        self [[ level.cybercom.exo_breakdown._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_exo_breakdown
// Params 2
// Checksum 0xcc9dfa1f, Offset: 0x4b8
// Size: 0x5c
function gadget_exo_breakdown_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.exo_breakdown ) )
    {
        self [[ level.cybercom.exo_breakdown._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_exo_breakdown
// Params 0
// Checksum 0x1db99d0e, Offset: 0x520
// Size: 0x44
function gadget_exo_breakdown_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.exo_breakdown ) )
    {
        self [[ level.cybercom.exo_breakdown._on_connect ]]();
    }
}

// Namespace _gadget_exo_breakdown
// Params 2
// Checksum 0x54ac308b, Offset: 0x570
// Size: 0x7c
function gadget_exo_breakdown_on( slot, weapon )
{
    self flagsys::set( "gadget_exo_breakdown_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.exo_breakdown ) )
    {
        self [[ level.cybercom.exo_breakdown._on ]]( slot, weapon );
    }
}

// Namespace _gadget_exo_breakdown
// Params 2
// Checksum 0x1456bb05, Offset: 0x5f8
// Size: 0x7c
function gadget_exo_breakdown_off( slot, weapon )
{
    self flagsys::clear( "gadget_exo_breakdown_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.exo_breakdown ) )
    {
        self [[ level.cybercom.exo_breakdown._off ]]( slot, weapon );
    }
}

// Namespace _gadget_exo_breakdown
// Params 2
// Checksum 0x5d2e5cae, Offset: 0x680
// Size: 0x5c
function gadget_exo_breakdown_is_primed( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.exo_breakdown ) )
    {
        self [[ level.cybercom.exo_breakdown._is_primed ]]( slot, weapon );
    }
}

