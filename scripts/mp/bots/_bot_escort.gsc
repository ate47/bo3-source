#using scripts/mp/_util;
#using scripts/mp/bots/_bot;
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

#namespace bot_escort;

// Namespace bot_escort
// Params 0
// Checksum 0x11dcaeac, Offset: 0x1f8
// Size: 0x1c
function init()
{
    level.botidle = &bot_idle;
}

// Namespace bot_escort
// Params 0
// Checksum 0xe007fe44, Offset: 0x220
// Size: 0x4c
function bot_idle()
{
    if ( self.team == game[ "attackers" ] )
    {
        self function_69879c50();
        return;
    }
    
    self function_16ce4b24();
}

// Namespace bot_escort
// Params 0
// Checksum 0x8b74385b, Offset: 0x278
// Size: 0xec
function function_69879c50()
{
    if ( level.robot.active || isdefined( level.moveobject ) && level.rebootplayers > 0 )
    {
        if ( !level.robot.moving || math::cointoss() )
        {
            self bot::path_to_point_in_trigger( level.moveobject.trigger );
        }
        else
        {
            self bot::approach_point( level.moveobject.trigger.origin, 160, 400 );
        }
        
        self bot::sprint_to_goal();
        return;
    }
    
    self bot::bot_idle();
}

// Namespace bot_escort
// Params 0
// Checksum 0x203a2cfe, Offset: 0x370
// Size: 0x84
function function_16ce4b24()
{
    if ( isdefined( level.moveobject ) && level.robot.active )
    {
        self bot::approach_point( level.moveobject.trigger.origin, 160, 400 );
        self bot::sprint_to_goal();
        return;
    }
    
    self bot::bot_idle();
}

