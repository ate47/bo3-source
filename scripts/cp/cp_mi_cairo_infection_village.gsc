#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_village_surreal;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace village;

// Namespace village
// Params 0, eflags: 0x2
// Checksum 0x2ad08b8e, Offset: 0x1420
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "infection_village", &__init__, undefined, undefined );
}

// Namespace village
// Params 0
// Checksum 0x20d3896b, Offset: 0x1460
// Size: 0x14
function __init__()
{
    scene_setup();
}

// Namespace village
// Params 0
// Checksum 0xcac1d4a4, Offset: 0x1480
// Size: 0xf4
function init_client_field_callback_funcs()
{
    clientfield::register( "world", "village_mortar_index", 1, 3, "int" );
    clientfield::register( "world", "village_intro_mortar", 1, 1, "int" );
    clientfield::register( "world", "init_fold", 1, 1, "int" );
    clientfield::register( "world", "start_fold", 1, 1, "int" );
    clientfield::register( "scriptmover", "fold_buildings", 1, 1, "int" );
}

// Namespace village
// Params 4
// Checksum 0x336a9118, Offset: 0x1580
// Size: 0x4c
function cleanup( str_objective, b_starting, b_direct, player )
{
    level notify( #"end_salm_foy_dialog" );
    objectives::complete( "cp_level_infection_gather_airlock" );
}

// Namespace village
// Params 3
// Checksum 0x9fcdbd6d, Offset: 0x15d8
// Size: 0x4e4
function main( str_objective, b_starting, var_75294396 )
{
    if ( !isdefined( var_75294396 ) )
    {
        var_75294396 = 0;
    }
    
    if ( b_starting )
    {
        load::function_73adcefc();
        spawner_setup();
    }
    
    level thread infection_util::setup_reverse_time_arrivals( "foy_reverse_anim" );
    init_time_rewind_destruction();
    
    if ( b_starting )
    {
        level thread scene::init( "p7_fxanim_cp_infection_reverse_house_01_bundle" );
        level thread scene::init( "cin_inf_10_01_foy_aie_reversemortar" );
        level thread scene::init( "cin_inf_10_02_foy_aie_reversewallexplosion_suppressor" );
        level thread scene::init( "cin_inf_10_01_foy_vign_intro" );
        level util::set_streamer_hint( 7 );
        objectives::set( "cp_level_infection_follow_sarah" );
    }
    
    level.allies_disadvantage = 0;
    level.alert_german = 0;
    level.var_acfc49b5 = 0;
    spawner::add_spawn_function_group( "sp_foy_friendlies", "targetname", &spawn_func_ally );
    spawner::add_spawn_function_group( "sp_foy_friendlies_respawn_1", "targetname", &respawn_func_ally );
    spawner::add_spawn_function_group( "sp_foy_friendlies_respawn_2", "targetname", &respawn_func_ally );
    spawner::add_spawn_function_group( "sp_foy_friendlies_respawn_3", "targetname", &respawn_func_ally );
    
    if ( isdefined( level.bzm_infectiondialogue11callback ) )
    {
        level thread [[ level.bzm_infectiondialogue11callback ]]();
    }
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        spawn_foy_turret_01();
        spawn_foy_turret_02();
        spawn_foy_turret_03();
    }
    
    infection_util::turn_on_snow_fx_for_all_players();
    a_blockers = getentarray( "foy_gather_point_debris_blocker", "targetname" );
    level thread hide_blocker( a_blockers );
    level thread monitor_t_allies_disadvantage();
    
    if ( b_starting )
    {
        load::function_a2995f22();
        level thread foy_intro( 0 );
    }
    else
    {
        level thread foy_intro( 1 );
    }
    
    level thread monitor_t_sm_barn_house_1();
    level thread monitor_t_battlechatter_reclaim_foy();
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        level thread monitor_t_foy_turret_01_enable();
        level thread monitor_t_foy_turret_02_spawn();
        level thread monitor_t_foy_turret_03_spawn();
    }
    
    level thread monitor_t_retreat_sp_wall_fx_german();
    level thread monitor_t_sm_foy_town_waves();
    level thread monitor_t_retreat_sp_foy_post_intro_formation_1_ai();
    level thread monitor_t_retreat_sp_barn_house_1_ai();
    level thread monitor_t_retreat_sp_foy_guys_right_ai();
    level thread monitor_t_retreat_sp_foy_town_wave_ai();
    level thread function_631f7f5e();
    level thread foy_folds();
    level thread random_battle_effects();
    level thread function_880a13df();
    level thread util::clear_streamer_hint();
}

// Namespace village
// Params 0
// Checksum 0x4369b750, Offset: 0x1ac8
// Size: 0x34
function function_633271eb()
{
    level thread infection_util::function_f6d49772( "t_salm_having_established_a_1", "salm_having_established_a_1", "end_salm_foy_dialog" );
}

// Namespace village
// Params 0
// Checksum 0x569f57a1, Offset: 0x1b08
// Size: 0x102
function monitor_t_allies_disadvantage()
{
    trigger::wait_till( "t_allies_disadvantage" );
    level.allies_disadvantage = 1;
    a_ai_array = getaiteamarray( "allies" );
    
    foreach ( ai in a_ai_array )
    {
        if ( isdefined( ai.targetname ) )
        {
            if ( ai.targetname == "sp_foy_friendlies_ai" )
            {
                ai.takedamage = 1;
            }
        }
    }
}

// Namespace village
// Params 0
// Checksum 0x8e4c7f0a, Offset: 0x1c18
// Size: 0x54
function monitor_t_battlechatter_reclaim_foy()
{
    trigger::wait_till( "t_battlechatter_reclaim_foy" );
    infection_util::infection_battle_chatter( "company_move" );
    wait 3;
    infection_util::infection_battle_chatter( "reclaim_foy" );
}

// Namespace village
// Params 0
// Checksum 0x1c34c531, Offset: 0x1c78
// Size: 0x68
function spawn_foy_turret_01()
{
    level.ai_foy_turret_01 = new cfoyturret();
    vh_turret_01 = vehicle::simple_spawn_single( "sp_foy_turret_01" );
    [[ level.ai_foy_turret_01 ]]->turret_setup( vh_turret_01, "sp_foy_turret_01_gunner", "t_foy_turret_01_gunner" );
}

// Namespace village
// Params 0
// Checksum 0xeefc5416, Offset: 0x1ce8
// Size: 0x60
function spawn_foy_turret_02()
{
    level.ai_foy_turret_02 = new cfoyturret();
    vh_turret_02 = vehicle::simple_spawn_single( "sp_foy_turret_02" );
    [[ level.ai_foy_turret_02 ]]->turret_setup( vh_turret_02, "sp_foy_turret_02_gunner", undefined );
}

// Namespace village
// Params 0
// Checksum 0xebca01f1, Offset: 0x1d50
// Size: 0x90
function spawn_foy_turret_03()
{
    level.ai_foy_turret_03 = new cfoyturret();
    vh_turret_03 = vehicle::simple_spawn_single( "sp_foy_turret_03" );
    vh_turret_03 setcandamage( 1 );
    vh_turret_03.health = 2000;
    [[ level.ai_foy_turret_03 ]]->turret_setup( vh_turret_03, "sp_foy_turret_03_gunner", undefined );
}

// Namespace village
// Params 0
// Checksum 0xe2852183, Offset: 0x1de8
// Size: 0x4c
function monitor_t_foy_turret_01_enable()
{
    trigger::wait_till( "t_foy_turret_01_enable" );
    [[ level.ai_foy_turret_01 ]]->gunner_start_think();
    wait 2;
    infection_util::infection_battle_chatter( "mg_middle" );
}

// Namespace village
// Params 0
// Checksum 0x5efec310, Offset: 0x1e40
// Size: 0xf4
function monitor_t_foy_turret_02_spawn()
{
    trigger::wait_till( "t_foy_turret_02_spawn" );
    level thread foy_turret_doors_open( "turret_door" );
    exploder::exploder( "fx_expl_barn_window_open" );
    wait 0.5;
    [[ level.ai_foy_turret_02 ]]->gunner_start_think();
    wait 1;
    infection_util::infection_battle_chatter( "mg_brick_building" );
    level thread function_77321751();
    spawn_manager::enable( "sm_turret_barn_door" );
    level thread foy_turret_doors_open( "turret_barn_door" );
    exploder::exploder( "fx_expl_barn_door_open" );
}

// Namespace village
// Params 0
// Checksum 0x75c05a7d, Offset: 0x1f40
// Size: 0x2c
function function_77321751()
{
    level waittill( #"hash_ec7a5edf" );
    wait 1;
    infection_util::infection_battle_chatter( "mg_down" );
}

// Namespace village
// Params 0
// Checksum 0x3d568e2c, Offset: 0x1f78
// Size: 0xb4
function monitor_t_foy_turret_03_spawn()
{
    trigger::wait_till( "t_foy_turret_03_spawn" );
    level thread foy_turret_doors_open( "barn_door" );
    wait 0.5;
    [[ level.ai_foy_turret_03 ]]->gunner_start_think();
    exploder::exploder( "fx_expl_mg_bullet_impacts_village01" );
    wait 1.5;
    exploder::exploder( "fx_expl_mg_bullet_impacts_village02" );
    wait 1.5;
    exploder::exploder( "fx_expl_mg_bullet_impacts_village03" );
}

// Namespace village
// Params 0
// Checksum 0xef182dd5, Offset: 0x2038
// Size: 0x54
function monitor_t_sm_barn_house_1()
{
    trigger::wait_till( "t_sm_barn_house_1" );
    foy_turret_doors_open( "barn_lower_door" );
    wait 0.25;
    spawn_manager::enable( "sm_barn_house_1" );
}

// Namespace village
// Params 2
// Checksum 0x7799fc02, Offset: 0x2098
// Size: 0xe0
function formation_retreat( str_start_nd, n_wait )
{
    self endon( #"death" );
    
    if ( isdefined( str_start_nd ) )
    {
    }
    
    for ( e_target = getnode( str_start_nd, "targetname" ); isdefined( e_target ) ; e_target = undefined )
    {
        self setgoal( e_target );
        self waittill( #"goal" );
        self.goalradius = 64;
        
        if ( isdefined( e_target.target ) )
        {
            wait n_wait;
            e_target = getnode( e_target.target, "targetname" );
            continue;
        }
    }
}

// Namespace village
// Params 0
// Checksum 0x7094568e, Offset: 0x2180
// Size: 0x64
function monitor_t_sm_foy_town_waves()
{
    trigger::wait_till( "t_sm_foy_town_waves" );
    spawn_manager::enable( "sm_foy_town_wave_1" );
    spawn_manager::enable( "sm_foy_town_wave_2" );
    spawn_manager::enable( "sm_foy_town_wave_3" );
}

// Namespace village
// Params 0
// Checksum 0xe4194b42, Offset: 0x21f0
// Size: 0x194
function monitor_t_retreat_sp_wall_fx_german()
{
    trigger::wait_till( "t_retreat_sp_wall_fx_german" );
    level thread infection_util::set_ai_goal_volume( "foy_wall_fx_german_01_ai", "foy_goal_volume_2" );
    level thread infection_util::set_ai_goal_volume( "foy_wall_fx_german_02_ai", "foy_goal_volume_2" );
    level thread infection_util::set_ai_goal_volume( "foy_wall_fx_german_03_ai", "foy_goal_volume_2" );
    level thread infection_util::set_ai_goal_volume( "foy_wall_fx_german_04_ai", "foy_goal_volume_2" );
    sp_retreat_01 = spawner::simple_spawn_single( "sp_retreat_01" );
    sp_retreat_01 thread formation_retreat( "nd_retreat_01", 12 );
    sp_retreat_02 = spawner::simple_spawn_single( "sp_retreat_02" );
    sp_retreat_02 thread formation_retreat( "nd_retreat_02", 10 );
    sp_retreat_03 = spawner::simple_spawn_single( "sp_retreat_03" );
    sp_retreat_03 thread formation_retreat( "nd_retreat_03", 8 );
}

// Namespace village
// Params 0
// Checksum 0x18ed870f, Offset: 0x2390
// Size: 0x44
function monitor_t_retreat_sp_foy_post_intro_formation_1_ai()
{
    trigger::wait_till( "t_retreat_sp_foy_post_intro_formation_1_ai" );
    level thread infection_util::retreat_if_in_volume( "t_sp_foy_post_intro_formation_1_ai", "foy_goal_volume_2" );
}

// Namespace village
// Params 0
// Checksum 0xc570926d, Offset: 0x23e0
// Size: 0x6c
function monitor_t_retreat_sp_barn_house_1_ai()
{
    trigger::wait_till( "t_retreat_sp_barn_house_1_ai" );
    level thread infection_util::retreat_if_in_volume( "t_sp_barn_house_1_ai", "t_sp_foy_town_wave_ai" );
    level thread infection_util::retreat_if_in_volume( "foy_goal_volume_2", "t_sp_foy_town_wave_ai" );
}

// Namespace village
// Params 0
// Checksum 0xce35c43e, Offset: 0x2458
// Size: 0x44
function monitor_t_retreat_sp_foy_guys_right_ai()
{
    trigger::wait_till( "t_retreat_sp_foy_guys_right_ai" );
    level thread infection_util::retreat_if_in_volume( "t_sp_foy_guys_right_ai", "foy_goal_volume_3" );
}

// Namespace village
// Params 0
// Checksum 0xe0d8bf73, Offset: 0x24a8
// Size: 0x44
function monitor_t_retreat_sp_foy_town_wave_ai()
{
    trigger::wait_till( "t_retreat_sp_foy_town_wave_ai" );
    level thread infection_util::retreat_if_in_volume( "t_sp_foy_town_wave_ai", "foy_goal_volume_3" );
}

// Namespace village
// Params 0
// Checksum 0x6f3b0141, Offset: 0x24f8
// Size: 0x7c
function function_631f7f5e()
{
    trigger::wait_till( "t_sm_foy_post_fold" );
    infection_util::infection_battle_chatter( "fences_move" );
    flag::wait_till( "final_area_cleared" );
    battlechatter::function_d9f49fba( 0 );
    wait 1;
    function_c79f9420();
}

// Namespace village
// Params 0
// Checksum 0xb4f8ef44, Offset: 0x2580
// Size: 0x44
function spawner_setup()
{
    infection_util::enable_exploding_deaths( 1 );
    spawner::add_global_spawn_function( "axis", &infection_util::function_dafed344 );
}

// Namespace village
// Params 0
// Checksum 0x3d25958c, Offset: 0x25d0
// Size: 0x2f4
function scene_setup()
{
    scene::add_scene_func( "cin_inf_10_01_foy_vign_walk", &infection_util::callback_scene_objective_light_enable, "init" );
    scene::add_scene_func( "cin_inf_10_01_foy_vign_walk", &infection_util::callback_scene_objective_light_disable_no_delete, "play" );
    scene::add_scene_func( "cin_inf_10_01_foy_vign_intro", &foy_vign_intro_play, "play" );
    scene::add_scene_func( "cin_inf_10_01_foy_vign_intro", &village_messages, "play" );
    scene::add_scene_func( "cin_inf_10_01_foy_vign_intro", &callback_scene_warp_players_after_foy_intro, "done" );
    scene::add_scene_func( "cin_inf_10_01_foy_vign_intro", &infection_util::callback_scene_objective_light_enable, "done" );
    scene::add_scene_func( "cin_inf_10_01_foy_vign_intro", &infection_util::function_23e59afd, "play" );
    scene::add_scene_func( "cin_inf_10_01_foy_vign_intro", &infection_util::function_e2eba6da, "done" );
    infection_util::play_scene_on_trigger( "p7_fxanim_cp_infection_reverse_wall_01_bundle", "fxanim_reverse_wall_explosion_trigger" );
    scene::add_scene_func( "p7_fxanim_cp_infection_reverse_wall_01_bundle", &callback_scene_reverse_time_wall_explosion, "play" );
    scene::add_scene_func( "cin_inf_06_03_bastogne_aie_reverse_soldier01hipshot_suppressor", &infection_util::scene_callback_reverse_time_play_foy, "play" );
    scene::add_scene_func( "cin_inf_06_03_bastogne_aie_reverse_soldier02headshot_suppressor", &infection_util::scene_callback_reverse_time_play_foy, "play" );
    scene::add_scene_func( "cin_inf_10_01_foy_aie_reversemortar_react", &infection_util::scene_callback_reverse_time_play_foy, "play" );
    scene::add_scene_func( "cin_inf_10_02_foy_aie_reversewallexplosion_suppressor", &infection_util::scene_callback_reverse_time_play_foy, "play" );
    scene::add_scene_func( "p7_fxanim_cp_infection_fold_bundle", &function_8b16f470, "init" );
    scene::add_scene_func( "p7_fxanim_cp_infection_fold_bundle", &function_6ac10d8c, "play" );
}

// Namespace village
// Params 0
// Checksum 0xc7a93df, Offset: 0x28d0
// Size: 0x17c
function spawn_func_ally()
{
    self endon( #"death" );
    self hide();
    self.takedamage = 0;
    self ai::set_ignoreall( 1 );
    self.goalradius = 256;
    self.script_accuracy = 0.25;
    self.overrideactordamage = &callback_ally_damage;
    self thread infection_util::ai_camo( 0 );
    util::wait_network_frame();
    self show();
    n_spawn_anim = randomint( 2 );
    str_spawn_anim = undefined;
    
    switch ( n_spawn_anim )
    {
        case 0:
            str_spawn_anim = "cin_inf_10_02_foy_vign_teleport_spawn";
            break;
        case 1:
            str_spawn_anim = "cin_inf_10_02_foy_vign_teleport_spawn02";
            break;
        case 2:
            str_spawn_anim = "cin_inf_10_02_foy_vign_teleport_spawn03";
            break;
    }
    
    self scene::play( str_spawn_anim, self );
    self ai::set_ignoreall( 0 );
}

// Namespace village
// Params 0
// Checksum 0xecfb8db, Offset: 0x2a58
// Size: 0x44
function respawn_func_ally()
{
    self endon( #"death" );
    self.goalradius = 256;
    self.script_accuracy = 0.25;
    self.overrideactordamage = &callback_ally_damage;
}

// Namespace village
// Params 12
// Checksum 0xf6c50e58, Offset: 0x2aa8
// Size: 0x92
function callback_ally_damage( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename )
{
    if ( isdefined( eattacker ) && isplayer( eattacker ) )
    {
        idamage = 0;
    }
    
    return idamage;
}

// Namespace village
// Params 1
// Checksum 0x91db4766, Offset: 0x2b48
// Size: 0x9c
function callback_scene_reverse_time_wall_explosion( a_ents )
{
    level clientfield::set( "village_mortar_index", 1 );
    level thread scene::play( "cin_inf_10_02_foy_aie_reversewallexplosion_suppressor" );
    wait 1;
    spawn_manager::enable( "sm_foy_friendlies" );
    spawn_manager::wait_till_complete( "sm_foy_friendlies" );
    spawn_manager::kill( "sm_foy_friendlies" );
}

// Namespace village
// Params 1
// Checksum 0x75ca952f, Offset: 0x2bf0
// Size: 0x7c
function callback_scene_warp_players_after_foy_intro( a_ents )
{
    level thread infection_util::teleport_coop_players_after_shared_cinematic( a_ents );
    infection_util::turn_off_snow_fx_for_all_players();
    util::wait_network_frame();
    infection_util::turn_on_snow_fx_for_all_players();
    array::thread_all( level.players, &infection_util::player_leave_cinematic );
}

// Namespace village
// Params 0
// Checksum 0xa1bf9b49, Offset: 0x2c78
// Size: 0x424
function init_time_rewind_destruction()
{
    level.a_m_reverse_barn_01 = getentarray( "reverse_barn_01_corner", "targetname" );
    infection_util::models_ghost( level.a_m_reverse_barn_01 );
    level.a_m_reverse_fence_01 = getentarray( "m_reverse_fence_01", "targetname" );
    infection_util::models_ghost( level.a_m_reverse_fence_01 );
    level.a_m_reverse_fence_02 = getentarray( "m_reverse_fence_02", "targetname" );
    infection_util::models_ghost( level.a_m_reverse_fence_02 );
    level.a_m_reverse_chciken_coop_01 = getentarray( "m_reverse_chciken_coop_01", "targetname" );
    infection_util::models_ghost( level.a_m_reverse_chciken_coop_01 );
    level.a_m_reverse_chciken_coop_02 = getentarray( "m_reverse_chciken_coop_02", "targetname" );
    infection_util::models_ghost( level.a_m_reverse_chciken_coop_02 );
    level.a_m_reverse_house_01_bundle = getentarray( "m_reverse_house_01", "targetname" );
    infection_util::models_ghost( level.a_m_reverse_house_01_bundle );
    scene::add_scene_func( "p7_fxanim_cp_infection_reverse_barn_01_bundle", &callback_show_m_reverse_barn_01, "done" );
    scene::add_scene_func( "p7_fxanim_cp_infection_reverse_fence_01_bundle", &callback_show_m_reverse_fence_01, "done" );
    scene::add_scene_func( "p7_fxanim_cp_infection_reverse_fence_02_bundle", &callback_show_m_reverse_fence_02, "done" );
    scene::add_scene_func( "p7_fxanim_cp_infection_reverse_chciken_coop_01_bundle", &callback_show_m_reverse_chciken_coop_01, "done" );
    scene::add_scene_func( "p7_fxanim_cp_infection_reverse_chciken_coop_02_bundle", &callback_show_m_reverse_chciken_coop_02, "done" );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        scene::add_scene_func( "p7_fxanim_cp_infection_reverse_house_01_bundle", &callback_reverse_house_01_bundle_play, "play" );
        scene::add_scene_func( "p7_fxanim_cp_infection_reverse_house_01_bundle", &callback_show_m_reverse_house_01_bundle, "done" );
    }
    
    infection_util::play_scene_on_view_and_radius( "p7_fxanim_cp_infection_reverse_barn_01_bundle", "s_infection_reverse_barn_01_bundle", "t_infection_reverse_barn_01_bundle_inner", "t_infection_reverse_barn_01_bundle_outter" );
    infection_util::play_scene_on_view_and_radius( "p7_fxanim_cp_infection_reverse_fence_01_bundle", "s_infection_reverse_fence_01_bundle", "t_infection_reverse_fence_01_bundle_inner", "t_infection_reverse_fence_01_bundle_outter" );
    infection_util::play_scene_on_view_and_radius( "p7_fxanim_cp_infection_reverse_fence_02_bundle", "s_infection_reverse_fence_02_bundle", "t_infection_reverse_fence_02_bundle_inner", "t_infection_reverse_fence_02_bundle_outter" );
    infection_util::play_scene_on_view_and_radius( "p7_fxanim_cp_infection_reverse_chciken_coop_01_bundle", "s_infection_reverse_chciken_coop_01_bundle", "t_infection_reverse_chciken_coop_01_bundle_inner", "t_infection_reverse_chciken_coop_01_bundle_outter" );
    infection_util::play_scene_on_view_and_radius( "p7_fxanim_cp_infection_reverse_chciken_coop_02_bundle", "s_infection_reverse_chciken_coop_02_bundle", "t_infection_reverse_chciken_coop_02_bundle_inner", "t_infection_reverse_chciken_coop_02_bundle_outter" );
    infection_util::play_scene_on_view_and_radius( "p7_fxanim_cp_infection_reverse_telephone_pole_bundle", "s_infection_reverse_telephone_pole_bundle", "t_infection_reverse_telephone_pole_bundle_inner", "t_infection_reverse_telephone_pole_bundle_outter" );
    level scene::init( "p7_fxanim_cp_infection_reverse_transition_wall_bundle" );
}

// Namespace village
// Params 1
// Checksum 0x98f8c3e9, Offset: 0x30a8
// Size: 0x24
function callback_show_m_reverse_barn_01( a_ents )
{
    infection_util::models_show( level.a_m_reverse_barn_01 );
}

// Namespace village
// Params 1
// Checksum 0xeddad262, Offset: 0x30d8
// Size: 0x24
function callback_show_m_reverse_fence_01( a_ents )
{
    infection_util::models_show( level.a_m_reverse_fence_01 );
}

// Namespace village
// Params 1
// Checksum 0x4a7e4a79, Offset: 0x3108
// Size: 0x24
function callback_show_m_reverse_fence_02( a_ents )
{
    infection_util::models_show( level.a_m_reverse_fence_02 );
}

// Namespace village
// Params 1
// Checksum 0x1cee33d8, Offset: 0x3138
// Size: 0x24
function callback_show_m_reverse_chciken_coop_01( a_ents )
{
    infection_util::models_show( level.a_m_reverse_chciken_coop_01 );
}

// Namespace village
// Params 1
// Checksum 0xbe009287, Offset: 0x3168
// Size: 0x24
function callback_show_m_reverse_chciken_coop_02( a_ents )
{
    infection_util::models_show( level.a_m_reverse_chciken_coop_02 );
}

// Namespace village
// Params 1
// Checksum 0xe625d014, Offset: 0x3198
// Size: 0xbc
function callback_reverse_house_01_bundle_play( a_ents )
{
    foreach ( player in level.activeplayers )
    {
        player thread play_fold_house_rumble();
    }
    
    level waittill( #"revive_german" );
    level thread scene::play( "cin_inf_10_01_foy_aie_reversemortar" );
}

// Namespace village
// Params 1
// Checksum 0xfc9edd, Offset: 0x3260
// Size: 0x32
function callback_show_m_reverse_house_01_bundle( a_ents )
{
    infection_util::models_show( level.a_m_reverse_house_01_bundle );
    level notify( #"reverse_house_01_done" );
}

// Namespace village
// Params 0
// Checksum 0x1c40d08a, Offset: 0x32a0
// Size: 0x94
function function_1bf08d19()
{
    spawner_setup();
    level thread scene::init( "p7_fxanim_cp_infection_reverse_house_01_bundle" );
    level thread scene::init( "cin_inf_10_01_foy_aie_reversemortar" );
    level thread scene::init( "cin_inf_10_02_foy_aie_reversewallexplosion_suppressor" );
    level thread scene::init( "cin_inf_10_01_foy_vign_intro" );
}

// Namespace village
// Params 1
// Checksum 0xd748d1d6, Offset: 0x3340
// Size: 0x17c
function foy_intro( var_ea6e4b0d )
{
    if ( var_ea6e4b0d )
    {
        level waittill( #"hash_6aa6dc33" );
    }
    else
    {
        level scene::add_player_linked_scene( "p7_fxanim_cp_infection_reverse_house_01_bundle" );
        level scene::play( "cin_inf_10_01_foy_vign_intro" );
    }
    
    scene::waittill_skip_sequence_completed();
    level flag::wait_till( "sarah_anchor_post_scene_done" );
    level thread infection_util::function_3fe1f72( "t_sarah_foy_objective_", 0, &sarah_appears_airlock_exterior_and_waits_for_players );
    level.players[ 0 ] thread dialog::say( "hall_this_is_the_path_i_0", 2 );
    level clientfield::set( "village_intro_mortar", 1 );
    exploder::exploder( "light_foy_introroom" );
    level notify( #"hash_5b12bc4" );
    level thread monitor_player_attack();
    level thread monitor_t_alert_german();
    level scene::init( "p7_fxanim_cp_infection_fold_bundle" );
}

// Namespace village
// Params 1
// Checksum 0x167646ff, Offset: 0x34c8
// Size: 0x5c
function function_8b16f470( a_ents )
{
    level clientfield::set( "init_fold", 1 );
    a_ents[ "fold_skinned" ] clientfield::set( "fold_buildings", 1 );
}

// Namespace village
// Params 1
// Checksum 0x148b7f30, Offset: 0x3530
// Size: 0x2c
function function_6ac10d8c( a_ents )
{
    level clientfield::set( "start_fold", 1 );
}

// Namespace village
// Params 1
// Checksum 0x8423f15f, Offset: 0x3568
// Size: 0x114
function foy_vign_intro_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        foreach ( player in level.activeplayers )
        {
            player playrumbleonentity( "infection2_tank_crash_rumble" );
            player shellshock( "default", 3.5 );
        }
    }
    
    level waittill( #"hash_9459f59" );
    level thread sndrecordplayer();
    level scene::play( "p7_fxanim_cp_infection_reverse_house_01_bundle" );
}

// Namespace village
// Params 0
// Checksum 0x2e056de0, Offset: 0x3688
// Size: 0x64
function monitor_t_alert_german()
{
    self endon( #"alert_german_fire" );
    trigger::wait_till( "t_alert_german" );
    
    if ( level.alert_german == 0 )
    {
        alert_german = 1;
        level notify( #"alert_german_trigger" );
        alert_german();
    }
}

// Namespace village
// Params 0
// Checksum 0xeb573bdd, Offset: 0x36f8
// Size: 0x6c
function waittill_action_alert()
{
    self endon( #"disconnect" );
    
    while ( !self attackbuttonpressed() && !self throwbuttonpressed() && !self fragbuttonpressed() )
    {
        wait 0.05;
    }
    
    wait 0.2;
}

// Namespace village
// Params 0
// Checksum 0x20dec940, Offset: 0x3770
// Size: 0x32
function wait_till_attack()
{
    self endon( #"disconnect" );
    self waittill_action_alert();
    level notify( #"alert_german" );
}

// Namespace village
// Params 0
// Checksum 0x308f7e3e, Offset: 0x37b0
// Size: 0x84
function monitor_player_attack()
{
    self endon( #"alert_german_trigger" );
    array::spread_all( level.players, &wait_till_attack );
    level waittill( #"alert_german" );
    
    if ( level.alert_german == 0 )
    {
        alert_german = 1;
        level notify( #"alert_german_fire" );
        alert_german();
    }
}

// Namespace village
// Params 0
// Checksum 0xf62b95d, Offset: 0x3840
// Size: 0xf4
function alert_german()
{
    e_german_01 = getent( "foy_intro_german_01_ai", "targetname" );
    e_german_02 = getent( "foy_intro_german_02_ai", "targetname" );
    e_german_03 = getent( "foy_intro_german_03_ai", "targetname" );
    a_e_actors = array( e_german_01, e_german_02, e_german_03 );
    level scene::stop( "cin_inf_10_01_foy_aie_reversemortar" );
    level thread scene::play( "cin_inf_10_01_foy_aie_reversemortar_react", a_e_actors );
}

// Namespace village
// Params 0
// Checksum 0x76c30871, Offset: 0x3940
// Size: 0x54
function sarah_appears_airlock_exterior_and_waits_for_players()
{
    self scene::play( "cin_inf_10_01_foy_vign_walk", self );
    self thread scene::init( "cin_inf_11_02_fold_1st_airlock_entrance", self );
    players_gather_in_fold_house();
}

// Namespace village
// Params 0
// Checksum 0xcd9aefbc, Offset: 0x39a0
// Size: 0x9c
function sndrecordplayer()
{
    playsoundatposition( "evt_infection_record_reverse_event", ( -66734, -9538, 491 ) );
    playbacktime = soundgetplaybacktime( "evt_infection_record_reverse_event" );
    playbacktime *= 0.001;
    playbacktime -= 0.25;
    wait playbacktime - 7;
    level util::clientnotify( "sndREC" );
}

// Namespace village
// Params 0
// Checksum 0x199da30f, Offset: 0x3a48
// Size: 0x54
function foy_folds()
{
    trigger::wait_till( "fold_start" );
    playsoundatposition( "evt_world_fold", ( -67613, -4626, 755 ) );
    fold_start();
}

// Namespace village
// Params 0
// Checksum 0x9319b651, Offset: 0x3aa8
// Size: 0x48
function _display_origin()
{
    self endon( #"death" );
    
    while ( true )
    {
        /#
            debugstar( self.origin, 2, ( 1, 0, 0 ) );
        #/
        
        wait 0.1;
    }
}

// Namespace village
// Params 1
// Checksum 0x8826b44d, Offset: 0x3af8
// Size: 0xb4
function sarah_waits_airlock_interior( str_breadcrumb )
{
    s_struct_pos = struct::get( str_breadcrumb, "targetname" );
    v_offset = ( 0, 0, -500 );
    t_radius = infection_util::create_trigger_radius( s_struct_pos.origin + v_offset, 128, 1024 );
    t_radius waittill( #"trigger" );
    t_radius delete();
}

// Namespace village
// Params 0
// Checksum 0x3dcffcee, Offset: 0x3bb8
// Size: 0x266
function cleanup_ai_foldhouse()
{
    spawner::remove_global_spawn_function( "axis", &infection_util::function_dafed344 );
    colors::kill_color_replacements();
    a_foy_allies = getaiteamarray( "allies" );
    
    for ( i = 0; i < a_foy_allies.size ; i++ )
    {
        if ( isdefined( a_foy_allies[ i ].targetname ) )
        {
            if ( !issubstr( a_foy_allies[ i ].targetname, "sarah" ) )
            {
                a_foy_allies[ i ] dodamage( a_foy_allies[ i ].health + 100, a_foy_allies[ i ].origin );
                wait 0.1;
            }
            
            continue;
        }
        
        a_foy_allies[ i ] dodamage( a_foy_allies[ i ].health + 100, a_foy_allies[ i ].origin );
        wait 0.1;
    }
    
    a_foy_enemies = getaiteamarray( "axis" );
    
    for ( i = 0; i < a_foy_enemies.size ; i++ )
    {
        if ( isalive( a_foy_enemies[ i ] ) )
        {
            if ( isdefined( a_foy_enemies[ i ].script_objective ) )
            {
                if ( a_foy_enemies[ i ].script_objective == "village" )
                {
                    a_foy_enemies[ i ] dodamage( a_foy_enemies[ i ].health + 100, a_foy_enemies[ i ].origin );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace village
// Params 0
// Checksum 0x5e886265, Offset: 0x3e28
// Size: 0x214
function players_gather_in_fold_house()
{
    function_c79f9420();
    trigger::wait_till( "t_foy_house_regroup", "targetname" );
    level thread util::screen_fade_out( 1, "white", "foy_white" );
    util::wait_network_frame();
    level thread cleanup_ai_foldhouse();
    infection_util::turn_off_snow_fx_for_all_players();
    infection_util::enable_exploding_deaths( 0 );
    a_blockers = getentarray( "foy_gather_point_debris_blocker", "targetname" );
    level thread show_blocker( a_blockers );
    level thread scene::play( "p7_fxanim_cp_infection_reverse_transition_wall_bundle" );
    array::thread_all( level.players, &infection_util::player_enter_cinematic );
    
    if ( isdefined( level.bzmutil_waitforallzombiestodie ) )
    {
        [[ level.bzmutil_waitforallzombiestodie ]]();
    }
    
    self thread scene::play( "cin_inf_11_02_fold_1st_airlock_entrance", self );
    level thread village_surreal::function_a1dc825e();
    var_7d116593 = struct::get( "s_village_inception_lighting_hint", "targetname" );
    infection_util::function_7aca917c( var_7d116593.origin );
    level thread util::set_streamer_hint( 11 );
    wait 1.5;
    level thread skipto::objective_completed( "village" );
}

// Namespace village
// Params 0
// Checksum 0x5bdcd06, Offset: 0x4048
// Size: 0x74
function function_c79f9420()
{
    if ( !isdefined( level.var_acfc49b5 ) || !level.var_acfc49b5 )
    {
        level.var_acfc49b5 = 1;
        s_use_pos = struct::get( "s_foy_gather_point_blocker", "targetname" );
        objectives::set( "cp_level_infection_gather_airlock", s_use_pos );
    }
}

// Namespace village
// Params 1
// Checksum 0x55fcb850, Offset: 0x40c8
// Size: 0xaa
function hide_blocker( a_blockers )
{
    foreach ( blocker in a_blockers )
    {
        blocker hide();
        blocker notsolid();
    }
}

// Namespace village
// Params 1
// Checksum 0xce9a5008, Offset: 0x4180
// Size: 0xaa
function show_blocker( a_blockers )
{
    foreach ( blocker in a_blockers )
    {
        blocker show();
        blocker solid();
    }
}

// Namespace village
// Params 0
// Checksum 0xe385156b, Offset: 0x4238
// Size: 0xa4
function random_battle_effects()
{
    trigger::wait_till( "t_village_mortar_2" );
    clientfield::set( "village_mortar_index", 2 );
    trigger::wait_till( "t_village_mortar_3" );
    clientfield::set( "village_mortar_index", 3 );
    trigger::wait_till( "t_village_mortar_4" );
    clientfield::set( "village_mortar_index", 0 );
}

// Namespace village
// Params 2
// Checksum 0xe9139736, Offset: 0x42e8
// Size: 0x6c
function play_fold_start_rumble( n_loops, n_wait )
{
    self endon( #"death" );
    
    for ( i = 0; i < n_loops ; i++ )
    {
        self playrumbleonentity( "cp_infection_fold_start" );
        wait n_wait;
    }
}

// Namespace village
// Params 0
// Checksum 0xfce408c9, Offset: 0x4360
// Size: 0x48
function play_fold_house_rumble()
{
    self endon( #"death" );
    level endon( #"reverse_house_01_done" );
    
    while ( true )
    {
        self playrumbleonentity( "cp_infection_fold_house" );
        wait 0.5;
    }
}

// Namespace village
// Params 0
// Checksum 0x37d4c19a, Offset: 0x43b0
// Size: 0x14c
function fold_start()
{
    level thread scene::play( "p7_fxanim_cp_infection_fold_bundle" );
    e_earthquake_origin = getent( "fold_earthquake_origin", "targetname" );
    assert( isdefined( e_earthquake_origin ), "<dev string:x28>" );
    
    foreach ( player in level.activeplayers )
    {
        player thread play_fold_start_rumble( 3, 0.5 );
    }
    
    wait 3;
    level thread fold_camera_shake( 57, e_earthquake_origin.origin );
    level thread infection_util::slow_nearby_players_for_time( e_earthquake_origin, 3500, 57 );
}

// Namespace village
// Params 2
// Checksum 0xe2fd464a, Offset: 0x4508
// Size: 0x186
function fold_camera_shake( n_duration, e_origin )
{
    earthquake( 0.1, n_duration, e_origin, 10000 );
    n_strong_shake_pause = 6;
    n_strong_shake_iteration = int( n_duration / n_strong_shake_pause ) - 1;
    n_strong_shake_duration_min = 1.4;
    n_strong_shake_duration_max = 1.6;
    n_strong_shake_scale_min = 0.25;
    n_strong_shake_scale_max = 0.28;
    
    for ( i = 0; i <= n_strong_shake_iteration ; i++ )
    {
        wait randomfloatrange( n_strong_shake_pause - 1, n_strong_shake_pause );
        n_strong_shake_duration = randomfloatrange( n_strong_shake_duration_min, n_strong_shake_duration_max );
        n_strong_shake_scale = randomfloatrange( n_strong_shake_scale_min, n_strong_shake_scale_max );
        earthquake( n_strong_shake_scale, n_strong_shake_duration, e_origin, 10000 );
    }
}

// Namespace village
// Params 1
// Checksum 0xbced56b4, Offset: 0x4698
// Size: 0x298
function foy_turret_doors_open( str_door_name )
{
    a_doors = getentarray( str_door_name, "targetname" );
    assert( a_doors.size, "<dev string:x4b>" );
    a_temp_ents = [];
    
    foreach ( m_door in a_doors )
    {
        assert( isdefined( m_door.script_int ), "<dev string:x86>" + m_door.origin + "<dev string:xac>" );
        assert( isdefined( m_door.target ), "<dev string:x86>" + m_door.origin + "<dev string:xf7>" );
        s_rotate = struct::get( m_door.target, "targetname" );
        e_temp = spawn( "script_origin", s_rotate.origin );
        m_door linkto( e_temp );
        e_temp rotateyaw( m_door.script_int, 0.75, 0.2, 0 );
        
        if ( !isdefined( a_temp_ents ) )
        {
            a_temp_ents = [];
        }
        else if ( !isarray( a_temp_ents ) )
        {
            a_temp_ents = array( a_temp_ents );
        }
        
        a_temp_ents[ a_temp_ents.size ] = e_temp;
    }
    
    wait 0.75;
}

// Namespace village
// Params 1
// Checksum 0xc6a6ddf2, Offset: 0x4938
// Size: 0x70
function village_messages( a_ents )
{
    e_sarah = a_ents[ "sarah" ];
    
    if ( isdefined( e_sarah ) )
    {
        e_sarah setteam( "allies" );
    }
    else
    {
        e_sarah = level.players[ 0 ];
    }
    
    level waittill( #"sarah_dialog_starts" );
}

// Namespace village
// Params 0
// Checksum 0xe88edabf, Offset: 0x49b0
// Size: 0x64
function function_880a13df()
{
    level waittill( #"hash_5b12bc4" );
    util::wait_network_frame();
    savegame::checkpoint_save();
    trigger::wait_till( "foy_post_fold_spawn_trigger", "targetname" );
    savegame::checkpoint_save();
}

