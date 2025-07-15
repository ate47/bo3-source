#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;

#namespace util;

// Namespace util
// Params 2
// Checksum 0x2a4248a, Offset: 0x170
// Size: 0x74
function set_streamer_hint_function( func, number_of_zones )
{
    level.func_streamer_hint = func;
    clientfield::register( "world", "force_streamer", 1, getminbitcountfornum( number_of_zones ), "int", &_force_streamer, 0, 0 );
}

// Namespace util
// Params 7
// Checksum 0x8c25f138, Offset: 0x1f0
// Size: 0xac
function _force_streamer( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojumpid )
{
    if ( newval == 0 )
    {
        stopforcingstreamer();
        return;
    }
    
    [[ level.func_streamer_hint ]]( newval );
    level waittill_notify_or_timeout( "streamer_100", 15 );
    streamernotify( newval );
}

// Namespace util
// Params 0
// Checksum 0x45efd6d2, Offset: 0x2a8
// Size: 0xd4
function init_breath_fx()
{
    level.cold_breath = [];
    level._effect[ "player_cold_breath" ] = "player/fx_plyr_breath_steam_1p";
    level._effect[ "ai_cold_breath" ] = "player/fx_plyr_breath_steam_3p";
    clientfield::register( "toplayer", "player_cold_breath", 1, 1, "int", &function_9d577661, 0, 0 );
    clientfield::register( "actor", "ai_cold_breath", 1, 1, "counter", &function_ddc76be5, 0, 0 );
}

// Namespace util
// Params 7
// Checksum 0x4f1f90c5, Offset: 0x388
// Size: 0xb2
function function_9d577661( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        if ( isdefined( level.cold_breath[ localclientnum ] ) && level.cold_breath[ localclientnum ] )
        {
            return;
        }
        
        level.cold_breath[ localclientnum ] = 1;
        self thread function_5556b03d( localclientnum );
        return;
    }
    
    level.cold_breath[ localclientnum ] = 0;
}

// Namespace util
// Params 1
// Checksum 0xd7f0b8cd, Offset: 0x448
// Size: 0xa8
function function_5556b03d( localclientnum )
{
    self endon( #"disconnect" );
    self endon( #"entityshutdown" );
    self endon( #"death" );
    
    while ( isdefined( level.cold_breath[ localclientnum ] ) && level.cold_breath[ localclientnum ] )
    {
        wait randomintrange( 5, 7 );
        playfxoncamera( localclientnum, level._effect[ "player_cold_breath" ], ( 0, 0, 0 ), ( 1, 0, 0 ), ( 0, 0, 1 ) );
    }
}

// Namespace util
// Params 7
// Checksum 0xbc408f40, Offset: 0x4f8
// Size: 0xb8
function function_ddc76be5( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    self endon( #"death" );
    
    while ( isalive( self ) )
    {
        wait randomintrange( 6, 8 );
        playfxontag( localclientnum, level._effect[ "ai_cold_breath" ], self, "j_head" );
    }
}

