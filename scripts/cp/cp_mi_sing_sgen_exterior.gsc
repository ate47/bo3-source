#using scripts/codescripts/struct;
#using scripts/cp/_collectibles;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_quadtank_util;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cp_mi_sing_sgen_accolades;
#using scripts/cp/cp_mi_sing_sgen_enter_silo;
#using scripts/cp/cp_mi_sing_sgen_revenge_igc;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_mi_sing_sgen_exterior;

// Namespace cp_mi_sing_sgen_exterior
// Params 2
// Checksum 0xfae7b067, Offset: 0x1d10
// Size: 0x462
function skipto_intro_init( str_objective, b_starting )
{
    level scene::init( "cin_sgen_01_intro_3rd_pre200_overlook_sh010" );
    level scene::init( "cin_sgen_01_intro_3rd_pre100_flyover" );
    level clientfield::set( "w_flyover_buoys", 1 );
    load::function_c32ba481( 1 );
    
    foreach ( e_player in level.activeplayers )
    {
        e_player freezecontrols( 1 );
    }
    
    util::do_chyron_text( &"CP_MI_SING_SGEN_INTRO_LINE_2_FULL", &"CP_MI_SING_SGEN_INTRO_LINE_2_SHORT", &"CP_MI_SING_SGEN_INTRO_LINE_3_FULL", &"CP_MI_SING_SGEN_INTRO_LINE_3_SHORT", &"CP_MI_SING_SGEN_INTRO_LINE_4_FULL", &"CP_MI_SING_SGEN_INTRO_LINE_4_SHORT", &"CP_MI_SING_SGEN_INTRO_LINE_5_FULL", &"CP_MI_SING_SGEN_INTRO_LINE_5_SHORT", "", "" );
    level scene::add_scene_func( "cin_sgen_01_intro_3rd_pre200_overlook_sh010", &function_12570551 );
    level scene::add_scene_func( "cin_sgen_01_intro_3rd_pre200_overlook_sh020", &function_d97219ae, "play" );
    level scene::add_scene_func( "cin_sgen_01_intro_3rd_pre200_overlook_sh060", &function_149dd934, "play" );
    level scene::add_scene_func( "cin_sgen_01_intro_3rd_pre200_overlook_sh060", &intro_igc_complete, "done" );
    setdvar( "ai_awarenessenabled", 1 );
    level thread function_87664862();
    level thread spawn_qtank_encounter();
    level thread intro_technicals();
    exploder::exploder( "sgen_flying_IGC" );
    
    if ( isdefined( level.bzm_sgendialogue1callback ) )
    {
        level thread [[ level.bzm_sgendialogue1callback ]]();
    }
    
    level thread function_32c69f8a();
    level thread namespace_d40478f6::function_6cad5ce0();
    level scene::play( "cin_sgen_01_intro_3rd_pre100_flyover" );
    level clientfield::set( "w_flyover_buoys", 0 );
    
    if ( isdefined( level.bzm_sgendialogue1_1callback ) )
    {
        level thread [[ level.bzm_sgendialogue1_1callback ]]();
    }
    
    level thread scene::play( "cin_sgen_01_intro_3rd_pre200_overlook_sh010" );
    level thread sgen_entrance_54i();
    level flag::wait_till( "intro_igc_done" );
    level clientfield::set( "gameplay_started", 1 );
    util::teleport_players_igc( "intro" );
    
    foreach ( e_player in level.activeplayers )
    {
        e_player freezecontrols( 0 );
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x3d65b44c, Offset: 0x2180
// Size: 0x54
function function_32c69f8a()
{
    level waittill( #"fade_out" );
    level thread util::screen_fade_out( 2 );
    level waittill( #"fade_in" );
    level thread util::screen_fade_in( 3 );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0xc23bf262, Offset: 0x21e0
// Size: 0x64
function function_12570551( a_ents )
{
    a_ents[ "m_cinematic_hendricks" ] clientfield::set( "dni_eye", 1 );
    level waittill( #"hash_f39f25df" );
    level dialog::remote( "kane_much_of_the_structur_0" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0x6c6bd990, Offset: 0x2250
// Size: 0x64
function function_149dd934( a_ents )
{
    level.ai_hendricks = a_ents[ "hendricks_backpack" ];
    util::init_hero( "hendricks_backpack" );
    trigger::use( "enter_sgen_hendricks", "targetname", undefined, 1 );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0x208ae4e6, Offset: 0x22c0
// Size: 0xba
function function_d97219ae( a_ents )
{
    a_shadow_blockers = getentarray( "sgen_intro_igc_card", "targetname" );
    
    foreach ( blocker in a_shadow_blockers )
    {
        blocker delete();
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0x4615c50, Offset: 0x2388
// Size: 0x24
function intro_igc_complete( a_ents )
{
    skipto::objective_completed( "intro" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 4
// Checksum 0xfb77aaab, Offset: 0x23b8
// Size: 0x54
function skipto_intro_done( str_objective, b_starting, b_direct, player )
{
    struct::delete_script_bundle( "scene", "cin_sgen_01_intro_3rd_pre100_flyover" );
    cp_mi_sing_sgen_revenge_igc::function_a8e314e9();
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x19f6153c, Offset: 0x2418
// Size: 0x34
function function_87664862()
{
    flag::wait_till( "exterior_gone_hot" );
    setdvar( "ai_awarenessenabled", 0 );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 2
// Checksum 0xa9a4de38, Offset: 0x2458
// Size: 0x824
function function_d43e5685( str_objective, b_starting )
{
    if ( b_starting )
    {
        setdvar( "ai_awarenessenabled", 1 );
        level thread intro_technicals();
        level thread spawn_qtank_encounter();
        level thread function_d97219ae();
        exploder::exploder( "sgen_flying_IGC" );
        sgen::init_hendricks( str_objective );
        level thread sgen_entrance_54i();
        load::function_a2995f22();
    }
    
    util::clientnotify( "sw" );
    level thread namespace_d40478f6::function_973b77f9();
    sgen_accolades::function_6a1ab5fc();
    sgen_accolades::function_b2309b8();
    sgen_accolades::function_6a2780bc();
    
    foreach ( player in level.activeplayers )
    {
        player thread function_210baecb();
    }
    
    callback::on_spawned( &function_210baecb );
    var_f38271e7 = getent( "exterior_fountain_water", "targetname" );
    level thread trigger::no_prone_think( var_f38271e7 );
    vehicle::add_spawn_function( "intro_truck", &function_ceeb020 );
    trigger::use( "t_intro_truck" );
    objectives::set( "cp_level_sgen_enter_sgen_no_pointer" );
    a_outside_color_triggers = getentarray( "outside_color_triggers", "script_noteworthy" );
    
    foreach ( e_trig in a_outside_color_triggers )
    {
        e_trig.script_color_stay_on = 1;
    }
    
    a_trig_hendricks_stealth = getentarray( "trig_hendricks_stealth", "script_noteworthy" );
    
    foreach ( e_trig in a_trig_hendricks_stealth )
    {
        e_trig thread monitor_hendricks_color_notify();
    }
    
    level.ai_hendricks ai::set_ignoreall( 1 );
    level.ai_hendricks ai::set_ignoreme( 1 );
    level.ai_hendricks.b_have_assist_target = 0;
    level.ai_hendricks ai::set_behavior_attribute( "vignette_mode", "fast" );
    level.ai_hendricks.goalradius = 64;
    e_hendricks_weapon = getweapon( "ar_standard_hero", "suppressed", "acog", "fastreload", "extclip", "damage" );
    level.ai_hendricks ai::gun_switchto( e_hendricks_weapon, "right" );
    level thread function_a56f1c2e();
    t_door = getent( "trig_lobby_entrance", "targetname" );
    t_door triggerenable( 0 );
    level thread intro_obj_breadcrumb();
    
    foreach ( e_player in level.players )
    {
        e_player thread monitor_player_gunfire();
    }
    
    level flag::set( "start_technical" );
    level flag::wait_till( "start_enter_sgen" );
    savegame::checkpoint_save();
    level thread player_lobby_entrance();
    level thread stealth_vo();
    level.ai_hendricks thread qtank_fight_hendricks();
    level.vh_qtank thread qtank_spawn_and_fight();
    level.vh_qtank waittill( #"death" );
    level.vh_qtank disconnectpaths();
    level flag::set( "intro_quadtank_dead" );
    a_axis = getaiteamarray( "axis" );
    var_ce29d857 = getent( "exterior_retreat_killer", "targetname" );
    
    foreach ( e_ai in a_axis )
    {
        e_ai setgoal( var_ce29d857, 1 );
    }
    
    level flag::set( "qtank_fight_completed" );
    skipto::objective_completed( str_objective );
    objectives::complete( "cp_level_sgen_clear_entrance" );
    sgen_accolades::function_45afef12();
    sgen_accolades::function_59fa6593();
    sgen_accolades::function_6d2fd9d2();
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x5c59da95, Offset: 0x2c88
// Size: 0x176
function function_da046478()
{
    var_b640b7ec = getent( "exterior_quad_tank_retreat", "targetname" );
    a_ai_enemies = spawner::get_ai_group_ai( "exterior_guys" );
    a_ai_enemies = arraysort( a_ai_enemies, level.vh_qtank.origin, 0 );
    
    for ( i = 0; i < a_ai_enemies.size ; i++ )
    {
        if ( isai( a_ai_enemies[ i ] ) && a_ai_enemies[ i ].script_parameters !== "sniper" )
        {
            a_ai_enemies[ i ] notify( #"retreating" );
            a_ai_enemies[ i ] setgoal( var_b640b7ec, 1 );
            a_ai_enemies[ i ] thread sgen_util::wait_to_delete( 800 );
            wait randomfloatrange( 2, 5 );
        }
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x2572bd6, Offset: 0x2e08
// Size: 0xa6
function function_331e454()
{
    a_ai_snipers = getentarray( "sniper", "script_parameters" );
    
    for ( i = 0; i < a_ai_snipers.size ; i++ )
    {
        if ( isalive( a_ai_snipers[ i ] ) )
        {
            level.ai_hendricks ai::shoot_at_target( "kill_within_time", a_ai_snipers[ i ], undefined, 10 );
        }
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x1bad4a04, Offset: 0x2eb8
// Size: 0x4c
function function_a56f1c2e()
{
    wait 10;
    var_b9b7fda9 = getent( "intro_no_sight", "targetname" );
    var_b9b7fda9 delete();
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x885e2fed, Offset: 0x2f10
// Size: 0xdc
function function_ceeb020()
{
    self endon( #"death" );
    self vehicle::lights_off();
    self setseatoccupied( 0 );
    self.script_objective = "gen_lab";
    self waittill( #"reached_end_node" );
    level flag::set( "intro_truck_arrived" );
    array::thread_all( self.riders, &function_2a8b80c4 );
    level flag::wait_till( "exterior_gone_hot" );
    self vehicle::unload( "all" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xc83e3664, Offset: 0x2ff8
// Size: 0x84
function function_2a8b80c4()
{
    self endon( #"death" );
    level endon( #"exterior_gone_hot" );
    self ai::set_ignoreall( 0 );
    self util::waittill_any( "damage", "death", "bulletwhizby" );
    level flag::set( "exterior_gone_hot" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xdc7b82b5, Offset: 0x3088
// Size: 0x7e
function monitor_hendricks_color_notify()
{
    self endon( #"death" );
    level endon( #"start_hendricks_move_up_battle_1" );
    
    while ( true )
    {
        self waittill( #"trigger", e_player );
        
        if ( level.players.size == 1 )
        {
            trigger::use( self.script_string, "targetname", e_player );
            wait 1;
        }
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 4
// Checksum 0xd25848ba, Offset: 0x3110
// Size: 0x124
function function_91e8545f( str_objective, b_starting, b_direct, player )
{
    struct::delete_script_bundle( "scene", "cin_sgen_01_intro_3rd_pre200_overlook_sh020" );
    struct::delete_script_bundle( "scene", "cin_sgen_01_intro_3rd_pre200_overlook_sh020_female" );
    struct::delete_script_bundle( "scene", "cin_sgen_01_intro_3rd_pre200_overlook_sh030" );
    struct::delete_script_bundle( "scene", "cin_sgen_01_intro_3rd_pre200_overlook_sh030_female" );
    struct::delete_script_bundle( "scene", "cin_sgen_01_intro_3rd_pre200_overlook_sh040" );
    struct::delete_script_bundle( "scene", "cin_sgen_01_intro_3rd_pre200_overlook_sh050" );
    struct::delete_script_bundle( "scene", "cin_sgen_01_intro_3rd_pre200_overlook_sh060" );
    callback::remove_on_spawned( &function_210baecb );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xfb677f38, Offset: 0x3240
// Size: 0x15c
function stealth_vo()
{
    var_e561bbaf = 0;
    
    foreach ( player in level.activeplayers )
    {
        w_current_weapon = player getcurrentweapon();
        
        if ( weaponhasattachment( w_current_weapon, "suppressed" ) )
        {
            var_e561bbaf = 1;
        }
    }
    
    if ( !flag::get( "exterior_gone_hot" ) && var_e561bbaf )
    {
        level.ai_hendricks dialog::say( "hend_54i_crawling_all_ove_0" );
        wait 0.8;
    }
    
    if ( !flag::get( "exterior_gone_hot" ) )
    {
        level.ai_hendricks dialog::say( "hend_waiting_on_your_shot_0", 1 );
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x3f1ac2e2, Offset: 0x33a8
// Size: 0x5c
function intro_obj_breadcrumb()
{
    level thread objectives::breadcrumb( "trig_obj_1" );
    flag::wait_till( "exterior_gone_hot" );
    level thread objectives::breadcrumb( "obj_intro_breadcrumb_3" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 2
// Checksum 0x23f93c53, Offset: 0x3410
// Size: 0x34
function function_2c6d8ae0( str_endon, str_name )
{
    self endon( str_endon );
    level trigger::wait_till( str_name );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x1aefcd3d, Offset: 0x3450
// Size: 0x6a
function monitor_player_gunfire()
{
    self endon( #"death" );
    self thread monitor_exterior_gunfire();
    self thread function_cb09a77d();
    level flag::wait_till( "exterior_gone_hot" );
    level notify( #"stop_patrolling" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xf962020, Offset: 0x34c8
// Size: 0xb8
function monitor_exterior_gunfire()
{
    self endon( #"death" );
    level endon( #"exterior_gone_hot" );
    level endon( #"stop_patrolling" );
    w_current_weapon = self getcurrentweapon();
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        w_current_weapon = self getcurrentweapon();
        
        if ( !weaponhasattachment( w_current_weapon, "suppressed" ) )
        {
            level flag::set( "exterior_gone_hot" );
        }
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xf3bbcfb, Offset: 0x3588
// Size: 0x148
function function_cb09a77d()
{
    self endon( #"death" );
    level endon( #"exterior_gone_hot" );
    level endon( #"stop_patrolling" );
    var_83181ea9[ 0 ] = "gadget_active_camo";
    var_83181ea9[ 1 ] = "gadget_es_strike";
    
    while ( true )
    {
        self waittill( #"cybercom_activation_succeeded", var_db4f7ce4 );
        b_safe = 0;
        
        foreach ( var_86ce8156 in var_83181ea9 )
        {
            if ( issubstr( var_db4f7ce4.name, var_86ce8156 ) )
            {
                b_safe = 1;
            }
        }
        
        if ( !b_safe )
        {
            level flag::set( "exterior_gone_hot" );
        }
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x156d87a, Offset: 0x36d8
// Size: 0x174
function force_exit_exterior_stealth()
{
    level endon( #"exterior_gone_hot" );
    level.n_dead_bodies = 0;
    
    while ( true )
    {
        if ( level.n_dead_bodies >= 8 )
        {
            break;
        }
        
        wait 1;
    }
    
    wait 0.5;
    a_dead_bodies = getcorpsearray();
    e_closest_corpse = arraygetclosest( level.players[ 0 ].origin, a_dead_bodies );
    e_closest_corpse_pos = util::spawn_model( "tag_origin", e_closest_corpse.origin, e_closest_corpse.angles );
    a_ai_enemies = getaiteamarray( "axis" );
    ai_closest_enemy_to_corpse = arraygetclosest( e_closest_corpse.origin, a_ai_enemies );
    
    if ( isalive( ai_closest_enemy_to_corpse ) )
    {
        ai_closest_enemy_to_corpse thread responder_run_to_corpse( e_closest_corpse_pos );
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0x3c207432, Offset: 0x3858
// Size: 0x94
function responder_run_to_corpse( e_search_pos )
{
    self endon( #"death" );
    self notify( #"stop_patrolling" );
    self.should_stop_patrolling = 0;
    self ai::set_behavior_attribute( "sprint", 1 );
    self ai::force_goal( e_search_pos.origin, 64, 1 );
    level flag::set( "exterior_gone_hot" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x7a21314b, Offset: 0x38f8
// Size: 0x74
function enable_battle_volumes()
{
    level flag::wait_till( "enable_battle_volumes" );
    a_vol_enemy_reaction = getentarray( "vol_enemy_reaction", "script_noteworthy" );
    array::run_all( a_vol_enemy_reaction, &delete );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x256836df, Offset: 0x3978
// Size: 0x2c4
function sgen_entrance_54i()
{
    level thread enable_battle_volumes();
    level thread force_exit_exterior_stealth();
    spawner::add_spawn_function_group( "exterior_guys", "script_aigroup", &setup_exterior_guy );
    spawner::add_spawn_function_group( "quadtank_reinforcement_guy", "targetname", &setup_quadtank_reinforcement_guy );
    spawner::simple_spawn( "enemy_enter_sgen" );
    spawner::simple_spawn( "exterior_patroller" );
    level thread scene::init( "cin_gen_breakout_vign_orders" );
    level battlechatter::function_d9f49fba( 0 );
    level flag::wait_till( "exterior_gone_hot" );
    level thread scene::play( "cin_gen_breakout_vign_orders" );
    level battlechatter::function_d9f49fba( 1 );
    level flag::set( "start_enter_sgen" );
    a_t_color = getentarray( "color_enter_sgen", "script_noteworthy" );
    array::run_all( a_t_color, &delete );
    spawner::waittill_ai_group_amount_killed( "exterior_guys", 8 );
    level flag::set( "start_hendricks_move_up_battle_1" );
    spawner::waittill_ai_group_amount_killed( "exterior_guys", 12 );
    level flag::set( "start_hendricks_move_up_battle_2" );
    spawner::waittill_ai_group_amount_killed( "exterior_guys", 18 );
    level flag::set( "spawn_quad_tank" );
    spawner::waittill_ai_group_amount_killed( "exterior_guys", 25 );
    level flag::set( "fallback_to_qt" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xaee88fe, Offset: 0x3c48
// Size: 0x352
function setup_quadtank_reinforcement_guy()
{
    self endon( #"death" );
    self endon( #"retreating" );
    e_vol_enemy_end = getent( "vol_enemy_end", "targetname" );
    self setgoal( e_vol_enemy_end, 1 );
    level waittill( #"enemies_react" );
    wait randomfloatrange( 1, 3 );
    self cleargoalvolume();
    a_nd_attack_quadtank = getnodearray( "nd_attack_quadtank", "targetname" );
    
    foreach ( nd_attack in a_nd_attack_quadtank )
    {
        self thread ai::force_goal( nd_attack, 32, 1 );
    }
    
    foreach ( e_player in level.players )
    {
        self setignoreent( e_player, 1 );
    }
    
    self setignoreent( level.ai_hendricks, 1 );
    self thread monitor_player_damage();
    wait randomfloatrange( 8, 11 );
    self setignoreent( level.ai_hendricks, 0 );
    e_vol_enemy_end = getent( "vol_enemy_end", "targetname" );
    self setgoal( e_vol_enemy_end, 1 );
    wait randomfloatrange( 3, 5 );
    self notify( #"end_damage_monitor" );
    
    foreach ( e_player in level.players )
    {
        self setignoreent( e_player, 0 );
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xab0e248b, Offset: 0x3fa8
// Size: 0xcc
function monitor_player_damage()
{
    self endon( #"end_damage_monitor" );
    self waittill( #"damage" );
    
    foreach ( e_player in level.players )
    {
        self setignoreent( e_player, 0 );
    }
    
    self setignoreent( level.ai_hendricks, 0 );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x677d9072, Offset: 0x4080
// Size: 0x5a4
function setup_exterior_guy()
{
    self endon( #"death" );
    self endon( #"corpse_responding" );
    self thread monitor_enemy_death_count();
    self thread sndfakeradios();
    self.cybercomtargetstatusoverride = 1;
    self thread setup_ai_for_stealth();
    level flag::wait_till( "start_technical" );
    
    if ( isdefined( self.script_string ) )
    {
        nd_start_node = get_patrol_path_node();
        self thread patrol_exterior_path( nd_start_node );
    }
    
    if ( isdefined( self.script_noteworthy ) )
    {
        scene::add_scene_func( "cin_sgen_02_05_exterior_vign_using_ipad_guy01", &monitor_tablet_drop, "play" );
        
        if ( isdefined( self.script_int ) )
        {
            self thread scene::init( self.script_noteworthy, self );
        }
        else
        {
            self thread scene::play( self.script_noteworthy, self );
        }
    }
    
    level flag::wait_till( "exterior_gone_hot" );
    revert_back_to_default();
    
    if ( self.b_ignore_goal_volumes === 1 )
    {
        level flag::wait_till( "start_hendricks_move_up_battle_2" );
    }
    
    if ( isdefined( self.str_attack_node ) )
    {
        nd_attack_node = getnode( self.str_attack_node, "targetname" );
        self ai::force_goal( nd_attack_node.origin, 32, 1 );
        level waittill( #"forever" );
    }
    
    a_vol_enemy_reaction = getentarray( "vol_enemy_reaction", "script_noteworthy" );
    
    foreach ( e_vol in a_vol_enemy_reaction )
    {
        if ( self istouching( e_vol ) )
        {
            e_enemy_reaction_vol = getent( e_vol.targetname, "targetname" );
            self setgoal( e_enemy_reaction_vol, 1 );
            continue;
        }
        
        a_vol_hendricks_stealth = getentarray( "vol_hendricks_stealth", "targetname" );
        
        foreach ( e_vol in a_vol_hendricks_stealth )
        {
            if ( self istouching( e_vol ) )
            {
                self setgoal( e_vol, 1 );
            }
        }
    }
    
    wait randomfloatrange( 10, 12 );
    self cleargoalvolume();
    level flag::set( "enable_battle_volumes" );
    e_goal_vol = getent( "vol_exterior_area", "targetname" );
    self setgoal( e_goal_vol, 1 );
    level flag::wait_till( "start_hendricks_move_up_battle_1" );
    self cleargoalvolume();
    e_vol_enemy_middle = getent( "vol_enemy_middle", "targetname" );
    self setgoal( e_vol_enemy_middle, 1 );
    level flag::wait_till( "start_hendricks_move_up_battle_2" );
    self cleargoalvolume();
    e_vol_enemy_end = getent( "vol_enemy_end", "targetname" );
    self setgoal( e_vol_enemy_end, 1 );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xa4cbdeb2, Offset: 0x4630
// Size: 0x60
function sndfakeradios()
{
    self endon( #"death" );
    level endon( #"exterior_gone_hot" );
    
    while ( true )
    {
        wait randomintrange( 5, 15 );
        self playsound( "amb_enemy_fake_radio" );
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0x5e4f6db7, Offset: 0x4698
// Size: 0xe4
function monitor_tablet_drop( a_scene_ents )
{
    mdl_tablet = a_scene_ents[ "tablet" ];
    ai_guy = a_scene_ents[ "guy" ];
    mdl_tablet endon( #"death" );
    mdl_tablet thread monitor_tablet_damage();
    level util::waittill_any_ents( level, "exterior_gone_hot", ai_guy, "damage", ai_guy, "death" );
    ai_guy scene::stop();
    wait 0.05;
    mdl_tablet physicslaunch( mdl_tablet.origin, ( 0, 0, -1 ) );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x35f357ff, Offset: 0x4788
// Size: 0x4c
function monitor_tablet_damage()
{
    level endon( #"exterior_gone_hot" );
    self setcandamage( 1 );
    self waittill( #"damage" );
    level flag::set( "exterior_gone_hot" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x784788e8, Offset: 0x47e0
// Size: 0x114
function setup_ai_for_stealth()
{
    self endon( #"death" );
    level endon( #"exterior_gone_hot" );
    self thread check_for_alert();
    self.goalradius = 32;
    self.old_maxsightdistsqrd = self.maxsightdistsqrd;
    self.maxsightdistsqrd = 562500;
    self.fovcosine = 0.8;
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        self ai::set_pacifist( 1 );
    }
    
    self util::waittill_any( "damage", "bulletwhizby" );
    self thread revert_back_to_default( 1 );
    wait 1;
    
    if ( isalive( self ) )
    {
        level flag::set( "exterior_gone_hot" );
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0x127d662b, Offset: 0x4900
// Size: 0x11c
function revert_back_to_default( b_immediate )
{
    if ( !isdefined( b_immediate ) )
    {
        b_immediate = 0;
    }
    
    self endon( #"death" );
    self.goalradius = 2048;
    self.maxsightdistsqrd = self.old_maxsightdistsqrd;
    self.fovcosine = 0;
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        self ai::set_pacifist( 0 );
    }
    
    self.should_stop_patrolling = 1;
    
    if ( isdefined( self.script_noteworthy ) )
    {
        wait randomfloatrange( 0.3, 1.5 );
        
        if ( issubstr( self.script_noteworthy, "rummage" ) )
        {
            self thread scene::play( self.script_noteworthy + "_react", self );
            return;
        }
        
        sgen_util::scene_stop_if_active( self.script_noteworthy );
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xad88d046, Offset: 0x4a28
// Size: 0x22c
function get_patrol_path_node()
{
    switch ( self.script_string )
    {
        case "nd_cargo_truck_driver":
            self.str_flag_wait = "start_vehicle_patrols";
            self vehicle::get_in( level.e_intro_cargo_truck, "driver", 1 );
            break;
        case "nd_cargo_truck_passenger":
            self.str_flag_wait = "start_vehicle_patrols";
            self vehicle::get_in( level.e_intro_cargo_truck, "passenger1", 1 );
            break;
        case "nd_left_walkway":
            self.str_attack_node = "nd_left_walkway_attack";
            break;
        default:
            self.str_attack_node = "nd_right_walkway_attack";
            break;
        case "nd_big_rig":
            self.str_attack_node = "nd_bigrig_attack";
            break;
        case "nd_patrol_right_truck_driver":
            self.str_flag_wait = "start_vehicle_patrols";
            self vehicle::get_in( level.e_technical_fountain_right, "driver", 1 );
            break;
        case "nd_right_driveway_path":
            self.n_wait = 1.2;
            self thread exterior_battle_stealth_assist();
            break;
        case "nd_right_intro_shack":
            self thread exterior_battle_stealth_assist();
            break;
        case "nd_left_driveway_path":
            self.n_wait = 3;
            self thread exterior_battle_stealth_assist();
            break;
        case "nd_left_building_enemy_path":
            self.str_flag_wait = "trig_left_exterior_building";
            self.b_ignore_goal_volumes = 1;
            self thread exterior_battle_stealth_assist();
            break;
    }
    
    nd_start_path = getnode( self.script_string, "targetname" );
    return nd_start_path;
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x4323c261, Offset: 0x4c60
// Size: 0x64
function monitor_enemy_death_count()
{
    level endon( #"exterior_gone_hot" );
    self waittill( #"death" );
    level.n_dead_bodies++;
    
    if ( self.script_string === "left_building_enemy" )
    {
        if ( level.players.size == 1 )
        {
            trigger::use( "trig_color_left_exterior_building_upstairs" );
        }
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x2df52aca, Offset: 0x4cd0
// Size: 0x14c
function exterior_battle_stealth_assist()
{
    level endon( #"exterior_gone_hot" );
    self endon( #"assisted_kill" );
    self endon( #"stop_assisted_kill" );
    self.b_assisted_kill_guy = 1;
    self waittill( #"death", e_attacker );
    
    if ( isplayer( e_attacker ) & !level flag::get( "exterior_gone_hot" ) )
    {
        ai_close = arraygetclosest( self.origin, getaiteamarray( "axis" ), 512 );
        
        if ( isalive( ai_close ) )
        {
            if ( ai_close cansee( e_attacker ) || ai_close cansee( self ) )
            {
                ai_close thread function_4e452acd( self.origin );
                ai_close thread function_94a23f13( e_attacker );
            }
        }
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0x5010cd8f, Offset: 0x4e28
// Size: 0x1cc
function function_4e452acd( v_death_origin )
{
    self endon( #"death" );
    wait randomfloatrange( 0.4, 0.8 );
    
    if ( !level.ai_hendricks.b_have_assist_target )
    {
        if ( self.b_assisted_kill_guy === 1 )
        {
            if ( level.players.size == 1 && !util::within_fov( level.ai_hendricks.origin, level.players[ 0 ].angles, level.players[ 0 ].origin, cos( 70 ) ) )
            {
                level.ai_hendricks.b_have_assist_target = 1;
                vec_directiontohendricks = vectornormalize( level.ai_hendricks geteye() - self geteye() );
                vec_bulletstartorigin = self geteye() + vectorscale( vec_directiontohendricks, 300 );
                vec_bulletendorigin = self geteye();
                magicbullet( level.ai_hendricks.weapon, vec_bulletstartorigin, vec_bulletendorigin, level.ai_hendricks );
                self kill( vec_bulletstartorigin, level.ai_hendricks );
            }
        }
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0x6562d4a0, Offset: 0x5000
// Size: 0x15c
function function_94a23f13( player )
{
    self endon( #"death" );
    level endon( #"exterior_gone_hot" );
    self notify( #"stealth_assist_alerted" );
    
    if ( isdefined( player ) && distancesquared( self.origin, player.origin ) > 40000 )
    {
        if ( !level flag::get( "enemy_alerting_area" ) )
        {
            if ( !sessionmodeiscampaignzombiesgame() )
            {
                level flag::set( "enemy_alerting_area" );
                level util::delay( 3, undefined, &flag::clear, "enemy_alerting_area" );
                self scene::play( "cin_sgen_02_01_alerting_scene", self );
            }
        }
    }
    else
    {
        self thread revert_back_to_default( 1 );
        wait 1;
    }
    
    level flag::set( "exterior_gone_hot" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0x326d4553, Offset: 0x5168
// Size: 0x9c
function patrol_exterior_path( nd_start_path )
{
    self endon( #"death" );
    level endon( #"exterior_gone_hot" );
    
    if ( isdefined( self.str_flag_wait ) && !level flag::get( "exterior_gone_hot" ) )
    {
        level flag::wait_till( self.str_flag_wait );
    }
    
    if ( isdefined( self.n_wait ) )
    {
        wait self.n_wait;
    }
    
    self thread ai::patrol( nd_start_path );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x612fe93c, Offset: 0x5210
// Size: 0x214
function intro_technicals()
{
    level.w_quadtank_player_weapon = getweapon( "quadtank_main_turret_player" );
    level.w_quadtank_mlrs_weapon = getweapon( "quadtank_main_turret_rocketpods_straight" );
    level.w_quadtank_mlrs_weapon2 = getweapon( "quadtank_main_turret_rocketpods_javelin" );
    level.e_technical_fountain_right = vehicle::simple_spawn_single( "technical_fountain_right" );
    level.e_technical_fountain_right vehicle::lights_off();
    level.e_technical_fountain_right setseatoccupied( 0 );
    level.e_technical_fountain_right thread exterior_vehicle_damagefunc();
    e_technical_fountain_left = vehicle::simple_spawn_single( "technical_fountain_left" );
    e_technical_fountain_left vehicle::lights_off();
    e_technical_fountain_left setseatoccupied( 0 );
    e_technical_fountain_left thread truck_gunner_replace( level.players.size, 2.5, "start_hendricks_move_up_battle_2" );
    e_technical_fountain_left thread exterior_vehicle_damagefunc();
    level.e_intro_cargo_truck = vehicle::simple_spawn_single( "intro_cargo_truck" );
    level.e_intro_cargo_truck vehicle::lights_off();
    level.e_intro_cargo_truck thread exterior_vehicle_damagefunc();
    level flag::wait_till( "exterior_gone_hot" );
    level.e_technical_fountain_right vehicle::unload( "all" );
    level.e_intro_cargo_truck vehicle::unload( "all" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0xe3fefea2, Offset: 0x5430
// Size: 0x94
function intro_truck_path( str_start_node )
{
    self setcandamage( 0 );
    self playsound( "evt_sgen_technical_drive" );
    self thread vehicle::get_on_and_go_path( str_start_node );
    self waittill( #"reached_end_node" );
    self disconnectpaths();
    self setcandamage( 1 );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x6c0f7475, Offset: 0x54d0
// Size: 0x16c
function spawn_qtank_encounter()
{
    level.vh_qtank = spawner::simple_spawn_single( "entrance_qtank" );
    level.vh_qtank ai::set_ignoreme( 1 );
    level.vh_qtank ai::set_ignoreall( 1 );
    level.vh_qtank disableaimassist();
    level.vh_qtank notsolid();
    level.vh_qtank oed::disable_thermal();
    level.vh_qtank clientfield::set( "quad_tank_tac_mode", 1 );
    level.vh_qtank util::set_rogue_controlled();
    level.vh_qtank quadtank::quadtank_weakpoint_display( 0 );
    
    if ( level.players.size == 1 )
    {
        level.vh_qtank.health = 2500;
    }
    
    level thread scene::init( "cin_sgen_03_01_qt_attack_vign_reveal_qt01" );
    level thread scene::init( "p7_fxanim_cp_sgen_quadtank_reveal_debris_bundle" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x7e4b7e22, Offset: 0x5648
// Size: 0x86c
function qtank_fight_hendricks()
{
    level flag::wait_till( "exterior_gone_hot" );
    e_hendricks_weapon = getweapon( "ar_standard_hero", "acog", "fastreload", "extclip", "damage" );
    level.ai_hendricks ai::gun_switchto( e_hendricks_weapon, "right" );
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_hendricks ai::set_ignoreme( 0 );
    level.ai_hendricks.goalradius = 2048;
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 0 );
    level.ai_hendricks ai::set_behavior_attribute( "sprint", 1 );
    level.ai_hendricks ai::set_behavior_attribute( "vignette_mode", "off" );
    
    if ( !level flag::get( "hendricks_on_hill" ) )
    {
        trigger::use( "trig_color_security_exterior" );
    }
    
    a_vol_hendricks_stealth = getentarray( "vol_hendricks_stealth", "targetname" );
    
    while ( !level flag::get( "start_hendricks_move_up_battle_1" ) )
    {
        foreach ( e_vol in a_vol_hendricks_stealth )
        {
            if ( isdefined( e_vol ) )
            {
                if ( level.ai_hendricks istouching( e_vol ) && e_vol.b_hendricks_in_vol === 1 )
                {
                    e_vol.b_hendricks_in_vol = 1;
                    level.ai_hendricks.e_current_vol = getent( e_vol.script_noteworthy, "targetname" );
                    level.ai_hendricks setgoal( level.ai_hendricks.e_current_vol, 1 );
                    
                    if ( !level.ai_hendricks istouching( level.ai_hendricks.e_current_vol ) )
                    {
                        wait 1;
                    }
                    
                    e_vol.b_hendricks_in_vol = 0;
                }
            }
        }
        
        wait 5;
    }
    
    level.ai_hendricks cleargoalvolume();
    
    foreach ( e_vol in a_vol_hendricks_stealth )
    {
        if ( isdefined( e_vol ) )
        {
            if ( level.ai_hendricks istouching( e_vol ) )
            {
                switch ( e_vol.script_noteworthy )
                {
                    case "vol_security_room":
                        level.b_hendricks_right_path = 1;
                        trig_color_stop_1 = getent( "trig_color_move_security_1", "targetname" );
                        trig_color_stop_2 = getent( "trig_color_move_security_2", "targetname" );
                        trig_color_stop_3 = getent( "trig_color_move_security_3", "targetname" );
                        break;
                    case "vol_driveway":
                        level.b_hendricks_right_path = 0;
                        trig_color_stop_1 = getent( "trig_color_move_middle_1", "targetname" );
                        trig_color_stop_2 = getent( "trig_color_move_middle_2", "targetname" );
                        trig_color_stop_3 = getent( "trig_color_move_middle_3", "targetname" );
                        break;
                    case "vol_left_building_exterior":
                        level.b_hendricks_right_path = 0;
                        trig_color_stop_1 = getent( "trig_color_left_building_1", "targetname" );
                        trig_color_stop_2 = getent( "trig_color_left_building_2", "targetname" );
                        trig_color_stop_3 = getent( "trig_color_move_middle_3", "targetname" );
                        break;
                    case "vol_left_building":
                        level.b_hendricks_right_path = 0;
                        trig_color_stop_1 = getent( "trig_color_left_building_1", "targetname" );
                        trig_color_stop_2 = getent( "trig_color_left_building_2", "targetname" );
                        trig_color_stop_3 = getent( "trig_color_move_middle_3", "targetname" );
                        break;
                    default:
                        level.b_hendricks_right_path = 0;
                        trig_color_stop_1 = getent( "trig_color_move_middle_1", "targetname" );
                        trig_color_stop_2 = getent( "trig_color_move_middle_2", "targetname" );
                        trig_color_stop_3 = getent( "trig_color_move_middle_3", "targetname" );
                        break;
                }
            }
        }
    }
    
    if ( !isdefined( trig_color_stop_1 ) )
    {
        trig_color_stop_1 = getent( "trig_color_move_middle_1", "targetname" );
    }
    
    if ( !isdefined( trig_color_stop_2 ) )
    {
        trig_color_stop_2 = getent( "trig_color_move_middle_2", "targetname" );
    }
    
    if ( !isdefined( trig_color_stop_3 ) )
    {
        trig_color_stop_3 = getent( "trig_color_move_middle_3", "targetname" );
    }
    
    trigger::use( trig_color_stop_1.targetname );
    level flag::wait_till( "start_hendricks_move_up_battle_2" );
    trigger::use( trig_color_stop_2.targetname );
    level flag::wait_till( "spawn_quad_tank" );
    var_3cfcee01 = getent( "vol_enemy_middle", "targetname" );
    level.ai_hendricks setgoal( var_3cfcee01 );
    level flag::wait_till( "qtank_fight_completed" );
    battlechatter::function_d9f49fba( 0 );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x515e3852, Offset: 0x5ec0
// Size: 0x3a4
function qtank_spawn_and_fight()
{
    level flag::wait_till( "activate_quad_tank" );
    level thread function_da046478();
    level thread function_331e454();
    spawner::simple_spawn( "quadtank_reinforcement_guy" );
    level thread namespace_d40478f6::function_3440789f();
    trigger::use( "obj_intro_breadcrumb_3" );
    util::delay( 4, undefined, &objectives::set, "cp_level_sgen_clear_entrance", level.vh_qtank );
    level.vh_qtank ai::set_ignoreme( 0 );
    level.vh_qtank ai::set_ignoreall( 0 );
    level.vh_qtank enableaimassist();
    level.vh_qtank solid();
    level.vh_qtank oed::enable_thermal();
    level.vh_qtank clientfield::set( "quad_tank_tac_mode", 0 );
    level.vh_qtank.team = "team3";
    var_3bc3122a = getent( "qt_intro_target", "targetname" );
    level.vh_qtank ai::shoot_at_target( "shoot_until_target_dead", var_3bc3122a );
    level.vh_qtank thread function_f2daaec0();
    level.vh_qtank thread quadtank_fight_vo();
    level util::delay( 2, undefined, &flag::set, "exterior_gone_hot" );
    
    if ( isdefined( level.bzm_sgendialogue1_2callback ) )
    {
        level thread [[ level.bzm_sgendialogue1_2callback ]]();
    }
    
    level thread scene::play( "p7_fxanim_cp_sgen_quadtank_reveal_debris_bundle" );
    level scene::add_scene_func( "cin_sgen_03_01_qt_attack_vign_reveal_qt01", &function_dce4d116 );
    level scene::play( "cin_sgen_03_01_qt_attack_vign_reveal_qt01" );
    savegame::checkpoint_save();
    level.vh_qtank quadtank::quadtank_weakpoint_display( 1 );
    level.vh_qtank.goalradius = 512;
    level.vh_qtank setneargoalnotifydist( 128 );
    level.vh_qtank thread quadtank_movement_think();
    level flag::wait_till( "intro_quadtank_dead" );
    level thread namespace_d40478f6::function_973b77f9();
    level flag::wait_till_clear( "quad_tank_nag_vo_playing" );
    level thread dialog::remote( "kane_core_destabilized_q_0", 1 );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0x720691e, Offset: 0x6270
// Size: 0x34
function function_dce4d116( a_ents )
{
    level.vh_qtank waittill( #"turn_on" );
    level.vh_qtank quadtank::quadtank_on();
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xb94c3c9e, Offset: 0x62b0
// Size: 0x3e4
function quadtank_fight_vo()
{
    self endon( #"death" );
    a_str_trophy_active = [];
    a_str_trophy_active[ 0 ] = "kane_keep_hammering_its_t_1";
    a_str_trophy_active[ 1 ] = "hend_what_are_you_waiting_2";
    a_str_trophy_active[ 2 ] = "hend_trophy_system_s_mark_0";
    a_str_trophy_active[ 3 ] = "hend_ain_t_gonna_do_damag_0";
    a_str_trophy_active[ 4 ] = "kane_keep_firing_on_its_t_0";
    a_str_trophy_down = [];
    a_str_trophy_down[ 0 ] = "kane_trophy_system_offlin_0";
    a_str_trophy_down[ 1 ] = "kane_quad_defense_disable_0";
    a_str_trophy_down[ 2 ] = "hend_c_mon_hit_it_the_rp_0";
    a_str_trophy_down[ 3 ] = "kane_use_an_rpg_or_a_gren_0";
    a_str_trophy_down[ 4 ] = "hend_only_a_few_more_shot_0";
    a_str_trophy_down[ 5 ] = "hend_hurry_up_use_your_r_0";
    a_str_trophy_down[ 6 ] = "hend_an_rpg_will_weaken_i_0";
    a_str_direct_hit = [];
    a_str_direct_hit[ 0 ] = "kane_clean_hit_0";
    a_str_direct_hit[ 1 ] = "hend_good_shot_that_ba_0";
    a_str_direct_hit[ 2 ] = "kane_one_more_direct_hit_0";
    a_str_direct_hit[ 3 ] = "kane_direct_hit_few_more_0";
    a_str_direct_hit[ 4 ] = "hend_it_s_weakening_0";
    a_str_bullet_vo = [];
    a_str_bullet_vo[ 0 ] = "hend_hit_its_defensive_sy_0";
    a_str_bullet_vo[ 1 ] = "kane_keep_hammering_its_t_0";
    a_str_bullet_vo[ 2 ] = "hend_we_re_shooting_blank_0";
    a_str_trophy_destroyed = [];
    a_str_trophy_destroyed[ 0 ] = "kane_trophy_system_offlin_1";
    a_str_trophy_destroyed[ 1 ] = "hend_this_is_it_hit_it_w_0";
    a_str_trophy_destroyed[ 2 ] = "hend_c_mon_shoot_that_f_0";
    callback::on_vehicle_damage( &monitor_quadtank_health, self );
    level dialog::remote( "kane_find_cover_quad_un_0", 1 );
    level.ai_hendricks dialog::say( "hend_that_bastard_should_0", 1.5 );
    level dialog::remote( "kane_quad_tanks_have_a_tr_0", 2 );
    level dialog::remote( "kane_hit_the_quad_s_troph_0", 0.5 );
    self thread function_749f2173();
    self thread function_624e7d89();
    self thread quadtank_util::function_35209d64();
    self thread function_91175921( "vo_trophy_system_destroyed", a_str_trophy_destroyed, 5 );
    self thread function_91175921( "vo_trophy_system_disabled", a_str_trophy_down, 10, "quad_tank_trophy_system_destroyed" );
    self thread function_91175921( "vo_trophy_system_enabled", a_str_trophy_active, 10, "quad_tank_trophy_system_destroyed" );
    self thread function_91175921( "vo_direct_hit", a_str_direct_hit );
    self thread function_91175921( "vo_bullet_damage", a_str_bullet_vo, 30 );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xb3f0c19f, Offset: 0x66a0
// Size: 0x78
function function_624e7d89()
{
    self endon( #"death" );
    self waittill( #"trophy_system_destroyed" );
    level flag::set( "quad_tank_trophy_system_destroyed" );
    
    while ( true )
    {
        level notify( #"vo_trophy_system_destroyed" );
        wait randomfloatrange( 10, 15 );
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x7d85a368, Offset: 0x6720
// Size: 0x5e
function function_749f2173()
{
    self endon( #"death" );
    self endon( #"trophy_system_destroyed" );
    
    while ( true )
    {
        self waittill( #"trophy_system_disabled" );
        level notify( #"vo_trophy_system_disabled" );
        self waittill( #"trophy_system_enabled" );
        level notify( #"vo_trophy_system_enabled" );
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 4
// Checksum 0x354d43ff, Offset: 0x6788
// Size: 0x252
function function_91175921( str_notify, a_str_vo, n_cooldown, str_endon_flag )
{
    self endon( #"death" );
    
    foreach ( str_vo in a_str_vo )
    {
        if ( level flag::get( "intro_quadtank_dead" ) )
        {
            return;
        }
        
        if ( isdefined( str_endon_flag ) && level flag::get( str_endon_flag ) )
        {
            return;
        }
        
        level waittill( str_notify );
        
        if ( level flag::get( "quad_tank_nag_vo_playing" ) )
        {
            str_msg = level util::waittill_any_timeout( 5, "quad_tank_nag_vo_playing", "intro_quadtank_dead" );
            
            if ( str_msg == "timeout" || str_msg == "intro_quadtank_dead" )
            {
                continue;
            }
        }
        
        level flag::set( "quad_tank_nag_vo_playing" );
        
        if ( strstartswith( str_vo, "hend" ) )
        {
            level.ai_hendricks dialog::say( str_vo );
        }
        else
        {
            level thread dialog::remote( str_vo );
            level waittill( #"hash_120cde7f", var_c8ee7e7d );
            var_c8ee7e7d waittillmatch( #"done speaking", str_vo );
        }
        
        wait 1;
        level flag::clear( "quad_tank_nag_vo_playing" );
        
        if ( isdefined( n_cooldown ) )
        {
            wait n_cooldown;
        }
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 2
// Checksum 0x317e7367, Offset: 0x69e8
// Size: 0xfe
function monitor_quadtank_health( obj, params )
{
    if ( isplayer( params.eattacker ) )
    {
        if ( params.smeansofdeath === "MOD_RIFLE_BULLET" )
        {
            if ( params.partname != "tag_target_lower" && params.partname != "tag_target_upper" && params.partname != "tag_defense_active" && params.partname != "tag_body_animate" )
            {
                level notify( #"vo_bullet_damage" );
            }
        }
        
        if ( params.weapon.name === "launcher_standard" )
        {
            level notify( #"vo_direct_hit" );
        }
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x9e300b5c, Offset: 0x6af0
// Size: 0x1c8
function quadtank_movement_think()
{
    self endon( #"death" );
    a_quadtank_positions = struct::get_array( "quadtank_positions", "script_noteworthy" );
    s_next_pos = array::random( a_quadtank_positions );
    
    while ( true )
    {
        if ( s_next_pos == s_next_pos )
        {
            s_next_pos = array::random( a_quadtank_positions );
        }
        
        self setgoal( s_next_pos.origin, 1 );
        self util::waittill_either( "near_goal", "goal" );
        
        if ( s_next_pos.script_string === "qt_pos_back" )
        {
            if ( level.b_hendricks_right_path === 1 )
            {
                trigger::use( "trig_color_qt_right_fallback" );
            }
            else
            {
                trigger::use( "trig_color_qt_left_fallback" );
            }
        }
        
        if ( s_next_pos.script_string === "qt_pos_back" )
        {
            if ( level.b_hendricks_right_path === 1 )
            {
                trigger::use( "trig_color_qt_right_push" );
            }
            else
            {
                trigger::use( "trig_color_qt_left_push" );
            }
        }
        
        wait randomfloatrange( 6, 9 );
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xc5b15ec9, Offset: 0x6cc0
// Size: 0x21a
function function_f2daaec0()
{
    scene::add_scene_func( "p7_fxanim_cp_sgen_truck_flip_crates_bundle", &function_78ca0a7d );
    self waittill( #"fire" );
    wait 0.2;
    level thread scene::play( "p7_fxanim_cp_sgen_truck_flip_crates_bundle" );
    s_qtank_impact = struct::get( "qtank_impact", "targetname" );
    radiusdamage( s_qtank_impact.origin, 180, 500, 90, self );
    a_nodes = getnodearray( "qt_truck_nodes", "script_noteworthy" );
    
    foreach ( nd_node in a_nodes )
    {
        setenablenode( nd_node, 0 );
    }
    
    a_pickup_carver = getentarray( "pickup_carver", "targetname" );
    
    foreach ( e_ent in a_pickup_carver )
    {
        e_ent delete();
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0x71683fb, Offset: 0x6ee8
// Size: 0x44
function function_78ca0a7d( a_ents )
{
    level waittill( #"hash_8d9c68d3" );
    a_ents[ "truck_flip" ] setmodel( "veh_t7_civ_truck_pickup_yell_dead_not_flat" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xde7f270e, Offset: 0x6f38
// Size: 0x16c
function player_lobby_entrance()
{
    level flag::wait_till( "qtank_fight_completed" );
    level flag::clear( "player_at_sgen_entrance" );
    objectives::set( "cp_level_sgen_enter_sgen_no_pointer" );
    objectives::breadcrumb( "obj_intro_breadcrumb_3" );
    trigger::wait_till( "obj_intro_breadcrumb_3", "targetname", undefined, 0 );
    objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
    level flag::wait_till( "hendricks_at_lobby_idle" );
    t_door = getent( "trig_lobby_entrance", "targetname" );
    t_door triggerenable( 1 );
    util::init_interactive_gameobject( t_door, &"cp_prompt_dni_sgen_hack_door", &"CP_MI_SING_SGEN_HACK", &function_5d647309 );
    level thread sndpanelhack( t_door.origin );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0xf2ae5ae, Offset: 0x70b0
// Size: 0x524
function function_5d647309( e_player )
{
    self gameobjects::disable_object();
    level flag::set( "lobby_door_opening" );
    level thread scene::play( "cin_sgen_03_03_undeadqt_1st_transmit_player", e_player );
    e_player cybercom::cybercom_armpulse( 1 );
    e_player clientfield::set_to_player( "sndCCHacking", 2 );
    e_player util::delay( 1, undefined, &clientfield::increment_to_player, "hack_dni_fx" );
    wait 0.5;
    var_8cc17559 = getentarray( "exterior_hack_panel", "targetname" );
    
    foreach ( model in var_8cc17559 )
    {
        model setmodel( "p7_sgen_door_access_panel_hacked" );
    }
    
    e_player thread function_27f3c2cd();
    level waittill( #"sgen_entry_door_open" );
    
    if ( isdefined( e_player ) )
    {
        e_player clientfield::set_to_player( "sndCCHacking", 0 );
    }
    
    a_m_doors = getentarray( "lobby_entrance_doors", "script_noteworthy" );
    
    foreach ( m_door in a_m_doors )
    {
        bm_clip = getent( m_door.target, "targetname" );
        bm_clip linkto( m_door );
    }
    
    n_time = 1;
    n_accel = 0.25;
    n_decel = 0.25;
    
    foreach ( m_door in a_m_doors )
    {
        if ( m_door.targetname == "lobby_entrance_door_left" )
        {
            v_move = anglestoforward( m_door.angles ) * -60;
            m_door moveto( m_door.origin + v_move, n_time, n_accel, n_decel );
            playsoundatposition( "evt_lobby_door_open", m_door.origin );
            continue;
        }
        
        v_move = anglestoforward( m_door.angles ) * 60;
        m_door moveto( m_door.origin + v_move, n_time, n_accel, n_decel );
    }
    
    wait n_time;
    
    foreach ( m_door in a_m_doors )
    {
        m_door connectpaths();
    }
    
    level flag::set( "lobby_door_opened" );
    self gameobjects::destroy_object( 1 );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x4b061b13, Offset: 0x75e0
// Size: 0x2a
function function_27f3c2cd()
{
    level endon( #"sgen_entry_door_open" );
    self waittill( #"death" );
    level notify( #"sgen_entry_door_open" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0x1456ebfc, Offset: 0x7618
// Size: 0x34
function sndpanelhack( sndorigin )
{
    level waittill( #"sndpanelhack" );
    playsoundatposition( "evt_lobby_door_panelhack", sndorigin );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 2
// Checksum 0x2f5537b4, Offset: 0x7658
// Size: 0x38c
function skipto_enter_lobby_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        level thread function_d97219ae();
        spawner::simple_spawn_single( "entrance_qtank", &function_86c5b0ca );
        exploder::exploder( "sgen_flying_IGC" );
        sgen::init_hendricks( str_objective );
        objectives::complete( "cp_level_sgen_clear_entrance" );
        t_door = getent( "trig_lobby_entrance", "targetname" );
        t_door triggerenable( 0 );
        level flag::set( "player_at_sgen_entrance" );
        level flag::set( "qtank_fight_completed" );
        load::function_a2995f22();
        level thread player_lobby_entrance();
    }
    
    collectibles::function_93523442( "p7_nc_sin_coa_02", undefined, ( 0, -8, 0 ) );
    collectibles::function_37aecd21();
    setdvar( "ai_awarenessenabled", 0 );
    scene::init( "p7_fxanim_cp_sgen_overhang_building_glass_bundle" );
    level thread obj_lobby_entrance();
    level thread sndlobby();
    level.ai_hendricks thread enter_lobby_hendricks( b_starting );
    level flag::wait_till( "lobby_door_opened" );
    level scene::init( "cin_sgen_05_01_discoverdata_vign_lookaround_bodies" );
    level scene::init( "pb_sgen_data_discovery_hack" );
    
    if ( isdefined( level.bzm_sgendialogue1_3callback ) )
    {
        level thread [[ level.bzm_sgendialogue1_3callback ]]();
    }
    
    exploder::exploder( "lgt_sgen_obelisk_lobby" );
    level.var_75c82874 = 1;
    objectives::complete( "cp_level_sgen_hack_door" );
    objectives::set( "cp_level_sgen_investigate_sgen" );
    trig_post_discover_data = getent( "trig_post_discover_data", "targetname" );
    trig_post_discover_data triggerenable( 0 );
    trigger::wait_till( "discover_data_breadcrumb_2" );
    
    if ( isdefined( level.bzm_sgendialogue1_3callback_waittill_done ) )
    {
        [[ level.bzm_sgendialogue1_3callback_waittill_done ]]();
    }
    
    open_silo_doors();
    skipto::objective_completed( str_objective );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x6d895506, Offset: 0x79f0
// Size: 0x84
function function_86c5b0ca()
{
    self.team = "neutral";
    self ai::set_ignoreme( 1 );
    level thread scene::init( "cin_sgen_03_01_qt_attack_vign_reveal_qt01" );
    level flag::wait_till( "player_past_shimmy_wall" );
    self delete();
}

// Namespace cp_mi_sing_sgen_exterior
// Params 4
// Checksum 0x7d6732cc, Offset: 0x7a80
// Size: 0x17c
function skipto_enter_lobby_done( str_objective, b_starting, b_direct, player )
{
    if ( !( isdefined( level.var_75c82874 ) && level.var_75c82874 ) )
    {
        level.var_75c82874 = 1;
        objectives::complete( "cp_level_sgen_enter_sgen_no_pointer" );
    }
    
    struct::delete_script_bundle( "scene", "cin_sgen_02_05_exterior_vign_using_ipad_guy01" );
    struct::delete_script_bundle( "scene", "cin_sgen_03_01_qt_attack_vign_reveal_qt01" );
    struct::delete_script_bundle( "scene", "cin_sgen_03_03_undeadqt_1st_transmit_player" );
    struct::delete_script_bundle( "scene", "cin_sgen_03_03_undeadqt_vign_limitedpower_hendricks" );
    struct::delete_script_bundle( "scene", "cin_sgen_03_03_undeadqt_vign_limitedpower_hendricks_moveintolobby" );
    struct::delete_script_bundle( "scene", "cin_sgen_04_01_lobby_vign_react_hendricks" );
    hidemiscmodels( "sgen_ocean_water" );
    var_dee3d10a = getent( "discover_data_tele", "script_flag_set" );
    var_dee3d10a.script_objective = "discover_data";
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x2013f052, Offset: 0x7c08
// Size: 0x144
function sndlobby()
{
    level flag::wait_till( "player_in_lobby" );
    videostart( "cp_sgen_env_LobbyMovie", 1 );
    var_910bc1f3 = spawn( "script_origin", ( 1414, -432, 304 ) );
    var_910bc1f3 playloopsound( "amb_billboard_glitch_loop" );
    sndent = spawn( "script_origin", ( -6, -1301, 250 ) );
    sndent playsound( "mus_coalescence_theme_lobby" );
    wait 6;
    sndent playsound( "mus_coalescence_theme_lobby_underscore" );
    sndent dialog::say( "rbot_welcome_to_coalescen_0" );
    wait 45;
    sndent delete();
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x4bd73914, Offset: 0x7d58
// Size: 0x7c
function obj_lobby_entrance()
{
    level flag::wait_till( "player_at_sgen_entrance" );
    level waittill( #"hash_33481609" );
    objectives::set( "cp_level_sgen_investigate_sgen" );
    objectives::set( "cp_level_sgen_investigate_sgen_atrium" );
    objectives::breadcrumb( "discover_data_breadcrumb_2" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0x48fe1eb5, Offset: 0x7de0
// Size: 0x21c
function enter_lobby_hendricks( var_640e871b )
{
    level flag::wait_till( "qtank_fight_completed" );
    self ai::set_behavior_attribute( "cqb", 1 );
    self ai::set_behavior_attribute( "sprint", 1 );
    self colors::disable();
    level thread scene::play( "cin_sgen_03_03_undeadqt_vign_limitedpower_hendricks" );
    level util::waittill_any_timeout( 25, "cin_sgen_03_03_undeadqt_vign_limitedpower_hendricks_done" );
    level flag::set( "hendricks_at_lobby_idle" );
    self thread lobby_door_hendricks_vo();
    level flag::wait_till( "lobby_door_opening" );
    level scene::play( "cin_sgen_03_03_undeadqt_vign_limitedpower_hendricks_moveintolobby" );
    level.ai_hendricks thread function_d05c5d63();
    level scene::play( "cin_sgen_04_01_lobby_vign_react_hendricks" );
    self colors::set_force_color( "r" );
    self colors::enable();
    trigger::use( "trig_hendricks_lobby_color" );
    self waittill( #"goal" );
    level notify( #"hash_33481609" );
    level flag::wait_till( "player_at_data_doors" );
    level flag::set( "hendricks_at_silo_doors" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x5096d4d0, Offset: 0x8008
// Size: 0x94
function lobby_door_hendricks_vo()
{
    level flag::wait_till( "hendricks_at_lobby_idle" );
    level dialog::remote( "kane_interface_with_that_2" );
    
    if ( level flag::get( "lobby_door_opening" ) )
    {
        return;
    }
    
    level endon( #"lobby_door_opening" );
    wait 5;
    self dialog::say( "hend_hey_let_s_go_0" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x3625094e, Offset: 0x80a8
// Size: 0xd6
function function_d05c5d63()
{
    self waittill( #"hash_b32ba9d" );
    
    foreach ( e_player in level.activeplayers )
    {
        if ( distance( self.origin, e_player.origin ) <= 500 )
        {
            self dialog::say( "hend_don_t_get_skittish_0" );
            break;
        }
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xc486ec5b, Offset: 0x8188
// Size: 0x28c
function open_silo_doors()
{
    level flag::wait_till( "hendricks_at_silo_doors" );
    objectives::complete( "cp_level_sgen_investigate_sgen" );
    objectives::complete( "cp_level_sgen_investigate_sgen_atrium" );
    level.ai_hendricks cybercom::cybercom_armpulse( 1 );
    level.ai_hendricks dialog::say( "hend_interfacing_with_the_0" );
    
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "sndSiloBG", 1 );
    }
    
    wait 0.5;
    var_280d5f68 = getent( "silo_door_left", "targetname" );
    var_3c301126 = getent( "silo_door_right", "targetname" );
    var_280d5f68 rotateyaw( var_280d5f68.script_int, 1, 0.25, 0.4 );
    playsoundatposition( "evt_silo_door_open", var_280d5f68.origin );
    var_3c301126 rotateyaw( var_3c301126.script_int, 1, 0.25, 0.4 );
    playsoundatposition( "evt_silo_door_open", var_3c301126.origin );
    var_3c301126 waittill( #"rotatedone" );
    level flag::set( "silo_door_opened" );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x5da114a0, Offset: 0x8420
// Size: 0x164
function check_for_alert()
{
    self endon( #"death" );
    self endon( #"stealth_assist_alerted" );
    level endon( #"exterior_gone_hot" );
    b_alerted = 0;
    var_50cacf55 = undefined;
    
    do
    {
        b_alerted = 0;
        
        if ( self.should_stop_patrolling === 1 )
        {
            b_alerted = 1;
            break;
        }
        
        foreach ( player in level.players )
        {
            if ( !( isdefined( player.active_camo ) && player.active_camo ) && self cansee( player ) )
            {
                b_alerted = 1;
                var_50cacf55 = player;
                break;
            }
        }
        
        wait 0.1;
    }
    while ( !b_alerted );
    
    self thread function_94a23f13( var_50cacf55 );
}

// Namespace cp_mi_sing_sgen_exterior
// Params 3
// Checksum 0x35ebaa17, Offset: 0x8590
// Size: 0x184
function truck_gunner_replace( n_gunners, n_delay, str_endon )
{
    if ( !isdefined( n_gunners ) )
    {
        n_gunners = 1;
    }
    
    if ( !isdefined( n_delay ) )
    {
        n_delay = 1;
    }
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    self endon( #"death" );
    
    if ( isdefined( str_endon ) )
    {
        level endon( str_endon );
    }
    
    level flag::wait_till( "exterior_gone_hot" );
    self turret::enable( 1, 1 );
    n_guys = 0;
    
    while ( n_guys < n_gunners )
    {
        ai_gunner = self vehicle::get_rider( "gunner1" );
        
        if ( isalive( ai_gunner ) )
        {
            ai_gunner waittill( #"death" );
        }
        else
        {
            ai_gunner = get_truck_gunner( self );
            
            if ( isalive( ai_gunner ) )
            {
                ai_gunner vehicle::get_in( self, "gunner1", 0 );
                n_guys++;
            }
        }
        
        wait n_delay;
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 1
// Checksum 0xb97ccd92, Offset: 0x8720
// Size: 0x70
function get_truck_gunner( vh_truck )
{
    a_ai_enemies = getaiarchetypearray( "human", "axis" );
    a_ai_gunners = arraysortclosest( a_ai_enemies, vh_truck.origin );
    return a_ai_gunners[ 0 ];
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0xa4f5ca0d, Offset: 0x8798
// Size: 0x24a
function exterior_vehicle_damagefunc()
{
    level endon( #"qt_plaza_outro_igc_started" );
    
    while ( true )
    {
        self waittill( #"damage", n_damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags );
        
        if ( weapon == level.w_quadtank_player_weapon || weapon == level.w_quadtank_mlrs_weapon || weapon == level.w_quadtank_mlrs_weapon2 )
        {
            self dodamage( self.health, self.origin );
            break;
        }
    }
    
    v_launch = anglestoforward( self.angles ) * -350 + ( 0, 0, 200 );
    v_org = self.origin + anglestoforward( self.angles ) * 10;
    self launchvehicle( v_launch, v_org, 0 );
    self thread monitor_vehicle_landing();
    a_ai_riders = self.riders;
    
    foreach ( ai in a_ai_riders )
    {
        ai dodamage( ai.health, ai.origin );
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x53b32bd0, Offset: 0x89f0
// Size: 0x94
function monitor_vehicle_landing()
{
    self endon( #"death" );
    
    if ( isdefined( 60 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 60, "timeout" );
    }
    
    self waittill( #"veh_landed" );
    
    if ( isdefined( self ) )
    {
        self playsound( "evt_truck_impact" );
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x5f8cf1b0, Offset: 0x8a90
// Size: 0x74
function function_210baecb()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"weapon_change" );
        
        if ( self getcurrentweapon() == getweapon( "launcher_standard" ) )
        {
            self thread missile_launcher_equip_hint();
            break;
        }
    }
}

// Namespace cp_mi_sing_sgen_exterior
// Params 0
// Checksum 0x933b3066, Offset: 0x8b10
// Size: 0xfa
function missile_launcher_equip_hint()
{
    self endon( #"death" );
    self endon( #"weapon_swap_learned" );
    
    if ( !isdefined( self.var_c142b118 ) )
    {
        self util::show_hint_text( &"COOP_EQUIP_XM53", 0, "weapon_swap_learned", 10 );
        n_timeout = 0;
        
        while ( self getcurrentweapon() == getweapon( "launcher_standard" ) && n_timeout <= 10 )
        {
            n_timeout += 0.1;
            wait 0.1;
        }
        
        self.var_c142b118 = 1;
        self util::hide_hint_text();
        self notify( #"weapon_swap_learned" );
    }
}

