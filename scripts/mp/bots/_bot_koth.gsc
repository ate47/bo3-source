#using scripts/mp/bots/_bot;
#using scripts/mp/bots/_bot_combat;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace bot_koth;

// Namespace bot_koth
// Params 0
// Checksum 0x3fa050e8, Offset: 0x148
// Size: 0x4c
function init()
{
    level.onbotspawned = &on_bot_spawned;
    level.botupdatethreatgoal = &bot_update_threat_goal;
    level.botidle = &bot_idle;
}

// Namespace bot_koth
// Params 0
// Checksum 0x7f53e294, Offset: 0x1a0
// Size: 0x34
function on_bot_spawned()
{
    self thread wait_zone_moved();
    self bot::on_bot_spawned();
}

// Namespace bot_koth
// Params 0
// Checksum 0x23fee3f3, Offset: 0x1e0
// Size: 0x80
function wait_zone_moved()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"zone_moved" );
        
        if ( !self bot_combat::has_threat() && self botgoalset() )
        {
            self botsetgoal( self.origin );
        }
    }
}

// Namespace bot_koth
// Params 0
// Checksum 0x8c2b8aae, Offset: 0x268
// Size: 0x9c
function bot_update_threat_goal()
{
    if ( isdefined( level.zone ) && self istouching( level.zone.gameobject.trigger ) )
    {
        if ( self botgoalreached() )
        {
            self bot::path_to_point_in_trigger( level.zone.gameobject.trigger );
        }
        
        return;
    }
    
    self bot_combat::update_threat_goal();
}

// Namespace bot_koth
// Params 0
// Checksum 0x4a08fd45, Offset: 0x310
// Size: 0xcc
function bot_idle()
{
    if ( isdefined( level.zone ) )
    {
        if ( self istouching( level.zone.gameobject.trigger ) )
        {
            self bot::path_to_point_in_trigger( level.zone.gameobject.trigger );
            return;
        }
        
        self bot::approach_goal_trigger( level.zone.gameobject.trigger );
        self bot::sprint_to_goal();
        return;
    }
    
    self bot::bot_idle();
}

