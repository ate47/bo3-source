#using scripts/codescripts/struct;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/zm_temple_sq;
#using scripts/zm/zm_temple_sq_brock;
#using scripts/zm/zm_temple_sq_skits;

#namespace zm_temple_sq_ptt;

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0x955f1b6, Offset: 0x410
// Size: 0x10c
function init()
{
    flag::init( "sq_ptt_dial_dialed" );
    flag::init( "sq_ptt_level_pulled" );
    flag::init( "ptt_plot_vo_done" );
    zm_sidequests::declare_sidequest_stage( "sq", "PtT", &init_stage, &stage_logic, &exit_stage );
    zm_sidequests::set_stage_time_limit( "sq", "PtT", 300 );
    zm_sidequests::declare_stage_asset_from_struct( "sq", "PtT", "sq_ptt_trig", &gas_volume, &function_74e74bde );
}

/#

    // Namespace zm_temple_sq_ptt
    // Params 0
    // Checksum 0x5778c9bd, Offset: 0x528
    // Size: 0x140, Type: dev
    function debug_jet()
    {
        self endon( #"death" );
        struct = struct::get( self.target, "<dev string:x28>" );
        dir = anglestoforward( struct.angles );
        
        while ( !( isdefined( level.disable_print3d_ent ) && level.disable_print3d_ent ) )
        {
            scale = 0.1;
            offset = ( 0, 0, 0 );
            
            for ( i = 0; i < 5 ; i++ )
            {
                print3d( struct.origin + offset, "<dev string:x33>", self.jet_color, 1, scale, 10 );
                scale *= 1.7;
                offset += dir * 6;
            }
            
            wait 1;
        }
    }

#/

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0x5ae3ab01, Offset: 0x670
// Size: 0x84
function ignite_jet()
{
    level endon( #"end_game" );
    self playsound( "evt_sq_ptt_gas_ignite" );
    str_exploder = "fxexp_" + self.script_int + 10;
    exploder::exploder( str_exploder );
    level waittill( #"sq_ptt_over" );
    exploder::stop_exploder( str_exploder );
}

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0x211abeaa, Offset: 0x700
// Size: 0xfa
function gas_volume()
{
    self endon( #"death" );
    self.jet_color = ( 0, 255, 0 );
    level flag::wait_till( "sq_ptt_dial_dialed" );
    exploder::exploder( "fxexp_" + self.script_int );
    
    while ( true )
    {
        level waittill( #"napalm_death", volume );
        
        if ( volume == self.script_int )
        {
            self.trigger notify( #"lit" );
            level notify( #"lit" );
            self thread ignite_jet();
            self thread play_line_on_nearby_player();
            level._ptt_num_lit++;
            return;
        }
    }
}

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0xcfe1fc44, Offset: 0x808
// Size: 0xc8
function play_line_on_nearby_player()
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( distancesquared( self.origin, players[ i ].origin ) <= 62500 )
        {
            players[ i ] thread zm_audio::create_and_play_dialog( "eggs", "quest4", randomintrange( 2, 5 ) );
            return;
        }
    }
}

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0x5f3b54da, Offset: 0x8d8
// Size: 0x15c
function function_d9c0ed6()
{
    self endon( #"death" );
    self triggerignoreteam();
    
    while ( true )
    {
        while ( level.var_4e4c9791.size == 0 )
        {
            /#
                if ( getdvarint( "<dev string:x35>" ) == 2 )
                {
                    wait ( self.owner_ent.script_int - 99 ) * 2;
                    self notify( #"hash_c1510355" );
                }
            #/
            
            wait 1;
        }
        
        while ( level.var_4e4c9791.size > 0 )
        {
            foreach ( zombie in level.var_4e4c9791 )
            {
                if ( zombie istouching( self ) )
                {
                    self notify( #"hash_c1510355" );
                }
            }
            
            util::wait_network_frame();
        }
    }
}

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0x46903df9, Offset: 0xa40
// Size: 0x9c
function function_74e74bde()
{
    self endon( #"death" );
    self endon( #"lit" );
    level flag::wait_till( "sq_ptt_dial_dialed" );
    self thread player_line_thread();
    self thread function_d9c0ed6();
    
    while ( true )
    {
        self waittill( #"hash_c1510355" );
        level notify( #"napalm_death", self.owner_ent.script_int );
        return;
    }
}

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0xf05ec056, Offset: 0xae8
// Size: 0x9a
function player_line_thread()
{
    self endon( #"death" );
    self endon( #"lit" );
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( isplayer( who ) )
        {
            who thread zm_audio::create_and_play_dialog( "eggs", "quest4", randomintrange( 0, 2 ) );
            return;
        }
    }
}

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0x925eb882, Offset: 0xb90
// Size: 0x13c
function init_stage()
{
    level notify( #"ptt_start" );
    level flag::clear( "sq_ptt_dial_dialed" );
    dial = getent( "sq_ptt_dial", "targetname" );
    dial thread ptt_dial();
    jets = getentarray( "sq_ptt_trig", "targetname" );
    level._ptt_jets = jets.size;
    level._ptt_num_lit = 0;
    zm_temple_sq_brock::delete_radio();
    
    if ( level flag::get( "radio_4_played" ) )
    {
        level thread delayed_start_skit( "tt4a" );
    }
    else
    {
        level thread delayed_start_skit( "tt4b" );
    }
    
    level thread play_choking_loop();
}

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0x2be55a09, Offset: 0xcd8
// Size: 0x106
function play_choking_loop()
{
    level endon( #"sq_ptt_over" );
    struct = struct::get( "sq_location_ptt", "targetname" );
    
    if ( !isdefined( struct ) )
    {
        return;
    }
    
    level._ptt_sound_choking_ent = spawn( "script_origin", struct.origin );
    level._ptt_sound_choking_ent playloopsound( "evt_sq_ptt_choking_loop", 2 );
    level flag::wait_till( "sq_ptt_dial_dialed" );
    level._ptt_sound_choking_ent stoploopsound( 1 );
    wait 1;
    level._ptt_sound_choking_ent delete();
    level._ptt_sound_choking_ent = undefined;
}

// Namespace zm_temple_sq_ptt
// Params 1
// Checksum 0xcc1251a5, Offset: 0xde8
// Size: 0x24
function delayed_start_skit( skit )
{
    level thread zm_temple_sq_skits::start_skit( skit );
}

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0xc8f3653, Offset: 0xe18
// Size: 0x1bc
function ptt_lever()
{
    level endon( #"sq_ptt_over" );
    level flag::clear( "sq_ptt_level_pulled" );
    
    if ( !isdefined( self.original_angles ) )
    {
        self.original_angles = self.angles;
    }
    
    self.angles = self.original_angles;
    
    while ( level._ptt_num_lit < level._ptt_jets )
    {
        level waittill( #"lit" );
        self playsound( "evt_sq_ptt_lever_ratchet" );
        self rotateroll( -25, 0.25 );
        self waittill( #"rotatedone" );
    }
    
    use_trigger = spawn( "trigger_radius_use", self.origin, 0, 32, 72 );
    use_trigger triggerignoreteam();
    use_trigger setcursorhint( "HINT_NOICON" );
    use_trigger waittill( #"trigger" );
    use_trigger delete();
    self playsound( "evt_sq_ptt_lever_pull" );
    self rotateroll( 100, 0.25 );
    self waittill( #"rotatedone" );
    level flag::set( "sq_ptt_level_pulled" );
}

// Namespace zm_temple_sq_ptt
// Params 1
// Checksum 0x4b6553ca, Offset: 0xfe0
// Size: 0x356
function ptt_story_vox( player )
{
    level endon( #"sq_ptt_over" );
    struct = struct::get( "sq_location_ptt", "targetname" );
    
    if ( !isdefined( struct ) )
    {
        return;
    }
    
    level._ptt_sound_ent = spawn( "script_origin", struct.origin );
    level._ptt_sound_ent_trash = spawn( "script_origin", struct.origin );
    level._ptt_sound_ent playsoundwithnotify( "vox_egg_story_3_0", "sounddone" );
    level._ptt_sound_ent waittill( #"sounddone" );
    level._ptt_sound_ent_trash playsound( "evt_sq_ptt_trash_start" );
    level._ptt_sound_ent_trash playloopsound( "evt_sq_ptt_trash_loop" );
    level._ptt_sound_ent playsoundwithnotify( "vox_egg_story_3_1", "sounddone" );
    level._ptt_sound_ent waittill( #"sounddone" );
    level._ptt_sound_ent playsoundwithnotify( "vox_egg_story_3_2", "sounddone" );
    level._ptt_sound_ent waittill( #"sounddone" );
    
    if ( isdefined( player ) )
    {
        level.skit_vox_override = 1;
        player playsoundwithnotify( "vox_egg_story_3_3" + zm_temple_sq::function_26186755( player.characterindex ), "vox_egg_sounddone" );
        player waittill( #"vox_egg_sounddone" );
        level.skit_vox_override = 0;
    }
    
    level thread ptt_story_reminder_vox( 45 );
    level flag::wait_till( "sq_ptt_level_pulled" );
    level._ptt_sound_ent_trash stoploopsound( 2 );
    level._ptt_sound_ent_trash playsound( "evt_sq_ptt_trash_end" );
    level._ptt_sound_ent playsoundwithnotify( "vox_egg_story_3_8", "sounddone" );
    level._ptt_sound_ent waittill( #"sounddone" );
    level._ptt_sound_ent playsoundwithnotify( "vox_egg_story_3_9", "sounddone" );
    level._ptt_sound_ent waittill( #"sounddone" );
    level flag::set( "ptt_plot_vo_done" );
    level._ptt_sound_ent_trash delete();
    level._ptt_sound_ent_trash = undefined;
    level._ptt_sound_ent delete();
    level._ptt_sound_ent = undefined;
}

// Namespace zm_temple_sq_ptt
// Params 1
// Checksum 0xbc8ad670, Offset: 0x1340
// Size: 0xae
function ptt_story_reminder_vox( waittime )
{
    level endon( #"sq_ptt_over" );
    wait waittime;
    count = 4;
    
    while ( !level flag::get( "sq_ptt_level_pulled" ) && count <= 7 )
    {
        level._ptt_sound_ent playsoundwithnotify( "vox_egg_story_3_" + count, "sounddone" );
        level._ptt_sound_ent waittill( #"sounddone" );
        count++;
        wait waittime;
    }
}

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0x42ed1ba6, Offset: 0x13f8
// Size: 0x104
function stage_logic()
{
    level flag::wait_till( "sq_ptt_dial_dialed" );
    
    while ( level._ptt_num_lit < level._ptt_jets )
    {
        wait 0.1;
    }
    
    level flag::wait_till( "sq_ptt_level_pulled" );
    level notify( #"suspend_timer" );
    wait 5;
    level notify( #"raise_crystal_1" );
    level notify( #"raise_crystal_2" );
    level notify( #"raise_crystal_3" );
    level notify( #"raise_crystal_4", 1 );
    level waittill( #"raised_crystal_4" );
    level flag::wait_till( "ptt_plot_vo_done" );
    wait 5;
    zm_sidequests::stage_completed( "sq", "PtT" );
}

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0x114d3de9, Offset: 0x1508
// Size: 0xd4
function remove_exploders()
{
    exploder::stop_exploder( "fxexp_100" );
    exploder::stop_exploder( "fxexp_101" );
    exploder::stop_exploder( "fxexp_102" );
    exploder::stop_exploder( "fxexp_103" );
    util::wait_network_frame();
    exploder::stop_exploder( "fxexp_110" );
    exploder::stop_exploder( "fxexp_111" );
    exploder::stop_exploder( "fxexp_112" );
    exploder::stop_exploder( "fxexp_113" );
}

// Namespace zm_temple_sq_ptt
// Params 1
// Checksum 0xe1713072, Offset: 0x15e8
// Size: 0x20e
function exit_stage( success )
{
    level flag::clear( "sq_ptt_dial_dialed" );
    level flag::clear( "ptt_plot_vo_done" );
    dial = getent( "sq_ptt_dial", "targetname" );
    dial thread dud_dial_handler();
    ents = getaiarray();
    
    for ( i = 0; i < ents.size ; i++ )
    {
        if ( isdefined( ents[ i ].explosive_volume ) )
        {
            ents[ i ].explosive_volume = 0;
        }
    }
    
    level thread remove_exploders();
    
    if ( success )
    {
        zm_temple_sq_brock::create_radio( 5 );
    }
    else
    {
        zm_temple_sq_brock::create_radio( 4, &zm_temple_sq_brock::radio4_override );
        level thread zm_temple_sq_skits::fail_skit();
    }
    
    level.skit_vox_override = 0;
    
    if ( isdefined( level._ptt_sound_ent ) )
    {
        level._ptt_sound_ent delete();
        level._ptt_sound_ent = undefined;
    }
    
    if ( isdefined( level._ptt_sound_ent_trash ) )
    {
        level._ptt_sound_ent_trash delete();
        level._ptt_sound_ent_trash = undefined;
    }
    
    if ( isdefined( level._ptt_sound_choking_ent ) )
    {
        level._ptt_sound_choking_ent delete();
        level._ptt_sound_choking_ent = undefined;
    }
}

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0x6529b10f, Offset: 0x1800
// Size: 0x58
function dial_trigger()
{
    level endon( #"ptt_start" );
    level endon( #"sq_ptt_over" );
    
    while ( true )
    {
        self waittill( #"trigger", who );
        self.owner_ent notify( #"triggered", who );
    }
}

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0xde5b6eae, Offset: 0x1860
// Size: 0x16c
function ptt_dial()
{
    level endon( #"sq_ptt_over" );
    num_turned = 0;
    who = undefined;
    self.trigger triggerignoreteam();
    self.trigger thread dial_trigger();
    
    while ( num_turned < 4 )
    {
        self waittill( #"triggered", who );
        self playsound( "evt_sq_ptt_valve" );
        self rotateroll( 90, 0.25 );
        self waittill( #"rotatedone" );
        num_turned++;
    }
    
    level thread ptt_story_vox( who );
    self playsound( "evt_sq_ptt_gas_release" );
    lever = getent( "sq_ptt_lever", "targetname" );
    lever thread ptt_lever();
    level flag::set( "sq_ptt_dial_dialed" );
}

// Namespace zm_temple_sq_ptt
// Params 0
// Checksum 0x76492037, Offset: 0x19d8
// Size: 0x90
function dud_dial_handler()
{
    level endon( #"ptt_start" );
    self.trigger triggerignoreteam();
    self.trigger thread dial_trigger();
    
    while ( true )
    {
        self waittill( #"triggered" );
        self playsound( "evt_sq_ptt_valve" );
        self rotateroll( 90, 0.25 );
    }
}

