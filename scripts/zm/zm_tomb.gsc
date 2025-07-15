#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_mechz;
#using scripts/zm/_zm_ai_mechz_claw;
#using scripts/zm/_zm_ai_quadrotor;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_electric_cherry;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_placeable_mine;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerup_zombie_blood;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_timer;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_annihilator;
#using scripts/zm/_zm_weap_beacon;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weap_bowie;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_one_inch_punch;
#using scripts/zm/_zm_weap_riotshield_tomb;
#using scripts/zm/_zm_weap_staff_air;
#using scripts/zm/_zm_weap_staff_fire;
#using scripts/zm/_zm_weap_staff_lightning;
#using scripts/zm/_zm_weap_staff_revive;
#using scripts/zm/_zm_weap_staff_water;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/zm_challenges_tomb;
#using scripts/zm/zm_remaster_zombie;
#using scripts/zm/zm_tomb_achievement;
#using scripts/zm/zm_tomb_amb;
#using scripts/zm/zm_tomb_ambient_scripts;
#using scripts/zm/zm_tomb_capture_zones;
#using scripts/zm/zm_tomb_challenges;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/zm_tomb_craftables;
#using scripts/zm/zm_tomb_dig;
#using scripts/zm/zm_tomb_ee_main;
#using scripts/zm/zm_tomb_ee_side;
#using scripts/zm/zm_tomb_ffotd;
#using scripts/zm/zm_tomb_fx;
#using scripts/zm/zm_tomb_giant_robot;
#using scripts/zm/zm_tomb_magicbox;
#using scripts/zm/zm_tomb_main_quest;
#using scripts/zm/zm_tomb_mech;
#using scripts/zm/zm_tomb_quest_fire;
#using scripts/zm/zm_tomb_tank;
#using scripts/zm/zm_tomb_teleporter;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_zombie;
#using scripts/zm/zm_zmhd_cleanup_mgr;

#namespace zm_tomb;

// Namespace zm_tomb
// Params 0, eflags: 0x2
// Checksum 0x2fd4f349, Offset: 0x2278
// Size: 0x28
function autoexec opt_in()
{
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    level.pack_a_punch_camo_index = 133;
}

// Namespace zm_tomb
// Params 0
// Checksum 0x5cf4f1e8, Offset: 0x22a8
// Size: 0xd74
function main()
{
    zm_tomb_ffotd::main_start();
    level._no_equipment_activated_clientfield = 1;
    level._no_navcards = 1;
    level._wallbuy_override_num_bits = 1;
    level.player_out_of_playable_area_monitor_callback = &player_out_of_playable_area_override;
    zm_tomb_fx::main();
    level.default_game_mode = "zclassic";
    level.default_start_location = "tomb";
    setup_rex_starts();
    level.fx_exclude_edge_fog = 1;
    level.fx_exclude_tesla_head_light = 1;
    level.fx_exclude_default_explosion = 1;
    level.fx_exclude_footsteps = 1;
    level._uses_sticky_grenades = 1;
    level.disable_fx_zmb_wall_buy_semtex = 1;
    level._uses_taser_knuckles = 0;
    level.disable_fx_upgrade_aquired = 1;
    level.sndzhdaudio = 1;
    zm::init_fx();
    level.zombiemode = 1;
    level._no_water_risers = 1;
    level.riser_fx_on_client = 1;
    level._round_start_func = &zm::round_start;
    level.n_active_ragdolls = 0;
    level.ragdoll_limit_check = &zm_tomb_utility::ragdoll_attempt;
    level._limited_equipment = [];
    level._limited_equipment[ level._limited_equipment.size ] = getweapon( "equip_dieseldrone" );
    level._limited_equipment[ level._limited_equipment.size ] = getweapon( "staff_air" );
    level._limited_equipment[ level._limited_equipment.size ] = getweapon( "staff_fire" );
    level._limited_equipment[ level._limited_equipment.size ] = getweapon( "staff_lightning" );
    level._limited_equipment[ level._limited_equipment.size ] = getweapon( "staff_water" );
    level.a_func_vehicle_damage_override = [];
    level.callbackvehicledamage = &tomb_vehicle_damage_override_wrapper;
    level.level_specific_stats_init = &init_tomb_stats;
    setdvar( "zombiemode_path_minz_bias", 13 );
    setdvar( "bg_chargeShotExponentialAmmoPerChargeLevel", 1 );
    setdvar( "dlc2_fix_scripted_looping_linked_animations", 1 );
    level thread setup_tomb_spawn_groups();
    spawner_main_chamber_capture_zombies = getent( "chamber_capture_zombie_spawner", "targetname" );
    spawner_main_chamber_capture_zombies spawner::add_spawn_function( &chamber_capture_zombie_spawn_init );
    level.has_richtofen = 0;
    level.givecustomcharacters = &give_personality_characters;
    level.setupcustomcharacterexerts = &zm_tomb_vo::setup_personality_character_exerts;
    initcharacterstartindex();
    level thread zm_tomb_vo::init_flags();
    level._zmbvoxlevelspecific = &zm_tomb_vo::init_level_specific_audio;
    level.custom_player_fake_death = &zm_player_fake_death;
    level.custom_player_fake_death_cleanup = &zm_player_fake_death_cleanup;
    level.custom_player_track_ammo_count = &tomb_custom_player_track_ammo_count;
    level.zombie_init_done = &zombie_init_done;
    level._zombies_round_spawn_failsafe = &tomb_round_spawn_failsafe;
    level.random_pandora_box_start = 1;
    level.custom_electric_cherry_perk_threads = zm_perks::register_perk_threads( "specialty_electriccherry", &tomb_custom_electric_cherry_reload_attack, &zm_perk_electric_cherry::electric_cherry_perk_lost );
    level.custom_laststand_func = &tomb_custom_electric_cherry_laststand;
    level.perk_random_vo_func_usemachine = &zm_tomb_vo::wunderfizz_used_vo;
    level._custom_turn_packapunch_on = &zm_tomb_capture_zones::pack_a_punch_dummy_init;
    zm_pap_util::set_interaction_trigger_radius( 80 );
    level.register_offhand_weapons_for_level_defaults_override = &offhand_weapon_overrride;
    level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
    level._zombie_custom_add_weapons = &custom_add_weapons;
    level._allow_melee_weapon_switching = 1;
    zm_placeable_mine::add_weapon_to_mine_slot( "equip_dieseldrone" );
    level.custom_ai_type = [];
    level.raygun2_included = 1;
    include_powerups();
    include_perks_in_random_rotation();
    level thread zm_tomb_ee_main::init();
    level thread zm_tomb_ee_side::init();
    level zm_tomb_achievement::init();
    
    if ( level.splitscreen && getdvarint( "splitscreen_playerCount" ) > 2 )
    {
        level.optimise_for_splitscreen = 1;
    }
    else
    {
        level.optimise_for_splitscreen = 0;
    }
    
    level.var_7c29c50e = &function_56848b85;
    level.special_weapon_magicbox_check = &tomb_special_weapon_magicbox_check;
    level.dont_unset_perk_when_machine_paused = 1;
    tomb_register_client_fields();
    register_burn_overlay();
    zm_tomb_tank::init();
    zm_tomb_giant_robot::init_giant_robot_glows();
    zm_tomb_giant_robot::init_giant_robot();
    level.can_revive = &zm_tomb_giant_robot::tomb_can_revive_override;
    zm_tomb_capture_zones::init_capture_zones();
    zm_tomb_ambient_scripts::init_tomb_ambient_scripts();
    zm_tomb_dig::init_shovel();
    level thread zm_tomb_teleporter::teleporter_init();
    zm_craftables::init();
    zm_tomb_craftables::include_craftables();
    zm_tomb_craftables::init_craftables();
    zm_tomb_craftables::register_clientfields();
    zm_tomb_craftables::randomize_craftable_spawns();
    _zm_weap_beacon::init();
    _zm_weap_one_inch_punch::init();
    zm_tomb_challenges::challenges_init();
    zm_tomb_amb::init();
    load::main();
    level thread function_89182d9b();
    function_67268668();
    zm_tomb_tank::main();
    zm_tomb_teleporter::main();
    zm_tomb_ambient_scripts::main();
    init_sounds();
    level thread setupmusic();
    zm_tomb_amb::main();
    level thread zm_tomb_ee_main::main();
    level.callbackactordamage = &tomb_actor_damage_override_wrapper;
    level._weaponobjects_on_player_connect_override = &tomb_weaponobjects_on_player_connect_override;
    zm_spawner::register_zombie_death_event_callback( &tomb_zombie_death_event_callback );
    level.player_intersection_tracker_override = &tomb_player_intersection_tracker_override;
    _zm_weap_cymbal_monkey::init();
    level._melee_weapons = [];
    level.a_e_slow_areas = getentarray( "player_slow_area", "targetname" );
    level thread zm_tomb_mech::init();
    level.n_crystals_pickedup = 0;
    level thread zm_tomb_main_quest::main_quest_init();
    level.closest_player_override = &tomb_closest_player_override;
    level.validate_enemy_path_length = &tomb_validate_enemy_path_length;
    level.zones = [];
    level.zone_manager_init_func = &working_zone_init;
    init_zones[ 0 ] = "zone_start";
    level thread zm_zonemgr::manage_zones( init_zones );
    
    if ( isdefined( level.optimise_for_splitscreen ) && level.optimise_for_splitscreen )
    {
        if ( zm_utility::is_classic() )
        {
            level.zombie_ai_limit = 20;
        }
        
        setdvar( "fx_marks_draw", 0 );
        setdvar( "disable_rope", 1 );
        setdvar( "cg_disableplayernames", 1 );
        setdvar( "disableLookAtEntityLogic", 1 );
    }
    else
    {
        level.zombie_ai_limit = 24;
    }
    
    level.default_laststandpistol = getweapon( "pistol_c96" );
    level.default_solo_laststandpistol = getweapon( "pistol_c96_upgraded" );
    level.laststandpistol = level.default_laststandpistol;
    level.start_weapon = level.default_laststandpistol;
    level thread zm::last_stand_pistol_rank_init();
    level thread drop_all_barriers();
    level thread zm_tomb_utility::traversal_blocker();
    callback::on_connect( &on_player_connect );
    callback::on_ai_spawned( &function_7b72be0d );
    zm::register_player_damage_callback( &tomb_player_damage_callback );
    level.custom_get_round_enemy_array_func = &zm_tomb_get_round_enemy_array;
    level flag::wait_till( "start_zombie_round_logic" );
    util::wait_network_frame();
    level notify( #"specialty_additionalprimaryweapon_power_on" );
    util::wait_network_frame();
    level notify( #"additionalprimaryweapon_on" );
    zombie_utility::set_zombie_var( "zombie_use_failsafe", 0 );
    level zm_tomb_utility::check_solo_status();
    level thread zm_tomb_utility::adjustments_for_solo();
    level thread zm_tomb_utility::zone_capture_powerup();
    level thread zm_tomb_utility::clean_up_bunker_doors();
    level clientfield::set( "lantern_fx", 1 );
    level thread zm_tomb_chamber::tomb_watch_chamber_player_activity();
    
    /#
        zm_tomb_utility::setup_devgui();
    #/
    
    zm_tomb_utility::init_weather_manager();
    zm_tomb_capture_zones::function_b0debead();
    level.zm_bgb_anywhere_but_here_validation_override = &function_869d6f66;
    level.var_9f5c2c50 = &function_e36dbcf4;
    level.var_2d4e3645 = &function_d9e1ec4d;
    level.var_2d0e5eb6 = &function_2d0e5eb6;
    level thread zm_tomb_ambient_scripts::function_add29756();
    level thread zm_perks::spare_change();
    zm_tomb_ffotd::main_end();
}

// Namespace zm_tomb
// Params 0
// Checksum 0x82487e78, Offset: 0x3028
// Size: 0x54c
function tomb_register_client_fields()
{
    clientfield::register( "scriptmover", "stone_frozen", 21000, 1, "int" );
    n_bits = getminbitcountfornum( 5 );
    clientfield::register( "world", "rain_level", 21000, n_bits, "int" );
    clientfield::register( "world", "snow_level", 21000, n_bits, "int" );
    clientfield::register( "toplayer", "player_weather_visionset", 21000, 2, "int" );
    n_bits = getminbitcountfornum( 6 );
    clientfield::register( "toplayer", "player_rumble_and_shake", 21000, n_bits, "int" );
    clientfield::register( "scriptmover", "sky_pillar", 21000, 1, "int" );
    clientfield::register( "scriptmover", "staff_charger", 21000, 3, "int" );
    clientfield::register( "toplayer", "player_staff_charge", 21000, 2, "int" );
    clientfield::register( "toplayer", "player_tablet_state", 21000, 2, "int" );
    n_bits = getminbitcountfornum( 4 );
    clientfield::register( "actor", "zombie_soul", 21000, n_bits, "int" );
    clientfield::register( "zbarrier", "magicbox_runes", 21000, 1, "int" );
    clientfield::register( "scriptmover", "barbecue_fx", 21000, 1, "int" );
    clientfield::register( "world", "cooldown_steam", 21000, 2, "int" );
    clientfield::register( "world", "mus_zmb_egg_snapshot_loop", 21000, 1, "int" );
    clientfield::register( "toplayer", "sndMaelstrom", 21000, 1, "int" );
    clientfield::register( "actor", "foot_print_box_fx", 21000, 1, "int" );
    clientfield::register( "scriptmover", "foot_print_box_glow", 21000, 1, "int" );
    clientfield::register( "world", "crypt_open_exploder", 21000, 1, "int" );
    clientfield::register( "world", "lantern_fx", 21000, 1, "int" );
    clientfield::register( "clientuimodel", "player_lives", 21000, 2, "int" );
    clientfield::register( "clientuimodel", "zmInventory.widget_shield_parts", 21000, 1, "int" );
    clientfield::register( "clientuimodel", "zmInventory.player_crafted_shield", 21000, 1, "int" );
    clientfield::register( "actor", "tomb_mech_eye", 21000, 1, "int" );
    clientfield::register( "actor", "crusader_emissive_fx", 21000, 1, "int" );
    clientfield::register( "actor", "zombie_instant_explode", 21000, 1, "int" );
    clientfield::register( "scriptmover", "glow_biplane_trail_fx", 21000, 1, "int" );
}

// Namespace zm_tomb
// Params 0
// Checksum 0x34ca649d, Offset: 0x3580
// Size: 0x6c
function register_burn_overlay()
{
    level.zm_transit_burn_max_duration = 2;
    
    if ( !isdefined( level.vsmgr_prio_overlay_zm_transit_burn ) )
    {
        level.vsmgr_prio_overlay_zm_transit_burn = 20;
    }
    
    visionset_mgr::register_info( "overlay", "zm_transit_burn", 21000, level.vsmgr_prio_overlay_zm_transit_burn, 15, 1, &visionset_mgr::duration_lerp_thread_per_player, 0 );
}

// Namespace zm_tomb
// Params 0
// Checksum 0x55ca3a5a, Offset: 0x35f8
// Size: 0x1d4
function function_2d0e5eb6()
{
    var_cdb0f86b = getarraykeys( level.zombie_powerups );
    var_b4442b55 = array( "shield_charge", "ww_grenade", "bonus_points_team" );
    var_62e2eaf2 = [];
    
    for ( i = 0; i < var_cdb0f86b.size ; i++ )
    {
        var_77917a61 = 0;
        
        foreach ( var_68de493a in var_b4442b55 )
        {
            if ( var_cdb0f86b[ i ] == var_68de493a )
            {
                var_77917a61 = 1;
                break;
            }
        }
        
        if ( var_77917a61 )
        {
            continue;
        }
        
        if ( !isdefined( var_62e2eaf2 ) )
        {
            var_62e2eaf2 = [];
        }
        else if ( !isarray( var_62e2eaf2 ) )
        {
            var_62e2eaf2 = array( var_62e2eaf2 );
        }
        
        var_62e2eaf2[ var_62e2eaf2.size ] = var_cdb0f86b[ i ];
    }
    
    str_powerup = array::random( var_62e2eaf2 );
    return str_powerup;
}

// Namespace zm_tomb
// Params 0
// Checksum 0x3305db06, Offset: 0x37d8
// Size: 0x196, Type: bool
function function_56848b85()
{
    zombie_in_chamber = zm_tomb_chamber::is_point_in_chamber( self.origin );
    a_players = getplayers();
    
    for ( i = 0; i < a_players.size ; i++ )
    {
        if ( isdefined( a_players[ i ].ignoreme ) && ( !zombie_utility::is_player_valid( a_players[ i ] ) || a_players[ i ].ignoreme ) )
        {
            continue;
        }
        
        if ( isdefined( a_players[ i ].b_already_on_tank ) && a_players[ i ].b_already_on_tank )
        {
            if ( isdefined( self.b_on_tank ) && self.b_on_tank )
            {
                return true;
            }
            else
            {
                a_players[ i ].origin = level.vh_tank gettagorigin( "window_left_rear_jmp_jnt" );
            }
            
            continue;
        }
        
        player_in_chamber = zm_tomb_chamber::is_point_in_chamber( a_players[ i ].origin );
        
        if ( player_in_chamber != zombie_in_chamber )
        {
        }
    }
    
    return false;
}

// Namespace zm_tomb
// Params 1, eflags: 0x4
// Checksum 0xd458b5de, Offset: 0x3978
// Size: 0x10e
function private function_ce3464b9( players )
{
    if ( isdefined( self.last_closest_player.am_i_valid ) && isdefined( self.last_closest_player ) && self.last_closest_player.am_i_valid )
    {
        return;
    }
    
    self.var_13ed8adf = undefined;
    
    foreach ( player in players )
    {
        if ( isdefined( player.am_i_valid ) && player.am_i_valid && zm_tomb_utility::function_d39fc97a( player ) )
        {
            self.last_closest_player = player;
            return;
        }
    }
    
    self.last_closest_player = undefined;
}

// Namespace zm_tomb
// Params 0
// Checksum 0x12877a62, Offset: 0x3a90
// Size: 0x74
function function_7b72be0d()
{
    if ( !issubstr( self.classname, "crusader" ) )
    {
        return;
    }
    
    self clientfield::set( "crusader_emissive_fx", 1 );
    self waittill( #"death" );
    self clientfield::set( "crusader_emissive_fx", 0 );
}

// Namespace zm_tomb
// Params 2
// Checksum 0xf9bacccf, Offset: 0x3b10
// Size: 0x35a
function tomb_closest_player_override( v_zombie_origin, a_players_to_check )
{
    if ( isdefined( self.zombie_poi ) )
    {
        return undefined;
    }
    
    if ( isdefined( self.attackable ) )
    {
        return undefined;
    }
    
    if ( !isdefined( self.last_closest_player ) )
    {
        self.last_closest_player = a_players_to_check[ 0 ];
    }
    
    if ( !isdefined( self.var_13ed8adf ) || isdefined( level.last_closest_time ) && level.last_closest_time >= level.time && self.var_13ed8adf < level.time )
    {
        self function_ce3464b9( a_players_to_check );
        return self.last_closest_player;
    }
    
    if ( !isdefined( self.var_13ed8adf ) || self.var_13ed8adf == level.time )
    {
        self.var_13ed8adf = level.time;
        level.last_closest_time = level.time;
        level.var_2613231a = self;
        
        if ( a_players_to_check.size == 1 )
        {
            self.last_closest_player = a_players_to_check[ 0 ];
            self function_ce3464b9( a_players_to_check );
            return self.last_closest_player;
        }
        
        e_player_to_attack = zm_tomb_utility::tomb_get_closest_player_using_paths( v_zombie_origin, a_players_to_check );
        a_players = zm_tomb_tank::get_players_on_tank( 1 );
        
        if ( a_players.size > 0 )
        {
            e_player_closest_on_tank = undefined;
            n_dist_tank_min = 99999999;
            
            foreach ( e_player in a_players )
            {
                n_dist_sq = distance2dsquared( self.origin, e_player.origin );
                
                if ( n_dist_sq < n_dist_tank_min )
                {
                    n_dist_tank_min = n_dist_sq;
                    e_player_closest_on_tank = e_player;
                }
            }
            
            if ( zombie_utility::is_player_valid( e_player_to_attack ) )
            {
                n_dist_for_path = distance2dsquared( self.origin, e_player_to_attack.origin );
                
                if ( n_dist_tank_min < n_dist_for_path )
                {
                    e_player_to_attack = e_player_closest_on_tank;
                }
            }
            else if ( zombie_utility::is_player_valid( e_player_closest_on_tank ) )
            {
                e_player_to_attack = e_player_closest_on_tank;
            }
        }
        
        if ( !isdefined( e_player_to_attack ) )
        {
            e_player_to_attack = arraygetclosest( v_zombie_origin, a_players_to_check );
        }
        
        self.last_closest_player = e_player_to_attack;
    }
    
    self function_ce3464b9( a_players_to_check );
    return self.last_closest_player;
}

// Namespace zm_tomb
// Params 0
// Checksum 0xfe03a394, Offset: 0x3e78
// Size: 0x8a, Type: bool
function function_869d6f66()
{
    if ( !isdefined( self zm_bgb_anywhere_but_here::function_728dfe3() ) )
    {
        return false;
    }
    
    if ( isdefined( self.var_b605c6c3 ) && !self.var_b605c6c3 )
    {
        return false;
    }
    
    if ( issubstr( self.zone_name, "zone_chamber" ) )
    {
        return false;
    }
    
    if ( isdefined( self.b_already_on_tank ) && self.b_already_on_tank )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_tomb
// Params 0
// Checksum 0x86739d67, Offset: 0x3f10
// Size: 0x1c, Type: bool
function function_e36dbcf4()
{
    if ( self.is_stomped === 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_tomb
// Params 1
// Checksum 0x2ee4ed50, Offset: 0x3f38
// Size: 0x58
function function_d9e1ec4d( a_s_valid_respawn_points )
{
    var_c7786100 = struct::get( "zone_chamber", "script_noteworthy" );
    arrayremovevalue( a_s_valid_respawn_points, var_c7786100 );
    return a_s_valid_respawn_points;
}

// Namespace zm_tomb
// Params 0
// Checksum 0x172f3ae7, Offset: 0x3f98
// Size: 0x146
function zm_tomb_get_round_enemy_array()
{
    enemies = [];
    valid_enemies = [];
    enemies = getaispeciesarray( level.zombie_team, "all" );
    
    for ( i = 0; i < enemies.size ; i++ )
    {
        if ( !isdefined( enemies[ i ].script_noteworthy ) || isdefined( enemies[ i ].ignore_enemy_count ) && enemies[ i ].ignore_enemy_count && enemies[ i ].script_noteworthy != "capture_zombie" )
        {
            continue;
        }
        
        if ( !isdefined( valid_enemies ) )
        {
            valid_enemies = [];
        }
        else if ( !isarray( valid_enemies ) )
        {
            valid_enemies = array( valid_enemies );
        }
        
        valid_enemies[ valid_enemies.size ] = enemies[ i ];
    }
    
    return valid_enemies;
}

// Namespace zm_tomb
// Params 13
// Checksum 0xd57caf3a, Offset: 0x40e8
// Size: 0xf6
function tomb_player_damage_callback( e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, w_weapon, v_point, v_dir, str_hit_loc, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name )
{
    if ( isdefined( w_weapon ) )
    {
        if ( issubstr( w_weapon.name, "staff" ) )
        {
            return 0;
        }
        
        switch ( w_weapon.name )
        {
            case "quadrotorturret":
            case "quadrotorturret_upgraded":
            case "t72_turret":
            case "zombie_markiv_cannon":
            case "zombie_markiv_side_cannon":
            default:
                return 0;
        }
    }
    
    return n_damage;
}

// Namespace zm_tomb
// Params 0
// Checksum 0x25f5f1c5, Offset: 0x41e8
// Size: 0x1e4
function tomb_random_perk_weights()
{
    temp_array = [];
    
    if ( randomint( 4 ) == 0 )
    {
        arrayinsert( temp_array, "specialty_doubletap2", 0 );
    }
    
    if ( randomint( 4 ) == 0 )
    {
        arrayinsert( temp_array, "specialty_deadshot", 0 );
    }
    
    if ( randomint( 4 ) == 0 )
    {
        arrayinsert( temp_array, "specialty_additionalprimaryweapon", 0 );
    }
    
    if ( randomint( 4 ) == 0 )
    {
        arrayinsert( temp_array, "specialty_widowswine", 0 );
    }
    
    if ( randomint( 4 ) == 0 )
    {
        arrayinsert( temp_array, "specialty_electriccherry", 0 );
    }
    
    temp_array = array::randomize( temp_array );
    level._random_perk_machine_perk_list = array::randomize( level._random_perk_machine_perk_list );
    level._random_perk_machine_perk_list = arraycombine( level._random_perk_machine_perk_list, temp_array, 1, 0 );
    keys = getarraykeys( level._random_perk_machine_perk_list );
    return keys;
}

// Namespace zm_tomb
// Params 0
// Checksum 0x2e2eefb1, Offset: 0x43d8
// Size: 0x5c
function on_player_connect()
{
    self thread revive_watcher();
    util::wait_network_frame();
    self thread zm_tomb_utility::player_slow_movement_speed_monitor();
    level thread function_a5d4f26d();
}

// Namespace zm_tomb
// Params 0
// Checksum 0x1b40e612, Offset: 0x4440
// Size: 0x66
function revive_watcher()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"do_revive_ended_normally" );
        
        if ( self hasperk( "specialty_quickrevive" ) )
        {
            self notify( #"quick_revived_player" );
            continue;
        }
        
        self notify( #"revived_player" );
    }
}

// Namespace zm_tomb
// Params 0
// Checksum 0x3841c81, Offset: 0x44b0
// Size: 0x84
function function_a5d4f26d()
{
    e_machine = getent( "specialty_additionalprimaryweapon", "script_noteworthy" );
    
    if ( isdefined( e_machine ) && isdefined( e_machine ) )
    {
        e_machine.clip ghost();
        e_machine.clip connectpaths();
    }
}

// Namespace zm_tomb
// Params 0
// Checksum 0xea1aa2df, Offset: 0x4540
// Size: 0x40
function setup_tomb_spawn_groups()
{
    level.use_multiple_spawns = 1;
    level.spawner_int = 1;
    level.fn_custom_zombie_spawner_selection = &function_df9f5719;
    level waittill( #"start_zombie_round_logic" );
}

// Namespace zm_tomb
// Params 0
// Checksum 0x4e6852f5, Offset: 0x4588
// Size: 0x204
function function_df9f5719()
{
    var_6af221a2 = [];
    a_s_spots = array::randomize( level.zm_loc_types[ "zombie_location" ] );
    
    for ( i = 0; i < a_s_spots.size ; i++ )
    {
        if ( !isdefined( a_s_spots[ i ].script_int ) )
        {
            var_343b1937 = 1;
        }
        else
        {
            var_343b1937 = a_s_spots[ i ].script_int;
        }
        
        a_sp_zombies = [];
        
        foreach ( sp_zombie in level.zombie_spawners )
        {
            if ( sp_zombie.script_int == var_343b1937 )
            {
                if ( !isdefined( a_sp_zombies ) )
                {
                    a_sp_zombies = [];
                }
                else if ( !isarray( a_sp_zombies ) )
                {
                    a_sp_zombies = array( a_sp_zombies );
                }
                
                a_sp_zombies[ a_sp_zombies.size ] = sp_zombie;
            }
        }
        
        if ( a_sp_zombies.size )
        {
            sp_zombie = array::random( a_sp_zombies );
            return sp_zombie;
        }
    }
    
    assert( isdefined( sp_zombie ), "<dev string:x28>" + var_343b1937 );
}

// Namespace zm_tomb
// Params 0
// Checksum 0x1dbaf05a, Offset: 0x4798
// Size: 0x3c
function chamber_capture_zombie_spawn_init()
{
    self endon( #"death" );
    self waittill( #"completed_emerging_into_playable_area" );
    self clientfield::set( "zone_capture_zombie", 1 );
}

// Namespace zm_tomb
// Params 0
// Checksum 0x9f08c650, Offset: 0x47e0
// Size: 0x360
function tomb_round_spawn_failsafe()
{
    self endon( #"death" );
    
    for ( prevorigin = self.origin; true ; prevorigin = self.origin )
    {
        if ( isdefined( self.ignore_round_spawn_failsafe ) && self.ignore_round_spawn_failsafe )
        {
            return;
        }
        
        wait 15;
        
        if ( isdefined( self.is_inert ) && self.is_inert )
        {
            continue;
        }
        
        players = getplayers();
        zombie_blood = 0;
        
        foreach ( player in players )
        {
            if ( zm_utility::is_player_valid( player ) )
            {
                if ( isdefined( player.zombie_vars[ "zombie_powerup_zombie_blood_on" ] ) && player.zombie_vars[ "zombie_powerup_zombie_blood_on" ] )
                {
                    zombie_blood = 1;
                    break;
                }
            }
        }
        
        if ( zombie_blood )
        {
            continue;
        }
        
        if ( isdefined( self.lastchunk_destroy_time ) )
        {
            if ( gettime() - self.lastchunk_destroy_time < 8000 )
            {
                continue;
            }
        }
        
        if ( self.origin[ 2 ] < -3000 )
        {
            if ( isdefined( level.put_timed_out_zombies_back_in_queue ) && level.put_timed_out_zombies_back_in_queue && !level flag::get( "dog_round" ) && !( isdefined( self.isscreecher ) && self.isscreecher ) )
            {
                level.zombie_total++;
                level.zombie_total_subtract++;
            }
            
            self dodamage( self.health + 100, ( 0, 0, 0 ) );
            break;
        }
        
        if ( distancesquared( self.origin, prevorigin ) < 576 )
        {
            if ( isdefined( level.put_timed_out_zombies_back_in_queue ) && level.put_timed_out_zombies_back_in_queue && !level flag::get( "dog_round" ) )
            {
                if ( !self.ignoreall && !( isdefined( self.nuked ) && self.nuked ) && !( isdefined( self.marked_for_death ) && self.marked_for_death ) && !( isdefined( self.isscreecher ) && self.isscreecher ) && !( isdefined( self.missinglegs ) && self.missinglegs ) && !( isdefined( self.is_brutus ) && self.is_brutus ) )
                {
                    level.zombie_total++;
                    level.zombie_total_subtract++;
                }
            }
            
            level.zombies_timeout_playspace++;
            self dodamage( self.health + 100, ( 0, 0, 0 ) );
            break;
        }
    }
}

// Namespace zm_tomb
// Params 0
// Checksum 0xdfe5bfa6, Offset: 0x4b48
// Size: 0x2e4
function give_personality_characters()
{
    if ( isdefined( level.hotjoin_player_setup ) && [[ level.hotjoin_player_setup ]]( "c_zom_farmgirl_viewhands" ) )
    {
        return;
    }
    
    self detachall();
    
    if ( !isdefined( self.characterindex ) )
    {
        self.characterindex = assign_lowest_unused_character_index();
    }
    
    self.favorite_wall_weapons_list = [];
    self.talks_in_danger = 0;
    
    /#
        if ( getdvarstring( "<dev string:x52>" ) != "<dev string:x5d>" )
        {
            self.characterindex = getdvarint( "<dev string:x52>" );
        }
    #/
    
    self setcharacterbodytype( self.characterindex );
    self setcharacterbodystyle( 0 );
    self setcharacterhelmetstyle( 0 );
    
    switch ( self.characterindex )
    {
        case 1:
            self.favorite_wall_weapons_list[ self.favorite_wall_weapons_list.size ] = getweapon( "shotgun_semiauto" );
            self.character_name = "Nikolai";
            break;
        case 0:
            self.favorite_wall_weapons_list[ self.favorite_wall_weapons_list.size ] = getweapon( "frag_grenade" );
            self.character_name = "Dempsey";
            break;
        case 3:
            self.favorite_wall_weapons_list[ self.favorite_wall_weapons_list.size ] = getweapon( "ar_accurate" );
            self.character_name = "Takeo";
            break;
        case 2:
            self.talks_in_danger = 1;
            level.rich_sq_player = self;
            level.sndradioa = self;
            self.favorite_wall_weapons_list[ self.favorite_wall_weapons_list.size ] = getweapon( "pistol_c96" );
            self.character_name = "Richtofen";
            break;
    }
    
    self setmovespeedscale( 1 );
    self setsprintduration( 4 );
    self setsprintcooldown( 0 );
    self thread set_exert_id();
}

// Namespace zm_tomb
// Params 0
// Checksum 0xc8ac26f6, Offset: 0x4e38
// Size: 0x54
function set_exert_id()
{
    self endon( #"disconnect" );
    util::wait_network_frame();
    util::wait_network_frame();
    self zm_audio::setexertvoice( self.characterindex + 1 );
}

// Namespace zm_tomb
// Params 0
// Checksum 0xc0f664cd, Offset: 0x4e98
// Size: 0x214
function assign_lowest_unused_character_index()
{
    charindexarray = [];
    charindexarray[ 0 ] = 0;
    charindexarray[ 1 ] = 1;
    charindexarray[ 2 ] = 2;
    charindexarray[ 3 ] = 3;
    players = getplayers();
    
    if ( players.size == 1 )
    {
        charindexarray = array::randomize( charindexarray );
        
        if ( charindexarray[ 0 ] == 2 )
        {
            level.has_richtofen = 1;
        }
        
        return charindexarray[ 0 ];
    }
    else
    {
        n_characters_defined = 0;
        
        foreach ( player in players )
        {
            if ( isdefined( player.characterindex ) )
            {
                arrayremovevalue( charindexarray, player.characterindex, 0 );
                n_characters_defined++;
            }
        }
        
        if ( charindexarray.size > 0 )
        {
            if ( n_characters_defined == players.size - 1 )
            {
                if ( !( isdefined( level.has_richtofen ) && level.has_richtofen ) )
                {
                    level.has_richtofen = 1;
                    return 2;
                }
            }
            
            charindexarray = array::randomize( charindexarray );
            
            if ( charindexarray[ 0 ] == 2 )
            {
                level.has_richtofen = 1;
            }
            
            return charindexarray[ 0 ];
        }
    }
    
    return 0;
}

// Namespace zm_tomb
// Params 0
// Checksum 0x295b22a3, Offset: 0x50b8
// Size: 0x24
function initcharacterstartindex()
{
    level.characterstartindex = randomint( 4 );
}

// Namespace zm_tomb
// Params 0
// Checksum 0x921e5545, Offset: 0x50e8
// Size: 0x36
function zm_player_fake_death_cleanup()
{
    if ( isdefined( self._fall_down_anchor ) )
    {
        self._fall_down_anchor delete();
        self._fall_down_anchor = undefined;
    }
}

// Namespace zm_tomb
// Params 1
// Checksum 0xe376bcf6, Offset: 0x5128
// Size: 0x15a
function zm_player_fake_death( vdir )
{
    level notify( #"fake_death" );
    self notify( #"fake_death" );
    stance = self getstance();
    self.ignoreme = 1;
    self enableinvulnerability();
    self takeallweapons();
    
    if ( isdefined( self.insta_killed ) && self.insta_killed )
    {
        self zm::player_fake_death();
        self allowprone( 1 );
        self allowcrouch( 0 );
        self allowstand( 0 );
        wait 0.25;
        self freezecontrols( 1 );
        return;
    }
    
    self freezecontrols( 1 );
    self thread fall_down( vdir, stance );
    wait 1;
}

// Namespace zm_tomb
// Params 2
// Checksum 0xe76168c, Offset: 0x5290
// Size: 0x494
function fall_down( vdir, stance )
{
    self endon( #"disconnect" );
    level endon( #"game_module_ended" );
    self ghost();
    origin = self.origin;
    xyspeed = ( 0, 0, 0 );
    angles = self getplayerangles();
    angles = ( angles[ 0 ], angles[ 1 ], angles[ 2 ] + randomfloatrange( -5, 5 ) );
    
    if ( isdefined( vdir ) && length( vdir ) > 0 )
    {
        xyspeedmag = 40 + randomint( 12 ) + randomint( 12 );
        xyspeed = xyspeedmag * vectornormalize( ( vdir[ 0 ], vdir[ 1 ], 0 ) );
    }
    
    linker = spawn( "script_origin", ( 0, 0, 0 ) );
    linker.origin = origin;
    linker.angles = angles;
    self._fall_down_anchor = linker;
    self playerlinkto( linker );
    self playsoundtoplayer( "zmb_player_death_fall", self );
    falling = stance != "prone";
    
    if ( falling )
    {
        origin = playerphysicstrace( origin, origin + xyspeed );
        eye = self util::get_eye();
        floor_height = 10 + origin[ 2 ] - eye[ 2 ];
        origin += ( 0, 0, floor_height );
        lerptime = 0.5;
        linker moveto( origin, lerptime, lerptime );
        linker rotateto( angles, lerptime, lerptime );
    }
    
    self freezecontrols( 1 );
    
    if ( falling )
    {
        linker waittill( #"movedone" );
    }
    
    self giveweapon( level.weaponzmdeaththroe );
    self switchtoweapon( level.weaponzmdeaththroe );
    
    if ( falling )
    {
        bounce = randomint( 4 ) + 8;
        origin = origin + ( 0, 0, bounce ) - xyspeed * 0.1;
        lerptime = bounce / 50;
        linker moveto( origin, lerptime, 0, lerptime );
        linker waittill( #"movedone" );
        origin = origin + ( 0, 0, bounce * -1 ) + xyspeed * 0.1;
        lerptime /= 2;
        linker moveto( origin, lerptime, lerptime );
        linker waittill( #"movedone" );
        linker moveto( origin, 5, 0 );
    }
    
    wait 15;
    linker delete();
}

// Namespace zm_tomb
// Params 0
// Checksum 0xbd4666ee, Offset: 0x5730
// Size: 0xec
function offhand_weapon_overrride()
{
    zm_utility::register_lethal_grenade_for_level( "frag_grenade" );
    level.zombie_lethal_grenade_player_init = getweapon( "frag_grenade" );
    zm_utility::register_tactical_grenade_for_level( "beacon" );
    zm_utility::register_tactical_grenade_for_level( "cymbal_monkey" );
    zm_utility::register_tactical_grenade_for_level( "cymbal_monkey_upgraded" );
    zm_utility::register_melee_weapon_for_level( level.weaponbasemelee.name );
    zm_utility::register_melee_weapon_for_level( "bowie_knife" );
    level.zombie_melee_weapon_player_init = level.weaponbasemelee;
    level.zombie_equipment_player_init = undefined;
    level.equipment_safe_to_drop = &equipment_safe_to_drop;
}

// Namespace zm_tomb
// Params 1
// Checksum 0x5f9f3c98, Offset: 0x5828
// Size: 0x22, Type: bool
function equipment_safe_to_drop( weapon )
{
    if ( !isdefined( self.origin ) )
    {
        return true;
    }
    
    return true;
}

// Namespace zm_tomb
// Params 1
// Checksum 0xbd6c1b62, Offset: 0x5858
// Size: 0xbe, Type: bool
function offhand_weapon_give_override( str_weapon )
{
    self endon( #"death" );
    
    if ( zm_utility::is_tactical_grenade( str_weapon ) && isdefined( self zm_utility::get_player_tactical_grenade() ) && !self zm_utility::is_player_tactical_grenade( str_weapon ) )
    {
        self setweaponammoclip( self zm_utility::get_player_tactical_grenade(), 0 );
        self takeweapon( self zm_utility::get_player_tactical_grenade() );
    }
    
    return false;
}

// Namespace zm_tomb
// Params 0
// Checksum 0xaceaaba4, Offset: 0x5920
// Size: 0x34
function tomb_weaponobjects_on_player_connect_override()
{
    level.retrievable_knife_init_names = [];
    callback::on_connect( &zm_weapons::weaponobjects_on_player_connect_override_internal );
}

// Namespace zm_tomb
// Params 1
// Checksum 0x19af7133, Offset: 0x5960
// Size: 0x96, Type: bool
function tomb_player_intersection_tracker_override( e_player )
{
    if ( isdefined( self.b_already_on_tank ) && ( isdefined( e_player.b_already_on_tank ) && e_player.b_already_on_tank || self.b_already_on_tank ) )
    {
        return true;
    }
    
    if ( isdefined( self.giant_robot_transition ) && ( isdefined( e_player.giant_robot_transition ) && e_player.giant_robot_transition || self.giant_robot_transition ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_tomb
// Params 0
// Checksum 0x8b3ad997, Offset: 0x5a00
// Size: 0x1c
function init_tomb_stats()
{
    self zm_tomb_achievement::init_player_achievement_stats();
}

// Namespace zm_tomb
// Params 0
// Checksum 0xca6b221e, Offset: 0x5a28
// Size: 0x34
function custom_add_weapons()
{
    zm_weapons::load_weapon_spec_from_table( "gamedata/weapons/zm/zm_tomb_weapons.csv", 1 );
    zm_weapons::autofill_wallbuys_init();
}

// Namespace zm_tomb
// Params 0
// Checksum 0x85aadc54, Offset: 0x5a68
// Size: 0x1c
function custom_add_vox()
{
    zm_audio::loadplayervoicecategories( "gamedata/audio/zm/zm_tomb_vox.csv" );
}

// Namespace zm_tomb
// Params 0
// Checksum 0x9f6316a, Offset: 0x5a90
// Size: 0x64
function include_powerups()
{
    level._zombiemode_powerup_grab = &tomb_powerup_grab;
    
    /#
        setup_powerup_devgui();
    #/
    
    /#
        setup_oneinchpunch_devgui();
    #/
    
    /#
        setup_tablet_devgui();
    #/
}

// Namespace zm_tomb
// Params 0
// Checksum 0xa4e1c94a, Offset: 0x5b00
// Size: 0xf4
function include_perks_in_random_rotation()
{
    zm_perk_random::include_perk_in_random_rotation( "specialty_armorvest" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_quickrevive" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_fastreload" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_doubletap2" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_staminup" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_deadshot" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_additionalprimaryweapon" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_electriccherry" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_widowswine" );
    level.custom_random_perk_weights = &tomb_random_perk_weights;
}

// Namespace zm_tomb
// Params 2
// Checksum 0x217ced55, Offset: 0x5c00
// Size: 0x4c
function tomb_powerup_grab( s_powerup, e_player )
{
    if ( s_powerup.powerup_name == "zombie_blood" )
    {
        level thread zm_powerup_zombie_blood::zombie_blood_powerup( s_powerup, e_player );
    }
}

/#

    // Namespace zm_tomb
    // Params 0
    // Checksum 0x1fe5fd5f, Offset: 0x5c58
    // Size: 0x5c, Type: dev
    function setup_powerup_devgui()
    {
        setdvar( "<dev string:x5e>", "<dev string:x6b>" );
        adddebugcommand( "<dev string:x6f>" );
        level thread watch_devgui_zombie_blood();
    }

    // Namespace zm_tomb
    // Params 0
    // Checksum 0xcefb4e0, Offset: 0x5cc0
    // Size: 0x174, Type: dev
    function setup_oneinchpunch_devgui()
    {
        setdvar( "<dev string:xb2>", "<dev string:x6b>" );
        adddebugcommand( "<dev string:xc4>" );
        setdvar( "<dev string:x10b>", "<dev string:x6b>" );
        adddebugcommand( "<dev string:x126>" );
        setdvar( "<dev string:x17f>", "<dev string:x6b>" );
        adddebugcommand( "<dev string:x195>" );
        setdvar( "<dev string:x1e4>", "<dev string:x6b>" );
        adddebugcommand( "<dev string:x1fb>" );
        setdvar( "<dev string:x24c>", "<dev string:x6b>" );
        adddebugcommand( "<dev string:x262>" );
        setdvar( "<dev string:x2b1>", "<dev string:x6b>" );
        adddebugcommand( "<dev string:x2cd>" );
        level thread watch_devgui_oneinchpunch();
    }

    // Namespace zm_tomb
    // Params 0
    // Checksum 0x2701a74a, Offset: 0x5e40
    // Size: 0x5d0, Type: dev
    function watch_devgui_oneinchpunch()
    {
        while ( true )
        {
            if ( getdvarstring( "<dev string:xb2>" ) == "<dev string:x328>" )
            {
                setdvar( "<dev string:xb2>", "<dev string:x6b>" );
                
                foreach ( player in getplayers() )
                {
                    player thread _zm_weap_one_inch_punch::one_inch_punch_melee_attack();
                }
            }
            else if ( getdvarstring( "<dev string:x10b>" ) == "<dev string:x328>" )
            {
                setdvar( "<dev string:x10b>", "<dev string:x6b>" );
                
                foreach ( player in getplayers() )
                {
                    player.b_punch_upgraded = 1;
                    player.str_punch_element = "<dev string:x32b>";
                    player thread _zm_weap_one_inch_punch::one_inch_punch_melee_attack();
                }
            }
            else if ( getdvarstring( "<dev string:x17f>" ) == "<dev string:x328>" )
            {
                setdvar( "<dev string:x17f>", "<dev string:x6b>" );
                
                foreach ( player in getplayers() )
                {
                    player.b_punch_upgraded = 1;
                    player.str_punch_element = "<dev string:x334>";
                    player thread _zm_weap_one_inch_punch::one_inch_punch_melee_attack();
                }
            }
            else if ( getdvarstring( "<dev string:x1e4>" ) == "<dev string:x328>" )
            {
                setdvar( "<dev string:x1e4>", "<dev string:x6b>" );
                
                foreach ( player in getplayers() )
                {
                    player.b_punch_upgraded = 1;
                    player.str_punch_element = "<dev string:x338>";
                    player thread _zm_weap_one_inch_punch::one_inch_punch_melee_attack();
                }
            }
            else if ( getdvarstring( "<dev string:x24c>" ) == "<dev string:x328>" )
            {
                setdvar( "<dev string:x24c>", "<dev string:x6b>" );
                
                foreach ( player in getplayers() )
                {
                    player.b_punch_upgraded = 1;
                    player.str_punch_element = "<dev string:x33d>";
                    player thread _zm_weap_one_inch_punch::one_inch_punch_melee_attack();
                }
            }
            else if ( getdvarstring( "<dev string:x2b1>" ) == "<dev string:x328>" )
            {
                setdvar( "<dev string:x2b1>", "<dev string:x6b>" );
                
                foreach ( player in getplayers() )
                {
                    player.b_punch_upgraded = 1;
                    player.str_punch_element = "<dev string:x341>";
                    player thread _zm_weap_one_inch_punch::one_inch_punch_melee_attack();
                }
            }
            
            wait 0.1;
        }
    }

    // Namespace zm_tomb
    // Params 0
    // Checksum 0xb42c4a0e, Offset: 0x6418
    // Size: 0x8c, Type: dev
    function setup_tablet_devgui()
    {
        setdvar( "<dev string:x34b>", "<dev string:x35e>" );
        adddebugcommand( "<dev string:x360>" );
        adddebugcommand( "<dev string:x3a4>" );
        adddebugcommand( "<dev string:x3e9>" );
        level thread watch_devgui_tablet();
    }

    // Namespace zm_tomb
    // Params 0
    // Checksum 0x8ecc5316, Offset: 0x64b0
    // Size: 0xe0, Type: dev
    function watch_devgui_tablet()
    {
        while ( true )
        {
            if ( getdvarstring( "<dev string:x34b>" ) != "<dev string:x35e>" )
            {
                player = getplayers()[ 0 ];
                n_tablet_state = int( getdvarint( "<dev string:x34b>" ) );
                player clientfield::set_to_player( "<dev string:x42e>", n_tablet_state );
                setdvar( "<dev string:x34b>", "<dev string:x35e>" );
            }
            
            wait 0.1;
        }
    }

    // Namespace zm_tomb
    // Params 0
    // Checksum 0x2d7d2fce, Offset: 0x6598
    // Size: 0x88, Type: dev
    function watch_devgui_zombie_blood()
    {
        while ( true )
        {
            if ( getdvarstring( "<dev string:x5e>" ) == "<dev string:x328>" )
            {
                setdvar( "<dev string:x5e>", "<dev string:x6b>" );
                level thread zm_devgui::zombie_devgui_give_powerup( "<dev string:x5e>", 1 );
            }
            
            wait 0.1;
        }
    }

    // Namespace zm_tomb
    // Params 0
    // Checksum 0x946e420e, Offset: 0x6628
    // Size: 0xa0, Type: dev
    function watch_devgui_double_points()
    {
        while ( true )
        {
            if ( getdvarstring( "<dev string:x442>" ) == "<dev string:x328>" )
            {
                setdvar( "<dev string:x442>", "<dev string:x6b>" );
                level thread zm_devgui::zombie_devgui_give_powerup( "<dev string:x442>", 1 );
                iprintlnbold( "<dev string:x450>" );
            }
            
            wait 0.1;
        }
    }

#/

// Namespace zm_tomb
// Params 0
// Checksum 0x2a3e7409, Offset: 0x66d0
// Size: 0x84
function setup_rex_starts()
{
    zm_utility::add_gametype( "zclassic", &dummy, "zclassic", &dummy );
    zm_utility::add_gameloc( "tomb", &dummy, "tomb", &dummy );
}

// Namespace zm_tomb
// Params 0
// Checksum 0x99ec1590, Offset: 0x6760
// Size: 0x4
function dummy()
{
    
}

// Namespace zm_tomb
// Params 0
// Checksum 0xa91bad30, Offset: 0x6770
// Size: 0x19ec
function working_zone_init()
{
    level flag::init( "always_on" );
    level flag::set( "always_on" );
    zm_zonemgr::add_adjacent_zone( "zone_robot_head", "zone_robot_head", "always_on" );
    zm_zonemgr::add_adjacent_zone( "zone_start", "zone_start_a", "always_on" );
    zm_zonemgr::add_adjacent_zone( "zone_start", "zone_start_b", "always_on" );
    zm_zonemgr::add_adjacent_zone( "zone_start_a", "zone_start_b", "always_on" );
    zm_zonemgr::add_adjacent_zone( "zone_start_a", "zone_bunker_1a", "activate_zone_bunker_1" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_1a", "zone_bunker_1", "activate_zone_bunker_1" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_1a", "zone_bunker_1", "activate_zone_bunker_3a" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_1", "zone_bunker_3a", "activate_zone_bunker_3a" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_3a", "zone_bunker_3b", "activate_zone_bunker_3a" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_3a", "zone_bunker_3b", "activate_zone_bunker_3b" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_3b", "zone_bunker_5a", "activate_zone_bunker_3b" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_5a", "zone_bunker_5b", "activate_zone_bunker_3b" );
    zm_zonemgr::add_adjacent_zone( "zone_start_b", "zone_bunker_2a", "activate_zone_bunker_2" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_2a", "zone_bunker_2", "activate_zone_bunker_2" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_2a", "zone_bunker_2", "activate_zone_bunker_4a" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_2", "zone_bunker_4a", "activate_zone_bunker_4a" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4a", "zone_bunker_4b", "activate_zone_bunker_4a" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4a", "zone_bunker_4c", "activate_zone_bunker_4a" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4b", "zone_bunker_4f", "activate_zone_bunker_4a" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4c", "zone_bunker_4d", "activate_zone_bunker_4a" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4c", "zone_bunker_4e", "activate_zone_bunker_4a" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4e", "zone_bunker_tank_c1", "activate_zone_bunker_4a" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4e", "zone_bunker_tank_d", "activate_zone_bunker_4a" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_c", "zone_bunker_tank_c1", "activate_zone_bunker_4a" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_d", "zone_bunker_tank_d1", "activate_zone_bunker_4a" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4a", "zone_bunker_4b", "activate_zone_bunker_4b" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4a", "zone_bunker_4c", "activate_zone_bunker_4b" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4b", "zone_bunker_4f", "activate_zone_bunker_4b" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4c", "zone_bunker_4d", "activate_zone_bunker_4b" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4c", "zone_bunker_4e", "activate_zone_bunker_4b" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4b", "zone_bunker_5a", "activate_zone_bunker_4b" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_5a", "zone_bunker_5b", "activate_zone_bunker_4b" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4e", "zone_bunker_tank_c1", "activate_zone_bunker_4b" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4e", "zone_bunker_tank_d", "activate_zone_bunker_4b" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_c", "zone_bunker_tank_c1", "activate_zone_bunker_4b" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_d", "zone_bunker_tank_d1", "activate_zone_bunker_4b" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_a", "zone_nml_7", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_a", "zone_nml_7a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_a", "zone_bunker_tank_a1", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_a1", "zone_bunker_tank_a2", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_a1", "zone_bunker_tank_b", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_b", "zone_bunker_tank_c", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_c", "zone_bunker_tank_c1", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_d", "zone_bunker_tank_d1", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_d1", "zone_bunker_tank_e", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_e", "zone_bunker_tank_e1", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_e1", "zone_bunker_tank_e2", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_e1", "zone_bunker_tank_f", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_f", "zone_nml_1", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_5b", "zone_nml_2a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_0", "zone_nml_1", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_0", "zone_nml_farm", "activate_zone_farm" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_1", "zone_nml_2", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_1", "zone_nml_4", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_1", "zone_nml_20", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_2", "zone_nml_2a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_2", "zone_nml_2b", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_2", "zone_nml_3", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_3", "zone_nml_4", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_3", "zone_nml_13", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_4", "zone_nml_5", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_4", "zone_nml_13", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_5", "zone_nml_farm", "activate_zone_farm" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_6", "zone_nml_2b", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_6", "zone_nml_7", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_6", "zone_nml_7a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_6", "zone_nml_8", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_7", "zone_nml_7a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_7", "zone_nml_9", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_7", "zone_nml_10", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_8", "zone_nml_10a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_8", "zone_nml_14", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_8", "zone_nml_16", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_9", "zone_nml_7a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_9", "zone_nml_9a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_9", "zone_nml_11", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_10", "zone_nml_10a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_10", "zone_nml_11", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_10a", "zone_nml_12", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_10a", "zone_village_4", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_11", "zone_nml_9a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_11", "zone_nml_11a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_11", "zone_nml_12", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_12", "zone_nml_11a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_12", "zone_nml_12a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_13", "zone_nml_15", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_14", "zone_nml_15", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_15", "zone_nml_17", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_15a", "zone_nml_14", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_15a", "zone_nml_15", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_16", "zone_nml_2b", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_16", "zone_nml_16a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_16", "zone_nml_18", "activate_zone_ruins" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_17", "zone_nml_17a", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_17", "zone_nml_18", "activate_zone_ruins" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_18", "zone_nml_19", "activate_zone_ruins" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_farm", "zone_nml_celllar", "activate_zone_farm" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_farm", "zone_nml_farm_1", "activate_zone_farm" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_19", "ug_bottom_zone", "activate_zone_crypt" );
    zm_zonemgr::add_adjacent_zone( "zone_village_0", "zone_nml_15", "activate_zone_village_0" );
    zm_zonemgr::add_adjacent_zone( "zone_village_0", "zone_village_4b", "activate_zone_village_0" );
    zm_zonemgr::add_adjacent_zone( "zone_village_1", "zone_village_1a", "activate_zone_village_0" );
    zm_zonemgr::add_adjacent_zone( "zone_village_1", "zone_village_2", "activate_zone_village_1" );
    zm_zonemgr::add_adjacent_zone( "zone_village_1", "zone_village_4b", "activate_zone_village_0" );
    zm_zonemgr::add_adjacent_zone( "zone_village_1", "zone_village_5b", "activate_zone_village_0" );
    zm_zonemgr::add_adjacent_zone( "zone_village_2", "zone_village_3", "activate_zone_village_1" );
    zm_zonemgr::add_adjacent_zone( "zone_village_3", "zone_village_3a", "activate_zone_village_1" );
    zm_zonemgr::add_adjacent_zone( "zone_village_3", "zone_ice_stairs", "activate_zone_village_1" );
    zm_zonemgr::add_adjacent_zone( "zone_ice_stairs", "zone_ice_stairs_1", "activate_zone_village_1" );
    zm_zonemgr::add_adjacent_zone( "zone_village_3a", "zone_village_3b", "activate_zone_village_1" );
    zm_zonemgr::add_adjacent_zone( "zone_village_4", "zone_nml_14", "activate_zone_village_0" );
    zm_zonemgr::add_adjacent_zone( "zone_village_4", "zone_village_4a", "activate_zone_village_0" );
    zm_zonemgr::add_adjacent_zone( "zone_village_4", "zone_village_4b", "activate_zone_village_0" );
    zm_zonemgr::add_adjacent_zone( "zone_village_5", "zone_nml_4", "activate_zone_village_0" );
    zm_zonemgr::add_adjacent_zone( "zone_village_5", "zone_village_5a", "activate_zone_village_0" );
    zm_zonemgr::add_adjacent_zone( "zone_village_5a", "zone_village_5b", "activate_zone_village_0" );
    zm_zonemgr::add_adjacent_zone( "zone_village_6", "zone_village_5b", "activate_zone_village_0" );
    zm_zonemgr::add_adjacent_zone( "zone_village_6", "zone_village_6a", "activate_zone_village_0" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_0", "zone_chamber_1", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_0", "zone_chamber_3", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_0", "zone_chamber_4", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_1", "zone_chamber_2", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_1", "zone_chamber_3", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_1", "zone_chamber_4", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_1", "zone_chamber_5", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_2", "zone_chamber_4", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_2", "zone_chamber_5", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_3", "zone_chamber_4", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_3", "zone_chamber_6", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_3", "zone_chamber_7", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_4", "zone_chamber_5", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_4", "zone_chamber_6", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_4", "zone_chamber_7", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_4", "zone_chamber_8", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_5", "zone_chamber_7", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_5", "zone_chamber_8", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_6", "zone_chamber_7", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_chamber_7", "zone_chamber_8", "activate_zone_chamber" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_1", "zone_bunker_1a", "activate_zone_bunker_1_tank" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_1a", "zone_fire_stairs", "activate_zone_bunker_1_tank" );
    zm_zonemgr::add_adjacent_zone( "zone_fire_stairs", "zone_fire_stairs_1", "activate_zone_bunker_1_tank" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_2", "zone_bunker_2a", "activate_zone_bunker_2_tank" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4a", "zone_bunker_4b", "activate_zone_bunker_4_tank" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4a", "zone_bunker_4c", "activate_zone_bunker_4_tank" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4c", "zone_bunker_4d", "activate_zone_bunker_4_tank" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4c", "zone_bunker_4e", "activate_zone_bunker_4_tank" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4e", "zone_bunker_tank_c1", "activate_zone_bunker_4_tank" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_4e", "zone_bunker_tank_d", "activate_zone_bunker_4_tank" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_c", "zone_bunker_tank_c1", "activate_zone_bunker_4_tank" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_d", "zone_bunker_tank_d1", "activate_zone_bunker_4_tank" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_tank_b", "zone_bunker_6", "activate_zone_bunker_6_tank" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_1", "zone_bunker_6", "activate_zone_bunker_6_tank" );
    level thread activate_zone_trig( "trig_zone_bunker_1", "activate_zone_bunker_1_tank" );
    level thread activate_zone_trig( "trig_zone_bunker_2", "activate_zone_bunker_2_tank" );
    level thread activate_zone_trig( "trig_zone_bunker_4", "activate_zone_bunker_4_tank" );
    level thread activate_zone_trig( "trig_zone_bunker_6", "activate_zone_bunker_6_tank", "activate_zone_bunker_1_tank" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_1a", "zone_fire_stairs", "activate_zone_bunker_1" );
    zm_zonemgr::add_adjacent_zone( "zone_fire_stairs", "zone_fire_stairs_1", "activate_zone_bunker_1" );
    zm_zonemgr::add_adjacent_zone( "zone_bunker_1a", "zone_fire_stairs", "activate_zone_bunker_3a" );
    zm_zonemgr::add_adjacent_zone( "zone_fire_stairs", "zone_fire_stairs_1", "activate_zone_bunker_3a" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_9", "zone_air_stairs", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_air_stairs", "zone_air_stairs_1", "activate_zone_nml" );
    zm_zonemgr::add_adjacent_zone( "zone_nml_celllar", "zone_bolt_stairs", "activate_zone_farm" );
    zm_zonemgr::add_adjacent_zone( "zone_bolt_stairs", "zone_bolt_stairs_1", "activate_zone_farm" );
}

// Namespace zm_tomb
// Params 3
// Checksum 0x81707589, Offset: 0x8168
// Size: 0xb4
function activate_zone_trig( str_name, str_zone1, str_zone2 )
{
    trig = getent( str_name, "targetname" );
    trig waittill( #"trigger" );
    
    if ( isdefined( str_zone1 ) )
    {
        level flag::set( str_zone1 );
    }
    
    if ( isdefined( str_zone2 ) )
    {
        level flag::set( str_zone2 );
    }
    
    trig delete();
}

// Namespace zm_tomb
// Params 0
// Checksum 0xf27d1bb5, Offset: 0x8228
// Size: 0x5c
function check_tank_platform_zone()
{
    while ( true )
    {
        level waittill( #"newzoneactive", activezone );
        
        if ( activezone == "zone_bunker_3" )
        {
            break;
        }
        
        wait 1;
    }
    
    level flag::set( "activate_zone_nml" );
}

// Namespace zm_tomb
// Params 13
// Checksum 0xf3c3f015, Offset: 0x8290
// Size: 0x9a
function tomb_vehicle_damage_override_wrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname )
{
    if ( isdefined( level.a_func_vehicle_damage_override[ self.vehicletype ] ) )
    {
        return level.a_func_vehicle_damage_override[ self.vehicletype ];
    }
    
    return idamage;
}

// Namespace zm_tomb
// Params 0
// Checksum 0x4322a9ce, Offset: 0x8338
// Size: 0x188
function drop_all_barriers()
{
    zkeys = getarraykeys( level.zones );
    
    for ( z = 0; z < level.zones.size ; z++ )
    {
        zbarriers = get_all_zone_zbarriers( zkeys[ z ] );
        
        if ( !isdefined( zbarriers ) )
        {
            continue;
        }
        
        foreach ( zbarrier in zbarriers )
        {
            zbarrier_pieces = zbarrier getnumzbarrierpieces();
            
            for ( i = 0; i < zbarrier_pieces ; i++ )
            {
                zbarrier hidezbarrierpiece( i );
                zbarrier setzbarrierpiecestate( i, "open" );
            }
            
            wait 0.05;
        }
    }
}

// Namespace zm_tomb
// Params 1
// Checksum 0x2a2ea32, Offset: 0x84c8
// Size: 0x42
function get_all_zone_zbarriers( zone_name )
{
    if ( !isdefined( zone_name ) )
    {
        return undefined;
    }
    
    zone = level.zones[ zone_name ];
    return zone.zbarriers;
}

// Namespace zm_tomb
// Params 1
// Checksum 0x6d9ef7a5, Offset: 0x8518
// Size: 0x9e, Type: bool
function tomb_special_weapon_magicbox_check( weapon )
{
    if ( weapon.name == "beacon" )
    {
        if ( isdefined( self.beacon_ready ) && self.beacon_ready )
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    if ( isdefined( level.zombie_weapons[ weapon ].shared_ammo_weapon ) )
    {
        if ( self zm_weapons::has_weapon_or_upgrade( level.zombie_weapons[ weapon ].shared_ammo_weapon ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_tomb
// Params 15
// Checksum 0xa20fba0a, Offset: 0x85c0
// Size: 0x310
function tomb_actor_damage_override_wrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal )
{
    if ( isdefined( self.b_zombie_blood_damage_only ) && self.b_zombie_blood_damage_only )
    {
        if ( !isplayer( eattacker ) || !eattacker.zombie_vars[ "zombie_powerup_zombie_blood_on" ] )
        {
            return 0;
        }
    }
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "capture_zombie" && isdefined( eattacker ) && isplayer( eattacker ) )
    {
        if ( idamage >= self.health )
        {
            if ( 100 * level.round_number > eattacker.n_capture_zombie_points )
            {
                eattacker zm_score::player_add_points( "rebuild_board", 10 );
                eattacker.n_capture_zombie_points += 10;
            }
        }
    }
    
    return_val = self zm::actor_damage_override_wrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal );
    
    if ( self.health <= 0 )
    {
        if ( weapon.name == "zombie_markiv_cannon" && smeansofdeath == "MOD_CRUSH" )
        {
            self thread zm_tomb_utility::zombie_gib_guts();
        }
        else if ( isdefined( self.b_climbing_tank ) && ( isdefined( self.b_on_tank ) && self.b_on_tank || self.b_climbing_tank ) )
        {
            self zm_tomb_tank::zombie_on_tank_death_animscript_callback( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal );
        }
        
        if ( isdefined( eattacker ) && isdefined( eattacker.targetname ) && eattacker.targetname == "quadrotor_ai" )
        {
            eattacker thread zm_tomb_vo::function_860b0710();
        }
    }
    
    return return_val;
}

// Namespace zm_tomb
// Params 1
// Checksum 0x221ad21f, Offset: 0x88d8
// Size: 0xd4
function tomb_zombie_death_event_callback( attacker )
{
    if ( isdefined( self ) && isdefined( self.damagelocation ) && isdefined( self.damagemod ) && isdefined( self.damageweapon ) && isdefined( self.attacker ) && isplayer( self.attacker ) )
    {
        if ( zm_utility::is_headshot( self.damageweapon, self.damagelocation, self.damagemod ) && zm_challenges_tomb::challenge_exists( "zc_headshots" ) && !( self.script_noteworthy === "capture_zombie" ) )
        {
            self.attacker zm_challenges_tomb::increment_stat( "zc_headshots" );
        }
    }
}

// Namespace zm_tomb
// Params 0
// Checksum 0xf48a0d04, Offset: 0x89b8
// Size: 0x10
function zombie_init_done()
{
    self.allowpain = 0;
}

// Namespace zm_tomb
// Params 1
// Checksum 0x2f926176, Offset: 0x89d0
// Size: 0x66, Type: bool
function tomb_validate_enemy_path_length( player )
{
    max_dist = 1296;
    d = distancesquared( self.origin, player.origin );
    
    if ( d <= max_dist )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_tomb
// Params 0
// Checksum 0x9029e003, Offset: 0x8a40
// Size: 0x9e
function show_zombie_count()
{
    self endon( #"death_or_disconnect" );
    level flag::wait_till( "start_zombie_round_logic" );
    
    while ( true )
    {
        n_round_zombies = zombie_utility::get_current_zombie_count();
        str_hint = "Alive: " + n_round_zombies + ". To Spawn: " + level.zombie_total;
        
        /#
            iprintlnbold( str_hint );
        #/
        
        wait 5;
    }
}

// Namespace zm_tomb
// Params 0
// Checksum 0x7a387d0a, Offset: 0x8ae8
// Size: 0x222
function tomb_custom_electric_cherry_laststand()
{
    visionsetlaststand( "zombie_last_stand", 1 );
    
    if ( isdefined( self ) )
    {
        playfx( level._effect[ "electric_cherry_explode" ], self.origin );
        self playsound( "zmb_cherry_explode" );
        self notify( #"electric_cherry_start" );
        wait 0.05;
        a_zombies = getaispeciesarray( "axis", "all" );
        a_zombies = util::get_array_of_closest( self.origin, a_zombies, undefined, undefined, 500 );
        
        for ( i = 0; i < a_zombies.size ; i++ )
        {
            if ( isalive( self ) )
            {
                if ( a_zombies[ i ].health <= 1000 )
                {
                    a_zombies[ i ] thread zm_perk_electric_cherry::electric_cherry_death_fx();
                    
                    if ( isdefined( self.cherry_kills ) )
                    {
                        self.cherry_kills++;
                    }
                    
                    self zm_score::add_to_player_score( 40 );
                }
                else
                {
                    a_zombies[ i ] thread zm_perk_electric_cherry::electric_cherry_stun();
                    a_zombies[ i ] thread zm_perk_electric_cherry::electric_cherry_shock_fx();
                }
                
                wait 0.1;
                a_zombies[ i ] dodamage( 1000, self.origin, self, self, "none" );
            }
        }
        
        self notify( #"electric_cherry_end" );
    }
}

// Namespace zm_tomb
// Params 0
// Checksum 0x50e5ea00, Offset: 0x8d18
// Size: 0x4b6
function tomb_custom_electric_cherry_reload_attack()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"stop_electric_cherry_reload_attack" );
    self.wait_on_reload = [];
    self.consecutive_electric_cherry_attacks = 0;
    
    while ( true )
    {
        self waittill( #"reload_start" );
        w_current_weapon = self getcurrentweapon();
        
        if ( isinarray( self.wait_on_reload, w_current_weapon ) )
        {
            continue;
        }
        
        self.wait_on_reload[ self.wait_on_reload.size ] = w_current_weapon;
        self.consecutive_electric_cherry_attacks++;
        n_clip_current = self getweaponammoclip( w_current_weapon );
        n_clip_max = w_current_weapon.clipsize;
        n_fraction = n_clip_current / n_clip_max;
        perk_radius = math::linear_map( n_fraction, 1, 0, 32, 128 );
        perk_dmg = math::linear_map( n_fraction, 1, 0, 1, 1045 );
        self thread zm_perk_electric_cherry::check_for_reload_complete( w_current_weapon );
        
        if ( isdefined( self ) )
        {
            switch ( self.consecutive_electric_cherry_attacks )
            {
                case 0:
                case 1:
                    n_zombie_limit = undefined;
                    break;
                case 2:
                    n_zombie_limit = 8;
                    break;
                case 3:
                    n_zombie_limit = 4;
                    break;
                case 4:
                    n_zombie_limit = 2;
                    break;
                default:
                    n_zombie_limit = 0;
                    break;
            }
            
            self thread zm_perk_electric_cherry::electric_cherry_cooldown_timer( w_current_weapon );
            
            if ( isdefined( n_zombie_limit ) && n_zombie_limit == 0 )
            {
                continue;
            }
            
            self thread zm_perk_electric_cherry::electric_cherry_reload_fx( n_fraction );
            self notify( #"electric_cherry_start" );
            self playsound( "zmb_cherry_explode" );
            a_zombies = getaispeciesarray( "axis", "all" );
            a_zombies = util::get_array_of_closest( self.origin, a_zombies, undefined, undefined, perk_radius );
            n_zombies_hit = 0;
            
            for ( i = 0; i < a_zombies.size ; i++ )
            {
                if ( isalive( self ) && isalive( a_zombies[ i ] ) )
                {
                    if ( isdefined( n_zombie_limit ) )
                    {
                        if ( n_zombies_hit < n_zombie_limit )
                        {
                            n_zombies_hit++;
                        }
                        else
                        {
                            break;
                        }
                    }
                    
                    if ( a_zombies[ i ].health <= perk_dmg )
                    {
                        a_zombies[ i ] thread zm_perk_electric_cherry::electric_cherry_death_fx();
                        
                        if ( isdefined( self.cherry_kills ) )
                        {
                            self.cherry_kills++;
                        }
                        
                        self zm_score::add_to_player_score( 40 );
                    }
                    else
                    {
                        if ( !isdefined( a_zombies[ i ].is_mechz ) )
                        {
                            a_zombies[ i ] thread zm_perk_electric_cherry::electric_cherry_stun();
                        }
                        
                        a_zombies[ i ] thread zm_perk_electric_cherry::electric_cherry_shock_fx();
                    }
                    
                    wait 0.1;
                    
                    if ( isalive( a_zombies[ i ] ) )
                    {
                        a_zombies[ i ] dodamage( perk_dmg, self.origin, self, self, "none" );
                    }
                }
            }
            
            self notify( #"electric_cherry_end" );
        }
    }
}

// Namespace zm_tomb
// Params 0
// Checksum 0x12c46d, Offset: 0x91d8
// Size: 0x1ac
function tomb_custom_player_track_ammo_count()
{
    self notify( #"stop_ammo_tracking" );
    self endon( #"disconnect" );
    self endon( #"stop_ammo_tracking" );
    ammolowcount = 0;
    ammooutcount = 0;
    
    while ( true )
    {
        wait 0.5;
        weap = self getcurrentweapon();
        
        if ( !isdefined( weap ) || weap == level.weaponnone || !tomb_can_track_ammo_custom( weap ) )
        {
            continue;
        }
        
        if ( self getammocount( weap ) > 5 || self laststand::player_is_in_laststand() )
        {
            ammooutcount = 0;
            ammolowcount = 0;
            continue;
        }
        
        if ( self getammocount( weap ) > 0 )
        {
            if ( ammolowcount < 1 )
            {
                self zm_audio::create_and_play_dialog( "general", "ammo_low" );
                ammolowcount++;
            }
        }
        else if ( ammooutcount < 1 )
        {
            self zm_audio::create_and_play_dialog( "general", "ammo_out" );
            ammooutcount++;
        }
        
        wait 20;
    }
}

// Namespace zm_tomb
// Params 1
// Checksum 0x843d9b54, Offset: 0x9390
// Size: 0x18e, Type: bool
function tomb_can_track_ammo_custom( weap )
{
    if ( !isdefined( weap ) )
    {
        return false;
    }
    
    switch ( weap.name )
    {
        case "death_throe":
        case "equip_dieseldrone":
        case "falling_hands_tomb":
        case "hero_annihilator":
        case "minigun":
        case "no_hands":
        case "none":
        case "one_inch_punch":
        case "one_inch_punch_air":
        case "one_inch_punch_fire":
        case "one_inch_punch_ice":
        case "one_inch_punch_lightning":
        case "one_inch_punch_upgraded":
        case "riotshield":
        case "staff_revive":
        case "zombie_bowie_flourish":
        case "zombie_builder":
        case "zombie_fists":
        case "zombie_knuckle_crack":
        case "zombie_one_inch_punch_flourish":
        case "zombie_one_inch_punch_upgrade_flourish":
            return false;
        default:
            if ( weap.isperkbottle || zm_utility::is_placeable_mine( weap ) || zm_equipment::is_equipment( weap ) || issubstr( weap.name, "knife_ballistic_" ) || getsubstr( weap.name, 0, 3 ) == "gl_" )
            {
                return false;
            }
            
            break;
    }
    
    return true;
}

// Namespace zm_tomb
// Params 0
// Checksum 0xf90fae3b, Offset: 0x9528
// Size: 0x27e
function function_89182d9b()
{
    level.machine_assets[ "specialty_additionalprimaryweapon" ].power_on_callback = &zm_tomb_capture_zones::custom_vending_power_on;
    level.machine_assets[ "specialty_additionalprimaryweapon" ].power_off_callback = &zm_tomb_capture_zones::custom_vending_power_off;
    level.machine_assets[ "specialty_armorvest" ].power_on_callback = &zm_tomb_capture_zones::custom_vending_power_on;
    level.machine_assets[ "specialty_armorvest" ].power_off_callback = &zm_tomb_capture_zones::custom_vending_power_off;
    level.machine_assets[ "specialty_fastreload" ].power_on_callback = &zm_tomb_capture_zones::custom_vending_power_on;
    level.machine_assets[ "specialty_fastreload" ].power_off_callback = &zm_tomb_capture_zones::custom_vending_power_off;
    level.machine_assets[ "specialty_quickrevive" ].power_on_callback = &zm_tomb_capture_zones::custom_vending_power_on;
    level.machine_assets[ "specialty_quickrevive" ].power_off_callback = &zm_tomb_capture_zones::custom_vending_power_off;
    level.machine_assets[ "specialty_staminup" ].power_on_callback = &zm_tomb_capture_zones::custom_vending_power_on;
    level.machine_assets[ "specialty_staminup" ].power_off_callback = &zm_tomb_capture_zones::custom_vending_power_off;
    level flag::wait_till( "start_zombie_round_logic" );
    wait 0.5;
    
    foreach ( var_3b5635b9 in level.powered_items )
    {
        if ( var_3b5635b9.target.script_noteworthy != "pack_a_punch" )
        {
            var_3b5635b9.power_on_func = &zm_tomb_capture_zones::custom_vending_power_on;
            var_3b5635b9.power_off_func = &zm_tomb_capture_zones::custom_vending_power_off;
        }
    }
}

// Namespace zm_tomb
// Params 0
// Checksum 0x4eb0f63f, Offset: 0x97b0
// Size: 0x4c
function function_67268668()
{
    level.machine_assets[ "specialty_quickrevive" ].off_model = "p7_zm_ori_vending_revive";
    level.machine_assets[ "specialty_quickrevive" ].on_model = "p7_zm_ori_vending_revive";
}

// Namespace zm_tomb
// Params 0
// Checksum 0xddd353e0, Offset: 0x9808
// Size: 0x34
function init_sounds()
{
    level thread custom_add_vox();
    level thread zm_tomb_vo::init_level_specific_audio();
}

// Namespace zm_tomb
// Params 0
// Checksum 0x9b29891c, Offset: 0x9848
// Size: 0x7b4
function setupmusic()
{
    zm_audio::musicstate_create( "round_start", 3, "round_start_tomb_1", "round_start_tomb_2", "round_start_tomb_3", "round_start_tomb_4" );
    zm_audio::musicstate_create( "round_start_short", 3, "round_start_tomb_1", "round_start_tomb_2", "round_start_tomb_3", "round_start_tomb_4" );
    zm_audio::musicstate_create( "round_start_first", 3, "round_start_tomb_first" );
    zm_audio::musicstate_create( "round_end", 3, "round_end_tomb_1" );
    zm_audio::musicstate_create( "aether", 4, "aether" );
    zm_audio::musicstate_create( "archangel", 4, "archangel" );
    zm_audio::musicstate_create( "shepherd_of_fire", 4, "shepherd_of_fire" );
    zm_audio::musicstate_create( "sam", 4, "sam" );
    zm_audio::musicstate_create( "game_over", 5, "game_over_zhd_tomb" );
    zm_audio::musicstate_create( "round_start_recap", 3, "round_start_recap" );
    zm_audio::musicstate_create( "round_end_recap", 3, "round_end_recap" );
    zm_audio::musicstate_create( "zone_nml_18", 4, "location_hilltop" );
    zm_audio::musicstate_create( "zone_village_2", 4, "location_church" );
    zm_audio::musicstate_create( "ug_bottom_zone", 4, "location_crypt" );
    zm_audio::musicstate_create( "zone_robot_head", 4, "location_robot" );
    zm_audio::musicstate_create( "zone_air_stairs", 4, "location_cave_air" );
    zm_audio::musicstate_create( "zone_ice_stairs", 4, "location_cave_ice" );
    zm_audio::musicstate_create( "zone_bolt_stairs", 4, "location_cave_lightning" );
    zm_audio::musicstate_create( "zone_fire_stairs", 4, "location_cave_fire" );
    zm_audio::musicstate_create( "mus_event_first_door", 4, "location_firstdoor" );
    zm_audio::musicstate_create( "mus_event_second_door", 4, "location_seconddoor" );
    zm_audio::musicstate_create( "generator_1", 2, "event_generator_1" );
    zm_audio::musicstate_create( "generator_2", 2, "event_generator_2" );
    zm_audio::musicstate_create( "generator_3", 2, "event_generator_3" );
    zm_audio::musicstate_create( "generator_4", 2, "event_generator_4" );
    zm_audio::musicstate_create( "generator_5", 2, "event_generator_5" );
    zm_audio::musicstate_create( "generator_6", 2, "event_generator_6" );
    zm_audio::musicstate_create( "staff_air", 2, "staff_air" );
    zm_audio::musicstate_create( "staff_air_upgraded", 2, "staff_air_upg" );
    zm_audio::musicstate_create( "staff_fire", 2, "staff_fire" );
    zm_audio::musicstate_create( "staff_fire_upgraded", 2, "staff_fire_upg" );
    zm_audio::musicstate_create( "staff_ice", 2, "staff_ice" );
    zm_audio::musicstate_create( "staff_ice_upgraded", 2, "staff_ice_upg" );
    zm_audio::musicstate_create( "staff_lightning", 2, "staff_lightning" );
    zm_audio::musicstate_create( "staff_lightning_upgraded", 2, "staff_lightning_upg" );
    zm_audio::musicstate_create( "staff_all_upgraded", 2, "staff_all" );
    zm_audio::musicstate_create( "side_sting_1", 2, "side_sting_1" );
    zm_audio::musicstate_create( "side_sting_2", 2, "side_sting_2" );
    zm_audio::musicstate_create( "side_sting_3", 2, "side_sting_3" );
    zm_audio::musicstate_create( "side_sting_4", 2, "side_sting_4" );
    zm_audio::musicstate_create( "side_sting_5", 2, "side_sting_5" );
    zm_audio::musicstate_create( "side_sting_6", 2, "side_sting_6" );
    zm_audio::musicstate_create( "ee_main_1", 4, "ee_main_1" );
    zm_audio::musicstate_create( "ee_main_2", 4, "ee_main_2" );
    zm_audio::musicstate_create( "ee_main_3", 4, "ee_main_3" );
    zm_audio::musicstate_create( "ee_main_4", 4, "ee_main_4" );
    zm_audio::musicstate_create( "ee_main_5", 4, "ee_main_5" );
    zm_audio::musicstate_create( "ee_main_6", 4, "ee_main_6" );
}

// Namespace zm_tomb
// Params 0
// Checksum 0x9dc29a8d, Offset: 0xa008
// Size: 0x2e, Type: bool
function player_out_of_playable_area_override()
{
    if ( self clientfield::get_to_player( "mechz_grab" ) )
    {
        return false;
    }
    
    return true;
}

