#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/zm_moon_fx;

#namespace zm_moon_amb;

// Namespace zm_moon_amb
// Params 0
// Checksum 0xb755c0bb, Offset: 0x3f0
// Size: 0x224
function main()
{
    level._sndambientstatecallback = &function_93c8dd7;
    level.audio_zones_breached = [];
    level.audio_zones_breached[ "1" ] = 0;
    level.audio_zones_breached[ "2a" ] = 0;
    level.audio_zones_breached[ "2b" ] = 0;
    level.audio_zones_breached[ "3a" ] = 0;
    level.audio_zones_breached[ "3b" ] = 0;
    level.audio_zones_breached[ "3c" ] = 0;
    level.audio_zones_breached[ "4a" ] = 0;
    level.audio_zones_breached[ "4b" ] = 0;
    level.audio_zones_breached[ "5" ] = 0;
    level.audio_zones_breached[ "6" ] = 0;
    level thread setup_airless_ambient_packages();
    level thread teleporter_audio_sfx();
    level thread zone_alarms_setup();
    level thread ambience_randoms();
    level thread snd_start_autofx_audio();
    level thread function_c9207335();
    level thread startzmbspawnersoundloops();
    clientfield::register( "allplayers", "beam_fx_audio", 21000, 1, "counter", &beam_fx_audio, 0, 0 );
    clientfield::register( "world", "teleporter_audio_sfx", 21000, 1, "counter", &teleporter_audio_sfx, 0, 0 );
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0x92f9139f, Offset: 0x620
// Size: 0x74
function function_c9207335()
{
    wait 3;
    level thread function_d667714e();
    var_13a52dfe = getentarray( 0, "sndMusicTrig", "targetname" );
    array::thread_all( var_13a52dfe, &function_60a32834 );
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0x1070b422, Offset: 0x6a0
// Size: 0x94
function function_60a32834()
{
    while ( true )
    {
        self waittill( #"trigger", trigplayer );
        
        if ( trigplayer islocalplayer() )
        {
            level notify( #"hash_51d7bc7c", self.script_sound );
            
            while ( isdefined( trigplayer ) && trigplayer istouching( self ) )
            {
                wait 0.016;
            }
            
            continue;
        }
        
        wait 0.016;
    }
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0xf0bcd65d, Offset: 0x740
// Size: 0xf8
function function_d667714e()
{
    level.var_b6342abd = "";
    level.var_6d9d81aa = "";
    level.var_eb526c90 = spawn( 0, ( 0, 0, 0 ), "script_origin" );
    level.var_9433cf5a = level.var_eb526c90 playloopsound( level.var_b6342abd, 2 );
    
    while ( true )
    {
        level waittill( #"hash_51d7bc7c", location );
        level.var_6d9d81aa = "mus_moon_underscore_" + location;
        
        if ( level.var_6d9d81aa != level.var_b6342abd )
        {
            level thread function_b234849( level.var_6d9d81aa );
            level.var_b6342abd = level.var_6d9d81aa;
        }
    }
}

// Namespace zm_moon_amb
// Params 1
// Checksum 0x100a67ac, Offset: 0x840
// Size: 0x64
function function_b234849( var_6d9d81aa )
{
    level endon( #"hash_51d7bc7c" );
    level.var_eb526c90 stopallloopsounds( 2 );
    wait 1;
    level.var_9433cf5a = level.var_eb526c90 playloopsound( var_6d9d81aa, 2 );
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0x4c6db946, Offset: 0x8b0
// Size: 0x44
function snd_start_autofx_audio()
{
    audio::snd_play_auto_fx( "fx_moon_floodlight_wide", "amb_lights" );
    audio::snd_play_auto_fx( "fx_moon_floodlight_narrow", "amb_lights" );
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0x13c1fd6d, Offset: 0x900
// Size: 0x54
function ambience_randoms()
{
    level waittill( #"power_on" );
    array::thread_all( struct::get_array( "amb_random_beeps", "targetname" ), &play_random_beeps );
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0xcdc23848, Offset: 0x960
// Size: 0x50
function play_random_beeps()
{
    while ( true )
    {
        playsound( 0, "amb_random_beeps", self.origin );
        wait randomintrange( 10, 30 );
    }
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0x5ba27082, Offset: 0x9b8
// Size: 0xc4
function zone_alarms_setup()
{
    wait 5;
    array1 = struct::get_array( "zone_alarm", "targetname" );
    array2 = struct::get_array( "zone_shakes", "targetname" );
    
    if ( !isdefined( array1 ) || !isdefined( array2 ) )
    {
        return;
    }
    
    array::thread_all( array1, &play_zone_alarms );
    array::thread_all( array2, &play_zone_shakes );
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0xea103c44, Offset: 0xa88
// Size: 0x80
function play_zone_alarms()
{
    level endon( "Dz" + self.script_noteworthy + "e" );
    self thread reset_alarms();
    level waittill( "Dz" + self.script_noteworthy );
    
    while ( true )
    {
        playsound( 0, "evt_zone_alarm", self.origin );
        wait 2.8;
    }
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0x19efca2a, Offset: 0xb10
// Size: 0x98
function play_zone_shakes()
{
    level endon( "Dz" + self.script_noteworthy + "e" );
    self thread reset_shakes();
    level waittill( "Dz" + self.script_noteworthy );
    
    while ( true )
    {
        playsound( 0, "evt_digger_rattles_random", self.origin );
        wait randomfloatrange( 1.2, 2.3 );
    }
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0xc1023490, Offset: 0xbb0
// Size: 0x3c
function reset_alarms()
{
    level waittill( "Dz" + self.script_noteworthy + "e" );
    wait 2;
    self thread play_zone_alarms();
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0x60311460, Offset: 0xbf8
// Size: 0x3c
function reset_shakes()
{
    level waittill( "Dz" + self.script_noteworthy + "e" );
    wait 2;
    self thread play_zone_shakes();
}

// Namespace zm_moon_amb
// Params 7
// Checksum 0xff62ff43, Offset: 0xc40
// Size: 0x8c
function beam_fx_audio( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    playsound( 0, "evt_teleporter_beam_sfx", ( 0, 0, 0 ) );
    exploder::exploder( 122 );
    exploder::exploder( 132 );
}

// Namespace zm_moon_amb
// Params 7
// Checksum 0x56b5b7cb, Offset: 0xcd8
// Size: 0x12c
function teleporter_audio_sfx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( level.click_array ) )
    {
        level.click_array = struct::get_array( "teleporter_click_sfx", "targetname" );
    }
    
    if ( !isdefined( level.warmup_array ) )
    {
        level.warmup_array = struct::get_array( "teleporter_warmup_sfx", "targetname" );
    }
    
    array::thread_all( level.click_array, &play_teleporter_sounds );
    array::thread_all( level.warmup_array, &play_warmup_cooldown );
    exploder::exploder( 121 );
    exploder::exploder( 131 );
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0x25176183, Offset: 0xe10
// Size: 0x94
function play_teleporter_sounds()
{
    level endon( #"cafx" );
    wait 0.5;
    
    if ( isdefined( self.script_int ) && isdefined( self.script_noteworthy ) )
    {
        val = int( self.script_noteworthy ) / 2;
        wait val;
        playsound( 0, "evt_teleporter_click_" + self.script_noteworthy, self.origin );
    }
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0xd73d372, Offset: 0xeb0
// Size: 0x5c
function play_warmup_cooldown()
{
    level endon( #"cafx" );
    playsound( 0, "evt_teleporter_warmup", self.origin );
    wait 2;
    playsound( 0, "evt_teleporter_cooldown", self.origin );
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0xe06b14cc, Offset: 0xf18
// Size: 0x154
function setup_zone_1_special()
{
    level waittill( #"power_on" );
    level reset_ambient_packages( "1", 1 );
    level reset_ambient_packages( "2a", 1 );
    level reset_ambient_packages( "2b", 1 );
    level reset_ambient_packages( "3a", 1 );
    level reset_ambient_packages( "3b", 1 );
    level reset_ambient_packages( "3c", 1 );
    level reset_ambient_packages( "4a", 1 );
    level reset_ambient_packages( "4b", 1 );
    level reset_ambient_packages( "5", 1 );
    level reset_ambient_packages( "6", 1 );
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0xf3d60071, Offset: 0x1078
// Size: 0xdc
function setup_airless_ambient_packages()
{
    wait 5;
    trigs = getentarray( 0, "ambient_package", "targetname" );
    
    for ( i = 0; i < trigs.size ; i++ )
    {
        if ( isdefined( trigs[ i ].script_ambientroom ) )
        {
            trigs[ i ] remember_old_verb( trigs[ i ].script_ambientroom );
        }
        
        trigs[ i ].first_time = 1;
    }
    
    level thread setup_zone_1_special();
}

// Namespace zm_moon_amb
// Params 7
// Checksum 0xa6c3d722, Offset: 0x1160
// Size: 0x20e
function function_6ce4d731( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
    {
        level notify( fieldname );
        
        switch ( fieldname )
        {
            case "Az1":
                level thread reset_ambient_packages( "1" );
                level thread zm_moon_fx::breach_receiving_fx();
                break;
            case "Az2a":
                level thread reset_ambient_packages( "2a" );
                break;
            case "Az2b":
                level thread reset_ambient_packages( "2b" );
                break;
            case "Az3a":
                level thread reset_ambient_packages( "3a" );
                break;
            case "Az3b":
                level thread reset_ambient_packages( "3b" );
                break;
            case "Az3c":
                level thread reset_ambient_packages( "3c" );
                break;
            case "Az4a":
                level thread reset_ambient_packages( "4a" );
                level thread zm_moon_fx::breach_labs_lower_fx();
                break;
            case "Az4b":
                level thread reset_ambient_packages( "4b" );
                level thread zm_moon_fx::breach_labs_upper_fx();
                break;
            default:
                level thread reset_ambient_packages( "5" );
                break;
        }
    }
}

// Namespace zm_moon_amb
// Params 2
// Checksum 0xaceadeca, Offset: 0x1378
// Size: 0x4fa
function reset_ambient_packages( zone, poweron )
{
    if ( !isdefined( poweron ) )
    {
        poweron = 0;
    }
    
    if ( isdefined( zone ) )
    {
        trigs = getentarray( 0, "ambient_package", "targetname" );
        zone_array = [];
        z = 0;
        
        for ( i = 0; i < trigs.size ; i++ )
        {
            if ( isdefined( trigs[ i ].script_noteworthy ) && isdefined( trigs[ i ].script_ambientroom ) )
            {
                if ( trigs[ i ].script_noteworthy == zone )
                {
                    if ( poweron && !level.audio_zones_breached[ zone ] )
                    {
                        level.var_8aa493c0[ trigs[ i ].script_ambientroom ].var_b33e0a6 = trigs[ i ].script_string;
                        zone_array[ z ] = trigs[ i ];
                        z++;
                        continue;
                    }
                    
                    level.var_8aa493c0[ trigs[ i ].script_ambientroom ].var_b33e0a6 = "zmb_moon_bg_airless";
                    zone_array[ z ] = trigs[ i ];
                    z++;
                }
            }
        }
        
        players = getlocalplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            for ( a = 0; a < zone_array.size ; a++ )
            {
                if ( players[ i ] istouching( zone_array[ a ] ) )
                {
                    if ( !level.audio_zones_breached[ zone ] )
                    {
                        if ( poweron )
                        {
                            players[ i ] playsound( 0, "evt_air_repressurize" );
                            
                            if ( players[ i ] islocalplayer() )
                            {
                                level thread function_6b9d0090( zone_array[ a ].script_ambientroom );
                            }
                        }
                        else if ( !zone_array[ a ].first_time )
                        {
                            if ( zone == "5" )
                            {
                                players[ i ] playsound( 0, "evt_dig_wheel_breakthrough_bio" );
                                
                                if ( players[ i ] islocalplayer() )
                                {
                                    level thread function_6b9d0090( zone_array[ a ].script_ambientroom );
                                }
                            }
                            else if ( ( zone == "3a" || zone == "3b" || zone == "3c" ) && ( ( zone == "2a" || zone == "2b" ) && !level.audio_zones_breached[ "2b" ] || !level.audio_zones_breached[ "3b" ] ) )
                            {
                                players[ i ] playsound( 0, "evt_dig_wheel_breakthrough" );
                                
                                if ( players[ i ] islocalplayer() )
                                {
                                    level thread function_6b9d0090( zone_array[ a ].script_ambientroom );
                                }
                            }
                            
                            players[ i ] playsound( 0, "evt_air_release" );
                            
                            if ( players[ i ] islocalplayer() )
                            {
                                level thread function_6b9d0090( zone_array[ a ].script_ambientroom );
                            }
                        }
                    }
                }
                
                zone_array[ a ].first_time = 0;
            }
        }
        
        if ( !poweron )
        {
            level.audio_zones_breached[ zone ] = 1;
        }
    }
}

// Namespace zm_moon_amb
// Params 1
// Checksum 0xcb898fcd, Offset: 0x1880
// Size: 0x18
function remember_old_verb( name )
{
    if ( isdefined( self.masterreverbroomtype ) )
    {
    }
}

// Namespace zm_moon_amb
// Params 3
// Checksum 0xfffdbd79, Offset: 0x18a0
// Size: 0x6c
function function_93c8dd7( ambientroom, ambientpackage, roomcollidercent )
{
    if ( !isdefined( level.var_8aa493c0 ) )
    {
        level function_52553b46();
    }
    
    if ( !isdefined( level.var_8aa493c0[ ambientroom ] ) )
    {
        return;
    }
    
    level thread function_6b9d0090( ambientroom );
}

// Namespace zm_moon_amb
// Params 2
// Checksum 0x2902f659, Offset: 0x1918
// Size: 0x1d8
function function_52553b46( ambientroom, e_trigger )
{
    level.var_8aa493c0 = [];
    level.var_8aa493c0[ "space" ] = spawnstruct();
    level.var_8aa493c0[ "space" ].var_b33e0a6 = "zmb_moon_bg_airless";
    e_triggers = getentarray( 0, "ambient_package", "targetname" );
    
    foreach ( e_trigger in e_triggers )
    {
        level.var_8aa493c0[ e_trigger.script_ambientroom ] = spawnstruct();
        
        if ( isdefined( e_trigger.script_string ) )
        {
            if ( isdefined( e_trigger.script_noteworthy ) )
            {
                level.var_8aa493c0[ e_trigger.script_ambientroom ].var_b33e0a6 = "zmb_moon_bg_airless";
            }
            else
            {
                level.var_8aa493c0[ e_trigger.script_ambientroom ].var_b33e0a6 = e_trigger.script_string;
            }
            
            continue;
        }
        
        level.var_8aa493c0[ e_trigger.script_ambientroom ].var_b33e0a6 = undefined;
    }
}

// Namespace zm_moon_amb
// Params 1
// Checksum 0xb3f8da1d, Offset: 0x1af8
// Size: 0xc
function function_6b9d0090( ambientroom )
{
    
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0x52b755f9, Offset: 0x1b10
// Size: 0x15c
function startzmbspawnersoundloops()
{
    loopers = struct::get_array( "exterior_goal", "targetname" );
    
    if ( isdefined( loopers ) && loopers.size > 0 )
    {
        delay = 0;
        
        /#
            if ( getdvarint( "<dev string:x28>" ) > 0 )
            {
                println( "<dev string:x34>" + loopers.size + "<dev string:x6c>" );
            }
        #/
        
        for ( i = 0; i < loopers.size ; i++ )
        {
            loopers[ i ] thread soundloopthink();
            delay += 1;
            
            if ( delay % 20 == 0 )
            {
                wait 0.016;
            }
        }
        
        return;
    }
    
    /#
        if ( getdvarint( "<dev string:x28>" ) > 0 )
        {
            println( "<dev string:x77>" );
        }
    #/
}

// Namespace zm_moon_amb
// Params 0
// Checksum 0x6c512295, Offset: 0x1c78
// Size: 0x16c
function soundloopthink()
{
    if ( !isdefined( self.origin ) )
    {
        return;
    }
    
    if ( !isdefined( self.script_sound ) )
    {
        self.script_sound = "zmb_spawn_walla";
    }
    
    notifyname = "";
    assert( isdefined( notifyname ) );
    
    if ( isdefined( self.script_string ) )
    {
        notifyname = self.script_string;
    }
    
    assert( isdefined( notifyname ) );
    started = 1;
    
    if ( isdefined( self.script_int ) )
    {
        started = self.script_int != 0;
    }
    
    if ( started )
    {
        soundloopemitter( self.script_sound, self.origin );
    }
    
    if ( notifyname != "" )
    {
        for ( ;; )
        {
            level waittill( notifyname );
            
            if ( started )
            {
                soundstoploopemitter( self.script_sound, self.origin );
            }
            else
            {
                soundloopemitter( self.script_sound, self.origin );
            }
            
            started = !started;
        }
    }
}

