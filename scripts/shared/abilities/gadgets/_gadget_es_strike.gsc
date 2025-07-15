#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_es_strike;

// Namespace _gadget_es_strike
// Params 0, eflags: 0x2
// Checksum 0xd576f1c2, Offset: 0x1f8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_es_strike", &__init__, undefined, undefined );
}

// Namespace _gadget_es_strike
// Params 0
// Checksum 0xc609e697, Offset: 0x238
// Size: 0xe4
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 33, &gadget_es_strike_on, &gadget_es_strike_off );
    ability_player::register_gadget_possession_callbacks( 33, &gadget_es_strike_on_give, &gadget_es_strike_on_take );
    ability_player::register_gadget_flicker_callbacks( 33, &gadget_es_strike_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 33, &gadget_es_strike_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 33, &gadget_es_strike_is_flickering );
    callback::on_connect( &gadget_es_strike_on_connect );
}

// Namespace _gadget_es_strike
// Params 1
// Checksum 0xfe413ea2, Offset: 0x328
// Size: 0x2a
function gadget_es_strike_is_inuse( slot )
{
    return self flagsys::get( "gadget_es_strike_on" );
}

// Namespace _gadget_es_strike
// Params 1
// Checksum 0x4870a517, Offset: 0x360
// Size: 0x50
function gadget_es_strike_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.electro_strike ) )
    {
        return self [[ level.cybercom.electro_strike._is_flickering ]]( slot );
    }
}

// Namespace _gadget_es_strike
// Params 2
// Checksum 0x47145958, Offset: 0x3b8
// Size: 0x5c
function gadget_es_strike_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.electro_strike ) )
    {
        self [[ level.cybercom.electro_strike._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_es_strike
// Params 2
// Checksum 0x1102e94, Offset: 0x420
// Size: 0x5c
function gadget_es_strike_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.electro_strike ) )
    {
        self [[ level.cybercom.electro_strike._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_es_strike
// Params 2
// Checksum 0x2e144acd, Offset: 0x488
// Size: 0x5c
function gadget_es_strike_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.electro_strike ) )
    {
        self [[ level.cybercom.electro_strike._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_es_strike
// Params 0
// Checksum 0xe898dd73, Offset: 0x4f0
// Size: 0x44
function gadget_es_strike_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.electro_strike ) )
    {
        self [[ level.cybercom.electro_strike._on_connect ]]();
    }
}

// Namespace _gadget_es_strike
// Params 2
// Checksum 0x5932273a, Offset: 0x540
// Size: 0x7c
function gadget_es_strike_on( slot, weapon )
{
    self flagsys::set( "gadget_es_strike_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.electro_strike ) )
    {
        self [[ level.cybercom.electro_strike._on ]]( slot, weapon );
    }
}

// Namespace _gadget_es_strike
// Params 2
// Checksum 0xfa3d8db, Offset: 0x5c8
// Size: 0x7c
function gadget_es_strike_off( slot, weapon )
{
    self flagsys::clear( "gadget_es_strike_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.electro_strike ) )
    {
        self [[ level.cybercom.electro_strike._off ]]( slot, weapon );
    }
}

