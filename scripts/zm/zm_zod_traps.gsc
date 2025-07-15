#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/zm/_bb;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_zod_quest;

#namespace zm_zod_traps;

// Namespace zm_zod_traps
// Method(s) 23 Total 23
class ctrap
{

    // Namespace ctrap
    // Params 1
    // Checksum 0x98782565, Offset: 0x1d58
    // Size: 0x50e
    function function_7e393675( n_time )
    {
        switch ( self.m_n_state )
        {
            case 1:
                foreach ( e_heart in self.m_a_e_heart )
                {
                    e_heart thread scene::play( "p7_fxanim_zm_zod_chain_trap_heart_low_bundle", e_heart );
                }
                
                break;
            case 2:
                foreach ( e_heart in self.m_a_e_heart )
                {
                    e_heart scene::stop( "p7_fxanim_zm_zod_chain_trap_heart_low_bundle" );
                }
                
                for ( i = 0; i < self.m_a_e_heart.size ; i++ )
                {
                    e_heart = self.m_a_e_heart[ i ];
                    
                    if ( i + 1 == self.m_a_e_heart.size )
                    {
                        e_heart scene::play( "p7_fxanim_zm_zod_chain_trap_heart_pull_bundle", e_heart );
                        continue;
                    }
                    
                    e_heart thread scene::play( "p7_fxanim_zm_zod_chain_trap_heart_pull_bundle", e_heart );
                }
                
                n_wait = n_time / 3;
                
                foreach ( e_heart in self.m_a_e_heart )
                {
                    e_heart thread scene::play( "p7_fxanim_zm_zod_chain_trap_heart_low_bundle", e_heart );
                }
                
                wait n_wait;
                
                foreach ( e_heart in self.m_a_e_heart )
                {
                    e_heart scene::stop( "p7_fxanim_zm_zod_chain_trap_heart_low_bundle" );
                    e_heart thread scene::play( "p7_fxanim_zm_zod_chain_trap_heart_med_bundle", e_heart );
                }
                
                wait n_wait;
                
                foreach ( e_heart in self.m_a_e_heart )
                {
                    e_heart scene::stop( "p7_fxanim_zm_zod_chain_trap_heart_med_bundle" );
                    e_heart thread scene::play( "p7_fxanim_zm_zod_chain_trap_heart_fast_bundle", e_heart );
                }
                
                wait n_wait;
                
                foreach ( e_heart in self.m_a_e_heart )
                {
                    e_heart scene::stop( "p7_fxanim_zm_zod_chain_trap_heart_fast_bundle" );
                }
                
                foreach ( e_heart in self.m_a_e_heart )
                {
                    e_heart thread scene::play( "p7_fxanim_zm_zod_chain_trap_heart_low_bundle", e_heart );
                }
                
                break;
            case 3:
                break;
            case 0:
                break;
        }
    }

    // Namespace ctrap
    // Params 2
    // Checksum 0x2fbb851f, Offset: 0x1cd0
    // Size: 0x7c
    function hint_string( string, cost )
    {
        if ( isdefined( cost ) )
        {
            self sethintstring( string, cost );
        }
        else
        {
            self sethintstring( string );
        }
        
        self setcursorhint( "HINT_NOICON" );
    }

    // Namespace ctrap
    // Params 0
    // Checksum 0xd20afd6, Offset: 0x1c90
    // Size: 0x34
    function update_chain_animation()
    {
        self.m_a_e_heart[ 0 ] clientfield::set( "trap_chain_state", self.m_n_state );
    }

    // Namespace ctrap
    // Params 1
    // Checksum 0x1c926487, Offset: 0x1ba0
    // Size: 0xe4
    function trap_death_nonplayer( ent )
    {
        if ( !isvehicle( ent ) && ent.team != "allies" )
        {
            ent.a.gib_ref = array::random( array( "guts", "right_arm", "left_arm", "head" ) );
            ent thread zombie_death::do_gib();
            
            if ( isplayer( self.m_e_who ) )
            {
                self.m_e_who zm_stats::increment_challenge_stat( "ZOMBIE_HUNTER_KILL_TRAP" );
            }
        }
    }

    // Namespace ctrap
    // Params 1
    // Checksum 0xa86c9c3b, Offset: 0x19c0
    // Size: 0x1d2
    function trap_damage_nonplayer( ent )
    {
        ent endon( #"death" );
        
        if ( isdefined( ent.trap_damage_cooldown ) )
        {
            return;
        }
        
        ent.trap_damage_cooldown = 1;
        
        if ( isdefined( ent.maxhealth ) && self.m_n_zombie_damage >= ent.maxhealth && !isvehicle( ent ) )
        {
            trap_death_nonplayer( ent );
            ent dodamage( ent.maxhealth * 0.5, ent.origin, self.m_t_damage, self.m_t_damage, "MOD_GRENADE" );
            wait self.m_n_duration_zombie_damage_cooldown;
            trap_death_nonplayer( ent );
            ent dodamage( ent.maxhealth, ent.origin, self.m_t_damage, self.m_t_damage, "MOD_GRENADE" );
            ent.trap_damage_cooldown = undefined;
            return;
        }
        
        trap_death_nonplayer( ent );
        ent dodamage( self.m_n_zombie_damage, ent.origin, self.m_t_damage, self.m_t_damage, "MOD_GRENADE" );
        wait self.m_n_duration_zombie_damage_cooldown;
        ent.trap_damage_cooldown = undefined;
    }

    // Namespace ctrap
    // Params 1
    // Checksum 0x3c64bfa, Offset: 0x1880
    // Size: 0x132
    function trap_damage_player( ent )
    {
        ent endon( #"death" );
        ent endon( #"disconnect" );
        
        if ( ent laststand::player_is_in_laststand() )
        {
            return;
        }
        
        if ( isdefined( ent.trap_damage_cooldown ) )
        {
            return;
        }
        
        ent.trap_damage_cooldown = 1;
        
        if ( !ent hasperk( "specialty_armorvest" ) || ent.health - 100 < 1 )
        {
            ent dodamage( self.m_n_player_damage, ent.origin );
            ent.trap_damage_cooldown = undefined;
            return;
        }
        
        ent dodamage( self.m_n_player_damage / 2, ent.origin );
        wait self.m_n_duration_player_damage_cooldown;
        ent.trap_damage_cooldown = undefined;
    }

    // Namespace ctrap
    // Params 0
    // Checksum 0x10350fc0, Offset: 0x1710
    // Size: 0x168
    function trap_damage()
    {
        self endon( #"trap_done" );
        self.m_t_damage._trap_type = "chain";
        
        while ( true )
        {
            self.m_t_damage waittill( #"trigger", ent );
            self.m_t_damage.activated_by_player = self.m_e_who;
            
            if ( isplayer( ent ) )
            {
                if ( ent getstance() == "prone" || ent isonslide() )
                {
                    continue;
                }
                
                thread trap_damage_player( ent );
                continue;
            }
            
            if ( isdefined( ent.marked_for_death ) )
            {
                continue;
            }
            
            if ( isdefined( ent.missinglegs ) && ent.missinglegs )
            {
                continue;
            }
            
            if ( isdefined( ent.var_de36fc8 ) )
            {
                ent [[ ent.var_de36fc8 ]]( self );
                continue;
            }
            
            thread trap_damage_nonplayer( ent );
        }
    }

    // Namespace ctrap
    // Params 0
    // Checksum 0x9f6a23c4, Offset: 0x16d0
    // Size: 0x34
    function trap_unavailable()
    {
        self.m_t_damage setinvisibletoall();
        self.m_t_damage triggerenable( 0 );
    }

    // Namespace ctrap
    // Params 0
    // Checksum 0xce326d45, Offset: 0x1690
    // Size: 0x34
    function trap_cooldown()
    {
        self.m_t_damage setinvisibletoall();
        self.m_t_damage triggerenable( 0 );
    }

    // Namespace ctrap
    // Params 0
    // Checksum 0x46d92123, Offset: 0x1618
    // Size: 0x6c
    function trap_active()
    {
        println( "<dev string:x28>" );
        self.m_t_damage setvisibletoall();
        self.m_t_damage triggerenable( 1 );
        thread trap_damage();
    }

    // Namespace ctrap
    // Params 0
    // Checksum 0x944afdaa, Offset: 0x15d8
    // Size: 0x34
    function trap_available()
    {
        self.m_t_damage setinvisibletoall();
        self.m_t_damage triggerenable( 0 );
    }

    // Namespace ctrap
    // Params 0
    // Checksum 0x17a3aa36, Offset: 0x1520
    // Size: 0xae
    function trap_update_state()
    {
        switch ( self.m_n_state )
        {
            case 1:
                trap_available();
                break;
            case 2:
                trap_active();
                self notify( #"trap_start" );
                break;
            case 3:
                trap_cooldown();
                self notify( #"trap_done" );
                break;
            case 0:
                trap_unavailable();
                self notify( #"trap_done" );
                break;
        }
    }

    // Namespace ctrap
    // Params 1
    // Checksum 0x3fe25a4e, Offset: 0x14e0
    // Size: 0x34
    function switch_unavailable( t_use )
    {
        if ( self.var_54d81d07 != 1 )
        {
        }
        
        self thread update_chain_animation();
    }

    // Namespace ctrap
    // Params 1
    // Checksum 0xfabc8336, Offset: 0x13d8
    // Size: 0xfc
    function switch_cooldown( t_use )
    {
        function_7e393675( undefined );
        
        if ( self.var_54d81d07 != 1 )
        {
        }
        
        foreach ( e_heart in self.m_a_e_heart )
        {
            e_heart moveto( e_heart.origin - ( 0, 0, -32 ), 0.25 );
        }
        
        wait 0.25;
        self thread update_chain_animation();
    }

    // Namespace ctrap
    // Params 1
    // Checksum 0x3eaf304f, Offset: 0x1320
    // Size: 0xac
    function switch_active( t_use )
    {
        if ( !self.m_b_discovered )
        {
            level thread zm_audio::sndmusicsystem_playstate( "trap" );
            self.m_b_discovered = 1;
        }
        
        var_74a8cf96 = 30;
        self thread function_7e393675( var_74a8cf96 );
        wait 0.25;
        self.m_t_damage playsound( "zmb_trap_activate" );
        self thread update_chain_animation();
    }

    // Namespace ctrap
    // Params 1
    // Checksum 0x8bcd29b7, Offset: 0x12c8
    // Size: 0x4c
    function switch_available( t_use )
    {
        function_7e393675( undefined );
        
        if ( self.var_54d81d07 != 1 )
        {
        }
        
        self thread update_chain_animation();
    }

    // Namespace ctrap
    // Params 1
    // Checksum 0xeff06ca4, Offset: 0x1220
    // Size: 0x9e
    function switch_update_state( t_use )
    {
        switch ( self.m_n_state )
        {
            case 1:
                switch_available( t_use );
                break;
            case 2:
                switch_active( t_use );
                break;
            case 3:
                switch_cooldown( t_use );
                break;
            case 0:
                switch_unavailable( t_use );
                break;
        }
    }

    // Namespace ctrap
    // Params 0
    // Checksum 0x5f2465e1, Offset: 0x10f8
    // Size: 0x11e
    function strings_update_state()
    {
        switch ( self.m_n_state )
        {
            case 1:
                array::thread_all( self.m_a_t_use, &hint_string, self.m_str_trap_available, self.m_n_cost );
                break;
            case 2:
                array::thread_all( self.m_a_t_use, &hint_string, self.m_str_trap_active );
                break;
            case 3:
                array::thread_all( self.m_a_t_use, &hint_string, self.m_str_trap_cooldown );
                break;
            case 0:
                array::thread_all( self.m_a_t_use, &hint_string, self.m_str_trap_unavailable );
                break;
        }
    }

    // Namespace ctrap
    // Params 1
    // Checksum 0xb6d7f878, Offset: 0xe98
    // Size: 0x258
    function use_trig_think( o_trap )
    {
        while ( true )
        {
            self waittill( #"trigger", who );
            
            if ( who zm_utility::in_revive_trigger() )
            {
                continue;
            }
            
            if ( who.is_drinking > 0 )
            {
                continue;
            }
            
            if ( !zm_utility::is_player_valid( who ) )
            {
                continue;
            }
            
            if ( !who zm_score::can_player_purchase( o_trap.m_n_cost ) )
            {
                continue;
            }
            
            if ( o_trap.m_n_state != 1 )
            {
                continue;
            }
            
            o_trap.m_n_state = 2;
            o_trap.m_e_who = who;
            bb::logpurchaseevent( who, self, o_trap.m_n_cost, self.targetname, 0, "_trap", "_purchased" );
            who zm_score::minus_to_player_score( o_trap.m_n_cost );
            [[ o_trap ]]->strings_update_state();
            [[ o_trap ]]->switch_update_state( self );
            [[ o_trap ]]->trap_update_state();
            who thread zm_audio::create_and_play_dialog( "trap", "start" );
            wait o_trap.m_n_duration_active;
            o_trap.m_n_state = 3;
            [[ o_trap ]]->trap_update_state();
            [[ o_trap ]]->switch_update_state( self );
            [[ o_trap ]]->strings_update_state();
            wait o_trap.m_n_duration_cooldown;
            o_trap.m_n_state = 1;
            [[ o_trap ]]->strings_update_state();
            [[ o_trap ]]->switch_update_state( self );
            [[ o_trap ]]->trap_update_state();
        }
    }

    // Namespace ctrap
    // Params 2
    // Checksum 0x7e4fb803, Offset: 0xe58
    // Size: 0x34, Type: bool
    function filter_areaname( e_entity, str_area_name )
    {
        if ( e_entity.prefabname !== str_area_name )
        {
            return false;
        }
        
        return true;
    }

    // Namespace ctrap
    // Params 1
    // Checksum 0x8e2e5e79, Offset: 0x9b0
    // Size: 0x49c
    function init_trap( str_area_name )
    {
        self.m_n_state = 1;
        self.m_b_discovered = 0;
        self.var_54d81d07 = 0;
        self.m_n_cost = 1000;
        self.m_n_duration_active = 25;
        self.m_n_duration_cooldown = 25;
        self.m_n_duration_player_damage_cooldown = 1;
        self.m_n_duration_zombie_damage_cooldown = 0.25;
        self.m_n_player_damage = 25;
        self.m_n_zombie_damage = 6500;
        self.m_str_trap_unavailable = &"ZM_ZOD_TRAP_CHAIN_UNAVAILABLE";
        self.m_str_trap_available = &"ZM_ZOD_TRAP_CHAIN_AVAILABLE";
        self.m_str_trap_active = &"ZM_ZOD_TRAP_CHAIN_ACTIVE";
        self.m_str_trap_cooldown = &"ZM_ZOD_TRAP_CHAIN_COOLDOWN";
        m_a_t_damage = getentarray( "trap_chain_damage", "targetname" );
        m_a_t_damage = array::filter( m_a_t_damage, 0, &filter_areaname, str_area_name );
        m_a_t_rumble = getentarray( "trap_chain_rumble", "targetname" );
        m_a_t_rumble = array::filter( m_a_t_damage, 0, &filter_areaname, str_area_name );
        self.m_a_e_heart = getentarray( "trap_chain_heart", "targetname" );
        self.m_a_e_heart = array::filter( self.m_a_e_heart, 0, &filter_areaname, str_area_name );
        self.m_a_t_use = getentarray( "use_trap_chain", "targetname" );
        self.m_a_t_use = array::filter( self.m_a_t_use, 0, &filter_areaname, str_area_name );
        strings_update_state();
        array::thread_all( self.m_a_t_use, &use_trig_think, self );
        var_d186b130 = [];
        var_d186b130[ 0 ] = "theater";
        var_d186b130[ 1 ] = "slums";
        var_d186b130[ 2 ] = "canals";
        var_d186b130[ 3 ] = "pap";
        
        foreach ( heart in self.m_a_e_heart )
        {
            for ( i = 0; i < var_d186b130.size ; i++ )
            {
                if ( var_d186b130[ i ] == heart.prefabname )
                {
                    heart clientfield::set( "trap_chain_location", i );
                }
            }
        }
        
        self.m_t_damage = m_a_t_damage[ 0 ];
        self.m_t_rumble = m_a_t_rumble[ 0 ];
        a_audio_structs = struct::get_array( "trap_chain_audio_loc", "targetname" );
        a_audio_structs = array::filter( a_audio_structs, 0, &filter_areaname, str_area_name );
        self.m_s_audio_location = a_audio_structs[ 0 ];
        self.m_s_audio_location = spawn( "script_origin", self.m_s_audio_location.origin );
        self.m_b_are_strikers_moving = 0;
        self thread update_chain_animation();
    }

}

// Namespace zm_zod_traps
// Params 0, eflags: 0x2
// Checksum 0xb414e397, Offset: 0x528
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_zod_traps", &__init__, undefined, undefined );
}

// Namespace zm_zod_traps
// Params 0
// Checksum 0x1b9ab328, Offset: 0x568
// Size: 0x64
function __init__()
{
    clientfield::register( "scriptmover", "trap_chain_state", 1, 2, "int" );
    clientfield::register( "scriptmover", "trap_chain_location", 1, 2, "int" );
}

// Namespace zm_zod_traps
// Params 0
// Checksum 0x87fff9bd, Offset: 0x5d8
// Size: 0xac
function init_traps()
{
    if ( !isdefined( level.a_o_trap_chain ) )
    {
        level.a_o_trap_chain = [];
        init_trap( "theater" );
        init_trap( "slums" );
        init_trap( "canals" );
        init_trap( "pap" );
    }
    
    flag::wait_till( "all_players_spawned" );
    function_89303c72( undefined );
}

// Namespace zm_zod_traps
// Params 1
// Checksum 0x69ac3fef, Offset: 0x690
// Size: 0x5c
function init_trap( str_area_name )
{
    if ( !isdefined( level.a_o_trap_chain[ str_area_name ] ) )
    {
        level.a_o_trap_chain[ str_area_name ] = new ctrap();
        [[ level.a_o_trap_chain[ str_area_name ] ]]->init_trap( str_area_name );
    }
}

// Namespace zm_zod_traps
// Params 1
// Checksum 0xa031d45b, Offset: 0x6f8
// Size: 0x1e4
function function_89303c72( var_f6caa7fd )
{
    var_cdd779bd = getarraykeys( level.a_o_trap_chain );
    
    foreach ( str_index in var_cdd779bd )
    {
        if ( str_index != "pap" )
        {
            level.a_o_trap_chain[ str_index ].m_n_state = 1;
            [[ level.a_o_trap_chain[ str_index ] ]]->trap_update_state();
            [[ level.a_o_trap_chain[ str_index ] ]]->switch_update_state( level.a_o_trap_chain[ str_index ].m_a_e_heart[ 0 ] );
            [[ level.a_o_trap_chain[ str_index ] ]]->strings_update_state();
        }
    }
    
    level.a_o_trap_chain[ "pap" ].m_n_state = 0;
    [[ level.a_o_trap_chain[ "pap" ] ]]->trap_update_state();
    [[ level.a_o_trap_chain[ "pap" ] ]]->switch_update_state( level.a_o_trap_chain[ "pap" ].m_a_e_heart[ 0 ] );
    [[ level.a_o_trap_chain[ "pap" ] ]]->strings_update_state();
    level thread function_8144bbbe();
}

// Namespace zm_zod_traps
// Params 0
// Checksum 0x887fccef, Offset: 0x8e8
// Size: 0xc0
function function_8144bbbe()
{
    level flag::wait_till( "pap_door_open" );
    level.a_o_trap_chain[ "pap" ].m_n_state = 1;
    [[ level.a_o_trap_chain[ "pap" ] ]]->trap_update_state();
    [[ level.a_o_trap_chain[ "pap" ] ]]->switch_update_state( level.a_o_trap_chain[ "pap" ].m_a_e_heart[ 0 ] );
    [[ level.a_o_trap_chain[ "pap" ] ]]->strings_update_state();
}

