#using scripts/codescripts/struct;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace mapping_drone;

// Namespace mapping_drone
// Params 2
// Checksum 0xfea59928, Offset: 0x248
// Size: 0x180
function spawn_drone( str_start_node, b_active )
{
    if ( !isdefined( b_active ) )
    {
        b_active = 1;
    }
    
    level.vh_mapper = vehicle::simple_spawn_single( "mapping_drone" );
    level.vh_mapper.animname = "mapping_drone";
    level.vh_mapper setcandamage( 0 );
    level.vh_mapper notsolid();
    level.vh_mapper sethoverparams( 20, 5, 10 );
    level.vh_mapper.drivepath = 1;
    
    if ( !b_active )
    {
        level.vh_mapper vehicle::lights_off();
        level.vh_mapper vehicle::toggle_sounds( 0 );
    }
    
    if ( isdefined( str_start_node ) )
    {
        nd_start = getvehiclenode( str_start_node, "targetname" );
        level.vh_mapper.origin = nd_start.origin;
        level.vh_mapper.angles = nd_start.angles;
    }
}

// Namespace mapping_drone
// Params 3
// Checksum 0x218d5d8c, Offset: 0x3d0
// Size: 0x104
function follow_path( str_start_node, str_flag, var_178571be )
{
    if ( isdefined( str_flag ) && !level flag::get( str_flag ) )
    {
        nd_start = getvehiclenode( str_start_node, "targetname" );
        self setvehgoalpos( nd_start.origin, 1 );
        level flag::wait_till( str_flag );
        self clearvehgoalpos();
    }
    
    if ( isdefined( var_178571be ) )
    {
        self thread [[ var_178571be ]]();
    }
    
    self thread function_fb6d201d();
    self vehicle::get_on_and_go_path( str_start_node );
}

// Namespace mapping_drone
// Params 1
// Checksum 0x9c0e144f, Offset: 0x4e0
// Size: 0x3c
function function_6a8adcf6( n_speed )
{
    self.n_speed_override = n_speed;
    self setspeed( self.n_speed_override, 35, 35 );
}

// Namespace mapping_drone
// Params 0
// Checksum 0x162d9e4c, Offset: 0x528
// Size: 0xe
function function_2dde6e87()
{
    self.n_speed_override = undefined;
}

// Namespace mapping_drone
// Params 1
// Checksum 0xead26998, Offset: 0x540
// Size: 0x54
function function_74191a2( b_stealth )
{
    if ( !isdefined( b_stealth ) )
    {
        b_stealth = 1;
    }
    
    if ( b_stealth )
    {
        self vehicle::lights_off();
        return;
    }
    
    self vehicle::lights_on();
}

// Namespace mapping_drone
// Params 0
// Checksum 0x6a7a756c, Offset: 0x5a0
// Size: 0x468
function function_fb6d201d()
{
    self endon( #"stop_speed_regulator" );
    self endon( #"reached_end_node" );
    n_forward_view = cos( 89 );
    
    /#
        self thread function_3c36d48d();
    #/
    
    self.n_speed = 0;
    
    while ( true )
    {
        if ( isdefined( self.n_speed_override ) )
        {
            self.n_speed = self.n_speed_override;
            self setspeed( self.n_speed_override, 35, 35 );
            wait 0.05;
            continue;
        }
        
        n_lowest_height_offset = 10000;
        n_closest_dist_sq = 9000000;
        b_player_is_ahead = 0;
        var_a8dc514 = 0;
        b_wait_for_player = 0;
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            n_height_offset = player.origin[ 2 ] + 72 - self.origin[ 2 ];
            n_dist_sq = distancesquared( player.origin, self.origin );
            
            if ( n_height_offset < n_lowest_height_offset )
            {
                n_lowest_height_offset = n_height_offset;
            }
            
            if ( n_dist_sq < n_closest_dist_sq )
            {
                n_closest_dist_sq = n_dist_sq;
            }
            
            if ( n_lowest_height_offset < 152 * -1 )
            {
                var_a8dc514 = 1;
                continue;
            }
            
            if ( abs( n_height_offset ) < 96 )
            {
                if ( util::within_fov( self.origin, self.angles, player.origin, n_forward_view ) )
                {
                    b_player_is_ahead = 1;
                }
            }
        }
        
        if ( !var_a8dc514 && !b_player_is_ahead && n_closest_dist_sq > 2250000 )
        {
            b_wait_for_player = 1;
        }
        
        if ( !b_wait_for_player )
        {
            if ( var_a8dc514 )
            {
                self.n_speed = 35;
            }
            else if ( n_closest_dist_sq <= 562500 || b_player_is_ahead )
            {
                self.n_speed = 25;
            }
            else
            {
                self.n_speed = 5;
            }
            
            if ( level flag::get( "drone_scanning" ) )
            {
                self vehicle::resume_path();
                level flag::clear( "drone_scanning" );
            }
        }
        else
        {
            self.n_speed = 0;
            self vehicle::pause_path();
            
            if ( !level flag::get( "drone_scanning" ) )
            {
                self thread function_517ced56( 60, 90, 15, 50 );
            }
        }
        
        self setspeed( self.n_speed, 35, 35 );
        wait 0.05;
    }
}

/#

    // Namespace mapping_drone
    // Params 0
    // Checksum 0xe080b7f1, Offset: 0xa10
    // Size: 0xea, Type: dev
    function function_3c36d48d()
    {
        self endon( #"stop_speed_regulator" );
        self endon( #"reached_end_node" );
        
        while ( true )
        {
            wait 1;
            
            switch ( self.n_speed )
            {
                case 35:
                    iprintln( "<dev string:x28>" );
                    break;
                case 25:
                    iprintln( "<dev string:x3b>" );
                    break;
                case 5:
                    iprintln( "<dev string:x4d>" );
                    break;
                default:
                    iprintln( "<dev string:x60>" );
                    break;
            }
        }
    }

#/

// Namespace mapping_drone
// Params 4
// Checksum 0xfe7f8847, Offset: 0xb08
// Size: 0x204
function function_517ced56( n_yaw_left, n_yaw_right, n_pitch_down, n_pitch_up )
{
    if ( !isdefined( n_yaw_left ) )
    {
        n_yaw_left = 90;
    }
    
    if ( !isdefined( n_yaw_right ) )
    {
        n_yaw_right = 90;
    }
    
    if ( !isdefined( n_pitch_down ) )
    {
        n_pitch_down = 10;
    }
    
    if ( !isdefined( n_pitch_up ) )
    {
        n_pitch_up = 30;
    }
    
    level flag::set( "drone_scanning" );
    e_base = spawn( "script_origin", self.origin );
    e_base.angles = self.angles;
    self linkto( e_base );
    v_base_look = self.angles;
    
    while ( level flag::get( "drone_scanning" ) )
    {
        v_look_offset = ( randomfloatrange( n_pitch_down * -1, n_pitch_up ), randomfloatrange( n_yaw_left * -1, n_yaw_right ), 0 );
        v_look_angles = v_base_look + v_look_offset;
        e_base rotateto( v_look_angles, 0.5, 0.2, 0.2 );
        e_base waittill( #"rotatedone" );
        wait randomfloatrange( 1, 2 );
    }
    
    e_base delete();
}

// Namespace mapping_drone
// Params 1
// Checksum 0xcb3fe5e2, Offset: 0xd18
// Size: 0x1bc
function function_4f6daa65( b_on )
{
    if ( !isdefined( b_on ) )
    {
        b_on = 1;
    }
    
    if ( b_on )
    {
        self clientfield::set( "extra_cam_ent", 1 );
        
        foreach ( player in level.activeplayers )
        {
            player.menu_pip = player openluimenu( "drone_pip" );
        }
        
        return;
    }
    
    foreach ( player in level.activeplayers )
    {
        if ( isdefined( player.menu_pip ) )
        {
            player thread close_menu_with_delay( player.menu_pip, 1.25 );
            player.menu_pip = undefined;
        }
    }
    
    self clientfield::set( "extra_cam_ent", 0 );
}

// Namespace mapping_drone
// Params 2, eflags: 0x4
// Checksum 0x4f0ff879, Offset: 0xee0
// Size: 0x5c
function private close_menu_with_delay( menuhandle, delay )
{
    self setluimenudata( menuhandle, "close_current_menu", 1 );
    wait delay;
    self closeluimenu( menuhandle );
}

