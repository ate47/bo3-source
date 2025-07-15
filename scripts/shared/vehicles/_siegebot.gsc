#using scripts/codescripts/struct;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/array_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/math_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons/_spike_charge_siegebot;

#namespace siegebot;

// Namespace siegebot
// Params 0, eflags: 0x2
// Checksum 0xe902de76, Offset: 0x498
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "siegebot", &__init__, undefined, undefined );
}

// Namespace siegebot
// Params 0
// Checksum 0xe10f2703, Offset: 0x4d8
// Size: 0x2c
function __init__()
{
    vehicle::add_main_callback( "siegebot", &siegebot_initialize );
}

#using_animtree( "generic" );

// Namespace siegebot
// Params 0
// Checksum 0x34518660, Offset: 0x510
// Size: 0x3d4
function siegebot_initialize()
{
    self useanimtree( #animtree );
    blackboard::createblackboardforentity( self );
    self blackboard::registervehicleblackboardattributes();
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    target_set( self, ( 0, 0, 84 ) );
    self enableaimassist();
    self setneargoalnotifydist( 40 );
    self.fovcosine = 0.5;
    self.fovcosinebusy = 0.5;
    self.maxsightdistsqrd = 10000 * 10000;
    assert( isdefined( self.scriptbundlesettings ) );
    self.settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    self.goalradius = 9999999;
    self.goalheight = 5000;
    self setgoal( self.origin, 0, self.goalradius, self.goalheight );
    self.overridevehicledamage = &siegebot_callback_damage;
    self siegebot_update_difficulty();
    self setgunnerturretontargetrange( 0, self.settings.gunner_turret_on_target_range );
    self asmrequestsubstate( "locomotion@movement" );
    
    if ( self.vehicletype === "spawner_enemy_boss_siegebot_zombietron" )
    {
        self asmsetanimationrate( 0.5 );
        self hidepart( "tag_turret_canopy_animate" );
        self hidepart( "tag_turret_panel_01_d0" );
        self hidepart( "tag_turret_panel_02_d0" );
        self hidepart( "tag_turret_panel_03_d0" );
        self hidepart( "tag_turret_panel_04_d0" );
        self hidepart( "tag_turret_panel_05_d0" );
    }
    else if ( self.vehicletype == "zombietron_veh_siegebot" )
    {
        self asmsetanimationrate( 1.429 );
    }
    
    self initjumpstruct();
    
    if ( isdefined( level.vehicle_initializer_cb ) )
    {
        [[ level.vehicle_initializer_cb ]]( self );
    }
    
    self.ignorefirefly = 1;
    self.ignoredecoy = 1;
    self vehicle_ai::initthreatbias();
    self thread vehicle_ai::target_hijackers();
    
    if ( !sessionmodeismultiplayergame() )
    {
        defaultrole();
    }
}

// Namespace siegebot
// Params 0
// Checksum 0x1d50b3ce, Offset: 0x8f0
// Size: 0xa8
function siegebot_update_difficulty()
{
    value = gameskill::get_general_difficulty_level();
    scale_up = mapfloat( 0, 9, 0.8, 2, value );
    scale_down = mapfloat( 0, 9, 1, 0.5, value );
    self.difficulty_scale_up = scale_up;
    self.difficulty_scale_down = scale_down;
}

// Namespace siegebot
// Params 0
// Checksum 0x77726ee1, Offset: 0x9a0
// Size: 0x2ac
function defaultrole()
{
    self vehicle_ai::init_state_machine_for_role( "default" );
    self vehicle_ai::get_state_callbacks( "combat" ).update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks( "combat" ).exit_func = &state_combat_exit;
    self vehicle_ai::get_state_callbacks( "driving" ).update_func = &siegebot_driving;
    self vehicle_ai::get_state_callbacks( "death" ).update_func = &state_death_update;
    self vehicle_ai::get_state_callbacks( "pain" ).update_func = &pain_update;
    self vehicle_ai::get_state_callbacks( "emped" ).enter_func = &emped_enter;
    self vehicle_ai::get_state_callbacks( "emped" ).update_func = &emped_update;
    self vehicle_ai::get_state_callbacks( "emped" ).exit_func = &emped_exit;
    self vehicle_ai::get_state_callbacks( "emped" ).reenter_func = &emped_reenter;
    self vehicle_ai::add_state( "jump", &state_jump_enter, &state_jump_update, &state_jump_exit );
    vehicle_ai::add_utility_connection( "combat", "jump", &state_jump_can_enter );
    vehicle_ai::add_utility_connection( "jump", "combat" );
    self vehicle_ai::add_state( "unaware", undefined, &state_unaware_update, undefined );
    vehicle_ai::startinitialstate( "combat" );
}

// Namespace siegebot
// Params 1
// Checksum 0x6a12456f, Offset: 0xc58
// Size: 0x2d4
function state_death_update( params )
{
    self endon( #"death" );
    self endon( #"nodeath_thread" );
    streamermodelhint( self.deathmodel, 6 );
    death_type = vehicle_ai::get_death_type( params );
    
    if ( !isdefined( death_type ) )
    {
        params.death_type = "gibbed";
        death_type = params.death_type;
    }
    
    self clean_up_spawned();
    self setturretspinning( 0 );
    self stopmovementandsetbrake();
    self vehicle::set_damage_fx_level( 0 );
    self playsound( "veh_quadtank_sparks" );
    
    if ( self.vehicletype === "spawner_enemy_boss_siegebot_zombietron" )
    {
        self asmsetanimationrate( 1 );
    }
    
    self.turretrotscale = 3;
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 0 );
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 1 );
    self setturrettargetrelativeangles( ( 0, 0, 0 ), 2 );
    self asmrequestsubstate( "death@stationary" );
    self waittill( #"model_swap" );
    self vehicle_death::set_death_model( self.deathmodel, self.modelswapdelay );
    self vehicle::do_death_dynents();
    self vehicle_death::death_radius_damage();
    self waittill( #"bodyfall large" );
    self radiusdamage( self.origin + ( 0, 0, 10 ), self.radius * 0.8, 150, 60, self, "MOD_CRUSH" );
    vehicle_ai::waittill_asm_complete( "death@stationary", 3 );
    self thread vehicle_death::cleanup();
    self vehicle_death::freewhensafe();
}

// Namespace siegebot
// Params 1
// Checksum 0x6ca3460, Offset: 0xf38
// Size: 0x84
function siegebot_driving( params )
{
    self thread siegebot_player_fireupdate();
    self thread siegebot_kill_on_tilting();
    self cleartargetentity();
    self cancelaimove();
    self clearvehgoalpos();
}

// Namespace siegebot
// Params 0
// Checksum 0x5fcd1474, Offset: 0xfc8
// Size: 0x108
function siegebot_kill_on_tilting()
{
    self endon( #"death" );
    self endon( #"exit_vehicle" );
    tilecount = 0;
    
    while ( true )
    {
        selfup = anglestoup( self.angles );
        worldup = ( 0, 0, 1 );
        
        if ( vectordot( selfup, worldup ) < 0.64 )
        {
            tilecount += 1;
        }
        else
        {
            tilecount = 0;
        }
        
        if ( tilecount > 20 )
        {
            driver = self getseatoccupant( 0 );
            self kill( self.origin );
        }
        
        wait 0.05;
    }
}

// Namespace siegebot
// Params 0
// Checksum 0x284d4062, Offset: 0x10d8
// Size: 0xe4
function siegebot_player_fireupdate()
{
    self endon( #"death" );
    self endon( #"exit_vehicle" );
    weapon = self seatgetweapon( 2 );
    firetime = weapon.firetime;
    driver = self getseatoccupant( 0 );
    self thread siegebot_player_aimupdate();
    
    while ( true )
    {
        if ( driver attackbuttonpressed() )
        {
            self fireweapon( 2 );
            wait firetime;
            continue;
        }
        
        wait 0.05;
    }
}

// Namespace siegebot
// Params 0
// Checksum 0x72912557, Offset: 0x11c8
// Size: 0x58
function siegebot_player_aimupdate()
{
    self endon( #"death" );
    self endon( #"exit_vehicle" );
    
    while ( true )
    {
        self setgunnertargetvec( self getgunnertargetvec( 0 ), 1 );
        wait 0.05;
    }
}

// Namespace siegebot
// Params 1
// Checksum 0x2289f8fd, Offset: 0x1228
// Size: 0xac
function emped_enter( params )
{
    if ( !isdefined( self.abnormal_status ) )
    {
        self.abnormal_status = spawnstruct();
    }
    
    self.abnormal_status.emped = 1;
    self.abnormal_status.attacker = params.notify_param[ 1 ];
    self.abnormal_status.inflictor = params.notify_param[ 2 ];
    self vehicle::toggle_emp_fx( 1 );
}

// Namespace siegebot
// Params 1
// Checksum 0x9ca8b7ea, Offset: 0x12e0
// Size: 0xe4
function emped_update( params )
{
    self endon( #"death" );
    self endon( #"change_state" );
    self stopmovementandsetbrake();
    
    if ( self.vehicletype === "spawner_enemy_boss_siegebot_zombietron" )
    {
        self asmsetanimationrate( 1 );
    }
    
    asmstate = "damage_2@pain";
    self asmrequestsubstate( asmstate );
    self vehicle_ai::waittill_asm_complete( asmstate, 3 );
    self setbrake( 0 );
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot
// Params 1
// Checksum 0x5ef0a3ff, Offset: 0x13d0
// Size: 0xc
function emped_exit( params )
{
    
}

// Namespace siegebot
// Params 1
// Checksum 0xe3e19777, Offset: 0x13e8
// Size: 0xe, Type: bool
function emped_reenter( params )
{
    return false;
}

// Namespace siegebot
// Params 1
// Checksum 0xeab8827d, Offset: 0x1400
// Size: 0x18
function pain_toggle( enabled )
{
    self._enablepain = enabled;
}

// Namespace siegebot
// Params 1
// Checksum 0x2e78ed7e, Offset: 0x1420
// Size: 0x104
function pain_update( params )
{
    self endon( #"death" );
    self endon( #"change_state" );
    self stopmovementandsetbrake();
    
    if ( self.vehicletype === "spawner_enemy_boss_siegebot_zombietron" )
    {
        self asmsetanimationrate( 1 );
    }
    
    if ( self.newdamagelevel == 3 )
    {
        asmstate = "damage_2@pain";
    }
    else
    {
        asmstate = "damage_1@pain";
    }
    
    self asmrequestsubstate( asmstate );
    self vehicle_ai::waittill_asm_complete( asmstate, 1.5 );
    self setbrake( 0 );
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot
// Params 1
// Checksum 0x5093b5df, Offset: 0x1530
// Size: 0xae
function state_unaware_update( params )
{
    self endon( #"death" );
    self endon( #"change_state" );
    self setturrettargetrelativeangles( ( 0, 90, 0 ), 1 );
    self setturrettargetrelativeangles( ( 0, 90, 0 ), 2 );
    self thread movement_thread_unaware();
    
    while ( true )
    {
        self vehicle_ai::evaluate_connections();
        wait 1;
    }
}

// Namespace siegebot
// Params 0
// Checksum 0x67100bc3, Offset: 0x15e8
// Size: 0x12c
function movement_thread_unaware()
{
    self endon( #"death" );
    self endon( #"change_state" );
    self notify( #"end_movement_thread" );
    self endon( #"end_movement_thread" );
    
    while ( true )
    {
        self.current_pathto_pos = self getnextmoveposition_unaware();
        foundpath = self setvehgoalpos( self.current_pathto_pos, 0, 1 );
        
        if ( foundpath )
        {
            locomotion_start();
            self thread path_update_interrupt();
            self vehicle_ai::waittill_pathing_done();
            self notify( #"near_goal" );
            self cancelaimove();
            self clearvehgoalpos();
            scan();
        }
        else
        {
            wait 1;
        }
        
        wait 0.05;
    }
}

// Namespace siegebot
// Params 0
// Checksum 0x58db2d59, Offset: 0x1720
// Size: 0x47e
function getnextmoveposition_unaware()
{
    if ( self.goalforced )
    {
        return self.goalpos;
    }
    
    minsearchradius = 500;
    maxsearchradius = 1500;
    halfheight = 400;
    spacing = 80;
    queryresult = positionquery_source_navigation( self.origin, minsearchradius, maxsearchradius, halfheight, spacing, self, spacing );
    positionquery_filter_distancetogoal( queryresult, self );
    vehicle_ai::positionquery_filter_outofgoalanchor( queryresult );
    forward = anglestoforward( self.angles );
    
    foreach ( point in queryresult.data )
    {
        /#
            if ( !isdefined( point._scoredebug ) )
            {
                point._scoredebug = [];
            }
            
            point._scoredebug[ "<dev string:x28>" ] = randomfloatrange( 0, 30 );
        #/
        
        point.score += randomfloatrange( 0, 30 );
        pointdirection = vectornormalize( point.origin - self.origin );
        factor = vectordot( pointdirection, forward );
        
        if ( factor > 0.7 )
        {
            /#
                if ( !isdefined( point._scoredebug ) )
                {
                    point._scoredebug = [];
                }
                
                point._scoredebug[ "<dev string:x2f>" ] = 600;
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
                
                point._scoredebug[ "<dev string:x2f>" ] = 0;
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
                
                point._scoredebug[ "<dev string:x2f>" ] = -600;
            #/
            
            point.score += -600;
            continue;
        }
        
        /#
            if ( !isdefined( point._scoredebug ) )
            {
                point._scoredebug = [];
            }
            
            point._scoredebug[ "<dev string:x2f>" ] = -1200;
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

// Namespace siegebot
// Params 0
// Checksum 0x1868aeee, Offset: 0x1ba8
// Size: 0x44
function clean_up_spawned()
{
    if ( isdefined( self.jump ) && isdefined( self.jump.linkent ) )
    {
        self.jump.linkent delete();
    }
}

// Namespace siegebot
// Params 1
// Checksum 0xa8be59e0, Offset: 0x1bf8
// Size: 0x3c
function clean_up_spawnedondeath( enttowatch )
{
    self endon( #"death" );
    enttowatch waittill( #"death" );
    self delete();
}

// Namespace siegebot
// Params 0
// Checksum 0x682d8d45, Offset: 0x1c40
// Size: 0x12c
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
    self.jump.linkent thread clean_up_spawnedondeath( self );
    self.jump.in_air = 0;
    self.jump.highgrounds = struct::get_array( "balcony_point" );
    self.jump.groundpoints = struct::get_array( "ground_point" );
}

// Namespace siegebot
// Params 3
// Checksum 0xf5bc848e, Offset: 0x1d78
// Size: 0x48, Type: bool
function state_jump_can_enter( from_state, to_state, connection )
{
    if ( isdefined( self.nojumping ) && self.nojumping )
    {
        return false;
    }
    
    return self.vehicletype === "spawner_enemy_boss_siegebot_zombietron";
}

// Namespace siegebot
// Params 1
// Checksum 0xb1d23f0b, Offset: 0x1dc8
// Size: 0x1e4
function state_jump_enter( params )
{
    goal = params.jumpgoal;
    trace = physicstrace( goal + ( 0, 0, 500 ), goal - ( 0, 0, 10000 ), ( -10, -10, -10 ), ( 10, 10, 10 ), self, 2 );
    
    if ( false )
    {
        /#
            debugstar( goal, 60000, ( 0, 1, 0 ) );
        #/
        
        /#
            debugstar( trace[ "<dev string:x3d>" ], 60000, ( 0, 1, 0 ) );
        #/
        
        /#
            line( goal, trace[ "<dev string:x3d>" ], ( 0, 1, 0 ), 1, 0, 60000 );
        #/
    }
    
    if ( trace[ "fraction" ] < 1 )
    {
        goal = trace[ "position" ];
    }
    
    self.jump.goal = goal;
    params.scaleforward = 40;
    params.gravityforce = ( 0, 0, -6 );
    params.upbyheight = 50;
    params.coptermodel = "land@jump";
    self pain_toggle( 0 );
    self stopmovementandsetbrake();
}

// Namespace siegebot
// Params 1
// Checksum 0xacea8215, Offset: 0x1fb8
// Size: 0xbfc
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
    antigravitybydistance = 0;
    initvelocityup = ( 0, 0, 1 ) * ( upbydistance + params.upbyheight );
    initvelocityforward = forward * params.scaleforward * mapfloat( 500, 2000, 0.8, 1, totaldistance );
    velocity = initvelocityup + initvelocityforward;
    
    if ( self.vehicletype === "spawner_enemy_boss_siegebot_zombietron" )
    {
        self asmsetanimationrate( 1 );
    }
    
    self asmrequestsubstate( "inair@jump" );
    self waittill( #"engine_startup" );
    self vehicle::impact_fx( self.settings.startupfx1 );
    self waittill( #"leave_ground" );
    self vehicle::impact_fx( self.settings.takeofffx1 );
    
    while ( true )
    {
        distancetogoal = distance2d( self.jump.linkent.origin, goal );
        antigravityscaleup = 1;
        antigravityscale = 1;
        antigravity = ( 0, 0, 0 );
        
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
        
        if ( oldverticlespeed > 0 && velocity[ 2 ] < 0 )
        {
            self asmrequestsubstate( "fall@jump" );
        }
        
        if ( velocity[ 2 ] < 0 && self.jump.linkent.origin[ 2 ] + velocity[ 2 ] < goal[ 2 ] )
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
            }
        }
    }
    
    self vehicle::impact_fx( self.settings.landingfx1 );
    self stopmovementandsetbrake();
    wait 0.3;
    self unlink();
    wait 0.05;
    self.jump.in_air = 0;
    self notify( #"jump_finished" );
    vehicle_ai::cooldown( "jump", 7 );
    self vehicle_ai::waittill_asm_complete( params.coptermodel, 3 );
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot
// Params 1
// Checksum 0x8cf8834, Offset: 0x2bc0
// Size: 0xc
function state_jump_exit( params )
{
    
}

// Namespace siegebot
// Params 1
// Checksum 0xa13a50b5, Offset: 0x2bd8
// Size: 0x64
function state_combat_update( params )
{
    self endon( #"death" );
    self endon( #"change_state" );
    self thread movement_thread();
    self thread attack_thread_machinegun();
    self thread attack_thread_rocket();
}

// Namespace siegebot
// Params 1
// Checksum 0x203a2c7b, Offset: 0x2c48
// Size: 0x3c
function state_combat_exit( params )
{
    self clearturrettarget();
    self setturretspinning( 0 );
}

// Namespace siegebot
// Params 0
// Checksum 0xcb502c73, Offset: 0x2c90
// Size: 0x54
function locomotion_start()
{
    if ( self.vehicletype === "spawner_enemy_boss_siegebot_zombietron" )
    {
        self asmsetanimationrate( 0.5 );
    }
    
    self asmrequestsubstate( "locomotion@movement" );
}

// Namespace siegebot
// Params 0
// Checksum 0xee2d92d1, Offset: 0x2cf0
// Size: 0x476
function getnextmoveposition_tactical()
{
    if ( self.goalforced )
    {
        return self.goalpos;
    }
    
    maxsearchradius = 800;
    halfheight = 400;
    innerspacing = 50;
    outerspacing = 60;
    queryresult = positionquery_source_navigation( self.origin, 0, maxsearchradius, halfheight, innerspacing, self, outerspacing );
    positionquery_filter_distancetogoal( queryresult, self );
    vehicle_ai::positionquery_filter_outofgoalanchor( queryresult );
    
    if ( isdefined( self.enemy ) )
    {
        positionquery_filter_sight( queryresult, self.enemy.origin, self geteye() - self.origin, self, 0, self.enemy );
        self vehicle_ai::positionquery_filter_engagementdist( queryresult, self.enemy, self.settings.engagementdistmin, self.settings.engagementdistmax );
    }
    
    foreach ( point in queryresult.data )
    {
        /#
            if ( !isdefined( point._scoredebug ) )
            {
                point._scoredebug = [];
            }
            
            point._scoredebug[ "<dev string:x28>" ] = randomfloatrange( 0, 30 );
        #/
        
        point.score += randomfloatrange( 0, 30 );
        
        if ( point.disttoorigin2d < 120 )
        {
            /#
                if ( !isdefined( point._scoredebug ) )
                {
                    point._scoredebug = [];
                }
                
                point._scoredebug[ "<dev string:x46>" ] = ( 120 - point.disttoorigin2d ) * -1.5;
            #/
            
            point.score += ( 120 - point.disttoorigin2d ) * -1.5;
        }
        
        if ( isdefined( self.enemy ) )
        {
            /#
                if ( !isdefined( point._scoredebug ) )
                {
                    point._scoredebug = [];
                }
                
                point._scoredebug[ "<dev string:x55>" ] = point.distawayfromengagementarea * -1;
            #/
            
            point.score += point.distawayfromengagementarea * -1;
            
            if ( !point.visibility )
            {
                /#
                    if ( !isdefined( point._scoredebug ) )
                    {
                        point._scoredebug = [];
                    }
                    
                    point._scoredebug[ "<dev string:x64>" ] = -600;
                #/
                
                point.score += -600;
            }
        }
    }
    
    vehicle_ai::positionquery_postprocess_sortscore( queryresult );
    self vehicle_ai::positionquery_debugscores( queryresult );
    
    if ( queryresult.data.size == 0 )
    {
        return self.origin;
    }
    
    return queryresult.data[ 0 ].origin;
}

// Namespace siegebot
// Params 0
// Checksum 0xc9255d43, Offset: 0x3170
// Size: 0x484
function path_update_interrupt()
{
    self endon( #"death" );
    self endon( #"change_state" );
    self endon( #"near_goal" );
    self endon( #"reached_end_node" );
    canseeenemycount = 0;
    old_enemy = self.enemy;
    startpath = gettime();
    old_origin = self.origin;
    move_dist = 300;
    wait 1.5;
    
    while ( true )
    {
        self setmaxspeedscale( 1 );
        self setmaxaccelerationscale( 1 );
        self setspeed( self.settings.defaultmovespeed );
        
        if ( isdefined( self.enemy ) )
        {
            selfdisttotarget = distance2d( self.origin, self.enemy.origin );
            farengagementdist = self.settings.engagementdistmax + 150;
            closeengagementdist = self.settings.engagementdistmin - 150;
            
            if ( self vehcansee( self.enemy ) )
            {
                self setlookatent( self.enemy );
                self setturrettargetent( self.enemy );
                
                if ( selfdisttotarget < farengagementdist && selfdisttotarget > closeengagementdist )
                {
                    canseeenemycount++;
                    
                    if ( vehicle_ai::timesince( startpath ) > 5 || canseeenemycount > 3 && distance2dsquared( old_origin, self.origin ) > move_dist * move_dist )
                    {
                        self notify( #"near_goal" );
                    }
                }
                else
                {
                    self setmaxspeedscale( 2.5 );
                    self setmaxaccelerationscale( 3 );
                    self setspeed( self.settings.defaultmovespeed * 2 );
                }
            }
            else if ( !self vehseenrecently( self.enemy, 1.5 ) && self vehseenrecently( self.enemy, 15 ) || selfdisttotarget > farengagementdist )
            {
                self setmaxspeedscale( 1.8 );
                self setmaxaccelerationscale( 2 );
                self setspeed( self.settings.defaultmovespeed * 1.5 );
            }
        }
        else
        {
            canseeenemycount = 0;
        }
        
        if ( isdefined( self.enemy ) )
        {
            if ( !isdefined( old_enemy ) )
            {
                self notify( #"near_goal" );
            }
            else if ( self.enemy != old_enemy )
            {
                self notify( #"near_goal" );
            }
            
            if ( self vehcansee( self.enemy ) && distance2dsquared( self.origin, self.enemy.origin ) < 150 * 150 && distance2dsquared( old_origin, self.enemy.origin ) > 151 * 151 )
            {
                self notify( #"near_goal" );
            }
        }
        
        wait 0.2;
    }
}

// Namespace siegebot
// Params 2
// Checksum 0xf578375e, Offset: 0x3600
// Size: 0x84
function weapon_doors_state( isopen, waittime )
{
    if ( !isdefined( waittime ) )
    {
        waittime = 0;
    }
    
    self endon( #"death" );
    self notify( #"weapon_doors_state" );
    self endon( #"weapon_doors_state" );
    
    if ( isdefined( waittime ) && waittime > 0 )
    {
        wait waittime;
    }
    
    self vehicle::toggle_ambient_anim_group( 1, isopen );
}

// Namespace siegebot
// Params 0
// Checksum 0x30d20917, Offset: 0x3690
// Size: 0x2d8
function movement_thread()
{
    self endon( #"death" );
    self endon( #"change_state" );
    self notify( #"end_movement_thread" );
    self endon( #"end_movement_thread" );
    
    while ( true )
    {
        self.current_pathto_pos = self getnextmoveposition_tactical();
        
        if ( self.vehicletype === "spawner_enemy_boss_siegebot_zombietron" )
        {
            if ( vehicle_ai::iscooldownready( "jump" ) )
            {
                params = spawnstruct();
                params.jumpgoal = self.current_pathto_pos;
                locomotion_start();
                wait 0.5;
                self vehicle_ai::evaluate_connections( undefined, params );
                wait 0.5;
            }
        }
        
        foundpath = self setvehgoalpos( self.current_pathto_pos, 0, 1 );
        
        if ( foundpath )
        {
            if ( isdefined( self.enemy ) && self vehseenrecently( self.enemy, 1 ) )
            {
                self setlookatent( self.enemy );
                self setturrettargetent( self.enemy );
            }
            
            locomotion_start();
            self thread path_update_interrupt();
            self vehicle_ai::waittill_pathing_done();
            self notify( #"near_goal" );
            self cancelaimove();
            self clearvehgoalpos();
            
            if ( isdefined( self.enemy ) && self vehseenrecently( self.enemy, 2 ) )
            {
                self face_target( self.enemy.origin );
            }
        }
        
        wait 1;
        startadditionalwaiting = gettime();
        
        while ( isdefined( self.enemy ) && self vehcansee( self.enemy ) && vehicle_ai::timesince( startadditionalwaiting ) < 1.5 )
        {
            wait 0.4;
        }
    }
}

// Namespace siegebot
// Params 0
// Checksum 0x44f81cac, Offset: 0x3970
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

// Namespace siegebot
// Params 2
// Checksum 0x1ae049a9, Offset: 0x3a10
// Size: 0x20c
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
        anglediff = absangleclamp180( self.angles[ 1 ] - goalangles[ 1 ] );
        wait 0.05;
    }
    
    self clearvehgoalpos();
    self clearlookatent();
    self clearturrettarget();
    self cancelaimove();
}

// Namespace siegebot
// Params 0
// Checksum 0xe863cbd8, Offset: 0x3c28
// Size: 0x24c
function scan()
{
    angles = self gettagangles( "tag_barrel" );
    angles = ( 0, angles[ 1 ], 0 );
    rotate = 360;
    
    while ( rotate > 0 )
    {
        angles += ( 0, 30, 0 );
        rotate -= 30;
        forward = anglestoforward( angles );
        aimpos = self.origin + forward * 1000;
        self setturrettargetvec( aimpos );
        msg = self util::waittill_any_timeout( 0.5, "turret_on_target" );
        wait 0.1;
        
        if ( isdefined( self.enemy ) && self vehcansee( self.enemy ) )
        {
            self setturrettargetent( self.enemy );
            self setlookatent( self.enemy );
            self face_target( self.enemy );
            return;
        }
    }
    
    forward = anglestoforward( self.angles );
    aimpos = self.origin + forward * 1000;
    self setturrettargetvec( aimpos );
    msg = self util::waittill_any_timeout( 3, "turret_on_target" );
    self clearturrettarget();
}

// Namespace siegebot
// Params 0
// Checksum 0xf813aa42, Offset: 0x3e80
// Size: 0x270
function attack_thread_machinegun()
{
    self endon( #"death" );
    self endon( #"change_state" );
    self endon( #"end_attack_thread" );
    self notify( #"end_machinegun_attack_thread" );
    self endon( #"end_machinegun_attack_thread" );
    self.turretrotscale = 1 * self.difficulty_scale_up;
    spinning = 0;
    
    while ( true )
    {
        if ( isdefined( self.enemy ) && self vehcansee( self.enemy ) )
        {
            self setlookatent( self.enemy );
            self setturrettargetent( self.enemy );
            
            if ( !spinning )
            {
                spinning = 1;
                self setturretspinning( 1 );
                wait 0.5;
                continue;
            }
            
            self setgunnertargetent( self.enemy, ( 0, 0, 0 ), 0 );
            self setgunnertargetent( self.enemy, ( 0, 0, 0 ), 1 );
            self vehicle_ai::fire_for_time( randomfloatrange( 0.75, 1.5 ) * self.difficulty_scale_up, 1 );
            
            if ( isdefined( self.enemy ) && isai( self.enemy ) )
            {
                wait randomfloatrange( 0.1, 0.2 );
            }
            else
            {
                wait randomfloatrange( 0.2, 0.3 ) * self.difficulty_scale_down;
            }
            
            continue;
        }
        
        spinning = 0;
        self setturretspinning( 0 );
        self cleargunnertarget( 0 );
        self cleargunnertarget( 1 );
        wait 0.4;
    }
}

// Namespace siegebot
// Params 1
// Checksum 0x9ac79408, Offset: 0x40f8
// Size: 0xc4
function attack_rocket( target )
{
    if ( isdefined( target ) )
    {
        self setturrettargetent( target );
        self setgunnertargetent( target, ( 0, 0, -10 ), 2 );
        msg = self util::waittill_any_timeout( 1, "turret_on_target" );
        self fireweapon( 2, target, ( 0, 0, -10 ) );
        self cleargunnertarget( 1 );
    }
}

// Namespace siegebot
// Params 0
// Checksum 0xa6f411ce, Offset: 0x41c8
// Size: 0x230
function attack_thread_rocket()
{
    self endon( #"death" );
    self endon( #"change_state" );
    self endon( #"end_attack_thread" );
    self notify( #"end_rocket_attack_thread" );
    self endon( #"end_rocket_attack_thread" );
    vehicle_ai::cooldown( "rocket", 3 );
    
    while ( true )
    {
        if ( isdefined( self.enemy ) && self vehseenrecently( self.enemy, 3 ) && vehicle_ai::iscooldownready( "rocket", 1.5 ) )
        {
            self setgunnertargetent( self.enemy, ( 0, 0, 0 ), 0 );
            self setgunnertargetent( self.enemy, ( 0, 0, -10 ), 2 );
            self thread weapon_doors_state( 1 );
            wait 1.5;
            
            if ( isdefined( self.enemy ) && self vehseenrecently( self.enemy, 1 ) )
            {
                vehicle_ai::cooldown( "rocket", 5 );
                attack_rocket( self.enemy );
                wait 1;
                
                if ( isdefined( self.enemy ) )
                {
                    attack_rocket( self.enemy );
                }
                
                self thread weapon_doors_state( 0, 1 );
            }
            else
            {
                self thread weapon_doors_state( 0 );
            }
            
            continue;
        }
        
        self cleargunnertarget( 0 );
        self cleargunnertarget( 1 );
        wait 0.4;
    }
}

// Namespace siegebot
// Params 15
// Checksum 0x5f9f6681, Offset: 0x4400
// Size: 0x288
function siegebot_callback_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    num_players = getplayers().size;
    maxdamage = self.healthdefault * ( 0.4 - 0.02 * num_players );
    
    if ( smeansofdeath !== "MOD_UNKNOWN" && idamage > maxdamage )
    {
        idamage = maxdamage;
    }
    
    if ( vehicle_ai::should_emp( self, weapon, smeansofdeath, einflictor, eattacker ) )
    {
        minempdowntime = 0.8 * self.settings.empdowntime;
        maxempdowntime = 1.2 * self.settings.empdowntime;
        self notify( #"emped", randomfloatrange( minempdowntime, maxempdowntime ), eattacker, einflictor );
    }
    
    if ( !isdefined( self.damagelevel ) )
    {
        self.damagelevel = 0;
        self.newdamagelevel = self.damagelevel;
    }
    
    newdamagelevel = vehicle::should_update_damage_fx_level( self.health, idamage, self.healthdefault );
    
    if ( newdamagelevel > self.damagelevel )
    {
        self.newdamagelevel = newdamagelevel;
    }
    
    if ( self.newdamagelevel > self.damagelevel )
    {
        self.damagelevel = self.newdamagelevel;
        driver = self getseatoccupant( 0 );
        
        if ( !isdefined( driver ) )
        {
            self notify( #"pain" );
        }
        
        vehicle::set_damage_fx_level( self.damagelevel );
    }
    
    return idamage;
}

