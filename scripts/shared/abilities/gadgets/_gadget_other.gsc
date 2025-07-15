#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace _gadget_other;

// Namespace _gadget_other
// Params 0, eflags: 0x2
// Checksum 0xadf710e8, Offset: 0x218
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_other", &__init__, undefined, undefined );
}

// Namespace _gadget_other
// Params 0
// Checksum 0xf02213d9, Offset: 0x258
// Size: 0xe4
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 1, &gadget_other_on_activate, &gadget_other_on_off );
    ability_player::register_gadget_possession_callbacks( 1, &gadget_other_on_give, &gadget_other_on_take );
    ability_player::register_gadget_flicker_callbacks( 1, &gadget_other_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 1, &gadget_other_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 1, &gadget_other_is_flickering );
    ability_player::register_gadget_ready_callbacks( 1, &gadget_other_ready );
}

// Namespace _gadget_other
// Params 1
// Checksum 0x8d058f, Offset: 0x348
// Size: 0x22
function gadget_other_is_inuse( slot )
{
    return self gadgetisactive( slot );
}

// Namespace _gadget_other
// Params 1
// Checksum 0xedf8b652, Offset: 0x378
// Size: 0x22
function gadget_other_is_flickering( slot )
{
    return self gadgetflickering( slot );
}

// Namespace _gadget_other
// Params 2
// Checksum 0x38321943, Offset: 0x3a8
// Size: 0x14
function gadget_other_on_flicker( slot, weapon )
{
    
}

// Namespace _gadget_other
// Params 2
// Checksum 0x3cad2797, Offset: 0x3c8
// Size: 0x14
function gadget_other_on_give( slot, weapon )
{
    
}

// Namespace _gadget_other
// Params 2
// Checksum 0x9622ab3d, Offset: 0x3e8
// Size: 0x14
function gadget_other_on_take( slot, weapon )
{
    
}

// Namespace _gadget_other
// Params 0
// Checksum 0x99ec1590, Offset: 0x408
// Size: 0x4
function gadget_other_on_connect()
{
    
}

// Namespace _gadget_other
// Params 0
// Checksum 0x99ec1590, Offset: 0x418
// Size: 0x4
function gadget_other_on_spawn()
{
    
}

// Namespace _gadget_other
// Params 2
// Checksum 0xaafbe343, Offset: 0x428
// Size: 0x14
function gadget_other_on_activate( slot, weapon )
{
    
}

// Namespace _gadget_other
// Params 2
// Checksum 0xbaca77c8, Offset: 0x448
// Size: 0x14
function gadget_other_on_off( slot, weapon )
{
    
}

// Namespace _gadget_other
// Params 2
// Checksum 0xc990ae0a, Offset: 0x468
// Size: 0x14
function gadget_other_ready( slot, weapon )
{
    
}

// Namespace _gadget_other
// Params 3
// Checksum 0x993adb86, Offset: 0x488
// Size: 0xb4
function set_gadget_other_status( weapon, status, time )
{
    timestr = "";
    
    if ( isdefined( time ) )
    {
        timestr = "^3" + ", time: " + time;
    }
    
    if ( getdvarint( "scr_cpower_debug_prints" ) > 0 )
    {
        self iprintlnbold( "Gadget Other " + weapon.name + ": " + status + timestr );
    }
}

