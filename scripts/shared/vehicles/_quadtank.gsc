#using scripts/codescripts/struct;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/gametypes/_globallogic_ui;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/clientfield_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
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

#namespace quadtank;

// Namespace quadtank
// Params 0, eflags: 0x2
// Checksum 0x3bb21369, Offset: 0x8e0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "quadtank", &__init__, undefined, undefined );
}

// Namespace quadtank
// Params 0
// Checksum 0x58dd96e9, Offset: 0x920
// Size: 0x8c
function __init__()
{
    vehicle::add_main_callback( "quadtank", &quadtank_initialize );
    clientfield::register( "toplayer", "player_shock_fx", 1, 1, "int" );
    clientfield::register( "vehicle", "quadtank_trophy_state", 1, 1, "int" );
}

#using_animtree( "generic" );

// Namespace quadtank
// Params 0
// Checksum 0x24b7e787, Offset: 0x9b8
// Size: 0x3dc
function quadtank_initialize()
{
    self useanimtree( #animtree );
    self enableaimassist();
    self setneargoalnotifydist( 50 );
    blackboard::createblackboardforentity( self );
    self blackboard::registervehicleblackboardattributes();
    self.turret_state = 1;
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.maxsightdistsqrd = 10000 * 10000;
    self.weakpointobjective = 0;
    self.combatactive = 1;
    self.damage_during_trophy_down = 0;
    self.spike_hits_during_trophy_down = 0;
    self.trophy_disables = 0;
    self.allow_movement = 1;
    assert( isdefined( self.scriptbundlesettings ) );
    self.settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    objectives::set( "cp_quadtank_rocket_icon", self );
    objectives::hide_for_target( "cp_quadtank_rocket_icon", self );
    self.variant = "cannon";
    
    if ( issubstr( self.vehicletype, "mlrs" ) )
    {
        self.variant = "rocketpod";
    }
    
    self.goalradius = 9999999;
    self.goalheight = 512;
    self setgoal( self.origin, 0, self.goalradius, self.goalheight );
    self setspeed( self.settings.defaultmovespeed, 10, 10 );
    self setmindesiredturnyaw( 45 );
    self show_weak_spots( 0 );
    turret::_init_turret( 1 );
    turret::_init_turret( 2 );
    turret::set_best_target_func( &_get_best_target_quadtank_side_turret, 1 );
    turret::set_best_target_func( &_get_best_target_quadtank_side_turret, 2 );
    self quadtank_update_difficulty();
    self quadtank_side_turrets_forward();
    self.overridevehicledamage = &quadtankcallback_vehicledamage;
    
    if ( isdefined( level.vehicle_initializer_cb ) )
    {
        [[ level.vehicle_initializer_cb ]]( self );
    }
    
    self.ignorefirefly = 1;
    self.ignoredecoy = 1;
    self vehicle_ai::initthreatbias();
    self.disableelectrodamage = 1;
    self.disableburndamage = 1;
    self thread vehicle_ai::target_hijackers();
    self hidepart( "tag_defense_active" );
    defaultrole();
}

// Namespace quadtank
// Params 0
// Checksum 0x515ea16, Offset: 0xda0
// Size: 0x13c
function quadtank_update_difficulty()
{
    if ( isdefined( level.players ) )
    {
        value = level.players.size;
    }
    else
    {
        value = 1;
    }
    
    scale_up = mapfloat( 1, 4, 1, 1.5, value );
    scale_down = mapfloat( 1, 4, 1, 0.75, value );
    turret::set_burst_parameters( 1.5, 2.5 * scale_up, 0.25 * scale_down, 0.75 * scale_down, 1 );
    turret::set_burst_parameters( 1.5, 2.5 * scale_up, 0.25 * scale_down, 0.75 * scale_down, 2 );
    self.difficulty_scale_up = scale_up;
    self.difficulty_scale_down = scale_down;
}

// Namespace quadtank
// Params 0
// Checksum 0xa7ea5204, Offset: 0xee8
// Size: 0x20c
function defaultrole()
{
    self.state_machine = self vehicle_ai::init_state_machine_for_role( "default" );
    self vehicle_ai::get_state_callbacks( "pain" ).update_func = &pain_update;
    self vehicle_ai::get_state_callbacks( "emped" ).update_func = &quadtank_emped;
    self vehicle_ai::get_state_callbacks( "off" ).enter_func = &state_off_enter;
    self vehicle_ai::get_state_callbacks( "off" ).exit_func = &state_off_exit;
    self vehicle_ai::get_state_callbacks( "scripted" ).update_func = &state_scripted_update;
    self vehicle_ai::get_state_callbacks( "driving" ).update_func = &state_driving_update;
    self vehicle_ai::get_state_callbacks( "combat" ).update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks( "combat" ).exit_func = &state_combat_exit;
    self vehicle_ai::get_state_callbacks( "death" ).update_func = &quadtank_death;
    self vehicle_ai::call_custom_add_state_callbacks();
    self vehicle_ai::startinitialstate();
}

// Namespace quadtank
// Params 0
// Checksum 0xaf1a9dd7, Offset: 0x1100
// Size: 0x30
function quadtank_off()
{
    self vehicle_ai::set_state( "off" );
    self.combatactive = 0;
}

// Namespace quadtank
// Params 0
// Checksum 0xc2bec379, Offset: 0x1138
// Size: 0x30
function quadtank_on()
{
    self vehicle_ai::set_state( "combat" );
    self.combatactive = 1;
}

// Namespace quadtank
// Params 1
// Checksum 0xb0a2e301, Offset: 0x1170
// Size: 0x1e4
function state_off_enter( params )
{
    self playsound( "veh_quadtank_power_down" );
    self laseroff();
    self cleartargetentity();
    self cancelaimove();
    self clearvehgoalpos();
    vehicle_ai::turnoffalllightsandlaser();
    vehicle_ai::turnoffallambientanims();
    self vehicle::toggle_tread_fx( 0 );
    self vehicle::toggle_sounds( 0 );
    self vehicle::toggle_exhaust_fx( 0 );
    angles = self gettagangles( "tag_flash" );
    target_vec = self.origin + anglestoforward( ( 0, angles[ 1 ], 0 ) ) * 1000;
    target_vec += ( 0, 0, -500 );
    self settargetorigin( target_vec );
    self set_side_turrets_enabled( 0 );
    self thread quadtank_disabletrophy();
    
    if ( !isdefined( self.emped ) )
    {
        self disableaimassist();
    }
}

// Namespace quadtank
// Params 1
// Checksum 0xaece5e52, Offset: 0x1360
// Size: 0x9c
function state_off_exit( params )
{
    self vehicle::lights_on();
    self vehicle::toggle_tread_fx( 1 );
    self vehicle::toggle_sounds( 1 );
    self thread bootup();
    self vehicle::toggle_exhaust_fx( 1 );
    self enableaimassist();
}

// Namespace quadtank
// Params 0
// Checksum 0x6bd57b2c, Offset: 0x1408
// Size: 0x128
function bootup()
{
    self endon( #"death" );
    self playsound( "veh_quadtank_power_up" );
    self vehicle_ai::blink_lights_for_time( 1.5 );
    angles = self gettagangles( "tag_flash" );
    target_vec = self.origin + anglestoforward( ( 0, angles[ 1 ], 0 ) ) * 1000;
    self.turretrotscale = 0.3;
    driver = self getseatoccupant( 0 );
    
    if ( !isdefined( driver ) )
    {
        self settargetorigin( target_vec );
    }
    
    wait 1;
    self.turretrotscale = 1 * self.difficulty_scale_up;
}

// Namespace quadtank
// Params 1
// Checksum 0x8403abf0, Offset: 0x1538
// Size: 0x1cc
function pain_update( params )
{
    self endon( #"change_state" );
    self endon( #"death" );
    istrophydownpain = params.notify_param[ 0 ];
    
    if ( istrophydownpain === 1 )
    {
        asmstate = "trophy_disabled@stationary";
    }
    else
    {
        asmstate = "pain@stationary";
    }
    
    self asmrequestsubstate( asmstate );
    playsoundatposition( "prj_quad_impact", self.origin );
    self cancelaimove();
    self clearvehgoalpos();
    self clearturrettarget();
    self setbrake( 1 );
    self vehicle_ai::waittill_asm_complete( asmstate, 6 );
    self setbrake( 0 );
    self asmrequestsubstate( "locomotion@movement" );
    driver = self getseatoccupant( 0 );
    
    if ( !isdefined( driver ) )
    {
        self vehicle_ai::set_state( "combat" );
        return;
    }
    
    self vehicle_ai::set_state( "driving" );
}

// Namespace quadtank
// Params 1
// Checksum 0xbe84bad3, Offset: 0x1710
// Size: 0xbc
function state_scripted_update( params )
{
    self endon( #"death" );
    self endon( #"change_state" );
    self set_side_turrets_enabled( 0 );
    self laseroff();
    self cleartargetentity();
    self cancelaimove();
    self clearvehgoalpos();
    self vehicle::toggle_ambient_anim_group( 2, 1 );
}

// Namespace quadtank
// Params 1
// Checksum 0xd65fa606, Offset: 0x17d8
// Size: 0x1cc
function state_driving_update( params )
{
    self endon( #"death" );
    self endon( #"change_state" );
    self set_side_turrets_enabled( 0 );
    self laseroff();
    self cleartargetentity();
    self cancelaimove();
    self clearvehgoalpos();
    self vehicle::toggle_ambient_anim_group( 2, 1 );
    objectives::hide_for_target( "cp_quadtank_rocket_icon", self );
    driver = self getseatoccupant( 0 );
    
    if ( isdefined( driver ) )
    {
        self.turretrotscale = 1;
        self disableaimassist();
        self thread quadtank_set_team( driver.team );
        self setbrake( 0 );
        self asmrequestsubstate( "locomotion@movement" );
        self thread quadtank_player_fireupdate();
        self thread footstep_handler();
        self.trophy_disables = 3;
        self thread quadtank_disabletrophy();
    }
}

// Namespace quadtank
// Params 0
// Checksum 0x1b9d90c7, Offset: 0x19b0
// Size: 0x24
function quadtank_exit_vehicle()
{
    self setgoal( self.origin );
}

// Namespace quadtank
// Params 1
// Checksum 0xd0489819, Offset: 0x19e0
// Size: 0x12e
function state_combat_update( params )
{
    self endon( #"death" );
    self endon( #"change_state" );
    
    if ( isalive( self ) )
    {
    }
    
    if ( isalive( self ) && !trophy_disabled() )
    {
        self thread quadtank_enabletrophy();
    }
    
    if ( self.allow_movement )
    {
        self thread quadtank_movementupdate();
    }
    else
    {
        self setbrake( 1 );
    }
    
    switch ( self.variant )
    {
        case "cannon":
            vehicle_ai::cooldown( "main_cannon", 4 );
            self thread quadtank_weapon_think_cannon();
            break;
        default:
            self thread attack_thread_rocket();
            break;
    }
}

// Namespace quadtank
// Params 1
// Checksum 0xa900c375, Offset: 0x1b18
// Size: 0x54
function state_combat_exit( params )
{
    self notify( #"end_attack_thread" );
    self notify( #"end_movement_thread" );
    self clearturrettarget();
    self clearlookatent();
}

// Namespace quadtank
// Params 1
// Checksum 0x74c7bddc, Offset: 0x1b78
// Size: 0x28c
function quadtank_death( params )
{
    self endon( #"death" );
    self endon( #"nodeath_thread" );
    self set_trophy_state( 0 );
    self quadtank_weakpoint_display( 0 );
    objectives::hide_for_target( "cp_quadtank_rocket_icon", self );
    self remove_repulsor();
    self hidepart( "tag_lidar_null", "", 1 );
    self vehicle::set_damage_fx_level( 0 );
    streamermodelhint( self.deathmodel, 6 );
    
    if ( !isdefined( self.custom_death_sequence ) )
    {
        playsoundatposition( "prj_quad_impact", self.origin );
        self playsound( "veh_quadtank_power_down" );
        self playsound( "veh_quadtank_sparks" );
        self asmrequestsubstate( "death@stationary" );
        self waittill( #"explosion_c" );
    }
    else
    {
        self [[ self.custom_death_sequence ]]();
    }
    
    if ( isdefined( level.disable_thermal ) )
    {
        [[ level.disable_thermal ]]();
    }
    
    if ( isdefined( self.stun_fx ) )
    {
        self.stun_fx delete();
    }
    
    badplace_box( "", 0, self.origin, 90, "neutral" );
    self vehicle_death::set_death_model( self.deathmodel, self.modelswapdelay );
    self vehicle_death::death_radius_damage();
    vehicle_ai::waittill_asm_complete( "death@stationary", 5 );
    self thread vehicle_death::cleanup();
    vehicle_death::freewhensafe();
}

// Namespace quadtank
// Params 1
// Checksum 0x2a37805b, Offset: 0x1e10
// Size: 0x20c
function quadtank_emped( params )
{
    self endon( #"death" );
    self endon( #"change_state" );
    self endon( #"emped" );
    
    if ( isdefined( self.emped ) )
    {
        return;
    }
    
    self.emped = 1;
    playsoundatposition( "veh_quadtankemp_down", self.origin );
    self.turretrotscale = 0.2;
    
    if ( !isdefined( self.stun_fx ) )
    {
        self.stun_fx = spawn( "script_model", self.origin );
        self.stun_fx setmodel( "tag_origin" );
        self.stun_fx linkto( self, "tag_turret", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    time = params.notify_param[ 0 ];
    assert( isdefined( time ) );
    vehicle_ai::cooldown( "emped_timer", time );
    
    while ( !vehicle_ai::iscooldownready( "emped_timer" ) )
    {
        timeleft = max( vehicle_ai::getcooldownleft( "emped_timer" ), 0.5 );
        wait timeleft;
    }
    
    self.stun_fx delete();
    self.emped = undefined;
    self playsound( "veh_boot_quadtank" );
    self vehicle_ai::evaluate_connections();
}

// Namespace quadtank
// Params 0
// Checksum 0x240566e0, Offset: 0x2028
// Size: 0x36, Type: bool
function trophy_disabled()
{
    if ( self.trophy_down === 1 )
    {
        return true;
    }
    
    if ( trophy_destroyed() )
    {
        return true;
    }
    
    return false;
}

// Namespace quadtank
// Params 0
// Checksum 0x985fc96b, Offset: 0x2068
// Size: 0x1c, Type: bool
function trophy_destroyed()
{
    if ( self.trophy_disables >= 4 )
    {
        return true;
    }
    
    return false;
}

// Namespace quadtank
// Params 1
// Checksum 0xaa72dc4b, Offset: 0x2090
// Size: 0x2c
function set_trophy_state( ison )
{
    self clientfield::set( "quadtank_trophy_state", ison );
}

// Namespace quadtank
// Params 0
// Checksum 0xf48fc13f, Offset: 0x20c8
// Size: 0x4a4
function quadtank_disabletrophy()
{
    self endon( #"death" );
    self notify( #"stop_disabletrophy" );
    self endon( #"stop_disabletrophy" );
    self notify( #"stop_enabletrophy" );
    set_trophy_state( 0 );
    
    if ( trophy_disabled() )
    {
        return;
    }
    
    self.trophy_down = 1;
    driver = self getseatoccupant( 0 );
    
    if ( !isdefined( driver ) && self vehicle_ai::get_current_state() != "off" && self vehicle_ai::get_next_state() !== "off" )
    {
        self notify( #"pain", 1 );
    }
    
    target_set( self, ( 0, 0, 60 ) );
    self hidepart( "tag_defense_active" );
    self.attackeraccuracy = 0.5;
    self.damage_during_trophy_down = 0;
    self.spike_hits_during_trophy_down = 0;
    self.trophy_disables += 1;
    self quadtank_weakpoint_display( 0 );
    self remove_repulsor();
    driver = self getseatoccupant( 0 );
    
    if ( !isdefined( driver ) && self vehicle_ai::get_current_state() != "off" && self vehicle_ai::get_next_state() !== "off" )
    {
        objectives::show_for_target( "cp_quadtank_rocket_icon", self );
    }
    else
    {
        objectives::hide_for_target( "cp_quadtank_rocket_icon", self );
    }
    
    self set_side_turrets_enabled( 0 );
    
    if ( isdefined( level.vehicle_defense_cb ) )
    {
        [[ level.vehicle_defense_cb ]]( self, 0 );
    }
    
    if ( trophy_destroyed() )
    {
        self notify( #"trophy_system_destroyed" );
        level notify( #"trophy_system_destroyed", self );
        self playsound( "wpn_trophy_disable" );
        playfxontag( self.settings.trophydetonationfx, self, "tag_target_lower" );
        self hidepart( "tag_lidar_null", "", 1 );
        return;
    }
    
    self notify( #"trophy_system_disabled" );
    level notify( #"trophy_system_disabled", self );
    self playsound( "wpn_trophy_disable" );
    self vehicle_ai::cooldown( "trophy_down", self.settings.trophysystemdowntime );
    
    while ( !self vehicle_ai::iscooldownready( "trophy_down" ) || self vehicle_ai::get_current_state() === "off" )
    {
        if ( self.damage_during_trophy_down >= self.settings.trophysystemdisablethreshold || vehicle_ai::getcooldownleft( "trophy_down" ) < 0.5 * self.settings.trophysystemdowntime && self.spike_hits_during_trophy_down >= 5 )
        {
            self vehicle_ai::clearcooldown( "trophy_down" );
        }
        
        wait 1;
    }
    
    driver = self getseatoccupant( 0 );
    
    if ( isdefined( driver ) )
    {
        self.trophy_disables = 4;
    }
    
    if ( !trophy_destroyed() )
    {
        self thread quadtank_enabletrophy();
    }
}

// Namespace quadtank
// Params 0
// Checksum 0xc2bd8fbf, Offset: 0x2578
// Size: 0x29a
function quadtank_enabletrophy()
{
    self endon( #"death" );
    self notify( #"stop_enabletrophy" );
    self endon( #"stop_enabletrophy" );
    set_trophy_state( 1 );
    time = isdefined( self.settings.trophywarmup ) ? self.settings.trophywarmup : 0.1;
    wait time;
    driver = self getseatoccupant( 0 );
    self.trophy_down = 0;
    self.attackeraccuracy = 1;
    self showpart( "tag_defense_active" );
    objectives::hide_for_target( "cp_quadtank_rocket_icon", self );
    self quadtank_projectile_watcher();
    self thread quadtank_automelee_update();
    
    if ( !isdefined( driver ) )
    {
        self quadtank_weakpoint_display( 1 );
    }
    else
    {
        self quadtank_weakpoint_display( 0 );
    }
    
    if ( target_istarget( self ) )
    {
        target_remove( self );
    }
    
    if ( !isdefined( driver ) )
    {
        self set_side_turrets_enabled( 1 );
    }
    
    self.trophy_system_health = self.settings.trophysystemhealth;
    
    if ( isdefined( level.players ) && level.players.size > 0 )
    {
        num_players_trophy_health_modifier = 0.75;
        
        if ( level.players.size == 2 )
        {
            num_players_trophy_health_modifier = 1;
        }
        
        if ( level.players.size == 3 )
        {
            num_players_trophy_health_modifier = 1.25;
        }
        
        if ( level.players.size >= 4 )
        {
            num_players_trophy_health_modifier = 1.5;
        }
        
        self.trophy_system_health *= num_players_trophy_health_modifier;
    }
    
    if ( isdefined( level.vehicle_defense_cb ) )
    {
        [[ level.vehicle_defense_cb ]]( self, 1 );
    }
    
    self notify( #"trophy_system_enabled" );
    level notify( #"trophy_system_enabled", self );
}

// Namespace quadtank
// Params 0
// Checksum 0xe3312b7a, Offset: 0x2820
// Size: 0x68
function quadtank_side_turrets_forward()
{
    self setturrettargetrelativeangles( ( 10, -90, 0 ), 1 );
    self setturrettargetrelativeangles( ( 10, 90, 0 ), 2 );
    self.turretrotscale = 1 * self.difficulty_scale_up;
}

// Namespace quadtank
// Params 1
// Checksum 0xb6b66a13, Offset: 0x2890
// Size: 0x2c0
function quadtank_turret_scan( scan_forever )
{
    self endon( #"death" );
    self endon( #"change_state" );
    self.turretrotscale = 0.3;
    
    while ( !isdefined( self.enemy ) || scan_forever || !self vehcansee( self.enemy ) )
    {
        if ( self.turretontarget && self.turret_state != 0 )
        {
            self.turret_state++;
            
            if ( self.turret_state >= 5 )
            {
                self.turret_state = 1;
            }
        }
        
        switch ( self.turret_state )
        {
            case 0:
                if ( isdefined( self.enemy ) )
                {
                    self setlookatent( self.enemy );
                    target_vec = self.enemy.origin + ( 0, 0, 40 );
                    self settargetorigin( target_vec );
                    wait 1;
                    self clearlookatent();
                    self.turret_state++;
                }
            case 1:
                target_vec = self.origin + anglestoforward( ( 0, self.angles[ 1 ], 0 ) ) * 1000;
                break;
            case 2:
                target_vec = self.origin + anglestoforward( ( 0, self.angles[ 1 ] + 30, 0 ) ) * 1000;
                break;
            case 3:
                target_vec = self.origin + anglestoforward( ( 0, self.angles[ 1 ], 0 ) ) * 1000;
                break;
            case 4:
                target_vec = self.origin + anglestoforward( ( 0, self.angles[ 1 ] - 30, 0 ) ) * 1000;
                break;
        }
        
        target_vec += ( 0, 0, 40 );
        self settargetorigin( target_vec );
        wait 0.2;
    }
}

// Namespace quadtank
// Params 1
// Checksum 0x499ab7cf, Offset: 0x2b58
// Size: 0x74
function set_side_turrets_enabled( on )
{
    if ( on )
    {
        turret::enable( 1, 0 );
        turret::enable( 2, 0 );
        return;
    }
    
    turret::disable( 1 );
    turret::disable( 2 );
}

// Namespace quadtank
// Params 1
// Checksum 0x908fa68, Offset: 0x2bd8
// Size: 0x44
function show_weak_spots( show )
{
    if ( show )
    {
        self vehicle::toggle_exhaust_fx( 1 );
        return;
    }
    
    self vehicle::toggle_exhaust_fx( 0 );
}

// Namespace quadtank
// Params 1
// Checksum 0xd37057ed, Offset: 0x2c28
// Size: 0x13c
function set_detonation_time( target )
{
    self endon( #"change_state" );
    self playsound( "veh_quadtank_cannon_charge" );
    self waittill( #"weapon_fired", proj );
    self thread railgun_sound( proj );
    
    if ( isdefined( target ) && isdefined( proj ) )
    {
        vel = proj getvelocity();
        proj_speed = length( vel );
        dist = distance( proj.origin, target.origin ) + randomfloatrange( 0, 40 );
        time_to_enemy = dist / proj_speed;
        proj resetmissiledetonationtime( time_to_enemy );
    }
}

// Namespace quadtank
// Params 0
// Checksum 0xc2115316, Offset: 0x2d70
// Size: 0x620
function quadtank_weapon_think_cannon()
{
    self endon( #"death" );
    self endon( #"change_state" );
    cant_see_enemy_count = 0;
    self set_side_turrets_enabled( 1 );
    self setontargetangle( 10 );
    self.getreadytofire = undefined;
    
    while ( true )
    {
        if ( self.hold_cannon === 1 || !vehicle_ai::iscooldownready( "main_cannon" ) )
        {
            if ( isdefined( self.enemy ) && self vehcansee( self.enemy ) )
            {
                self setturrettargetent( self.enemy );
                self setlookatent( self.enemy );
            }
            
            wait 0.2;
            continue;
        }
        
        if ( isdefined( self.enemy ) && self vehcansee( self.enemy ) )
        {
            self.turretrotscale = 1 * self.difficulty_scale_up;
            self setturrettargetent( self.enemy );
            self setlookatent( self.enemy );
            
            if ( cant_see_enemy_count >= 2 )
            {
                wait 0.1;
                self cancelaimove();
                self clearvehgoalpos();
                self notify( #"near_goal" );
            }
            
            cant_see_enemy_count = 0;
            fired = 0;
            
            if ( isdefined( self.enemy ) && self vehcansee( self.enemy ) )
            {
                if ( distancesquared( self.origin, self.enemy.origin ) > 72900 && self.turretontarget )
                {
                    v_my_forward = anglestoforward( self.angles );
                    v_to_enemy = self.enemy.origin - self.origin;
                    v_to_enemy = vectornormalize( v_to_enemy );
                    dot = vectordot( v_to_enemy, v_my_forward );
                    
                    if ( dot > 0.707 )
                    {
                        self asmrequestsubstate( "fire@stationary" );
                        self setturrettargetent( self.enemy );
                        self thread set_detonation_time( self.enemy );
                        
                        if ( isdefined( level.players ) && level.players.size < 3 )
                        {
                            self set_side_turrets_enabled( 0 );
                        }
                        
                        self show_weak_spots( 1 );
                        self.getreadytofire = 1;
                        fired = 1;
                        self cancelaimove();
                        self clearvehgoalpos();
                        self notify( #"near_goal" );
                        self.turretrotscale = 0.7;
                        wait 1;
                        level notify( #"sndstopcountdown" );
                        self vehicle_ai::waittill_asm_complete( "fire@stationary", 6 );
                        self set_side_turrets_enabled( 1 );
                        self.turretrotscale = 1;
                    }
                }
            }
            
            self.getreadytofire = undefined;
            
            if ( isdefined( self.enemy ) )
            {
                self setturrettargetent( self.enemy );
                self setlookatent( self.enemy );
            }
            
            if ( fired )
            {
                self show_weak_spots( 0 );
                vehicle_ai::cooldown( "main_cannon", randomfloatrange( 5, 7.5 ) );
            }
            else
            {
                wait 0.25;
            }
            
            continue;
        }
        
        cant_see_enemy_count++;
        wait 0.5;
        
        if ( cant_see_enemy_count > 40 )
        {
            self quadtank_turret_scan( 0 );
            continue;
        }
        
        if ( cant_see_enemy_count > 30 )
        {
            self clearlookatent();
            self cleartargetentity();
            continue;
        }
        
        if ( isdefined( self.enemy ) )
        {
            self setturrettargetent( self.enemy );
            self clearlookatent();
            continue;
        }
        
        self clearlookatent();
        self quadtank_turret_scan( 0 );
    }
}

// Namespace quadtank
// Params 0
// Checksum 0x79b1937f, Offset: 0x3398
// Size: 0x566
function attack_thread_rocket()
{
    self endon( #"death" );
    self endon( #"end_attack_thread" );
    self vehicle::toggle_ambient_anim_group( 2, 0 );
    
    while ( true )
    {
        usejavelin = 0;
        
        if ( isdefined( self.enemy ) )
        {
            self setturrettargetent( self.enemy );
            self setlookatent( self.enemy );
        }
        
        if ( isdefined( self.enemy ) && vehicle_ai::iscooldownready( "javelin_rocket_launcher", 0.5 ) )
        {
            if ( isvehicle( self.enemy ) || distance2dsquared( self.origin, self.enemy.origin ) >= 800 * 800 )
            {
                usejavelin = !self vehseenrecently( self.enemy, 3 ) || randomint( 100 ) < 3;
            }
        }
        
        if ( isdefined( self.enemy ) && vehicle_ai::iscooldownready( "rocket_launcher", 0.5 ) )
        {
            if ( isdefined( level.players ) && level.players.size < 3 )
            {
                self set_side_turrets_enabled( 0 );
            }
            
            self clearvehgoalpos();
            self notify( #"near_goal" );
            self show_weak_spots( 1 );
            self vehicle::toggle_ambient_anim_group( 2, 1 );
            
            if ( !usejavelin )
            {
                self setvehweapon( getweapon( "quadtank_main_turret_rocketpods_straight" ) );
                offset = ( 0, 0, -50 );
                
                if ( isplayer( self.enemy ) )
                {
                    origin = self.enemy.origin;
                    eye = self.enemy geteye();
                    offset = ( 0, 0, origin[ 2 ] - eye[ 2 ] - 5 );
                }
                
                vehicle_ai::setturrettarget( self.enemy, 0, offset );
            }
            else
            {
                self playsound( "veh_quadtank_mlrs_plant_start" );
                self setvehweapon( getweapon( "quadtank_main_turret_rocketpods_javelin" ) );
                vehicle_ai::setturrettarget( self.enemy, 0, ( 0, 0, 300 ) );
            }
            
            wait 1;
            msg = self util::waittill_any_timeout( 2, "turret_on_target" );
            
            if ( isdefined( self.enemy ) && distance2dsquared( self.origin, self.enemy.origin ) > 350 * 350 )
            {
                fired = 0;
                
                for ( i = 0; i < 4 && isdefined( self.enemy ) ; i++ )
                {
                    if ( usejavelin )
                    {
                        if ( isplayer( self.enemy ) )
                        {
                            self thread vehicle_ai::javelin_losetargetatrighttime( self.enemy );
                        }
                        
                        self thread javeline_incoming( getweapon( "quadtank_main_turret_rocketpods_javelin" ) );
                    }
                    
                    self fireweapon( 0, self.enemy );
                    fired = 1;
                    wait 0.8;
                }
                
                if ( fired )
                {
                    vehicle_ai::cooldown( "rocket_launcher", randomfloatrange( 8, 10 ) );
                    
                    if ( usejavelin )
                    {
                        vehicle_ai::cooldown( "javelin_rocket_launcher", 20 );
                    }
                }
            }
            
            self set_side_turrets_enabled( 1 );
            self vehicle::toggle_ambient_anim_group( 2, 0 );
        }
        
        wait 1;
    }
}

// Namespace quadtank
// Params 0
// Checksum 0x7838d4dd, Offset: 0x3908
// Size: 0x54
function trigger_player_shock_fx()
{
    if ( !isdefined( self._player_shock_fx_quadtank_melee ) )
    {
        self._player_shock_fx_quadtank_melee = 0;
    }
    
    self._player_shock_fx_quadtank_melee = !self._player_shock_fx_quadtank_melee;
    self clientfield::set_to_player( "player_shock_fx", self._player_shock_fx_quadtank_melee );
}

// Namespace quadtank
// Params 0
// Checksum 0xddfc8e6a, Offset: 0x3968
// Size: 0x190
function path_update_interrupt()
{
    self endon( #"death" );
    self endon( #"change_state" );
    self endon( #"near_goal" );
    self endon( #"reached_end_node" );
    wait 1;
    cantseeenemycount = 0;
    
    while ( true )
    {
        if ( isdefined( self.current_pathto_pos ) )
        {
            if ( isdefined( self.enemy ) )
            {
                if ( distance2dsquared( self.enemy.origin, self.current_pathto_pos ) < 62500 )
                {
                    self.move_now = 1;
                    self notify( #"near_goal" );
                }
                
                if ( !self vehcansee( self.enemy ) )
                {
                    if ( !self vehicle_ai::canseeenemyfromposition( self.current_pathto_pos, self.enemy, 80 ) )
                    {
                        cantseeenemycount++;
                        
                        if ( cantseeenemycount > 5 )
                        {
                            self.move_now = 1;
                            self notify( #"near_goal" );
                        }
                    }
                }
            }
            
            if ( distance2dsquared( self.current_pathto_pos, self.goalpos ) > self.goalradius * self.goalradius )
            {
                wait 1;
                self.move_now = 1;
                self notify( #"near_goal" );
            }
        }
        
        wait 0.3;
    }
}

// Namespace quadtank
// Params 0
// Checksum 0x9987bf0f, Offset: 0x3b00
// Size: 0x50a
function movement_thread_wander()
{
    self endon( #"death" );
    self endon( #"change_state" );
    self notify( #"end_movement_thread" );
    self endon( #"end_movement_thread" );
    
    if ( self.goalforced )
    {
        return self.goalpos;
    }
    
    minsearchradius = 0;
    maxsearchradius = 2000;
    halfheight = 300;
    innerspacing = 90;
    outerspacing = innerspacing * 2;
    maxgoaltimeout = 15;
    self asmrequestsubstate( "locomotion@movement" );
    wait 0.5;
    self setbrake( 0 );
    
    while ( true )
    {
        self setspeed( self.settings.defaultmovespeed, 5, 5 );
        pixbeginevent( "_quadtank::Movement_Thread_Wander" );
        queryresult = positionquery_source_navigation( self.origin, minsearchradius, maxsearchradius, halfheight, innerspacing, self, outerspacing );
        pixendevent();
        positionquery_filter_distancetogoal( queryresult, self );
        vehicle_ai::positionquery_filter_outofgoalanchor( queryresult );
        vehicle_ai::positionquery_filter_random( queryresult, 200, 250 );
        
        foreach ( point in queryresult.data )
        {
            if ( distance2dsquared( self.origin, point.origin ) < 28900 )
            {
                /#
                    if ( !isdefined( point._scoredebug ) )
                    {
                        point._scoredebug = [];
                    }
                    
                    point._scoredebug[ "<dev string:x28>" ] = -100;
                #/
                
                point.score += -100;
            }
        }
        
        self vehicle_ai::positionquery_debugscores( queryresult );
        vehicle_ai::positionquery_postprocess_sortscore( queryresult );
        foundpath = 0;
        goalpos = self.origin;
        count = queryresult.data.size;
        
        if ( count > 3 )
        {
            count = 3;
        }
        
        for ( i = 0; i < count && !foundpath ; i++ )
        {
            goalpos = queryresult.data[ i ].origin;
            foundpath = self setvehgoalpos( goalpos, 0, 1 );
        }
        
        if ( foundpath )
        {
            self.current_pathto_pos = goalpos;
            self thread path_update_interrupt();
            self asmrequestsubstate( "locomotion@movement" );
            msg = self util::waittill_any_timeout( maxgoaltimeout, "near_goal", "force_goal", "reached_end_node", "goal" );
            self cancelaimove();
            self clearvehgoalpos();
            
            if ( isdefined( self.move_now ) )
            {
                self.move_now = undefined;
                wait 0.1;
            }
            else
            {
                wait 0.5;
            }
            
            continue;
        }
        
        self.current_pathto_pos = undefined;
        goalyaw = self getgoalyaw();
        wait 1;
    }
}

// Namespace quadtank
// Params 0
// Checksum 0x37c5c0af, Offset: 0x4018
// Size: 0x248
function quadtank_movementupdate()
{
    self endon( #"death" );
    self endon( #"change_state" );
    self asmrequestsubstate( "locomotion@movement" );
    wait 0.5;
    self setbrake( 0 );
    
    while ( self.allow_movement )
    {
        if ( self.getreadytofire !== 1 )
        {
            goalpos = vehicle_ai::findnewposition( 80 );
            
            if ( distance2dsquared( goalpos, self.origin ) > 50 * 50 || isdefined( goalpos ) && abs( goalpos[ 2 ] - self.origin[ 2 ] ) > self.height )
            {
                self setspeed( self.settings.defaultmovespeed, 5, 5 );
                self setvehgoalpos( goalpos, 0, 1 );
                self.current_pathto_pos = goalpos;
                self thread path_update_interrupt();
                self asmrequestsubstate( "locomotion@movement" );
                result = self util::waittill_any_return( "near_goal", "reached_end_node", "force_goal" );
            }
            else
            {
                self notify( #"goal" );
            }
            
            self cancelaimove();
            self clearvehgoalpos();
            
            if ( isdefined( self.move_now ) )
            {
                self.move_now = undefined;
                wait 0.1;
            }
            else
            {
                wait 0.5;
            }
            
            continue;
        }
        
        while ( isdefined( self.getreadytofire ) )
        {
            wait 0.2;
        }
    }
}

// Namespace quadtank
// Params 0
// Checksum 0xc79e01f7, Offset: 0x4268
// Size: 0xce
function quadtank_player_fireupdate()
{
    self endon( #"death" );
    self endon( #"exit_vehicle" );
    weapon = self seatgetweapon( 1 );
    firetime = weapon.firetime;
    
    while ( true )
    {
        self setgunnertargetvec( self getgunnertargetvec( 0 ), 1 );
        
        if ( self isgunnerfiring( 0 ) )
        {
            self fireweapon( 2 );
        }
        
        wait firetime;
    }
}

// Namespace quadtank
// Params 2
// Checksum 0x7f972227, Offset: 0x4340
// Size: 0x438, Type: bool
function do_melee( shoulddodamage, enemy )
{
    if ( !isalive( enemy ) || distancesquared( enemy.origin, self.origin ) > 270 * 270 )
    {
        return false;
    }
    
    if ( vehicle_ai::entityisarchetype( enemy, "quadtank" ) || vehicle_ai::entityisarchetype( enemy, "raps" ) )
    {
        return false;
    }
    
    if ( isplayer( enemy ) && enemy laststand::player_is_in_laststand() )
    {
        return false;
    }
    
    self notify( #"play_meleefx" );
    
    if ( shoulddodamage )
    {
        players = getplayers();
        
        foreach ( player in players )
        {
            player._takedamage_old = player.takedamage;
            player.takedamage = 0;
        }
        
        radiusdamage( self.origin + ( 0, 0, 40 ), 270, 400, 400, self );
        
        foreach ( player in players )
        {
            player.takedamage = player._takedamage_old;
            player._takedamage_old = undefined;
        }
    }
    
    if ( isdefined( enemy ) && isplayer( enemy ) )
    {
        direction = ( ( enemy.origin - self.origin )[ 0 ], ( enemy.origin - self.origin )[ 1 ], 0 );
        
        if ( abs( direction[ 0 ] ) < 0.01 && abs( direction[ 1 ] ) < 0.01 )
        {
            direction = ( randomfloatrange( 1, 2 ), randomfloatrange( 1, 2 ), 0 );
        }
        
        direction = vectornormalize( direction );
        strength = 1000;
        enemy setvelocity( enemy getvelocity() + direction * strength );
        enemy trigger_player_shock_fx();
        enemy dodamage( 15, self.origin, self );
    }
    
    self playsound( "veh_quadtank_emp" );
    return true;
}

// Namespace quadtank
// Params 0
// Checksum 0x1cfe72e2, Offset: 0x4780
// Size: 0x140
function quadtank_automelee_update()
{
    self endon( #"death" );
    assert( isdefined( self.team ) );
    
    while ( !trophy_disabled() )
    {
        enemies = self getenemies();
        meleed = 0;
        
        foreach ( enemy in enemies )
        {
            if ( enemy isnotarget() )
            {
                continue;
            }
            
            meleed = meleed || self do_melee( !meleed, enemy );
            
            if ( meleed )
            {
                break;
            }
        }
        
        wait 0.3;
    }
}

// Namespace quadtank
// Params 1
// Checksum 0xc32e6eb5, Offset: 0x48c8
// Size: 0xbc
function quadtank_destroyturret( index )
{
    turret::disable( index );
    
    if ( index == 1 )
    {
        self hidepart( "tag_gunner_barrel1" );
        self hidepart( "tag_gunner_turret1" );
        return;
    }
    
    if ( index == 2 )
    {
        self hidepart( "tag_gunner_barrel2" );
        self hidepart( "tag_gunner_turret2" );
    }
}

// Namespace quadtank
// Params 15
// Checksum 0xedce8c5c, Offset: 0x4990
// Size: 0x6dc
function quadtankcallback_vehicledamage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    is_damaged_by_grenade = weapon.weapclass == "grenade";
    
    if ( issubstr( weapon.name, "spike" ) )
    {
        if ( eattacker.team !== self.team )
        {
            self.spike_hits_during_trophy_down += 1;
        }
        
        is_damaged_by_grenade = 0;
    }
    
    if ( isplayer( eattacker ) && eattacker.usingvehicle && ( eattacker == self || isdefined( eattacker ) && eattacker.viewlockedentity === self ) )
    {
        return 0;
    }
    
    if ( smeansofdeath === "MOD_MELEE" || smeansofdeath === "MOD_MELEE_WEAPON_BUTT" || smeansofdeath === "MOD_MELEE_ASSASSINATE" || smeansofdeath === "MOD_ELECTROCUTED" || smeansofdeath === "MOD_CRUSH" || weapon.isemp )
    {
        return 0;
    }
    
    if ( vehicle_ai::entityisarchetype( eattacker, "raps" ) && !trophy_disabled() )
    {
        self.trophy_system_health = 0;
        self.trophy_disables = 3;
        self thread quadtank_disabletrophy();
        
        if ( isplayer( eattacker ) && damagefeedback::dodamagefeedback( weapon, einflictor ) )
        {
            eattacker thread damagefeedback::update( smeansofdeath, einflictor );
        }
    }
    
    if ( partname == "tag_target_lower" || partname == "tag_target_upper" || partname == "tag_defense_active" || partname == "tag_body_animate" )
    {
        if ( isdefined( eattacker ) && isplayer( eattacker ) && eattacker.team != self.team )
        {
            if ( !isdefined( self.trophy_system_health ) )
            {
                self.trophy_system_health = self.settings.trophysystemhealth;
            }
            
            if ( !trophy_disabled() )
            {
                self.trophy_system_health -= idamage;
                quadtank_weakpoint_trigger();
                
                if ( self.trophy_system_health <= 0 )
                {
                    self thread quadtank_disabletrophy();
                }
                
                if ( isplayer( eattacker ) && damagefeedback::dodamagefeedback( weapon, einflictor ) )
                {
                    if ( idamage > 0 )
                    {
                        eattacker thread damagefeedback::update( smeansofdeath, einflictor );
                    }
                }
            }
        }
    }
    else if ( is_damaged_by_grenade )
    {
        idamage = int( idamage * 3 );
    }
    
    self.turret_state = 0;
    self.turretrotscale = 1 * self.difficulty_scale_up;
    self.turret_on_target = 1;
    
    if ( smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" )
    {
        return idamage;
    }
    
    if ( isactor( eattacker ) && idamage > 250 )
    {
        idamage = 250;
    }
    
    num_players = getplayers().size;
    maxdamage = self.healthdefault * ( 0.2 - 0.025 * num_players );
    
    if ( smeansofdeath !== "MOD_UNKNOWN" && idamage > maxdamage )
    {
        idamage = maxdamage;
    }
    
    damagelevelchanged = vehicle::update_damage_fx_level( self.health, idamage, self.healthdefault );
    driver = self getseatoccupant( 0 );
    
    if ( smeansofdeath != "MOD_UNKNOWN" && !vehicle_ai::entityisarchetype( eattacker, "quadtank" ) )
    {
        if ( self.damage_during_trophy_down + idamage > self.settings.trophysystemdisablethreshold && self.trophy_disables < 4 && !isdefined( driver ) )
        {
            idamage = max( 1, self.settings.trophysystemdisablethreshold - self.damage_during_trophy_down );
        }
        
        self.damage_during_trophy_down += idamage;
    }
    
    if ( ( !isdefined( eattacker ) || damagelevelchanged && smeansofdeath != "MOD_MELEE_ASSASSINATE" && eattacker.team !== self.team ) && !isdefined( driver ) )
    {
        playsoundatposition( "prj_quad_impact", self.origin );
    }
    
    idamage = vehicle_ai::shared_callback_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal );
    return idamage;
}

// Namespace quadtank
// Params 1
// Checksum 0x88f3f29f, Offset: 0x5078
// Size: 0x54
function quadtank_set_team( team )
{
    self.team = team;
    
    if ( !self vehicle_ai::is_instate( "off" ) )
    {
        self vehicle_ai::blink_lights_for_time( 0.5 );
    }
}

// Namespace quadtank
// Params 0
// Checksum 0xfda320df, Offset: 0x50d8
// Size: 0x42
function remove_repulsor()
{
    if ( isdefined( self.missile_repulsor ) )
    {
        missile_deleteattractor( self.missile_repulsor );
        self.missile_repulsor = undefined;
    }
    
    self notify( #"end_repulsor_fx" );
}

// Namespace quadtank
// Params 0
// Checksum 0xc9cd5a6e, Offset: 0x5128
// Size: 0x120
function repulsor_fx()
{
    self notify( #"end_repulsor_fx" );
    self endon( #"end_repulsor_fx" );
    self endon( #"death" );
    self endon( #"change_state" );
    
    while ( true )
    {
        self util::waittill_any( "projectile_applyattractor", "play_meleefx" );
        
        if ( vehicle_ai::iscooldownready( "repulsorfx_interval" ) )
        {
            playfxontag( self.settings.trophyrepulsefx, self, "tag_body" );
            self vehicle::impact_fx( self.settings.trophyrepulsefx_ground );
            vehicle_ai::cooldown( "repulsorfx_interval", 0.5 );
            self playsound( "wpn_quadtank_shield_impact" );
            quadtank_weakpoint_trigger();
        }
    }
}

// Namespace quadtank
// Params 0
// Checksum 0x6f0864c8, Offset: 0x5250
// Size: 0x64
function quadtank_projectile_watcher()
{
    if ( !isdefined( self.missile_repulsor ) )
    {
        self.missile_repulsor = missile_createrepulsorent( self, 40000, self.settings.trophysystemrange, 1 );
    }
    
    self thread repulsor_fx();
}

// Namespace quadtank
// Params 1
// Checksum 0xc333d3f7, Offset: 0x52c0
// Size: 0x4c
function turn_off_laser_after( time )
{
    self notify( #"turn_off_laser_thread" );
    self endon( #"turn_off_laser_thread" );
    self endon( #"death" );
    wait time;
    self laseroff();
}

// Namespace quadtank
// Params 2
// Checksum 0x455084d8, Offset: 0x5318
// Size: 0x246
function side_turret_is_target_in_view_score( v_target, n_index )
{
    s_turret = turret::_get_turret_data( n_index );
    v_pivot_pos = self gettagorigin( s_turret.str_tag_pivot );
    v_angles_to_target = vectortoangles( v_target - v_pivot_pos );
    n_rest_angle_pitch = s_turret.n_rest_angle_pitch + self.angles[ 0 ];
    n_rest_angle_yaw = s_turret.n_rest_angle_yaw + self.angles[ 1 ];
    n_ang_pitch = angleclamp180( v_angles_to_target[ 0 ] - n_rest_angle_pitch );
    n_ang_yaw = angleclamp180( v_angles_to_target[ 1 ] - n_rest_angle_yaw );
    b_out_of_range = 0;
    
    if ( n_ang_pitch > 0 )
    {
        if ( n_ang_pitch > s_turret.bottomarc )
        {
            b_out_of_range = 1;
        }
    }
    else if ( abs( n_ang_pitch ) > s_turret.toparc )
    {
        b_out_of_range = 1;
    }
    
    if ( n_ang_yaw > 0 )
    {
        if ( n_ang_yaw > s_turret.leftarc )
        {
            b_out_of_range = 1;
        }
    }
    else if ( abs( n_ang_yaw ) > s_turret.rightarc )
    {
        b_out_of_range = 1;
    }
    
    if ( b_out_of_range )
    {
        return 0;
    }
    
    return abs( n_ang_yaw ) / 90 * 800;
}

// Namespace quadtank
// Params 2
// Checksum 0x33d44f02, Offset: 0x5568
// Size: 0x3e4
function _get_best_target_quadtank_side_turret( a_potential_targets, n_index )
{
    takeeasyononetarget = mapfloat( 0, 4, 800, 0, level.gameskill );
    
    if ( n_index === 1 )
    {
        other_turret_target = turret::get_target( 2 );
    }
    else if ( n_index === 2 )
    {
        other_turret_target = turret::get_target( 1 );
    }
    
    e_best_target = undefined;
    f_best_score = 100000;
    s_turret = turret::_get_turret_data( n_index );
    
    foreach ( e_target in a_potential_targets )
    {
        f_score = distance( self.origin, e_target.origin );
        b_current_target = turret::is_target( e_target, n_index );
        
        if ( b_current_target )
        {
            f_score -= 100;
        }
        
        if ( e_target === self.enemy )
        {
            f_score += 300;
        }
        
        if ( e_target === other_turret_target )
        {
            f_score += 100 + takeeasyononetarget;
        }
        
        if ( issentient( e_target ) && e_target attackedrecently( self, 2 ) )
        {
            f_score -= 200;
        }
        
        if ( isalive( self.lockon_owner ) && e_target === self.lockon_owner )
        {
            f_score -= 1000;
        }
        
        v_offset = turret::_get_default_target_offset( e_target, n_index );
        view_score = side_turret_is_target_in_view_score( e_target.origin + v_offset, n_index );
        
        if ( view_score != 0 )
        {
            f_score += view_score;
            b_trace_passed = turret::trace_test( e_target, v_offset, n_index );
            
            if ( b_current_target && !b_trace_passed && !isdefined( s_turret.n_time_lose_sight ) )
            {
                s_turret.n_time_lose_sight = gettime();
            }
            
            if ( b_trace_passed )
            {
                f_score -= 500;
            }
        }
        else if ( b_current_target )
        {
            s_turret.b_target_out_of_range = 1;
            f_score += 5000;
        }
        
        if ( f_score < f_best_score )
        {
            f_best_score = f_score;
            e_best_target = e_target;
        }
    }
    
    return e_best_target;
}

// Namespace quadtank
// Params 0
// Checksum 0x6d2b8381, Offset: 0x5958
// Size: 0x34
function quadtank_weakpoint_trigger()
{
    if ( isdefined( self.displayweakpoint ) && self.displayweakpoint )
    {
        self globallogic_ui::triggerweakpointdamage( &"tag_target_lower" );
    }
}

// Namespace quadtank
// Params 1
// Checksum 0xac007ae0, Offset: 0x5998
// Size: 0x104
function quadtank_weakpoint_display( state )
{
    if ( self.displayweakpoint !== state )
    {
        self.displayweakpoint = state;
        
        if ( !self.displayweakpoint && self.weakpointobjective === 1 )
        {
            self.weakpointobjective = 0;
            self globallogic_ui::destroyweakpointwidget( &"tag_target_lower" );
        }
        
        player = level.players[ 0 ];
        
        if ( !isdefined( player ) || self.displayweakpoint && self.combatactive && self.weakpointobjective !== 1 && player.team !== self.team )
        {
            self.weakpointobjective = 1;
            self globallogic_ui::createweakpointwidget( &"tag_target_lower" );
        }
    }
}

// Namespace quadtank
// Params 0
// Checksum 0xc1dfc1df, Offset: 0x5aa8
// Size: 0x140
function footstep_handler()
{
    self endon( #"death" );
    self endon( #"exit_vehicle" );
    
    while ( true )
    {
        note = self util::waittill_any_return( "footstep_front_left", "footstep_front_right", "footstep_rear_left", "footstep_rear_right" );
        
        switch ( note )
        {
            case "footstep_front_left":
                bone = "tag_foot_fx_left_front";
                break;
            case "footstep_front_right":
                bone = "tag_foot_fx_right_front";
                break;
            case "footstep_rear_left":
                bone = "tag_foot_fx_left_back";
                break;
            default:
                bone = "tag_foot_fx_right_back";
                break;
        }
        
        position = self gettagorigin( bone ) + ( 0, 0, 15 );
        self radiusdamage( position, 60, 50, 50, self, "MOD_CRUSH" );
    }
}

// Namespace quadtank
// Params 1
// Checksum 0xd7799efb, Offset: 0x5bf0
// Size: 0x124
function javeline_incoming( projectile )
{
    self endon( #"entityshutdown" );
    self endon( #"death" );
    self waittill( #"weapon_fired", projectile );
    distance = 1400;
    alias = "prj_quadtank_javelin_incoming";
    wait 5;
    
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
        
        wait 0.2;
    }
}

// Namespace quadtank
// Params 1
// Checksum 0x687b9220, Offset: 0x5d20
// Size: 0x124
function railgun_sound( projectile )
{
    self endon( #"entityshutdown" );
    self endon( #"death" );
    self waittill( #"weapon_fired", projectile );
    distance = 900;
    alais = "wpn_quadtank_railgun_fire_rocket_flux";
    players = level.players;
    
    while ( isdefined( projectile ) && isdefined( projectile.origin ) )
    {
        if ( isdefined( players[ 0 ] ) && isdefined( players[ 0 ].origin ) )
        {
            projectiledistance = distancesquared( projectile.origin, players[ 0 ].origin );
            
            if ( projectiledistance <= distance * distance )
            {
                projectile playsound( alais );
                return;
            }
        }
        
        wait 0.2;
    }
}

