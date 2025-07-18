#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/music_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;

#namespace zm_audio;

// Namespace zm_audio
// Params 0, eflags: 0x2
// Checksum 0x42d46e52, Offset: 0x758
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_audio", &__init__, undefined, undefined );
}

// Namespace zm_audio
// Params 0
// Checksum 0x830ba0f9, Offset: 0x798
// Size: 0xec
function __init__()
{
    clientfield::register( "allplayers", "charindex", 1, 3, "int" );
    clientfield::register( "toplayer", "isspeaking", 1, 1, "int" );
    println( "<dev string:x28>" );
    level.audio_get_mod_type = &get_mod_type;
    level zmbvox();
    callback::on_connect( &init_audio_functions );
    level thread sndannouncer_init();
}

// Namespace zm_audio
// Params 1
// Checksum 0x59d1b587, Offset: 0x890
// Size: 0x3c
function setexertvoice( exert_id )
{
    self.player_exert_id = exert_id;
    self clientfield::set( "charindex", self.player_exert_id );
}

// Namespace zm_audio
// Params 2
// Checksum 0x1e24a43e, Offset: 0x8d8
// Size: 0x1e4
function playerexert( exert, notifywait )
{
    if ( !isdefined( notifywait ) )
    {
        notifywait = 0;
    }
    
    if ( isdefined( self.isexerting ) && ( isdefined( self.isspeaking ) && self.isspeaking || self.isexerting ) )
    {
        return;
    }
    
    if ( isdefined( self.beastmode ) && self.beastmode )
    {
        return;
    }
    
    id = level.exert_sounds[ 0 ][ exert ];
    
    if ( isdefined( self.player_exert_id ) )
    {
        if ( !isdefined( level.exert_sounds ) || !isdefined( level.exert_sounds[ self.player_exert_id ] ) || !isdefined( level.exert_sounds[ self.player_exert_id ][ exert ] ) )
        {
            return;
        }
        
        if ( isarray( level.exert_sounds[ self.player_exert_id ][ exert ] ) )
        {
            id = array::random( level.exert_sounds[ self.player_exert_id ][ exert ] );
        }
        else
        {
            id = level.exert_sounds[ self.player_exert_id ][ exert ];
        }
    }
    
    if ( isdefined( id ) )
    {
        self.isexerting = 1;
        
        if ( notifywait )
        {
            self playsoundwithnotify( id, "done_exerting" );
            self waittill( #"done_exerting" );
            self.isexerting = 0;
            return;
        }
        
        self thread exert_timer();
        self playsound( id );
    }
}

// Namespace zm_audio
// Params 0
// Checksum 0x6010c3fa, Offset: 0xac8
// Size: 0x38
function exert_timer()
{
    self endon( #"disconnect" );
    wait randomfloatrange( 1.5, 3 );
    self.isexerting = 0;
}

// Namespace zm_audio
// Params 0
// Checksum 0xb6e8ca47, Offset: 0xb08
// Size: 0x12c
function zmbvox()
{
    level.votimer = [];
    level.vox = zmbvoxcreate();
    
    if ( isdefined( level._zmbvoxlevelspecific ) )
    {
        level thread [[ level._zmbvoxlevelspecific ]]();
    }
    
    if ( isdefined( level._zmbvoxgametypespecific ) )
    {
        level thread [[ level._zmbvoxgametypespecific ]]();
    }
    
    announcer_ent = spawn( "script_origin", ( 0, 0, 0 ) );
    level.vox zmbvoxinitspeaker( "announcer", "vox_zmba_", announcer_ent );
    level.exert_sounds[ 0 ][ "burp" ] = "evt_belch";
    level.exert_sounds[ 0 ][ "hitmed" ] = "null";
    level.exert_sounds[ 0 ][ "hitlrg" ] = "null";
    
    if ( isdefined( level.setupcustomcharacterexerts ) )
    {
        [[ level.setupcustomcharacterexerts ]]();
    }
}

// Namespace zm_audio
// Params 0
// Checksum 0xebfb6660, Offset: 0xc40
// Size: 0x6c
function init_audio_functions()
{
    self thread zombie_behind_vox();
    self thread player_killstreak_timer();
    
    if ( isdefined( level._custom_zombie_oh_shit_vox_func ) )
    {
        self thread [[ level._custom_zombie_oh_shit_vox_func ]]();
        return;
    }
    
    self thread oh_shit_vox();
}

// Namespace zm_audio
// Params 0
// Checksum 0x27dff9b7, Offset: 0xcb8
// Size: 0x2f8
function zombie_behind_vox()
{
    level endon( #"unloaded" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( level._zbv_vox_last_update_time ) )
    {
        level._zbv_vox_last_update_time = 0;
        level._audio_zbv_shared_ent_list = zombie_utility::get_zombie_array();
    }
    
    while ( true )
    {
        wait 1;
        t = gettime();
        
        if ( t > level._zbv_vox_last_update_time + 1000 )
        {
            level._zbv_vox_last_update_time = t;
            level._audio_zbv_shared_ent_list = zombie_utility::get_zombie_array();
        }
        
        zombs = level._audio_zbv_shared_ent_list;
        played_sound = 0;
        
        for ( i = 0; i < zombs.size ; i++ )
        {
            if ( !isdefined( zombs[ i ] ) )
            {
                continue;
            }
            
            if ( zombs[ i ].isdog )
            {
                continue;
            }
            
            dist = 150;
            z_dist = 50;
            alias = level.vox_behind_zombie;
            
            if ( isdefined( zombs[ i ].zombie_move_speed ) )
            {
                switch ( zombs[ i ].zombie_move_speed )
                {
                    default:
                        dist = 150;
                        break;
                    case "run":
                        dist = 175;
                        break;
                    case "sprint":
                        dist = 200;
                        break;
                }
            }
            
            if ( distancesquared( zombs[ i ].origin, self.origin ) < dist * dist )
            {
                yaw = self zm_utility::getyawtospot( zombs[ i ].origin );
                z_diff = self.origin[ 2 ] - zombs[ i ].origin[ 2 ];
                
                if ( ( yaw < -95 || yaw > 95 ) && abs( z_diff ) < 50 )
                {
                    zombs[ i ] notify( #"bhtn_action_notify", "behind" );
                    played_sound = 1;
                    break;
                }
            }
        }
        
        if ( played_sound )
        {
            wait 3.5;
        }
    }
}

// Namespace zm_audio
// Params 0
// Checksum 0x96b82e50, Offset: 0xfb8
// Size: 0x16e
function oh_shit_vox()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        wait 1;
        players = getplayers();
        zombs = zombie_utility::get_round_enemy_array();
        
        if ( players.size >= 1 )
        {
            close_zombs = 0;
            
            for ( i = 0; i < zombs.size ; i++ )
            {
                if ( isdefined( zombs[ i ].favoriteenemy ) && zombs[ i ].favoriteenemy == self || !isdefined( zombs[ i ].favoriteenemy ) )
                {
                    if ( distancesquared( zombs[ i ].origin, self.origin ) < 62500 )
                    {
                        close_zombs++;
                    }
                }
            }
            
            if ( close_zombs > 4 )
            {
                self create_and_play_dialog( "general", "oh_shit" );
                wait 4;
            }
        }
    }
}

// Namespace zm_audio
// Params 0
// Checksum 0x3b238d26, Offset: 0x1130
// Size: 0x1e0
function player_killstreak_timer()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( getdvarstring( "zombie_kills" ) == "" )
    {
        setdvar( "zombie_kills", "7" );
    }
    
    if ( getdvarstring( "zombie_kill_timer" ) == "" )
    {
        setdvar( "zombie_kill_timer", "5" );
    }
    
    kills = getdvarint( "zombie_kills" );
    time = getdvarint( "zombie_kill_timer" );
    
    if ( !isdefined( self.timerisrunning ) )
    {
        self.timerisrunning = 0;
        self.killcounter = 0;
    }
    
    while ( true )
    {
        self waittill( #"zom_kill", zomb );
        
        if ( isdefined( zomb._black_hole_bomb_collapse_death ) && zomb._black_hole_bomb_collapse_death == 1 )
        {
            continue;
        }
        
        if ( isdefined( zomb.microwavegun_death ) && zomb.microwavegun_death )
        {
            continue;
        }
        
        self.killcounter++;
        
        if ( self.timerisrunning != 1 )
        {
            self.timerisrunning = 1;
            self thread timer_actual( kills, time );
        }
    }
}

// Namespace zm_audio
// Params 4
// Checksum 0xb068737e, Offset: 0x1318
// Size: 0x1b4
function player_zombie_kill_vox( hit_location, player, mod, zombie )
{
    weapon = player getcurrentweapon();
    dist = distancesquared( player.origin, zombie.origin );
    
    if ( !isdefined( level.zombie_vars[ player.team ][ "zombie_insta_kill" ] ) )
    {
        level.zombie_vars[ player.team ][ "zombie_insta_kill" ] = 0;
    }
    
    instakill = level.zombie_vars[ player.team ][ "zombie_insta_kill" ];
    death = [[ level.audio_get_mod_type ]]( hit_location, mod, weapon, zombie, instakill, dist, player );
    
    if ( !isdefined( death ) )
    {
        return undefined;
    }
    
    if ( !( isdefined( player.force_wait_on_kill_line ) && player.force_wait_on_kill_line ) )
    {
        player.force_wait_on_kill_line = 1;
        player create_and_play_dialog( "kill", death );
        wait 2;
        
        if ( isdefined( player ) )
        {
            player.force_wait_on_kill_line = 0;
        }
    }
}

// Namespace zm_audio
// Params 1
// Checksum 0x2def7c6, Offset: 0x14d8
// Size: 0x30
function get_response_chance( event )
{
    if ( !isdefined( level.response_chances[ event ] ) )
    {
        return 0;
    }
    
    return level.response_chances[ event ];
}

// Namespace zm_audio
// Params 7
// Checksum 0x6a6bcb82, Offset: 0x1510
// Size: 0x36a
function get_mod_type( impact, mod, weapon, zombie, instakill, dist, player )
{
    close_dist = 4096;
    med_dist = 15376;
    far_dist = 160000;
    
    if ( weapon.name == "hero_annihilator" )
    {
        return "annihilator";
    }
    
    if ( zm_utility::is_placeable_mine( weapon ) )
    {
        if ( !instakill )
        {
            return "betty";
        }
        else
        {
            return "weapon_instakill";
        }
    }
    
    if ( zombie.damageweapon.name == "cymbal_monkey" )
    {
        if ( instakill )
        {
            return "weapon_instakill";
        }
        else
        {
            return "monkey";
        }
    }
    
    if ( weapon.name == "ray_gun" && dist > far_dist )
    {
        if ( !instakill )
        {
            return "raygun";
        }
        else
        {
            return "weapon_instakill";
        }
    }
    
    if ( zm_utility::is_headshot( weapon, impact, mod ) && dist >= far_dist )
    {
        return "headshot";
    }
    
    if ( ( mod == "MOD_MELEE" || mod == "MOD_UNKNOWN" ) && dist < close_dist )
    {
        if ( !instakill )
        {
            return "melee";
        }
        else
        {
            return "melee_instakill";
        }
    }
    
    if ( zm_utility::is_explosive_damage( mod ) && weapon.name != "ray_gun" && !( isdefined( zombie.is_on_fire ) && zombie.is_on_fire ) )
    {
        if ( !instakill )
        {
            return "explosive";
        }
        else
        {
            return "weapon_instakill";
        }
    }
    
    if ( mod == "MOD_BURNED" || mod == "MOD_GRENADE" || weapon.doesfiredamage && mod == "MOD_GRENADE_SPLASH" )
    {
        if ( !instakill )
        {
            return "flame";
        }
        else
        {
            return "weapon_instakill";
        }
    }
    
    if ( !isdefined( impact ) )
    {
        impact = "";
    }
    
    if ( mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET" )
    {
        if ( !instakill )
        {
            return "bullet";
        }
        else
        {
            return "weapon_instakill";
        }
    }
    
    if ( instakill )
    {
        return "default";
    }
    
    if ( mod != "MOD_MELEE" && zombie.missinglegs )
    {
        return "crawler";
    }
    
    if ( mod != "MOD_BURNED" && dist < close_dist )
    {
        return "close";
    }
    
    return "default";
}

// Namespace zm_audio
// Params 2
// Checksum 0xdf07c9c, Offset: 0x1888
// Size: 0xd0
function timer_actual( kills, time )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    timer = gettime() + time * 1000;
    
    while ( gettime() < timer )
    {
        if ( self.killcounter > kills )
        {
            self create_and_play_dialog( "kill", "streak" );
            wait 1;
            self.killcounter = 0;
            timer = -1;
        }
        
        wait 0.1;
    }
    
    wait 10;
    self.killcounter = 0;
    self.timerisrunning = 0;
}

// Namespace zm_audio
// Params 0
// Checksum 0xa2589b20, Offset: 0x1960
// Size: 0x34
function zmbvoxcreate()
{
    vox = spawnstruct();
    vox.speaker = [];
    return vox;
}

// Namespace zm_audio
// Params 3
// Checksum 0xffcc5613, Offset: 0x19a0
// Size: 0xb4
function zmbvoxinitspeaker( speaker, prefix, ent )
{
    ent.zmbvoxid = speaker;
    
    if ( !isdefined( self.speaker[ speaker ] ) )
    {
        self.speaker[ speaker ] = spawnstruct();
        self.speaker[ speaker ].alias = [];
    }
    
    self.speaker[ speaker ].prefix = prefix;
    self.speaker[ speaker ].ent = ent;
}

// Namespace zm_audio
// Params 1
// Checksum 0xe97141b5, Offset: 0x1a60
// Size: 0x4e
function custom_kill_damaged_vo( player )
{
    self notify( #"sound_damage_player_updated" );
    self endon( #"death" );
    self endon( #"sound_damage_player_updated" );
    self.sound_damage_player = player;
    wait 2;
    self.sound_damage_player = undefined;
}

// Namespace zm_audio
// Params 1
// Checksum 0x420ac1dc, Offset: 0x1ab8
// Size: 0x23c
function loadplayervoicecategories( table )
{
    level.votimer = [];
    level.sndplayervox = [];
    index = 0;
    
    for ( row = tablelookuprow( table, index ); isdefined( row ) ; row = tablelookuprow( table, index ) )
    {
        category = checkstringvalid( row[ 0 ] );
        subcategory = checkstringvalid( row[ 1 ] );
        suffix = checkstringvalid( row[ 2 ] );
        percentage = int( row[ 3 ] );
        
        if ( percentage <= 0 )
        {
            percentage = 100;
        }
        
        response = checkstringtrue( row[ 4 ] );
        
        if ( isdefined( response ) && response )
        {
            for ( i = 0; i < 4 ; i++ )
            {
                zmbvoxadd( category, subcategory + "_resp_" + i, suffix + "_resp_" + i, 50, 0 );
            }
        }
        
        delaybeforeplayagain = checkintvalid( row[ 5 ] );
        zmbvoxadd( category, subcategory, suffix, percentage, response, delaybeforeplayagain );
        index++;
    }
}

// Namespace zm_audio
// Params 1
// Checksum 0x229354a2, Offset: 0x1d00
// Size: 0x24
function checkstringvalid( str )
{
    if ( str != "" )
    {
        return str;
    }
    
    return undefined;
}

// Namespace zm_audio
// Params 1
// Checksum 0xf88a98b7, Offset: 0x1d30
// Size: 0x58, Type: bool
function checkstringtrue( str )
{
    if ( !isdefined( str ) )
    {
        return false;
    }
    
    if ( str != "" )
    {
        if ( tolower( str ) == "true" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_audio
// Params 2
// Checksum 0x7817d175, Offset: 0x1d90
// Size: 0x62
function checkintvalid( value, defaultvalue )
{
    if ( !isdefined( defaultvalue ) )
    {
        defaultvalue = 0;
    }
    
    if ( !isdefined( value ) )
    {
        return defaultvalue;
    }
    
    if ( value == "" )
    {
        return defaultvalue;
    }
    
    return int( value );
}

// Namespace zm_audio
// Params 6
// Checksum 0x9b960c06, Offset: 0x1e00
// Size: 0x1f4
function zmbvoxadd( category, subcategory, suffix, percentage, response, delaybeforeplayagain )
{
    if ( !isdefined( delaybeforeplayagain ) )
    {
        delaybeforeplayagain = 0;
    }
    
    assert( isdefined( category ) );
    assert( isdefined( subcategory ) );
    assert( isdefined( suffix ) );
    assert( isdefined( percentage ) );
    assert( isdefined( response ) );
    assert( isdefined( delaybeforeplayagain ) );
    vox = level.sndplayervox;
    
    if ( !isdefined( vox[ category ] ) )
    {
        vox[ category ] = [];
    }
    
    vox[ category ][ subcategory ] = spawnstruct();
    vox[ category ][ subcategory ].suffix = suffix;
    vox[ category ][ subcategory ].percentage = percentage;
    vox[ category ][ subcategory ].response = response;
    vox[ category ][ subcategory ].delaybeforeplayagain = delaybeforeplayagain;
    zm_utility::create_vox_timer( subcategory );
}

// Namespace zm_audio
// Params 3
// Checksum 0xf6a81c8f, Offset: 0x2000
// Size: 0x224
function create_and_play_dialog( category, subcategory, force_variant )
{
    if ( !isdefined( level.sndplayervox ) )
    {
        return;
    }
    
    if ( !isdefined( level.sndplayervox[ category ] ) )
    {
        return;
    }
    
    if ( !isdefined( level.sndplayervox[ category ][ subcategory ] ) )
    {
        /#
            if ( getdvarint( "<dev string:x5d>" ) > 0 )
            {
                println( "<dev string:x69>" + category + "<dev string:x84>" + subcategory + "<dev string:x95>" );
            }
        #/
        
        return;
    }
    
    if ( isdefined( self.isspeaking ) && self.isspeaking && ( isdefined( level.sndvoxoverride ) && level.sndvoxoverride || !( isdefined( self.b_wait_if_busy ) && self.b_wait_if_busy ) ) )
    {
        return;
    }
    
    suffix = level.sndplayervox[ category ][ subcategory ].suffix;
    percentage = level.sndplayervox[ category ][ subcategory ].percentage;
    prefix = shouldplayerspeak( self, category, subcategory, percentage );
    
    if ( !isdefined( prefix ) )
    {
        return;
    }
    
    sound_to_play = self zmbvoxgetlinevariant( prefix, suffix, force_variant );
    
    if ( isdefined( sound_to_play ) )
    {
        self thread do_player_or_npc_playvox( sound_to_play, category, subcategory );
        return;
    }
    
    /#
        if ( getdvarint( "<dev string:x5d>" ) > 0 )
        {
            iprintln( "<dev string:xab>" );
        }
    #/
}

// Namespace zm_audio
// Params 3
// Checksum 0x958e9326, Offset: 0x2230
// Size: 0x32c
function do_player_or_npc_playvox( sound_to_play, category, subcategory )
{
    self endon( #"death_or_disconnect" );
    
    if ( self flag::exists( "in_beastmode" ) && self flag::get( "in_beastmode" ) )
    {
        return;
    }
    
    if ( !isdefined( self.isspeaking ) )
    {
        self.isspeaking = 0;
    }
    
    if ( self.isspeaking )
    {
        return;
    }
    
    waittime = 1;
    
    if ( isdefined( self.ignorenearbyspkrs ) && ( !self arenearbyspeakersactive() || self.ignorenearbyspkrs ) )
    {
        self.speakingline = sound_to_play;
        self.isspeaking = 1;
        
        if ( isplayer( self ) )
        {
            self clientfield::set_to_player( "isspeaking", 1 );
        }
        
        playbacktime = soundgetplaybacktime( sound_to_play );
        
        if ( !isdefined( playbacktime ) )
        {
            return;
        }
        
        if ( playbacktime >= 0 )
        {
            playbacktime *= 0.001;
        }
        else
        {
            playbacktime = 1;
        }
        
        if ( isdefined( level._do_player_or_npc_playvox_override ) )
        {
            self thread [[ level._do_player_or_npc_playvox_override ]]( sound_to_play, playbacktime );
            wait playbacktime;
        }
        else if ( !self istestclient() )
        {
            self playsoundontag( sound_to_play, "J_Head" );
            wait playbacktime;
        }
        
        if ( isplayer( self ) && isdefined( self.last_vo_played_time ) )
        {
            if ( gettime() < self.last_vo_played_time + 5000 )
            {
                self.last_vo_played_time = gettime();
                waittime = 7;
            }
        }
        
        wait waittime;
        self.isspeaking = 0;
        
        if ( isplayer( self ) )
        {
            self clientfield::set_to_player( "isspeaking", 0 );
        }
        
        if ( isdefined( level.sndplayervox[ category ][ subcategory ].response ) && !level flag::get( "solo_game" ) && level.sndplayervox[ category ][ subcategory ].response )
        {
            if ( isdefined( level.vox_response_override ) && level.vox_response_override )
            {
                level thread setup_response_line_override( self, category, subcategory );
                return;
            }
            
            level thread setup_response_line( self, category, subcategory );
        }
    }
}

// Namespace zm_audio
// Params 3
// Checksum 0xf039dd3c, Offset: 0x2568
// Size: 0x12e
function setup_response_line_override( player, category, subcategory )
{
    if ( isdefined( level._audio_custom_response_line ) )
    {
        self thread [[ level._audio_custom_response_line ]]( player, category, subcategory );
        return;
    }
    
    switch ( player.characterindex )
    {
        case 0:
            level setup_hero_rival( player, 1, 2, category, subcategory );
            break;
        case 1:
            level setup_hero_rival( player, 2, 3, category, subcategory );
            break;
        case 3:
            level setup_hero_rival( player, 0, 1, category, subcategory );
            break;
        case 2:
            level setup_hero_rival( player, 3, 0, category, subcategory );
            break;
    }
}

// Namespace zm_audio
// Params 5
// Checksum 0x1fb0577e, Offset: 0x26a0
// Size: 0x2dc
function setup_hero_rival( player, hero, rival, category, type )
{
    players = getplayers();
    hero_player = undefined;
    rival_player = undefined;
    
    foreach ( ent in players )
    {
        if ( ent.characterindex == hero )
        {
            hero_player = ent;
            continue;
        }
        
        if ( ent.characterindex == rival )
        {
            rival_player = ent;
        }
    }
    
    if ( isdefined( hero_player ) && isdefined( rival_player ) )
    {
        if ( randomint( 100 ) > 50 )
        {
            hero_player = undefined;
        }
        else
        {
            rival_player = undefined;
        }
    }
    
    if ( isdefined( hero_player ) && distancesquared( player.origin, hero_player.origin ) < 250000 )
    {
        if ( isdefined( player.issamantha ) && player.issamantha )
        {
            hero_player create_and_play_dialog( category, type + "_s" );
        }
        else
        {
            hero_player create_and_play_dialog( category, type + "_hr" );
        }
        
        return;
    }
    
    if ( isdefined( rival_player ) && distancesquared( player.origin, rival_player.origin ) < 250000 )
    {
        if ( isdefined( player.issamantha ) && player.issamantha )
        {
            rival_player create_and_play_dialog( category, type + "_s" );
            return;
        }
        
        rival_player create_and_play_dialog( category, type + "_riv" );
    }
}

// Namespace zm_audio
// Params 3
// Checksum 0xf3e7aece, Offset: 0x2988
// Size: 0x114
function setup_response_line( player, category, subcategory )
{
    players = array::get_all_closest( player.origin, level.activeplayers );
    players_that_can_respond = array::exclude( players, player );
    
    if ( players_that_can_respond.size == 0 )
    {
        return;
    }
    
    player_to_respond = players_that_can_respond[ 0 ];
    
    if ( distancesquared( player.origin, player_to_respond.origin ) < 250000 )
    {
        player_to_respond create_and_play_dialog( category, subcategory + "_resp_" + player.characterindex );
    }
}

// Namespace zm_audio
// Params 4
// Checksum 0xe6b8352c, Offset: 0x2aa8
// Size: 0x1cc
function shouldplayerspeak( player, category, subcategory, percentage )
{
    if ( !isdefined( player ) )
    {
        return undefined;
    }
    
    if ( !player zm_utility::is_player() )
    {
        return undefined;
    }
    
    if ( player zm_utility::is_player() )
    {
        if ( player.sessionstate != "playing" )
        {
            return undefined;
        }
        
        if ( subcategory != "revive_down" || player laststand::player_is_in_laststand() && subcategory != "revive_up" )
        {
            return undefined;
        }
        
        if ( player isplayerunderwater() )
        {
            return undefined;
        }
    }
    
    if ( isdefined( player.dontspeak ) && player.dontspeak )
    {
        return undefined;
    }
    
    if ( percentage < randomintrange( 1, 101 ) )
    {
        return undefined;
    }
    
    if ( isvoxoncooldown( player, category, subcategory ) )
    {
        return undefined;
    }
    
    index = zm_utility::get_player_index( player );
    
    if ( isdefined( player.issamantha ) && player.issamantha )
    {
        index = 4;
    }
    
    return "vox_plr_" + index + "_";
}

// Namespace zm_audio
// Params 3
// Checksum 0x4389c05a, Offset: 0x2c80
// Size: 0x124, Type: bool
function isvoxoncooldown( player, category, subcategory )
{
    if ( level.sndplayervox[ category ][ subcategory ].delaybeforeplayagain <= 0 )
    {
        return false;
    }
    
    fullname = category + subcategory;
    
    if ( !isdefined( player.voxtimer ) )
    {
        player.voxtimer = [];
    }
    
    if ( !isdefined( player.voxtimer[ fullname ] ) )
    {
        player.voxtimer[ fullname ] = gettime();
        return false;
    }
    
    time = gettime();
    
    if ( time - player.voxtimer[ fullname ] <= level.sndplayervox[ category ][ subcategory ].delaybeforeplayagain * 1000 )
    {
        return true;
    }
    
    player.voxtimer[ fullname ] = time;
    return false;
}

// Namespace zm_audio
// Params 3
// Checksum 0x1b9e86eb, Offset: 0x2db0
// Size: 0x20a
function zmbvoxgetlinevariant( prefix, suffix, force_variant )
{
    if ( !isdefined( self.sound_dialog ) )
    {
        self.sound_dialog = [];
        self.sound_dialog_available = [];
    }
    
    if ( !isdefined( self.sound_dialog[ suffix ] ) )
    {
        num_variants = zm_spawner::get_number_variants( prefix + suffix );
        
        if ( num_variants <= 0 )
        {
            /#
                if ( getdvarint( "<dev string:x5d>" ) > 0 )
                {
                    println( "<dev string:xd7>" + prefix + suffix );
                }
            #/
            
            return undefined;
        }
        
        for ( i = 0; i < num_variants ; i++ )
        {
            self.sound_dialog[ suffix ][ i ] = i;
        }
        
        self.sound_dialog_available[ suffix ] = [];
    }
    
    if ( self.sound_dialog_available[ suffix ].size <= 0 )
    {
        for ( i = 0; i < self.sound_dialog[ suffix ].size ; i++ )
        {
            self.sound_dialog_available[ suffix ][ i ] = self.sound_dialog[ suffix ][ i ];
        }
    }
    
    variation = array::random( self.sound_dialog_available[ suffix ] );
    arrayremovevalue( self.sound_dialog_available[ suffix ], variation );
    
    if ( isdefined( force_variant ) )
    {
        variation = force_variant;
    }
    
    return prefix + suffix + "_" + variation;
}

// Namespace zm_audio
// Params 1
// Checksum 0xd5b923ad, Offset: 0x2fc8
// Size: 0x1ae
function arenearbyspeakersactive( radius )
{
    if ( !isdefined( radius ) )
    {
        radius = 1000;
    }
    
    nearbyspeakeractive = 0;
    speakers = getplayers();
    
    foreach ( person in speakers )
    {
        if ( self == person )
        {
            continue;
        }
        
        if ( person zm_utility::is_player() )
        {
            if ( person.sessionstate != "playing" )
            {
                continue;
            }
            
            if ( person laststand::player_is_in_laststand() )
            {
                continue;
            }
        }
        
        if ( isdefined( person.isspeaking ) && person.isspeaking && !( isdefined( person.ignorenearbyspkrs ) && person.ignorenearbyspkrs ) )
        {
            if ( distancesquared( self.origin, person.origin ) < radius * radius )
            {
                nearbyspeakeractive = 1;
            }
        }
    }
    
    return nearbyspeakeractive;
}

// Namespace zm_audio
// Params 8
// Checksum 0xd95fdc5f, Offset: 0x3180
// Size: 0x2c4
function musicstate_create( statename, playtype, musname1, musname2, musname3, musname4, musname5, musname6 )
{
    if ( !isdefined( playtype ) )
    {
        playtype = 1;
    }
    
    if ( !isdefined( level.musicsystem ) )
    {
        level.musicsystem = spawnstruct();
        level.musicsystem.queue = 0;
        level.musicsystem.currentplaytype = 0;
        level.musicsystem.currentset = undefined;
        level.musicsystem.states = [];
    }
    
    level.musicsystem.states[ statename ] = spawnstruct();
    level.musicsystem.states[ statename ].playtype = playtype;
    level.musicsystem.states[ statename ].musarray = array();
    
    if ( isdefined( musname1 ) )
    {
        array::add( level.musicsystem.states[ statename ].musarray, musname1 );
    }
    
    if ( isdefined( musname2 ) )
    {
        array::add( level.musicsystem.states[ statename ].musarray, musname2 );
    }
    
    if ( isdefined( musname3 ) )
    {
        array::add( level.musicsystem.states[ statename ].musarray, musname3 );
    }
    
    if ( isdefined( musname4 ) )
    {
        array::add( level.musicsystem.states[ statename ].musarray, musname4 );
    }
    
    if ( isdefined( musname5 ) )
    {
        array::add( level.musicsystem.states[ statename ].musarray, musname5 );
    }
    
    if ( isdefined( musname6 ) )
    {
        array::add( level.musicsystem.states[ statename ].musarray, musname6 );
    }
}

// Namespace zm_audio
// Params 4
// Checksum 0x7e4f223c, Offset: 0x3450
// Size: 0x1d4
function sndmusicsystem_createstate( state, statename, playtype, delay )
{
    if ( !isdefined( playtype ) )
    {
        playtype = 1;
    }
    
    if ( !isdefined( delay ) )
    {
        delay = 0;
    }
    
    if ( !isdefined( level.musicsystem ) )
    {
        level.musicsystem = spawnstruct();
        level.musicsystem.ent = spawn( "script_origin", ( 0, 0, 0 ) );
        level.musicsystem.queue = 0;
        level.musicsystem.currentplaytype = 0;
        level.musicsystem.currentstate = undefined;
        level.musicsystem.states = [];
    }
    
    m = level.musicsystem;
    
    if ( !isdefined( m.states[ state ] ) )
    {
        m.states[ state ] = spawnstruct();
        m.states[ state ] = array();
    }
    
    m.states[ state ][ m.states[ state ].size ].statename = statename;
    m.states[ state ][ m.states[ state ].size ].playtype = playtype;
}

// Namespace zm_audio
// Params 1
// Checksum 0x17260107, Offset: 0x3630
// Size: 0x1b4
function sndmusicsystem_playstate( state )
{
    if ( !isdefined( level.musicsystem ) )
    {
        return;
    }
    
    m = level.musicsystem;
    
    if ( !isdefined( m.states[ state ] ) )
    {
        return;
    }
    
    s = level.musicsystem.states[ state ];
    playtype = s.playtype;
    
    if ( m.currentplaytype > 0 )
    {
        if ( playtype == 1 )
        {
            return;
        }
        else if ( playtype == 2 )
        {
            level thread sndmusicsystem_queuestate( state );
        }
        else if ( playtype == 3 && ( playtype > m.currentplaytype || m.currentplaytype == 3 ) )
        {
            if ( isdefined( level.musicsystemoverride ) && level.musicsystemoverride && playtype != 5 )
            {
                return;
            }
            else
            {
                level sndmusicsystem_stopandflush();
                level thread playstate( state );
            }
        }
        
        return;
    }
    
    if ( !( isdefined( level.musicsystemoverride ) && level.musicsystemoverride ) || playtype == 5 )
    {
        level thread playstate( state );
    }
}

// Namespace zm_audio
// Params 1
// Checksum 0xd6a025bf, Offset: 0x37f0
// Size: 0x1f6
function playstate( state )
{
    level endon( #"sndstatestop" );
    m = level.musicsystem;
    musarray = level.musicsystem.states[ state ].musarray;
    
    if ( musarray.size <= 0 )
    {
        return;
    }
    
    mustoplay = musarray[ randomintrange( 0, musarray.size ) ];
    m.currentplaytype = m.states[ state ].playtype;
    m.currentstate = state;
    wait 0.1;
    
    if ( isdefined( level.sndplaystateoverride ) )
    {
        perplayer = level [[ level.sndplaystateoverride ]]( state );
        
        if ( !( isdefined( perplayer ) && perplayer ) )
        {
            music::setmusicstate( mustoplay );
        }
    }
    else
    {
        music::setmusicstate( mustoplay );
    }
    
    aliasname = "mus_" + mustoplay + "_intro";
    playbacktime = soundgetplaybacktime( aliasname );
    
    if ( !isdefined( playbacktime ) || playbacktime <= 0 )
    {
        waittime = 1;
    }
    else
    {
        waittime = playbacktime * 0.001;
    }
    
    wait waittime;
    m.currentplaytype = 0;
    m.currentstate = undefined;
}

// Namespace zm_audio
// Params 1
// Checksum 0x10fe1281, Offset: 0x39f0
// Size: 0xec
function sndmusicsystem_queuestate( state )
{
    level endon( #"sndqueueflush" );
    m = level.musicsystem;
    count = 0;
    
    if ( isdefined( m.queue ) && m.queue )
    {
        return;
    }
    
    m.queue = 1;
    
    while ( m.currentplaytype > 0 )
    {
        wait 0.5;
        count++;
        
        if ( count >= 25 )
        {
            m.queue = 0;
            return;
        }
    }
    
    level thread playstate( state );
    m.queue = 0;
}

// Namespace zm_audio
// Params 0
// Checksum 0x7b074426, Offset: 0x3ae8
// Size: 0x52
function sndmusicsystem_stopandflush()
{
    level notify( #"sndqueueflush" );
    level.musicsystem.queue = 0;
    level notify( #"sndstatestop" );
    level.musicsystem.currentplaytype = 0;
    level.musicsystem.currentstate = undefined;
}

// Namespace zm_audio
// Params 0
// Checksum 0x1d7cd718, Offset: 0x3b48
// Size: 0x4c, Type: bool
function sndmusicsystem_isabletoplay()
{
    if ( !isdefined( level.musicsystem ) )
    {
        return false;
    }
    
    if ( !isdefined( level.musicsystem.currentplaytype ) )
    {
        return false;
    }
    
    if ( level.musicsystem.currentplaytype >= 4 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_audio
// Params 1
// Checksum 0xaf6e6a86, Offset: 0x3ba0
// Size: 0x54
function sndmusicsystem_locationsinit( locationarray )
{
    if ( !isdefined( locationarray ) || locationarray.size <= 0 )
    {
        return;
    }
    
    level.musicsystem.locationarray = locationarray;
    level thread sndmusicsystem_locations( locationarray );
}

// Namespace zm_audio
// Params 1
// Checksum 0x8a26eb8f, Offset: 0x3c00
// Size: 0xfc
function sndmusicsystem_locations( locationarray )
{
    numcut = 0;
    level.sndlastzone = undefined;
    m = level.musicsystem;
    
    while ( true )
    {
        level waittill( #"newzoneactive", activezone );
        wait 0.1;
        
        if ( !sndlocationshouldplay( locationarray, activezone ) )
        {
            continue;
        }
        
        level thread sndmusicsystem_playstate( activezone );
        locationarray = sndcurrentlocationarray( locationarray, activezone, numcut, 3 );
        level.sndlastzone = activezone;
        
        if ( numcut >= 3 )
        {
            numcut = 0;
        }
        else
        {
            numcut++;
        }
        
        level waittill( #"between_round_over" );
    }
}

// Namespace zm_audio
// Params 2
// Checksum 0xbf707041, Offset: 0x3d08
// Size: 0x128
function sndlocationshouldplay( array, activezone )
{
    shouldplay = 0;
    
    if ( level.musicsystem.currentplaytype >= 3 )
    {
        level thread sndlocationqueue( activezone );
        return shouldplay;
    }
    
    foreach ( place in array )
    {
        if ( place == activezone )
        {
            shouldplay = 1;
        }
    }
    
    if ( shouldplay == 0 )
    {
        return shouldplay;
    }
    
    if ( zm_zonemgr::any_player_in_zone( activezone ) )
    {
        shouldplay = 1;
    }
    else
    {
        shouldplay = 0;
    }
    
    return shouldplay;
}

// Namespace zm_audio
// Params 4
// Checksum 0x1e12a154, Offset: 0x3e38
// Size: 0xea
function sndcurrentlocationarray( current_array, activezone, numcut, num )
{
    if ( numcut >= num )
    {
        current_array = level.musicsystem.locationarray;
    }
    
    foreach ( place in current_array )
    {
        if ( place == activezone )
        {
            arrayremovevalue( current_array, place );
            break;
        }
    }
    
    return current_array;
}

// Namespace zm_audio
// Params 1
// Checksum 0x1171b9e8, Offset: 0x3f30
// Size: 0x4e
function sndlocationqueue( zone )
{
    level endon( #"newzoneactive" );
    
    while ( level.musicsystem.currentplaytype >= 3 )
    {
        wait 0.5;
    }
    
    level notify( #"newzoneactive", zone );
}

// Namespace zm_audio
// Params 6
// Checksum 0x28aec4e4, Offset: 0x3f88
// Size: 0x30a
function sndmusicsystem_eesetup( state, origin1, origin2, origin3, origin4, origin5 )
{
    sndeearray = array();
    
    if ( isdefined( origin1 ) )
    {
        if ( !isdefined( sndeearray ) )
        {
            sndeearray = [];
        }
        else if ( !isarray( sndeearray ) )
        {
            sndeearray = array( sndeearray );
        }
    }
    
    sndeearray[ sndeearray.size ] = origin1;
    
    if ( isdefined( origin2 ) )
    {
        if ( !isdefined( sndeearray ) )
        {
            sndeearray = [];
        }
        else if ( !isarray( sndeearray ) )
        {
            sndeearray = array( sndeearray );
        }
    }
    
    sndeearray[ sndeearray.size ] = origin2;
    
    if ( isdefined( origin3 ) )
    {
        if ( !isdefined( sndeearray ) )
        {
            sndeearray = [];
        }
        else if ( !isarray( sndeearray ) )
        {
            sndeearray = array( sndeearray );
        }
    }
    
    sndeearray[ sndeearray.size ] = origin3;
    
    if ( isdefined( origin4 ) )
    {
        if ( !isdefined( sndeearray ) )
        {
            sndeearray = [];
        }
        else if ( !isarray( sndeearray ) )
        {
            sndeearray = array( sndeearray );
        }
    }
    
    sndeearray[ sndeearray.size ] = origin4;
    
    if ( isdefined( origin5 ) )
    {
        if ( !isdefined( sndeearray ) )
        {
            sndeearray = [];
        }
        else if ( !isarray( sndeearray ) )
        {
            sndeearray = array( sndeearray );
        }
    }
    
    sndeearray[ sndeearray.size ] = origin5;
    
    if ( sndeearray.size > 0 )
    {
        level.sndeemax = sndeearray.size;
        level.sndeecount = 0;
        
        foreach ( origin in sndeearray )
        {
            level thread sndmusicsystem_eewait( origin, state );
        }
    }
}

// Namespace zm_audio
// Params 2
// Checksum 0x19f65af0, Offset: 0x42a0
// Size: 0x144
function sndmusicsystem_eewait( origin, state )
{
    temp_ent = spawn( "script_origin", origin );
    temp_ent playloopsound( "zmb_meteor_loop" );
    temp_ent thread secretuse( "main_music_egg_hit", ( 0, 255, 0 ), &sndmusicsystem_eeoverride );
    temp_ent waittill( #"main_music_egg_hit", player );
    temp_ent stoploopsound( 1 );
    player playsound( "zmb_meteor_activate" );
    level.sndeecount++;
    
    if ( level.sndeecount >= level.sndeemax )
    {
        level notify( #"hash_a1b1dadb" );
        level thread sndmusicsystem_playstate( state );
    }
    
    temp_ent delete();
}

// Namespace zm_audio
// Params 2
// Checksum 0x498e176d, Offset: 0x43f0
// Size: 0x48, Type: bool
function sndmusicsystem_eeoverride( arg1, arg2 )
{
    if ( isdefined( level.musicsystem.currentplaytype ) && level.musicsystem.currentplaytype >= 4 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_audio
// Params 5
// Checksum 0x81adc26d, Offset: 0x4440
// Size: 0x1a8
function secretuse( notify_string, color, qualifier_func, arg1, arg2 )
{
    waittillframeend();
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        /#
            print3d( self.origin, "<dev string:x101>", color, 1 );
        #/
        
        players = level.players;
        
        foreach ( player in players )
        {
            qualifier_passed = 1;
            
            if ( isdefined( qualifier_func ) )
            {
                qualifier_passed = player [[ qualifier_func ]]( arg1, arg2 );
            }
            
            if ( qualifier_passed && distancesquared( self.origin, player.origin ) < 4096 )
            {
                if ( player laststand::is_facing( self ) )
                {
                    if ( player usebuttonpressed() )
                    {
                        self notify( notify_string, player );
                        return;
                    }
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_audio
// Params 0
// Checksum 0x5e163e76, Offset: 0x45f0
// Size: 0x154
function sndannouncer_init()
{
    if ( !isdefined( level.zmannouncerprefix ) )
    {
        level.zmannouncerprefix = "vox_" + "zmba" + "_";
    }
    
    sndannouncervoxadd( "carpenter", "powerup_carpenter_0" );
    sndannouncervoxadd( "insta_kill", "powerup_instakill_0" );
    sndannouncervoxadd( "double_points", "powerup_doublepoints_0" );
    sndannouncervoxadd( "nuke", "powerup_nuke_0" );
    sndannouncervoxadd( "full_ammo", "powerup_maxammo_0" );
    sndannouncervoxadd( "fire_sale", "powerup_firesale_0" );
    sndannouncervoxadd( "minigun", "powerup_death_machine_0" );
    sndannouncervoxadd( "boxmove", "event_magicbox_0" );
    sndannouncervoxadd( "dogstart", "event_dogstart_0" );
}

// Namespace zm_audio
// Params 2
// Checksum 0xab47a598, Offset: 0x4750
// Size: 0x4e
function sndannouncervoxadd( type, suffix )
{
    if ( !isdefined( level.zmannouncervox ) )
    {
        level.zmannouncervox = array();
    }
    
    level.zmannouncervox[ type ] = suffix;
}

// Namespace zm_audio
// Params 2
// Checksum 0x7c6ad48b, Offset: 0x47a8
// Size: 0x154
function sndannouncerplayvox( type, player )
{
    if ( !isdefined( level.zmannouncervox[ type ] ) )
    {
        return;
    }
    
    prefix = level.zmannouncerprefix;
    suffix = level.zmannouncervox[ type ];
    
    if ( !( isdefined( level.zmannouncertalking ) && level.zmannouncertalking ) )
    {
        if ( !isdefined( player ) )
        {
            level.zmannouncertalking = 1;
            temp_ent = spawn( "script_origin", ( 0, 0, 0 ) );
            temp_ent playsoundwithnotify( prefix + suffix, prefix + suffix + "wait" );
            temp_ent waittill( prefix + suffix + "wait" );
            wait 0.05;
            temp_ent delete();
            level.zmannouncertalking = 0;
            return;
        }
        
        player playsoundtoplayer( prefix + suffix, player );
    }
}

// Namespace zm_audio
// Params 0
// Checksum 0x45b62a5e, Offset: 0x4908
// Size: 0x2ea
function zmbaivox_notifyconvert()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self thread zmbaivox_playdeath();
    self thread zmbaivox_playelectrocution();
    
    while ( true )
    {
        self waittill( #"bhtn_action_notify", notify_string );
        
        switch ( notify_string )
        {
            case "pain":
                level thread zmbaivox_playvox( self, notify_string, 1, 9 );
                break;
            case "death":
                if ( isdefined( self.bgb_tone_death ) && self.bgb_tone_death )
                {
                    level thread zmbaivox_playvox( self, "death_whimsy", 1, 10 );
                }
                else
                {
                    level thread zmbaivox_playvox( self, notify_string, 1, 10 );
                }
                
                break;
            case "behind":
                level thread zmbaivox_playvox( self, notify_string, 1, 9 );
                break;
            case "attack_melee":
                if ( self.animname != "zombie" && ( !isdefined( self.animname ) || self.animname != "quad_zombie" ) )
                {
                    level thread zmbaivox_playvox( self, notify_string, 1, 8, 1 );
                }
                
                break;
            case "attack_melee_zhd":
                level thread zmbaivox_playvox( self, "attack_melee", 1, 8, 1 );
                break;
            case "electrocute":
                level thread zmbaivox_playvox( self, notify_string, 1, 7 );
                break;
            case "close":
                level thread zmbaivox_playvox( self, notify_string, 1, 6 );
                break;
            case "ambient":
            case "crawler":
            case "sprint":
            case "taunt":
            case "teardown":
                level thread zmbaivox_playvox( self, notify_string, 0 );
                break;
            default:
                if ( isdefined( level._zmbaivox_specialtype ) )
                {
                    if ( isdefined( level._zmbaivox_specialtype[ notify_string ] ) )
                    {
                        level thread zmbaivox_playvox( self, notify_string, 0 );
                    }
                }
                
                break;
        }
    }
}

// Namespace zm_audio
// Params 5
// Checksum 0x3a8838c8, Offset: 0x4c00
// Size: 0x370
function zmbaivox_playvox( zombie, type, override, priority, delayambientvox )
{
    if ( !isdefined( delayambientvox ) )
    {
        delayambientvox = 0;
    }
    
    zombie endon( #"death" );
    
    if ( !isdefined( zombie ) )
    {
        return;
    }
    
    if ( !isdefined( zombie.voiceprefix ) )
    {
        return;
    }
    
    if ( !isdefined( priority ) )
    {
        priority = 1;
    }
    
    if ( !isdefined( zombie.currentvoxpriority ) )
    {
        zombie.currentvoxpriority = 1;
    }
    
    if ( !isdefined( self.delayambientvox ) )
    {
        self.delayambientvox = 0;
    }
    
    if ( isdefined( self.delayambientvox ) && ( type == "ambient" || type == "sprint" || type == "crawler" ) && self.delayambientvox )
    {
        return;
    }
    
    if ( delayambientvox )
    {
        self.delayambientvox = 1;
        self thread zmbaivox_ambientdelay();
    }
    
    alias = "zmb_vocals_" + zombie.voiceprefix + "_" + type;
    
    if ( sndisnetworksafe() )
    {
        if ( isdefined( override ) && override )
        {
            if ( isdefined( zombie.currentvox ) && priority > zombie.currentvoxpriority )
            {
                zombie stopsound( zombie.currentvox );
            }
            
            if ( type == "death" || type == "death_whimsy" )
            {
                zombie playsound( alias );
                return;
            }
        }
        
        if ( zombie.talking === 1 && priority < zombie.currentvoxpriority )
        {
            return;
        }
        
        zombie.talking = 1;
        
        if ( zombie is_last_zombie() && type == "ambient" )
        {
            alias += "_loud";
        }
        
        zombie.currentvox = alias;
        zombie.currentvoxpriority = priority;
        zombie playsoundontag( alias, "j_head" );
        playbacktime = soundgetplaybacktime( alias );
        
        if ( !isdefined( playbacktime ) )
        {
            playbacktime = 1;
        }
        
        if ( playbacktime >= 0 )
        {
            playbacktime *= 0.001;
        }
        else
        {
            playbacktime = 1;
        }
        
        wait playbacktime;
        zombie.talking = 0;
        zombie.currentvox = undefined;
        zombie.currentvoxpriority = 1;
    }
}

// Namespace zm_audio
// Params 0
// Checksum 0x5ed9db76, Offset: 0x4f78
// Size: 0x9c
function zmbaivox_playdeath()
{
    self endon( #"disconnect" );
    self waittill( #"death", attacker, meansofdeath );
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.bgb_tone_death ) && self.bgb_tone_death )
        {
            level thread zmbaivox_playvox( self, "death_whimsy", 1 );
            return;
        }
        
        level thread zmbaivox_playvox( self, "death", 1 );
    }
}

// Namespace zm_audio
// Params 0
// Checksum 0x1884f579, Offset: 0x5020
// Size: 0x10a
function zmbaivox_playelectrocution()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon );
        
        if ( weapon.name == "zombie_beast_lightning_dwl" || weapon.name == "zombie_beast_lightning_dwl2" || weapon.name == "zombie_beast_lightning_dwl3" )
        {
            self notify( #"bhtn_action_notify", "electrocute" );
        }
    }
}

// Namespace zm_audio
// Params 0
// Checksum 0xb69d0b99, Offset: 0x5138
// Size: 0x48
function zmbaivox_ambientdelay()
{
    self notify( #"sndambientdelay" );
    self endon( #"sndambientdelay" );
    self endon( #"death" );
    self endon( #"disconnect" );
    wait 2;
    self.delayambientvox = 0;
}

// Namespace zm_audio
// Params 0
// Checksum 0x366aa0dc, Offset: 0x5188
// Size: 0x30
function networksafereset()
{
    while ( true )
    {
        level._numzmbaivox = 0;
        util::wait_network_frame();
    }
}

// Namespace zm_audio
// Params 0
// Checksum 0xb8cc1b77, Offset: 0x51c0
// Size: 0x44, Type: bool
function sndisnetworksafe()
{
    if ( !isdefined( level._numzmbaivox ) )
    {
        level thread networksafereset();
    }
    
    if ( level._numzmbaivox >= 2 )
    {
        return false;
    }
    
    level._numzmbaivox++;
    return true;
}

// Namespace zm_audio
// Params 0
// Checksum 0x504d9bce, Offset: 0x5210
// Size: 0x24, Type: bool
function is_last_zombie()
{
    if ( zombie_utility::get_current_zombie_count() <= 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_audio
// Params 7
// Checksum 0x33228ca2, Offset: 0x5240
// Size: 0x466
function sndradiosetup( alias_prefix, is_sequential, origin1, origin2, origin3, origin4, origin5 )
{
    if ( !isdefined( is_sequential ) )
    {
        is_sequential = 0;
    }
    
    radio = spawnstruct();
    radio.counter = 1;
    radio.alias_prefix = alias_prefix;
    radio.isplaying = 0;
    radio.array = array();
    
    if ( isdefined( origin1 ) )
    {
        if ( !isdefined( radio.array ) )
        {
            radio.array = [];
        }
        else if ( !isarray( radio.array ) )
        {
            radio.array = array( radio.array );
        }
    }
    
    radio.array[ radio.array.size ] = origin1;
    
    if ( isdefined( origin2 ) )
    {
        if ( !isdefined( radio.array ) )
        {
            radio.array = [];
        }
        else if ( !isarray( radio.array ) )
        {
            radio.array = array( radio.array );
        }
    }
    
    radio.array[ radio.array.size ] = origin2;
    
    if ( isdefined( origin3 ) )
    {
        if ( !isdefined( radio.array ) )
        {
            radio.array = [];
        }
        else if ( !isarray( radio.array ) )
        {
            radio.array = array( radio.array );
        }
    }
    
    radio.array[ radio.array.size ] = origin3;
    
    if ( isdefined( origin4 ) )
    {
        if ( !isdefined( radio.array ) )
        {
            radio.array = [];
        }
        else if ( !isarray( radio.array ) )
        {
            radio.array = array( radio.array );
        }
    }
    
    radio.array[ radio.array.size ] = origin4;
    
    if ( isdefined( origin5 ) )
    {
        if ( !isdefined( radio.array ) )
        {
            radio.array = [];
        }
        else if ( !isarray( radio.array ) )
        {
            radio.array = array( radio.array );
        }
    }
    
    radio.array[ radio.array.size ] = origin5;
    
    if ( radio.array.size > 0 )
    {
        for ( i = 0; i < radio.array.size ; i++ )
        {
            level thread sndradiowait( radio.array[ i ], radio, is_sequential, i + 1 );
        }
    }
}

// Namespace zm_audio
// Params 4
// Checksum 0x840aa86b, Offset: 0x56b0
// Size: 0x244
function sndradiowait( origin, radio, is_sequential, num )
{
    temp_ent = spawn( "script_origin", origin );
    temp_ent thread secretuse( "sndRadioHit", ( 0, 0, 255 ), &sndradio_override, radio );
    temp_ent waittill( #"sndradiohit", player );
    
    if ( !( isdefined( is_sequential ) && is_sequential ) )
    {
        radionum = num;
    }
    else
    {
        radionum = radio.counter;
    }
    
    radioalias = radio.alias_prefix + radionum;
    radiolinecount = zm_spawner::get_number_variants( radioalias );
    
    if ( radiolinecount > 0 )
    {
        radio.isplaying = 1;
        
        for ( i = 0; i < radiolinecount ; i++ )
        {
            temp_ent playsound( radioalias + "_" + i );
            playbacktime = soundgetplaybacktime( radioalias + "_" + i );
            
            if ( !isdefined( playbacktime ) )
            {
                playbacktime = 1;
            }
            
            if ( playbacktime >= 0 )
            {
                playbacktime *= 0.001;
            }
            else
            {
                playbacktime = 1;
            }
            
            wait playbacktime;
        }
    }
    
    radio.counter++;
    radio.isplaying = 0;
    temp_ent delete();
}

// Namespace zm_audio
// Params 2
// Checksum 0xff325d57, Offset: 0x5900
// Size: 0x3c, Type: bool
function sndradio_override( arg1, arg2 )
{
    if ( isdefined( arg1 ) && arg1.isplaying == 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_audio
// Params 0
// Checksum 0xc1938ee9, Offset: 0x5948
// Size: 0xa0
function sndperksjingles_timer()
{
    self endon( #"death" );
    
    if ( isdefined( self.sndjinglecooldown ) )
    {
        self.sndjinglecooldown = 0;
    }
    
    while ( true )
    {
        wait randomfloatrange( 30, 60 );
        
        if ( randomintrange( 0, 100 ) <= 10 && !( isdefined( self.sndjinglecooldown ) && self.sndjinglecooldown ) )
        {
            self thread sndperksjingles_player( 0 );
        }
    }
}

// Namespace zm_audio
// Params 1
// Checksum 0x5ff07620, Offset: 0x59f0
// Size: 0x180
function sndperksjingles_player( type )
{
    self endon( #"death" );
    
    if ( !isdefined( self.sndjingleactive ) )
    {
        self.sndjingleactive = 0;
    }
    
    alias = self.script_sound;
    
    if ( type == 1 )
    {
        alias = self.script_label;
    }
    
    if ( isdefined( level.musicsystem ) && level.musicsystem.currentplaytype >= 4 )
    {
        return;
    }
    
    self.str_jingle_alias = alias;
    
    if ( !( isdefined( self.sndjingleactive ) && self.sndjingleactive ) )
    {
        self.sndjingleactive = 1;
        self playsoundwithnotify( alias, "sndDone" );
        playbacktime = soundgetplaybacktime( alias );
        
        if ( !isdefined( playbacktime ) || playbacktime <= 0 )
        {
            waittime = 1;
        }
        else
        {
            waittime = playbacktime * 0.001;
        }
        
        wait waittime;
        
        if ( type == 0 )
        {
            self.sndjinglecooldown = 1;
            self thread sndperksjingles_cooldown();
        }
        
        self.sndjingleactive = 0;
    }
}

// Namespace zm_audio
// Params 0
// Checksum 0x23dbbb7d, Offset: 0x5b78
// Size: 0x4c
function sndperksjingles_cooldown()
{
    self endon( #"death" );
    
    if ( isdefined( self.var_1afc1154 ) )
    {
        while ( isdefined( self.var_1afc1154 ) && self.var_1afc1154 )
        {
            wait 1;
        }
    }
    
    wait 45;
    self.sndjinglecooldown = 0;
}

// Namespace zm_audio
// Params 2
// Checksum 0x56ef71d6, Offset: 0x5bd0
// Size: 0x88
function sndconversation_init( name, specialendon )
{
    if ( !isdefined( specialendon ) )
    {
        specialendon = undefined;
    }
    
    if ( !isdefined( level.sndconversations ) )
    {
        level.sndconversations = array();
    }
    
    level.sndconversations[ name ] = spawnstruct();
    level.sndconversations[ name ].specialendon = specialendon;
}

// Namespace zm_audio
// Params 4
// Checksum 0xbb08d499, Offset: 0x5c60
// Size: 0x2a6
function sndconversation_addline( name, line, player_or_random, ignoreplayer )
{
    if ( !isdefined( ignoreplayer ) )
    {
        ignoreplayer = 5;
    }
    
    thisconvo = level.sndconversations[ name ];
    
    if ( !isdefined( thisconvo.line ) )
    {
        thisconvo.line = array();
    }
    
    if ( !isdefined( thisconvo.player ) )
    {
        thisconvo.player = array();
    }
    
    if ( !isdefined( thisconvo.ignoreplayer ) )
    {
        thisconvo.ignoreplayer = array();
    }
    
    if ( !isdefined( thisconvo.line ) )
    {
        thisconvo.line = [];
    }
    else if ( !isarray( thisconvo.line ) )
    {
        thisconvo.line = array( thisconvo.line );
    }
    
    thisconvo.line[ thisconvo.line.size ] = line;
    
    if ( !isdefined( thisconvo.player ) )
    {
        thisconvo.player = [];
    }
    else if ( !isarray( thisconvo.player ) )
    {
        thisconvo.player = array( thisconvo.player );
    }
    
    thisconvo.player[ thisconvo.player.size ] = player_or_random;
    
    if ( !isdefined( thisconvo.ignoreplayer ) )
    {
        thisconvo.ignoreplayer = [];
    }
    else if ( !isarray( thisconvo.ignoreplayer ) )
    {
        thisconvo.ignoreplayer = array( thisconvo.ignoreplayer );
    }
    
    thisconvo.ignoreplayer[ thisconvo.ignoreplayer.size ] = ignoreplayer;
}

// Namespace zm_audio
// Params 1
// Checksum 0xe1cbfcff, Offset: 0x5f10
// Size: 0x28e
function sndconversation_play( name )
{
    thisconvo = level.sndconversations[ name ];
    level endon( #"sndconvointerrupt" );
    
    if ( isdefined( thisconvo.specialendon ) )
    {
        level endon( thisconvo.specialendon );
    }
    
    while ( isanyonetalking() )
    {
        wait 0.5;
    }
    
    while ( isdefined( level.sndvoxoverride ) && level.sndvoxoverride )
    {
        wait 0.5;
    }
    
    level.sndvoxoverride = 1;
    
    for ( i = 0; i < thisconvo.line.size ; i++ )
    {
        if ( thisconvo.player[ i ] == 4 )
        {
            speaker = getrandomcharacter( thisconvo.ignoreplayer[ i ] );
        }
        else
        {
            speaker = getspecificcharacter( thisconvo.player[ i ] );
        }
        
        if ( !isdefined( speaker ) )
        {
            continue;
        }
        
        if ( iscurrentspeakerabletotalk( speaker ) )
        {
            level.currentconvoplayer = speaker;
            
            if ( isdefined( level.vox_name_complete ) )
            {
                level.currentconvoline = thisconvo.line[ i ];
            }
            else
            {
                level.currentconvoline = "vox_plr_" + speaker.characterindex + "_" + thisconvo.line[ i ];
                speaker thread sndconvointerrupt();
            }
            
            speaker playsoundontag( level.currentconvoline, "J_Head" );
            waitplaybacktime( level.currentconvoline );
            level notify( #"sndconvolinedone" );
        }
    }
    
    level.sndvoxoverride = 0;
    level notify( #"sndconversationdone" );
    level.currentconvoline = undefined;
    level.currentconvoplayer = undefined;
}

// Namespace zm_audio
// Params 0
// Checksum 0x66a509e0, Offset: 0x61a8
// Size: 0x76
function sndconvostopcurrentconversation()
{
    level notify( #"sndconvointerrupt" );
    level notify( #"sndconversationdone" );
    level.sndvoxoverride = 0;
    
    if ( isdefined( level.currentconvoplayer ) && isdefined( level.currentconvoline ) )
    {
        level.currentconvoplayer stopsound( level.currentconvoline );
        level.currentconvoline = undefined;
        level.currentconvoplayer = undefined;
    }
}

// Namespace zm_audio
// Params 1
// Checksum 0xb70cdcb5, Offset: 0x6228
// Size: 0x76
function waitplaybacktime( alias )
{
    playbacktime = soundgetplaybacktime( alias );
    
    if ( !isdefined( playbacktime ) )
    {
        playbacktime = 1;
    }
    
    if ( playbacktime >= 0 )
    {
        playbacktime *= 0.001;
    }
    else
    {
        playbacktime = 1;
    }
    
    wait playbacktime;
}

// Namespace zm_audio
// Params 1
// Checksum 0xe56ef69f, Offset: 0x62a8
// Size: 0x66, Type: bool
function iscurrentspeakerabletotalk( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( player.sessionstate != "playing" )
    {
        return false;
    }
    
    if ( isdefined( player.laststand ) && player.laststand )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_audio
// Params 1
// Checksum 0xc6c50b99, Offset: 0x6318
// Size: 0xc6
function getrandomcharacter( ignore )
{
    array = level.players;
    array::randomize( array );
    
    foreach ( guy in array )
    {
        if ( guy.characterindex == ignore )
        {
            continue;
        }
        
        return guy;
    }
    
    return undefined;
}

// Namespace zm_audio
// Params 1
// Checksum 0x906df99b, Offset: 0x63e8
// Size: 0x9a
function getspecificcharacter( charindex )
{
    foreach ( guy in level.players )
    {
        if ( guy.characterindex == charindex )
        {
            return guy;
        }
    }
    
    return undefined;
}

// Namespace zm_audio
// Params 0
// Checksum 0x91cf5572, Offset: 0x6490
// Size: 0xa0, Type: bool
function isanyonetalking()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player.isspeaking ) && player.isspeaking )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_audio
// Params 0
// Checksum 0xd181a787, Offset: 0x6538
// Size: 0x14c
function sndconvointerrupt()
{
    level endon( #"sndconvolinedone" );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        max_dist_squared = 0;
        check_pos = self.origin;
        count = 0;
        
        foreach ( player in level.players )
        {
            if ( self == player )
            {
                continue;
            }
            
            if ( distance2dsquared( player.origin, self.origin ) >= 810000 )
            {
                count++;
            }
        }
        
        if ( count == level.players.size - 1 )
        {
            break;
        }
        
        wait 0.25;
    }
    
    level thread sndconvostopcurrentconversation();
}

// Namespace zm_audio
// Params 0
// Checksum 0x7ba90ecd, Offset: 0x6690
// Size: 0x16c
function water_vox()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"end_game" );
    self.voxunderwatertime = 0;
    self.voxemergebreath = 0;
    self.voxdrowning = 0;
    
    while ( true )
    {
        if ( self isplayerunderwater() )
        {
            if ( !self.voxunderwatertime && !self.voxemergebreath )
            {
                self vo_clear_underwater();
                self.voxunderwatertime = gettime();
            }
            else if ( self.voxunderwatertime )
            {
                if ( gettime() > self.voxunderwatertime + 3000 )
                {
                    self.voxunderwatertime = 0;
                    self.voxemergebreath = 1;
                }
            }
        }
        else
        {
            if ( self.voxdrowning )
            {
                self playerexert( "underwater_gasp" );
                self.voxdrowning = 0;
                self.voxemergebreath = 0;
            }
            
            if ( self.voxemergebreath )
            {
                self playerexert( "underwater_emerge" );
                self.voxemergebreath = 0;
            }
            else
            {
                self.voxunderwatertime = 0;
            }
        }
        
        wait 0.05;
    }
}

// Namespace zm_audio
// Params 0
// Checksum 0x3977f264, Offset: 0x6808
// Size: 0x1a4
function vo_clear_underwater()
{
    if ( level flag::exists( "abcd_speaking" ) )
    {
        if ( level flag::get( "abcd_speaking" ) )
        {
            return;
        }
    }
    
    if ( level flag::exists( "shadowman_speaking" ) )
    {
        if ( level flag::get( "shadowman_speaking" ) )
        {
            return;
        }
    }
    
    self stopsounds();
    self notify( #"stop_vo_convo" );
    self.str_vo_being_spoken = "";
    self.n_vo_priority = 0;
    self.isspeaking = 0;
    level.sndvoxoverride = 0;
    b_in_a_e_speakers = 0;
    
    foreach ( e_checkme in level.a_e_speakers )
    {
        if ( e_checkme == self )
        {
            b_in_a_e_speakers = 1;
            break;
        }
    }
    
    if ( isdefined( b_in_a_e_speakers ) && b_in_a_e_speakers )
    {
        arrayremovevalue( level.a_e_speakers, self );
    }
}

// Namespace zm_audio
// Params 4
// Checksum 0xee82d5d8, Offset: 0x69b8
// Size: 0xcc
function sndplayerhitalert( e_victim, str_meansofdeath, e_inflictor, weapon )
{
    if ( !( isdefined( level.sndzhdaudio ) && level.sndzhdaudio ) )
    {
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !checkforvalidmod( str_meansofdeath ) )
    {
        return;
    }
    
    if ( !checkforvalidweapon( weapon ) )
    {
        return;
    }
    
    if ( !checkforvalidaitype( e_victim ) )
    {
        return;
    }
    
    str_alias = "zmb_hit_alert";
    self thread sndplayerhitalert_playsound( str_alias );
}

// Namespace zm_audio
// Params 1
// Checksum 0x52736e3, Offset: 0x6a90
// Size: 0x58
function sndplayerhitalert_playsound( str_alias )
{
    self endon( #"disconnect" );
    
    if ( self.hitsoundtracker )
    {
        self.hitsoundtracker = 0;
        self playsoundtoplayer( str_alias, self );
        wait 0.05;
        self.hitsoundtracker = 1;
    }
}

// Namespace zm_audio
// Params 1
// Checksum 0xe1a1b2d1, Offset: 0x6af0
// Size: 0x28, Type: bool
function checkforvalidmod( str_meansofdeath )
{
    if ( !isdefined( str_meansofdeath ) )
    {
        return false;
    }
    
    switch ( str_meansofdeath )
    {
        case "MOD_CRUSH":
        case "MOD_GRENADE_SPLASH":
        case "MOD_HIT_BY_OBJECT":
        case "MOD_MELEE":
        case "MOD_MELEE_ASSASSINATE":
        default:
            return false;
    }
}

// Namespace zm_audio
// Params 1
// Checksum 0x472cce52, Offset: 0x6b60
// Size: 0x10, Type: bool
function checkforvalidweapon( weapon )
{
    return true;
}

// Namespace zm_audio
// Params 1
// Checksum 0x9e8fbc95, Offset: 0x6b78
// Size: 0x10, Type: bool
function checkforvalidaitype( e_victim )
{
    return true;
}

