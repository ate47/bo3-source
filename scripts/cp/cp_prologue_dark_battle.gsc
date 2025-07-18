#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_eth_prologue_accolades;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_prologue_apc;
#using scripts/cp/cp_prologue_cyber_soldiers;
#using scripts/cp/cp_prologue_hangars;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/cybercom/_cybercom_gadget_firefly;
#using scripts/cp/cybercom/_cybercom_gadget_sensory_overload;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace dark_battle;

// Namespace dark_battle
// Params 0
// Checksum 0xec557aa9, Offset: 0xf30
// Size: 0x54
function dark_battle_start()
{
    dark_battle_precache();
    dark_battle_heros_init();
    level thread namespace_21b2c1f2::function_3c37ec50();
    level thread dark_battle_main();
}

// Namespace dark_battle
// Params 0
// Checksum 0xceef6bde, Offset: 0xf90
// Size: 0x24
function dark_battle_precache()
{
    level flag::init( "flag_player_fired_early" );
}

// Namespace dark_battle
// Params 0
// Checksum 0xea2675e9, Offset: 0xfc0
// Size: 0x26c
function dark_battle_heros_init()
{
    battlechatter::function_d9f49fba( 0 );
    level.ai_khalil ai::set_ignoreall( 1 );
    level.ai_khalil ai::set_ignoreme( 1 );
    level.ai_khalil.goalradius = 32;
    level.ai_hyperion ai::set_ignoreall( 1 );
    level.ai_hyperion ai::set_ignoreme( 1 );
    level.ai_hyperion.goalradius = 32;
    level.ai_hyperion.allowpain = 0;
    level.ai_hyperion colors::set_force_color( "p" );
    level.ai_hyperion ai::set_behavior_attribute( "cqb", 1 );
    level.ai_hyperion ai::set_behavior_attribute( "sprint", 0 );
    level.ai_minister ai::set_ignoreall( 1 );
    level.ai_minister ai::set_ignoreme( 1 );
    level.ai_minister.goalradius = 32;
    level.ai_hendricks ai::set_ignoreall( 1 );
    level.ai_hendricks ai::set_ignoreme( 1 );
    level.ai_hendricks.goalradius = 16;
    level.ai_hendricks.allowpain = 0;
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
    level.ai_hendricks ai::set_behavior_attribute( "sprint", 0 );
    
    if ( isalive( level.ai_pallas ) )
    {
        level.ai_pallas delete();
    }
}

// Namespace dark_battle
// Params 0
// Checksum 0xcaf36e10, Offset: 0x1238
// Size: 0x5ec
function dark_battle_main()
{
    objectives::set( "cp_level_prologue_escort_data_center" );
    array::thread_all( level.players, &function_2909799b );
    array::thread_all( level.players, &function_b7634680 );
    callback::on_ai_killed( &function_e2b1615a );
    level thread vtol_guards_handler();
    array::thread_all( level.players, &clientfield::set_to_player, "turn_off_tacmode_vfx", 1 );
    level scene::init( "p7_fxanim_cp_prologue_vtol_tackle_windows_bundle" );
    level thread objectives::breadcrumb( "dark_battle_breadcrumb_3" );
    level thread dark_battle_behavior_handler();
    level thread function_4d2734fa();
    level thread function_c2326e34();
    level thread dark_room_confusion_dialog();
    level thread function_edbf19b4();
    level thread function_312ac345();
    level.ai_hyperion thread function_43d5fd7a();
    level.ai_khalil ai::set_behavior_attribute( "coverIdleOnly", 1 );
    level.ai_minister ai::set_behavior_attribute( "coverIdleOnly", 1 );
    
    if ( isdefined( level.bzm_prologuedialogue5_2callback ) )
    {
        level thread [[ level.bzm_prologuedialogue5_2callback ]]();
    }
    
    function_f7eee26d();
    
    while ( !spawn_manager::is_cleared( "sm_darkroom_spawner" ) )
    {
        wait 0.5;
    }
    
    level thread namespace_21b2c1f2::function_973b77f9();
    level notify( #"hash_a9e3188" );
    level notify( #"hash_bd74d007" );
    level util::clientnotify( "sndDBW" );
    level thread function_4e24163f();
    level thread function_7bd8c5a3();
    battlechatter::function_d9f49fba( 0 );
    level scene::init( "cin_pro_13_01_vtoltackle_vign_takedown" );
    wait 0.05;
    level.ai_hyperion setgoal( getnode( "hyperion_dark_battle_final", "targetname" ), 1 );
    level.ai_hendricks setgoal( getnode( "hendricks_dark_battle_final", "targetname" ), 1 );
    level.ai_hendricks waittill( #"goal" );
    level thread objectives::breadcrumb( "dark_battle_breadcrumb_4" );
    callback::remove_on_ai_killed( &function_e2b1615a );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            player thread function_63222c73();
            player thread function_4933d21a();
        }
    }
    
    playsoundatposition( "evt_doorhack_dooropen", ( 13437, 2216, 252 ) );
    function_62e89023( 1, 0 );
    level thread function_b3666179();
    level.ai_hyperion clearforcedgoal();
    level.ai_khalil ai::set_behavior_attribute( "coverIdleOnly", 0 );
    level.ai_minister ai::set_behavior_attribute( "coverIdleOnly", 0 );
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 0 );
    level.ai_hyperion ai::set_behavior_attribute( "cqb", 0 );
    objectives::complete( "cp_level_prologue_escort_data_center" );
    objectives::set( "cp_level_prologue_find_vehicle" );
    skipto::objective_completed( "skipto_dark_battle" );
}

// Namespace dark_battle
// Params 0
// Checksum 0x1af7c2db, Offset: 0x1830
// Size: 0x2a
function function_7cd37960()
{
    level endon( #"hash_7a9811b7" );
    self waittill( #"weapon_fired" );
    level notify( #"hash_9babf62" );
}

// Namespace dark_battle
// Params 0
// Checksum 0xce981172, Offset: 0x1868
// Size: 0x42
function function_997d6fdc()
{
    level endon( #"hash_7a9811b7" );
    self waittill( #"grenade_fire", grenade, weapon );
    level notify( #"hash_9babf62" );
}

// Namespace dark_battle
// Params 0
// Checksum 0x415add12, Offset: 0x18b8
// Size: 0x92
function function_f7eee26d()
{
    level endon( #"hash_b1b6677a" );
    level endon( #"hash_9babf62" );
    array::thread_all( level.players, &function_7cd37960 );
    array::thread_all( level.players, &function_997d6fdc );
    trigger::wait_till( "t_dark_battle_glass" );
    level notify( #"hash_9babf62" );
}

// Namespace dark_battle
// Params 1
// Checksum 0x9f7fea9e, Offset: 0x1958
// Size: 0x2c
function function_e6296f02( a_ents )
{
    array::thread_all( a_ents, &function_dabc0173 );
}

// Namespace dark_battle
// Params 0
// Checksum 0x69b58f1d, Offset: 0x1990
// Size: 0xac
function function_dabc0173()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self.firing_at_something = 0;
    level flag::wait_till( "flag_player_fired_early" );
    self stopanimscripted();
    self ai::set_ignoreme( 0 );
    self thread dark_battle_spawner_init();
}

// Namespace dark_battle
// Params 0
// Checksum 0xe8f4d990, Offset: 0x1a48
// Size: 0x1a4
function function_4d2734fa()
{
    spawner::add_spawn_function_group( "darkroom_spawner", "targetname", &dark_battle_spawner_init );
    function_62e89023();
    spawn_manager::enable( "sm_darkroom_spawner" );
    spawn_manager::wait_till_complete( "sm_darkroom_spawner" );
    var_5ca9a217 = getent( "outside_dark_battle_room", "targetname" );
    b_clear = 0;
    
    while ( !b_clear )
    {
        b_clear = 1;
        a_ai = spawner::get_ai_group_ai( "aig_darkroom" );
        
        foreach ( ai in a_ai )
        {
            if ( ai istouching( var_5ca9a217 ) )
            {
                b_clear = 0;
                break;
            }
        }
        
        wait 0.5;
    }
    
    function_62e89023( 0, 0 );
}

// Namespace dark_battle
// Params 0
// Checksum 0x653651a7, Offset: 0x1bf8
// Size: 0x1a4
function function_4e24163f()
{
    door_l = getent( "intelstation_bottom_door_l", "targetname" );
    door_r = getent( "intelstation_bottom_door_r", "targetname" );
    v_move = ( 54, 0, 0 );
    move_time = 0.5;
    v_door_destination = door_l.origin + v_move;
    door_l moveto( v_door_destination, move_time );
    v_door_destination = door_r.origin - v_move;
    door_r moveto( v_door_destination, move_time );
    door_l waittill( #"movedone" );
    level.ai_khalil setgoal( getnode( "khalil_dark_battle_final", "targetname" ), 1 );
    wait 1;
    level.ai_minister setgoal( getnode( "minister_dark_battle_final", "targetname" ), 1 );
}

// Namespace dark_battle
// Params 0
// Checksum 0x39a33272, Offset: 0x1da8
// Size: 0xfc
function function_b3666179()
{
    t_door = getent( "t_vtol_tackle_doors", "targetname" );
    a_friendly_ai = array( level.ai_minister, level.ai_hendricks, level.ai_khalil, level.ai_hyperion );
    level thread cp_prologue_util::function_21f52196( "vtol_tackle_doors", t_door );
    level thread cp_prologue_util::function_2e61b3e8( "vtol_tackle_doors", t_door, a_friendly_ai );
    
    while ( !cp_prologue_util::function_cdd726fb( "vtol_tackle_doors" ) )
    {
        wait 0.05;
    }
    
    function_62e89023( 0, 0 );
}

// Namespace dark_battle
// Params 2
// Checksum 0xe7ec0ae5, Offset: 0x1eb0
// Size: 0x23a
function function_62e89023( b_open, var_abf03d83 )
{
    if ( !isdefined( b_open ) )
    {
        b_open = 1;
    }
    
    if ( !isdefined( var_abf03d83 ) )
    {
        var_abf03d83 = 1;
    }
    
    var_280d5f68 = getent( "dark_battle_door_l", "targetname" );
    var_3c301126 = getent( "dark_battle_door_r", "targetname" );
    n_open_time = 1;
    
    if ( !b_open )
    {
        n_open_time = 0.4;
    }
    
    if ( var_abf03d83 )
    {
        n_open_time = 0.05;
    }
    
    v_side = anglestoright( var_280d5f68.angles );
    
    if ( b_open )
    {
        v_pos_left = var_280d5f68.origin + v_side * 52 * -1;
        var_280d5f68 moveto( v_pos_left, n_open_time );
        v_pos_right = var_3c301126.origin + v_side * 52;
        var_3c301126 moveto( v_pos_right, n_open_time );
    }
    else
    {
        v_pos_left = var_280d5f68.origin + v_side * 52;
        var_280d5f68 moveto( v_pos_left, n_open_time );
        v_pos_right = var_3c301126.origin + v_side * 52 * -1;
        var_3c301126 moveto( v_pos_right, n_open_time );
    }
    
    var_3c301126 waittill( #"movedone" );
}

// Namespace dark_battle
// Params 0
// Checksum 0x24f6f07f, Offset: 0x20f8
// Size: 0x27c
function function_43d5fd7a()
{
    level scene::add_scene_func( "cin_pro_12_01_darkbattle_vign_dive_kill_enemyloop", &function_e6296f02 );
    level thread dialog::remote( "hall_heads_up_we_have_m_0", undefined, "normal" );
    level thread scene::play( "cin_pro_12_01_darkbattle_vign_dive_kill_enemyloop" );
    level thread function_356b8cd9();
    level.ai_hyperion colors::disable();
    level.ai_hendricks colors::disable();
    level.ai_hendricks setgoal( getnode( "hendricks_dark_battle_start", "targetname" ), 1 );
    level.ai_hyperion setgoal( getnode( "diaz_dark_battle_start", "targetname" ), 1 );
    util::waittill_multiple_ents( level.ai_hyperion, "goal", level.ai_hendricks, "goal" );
    wait 1;
    level flag::wait_till_any( array( "dark_battle_player_upstairs", "flag_player_fired_early" ) );
    level scene::play( "cin_pro_12_01_darkbattle_vign_dive_kill_start" );
    level.ai_hyperion thread function_619c28d();
    level notify( #"hash_307c99bd" );
    
    if ( !level flag::get( "flag_player_fired_early" ) )
    {
        level notify( #"hash_b1b6677a" );
        level scene::play( "cin_pro_12_01_darkbattle_vign_dive_kill_attack" );
    }
    
    level.ai_hyperion ai::set_ignoreall( 0 );
    level.ai_hendricks battlechatter::function_d9f49fba( 1 );
    level thread hyperion_movement();
}

// Namespace dark_battle
// Params 0
// Checksum 0x7b43fe6f, Offset: 0x2380
// Size: 0x6c
function function_619c28d()
{
    level endon( #"hash_a9e3188" );
    self dialog::say( "mare_remember_they_ain_0" );
    wait 5;
    self dialog::say( "mare_take_it_slow_pick_0" );
    wait 10;
    self dialog::say( "mare_use_your_advantage_0" );
}

// Namespace dark_battle
// Params 0
// Checksum 0xd9486519, Offset: 0x23f8
// Size: 0x4c
function function_356b8cd9()
{
    level endon( #"hash_b1b6677a" );
    level flag::wait_till( "flag_player_fired_early" );
    level scene::stop( "cin_pro_12_01_darkbattle_vign_dive_kill_enemyloop" );
}

// Namespace dark_battle
// Params 0
// Checksum 0x81ce57f6, Offset: 0x2450
// Size: 0x1a6
function hyperion_movement()
{
    self endon( #"hash_a9e3188" );
    var_72069915 = getnode( "hyperion_dark_battle_1", "targetname" );
    level.ai_hyperion setgoal( var_72069915, 1 );
    level.ai_hyperion waittill( #"goal" );
    wait 5;
    var_9809137e = getnode( "hyperion_dark_battle_2", "targetname" );
    level.ai_hyperion setgoal( var_9809137e, 1 );
    level.ai_hyperion waittill( #"goal" );
    wait 5;
    var_be0b8de7 = getnode( "hyperion_dark_battle_3", "targetname" );
    level.ai_hyperion setgoal( var_be0b8de7, 1 );
    level.ai_hyperion waittill( #"goal" );
    wait 5;
    var_b3fa3508 = getnode( "hyperion_dark_battle_4", "targetname" );
    level.ai_hyperion setgoal( var_b3fa3508, 1 );
    level.ai_hyperion waittill( #"goal" );
}

// Namespace dark_battle
// Params 0
// Checksum 0x8ee44502, Offset: 0x2600
// Size: 0x186
function function_312ac345()
{
    self endon( #"hash_a9e3188" );
    level waittill( #"hash_307c99bd" );
    level.ai_hendricks battlechatter::function_d9f49fba( 1 );
    level.ai_hendricks ai::set_ignoreall( 0 );
    var_900c9df2 = getnode( "hendricks_dark_battle_1", "targetname" );
    level.ai_hendricks setgoal( var_900c9df2, 1 );
    level.ai_hendricks waittill( #"goal" );
    wait 6;
    var_6a0a2389 = getnode( "hendricks_dark_battle_2", "targetname" );
    level.ai_hendricks setgoal( var_6a0a2389, 1 );
    level.ai_hendricks waittill( #"goal" );
    wait 6;
    var_4407a920 = getnode( "hendricks_dark_battle_3", "targetname" );
    level.ai_hendricks setgoal( var_4407a920, 1 );
    level.ai_hendricks waittill( #"goal" );
}

// Namespace dark_battle
// Params 0
// Checksum 0x3416d9e7, Offset: 0x2790
// Size: 0x2b4
function function_c2326e34()
{
    level endon( #"hash_c63a5f38" );
    var_94ace873 = getentarray( "dark_wall_logo_off", "targetname" );
    var_cd29e581 = getentarray( "dark_wall_logo_on", "targetname" );
    
    foreach ( e_sign in var_94ace873 )
    {
        e_sign ghost();
    }
    
    level waittill( #"hash_400d768d" );
    exploder::stop_exploder( "light_exploder_darkbattle" );
    level util::clientnotify( "sndDBB" );
    
    foreach ( e_sign in var_cd29e581 )
    {
        e_sign ghost();
    }
    
    foreach ( e_sign in var_94ace873 )
    {
        e_sign show();
    }
    
    level waittill( #"hash_113f3cd3" );
    array::thread_all( level.activeplayers, &oed::set_player_ev, 1 );
    level flag::set( "ev_enabled" );
    wait 1;
    level notify( #"lights_out" );
    level thread namespace_21b2c1f2::function_a0f24f9b();
}

// Namespace dark_battle
// Params 0
// Checksum 0xf450f73f, Offset: 0x2a50
// Size: 0x17c
function function_edbf19b4()
{
    level waittill( #"hash_7a9811b7" );
    var_280d5f68 = getent( "intelstation_balcony_door_l", "targetname" );
    var_3c301126 = getent( "intelstation_balcony_door_r", "targetname" );
    playsoundatposition( "evt_doorhack_dooropen", var_3c301126.origin );
    v_move = ( 54, 0, 0 );
    n_move_time = 0.5;
    v_door_destination = var_280d5f68.origin + v_move;
    var_280d5f68 moveto( v_door_destination, n_move_time );
    v_door_destination = var_3c301126.origin - v_move;
    var_3c301126 moveto( v_door_destination, n_move_time );
    var_3c301126 waittill( #"movedone" );
    var_3c301126 connectpaths();
    var_280d5f68 connectpaths();
}

// Namespace dark_battle
// Params 0
// Checksum 0xa1dfed8, Offset: 0x2bd8
// Size: 0xfc
function function_7bd8c5a3()
{
    level.ai_hyperion dialog::say( "mare_clear_0", 1 );
    level.ai_hyperion thread dialog::say( "mare_disabling_tactical_f_0", 0.5 );
    wait 1;
    array::thread_all( level.players, &oed::set_player_ev, 0 );
    level flag::clear( "ev_enabled" );
    wait 1;
    exploder::exploder( "light_exploder_darkbattle" );
    level util::clientnotify( "sndDBBe" );
    level thread namespace_21b2c1f2::function_2a66b344();
}

// Namespace dark_battle
// Params 0
// Checksum 0xc97fa59c, Offset: 0x2ce0
// Size: 0x278
function dark_room_confusion_dialog()
{
    level waittill( #"hash_400d768d" );
    wait 0.5;
    
    while ( spawner::get_ai_group_count( "aig_darkroom" ) > 6 )
    {
        a_ai_array = getaiteamarray( "axis" );
        var_e248524d = array::get_all_closest( level.players[ 0 ].origin, a_ai_array, undefined, 4 );
        var_1f76714 = array( "hear_that", "cannot_hide", "happened_lights", "power_on" );
        
        for ( i = 0; i < var_e248524d.size ; i++ )
        {
            if ( isalive( var_e248524d[ 0 ] ) )
            {
                var_e248524d[ i ] function_11c60e29( var_1f76714[ i ] );
            }
        }
        
        wait 1;
    }
    
    while ( spawner::get_ai_group_count( "aig_darkroom" ) > 1 )
    {
        a_ai_array = getaiteamarray( "axis" );
        var_e248524d = array::get_all_closest( level.players[ 0 ].origin, a_ai_array, undefined, 4 );
        var_1f76714 = array( "cant_see", "please_no", "dont_take", "screw_this" );
        
        for ( i = 0; i < var_e248524d.size ; i++ )
        {
            if ( isalive( var_e248524d[ 0 ] ) )
            {
                var_e248524d[ i ] function_11c60e29( var_1f76714[ i ] );
            }
        }
        
        wait 1;
    }
}

// Namespace dark_battle
// Params 1
// Checksum 0xc806bd22, Offset: 0x2f60
// Size: 0x66
function function_11c60e29( s_vo )
{
    n_wait_time = randomfloatrange( 0.4, 1 );
    wait n_wait_time;
    
    if ( isalive( self ) )
    {
        self notify( #"scriptedbc", s_vo );
    }
}

// Namespace dark_battle
// Params 0
// Checksum 0x6ec1f347, Offset: 0x2fd0
// Size: 0xbc
function dark_battle_behavior_handler()
{
    foreach ( player in level.players )
    {
        player thread dark_battle_player_firing_check();
    }
    
    level.ai_hyperion thread dark_battle_ai_firing_check();
    level.ai_hendricks thread dark_battle_ai_firing_check();
}

// Namespace dark_battle
// Params 0
// Checksum 0x736df4d6, Offset: 0x3098
// Size: 0x1f4
function dark_battle_spawner_init()
{
    self endon( #"hash_bd74d007" );
    self endon( #"death" );
    self.firing_at_something = 0;
    self ai::set_behavior_attribute( "cqb", 1 );
    self ai::set_ignoreall( 1 );
    self.goalradius = 32;
    self thread function_494e04e8();
    level waittill( #"lights_out" );
    self ai::set_ignoreall( 0 );
    self.goalradius = 32;
    self.maxsightdistsqrd = 4096;
    choice = randomintrange( 1, 4 );
    
    switch ( choice )
    {
        case 1:
            str_anim = "cin_gen_vign_confusion_01";
            break;
        case 2:
            str_anim = "cin_gen_vign_confusion_02";
            break;
        case 3:
            str_anim = "cin_gen_vign_confusion_03";
            break;
        default:
            assert( 0, "<dev string:x28>" );
            break;
    }
    
    delay = randomfloatrange( 0.1, 0.5 );
    wait delay;
    self thread scene::play( str_anim, self );
    level waittill( #"hash_307c99bd" );
    
    if ( self scene::is_playing( str_anim ) )
    {
        self scene::stop( str_anim );
    }
}

// Namespace dark_battle
// Params 0
// Checksum 0xf426fc71, Offset: 0x3298
// Size: 0x78
function function_494e04e8()
{
    self endon( #"hash_b1b6677a" );
    self endon( #"lights_out" );
    self endon( #"death" );
    level waittill( #"hash_9babf62" );
    level flag::set( "flag_player_fired_early" );
    self ai::set_ignoreall( 0 );
    self.goalradius = 96;
}

// Namespace dark_battle
// Params 0
// Checksum 0x56bdb462, Offset: 0x3318
// Size: 0x56
function dark_battle_player_firing_check()
{
    self endon( #"hash_bd74d007" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        self thread dark_battle_shots_fired( 1 );
        wait 3;
    }
}

// Namespace dark_battle
// Params 0
// Checksum 0x68554026, Offset: 0x3378
// Size: 0x56
function dark_battle_ai_firing_check()
{
    self endon( #"hash_bd74d007" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"about_to_fire" );
        self thread dark_battle_shots_fired( 0.25 );
        wait 3;
    }
}

// Namespace dark_battle
// Params 1
// Checksum 0x87f56b33, Offset: 0x33d8
// Size: 0x122
function dark_battle_shots_fired( n_chance )
{
    self endon( #"death" );
    self endon( #"hash_bd74d007" );
    a_enemies = getentarray( "darkroom_enemy", "script_noteworthy" );
    
    foreach ( cur_enemy in a_enemies )
    {
        if ( isalive( cur_enemy ) && n_chance > randomfloatrange( 0, 1 ) )
        {
            if ( cur_enemy.firing_at_something == 0 )
            {
                cur_enemy thread fire_at_location( self );
            }
        }
    }
}

// Namespace dark_battle
// Params 2
// Checksum 0xe751ded0, Offset: 0x3508
// Size: 0x256
function fire_at_location( e_target, duration )
{
    if ( !isdefined( duration ) )
    {
        duration = 5;
    }
    
    self endon( #"death" );
    self.firing_at_something = 1;
    
    if ( isplayer( e_target ) )
    {
        var_a03ca40a = e_target;
    }
    else
    {
        var_a03ca40a = spawn( "script_model", e_target.origin + ( 0, 0, 32 ) );
        var_a03ca40a setmodel( "tag_origin" );
        var_a03ca40a.health = 1000;
        var_a03ca40a.takedamage = 0;
        var_a03ca40a thread move_target( e_target, self );
        var_a03ca40a thread dark_battle_ai_delete_target( duration + 1 );
    }
    
    self setgoal( self.origin, 1 );
    self thread ai::shoot_at_target( "shoot_until_target_dead", var_a03ca40a, undefined, duration );
    wait duration;
    self thread ai::stop_shoot_at_target();
    self.firing_at_something = 0;
    a_nodes = getcovernodearray( self.origin, 192 );
    
    foreach ( node in a_nodes )
    {
        if ( !isnodeoccupied( node ) )
        {
            self setgoal( node );
            break;
        }
    }
}

// Namespace dark_battle
// Params 2
// Checksum 0xe586d545, Offset: 0x3768
// Size: 0x1cc
function move_target( e_target, e_shooter )
{
    v_right = anglestoright( e_target.angles );
    var_7dad3ff1 = v_right * 50;
    var_a0d5e21e = var_7dad3ff1 + e_target.origin;
    var_58670eab = var_7dad3ff1 * -1 + e_target.origin;
    var_67766dec = e_target.origin;
    var_20b9665f = e_target.origin + ( 0, 0, 50 );
    
    while ( isdefined( e_shooter ) && e_shooter.firing_at_something == 1 )
    {
        self moveto( var_58670eab, 0.5 );
        self waittill( #"movedone" );
        self moveto( var_67766dec, 0.5 );
        self waittill( #"movedone" );
        self moveto( var_a0d5e21e, 0.5 );
        self waittill( #"movedone" );
        self moveto( var_20b9665f, 0.5 );
        self waittill( #"movedone" );
    }
}

// Namespace dark_battle
// Params 1
// Checksum 0xcb07e299, Offset: 0x3940
// Size: 0x24
function dark_battle_ai_delete_target( duration )
{
    wait duration;
    self delete();
}

// Namespace dark_battle
// Params 1
// Checksum 0x2670f7f3, Offset: 0x3970
// Size: 0x208
function fire_random_direction( height_offset )
{
    self endon( #"death" );
    height_offset = 48 + height_offset;
    self.firing_at_something = 1;
    distance = 64 + height_offset;
    
    for ( i = 0; i < 3 ; i++ )
    {
        myangles = self.angles;
        random_yaw = randomfloatrange( myangles[ 1 ] + 30, myangles[ 1 ] + 90 );
        new_angles = ( 0, random_yaw, 0 );
        vector = anglestoforward( new_angles );
        height_offset_vector = ( 0, 0, height_offset );
        end_point = self.origin + height_offset_vector + vector * distance;
        var_a03ca40a = spawn( "script_origin", end_point );
        var_a03ca40a.health = 1000;
        duration = 1.5;
        self setgoal( self.origin, 1 );
        self ai::shoot_at_target( "normal", var_a03ca40a, undefined, duration );
        wait duration;
        var_a03ca40a delete();
    }
    
    self.firing_at_something = 0;
}

// Namespace dark_battle
// Params 0
// Checksum 0x4e71109b, Offset: 0x3b80
// Size: 0x54
function vtol_guards_handler()
{
    spawner::add_spawn_function_group( "vtol_tackle_guy", "script_noteworthy", &cp_prologue_util::ai_idle_then_alert, "vtol_guards_alerted" );
    spawn_manager::enable( "vtol_tackle_spwn_mgr2" );
}

// Namespace dark_battle
// Params 0
// Checksum 0x7469bc7e, Offset: 0x3be0
// Size: 0x8c
function function_2909799b()
{
    if ( !self flag::exists( "no_damage_taken" ) )
    {
        self flag::init( "no_damage_taken" );
    }
    
    self flag::set( "no_damage_taken" );
    self waittill( #"damage" );
    self flag::clear( "no_damage_taken" );
}

// Namespace dark_battle
// Params 0
// Checksum 0xa61de96f, Offset: 0x3c78
// Size: 0x64
function function_4933d21a()
{
    self endon( #"death" );
    
    if ( self flag::exists( "no_damage_taken" ) && self flag::get( "no_damage_taken" ) )
    {
        prologue_accolades::function_b9175513( self );
    }
}

// Namespace dark_battle
// Params 0
// Checksum 0x33412dc, Offset: 0x3ce8
// Size: 0x74
function function_b7634680()
{
    self flag::init( "used_only_melee", 1 );
    self flag::init( "melee_killed_ai" );
    self thread function_b12285b9();
    self thread function_5f41b7ea();
}

// Namespace dark_battle
// Params 1
// Checksum 0xceecc8aa, Offset: 0x3d68
// Size: 0xa4
function function_e2b1615a( params )
{
    if ( isplayer( params.eattacker ) )
    {
        if ( params.eattacker flag::exists( "melee_killed_ai" ) && !params.eattacker flag::get( "melee_killed_ai" ) )
        {
            params.eattacker flag::set( "melee_killed_ai" );
        }
    }
}

// Namespace dark_battle
// Params 0
// Checksum 0x9214a0ef, Offset: 0x3e18
// Size: 0x44
function function_b12285b9()
{
    self waittill( #"grenade_fire", grenade, weapon );
    self flag::clear( "used_only_melee" );
}

// Namespace dark_battle
// Params 0
// Checksum 0x4b413ed9, Offset: 0x3e68
// Size: 0x2c
function function_5f41b7ea()
{
    self waittill( #"weapon_fired" );
    self flag::clear( "used_only_melee" );
}

// Namespace dark_battle
// Params 0
// Checksum 0x8bdc5066, Offset: 0x3ea0
// Size: 0x84
function function_63222c73()
{
    self endon( #"death" );
    
    if ( self flag::exists( "used_only_melee" ) && self flag::get( "used_only_melee" ) && self flag::get( "melee_killed_ai" ) )
    {
        prologue_accolades::function_df19cf7c( self );
    }
}

#namespace vtol_tackle;

// Namespace vtol_tackle
// Params 1
// Checksum 0xe401cd8a, Offset: 0x3f30
// Size: 0x3bc
function vtol_tackle_main( b_starting )
{
    var_6cf84815 = array( level.ai_hyperion, level.ai_prometheus, level.ai_khalil, level.ai_minister, level.ai_hendricks );
    array::thread_all( var_6cf84815, &function_b243f34 );
    
    if ( !b_starting )
    {
        level flag::wait_till( "dark_battle_end" );
    }
    
    vtol_tackle_scene( b_starting );
    trigger::use( "post_vtol_tackle_colors" );
    level.ai_hendricks colors::enable();
    savegame::checkpoint_save();
    level thread vtol_tackle_enemies();
    level waittill( #"hash_147f8c7" );
    level cp_prologue_util::spawn_coop_player_replacement( "skipto_vtol_tackle_ai" );
    
    foreach ( ai_ally in level.var_681ad194 )
    {
        ai_ally thread hangar::ai_teleport( "ally_0" + ai_ally.var_a89679b6 + "_vtol_tackle_node" );
        ai_ally function_b243f34();
    }
    
    level thread objectives::breadcrumb( "dark_battle_breadcrumb_5" );
    array::thread_all( var_6cf84815, &function_b243f34, 0 );
    array::thread_all( level.var_681ad194, &function_b243f34, 0 );
    
    if ( isdefined( level.ai_pallas ) )
    {
        level.ai_pallas colors::disable();
    }
    
    level.ai_prometheus colors::set_force_color( "o" );
    n_node = getnode( "theia_vtol_tackle_node", "targetname" );
    level.ai_hyperion setgoal( n_node, 1 );
    level.ai_hendricks thread hendricks_vtol_tackle_path();
    level thread hendricks_vtol_snark();
    level flag::wait_till( "vtol_tackle_move_allies" );
    thread dark_battle_cleanup();
    spawn_manager::kill( "vtol_tackle_spwn_mgr", 1 );
    level thread enemies_killed_timeout();
    level flag::wait_till( "robot_reveal" );
    skipto::objective_completed( "skipto_vtol_tackle" );
}

// Namespace vtol_tackle
// Params 0
// Checksum 0x84318ea6, Offset: 0x42f8
// Size: 0x34
function vtol_tackle_enemies()
{
    spawn_manager::enable( "vtol_tackle_spwn_mgr_door" );
    spawner::simple_spawn_single( "vtol_tackle_staircase_guard" );
}

// Namespace vtol_tackle
// Params 1
// Checksum 0x8fb1a16f, Offset: 0x4338
// Size: 0xb4
function function_b243f34( b_state )
{
    if ( !isdefined( b_state ) )
    {
        b_state = 1;
    }
    
    if ( b_state )
    {
        self ai::set_ignoreall( 1 );
        self ai::set_ignoreme( 1 );
        self.goalradius = 32;
        return;
    }
    
    self battlechatter::function_d9f49fba( 1 );
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
}

// Namespace vtol_tackle
// Params 1
// Checksum 0x4ebaaba6, Offset: 0x43f8
// Size: 0x27c
function vtol_tackle_scene( b_starting )
{
    array::thread_all( level.players, &function_236046c4 );
    level scene::add_scene_func( "cin_pro_13_01_vtoltackle_vign_takedown", &function_b007992c, "play" );
    
    if ( b_starting )
    {
        level thread scene::skipto_end( "cin_pro_13_01_vtoltackle_vign_takedown", undefined, undefined, 0.2 );
        level thread scene::skipto_end( "cin_pro_13_01_vtoltackle_vign_takedown_khalil", undefined, undefined, 0.2 );
        level thread scene::skipto_end( "cin_pro_13_01_vtoltackle_vign_takedown_minister", undefined, undefined, 0.2 );
    }
    else
    {
        level thread scene::play( "cin_pro_13_01_vtoltackle_vign_takedown" );
        level thread scene::play( "cin_pro_13_01_vtoltackle_vign_takedown_khalil" );
        level thread scene::play( "cin_pro_13_01_vtoltackle_vign_takedown_minister" );
    }
    
    level.ai_hyperion setgoal( getnode( "hyperion_post_dark_battle", "targetname" ), 1 );
    vehicle::simple_spawn_single_and_drive( "vtol_vehicle" );
    level thread function_623731e2();
    level thread function_321578a8();
    level thread vtol_tackle_doors();
    level waittill( #"hash_7ab4e268" );
    level flag::set( "vtol_has_crashed" );
    level flag::set( "vtol_guards_alerted" );
    node = getnode( "prometheus_vtol_tackle_node2", "targetname" );
    level.ai_prometheus thread ai::force_goal( node, 32 );
}

// Namespace vtol_tackle
// Params 1
// Checksum 0x61634651, Offset: 0x4680
// Size: 0x16c
function function_b007992c( a_ents )
{
    vh_vtol = a_ents[ "vtol" ];
    vh_vtol.script_crashtypeoverride = "none";
    vh_vtol thread cp_prologue_util::vehicle_rumble( "buzz_high", "stop_vh_rumble", 0.05, 0.1, 3000, 20 );
    vh_vtol thread cp_prologue_util::function_c56034b7();
    level waittill( #"hash_3af3e792" );
    vh_vtol notify( #"death" );
    vh_vtol notify( #"stop_vh_rumble" );
    vh_vtol setmodel( "veh_t7_mil_vtol_nrc_no_interior_d" );
    level thread cp_prologue_util::function_2a0bc326( vh_vtol.origin, 0.6, 2, 5000, 6 );
    exploder::exploder( "light_exploder_vtol_tackle_fire" );
    wait 1;
    level thread cp_prologue_util::function_2a0bc326( vh_vtol.origin, 0.3, 2, 5000, 6 );
}

// Namespace vtol_tackle
// Params 0
// Checksum 0x2c19415c, Offset: 0x47f8
// Size: 0x162
function vtol_tackle_doors()
{
    level waittill( #"hash_ec873a98" );
    var_280d5f68 = getent( "intelstation_exit_door_l", "targetname" );
    var_3c301126 = getent( "intelstation_exit_door_r", "targetname" );
    v_move = ( 54, 0, 0 );
    v_door_destination = var_280d5f68.origin + v_move;
    var_280d5f68 moveto( v_door_destination, 0.5 );
    v_door_destination = var_3c301126.origin - v_move;
    var_3c301126 moveto( v_door_destination, 0.5 );
    var_3c301126 waittill( #"movedone" );
    var_3c301126 connectpaths();
    var_280d5f68 connectpaths();
    level notify( #"hash_147f8c7" );
}

// Namespace vtol_tackle
// Params 0
// Checksum 0xa0e73d1d, Offset: 0x4968
// Size: 0x2c
function function_321578a8()
{
    level waittill( #"hash_41679010" );
    level scene::play( "p7_fxanim_cp_prologue_vtol_tackle_windows_bundle" );
}

// Namespace vtol_tackle
// Params 0
// Checksum 0xdc0d2bc1, Offset: 0x49a0
// Size: 0x4c
function function_623731e2()
{
    level waittill( #"hash_13ea3fcf" );
    level thread namespace_21b2c1f2::function_f573bcb9();
    level dialog::remote( "tayr_easy_hold_your_fire_0", undefined, "normal" );
}

// Namespace vtol_tackle
// Params 0
// Checksum 0xe62d562c, Offset: 0x49f8
// Size: 0xe4
function hendricks_vtol_snark()
{
    level thread namespace_21b2c1f2::function_49fef8f4();
    level.ai_hendricks dialog::say( "hend_taylor_alpha_two_te_0", 2 );
    level.ai_hendricks dialog::say( "hend_comes_easy_now_hu_0", 1.5 );
    level.ai_prometheus dialog::say( "tayr_extract_is_the_satel_0", 0.5 );
    level.ai_hendricks dialog::say( "hend_you_didn_t_answer_me_0", 0.5 );
    level.ai_hyperion dialog::say( "mare_keep_up_secondary_r_0", 3 );
}

// Namespace vtol_tackle
// Params 0
// Checksum 0x4176c7c1, Offset: 0x4ae8
// Size: 0x88
function hendricks_vtol_tackle_path()
{
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    node = getnode( "hendricks_vtol_tackle_node2", "targetname" );
    self setgoal( node, 1 );
    self.goalradius = 500;
}

// Namespace vtol_tackle
// Params 1
// Checksum 0xa96365f1, Offset: 0x4b78
// Size: 0x54
function ai_setgoal( ai_node )
{
    node = getnode( ai_node, "targetname" );
    self setgoal( node, 1 );
}

// Namespace vtol_tackle
// Params 0
// Checksum 0xedfce9b8, Offset: 0x4bd8
// Size: 0xca
function dark_battle_cleanup()
{
    a_ai_db_guys = getaiarray( "dark_battle_guy", "targetname" );
    
    foreach ( ai_guy in a_ai_db_guys )
    {
        if ( isalive( ai_guy ) )
        {
            ai_guy kill();
        }
    }
}

// Namespace vtol_tackle
// Params 0
// Checksum 0x91e5947d, Offset: 0x4cb0
// Size: 0x3c
function enemies_killed_timeout()
{
    level spawner::waittill_ai_group_cleared( "vtol_tackle_enemies" );
    trigger::use( "robot_reveal_trig" );
}

// Namespace vtol_tackle
// Params 0
// Checksum 0xec57f130, Offset: 0x4cf8
// Size: 0x54
function function_236046c4()
{
    level endon( #"hash_51bc43cb" );
    self waittill( #"weapon_fired" );
    level flag::set( "vtol_guards_alerted" );
    self thread function_ecf2e565();
}

// Namespace vtol_tackle
// Params 0
// Checksum 0x602c0766, Offset: 0x4d58
// Size: 0x120
function function_ecf2e565()
{
    level endon( #"hash_51bc43cb" );
    veh_vtol = getent( "vtol", "animname" );
    
    while ( true )
    {
        if ( !isdefined( veh_vtol ) )
        {
            wait 0.5;
            continue;
        }
        
        var_30299a05 = ( randomintrange( -150, 150 ), randomintrange( -150, 150 ), randomintrange( -150, 150 ) );
        magicbullet( getweapon( "turret_bo3_mil_vtol_nrc" ), veh_vtol gettagorigin( "tag_gunner_barrel3" ) + ( 0, -40, 0 ), self.origin + var_30299a05 );
        wait 0.05;
    }
}

#namespace prologue_util;

// Namespace prologue_util
// Params 0
// Checksum 0x55e4f2bc, Offset: 0x4e80
// Size: 0x10
function remove_grenades()
{
    self.grenadeammo = 0;
}

