#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_globallogic;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/cp/gametypes/_globallogic_utils;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/shared/math_shared;
#using scripts/shared/rank_shared;

#namespace globallogic_defaults;

// Namespace globallogic_defaults
// Params 1
// Checksum 0x1d8e98fb, Offset: 0x2d8
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
// Checksum 0xec77d729, Offset: 0x318
// Size: 0x324
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
    
    if ( level.multiteam )
    {
        setdvar( "ui_text_endreason", game[ "strings" ][ "other_teams_forfeited" ] );
        endreason = game[ "strings" ][ "other_teams_forfeited" ];
        winner = team;
    }
    else if ( !isdefined( team ) )
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
// Checksum 0x8248f09f, Offset: 0x648
// Size: 0xc4
function default_ondeadevent( team )
{
    if ( team == "all" )
    {
        winner = level.enemy_ai_team;
        globallogic_utils::logteamwinstring( "team eliminated", winner );
        thread globallogic::endgame( winner, &"SM_ALL_PLAYERS_KILLED" );
        return;
    }
    
    winner = getwinningteamfromloser( team );
    globallogic_utils::logteamwinstring( "team eliminated", winner );
    thread globallogic::endgame( winner, &"SM_ALL_PLAYERS_KILLED" );
}

// Namespace globallogic_defaults
// Params 1
// Checksum 0xb17c3eaf, Offset: 0x718
// Size: 0x184
function default_onlastteamaliveevent( team )
{
    if ( isdefined( level.teams[ team ] ) )
    {
        eliminatedstring = game[ "strings" ][ "enemies_eliminated" ];
        iprintln( eliminatedstring );
        setdvar( "ui_text_endreason", eliminatedstring );
        winner = globallogic::determineteamwinnerbygamestat( "teamScores" );
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
// Checksum 0x1c661e8a, Offset: 0x8a8
// Size: 0xe, Type: bool
function things_exist_which_could_revive_player( team )
{
    return false;
}

// Namespace globallogic_defaults
// Params 1
// Checksum 0x4d3d9222, Offset: 0x8c0
// Size: 0xae, Type: bool
function team_can_be_revived( team )
{
    if ( things_exist_which_could_revive_player( team ) )
    {
        return true;
    }
    
    if ( level.playercount[ team ] == 1 && level.alivecount[ team ] == 1 )
    {
        assert( level.aliveplayers[ team ].size == 1 );
        
        if ( level.aliveplayers[ team ][ 0 ].lives > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace globallogic_defaults
// Params 1
// Checksum 0xd888d4d, Offset: 0x978
// Size: 0x94
function default_onlaststandevent( team )
{
    if ( team_can_be_revived( team ) )
    {
        return;
    }
    
    if ( team == "all" )
    {
        thread globallogic::endgame( level.enemy_ai_team, &"SM_ALL_PLAYERS_KILLED" );
        return;
    }
    
    thread globallogic::endgame( util::getotherteam( team ), &"SM_ALL_PLAYERS_KILLED" );
}

// Namespace globallogic_defaults
// Params 1
// Checksum 0x8b5c3696, Offset: 0xa18
// Size: 0xc
function default_onalivecountchange( team )
{
    
}

// Namespace globallogic_defaults
// Params 1
// Checksum 0x302553b9, Offset: 0xa30
// Size: 0x10
function default_onroundendgame( winner )
{
    return winner;
}

// Namespace globallogic_defaults
// Params 1
// Checksum 0x4de415d7, Offset: 0xa48
// Size: 0x154
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
        }
    }
}

// Namespace globallogic_defaults
// Params 0
// Checksum 0x482c3a2b, Offset: 0xba8
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
// Checksum 0x8419719f, Offset: 0xcd8
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
// Checksum 0x52cbdf0e, Offset: 0xe18
// Size: 0x1a4
function default_onspawnspectator( origin, angles )
{
    if ( isdefined( origin ) && isdefined( angles ) )
    {
        self spawn( origin, angles );
        return;
    }
    
    spawnpointname = "cp_global_intermission";
    spawnpoints = struct::get_array( spawnpointname, "targetname" );
    assert( spawnpoints.size, "<dev string:xff>" + spawnpointname + "<dev string:x10d>" );
    spawnpoint = spawnlogic::get_spawnpoint_random( spawnpoints );
    assert( isdefined( spawnpoint.origin ), "<dev string:x144>" + spawnpointname + "<dev string:x156>" );
    assert( isdefined( spawnpoint.angles ), "<dev string:x144>" + spawnpointname + "<dev string:x167>" + spawnpoint.origin + "<dev string:x16d>" );
    self spawn( spawnpoint.origin, spawnpoint.angles );
}

// Namespace globallogic_defaults
// Params 0
// Checksum 0x239ef23e, Offset: 0xfc8
// Size: 0xbc
function default_onspawnintermission()
{
    spawnpointname = "cp_global_intermission";
    spawnpoints = struct::get_array( spawnpointname, "targetname" );
    spawnpoint = spawnpoints[ 0 ];
    
    if ( isdefined( spawnpoint ) )
    {
        self spawn( spawnpoint.origin, spawnpoint.angles );
        return;
    }
    
    /#
        util::error( "<dev string:x17c>" + spawnpointname + "<dev string:x180>" );
    #/
}

// Namespace globallogic_defaults
// Params 0
// Checksum 0xeeeb70b4, Offset: 0x1090
// Size: 0x3a
function default_gettimelimit()
{
    return math::clamp( getgametypesetting( "timeLimit" ), level.timelimitmin, level.timelimitmax );
}

// Namespace globallogic_defaults
// Params 4
// Checksum 0x6c66b424, Offset: 0x10d8
// Size: 0x72
function default_getteamkillpenalty( einflictor, attacker, smeansofdeath, weapon )
{
    teamkill_penalty = 1;
    score = globallogic_score::_getplayerscore( attacker );
    
    if ( score == 0 )
    {
        teamkill_penalty = 2;
    }
    
    return teamkill_penalty;
}

// Namespace globallogic_defaults
// Params 4
// Checksum 0xca25ed86, Offset: 0x1158
// Size: 0x3a
function default_getteamkillscore( einflictor, attacker, smeansofdeath, weapon )
{
    return rank::getscoreinfovalue( "team_kill" );
}

