#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _gadget_unstoppable_force;

// Namespace _gadget_unstoppable_force
// Params 0, eflags: 0x2
// Checksum 0x67136c8f, Offset: 0x230
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_unstoppable_force", &__init__, undefined, undefined );
}

// Namespace _gadget_unstoppable_force
// Params 0
// Checksum 0x1fe5976a, Offset: 0x270
// Size: 0x114
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 29, &gadget_unstoppable_force_on, &gadget_unstoppable_force_off );
    ability_player::register_gadget_possession_callbacks( 29, &gadget_unstoppable_force_on_give, &gadget_unstoppable_force_on_take );
    ability_player::register_gadget_flicker_callbacks( 29, &gadget_unstoppable_force_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 29, &gadget_unstoppable_force_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 29, &gadget_unstoppable_force_is_flickering );
    callback::on_connect( &gadget_unstoppable_force_on_connect );
    clientfield::register( "toplayer", "unstoppableforce_state", 1, 1, "int" );
}

// Namespace _gadget_unstoppable_force
// Params 1
// Checksum 0x8b370a0d, Offset: 0x390
// Size: 0x2a
function gadget_unstoppable_force_is_inuse( slot )
{
    return self flagsys::get( "gadget_unstoppable_force_on" );
}

// Namespace _gadget_unstoppable_force
// Params 1
// Checksum 0x5269cb30, Offset: 0x3c8
// Size: 0x52
function gadget_unstoppable_force_is_flickering( slot )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.unstoppable_force ) )
    {
        return self [[ level.cybercom.unstoppable_force._is_flickering ]]( slot );
    }
    
    return 0;
}

// Namespace _gadget_unstoppable_force
// Params 2
// Checksum 0xed6d25cc, Offset: 0x428
// Size: 0x5c
function gadget_unstoppable_force_on_flicker( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.unstoppable_force ) )
    {
        self [[ level.cybercom.unstoppable_force._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_unstoppable_force
// Params 2
// Checksum 0x8be54724, Offset: 0x490
// Size: 0x5c
function gadget_unstoppable_force_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.unstoppable_force ) )
    {
        self [[ level.cybercom.unstoppable_force._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_unstoppable_force
// Params 2
// Checksum 0x8f8ed0df, Offset: 0x4f8
// Size: 0x5c
function gadget_unstoppable_force_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.unstoppable_force ) )
    {
        self [[ level.cybercom.unstoppable_force._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_unstoppable_force
// Params 0
// Checksum 0x9033941a, Offset: 0x560
// Size: 0x44
function gadget_unstoppable_force_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.unstoppable_force ) )
    {
        self [[ level.cybercom.unstoppable_force._on_connect ]]();
    }
}

// Namespace _gadget_unstoppable_force
// Params 2
// Checksum 0xeac59acb, Offset: 0x5b0
// Size: 0x7c
function gadget_unstoppable_force_on( slot, weapon )
{
    self flagsys::set( "gadget_unstoppable_force_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.unstoppable_force ) )
    {
        self [[ level.cybercom.unstoppable_force._on ]]( slot, weapon );
    }
}

// Namespace _gadget_unstoppable_force
// Params 2
// Checksum 0x2be1b544, Offset: 0x638
// Size: 0x7c
function gadget_unstoppable_force_off( slot, weapon )
{
    self flagsys::clear( "gadget_unstoppable_force_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.unstoppable_force ) )
    {
        self [[ level.cybercom.unstoppable_force._off ]]( slot, weapon );
    }
}

// Namespace _gadget_unstoppable_force
// Params 2
// Checksum 0xae7fc097, Offset: 0x6c0
// Size: 0x5c
function gadget_firefly_is_primed( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.unstoppable_force ) )
    {
        self [[ level.cybercom.unstoppable_force._is_primed ]]( slot, weapon );
    }
}

