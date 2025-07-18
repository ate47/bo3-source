#using scripts/codescripts/struct;
#using scripts/shared/math_shared;
#using scripts/zm/_util;
#using scripts/zm/gametypes/_globallogic;
#using scripts/zm/gametypes/_globallogic_audio;
#using scripts/zm/gametypes/_globallogic_score;
#using scripts/zm/gametypes/_globallogic_utils;
#using scripts/zm/gametypes/_spawnlogic;

#namespace globallogic_defaults;

// Namespace globallogic_defaults
// Params 1
// Checksum 0x14d14d3d, Offset: 0x2b0
// Size: 0x32
function getwinningteamfromloser( losing_team )
{
    if ( level.multiteam )
    {
        return "tie";
    }
    
    return util::getotherteam( losing_team );
}

// Namespace globallogic_defaults
// Params 1
// Checksum 0xae330b20, Offset: 0x2f0
// Size: 0x2c4
function default_onforfeit( team )
{
    level.gameforfeited = 1;
    level notify( #"hash_d343f3a0" );
    level endon( #"hash_d343f3a0" );
    level endon( #"hash_577494dc" );
    forfeit_delay = 20;
    announcement( game[ "strings" ][ "opponent_forfeiting_in" ], forfeit_delay, 0 );
    wait 10;
    announcement( game[ "strings" ][ "opponent_forfeiting_in" ], 10, 0 );
    wait 10;
    endreason = &"";
    
    if ( !isdefined( team ) )
    {
        setdvar( "ui_text_endreason", game[ "strings" ][ "players_forfeited" ] );
        endreason = game[ "strings" ][ "players_forfeited" ];
        winner = level.players[ 0 ];
    }
    else if ( isdefined( level.teams[ team ] ) )
    {
        endreason = game[ "strings" ][ team + "_forfeited" ];
        setdvar( "ui_text_endreason", endreason );
        winner = getwinningteamfromloser( team );
    }
    else
    {
        assert( isdefined( team ), "<dev string:x28>" );
        assert( 0, "<dev string:x46>" + team + "<dev string:x56>" );
        winner = "tie";
    }
    
    level.forcedend = 1;
    
    /#
        if ( isplayer( winner ) )
        {
            print( "<dev string:x6d>" + winner getxuid() + "<dev string:x7c>" + winner.name + "<dev string:x7e>" );
        }
        else
        {
            globallogic_utils::logteamwinstring( "<dev string:x80>", winner );
        }
    #/
    
    thread globallogic::endgame( winner, endreason );
}

// Namespace globallogic_defaults
// Params 1
// Checksum 0x5fbead3, Offset: 0x5c0
// Size: 0x184
function default_ondeadevent( team )
{
    if ( isdefined( level.teams[ team ] ) )
    {
        eliminatedstring = game[ "strings" ][ team + "_eliminated" ];
        iprintln( eliminatedstring );
        setdvar( "ui_text_endreason", eliminatedstring );
        winner = getwinningteamfromloser( team );
        globallogic_utils::logteamwinstring( "team eliminated", winner );
        thread globallogic::endgame( winner, eliminatedstring );
        return;
    }
    
    setdvar( "ui_text_endreason", game[ "strings" ][ "tie" ] );
    globallogic_utils::logteamwinstring( "tie" );
    
    if ( level.teambased )
    {
        thread globallogic::endgame( "tie", game[ "strings" ][ "tie" ] );
        return;
    }
    
    thread globallogic::endgame( undefined, game[ "strings" ][ "tie" ] );
}

// Namespace globallogic_defaults
// Params 1
// Checksum 0x4f978bc1, Offset: 0x750
// Size: 0xc
function default_onalivecountchange( team )
{
    
}

// Namespace globallogic_defaults
// Params 1
// Checksum 0xccd9333a, Offset: 0x768
// Size: 0x10
function default_onroundendgame( winner )
{
    return winner;
}

// Namespace globallogic_defaults
// Params 1
// Checksum 0xb23bc7ee, Offset: 0x780
// Size: 0x16e
function default_ononeleftevent( team )
{
    if ( !level.teambased )
    {
        winner = globallogic_score::gethighestscoringplayer();
        
        /#
            if ( isdefined( winner ) )
            {
                print( "<dev string:x88>" + winner.name );
            }
            else
            {
                print( "<dev string:x9e>" );
            }
        #/
        
        thread globallogic::endgame( winner, &"MP_ENEMIES_ELIMINATED" );
        return;
    }
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        player = level.players[ index ];
        
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.pers[ "team" ] ) || player.pers[ "team" ] != team )
        {
            continue;
        }
        
        player globallogic_audio::leaderdialogonplayer( "sudden_death" );
    }
}

// Namespace globallogic_defaults
// Params 0
// Checksum 0x49f6d004, Offset: 0x8f8
// Size: 0x124
function default_ontimelimit()
{
    winner = undefined;
    
    if ( level.teambased )
    {
        winner = globallogic::determineteamwinnerbygamestat( "teamScores" );
        globallogic_utils::logteamwinstring( "time limit", winner );
    }
    else
    {
        winner = globallogic_score::gethighestscoringplayer();
        
        /#
            if ( isdefined( winner ) )
            {
                print( "<dev string:xbb>" + winner.name );
            }
            else
            {
                print( "<dev string:xcd>" );
            }
        #/
    }
    
    setdvar( "ui_text_endreason", game[ "strings" ][ "time_limit_reached" ] );
    thread globallogic::endgame( winner, game[ "strings" ][ "time_limit_reached" ] );
}

// Namespace globallogic_defaults
// Params 0
// Checksum 0x97efaffd, Offset: 0xa28
// Size: 0x138, Type: bool
function default_onscorelimit()
{
    if ( !level.endgameonscorelimit )
    {
        return false;
    }
    
    winner = undefined;
    
    if ( level.teambased )
    {
        winner = globallogic::determineteamwinnerbygamestat( "teamScores" );
        globallogic_utils::logteamwinstring( "scorelimit", winner );
    }
    else
    {
        winner = globallogic_score::gethighestscoringplayer();
        
        /#
            if ( isdefined( winner ) )
            {
                print( "<dev string:xdd>" + winner.name );
            }
            else
            {
                print( "<dev string:xef>" );
            }
        #/
    }
    
    setdvar( "ui_text_endreason", game[ "strings" ][ "score_limit_reached" ] );
    thread globallogic::endgame( winner, game[ "strings" ][ "score_limit_reached" ] );
    return true;
}

// Namespace globallogic_defaults
// Params 2
// Checksum 0x8cf46196, Offset: 0xb68
// Size: 0xfc
function default_onspawnspectator( origin, angles )
{
    if ( isdefined( origin ) && isdefined( angles ) )
    {
        self spawn( origin, angles );
        return;
    }
    
    spawnpointname = "mp_global_intermission";
    spawnpoints = getentarray( spawnpointname, "classname" );
    assert( spawnpoints.size, "<dev string:xff>" );
    spawnpoint = spawnlogic::getspawnpoint_random( spawnpoints );
    self spawn( spawnpoint.origin, spawnpoint.angles );
}

// Namespace globallogic_defaults
// Params 0
// Checksum 0x36a195a3, Offset: 0xc70
// Size: 0xbc
function default_onspawnintermission()
{
    spawnpointname = "mp_global_intermission";
    spawnpoints = getentarray( spawnpointname, "classname" );
    spawnpoint = spawnpoints[ 0 ];
    
    if ( isdefined( spawnpoint ) )
    {
        self spawn( spawnpoint.origin, spawnpoint.angles );
        return;
    }
    
    /#
        util::error( "<dev string:x159>" + spawnpointname + "<dev string:x15d>" );
    #/
}

// Namespace globallogic_defaults
// Params 0
// Checksum 0xed10c520, Offset: 0xd38
// Size: 0x3a
function default_gettimelimit()
{
    return math::clamp( getgametypesetting( "timeLimit" ), level.timelimitmin, level.timelimitmax );
}

