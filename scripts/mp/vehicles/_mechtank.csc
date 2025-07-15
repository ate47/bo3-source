#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace mechtank;

// Namespace mechtank
// Params 0, eflags: 0x2
// Checksum 0x2e1508cb, Offset: 0x168
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "mechtank", &__init__, undefined, undefined );
}

// Namespace mechtank
// Params 0
// Checksum 0xa11dd81, Offset: 0x1a8
// Size: 0x2c
function __init__()
{
    vehicle::add_vehicletype_callback( "mechtank", &_setup_ );
}

// Namespace mechtank
// Params 1
// Checksum 0xd7e83fa3, Offset: 0x1e0
// Size: 0x3c
function _setup_( localclientnum )
{
    self thread player_enter( localclientnum );
    self thread player_exit( localclientnum );
}

// Namespace mechtank
// Params 1
// Checksum 0x6139cc55, Offset: 0x228
// Size: 0x80
function player_enter( localclientnum )
{
    self endon( #"death" );
    self endon( #"entityshutdown" );
    
    while ( true )
    {
        self waittill( #"enter_vehicle", player );
        
        if ( self islocalclientdriver( localclientnum ) )
        {
            self sethighdetail( 1 );
        }
        
        wait 0.016;
    }
}

// Namespace mechtank
// Params 1
// Checksum 0x7036de4b, Offset: 0x2b0
// Size: 0x88
function player_exit( localclientnum )
{
    self endon( #"death" );
    self endon( #"entityshutdown" );
    
    while ( true )
    {
        self waittill( #"exit_vehicle", player );
        
        if ( isdefined( player ) && player islocalplayer() )
        {
            self sethighdetail( 0 );
        }
        
        wait 0.016;
    }
}

