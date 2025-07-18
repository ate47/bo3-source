#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_attackables;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/zm_challenges_tomb;
#using scripts/zm/zm_tomb_amb;
#using scripts/zm/zm_tomb_capture_zones_ffotd;
#using scripts/zm/zm_tomb_magicbox;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_vo;

#namespace zm_tomb_capture_zones;

#using_animtree( "generic" );

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x2d63cbd3, Offset: 0x1328
// Size: 0x31c
function init_capture_zones()
{
    zm_tomb_capture_zones_ffotd::capture_zone_init_start();
    level.initial_quick_revive_power_off = 1;
    precache_everything();
    level flag::init( "zone_capture_in_progress" );
    level flag::init( "recapture_event_in_progress" );
    level flag::init( "capture_zones_init_done" );
    level flag::init( "recapture_zombies_cleared" );
    level flag::init( "generator_under_attack" );
    level flag::init( "all_zones_captured" );
    level flag::init( "generator_lost_to_recapture_zombies" );
    level flag::init( "power_on1" );
    level flag::init( "power_on2" );
    level flag::init( "power_on3" );
    level flag::init( "power_on4" );
    level flag::init( "power_on5" );
    level flag::init( "power_on6" );
    root = %root;
    i = %p7_fxanim_zm_ori_pack_pc1_anim;
    i = %p7_fxanim_zm_ori_pack_pc2_anim;
    i = %p7_fxanim_zm_ori_pack_pc3_anim;
    i = %p7_fxanim_zm_ori_pack_pc4_anim;
    i = %p7_fxanim_zm_ori_pack_pc5_anim;
    i = %p7_fxanim_zm_ori_pack_pc6_anim;
    i = %p7_fxanim_zm_ori_pack_return_pc1_anim;
    i = %p7_fxanim_zm_ori_pack_return_pc2_anim;
    i = %p7_fxanim_zm_ori_pack_return_pc3_anim;
    i = %p7_fxanim_zm_ori_pack_return_pc4_anim;
    i = %p7_fxanim_zm_ori_pack_return_pc5_anim;
    i = %p7_fxanim_zm_ori_pack_return_pc6_anim;
    i = %p7_fxanim_zm_ori_monolith_inductor_pull_anim;
    i = %p7_fxanim_zm_ori_monolith_inductor_pull_idle_anim;
    i = %p7_fxanim_zm_ori_monolith_inductor_release_anim;
    i = %p7_fxanim_zm_ori_monolith_inductor_shake_anim;
    i = %p7_fxanim_zm_ori_monolith_inductor_idle_anim;
    level thread setup_capture_zones();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x99ec1590, Offset: 0x1650
// Size: 0x4
function precache_everything()
{
    
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xe07ca93a, Offset: 0x1660
// Size: 0x88c
function setup_capture_zones()
{
    spawner_capture_zombie = getent( "capture_zombie_spawner", "targetname" );
    spawner_capture_zombie spawner::add_spawn_function( &zm_tomb_utility::capture_zombie_spawn_init );
    a_s_generator = struct::get_array( "s_generator", "targetname" );
    var_2dc6026c = struct::get_array( "generator_attackable", "targetname" );
    clientfield::register( "world", "packapunch_anim", 21000, 3, "int" );
    clientfield::register( "actor", "zone_capture_zombie", 21000, 1, "int" );
    clientfield::register( "scriptmover", "zone_capture_emergence_hole", 21000, 1, "int" );
    clientfield::register( "world", "zc_change_progress_bar_color", 21000, 1, "int" );
    clientfield::register( "world", "zone_capture_hud_all_generators_captured", 21000, 1, "int" );
    clientfield::register( "world", "zone_capture_perk_machine_smoke_fx_always_on", 21000, 1, "int" );
    clientfield::register( "world", "pap_monolith_ring_shake", 21000, 1, "counter" );
    clientfield::register( "zbarrier", "pap_emissive_fx", 21000, 1, "int" );
    clientfield::register( "clientuimodel", "zmInventory.capture_generator_wheel_widget", 21000, 1, "int" );
    
    foreach ( struct in a_s_generator )
    {
        clientfield::register( "world", struct.script_noteworthy, 21000, 7, "float" );
        clientfield::register( "world", "state_" + struct.script_noteworthy, 21000, 3, "int" );
        clientfield::register( "world", "zone_capture_hud_generator_" + struct.script_int, 21000, 2, "int" );
        clientfield::register( "world", "zone_capture_monolith_crystal_" + struct.script_int, 21000, 1, "int" );
        clientfield::register( "world", "zone_capture_perk_machine_smoke_fx_" + struct.script_int, 21000, 1, "int" );
    }
    
    while ( !level flag::exists( "start_zombie_round_logic" ) )
    {
        wait 0.5;
    }
    
    level flag::wait_till( "start_zombie_round_logic" );
    objective_add( 0, "invisible", ( 0, 0, 0 ), istring( "zm_dlc5_capture_generator1" ) );
    objective_add( 1, "invisible", ( 0, 0, 0 ), istring( "zm_dlc5_capture_generator1" ) );
    objective_add( 2, "invisible", ( 0, 0, 0 ), istring( "zm_dlc5_capture_generator1" ) );
    objective_add( 3, "invisible", ( 0, 0, 0 ), istring( "zm_dlc5_capture_generator1" ) );
    level.magic_box_zbarrier_state_func = &set_magic_box_zbarrier_state;
    level.custom_perk_validation = &check_perk_machine_valid;
    level thread track_max_player_zombie_points();
    
    foreach ( s_generator in a_s_generator )
    {
        if ( !isdefined( s_generator.var_b454101b ) )
        {
            foreach ( var_b454101b in var_2dc6026c )
            {
                if ( var_b454101b.script_noteworthy == s_generator.script_noteworthy )
                {
                    s_generator.var_b454101b = var_b454101b;
                    break;
                }
            }
        }
        
        s_generator thread init_capture_zone();
    }
    
    register_elements_powered_by_zone_capture_generators();
    setup_perk_machines_not_controlled_by_zone_capture();
    pack_a_punch_init();
    level thread recapture_round_tracker();
    level.zone_capture.recapture_zombies = [];
    level.zone_capture.last_zone_captured = undefined;
    level.zone_capture.spawn_func_capture_zombie = &init_capture_zombie;
    level.zone_capture.spawn_func_recapture_zombie = &init_recapture_zombie;
    
    /#
        level thread watch_for_open_sesame();
        level thread debug_watch_for_zone_capture();
        level thread debug_watch_for_zone_recapture();
    #/
    
    zm_spawner::register_zombie_death_event_callback( &recapture_zombie_death_func );
    level.custom_derive_damage_refs = &zone_capture_gib_think;
    setup_inaccessible_zombie_attack_points();
    level thread quick_revive_game_type_watcher();
    level thread quick_revive_solo_leave_watcher();
    level thread all_zones_captured_vo();
    level flag::set( "capture_zones_init_done" );
    level clientfield::set( "zone_capture_perk_machine_smoke_fx_always_on", 1 );
    zm_tomb_capture_zones_ffotd::capture_zone_init_end();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x7d0d6145, Offset: 0x1ef8
// Size: 0x1a4
function all_zones_captured_vo()
{
    level flag::wait_till( "all_zones_captured" );
    level flag::wait_till_clear( "story_vo_playing" );
    zm_tomb_vo::set_players_dontspeak( 1 );
    level flag::set( "story_vo_playing" );
    e_speaker = get_closest_player_to_richtofen();
    
    if ( isdefined( e_speaker ) )
    {
        e_speaker zm_tomb_vo::set_player_dontspeak( 0 );
        e_speaker zm_audio::create_and_play_dialog( "zone_capture", "all_generators_captured" );
        e_speaker function_a98fbefd();
    }
    
    e_richtofen = get_player_named( "Richtofen" );
    
    if ( isdefined( e_richtofen ) )
    {
        e_richtofen zm_tomb_vo::set_player_dontspeak( 0 );
        e_richtofen zm_audio::create_and_play_dialog( "zone_capture", "all_generators_captured" );
    }
    
    zm_tomb_vo::set_players_dontspeak( 0 );
    level flag::clear( "story_vo_playing" );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x26ea7fc6, Offset: 0x20a8
// Size: 0x66
function function_a98fbefd()
{
    self endon( #"disconnect" );
    self thread function_7b7c0a4e();
    self thread function_859f7d9c();
    self waittill( #"hash_a227b4c7", str_msg );
    self notify( #"hash_40238b64" );
    return str_msg;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x2f6fcc24, Offset: 0x2118
// Size: 0x4a
function function_859f7d9c()
{
    self endon( #"hash_40238b64" );
    
    while ( isdefined( self.isspeaking ) && self.isspeaking )
    {
        wait 0.05;
    }
    
    self notify( #"hash_a227b4c7", "sound_played" );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xda4c8006, Offset: 0x2170
// Size: 0x46
function function_7b7c0a4e( n_timeout )
{
    if ( !isdefined( n_timeout ) )
    {
        n_timeout = 5;
    }
    
    self endon( #"hash_40238b64" );
    wait n_timeout;
    self notify( #"hash_a227b4c7", "timeout" );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xa5027a69, Offset: 0x21c0
// Size: 0xe4
function get_closest_player_to_richtofen()
{
    a_players = getplayers();
    e_speaker = undefined;
    e_richtofen = get_player_named( "Richtofen" );
    
    if ( isdefined( e_richtofen ) )
    {
        if ( a_players.size > 1 )
        {
            arrayremovevalue( a_players, e_richtofen, 0 );
            e_speaker = arraysort( a_players, e_richtofen.origin, 1 )[ 0 ];
        }
        else
        {
            e_speaker = undefined;
        }
    }
    else
    {
        e_speaker = get_random_speaker();
    }
    
    return e_speaker;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x307794cd, Offset: 0x22b0
// Size: 0xcc
function get_player_named( str_character_name )
{
    e_character = undefined;
    
    foreach ( player in getplayers() )
    {
        if ( isdefined( player.character_name ) && player.character_name == str_character_name )
        {
            e_character = player;
        }
    }
    
    return e_character;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x5eb8146, Offset: 0x2388
// Size: 0x108
function quick_revive_game_type_watcher()
{
    while ( true )
    {
        level waittill( #"revive_hide" );
        wait 1;
        t_revive_machine = level.zone_capture.zones[ "generator_start_bunker" ].perk_machines[ "revive" ];
        
        if ( level.zone_capture.zones[ "generator_start_bunker" ] flag::get( "player_controlled" ) )
        {
            level notify( #"revive_on" );
            t_revive_machine.is_locked = 0;
            t_revive_machine zm_perks::reset_vending_hint_string();
            continue;
        }
        
        level notify( #"revive_off" );
        t_revive_machine.is_locked = 1;
        t_revive_machine sethintstring( &"ZM_TOMB_ZC" );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xb8f9ac8d, Offset: 0x2498
// Size: 0x64
function quick_revive_solo_leave_watcher()
{
    if ( level flag::exists( "solo_revive" ) )
    {
        level flag::wait_till( "solo_revive" );
        level clientfield::set( "zone_capture_perk_machine_smoke_fx_1", 0 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xee0974a7, Offset: 0x2508
// Size: 0x44, Type: bool
function revive_perk_fx_think()
{
    return !level flag::exists( "solo_revive" ) || !level flag::get( "solo_revive" );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x7bbe56ac, Offset: 0x2558
// Size: 0xa4
function setup_inaccessible_zombie_attack_points()
{
    set_attack_point_as_inaccessible( "generator_start_bunker", 5 );
    set_attack_point_as_inaccessible( "generator_start_bunker", 11 );
    set_attack_point_as_inaccessible( "generator_tank_trench", 4 );
    set_attack_point_as_inaccessible( "generator_tank_trench", 5 );
    set_attack_point_as_inaccessible( "generator_tank_trench", 6 );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0x9912e281, Offset: 0x2608
// Size: 0x110
function set_attack_point_as_inaccessible( str_zone, n_index )
{
    assert( isdefined( level.zone_capture.zones[ str_zone ] ), "<dev string:x28>" + str_zone + "<dev string:x58>" );
    level.zone_capture.zones[ str_zone ] flag::wait_till( "zone_initialized" );
    assert( isdefined( level.zone_capture.zones[ str_zone ].zombie_attack_points[ n_index ] ), "<dev string:x7d>" + n_index + "<dev string:xb4>" + str_zone );
    level.zone_capture.zones[ str_zone ].zombie_attack_points[ n_index ].inaccessible = 1;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x9f5a83cb, Offset: 0x2720
// Size: 0x2c
function setup_perk_machines_not_controlled_by_zone_capture()
{
    level.zone_capture.perk_machines_always_on = array( "specialty_additionalprimaryweapon" );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xf84f451b, Offset: 0x2758
// Size: 0xb8
function track_max_player_zombie_points()
{
    while ( true )
    {
        a_players = getplayers();
        
        foreach ( player in a_players )
        {
            player.n_capture_zombie_points = 0;
        }
        
        level waittill( #"between_round_over" );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x99ec1590, Offset: 0x2818
// Size: 0x4
function pack_a_punch_dummy_init()
{
    
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xa304ba2d, Offset: 0x2828
// Size: 0x34
function pack_a_punch_init()
{
    level function_a2bcb201( 0 );
    level thread pack_a_punch_think();
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xae9daaea, Offset: 0x2868
// Size: 0x1da
function function_a2bcb201( b_show )
{
    var_1f4b1fcf = self.pack_a_punch.triggers;
    
    if ( b_show )
    {
        wait 2.5;
        
        foreach ( t_trigger in var_1f4b1fcf )
        {
            t_trigger.pap_machine setvisibletoall();
            t_trigger.pap_machine _zm_pack_a_punch::set_state_power_on();
            t_trigger.pap_machine clientfield::set( "pap_emissive_fx", 1 );
        }
        
        return;
    }
    
    foreach ( t_trigger in var_1f4b1fcf )
    {
        t_trigger.pap_machine setinvisibletoall();
        t_trigger.pap_machine _zm_pack_a_punch::set_state_hidden();
        t_trigger.pap_machine clientfield::set( "pap_emissive_fx", 0 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x9f387c91, Offset: 0x2a50
// Size: 0xe0
function pack_a_punch_think()
{
    while ( true )
    {
        level flag::wait_till( "all_zones_captured" );
        level notify( #"pack_a_punch_on" );
        pack_a_punch_enable();
        level thread function_a2bcb201( 1 );
        exploder::exploder( "lgtexp_exc_poweron" );
        level flag::wait_till_clear( "all_zones_captured" );
        pack_a_punch_disable();
        level thread function_a2bcb201( 0 );
        exploder::kill_exploder( "lgtexp_exc_poweron" );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x42c94df3, Offset: 0x2b38
// Size: 0x72
function pack_a_punch_enable()
{
    level flag::set( "power_on" );
    level clientfield::set( "zone_capture_hud_all_generators_captured", 1 );
    
    if ( !level flag::get( "generator_lost_to_recapture_zombies" ) )
    {
        level notify( #"all_zones_captured_none_lost" );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x336a3603, Offset: 0x2bb8
// Size: 0x64
function pack_a_punch_disable()
{
    level flag::wait_till_clear( "pack_machine_in_use" );
    level clientfield::set( "zone_capture_hud_all_generators_captured", 0 );
    level flag::clear( "power_on" );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xeed215c, Offset: 0x2c28
// Size: 0x234
function register_elements_powered_by_zone_capture_generators()
{
    register_random_perk_machine_for_zone( "generator_start_bunker", "starting_bunker" );
    register_perk_machine_for_zone( "generator_start_bunker", "revive", "specialty_quickrevive", &revive_perk_fx_think );
    register_mystery_box_for_zone( "generator_start_bunker", "bunker_start_chest" );
    register_random_perk_machine_for_zone( "generator_tank_trench", "trenches_right" );
    register_mystery_box_for_zone( "generator_tank_trench", "bunker_tank_chest" );
    register_random_perk_machine_for_zone( "generator_mid_trench", "trenches_left" );
    register_perk_machine_for_zone( "generator_mid_trench", "sleight", "specialty_fastreload" );
    register_mystery_box_for_zone( "generator_mid_trench", "bunker_cp_chest" );
    register_random_perk_machine_for_zone( "generator_nml_right", "nml" );
    register_perk_machine_for_zone( "generator_nml_right", "juggernog", "specialty_armorvest" );
    register_mystery_box_for_zone( "generator_nml_right", "nml_open_chest" );
    register_random_perk_machine_for_zone( "generator_nml_left", "farmhouse" );
    register_perk_machine_for_zone( "generator_nml_left", "marathon", "specialty_staminup" );
    register_mystery_box_for_zone( "generator_nml_left", "nml_farm_chest" );
    register_random_perk_machine_for_zone( "generator_church", "church" );
    register_mystery_box_for_zone( "generator_church", "village_church_chest" );
}

// Namespace zm_tomb_capture_zones
// Params 4
// Checksum 0x5739b881, Offset: 0x2e68
// Size: 0x15c
function register_perk_machine_for_zone( str_zone_name, str_perk_name, str_machine_targetname, func_perk_fx_think )
{
    assert( isdefined( level.zone_capture.zones[ str_zone_name ] ), "<dev string:xbe>" + str_zone_name + "<dev string:xe9>" );
    
    if ( !isdefined( level.zone_capture.zones[ str_zone_name ].perk_machines ) )
    {
        level.zone_capture.zones[ str_zone_name ].perk_machines = [];
    }
    
    if ( !isdefined( level.zone_capture.zones[ str_zone_name ].perk_machines[ str_perk_name ] ) )
    {
        e_perk_machine_trigger = get_perk_machine_trigger_from_vending_entity( str_machine_targetname );
        e_perk_machine_trigger.str_zone_name = str_zone_name;
        level.zone_capture.zones[ str_zone_name ].perk_machines[ str_perk_name ] = e_perk_machine_trigger;
    }
    
    level.zone_capture.zones[ str_zone_name ].perk_fx_func = func_perk_fx_think;
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0x9e5dd352, Offset: 0x2fd0
// Size: 0x278
function register_random_perk_machine_for_zone( str_zone_name, str_identifier )
{
    assert( isdefined( level.zone_capture.zones[ str_zone_name ] ), "<dev string:x126>" + str_zone_name + "<dev string:xe9>" );
    
    if ( !isdefined( level.zone_capture.zones[ str_zone_name ].perk_machines_random ) )
    {
        level.zone_capture.zones[ str_zone_name ].perk_machines_random = [];
    }
    
    a_random_perk_machines = getentarray( "perk_random_machine", "targetname" );
    
    foreach ( random_perk_machine in a_random_perk_machines )
    {
        if ( isdefined( random_perk_machine.script_string ) && random_perk_machine.script_string == str_identifier )
        {
            if ( !isdefined( level.zone_capture.zones[ str_zone_name ].perk_machines_random ) )
            {
                level.zone_capture.zones[ str_zone_name ].perk_machines_random = [];
            }
            else if ( !isarray( level.zone_capture.zones[ str_zone_name ].perk_machines_random ) )
            {
                level.zone_capture.zones[ str_zone_name ].perk_machines_random = array( level.zone_capture.zones[ str_zone_name ].perk_machines_random );
            }
            
            level.zone_capture.zones[ str_zone_name ].perk_machines_random[ level.zone_capture.zones[ str_zone_name ].perk_machines_random.size ] = random_perk_machine;
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0xb8ff6a95, Offset: 0x3250
// Size: 0x242
function register_mystery_box_for_zone( str_zone_name, str_identifier )
{
    assert( isdefined( level.zone_capture.zones[ str_zone_name ] ), "<dev string:x158>" + str_zone_name + "<dev string:xe9>" );
    
    if ( !isdefined( level.zone_capture.zones[ str_zone_name ].mystery_boxes ) )
    {
        level.zone_capture.zones[ str_zone_name ].mystery_boxes = [];
    }
    
    s_mystery_box = get_mystery_box_from_script_noteworthy( str_identifier );
    s_mystery_box.unitrigger_stub.prompt_and_visibility_func = &magic_box_trigger_update_prompt;
    s_mystery_box.unitrigger_stub.zone = str_zone_name;
    s_mystery_box.zone_capture_area = str_zone_name;
    s_mystery_box.zbarrier.zone_capture_area = str_zone_name;
    
    if ( !isdefined( level.zone_capture.zones[ str_zone_name ].mystery_boxes ) )
    {
        level.zone_capture.zones[ str_zone_name ].mystery_boxes = [];
    }
    else if ( !isarray( level.zone_capture.zones[ str_zone_name ].mystery_boxes ) )
    {
        level.zone_capture.zones[ str_zone_name ].mystery_boxes = array( level.zone_capture.zones[ str_zone_name ].mystery_boxes );
    }
    
    level.zone_capture.zones[ str_zone_name ].mystery_boxes[ level.zone_capture.zones[ str_zone_name ].mystery_boxes.size ] = s_mystery_box;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x4b570044, Offset: 0x34a0
// Size: 0xf0
function get_mystery_box_from_script_noteworthy( str_script_noteworthy )
{
    s_box = undefined;
    
    foreach ( s_mystery_box in level.chests )
    {
        if ( isdefined( s_mystery_box.script_noteworthy ) && s_mystery_box.script_noteworthy == str_script_noteworthy )
        {
            s_box = s_mystery_box;
        }
    }
    
    assert( isdefined( s_mystery_box ), "<dev string:x182>" + str_script_noteworthy );
    return s_box;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xbdc9b631, Offset: 0x3598
// Size: 0xfe
function enable_perk_machines_in_zone()
{
    if ( isdefined( self.perk_machines ) && isarray( self.perk_machines ) )
    {
        a_keys = getarraykeys( self.perk_machines );
        
        for ( i = 0; i < a_keys.size ; i++ )
        {
            level notify( a_keys[ i ] + "_on" );
        }
        
        for ( i = 0; i < a_keys.size ; i++ )
        {
            e_perk_trigger = self.perk_machines[ a_keys[ i ] ];
            e_perk_trigger.is_locked = 0;
            e_perk_trigger zm_perks::reset_vending_hint_string();
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x3e5a289c, Offset: 0x36a0
// Size: 0x106
function disable_perk_machines_in_zone()
{
    if ( isdefined( self.perk_machines ) && isarray( self.perk_machines ) )
    {
        a_keys = getarraykeys( self.perk_machines );
        
        for ( i = 0; i < a_keys.size ; i++ )
        {
            level notify( a_keys[ i ] + "_off" );
        }
        
        for ( i = 0; i < a_keys.size ; i++ )
        {
            e_perk_trigger = self.perk_machines[ a_keys[ i ] ];
            e_perk_trigger.is_locked = 1;
            e_perk_trigger sethintstring( &"ZM_TOMB_ZC" );
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x86d66bf4, Offset: 0x37b0
// Size: 0x112
function enable_random_perk_machines_in_zone()
{
    if ( isdefined( self.perk_machines_random ) && isarray( self.perk_machines_random ) )
    {
        foreach ( random_perk_machine in self.perk_machines_random )
        {
            random_perk_machine.is_locked = 0;
            
            if ( isdefined( random_perk_machine.current_perk_random_machine ) && random_perk_machine.current_perk_random_machine )
            {
                random_perk_machine zm_perk_random::set_perk_random_machine_state( "idle" );
                continue;
            }
            
            random_perk_machine zm_perk_random::set_perk_random_machine_state( "away" );
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xf1e16206, Offset: 0x38d0
// Size: 0x112
function disable_random_perk_machines_in_zone()
{
    if ( isdefined( self.perk_machines_random ) && isarray( self.perk_machines_random ) )
    {
        foreach ( random_perk_machine in self.perk_machines_random )
        {
            random_perk_machine.is_locked = 1;
            
            if ( isdefined( random_perk_machine.current_perk_random_machine ) && random_perk_machine.current_perk_random_machine )
            {
                random_perk_machine zm_perk_random::set_perk_random_machine_state( "initial" );
                continue;
            }
            
            random_perk_machine zm_perk_random::set_perk_random_machine_state( "power_off" );
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x416e2277, Offset: 0x39f0
// Size: 0xd2
function enable_mystery_boxes_in_zone()
{
    foreach ( mystery_box in self.mystery_boxes )
    {
        mystery_box.is_locked = 0;
        mystery_box.zbarrier set_magic_box_zbarrier_state( "player_controlled" );
        mystery_box.zbarrier clientfield::set( "magicbox_runes", 1 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x76806a19, Offset: 0x3ad0
// Size: 0xd2
function disable_mystery_boxes_in_zone()
{
    foreach ( mystery_box in self.mystery_boxes )
    {
        mystery_box.is_locked = 1;
        mystery_box.zbarrier set_magic_box_zbarrier_state( "zombie_controlled" );
        mystery_box.zbarrier clientfield::set( "magicbox_runes", 0 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xd40e2525, Offset: 0x3bb0
// Size: 0x68
function get_perk_machine_trigger_from_vending_entity( str_vending_machine_targetname )
{
    e_trigger = getent( str_vending_machine_targetname, "script_noteworthy" );
    assert( isdefined( e_trigger ), "<dev string:x1e1>" + str_vending_machine_targetname );
    return e_trigger;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x19694c2b, Offset: 0x3c20
// Size: 0xf0
function check_perk_machine_valid( player )
{
    if ( isdefined( self.script_noteworthy ) && isinarray( level.zone_capture.perk_machines_always_on, self.script_noteworthy ) )
    {
        b_machine_valid = 1;
    }
    else
    {
        assert( isdefined( self.str_zone_name ), "<dev string:x240>" );
        b_machine_valid = level.zone_capture.zones[ self.str_zone_name ] flag::get( "player_controlled" );
    }
    
    if ( !b_machine_valid )
    {
        player zm_audio::create_and_play_dialog( "lockdown", "power_off" );
    }
    
    return b_machine_valid;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x60e0d60a, Offset: 0x3d18
// Size: 0x2ac
function init_capture_zone()
{
    assert( isdefined( self.script_noteworthy ), "<dev string:x29a>" );
    
    if ( !isdefined( level.zone_capture ) )
    {
        level.zone_capture = spawnstruct();
    }
    
    if ( !isdefined( level.zone_capture.zones ) )
    {
        level.zone_capture.zones = [];
    }
    
    assert( !isdefined( level.zone_capture.zones[ self.script_noteworthy ] ), "<dev string:x2f9>" + self.script_noteworthy + "<dev string:x343>" );
    self.n_current_progress = 0;
    self.n_last_progress = 0;
    self setup_generator_unitrigger();
    self.str_zone = zm_zonemgr::get_zone_from_position( self.origin, 1 );
    self.sndent = spawn( "script_origin", self.origin );
    assert( isdefined( self.script_int ), "<dev string:x345>" + self.script_noteworthy + "<dev string:x343>" );
    self flag::init( "attacked_by_recapture_zombies" );
    self flag::init( "current_recapture_target_zone" );
    self flag::init( "player_controlled" );
    self flag::init( "zone_contested" );
    self flag::init( "zone_initialized" );
    level.zone_capture.zones[ self.script_noteworthy ] = self;
    self set_zombie_controlled_area( 1 );
    self setup_zombie_attack_points();
    self flag::set( "zone_initialized" );
    self thread wait_for_capture_trigger();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x146aba4d, Offset: 0x3fd0
// Size: 0x174
function setup_generator_unitrigger()
{
    s_unitrigger_stub = spawnstruct();
    s_unitrigger_stub.origin = self.origin;
    s_unitrigger_stub.angles = self.angles;
    s_unitrigger_stub.radius = 32;
    s_unitrigger_stub.script_length = 128;
    s_unitrigger_stub.script_width = 128;
    s_unitrigger_stub.script_height = 128;
    s_unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_unitrigger_stub.hint_string = &"ZM_TOMB_CAP";
    s_unitrigger_stub.hint_parm1 = [[ &get_generator_capture_start_cost ]]();
    s_unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_unitrigger_stub.require_look_at = 1;
    s_unitrigger_stub.prompt_and_visibility_func = &generator_trigger_prompt_and_visibility;
    s_unitrigger_stub.generator_struct = self;
    zm_unitrigger::unitrigger_force_per_player_triggers( s_unitrigger_stub, 1 );
    zm_unitrigger::register_static_unitrigger( s_unitrigger_stub, &generator_unitrigger_think );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xe18ce658, Offset: 0x4150
// Size: 0x118
function generator_trigger_prompt_and_visibility( e_player )
{
    b_can_see_hint = 1;
    s_zone = self.stub.generator_struct;
    
    if ( s_zone flag::get( "zone_contested" ) || s_zone flag::get( "player_controlled" ) )
    {
        b_can_see_hint = 0;
    }
    
    if ( level flag::get( "zone_capture_in_progress" ) )
    {
        self sethintstring( &"ZM_TOMB_ZCIP" );
    }
    else
    {
        self sethintstring( &"ZM_TOMB_CAP", get_generator_capture_start_cost() );
    }
    
    self setinvisibletoplayer( e_player, !b_can_see_hint );
    return b_can_see_hint;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x9507e6e3, Offset: 0x4270
// Size: 0x1d8
function generator_unitrigger_think()
{
    self endon( #"kill_trigger" );
    
    while ( true )
    {
        self waittill( #"trigger", e_player );
        
        if ( !zombie_utility::is_player_valid( e_player ) || e_player zm_laststand::is_reviving_any() || e_player != self.parent_player )
        {
            continue;
        }
        
        if ( level flag::get( "zone_capture_in_progress" ) )
        {
            continue;
        }
        
        if ( zombie_utility::is_player_valid( e_player ) )
        {
            self.stub.generator_struct.generator_cost = get_generator_capture_start_cost();
            
            if ( e_player zm_score::can_player_purchase( self.stub.generator_struct.generator_cost ) )
            {
                e_player zm_score::minus_to_player_score( self.stub.generator_struct.generator_cost );
                self.purchaser = e_player;
            }
            else
            {
                zm_utility::play_sound_at_pos( "no_purchase", self.origin );
                e_player zm_audio::create_and_play_dialog( "general", "no_money_capture" );
                continue;
            }
        }
        
        self setinvisibletoall();
        self.stub.generator_struct notify( #"start_generator_capture", e_player );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x3383d158, Offset: 0x4450
// Size: 0xc4
function setup_zombie_attack_points()
{
    self.zombie_attack_points = [];
    v_right = anglestoright( self.angles );
    self add_attack_points_from_anchor_origin( self.origin, 0, 52 );
    self add_attack_points_from_anchor_origin( self.origin + v_right * 170, 4, 32 );
    self add_attack_points_from_anchor_origin( self.origin + v_right * -1 * 170, 8, 32 );
}

// Namespace zm_tomb_capture_zones
// Params 3
// Checksum 0x98329d49, Offset: 0x4520
// Size: 0x156
function add_attack_points_from_anchor_origin( v_origin, n_start_index, n_scale )
{
    v_forward = anglestoforward( self.angles );
    v_right = anglestoright( self.angles );
    self.zombie_attack_points[ n_start_index ] = init_attack_point( v_origin + v_forward * n_scale, v_origin );
    self.zombie_attack_points[ n_start_index + 1 ] = init_attack_point( v_origin + v_right * n_scale, v_origin );
    self.zombie_attack_points[ n_start_index + 2 ] = init_attack_point( v_origin + v_forward * -1 * n_scale, v_origin );
    self.zombie_attack_points[ n_start_index + 3 ] = init_attack_point( v_origin + v_right * -1 * n_scale, v_origin );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0xa5be3570, Offset: 0x4680
// Size: 0x88
function init_attack_point( v_origin, v_center_pillar )
{
    s_temp = spawnstruct();
    s_temp.is_claimed = 0;
    s_temp.claimed_by = undefined;
    s_temp.origin = v_origin;
    s_temp.inaccessible = 0;
    s_temp.v_center_pillar = v_center_pillar;
    return s_temp;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xadd64a8c, Offset: 0x4710
// Size: 0x200
function wait_for_capture_trigger()
{
    while ( true )
    {
        self waittill( #"start_generator_capture", e_player );
        
        if ( !level flag::get( "zone_capture_in_progress" ) )
        {
            level flag::set( "zone_capture_in_progress" );
            self.var_ea997a3c = e_player;
            e_player util::delay( 2.5, undefined, &zm_audio::create_and_play_dialog, "zone_capture", "capture_started" );
            self zm_tomb_capture_zones_ffotd::capture_event_start();
            self thread monitor_capture_zombies();
            self thread activate_capture_zone();
            self flag::wait_till( "zone_contested" );
            capture_event_handle_ai_limit();
            self flag::wait_till_clear( "zone_contested" );
            self zm_tomb_capture_zones_ffotd::capture_event_end();
            wait 1;
            self.var_ea997a3c = undefined;
        }
        else
        {
            level flag::wait_till( "zone_capture_in_progress" );
            level flag::wait_till_clear( "zone_capture_in_progress" );
        }
        
        capture_event_handle_ai_limit();
        
        if ( self flag::get( "player_controlled" ) )
        {
            self flag::wait_till_clear( "player_controlled" );
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x5e7cdf67, Offset: 0x4918
// Size: 0xcc
function refund_generator_cost_if_player_captured_it( e_player )
{
    if ( isinarray( self get_players_in_capture_zone(), e_player ) )
    {
        n_refund_amount = self.generator_cost;
        b_double_points_active = level.zombie_vars[ "allies" ][ "zombie_point_scalar" ] == 2;
        n_multiplier = 1;
        
        if ( b_double_points_active )
        {
            n_multiplier = 0.5;
        }
        
        e_player zm_score::add_to_player_score( int( n_refund_amount * n_multiplier ) );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xc88c662b, Offset: 0x49f0
// Size: 0x1e
function get_generator_capture_start_cost()
{
    return 200 * getplayers().size;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x82988a26, Offset: 0x4a18
// Size: 0xa8
function capture_event_handle_ai_limit()
{
    n_capture_zombies_needed = calculate_capture_event_zombies_needed();
    level.zombie_ai_limit = 24 - n_capture_zombies_needed;
    
    while ( zombie_utility::get_current_zombie_count() > level.zombie_ai_limit )
    {
        ai_zombie = get_zombie_to_delete();
        
        if ( isdefined( ai_zombie ) )
        {
            ai_zombie thread delete_zombie_for_capture_event();
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xc7f0ceaa, Offset: 0x4ac8
// Size: 0x5c
function get_zombie_to_delete()
{
    ai_zombie = undefined;
    a_zombies = zombie_utility::get_round_enemy_array();
    
    if ( a_zombies.size > 0 )
    {
        ai_zombie = array::random( a_zombies );
    }
    
    return ai_zombie;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x7dd8b7dd, Offset: 0x4b30
// Size: 0x84
function delete_zombie_for_capture_event()
{
    if ( isdefined( self ) )
    {
        playfx( level._effect[ "tesla_elec_kill" ], self.origin );
        self ghost();
    }
    
    util::wait_network_frame();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x10fe6aa3, Offset: 0x4bc0
// Size: 0x72
function calculate_capture_event_zombies_needed()
{
    n_capture_zombies_needed = get_capture_zombies_needed();
    n_recapture_zombies_needed = 0;
    
    if ( level flag::get( "recapture_event_in_progress" ) )
    {
        n_recapture_zombies_needed = get_recapture_zombies_needed();
    }
    
    return n_capture_zombies_needed + n_recapture_zombies_needed;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x6e59842d, Offset: 0x4c40
// Size: 0x168
function get_capture_zombies_needed( b_per_zone )
{
    if ( !isdefined( b_per_zone ) )
    {
        b_per_zone = 0;
    }
    
    a_contested_zones = get_contested_zones();
    
    switch ( a_contested_zones.size )
    {
        case 0:
            n_capture_zombies_needed = 0;
            n_capture_zombies_needed_per_zone = 0;
            break;
        case 1:
            n_capture_zombies_needed = 4;
            n_capture_zombies_needed_per_zone = 4;
            break;
        case 2:
            n_capture_zombies_needed = 6;
            n_capture_zombies_needed_per_zone = 3;
            break;
        case 3:
            n_capture_zombies_needed = 6;
            n_capture_zombies_needed_per_zone = 2;
            break;
        case 4:
            n_capture_zombies_needed = 8;
            n_capture_zombies_needed_per_zone = 2;
            break;
        default:
            /#
                iprintlnbold( "<dev string:x3b3>" + a_contested_zones.size );
            #/
            
            n_capture_zombies_needed = 2 * a_contested_zones.size;
            n_capture_zombies_needed_per_zone = 2;
            break;
    }
    
    if ( b_per_zone )
    {
        b_capture_zombies_needed = n_capture_zombies_needed_per_zone;
    }
    
    return n_capture_zombies_needed;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x9755cea7, Offset: 0x4db0
// Size: 0xe6
function set_capture_zombies_needed_per_zone()
{
    a_contested_zones = get_contested_zones();
    n_zombies_needed_per_zone = get_capture_zombies_needed( 1 );
    
    foreach ( zone in a_contested_zones )
    {
        if ( zone flag::get( "current_recapture_target_zone" ) )
        {
            continue;
        }
        
        zone.capture_zombie_limit = n_zombies_needed_per_zone;
    }
    
    return n_zombies_needed_per_zone;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xe0ba9b46, Offset: 0x4ea0
// Size: 0x3a
function get_recapture_zombies_needed()
{
    if ( level.players.size == 1 )
    {
        n_recapture_zombies_needed = 4;
    }
    else
    {
        n_recapture_zombies_needed = 6;
    }
    
    return n_recapture_zombies_needed;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x818fa93a, Offset: 0x4ee8
// Size: 0x184
function activate_capture_zone( b_show_emergence_holes )
{
    if ( !isdefined( b_show_emergence_holes ) )
    {
        b_show_emergence_holes = 1;
    }
    
    if ( !level flag::get( "recapture_event_in_progress" ) )
    {
        self thread generator_initiated_vo();
    }
    
    self.a_emergence_hole_structs = struct::get_array( self.target, "targetname" );
    self show_emergence_holes( b_show_emergence_holes );
    
    if ( level flag::get( "recapture_event_in_progress" ) && self flag::get( "current_recapture_target_zone" ) )
    {
        self thread function_38a0fa7f();
        self thread function_de6d807b();
        level flag::wait_till_any( array( "generator_under_attack", "recapture_zombies_cleared" ) );
        
        if ( level flag::get( "recapture_zombies_cleared" ) )
        {
            return;
        }
    }
    
    self capture_progress_think();
    self destroy_emergence_holes();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x2fe65c29, Offset: 0x5078
// Size: 0x5c
function function_38a0fa7f()
{
    level endon( #"recapture_zombies_cleared" );
    self.var_b454101b waittill( #"attackable_damaged" );
    level flag::set( "generator_under_attack" );
    self flag::set( "attacked_by_recapture_zombies" );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xa60915de, Offset: 0x50e0
// Size: 0x5c
function function_de6d807b()
{
    level endon( #"recapture_zombies_cleared" );
    self.var_b454101b waittill( #"attackable_deactivated" );
    level flag::clear( "generator_under_attack" );
    self flag::clear( "attacked_by_recapture_zombies" );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x33affc1b, Offset: 0x5148
// Size: 0x134
function show_emergence_holes( b_show_emergence_holes )
{
    self destroy_emergence_holes();
    
    if ( b_show_emergence_holes )
    {
        self.a_spawner_holes = [];
        self.a_emergence_holes = [];
        
        foreach ( s_spawner_hole in self.a_emergence_hole_structs )
        {
            if ( !isdefined( self.a_emergence_holes ) )
            {
                self.a_emergence_holes = [];
            }
            else if ( !isarray( self.a_emergence_holes ) )
            {
                self.a_emergence_holes = array( self.a_emergence_holes );
            }
            
            self.a_emergence_holes[ self.a_emergence_holes.size ] = s_spawner_hole emergence_hole_spawn();
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x6211924e, Offset: 0x5288
// Size: 0x112
function destroy_emergence_holes()
{
    if ( isdefined( self.a_emergence_holes ) && self.a_emergence_holes.size > 0 )
    {
        foreach ( m_emergence_hole in self.a_emergence_holes )
        {
            if ( isdefined( m_emergence_hole ) )
            {
                m_emergence_hole clientfield::set( "zone_capture_emergence_hole", 0 );
                m_emergence_hole ghost();
                m_emergence_hole thread delete_self_after_time( randomfloatrange( 0.5, 2 ) );
            }
            
            util::wait_network_frame();
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x73b3de01, Offset: 0x53a8
// Size: 0x2c
function delete_self_after_time( n_time )
{
    wait n_time;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xa035d37b, Offset: 0x53e0
// Size: 0x1a8
function monitor_capture_zombies()
{
    self flag::wait_till( "zone_contested" );
    e_spawner_capture_zombie = getent( "capture_zombie_spawner", "targetname" );
    self.capture_zombies = [];
    self.capture_zombie_limit = self set_capture_zombies_needed_per_zone();
    
    while ( self flag::get( "zone_contested" ) )
    {
        self.capture_zombies = array::remove_dead( self.capture_zombies );
        
        if ( self.capture_zombies.size < self.capture_zombie_limit )
        {
            ai = zombie_utility::spawn_zombie( e_spawner_capture_zombie );
            s_spawn_point = self get_emergence_hole_spawn_point();
            ai thread [[ level.zone_capture.spawn_func_capture_zombie ]]( self, s_spawn_point );
            
            if ( !isdefined( self.capture_zombies ) )
            {
                self.capture_zombies = [];
            }
            else if ( !isarray( self.capture_zombies ) )
            {
                self.capture_zombies = array( self.capture_zombies );
            }
            
            self.capture_zombies[ self.capture_zombies.size ] = ai;
        }
        
        wait 0.5;
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x47ade90a, Offset: 0x5590
// Size: 0x214
function monitor_recapture_zombies()
{
    e_spawner_capture_zombie = getent( "capture_zombie_spawner", "targetname" );
    self.capture_zombie_limit = get_recapture_zombies_needed();
    n_capture_zombie_spawns = 0;
    self thread play_vo_when_generator_is_attacked();
    
    while ( level flag::get( "recapture_event_in_progress" ) && n_capture_zombie_spawns < self.capture_zombie_limit )
    {
        level.zone_capture.recapture_zombies = array::remove_dead( level.zone_capture.recapture_zombies );
        ai = zombie_utility::spawn_zombie( e_spawner_capture_zombie );
        
        if ( isdefined( ai ) )
        {
            n_capture_zombie_spawns++;
            s_spawn_point = self get_emergence_hole_spawn_point();
            ai thread [[ level.zone_capture.spawn_func_recapture_zombie ]]( self, s_spawn_point );
            
            if ( !isdefined( level.zone_capture.recapture_zombies ) )
            {
                level.zone_capture.recapture_zombies = [];
            }
            else if ( !isarray( level.zone_capture.recapture_zombies ) )
            {
                level.zone_capture.recapture_zombies = array( level.zone_capture.recapture_zombies );
            }
            
            level.zone_capture.recapture_zombies[ level.zone_capture.recapture_zombies.size ] = ai;
        }
        
        wait 0.5;
    }
    
    level monitor_recapture_zombie_count();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xe67b01b4, Offset: 0x57b0
// Size: 0x4c
function play_vo_when_generator_is_attacked()
{
    self endon( #"zone_contested" );
    level endon( #"recapture_event_in_progress" );
    self waittill( #"zombies_attacking_generator" );
    broadcast_vo_category_to_team( "recapture_generator_attacked", 3.5 );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x5f9cd1ac, Offset: 0x5808
// Size: 0x98
function get_emergence_hole_spawn_point()
{
    while ( true )
    {
        if ( isdefined( self.a_emergence_hole_structs ) && self.a_emergence_hole_structs.size > 0 )
        {
            s_spawn_point = self get_unused_emergence_hole_spawn_point();
            s_spawn_point.spawned_zombie = 1;
            return s_spawn_point;
        }
        else
        {
            self.a_emergence_hole_structs = struct::get_array( self.target, "targetname" );
        }
        
        wait 0.05;
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x511c2939, Offset: 0x58a8
// Size: 0x174
function get_unused_emergence_hole_spawn_point()
{
    a_valid_spawn_points = [];
    
    for ( b_all_points_used = 0; !a_valid_spawn_points.size ; b_all_points_used = 1 )
    {
        foreach ( s_emergence_hole in self.a_emergence_hole_structs )
        {
            if ( !isdefined( s_emergence_hole.spawned_zombie ) || b_all_points_used )
            {
                s_emergence_hole.spawned_zombie = 0;
            }
            
            if ( !s_emergence_hole.spawned_zombie )
            {
                if ( !isdefined( a_valid_spawn_points ) )
                {
                    a_valid_spawn_points = [];
                }
                else if ( !isarray( a_valid_spawn_points ) )
                {
                    a_valid_spawn_points = array( a_valid_spawn_points );
                }
                
                a_valid_spawn_points[ a_valid_spawn_points.size ] = s_emergence_hole;
            }
        }
        
        if ( !a_valid_spawn_points.size )
        {
        }
    }
    
    s_spawn_point = array::random( a_valid_spawn_points );
    return s_spawn_point;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xc6af090f, Offset: 0x5a28
// Size: 0x98
function emergence_hole_spawn()
{
    m_emergence_hole = spawn( "script_model", self.origin );
    m_emergence_hole.angles = self.angles;
    m_emergence_hole setmodel( "p7_zm_ori_dig_mound_hole" );
    util::wait_network_frame();
    m_emergence_hole clientfield::set( "zone_capture_emergence_hole", 1 );
    return m_emergence_hole;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x9e1c015c, Offset: 0x5ac8
// Size: 0xb4
function init_zone_capture_zombie_common( s_spawn_point )
{
    self setphysparams( 15, 0, 72 );
    self.ignore_enemy_count = 1;
    self.b_ignore_cleanup = 1;
    self zm_tomb_utility::dug_zombie_rise( s_spawn_point );
    self playsound( "zmb_vocals_capzomb_spawn" );
    self clientfield::set( "zone_capture_zombie", 1 );
    self init_anim_rate();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x7f1a1e0e, Offset: 0x5b88
// Size: 0x8c
function init_anim_rate()
{
    self asmsetanimationrate( 1 );
    self clientfield::set( "anim_rate", 1 );
    n_rate = self clientfield::get( "anim_rate" );
    self setentityanimrate( n_rate );
}

// Namespace zm_tomb_capture_zones
// Params 3
// Checksum 0x4af1a241, Offset: 0x5c20
// Size: 0x98
function zone_capture_gib_think( refs, point, weaponname )
{
    if ( isdefined( self.is_recapture_zombie ) && self.is_recapture_zombie )
    {
        arrayremovevalue( refs, "right_leg", 0 );
        arrayremovevalue( refs, "left_leg", 0 );
        arrayremovevalue( refs, "no_legs", 0 );
    }
    
    return refs;
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0xc92ef01d, Offset: 0x5cc0
// Size: 0xc4
function init_capture_zombie( zone_struct, s_spawn_point )
{
    self endon( #"death" );
    self init_zone_capture_zombie_common( s_spawn_point );
    
    if ( isdefined( self.zombie_move_speed ) && self.zombie_move_speed == "walk" )
    {
        self.zombie_move_speed = "run";
        self zombie_utility::set_zombie_run_cycle( "run" );
    }
    
    find_flesh_struct_string = "find_flesh";
    self notify( #"zombie_custom_think_done", find_flesh_struct_string );
    self thread capture_zombies_only_attack_nearby_players( zone_struct );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0xdf87f9c4, Offset: 0x5d90
// Size: 0xc8
function init_recapture_zombie( zone_struct, s_spawn_point )
{
    self endon( #"death" );
    self.is_recapture_zombie = 1;
    self.ignoremelee = 1;
    self ai::set_behavior_attribute( "use_attackable", 1 );
    self init_zone_capture_zombie_common( s_spawn_point );
    self.goalradius = 30;
    self zombie_utility::set_zombie_run_cycle( "sprint" );
    self.var_dfb19f30 = 1;
    set_recapture_zombie_attack_target( zone_struct );
    self.is_attacking_zone = 1;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xac500107, Offset: 0x5e60
// Size: 0x64
function capture_zombie_rise_fx( ai_zombie )
{
    playfx( level._effect[ "zone_capture_zombie_spawn" ], self.origin, anglestoforward( self.angles ), anglestoup( self.angles ) );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x1b226273, Offset: 0x5ed0
// Size: 0x250
function get_unclaimed_attack_point( s_zone )
{
    s_zone clean_up_unused_attack_points();
    n_claimed_center = s_zone get_claimed_attack_points_between_indicies( 0, 3 );
    n_claimed_left = s_zone get_claimed_attack_points_between_indicies( 4, 7 );
    n_claimed_right = s_zone get_claimed_attack_points_between_indicies( 8, 11 );
    b_use_center_pillar = n_claimed_center < 3;
    b_use_left_pillar = n_claimed_left < 1;
    b_use_right_pillar = n_claimed_right < 1;
    
    if ( b_use_center_pillar )
    {
        a_valid_attack_points = s_zone get_unclaimed_attack_points_between_indicies( 0, 3 );
    }
    else if ( b_use_left_pillar )
    {
        a_valid_attack_points = s_zone get_unclaimed_attack_points_between_indicies( 4, 7 );
    }
    else if ( b_use_right_pillar )
    {
        a_valid_attack_points = s_zone get_unclaimed_attack_points_between_indicies( 8, 11 );
    }
    else
    {
        a_valid_attack_points = s_zone get_unclaimed_attack_points_between_indicies( 0, 11 );
    }
    
    if ( a_valid_attack_points.size == 0 )
    {
        a_valid_attack_points = s_zone get_unclaimed_attack_points_between_indicies( 0, 11 );
    }
    
    assert( a_valid_attack_points.size > 0, "<dev string:x3f9>" + s_zone.script_noteworthy );
    s_attack_point = array::random( a_valid_attack_points );
    s_attack_point.is_claimed = 1;
    s_attack_point.claimed_by = self;
    return s_attack_point;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x48a59d4f, Offset: 0x6128
// Size: 0xb8
function clean_up_unused_attack_points()
{
    foreach ( s_attack_point in self.zombie_attack_points )
    {
        if ( s_attack_point.is_claimed && !isdefined( s_attack_point.claimed_by ) )
        {
            s_attack_point.is_claimed = 0;
            s_attack_point.claimed_by = undefined;
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0xf05f4ff4, Offset: 0x61e8
// Size: 0xf0
function get_unclaimed_attack_points_between_indicies( n_start, n_end )
{
    a_valid_attack_points = [];
    
    for ( i = n_start; i < n_end ; i++ )
    {
        if ( !self.zombie_attack_points[ i ].is_claimed && !self.zombie_attack_points[ i ].inaccessible )
        {
            if ( !isdefined( a_valid_attack_points ) )
            {
                a_valid_attack_points = [];
            }
            else if ( !isarray( a_valid_attack_points ) )
            {
                a_valid_attack_points = array( a_valid_attack_points );
            }
            
            a_valid_attack_points[ a_valid_attack_points.size ] = self.zombie_attack_points[ i ];
        }
    }
    
    return a_valid_attack_points;
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0xfba87a8b, Offset: 0x62e0
// Size: 0xd2
function get_claimed_attack_points_between_indicies( n_start, n_end )
{
    a_valid_points = [];
    
    for ( i = n_start; i < n_end ; i++ )
    {
        if ( self.zombie_attack_points[ i ].is_claimed )
        {
            if ( !isdefined( a_valid_points ) )
            {
                a_valid_points = [];
            }
            else if ( !isarray( a_valid_points ) )
            {
                a_valid_points = array( a_valid_points );
            }
            
            a_valid_points[ a_valid_points.size ] = self.zombie_attack_points[ i ];
        }
    }
    
    return a_valid_points.size;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x75fc2fb9, Offset: 0x63c0
// Size: 0x1a
function unclaim_attacking_point()
{
    self.is_claimed = 0;
    self.claimed_by = undefined;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x38e98146, Offset: 0x63e8
// Size: 0x8a
function clear_all_zombie_attack_points_in_zone()
{
    foreach ( s_attack_point in self.zombie_attack_points )
    {
        s_attack_point unclaim_attacking_point();
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xec85cf0b, Offset: 0x6480
// Size: 0x18c
function capture_zombies_only_attack_nearby_players( s_zone )
{
    self endon( #"death" );
    n_goal_radius = self.goalradius;
    
    while ( true )
    {
        self.goalradius = n_goal_radius;
        
        if ( self should_capture_zombie_attack_generator( s_zone ) )
        {
            self notify( #"stop_find_flesh" );
            self notify( #"zombie_acquire_enemy" );
            self.ignore_find_flesh = 1;
            self.goalradius = 30;
            
            if ( !isdefined( self.attacking_point ) )
            {
                self.attacking_point = self get_unclaimed_attack_point( s_zone );
            }
            
            self setgoalpos( self.attacking_point.origin );
            self thread cancel_generator_attack_if_player_gets_close_to_generator( s_zone );
            str_notify = self util::waittill_any_return( "goal", "stop_attacking_generator", "death" );
            
            if ( str_notify === "stop_attacking_generator" )
            {
                self.attacking_point unclaim_attacking_point();
            }
            else
            {
                self play_melee_attack_animation();
                continue;
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xde132778, Offset: 0x6618
// Size: 0x98
function cancel_generator_attack_if_player_gets_close_to_generator( s_zone )
{
    self notify( #"generator_attack_cancel_think" );
    self endon( #"generator_attack_cancel_think" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( !self should_capture_zombie_attack_generator( s_zone ) )
        {
            self notify( #"stop_attacking_generator" );
            self.ignore_find_flesh = 0;
            break;
        }
        
        wait randomfloatrange( 0.2, 1.5 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xc5e9f065, Offset: 0x66b8
// Size: 0x23e
function should_capture_zombie_attack_generator( s_zone )
{
    a_players = getplayers();
    a_valid_targets = arraysort( a_players, s_zone.origin, 1, undefined, 700 );
    
    foreach ( player in a_players )
    {
        if ( !isdefined( self.ignore_player ) )
        {
            self.ignore_player = [];
        }
        
        b_is_valid_target = isinarray( a_valid_targets, player ) && zombie_utility::is_player_valid( player );
        b_is_currently_ignored = isinarray( self.ignore_player, player );
        
        if ( b_is_valid_target && b_is_currently_ignored )
        {
            arrayremovevalue( self.ignore_player, player, 0 );
            continue;
        }
        
        if ( !b_is_valid_target && !b_is_currently_ignored )
        {
            if ( !isdefined( self.ignore_player ) )
            {
                self.ignore_player = [];
            }
            else if ( !isarray( self.ignore_player ) )
            {
                self.ignore_player = array( self.ignore_player );
            }
            
            self.ignore_player[ self.ignore_player.size ] = player;
        }
    }
    
    b_should_attack_generator = a_valid_targets.size == 0 || isdefined( self.enemy ) && self.ignore_player.size == a_players.size;
    return b_should_attack_generator;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x1e6c1c1c, Offset: 0x6900
// Size: 0x15e
function play_melee_attack_animation()
{
    self endon( #"death" );
    self endon( #"poi_state_changed" );
    v_angles = self.angles;
    
    if ( isdefined( self.attacking_point ) )
    {
        v_angles = self.attacking_point.v_center_pillar - self.origin;
        v_angles = vectortoangles( ( v_angles[ 0 ], v_angles[ 1 ], 0 ) );
    }
    
    var_ae686a3e = [];
    var_ae686a3e[ var_ae686a3e.size ] = "ai_zombie_base_ad_attack_v1";
    var_ae686a3e[ var_ae686a3e.size ] = "ai_zombie_base_ad_attack_v2";
    var_ae686a3e[ var_ae686a3e.size ] = "ai_zombie_base_ad_attack_v3";
    var_ae686a3e[ var_ae686a3e.size ] = "ai_zombie_base_ad_attack_v4";
    var_ae686a3e = array::randomize( var_ae686a3e );
    self animscripted( "attack_anim", self.origin, v_angles, var_ae686a3e[ 0 ] );
    time = getanimlength( var_ae686a3e[ 0 ] );
    wait time;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x3d1e9c46, Offset: 0x6a68
// Size: 0x17e
function recapture_zombie_poi_think()
{
    self endon( #"death" );
    self.zombie_has_point_of_interest = 0;
    
    while ( isdefined( self ) && isalive( self ) )
    {
        if ( isdefined( level._poi_override ) )
        {
            zombie_poi = self [[ level._poi_override ]]();
        }
        
        if ( !isdefined( zombie_poi ) )
        {
            zombie_poi = self zm_utility::get_zombie_point_of_interest( self.origin );
        }
        
        self.using_poi_last_check = self.zombie_has_point_of_interest;
        
        if ( isdefined( zombie_poi ) && isarray( zombie_poi ) && isdefined( zombie_poi[ 1 ] ) )
        {
            self.goalradius = 16;
            self.zombie_has_point_of_interest = 1;
            self.is_attacking_zone = 0;
            self.point_of_interest = zombie_poi[ 0 ];
        }
        else
        {
            self.goalradius = 30;
            self.zombie_has_point_of_interest = 0;
            self.point_of_interest = undefined;
            zombie_poi = undefined;
        }
        
        if ( self.using_poi_last_check != self.zombie_has_point_of_interest )
        {
            self notify( #"poi_state_changed" );
            self stopanimscripted( 0.2 );
        }
        
        wait 1;
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xf714a23f, Offset: 0x6bf0
// Size: 0x164
function kill_all_capture_zombies()
{
    while ( isdefined( self.capture_zombies ) && self.capture_zombies.size > 0 )
    {
        foreach ( zombie in self.capture_zombies )
        {
            if ( isdefined( zombie ) && isalive( zombie ) )
            {
                playfx( level._effect[ "tesla_elec_kill" ], zombie.origin );
                zombie dodamage( zombie.health + 100, zombie.origin );
            }
            
            util::wait_network_frame();
        }
        
        self.capture_zombies = array::remove_dead( self.capture_zombies );
    }
    
    self.capture_zombies = [];
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x74afdc67, Offset: 0x6d60
// Size: 0x194
function kill_all_recapture_zombies()
{
    while ( isdefined( level.zone_capture.recapture_zombies ) && level.zone_capture.recapture_zombies.size > 0 )
    {
        foreach ( zombie in level.zone_capture.recapture_zombies )
        {
            if ( isdefined( zombie ) && isalive( zombie ) )
            {
                playfx( level._effect[ "tesla_elec_kill" ], zombie.origin );
                zombie dodamage( zombie.health + 100, zombie.origin );
            }
            
            util::wait_network_frame();
        }
        
        level.zone_capture.recapture_zombies = array::remove_dead( level.zone_capture.recapture_zombies );
    }
    
    level.zone_capture.recapture_zombies = [];
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x3f757cb, Offset: 0x6f00
// Size: 0xb4, Type: bool
function is_capture_area_occupied( parent_zone )
{
    if ( parent_zone.is_occupied )
    {
        return true;
    }
    
    foreach ( s_child_zone in parent_zone.child_capture_zones )
    {
        if ( s_child_zone.is_occupied )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x943d4cf7, Offset: 0x6fc0
// Size: 0x44
function set_player_controlled_area()
{
    level.zone_capture.last_zone_captured = self;
    self set_player_controlled_zone();
    self play_pap_anim( 1 );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x601af2bb, Offset: 0x7010
// Size: 0x6c
function update_captured_zone_count()
{
    level.total_capture_zones = get_captured_zone_count();
    
    if ( level.total_capture_zones == 6 )
    {
        level flag::set( "all_zones_captured" );
        return;
    }
    
    level flag::clear( "all_zones_captured" );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x597bc2f6, Offset: 0x7088
// Size: 0xb6
function get_captured_zone_count()
{
    n_player_controlled_zones = 0;
    
    foreach ( generator in level.zone_capture.zones )
    {
        if ( generator flag::get( "player_controlled" ) )
        {
            n_player_controlled_zones++;
        }
    }
    
    return n_player_controlled_zones;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x116eef8a, Offset: 0x7148
// Size: 0x14
function get_contested_zone_count()
{
    return get_contested_zones().size;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xe0956fa3, Offset: 0x7168
// Size: 0x10c
function get_contested_zones()
{
    a_contested_zones = [];
    
    foreach ( generator in level.zone_capture.zones )
    {
        if ( generator flag::get( "zone_contested" ) )
        {
            if ( !isdefined( a_contested_zones ) )
            {
                a_contested_zones = [];
            }
            else if ( !isarray( a_contested_zones ) )
            {
                a_contested_zones = array( a_contested_zones );
            }
            
            a_contested_zones[ a_contested_zones.size ] = generator;
        }
    }
    
    return a_contested_zones;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x9cd09d61, Offset: 0x7280
// Size: 0x232
function set_player_controlled_zone()
{
    if ( !self flag::get( "player_controlled" ) )
    {
        foreach ( e_player in level.players )
        {
            e_player thread zm_craftables::player_show_craftable_parts_ui( undefined, "zmInventory.capture_generator_wheel_widget", 0 );
        }
    }
    
    self flag::set( "player_controlled" );
    self flag::clear( "attacked_by_recapture_zombies" );
    level clientfield::set( "zone_capture_hud_generator_" + self.script_int, 1 );
    level clientfield::set( "zone_capture_monolith_crystal_" + self.script_int, 0 );
    
    if ( !isdefined( self.perk_fx_func ) || [[ self.perk_fx_func ]]() )
    {
        level clientfield::set( "zone_capture_perk_machine_smoke_fx_" + self.script_int, 1 );
    }
    
    self flag::set( "player_controlled" );
    update_captured_zone_count();
    self enable_perk_machines_in_zone();
    self enable_random_perk_machines_in_zone();
    self enable_mystery_boxes_in_zone();
    self function_c3b54f6d();
    level notify( #"zone_captured_by_player", self.str_zone );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xf551827b, Offset: 0x74c0
// Size: 0x10c
function set_zombie_controlled_area( b_is_level_initializing )
{
    if ( !isdefined( b_is_level_initializing ) )
    {
        b_is_level_initializing = 0;
    }
    
    update_captured_zone_count();
    
    if ( b_is_level_initializing )
    {
        level clientfield::set( "state_" + self.script_noteworthy, 3 );
        util::wait_network_frame();
        level clientfield::set( "state_" + self.script_noteworthy, 0 );
    }
    
    if ( self flag::get( "player_controlled" ) )
    {
        level flag::set( "generator_lost_to_recapture_zombies" );
    }
    
    self set_zombie_controlled_zone( b_is_level_initializing );
    self play_pap_anim( 0 );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xaab66034, Offset: 0x75d8
// Size: 0xc4
function function_b0debead()
{
    level flag::wait_till( "start_zombie_round_logic" );
    n_zone_count = get_captured_zone_count();
    
    if ( n_zone_count > 0 )
    {
        level clientfield::set( "packapunch_anim", 0 );
        return;
    }
    
    if ( n_zone_count == 0 )
    {
        level clientfield::set( "packapunch_anim", 6 );
        wait 5;
        level clientfield::set( "packapunch_anim", 0 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x2775089c, Offset: 0x76a8
// Size: 0x3c
function play_pap_anim( b_assemble )
{
    level clientfield::set( "packapunch_anim", get_captured_zone_count() );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x7ee2addd, Offset: 0x76f0
// Size: 0x204
function set_zombie_controlled_zone( b_is_level_initializing )
{
    if ( !isdefined( b_is_level_initializing ) )
    {
        b_is_level_initializing = 0;
    }
    
    n_hud_state = 2;
    
    if ( b_is_level_initializing )
    {
        n_hud_state = 0;
    }
    
    if ( !b_is_level_initializing && self flag::get( "player_controlled" ) )
    {
        foreach ( e_player in level.players )
        {
            e_player thread zm_craftables::player_show_craftable_parts_ui( undefined, "zmInventory.capture_generator_wheel_widget", 0 );
        }
    }
    
    self flag::clear( "player_controlled" );
    level clientfield::set( "zone_capture_hud_generator_" + self.script_int, n_hud_state );
    level clientfield::set( "zone_capture_monolith_crystal_" + self.script_int, 1 );
    level clientfield::set( "zone_capture_perk_machine_smoke_fx_" + self.script_int, 0 );
    update_captured_zone_count();
    self disable_perk_machines_in_zone();
    self disable_random_perk_machines_in_zone();
    self disable_mystery_boxes_in_zone();
    
    if ( !b_is_level_initializing )
    {
        self function_1138b343();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x16a71f90, Offset: 0x7900
// Size: 0x3c
function function_c3b54f6d()
{
    var_43157bc9 = "power_on" + self.script_int;
    level flag::set( var_43157bc9 );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xa3b371, Offset: 0x7948
// Size: 0x3c
function function_1138b343()
{
    var_43157bc9 = "power_on" + self.script_int;
    level flag::clear( var_43157bc9 );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x8e64ec44, Offset: 0x7990
// Size: 0x484
function capture_progress_think()
{
    self init_capture_progress();
    self clear_zone_objective_index();
    self show_zone_capture_objective( 1 );
    self get_zone_objective_index();
    
    while ( self flag::get( "zone_contested" ) )
    {
        a_players = getplayers();
        a_players_in_capture_zone = self get_players_in_capture_zone();
        
        foreach ( player in a_players )
        {
            if ( isinarray( a_players_in_capture_zone, player ) )
            {
                if ( !level flag::get( "recapture_event_in_progress" ) || !self flag::get( "current_recapture_target_zone" ) )
                {
                    objective_setplayerusing( self.n_objective_index, player );
                }
                
                continue;
            }
            
            if ( zombie_utility::is_player_valid( player ) )
            {
                objective_clearplayerusing( self.n_objective_index, player );
            }
        }
        
        self.n_last_progress = self.n_current_progress;
        self.n_current_progress += self get_progress_rate( a_players_in_capture_zone.size, a_players.size );
        
        if ( self.n_last_progress != self.n_current_progress )
        {
            self.n_current_progress = math::clamp( self.n_current_progress, 0, 100 );
            objective_setprogress( self.n_objective_index, self.n_current_progress / 100 );
            self zone_capture_sound_state_think();
            level clientfield::set( self.script_noteworthy, self.n_current_progress / 100 );
            self generator_set_state();
            
            if ( !level flag::get( "recapture_event_in_progress" ) || !self flag::get( "attacked_by_recapture_zombies" ) )
            {
                b_set_color_to_white = a_players_in_capture_zone.size > 0;
                
                if ( !level flag::get( "recapture_event_in_progress" ) && self flag::get( "current_recapture_target_zone" ) )
                {
                    b_set_color_to_white = 1;
                }
                
                level clientfield::set( "zc_change_progress_bar_color", b_set_color_to_white );
            }
            
            update_objective_on_momentum_change();
            
            if ( self.n_current_progress == 100 && ( self.n_current_progress == 0 || !self flag::get( "attacked_by_recapture_zombies" ) ) )
            {
                self flag::clear( "zone_contested" );
            }
        }
        
        show_zone_capture_debug_info();
        wait 0.1;
    }
    
    self flag::clear( "attacked_by_recapture_zombies" );
    self handle_generator_capture();
    self clear_all_zombie_attack_points_in_zone();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x852abacc, Offset: 0x7e20
// Size: 0xbc
function update_objective_on_momentum_change()
{
    if ( self flag::get( "current_recapture_target_zone" ) && !level flag::get( "recapture_event_in_progress" ) && self.n_objective_index == 1 && self.n_current_progress > self.n_last_progress )
    {
        self clear_zone_objective_index();
        self show_zone_capture_objective( 1 );
        level clientfield::set( "zc_change_progress_bar_color", 1 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x18a5413b, Offset: 0x7ee8
// Size: 0x8e
function get_zone_objective_index()
{
    if ( !isdefined( self.n_objective_index ) )
    {
        if ( self flag::get( "current_recapture_target_zone" ) )
        {
            if ( level flag::get( "recapture_event_in_progress" ) )
            {
                n_objective = 1;
            }
            else
            {
                n_objective = 2;
            }
        }
        else
        {
            n_objective = 0;
        }
        
        self.n_objective_index = n_objective;
    }
    
    return self.n_objective_index;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x43d85fcd, Offset: 0x7f80
// Size: 0xc8
function get_zones_using_objective_index( n_index )
{
    n_zones_using_objective_index = 0;
    
    foreach ( zone in level.zone_capture.zones )
    {
        if ( isdefined( zone.n_objective_index ) && zone.n_objective_index == n_index )
        {
            n_zones_using_objective_index++;
        }
    }
    
    return n_zones_using_objective_index;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xf90bf41a, Offset: 0x8050
// Size: 0xc0
function zone_capture_sound_state_think()
{
    if ( !isdefined( self.is_playing_audio ) )
    {
        self.is_playing_audio = 0;
    }
    
    if ( self.n_current_progress > self.n_last_progress )
    {
        if ( self.is_playing_audio )
        {
            self.sndent stoploopsound();
            self.is_playing_audio = 0;
        }
        
        return;
    }
    
    if ( !self.is_playing_audio && level flag::get( "generator_under_attack" ) )
    {
        self.sndent playloopsound( "zmb_capturezone_generator_alarm", 0.25 );
        self.is_playing_audio = 1;
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x2b243ea1, Offset: 0x8118
// Size: 0x4c
function function_d545328()
{
    self show_zone_capture_objective( 0 );
    util::wait_network_frame();
    level clientfield::set( "zc_change_progress_bar_color", 0 );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x7152e599, Offset: 0x8170
// Size: 0x194
function handle_generator_capture()
{
    self thread function_d545328();
    
    if ( self.n_current_progress == 100 )
    {
        self players_capture_zone();
        self kill_all_capture_zombies();
        level clientfield::set( "state_" + self.script_noteworthy, 6 );
    }
    else if ( self.n_current_progress == 0 )
    {
        if ( self flag::get( "player_controlled" ) )
        {
            self.sndent stoploopsound( 0.25 );
            self thread generator_deactivated_vo();
            self.is_playing_audio = 0;
        }
        
        self set_zombie_controlled_area();
        
        if ( level flag::get( "recapture_event_in_progress" ) && get_captured_zone_count() > 0 )
        {
        }
        else
        {
            self kill_all_capture_zombies();
        }
    }
    
    if ( get_contested_zone_count() == 0 )
    {
        level flag::clear( "zone_capture_in_progress" );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x657e2fbe, Offset: 0x8310
// Size: 0x194
function init_capture_progress()
{
    if ( !isdefined( level.zone_capture.rate_capture ) )
    {
        level.zone_capture.rate_capture = get_update_rate( 10 );
    }
    
    if ( !isdefined( level.zone_capture.rate_capture_solo ) )
    {
        level.zone_capture.rate_capture_solo = get_update_rate( 12 );
    }
    
    if ( !isdefined( level.zone_capture.rate_decay ) )
    {
        level.zone_capture.rate_decay = get_update_rate( 20 ) * -1;
    }
    
    if ( !isdefined( level.zone_capture.rate_recapture ) )
    {
        level.zone_capture.rate_recapture = get_update_rate( 40 ) * -1;
    }
    
    if ( !isdefined( level.zone_capture.rate_recapture_players ) )
    {
        level.zone_capture.rate_recapture_players = get_update_rate( 10 );
    }
    
    if ( !self flag::get( "player_controlled" ) )
    {
        self.n_current_progress = 0;
        self flag::clear( "attacked_by_recapture_zombies" );
    }
    
    self flag::set( "zone_contested" );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0x4a2978ee, Offset: 0x84b0
// Size: 0x18c
function get_progress_rate( n_players_in_zone, n_players_total )
{
    if ( level flag::get( "recapture_event_in_progress" ) && self flag::get( "current_recapture_target_zone" ) )
    {
        if ( self get_recapture_attacker_count() > 0 )
        {
            n_rate = level.zone_capture.rate_recapture;
        }
        else if ( !self flag::get( "attacked_by_recapture_zombies" ) )
        {
            n_rate = 0;
        }
        else
        {
            n_rate = level.zone_capture.rate_recapture_players;
        }
    }
    else if ( self flag::get( "current_recapture_target_zone" ) )
    {
        n_rate = level.zone_capture.rate_recapture_players;
    }
    else if ( n_players_in_zone > 0 )
    {
        if ( level.players.size == 1 )
        {
            n_rate = level.zone_capture.rate_capture_solo;
        }
        else
        {
            n_rate = level.zone_capture.rate_capture * n_players_in_zone / n_players_total;
        }
    }
    else
    {
        n_rate = level.zone_capture.rate_decay;
    }
    
    return n_rate;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x5d440eba, Offset: 0x8648
// Size: 0xac
function show_zone_capture_objective( b_show_objective )
{
    self get_zone_objective_index();
    
    if ( b_show_objective )
    {
        objective_add( self.n_objective_index, "active", self.origin, istring( "zm_dlc5_capture_generator" + self.script_int ) );
        objective_setvisibletoall( self.n_objective_index );
        return;
    }
    
    self clear_zone_objective_index();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xff16d838, Offset: 0x8700
// Size: 0x102
function clear_zone_objective_index()
{
    if ( isdefined( self.n_objective_index ) && get_zones_using_objective_index( self.n_objective_index ) < 2 )
    {
        objective_state( self.n_objective_index, "invisible" );
        a_players = getplayers();
        
        foreach ( player in a_players )
        {
            objective_clearplayerusing( self.n_objective_index, player );
        }
    }
    
    self.n_objective_index = undefined;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xac4dda9d, Offset: 0x8810
// Size: 0xcc
function hide_zone_objective_while_recapture_group_runs_to_next_generator( b_hide_icon )
{
    self clear_zone_objective_index();
    level flag::clear( "generator_under_attack" );
    
    if ( !b_hide_icon )
    {
        recapture_zombie_group_icon_show();
    }
    
    do
    {
        wait 1;
    }
    while ( !level flag::get( "recapture_zombies_cleared" ) && self get_recapture_attacker_count() == 0 );
    
    if ( !level flag::get( "recapture_zombies_cleared" ) )
    {
        self thread generator_compromised_vo();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x2501b18f, Offset: 0x88e8
// Size: 0x154
function recapture_zombie_group_icon_show()
{
    level endon( #"recapture_zombies_cleared" );
    
    if ( isdefined( level.zone_capture.recapture_zombies ) && level flag::get( "recapture_event_in_progress" ) )
    {
        while ( !level.zone_capture.recapture_zombies.size )
        {
            util::wait_network_frame();
            level.zone_capture.recapture_zombies = array::remove_dead( level.zone_capture.recapture_zombies );
        }
        
        level flag::wait_till_clear( "generator_under_attack" );
        
        if ( level.zone_capture.recapture_zombies.size > 0 )
        {
            ai_zombie = array::random( level.zone_capture.recapture_zombies );
            objective_add( 3, "active", ai_zombie, istring( "zm_dlc5_recapture_zombie" ) );
            ai_zombie thread recapture_zombie_icon_think();
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xe3e2901f, Offset: 0x8a48
// Size: 0xcc
function recapture_zombie_icon_think()
{
    while ( isalive( self ) && !level flag::get( "generator_under_attack" ) )
    {
        /#
            debugstar( self.origin, 20, ( 1, 0, 0 ) );
        #/
        
        wait 1;
    }
    
    recapture_zombie_group_icon_hide();
    util::wait_network_frame();
    
    if ( !level flag::get( "recapture_zombies_cleared" ) )
    {
        recapture_zombie_group_icon_show();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x5bfbba3e, Offset: 0x8b20
// Size: 0x54
function recapture_zombie_group_icon_hide()
{
    objective_state( 3, "invisible" );
    
    if ( isalive( self ) )
    {
        objective_clearentity( 3 );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xef99d03a, Offset: 0x8b80
// Size: 0x154
function players_capture_zone()
{
    self.sndent playsound( "zmb_capturezone_success" );
    self.sndent stoploopsound( 0.25 );
    util::wait_network_frame();
    
    if ( !level flag::get( "recapture_event_in_progress" ) && !self flag::get( "player_controlled" ) )
    {
        self thread zone_capture_complete_vo();
    }
    
    reward_players_in_capture_zone();
    self set_player_controlled_area();
    
    if ( isdefined( self.var_ea997a3c ) )
    {
        self refund_generator_cost_if_player_captured_it( self.var_ea997a3c );
    }
    
    util::wait_network_frame();
    playfx( level._effect[ "capture_complete" ], self.origin );
    level thread sndplaygeneratormusicstinger();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xca233ce8, Offset: 0x8ce0
// Size: 0x11a
function reward_players_in_capture_zone()
{
    b_challenge_exists = zm_challenges_tomb::challenge_exists( "zc_zone_captures" );
    
    if ( !self flag::get( "player_controlled" ) )
    {
        foreach ( player in get_players_in_capture_zone() )
        {
            player notify( #"completed_zone_capture" );
            player zm_score::player_add_points( "bonus_points_powerup", 100 );
            
            if ( b_challenge_exists )
            {
                player zm_challenges_tomb::increment_stat( "zc_zone_captures" );
            }
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xf15341a1, Offset: 0x8e08
// Size: 0x1d2
function show_zone_capture_debug_info()
{
    /#
        if ( getdvarint( "<dev string:x445>" ) > 0 )
        {
            print3d( self.origin, "<dev string:x458>" + self.n_current_progress, ( 0, 1, 0 ) );
            circle( groundtrace( self.origin, self.origin - ( 0, 0, 1000 ), 0, undefined )[ "<dev string:x464>" ], 220, ( 0, 1, 0 ), 0, 4 );
            
            foreach ( n_index, attack_point in self.zombie_attack_points )
            {
                if ( attack_point.inaccessible )
                {
                    v_color = ( 1, 1, 1 );
                }
                else if ( attack_point.is_claimed )
                {
                    v_color = ( 1, 0, 0 );
                }
                else
                {
                    v_color = ( 0, 1, 0 );
                }
                
                debugstar( attack_point.origin, 4, v_color );
                print3d( attack_point.origin + ( 0, 0, 10 ), n_index, v_color, 1, 1, 4 );
            }
        }
    #/
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xf57de2b9, Offset: 0x8fe8
// Size: 0x164
function get_players_in_capture_zone()
{
    a_players_in_capture_zone = [];
    
    foreach ( player in getplayers() )
    {
        if ( zombie_utility::is_player_valid( player ) && distance2dsquared( player.origin, self.origin ) < 48400 && player.origin[ 2 ] > self.origin[ 2 ] + -20 )
        {
            if ( !isdefined( a_players_in_capture_zone ) )
            {
                a_players_in_capture_zone = [];
            }
            else if ( !isarray( a_players_in_capture_zone ) )
            {
                a_players_in_capture_zone = array( a_players_in_capture_zone );
            }
            
            a_players_in_capture_zone[ a_players_in_capture_zone.size ] = player;
        }
    }
    
    return a_players_in_capture_zone;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xf0be75a3, Offset: 0x9158
// Size: 0x32
function get_update_rate( n_duration )
{
    n_change_per_update = 100 / n_duration * 0.1;
    return n_change_per_update;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x1b205db3, Offset: 0x9198
// Size: 0x134
function generator_set_state()
{
    n_generator_state = level clientfield::get( "state_" + self.script_noteworthy );
    
    if ( self.n_current_progress == 0 )
    {
        self generator_state_turn_off();
        return;
    }
    
    if ( n_generator_state == 0 && self.n_current_progress > 0 )
    {
        self generator_state_turn_on();
        return;
    }
    
    if ( self can_start_generator_power_up_anim() )
    {
        self generator_state_power_up();
        return;
    }
    
    if ( n_generator_state == 2 && self.n_current_progress < self.n_last_progress )
    {
        self generator_state_power_down();
        
        if ( !level flag::get( "recapture_event_in_progress" ) )
        {
            self thread generator_interrupted_vo();
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x48311ed8, Offset: 0x92d8
// Size: 0x38
function generator_state_turn_on()
{
    level clientfield::set( "state_" + self.script_noteworthy, 1 );
    self.n_time_started_generator = gettime();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xb8a59107, Offset: 0x9318
// Size: 0x2c
function generator_state_power_up()
{
    level clientfield::set( "state_" + self.script_noteworthy, 2 );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xe8e65740, Offset: 0x9350
// Size: 0x6c
function generator_state_power_down()
{
    if ( self flag::get( "attacked_by_recapture_zombies" ) )
    {
        n_state = 5;
    }
    else
    {
        n_state = 3;
    }
    
    level clientfield::set( "state_" + self.script_noteworthy, n_state );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xb1d41dca, Offset: 0x93c8
// Size: 0x44
function generator_state_turn_off()
{
    level clientfield::set( "state_" + self.script_noteworthy, 4 );
    self thread generator_turns_off_after_anim();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x5a4c83cb, Offset: 0x9418
// Size: 0x3c
function generator_turns_off_after_anim()
{
    wait getanimlength( %p7_fxanim_zm_ori_generator_end_anim );
    self generator_state_off();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xac867058, Offset: 0x9460
// Size: 0x2c
function generator_state_off()
{
    level clientfield::set( "state_" + self.script_noteworthy, 0 );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x67c4c6b4, Offset: 0x9498
// Size: 0x84, Type: bool
function can_start_generator_power_up_anim()
{
    if ( !isdefined( self.n_time_started_generator ) )
    {
        self.n_time_started_generator = 0;
    }
    
    if ( !isdefined( self.n_time_start_anim ) )
    {
        self.n_time_start_anim = getanimlength( %p7_fxanim_zm_ori_generator_start_anim );
    }
    
    return self.n_current_progress > self.n_last_progress && ( gettime() - self.n_time_started_generator ) * 0.001 > self.n_time_start_anim;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xd5bfe571, Offset: 0x9528
// Size: 0xf0
function get_recapture_attacker_count()
{
    n_zone_attacker_count = 0;
    
    foreach ( zombie in level.zone_capture.recapture_zombies )
    {
        if ( isdefined( zombie.is_attacking_zone ) && isalive( zombie ) && zombie.is_attacking_zone && self.script_noteworthy === level.zone_capture.recapture_target )
        {
            n_zone_attacker_count++;
        }
    }
    
    return n_zone_attacker_count;
}

/#

    // Namespace zm_tomb_capture_zones
    // Params 0
    // Checksum 0xcfc60a01, Offset: 0x9620
    // Size: 0x112, Type: dev
    function watch_for_open_sesame()
    {
        level waittill( #"open_sesame" );
        level.b_open_sesame = 1;
        a_generators = struct::get_array( "<dev string:x46d>", "<dev string:x479>" );
        
        foreach ( s_generator in a_generators )
        {
            s_temp = level.zone_capture.zones[ s_generator.script_noteworthy ];
            s_temp debug_set_generator_active();
            util::wait_network_frame();
        }
    }

    // Namespace zm_tomb_capture_zones
    // Params 0
    // Checksum 0x64e5ef23, Offset: 0x9740
    // Size: 0xee, Type: dev
    function debug_watch_for_zone_capture()
    {
        while ( true )
        {
            level waittill( #"force_zone_capture", n_zone );
            
            foreach ( zone in level.zone_capture.zones )
            {
                if ( zone.script_int == n_zone && !zone flag::get( "<dev string:x484>" ) )
                {
                    zone debug_set_generator_active();
                }
            }
        }
    }

    // Namespace zm_tomb_capture_zones
    // Params 0
    // Checksum 0xd0ecf56c, Offset: 0x9838
    // Size: 0xee, Type: dev
    function debug_watch_for_zone_recapture()
    {
        while ( true )
        {
            level waittill( #"force_zone_recapture", n_zone );
            
            foreach ( zone in level.zone_capture.zones )
            {
                if ( zone.script_int == n_zone && zone flag::get( "<dev string:x484>" ) )
                {
                    zone debug_set_generator_inactive();
                }
            }
        }
    }

    // Namespace zm_tomb_capture_zones
    // Params 0
    // Checksum 0x859094b3, Offset: 0x9930
    // Size: 0x64, Type: dev
    function debug_set_generator_active()
    {
        self set_player_controlled_area();
        self.n_current_progress = 100;
        self generator_state_power_up();
        level clientfield::set( self.script_noteworthy, self.n_current_progress / 100 );
    }

    // Namespace zm_tomb_capture_zones
    // Params 0
    // Checksum 0xd4494bfb, Offset: 0x99a0
    // Size: 0x64, Type: dev
    function debug_set_generator_inactive()
    {
        self set_zombie_controlled_area();
        self.n_current_progress = 0;
        self generator_state_turn_off();
        level clientfield::set( self.script_noteworthy, self.n_current_progress / 100 );
    }

#/

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x7c75d9a0, Offset: 0x9a10
// Size: 0x50a
function set_magic_box_zbarrier_state( state )
{
    for ( i = 0; i < self getnumzbarrierpieces() ; i++ )
    {
        self hidezbarrierpiece( i );
    }
    
    self notify( #"zbarrier_state_change" );
    
    switch ( state )
    {
        case "away":
            self showzbarrierpiece( 0 );
            self.state = "away";
            self.owner.is_locked = 0;
            break;
        case "arriving":
            self showzbarrierpiece( 1 );
            self thread tomb_magicbox::magic_box_arrives();
            self.state = "arriving";
            break;
        case "initial":
            self showzbarrierpiece( 1 );
            self thread zm_magicbox::magic_box_initial();
            thread zm_unitrigger::register_static_unitrigger( self.owner.unitrigger_stub, &zm_magicbox::magicbox_unitrigger_think );
            self.state = "close";
            break;
        case "open":
            self showzbarrierpiece( 2 );
            self thread tomb_magicbox::magic_box_opens();
            self.state = "open";
            break;
        case "close":
            self showzbarrierpiece( 2 );
            self thread tomb_magicbox::magic_box_closes();
            self.state = "close";
            break;
        case "leaving":
            self showzbarrierpiece( 1 );
            self thread tomb_magicbox::magic_box_leaves();
            self.state = "leaving";
            self.owner.is_locked = 0;
            break;
        case "zombie_controlled":
            if ( isdefined( level.zombie_vars[ "zombie_powerup_fire_sale_on" ] ) && level.zombie_vars[ "zombie_powerup_fire_sale_on" ] )
            {
                self showzbarrierpiece( 2 );
                self clientfield::set( "magicbox_amb_fx", 0 );
            }
            
            if ( self.state == "initial" || self.state == "close" )
            {
                self showzbarrierpiece( 1 );
                self clientfield::set( "magicbox_amb_fx", 1 );
            }
            else if ( self.state == "away" )
            {
                self showzbarrierpiece( 0 );
                self clientfield::set( "magicbox_amb_fx", 0 );
            }
            else if ( self.state == "open" || self.state == "leaving" )
            {
                self showzbarrierpiece( 2 );
                self clientfield::set( "magicbox_amb_fx", 0 );
            }
            
            break;
        case "player_controlled":
            if ( self.state == "arriving" || self.state == "close" )
            {
                self showzbarrierpiece( 2 );
                self clientfield::set( "magicbox_amb_fx", 2 );
                break;
            }
            
            if ( self.state == "away" )
            {
                self showzbarrierpiece( 0 );
                self clientfield::set( "magicbox_amb_fx", 3 );
            }
            
            break;
        default:
            if ( isdefined( level.custom_magicbox_state_handler ) )
            {
                self [[ level.custom_magicbox_state_handler ]]( state );
            }
            
            break;
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x59719c2b, Offset: 0x9f28
// Size: 0x90
function magic_box_trigger_update_prompt( player )
{
    can_use = self magic_box_stub_update_prompt( player );
    
    if ( isdefined( self.hint_string ) )
    {
        if ( isdefined( self.hint_parm1 ) )
        {
            self sethintstring( self.hint_string, self.hint_parm1 );
        }
        else
        {
            self sethintstring( self.hint_string );
        }
    }
    
    return can_use;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x8ed0d6e, Offset: 0x9fc0
// Size: 0x1d0, Type: bool
function magic_box_stub_update_prompt( player )
{
    if ( !self zm_magicbox::trigger_visible_to_player( player ) )
    {
        return false;
    }
    
    self.hint_parm1 = undefined;
    
    if ( isdefined( self.stub.trigger_target.grab_weapon_hint ) && self.stub.trigger_target.grab_weapon_hint )
    {
        cursor_hint = "HINT_WEAPON";
        cursor_hint_weapon = self.stub.trigger_target.grab_weapon;
        self setcursorhint( cursor_hint, cursor_hint_weapon );
        
        if ( isdefined( level.magic_box_check_equipment ) && [[ level.magic_box_check_equipment ]]( cursor_hint_weapon ) )
        {
            self.hint_string = &"ZOMBIE_TRADE_EQUIP_FILL";
        }
        else
        {
            self.hint_string = &"ZOMBIE_TRADE_WEAPON_FILL";
        }
    }
    else
    {
        self setcursorhint( "HINT_NOICON" );
        
        if ( !level.zone_capture.zones[ self.stub.zone ] flag::get( "player_controlled" ) )
        {
            self.hint_string = &"ZM_TOMB_ZC";
            return false;
        }
        else
        {
            self.hint_parm1 = self.stub.trigger_target.zombie_cost;
            self.hint_string = zm_utility::get_hint_string( self, "default_treasure_chest" );
        }
    }
    
    return true;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x49cac944, Offset: 0xa198
// Size: 0x138
function recapture_round_tracker()
{
    n_next_recapture_round = 10;
    
    while ( true )
    {
        /#
            iprintln( "<dev string:x496>" + n_next_recapture_round );
        #/
        
        level util::waittill_any( "between_round_over", "force_recapture_start" );
        
        /#
            if ( getdvarint( "<dev string:x4ae>" ) > 0 )
            {
                n_next_recapture_round = level.round_number;
            }
        #/
        
        if ( level.round_number >= n_next_recapture_round && !level flag::get( "zone_capture_in_progress" ) && get_captured_zone_count() >= get_player_controlled_zone_count_for_recapture() )
        {
            n_next_recapture_round = level.round_number + randomintrange( 3, 6 );
            level thread recapture_round_start();
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x938ad78d, Offset: 0xa2d8
// Size: 0x48
function get_player_controlled_zone_count_for_recapture()
{
    n_zones_required = 4;
    
    /#
        if ( getdvarint( "<dev string:x4ae>" ) > 0 )
        {
            n_zones_required = 1;
        }
    #/
    
    return n_zones_required;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xe355cd67, Offset: 0xa328
// Size: 0x2e6
function get_recapture_zone( s_last_recapture_zone )
{
    a_s_player_zones = [];
    
    foreach ( str_key, s_zone in level.zone_capture.zones )
    {
        if ( s_zone flag::get( "player_controlled" ) )
        {
            a_s_player_zones[ str_key ] = s_zone;
        }
    }
    
    s_recapture_zone = undefined;
    
    if ( a_s_player_zones.size )
    {
        if ( isdefined( s_last_recapture_zone ) )
        {
            n_distance_closest = undefined;
            
            foreach ( s_zone in a_s_player_zones )
            {
                n_distance = distancesquared( s_zone.origin, s_last_recapture_zone.origin );
                
                if ( !isdefined( n_distance_closest ) || n_distance < n_distance_closest )
                {
                    s_recapture_zone = s_zone;
                    n_distance_closest = n_distance;
                }
            }
        }
        else
        {
            s_recapture_zone = array::random( a_s_player_zones );
            
            /#
                if ( getdvarint( "<dev string:x4c2>" ) > 0 )
                {
                    n_zone = getdvarint( "<dev string:x4c2>" );
                    
                    foreach ( zone in level.zone_capture.zones )
                    {
                        if ( n_zone == zone.script_int && zone flag::get( "<dev string:x484>" ) )
                        {
                            s_recapture_zone = zone;
                            break;
                        }
                    }
                }
            #/
        }
    }
    
    return s_recapture_zone;
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x9cba1971, Offset: 0xa618
// Size: 0x554
function recapture_round_start()
{
    level flag::set( "recapture_event_in_progress" );
    level flag::clear( "recapture_zombies_cleared" );
    level flag::clear( "generator_under_attack" );
    level.recapture_zombies_killed = 0;
    b_is_first_generator_attack = 1;
    s_recapture_target_zone = undefined;
    capture_event_handle_ai_limit();
    recapture_round_audio_starts();
    var_c746b61a = struct::get_array( "generator_attackable", "targetname" );
    
    foreach ( var_b454101b in var_c746b61a )
    {
        var_b454101b zm_attackables::deactivate();
        var_b454101b.health = 1000000;
        var_b454101b.max_health = var_b454101b.health;
        var_b454101b.aggro_distance = 1024;
    }
    
    while ( !level flag::get( "recapture_zombies_cleared" ) && get_captured_zone_count() > 0 )
    {
        s_recapture_target_zone = get_recapture_zone( s_recapture_target_zone );
        var_28e07566 = s_recapture_target_zone.var_b454101b;
        level.zone_capture.recapture_target = s_recapture_target_zone.script_noteworthy;
        level.zone_capture.var_186a84eb = var_28e07566;
        s_recapture_target_zone zm_tomb_capture_zones_ffotd::recapture_event_start();
        var_28e07566 zm_attackables::activate();
        
        if ( b_is_first_generator_attack )
        {
            s_recapture_target_zone thread monitor_recapture_zombies();
            util::delay( 10, undefined, &broadcast_vo_category_to_team, "recapture_generator_attacked" );
        }
        
        s_recapture_target_zone thread generator_under_attack_warnings();
        s_recapture_target_zone flag::set( "current_recapture_target_zone" );
        s_recapture_target_zone thread hide_zone_objective_while_recapture_group_runs_to_next_generator( b_is_first_generator_attack );
        s_recapture_target_zone activate_capture_zone( b_is_first_generator_attack );
        s_recapture_target_zone flag::clear( "attacked_by_recapture_zombies" );
        s_recapture_target_zone flag::clear( "current_recapture_target_zone" );
        var_28e07566 zm_attackables::deactivate();
        
        if ( !s_recapture_target_zone flag::get( "player_controlled" ) )
        {
            util::delay( 3, undefined, &broadcast_vo_category_to_team, "recapture_started" );
        }
        
        b_is_first_generator_attack = 0;
        s_recapture_target_zone zm_tomb_capture_zones_ffotd::recapture_event_end();
        wait 0.05;
    }
    
    if ( s_recapture_target_zone.n_current_progress == 0 || s_recapture_target_zone.n_current_progress == 100 )
    {
        s_recapture_target_zone handle_generator_capture();
    }
    
    capture_event_handle_ai_limit();
    kill_all_recapture_zombies();
    recapture_round_audio_ends();
    var_c746b61a = struct::get_array( "generator_attackable", "targetname" );
    
    foreach ( var_b454101b in var_c746b61a )
    {
        var_b454101b zm_attackables::deactivate();
    }
    
    level flag::clear( "recapture_event_in_progress" );
    level flag::clear( "generator_under_attack" );
}

// Namespace zm_tomb_capture_zones
// Params 2
// Checksum 0x77c5b782, Offset: 0xab78
// Size: 0x17e
function broadcast_vo_category_to_team( str_category, n_delay )
{
    if ( !isdefined( n_delay ) )
    {
        n_delay = 1;
    }
    
    a_players = getplayers();
    a_speakers = [];
    
    do
    {
        e_speaker = get_random_speaker( a_players );
        
        if ( !isdefined( a_speakers ) )
        {
            a_speakers = [];
        }
        else if ( !isarray( a_speakers ) )
        {
            a_speakers = array( a_speakers );
        }
        
        a_speakers[ a_speakers.size ] = e_speaker;
        arrayremovevalue( a_players, e_speaker );
        a_players = e_speaker get_players_too_far_to_hear( a_players );
    }
    while ( a_players.size > 0 );
    
    for ( i = 0; i < a_speakers.size ; i++ )
    {
        a_speakers[ i ] util::delay( n_delay, undefined, &zm_audio::create_and_play_dialog, "zone_capture", str_category );
    }
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0xceda071, Offset: 0xad00
// Size: 0x14c
function get_players_too_far_to_hear( a_players )
{
    a_distant = [];
    
    foreach ( player in a_players )
    {
        if ( distancesquared( player.origin, self.origin ) > 640000 && zombie_utility::is_player_valid( player ) && !player isplayeronsamemachine( self ) )
        {
            if ( !isdefined( a_distant ) )
            {
                a_distant = [];
            }
            else if ( !isarray( a_distant ) )
            {
                a_distant = array( a_distant );
            }
            
            a_distant[ a_distant.size ] = player;
        }
    }
    
    return a_distant;
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x9a61af39, Offset: 0xae58
// Size: 0x132
function get_random_speaker( a_players )
{
    if ( !isdefined( a_players ) )
    {
        a_players = getplayers();
    }
    
    a_valid_players = [];
    
    foreach ( player in a_players )
    {
        if ( zombie_utility::is_player_valid( player ) )
        {
            if ( !isdefined( a_valid_players ) )
            {
                a_valid_players = [];
            }
            else if ( !isarray( a_valid_players ) )
            {
                a_valid_players = array( a_valid_players );
            }
            
            a_valid_players[ a_valid_players.size ] = player;
        }
    }
    
    return array::random( a_valid_players );
}

// Namespace zm_tomb_capture_zones
// Params 1
// Checksum 0x783897ad, Offset: 0xaf98
// Size: 0x4c
function set_recapture_zombie_attack_target( s_recapture_target_zone )
{
    level flag::clear( "generator_under_attack" );
    s_recapture_target_zone flag::clear( "attacked_by_recapture_zombies" );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xf4a77d50, Offset: 0xaff0
// Size: 0x7c
function sndrecaptureroundloop()
{
    level endon( #"sndendroundloop" );
    wait 5;
    ent = spawn( "script_origin", ( 0, 0, 0 ) );
    ent playloopsound( "mus_recapture_round_loop", 5 );
    ent thread sndrecaptureroundloop_stop();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xfc0a618b, Offset: 0xb078
// Size: 0x54
function sndrecaptureroundloop_stop()
{
    level flag::wait_till( "recapture_zombies_cleared" );
    self stoploopsound( 2 );
    wait 2;
    self delete();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x461f3d55, Offset: 0xb0d8
// Size: 0x120
function monitor_recapture_zombie_count()
{
    while ( true )
    {
        level.zone_capture.recapture_zombies = array::remove_dead( level.zone_capture.recapture_zombies );
        
        if ( level.zone_capture.recapture_zombies.size == 0 )
        {
            level flag::set( "recapture_zombies_cleared" );
            level flag::clear( "recapture_event_in_progress" );
            level flag::clear( "generator_under_attack" );
            
            if ( isdefined( level.zone_capture.recapture_target ) )
            {
                level.zone_capture.zones[ level.zone_capture.recapture_target ] flag::clear( "attacked_by_recapture_zombies" );
                level.zone_capture.recapture_target = undefined;
            }
            
            break;
        }
        
        wait 1;
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x7f1ab80d, Offset: 0xb200
// Size: 0x174
function recapture_zombie_death_func()
{
    if ( isdefined( self.is_recapture_zombie ) && self.is_recapture_zombie )
    {
        level.recapture_zombies_killed++;
        
        if ( isdefined( self.attacker ) && isplayer( self.attacker ) && level.recapture_zombies_killed == get_recapture_zombies_needed() )
        {
            self.attacker thread util::delay( 2, undefined, &zm_audio::create_and_play_dialog, "zone_capture", "recapture_prevented" );
            
            foreach ( player in getplayers() )
            {
            }
        }
        
        if ( level.recapture_zombies_killed == get_recapture_zombies_needed() && level flag::get( "generator_under_attack" ) )
        {
            self drop_max_ammo_at_death_location();
        }
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xe7b28fe, Offset: 0xb380
// Size: 0x94
function drop_max_ammo_at_death_location()
{
    if ( isdefined( self ) )
    {
        v_powerup_origin = groundtrace( self.origin + ( 0, 0, 10 ), self.origin + ( 0, 0, -150 ), 0, undefined, 1 )[ "position" ];
    }
    
    if ( isdefined( v_powerup_origin ) )
    {
        level thread zm_powerups::specific_powerup_drop( "full_ammo", v_powerup_origin );
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x53d82b6, Offset: 0xb420
// Size: 0x11c
function generator_under_attack_warnings()
{
    level flag::wait_till_any( array( "generator_under_attack", "recapture_zombies_cleared" ) );
    
    if ( !level flag::get( "recapture_zombies_cleared" ) )
    {
        e_alarm_sound = spawn( "script_origin", self.origin );
        e_alarm_sound playloopsound( "zmb_capturezone_losing" );
        e_alarm_sound thread play_flare_effect();
        wait 0.5;
        level flag::wait_till_clear( "generator_under_attack" );
        e_alarm_sound stoploopsound( 0.2 );
        wait 0.5;
        e_alarm_sound delete();
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x6892a84b, Offset: 0xb548
// Size: 0x7e
function play_flare_effect()
{
    self endon( #"death" );
    n_end_time = gettime() + 5000;
    
    while ( level flag::get( "generator_under_attack" ) )
    {
        playfx( level._effect[ "lght_marker_flare" ], self.origin );
        wait 4;
    }
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x4749abdf, Offset: 0xb5d0
// Size: 0x2c
function recapture_round_audio_starts()
{
    level.sndmusicspecialround = 1;
    level thread zm_audio::sndmusicsystem_playstate( "round_start_recap" );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x2305c45, Offset: 0xb608
// Size: 0x3e
function recapture_round_audio_ends()
{
    level thread zm_audio::sndmusicsystem_playstate( "round_end_recap" );
    level.sndmusicspecialround = 0;
    level notify( #"sndendroundloop" );
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x99ec1590, Offset: 0xb650
// Size: 0x4
function custom_vending_power_on()
{
    
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x99ec1590, Offset: 0xb660
// Size: 0x4
function custom_vending_power_off()
{
    
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x52b12b29, Offset: 0xb670
// Size: 0x94
function generator_initiated_vo()
{
    e_vo_origin = spawn( "script_origin", self.origin );
    level.maxis_generator_vo = 1;
    e_vo_origin playsoundwithnotify( "vox_maxi_generator_initiate_0", "vox_maxi_generator_initiate_0_done" );
    e_vo_origin waittill( #"vox_maxi_generator_initiate_0_done" );
    level.maxis_generator_vo = 0;
    e_vo_origin delete();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xc9d431c4, Offset: 0xb710
// Size: 0xe4
function zone_capture_complete_vo()
{
    e_vo_origin = spawn( "script_origin", self.origin );
    e_vo_origin playsoundwithnotify( "vox_maxi_generator_process_complete_0", "vox_maxi_generator_process_complete_0_done" );
    e_vo_origin waittill( #"vox_maxi_generator_process_complete_0_done" );
    e_vo_origin playsoundwithnotify( "vox_maxi_generator_" + self.script_int + "_activated_0", "vox_maxi_generator_" + self.script_int + "_activated_0_done" );
    e_vo_origin waittill( "vox_maxi_generator_" + self.script_int + "_activated_0_done" );
    e_vo_origin delete();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xe8f91551, Offset: 0xb800
// Size: 0x7c
function generator_interrupted_vo()
{
    e_vo_origin = spawn( "script_origin", self.origin );
    e_vo_origin playsoundwithnotify( "vox_maxi_generator_interrupted_0", "vox_maxi_generator_interrupted_0_done" );
    e_vo_origin waittill( #"vox_maxi_generator_interrupted_0_done" );
    e_vo_origin delete();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xa0d3673a, Offset: 0xb888
// Size: 0xb4
function generator_compromised_vo()
{
    e_vo_origin = spawn( "script_origin", self.origin );
    e_vo_origin playsoundwithnotify( "vox_maxi_generator_" + self.script_int + "_compromised_0", "vox_maxi_generator_" + self.script_int + "_compromised_0_done" );
    e_vo_origin waittill( "vox_maxi_generator_" + self.script_int + "_compromised_0_done" );
    e_vo_origin delete();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0x870da3ae, Offset: 0xb948
// Size: 0xb4
function generator_deactivated_vo()
{
    e_vo_origin = spawn( "script_origin", self.origin );
    e_vo_origin playsoundwithnotify( "vox_maxi_generator_" + self.script_int + "_deactivated_0", "vox_maxi_generator_" + self.script_int + "_deactivated_0_done" );
    e_vo_origin waittill( "vox_maxi_generator_" + self.script_int + "_deactivated_0_done" );
    e_vo_origin delete();
}

// Namespace zm_tomb_capture_zones
// Params 0
// Checksum 0xbfdf4b54, Offset: 0xba08
// Size: 0x44
function sndplaygeneratormusicstinger()
{
    num = get_captured_zone_count();
    level thread zm_tomb_amb::sndplaystinger( "generator_" + num );
}

