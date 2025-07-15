#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace _gadget_cleanse;

// Namespace _gadget_cleanse
// Params 0, eflags: 0x2
// Checksum 0x27b72c60, Offset: 0x208
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_cleanse", &__init__, undefined, undefined );
}

// Namespace _gadget_cleanse
// Params 0
// Checksum 0x4c118825, Offset: 0x248
// Size: 0x114
function __init__()
{
    ability_player::register_gadget_activation_callbacks( 17, &gadget_cleanse_on, &gadget_cleanse_off );
    ability_player::register_gadget_possession_callbacks( 17, &gadget_cleanse_on_give, &gadget_cleanse_on_take );
    ability_player::register_gadget_flicker_callbacks( 17, &gadget_cleanse_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 17, &gadget_cleanse_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 17, &gadget_cleanse_is_flickering );
    clientfield::register( "allplayers", "gadget_cleanse_on", 1, 1, "int" );
    callback::on_connect( &gadget_cleanse_on_connect );
}

// Namespace _gadget_cleanse
// Params 1
// Checksum 0x4aa20e2c, Offset: 0x368
// Size: 0x2a
function gadget_cleanse_is_inuse( slot )
{
    return self flagsys::get( "gadget_cleanse_on" );
}

// Namespace _gadget_cleanse
// Params 1
// Checksum 0x5002e5ce, Offset: 0x3a0
// Size: 0x22
function gadget_cleanse_is_flickering( slot )
{
    return self gadgetflickering( slot );
}

// Namespace _gadget_cleanse
// Params 2
// Checksum 0x52484437, Offset: 0x3d0
// Size: 0x34
function gadget_cleanse_on_flicker( slot, weapon )
{
    self thread gadget_cleanse_flicker( slot, weapon );
}

// Namespace _gadget_cleanse
// Params 2
// Checksum 0x38d1ebd, Offset: 0x410
// Size: 0x14
function gadget_cleanse_on_give( slot, weapon )
{
    
}

// Namespace _gadget_cleanse
// Params 2
// Checksum 0xd0d8ea22, Offset: 0x430
// Size: 0x14
function gadget_cleanse_on_take( slot, weapon )
{
    
}

// Namespace _gadget_cleanse
// Params 0
// Checksum 0x99ec1590, Offset: 0x450
// Size: 0x4
function gadget_cleanse_on_connect()
{
    
}

// Namespace _gadget_cleanse
// Params 2
// Checksum 0xd56256f8, Offset: 0x460
// Size: 0x74
function gadget_cleanse_on( slot, weapon )
{
    self flagsys::set( "gadget_cleanse_on" );
    self thread gadget_cleanse_start( slot, weapon );
    self clientfield::set( "gadget_cleanse_on", 1 );
}

// Namespace _gadget_cleanse
// Params 2
// Checksum 0x12146b61, Offset: 0x4e0
// Size: 0x54
function gadget_cleanse_off( slot, weapon )
{
    self flagsys::clear( "gadget_cleanse_on" );
    self clientfield::set( "gadget_cleanse_on", 0 );
}

// Namespace _gadget_cleanse
// Params 2
// Checksum 0x38085cf0, Offset: 0x540
// Size: 0xaa
function gadget_cleanse_start( slot, weapon )
{
    self setempjammed( 0 );
    self gadgetsetactivatetime( slot, gettime() );
    self setnormalhealth( self.maxhealth );
    self setdoublejumpenergy( 1 );
    self stopshellshock();
    self notify( #"gadget_cleanse_on" );
}

// Namespace _gadget_cleanse
// Params 2
// Checksum 0xfc44388a, Offset: 0x5f8
// Size: 0x14
function wait_until_is_done( slot, timepulse )
{
    
}

// Namespace _gadget_cleanse
// Params 2
// Checksum 0x222dccc7, Offset: 0x618
// Size: 0x1e
function gadget_cleanse_flicker( slot, weapon )
{
    self endon( #"disconnect" );
}

// Namespace _gadget_cleanse
// Params 2
// Checksum 0xb5c40f2e, Offset: 0x640
// Size: 0x14
function set_gadget_cleanse_status( status, time )
{
    
}

