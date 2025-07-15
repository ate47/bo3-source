#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/bot_buttons;
#using scripts/shared/bots/bot_traversals;
#using scripts/shared/callbacks_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace bot;

// Namespace bot
// Params 0, eflags: 0x2
// Checksum 0xd24e8fb0, Offset: 0x3d8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "bot", &__init__, undefined, undefined );
}

// Namespace bot
// Params 0
// Checksum 0xcdd1d3b8, Offset: 0x418
// Size: 0x2dc
function __init__()
{
    callback::on_start_gametype( &init );
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    callback::on_player_killed( &on_player_killed );
    
    if ( !isdefined( level.getbotsettings ) )
    {
        level.getbotsettings = &get_bot_default_settings;
    }
    
    if ( !isdefined( level.onbotremove ) )
    {
        level.onbotremove = &bot_void;
    }
    
    if ( !isdefined( level.onbotconnect ) )
    {
        level.onbotconnect = &bot_void;
    }
    
    if ( !isdefined( level.onbotspawned ) )
    {
        level.onbotspawned = &bot_void;
    }
    
    if ( !isdefined( level.onbotkilled ) )
    {
        level.onbotkilled = &bot_void;
    }
    
    if ( !isdefined( level.onbotdamage ) )
    {
        level.onbotdamage = &bot_void;
    }
    
    if ( !isdefined( level.botupdate ) )
    {
        level.botupdate = &bot_update;
    }
    
    if ( !isdefined( level.botprecombat ) )
    {
        level.botprecombat = &bot_void;
    }
    
    if ( !isdefined( level.botcombat ) )
    {
        level.botcombat = &bot_combat::combat_think;
    }
    
    if ( !isdefined( level.botpostcombat ) )
    {
        level.botpostcombat = &bot_void;
    }
    
    if ( !isdefined( level.botidle ) )
    {
        level.botidle = &bot_void;
    }
    
    if ( !isdefined( level.botthreatdead ) )
    {
        level.botthreatdead = &bot_combat::clear_threat;
    }
    
    if ( !isdefined( level.botthreatengage ) )
    {
        level.botthreatengage = &bot_combat::engage_threat;
    }
    
    if ( !isdefined( level.botupdatethreatgoal ) )
    {
        level.botupdatethreatgoal = &bot_combat::update_threat_goal;
    }
    
    if ( !isdefined( level.botthreatlost ) )
    {
        level.botthreatlost = &bot_combat::clear_threat;
    }
    
    if ( !isdefined( level.botgetthreats ) )
    {
        level.botgetthreats = &bot_combat::get_bot_threats;
    }
    
    if ( !isdefined( level.botignorethreat ) )
    {
        level.botignorethreat = &bot_combat::ignore_non_sentient;
    }
    
    setdvar( "bot_maxMantleHeight", 200 );
    
    /#
        level thread bot_devgui_think();
    #/
}

// Namespace bot
// Params 0
// Checksum 0x40462943, Offset: 0x700
// Size: 0x14
function init()
{
    init_bot_settings();
}

// Namespace bot
// Params 0
// Checksum 0xe404801d, Offset: 0x720
// Size: 0x6, Type: bool
function is_bot_ranked_match()
{
    return false;
}

// Namespace bot
// Params 0
// Checksum 0x99ec1590, Offset: 0x730
// Size: 0x4
function bot_void()
{
    
}

// Namespace bot
// Params 0
// Checksum 0x4aa714a7, Offset: 0x740
// Size: 0x6, Type: bool
function bot_unhandled()
{
    return false;
}

// Namespace bot
// Params 2
// Checksum 0xd1c99d13, Offset: 0x750
// Size: 0x56
function add_bots( count, team )
{
    for ( i = 0; i < count ; i++ )
    {
        add_bot( team );
    }
}

// Namespace bot
// Params 1
// Checksum 0xc535196a, Offset: 0x7b0
// Size: 0xd2
function add_bot( team )
{
    botent = addtestclient();
    
    if ( !isdefined( botent ) )
    {
        return undefined;
    }
    
    botent botsetrandomcharactercustomization();
    
    if ( isdefined( level.disableclassselection ) && level.disableclassselection )
    {
        botent.pers[ "class" ] = level.defaultclass;
        botent.curclass = level.defaultclass;
    }
    
    if ( level.teambased && team !== "autoassign" )
    {
        botent.pers[ "team" ] = team;
    }
    
    return botent;
}

// Namespace bot
// Params 2
// Checksum 0xcd6df001, Offset: 0x890
// Size: 0x112
function remove_bots( count, team )
{
    players = getplayers();
    
    foreach ( player in players )
    {
        if ( !player istestclient() )
        {
            continue;
        }
        
        if ( isdefined( team ) && player.team != team )
        {
            continue;
        }
        
        remove_bot( player );
        
        if ( isdefined( count ) )
        {
            count--;
            
            if ( count <= 0 )
            {
                break;
            }
        }
    }
}

// Namespace bot
// Params 1
// Checksum 0x89fe72dd, Offset: 0x9b0
// Size: 0x54
function remove_bot( bot )
{
    if ( !bot istestclient() )
    {
        return;
    }
    
    bot [[ level.onbotremove ]]();
    bot botdropclient();
}

// Namespace bot
// Params 1
// Checksum 0x66b013fc, Offset: 0xa10
// Size: 0xba
function filter_bots( players )
{
    bots = [];
    
    foreach ( player in players )
    {
        if ( player util::is_bot() )
        {
            bots[ bots.size ] = player;
        }
    }
    
    return bots;
}

// Namespace bot
// Params 0
// Checksum 0xca8f5dac, Offset: 0xad8
// Size: 0x104
function on_player_connect()
{
    if ( !self istestclient() )
    {
        return;
    }
    
    self endon( #"disconnect" );
    self.bot = spawnstruct();
    self.bot.threat = spawnstruct();
    self.bot.damage = spawnstruct();
    self.pers[ "isBot" ] = 1;
    
    if ( level.teambased )
    {
        self notify( #"menuresponse", game[ "menu_team" ], self.team );
        wait 0.5;
    }
    
    self notify( #"joined_team" );
    callback::callback( #"hash_95a6c4c0" );
    self thread [[ level.onbotconnect ]]();
}

// Namespace bot
// Params 0
// Checksum 0xba949b8d, Offset: 0xbe8
// Size: 0xdc
function on_player_spawned()
{
    if ( !self util::is_bot() )
    {
        return;
    }
    
    self clear_stuck();
    self bot_combat::clear_threat();
    self.bot.prevweapon = undefined;
    self botlookforward();
    self thread [[ level.onbotspawned ]]();
    self thread bot_combat::wait_damage_loop();
    self thread wait_bot_path_failed_loop();
    self thread wait_bot_goal_reached_loop();
    self thread bot_think_loop();
}

// Namespace bot
// Params 0
// Checksum 0x8f8a5e9, Offset: 0xcd0
// Size: 0x44
function on_player_killed()
{
    if ( !self util::is_bot() )
    {
        return;
    }
    
    self thread [[ level.onbotkilled ]]();
    self botreleasemanualcontrol();
}

// Namespace bot
// Params 0
// Checksum 0x8d6be3a8, Offset: 0xd20
// Size: 0x48
function bot_think_loop()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self bot_think();
        wait level.botsettings.thinkinterval;
    }
}

// Namespace bot
// Params 0
// Checksum 0x5b437328, Offset: 0xd70
// Size: 0x110
function bot_think()
{
    self botreleasebuttons();
    
    if ( level.inprematchperiod || level.gameended || !isalive( self ) )
    {
        return;
    }
    
    self check_stuck();
    self sprint_think();
    self update_swim();
    self thread [[ level.botupdate ]]();
    self thread [[ level.botprecombat ]]();
    self thread [[ level.botcombat ]]();
    self thread [[ level.botpostcombat ]]();
    
    if ( !self bot_combat::has_threat() && !self botgoalset() )
    {
        self thread [[ level.botidle ]]();
    }
}

// Namespace bot
// Params 0
// Checksum 0x99ec1590, Offset: 0xe88
// Size: 0x4
function bot_update()
{
    
}

// Namespace bot
// Params 0
// Checksum 0xdd977f64, Offset: 0xe98
// Size: 0x2bc
function update_swim()
{
    if ( !self isplayerswimming() )
    {
        self.bot.resurfacetime = undefined;
        return;
    }
    
    if ( self isplayerunderwater() )
    {
        if ( !isdefined( self.bot.resurfacetime ) )
        {
            self.bot.resurfacetime = gettime() + level.botsettings.swimtime;
        }
    }
    else
    {
        self.bot.resurfacetime = undefined;
    }
    
    if ( self botundermanualcontrol() )
    {
        return;
    }
    
    goalposition = self botgetgoalposition();
    
    if ( distance2dsquared( goalposition, self.origin ) <= 16384 && getwaterheight( goalposition ) > 0 )
    {
        self press_swim_down();
        return;
    }
    
    if ( isdefined( self.bot.resurfacetime ) && self.bot.resurfacetime <= gettime() )
    {
        press_swim_up();
        return;
    }
    
    bottomtrace = groundtrace( self.origin, self.origin + ( 0, 0, -1000 ), 0, self, 1 );
    swimheight = self.origin[ 2 ] - bottomtrace[ "position" ][ 2 ];
    
    if ( swimheight < 25 )
    {
        self press_swim_up();
        vertdist = 25 - swimheight;
    }
    else if ( swimheight > 45 )
    {
        self press_swim_down();
        vertdist = swimheight - 45;
    }
    
    if ( isdefined( vertdist ) )
    {
        intervaldist = level.botsettings.swimverticalspeed * level.botsettings.thinkinterval;
        
        if ( intervaldist > vertdist )
        {
            self wait_release_swim_buttons( level.botsettings.thinkinterval * vertdist / intervaldist );
        }
    }
}

// Namespace bot
// Params 1
// Checksum 0x3d46eb, Offset: 0x1160
// Size: 0x54
function wait_release_swim_buttons( waittime )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait waittime;
    self release_swim_up();
    self release_swim_down();
}

// Namespace bot
// Params 0
// Checksum 0xb6cc53ab, Offset: 0x11c0
// Size: 0x688
function init_bot_settings()
{
    level.botsettings = [[ level.getbotsettings ]]();
    setdvar( "bot_AllowMelee", isdefined( level.botsettings.allowmelee ) ? level.botsettings.allowmelee : 0 );
    setdvar( "bot_AllowGrenades", isdefined( level.botsettings.allowgrenades ) ? level.botsettings.allowgrenades : 0 );
    setdvar( "bot_AllowKillstreaks", isdefined( level.botsettings.allowkillstreaks ) ? level.botsettings.allowkillstreaks : 0 );
    setdvar( "bot_AllowHeroGadgets", isdefined( level.botsettings.allowherogadgets ) ? level.botsettings.allowherogadgets : 0 );
    setdvar( "bot_Fov", isdefined( level.botsettings.fov ) ? level.botsettings.fov : 0 );
    setdvar( "bot_FovAds", isdefined( level.botsettings.fovads ) ? level.botsettings.fovads : 0 );
    setdvar( "bot_PitchSensitivity", level.botsettings.pitchsensitivity );
    setdvar( "bot_YawSensitivity", level.botsettings.yawsensitivity );
    setdvar( "bot_PitchSpeed", isdefined( level.botsettings.pitchspeed ) ? level.botsettings.pitchspeed : 0 );
    setdvar( "bot_PitchSpeedAds", isdefined( level.botsettings.pitchspeedads ) ? level.botsettings.pitchspeedads : 0 );
    setdvar( "bot_YawSpeed", isdefined( level.botsettings.yawspeed ) ? level.botsettings.yawspeed : 0 );
    setdvar( "bot_YawSpeedAds", isdefined( level.botsettings.yawspeedads ) ? level.botsettings.yawspeedads : 0 );
    setdvar( "pitchAccelerationTime", isdefined( level.botsettings.pitchaccelerationtime ) ? level.botsettings.pitchaccelerationtime : 0 );
    setdvar( "yawAccelerationTime", isdefined( level.botsettings.yawaccelerationtime ) ? level.botsettings.yawaccelerationtime : 0 );
    setdvar( "pitchDecelerationThreshold", isdefined( level.botsettings.pitchdecelerationthreshold ) ? level.botsettings.pitchdecelerationthreshold : 0 );
    setdvar( "yawDecelerationThreshold", isdefined( level.botsettings.yawdecelerationthreshold ) ? level.botsettings.yawdecelerationthreshold : 0 );
    meleerange = getdvarint( "player_meleeRangeDefault" ) * ( isdefined( level.botsettings.meleerangemultiplier ) ? level.botsettings.meleerangemultiplier : 0 );
    level.botsettings.meleerange = int( meleerange );
    level.botsettings.meleerangesq = meleerange * meleerange;
    level.botsettings.threatradiusminsq = level.botsettings.threatradiusmin * level.botsettings.threatradiusmin;
    level.botsettings.threatradiusmaxsq = level.botsettings.threatradiusmax * level.botsettings.threatradiusmax;
    lethaldistancemin = isdefined( level.botsettings.lethaldistancemin ) ? level.botsettings.lethaldistancemin : 0;
    level.botsettings.lethaldistanceminsq = lethaldistancemin * lethaldistancemin;
    lethaldistancemax = isdefined( level.botsettings.lethaldistancemax ) ? level.botsettings.lethaldistancemax : 1024;
    level.botsettings.lethaldistancemaxsq = lethaldistancemax * lethaldistancemax;
    tacticaldistancemin = isdefined( level.botsettings.tacticaldistancemin ) ? level.botsettings.tacticaldistancemin : 0;
    level.botsettings.tacticaldistanceminsq = tacticaldistancemin * tacticaldistancemin;
    tacticaldistancemax = isdefined( level.botsettings.tacticaldistancemax ) ? level.botsettings.tacticaldistancemax : 1024;
    level.botsettings.tacticaldistancemaxsq = tacticaldistancemax * tacticaldistancemax;
    level.botsettings.swimverticalspeed = getdvarfloat( "player_swimVerticalSpeedMax" );
    level.botsettings.swimtime = getdvarfloat( "player_swimTime", 5 ) * 1000;
}

// Namespace bot
// Params 0
// Checksum 0xf73a4a26, Offset: 0x1850
// Size: 0x22
function get_bot_default_settings()
{
    return struct::get_script_bundle( "botsettings", "bot_default" );
}

// Namespace bot
// Params 0
// Checksum 0x11c741fd, Offset: 0x1880
// Size: 0x18
function sprint_to_goal()
{
    self.bot.sprinttogoal = 1;
}

// Namespace bot
// Params 0
// Checksum 0x8838991, Offset: 0x18a0
// Size: 0x18
function end_sprint_to_goal()
{
    self.bot.sprinttogoal = 0;
}

// Namespace bot
// Params 0
// Checksum 0xfdf326d5, Offset: 0x18c0
// Size: 0x6e
function sprint_think()
{
    if ( isdefined( self.bot.sprinttogoal ) && self.bot.sprinttogoal )
    {
        if ( self botgoalreached() )
        {
            self end_sprint_to_goal();
            return;
        }
        
        self press_sprint_button();
        return;
    }
}

// Namespace bot
// Params 1
// Checksum 0x16d86964, Offset: 0x1938
// Size: 0x66, Type: bool
function goal_in_trigger( trigger )
{
    radius = self get_trigger_radius( trigger );
    return distancesquared( trigger.origin, self botgetgoalposition() ) <= radius * radius;
}

// Namespace bot
// Params 1
// Checksum 0x8f819dd0, Offset: 0x19a8
// Size: 0x70, Type: bool
function point_in_goal( point )
{
    deltasq = distance2dsquared( self botgetgoalposition(), point );
    goalradius = self botgetgoalradius();
    return deltasq <= goalradius * goalradius;
}

// Namespace bot
// Params 2
// Checksum 0xea05bb9, Offset: 0x1a20
// Size: 0x14c
function path_to_trigger( trigger, radius )
{
    if ( trigger.classname == "trigger_use" || trigger.classname == "trigger_use_touch" )
    {
        if ( !isdefined( radius ) )
        {
            radius = get_trigger_radius( trigger );
        }
        
        randomangle = ( 0, randomint( 360 ), 0 );
        randomvec = anglestoforward( randomangle );
        point = trigger.origin + randomvec * radius;
        self botsetgoal( point );
    }
    
    if ( !isdefined( radius ) )
    {
        radius = 0;
    }
    
    self botsetgoal( trigger.origin, int( radius ) );
}

// Namespace bot
// Params 1
// Checksum 0x21d2c2aa, Offset: 0x1b78
// Size: 0x33c
function path_to_point_in_trigger( trigger )
{
    mins = trigger getmins();
    maxs = trigger getmaxs();
    radius = min( maxs[ 0 ], maxs[ 1 ] );
    height = maxs[ 2 ] - mins[ 2 ];
    minorigin = trigger.origin + ( 0, 0, mins[ 2 ] );
    queryheight = height / 4;
    queryorigin = minorigin + ( 0, 0, queryheight );
    
    /#
        if ( getdvarint( "<dev string:x28>", 0 ) )
        {
            draws = 10;
            circle( queryorigin, radius, ( 0, 1, 0 ), 0, 1, 20 * draws );
            circle( queryorigin + ( 0, 0, queryheight ), radius, ( 0, 1, 0 ), 0, 1, 20 * draws );
            circle( queryorigin - ( 0, 0, queryheight ), radius, ( 0, 1, 0 ), 0, 1, 20 * draws );
        }
    #/
    
    queryresult = positionquery_source_navigation( queryorigin, 0, radius, queryheight, 17, self );
    best_point = undefined;
    
    foreach ( point in queryresult.data )
    {
        point.score = randomfloatrange( 0, 100 );
        
        if ( !isdefined( best_point ) || point.score > best_point.score )
        {
            best_point = point;
        }
    }
    
    if ( isdefined( best_point ) )
    {
        self botsetgoal( best_point.origin, 24 );
        return;
    }
    
    self path_to_trigger( trigger, radius );
}

// Namespace bot
// Params 1
// Checksum 0x7b6c1ce3, Offset: 0x1ec0
// Size: 0x7a
function get_trigger_radius( trigger )
{
    maxs = trigger getmaxs();
    
    if ( trigger.classname == "trigger_radius" )
    {
        return maxs[ 0 ];
    }
    
    return min( maxs[ 0 ], maxs[ 1 ] );
}

// Namespace bot
// Params 1
// Checksum 0xe5dfa0b, Offset: 0x1f48
// Size: 0x68
function get_trigger_height( trigger )
{
    maxs = trigger getmaxs();
    
    if ( trigger.classname == "trigger_radius" )
    {
        return maxs[ 2 ];
    }
    
    return maxs[ 2 ] * 2;
}

// Namespace bot
// Params 0
// Checksum 0x54016300, Offset: 0x1fb8
// Size: 0x284
function check_stuck()
{
    /#
        if ( !getdvarint( "<dev string:x3d>" ) )
        {
            return;
        }
    #/
    
    if ( self bot_combat::has_threat() && ( self botundermanualcontrol() || self botgoalreached() || self util::isstunned() || self ismeleeing() || self meleebuttonpressed() || self.bot.threat.lastdistancesq < 16384 ) )
    {
        return;
    }
    
    velocity = self getvelocity();
    
    if ( velocity[ 2 ] == 0 || velocity[ 0 ] == 0 && velocity[ 1 ] == 0 && self isplayerswimming() )
    {
        if ( !isdefined( self.bot.stuckcycles ) )
        {
            self.bot.stuckcycles = 0;
        }
        
        self.bot.stuckcycles++;
        
        if ( self.bot.stuckcycles >= 3 )
        {
            /#
                if ( getdvarint( "<dev string:x4f>", 0 ) )
                {
                    sphere( self.origin, 16, ( 1, 0, 0 ), 0.25, 0, 16, 1200 );
                    iprintln( "<dev string:x5e>" + self.name + "<dev string:x63>" + self.origin );
                }
            #/
            
            self thread stuck_resolution();
        }
    }
    else
    {
        self.bot.stuckcycles = 0;
    }
    
    if ( !self bot_combat::threat_visible() )
    {
        self check_stuck_position();
    }
}

// Namespace bot
// Params 0
// Checksum 0x341d4adc, Offset: 0x2248
// Size: 0x2ac
function check_stuck_position()
{
    if ( gettime() < self.bot.checkpositiontime )
    {
        return;
    }
    
    self.bot.checkpositiontime = gettime() + 500;
    self.bot.positionhistory[ self.bot.positionhistoryindex ] = self.origin;
    self.bot.positionhistoryindex = ( self.bot.positionhistoryindex + 1 ) % 5;
    
    if ( self.bot.positionhistory.size < 5 )
    {
        return;
    }
    
    maxdistsq = undefined;
    
    for ( i = 0; i < self.bot.positionhistory.size ; i++ )
    {
        /#
            if ( getdvarint( "<dev string:x4f>", 0 ) )
            {
                line( self.bot.positionhistory[ i ], self.bot.positionhistory[ i ] + ( 0, 0, 72 ), ( 0, 1, 0 ), 1, 0, 10 );
            }
        #/
        
        for ( j = i + 1; j < self.bot.positionhistory.size ; j++ )
        {
            distsq = distancesquared( self.bot.positionhistory[ i ], self.bot.positionhistory[ j ] );
            
            if ( distsq > 16384 )
            {
                return;
            }
        }
    }
    
    /#
        if ( getdvarint( "<dev string:x4f>", 0 ) )
        {
            sphere( self.origin, 128, ( 1, 0, 0 ), 0.25, 0, 16, 1200 );
            iprintln( "<dev string:x5e>" + self.name + "<dev string:x74>" + self.origin );
        }
    #/
    
    self thread stuck_resolution();
}

// Namespace bot
// Params 0
// Checksum 0xeba93359, Offset: 0x2500
// Size: 0x104
function stuck_resolution()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self clear_stuck();
    self bottakemanualcontrol();
    escapeangle = self getangles()[ 1 ] + 180 + randomintrange( -60, 60 );
    escapedir = anglestoforward( ( 0, escapeangle, 0 ) );
    self botsetmoveangle( escapedir );
    self botsetmovemagnitude( 1 );
    wait 1.5;
    self botreleasemanualcontrol();
}

// Namespace bot
// Params 0
// Checksum 0xdc719305, Offset: 0x2610
// Size: 0x54
function clear_stuck()
{
    self.bot.stuckcycles = 0;
    self.bot.positionhistory = [];
    self.bot.positionhistoryindex = 0;
    self.bot.checkpositiontime = 0;
}

// Namespace bot
// Params 0
// Checksum 0xc993c7f5, Offset: 0x2670
// Size: 0x3c
function camp()
{
    self botsetgoal( self.origin );
    self press_crouch_button();
}

// Namespace bot
// Params 0
// Checksum 0x7dc91e22, Offset: 0x26b8
// Size: 0x190
function wait_bot_path_failed_loop()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"bot_path_failed", reason );
        
        /#
            if ( getdvarint( "<dev string:x4f>", 0 ) )
            {
                goalposition = self botgetgoalposition();
                box( self.origin, ( -15, -15, 0 ), ( 15, 15, 72 ), 0, ( 0, 1, 0 ), 0.25, 0, 1200 );
                box( goalposition, ( -15, -15, 0 ), ( 15, 15, 72 ), 0, ( 1, 0, 0 ), 0.25, 0, 1200 );
                line( self.origin, goalposition, ( 1, 1, 1 ), 1, 0, 1200 );
                iprintln( "<dev string:x5e>" + self.name + "<dev string:x86>" + self.origin + "<dev string:x9a>" + goalposition );
            }
        #/
        
        self thread stuck_resolution();
    }
}

// Namespace bot
// Params 0
// Checksum 0x1d52e868, Offset: 0x2850
// Size: 0x58
function wait_bot_goal_reached_loop()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"bot_goal_reached", reason );
        self clear_stuck();
    }
}

// Namespace bot
// Params 0
// Checksum 0xc9b3cc76, Offset: 0x28b0
// Size: 0xa4
function stow_gun_gadget()
{
    currentweapon = self getcurrentweapon();
    
    if ( self getweaponammoclip( currentweapon ) || !currentweapon.isheroweapon )
    {
        return;
    }
    
    if ( isdefined( self.lastdroppableweapon ) && self hasweapon( self.lastdroppableweapon ) )
    {
        self switchtoweapon( self.lastdroppableweapon );
    }
}

// Namespace bot
// Params 0
// Checksum 0x8b3c430e, Offset: 0x2960
// Size: 0x116
function get_ready_gadget()
{
    weapons = self getweaponslist();
    
    foreach ( weapon in weapons )
    {
        slot = self gadgetgetslot( weapon );
        
        if ( slot < 0 || !self gadgetisready( slot ) || self gadgetisactive( slot ) )
        {
            continue;
        }
        
        return weapon;
    }
    
    return level.weaponnone;
}

// Namespace bot
// Params 0
// Checksum 0xb0875f01, Offset: 0x2a80
// Size: 0x12e
function get_ready_gun_gadget()
{
    weapons = self getweaponslist();
    
    foreach ( weapon in weapons )
    {
        if ( !is_gun_gadget( weapon ) )
        {
            continue;
        }
        
        slot = self gadgetgetslot( weapon );
        
        if ( slot < 0 || !self gadgetisready( slot ) || self gadgetisactive( slot ) )
        {
            continue;
        }
        
        return weapon;
    }
    
    return level.weaponnone;
}

// Namespace bot
// Params 1
// Checksum 0x3d28d0e7, Offset: 0x2bb8
// Size: 0x7e, Type: bool
function is_gun_gadget( weapon )
{
    if ( !isdefined( weapon ) || weapon == level.weaponnone || !weapon.isheroweapon )
    {
        return false;
    }
    
    return weapon.isbulletweapon || weapon.isprojectileweapon || weapon.islauncher || weapon.isgasweapon;
}

// Namespace bot
// Params 1
// Checksum 0x64966e8b, Offset: 0x2c40
// Size: 0xb4
function activate_hero_gadget( weapon )
{
    if ( !isdefined( weapon ) || weapon == level.weaponnone || !weapon.isgadget )
    {
        return;
    }
    
    if ( is_gun_gadget( weapon ) )
    {
        self switchtoweapon( weapon );
        return;
    }
    
    if ( weapon.isheroweapon )
    {
        self tap_offhand_special_button();
        return;
    }
    
    self botpressbuttonforgadget( weapon );
}

// Namespace bot
// Params 0
// Checksum 0x7908e56c, Offset: 0x2d00
// Size: 0x140
function coop_pre_combat()
{
    self bot_combat::bot_pre_combat();
    
    if ( self bot_combat::has_threat() )
    {
        return;
    }
    
    if ( self isreloading() || self isswitchingweapons() || self isthrowinggrenade() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self ismeleeing() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked() )
    {
        return;
    }
    
    if ( self bot_combat::switch_weapon() )
    {
        return;
    }
    
    if ( self bot_combat::reload_weapon() )
    {
        return;
    }
}

// Namespace bot
// Params 0
// Checksum 0x8d061f74, Offset: 0x2e48
// Size: 0x84
function coop_post_combat()
{
    if ( self revive_players() )
    {
        if ( self bot_combat::has_threat() )
        {
            self bot_combat::clear_threat();
            self botsetgoal( self.origin );
        }
        
        return;
    }
    
    self bot_combat::bot_post_combat();
}

// Namespace bot
// Params 0
// Checksum 0x2be90678, Offset: 0x2ed8
// Size: 0x1bc
function follow_coop_players()
{
    host = get_host_player();
    
    if ( !isalive( host ) )
    {
        players = arraysort( level.players, self.origin );
        
        foreach ( player in players )
        {
            if ( !player util::is_bot() && player.team == self.team && isalive( player ) )
            {
                break;
            }
        }
    }
    else
    {
        player = host;
    }
    
    if ( isdefined( player ) )
    {
        fwd = anglestoforward( player.angles );
        botdir = self.origin - player.origin;
        
        if ( vectordot( botdir, fwd ) < 0 )
        {
            self thread lead_player( player, 150 );
        }
    }
}

// Namespace bot
// Params 2
// Checksum 0x83e1ac9f, Offset: 0x30a0
// Size: 0x12c
function lead_player( player, followmin )
{
    radiusmin = followmin - 32;
    radiusmax = followmin;
    dotmin = 0.85;
    dotmax = 0.92;
    queryresult = positionquery_source_navigation( player.origin, radiusmin, radiusmax, 150, 32, self );
    fwd = anglestoforward( player.angles );
    point = player.origin + fwd * 72;
    self botsetgoal( point, 42 );
    self sprint_to_goal();
}

// Namespace bot
// Params 3
// Checksum 0xcd932c6, Offset: 0x31d8
// Size: 0xd4
function follow_entity( entity, radiusmin, radiusmax )
{
    if ( !isdefined( radiusmin ) )
    {
        radiusmin = 24;
    }
    
    if ( !isdefined( radiusmax ) )
    {
        radiusmax = radiusmin + 1;
    }
    
    if ( !point_in_goal( entity.origin ) )
    {
        radius = randomintrange( radiusmin, radiusmax );
        self botsetgoal( entity.origin, radius );
        self sprint_to_goal();
    }
}

// Namespace bot
// Params 5
// Checksum 0xa7ee6018, Offset: 0x32b8
// Size: 0x544
function navmesh_wander( fwd, radiusmin, radiusmax, spacing, fwddot )
{
    if ( !isdefined( radiusmin ) )
    {
        radiusmin = isdefined( level.botsettings.wandermin ) ? level.botsettings.wandermin : 0;
    }
    
    if ( !isdefined( radiusmax ) )
    {
        radiusmax = isdefined( level.botsettings.wandermax ) ? level.botsettings.wandermax : 0;
    }
    
    if ( !isdefined( spacing ) )
    {
        spacing = isdefined( level.botsettings.wanderspacing ) ? level.botsettings.wanderspacing : 0;
    }
    
    if ( !isdefined( fwddot ) )
    {
        fwddot = isdefined( level.botsettings.wanderfwddot ) ? level.botsettings.wanderfwddot : 0;
    }
    
    if ( !isdefined( fwd ) )
    {
        fwd = anglestoforward( self.angles );
    }
    
    fwd = vectornormalize( ( fwd[ 0 ], fwd[ 1 ], 0 ) );
    
    /#
    #/
    
    queryresult = positionquery_source_navigation( self.origin, radiusmin, radiusmax, 150, spacing, self );
    best_point = undefined;
    origin = ( self.origin[ 0 ], self.origin[ 1 ], 0 );
    
    foreach ( point in queryresult.data )
    {
        movepoint = ( point.origin[ 0 ], point.origin[ 1 ], 0 );
        movedir = vectornormalize( movepoint - origin );
        dot = vectordot( movedir, fwd );
        point.score = mapfloat( radiusmin, radiusmax, 0, 50, point.disttoorigin2d );
        
        if ( dot > fwddot )
        {
            point.score += randomfloatrange( 30, 50 );
        }
        else if ( dot > 0 )
        {
            point.score += randomfloatrange( 10, 35 );
        }
        else
        {
            point.score += randomfloatrange( 0, 15 );
        }
        
        /#
        #/
        
        if ( !isdefined( best_point ) || point.score > best_point.score )
        {
            best_point = point;
        }
    }
    
    if ( isdefined( best_point ) )
    {
        /#
        #/
        
        self botsetgoal( best_point.origin, radiusmin );
        return;
    }
    
    /#
        if ( getdvarint( "<dev string:x4f>", 0 ) )
        {
            circle( self.origin, radiusmin, ( 1, 0, 0 ), 0, 1, 1200 );
            circle( self.origin, radiusmax, ( 1, 0, 0 ), 0, 1, 1200 );
            sphere( self.origin, 16, ( 0, 1, 0 ), 0.25, 0, 16, 1200 );
            iprintln( "<dev string:x5e>" + self.name + "<dev string:xa0>" + self.origin );
        }
    #/
    
    self thread stuck_resolution();
}

// Namespace bot
// Params 3
// Checksum 0x520b72d7, Offset: 0x3808
// Size: 0xf4
function approach_goal_trigger( trigger, radiusmax, spacing )
{
    if ( !isdefined( radiusmax ) )
    {
        radiusmax = 1500;
    }
    
    if ( !isdefined( spacing ) )
    {
        spacing = 128;
    }
    
    distsq = distancesquared( self.origin, trigger.origin );
    
    if ( distsq < radiusmax * radiusmax )
    {
        self path_to_point_in_trigger( trigger );
        return;
    }
    
    radiusmin = self get_trigger_radius( trigger );
    self approach_point( trigger.origin, radiusmin, radiusmax, spacing );
}

// Namespace bot
// Params 4
// Checksum 0x7a8e2522, Offset: 0x3908
// Size: 0x37c
function approach_point( point, radiusmin, radiusmax, spacing )
{
    if ( !isdefined( radiusmin ) )
    {
        radiusmin = 0;
    }
    
    if ( !isdefined( radiusmax ) )
    {
        radiusmax = 1500;
    }
    
    if ( !isdefined( spacing ) )
    {
        spacing = 128;
    }
    
    distsq = distancesquared( self.origin, point );
    
    if ( distsq < radiusmax * radiusmax )
    {
        self botsetgoal( point, 24 );
        return;
    }
    
    queryresult = positionquery_source_navigation( point, radiusmin, radiusmax, 150, spacing, self );
    fwd = anglestoforward( self.angles );
    fwd = ( fwd[ 0 ], fwd[ 1 ], 0 );
    origin = ( self.origin[ 0 ], self.origin[ 1 ], 0 );
    best_point = undefined;
    
    foreach ( point in queryresult.data )
    {
        movepoint = ( point.origin[ 0 ], point.origin[ 1 ], 0 );
        movedir = vectornormalize( movepoint - origin );
        dot = vectordot( movedir, fwd );
        point.score = randomfloatrange( 0, 50 );
        
        if ( dot < 0.5 )
        {
            point.score += randomfloatrange( 30, 50 );
        }
        else
        {
            point.score += randomfloatrange( 0, 15 );
        }
        
        if ( !isdefined( best_point ) || point.score > best_point.score )
        {
            best_point = point;
        }
    }
    
    if ( isdefined( best_point ) )
    {
        self botsetgoal( best_point.origin, 24 );
    }
}

// Namespace bot
// Params 0
// Checksum 0xeaa81190, Offset: 0x3c90
// Size: 0x5c, Type: bool
function revive_players()
{
    players = self get_team_players_in_laststand();
    
    if ( players.size > 0 )
    {
        revive_player( players[ 0 ] );
        return true;
    }
    
    return false;
}

// Namespace bot
// Params 0
// Checksum 0x28b517dc, Offset: 0x3cf8
// Size: 0xfc
function get_team_players_in_laststand()
{
    players = [];
    
    foreach ( player in level.players )
    {
        if ( player != self && player laststand::player_is_in_laststand() && player.team == self.team )
        {
            players[ players.size ] = player;
        }
    }
    
    players = arraysort( players, self.origin );
    return players;
}

// Namespace bot
// Params 1
// Checksum 0xd42b2ba8, Offset: 0x3e00
// Size: 0xc4
function revive_player( player )
{
    if ( !point_in_goal( player.origin ) )
    {
        self botsetgoal( player.origin, 64 );
        self sprint_to_goal();
        return;
    }
    
    if ( self botgoalreached() )
    {
        self botsetlookanglesfrompoint( player getcentroid() );
        self tap_use_button();
    }
}

// Namespace bot
// Params 2
// Checksum 0x63b22886, Offset: 0x3ed0
// Size: 0x170
function watch_bot_corner( startcornerdist, cornerdist )
{
    self endon( #"death" );
    self endon( #"bot_combat_target" );
    level endon( #"game_ended" );
    
    if ( !isdefined( startcornerdist ) )
    {
        startcornerdist = 64;
    }
    
    if ( !isdefined( cornerdist ) )
    {
        cornerdist = 128;
    }
    
    startcornerdistsq = cornerdist * cornerdist;
    cornerdistsq = cornerdist * cornerdist;
    
    while ( true )
    {
        self waittill( #"bot_corner", centerpoint, enterpoint, leavepoint, angle, nextenterpoint );
        
        if ( self bot_combat::has_threat() )
        {
            continue;
        }
        
        if ( distance2dsquared( self.origin, enterpoint ) < startcornerdistsq || distance2dsquared( leavepoint, nextenterpoint ) < cornerdistsq )
        {
            continue;
        }
        
        self thread wait_corner_radius( startcornerdistsq, centerpoint, enterpoint, leavepoint, angle, nextenterpoint );
    }
}

// Namespace bot
// Params 6
// Checksum 0xfe82edd, Offset: 0x4048
// Size: 0x10c
function wait_corner_radius( startcornerdistsq, centerpoint, enterpoint, leavepoint, angle, nextenterpoint )
{
    self endon( #"death" );
    self endon( #"bot_corner" );
    self endon( #"bot_goal_reached" );
    self endon( #"bot_combat_target" );
    level endon( #"game_ended" );
    
    while ( distance2dsquared( self.origin, enterpoint ) > startcornerdistsq )
    {
        if ( self bot_combat::has_threat() )
        {
            return;
        }
        
        wait 0.05;
    }
    
    self botlookatpoint( ( nextenterpoint[ 0 ], nextenterpoint[ 1 ], nextenterpoint[ 1 ] + 60 ) );
    self thread finish_corner();
}

// Namespace bot
// Params 0
// Checksum 0x3e052610, Offset: 0x4160
// Size: 0x64
function finish_corner()
{
    self endon( #"death" );
    self endon( #"combat_target" );
    level endon( #"game_ended" );
    self util::waittill_any( "bot_corner", "bot_goal_reached" );
    self botlookforward();
}

// Namespace bot
// Params 0
// Checksum 0x33006195, Offset: 0x41d0
// Size: 0xac
function get_host_player()
{
    players = getplayers();
    
    foreach ( player in players )
    {
        if ( player ishost() )
        {
            return player;
        }
    }
    
    return undefined;
}

// Namespace bot
// Params 1
// Checksum 0x88446226, Offset: 0x4288
// Size: 0xc4
function fwd_dot( point )
{
    angles = self getplayerangles();
    fwd = anglestoforward( angles );
    delta = point - self geteye();
    delta = vectornormalize( delta );
    dot = vectordot( fwd, delta );
    return dot;
}

// Namespace bot
// Params 0
// Checksum 0x6807058c, Offset: 0x4358
// Size: 0xb0, Type: bool
function has_launcher()
{
    weapons = self getweaponslist();
    
    foreach ( weapon in weapons )
    {
        if ( weapon.isrocketlauncher )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bot
// Params 0
// Checksum 0x5a9a61f7, Offset: 0x4410
// Size: 0x2c
function kill_bot()
{
    self dodamage( self.health, self.origin );
}

/#

    // Namespace bot
    // Params 0
    // Checksum 0x5405430a, Offset: 0x4448
    // Size: 0xaa, Type: dev
    function kill_bots()
    {
        foreach ( player in level.players )
        {
            if ( player util::is_bot() )
            {
                player kill_bot();
            }
        }
    }

    // Namespace bot
    // Params 1
    // Checksum 0xf51cea5b, Offset: 0x4500
    // Size: 0x15a, Type: dev
    function add_bot_at_eye_trace( team )
    {
        host = util::gethostplayer();
        trace = host eye_trace();
        direction_vec = host.origin - trace[ "<dev string:xbe>" ];
        direction = vectortoangles( direction_vec );
        yaw = direction[ 1 ];
        bot = add_bot( team );
        
        if ( isdefined( bot ) )
        {
            bot waittill( #"spawned_player" );
            bot setorigin( trace[ "<dev string:xbe>" ] );
            bot setplayerangles( ( bot.angles[ 0 ], yaw, bot.angles[ 2 ] ) );
        }
        
        return bot;
    }

    // Namespace bot
    // Params 0
    // Checksum 0xa97d49df, Offset: 0x4668
    // Size: 0xd4, Type: dev
    function eye_trace()
    {
        direction = self getplayerangles();
        direction_vec = anglestoforward( direction );
        eye = self geteye();
        scale = 8000;
        direction_vec = ( direction_vec[ 0 ] * scale, direction_vec[ 1 ] * scale, direction_vec[ 2 ] * scale );
        return bullettrace( eye, eye + direction_vec, 0, undefined );
    }

    // Namespace bot
    // Params 0
    // Checksum 0xba222abc, Offset: 0x4748
    // Size: 0x152, Type: dev
    function devgui_debug_route()
    {
        iprintln( "<dev string:xc7>" );
        points = self get_nav_points();
        
        if ( !isdefined( points ) || points.size == 0 )
        {
            iprintln( "<dev string:xd5>" );
            return;
        }
        
        iprintln( "<dev string:xeb>" );
        players = getplayers();
        
        foreach ( player in players )
        {
            if ( !player util::is_bot() )
            {
                continue;
            }
            
            player thread debug_patrol( points );
        }
    }

    // Namespace bot
    // Params 0
    // Checksum 0xa866648f, Offset: 0x48a8
    // Size: 0x22a, Type: dev
    function get_nav_points()
    {
        iprintln( "<dev string:x109>" );
        iprintln( "<dev string:x120>" );
        iprintln( "<dev string:x131>" );
        points = [];
        
        while ( true )
        {
            wait 0.05;
            point = self eye_trace()[ "<dev string:xbe>" ];
            
            if ( isdefined( point ) )
            {
                point = getclosestpointonnavmesh( point, 128 );
                
                if ( isdefined( point ) )
                {
                    sphere( point, 16, ( 0, 0, 1 ), 0.25, 0, 16, 1 );
                }
            }
            
            if ( self buttonpressed( "<dev string:x145>" ) )
            {
                if ( points.size == 0 || isdefined( point ) && distance2d( point, points[ points.size - 1 ] ) > 16 )
                {
                    points[ points.size ] = point;
                }
            }
            else if ( self buttonpressed( "<dev string:x14e>" ) )
            {
                return points;
            }
            else if ( self buttonpressed( "<dev string:x157>" ) )
            {
                return undefined;
            }
            
            for ( i = 0; i < points.size ; i++ )
            {
                sphere( points[ i ], 16, ( 0, 1, 0 ), 0.25, 0, 16, 1 );
            }
        }
    }

    // Namespace bot
    // Params 1
    // Checksum 0xbb172ebe, Offset: 0x4ae0
    // Size: 0xb4, Type: dev
    function debug_patrol( points )
    {
        self notify( #"debug_patrol" );
        self endon( #"death" );
        self endon( #"debug_patrol" );
        
        for ( i = 0; true ; i = ( i + 1 ) % points.size )
        {
            self botsetgoal( points[ i ], 24 );
            self sprint_to_goal();
            self waittill( #"bot_goal_reached" );
        }
    }

    // Namespace bot
    // Params 0
    // Checksum 0x11e3e8fd, Offset: 0x4ba0
    // Size: 0x128, Type: dev
    function bot_devgui_think()
    {
        while ( true )
        {
            wait 0.25;
            cmd = getdvarstring( "<dev string:x160>", "<dev string:x16b>" );
            
            if ( !isdefined( level.botdevguicmd ) || ![[ level.botdevguicmd ]]( cmd ) )
            {
                host = util::gethostplayer();
                
                switch ( cmd )
                {
                    case "<dev string:x16c>":
                        remove_bots();
                        break;
                    case "<dev string:x177>":
                        kill_bots();
                        break;
                    case "<dev string:x181>":
                        host devgui_debug_route();
                        break;
                    default:
                        break;
                }
            }
            
            setdvar( "<dev string:x160>", "<dev string:x16b>" );
        }
    }

    // Namespace bot
    // Params 1
    // Checksum 0xcbafbddd, Offset: 0x4cd0
    // Size: 0xf2, Type: dev
    function coop_bot_devgui_cmd( cmd )
    {
        host = get_host_player();
        
        switch ( cmd )
        {
            case "<dev string:x188>":
                add_bot( host.team );
                return 1;
            case "<dev string:x18c>":
                add_bots( 3, host.team );
                return 1;
            case "<dev string:x192>":
                add_bot_at_eye_trace();
                return 1;
            default:
                remove_bots( 1 );
                return 1;
        }
        
        return 0;
    }

    // Namespace bot
    // Params 3
    // Checksum 0x6dbfb4d4, Offset: 0x4dd0
    // Size: 0x8c, Type: dev
    function debug_star( origin, seconds, color )
    {
        if ( !isdefined( seconds ) )
        {
            seconds = 1;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 0, 0 );
        }
        
        frames = int( 20 * seconds );
        debugstar( origin, frames, color );
    }

#/
