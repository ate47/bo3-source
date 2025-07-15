#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace _gadget_overdrive;

// Namespace _gadget_overdrive
// Params 0, eflags: 0x2
// Checksum 0xeeddcbc6, Offset: 0x250
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_overdrive", &__init__, undefined, undefined );
}

// Namespace _gadget_overdrive
// Params 0
// Checksum 0xabbc3641, Offset: 0x290
// Size: 0x16c
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 28, &gadget_overdrive_on, &gadget_overdrive_off );
    ability_player::register_gadget_possession_callbacks( 28, &gadget_overdrive_on_give, &gadget_overdrive_on_take );
    ability_player::register_gadget_flicker_callbacks( 28, &gadget_overdrive_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 28, &gadget_overdrive_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 28, &gadget_overdrive_is_flickering );
    
    if ( !isdefined( level.vsmgr_prio_visionset_overdrive ) )
    {
        level.vsmgr_prio_visionset_overdrive = 65;
    }
    
    visionset_mgr::register_info( "visionset", "overdrive", 1, level.vsmgr_prio_visionset_overdrive, 15, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0 );
    callback::on_connect( &gadget_overdrive_on_connect );
    clientfield::register( "toplayer", "overdrive_state", 1, 1, "int" );
}

// Namespace _gadget_overdrive
// Params 1
// Checksum 0x51505205, Offset: 0x408
// Size: 0x2a
function gadget_overdrive_is_inuse( slot )
{
    return self flagsys::get( "gadget_overdrive_on" );
}

// Namespace _gadget_overdrive
// Params 1
// Checksum 0x5c698b63, Offset: 0x440
// Size: 0xc
function gadget_overdrive_is_flickering( slot )
{
    
}

// Namespace _gadget_overdrive
// Params 2
// Checksum 0x56cc9f2, Offset: 0x458
// Size: 0x14
function gadget_overdrive_on_flicker( slot, weapon )
{
    
}

// Namespace _gadget_overdrive
// Params 2
// Checksum 0xa2d7e72e, Offset: 0x478
// Size: 0x5c
function gadget_overdrive_on_give( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.overdrive ) )
    {
        self [[ level.cybercom.overdrive._on_give ]]( slot, weapon );
    }
}

// Namespace _gadget_overdrive
// Params 2
// Checksum 0x12fee31a, Offset: 0x4e0
// Size: 0x5c
function gadget_overdrive_on_take( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.overdrive ) )
    {
        self [[ level.cybercom.overdrive._on_take ]]( slot, weapon );
    }
}

// Namespace _gadget_overdrive
// Params 0
// Checksum 0x99ec1590, Offset: 0x548
// Size: 0x4
function gadget_overdrive_on_connect()
{
    
}

// Namespace _gadget_overdrive
// Params 2
// Checksum 0xb972e8a2, Offset: 0x558
// Size: 0x7c
function gadget_overdrive_on( slot, weapon )
{
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.overdrive ) )
    {
        self thread [[ level.cybercom.overdrive._on ]]( slot, weapon );
        self flagsys::set( "gadget_overdrive_on" );
    }
}

// Namespace _gadget_overdrive
// Params 2
// Checksum 0xec528c8, Offset: 0x5e0
// Size: 0x7c
function gadget_overdrive_off( slot, weapon )
{
    self flagsys::clear( "gadget_overdrive_on" );
    
    if ( isdefined( level.cybercom ) && isdefined( level.cybercom.overdrive ) )
    {
        self thread [[ level.cybercom.overdrive._off ]]( slot, weapon );
    }
}

