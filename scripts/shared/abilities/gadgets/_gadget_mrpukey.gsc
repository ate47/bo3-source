#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_mrpukey;

// Namespace _gadget_mrpukey
// Params 0, eflags: 0x2
// Checksum 0x3059694e, Offset: 0x1f0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_mrpukey", &__init__, undefined, undefined );
}

// Namespace _gadget_mrpukey
// Params 0
// Checksum 0xc3277878, Offset: 0x230
// Size: 0xe4
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 38, &gadget_mrpukey_on, &gadget_mrpukey_off );
    ability_player::register_gadget_possession_callbacks( 38, &gadget_mrpukey_on_give, &gadget_mrpukey_on_take );
    ability_player::register_gadget_flicker_callbacks( 38, &gadget_mrpukey_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 38, &gadget_mrpukey_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 38, &gadget_mrpukey_is_flickering );
    ability_player::register_gadget_primed_callbacks( 38, &gadget_mrpukey_is_primed );
}

// Namespace _gadget_mrpukey
// Params 1
// Checksum 0x5320560f, Offset: 0x320
// Size: 0x2a
function gadget_mrpukey_is_inuse( slot )
{
    return self flagsys::get( "gadget_mrpukey_on" );
}

// Namespace _gadget_mrpukey
// Params 1
// Checksum 0xc50c3ca2, Offset: 0x358
// Size: 0x50
function gadget_mrpukey_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.mrpukey ) )
    {
        return self [[ level.cybercom.mrpukey._is_flickering ]]( slot );
    }
}

// Namespace _gadget_mrpukey
// Params 2
// Checksum 0xc810ad, Offset: 0x3b0
// Size: 0x5c
function gadget_mrpukey_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.mrpukey ) )
    {
        self [[ level.cybercom.mrpukey._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_mrpukey
// Params 2
// Checksum 0xab1ccd16, Offset: 0x418
// Size: 0x5c
function gadget_mrpukey_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.mrpukey ) )
    {
        self [[ level.cybercom.mrpukey._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_mrpukey
// Params 2
// Checksum 0xe9fe21a9, Offset: 0x480
// Size: 0x5c
function gadget_mrpukey_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.mrpukey ) )
    {
        self [[ level.cybercom.mrpukey._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_mrpukey
// Params 0
// Checksum 0x3662da1b, Offset: 0x4e8
// Size: 0x44
function gadge_mrpukey_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.mrpukey ) )
    {
        self [[ level.cybercom.mrpukey._on_connect ]]();
    }
}

// Namespace _gadget_mrpukey
// Params 2
// Checksum 0x262da596, Offset: 0x538
// Size: 0x7c
function gadget_mrpukey_on( slot, weapon )
{
    self flagsys::set( "gadget_mrpukey_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.mrpukey ) )
    {
        self [[ level.cybercom.mrpukey._on ]]( slot, weapon );
    }
}

// Namespace _gadget_mrpukey
// Params 2
// Checksum 0xee2cd722, Offset: 0x5c0
// Size: 0x7c
function gadget_mrpukey_off( slot, weapon )
{
    self flagsys::clear( "gadget_mrpukey_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.mrpukey ) )
    {
        self [[ level.cybercom.mrpukey._off ]]( slot, weapon );
    }
}

// Namespace _gadget_mrpukey
// Params 2
// Checksum 0x65f01284, Offset: 0x648
// Size: 0x5c
function gadget_mrpukey_is_primed( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.mrpukey ) )
    {
        self [[ level.cybercom.mrpukey._is_primed ]]( slot, weapon );
    }
}

