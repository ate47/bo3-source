#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace speedburst;

// Namespace speedburst
// Params 0, eflags: 0x2
// Checksum 0x17d41454, Offset: 0x2c8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_speed_burst", &__init__, undefined, undefined );
}

// Namespace speedburst
// Params 0
// Checksum 0x93c543c5, Offset: 0x308
// Size: 0x16c
function __init__()
{
    clientfield::register( "toplayer", "speed_burst", 1, 1, "int" );
    ability_player::register_gadget_activation_callbacks( 13, &gadget_speed_burst_on, &gadget_speed_burst_off );
    ability_player::register_gadget_possession_callbacks( 13, &gadget_speed_burst_on_give, &gadget_speed_burst_on_take );
    ability_player::register_gadget_flicker_callbacks( 13, &gadget_speed_burst_on_flicker );
    ability_player::register_gadget_is_inuse_callbacks( 13, &gadget_speed_burst_is_inuse );
    ability_player::register_gadget_is_flickering_callbacks( 13, &gadget_speed_burst_is_flickering );
    
    if ( !isdefined( level.vsmgr_prio_visionset_speedburst ) )
    {
        level.vsmgr_prio_visionset_speedburst = 60;
    }
    
    visionset_mgr::register_info( "visionset", "speed_burst", 1, level.vsmgr_prio_visionset_speedburst, 9, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0 );
    callback::on_connect( &gadget_speed_burst_on_connect );
}

// Namespace speedburst
// Params 1
// Checksum 0xdb301688, Offset: 0x480
// Size: 0x2a
function gadget_speed_burst_is_inuse( slot )
{
    return self flagsys::get( "gadget_speed_burst_on" );
}

// Namespace speedburst
// Params 1
// Checksum 0x4b9ce329, Offset: 0x4b8
// Size: 0x22
function gadget_speed_burst_is_flickering( slot )
{
    return self gadgetflickering( slot );
}

// Namespace speedburst
// Params 2
// Checksum 0xde6b0911, Offset: 0x4e8
// Size: 0x34
function gadget_speed_burst_on_flicker( slot, weapon )
{
    self thread gadget_speed_burst_flicker( slot, weapon );
}

// Namespace speedburst
// Params 2
// Checksum 0x7c825f71, Offset: 0x528
// Size: 0x4c
function gadget_speed_burst_on_give( slot, weapon )
{
    flagsys::set( "speed_burst_on" );
    self clientfield::set_to_player( "speed_burst", 0 );
}

// Namespace speedburst
// Params 2
// Checksum 0x995c19e4, Offset: 0x580
// Size: 0x4c
function gadget_speed_burst_on_take( slot, weapon )
{
    flagsys::clear( "speed_burst_on" );
    self clientfield::set_to_player( "speed_burst", 0 );
}

// Namespace speedburst
// Params 0
// Checksum 0x99ec1590, Offset: 0x5d8
// Size: 0x4
function gadget_speed_burst_on_connect()
{
    
}

// Namespace speedburst
// Params 2
// Checksum 0x81291a6a, Offset: 0x5e8
// Size: 0xc8
function gadget_speed_burst_on( slot, weapon )
{
    self flagsys::set( "gadget_speed_burst_on" );
    self gadgetsetactivatetime( slot, gettime() );
    self clientfield::set_to_player( "speed_burst", 1 );
    visionset_mgr::activate( "visionset", "speed_burst", self, 0.4, 0.1, 1.35 );
    self.speedburstlastontime = gettime();
    self.speedburston = 1;
    self.speedburstkill = 0;
}

// Namespace speedburst
// Params 2
// Checksum 0x76b9a15, Offset: 0x6b8
// Size: 0xd4
function gadget_speed_burst_off( slot, weapon )
{
    self notify( #"gadget_speed_burst_off" );
    self flagsys::clear( "gadget_speed_burst_on" );
    self clientfield::set_to_player( "speed_burst", 0 );
    self.speedburstlastontime = gettime();
    self.speedburston = 0;
    
    if ( isdefined( self.speedburstkill ) && isalive( self ) && self.speedburstkill && isdefined( level.playgadgetsuccess ) )
    {
        self [[ level.playgadgetsuccess ]]( weapon );
    }
    
    self.speedburstkill = 0;
}

// Namespace speedburst
// Params 2
// Checksum 0x91476243, Offset: 0x798
// Size: 0xcc
function gadget_speed_burst_flicker( slot, weapon )
{
    self endon( #"disconnect" );
    
    if ( !self gadget_speed_burst_is_inuse( slot ) )
    {
        return;
    }
    
    eventtime = self._gadgets_player[ slot ].gadget_flickertime;
    self set_gadget_status( "Flickering", eventtime );
    
    while ( true )
    {
        if ( !self gadgetflickering( slot ) )
        {
            self set_gadget_status( "Normal" );
            return;
        }
        
        wait 0.5;
    }
}

// Namespace speedburst
// Params 2
// Checksum 0x948e74e, Offset: 0x870
// Size: 0x9c
function set_gadget_status( status, time )
{
    timestr = "";
    
    if ( isdefined( time ) )
    {
        timestr = "^3" + ", time: " + time;
    }
    
    if ( getdvarint( "scr_cpower_debug_prints" ) > 0 )
    {
        self iprintlnbold( "Vision Speed burst: " + status + timestr );
    }
}

