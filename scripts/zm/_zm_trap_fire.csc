#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace zm_trap_fire;

// Namespace zm_trap_fire
// Params 0, eflags: 0x2
// Checksum 0x24bd21b8, Offset: 0x160
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_trap_fire", &__init__, undefined, undefined );
}

// Namespace zm_trap_fire
// Params 0
// Checksum 0xffdb07d7, Offset: 0x1a0
// Size: 0xe2
function __init__()
{
    a_traps = struct::get_array( "trap_fire", "targetname" );
    
    foreach ( trap in a_traps )
    {
        clientfield::register( "world", trap.script_noteworthy, 21000, 1, "int", &trap_fx_monitor, 0, 0 );
    }
}

// Namespace zm_trap_fire
// Params 7
// Checksum 0x4f8771e4, Offset: 0x290
// Size: 0x172
function trap_fx_monitor( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    exploder_name = "trap_fire_" + fieldname;
    
    if ( newval )
    {
        exploder::exploder( exploder_name );
    }
    else
    {
        exploder::stop_exploder( exploder_name );
    }
    
    fire_points = struct::get_array( fieldname, "targetname" );
    
    foreach ( point in fire_points )
    {
        if ( !isdefined( point.script_noteworthy ) )
        {
            if ( newval )
            {
                point thread fire_trap_fx();
                continue;
            }
            
            point thread stop_trap_fx();
        }
    }
}

// Namespace zm_trap_fire
// Params 0
// Checksum 0xaf8398b7, Offset: 0x410
// Size: 0x12c
function fire_trap_fx()
{
    ang = self.angles;
    forward = anglestoforward( ang );
    up = anglestoup( ang );
    
    if ( isdefined( self.loopfx ) && self.loopfx.size )
    {
        stop_trap_fx();
    }
    
    if ( !isdefined( self.loopfx ) )
    {
        self.loopfx = [];
    }
    
    players = getlocalplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        self.loopfx[ i ] = playfx( i, level._effect[ "fire_trap" ], self.origin, forward, up, 0 );
    }
}

// Namespace zm_trap_fire
// Params 0
// Checksum 0x601c4c7f, Offset: 0x548
// Size: 0x88
function stop_trap_fx()
{
    players = getlocalplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( isdefined( self.loopfx[ i ] ) )
        {
            stopfx( i, self.loopfx[ i ] );
        }
    }
    
    self.loopfx = [];
}

