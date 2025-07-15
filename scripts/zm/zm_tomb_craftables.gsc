#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_ai_quadrotor;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/zm_tomb_amb;
#using scripts/zm/zm_tomb_main_quest;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_vo;

#namespace zm_tomb_craftables;

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x6863187a, Offset: 0x1308
// Size: 0x1a6
function randomize_craftable_spawns()
{
    a_randomized_craftables = array( "gramophone_vinyl_ice", "gramophone_vinyl_air", "gramophone_vinyl_elec", "gramophone_vinyl_fire", "gramophone_vinyl_master", "gramophone_vinyl_player" );
    
    foreach ( str_craftable in a_randomized_craftables )
    {
        s_original_pos = struct::get( str_craftable, "targetname" );
        a_alt_locations = struct::get_array( str_craftable + "_alt", "targetname" );
        n_loc_index = randomintrange( 0, a_alt_locations.size + 1 );
        
        if ( n_loc_index == a_alt_locations.size )
        {
            continue;
        }
        
        s_original_pos.origin = a_alt_locations[ n_loc_index ].origin;
        s_original_pos.angles = a_alt_locations[ n_loc_index ].angles;
    }
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x471f27ce, Offset: 0x14b8
// Size: 0x4a0
function init_craftables()
{
    level flag::init( "quadrotor_cooling_down" );
    level.craftable_piece_count = 4;
    level flag::init( "any_crystal_picked_up" );
    level flag::init( "staff_air_zm_enabled" );
    level flag::init( "staff_fire_zm_enabled" );
    level flag::init( "staff_lightning_zm_enabled" );
    level flag::init( "staff_water_zm_enabled" );
    level flag::init( "staff_air_picked_up" );
    level flag::init( "staff_fire_picked_up" );
    level flag::init( "staff_lightning_picked_up" );
    level flag::init( "staff_water_picked_up" );
    zm_craftables::add_zombie_craftable( "equip_dieseldrone", &"ZM_TOMB_CRQ", &"ZM_TOMB_CRQ", &"ZM_TOMB_TQ", &onfullycrafted_quadrotor, 1 );
    zm_craftables::add_zombie_craftable_vox_category( "equip_dieseldrone", "build_dd" );
    zm_craftables::make_zombie_craftable_open( "equip_dieseldrone", "veh_t7_dlc_zm_quadrotor", ( 0, 0, 0 ), ( 0, -4, 10 ) );
    zm_craftables::add_zombie_craftable( "elemental_staff_fire", &"ZM_TOMB_CRF", &"ZM_TOMB_INS", &"ZM_TOMB_BOF", &staff_fire_fullycrafted, 1 );
    zm_craftables::add_zombie_craftable_vox_category( "elemental_staff_fire", "fire_staff" );
    zm_craftables::add_zombie_craftable( "elemental_staff_air", &"ZM_TOMB_CRA", &"ZM_TOMB_INS", &"ZM_TOMB_BOA", &staff_air_fullycrafted, 1 );
    zm_craftables::add_zombie_craftable_vox_category( "elemental_staff_air", "air_staff" );
    zm_craftables::add_zombie_craftable( "elemental_staff_lightning", &"ZM_TOMB_CRL", &"ZM_TOMB_INS", &"ZM_TOMB_BOL", &staff_lightning_fullycrafted, 1 );
    zm_craftables::add_zombie_craftable_vox_category( "elemental_staff_lightning", "light_staff" );
    zm_craftables::add_zombie_craftable( "elemental_staff_water", &"ZM_TOMB_CRW", &"ZM_TOMB_INS", &"ZM_TOMB_BOW", &staff_water_fullycrafted, 1 );
    zm_craftables::add_zombie_craftable_vox_category( "elemental_staff_water", "ice_staff" );
    zm_craftables::add_zombie_craftable( "gramophone", &"ZM_TOMB_CRAFT_GRAMOPHONE", &"ZM_TOMB_CRAFT_GRAMOPHONE", &"ZM_TOMB_BOUGHT_GRAMOPHONE", undefined, 0 );
    zm_craftables::add_zombie_craftable_vox_category( "gramophone", "gramophone" );
    level.zombie_craftable_persistent_weapon = &tomb_check_crafted_weapon_persistence;
    level.custom_craftable_validation = &tomb_custom_craftable_validation;
    level.zombie_custom_equipment_setup = &setup_quadrotor_purchase;
    level thread hide_staff_model();
    level.quadrotor_status = spawnstruct();
    level.quadrotor_status.crafted = 0;
    level.quadrotor_status.picked_up = 0;
    level.num_staffpieces_picked_up = [];
    level.var_b79a2c38 = [];
    level.n_staffs_crafted = 0;
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xc1681eef, Offset: 0x1960
// Size: 0x392
function add_craftable_cheat( craftable )
{
    /#
        if ( !isdefined( level.cheat_craftables ) )
        {
            level.cheat_craftables = [];
        }
        
        foreach ( s_piece in craftable.a_piecestubs )
        {
            id_string = undefined;
            client_field_val = undefined;
            
            if ( isdefined( s_piece.client_field_id ) )
            {
                id_string = s_piece.client_field_id;
                client_field_val = id_string;
            }
            else if ( isdefined( s_piece.client_field_state ) )
            {
                id_string = "<dev string:x28>";
                client_field_val = s_piece.client_field_state;
            }
            else
            {
                continue;
            }
            
            tokens = strtok( id_string, "<dev string:x2c>" );
            display_string = "<dev string:x2e>";
            
            foreach ( token in tokens )
            {
                if ( token != "<dev string:x2e>" && token != "<dev string:x34>" && token != "<dev string:x3a>" )
                {
                    display_string = display_string + "<dev string:x2c>" + token;
                }
            }
            
            level.cheat_craftables[ "<dev string:x3d>" + client_field_val ] = s_piece;
            adddebugcommand( "<dev string:x3e>" + craftable.name + "<dev string:x5e>" + display_string + "<dev string:x60>" + client_field_val + "<dev string:x73>" );
            s_piece.waste = "<dev string:x76>";
        }
        
        wait 0.05;
        level flag::wait_till( "<dev string:x7c>" );
        wait 0.05;
        
        foreach ( s_piece in craftable.a_piecestubs )
        {
            s_piece craftable_waittill_spawned();
            s_piece.piecespawn.model thread zm_tomb_utility::puzzle_debug_position( "<dev string:x95>", ( 0, 255, 0 ), undefined, "<dev string:x97>" );
        }
    #/
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x810fa213, Offset: 0x1d00
// Size: 0x2c6
function autocraft_staffs()
{
    setdvar( "autocraft_staffs", "off" );
    
    /#
        adddebugcommand( "<dev string:xb0>" );
    #/
    
    while ( getdvarstring( "autocraft_staffs" ) != "on" )
    {
        util::wait_network_frame();
    }
    
    level flag::wait_till( "start_zombie_round_logic" );
    keys = getarraykeys( level.cheat_craftables );
    a_players = getplayers();
    
    foreach ( key in keys )
    {
        if ( issubstr( key, "staff" ) || issubstr( key, "record" ) )
        {
            s_piece = level.cheat_craftables[ key ];
            
            if ( isdefined( s_piece.piecespawn ) )
            {
                a_players[ 0 ] zm_craftables::player_take_piece( s_piece.piecespawn );
            }
        }
    }
    
    for ( i = 1; i <= 4 ; i++ )
    {
        level notify( #"player_teleported", a_players[ 0 ], i );
        util::wait_network_frame();
        piece_spawn = level.cheat_craftables[ "" + i ].piecespawn;
        
        if ( isdefined( piece_spawn ) )
        {
            if ( isdefined( a_players[ i - 1 ] ) )
            {
                a_players[ i - 1 ] zm_craftables::player_take_piece( piece_spawn );
                util::wait_network_frame();
            }
        }
        
        util::wait_network_frame();
    }
}

/#

    // Namespace zm_tomb_craftables
    // Params 0
    // Checksum 0x2dd7e159, Offset: 0x1fd0
    // Size: 0x110, Type: dev
    function run_craftables_devgui()
    {
        level thread autocraft_staffs();
        setdvar( "<dev string:xfa>", "<dev string:x3d>" );
        
        while ( true )
        {
            craftable_id = getdvarstring( "<dev string:xfa>" );
            
            if ( craftable_id != "<dev string:x3d>" )
            {
                piece_spawn = level.cheat_craftables[ craftable_id ].piecespawn;
                
                if ( isdefined( piece_spawn ) )
                {
                    players = getplayers();
                    players[ 0 ] zm_craftables::player_take_piece( piece_spawn );
                }
                
                setdvar( "<dev string:xfa>", "<dev string:x3d>" );
            }
            
            wait 0.05;
        }
    }

#/

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0xc5597f56, Offset: 0x20e8
// Size: 0x13ac
function include_craftables()
{
    craftable_name = "equip_dieseldrone";
    quadrotor_body = zm_craftables::generate_zombie_craftable_piece( craftable_name, "body", 32, 64, 0, undefined, &onpickup_common, &ondrop_common, undefined, undefined, undefined, undefined, "piece_quadrotor_zm_body", 1, "build_dd", 0 );
    quadrotor_brain = zm_craftables::generate_zombie_craftable_piece( craftable_name, "brain", 32, 64, 0, undefined, &onpickup_common, &ondrop_common, undefined, undefined, undefined, undefined, "piece_quadrotor_zm_brain", 1, "build_dd_brain", 0 );
    quadrotor_engine = zm_craftables::generate_zombie_craftable_piece( craftable_name, "engine", 32, 64, 0, undefined, &onpickup_common, &ondrop_common, undefined, undefined, undefined, undefined, "piece_quadrotor_zm_engine", 1, "build_dd", 0 );
    quadrotor_body thread watch_part_pickup( "piece_quadrotor_zm_body", 1, "zmInventory.show_maxis_drone_parts_widget" );
    quadrotor_brain thread watch_part_pickup( "piece_quadrotor_zm_brain", 1, "zmInventory.show_maxis_drone_parts_widget" );
    quadrotor_engine thread watch_part_pickup( "piece_quadrotor_zm_engine", 1, "zmInventory.show_maxis_drone_parts_widget" );
    quadrotor = spawnstruct();
    quadrotor.name = craftable_name;
    quadrotor zm_craftables::add_craftable_piece( quadrotor_body );
    quadrotor zm_craftables::add_craftable_piece( quadrotor_brain );
    quadrotor zm_craftables::add_craftable_piece( quadrotor_engine );
    quadrotor.triggerthink = &quadrotorcraftable;
    zm_craftables::include_zombie_craftable( quadrotor );
    level thread add_craftable_cheat( quadrotor );
    craftable_name = "gramophone";
    vinyl_pickup_player = vinyl_add_pickup( craftable_name, "vinyl_player", "p7_spl_gramophone", "piece_record_zm_player", undefined, "gramophone", "zmInventory.show_musical_parts_widget" );
    vinyl_pickup_master = vinyl_add_pickup( craftable_name, "vinyl_master", "p7_zm_ori_record_vinyl_master", "piece_record_zm_vinyl_master", undefined, "record", "zmInventory.show_musical_parts_widget" );
    vinyl_pickup_air = vinyl_add_pickup( craftable_name, "vinyl_air", "p7_zm_ori_record_vinyl_wind", "piece_record_zm_vinyl_air", "air_staff.quest_state", "record", "zmInventory.air_staff.visible" );
    vinyl_pickup_ice = vinyl_add_pickup( craftable_name, "vinyl_ice", "p7_zm_ori_record_vinyl_ice", "piece_record_zm_vinyl_water", "water_staff.quest_state", "record", "zmInventory.water_staff.visible" );
    vinyl_pickup_fire = vinyl_add_pickup( craftable_name, "vinyl_fire", "p7_zm_ori_record_vinyl_fire", "piece_record_zm_vinyl_fire", "fire_staff.quest_state", "record", "zmInventory.fire_staff.visible" );
    vinyl_pickup_elec = vinyl_add_pickup( craftable_name, "vinyl_elec", "p7_zm_ori_record_vinyl_lightning", "piece_record_zm_vinyl_lightning", "lightning_staff.quest_state", "record", "zmInventory.lightning_staff.visible" );
    vinyl_pickup_player.sam_line = "gramophone_found";
    vinyl_pickup_master.sam_line = "master_found";
    vinyl_pickup_air.sam_line = "first_record_found";
    vinyl_pickup_ice.sam_line = "first_record_found";
    vinyl_pickup_fire.sam_line = "first_record_found";
    vinyl_pickup_elec.sam_line = "first_record_found";
    level thread zm_tomb_vo::watch_one_shot_samantha_line( "vox_sam_1st_record_found_0", "first_record_found" );
    level thread zm_tomb_vo::watch_one_shot_samantha_line( "vox_sam_gramophone_found_0", "gramophone_found" );
    level thread zm_tomb_vo::watch_one_shot_samantha_line( "vox_sam_master_found_0", "master_found" );
    gramophone = spawnstruct();
    gramophone.name = craftable_name;
    gramophone zm_craftables::add_craftable_piece( vinyl_pickup_player );
    gramophone zm_craftables::add_craftable_piece( vinyl_pickup_master );
    gramophone zm_craftables::add_craftable_piece( vinyl_pickup_air );
    gramophone zm_craftables::add_craftable_piece( vinyl_pickup_ice );
    gramophone zm_craftables::add_craftable_piece( vinyl_pickup_fire );
    gramophone zm_craftables::add_craftable_piece( vinyl_pickup_elec );
    gramophone.triggerthink = &gramophonecraftable;
    zm_craftables::include_zombie_craftable( gramophone );
    level thread add_craftable_cheat( gramophone );
    craftable_name = "elemental_staff_air";
    staff_air_gem = zm_craftables::generate_zombie_craftable_piece( craftable_name, "gem", 48, 64, 0, undefined, &onpickup_aircrystal, &ondrop_aircrystal, undefined, undefined, undefined, undefined, 2, 0, "crystal", 1 );
    staff_air_upper_staff = zm_craftables::generate_zombie_craftable_piece( craftable_name, "upper_staff", 32, 64, 0, undefined, &function_f35af043, &ondrop_common, undefined, undefined, undefined, undefined, "air_staff.piece_zm_ustaff", 1, "staff_part" );
    staff_air_middle_staff = zm_craftables::generate_zombie_craftable_piece( craftable_name, "middle_staff", 32, 64, 0, undefined, &function_f35af043, &ondrop_common, undefined, undefined, undefined, undefined, "air_staff.piece_zm_mstaff", 1, "staff_part" );
    staff_air_lower_staff = zm_craftables::generate_zombie_craftable_piece( craftable_name, "lower_staff", 32, 64, 0, undefined, &function_f35af043, &ondrop_common, undefined, undefined, undefined, undefined, "air_staff.piece_zm_lstaff", 1, "staff_part" );
    staff = spawnstruct();
    staff.name = craftable_name;
    staff zm_craftables::add_craftable_piece( staff_air_gem );
    staff zm_craftables::add_craftable_piece( staff_air_upper_staff );
    staff zm_craftables::add_craftable_piece( staff_air_middle_staff );
    staff zm_craftables::add_craftable_piece( staff_air_lower_staff );
    staff.triggerthink = &staffcraftable_air;
    staff.custom_craftablestub_update_prompt = &tomb_staff_update_prompt;
    zm_craftables::include_zombie_craftable( staff );
    level thread add_craftable_cheat( staff );
    count_staff_piece_pickup( array( staff_air_upper_staff, staff_air_middle_staff, staff_air_lower_staff ) );
    craftable_name = "elemental_staff_fire";
    staff_fire_gem = zm_craftables::generate_zombie_craftable_piece( craftable_name, "gem", 48, 64, 0, undefined, &onpickup_firecrystal, &ondrop_firecrystal, undefined, undefined, undefined, undefined, 1, 0, "crystal", 1 );
    staff_fire_upper_staff = zm_craftables::generate_zombie_craftable_piece( craftable_name, "upper_staff", 32, 64, 0, undefined, &function_4d932a71, &ondrop_common, undefined, undefined, undefined, undefined, "fire_staff.piece_zm_ustaff", 1, "staff_part" );
    staff_fire_middle_staff = zm_craftables::generate_zombie_craftable_piece( craftable_name, "middle_staff", 32, 64, 0, undefined, &function_4d932a71, &ondrop_common, undefined, undefined, undefined, undefined, "fire_staff.piece_zm_mstaff", 1, "staff_part" );
    staff_fire_lower_staff = zm_craftables::generate_zombie_craftable_piece( craftable_name, "lower_staff", 64, 128, 0, undefined, &function_4d932a71, &ondrop_common, undefined, undefined, undefined, undefined, "fire_staff.piece_zm_lstaff", 1, "staff_part" );
    level thread zm_tomb_main_quest::staff_mechz_drop_pieces( staff_fire_lower_staff );
    level thread zm_tomb_main_quest::staff_biplane_drop_pieces( array( staff_fire_middle_staff ) );
    level thread zm_tomb_main_quest::staff_unlock_with_zone_capture( staff_fire_upper_staff );
    staff = spawnstruct();
    staff.name = craftable_name;
    staff zm_craftables::add_craftable_piece( staff_fire_gem );
    staff zm_craftables::add_craftable_piece( staff_fire_upper_staff );
    staff zm_craftables::add_craftable_piece( staff_fire_middle_staff );
    staff zm_craftables::add_craftable_piece( staff_fire_lower_staff );
    staff.triggerthink = &staffcraftable_fire;
    staff.custom_craftablestub_update_prompt = &tomb_staff_update_prompt;
    zm_craftables::include_zombie_craftable( staff );
    level thread add_craftable_cheat( staff );
    count_staff_piece_pickup( array( staff_fire_upper_staff, staff_fire_middle_staff, staff_fire_lower_staff ) );
    craftable_name = "elemental_staff_lightning";
    staff_lightning_gem = zm_craftables::generate_zombie_craftable_piece( craftable_name, "gem", 48, 64, 0, undefined, &onpickup_lightningcrystal, &ondrop_lightningcrystal, undefined, undefined, undefined, undefined, 3, 0, "crystal", 1 );
    staff_lightning_upper_staff = zm_craftables::generate_zombie_craftable_piece( craftable_name, "upper_staff", 32, 64, 0, undefined, &function_47c3d969, &ondrop_common, undefined, undefined, undefined, undefined, "lightning_staff.piece_zm_ustaff", 1, "staff_part" );
    staff_lightning_middle_staff = zm_craftables::generate_zombie_craftable_piece( craftable_name, "middle_staff", 32, 64, 0, undefined, &function_47c3d969, &ondrop_common, undefined, undefined, undefined, undefined, "lightning_staff.piece_zm_mstaff", 1, "staff_part" );
    staff_lightning_lower_staff = zm_craftables::generate_zombie_craftable_piece( craftable_name, "lower_staff", 32, 64, 0, undefined, &function_47c3d969, &ondrop_common, undefined, undefined, undefined, undefined, "lightning_staff.piece_zm_lstaff", 1, "staff_part" );
    staff = spawnstruct();
    staff.name = craftable_name;
    staff zm_craftables::add_craftable_piece( staff_lightning_gem );
    staff zm_craftables::add_craftable_piece( staff_lightning_upper_staff );
    staff zm_craftables::add_craftable_piece( staff_lightning_middle_staff );
    staff zm_craftables::add_craftable_piece( staff_lightning_lower_staff );
    staff.triggerthink = &staffcraftable_lightning;
    staff.custom_craftablestub_update_prompt = &tomb_staff_update_prompt;
    zm_craftables::include_zombie_craftable( staff );
    level thread add_craftable_cheat( staff );
    count_staff_piece_pickup( array( staff_lightning_upper_staff, staff_lightning_middle_staff, staff_lightning_lower_staff ) );
    craftable_name = "elemental_staff_water";
    staff_water_gem = zm_craftables::generate_zombie_craftable_piece( craftable_name, "gem", 48, 64, 0, undefined, &onpickup_watercrystal, &ondrop_watercrystal, undefined, undefined, undefined, undefined, 4, 0, "crystal", 1 );
    staff_water_upper_staff = zm_craftables::generate_zombie_craftable_piece( craftable_name, "upper_staff", 32, 64, 0, undefined, &function_6c091d36, &ondrop_common, undefined, undefined, undefined, undefined, "water_staff.piece_zm_ustaff", 1, "staff_part" );
    staff_water_middle_staff = zm_craftables::generate_zombie_craftable_piece( craftable_name, "middle_staff", 32, 64, 0, undefined, &function_6c091d36, &ondrop_common, undefined, undefined, undefined, undefined, "water_staff.piece_zm_mstaff", 1, "staff_part" );
    staff_water_lower_staff = zm_craftables::generate_zombie_craftable_piece( craftable_name, "lower_staff", 32, 64, 0, undefined, &function_6c091d36, &ondrop_common, undefined, undefined, undefined, undefined, "water_staff.piece_zm_lstaff", 1, "staff_part" );
    a_ice_staff_parts = array( staff_water_lower_staff, staff_water_middle_staff, staff_water_upper_staff );
    level thread zm_tomb_main_quest::staff_ice_dig_pieces( a_ice_staff_parts );
    staff = spawnstruct();
    staff.name = craftable_name;
    staff zm_craftables::add_craftable_piece( staff_water_gem );
    staff zm_craftables::add_craftable_piece( staff_water_upper_staff );
    staff zm_craftables::add_craftable_piece( staff_water_middle_staff );
    staff zm_craftables::add_craftable_piece( staff_water_lower_staff );
    staff.triggerthink = &staffcraftable_water;
    staff.custom_craftablestub_update_prompt = &tomb_staff_update_prompt;
    zm_craftables::include_zombie_craftable( staff );
    level thread add_craftable_cheat( staff );
    count_staff_piece_pickup( array( staff_water_upper_staff, staff_water_middle_staff, staff_water_lower_staff ) );
    staff_fire_gem thread watch_part_pickup( "fire_staff.quest_state", 2 );
    staff_air_gem thread watch_part_pickup( "air_staff.quest_state", 2 );
    staff_lightning_gem thread watch_part_pickup( "lightning_staff.quest_state", 2 );
    staff_water_gem thread watch_part_pickup( "water_staff.quest_state", 2 );
    staff_fire_gem thread zm_tomb_main_quest::staff_crystal_wait_for_teleport( 1 );
    staff_air_gem thread zm_tomb_main_quest::staff_crystal_wait_for_teleport( 2 );
    staff_lightning_gem thread zm_tomb_main_quest::staff_crystal_wait_for_teleport( 3 );
    staff_water_gem thread zm_tomb_main_quest::staff_crystal_wait_for_teleport( 4 );
    level thread craftable_add_glow_fx();
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x8a9261b9, Offset: 0x34a0
// Size: 0x964
function register_clientfields()
{
    bits = 1;
    clientfield::register( "world", "piece_quadrotor_zm_body", 21000, bits, "int" );
    clientfield::register( "world", "piece_quadrotor_zm_brain", 21000, bits, "int" );
    clientfield::register( "world", "piece_quadrotor_zm_engine", 21000, bits, "int" );
    clientfield::register( "world", "air_staff.piece_zm_gem", 21000, bits, "int" );
    clientfield::register( "world", "air_staff.piece_zm_ustaff", 21000, bits, "int" );
    clientfield::register( "world", "air_staff.piece_zm_mstaff", 21000, bits, "int" );
    clientfield::register( "world", "air_staff.piece_zm_lstaff", 21000, bits, "int" );
    clientfield::register( "clientuimodel", "zmInventory.air_staff.visible", 21000, bits, "int" );
    clientfield::register( "world", "fire_staff.piece_zm_gem", 21000, bits, "int" );
    clientfield::register( "world", "fire_staff.piece_zm_ustaff", 21000, bits, "int" );
    clientfield::register( "world", "fire_staff.piece_zm_mstaff", 21000, bits, "int" );
    clientfield::register( "world", "fire_staff.piece_zm_lstaff", 21000, bits, "int" );
    clientfield::register( "clientuimodel", "zmInventory.fire_staff.visible", 21000, bits, "int" );
    clientfield::register( "world", "lightning_staff.piece_zm_gem", 21000, bits, "int" );
    clientfield::register( "world", "lightning_staff.piece_zm_ustaff", 21000, bits, "int" );
    clientfield::register( "world", "lightning_staff.piece_zm_mstaff", 21000, bits, "int" );
    clientfield::register( "world", "lightning_staff.piece_zm_lstaff", 21000, bits, "int" );
    clientfield::register( "clientuimodel", "zmInventory.lightning_staff.visible", 21000, bits, "int" );
    clientfield::register( "world", "water_staff.piece_zm_gem", 21000, bits, "int" );
    clientfield::register( "world", "water_staff.piece_zm_ustaff", 21000, bits, "int" );
    clientfield::register( "world", "water_staff.piece_zm_mstaff", 21000, bits, "int" );
    clientfield::register( "world", "water_staff.piece_zm_lstaff", 21000, bits, "int" );
    clientfield::register( "clientuimodel", "zmInventory.water_staff.visible", 21000, bits, "int" );
    clientfield::register( "world", "piece_record_zm_player", 21000, bits, "int" );
    clientfield::register( "world", "piece_record_zm_vinyl_master", 21000, bits, "int" );
    clientfield::register( "world", "piece_record_zm_vinyl_air", 21000, bits, "int" );
    clientfield::register( "world", "piece_record_zm_vinyl_water", 21000, bits, "int" );
    clientfield::register( "world", "piece_record_zm_vinyl_fire", 21000, bits, "int" );
    clientfield::register( "world", "piece_record_zm_vinyl_lightning", 21000, bits, "int" );
    clientfield::register( "scriptmover", "element_glow_fx", 21000, 4, "int" );
    clientfield::register( "scriptmover", "bryce_cake", 21000, 2, "int" );
    clientfield::register( "scriptmover", "switch_spark", 21000, 1, "int" );
    clientfield::register( "scriptmover", "plane_fx", 21000, 1, "int" );
    bits = getminbitcountfornum( 5 );
    clientfield::register( "world", "air_staff.holder", 21000, bits, "int" );
    clientfield::register( "world", "fire_staff.holder", 21000, bits, "int" );
    clientfield::register( "world", "lightning_staff.holder", 21000, bits, "int" );
    clientfield::register( "world", "water_staff.holder", 21000, bits, "int" );
    bits = getminbitcountfornum( 5 );
    clientfield::register( "world", "fire_staff.quest_state", 21000, bits, "int" );
    clientfield::register( "world", "air_staff.quest_state", 21000, bits, "int" );
    clientfield::register( "world", "lightning_staff.quest_state", 21000, bits, "int" );
    clientfield::register( "world", "water_staff.quest_state", 21000, bits, "int" );
    clientfield::register( "toplayer", "sndMudSlow", 21000, 1, "int" );
    clientfield::register( "clientuimodel", "zmInventory.show_maxis_drone_parts_widget", 21000, 1, "int" );
    clientfield::register( "clientuimodel", "zmInventory.current_gem", 21000, getminbitcountfornum( 5 ), "int" );
    clientfield::register( "clientuimodel", "zmInventory.show_musical_parts_widget", 21000, 1, "int" );
    clientfield::register( "clientuimodel", "hudItems.showDpadRight_Drone", 21000, 1, "int" );
    clientfield::register( "clientuimodel", "hudItems.showDpadLeft_Staff", 21000, 1, "int" );
    clientfield::register( "clientuimodel", "hudItems.dpadLeftAmmo", 21000, 2, "int" );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x8f68ef57, Offset: 0x3e10
// Size: 0x300
function craftable_add_glow_fx()
{
    level flagsys::wait_till( "load_main_complete" );
    level flag::wait_till( "start_zombie_round_logic" );
    
    foreach ( s_craftable in level.zombie_include_craftables )
    {
        if ( !issubstr( s_craftable.name, "elemental_staff" ) )
        {
            continue;
        }
        
        n_elem = 0;
        
        if ( issubstr( s_craftable.name, "fire" ) )
        {
            n_elem = 1;
        }
        else if ( issubstr( s_craftable.name, "air" ) )
        {
            n_elem = 2;
        }
        else if ( issubstr( s_craftable.name, "lightning" ) )
        {
            n_elem = 3;
        }
        else if ( issubstr( s_craftable.name, "water" ) )
        {
            n_elem = 4;
        }
        else
        {
            /#
                iprintlnbold( "<dev string:x109>" + s_craftable.name );
            #/
            
            return;
        }
        
        foreach ( s_piece in s_craftable.a_piecestubs )
        {
            if ( s_piece.piecename == "gem" )
            {
                continue;
            }
            
            s_piece craftable_waittill_spawned();
            do_glow_now = n_elem == 3 || n_elem == 2;
            s_piece.piecespawn.model thread craftable_model_attach_glow( n_elem, do_glow_now );
        }
    }
}

// Namespace zm_tomb_craftables
// Params 2
// Checksum 0x178dc82c, Offset: 0x4118
// Size: 0x54
function craftable_model_attach_glow( n_elem, do_glow_now )
{
    self endon( #"death" );
    
    if ( !do_glow_now )
    {
        self waittill( #"staff_piece_glow" );
    }
    
    self clientfield::set( "element_glow_fx", n_elem );
}

// Namespace zm_tomb_craftables
// Params 3
// Checksum 0x8bded710, Offset: 0x4178
// Size: 0x15e
function tomb_staff_update_prompt( player, b_set_hint_string_now, trigger )
{
    str_flag = self.weaponname.name + "_picked_up";
    
    if ( level flag::get( str_flag ) )
    {
        return 0;
    }
    
    if ( isdefined( self.crafted ) && self.crafted )
    {
        return 1;
    }
    
    self.hint_string = &"ZOMBIE_BUILD_PIECE_MORE";
    
    if ( isdefined( player ) )
    {
        if ( !isdefined( player.current_craftable_pieces ) || player.current_craftable_pieces.size < 1 )
        {
            return 0;
        }
        
        if ( !self.craftablespawn zm_craftables::craftable_has_piece( player.current_craftable_pieces[ 0 ] ) )
        {
            self.hint_string = &"ZOMBIE_BUILD_PIECE_WRONG";
            return 0;
        }
    }
    
    if ( level.staff_part_count[ self.craftablespawn.craftable_name ] == 0 )
    {
        self.hint_string = level.zombie_craftablestubs[ self.equipname ].str_to_craft;
        return 1;
    }
    
    return 0;
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0xe9b1b6a3, Offset: 0x42e0
// Size: 0x3c
function init_craftable_choke()
{
    level.craftables_spawned_this_frame = 0;
    
    while ( true )
    {
        util::wait_network_frame();
        level.craftables_spawned_this_frame = 0;
    }
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0xb2c122b, Offset: 0x4328
// Size: 0x58
function craftable_wait_your_turn()
{
    if ( !isdefined( level.craftables_spawned_this_frame ) )
    {
        level thread init_craftable_choke();
    }
    
    while ( level.craftables_spawned_this_frame >= 2 )
    {
        util::wait_network_frame();
    }
    
    level.craftables_spawned_this_frame++;
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x48a6173f, Offset: 0x4388
// Size: 0x4c
function quadrotorcraftable()
{
    craftable_wait_your_turn();
    zm_craftables::craftable_trigger_think( "quadrotor_zm_craftable_trigger", "equip_dieseldrone", "equip_dieseldrone", &"ZM_TOMB_TQ", 1, 1 );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x1c31d231, Offset: 0x43e0
// Size: 0x4c
function staffcraftable_air()
{
    craftable_wait_your_turn();
    zm_craftables::craftable_trigger_think( "staff_air_craftable_trigger", "elemental_staff_air", "staff_air", &"ZM_TOMB_PUAS", 1, 1 );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x1d8610bd, Offset: 0x4438
// Size: 0x4c
function staffcraftable_fire()
{
    craftable_wait_your_turn();
    zm_craftables::craftable_trigger_think( "staff_fire_craftable_trigger", "elemental_staff_fire", "staff_fire", &"ZM_TOMB_PUFS", 1, 1 );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0xdcc289de, Offset: 0x4490
// Size: 0x4c
function staffcraftable_lightning()
{
    craftable_wait_your_turn();
    zm_craftables::craftable_trigger_think( "staff_lightning_craftable_trigger", "elemental_staff_lightning", "staff_lightning", &"ZM_TOMB_PULS", 1, 1 );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x247f7b66, Offset: 0x44e8
// Size: 0x4c
function staffcraftable_water()
{
    craftable_wait_your_turn();
    zm_craftables::craftable_trigger_think( "staff_water_craftable_trigger", "elemental_staff_water", "staff_water", &"ZM_TOMB_PUIS", 1, 1 );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0xd07735ef, Offset: 0x4540
// Size: 0x4c
function gramophonecraftable()
{
    craftable_wait_your_turn();
    zm_craftables::craftable_trigger_think( "gramophone_craftable_trigger", "gramophone", "gramophone", &"ZOMBIE_GRAB_GRAMOPHONE", 1, 1 );
}

// Namespace zm_tomb_craftables
// Params 3
// Checksum 0xc1256e2b, Offset: 0x4598
// Size: 0x9c, Type: bool
function tankcraftableupdateprompt( player, sethintstringnow, buildabletrigger )
{
    if ( level.vh_tank getspeedmph() > 0 )
    {
        if ( isdefined( self ) )
        {
            self.hint_string = "";
            
            if ( isdefined( sethintstringnow ) && sethintstringnow && isdefined( buildabletrigger ) )
            {
                buildabletrigger sethintstring( self.hint_string );
            }
        }
        
        return false;
    }
    
    return true;
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x7b71d7c0, Offset: 0x4640
// Size: 0x16
function ondrop_common( player )
{
    self.piece_owner = undefined;
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x2233d270, Offset: 0x4660
// Size: 0x110
function ondrop_crystal( player )
{
    ondrop_common( player );
    s_piece = self.piecestub;
    s_piece.piecespawn.canmove = 1;
    zm_unitrigger::reregister_unitrigger_as_dynamic( s_piece.piecespawn.unitrigger );
    s_original_pos = struct::get( self.craftablename + "_" + self.piecename );
    s_piece.piecespawn.model.origin = s_original_pos.origin;
    s_piece.piecespawn.model.angles = s_original_pos.angles;
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xd730f0f6, Offset: 0x4778
// Size: 0xa4
function ondrop_firecrystal( player )
{
    level clientfield::set( "fire_staff.piece_zm_gem", 0 );
    level clientfield::set( "fire_staff.quest_state", 1 );
    level clientfield::set( "piece_record_zm_vinyl_fire", 0 );
    player clear_player_crystal( 1, "fire_staff.holder" );
    ondrop_crystal( player );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xbf32898c, Offset: 0x4828
// Size: 0xa4
function ondrop_aircrystal( player )
{
    level clientfield::set( "air_staff.piece_zm_gem", 0 );
    level clientfield::set( "air_staff.quest_state", 1 );
    level clientfield::set( "piece_record_zm_vinyl_air", 0 );
    player clear_player_crystal( 2, "air_staff.holder" );
    ondrop_crystal( player );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x21ee29ed, Offset: 0x48d8
// Size: 0xa4
function ondrop_lightningcrystal( player )
{
    level clientfield::set( "lightning_staff.piece_zm_gem", 0 );
    level clientfield::set( "lightning_staff.quest_state", 1 );
    level clientfield::set( "piece_record_zm_vinyl_lightning", 0 );
    player clear_player_crystal( 3, "lightning_staff.holder" );
    ondrop_crystal( player );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xca92f55, Offset: 0x4988
// Size: 0xa4
function ondrop_watercrystal( player )
{
    level clientfield::set( "water_staff.piece_zm_gem", 0 );
    level clientfield::set( "water_staff.quest_state", 1 );
    level clientfield::set( "piece_record_zm_vinyl_water", 0 );
    player clear_player_crystal( 4, "water_staff.holder" );
    ondrop_crystal( player );
}

// Namespace zm_tomb_craftables
// Params 2
// Checksum 0x9976fcd6, Offset: 0x4a38
// Size: 0x68
function clear_player_crystal( n_element, var_94f38c49 )
{
    if ( n_element == self.crystal_id )
    {
        level clientfield::set( var_94f38c49, 0 );
        self clientfield::set_player_uimodel( "zmInventory.current_gem", 0 );
        self.crystal_id = 0;
    }
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x7d9d49cf, Offset: 0x4aa8
// Size: 0xea
function piece_pickup_conversation( player )
{
    wait 1;
    
    while ( isdefined( player.isspeaking ) && player.isspeaking )
    {
        util::wait_network_frame();
    }
    
    if ( isdefined( self.piecestub.vo_line_notify ) )
    {
        level notify( #"quest_progressed", player, 0 );
        level notify( self.piecestub.vo_line_notify, player );
        return;
    }
    
    if ( isdefined( self.piecestub.sam_line ) )
    {
        level notify( #"quest_progressed", player, 0 );
        level notify( self.piecestub.sam_line, player );
        return;
    }
    
    level notify( #"quest_progressed", player, 1 );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x6eaf8823, Offset: 0x4ba0
// Size: 0xd6
function onpickup_common( player )
{
    player playsound( "zmb_craftable_pickup" );
    self.piece_owner = player;
    self thread piece_pickup_conversation( player );
    
    /#
        foreach ( spawn in self.spawns )
        {
            spawn notify( #"stop_debug_position" );
        }
    #/
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x774b5f58, Offset: 0x4c80
// Size: 0xe4
function staff_pickup_vo()
{
    if ( !level flag::get( "samantha_intro_done" ) )
    {
        return;
    }
    
    if ( !( isdefined( level.sam_staff_line_played ) && level.sam_staff_line_played ) )
    {
        level.sam_staff_line_played = 1;
        wait 1;
        zm_tomb_vo::set_players_dontspeak( 1 );
        zm_tomb_vo::samanthasay( "vox_sam_1st_staff_found_1_0", self, 1 );
        zm_tomb_vo::samanthasay( "vox_sam_1st_staff_found_2_0", self );
        zm_tomb_vo::set_players_dontspeak( 0 );
        self zm_audio::create_and_play_dialog( "staff", "first_piece" );
    }
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x663eb4ed, Offset: 0x4d70
// Size: 0x2c
function function_4d932a71( player )
{
    onpickup_staffpiece( player, "fire" );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xd59fc7cb, Offset: 0x4da8
// Size: 0x2c
function function_f35af043( player )
{
    onpickup_staffpiece( player, "air" );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x74964fee, Offset: 0x4de0
// Size: 0x2c
function function_47c3d969( player )
{
    onpickup_staffpiece( player, "lightning" );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xc8e9a3f6, Offset: 0x4e18
// Size: 0x2c
function function_6c091d36( player )
{
    onpickup_staffpiece( player, "water" );
}

// Namespace zm_tomb_craftables
// Params 2
// Checksum 0xebf24f6d, Offset: 0x4e50
// Size: 0x154
function onpickup_staffpiece( player, elementname )
{
    onpickup_common( player );
    
    if ( !isdefined( level.num_staffpieces_picked_up[ self.craftablename ] ) )
    {
        level.num_staffpieces_picked_up[ self.craftablename ] = 0;
    }
    
    level.num_staffpieces_picked_up[ self.craftablename ]++;
    
    if ( level.num_staffpieces_picked_up[ self.craftablename ] == 3 )
    {
        level notify( self.craftablename + "_all_pieces_found" );
    }
    
    foreach ( e_player in level.players )
    {
        e_player thread zm_craftables::player_show_craftable_parts_ui( undefined, "zmInventory." + elementname + "_staff.visible", 0 );
    }
    
    player thread staff_pickup_vo();
}

// Namespace zm_tomb_craftables
// Params 3
// Checksum 0xede50013, Offset: 0x4fb0
// Size: 0x1cc
function onpickup_crystal( player, elementname, elementenum )
{
    onpickup_common( player );
    level clientfield::set( elementname + "_staff.piece_zm_gem", 1 );
    level clientfield::set( elementname + "_staff.holder", player.characterindex + 1 );
    
    if ( level flag::get( "any_crystal_picked_up" ) )
    {
        self.piecestub.vox_id = undefined;
    }
    
    foreach ( e_player in level.players )
    {
        e_player thread zm_craftables::player_show_craftable_parts_ui( undefined, "zmInventory." + elementname + "_staff.visible", 0 );
    }
    
    player thread zm_craftables::player_show_craftable_parts_ui( undefined, "zmInventory.show_musical_parts_widget", 0 );
    level flag::set( "any_crystal_picked_up" );
    player clientfield::set_player_uimodel( "zmInventory.current_gem", player.crystal_id );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xe88811aa, Offset: 0x5188
// Size: 0x64
function onpickup_firecrystal( player )
{
    level clientfield::set( "fire_staff.quest_state", 2 );
    player.crystal_id = 1;
    onpickup_crystal( player, "fire", 1 );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x26bbc2ed, Offset: 0x51f8
// Size: 0x64
function onpickup_aircrystal( player )
{
    level clientfield::set( "air_staff.quest_state", 2 );
    player.crystal_id = 2;
    onpickup_crystal( player, "air", 2 );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x641e52a6, Offset: 0x5268
// Size: 0x64
function onpickup_lightningcrystal( player )
{
    level clientfield::set( "lightning_staff.quest_state", 2 );
    player.crystal_id = 3;
    onpickup_crystal( player, "lightning", 3 );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xd36e5ca6, Offset: 0x52d8
// Size: 0x64
function onpickup_watercrystal( player )
{
    level clientfield::set( "water_staff.quest_state", 2 );
    player.crystal_id = 4;
    onpickup_crystal( player, "water", 4 );
}

// Namespace zm_tomb_craftables
// Params 7
// Checksum 0xf8d180c8, Offset: 0x5348
// Size: 0xe0
function vinyl_add_pickup( str_craftable_name, str_piece_name, str_model_name, str_bit_clientfield, str_quest_clientfield, str_vox_id, var_e46422e8 )
{
    b_one_time_vo = 1;
    craftable = zm_craftables::generate_zombie_craftable_piece( str_craftable_name, str_piece_name, 32, 64, 0, undefined, &onpickup_common, &ondrop_common, undefined, undefined, undefined, undefined, str_bit_clientfield, 1, str_vox_id, b_one_time_vo, undefined, 0 );
    craftable thread watch_part_pickup( str_quest_clientfield, 1, var_e46422e8 );
    return craftable;
}

// Namespace zm_tomb_craftables
// Params 3
// Checksum 0x81978821, Offset: 0x5430
// Size: 0x13a
function watch_part_pickup( str_quest_clientfield, n_clientfield_val, var_e46422e8 )
{
    self craftable_waittill_spawned();
    self.piecespawn waittill( #"pickup" );
    level notify( self.craftablename + "_" + self.piecename + "_picked_up" );
    
    if ( isdefined( str_quest_clientfield ) && isdefined( n_clientfield_val ) )
    {
        level clientfield::set( str_quest_clientfield, n_clientfield_val );
    }
    
    if ( isdefined( var_e46422e8 ) )
    {
        foreach ( e_player in level.players )
        {
            e_player thread zm_craftables::player_show_craftable_parts_ui( undefined, var_e46422e8, 0 );
        }
    }
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x26b5ff8f, Offset: 0x5578
// Size: 0x10a
function count_staff_piece_pickup( a_staff_pieces )
{
    if ( !isdefined( level.staff_part_count ) )
    {
        level.staff_part_count = [];
    }
    
    str_name = a_staff_pieces[ 0 ].craftablename;
    level.staff_part_count[ str_name ] = a_staff_pieces.size;
    
    foreach ( piece in a_staff_pieces )
    {
        assert( piece.craftablename == str_name );
        piece thread watch_staff_pickup();
    }
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0xde284e20, Offset: 0x5690
// Size: 0x28
function craftable_waittill_spawned()
{
    while ( !isdefined( self.piecespawn ) )
    {
        util::wait_network_frame();
    }
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0xb9fdf290, Offset: 0x56c0
// Size: 0x42
function watch_staff_pickup()
{
    self craftable_waittill_spawned();
    self.piecespawn waittill( #"pickup" );
    level.staff_part_count[ self.craftablename ]--;
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x5b866dfa, Offset: 0x5710
// Size: 0x10e, Type: bool
function onfullycrafted_quadrotor( player )
{
    level.quadrotor_status.crafted = 1;
    zm_craftables::set_hide_model_if_unavailable( "equip_dieseldrone", 1 );
    self.custom_craftablestub_update_prompt = &function_52fbdde1;
    pickup_trig = level.quadrotor_status.pickup_trig;
    level.quadrotor_status.str_zone = zm_zonemgr::get_zone_from_position( pickup_trig.origin, 1 );
    pickup_trig.model setmodel( "veh_t7_dlc_zm_quadrotor" );
    pickup_trig.model setscale( 0.7 );
    level notify( #"quest_progressed", player, 1 );
    return true;
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x1cbb14b, Offset: 0x5828
// Size: 0x170, Type: bool
function function_52fbdde1( player )
{
    w_drone = getweapon( "equip_dieseldrone" );
    
    if ( player hasweapon( w_drone ) )
    {
        self.hint_string = &"ZOMBIE_BUILD_PIECE_HAVE_ONE";
        return false;
    }
    
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( players[ i ] hasweapon( w_drone ) )
        {
            self.hint_string = &"DLC5_QUADROTOR_UNAVAILABLE";
            return false;
        }
    }
    
    quadrotors = getentarray( "quadrotor_ai", "targetname" );
    
    if ( quadrotors.size >= 1 )
    {
        self.hint_string = &"DLC5_QUADROTOR_UNAVAILABLE";
        return false;
    }
    
    if ( level flag::get( "quadrotor_cooling_down" ) )
    {
        self.hint_string = &"DLC5_QUADROTOR_COOLDOWN";
        return false;
    }
    
    return true;
}

// Namespace zm_tomb_craftables
// Params 2
// Checksum 0xdd3e0db3, Offset: 0x59a0
// Size: 0x388, Type: bool
function staff_fullycrafted( modelname, elementenum )
{
    player = zm_utility::get_closest_player( self.origin );
    staff_model = getent( modelname, "targetname" );
    staff_info = get_staff_info_from_element_index( elementenum );
    staff_model useweaponmodel( staff_info.w_weapon );
    staff_model showallparts();
    
    switch ( staff_info.craftable_name )
    {
        case "elemental_staff_air":
            staff_model.angles = ( 0, 130, 0 );
            break;
        case "elemental_staff_fire":
            staff_model.angles = ( 0, 50, 0 );
            break;
        case "elemental_staff_lightning":
            staff_model.angles = ( 0, 90, 0 );
            break;
        default:
            staff_model.angles = ( 0, 0, 0 );
            break;
    }
    
    level notify( #"quest_progressed", player, 0 );
    
    if ( !isdefined( staff_model.inused ) )
    {
        staff_model.origin -= ( 0, 0, 30 );
        player clear_player_crystal( elementenum, staff_info.element + "_staff.holder" );
        staff_model show();
        staff_model.inused = 1;
        level.n_staffs_crafted++;
        
        if ( level.n_staffs_crafted == 4 )
        {
            level flag::set( "ee_all_staffs_crafted" );
        }
        
        foreach ( e_player in level.players )
        {
            e_player thread zm_craftables::player_show_craftable_parts_ui( undefined, "zmInventory." + staff_info.element + "_staff.visible", 1 );
        }
    }
    
    if ( !isdefined( staff_info.charger ) || !( isdefined( staff_info.charger.is_charged ) && staff_info.charger.is_charged ) )
    {
        str_fieldname = staff_info.element + "_staff.quest_state";
        level clientfield::set( str_fieldname, 3 );
    }
    
    return true;
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0xfc3a34d8, Offset: 0x5d30
// Size: 0x42, Type: bool
function staff_fire_fullycrafted()
{
    level thread sndplaystaffstingeronce( "fire" );
    return staff_fullycrafted( "craftable_staff_fire_zm", 1 );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0xf0f1cddc, Offset: 0x5d80
// Size: 0x42, Type: bool
function staff_air_fullycrafted()
{
    level thread sndplaystaffstingeronce( "air" );
    return staff_fullycrafted( "craftable_staff_air_zm", 2 );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0xeda55fcf, Offset: 0x5dd0
// Size: 0x42, Type: bool
function staff_lightning_fullycrafted()
{
    level thread sndplaystaffstingeronce( "lightning" );
    return staff_fullycrafted( "craftable_staff_lightning_zm", 3 );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x9e586018, Offset: 0x5e20
// Size: 0x42, Type: bool
function staff_water_fullycrafted()
{
    level thread sndplaystaffstingeronce( "ice" );
    return staff_fullycrafted( "craftable_staff_water_zm", 4 );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x11062620, Offset: 0x5e70
// Size: 0x7c
function sndplaystaffstingeronce( type )
{
    if ( !isdefined( level.sndstaffbuilt ) )
    {
        level.sndstaffbuilt = [];
    }
    
    if ( !isinarray( level.sndstaffbuilt, type ) )
    {
        level.sndstaffbuilt[ level.sndstaffbuilt.size ] = type;
        level thread zm_tomb_amb::sndplaystinger( "staff_" + type );
    }
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xef33309d, Offset: 0x5ef8
// Size: 0xac
function quadrotor_watcher( player )
{
    quadrotor_set_unavailable();
    player thread quadrotor_return_condition_watcher();
    player thread quadrotor_control_thread();
    level waittill( #"drone_available" );
    level.maxis_quadrotor = undefined;
    
    if ( level flag::get( "ee_quadrotor_disabled" ) )
    {
        level flag::wait_till_clear( "ee_quadrotor_disabled" );
    }
    
    quadrotor_set_available();
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x5456c10, Offset: 0x5fb0
// Size: 0x76
function quadrotor_return_condition_watcher()
{
    self notify( #"quadrotor_return_condition_watcher" );
    self endon( #"quadrotor_return_condition_watcher" );
    self endon( #"new_placeable_mine" );
    self util::waittill_any( "bled_out", "disconnect" );
    
    if ( isdefined( level.maxis_quadrotor ) )
    {
        level notify( #"drone_should_return" );
        return;
    }
    
    level notify( #"drone_available" );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x74c80716, Offset: 0x6030
// Size: 0x234
function quadrotor_control_thread()
{
    self notify( #"quadrotor_control_thread" );
    self endon( #"quadrotor_control_thread" );
    self endon( #"bled_out" );
    self endon( #"disconnect" );
    self endon( #"new_placeable_mine" );
    
    while ( true )
    {
        w_drone = getweapon( "equip_dieseldrone" );
        
        if ( self actionslotfourbuttonpressed() && self hasweapon( w_drone ) )
        {
            self util::waittill_any_timeout( 1, "weapon_change_complete" );
            self playsound( "veh_qrdrone_takeoff" );
            self zm_weapons::switch_back_primary_weapon();
            self util::waittill_any_timeout( 1, "weapon_change_complete" );
            self zm_weapons::weapon_take( w_drone );
            self setactionslot( 4, "" );
            str_vehicle = "heli_quadrotor_zm";
            
            if ( level flag::get( "ee_maxis_drone_retrieved" ) )
            {
                str_vehicle = "heli_quadrotor_upgraded_zm";
            }
            
            qr = spawnvehicle( str_vehicle, self.origin + ( 0, 0, 96 ), self.angles, "quadrotor_ai" );
            level thread quadrotor_death_watcher( qr );
            qr thread quadrotor_instance_watcher( self );
            qr thread zm_tomb_vo::function_a808bc8e();
            return;
        }
        
        wait 0.05;
    }
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x28dcd8de, Offset: 0x6270
// Size: 0x68
function quadrotor_debug_send_home( player_owner )
{
    self endon( #"drone_should_return" );
    level endon( #"drone_available" );
    
    while ( true )
    {
        if ( player_owner actionslotfourbuttonpressed() )
        {
            self quadrotor_fly_back_to_table();
        }
        
        wait 0.05;
    }
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x27e4c3c6, Offset: 0x62e0
// Size: 0xbc
function quadrotor_instance_watcher( player_owner )
{
    self endon( #"death" );
    self.player_owner = player_owner;
    self.health = 200;
    level.maxis_quadrotor = self;
    self makevehicleunusable();
    self thread zm_ai_quadrotor::follow_ent( player_owner );
    self thread quadrotor_timer();
    self thread function_e8aad972( player_owner );
    level waittill( #"drone_should_return" );
    self quadrotor_fly_back_to_table();
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x564934b, Offset: 0x63a8
// Size: 0x32
function quadrotor_death_watcher( quadrotor )
{
    level endon( #"drone_available" );
    quadrotor waittill( #"death" );
    level notify( #"drone_available" );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x7cdf2090, Offset: 0x63e8
// Size: 0x162
function quadrotor_fly_back_to_table()
{
    self endon( #"death" );
    level endon( #"drone_available" );
    
    if ( isdefined( self ) )
    {
        /#
            iprintln( "<dev string:x146>" );
        #/
        
        self.returning_home = 1;
        self thread quadrotor_fly_back_to_table_timeout();
        self util::waittill_any( "attempting_return", "return_timeout" );
    }
    
    if ( isdefined( self ) )
    {
        self util::waittill_any( "near_goal", "force_goal", "reached_end_node", "return_timeout" );
    }
    
    if ( isdefined( self ) )
    {
        playfx( level._effect[ "tesla_elec_kill" ], self.origin );
        self playsound( "zmb_qrdrone_leave" );
        self delete();
        
        /#
            iprintln( "<dev string:x160>" );
        #/
    }
    
    level notify( #"drone_available" );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x5edfd75f, Offset: 0x6558
// Size: 0x2c
function report_notify( str_notify )
{
    self waittill( str_notify );
    iprintln( str_notify );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x8589fd7a, Offset: 0x6590
// Size: 0x6a
function quadrotor_fly_back_to_table_timeout()
{
    self endon( #"death" );
    level endon( #"drone_available" );
    wait 30;
    
    if ( isdefined( self ) )
    {
        self delete();
        
        /#
            iprintln( "<dev string:x160>" );
        #/
    }
    
    self notify( #"return_timeout" );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x1f21aee2, Offset: 0x6608
// Size: 0xa2
function quadrotor_timer()
{
    self endon( #"death" );
    level endon( #"drone_available" );
    wait 80;
    vox_line = "vox_maxi_drone_cool_down_" + randomintrange( 0, 2 );
    self thread zm_tomb_vo::maxissay( vox_line, self );
    wait 10;
    vox_line = "vox_maxi_drone_cool_down_2";
    self thread zm_tomb_vo::maxissay( vox_line, self );
    level notify( #"drone_should_return" );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x82e47fee, Offset: 0x66b8
// Size: 0x2f4
function quadrotor_set_available()
{
    /#
        iprintln( "<dev string:x16e>" );
    #/
    
    playfx( level._effect[ "tesla_elec_kill" ], level.quadrotor_status.pickup_trig.model.origin );
    level.quadrotor_status.pickup_trig.model playsound( "zmb_qrdrone_leave" );
    level.quadrotor_status.picked_up = 0;
    level.quadrotor_status.pickup_trig.model show();
    level flag::set( "quadrotor_cooling_down" );
    str_zone = level.quadrotor_status.str_zone;
    
    switch ( str_zone )
    {
        case "zone_nml_9":
            clientfield::set( "cooldown_steam", 1 );
            break;
        case "zone_bunker_5a":
            clientfield::set( "cooldown_steam", 2 );
            break;
        default:
            clientfield::set( "cooldown_steam", 3 );
            break;
    }
    
    vox_line = "vox_maxi_drone_cool_down_3";
    thread zm_tomb_vo::maxissay( vox_line, level.quadrotor_status.pickup_trig.model );
    wait 60;
    level flag::clear( "quadrotor_cooling_down" );
    clientfield::set( "cooldown_steam", 0 );
    
    foreach ( t_pickup in level.quadrotor_status.pickup_trig.playertrigger )
    {
        t_pickup triggerenable( 1 );
    }
    
    vox_line = "vox_maxi_drone_cool_down_4";
    zm_tomb_vo::maxissay( vox_line, level.quadrotor_status.pickup_trig.model );
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0xde18118, Offset: 0x69b8
// Size: 0xdc
function quadrotor_set_unavailable()
{
    level.quadrotor_status.picked_up = 1;
    
    foreach ( t_pickup in level.quadrotor_status.pickup_trig.playertrigger )
    {
        t_pickup triggerenable( 0 );
    }
    
    level.quadrotor_status.pickup_trig.model ghost();
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x4cb3b618, Offset: 0x6aa0
// Size: 0xb8
function function_e8aad972( e_player_owner )
{
    self endon( #"death" );
    level endon( #"drone_available" );
    
    while ( true )
    {
        e_player_owner util::waittill_any( "teleport_finished", "gr_eject_sequence_complete" );
        self clientfield::increment( "teleport_arrival_departure_fx" );
        self.origin = e_player_owner.origin + ( 0, 0, 100 );
        self clientfield::increment( "teleport_arrival_departure_fx" );
    }
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0xd1056bd5, Offset: 0x6b60
// Size: 0x44
function sqcommoncraftable()
{
    level.sq_craftable = zm_craftables::craftable_trigger_think( "sq_common_craftable_trigger", "sq_common", "sq_common", "", 1, 0 );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xc135297d, Offset: 0x6bb0
// Size: 0xc
function droponmover( player )
{
    
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x99ec1590, Offset: 0x6bc8
// Size: 0x4
function pickupfrommover()
{
    
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x9d0a5661, Offset: 0x6bd8
// Size: 0x214, Type: bool
function setup_quadrotor_purchase( player )
{
    w_drone = getweapon( "equip_dieseldrone" );
    
    if ( self.stub.equipname == "equip_dieseldrone" )
    {
        if ( players_has_weapon( w_drone ) )
        {
            return true;
        }
        
        quadrotor = getentarray( "quadrotor_ai", "targetname" );
        
        if ( quadrotor.size >= 1 )
        {
            return true;
        }
        
        quadrotor_set_unavailable();
        player zm_weapons::weapon_give( w_drone );
        player setweaponammoclip( w_drone, 1 );
        player playsoundtoplayer( "zmb_buildable_pickup_complete", player );
        
        if ( isdefined( self.stub.craftablestub.use_actionslot ) )
        {
            player setactionslot( self.stub.craftablestub.use_actionslot, "weapon", w_drone );
        }
        else
        {
            player setactionslot( 4, "weapon", w_drone );
        }
        
        player clientfield::set_player_uimodel( "hudItems.showDpadRight_Drone", 1 );
        player notify( #"equip_dieseldrone_zm_given" );
        level thread quadrotor_watcher( player );
        player thread zm_audio::create_and_play_dialog( "general", "build_dd_plc" );
        return true;
    }
    
    return false;
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xd47de52d, Offset: 0x6df8
// Size: 0xc0, Type: bool
function players_has_weapon( weaponname )
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( players[ i ] hasweapon( weaponname ) )
        {
            return true;
        }
    }
    
    quadrotors = getentarray( "quadrotor_ai", "targetname" );
    
    if ( quadrotors.size >= 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xefb36241, Offset: 0x6ec0
// Size: 0x27e, Type: bool
function tomb_custom_craftable_validation( player )
{
    if ( self.stub.equipname == "equip_dieseldrone" )
    {
        level.quadrotor_status.pickup_trig = self.stub;
        
        if ( level.quadrotor_status.crafted )
        {
            w_drone = getweapon( "equip_dieseldrone" );
            return ( !players_has_weapon( w_drone ) && !level flag::get( "quadrotor_cooling_down" ) );
        }
    }
    
    if ( !issubstr( self.stub.weaponname.name, "staff" ) )
    {
        return true;
    }
    
    str_craftable = self.stub.equipname;
    
    if ( !( isdefined( level.craftables_crafted[ str_craftable ] ) && level.craftables_crafted[ str_craftable ] ) )
    {
        return true;
    }
    
    if ( !player zm_tomb_main_quest::can_pickup_staff() )
    {
        return false;
    }
    
    s_elemental_staff = get_staff_info_from_weapon_name( self.stub.weaponname, 0 );
    str_weapon_check = s_elemental_staff.weapname;
    a_weapons = player getweaponslistprimaries();
    
    foreach ( weapon in a_weapons )
    {
        if ( issubstr( weapon.name, "staff" ) && weapon.name != str_weapon_check )
        {
            player takeweapon( weapon );
        }
    }
    
    return true;
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xa94c1858, Offset: 0x7148
// Size: 0x44c, Type: bool
function tomb_check_crafted_weapon_persistence( player )
{
    if ( self.stub.equipname == "equip_dieseldrone" )
    {
        if ( level.quadrotor_status.crafted )
        {
            return false;
        }
    }
    else if ( self.stub.weaponname == level.a_elemental_staffs[ "staff_air" ].w_weapon || self.stub.weaponname == level.a_elemental_staffs[ "staff_fire" ].w_weapon || self.stub.weaponname == level.a_elemental_staffs[ "staff_lightning" ].w_weapon || self.stub.weaponname == level.a_elemental_staffs[ "staff_water" ].w_weapon )
    {
        if ( self is_unclaimed_staff_weapon( self.stub.weaponname ) && !( isdefined( level.var_b79a2c38[ self.stub.equipname ] ) && level.var_b79a2c38[ self.stub.equipname ] ) )
        {
            level thread function_fcebb932( self.stub.equipname );
            s_elemental_staff = get_staff_info_from_weapon_name( self.stub.weaponname, 0 );
            player zm_weapons::weapon_give( s_elemental_staff.w_weapon, 0, 0 );
            
            if ( isdefined( s_elemental_staff.prev_ammo_stock ) && isdefined( s_elemental_staff.prev_ammo_clip ) )
            {
                player setweaponammostock( s_elemental_staff.w_weapon, s_elemental_staff.prev_ammo_stock );
                player setweaponammoclip( s_elemental_staff.w_weapon, s_elemental_staff.prev_ammo_clip );
            }
            
            if ( isdefined( level.zombie_craftablestubs[ self.stub.equipname ].str_taken ) )
            {
                self.stub.hint_string = level.zombie_craftablestubs[ self.stub.equipname ].str_taken;
            }
            else
            {
                self.stub.hint_string = "";
            }
            
            self sethintstring( self.stub.hint_string );
            player zm_craftables::track_craftables_pickedup( self.stub.craftablespawn );
            str_name = "craftable_" + self.stub.weaponname.name + "_zm";
            model = getent( str_name, "targetname" );
            model ghost();
            self.stub thread track_crafted_staff_trigger();
            self.stub thread track_staff_weapon_respawn( player );
            set_player_staff( self.stub.weaponname, player );
        }
        else
        {
            self.stub.hint_string = "";
            self sethintstring( self.stub.hint_string );
        }
        
        return true;
    }
    
    return false;
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xf750e0db, Offset: 0x75a0
// Size: 0x3a
function function_fcebb932( str_equipname )
{
    level.var_b79a2c38[ str_equipname ] = 1;
    wait 0.2;
    level.var_b79a2c38[ str_equipname ] = 0;
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0xeafef3f9, Offset: 0x75e8
// Size: 0x144, Type: bool
function is_unclaimed_staff_weapon( w_check )
{
    if ( !zm_equipment::is_limited( w_check ) )
    {
        return true;
    }
    else
    {
        s_elemental_staff = get_staff_info_from_weapon_name( w_check, 0 );
        str_weapon_check = s_elemental_staff.weapname;
        players = getplayers();
        
        foreach ( player in players )
        {
            if ( isdefined( player ) && player.sessionstate == "playing" && player zm_weapons::has_weapon_or_upgrade( w_check ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace zm_tomb_craftables
// Params 2
// Checksum 0x72c9a67b, Offset: 0x7738
// Size: 0x12a
function get_staff_info_from_weapon_name( w_weapon, b_base_info_only )
{
    if ( !isdefined( b_base_info_only ) )
    {
        b_base_info_only = 1;
    }
    
    str_name = w_weapon.name;
    
    foreach ( s_staff in level.a_elemental_staffs )
    {
        if ( s_staff.weapname == str_name || s_staff.upgrade.weapname == str_name )
        {
            if ( s_staff.charger.is_charged && !b_base_info_only )
            {
                return s_staff.upgrade;
            }
            
            return s_staff;
        }
    }
    
    return undefined;
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x7b042fdf, Offset: 0x7870
// Size: 0x9a
function get_staff_info_from_element_index( n_index )
{
    foreach ( s_staff in level.a_elemental_staffs )
    {
        if ( s_staff.enum == n_index )
        {
            return s_staff;
        }
    }
    
    return undefined;
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0xa4bb3ee0, Offset: 0x7918
// Size: 0xf4
function track_crafted_staff_trigger()
{
    s_elemental_staff = get_staff_info_from_weapon_name( self.weaponname, 1 );
    
    if ( !isdefined( self.base_weaponname ) )
    {
        self.base_weaponname = s_elemental_staff.weapname;
    }
    
    level flag::wait_till_clear( self.base_weaponname + "_zm_enabled" );
    level flag::set( self.base_weaponname + "_picked_up" );
    level flag::wait_till( self.base_weaponname + "_zm_enabled" );
    level flag::clear( self.base_weaponname + "_picked_up" );
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x6331944f, Offset: 0x7a18
// Size: 0x79c
function track_staff_weapon_respawn( player )
{
    self notify( #"kill_track_staff_weapon_respawn" );
    self endon( #"kill_track_staff_weapon_respawn" );
    s_elemental_staff = undefined;
    
    if ( issubstr( self.targetname, "prop_" ) )
    {
        s_elemental_staff = get_staff_info_from_weapon_name( self.w_weapon, 1 );
    }
    else
    {
        s_elemental_staff = get_staff_info_from_weapon_name( self.weaponname, 1 );
    }
    
    s_upgraded_staff = s_elemental_staff.upgrade;
    
    if ( !isdefined( self.base_weaponname ) )
    {
        self.base_weaponname = s_elemental_staff.weapname;
    }
    
    level flag::clear( self.base_weaponname + "_zm_enabled" );
    
    for ( has_weapon = 0; isalive( player ) ; has_weapon = 0 )
    {
        if ( isdefined( s_upgraded_staff.ee_in_use ) && ( isdefined( s_upgraded_staff.charger.is_inserted ) && ( isdefined( s_elemental_staff.charger.is_inserted ) && s_elemental_staff.charger.is_inserted || s_upgraded_staff.charger.is_inserted ) || s_upgraded_staff.ee_in_use ) )
        {
            has_weapon = 1;
        }
        else
        {
            weapons = player getweaponslistprimaries();
            
            foreach ( weapon in weapons )
            {
                n_melee_element = 0;
                
                if ( weapon.name == self.base_weaponname )
                {
                    s_elemental_staff.prev_ammo_stock = player getweaponammostock( weapon );
                    s_elemental_staff.prev_ammo_clip = player getweaponammoclip( weapon );
                    has_weapon = 1;
                }
                else if ( weapon.name == s_upgraded_staff.weapname )
                {
                    s_upgraded_staff.prev_ammo_stock = player getweaponammostock( weapon );
                    s_upgraded_staff.prev_ammo_clip = player getweaponammoclip( weapon );
                    has_weapon = 1;
                    n_melee_element = s_upgraded_staff.enum;
                }
                
                if ( player hasweapon( level.w_staff_revive ) )
                {
                    s_upgraded_staff.revive_ammo_stock = player getweaponammostock( level.w_staff_revive );
                    s_upgraded_staff.revive_ammo_clip = player getweaponammoclip( level.w_staff_revive );
                }
                
                if ( has_weapon && !( isdefined( player.one_inch_punch_flag_has_been_init ) && player.one_inch_punch_flag_has_been_init ) && n_melee_element != 0 && !player hasperk( "specialty_widowswine" ) )
                {
                    cur_weapon = player getcurrentweapon();
                    
                    if ( isdefined( player.use_staff_melee ) && cur_weapon != weapon && player.use_staff_melee )
                    {
                        player zm_tomb_utility::update_staff_accessories( 0 );
                        continue;
                    }
                    
                    if ( cur_weapon == weapon && !( isdefined( player.use_staff_melee ) && player.use_staff_melee ) )
                    {
                        player zm_tomb_utility::update_staff_accessories( n_melee_element );
                    }
                }
            }
        }
        
        if ( !has_weapon && !player laststand::player_is_in_laststand() )
        {
            break;
        }
        
        wait 0.5;
    }
    
    b_staff_in_use = 0;
    a_players = getplayers();
    
    foreach ( check_player in a_players )
    {
        if ( check_player.sessionstate == "playing" )
        {
            weapons = check_player getweaponslistprimaries();
            
            foreach ( weapon in weapons )
            {
                if ( weapon.name == self.base_weaponname || weapon.name == s_upgraded_staff.weapname )
                {
                    b_staff_in_use = 1;
                }
            }
        }
    }
    
    if ( !b_staff_in_use )
    {
        str_name = "craftable_" + self.base_weaponname + "_zm";
        model = getent( str_name, "targetname" );
        model show();
        level flag::set( self.base_weaponname + "_zm_enabled" );
    }
    
    if ( isweapon( self.weaponname ) )
    {
        clear_player_staff( self.weaponname, player );
        return;
    }
    
    clear_player_staff( self.w_weapon, player );
}

// Namespace zm_tomb_craftables
// Params 2
// Checksum 0xf911db0b, Offset: 0x81c0
// Size: 0x12c
function set_player_staff( w_staff, e_player )
{
    s_staff = get_staff_info_from_weapon_name( w_staff );
    s_staff.e_owner = e_player;
    n_player = e_player getentitynumber() + 1;
    e_player.staff_enum = s_staff.enum;
    level clientfield::set( s_staff.element + "_staff.holder", e_player.characterindex + 1 );
    e_player zm_tomb_utility::update_staff_accessories( s_staff.enum );
    
    /#
        iprintlnbold( "<dev string:x185>" + n_player + "<dev string:x18d>" + s_staff.enum );
    #/
}

// Namespace zm_tomb_craftables
// Params 1
// Checksum 0x1b9c190a, Offset: 0x82f8
// Size: 0xe2
function clear_player_staff_by_player_number( var_d95a0cf3 )
{
    foreach ( s_staff in level.a_elemental_staffs )
    {
        if ( level clientfield::get( s_staff.element + "_staff.holder" ) == var_d95a0cf3 )
        {
            level clientfield::set( s_staff.element + "_staff.holder", 0 );
        }
    }
}

// Namespace zm_tomb_craftables
// Params 2
// Checksum 0x4c29de8, Offset: 0x83e8
// Size: 0x19a
function clear_player_staff( w_check, e_owner )
{
    s_staff = get_staff_info_from_weapon_name( w_check );
    
    if ( isdefined( e_owner ) && isdefined( s_staff.e_owner ) && e_owner != s_staff.e_owner )
    {
        return;
    }
    
    if ( !isdefined( e_owner ) )
    {
        e_owner = s_staff.e_owner;
    }
    
    if ( isdefined( e_owner ) )
    {
        if ( level clientfield::get( s_staff.element + "_staff.holder" ) == e_owner.characterindex + 1 )
        {
            n_player = e_owner getentitynumber() + 1;
            e_owner.staff_enum = 0;
            level clientfield::set( s_staff.element + "_staff.holder", 0 );
            e_owner zm_tomb_utility::update_staff_accessories( 0 );
        }
    }
    
    /#
        iprintlnbold( "<dev string:x199>" + s_staff.enum );
    #/
    
    s_staff.e_owner = undefined;
}

// Namespace zm_tomb_craftables
// Params 0
// Checksum 0x27c53e80, Offset: 0x8590
// Size: 0xb2
function hide_staff_model()
{
    staffs = getentarray( "craftable_staff_model", "script_noteworthy" );
    
    foreach ( stave in staffs )
    {
        stave ghost();
    }
}

