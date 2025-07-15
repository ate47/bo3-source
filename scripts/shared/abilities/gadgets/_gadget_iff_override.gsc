#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_iff_override;

// Namespace _gadget_iff_override
// Params 0, eflags: 0x2
// Checksum 0xaa3ebfbf, Offset: 0x200
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_iff_override", &__init__, undefined, undefined );
}

// Namespace _gadget_iff_override
// Params 0
// Checksum 0x8e026f0f, Offset: 0x240
// Size: 0x104
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 24, &gadget_iff_override_on, &gadget_iff_override_off );
    ability_player::register_gadget_possession_callbacks( 24, &gadget_iff_override_on_give, &gadget_iff_override_on_take );
    ability_player::register_gadget_flicker_callbacks( 24, &gadget_iff_override_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 24, &gadget_iff_override_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 24, &gadget_iff_override_is_flickering );
    ability_player::register_gadget_primed_callbacks( 24, &gadget_iff_override_is_primed );
    callback::on_connect( &gadget_iff_override_on_connect );
}

// Namespace _gadget_iff_override
// Params 1
// Checksum 0xc7e626e1, Offset: 0x350
// Size: 0x2a
function gadget_iff_override_is_inuse( slot )
{
    return self flagsys::get( "gadget_iff_override_on" );
}

// Namespace _gadget_iff_override
// Params 1
// Checksum 0xa0c72c4, Offset: 0x388
// Size: 0x52
function gadget_iff_override_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.iff_override ) )
    {
        return self [[ level.cybercom.iff_override._is_flickering ]]( slot );
    }
    
    return 0;
}

// Namespace _gadget_iff_override
// Params 2
// Checksum 0xc8b79216, Offset: 0x3e8
// Size: 0x5c
function gadget_iff_override_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.iff_override ) )
    {
        self [[ level.cybercom.iff_override._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_iff_override
// Params 2
// Checksum 0x3c891c08, Offset: 0x450
// Size: 0x5c
function gadget_iff_override_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.iff_override ) )
    {
        self [[ level.cybercom.iff_override._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_iff_override
// Params 2
// Checksum 0x851aadbb, Offset: 0x4b8
// Size: 0x5c
function gadget_iff_override_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.iff_override ) )
    {
        self [[ level.cybercom.iff_override._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_iff_override
// Params 0
// Checksum 0x4c291b07, Offset: 0x520
// Size: 0x44
function gadget_iff_override_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.iff_override ) )
    {
        self [[ level.cybercom.iff_override._on_connect ]]();
    }
}

// Namespace _gadget_iff_override
// Params 2
// Checksum 0xebd41df2, Offset: 0x570
// Size: 0x7c
function gadget_iff_override_on( slot, weapon )
{
    self flagsys::set( "gadget_iff_override_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.iff_override ) )
    {
        self [[ level.cybercom.iff_override._on ]]( slot, weapon );
    }
}

// Namespace _gadget_iff_override
// Params 2
// Checksum 0x91eb604, Offset: 0x5f8
// Size: 0x7c
function gadget_iff_override_off( slot, weapon )
{
    self flagsys::clear( "gadget_iff_override_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.iff_override ) )
    {
        self [[ level.cybercom.iff_override._off ]]( slot, weapon );
    }
}

// Namespace _gadget_iff_override
// Params 2
// Checksum 0xf8cad14c, Offset: 0x680
// Size: 0x5c
function gadget_iff_override_is_primed( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.iff_override ) )
    {
        self [[ level.cybercom.iff_override._is_primed ]]( slot, weapon );
    }
}

