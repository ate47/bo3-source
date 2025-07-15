#using scripts/cp/_util;
#using scripts/cp/gametypes/_globallogic;
#using scripts/cp/gametypes/_globallogic_player;
#using scripts/cp/gametypes/_loadout;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_spectating;
#using scripts/cp/teams/_teams;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/string_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace globallogic_ui;

// Namespace globallogic_ui
// Params 0
// Checksum 0xbccf1cf4, Offset: 0x658
// Size: 0x17c
function init()
{
    callback::add_callback( #"hash_bc12b61f", &on_player_spawn );
    clientfield::register( "clientuimodel", "hudItems.cybercoreSelectMenuDisabled", 1, 1, "int" );
    clientfield::register( "clientuimodel", "hudItems.playerInCombat", 1, 1, "int" );
    clientfield::register( "clientuimodel", "playerAbilities.repulsorIndicatorDirection", 1, 2, "int" );
    clientfield::register( "clientuimodel", "playerAbilities.repulsorIndicatorIntensity", 1, 2, "int" );
    clientfield::register( "clientuimodel", "playerAbilities.proximityIndicatorDirection", 1, 2, "int" );
    clientfield::register( "clientuimodel", "playerAbilities.proximityIndicatorIntensity", 1, 2, "int" );
    clientfield::register( "clientuimodel", "serverDifficulty", 1, 3, "int" );
}

// Namespace globallogic_ui
// Params 0
// Checksum 0xa330c9a5, Offset: 0x7e0
// Size: 0x64
function on_player_spawn()
{
    self thread watch_player_in_combat();
    assert( isdefined( level.gameskill ) );
    self clientfield::set_player_uimodel( "serverDifficulty", level.gameskill );
}

// Namespace globallogic_ui
// Params 1
// Checksum 0x6c74607d, Offset: 0x850
// Size: 0x1a0, Type: bool
function isanyaiattackingtheplayer( playerent )
{
    ais = getaiteamarray( "axis" );
    ais = arraycombine( ais, getaiteamarray( "team3" ), 0, 0 );
    
    foreach ( ai in ais )
    {
        if ( issentient( ai ) )
        {
            if ( ai attackedrecently( playerent, 10 ) )
            {
                return true;
            }
            
            if ( ai.enemy === playerent && isdefined( ai.weapon ) && ai.weapon.name === "none" && distancesquared( ai.origin, playerent.origin ) < 240 * 240 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace globallogic_ui
// Params 1
// Checksum 0x1d89981b, Offset: 0x9f8
// Size: 0x116, Type: bool
function isanyaiawareofplayer( playerent )
{
    ais = getaiteamarray( "axis" );
    ais = arraycombine( ais, getaiteamarray( "team3" ), 0, 0 );
    
    foreach ( ai in ais )
    {
        if ( issentient( ai ) )
        {
            if ( ai lastknowntime( playerent ) + 4000 >= gettime() )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace globallogic_ui
// Params 1
// Checksum 0x58db2e83, Offset: 0xb18
// Size: 0x28, Type: bool
function isplayerhurt( playerent )
{
    return playerent.health < playerent.maxhealth;
}

// Namespace globallogic_ui
// Params 0
// Checksum 0x35313c8a, Offset: 0xb48
// Size: 0x98
function watch_player_in_combat()
{
    self endon( #"kill_watch_player_in_combat" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( isplayerhurt( self ) || isanyaiattackingtheplayer( self ) )
        {
            self clientfield::set_player_uimodel( "hudItems.playerInCombat", 1 );
        }
        else
        {
            self clientfield::set_player_uimodel( "hudItems.playerInCombat", 0 );
        }
        
        wait 0.5;
    }
}

// Namespace globallogic_ui
// Params 0
// Checksum 0x9d2ca19f, Offset: 0xbe8
// Size: 0x64
function setupcallbacks()
{
    level.autoassign = &menuautoassign;
    level.spectator = &menuspectator;
    level.curclass = &menuclass;
    level.teammenu = &menuteam;
}

// Namespace globallogic_ui
// Params 0
// Checksum 0xe5b262b4, Offset: 0xc58
// Size: 0x27c
function freegameplayhudelems()
{
    if ( isdefined( self.perkicon ) )
    {
        for ( numspecialties = 0; numspecialties < level.maxspecialties ; numspecialties++ )
        {
            if ( isdefined( self.perkicon[ numspecialties ] ) )
            {
                self.perkicon[ numspecialties ] hud::destroyelem();
                self.perkname[ numspecialties ] hud::destroyelem();
            }
        }
    }
    
    if ( isdefined( self.perkhudelem ) )
    {
        self.perkhudelem hud::destroyelem();
    }
    
    if ( isdefined( self.killstreakicon ) )
    {
        if ( isdefined( self.killstreakicon[ 0 ] ) )
        {
            self.killstreakicon[ 0 ] hud::destroyelem();
        }
        
        if ( isdefined( self.killstreakicon[ 1 ] ) )
        {
            self.killstreakicon[ 1 ] hud::destroyelem();
        }
        
        if ( isdefined( self.killstreakicon[ 2 ] ) )
        {
            self.killstreakicon[ 2 ] hud::destroyelem();
        }
        
        if ( isdefined( self.killstreakicon[ 3 ] ) )
        {
            self.killstreakicon[ 3 ] hud::destroyelem();
        }
        
        if ( isdefined( self.killstreakicon[ 4 ] ) )
        {
            self.killstreakicon[ 4 ] hud::destroyelem();
        }
    }
    
    if ( isdefined( self.lowermessage ) )
    {
        self.lowermessage hud::destroyelem();
    }
    
    if ( isdefined( self.lowertimer ) )
    {
        self.lowertimer hud::destroyelem();
    }
    
    if ( isdefined( self.proxbar ) )
    {
        self.proxbar hud::destroyelem();
    }
    
    if ( isdefined( self.proxbartext ) )
    {
        self.proxbartext hud::destroyelem();
    }
    
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon hud::destroyelem();
    }
}

// Namespace globallogic_ui
// Params 1
// Checksum 0x7fe78b3e, Offset: 0xee0
// Size: 0xc6, Type: bool
function teamplayercountsequal( playercounts )
{
    count = undefined;
    
    foreach ( team in level.teams )
    {
        if ( !isdefined( count ) )
        {
            count = playercounts[ team ];
            continue;
        }
        
        if ( count != playercounts[ team ] )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace globallogic_ui
// Params 2
// Checksum 0xd24f32c3, Offset: 0xfb0
// Size: 0xda
function teamwithlowestplayercount( playercounts, ignore_team )
{
    count = 9999;
    lowest_team = undefined;
    
    foreach ( team in level.teams )
    {
        if ( count > playercounts[ team ] )
        {
            count = playercounts[ team ];
            lowest_team = team;
        }
    }
    
    return lowest_team;
}

// Namespace globallogic_ui
// Params 1
// Checksum 0xf699c3c7, Offset: 0x1098
// Size: 0x36c
function menuautoassign( comingfrommenu )
{
    teamkeys = getarraykeys( level.teams );
    assignment = teamkeys[ randomint( teamkeys.size ) ];
    self closemenus();
    assignment = "allies";
    
    if ( level.teambased )
    {
        if ( self.sessionstate == "playing" || assignment == self.pers[ "team" ] && self.sessionstate == "dead" )
        {
            self beginclasschoice();
            return;
        }
    }
    else if ( getdvarint( "party_autoteams" ) == 1 )
    {
        if ( !self.hasspawned && ( level.allow_teamchange != "1" || !comingfrommenu ) )
        {
            team = getassignedteam( self );
            
            if ( isdefined( level.teams[ team ] ) )
            {
                assignment = team;
            }
            else if ( team == "spectator" && !level.forceautoassign )
            {
                self setclientscriptmainmenu( game[ "menu_start_menu" ] );
                return;
            }
        }
    }
    
    if ( self.sessionstate == "playing" || assignment != self.pers[ "team" ] && self.sessionstate == "dead" )
    {
        self.switching_teams = 1;
        self.switchedteamsresetgadgets = 1;
        self.joining_team = assignment;
        self.leaving_team = self.pers[ "team" ];
        self suicide();
    }
    
    self.pers[ "team" ] = assignment;
    self.team = assignment;
    self.pers[ "class" ] = undefined;
    self.curclass = undefined;
    self.pers[ "weapon" ] = undefined;
    self.pers[ "savedmodel" ] = undefined;
    self updateobjectivetext();
    self.sessionteam = assignment;
    
    if ( !isalive( self ) )
    {
        self.statusicon = "hud_status_dead";
    }
    
    self notify( #"joined_team" );
    level notify( #"joined_team" );
    callback::callback( #"hash_95a6c4c0" );
    self notify( #"end_respawn" );
    self beginclasschoice();
    self setclientscriptmainmenu( game[ "menu_start_menu" ] );
}

// Namespace globallogic_ui
// Params 0
// Checksum 0xce8abee3, Offset: 0x1410
// Size: 0xce, Type: bool
function teamscoresequal()
{
    score = undefined;
    
    foreach ( team in level.teams )
    {
        if ( !isdefined( score ) )
        {
            score = getteamscore( team );
            continue;
        }
        
        if ( score != getteamscore( team ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace globallogic_ui
// Params 0
// Checksum 0x5a41cf0, Offset: 0x14e8
// Size: 0xc4
function teamwithlowestscore()
{
    score = 99999999;
    lowest_team = undefined;
    
    foreach ( team in level.teams )
    {
        if ( score > getteamscore( team ) )
        {
            lowest_team = team;
        }
    }
    
    return lowest_team;
}

// Namespace globallogic_ui
// Params 1
// Checksum 0x5808531b, Offset: 0x15b8
// Size: 0x74
function pickteamfromscores( teams )
{
    assignment = "allies";
    
    if ( teamscoresequal() )
    {
        assignment = teams[ randomint( teams.size ) ];
    }
    else
    {
        assignment = teamwithlowestscore();
    }
    
    return assignment;
}

// Namespace globallogic_ui
// Params 0
// Checksum 0x36a9d295, Offset: 0x1638
// Size: 0xce
function get_splitscreen_team()
{
    for ( index = 0; index < level.players.size ; index++ )
    {
        if ( !isdefined( level.players[ index ] ) )
        {
            continue;
        }
        
        if ( level.players[ index ] == self )
        {
            continue;
        }
        
        if ( !self isplayeronsamemachine( level.players[ index ] ) )
        {
            continue;
        }
        
        team = level.players[ index ].sessionteam;
        
        if ( team != "spectator" )
        {
            return team;
        }
    }
    
    return "";
}

// Namespace globallogic_ui
// Params 0
// Checksum 0x9c684ea2, Offset: 0x1710
// Size: 0xd4
function updateobjectivetext()
{
    if ( sessionmodeiszombiesgame() || self.pers[ "team" ] == "spectator" )
    {
        self setclientcgobjectivetext( "" );
        return;
    }
    
    if ( level.scorelimit > 0 )
    {
        self setclientcgobjectivetext( util::getobjectivescoretext( self.pers[ "team" ] ) );
        return;
    }
    
    self setclientcgobjectivetext( util::getobjectivetext( self.pers[ "team" ] ) );
}

// Namespace globallogic_ui
// Params 0
// Checksum 0x2117fdcb, Offset: 0x17f0
// Size: 0x1c
function closemenus()
{
    self closeingamemenu();
}

// Namespace globallogic_ui
// Params 0
// Checksum 0x36e13dad, Offset: 0x1818
// Size: 0x2ac
function beginclasschoice()
{
    assert( isdefined( level.teams[ self.pers[ "<dev string:x28>" ] ] ) );
    team = self.pers[ "team" ];
    self closemenu( game[ "menu_start_menu" ] );
    
    if ( !getdvarint( "art_review", 0 ) )
    {
        self thread fullscreen_black();
    }
    
    b_disable_cac = getdvarint( "force_no_cac", 0 );
    
    if ( !getdvarint( "force_cac", 0 ) || b_disable_cac )
    {
        prevclass = self savegame::get_player_data( "playerClass", undefined );
        var_d47d35d1 = self savegame::get_player_data( savegame::get_mission_name() + "hero_weapon", undefined );
        
        if ( isdefined( self.disableclassselection ) && ( isdefined( level.disableclassselection ) && ( isdefined( prevclass ) || b_disable_cac || level.disableclassselection ) || self.disableclassselection ) || getdvarint( "migration_soak" ) == 1 )
        {
            self.curclass = isdefined( prevclass ) ? prevclass : level.defaultclass;
            self.pers[ "class" ] = self.curclass;
            wait 0.05;
            
            if ( self.sessionstate != "playing" && game[ "state" ] == "playing" )
            {
                self thread [[ level.spawnclient ]]();
            }
            
            globallogic::updateteamstatus();
            self thread spectating::set_permissions_for_machine();
            return;
        }
    }
    
    self closemenu( game[ "menu_changeclass" ] );
    self openmenu( game[ "menu_changeclass_" + team ] );
}

// Namespace globallogic_ui
// Params 0
// Checksum 0x4d37e32b, Offset: 0x1ad0
// Size: 0x38c
function fullscreen_black()
{
    self endon( #"disconnect" );
    util::show_hud( 0 );
    self closemenu( "InitialBlack" );
    self openmenu( "InitialBlack" );
    b_hot_joining = 0;
    
    if ( level flag::get( "all_players_spawned" ) )
    {
        b_hot_joining = 1;
    }
    
    self.fullscreen_black_active = 1;
    self thread fullscreen_black_checkpoint_restore();
    self hide();
    wait 0.05;
    
    if ( isdefined( level.str_level_start_flag ) || isdefined( level.str_player_start_flag ) )
    {
        init_start_flags();
        self thread fullscreen_black_freeze_controls();
        
        if ( isdefined( level.str_level_start_flag ) )
        {
            level flag::wait_till( level.str_level_start_flag );
        }
        
        if ( isdefined( level.str_player_start_flag ) )
        {
            self flag::wait_till( level.str_player_start_flag );
        }
    }
    
    if ( b_hot_joining && !( isdefined( level.is_safehouse ) && level.is_safehouse ) )
    {
        while ( self.sessionstate !== "playing" )
        {
            wait 0.05;
        }
        
        self thread fullscreen_black_freeze_controls();
        
        while ( self isloadingcinematicplaying() )
        {
            wait 0.05;
        }
        
        self flag::wait_till( "loadout_given" );
        waittillframeend();
        wait 2;
        self util::streamer_wait( undefined, 5, 5 );
        self thread lui::screen_fade_in( 0.3, "black", "hot_join" );
    }
    
    if ( !flagsys::get( "shared_igc" ) )
    {
        self show();
    }
    
    self flagsys::set( "kill_fullscreen_black" );
    self clientfield::set_to_player( "sndLevelStartSnapOff", 1 );
    self closemenu( "InitialBlack" );
    self.fullscreen_black_active = undefined;
    util::show_hud( 1 );
    
    /#
        printtoprightln( "<dev string:x2d>" + gettime() + "<dev string:x2f>" + self getentitynumber(), ( 1, 1, 1 ) );
        streamerskiptodebug( getskiptos() );
    #/
}

// Namespace globallogic_ui
// Params 0
// Checksum 0x18bec12f, Offset: 0x1e68
// Size: 0x8c
function fullscreen_black_checkpoint_restore()
{
    self endon( #"disconnect" );
    self endon( #"kill_fullscreen_black" );
    b_fullscreen_black = self.fullscreen_black_active;
    level waittill( #"save_restore" );
    
    if ( isdefined( b_fullscreen_black ) && b_fullscreen_black )
    {
        self closemenu( "InitialBlack" );
        self openmenu( "InitialBlack" );
    }
}

// Namespace globallogic_ui
// Params 0
// Checksum 0x4705f18a, Offset: 0x1f00
// Size: 0x94
function init_start_flags()
{
    if ( isdefined( level.str_player_start_flag ) && !self flag::exists( level.str_player_start_flag ) )
    {
        self flag::init( level.str_player_start_flag );
    }
    
    if ( isdefined( level.str_level_start_flag ) && !level flag::exists( level.str_level_start_flag ) )
    {
        level flag::init( level.str_level_start_flag );
    }
}

// Namespace globallogic_ui
// Params 0
// Checksum 0x45100f1c, Offset: 0x1fa0
// Size: 0xfe
function fullscreen_black_freeze_controls()
{
    self endon( #"disconnect" );
    self.b_game_start_invulnerability = 1;
    self flagsys::wait_till( "loadout_given" );
    self disableweapons();
    self freezecontrols( 1 );
    wait 0.1;
    waittillframeend();
    self freezecontrols( 1 );
    self disableweapons();
    self flagsys::wait_till( "kill_fullscreen_black" );
    self enableweapons();
    self freezecontrols( 0 );
    self.b_game_start_invulnerability = undefined;
}

// Namespace globallogic_ui
// Params 0
// Checksum 0x40f1396b, Offset: 0x20a8
// Size: 0x74
function showmainmenuforteam()
{
    assert( isdefined( level.teams[ self.pers[ "<dev string:x28>" ] ] ) );
    team = self.pers[ "team" ];
    self openmenu( game[ "menu_changeclass_" + team ] );
}

// Namespace globallogic_ui
// Params 1
// Checksum 0x26219d3c, Offset: 0x2128
// Size: 0x234
function menuteam( team )
{
    self closemenus();
    
    if ( isdefined( self.hasdonecombat ) && !level.console && level.allow_teamchange == "0" && self.hasdonecombat )
    {
        return;
    }
    
    if ( self.pers[ "team" ] != team )
    {
        if ( !isdefined( self.hasdonecombat ) || level.ingraceperiod && !self.hasdonecombat )
        {
            self.hasspawned = 0;
        }
        
        if ( self.sessionstate == "playing" )
        {
            self.switching_teams = 1;
            self.switchedteamsresetgadgets = 1;
            self.joining_team = team;
            self.leaving_team = self.pers[ "team" ];
            self suicide();
        }
        
        self.pers[ "team" ] = team;
        self.team = team;
        self.pers[ "class" ] = undefined;
        self.curclass = undefined;
        self.pers[ "weapon" ] = undefined;
        self.pers[ "savedmodel" ] = undefined;
        self updateobjectivetext();
        
        if ( !level.rankedmatch && !level.leaguematch )
        {
            self.sessionstate = "spectator";
        }
        
        self.sessionteam = team;
        self setclientscriptmainmenu( game[ "menu_start_menu" ] );
        self notify( #"joined_team" );
        level notify( #"joined_team" );
        callback::callback( #"hash_95a6c4c0" );
        self notify( #"end_respawn" );
    }
    
    self beginclasschoice();
}

// Namespace globallogic_ui
// Params 0
// Checksum 0x804ed8a2, Offset: 0x2368
// Size: 0x1a4
function menuspectator()
{
    self closemenus();
    
    if ( self.pers[ "team" ] != "spectator" )
    {
        if ( isalive( self ) )
        {
            self.switching_teams = 1;
            self.switchedteamsresetgadgets = 1;
            self.joining_team = "spectator";
            self.leaving_team = self.pers[ "team" ];
            self suicide();
        }
        
        self.pers[ "team" ] = "spectator";
        self.team = "spectator";
        self.pers[ "class" ] = undefined;
        self.curclass = undefined;
        self.pers[ "weapon" ] = undefined;
        self.pers[ "savedmodel" ] = undefined;
        self updateobjectivetext();
        self.sessionteam = "spectator";
        [[ level.spawnspectator ]]();
        self thread globallogic_player::spectate_player_watcher();
        self setclientscriptmainmenu( game[ "menu_start_menu" ] );
        self notify( #"joined_spectators" );
        callback::callback( #"hash_4c5ae192" );
    }
}

// Namespace globallogic_ui
// Params 1
// Checksum 0xa546881a, Offset: 0x2518
// Size: 0x68a
function menuclass( response )
{
    self closemenus();
    
    if ( !isdefined( self.pers[ "team" ] ) || !isdefined( level.teams[ self.pers[ "team" ] ] ) )
    {
        return;
    }
    
    if ( flagsys::get( "mobile_armory_in_use" ) )
    {
        return;
    }
    
    playerclass = "";
    
    if ( response == "cancel" )
    {
        prevclass = self savegame::get_player_data( "playerClass", undefined );
        
        if ( isdefined( prevclass ) )
        {
            playerclass = prevclass;
        }
        else
        {
            playerclass = level.defaultclass;
        }
    }
    else
    {
        responsearray = strtok( response, "," );
        
        if ( responsearray.size > 1 )
        {
            str_class_chosen = responsearray[ 0 ];
            clientnum = int( responsearray[ 1 ] );
            altplayer = util::getplayerfromclientnum( clientnum );
        }
        else
        {
            str_class_chosen = response;
        }
        
        playerclass = self loadout::getclasschoice( str_class_chosen );
        
        if ( isdefined( altplayer ) )
        {
            xuid = altplayer getxuid();
            self savegame::set_player_data( "altPlayerID", xuid );
        }
        else
        {
            self savegame::set_player_data( "altPlayerID", undefined );
        }
        
        self savegame::set_player_data( "saved_weapon", undefined );
        self savegame::set_player_data( "saved_weapondata", undefined );
        self savegame::set_player_data( "lives", undefined );
        self savegame::set_player_data( "saved_rig1", undefined );
        self savegame::set_player_data( "saved_rig1_upgraded", undefined );
        self savegame::set_player_data( "saved_rig2", undefined );
        self savegame::set_player_data( "saved_rig2_upgraded", undefined );
    }
    
    if ( isdefined( self.pers[ "class" ] ) && self.pers[ "class" ] == playerclass )
    {
        return;
    }
    
    self.pers[ "changed_class" ] = 1;
    self notify( #"changed_class" );
    waittillframeend();
    
    if ( isdefined( self.curclass ) && self.curclass == playerclass )
    {
        self.pers[ "changed_class" ] = 0;
    }
    
    if ( self.sessionstate == "playing" )
    {
        self savegame::set_player_data( "playerClass", playerclass );
        self.pers[ "class" ] = playerclass;
        self.curclass = playerclass;
        self.pers[ "weapon" ] = undefined;
        
        if ( game[ "state" ] == "postgame" )
        {
            return;
        }
        
        supplystationclasschange = isdefined( self.usingsupplystation ) && self.usingsupplystation;
        self.usingsupplystation = 0;
        
        if ( level.ingraceperiod && !self.hasdonecombat || supplystationclasschange )
        {
            self loadout::setclass( self.pers[ "class" ] );
            self.tag_stowed_back = undefined;
            self.tag_stowed_hip = undefined;
            self loadout::giveloadout( self.pers[ "team" ], self.pers[ "class" ] );
        }
        else if ( !self issplitscreen() )
        {
            self iprintlnbold( game[ "strings" ][ "change_class" ] );
        }
    }
    else
    {
        self savegame::set_player_data( "playerClass", playerclass );
        self.pers[ "class" ] = playerclass;
        self.curclass = playerclass;
        self.pers[ "weapon" ] = undefined;
        
        if ( game[ "state" ] == "postgame" )
        {
            return;
        }
        
        if ( self.sessionstate != "spectator" )
        {
            if ( self isinvehicle() )
            {
                return;
            }
            
            if ( self isremotecontrolling() )
            {
                return;
            }
            
            if ( self isweaponviewonlylinked() )
            {
                return 0;
            }
        }
        
        if ( game[ "state" ] == "playing" )
        {
            timepassed = undefined;
            
            if ( isdefined( self.respawntimerstarttime ) )
            {
                timepassed = ( gettime() - self.respawntimerstarttime ) / 1000;
            }
            
            self thread [[ level.spawnclient ]]( timepassed );
            self.respawntimerstarttime = undefined;
        }
    }
    
    globallogic::updateteamstatus();
    self thread spectating::set_permissions_for_machine();
    self notify( #"class_changed" );
}

// Namespace globallogic_ui
// Params 1
// Checksum 0xd160de01, Offset: 0x2bb0
// Size: 0x44
function removespawnmessageshortly( delay )
{
    self endon( #"disconnect" );
    waittillframeend();
    self endon( #"end_respawn" );
    wait delay;
    self util::clearlowermessage( 2 );
}

// Namespace globallogic_ui
// Params 1
// Checksum 0x39576679, Offset: 0x2c00
// Size: 0x108
function weakpoint_anim_watch( precachedbonename )
{
    self endon( #"death" );
    self endon( #"weakpoint_destroyed" );
    
    while ( true )
    {
        self waittill( #"weakpoint_update", bonename, event );
        
        if ( bonename == precachedbonename )
        {
            if ( event == "damage" )
            {
                luinotifyevent( &"weakpoint_update", 3, 2, self getentitynumber(), precachedbonename );
            }
            else if ( event == "repulse" )
            {
                luinotifyevent( &"weakpoint_update", 3, 3, self getentitynumber(), precachedbonename );
            }
            
            wait 0.5;
        }
    }
}

// Namespace globallogic_ui
// Params 1
// Checksum 0xc7a0998f, Offset: 0x2d10
// Size: 0x4a
function destroyweakpointwidget( precachedbonename )
{
    luinotifyevent( &"weakpoint_update", 3, 0, self getentitynumber(), precachedbonename );
    self notify( #"weakpoint_destroyed" );
}

// Namespace globallogic_ui
// Params 3
// Checksum 0x148772b, Offset: 0x2d68
// Size: 0xec
function createweakpointwidget( precachedbonename, closestatemaxdistance, mediumstatemaxdistance )
{
    if ( !isdefined( closestatemaxdistance ) )
    {
        closestatemaxdistance = undefined;
    }
    
    if ( !isdefined( mediumstatemaxdistance ) )
    {
        mediumstatemaxdistance = undefined;
    }
    
    if ( !isdefined( closestatemaxdistance ) )
    {
        closestatemaxdistance = getdvarint( "ui_weakpointIndicatorNear", 1050 );
    }
    
    if ( !isdefined( mediumstatemaxdistance ) )
    {
        mediumstatemaxdistance = getdvarint( "ui_weakpointIndicatorMedium", 1900 );
    }
    
    luinotifyevent( &"weakpoint_update", 5, 1, self getentitynumber(), precachedbonename, closestatemaxdistance, mediumstatemaxdistance );
    self thread weakpoint_anim_watch( precachedbonename );
}

// Namespace globallogic_ui
// Params 1
// Checksum 0xec2a034d, Offset: 0x2e60
// Size: 0x26
function triggerweakpointdamage( precachedbonename )
{
    self notify( #"weakpoint_update", precachedbonename, "damage" );
}

// Namespace globallogic_ui
// Params 1
// Checksum 0xa0e41bc5, Offset: 0x2e90
// Size: 0x26
function triggerweakpointrepulsed( precachedbonename )
{
    self notify( #"weakpoint_update", precachedbonename, "repulse" );
}

