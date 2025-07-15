#using scripts/codescripts/struct;
#using scripts/cp/_laststand;
#using scripts/cp/_pickups;
#using scripts/cp/_scoreevents;
#using scripts/cp/_util;
#using scripts/shared/ai_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;

#namespace pickups;

// Namespace pickups
// Method(s) 13 Total 38
class cpickupitem : cbaseinteractable
{

    // Namespace cpickupitem
    // Params 0
    // Checksum 0x6ee9770b, Offset: 0x3c8
    // Size: 0xe6
    function constructor()
    {
        self.m_n_respawn_time = 1;
        self.m_n_respawn_rounds = 0;
        self.m_n_throw_distance_min = 128;
        self.m_n_throw_distance_max = 256;
        self.m_n_throw_max_hold_duration = 2;
        self.m_v_holding_angle = ( 0, 0, 0 );
        self.m_n_despawn_wait = 0;
        self.m_v_holding_offset_angle = ( 45, 0, 0 );
        self.m_n_holding_distance = 64;
        self.m_n_drop_offset = 0;
        self.m_iscarryable = 1;
        self.a_carry_threads = [];
        self.a_carry_threads[ 0 ] = &carry_pickupitem;
        self.a_drop_funcs = [];
        self.a_drop_funcs[ 0 ] = &drop_pickupitem;
    }

    // Namespace cpickupitem
    // Params 1
    // Checksum 0xffb7b0cf, Offset: 0xad0
    // Size: 0x34
    function drop_pickupitem( e_triggerer )
    {
        pickupitem_spawn( e_triggerer.origin, e_triggerer.angles );
    }

    // Namespace cpickupitem
    // Params 1
    // Checksum 0x112051c1, Offset: 0xa88
    // Size: 0x3c
    function carry_pickupitem( e_triggerer )
    {
        self.m_e_model delete();
        self.m_e_body_trigger setinvisibletoall();
    }

    // Namespace cpickupitem
    // Params 0
    // Checksum 0x6bed268a, Offset: 0xa50
    // Size: 0x30
    function pickupitem_respawn_delay()
    {
        if ( self.m_n_respawn_rounds > 0 )
        {
            return;
        }
        
        if ( self.m_n_respawn_time > 0 )
        {
            wait self.m_n_respawn_time;
        }
    }

    // Namespace cpickupitem
    // Params 0
    // Checksum 0xfa6d1213, Offset: 0xa30
    // Size: 0x12
    function pickupitem_despawn()
    {
        self notify( #"respawn_pickupitem" );
    }

    // Namespace cpickupitem
    // Params 0
    // Checksum 0x27912ab0, Offset: 0x988
    // Size: 0x9e
    function debug_despawn_timer()
    {
        self endon( #"cancel_despawn" );
        n_time_remaining = self.m_n_despawn_wait;
        
        while ( n_time_remaining >= 0 && isdefined( self.m_e_model ) )
        {
            /#
                print3d( self.m_e_model.origin + ( 0, 0, 15 ), n_time_remaining, ( 1, 0, 0 ), 1, 1, 20 );
            #/
            
            wait 1;
            n_time_remaining -= 1;
        }
    }

    // Namespace cpickupitem
    // Params 0
    // Checksum 0x356dd499, Offset: 0x910
    // Size: 0x6c
    function pickupitem_despawn_timer()
    {
        self endon( #"cancel_despawn" );
        
        if ( self.m_n_despawn_wait <= 0 )
        {
            return;
        }
        
        self thread debug_despawn_timer();
        wait self.m_n_despawn_wait;
        
        if ( isdefined( self.m_custom_despawn_func ) )
        {
            [[ self.m_custom_despawn_func ]]();
            return;
        }
        
        pickupitem_despawn();
    }

    // Namespace cpickupitem
    // Params 2
    // Checksum 0x908a9c1c, Offset: 0x638
    // Size: 0x2cc
    function pickupitem_spawn( v_pos, v_angles )
    {
        if ( !isdefined( self.m_e_model ) )
        {
            self.m_e_model = util::spawn_model( self.m_str_modelname, v_pos + ( 0, 0, self.m_n_drop_offset ), v_angles );
            self.m_e_model notsolid();
            
            if ( isdefined( self.m_fx_glow ) )
            {
                playfxontag( self.m_fx_glow, self.m_e_model, "tag_origin" );
            }
        }
        
        self.m_str_pickup_hintstring = "Press and hold ^3[{+activate}]^7 to pick up " + self.m_str_itemname;
        
        if ( !isdefined( self.m_e_body_trigger ) )
        {
            e_trigger = cbaseinteractable::spawn_body_trigger( v_pos );
            cbaseinteractable::set_body_trigger( e_trigger );
        }
        
        self.m_e_body_trigger setvisibletoall();
        self.m_e_body_trigger.origin = v_pos;
        self.m_e_body_trigger notify( #"upgrade_trigger_moved" );
        self.m_e_body_trigger notify( #"upgrade_trigger_enable", 1 );
        self.m_e_body_trigger sethintstring( self.m_str_pickup_hintstring );
        self.m_e_body_trigger.str_itemname = self.m_str_itemname;
        
        if ( !isdefined( self.m_e_body_trigger.targetname ) )
        {
            m_str_targetname = "";
            m_a_str_targetname = strtok( tolower( self.m_str_itemname ), " " );
            
            foreach ( n_index, m_str_targetname_piece in m_a_str_targetname )
            {
                if ( n_index > 0 )
                {
                    m_str_targetname += "_";
                }
                
                m_str_targetname += m_str_targetname_piece;
            }
            
            self.m_e_body_trigger.targetname = "trigger_" + m_str_targetname;
        }
        
        if ( self.m_iscarryable )
        {
            self thread cbaseinteractable::thread_allow_carry();
        }
    }

    // Namespace cpickupitem
    // Params 2
    // Checksum 0xad595426, Offset: 0x598
    // Size: 0x98
    function respawn_loop( v_pos, v_angles )
    {
        while ( true )
        {
            if ( isdefined( self.m_custom_spawn_func ) )
            {
                [[ self.m_custom_spawn_func ]]( v_pos, v_angles );
            }
            else
            {
                self.m_str_holding_hintstring = "Press ^3[{+usereload}]^7 to drop " + self.m_str_itemname;
                pickupitem_spawn( v_pos, v_angles );
            }
            
            self waittill( #"respawn_pickupitem" );
            pickupitem_respawn_delay();
        }
    }

    // Namespace cpickupitem
    // Params 2
    // Checksum 0x6734b55, Offset: 0x560
    // Size: 0x2c
    function spawn_at_position( v_pos, v_angles )
    {
        respawn_loop( v_pos, v_angles );
    }

    // Namespace cpickupitem
    // Params 1
    // Checksum 0x6e49965b, Offset: 0x4f8
    // Size: 0x5c
    function spawn_at_struct( str_struct )
    {
        if ( !isdefined( str_struct.angles ) )
        {
            str_struct.angles = ( 0, 0, 0 );
        }
        
        respawn_loop( str_struct.origin, str_struct.angles );
    }

    // Namespace cpickupitem
    // Params 0
    // Checksum 0x2322ea50, Offset: 0x4b8
    // Size: 0x32
    function get_model()
    {
        if ( isdefined( self.m_e_carry_model ) )
        {
            return self.m_e_carry_model;
        }
        else if ( isdefined( self.m_e_model ) )
        {
            return self.m_e_model;
        }
        
        return undefined;
    }

}

// Namespace pickups
// Method(s) 27 Total 27
class cbaseinteractable
{

    var disable_object_pickup;

    // Namespace cbaseinteractable
    // Params 0
    // Checksum 0xf8b46e77, Offset: 0x12b0
    // Size: 0x7c
    function constructor()
    {
        self.m_isfunctional = 1;
        self.m_ishackable = 0;
        self.m_iscarryable = 0;
        self.m_n_body_trigger_radius = 36;
        self.m_n_body_trigger_height = 128;
        self.m_n_repair_radius = 72;
        self.m_n_repair_height = 128;
        self.m_repair_complete_func = &repair_completed;
        self.m_str_itemname = "Item";
    }

    // Namespace cbaseinteractable
    // Params 4
    // Checksum 0x6eb896d7, Offset: 0x2188
    // Size: 0x168
    function spawn_interact_trigger( v_origin, n_radius, n_height, str_hint )
    {
        assert( isdefined( v_origin ), "<dev string:x28>" );
        assert( isdefined( n_radius ), "<dev string:x56>" );
        assert( isdefined( n_height ), "<dev string:x84>" );
        e_trigger = spawn( "trigger_radius", v_origin, 0, n_radius, n_height );
        e_trigger triggerignoreteam();
        e_trigger setvisibletoall();
        e_trigger setteamfortrigger( "none" );
        e_trigger setcursorhint( "HINT_NOICON" );
        
        if ( isdefined( str_hint ) )
        {
            e_trigger sethintstring( str_hint );
        }
        
        return e_trigger;
    }

    // Namespace cbaseinteractable
    // Params 1
    // Checksum 0x1ea0c7, Offset: 0x2118
    // Size: 0x68
    function spawn_body_trigger( v_origin )
    {
        e_trigger = spawn_interact_trigger( v_origin, self.m_n_body_trigger_radius, self.m_n_body_trigger_height, "" );
        e_trigger sethintlowpriority( 1 );
        return e_trigger;
    }

    // Namespace cbaseinteractable
    // Params 1
    // Checksum 0x9111d7ee, Offset: 0x20c0
    // Size: 0x4c
    function spawn_repair_trigger( v_origin )
    {
        e_repair_trigger = spawn_interact_trigger( v_origin, self.m_n_repair_radius, self.m_n_repair_height, "Bring Toolbox to repair" );
        return e_repair_trigger;
    }

    // Namespace cbaseinteractable
    // Params 1
    // Checksum 0x2f2e6149, Offset: 0x2048
    // Size: 0x6c
    function drop_on_death( e_triggerer )
    {
        self notify( #"drop_on_death" );
        self endon( #"drop_on_death" );
        e_triggerer util::waittill_any( "player_downed", "death" );
        
        if ( isdefined( self.m_e_player_currently_holding ) )
        {
            drop( e_triggerer );
        }
    }

    // Namespace cbaseinteractable
    // Params 0
    // Checksum 0x3f68bc31, Offset: 0x2008
    // Size: 0x34
    function _wait_for_button_release()
    {
        self endon( #"player_downed" );
        
        while ( self usebuttonpressed() )
        {
            wait 0.05;
        }
    }

    // Namespace cbaseinteractable
    // Params 0
    // Checksum 0x7ecaf472, Offset: 0x1fc0
    // Size: 0x3e
    function wait_for_button_release()
    {
        self endon( #"death_or_disconnect" );
        self.disable_object_pickup = 1;
        self _wait_for_button_release();
        disable_object_pickup = undefined;
    }

    // Namespace cbaseinteractable
    // Params 0
    // Checksum 0xe215b463, Offset: 0x1f40
    // Size: 0x78
    function destroy()
    {
        if ( isdefined( self.m_e_player_currently_holding ) )
        {
            restore_player_controls_from_carry( self.m_e_player_currently_holding );
            self.m_e_player_currently_holding util::screen_message_delete_client();
        }
        
        if ( isdefined( self.m_e_carry_model ) )
        {
            self.m_e_carry_model delete();
        }
        
        self.m_e_player_currently_holding = undefined;
    }

    // Namespace cbaseinteractable
    // Params 1
    // Checksum 0x46c8c2e1, Offset: 0x1eb8
    // Size: 0x7e
    function remove( e_triggerer )
    {
        restore_player_controls_from_carry( e_triggerer );
        e_triggerer util::screen_message_delete_client();
        
        if ( isdefined( self.m_e_carry_model ) )
        {
            self.m_e_carry_model delete();
        }
        
        self.m_e_player_currently_holding = undefined;
        self notify( #"respawn_pickupitem" );
    }

    // Namespace cbaseinteractable
    // Params 1
    // Checksum 0xbe645fbc, Offset: 0x1d80
    // Size: 0x12c
    function drop( e_triggerer )
    {
        restore_player_controls_from_carry( e_triggerer );
        e_triggerer util::screen_message_delete_client();
        
        if ( isdefined( self.m_e_carry_model ) )
        {
            self.m_e_carry_model delete();
        }
        
        if ( isdefined( self.a_drop_funcs ) )
        {
            foreach ( drop_func in self.a_drop_funcs )
            {
                [[ drop_func ]]( e_triggerer );
            }
        }
        
        self.m_e_player_currently_holding = undefined;
        self thread thread_allow_carry();
        e_triggerer thread wait_for_button_release();
    }

    // Namespace cbaseinteractable
    // Params 1
    // Checksum 0x578db70b, Offset: 0x1cf0
    // Size: 0x84
    function restore_player_controls_from_carry( e_triggerer )
    {
        e_triggerer endon( #"death" );
        e_triggerer endon( #"player_downed" );
        
        if ( !e_triggerer.is_carrying_pickupitem )
        {
            return;
        }
        
        e_triggerer notify( #"restore_player_controls_from_carry" );
        e_triggerer enableweapons();
        e_triggerer.is_carrying_pickupitem = 0;
        e_triggerer allowjump( 1 );
    }

    // Namespace cbaseinteractable
    // Params 1
    // Checksum 0xb599f0f8, Offset: 0x1ac0
    // Size: 0x228
    function show_carry_model( e_triggerer )
    {
        e_triggerer endon( #"restore_player_controls_from_carry" );
        e_triggerer endon( #"death" );
        e_triggerer endon( #"player_downed" );
        v_eye_origin = e_triggerer geteye();
        v_player_angles = e_triggerer getplayerangles();
        v_player_angles += self.m_v_holding_offset_angle;
        v_player_angles = anglestoforward( v_player_angles );
        v_angles = e_triggerer.angles + self.m_v_holding_angle;
        v_origin = v_eye_origin + v_player_angles * self.m_n_holding_distance;
        
        if ( !isdefined( self.m_str_carry_model ) )
        {
            if ( isdefined( self.m_str_modelname ) )
            {
                self.m_str_carry_model = self.m_str_modelname;
            }
            else
            {
                self.m_str_carry_model = "script_origin";
            }
        }
        
        self.m_e_carry_model = util::spawn_model( self.m_str_carry_model, v_origin, v_angles );
        self.m_e_carry_model notsolid();
        
        while ( isdefined( self.m_e_carry_model ) )
        {
            v_eye_origin = e_triggerer geteye();
            v_player_angles = e_triggerer getplayerangles();
            v_player_angles += self.m_v_holding_offset_angle;
            v_player_angles = anglestoforward( v_player_angles );
            self.m_e_carry_model.angles = e_triggerer.angles + self.m_v_holding_angle;
            self.m_e_carry_model.origin = v_eye_origin + v_player_angles * self.m_n_holding_distance;
            wait 0.05;
        }
    }

    // Namespace cbaseinteractable
    // Params 1
    // Checksum 0x44a73738, Offset: 0x1a00
    // Size: 0xb4
    function thread_allow_drop( e_triggerer )
    {
        e_triggerer endon( #"restore_player_controls_from_carry" );
        e_triggerer endon( #"death" );
        e_triggerer endon( #"player_downed" );
        self thread drop_on_death( e_triggerer );
        
        while ( e_triggerer usebuttonpressed() )
        {
            wait 0.05;
        }
        
        while ( !e_triggerer usebuttonpressed() )
        {
            wait 0.05;
        }
        
        self thread drop( e_triggerer );
    }

    // Namespace cbaseinteractable
    // Params 1
    // Checksum 0x20051ae, Offset: 0x19c0
    // Size: 0x34
    function flash_drop_prompt_stop( player )
    {
        player notify( #"stop_flashing_drop_prompt" );
        player util::screen_message_delete_client();
    }

    // Namespace cbaseinteractable
    // Params 1
    // Checksum 0x2bef749c, Offset: 0x1938
    // Size: 0x80
    function flash_drop_prompt( player )
    {
        self endon( #"death" );
        player endon( #"death" );
        player endon( #"stop_flashing_drop_prompt" );
        
        while ( true )
        {
            player util::screen_message_create_client( get_drop_prompt(), undefined, undefined, 0, 0.35 );
            wait 0.35;
        }
    }

    // Namespace cbaseinteractable
    // Params 1
    // Checksum 0x61ec9e7d, Offset: 0x18f8
    // Size: 0x34
    function show_drop_prompt( player )
    {
        player util::screen_message_create_client( get_drop_prompt() );
    }

    // Namespace cbaseinteractable
    // Params 0
    // Checksum 0x24eecae5, Offset: 0x18d8
    // Size: 0x14
    function get_drop_prompt()
    {
        return "Press ^3[{+usereload}]^7 to drop " + self.m_str_itemname;
    }

    // Namespace cbaseinteractable
    // Params 1
    // Checksum 0xe4f384fb, Offset: 0x1758
    // Size: 0x174
    function carry( e_triggerer )
    {
        e_triggerer endon( #"death" );
        e_triggerer endon( #"player_downed" );
        e_triggerer.o_pickupitem = self;
        self.m_e_player_currently_holding = e_triggerer;
        self.m_e_body_trigger notify( #"upgrade_trigger_enable", 0 );
        self notify( #"cancel_despawn" );
        e_triggerer disableweapons();
        wait 0.5;
        
        if ( isdefined( self.a_carry_threads ) )
        {
            foreach ( carry_thread in self.a_carry_threads )
            {
                self thread [[ carry_thread ]]( e_triggerer );
            }
        }
        else
        {
            e_triggerer allowjump( 0 );
        }
        
        self thread show_drop_prompt( e_triggerer );
        self thread show_carry_model( e_triggerer );
        self thread thread_allow_drop( e_triggerer );
    }

    // Namespace cbaseinteractable
    // Params 0
    // Checksum 0xbd8cc8f3, Offset: 0x1570
    // Size: 0x1da
    function thread_allow_carry()
    {
        self notify( #"thread_allow_carry" );
        self endon( #"thread_allow_carry" );
        self endon( #"unmake" );
        
        while ( true )
        {
            wait 0.05;
            
            if ( !isdefined( self.m_e_body_trigger ) )
            {
                return;
            }
            
            self.m_e_body_trigger waittill( #"trigger", e_triggerer );
            
            if ( isdefined( e_triggerer.is_carrying_pickupitem ) && e_triggerer.is_carrying_pickupitem )
            {
                self.m_e_body_trigger sethintstringforplayer( e_triggerer, "" );
                continue;
            }
            
            if ( !self.m_iscarryable )
            {
                continue;
            }
            
            if ( isdefined( e_triggerer.disable_object_pickup ) && e_triggerer.disable_object_pickup )
            {
                continue;
            }
            
            if ( !e_triggerer util::use_button_held() )
            {
                continue;
            }
            
            if ( isdefined( self.m_allow_carry_custom_conditions_func ) && ![[ self.m_allow_carry_custom_conditions_func ]]() )
            {
                continue;
            }
            
            if ( !isdefined( self.m_e_body_trigger ) )
            {
                return;
            }
            
            if ( !e_triggerer istouching( self.m_e_body_trigger ) )
            {
                continue;
            }
            
            if ( isdefined( e_triggerer.is_carrying_pickupitem ) && e_triggerer.is_carrying_pickupitem )
            {
                continue;
            }
            
            if ( e_triggerer laststand::player_is_in_laststand() )
            {
                continue;
            }
            
            e_triggerer.is_carrying_pickupitem = 1;
            self thread carry( e_triggerer );
            return;
        }
    }

    // Namespace cbaseinteractable
    // Params 0
    // Checksum 0xbae3018c, Offset: 0x1548
    // Size: 0x1e
    function disable_carry()
    {
        self.m_iscarryable = 0;
        self notify( #"thread_allow_carry" );
    }

    // Namespace cbaseinteractable
    // Params 0
    // Checksum 0x35dfcf4f, Offset: 0x1518
    // Size: 0x24
    function enable_carry()
    {
        self.m_iscarryable = 1;
        self thread thread_allow_carry();
    }

    // Namespace cbaseinteractable
    // Params 1
    // Checksum 0xe5f1bd89, Offset: 0x14d8
    // Size: 0x38
    function set_body_trigger( e_trigger )
    {
        assert( !isdefined( self.m_e_body_trigger ) );
        self.m_e_body_trigger = e_trigger;
    }

    // Namespace cbaseinteractable
    // Params 0
    // Checksum 0xebaebeff, Offset: 0x1418
    // Size: 0xb8
    function repair_trigger()
    {
        self endon( #"unmake" );
        
        while ( true )
        {
            self.m_e_body_trigger waittill( #"trigger", player );
            
            if ( isdefined( player.is_carrying_pickupitem ) && player.is_carrying_pickupitem && player.o_pickupitem.m_str_itemname == "Toolbox" )
            {
                [[ player.o_pickupitem ]]->remove( player );
                [[ self.m_repair_complete_func ]]( player );
            }
            
            wait 0.05;
        }
    }

    // Namespace cbaseinteractable
    // Params 1
    // Checksum 0x602ac1cf, Offset: 0x13d0
    // Size: 0x3c
    function repair_completed( player )
    {
        self notify( #"repair_completed" );
        
        if ( isdefined( self.m_repair_custom_complete_func ) )
        {
            self thread [[ self.m_repair_custom_complete_func ]]( player );
        }
    }

    // Namespace cbaseinteractable
    // Params 0
    // Checksum 0xabdbaa18, Offset: 0x1350
    // Size: 0x74
    function prompt_manager()
    {
        if ( isdefined( self.m_prompt_manager_custom_func ) )
        {
            self thread [[ self.m_prompt_manager_custom_func ]]();
            return;
        }
        
        while ( isdefined( self.m_e_body_trigger ) )
        {
            if ( !self.m_isfunctional )
            {
                self.m_e_body_trigger sethintstring( "Bring Toolbox to repair" );
                wait 0.05;
                continue;
            }
            
            wait 0.05;
        }
    }

    // Namespace cbaseinteractable
    // Params 0
    // Checksum 0x70dd5230, Offset: 0x1338
    // Size: 0xa
    function get_player_currently_holding()
    {
        return self.m_e_player_currently_holding;
    }

}

