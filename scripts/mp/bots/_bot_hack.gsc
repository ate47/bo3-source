#namespace bot_hack;

// Namespace bot_hack
// Params 1
// Checksum 0x5ccfd285, Offset: 0xa8
// Size: 0x14c
function hack_tank_get_goal_origin( tank )
{
    nodes = getnodesinradiussorted( tank.origin, 256, 0, 64, "Path" );
    
    foreach ( node in nodes )
    {
        dir = vectornormalize( node.origin - tank.origin );
        dir = vectorscale( dir, 32 );
        goal = tank.origin + dir;
        
        if ( self findpath( self.origin, goal, 0 ) )
        {
            return goal;
        }
    }
    
    return undefined;
}

// Namespace bot_hack
// Params 1
// Checksum 0x809c8489, Offset: 0x200
// Size: 0x74, Type: bool
function hack_has_goal( tank )
{
    goal = self getgoal( "hack" );
    
    if ( isdefined( goal ) )
    {
        if ( distancesquared( goal, tank.origin ) < 16384 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bot_hack
// Params 0
// Checksum 0xa8f4a3b2, Offset: 0x280
// Size: 0x18c, Type: bool
function hack_at_goal()
{
    if ( self atgoal( "hack" ) )
    {
        return true;
    }
    
    goal = self getgoal( "hack" );
    
    if ( isdefined( goal ) )
    {
        tanks = getentarray( "talon", "targetname" );
        tanks = arraysort( tanks, self.origin );
        
        foreach ( tank in tanks )
        {
            if ( distancesquared( goal, tank.origin ) < 16384 )
            {
                if ( isdefined( tank.trigger ) && self istouching( tank.trigger ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace bot_hack
// Params 1
// Checksum 0x415abcf7, Offset: 0x418
// Size: 0x134
function hack_goal_pregame( tanks )
{
    foreach ( tank in tanks )
    {
        if ( isdefined( tank.owner ) )
        {
            continue;
        }
        
        if ( isdefined( tank.team ) && tank.team == self.team )
        {
            continue;
        }
        
        goal = self hack_tank_get_goal_origin( tank );
        
        if ( isdefined( goal ) )
        {
            if ( self addgoal( goal, 24, 2, "hack" ) )
            {
                self.goal_flag = tank;
                return;
            }
        }
    }
}

// Namespace bot_hack
// Params 0
// Checksum 0x2c18baf5, Offset: 0x558
// Size: 0x45c
function hack_think()
{
    if ( hack_at_goal() )
    {
        self setstance( "crouch" );
        wait 0.25;
        self addgoal( self.origin, 24, 4, "hack" );
        self pressusebutton( level.drone_hack_time + 1 );
        wait level.drone_hack_time + 1;
        self setstance( "stand" );
        self cancelgoal( "hack" );
    }
    
    tanks = getentarray( "talon", "targetname" );
    tanks = arraysort( tanks, self.origin );
    
    if ( !( isdefined( level.drones_spawned ) && level.drones_spawned ) )
    {
        self hack_goal_pregame( tanks );
        return;
    }
    
    foreach ( tank in tanks )
    {
        if ( isdefined( tank.owner ) && tank.owner == self )
        {
            continue;
        }
        
        if ( !isdefined( tank.owner ) )
        {
            if ( self hack_has_goal( tank ) )
            {
                return;
            }
            
            goal = self hack_tank_get_goal_origin( tank );
            
            if ( isdefined( goal ) )
            {
                self addgoal( goal, 24, 2, "hack" );
                return;
            }
        }
        
        if ( tank.isstunned && distancesquared( self.origin, tank.origin ) < 262144 )
        {
            goal = self hack_tank_get_goal_origin( tank );
            
            if ( isdefined( goal ) )
            {
                self addgoal( goal, 24, 3, "hack" );
                return;
            }
        }
    }
    
    foreach ( tank in tanks )
    {
        if ( isdefined( tank.owner ) && tank.owner == self )
        {
            continue;
        }
        
        if ( tank.isstunned )
        {
            continue;
        }
        
        if ( self throwgrenade( getweapon( "emp_grenade" ), tank.origin ) )
        {
            self waittill( #"grenade_fire" );
            goal = self hack_tank_get_goal_origin( tank );
            
            if ( isdefined( goal ) )
            {
                self addgoal( goal, 24, 3, "hack" );
                wait 0.5;
                return;
            }
        }
    }
}

