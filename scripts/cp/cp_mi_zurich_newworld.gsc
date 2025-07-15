#using scripts/codescripts/struct;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_collectibles;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_newworld_accolades;
#using scripts/cp/cp_mi_zurich_newworld_factory;
#using scripts/cp/cp_mi_zurich_newworld_fx;
#using scripts/cp/cp_mi_zurich_newworld_lab;
#using scripts/cp/cp_mi_zurich_newworld_patch;
#using scripts/cp/cp_mi_zurich_newworld_rooftops;
#using scripts/cp/cp_mi_zurich_newworld_sound;
#using scripts/cp/cp_mi_zurich_newworld_train;
#using scripts/cp/cp_mi_zurich_newworld_underground;
#using scripts/cp/cp_mi_zurich_newworld_util;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace newworld;

// Namespace newworld
// Params 0
// Checksum 0xcf91fdda, Offset: 0xec8
// Size: 0x34
function setup_rex_starts()
{
    util::add_gametype( "coop" );
    util::add_gametype( "cpzm" );
}

// Namespace newworld
// Params 0
// Checksum 0xa751c7ef, Offset: 0xf08
// Size: 0x1a4
function main()
{
    if ( sessionmodeiscampaignzombiesgame() && -1 )
    {
        setclearanceceiling( 34 );
    }
    else
    {
        setclearanceceiling( 29 );
    }
    
    level.friendlyfiredisabled = 1;
    newworld_accolades::function_4d39a2af();
    savegame::set_mission_name( "newworld" );
    init_clientfields();
    init_flags();
    init_fx();
    cp_mi_zurich_newworld_fx::main();
    cp_mi_zurich_newworld_sound::main();
    setup_skiptos();
    util::init_streamer_hints( 10 );
    callback::on_spawned( &on_player_spawn );
    callback::on_connect( &on_player_connect );
    callback::on_loadout( &newworld_util::on_player_loadout );
    load::main();
    cp_mi_zurich_newworld_patch::function_7403e82b();
    level thread level_threads();
    newworld_util::player_snow_fx();
}

// Namespace newworld
// Params 0
// Checksum 0xa6c72487, Offset: 0x10b8
// Size: 0x1e
function init_fx()
{
    level._effect[ "smk_idle_cauldron" ] = "smoke/fx_smk_idle_cauldron";
}

// Namespace newworld
// Params 0
// Checksum 0xb8c18419, Offset: 0x10e0
// Size: 0x9f4
function init_clientfields()
{
    clientfield::register( "actor", "diaz_camo_shader", 1, 2, "int" );
    clientfield::register( "vehicle", "name_diaz_wasp", 1, 1, "int" );
    clientfield::register( "scriptmover", "weakpoint", 1, 1, "int" );
    clientfield::register( "world", "factory_exterior_vents", 1, 1, "int" );
    clientfield::register( "scriptmover", "open_vat_doors", 1, 1, "int" );
    clientfield::register( "world", "chase_pedestrian_blockers", 1, 1, "int" );
    clientfield::register( "toplayer", "chase_train_rumble", 1, 1, "int" );
    clientfield::register( "world", "spinning_vent_fxanim", 1, 1, "int" );
    clientfield::register( "world", "crane_fxanim", 1, 1, "int" );
    clientfield::register( "world", "underground_subway_debris", 1, 2, "int" );
    clientfield::register( "toplayer", "ability_wheel_tutorial", 1, 1, "int" );
    clientfield::register( "world", "underground_subway_wires", 1, 1, "int" );
    clientfield::register( "world", "inbound_igc_glass", 1, 2, "int" );
    clientfield::register( "world", "train_robot_swing_glass_left", 1, 2, "int" );
    clientfield::register( "world", "train_robot_swing_glass_right", 1, 2, "int" );
    clientfield::register( "world", "train_robot_swing_left_extra", 1, 1, "int" );
    clientfield::register( "world", "train_robot_swing_right_extra", 1, 1, "int" );
    clientfield::register( "world", "train_dropdown_glass", 1, 2, "int" );
    clientfield::register( "world", "train_lockdown_glass_left", 1, 2, "int" );
    clientfield::register( "world", "train_lockdown_glass_right", 1, 2, "int" );
    clientfield::register( "world", "train_lockdown_shutters_1", 1, 1, "int" );
    clientfield::register( "world", "train_lockdown_shutters_2", 1, 1, "int" );
    clientfield::register( "world", "train_lockdown_shutters_3", 1, 1, "int" );
    clientfield::register( "world", "train_lockdown_shutters_4", 1, 1, "int" );
    clientfield::register( "world", "train_lockdown_shutters_5", 1, 1, "int" );
    clientfield::register( "actor", "train_throw_robot_corpses", 1, 1, "int" );
    clientfield::register( "scriptmover", "train_throw_robot_corpses", 1, 1, "int" );
    clientfield::register( "world", "train_brake_flaps", 1, 2, "int" );
    clientfield::register( "world", "waterplant_rotate_fans", 1, 1, "int" );
    clientfield::register( "world", "train_main_fx_occlude", 1, 1, "int" );
    clientfield::register( "world", "sndTrainContext", 1, 2, "int" );
    clientfield::register( "world", "set_fog_bank", 1, 2, "int" );
    clientfield::register( "actor", "derez_ai_deaths", 1, 1, "int" );
    clientfield::register( "actor", "chase_suspect_fx", 1, 1, "int" );
    clientfield::register( "actor", "wall_run_fx", 1, 1, "int" );
    clientfield::register( "actor", "cs_rez_in_fx", 1, 2, "counter" );
    clientfield::register( "actor", "cs_rez_out_fx", 1, 2, "counter" );
    clientfield::register( "scriptmover", "derez_ai_deaths", 1, 1, "int" );
    clientfield::register( "scriptmover", "truck_explosion_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "derez_model_deaths", 1, 1, "int" );
    clientfield::register( "scriptmover", "emp_door_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "smoke_grenade_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "frag_grenade_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "wall_break_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "train_explosion_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "wasp_hack_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "train_fx_occlude", 1, 1, "int" );
    clientfield::register( "vehicle", "wasp_hack_fx", 1, 1, "int" );
    clientfield::register( "vehicle", "emp_vehicles_fx", 1, 1, "int" );
    clientfield::register( "world", "player_snow_fx", 1, 4, "int" );
    clientfield::register( "allplayers", "player_spawn_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "emp_generator_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "train_rumble_loop", 1, 1, "int" );
}

// Namespace newworld
// Params 0
// Checksum 0x8cc348d6, Offset: 0x1ae0
// Size: 0xa4
function init_flags()
{
    level flag::init( "foundry_remote_hijack_enabled" );
    level flag::init( "ptsd_active" );
    level flag::init( "ptsd_area_clear" );
    level flag::init( "chase_train_station_glass_ceiling" );
    level flag::init( "infinite_white_transition" );
}

// Namespace newworld
// Params 0
// Checksum 0x137be0d3, Offset: 0x1b90
// Size: 0xf4
function level_threads()
{
    spawner::add_spawn_function_group( "civilian", "script_noteworthy", &civilian_spawn_function );
    spawner::add_global_spawn_function( "axis", &newworld_util::ai_death_derez );
    spawner::add_spawn_function_ai_group( "factory_allies", &util::magic_bullet_shield );
    spawner::add_spawn_function_ai_group( "factory_allies", &newworld_util::ai_death_derez );
    spawner::add_spawn_function_ai_group( "factory_intro_die", &newworld_util::ai_death_derez );
    callback::on_ai_killed( &newworld_util::function_606dbca2 );
}

// Namespace newworld
// Params 0
// Checksum 0x3b16a25f, Offset: 0x1c90
// Size: 0x64
function on_player_spawn()
{
    self newworld_util::function_1943bf79();
    
    if ( !self newworld_util::function_c633d8fe() )
    {
        self.cybercoreselectmenudisabled = 1;
        self clientfield::set_player_uimodel( "hudItems.cybercoreSelectMenuDisabled", 1 );
    }
}

// Namespace newworld
// Params 0
// Checksum 0x893f3dff, Offset: 0x1d00
// Size: 0x44
function on_player_connect()
{
    if ( !self newworld_util::function_c633d8fe() )
    {
        self.disableclassselection = 1;
    }
    
    self newworld_util::function_70176ad6();
}

// Namespace newworld
// Params 0
// Checksum 0x4cb9a9e9, Offset: 0x1d50
// Size: 0x6f4
function setup_skiptos()
{
    skipto::function_d68e678e( "white_infinite_igc", &newworld_train::skipto_white_infinite_igc_init, "White Infinite IGC", &newworld_train::skipto_white_infinite_igc_done );
    skipto::function_d68e678e( "factory_factory_intro_igc", &newworld_factory::skipto_pallas_igc_init, "Factory \x96 Factory Intro IGC", &newworld_factory::skipto_pallas_igc_done );
    skipto::add( "factory_factory_exterior", &newworld_factory::skipto_factory_exterior_init, "Factory \x96 Factory Exterior", &newworld_factory::skipto_factory_exterior_done );
    skipto::function_d68e678e( "factory_alley", &newworld_factory::skipto_alley_init, "Factory \x96 Alley", &newworld_factory::skipto_alley_done );
    skipto::function_d68e678e( "factory_warehouse", &newworld_factory::skipto_warehouse_init, "Factory \x96 Warehouse", &newworld_factory::skipto_warehouse_done );
    skipto::function_d68e678e( "factory_foundry", &newworld_factory::skipto_foundry_init, "Factory \x96 Foundry", &newworld_factory::skipto_foundry_done );
    skipto::function_d68e678e( "factory_vat_room", &newworld_factory::skipto_vat_room_init, "Factory \x96 Vat Room", &newworld_factory::skipto_vat_room_done );
    skipto::function_d68e678e( "factory_inside_man_igc", &newworld_factory::skipto_inside_man_igc_init, "Factory \x96 Inside Man IGC", &newworld_factory::skipto_inside_man_igc_done );
    skipto::add( "chase_apartment_igc", &newworld_rooftops::skipto_apartment_igc_init, "Chase \x96 Apartment IGC", &newworld_rooftops::skipto_apartment_igc_done );
    skipto::function_d68e678e( "chase_chase_start", &newworld_rooftops::skipto_chase_init, "Chase \x96 Chase Start", &newworld_rooftops::skipto_chase_done );
    skipto::add( "chase_bridge_collapse", &newworld_rooftops::skipto_bridge_collapse_igc_init, "Chase \x96 Bridge Collapse", &newworld_rooftops::skipto_bridge_collapse_igc_done );
    skipto::add( "chase_rooftops", &newworld_rooftops::skipto_rooftops_init, "Chase \x96 Rooftops", &newworld_rooftops::skipto_rooftops_done );
    skipto::function_d68e678e( "chase_old_zurich", &newworld_rooftops::function_a7ce33a6, "Chase \x96 Old Zurich", &newworld_rooftops::function_4d063e30 );
    skipto::add( "chase_construction_site", &newworld_rooftops::skipto_construction_site_init, "Chase \x96 Construction Site", &newworld_rooftops::skipto_construction_site_done );
    skipto::function_d68e678e( "chase_glass_ceiling_igc", &newworld_rooftops::skipto_glass_ceiling_igc_init, "Chase \x96 Glass Ceiling IGC", &newworld_rooftops::skipto_glass_ceiling_igc_done );
    skipto::add( "underground_pinned_down_igc", &newworld_underground::skipto_pinned_down_igc_init, "Underground \x96 Pinned Down IGC", &newworld_underground::skipto_pinned_down_igc_done );
    skipto::add( "underground_subway", &newworld_underground::skipto_subway_init, "Underground \x96 Subway", &newworld_underground::skipto_subway_done );
    skipto::function_d68e678e( "underground_crossroads", &newworld_underground::skipto_crossroads_init, "Underground \x96 Crossroads", &newworld_underground::skipto_crossroads_done );
    skipto::function_d68e678e( "underground_construction", &newworld_underground::skipto_construction_init, "Underground \x96 Construction Area", &newworld_underground::skipto_construction_done );
    skipto::function_d68e678e( "underground_maintenance", &newworld_underground::skipto_maintenance_init, "Underground \x96 Maintenance", &newworld_underground::skipto_maintenance_done );
    skipto::function_d68e678e( "underground_water_plant", &newworld_underground::skipto_water_plant_init, "Underground \x96 Water Treatment Plant", &newworld_underground::skipto_water_plant_done );
    skipto::function_d68e678e( "underground_staging_room_igc", &newworld_underground::skipto_staging_room_igc_init, "Underground \x96 Staging Room IGC", &newworld_underground::skipto_staging_room_igc_done );
    skipto::add( "train_inbound_igc", &newworld_train::skipto_inbound_igc_init, "Train \x96 Inbound IGC", &newworld_train::skipto_inbound_igc_done );
    skipto::add( "train_train_start", &newworld_train::skipto_train_init, "Train \x96 Train Start", &newworld_train::skipto_train_done );
    skipto::function_d68e678e( "train_train_roof", &newworld_train::skipto_train_rooftop_init, "Train \x96 Train Roof", &newworld_train::skipto_train_rooftop_done );
    skipto::function_d68e678e( "train_detach_bomb_igc", &newworld_train::skipto_detach_bomb_igc_init, "Train \x96 Detach Bomb IGC", &newworld_train::skipto_detach_bomb_igc_done );
    skipto::add( "waking_up_igc", &newworld_lab::skipto_waking_up_igc_init, "Waking Up IGC", &newworld_lab::skipto_waking_up_igc_done );
    skipto::add_dev( "dev_lab", &newworld_lab::dev_lab_init, "DEV:  Lab" );
}

// Namespace newworld
// Params 0
// Checksum 0x71c446b, Offset: 0x2450
// Size: 0xb4
function civilian_spawn_function()
{
    self.health = 1;
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self disableaimassist();
    self.cybercomtargetstatusoverride = 0;
    self ai::set_behavior_attribute( "panic", 0 );
    self thread civilian_touch_death();
    self thread newworld_util::function_523cdc93();
}

// Namespace newworld
// Params 1
// Checksum 0x1235c211, Offset: 0x2510
// Size: 0xb4
function function_3840d81a( nd_exit )
{
    self endon( #"death" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    self ai::set_behavior_attribute( "panic", 1 );
    self playloopsound( "vox_civ_panic_loop" );
    self ai::force_goal( nd_exit, 8 );
    self waittill( #"goal" );
    newworld_util::function_523cdc93( 0 );
}

// Namespace newworld
// Params 0
// Checksum 0x17b95347, Offset: 0x25d0
// Size: 0x84
function civilian_touch_death()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"touch", e_toucher );
        
        if ( e_toucher.script_noteworthy === "civilian" )
        {
            continue;
        }
        
        if ( self.var_a0f70d54 === e_toucher )
        {
            continue;
        }
        
        newworld_util::function_523cdc93( 0 );
        break;
    }
}

// Namespace newworld
// Params 1
// Checksum 0xf4e6613a, Offset: 0x2660
// Size: 0x2c
function civilian_cleanup_death( var_56c18f67 )
{
    self waittill( #"death" );
    var_56c18f67 util::self_delete();
}

