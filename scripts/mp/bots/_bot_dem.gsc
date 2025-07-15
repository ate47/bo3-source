#using scripts/mp/bots/_bot;
#using scripts/mp/bots/_bot_combat;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/bot_buttons;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace bot_dem;

// Namespace bot_dem
// Params 0
// Checksum 0x29839e8e, Offset: 0x190
// Size: 0x4c
function init()
{
    level.botidle = &bot_idle;
    level.botcombat = &combat_think;
    level.botthreatlost = &function_211bcdc;
}

// Namespace bot_dem
// Params 0
// Checksum 0xdbd5f61f, Offset: 0x1e8
// Size: 0x46c
function bot_idle()
{
    approachradiussq = 562500;
    
    foreach ( zone in level.bombzones )
    {
        if ( isdefined( zone.bombexploded ) && zone.bombexploded )
        {
            continue;
        }
        
        if ( self istouching( zone.trigger ) )
        {
            if ( self can_plant( zone ) || self can_defuse( zone ) )
            {
                self bot::press_use_button();
                return;
            }
        }
        
        if ( distancesquared( self.origin, zone.trigger.origin ) < approachradiussq )
        {
            if ( self can_plant( zone ) || self can_defuse( zone ) )
            {
                self bot::path_to_trigger( zone.trigger );
                self bot::sprint_to_goal();
                return;
            }
        }
    }
    
    zones = array::randomize( level.bombzones );
    
    foreach ( zone in zones )
    {
        if ( isdefined( zone.bombexploded ) && zone.bombexploded )
        {
            continue;
        }
        
        if ( self can_defuse( zone ) && randomint( 100 ) < 70 )
        {
            self bot::approach_goal_trigger( zone.trigger, 750 );
            self bot::sprint_to_goal();
            return;
        }
    }
    
    foreach ( zone in zones )
    {
        if ( isdefined( zone.bombexploded ) && zone.bombexploded )
        {
            continue;
        }
        
        if ( distancesquared( self.origin, zone.trigger.origin ) < approachradiussq && randomint( 100 ) < 70 )
        {
            triggerradius = self bot::get_trigger_radius( zone.trigger );
            self bot::approach_point( zone.trigger.origin, triggerradius, 750 );
            self bot::sprint_to_goal();
            return;
        }
    }
    
    self bot::bot_idle();
}

// Namespace bot_dem
// Params 1
// Checksum 0x3e95b6fb, Offset: 0x660
// Size: 0x54, Type: bool
function can_plant( zone )
{
    return !( isdefined( zone.bombplanted ) && zone.bombplanted ) && self.team != zone gameobjects::get_owner_team();
}

// Namespace bot_dem
// Params 1
// Checksum 0x8cb6cdca, Offset: 0x6c0
// Size: 0x54, Type: bool
function can_defuse( zone )
{
    return isdefined( zone.bombplanted ) && zone.bombplanted && self.team == zone gameobjects::get_owner_team();
}

// Namespace bot_dem
// Params 0
// Checksum 0x18c6cae4, Offset: 0x720
// Size: 0x4c
function combat_think()
{
    if ( isdefined( self.isdefusing ) && ( isdefined( self.isplanting ) && self.isplanting || self.isdefusing ) )
    {
        return;
    }
    
    self bot_combat::combat_think();
}

// Namespace bot_dem
// Params 0
// Checksum 0x309587f4, Offset: 0x778
// Size: 0x134
function function_211bcdc()
{
    approachradiussq = 562500;
    
    foreach ( zone in level.bombzones )
    {
        if ( isdefined( zone.bombexploded ) && zone.bombexploded )
        {
            continue;
        }
        
        if ( distancesquared( self.origin, zone.trigger.origin ) < approachradiussq )
        {
            if ( self can_plant( zone ) || self can_defuse( zone ) )
            {
                return;
            }
        }
    }
    
    self bot_combat::chase_threat();
}

