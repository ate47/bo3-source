#using scripts/codescripts/struct;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/vehicles/_siegebot;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons/_spike_charge_siegebot;

#namespace siegebot_theia;

// Namespace siegebot_theia
// Params 0, eflags: 0x2
// Checksum 0xe64c428f, Offset: 0x670
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "siegebot_theia", &__init__, undefined, undefined );
}

// Namespace siegebot_theia
// Params 0
// Checksum 0xf02c09f3, Offset: 0x6b0
// Size: 0x8c
function __init__()
{
    vehicle::add_main_callback( "siegebot_theia", &siegebot_initialize );
    clientfield::register( "vehicle", "sarah_rumble_on_landing", 1, 1, "counter" );
    clientfield::register( "vehicle", "sarah_minigun_spin", 1, 1, "int" );
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x7fe42769, Offset: 0x748
// Size: 0x35c
function siegebot_initialize()
{
    self useanimtree( $generic );
    blackboard::createblackboardforentity( self );
    self blackboard::registervehicleblackboardattributes();
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self enableaimassist();
    self setneargoalnotifydist( self.radius * 1.2 );
    target_set( self, ( 0, 0, 150 ) );
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.maxsightdistsqrd = 10000 * 10000;
    assert( isdefined( self.scriptbundlesettings ) );
    self.settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    self.goalradius = 9999999;
    self.goalheight = 5000;
    self setgoal( self.origin, 0, self.goalradius, self.goalheight );
    self.overridevehicledamage = &theia_callback_damage;
    self pain_toggle( 1 );
    
    if ( !sessionmodeismultiplayergame() )
    {
        self initjumpstruct();
    }
    
    self setgunnerturretontargetrange( 0, self.settings.gunner_turret_on_target_range );
    self locomotion_start();
    self thread init_clientfields();
    self.damagelevel = 0;
    self.newdamagelevel = self.damagelevel;
    self init_player_threat_all();
    self init_fake_targets();
    
    if ( isdefined( self.combat_goal_volume ) )
    {
        self setgoal( self.combat_goal_volume );
    }
    
    if ( !isdefined( self.height ) )
    {
        self.height = self.radius;
    }
    
    self.nocybercom = 1;
    self.ignorefirefly = 1;
    self.ignoredecoy = 1;
    self vehicle_ai::initthreatbias();
    killstreak_bundles::register_killstreak_bundle( "siegebot_theia" );
    self.maxhealth = killstreak_bundles::get_max_health( "siegebot_theia" );
    self.heatlh = self.maxhealth;
}

// Namespace siegebot_theia
// Params 0
// Checksum 0xc042d678, Offset: 0xab0
// Size: 0x9c
function init_clientfields()
{
    self vehicle::lights_on();
    self vehicle::toggle_lights_group( 1, 1 );
    self vehicle::toggle_lights_group( 2, 1 );
    self vehicle::toggle_lights_group( 3, 1 );
    self clientfield::set( "sarah_minigun_spin", 0 );
}

// Namespace siegebot_theia
// Params 0
// Checksum 0xf6ece250, Offset: 0xb58
// Size: 0x4b4
function defaultrole()
{
    self vehicle_ai::init_state_machine_for_role();
    self vehicle_ai::get_state_callbacks( "combat" ).enter_func = &state_balconycombat_enter;
    self vehicle_ai::get_state_callbacks( "combat" ).update_func = &state_balconycombat_update;
    self vehicle_ai::get_state_callbacks( "combat" ).exit_func = &state_balconycombat_exit;
    self vehicle_ai::get_state_callbacks( "pain" ).enter_func = &pain_enter;
    self vehicle_ai::get_state_callbacks( "pain" ).update_func = &pain_update;
    self vehicle_ai::get_state_callbacks( "pain" ).exit_func = &pain_exit;
    self vehicle_ai::get_state_callbacks( "scripted" ).exit_func = &scripted_exit;
    self vehicle_ai::get_state_callbacks( "death" ).update_func = &state_death_update;
    self vehicle_ai::add_state( "jumpUp", &state_jumpup_enter, &state_jump_update, &state_jump_exit );
    self vehicle_ai::add_state( "jumpDown", &state_jumpdown_enter, &state_jump_update, &state_jumpdown_exit );
    self vehicle_ai::add_state( "jumpGroundToGround", &state_jumpdown_enter, &state_jump_update, &state_jump_exit );
    self vehicle_ai::add_state( "groundCombat", undefined, &state_groundcombat_update, &state_groundcombat_exit );
    self vehicle_ai::add_state( "prepareDeath", undefined, &prepare_death_update, undefined );
    vehicle_ai::add_interrupt_connection( "groundCombat", "pain", "pain" );
    vehicle_ai::add_utility_connection( "emped", "groundCombat" );
    vehicle_ai::add_utility_connection( "pain", "groundCombat" );
    vehicle_ai::add_utility_connection( "combat", "jumpDown", &can_jump_down );
    vehicle_ai::add_utility_connection( "jumpDown", "groundCombat" );
    vehicle_ai::add_utility_connection( "groundCombat", "jumpGroundToGround", &can_jump_ground_to_ground );
    vehicle_ai::add_utility_connection( "jumpGroundToGround", "groundCombat" );
    vehicle_ai::add_utility_connection( "groundCombat", "jumpUp", &can_jump_up );
    vehicle_ai::add_utility_connection( "jumpUp", "combat" );
    vehicle_ai::add_utility_connection( "groundCombat", "prepareDeath", &should_prepare_death );
    vehicle_ai::cooldown( "jump", 22 );
    vehicle_ai::cooldown( "jumpUp", 33 );
    vehicle_ai::startinitialstate( "groundCombat" );
}

// Namespace siegebot_theia
// Params 1
// Checksum 0xeee2e7f9, Offset: 0x1018
// Size: 0xfc
function state_death_update( params )
{
    self endon( #"death" );
    self endon( #"nodeath_thread" );
    self setturretspinning( 0 );
    self clean_up_spawned();
    self stopmovementandsetbrake();
    self setturrettargetrelativeangles( ( 0, 0, 0 ) );
    self vehicle_death::death_fx();
    self vehicle_death::set_death_model( self.deathmodel, self.modelswapdelay );
    self vehicle::set_damage_fx_level( 0 );
    self playsound( "veh_quadtank_sparks" );
}

// Namespace siegebot_theia
// Params 0
// Checksum 0xbab4823e, Offset: 0x1120
// Size: 0xf2
function clean_up_spawned()
{
    if ( isdefined( self.jump ) )
    {
        self.jump.linkent delete();
    }
    
    if ( isdefined( self.faketargetent ) )
    {
        self.faketargetent delete();
    }
    
    if ( isdefined( self.spikefaketargets ) )
    {
        foreach ( target in self.spikefaketargets )
        {
            target delete();
        }
    }
}

// Namespace siegebot_theia
// Params 1
// Checksum 0xee9000fe, Offset: 0x1220
// Size: 0x18
function pain_toggle( enabled )
{
    self._enablepain = enabled;
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x9dddb55, Offset: 0x1240
// Size: 0x42, Type: bool
function pain_canenter()
{
    state = vehicle_ai::get_current_state();
    return isdefined( state ) && state != "pain" && self._enablepain;
}

// Namespace siegebot_theia
// Params 1
// Checksum 0xf2aa6147, Offset: 0x1290
// Size: 0x24
function pain_enter( params )
{
    self stopmovementandsetbrake();
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x28ab4281, Offset: 0x12c0
// Size: 0x24
function pain_exit( params )
{
    self setbrake( 0 );
}

// Namespace siegebot_theia
// Params 1
// Checksum 0xb96f4079, Offset: 0x12f0
// Size: 0x13c
function pain_update( params )
{
    self endon( #"death" );
    
    if ( 1 <= self.damagelevel && self.damagelevel <= 4 )
    {
        asmstate = "damage_" + self.damagelevel + "@pain";
    }
    else
    {
        asmstate = "normal@pain";
    }
    
    self asmrequestsubstate( asmstate );
    self vehicle_ai::waittill_asm_complete( asmstate, 5 );
    vehicle_ai::addcooldowntime( "jump", -4.4 );
    vehicle_ai::addcooldowntime( "jumpUp", -11 );
    previous_state = vehicle_ai::get_previous_state();
    self vehicle_ai::set_state( previous_state );
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot_theia
// Params 3
// Checksum 0x11ba8d6d, Offset: 0x1438
// Size: 0x56
function should_prepare_death( from_state, to_state, connection )
{
    prepare_death_threshold = self.healthdefault * 0.1;
    
    if ( self.health < prepare_death_threshold )
    {
        return 99999999;
    }
    
    return 0;
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x6627f5fa, Offset: 0x1498
// Size: 0x1f4
function prepare_death_update( params )
{
    self endon( #"death" );
    self endon( #"change_state" );
    vehicle_ai::cooldown( "spike_on_ground", 2 );
    self thread attack_thread_gun();
    self thread attack_thread_rocket();
    locomotion_start();
    starttime = gettime();
    
    while ( distance2dsquared( self.origin, self.death_goal_point ) > 1200 && vehicle_ai::timesince( starttime ) < 8 )
    {
        self setvehgoalpos( self.death_goal_point, 0, 1 );
        self setbrake( 0 );
        wait 1;
    }
    
    self cancelaimove();
    self clearvehgoalpos();
    self setbrake( 1 );
    self notify( #"end_attack_thread" );
    self notify( #"end_movement_thread" );
    self.jump.highground_history = self.jump.highgrounds[ 0 ];
    self state_jumpup_enter( params );
    self state_jump_update( params );
    self.disable_side_step = 1;
    self state_balconycombat_update( params );
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x6ac33a80, Offset: 0x1698
// Size: 0x4c
function scripted_exit( params )
{
    vehicle_ai::cooldown( "jump", 22 );
    vehicle_ai::cooldown( "jumpUp", 33 );
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x6d416bb5, Offset: 0x16f0
// Size: 0x354
function initjumpstruct()
{
    if ( isdefined( self.jump ) )
    {
        self unlink();
        self.jump.linkent delete();
        self.jump delete();
    }
    
    self.jump = spawnstruct();
    self.jump.linkent = spawn( "script_origin", self.origin );
    self.jump.in_air = 0;
    self.jump.highgrounds = struct::get_array( "balcony_point" );
    self.jump.groundpoints = struct::get_array( "ground_point" );
    self.arena_center = struct::get( "arena_center" ).origin;
    self.death_goal_point = struct::get( "death_goal_point" ).origin;
    self.combat_goal_volume = getent( "theia_combat_region", "targetname" );
    
    foreach ( point in self.jump.highgrounds )
    {
        if ( distancesquared( point.origin, ( -24566.2, 23972.5, -20000 ) ) < 100 * 100 )
        {
            point.origin += ( 20, -20, -100 );
            continue;
        }
        
        if ( distancesquared( point.origin, ( -27291.2, 25825.6, -20072 ) ) < 100 * 100 )
        {
            point.origin += ( 0, 35, 0 );
        }
    }
    
    assert( self.jump.highgrounds.size > 0 );
    assert( self.jump.groundpoints.size > 0 );
    assert( isdefined( self.arena_center ) );
}

// Namespace siegebot_theia
// Params 3
// Checksum 0xbebb8c61, Offset: 0x1a50
// Size: 0xc0
function can_jump_up( from_state, to_state, connection )
{
    if ( !vehicle_ai::iscooldownready( "jump" ) || !vehicle_ai::iscooldownready( "jumpUp" ) )
    {
        return 0;
    }
    
    target = highgroundpoint( 800, 2000, self.jump.highgrounds, 1200 );
    
    if ( isdefined( target ) )
    {
        self.jump.highground_history = target;
        return 500;
    }
    
    return 0;
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x9c326b7d, Offset: 0x1b18
// Size: 0x1fc
function state_jumpup_enter( params )
{
    goal = self.jump.highground_history.origin;
    trace = physicstrace( goal + ( 0, 0, 200 ), goal - ( 0, 0, 10000 ), ( -10, -10, -10 ), ( 10, 10, 10 ), self, 2 );
    
    if ( false )
    {
        /#
            debugstar( goal, 60000, ( 0, 1, 0 ) );
        #/
        
        /#
            debugstar( trace[ "<dev string:x28>" ], 60000, ( 0, 1, 0 ) );
        #/
        
        /#
            line( goal, trace[ "<dev string:x28>" ], ( 0, 1, 0 ), 1, 0, 60000 );
        #/
    }
    
    if ( trace[ "fraction" ] < 1 )
    {
        goal = trace[ "position" ];
    }
    
    self.jump.highground_history = goal;
    self.jump.goal = goal;
    params.scaleforward = 70;
    params.gravityforce = ( 0, 0, -5 );
    params.upbyheight = 10;
    params.coptermodel = "land_turn@jump";
    self pain_toggle( 0 );
    self stopmovementandsetbrake();
}

// Namespace siegebot_theia
// Params 3
// Checksum 0xf865765b, Offset: 0x1d20
// Size: 0xa0
function can_jump_down( from_state, to_state, connection )
{
    if ( !vehicle_ai::iscooldownready( "jump" ) || self.dontchangestate === 1 )
    {
        return 0;
    }
    
    target = get_jumpon_target( 800, 2000, 1300 );
    
    if ( isdefined( target ) )
    {
        self.jump.lowground_history = target;
        return 500;
    }
    
    return 0;
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x74b95fd5, Offset: 0x1dc8
// Size: 0x1f4
function state_jumpdown_enter( params )
{
    goal = self.jump.lowground_history;
    trace = physicstrace( goal + ( 0, 0, 500 ), goal - ( 0, 0, 10000 ), ( -10, -10, -10 ), ( 10, 10, 10 ), self, 2 );
    
    if ( false )
    {
        /#
            debugstar( goal, 60000, ( 0, 1, 0 ) );
        #/
        
        /#
            debugstar( trace[ "<dev string:x28>" ], 60000, ( 0, 1, 0 ) );
        #/
        
        /#
            line( goal, trace[ "<dev string:x28>" ], ( 0, 1, 0 ), 1, 0, 60000 );
        #/
    }
    
    if ( trace[ "fraction" ] < 1 )
    {
        goal = trace[ "position" ];
    }
    
    self.jump.lowground_history = goal;
    self.jump.goal = goal;
    params.scaleforward = 70;
    params.gravityforce = ( 0, 0, -5 );
    params.upbyheight = -5;
    params.coptermodel = "land@jump";
    self pain_toggle( 0 );
    self stopmovementandsetbrake();
}

// Namespace siegebot_theia
// Params 3
// Checksum 0x6b58f74c, Offset: 0x1fc8
// Size: 0x90
function can_jump_ground_to_ground( from_state, to_state, connection )
{
    if ( !vehicle_ai::iscooldownready( "jump" ) )
    {
        return 0;
    }
    
    target = get_jumpon_target( 800, 1800, 1300, 0, 0, 0 );
    
    if ( isdefined( target ) )
    {
        self.jump.lowground_history = target;
        return 400;
    }
    
    return 0;
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x6137176e, Offset: 0x2060
// Size: 0x24
function state_jump_exit( params )
{
    self pain_toggle( 1 );
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x263c14a9, Offset: 0x2090
// Size: 0x5c
function state_jumpdown_exit( params )
{
    self pain_toggle( 1 );
    self vehicle_ai::cooldown( "jumpUp", 11 + randomfloatrange( -1, 3 ) );
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x2c870e74, Offset: 0x20f8
// Size: 0xd14
function state_jump_update( params )
{
    self endon( #"change_state" );
    self endon( #"death" );
    goal = self.jump.goal;
    self face_target( goal );
    self.jump.linkent.origin = self.origin;
    self.jump.linkent.angles = self.angles;
    wait 0.05;
    self linkto( self.jump.linkent );
    self.jump.in_air = 1;
    
    if ( false )
    {
        /#
            debugstar( goal, 60000, ( 0, 1, 0 ) );
        #/
        
        /#
            debugstar( goal + ( 0, 0, 100 ), 60000, ( 0, 1, 0 ) );
        #/
        
        /#
            line( goal, goal + ( 0, 0, 100 ), ( 0, 1, 0 ), 1, 0, 60000 );
        #/
    }
    
    totaldistance = distance2d( goal, self.jump.linkent.origin );
    forward = ( ( ( goal - self.jump.linkent.origin ) / totaldistance )[ 0 ], ( ( goal - self.jump.linkent.origin ) / totaldistance )[ 1 ], 0 );
    upbydistance = mapfloat( 500, 2000, 46, 52, totaldistance );
    antigravitybydistance = mapfloat( 500, 2000, 0, 0.5, totaldistance );
    initvelocityup = ( 0, 0, 1 ) * ( upbydistance + params.upbyheight );
    initvelocityforward = forward * params.scaleforward * mapfloat( 500, 2000, 0.8, 1, totaldistance );
    velocity = initvelocityup + initvelocityforward;
    self asmrequestsubstate( "inair@jump" );
    self waittill( #"engine_startup" );
    self vehicle::impact_fx( self.settings.startupfx1 );
    self waittill( #"leave_ground" );
    self vehicle::impact_fx( self.settings.takeofffx1 );
    jumpstart = gettime();
    
    while ( true )
    {
        distancetogoal = distance2d( self.jump.linkent.origin, goal );
        antigravityscaleup = mapfloat( 0, 0.5, 0.6, 0, abs( 0.5 - distancetogoal / totaldistance ) );
        antigravityscale = mapfloat( self.radius * 1, self.radius * 3, 0, 1, distancetogoal );
        antigravity = antigravityscale * antigravityscaleup * params.gravityforce * -1 + ( 0, 0, antigravitybydistance );
        
        if ( false )
        {
            /#
                line( self.jump.linkent.origin, self.jump.linkent.origin + antigravity, ( 0, 1, 0 ), 1, 0, 60000 );
            #/
        }
        
        velocityforwardscale = mapfloat( self.radius * 1, self.radius * 4, 0.2, 1, distancetogoal );
        velocityforward = initvelocityforward * velocityforwardscale;
        
        if ( false )
        {
            /#
                line( self.jump.linkent.origin, self.jump.linkent.origin + velocityforward, ( 0, 1, 0 ), 1, 0, 60000 );
            #/
        }
        
        oldverticlespeed = velocity[ 2 ];
        velocity = ( 0, 0, velocity[ 2 ] );
        velocity += velocityforward + params.gravityforce + antigravity;
        
        if ( oldverticlespeed > 0 && velocity[ 2 ] <= 0 )
        {
            self asmrequestsubstate( "fall@jump" );
        }
        
        if ( velocity[ 2 ] <= 0 && self.jump.linkent.origin[ 2 ] + velocity[ 2 ] <= goal[ 2 ] || vehicle_ai::timesince( jumpstart ) > 10 )
        {
            break;
        }
        
        heightthreshold = goal[ 2 ] + 110;
        oldheight = self.jump.linkent.origin[ 2 ];
        self.jump.linkent.origin += velocity;
        
        if ( oldverticlespeed > 0 && ( oldheight > heightthreshold || self.jump.linkent.origin[ 2 ] < heightthreshold && velocity[ 2 ] < 0 ) )
        {
            self notify( #"start_landing" );
            self asmrequestsubstate( params.coptermodel );
        }
        
        if ( false )
        {
            /#
                debugstar( self.jump.linkent.origin, 60000, ( 1, 0, 0 ) );
            #/
        }
        
        wait 0.05;
    }
    
    self.jump.linkent.origin = ( self.jump.linkent.origin[ 0 ], self.jump.linkent.origin[ 1 ], 0 ) + ( 0, 0, goal[ 2 ] );
    self notify( #"land_crush" );
    
    foreach ( player in level.players )
    {
        player._takedamage_old = player.takedamage;
        player.takedamage = 0;
    }
    
    self radiusdamage( self.origin + ( 0, 0, 15 ), self.radiusdamageradius, self.radiusdamagemax, self.radiusdamagemin, self, "MOD_EXPLOSIVE" );
    
    foreach ( player in level.players )
    {
        player.takedamage = player._takedamage_old;
        player._takedamage_old = undefined;
        
        if ( distance2dsquared( self.origin, player.origin ) < 200 * 200 )
        {
            direction = ( ( player.origin - self.origin )[ 0 ], ( player.origin - self.origin )[ 1 ], 0 );
            
            if ( abs( direction[ 0 ] ) < 0.01 && abs( direction[ 1 ] ) < 0.01 )
            {
                direction = ( randomfloatrange( 1, 2 ), randomfloatrange( 1, 2 ), 0 );
            }
            
            direction = vectornormalize( direction );
            strength = 700;
            player setvelocity( player getvelocity() + direction * strength );
            
            if ( player.health > 80 )
            {
                player dodamage( player.health - 70, self.origin, self );
                continue;
            }
            
            player dodamage( 20, self.origin, self );
        }
    }
    
    self vehicle::impact_fx( self.settings.landingfx1 );
    self stopmovementandsetbrake();
    self clientfield::increment( "sarah_rumble_on_landing" );
    wait 0.3;
    self unlink();
    wait 0.05;
    self.jump.in_air = 0;
    self notify( #"jump_finished" );
    vehicle_ai::cooldown( "jump", 11 );
    vehicle_ai::cooldown( "ignore_player", 12 );
    self vehicle_ai::waittill_asm_complete( params.coptermodel, 3 );
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x13d8a433, Offset: 0x2e18
// Size: 0xbc
function state_balconycombat_enter( params )
{
    self vehicle_ai::clearalllookingandtargeting();
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 0 );
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 1 );
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 2 );
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 3 );
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 4 );
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x412db5d2, Offset: 0x2ee0
// Size: 0x2e8
function state_balconycombat_update( params )
{
    self endon( #"change_state" );
    self endon( #"death" );
    currenthighground = undefined;
    
    foreach ( highground in self.jump.highgrounds )
    {
        if ( distance2dsquared( highground.origin, self.origin ) < self.radius * 6 * self.radius * 6 )
        {
            currenthighground = highground;
            break;
        }
    }
    
    if ( !isdefined( currenthighground ) )
    {
        self vehicle_ai::clearcooldown( "jump" );
        self vehicle_ai::evaluate_connections();
    }
    
    forward = anglestoforward( currenthighground.angles );
    
    while ( true )
    {
        while ( !isdefined( self.enemy ) )
        {
            wait 1;
        }
        
        self face_target( self.origin + forward * 10000 );
        javelinchance = self.damagelevel * 0.15;
        
        if ( randomfloat( 1 ) < javelinchance )
        {
            attack_javelin();
            level notify( #"theia_finished_platform_attack" );
            self vehicle_ai::evaluate_connections();
            wait 0.8;
        }
        
        attack_spike_minefield();
        level notify( #"theia_finished_platform_attack" );
        self vehicle_ai::evaluate_connections();
        
        if ( randomfloat( 1 ) > 0.4 && self.disable_side_step !== 1 )
        {
            wait 0.2;
            self side_step();
        }
        
        wait 0.8;
        attack_minigun_sweep();
        level notify( #"theia_finished_platform_attack" );
        self vehicle_ai::evaluate_connections();
        wait 0.8;
    }
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x6aa6a686, Offset: 0x31d0
// Size: 0x2f4, Type: bool
function side_step()
{
    step_size = 180;
    right_dir = anglestoright( self.angles );
    start = self.origin + ( 0, 0, 10 );
    tracedir = right_dir;
    jukestate = "juke_r@movement";
    oppositejukestate = "juke_l@movement";
    
    if ( math::cointoss() )
    {
        tracedir *= -1;
        jukestate = "juke_l@movement";
        oppositejukestate = "juke_r@movement";
    }
    
    trace = physicstrace( start, start + tracedir * step_size, 0.8 * ( self.radius * -1, self.radius * -1, 0 ), 0.8 * ( self.radius, self.radius, self.height ), self, 2 );
    
    if ( false )
    {
        /#
            line( start, start + tracedir * step_size, ( 1, 0, 0 ), 1, 0, 100 );
        #/
    }
    
    if ( trace[ "fraction" ] < 1 )
    {
        tracedir *= -1;
        trace = physicstrace( start, start + tracedir * step_size, 0.8 * ( self.radius * -1, self.radius * -1, 0 ), 0.8 * ( self.radius, self.radius, self.height ), self, 2 );
        jukestate = oppositejukestate;
        
        if ( false )
        {
            /#
                line( start, start + tracedir * step_size, ( 1, 0, 0 ), 1, 0, 100 );
            #/
        }
    }
    
    if ( trace[ "fraction" ] >= 1 )
    {
        self asmrequestsubstate( jukestate );
        self vehicle_ai::waittill_asm_complete( jukestate, 3 );
        self locomotion_start();
        return true;
    }
    
    return false;
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x5d489f12, Offset: 0x34d0
// Size: 0xbc
function state_balconycombat_exit( params )
{
    self vehicle_ai::clearalllookingandtargeting();
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 0 );
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 1 );
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 2 );
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 3 );
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 4 );
}

// Namespace siegebot_theia
// Params 1
// Checksum 0xc55166ba, Offset: 0x3598
// Size: 0xfe
function state_groundcombat_update( params )
{
    self endon( #"death" );
    self endon( #"change_state" );
    
    if ( vehicle_ai::get_previous_state() === "jump" )
    {
        vehicle_ai::cooldown( "spike_on_ground", 2 );
    }
    
    self thread attack_thread_gun();
    self thread attack_thread_rocket();
    self thread movement_thread();
    self thread footstep_left_monitor();
    self thread footstep_right_monitor();
    
    while ( true )
    {
        self vehicle_ai::evaluate_connections();
        wait 1;
    }
}

// Namespace siegebot_theia
// Params 1
// Checksum 0xd03dd5a6, Offset: 0x36a0
// Size: 0x1fa
function footstep_damage( tag_name )
{
    origin = self gettagorigin( tag_name );
    
    foreach ( player in level.players )
    {
        player._takedamage_old = player.takedamage;
        player.takedamage = 0;
    }
    
    self radiusdamage( origin + ( 0, 0, 10 ), self.radius, 200, 200, self, "MOD_EXPLOSIVE" );
    
    foreach ( player in level.players )
    {
        player.takedamage = player._takedamage_old;
        player._takedamage_old = undefined;
        
        if ( distance2dsquared( origin, player.origin ) < self.radius * self.radius )
        {
            player dodamage( 15, origin, self );
        }
    }
}

// Namespace siegebot_theia
// Params 0
// Checksum 0xa301812b, Offset: 0x38a8
// Size: 0x68
function footstep_left_monitor()
{
    self endon( #"death" );
    self endon( #"change_state" );
    self notify( #"stop_left_footstep_damage" );
    self endon( #"stop_left_footstep_damage" );
    
    while ( true )
    {
        self waittill( #"footstep_left_large_theia" );
        footstep_damage( "tag_leg_left_foot_animate" );
    }
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x3aae550a, Offset: 0x3918
// Size: 0x68
function footstep_right_monitor()
{
    self endon( #"death" );
    self endon( #"change_state" );
    self notify( #"stop_right_footstep_damage" );
    self endon( #"stop_right_footstep_damage" );
    
    while ( true )
    {
        self waittill( #"footstep_right_large_theia" );
        footstep_damage( "tag_leg_right_foot_animate" );
    }
}

// Namespace siegebot_theia
// Params 4
// Checksum 0x929fa4ef, Offset: 0x3988
// Size: 0x346
function highgroundpoint( distancelimitmin, distancelimitmax, pointsarray, idealdist )
{
    /#
        record3dtext( "<dev string:x31>" + distancelimitmin + "<dev string:x3a>" + distancelimitmax + "<dev string:x3c>", self.origin, ( 1, 0.5, 0 ), "<dev string:x3e>", self );
    #/
    
    bestscore = 1000000;
    result = undefined;
    
    foreach ( point in pointsarray )
    {
        distancetotarget = distance2d( point.origin, self.origin );
        
        if ( distancetotarget < distancelimitmin || distancelimitmax < distancetotarget )
        {
            /#
                recordstar( point.origin, ( 1, 0.5, 0 ) );
            #/
            
            /#
                record3dtext( "<dev string:x45>" + distancetotarget, point.origin, ( 1, 0.5, 0 ), "<dev string:x3e>", self );
            #/
            
            continue;
        }
        
        score = abs( distancetotarget - idealdist );
        
        if ( score < 200 )
        {
            score = randomfloat( 200 );
        }
        
        if ( isdefined( self.jump.highground_history ) && distance2dsquared( point.origin, self.jump.highground_history ) < 50 * 50 )
        {
            score += 1000;
        }
        
        /#
            recordstar( point.origin, ( 1, 0.5, 0 ) );
        #/
        
        /#
            record3dtext( "<dev string:x54>" + distancetotarget + "<dev string:x5b>" + score, point.origin, ( 1, 0.5, 0 ), "<dev string:x3e>", self );
        #/
        
        if ( score < bestscore )
        {
            bestscore = score;
            result = point;
        }
    }
    
    if ( isdefined( result ) )
    {
        return result;
    }
    
    return undefined;
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x4e1b650c, Offset: 0x3cd8
// Size: 0x54
function state_groundcombat_exit( params )
{
    self notify( #"end_attack_thread" );
    self notify( #"end_movement_thread" );
    self clearturrettarget();
    self setturretspinning( 0 );
}

// Namespace siegebot_theia
// Params 1
// Checksum 0xefb756ba, Offset: 0x3d38
// Size: 0x76
function get_player_vehicle( player )
{
    if ( isplayer( player ) )
    {
        if ( player.usingvehicle && isdefined( player.viewlockedentity ) && isvehicle( player.viewlockedentity ) )
        {
            return player.viewlockedentity;
        }
    }
    
    return undefined;
}

// Namespace siegebot_theia
// Params 0
// Checksum 0xd5a6d768, Offset: 0x3db8
// Size: 0x144
function get_player_and_vehicle_array()
{
    targets = level.players;
    vehicles = [];
    
    foreach ( player in level.players )
    {
        vehicle = get_player_vehicle( player );
        
        if ( isdefined( vehicle ) )
        {
            if ( !isdefined( vehicles ) )
            {
                vehicles = [];
            }
            else if ( !isarray( vehicles ) )
            {
                vehicles = array( vehicles );
            }
            
            vehicles[ vehicles.size ] = vehicle;
        }
    }
    
    targets = arraycombine( targets, vehicles, 0, 0 );
    return targets;
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x44418681, Offset: 0x3f08
// Size: 0x10c
function init_player_threat( player )
{
    index = player getentitynumber();
    
    if ( !isdefined( self.player_threat ) )
    {
        self.player_threat = [];
        
        for ( i = 0; i < 4 ; i++ )
        {
            self.player_threat[ self.player_threat.size ] = spawnstruct();
        }
    }
    
    if ( !isdefined( self.player_threat[ index ].damage ) || !isdefined( self.player_threat[ index ].tempboost ) || !isdefined( self.player_threat[ index ].tempboosttimeout ) )
    {
        reset_player_threat( player );
    }
}

// Namespace siegebot_theia
// Params 0
// Checksum 0xddc9b7fb, Offset: 0x4020
// Size: 0xea
function init_player_threat_all()
{
    callback::on_spawned( &init_player_threat, self );
    callback::on_player_killed( &init_player_threat, self );
    callback::on_laststand( &init_player_threat, self );
    
    foreach ( player in level.players )
    {
        self init_player_threat( player );
    }
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x6fe7bd61, Offset: 0x4118
// Size: 0x188
function reset_player_threat( player )
{
    index = player getentitynumber();
    mindamage = self.player_threat[ index ].damage;
    
    if ( !isdefined( mindamage ) )
    {
        mindamage = 1000000;
    }
    
    if ( self.player_threat.size > 0 )
    {
        foreach ( threat in self.player_threat )
        {
            if ( isdefined( threat.damage ) )
            {
                mindamage = min( mindamage, threat.damage );
            }
        }
    }
    else
    {
        mindamage = 0;
    }
    
    self.player_threat[ index ].damage = mindamage;
    self.player_threat[ index ].tempboost = 0;
    self.player_threat[ index ].tempboosttimeout = 0;
}

// Namespace siegebot_theia
// Params 2
// Checksum 0xb902752c, Offset: 0x42a8
// Size: 0x6c
function add_player_threat_damage( player, damage )
{
    index = player getentitynumber();
    self.player_threat[ index ].damage += damage;
}

// Namespace siegebot_theia
// Params 3
// Checksum 0xcb51b727, Offset: 0x4320
// Size: 0xd4
function add_player_threat_boost( player, boost, timeseconds )
{
    index = player getentitynumber();
    
    if ( self.player_threat[ index ].tempboosttimeout <= gettime() )
    {
        self.player_threat[ index ].tempboost = 0;
    }
    
    self.player_threat[ index ].tempboost += boost;
    self.player_threat[ index ].tempboosttimeout = gettime() + timeseconds * 1000;
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x2eb00ec5, Offset: 0x4400
// Size: 0x230
function get_player_threat( player )
{
    if ( !is_valid_target( player ) )
    {
        return;
    }
    
    timeignoreonspawn = 7;
    currenttime = gettime();
    
    if ( isdefined( player._spawn_time ) && player._spawn_time + timeignoreonspawn * 1000 > currenttime )
    {
        return;
    }
    
    index = player getentitynumber();
    
    if ( !isdefined( self.player_threat ) || !isdefined( self.player_threat[ index ] ) )
    {
        return;
    }
    
    threat = self.player_threat[ index ].damage;
    
    if ( self.player_threat[ index ].tempboosttimeout > gettime() )
    {
        threat += self.player_threat[ index ].tempboost;
    }
    
    if ( self.main_target === player )
    {
        threat += 1000;
    }
    
    if ( self vehseenrecently( player, 3 ) )
    {
        threat += 1000;
    }
    
    if ( player.health < 50 )
    {
        threat -= 800;
    }
    
    distancesqr = distance2dsquared( self.origin, player.origin );
    
    if ( distancesqr < 800 * 800 )
    {
        threat += 800;
    }
    else if ( distancesqr < 1500 * 1500 )
    {
        threat += 400;
    }
    
    return threat;
}

// Namespace siegebot_theia
// Params 0
// Checksum 0xb0f8f895, Offset: 0x4638
// Size: 0xe6
function update_target_player()
{
    best_threat = -1000000;
    self.main_target = undefined;
    
    foreach ( player in level.players )
    {
        threat = get_player_threat( player );
        
        if ( isdefined( threat ) && threat > best_threat )
        {
            best_threat = threat;
            self.main_target = player;
        }
    }
}

// Namespace siegebot_theia
// Params 1
// Checksum 0xf2d40e4e, Offset: 0x4728
// Size: 0x94
function shoulder_light_focus( target )
{
    if ( !isdefined( target ) )
    {
        self setturrettargetrelativeangles( ( 0, 0, 0 ), 3 );
        self setturrettargetrelativeangles( ( 0, 0, 0 ), 4 );
        return;
    }
    
    self vehicle_ai::setturrettarget( target, 3 );
    self vehicle_ai::setturrettarget( target, 4 );
}

// Namespace siegebot_theia
// Params 3
// Checksum 0xcf018020, Offset: 0x47c8
// Size: 0xc0
function debug_line_to_target( target, time, color )
{
    self endon( #"death" );
    point1 = self.origin;
    point2 = target.origin;
    
    if ( false )
    {
        stoptime = gettime() + time * 1000;
        
        while ( gettime() <= stoptime )
        {
            /#
                line( point1, point2, color, 1, 0, 3 );
            #/
            
            wait 0.05;
        }
    }
}

// Namespace siegebot_theia
// Params 1
// Checksum 0xaebd4631, Offset: 0x4890
// Size: 0x96
function pin_first_three_spikes_to_ground( delay )
{
    self endon( #"death" );
    wait delay;
    
    for ( i = 0; i < 3 && i < self.spikefaketargets.size ; i++ )
    {
        spike = self.spikefaketargets[ i ];
        spike pin_to_ground();
        wait 0.15;
    }
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x80ba572b, Offset: 0x4930
// Size: 0x3c0
function attack_thread_gun()
{
    self endon( #"death" );
    self endon( #"change_state" );
    self endon( #"end_attack_thread" );
    self notify( #"end_attack_thread_gun" );
    self endon( #"end_attack_thread_gun" );
    
    while ( true )
    {
        enemy = self.enemy;
        
        if ( !isdefined( enemy ) )
        {
            self setturrettargetrelativeangles( ( 0, 0, 0 ) );
            wait 0.4;
            continue;
        }
        
        if ( !enemy.allowdeath && !isplayer( enemy ) )
        {
            self setpersonalthreatbias( enemy, -2000, 8 );
            wait 0.4;
            continue;
        }
        
        distsq = distancesquared( enemy.origin, self.origin );
        
        if ( 200 * 200 < distsq && ( isplayer( enemy ) || self vehcansee( enemy ) && distsq < 2000 * 2000 ) )
        {
            self setpersonalthreatbias( enemy, 1000, 1 );
        }
        else
        {
            self setpersonalthreatbias( enemy, -1000, 1 );
        }
        
        self vehicle_ai::setturrettarget( enemy, 0 );
        self vehicle_ai::setturrettarget( enemy, 1 );
        self shoulder_light_focus( enemy );
        gun_on_target = gettime();
        self setturretspinning( 1 );
        
        while ( isdefined( enemy ) && !self.gunner1ontarget && vehicle_ai::timesince( gun_on_target ) < 2 )
        {
            wait 0.4;
        }
        
        if ( !isdefined( enemy ) )
        {
            self setturretspinning( 0 );
            continue;
        }
        
        attack_start = gettime();
        
        while ( isdefined( enemy ) && enemy === self.enemy && self vehseenrecently( enemy, 1 ) && vehicle_ai::timesince( attack_start ) < 5 )
        {
            self vehicle_ai::fire_for_time( 1 + randomfloat( 0.4 ), 1 );
            
            if ( isdefined( enemy ) && isplayer( enemy ) )
            {
                wait 0.6 + randomfloat( 0.2 );
            }
            
            wait 0.1;
        }
        
        self setturretspinning( 0 );
        wait 0.1;
    }
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x9debfe80, Offset: 0x4cf8
// Size: 0x7fc
function attack_thread_rocket()
{
    self endon( #"death" );
    self endon( #"change_state" );
    self endon( #"end_attack_thread" );
    self notify( #"end_attack_thread_rocket" );
    self endon( #"end_attack_thread_rocket" );
    
    while ( true )
    {
        enemy = self.enemy;
        
        if ( !isdefined( enemy ) )
        {
            wait 0.4;
            continue;
        }
        
        if ( vehicle_ai::iscooldownready( "spike_on_ground", 2 ) && self.rocketaim !== 1 )
        {
            self toggle_rocketaim( 1 );
        }
        
        if ( !vehicle_ai::iscooldownready( "spike_on_ground" ) )
        {
            wait 0.4;
            continue;
        }
        
        primaryenemy = enemy;
        targets = getaiteamarray( "allies" );
        targets = arraycombine( targets, level.players, 0, 0 );
        dirtoprimaryenemy = vectornormalize( ( ( primaryenemy.origin - self.origin )[ 0 ], ( primaryenemy.origin - self.origin )[ 1 ], 0 ) );
        bestclosescore = 0;
        besttarget = undefined;
        
        foreach ( target in targets )
        {
            if ( target isnotarget() || target == primaryenemy )
            {
                continue;
            }
            
            dirtotarget = vectornormalize( ( ( target.origin - self.origin )[ 0 ], ( target.origin - self.origin )[ 1 ], 0 ) );
            angledot = vectordot( dirtotarget, dirtoprimaryenemy );
            
            if ( angledot < 0.2 )
            {
                continue;
            }
            
            distanceselftotargetsqr = distance2dsquared( target.origin, self.origin );
            
            if ( distanceselftotargetsqr < 400 * 400 || distanceselftotargetsqr > 1200 * 1200 )
            {
                continue;
            }
            
            closetargetscore = spike_score( target );
            closetargetscore += 1 - angledot;
            
            if ( isplayer( target ) )
            {
                closetargetscore += 0.5;
            }
            
            distanceprimaryenemytotargetsqr = distance2dsquared( target.origin, primaryenemy.origin );
            
            if ( distanceprimaryenemytotargetsqr < 200 * 200 )
            {
                closetargetscore -= 0.3;
            }
            
            if ( bestclosescore <= closetargetscore )
            {
                bestclosescore = closetargetscore;
                besttarget = target;
            }
        }
        
        enemy = besttarget;
        
        if ( isalive( enemy ) )
        {
            if ( false )
            {
                self thread debug_line_to_target( enemy, 5, ( 1, 0, 0 ) );
            }
            
            turretorigin = self gettagorigin( "tag_gunner_flash2" );
            disttoenemy = distance2d( self.origin, enemy.origin );
            shootheight = math::clamp( disttoenemy * 0.35, 100, 350 );
            points = generatepointsaroundcenter( enemy.origin + ( 0, 0, shootheight ), 300, 80, 50 );
            pindelay = mapfloat( 300, 700, 0.1, 1, disttoenemy );
            spike = self.spikefaketargets[ 0 ];
            spike.origin = points[ 0 ];
            self setgunnertargetent( spike, ( 0, 0, 0 ), 1 );
            rocket_on_target = gettime();
            
            while ( !self.gunner2ontarget && vehicle_ai::timesince( rocket_on_target ) < 2 )
            {
                wait 0.4;
            }
            
            self thread pin_first_three_spikes_to_ground( pindelay );
            
            for ( i = 0; i < 3 && i < self.spikefaketargets.size && i < points.size ; i++ )
            {
                spike = self.spikefaketargets[ i ];
                spike.origin = points[ i ];
                self setgunnertargetent( spike, ( 0, 0, 0 ), 1 );
                self fireweapon( 2, enemy );
                vehicle_ai::cooldown( "spike_on_ground", randomfloatrange( 6, 10 ) );
                
                if ( false )
                {
                    /#
                        debugstar( spike.origin, 200, ( 1, 0, 0 ) );
                    #/
                    
                    /#
                        circle( spike.origin, 150, ( 1, 0, 0 ), 0, 1, 200 );
                    #/
                }
                
                wait 0.1;
            }
            
            wait 0.5;
            self setturrettargetrelativeangles( ( 0, 0, 0 ), 2 );
            self toggle_rocketaim( 0 );
            continue;
        }
        
        wait 0.4;
    }
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x571a24a9, Offset: 0x5500
// Size: 0x2c
function toggle_rocketaim( is_aiming )
{
    self.rocketaim = is_aiming;
    self locomotion_start();
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x67407689, Offset: 0x5538
// Size: 0x54
function locomotion_start()
{
    if ( self.rocketaim === 1 )
    {
        locomotion = "locomotion@movement";
    }
    else
    {
        locomotion = "locomotion_rocketup@movement";
    }
    
    self asmrequestsubstate( locomotion );
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x299ccad7, Offset: 0x5598
// Size: 0x1b0
function get_strong_target()
{
    mindist = 400;
    ai_array = getaiteamarray( "allies" );
    ai_array = array::randomize( ai_array );
    
    foreach ( ai in ai_array )
    {
        awayfromplayer = 1;
        
        foreach ( player in level.players )
        {
            if ( is_valid_target( player ) && distance2dsquared( ai.origin, player.origin ) < mindist * mindist )
            {
                awayfromplayer = 0;
                break;
            }
        }
        
        if ( !awayfromplayer )
        {
        }
    }
    
    return undefined;
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x46579eb8, Offset: 0x5750
// Size: 0x2e8
function movement_thread()
{
    self endon( #"death" );
    self endon( #"change_state" );
    self notify( #"end_movement_thread" );
    self endon( #"end_movement_thread" );
    
    while ( true )
    {
        self update_target_player();
        enemy = self.main_target;
        
        if ( level.players.size <= 1 && vehicle_ai::iscooldownready( "ignore_player" ) )
        {
            vehicle_ai::cooldown( "ignore_player", 12 );
            enemy = get_strong_target();
            
            foreach ( player in level.players )
            {
                self setpersonalthreatbias( player, -1000, 2 );
            }
        }
        
        if ( !isdefined( enemy ) )
        {
            enemy = self.enemy;
        }
        
        if ( !isdefined( enemy ) )
        {
            wait 0.05;
            continue;
        }
        
        self.current_pathto_pos = self getnextmoveposition( enemy );
        self.current_enemy_pos = enemy.origin;
        self setspeed( self.settings.defaultmovespeed );
        foundpath = self setvehgoalpos( self.current_pathto_pos, 0, 1 );
        
        if ( foundpath )
        {
            self setlookatent( enemy );
            self setbrake( 0 );
            locomotion_start();
            self thread path_update_interrupt();
            self vehicle_ai::waittill_pathing_done();
            self notify( #"end_path_interrupt" );
            self cancelaimove();
            self clearvehgoalpos();
            self setbrake( 1 );
        }
        
        wait 0.05;
    }
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x5f1205e5, Offset: 0x5a40
// Size: 0xb4
function path_update_interrupt()
{
    self endon( #"death" );
    self endon( #"change_state" );
    self endon( #"end_movement_thread" );
    self notify( #"end_path_interrupt" );
    self endon( #"end_path_interrupt" );
    
    while ( true )
    {
        if ( isdefined( self.current_enemy_pos ) && isdefined( self.main_target ) )
        {
            if ( distance2dsquared( self.current_enemy_pos, self.main_target.origin ) > 200 * 200 )
            {
                self notify( #"near_goal" );
            }
        }
        
        wait 0.8;
    }
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x66e0bcc0, Offset: 0x5b00
// Size: 0x6c6
function getnextmoveposition( enemy )
{
    if ( self.goalforced )
    {
        return self.goalpos;
    }
    
    halfheight = 400;
    spacing = 80;
    queryorigin = self.origin;
    
    if ( isdefined( enemy ) && self canpath( self.origin, enemy.origin ) )
    {
        queryorigin = enemy.origin;
    }
    
    queryresult = positionquery_source_navigation( queryorigin, 0, self.settings.engagementdistmax + 200, halfheight, spacing, self );
    
    if ( isdefined( enemy ) )
    {
        positionquery_filter_sight( queryresult, enemy.origin, self geteye() - self.origin, self, 0, enemy );
        vehicle_ai::positionquery_filter_engagementdist( queryresult, enemy, self.settings.engagementdistmin, self.settings.engagementdistmax );
    }
    
    positionquery_filter_distancetogoal( queryresult, self );
    vehicle_ai::positionquery_filter_outofgoalanchor( queryresult );
    forward = anglestoforward( self.angles );
    
    if ( isdefined( enemy ) )
    {
        enemydir = vectornormalize( enemy.origin - self.origin );
        forward = vectornormalize( forward + 5 * enemydir );
    }
    
    foreach ( point in queryresult.data )
    {
        if ( distance2dsquared( self.origin, point.origin ) < 300 * 300 )
        {
            /#
                if ( !isdefined( point._scoredebug ) )
                {
                    point._scoredebug = [];
                }
                
                point._scoredebug[ "<dev string:x64>" ] = -700;
            #/
            
            point.score += -700;
        }
        
        if ( isdefined( enemy ) )
        {
            /#
                if ( !isdefined( point._scoredebug ) )
                {
                    point._scoredebug = [];
                }
                
                point._scoredebug[ "<dev string:x73>" ] = point.distawayfromengagementarea * -1;
            #/
            
            point.score += point.distawayfromengagementarea * -1;
            
            if ( !point.visibility )
            {
                /#
                    if ( !isdefined( point._scoredebug ) )
                    {
                        point._scoredebug = [];
                    }
                    
                    point._scoredebug[ "<dev string:x82>" ] = -600;
                #/
                
                point.score += -600;
            }
        }
        
        pointdirection = vectornormalize( point.origin - self.origin );
        factor = vectordot( pointdirection, forward );
        
        if ( factor > 0.7 )
        {
            /#
                if ( !isdefined( point._scoredebug ) )
                {
                    point._scoredebug = [];
                }
                
                point._scoredebug[ "<dev string:x8d>" ] = 600;
            #/
            
            point.score += 600;
            continue;
        }
        
        if ( factor > 0 )
        {
            /#
                if ( !isdefined( point._scoredebug ) )
                {
                    point._scoredebug = [];
                }
                
                point._scoredebug[ "<dev string:x8d>" ] = 0;
            #/
            
            point.score += 0;
            continue;
        }
        
        if ( factor > -0.5 )
        {
            /#
                if ( !isdefined( point._scoredebug ) )
                {
                    point._scoredebug = [];
                }
                
                point._scoredebug[ "<dev string:x8d>" ] = -600;
            #/
            
            point.score += -600;
            continue;
        }
        
        /#
            if ( !isdefined( point._scoredebug ) )
            {
                point._scoredebug = [];
            }
            
            point._scoredebug[ "<dev string:x8d>" ] = -1200;
        #/
        
        point.score += -1200;
    }
    
    vehicle_ai::positionquery_postprocess_sortscore( queryresult );
    self vehicle_ai::positionquery_debugscores( queryresult );
    
    if ( queryresult.data.size == 0 )
    {
        return self.origin;
    }
    
    return queryresult.data[ 0 ].origin;
}

// Namespace siegebot_theia
// Params 3
// Checksum 0x43de2bcf, Offset: 0x61d0
// Size: 0x82, Type: bool
function _sort_by_distance2d( left, right, point )
{
    distancesqrtoleft = distance2dsquared( left.origin, point );
    distancesqrtoright = distance2dsquared( right.origin, point );
    return distancesqrtoleft > distancesqrtoright;
}

// Namespace siegebot_theia
// Params 2
// Checksum 0x7d076f1b, Offset: 0x6260
// Size: 0xcc, Type: bool
function too_close_to_high_ground( point, mindistance )
{
    foreach ( highground in self.jump.highgrounds )
    {
        if ( distance2dsquared( point, highground.origin ) < mindistance * mindistance )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace siegebot_theia
// Params 6
// Checksum 0xd1e51f8, Offset: 0x6338
// Size: 0x8e6
function get_jumpon_target( distancelimitmin, distancelimitmax, idealdist, includingai, minanglediffcos, mustjump )
{
    targets = level.players;
    
    if ( includingai === 1 )
    {
        targets = arraycombine( targets, getaiteamarray( "allies" ), 0, 0 );
        targets = array::merge_sort( targets, &_sort_by_distance2d, self.origin );
    }
    
    angles = ( 0, self.angles[ 1 ], 0 );
    forward = anglestoforward( angles );
    besttarget = undefined;
    bestscore = 1000000;
    mindistawayfromhighground = 300;
    maxdistawayfromarenacenter = 1800;
    
    /#
        recordstar( self.origin, ( 1, 0.5, 0 ) );
    #/
    
    /#
        record3dtext( "<dev string:x9b>", self.origin, ( 1, 0.5, 0 ), "<dev string:x3e>", self );
    #/
    
    foreach ( target in targets )
    {
        if ( !is_valid_target( target ) || !target.allowdeath || isairborne( target ) )
        {
            continue;
        }
        
        if ( distance2dsquared( self.arena_center, target.origin ) > maxdistawayfromarenacenter * maxdistawayfromarenacenter )
        {
            /#
                recordstar( target.origin, ( 0, 0.5, 1 ) );
            #/
            
            /#
                record3dtext( "<dev string:xaa>" + distance2d( self.arena_center, target.origin ), target.origin, ( 0, 0.5, 1 ), "<dev string:x3e>", self );
            #/
            
            continue;
        }
        
        if ( too_close_to_high_ground( target.origin, mindistawayfromhighground ) )
        {
            /#
                recordstar( target.origin, ( 0, 0.5, 1 ) );
            #/
            
            /#
                record3dtext( "<dev string:xc0>", target.origin, ( 0, 0.5, 1 ), "<dev string:x3e>", self );
            #/
            
            continue;
        }
        
        distancetotarget = distance2d( target.origin, self.origin );
        
        if ( distancetotarget < distancelimitmin || distancelimitmax < distancetotarget )
        {
            /#
                recordstar( target.origin, ( 1, 0.5, 0 ) );
            #/
            
            /#
                record3dtext( "<dev string:x45>" + distancetotarget, target.origin, ( 1, 0.5, 0 ), "<dev string:x3e>", self );
            #/
            
            continue;
        }
        
        vectortotarget = ( ( target.origin - self.origin )[ 0 ], ( target.origin - self.origin )[ 1 ], 0 );
        vectortotarget /= distancetotarget;
        
        if ( isdefined( minanglediffcos ) && vectordot( forward, vectortotarget ) < minanglediffcos )
        {
            continue;
        }
        
        score = abs( distancetotarget - idealdist );
        
        if ( score < 200 )
        {
            score = randomfloat( 200 );
        }
        
        /#
            recordstar( target.origin, ( 1, 0.5, 0 ) );
        #/
        
        /#
            record3dtext( "<dev string:x54>" + distancetotarget + "<dev string:x5b>" + score, target.origin, ( 1, 0.5, 0 ), "<dev string:x3e>", self );
        #/
        
        if ( isplayer( target ) && !isvehicle( target ) )
        {
            minradius = 0;
            maxradius = 300;
        }
        else
        {
            minradius = 200;
            maxradius = 400;
        }
        
        queryresult = positionquery_source_navigation( target.origin, minradius, maxradius, 500, self.radius * 0.5, self.radius * 1.1 );
        
        if ( queryresult.data.size > 0 )
        {
            element = queryresult.data[ 0 ];
            
            if ( score < bestscore )
            {
                bestscore = score;
                besttarget = element;
            }
        }
    }
    
    if ( isdefined( besttarget ) )
    {
        return besttarget.origin;
    }
    
    if ( mustjump === 0 )
    {
        return undefined;
    }
    
    queryresult = positionquery_source_navigation( self.arena_center, 100, 1300, 500, self.radius, self.radius * 1.1 );
    assert( queryresult.data.size > 0 );
    pointlist = array::randomize( queryresult.data );
    
    foreach ( point in pointlist )
    {
        distancetotargetsqr = distance2dsquared( point.origin, self.origin );
        
        if ( distancelimitmin * distancelimitmin < distancetotargetsqr && distancetotargetsqr < distancelimitmax * distancelimitmax && !too_close_to_high_ground( point.origin, mindistawayfromhighground ) )
        {
            return point.origin;
        }
    }
    
    return self.arena_center;
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x522f1823, Offset: 0x6c28
// Size: 0x94
function stopmovementandsetbrake()
{
    self notify( #"end_movement_thread" );
    self notify( #"near_goal" );
    self cancelaimove();
    self clearvehgoalpos();
    self clearturrettarget();
    self clearlookatent();
    self setbrake( 1 );
}

// Namespace siegebot_theia
// Params 2
// Checksum 0xc48a11b8, Offset: 0x6cc8
// Size: 0x244
function face_target( position, targetanglediff )
{
    if ( !isdefined( targetanglediff ) )
    {
        targetanglediff = 30;
    }
    
    v_to_enemy = ( ( position - self.origin )[ 0 ], ( position - self.origin )[ 1 ], 0 );
    v_to_enemy = vectornormalize( v_to_enemy );
    goalangles = vectortoangles( v_to_enemy );
    anglediff = absangleclamp180( self.angles[ 1 ] - goalangles[ 1 ] );
    
    if ( anglediff <= targetanglediff )
    {
        return;
    }
    
    self setlookatorigin( position );
    self setturrettargetvec( position );
    self locomotion_start();
    angleadjustingstart = gettime();
    
    while ( anglediff > targetanglediff && vehicle_ai::timesince( angleadjustingstart ) < 4 )
    {
        if ( false )
        {
            /#
                line( self.origin, position, ( 1, 0, 1 ), 1, 0, 5 );
            #/
        }
        
        anglediff = absangleclamp180( self.angles[ 1 ] - goalangles[ 1 ] );
        wait 0.05;
    }
    
    self clearvehgoalpos();
    self clearlookatent();
    self clearturrettarget();
    self cancelaimove();
}

// Namespace siegebot_theia
// Params 14
// Checksum 0x260e6158, Offset: 0x6f18
// Size: 0x1e8
function theia_callback_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    if ( !isplayer( eattacker ) )
    {
        idamage = 0;
        return idamage;
    }
    
    idamage = self killstreaks::ondamageperweapon( "siegebot_theia", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1 );
    
    if ( idamage == 0 )
    {
        return 0;
    }
    
    newdamagelevel = vehicle::should_update_damage_fx_level( self.health, idamage, self.healthdefault );
    
    if ( newdamagelevel > self.damagelevel )
    {
        self.newdamagelevel = newdamagelevel;
    }
    
    if ( self.newdamagelevel > self.damagelevel && pain_canenter() )
    {
        self.damagelevel = self.newdamagelevel;
        self notify( #"pain" );
        vehicle::set_damage_fx_level( self.damagelevel );
        
        if ( self.damagelevel >= 2 )
        {
            self vehicle::toggle_lights_group( 1, 0 );
        }
    }
    
    return idamage;
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x40118291, Offset: 0x7108
// Size: 0x30c
function attack_javelin()
{
    if ( level.players.size < 1 )
    {
        return;
    }
    
    enemy = array::random( level.players );
    
    if ( !isdefined( enemy ) )
    {
        return;
    }
    
    forward = anglestoforward( self.angles );
    shootpos = self.origin + forward * 200 + ( 0, 0, 500 );
    self asmrequestsubstate( "javelin@stationary" );
    self waittill( #"fire_javelin" );
    level notify( #"theia_preparing_javelin_attack", enemy );
    current_weapon = self seatgetweapon( 0 );
    weapon = getweapon( "siegebot_javelin_turret" );
    self thread javeline_incoming( weapon );
    self setvehweapon( weapon );
    self thread vehicle_ai::javelin_losetargetatrighttime( enemy );
    self fireweapon( 0, enemy );
    self vehicle_ai::waittill_asm_complete( "javelin@stationary", 3 );
    self setvehweapon( current_weapon );
    shootpos = self.origin + forward * 500;
    self setturrettargetvec( shootpos );
    self util::waittill_any_timeout( 2, "turret_on_target" );
    self clearturrettarget();
    
    if ( isdefined( enemy ) && !self vehcansee( enemy ) )
    {
        forward = anglestoforward( self.angles );
        aimpos = self.origin + forward * 1000;
        self setturrettargetvec( aimpos );
        msg = self util::waittill_any_timeout( 3, "turret_on_target" );
        self clearturrettarget();
    }
    
    self locomotion_start();
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x81e15c6e, Offset: 0x7420
// Size: 0x124
function javeline_incoming( projectile )
{
    self endon( #"entityshutdown" );
    self endon( #"death" );
    self waittill( #"weapon_fired", projectile );
    distance = 1400;
    alias = "prj_javelin_incoming";
    wait 3;
    
    if ( !isdefined( projectile ) )
    {
        return;
    }
    
    while ( isdefined( projectile ) && isdefined( projectile.origin ) )
    {
        if ( isdefined( self.enemy ) && isdefined( self.enemy.origin ) )
        {
            projectiledistance = distancesquared( projectile.origin, self.enemy.origin );
            
            if ( projectiledistance <= distance * distance )
            {
                projectile playsound( alias );
                return;
            }
        }
        
        wait 0.05;
    }
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x602f4710, Offset: 0x7550
// Size: 0x13c
function init_fake_targets()
{
    count = 6;
    
    if ( !isdefined( self.spikefaketargets ) || self.spikefaketargets.size < 1 )
    {
        self.spikefaketargets = [];
        
        for ( i = 0; i < count ; i++ )
        {
            newfaketarget = spawn( "script_origin", self.origin );
            
            if ( !isdefined( self.spikefaketargets ) )
            {
                self.spikefaketargets = [];
            }
            else if ( !isarray( self.spikefaketargets ) )
            {
                self.spikefaketargets = array( self.spikefaketargets );
            }
            
            self.spikefaketargets[ self.spikefaketargets.size ] = newfaketarget;
        }
    }
    
    if ( !isdefined( self.faketargetent ) )
    {
        self.faketargetent = spawn( "script_origin", self.origin );
    }
}

// Namespace siegebot_theia
// Params 0
// Checksum 0xfcdbccb1, Offset: 0x7698
// Size: 0xa8
function pin_to_ground()
{
    trace = bullettrace( self.origin, self.origin + ( 0, 0, -800 ), 0, self );
    
    if ( trace[ "fraction" ] < 1 )
    {
        self.origin = trace[ "position" ] + ( 0, 0, -20 );
        return;
    }
    
    self.origin += ( 0, 0, -500 );
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x1b841b2, Offset: 0x7748
// Size: 0x1ba
function pin_spike_to_ground()
{
    self endon( #"death" );
    wait 0.1;
    spiketargets = array::randomize( self.spikefaketargets );
    
    foreach ( target in spiketargets )
    {
        target pin_to_ground();
        wait randomfloatrange( 0.05, 0.1 );
    }
    
    if ( false )
    {
        foreach ( spike in spiketargets )
        {
            /#
                debugstar( spike.origin, 200, ( 1, 0, 0 ) );
            #/
            
            /#
                circle( spike.origin, 150, ( 1, 0, 0 ), 0, 1, 200 );
            #/
        }
    }
}

// Namespace siegebot_theia
// Params 1
// Checksum 0xd3be44e4, Offset: 0x7910
// Size: 0x98
function spike_score( target )
{
    score = 1;
    
    if ( target isnotarget() )
    {
        score = 0.2;
    }
    else if ( !target.allowdeath )
    {
        score = 0.4;
    }
    else if ( isairborne( target ) )
    {
        score = 0.2;
    }
    
    return score;
}

// Namespace siegebot_theia
// Params 3
// Checksum 0x5015b85d, Offset: 0x79b0
// Size: 0x11c
function spike_group_score( target, targetlist, radius )
{
    closetargetscore = spike_score( target );
    
    foreach ( othertarget in targetlist )
    {
        closeenough = distance2dsquared( target.origin, othertarget.origin ) < radius * radius;
        
        if ( closeenough )
        {
            closetargetscore += spike_score( othertarget );
        }
    }
    
    return closetargetscore;
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x68a330af, Offset: 0x7ad8
// Size: 0x5cc
function attack_spike_minefield()
{
    spikecoverradius = 600;
    randomscale = 40;
    init_fake_targets();
    forward = anglestoforward( self.angles );
    self setturrettargetvec( self.origin + forward * 1000 );
    self util::waittill_any_timeout( 2, "turret_on_target" );
    forward = anglestoforward( self.angles );
    targets = getaiteamarray( "allies" );
    targets = arraycombine( targets, level.players, 0, 0 );
    bestclosescore = 0;
    besttarget = undefined;
    
    foreach ( target in targets )
    {
        if ( target isnotarget() || isairborne( target ) )
        {
            continue;
        }
        
        distanceselftotargetsqr = distance2dsquared( target.origin, self.origin );
        
        if ( distanceselftotargetsqr < 500 * 500 || distanceselftotargetsqr > 2100 * 2100 )
        {
            continue;
        }
        
        dirtotarget = ( ( target.origin - self.origin )[ 0 ], ( target.origin - self.origin )[ 1 ], 0 );
        
        if ( vectordot( dirtotarget, forward ) < 0.1 )
        {
            continue;
        }
        
        closetargetscore = spike_group_score( target, targets, spikecoverradius );
        
        if ( bestclosescore <= closetargetscore )
        {
            bestclosescore = closetargetscore;
            besttarget = target;
        }
    }
    
    if ( !isdefined( besttarget ) )
    {
        besttarget = array::random( generatepointsaroundcenter( self.arena_center, 2000, 200 ) );
    }
    else
    {
        besttarget = besttarget.origin;
    }
    
    if ( false )
    {
        /#
            debugstar( besttarget, 200, ( 1, 0, 0 ) );
        #/
        
        /#
            circle( besttarget, spikecoverradius, ( 1, 0, 0 ), 0, 1, 200 );
        #/
    }
    
    level notify( #"theia_preparing_spike_attack", besttarget );
    targetorigin = ( besttarget[ 0 ], besttarget[ 1 ], 0 ) + ( 0, 0, self.origin[ 2 ] );
    targetpoints = generatepointsaroundcenter( targetorigin, 1200, 120 );
    numofspikeassigned = 0;
    
    for ( i = 0; i < self.spikefaketargets.size && i < targetpoints.size ; i++ )
    {
        spike = self.spikefaketargets[ i ];
        spike.origin = targetpoints[ i ];
        numofspikeassigned++;
    }
    
    self asmrequestsubstate( "arm_rocket@stationary" );
    self waittill( #"fire_spikes" );
    
    for ( i = 0; i < numofspikeassigned ; i++ )
    {
        spike = self.spikefaketargets[ i ];
        self setgunnertargetent( spike, ( 0, 0, 0 ), 1 );
        self fireweapon( 2 );
        wait 0.05;
    }
    
    self thread pin_spike_to_ground();
    self cleargunnertarget( 1 );
    self clearturrettarget();
    self vehicle_ai::waittill_asm_complete( "arm_rocket@stationary", 3 );
    self locomotion_start();
}

// Namespace siegebot_theia
// Params 3
// Checksum 0x137136d8, Offset: 0x80b0
// Size: 0x1e4
function delay_target_toenemy_thread( point, enemy, timetohit )
{
    offset = ( 0, 0, 10 );
    self.faketargetent unlink();
    
    if ( distancesquared( self.faketargetent.origin, enemy.origin ) > 20 * 20 )
    {
        self.faketargetent.origin = point;
        self vehicle_ai::setturrettarget( self.faketargetent, 1 );
        self util::waittill_any_timeout( 2, "turret_on_target" );
        timestart = gettime();
        
        while ( gettime() < timestart + timetohit * 1000 )
        {
            self.faketargetent.origin = lerpvector( point, enemy.origin + offset, ( gettime() - timestart ) / timetohit * 1000 );
            
            if ( false )
            {
                /#
                    debugstar( self.faketargetent.origin, 100, ( 0, 1, 0 ) );
                #/
            }
            
            wait 0.05;
        }
    }
    
    self.faketargetent.origin = enemy.origin + offset;
    wait 0.05;
    self.faketargetent linkto( enemy );
}

// Namespace siegebot_theia
// Params 1
// Checksum 0x7aada0a0, Offset: 0x82a0
// Size: 0xd8, Type: bool
function is_valid_target( target )
{
    if ( isdefined( target.ignoreme ) && target.ignoreme || target.health <= 0 )
    {
        return false;
    }
    else if ( isplayer( target ) && target laststand::player_is_in_laststand() )
    {
        return false;
    }
    else if ( target isnotarget() || issentient( target ) && !isalive( target ) )
    {
        return false;
    }
    
    return true;
}

// Namespace siegebot_theia
// Params 0
// Checksum 0xe14860e4, Offset: 0x8380
// Size: 0x1b0
function get_enemy()
{
    if ( isdefined( self.enemy ) && is_valid_target( self.enemy ) )
    {
        return self.enemy;
    }
    
    targets = getaiteamarray( "allies" );
    targets = arraycombine( targets, level.players, 0, 0 );
    validtargets = [];
    
    foreach ( target in targets )
    {
        if ( is_valid_target( target ) )
        {
            if ( !isdefined( validtargets ) )
            {
                validtargets = [];
            }
            else if ( !isarray( validtargets ) )
            {
                validtargets = array( validtargets );
            }
            
            validtargets[ validtargets.size ] = target;
        }
    }
    
    targets = array::merge_sort( validtargets, &_sort_by_distance2d, self.origin );
    return targets[ 0 ];
}

// Namespace siegebot_theia
// Params 0
// Checksum 0x8338f27, Offset: 0x8538
// Size: 0x4cc
function attack_minigun_sweep()
{
    duration = 4;
    interval = 1;
    self.turretrotscale = 0.4;
    self clearturrettarget();
    self cleargunnertarget( 1 );
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 0 );
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 1 );
    self asmrequestsubstate( "sweep@gun" );
    self waittill( #"barrelspin_start" );
    self clientfield::set( "sarah_minigun_spin", 1 );
    self setturretspinning( 1 );
    self waittill( #"barrelspin_loop" );
    enemy = get_enemy();
    vectorfromenemy = vectornormalize( ( ( self.origin - enemy.origin )[ 0 ], ( self.origin - enemy.origin )[ 1 ], 0 ) );
    position = enemy.origin + vectorfromenemy * 500;
    stoptime = gettime() + duration * 1000;
    self thread vehicle_ai::fire_for_time( duration * 2, 1 );
    
    while ( gettime() < stoptime )
    {
        enemy = get_enemy();
        v_gunner_barrel1 = self gettagorigin( "tag_gunner_flash1" );
        v_bullet_trace_end = enemy.origin + ( 0, 0, 30 );
        trace = bullettrace( v_gunner_barrel1, v_bullet_trace_end, 1, enemy );
        
        if ( trace[ "fraction" ] == 1 )
        {
            self getperfectinfo( enemy, 1 );
        }
        else if ( !isplayer( enemy ) )
        {
            self setpersonalthreatbias( enemy, -2000, 3 );
        }
        
        if ( !enemy.allowdeath && !isplayer( enemy ) )
        {
            self setpersonalthreatbias( enemy, -900, 8 );
        }
        
        self vehicle_ai::setturrettarget( enemy, 0 );
        
        if ( isplayer( enemy ) )
        {
            vectorfromenemy = vectornormalize( ( ( self.origin - enemy.origin )[ 0 ], ( self.origin - enemy.origin )[ 1 ], 0 ) );
            self delay_target_toenemy_thread( enemy.origin + vectorfromenemy * 500, enemy, 0.7 );
        }
        else
        {
            self vehicle_ai::setturrettarget( enemy, 1 );
        }
        
        self util::waittill_any_timeout( interval, "enemy" );
    }
    
    self setturretspinning( 0 );
    self notify( #"fire_stop" );
    self locomotion_start();
    self waittill( #"barrelspin_end" );
    self clientfield::set( "sarah_minigun_spin", 0 );
    self.turretrotscale = 1;
    wait 0.2;
}

