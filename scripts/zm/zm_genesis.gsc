#using scripts/codescripts/struct;
#using scripts/shared/ai/archetype_apothicon_fury;
#using scripts/shared/ai/margwa;
#using scripts/shared/ai/mechz;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_spider;
#using scripts/zm/_electroball_grenade;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_margwa_elemental;
#using scripts/zm/_zm_ai_margwa_no_idgun;
#using scripts/zm/_zm_ai_mechz;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_auto_turret;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_fog;
#using scripts/zm/_zm_genesis_spiders;
#using scripts/zm/_zm_light_zombie;
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
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_genesis_random_weapon;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_shadow_zombie;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_ball;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weap_bowie;
#using scripts/zm/_zm_weap_dragon_scale_shield;
#using scripts/zm/_zm_weap_gravityspikes;
#using scripts/zm/_zm_weap_idgun;
#using scripts/zm/_zm_weap_octobomb;
#using scripts/zm/_zm_weap_thundergun;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/archetype_genesis_keeper_companion;
#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
#using scripts/zm/craftables/_zm_craft_shield;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/zm_genesis_achievements;
#using scripts/zm/zm_genesis_ai_spawning;
#using scripts/zm/zm_genesis_amb;
#using scripts/zm/zm_genesis_apothican;
#using scripts/zm/zm_genesis_apothicon_fury;
#using scripts/zm/zm_genesis_apothicon_god;
#using scripts/zm/zm_genesis_arena;
#using scripts/zm/zm_genesis_boss;
#using scripts/zm/zm_genesis_challenges;
#using scripts/zm/zm_genesis_cleanup_mgr;
#using scripts/zm/zm_genesis_ee_quest;
#using scripts/zm/zm_genesis_ffotd;
#using scripts/zm/zm_genesis_flinger_trap;
#using scripts/zm/zm_genesis_flingers;
#using scripts/zm/zm_genesis_fx;
#using scripts/zm/zm_genesis_gamemodes;
#using scripts/zm/zm_genesis_hope;
#using scripts/zm/zm_genesis_keeper;
#using scripts/zm/zm_genesis_keeper_companion;
#using scripts/zm/zm_genesis_margwa;
#using scripts/zm/zm_genesis_mechz;
#using scripts/zm/zm_genesis_minor_ee;
#using scripts/zm/zm_genesis_pap_quest;
#using scripts/zm/zm_genesis_portals;
#using scripts/zm/zm_genesis_power;
#using scripts/zm/zm_genesis_radios;
#using scripts/zm/zm_genesis_round_bosses;
#using scripts/zm/zm_genesis_shadowman;
#using scripts/zm/zm_genesis_skull_turret;
#using scripts/zm/zm_genesis_sound;
#using scripts/zm/zm_genesis_spiders;
#using scripts/zm/zm_genesis_timer;
#using scripts/zm/zm_genesis_traps;
#using scripts/zm/zm_genesis_undercroft_low_grav;
#using scripts/zm/zm_genesis_util;
#using scripts/zm/zm_genesis_vo;
#using scripts/zm/zm_genesis_wasp;
#using scripts/zm/zm_genesis_wearables;
#using scripts/zm/zm_genesis_wisps;
#using scripts/zm/zm_genesis_zombie;
#using scripts/zm/zm_genesis_zones;

#namespace zm_genesis;

// Namespace zm_genesis
// Params 0, eflags: 0x2
// Checksum 0x7fbcca8b, Offset: 0x2540
// Size: 0x64
function autoexec opt_in()
{
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    level.random_pandora_box_start = 1;
    level.clientfieldaicheck = 1;
    level.pack_a_punch_camo_index = 121;
    level.pack_a_punch_camo_index_number_variants = 5;
    level.ignore_vortex_ragdoll = 1;
    level.ignore_gravityspikes_ragdoll = 1;
}

// Namespace zm_genesis
// Params 0
// Checksum 0x5e4ad350, Offset: 0x25b0
// Size: 0x84
function setup_rex_starts()
{
    zm_utility::add_gametype( "zclassic", &dummy, "zclassic", &dummy );
    zm_utility::add_gameloc( "default", &dummy, "default", &dummy );
}

// Namespace zm_genesis
// Params 0
// Checksum 0x99ec1590, Offset: 0x2640
// Size: 0x4
function dummy()
{
    
}

// Namespace zm_genesis
// Params 0
// Checksum 0xcdbd2f0c, Offset: 0x2650
// Size: 0x9b4
function main()
{
    zm_genesis_ffotd::main_start();
    level thread function_9c3ef4d4();
    level._uses_sticky_grenades = 1;
    level._uses_taser_knuckles = 1;
    level flag::init( "is_coop_door_price" );
    callback::on_spawned( &on_player_spawned );
    callback::on_connect( &on_player_connected );
    callback::on_disconnect( &zm_genesis_challenges::on_player_disconnect );
    zm::register_actor_damage_callback( &function_82800a29 );
    zm::register_vehicle_damage_callback( &function_68a54382 );
    spawner::add_archetype_spawn_function( "zombie", &zm_genesis_ai_spawning::function_47b2f1f4 );
    setdvar( "doublejump_enabled", 1 );
    setdvar( "playerEnergy_enabled", 1 );
    setdvar( "wallrun_enabled", 1 );
    setdvar( "waypointVerticalSeparation", -2001 );
    setdvar( "bg_freeCamClipMaxDist", 4000 );
    level.debug_keyline_zombies = 0;
    level construct_idgun_weapon_array();
    zm::init_fx();
    zm_genesis_fx::main();
    zm_genesis_amb::main();
    setdvar( "zm_wasp_open_spawning", 1 );
    zm_genesis_wasp::init();
    zm_genesis_apothicon_fury::function_51dd865c();
    zm_genesis_keeper::function_51dd865c();
    zm_genesis_keeper_companion::function_51dd865c();
    zm_genesis_spiders::function_56aaef97();
    level thread function_ee64baa8();
    clientfield::register( "clientuimodel", "player_lives", 15000, 2, "int" );
    clientfield::register( "clientuimodel", "zmInventory.widget_shield_parts", 12000, 1, "int" );
    clientfield::register( "clientuimodel", "zmInventory.widget_dragon_strike", 12000, 1, "int" );
    clientfield::register( "clientuimodel", "zmInventory.player_crafted_shield", 12000, 1, "int" );
    zm_genesis_challenges::init_clientfields();
    level._effect[ "eye_glow" ] = "dlc3/stalingrad/fx_glow_eye_red_stal";
    
    /#
        zm_genesis_util::devgui();
    #/
    
    level.default_start_location = "start_room";
    level.default_game_mode = "zclassic";
    level.precachecustomcharacters = &precachecustomcharacters;
    level.givecustomcharacters = &givecustomcharacters;
    initcharacterstartindex();
    level.custom_game_over_hud_elem = &function_1af84ba5;
    level.register_offhand_weapons_for_level_defaults_override = &offhand_weapon_overrride;
    level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
    level._zombie_custom_add_weapons = &custom_add_weapons;
    level._allow_melee_weapon_switching = 1;
    level.zombiemode_reusing_pack_a_punch = 1;
    level._zombie_custom_spawn_logic = &function_dcf0070e;
    level.minigun_damage_adjust_override = &function_83937162;
    setdvar( "tu13_ai_useModifiedPushActors", 1 );
    level.speed_change_round = 9;
    zombie_utility::set_zombie_var( "zombie_powerup_drop_max_per_round", 4 );
    level.do_randomized_zigzag_path = 1;
    level.zm_custom_spawn_location_selection = &genesis_custom_spawn_location_selection;
    level.enemy_location_override_func = &function_b51f6175;
    level.player_intersection_tracker_override = &function_1b647c97;
    level.zm_bgb_anywhere_but_here_validation_override = &function_869d6f66;
    level.var_9cef605e = &function_cc2772da;
    level.var_2d4e3645 = &function_d9e1ec4d;
    level.var_1c0253f1 = &zm_genesis_ee_quest::function_d86f4446;
    level.var_774896e3 = "power_on3";
    level.gravityspike_position_check = &function_6190ec3f;
    level.custom_limited_weapon_checks = [];
    level.custom_limited_weapon_checks[ 0 ] = &function_52c6fb28;
    level.var_f06c86b9 = 0;
    level.customrandomweaponweights = &function_659c2324;
    level.func_magicbox_weapon_spawned = &function_1350a73f;
    level.custom_magic_box_selection_logic = &function_e1630fb4;
    level.revive_give_back_weapons_custom_func = &function_b45f77c1;
    
    /#
        level.var_e26adf8d = &function_e26adf8d;
    #/
    
    include_weapons();
    zm_craftables::init();
    zm_genesis_flingers::function_976c9217();
    zm_genesis_apothicon_god::main();
    level._no_vending_machine_auto_collision = 1;
    include_perks_in_random_rotation();
    level thread zm_genesis_challenges::init_challenge_boards();
    load::main();
    level thread zm_genesis_fx::function_2c301fae();
    level._round_start_func = &zm::round_start;
    init_sounds();
    level thread zm_genesis_sound::main();
    array::thread_all( level.zombie_spawners, &spawner::add_spawn_function, &function_429599b3 );
    level thread zm_genesis_keeper_companion::main();
    level thread zm_genesis_portals::function_16616103();
    level thread zm_genesis_challenges::main();
    level thread function_a00f0b4d();
    level thread function_57e1c276();
    level thread zm_genesis_flinger_trap::main();
    level thread zm_genesis_portals::function_b64d33a7();
    level thread sndfunctions();
    
    /#
        level thread zm_genesis_util::function_1f006e62();
    #/
    
    zombie_utility::set_zombie_var( "below_world_check", -4000 );
    setdvar( "hkai_pathfindIterationLimit", 4000 );
    setdvar( "dlc2_fix_scripted_looping_linked_animations", 1 );
    level thread function_632e15ea();
    zm_genesis_ffotd::main_end();
    level thread zm_genesis_ee_quest::function_26bc55e3();
    level thread zm_genesis_hope::start();
    level.check_end_solo_game_override = &check_end_solo_game_override;
    level._game_module_game_end_check = &function_63f29efd;
    level thread function_a81bfac6();
    level flag::wait_till( "start_zombie_round_logic" );
    level util::clientnotify( "force_stop" );
    level thread zm_perks::spare_change();
}

// Namespace zm_genesis
// Params 0
// Checksum 0xff9051d0, Offset: 0x3010
// Size: 0x1ec
function function_a81bfac6()
{
    if ( getdvarint( "splitscreen_playerCount" ) > 2 )
    {
        wait 0.5;
        level thread scene::stop( "p7_fxanim_zm_gen_floating_truck_01_bundle", 1 );
        level thread scene::stop( "p7_fxanim_zm_gen_truck_flatbed_sheffield_bundle", 1 );
        level thread scene::stop( "p7_fxanim_zm_gen_undercroft_pyramid_floaters_bundle", 1 );
        level thread scene::stop( "p7_fxanim_zm_gen_apoth_corpt_engine_gate_chunks_bundle", 1 );
        level thread scene::stop( "p7_fxanim_zm_gen_prison_cells_bundle", 1 );
        level thread scene::stop( "p7_fxanim_zm_gen_corrupted_shards_origins_01_bundle", 1 );
        level thread scene::stop( "p7_fxanim_zm_gen_corrupted_shards_origins_02_bundle", 1 );
        level thread scene::stop( "p7_fxanim_gp_body_hang_feet_01_bundle", 1 );
        level thread scene::stop( "p7_fxanim_gp_body_hang_feet_01_long_bundle", 1 );
        level thread scene::stop( "p7_fxanim_gp_body_hang_neck_01_bundle", 1 );
        level thread scene::stop( "p7_fxanim_gp_body_hang_neck_01_long_bundle", 1 );
        level thread scene::stop( "p7_fxanim_zm_gen_apoth_corpt_engine_tower_top_bundle", 1 );
        level thread scene::stop( "p7_fxanim_zm_gen_apoth_corpt_engine_pillar_mod", 1 );
        level thread scene::stop( "p7_fxanim_zm_gen_apoth_corpt_engine_door_bundle", 1 );
    }
}

/#

    // Namespace zm_genesis
    // Params 2
    // Checksum 0xc74a5b25, Offset: 0x3208
    // Size: 0x21c, Type: dev
    function function_e26adf8d( player, ip1 )
    {
        weapon_name = "<dev string:x28>";
        adddebugcommand( "<dev string:x33>" + player.name + "<dev string:x4f>" + ip1 + "<dev string:x53>" + weapon_name + "<dev string:x55>" + ip1 + "<dev string:x75>" + weapon_name + "<dev string:x77>" );
        weapon_name = "<dev string:x7b>";
        adddebugcommand( "<dev string:x8f>" + player.name + "<dev string:x4f>" + ip1 + "<dev string:x53>" + weapon_name + "<dev string:x55>" + ip1 + "<dev string:x75>" + weapon_name + "<dev string:x77>" );
        weapon_name = "<dev string:xab>";
        adddebugcommand( "<dev string:xb1>" + player.name + "<dev string:x4f>" + ip1 + "<dev string:x53>" + weapon_name + "<dev string:x55>" + ip1 + "<dev string:x75>" + weapon_name + "<dev string:x77>" );
        weapon_name = "<dev string:xcd>";
        adddebugcommand( "<dev string:xdc>" + player.name + "<dev string:x4f>" + ip1 + "<dev string:x53>" + weapon_name + "<dev string:x55>" + ip1 + "<dev string:x75>" + weapon_name + "<dev string:x77>" );
    }

#/

// Namespace zm_genesis
// Params 1
// Checksum 0x888eb6c0, Offset: 0x3430
// Size: 0x74, Type: bool
function function_b45f77c1( w_revive )
{
    if ( isdefined( self.carryobject ) && isdefined( self.carryobject.carryweapon ) && self.carryobject.carryweapon == level.ballweapon )
    {
        self zm_weapons::switch_back_primary_weapon( self.carryobject.carryweapon );
        return true;
    }
    
    return false;
}

// Namespace zm_genesis
// Params 12
// Checksum 0xceecf5f8, Offset: 0x34b0
// Size: 0xc0
function function_82800a29( e_inflictor, e_attacker, n_damage, n_flags, str_meansofdeath, w_weapon, v_point, v_dir, str_hit_loc, var_901d6761, var_22b92c8f, var_83c2eb8 )
{
    if ( isdefined( self.killby_interdimensional_gun_hole ) && self.killby_interdimensional_gun_hole )
    {
        return -1;
    }
    
    if ( isdefined( e_attacker ) && isdefined( e_attacker.team ) )
    {
        if ( e_attacker.team == self.team )
        {
            return 0;
        }
    }
    
    return -1;
}

// Namespace zm_genesis
// Params 12
// Checksum 0xb6388468, Offset: 0x3578
// Size: 0xf0
function function_83937162( e_inflictor, e_attacker, n_damage, n_flags, str_meansofdeath, w_weapon, v_point, v_dir, str_hit_loc, var_901d6761, var_22b92c8f, var_83c2eb8 )
{
    if ( self.archetype == "apothicon_fury" || self.archetype == "keeper" || self.archetype == "spider" || self.archetype == "parasite" )
    {
        n_percent_damage = self.health * randomfloatrange( 0.34, 0.75 );
        return n_percent_damage;
    }
}

// Namespace zm_genesis
// Params 15
// Checksum 0x920fd9e4, Offset: 0x3670
// Size: 0xbc
function function_68a54382( e_inflictor, e_attacker, n_damage, n_flags, str_meansofdeath, w_weapon, v_point, v_dir, str_hit_loc, v_damage_origin, var_901d6761, b_damage_from_underneath, n_model_index, str_part_name, v_surface_normal )
{
    if ( isdefined( e_attacker ) && isdefined( e_attacker.team ) )
    {
        if ( e_attacker.team == self.team )
        {
            return 0;
        }
    }
    
    return n_damage;
}

// Namespace zm_genesis
// Params 1
// Checksum 0x4077d91b, Offset: 0x3738
// Size: 0x14c
function function_659c2324( a_keys )
{
    if ( level.chest_moves > 0 && zm_weapons::limited_weapon_below_quota( level.idgun_weapons[ 0 ] ) )
    {
        if ( level.var_f06c86b9 > 12 )
        {
            if ( !isdefined( a_keys ) )
            {
                a_keys = [];
            }
            else if ( !isarray( a_keys ) )
            {
                a_keys = array( a_keys );
            }
            
            a_keys[ a_keys.size ] = level.idgun_weapons[ 0 ];
        }
        
        if ( level.var_f06c86b9 > 6 )
        {
            if ( !isdefined( a_keys ) )
            {
                a_keys = [];
            }
            else if ( !isarray( a_keys ) )
            {
                a_keys = array( a_keys );
            }
            
            a_keys[ a_keys.size ] = level.idgun_weapons[ 0 ];
            a_keys = array::randomize( a_keys );
        }
    }
    
    return a_keys;
}

// Namespace zm_genesis
// Params 1
// Checksum 0x620fa544, Offset: 0x3890
// Size: 0x78
function function_1350a73f( w_weapon )
{
    if ( w_weapon == level.idgun_weapons[ 0 ] )
    {
        level.var_f06c86b9 = 0;
        return;
    }
    
    if ( level.chest_moves && zm_weapons::limited_weapon_below_quota( level.idgun_weapons[ 0 ] ) )
    {
        level.var_f06c86b9++;
        return;
    }
    
    level.var_f06c86b9 = 0;
}

// Namespace zm_genesis
// Params 1
// Checksum 0x789e53e9, Offset: 0x3910
// Size: 0x44, Type: bool
function function_52c6fb28( var_be1d6484 )
{
    if ( isdefined( level.var_3bb6997f ) && zm_weapons::get_base_weapon( level.var_3bb6997f ) == var_be1d6484 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_genesis
// Params 0
// Checksum 0xc946b980, Offset: 0x3960
// Size: 0x18, Type: bool
function check_end_solo_game_override()
{
    if ( isdefined( level.ai_companion ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_genesis
// Params 0
// Checksum 0xf0b7fa2b, Offset: 0x3980
// Size: 0x28, Type: bool
function function_63f29efd()
{
    if ( isdefined( level.var_46040f3e ) && level.var_46040f3e == 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_genesis
// Params 0
// Checksum 0xf0ce1c9f, Offset: 0x39b0
// Size: 0x58
function on_player_spawned()
{
    self.is_flung = 0;
    self.var_7dd18a0 = 0;
    self allowwallrun( 0 );
    self allowdoublejump( 0 );
    self.zapped_zombies = 0;
}

// Namespace zm_genesis
// Params 0
// Checksum 0x989dcbba, Offset: 0x3a10
// Size: 0xd4
function on_player_connected()
{
    self thread zm_genesis_undercroft_low_grav::function_c3f6aa22();
    self zm_genesis_challenges::on_player_connect();
    self.overrideplayerdamage = &function_7427eacc;
    
    if ( level.players.size > 1 && !level flag::get( "is_coop_door_price" ) )
    {
        function_898d7758();
    }
    
    self flag::init( "holding_egg" );
    self flag::init( "holding_gateworm" );
}

// Namespace zm_genesis
// Params 0
// Checksum 0xe2c5bd5f, Offset: 0x3af0
// Size: 0x24
function init_sounds()
{
    zm_utility::add_sound( "zmb_heavy_door_open", "zmb_heavy_door_open" );
}

// Namespace zm_genesis
// Params 0
// Checksum 0xd43a59ed, Offset: 0x3b20
// Size: 0xee
function offhand_weapon_overrride()
{
    zm_utility::register_lethal_grenade_for_level( "frag_grenade" );
    level.zombie_lethal_grenade_player_init = getweapon( "frag_grenade" );
    zm_utility::register_tactical_grenade_for_level( "emp_grenade" );
    zm_utility::register_tactical_grenade_for_level( "octobomb" );
    zm_utility::register_tactical_grenade_for_level( "octobomb_upgraded" );
    zm_utility::register_melee_weapon_for_level( level.weaponbasemelee.name );
    zm_utility::register_melee_weapon_for_level( "bowie_knife" );
    zm_utility::register_melee_weapon_for_level( "tazer_knuckles" );
    level.zombie_melee_weapon_player_init = level.weaponbasemelee;
    level.zombie_equipment_player_init = undefined;
}

// Namespace zm_genesis
// Params 0
// Checksum 0x61b7f0da, Offset: 0x3c18
// Size: 0x136
function construct_idgun_weapon_array()
{
    level.idgun_weapons = [];
    level.w_idgun = getweapon( "idgun_genesis_0" );
    level.w_idgun_upgraded = getweapon( "idgun_genesis_0_upgraded" );
    
    if ( !isdefined( level.idgun_weapons ) )
    {
        level.idgun_weapons = [];
    }
    else if ( !isarray( level.idgun_weapons ) )
    {
        level.idgun_weapons = array( level.idgun_weapons );
    }
    
    level.idgun_weapons[ level.idgun_weapons.size ] = level.w_idgun;
    
    if ( !isdefined( level.idgun_weapons ) )
    {
        level.idgun_weapons = [];
    }
    else if ( !isarray( level.idgun_weapons ) )
    {
        level.idgun_weapons = array( level.idgun_weapons );
    }
    
    level.idgun_weapons[ level.idgun_weapons.size ] = level.w_idgun_upgraded;
}

// Namespace zm_genesis
// Params 1
// Checksum 0x18bf4f77, Offset: 0x3d58
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

// Namespace zm_genesis
// Params 0
// Checksum 0x99ec1590, Offset: 0x3e20
// Size: 0x4
function include_weapons()
{
    
}

// Namespace zm_genesis
// Params 0
// Checksum 0x99ec1590, Offset: 0x3e30
// Size: 0x4
function precachecustomcharacters()
{
    
}

// Namespace zm_genesis
// Params 0
// Checksum 0x21fb5b8b, Offset: 0x3e40
// Size: 0x24
function initcharacterstartindex()
{
    level.characterstartindex = randomint( 4 );
}

// Namespace zm_genesis
// Params 0
// Checksum 0x9eecc3fa, Offset: 0x3e70
// Size: 0x3e
function selectcharacterindextouse()
{
    if ( level.characterstartindex >= 4 )
    {
        level.characterstartindex = 0;
    }
    
    self.characterindex = level.characterstartindex;
    level.characterstartindex++;
    return self.characterindex;
}

// Namespace zm_genesis
// Params 0
// Checksum 0x3153bfd3, Offset: 0x3eb8
// Size: 0x182
function function_898d7758()
{
    level flag::set( "is_coop_door_price" );
    var_667e2b8a = getentarray( "zombie_door", "targetname" );
    
    foreach ( var_12248b8b in var_667e2b8a )
    {
        if ( isdefined( var_12248b8b.zombie_cost ) )
        {
            var_12248b8b.zombie_cost += 250;
            
            if ( isdefined( var_12248b8b.script_label ) && var_12248b8b.script_label == "debris_using_door_trigger" )
            {
                var_12248b8b zm_utility::set_hint_string( var_12248b8b, "default_buy_debris", var_12248b8b.zombie_cost );
                continue;
            }
            
            var_12248b8b zm_utility::set_hint_string( var_12248b8b, "default_buy_door", var_12248b8b.zombie_cost );
        }
    }
}

// Namespace zm_genesis
// Params 0
// Checksum 0x81dfa6ab, Offset: 0x4048
// Size: 0xe8
function function_ee64baa8()
{
    level.use_multiple_spawns = 1;
    level.fn_custom_zombie_spawner_selection = &function_9160f4d3;
    level.a_sp_skeleton = getentarray( "skeleton_spawner", "script_noteworthy" );
    array::thread_all( level.a_sp_skeleton, &spawner::add_spawn_function, &zm_spawner::zombie_spawn_init );
    array::thread_all( level.a_sp_skeleton, &spawner::add_spawn_function, &function_68dbbc77 );
    level waittill( #"start_zombie_round_logic" );
    level.zones[ "apothicon_interior_zone" ].script_int = 2;
}

// Namespace zm_genesis
// Params 0
// Checksum 0xc7fa9bdb, Offset: 0x4138
// Size: 0x104
function function_429599b3()
{
    self endon( #"death" );
    
    if ( isdefined( self.spawn_point ) && isdefined( self.spawn_point.speed ) )
    {
        self waittill( #"risen" );
        wait 0.2;
        
        if ( isdefined( self.zombie_move_speed ) )
        {
            var_75fd27c = self.zombie_move_speed;
        }
        
        if ( self.spawn_point.speed === 2 )
        {
            self zombie_utility::set_zombie_run_cycle( "sprint" );
        }
        else
        {
            self zombie_utility::set_zombie_run_cycle( "run" );
        }
        
        self util::waittill_any_timeout( 10, "completed_emerging_into_playable_area", "death" );
        
        if ( isdefined( var_75fd27c ) )
        {
            self zombie_utility::set_zombie_run_cycle( var_75fd27c );
        }
    }
}

// Namespace zm_genesis
// Params 0
// Checksum 0x245f1806, Offset: 0x4248
// Size: 0x64
function function_68dbbc77()
{
    if ( issubstr( self.model, "skeleton" ) )
    {
        self hidepart( "tag_weapon_left" );
        self hidepart( "tag_weapon_right" );
    }
}

// Namespace zm_genesis
// Params 0
// Checksum 0x92c3c569, Offset: 0x42b8
// Size: 0x260
function function_9160f4d3()
{
    var_6af221a2 = [];
    var_bbe5e3fe = function_2352d916( 2 );
    var_e632342f = function_2352d916( 1 );
    var_6b2d3150 = var_bbe5e3fe + var_e632342f;
    
    if ( var_bbe5e3fe > 0 )
    {
        foreach ( sp_skeleton in level.a_sp_skeleton )
        {
            array::add( var_6af221a2, sp_skeleton, 0 );
        }
    }
    
    if ( var_e632342f > 0 )
    {
        foreach ( sp_zombie in level.zombie_spawners )
        {
            array::add( var_6af221a2, sp_zombie, 0 );
        }
    }
    
    n_randy = randomint( var_6b2d3150 );
    
    if ( var_bbe5e3fe > 0 && n_randy <= var_bbe5e3fe )
    {
        sp_zombie = array::random( level.a_sp_skeleton );
    }
    else if ( var_e632342f > 0 )
    {
        sp_zombie = array::random( level.zombie_spawners );
    }
    else
    {
        assert( var_e632342f > 0, "<dev string:xf8>" );
    }
    
    return sp_zombie;
}

// Namespace zm_genesis
// Params 1
// Checksum 0x910a1a6b, Offset: 0x4520
// Size: 0x8c
function function_2352d916( script_int )
{
    a_s_spots = level.zm_loc_types[ "zombie_location" ];
    var_b02939f6 = 0;
    
    for ( i = 0; i < a_s_spots.size ; i++ )
    {
        if ( a_s_spots[ i ].script_int === script_int )
        {
            var_b02939f6++;
        }
    }
    
    return var_b02939f6;
}

// Namespace zm_genesis
// Params 0
// Checksum 0xa197019, Offset: 0x45b8
// Size: 0x18c
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
        return charindexarray[ 0 ];
    }
    else
    {
        if ( !function_5c35365f( players ) )
        {
            return charindexarray[ 2 ];
        }
        
        foreach ( player in players )
        {
            if ( isdefined( player.characterindex ) )
            {
                arrayremovevalue( charindexarray, player.characterindex, 0 );
            }
        }
        
        if ( charindexarray.size > 0 )
        {
            return charindexarray[ 0 ];
        }
    }
    
    return 0;
}

// Namespace zm_genesis
// Params 1
// Checksum 0x97aa4ccf, Offset: 0x4750
// Size: 0xae, Type: bool
function function_5c35365f( a_players )
{
    foreach ( player in a_players )
    {
        if ( isdefined( player.characterindex ) && player.characterindex == 2 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_genesis
// Params 0
// Checksum 0x71bf9507, Offset: 0x4808
// Size: 0x2cc
function givecustomcharacters()
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
        if ( getdvarstring( "<dev string:x118>" ) != "<dev string:x123>" )
        {
            self.characterindex = getdvarint( "<dev string:x118>" );
        }
    #/
    
    self setcharacterbodytype( self.characterindex );
    
    if ( self.characterindex != 2 )
    {
        self setcharacterbodystyle( 1 );
    }
    
    self setcharacterhelmetstyle( 0 );
    
    switch ( self.characterindex )
    {
        case 0:
            self.favorite_wall_weapons_list[ self.favorite_wall_weapons_list.size ] = getweapon( "frag_grenade" );
            self.favorite_wall_weapons_list[ self.favorite_wall_weapons_list.size ] = getweapon( "bouncingbetty" );
            break;
        case 1:
            self.talks_in_danger = 1;
            level.rich_sq_player = self;
            self.favorite_wall_weapons_list[ self.favorite_wall_weapons_list.size ] = getweapon( "pistol_standard" );
            break;
        case 2:
            self.favorite_wall_weapons_list[ self.favorite_wall_weapons_list.size ] = getweapon( "870mcs" );
            break;
        case 3:
            self.favorite_wall_weapons_list[ self.favorite_wall_weapons_list.size ] = getweapon( "hk416" );
            break;
    }
    
    self setmovespeedscale( 1 );
    self setsprintduration( 4 );
    self setsprintcooldown( 0 );
    self thread set_exert_id();
}

// Namespace zm_genesis
// Params 0
// Checksum 0xe370fadb, Offset: 0x4ae0
// Size: 0x54
function set_exert_id()
{
    self endon( #"disconnect" );
    util::wait_network_frame();
    util::wait_network_frame();
    self zm_audio::setexertvoice( self.characterindex + 1 );
}

// Namespace zm_genesis
// Params 0
// Checksum 0xa50e28a2, Offset: 0x4b40
// Size: 0x113a
function setup_personality_character_exerts()
{
    level.exert_sounds[ 1 ][ "burp" ][ 0 ] = "vox_plr_0_exert_burp_0";
    level.exert_sounds[ 1 ][ "burp" ][ 1 ] = "vox_plr_0_exert_burp_1";
    level.exert_sounds[ 1 ][ "burp" ][ 2 ] = "vox_plr_0_exert_burp_2";
    level.exert_sounds[ 1 ][ "burp" ][ 3 ] = "vox_plr_0_exert_burp_3";
    level.exert_sounds[ 1 ][ "burp" ][ 4 ] = "vox_plr_0_exert_burp_4";
    level.exert_sounds[ 1 ][ "burp" ][ 5 ] = "vox_plr_0_exert_burp_5";
    level.exert_sounds[ 1 ][ "burp" ][ 6 ] = "vox_plr_0_exert_burp_6";
    level.exert_sounds[ 2 ][ "burp" ][ 0 ] = "vox_plr_1_exert_burp_0";
    level.exert_sounds[ 2 ][ "burp" ][ 1 ] = "vox_plr_1_exert_burp_1";
    level.exert_sounds[ 2 ][ "burp" ][ 2 ] = "vox_plr_1_exert_burp_2";
    level.exert_sounds[ 2 ][ "burp" ][ 3 ] = "vox_plr_1_exert_burp_3";
    level.exert_sounds[ 3 ][ "burp" ][ 0 ] = "vox_plr_2_exert_burp_0";
    level.exert_sounds[ 3 ][ "burp" ][ 1 ] = "vox_plr_2_exert_burp_1";
    level.exert_sounds[ 3 ][ "burp" ][ 2 ] = "vox_plr_2_exert_burp_2";
    level.exert_sounds[ 3 ][ "burp" ][ 3 ] = "vox_plr_2_exert_burp_3";
    level.exert_sounds[ 3 ][ "burp" ][ 4 ] = "vox_plr_2_exert_burp_4";
    level.exert_sounds[ 3 ][ "burp" ][ 5 ] = "vox_plr_2_exert_burp_5";
    level.exert_sounds[ 3 ][ "burp" ][ 6 ] = "vox_plr_2_exert_burp_6";
    level.exert_sounds[ 4 ][ "burp" ][ 0 ] = "vox_plr_3_exert_burp_0";
    level.exert_sounds[ 4 ][ "burp" ][ 1 ] = "vox_plr_3_exert_burp_1";
    level.exert_sounds[ 4 ][ "burp" ][ 2 ] = "vox_plr_3_exert_burp_2";
    level.exert_sounds[ 4 ][ "burp" ][ 3 ] = "vox_plr_3_exert_burp_3";
    level.exert_sounds[ 4 ][ "burp" ][ 4 ] = "vox_plr_3_exert_burp_4";
    level.exert_sounds[ 4 ][ "burp" ][ 5 ] = "vox_plr_3_exert_burp_5";
    level.exert_sounds[ 4 ][ "burp" ][ 6 ] = "vox_plr_3_exert_burp_6";
    level.exert_sounds[ 1 ][ "hitmed" ][ 0 ] = "vox_plr_0_exert_pain_0";
    level.exert_sounds[ 1 ][ "hitmed" ][ 1 ] = "vox_plr_0_exert_pain_1";
    level.exert_sounds[ 1 ][ "hitmed" ][ 2 ] = "vox_plr_0_exert_pain_2";
    level.exert_sounds[ 1 ][ "hitmed" ][ 3 ] = "vox_plr_0_exert_pain_3";
    level.exert_sounds[ 1 ][ "hitmed" ][ 4 ] = "vox_plr_0_exert_pain_4";
    level.exert_sounds[ 2 ][ "hitmed" ][ 0 ] = "vox_plr_1_exert_pain_0";
    level.exert_sounds[ 2 ][ "hitmed" ][ 1 ] = "vox_plr_1_exert_pain_1";
    level.exert_sounds[ 2 ][ "hitmed" ][ 2 ] = "vox_plr_1_exert_pain_2";
    level.exert_sounds[ 2 ][ "hitmed" ][ 3 ] = "vox_plr_1_exert_pain_3";
    level.exert_sounds[ 2 ][ "hitmed" ][ 4 ] = "vox_plr_1_exert_pain_4";
    level.exert_sounds[ 3 ][ "hitmed" ][ 0 ] = "vox_plr_2_exert_pain_0";
    level.exert_sounds[ 3 ][ "hitmed" ][ 1 ] = "vox_plr_2_exert_pain_1";
    level.exert_sounds[ 3 ][ "hitmed" ][ 2 ] = "vox_plr_2_exert_pain_2";
    level.exert_sounds[ 3 ][ "hitmed" ][ 3 ] = "vox_plr_2_exert_pain_3";
    level.exert_sounds[ 3 ][ "hitmed" ][ 4 ] = "vox_plr_2_exert_pain_4";
    level.exert_sounds[ 4 ][ "hitmed" ][ 0 ] = "vox_plr_3_exert_pain_0";
    level.exert_sounds[ 4 ][ "hitmed" ][ 1 ] = "vox_plr_3_exert_pain_1";
    level.exert_sounds[ 4 ][ "hitmed" ][ 2 ] = "vox_plr_3_exert_pain_2";
    level.exert_sounds[ 4 ][ "hitmed" ][ 3 ] = "vox_plr_3_exert_pain_3";
    level.exert_sounds[ 4 ][ "hitmed" ][ 3 ] = "vox_plr_3_exert_pain_4";
    level.exert_sounds[ 1 ][ "hitlrg" ][ 0 ] = "vox_plr_0_exert_pain_0";
    level.exert_sounds[ 1 ][ "hitlrg" ][ 1 ] = "vox_plr_0_exert_pain_1";
    level.exert_sounds[ 1 ][ "hitlrg" ][ 2 ] = "vox_plr_0_exert_pain_2";
    level.exert_sounds[ 1 ][ "hitlrg" ][ 3 ] = "vox_plr_0_exert_pain_3";
    level.exert_sounds[ 1 ][ "hitlrg" ][ 4 ] = "vox_plr_0_exert_pain_4";
    level.exert_sounds[ 2 ][ "hitlrg" ][ 0 ] = "vox_plr_1_exert_pain_0";
    level.exert_sounds[ 2 ][ "hitlrg" ][ 1 ] = "vox_plr_1_exert_pain_1";
    level.exert_sounds[ 2 ][ "hitlrg" ][ 2 ] = "vox_plr_1_exert_pain_2";
    level.exert_sounds[ 2 ][ "hitlrg" ][ 3 ] = "vox_plr_1_exert_pain_3";
    level.exert_sounds[ 2 ][ "hitlrg" ][ 4 ] = "vox_plr_1_exert_pain_4";
    level.exert_sounds[ 3 ][ "hitlrg" ][ 0 ] = "vox_plr_2_exert_pain_0";
    level.exert_sounds[ 3 ][ "hitlrg" ][ 1 ] = "vox_plr_2_exert_pain_1";
    level.exert_sounds[ 3 ][ "hitlrg" ][ 2 ] = "vox_plr_2_exert_pain_2";
    level.exert_sounds[ 3 ][ "hitlrg" ][ 3 ] = "vox_plr_2_exert_pain_3";
    level.exert_sounds[ 3 ][ "hitlrg" ][ 4 ] = "vox_plr_2_exert_pain_4";
    level.exert_sounds[ 4 ][ "hitlrg" ][ 0 ] = "vox_plr_3_exert_pain_0";
    level.exert_sounds[ 4 ][ "hitlrg" ][ 1 ] = "vox_plr_3_exert_pain_1";
    level.exert_sounds[ 4 ][ "hitlrg" ][ 2 ] = "vox_plr_3_exert_pain_2";
    level.exert_sounds[ 4 ][ "hitlrg" ][ 3 ] = "vox_plr_3_exert_pain_3";
    level.exert_sounds[ 4 ][ "hitlrg" ][ 4 ] = "vox_plr_3_exert_pain_4";
    level.exert_sounds[ 1 ][ "drowning" ][ 0 ] = "vox_plr_0_exert_underwater_air_low_0";
    level.exert_sounds[ 1 ][ "drowning" ][ 1 ] = "vox_plr_0_exert_underwater_air_low_1";
    level.exert_sounds[ 1 ][ "drowning" ][ 2 ] = "vox_plr_0_exert_underwater_air_low_2";
    level.exert_sounds[ 1 ][ "drowning" ][ 3 ] = "vox_plr_0_exert_underwater_air_low_3";
    level.exert_sounds[ 2 ][ "drowning" ][ 0 ] = "vox_plr_1_exert_underwater_air_low_0";
    level.exert_sounds[ 2 ][ "drowning" ][ 1 ] = "vox_plr_1_exert_underwater_air_low_1";
    level.exert_sounds[ 2 ][ "drowning" ][ 2 ] = "vox_plr_1_exert_underwater_air_low_2";
    level.exert_sounds[ 2 ][ "drowning" ][ 3 ] = "vox_plr_1_exert_underwater_air_low_3";
    level.exert_sounds[ 3 ][ "drowning" ][ 0 ] = "vox_plr_2_exert_underwater_air_low_0";
    level.exert_sounds[ 3 ][ "drowning" ][ 1 ] = "vox_plr_2_exert_underwater_air_low_1";
    level.exert_sounds[ 3 ][ "drowning" ][ 2 ] = "vox_plr_2_exert_underwater_air_low_2";
    level.exert_sounds[ 3 ][ "drowning" ][ 3 ] = "vox_plr_2_exert_underwater_air_low_3";
    level.exert_sounds[ 4 ][ "drowning" ][ 0 ] = "vox_plr_3_exert_underwater_air_low_0";
    level.exert_sounds[ 4 ][ "drowning" ][ 1 ] = "vox_plr_3_exert_underwater_air_low_1";
    level.exert_sounds[ 4 ][ "drowning" ][ 2 ] = "vox_plr_3_exert_underwater_air_low_2";
    level.exert_sounds[ 4 ][ "drowning" ][ 3 ] = "vox_plr_3_exert_underwater_air_low_3";
    level.exert_sounds[ 1 ][ "cough" ][ 0 ] = "vox_plr_0_exert_cough_0";
    level.exert_sounds[ 1 ][ "cough" ][ 1 ] = "vox_plr_0_exert_cough_1";
    level.exert_sounds[ 1 ][ "cough" ][ 2 ] = "vox_plr_0_exert_cough_2";
    level.exert_sounds[ 1 ][ "cough" ][ 3 ] = "vox_plr_0_exert_cough_3";
    level.exert_sounds[ 2 ][ "cough" ][ 0 ] = "vox_plr_1_exert_cough_0";
    level.exert_sounds[ 2 ][ "cough" ][ 1 ] = "vox_plr_1_exert_cough_1";
    level.exert_sounds[ 2 ][ "cough" ][ 2 ] = "vox_plr_1_exert_cough_2";
    level.exert_sounds[ 2 ][ "cough" ][ 3 ] = "vox_plr_1_exert_cough_3";
    level.exert_sounds[ 3 ][ "cough" ][ 0 ] = "vox_plr_2_exert_cough_0";
    level.exert_sounds[ 3 ][ "cough" ][ 1 ] = "vox_plr_2_exert_cough_1";
    level.exert_sounds[ 3 ][ "cough" ][ 2 ] = "vox_plr_2_exert_cough_2";
    level.exert_sounds[ 3 ][ "cough" ][ 3 ] = "vox_plr_2_exert_cough_3";
    level.exert_sounds[ 4 ][ "cough" ][ 0 ] = "vox_plr_3_exert_cough_0";
    level.exert_sounds[ 4 ][ "cough" ][ 1 ] = "vox_plr_3_exert_cough_1";
    level.exert_sounds[ 4 ][ "cough" ][ 2 ] = "vox_plr_3_exert_cough_2";
    level.exert_sounds[ 4 ][ "cough" ][ 3 ] = "vox_plr_3_exert_cough_3";
    level.exert_sounds[ 1 ][ "underwater_emerge" ][ 0 ] = "vox_plr_0_exert_underwater_emerge_0";
    level.exert_sounds[ 1 ][ "underwater_emerge" ][ 1 ] = "vox_plr_0_exert_underwater_emerge_1";
    level.exert_sounds[ 2 ][ "underwater_emerge" ][ 0 ] = "vox_plr_1_exert_underwater_emerge_0";
    level.exert_sounds[ 2 ][ "underwater_emerge" ][ 1 ] = "vox_plr_1_exert_underwater_emerge_1";
    level.exert_sounds[ 3 ][ "underwater_emerge" ][ 0 ] = "vox_plr_2_exert_underwater_emerge_0";
    level.exert_sounds[ 3 ][ "underwater_emerge" ][ 1 ] = "vox_plr_2_exert_underwater_emerge_1";
    level.exert_sounds[ 4 ][ "underwater_emerge" ][ 0 ] = "vox_plr_3_exert_underwater_emerge_0";
    level.exert_sounds[ 4 ][ "underwater_emerge" ][ 1 ] = "vox_plr_3_exert_underwater_emerge_1";
    level.exert_sounds[ 1 ][ "underwater_gasp" ][ 0 ] = "vox_plr_0_exert_underwater_gasp_0";
    level.exert_sounds[ 1 ][ "underwater_gasp" ][ 1 ] = "vox_plr_0_exert_underwater_gasp_1";
    level.exert_sounds[ 2 ][ "underwater_gasp" ][ 0 ] = "vox_plr_1_exert_underwater_gasp_0";
    level.exert_sounds[ 2 ][ "underwater_gasp" ][ 1 ] = "vox_plr_1_exert_underwater_gasp_1";
    level.exert_sounds[ 3 ][ "underwater_gasp" ][ 0 ] = "vox_plr_2_exert_underwater_gasp_0";
    level.exert_sounds[ 3 ][ "underwater_gasp" ][ 1 ] = "vox_plr_2_exert_underwater_gasp_1";
    level.exert_sounds[ 4 ][ "underwater_gasp" ][ 0 ] = "vox_plr_3_exert_underwater_gasp_0";
    level.exert_sounds[ 4 ][ "underwater_gasp" ][ 1 ] = "vox_plr_3_exert_underwater_gasp_1";
}

// Namespace zm_genesis
// Params 0
// Checksum 0x1b4336fb, Offset: 0x5c88
// Size: 0x34
function custom_add_weapons()
{
    zm_weapons::load_weapon_spec_from_table( "gamedata/weapons/zm/zm_genesis_weapons.csv", 1 );
    zm_weapons::autofill_wallbuys_init();
}

// Namespace zm_genesis
// Params 0
// Checksum 0x198f8374, Offset: 0x5cc8
// Size: 0x1c
function custom_add_vox()
{
    zm_audio::loadplayervoicecategories( "gamedata/audio/zm/zm_genesis_vox.csv" );
}

// Namespace zm_genesis
// Params 0
// Checksum 0x3d6559d1, Offset: 0x5cf0
// Size: 0x34
function sndfunctions()
{
    level thread setupmusic();
    level thread custom_add_vox();
}

// Namespace zm_genesis
// Params 0
// Checksum 0xb81fa821, Offset: 0x5d30
// Size: 0x194
function setupmusic()
{
    zm_audio::musicstate_create( "round_start", 3, "round_start" );
    zm_audio::musicstate_create( "round_start_short", 3, "round_start" );
    zm_audio::musicstate_create( "round_start_first", 3, "round_start_genesis_first" );
    zm_audio::musicstate_create( "round_end", 3, "round_end" );
    zm_audio::musicstate_create( "game_over", 5, "gameover_genesis" );
    zm_audio::musicstate_create( "chaos_start", 3, "chaos_start" );
    zm_audio::musicstate_create( "chaos_end", 3, "chaos_end" );
    zm_audio::musicstate_create( "timer", 3, "timer" );
    zm_audio::musicstate_create( "power_on", 2, "poweron" );
    zm_audio::musicstate_create( "the_gift", 4, "the_gift" );
}

// Namespace zm_genesis
// Params 0
// Checksum 0x33990ada, Offset: 0x5ed0
// Size: 0x1c
function function_dcf0070e()
{
    self thread zm_genesis_undercroft_low_grav::function_3ccd9604();
}

// Namespace zm_genesis
// Params 2
// Checksum 0xa6eb37ee, Offset: 0x5ef8
// Size: 0x17c
function function_b51f6175( zombie, enemy )
{
    if ( isdefined( enemy.b_teleporting ) && enemy.b_teleporting )
    {
        if ( isdefined( enemy.a_s_port_locs ) && enemy.a_s_port_locs.size > 0 )
        {
            teleport_pos = enemy.a_s_port_locs[ 0 ].origin;
            
            if ( !ispointonnavmesh( teleport_pos, enemy ) )
            {
                position = getclosestpointonnavmesh( teleport_pos, 100, 15 );
                
                if ( isdefined( position ) )
                {
                    return position;
                }
            }
            
            return teleport_pos;
        }
    }
    
    if ( zombie.archetype == "mechz" )
    {
        if ( isplayer( enemy ) && enemy iswallrunning() )
        {
            position = getclosestpointonnavmesh( enemy.origin, 256, 30 );
            
            if ( isdefined( position ) )
            {
                enemy.last_valid_position = position;
                return position;
            }
        }
    }
    
    return undefined;
}

// Namespace zm_genesis
// Params 0
// Checksum 0xd26ca5cd, Offset: 0x6080
// Size: 0xf4
function include_perks_in_random_rotation()
{
    zm_perk_random::include_perk_in_random_rotation( "specialty_armorvest" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_quickrevive" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_fastreload" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_doubletap2" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_staminup" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_additionalprimaryweapon" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_deadshot" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_electriccherry" );
    zm_perk_random::include_perk_in_random_rotation( "specialty_widowswine" );
    level.custom_random_perk_weights = &function_fc65af2e;
}

// Namespace zm_genesis
// Params 0
// Checksum 0x5d233049, Offset: 0x6180
// Size: 0x1a4
function function_fc65af2e()
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
        arrayinsert( temp_array, "specialty_electriccherry", 0 );
    }
    
    temp_array = array::randomize( temp_array );
    level._random_perk_machine_perk_list = array::randomize( level._random_perk_machine_perk_list );
    level._random_perk_machine_perk_list = arraycombine( level._random_perk_machine_perk_list, temp_array, 1, 0 );
    keys = getarraykeys( level._random_perk_machine_perk_list );
    return keys;
}

// Namespace zm_genesis
// Params 1
// Checksum 0xb99ae348, Offset: 0x6330
// Size: 0x66, Type: bool
function function_1b647c97( var_3c6a24bf )
{
    if ( isdefined( self.var_4870991a ) && ( isdefined( var_3c6a24bf.is_flung ) && ( isdefined( self.is_flung ) && self.is_flung || var_3c6a24bf.is_flung ) || self.var_4870991a ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_genesis
// Params 0
// Checksum 0x9e20f28c, Offset: 0x63a0
// Size: 0x64, Type: bool
function function_6190ec3f()
{
    if ( isdefined( self.is_flung ) && self.is_flung || !ispointonnavmesh( self.origin, self ) )
    {
        self thread zm_equipment::show_hint_text( &"ZM_GENESIS_GRAVITYSPIKE_BAD_LOCATION", 3 );
        return false;
    }
    
    return true;
}

// Namespace zm_genesis
// Params 0
// Checksum 0xa7151828, Offset: 0x6410
// Size: 0xce, Type: bool
function function_869d6f66()
{
    if ( !isdefined( self zm_bgb_anywhere_but_here::function_728dfe3() ) )
    {
        return false;
    }
    
    if ( isdefined( level.var_b7572a82 ) && level.var_b7572a82 )
    {
        return false;
    }
    
    var_bfe88385 = getent( "samanthas_room_zone", "targetname" );
    
    if ( self istouching( var_bfe88385 ) )
    {
        return false;
    }
    
    if ( level flag::get( "boss_fight" ) || level flag::get( "arena_occupied_by_player" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_genesis
// Params 0
// Checksum 0x18c57d15, Offset: 0x64e8
// Size: 0x56, Type: bool
function function_cc2772da()
{
    if ( isdefined( self.var_9a017681 ) && ( isdefined( self.is_flung ) && self.is_flung || self.var_9a017681 ) )
    {
        return false;
    }
    
    if ( isdefined( self.b_teleporting ) && self.b_teleporting )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_genesis
// Params 1
// Checksum 0xadb181aa, Offset: 0x6548
// Size: 0x58
function function_d9e1ec4d( a_s_valid_respawn_points )
{
    var_ea555b15 = struct::get( "zm_prototype_outside_zone", "script_noteworthy" );
    arrayremovevalue( a_s_valid_respawn_points, var_ea555b15 );
    return a_s_valid_respawn_points;
}

// Namespace zm_genesis
// Params 0
// Checksum 0xa13b5514, Offset: 0x65a8
// Size: 0x1c
function function_a00f0b4d()
{
    level.inner_zigzag_radius = 0;
    level.outer_zigzag_radius = 96;
}

// Namespace zm_genesis
// Params 0
// Checksum 0x10a7e472, Offset: 0x65d0
// Size: 0x84
function function_57e1c276()
{
    while ( level.round_number < 6 )
    {
        level waittill( #"end_of_round" );
    }
    
    difficulty = 1;
    column = int( difficulty ) + 1;
    zombie_utility::set_zombie_var( "zombie_move_speed_multiplier", 5, 0, column );
}

// Namespace zm_genesis
// Params 1
// Checksum 0x2d521d28, Offset: 0x6660
// Size: 0x16c
function genesis_custom_spawn_location_selection( a_spots )
{
    if ( math::cointoss() )
    {
        if ( !isdefined( level.n_player_spawn_selection_index ) )
        {
            level.n_player_spawn_selection_index = 0;
        }
        
        e_player = level.players[ level.n_player_spawn_selection_index ];
        level.n_player_spawn_selection_index++;
        
        if ( level.n_player_spawn_selection_index > level.players.size - 1 )
        {
            level.n_player_spawn_selection_index = 0;
        }
        
        if ( !zm_utility::is_player_valid( e_player ) )
        {
            s_spot = array::random( a_spots );
            return s_spot;
        }
        
        var_e8c67fc0 = array::get_all_closest( e_player.origin, a_spots, undefined, 5 );
        
        if ( var_e8c67fc0.size )
        {
            s_spot = array::random( var_e8c67fc0 );
        }
        else
        {
            s_spot = array::random( a_spots );
        }
    }
    else
    {
        s_spot = array::random( a_spots );
    }
    
    return s_spot;
}

// Namespace zm_genesis
// Params 10
// Checksum 0x1042aaed, Offset: 0x67d8
// Size: 0x34c
function function_7427eacc( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime )
{
    if ( isdefined( self.var_e1384d1e ) )
    {
        if ( isdefined( eattacker ) && isdefined( eattacker.archetype ) && eattacker.archetype == "margwa" )
        {
            idamage *= self.var_e1384d1e;
        }
    }
    
    if ( isdefined( self.var_ad21546 ) )
    {
        if ( isdefined( eattacker ) && isdefined( eattacker.archetype ) && eattacker.archetype == "mechz" )
        {
            idamage *= self.var_ad21546;
        }
    }
    
    if ( isdefined( self.var_ebafd972 ) )
    {
        if ( isdefined( eattacker ) && isdefined( eattacker.archetype ) && eattacker.archetype == "keeper" )
        {
            idamage *= self.var_ebafd972;
        }
    }
    
    if ( isdefined( eattacker ) && isdefined( eattacker.archetype ) && eattacker.archetype == "apothicon_fury" )
    {
        if ( smeansofdeath === "MOD_MELEE" )
        {
            idamage = int( idamage + idamage * 0.5 );
        }
        
        if ( isdefined( self.var_eef0616b ) )
        {
            idamage *= self.var_eef0616b;
        }
    }
    
    if ( isdefined( self.ctffriendlyflagreturned ) && self.ctffriendlyflagreturned )
    {
        if ( isdefined( eattacker ) && isdefined( eattacker.archetype ) && eattacker.archetype == "zombie" && smeansofdeath == "MOD_EXPLOSIVE" )
        {
            idamage = 0;
        }
        
        if ( isdefined( eattacker ) && eattacker.targetname === "shadow_curse_trap" )
        {
            idamage = 0;
        }
    }
    
    if ( isdefined( self.var_bcff1de ) && self.var_bcff1de )
    {
        if ( isdefined( eattacker ) && isai( eattacker ) )
        {
            idamage = int( idamage / 2 );
        }
    }
    
    if ( isdefined( self.b_teleporting ) && self.b_teleporting )
    {
        idamage = 0;
    }
    
    n_damage = zm::player_damage_override( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime );
    return n_damage;
}

// Namespace zm_genesis
// Params 0
// Checksum 0x4f9c71bc, Offset: 0x6b30
// Size: 0x11c
function function_632e15ea()
{
    level thread function_237000f3( "p7_fxanim_zm_gen_undercroft_gate_bundle", "connect_undercroft_to_temple" );
    level thread function_237000f3( "p7_fxanim_zm_gen_door_buy_temple1_bundle", "connect_temple_to_temple_stairs" );
    level thread function_237000f3( "p7_fxanim_zm_gen_door_buy_temple2_bundle", "connect_temple_to_temple_stairs" );
    level thread function_237000f3( "p7_fxanim_zm_gen_door_buy_nacht1_bundle", "connect_prototype_upstairs_to_outside" );
    level thread function_237000f3( "p7_fxanim_zm_gen_door_buy_nacht2_bundle", "connect_prototype_start_to_upstairs" );
    level thread function_237000f3( "p7_fxanim_zm_gen_door_buy_asylum_bundle", "connect_asylum_downstairs_to_upstairs" );
    level thread function_237000f3( "p7_fxanim_zm_gen_door_buy_origins_bundle", "connect_ruins_to_inner_ruins" );
}

// Namespace zm_genesis
// Params 3
// Checksum 0xe62fdbcf, Offset: 0x6c58
// Size: 0xb4
function function_237000f3( str_scene, str_flag, var_38cd507c )
{
    if ( !isdefined( var_38cd507c ) )
    {
        var_38cd507c = undefined;
    }
    
    level scene::init( str_scene );
    
    if ( isdefined( var_38cd507c ) )
    {
        level flag::wait_till_any( array( str_flag, var_38cd507c ) );
    }
    else
    {
        level flag::wait_till( str_flag );
    }
    
    level scene::play( str_scene );
}

// Namespace zm_genesis
// Params 0
// Checksum 0x4d67068a, Offset: 0x6d18
// Size: 0x19a
function function_9c3ef4d4()
{
    level.b_show_single_intermission = 1;
    level waittill( #"intermission" );
    level notify( #"hash_c9cb5160" );
    
    foreach ( e_player in level.players )
    {
        if ( isdefined( e_player ) )
        {
            e_player clientfield::set_to_player( "player_light_exploder", 2 );
            util::wait_network_frame();
            e_player clientfield::set_to_player( "player_light_exploder", 4 );
            util::wait_network_frame();
            e_player clientfield::set_to_player( "player_light_exploder", 6 );
            util::wait_network_frame();
            e_player clientfield::set_to_player( "player_light_exploder", 8 );
            util::wait_network_frame();
            e_player clientfield::set_to_player( "player_light_exploder", 10 );
            util::wait_network_frame();
        }
    }
}

// Namespace zm_genesis
// Params 3
// Checksum 0x8dac5366, Offset: 0x6ec0
// Size: 0x2a8
function function_1af84ba5( player, var_65df0562, var_daaea4ad )
{
    var_65df0562.alignx = "center";
    var_65df0562.aligny = "middle";
    var_65df0562.horzalign = "center";
    var_65df0562.vertalign = "middle";
    var_65df0562.y -= 180;
    var_65df0562.foreground = 1;
    var_65df0562.fontscale = 3;
    var_65df0562.alpha = 0;
    var_65df0562.color = ( 1, 1, 1 );
    var_65df0562.hidewheninmenu = 1;
    var_65df0562 settext( &"ZOMBIE_GAME_OVER" );
    var_65df0562 fadeovertime( 1 );
    var_65df0562.alpha = 1;
    
    if ( player issplitscreen() )
    {
        var_65df0562.fontscale = 2;
        var_65df0562.y += 40;
    }
    
    var_daaea4ad.alignx = "center";
    var_daaea4ad.aligny = "middle";
    var_daaea4ad.horzalign = "center";
    var_daaea4ad.vertalign = "middle";
    var_daaea4ad.y -= 150;
    var_daaea4ad.foreground = 1;
    var_daaea4ad.fontscale = 2;
    var_daaea4ad.alpha = 0;
    var_daaea4ad.color = ( 1, 1, 1 );
    var_daaea4ad.hidewheninmenu = 1;
    
    if ( player issplitscreen() )
    {
        var_daaea4ad.fontscale = 1.5;
        var_daaea4ad.y += 40;
    }
}

// Namespace zm_genesis
// Params 3
// Checksum 0xdee7ca4c, Offset: 0x7170
// Size: 0x1ae, Type: bool
function function_e1630fb4( weapon, player, pap_triggers )
{
    if ( level.players.size > 1 )
    {
        switch ( weapon.name )
        {
            case "thundergun":
            case "thundergun_upgraded":
                var_17998646 = getweapon( "idgun_genesis_0" );
                break;
            case "idgun_genesis_0":
            case "idgun_genesis_0_upgraded":
                var_17998646 = getweapon( "thundergun" );
                break;
            default:
                return true;
        }
        
        if ( player zm_weapons::has_weapon_or_upgrade( var_17998646 ) )
        {
            return false;
        }
        
        foreach ( pap_trigger in pap_triggers )
        {
            if ( pap_trigger.current_weapon == var_17998646 || isdefined( pap_trigger.current_weapon ) && pap_trigger.current_weapon == zm_weapons::get_upgrade_weapon( var_17998646 ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

