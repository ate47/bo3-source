#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_raps;

#namespace raps_mp;

// Namespace raps_mp
// Params 0, eflags: 0x2
// Checksum 0xb3e6a28a, Offset: 0x240
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "raps_mp", &__init__, undefined, undefined );
}

// Namespace raps_mp
// Params 0
// Checksum 0x6b22e53d, Offset: 0x280
// Size: 0xdc
function __init__()
{
    clientfield::register( "vehicle", "monitor_raps_drop_landing", 1, 1, "int", &monitor__drop_landing_changed, 0, 0 );
    clientfield::register( "vehicle", "raps_heli_low_health", 1, 1, "int", &heli_low_health_fx, 0, 0 );
    clientfield::register( "vehicle", "raps_heli_extra_low_health", 1, 1, "int", &heli_extra_low_health_fx, 0, 0 );
}

// Namespace raps_mp
// Params 7
// Checksum 0x8304ecb0, Offset: 0x368
// Size: 0x94
function heli_low_health_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 0 )
    {
        return;
    }
    
    self endon( #"entityshutdown" );
    vehicle::wait_for_dobj( localclientnum );
    playfxontag( localclientnum, "killstreaks/fx_heli_raps_exp_trail", self, "tag_fx_engine_left_front" );
}

// Namespace raps_mp
// Params 7
// Checksum 0xb95afff3, Offset: 0x408
// Size: 0x94
function heli_extra_low_health_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 0 )
    {
        return;
    }
    
    self endon( #"entityshutdown" );
    vehicle::wait_for_dobj( localclientnum );
    playfxontag( localclientnum, "killstreaks/fx_heli_raps_exp_trail", self, "tag_fx_engine_right_back" );
}

// Namespace raps_mp
// Params 7
// Checksum 0x43461af6, Offset: 0x4a8
// Size: 0x5c
function monitor__drop_landing_changed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !newval )
    {
        return;
    }
    
    self thread monitor_drop_landing( localclientnum );
}

// Namespace raps_mp
// Params 1
// Checksum 0x1cba122b, Offset: 0x510
// Size: 0x394
function monitor_drop_landing( localclientnum )
{
    self endon( #"entityshutdown" );
    self notify( #"monitor_drop_landing_entity_singleton" );
    self endon( #"monitor_drop_landing_entity_singleton" );
    a_trace = bullettrace( self.origin + ( 0, 0, -200 ), self.origin + ( 0, 0, -5000 ), 0, self, 1 );
    v_ground = a_trace[ "position" ];
    wait 0.5;
    whoosh_distance = 0;
    
    if ( isdefined( v_ground ) )
    {
        not_close_enough_to_ground = 1;
        
        while ( not_close_enough_to_ground )
        {
            velocity = self getvelocity();
            whoosh_distance = max( whoosh_distance, abs( velocity[ 2 ] ) * 0.15 + 193.044 * 0.15 * 0.15 );
            whoosh_distance_squared = whoosh_distance * whoosh_distance;
            distance_squared = distancesquared( self.origin, v_ground );
            not_close_enough_to_ground = distance_squared > whoosh_distance_squared;
            
            if ( not_close_enough_to_ground )
            {
                wait distance_squared > whoosh_distance_squared * 4 ? 0.1 : 0.05;
            }
        }
        
        self playsound( localclientnum, "veh_raps_first_land" );
    }
    
    while ( distancesquared( self.origin, v_ground ) > 576 || velocity[ 2 ] <= 0 )
    {
        velocity = self getvelocity();
        wait 0.016;
    }
    
    bundle = struct::get_script_bundle( "killstreak", "killstreak_" + "raps" );
    
    if ( isdefined( bundle ) && isdefined( bundle.ksdropdeploylandsurfacefxtable ) && isdefined( a_trace[ "surfacetype" ] ) )
    {
        fx_to_play = getfxfromsurfacetable( bundle.ksdropdeploylandsurfacefxtable, a_trace[ "surfacetype" ] );
        
        if ( isdefined( fx_to_play ) )
        {
            playfx( localclientnum, fx_to_play, self.origin );
        }
    }
    
    if ( isdefined( bundle ) && isdefined( bundle.ksdropdeploylandfx ) )
    {
        playfx( localclientnum, bundle.ksdropdeploylandfx, self.origin );
    }
    
    playrumbleonposition( localclientnum, "raps_land", self.origin );
}

