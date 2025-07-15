#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace vehicle_platform;

// Namespace vehicle_platform
// Method(s) 15 Total 15
class cvehicleplatform
{

    // Namespace cvehicleplatform
    // Params 5
    // Checksum 0xee12698c, Offset: 0x14f0
    // Size: 0x118
    function move_elevator_doors( platform_target, direction, v_moveto, v_angles, n_time )
    {
        level endon( self.m_str_platform_name + "_disabled" );
        platform_target linkto( self.m_e_platform );
        
        while ( true )
        {
            level waittill( direction + self.m_str_platform_name + "_doors" );
            platform_target unlink();
            platform_target moveto( platform_target.origin + v_moveto, n_time );
            platform_target rotateto( platform_target.angles + v_angles, n_time );
            wait n_time;
            platform_target linkto( self.m_e_platform );
        }
    }

    // Namespace cvehicleplatform
    // Params 1
    // Checksum 0xf160328a, Offset: 0x11d0
    // Size: 0x314
    function setup_elevator_doors( platform_target )
    {
        open_struct = struct::get( platform_target.target, "targetname" );
        assert( isdefined( open_struct ), "<dev string:xc2>" + platform_target.origin );
        assert( isdefined( open_struct.target ), "<dev string:x104>" + platform_target.origin );
        closed_struct = struct::get( open_struct.target, "targetname" );
        assert( isdefined( closed_struct ), "<dev string:x150>" + platform_target.origin );
        n_opening_time = isdefined( open_struct.script_float ) ? open_struct.script_float : 1;
        n_closing_time = isdefined( closed_struct.script_float ) ? closed_struct.script_float : 1;
        stay_closed = 0;
        
        if ( isdefined( closed_struct.script_noteworthy ) && closed_struct.script_noteworthy == "stay_closed" )
        {
            stay_closed = 1;
        }
        
        platform_target.origin = open_struct.origin;
        platform_target.angles = open_struct.angles;
        v_move_to_close = closed_struct.origin - platform_target.origin;
        v_angles_to_close = closed_struct.angles - platform_target.angles;
        v_move_to_open = platform_target.origin - closed_struct.origin;
        v_angles_to_open = platform_target.angles - closed_struct.angles;
        self thread move_elevator_doors( platform_target, "close_", v_move_to_close, v_angles_to_close, n_closing_time );
        
        if ( !stay_closed )
        {
            self thread move_elevator_doors( platform_target, "open_", v_move_to_open, v_angles_to_open, n_opening_time );
        }
    }

    // Namespace cvehicleplatform
    // Params 3
    // Checksum 0x96f885d, Offset: 0x1150
    // Size: 0x74
    function looping_sounds( s_audio_point, notify_play, notify_stop )
    {
        level waittill( notify_play );
        
        if ( isdefined( s_audio_point.script_sound ) )
        {
            s_audio_point thread sound::loop_in_space( level.scr_sound[ s_audio_point.script_sound ], s_audio_point.origin, notify_stop );
        }
    }

    // Namespace cvehicleplatform
    // Params 0
    // Checksum 0x69d678c4, Offset: 0xff0
    // Size: 0x158
    function stop_platform()
    {
        level notify( "vehicle_platform_" + self.m_str_platform_name + "_stop" );
        level notify( "stop_" + self.m_str_platform_name + "_movement_sound" );
        level notify( "stop_" + self.m_str_platform_name + "_klaxon" );
        level notify( "open_" + self.m_str_platform_name + "_doors" );
        
        if ( isdefined( self.script_sound ) )
        {
            self.m_e_sound_point playsound( level.scr_sound[ self.script_sound ] );
        }
        
        if ( isdefined( level.scr_sound ) && isdefined( level.scr_sound[ "elevator_end" ] ) )
        {
            self.m_e_sound_point playsound( level.scr_sound[ "elevator_end" ] );
        }
        
        if ( isdefined( self.m_func_stop ) )
        {
            if ( isdefined( self.m_arg ) )
            {
                self.m_e_platform thread [[ self.m_func_stop ]]( self.m_arg );
                return;
            }
            
            self.m_e_platform thread [[ self.m_func_stop ]]();
        }
    }

    // Namespace cvehicleplatform
    // Params 1
    // Checksum 0x424e6746, Offset: 0xf08
    // Size: 0xe0
    function start_platform( b_new_start )
    {
        if ( self.m_has_been_destroyed )
        {
            return;
        }
        
        if ( isdefined( b_new_start ) && b_new_start )
        {
            self.m_veh_platform vehicle::get_on_and_go_path( self.m_nd_start );
        }
        else
        {
            self.m_veh_platform vehicle::go_path();
        }
        
        level notify( "vehicle_platform_" + self.m_str_platform_name + "_move" );
        
        if ( isdefined( self.m_func_start ) )
        {
            if ( isdefined( self.m_arg ) )
            {
                self.m_e_platform thread [[ self.m_func_start ]]( self.m_arg );
                return;
            }
            
            self.m_e_platform thread [[ self.m_func_start ]]();
        }
    }

    // Namespace cvehicleplatform
    // Params 2
    // Checksum 0x8fa8a731, Offset: 0xec8
    // Size: 0x34
    function set_speed( n_new_speed, n_accel_time )
    {
        self.m_veh_platform vehicle::set_speed( n_new_speed, n_accel_time );
    }

    // Namespace cvehicleplatform
    // Params 1
    // Checksum 0x37294bc7, Offset: 0xe38
    // Size: 0x84
    function attach_to_vehicle_node( str_node_name )
    {
        self.m_nd_start = getvehiclenode( str_node_name, "targetname" );
        assert( isdefined( self.m_nd_start ), "<dev string:x9f>" + str_node_name );
        self.m_veh_platform vehicle::get_on_path( self.m_nd_start );
    }

    // Namespace cvehicleplatform
    // Params 1
    // Checksum 0x4e5e9f29, Offset: 0xc50
    // Size: 0x1e0
    function trigger_think( e_trigger )
    {
        e_trigger endon( #"death" );
        level endon( self.m_str_platform_name + "_disabled" );
        nd_start_old = self.m_nd_start;
        
        while ( true )
        {
            e_trigger trigger::wait_till();
            level notify( "start_" + self.m_str_platform_name + "_klaxon" );
            level notify( "close_" + self.m_str_platform_name + "_doors" );
            
            if ( isdefined( e_trigger.script_wait ) )
            {
                wait e_trigger.script_wait;
            }
            else
            {
                wait 2;
            }
            
            if ( self.m_nd_start != nd_start_old )
            {
                b_new_start = 1;
            }
            
            self.m_e_sound_point playsound( "veh_" + self.m_str_platform_name + "_start" );
            self.m_e_sound_point playloopsound( "veh_" + self.m_str_platform_name + "_loop", 0.5 );
            self thread start_platform( b_new_start );
            self.m_veh_platform waittill( #"reached_end_node" );
            self.m_e_sound_point playsound( "veh_" + self.m_str_platform_name + "_stop" );
            self.m_e_sound_point stoploopsound( 0.5 );
            stop_platform();
        }
    }

    // Namespace cvehicleplatform
    // Params 0
    // Checksum 0xe75eb1e3, Offset: 0xa90
    // Size: 0x1b4
    function damage_watcher()
    {
        self.m_e_weakpoint setcandamage( 1 );
        self.m_e_weakpoint.health = 100;
        self.m_e_weakpoint waittill( #"death" );
        self.m_has_been_destroyed = 1;
        self thread fx::play( "mobile_shop_fall_explosion", self.m_veh_platform.origin, ( 0, 0, 0 ) );
        wait 0.3;
        self thread fx::play( "mobile_shop_fall_explosion", self.m_veh_platform.origin - ( 0, 200, 0 ), ( 0, 0, 0 ) );
        self.m_e_weakpoint hide();
        a_ai = getaiarray( self.m_str_platform_name, "groupname" );
        
        foreach ( ai in a_ai )
        {
            ai kill();
        }
        
        self.m_veh_platform vehicle::pause_path();
    }

    // Namespace cvehicleplatform
    // Params 1
    // Checksum 0x4f030cbd, Offset: 0xa18
    // Size: 0x70
    function set_node_start( str_node_name )
    {
        nd_start = getvehiclenode( str_node_name, "targetname" );
        assert( isdefined( self.m_nd_start ), "<dev string:x9f>" + str_node_name );
        self.m_nd_start = nd_start;
    }

    // Namespace cvehicleplatform
    // Params 0
    // Checksum 0x2c2d801e, Offset: 0xa00
    // Size: 0xa
    function get_platform_vehicle()
    {
        return self.m_veh_platform;
    }

    // Namespace cvehicleplatform
    // Params 3
    // Checksum 0xba14013c, Offset: 0x9b8
    // Size: 0x40
    function set_external_functions( func_start, func_stop, arg )
    {
        self.m_func_start = func_start;
        self.m_func_stop = func_stop;
        self.m_arg = arg;
    }

    // Namespace cvehicleplatform
    // Params 2
    // Checksum 0xaab35220, Offset: 0x2b0
    // Size: 0x6fc
    function init( str_platform_name, str_node_name )
    {
        if ( !level flag::get( "first_player_spawned" ) )
        {
            wait 0.05;
        }
        
        self.m_str_platform_name = str_platform_name;
        self.m_has_been_destroyed = 0;
        self.m_veh_platform = getent( self.m_str_platform_name + "_vehicle", "targetname" );
        
        if ( !isdefined( self.m_veh_platform ) )
        {
            self.m_veh_platform = getent( self.m_str_platform_name + "_vehicle_vh", "targetname" );
        }
        
        self.m_veh_platform.team = "spectator";
        self.m_veh_platform setmovingplatformenabled( 1 );
        assert( isdefined( self.m_veh_platform ), "<dev string:x28>" + self.m_str_platform_name + "<dev string:x46>" );
        self.m_a_e_platform_pieces = getentarray( self.m_str_platform_name, "targetname" );
        
        foreach ( platform_piece in self.m_a_e_platform_pieces )
        {
            platform_piece enablelinkto();
            platform_piece linkto( self.m_veh_platform );
            
            if ( platform_piece.classname == "script_brushmodel" )
            {
                assert( !isdefined( self.m_e_platform ), "<dev string:x4f>" + self.m_str_platform_name );
                self.m_e_platform = platform_piece;
            }
        }
        
        assert( isdefined( self.m_e_platform ), "<dev string:x81>" + self.m_str_platform_name );
        self.m_e_platform setmovingplatformenabled( 1 );
        self.m_e_sound_point = spawn( "script_origin", self.m_e_platform.origin );
        self.m_e_sound_point linkto( self.m_e_platform );
        self.m_e_weakpoint = getent( self.m_str_platform_name + "_weakpoint", "targetname" );
        
        if ( isdefined( self.m_e_weakpoint ) )
        {
            self.m_e_weakpoint enablelinkto();
            self.m_e_weakpoint linkto( self.m_e_platform );
            self thread damage_watcher();
        }
        
        self attach_to_vehicle_node( str_node_name );
        ent_targeting_platform = getentarray( str_platform_name, "target" );
        
        foreach ( ent_targeting_platform in ent_targeting_platform )
        {
            if ( ent_targeting_platform.classname == "script_model" || ent_targeting_platform.classname == "script_brushmodel" )
            {
                switch_trigger = getent( ent_targeting_platform.targetname, "target" );
                self thread trigger_think( switch_trigger );
                continue;
            }
            
            self thread trigger_think( ent_targeting_platform );
        }
        
        a_e_platform_targets = getentarray( self.m_e_platform.target, "targetname" );
        a_s_platform_targets = struct::get_array( self.m_e_platform.target, "targetname" );
        platform_targets = arraycombine( a_e_platform_targets, a_s_platform_targets, 1, 0 );
        
        foreach ( platform_target in platform_targets )
        {
            if ( !isdefined( platform_target.script_noteworthy ) )
            {
                continue;
            }
            
            switch ( platform_target.script_noteworthy )
            {
                case "audio_point":
                    self thread looping_sounds( platform_target, "start_" + self.m_str_platform_name + "_klaxon", "stop_" + self.m_str_platform_name + "_klaxon" );
                    break;
                case "elevator_door":
                    self thread setup_elevator_doors( platform_target );
                    break;
                default:
                    self thread looping_sounds( platform_target, "vehicle_platform_" + self.m_str_platform_name + "_move", "stop_" + self.m_str_platform_name + "_movement_sound" );
                    break;
            }
        }
    }

}

