#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_equip_hacker;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/zm_moon_sq;

#namespace zm_moon_sq_osc;

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0xa6fb10fe, Offset: 0x588
// Size: 0x55c
function init()
{
    level._osc_rb_jolie_spots = [];
    level._osc_rbs = struct::get_array( "struct_osc_button", "targetname" );
    
    if ( !isdefined( level._osc_rbs ) )
    {
        println( "<dev string:x28>" );
        wait 1;
        return;
    }
    
    level._osc_struct = struct::get( "struct_sq_osc", "targetname" );
    
    if ( !isdefined( level._osc_struct ) )
    {
        println( "<dev string:x4d>" );
        wait 1;
        return;
    }
    
    level._osc_flags = strtok( level._osc_struct.script_flag, "," );
    
    if ( !isdefined( level._osc_flags ) )
    {
        println( "<dev string:x75>" );
        wait 1;
        return;
    }
    
    for ( j = 0; j < level._osc_flags.size ; j++ )
    {
        if ( !isdefined( level.flag[ level._osc_flags[ j ] ] ) )
        {
            level flag::init( level._osc_flags[ j ] );
        }
    }
    
    level._jolie_greet_array = array( level._osc_flags[ 4 ], level._osc_flags[ 5 ], level._osc_flags[ 6 ], level._osc_flags[ 7 ] );
    level._osc_st = struct::get_array( "struct_osc_st", "targetname" );
    
    for ( k = 0; k < level._osc_st.size ; k++ )
    {
        level._osc_st[ k ].focus = spawnstruct();
        level._osc_st[ k ].focus.origin = level._osc_st[ k ].origin;
        level._osc_st[ k ].focus.radius = 48;
        level._osc_st[ k ].focus.height = 48;
        level._osc_st[ k ].focus.script_float = 5;
        level._osc_st[ k ].focus.script_int = 0;
        level._osc_st[ k ].focus._light_spot = struct::get( level._osc_st[ k ].target, "targetname" );
    }
    
    level thread function_f65c74fe();
    level._osc_min_dist = level._osc_struct.script_wait_min;
    level._osc_max_dist = level._osc_struct.script_wait_max;
    level._osc_rbs_dist_range = level._osc_max_dist - level._osc_min_dist;
    level._osc_release = 0;
    level._osc_check = undefined;
    
    if ( getdvarint( "jolie_greet_debug" ) )
    {
        level._osc_trial_time = getdvarint( "jolie_greet_time" );
    }
    else
    {
        if ( !isdefined( level._osc_struct.script_int ) )
        {
            println( "<dev string:x98>" );
            wait 1;
            return;
        }
        
        level._osc_trial_time = level._osc_struct.script_int;
    }
    
    level._osc_cap_spot = struct::get( "struct_cover", "targetname" );
    level._osc_cap = util::spawn_model( "p7_zm_moo_glyph_dial_cap", level._osc_cap_spot.origin, level._osc_cap_spot.angles );
    level._osc_terms = 0;
    level thread osc_button_cover_setup();
    zm_sidequests::declare_sidequest_stage( "sq", "osc", &init_stage, &stage_logic, &exit_stage );
}

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0x1eff8fc6, Offset: 0xaf0
// Size: 0xaa
function function_f65c74fe()
{
    level flag::wait_till( "start_zombie_round_logic" );
    
    foreach ( var_c597f9d8 in level._osc_st )
    {
        var_c597f9d8 function_27fd2e20( 0 );
    }
}

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0x85e5ae95, Offset: 0xba8
// Size: 0x3e8
function osc_button_cover_setup()
{
    level flagsys::wait_till( "load_main_complete" );
    level flag::wait_till( "start_zombie_round_logic" );
    
    for ( i = 0; i < level._osc_rbs.size ; i++ )
    {
        osc_target = struct::get( level._osc_rbs[ i ].target, "targetname" );
        level._osc_rbs[ i ].cover = spawn( "script_model", osc_target.origin );
        level._osc_rbs[ i ].cover.angles = osc_target.angles;
        level._osc_rbs[ i ].cover setmodel( "p7_zm_moo_console_button_lid" );
        level._osc_rbs[ i ].cover_close = level._osc_rbs[ i ].cover.angles;
        level._osc_rbs[ i ].cover rotateroll( -90, 0.05 );
        level._osc_rbs[ i ].cover waittill( #"rotatedone" );
        level._osc_rbs[ i ].cover_open = level._osc_rbs[ i ].cover.angles;
        level._osc_rbs[ i ].cover.angles = level._osc_rbs[ i ].cover_close;
        level._osc_rbs[ i ].jolie = spawnstruct();
        level._osc_rbs[ i ].jolie.origin = level._osc_rbs[ i ].origin;
        level._osc_rbs[ i ].jolie.radius = 48;
        level._osc_rbs[ i ].jolie.height = 48;
        level._osc_rbs[ i ].jolie.script_float = 4;
        level._osc_rbs[ i ].jolie.script_int = 500;
        level._osc_rbs[ i ].jolie.no_sight_check = 1;
        level._osc_rbs[ i ].jolie.no_bullet_trace = 1;
        array::add( level._osc_rb_jolie_spots, level._osc_rbs[ i ].jolie, 0 );
    }
    
    level._osc_rbs_totalrot = level._osc_rbs[ 0 ].cover_close - level._osc_rbs[ 0 ].cover_open;
}

// Namespace zm_moon_sq_osc
// Params 1
// Checksum 0xd09cb99a, Offset: 0xf98
// Size: 0xc
function exit_stage( success )
{
    
}

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0xcf047c4e, Offset: 0xfb0
// Size: 0x34
function stage_logic()
{
    level waittill( #"release_complete" );
    zm_sidequests::stage_completed( "sq", "osc" );
}

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0x18dd0668, Offset: 0xff0
// Size: 0x64
function init_stage()
{
    level thread moon_jolie_greet();
    level thread moon_rb_dist_think();
    level thread moon_open_access();
    level thread moon_keyhole();
}

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0x9a8416bc, Offset: 0x1060
// Size: 0x276
function moon_rb_dist_think()
{
    level endon( #"end_game" );
    level endon( level._osc_flags[ 1 ] );
    level endon( #"stop_dist_think" );
    level._lid_close_sound = 0;
    int_close = 0;
    dist_struct = struct::get( "struct_rb_dist_check", "targetname" );
    
    while ( !level flag::get( level._osc_flags[ 1 ] ) )
    {
        level._osc_check = zm_utility::get_closest_player( dist_struct.origin );
        int_distance = distance2d( level._osc_check.origin, dist_struct.origin );
        
        if ( int_distance > level._osc_max_dist )
        {
            int_distance = level._osc_max_dist;
        }
        else if ( int_distance < level._osc_min_dist )
        {
            int_distance = level._osc_min_dist;
        }
        
        scale = ( int_distance - level._osc_min_dist ) / level._osc_rbs_dist_range;
        rotation_offset = level._osc_rbs_totalrot * scale;
        
        for ( i = 0; i < level._osc_rbs.size ; i++ )
        {
            level._osc_rbs[ i ].cover.angles = level._osc_rbs[ i ].cover_close - rotation_offset;
            
            if ( level._osc_rbs[ i ].cover.angles == level._osc_rbs[ i ].cover_close && level._lid_close_sound == 0 )
            {
                level._lid_close_sound = 1;
                level._osc_rbs[ i ].cover thread rb_cover_sound();
            }
        }
        
        wait 0.05;
        level._osc_check = undefined;
    }
}

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0x13c024c1, Offset: 0x12e0
// Size: 0xdc
function rb_cover_sound()
{
    for ( i = 0; i < level._osc_rbs.size ; i++ )
    {
        level._osc_rbs[ i ].cover playsound( "evt_sq_rbs_close" );
        level._osc_rbs[ i ].cover playsoundwithnotify( "vox_mcomp_quest_step3_0", "sounddone" );
    }
    
    level._osc_rbs[ 0 ].cover waittill( #"sounddone" );
    level thread play_rb_cover_player_vox( self );
    wait 30;
    level._lid_close_sound = 0;
}

// Namespace zm_moon_sq_osc
// Params 1
// Checksum 0xb9dc2eb4, Offset: 0x13c8
// Size: 0x7c
function play_rb_cover_player_vox( ent )
{
    level notify( #"prevent_dupe_rb_cover_vox" );
    level endon( #"prevent_dupe_rb_cover_vox" );
    wait 0.5;
    player = zm_utility::get_closest_player( ent.origin );
    player thread zm_audio::create_and_play_dialog( "eggs", "quest3", 0 );
}

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0x7d75db8d, Offset: 0x1450
// Size: 0x580
function moon_jolie_greet()
{
    if ( !isdefined( level._osc_rb_jolie_spots ) || level._osc_rb_jolie_spots.size == 0 )
    {
        println( "<dev string:xc7>" );
        wait 1;
        return;
    }
    
    while ( !level flag::get( level._osc_flags[ 1 ] ) )
    {
        for ( i = 0; i < level._osc_rb_jolie_spots.size ; i++ )
        {
            zm_equip_hacker::register_pooled_hackable_struct( level._osc_rb_jolie_spots[ i ], &moon_jolie_access );
        }
        
        if ( !isdefined( level._osc_flags[ 2 ] ) || !isdefined( level._osc_flags[ 3 ] ) )
        {
            println( "<dev string:xe5>" );
            wait 1;
            return;
        }
        
        level flag::wait_till_any( array( level._osc_flags[ 2 ], level._osc_flags[ 3 ] ) );
        
        if ( level flag::get( level._osc_flags[ 2 ] ) )
        {
            if ( level flag::get( level._osc_flags[ 2 ] ) )
            {
                level flag::clear( level._osc_flags[ 2 ] );
            }
            else if ( level flag::get( level._osc_flags[ 3 ] ) )
            {
                level flag::clear( level._osc_flags[ 3 ] );
            }
            
            for ( j = 0; j < level._osc_st.size ; j++ )
            {
                zm_equip_hacker::deregister_hackable_struct( level._osc_st[ j ].focus );
                
                if ( isdefined( level._osc_st[ j ].focus._light ) )
                {
                    level._osc_st[ j ].focus._light delete();
                }
                
                if ( isdefined( level._osc_st[ j ].focus.script_flag ) )
                {
                    level flag::clear( level._osc_st[ j ].focus.script_flag );
                    level._osc_st[ j ].focus.script_flag = "";
                }
            }
            
            continue;
        }
        
        if ( level flag::get( level._osc_flags[ 3 ] ) )
        {
            level flag::set( level._osc_flags[ 1 ] );
            level notify( #"stop_dist_think" );
            
            for ( l = 0; l < level._osc_rbs.size ; l++ )
            {
                level._osc_rbs[ l ].cover.angles = level._osc_rbs[ l ].cover_open;
                level._osc_rbs[ l ].cover playsound( "evt_sq_rbs_open" );
            }
            
            for ( m = 0; m < level._osc_st.size ; m++ )
            {
                if ( isdefined( level._osc_st[ m ].focus._light ) )
                {
                    level._osc_st[ m ].focus._light delete();
                }
                
                level._osc_st[ m ].focus.script_flag = "";
                zm_equip_hacker::deregister_hackable_struct( level._osc_st[ m ].focus );
            }
            
            if ( level flag::get( level._osc_flags[ 2 ] ) )
            {
                level flag::clear( level._osc_flags[ 2 ] );
                continue;
            }
            
            if ( level flag::get( level._osc_flags[ 3 ] ) )
            {
                level flag::clear( level._osc_flags[ 3 ] );
            }
        }
    }
}

// Namespace zm_moon_sq_osc
// Params 1
// Checksum 0x4551edc7, Offset: 0x19d8
// Size: 0x2e4
function moon_jolie_access( ent_hacker )
{
    level thread play_moon_jolie_access_vox( ent_hacker );
    level._lid_close_sound = 1;
    
    for ( i = 0; i < level._osc_rb_jolie_spots.size ; i++ )
    {
        zm_equip_hacker::deregister_hackable_struct( level._osc_rb_jolie_spots[ i ] );
    }
    
    level._osc_terms = 0;
    random_array = level._osc_st;
    random_array = array::randomize( random_array );
    
    for ( j = 0; j < 4 ; j++ )
    {
        println( "<dev string:x10d>" );
        random_array[ j ].focus._light = spawn( "script_model", random_array[ j ].focus._light_spot.origin );
        random_array[ j ].focus._light.angles = random_array[ j ].focus._light_spot.angles;
        random_array[ j ].focus._light setmodel( "tag_origin" );
        random_array[ j ] function_27fd2e20( 1 );
        random_array[ j ].focus._light playsound( "evt_sq_rbs_light_on" );
        random_array[ j ].focus._light playloopsound( "evt_sq_rbs_light_loop", 1 );
        zm_equip_hacker::register_pooled_hackable_struct( random_array[ j ].focus, &moon_jolie_work );
    }
    
    level thread moon_good_jolie();
    level thread moon_bad_jolie();
    array::thread_all( random_array, &moon_jolie_timer_vox );
}

// Namespace zm_moon_sq_osc
// Params 1
// Checksum 0x8e4aa3e3, Offset: 0x1cc8
// Size: 0x64
function function_27fd2e20( var_ad826a0f )
{
    str_exploder_name = "struct_sq_osc0" + self.script_int;
    
    if ( var_ad826a0f )
    {
        exploder::exploder( str_exploder_name );
        return;
    }
    
    exploder::kill_exploder( str_exploder_name );
}

// Namespace zm_moon_sq_osc
// Params 1
// Checksum 0x181d0f01, Offset: 0x1d38
// Size: 0xfc
function moon_jolie_work( ent_hacker )
{
    level._osc_terms++;
    self._light_spot function_27fd2e20( 0 );
    
    if ( isdefined( self._light ) )
    {
        self._light playsound( "evt_sq_rbs_light_off" );
        self._light delete();
    }
    
    if ( level._osc_terms < 4 )
    {
        ent_hacker thread zm_audio::create_and_play_dialog( "eggs", "quest3", randomintrange( 10, 12 ) );
    }
    else
    {
        self thread play_moon_pass_vox( ent_hacker );
    }
    
    zm_equip_hacker::deregister_hackable_struct( self );
}

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0x81f603de, Offset: 0x1e40
// Size: 0xa2
function moon_good_jolie()
{
    level endon( #"jolie_fail" );
    level endon( #"jolie_pass" );
    level endon( level._osc_flags[ 1 ] );
    
    while ( level._osc_terms < 4 )
    {
        println( "<dev string:x136>" + level._osc_terms );
        wait 0.1;
    }
    
    level flag::set( level._osc_flags[ 3 ] );
    level notify( #"jolie_pass" );
}

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0x49259061, Offset: 0x1ef0
// Size: 0xfe
function moon_bad_jolie()
{
    level endon( #"jolie_fail" );
    level endon( #"jolie_pass" );
    level endon( level._osc_flags[ 1 ] );
    wait level._osc_trial_time;
    level flag::set( level._osc_flags[ 2 ] );
    level thread comp_fail_vox();
    
    foreach ( var_c597f9d8 in level._osc_st )
    {
        var_c597f9d8 function_27fd2e20( 0 );
    }
    
    level notify( #"jolie_fail" );
}

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0x908e65cb, Offset: 0x1ff8
// Size: 0x174
function moon_jolie_timer_vox()
{
    level endon( #"jolie_fail" );
    level endon( #"jolie_pass" );
    level endon( level._osc_flags[ 1 ] );
    
    for ( i = level._osc_trial_time; i > 0 ; i-- )
    {
        playon = self.focus._light;
        
        if ( !isdefined( playon ) )
        {
            return;
        }
        
        if ( i == 50 )
        {
            playon playsound( "vox_mcomp_quest_step3_2" );
        }
        
        if ( i == 40 )
        {
            playon playsound( "vox_mcomp_quest_step3_3" );
        }
        
        if ( i == 30 )
        {
            playon playsound( "vox_mcomp_quest_step3_4" );
        }
        
        if ( i == 20 )
        {
            playon playsound( "vox_mcomp_quest_step3_5" );
        }
        
        if ( i == 10 )
        {
            playon playsound( "vox_mcomp_quest_step3_6" );
        }
        
        if ( i == 5 )
        {
            playon playsound( "vox_mcomp_quest_step3_7" );
        }
        
        wait 1;
    }
}

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0x106c3480, Offset: 0x2178
// Size: 0x2f8
function moon_open_access()
{
    button_triggers = [];
    level flag::wait_till( level._osc_flags[ 1 ] );
    
    for ( i = 0; i < level._osc_rbs.size ; i++ )
    {
        trig = spawn( "trigger_radius_use", level._osc_rbs[ i ].origin, 0, 48, 32 );
        trig.radius = 48;
        trig setcursorhint( "HINT_NOICON" );
        trig triggerignoreteam();
        trig._hit_already = 0;
        trig thread moon_hit_reaction();
        array::add( button_triggers, trig, 0 );
        trig = undefined;
    }
    
    level thread moon_access_granted( button_triggers.size );
    
    while ( !level flag::get( level._osc_flags[ 9 ] ) )
    {
        level flag::wait_till( level._osc_flags[ 8 ] );
        
        if ( !isdefined( level._osc_struct.script_float ) )
        {
            println( "<dev string:x148>" );
            wait 1;
            return;
        }
        
        if ( getdvarint( "osc_access_time" ) > 0 )
        {
            wait getdvarint( "osc_access_time" );
        }
        else
        {
            wait level._osc_struct.script_float;
        }
        
        if ( !level flag::get( level._osc_flags[ 9 ] ) )
        {
            level._osc_release = 0;
            
            for ( k = 0; k < button_triggers.size ; k++ )
            {
                button_triggers[ k ]._hit_already = 0;
                
                if ( isdefined( button_triggers[ k ]._active ) )
                {
                    button_triggers[ k ]._active delete();
                }
            }
            
            level flag::clear( level._osc_flags[ 8 ] );
        }
    }
}

// Namespace zm_moon_sq_osc
// Params 1
// Checksum 0xeac17162, Offset: 0x2478
// Size: 0x174
function moon_access_granted( int_hits )
{
    level endon( #"end_game" );
    level flag::wait_till( level._osc_flags[ 1 ] );
    
    while ( !level flag::get( level._osc_flags[ 9 ] ) )
    {
        if ( level._osc_release == int_hits )
        {
            level flag::set( level._osc_flags[ 9 ] );
            
            for ( l = 0; l < level._osc_rbs.size ; l++ )
            {
                level._osc_rbs[ l ].cover.angles = level._osc_rbs[ l ].cover_close;
                level._osc_rbs[ l ].cover playsound( "evt_sq_rbs_close" );
                
                if ( l == 0 )
                {
                    level._osc_rbs[ l ].cover playsound( "evt_sq_rbs_button_complete" );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0xfe3fadd4, Offset: 0x25f8
// Size: 0x164
function moon_hit_reaction()
{
    level endon( #"end_game" );
    level endon( level._osc_flags[ 9 ] );
    
    while ( !level flag::get( level._osc_flags[ 9 ] ) )
    {
        self waittill( #"trigger", who );
        
        if ( self._hit_already )
        {
            wait 0.1;
            continue;
        }
        
        if ( zombie_utility::is_player_valid( who ) )
        {
            level flag::set( level._osc_flags[ 8 ] );
            self playsound( "evt_sq_rbs_button" );
            self._active = spawn( "script_model", self.origin );
            self._active setmodel( "tag_origin" );
            playfxontag( level._effect[ "osc_button_glow" ], self._active, "tag_origin" );
            self._hit_already = 1;
            level._osc_release++;
        }
    }
}

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0x5339c601, Offset: 0x2768
// Size: 0x9c
function moon_keyhole()
{
    level flag::wait_till( level._osc_flags[ 9 ] );
    level._osc_cap movez( -8, 1 );
    level._osc_cap playsound( "evt_sq_rbs_open" );
    level._osc_cap waittill( #"movedone" );
    level flag::set( level._osc_flags[ 10 ] );
}

/#

    // Namespace zm_moon_sq_osc
    // Params 2
    // Checksum 0x82f34dcf, Offset: 0x2810
    // Size: 0x70, Type: dev
    function hacker_debug( msg, color )
    {
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        while ( true )
        {
            print3d( self.origin, msg, color, 1, 2, 10 );
            wait 1;
        }
    }

#/

// Namespace zm_moon_sq_osc
// Params 1
// Checksum 0x95e49f47, Offset: 0x2888
// Size: 0xc4
function play_moon_jolie_access_vox( who )
{
    for ( i = 0; i < level._osc_rbs.size ; i++ )
    {
        level._osc_rbs[ i ].cover playsoundwithnotify( "vox_mcomp_quest_step3_1", "rbs_sounddone" );
    }
    
    level._osc_rbs[ 0 ].cover waittill( #"rbs_sounddone" );
    
    if ( isdefined( who ) )
    {
        who thread zm_audio::create_and_play_dialog( "eggs", "quest3", 9 );
    }
}

// Namespace zm_moon_sq_osc
// Params 1
// Checksum 0x744c2917, Offset: 0x2958
// Size: 0xe4
function play_moon_pass_vox( who )
{
    playsoundatposition( "vox_mcomp_quest_step5_26", self.origin );
    
    for ( i = 0; i < level._osc_rbs.size ; i++ )
    {
        level._osc_rbs[ i ].cover playsoundwithnotify( "vox_mcomp_quest_step5_26", "rbs_sounddone" );
    }
    
    level._osc_rbs[ 0 ].cover waittill( #"rbs_sounddone" );
    
    if ( isdefined( who ) )
    {
        who thread zm_audio::create_and_play_dialog( "eggs", "quest3", 12 );
    }
}

// Namespace zm_moon_sq_osc
// Params 0
// Checksum 0xfa9f007a, Offset: 0x2a48
// Size: 0x90
function comp_fail_vox()
{
    for ( i = 0; i < level._osc_rbs.size ; i++ )
    {
        level._osc_rbs[ i ].cover playsoundwithnotify( "vox_mcomp_quest_step5_8", "rbs_sounddone" );
    }
    
    level._osc_rbs[ 0 ].cover waittill( #"rbs_sounddone" );
    level._lid_close_sound = 0;
}

