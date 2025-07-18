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

#namespace bot_ball;

// Namespace bot_ball
// Params 0
// Checksum 0xd96c8b0b, Offset: 0x208
// Size: 0x4c
function init()
{
    level.botidle = &bot_idle;
    level.botcombat = &bot_combat;
    level.botprecombat = &bot_pre_combat;
}

// Namespace bot_ball
// Params 0
// Checksum 0xda2bf4d, Offset: 0x260
// Size: 0x7c
function release_control_on_landing()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( self isonground() )
    {
        wait 0.05;
    }
    
    while ( !self isonground() )
    {
        wait 0.05;
    }
    
    self botreleasemanualcontrol();
}

// Namespace bot_ball
// Params 0
// Checksum 0x1ca59796, Offset: 0x2e8
// Size: 0x18c
function bot_pre_combat()
{
    if ( isdefined( self.carryobject ) )
    {
        if ( self isonground() && self botgoalset() )
        {
            goal = level.ball_goals[ util::getotherteam( self.team ) ];
            radius = 300;
            radiussq = radius * radius;
            
            if ( distance2dsquared( self.origin, goal.trigger.origin ) <= radiussq )
            {
                if ( self botsighttrace( goal.trigger ) )
                {
                    self bottakemanualcontrol();
                    self thread bot::jump_to( goal.trigger.origin );
                    self thread release_control_on_landing();
                    return;
                }
            }
        }
        
        if ( !self ismeleeing() )
        {
            self bot::use_killstreak();
        }
        
        return;
    }
    
    self bot_combat::mp_pre_combat();
}

// Namespace bot_ball
// Params 0
// Checksum 0xe169ed02, Offset: 0x480
// Size: 0x15c
function bot_combat()
{
    if ( isdefined( self.carryobject ) )
    {
        if ( self bot_combat::has_threat() )
        {
            self bot_combat::clear_threat();
        }
        
        meleethreat = bot_combat::get_greatest_threat( level.botsettings.meleerange );
        
        if ( isdefined( meleethreat ) )
        {
            angles = self getplayerangles();
            fwd = anglestoforward( angles );
            threatdir = meleethreat.origin - self.origin;
            threatdir = vectornormalize( threatdir );
            dot = vectordot( fwd, threatdir );
            
            if ( dot > level.botsettings.meleedot )
            {
                self bot::tap_melee_button();
            }
        }
        
        return;
    }
    
    self bot_combat::combat_think();
}

// Namespace bot_ball
// Params 0
// Checksum 0x1a9ac30f, Offset: 0x5e8
// Size: 0x29c
function bot_idle()
{
    if ( isdefined( self.carryobject ) )
    {
        if ( !self botgoalset() )
        {
            goal = level.ball_goals[ util::getotherteam( self.team ) ];
            goalpoint = goal.origin - ( 0, 0, 125 );
            self bot::approach_point( goalpoint );
            self bot::sprint_to_goal();
        }
        
        return;
    }
    
    triggers = [];
    balls = array::randomize( level.balls );
    
    foreach ( ball in balls )
    {
        if ( !isdefined( ball.carrier ) && !ball.in_goal )
        {
            triggers[ triggers.size ] = ball.trigger;
            continue;
        }
        
        if ( isdefined( ball.carrier ) && ball.carrier.team != self.team )
        {
            self bot::approach_point( ball.carrier.origin, 250, 1000, 128 );
            self bot::sprint_to_goal();
            return;
        }
    }
    
    if ( triggers.size > 0 )
    {
        triggers = arraysort( triggers, self.origin );
        self botsetgoal( triggers[ 0 ].origin );
        self bot::sprint_to_goal();
        return;
    }
    
    self bot::bot_idle();
}

