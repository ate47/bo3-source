#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/killstreaks/_qrdrone;
#using scripts/mp/killstreaks/_rcbomb;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_death_shared;

#namespace vehicle;

// Namespace vehicle
// Params 0, eflags: 0x2
// Checksum 0x118588f, Offset: 0xc98
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "vehicle", &__init__, undefined, undefined );
}

// Namespace vehicle
// Params 0
// Checksum 0x4ac9bc32, Offset: 0xcd8
// Size: 0x742
function __init__()
{
    setdvar( "scr_veh_cleanupdebugprint", "0" );
    setdvar( "scr_veh_driversarehidden", "1" );
    setdvar( "scr_veh_driversareinvulnerable", "1" );
    setdvar( "scr_veh_alive_cleanuptimemin", "119" );
    setdvar( "scr_veh_alive_cleanuptimemax", "120" );
    setdvar( "scr_veh_dead_cleanuptimemin", "20" );
    setdvar( "scr_veh_dead_cleanuptimemax", "30" );
    setdvar( "scr_veh_cleanuptime_dmgfactor_min", "0.33" );
    setdvar( "scr_veh_cleanuptime_dmgfactor_max", "1.0" );
    setdvar( "scr_veh_cleanuptime_dmgfactor_deadtread", "0.25" );
    setdvar( "scr_veh_cleanuptime_dmgfraction_curve_begin", "0.0" );
    setdvar( "scr_veh_cleanuptime_dmgfraction_curve_end", "1.0" );
    setdvar( "scr_veh_cleanupabandoned", "1" );
    setdvar( "scr_veh_cleanupdrifted", "1" );
    setdvar( "scr_veh_cleanupmaxspeedmph", "1" );
    setdvar( "scr_veh_cleanupmindistancefeet", "75" );
    setdvar( "scr_veh_waittillstoppedandmindist_maxtime", "10" );
    setdvar( "scr_veh_waittillstoppedandmindist_maxtimeenabledistfeet", "5" );
    setdvar( "scr_veh_respawnafterhuskcleanup", "1" );
    setdvar( "scr_veh_respawntimemin", "50" );
    setdvar( "scr_veh_respawntimemax", "90" );
    setdvar( "scr_veh_respawnwait_maxiterations", "30" );
    setdvar( "scr_veh_respawnwait_iterationwaitseconds", "1" );
    setdvar( "scr_veh_disablerespawn", "0" );
    setdvar( "scr_veh_disableoverturndamage", "0" );
    setdvar( "scr_veh_explosion_spawnfx", "1" );
    setdvar( "scr_veh_explosion_doradiusdamage", "1" );
    setdvar( "scr_veh_explosion_radius", "256" );
    setdvar( "scr_veh_explosion_mindamage", "20" );
    setdvar( "scr_veh_explosion_maxdamage", "200" );
    setdvar( "scr_veh_ondeath_createhusk", "1" );
    setdvar( "scr_veh_ondeath_usevehicleashusk", "1" );
    setdvar( "scr_veh_explosion_husk_forcepointvariance", "30" );
    setdvar( "scr_veh_explosion_husk_horzvelocityvariance", "25" );
    setdvar( "scr_veh_explosion_husk_vertvelocitymin", "100" );
    setdvar( "scr_veh_explosion_husk_vertvelocitymax", "200" );
    setdvar( "scr_veh_explode_on_cleanup", "1" );
    setdvar( "scr_veh_disappear_maxwaittime", "60" );
    setdvar( "scr_veh_disappear_maxpreventdistancefeet", "30" );
    setdvar( "scr_veh_disappear_maxpreventvisibilityfeet", "150" );
    setdvar( "scr_veh_health_tank", "1350" );
    level.vehicle_drivers_are_invulnerable = getdvarint( "scr_veh_driversareinvulnerable" );
    level.onejectoccupants = &vehicle_eject_all_occupants;
    level.vehiclehealths[ "panzer4_mp" ] = 2600;
    level.vehiclehealths[ "t34_mp" ] = 2600;
    setdvar( "scr_veh_health_jeep", "700" );
    
    if ( init_vehicle_entities() )
    {
        level.vehicle_explosion_effect = "_t6/vehicle/vexplosion/fx_vexplode_helicopter_exp_mp";
        level.veh_husk_models = [];
        level.veh_husk_effects = [];
        
        if ( isdefined( level.use_new_veh_husks ) )
        {
            level.veh_husk_models[ "t34_mp" ] = "veh_t34_destroyed_mp";
        }
        
        if ( isdefined( level.onaddvehiclehusks ) )
        {
            [[ level.onaddvehiclehusks ]]();
        }
    }
    
    chopper_player_get_on_gun = %mp_vehicles::int_huey_gunner_on;
    chopper_door_open = %mp_vehicles::v_huey_door_open;
    chopper_door_open_state = %mp_vehicles::v_huey_door_open_state;
    chopper_door_closed_state = %mp_vehicles::v_huey_door_close_state;
    killbrushes = getentarray( "water_killbrush", "targetname" );
    
    foreach ( brush in killbrushes )
    {
        brush thread water_killbrush_think();
    }
}

// Namespace vehicle
// Params 0
// Checksum 0x3aad7abd, Offset: 0x1428
// Size: 0x108
function water_killbrush_think()
{
    for ( ;; )
    {
        self waittill( #"trigger", entity );
        
        if ( isdefined( entity ) )
        {
            if ( isdefined( entity.targetname ) )
            {
                if ( entity.targetname == "rcbomb" )
                {
                    entity notify( #"rcbomb_shutdown" );
                }
                else if ( entity.targetname == "talon" && !( isdefined( entity.dead ) && entity.dead ) )
                {
                    entity notify( #"death" );
                }
            }
            
            if ( isdefined( entity.helitype ) && entity.helitype == "qrdrone" )
            {
                entity qrdrone::qrdrone_force_destroy();
            }
        }
    }
}

// Namespace vehicle
// Params 0
// Checksum 0x25e1e79, Offset: 0x1538
// Size: 0x62a
function initialize_vehicle_damage_effects_for_level()
{
    k_mild_damage_index = 0;
    k_moderate_damage_index = 1;
    k_severe_damage_index = 2;
    k_total_damage_index = 3;
    k_mild_damage_health_percentage = 0.85;
    k_moderate_damage_health_percentage = 0.55;
    k_severe_damage_health_percentage = 0.35;
    k_total_damage_health_percentage = 0;
    level.k_mild_damage_health_percentage = k_mild_damage_health_percentage;
    level.k_moderate_damage_health_percentage = k_moderate_damage_health_percentage;
    level.k_severe_damage_health_percentage = k_severe_damage_health_percentage;
    level.k_total_damage_health_percentage = k_total_damage_health_percentage;
    level.vehicles_damage_states = [];
    level.vehicles_husk_effects = [];
    level.vehicles_damage_treadfx = [];
    vehicle_name = get_default_vehicle_name();
    level.vehicles_damage_states[ vehicle_name ] = [];
    level.vehicles_damage_treadfx[ vehicle_name ] = [];
    level.vehicles_damage_states[ vehicle_name ][ k_mild_damage_index ] = spawnstruct();
    level.vehicles_damage_states[ vehicle_name ][ k_mild_damage_index ].health_percentage = k_mild_damage_health_percentage;
    level.vehicles_damage_states[ vehicle_name ][ k_mild_damage_index ].effect_array = [];
    level.vehicles_damage_states[ vehicle_name ][ k_mild_damage_index ].effect_array[ 0 ] = spawnstruct();
    level.vehicles_damage_states[ vehicle_name ][ k_mild_damage_index ].effect_array[ 0 ].damage_effect = "_t6/vehicle/vfire/fx_tank_sherman_smldr";
    level.vehicles_damage_states[ vehicle_name ][ k_mild_damage_index ].effect_array[ 0 ].sound_effect = undefined;
    level.vehicles_damage_states[ vehicle_name ][ k_mild_damage_index ].effect_array[ 0 ].vehicle_tag = "tag_origin";
    level.vehicles_damage_states[ vehicle_name ][ k_moderate_damage_index ] = spawnstruct();
    level.vehicles_damage_states[ vehicle_name ][ k_moderate_damage_index ].health_percentage = k_moderate_damage_health_percentage;
    level.vehicles_damage_states[ vehicle_name ][ k_moderate_damage_index ].effect_array = [];
    level.vehicles_damage_states[ vehicle_name ][ k_moderate_damage_index ].effect_array[ 0 ] = spawnstruct();
    level.vehicles_damage_states[ vehicle_name ][ k_moderate_damage_index ].effect_array[ 0 ].damage_effect = "_t6/vehicle/vfire/fx_vfire_med_12";
    level.vehicles_damage_states[ vehicle_name ][ k_moderate_damage_index ].effect_array[ 0 ].sound_effect = undefined;
    level.vehicles_damage_states[ vehicle_name ][ k_moderate_damage_index ].effect_array[ 0 ].vehicle_tag = "tag_origin";
    level.vehicles_damage_states[ vehicle_name ][ k_severe_damage_index ] = spawnstruct();
    level.vehicles_damage_states[ vehicle_name ][ k_severe_damage_index ].health_percentage = k_severe_damage_health_percentage;
    level.vehicles_damage_states[ vehicle_name ][ k_severe_damage_index ].effect_array = [];
    level.vehicles_damage_states[ vehicle_name ][ k_severe_damage_index ].effect_array[ 0 ] = spawnstruct();
    level.vehicles_damage_states[ vehicle_name ][ k_severe_damage_index ].effect_array[ 0 ].damage_effect = "_t6/vehicle/vfire/fx_vfire_sherman";
    level.vehicles_damage_states[ vehicle_name ][ k_severe_damage_index ].effect_array[ 0 ].sound_effect = undefined;
    level.vehicles_damage_states[ vehicle_name ][ k_severe_damage_index ].effect_array[ 0 ].vehicle_tag = "tag_origin";
    level.vehicles_damage_states[ vehicle_name ][ k_total_damage_index ] = spawnstruct();
    level.vehicles_damage_states[ vehicle_name ][ k_total_damage_index ].health_percentage = k_total_damage_health_percentage;
    level.vehicles_damage_states[ vehicle_name ][ k_total_damage_index ].effect_array = [];
    level.vehicles_damage_states[ vehicle_name ][ k_total_damage_index ].effect_array[ 0 ] = spawnstruct();
    level.vehicles_damage_states[ vehicle_name ][ k_total_damage_index ].effect_array[ 0 ].damage_effect = "_t6/vehicle/vexplosion/fx_vexplode_helicopter_exp_mp";
    level.vehicles_damage_states[ vehicle_name ][ k_total_damage_index ].effect_array[ 0 ].sound_effect = "vehicle_explo";
    level.vehicles_damage_states[ vehicle_name ][ k_total_damage_index ].effect_array[ 0 ].vehicle_tag = "tag_origin";
    default_husk_effects = spawnstruct();
    default_husk_effects.damage_effect = undefined;
    default_husk_effects.sound_effect = undefined;
    default_husk_effects.vehicle_tag = "tag_origin";
    level.vehicles_husk_effects[ vehicle_name ] = default_husk_effects;
}

// Namespace vehicle
// Params 1
// Checksum 0x7149b778, Offset: 0x1b70
// Size: 0x54
function get_vehicle_name( vehicle )
{
    name = "";
    
    if ( isdefined( vehicle ) )
    {
        if ( isdefined( vehicle.vehicletype ) )
        {
            name = vehicle.vehicletype;
        }
    }
    
    return name;
}

// Namespace vehicle
// Params 0
// Checksum 0xa7a2be51, Offset: 0x1bd0
// Size: 0xa
function get_default_vehicle_name()
{
    return "defaultvehicle_mp";
}

// Namespace vehicle
// Params 1
// Checksum 0x464805ed, Offset: 0x1be8
// Size: 0x6c
function get_vehicle_name_key_for_damage_states( vehicle )
{
    vehicle_name = get_vehicle_name( vehicle );
    
    if ( !isdefined( level.vehicles_damage_states ) || !isdefined( level.vehicles_damage_states[ vehicle_name ] ) )
    {
        vehicle_name = get_default_vehicle_name();
    }
    
    return vehicle_name;
}

// Namespace vehicle
// Params 1
// Checksum 0x84ce34f6, Offset: 0x1c60
// Size: 0xc8
function get_vehicle_damage_state_index_from_health_percentage( vehicle )
{
    if ( !isdefined( level.vehicles_damage_states ) )
    {
        return -1;
    }
    
    damage_state_index = -1;
    vehicle_name = get_vehicle_name_key_for_damage_states();
    
    for ( test_index = 0; test_index < level.vehicles_damage_states[ vehicle_name ].size ; test_index++ )
    {
        if ( vehicle.current_health_percentage <= level.vehicles_damage_states[ vehicle_name ][ test_index ].health_percentage )
        {
            damage_state_index = test_index;
            continue;
        }
        
        break;
    }
    
    return damage_state_index;
}

// Namespace vehicle
// Params 2
// Checksum 0xd56e85e5, Offset: 0x1d30
// Size: 0x14c
function update_damage_effects( vehicle, attacker )
{
    if ( vehicle.initial_state.health > 0 )
    {
        previous_damage_state_index = get_vehicle_damage_state_index_from_health_percentage( vehicle );
        vehicle.current_health_percentage = vehicle.health / vehicle.initial_state.health;
        current_damage_state_index = get_vehicle_damage_state_index_from_health_percentage( vehicle );
        
        if ( previous_damage_state_index != current_damage_state_index )
        {
            vehicle notify( #"damage_state_changed" );
            
            if ( previous_damage_state_index < 0 )
            {
                start_damage_state_index = 0;
            }
            else
            {
                start_damage_state_index = previous_damage_state_index + 1;
            }
            
            play_damage_state_effects( vehicle, start_damage_state_index, current_damage_state_index );
            
            if ( vehicle.health <= 0 )
            {
                vehicle kill_vehicle( attacker );
            }
        }
    }
}

// Namespace vehicle
// Params 3
// Checksum 0x27587b0, Offset: 0x1e88
// Size: 0xf8
function play_damage_state_effects( vehicle, start_damage_state_index, end_damage_state_index )
{
    vehicle_name = get_vehicle_name_key_for_damage_states( vehicle );
    
    for ( damage_state_index = start_damage_state_index; damage_state_index <= end_damage_state_index ; damage_state_index++ )
    {
        for ( effect_index = 0; effect_index < level.vehicles_damage_states[ vehicle_name ][ damage_state_index ].effect_array.size ; effect_index++ )
        {
            effects = level.vehicles_damage_states[ vehicle_name ][ damage_state_index ].effect_array[ effect_index ];
            vehicle thread play_vehicle_effects( effects );
        }
    }
}

// Namespace vehicle
// Params 2
// Checksum 0x37c312cf, Offset: 0x1f90
// Size: 0x116
function play_vehicle_effects( effects, isdamagedtread )
{
    self endon( #"delete" );
    self endon( #"removed" );
    
    if ( !isdefined( isdamagedtread ) || isdamagedtread == 0 )
    {
        self endon( #"damage_state_changed" );
    }
    
    if ( isdefined( effects.sound_effect ) )
    {
        self playsound( effects.sound_effect );
    }
    
    waittime = 0;
    
    if ( isdefined( effects.damage_effect_loop_time ) )
    {
        waittime = effects.damage_effect_loop_time;
    }
    
    while ( waittime > 0 )
    {
        if ( isdefined( effects.damage_effect ) )
        {
            playfxontag( effects.damage_effect, self, effects.vehicle_tag );
        }
        
        wait waittime;
    }
}

// Namespace vehicle
// Params 0
// Checksum 0xb725b122, Offset: 0x20b0
// Size: 0x68
function init_vehicle_entities()
{
    vehicles = getentarray( "script_vehicle", "classname" );
    array::thread_all( vehicles, &init_original_vehicle );
    
    if ( isdefined( vehicles ) )
    {
        return vehicles.size;
    }
    
    return 0;
}

// Namespace vehicle
// Params 0
// Checksum 0x99ec1590, Offset: 0x2120
// Size: 0x4
function precache_vehicles()
{
    
}

// Namespace vehicle
// Params 0
// Checksum 0x4af6e813, Offset: 0x2130
// Size: 0x32
function register_vehicle()
{
    if ( !isdefined( level.vehicles_list ) )
    {
        level.vehicles_list = [];
    }
    
    level.vehicles_list[ level.vehicles_list.size ] = self;
}

// Namespace vehicle
// Params 0
// Checksum 0xab7c78bc, Offset: 0x2170
// Size: 0x1c4
function manage_vehicles()
{
    if ( !isdefined( level.vehicles_list ) )
    {
        return 1;
    }
    
    max_vehicles = getmaxvehicles();
    newarray = [];
    
    for ( i = 0; i < level.vehicles_list.size ; i++ )
    {
        if ( isdefined( level.vehicles_list[ i ] ) )
        {
            newarray[ newarray.size ] = level.vehicles_list[ i ];
        }
    }
    
    level.vehicles_list = newarray;
    vehiclestodelete = level.vehicles_list.size + 1 - max_vehicles;
    
    if ( vehiclestodelete > 0 )
    {
        newarray = [];
        
        for ( i = 0; i < level.vehicles_list.size ; i++ )
        {
            vehicle = level.vehicles_list[ i ];
            
            if ( vehiclestodelete > 0 )
            {
                if ( isdefined( vehicle.is_husk ) && !isdefined( vehicle.permanentlyremoved ) )
                {
                    deleted = vehicle husk_do_cleanup();
                    
                    if ( deleted )
                    {
                        vehiclestodelete--;
                        continue;
                    }
                }
            }
            
            newarray[ newarray.size ] = vehicle;
        }
        
        level.vehicles_list = newarray;
    }
    
    return level.vehicles_list.size < max_vehicles;
}

// Namespace vehicle
// Params 0
// Checksum 0xe3c73ef1, Offset: 0x2340
// Size: 0x104
function init_vehicle()
{
    self register_vehicle();
    
    if ( isdefined( level.vehiclehealths ) && isdefined( level.vehiclehealths[ self.vehicletype ] ) )
    {
        self.maxhealth = level.vehiclehealths[ self.vehicletype ];
    }
    else
    {
        self.maxhealth = getdvarint( "scr_veh_health_tank" );
        println( "<dev string:x28>" + self.vehicletype + "<dev string:x4e>" );
    }
    
    self.health = self.maxhealth;
    self vehicle_record_initial_values();
    self init_vehicle_threads();
    system::wait_till( "spawning" );
}

// Namespace vehicle
// Params 0
// Checksum 0x5e131e24, Offset: 0x2450
// Size: 0x78
function initialize_vehicle_damage_state_data()
{
    if ( self.initial_state.health > 0 )
    {
        self.current_health_percentage = self.health / self.initial_state.health;
        self.previous_health_percentage = self.health / self.initial_state.health;
        return;
    }
    
    self.current_health_percentage = 1;
    self.previous_health_percentage = 1;
}

// Namespace vehicle
// Params 0
// Checksum 0xa437b336, Offset: 0x24d8
// Size: 0x24
function init_original_vehicle()
{
    self.original_vehicle = 1;
    self init_vehicle();
}

// Namespace vehicle
// Params 0
// Checksum 0x87ce3b4, Offset: 0x2508
// Size: 0x80
function vehicle_wait_player_enter_t()
{
    self endon( #"transmute" );
    self endon( #"death" );
    self endon( #"delete" );
    
    while ( true )
    {
        self waittill( #"enter_vehicle", player );
        player thread player_wait_exit_vehicle_t();
        player player_update_vehicle_hud( 1, self );
    }
}

// Namespace vehicle
// Params 0
// Checksum 0x1b483fc5, Offset: 0x2590
// Size: 0x44
function player_wait_exit_vehicle_t()
{
    self endon( #"disconnect" );
    self waittill( #"exit_vehicle", vehicle );
    self player_update_vehicle_hud( 0, vehicle );
}

// Namespace vehicle
// Params 0
// Checksum 0x3106b9ab, Offset: 0x25e0
// Size: 0xba
function vehicle_wait_damage_t()
{
    self endon( #"transmute" );
    self endon( #"death" );
    self endon( #"delete" );
    
    while ( true )
    {
        self waittill( #"damage" );
        occupants = self getvehoccupants();
        
        if ( isdefined( occupants ) )
        {
            for ( i = 0; i < occupants.size ; i++ )
            {
                occupants[ i ] player_update_vehicle_hud( 1, self );
            }
        }
    }
}

// Namespace vehicle
// Params 2
// Checksum 0xbd5ca8e5, Offset: 0x26a8
// Size: 0x25c
function player_update_vehicle_hud( show, vehicle )
{
    if ( show )
    {
        if ( !isdefined( self.vehiclehud ) )
        {
            self.vehiclehud = hud::createbar( ( 1, 1, 1 ), 64, 16 );
            self.vehiclehud hud::setpoint( "CENTER", "BOTTOM", 0, -40 );
            self.vehiclehud.alpha = 0.75;
        }
        
        self.vehiclehud hud::updatebar( vehicle.health / vehicle.initial_state.health );
    }
    else if ( isdefined( self.vehiclehud ) )
    {
        self.vehiclehud hud::destroyelem();
    }
    
    if ( getdvarstring( "scr_vehicle_healthnumbers" ) != "" )
    {
        if ( getdvarint( "scr_vehicle_healthnumbers" ) != 0 )
        {
            if ( show )
            {
                if ( !isdefined( self.vehiclehudhealthnumbers ) )
                {
                    self.vehiclehudhealthnumbers = hud::createfontstring( "default", 2 );
                    self.vehiclehudhealthnumbers hud::setparent( self.vehiclehud );
                    self.vehiclehudhealthnumbers hud::setpoint( "LEFT", "RIGHT", 8, 0 );
                    self.vehiclehudhealthnumbers.alpha = 0.75;
                    self.vehiclehudhealthnumbers.hidewheninmenu = 0;
                    self.vehiclehudhealthnumbers.archived = 0;
                }
                
                self.vehiclehudhealthnumbers setvalue( vehicle.health );
                return;
            }
            
            if ( isdefined( self.vehiclehudhealthnumbers ) )
            {
                self.vehiclehudhealthnumbers hud::destroyelem();
            }
        }
    }
}

// Namespace vehicle
// Params 0
// Checksum 0xd0eee825, Offset: 0x2910
// Size: 0x164
function init_vehicle_threads()
{
    self thread vehicle_abandoned_by_drift_t();
    self thread vehicle_abandoned_by_occupants_t();
    self thread vehicle_damage_t();
    self thread vehicle_ghost_entering_occupants_t();
    self thread vehicle_recycle_spawner_t();
    self thread vehicle_disconnect_paths();
    
    if ( isdefined( level.enablevehiclehealthbar ) && level.enablevehiclehealthbar )
    {
        self thread vehicle_wait_player_enter_t();
        self thread vehicle_wait_damage_t();
    }
    
    self thread vehicle_wait_tread_damage();
    self thread vehicle_overturn_eject_occupants();
    
    if ( getdvarint( "scr_veh_disableoverturndamage" ) == 0 )
    {
        self thread vehicle_overturn_suicide();
    }
    
    /#
        self thread cleanup_debug_print_t();
        self thread cleanup_debug_print_clearmsg_t();
    #/
}

// Namespace vehicle
// Params 3
// Checksum 0x80ead5a8, Offset: 0x2a80
// Size: 0xe0
function build_template( type, model, typeoverride )
{
    if ( isdefined( typeoverride ) )
    {
        type = typeoverride;
    }
    
    if ( !isdefined( level.vehicle_death_fx ) )
    {
        level.vehicle_death_fx = [];
    }
    
    if ( !isdefined( level.vehicle_death_fx[ type ] ) )
    {
        level.vehicle_death_fx[ type ] = [];
    }
    
    level.vehicle_compassicon[ type ] = 0;
    level.vehicle_team[ type ] = "axis";
    level.vehicle_life[ type ] = 999;
    level.vehicle_hasmainturret[ model ] = 0;
    level.vehicle_mainturrets[ model ] = [];
    level.vtmodel = model;
    level.vttype = type;
}

// Namespace vehicle
// Params 6
// Checksum 0xd17ac653, Offset: 0x2b68
// Size: 0xc6
function build_rumble( rumble, scale, duration, radius, basetime, randomaditionaltime )
{
    if ( !isdefined( level.vehicle_rumble ) )
    {
        level.vehicle_rumble = [];
    }
    
    struct = build_quake( scale, duration, radius, basetime, randomaditionaltime );
    assert( isdefined( rumble ) );
    struct.rumble = rumble;
    level.vehicle_rumble[ level.vttype ] = struct;
}

// Namespace vehicle
// Params 5
// Checksum 0x2ab09e9f, Offset: 0x2c38
// Size: 0xc0
function build_quake( scale, duration, radius, basetime, randomaditionaltime )
{
    struct = spawnstruct();
    struct.scale = scale;
    struct.duration = duration;
    struct.radius = radius;
    
    if ( isdefined( basetime ) )
    {
        struct.basetime = basetime;
    }
    
    if ( isdefined( randomaditionaltime ) )
    {
        struct.randomaditionaltime = randomaditionaltime;
    }
    
    return struct;
}

// Namespace vehicle
// Params 1
// Checksum 0xc97ef76e, Offset: 0x2d00
// Size: 0x22
function build_exhaust( effect )
{
    level.vehicle_exhaust[ level.vtmodel ] = effect;
}

// Namespace vehicle
// Params 0
// Checksum 0xb7a8196, Offset: 0x2d30
// Size: 0xb0
function cleanup_debug_print_t()
{
    self endon( #"transmute" );
    self endon( #"death" );
    self endon( #"delete" );
    
    /#
        while ( true )
        {
            if ( isdefined( self.debug_message ) && getdvarint( "<dev string:x61>" ) != 0 )
            {
                print3d( self.origin + ( 0, 0, 150 ), self.debug_message, ( 0, 1, 0 ), 1, 1, 1 );
            }
            
            wait 0.01;
        }
    #/
}

// Namespace vehicle
// Params 0
// Checksum 0x9b70b484, Offset: 0x2de8
// Size: 0x4e
function cleanup_debug_print_clearmsg_t()
{
    self endon( #"transmute" );
    self endon( #"death" );
    self endon( #"delete" );
    
    /#
        while ( true )
        {
            self waittill( #"enter_vehicle" );
            self.debug_message = undefined;
        }
    #/
}

// Namespace vehicle
// Params 1
// Checksum 0x386a6980, Offset: 0x2e40
// Size: 0x1c
function cleanup_debug_print( message )
{
    /#
        self.debug_message = message;
    #/
}

// Namespace vehicle
// Params 0
// Checksum 0x321212fe, Offset: 0x2e68
// Size: 0x4c
function vehicle_abandoned_by_drift_t()
{
    self endon( #"transmute" );
    self endon( #"death" );
    self endon( #"delete" );
    self wait_then_cleanup_vehicle( "Drift Test", "scr_veh_cleanupdrifted" );
}

// Namespace vehicle
// Params 0
// Checksum 0xaba6c6cb, Offset: 0x2ec0
// Size: 0x4c
function vehicle_abandoned_by_occupants_timeout_t()
{
    self endon( #"transmute" );
    self endon( #"death" );
    self endon( #"delete" );
    self wait_then_cleanup_vehicle( "Abandon Test", "scr_veh_cleanupabandoned" );
}

// Namespace vehicle
// Params 2
// Checksum 0x301add1, Offset: 0x2f18
// Size: 0x8c
function wait_then_cleanup_vehicle( test_name, cleanup_dvar_name )
{
    self endon( #"enter_vehicle" );
    self wait_until_severely_damaged();
    self do_alive_cleanup_wait( test_name );
    self wait_for_vehicle_to_stop_outside_min_radius();
    self cleanup( test_name, cleanup_dvar_name, &vehicle_recycle );
}

// Namespace vehicle
// Params 0
// Checksum 0x47ba5add, Offset: 0x2fb0
// Size: 0xec
function wait_until_severely_damaged()
{
    while ( true )
    {
        health_percentage = self.health / self.initial_state.health;
        
        if ( isdefined( level.k_severe_damage_health_percentage ) )
        {
            self cleanup_debug_print( "Damage Test: Still healthy - (" + health_percentage + " >= " + level.k_severe_damage_health_percentage + ") and working treads" );
        }
        else
        {
            self cleanup_debug_print( "Damage Test: Still healthy and working treads" );
        }
        
        self waittill( #"damage" );
        health_percentage = self.health / self.initial_state.health;
        
        if ( isdefined( level.k_severe_damage_health_percentage ) && health_percentage < level.k_severe_damage_health_percentage )
        {
            break;
        }
    }
}

// Namespace vehicle
// Params 1
// Checksum 0xfbbbcf3, Offset: 0x30a8
// Size: 0xbe
function get_random_cleanup_wait_time( state )
{
    varnameprefix = "scr_veh_" + state + "_cleanuptime";
    mintime = getdvarfloat( varnameprefix + "min" );
    maxtime = getdvarfloat( varnameprefix + "max" );
    
    if ( maxtime > mintime )
    {
        return randomfloatrange( mintime, maxtime );
    }
    
    return maxtime;
}

// Namespace vehicle
// Params 1
// Checksum 0xe6adc741, Offset: 0x3170
// Size: 0x29e
function do_alive_cleanup_wait( test_name )
{
    initialrandomwaitseconds = get_random_cleanup_wait_time( "alive" );
    secondswaited = 0;
    seconds_per_iteration = 1;
    
    while ( true )
    {
        curve_begin = getdvarfloat( "scr_veh_cleanuptime_dmgfraction_curve_begin" );
        curve_end = getdvarfloat( "scr_veh_cleanuptime_dmgfraction_curve_end" );
        factor_min = getdvarfloat( "scr_veh_cleanuptime_dmgfactor_min" );
        factor_max = getdvarfloat( "scr_veh_cleanuptime_dmgfactor_max" );
        treaddeaddamagefactor = getdvarfloat( "scr_veh_cleanuptime_dmgfactor_deadtread" );
        damagefraction = 0;
        
        if ( self is_vehicle() )
        {
            damagefraction = ( self.initial_state.health - self.health ) / self.initial_state.health;
        }
        else
        {
            damagefraction = 1;
        }
        
        damagefactor = 0;
        
        if ( damagefraction <= curve_begin )
        {
            damagefactor = factor_max;
        }
        else if ( damagefraction >= curve_end )
        {
            damagefactor = factor_min;
        }
        else
        {
            dydx = ( factor_min - factor_max ) / ( curve_end - curve_begin );
            damagefactor = factor_max + ( damagefraction - curve_begin ) * dydx;
        }
        
        totalsecstowait = initialrandomwaitseconds * damagefactor;
        
        if ( secondswaited >= totalsecstowait )
        {
            break;
        }
        
        self cleanup_debug_print( test_name + ": Waiting " + totalsecstowait - secondswaited + "s" );
        wait seconds_per_iteration;
        secondswaited += seconds_per_iteration;
    }
}

// Namespace vehicle
// Params 1
// Checksum 0xc24449df, Offset: 0x3418
// Size: 0xb6
function do_dead_cleanup_wait( test_name )
{
    total_secs_to_wait = get_random_cleanup_wait_time( "dead" );
    seconds_waited = 0;
    seconds_per_iteration = 1;
    
    while ( seconds_waited < total_secs_to_wait )
    {
        self cleanup_debug_print( test_name + ": Waiting " + total_secs_to_wait - seconds_waited + "s" );
        wait seconds_per_iteration;
        seconds_waited += seconds_per_iteration;
    }
}

// Namespace vehicle
// Params 3
// Checksum 0x243541fe, Offset: 0x34d8
// Size: 0xe2
function cleanup( test_name, cleanup_dvar_name, cleanup_func )
{
    keep_waiting = 1;
    
    while ( keep_waiting )
    {
        cleanupenabled = !isdefined( cleanup_dvar_name ) || getdvarint( cleanup_dvar_name ) != 0;
        
        if ( cleanupenabled != 0 )
        {
            self [[ cleanup_func ]]();
            break;
        }
        
        keep_waiting = 0;
        
        /#
            self cleanup_debug_print( "<dev string:x7b>" + test_name + "<dev string:x91>" + cleanup_dvar_name + "<dev string:x9c>" );
            wait 5;
            keep_waiting = 1;
        #/
    }
}

// Namespace vehicle
// Params 0
// Checksum 0x79c2c368, Offset: 0x35c8
// Size: 0x130
function vehicle_wait_tread_damage()
{
    self endon( #"death" );
    self endon( #"delete" );
    vehicle_name = get_vehicle_name( self );
    
    while ( true )
    {
        self waittill( #"broken", brokennotify );
        
        if ( brokennotify == "left_tread_destroyed" )
        {
            if ( isdefined( level.vehicles_damage_treadfx[ vehicle_name ] ) && isdefined( level.vehicles_damage_treadfx[ vehicle_name ][ 0 ] ) )
            {
                self thread play_vehicle_effects( level.vehicles_damage_treadfx[ vehicle_name ][ 0 ], 1 );
            }
            
            continue;
        }
        
        if ( brokennotify == "right_tread_destroyed" )
        {
            if ( isdefined( level.vehicles_damage_treadfx[ vehicle_name ] ) && isdefined( level.vehicles_damage_treadfx[ vehicle_name ][ 1 ] ) )
            {
                self thread play_vehicle_effects( level.vehicles_damage_treadfx[ vehicle_name ][ 1 ], 1 );
            }
        }
    }
}

// Namespace vehicle
// Params 0
// Checksum 0xd132508b, Offset: 0x3700
// Size: 0x166
function wait_for_vehicle_to_stop_outside_min_radius()
{
    maxwaittime = getdvarfloat( "scr_veh_waittillstoppedandmindist_maxtime" );
    iterationwaitseconds = 1;
    maxwaittimeenabledistinches = 12 * getdvarfloat( "scr_veh_waittillstoppedandmindist_maxtimeenabledistfeet" );
    initialorigin = self.initial_state.origin;
    totalsecondswaited = 0;
    
    while ( totalsecondswaited < maxwaittime )
    {
        speedmph = self getspeedmph();
        cutoffmph = getdvarfloat( "scr_veh_cleanupmaxspeedmph" );
        
        if ( speedmph > cutoffmph )
        {
            cleanup_debug_print( "(" + maxwaittime - totalsecondswaited + "s) Speed: " + speedmph + ">" + cutoffmph );
        }
        else
        {
            break;
        }
        
        wait iterationwaitseconds;
        totalsecondswaited += iterationwaitseconds;
    }
}

// Namespace vehicle
// Params 0
// Checksum 0x2616ddf2, Offset: 0x3870
// Size: 0xa8
function vehicle_abandoned_by_occupants_t()
{
    self endon( #"transmute" );
    self endon( #"death" );
    self endon( #"delete" );
    
    while ( true )
    {
        self waittill( #"exit_vehicle" );
        occupants = self getvehoccupants();
        
        if ( occupants.size == 0 )
        {
            self play_start_stop_sound( "tank_shutdown_sfx" );
            self thread vehicle_abandoned_by_occupants_timeout_t();
        }
    }
}

// Namespace vehicle
// Params 2
// Checksum 0xbf36ee77, Offset: 0x3920
// Size: 0x44
function play_start_stop_sound( sound_alias, modulation )
{
    if ( isdefined( self.start_stop_sfxid ) )
    {
    }
    
    self.start_stop_sfxid = self playsound( sound_alias );
}

// Namespace vehicle
// Params 0
// Checksum 0xd03cbcd3, Offset: 0x3970
// Size: 0x150
function vehicle_ghost_entering_occupants_t()
{
    self endon( #"transmute" );
    self endon( #"death" );
    self endon( #"delete" );
    
    if ( isdefined( self.vehicleclass ) && "artillery" == self.vehicleclass )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"enter_vehicle", player, seat );
        isdriver = seat == 0;
        
        if ( getdvarint( "scr_veh_driversarehidden" ) != 0 && isdriver )
        {
            player ghost();
        }
        
        occupants = self getvehoccupants();
        
        if ( occupants.size == 1 )
        {
            self play_start_stop_sound( "tank_startup_sfx" );
        }
        
        player thread player_change_seat_handler_t( self );
        player thread player_leave_vehicle_cleanup_t( self );
    }
}

// Namespace vehicle
// Params 1
// Checksum 0xc415e179, Offset: 0x3ac8
// Size: 0x74
function player_is_occupant_invulnerable( smeansofdeath )
{
    if ( self isremotecontrolling() )
    {
        return 0;
    }
    
    if ( !isdefined( level.vehicle_drivers_are_invulnerable ) )
    {
        level.vehicle_drivers_are_invulnerable = 0;
    }
    
    invulnerable = level.vehicle_drivers_are_invulnerable && self player_is_driver();
    return invulnerable;
}

// Namespace vehicle
// Params 0
// Checksum 0xb37feab2, Offset: 0x3b48
// Size: 0xbe, Type: bool
function player_is_driver()
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    vehicle = self getvehicleoccupied();
    
    if ( isdefined( vehicle ) )
    {
        if ( isdefined( vehicle.vehicleclass ) && "artillery" == vehicle.vehicleclass )
        {
            return false;
        }
        
        seat = vehicle getoccupantseat( self );
        
        if ( isdefined( seat ) && seat == 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle
// Params 1
// Checksum 0x77969df4, Offset: 0x3c10
// Size: 0xc0
function player_change_seat_handler_t( vehicle )
{
    self endon( #"disconnect" );
    self endon( #"exit_vehicle" );
    
    while ( true )
    {
        self waittill( #"change_seat", vehicle, oldseat, newseat );
        isdriver = newseat == 0;
        
        if ( isdriver )
        {
            if ( getdvarint( "scr_veh_driversarehidden" ) != 0 )
            {
                self ghost();
            }
            
            continue;
        }
        
        self show();
    }
}

// Namespace vehicle
// Params 1
// Checksum 0x8fda2181, Offset: 0x3cd8
// Size: 0xac
function player_leave_vehicle_cleanup_t( vehicle )
{
    self endon( #"disconnect" );
    self waittill( #"exit_vehicle" );
    currentweapon = self getcurrentweapon();
    
    if ( isdefined( self.lastweapon ) && self.lastweapon != currentweapon && self.lastweapon != level.weaponnone )
    {
        self switchtoweapon( self.lastweapon );
    }
    
    self show();
}

// Namespace vehicle
// Params 0
// Checksum 0x6eb7457a, Offset: 0x3d90
// Size: 0x50, Type: bool
function vehicle_is_tank()
{
    return self.vehicletype == "sherman_mp" || self.vehicletype == "panzer4_mp" || self.vehicletype == "type97_mp" || self.vehicletype == "t34_mp";
}

// Namespace vehicle
// Params 0
// Checksum 0x72ba29c3, Offset: 0x3de8
// Size: 0xac
function vehicle_record_initial_values()
{
    if ( !isdefined( self.initial_state ) )
    {
        self.initial_state = spawnstruct();
    }
    
    if ( isdefined( self.origin ) )
    {
        self.initial_state.origin = self.origin;
    }
    
    if ( isdefined( self.angles ) )
    {
        self.initial_state.angles = self.angles;
    }
    
    if ( isdefined( self.health ) )
    {
        self.initial_state.health = self.health;
    }
    
    self initialize_vehicle_damage_state_data();
}

// Namespace vehicle
// Params 0
// Checksum 0xb5d20c3e, Offset: 0x3ea0
// Size: 0x1e, Type: bool
function vehicle_should_explode_on_cleanup()
{
    return getdvarint( "scr_veh_explode_on_cleanup" ) != 0;
}

// Namespace vehicle
// Params 0
// Checksum 0xf20878cf, Offset: 0x3ec8
// Size: 0x3c
function vehicle_recycle()
{
    self wait_for_unnoticeable_cleanup_opportunity();
    self.recycling = 1;
    self suicide();
}

// Namespace vehicle
// Params 0
// Checksum 0xa4aa8d71, Offset: 0x3f10
// Size: 0xf0
function wait_for_vehicle_overturn()
{
    self endon( #"transmute" );
    self endon( #"death" );
    self endon( #"delete" );
    worldup = anglestoup( ( 0, 90, 0 ) );
    overturned = 0;
    
    while ( !overturned )
    {
        if ( isdefined( self.angles ) )
        {
            up = anglestoup( self.angles );
            dot = vectordot( up, worldup );
            
            if ( dot <= 0 )
            {
                overturned = 1;
            }
        }
        
        if ( !overturned )
        {
            wait 1;
        }
    }
}

// Namespace vehicle
// Params 0
// Checksum 0x205eda4e, Offset: 0x4008
// Size: 0x5c
function vehicle_overturn_eject_occupants()
{
    self endon( #"transmute" );
    self endon( #"death" );
    self endon( #"delete" );
    
    for ( ;; )
    {
        self waittill( #"veh_ejectoccupants" );
        
        if ( isdefined( level.onejectoccupants ) )
        {
            [[ level.onejectoccupants ]]();
        }
        
        wait 0.25;
    }
}

// Namespace vehicle
// Params 0
// Checksum 0x8812b93b, Offset: 0x4070
// Size: 0x86
function vehicle_eject_all_occupants()
{
    occupants = self getvehoccupants();
    
    if ( isdefined( occupants ) )
    {
        for ( i = 0; i < occupants.size ; i++ )
        {
            if ( isdefined( occupants[ i ] ) )
            {
                occupants[ i ] unlink();
            }
        }
    }
}

// Namespace vehicle
// Params 0
// Checksum 0xb3f38289, Offset: 0x4100
// Size: 0xd4
function vehicle_overturn_suicide()
{
    self endon( #"transmute" );
    self endon( #"death" );
    self endon( #"delete" );
    self wait_for_vehicle_overturn();
    seconds = randomfloatrange( 5, 7 );
    wait seconds;
    damageorigin = self.origin + ( 0, 0, 25 );
    self finishvehicleradiusdamage( self, self, 32000, 32000, 32000, 0, "MOD_EXPLOSIVE", level.weaponnone, damageorigin, 400, -1, ( 0, 0, 1 ), 0 );
}

// Namespace vehicle
// Params 0
// Checksum 0x80513ea6, Offset: 0x41e0
// Size: 0x1c
function suicide()
{
    self kill_vehicle( self );
}

// Namespace vehicle
// Params 1
// Checksum 0xd0012f23, Offset: 0x4208
// Size: 0x74
function kill_vehicle( attacker )
{
    damageorigin = self.origin + ( 0, 0, 1 );
    self finishvehicleradiusdamage( attacker, attacker, 32000, 32000, 10, 0, "MOD_EXPLOSIVE", level.weaponnone, damageorigin, 400, -1, ( 0, 0, 1 ), 0 );
}

// Namespace vehicle
// Params 2
// Checksum 0x7b3b28c3, Offset: 0x4288
// Size: 0x28
function value_with_default( preferred_value, default_value )
{
    if ( isdefined( preferred_value ) )
    {
        return preferred_value;
    }
    
    return default_value;
}

// Namespace vehicle
// Params 1
// Checksum 0x2cce2fc9, Offset: 0x42b8
// Size: 0x3ec
function vehicle_transmute( attacker )
{
    deathorigin = self.origin;
    deathangles = self.angles;
    vehicle_name = get_vehicle_name_key_for_damage_states( self );
    respawn_parameters = spawnstruct();
    respawn_parameters.origin = self.initial_state.origin;
    respawn_parameters.angles = self.initial_state.angles;
    respawn_parameters.health = self.initial_state.health;
    respawn_parameters.targetname = value_with_default( self.targetname, "" );
    respawn_parameters.vehicletype = value_with_default( self.vehicletype, "" );
    respawn_parameters.destructibledef = self.destructibledef;
    vehiclewasdestroyed = !isdefined( self.recycling );
    
    if ( vehiclewasdestroyed || vehicle_should_explode_on_cleanup() )
    {
        _spawn_explosion( deathorigin );
        
        if ( vehiclewasdestroyed && getdvarint( "scr_veh_explosion_doradiusdamage" ) != 0 )
        {
            explosionradius = getdvarint( "scr_veh_explosion_radius" );
            explosionmindamage = getdvarint( "scr_veh_explosion_mindamage" );
            explosionmaxdamage = getdvarint( "scr_veh_explosion_maxdamage" );
            self kill_vehicle( attacker );
            self radiusdamage( deathorigin, explosionradius, explosionmaxdamage, explosionmindamage, attacker, "MOD_EXPLOSIVE", getweapon( self.vehicletype + "_explosion" ) );
        }
    }
    
    self notify( #"transmute" );
    respawn_vehicle_now = 1;
    
    if ( vehiclewasdestroyed && getdvarint( "scr_veh_ondeath_createhusk" ) != 0 )
    {
        if ( getdvarint( "scr_veh_ondeath_usevehicleashusk" ) != 0 )
        {
            husk = self;
            self.is_husk = 1;
        }
        else
        {
            husk = _spawn_husk( deathorigin, deathangles, self.vehmodel );
        }
        
        husk _init_husk( vehicle_name, respawn_parameters );
        
        if ( getdvarint( "scr_veh_respawnafterhuskcleanup" ) != 0 )
        {
            respawn_vehicle_now = 0;
        }
    }
    
    if ( !isdefined( self.is_husk ) )
    {
        self remove_vehicle_from_world();
    }
    
    if ( getdvarint( "scr_veh_disablerespawn" ) != 0 )
    {
        respawn_vehicle_now = 0;
    }
    
    if ( respawn_vehicle_now )
    {
        respawn_vehicle( respawn_parameters );
    }
}

// Namespace vehicle
// Params 1
// Checksum 0xca087a8c, Offset: 0x46b0
// Size: 0x21c
function respawn_vehicle( respawn_parameters )
{
    mintime = getdvarint( "scr_veh_respawntimemin" );
    maxtime = getdvarint( "scr_veh_respawntimemax" );
    seconds = randomfloatrange( mintime, maxtime );
    wait seconds;
    wait_until_vehicle_position_wont_telefrag( respawn_parameters.origin );
    
    if ( !manage_vehicles() )
    {
        /#
            iprintln( "<dev string:x9f>" );
        #/
        
        return;
    }
    
    if ( isdefined( respawn_parameters.destructibledef ) )
    {
        vehicle = spawnvehicle( respawn_parameters.vehicletype, respawn_parameters.origin, respawn_parameters.angles, respawn_parameters.targetname, respawn_parameters.destructibledef );
    }
    else
    {
        vehicle = spawnvehicle( respawn_parameters.vehicletype, respawn_parameters.origin, respawn_parameters.angles, respawn_parameters.targetname );
    }
    
    vehicle.vehicletype = respawn_parameters.vehicletype;
    vehicle.destructibledef = respawn_parameters.destructibledef;
    vehicle.health = respawn_parameters.health;
    vehicle init_vehicle();
    vehicle vehicle_telefrag_griefers_at_position( respawn_parameters.origin );
}

// Namespace vehicle
// Params 0
// Checksum 0xea224d3c, Offset: 0x48d8
// Size: 0x72
function remove_vehicle_from_world()
{
    self notify( #"removed" );
    
    if ( isdefined( self.original_vehicle ) )
    {
        if ( !isdefined( self.permanentlyremoved ) )
        {
            self.permanentlyremoved = 1;
            self thread hide_vehicle();
        }
        
        return 0;
    }
    
    self _delete_entity();
    return 1;
}

// Namespace vehicle
// Params 0
// Checksum 0x66fbda12, Offset: 0x4958
// Size: 0x1c
function _delete_entity()
{
    /#
    #/
    
    self delete();
}

// Namespace vehicle
// Params 0
// Checksum 0x8f76ef3b, Offset: 0x4980
// Size: 0x7a
function hide_vehicle()
{
    under_the_world = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - 10000 );
    self.origin = under_the_world;
    wait 0.1;
    self hide();
    self notify( #"hidden_permanently" );
}

// Namespace vehicle
// Params 0
// Checksum 0x6cc13dc0, Offset: 0x4a08
// Size: 0x2ca
function wait_for_unnoticeable_cleanup_opportunity()
{
    maxpreventdistancefeet = getdvarint( "scr_veh_disappear_maxpreventdistancefeet" );
    maxpreventvisibilityfeet = getdvarint( "scr_veh_disappear_maxpreventvisibilityfeet" );
    maxpreventdistanceinchessq = 144 * maxpreventdistancefeet * maxpreventdistancefeet;
    maxpreventvisibilityinchessq = 144 * maxpreventvisibilityfeet * maxpreventvisibilityfeet;
    maxsecondstowait = getdvarfloat( "scr_veh_disappear_maxwaittime" );
    iterationwaitseconds = 1;
    secondswaited = 0;
    
    while ( secondswaited < maxsecondstowait )
    {
        players_s = util::get_all_alive_players_s();
        oktocleanup = 1;
        
        for ( j = 0; j < players_s.a.size && oktocleanup ; j++ )
        {
            player = players_s.a[ j ];
            distinchessq = distancesquared( self.origin, player.origin );
            
            if ( distinchessq < maxpreventdistanceinchessq )
            {
                self cleanup_debug_print( "(" + maxsecondstowait - secondswaited + "s) Player too close: " + distinchessq + "<" + maxpreventdistanceinchessq );
                oktocleanup = 0;
                continue;
            }
            
            if ( distinchessq < maxpreventvisibilityinchessq )
            {
                vehiclevisibilityfromplayer = self sightconetrace( player.origin, player, anglestoforward( player.angles ) );
                
                if ( vehiclevisibilityfromplayer > 0 )
                {
                    self cleanup_debug_print( "(" + maxsecondstowait - secondswaited + "s) Player can see" );
                    oktocleanup = 0;
                }
            }
        }
        
        if ( oktocleanup )
        {
            return;
        }
        
        wait iterationwaitseconds;
        secondswaited += iterationwaitseconds;
    }
}

// Namespace vehicle
// Params 1
// Checksum 0x345f15f, Offset: 0x4ce0
// Size: 0xa0
function wait_until_vehicle_position_wont_telefrag( position )
{
    maxiterations = getdvarint( "scr_veh_respawnwait_maxiterations" );
    iterationwaitseconds = getdvarint( "scr_veh_respawnwait_iterationwaitseconds" );
    
    for ( i = 0; i < maxiterations ; i++ )
    {
        if ( !vehicle_position_will_telefrag( position ) )
        {
            return;
        }
        
        wait iterationwaitseconds;
    }
}

// Namespace vehicle
// Params 1
// Checksum 0x9102b156, Offset: 0x4d88
// Size: 0x90, Type: bool
function vehicle_position_will_telefrag( position )
{
    players_s = util::get_all_alive_players_s();
    
    for ( i = 0; i < players_s.a.size ; i++ )
    {
        if ( players_s.a[ i ] player_vehicle_position_will_telefrag( position ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle
// Params 1
// Checksum 0xd63c9775, Offset: 0x4e20
// Size: 0xf6
function vehicle_telefrag_griefers_at_position( position )
{
    attacker = self;
    inflictor = self;
    players_s = util::get_all_alive_players_s();
    
    for ( i = 0; i < players_s.a.size ; i++ )
    {
        player = players_s.a[ i ];
        
        if ( player player_vehicle_position_will_telefrag( position ) )
        {
            player dodamage( 20000, player.origin + ( 0, 0, 1 ), attacker, inflictor, "none" );
        }
    }
}

// Namespace vehicle
// Params 1
// Checksum 0x8066f431, Offset: 0x4f20
// Size: 0x6a, Type: bool
function player_vehicle_position_will_telefrag( position )
{
    distanceinches = 240;
    mindistinchessq = distanceinches * distanceinches;
    distinchessq = distancesquared( self.origin, position );
    return distinchessq < mindistinchessq;
}

// Namespace vehicle
// Params 0
// Checksum 0x96db3ef4, Offset: 0x4f98
// Size: 0x4c
function vehicle_recycle_spawner_t()
{
    self endon( #"delete" );
    self waittill( #"death", attacker );
    
    if ( isdefined( self ) )
    {
        self vehicle_transmute( attacker );
    }
}

// Namespace vehicle
// Params 0
// Checksum 0xe3642018, Offset: 0x4ff0
// Size: 0x24
function vehicle_play_explosion_sound()
{
    self playsound( "car_explo_large" );
}

// Namespace vehicle
// Params 0
// Checksum 0xa27cd50d, Offset: 0x5020
// Size: 0x228
function vehicle_damage_t()
{
    self endon( #"delete" );
    self endon( #"removed" );
    
    for ( ;; )
    {
        self waittill( #"damage", damage, attacker );
        players = getplayers();
        
        for ( i = 0; i < players.size ; i++ )
        {
            if ( !isalive( players[ i ] ) )
            {
                continue;
            }
            
            vehicle = players[ i ] getvehicleoccupied();
            
            if ( isdefined( vehicle ) && self == vehicle && players[ i ] player_is_driver() )
            {
                if ( damage > 0 )
                {
                    earthquake( damage / 400, 1, players[ i ].origin, 512, players[ i ] );
                }
                
                if ( damage > 100 )
                {
                    println( "<dev string:x109>" );
                    players[ i ] playrumbleonentity( "tank_damage_heavy_mp" );
                    continue;
                }
                
                if ( damage > 10 )
                {
                    println( "<dev string:x11f>" );
                    players[ i ] playrumbleonentity( "tank_damage_light_mp" );
                }
            }
        }
        
        update_damage_effects( self, attacker );
    }
}

// Namespace vehicle
// Params 3
// Checksum 0x37db1f15, Offset: 0x5250
// Size: 0xa8
function _spawn_husk( origin, angles, modelname )
{
    husk = spawn( "script_model", origin );
    husk.angles = angles;
    husk setmodel( modelname );
    husk.health = 1;
    husk setcandamage( 0 );
    return husk;
}

// Namespace vehicle
// Params 0
// Checksum 0xfe483b22, Offset: 0x5300
// Size: 0xc, Type: bool
function is_vehicle()
{
    return isdefined( self.vehicletype );
}

// Namespace vehicle
// Params 0
// Checksum 0xa7480bb, Offset: 0x5318
// Size: 0x54
function swap_to_husk_model()
{
    if ( isdefined( self.vehicletype ) )
    {
        husk_model = level.veh_husk_models[ self.vehicletype ];
        
        if ( isdefined( husk_model ) )
        {
            self setmodel( husk_model );
        }
    }
}

// Namespace vehicle
// Params 2
// Checksum 0x7095da79, Offset: 0x5378
// Size: 0x2b4
function _init_husk( vehicle_name, respawn_parameters )
{
    self swap_to_husk_model();
    
    if ( isdefined( level.vehicles_husk_effects ) )
    {
        effects = level.vehicles_husk_effects[ vehicle_name ];
        self play_vehicle_effects( effects );
    }
    
    self.respawn_parameters = respawn_parameters;
    forcepointvariance = getdvarint( "scr_veh_explosion_husk_forcepointvariance" );
    horzvelocityvariance = getdvarint( "scr_veh_explosion_husk_horzvelocityvariance" );
    vertvelocitymin = getdvarint( "scr_veh_explosion_husk_vertvelocitymin" );
    vertvelocitymax = getdvarint( "scr_veh_explosion_husk_vertvelocitymax" );
    forcepointx = randomfloatrange( 0 - forcepointvariance, forcepointvariance );
    forcepointy = randomfloatrange( 0 - forcepointvariance, forcepointvariance );
    forcepoint = ( forcepointx, forcepointy, 0 );
    forcepoint += self.origin;
    initialvelocityx = randomfloatrange( 0 - horzvelocityvariance, horzvelocityvariance );
    initialvelocityy = randomfloatrange( 0 - horzvelocityvariance, horzvelocityvariance );
    initialvelocityz = randomfloatrange( vertvelocitymin, vertvelocitymax );
    initialvelocity = ( initialvelocityx, initialvelocityy, initialvelocityz );
    
    if ( self is_vehicle() )
    {
        self launchvehicle( initialvelocity, forcepoint );
    }
    else
    {
        self physicslaunch( forcepoint, initialvelocity );
    }
    
    self thread husk_cleanup_t();
    
    /#
        self thread cleanup_debug_print_t();
    #/
}

// Namespace vehicle
// Params 0
// Checksum 0x48970d5c, Offset: 0x5638
// Size: 0x8c
function husk_cleanup_t()
{
    self endon( #"death" );
    self endon( #"delete" );
    self endon( #"hidden_permanently" );
    respawn_parameters = self.respawn_parameters;
    self do_dead_cleanup_wait( "Husk Cleanup Test" );
    self wait_for_unnoticeable_cleanup_opportunity();
    self thread final_husk_cleanup_t( respawn_parameters );
}

// Namespace vehicle
// Params 1
// Checksum 0x1e62cd8a, Offset: 0x56d0
// Size: 0x7c
function final_husk_cleanup_t( respawn_parameters )
{
    self husk_do_cleanup();
    
    if ( getdvarint( "scr_veh_respawnafterhuskcleanup" ) != 0 )
    {
        if ( getdvarint( "scr_veh_disablerespawn" ) == 0 )
        {
            respawn_vehicle( respawn_parameters );
        }
    }
}

// Namespace vehicle
// Params 0
// Checksum 0x89b17569, Offset: 0x5758
// Size: 0x72
function husk_do_cleanup()
{
    self _spawn_explosion( self.origin );
    
    if ( self is_vehicle() )
    {
        return self remove_vehicle_from_world();
    }
    
    self _delete_entity();
    return 1;
}

// Namespace vehicle
// Params 1
// Checksum 0xfe221f1b, Offset: 0x57d8
// Size: 0xf4
function _spawn_explosion( origin )
{
    if ( getdvarint( "scr_veh_explosion_spawnfx" ) == 0 )
    {
        return;
    }
    
    if ( isdefined( level.vehicle_explosion_effect ) )
    {
        forward = ( 0, 0, 1 );
        rot = randomfloat( 360 );
        up = ( cos( rot ), sin( rot ), 0 );
        playfx( level.vehicle_explosion_effect, origin, forward, up );
    }
    
    thread _play_sound_in_space( "vehicle_explo", origin );
}

// Namespace vehicle
// Params 2
// Checksum 0xd6c52b89, Offset: 0x58d8
// Size: 0x9c
function _play_sound_in_space( soundeffectname, origin )
{
    org = spawn( "script_origin", origin );
    org.origin = origin;
    org playsoundwithnotify( soundeffectname, "sounddone" );
    org waittill( #"sounddone" );
    org delete();
}

// Namespace vehicle
// Params 0
// Checksum 0xab69d102, Offset: 0x5980
// Size: 0x12
function vehicle_kill_disconnect_paths_forever()
{
    self notify( #"kill_disconnect_paths_forever" );
}

// Namespace vehicle
// Params 0
// Checksum 0x99ec1590, Offset: 0x59a0
// Size: 0x4
function vehicle_disconnect_paths()
{
    
}

// Namespace vehicle
// Params 1
// Checksum 0xf95fc0ca, Offset: 0x59b0
// Size: 0x164
function follow_path( node )
{
    self endon( #"death" );
    assert( isdefined( node ), "<dev string:x135>" );
    self notify( #"newpath" );
    
    if ( isdefined( node ) )
    {
        self.attachedpath = node;
    }
    
    pathstart = self.attachedpath;
    self.currentnode = self.attachedpath;
    
    if ( !isdefined( pathstart ) )
    {
        return;
    }
    
    self attachpath( pathstart );
    self startpath();
    self endon( #"newpath" );
    nextpoint = pathstart;
    
    while ( isdefined( nextpoint ) )
    {
        self waittill( #"reached_node", nextpoint );
        self.currentnode = nextpoint;
        nextpoint notify( #"trigger", self );
        
        if ( isdefined( nextpoint.script_noteworthy ) )
        {
            self notify( nextpoint.script_noteworthy );
            self notify( #"noteworthy", nextpoint.script_noteworthy, nextpoint );
        }
        
        waittillframeend();
    }
}

// Namespace vehicle
// Params 0
// Checksum 0xbabac715, Offset: 0x5b20
// Size: 0xac
function initvehiclemap()
{
    root = "devgui_cmd \"MP/Vehicles/";
    adddebugcommand( root + "Spawn siegebot\" \"set scr_spawnvehicle 1\"\n" );
    adddebugcommand( root + "Spawn siegebot boss\" \"set scr_spawnvehicle 2\"\n" );
    adddebugcommand( root + "Spawn quadtank\" \"set scr_spawnvehicle 3\"\n" );
    adddebugcommand( root + "Spawn mechtank\" \"set scr_spawnvehicle 4\"\n" );
    thread vehiclemainthread();
}

// Namespace vehicle
// Params 0
// Checksum 0x3ba61492, Offset: 0x5bd8
// Size: 0x188
function vehiclemainthread()
{
    if ( level.disablevehiclespawners === 1 )
    {
        return;
    }
    
    spawn_nodes = struct::get_array( "veh_spawn_point", "targetname" );
    veh_spawner_id = 0;
    
    for ( i = 0; i < spawn_nodes.size ; i++ )
    {
        spawn_node = spawn_nodes[ i ];
        veh_name = spawn_node.script_noteworthy;
        time_interval = int( spawn_node.script_parameters );
        
        if ( !isdefined( veh_name ) )
        {
            continue;
        }
        
        veh_spawner_id++;
        thread vehiclespawnthread( veh_spawner_id, veh_name, spawn_node.origin, spawn_node.angles, time_interval );
        
        if ( isdefined( level.vehicle_spawner_init ) )
        {
            level [[ level.vehicle_spawner_init ]]( veh_spawner_id, veh_name, spawn_node.origin, spawn_node.angles );
        }
        
        wait 0.05;
    }
    
    if ( isdefined( level.vehicle_spawners_init_finished ) )
    {
        level thread [[ level.vehicle_spawners_init_finished ]]();
    }
}

// Namespace vehicle
// Params 5
// Checksum 0x60c44d1d, Offset: 0x5d68
// Size: 0x2ee
function vehiclespawnthread( veh_spawner_id, veh_name, origin, angles, time_interval )
{
    level endon( #"game_ended" );
    veh_spawner = getent( veh_name + "_spawner", "targetname" );
    kill_trigger = spawn( "trigger_radius", origin, 0, 60, 180 );
    
    /#
        level thread function_87e9a4ad( veh_name, origin, angles );
        var_45b6c208 = time_interval;
    #/
    
    while ( true )
    {
        vehicle = veh_spawner spawnfromspawner( veh_name, 1, 1, 1 );
        
        if ( !isdefined( vehicle ) )
        {
            wait randomfloatrange( 1, 2 );
            continue;
        }
        
        if ( isdefined( vehicle.archetype ) )
        {
            vehicle asmrequestsubstate( "locomotion@movement" );
        }
        
        wait 0.05;
        vehicle.origin = origin;
        vehicle.angles = angles;
        vehicle.veh_spawner_id = veh_spawner_id;
        vehicle thread vehicleteamthread();
        
        /#
            level thread function_4b28749d( vehicle );
        #/
        
        vehicle waittill( #"death" );
        vehicle vehicle_death::deletewhensafe( 0.25 );
        
        if ( isdefined( level.vehicle_destroyed ) )
        {
            level thread [[ level.vehicle_destroyed ]]( veh_spawner_id );
        }
        
        /#
            time_interval = var_45b6c208;
            
            if ( getdvarfloat( "<dev string:x15a>", 0 ) != 0 )
            {
                time_interval = getdvarfloat( "<dev string:x15a>", 0 );
                
                if ( time_interval < 5.1 )
                {
                    time_interval = 5.1;
                }
            }
        #/
        
        if ( isdefined( time_interval ) )
        {
            level thread performvehicleprespawn( veh_spawner_id, veh_name, origin, angles, time_interval, kill_trigger );
            wait time_interval;
        }
    }
}

// Namespace vehicle
// Params 6
// Checksum 0xefce4e, Offset: 0x6060
// Size: 0x10a
function performvehicleprespawn( veh_spawner_id, veh_name, origin, angles, spawn_delay, kill_trigger )
{
    fx_prespawn_time = 5;
    fx_spawn_delay = spawn_delay - fx_prespawn_time;
    wait fx_spawn_delay;
    
    if ( isdefined( level.vehicle_about_to_spawn ) )
    {
        level thread [[ level.vehicle_about_to_spawn ]]( veh_spawner_id, veh_name, origin, angles, fx_prespawn_time );
    }
    
    kill_overlap_time = 0.1;
    wait_before_kill = fx_prespawn_time - kill_overlap_time;
    wait wait_before_kill;
    kill_duration_ms = kill_overlap_time * 2 * 1000;
    level thread kill_any_touching( kill_trigger, kill_duration_ms );
    wait kill_overlap_time;
}

// Namespace vehicle
// Params 2
// Checksum 0x3f32b906, Offset: 0x6178
// Size: 0x2e8
function kill_any_touching( kill_trigger, kill_duration_ms )
{
    kill_expire_time_ms = gettime() + kill_duration_ms;
    kill_weapon = getweapon( "hero_minigun" );
    
    while ( gettime() <= kill_expire_time_ms )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player istouching( kill_trigger ) )
            {
                if ( player isinvehicle() )
                {
                    vehicle = player getvehicleoccupied();
                    
                    if ( isdefined( vehicle ) && vehicle.is_oob_kill_target === 1 )
                    {
                        destroy_vehicle( vehicle );
                        continue;
                    }
                }
                
                player dodamage( player.health + 1, player.origin, kill_trigger, kill_trigger, "none", "MOD_SUICIDE", 0, kill_weapon );
            }
        }
        
        potential_victims = getaiarray();
        
        if ( isdefined( potential_victims ) )
        {
            foreach ( entity in potential_victims )
            {
                if ( !isdefined( entity ) )
                {
                    continue;
                }
                
                if ( !entity istouching( kill_trigger ) )
                {
                    continue;
                }
                
                if ( isdefined( entity.health ) && entity.health <= 0 )
                {
                    continue;
                }
                
                if ( isvehicle( entity ) )
                {
                    destroy_vehicle( entity );
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace vehicle
// Params 1
// Checksum 0x54144afe, Offset: 0x6468
// Size: 0x54
function destroy_vehicle( vehicle )
{
    vehicle dodamage( vehicle.health + 10000, vehicle.origin, undefined, undefined, "none", "MOD_TRIGGER_HURT" );
}

/#

    // Namespace vehicle
    // Params 3
    // Checksum 0x66c0f5c1, Offset: 0x64c8
    // Size: 0xa0, Type: dev
    function function_87e9a4ad( veh_name, origin, angles )
    {
        fx_prespawn_time = 5;
        
        while ( true )
        {
            if ( getdvarint( "<dev string:x171>", 0 ) == 0 )
            {
                wait 1;
                continue;
            }
            
            if ( isdefined( level.vehicle_about_to_spawn ) )
            {
                level thread [[ level.vehicle_about_to_spawn ]]( veh_name, origin, angles, fx_prespawn_time );
            }
            
            wait 6;
        }
    }

    // Namespace vehicle
    // Params 1
    // Checksum 0x58a9b96a, Offset: 0x6570
    // Size: 0x80, Type: dev
    function function_4b28749d( vehicle )
    {
        vehicle endon( #"death" );
        setdvar( "<dev string:x18c>", 0 );
        
        while ( true )
        {
            if ( getdvarint( "<dev string:x18c>" ) != 0 )
            {
                destroy_vehicle( vehicle );
            }
            
            wait 1;
        }
    }

#/

// Namespace vehicle
// Params 0
// Checksum 0xfd6245e9, Offset: 0x65f8
// Size: 0x2f0
function vehicleteamthread()
{
    vehicle = self;
    vehicle endon( #"death" );
    vehicle makevehicleusable();
    
    if ( target_istarget( vehicle ) )
    {
        target_remove( vehicle );
    }
    
    vehicle.nojumping = 1;
    vehicle.forcedamagefeedback = 1;
    vehicle.vehkilloccupantsondeath = 1;
    vehicle disableaimassist();
    
    while ( true )
    {
        vehicle setteam( "neutral" );
        vehicle.ignoreme = 1;
        vehicle clientfield::set( "toggle_lights", 1 );
        
        if ( target_istarget( vehicle ) )
        {
            target_remove( vehicle );
        }
        
        vehicle waittill( #"enter_vehicle", player );
        player clearandcacheperks();
        vehicle setteam( player.team );
        vehicle.ignoreme = 0;
        vehicle clientfield::set( "toggle_lights", 0 );
        vehicle spawning::create_entity_enemy_influencer( "small_vehicle", player.team );
        player spawning::enable_influencers( 0 );
        
        if ( !target_istarget( vehicle ) )
        {
            if ( isdefined( vehicle.targetoffset ) )
            {
                target_set( vehicle, vehicle.targetoffset );
            }
            else
            {
                target_set( vehicle, ( 0, 0, 0 ) );
            }
        }
        
        vehicle thread watchplayerexitrequestthread( player );
        vehicle waittill( #"exit_vehicle", player );
        
        if ( isdefined( player ) )
        {
            player setcachedperks();
            player spawning::enable_influencers( 1 );
        }
        
        vehicle spawning::remove_influencers();
    }
}

// Namespace vehicle
// Params 1
// Checksum 0xfbb5a3c4, Offset: 0x68f0
// Size: 0xe0
function watchplayerexitrequestthread( player )
{
    level endon( #"game_ended" );
    player endon( #"death" );
    player endon( #"disconnect" );
    vehicle = self;
    vehicle endon( #"death" );
    wait 1.5;
    
    while ( true )
    {
        timeused = 0;
        
        while ( player usebuttonpressed() )
        {
            timeused += 0.05;
            
            if ( timeused > 0.25 )
            {
                player unlink();
                return;
            }
            
            wait 0.05;
        }
        
        wait 0.05;
    }
}

// Namespace vehicle
// Params 0
// Checksum 0x827e76eb, Offset: 0x69d8
// Size: 0x3c
function clearandcacheperks()
{
    self.perks_before_vehicle = self getperks();
    self clearperks();
}

// Namespace vehicle
// Params 0
// Checksum 0x33670fe2, Offset: 0x6a20
// Size: 0xaa
function setcachedperks()
{
    assert( isdefined( self.perks_before_vehicle ) );
    
    foreach ( perk in self.perks_before_vehicle )
    {
        self setperk( perk );
    }
}

