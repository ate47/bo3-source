#using scripts/mp/_util;
#using scripts/mp/bots/_bot;
#using scripts/mp/bots/_bot_combat;
#using scripts/mp/teams/_teams;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/bot_buttons;
#using scripts/shared/bots/bot_traversals;
#using scripts/shared/callbacks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace bot_clean;

// Namespace bot_clean
// Params 0
// Checksum 0x30943025, Offset: 0x218
// Size: 0x4c
function init()
{
    level.botpostcombat = &bot_post_combat;
    level.botidle = &bot_idle;
    level.botupdatethreatgoal = &update_threat_goal;
}

// Namespace bot_clean
// Params 0
// Checksum 0x1376dff3, Offset: 0x270
// Size: 0x114
function bot_post_combat()
{
    if ( isdefined( self.targethub ) )
    {
        if ( self.carriedtacos == 0 || self.targethub.interactteam == "none" )
        {
            self.targethub = undefined;
            self botsetgoal( self.origin );
        }
    }
    
    if ( isdefined( self.targettaco ) )
    {
        if ( self.targettaco.interactteam == "none" || self.targettaco.droptime != self.targettacodroptime )
        {
            self.targettaco = undefined;
            self botsetgoal( self.origin );
        }
    }
    
    if ( !self bot_combat::has_threat() )
    {
        look_for_taco( 1024 );
    }
    
    self bot_combat::mp_post_combat();
}

// Namespace bot_clean
// Params 0
// Checksum 0x3d79df07, Offset: 0x390
// Size: 0x17c
function bot_idle()
{
    if ( isdefined( self.targethub ) )
    {
        self bot::path_to_point_in_trigger( self.targethub.trigger );
        self bot::sprint_to_goal();
        return;
    }
    
    if ( randomint( 10 ) < self.carriedtacos )
    {
        foreach ( hub in level.cleandeposithubs )
        {
            if ( hub.interactteam == "any" )
            {
                self.targethub = hub;
                self.targettaco = undefined;
                self bot::path_to_point_in_trigger( self.targethub.trigger );
                self bot::sprint_to_goal();
                return;
            }
        }
    }
    
    if ( look_for_taco( 1024 ) )
    {
        return;
    }
    
    self bot::bot_idle();
}

// Namespace bot_clean
// Params 1
// Checksum 0x89262acd, Offset: 0x518
// Size: 0xa0, Type: bool
function look_for_taco( radius )
{
    besttaco = get_best_taco( radius );
    
    if ( !isdefined( besttaco ) )
    {
        return false;
    }
    
    self.targettaco = besttaco;
    self.targettacodroptime = besttaco.droptime;
    self bot::path_to_point_in_trigger( besttaco.trigger );
    self bot::sprint_to_goal();
    return true;
}

// Namespace bot_clean
// Params 1
// Checksum 0xe8fc16f9, Offset: 0x5c0
// Size: 0x188
function get_best_taco( radius )
{
    radiussq = radius * radius;
    besttaco = undefined;
    besttacodistsq = undefined;
    
    foreach ( taco in level.tacos )
    {
        if ( taco.interactteam == "none" || !ispointonnavmesh( taco.origin, self ) )
        {
            continue;
        }
        
        tacodistsq = distance2dsquared( self.origin, taco.origin );
        
        if ( taco.attacker != self && tacodistsq > radiussq )
        {
            continue;
        }
        
        if ( !isdefined( besttaco ) || tacodistsq < besttacodistsq )
        {
            besttaco = taco;
            besttacodistsq = tacodistsq;
        }
    }
    
    return besttaco;
}

// Namespace bot_clean
// Params 0
// Checksum 0x733b7f91, Offset: 0x750
// Size: 0x114
function update_threat_goal()
{
    if ( isdefined( self.targethub ) )
    {
        if ( !self botgoalset() )
        {
            self bot::path_to_point_in_trigger( self.targethub.trigger );
            self bot::sprint_to_goal();
        }
        
        return;
    }
    
    radiussq = 65536;
    
    if ( isdefined( self.targettaco ) )
    {
        tacodistsq = distance2dsquared( self.origin, self.targettaco.origin );
        
        if ( tacodistsq > radiussq )
        {
            self.targettaco = undefined;
        }
    }
    
    if ( isdefined( self.targettaco ) || self look_for_taco( 1024 ) )
    {
        return;
    }
    
    self bot_combat::update_threat_goal();
}

