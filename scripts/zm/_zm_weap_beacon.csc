#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace _zm_weap_beacon;

// Namespace _zm_weap_beacon
// Params 0
// Checksum 0x6fcd52f9, Offset: 0x358
// Size: 0x204
function init()
{
    level.w_beacon = getweapon( "beacon" );
    level.var_67735adb = "wpn_t7_zmb_hd_g_strike_world";
    level._effect[ "beacon_glow" ] = "dlc5/tomb/fx_tomb_beacon_glow";
    level._effect[ "beacon_launch_fx" ] = "dlc5/tomb/fx_tomb_beacon_launch";
    level._effect[ "beacon_shell_explosion" ] = "dlc5/tomb/fx_tomb_beacon_exp";
    level._effect[ "beacon_shell_trail" ] = "dlc5/tomb/fx_tomb_beacon_trail";
    clientfield::register( "world", "play_launch_artillery_fx_robot_0", 21000, 1, "int", &function_59491961, 0, 0 );
    clientfield::register( "world", "play_launch_artillery_fx_robot_1", 21000, 1, "int", &function_59491961, 0, 0 );
    clientfield::register( "world", "play_launch_artillery_fx_robot_2", 21000, 1, "int", &function_59491961, 0, 0 );
    clientfield::register( "scriptmover", "play_beacon_fx", 21000, 1, "int", &function_dc4ed336, 0, 0 );
    clientfield::register( "scriptmover", "play_artillery_barrage", 21000, 2, "int", &play_artillery_barrage, 0, 0 );
}

// Namespace _zm_weap_beacon
// Params 7
// Checksum 0x2310849f, Offset: 0x568
// Size: 0x154
function function_59491961( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( issubstr( fieldname, 0 ) )
    {
        ai_robot = level.a_giant_robots[ localclientnum ][ 0 ];
    }
    else if ( issubstr( fieldname, 1 ) )
    {
        ai_robot = level.a_giant_robots[ localclientnum ][ 1 ];
    }
    else
    {
        ai_robot = level.a_giant_robots[ localclientnum ][ 2 ];
    }
    
    if ( newval == 1 )
    {
        playfx( localclientnum, level._effect[ "beacon_launch_fx" ], ai_robot gettagorigin( "tag_rocketpod" ) );
        level thread function_d391c94e( ai_robot gettagorigin( "tag_rocketpod" ) );
    }
}

// Namespace _zm_weap_beacon
// Params 1
// Checksum 0xac61e5ef, Offset: 0x6c8
// Size: 0x7e
function function_d391c94e( origin )
{
    playsound( 0, "zmb_homingbeacon_missiile_alarm", origin );
    
    for ( i = 0; i < 5 ; i++ )
    {
        playsound( 0, "zmb_homingbeacon_missile_fire", origin );
        wait 0.15;
    }
}

// Namespace _zm_weap_beacon
// Params 7
// Checksum 0x59668049, Offset: 0x750
// Size: 0xb0
function function_dc4ed336( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    self endon( #"hash_962e0148" );
    
    while ( isdefined( self ) )
    {
        playsound( 0, "evt_beacon_beep", self.origin );
        playfxontag( localclientnum, level._effect[ "beacon_glow" ], self, "origin_animate_jnt" );
        wait 1.5;
    }
}

// Namespace _zm_weap_beacon
// Params 7
// Checksum 0x58bce7c3, Offset: 0x808
// Size: 0x2ba
function play_artillery_barrage( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval == 0 )
    {
        return;
    }
    
    if ( newval == 1 )
    {
        if ( !isdefined( self.a_v_land_offsets ) )
        {
            self.a_v_land_offsets = [];
        }
        
        if ( !isdefined( self.a_v_land_offsets[ localclientnum ] ) )
        {
            self.a_v_land_offsets[ localclientnum ] = self build_weap_beacon_landing_offsets();
        }
        
        if ( !isdefined( self.a_v_start_offsets ) )
        {
            self.a_v_start_offsets = [];
        }
        
        if ( !isdefined( self.a_v_start_offsets[ localclientnum ] ) )
        {
            self.a_v_start_offsets[ localclientnum ] = self build_weap_beacon_start_offsets();
        }
    }
    
    if ( newval == 2 )
    {
        if ( !isdefined( self.a_v_land_offsets ) )
        {
            self.a_v_land_offsets = [];
        }
        
        if ( !isdefined( self.a_v_land_offsets[ localclientnum ] ) )
        {
            self.a_v_land_offsets[ localclientnum ] = self build_weap_beacon_landing_offsets_ee();
        }
        
        if ( !isdefined( self.a_v_start_offsets ) )
        {
            self.a_v_start_offsets = [];
        }
        
        if ( !isdefined( self.a_v_start_offsets[ localclientnum ] ) )
        {
            self.a_v_start_offsets[ localclientnum ] = self build_weap_beacon_start_offsets_ee();
        }
    }
    
    if ( !isdefined( self.var_f510f618 ) )
    {
        self.var_f510f618 = [];
    }
    
    if ( !isdefined( self.var_f510f618[ localclientnum ] ) )
    {
        self.var_f510f618[ localclientnum ] = 0;
    }
    
    n_index = self.var_f510f618[ localclientnum ];
    v_start = self.origin + self.a_v_start_offsets[ localclientnum ][ n_index ];
    shell = spawn( localclientnum, v_start, "script_model" );
    shell.angles = ( -90, 0, 0 );
    shell setmodel( "tag_origin" );
    shell thread function_3700164e( self, n_index, v_start, localclientnum );
    self.var_f510f618[ localclientnum ]++;
}

// Namespace _zm_weap_beacon
// Params 0
// Checksum 0x6319ac46, Offset: 0xad0
// Size: 0x88
function build_weap_beacon_landing_offsets()
{
    a_offsets = [];
    a_offsets[ 0 ] = ( 0, 0, 0 );
    a_offsets[ 1 ] = ( -72, 72, 0 );
    a_offsets[ 2 ] = ( 72, 72, 0 );
    a_offsets[ 3 ] = ( 72, -72, 0 );
    a_offsets[ 4 ] = ( -72, -72, 0 );
    return a_offsets;
}

// Namespace _zm_weap_beacon
// Params 0
// Checksum 0x2d221072, Offset: 0xb60
// Size: 0x96
function build_weap_beacon_start_offsets()
{
    a_offsets = [];
    a_offsets[ 0 ] = ( 0, 0, 8500 );
    a_offsets[ 1 ] = ( -6500, 6500, 8500 );
    a_offsets[ 2 ] = ( 6500, 6500, 8500 );
    a_offsets[ 3 ] = ( 6500, -6500, 8500 );
    a_offsets[ 4 ] = ( -6500, -6500, 8500 );
    return a_offsets;
}

// Namespace _zm_weap_beacon
// Params 0
// Checksum 0x9c82acc5, Offset: 0xc00
// Size: 0x178
function build_weap_beacon_landing_offsets_ee()
{
    a_offsets = [];
    a_offsets[ 0 ] = ( 0, 0, 0 );
    a_offsets[ 1 ] = ( -72, 72, 0 );
    a_offsets[ 2 ] = ( 72, 72, 0 );
    a_offsets[ 3 ] = ( 72, -72, 0 );
    a_offsets[ 4 ] = ( -72, -72, 0 );
    a_offsets[ 5 ] = ( -72, 72, 0 );
    a_offsets[ 6 ] = ( 72, 72, 0 );
    a_offsets[ 7 ] = ( 72, -72, 0 );
    a_offsets[ 8 ] = ( -72, -72, 0 );
    a_offsets[ 9 ] = ( -72, 72, 0 );
    a_offsets[ 10 ] = ( 72, 72, 0 );
    a_offsets[ 11 ] = ( 72, -72, 0 );
    a_offsets[ 12 ] = ( -72, -72, 0 );
    a_offsets[ 13 ] = ( -72, 72, 0 );
    a_offsets[ 14 ] = ( 72, 72, 0 );
    return a_offsets;
}

// Namespace _zm_weap_beacon
// Params 0
// Checksum 0xf9455fbb, Offset: 0xd80
// Size: 0x19a
function build_weap_beacon_start_offsets_ee()
{
    a_offsets = [];
    a_offsets[ 0 ] = ( 0, 0, 8500 );
    a_offsets[ 1 ] = ( -6500, 6500, 8500 );
    a_offsets[ 2 ] = ( 6500, 6500, 8500 );
    a_offsets[ 3 ] = ( 6500, -6500, 8500 );
    a_offsets[ 4 ] = ( -6500, -6500, 8500 );
    a_offsets[ 5 ] = ( -6500, 6500, 8500 );
    a_offsets[ 6 ] = ( 6500, 6500, 8500 );
    a_offsets[ 7 ] = ( 6500, -6500, 8500 );
    a_offsets[ 8 ] = ( -6500, -6500, 8500 );
    a_offsets[ 9 ] = ( -6500, 6500, 8500 );
    a_offsets[ 10 ] = ( 6500, 6500, 8500 );
    a_offsets[ 11 ] = ( 6500, -6500, 8500 );
    a_offsets[ 12 ] = ( -6500, -6500, 8500 );
    a_offsets[ 13 ] = ( -6500, 6500, 8500 );
    a_offsets[ 14 ] = ( 6500, 6500, 8500 );
    return a_offsets;
}

// Namespace _zm_weap_beacon
// Params 4
// Checksum 0xa062f7ea, Offset: 0xf28
// Size: 0x1d4
function function_3700164e( model, index, v_start, localclientnum )
{
    v_land = model.origin + model.a_v_land_offsets[ localclientnum ][ index ];
    v_start_trace = v_start - ( 0, 0, 5000 );
    trace = bullettrace( v_start_trace, v_land, 0, undefined );
    v_land = trace[ "position" ];
    self moveto( v_land, 3 );
    playfxontag( localclientnum, level._effect[ "beacon_shell_trail" ], self, "tag_origin" );
    self playsound( 0, "zmb_homingbeacon_missile_boom" );
    self thread function_42cb41ec( v_land );
    self waittill( #"movedone" );
    
    if ( index == 1 )
    {
        model notify( #"hash_962e0148" );
    }
    
    playfx( localclientnum, level._effect[ "beacon_shell_explosion" ], self.origin );
    playsound( 0, "wpn_rocket_explode", self.origin );
    self delete();
}

// Namespace _zm_weap_beacon
// Params 1
// Checksum 0xc674da7, Offset: 0x1108
// Size: 0x34
function function_42cb41ec( origin )
{
    wait 2;
    playsound( 0, "zmb_homingbeacon_missile_incoming", origin );
}

