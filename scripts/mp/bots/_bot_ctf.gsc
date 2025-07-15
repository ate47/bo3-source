#using scripts/mp/_util;
#using scripts/mp/bots/_bot;
#using scripts/mp/bots/_bot_combat;
#using scripts/mp/gametypes/ctf;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace bot_ctf;

// Namespace bot_ctf
// Params 0
// Checksum 0xa3aed79e, Offset: 0x1a0
// Size: 0x34
function init()
{
    level.onbotconnect = &on_bot_connect;
    level.botidle = &bot_idle;
}

// Namespace bot_ctf
// Params 0
// Checksum 0x20aad701, Offset: 0x1e0
// Size: 0xd4
function on_bot_connect()
{
    foreach ( flag in level.flags )
    {
        if ( flag gameobjects::get_owner_team() == self.team )
        {
            self.bot.flag = flag;
            continue;
        }
        
        self.bot.enemyflag = flag;
    }
    
    self bot::on_bot_connect();
}

// Namespace bot_ctf
// Params 0
// Checksum 0x1a6dbf0b, Offset: 0x2c0
// Size: 0x32c
function bot_idle()
{
    carrier = self.bot.enemyflag gameobjects::get_carrier();
    
    if ( isdefined( carrier ) && carrier == self )
    {
        if ( self.bot.flag gameobjects::is_object_away_from_home() )
        {
            self bot::approach_point( self.bot.flag.flagbase.trigger.origin, 0, 1024 );
        }
        else
        {
            self bot::approach_goal_trigger( self.bot.flag.flagbase.trigger );
        }
        
        self bot::sprint_to_goal();
        return;
    }
    else if ( distance2dsquared( self.origin, self.bot.flag.flagbase.trigger.origin ) < 1048576 && randomint( 100 ) < 80 )
    {
        self bot::approach_point( self.bot.flag.flagbase.trigger.origin, 0, 1024 );
        self bot::sprint_to_goal();
        return;
    }
    else if ( self.bot.flag gameobjects::is_object_away_from_home() )
    {
        enemycarrier = self.bot.flag gameobjects::get_carrier();
        
        if ( isdefined( enemycarrier ) )
        {
            self bot::approach_point( enemycarrier.origin, 250, 1000, 128 );
            self bot::sprint_to_goal();
            return;
        }
        else
        {
            self botsetgoal( self.bot.flag.trigger.origin );
            self bot::sprint_to_goal();
            return;
        }
    }
    else if ( !isdefined( carrier ) )
    {
        self bot::approach_goal_trigger( self.bot.enemyflag.trigger );
        self bot::sprint_to_goal();
        return;
    }
    
    self bot::bot_idle();
}

