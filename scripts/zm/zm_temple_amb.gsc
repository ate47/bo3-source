#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/zm_temple_sq_skits;

#namespace zm_temple_amb;

// Namespace zm_temple_amb
// Params 0
// Checksum 0x85c85b1, Offset: 0x2b0
// Size: 0xf4
function main()
{
    level._audio_custom_weapon_check = &weapon_type_check_custom;
    level._custom_intro_vox = &intro_vox_or_skit;
    level._audio_alias_override = &audio_alias_override;
    level thread setup_music_egg();
    level thread visual_trigger_vox( "location_maze" );
    level thread visual_trigger_vox( "location_waterfall" );
    level thread visual_trigger_vox( "mine_see" );
    level thread endgame_vox();
    level thread function_45b4acf2();
}

// Namespace zm_temple_amb
// Params 0
// Checksum 0x23e3b70b, Offset: 0x3b0
// Size: 0x42
function audio_alias_override()
{
    level.plr_vox[ "kill" ][ "explosive" ] = "kill_explosive";
    level.plr_vox[ "kill" ][ "explosive_response" ] = undefined;
}

// Namespace zm_temple_amb
// Params 0
// Checksum 0xe2033c6b, Offset: 0x400
// Size: 0xa
function function_d4b7774a()
{
    wait 10;
}

// Namespace zm_temple_amb
// Params 0
// Checksum 0xf513140a, Offset: 0x418
// Size: 0x154
function endgame_vox()
{
    level waittill( #"end_game" );
    wait 2;
    winner = undefined;
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( isdefined( players[ i ]._has_anti115 ) && players[ i ]._has_anti115 == 1 )
        {
            winner = players[ i ];
            break;
        }
    }
    
    if ( isdefined( winner ) )
    {
        num = winner.characterindex;
        
        if ( isdefined( winner.zm_random_char ) )
        {
            num = winner.zm_random_char;
        }
        
        if ( num == 3 )
        {
            playsoundatposition( "vox_plr_3_gameover_1", ( 0, 0, 0 ) );
            return;
        }
        
        playsoundatposition( "vox_plr_3_gameover_0", ( 0, 0, 0 ) );
    }
}

// Namespace zm_temple_amb
// Params 2
// Checksum 0xfda8abdf, Offset: 0x578
// Size: 0x80
function weapon_type_check_custom( weapon, magic_box )
{
    if ( issubstr( weapon.name, "upgraded" ) )
    {
        return "upgrade";
    }
    
    w_root = weapon.rootweapon;
    return level.zombie_weapons[ w_root ].vox;
}

// Namespace zm_temple_amb
// Params 0
// Checksum 0x713ea969, Offset: 0x600
// Size: 0x5c
function setup_music_egg()
{
    level thread zm_audio_zhd::function_e753d4f();
    level flag::wait_till( "snd_song_completed" );
    level thread zm_audio::sndmusicsystem_playstate( "pareidolia" );
}

// Namespace zm_temple_amb
// Params 0
// Checksum 0x5bc3831b, Offset: 0x668
// Size: 0x17c
function intro_vox_or_skit()
{
    playsoundatposition( "evt_warp_in", ( 0, 0, 0 ) );
    wait 3;
    players = getplayers();
    
    if ( players.size == 4 && randomintrange( 0, 101 ) <= 10 )
    {
        if ( randomintrange( 0, 101 ) <= 10 )
        {
            players[ randomintrange( 0, players.size ) ] thread zm_audio::create_and_play_dialog( "eggs", "rod" );
        }
        else
        {
            num = randomintrange( 0, 2 );
            level thread zm_temple_sq_skits::start_skit( "start" + num, players );
        }
        
        return;
    }
    
    players[ randomintrange( 0, players.size ) ] thread zm_audio::create_and_play_dialog( "general", "start" );
}

// Namespace zm_temple_amb
// Params 1
// Checksum 0x268a0bed, Offset: 0x7f0
// Size: 0x134
function visual_trigger_vox( place )
{
    wait 3;
    struct = struct::get( "vox_" + place, "targetname" );
    
    if ( !isdefined( struct ) )
    {
        return;
    }
    
    vox_trig = spawn( "trigger_radius", struct.origin - ( 0, 0, 100 ), 0, 250, 200 );
    
    while ( true )
    {
        vox_trig waittill( #"trigger", who );
        
        if ( isplayer( who ) )
        {
            who thread zm_audio::create_and_play_dialog( "general", place );
            
            if ( place == "location_maze" )
            {
                wait 90;
                continue;
            }
            
            break;
        }
    }
    
    vox_trig delete();
}

// Namespace zm_temple_amb
// Params 0
// Checksum 0x8a3b85b4, Offset: 0x930
// Size: 0x11c
function function_45b4acf2()
{
    var_18d6690a = getentarray( "zhdsnd_pans", "targetname" );
    array::thread_all( var_18d6690a, &function_19277046 );
    n_count = 0;
    a_order = array( 1, 1, 5 );
    
    if ( var_18d6690a.size <= 0 )
    {
        return;
    }
    
    while ( true )
    {
        level waittill( #"hash_ab740a84", num );
        
        if ( num == a_order[ n_count ] )
        {
            n_count++;
            
            if ( n_count >= 3 )
            {
                break;
            }
            
            continue;
        }
        
        n_count = 0;
    }
    
    level flag::set( "snd_zhdegg_activate" );
}

// Namespace zm_temple_amb
// Params 0
// Checksum 0x3644b6c2, Offset: 0xa58
// Size: 0x148
function function_19277046()
{
    level endon( #"snd_zhdegg_activate" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, dir, loc, str_type, model, tag, part, weapon, flags );
        
        if ( !level flag::get( "gongs_resonating" ) )
        {
            continue;
        }
        
        if ( !isplayer( attacker ) )
        {
            continue;
        }
        
        if ( weapon != level.start_weapon )
        {
            continue;
        }
        
        if ( str_type != "MOD_PISTOL_BULLET" )
        {
            continue;
        }
        
        level notify( #"hash_ab740a84", self.script_int );
        playsoundatposition( "zmb_zhd_plate_hit", self.origin );
    }
}

