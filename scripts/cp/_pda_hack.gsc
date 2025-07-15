#using scripts/cp/_util;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace _pda_hack;

// Namespace _pda_hack
// Method(s) 14 Total 14
class chackableobject
{

    // Namespace chackableobject
    // Params 0
    // Checksum 0xefc64391, Offset: 0x1d0
    // Size: 0x80
    constructor()
    {
        self.m_is_functional = 1;
        self.m_is_hackable = 0;
        self.m_is_trigger_thread_active = 0;
        self.m_n_hack_duration = 2;
        self.m_n_hack_radius = 72;
        self.m_n_hack_height = 128;
        self.m_hack_complete_func = &hacking_completed;
        self.m_does_hack_time_scale = 0;
        self.m_str_team = "axis";
    }

    // Namespace chackableobject
    // Params 0
    // Checksum 0xf9b0c4b0, Offset: 0x258
    // Size: 0x14
    destructor()
    {
        clean_up();
    }

    // Namespace chackableobject
    // Params 0
    // Checksum 0xa83bf92c, Offset: 0xf58
    // Size: 0x2c
    function clean_up()
    {
        if ( isdefined( self.m_e_hack_trigger ) )
        {
            self.m_e_hack_trigger delete();
        }
    }

    // Namespace chackableobject
    // Params 4
    // Checksum 0x6f1c2cfe, Offset: 0xde8
    // Size: 0x168
    function spawn_hackable_trigger( v_origin, n_radius, n_height, str_hint )
    {
        assert( isdefined( v_origin ), "<dev string:xb4>" );
        assert( isdefined( n_radius ), "<dev string:xe2>" );
        assert( isdefined( n_height ), "<dev string:x110>" );
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

    // Namespace chackableobject
    // Params 1
    // Checksum 0x6ab3a10c, Offset: 0xda0
    // Size: 0x3c
    function do_bar_update( n_hack_duration )
    {
        self endon( #"kill_bar" );
        self hud::updatebar( 0.01, 1 / n_hack_duration );
    }

    // Namespace chackableobject
    // Params 0
    // Checksum 0xe9339f6b, Offset: 0xd38
    // Size: 0x5c
    function temp_player_lock_in_place_remove()
    {
        if ( isdefined( self ) && isdefined( self.circuit_breaker_lock_ent ) )
        {
            self unlink();
            self.circuit_breaker_lock_ent delete();
            self enableweapons();
        }
    }

    // Namespace chackableobject
    // Params 1
    // Checksum 0x521e01b5, Offset: 0xbb8
    // Size: 0x174
    function temp_player_lock_in_place( trigger )
    {
        v_lock_position = trigger.origin + vectornormalize( anglestoforward( trigger.angles ) ) * 50;
        v_lock_position_ground = bullettrace( v_lock_position, v_lock_position - ( 0, 0, 100 ), 0, undefined )[ "position" ];
        v_lock_angles = ( 0, vectortoangles( vectorscale( anglestoforward( trigger.angles ), -1 ) )[ 1 ], 0 );
        self.circuit_breaker_lock_ent = spawn( "script_origin", v_lock_position_ground );
        self.circuit_breaker_lock_ent.angles = v_lock_angles;
        self playerlinkto( self.circuit_breaker_lock_ent, undefined, 0, 0, 0, 0, 0 );
        self disableweapons();
    }

    // Namespace chackableobject
    // Params 0
    // Checksum 0xd41b1db0, Offset: 0x658
    // Size: 0x558
    function thread_hacking_progress()
    {
        self endon( #"hacking_completed" );
        self endon( #"hacking_disabled" );
        self.m_e_hack_trigger endon( #"death" );
        self.m_is_trigger_thread_active = 1;
        self.m_e_hack_trigger sethintstring( "" );
        self.m_e_hack_trigger sethintlowpriority( 1 );
        
        while ( true )
        {
            self.m_e_hack_trigger waittill( #"trigger", e_triggerer );
            
            if ( !self.m_is_functional )
            {
                continue;
            }
            
            if ( !e_triggerer util::is_player_looking_at( self.m_e_hack_trigger.origin, 0.75, 0 ) )
            {
                self.m_e_hack_trigger sethintstring( "" );
                self.m_e_hack_trigger sethintlowpriority( 1 );
                continue;
            }
            
            self.m_e_hack_trigger sethintstring( self.m_str_hackable_hint );
            self.m_e_hack_trigger sethintlowpriority( 1 );
            
            if ( !e_triggerer usebuttonpressed() )
            {
                continue;
            }
            
            foreach ( player in level.players )
            {
                if ( player != e_triggerer )
                {
                    self.m_e_hack_trigger sethintstringforplayer( player, "" );
                }
            }
            
            level.primaryprogressbarx = 0;
            level.primaryprogressbary = 110;
            level.primaryprogressbarheight = 8;
            level.primaryprogressbarwidth = 120;
            level.primaryprogressbary_ss = 280;
            e_triggerer temp_player_lock_in_place( self.m_e_hack_trigger );
            wait 0.8;
            n_start_time = 0;
            n_hack_time = self.m_n_hack_duration;
            
            if ( self.m_does_hack_time_scale )
            {
                if ( isdefined( level.n_hack_time_multiplier ) )
                {
                    n_hack_time *= level.n_hack_time_multiplier;
                }
            }
            
            n_hack_range_sq = self.m_n_hack_radius * self.m_n_hack_radius;
            n_user_dist_sq = distance2dsquared( e_triggerer.origin, self.m_e_hack_trigger.origin );
            
            if ( n_user_dist_sq > n_hack_range_sq )
            {
                n_hack_range_sq = n_user_dist_sq;
            }
            
            b_looking = 1;
            
            while ( n_start_time < n_hack_time && e_triggerer usebuttonpressed() && n_user_dist_sq <= n_hack_range_sq && b_looking )
            {
                n_start_time += 0.05;
                
                if ( !isdefined( self.m_progress_bar ) )
                {
                    self.m_progress_bar = e_triggerer hud::createprimaryprogressbar();
                    self.m_progress_bar thread do_bar_update( n_hack_time );
                }
                
                wait 0.05;
                n_user_dist_sq = distance2dsquared( e_triggerer.origin, self.m_e_hack_trigger.origin );
                b_lookig = e_triggerer util::is_player_looking_at( self.m_e_hack_trigger.origin, 0.75, 0 );
            }
            
            if ( isdefined( self.m_progress_bar ) )
            {
                self.m_progress_bar notify( #"kill_bar" );
                self.m_progress_bar hud::destroyelem();
            }
            
            e_triggerer temp_player_lock_in_place_remove();
            
            if ( n_start_time >= n_hack_time )
            {
                if ( self.m_does_hack_time_scale )
                {
                    if ( !isdefined( level.n_hack_time_multiplier ) )
                    {
                        level.n_hack_time_multiplier = 1;
                    }
                    
                    level.n_hack_time_multiplier += 0.2;
                }
                
                self thread [[ self.m_hack_complete_func ]]( e_triggerer );
            }
            
            while ( e_triggerer usebuttonpressed() )
            {
                wait 0.1;
            }
        }
    }

    // Namespace chackableobject
    // Params 0
    // Checksum 0x7a93950c, Offset: 0x640
    // Size: 0x10
    function wait_till_hacking_completed()
    {
        self waittill( #"hacking_completed" );
    }

    // Namespace chackableobject
    // Params 1
    // Checksum 0x3c8995ca, Offset: 0x580
    // Size: 0xb8
    function hacking_completed( e_triggerer )
    {
        self notify( #"hacking_completed" );
        self.m_str_team = "allies";
        self.m_e_hack_trigger sethintstring( "" );
        self.m_e_hack_trigger sethintlowpriority( 1 );
        
        if ( isdefined( self.m_e_reference ) )
        {
            e_reference = self.m_e_reference;
        }
        else
        {
            e_reference = self;
        }
        
        if ( isdefined( self.m_hack_custom_complete_func ) )
        {
            e_reference [[ self.m_hack_custom_complete_func ]]();
        }
    }

    // Namespace chackableobject
    // Params 0
    // Checksum 0xe5fd5d41, Offset: 0x510
    // Size: 0x68
    function disable_hacking()
    {
        if ( self.m_is_hackable )
        {
            self notify( #"hacking_disabled" );
            self.m_e_hack_trigger sethintstring( "" );
            self.m_e_hack_trigger sethintlowpriority( 1 );
            self.m_is_trigger_thread_active = 0;
        }
    }

    // Namespace chackableobject
    // Params 0
    // Checksum 0x198d3c44, Offset: 0x438
    // Size: 0xcc
    function enable_hacking()
    {
        if ( self.m_is_hackable )
        {
            if ( self.m_str_team != "allies" )
            {
                self.m_e_hack_trigger sethintstring( self.m_str_hackable_hint );
                self.m_e_hack_trigger sethintlowpriority( 1 );
                
                if ( !self.m_is_trigger_thread_active )
                {
                    self thread thread_hacking_progress();
                }
                
                return;
            }
            
            self.m_e_hack_trigger sethintstring( "" );
            self.m_e_hack_trigger sethintlowpriority( 1 );
        }
    }

    // Namespace chackableobject
    // Params 1
    // Checksum 0x4dd10459, Offset: 0x418
    // Size: 0x18
    function set_custom_hack_time( n_time )
    {
        self.m_n_hack_duration = n_time;
    }

    // Namespace chackableobject
    // Params 5
    // Checksum 0xdf0f4703, Offset: 0x278
    // Size: 0x194
    function setup_hackable_object( v_origin, str_hint_string, v_angles, func_on_completion, e_reference )
    {
        assert( isdefined( v_origin ), "<dev string:x28>" );
        
        if ( !isdefined( v_angles ) )
        {
            v_angles = ( 0, 0, 0 );
        }
        
        self.m_str_hackable_hint = str_hint_string;
        self.m_hack_custom_complete_func = func_on_completion;
        self.m_e_reference = e_reference;
        self.m_e_hack_trigger = spawn_hackable_trigger( v_origin, self.m_n_hack_radius, self.m_n_hack_height, self.m_str_hackable_hint );
        self.m_e_hack_trigger.angles = v_angles;
        self.m_e_origin = spawn( "script_model", v_origin );
        self.m_e_origin setmodel( "" );
        self.m_e_origin notsolid();
        assert( !self.m_is_hackable, "<dev string:x63>" );
        self.m_is_hackable = 1;
        enable_hacking();
        self thread thread_hacking_progress();
    }

}

// Namespace _pda_hack
// Params 0, eflags: 0x2
// Checksum 0x2df759d0, Offset: 0x180
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "pda_hack", &__init__, undefined, undefined );
}

// Namespace _pda_hack
// Params 0
// Checksum 0x99ec1590, Offset: 0x1c0
// Size: 0x4
function __init__()
{
    
}

