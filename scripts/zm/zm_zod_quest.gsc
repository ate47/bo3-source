#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/music_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/zm_zod_craftables;
#using scripts/zm/zm_zod_defend_areas;
#using scripts/zm/zm_zod_margwa;
#using scripts/zm/zm_zod_pods;
#using scripts/zm/zm_zod_portals;
#using scripts/zm/zm_zod_quest_vo;
#using scripts/zm/zm_zod_util;
#using scripts/zm/zm_zod_vo;

#namespace zm_zod_quest;

// Namespace zm_zod_quest
// Params 0, eflags: 0x2
// Checksum 0xe1ebcaa8, Offset: 0x1610
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_zod_quest", &__init__, undefined, undefined );
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xecfa08c2, Offset: 0x1650
// Size: 0xdfc
function __init__()
{
    level.pap_zbarrier_state_func = &function_b35b6cb3;
    callback::on_connect( &on_player_connect );
    clientfield::register( "toplayer", "ZM_ZOD_UI_SUMMONING_KEY_PICKUP", 1, 1, "int" );
    clientfield::register( "toplayer", "ZM_ZOD_UI_RITUAL_BUSY", 1, 1, "int" );
    clientfield::register( "world", "quest_key", 1, 1, "int" );
    clientfield::register( "world", "ritual_progress", 1, 7, "float" );
    clientfield::register( "world", "ritual_current", 1, 3, "int" );
    n_bits = getminbitcountfornum( 5 );
    clientfield::register( "world", "ritual_state_boxer", 1, n_bits, "int" );
    clientfield::register( "world", "ritual_state_detective", 1, n_bits, "int" );
    clientfield::register( "world", "ritual_state_femme", 1, n_bits, "int" );
    clientfield::register( "world", "ritual_state_magician", 1, n_bits, "int" );
    clientfield::register( "world", "ritual_state_pap", 1, n_bits, "int" );
    clientfield::register( "world", "keeper_spawn_portals", 1, 4, "int" );
    clientfield::register( "world", "keeper_subway_fx", 1, 1, "int" );
    clientfield::register( "world", "junction_crane_state", 1, 1, "int" );
    clientfield::register( "scriptmover", "cursetrap_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "mini_cursetrap_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "curse_tell_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "darkportal_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "boss_shield_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "keeper_symbol_fx", 1, 1, "int" );
    n_bits = getminbitcountfornum( 6 );
    clientfield::register( "scriptmover", "totem_state_fx", 1, n_bits, "int" );
    clientfield::register( "scriptmover", "totem_damage_fx", 1, 3, "int" );
    clientfield::register( "scriptmover", "set_fade_material", 1, 1, "int" );
    clientfield::register( "scriptmover", "set_subway_wall_dissolve", 1, 1, "int" );
    n_bits = getminbitcountfornum( 3 );
    clientfield::register( "actor", "status_fx", 1, n_bits, "int" );
    n_bits = getminbitcountfornum( 3 );
    clientfield::register( "vehicle", "veh_status_fx", 1, n_bits, "int" );
    clientfield::register( "actor", "keeper_fx", 1, 1, "int" );
    clientfield::register( "scriptmover", "item_glow_fx", 1, 3, "int" );
    n_bits = getminbitcountfornum( 7 );
    clientfield::register( "scriptmover", "shadowman_fx", 1, n_bits, "int" );
    clientfield::register( "world", "devgui_gateworm", 1, 1, "int" );
    clientfield::register( "scriptmover", "gateworm_basin_fx", 1, 2, "int" );
    clientfield::register( "world", "wallrun_footprints", 1, 2, "int" );
    a_str_names = array( "boxer", "detective", "femme", "magician" );
    
    for ( i = 0; i < 4 ; i++ )
    {
        clientfield::register( "toplayer", "check_" + a_str_names[ i ] + "_memento", 1, 1, "int" );
    }
    
    level flag::init( "keeper_sword_locker" );
    n_bits = getminbitcountfornum( 6 );
    clientfield::register( "toplayer", "used_quest_key", 1, n_bits, "int" );
    clientfield::register( "toplayer", "used_quest_key_location", 1, n_bits, "int" );
    visionset_mgr::register_info( "visionset", "zod_ritual_dim", 1, 1, 15, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0 );
    a_str_names = array( "boxer", "detective", "femme", "magician" );
    
    foreach ( str_name in a_str_names )
    {
        relic_placed = getent( "quest_ritual_relic_" + str_name + "_placed", "targetname" );
        relic_placed ghost();
        a_e_clip = getentarray( "ritual_clip_" + str_name, "targetname" );
        
        foreach ( e_clip in a_e_clip )
        {
            e_clip setinvisibletoall();
            e_clip.origin -= ( 0, 0, 128 );
        }
    }
    
    a_e_clip = getentarray( "ritual_clip_pap", "targetname" );
    
    foreach ( e_clip in a_e_clip )
    {
        e_clip setinvisibletoall();
        e_clip.origin -= ( 0, 0, 128 );
    }
    
    level._effect[ "ritual_key_glow" ] = "zombie/fx_ritual_glow_key_zod_zmb";
    level.n_zod_rituals_completed = 0;
    level.zod_ritual_durations = [];
    level.zod_ritual_durations[ 0 ] = 20;
    level.zod_ritual_durations[ 1 ] = 25;
    level.zod_ritual_durations[ 2 ] = 30;
    level.zod_ritual_durations[ 3 ] = 30;
    level.zod_ritual_durations[ 4 ] = 30;
    level.gatestone = spawnstruct();
    level.gatestone.n_power_level = 0;
    flag::init( "quest_key_found" );
    flag::init( "memento_boxer_found" );
    flag::init( "memento_detective_found" );
    flag::init( "memento_femme_found" );
    flag::init( "memento_magician_found" );
    flag::init( "ritual_in_progress" );
    flag::init( "ritual_boxer_ready" );
    flag::init( "ritual_boxer_complete" );
    flag::init( "ritual_detective_ready" );
    flag::init( "ritual_detective_complete" );
    flag::init( "ritual_femme_ready" );
    flag::init( "ritual_femme_complete" );
    flag::init( "ritual_magician_ready" );
    flag::init( "ritual_magician_complete" );
    flag::init( "ritual_all_characters_complete" );
    flag::init( "pap_door_open" );
    flag::init( "pap_basin_1" );
    flag::init( "pap_basin_2" );
    flag::init( "pap_basin_3" );
    flag::init( "pap_basin_4" );
    flag::init( "pap_altar" );
    flag::init( "ritual_pap_ready" );
    flag::init( "ritual_pap_complete" );
    flag::init( "story_vo_playing" );
    
    /#
        level thread quest_devgui();
    #/
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x3036e93c, Offset: 0x2458
// Size: 0x1c
function on_player_connect()
{
    self thread function_f7d960ba();
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x2d8d0bf3, Offset: 0x2480
// Size: 0x46
function function_f7d960ba()
{
    for ( i = 0; i < 4 ; i++ )
    {
        self thread function_70a7429b( i );
    }
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xec5e93fe, Offset: 0x24d0
// Size: 0x144
function function_70a7429b( var_25bc1c51 )
{
    self endon( #"disconnect" );
    a_str_names = array( "boxer", "detective", "femme", "magician" );
    s_centerpoint = struct::get( "defend_area_" + a_str_names[ var_25bc1c51 ], "targetname" );
    var_33e67e27 = 0;
    
    while ( isdefined( self ) )
    {
        dist2 = distancesquared( self.origin, s_centerpoint.origin );
        var_f7225255 = dist2 < 4096;
        
        if ( var_f7225255 != var_33e67e27 )
        {
            self clientfield::set_to_player( "check_" + a_str_names[ var_25bc1c51 ] + "_memento", var_f7225255 );
            var_33e67e27 = var_f7225255;
        }
        
        wait 0.1;
    }
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xa9514938, Offset: 0x2620
// Size: 0x1c4
function start_zod_quest()
{
    callback::on_connect( &player_death_watcher );
    level flag::wait_till( "start_zombie_round_logic" );
    prevent_theater_mode_spoilers();
    level thread setup_quest_key();
    level thread setup_personal_items();
    level thread setup_defend_areas();
    level thread setup_pap_door();
    level thread setup_pap_chamber();
    level thread function_83c8b6e8();
    level thread function_58fe842c();
    exploder::exploder( "fx_exploder_magician_candles" );
    level thread function_ffcfbd77();
    
    if ( isdefined( level.gamedifficulty ) && level.gamedifficulty != 0 )
    {
    }
    
    if ( isdefined( level.host_migration_listener_custom_func ) )
    {
        level thread [[ level.host_migration_listener_custom_func ]]();
    }
    else
    {
        level thread host_migration_listener();
    }
    
    if ( isdefined( level.track_quest_status_thread_custom_func ) )
    {
        level thread [[ level.track_quest_status_thread_custom_func ]]();
    }
    else
    {
        level thread track_quest_status_thread();
    }
    
    zm_zod_quest_vo::opening_vo();
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x346498ab, Offset: 0x27f0
// Size: 0x64
function prevent_theater_mode_spoilers()
{
    level flag::wait_till( "initial_blackscreen_passed" );
    mdl_key = getent( "quest_key_pickup", "targetname" );
    mdl_key ghost();
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xa8f7103f, Offset: 0x2860
// Size: 0xfa
function function_ffcfbd77()
{
    a_str_fuses = array( "fuse_01", "fuse_02", "fuse_03" );
    
    foreach ( str_fuse in a_str_fuses )
    {
        mdl_fuse = level zm_craftables::get_craftable_piece_model( "police_box", str_fuse );
        mdl_fuse clientfield::set( "item_glow_fx", 4 );
    }
}

#using_animtree( "generic" );

// Namespace zm_zod_quest
// Params 0
// Checksum 0x39af3ff6, Offset: 0x2968
// Size: 0xbc
function setup_quest_key()
{
    mdl_key = getent( "quest_key_pickup", "targetname" );
    mdl_key show();
    mdl_key useanimtree( #animtree );
    mdl_key clientfield::set( "item_glow_fx", 1 );
    create_quest_key_pickup_unitrigger( mdl_key );
    mdl_key animation::play( "p7_fxanim_zm_zod_summoning_key_idle_anim" );
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x718de5a8, Offset: 0x2a30
// Size: 0x1b4
function create_quest_key_pickup_unitrigger( mdl_key )
{
    width = 128;
    height = 128;
    length = 128;
    mdl_key.unitrigger_stub = spawnstruct();
    mdl_key.unitrigger_stub.origin = mdl_key.origin;
    mdl_key.unitrigger_stub.angles = mdl_key.angles;
    mdl_key.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    mdl_key.unitrigger_stub.cursor_hint = "HINT_NOICON";
    mdl_key.unitrigger_stub.script_width = width;
    mdl_key.unitrigger_stub.script_height = height;
    mdl_key.unitrigger_stub.script_length = length;
    mdl_key.unitrigger_stub.require_look_at = 0;
    mdl_key.unitrigger_stub.mdl_key = mdl_key;
    mdl_key.unitrigger_stub.prompt_and_visibility_func = &quest_key_trigger_visibility;
    zm_unitrigger::register_static_unitrigger( mdl_key.unitrigger_stub, &quest_key_trigger_think );
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x99ec780b, Offset: 0x2bf0
// Size: 0x9a, Type: bool
function quest_key_trigger_visibility( player )
{
    b_is_invis = isdefined( player.beastmode ) && player.beastmode || !( isdefined( level.quest_key_can_be_picked_up ) && level.quest_key_can_be_picked_up );
    self setinvisibletoplayer( player, b_is_invis );
    self sethintstring( &"ZM_ZOD_QUEST_RITUAL_PICKUP_QUEST_KEY" );
    return !b_is_invis;
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x34ac52, Offset: 0x2c98
// Size: 0xd4
function quest_key_trigger_think()
{
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( player zm_utility::in_revive_trigger() )
        {
            continue;
        }
        
        if ( player.is_drinking > 0 )
        {
            continue;
        }
        
        if ( !zm_utility::is_player_valid( player ) )
        {
            continue;
        }
        
        player playsound( "zmb_zod_key_pickup" );
        player thread zm_zod_vo::function_53b96c8f();
        level thread quest_key_trigger_pickup( self.stub );
        break;
    }
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xc4e089ec, Offset: 0x2d78
// Size: 0x154
function quest_key_trigger_pickup( trig_stub )
{
    trig_stub.mdl_key ghost();
    level.quest_key_can_be_picked_up = 0;
    players = level.players;
    
    foreach ( player in players )
    {
        if ( zm_utility::is_player_valid( player ) )
        {
            player thread zm_zod_util::function_55f114f9( "zmInventory.widget_quest_items", 3.5 );
            player thread zm_zod_util::show_infotext_for_duration( "ZM_ZOD_UI_SUMMONING_KEY_PICKUP", 3.5 );
        }
    }
    
    set_key_availability( 1 );
    trig_stub zm_unitrigger::run_visibility_function_for_all_triggers();
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x1f709fba, Offset: 0x2ed8
// Size: 0x64
function setup_personal_items()
{
    level thread personal_item_junction();
    level thread personal_item_canal();
    level thread keeper_sword_locker();
    level thread function_af9ab682();
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x32559ff8, Offset: 0x2f48
// Size: 0x64
function personal_item_junction()
{
    level flag::wait_till( "power_on" + 20 );
    level clientfield::set( "junction_crane_state", 1 );
    wait 9.5;
    reveal_personal_item( "memento_magician_drop" );
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xb00f9a17, Offset: 0x2fb8
// Size: 0xfa
function personal_item_canal()
{
    a_e_door = getentarray( "quest_personal_item_canal_door", "targetname" );
    level flag::wait_till( "power_on" + 23 );
    
    foreach ( e_door in a_e_door )
    {
        e_door moveto( e_door.origin - ( 0, 0, 64 ), 1 );
    }
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x7a1a4c68, Offset: 0x30c0
// Size: 0x144
function function_af9ab682()
{
    level flag::wait_till( "power_on" + 21 );
    e_door_left = getent( "deco_door_left", "targetname" );
    e_door_right = getent( "deco_door_right", "targetname" );
    e_door_clip = getent( "deco_door_clip", "targetname" );
    e_door_left rotateyaw( 135, 3 );
    e_door_right rotateyaw( -135, 3 );
    e_door_clip connectpaths();
    e_door_clip delete();
    level flag::set( "connect_theater_to_burlesque" );
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x13d3f190, Offset: 0x3210
// Size: 0x134
function keeper_sword_locker()
{
    e_door = getent( "keeper_sword_locker", "targetname" );
    e_door_clip = getent( "keeper_sword_locker_clip", "targetname" );
    e_door clientfield::set( "set_subway_wall_dissolve", 1 );
    level flag::wait_till( "keeper_sword_locker" );
    e_door clientfield::set( "set_subway_wall_dissolve", 0 );
    wait 2;
    e_door_clip connectpaths();
    e_door_clip delete();
    [[ level.o_canal_beastcode ]]->hide_readout( 1 );
    wait 4;
    e_door delete();
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x1a367952, Offset: 0x3350
// Size: 0x224
function reveal_personal_item( str_id )
{
    mdl_phrase = getent( str_id + "_phrase", "targetname" );
    
    if ( isdefined( mdl_phrase ) )
    {
        mdl_phrase delete();
    }
    
    str_char_name = zm_zod_craftables::get_character_name_from_value( str_id );
    n_wait_time = 0;
    
    switch ( str_char_name )
    {
        case "boxer":
            n_wait_time = 3;
            break;
        default:
            n_wait_time = 2.75;
            break;
        case "detective":
            n_wait_time = 0.1;
            break;
    }
    
    wait n_wait_time;
    mdl_relic = level zm_craftables::get_craftable_piece_model( "ritual_" + str_char_name, "memento_" + str_char_name );
    mdl_relic clientfield::set( "set_fade_material", 1 );
    s_body = struct::get( str_id + "_point", "targetname" );
    mdl_relic.origin = s_body.origin;
    mdl_relic.angles = s_body.angles;
    mdl_relic setvisibletoall();
    mdl_relic showindemo();
    mdl_relic clientfield::set( "item_glow_fx", 3 );
    function_984725d6( str_char_name );
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xe0095362, Offset: 0x3580
// Size: 0x2b4
function function_984725d6( str_name )
{
    var_d16bd3a3 = getent( "ritual_zombie_spawner", "targetname" );
    level flag::wait_till( "memento_" + str_name + "_found" );
    
    if ( level.var_a80c1a9a !== 1 )
    {
        level.var_a80c1a9a = 0;
    }
    
    wait 0.25;
    n_place_index = function_b4c88128( str_name );
    n_place_index--;
    function_12370901( "keeper_spawn_portals", n_place_index, 1 );
    wait 2.5;
    a_spawn_points = struct::get_array( "memento_spawn_point_" + str_name );
    level thread zm_zod_vo::function_bcf7d3ea( a_spawn_points );
    var_4480cf29 = [];
    
    foreach ( s_spawn_point in a_spawn_points )
    {
        ai = zombie_utility::spawn_zombie( var_d16bd3a3, "memento_keeper_zombie", s_spawn_point );
        
        if ( isdefined( ai ) )
        {
            ai thread function_2d0c5aa1( s_spawn_point );
            ai.custom_location = &function_411c908f;
            
            if ( !isdefined( var_4480cf29 ) )
            {
                var_4480cf29 = [];
            }
            else if ( !isarray( var_4480cf29 ) )
            {
                var_4480cf29 = array( var_4480cf29 );
            }
            
            var_4480cf29[ var_4480cf29.size ] = ai;
        }
        
        wait 0.05;
    }
    
    if ( !level.var_a80c1a9a )
    {
        thread function_7965975d( var_4480cf29 );
    }
    
    wait 3;
    function_12370901( "keeper_spawn_portals", n_place_index, 0 );
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x8fd196e9, Offset: 0x3840
// Size: 0x2c2
function function_58fe842c()
{
    e_spawner = getent( "ritual_zombie_spawner", "targetname" );
    var_eb09d2ff = getent( "keeper_subway_welcome", "targetname" );
    
    for ( b_triggered = 0; !b_triggered ; b_triggered = 1 )
    {
        var_eb09d2ff waittill( #"trigger", e_triggerer );
        
        if ( zm_utility::is_player_valid( e_triggerer ) && !( isdefined( e_triggerer.beastmode ) && e_triggerer.beastmode ) )
        {
            level clientfield::set( "keeper_subway_fx", 1 );
            wait 2.5;
            a_spawn_points = struct::get_array( "keeper_spawn_point_subway" );
            level thread zm_zod_vo::function_bcf7d3ea( a_spawn_points );
            var_4480cf29 = [];
            
            foreach ( s_spawn_point in a_spawn_points )
            {
                ai = zombie_utility::spawn_zombie( e_spawner, "memento_keeper_zombie", s_spawn_point );
                
                if ( isdefined( ai ) )
                {
                    ai thread function_2d0c5aa1( s_spawn_point );
                    ai.custom_location = &function_411c908f;
                    
                    if ( !isdefined( var_4480cf29 ) )
                    {
                        var_4480cf29 = [];
                    }
                    else if ( !isarray( var_4480cf29 ) )
                    {
                        var_4480cf29 = array( var_4480cf29 );
                    }
                    
                    var_4480cf29[ var_4480cf29.size ] = ai;
                }
                
                wait 0.05;
            }
            
            wait 3;
            level clientfield::set( "keeper_subway_fx", 0 );
        }
    }
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xc565942c, Offset: 0x3b10
// Size: 0xce
function function_7965975d( a_e_keepers )
{
    self endon( #"_zombie_game_over" );
    level endon( #"hash_2403fc5b" );
    
    while ( a_e_keepers.size > 0 )
    {
        for ( i = 0; i < a_e_keepers.size ; i++ )
        {
            if ( !isalive( a_e_keepers[ i ] ) )
            {
                arrayremovevalue( a_e_keepers, a_e_keepers[ i ] );
            }
        }
        
        wait 0.05;
    }
    
    thread zm_zod_vo::function_93f0e7bd();
    level.var_a80c1a9a = 1;
    level notify( #"hash_2403fc5b" );
}

// Namespace zm_zod_quest
// Params 3
// Checksum 0x90e2bca4, Offset: 0x3be8
// Size: 0x94
function function_12370901( str_fieldname, n_place_index, b_on )
{
    n_val = level clientfield::get( str_fieldname );
    
    if ( b_on )
    {
        n_val |= 1 << n_place_index;
    }
    else
    {
        n_val &= !( 1 << n_place_index );
    }
    
    level clientfield::set( str_fieldname, n_val );
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x99ec1590, Offset: 0x3c88
// Size: 0x4
function function_411c908f()
{
    
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xf8af291b, Offset: 0x3c98
// Size: 0x284
function function_2d0c5aa1( s_spawn_point )
{
    self endon( #"death" );
    self.script_string = "find_flesh";
    self setphysparams( 15, 0, 72 );
    self.ignore_enemy_count = 1;
    self.no_eye_glow = 1;
    self.deathpoints_already_given = 1;
    self.exclude_distance_cleanup_adding_to_total = 1;
    self.exclude_cleanup_adding_to_total = 1;
    util::wait_network_frame();
    self clientfield::set( "keeper_fx", 1 );
    level thread function_efbd4abf( self, s_spawn_point );
    self.voiceprefix = "keeper";
    
    if ( self.zombie_move_speed === "walk" )
    {
        self zombie_utility::set_zombie_run_cycle( "run" );
    }
    
    find_flesh_struct_string = "find_flesh";
    self notify( #"zombie_custom_think_done", find_flesh_struct_string );
    self.variant_type = randomint( 4 );
    self.nocrawler = 1;
    self.zm_variant_type_max = [];
    self.zm_variant_type_max[ "walk" ] = [];
    self.zm_variant_type_max[ "run" ] = [];
    self.zm_variant_type_max[ "sprint" ] = [];
    self.zm_variant_type_max[ "walk" ][ "down" ] = 4;
    self.zm_variant_type_max[ "walk" ][ "up" ] = 4;
    self.zm_variant_type_max[ "run" ][ "down" ] = 4;
    self.zm_variant_type_max[ "run" ][ "up" ] = 4;
    self.zm_variant_type_max[ "sprint" ][ "down" ] = 4;
    self.zm_variant_type_max[ "sprint" ][ "up" ] = 4;
    self waittill( #"completed_emerging_into_playable_area" );
    self.no_powerups = 1;
}

// Namespace zm_zod_quest
// Params 2
// Checksum 0xeae583bd, Offset: 0x3f28
// Size: 0xa4
function function_efbd4abf( ai_zombie, s_spawn_point )
{
    ai_zombie waittill( #"death" );
    
    if ( isdefined( ai_zombie ) )
    {
        ai_zombie clientfield::set( "keeper_fx", 0 );
    }
    
    if ( isdefined( s_spawn_point.var_e93843aa ) )
    {
        s_spawn_point.var_e93843aa--;
    }
    
    util::wait_network_frame();
    
    if ( isdefined( ai_zombie ) )
    {
        ai_zombie delete();
    }
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xde3df312, Offset: 0x3fd8
// Size: 0x2c
function function_b4c88128( str_name )
{
    switch ( str_name )
    {
        case "boxer":
            return 1;
        case "detective":
            return 2;
        case "femme":
            return 3;
        default:
            return 4;
    }
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xcbb14295, Offset: 0x4038
// Size: 0x2f0
function setup_defend_areas()
{
    assert( !isdefined( level.a_o_defend_areas ), "<dev string:x28>" );
    level.a_o_defend_areas = [];
    a_str_names = array( "boxer", "detective", "femme", "magician" );
    
    foreach ( str_name in a_str_names )
    {
        setup_defend_area( str_name );
    }
    
    a_e_zombie_spawners = getentarray( "ritual_zombie_spawner", "targetname" );
    array::thread_all( a_e_zombie_spawners, &spawner::add_spawn_function, &zm_spawner::zombie_spawn_init );
    level.a_o_defend_areas[ "pap" ] = new careadefend();
    [[ level.a_o_defend_areas[ "pap" ] ]]->init( "defend_area_" + "pap", "defend_area_spawn_point_" + "pap" );
    [[ level.a_o_defend_areas[ "pap" ] ]]->set_luimenus( "ZodRitualProgress", "ZodRitualReturn", "ZodRitualSucceeded", "ZodRitualFailed" );
    [[ level.a_o_defend_areas[ "pap" ] ]]->set_trigger_visibility_function( &altar_trigger_visibility );
    [[ level.a_o_defend_areas[ "pap" ] ]]->set_external_functions( &ritual_prereq, &ritual_start, &ritual_succeed, &ritual_fail, "pap" );
    [[ level.a_o_defend_areas[ "pap" ] ]]->set_volumes( "defend_area_volume_" + "pap", "defend_area_volume_" + "pap" );
    [[ level.a_o_defend_areas[ "pap" ] ]]->start();
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xcf75dca4, Offset: 0x4330
// Size: 0x158
function setup_defend_area( str_name )
{
    assert( !isdefined( level.a_o_defend_areas[ str_name ] ), "<dev string:x65>" );
    level.a_o_defend_areas[ str_name ] = new careadefend();
    [[ level.a_o_defend_areas[ str_name ] ]]->init( "defend_area_" + str_name, "defend_area_spawn_point_" + str_name );
    [[ level.a_o_defend_areas[ str_name ] ]]->set_luimenus( "ZodRitualProgress", "ZodRitualReturn", "ZodRitualSucceeded", "ZodRitualFailed" );
    [[ level.a_o_defend_areas[ str_name ] ]]->set_external_functions( &ritual_prereq, &ritual_start, &ritual_succeed, &ritual_fail, str_name );
    [[ level.a_o_defend_areas[ str_name ] ]]->set_volumes( "defend_area_volume_" + str_name, "defend_area_volume_" + str_name );
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x17815112, Offset: 0x4490
// Size: 0xc
function function_b35b6cb3( state )
{
    
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x6d0622b1, Offset: 0x44a8
// Size: 0x11e
function set_key_availability( b_is_available )
{
    level clientfield::set( "quest_key", b_is_available );
    
    foreach ( o_defend_area in level.a_o_defend_areas )
    {
        thread [[ o_defend_area ]]->set_availability( b_is_available );
    }
    
    if ( b_is_available )
    {
        players = level.players;
        
        for ( i = 0; i < players.size ; i++ )
        {
            players[ i ] clientfield::set_to_player( "used_quest_key", 0 );
        }
    }
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xc6e973c, Offset: 0x45d0
// Size: 0x18a
function ritual_prereq( str_name )
{
    if ( str_name === "pap" )
    {
        a_basins = array( "pap_basin_1", "pap_basin_2", "pap_basin_3", "pap_basin_4" );
        
        foreach ( str_basin in a_basins )
        {
            if ( !level flag::get( str_basin ) )
            {
                return 0;
            }
        }
        
        return 1;
    }
    
    b_is_quest_key_available = level clientfield::get( "quest_key" );
    
    if ( level clientfield::get( "ritual_state_" + str_name ) == 2 )
    {
        b_has_ritual_previously_been_started = 1;
    }
    else
    {
        b_has_ritual_previously_been_started = 0;
    }
    
    if ( b_is_quest_key_available && !b_has_ritual_previously_been_started || b_has_ritual_previously_been_started )
    {
        return 1;
    }
    
    return 0;
}

// Namespace zm_zod_quest
// Params 2
// Checksum 0xeda7431a, Offset: 0x4768
// Size: 0x4c4
function ritual_start( str_name, e_triggerer )
{
    level notify( "ritual_" + str_name + "_start" );
    level flag::clear( "zombie_drop_powerups" );
    level flag::set( "ritual_in_progress" );
    level flag::clear( "can_spawn_margwa" );
    
    if ( str_name === "pap" )
    {
        level.pap_altar_filled = 1;
        level.pap_altar_active = 1;
        mdl_key = getent( "quest_key_pickup", "targetname" );
        s_altar = struct::get( "defend_area_pap", "targetname" );
        mdl_key.origin = s_altar.origin;
        mdl_key show();
        mdl_key clientfield::set( "item_glow_fx", 1 );
        mdl_key thread animation::play( "p7_fxanim_zm_zod_summoning_key_idle_anim" );
        exploder::exploder( "fx_exploder_ritual_pap_altar_path" );
        level.musicsystemoverride = 1;
        music::setmusicstate( "zod_final_ritual" );
    }
    else
    {
        level.var_9bc9c61f = str_name;
        level thread zm_zod_vo::function_658d89a3( str_name );
    }
    
    set_key_availability( 0 );
    
    switch ( str_name )
    {
        case "boxer":
            var_f34eee69 = 1;
            break;
        case "detective":
            var_f34eee69 = 2;
            break;
        case "femme":
            var_f34eee69 = 3;
            break;
        case "magician":
            var_f34eee69 = 4;
            break;
        default:
            var_f34eee69 = 5;
            break;
    }
    
    e_triggerer clientfield::set_to_player( "used_quest_key_location", var_f34eee69 );
    var_e85b4e8 = 0;
    
    switch ( e_triggerer.characterindex )
    {
        case 0:
            var_e85b4e8 = 1;
            break;
        case 1:
            var_e85b4e8 = 2;
            break;
        case 2:
            var_e85b4e8 = 3;
            break;
        case 3:
            var_e85b4e8 = 4;
            break;
    }
    
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "used_quest_key", var_e85b4e8 );
        player recordmapevent( 21, gettime(), player.origin, level.round_number, var_f34eee69 );
    }
    
    level clientfield::set( "ritual_state_" + str_name, 2 );
    level clientfield::set( "ritual_current", get_enum_from_name( str_name ) );
    set_ritual_barrier( str_name, 1 );
    n_duration = level.zod_ritual_durations[ level.n_zod_rituals_completed ];
    ritual_current_progress = [[ level.a_o_defend_areas[ str_name ] ]]->set_duration( n_duration );
    level thread ritual_think( str_name );
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x7489471e, Offset: 0x4c38
// Size: 0x10e
function ritual_end()
{
    var_59e0351b = level clientfield::get( "ritual_current" );
    
    foreach ( player in level.players )
    {
        player recordmapevent( 22, gettime(), player.origin, level.round_number, var_59e0351b );
    }
    
    level clientfield::set( "ritual_current", 0 );
    level.var_8280ab5f = level.var_9bc9c61f;
    level.var_9bc9c61f = undefined;
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xe90db769, Offset: 0x4d50
// Size: 0x29c
function ritual_think( str_name )
{
    var_bfb1dae2 = "ritual_" + str_name + "_succeed";
    var_d135f7ae = "ritual_" + str_name + "_fail";
    level endon( var_bfb1dae2 );
    level endon( var_d135f7ae );
    level thread function_cc04ada( var_bfb1dae2, var_d135f7ae );
    var_9e663a06 = 0;
    var_c468b46f = 0;
    var_52614534 = 0;
    var_7863bf9d = 0;
    var_8df092ed = function_5e98a0b6( str_name );
    
    while ( true )
    {
        ritual_current_progress = [[ level.a_o_defend_areas[ str_name ] ]]->get_current_progress();
        ritual_current_progress = float( ritual_current_progress );
        println( "<dev string:xc0>" + ritual_current_progress );
        level clientfield::set( "ritual_progress", ritual_current_progress );
        
        if ( ritual_current_progress >= 0.2 && ritual_current_progress < 0.45 && !var_9e663a06 )
        {
            var_9e663a06 = zm_zod_vo::function_335f3a81( 0, var_8df092ed );
        }
        else if ( ritual_current_progress >= 0.45 && ritual_current_progress < 0.7 && !var_c468b46f )
        {
            var_c468b46f = zm_zod_vo::function_335f3a81( 1, var_8df092ed );
        }
        else if ( ritual_current_progress >= 0.7 && ritual_current_progress < 0.9 && !var_52614534 )
        {
            var_52614534 = zm_zod_vo::function_335f3a81( 2, var_8df092ed );
        }
        else if ( ritual_current_progress >= 0.9 && !var_7863bf9d )
        {
            var_7863bf9d = zm_zod_vo::function_335f3a81( 3, var_8df092ed );
        }
        
        wait 0.05;
    }
}

// Namespace zm_zod_quest
// Params 2
// Checksum 0xd59c115e, Offset: 0x4ff8
// Size: 0x48
function function_cc04ada( var_bfb1dae2, var_d135f7ae )
{
    level.no_powerups = 1;
    level util::waittill_any( var_bfb1dae2, var_d135f7ae );
    level.no_powerups = 0;
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x5d99bd01, Offset: 0x5048
// Size: 0x14a, Type: bool
function function_5e98a0b6( str_name )
{
    switch ( str_name )
    {
        case "boxer":
            var_8f06ff9 = 0;
            break;
        case "detective":
            var_8f06ff9 = 1;
            break;
        case "femme":
            var_8f06ff9 = 2;
            break;
        case "magician":
            var_8f06ff9 = 3;
            break;
        default:
            return false;
    }
    
    foreach ( e_player in level.players )
    {
        var_8df092ed = [[ level.a_o_defend_areas[ str_name ] ]]->is_player_in_defend_area( e_player );
        
        if ( var_8df092ed && e_player.characterindex == var_8f06ff9 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_zod_quest
// Params 2
// Checksum 0x23a1cc8b, Offset: 0x51a0
// Size: 0x33c
function ritual_succeed( str_name, var_6ec814a1 )
{
    level.n_zod_rituals_completed++;
    level flag::set( "zombie_drop_powerups" );
    level flag::clear( "ritual_in_progress" );
    set_ritual_barrier( str_name, 0 );
    
    if ( str_name == "pap" )
    {
        music::setmusicstate( "none" );
        level.musicsystemoverride = 0;
        exploder::stop_exploder( "fx_exploder_ritual_pap_altar_path" );
        ritual_pap_succeed();
        return;
    }
    
    /#
        if ( !isdefined( var_6ec814a1 ) )
        {
            var_6ec814a1 = level.activeplayers;
        }
    #/
    
    ritual_end();
    level thread function_b600b7f6( str_name );
    level notify( "ritual_" + str_name + "_succeed" );
    level flag::set( "ritual_" + str_name + "_complete" );
    level clientfield::set( "ritual_state_" + str_name, 3 );
    level clientfield::set( "quest_state_" + str_name, 3 );
    wait getanimlength( "p7_fxanim_zm_zod_redemption_key_ritual_end_anim" );
    
    if ( str_name === "magician" )
    {
        exploder::stop_exploder( "fx_exploder_magician_candles" );
        hidemiscmodels( "ritual_candles_" + str_name + "_on" );
        showmiscmodels( "ritual_candles_" + str_name + "_off" );
    }
    
    mdl_relic = level zm_craftables::get_craftable_piece_model( "ritual_pap", "relic_" + str_name );
    
    if ( isdefined( mdl_relic ) )
    {
        mdl_relic setinvisibletoall();
        s_body = struct::get( "quest_ritual_item_placed_" + str_name, "targetname" );
        mdl_relic.origin = s_body.origin;
        mdl_relic clientfield::set( "item_glow_fx", 2 );
    }
    
    level thread zm_zod_vo::function_17f92643();
    set_key_availability( 1 );
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xa32c2037, Offset: 0x54e8
// Size: 0xec
function function_b600b7f6( str_name )
{
    wait 10;
    
    if ( level.n_zod_rituals_completed == 2 || level.n_zod_rituals_completed == 4 || level.n_zod_rituals_completed == 5 )
    {
        var_7ee78287 = struct::get( "defend_area_" + str_name, "targetname" );
        var_5fb1e746 = arraygetclosest( var_7ee78287.origin, level.margwa_locations );
        
        if ( level.var_6e63e659 == 0 )
        {
            zm_zod_margwa::function_8bcb72e9( 0, var_5fb1e746 );
        }
    }
    
    level flag::set( "can_spawn_margwa" );
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x734c1520, Offset: 0x55e0
// Size: 0x1bc
function ritual_fail( str_name )
{
    level flag::set( "zombie_drop_powerups" );
    level flag::clear( "ritual_in_progress" );
    set_ritual_barrier( str_name, 0 );
    
    if ( str_name == "pap" )
    {
        music::setmusicstate( "none" );
        level.musicsystemoverride = 0;
        exploder::stop_exploder( "fx_exploder_ritual_pap_altar_path" );
        ritual_pap_fail();
    }
    
    set_key_availability( 1 );
    level notify( "ritual_" + str_name + "_fail" );
    level clientfield::set( "ritual_progress", 0 );
    wait 1;
    level clientfield::set( "ritual_current", 0 );
    level clientfield::set( "ritual_state_" + str_name, 1 );
    
    if ( str_name != "pap" )
    {
        level clientfield::set( "quest_state_" + str_name, 3 );
    }
    
    level flag::set( "can_spawn_margwa" );
}

// Namespace zm_zod_quest
// Params 2
// Checksum 0x4b9eb299, Offset: 0x57a8
// Size: 0x19a
function set_ritual_barrier( str_name, b_on )
{
    a_e_clip = getentarray( "ritual_clip_" + str_name, "targetname" );
    
    foreach ( e_clip in a_e_clip )
    {
        if ( b_on )
        {
            e_clip.origin += ( 0, 0, 128 );
            e_clip setvisibletoall();
            exploder::exploder( "fx_exploder_ritual_" + str_name + "_barrier" );
            continue;
        }
        
        e_clip.origin -= ( 0, 0, 128 );
        e_clip setinvisibletoall();
        exploder::stop_exploder( "fx_exploder_ritual_" + str_name + "_barrier" );
    }
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x8a554c16, Offset: 0x5950
// Size: 0x32
function get_enum_from_name( str_name )
{
    switch ( str_name )
    {
        case "boxer":
            return 1;
        case "detective":
            return 2;
        case "femme":
            return 3;
        case "magician":
            return 4;
        default:
            return 5;
    }
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xcd8609de, Offset: 0x59c0
// Size: 0x454
function ritual_pap_succeed()
{
    exploder::exploder( "fx_exploder_ritual_gatestone_explosion" );
    exploder::exploder( "fx_exploder_ritual_gatestone_portal" );
    
    for ( i = 1; i < 5 ; i++ )
    {
        exploder::stop_exploder( "fx_exploder_ritual_pap_basin_" + i + "_path" );
        e_basin = get_worm_basin( "pap_basin_" + i );
        e_basin clientfield::set( "gateworm_basin_fx", 2 );
        e_basin playloopsound( "zmb_zod_ritual_pap_worm_firelvl2", 1 );
    }
    
    a_str_gateworm_held = array( "relic_boxer", "relic_detective", "relic_femme", "relic_magician" );
    
    foreach ( str_gateworm_held in a_str_gateworm_held )
    {
        mdl_gateworm = getent( "quest_ritual_" + str_gateworm_held + "_placed", "targetname" );
        mdl_gateworm movez( 64, 3 );
        mdl_gateworm rotateyaw( 180, 3 );
    }
    
    level notify( #"ritual_pap_succeed" );
    level flag::set( "ritual_pap_complete" );
    hidemiscmodels( "gatestone_unbroken" );
    level clientfield::set( "ritual_current", 0 );
    level clientfield::set( "ritual_state_pap", 3 );
    
    for ( i = 1; i < 5 ; i++ )
    {
        if ( isdefined( level.var_f86952c7[ "pap_basin_" + i ] ) )
        {
            zm_unitrigger::unregister_unitrigger( level.var_f86952c7[ "pap_basin_" + i ] );
        }
    }
    
    function_a6838c4f();
    level thread zm_zod_vo::function_edca6dc9();
    level util::waittill_any_timeout( 20, "vo_ritual_pap_succeed_done" );
    level thread function_b600b7f6( "pap" );
    
    /#
        a_str_ritual_flags = array( "<dev string:xda>", "<dev string:xf0>", "<dev string:x10a>", "<dev string:x120>" );
        
        foreach ( var_83f1459 in a_str_ritual_flags )
        {
            level flag::set( var_83f1459 );
        }
        
        level flag::set( "<dev string:x139>" );
    #/
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x99732e6f, Offset: 0x5e20
// Size: 0x40
function ritual_pap_fail()
{
    level notify( #"ritual_pap_fail" );
    level clientfield::set( "ritual_current", 0 );
    level.pap_altar_active = 0;
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x6a6df4ad, Offset: 0x5e68
// Size: 0xb8
function get_completed_ritual_count()
{
    n_completed_rituals = 0;
    
    if ( flag::get( "ritual_boxer_complete" ) )
    {
        n_completed_rituals++;
    }
    
    if ( flag::get( "ritual_detective_complete" ) )
    {
        n_completed_rituals++;
    }
    
    if ( flag::get( "ritual_femme_complete" ) )
    {
        n_completed_rituals++;
    }
    
    if ( flag::get( "ritual_magician_complete" ) )
    {
        n_completed_rituals++;
    }
    
    if ( flag::get( "ritual_pap_complete" ) )
    {
        n_completed_rituals++;
    }
    
    return n_completed_rituals;
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x7b8cb3b0, Offset: 0x5f28
// Size: 0x434
function setup_pap_door()
{
    e_pap_door = getent( "pap_door", "targetname" );
    e_pap_door_brick_chunk1 = getent( "e_pap_door_brick_chunk1", "targetname" );
    e_pap_door_brick_chunk2 = getent( "e_pap_door_brick_chunk2", "targetname" );
    e_pap_door_clip = getent( "pap_door_clip", "targetname" );
    e_pap_door_brick_chunk1 thread clientfield::set( "set_subway_wall_dissolve", 1 );
    e_pap_door_brick_chunk2 thread clientfield::set( "set_subway_wall_dissolve", 1 );
    e_pap_door hidepart( "tag_ritual_key_on" );
    e_pap_door showpart( "tag_ritual_key_off" );
    exploder::exploder( "fx_exploder_ritual_pap_wall_smk" );
    a_str_names = array( "boxer", "detective", "femme", "magician" );
    
    foreach ( str_name in a_str_names )
    {
        e_pap_door thread pap_door_watch_for_ritual( str_name );
    }
    
    a_str_ritual_flags = array( "ritual_boxer_complete", "ritual_detective_complete", "ritual_femme_complete", "ritual_magician_complete" );
    level flag::wait_till_all( a_str_ritual_flags );
    flag::set( "ritual_all_characters_complete" );
    e_pap_door showpart( "tag_ritual_key_on" );
    e_pap_door hidepart( "tag_ritual_key_off" );
    level thread pap_door_watch_for_explosion();
    level flag::wait_till( "pap_door_open" );
    e_pap_door setinvisibletoall();
    e_pap_door playsound( "zmb_zod_pap_wall_explode" );
    exploder::exploder( "fx_exploder_ritual_pap_wall_explo" );
    e_pap_door_brick_chunk1 thread clientfield::set( "set_subway_wall_dissolve", 0 );
    e_pap_door_brick_chunk2 thread clientfield::set( "set_subway_wall_dissolve", 0 );
    wait 3.5;
    e_pap_door_clip connectpaths();
    e_pap_door delete();
    e_pap_door_clip delete();
    exploder::stop_exploder( "fx_exploder_ritual_pap_wall_smk" );
    e_pap_door_brick_chunk1 delete();
    e_pap_door_brick_chunk2 delete();
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x7b88e5b7, Offset: 0x6368
// Size: 0x144
function pap_door_watch_for_ritual( str_name )
{
    self hidepart( "tag_ritual_" + str_name + "_on" );
    self showpart( "tag_ritual_" + str_name + "_off" );
    level flag::wait_till( "ritual_" + str_name + "_complete" );
    self showpart( "tag_ritual_" + str_name + "_on" );
    self hidepart( "tag_ritual_" + str_name + "_off" );
    level flag::wait_till( "pap_door_open" );
    self hidepart( "tag_ritual_" + str_name + "_on" );
    self hidepart( "tag_ritual_" + str_name + "_off" );
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xa38a1fe4, Offset: 0x64b8
// Size: 0x170
function pap_door_watch_for_explosion()
{
    level notify( #"pap_door_watch_for_explosion" );
    level endon( #"pap_door_watch_for_explosion" );
    t_pap_door = getent( "pap_door_trigger", "targetname" );
    
    while ( true )
    {
        foreach ( player in level.activeplayers )
        {
            if ( zombie_utility::is_player_valid( player ) && player istouching( t_pap_door ) )
            {
                player zm_zod_util::set_rumble_to_player( 5 );
                wait 1;
                
                if ( isdefined( player ) )
                {
                    player zm_zod_util::set_rumble_to_player( 0 );
                }
                
                level flag::set( "pap_door_open" );
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xa4005734, Offset: 0x6630
// Size: 0x1b4
function setup_pap_chamber()
{
    level flag::wait_till( "start_zombie_round_logic" );
    hint_string = &"ZM_ZOD_QUEST_RITUAL_NEED_RELIC";
    func_trigger_visibility = &basin_trigger_visibility;
    func_trigger_thread = &basin_trigger_thread;
    
    for ( i = 1; i < 5 ; i++ )
    {
        create_ritual_unitrigger( "pap_basin_" + i, hint_string, func_trigger_visibility, func_trigger_thread );
    }
    
    level thread watch_wallrun( 1, "pap_basin_1" );
    level thread watch_island( 1, "pap_basin_2" );
    level thread watch_island( 0, "pap_basin_3" );
    level thread watch_wallrun( 0, "pap_basin_4" );
    a_flags = array( "pap_basin_2", "pap_basin_3" );
    level thread watch_central_traversal( a_flags );
    level thread function_ae395e41( a_flags );
    level thread pap_chasm_killtrigger();
}

// Namespace zm_zod_quest
// Params 4
// Checksum 0x5bb41f05, Offset: 0x67f0
// Size: 0x23a
function create_ritual_unitrigger( str_flag, hint_string, func_trigger_visibility, func_trigger_thread )
{
    width = 110;
    height = 90;
    length = 110;
    s_basin = struct::get( str_flag, "script_noteworthy" );
    s_basin.unitrigger_stub = spawnstruct();
    s_basin.unitrigger_stub.origin = s_basin.origin;
    s_basin.unitrigger_stub.angles = s_basin.angles;
    s_basin.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_basin.unitrigger_stub.hint_string = hint_string;
    s_basin.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_basin.unitrigger_stub.script_width = width;
    s_basin.unitrigger_stub.script_height = height;
    s_basin.unitrigger_stub.script_length = length;
    s_basin.unitrigger_stub.require_look_at = 0;
    s_basin.unitrigger_stub.str_flag = str_flag;
    s_basin.unitrigger_stub.prompt_and_visibility_func = func_trigger_visibility;
    zm_unitrigger::register_static_unitrigger( s_basin.unitrigger_stub, func_trigger_thread );
    
    if ( !isdefined( level.var_f86952c7 ) )
    {
        level.var_f86952c7 = [];
    }
    
    level.var_f86952c7[ str_flag ] = s_basin.unitrigger_stub;
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xad0fc25c, Offset: 0x6a38
// Size: 0x112, Type: bool
function basin_trigger_visibility( player )
{
    b_is_invis = isdefined( self.stub.basin_filled ) && ( isdefined( player.beastmode ) && player.beastmode || self.stub.basin_filled );
    self setinvisibletoplayer( player, b_is_invis );
    
    if ( zombie_utility::is_player_valid( player ) )
    {
        str_gateworm_held = function_7839dceb();
    }
    
    if ( isdefined( str_gateworm_held ) )
    {
        self sethintstring( &"ZM_ZOD_QUEST_RITUAL_PLACE_RELIC" );
    }
    else
    {
        self sethintstring( self.stub.hint_string );
    }
    
    return !b_is_invis;
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xccd231c7, Offset: 0x6b58
// Size: 0x122, Type: bool
function altar_trigger_visibility( player )
{
    b_is_invis = isdefined( level.pap_altar_active ) && ( isdefined( player.beastmode ) && player.beastmode || level.pap_altar_active ) || level flag::get( "ee_book" );
    self setinvisibletoplayer( player, b_is_invis );
    all_basins_filled = are_all_basins_filled();
    
    if ( !all_basins_filled )
    {
        if ( isdefined( level.pap_altar_filled ) )
        {
            self sethintstring( &"ZM_ZOD_QUEST_RITUAL_PAP_REPLACE" );
        }
        else
        {
            self sethintstring( &"ZM_ZOD_QUEST_RITUAL_PAP_NOT_READY" );
        }
    }
    else
    {
        self sethintstring( &"ZM_ZOD_QUEST_RITUAL_PAP_KICKOFF" );
    }
    
    return !b_is_invis;
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xa5420858, Offset: 0x6c88
// Size: 0x58, Type: bool
function are_all_basins_filled()
{
    for ( i = 1; i < 5 ; i++ )
    {
        if ( !level flag::get( "pap_basin_" + i ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xee3b6521, Offset: 0x6ce8
// Size: 0x4e
function clear_all_basins()
{
    for ( i = 1; i < 5 ; i++ )
    {
        level flag::clear( "pap_basin_" + i );
    }
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x70fd60c4, Offset: 0x6d40
// Size: 0x242
function is_holding_relic( characterindex )
{
    someone_has_relic_boxer = level clientfield::get( "quest_state_" + "boxer" );
    someone_has_relic_detective = level clientfield::get( "quest_state_" + "detective" );
    someone_has_relic_femme = level clientfield::get( "quest_state_" + "femme" );
    someone_has_relic_magician = level clientfield::get( "quest_state_" + "magician" );
    who_has_relic_boxer = level clientfield::get( "holder_of_" + "boxer" );
    who_has_relic_detective = level clientfield::get( "holder_of_" + "detective" );
    who_has_relic_femme = level clientfield::get( "holder_of_" + "femme" );
    who_has_relic_magician = level clientfield::get( "holder_of_" + "magician" );
    
    if ( someone_has_relic_boxer === 4 && who_has_relic_boxer === characterindex + 1 )
    {
        return "relic_boxer";
    }
    
    if ( someone_has_relic_detective === 4 && who_has_relic_detective === characterindex + 1 )
    {
        return "relic_detective";
    }
    
    if ( someone_has_relic_femme === 4 && who_has_relic_femme === characterindex + 1 )
    {
        return "relic_femme";
    }
    
    if ( someone_has_relic_magician === 4 && who_has_relic_magician === characterindex + 1 )
    {
        return "relic_magician";
    }
    
    return undefined;
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xdac39f8f, Offset: 0x6f90
// Size: 0xa8
function function_7839dceb()
{
    for ( i = 1; i <= 4 ; i++ )
    {
        str_charname = function_d4c08457( i );
        n_quest_state = level clientfield::get( "quest_state_" + str_charname );
        
        if ( n_quest_state == 4 )
        {
            return function_7130d103( i );
        }
    }
    
    return undefined;
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xbc1f9ed9, Offset: 0x7040
// Size: 0x5e
function function_d4c08457( n_character_index )
{
    switch ( n_character_index )
    {
        case 1:
            return "boxer";
        case 2:
            return "detective";
        case 3:
            return "femme";
        case 4:
            return "magician";
    }
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x8976e17f, Offset: 0x70a8
// Size: 0x5e
function function_7130d103( n_character_index )
{
    switch ( n_character_index )
    {
        case 1:
            return "relic_boxer";
        case 2:
            return "relic_detective";
        case 3:
            return "relic_femme";
        case 4:
            return "relic_magician";
    }
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xc4191acf, Offset: 0x7110
// Size: 0x29c
function basin_trigger_thread()
{
    str_gateworm_held = undefined;
    
    while ( !level flag::get( "ritual_pap_complete" ) )
    {
        self waittill( #"trigger", e_triggerer );
        
        if ( zombie_utility::is_player_valid( e_triggerer ) )
        {
            str_gateworm_held = function_7839dceb();
        }
        
        if ( isdefined( str_gateworm_held ) )
        {
            self.stub.basin_filled = 1;
            self.stub zm_unitrigger::run_visibility_function_for_all_triggers();
            str_flag = self.stub.str_flag;
            level flag::set( str_flag );
            function_5eb042a7( str_flag, str_gateworm_held, 1 );
            e_triggerer thread zm_zod_util::set_rumble_to_player( 6, 1 );
            earthquake( 0.35, 0.3, e_triggerer.origin, 150 );
            e_triggerer thread zm_zod_vo::function_24b80509();
            level clientfield::set( "holder_of_" + zm_zod_craftables::get_character_name_from_value( str_gateworm_held ), 0 );
            e_triggerer zm_craftables::player_remove_craftable_piece( "ritual_pap", "relic_" + zm_zod_craftables::get_character_name_from_value( str_gateworm_held ) );
            level clientfield::set( "quest_state_" + zm_zod_craftables::get_character_name_from_value( str_gateworm_held ), 5 );
            
            if ( are_all_basins_filled() )
            {
                self playsound( "zmb_zod_ritual_pap_worm_place_final" );
            }
            else
            {
                self playsound( "zmb_zod_ritual_pap_worm_place" );
            }
            
            level thread zm_unitrigger::unregister_unitrigger( self.stub );
            return;
        }
        
        wait 0.05;
    }
}

// Namespace zm_zod_quest
// Params 3
// Checksum 0x93376628, Offset: 0x73b8
// Size: 0x1fc
function function_5eb042a7( str_flag, str_gateworm_held, b_is_active )
{
    mdl_gateworm = getent( "quest_ritual_" + str_gateworm_held + "_placed", "targetname" );
    
    if ( b_is_active )
    {
        e_basin = get_worm_basin( str_flag );
        var_16e322eb = str_flag + "_pos";
        var_8835d08c = struct::get( var_16e322eb, "targetname" );
        
        if ( isdefined( var_8835d08c ) )
        {
            mdl_gateworm.origin = var_8835d08c.origin;
            mdl_gateworm.angles = var_8835d08c.angles;
        }
        else
        {
            mdl_gateworm.origin = e_basin.origin + ( 0, 0, 40 );
        }
        
        mdl_gateworm show();
        mdl_gateworm playloopsound( "zmb_zod_ritual_worm_lp" );
        e_basin clientfield::set( "gateworm_basin_fx", 1 );
        mdl_gateworm thread scene::play( "zm_zod_gateworm_idle_basin", mdl_gateworm );
        e_basin playloopsound( "zmb_zod_ritual_pap_worm_firelvl1", 1 );
        return;
    }
    
    mdl_gateworm ghost();
    mdl_gateworm stoploopsound( 0.5 );
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x22e07595, Offset: 0x75c0
// Size: 0xc4
function get_worm_basin( str_flag )
{
    a_e_basins = getentarray( "worm_basin", "targetname" );
    
    foreach ( e_basin in a_e_basins )
    {
        if ( e_basin.script_noteworthy === str_flag )
        {
            return e_basin;
        }
    }
}

// Namespace zm_zod_quest
// Params 2
// Checksum 0x9e927c41, Offset: 0x7690
// Size: 0x248
function watch_wallrun( var_e7fbc48, str_flag )
{
    if ( var_e7fbc48 )
    {
        str_side = "left";
    }
    else
    {
        str_side = "right";
    }
    
    str_wallrun = "quest_ritual_pap_wallrun_" + str_side;
    str_model = "quest_ritual_pap_frieze_" + str_side;
    t_wallrun = getent( str_wallrun, "targetname" );
    t_wallrun triggerenable( 0 );
    t_wallrun thread monitor_wallrun_trigger();
    mdl_frieze = getent( str_model, "targetname" );
    mdl_frieze useanimtree( #animtree );
    
    while ( true )
    {
        flag::wait_till( str_flag );
        exploder::exploder( "fx_exploder_ritual_" + str_flag + "_path" );
        gatestone_increment_power();
        set_frieze_power( var_e7fbc48, 1 );
        
        if ( var_e7fbc48 )
        {
            level clientfield::set( "wallrun_footprints", 1 );
        }
        else
        {
            level clientfield::set( "wallrun_footprints", 2 );
        }
        
        flag::wait_till_clear( str_flag );
        gatestone_decrement_power();
        exploder::stop_exploder( "fx_exploder_ritual_" + str_flag + "_path" );
        set_frieze_power( var_e7fbc48, 0 );
    }
}

// Namespace zm_zod_quest
// Params 2
// Checksum 0x3f56c2af, Offset: 0x78e0
// Size: 0x21c
function set_frieze_power( var_e7fbc48, b_on )
{
    if ( var_e7fbc48 )
    {
        str_side = "left";
    }
    else
    {
        str_side = "right";
    }
    
    t_wallrun = getent( "quest_ritual_pap_wallrun_" + str_side, "targetname" );
    mdl_frieze = getent( "quest_ritual_pap_frieze_" + str_side, "targetname" );
    
    if ( b_on )
    {
        var_4539ae4a = struct::get( "quest_ritual_pap_wallimpacts_" + str_side, "targetname" );
        level thread function_7107ea51( mdl_frieze, var_4539ae4a );
        mdl_frieze animation::play( "p7_fxanim_zm_zod_frieze_anim" );
        mdl_frieze animation::first_frame( "p7_fxanim_zm_zod_frieze_fall_anim" );
        t_wallrun triggerenable( 1 );
        t_wallrun sethintstring( "" );
        exploder::exploder( "fx_exploder_ritual_frieze_" + str_side + "_wallrun" );
        level notify( #"hash_7107ea51" );
        return;
    }
    
    exploder::stop_exploder( "fx_exploder_ritual_frieze_" + str_side + "_wallrun" );
    t_wallrun triggerenable( 0 );
    mdl_frieze animation::play( "p7_fxanim_zm_zod_frieze_fall_anim" );
}

// Namespace zm_zod_quest
// Params 2
// Checksum 0x765f8d6f, Offset: 0x7b08
// Size: 0x17e
function function_7107ea51( var_b12a7acb, var_4539ae4a )
{
    level notify( #"hash_7107ea51" );
    level endon( #"hash_7107ea51" );
    
    while ( true )
    {
        var_b12a7acb util::waittill_any( "impact_rumble", "rumble_stop" );
        earthquake( 0.5, 0.2, var_4539ae4a.origin, 512 );
        
        foreach ( player in level.activeplayers )
        {
            if ( zombie_utility::is_player_valid( player ) && distance2dsquared( player.origin, var_4539ae4a.origin ) < 262144 )
            {
                player zm_zod_util::set_rumble_to_player( 6, 0.25 );
            }
        }
    }
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xacb1d675, Offset: 0x7c90
// Size: 0x44
function gatestone_increment_power()
{
    gatestone_deactivate_power_level_indicator();
    level.gatestone.n_power_level++;
    gatestone_activate_power_level_indicator();
    update_chasm_awakening_vfx();
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x6bc6d3b8, Offset: 0x7ce0
// Size: 0x44
function gatestone_decrement_power()
{
    gatestone_deactivate_power_level_indicator();
    level.gatestone.n_power_level--;
    gatestone_activate_power_level_indicator();
    update_chasm_awakening_vfx();
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x26c453e, Offset: 0x7d30
// Size: 0x54
function gatestone_set_power( n_power_level )
{
    gatestone_deactivate_power_level_indicator();
    level.gatestone.n_power_level = n_power_level;
    gatestone_activate_power_level_indicator();
    update_chasm_awakening_vfx();
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xe95f76f4, Offset: 0x7d90
// Size: 0x4c
function gatestone_deactivate_power_level_indicator()
{
    if ( level.gatestone.n_power_level > 0 )
    {
        exploder::stop_exploder( "fx_exploder_ritual_gatestone_" + level.gatestone.n_power_level + "_glow" );
    }
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x68bdc6f3, Offset: 0x7de8
// Size: 0x6c
function gatestone_activate_power_level_indicator()
{
    if ( level.gatestone.n_power_level > 0 && level.gatestone.n_power_level < 5 )
    {
        exploder::exploder( "fx_exploder_ritual_gatestone_" + level.gatestone.n_power_level + "_glow" );
    }
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xf7545882, Offset: 0x7e60
// Size: 0x54
function update_chasm_awakening_vfx()
{
    if ( level.gatestone.n_power_level > 0 )
    {
        exploder::exploder( "fx_exploder_ritual_chasm_awakened" );
        return;
    }
    
    exploder::stop_exploder( "fx_exploder_ritual_chasm_awakened" );
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x9ed48652, Offset: 0x7ec0
// Size: 0x70
function monitor_wallrun_trigger( t_wallrun )
{
    while ( true )
    {
        self waittill( #"trigger", e_triggerer );
        
        if ( !( isdefined( e_triggerer.b_wall_run_enabled ) && e_triggerer.b_wall_run_enabled ) )
        {
            e_triggerer thread enable_wallrun( self );
        }
    }
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x8fb76bdd, Offset: 0x7f38
// Size: 0xa0
function enable_wallrun( t_trigger )
{
    self endon( #"death" );
    
    if ( isdefined( self.beastmode ) && self.beastmode )
    {
        return;
    }
    
    self.b_wall_run_enabled = 1;
    self allowwallrun( 1 );
    
    while ( self istouching( t_trigger ) )
    {
        wait 0.05;
    }
    
    self allowwallrun( 0 );
    self.b_wall_run_enabled = 0;
}

// Namespace zm_zod_quest
// Params 2
// Checksum 0x6af71da7, Offset: 0x7fe0
// Size: 0x1b8
function watch_island( var_f7225255, str_flag )
{
    if ( var_f7225255 )
    {
        str_side = "near";
    }
    else
    {
        str_side = "far";
    }
    
    e_island = getent( "pap_chamber_middle_island_" + str_side, "targetname" );
    e_island ghost();
    e_clip = getent( "pap_chamber_middle_island_" + str_side + "_clip", "targetname" );
    e_clip setinvisibletoall();
    
    while ( true )
    {
        flag::wait_till( str_flag );
        gatestone_increment_power();
        exploder::exploder( "fx_exploder_ritual_" + str_flag + "_path" );
        function_c3e5d4f( var_f7225255, 1 );
        flag::wait_till_clear( str_flag );
        gatestone_decrement_power();
        exploder::stop_exploder( "fx_exploder_ritual_" + str_flag + "_path" );
        function_c3e5d4f( var_f7225255, 0 );
    }
}

// Namespace zm_zod_quest
// Params 2
// Checksum 0xb98271af, Offset: 0x81a0
// Size: 0x244
function function_c3e5d4f( var_f7225255, b_on )
{
    if ( var_f7225255 )
    {
        str_side = "near";
        var_ea5390b2 = 1;
    }
    else
    {
        str_side = "far";
        var_ea5390b2 = 2;
    }
    
    e_island = getent( "pap_chamber_middle_island_" + str_side, "targetname" );
    e_island useanimtree( #animtree );
    e_clip = getent( "pap_chamber_middle_island_" + str_side + "_clip", "targetname" );
    
    if ( b_on )
    {
        var_4539ae4a = struct::get( "quest_ritual_pap_bridgeimpacts_" + str_side, "targetname" );
        level thread function_7107ea51( e_island, var_4539ae4a );
        e_island show();
        e_island animation::play( "p7_fxanim_zm_zod_pap_bridge_0" + var_ea5390b2 + "_rise_anim" );
        e_island animation::first_frame( "p7_fxanim_zm_zod_pap_bridge_0" + var_ea5390b2 + "_fall_anim" );
        e_clip setvisibletoall();
        level notify( #"hash_7107ea51" );
        return;
    }
    
    e_clip setinvisibletoall();
    e_island animation::play( "p7_fxanim_zm_zod_pap_bridge_0" + var_ea5390b2 + "_fall_anim" );
    e_island ghost();
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x37fcf242, Offset: 0x83f0
// Size: 0x170
function watch_central_traversal( a_flags )
{
    self notify( #"watch_central_traversal" );
    self endon( #"watch_central_traversal" );
    str_traversal = "pap_mid_jump_72";
    nd_traversal = getnode( str_traversal, "targetname" );
    e_monster_clip = getent( "pap_chamber_middle_island_monster_clip", "targetname" );
    
    while ( true )
    {
        flag::wait_till_all( a_flags );
        e_monster_clip moveto( e_monster_clip.origin - ( 0, 0, 5000 ), 0.1 );
        e_monster_clip connectpaths();
        flag::wait_till_clear_any( a_flags );
        e_monster_clip moveto( e_monster_clip.origin + ( 0, 0, 5000 ), 0.1 );
        e_monster_clip disconnectpaths();
    }
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xcc7a616d, Offset: 0x8568
// Size: 0x1f0
function pap_chasm_killtrigger()
{
    t_kill = getent( "pap_chasm_killtrigger", "targetname" );
    level thread function_64cb1f9b( "pap_chasm_side_far", 1 );
    level thread function_64cb1f9b( "pap_chasm_side_near", 0 );
    
    while ( true )
    {
        t_kill waittill( #"trigger", e_triggerer );
        
        if ( isplayer( e_triggerer ) )
        {
            if ( !( isdefined( e_triggerer.beastmode ) && e_triggerer.beastmode ) )
            {
                e_triggerer dodamage( 1000000, e_triggerer.origin );
            }
            
            if ( isdefined( e_triggerer.var_d9394bfb ) && e_triggerer.var_d9394bfb )
            {
                var_38feb4f6 = struct::get_array( "pap_chasm_return_point_far", "targetname" );
            }
            else
            {
                var_38feb4f6 = struct::get_array( "pap_chasm_return_point_near", "targetname" );
            }
            
            var_8f51a1d6 = arraygetclosest( e_triggerer.origin, var_38feb4f6 );
            e_triggerer setorigin( var_8f51a1d6.origin );
            e_triggerer setplayerangles( var_8f51a1d6.angles );
        }
    }
}

// Namespace zm_zod_quest
// Params 2
// Checksum 0x3b86c20, Offset: 0x8760
// Size: 0x94
function function_64cb1f9b( str_trigger_name, var_f8826470 )
{
    t_side = getent( str_trigger_name, "targetname" );
    
    while ( true )
    {
        t_side waittill( #"trigger", e_triggerer );
        
        if ( isplayer( e_triggerer ) )
        {
            e_triggerer.var_d9394bfb = var_f8826470;
        }
    }
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x99ec1590, Offset: 0x8800
// Size: 0x4
function host_migration_listener()
{
    
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x99ec1590, Offset: 0x8810
// Size: 0x4
function track_quest_status_thread()
{
    
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xc8a32922, Offset: 0x8820
// Size: 0x54
function player_death_watcher()
{
    if ( isdefined( level.player_death_watcher_custom_func ) )
    {
        self thread [[ level.player_death_watcher_custom_func ]]();
        return;
    }
    
    self notify( #"player_death_watcher" );
    self endon( #"player_death_watcher" );
    
    /#
        iprintlnbold( "<dev string:x147>" );
    #/
}

/#

    // Namespace zm_zod_quest
    // Params 0
    // Checksum 0x1f63159f, Offset: 0x8880
    // Size: 0x23c, Type: dev
    function quest_devgui()
    {
        level thread zm_zod_util::setup_devgui_func( "<dev string:x15c>", "<dev string:x177>", 1, &function_dc59b750 );
        level thread zm_zod_util::setup_devgui_func( "<dev string:x18f>", "<dev string:x1a7>", 1, &zm_zod_pods::function_3f95af32 );
        level thread zm_zod_util::setup_devgui_func( "<dev string:x1bc>", "<dev string:x1db>", 1, &function_7dda8ea9 );
        level thread zm_zod_util::setup_devgui_func( "<dev string:x1f3>", "<dev string:x21a>", 1, &function_6c6a5914 );
        level thread zm_zod_util::setup_devgui_func( "<dev string:x22f>", "<dev string:x249>", 1, &function_c0a29676 );
        level thread zm_zod_util::setup_devgui_func( "<dev string:x261>", "<dev string:x295>", 1, &function_546835a );
        level thread zm_zod_util::setup_devgui_func( "<dev string:x2a6>", "<dev string:x2d8>", 1, &function_832e2eaa );
        level thread zm_zod_util::setup_devgui_func( "<dev string:x2e8>", "<dev string:x315>", 1, &function_11a2ca3b );
        level thread zm_zod_util::setup_devgui_func( "<dev string:x32c>", "<dev string:x35b>", 1, &function_1dadcc76 );
        level thread zm_zod_util::setup_devgui_func( "<dev string:x373>", "<dev string:x38c>", 1, &function_150df737 );
    }

#/

// Namespace zm_zod_quest
// Params 1
// Checksum 0x1182ffd8, Offset: 0x8ac8
// Size: 0x5c
function function_150df737( n_val )
{
    var_53729670 = level clientfield::get( "rain_state" );
    level clientfield::set( "rain_state", !var_53729670 );
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xe992965c, Offset: 0x8b30
// Size: 0x12a
function function_6c6a5914( n_val )
{
    level clientfield::set( "devgui_gateworm", 1 );
    level thread zm_zod_pods::function_2947f395();
    hidemiscmodels( "robot_model" );
    level flag::set( "police_box_hide" );
    var_dfda7cba = getentarray( "robot_readout_model", "targetname" );
    
    foreach ( mdl_readout in var_dfda7cba )
    {
        mdl_readout hide();
    }
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xe938ec95, Offset: 0x8c68
// Size: 0x74
function function_546835a( n_val )
{
    level endon( #"hash_832e2eaa" );
    level thread exploder::stop_exploder( "ritual_light_magician_fin" );
    level thread ritual_start( "magician" );
    wait 30;
    level thread ritual_succeed( "magician" );
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0xb0fd5bc2, Offset: 0x8ce8
// Size: 0x34
function function_832e2eaa( n_val )
{
    level notify( #"hash_832e2eaa" );
    level thread ritual_fail( "magician" );
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x6e0f689d, Offset: 0x8d28
// Size: 0x26c
function function_c0a29676()
{
    var_cbe37472 = array( "ritual_boxer", "ritual_detective", "ritual_femme", "ritual_magician", "ritual_pap" );
    
    foreach ( var_5afbab23 in var_cbe37472 )
    {
        zm_craftables::complete_craftable( var_5afbab23 );
    }
    
    level.var_522a1f61 = 1;
    var_f99f027c = array( "relic_boxer", "relic_detective", "relic_femme", "relic_magician" );
    
    for ( i = 1; i < 5 ; i++ )
    {
        str_flag = "pap_basin_" + i;
        exploder::exploder( "fx_exploder_ritual_" + str_flag + "_path" );
        str_gateworm_held = "relic_boxer";
        function_5eb042a7( str_flag, var_f99f027c[ i - 1 ], 1 );
        flag::set( str_flag );
    }
    
    set_frieze_power( 1, 1 );
    set_frieze_power( 0, 1 );
    function_c3e5d4f( 1, 1 );
    function_c3e5d4f( 0, 1 );
    gatestone_set_power( 4 );
    ritual_pap_succeed();
}

/#

    // Namespace zm_zod_quest
    // Params 1
    // Checksum 0x28c38d41, Offset: 0x8fa0
    // Size: 0x44, Type: dev
    function function_11a2ca3b( val )
    {
        if ( val )
        {
            level.overridezombiespawn = &function_861cf6b3;
            setdvar( "<dev string:x39f>", 0 );
        }
    }

    // Namespace zm_zod_quest
    // Params 1
    // Checksum 0x96ccc3e5, Offset: 0x8ff0
    // Size: 0x3c, Type: dev
    function function_1dadcc76( val )
    {
        if ( val )
        {
            level.overridezombiespawn = undefined;
            setdvar( "<dev string:x39f>", -1 );
        }
    }

    // Namespace zm_zod_quest
    // Params 0
    // Checksum 0x920a8c27, Offset: 0x9038
    // Size: 0x6e, Type: dev
    function function_861cf6b3()
    {
        var_92d58fd4 = getentarray( "<dev string:x3b7>", "<dev string:x3cd>" );
        ai = var_92d58fd4[ 0 ] spawnfromspawner( 0, 1 );
        return ai;
    }

#/

// Namespace zm_zod_quest
// Params 1
// Checksum 0x8477a574, Offset: 0x90b0
// Size: 0x2c
function function_7dda8ea9( n_val )
{
    level flag::set( "keeper_sword_locker" );
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x6193b9e4, Offset: 0x90e8
// Size: 0x24
function function_dc59b750( n_val )
{
    set_key_availability( 1 );
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x36880276, Offset: 0x9118
// Size: 0x18c
function function_83c8b6e8()
{
    zm_pap_util::set_move_in_func( &function_5630c228 );
    zm_pap_util::set_move_out_func( &function_ea272f07 );
    mdl_pap = getent( "vending_packapunch", "targetname" );
    mdl_pap ghost();
    var_4197ca83 = zm_pap_util::get_triggers();
    
    foreach ( trigger in var_4197ca83 )
    {
        trigger sethintstring( "" );
    }
    
    var_eadb7e53 = getent( "pap_tentacle", "targetname" );
    var_eadb7e53 useanimtree( #animtree );
    var_eadb7e53 ghost();
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x862df713, Offset: 0x92b0
// Size: 0x8a
function function_a6838c4f()
{
    var_eadb7e53 = getent( "pap_tentacle", "targetname" );
    
    if ( !isdefined( var_eadb7e53.org_angles ) )
    {
        var_eadb7e53.org_angles = var_eadb7e53.angles;
    }
    
    var_eadb7e53 useanimtree( #animtree );
    level notify( #"pack_a_punch_on" );
}

// Namespace zm_zod_quest
// Params 4
// Checksum 0x2dc80e95, Offset: 0x9348
// Size: 0x42c
function function_5630c228( player, trigger, origin_offset, angles_offset )
{
    level endon( #"pack_a_punch_off" );
    trigger endon( #"pap_player_disconnected" );
    var_c7c7077b = struct::get( "pap_portal_center", "targetname" );
    var_eadb7e53 = getent( "pap_tentacle", "targetname" );
    
    if ( !isdefined( var_eadb7e53.org_angles ) )
    {
        var_eadb7e53.org_angles = var_eadb7e53.angles;
    }
    
    var_eadb7e53.origin = var_c7c7077b.origin;
    var_eadb7e53.angles = var_eadb7e53.org_angles;
    temp_ent = spawn( "script_model", var_eadb7e53.origin );
    temp_ent.angles = var_eadb7e53.angles;
    temp_ent setmodel( "tag_origin_animate" );
    temp_ent useanimtree( #animtree );
    playsoundatposition( "zmb_zod_pap_activate", var_c7c7077b.origin );
    offsetdw = ( 3, 3, 3 );
    weoptions = 0;
    trigger.worldgun = zm_utility::spawn_buildkit_weapon_model( player, trigger.current_weapon, undefined, self.origin, self.angles );
    worldgundw = undefined;
    
    if ( trigger.current_weapon.isdualwield )
    {
        worldgundw = zm_utility::spawn_buildkit_weapon_model( player, trigger.current_weapon, undefined, self.origin + offsetdw, self.angles );
    }
    
    trigger.worldgun.worldgundw = worldgundw;
    trigger.worldgun linkto( temp_ent, "tag_origin", ( 0, 0, 0 ), angles_offset );
    offsetdw = ( 3, 3, 3 );
    
    if ( isdefined( trigger.worldgun.worldgundw ) )
    {
        trigger.worldgun.worldgundw linkto( temp_ent, "tag_origin", offsetdw, angles_offset );
    }
    
    wait 0.5;
    temp_ent thread animation::play( "o_zombie_zod_packapunch_tentacle_worldgun_taken" );
    var_eadb7e53 show();
    var_eadb7e53 animation::play( "o_zombie_zod_packapunch_tentacle_gun_take" );
    var_eadb7e53 ghost();
    temp_ent delete();
    trigger.worldgun delete();
    
    if ( isdefined( trigger.worldgun.worldgundw ) )
    {
        trigger.worldgun.worldgundw delete();
    }
}

// Namespace zm_zod_quest
// Params 4
// Checksum 0x55e521be, Offset: 0x9780
// Size: 0x43c
function function_ea272f07( player, t_trigger, origin_offset, interact_offset )
{
    level endon( #"pack_a_punch_off" );
    t_trigger endon( #"pap_player_disconnected" );
    var_c7c7077b = struct::get( "pap_portal_center", "targetname" );
    var_eadb7e53 = getent( "pap_tentacle", "targetname" );
    var_eadb7e53.origin = var_c7c7077b.origin;
    var_3acfce06 = spawn( "script_model", var_eadb7e53.origin );
    var_3acfce06.angles = var_eadb7e53.angles;
    var_3acfce06 setmodel( "tag_origin_animate" );
    var_3acfce06 useanimtree( #animtree );
    upoptions = 0;
    var_aa51a9ae = ( 3, 3, 3 );
    t_trigger.worldgun = zm_utility::spawn_buildkit_weapon_model( player, t_trigger.upgrade_weapon, zm_weapons::get_pack_a_punch_camo_index( undefined ), self.origin, self.angles );
    worldgundw = undefined;
    
    if ( t_trigger.upgrade_weapon.isdualwield )
    {
        worldgundw = zm_utility::spawn_buildkit_weapon_model( player, t_trigger.upgrade_weapon, zm_weapons::get_pack_a_punch_camo_index( undefined ), self.origin + var_aa51a9ae, self.angles );
    }
    
    t_trigger.worldgun.worldgundw = worldgundw;
    
    if ( !isdefined( t_trigger.worldgun ) )
    {
        return;
    }
    
    t_trigger.worldgun linkto( var_3acfce06, "tag_origin", ( 0, 0, 0 ), ( 0, 90, 0 ) );
    
    if ( isdefined( t_trigger.worldgun.worldgundw ) )
    {
        t_trigger.worldgun.worldgundw linkto( var_3acfce06, "tag_origin", var_aa51a9ae, ( 0, 90, 0 ) );
    }
    
    t_trigger thread function_4de2af97( var_eadb7e53, var_3acfce06 );
    t_trigger util::waittill_any( "pap_timeout", "pap_taken" );
    t_trigger thread function_f46eb6f9();
    t_trigger thread function_b99f7d2b();
    var_3acfce06 delete();
    var_eadb7e53 animation::stop();
    var_eadb7e53 thread function_2934e5d0( t_trigger );
    
    if ( isdefined( t_trigger.worldgun ) )
    {
        if ( isdefined( t_trigger.worldgun.worldgundw ) )
        {
            t_trigger.worldgun.worldgundw delete();
        }
        
        t_trigger.worldgun delete();
    }
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x7f436620, Offset: 0x9bc8
// Size: 0x3c
function function_f46eb6f9()
{
    self endon( #"pap_timeout" );
    self waittill( #"pap_taken" );
    self playsound( "zmb_zod_pap_take" );
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x44372806, Offset: 0x9c10
// Size: 0x3c
function function_b99f7d2b()
{
    self endon( #"pap_taken" );
    self waittill( #"pap_timeout" );
    self playsound( "zmb_zod_pap_lose" );
}

// Namespace zm_zod_quest
// Params 2
// Checksum 0xb0aa7fb5, Offset: 0x9c58
// Size: 0x9c
function function_4de2af97( var_eadb7e53, var_3acfce06 )
{
    self endon( #"pap_timeout" );
    self endon( #"pap_taken" );
    var_3acfce06 thread animation::play( "o_zombie_zod_packapunch_tentacle_worldgun_ejected" );
    self thread function_e94f1c9c( var_eadb7e53 );
    var_eadb7e53 animation::play( "o_zombie_zod_packapunch_tentacle_extend" );
    var_eadb7e53 thread animation::play( "o_zombie_zod_packapunch_tentacle_extended_loop" );
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x5f5789a9, Offset: 0x9d00
// Size: 0x44
function function_e94f1c9c( var_eadb7e53 )
{
    self endon( #"pap_timeout" );
    self endon( #"pap_taken" );
    wait 0.1;
    var_eadb7e53 show();
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x2080ec0e, Offset: 0x9d50
// Size: 0x4c
function function_2934e5d0( t_trigger )
{
    t_trigger endon( #"pap_player_disconnected" );
    self animation::play( "o_zombie_zod_packapunch_tentacle_retract" );
    self ghost();
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xf284bcf5, Offset: 0x9da8
// Size: 0x3c
function function_c7ea04e6()
{
    self endon( #"death" );
    self waittill( #"hash_bb7a9d17" );
    self playsound( "zmb_zod_pap_finish" );
}

// Namespace zm_zod_quest
// Params 3
// Checksum 0x4e6bbe2f, Offset: 0x9df0
// Size: 0x44
function function_81e2f06e( notify1, alias, notify2 )
{
    self endon( notify2 );
    self waittill( notify1 );
    self playsound( alias );
}

// Namespace zm_zod_quest
// Params 1
// Checksum 0x12793410, Offset: 0x9e40
// Size: 0xd6
function function_ae395e41( a_flags )
{
    a_nodes = getnodearray( "pap_bridge_node", "script_linkname" );
    
    for ( i = 0; i < a_nodes.size ; i++ )
    {
        setenablenode( a_nodes[ i ], 0 );
    }
    
    flag::wait_till_all( a_flags );
    
    for ( i = 0; i < a_nodes.size ; i++ )
    {
        setenablenode( a_nodes[ i ], 1 );
    }
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0xf9f8190f, Offset: 0x9f20
// Size: 0x178
function function_b62ad2c()
{
    var_b63ffd42 = level.a_o_defend_areas[ "magician" ];
    var_578145e1 = level.a_o_defend_areas[ "boxer" ];
    var_e6fe55fe = level.a_o_defend_areas[ "detective" ];
    var_bab3e119 = level.a_o_defend_areas[ "femme" ];
    a_rituals = [];
    array::add( a_rituals, var_b63ffd42 );
    array::add( a_rituals, var_578145e1 );
    array::add( a_rituals, var_e6fe55fe );
    array::add( a_rituals, var_bab3e119 );
    
    for ( i = 0; i < a_rituals.size ; i++ )
    {
        s_ritual = a_rituals[ i ];
        
        if ( s_ritual.m_b_started )
        {
            if ( self istouching( s_ritual.m_e_defend_volume ) )
            {
                return s_ritual;
            }
        }
    }
    
    return undefined;
}

// Namespace zm_zod_quest
// Params 0
// Checksum 0x8c14e5b4, Offset: 0xa0a0
// Size: 0x10
function function_15f1b929()
{
    self.is_in_defend_area = 0;
}

