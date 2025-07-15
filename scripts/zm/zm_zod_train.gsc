#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_zod_cleanup_mgr;
#using scripts/zm/zm_zod_util;

#namespace zm_train;

// Namespace zm_train
// Method(s) 64 Total 64
class czmtrain
{

    // Namespace czmtrain
    // Params 0
    // Checksum 0x1aa5265d, Offset: 0x1ce0
    // Size: 0x226
    function constructor()
    {
        self.m_vh_train = undefined;
        self.m_s_trigger = undefined;
        self.m_t_switch = undefined;
        self.m_e_volume = undefined;
        self.m_b_facing_forward = 1;
        self.m_b_free = 0;
        self.m_b_incoming = 0;
        self.m_a_s_stations = [];
        self.m_a_mdl_doors = [];
        self.m_str_station = undefined;
        self.m_str_destination = undefined;
        self.m_a_zombies_locked_in = [];
        self.m_n_last_jumper_time = 0;
        self.m_a_jumptags = [];
        self.var_9e0dc993 = 1;
        a_names = array( "tag_enter_back_top", "tag_enter_front_top", "tag_enter_left_top", "tag_enter_right_top" );
        a_anims = array( "ai_zombie_zod_train_win_trav_from_roof_b", "ai_zombie_zod_train_win_trav_from_roof_f", "ai_zombie_zod_train_win_trav_from_roof_l", "ai_zombie_zod_train_win_trav_from_roof_r" );
        assert( a_names.size == a_anims.size );
        
        for ( i = 0; i < a_names.size ; i++ )
        {
            str_name = a_names[ i ];
            str_anim = a_anims[ i ];
            self.m_a_jumptags[ str_name ] = spawnstruct();
            s_entrance = self.m_a_jumptags[ str_name ];
            s_entrance.str_tag = str_name;
            s_entrance.str_anim = str_anim;
            s_entrance.occupied = 0;
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x9bc27727, Offset: 0x7dd0
    // Size: 0x200
    function function_876255()
    {
        a_e_train_maps = getentarray( "map_train", "targetname" );
        
        while ( true )
        {
            str_station = get_current_station();
            
            switch ( str_station )
            {
                case "slums":
                    n_station = 1;
                    break;
                default:
                    n_station = 2;
                    break;
                case "canal":
                    n_station = 3;
                    break;
            }
            
            foreach ( e_train_map in a_e_train_maps )
            {
                e_train_map clientfield::set( "train_map_light", n_station );
            }
            
            self flag::wait_till( "moving" );
            
            foreach ( e_train_map in a_e_train_maps )
            {
                e_train_map clientfield::set( "train_map_light", 0 );
            }
            
            self flag::wait_till_clear( "moving" );
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x94a2a997, Offset: 0x7db0
    // Size: 0x12
    function get_origin()
    {
        return self.m_vh_train.origin;
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0xa8d9047b, Offset: 0x7b00
    // Size: 0x2a4
    function get_available_jumptag()
    {
        a_valid_tags = [];
        
        foreach ( tag in self.m_a_jumptags )
        {
            if ( tag.occupied )
            {
                continue;
            }
            
            if ( !isdefined( a_valid_tags ) )
            {
                a_valid_tags = [];
            }
            else if ( !isarray( a_valid_tags ) )
            {
                a_valid_tags = array( a_valid_tags );
            }
            
            a_valid_tags[ a_valid_tags.size ] = tag;
        }
        
        a_valid_tags = array::randomize( a_valid_tags );
        a_forward_tags = [];
        a_players = get_players_on_train( 0 );
        n_roll = randomint( 100 );
        
        if ( n_roll < 80 && a_players.size > 0 )
        {
            foreach ( s_tag in a_valid_tags )
            {
                if ( any_player_facing_tag( s_tag.str_tag ) )
                {
                    if ( !isdefined( a_forward_tags ) )
                    {
                        a_forward_tags = [];
                    }
                    else if ( !isarray( a_forward_tags ) )
                    {
                        a_forward_tags = array( a_forward_tags );
                    }
                    
                    a_forward_tags[ a_forward_tags.size ] = s_tag;
                }
            }
        }
        
        if ( a_forward_tags.size > 2 )
        {
            a_valid_tags = a_forward_tags;
        }
        
        if ( a_valid_tags.size == 0 )
        {
            return undefined;
        }
        
        return array::random( a_valid_tags );
    }

    // Namespace czmtrain
    // Params 1, eflags: 0x4
    // Checksum 0x89fc4974, Offset: 0x79d0
    // Size: 0x128, Type: bool
    function private any_player_facing_tag( str_tag )
    {
        foreach ( e_player in level.players )
        {
            v_pos = self.m_vh_train gettagorigin( str_tag );
            v_fwd = anglestoforward( e_player.angles );
            v_to_tag = vectornormalize( v_pos - e_player.origin );
            
            if ( vectordot( v_fwd, v_to_tag ) > 0 )
            {
                return true;
            }
        }
        
        return false;
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x58b6ac15, Offset: 0x79a0
    // Size: 0x22
    function is_offline()
    {
        return self flag::get( "offline" );
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x73c29708, Offset: 0x7970
    // Size: 0x22
    function is_cooling_down()
    {
        return self flag::get( "cooldown" );
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x55bb8013, Offset: 0x7958
    // Size: 0xa
    function function_3e62f527()
    {
        return self.var_9e0dc993;
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x4db9e472, Offset: 0x7928
    // Size: 0x22
    function is_moving()
    {
        return self flag::get( "moving" );
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0xcf2a6f09, Offset: 0x7848
    // Size: 0xd6
    function get_junction_origin()
    {
        v_origin = ( 0, 0, 0 );
        
        foreach ( s_station in self.m_a_s_stations )
        {
            v_origin += s_station.junction_node.origin;
        }
        
        v_origin /= float( self.m_a_s_stations.size );
        return v_origin;
    }

    // Namespace czmtrain
    // Params 2
    // Checksum 0x1c2ac7c1, Offset: 0x76b0
    // Size: 0x18c
    function jump_into_train( ai, str_tag )
    {
        self endon( #"death" );
        s_tag = self.m_a_jumptags[ str_tag ];
        s_tag.occupied = 1;
        v_tag_pos = self.m_vh_train gettagorigin( str_tag );
        v_tag_angles = self.m_vh_train gettagangles( str_tag );
        ai teleport( v_tag_pos, v_tag_angles );
        util::wait_network_frame();
        ai linkto( self.m_vh_train, str_tag );
        ai animscripted( "entered_train", v_tag_pos, v_tag_angles, s_tag.str_anim );
        ai zombie_shared::donotetracks( "entered_train" );
        ai unlink();
        s_tag.occupied = 0;
        
        if ( is_moving() )
        {
            add_zombie_locked_in( ai );
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x6857928c, Offset: 0x7698
    // Size: 0x10
    function mark_jumper_time()
    {
        self.m_n_last_jumper_time = gettime();
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x4f33d043, Offset: 0x7660
    // Size: 0x2c
    function get_time_since_last_jumper()
    {
        return float( gettime() - self.m_n_last_jumper_time ) / 1000;
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x4e3cc587, Offset: 0x7648
    // Size: 0xa
    function get_zombies_locked_in()
    {
        return self.m_a_zombies_locked_in;
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x2855851e, Offset: 0x7618
    // Size: 0x24
    function locked_in_list_remove_undefined()
    {
        self.m_a_zombies_locked_in = array::remove_undefined( self.m_a_zombies_locked_in );
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0x1a0ccca2, Offset: 0x75c0
    // Size: 0x4c
    function remove_zombie_locked_in( ai_zombie )
    {
        ai_zombie.locked_in_train = 0;
        arrayremovevalue( self.m_a_zombies_locked_in, ai_zombie );
        ai_zombie notify( #"released_from_train" );
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0x7d5f2f11, Offset: 0x7560
    // Size: 0x54
    function add_zombie_locked_in( ai_zombie )
    {
        ai_zombie.locked_in_train = 1;
        array::add( self.m_a_zombies_locked_in, ai_zombie, 0 );
        thread watch_zombie_fall_off( ai_zombie );
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0xb9a1fcb3, Offset: 0x7408
    // Size: 0x14c
    function get_players_on_train( b_valid_targets_only )
    {
        if ( !isdefined( b_valid_targets_only ) )
        {
            b_valid_targets_only = 0;
        }
        
        a_players = [];
        
        foreach ( e_player in level.players )
        {
            if ( e_player.ignoreme || b_valid_targets_only && !zm_utility::is_player_valid( e_player ) )
            {
                continue;
            }
            
            if ( e_player.on_train )
            {
                if ( !isdefined( a_players ) )
                {
                    a_players = [];
                }
                else if ( !isarray( a_players ) )
                {
                    a_players = array( a_players );
                }
                
                a_players[ a_players.size ] = e_player;
            }
        }
        
        return a_players;
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0x78aae0b6, Offset: 0x73d0
    // Size: 0x2a
    function is_touching_train_volume( ent )
    {
        return ent istouching( self.m_e_volume );
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0xcd16708f, Offset: 0x7328
    // Size: 0x9c
    function watch_zombie_fall_off( ai )
    {
        ai endon( #"death" );
        ai endon( #"released_from_train" );
        zm_net::network_safe_init( "train_fall_check", 1 );
        
        while ( self zm_net::network_choke_action( "train_fall_check", &is_touching_train, ai ) )
        {
            wait 2;
        }
        
        remove_zombie_locked_in( ai );
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0xdf58df76, Offset: 0x72f0
    // Size: 0x2a
    function is_touching_train( e_ent )
    {
        return e_ent istouching( self.m_e_volume );
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x16d9c3ed, Offset: 0x71a0
    // Size: 0x144
    function watch_players_on_train()
    {
        /#
            foreach ( e_player in level.players )
            {
                assert( isdefined( e_player.on_train ) );
            }
        #/
        
        while ( true )
        {
            foreach ( e_player in level.players )
            {
                e_player.on_train = is_touching_train( e_player );
            }
            
            wait 0.5;
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x669ab6c6, Offset: 0x7100
    // Size: 0x94, Type: bool
    function function_ccd778ab()
    {
        foreach ( e_player in level.players )
        {
            if ( is_touching_train( e_player ) )
            {
                return false;
            }
        }
        
        return true;
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x82ef5413, Offset: 0x6f10
    // Size: 0x1e4
    function function_ca899bfc()
    {
        if ( self.m_str_destination == "slums" )
        {
            self.m_vh_train hidepart( "tag_sign_footlight" );
            self.m_vh_train hidepart( "tag_sign_canals" );
            self.m_vh_train showpart( "tag_sign_waterfront" );
            playsoundatposition( "evt_train_switch_track_hit", self.m_t_switch.origin );
            return;
        }
        
        if ( self.m_str_destination == "theater" )
        {
            self.m_vh_train hidepart( "tag_sign_canals" );
            self.m_vh_train hidepart( "tag_sign_waterfront" );
            self.m_vh_train showpart( "tag_sign_footlight" );
            playsoundatposition( "evt_train_switch_track_hit", self.m_t_switch.origin );
            return;
        }
        
        if ( self.m_str_destination == "canal" )
        {
            self.m_vh_train hidepart( "tag_sign_footlight" );
            self.m_vh_train hidepart( "tag_sign_waterfront" );
            self.m_vh_train showpart( "tag_sign_canals" );
            playsoundatposition( "evt_train_switch_track_hit", self.m_t_switch.origin );
        }
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0x56f3a46, Offset: 0x6e88
    // Size: 0x7c
    function function_de6e1f4f( m_t_switch )
    {
        self.m_vh_train endon( #"hash_51689c0f" );
        
        if ( !flag::get( "switches_enabled" ) )
        {
            flag::wait_till( "switches_enabled" );
        }
        
        m_t_switch.player_used = 0;
        m_t_switch waittill( #"trigger" );
        m_t_switch.player_used = 1;
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0xc6967eb0, Offset: 0x6c60
    // Size: 0x21e
    function run_switch()
    {
        while ( true )
        {
            function_de6e1f4f( self.m_t_switch );
            str_prev_dest = self.m_str_destination;
            
            if ( self.m_t_switch.player_used )
            {
                self.m_a_s_stations[ self.m_str_station ].b_left_path_active = !self.m_a_s_stations[ self.m_str_station ].b_left_path_active;
                self.m_str_destination = get_current_destination();
            }
            
            if ( self.m_str_destination != str_prev_dest )
            {
                function_ca899bfc();
                
                if ( is_moving() && !level flag::get( "callbox" ) )
                {
                    sndnum = self.m_a_s_stations[ self.m_str_destination ].audio_divert;
                    level clientfield::set( "sndTrainVox", sndnum );
                    self.m_vh_train playsoundontag( level.var_98f27ad[ sndnum - 1 ], "tag_support_arm_01" );
                }
                
                if ( level flag::get( "callbox" ) )
                {
                    level flag::clear( "callbox" );
                }
                
                self.m_t_switch sethintstring( &"ZM_ZOD_SWITCHING_PROGRESS" );
                wait 1;
                
                if ( flag::get( "switches_enabled" ) )
                {
                    self.m_t_switch sethintstring( &"ZM_ZOD_SWITCH_ENABLE" );
                }
            }
            
            level notify( #"hash_8939bd21" );
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0xb2e91fb7, Offset: 0x6c28
    // Size: 0x30
    function send_train()
    {
        if ( isdefined( self.m_s_trigger ) )
        {
            self.m_b_free = 1;
            self.m_s_trigger notify( #"trigger" );
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x169b5f65, Offset: 0x6b48
    // Size: 0xd4
    function update_use_trigger()
    {
        if ( !isdefined( self.m_s_trigger ) )
        {
            return;
        }
        
        if ( self.m_b_free )
        {
            self.m_s_trigger zm_zod_util::set_unitrigger_hint_string( &"ZM_ZOD_TRAIN_USE_FREE" );
            return;
        }
        
        if ( is_offline() )
        {
            self.m_s_trigger zm_zod_util::set_unitrigger_hint_string( &"ZM_ZOD_TRAIN_OFFLINE" );
            return;
        }
        
        if ( is_cooling_down() )
        {
            self.m_s_trigger zm_zod_util::set_unitrigger_hint_string( &"ZM_ZOD_TRAIN_COOLDOWN" );
            return;
        }
        
        self.m_s_trigger zm_zod_util::set_unitrigger_hint_string( &"ZM_ZOD_TRAIN_USE", 500 );
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0xe99250e8, Offset: 0x6a10
    // Size: 0x12a
    function recalc_zombies_locked_in_train()
    {
        zombies = getaiteamarray( level.zombie_team );
        n_counter = 0;
        
        foreach ( zombie in zombies )
        {
            if ( !isdefined( zombie ) || !isalive( zombie ) )
            {
                continue;
            }
            
            if ( is_touching_train_volume( zombie ) )
            {
                add_zombie_locked_in( zombie );
            }
            
            n_counter++;
            
            if ( n_counter % 3 == 0 )
            {
                util::wait_network_frame();
            }
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0xadd75752, Offset: 0x6998
    // Size: 0x70
    function function_285f0f0b()
    {
        if ( self.var_901503d0 )
        {
            self scene::play( "p7_fxanim_zm_zod_train_door_rt_close_bundle", self );
            self.var_901503d0 = 0;
        }
        
        if ( self.var_619deb2d )
        {
            self scene::play( "p7_fxanim_zm_zod_train_door_lft_close_bundle", self );
            self.var_619deb2d = 0;
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x870caa11, Offset: 0x6738
    // Size: 0x252
    function function_9211290c()
    {
        foreach ( e_door in self.m_a_mdl_doors )
        {
            v_pos = get_door_closed_pos( e_door );
            e_door unlink();
            e_door moveto( v_pos, 0.3 );
            e_door.e_clip unlink();
            e_door.e_clip moveto( e_door.e_clip.var_b620e1b1.origin, 0.3 );
        }
        
        self.m_a_mdl_doors[ 0 ] waittill( #"movedone" );
        util::wait_network_frame();
        
        foreach ( e_door in self.m_a_mdl_doors )
        {
            v_pos = get_door_closed_pos( e_door );
            e_door.origin = v_pos;
            e_door.angles = e_door.script_origin.angles;
            e_door linkto( self.m_vh_train );
            e_door.e_clip linkto( self.m_vh_train );
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x2a64a2cd, Offset: 0x64b0
    // Size: 0x27c
    function close_doors()
    {
        self.m_vh_train function_285f0f0b();
        
        foreach ( e_door in self.m_a_mdl_doors )
        {
            v_pos = get_door_closed_pos( e_door );
            e_door unlink();
            e_door moveto( v_pos, 0.3 );
            e_door.e_clip unlink();
            e_door.e_clip moveto( e_door.e_clip.var_b620e1b1.origin, 0.3 );
        }
        
        self.m_a_mdl_doors[ 0 ] waittill( #"movedone" );
        util::wait_network_frame();
        
        foreach ( e_door in self.m_a_mdl_doors )
        {
            v_pos = get_door_closed_pos( e_door );
            e_door.origin = v_pos;
            e_door.angles = e_door.script_origin.angles;
            e_door linkto( self.m_vh_train );
            e_door.e_clip linkto( self.m_vh_train );
        }
        
        thread recalc_zombies_locked_in_train();
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0x6ea4b71e, Offset: 0x6420
    // Size: 0x88
    function function_59722edc( str_side )
    {
        if ( str_side == "right" )
        {
            if ( !self.var_901503d0 )
            {
                self thread scene::play( "p7_fxanim_zm_zod_train_door_rt_open_bundle", self );
                self.var_901503d0 = 1;
            }
            
            return;
        }
        
        if ( !self.var_619deb2d )
        {
            self thread scene::play( "p7_fxanim_zm_zod_train_door_lft_open_bundle", self );
            self.var_619deb2d = 1;
        }
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0x16f263c8, Offset: 0x6000
    // Size: 0x418
    function open_doors( str_side )
    {
        if ( !isdefined( str_side ) )
        {
            str_side = get_open_side();
        }
        
        self.m_vh_train function_59722edc( str_side );
        var_7631d55c = ( 0, 0, 300 );
        a_doors_moved = [];
        
        foreach ( e_door in self.m_a_mdl_doors )
        {
            if ( str_side == "right" && ( str_side == "left" && ( !isdefined( str_side ) || e_door.script_string == "train_rear_door" ) || e_door.script_string == "train_front_door" ) )
            {
                v_pos = get_door_open_pos( e_door );
                e_door unlink();
                e_door moveto( v_pos, 0.3 );
                
                if ( !isdefined( a_doors_moved ) )
                {
                    a_doors_moved = [];
                }
                else if ( !isarray( a_doors_moved ) )
                {
                    a_doors_moved = array( a_doors_moved );
                }
                
                a_doors_moved[ a_doors_moved.size ] = e_door;
                e_door.e_clip unlink();
                e_door.e_clip moveto( e_door.e_clip.origin + var_7631d55c, 0.3 );
            }
        }
        
        if ( a_doors_moved.size > 0 )
        {
            a_doors_moved[ 0 ] waittill( #"movedone" );
            util::wait_network_frame();
        }
        
        util::wait_network_frame();
        
        foreach ( e_door in a_doors_moved )
        {
            v_pos = get_door_open_pos( e_door );
            e_door.origin = v_pos;
            e_door.angles = e_door.script_origin.angles;
            e_door linkto( self.m_vh_train );
            e_door.e_clip linkto( self.m_vh_train );
        }
        
        for ( i = self.m_a_zombies_locked_in.size - 1; i >= 0 ; i-- )
        {
            ai = self.m_a_zombies_locked_in[ i ];
            
            if ( isdefined( ai ) )
            {
                remove_zombie_locked_in( ai );
            }
        }
        
        self.m_a_zombies_locked_in = [];
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0x34141d98, Offset: 0x5f68
    // Size: 0x8a
    function is_door_open( e_door )
    {
        str_side = get_open_side();
        
        if ( str_side == "right" && ( str_side == "left" && e_door.script_string == "train_rear_door" || e_door.script_string == "train_front_door" ) )
        {
            return self.var_9e0dc993;
        }
        
        return 0;
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0xd2c82c3a, Offset: 0x5ef0
    // Size: 0x70
    function get_open_side()
    {
        str_side = self.m_a_s_stations[ self.m_str_station ].door_side;
        
        if ( !self.m_b_facing_forward )
        {
            if ( str_side == "left" )
            {
                return "right";
            }
            else if ( str_side == "right" )
            {
                return "left";
            }
        }
        
        return str_side;
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0xd4d64f94, Offset: 0x5ec0
    // Size: 0x22
    function get_door_closed_pos( e_door )
    {
        return e_door.script_origin.origin;
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0x6ed9e238, Offset: 0x5df8
    // Size: 0xc0
    function get_door_open_pos( e_door )
    {
        if ( e_door.script_string == "front_door" )
        {
            return ( e_door.script_origin.origin - anglestoforward( e_door.script_origin.angles ) * 100 );
        }
        
        return e_door.script_origin.origin + anglestoforward( e_door.script_origin.angles ) * 100;
    }

    // Namespace czmtrain
    // Params 2
    // Checksum 0xf14137d4, Offset: 0x5aa0
    // Size: 0x350
    function run_gate( e_gate, a_jump_nodes )
    {
        nd_start = self.m_a_s_stations[ e_gate.script_string ].start_node;
        v_open = e_gate.origin;
        v_closed = v_open + anglestoforward( nd_start.angles ) * 96;
        
        if ( self.m_a_s_stations[ e_gate.script_string ].door_side == "right" )
        {
            v_closed = v_open - anglestoforward( nd_start.angles ) * 96;
        }
        
        b_open = 1;
        
        while ( true )
        {
            if ( b_open )
            {
                self.var_9e0dc993 = 0;
                e_gate moveto( v_closed, 1 );
                b_open = 0;
                
                foreach ( nd in a_jump_nodes )
                {
                    unlinktraversal( nd );
                }
            }
            
            self flag::wait_till_clear( "moving" );
            
            if ( self.m_str_station == e_gate.script_string )
            {
                e_gate moveto( v_open, 1 );
                b_open = 1;
                e_gate waittill( #"movedone" );
                
                foreach ( nd in a_jump_nodes )
                {
                    b_fwd_node = nd.script_string === "forward";
                    
                    if ( !self.m_b_facing_forward && ( self.m_b_facing_forward && b_fwd_node || !b_fwd_node ) )
                    {
                        linktraversal( nd );
                    }
                }
                
                self.var_9e0dc993 = 1;
            }
            
            self flag::wait_till( "moving" );
            wait 1;
        }
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0x83a1c33e, Offset: 0x5838
    // Size: 0x260
    function run_callbox( str_callbox )
    {
        assert( isdefined( self.m_str_station ) );
        e_lever = self.m_a_s_stations[ str_callbox ].callbox;
        t_use = zm_zod_util::spawn_trigger_radius( e_lever.origin, 60, 1 );
        thread run_callbox_hintstring( str_callbox, t_use, getent( e_lever.target, "targetname" ) );
        
        while ( true )
        {
            t_use waittill( #"trigger", e_who );
            
            if ( !e_who zm_score::can_player_purchase( 500 ) )
            {
                e_who zm_audio::create_and_play_dialog( "general", "transport_deny" );
                continue;
            }
            
            if ( self.m_str_station != str_callbox && isdefined( self.m_s_trigger ) )
            {
                self.m_b_free = 0;
                
                if ( str_callbox != self.m_str_destination )
                {
                    level flag::set( "callbox" );
                    self.m_t_switch notify( #"trigger" );
                    level waittill( #"hash_8939bd21" );
                }
                
                self.m_s_trigger notify( #"trigger", e_who );
                util::wait_network_frame();
                self.m_b_free = 1;
                e_lever rotatepitch( 180, 0.5 );
                self flag::wait_till( "moving" );
                self flag::wait_till_clear( "moving" );
                e_lever rotatepitch( -180, 0.5 );
            }
        }
    }

    // Namespace czmtrain
    // Params 3
    // Checksum 0x47fc1c3e, Offset: 0x55d8
    // Size: 0x258
    function run_callbox_hintstring( str_callbox, t_use, e_light )
    {
        while ( true )
        {
            if ( self.m_str_station == str_callbox )
            {
                e_light clientfield::set( "train_callbox_light", 0 );
                t_use zm_zod_util::set_unitrigger_hint_string( &"" );
            }
            else
            {
                e_light clientfield::set( "train_callbox_light", 1 );
                t_use zm_zod_util::set_unitrigger_hint_string( &"ZM_ZOD_TRAIN_CALL", 500 );
            }
            
            self flag::wait_till( "moving" );
            e_light clientfield::set( "train_callbox_light", 0 );
            t_use zm_zod_util::set_unitrigger_hint_string( &"ZM_ZOD_TRAIN_MOVING" );
            self flag::wait_till_clear( "moving" );
            wait 0.05;
            
            if ( self flag::get( "offline" ) )
            {
                t_use zm_zod_util::set_unitrigger_hint_string( &"ZM_ZOD_TRAIN_OFFLINE" );
                e_light clientfield::set( "train_callbox_light", 2 );
                self flag::wait_till_clear( "offline" );
                continue;
            }
            
            if ( self.m_str_station == str_callbox )
            {
                t_use zm_zod_util::set_unitrigger_hint_string( &"" );
                self flag::wait_till_clear( "cooldown" );
                continue;
            }
            
            t_use zm_zod_util::set_unitrigger_hint_string( &"ZM_ZOD_TRAIN_COOLDOWN" );
            self flag::wait_till_clear( "cooldown" );
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x6d6efd06, Offset: 0x55a0
    // Size: 0x30
    function function_b0af9dac()
    {
        while ( true )
        {
            level waittill( #"between_round_over" );
            level.var_33c4ee76 = 0;
            wait 0.05;
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0xb2896446, Offset: 0x5538
    // Size: 0x5c
    function function_955e57a7()
    {
        level flag::wait_till( "ee_boss_defeated" );
        level notify( #"hash_12be7dbb" );
        self flag::clear( "offline" );
        update_use_trigger();
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0xfd33d9e3, Offset: 0x5440
    // Size: 0xec
    function function_312bb6e1()
    {
        level endon( #"hash_12be7dbb" );
        
        if ( level flag::get( "ee_boss_defeated" ) && !level flag::get( "ee_final_boss_defeated" ) )
        {
            return;
        }
        
        if ( level.var_33c4ee76 < 5 )
        {
            return;
        }
        
        self flag::set( "offline" );
        self.m_vh_train clientfield::set( "train_switch_light", 2 );
        update_use_trigger();
        level waittill( #"between_round_over" );
        self flag::clear( "offline" );
        wait 0.05;
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x722c5a18, Offset: 0x5330
    // Size: 0x104
    function function_a377ba46()
    {
        if ( flag::get( "moving" ) )
        {
            var_38c97a3b = get_current_destination();
        }
        else
        {
            var_38c97a3b = self.m_str_station;
        }
        
        switch ( var_38c97a3b )
        {
            case "slums":
                var_bddb9113 = "lgt_exp_train_slums_debug";
                break;
            case "canal":
                var_bddb9113 = "lgt_exp_train_canals_debug";
                break;
            default:
                var_bddb9113 = "lgt_exp_train_theater_debug";
                break;
        }
        
        if ( flag::get( "moving" ) )
        {
            exploder::exploder( var_bddb9113 );
            return;
        }
        
        wait 2;
        exploder::exploder_stop( var_bddb9113 );
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0xc784593d, Offset: 0x4b78
    // Size: 0x7b0
    function main()
    {
        a_path_names = getarraykeys( self.m_a_s_stations );
        a_path_names = array::randomize( a_path_names );
        self.m_str_station = a_path_names[ 0 ];
        self.var_97fef807 = self.m_str_station;
        self.m_a_s_stations[ self.m_str_station ].b_left_path_active = randomint( 2 );
        self.m_str_destination = get_current_destination();
        self.m_vh_train attachpath( self.m_a_s_stations[ self.m_str_station ].start_node );
        b_first_run = 1;
        self thread function_876255();
        self thread watch_players_on_train();
        self thread function_955e57a7();
        wait 1;
        v_front = self.m_vh_train gettagorigin( "tag_button_front" );
        self.m_s_trigger = zm_zod_util::spawn_trigger_radius( v_front, 60, 1 );
        self.m_vh_train playloopsound( "evt_train_idle_loop", 4 );
        open_doors();
        thread run_switch();
        
        while ( true )
        {
            update_use_trigger();
            enable_train_switches( 1 );
            level thread function_b0af9dac();
            
            while ( true )
            {
                self.m_vh_train clientfield::set( "train_switch_light", 1 );
                self.m_s_trigger waittill( #"trigger", e_who );
                self.m_vh_train clientfield::set( "train_switch_light", 0 );
                
                if ( self.m_b_free )
                {
                    self.m_b_free = 0;
                    break;
                }
                
                if ( !e_who zm_score::can_player_purchase( 500 ) )
                {
                    e_who zm_audio::create_and_play_dialog( "general", "transport_deny" );
                    continue;
                }
                
                e_who zm_score::minus_to_player_score( 500 );
                e_who zm_audio::create_and_play_dialog( "train", "start" );
                break;
            }
            
            level.var_33c4ee76++;
            thread function_a377ba46();
            wait 0.05;
            self flag::set( "moving" );
            zm_unitrigger::unregister_unitrigger( self.m_s_trigger );
            self.m_s_trigger = undefined;
            close_doors();
            self.m_vh_train playsound( "evt_train_start" );
            self.m_vh_train playloopsound( "evt_train_loop", 4 );
            var_8d722bd4 = function_ccd778ab();
            
            if ( var_8d722bd4 || b_first_run )
            {
                self.m_vh_train setspeed( 32 );
            }
            else
            {
                level.b_host_migration_force_player_respawn = 1;
                thread function_a9acf9e2();
            }
            
            move();
            self.m_vh_train playloopsound( "evt_train_idle_loop", 4 );
            a_riders = get_players_on_train( 0 );
            
            if ( a_riders.size > 0 )
            {
                level flag::set( self.m_a_s_stations[ self.m_str_station ].str_zone_flag );
                level flag::set( "train_rode_to_" + self.m_str_station );
            }
            
            if ( var_8d722bd4 || b_first_run )
            {
                self.m_vh_train resumespeed();
            }
            
            if ( b_first_run )
            {
                b_first_run = 0;
            }
            
            open_doors();
            a_riders = get_players_on_train( 0 );
            
            if ( a_riders.size > 0 )
            {
                var_3a349c58 = a_riders[ randomint( a_riders.size ) ];
                var_3a349c58 zm_audio::create_and_play_dialog( "train", "stop" );
            }
            
            v_trig = ( 0, 0, 0 );
            
            if ( !self.m_b_facing_forward )
            {
                v_trig = self.m_vh_train gettagorigin( "tag_button_back" );
            }
            else
            {
                v_trig = self.m_vh_train gettagorigin( "tag_button_front" );
            }
            
            self flag::clear( "moving" );
            level.b_host_migration_force_player_respawn = 0;
            self function_312bb6e1();
            
            if ( !self.m_b_free && level.var_33c4ee76 > 0 )
            {
                self flag::set( "cooldown" );
                update_use_trigger();
                n_wait = 40;
                
                /#
                    if ( getdvarint( "<dev string:xd5>" ) > 0 )
                    {
                        n_wait = 5;
                    }
                #/
                
                wait n_wait;
                self.m_s_trigger = zm_zod_util::spawn_trigger_radius( v_trig, 60, 1 );
                self flag::clear( "cooldown" );
                continue;
            }
            
            self.m_s_trigger = zm_zod_util::spawn_trigger_radius( v_trig, 60, 1 );
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x3a33b794, Offset: 0x49c0
    // Size: 0x1aa
    function function_6f6ab7a4()
    {
        for ( i = 0; i < self.m_a_mdl_doors.size ; i++ )
        {
            e_door = self.m_a_mdl_doors[ i ];
            e_door hide();
            
            if ( e_door.script_string == "train_front_door" )
            {
                e_door.e_clip = getent( "train_front_clip", "script_string" );
            }
            else if ( e_door.script_string == "train_rear_door" )
            {
                e_door.e_clip = getent( "train_rear_clip", "script_string" );
            }
            
            if ( isdefined( e_door.e_clip ) )
            {
                e_origin = spawn( "script_origin", e_door.e_clip.origin );
                e_origin.angles = self.m_vh_train.angles;
                e_origin linkto( self.m_vh_train );
                e_door.e_clip.var_b620e1b1 = e_origin;
            }
        }
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0x5caa134c, Offset: 0x4100
    // Size: 0x8b2
    function initialize( e_train )
    {
        assert( isdefined( e_train ) );
        self.m_vh_train = e_train;
        self.m_vh_train.var_619deb2d = 0;
        self.m_vh_train.var_901503d0 = 0;
        
        if ( !self flag::exists( "moving" ) )
        {
            self flag::init( "moving", 0 );
        }
        
        if ( !self flag::exists( "cooldown" ) )
        {
            self flag::init( "cooldown", 0 );
        }
        
        if ( !self flag::exists( "offline" ) )
        {
            self flag::init( "offline", 0 );
        }
        
        if ( !self flag::exists( "switches_enabled" ) )
        {
            self flag::init( "switches_enabled", 1 );
        }
        
        if ( !level flag::exists( "callbox" ) )
        {
            level flag::init( "callbox" );
        }
        
        self.m_vh_train.team = "spectator";
        initialize_stations();
        
        /#
            thread debug_draw_paths();
            thread debug_draw_doors();
        #/
        
        a_e_children = getentarray( self.m_vh_train.target, "targetname" );
        
        foreach ( e_ent in a_e_children )
        {
            if ( isdefined( e_ent.script_string ) )
            {
                if ( e_ent.script_string == "train_volume" )
                {
                    if ( !isdefined( self.m_e_volume ) )
                    {
                        assert( !isdefined( self.m_e_volume ) );
                        e_ent enablelinkto();
                        self.m_e_volume = e_ent;
                    }
                }
                else if ( e_ent.script_string == "train_rear_door" || e_ent.script_string == "train_front_door" )
                {
                    if ( !isdefined( e_ent.script_origin ) )
                    {
                        e_ent.script_origin = spawn( "script_origin", e_ent.origin );
                        e_ent.script_origin.angles = self.m_vh_train.angles;
                        e_ent.script_origin linkto( self.m_vh_train );
                    }
                    
                    if ( !isdefined( self.m_a_mdl_doors ) )
                    {
                        self.m_a_mdl_doors = [];
                    }
                    else if ( !isarray( self.m_a_mdl_doors ) )
                    {
                        self.m_a_mdl_doors = array( self.m_a_mdl_doors );
                    }
                    
                    self.m_a_mdl_doors[ self.m_a_mdl_doors.size ] = e_ent;
                }
                
                e_ent linkto( self.m_vh_train );
                continue;
            }
            
            /#
                iprintlnbold( "<dev string:x76>" + zm_zod_util::vec_to_string( e_ent.origin ) + "<dev string:x81>" );
            #/
        }
        
        function_6f6ab7a4();
        
        /#
            if ( !isdefined( self.m_e_volume ) )
            {
                assertmsg( "<dev string:xbb>" + zm_zod_util::vec_to_string( self.m_vh_train.origin ) + "<dev string:xc5>" );
            }
        #/
        
        self.m_vh_train function_a8e2d7ff();
        self.m_t_switch = getent( "m_s_switch_trigger", "targetname" );
        self.m_t_switch triggerignoreteam();
        self.m_t_switch setteamfortrigger( "none" );
        self.m_t_switch sethintstring( &"ZM_ZOD_SWITCH_DISABLE" );
        self.m_t_switch setcursorhint( "HINT_NOICON" );
        self.m_t_switch enablelinkto();
        self.m_t_switch linkto( self.m_vh_train );
        self.m_t_switch.player_used = 0;
        thread main();
        a_callboxes = getentarray( "train_call_lever", "targetname" );
        
        foreach ( e_callbox in a_callboxes )
        {
            thread run_callbox( e_callbox.script_string );
        }
        
        a_gates = getentarray( "train_gate", "targetname" );
        
        foreach ( gate in a_gates )
        {
            station = self.m_a_s_stations[ gate.script_string ];
            
            if ( !isdefined( station.gates ) )
            {
                station.gates = [];
            }
            
            if ( !isdefined( station.gates ) )
            {
                station.gates = [];
            }
            else if ( !isarray( station.gates ) )
            {
                station.gates = array( station.gates );
            }
            
            station.gates[ station.gates.size ] = gate;
            jump_nodes = getnodearray( station.path_node.target, "targetname" );
            self thread run_gate( gate, jump_nodes );
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x7762de6c, Offset: 0x37d0
    // Size: 0x922
    function initialize_stations()
    {
        self.m_a_s_stations = [];
        a_path_nodes = getnodearray( "train_pathnode", "targetname" );
        
        foreach ( nd in a_path_nodes )
        {
            str_station = nd.script_string;
            self.m_a_s_stations[ str_station ] = spawnstruct();
            self.m_a_s_stations[ str_station ].path_node = nd;
            self.m_a_s_stations[ str_station ].origin = nd.origin;
            self.m_a_s_stations[ str_station ].angles = nd.angles;
            self.m_a_s_stations[ str_station ].station_id = str_station;
            self.m_a_s_stations[ str_station ].door_side = nd.script_parameters;
        }
        
        self.m_a_s_stations[ "slums" ].left_path = "canal";
        self.m_a_s_stations[ "slums" ].right_path = "theater";
        self.m_a_s_stations[ "slums" ].b_left_path_active = 0;
        self.m_a_s_stations[ "slums" ].str_zone_flag = "activate_slums_waterfront";
        self.m_a_s_stations[ "slums" ].audio_divert = 8;
        self.m_a_s_stations[ "slums" ].audio_depart = 5;
        self.m_a_s_stations[ "slums" ].audio_arrive = 1;
        self.m_a_s_stations[ "slums" ].start_node = getvehiclenode( "a1", "targetname" );
        self.m_a_s_stations[ "theater" ].left_path = "slums";
        self.m_a_s_stations[ "theater" ].right_path = "canal";
        self.m_a_s_stations[ "theater" ].b_left_path_active = 0;
        self.m_a_s_stations[ "theater" ].str_zone_flag = "activate_theater_square";
        self.m_a_s_stations[ "theater" ].audio_divert = 9;
        self.m_a_s_stations[ "theater" ].audio_depart = 6;
        self.m_a_s_stations[ "theater" ].audio_arrive = 2;
        self.m_a_s_stations[ "theater" ].start_node = getvehiclenode( "b1", "targetname" );
        self.m_a_s_stations[ "canal" ].left_path = "theater";
        self.m_a_s_stations[ "canal" ].right_path = "slums";
        self.m_a_s_stations[ "canal" ].b_left_path_active = 0;
        self.m_a_s_stations[ "canal" ].str_zone_flag = "activate_brothel_street";
        self.m_a_s_stations[ "canal" ].audio_divert = 7;
        self.m_a_s_stations[ "canal" ].audio_depart = 4;
        self.m_a_s_stations[ "canal" ].audio_arrive = 3;
        self.m_a_s_stations[ "canal" ].start_node = getvehiclenode( "c1", "targetname" );
        level.var_98f27ad = array( "vox_tanc_board_canal_0", "vox_tanc_board_slums_0", "vox_tanc_board_theater_0", "vox_tanc_depart_canal_0", "vox_tanc_depart_slums_0", "vox_tanc_depart_theater_0", "vox_tanc_divert_canal_0", "vox_tanc_divert_slums_0", "vox_tanc_divert_theater_0" );
        a_keys = getarraykeys( self.m_a_s_stations );
        
        for ( i = 0; i < a_keys.size ; i++ )
        {
            str_key = a_keys[ i ];
            nd_next = self.m_a_s_stations[ str_key ].start_node;
            nd_prev = undefined;
            self.m_a_s_stations[ str_key ].nodes = [];
            
            while ( isdefined( nd_next ) )
            {
                if ( isdefined( nd_prev ) )
                {
                    nd_next.target2 = nd_prev.targetname;
                }
                
                if ( !isdefined( self.m_a_s_stations[ str_key ].nodes ) )
                {
                    self.m_a_s_stations[ str_key ].nodes = [];
                }
                else if ( !isarray( self.m_a_s_stations[ str_key ].nodes ) )
                {
                    self.m_a_s_stations[ str_key ].nodes = array( self.m_a_s_stations[ str_key ].nodes );
                }
                
                self.m_a_s_stations[ str_key ].nodes[ self.m_a_s_stations[ str_key ].nodes.size ] = nd_next;
                nd_prev = nd_next;
                
                if ( !isdefined( nd_next.target ) )
                {
                    break;
                }
                
                nd_next = getvehiclenode( nd_next.target, "targetname" );
            }
            
            num_nodes = self.m_a_s_stations[ str_key ].nodes.size;
            self.m_a_s_stations[ str_key ].junction_node = self.m_a_s_stations[ str_key ].nodes[ num_nodes - 1 ];
            self.m_a_s_stations[ str_key ].path_toward_junction = 1;
        }
        
        a_callboxes = getentarray( "train_call_lever", "targetname" );
        
        foreach ( e_callbox in a_callboxes )
        {
            e_station_closest = arraygetclosest( e_callbox.origin, self.m_a_s_stations );
            assert( isdefined( e_station_closest ) );
            e_callbox.script_string = e_station_closest.station_id;
            e_station_closest.callbox = e_callbox;
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x4fa3acd0, Offset: 0x37b0
    // Size: 0x14
    function function_dda9a9d2()
    {
        self.m_b_facing_forward = !self.m_b_facing_forward;
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0xdbc35e55, Offset: 0x33a0
    // Size: 0x402
    function function_a9acf9e2()
    {
        var_e19f73fe = [];
        
        foreach ( e_player in level.players )
        {
            if ( is_touching_train( e_player ) )
            {
                /#
                    if ( e_player isinmovemode( "<dev string:x6b>", "<dev string:x6f>" ) )
                    {
                        continue;
                    }
                #/
                
                if ( !zm_utility::is_player_valid( e_player, 1, 0 ) )
                {
                    continue;
                }
                
                e_player.train_board_time = gettime();
                
                if ( !isdefined( var_e19f73fe ) )
                {
                    var_e19f73fe = [];
                }
                else if ( !isarray( var_e19f73fe ) )
                {
                    var_e19f73fe = array( var_e19f73fe );
                }
                
                var_e19f73fe[ var_e19f73fe.size ] = e_player;
            }
        }
        
        self.m_vh_train waittill( #"docked_in_station" );
        train_center = self.m_vh_train getcentroid();
        var_10b9b744 = 0;
        
        foreach ( e_player in var_e19f73fe )
        {
            /#
                if ( e_player isinmovemode( "<dev string:x6b>", "<dev string:x6f>" ) )
                {
                    continue;
                }
            #/
            
            if ( !zm_utility::is_player_valid( e_player, 1, 0 ) )
            {
                continue;
            }
            
            if ( !isdefined( e_player.train_board_time ) )
            {
                continue;
            }
            
            if ( isdefined( e_player.last_bleed_out_time ) && e_player.last_bleed_out_time > e_player.train_board_time )
            {
                continue;
            }
            
            if ( !is_touching_train( e_player ) )
            {
                fatal = 0;
                
                do
                {
                    spawnpos = train_center;
                    
                    switch ( var_10b9b744 )
                    {
                        case 0:
                            spawnpos += ( 36, 36, 0 );
                            break;
                        case 1:
                            spawnpos += ( -36, -36, 0 );
                            break;
                        case 2:
                            spawnpos += ( 36, -36, 0 );
                            break;
                        case 3:
                            spawnpos += ( -36, 36, 0 );
                            break;
                        case 4:
                            e_player dodamage( 1000, ( 0, 0, 0 ) );
                            fatal = 1;
                            continue;
                    }
                    
                    var_10b9b744++;
                LOC_000003ae:
                }
                while ( !fatal && !function_eb9ee200( spawnpos ) );
                
                e_player setorigin( spawnpos );
            }
        }
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0x275c672c, Offset: 0x3258
    // Size: 0x13e, Type: bool
    function function_eb9ee200( spawnpos )
    {
        foreach ( e_player in level.players )
        {
            if ( !zm_utility::is_player_valid( e_player, 0, 0 ) )
            {
                continue;
            }
            
            porigin = e_player.origin;
            
            if ( abs( porigin[ 2 ] - spawnpos[ 2 ] ) > 60 )
            {
                continue;
            }
            
            distance_apart = distance2d( porigin, spawnpos );
            
            if ( abs( distance_apart ) > 18 )
            {
                continue;
            }
            
            return false;
        }
        
        return true;
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x47b4e91, Offset: 0x2c48
    // Size: 0x604
    function move()
    {
        self.m_b_incoming = 0;
        str_start = self.m_str_station;
        str_left = self.m_a_s_stations[ str_start ].left_path;
        str_right = self.m_a_s_stations[ str_start ].right_path;
        
        if ( self.m_a_s_stations[ str_start ].path_toward_junction == 0 )
        {
            self.m_vh_train flip180();
            self.m_a_s_stations[ str_start ].path_toward_junction = switch_path_direction( self.m_a_s_stations[ str_start ].nodes, self.m_a_s_stations[ str_start ].path_toward_junction );
            self.m_vh_train switchstartnode( self.m_a_s_stations[ str_start ].start_node, self.m_a_s_stations[ str_start ].junction_node );
        }
        
        if ( self.m_a_s_stations[ str_left ].path_toward_junction == 1 )
        {
            self.m_a_s_stations[ str_left ].path_toward_junction = switch_path_direction( self.m_a_s_stations[ str_left ].nodes, self.m_a_s_stations[ str_left ].path_toward_junction );
            self.m_vh_train switchstartnode( self.m_a_s_stations[ str_left ].start_node, self.m_a_s_stations[ str_left ].junction_node );
        }
        
        if ( self.m_a_s_stations[ str_right ].path_toward_junction == 1 )
        {
            self.m_a_s_stations[ str_right ].path_toward_junction = switch_path_direction( self.m_a_s_stations[ str_right ].nodes, self.m_a_s_stations[ str_right ].path_toward_junction );
            self.m_vh_train switchstartnode( self.m_a_s_stations[ str_right ].start_node, self.m_a_s_stations[ str_right ].junction_node );
        }
        
        sndnum = self.m_a_s_stations[ self.m_str_destination ].audio_depart;
        level clientfield::set( "sndTrainVox", sndnum );
        self.m_vh_train playsoundontag( level.var_98f27ad[ sndnum - 1 ], "tag_support_arm_01" );
        thread watch_node_parameters();
        self.m_vh_train recalcsplinepaths();
        self.m_vh_train attachpath( self.m_a_s_stations[ str_start ].start_node );
        self.m_vh_train startpath();
        
        while ( distance2dsquared( self.m_vh_train.origin, self.m_a_s_stations[ str_start ].junction_node.origin ) > 122500 )
        {
            util::wait_network_frame();
        }
        
        enable_train_switches( 0 );
        thread function_a377ba46();
        str_chosen_path = str_left;
        
        if ( !self.m_a_s_stations[ str_start ].b_left_path_active )
        {
            str_chosen_path = str_right;
        }
        
        which_way = self.m_a_s_stations[ str_chosen_path ].junction_node;
        self.m_vh_train setswitchnode( self.m_a_s_stations[ str_start ].junction_node, self.m_a_s_stations[ str_chosen_path ].junction_node );
        self.m_b_incoming = 1;
        self.var_97fef807 = str_chosen_path;
        level flag::set( self.m_a_s_stations[ str_chosen_path ].str_zone_flag );
        self.m_vh_train waittill( #"reached_end_node" );
        self.m_b_facing_forward = !self.m_b_facing_forward;
        self.m_str_station = str_chosen_path;
        self.m_str_destination = get_current_destination();
        self.m_vh_train notify( #"docked_in_station", self.m_str_station );
        sndnum = self.m_a_s_stations[ self.m_str_station ].audio_arrive;
        level clientfield::set( "sndTrainVox", sndnum );
        self.m_vh_train playsoundontag( level.var_98f27ad[ sndnum - 1 ], "tag_support_arm_01" );
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x8836593c, Offset: 0x2be8
    // Size: 0x58
    function function_7eb2583b()
    {
        timeout = 15;
        
        while ( timeout > 0 && self flag::get( "moving" ) )
        {
            timeout -= 1;
            wait 1;
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x320f6ebf, Offset: 0x2a80
    // Size: 0x15a
    function watch_node_parameters()
    {
        self.m_vh_train endon( #"docked_in_station" );
        
        while ( true )
        {
            self.m_vh_train waittill( #"reached_node", nd );
            
            if ( isdefined( nd.script_parameters ) )
            {
                switch ( nd.script_parameters )
                {
                    case "arrival_brakes":
                        if ( self.m_b_incoming )
                        {
                            self.m_vh_train playsound( "evt_train_stop" );
                            self.m_vh_train stoploopsound( 3 );
                        }
                        
                        break;
                    case "arrival_bell":
                        if ( self.m_b_incoming )
                        {
                            e_callbox = self.m_a_s_stations[ self.m_str_destination ].callbox;
                            e_callbox playsound( "evt_train_station_bell" );
                        }
                        
                        break;
                    default:
                        assertmsg( "<dev string:x4c>" + nd.script_parameters );
                        break;
                }
            }
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0xb5995f60, Offset: 0x2a18
    // Size: 0x60
    function get_current_destination()
    {
        if ( self.m_a_s_stations[ self.m_str_station ].b_left_path_active )
        {
            return self.m_a_s_stations[ self.m_str_station ].left_path;
        }
        
        return self.m_a_s_stations[ self.m_str_station ].right_path;
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x82585757, Offset: 0x2a00
    // Size: 0xa
    function get_current_station()
    {
        return self.m_str_station;
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x99dab385, Offset: 0x27d0
    // Size: 0x228
    function function_a8e2d7ff()
    {
        var_aed9540e = [];
        var_aed9540e[ "moving" ] = getentarray( "lgt_train_lightrig_veh_placement", "targetname" );
        var_aed9540e[ "canals" ] = getentarray( "lgt_train_lightrig_canals_debug", "targetname" );
        var_aed9540e[ "slums" ] = getentarray( "lgt_train_lightrig_slums_debug", "targetname" );
        var_aed9540e[ "theater" ] = getentarray( "lgt_train_lightrig_theater_debug", "targetname" );
        var_105cc375 = ( 0, 45, 0 );
        self enablelinkto();
        
        foreach ( var_83e6406e in var_aed9540e )
        {
            foreach ( var_66fccd7 in var_83e6406e )
            {
                var_66fccd7.origin = self.origin;
                var_66fccd7.angles = self.angles + var_105cc375;
                var_66fccd7 linkto( self );
            }
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0x4b6cc725, Offset: 0x27b8
    // Size: 0xa
    function get_train_vehicle()
    {
        return self.m_vh_train;
    }

    // Namespace czmtrain
    // Params 1
    // Checksum 0xb675e256, Offset: 0x26f8
    // Size: 0xb8
    function enable_train_switches( b_enabled )
    {
        if ( b_enabled )
        {
            self flag::set( "switches_enabled" );
            self.m_t_switch sethintstring( &"ZM_ZOD_SWITCH_ENABLE" );
            function_ca899bfc();
            return;
        }
        
        self flag::clear( "switches_enabled" );
        self.m_t_switch sethintstring( &"ZM_ZOD_SWITCH_DISABLE" );
        self.m_vh_train notify( #"hash_51689c0f" );
    }

    // Namespace czmtrain
    // Params 2
    // Checksum 0x8b0f3deb, Offset: 0x2648
    // Size: 0xa4, Type: bool
    function switch_path_direction( all_nodes, direction )
    {
        for ( i = 0; i < all_nodes.size ; i++ )
        {
            prev_target = all_nodes[ i ].target;
            all_nodes[ i ].target = all_nodes[ i ].target2;
            all_nodes[ i ].target2 = prev_target;
        }
        
        return !direction;
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0xbbcbf00e, Offset: 0x2328
    // Size: 0x318
    function debug_draw_doors()
    {
        do
        {
            n_debug = getdvarint( "train_debug_doors" );
            wait 1;
        }
        while ( !isdefined( n_debug ) || n_debug <= 0 );
        
        while ( true )
        {
            duration = 1;
            var_6ffe9d93 = 240;
            var_4dc5a359 = 12;
            origin = self.m_vh_train.origin;
            origin += ( 0, 0, -90 );
            forward = anglestoforward( self.m_vh_train.angles );
            right = anglestoright( self.m_vh_train.angles );
            
            if ( !self.m_b_facing_forward )
            {
                forward = -1 * forward;
            }
            
            var_bba032ca = origin + var_6ffe9d93 * forward;
            
            /#
                line( origin, var_bba032ca, ( 1, 0, 0 ), 1, 1, duration );
            #/
            
            /#
                line( var_bba032ca, var_bba032ca - var_4dc5a359 * forward - var_4dc5a359 * right, ( 1, 0, 0 ), 1, 1, duration );
            #/
            
            /#
                line( var_bba032ca, var_bba032ca - var_4dc5a359 * forward + var_4dc5a359 * right, ( 1, 0, 0 ), 1, 1, duration );
            #/
            
            foreach ( e_door in self.m_a_mdl_doors )
            {
                var_d4280494 = e_door.origin;
                open = is_door_open( e_door );
                str_state = "closed";
                
                if ( open )
                {
                    str_state = "open";
                }
                
                /#
                    print3d( var_d4280494, str_state, ( 0, 0, 1 ), 1, 1, duration );
                #/
            }
            
            wait 0.05;
        }
    }

    // Namespace czmtrain
    // Params 0
    // Checksum 0xb1e15503, Offset: 0x1f10
    // Size: 0x410, Type: dev
    function debug_draw_paths()
    {
        /#
            do
            {
                n_debug = getdvarint( "<dev string:x28>" );
                wait 1;
            }
            while ( !isdefined( n_debug ) || n_debug <= 0 );
            
            while ( true )
            {
                a_keys = getarraykeys( self.m_a_s_stations );
                
                for ( key_num = 0; key_num < self.m_a_s_stations.size ; key_num++ )
                {
                    j = a_keys[ key_num ];
                    node_set = self.m_a_s_stations[ j ].nodes;
                    
                    for ( i = 0; i < node_set.size ; i++ )
                    {
                        node = node_set[ i ];
                        node_pos = node.origin + ( 0, 0, -95 );
                        debugstar( node_pos, 1, ( 1, 0, 0 ) );
                        
                        if ( isdefined( node.target ) )
                        {
                            node_target = getvehiclenode( node.target, "<dev string:x34>" );
                            node_target_pos = node_target.origin + ( 0, 0, -70 );
                            line( node_pos, node_target_pos, ( 0, 1, 0 ), 0, 1 );
                            debugstar( node_target_pos, 1, ( 0, 1, 0 ) );
                        }
                        
                        if ( isdefined( node.target2 ) )
                        {
                            node_target2 = getvehiclenode( node.target2, "<dev string:x34>" );
                            node_target2_pos = node_target2.origin + ( 0, 0, -120 );
                            line( node_pos, node_target2_pos, ( 0, 0, 1 ), 0, 1 );
                            debugstar( node_target2_pos, 1, ( 0, 0, 1 ) );
                        }
                    }
                }
                
                a_zombies = getaiteamarray( level.zombie_team );
                
                foreach ( ai in a_zombies )
                {
                    if ( isdefined( ai.locked_in_train ) && ai.locked_in_train )
                    {
                        print3d( ai.origin + ( 0, 0, 100 ), "<dev string:x3f>" + self.m_a_zombies_locked_in.size + "<dev string:x4a>", ( 0, 255, 0 ), 1 );
                    }
                }
                
                wait 0.05;
            }
        #/
    }

}

// Namespace zm_train
// Params 0, eflags: 0x2
// Checksum 0xbdd9c4ef, Offset: 0xce0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_train", &__init__, undefined, undefined );
}

// Namespace zm_train
// Params 0
// Checksum 0x3fa43a3f, Offset: 0xd20
// Size: 0x10
function onplayerconnect()
{
    self.on_train = 0;
}

// Namespace zm_train
// Params 0
// Checksum 0x43133229, Offset: 0xd38
// Size: 0x1c4
function __init__()
{
    callback::on_connect( &onplayerconnect );
    callback::on_spawned( &player_on_spawned );
    zm_zod_util::on_zombie_killed( &remove_dead_zombie );
    zm_zod_util::add_zod_zombie_spawn_func( &zombie_init );
    clientfield::register( "vehicle", "train_switch_light", 1, 2, "int" );
    clientfield::register( "scriptmover", "train_callbox_light", 1, 2, "int" );
    clientfield::register( "scriptmover", "train_map_light", 1, 2, "int" );
    clientfield::register( "vehicle", "train_rain_fx_occluder", 1, 1, "int" );
    clientfield::register( "world", "sndTrainVox", 1, 4, "int" );
    level.player_intemission_spawn_callback = &player_intemission_spawn_callback;
    thread initialize_train();
    thread function_eb0db7bc();
    
    /#
        thread train_devgui();
    #/
}

// Namespace zm_train
// Params 0
// Checksum 0x68ea01f1, Offset: 0xf08
// Size: 0xac
function function_eb0db7bc()
{
    level flag::wait_till( "all_players_spawned" );
    level flag::wait_till( "zones_initialized" );
    
    while ( true )
    {
        level waittill( #"host_migration_end" );
        [[ level.o_zod_train ]]->initialize_stations();
        [[ level.o_zod_train ]]->function_7eb2583b();
        [[ level.o_zod_train ]]->function_dda9a9d2();
        [[ level.o_zod_train ]]->send_train();
    }
}

// Namespace zm_train
// Params 2
// Checksum 0x49391276, Offset: 0xfc0
// Size: 0xbc
function player_intemission_spawn_callback( origin, angles )
{
    ride_vehicle = undefined;
    self.ground_ent = self getgroundent();
    
    if ( isdefined( self.ground_ent ) )
    {
        if ( isvehicle( self.ground_ent ) && !( level.zombie_team === self.ground_ent ) )
        {
            ride_vehicle = self.ground_ent;
        }
    }
    
    if ( isdefined( ride_vehicle ) )
    {
        self spawn( origin, angles );
    }
}

// Namespace zm_train
// Params 0
// Checksum 0xd73d9d57, Offset: 0x1088
// Size: 0x108
function initialize_train()
{
    level flag::wait_till( "all_players_spawned" );
    level flag::wait_till( "zones_initialized" );
    e_train = getent( "zod_train", "targetname" );
    e_train function_7465f87();
    e_train.takedamage = 0;
    e_train clientfield::set( "train_rain_fx_occluder", 1 );
    level.o_zod_train = new czmtrain();
    [[ level.o_zod_train ]]->initialize( e_train );
    level thread autosend_train();
    level.var_33c4ee76 = 0;
}

// Namespace zm_train
// Params 1
// Checksum 0xec474585, Offset: 0x1198
// Size: 0xb6
function function_f37aa349( sn )
{
    ents = getentarray();
    
    foreach ( ent in ents )
    {
        if ( ent.script_noteworthy === sn )
        {
            return ent;
        }
    }
    
    return undefined;
}

// Namespace zm_train
// Params 0
// Checksum 0xf99bfce4, Offset: 0x1258
// Size: 0x33a
function function_7465f87()
{
    trigs = getentarray( "train_buyable_weapon", "script_noteworthy" );
    
    foreach ( trig in trigs )
    {
        trig enablelinkto();
        trig linkto( self, "", self worldtolocalcoords( trig.origin ), ( 0, 0, 0 ) );
        trig.weapon = getweapon( trig.zombie_weapon_upgrade );
        trig setcursorhint( "HINT_WEAPON", trig.weapon );
        trig.cost = zm_weapons::get_weapon_cost( trig.weapon );
        trig.hint_string = zm_weapons::get_weapon_hint( trig.weapon );
        
        if ( isdefined( level.weapon_cost_client_filled ) && level.weapon_cost_client_filled )
        {
            trig sethintstring( trig.hint_string );
        }
        else
        {
            trig.hint_parm1 = trig.cost;
            trig sethintstring( trig.hint_string, trig.hint_parm1 );
        }
        
        self.buyable_weapon = trig;
        level._spawned_wallbuys[ level._spawned_wallbuys.size ] = trig;
        weapon_model = getent( trig.target, "targetname" );
        weapon_model linkto( self, "", self worldtolocalcoords( weapon_model.origin ), weapon_model.angles + self.angles );
        weapon_model setmovingplatformenabled( 1 );
        weapon_model._linked_ent = trig;
        weapon_model show();
        weapon_model thread function_d7993b3d( trig );
    }
}

// Namespace zm_train
// Params 0
// Checksum 0xaa3fe45e, Offset: 0x15a0
// Size: 0x1c
function player_on_spawned()
{
    self thread function_69c89e00();
}

// Namespace zm_train
// Params 0
// Checksum 0x64908cd3, Offset: 0x15c8
// Size: 0x142
function function_69c89e00()
{
    self endon( #"disconnect" );
    self notify( #"hash_69c89e00" );
    self endon( #"hash_69c89e00" );
    level flag::wait_till( "all_players_spawned" );
    level flag::wait_till( "zones_initialized" );
    wait 1;
    wallbuy = level.o_zod_train.m_vh_train.buyable_weapon;
    self notify( #"zm_bgb_secret_shopper", wallbuy );
    self.var_316060b3 = 0;
    
    while ( isdefined( self ) )
    {
        if ( isdefined( self.on_train ) && self.on_train )
        {
            if ( !self.var_316060b3 )
            {
                self notify( #"zm_bgb_secret_shopper", wallbuy );
            }
            
            wallbuy function_2e9b7fc1( self, wallbuy.weapon );
        }
        else if ( self.var_316060b3 )
        {
            self notify( #"hash_a09e2c64" );
        }
        
        self.var_316060b3 = self.on_train;
        wait 1;
    }
}

// Namespace zm_train
// Params 2
// Checksum 0x539a5ebf, Offset: 0x1718
// Size: 0x4f8, Type: bool
function function_2e9b7fc1( player, weapon )
{
    if ( !isdefined( weapon ) )
    {
        weapon = self.weapon;
    }
    
    player_has_weapon = player zm_weapons::has_weapon_or_upgrade( weapon );
    
    if ( isdefined( level.weapons_using_ammo_sharing ) && !player_has_weapon && level.weapons_using_ammo_sharing )
    {
        shared_ammo_weapon = player zm_weapons::get_shared_ammo_weapon( self.zombie_weapon_upgrade );
        
        if ( isdefined( shared_ammo_weapon ) )
        {
            weapon = shared_ammo_weapon;
            player_has_weapon = 1;
        }
    }
    
    if ( !player_has_weapon )
    {
        cursor_hint = "HINT_WEAPON";
        cost = zm_weapons::get_weapon_cost( weapon );
        
        if ( isdefined( level.weapon_cost_client_filled ) && level.weapon_cost_client_filled )
        {
            if ( player bgb::is_enabled( "zm_bgb_secret_shopper" ) && !zm_weapons::is_wonder_weapon( player.currentweapon ) )
            {
                hint_string = &"ZOMBIE_WEAPONCOSTONLY_CFILL_BGB_SECRET_SHOPPER";
                self sethintstringforplayer( player, hint_string );
            }
            else
            {
                hint_string = &"ZOMBIE_WEAPONCOSTONLY_CFILL";
                self sethintstringforplayer( player, hint_string );
            }
        }
        else if ( player bgb::is_enabled( "zm_bgb_secret_shopper" ) && !zm_weapons::is_wonder_weapon( player.currentweapon ) )
        {
            hint_string = &"ZOMBIE_WEAPONCOSTONLYFILL_BGB_SECRET_SHOPPER";
            n_bgb_cost = player zm_weapons::get_ammo_cost_for_weapon( player.currentweapon );
            self sethintstringforplayer( player, hint_string, cost, n_bgb_cost );
        }
        else
        {
            hint_string = &"ZOMBIE_WEAPONCOSTONLYFILL";
            self sethintstringforplayer( player, hint_string, cost );
        }
    }
    else
    {
        if ( player bgb::is_enabled( "zm_bgb_secret_shopper" ) && !zm_weapons::is_wonder_weapon( weapon ) )
        {
            ammo_cost = player zm_weapons::get_ammo_cost_for_weapon( weapon );
        }
        else if ( player zm_weapons::has_upgrade( weapon ) )
        {
            ammo_cost = zm_weapons::get_upgraded_ammo_cost( weapon );
        }
        else
        {
            ammo_cost = zm_weapons::get_ammo_cost( weapon );
        }
        
        if ( isdefined( level.weapon_cost_client_filled ) && level.weapon_cost_client_filled )
        {
            if ( player bgb::is_enabled( "zm_bgb_secret_shopper" ) && !zm_weapons::is_wonder_weapon( player.currentweapon ) )
            {
                hint_string = &"ZOMBIE_WEAPONAMMOONLY_CFILL_BGB_SECRET_SHOPPER";
                self sethintstringforplayer( player, hint_string );
            }
            else
            {
                hint_string = &"ZOMBIE_WEAPONAMMOONLY_CFILL";
                self sethintstringforplayer( player, hint_string );
            }
        }
        else if ( player bgb::is_enabled( "zm_bgb_secret_shopper" ) && !zm_weapons::is_wonder_weapon( player.currentweapon ) )
        {
            hint_string = &"ZOMBIE_WEAPONAMMOONLY_BGB_SECRET_SHOPPER";
            n_bgb_cost = player zm_weapons::get_ammo_cost_for_weapon( player.currentweapon );
            self sethintstringforplayer( player, hint_string, ammo_cost, n_bgb_cost );
        }
        else
        {
            hint_string = &"ZOMBIE_WEAPONAMMOONLY";
            self sethintstringforplayer( player, hint_string, ammo_cost );
        }
    }
    
    cursor_hint = "HINT_WEAPON";
    cursor_hint_weapon = weapon;
    self setcursorhint( cursor_hint, cursor_hint_weapon );
    return true;
}

// Namespace zm_train
// Params 1
// Checksum 0x619407b6, Offset: 0x1c18
// Size: 0x64
function function_d7993b3d( trigger )
{
    self.orgmodel = self.model;
    self setmodel( "wpn_t7_none_world" );
    trigger waittill( #"trigger" );
    self setmodel( self.orgmodel );
}

// Namespace zm_train
// Params 0
// Checksum 0x11518fa2, Offset: 0x1c88
// Size: 0x10
function zombie_init()
{
    self.locked_in_train = 0;
}

// Namespace zm_train
// Params 0
// Checksum 0xdd56e2fa, Offset: 0x1ca0
// Size: 0x38
function autosend_train()
{
    level flag::wait_till( "connect_start_to_junction" );
    [[ level.o_zod_train ]]->send_train();
}

// Namespace zm_train
// Params 4
// Checksum 0x6822fd88, Offset: 0x8c18
// Size: 0x7e, Type: bool
function in_range_2d( v1, v2, range, vert_allowance )
{
    if ( abs( v1[ 2 ] - v2[ 2 ] ) > vert_allowance )
    {
        return false;
    }
    
    return distance2dsquared( v1, v2 ) < range * range;
}

// Namespace zm_train
// Params 1
// Checksum 0x7b70a744, Offset: 0x8ca0
// Size: 0x32
function get_players_on_train( b_valid_targets_only )
{
    if ( !isdefined( b_valid_targets_only ) )
    {
        b_valid_targets_only = 0;
    }
    
    return [[ level.o_zod_train ]]->get_players_on_train( 1 );
}

// Namespace zm_train
// Params 0
// Checksum 0x9c7b626a, Offset: 0x8ce0
// Size: 0x26
function is_moving()
{
    if ( !isdefined( level.o_zod_train ) )
    {
        return 0;
    }
    
    return [[ level.o_zod_train ]]->is_moving();
}

// Namespace zm_train
// Params 1
// Checksum 0x95c19e39, Offset: 0x8d10
// Size: 0x88
function zombie_jump_onto_moving_train( ai )
{
    [[ level.o_zod_train ]]->mark_jumper_time();
    spot = [[ level.o_zod_train ]]->get_available_jumptag();
    
    if ( isdefined( spot ) )
    {
        ai.str_train_tag = spot.str_tag;
        [[ level.o_zod_train ]]->jump_into_train( ai, spot.str_tag );
    }
}

// Namespace zm_train
// Params 3
// Checksum 0x514bec09, Offset: 0x8da0
// Size: 0xe8
function remove_dead_zombie( e_attacker, str_means_of_death, weapon )
{
    if ( isdefined( self ) )
    {
        b_on_train = 0;
        
        if ( is_moving() )
        {
            if ( self.locked_in_train )
            {
                b_on_train = 1;
            }
        }
        
        if ( b_on_train )
        {
            self clientfield::set( "zombie_gut_explosion", 1 );
            self ghost();
        }
    }
    
    if ( isdefined( level.o_zod_train ) )
    {
        if ( isdefined( self ) && self.locked_in_train )
        {
            [[ level.o_zod_train ]]->remove_zombie_locked_in( self );
            return;
        }
        
        [[ level.o_zod_train ]]->locked_in_list_remove_undefined();
    }
}

// Namespace zm_train
// Params 0
// Checksum 0xde13bfa5, Offset: 0x8e90
// Size: 0x2a
function get_num_zombies_locked_in()
{
    a_zombies = [[ level.o_zod_train ]]->get_zombies_locked_in();
    return a_zombies.size;
}

// Namespace zm_train
// Params 0
// Checksum 0xdaf9ed5d, Offset: 0x8ec8
// Size: 0x18, Type: bool
function is_full()
{
    return get_num_zombies_locked_in() >= 6;
}

// Namespace zm_train
// Params 0
// Checksum 0xc4210679, Offset: 0x8ee8
// Size: 0x20, Type: bool
function is_ready_for_jumper()
{
    return [[ level.o_zod_train ]]->get_time_since_last_jumper() > 10;
}

/#

    // Namespace zm_train
    // Params 0
    // Checksum 0x9185acab, Offset: 0x8f10
    // Size: 0xdc, Type: dev
    function debug_go_to_train()
    {
        train = getent( "<dev string:xe2>", "<dev string:x34>" );
        
        if ( isdefined( train ) )
        {
            train_origin = train getorigin();
            player = level.players[ 0 ];
            
            if ( isdefined( player ) && isdefined( train_origin ) )
            {
                train_origin = ( train_origin[ 0 ], train_origin[ 1 ], train_origin[ 2 ] - 100 );
                player setorigin( train_origin );
            }
        }
    }

    // Namespace zm_train
    // Params 0
    // Checksum 0x5577b68c, Offset: 0x8ff8
    // Size: 0x1f0, Type: dev
    function train_devgui()
    {
        setdvar( "<dev string:xec>", "<dev string:x101>" );
        adddebugcommand( "<dev string:x102>" );
        adddebugcommand( "<dev string:x13d>" );
        adddebugcommand( "<dev string:x177>" );
        adddebugcommand( "<dev string:x1bc>" );
        adddebugcommand( "<dev string:x204>" );
        adddebugcommand( "<dev string:x24e>" );
        adddebugcommand( "<dev string:x27f>" );
        adddebugcommand( "<dev string:x2c0>" );
        
        while ( true )
        {
            cmd = getdvarstring( "<dev string:xec>" );
            
            if ( cmd != "<dev string:x101>" )
            {
                switch ( cmd )
                {
                    case "<dev string:x318>":
                    case "<dev string:x30a>":
                    case "<dev string:x310>":
                        break;
                    case "<dev string:x31e>":
                        [[ level.o_zod_train ]]->open_doors();
                        break;
                    case "<dev string:x329>":
                        [[ level.o_zod_train ]]->close_doors();
                        break;
                    case "<dev string:x335>":
                        debug_go_to_train();
                        break;
                    default:
                        break;
                }
                
                setdvar( "<dev string:xec>", "<dev string:x101>" );
            }
            
            util::wait_network_frame();
        }
    }

#/
