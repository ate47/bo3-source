#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace replay_gun;

// Namespace replay_gun
// Params 0, eflags: 0x2
// Checksum 0xe680f5db, Offset: 0x1d0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "replay_gun", &__init__, undefined, undefined );
}

// Namespace replay_gun
// Params 0
// Checksum 0x8ae866dd, Offset: 0x210
// Size: 0x24
function __init__()
{
    callback::on_spawned( &watch_for_replay_gun );
}

// Namespace replay_gun
// Params 0
// Checksum 0xdd7341a9, Offset: 0x240
// Size: 0xb0
function watch_for_replay_gun()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"spawned_player" );
    self endon( #"killreplaygunmonitor" );
    
    while ( true )
    {
        self waittill( #"weapon_change_complete", weapon );
        self weaponlockfree();
        
        if ( isdefined( weapon.usespivottargeting ) && weapon.usespivottargeting )
        {
            self thread watch_lockon( weapon );
        }
    }
}

// Namespace replay_gun
// Params 1
// Checksum 0x7b092f85, Offset: 0x2f8
// Size: 0xec
function watch_lockon( weapon )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"spawned_player" );
    self endon( #"weapon_change_complete" );
    
    while ( true )
    {
        wait 0.05;
        
        if ( !isdefined( self.lockonentity ) )
        {
            ads = self playerads() == 1;
            
            if ( ads )
            {
                target = self get_a_target( weapon );
                
                if ( is_valid_target( target ) )
                {
                    self weaponlockfree();
                    self.lockonentity = target;
                }
            }
        }
    }
}

// Namespace replay_gun
// Params 1
// Checksum 0x411a8683, Offset: 0x3f0
// Size: 0x2ea
function get_a_target( weapon )
{
    origin = self getweaponmuzzlepoint();
    forward = self getweaponforwarddir();
    targets = self get_potential_targets();
    
    if ( !isdefined( targets ) )
    {
        return undefined;
    }
    
    if ( !isdefined( weapon.lockonscreenradius ) || weapon.lockonscreenradius < 1 )
    {
        return undefined;
    }
    
    validtargets = [];
    should_wait = 0;
    
    for ( i = 0; i < targets.size ; i++ )
    {
        if ( should_wait )
        {
            wait 0.05;
            origin = self getweaponmuzzlepoint();
            forward = self getweaponforwarddir();
            should_wait = 0;
        }
        
        testtarget = targets[ i ];
        
        if ( !is_valid_target( testtarget ) )
        {
            continue;
        }
        
        testorigin = get_target_lock_on_origin( testtarget );
        test_range = distance( origin, testorigin );
        
        if ( test_range > weapon.lockonmaxrange || test_range < weapon.lockonminrange )
        {
            continue;
        }
        
        normal = vectornormalize( testorigin - origin );
        dot = vectordot( forward, normal );
        
        if ( 0 > dot )
        {
            continue;
        }
        
        if ( !self inside_screen_crosshair_radius( testorigin, weapon ) )
        {
            continue;
        }
        
        cansee = self can_see_projected_crosshair( testtarget, testorigin, origin, forward, test_range );
        should_wait = 1;
        
        if ( cansee )
        {
            validtargets[ validtargets.size ] = testtarget;
        }
    }
    
    return pick_a_target_from( validtargets );
}

// Namespace replay_gun
// Params 0
// Checksum 0xef543ee7, Offset: 0x6e8
// Size: 0xfe
function get_potential_targets()
{
    str_opposite_team = "axis";
    
    if ( self.team == "axis" )
    {
        str_opposite_team = "allies";
    }
    
    potentialtargets = [];
    aitargets = getaiteamarray( str_opposite_team );
    
    if ( aitargets.size > 0 )
    {
        potentialtargets = arraycombine( potentialtargets, aitargets, 1, 0 );
    }
    
    playertargets = self getenemies();
    
    if ( playertargets.size > 0 )
    {
        potentialtargets = arraycombine( potentialtargets, playertargets, 1, 0 );
    }
    
    if ( potentialtargets.size == 0 )
    {
        return undefined;
    }
    
    return potentialtargets;
}

// Namespace replay_gun
// Params 1
// Checksum 0x3e45cf2b, Offset: 0x7f0
// Size: 0x120
function pick_a_target_from( targets )
{
    if ( !isdefined( targets ) )
    {
        return undefined;
    }
    
    besttarget = undefined;
    besttargetdistancesquared = undefined;
    
    for ( i = 0; i < targets.size ; i++ )
    {
        target = targets[ i ];
        
        if ( is_valid_target( target ) )
        {
            targetdistancesquared = distancesquared( self.origin, target.origin );
            
            if ( !isdefined( besttarget ) || !isdefined( besttargetdistancesquared ) )
            {
                besttarget = target;
                besttargetdistancesquared = targetdistancesquared;
                continue;
            }
            
            if ( targetdistancesquared < besttargetdistancesquared )
            {
                besttarget = target;
                besttargetdistancesquared = targetdistancesquared;
            }
        }
    }
    
    return besttarget;
}

// Namespace replay_gun
// Params 2
// Checksum 0xde141c1c, Offset: 0x918
// Size: 0x3c
function trace( from, to )
{
    return bullettrace( from, to, 0, self )[ "position" ];
}

// Namespace replay_gun
// Params 5
// Checksum 0x99ebe69d, Offset: 0x960
// Size: 0xec, Type: bool
function can_see_projected_crosshair( target, target_origin, player_origin, player_forward, distance )
{
    crosshair = player_origin + player_forward * distance;
    collided = target trace( target_origin, crosshair );
    
    if ( distance2dsquared( crosshair, collided ) > 9 )
    {
        return false;
    }
    
    collided = self trace( player_origin, crosshair );
    
    if ( distance2dsquared( crosshair, collided ) > 9 )
    {
        return false;
    }
    
    return true;
}

// Namespace replay_gun
// Params 1
// Checksum 0xe3d519d4, Offset: 0xa58
// Size: 0x2a, Type: bool
function is_valid_target( ent )
{
    return isdefined( ent ) && isalive( ent );
}

// Namespace replay_gun
// Params 2
// Checksum 0x2857b355, Offset: 0xa90
// Size: 0x4a
function inside_screen_crosshair_radius( testorigin, weapon )
{
    radius = weapon.lockonscreenradius;
    return self inside_screen_radius( testorigin, radius );
}

// Namespace replay_gun
// Params 1
// Checksum 0xc419f5be, Offset: 0xae8
// Size: 0x4a
function inside_screen_lockon_radius( targetorigin )
{
    radius = self getlockonradius();
    return self inside_screen_radius( targetorigin, radius );
}

// Namespace replay_gun
// Params 2
// Checksum 0x3321cba0, Offset: 0xb40
// Size: 0x3a
function inside_screen_radius( targetorigin, radius )
{
    return target_originisincircle( targetorigin, self, 65, radius );
}

// Namespace replay_gun
// Params 1
// Checksum 0xda063c6e, Offset: 0xb88
// Size: 0x22
function get_target_lock_on_origin( target )
{
    return self getreplaygunlockonorigin( target );
}

