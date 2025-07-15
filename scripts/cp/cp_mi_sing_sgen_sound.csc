#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/trigger_shared;

#namespace cp_mi_sing_sgen_sound;

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xede6bdec, Offset: 0x288
// Size: 0xf4
function main()
{
    thread decon_light();
    thread force_underwater_context();
    thread release_underwater_context();
    level thread sndmusicrampers();
    level thread sndscares();
    level thread sndjumpland();
    level thread function_4e5472a7();
    level thread function_45100b4d();
    level thread battle_cry();
    level thread function_6c080ebb();
    level thread function_66507a64();
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x5a02317c, Offset: 0x388
// Size: 0x12
function decon_light()
{
    level notify( #"light_on" );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x6d2c596c, Offset: 0x3a8
// Size: 0x10
function force_underwater_context()
{
    level waittill( #"tuwc" );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x9036ba8a, Offset: 0x3c0
// Size: 0x10
function release_underwater_context()
{
    level waittill( #"tuwco" );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x2bd07de5, Offset: 0x3d8
// Size: 0x1c
function sndmusicrampers()
{
    level thread sndrobothall();
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x947e6694, Offset: 0x400
// Size: 0xbc
function sndrobothall()
{
    level waittill( #"sndrhstart" );
    level thread sndrobothallend();
    target_origin = ( -163, -2934, -5050 );
    player = getlocalplayer( 0 );
    level.tensionactive = 1;
    level sndramperthink( player, target_origin, "mus_robothall_layer_1", 0, 1, 400, 1600, "mus_robothall_layer_2", 0, 1, 250, 1000, "mus_robothall_end" );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x9a798ddc, Offset: 0x4c8
// Size: 0x1c
function sndrobothallend()
{
    level waittill( #"sndrhstop" );
    level.tensionactive = 0;
}

// Namespace cp_mi_sing_sgen_sound
// Params 13
// Checksum 0xb4b7e0ea, Offset: 0x4f0
// Size: 0x404
function sndramperthink( player, target_origin, alias1, min_vol1, max_vol1, min_dist1, max_dist1, alias2, min_vol2, max_vol2, min_dist2, max_dist2, end_alias )
{
    level endon( #"save_restore" );
    level endon( #"disconnect" );
    player endon( #"death" );
    player endon( #"disconnect" );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    volume1 = undefined;
    volume2 = undefined;
    
    if ( isdefined( alias1 ) )
    {
        sndloop1_ent = spawn( 0, ( 0, 0, 0 ), "script_origin" );
        sndloop1_id = sndloop1_ent playloopsound( alias1, 3 );
        sndloop1_min_volume = min_vol1;
        sndloop1_max_volume = max_vol1;
        sndloop1_min_distance = min_dist1;
        sndloop1_max_distance = max_dist1;
        volume1 = 0;
    }
    
    if ( isdefined( alias2 ) )
    {
        sndloop2_ent = spawn( 0, ( 0, 0, 0 ), "script_origin" );
        sndloop2_id = sndloop2_ent playloopsound( alias2, 3 );
        sndloop2_min_volume = min_vol2;
        sndloop2_max_volume = max_vol2;
        sndloop2_min_distance = min_dist2;
        sndloop2_max_distance = max_dist2;
        volume2 = 0;
    }
    
    level thread function_860d167b( sndloop1_ent, sndloop2_ent, sndloop1_id, sndloop2_id );
    
    while ( isdefined( level.tensionactive ) && level.tensionactive )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        distance = distance( target_origin, player.origin );
        
        if ( isdefined( volume1 ) )
        {
            volume1 = audio::scale_speed( sndloop1_min_distance, sndloop1_max_distance, sndloop1_min_volume, sndloop1_max_volume, distance );
            volume1 = abs( 1 - volume1 );
            setsoundvolume( sndloop1_id, volume1 );
        }
        
        if ( isdefined( volume2 ) )
        {
            volume2 = audio::scale_speed( sndloop2_min_distance, sndloop2_max_distance, sndloop2_min_volume, sndloop2_max_volume, distance );
            volume2 = abs( 1 - volume2 );
            setsoundvolume( sndloop2_id, volume2 );
        }
        
        wait 0.1;
    }
    
    level notify( #"hash_61477803" );
    
    if ( isdefined( end_alias ) )
    {
        playsound( 0, end_alias, ( 0, 0, 0 ) );
    }
    
    if ( isdefined( sndloop1_ent ) )
    {
        sndloop1_ent delete();
    }
    
    if ( isdefined( sndloop2_ent ) )
    {
        sndloop2_ent delete();
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 4
// Checksum 0x39178e6b, Offset: 0x900
// Size: 0x114
function function_860d167b( ent1, ent2, id1, id2 )
{
    level endon( #"hash_61477803" );
    level waittill( #"save_restore" );
    ent1 delete();
    ent2 delete();
    id1 = undefined;
    id2 = undefined;
    target_origin = ( -163, -2934, -5050 );
    wait 2;
    player = getlocalplayer( 0 );
    
    if ( isdefined( player ) )
    {
        level thread sndramperthink( player, target_origin, "mus_robothall_layer_1", 0, 1, 400, 1600, "mus_robothall_layer_2", 0, 1, 250, 1000, "mus_robothall_end" );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x1f8a8fcf, Offset: 0xa20
// Size: 0x74
function sndscares()
{
    scaretrigs = getentarray( 0, "sndScares", "targetname" );
    
    if ( !isdefined( scaretrigs ) || scaretrigs.size <= 0 )
    {
        return;
    }
    
    array::thread_all( scaretrigs, &sndscaretrig );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x685fcf8d, Offset: 0xaa0
// Size: 0x9c
function sndscaretrig()
{
    target = struct::get( self.target, "targetname" );
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( who isplayer() )
        {
            playsound( 0, self.script_sound, target.origin );
            break;
        }
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xa66e42b7, Offset: 0xb48
// Size: 0x74
function sndjumpland()
{
    jumptrigs = getentarray( 0, "sndJumpLand", "targetname" );
    
    if ( !isdefined( jumptrigs ) || jumptrigs.size <= 0 )
    {
        return;
    }
    
    array::thread_all( jumptrigs, &sndjumplandtrig );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xdd3b3e19, Offset: 0xbc8
// Size: 0x50
function sndjumplandtrig()
{
    while ( true )
    {
        self waittill( #"trigger", who );
        self thread trigger::function_thread( who, &sndjumplandtrigplaysound );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 1
// Checksum 0xe964f39a, Offset: 0xc20
// Size: 0x34
function sndjumplandtrigplaysound( ent )
{
    playsound( 0, self.script_sound, ent.origin );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0xa45db3b0, Offset: 0xc60
// Size: 0x6c
function function_4e5472a7()
{
    level waittill( #"escp" );
    wait 3;
    audio::playloopat( "evt_escape_walla", ( 20225, 2651, -6631 ) );
    level waittill( #"escps" );
    audio::stoploopat( "evt_escape_walla", ( 20225, 2651, -6631 ) );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x9d5eceaa, Offset: 0xcd8
// Size: 0x98
function function_45100b4d()
{
    level endon( #"kw" );
    level waittill( #"sw" );
    
    while ( true )
    {
        playsound( 0, "vox_walla_call", ( -1045, -4195, 564 ) );
        wait 4;
        playsound( 0, "vox_walla_call_response", ( 621, -5090, 376 ) );
        wait randomintrange( 2, 7 );
    }
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x1f8d82b4, Offset: 0xd78
// Size: 0x3c
function battle_cry()
{
    level waittill( #"kw" );
    playsound( 0, "vox_walla_battlecry", ( -138, -4871, 311 ) );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x265ded44, Offset: 0xdc0
// Size: 0x1d4
function function_6c080ebb()
{
    level waittill( #"escp" );
    level thread function_9d912a9d( 20210, 4156, -6727 );
    level thread function_9d912a9d( 20369, 3460, -6700 );
    level thread function_9d912a9d( 20369, 3460, -6700 );
    level thread function_9d912a9d( 20176, 2461, -6547 );
    level thread function_9d912a9d( 21068, 2494, -6526 );
    level thread function_9d912a9d( 22036, 2473, -6543 );
    level thread function_9d912a9d( 23219, 2550, -6545 );
    level thread function_9d912a9d( 23132, 1542, -6547 );
    level thread function_9d912a9d( 23132, 1542, -6547 );
    level thread function_9d912a9d( 24602, 1593, -6243 );
    level thread function_9d912a9d( 25098, 1888, -6524 );
    level thread function_9d912a9d( 25120, 1258, -6557 );
    level thread function_9d912a9d( 25522, 1821, -6447 );
    level thread function_9d912a9d( 25516, 1302, -6511 );
}

// Namespace cp_mi_sing_sgen_sound
// Params 3
// Checksum 0x12c8fdab, Offset: 0xfa0
// Size: 0x44
function function_9d912a9d( pos1, pos2, pos3 )
{
    audio::playloopat( "evt_escape_alarm", ( pos1, pos2, pos3 ) );
}

// Namespace cp_mi_sing_sgen_sound
// Params 7
// Checksum 0xb3c2c607, Offset: 0xff0
// Size: 0xd0
function sndLabWalla( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        soundloopemitter( "amb_lab_walla", ( 1240, 285, -1203 ) );
        return;
    }
    
    soundstoploopemitter( "amb_lab_walla", ( 1240, 285, -1203 ) );
    playsound( 0, "amb_lab_walla_stop", ( 1240, 285, -1203 ) );
}

// Namespace cp_mi_sing_sgen_sound
// Params 0
// Checksum 0x7059daef, Offset: 0x10c8
// Size: 0x3c4
function function_66507a64()
{
    audio::playloopat( "amb_glitchy_screens", ( 3275, -2730, -4743 ) );
    audio::playloopat( "amb_glitchy_screens", ( 232, -939, -4529 ) );
    audio::playloopat( "amb_glitchy_screens", ( 3952, -1962, -4781 ) );
    audio::playloopat( "amb_flourescent_light_quiet", ( 1649, -999, -4547 ) );
    audio::playloopat( "amb_flourescent_light_quiet", ( 209, 53, -4409 ) );
    audio::playloopat( "amb_billboard_glitch_loop", ( 1100, -954, 325 ) );
    audio::playloopat( "amb_billboard_glitch_loop", ( -505, 1787, 4005 ) );
    audio::playloopat( "amb_billboard_glitch_loop", ( -25, -1367, 424 ) );
    audio::playloopat( "amb_billboard_glitch_loop", ( 398, -2739, 399 ) );
    audio::playloopat( "amb_computer", ( 4476, -2321, -4913 ) );
    audio::playloopat( "amb_computer", ( 4492, -2606, -4914 ) );
    audio::playloopat( "amb_air_vent", ( 4214, -2387, -4753 ) );
    audio::playloopat( "amb_air_vent", ( 3623, -2391, -4781 ) );
    audio::playloopat( "amb_quiet_monkey_machine", ( 4200, -2553, -4755 ) );
    audio::playloopat( "amb_quiet_monkey_machine", ( 3691, -2553, -4757 ) );
    audio::playloopat( "amb_quiet_monkey_machine", ( 3663, -2205, -4758 ) );
    audio::playloopat( "amb_quiet_monkey_machine", ( 4121, -2205, -4759 ) );
    audio::playloopat( "pfx_steam_hollow", ( 1487, 1043, -2042 ) );
    audio::playloopat( "pfx_steam_hollow", ( 1903, 1280, -1871 ) );
    audio::playloopat( "amb_flourescent_light_quiet", ( 1678, 416, -1813 ) );
    audio::playloopat( "amb_flourescent_light_quiet", ( 2326, -2166, -4608 ) );
    audio::playloopat( "amb_air_vent", ( 2265, -1672, -4526 ) );
    audio::playloopat( "amb_air_vent_rattle", ( 2265, -1672, -4526 ) );
    audio::playloopat( "amb_flourescent_light_quiet", ( 2652, -2736, -4656 ) );
}

