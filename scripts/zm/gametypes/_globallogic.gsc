#using scripts/codescripts/struct;
#using scripts/shared/bb_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/medals_shared;
#using scripts/shared/music_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/simple_hostmigration;
#using scripts/shared/tweakables_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_challenges;
#using scripts/zm/_rat;
#using scripts/zm/_util;
#using scripts/zm/gametypes/_dev;
#using scripts/zm/gametypes/_globallogic_audio;
#using scripts/zm/gametypes/_globallogic_defaults;
#using scripts/zm/gametypes/_globallogic_player;
#using scripts/zm/gametypes/_globallogic_score;
#using scripts/zm/gametypes/_globallogic_spawn;
#using scripts/zm/gametypes/_globallogic_ui;
#using scripts/zm/gametypes/_globallogic_utils;
#using scripts/zm/gametypes/_hostmigration;
#using scripts/zm/gametypes/_hud_message;
#using scripts/zm/gametypes/_spawnlogic;
#using scripts/zm/gametypes/_weapon_utils;
#using scripts/zm/gametypes/_weaponobjects;
#using scripts/zm/gametypes/_weapons;

#namespace globallogic;

// Namespace globallogic
// Params 0
// Checksum 0x77414df0, Offset: 0x1268
// Size: 0x7e4
function init()
{
    level.language = getdvarstring( "language" );
    level.splitscreen = issplitscreen();
    level.xenon = getdvarstring( "xenonGame" ) == "true";
    level.ps3 = getdvarstring( "ps3Game" ) == "true";
    level.wiiu = getdvarstring( "wiiuGame" ) == "true";
    level.orbis = getdvarstring( "orbisGame" ) == "true";
    level.durango = getdvarstring( "durangoGame" ) == "true";
    level.createfx_disable_fx = getdvarint( "disable_fx" ) == 1;
    level.onlinegame = sessionmodeisonlinegame();
    level.systemlink = sessionmodeissystemlink();
    level.console = level.xenon || level.ps3 || level.wiiu || level.orbis || level.durango;
    level.rankedmatch = gamemodeisusingxp();
    level.leaguematch = 0;
    level.arenamatch = 0;
    level.wagermatch = 0;
    level.contractsenabled = !getgametypesetting( "disableContracts" );
    level.contractsenabled = 0;
    
    /#
        if ( getdvarint( "<dev string:x28>" ) == 1 )
        {
            level.rankedmatch = 1;
        }
    #/
    
    level.script = tolower( getdvarstring( "mapname" ) );
    level.gametype = tolower( getdvarstring( "g_gametype" ) );
    level.teambased = 0;
    level.teamcount = getgametypesetting( "teamCount" );
    level.multiteam = level.teamcount > 2;
    
    if ( sessionmodeiszombiesgame() )
    {
        level.zombie_team_index = level.teamcount + 1;
        
        if ( 2 == level.zombie_team_index )
        {
            level.zombie_team = "axis";
        }
        else
        {
            level.zombie_team = "team" + level.zombie_team_index;
        }
    }
    
    level.teams = [];
    level.teamindex = [];
    teamcount = level.teamcount;
    level.teams[ "allies" ] = "allies";
    level.teams[ "axis" ] = "axis";
    level.teamindex[ "neutral" ] = 0;
    level.teamindex[ "allies" ] = 1;
    level.teamindex[ "axis" ] = 2;
    
    for ( teamindex = 3; teamindex <= teamcount ; teamindex++ )
    {
        level.teams[ "team" + teamindex ] = "team" + teamindex;
        level.teamindex[ "team" + teamindex ] = teamindex;
    }
    
    level.overrideteamscore = 0;
    level.overrideplayerscore = 0;
    level.displayhalftimetext = 0;
    level.displayroundendtext = 1;
    level.endgameonscorelimit = 1;
    level.endgameontimelimit = 1;
    level.scoreroundwinbased = 0;
    level.resetplayerscoreeveryround = 0;
    level.gameforfeited = 0;
    level.forceautoassign = 0;
    level.halftimetype = "halftime";
    level.halftimesubcaption = &"MP_SWITCHING_SIDES_CAPS";
    level.laststatustime = 0;
    level.waswinning = [];
    level.lastslowprocessframe = 0;
    level.placement = [];
    
    foreach ( team in level.teams )
    {
        level.placement[ team ] = [];
    }
    
    level.placement[ "all" ] = [];
    level.postroundtime = 7;
    level.inovertime = 0;
    level.defaultoffenseradius = 560;
    level.dropteam = getdvarint( "sv_maxclients" );
    level.infinalkillcam = 0;
    registerdvars();
    level.oldschool = getdvarint( "scr_oldschool" ) == 1;
    
    if ( level.oldschool )
    {
        /#
            print( "<dev string:x3d>" );
        #/
        
        setdvar( "jump_height", 64 );
        setdvar( "jump_slowdownEnable", 0 );
        setdvar( "bg_fallDamageMinHeight", 256 );
        setdvar( "bg_fallDamageMaxHeight", 512 );
        setdvar( "player_clipSizeMultiplier", 2 );
    }
    
    precache_mp_leaderboards();
    
    if ( !isdefined( game[ "tiebreaker" ] ) )
    {
        game[ "tiebreaker" ] = 0;
    }
    
    globallogic_audio::registerdialoggroup( "item_destroyed", 1 );
    globallogic_audio::registerdialoggroup( "introboost", 1 );
    globallogic_audio::registerdialoggroup( "status", 1 );
    level.playersdrivingvehiclesbecomeinvulnerable = 1;
    level.figure_out_attacker = &globallogic_player::figureoutattacker;
    level.figure_out_friendly_fire = &globallogic_player::figureoutfriendlyfire;
    level.get_base_weapon_param = &weapon_utils::getbaseweaponparam;
}

// Namespace globallogic
// Params 0
// Checksum 0x1122d582, Offset: 0x1a58
// Size: 0x1ac
function registerdvars()
{
    if ( getdvarstring( "scr_oldschool" ) == "" )
    {
        setdvar( "scr_oldschool", "0" );
    }
    
    if ( getdvarstring( "ui_guncycle" ) == "" )
    {
        setdvar( "ui_guncycle", 0 );
    }
    
    if ( getdvarstring( "ui_weapon_tiers" ) == "" )
    {
        setdvar( "ui_weapon_tiers", 0 );
    }
    
    setdvar( "ui_text_endreason", "" );
    setmatchflag( "bomb_timer", 0 );
    
    if ( getdvarstring( "scr_vehicle_damage_scalar" ) == "" )
    {
        setdvar( "scr_vehicle_damage_scalar", "1" );
    }
    
    level.vehicledamagescalar = getdvarfloat( "scr_vehicle_damage_scalar" );
    level.fire_audio_repeat_duration = getdvarint( "fire_audio_repeat_duration" );
    level.fire_audio_random_max_duration = getdvarint( "fire_audio_random_max_duration" );
}

// Namespace globallogic
// Params 10
// Checksum 0x46187fd1, Offset: 0x1c10
// Size: 0x54
function blank( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 )
{
    
}

// Namespace globallogic
// Params 0
// Checksum 0x5f32b867, Offset: 0x1c70
// Size: 0x474
function setupcallbacks()
{
    level.spawnplayer = &globallogic_spawn::spawnplayer;
    level.spawnplayerprediction = &globallogic_spawn::spawnplayerprediction;
    level.spawnclient = &globallogic_spawn::spawnclient;
    level.spawnspectator = &globallogic_spawn::spawnspectator;
    level.spawnintermission = &globallogic_spawn::spawnintermission;
    level.scoreongiveplayerscore = &globallogic_score::giveplayerscore;
    level.onplayerscore = &globallogic_score::default_onplayerscore;
    level.onteamscore = &globallogic_score::default_onteamscore;
    level.wavespawntimer = &wavespawntimer;
    level.spawnmessage = &globallogic_spawn::default_spawnmessage;
    level.onspawnplayer = &blank;
    level.onspawnplayerunified = &blank;
    level.onspawnspectator = &globallogic_defaults::default_onspawnspectator;
    level.onspawnintermission = &globallogic_defaults::default_onspawnintermission;
    level.onrespawndelay = &blank;
    level.onforfeit = &globallogic_defaults::default_onforfeit;
    level.ontimelimit = &globallogic_defaults::default_ontimelimit;
    level.onscorelimit = &globallogic_defaults::default_onscorelimit;
    level.onalivecountchange = &globallogic_defaults::default_onalivecountchange;
    level.ondeadevent = &globallogic_defaults::default_ondeadevent;
    level.ononeleftevent = &globallogic_defaults::default_ononeleftevent;
    level.giveteamscore = &globallogic_score::giveteamscore;
    level.onlastteamaliveevent = undefined;
    level.gettimepassed = &globallogic_utils::gettimepassed;
    level.gettimelimit = &globallogic_defaults::default_gettimelimit;
    level.getteamkillpenalty = &blank;
    level.getteamkillscore = &blank;
    level.iskillboosting = &globallogic_score::default_iskillboosting;
    level._setteamscore = &globallogic_score::_setteamscore;
    level._setplayerscore = &globallogic_score::_setplayerscore;
    level._getteamscore = &globallogic_score::_getteamscore;
    level._getplayerscore = &globallogic_score::_getplayerscore;
    level.onprecachegametype = &blank;
    level.onstartgametype = &blank;
    level.onplayerconnect = &blank;
    level.onplayerdisconnect = &blank;
    level.onplayerdamage = &blank;
    level.onplayerkilled = &blank;
    level.onplayerkilledextraunthreadedcbs = [];
    level.onteamoutcomenotify = &hud_message::teamoutcomenotify;
    level.onoutcomenotify = &hud_message::outcomenotify;
    level.onteamwageroutcomenotify = &hud_message::teamwageroutcomenotify;
    level.onwageroutcomenotify = &hud_message::wageroutcomenotify;
    level.setmatchscorehudelemforteam = &hud_message::setmatchscorehudelemforteam;
    level.onendgame = &blank;
    level.onroundendgame = &globallogic_defaults::default_onroundendgame;
    level.onmedalawarded = &blank;
    level.dogmanagerongetdogs = &blank;
    globallogic_ui::setupcallbacks();
}

// Namespace globallogic
// Params 0
// Checksum 0x1a3fe2ad, Offset: 0x20f0
// Size: 0x104
function precache_mp_leaderboards()
{
    if ( sessionmodeiszombiesgame() )
    {
        return;
    }
    
    if ( !level.rankedmatch )
    {
        return;
    }
    
    mapname = getdvarstring( "mapname" );
    globalleaderboards = "LB_MP_GB_XPPRESTIGE LB_MP_GB_TOTALXP_AT LB_MP_GB_TOTALXP_LT LB_MP_GB_WINS_AT LB_MP_GB_WINS_LT LB_MP_GB_KILLS_AT LB_MP_GB_KILLS_LT LB_MP_GB_ACCURACY_AT LB_MP_GB_ACCURACY_LT";
    gamemodeleaderboard = " LB_MP_GM_" + level.gametype;
    
    if ( getdvarint( "g_hardcore" ) )
    {
        gamemodeleaderboard += "_HC";
    }
    
    mapleaderboard = " LB_MP_MAP_" + getsubstr( mapname, 3, mapname.size );
    precacheleaderboards( globalleaderboards + gamemodeleaderboard + mapleaderboard );
}

// Namespace globallogic
// Params 4
// Checksum 0x3e523075, Offset: 0x2200
// Size: 0xe6
function compareteambygamestat( gamestat, teama, teamb, previous_winner_score )
{
    winner = undefined;
    
    if ( teama == "tie" )
    {
        winner = "tie";
        
        if ( previous_winner_score < game[ gamestat ][ teamb ] )
        {
            winner = teamb;
        }
    }
    else if ( game[ gamestat ][ teama ] == game[ gamestat ][ teamb ] )
    {
        winner = "tie";
    }
    else if ( game[ gamestat ][ teamb ] > game[ gamestat ][ teama ] )
    {
        winner = teamb;
    }
    else
    {
        winner = teama;
    }
    
    return winner;
}

// Namespace globallogic
// Params 1
// Checksum 0xf3cef4ba, Offset: 0x22f0
// Size: 0xe2
function determineteamwinnerbygamestat( gamestat )
{
    teamkeys = getarraykeys( level.teams );
    winner = teamkeys[ 0 ];
    previous_winner_score = game[ gamestat ][ winner ];
    
    for ( teamindex = 1; teamindex < teamkeys.size ; teamindex++ )
    {
        winner = compareteambygamestat( gamestat, winner, teamkeys[ teamindex ], previous_winner_score );
        
        if ( winner != "tie" )
        {
            previous_winner_score = game[ gamestat ][ winner ];
        }
    }
    
    return winner;
}

// Namespace globallogic
// Params 3
// Checksum 0x108ccfba, Offset: 0x23e0
// Size: 0xee
function compareteambyteamscore( teama, teamb, previous_winner_score )
{
    winner = undefined;
    teambscore = [[ level._getteamscore ]]( teamb );
    
    if ( teama == "tie" )
    {
        winner = "tie";
        
        if ( previous_winner_score < teambscore )
        {
            winner = teamb;
        }
        
        return winner;
    }
    
    teamascore = [[ level._getteamscore ]]( teama );
    
    if ( teambscore == teamascore )
    {
        winner = "tie";
    }
    else if ( teambscore > teamascore )
    {
        winner = teamb;
    }
    else
    {
        winner = teama;
    }
    
    return winner;
}

// Namespace globallogic
// Params 0
// Checksum 0xf50ae9d5, Offset: 0x24d8
// Size: 0xde
function determineteamwinnerbyteamscore()
{
    teamkeys = getarraykeys( level.teams );
    winner = teamkeys[ 0 ];
    previous_winner_score = [[ level._getteamscore ]]( winner );
    
    for ( teamindex = 1; teamindex < teamkeys.size ; teamindex++ )
    {
        winner = compareteambyteamscore( winner, teamkeys[ teamindex ], previous_winner_score );
        
        if ( winner != "tie" )
        {
            previous_winner_score = [[ level._getteamscore ]]( winner );
        }
    }
    
    return winner;
}

// Namespace globallogic
// Params 1
// Checksum 0x7c74e04d, Offset: 0x25c0
// Size: 0x1b4
function forceend( hostsucks )
{
    if ( !isdefined( hostsucks ) )
    {
        hostsucks = 0;
    }
    
    if ( level.hostforcedend || level.forcedend )
    {
        return;
    }
    
    winner = undefined;
    
    if ( level.teambased )
    {
        winner = determineteamwinnerbygamestat( "teamScores" );
        globallogic_utils::logteamwinstring( "host ended game", winner );
    }
    else
    {
        winner = globallogic_score::gethighestscoringplayer();
        
        /#
            if ( isdefined( winner ) )
            {
                print( "<dev string:x52>" + winner.name );
            }
            else
            {
                print( "<dev string:x69>" );
            }
        #/
    }
    
    level.forcedend = 1;
    level.hostforcedend = 1;
    
    if ( hostsucks )
    {
        endstring = &"MP_HOST_SUCKS";
    }
    else if ( level.splitscreen )
    {
        endstring = &"MP_ENDED_GAME";
    }
    else
    {
        endstring = &"MP_HOST_ENDED_GAME";
    }
    
    setmatchflag( "disableIngameMenu", 1 );
    setdvar( "ui_text_endreason", endstring );
    thread endgame( winner, endstring );
}

// Namespace globallogic
// Params 0
// Checksum 0xef37a8ad, Offset: 0x2780
// Size: 0x14c
function killserverpc()
{
    if ( level.hostforcedend || level.forcedend )
    {
        return;
    }
    
    winner = undefined;
    
    if ( level.teambased )
    {
        winner = determineteamwinnerbygamestat( "teamScores" );
        globallogic_utils::logteamwinstring( "host ended game", winner );
    }
    else
    {
        winner = globallogic_score::gethighestscoringplayer();
        
        /#
            if ( isdefined( winner ) )
            {
                print( "<dev string:x52>" + winner.name );
            }
            else
            {
                print( "<dev string:x69>" );
            }
        #/
    }
    
    level.forcedend = 1;
    level.hostforcedend = 1;
    level.killserver = 1;
    endstring = &"MP_HOST_ENDED_GAME";
    println( "<dev string:x7e>" );
    thread endgame( winner, endstring );
}

// Namespace globallogic
// Params 0
// Checksum 0x88491e33, Offset: 0x28d8
// Size: 0x92, Type: bool
function someoneoneachteam()
{
    foreach ( team in level.teams )
    {
        if ( level.playercount[ team ] == 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace globallogic
// Params 1
// Checksum 0xf80f9dd, Offset: 0x2978
// Size: 0x5a, Type: bool
function checkifteamforfeits( team )
{
    if ( !level.everexisted[ team ] )
    {
        return false;
    }
    
    if ( level.playercount[ team ] < 1 && util::totalplayercount() > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace globallogic
// Params 0
// Checksum 0x764f3f11, Offset: 0x29e0
// Size: 0xa6, Type: bool
function checkforanyteamforfeit()
{
    foreach ( team in level.teams )
    {
        if ( checkifteamforfeits( team ) )
        {
            thread [[ level.onforfeit ]]( team );
            return true;
        }
    }
    
    return false;
}

// Namespace globallogic
// Params 0
// Checksum 0x757a8050, Offset: 0x2a90
// Size: 0x9a
function dospawnqueueupdates()
{
    foreach ( team in level.teams )
    {
        if ( level.spawnqueuemodified[ team ] )
        {
            [[ level.onalivecountchange ]]( team );
        }
    }
}

// Namespace globallogic
// Params 1
// Checksum 0xf3dece44, Offset: 0x2b38
// Size: 0x3e, Type: bool
function isteamalldead( team )
{
    return level.everexisted[ team ] && !level.alivecount[ team ] && !level.playerlives[ team ];
}

// Namespace globallogic
// Params 0
// Checksum 0x4a5686a4, Offset: 0x2b80
// Size: 0x94, Type: bool
function areallteamsdead()
{
    foreach ( team in level.teams )
    {
        if ( !isteamalldead( team ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace globallogic
// Params 0
// Checksum 0x14e870b1, Offset: 0x2c20
// Size: 0xa6
function alldeadteamcount()
{
    count = 0;
    
    foreach ( team in level.teams )
    {
        if ( isteamalldead( team ) )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace globallogic
// Params 0
// Checksum 0x9965d25e, Offset: 0x2cd0
// Size: 0x224, Type: bool
function dodeadeventupdates()
{
    if ( level.teambased )
    {
        if ( areallteamsdead() )
        {
            [[ level.ondeadevent ]]( "all" );
            return true;
        }
        
        if ( isdefined( level.onlastteamaliveevent ) )
        {
            if ( alldeadteamcount() == level.teams.size - 1 )
            {
                foreach ( team in level.teams )
                {
                    if ( !isteamalldead( team ) )
                    {
                        [[ level.onlastteamaliveevent ]]( team );
                        return true;
                    }
                }
            }
        }
        else
        {
            foreach ( team in level.teams )
            {
                if ( isteamalldead( team ) )
                {
                    [[ level.ondeadevent ]]( team );
                    return true;
                }
            }
        }
    }
    else if ( totalalivecount() == 0 && totalplayerlives() == 0 && level.maxplayercount > 1 )
    {
        [[ level.ondeadevent ]]( "all" );
        return true;
    }
    
    return false;
}

// Namespace globallogic
// Params 1
// Checksum 0xfff5424a, Offset: 0x2f00
// Size: 0x4e, Type: bool
function isonlyoneleftaliveonteam( team )
{
    return level.lastalivecount[ team ] > 1 && level.alivecount[ team ] == 1 && level.playerlives[ team ] == 1;
}

// Namespace globallogic
// Params 0
// Checksum 0x771a1452, Offset: 0x2f58
// Size: 0x11c, Type: bool
function doonelefteventupdates()
{
    if ( level.teambased )
    {
        foreach ( team in level.teams )
        {
            if ( isonlyoneleftaliveonteam( team ) )
            {
                [[ level.ononeleftevent ]]( team );
                return true;
            }
        }
    }
    else if ( totalalivecount() == 1 && totalplayerlives() == 1 && level.maxplayercount > 1 )
    {
        [[ level.ononeleftevent ]]( "all" );
        return true;
    }
    
    return false;
}

// Namespace globallogic
// Params 0
// Checksum 0x79b2de8b, Offset: 0x3080
// Size: 0x1e0
function updategameevents()
{
    /#
        if ( getdvarint( "<dev string:x98>" ) == 1 )
        {
            return;
        }
    #/
    
    if ( ( level.rankedmatch || level.wagermatch || level.leaguematch ) && !level.ingraceperiod )
    {
        if ( level.teambased )
        {
            if ( !level.gameforfeited )
            {
                if ( game[ "state" ] == "playing" && checkforanyteamforfeit() )
                {
                    return;
                }
            }
            else if ( someoneoneachteam() )
            {
                level.gameforfeited = 0;
                level notify( #"hash_577494dc" );
            }
        }
        else if ( !level.gameforfeited )
        {
            if ( util::totalplayercount() == 1 && level.maxplayercount > 1 )
            {
                thread [[ level.onforfeit ]]();
                return;
            }
        }
        else if ( util::totalplayercount() > 1 )
        {
            level.gameforfeited = 0;
            level notify( #"hash_577494dc" );
        }
    }
    
    if ( !level.playerqueuedrespawn && !level.numlives && !level.inovertime )
    {
        return;
    }
    
    if ( level.ingraceperiod )
    {
        return;
    }
    
    if ( level.playerqueuedrespawn )
    {
        dospawnqueueupdates();
    }
    
    if ( dodeadeventupdates() )
    {
        return;
    }
    
    if ( doonelefteventupdates() )
    {
        return;
    }
}

// Namespace globallogic
// Params 0
// Checksum 0x374702e7, Offset: 0x3268
// Size: 0x2cc
function matchstarttimer()
{
    matchstarttext = hud::createserverfontstring( "objective", 1.5 );
    matchstarttext hud::setpoint( "CENTER", "CENTER", 0, -40 );
    matchstarttext.sort = 1001;
    matchstarttext settext( game[ "strings" ][ "waiting_for_teams" ] );
    matchstarttext.foreground = 0;
    matchstarttext.hidewheninmenu = 1;
    waitforplayers();
    matchstarttext settext( game[ "strings" ][ "match_starting_in" ] );
    matchstarttimer = hud::createserverfontstring( "objective", 2.2 );
    matchstarttimer hud::setpoint( "CENTER", "CENTER", 0, 0 );
    matchstarttimer.sort = 1001;
    matchstarttimer.color = ( 1, 1, 0 );
    matchstarttimer.foreground = 0;
    matchstarttimer.hidewheninmenu = 1;
    counttime = int( level.prematchperiod );
    
    if ( counttime >= 2 )
    {
        while ( counttime > 0 && !level.gameended )
        {
            matchstarttimer setvalue( counttime );
            
            if ( counttime == 2 )
            {
                visionsetnaked( getdvarstring( "mapname" ), 3 );
            }
            
            counttime--;
            wait 1;
        }
    }
    else
    {
        visionsetnaked( getdvarstring( "mapname" ), 1 );
    }
    
    matchstarttimer hud::destroyelem();
    matchstarttext hud::destroyelem();
}

// Namespace globallogic
// Params 0
// Checksum 0x5b3d11ae, Offset: 0x3540
// Size: 0x34
function matchstarttimerskip()
{
    visionsetnaked( getdvarstring( "mapname" ), 0 );
}

// Namespace globallogic
// Params 2
// Checksum 0x41b6e911, Offset: 0x3580
// Size: 0x76
function notifyteamwavespawn( team, time )
{
    if ( time - level.lastwave[ team ] > level.wavedelay[ team ] * 1000 )
    {
        level notify( "wave_respawn_" + team );
        level.lastwave[ team ] = time;
        level.waveplayerspawnindex[ team ] = 0;
    }
}

// Namespace globallogic
// Params 0
// Checksum 0xdae4facd, Offset: 0x3600
// Size: 0xd0
function wavespawntimer()
{
    level endon( #"game_ended" );
    
    while ( game[ "state" ] == "playing" )
    {
        time = gettime();
        
        foreach ( team in level.teams )
        {
            notifyteamwavespawn( team, time );
        }
        
        wait 0.05;
    }
}

// Namespace globallogic
// Params 0
// Checksum 0xf83b0b9b, Offset: 0x36d8
// Size: 0xa2, Type: bool
function hostidledout()
{
    hostplayer = util::gethostplayer();
    
    /#
        if ( getdvarint( "<dev string:xae>" ) == 1 || getdvarint( "<dev string:x98>" ) == 1 )
        {
            return false;
        }
    #/
    
    if ( isdefined( hostplayer ) && !hostplayer.hasspawned && !isdefined( hostplayer.selectedclass ) )
    {
        return true;
    }
    
    return false;
}

// Namespace globallogic
// Params 3
// Checksum 0x564e3f0e, Offset: 0x3788
// Size: 0x54
function incrementmatchcompletionstat( gamemode, playedorhosted, stat )
{
    self adddstat( "gameHistory", gamemode, "modeHistory", playedorhosted, stat, 1 );
}

// Namespace globallogic
// Params 3
// Checksum 0x7258b17e, Offset: 0x37e8
// Size: 0x54
function setmatchcompletionstat( gamemode, playedorhosted, stat )
{
    self setdstat( "gameHistory", gamemode, "modeHistory", playedorhosted, stat, 1 );
}

// Namespace globallogic
// Params 2
// Checksum 0x207ae4ac, Offset: 0x3848
// Size: 0x2f4
function displayroundend( winner, endreasontext )
{
    if ( level.displayroundendtext )
    {
        if ( winner == "tie" )
        {
            demo::gameresultbookmark( "round_result", level.teamindex[ "neutral" ], level.teamindex[ "neutral" ] );
        }
        else
        {
            demo::gameresultbookmark( "round_result", level.teamindex[ winner ], level.teamindex[ "neutral" ] );
        }
        
        setmatchflag( "cg_drawSpectatorMessages", 0 );
        players = level.players;
        
        for ( index = 0; index < players.size ; index++ )
        {
            player = players[ index ];
            
            if ( !isdefined( player.pers[ "team" ] ) )
            {
                player [[ level.spawnintermission ]]( 1 );
                player closeingamemenu();
                continue;
            }
            
            if ( level.wagermatch )
            {
                if ( level.teambased )
                {
                    player thread [[ level.onteamwageroutcomenotify ]]( winner, 1, endreasontext );
                }
                else
                {
                    player thread [[ level.onwageroutcomenotify ]]( winner, endreasontext );
                }
            }
            else if ( level.teambased )
            {
                player thread [[ level.onteamoutcomenotify ]]( winner, 1, endreasontext );
                player globallogic_audio::set_music_on_player( "ROUND_END" );
            }
            else
            {
                player thread [[ level.onoutcomenotify ]]( winner, 1, endreasontext );
                player globallogic_audio::set_music_on_player( "ROUND_END" );
            }
            
            player setclientuivisibilityflag( "hud_visible", 0 );
            player setclientuivisibilityflag( "g_compassShowEnemies", 0 );
        }
    }
    
    if ( util::waslastround() )
    {
        roundendwait( level.roundenddelay, 0 );
        return;
    }
    
    thread globallogic_audio::announceroundwinner( winner, level.roundenddelay / 4 );
    roundendwait( level.roundenddelay, 1 );
}

// Namespace globallogic
// Params 2
// Checksum 0x1453a835, Offset: 0x3b48
// Size: 0x2a4
function displayroundswitch( winner, endreasontext )
{
    switchtype = level.halftimetype;
    
    if ( switchtype == "halftime" )
    {
        if ( isdefined( level.nextroundisovertime ) && level.nextroundisovertime )
        {
            switchtype = "overtime";
        }
        else if ( level.roundlimit )
        {
            if ( game[ "roundsplayed" ] * 2 == level.roundlimit )
            {
                switchtype = "halftime";
            }
            else
            {
                switchtype = "intermission";
            }
        }
        else if ( level.scorelimit )
        {
            if ( game[ "roundsplayed" ] == level.scorelimit - 1 )
            {
                switchtype = "halftime";
            }
            else
            {
                switchtype = "intermission";
            }
        }
        else
        {
            switchtype = "intermission";
        }
    }
    
    leaderdialog = globallogic_audio::getroundswitchdialog( switchtype );
    setmatchtalkflag( "EveryoneHearsEveryone", 1 );
    players = level.players;
    
    for ( index = 0; index < players.size ; index++ )
    {
        player = players[ index ];
        
        if ( !isdefined( player.pers[ "team" ] ) )
        {
            player [[ level.spawnintermission ]]( 1 );
            player closeingamemenu();
            continue;
        }
        
        player globallogic_audio::leaderdialogonplayer( leaderdialog );
        player globallogic_audio::set_music_on_player( "ROUND_SWITCH" );
        
        if ( level.wagermatch )
        {
            player thread [[ level.onteamwageroutcomenotify ]]( switchtype, 1, level.halftimesubcaption );
        }
        else
        {
            player thread [[ level.onteamoutcomenotify ]]( switchtype, 0, level.halftimesubcaption );
        }
        
        player setclientuivisibilityflag( "hud_visible", 0 );
    }
    
    roundendwait( level.halftimeroundenddelay, 0 );
}

// Namespace globallogic
// Params 2
// Checksum 0xa7c46e30, Offset: 0x3df8
// Size: 0x484
function displaygameend( winner, endreasontext )
{
    setmatchtalkflag( "EveryoneHearsEveryone", 1 );
    setmatchflag( "cg_drawSpectatorMessages", 0 );
    
    if ( winner == "tie" )
    {
        demo::gameresultbookmark( "game_result", level.teamindex[ "neutral" ], level.teamindex[ "neutral" ] );
    }
    else
    {
        demo::gameresultbookmark( "game_result", level.teamindex[ winner ], level.teamindex[ "neutral" ] );
    }
    
    players = level.players;
    
    for ( index = 0; index < players.size ; index++ )
    {
        player = players[ index ];
        
        if ( !isdefined( player.pers[ "team" ] ) )
        {
            player [[ level.spawnintermission ]]( 1 );
            player closeingamemenu();
            continue;
        }
        
        if ( level.wagermatch )
        {
            if ( level.teambased )
            {
                player thread [[ level.onteamwageroutcomenotify ]]( winner, 0, endreasontext );
            }
            else
            {
                player thread [[ level.onwageroutcomenotify ]]( winner, endreasontext );
            }
        }
        else if ( level.teambased )
        {
            player thread [[ level.onteamoutcomenotify ]]( winner, 0, endreasontext );
        }
        else
        {
            player thread [[ level.onoutcomenotify ]]( winner, 0, endreasontext );
            
            if ( isdefined( winner ) && player == winner )
            {
                player globallogic_audio::set_music_on_player( "VICTORY" );
            }
            else if ( !level.splitscreen )
            {
                player globallogic_audio::set_music_on_player( "LOSE" );
            }
        }
        
        player setclientuivisibilityflag( "hud_visible", 0 );
        player setclientuivisibilityflag( "g_compassShowEnemies", 0 );
    }
    
    if ( level.teambased )
    {
        thread globallogic_audio::announcegamewinner( winner, level.postroundtime / 2 );
        players = level.players;
        
        for ( index = 0; index < players.size ; index++ )
        {
            player = players[ index ];
            team = player.pers[ "team" ];
            
            if ( level.splitscreen )
            {
                if ( winner == "tie" )
                {
                    player globallogic_audio::set_music_on_player( "DRAW" );
                }
                else if ( winner == team )
                {
                    player globallogic_audio::set_music_on_player( "VICTORY" );
                }
                else
                {
                    player globallogic_audio::set_music_on_player( "LOSE" );
                }
                
                continue;
            }
            
            if ( winner == "tie" )
            {
                player globallogic_audio::set_music_on_player( "DRAW" );
                continue;
            }
            
            if ( winner == team )
            {
                player globallogic_audio::set_music_on_player( "VICTORY" );
                continue;
            }
            
            player globallogic_audio::set_music_on_player( "LOSE" );
        }
    }
    
    bbprint( "global_session_epilogs", "reason %s", endreasontext );
    roundendwait( level.postroundtime, 1 );
}

// Namespace globallogic
// Params 0
// Checksum 0x3913c709, Offset: 0x4288
// Size: 0xb8
function getendreasontext()
{
    if ( util::hitroundlimit() || util::hitroundwinlimit() )
    {
        return game[ "strings" ][ "round_limit_reached" ];
    }
    else if ( util::hitscorelimit() )
    {
        return game[ "strings" ][ "score_limit_reached" ];
    }
    
    if ( level.forcedend )
    {
        if ( level.hostforcedend )
        {
            return &"MP_HOST_ENDED_GAME";
        }
        else
        {
            return &"MP_ENDED_GAME";
        }
    }
    
    return game[ "strings" ][ "time_limit_reached" ];
}

// Namespace globallogic
// Params 0
// Checksum 0xe3edbfbf, Offset: 0x4348
// Size: 0x6a
function resetoutcomeforallplayers()
{
    players = level.players;
    
    for ( index = 0; index < players.size ; index++ )
    {
        player = players[ index ];
        player notify( #"reset_outcome" );
    }
}

// Namespace globallogic
// Params 2
// Checksum 0x92ac3477, Offset: 0x43c0
// Size: 0x25c, Type: bool
function startnextround( winner, endreasontext )
{
    if ( !util::isoneround() )
    {
        displayroundend( winner, endreasontext );
        globallogic_utils::executepostroundevents();
        
        if ( !util::waslastround() )
        {
            if ( checkroundswitch() )
            {
                displayroundswitch( winner, endreasontext );
            }
            
            if ( isdefined( level.nextroundisovertime ) && level.nextroundisovertime )
            {
                if ( !isdefined( game[ "overtime_round" ] ) )
                {
                    game[ "overtime_round" ] = 1;
                }
                else
                {
                    game[ "overtime_round" ]++;
                }
            }
            
            setmatchtalkflag( "DeadChatWithDead", level.voip.deadchatwithdead );
            setmatchtalkflag( "DeadChatWithTeam", level.voip.deadchatwithteam );
            setmatchtalkflag( "DeadHearTeamLiving", level.voip.deadhearteamliving );
            setmatchtalkflag( "DeadHearAllLiving", level.voip.deadhearallliving );
            setmatchtalkflag( "EveryoneHearsEveryone", level.voip.everyonehearseveryone );
            setmatchtalkflag( "DeadHearKiller", level.voip.deadhearkiller );
            setmatchtalkflag( "KillersHearVictim", level.voip.killershearvictim );
            game[ "state" ] = "playing";
            level.allowbattlechatter[ "bc" ] = getgametypesetting( "allowBattleChatter" );
            map_restart( 1 );
            return true;
        }
    }
    
    return false;
}

// Namespace globallogic
// Params 0
// Checksum 0x96d9ced, Offset: 0x4628
// Size: 0x7a
function getgamelength()
{
    if ( !level.timelimit || level.forcedend )
    {
        gamelength = globallogic_utils::gettimepassed() / 1000;
        gamelength = min( gamelength, 1200 );
    }
    else
    {
        gamelength = level.timelimit * 60;
    }
    
    return gamelength;
}

// Namespace globallogic
// Params 0
// Checksum 0x7fa76e0a, Offset: 0x46b0
// Size: 0x132
function gamehistoryplayerquit()
{
    if ( !gamemodeismode( 0 ) )
    {
        return;
    }
    
    teamscoreratio = 0;
    self gamehistoryfinishmatch( 3, 0, 0, 0, 0, teamscoreratio );
    
    if ( isdefined( self.pers[ "matchesPlayedStatsTracked" ] ) )
    {
        gamemode = util::getcurrentgamemode();
        self incrementmatchcompletionstat( gamemode, "played", "quit" );
        
        if ( isdefined( self.pers[ "matchesHostedStatsTracked" ] ) )
        {
            self incrementmatchcompletionstat( gamemode, "hosted", "quit" );
            self.pers[ "matchesHostedStatsTracked" ] = undefined;
        }
        
        self.pers[ "matchesPlayedStatsTracked" ] = undefined;
    }
    
    uploadstats( self );
    wait 1;
}

// Namespace globallogic
// Params 1
// Checksum 0x98a5a066, Offset: 0x47f0
// Size: 0x6e
function recordzmendgamecomscoreevent( winner )
{
    players = level.players;
    
    for ( index = 0; index < players.size ; index++ )
    {
        globallogic_player::recordzmendgamecomscoreeventforplayer( players[ index ], winner );
    }
}

// Namespace globallogic
// Params 2
// Checksum 0x243b0053, Offset: 0x4868
// Size: 0x834
function endgame( winner, endreasontext )
{
    if ( game[ "state" ] == "postgame" || level.gameended )
    {
        return;
    }
    
    if ( isdefined( level.onendgame ) )
    {
        [[ level.onendgame ]]( winner );
    }
    
    if ( !isdefined( level.disableoutrovisionset ) || level.disableoutrovisionset == 0 )
    {
        if ( sessionmodeiszombiesgame() && level.forcedend )
        {
            visionsetnaked( "zombie_last_stand", 2 );
        }
        else
        {
            visionsetnaked( "mpOutro", 2 );
        }
    }
    
    setmatchflag( "cg_drawSpectatorMessages", 0 );
    setmatchflag( "game_ended", 1 );
    game[ "state" ] = "postgame";
    level.gameendtime = gettime();
    level.gameended = 1;
    setdvar( "g_gameEnded", 1 );
    level.ingraceperiod = 0;
    level notify( #"game_ended" );
    level.allowbattlechatter[ "bc" ] = 0;
    globallogic_audio::flushdialog();
    
    if ( !isdefined( game[ "overtime_round" ] ) || util::waslastround() )
    {
        game[ "roundsplayed" ]++;
        game[ "roundwinner" ][ game[ "roundsplayed" ] ] = winner;
        
        if ( level.teambased )
        {
            game[ "roundswon" ][ winner ]++;
        }
    }
    
    if ( isdefined( winner ) && isdefined( level.teams[ winner ] ) )
    {
        level.finalkillcam_winner = winner;
    }
    else
    {
        level.finalkillcam_winner = "none";
    }
    
    setgameendtime( 0 );
    updateplacement();
    updaterankedmatch( winner );
    players = level.players;
    newtime = gettime();
    gamelength = getgamelength();
    setmatchtalkflag( "EveryoneHearsEveryone", 1 );
    bbgameover = 0;
    
    if ( util::isoneround() || util::waslastround() )
    {
        bbgameover = 1;
        
        if ( level.teambased )
        {
            if ( winner == "tie" )
            {
                recordgameresult( "draw" );
            }
            else
            {
                recordgameresult( winner );
            }
        }
        else if ( !isdefined( winner ) )
        {
            recordgameresult( "draw" );
        }
        else
        {
            recordgameresult( winner.team );
        }
    }
    
    for ( index = 0; index < players.size ; index++ )
    {
        player = players[ index ];
        player globallogic_player::freezeplayerforroundend();
        player thread roundenddof( 4 );
        player globallogic_ui::freegameplayhudelems();
        player weapons::updateweapontimings( newtime );
        player bbplayermatchend( gamelength, endreasontext, bbgameover );
        
        if ( ( level.rankedmatch || level.wagermatch || level.leaguematch ) && !player issplitscreen() )
        {
            if ( isdefined( player.setpromotion ) )
            {
                player setdstat( "AfterActionReportStats", "lobbyPopup", "promotion" );
                continue;
            }
            
            player setdstat( "AfterActionReportStats", "lobbyPopup", "summary" );
        }
    }
    
    music::setmusicstate( "SILENT" );
    thread challenges::roundend( winner );
    recordzmendgamecomscoreevent( winner );
    globallogic_player::recordactiveplayersendgamematchrecordstats();
    
    if ( startnextround( winner, endreasontext ) )
    {
        return;
    }
    
    if ( !util::isoneround() )
    {
        if ( isdefined( level.onroundendgame ) )
        {
            winner = [[ level.onroundendgame ]]( winner );
        }
        
        endreasontext = getendreasontext();
    }
    
    skillupdate( winner, level.teambased );
    recordleaguewinner( winner );
    thread challenges::gameend( winner );
    
    if ( !isdefined( level.skipgameend ) || isdefined( winner ) && !level.skipgameend )
    {
        displaygameend( winner, endreasontext );
    }
    
    if ( util::isoneround() )
    {
        globallogic_utils::executepostroundevents();
    }
    
    level.intermission = 1;
    setmatchtalkflag( "EveryoneHearsEveryone", 1 );
    stopdemorecording();
    players = level.players;
    
    for ( index = 0; index < players.size ; index++ )
    {
        player = players[ index ];
        recordplayerstats( player, "presentAtEnd", 1 );
        player closeingamemenu();
        player notify( #"reset_outcome" );
        player thread [[ level.spawnintermission ]]();
        player setclientuivisibilityflag( "hud_visible", 1 );
        player setclientuivisibilityflag( "weapon_hud_visible", 1 );
    }
    
    level notify( #"sfade" );
    
    /#
        print( "<dev string:xc5>" );
    #/
    
    if ( !isdefined( level.skipgameend ) || !level.skipgameend )
    {
        wait 5;
    }
    
    exitlevel( 0 );
}

// Namespace globallogic
// Params 3
// Checksum 0xc05721f3, Offset: 0x50a8
// Size: 0xc0
function bbplayermatchend( gamelength, endreasonstring, gameover )
{
    playerrank = getplacementforplayer( self );
    totaltimeplayed = 0;
    
    if ( isdefined( self.timeplayed ) && isdefined( self.timeplayed[ "total" ] ) )
    {
        totaltimeplayed = self.timeplayed[ "total" ];
        
        if ( totaltimeplayed > gamelength )
        {
            totaltimeplayed = gamelength;
        }
    }
    
    xuid = self getxuid();
}

// Namespace globallogic
// Params 2
// Checksum 0x29a66835, Offset: 0x5170
// Size: 0x1ae
function roundendwait( defaultdelay, matchbonus )
{
    notifiesdone = 0;
    
    while ( !notifiesdone )
    {
        players = level.players;
        notifiesdone = 1;
        
        for ( index = 0; index < players.size ; index++ )
        {
            if ( !isdefined( players[ index ].doingnotify ) || !players[ index ].doingnotify )
            {
                continue;
            }
            
            notifiesdone = 0;
        }
        
        wait 0.5;
    }
    
    if ( !matchbonus )
    {
        wait defaultdelay;
        level notify( #"round_end_done" );
        return;
    }
    
    wait defaultdelay / 2;
    level notify( #"give_match_bonus" );
    wait defaultdelay / 2;
    notifiesdone = 0;
    
    while ( !notifiesdone )
    {
        players = level.players;
        notifiesdone = 1;
        
        for ( index = 0; index < players.size ; index++ )
        {
            if ( !isdefined( players[ index ].doingnotify ) || !players[ index ].doingnotify )
            {
                continue;
            }
            
            notifiesdone = 0;
        }
        
        wait 0.5;
    }
    
    level notify( #"round_end_done" );
}

// Namespace globallogic
// Params 1
// Checksum 0xf84821de, Offset: 0x5328
// Size: 0x3c
function roundenddof( time )
{
    self setdepthoffield( 0, 128, 512, 4000, 6, 1.8 );
}

// Namespace globallogic
// Params 0
// Checksum 0xb875b600, Offset: 0x5370
// Size: 0x130
function checktimelimit()
{
    if ( isdefined( level.timelimitoverride ) && level.timelimitoverride )
    {
        return;
    }
    
    if ( game[ "state" ] != "playing" )
    {
        setgameendtime( 0 );
        return;
    }
    
    if ( level.timelimit <= 0 )
    {
        setgameendtime( 0 );
        return;
    }
    
    if ( level.inprematchperiod )
    {
        setgameendtime( 0 );
        return;
    }
    
    if ( level.timerstopped )
    {
        setgameendtime( 0 );
        return;
    }
    
    if ( !isdefined( level.starttime ) )
    {
        return;
    }
    
    timeleft = globallogic_utils::gettimeremaining();
    setgameendtime( gettime() + int( timeleft ) );
    
    if ( timeleft > 0 )
    {
        return;
    }
    
    [[ level.ontimelimit ]]();
}

// Namespace globallogic
// Params 0
// Checksum 0x23c80fa6, Offset: 0x54a8
// Size: 0x9a, Type: bool
function allteamsunderscorelimit()
{
    foreach ( team in level.teams )
    {
        if ( game[ "teamScores" ][ team ] >= level.scorelimit )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace globallogic
// Params 0
// Checksum 0x30c86bc2, Offset: 0x5550
// Size: 0xa4
function checkscorelimit()
{
    if ( game[ "state" ] != "playing" )
    {
        return 0;
    }
    
    if ( level.scorelimit <= 0 )
    {
        return 0;
    }
    
    if ( level.teambased )
    {
        if ( allteamsunderscorelimit() )
        {
            return 0;
        }
    }
    else
    {
        if ( !isplayer( self ) )
        {
            return 0;
        }
        
        if ( self.score < level.scorelimit )
        {
            return 0;
        }
    }
    
    [[ level.onscorelimit ]]();
}

// Namespace globallogic
// Params 0
// Checksum 0x5d993022, Offset: 0x5600
// Size: 0x1f2
function updategametypedvars()
{
    level endon( #"game_ended" );
    
    while ( game[ "state" ] == "playing" )
    {
        roundlimit = math::clamp( getgametypesetting( "roundLimit" ), level.roundlimitmin, level.roundlimitmax );
        
        if ( roundlimit != level.roundlimit )
        {
            level.roundlimit = roundlimit;
            level notify( #"update_roundlimit" );
        }
        
        timelimit = [[ level.gettimelimit ]]();
        
        if ( timelimit != level.timelimit )
        {
            level.timelimit = timelimit;
            setdvar( "ui_timelimit", level.timelimit );
            level notify( #"update_timelimit" );
        }
        
        thread checktimelimit();
        scorelimit = math::clamp( getgametypesetting( "scoreLimit" ), level.scorelimitmin, level.scorelimitmax );
        
        if ( scorelimit != level.scorelimit )
        {
            level.scorelimit = scorelimit;
            setdvar( "ui_scorelimit", level.scorelimit );
            level notify( #"update_scorelimit" );
        }
        
        thread checkscorelimit();
        
        if ( isdefined( level.starttime ) )
        {
            if ( globallogic_utils::gettimeremaining() < 3000 )
            {
                wait 0.1;
                continue;
            }
        }
        
        wait 1;
    }
}

// Namespace globallogic
// Params 0
// Checksum 0xf8834a38, Offset: 0x5800
// Size: 0x1d6
function removedisconnectedplayerfromplacement()
{
    offset = 0;
    numplayers = level.placement[ "all" ].size;
    found = 0;
    
    for ( i = 0; i < numplayers ; i++ )
    {
        if ( level.placement[ "all" ][ i ] == self )
        {
            found = 1;
        }
        
        if ( found )
        {
            level.placement[ "all" ][ i ] = level.placement[ "all" ][ i + 1 ];
        }
    }
    
    if ( !found )
    {
        return;
    }
    
    level.placement[ "all" ][ numplayers - 1 ] = undefined;
    assert( level.placement[ "<dev string:xd0>" ].size == numplayers - 1 );
    
    /#
        globallogic_utils::assertproperplacement();
    #/
    
    updateteamplacement();
    
    if ( level.teambased )
    {
        return;
    }
    
    numplayers = level.placement[ "all" ].size;
    
    for ( i = 0; i < numplayers ; i++ )
    {
        player = level.placement[ "all" ][ i ];
        player notify( #"update_outcome" );
    }
}

// Namespace globallogic
// Params 0
// Checksum 0xfd226142, Offset: 0x59e0
// Size: 0x26c
function updateplacement()
{
    if ( !level.players.size )
    {
        return;
    }
    
    level.placement[ "all" ] = [];
    
    foreach ( player in level.players )
    {
        if ( !level.teambased || isdefined( level.teams[ player.team ] ) )
        {
            level.placement[ "all" ][ level.placement[ "all" ].size ] = player;
        }
    }
    
    placementall = level.placement[ "all" ];
    
    for ( i = 1; i < placementall.size ; i++ )
    {
        player = placementall[ i ];
        playerscore = player.score;
        
        for ( j = i - 1; playerscore == placementall[ j ].score && ( playerscore > placementall[ j ].score || j >= 0 && player.deaths < placementall[ j ].deaths ) ; j-- )
        {
            placementall[ j + 1 ] = placementall[ j ];
        }
        
        placementall[ j + 1 ] = player;
    }
    
    level.placement[ "all" ] = placementall;
    
    /#
        globallogic_utils::assertproperplacement();
    #/
    
    updateteamplacement();
}

// Namespace globallogic
// Params 0
// Checksum 0x524a17d8, Offset: 0x5c58
// Size: 0x1e0
function updateteamplacement()
{
    foreach ( team in level.teams )
    {
        placement[ team ] = [];
    }
    
    placement[ "spectator" ] = [];
    
    if ( !level.teambased )
    {
        return;
    }
    
    placementall = level.placement[ "all" ];
    placementallsize = placementall.size;
    
    for ( i = 0; i < placementallsize ; i++ )
    {
        player = placementall[ i ];
        
        if ( isdefined( player ) )
        {
            team = player.pers[ "team" ];
            placement[ team ][ placement[ team ].size ] = player;
        }
    }
    
    foreach ( team in level.teams )
    {
        level.placement[ team ] = placement[ team ];
    }
}

// Namespace globallogic
// Params 1
// Checksum 0xff717c0d, Offset: 0x5e40
// Size: 0xb2
function getplacementforplayer( player )
{
    updateplacement();
    playerrank = -1;
    placement = level.placement[ "all" ];
    
    for ( placementindex = 0; placementindex < placement.size ; placementindex++ )
    {
        if ( level.placement[ "all" ][ placementindex ] == player )
        {
            playerrank = placementindex + 1;
            break;
        }
    }
    
    return playerrank;
}

// Namespace globallogic
// Params 1
// Checksum 0xa9c3c508, Offset: 0x5f00
// Size: 0x19a
function sortdeadplayers( team )
{
    if ( !level.playerqueuedrespawn )
    {
        return;
    }
    
    for ( i = 1; i < level.deadplayers[ team ].size ; i++ )
    {
        player = level.deadplayers[ team ][ i ];
        
        for ( j = i - 1; j >= 0 && player.deathtime < level.deadplayers[ team ][ j ].deathtime ; j-- )
        {
            level.deadplayers[ team ][ j + 1 ] = level.deadplayers[ team ][ j ];
        }
        
        level.deadplayers[ team ][ j + 1 ] = player;
    }
    
    for ( i = 0; i < level.deadplayers[ team ].size ; i++ )
    {
        if ( level.deadplayers[ team ][ i ].spawnqueueindex != i )
        {
            level.spawnqueuemodified[ team ] = 1;
        }
        
        level.deadplayers[ team ][ i ].spawnqueueindex = i;
    }
}

// Namespace globallogic
// Params 0
// Checksum 0x2dfc2aad, Offset: 0x60a8
// Size: 0xa2
function totalalivecount()
{
    count = 0;
    
    foreach ( team in level.teams )
    {
        count += level.alivecount[ team ];
    }
    
    return count;
}

// Namespace globallogic
// Params 0
// Checksum 0xeec8a364, Offset: 0x6158
// Size: 0xa2
function totalplayerlives()
{
    count = 0;
    
    foreach ( team in level.teams )
    {
        count += level.playerlives[ team ];
    }
    
    return count;
}

// Namespace globallogic
// Params 1
// Checksum 0xb4f4b9be, Offset: 0x6208
// Size: 0x9c
function initteamvariables( team )
{
    if ( !isdefined( level.alivecount ) )
    {
        level.alivecount = [];
    }
    
    level.alivecount[ team ] = 0;
    level.lastalivecount[ team ] = 0;
    level.everexisted[ team ] = 0;
    level.wavedelay[ team ] = 0;
    level.lastwave[ team ] = 0;
    level.waveplayerspawnindex[ team ] = 0;
    resetteamvariables( team );
}

// Namespace globallogic
// Params 1
// Checksum 0x1da42165, Offset: 0x62b0
// Size: 0xaa
function resetteamvariables( team )
{
    level.playercount[ team ] = 0;
    level.botscount[ team ] = 0;
    level.lastalivecount[ team ] = level.alivecount[ team ];
    level.alivecount[ team ] = 0;
    level.playerlives[ team ] = 0;
    level.aliveplayers[ team ] = [];
    level.deadplayers[ team ] = [];
    level.squads[ team ] = [];
    level.spawnqueuemodified[ team ] = 0;
}

// Namespace globallogic
// Params 0
// Checksum 0xea1d9f5e, Offset: 0x6368
// Size: 0x3c4
function updateteamstatus()
{
    level notify( #"updating_team_status" );
    level endon( #"updating_team_status" );
    level endon( #"game_ended" );
    waittillframeend();
    wait 0;
    
    if ( game[ "state" ] == "postgame" )
    {
        return;
    }
    
    resettimeout();
    
    foreach ( team in level.teams )
    {
        resetteamvariables( team );
    }
    
    level.activeplayers = [];
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( !isdefined( player ) && level.splitscreen )
        {
            continue;
        }
        
        team = player.team;
        
        if ( team != "spectator" )
        {
            level.playercount[ team ]++;
            
            if ( isdefined( player.pers[ "isBot" ] ) )
            {
                level.botscount[ team ]++;
            }
            
            if ( player.sessionstate == "playing" )
            {
                level.alivecount[ team ]++;
                level.playerlives[ team ]++;
                player.spawnqueueindex = -1;
                
                if ( isalive( player ) )
                {
                    level.aliveplayers[ team ][ level.aliveplayers[ team ].size ] = player;
                    level.activeplayers[ level.activeplayers.size ] = player;
                }
                else
                {
                    level.deadplayers[ team ][ level.deadplayers[ team ].size ] = player;
                }
                
                continue;
            }
            
            level.deadplayers[ team ][ level.deadplayers[ team ].size ] = player;
            
            if ( player globallogic_spawn::mayspawn() )
            {
                level.playerlives[ team ]++;
            }
        }
    }
    
    totalalive = totalalivecount();
    
    if ( totalalive > level.maxplayercount )
    {
        level.maxplayercount = totalalive;
    }
    
    foreach ( team in level.teams )
    {
        if ( level.alivecount[ team ] )
        {
            level.everexisted[ team ] = 1;
        }
        
        sortdeadplayers( team );
    }
    
    level updategameevents();
}

// Namespace globallogic
// Params 1
// Checksum 0x82efe007, Offset: 0x6738
// Size: 0xb2
function checkteamscorelimitsoon( team )
{
    assert( isdefined( team ) );
    
    if ( level.scorelimit <= 0 )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        return;
    }
    
    if ( globallogic_utils::gettimepassed() < 60000 )
    {
        return;
    }
    
    timeleft = globallogic_utils::getestimatedtimeuntilscorelimit( team );
    
    if ( timeleft < 1 )
    {
        level notify( #"match_ending_soon", "score" );
    }
}

// Namespace globallogic
// Params 0
// Checksum 0x4d2d5d52, Offset: 0x67f8
// Size: 0xaa
function checkplayerscorelimitsoon()
{
    assert( isplayer( self ) );
    
    if ( level.scorelimit <= 0 )
    {
        return;
    }
    
    if ( level.teambased )
    {
        return;
    }
    
    if ( globallogic_utils::gettimepassed() < 60000 )
    {
        return;
    }
    
    timeleft = globallogic_utils::getestimatedtimeuntilscorelimit( undefined );
    
    if ( timeleft < 1 )
    {
        level notify( #"match_ending_soon", "score" );
    }
}

// Namespace globallogic
// Params 0
// Checksum 0x402e68ec, Offset: 0x68b0
// Size: 0x1b4
function startgame()
{
    thread globallogic_utils::gametimer();
    level.timerstopped = 0;
    setmatchtalkflag( "DeadChatWithDead", level.voip.deadchatwithdead );
    setmatchtalkflag( "DeadChatWithTeam", level.voip.deadchatwithteam );
    setmatchtalkflag( "DeadHearTeamLiving", level.voip.deadhearteamliving );
    setmatchtalkflag( "DeadHearAllLiving", level.voip.deadhearallliving );
    setmatchtalkflag( "EveryoneHearsEveryone", level.voip.everyonehearseveryone );
    setmatchtalkflag( "DeadHearKiller", level.voip.deadhearkiller );
    setmatchtalkflag( "KillersHearVictim", level.voip.killershearvictim );
    prematchperiod();
    level notify( #"prematch_over" );
    thread graceperiod();
    thread watchmatchendingsoon();
    thread globallogic_audio::musiccontroller();
    thread bb::recordblackboxbreadcrumbdata( "zmbreadcrumb" );
    recordmatchbegin();
}

// Namespace globallogic
// Params 0
// Checksum 0x99ec1590, Offset: 0x6a70
// Size: 0x4
function waitforplayers()
{
    
}

// Namespace globallogic
// Params 0
// Checksum 0x4e687bbf, Offset: 0x6a80
// Size: 0x122
function prematchperiod()
{
    setmatchflag( "hud_hardcore", level.hardcoremode );
    level endon( #"game_ended" );
    
    if ( level.prematchperiod > 0 )
    {
        thread matchstarttimer();
        waitforplayers();
        wait level.prematchperiod;
    }
    else
    {
        matchstarttimerskip();
        wait 0.05;
    }
    
    level.inprematchperiod = 0;
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        level.players[ index ] util::freeze_player_controls( 0 );
        level.players[ index ] enableweapons();
    }
    
    if ( game[ "state" ] != "playing" )
    {
        return;
    }
}

// Namespace globallogic
// Params 0
// Checksum 0xdb3433f1, Offset: 0x6bb0
// Size: 0x14c
function graceperiod()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.graceperiodfunc ) )
    {
        [[ level.graceperiodfunc ]]();
    }
    else
    {
        wait level.graceperiod;
    }
    
    level notify( #"grace_period_ending" );
    wait 0.05;
    level.ingraceperiod = 0;
    
    if ( game[ "state" ] != "playing" )
    {
        return;
    }
    
    if ( level.numlives )
    {
        players = level.players;
        
        for ( i = 0; i < players.size ; i++ )
        {
            player = players[ i ];
            
            if ( !player.hasspawned && player.sessionteam != "spectator" && !isalive( player ) )
            {
                player.statusicon = "hud_status_dead";
            }
        }
    }
    
    level thread updateteamstatus();
}

// Namespace globallogic
// Params 0
// Checksum 0xc1844e3, Offset: 0x6d08
// Size: 0x54
function watchmatchendingsoon()
{
    setdvar( "xblive_matchEndingSoon", 0 );
    level waittill( #"match_ending_soon", reason );
    setdvar( "xblive_matchEndingSoon", 1 );
}

// Namespace globallogic
// Params 0
// Checksum 0x99ec1590, Offset: 0x6d68
// Size: 0x4
function assertteamvariables()
{
    
}

// Namespace globallogic
// Params 0
// Checksum 0xd2e37d0c, Offset: 0x6d78
// Size: 0x8e, Type: bool
function anyteamhaswavedelay()
{
    foreach ( team in level.teams )
    {
        if ( level.wavedelay[ team ] )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace globallogic
// Params 0
// Checksum 0x687cebeb, Offset: 0x6e10
// Size: 0x138c
function callback_startgametype()
{
    level.prematchperiod = 0;
    level.intermission = 0;
    setmatchflag( "cg_drawSpectatorMessages", 1 );
    setmatchflag( "game_ended", 0 );
    
    if ( !isdefined( game[ "gamestarted" ] ) )
    {
        if ( !isdefined( game[ "allies" ] ) )
        {
            game[ "allies" ] = "seals";
        }
        
        if ( !isdefined( game[ "axis" ] ) )
        {
            game[ "axis" ] = "pmc";
        }
        
        if ( !isdefined( game[ "attackers" ] ) )
        {
            game[ "attackers" ] = "allies";
        }
        
        if ( !isdefined( game[ "defenders" ] ) )
        {
            game[ "defenders" ] = "axis";
        }
        
        assert( game[ "<dev string:xd4>" ] != game[ "<dev string:xde>" ] );
        
        foreach ( team in level.teams )
        {
            if ( !isdefined( game[ team ] ) )
            {
                game[ team ] = "pmc";
            }
        }
        
        if ( !isdefined( game[ "state" ] ) )
        {
            game[ "state" ] = "playing";
        }
        
        setdvar( "cg_thirdPersonAngle", 354 );
        game[ "strings" ][ "press_to_spawn" ] = &"PLATFORM_PRESS_TO_SPAWN";
        
        if ( level.teambased )
        {
            game[ "strings" ][ "waiting_for_teams" ] = &"MP_WAITING_FOR_TEAMS";
            game[ "strings" ][ "opponent_forfeiting_in" ] = &"MP_OPPONENT_FORFEITING_IN";
        }
        else
        {
            game[ "strings" ][ "waiting_for_teams" ] = &"MP_WAITING_FOR_PLAYERS";
            game[ "strings" ][ "opponent_forfeiting_in" ] = &"MP_OPPONENT_FORFEITING_IN";
        }
        
        game[ "strings" ][ "match_starting_in" ] = &"MP_MATCH_STARTING_IN";
        game[ "strings" ][ "spawn_next_round" ] = &"MP_SPAWN_NEXT_ROUND";
        game[ "strings" ][ "waiting_to_spawn" ] = &"MP_WAITING_TO_SPAWN";
        game[ "strings" ][ "waiting_to_spawn_ss" ] = &"MP_WAITING_TO_SPAWN_SS";
        game[ "strings" ][ "you_will_spawn" ] = &"MP_YOU_WILL_RESPAWN";
        game[ "strings" ][ "match_starting" ] = &"MP_MATCH_STARTING";
        game[ "strings" ][ "change_class" ] = &"MP_CHANGE_CLASS_NEXT_SPAWN";
        game[ "strings" ][ "last_stand" ] = &"MPUI_LAST_STAND";
        game[ "strings" ][ "cowards_way" ] = &"PLATFORM_COWARDS_WAY_OUT";
        game[ "strings" ][ "tie" ] = &"MP_MATCH_TIE";
        game[ "strings" ][ "round_draw" ] = &"MP_ROUND_DRAW";
        game[ "strings" ][ "enemies_eliminated" ] = &"MP_ENEMIES_ELIMINATED";
        game[ "strings" ][ "score_limit_reached" ] = &"MP_SCORE_LIMIT_REACHED";
        game[ "strings" ][ "round_limit_reached" ] = &"MP_ROUND_LIMIT_REACHED";
        game[ "strings" ][ "time_limit_reached" ] = &"MP_TIME_LIMIT_REACHED";
        game[ "strings" ][ "players_forfeited" ] = &"MP_PLAYERS_FORFEITED";
        assertteamvariables();
        [[ level.onprecachegametype ]]();
        game[ "gamestarted" ] = 1;
        game[ "totalKills" ] = 0;
        
        foreach ( team in level.teams )
        {
            game[ "teamScores" ][ team ] = 0;
            game[ "totalKillsTeam" ][ team ] = 0;
        }
        
        if ( !level.splitscreen )
        {
            level.prematchperiod = getgametypesetting( "prematchperiod" );
        }
        
        if ( getdvarint( "xblive_clanmatch" ) != 0 )
        {
            foreach ( team in level.teams )
            {
                game[ "icons" ][ team ] = "composite_emblem_team_axis";
            }
            
            game[ "icons" ][ "allies" ] = "composite_emblem_team_allies";
            game[ "icons" ][ "axis" ] = "composite_emblem_team_axis";
        }
    }
    
    if ( !isdefined( game[ "timepassed" ] ) )
    {
        game[ "timepassed" ] = 0;
    }
    
    if ( !isdefined( game[ "roundsplayed" ] ) )
    {
        game[ "roundsplayed" ] = 0;
    }
    
    setroundsplayed( game[ "roundsplayed" ] );
    
    if ( !isdefined( game[ "roundwinner" ] ) )
    {
        game[ "roundwinner" ] = [];
    }
    
    if ( !isdefined( game[ "roundswon" ] ) )
    {
        game[ "roundswon" ] = [];
    }
    
    if ( !isdefined( game[ "roundswon" ][ "tie" ] ) )
    {
        game[ "roundswon" ][ "tie" ] = 0;
    }
    
    foreach ( team in level.teams )
    {
        if ( !isdefined( game[ "roundswon" ][ team ] ) )
        {
            game[ "roundswon" ][ team ] = 0;
        }
        
        level.teamspawnpoints[ team ] = [];
        level.spawn_point_team_class_names[ team ] = [];
    }
    
    level.skipvote = 0;
    level.gameended = 0;
    setdvar( "g_gameEnded", 0 );
    level.objidstart = 0;
    level.forcedend = 0;
    level.hostforcedend = 0;
    level.hardcoremode = getgametypesetting( "hardcoreMode" );
    
    if ( level.hardcoremode )
    {
        /#
            print( "<dev string:xe8>" );
        #/
        
        if ( !isdefined( level.friendlyfiredelaytime ) )
        {
            level.friendlyfiredelaytime = 0;
        }
    }
    
    if ( getdvarstring( "scr_max_rank" ) == "" )
    {
        setdvar( "scr_max_rank", "0" );
    }
    
    level.rankcap = getdvarint( "scr_max_rank" );
    
    if ( getdvarstring( "scr_min_prestige" ) == "" )
    {
        setdvar( "scr_min_prestige", "0" );
    }
    
    level.minprestige = getdvarint( "scr_min_prestige" );
    level.usestartspawns = 1;
    level.cumulativeroundscores = getgametypesetting( "cumulativeRoundScores" );
    level.allowhitmarkers = getgametypesetting( "allowhitmarkers" );
    level.playerqueuedrespawn = getgametypesetting( "playerQueuedRespawn" );
    level.playerforcerespawn = getgametypesetting( "playerForceRespawn" );
    level.perksenabled = getgametypesetting( "perksEnabled" );
    level.disableattachments = getgametypesetting( "disableAttachments" );
    level.disabletacinsert = getgametypesetting( "disableTacInsert" );
    level.disablecac = getgametypesetting( "disableCAC" );
    level.disableweapondrop = getgametypesetting( "disableweapondrop" );
    level.onlyheadshots = getgametypesetting( "onlyHeadshots" );
    level.minimumallowedteamkills = getgametypesetting( "teamKillPunishCount" ) - 1;
    level.teamkillreducedpenalty = getgametypesetting( "teamKillReducedPenalty" );
    level.teamkillpointloss = getgametypesetting( "teamKillPointLoss" );
    level.teamkillspawndelay = getgametypesetting( "teamKillSpawnDelay" );
    level.deathpointloss = getgametypesetting( "deathPointLoss" );
    level.leaderbonus = getgametypesetting( "leaderBonus" );
    level.forceradar = getgametypesetting( "forceRadar" );
    level.playersprinttime = getgametypesetting( "playerSprintTime" );
    level.bulletdamagescalar = getgametypesetting( "bulletDamageScalar" );
    level.playermaxhealth = getgametypesetting( "playerMaxHealth" );
    level.playerhealthregentime = getgametypesetting( "playerHealthRegenTime" );
    level.playerrespawndelay = getgametypesetting( "playerRespawnDelay" );
    level.playerobjectiveheldrespawndelay = getgametypesetting( "playerObjectiveHeldRespawnDelay" );
    level.waverespawndelay = getgametypesetting( "waveRespawnDelay" );
    level.spectatetype = getgametypesetting( "spectateType" );
    level.voip = spawnstruct();
    level.voip.deadchatwithdead = getgametypesetting( "voipDeadChatWithDead" );
    level.voip.deadchatwithteam = getgametypesetting( "voipDeadChatWithTeam" );
    level.voip.deadhearallliving = getgametypesetting( "voipDeadHearAllLiving" );
    level.voip.deadhearteamliving = getgametypesetting( "voipDeadHearTeamLiving" );
    level.voip.everyonehearseveryone = getgametypesetting( "voipEveryoneHearsEveryone" );
    level.voip.deadhearkiller = getgametypesetting( "voipDeadHearKiller" );
    level.voip.killershearvictim = getgametypesetting( "voipKillersHearVictim" );
    callback::callback( #"hash_cc62acca" );
    level.prematchperiod = 0;
    level.persistentdatainfo = [];
    level.maxrecentstats = 10;
    level.maxhitlocations = 19;
    level.globalshotsfired = 0;
    thread hud_message::init();
    
    foreach ( team in level.teams )
    {
        initteamvariables( team );
    }
    
    level.maxplayercount = 0;
    level.activeplayers = [];
    level.allowannouncer = getgametypesetting( "allowAnnouncer" );
    
    if ( !isdefined( level.timelimit ) )
    {
        util::registertimelimit( 1, 1440 );
    }
    
    if ( !isdefined( level.scorelimit ) )
    {
        util::registerscorelimit( 1, 500 );
    }
    
    if ( !isdefined( level.roundlimit ) )
    {
        util::registerroundlimit( 0, 10 );
    }
    
    if ( !isdefined( level.roundwinlimit ) )
    {
        util::registerroundwinlimit( 0, 10 );
    }
    
    wavedelay = level.waverespawndelay;
    
    if ( wavedelay )
    {
        foreach ( team in level.teams )
        {
            level.wavedelay[ team ] = wavedelay;
            level.lastwave[ team ] = 0;
        }
        
        level thread [[ level.wavespawntimer ]]();
    }
    
    level.inprematchperiod = 1;
    
    if ( level.prematchperiod > 2 )
    {
        level.prematchperiod += randomfloat( 4 ) - 2;
    }
    
    if ( level.numlives || anyteamhaswavedelay() || level.playerqueuedrespawn )
    {
        level.graceperiod = 15;
    }
    else
    {
        level.graceperiod = 5;
    }
    
    level.ingraceperiod = 1;
    level.roundenddelay = 5;
    level.halftimeroundenddelay = 3;
    globallogic_score::updateallteamscores();
    level.killstreaksenabled = 1;
    
    if ( getdvarstring( "scr_game_rankenabled" ) == "" )
    {
        setdvar( "scr_game_rankenabled", 1 );
    }
    
    level.rankenabled = getdvarint( "scr_game_rankenabled" );
    
    if ( getdvarstring( "scr_game_medalsenabled" ) == "" )
    {
        setdvar( "scr_game_medalsenabled", 1 );
    }
    
    level.medalsenabled = getdvarint( "scr_game_medalsenabled" );
    
    if ( level.hardcoremode && level.rankedmatch && getdvarstring( "scr_game_friendlyFireDelay" ) == "" )
    {
        setdvar( "scr_game_friendlyFireDelay", 1 );
    }
    
    level.friendlyfiredelay = getdvarint( "scr_game_friendlyFireDelay" );
    [[ level.onstartgametype ]]();
    
    if ( getdvarint( "custom_killstreak_mode" ) == 1 )
    {
        level.killstreaksenabled = 0;
    }
    
    thread startgame();
    level thread updategametypedvars();
    level thread simple_hostmigration::updatehostmigrationdata();
    
    /#
        if ( getdvarint( "<dev string:xae>" ) == 1 )
        {
            level.skipgameend = 1;
            level.roundlimit = 1;
            wait 1;
            thread forceend( 0 );
        }
        
        if ( getdvarint( "<dev string:x98>" ) == 1 )
        {
            thread forcedebughostmigration();
        }
    #/
}

/#

    // Namespace globallogic
    // Params 0
    // Checksum 0x7e39c948, Offset: 0x81a8
    // Size: 0x50, Type: dev
    function forcedebughostmigration()
    {
        while ( true )
        {
            hostmigration::waittillhostmigrationdone();
            wait 60;
            starthostmigration();
            hostmigration::waittillhostmigrationdone();
        }
    }

#/

// Namespace globallogic
// Params 4
// Checksum 0x878b2ebe, Offset: 0x8200
// Size: 0x10c
function registerfriendlyfiredelay( dvarstring, defaultvalue, minvalue, maxvalue )
{
    dvarstring = "scr_" + dvarstring + "_friendlyFireDelayTime";
    
    if ( getdvarstring( dvarstring ) == "" )
    {
        setdvar( dvarstring, defaultvalue );
    }
    
    if ( getdvarint( dvarstring ) > maxvalue )
    {
        setdvar( dvarstring, maxvalue );
    }
    else if ( getdvarint( dvarstring ) < minvalue )
    {
        setdvar( dvarstring, minvalue );
    }
    
    level.friendlyfiredelaytime = getdvarint( dvarstring );
}

// Namespace globallogic
// Params 0
// Checksum 0xa17d99ba, Offset: 0x8318
// Size: 0x90, Type: bool
function checkroundswitch()
{
    if ( !isdefined( level.roundswitch ) || !level.roundswitch )
    {
        return false;
    }
    
    if ( !isdefined( level.onroundswitch ) )
    {
        return false;
    }
    
    assert( game[ "<dev string:xfc>" ] > 0 );
    
    if ( game[ "roundsplayed" ] % level.roundswitch == 0 )
    {
        [[ level.onroundswitch ]]();
        return true;
    }
    
    return false;
}

// Namespace globallogic
// Params 0
// Checksum 0xb8dc60c8, Offset: 0x83b0
// Size: 0x3c
function listenforgameend()
{
    self waittill( #"host_sucks_end_game" );
    level.skipvote = 1;
    
    if ( !level.gameended )
    {
        level thread forceend( 1 );
    }
}

// Namespace globallogic
// Params 1
// Checksum 0xee99ff5, Offset: 0x83f8
// Size: 0x128
function getkillstreaks( player )
{
    for ( killstreaknum = 0; killstreaknum < level.maxkillstreaks ; killstreaknum++ )
    {
        killstreak[ killstreaknum ] = "killstreak_null";
    }
    
    if ( !isdefined( player.pers[ "isBot" ] ) && isplayer( player ) && !level.oldschool && level.disablecac != 1 && isdefined( player.killstreak ) )
    {
        currentkillstreak = 0;
        
        for ( killstreaknum = 0; killstreaknum < level.maxkillstreaks ; killstreaknum++ )
        {
            if ( isdefined( player.killstreak[ killstreaknum ] ) )
            {
                killstreak[ currentkillstreak ] = player.killstreak[ killstreaknum ];
                currentkillstreak++;
            }
        }
    }
    
    return killstreak;
}

// Namespace globallogic
// Params 1
// Checksum 0xcbc8a627, Offset: 0x8528
// Size: 0x6c
function updaterankedmatch( winner )
{
    if ( level.rankedmatch )
    {
        if ( hostidledout() )
        {
            level.hostforcedend = 1;
            
            /#
                print( "<dev string:x109>" );
            #/
            
            endlobby();
        }
    }
}

