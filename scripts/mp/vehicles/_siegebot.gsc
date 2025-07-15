#using scripts/codescripts/struct;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/_oob;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scoreevents_shared;
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
// Checksum 0x4e6dfee2, Offset: 0x730
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "siegebot_mp", &__init__, undefined, undefined );
}

// Namespace siegebot
// Params 0
// Checksum 0x3cf3010d, Offset: 0x770
// Size: 0xac
function __init__()
{
    vehicle::add_main_callback( "siegebot_mp", &siegebot_initialize );
    clientfield::register( "vehicle", "siegebot_retract_right_arm", 15000, 1, "int" );
    clientfield::register( "vehicle", "siegebot_retract_left_arm", 15000, 1, "int" );
    callback::on_disconnect( &on_player_disconnected );
}

#using_animtree( "generic" );

// Namespace siegebot
// Params 0
// Checksum 0xed5e485c, Offset: 0x828
// Size: 0x49c
function siegebot_initialize()
{
    self useanimtree( #animtree );
    blackboard::createblackboardforentity( self );
    self blackboard::registervehicleblackboardattributes();
    self.health = self.healthdefault;
    self.spawntime = gettime();
    self.is_oob_kill_target = 1;
    self.isstunned = 0;
    self.missiles_disabled = 0;
    self.numberrockets = 3;
    self vehicle::friendly_fire_shield();
    self.targetoffset = ( 0, 0, 84 );
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
    self.ignoreme = 1;
    self.killstreaktype = "siegebot";
    killstreak_bundles::register_killstreak_bundle( self.killstreaktype );
    self.maxhealth = killstreak_bundles::get_max_health( self.killstreaktype );
    self.heatlh = self.maxhealth;
    self thread monitor_enter_exit_vehicle();
    self thread watch_game_ended();
    self thread watch_emped();
    self thread watch_death();
}

// Namespace siegebot
// Params 0
// Checksum 0x2117c93e, Offset: 0xcd0
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
// Checksum 0x173dd4f7, Offset: 0xd80
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
// Checksum 0xc65dd664, Offset: 0x1038
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
// Checksum 0x26d96e9e, Offset: 0x1318
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
// Checksum 0xac5ef858, Offset: 0x13a8
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
// Checksum 0x6c8c1197, Offset: 0x14b8
// Size: 0xec
function siegebot_player_fireupdate()
{
    self endon( #"death" );
    self endon( #"exit_vehicle" );
    weapon = self seatgetweapon( 2 );
    driver = self getseatoccupant( 0 );
    
    if ( !isdefined( driver ) )
    {
        return;
    }
    
    self thread siegebot_player_aimupdate();
    
    while ( isdefined( driver ) )
    {
        if ( driver fragbuttonpressed() && !self.missiles_disabled )
        {
            self fireweapon( 2 );
            wait weapon.firetime;
            continue;
        }
        
        wait 0.05;
    }
}

// Namespace siegebot
// Params 0
// Checksum 0x9b5c578c, Offset: 0x15b0
// Size: 0x1c8
function siegebot_player_aimupdate()
{
    self endon( #"death" );
    self endon( #"exit_vehicle" );
    rocket_wall_blocked_count = 0;
    use_old_trace = 1;
    
    while ( true )
    {
        if ( rocket_wall_blocked_count == 0 && self does_rocket_shoot_through_wall( use_old_trace ) )
        {
            rocket_wall_blocked_count = 10;
            use_old_trace = 1;
        }
        
        if ( rocket_wall_blocked_count > 0 )
        {
            aim_origin = self gettagorigin( "tag_turret" );
            ref_angles = self gettagangles( "tag_turret" );
            forward = anglestoforward( ref_angles );
            right = anglestoright( ref_angles );
            aim_origin += forward * 100 + right * 40;
            aim_origin += ( 0, 0, 500 );
            self setgunnertargetvec( aim_origin, 1 );
            rocket_wall_blocked_count--;
        }
        else
        {
            self setgunnertargetvec( self getgunnertargetvec( 0 ), 1 );
            use_old_trace = 0;
        }
        
        wait 0.05;
    }
}

// Namespace siegebot
// Params 1
// Checksum 0xd2bb8c5e, Offset: 0x1780
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
// Checksum 0x8bfe1a31, Offset: 0x1838
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
// Checksum 0x1517096c, Offset: 0x1928
// Size: 0xc
function emped_exit( params )
{
    
}

// Namespace siegebot
// Params 1
// Checksum 0x45dce38, Offset: 0x1940
// Size: 0xe, Type: bool
function emped_reenter( params )
{
    return false;
}

// Namespace siegebot
// Params 1
// Checksum 0x88e86ccb, Offset: 0x1958
// Size: 0x18
function pain_toggle( enabled )
{
    self._enablepain = enabled;
}

// Namespace siegebot
// Params 1
// Checksum 0xd99a8a25, Offset: 0x1978
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
// Checksum 0xd638be63, Offset: 0x1a88
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
// Checksum 0x29b47cf0, Offset: 0x1b40
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
// Checksum 0x4f83086, Offset: 0x1c78
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
// Checksum 0x1929bfc, Offset: 0x2100
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
// Checksum 0xb1c0256f, Offset: 0x2150
// Size: 0x3c
function clean_up_spawnedondeath( enttowatch )
{
    self endon( #"death" );
    enttowatch waittill( #"death" );
    self delete();
}

// Namespace siegebot
// Params 0
// Checksum 0xc9f8d5d3, Offset: 0x2198
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
// Checksum 0x8545cba3, Offset: 0x22d0
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
// Checksum 0x3eed561e, Offset: 0x2320
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
// Checksum 0xd785a0c9, Offset: 0x2510
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
// Checksum 0x26233fb2, Offset: 0x3118
// Size: 0xc
function state_jump_exit( params )
{
    
}

// Namespace siegebot
// Params 1
// Checksum 0xb55f1bfb, Offset: 0x3130
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
// Checksum 0x5d1cfbb2, Offset: 0x31a0
// Size: 0x3c
function state_combat_exit( params )
{
    self clearturrettarget();
    self setturretspinning( 0 );
}

// Namespace siegebot
// Params 0
// Checksum 0x1751c109, Offset: 0x31e8
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
// Checksum 0x58cc6ae3, Offset: 0x3248
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
// Checksum 0xa3ab144a, Offset: 0x36c8
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
// Checksum 0x245f445b, Offset: 0x3b58
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
// Checksum 0x73e0e5a8, Offset: 0x3be8
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
// Checksum 0x7e8a99a8, Offset: 0x3ec8
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
// Checksum 0xc1da7b8f, Offset: 0x3f68
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
// Checksum 0x504354fe, Offset: 0x4180
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
// Checksum 0x5df82199, Offset: 0x43d8
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
// Checksum 0xe4196e25, Offset: 0x4650
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
// Checksum 0x609d37ab, Offset: 0x4720
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
// Params 0
// Checksum 0x56a31ddd, Offset: 0x4958
// Size: 0x78
function monitor_enter_exit_vehicle()
{
    self endon( #"death" );
    player = undefined;
    
    while ( true )
    {
        self vehicle_unoccupied( player );
        self waittill( #"enter_vehicle", player );
        self vehicle_occupied( player );
        self waittill( #"exit_vehicle", player );
    }
}

// Namespace siegebot
// Params 1
// Checksum 0x1bd54e9f, Offset: 0x49d8
// Size: 0x1b4
function vehicle_occupied( player )
{
    self clientfield::set( "enemyvehicle", 1 );
    
    /#
    #/
    
    self.ignoreme = 0;
    self thread siegebot_player_fireupdate();
    self thread weapon_doors_state( 1 );
    self thread watch_left_arm();
    self thread watch_right_arm();
    
    if ( isplayer( player ) )
    {
        player.using_map_vehicle = 1;
        player.current_map_vehicle = self;
        player.ignoreme = 1;
        self.current_driver = player;
        player setclientuivisibilityflag( "weapon_hud_visible", 0 );
        player vehicle::update_damage_as_occupant( self.maxhealth - self.health, self.maxhealth );
        player disableweaponcycling();
        self thread watch_rockets( player );
        self update_emped_driver_visuals();
        player.siegebot_kills = undefined;
        player ghost();
    }
}

// Namespace siegebot
// Params 1
// Checksum 0xc21bf4c2, Offset: 0x4b98
// Size: 0x106
function vehicle_unoccupied( player )
{
    self clientfield::set( "enemyvehicle", 0 );
    self.ignoreme = 1;
    self thread weapon_doors_state( 0 );
    
    if ( isplayer( player ) )
    {
        player.using_map_vehicle = undefined;
        player.current_map_vehicle = undefined;
        player.ignoreme = 0;
        player setclientuivisibilityflag( "weapon_hud_visible", 1 );
        player enableweaponcycling();
        update_emped_visuals( player, 0 );
        player show();
    }
    
    self.current_driver = undefined;
}

// Namespace siegebot
// Params 15
// Checksum 0xcd4580df, Offset: 0x4ca8
// Size: 0x348
function siegebot_callback_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    time_alive = gettime() - self.spawntime;
    
    if ( time_alive < 500 && smeansofdeath == "MOD_TRIGGER_HURT" )
    {
        return 0;
    }
    
    idamage = self killstreaks::ondamageperweapon( "siegebot", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1 );
    fmj = loadout::isfmjdamage( weapon, smeansofdeath, eattacker );
    
    if ( !isdefined( weapon.isheroweapon ) || isdefined( fmj ) && fmj && !weapon.isheroweapon )
    {
        idamage /= 2;
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
    }
    
    newdamagelevel = vehicle::should_update_damage_fx_level( self.health, idamage, self.healthdefault );
    
    if ( newdamagelevel > self.damagelevel )
    {
        self.damagelevel = newdamagelevel;
        vehicle::set_damage_fx_level( self.damagelevel );
    }
    
    driver = self getseatoccupant( 0 );
    
    if ( isplayer( driver ) )
    {
        driver vehicle::update_damage_as_occupant( self.maxhealth - self.health - idamage, self.maxhealth );
        
        if ( idamage > self.health )
        {
            driver show();
        }
    }
    
    return idamage;
}

// Namespace siegebot
// Params 0
// Checksum 0x76d90e7d, Offset: 0x4ff8
// Size: 0x68
function watch_emped()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"emped", down_time, attacker, inflictor );
        self thread emped( down_time );
    }
}

// Namespace siegebot
// Params 1
// Checksum 0x48ff60e3, Offset: 0x5068
// Size: 0xac
function emped( down_time )
{
    self notify( #"emped_singleton" );
    self endon( #"death" );
    self endon( #"emped_singleton" );
    self setbrake( 1 );
    self.emped = 1;
    self update_emped_driver_visuals();
    wait down_time;
    self setbrake( 0 );
    self.emped = 0;
    self update_emped_driver_visuals();
}

// Namespace siegebot
// Params 0
// Checksum 0xdb099ade, Offset: 0x5120
// Size: 0x34
function update_emped_driver_visuals()
{
    update_emped_visuals( self getseatoccupant( 0 ), self.emped );
}

// Namespace siegebot
// Params 2
// Checksum 0x7de506cb, Offset: 0x5160
// Size: 0xb4
function update_emped_visuals( driver, emped )
{
    if ( isplayer( driver ) )
    {
        value = isdefined( emped ) ? emped : 0 ? 1 : 0;
        driver clientfield::set_to_player( "empd", value );
        driver clientfield::set_to_player( "static_postfx", value );
        driver setempjammed( value );
    }
}

// Namespace siegebot
// Params 0
// Checksum 0x4d540f9b, Offset: 0x5220
// Size: 0x54
function watch_game_ended()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    self thread wait_then_hide( 3 );
    self destroy_siegebot();
}

// Namespace siegebot
// Params 0
// Checksum 0x8ddf43fc, Offset: 0x5280
// Size: 0x54
function destroy_siegebot()
{
    self dodamage( self.health + 1, self.origin + ( 0, 0, 60 ), undefined, undefined, "none", "MOD_EXPLOSIVE", 0 );
}

// Namespace siegebot
// Params 1
// Checksum 0x3ae8c6ab, Offset: 0x52e0
// Size: 0x2c
function wait_then_hide( wait_time )
{
    wait wait_time;
    
    if ( isdefined( self ) )
    {
        self hide();
    }
}

// Namespace siegebot
// Params 0
// Checksum 0x8b9716cd, Offset: 0x5318
// Size: 0x11c
function watch_death()
{
    self notify( #"siegebot_watch_death" );
    self endon( #"siegebot_watch_death" );
    self waittill( #"death" );
    self process_siegebot_kill( self.current_driver );
    
    if ( isplayer( self.current_driver ) )
    {
        self vehicle_unoccupied( self.current_driver );
    }
    
    streamermodelhint( self.deathmodel, 6 );
    self vehicle_death::set_death_model( self.deathmodel, self.modelswapdelay );
    self vehicle::do_death_dynents();
    self vehicle_death::death_radius_damage();
    self vehicle_death::deletewhensafe( 0.25 );
}

// Namespace siegebot
// Params 1
// Checksum 0xbfb9179f, Offset: 0x5440
// Size: 0x19a
function process_siegebot_kill( driver )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.team == "neutral" )
    {
        return;
    }
    
    if ( !isplayer( driver ) )
    {
        return;
    }
    
    if ( isplayer( self.attacker ) )
    {
        if ( driver == self.attacker )
        {
            return;
        }
        
        scoreevents::processscoreevent( "destroyed_siegebot", self.attacker );
    }
    
    if ( isdefined( self.attackers ) )
    {
        foreach ( kill_assist in self.attackers )
        {
            if ( isplayer( kill_assist ) )
            {
                if ( self.attacker === kill_assist )
                {
                    continue;
                }
                
                if ( !isdefined( self.attacker ) || kill_assist.team == self.attacker.team )
                {
                    scoreevents::processscoreevent( "destroyed_siegebot_assist", kill_assist );
                }
            }
        }
    }
}

// Namespace siegebot
// Params 1
// Checksum 0xfbf9a182, Offset: 0x55e8
// Size: 0xfc
function reload_rockets( player )
{
    bundle = level.killstreakbundle[ "siegebot" ];
    self disable_missiles();
    weapon_wait_duration_ms = int( bundle.ksweaponreloadtime * 1000 );
    player setvehicleweaponwaitduration( weapon_wait_duration_ms );
    player setvehicleweaponwaitendtime( gettime() + weapon_wait_duration_ms );
    wait bundle.ksweaponreloadtime;
    self set_rocket_count( 3 );
    wait 0.4;
    
    if ( !self.isstunned )
    {
        self enable_missiles();
    }
}

// Namespace siegebot
// Params 1
// Checksum 0x431c68ef, Offset: 0x56f0
// Size: 0x34
function set_rocket_count( rocket_count )
{
    self.numberrockets = rocket_count;
    self update_client_ammo( self.numberrockets );
}

// Namespace siegebot
// Params 0
// Checksum 0x6914b4a3, Offset: 0x5730
// Size: 0x2c
function enable_missiles()
{
    self.missiles_disabled = 0;
    self disablegunnerfiring( 1, 0 );
}

// Namespace siegebot
// Params 0
// Checksum 0xbb63dc8, Offset: 0x5768
// Size: 0x2c
function disable_missiles()
{
    self.missiles_disabled = 1;
    self disablegunnerfiring( 1, 1 );
}

// Namespace siegebot
// Params 1
// Checksum 0x71ce889b, Offset: 0x57a0
// Size: 0x110
function watch_rockets( player )
{
    self endon( #"death" );
    self endon( #"exit_vehicle" );
    
    if ( self.numberrockets <= 0 )
    {
        self reload_rockets( player );
    }
    else
    {
        self update_client_ammo( self.numberrockets );
    }
    
    if ( !self.isstunned )
    {
        self enable_missiles();
    }
    
    while ( true )
    {
        player waittill( #"missile_fire", missile );
        missile.ignore_team_kills = self.ignore_team_kills;
        self set_rocket_count( self.numberrockets - 1 );
        
        if ( self.numberrockets <= 0 )
        {
            self reload_rockets( player );
        }
    }
}

// Namespace siegebot
// Params 2
// Checksum 0x6fc73422, Offset: 0x58b8
// Size: 0x8c
function update_client_ammo( ammo_count, driver_only_update )
{
    if ( !isdefined( driver_only_update ) )
    {
        driver_only_update = 0;
    }
    
    if ( !driver_only_update )
    {
        self clientfield::set( "ai_tank_missile_fire", ammo_count );
    }
    
    if ( isplayer( self.current_driver ) )
    {
        self.current_driver clientfield::increment_to_player( "ai_tank_update_hud", 1 );
    }
}

/#

    // Namespace siegebot
    // Params 0
    // Checksum 0x2b4342da, Offset: 0x5950
    // Size: 0xb6, Type: dev
    function arm_test()
    {
        self notify( #"arm_test" );
        self endon( #"arm_test" );
        level endon( #"game_ended" );
        delay = 10;
        
        while ( true )
        {
            self thread retract_left_arm();
            self thread retract_right_arm();
            wait delay;
            self thread extend_left_arm();
            self thread extend_right_arm();
            wait delay;
        }
    }

#/

// Namespace siegebot
// Params 0
// Checksum 0x6dee0348, Offset: 0x5a10
// Size: 0xc4
function retract_left_arm()
{
    if ( !isdefined( self.left_arm_retracted ) )
    {
        self.left_arm_retracted = 0;
    }
    
    if ( self.left_arm_retracted )
    {
        return;
    }
    
    self.left_arm_retracted = 1;
    self useanimtree( #animtree );
    self clientfield::set( "siegebot_retract_left_arm", 1 );
    self clearanim( %ai_siegebot_base_mp_left_arm_extend, 0.2 );
    self setanim( %ai_siegebot_base_mp_left_arm_retract, 1 );
}

// Namespace siegebot
// Params 0
// Checksum 0x13e1bef7, Offset: 0x5ae0
// Size: 0x10c
function extend_left_arm()
{
    if ( !isdefined( self.left_arm_retracted ) )
    {
        self.left_arm_retracted = 0;
    }
    
    if ( !self.left_arm_retracted )
    {
        return;
    }
    
    self.left_arm_retracted = 0;
    self useanimtree( #animtree );
    self clientfield::set( "siegebot_retract_left_arm", 0 );
    self clearanim( %ai_siegebot_base_mp_left_arm_retract, 0.2 );
    self setanim( %ai_siegebot_base_mp_left_arm_extend, 1, 0 );
    wait 0.1;
    
    if ( self.left_arm_retracted == 0 )
    {
        self clearanim( %ai_siegebot_base_mp_left_arm_extend, 0.1 );
    }
}

// Namespace siegebot
// Params 0
// Checksum 0xabf7a282, Offset: 0x5bf8
// Size: 0xc4
function retract_right_arm()
{
    if ( !isdefined( self.right_arm_retracted ) )
    {
        self.right_arm_retracted = 0;
    }
    
    if ( self.right_arm_retracted )
    {
        return;
    }
    
    self.right_arm_retracted = 1;
    self useanimtree( #animtree );
    self clientfield::set( "siegebot_retract_right_arm", 1 );
    self clearanim( %ai_siegebot_base_mp_right_arm_extend, 0.2 );
    self setanim( %ai_siegebot_base_mp_right_arm_retract, 1 );
}

// Namespace siegebot
// Params 0
// Checksum 0x8af4d2ad, Offset: 0x5cc8
// Size: 0x104
function extend_right_arm()
{
    if ( !isdefined( self.right_arm_retracted ) )
    {
        self.right_arm_retracted = 0;
    }
    
    if ( !self.right_arm_retracted )
    {
        return;
    }
    
    self.right_arm_retracted = 0;
    self useanimtree( #animtree );
    self clientfield::set( "siegebot_retract_right_arm", 0 );
    self clearanim( %ai_siegebot_base_mp_right_arm_retract, 0.2 );
    self setanim( %ai_siegebot_base_mp_right_arm_extend, 1 );
    wait 0.1;
    
    if ( self.right_arm_retracted == 0 )
    {
        self clearanim( %ai_siegebot_base_mp_right_arm_extend, 0.1 );
    }
}

// Namespace siegebot
// Params 0
// Checksum 0x1ae26752, Offset: 0x5dd8
// Size: 0x1c8
function watch_left_arm()
{
    self endon( #"death" );
    self endon( #"exit_vehicle" );
    wait randomfloatrange( 0.05, 0.3 );
    
    while ( true )
    {
        ref_origin = self gettagorigin( "tag_turret" );
        ref_angles = self gettagangles( "tag_turret" );
        forward = anglestoforward( ref_angles );
        right = anglestoright( ref_angles );
        ref_origin += right * -60;
        trace_start = ref_origin + forward * 40;
        trace_end = ref_origin + forward * -30;
        trace = physicstrace( trace_start, trace_end, ( -8, -8, -8 ), ( 8, 8, 8 ), self, 1 | 8 );
        
        if ( trace[ "fraction" ] < 1 )
        {
            self retract_left_arm();
        }
        else
        {
            self extend_left_arm();
        }
        
        wait 0.2;
    }
}

// Namespace siegebot
// Params 0
// Checksum 0x59fb0dfd, Offset: 0x5fa8
// Size: 0x1c8
function watch_right_arm()
{
    self endon( #"death" );
    self endon( #"exit_vehicle" );
    wait randomfloatrange( 0.05, 0.3 );
    
    while ( true )
    {
        ref_origin = self gettagorigin( "tag_turret" );
        ref_angles = self gettagangles( "tag_turret" );
        forward = anglestoforward( ref_angles );
        right = anglestoright( ref_angles );
        ref_origin += right * 60;
        trace_start = ref_origin + forward * 40;
        trace_end = ref_origin + forward * -30;
        trace = physicstrace( trace_start, trace_end, ( -8, -8, -8 ), ( 8, 8, 8 ), self, 1 | 8 );
        
        if ( trace[ "fraction" ] < 1 )
        {
            self retract_right_arm();
        }
        else
        {
            self extend_right_arm();
        }
        
        wait 0.2;
    }
}

// Namespace siegebot
// Params 1
// Checksum 0x36bd888a, Offset: 0x6178
// Size: 0x32c
function does_rocket_shoot_through_wall( use_old_trace )
{
    if ( use_old_trace && isdefined( self.rocket_wall_origin_offset ) )
    {
        base_tag_angles = self gettagangles( "tag_turret" );
        base_forward = anglestoforward( base_tag_angles );
        base_right = anglestoright( base_tag_angles );
        base_up = anglestoup( base_tag_angles );
        offset = self.rocket_wall_origin_offset;
        ref_origin = self.origin + offset[ 0 ] * base_forward + offset[ 1 ] * base_right + offset[ 2 ] * base_up;
        ref_angles = base_tag_angles + self.rocket_wall_angles_offset;
    }
    else
    {
        ref_origin = self gettagorigin( "tag_gunner_flash2b" );
        ref_angles = self gettagangles( "tag_gunner_flash2b" );
    }
    
    forward = anglestoforward( ref_angles );
    trace_start = ref_origin + forward * 12;
    trace_end = ref_origin + forward * -12;
    trace = physicstrace( trace_start, trace_end, ( -2, -2, -2 ), ( 2, 2, 2 ), self, 1 | 8 );
    shoot_through_wall = trace[ "fraction" ] < 1;
    
    if ( shoot_through_wall )
    {
        if ( !isdefined( base_tag_angles ) )
        {
            base_tag_angles = self gettagangles( "tag_turret" );
            base_forward = anglestoforward( base_tag_angles );
            base_right = anglestoright( base_tag_angles );
            base_up = anglestoup( base_tag_angles );
        }
        
        ref_offset = ref_origin - self.origin;
        self.rocket_wall_origin_offset = ( vectordot( ref_offset, base_forward ), vectordot( ref_offset, base_right ), vectordot( ref_offset, base_up ) );
        self.rocket_wall_angles_offset = ref_angles - base_tag_angles;
    }
    
    return shoot_through_wall;
}

// Namespace siegebot
// Params 0
// Checksum 0x5da6e313, Offset: 0x64b0
// Size: 0x4c
function on_player_disconnected()
{
    player = self;
    
    if ( isdefined( player ) && isdefined( player.current_map_vehicle ) )
    {
        player.current_map_vehicle notify( #"exit_vehicle", player );
    }
}

