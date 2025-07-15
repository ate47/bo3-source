#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace ai_sniper;

// Namespace ai_sniper
// Params 0, eflags: 0x2
// Checksum 0x50402727, Offset: 0x200
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "ai_sniper", &__init__, undefined, undefined );
}

// Namespace ai_sniper
// Params 0
// Checksum 0x67be2c58, Offset: 0x240
// Size: 0x14
function __init__()
{
    thread init_node_scan();
}

// Namespace ai_sniper
// Params 1
// Checksum 0x53df918a, Offset: 0x260
// Size: 0x326
function init_node_scan( targetname )
{
    wait 0.05;
    
    if ( !isdefined( targetname ) )
    {
        targetname = "ai_sniper_node_scan";
    }
    
    structlist = struct::get_array( targetname, "targetname" );
    pointlist = getentarray( targetname, "targetname" );
    
    foreach ( struct in structlist )
    {
        pointlist[ pointlist.size ] = struct;
    }
    
    foreach ( point in pointlist )
    {
        if ( isdefined( point.target ) )
        {
            node = getnode( point.target, "targetname" );
            
            if ( isdefined( node ) )
            {
                if ( !isdefined( node.lase_points ) )
                {
                    node.lase_points = [];
                }
                
                node.lase_points[ node.lase_points.size ] = point;
            }
        }
    }
    
    nodelist = getnodearray( targetname, "script_noteworthy" );
    
    foreach ( node in nodelist )
    {
        if ( isdefined( node.script_linkto ) )
        {
            node.var_57357d16 = struct::get( node.script_linkto, "script_linkname" );
            
            if ( !isdefined( node.var_57357d16 ) )
            {
                node.var_57357d16 = getent( node.script_linkto, "script_linkname" );
            }
        }
    }
}

// Namespace ai_sniper
// Params 0
// Checksum 0x743cd9d4, Offset: 0x590
// Size: 0x4c
function agent_init()
{
    self thread patrol_lase_goal_waiter();
    self thread function_6a517a0a();
    self thread function_6fb6a6d3();
}

// Namespace ai_sniper
// Params 1
// Checksum 0xf237f61e, Offset: 0x5e8
// Size: 0x132
function function_b61dfa9e( node )
{
    if ( !isdefined( node ) )
    {
        return;
    }
    
    if ( !isdefined( node.lase_points ) && !isdefined( node.var_57357d16 ) )
    {
        return;
    }
    
    self notify( #"hash_b61dfa9e" );
    self endon( #"hash_b61dfa9e" );
    self endon( #"death" );
    self endon( #"lase_points" );
    
    if ( isdefined( self.patroller ) && self.patroller )
    {
        self ai::end_and_clean_patrol_behaviors();
    }
    
    goalpos = node.origin;
    
    if ( isdefined( self.pathgoalpos ) )
    {
        goalpos = self.pathgoalpos;
    }
    
    if ( isdefined( self.arrivalfinalpos ) )
    {
        goalpos = self.arrivalfinalpos;
    }
    
    while ( distancesquared( self.origin, goalpos ) > 256 )
    {
        wait 0.05;
    }
    
    self notify( #"hash_50b88a46", node );
}

// Namespace ai_sniper
// Params 0
// Checksum 0xd1ca157, Offset: 0x728
// Size: 0x68
function function_6a517a0a()
{
    self notify( #"hash_6a517a0a" );
    self endon( #"hash_6a517a0a" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"patrol_goal", node );
        self function_b61dfa9e( node );
    }
}

// Namespace ai_sniper
// Params 0
// Checksum 0xa4f4b854, Offset: 0x798
// Size: 0xb4
function function_6fb6a6d3()
{
    self notify( #"hash_6fb6a6d3" );
    self endon( #"hash_6fb6a6d3" );
    self endon( #"death" );
    
    if ( isdefined( self.target ) && !( isdefined( self.patroller ) && self.patroller ) )
    {
        node = getnode( self.target, "targetname" );
        
        if ( isdefined( node ) )
        {
            self waittill( #"goal" );
            self function_b61dfa9e( node );
        }
    }
}

// Namespace ai_sniper
// Params 0
// Checksum 0xeb961440, Offset: 0x858
// Size: 0x278
function patrol_lase_goal_waiter()
{
    self notify( #"patrol_lase_goal_waiter" );
    self endon( #"patrol_lase_goal_waiter" );
    self endon( #"death" );
    
    while ( true )
    {
        was_stealth = 0;
        self waittill( #"hash_50b88a46", node );
        
        if ( isdefined( node.var_57357d16 ) )
        {
            self thread actor_lase_points_behavior( node.var_57357d16 );
        }
        else
        {
            self thread actor_lase_points_behavior( node.lase_points );
        }
        
        if ( self ai::has_behavior_attribute( "stealth" ) )
        {
            was_stealth = self ai::get_behavior_attribute( "stealth" );
            self ai::set_behavior_attribute( "stealth", 0 );
        }
        
        if ( isdefined( self.currentgoal ) && isdefined( self.currentgoal.target ) && self.currentgoal.target != "" )
        {
            self setgoal( node, 1 );
            self waittill( #"lase_points_loop" );
            self notify( #"lase_points" );
            self laseroff();
            self.holdfire = 0;
            self ai::stop_shoot_at_target();
            
            if ( isdefined( self.var_d1ddf246 ) )
            {
                self.goalradius = self.var_d1ddf246;
                self.var_d1ddf246 = undefined;
            }
            
            if ( isdefined( self.currentgoal ) )
            {
                self thread ai::patrol( self.currentgoal );
            }
            
            if ( was_stealth && self ai::has_behavior_attribute( "stealth" ) )
            {
                self ai::set_behavior_attribute( "stealth", self.awarenesslevelcurrent != "combat" );
            }
            
            continue;
        }
        
        break;
    }
}

// Namespace ai_sniper
// Params 1
// Checksum 0x1616368e, Offset: 0xad8
// Size: 0x314
function actor_lase_points_behavior( entity_or_point_array )
{
    self notify( #"lase_points" );
    self endon( #"lase_points" );
    self endon( #"death" );
    self.holdfire = 1;
    self.blindaim = 1;
    
    if ( !isdefined( self.var_d1ddf246 ) )
    {
        self.var_d1ddf246 = self.goalradius;
    }
    
    self.goalradius = 8;
    
    if ( isdefined( self.__blackboard ) && isdefined( self.script_parameters ) && self.script_parameters == "steady" )
    {
        blackboard::setblackboardattribute( self, "_context", "steady" );
    }
    
    if ( !isdefined( entity_or_point_array ) && isdefined( self.target ) )
    {
        entity_or_point_array = struct::get( self.target, "targetname" );
    }
    
    if ( isarray( entity_or_point_array ) && ( !isdefined( entity_or_point_array ) || entity_or_point_array.size == 0 ) )
    {
        /#
            iprintlnbold( "<dev string:x28>" );
        #/
        
        return;
    }
    
    firstpoint = undefined;
    
    if ( isarray( entity_or_point_array ) )
    {
        firstpoint = entity_or_point_array[ 0 ];
    }
    else
    {
        firstpoint = entity_or_point_array;
    }
    
    if ( !isdefined( self.lase_ent ) )
    {
        self.lase_ent = spawn( "script_model", lase_point( firstpoint ) );
        self.lase_ent setmodel( "tag_origin" );
        self.lase_ent.velocity = ( 100, 0, 0 );
        self thread util::delete_on_death( self.lase_ent );
    }
    
    if ( self.lase_ent.health <= 0 )
    {
        self.lase_ent.health = 1;
    }
    
    self thread ai::shoot_at_target( "shoot_until_target_dead", self.lase_ent );
    self.lase_ent thread target_lase_points( entity_or_point_array, self );
    self.lase_ent thread target_lase_points_ally_track( self geteye(), entity_or_point_array, self );
    self thread actor_lase_force_laser_on();
    self thread function_659cb4db();
}

// Namespace ai_sniper
// Params 0
// Checksum 0x8c398bdc, Offset: 0xdf8
// Size: 0xcc
function actor_lase_stop()
{
    if ( !isdefined( self.lase_ent ) )
    {
        return;
    }
    
    self notify( #"lase_points" );
    self.holdfire = 0;
    self.blindaim = 0;
    self.lase_ent delete();
    self.lase_ent = undefined;
    self clearentitytarget();
    
    if ( isdefined( self.var_d1ddf246 ) )
    {
        self.goalradius = self.var_d1ddf246;
        self.var_d1ddf246 = undefined;
    }
    
    self laseroff();
    
    if ( isdefined( self.__blackboard ) )
    {
        blackboard::setblackboardattribute( self, "_context", undefined );
    }
}

/#

    // Namespace ai_sniper
    // Params 0
    // Checksum 0xefe5b9a2, Offset: 0xed0
    // Size: 0x94, Type: dev
    function debug_position()
    {
        self endon( #"death" );
        lastpos = self.origin;
        
        while ( true )
        {
            debugstar( self.origin, 1, ( 1, 0, 0 ) );
            line( self.origin, lastpos, ( 1, 0, 0 ), 1, 0, 20 );
            lastpos = self.origin;
            wait 0.05;
        }
    }

#/

// Namespace ai_sniper
// Params 0
// Checksum 0x5f7f7ce3, Offset: 0xf70
// Size: 0x98
function actor_lase_force_laser_on()
{
    self endon( #"death" );
    self endon( #"lase_points" );
    var_bef987c0 = gettime();
    
    while ( true )
    {
        if ( self asmistransdecrunning() )
        {
            var_bef987c0 = gettime();
            self laseroff();
        }
        else if ( gettime() - var_bef987c0 > 350 )
        {
            self laseron();
        }
        
        wait 0.05;
    }
}

// Namespace ai_sniper
// Params 0
// Checksum 0x8cf905bd, Offset: 0x1010
// Size: 0x3c
function function_659cb4db()
{
    self endon( #"lase_points" );
    self waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        self laseroff();
    }
}

// Namespace ai_sniper
// Params 1
// Checksum 0x7ce28a9e, Offset: 0x1058
// Size: 0xbc
function lase_point( entity_or_point )
{
    if ( !isdefined( entity_or_point ) )
    {
        return ( 0, 0, 0 );
    }
    
    result = entity_or_point;
    
    if ( !isvec( entity_or_point ) && isdefined( entity_or_point.origin ) )
    {
        result = entity_or_point.origin;
        
        if ( isplayer( entity_or_point ) || isactor( entity_or_point ) )
        {
            result = entity_or_point geteye();
        }
    }
    
    return result;
}

// Namespace ai_sniper
// Params 3
// Checksum 0xc892cf85, Offset: 0x1120
// Size: 0x3c8
function target_lase_points_ally_track( v_eye, entity_or_point_array, a_owner )
{
    self notify( #"actor_lase_points_player_track" );
    self endon( #"actor_lase_points_player_track" );
    self endon( #"death" );
    
    if ( !isdefined( level.var_b8032721 ) )
    {
        level.var_b8032721 = [];
    }
    
    if ( !isdefined( level.var_2b420add ) )
    {
        level.var_2b420add = 0;
    }
    
    while ( true )
    {
        var_6121992f = vectornormalize( self.origin - v_eye );
        
        if ( gettime() > level.var_2b420add )
        {
            level.var_b8032721 = getplayers();
            actorlist = getaiteamarray( "allies" );
            
            foreach ( actor in actorlist )
            {
                if ( isdefined( actor.ignoreme ) && actor.ignoreme )
                {
                    continue;
                }
                
                if ( isalive( actor ) )
                {
                    level.var_b8032721[ level.var_b8032721.size ] = actor;
                }
            }
            
            level.var_2b420add = gettime() + 1000;
        }
        
        for ( i = 0; i < level.var_b8032721.size ; i++ )
        {
            ally = level.var_b8032721[ i ];
            
            if ( !isalive( ally ) )
            {
                continue;
            }
            
            if ( isdefined( ally.ignoreme ) && ( ally isnotarget() || ally.ignoreme ) )
            {
                continue;
            }
            
            var_633cfa62 = lase_point( ally );
            var_c4827684 = vectornormalize( var_633cfa62 - v_eye );
            
            if ( vectordot( var_6121992f, var_c4827684 ) < 0.7 )
            {
                continue;
            }
            
            var_6a3f5d89 = pointonsegmentnearesttopoint( v_eye, self.origin, var_633cfa62 );
            
            if ( distancesquared( var_633cfa62, var_6a3f5d89 ) < 40000 )
            {
                if ( sighttracepassed( v_eye, var_633cfa62, 0, undefined ) )
                {
                    if ( isdefined( a_owner ) )
                    {
                        a_owner notify( #"alert", "combat", var_633cfa62, ally );
                    }
                    
                    self function_b77b41d1( v_eye, ally, a_owner );
                    break;
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace ai_sniper
// Params 4
// Checksum 0x482cb195, Offset: 0x14f0
// Size: 0xac
function function_b77b41d1( v_eye, entity_or_point, a_owner, var_12065f0b )
{
    if ( !isdefined( var_12065f0b ) )
    {
        var_12065f0b = 1;
    }
    
    sight_timeout = 7;
    
    if ( isdefined( self.a_owner ) && isdefined( self.a_owner.var_815502c4 ) )
    {
        sight_timeout = self.a_owner.var_815502c4;
    }
    
    self target_lase_override( v_eye, entity_or_point, sight_timeout, a_owner, 1, var_12065f0b );
}

// Namespace ai_sniper
// Params 2
// Checksum 0xe9674f73, Offset: 0x15a8
// Size: 0x288
function target_lase_points( entity_or_point_array, e_owner )
{
    self notify( #"lase_points" );
    self endon( #"lase_points" );
    self endon( #"death" );
    pausetime = randomfloatrange( 2, 4 );
    
    if ( isarray( entity_or_point_array ) && entity_or_point_array.size <= 0 )
    {
        return;
    }
    
    index = 0;
    start = entity_or_point_array;
    
    while ( true )
    {
        while ( isdefined( self.lase_override ) )
        {
            wait 0.05;
            continue;
        }
        
        if ( isarray( entity_or_point_array ) )
        {
            self target_lase_transition( entity_or_point_array[ index ], e_owner );
            
            if ( !isvec( entity_or_point_array[ index ] ) && isdefined( entity_or_point_array[ index ].script_wait ) )
            {
                wait entity_or_point_array[ index ].script_wait;
            }
        }
        else
        {
            entity_or_point_array = target_lase_next( entity_or_point_array );
            self target_lase_transition( entity_or_point_array, e_owner );
            
            if ( !isvec( entity_or_point_array ) && isdefined( entity_or_point_array.script_wait ) )
            {
                wait entity_or_point_array.script_wait;
            }
        }
        
        looped = 0;
        
        if ( isarray( entity_or_point_array ) )
        {
            index += 1;
            
            if ( index >= entity_or_point_array.size )
            {
                index = 0;
                looped = 1;
            }
        }
        else if ( entity_or_point_array == start )
        {
            looped = 1;
        }
        
        if ( looped )
        {
            self notify( #"lase_points_loop" );
            
            if ( isdefined( e_owner ) )
            {
                e_owner notify( #"lase_points_loop" );
            }
        }
    }
}

// Namespace ai_sniper
// Params 3
// Checksum 0x72002cc2, Offset: 0x1838
// Size: 0x3bc
function function_9c1ac1cb( endposition, totaltime, var_5d61a864 )
{
    self notify( #"hash_9c1ac1cb" );
    self endon( #"hash_9c1ac1cb" );
    self endon( #"death" );
    startposition = self.origin;
    startvelocity = self.velocity;
    var_c8240fdb = vectornormalize( self.velocity );
    var_ed017668 = totaltime * 4;
    phase = length( self.velocity ) / var_ed017668 * 2;
    starttime = gettime();
    totaltimems = totaltime * 1000;
    var_1632b53d = totaltimems * 0.75;
    notified = 0;
    var_3d372c1a = 65000;
    
    if ( !isdefined( var_5d61a864 ) || var_5d61a864 )
    {
        self endon( #"hash_9744842a" );
    }
    
    while ( gettime() - starttime < totaltimems )
    {
        if ( !notified && gettime() - starttime > var_1632b53d )
        {
            self notify( #"hash_9744842a" );
            notified = 1;
        }
        
        deltatime = float( gettime() - starttime ) / 1000;
        var_67fe8eb1 = min( deltatime, var_ed017668 );
        var_e42cf565 = startposition + startvelocity * var_67fe8eb1;
        var_7a592a87 = var_e42cf565 + var_c8240fdb * phase * -0.5 * var_67fe8eb1 * var_67fe8eb1;
        coef = deltatime / totaltime;
        coef = 1 - 0.5 + cos( coef * 180 ) * 0.5;
        var_515ca7cf = endposition;
        assert( isdefined( var_515ca7cf ) );
        neworigin = vectorlerp( var_7a592a87, var_515ca7cf, coef );
        self.velocity = ( neworigin - self.origin ) / 0.05;
        
        if ( neworigin[ 0 ] > var_3d372c1a * -1 && neworigin[ 0 ] < var_3d372c1a && neworigin[ 1 ] > var_3d372c1a * -1 && neworigin[ 1 ] < var_3d372c1a && neworigin[ 2 ] > var_3d372c1a * -1 && neworigin[ 2 ] < var_3d372c1a )
        {
            self.origin = neworigin;
        }
        
        wait 0.05;
    }
}

// Namespace ai_sniper
// Params 1
// Checksum 0x7fdda166, Offset: 0x1c00
// Size: 0x180
function target_lase_next( node )
{
    if ( !isdefined( node ) )
    {
        return undefined;
    }
    
    nexta = undefined;
    nextb = undefined;
    
    if ( isdefined( node.target ) && isdefined( node.script_linkto ) )
    {
        nexta = struct::get( node.target, "targetname" );
        nextb = struct::get( node.script_linkto, "script_linkname" );
    }
    else if ( isdefined( node.target ) )
    {
        nexta = struct::get( node.target, "targetname" );
    }
    else if ( isdefined( node.script_linkto ) )
    {
        nexta = struct::get( node.script_linkto, "script_linkname" );
    }
    
    if ( isdefined( nexta ) && isdefined( nextb ) )
    {
        if ( randomfloatrange( 0, 1 ) < 0.5 )
        {
            return nexta;
        }
        
        return nextb;
    }
    
    return nexta;
}

// Namespace ai_sniper
// Params 2
// Checksum 0x64b88b7e, Offset: 0x1d88
// Size: 0x1d8
function target_lase_transition( entity_or_point, owner )
{
    self notify( #"target_lase_transition" );
    self endon( #"target_lase_transition" );
    self endon( #"death" );
    
    if ( isentity( entity_or_point ) )
    {
        entity_or_point endon( #"death" );
        
        while ( true )
        {
            point = lase_point( entity_or_point );
            delta = point - self.origin;
            delta *= 0.2;
            self.origin += delta;
            wait 0.05;
        }
        
        return;
    }
    
    speed = 200;
    point = lase_point( entity_or_point );
    time = distance( point, self.origin ) / speed;
    var_779fd53f = 0;
    
    if ( isdefined( owner ) && isdefined( owner.var_26c21ea3 ) )
    {
        var_779fd53f = 1;
        time = min( time, owner.var_26c21ea3 );
    }
    
    if ( time > 0 )
    {
        self thread function_9c1ac1cb( point, time, var_779fd53f );
        self waittill( #"hash_9744842a" );
    }
}

// Namespace ai_sniper
// Params 6
// Checksum 0x602aa1c0, Offset: 0x1f68
// Size: 0x272
function target_lase_override( v_eye, entity_or_point, sight_timeout, a_owner, fire_weapon, var_12065f0b )
{
    if ( !isdefined( var_12065f0b ) )
    {
        var_12065f0b = 1;
    }
    
    if ( !var_12065f0b || isdefined( self.lase_override ) && self.lase_override == entity_or_point )
    {
        return;
    }
    
    self notify( #"target_lase_override" );
    self endon( #"target_lase_override" );
    self endon( #"death" );
    self.lase_override = entity_or_point;
    self thread target_lase_transition( entity_or_point, a_owner );
    outofsighttime = 0;
    var_4bbe1b92 = 0;
    var_94a708a2 = 0;
    
    if ( isdefined( a_owner.var_dfa3c2cb ) )
    {
        var_94a708a2 = a_owner.var_dfa3c2cb;
    }
    
    if ( !isdefined( fire_weapon ) )
    {
        fire_weapon = 1;
    }
    
    while ( true )
    {
        if ( var_4bbe1b92 >= var_94a708a2 )
        {
            if ( isactor( a_owner ) )
            {
                a_owner.holdfire = !fire_weapon;
                
                if ( fire_weapon )
                {
                    a_owner.var_8c2ddc6 = gettime();
                }
            }
        }
        
        if ( !isdefined( entity_or_point ) || outofsighttime >= sight_timeout )
        {
            self notify( #"target_lase_transition" );
            break;
        }
        
        if ( !sighttracepassed( v_eye, lase_point( entity_or_point ), 0, undefined ) )
        {
            outofsighttime += 0.05;
        }
        else
        {
            outofsighttime = 0;
        }
        
        var_4bbe1b92 += 0.05;
        wait 0.05;
    }
    
    if ( isactor( a_owner ) )
    {
        a_owner.holdfire = 1;
    }
    
    self.lase_override = undefined;
}

// Namespace ai_sniper
// Params 1
// Checksum 0xd61442d7, Offset: 0x21e8
// Size: 0x46, Type: bool
function is_firing( a_owner )
{
    if ( !isdefined( a_owner ) )
    {
        return false;
    }
    
    if ( !isdefined( a_owner.var_8c2ddc6 ) )
    {
        return false;
    }
    
    return gettime() - a_owner.var_8c2ddc6 < 3000;
}

