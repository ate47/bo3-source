#using scripts/codescripts/struct;
#using scripts/shared/archetype_shared/archetype_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace wasp;

// Namespace wasp
// Params 0, eflags: 0x2
// Checksum 0x8ebb590e, Offset: 0x1d8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "wasp", &__init__, undefined, undefined );
}

// Namespace wasp
// Params 0
// Checksum 0x6939802f, Offset: 0x218
// Size: 0xb4
function __init__()
{
    clientfield::register( "vehicle", "rocket_wasp_hijacked", 1, 1, "int", &handle_lod_display_for_driver, 0, 0 );
    level.sentinelbundle = struct::get_script_bundle( "killstreak", "killstreak_sentinel" );
    
    if ( isdefined( level.sentinelbundle ) )
    {
        vehicle::add_vehicletype_callback( level.sentinelbundle.ksvehicle, &spawned );
    }
}

// Namespace wasp
// Params 1
// Checksum 0x9bb269c3, Offset: 0x2d8
// Size: 0x1c
function spawned( localclientnum )
{
    self.killstreakbundle = level.sentinelbundle;
}

// Namespace wasp
// Params 7
// Checksum 0x7da71f55, Offset: 0x300
// Size: 0x9c
function handle_lod_display_for_driver( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    
    if ( isdefined( self ) )
    {
        if ( self islocalclientdriver( localclientnum ) )
        {
            self sethighdetail( 1 );
            wait 0.05;
            self vehicle::lights_off( localclientnum );
        }
    }
}

