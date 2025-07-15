#using scripts/mp/bots/_bot;
#using scripts/mp/bots/_bot_combat;
#using scripts/mp/gametypes/dom;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace bot_dom;

// Namespace bot_dom
// Params 0
// Checksum 0xfcd9eb92, Offset: 0x188
// Size: 0x64
function init()
{
    level.botupdate = &bot_update;
    level.botprecombat = &bot_pre_combat;
    level.botupdatethreatgoal = &bot_update_threat_goal;
    level.botidle = &bot_idle;
}

// Namespace bot_dom
// Params 0
// Checksum 0x72bfab5b, Offset: 0x1f8
// Size: 0x114
function bot_update()
{
    self.bot.capturingflag = self get_capturing_flag();
    self.bot.goalflag = undefined;
    
    if ( !self botgoalreached() )
    {
        foreach ( flag in level.domflags )
        {
            if ( self bot::goal_in_trigger( flag.trigger ) )
            {
                self.bot.goalflag = flag;
                break;
            }
        }
    }
    
    self bot::bot_update();
}

// Namespace bot_dom
// Params 0
// Checksum 0x18c9a380, Offset: 0x318
// Size: 0x94
function bot_pre_combat()
{
    if ( !self bot_combat::has_threat() && isdefined( self.bot.goalflag ) && self.bot.goalflag gameobjects::get_owner_team() == self.team )
    {
        self botsetgoal( self.origin );
    }
    
    self bot_combat::mp_pre_combat();
}

// Namespace bot_dom
// Params 0
// Checksum 0xba0aca38, Offset: 0x3b8
// Size: 0xc4
function bot_idle()
{
    if ( isdefined( self.bot.capturingflag ) )
    {
        self bot::path_to_point_in_trigger( self.bot.capturingflag.trigger );
        return;
    }
    
    bestflag = get_best_flag();
    
    if ( isdefined( bestflag ) )
    {
        self bot::approach_goal_trigger( bestflag.trigger );
        self bot::sprint_to_goal();
        return;
    }
    
    self bot::bot_idle();
}

// Namespace bot_dom
// Params 0
// Checksum 0x8234aba5, Offset: 0x488
// Size: 0x74
function bot_update_threat_goal()
{
    if ( isdefined( self.bot.capturingflag ) )
    {
        if ( self botgoalreached() )
        {
            self bot::path_to_point_in_trigger( self.bot.capturingflag.trigger );
        }
        
        return;
    }
    
    self bot_combat::update_threat_goal();
}

// Namespace bot_dom
// Params 0
// Checksum 0xdce622e0, Offset: 0x508
// Size: 0xc4
function get_capturing_flag()
{
    foreach ( flag in level.domflags )
    {
        if ( self.team != flag gameobjects::get_owner_team() && self istouching( flag.trigger ) )
        {
            return flag;
        }
    }
    
    return undefined;
}

// Namespace bot_dom
// Params 0
// Checksum 0x190a3d78, Offset: 0x5d8
// Size: 0x15e
function get_best_flag()
{
    bestflag = undefined;
    bestflagdistsq = undefined;
    
    foreach ( flag in level.domflags )
    {
        ownerteam = flag gameobjects::get_owner_team();
        contested = flag gameobjects::get_num_touching_except_team( ownerteam );
        distsq = distance2dsquared( self.origin, flag.origin );
        
        if ( ownerteam == self.team && !contested )
        {
            continue;
        }
        
        if ( !isdefined( bestflag ) || distsq < bestflagdistsq )
        {
            bestflag = flag;
            bestflagdistsq = distsq;
        }
    }
    
    return bestflag;
}

