#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/bots/_bot_ball;
#using scripts/mp/bots/_bot_clean;
#using scripts/mp/bots/_bot_combat;
#using scripts/mp/bots/_bot_conf;
#using scripts/mp/bots/_bot_ctf;
#using scripts/mp/bots/_bot_dem;
#using scripts/mp/bots/_bot_dom;
#using scripts/mp/bots/_bot_escort;
#using scripts/mp/bots/_bot_hq;
#using scripts/mp/bots/_bot_koth;
#using scripts/mp/bots/_bot_loadout;
#using scripts/mp/bots/_bot_sd;
#using scripts/mp/killstreaks/_emp;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_satellite;
#using scripts/mp/killstreaks/_uav;
#using scripts/mp/teams/_teams;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/bot_buttons;
#using scripts/shared/bots/bot_traversals;
#using scripts/shared/callbacks_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons_shared;

#namespace bot;

// Namespace bot
// Params 0, eflags: 0x2
// Checksum 0xf459461a, Offset: 0x650
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "bot_mp", &__init__, undefined, undefined );
}

// Namespace bot
// Params 0
// Checksum 0xd13cb7f0, Offset: 0x690
// Size: 0x15c
function __init__()
{
    callback::on_start_gametype( &init );
    level.getbotsettings = &get_bot_settings;
    level.onbotconnect = &on_bot_connect;
    level.onbotspawned = &on_bot_spawned;
    level.onbotkilled = &on_bot_killed;
    level.botidle = &bot_idle;
    level.botthreatlost = &bot_combat::chase_threat;
    level.botprecombat = &bot_combat::mp_pre_combat;
    level.botcombat = &bot_combat::combat_think;
    level.botpostcombat = &bot_combat::mp_post_combat;
    level.botignorethreat = &bot_combat::bot_ignore_threat;
    level.enemyempactive = &emp::enemyempactive;
    
    /#
        level.botdevguicmd = &function_682f20bc;
        level thread system_devgui_gadget_think();
    #/
}

// Namespace bot
// Params 0
// Checksum 0x4e87f123, Offset: 0x7f8
// Size: 0x84
function init()
{
    level endon( #"game_ended" );
    level.botsoak = is_bot_soak();
    
    if ( level.rankedmatch && !level.botsoak || !init_bot_gametype() )
    {
        return;
    }
    
    wait_for_host();
    level thread populate_bots();
}

// Namespace bot
// Params 0
// Checksum 0xd544fa50, Offset: 0x888
// Size: 0x52
function is_bot_soak()
{
    /#
        return getdvarint( "<dev string:x28>", 0 );
    #/
    
    return isdedicated() && getdvarint( "sv_botsoak", 0 );
}

// Namespace bot
// Params 0
// Checksum 0x92ca68db, Offset: 0x8e8
// Size: 0x64
function wait_for_host()
{
    level endon( #"game_ended" );
    
    if ( level.botsoak )
    {
        return;
    }
    
    for ( host = util::gethostplayerforbots(); !isdefined( host ) ; host = util::gethostplayerforbots() )
    {
        wait 0.25;
    }
}

// Namespace bot
// Params 0
// Checksum 0x6ed01a99, Offset: 0x958
// Size: 0x5e
function get_host_team()
{
    host = util::gethostplayerforbots();
    
    if ( !isdefined( host ) || host.team == "spectator" )
    {
        return "allies";
    }
    
    return host.team;
}

// Namespace bot
// Params 0
// Checksum 0xced4510b, Offset: 0x9c0
// Size: 0x6, Type: bool
function is_bot_comp_stomp()
{
    return false;
}

// Namespace bot
// Params 0
// Checksum 0x22a8233a, Offset: 0x9d0
// Size: 0x144
function on_bot_connect()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( isdefined( level.disableclassselection ) && level.disableclassselection )
    {
        self set_rank();
        self bot_loadout::pick_hero_gadget();
        self bot_loadout::pick_killstreaks();
        return;
    }
    
    if ( !( isdefined( self.pers[ "bot_loadout" ] ) && self.pers[ "bot_loadout" ] ) )
    {
        self set_rank();
        self bot_loadout::build_classes();
        self bot_loadout::pick_hero_gadget();
        self bot_loadout::pick_killstreaks();
        self.pers[ "bot_loadout" ] = 1;
    }
    
    self bot_loadout::pick_classes();
    self choose_class();
}

// Namespace bot
// Params 0
// Checksum 0xe122225d, Offset: 0xb20
// Size: 0x18c
function on_bot_spawned()
{
    self.bot.goaltag = undefined;
    
    /#
        weapon = undefined;
        
        if ( getdvarint( "<dev string:x33>" ) != 0 )
        {
            player = util::gethostplayer();
            weapon = player getcurrentweapon();
        }
        
        if ( getdvarstring( "<dev string:x4b>", "<dev string:x5d>" ) != "<dev string:x5d>" )
        {
            weapon = getweapon( getdvarstring( "<dev string:x4b>" ) );
        }
        
        if ( isdefined( weapon ) && level.weaponnone != weapon )
        {
            self weapons::detach_all_weapons();
            self takeallweapons();
            self giveweapon( weapon );
            self switchtoweapon( weapon );
            self setspawnweapon( weapon );
            self teams::set_player_model( self.team, weapon );
        }
    #/
}

// Namespace bot
// Params 0
// Checksum 0x153d5789, Offset: 0xcb8
// Size: 0x7c
function on_bot_killed()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"spawned" );
    self waittill( #"death_delay_finished" );
    wait 0.1;
    
    if ( self choose_class() && level.playerforcerespawn )
    {
        return;
    }
    
    self thread respawn();
}

// Namespace bot
// Params 0
// Checksum 0x117da822, Offset: 0xd40
// Size: 0x50
function respawn()
{
    self endon( #"spawned" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self tap_use_button();
        wait 0.1;
    }
}

// Namespace bot
// Params 0
// Checksum 0x9dc3a64b, Offset: 0xd98
// Size: 0x4c
function bot_idle()
{
    if ( self do_supplydrop() )
    {
        return;
    }
    
    self navmesh_wander();
    self sprint_to_goal();
}

// Namespace bot
// Params 1
// Checksum 0xa72d913b, Offset: 0xdf0
// Size: 0x334, Type: bool
function do_supplydrop( maxrange )
{
    if ( !isdefined( maxrange ) )
    {
        maxrange = 1400;
    }
    
    crates = getentarray( "care_package", "script_noteworthy" );
    maxrangesq = maxrange * maxrange;
    useradiussq = 3844;
    closestcrate = undefined;
    closestcratedistsq = undefined;
    
    foreach ( crate in crates )
    {
        if ( !crate isonground() )
        {
            continue;
        }
        
        cratedistsq = distance2dsquared( self.origin, crate.origin );
        
        if ( cratedistsq > maxrangesq )
        {
            continue;
        }
        
        inuse = isdefined( crate.useent.inuse ) && isdefined( crate.useent ) && crate.useent.inuse;
        
        if ( cratedistsq <= useradiussq )
        {
            if ( inuse && !self usebuttonpressed() )
            {
                continue;
            }
            
            self press_use_button();
            return true;
        }
        
        if ( !self has_minimap() && !self botsighttracepassed( crate ) )
        {
            continue;
        }
        
        if ( !isdefined( closestcrate ) || cratedistsq < closestcratedistsq )
        {
            closestcrate = crate;
            closestcratedistsq = cratedistsq;
        }
    }
    
    if ( isdefined( closestcrate ) )
    {
        randomangle = ( 0, randomint( 360 ), 0 );
        randomvec = anglestoforward( randomangle );
        point = closestcrate.origin + randomvec * 39;
        
        if ( self botsetgoal( point ) )
        {
            self thread watch_crate( closestcrate );
            return true;
        }
    }
    
    return false;
}

// Namespace bot
// Params 1
// Checksum 0xb0b37450, Offset: 0x1130
// Size: 0x84
function watch_crate( crate )
{
    self endon( #"death" );
    self endon( #"bot_goal_reached" );
    level endon( #"game_ended" );
    
    while ( isdefined( crate ) && !self bot_combat::has_threat() )
    {
        wait level.botsettings.thinkinterval;
    }
    
    self botsetgoal( self.origin );
}

// Namespace bot
// Params 0
// Checksum 0x4d85df5f, Offset: 0x11c0
// Size: 0xcc
function populate_bots()
{
    level endon( #"game_ended" );
    
    if ( level.teambased )
    {
        maxallies = getdvarint( "bot_maxAllies", 0 );
        maxaxis = getdvarint( "bot_maxAxis", 0 );
        level thread monitor_bot_team_population( maxallies, maxaxis );
        return;
    }
    
    maxfree = getdvarint( "bot_maxFree", 0 );
    level thread monitor_bot_population( maxfree );
}

// Namespace bot
// Params 2
// Checksum 0x379b3bc7, Offset: 0x1298
// Size: 0x148
function monitor_bot_team_population( maxallies, maxaxis )
{
    level endon( #"game_ended" );
    
    if ( !maxallies && !maxaxis )
    {
        return;
    }
    
    fill_balanced_teams( maxallies, maxaxis );
    
    while ( true )
    {
        wait 3;
        allies = getplayers( "allies" );
        axis = getplayers( "axis" );
        
        if ( allies.size > maxallies && remove_best_bot( allies ) )
        {
            continue;
        }
        
        if ( axis.size > maxaxis && remove_best_bot( axis ) )
        {
            continue;
        }
        
        if ( allies.size < maxallies || axis.size < maxaxis )
        {
            add_balanced_bot( allies, maxallies, axis, maxaxis );
        }
    }
}

// Namespace bot
// Params 2
// Checksum 0x8eb8c4b9, Offset: 0x13e8
// Size: 0xf4
function fill_balanced_teams( maxallies, maxaxis )
{
    allies = getplayers( "allies" );
    
    for ( axis = getplayers( "axis" ); ( allies.size < maxallies || axis.size < maxaxis ) && add_balanced_bot( allies, maxallies, axis, maxaxis ) ; axis = getplayers( "axis" ) )
    {
        wait 0.05;
        allies = getplayers( "allies" );
    }
}

// Namespace bot
// Params 4
// Checksum 0xcc7d3217, Offset: 0x14e8
// Size: 0xb6, Type: bool
function add_balanced_bot( allies, maxallies, axis, maxaxis )
{
    bot = undefined;
    
    if ( allies.size <= axis.size || allies.size < maxallies && axis.size >= maxaxis )
    {
        bot = add_bot( "allies" );
    }
    else if ( axis.size < maxaxis )
    {
        bot = add_bot( "axis" );
    }
    
    return isdefined( bot );
}

// Namespace bot
// Params 1
// Checksum 0xc6efe319, Offset: 0x15a8
// Size: 0xf8
function monitor_bot_population( maxfree )
{
    level endon( #"game_ended" );
    
    if ( !maxfree )
    {
        return;
    }
    
    for ( players = getplayers(); players.size < maxfree ; players = getplayers() )
    {
        add_bot();
        wait 0.05;
    }
    
    while ( true )
    {
        wait 3;
        players = getplayers();
        
        if ( players.size < maxfree )
        {
            add_bot();
            continue;
        }
        
        if ( players.size > maxfree )
        {
            remove_best_bot( players );
        }
    }
}

// Namespace bot
// Params 1
// Checksum 0x406e420c, Offset: 0x16a8
// Size: 0x198, Type: bool
function remove_best_bot( players )
{
    bots = filter_bots( players );
    
    if ( !bots.size )
    {
        return false;
    }
    
    bestbots = [];
    
    foreach ( bot in bots )
    {
        if ( bot.sessionstate == "spectator" )
        {
            continue;
        }
        
        if ( bot.sessionstate == "dead" || !bot bot_combat::has_threat() )
        {
            bestbots[ bestbots.size ] = bot;
        }
    }
    
    if ( bestbots.size )
    {
        remove_bot( bestbots[ randomint( bestbots.size ) ] );
    }
    else
    {
        remove_bot( bots[ randomint( bots.size ) ] );
    }
    
    return true;
}

// Namespace bot
// Params 0
// Checksum 0xa2746bc4, Offset: 0x1848
// Size: 0x116, Type: bool
function choose_class()
{
    if ( isdefined( level.disableclassselection ) && level.disableclassselection )
    {
        return false;
    }
    
    currclass = self bot_loadout::get_current_class();
    
    if ( !isdefined( currclass ) || randomint( 100 ) < ( isdefined( level.botsettings.changeclassweight ) ? level.botsettings.changeclassweight : 0 ) )
    {
        classindex = randomint( self.loadoutclasses.size );
        classname = self.loadoutclasses[ classindex ].name;
    }
    
    if ( !isdefined( classname ) || classname === currclass )
    {
        return false;
    }
    
    self notify( #"menuresponse", "ChooseClass_InGame", classname );
    return true;
}

// Namespace bot
// Params 0
// Checksum 0x1ce3024c, Offset: 0x1968
// Size: 0x1f6
function use_killstreak()
{
    if ( !level.loadoutkillstreaksenabled || self emp::enemyempactive() )
    {
        return;
    }
    
    weapons = self getweaponslist();
    inventoryweapon = self getinventoryweapon();
    
    foreach ( weapon in weapons )
    {
        killstreak = killstreaks::get_killstreak_for_weapon( weapon );
        
        if ( !isdefined( killstreak ) )
        {
            continue;
        }
        
        if ( weapon != inventoryweapon && !self getweaponammoclip( weapon ) )
        {
            continue;
        }
        
        if ( self killstreakrules::iskillstreakallowed( killstreak, self.team ) )
        {
            useweapon = weapon;
            break;
        }
    }
    
    if ( !isdefined( useweapon ) )
    {
        return;
    }
    
    killstreak_ref = killstreaks::get_menu_name( killstreak );
    
    switch ( killstreak_ref )
    {
        case "killstreak_counteruav":
        case "killstreak_helicopter_player_gunner":
        case "killstreak_raps":
        case "killstreak_satellite":
        case "killstreak_sentinel":
        default:
            self switchtoweapon( useweapon );
            break;
    }
}

// Namespace bot
// Params 0
// Checksum 0xf6389d03, Offset: 0x1b68
// Size: 0x6a, Type: bool
function has_radar()
{
    if ( level.teambased )
    {
        return ( uav::hasuav( self.team ) || satellite::hassatellite( self.team ) );
    }
    
    return uav::hasuav( self.entnum ) || satellite::hassatellite( self.entnum );
}

// Namespace bot
// Params 0
// Checksum 0xb4c29a33, Offset: 0x1be0
// Size: 0x50, Type: bool
function has_minimap()
{
    if ( self isempjammed() )
    {
        return false;
    }
    
    if ( isdefined( level.hardcoremode ) && level.hardcoremode )
    {
        return self has_radar();
    }
    
    return true;
}

// Namespace bot
// Params 1
// Checksum 0xe3bd3ca, Offset: 0x1c38
// Size: 0x1b0
function get_enemies( on_radar )
{
    if ( !isdefined( on_radar ) )
    {
        on_radar = 0;
    }
    
    enemies = self getenemies();
    
    /#
        for ( i = 0; i < enemies.size ; i++ )
        {
            if ( isplayer( enemies[ i ] ) && enemies[ i ] isinmovemode( "<dev string:x5e>", "<dev string:x62>" ) )
            {
                arrayremoveindex( enemies, i );
                i--;
            }
        }
    #/
    
    if ( on_radar && !self has_radar() )
    {
        for ( i = 0; i < enemies.size ; i++ )
        {
            if ( !isdefined( enemies[ i ].lastfiretime ) )
            {
                arrayremoveindex( enemies, i );
                i--;
                continue;
            }
            
            if ( gettime() - enemies[ i ].lastfiretime > 2000 )
            {
                arrayremoveindex( enemies, i );
                i--;
            }
        }
    }
    
    return enemies;
}

// Namespace bot
// Params 0
// Checksum 0x4b60b0fd, Offset: 0x1df0
// Size: 0x324
function set_rank()
{
    players = getplayers();
    ranks = [];
    bot_ranks = [];
    human_ranks = [];
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( players[ i ] == self )
        {
            continue;
        }
        
        if ( isdefined( players[ i ].pers[ "rank" ] ) )
        {
            if ( players[ i ] util::is_bot() )
            {
                bot_ranks[ bot_ranks.size ] = players[ i ].pers[ "rank" ];
                continue;
            }
            
            human_ranks[ human_ranks.size ] = players[ i ].pers[ "rank" ];
        }
    }
    
    if ( !human_ranks.size )
    {
        human_ranks[ human_ranks.size ] = 10;
    }
    
    human_avg = math::array_average( human_ranks );
    
    while ( bot_ranks.size + human_ranks.size < 5 )
    {
        r = human_avg + randomintrange( -5, 5 );
        rank = math::clamp( r, 0, level.maxrank );
        human_ranks[ human_ranks.size ] = rank;
    }
    
    ranks = arraycombine( human_ranks, bot_ranks, 1, 0 );
    avg = math::array_average( ranks );
    s = math::array_std_deviation( ranks, avg );
    rank = int( math::random_normal_distribution( avg, s, 0, level.maxrank ) );
    
    while ( !isdefined( self.pers[ "codpoints" ] ) )
    {
        wait 0.1;
    }
    
    self.pers[ "rank" ] = rank;
    self.pers[ "rankxp" ] = rank::getrankinfominxp( rank );
    self setrank( rank );
    self rank::syncxpstat();
}

// Namespace bot
// Params 0
// Checksum 0xb85cf2b0, Offset: 0x2120
// Size: 0x106, Type: bool
function init_bot_gametype()
{
    switch ( level.gametype )
    {
        case "ball":
            bot_ball::init();
            return true;
        case "conf":
            bot_conf::init();
            return true;
        case "ctf":
            bot_ctf::init();
            return true;
        case "dem":
            bot_dem::init();
            return true;
        case "dm":
            return true;
        case "dom":
            bot_dom::init();
            return true;
        case "escort":
            bot_escort::init();
            return true;
        case "infect":
            return true;
        case "gun":
            return true;
        case "koth":
            bot_koth::init();
            return true;
        case "sd":
            bot_sd::init();
            return true;
        case "clean":
            bot_clean::init();
            return true;
        default:
            return true;
    }
}

// Namespace bot
// Params 0
// Checksum 0xd251c025, Offset: 0x22a0
// Size: 0xba
function get_bot_settings()
{
    switch ( getdvarint( "bot_difficulty", 1 ) )
    {
        case 0:
            bundlename = "bot_mp_easy";
            break;
        case 1:
            bundlename = "bot_mp_normal";
            break;
        case 2:
            bundlename = "bot_mp_hard";
            break;
        case 3:
        default:
            bundlename = "bot_mp_veteran";
            break;
    }
    
    return struct::get_script_bundle( "botsettings", bundlename );
}

// Namespace bot
// Params 3
// Checksum 0xed3002fd, Offset: 0x2368
// Size: 0x1e, Type: bool
function friend_goal_in_radius( goal_name, origin, radius )
{
    return false;
}

// Namespace bot
// Params 3
// Checksum 0xb6116329, Offset: 0x2390
// Size: 0x1e, Type: bool
function friend_in_radius( goal_name, origin, radius )
{
    return false;
}

// Namespace bot
// Params 0
// Checksum 0xc902d934, Offset: 0x23b8
// Size: 0x6
function get_friends()
{
    return [];
}

// Namespace bot
// Params 2
// Checksum 0x5b4f9f29, Offset: 0x23c8
// Size: 0x16
function get_closest_enemy( origin, someflag )
{
    return undefined;
}

// Namespace bot
// Params 1
// Checksum 0x12b3937c, Offset: 0x23e8
// Size: 0xe, Type: bool
function bot_vehicle_weapon_ammo( weaponname )
{
    return false;
}

// Namespace bot
// Params 2
// Checksum 0x79895444, Offset: 0x2400
// Size: 0x16, Type: bool
function navmesh_points_visible( origin, point )
{
    return false;
}

// Namespace bot
// Params 1
// Checksum 0x2eed0321, Offset: 0x2420
// Size: 0xc
function dive_to_prone( exit_stance )
{
    
}

/#

    // Namespace bot
    // Params 1
    // Checksum 0xd22845a2, Offset: 0x2438
    // Size: 0x38a, Type: dev
    function function_682f20bc( cmd )
    {
        var_d03a6f21 = strtok( cmd, "<dev string:x69>" );
        
        if ( var_d03a6f21.size == 0 )
        {
            return 0;
        }
        
        host = util::gethostplayerforbots();
        team = get_host_team();
        
        switch ( var_d03a6f21[ 0 ] )
        {
            case "<dev string:x6b>":
                team = util::getotherteam( team );
            default:
                count = 1;
                
                if ( var_d03a6f21.size > 1 )
                {
                    count = int( var_d03a6f21[ 1 ] );
                }
                
                for ( i = 0; i < count ; i++ )
                {
                    add_bot( team );
                }
                
                return 1;
            case "<dev string:x86>":
                team = util::getotherteam( team );
            case "<dev string:x93>":
                remove_bots( undefined, team );
                return 1;
            case "<dev string:xa3>":
                team = util::getotherteam( team );
            case "<dev string:xb5>":
                bot = add_bot_at_eye_trace( team );
                
                if ( isdefined( bot ) )
                {
                    bot thread fixed_spawn_override();
                }
                
                return 1;
            case "<dev string:xca>":
                players = getplayers();
                
                foreach ( player in players )
                {
                    if ( !player util::is_bot() )
                    {
                        continue;
                    }
                    
                    weapon = host getcurrentweapon();
                    player weapons::detach_all_weapons();
                    player takeallweapons();
                    player giveweapon( weapon );
                    player switchtoweapon( weapon );
                    player setspawnweapon( weapon );
                    player teams::set_player_model( player.team, weapon );
                }
                
                return 1;
        }
        
        return 0;
    }

    // Namespace bot
    // Params 0
    // Checksum 0xd5d02109, Offset: 0x27d0
    // Size: 0xb8, Type: dev
    function system_devgui_gadget_think()
    {
        setdvar( "<dev string:xd8>", "<dev string:x5d>" );
        
        for ( ;; )
        {
            wait 1;
            gadget = getdvarstring( "<dev string:xd8>" );
            
            if ( gadget != "<dev string:x5d>" )
            {
                bot_turn_on_gadget( getweapon( gadget ) );
                setdvar( "<dev string:xd8>", "<dev string:x5d>" );
            }
        }
    }

    // Namespace bot
    // Params 1
    // Checksum 0x4458afcd, Offset: 0x2890
    // Size: 0x252, Type: dev
    function bot_turn_on_gadget( gadget )
    {
        players = getplayers();
        
        foreach ( player in players )
        {
            if ( !player util::is_bot() )
            {
                continue;
            }
            
            host = util::gethostplayer();
            weapon = host getcurrentweapon();
            
            if ( !isdefined( weapon ) || weapon == level.weaponnone || weapon == level.weaponnull )
            {
                weapon = getweapon( "<dev string:xea>" );
            }
            
            player weapons::detach_all_weapons();
            player takeallweapons();
            player giveweapon( weapon );
            player switchtoweapon( weapon );
            player setspawnweapon( weapon );
            player teams::set_player_model( player.team, weapon );
            player giveweapon( gadget );
            slot = player gadgetgetslot( gadget );
            player gadgetpowerset( slot, 100 );
            player botpressbuttonforgadget( gadget );
        }
    }

    // Namespace bot
    // Params 0
    // Checksum 0xd218870f, Offset: 0x2af0
    // Size: 0x88, Type: dev
    function fixed_spawn_override()
    {
        self endon( #"disconnect" );
        spawnorigin = self.origin;
        spawnangles = self.angles;
        
        while ( true )
        {
            self waittill( #"spawned_player" );
            self setorigin( spawnorigin );
            self setplayerangles( spawnangles );
        }
    }

#/
