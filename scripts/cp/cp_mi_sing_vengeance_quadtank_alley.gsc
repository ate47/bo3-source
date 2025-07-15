#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/stealth;
#using scripts/shared/stealth_status;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace vengeance_quadtank_alley;

// Namespace vengeance_quadtank_alley
// Params 2
// Checksum 0x36fa57e4, Offset: 0x9f0
// Size: 0x1f4
function skipto_quadtank_alley_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        vengeance_util::skipto_baseline( str_objective, b_starting );
        vengeance_util::init_hero( "hendricks", str_objective );
        callback::on_spawned( &vengeance_util::give_hero_weapon );
        level.quadtank_alley_intro_org = struct::get( "quadtank_alley_intro_org" );
        level.quadtank_alley_intro_org thread scene::skipto_end( "cin_ven_04_30_quadalleydoor_1st" );
        spawner::add_spawn_function_group( "quadteaser_qt", "script_noteworthy", &quadtank_alley_quadtank_setup );
        level thread function_32620a97();
        vengeance_util::function_e00864bd( "dogleg_1_umbra_gate", 1, "dogleg_1_gate" );
        objectives::set( "cp_level_vengeance_rescue_kane" );
        objectives::set( "cp_level_vengeance_go_to_safehouse" );
        objectives::hide( "cp_level_vengeance_go_to_safehouse" );
        level thread objectives::breadcrumb( "trig_quadtank_alley_obj" );
        load::function_a2995f22();
    }
    
    level thread vengeance_util::function_cc6f3598();
    level thread vengeance_util::function_3f34106b();
    quadtank_alley_main( str_objective, b_starting );
}

// Namespace vengeance_quadtank_alley
// Params 2
// Checksum 0x91cf7fbf, Offset: 0xbf0
// Size: 0x84
function quadtank_alley_main( str_objective, b_starting )
{
    level flag::set( "quadtank_alley_begin" );
    level thread function_c231d685();
    level thread function_c58f9e9a();
    level.ai_hendricks thread setup_quadtank_alley_hendricks( b_starting );
}

// Namespace vengeance_quadtank_alley
// Params 0
// Checksum 0x36f9336b, Offset: 0xc80
// Size: 0xb4
function function_c231d685()
{
    level flag::wait_till( "move_quadtank_alley_hendricks_node_10" );
    savegame::checkpoint_save();
    wait 2;
    level.var_9c196273 = struct::get( "quadtank_alley_breadcrumb_02" );
    objectives::set( "cp_level_vengeance_goto_quadtank_alley_rooftop", level.var_9c196273 );
    level flag::wait_till( "quadtank_alley_rooftop" );
    objectives::hide( "cp_level_vengeance_goto_quadtank_alley_rooftop" );
}

// Namespace vengeance_quadtank_alley
// Params 0
// Checksum 0x521a6c4b, Offset: 0xd40
// Size: 0xe4
function function_32620a97()
{
    var_35a1e4f8 = struct::get( "quadteaser_org", "targetname" );
    trigger::wait_till( "qt_alley_init" );
    var_35a1e4f8 thread scene::init( "cin_ven_04_40_quadteaser_vign_start" );
    trigger::wait_till( "qt_alley_play" );
    var_35a1e4f8 thread scene::play( "cin_ven_04_40_quadteaser_vign_start" );
    e_trigger = getent( "qt_alley_init", "targetname" );
    e_trigger delete();
}

// Namespace vengeance_quadtank_alley
// Params 0
// Checksum 0x18742f7, Offset: 0xe30
// Size: 0x1b4
function quadtank_alley_quadtank_setup()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self vehicle_ai::start_scripted( 1 );
    self util::magic_bullet_shield();
    self.combatactive = 0;
    self quadtank::quadtank_weakpoint_display( 0 );
    vehicle_ai::turnoffalllightsandlaser();
    vehicle_ai::turnoffallambientanims();
    self vehicle::toggle_tread_fx( 0 );
    self vehicle::toggle_exhaust_fx( 0 );
    angles = self gettagangles( "tag_flash" );
    target_vec = self.origin + anglestoforward( ( 0, angles[ 1 ], 0 ) ) * 1000;
    target_vec += ( 0, 0, -500 );
    self settargetorigin( target_vec );
    
    if ( !isdefined( self.emped ) )
    {
        self disableaimassist();
    }
    
    self thread quadtank_alley_quadtank_notetracks();
}

// Namespace vengeance_quadtank_alley
// Params 0
// Checksum 0x8a1d8786, Offset: 0xff0
// Size: 0x3c
function quadtank_alley_quadtank_notetracks()
{
    self endon( #"death" );
    self thread quadtank_fire_missile_watcher();
    self thread quadtank_fire_mg_watcher();
}

// Namespace vengeance_quadtank_alley
// Params 0
// Checksum 0xb2f15d44, Offset: 0x1038
// Size: 0x80
function quadtank_fire_missile_watcher()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittillmatch( #"qt_fire_missile" );
        level util::clientnotify( "qt_fire_missile" );
        thread cp_mi_sing_vengeance_sound::function_b3768e28();
        thread cp_mi_sing_vengeance_sound::function_2afbdce();
        self fireweapon( 0 );
    }
}

// Namespace vengeance_quadtank_alley
// Params 0
// Checksum 0xa2a44df6, Offset: 0x10c0
// Size: 0x122
function quadtank_fire_mg_watcher()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittillmatch( #"qt_fire_mg_on" );
        level util::clientnotify( "qt_fire_mg" );
        self playloopsound( "wpn_qt_mg_loop" );
        thread cp_mi_sing_vengeance_sound::function_2afbdce();
        self thread turret::fire_for_time( -1, 1 );
        self thread turret::fire_for_time( -1, 2 );
        self waittillmatch( #"qt_fire_mg_off" );
        playsoundatposition( "wpn_qt_mg_tail", self.origin );
        self stoploopsound( 0.2 );
        self notify( #"_stop_turret1" );
        self notify( #"_stop_turret2" );
    }
}

// Namespace vengeance_quadtank_alley
// Params 1
// Checksum 0x60fb0eed, Offset: 0x11f0
// Size: 0x18c
function setup_quadtank_alley_hendricks( b_starting )
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self colors::disable();
    self ai::set_behavior_attribute( "cqb", 1 );
    self.goalradius = 32;
    self battlechatter::function_d9f49fba( 0 );
    level thread function_5a90d7e8( b_starting );
    node = getnode( "quadtank_alley_hendricks_node_05", "targetname" );
    self thread ai::force_goal( node, node.radius );
    level flag::wait_till( "move_quadtank_alley_hendricks_node_10" );
    self ai::set_behavior_attribute( "cqb", 0 );
    node = getnode( "quadtank_alley_hendricks_node_10", "targetname" );
    self thread ai::force_goal( node, node.radius );
}

// Namespace vengeance_quadtank_alley
// Params 0
// Checksum 0xe065026a, Offset: 0x1388
// Size: 0x90
function function_c58f9e9a()
{
    e_trigger = getent( "kill_qt_alley_light", "targetname" );
    
    while ( isdefined( e_trigger ) )
    {
        e_trigger waittill( #"trigger", e_other );
        
        if ( isplayer( e_other ) )
        {
            e_other clientfield::set_to_player( "kill_qt_alley_light", 1 );
        }
    }
}

// Namespace vengeance_quadtank_alley
// Params 0
// Checksum 0xec9d3d07, Offset: 0x1420
// Size: 0x34
function function_323d0a39()
{
    level.ai_hendricks waittill( #"plyr_you_okay_hendricks_1" );
    level dialog::player_say( "plyr_you_okay_hendricks_1" );
}

// Namespace vengeance_quadtank_alley
// Params 1
// Checksum 0x52936af5, Offset: 0x1460
// Size: 0x8c
function function_5a90d7e8( b_starting )
{
    if ( !isdefined( b_starting ) || b_starting == 0 )
    {
        level waittill( #"hash_ba467a50" );
    }
    
    level flag::wait_till( "move_quadtank_alley_hendricks_node_10" );
    level.ai_hendricks vengeance_util::function_5fbec645( "hend_something_big_headed_0" );
    level.ai_hendricks vengeance_util::function_5fbec645( "hend_quick_get_to_the_roo_0" );
}

// Namespace vengeance_quadtank_alley
// Params 4
// Checksum 0x6293f53, Offset: 0x14f8
// Size: 0x3c4
function skipto_quadtank_alley_done( str_objective, b_starting, b_direct, player )
{
    level flag::set( "quadtank_alley_end" );
    level util::clientnotify( "qt_alley_done" );
    level thread cleanup_quadtank_alley();
    level struct::delete_script_bundle( "scene", "cin_ven_03_20_storelineup_vign_start_doors_only" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_20_storelineup_vign_exit" );
    level struct::delete_script_bundle( "scene", "cin_ven_03_20_storelineup_vign_exit_reach" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_30_quadalleydoor_1st" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_40_quadteaser_vign_start" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafeexecution_vign_intro" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafeexecution_vign_kill" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafeexecution_vign_esc" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafeburning_vign_esc_civ_01" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafeburning_vign_esc_civ_02" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafeburning_vign_esc_civ_03" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafeburning_vign_loop" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafeburning_vign_main" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafemolotovflush_vign_intro" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafemolotovflush_vign_civa" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafemolotovflush_vign_civb" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafemolotovflush_vign_civc" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafemolotovflush_vign_civd" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafemolotovflush_vign_cive" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafemolotovflush_vign_civf" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_20_cafemolotovflush_vign_civg" );
}

// Namespace vengeance_quadtank_alley
// Params 0
// Checksum 0x77f50388, Offset: 0x18c8
// Size: 0x34
function cleanup_quadtank_alley()
{
    array::run_all( getcorpsearray(), &delete );
}

