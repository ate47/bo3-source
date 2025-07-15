#using scripts/codescripts/struct;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/_vehicle_platform;
#using scripts/cp/cp_mi_cairo_lotus3_sound;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/lotus_util;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace lotus_t2_ascent;

// Namespace lotus_t2_ascent
// Params 2
// Checksum 0x7d266c7f, Offset: 0x1110
// Size: 0x402
function tower_2_ascent_main( str_objective, b_starting )
{
    load::function_73adcefc();
    callback::on_spawned( &on_player_spawned );
    level.ai_hendricks = util::get_hero( "hendricks" );
    skipto::teleport_ai( str_objective );
    scene::init( "cin_lot_09_01_pursuit_1st_switch_end" );
    objectives::set( "cp_level_lotus_go_to_tower_two" );
    var_f23f965a = getent( "hack_panel_ms_cin", "targetname" );
    var_f23f965a hide();
    t_interact = getent( "tower_2_ascent_complete", "targetname" );
    t_interact triggerenable( 0 );
    lotus_util::spawn_funcs_generic_rogue_control();
    spawner::add_spawn_function_group( "team_3", "script_noteworthy", &function_b6e11e5d );
    trigger::use( "trig_tower_2_ascent_start" );
    level thread function_97e1c0b6();
    level thread function_eecc2d6();
    level thread function_afa41a25();
    load::function_a2995f22();
    exploder::exploder( "fx_interior_ambient_falling_debris_tower2" );
    function_a0ab59f();
    level thread namespace_3bad5a01::function_d641bfe3();
    level.ai_hendricks thread function_2eed485d();
    level thread function_562d8d63();
    level thread function_b9f5176f();
    level thread function_a82e3c9a();
    level thread function_24e69186();
    level thread function_25e58e03();
    function_1d0cebf2();
    var_306e8533 = getentarray( "trig_charging_station", "targetname" );
    array::thread_all( var_306e8533, &function_96e4a36 );
    level thread atrium01_mobile_shop_logic();
    function_a8e16f60();
    robot_climb_and_leap();
    level waittill( #"hash_dd19bcbe" );
    
    if ( isdefined( level.bzmutil_waitforallzombiestodie ) )
    {
        [[ level.bzmutil_waitforallzombiestodie ]]();
    }
    
    t_interact triggerenable( 1 );
    a_keyline = getentarray( "t2ascent_ms_panel_end_skipto", "targetname" );
    t_interact hacking::init_hack_trigger( 1, &"cp_level_lotus_hack_console", &"CP_MI_CAIRO_LOTUS_HACK_DOOR_CONSOLE", &function_1fd00721, a_keyline );
    level notify( #"hash_3369554" );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0xa965eb30, Offset: 0x1520
// Size: 0x24
function on_player_spawned()
{
    self.var_4948fbce = undefined;
    self thread function_59b06ed6();
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x78a8b82a, Offset: 0x1550
// Size: 0x108
function function_59b06ed6()
{
    self endon( #"tower_2_ascent_done" );
    self endon( #"death" );
    self endon( #"disconnect" );
    var_9dda0dc8 = getent( "filter_danger_trigger", "targetname" );
    
    while ( true )
    {
        if ( self istouching( var_9dda0dc8 ) )
        {
            if ( !isdefined( self.var_4948fbce ) || !self.var_4948fbce )
            {
                self thread hazard::function_ccddb105( "filter", 1, 999999, 1 );
                self.var_4948fbce = 1;
            }
        }
        else
        {
            self thread hazard::function_60455f28( "filter" );
            self.var_4948fbce = undefined;
        }
        
        wait 1;
    }
}

// Namespace lotus_t2_ascent
// Params 1
// Checksum 0xb4bf46eb, Offset: 0x1660
// Size: 0x314
function function_1fd00721( e_player )
{
    self gameobjects::disable_object();
    var_43f7b899 = getent( "atrium_mobile_shop_door1", "script_noteworthy" );
    var_69fa3302 = getent( "atrium_mobile_shop_door2", "script_noteworthy" );
    var_43f7b899 thread function_d413b369( 59 );
    var_69fa3302 thread function_d413b369( -59 );
    
    if ( isdefined( level.bzm_forceaicleanup ) )
    {
        [[ level.bzm_forceaicleanup ]]();
    }
    
    wait 0.5;
    a_remaining_enemies = getaiteamarray( "team3" );
    array::run_all( a_remaining_enemies, &kill );
    level notify( #"tower_2_ascent_done" );
    
    foreach ( player in level.players )
    {
        player thread hazard::function_60455f28( "filter" );
        player.var_43a8d7c6 = undefined;
    }
    
    objectives::complete( "cp_level_lotus_go_to_tower_two" );
    objectives::complete( "cp_level_lotus_go_to_mobile_shop" );
    level scene::add_scene_func( "cin_lot_11_tower2ascent_3rd_sh050", &function_9e4c698f, "done" );
    var_f23f965a = getent( "hack_panel_ms_cin", "targetname" );
    var_f23f965a show();
    var_4b8428ba = getent( "p_intro_glass_window", "targetname" );
    var_4b8428ba delete();
    
    if ( isdefined( level.bzm_lotusdialogue7callback ) )
    {
        level thread [[ level.bzm_lotusdialogue7callback ]]();
    }
    
    level thread namespace_3bad5a01::function_43ead72c();
    level scene::play( "cin_lot_11_tower2ascent_3rd_sh010", self.trigger.who );
}

// Namespace lotus_t2_ascent
// Params 1
// Checksum 0x34cb0d80, Offset: 0x1980
// Size: 0x4c
function function_d413b369( offset )
{
    var_bff1f526 = self.origin + ( offset, 0, 0 );
    self moveto( var_bff1f526, 0.35 );
}

// Namespace lotus_t2_ascent
// Params 1
// Checksum 0x78b31d2, Offset: 0x19d8
// Size: 0x24
function function_9e4c698f( a_ents )
{
    skipto::objective_completed( "tower_2_ascent" );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x4140e1e9, Offset: 0x1a08
// Size: 0x72
function function_562d8d63()
{
    trigger::wait_till( "trig_stairs_breadcrumb" );
    objectives::breadcrumb( "trig_breadcrumb_t2a_stairs" );
    trigger::wait_till( "trig_t2a_breadcrumb" );
    objectives::breadcrumb( "trig_breadcrumb_tower_2_ascent" );
    level notify( #"hash_dd19bcbe" );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0xe56eefc1, Offset: 0x1a88
// Size: 0x15a
function function_97e1c0b6()
{
    level endon( #"tower_2_ascent_complete" );
    battlechatter::function_d9f49fba( 0 );
    level waittill( #"hash_cb42bb2" );
    level dialog::player_say( "plyr_hendricks_you_sti_0" );
    level.ai_hendricks dialog::say( "hend_i_m_still_here_what_0" );
    level waittill( #"hash_d4b39ff7" );
    level notify( #"hash_794bb7a8" );
    level dialog::player_say( "plyr_where_is_he_kane_0" );
    level dialog::remote( "kane_got_him_in_a_mobil_0" );
    objectives::complete( "cp_level_lotus_go_to_tower_two" );
    objectives::set( "cp_level_lotus_go_to_mobile_shop" );
    flag::wait_till( "spawn_pods_01_activate" );
    level thread function_1d5b90d6();
    trigger::wait_till( "trig_t2a_wasps", undefined, undefined, 0 );
    savegame::checkpoint_save();
    wait 3;
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0xdff26a6c, Offset: 0x1bf0
// Size: 0x144
function function_1d5b90d6()
{
    level dialog::player_say( "plyr_where_we_going_kane_1" );
    level dialog::remote( "tayr_up_0" );
    level.ai_hendricks dialog::say( "hend_john_listen_to_me_0" );
    level dialog::remote( "tayr_it_can_t_be_stopped_0" );
    level.ai_hendricks dialog::say( "hend_you_go_down_this_pat_0" );
    level dialog::remote( "tayr_you_don_t_want_to_do_0" );
    level dialog::player_say( "plyr_don_t_listen_to_him_0" );
    level.ai_hendricks dialog::say( "hend_you_re_fucking_psych_0" );
    level dialog::remote( "tayr_we_re_all_being_used_0" );
    level dialog::remote( "tayr_this_time_around_s_0" );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x5036fcab, Offset: 0x1d40
// Size: 0x14
function function_b6e11e5d()
{
    self.team = "team3";
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x1a149264, Offset: 0x1d60
// Size: 0x62
function function_a0ab59f()
{
    if ( isdefined( level.bzm_lotusdialogue6callback ) )
    {
        level thread [[ level.bzm_lotusdialogue6callback ]]();
    }
    
    scene::play( "cin_lot_09_01_pursuit_1st_switch_end" );
    util::teleport_players_igc( "tower_2_ascent" );
    level notify( #"hash_cb42bb2" );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x51ff0f9c, Offset: 0x1dd0
// Size: 0x94
function function_eecc2d6()
{
    level waittill( #"hash_e6b6da78" );
    level thread scene::play( "p7_fxanim_cp_lotus_hall_debris_01_bundle" );
    trigger::wait_till( "trig_civ_crawl" );
    level thread scene::play( "p7_fxanim_cp_lotus_hall_debris_02_bundle" );
    level waittill( #"hash_c2e0f4f8" );
    level clientfield::set( "t2a_paper_burst", 1 );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0xefc92645, Offset: 0x1e70
// Size: 0x2b4
function function_afa41a25()
{
    var_f19e787 = spawner::simple_spawn_single( "civ_lotus" );
    var_f19e787 ai::set_ignoreme( 1 );
    var_f79b3b69 = struct::get( "sb_civ_choking_1" );
    var_f79b3b69 thread scene::skipto_end( "cin_gen_wounded_vign_choking03", var_f19e787, undefined, 0.5 );
    function_be24fb87( "sb_civ_choking_t2ascent_entry", "cin_gen_wounded_vign_choking01" );
    trigger::wait_till( "trig_civ_crawl" );
    function_be24fb87( "sb_civ_choking_2", "cin_gen_wounded_vign_choking01" );
    function_53775619( "sb_soldier_choking_pair_01", "cin_gen_wounded_vign_choking_pair" );
    trigger::wait_till( "trig_t2a_breadcrumb" );
    function_be24fb87( "sb_civ_choking_3", "cin_gen_wounded_vign_choking02" );
    function_e478d8aa( "sb_soldier_random_death_1", "cin_gen_wounded_last_stand_guy01" );
    function_e478d8aa( "sb_soldier_random_death_2", "cin_gen_wounded_last_stand_guy03" );
    trigger::wait_till( "intro_area_exit" );
    function_be24fb87( "sb_civ_choking_4", "cin_gen_wounded_vign_choking01" );
    function_e478d8aa( "sb_soldier_random_death_3", "cin_gen_wounded_vign_choking02" );
    trigger::wait_till( "trig_sb_civ_choking_5", "script_noteworthy" );
    function_be24fb87( "sb_civ_choking_5", "cin_gen_wounded_vign_choking02" );
    function_e478d8aa( "sb_soldier_random_death_4", "cin_gen_wounded_last_stand_guy02" );
    trigger::wait_till( "trig_t2a_wasps" );
    function_be24fb87( "sb_civ_choking_6", "cin_gen_wounded_vign_choking03" );
    function_e478d8aa( "sb_soldier_random_death_5", "cin_gen_wounded_last_stand_guy01" );
    function_e478d8aa( "sb_soldier_random_death_6", "cin_gen_wounded_last_stand_guy02" );
}

// Namespace lotus_t2_ascent
// Params 2
// Checksum 0xff6f67ed, Offset: 0x2130
// Size: 0x94
function function_be24fb87( var_d83ebd04, str_anim )
{
    var_f19e787 = spawner::simple_spawn_single( "civ_lotus" );
    var_f19e787 ai::set_ignoreme( 1 );
    var_f79b3b69 = struct::get( var_d83ebd04 );
    var_f79b3b69 thread scene::play( str_anim, var_f19e787 );
}

// Namespace lotus_t2_ascent
// Params 2
// Checksum 0xef417349, Offset: 0x21d0
// Size: 0xfc
function function_e478d8aa( var_d83ebd04, str_anim )
{
    selector = randomint( 2 );
    
    if ( selector == 0 )
    {
        spawner = "soldier_assault_lotus";
    }
    else
    {
        spawner = "soldier_supp_lotus";
    }
    
    ai_soldier = spawner::simple_spawn_single( spawner );
    ai_soldier ai::set_ignoreme( 1 );
    ai_soldier ai::set_ignoreall( 1 );
    var_f79b3b69 = struct::get( var_d83ebd04 );
    var_f79b3b69 thread scene::skipto_end( str_anim, ai_soldier );
}

// Namespace lotus_t2_ascent
// Params 2
// Checksum 0xf30f1497, Offset: 0x22d8
// Size: 0x134
function function_53775619( var_d83ebd04, str_anim )
{
    var_a98d2f05 = spawner::simple_spawn_single( "soldier_assault_lotus" );
    var_cf8fa96e = spawner::simple_spawn_single( "soldier_supp_lotus" );
    var_a98d2f05 ai::set_ignoreme( 1 );
    var_cf8fa96e ai::set_ignoreme( 1 );
    var_a98d2f05 ai::set_ignoreall( 1 );
    var_cf8fa96e ai::set_ignoreall( 1 );
    var_f096c1f7 = [];
    var_f096c1f7[ var_f096c1f7.size ] = var_a98d2f05;
    var_f096c1f7[ var_f096c1f7.size ] = var_cf8fa96e;
    var_f79b3b69 = struct::get( var_d83ebd04 );
    var_f79b3b69 thread scene::skipto_end( str_anim, var_f096c1f7 );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x2141291a, Offset: 0x2418
// Size: 0xbc
function function_2eed485d()
{
    trigger::wait_till( "trig_hendricks_cqb" );
    self ai::set_behavior_attribute( "cqb", 1 );
    level flag::wait_till( "rflag_t2_wall_break" );
    self ai::set_behavior_attribute( "cqb", 0 );
    spawn_manager::wait_till_cleared( "sm_wall_break" );
    trigger::use( "trig_stairs_breadcrumb", "targetname", undefined, 0 );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x96f930e6, Offset: 0x24e0
// Size: 0x8a
function function_b9f5176f()
{
    flag::wait_till( "rflag_t2_wall_break" );
    level thread scene::play( "p7_fxanim_cp_lotus_wall_hole_break_through_bundle" );
    spawn_manager::enable( "sm_wall_break" );
    
    while ( !spawn_manager::is_cleared( "sm_wall_break" ) )
    {
        wait 0.05;
    }
    
    level notify( #"hash_d4b39ff7" );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x1f2dd1f1, Offset: 0x2578
// Size: 0x54
function function_a8e16f60()
{
    flag::wait_till( "rflag_t2_ceiling_break" );
    level thread scene::play( "p7_fxanim_cp_lotus_t2_ceiling_collapse_bundle" );
    spawn_manager::enable( "sm_ceiling_hole_01" );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x4d477a43, Offset: 0x25d8
// Size: 0x8c
function robot_climb_and_leap()
{
    trigger::wait_till( "trig_robot_climb_and_leap" );
    ai_leaper = spawner::simple_spawn_single( "robot_climb_and_leap" );
    s_align = struct::get( "align_robot_climb_and_leap" );
    s_align scene::play( "cin_lot_12_01_minigun_vign_invadetop_robot01", ai_leaper );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x943d774b, Offset: 0x2670
// Size: 0x3c
function function_25e58e03()
{
    trigger::wait_till( "trig_ascent_init" );
    level scene::init( "cin_lot_11_tower2ascent_3rd_sh010" );
}

// Namespace lotus_t2_ascent
// Params 4
// Checksum 0x605892dd, Offset: 0x26b8
// Size: 0x24
function tower_2_ascent_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x1f73d9ff, Offset: 0x26e8
// Size: 0x15a
function function_24e69186()
{
    trigger::wait_till( "trig_crush_robots" );
    spawner::simple_spawn( "poor_crushed_bastards" );
    level thread scene::play( "p7_fxanim_cp_lotus_mobile_shop_tower2_balcony_bundle" );
    trigger::wait_till( "trig_crush_robots_mobile_shop" );
    savegame::function_fb150717();
    level thread scene::play( "p7_fxanim_cp_lotus_mobile_shop_tower2_bundle" );
    level waittill( #"hash_ff32a68a" );
    a_ai_crushed = getentarray( "poor_crushed_bastards_ai", "targetname" );
    
    foreach ( ai_crushed in a_ai_crushed )
    {
        ai_crushed kill();
    }
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x4426b4b7, Offset: 0x2850
// Size: 0x26c
function atrium01_mobile_shop_logic()
{
    level.a_ms_teleport_spot_names = [];
    o_vehicle_platform = new cvehicleplatform();
    [[ o_vehicle_platform ]]->init( "atrium01_mobile_shop", "atrium01_moblie_shop_path" );
    vh_atrium01_mobile_shop = [[ o_vehicle_platform ]]->get_platform_vehicle();
    vh_atrium01_mobile_shop setcandamage( 0 );
    a_ms_spawners = getentarray( "atrium01_mobile_shop", "groupname" );
    
    foreach ( n_index, ms_spawner in a_ms_spawners )
    {
        teleport_spot = spawn( "script_origin", ms_spawner.origin + ( 0, 0, 20 ) );
        teleport_spot.angles = ms_spawner.angles;
        teleport_spot.targetname = ms_spawner.targetname + "_telly";
        teleport_spot setinvisibletoall();
        level.a_ms_teleport_spot_names[ ms_spawner.targetname + "_ai" + n_index ] = teleport_spot;
        teleport_spot linkto( vh_atrium01_mobile_shop );
    }
    
    trigger::wait_till( "atrium01_mobile_shop_move" );
    spawn_manager::enable( "sm_atrium01_mobile_shop_enemies" );
    trigger::use( "atrium01_mobile_shop_trigger" );
    level waittill( #"vehicle_platform_atrium01_mobile_shop_stop" );
    level thread function_79518669();
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x3250454d, Offset: 0x2ac8
// Size: 0x1c
function atrium01_mobile_shop_traversals()
{
    linktraversal( self );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x666eeca, Offset: 0x2af0
// Size: 0x334
function function_79518669()
{
    var_43f7b899 = getent( "atrium_mobile_shop_door1", "script_noteworthy" );
    var_69fa3302 = getent( "atrium_mobile_shop_door2", "script_noteworthy" );
    var_43f7b899 unlink();
    var_69fa3302 unlink();
    var_43f7b899 thread function_d413b369( 59 );
    var_69fa3302 thread function_d413b369( -59 );
    array::thread_all( getnodearray( "atrium01_mobile_shop_traversal", "targetname" ), &atrium01_mobile_shop_traversals );
    var_9b973797 = getentarray( "atrium01_mobile_shop_interior", "script_aigroup", 1 );
    v_mobile_shop_enemies_goal = getent( "v_mobile_shop_enemies_goal", "targetname" );
    
    foreach ( enemy in var_9b973797 )
    {
        enemy ai::set_behavior_attribute( "move_mode", "rambo" );
        enemy.goalradius = 16;
    }
    
    array::wait_till( var_9b973797, "goal" );
    
    foreach ( enemy in var_9b973797 )
    {
        if ( isdefined( enemy ) && isalive( enemy ) )
        {
            enemy ai::set_behavior_attribute( "move_mode", "rambo" );
            enemy.goalradius = 1024;
            enemy setgoal( v_mobile_shop_enemies_goal );
        }
    }
    
    var_43f7b899 thread function_d413b369( -59 );
    var_69fa3302 thread function_d413b369( 59 );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x5ec1fbdb, Offset: 0x2e30
// Size: 0xde
function atrium01_mobile_shop_enemies_go()
{
    switch ( self.script_noteworthy )
    {
        case "mobile_shop_shooter_spawners":
            self setgoal( getnode( self.target, "targetname" ) );
            break;
        case "mobile_shop_melee_spawners":
            self ai::set_behavior_attribute( "rogue_control", "forced_level_2" );
            break;
        case "mobile_shop_suicide_spawners":
            self ai::set_behavior_attribute( "rogue_control", "forced_level_3" );
            break;
        default:
            assert( "<dev string:x28>" );
            break;
    }
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x91da482e, Offset: 0x2f18
// Size: 0xa4
function require_hendricks_for_mobile_shop()
{
    self endon( #"trigger" );
    self triggerenable( 0 );
    
    while ( ( !isalive( level.ai_hendricks ) || !level.ai_hendricks istouching( self ) ) && level.ai_hendricks.origin[ 2 ] > 16300 )
    {
        wait 0.2;
    }
    
    self triggerenable( 1 );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x9ebe92a1, Offset: 0x2fc8
// Size: 0x34
function function_a82e3c9a()
{
    level waittill( #"hash_794bb7a8" );
    level thread lui::play_movie( "cp_lotus3_pip_towerjump", "pip" );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x99ec1590, Offset: 0x3008
// Size: 0x4
function function_df51a037()
{
    
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x13d603f, Offset: 0x3018
// Size: 0x1ec
function function_283f872d()
{
    o_mobile_shop = new cvehicleplatform();
    [[ o_mobile_shop ]]->init( "ms_prometheus", "ms_prometheus_start_up" );
    ai_prometheus = util::get_hero( "taylor" );
    ai_prometheus ai::set_ignoreall( 1 );
    ai_prometheus ai::set_ignoreme( 1 );
    vh_mobile = [[ o_mobile_shop ]]->get_platform_vehicle();
    s_align = struct::get( "align_rise" );
    m_align = util::spawn_model( "tag_origin", s_align.origin, s_align.angles );
    m_align.targetname = "tag_align_rise";
    m_align linkto( vh_mobile );
    wait 10;
    m_align thread scene::play( "cin_lot_11_02_tower2_pip_jump_camera" );
    m_align scene::play( "cin_lot_11_02_tower2_pip_jump", ai_prometheus );
    trigger::use( "trig_ms_prometheus", "script_noteworthy" );
    m_align thread scene::play( "cin_lot_11_03_tower2_vign_rise", ai_prometheus );
    level waittill( #"hash_c31669a4" );
    ai_prometheus delete();
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x108282d3, Offset: 0x3210
// Size: 0x4c
function function_1d0cebf2()
{
    level.var_54a1e80 = 0;
    level.var_63a2bc2d = 1;
    scene::add_scene_func( "cin_lotus_charging_station_awaken_robot_static", &function_524683e3, "init" );
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x719223af, Offset: 0x3268
// Size: 0x126
function function_96e4a36()
{
    self waittill( #"trigger" );
    var_336f0a7e = struct::get_array( self.target );
    var_336f0a7e = array::randomize( var_336f0a7e );
    var_5a3059c5 = function_d7b7baa9( var_336f0a7e );
    var_336f0a7e = array::exclude( var_336f0a7e, var_5a3059c5 );
    var_8046f3a7 = function_c0ff2395();
    b_active = 1;
    
    for ( i = 0; i < var_336f0a7e.size ; i++ )
    {
        if ( i >= var_8046f3a7 )
        {
            b_active = 0;
        }
        
        var_336f0a7e[ i ] thread function_de86d341( b_active );
    }
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x65480b22, Offset: 0x3398
// Size: 0xaa
function function_c0ff2395()
{
    switch ( level.players.size )
    {
        case 1:
            var_d3fe3965 = 4;
            break;
        case 2:
            var_d3fe3965 = 6;
            break;
        case 3:
            var_d3fe3965 = 7;
            break;
        case 4:
            var_d3fe3965 = 8;
            break;
        default:
            break;
    }
    
    return var_d3fe3965;
}

// Namespace lotus_t2_ascent
// Params 1
// Checksum 0xdb1a8d42, Offset: 0x3450
// Size: 0x14c
function function_d7b7baa9( var_336f0a7e )
{
    var_99ca2a39 = 0;
    var_11b21d5 = [];
    
    foreach ( var_a1d93799 in var_336f0a7e )
    {
        if ( var_a1d93799.script_label === "ignore" )
        {
            if ( !isdefined( var_11b21d5 ) )
            {
                var_11b21d5 = [];
            }
            else if ( !isarray( var_11b21d5 ) )
            {
                var_11b21d5 = array( var_11b21d5 );
            }
            
            var_11b21d5[ var_11b21d5.size ] = var_a1d93799;
            var_a1d93799 function_b8c02ba3( var_99ca2a39 );
            
            if ( var_99ca2a39 )
            {
                var_99ca2a39 = 0;
                continue;
            }
            
            var_99ca2a39 = 1;
        }
    }
    
    return var_11b21d5;
}

// Namespace lotus_t2_ascent
// Params 1
// Checksum 0x5059baae, Offset: 0x35a8
// Size: 0x14c
function function_b8c02ba3( b_empty )
{
    if ( !isdefined( b_empty ) )
    {
        b_empty = 0;
    }
    
    if ( !b_empty )
    {
        self scene::init( "cin_lotus_charging_station_awaken_robot_static" );
    }
    
    s_door = struct::get( self.target );
    var_c638600 = util::spawn_model( "p7_fxanim_cp_sgen_charging_station_doors_break_mod", s_door.origin, s_door.angles );
    var_38ae1670 = 0;
    
    if ( b_empty )
    {
        if ( randomint( 2 ) )
        {
            var_38ae1670 = 1;
        }
    }
    
    if ( var_38ae1670 )
    {
        s_door scene::skipto_end( "p7_fxanim_cp_sgen_charging_station_break_01_bundle", var_c638600 );
    }
    else
    {
        s_door scene::init( "p7_fxanim_cp_sgen_charging_station_break_01_bundle", var_c638600 );
    }
    
    s_door.var_c638600 = var_c638600;
    return s_door;
}

// Namespace lotus_t2_ascent
// Params 1
// Checksum 0x3f2eda7c, Offset: 0x3700
// Size: 0x212
function function_de86d341( b_active )
{
    s_door = self function_b8c02ba3();
    
    if ( b_active )
    {
        if ( isdefined( self.script_label ) )
        {
            trigger::wait_till( self.script_label );
        }
        else
        {
            wait randomfloatrange( 0.05, 4.65 );
        }
    }
    else if ( level.var_63a2bc2d && level.players.size > 1 )
    {
        level.var_63a2bc2d = 0;
        t_radius = spawn( "trigger_radius", self.origin, 0, 128, 128 );
        t_radius waittill( #"trigger" );
    }
    else
    {
        level.var_63a2bc2d = 1;
        return;
    }
    
    str_anim = "cin_lotus_charging_station_awaken_robot_right";
    
    if ( self.script_string == "left" )
    {
        str_anim = "cin_lotus_charging_station_awaken_robot_left";
    }
    
    level.var_54a1e80++;
    str_spawner = "cs_robot_rusher";
    
    if ( level.var_54a1e80 > 3 )
    {
        level.var_54a1e80 = 0;
        str_spawner = "cs_robot_shooter";
    }
    
    ai_robot = spawner::simple_spawn_single( str_spawner );
    self thread scene::play( str_anim, ai_robot );
    ai_robot waittill( #"breakglass" );
    s_door thread scene::play( "p7_fxanim_cp_sgen_charging_station_break_01_bundle", s_door.var_c638600 );
    self notify( #"hash_2ffb0bc3" );
}

// Namespace lotus_t2_ascent
// Params 1
// Checksum 0xd075c945, Offset: 0x3920
// Size: 0xaa
function function_524683e3( a_entities )
{
    self waittill( #"hash_2ffb0bc3" );
    
    foreach ( e_in_scene in a_entities )
    {
        if ( isdefined( e_in_scene ) )
        {
            e_in_scene delete();
        }
    }
}

// Namespace lotus_t2_ascent
// Params 0
// Checksum 0x68c208f6, Offset: 0x39d8
// Size: 0x14c
function function_7c30c579()
{
    self endon( #"death" );
    level endon( #"tower_2_ascent_done" );
    hendricks_nag_position = getent( "hendricks_nag_position", "targetname" );
    
    while ( true )
    {
        dist_squared = 1000000;
        a_enemies = getactorteamarray( "axis" );
        
        if ( isdefined( a_enemies ) && a_enemies.size > 0 )
        {
            var_2e0763ad = arraygetclosest( self.origin, a_enemies );
            dist_squared = distancesquared( self.origin, var_2e0763ad.origin );
        }
        
        if ( self istouching( hendricks_nag_position ) && dist_squared >= 562500 )
        {
            self scene::play( "cin_gen_ambient_idle_nag", self );
            continue;
        }
        
        wait 0.25;
    }
}

