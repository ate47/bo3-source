#using scripts/codescripts/struct;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;

#namespace dragon;

// Namespace dragon
// Params 0, eflags: 0x2
// Checksum 0x95a02dce, Offset: 0x330
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "dragon", &__init__, undefined, undefined );
}

// Namespace dragon
// Params 0
// Checksum 0x19735ddb, Offset: 0x370
// Size: 0x2c
function __init__()
{
    vehicle::add_main_callback( "dragon", &dragon_initialize );
}

// Namespace dragon
// Params 0
// Checksum 0x6e1fc824, Offset: 0x3a8
// Size: 0x23c
function dragon_initialize()
{
    self useanimtree( $generic );
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    
    if ( isdefined( self.scriptbundlesettings ) )
    {
        self.settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    }
    
    assert( isdefined( self.settings ) );
    self setneargoalnotifydist( self.radius * 1.5 );
    self sethoverparams( self.radius, self.settings.defaultmovespeed * 2, self.radius );
    self setspeed( self.settings.defaultmovespeed );
    blackboard::createblackboardforentity( self );
    self blackboard::registervehicleblackboardattributes();
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.vehaircraftcollisionenabled = 0;
    self.goalradius = 9999999;
    self.goalheight = 512;
    self setgoal( self.origin, 0, self.goalradius, self.goalheight );
    self.delete_on_death = 1;
    self.overridevehicledamage = &dragon_callback_damage;
    self.allowfriendlyfiredamageoverride = &dragon_allowfriendlyfiredamage;
    self.ignoreme = 1;
    
    if ( isdefined( level.vehicle_initializer_cb ) )
    {
        [[ level.vehicle_initializer_cb ]]( self );
    }
    
    defaultrole();
}

// Namespace dragon
// Params 0
// Checksum 0xb07a22bd, Offset: 0x5f0
// Size: 0x178
function defaultrole()
{
    self vehicle_ai::init_state_machine_for_role( "default" );
    self vehicle_ai::get_state_callbacks( "combat" ).update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks( "death" ).update_func = &state_death_update;
    
    if ( sessionmodeiszombiesgame() )
    {
        self vehicle_ai::add_state( "power_up", undefined, &state_power_up_update, undefined );
        self vehicle_ai::add_utility_connection( "combat", "power_up", &should_go_for_power_up );
        self vehicle_ai::add_utility_connection( "power_up", "combat" );
    }
    
    /#
        setdvar( "<dev string:x28>", 0 );
    #/
    
    self thread dragon_target_selection();
    vehicle_ai::startinitialstate( "combat" );
    self.starttime = gettime();
}

// Namespace dragon
// Params 1, eflags: 0x4
// Checksum 0x301a319a, Offset: 0x770
// Size: 0x1be, Type: bool
function private is_enemy_valid( target )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( isdefined( self.intermission ) && self.intermission )
    {
        return false;
    }
    
    if ( isdefined( target.ignoreme ) && target.ignoreme )
    {
        return false;
    }
    
    if ( target isnotarget() )
    {
        return false;
    }
    
    if ( isdefined( target._dragon_ignoreme ) && target._dragon_ignoreme )
    {
        return false;
    }
    
    if ( distancesquared( self.owner.origin, target.origin ) > self.settings.guardradius * self.settings.guardradius )
    {
        return false;
    }
    
    if ( self vehcansee( target ) )
    {
        return true;
    }
    
    if ( isactor( target ) && target cansee( self.owner ) )
    {
        return true;
    }
    
    if ( isvehicle( target ) && target vehcansee( self.owner ) )
    {
        return true;
    }
    
    return false;
}

// Namespace dragon
// Params 0, eflags: 0x4
// Checksum 0xc3db2b33, Offset: 0x938
// Size: 0x29c
function private get_dragon_enemy()
{
    dragon_enemies = getaiteamarray( "axis" );
    distsqr = 10000 * 10000;
    best_enemy = undefined;
    
    foreach ( enemy in dragon_enemies )
    {
        newdistsqr = distance2dsquared( enemy.origin, self.owner.origin );
        
        if ( is_enemy_valid( enemy ) )
        {
            if ( enemy.archetype === "raz" )
            {
                newdistsqr = max( distance2d( enemy.origin, self.owner.origin ) - 700, 0 );
                newdistsqr *= newdistsqr;
            }
            else if ( enemy.archetype === "sentinel_drone" )
            {
                newdistsqr = max( distance2d( enemy.origin, self.owner.origin ) - 500, 0 );
                newdistsqr *= newdistsqr;
            }
            else if ( enemy === self.dragonenemy )
            {
                newdistsqr = max( distance2d( enemy.origin, self.owner.origin ) - 300, 0 );
                newdistsqr *= newdistsqr;
            }
            
            if ( newdistsqr < distsqr )
            {
                distsqr = newdistsqr;
                best_enemy = enemy;
            }
        }
    }
    
    return best_enemy;
}

// Namespace dragon
// Params 0, eflags: 0x4
// Checksum 0x9ce7bf64, Offset: 0xbe0
// Size: 0x100
function private dragon_target_selection()
{
    self endon( #"death" );
    
    for ( ;; )
    {
        if ( !isdefined( self.owner ) )
        {
            wait 0.25;
            continue;
        }
        
        if ( isdefined( self.ignoreall ) && self.ignoreall )
        {
            wait 0.25;
            continue;
        }
        
        /#
            if ( getdvarint( "<dev string:x28>", 0 ) )
            {
                if ( isdefined( self.dragonenemy ) )
                {
                    line( self.origin, self.dragonenemy.origin, ( 1, 0, 0 ), 1, 0, 5 );
                }
            }
        #/
        
        target = get_dragon_enemy();
        
        if ( !isdefined( target ) )
        {
            self.dragonenemy = undefined;
        }
        else
        {
            self.dragonenemy = target;
        }
        
        wait 0.25;
    }
}

// Namespace dragon
// Params 1
// Checksum 0x6ac2c56b, Offset: 0xce8
// Size: 0x264
function state_power_up_update( params )
{
    self endon( #"change_state" );
    self endon( #"death" );
    closest_distsqr = 10000 * 10000;
    closest = undefined;
    
    foreach ( powerup in level.active_powerups )
    {
        powerup.navvolumeorigin = self getclosestpointonnavvolume( powerup.origin, 100 );
        
        if ( !isdefined( powerup.navvolumeorigin ) )
        {
            continue;
        }
        
        distsqr = distancesquared( powerup.origin, self.origin );
        
        if ( distsqr < closest_distsqr )
        {
            closest_distsqr = distsqr;
            closest = powerup;
        }
    }
    
    if ( isdefined( closest ) && distsqr < 2000 * 2000 )
    {
        self setvehgoalpos( closest.navvolumeorigin, 1, 1 );
        
        if ( vehicle_ai::waittill_pathresult() )
        {
            self vehicle_ai::waittill_pathing_done();
        }
        
        if ( isdefined( closest ) )
        {
            trace = bullettrace( self.origin, closest.origin, 0, self );
            
            if ( trace[ "fraction" ] == 1 )
            {
                self setvehgoalpos( closest.origin, 1, 0 );
            }
        }
    }
    
    self vehicle_ai::evaluate_connections();
}

// Namespace dragon
// Params 3
// Checksum 0x5c589533, Offset: 0xf58
// Size: 0x5a, Type: bool
function should_go_for_power_up( from_state, to_state, connection )
{
    if ( level.whelp_no_power_up_pickup === 1 )
    {
        return false;
    }
    
    if ( isdefined( self.dragonenemy ) )
    {
        return false;
    }
    
    if ( level.active_powerups.size < 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace dragon
// Params 1
// Checksum 0x170a7e76, Offset: 0xfc0
// Size: 0x850
function state_combat_update( params )
{
    self endon( #"change_state" );
    self endon( #"death" );
    idealdisttoowner = 300;
    self asmrequestsubstate( "locomotion@movement" );
    
    while ( !isdefined( self.owner ) )
    {
        wait 0.05;
    }
    
    self thread attack_thread();
    
    for ( ;; )
    {
        self setspeed( self.settings.defaultmovespeed );
        self asmrequestsubstate( "locomotion@movement" );
        
        if ( isdefined( self.owner ) && distance2dsquared( self.origin, self.owner.origin ) < idealdisttoowner * idealdisttoowner && ispointinnavvolume( self.origin, "navvolume_small" ) )
        {
            if ( !isdefined( self.current_pathto_pos ) )
            {
                self.current_pathto_pos = self getclosestpointonnavvolume( self.origin, 100 );
            }
            
            self setvehgoalpos( self.current_pathto_pos, 1, 0 );
            wait 0.1;
            continue;
        }
        
        if ( isdefined( self.owner ) )
        {
            queryresult = positionquery_source_navigation( self.origin, 0, 256, 90, self.radius, self );
            sighttarget = undefined;
            
            if ( isdefined( self.dragonenemy ) )
            {
                sighttarget = self.dragonenemy geteye();
                positionquery_filter_sight( queryresult, sighttarget, ( 0, 0, 0 ), self, 4 );
            }
            
            if ( isdefined( queryresult.centeronnav ) && queryresult.centeronnav )
            {
                ownerorigin = self.owner.origin;
                ownerforward = anglestoforward( self.owner.angles );
                best_point = undefined;
                best_score = -999999;
                
                foreach ( point in queryresult.data )
                {
                    distsqr = distance2dsquared( point.origin, ownerorigin );
                    
                    if ( distsqr > idealdisttoowner * idealdisttoowner )
                    {
                        /#
                            if ( !isdefined( point._scoredebug ) )
                            {
                                point._scoredebug = [];
                            }
                            
                            point._scoredebug[ "<dev string:x46>" ] = sqrt( distsqr ) * -1 * 2;
                        #/
                        
                        point.score += sqrt( distsqr ) * -1 * 2;
                    }
                    
                    if ( isdefined( point.visibility ) && point.visibility )
                    {
                        if ( bullettracepassed( point.origin, sighttarget, 0, self ) )
                        {
                            /#
                                if ( !isdefined( point._scoredebug ) )
                                {
                                    point._scoredebug = [];
                                }
                                
                                point._scoredebug[ "<dev string:x52>" ] = 400;
                            #/
                            
                            point.score += 400;
                        }
                    }
                    
                    vectoowner = point.origin - ownerorigin;
                    dirtoowner = vectornormalize( ( vectoowner[ 0 ], vectoowner[ 1 ], 0 ) );
                    
                    if ( vectordot( ownerforward, dirtoowner ) > 0.34 )
                    {
                        if ( abs( vectoowner[ 2 ] ) < 100 )
                        {
                            /#
                                if ( !isdefined( point._scoredebug ) )
                                {
                                    point._scoredebug = [];
                                }
                                
                                point._scoredebug[ "<dev string:x5d>" ] = 300;
                            #/
                            
                            point.score += 300;
                        }
                        else if ( abs( vectoowner[ 2 ] ) < 200 )
                        {
                            /#
                                if ( !isdefined( point._scoredebug ) )
                                {
                                    point._scoredebug = [];
                                }
                                
                                point._scoredebug[ "<dev string:x5d>" ] = 100;
                            #/
                            
                            point.score += 100;
                        }
                    }
                    
                    if ( point.score > best_score )
                    {
                        best_score = point.score;
                        best_point = point;
                    }
                }
                
                self vehicle_ai::positionquery_debugscores( queryresult );
                
                if ( isdefined( best_point ) )
                {
                    /#
                        if ( isdefined( getdvarint( "<dev string:x6b>" ) ) && getdvarint( "<dev string:x6b>" ) )
                        {
                            recordline( self.origin, best_point.origin, ( 0.3, 1, 0 ) );
                            recordline( self.origin, self.owner.origin, ( 1, 0, 0.4 ) );
                        }
                    #/
                    
                    if ( distancesquared( self.origin, best_point.origin ) > 50 * 50 )
                    {
                        self.current_pathto_pos = best_point.origin;
                        self setvehgoalpos( self.current_pathto_pos, 1, 1 );
                        self vehicle_ai::waittill_pathing_done( 5 );
                    }
                    else
                    {
                        self vehicle_ai::cooldown( "move_cooldown", 4 );
                    }
                }
            }
            else
            {
                go_back_on_navvolume();
            }
        }
        
        wait 0.1;
    }
}

// Namespace dragon
// Params 0
// Checksum 0x36fdcf4, Offset: 0x1818
// Size: 0x250
function attack_thread()
{
    self endon( #"change_state" );
    self endon( #"death" );
    
    for ( ;; )
    {
        wait 0.1;
        self vehicle_ai::evaluate_connections();
        
        if ( !self vehicle_ai::iscooldownready( "attack" ) )
        {
            continue;
        }
        
        if ( !isdefined( self.dragonenemy ) )
        {
            continue;
        }
        
        self setlookatent( self.dragonenemy );
        
        if ( !self vehcansee( self.dragonenemy ) )
        {
            continue;
        }
        
        if ( distance2dsquared( self.dragonenemy.origin, self.owner.origin ) > self.settings.guardradius * self.settings.guardradius )
        {
            continue;
        }
        
        eyeoffset = ( self.dragonenemy geteye() - self.dragonenemy.origin ) * 0.6;
        
        if ( !bullettracepassed( self.origin, self.dragonenemy geteye() - eyeoffset, 0, self, self.dragonenemy ) )
        {
            self.dragonenemy = undefined;
            continue;
        }
        
        aimoffset = self.dragonenemy getvelocity() * 0.3 - eyeoffset;
        self setturrettargetent( self.dragonenemy, aimoffset );
        wait 0.2;
        
        if ( isdefined( self.dragonenemy ) )
        {
            self fireweapon( 0, self.dragonenemy, ( 0, 0, 0 ), self );
            self vehicle_ai::cooldown( "attack", 1 );
        }
    }
}

// Namespace dragon
// Params 0
// Checksum 0x43d208c4, Offset: 0x1a70
// Size: 0x2ac
function go_back_on_navvolume()
{
    queryresult = positionquery_source_navigation( self.origin, 0, 100, 90, self.radius, self );
    multiplier = 2;
    
    while ( queryresult.data.size < 1 )
    {
        queryresult = positionquery_source_navigation( self.origin, 0, 100 * multiplier, 90 * multiplier, self.radius * multiplier, self );
        multiplier += 2;
    }
    
    if ( queryresult.data.size && !queryresult.centeronnav )
    {
        best_point = undefined;
        best_score = 999999;
        
        foreach ( point in queryresult.data )
        {
            point.score = abs( point.origin[ 2 ] - queryresult.origin[ 2 ] );
            
            if ( point.score < best_score )
            {
                best_score = point.score;
                best_point = point;
            }
        }
        
        if ( isdefined( best_point ) )
        {
            self setneargoalnotifydist( 2 );
            point = best_point;
            self.current_pathto_pos = point.origin;
            foundpath = self setvehgoalpos( self.current_pathto_pos, 1, 0 );
            
            if ( foundpath )
            {
                self vehicle_ai::waittill_pathing_done( 5 );
            }
            
            self setneargoalnotifydist( self.radius );
        }
    }
}

// Namespace dragon
// Params 4
// Checksum 0xf44b4151, Offset: 0x1d28
// Size: 0x26, Type: bool
function dragon_allowfriendlyfiredamage( einflictor, eattacker, smeansofdeath, weapon )
{
    return false;
}

// Namespace dragon
// Params 15
// Checksum 0x5610bcb2, Offset: 0x1d58
// Size: 0x94
function dragon_callback_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    if ( self.dragon_recall_death !== 1 )
    {
        return 0;
    }
    
    return idamage;
}

// Namespace dragon
// Params 1
// Checksum 0xb059842e, Offset: 0x1df8
// Size: 0xfc
function state_death_update( params )
{
    self endon( #"death" );
    attacker = params.inflictor;
    
    if ( !isdefined( attacker ) )
    {
        attacker = params.attacker;
    }
    
    if ( isai( attacker ) || ( !isdefined( self.owner ) || attacker !== self && self.owner !== attacker ) && isplayer( attacker ) )
    {
        self.damage_on_death = 0;
        wait 0.05;
        attacker = params.inflictor;
        
        if ( !isdefined( attacker ) )
        {
            attacker = params.attacker;
        }
    }
    
    self vehicle_ai::defaultstate_death_update();
}

