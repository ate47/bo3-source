#using scripts/mp/_util;
#using scripts/mp/bots/_bot;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/bot_traversals;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weapon_utils;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons_shared;

#namespace bot_combat;

// Namespace bot_combat
// Params 1
// Checksum 0x7462de04, Offset: 0x258
// Size: 0x48, Type: bool
function bot_ignore_threat( entity )
{
    if ( threat_requires_launcher( entity ) && !self bot::has_launcher() )
    {
        return true;
    }
    
    return false;
}

// Namespace bot_combat
// Params 0
// Checksum 0x1ea39ef, Offset: 0x2a8
// Size: 0x13c
function mp_pre_combat()
{
    self bot_pre_combat();
    
    if ( self isreloading() || self isswitchingweapons() || self isthrowinggrenade() || self ismeleeing() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked() )
    {
        return;
    }
    
    if ( self has_threat() )
    {
        self threat_switch_weapon();
        return;
    }
    
    if ( self switch_weapon() )
    {
        return;
    }
    
    if ( self reload_weapon() )
    {
        return;
    }
    
    self bot::use_killstreak();
}

// Namespace bot_combat
// Params 0
// Checksum 0xfb8dc5, Offset: 0x3f0
// Size: 0x1e4
function mp_post_combat()
{
    if ( !isdefined( level.dogtags ) )
    {
        return;
    }
    
    if ( isdefined( self.bot.goaltag ) )
    {
        if ( !self.bot.goaltag gameobjects::can_interact_with( self ) )
        {
            self.bot.goaltag = undefined;
            
            if ( !self has_threat() && self botgoalset() )
            {
                self botsetgoal( self.origin );
            }
        }
        else if ( !self.bot.goaltagonground && !self has_threat() && self isonground() && distance2dsquared( self.origin, self.bot.goaltag.origin ) < 16384 && self botsighttrace( self.bot.goaltag ) )
        {
            self thread bot::jump_to( self.bot.goaltag.origin );
        }
        
        return;
    }
    
    if ( !self botgoalset() )
    {
        closesttag = self get_closest_tag();
        
        if ( isdefined( closesttag ) )
        {
            self set_goal_tag( closesttag );
        }
    }
}

// Namespace bot_combat
// Params 1
// Checksum 0x35148488, Offset: 0x5e0
// Size: 0xd6, Type: bool
function threat_requires_launcher( enemy )
{
    if ( !isdefined( enemy ) || isplayer( enemy ) )
    {
        return false;
    }
    
    killstreaktype = undefined;
    
    if ( isdefined( enemy.killstreaktype ) )
    {
        killstreaktype = enemy.killstreaktype;
    }
    else if ( isdefined( enemy.parentstruct ) && isdefined( enemy.parentstruct.killstreaktype ) )
    {
        killstreaktype = enemy.parentstruct.killstreaktype;
    }
    
    if ( !isdefined( killstreaktype ) )
    {
        return false;
    }
    
    switch ( killstreaktype )
    {
        case "counteruav":
        case "helicopter_gunner":
        case "satellite":
        default:
            return true;
    }
}

// Namespace bot_combat
// Params 1
// Checksum 0x998272b4, Offset: 0x6e8
// Size: 0xc
function combat_throw_proximity( origin )
{
    
}

// Namespace bot_combat
// Params 1
// Checksum 0x986bdb02, Offset: 0x700
// Size: 0xc
function combat_throw_smoke( origin )
{
    
}

// Namespace bot_combat
// Params 1
// Checksum 0xdc59b920, Offset: 0x718
// Size: 0xc
function combat_throw_lethal( origin )
{
    
}

// Namespace bot_combat
// Params 1
// Checksum 0x3baad24e, Offset: 0x730
// Size: 0xc
function combat_throw_tactical( origin )
{
    
}

// Namespace bot_combat
// Params 1
// Checksum 0xdaf54bc3, Offset: 0x748
// Size: 0xc
function combat_toss_frag( origin )
{
    
}

// Namespace bot_combat
// Params 1
// Checksum 0xaee3877d, Offset: 0x760
// Size: 0xc
function combat_toss_flash( origin )
{
    
}

// Namespace bot_combat
// Params 1
// Checksum 0x1725caee, Offset: 0x778
// Size: 0xe, Type: bool
function combat_tactical_insertion( origin )
{
    return false;
}

// Namespace bot_combat
// Params 1
// Checksum 0x861e3db8, Offset: 0x790
// Size: 0xe
function nearest_node( origin )
{
    return undefined;
}

// Namespace bot_combat
// Params 1
// Checksum 0x17d8c4f5, Offset: 0x7a8
// Size: 0x22
function dot_product( origin )
{
    return bot::fwd_dot( origin );
}

// Namespace bot_combat
// Params 0
// Checksum 0xc103bceb, Offset: 0x7d8
// Size: 0x118
function get_closest_tag()
{
    closesttag = undefined;
    closesttagdistsq = undefined;
    
    foreach ( tag in level.dogtags )
    {
        if ( !tag gameobjects::can_interact_with( self ) )
        {
            continue;
        }
        
        distsq = distancesquared( self.origin, tag.origin );
        
        if ( !isdefined( closesttag ) || distsq < closesttagdistsq )
        {
            closesttag = tag;
            closesttagdistsq = distsq;
        }
    }
    
    return closesttag;
}

// Namespace bot_combat
// Params 1
// Checksum 0xbeb4ce61, Offset: 0x8f8
// Size: 0xec
function set_goal_tag( tag )
{
    self.bot.goaltag = tag;
    tracestart = tag.origin;
    traceend = tag.origin + ( 0, 0, -64 );
    trace = bullettrace( tracestart, traceend, 0, undefined );
    self.bot.goaltagonground = trace[ "fraction" ] < 1;
    self bot::path_to_trigger( tag.trigger );
    self bot::sprint_to_goal();
}

