#using scripts/cp/_util;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/callbacks_shared;
#using scripts/shared/load_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace friendlyfire;

// Namespace friendlyfire
// Params 0, eflags: 0x2
// Checksum 0x8f431ea0, Offset: 0x308
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "friendlyfire", &__init__, undefined, undefined );
}

// Namespace friendlyfire
// Params 0
// Checksum 0x5bcd9dae, Offset: 0x348
// Size: 0x10c
function __init__()
{
    level.friendlyfirepoints[ "min_participation" ] = -1600;
    level.friendlyfirepoints[ "max_participation" ] = 1000;
    level.friendlyfirepoints[ "enemy_kill_points" ] = 250;
    level.friendlyfirepoints[ "friend_kill_points" ] = -600;
    level.friendlyfirepoints[ "civ_kill_points" ] = -900;
    level.friendlyfirepoints[ "point_loss_interval" ] = 0.75;
    level.friendlyfiredamagepercentage = 1;
    
    if ( util::coopgame() )
    {
        setdvar( "friendlyfire_enabled", "0" );
    }
    
    if ( !isdefined( level.friendlyfiredisabled ) )
    {
        level.friendlyfiredisabled = 0;
    }
    
    callback::on_connect( &init_player );
}

// Namespace friendlyfire
// Params 0
// Checksum 0xb679ea8b, Offset: 0x460
// Size: 0x5c
function init_player()
{
    assert( isdefined( self ), "<dev string:x28>" );
    self.participation = 0;
    self thread debug_friendlyfire();
    self thread participation_point_flattenovertime();
}

// Namespace friendlyfire
// Params 1
// Checksum 0x87f3e56, Offset: 0x4c8
// Size: 0x94
function debug_log( msg )
{
    /#
        if ( getdvarstring( "<dev string:x3c>" ) == "<dev string:x4f>" )
        {
            iprintlnbold( msg );
        }
        
        if ( getdvarstring( "<dev string:x52>" ) == "<dev string:x4f>" )
        {
            println( "<dev string:x69>" + msg );
        }
    #/
}

// Namespace friendlyfire
// Params 0
// Checksum 0xe91b0691, Offset: 0x568
// Size: 0xce8
function debug_friendlyfire()
{
    self endon( #"hash_cca1b1b9" );
    
    /#
        self endon( #"disconnect" );
        
        if ( getdvarstring( "<dev string:x3c>" ) == "<dev string:x79>" )
        {
            setdvar( "<dev string:x3c>", "<dev string:x7a>" );
        }
        
        if ( getdvarstring( "<dev string:x52>" ) == "<dev string:x79>" )
        {
            setdvar( "<dev string:x52>", "<dev string:x7a>" );
        }
        
        fullpts = level.friendlyfirepoints[ "<dev string:x7e>" ] - level.friendlyfirepoints[ "<dev string:x90>" ];
        lbound = 520;
        rbound = 620;
        ypos = 130;
        bar_width = rbound - lbound;
        friendly_fire = newdebughudelem();
        friendly_fire.fontscale = 3;
        friendly_fire.alignx = "<dev string:xa2>";
        friendly_fire.aligny = "<dev string:xa8>";
        friendly_fire.x = rbound - bar_width * level.friendlyfirepoints[ "<dev string:x7e>" ] / fullpts - log( self.participation ) * friendly_fire.fontscale;
        friendly_fire.y = 100;
        friendly_fire.alpha = 1;
        friendly_fire_lower_bound_label = newdebughudelem();
        friendly_fire_lower_bound_label.fontscale = 1.5;
        friendly_fire_lower_bound_label.alignx = "<dev string:xa2>";
        friendly_fire_lower_bound_label.aligny = "<dev string:xa8>";
        friendly_fire_lower_bound_label.x = lbound - ( ceil( max( log( abs( level.friendlyfirepoints[ "<dev string:x90>" ] ) ) / log( 10 ), 0 ) ) - 2 + ( self.participation < 0 ) ) * friendly_fire.fontscale;
        friendly_fire_lower_bound_label.y = ypos;
        friendly_fire_lower_bound_label.alpha = 1;
        friendly_fire_lower_bound_label setvalue( level.friendlyfirepoints[ "<dev string:x90>" ] );
        friendly_fire_upper_bound_label = newdebughudelem();
        friendly_fire_upper_bound_label.fontscale = 1.5;
        friendly_fire_upper_bound_label.alignx = "<dev string:xa2>";
        friendly_fire_upper_bound_label.aligny = "<dev string:xa8>";
        friendly_fire_upper_bound_label.x = rbound + 2 * ( ceil( max( log( abs( level.friendlyfirepoints[ "<dev string:x7e>" ] ) ) / log( 10 ), 0 ) ) + 2.5 + ( self.participation < 0 ) ) * friendly_fire.fontscale;
        friendly_fire_upper_bound_label.y = ypos;
        friendly_fire_upper_bound_label.alpha = 1;
        friendly_fire_upper_bound_label setvalue( level.friendlyfirepoints[ "<dev string:x7e>" ] );
        debug_health_bar_bg = newclienthudelem( self );
        debug_health_bar_bg.alignx = "<dev string:xa2>";
        debug_health_bar_bg.aligny = "<dev string:xa8>";
        debug_health_bar_bg.x = rbound;
        debug_health_bar_bg.y = ypos;
        debug_health_bar_bg.sort = 1;
        debug_health_bar_bg.alpha = 1;
        debug_health_bar_bg.foreground = 1;
        debug_health_bar_bg.color = ( 0.4, 0.4, 0.4 );
        debug_health_bar_bg setshader( "<dev string:xaf>", bar_width, 9 );
        debug_health_bar = newclienthudelem( self );
        debug_health_bar.alignx = "<dev string:xa2>";
        debug_health_bar.aligny = "<dev string:xa8>";
        debug_health_bar.x = 620;
        debug_health_bar.y = ypos;
        debug_health_bar.sort = 4;
        debug_health_bar.alpha = 1;
        debug_health_bar.foreground = 1;
        debug_health_bar.color = ( 0, 0, 0.9 );
        debug_health_bar setshader( "<dev string:xaf>", 4, 15 );
        debug_health_bar_left_bound = newclienthudelem( self );
        debug_health_bar_left_bound.alignx = "<dev string:xa2>";
        debug_health_bar_left_bound.aligny = "<dev string:xa8>";
        debug_health_bar_left_bound.x = lbound;
        debug_health_bar_left_bound.y = ypos;
        debug_health_bar_left_bound.sort = 2;
        debug_health_bar_left_bound.alpha = 1;
        debug_health_bar_left_bound.foreground = 1;
        debug_health_bar_left_bound setshader( "<dev string:xb5>", 4, 21 );
        debug_health_bar_right_bound = newclienthudelem( self );
        debug_health_bar_right_bound.alignx = "<dev string:xa2>";
        debug_health_bar_right_bound.aligny = "<dev string:xa8>";
        debug_health_bar_right_bound.x = rbound;
        debug_health_bar_right_bound.y = ypos;
        debug_health_bar_right_bound.sort = 2;
        debug_health_bar_right_bound.alpha = 1;
        debug_health_bar_right_bound.foreground = 1;
        debug_health_bar_right_bound setshader( "<dev string:xb5>", 4, 21 );
        debug_health_bar_0_top = newclienthudelem( self );
        debug_health_bar_0_top.alignx = "<dev string:xa2>";
        debug_health_bar_0_top.aligny = "<dev string:xa8>";
        debug_health_bar_0_top.x = lbound + level.friendlyfirepoints[ "<dev string:x90>" ] * -1 / fullpts * bar_width;
        debug_health_bar_0_top.y = ypos + 9;
        debug_health_bar_0_top.sort = 2;
        debug_health_bar_0_top.alpha = 1;
        debug_health_bar_0_top.foreground = 1;
        debug_health_bar_0_top setshader( "<dev string:xb5>", 4, 4 );
        debug_health_bar_0_bottom = newclienthudelem( self );
        debug_health_bar_0_bottom.alignx = "<dev string:xa2>";
        debug_health_bar_0_bottom.aligny = "<dev string:xa8>";
        debug_health_bar_0_bottom.x = lbound + level.friendlyfirepoints[ "<dev string:x90>" ] * -1 / fullpts * bar_width;
        debug_health_bar_0_bottom.y = ypos - 9;
        debug_health_bar_0_bottom.sort = 2;
        debug_health_bar_0_bottom.alpha = 1;
        debug_health_bar_0_bottom.foreground = 1;
        debug_health_bar_0_bottom setshader( "<dev string:xb5>", 4, 4 );
        
        for ( ;; )
        {
            if ( getdvarstring( "<dev string:x3c>" ) == "<dev string:x4f>" )
            {
                friendly_fire.alpha = 1;
                friendly_fire_lower_bound_label.alpha = 1;
                friendly_fire_upper_bound_label.alpha = 1;
                debug_health_bar_bg.alpha = 1;
                debug_health_bar.alpha = 1;
                debug_health_bar_left_bound.alpha = 1;
                debug_health_bar_right_bound.alpha = 1;
                debug_health_bar_0_top.alpha = 1;
                debug_health_bar_0_bottom.alpha = 1;
            }
            else
            {
                friendly_fire.alpha = 0;
                friendly_fire_lower_bound_label.alpha = 0;
                friendly_fire_upper_bound_label.alpha = 0;
                debug_health_bar_bg.alpha = 0;
                debug_health_bar.alpha = 0;
                debug_health_bar_left_bound.alpha = 0;
                debug_health_bar_right_bound.alpha = 0;
                debug_health_bar_0_top.alpha = 0;
                debug_health_bar_0_bottom.alpha = 0;
            }
            
            xpos = ( level.friendlyfirepoints[ "<dev string:x7e>" ] - self.participation ) / fullpts * bar_width;
            debug_health_bar.x = rbound - xpos;
            friendly_fire setvalue( self.participation );
            friendly_fire.x = rbound - bar_width * level.friendlyfirepoints[ "<dev string:x7e>" ] / fullpts + ( ceil( max( log( abs( self.participation ) ) / log( 10 ), 0 ) ) + 1 + ( self.participation < 0 ) ) * friendly_fire.fontscale * 2;
            wait 0.25;
        }
    #/
}

// Namespace friendlyfire
// Params 1
// Checksum 0x6a1c25f3, Offset: 0x1258
// Size: 0x3e, Type: bool
function check_warlord_killed( entity )
{
    if ( entity.archetype == "warlord_soldier" )
    {
        return ( entity.shieldhealth <= 0 );
    }
    
    return false;
}

// Namespace friendlyfire
// Params 4
// Checksum 0x3dd72d5a, Offset: 0x12a0
// Size: 0x5a4
function friendly_fire_callback( entity, damage, attacker, method )
{
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( !isdefined( entity.team ) )
    {
        entity.team = "allies";
    }
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    warlord_was_killed = check_warlord_killed( entity );
    
    if ( entity.health <= 0 )
    {
        if ( !warlord_was_killed )
        {
            return;
        }
    }
    
    if ( level.friendlyfiredisabled )
    {
        return;
    }
    
    if ( isdefined( entity.nofriendlyfire ) && entity.nofriendlyfire )
    {
        return;
    }
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    bplayersdamage = 0;
    
    if ( isplayer( attacker ) )
    {
        bplayersdamage = 1;
    }
    else if ( isdefined( attacker.classname ) && attacker.classname == "script_vehicle" )
    {
        owner = attacker getvehicleowner();
        
        if ( isdefined( owner ) )
        {
            if ( isplayer( owner ) )
            {
                if ( !isdefined( owner.friendlyfire_attacker_not_vehicle_owner ) )
                {
                    bplayersdamage = 1;
                    attacker = owner;
                }
            }
        }
    }
    
    if ( !bplayersdamage )
    {
        return;
    }
    
    same_team = entity.team == attacker.team;
    
    if ( attacker.team == "allies" )
    {
        if ( entity.team == "neutral" && !( isdefined( level.ignoreneutralfriendlyfire ) && level.ignoreneutralfriendlyfire ) )
        {
            same_team = 1;
        }
    }
    
    if ( entity.team == "neutral" && ( entity.team != "neutral" || !( isdefined( level.ignoreneutralfriendlyfire ) && level.ignoreneutralfriendlyfire ) ) )
    {
        attacker.last_hit_team = entity.team;
    }
    
    killed = damage >= entity.health || warlord_was_killed;
    
    if ( !entity.allowdeath )
    {
        killed = 0;
    }
    
    if ( !same_team )
    {
        if ( killed )
        {
            attacker.participation += level.friendlyfirepoints[ "enemy_kill_points" ];
            attacker participation_point_cap();
            debug_log( "Enemy killed: +" + level.friendlyfirepoints[ "enemy_kill_points" ] );
        }
        
        return;
    }
    
    if ( isdefined( entity.no_friendly_fire_penalty ) )
    {
        return;
    }
    
    if ( killed )
    {
        if ( entity.team == "neutral" )
        {
            level notify( #"player_killed_civ" );
            attacker.participation += level.friendlyfirepoints[ "civ_kill_points" ];
            debug_log( "Civilian killed: -" + 0 - level.friendlyfirepoints[ "civ_kill_points" ] );
        }
        else if ( isdefined( entity ) && isdefined( entity.ff_kill_penalty ) )
        {
            attacker.participation += entity.ff_kill_penalty;
            debug_log( "Friendly killed with custom penalty: -" + 0 - entity.ff_kill_penalty );
        }
        else
        {
            attacker.participation += level.friendlyfirepoints[ "friend_kill_points" ];
            debug_log( "Friendly killed: -" + 0 - level.friendlyfirepoints[ "friend_kill_points" ] );
        }
    }
    else
    {
        attacker.participation -= damage;
        debug_log( "Friendly hurt: -" + damage );
    }
    
    attacker participation_point_cap();
    
    if ( check_grenade( entity, method ) && savecommit_aftergrenade() )
    {
        return;
    }
    
    attacker friendly_fire_checkpoints();
}

// Namespace friendlyfire
// Params 1
// Checksum 0x30087afe, Offset: 0x1850
// Size: 0x610
function friendly_fire_think( entity )
{
    level endon( #"hash_77e184" );
    entity endon( #"no_friendly_fire" );
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( !isdefined( entity.team ) )
    {
        entity.team = "allies";
    }
    
    for ( ;; )
    {
        if ( !isdefined( entity ) )
        {
            return;
        }
        
        entity waittill( #"damage", damage, attacker, _, _, method );
        
        if ( level.friendlyfiredisabled )
        {
            continue;
        }
        
        if ( !isdefined( entity ) )
        {
            return;
        }
        
        if ( isdefined( entity.nofriendlyfire ) && entity.nofriendlyfire )
        {
            continue;
        }
        
        if ( !isdefined( attacker ) )
        {
            continue;
        }
        
        bplayersdamage = 0;
        
        if ( isplayer( attacker ) )
        {
            bplayersdamage = 1;
        }
        else if ( isdefined( attacker.classname ) && attacker.classname == "script_vehicle" )
        {
            owner = attacker getvehicleowner();
            
            if ( isdefined( owner ) )
            {
                if ( isplayer( owner ) )
                {
                    if ( !isdefined( owner.friendlyfire_attacker_not_vehicle_owner ) )
                    {
                        bplayersdamage = 1;
                        attacker = owner;
                    }
                }
            }
        }
        
        if ( !bplayersdamage )
        {
            continue;
        }
        
        same_team = entity.team == attacker.team;
        
        if ( attacker.team == "allies" )
        {
            if ( entity.team == "neutral" && !( isdefined( level.ignoreneutralfriendlyfire ) && level.ignoreneutralfriendlyfire ) )
            {
                same_team = 1;
            }
        }
        
        if ( entity.team == "neutral" && ( entity.team != "neutral" || !( isdefined( level.ignoreneutralfriendlyfire ) && level.ignoreneutralfriendlyfire ) ) )
        {
            attacker.last_hit_team = entity.team;
        }
        
        killed = damage >= entity.health;
        
        if ( !same_team )
        {
            if ( killed )
            {
                attacker.participation += level.friendlyfirepoints[ "enemy_kill_points" ];
                attacker participation_point_cap();
                debug_log( "Enemy killed: +" + level.friendlyfirepoints[ "enemy_kill_points" ] );
            }
            
            return;
        }
        
        if ( isdefined( entity.no_friendly_fire_penalty ) )
        {
            continue;
        }
        
        if ( killed )
        {
            if ( entity.team == "neutral" )
            {
                level notify( #"player_killed_civ" );
                
                if ( attacker.participation <= 0 )
                {
                    attacker.participation += level.friendlyfirepoints[ "min_participation" ];
                    debug_log( "Civilian killed with negative score, autofail!" );
                }
                else
                {
                    attacker.participation += level.friendlyfirepoints[ "civ_kill_points" ];
                    debug_log( "Civilian killed: -" + 0 - level.friendlyfirepoints[ "civ_kill_points" ] );
                }
            }
            else if ( isdefined( entity ) && isdefined( entity.ff_kill_penalty ) )
            {
                attacker.participation += entity.ff_kill_penalty;
                debug_log( "Friendly killed with custom penalty: -" + 0 - entity.ff_kill_penalty );
            }
            else
            {
                attacker.participation += level.friendlyfirepoints[ "friend_kill_points" ];
                debug_log( "Friendly killed: -" + 0 - level.friendlyfirepoints[ "friend_kill_points" ] );
            }
        }
        else
        {
            attacker.participation -= damage;
            debug_log( "Friendly hurt: -" + damage );
        }
        
        attacker participation_point_cap();
        
        if ( check_grenade( entity, method ) && savecommit_aftergrenade() )
        {
            if ( killed )
            {
                return;
            }
            
            continue;
        }
        
        attacker friendly_fire_checkpoints();
    }
}

// Namespace friendlyfire
// Params 0
// Checksum 0x3fca0fb4, Offset: 0x1e68
// Size: 0x34
function friendly_fire_checkpoints()
{
    if ( self.participation <= level.friendlyfirepoints[ "min_participation" ] )
    {
        self thread missionfail();
    }
}

// Namespace friendlyfire
// Params 2
// Checksum 0xcf582966, Offset: 0x1ea8
// Size: 0x9a
function check_grenade( entity, method )
{
    if ( !isdefined( entity ) )
    {
        return 0;
    }
    
    wasgrenade = 0;
    
    if ( isdefined( entity.damageweapon ) && entity.damageweapon.name == "none" )
    {
        wasgrenade = 1;
    }
    
    if ( isdefined( method ) && method == "MOD_GRENADE_SPLASH" )
    {
        wasgrenade = 1;
    }
    
    return wasgrenade;
}

// Namespace friendlyfire
// Params 0
// Checksum 0x707086bb, Offset: 0x1f50
// Size: 0x44, Type: bool
function savecommit_aftergrenade()
{
    currenttime = gettime();
    
    if ( currenttime < 4500 )
    {
        println( "<dev string:xbb>" );
        return true;
    }
    
    return false;
}

// Namespace friendlyfire
// Params 0
// Checksum 0x84e6f7e5, Offset: 0x1fa0
// Size: 0xa0
function participation_point_cap()
{
    if ( !isdefined( self.participation ) )
    {
        assertmsg( "<dev string:x124>" );
        return;
    }
    
    if ( self.participation > level.friendlyfirepoints[ "max_participation" ] )
    {
        self.participation = level.friendlyfirepoints[ "max_participation" ];
    }
    
    if ( self.participation < level.friendlyfirepoints[ "min_participation" ] )
    {
        self.participation = level.friendlyfirepoints[ "min_participation" ];
    }
}

// Namespace friendlyfire
// Params 0
// Checksum 0xbf157873, Offset: 0x2048
// Size: 0x66
function participation_point_flattenovertime()
{
    level endon( #"friendly_fire_terminate" );
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        if ( self.participation > 0 )
        {
            self.participation--;
        }
        else if ( self.participation < 0 )
        {
            self.participation++;
        }
        
        wait level.friendlyfirepoints[ "point_loss_interval" ];
    }
}

// Namespace friendlyfire
// Params 0
// Checksum 0x51d81f6d, Offset: 0x20b8
// Size: 0x10
function turnbackon()
{
    level.friendlyfiredisabled = 0;
}

// Namespace friendlyfire
// Params 0
// Checksum 0x1265aa88, Offset: 0x20d0
// Size: 0x10
function turnoff()
{
    level.friendlyfiredisabled = 1;
}

// Namespace friendlyfire
// Params 0
// Checksum 0xc7fd51ff, Offset: 0x20e8
// Size: 0x8c
function missionfail()
{
    self endon( #"death" );
    level endon( #"hash_1078e68a" );
    self.participation = 0;
    self.lives = 0;
    
    if ( self.last_hit_team === "neutral" )
    {
        util::missionfailedwrapper_nodeath( &"SCRIPT_MISSIONFAIL_KILLTEAM_NEUTRAL", &"SCRIPT_MISSIONFAIL_WATCH_FIRE" );
        return;
    }
    
    util::missionfailedwrapper_nodeath( &"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN", &"SCRIPT_MISSIONFAIL_WATCH_FIRE" );
}

// Namespace friendlyfire
// Params 1
// Checksum 0x58ad3d55, Offset: 0x2180
// Size: 0x7c
function notifydamage( entity )
{
    level endon( #"hash_77e184" );
    entity endon( #"death" );
    
    for ( ;; )
    {
        entity waittill( #"damage", damage, attacker, _, _, method );
        entity notify( #"friendlyfire_notify", damage, attacker, undefined, undefined, method );
    }
}

// Namespace friendlyfire
// Params 1
// Checksum 0xd2f3d1c0, Offset: 0x2208
// Size: 0x6c
function notifydamagenotdone( entity )
{
    level endon( #"hash_77e184" );
    entity waittill( #"damage_notdone", damage, attacker, _, _, method );
    entity notify( #"friendlyfire_notify", -1, attacker, undefined, undefined, method );
}

// Namespace friendlyfire
// Params 1
// Checksum 0x37a32e72, Offset: 0x2280
// Size: 0x5c
function notifydeath( entity )
{
    level endon( #"hash_77e184" );
    entity waittill( #"death", attacker, method );
    entity notify( #"friendlyfire_notify", -1, attacker, undefined, undefined, method );
}

