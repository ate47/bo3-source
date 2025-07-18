#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/math_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/util_shared;

#namespace bwars;

// Namespace bwars
// Params 0
// Checksum 0xa02df722, Offset: 0x8a8
// Size: 0x274
function main()
{
    globallogic::init();
    util::registertimelimit( 0, 1440 );
    util::registerscorelimit( 0, 1000 );
    util::registerroundlimit( 0, 10 );
    util::registerroundwinlimit( 0, 10 );
    util::registerroundswitch( 0, 9 );
    util::registernumlives( 0, 100 );
    globallogic::registerfriendlyfiredelay( level.gametype, 15, 0, 1440 );
    level.scoreroundwinbased = getgametypesetting( "cumulativeRoundScores" ) == 0;
    level.teambased = 0;
    level.overrideteamscore = 1;
    level.overrideplayerscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerkilled = &onplayerkilled;
    level.onroundswitch = &onroundswitch;
    level.onprecachegametype = &onprecachegametype;
    level.onendgame = &onendgame;
    level.onroundendgame = &onroundendgame;
    gameobjects::register_allowed_gameobject( "dom" );
    game[ "dialog" ][ "gametype" ] = "dom_start";
    game[ "dialog" ][ "gametype_hardcore" ] = "hcdom_start";
    game[ "dialog" ][ "offense_obj" ] = "cap_start";
    game[ "dialog" ][ "defense_obj" ] = "cap_start";
    level.lastdialogtime = 0;
    globallogic::setvisiblescoreboardcolumns( "score", "kills", "deaths", "captures", "defends" );
}

// Namespace bwars
// Params 0
// Checksum 0x99ec1590, Offset: 0xb28
// Size: 0x4
function onprecachegametype()
{
    
}

// Namespace bwars
// Params 0
// Checksum 0xf5d6b2e, Offset: 0xb38
// Size: 0x41c
function onstartgametype()
{
    util::setobjectivetext( "allies", &"OBJECTIVES_DOM" );
    util::setobjectivetext( "axis", &"OBJECTIVES_DOM" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    if ( level.splitscreen )
    {
        util::setobjectivescoretext( "allies", &"OBJECTIVES_DOM" );
        util::setobjectivescoretext( "axis", &"OBJECTIVES_DOM" );
    }
    else
    {
        util::setobjectivescoretext( "allies", &"OBJECTIVES_DOM_SCORE" );
        util::setobjectivescoretext( "axis", &"OBJECTIVES_DOM_SCORE" );
    }
    
    util::setobjectivehinttext( "allies", &"OBJECTIVES_DOM_HINT" );
    util::setobjectivehinttext( "axis", &"OBJECTIVES_DOM_HINT" );
    level.flagbasefxid = [];
    level.flagbasefxid[ "allies" ] = "_t6/misc/fx_ui_flagbase_gold_t5";
    level.flagbasefxid[ "axis" ] = "_t6/misc/fx_ui_flagbase_gold_t5";
    setclientnamemode( "auto_change" );
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    spawnlogic::place_spawn_points( "mp_dom_spawn_allies_start" );
    spawnlogic::place_spawn_points( "mp_dom_spawn_axis_start" );
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint( spawnpoint.origin, spawnpoint.angles );
    level.spawn_all = spawnlogic::get_spawnpoint_array( "mp_dom_spawn" );
    level.spawn_axis_start = spawnlogic::get_spawnpoint_array( "mp_dom_spawn_axis_start" );
    level.spawn_allies_start = spawnlogic::get_spawnpoint_array( "mp_dom_spawn_allies_start" );
    flagspawns = spawnlogic::get_spawnpoint_array( "mp_dom_spawn_flag_a" );
    level.startpos[ "allies" ] = level.spawn_allies_start[ 0 ].origin;
    level.startpos[ "axis" ] = level.spawn_axis_start[ 0 ].origin;
    spawning::create_map_placed_influencers();
    
    if ( !util::isoneround() && level.scoreroundwinbased )
    {
        globallogic_score::resetteamscores();
    }
    
    updategametypedvars();
    bwars_init();
    level thread bwars_update_scores();
    bwars_spawns_update();
}

// Namespace bwars
// Params 1
// Checksum 0x2a1af82a, Offset: 0xf60
// Size: 0xc
function onendgame( winningteam )
{
    
}

// Namespace bwars
// Params 1
// Checksum 0x9007916c, Offset: 0xf78
// Size: 0x10c
function onroundendgame( roundwinner )
{
    if ( level.scoreroundwinbased )
    {
        [[ level._setteamscore ]]( "allies", game[ "roundswon" ][ "allies" ] );
        [[ level._setteamscore ]]( "axis", game[ "roundswon" ][ "axis" ] );
    }
    
    axisscore = [[ level._getteamscore ]]( "axis" );
    alliedscore = [[ level._getteamscore ]]( "allies" );
    
    if ( axisscore == alliedscore )
    {
        winner = "tie";
    }
    else if ( axisscore > alliedscore )
    {
        winner = "axis";
    }
    else
    {
        winner = "allies";
    }
    
    return winner;
}

// Namespace bwars
// Params 0
// Checksum 0x62905462, Offset: 0x1090
// Size: 0x164
function updategametypedvars()
{
    level.flagcapturetime = getgametypesetting( "captureTime" );
    level.flagcapturelpm = math::clamp( getdvarfloat( "maxFlagCapturePerMinute", 3 ), 0, 10 );
    level.playercapturelpm = math::clamp( getdvarfloat( "maxPlayerCapturePerMinute", 2 ), 0, 10 );
    level.playercapturemax = math::clamp( getdvarfloat( "maxPlayerCapture", 1000 ), 0, 1000 );
    level.playeroffensivemax = math::clamp( getdvarfloat( "maxPlayerOffensive", 16 ), 0, 1000 );
    level.playerdefensivemax = math::clamp( getdvarfloat( "maxPlayerDefensive", 16 ), 0, 1000 );
}

// Namespace bwars
// Params 0
// Checksum 0xed93ed58, Offset: 0x1200
// Size: 0x2ac
function bwars_init()
{
    level.laststatus[ "allies" ] = 0;
    level.laststatus[ "axis" ] = 0;
    triggers = getentarray( "flag_primary", "targetname" );
    
    if ( !triggers.size )
    {
        println( "^1Not enough domination flags found in level!" );
        callback::abort_level();
        return;
    }
    
    level.bwars_flags = [];
    
    foreach ( trigger in triggers )
    {
        visuals = trigger flag_model_init();
        flag = gameobjects::create_use_object( "neutral", trigger, visuals, ( 0, 0, 100 ) );
        objective_delete( flag.objidallies );
        gameobjects::release_obj_id( flag.objidallies );
        flag gameobjects::allow_use( "any" );
        flag gameobjects::set_use_time( level.flagcapturetime );
        flag gameobjects::set_use_text( &"MP_CAPTURING_FLAG" );
        flag gameobjects::set_visible_team( "any" );
        flag flag_compass_init();
        flag.onuse = &onuse;
        flag.onbeginuse = &onbeginuse;
        flag.onuseupdate = &onuseupdate;
        flag.onenduse = &onenduse;
        level.bwars_flags[ level.bwars_flags.size ] = flag;
    }
}

// Namespace bwars
// Params 0
// Checksum 0x44ca4a, Offset: 0x14b8
// Size: 0x29c
function player_hud_init()
{
    if ( isdefined( self.bwars_hud ) )
    {
        return;
    }
    
    self.bwars_hud = [];
    x = -40;
    y = 300;
    
    for ( i = 0; i < 4 ; i++ )
    {
        hud = newclienthudelem( self );
        hud.alignx = "left";
        hud.aligny = "middle";
        hud.foreground = 1;
        hud.fontscale = 1.5;
        hud.alpha = 0.8;
        hud.x = x;
        hud.y = y;
        hud.hidewhendead = 1;
        hud.hidewheninkillcam = 1;
        hud.score = newclienthudelem( self );
        hud.score.alignx = "left";
        hud.score.aligny = "middle";
        hud.score.foreground = 1;
        hud.score.fontscale = 1.5;
        hud.score.alpha = 0.8;
        hud.score.x = x + 125;
        hud.score.y = y;
        hud.score.hidewhendead = 1;
        hud.score.hidewheninkillcam = 1;
        self.bwars_hud[ self.bwars_hud.size ] = hud;
        y += 15;
    }
    
    level bwars_scoreboard_update();
}

// Namespace bwars
// Params 2
// Checksum 0x2fbad4b0, Offset: 0x1760
// Size: 0x1aa
function player_hud_update( names, scores )
{
    if ( !isdefined( self.bwars_hud ) )
    {
        return;
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        self.bwars_hud[ i ] settext( names[ i ] );
        
        if ( names[ i ] == "" )
        {
            self.bwars_hud[ i ].score settext( "" );
        }
        else
        {
            self.bwars_hud[ i ].score setvalue( scores[ i ] );
        }
        
        if ( names[ i ] == self.name )
        {
            self.bwars_hud[ i ].color = ( 1, 0.84, 0 );
            self.bwars_hud[ i ].score.color = ( 1, 0.84, 0 );
            continue;
        }
        
        self.bwars_hud[ i ].color = ( 1, 1, 1 );
        self.bwars_hud[ i ].score.color = ( 1, 1, 1 );
    }
}

// Namespace bwars
// Params 0
// Checksum 0xdef0191f, Offset: 0x1918
// Size: 0xfe
function bubblesort_players()
{
    players = getplayers();
    
    while ( true )
    {
        swapped = 0;
        
        for ( i = 1; i < players.size ; i++ )
        {
            if ( players[ i - 1 ].score < players[ i ].score )
            {
                t = players[ i - 1 ];
                players[ i - 1 ] = players[ i ];
                players[ i ] = t;
                swapped = 1;
            }
        }
        
        if ( !swapped )
        {
            break;
        }
    }
    
    return players;
}

// Namespace bwars
// Params 0
// Checksum 0xe745ffc4, Offset: 0x1a20
// Size: 0x16a
function bwars_scoreboard_update()
{
    names = [];
    scores = [];
    players = bubblesort_players();
    
    for ( i = 0; i < 4 ; i++ )
    {
        if ( players.size > i )
        {
            names[ i ] = players[ i ].name;
            scores[ i ] = players[ i ].score;
            continue;
        }
        
        names[ i ] = "";
        scores[ i ] = -1;
    }
    
    foreach ( player in players )
    {
        player player_hud_update( names, scores );
    }
}

// Namespace bwars
// Params 0
// Checksum 0x96207e, Offset: 0x1b98
// Size: 0x120
function flag_model_init()
{
    visuals = [];
    visuals[ 0 ] = spawn( "script_model", self.origin );
    visuals[ 0 ].angles = self.angles;
    visuals[ 0 ] setmodel( "p7_mp_flag_neutral" );
    visuals[ 0 ] setinvisibletoall();
    visuals[ 1 ] = spawn( "script_model", self.origin );
    visuals[ 1 ].angles = self.angles;
    visuals[ 1 ] setmodel( "p7_mp_flag_neutral" );
    visuals[ 1 ] setvisibletoall();
    return visuals;
}

// Namespace bwars
// Params 0
// Checksum 0xac42a213, Offset: 0x1cc0
// Size: 0xfc
function flag_model_update()
{
    owner = self gameobjects::get_owner_team();
    self.visuals[ 0 ] setmodel( "p7_mp_flag_allies" );
    self.visuals[ 0 ] setinvisibletoall();
    self.visuals[ 0 ] setvisibletoplayer( owner );
    self.visuals[ 1 ] setmodel( "p7_mp_flag_axis" );
    self.visuals[ 1 ] setvisibletoall();
    self.visuals[ 1 ] setinvisibletoplayer( owner );
}

// Namespace bwars
// Params 0
// Checksum 0x6a9e41c9, Offset: 0x1dc8
// Size: 0x16c
function flag_compass_init()
{
    self.compass_icons = [];
    self.compass_icons[ 0 ] = gameobjects::get_next_obj_id();
    self.compass_icons[ 1 ] = gameobjects::get_next_obj_id();
    label = self gameobjects::get_label();
    objective_add( self.compass_icons[ 0 ], "active", self.curorigin );
    objective_icon( self.compass_icons[ 0 ], "compass_waypoint_defend" + label );
    objective_setinvisibletoall( self.compass_icons[ 0 ] );
    objective_add( self.compass_icons[ 1 ], "active", self.curorigin );
    objective_icon( self.compass_icons[ 1 ], "compass_waypoint_captureneutral" + label );
    objective_setvisibletoall( self.compass_icons[ 1 ] );
}

// Namespace bwars
// Params 0
// Checksum 0xc394f135, Offset: 0x1f40
// Size: 0x17c
function flag_compass_update()
{
    label = self gameobjects::get_label();
    owner = self gameobjects::get_owner_team();
    objective_icon( self.compass_icons[ 0 ], "compass_waypoint_defend" + label );
    objective_state( self.compass_icons[ 0 ], "active" );
    objective_setinvisibletoall( self.compass_icons[ 0 ] );
    objective_setvisibletoplayer( self.compass_icons[ 0 ], owner );
    objective_icon( self.compass_icons[ 1 ], "compass_waypoint_capture" + label );
    objective_state( self.compass_icons[ 1 ], "active" );
    objective_setvisibletoall( self.compass_icons[ 1 ] );
    objective_setinvisibletoplayer( self.compass_icons[ 1 ], owner );
}

// Namespace bwars
// Params 0
// Checksum 0x9116e208, Offset: 0x20c8
// Size: 0x194
function player_world_icon_init()
{
    if ( isdefined( self.bwars_icons ) )
    {
        return;
    }
    
    self.bwars_icons = [];
    
    foreach ( flag in level.bwars_flags )
    {
        icon = newclienthudelem( self );
        icon.flag = flag;
        icon.x = flag.curorigin[ 0 ];
        icon.y = flag.curorigin[ 1 ];
        icon.z = flag.curorigin[ 2 ] + 100;
        icon.fadewhentargeted = 1;
        icon.archived = 0;
        icon.alpha = 1;
        self.bwars_icons[ self.bwars_icons.size ] = icon;
    }
    
    self player_world_icon_update();
}

// Namespace bwars
// Params 0
// Checksum 0xa5e81c02, Offset: 0x2268
// Size: 0x1a2
function player_world_icon_update()
{
    assert( isdefined( self.bwars_icons ) );
    
    foreach ( icon in self.bwars_icons )
    {
        label = icon.flag gameobjects::get_label();
        owner = icon.flag gameobjects::get_owner_team();
        
        if ( isstring( owner ) && owner == "neutral" )
        {
            icon setwaypoint( 1, "waypoint_captureneutral" + label );
            continue;
        }
        
        if ( owner == self )
        {
            icon setwaypoint( 1, "waypoint_defend" + label );
            continue;
        }
        
        icon setwaypoint( 1, "waypoint_capture" + label );
    }
}

// Namespace bwars
// Params 0
// Checksum 0x161325a1, Offset: 0x2418
// Size: 0xa2
function world_icon_update()
{
    players = getplayers();
    
    foreach ( player in players )
    {
        player player_world_icon_update();
    }
}

// Namespace bwars
// Params 2
// Checksum 0x5bad53c5, Offset: 0x24c8
// Size: 0x12e
function getunownedflagneareststart( team, excludeflag )
{
    best = undefined;
    bestdistsq = undefined;
    
    for ( i = 0; i < level.flags.size ; i++ )
    {
        flag = level.flags[ i ];
        
        if ( flag getflagteam() != "neutral" )
        {
            continue;
        }
        
        distsq = distancesquared( flag.origin, level.startpos[ team ] );
        
        if ( !isdefined( best ) || ( !isdefined( excludeflag ) || flag != excludeflag ) && distsq < bestdistsq )
        {
            bestdistsq = distsq;
            best = flag;
        }
    }
    
    return best;
}

// Namespace bwars
// Params 1
// Checksum 0xcc266779, Offset: 0x2600
// Size: 0xc
function onbeginuse( player )
{
    
}

// Namespace bwars
// Params 3
// Checksum 0x2c1c1d66, Offset: 0x2618
// Size: 0x1c
function onuseupdate( team, progress, change )
{
    
}

// Namespace bwars
// Params 2
// Checksum 0x1985ee64, Offset: 0x2640
// Size: 0x6e
function statusdialog( dialog, team )
{
    time = gettime();
    
    if ( gettime() < level.laststatus[ team ] + 6000 )
    {
        return;
    }
    
    thread delayedleaderdialog( dialog, team );
    level.laststatus[ team ] = gettime();
}

// Namespace bwars
// Params 2
// Checksum 0x67c599b8, Offset: 0x26b8
// Size: 0xb2
function statusdialogenemies( dialog, friend_team )
{
    foreach ( team in level.teams )
    {
        if ( team == friend_team )
        {
            continue;
        }
        
        statusdialog( dialog, team );
    }
}

// Namespace bwars
// Params 3
// Checksum 0x7373a36b, Offset: 0x2778
// Size: 0x1c
function onenduse( team, player, success )
{
    
}

// Namespace bwars
// Params 0
// Checksum 0x99ec1590, Offset: 0x27a0
// Size: 0x4
function resetflagbaseeffect()
{
    
}

// Namespace bwars
// Params 1
// Checksum 0xbc469af, Offset: 0x27b0
// Size: 0xa4
function onuse( player )
{
    self gameobjects::set_owner_team( player );
    self gameobjects::allow_use( "enemy" );
    self flag_compass_update();
    self flag_model_update();
    level world_icon_update();
    level bwars_spawns_update();
}

// Namespace bwars
// Params 2
// Checksum 0x3344b802, Offset: 0x2860
// Size: 0x19e
function give_capture_credit( touchlist, string )
{
    wait 0.05;
    util::waittillslowprocessallowed();
    self updatecapsperminute();
    players = getarraykeys( touchlist );
    
    for ( i = 0; i < players.size ; i++ )
    {
        player_from_touchlist = touchlist[ players[ i ] ].player;
        player_from_touchlist updatecapsperminute();
        
        if ( !isscoreboosting( player_from_touchlist, self ) )
        {
            if ( isdefined( player_from_touchlist.pers[ "captures" ] ) )
            {
                player_from_touchlist.pers[ "captures" ]++;
                player_from_touchlist.captures = player_from_touchlist.pers[ "captures" ];
            }
            
            demo::bookmark( "event", gettime(), player_from_touchlist );
            player_from_touchlist addplayerstatwithgametype( "CAPTURES", 1 );
        }
        
        level thread popups::displayteammessagetoall( string, player_from_touchlist );
    }
}

// Namespace bwars
// Params 2
// Checksum 0x57f1d6ac, Offset: 0x2a08
// Size: 0x44
function delayedleaderdialog( sound, team )
{
    wait 0.1;
    util::waittillslowprocessallowed();
    globallogic_audio::leader_dialog( sound, team );
}

// Namespace bwars
// Params 4
// Checksum 0x1b522b10, Offset: 0x2a58
// Size: 0x3c
function delayedleaderdialogbothteams( sound1, team1, sound2, team2 )
{
    wait 0.1;
    util::waittillslowprocessallowed();
}

// Namespace bwars
// Params 0
// Checksum 0x1a450def, Offset: 0x2aa0
// Size: 0x1b0
function bwars_update_scores()
{
    while ( !level.gameended )
    {
        foreach ( flag in level.bwars_flags )
        {
            owner = flag gameobjects::get_owner_team();
            
            if ( isplayer( owner ) )
            {
                owner.score += 1;
            }
        }
        
        level bwars_scoreboard_update();
        players = getplayers();
        
        foreach ( player in players )
        {
            player globallogic::checkscorelimit();
        }
        
        wait 5;
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace bwars
// Params 0
// Checksum 0x7a245e66, Offset: 0x2c58
// Size: 0xa0
function onroundswitch()
{
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    game[ "switchedsides" ] = !game[ "switchedsides" ];
    
    if ( level.cumulativeroundscore == 0 )
    {
        [[ level._setteamscore ]]( "allies", game[ "roundswon" ][ "allies" ] );
        [[ level._setteamscore ]]( "axis", game[ "roundswon" ][ "axis" ] );
    }
}

// Namespace bwars
// Params 9
// Checksum 0x79966b49, Offset: 0x2d00
// Size: 0x4c
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    
}

// Namespace bwars
// Params 1
// Checksum 0xb3f91ed4, Offset: 0x2d58
// Size: 0x78
function getteamflagcount( team )
{
    score = 0;
    
    for ( i = 0; i < level.flags.size ; i++ )
    {
        if ( level.domflags[ i ] gameobjects::get_owner_team() == team )
        {
            score++;
        }
    }
    
    return score;
}

// Namespace bwars
// Params 0
// Checksum 0x3c414528, Offset: 0x2dd8
// Size: 0x1a
function getflagteam()
{
    return self.useobj gameobjects::get_owner_team();
}

// Namespace bwars
// Params 0
// Checksum 0xfadcf887, Offset: 0x2e00
// Size: 0x106
function getboundaryflags()
{
    bflags = [];
    
    for ( i = 0; i < level.flags.size ; i++ )
    {
        for ( j = 0; j < level.flags[ i ].adjflags.size ; j++ )
        {
            if ( level.flags[ i ].useobj gameobjects::get_owner_team() != level.flags[ i ].adjflags[ j ].useobj gameobjects::get_owner_team() )
            {
                bflags[ bflags.size ] = level.flags[ i ];
                break;
            }
        }
    }
    
    return bflags;
}

// Namespace bwars
// Params 1
// Checksum 0x6e5b7e04, Offset: 0x2f10
// Size: 0xf6
function getboundaryflagspawns( team )
{
    spawns = [];
    bflags = getboundaryflags();
    
    for ( i = 0; i < bflags.size ; i++ )
    {
        if ( isdefined( team ) && bflags[ i ] getflagteam() != team )
        {
            continue;
        }
        
        for ( j = 0; j < bflags[ i ].nearbyspawns.size ; j++ )
        {
            spawns[ spawns.size ] = bflags[ i ].nearbyspawns[ j ];
        }
    }
    
    return spawns;
}

// Namespace bwars
// Params 1
// Checksum 0x27a34972, Offset: 0x3010
// Size: 0x13e
function getspawnsboundingflag( avoidflag )
{
    spawns = [];
    
    for ( i = 0; i < level.flags.size ; i++ )
    {
        flag = level.flags[ i ];
        
        if ( flag == avoidflag )
        {
            continue;
        }
        
        isbounding = 0;
        
        for ( j = 0; j < flag.adjflags.size ; j++ )
        {
            if ( flag.adjflags[ j ] == avoidflag )
            {
                isbounding = 1;
                break;
            }
        }
        
        if ( !isbounding )
        {
            continue;
        }
        
        for ( j = 0; j < flag.nearbyspawns.size ; j++ )
        {
            spawns[ spawns.size ] = flag.nearbyspawns[ j ];
        }
    }
    
    return spawns;
}

// Namespace bwars
// Params 1
// Checksum 0x5b334fb0, Offset: 0x3158
// Size: 0x1b8
function getownedandboundingflagspawns( team )
{
    spawns = [];
    
    for ( i = 0; i < level.flags.size ; i++ )
    {
        if ( level.flags[ i ] getflagteam() == team )
        {
            for ( s = 0; s < level.flags[ i ].nearbyspawns.size ; s++ )
            {
                spawns[ spawns.size ] = level.flags[ i ].nearbyspawns[ s ];
            }
            
            continue;
        }
        
        for ( j = 0; j < level.flags[ i ].adjflags.size ; j++ )
        {
            if ( level.flags[ i ].adjflags[ j ] getflagteam() == team )
            {
                for ( s = 0; s < level.flags[ i ].nearbyspawns.size ; s++ )
                {
                    spawns[ spawns.size ] = level.flags[ i ].nearbyspawns[ s ];
                }
                
                break;
            }
        }
    }
    
    return spawns;
}

// Namespace bwars
// Params 1
// Checksum 0x446e5604, Offset: 0x3318
// Size: 0xda
function getownedflagspawns( team )
{
    spawns = [];
    
    for ( i = 0; i < level.flags.size ; i++ )
    {
        if ( level.flags[ i ] getflagteam() == team )
        {
            for ( s = 0; s < level.flags[ i ].nearbyspawns.size ; s++ )
            {
                spawns[ spawns.size ] = level.flags[ i ].nearbyspawns[ s ];
            }
        }
    }
    
    return spawns;
}

// Namespace bwars
// Params 0
// Checksum 0xc819e9e8, Offset: 0x3400
// Size: 0x68e
function flagsetup()
{
    maperrors = [];
    descriptorsbylinkname = [];
    descriptors = getentarray( "flag_descriptor", "targetname" );
    flags = level.flags;
    
    for ( i = 0; i < level.domflags.size ; i++ )
    {
        closestdist = undefined;
        closestdesc = undefined;
        
        for ( j = 0; j < descriptors.size ; j++ )
        {
            dist = distance( flags[ i ].origin, descriptors[ j ].origin );
            
            if ( !isdefined( closestdist ) || dist < closestdist )
            {
                closestdist = dist;
                closestdesc = descriptors[ j ];
            }
        }
        
        if ( !isdefined( closestdesc ) )
        {
            maperrors[ maperrors.size ] = "there is no flag_descriptor in the map! see explanation in dom.gsc";
            break;
        }
        
        if ( isdefined( closestdesc.flag ) )
        {
            maperrors[ maperrors.size ] = "flag_descriptor with script_linkname \"" + closestdesc.script_linkname + "\" is nearby more than one flag; is there a unique descriptor near each flag?";
            continue;
        }
        
        flags[ i ].descriptor = closestdesc;
        closestdesc.flag = flags[ i ];
        descriptorsbylinkname[ closestdesc.script_linkname ] = closestdesc;
    }
    
    if ( maperrors.size == 0 )
    {
        for ( i = 0; i < flags.size ; i++ )
        {
            if ( isdefined( flags[ i ].descriptor.script_linkto ) )
            {
                adjdescs = strtok( flags[ i ].descriptor.script_linkto, " " );
            }
            else
            {
                adjdescs = [];
            }
            
            for ( j = 0; j < adjdescs.size ; j++ )
            {
                otherdesc = descriptorsbylinkname[ adjdescs[ j ] ];
                
                if ( !isdefined( otherdesc ) || otherdesc.targetname != "flag_descriptor" )
                {
                    maperrors[ maperrors.size ] = "flag_descriptor with script_linkname \"" + flags[ i ].descriptor.script_linkname + "\" linked to \"" + adjdescs[ j ] + "\" which does not exist as a script_linkname of any other entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)";
                    continue;
                }
                
                adjflag = otherdesc.flag;
                
                if ( adjflag == flags[ i ] )
                {
                    maperrors[ maperrors.size ] = "flag_descriptor with script_linkname \"" + flags[ i ].descriptor.script_linkname + "\" linked to itself";
                    continue;
                }
                
                flags[ i ].adjflags[ flags[ i ].adjflags.size ] = adjflag;
            }
        }
    }
    
    spawnpoints = spawnlogic::get_spawnpoint_array( "mp_dom_spawn" );
    
    for ( i = 0; i < spawnpoints.size ; i++ )
    {
        if ( isdefined( spawnpoints[ i ].script_linkto ) )
        {
            desc = descriptorsbylinkname[ spawnpoints[ i ].script_linkto ];
            
            if ( !isdefined( desc ) || desc.targetname != "flag_descriptor" )
            {
                maperrors[ maperrors.size ] = "Spawnpoint at " + spawnpoints[ i ].origin + "\" linked to \"" + spawnpoints[ i ].script_linkto + "\" which does not exist as a script_linkname of any entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)";
                continue;
            }
            
            nearestflag = desc.flag;
        }
        else
        {
            nearestflag = undefined;
            nearestdist = undefined;
            
            for ( j = 0; j < flags.size ; j++ )
            {
                dist = distancesquared( flags[ j ].origin, spawnpoints[ i ].origin );
                
                if ( !isdefined( nearestflag ) || dist < nearestdist )
                {
                    nearestflag = flags[ j ];
                    nearestdist = dist;
                }
            }
        }
        
        nearestflag.nearbyspawns[ nearestflag.nearbyspawns.size ] = spawnpoints[ i ];
    }
    
    if ( maperrors.size > 0 )
    {
        /#
            println( "<dev string:x28>" );
            
            for ( i = 0; i < maperrors.size ; i++ )
            {
                println( maperrors[ i ] );
            }
            
            println( "<dev string:x4f>" );
            util::error( "<dev string:x76>" );
        #/
        
        callback::abort_level();
        return;
    }
}

// Namespace bwars
// Params 0
// Checksum 0x25255e0b, Offset: 0x3a98
// Size: 0x124
function createflagspawninfluencers()
{
    ss = level.spawnsystem;
    
    for ( flag_index = 0; flag_index < level.flags.size ; flag_index++ )
    {
        if ( level.domflags[ flag_index ] == self )
        {
            break;
        }
    }
    
    self.owned_flag_influencer = self spawning::create_influencer( "dom_friendly", self.trigger.origin, 0 );
    self.neutral_flag_influencer = self spawning::create_influencer( "dom_neutral", self.trigger.origin, 0 );
    self.enemy_flag_influencer = self spawning::create_influencer( "dom_enemy", self.trigger.origin, 0 );
    self update_spawn_influencers( "neutral" );
}

// Namespace bwars
// Params 1
// Checksum 0x6133ad64, Offset: 0x3bc8
// Size: 0x18c
function update_spawn_influencers( team )
{
    assert( isdefined( self.neutral_flag_influencer ) );
    assert( isdefined( self.owned_flag_influencer ) );
    assert( isdefined( self.enemy_flag_influencer ) );
    
    if ( team == "neutral" )
    {
        enableinfluencer( self.neutral_flag_influencer, 1 );
        enableinfluencer( self.owned_flag_influencer, 0 );
        enableinfluencer( self.enemy_flag_influencer, 0 );
        return;
    }
    
    enableinfluencer( self.neutral_flag_influencer, 0 );
    enableinfluencer( self.owned_flag_influencer, 1 );
    enableinfluencer( self.enemy_flag_influencer, 1 );
    setinfluencerteammask( self.owned_flag_influencer, util::getteammask( team ) );
    setinfluencerteammask( self.enemy_flag_influencer, util::getotherteamsmask( team ) );
}

// Namespace bwars
// Params 0
// Checksum 0xfd84096c, Offset: 0x3d60
// Size: 0x64
function bwars_spawns_update()
{
    spawnlogic::clear_spawn_points();
    spawnlogic::add_spawn_points( "axis", "mp_dom_spawn" );
    spawnlogic::add_spawn_points( "allies", "mp_dom_spawn" );
    spawning::updateallspawnpoints();
}

// Namespace bwars
// Params 0
// Checksum 0xdf34b8ae, Offset: 0x3dd0
// Size: 0xec, Type: bool
function dominated_challenge_check()
{
    num_flags = level.flags.size;
    allied_flags = 0;
    axis_flags = 0;
    
    for ( i = 0; i < num_flags ; i++ )
    {
        flag_team = level.flags[ i ] getflagteam();
        
        if ( flag_team == "allies" )
        {
            allied_flags++;
        }
        else if ( flag_team == "axis" )
        {
            axis_flags++;
        }
        else
        {
            return false;
        }
        
        if ( allied_flags > 0 && axis_flags > 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace bwars
// Params 0
// Checksum 0xb45bc6d8, Offset: 0x3ec8
// Size: 0xe4, Type: bool
function dominated_check()
{
    num_flags = level.flags.size;
    allied_flags = 0;
    axis_flags = 0;
    
    for ( i = 0; i < num_flags ; i++ )
    {
        flag_team = level.flags[ i ] getflagteam();
        
        if ( flag_team == "allies" )
        {
            allied_flags++;
        }
        else if ( flag_team == "axis" )
        {
            axis_flags++;
        }
        
        if ( allied_flags > 0 && axis_flags > 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace bwars
// Params 0
// Checksum 0xe2d37f5f, Offset: 0x3fb8
// Size: 0xdc
function updatecapsperminute()
{
    if ( !isdefined( self.capsperminute ) )
    {
        self.numcaps = 0;
        self.capsperminute = 0;
    }
    
    self.numcaps++;
    minutespassed = globallogic_utils::gettimepassed() / 60000;
    
    if ( isplayer( self ) && isdefined( self.timeplayed[ "total" ] ) )
    {
        minutespassed = self.timeplayed[ "total" ] / 60;
    }
    
    self.capsperminute = self.numcaps / minutespassed;
    
    if ( self.capsperminute > self.numcaps )
    {
        self.capsperminute = self.numcaps;
    }
}

// Namespace bwars
// Params 2
// Checksum 0x31abffda, Offset: 0x40a0
// Size: 0x84, Type: bool
function isscoreboosting( player, flag )
{
    if ( !level.rankedmatch )
    {
        return false;
    }
    
    if ( player.capsperminute > level.playercapturelpm )
    {
        return true;
    }
    
    if ( flag.capsperminute > level.flagcapturelpm )
    {
        return true;
    }
    
    if ( player.numcaps > level.playercapturemax )
    {
        return true;
    }
    
    return false;
}

