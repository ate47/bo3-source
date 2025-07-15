#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_gadgets;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;

#namespace _gadget_active_camo;

// Namespace _gadget_active_camo
// Params 0, eflags: 0x2
// Checksum 0x7d4c23dd, Offset: 0x1e8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_active_camo", &__init__, undefined, undefined );
}

// Namespace _gadget_active_camo
// Params 0
// Checksum 0x3682d3b3, Offset: 0x228
// Size: 0x124
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 31, &camo_gadget_on, &camo_gadget_off );
    ability_player::register_gadget_possession_callbacks( 31, &camo_on_give, &camo_on_take );
    ability_player::register_gadget_flicker_callbacks( 31, &camo_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 31, &camo_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 31, &camo_is_flickering );
    callback::on_connect( &camo_on_connect );
    callback::on_spawned( &camo_on_spawn );
    callback::on_disconnect( &camo_on_disconnect );
}

// Namespace _gadget_active_camo
// Params 0
// Checksum 0xcac32374, Offset: 0x358
// Size: 0x44
function camo_on_connect()
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.active_camo ) )
    {
        self [[ level.cybercom.active_camo._on_connect ]]();
    }
}

// Namespace _gadget_active_camo
// Params 0
// Checksum 0x99ec1590, Offset: 0x3a8
// Size: 0x4
function camo_on_disconnect()
{
    
}

// Namespace _gadget_active_camo
// Params 0
// Checksum 0x42ac512d, Offset: 0x3b8
// Size: 0x54
function camo_on_spawn()
{
    self flagsys::clear( "camo_suit_on" );
    self notify( #"camo_off" );
    self clientfield::set( "camo_shader", 0 );
}

// Namespace _gadget_active_camo
// Params 1
// Checksum 0x6acba577, Offset: 0x418
// Size: 0x2a
function camo_is_inuse( slot )
{
    return self flagsys::get( "camo_suit_on" );
}

// Namespace _gadget_active_camo
// Params 1
// Checksum 0xa4d695d2, Offset: 0x450
// Size: 0x22
function camo_is_flickering( slot )
{
    return self gadgetflickering( slot );
}

// Namespace _gadget_active_camo
// Params 2
// Checksum 0x8c7edc40, Offset: 0x480
// Size: 0x5c
function camo_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.active_camo ) )
    {
        self [[ level.cybercom.active_camo._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_active_camo
// Params 2
// Checksum 0x9a713e1c, Offset: 0x4e8
// Size: 0x6c
function camo_on_take( slot, weapon )
{
    self notify( #"camo_removed" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.active_camo ) )
    {
        self [[ level.cybercom.active_camo._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_active_camo
// Params 2
// Checksum 0x770e5f3b, Offset: 0x560
// Size: 0x7c
function camo_on_flicker( slot, weapon )
{
    self thread suspend_camo_suit( slot, weapon );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.active_camo ) )
    {
        self thread [[ level.cybercom.active_camo._on_flicker ]]( slot, weapon );
    }
}

// Namespace _gadget_active_camo
// Params 2
// Checksum 0x8c79d2e8, Offset: 0x5e8
// Size: 0xa4
function camo_gadget_on( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.active_camo ) )
    {
        self thread [[ level.cybercom.active_camo._on ]]( slot, weapon );
    }
    else
    {
        self clientfield::set( "camo_shader", 1 );
    }
    
    self flagsys::set( "camo_suit_on" );
}

// Namespace _gadget_active_camo
// Params 2
// Checksum 0x901995f2, Offset: 0x698
// Size: 0xac
function camo_gadget_off( slot, weapon )
{
    self flagsys::clear( "camo_suit_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.active_camo ) )
    {
        self thread [[ level.cybercom.active_camo._off ]]( slot, weapon );
    }
    
    self notify( #"camo_off" );
    self clientfield::set( "camo_shader", 0 );
}

// Namespace _gadget_active_camo
// Params 2
// Checksum 0x99e18047, Offset: 0x750
// Size: 0x9c
function suspend_camo_suit( slot, weapon )
{
    self endon( #"disconnect" );
    self endon( #"camo_off" );
    self clientfield::set( "camo_shader", 2 );
    suspend_camo_suit_wait( slot, weapon );
    
    if ( self camo_is_inuse( slot ) )
    {
        self clientfield::set( "camo_shader", 1 );
    }
}

// Namespace _gadget_active_camo
// Params 2
// Checksum 0x24113e8a, Offset: 0x7f8
// Size: 0x54
function suspend_camo_suit_wait( slot, weapon )
{
    self endon( #"death" );
    self endon( #"camo_off" );
    
    while ( self camo_is_flickering( slot ) )
    {
        wait 0.5;
    }
}

