#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_vengeance_garage;
#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_temple;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/stealth;
#using scripts/shared/stealth_status;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace vengeance_dogleg_2;

// Namespace vengeance_dogleg_2
// Params 2
// Checksum 0x48ca5965, Offset: 0xb08
// Size: 0x2ac
function skipto_dogleg_2_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        vengeance_util::skipto_baseline( str_objective, b_starting );
        level thread namespace_9fd035::function_e18f629a();
        callback::on_spawned( &vengeance_util::give_hero_weapon );
        vengeance_util::init_hero( "hendricks", str_objective );
        objectives::set( "cp_level_vengeance_rescue_kane" );
        objectives::set( "cp_level_vengeance_go_to_safehouse" );
        level thread vengeance_util::function_cc6f3598();
        level thread vengeance_util::function_936cf9d0();
        level.ai_hendricks setgoal( level.ai_hendricks.origin, 1 );
        s_anim_node = struct::get( "tag_align_dogleg_2", "targetname" );
        s_anim_node thread scene::play( "cin_ven_05_65_deadcivilians_vign" );
        level thread objectives::breadcrumb( "dogleg_2_upstairs" );
        load::function_a2995f22();
        level thread vengeance_temple::function_29e96a35();
        trigger::use( "temple_video" );
        level flag::set( "dogleg_2_begin" );
    }
    
    vengeance_util::function_4e8207e9( "dogleg_2" );
    level.ai_hendricks.goalradius = 12;
    level.ai_hendricks battlechatter::function_d9f49fba( 0 );
    level.ai_hendricks stealth::init();
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
    level.ai_hendricks colors::disable();
    dogleg_2_main( str_objective, b_starting );
}

// Namespace vengeance_dogleg_2
// Params 4
// Checksum 0xddb5ab6b, Offset: 0xdc0
// Size: 0x58c
function skipto_dogleg_2_done( str_objective, b_starting, b_direct, player )
{
    array::run_all( getcorpsearray(), &delete );
    s_anim_node = struct::get( "tag_align_dogleg_2", "targetname" );
    s_anim_node thread scene::stop( "cin_ven_05_65_deadcivilians_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_60_officedoor_1st" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_60_officedoor_1st_shared" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_65_deadcivilians_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_70_dogleg2_takedown_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_80_office_convo_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_23_slicendice_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_23_slicendice_civdeath_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_24_execution_lineup_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_24_execution_lineup_civdeath_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_26_beatdown_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_26_beatdown_civdeath_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_10_cafedoor_3rd_sh090" );
    level struct::delete_script_bundle( "scene", "cin_ven_04_10_cafedoor_1st_sh100" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_21_rocksmash_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_21_rocksmash_enemyreact_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_21_rocksmash_civdeath_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_22_drowncivilian_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_22_drowncivilian_enemyreact_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_22_drowncivilian_civdeath_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_27_ammorestock_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_27_ammorestock_enemyreact_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_28_grassstomp_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_28_grassstomp_civdeath_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_29_rail_beatdown_civdeath_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_29_rail_beatdown_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_29_rail_beatdown_enemyreact_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_32_wall_beatdown_civdeath_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_32_wall_beatdown_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_32_wall_beatdown_enemyreact_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_05_20_pond_floaters_vign" );
    level struct::delete_script_bundle( "scene", "cin_ven_gen_grenade_throw_a" );
    vengeance_util::function_4e8207e9( "dogleg_2", 0 );
}

// Namespace vengeance_dogleg_2
// Params 2
// Checksum 0x4220cf44, Offset: 0x1358
// Size: 0x254
function dogleg_2_main( str_objective, b_starting )
{
    objectives::show( "cp_level_vengeance_go_to_safehouse" );
    level thread function_b4520466();
    level thread dogleg_2_vo();
    vengeance_util::function_e00864bd( "office_umbra_gate", 1, "office_gate" );
    s_anim_node = struct::get( "tag_align_dogleg_2", "targetname" );
    trigger::wait_till( "dogleg_2_upstairs", "targetname" );
    
    if ( !level flag::get( "temple_stealth_broken" ) && !b_starting )
    {
        s_anim_node scene::play( "cin_ven_05_70_dogleg2_takedown_vign" );
    }
    else
    {
        s_anim_node thread scene::play( "cin_ven_05_80_office_convo_vign" );
    }
    
    level thread util::set_streamer_hint( 4 );
    vengeance_garage::garage_igc_scene_setup();
    s_anim_node = struct::get( "garage_igc_script_node", "targetname" );
    s_anim_node thread scene::init( "cin_ven_06_15_parkingstructure_deadbodies" );
    s_anim_node scene::init( "cin_ven_06_10_parkingstructure_1st_shot01" );
    level.ai_hendricks waittill( #"idle_started" );
    level thread function_8aac7e91();
    trigger::wait_till( "dogleg_2_near_end", "targetname" );
    level flag::set( "dogleg_2_at_end" );
    level waittill( #"hash_42cabc57" );
    skipto::objective_completed( "dogleg_2" );
}

// Namespace vengeance_dogleg_2
// Params 0
// Checksum 0x3aa06dc9, Offset: 0x15b8
// Size: 0x104
function dogleg_2_vo()
{
    level waittill( #"hash_e910cb50" );
    level thread namespace_9fd035::function_e6a33cb1();
    level vengeance_util::function_ee75acde( "kane_the_safe_house_has_b_0" );
    level waittill( #"hash_5b5c6225" );
    level vengeance_util::function_ee75acde( "kane_i_m_falling_back_to_0" );
    level waittill( #"hash_58c2cd5a" );
    level vengeance_util::function_ee75acde( "kane_taylor_did_he_cont_0" );
    level waittill( #"hash_32f1242d" );
    playsoundatposition( "evt_sh_breach", ( 0, 0, 0 ) );
    level vengeance_util::function_ee75acde( "kane_static_1" );
    level waittill( #"hash_e8162863" );
    level dialog::player_say( "plyr_no_this_is_someth_0" );
}

// Namespace vengeance_dogleg_2
// Params 0
// Checksum 0xe4e8a0e, Offset: 0x16c8
// Size: 0x34
function function_8aac7e91()
{
    level endon( #"hash_42cabc57" );
    wait 25;
    level.ai_hendricks vengeance_util::function_5fbec645( "hend_check_that_balcony_1" );
}

// Namespace vengeance_dogleg_2
// Params 0
// Checksum 0x89e5cffa, Offset: 0x1708
// Size: 0x12c
function function_b4520466()
{
    e_end_trigger = getent( "dogleg_2_door_trigger", "targetname" );
    e_end_trigger triggerenable( 0 );
    level flag::wait_till( "dogleg_2_at_end" );
    e_end_trigger triggerenable( 1 );
    objectives::hide( "cp_level_vengeance_go_to_safehouse" );
    e_door_use_object = util::init_interactive_gameobject( e_end_trigger, &"cp_prompt_enter_ven_door", &"CP_MI_SING_VENGEANCE_HINT_OPEN", &function_f476518d );
    objectives::set( "cp_level_vengeance_open_dogleg_2_exit_menu" );
    level waittill( #"hash_42cabc57" );
    e_door_use_object gameobjects::disable_object();
    objectives::hide( "cp_level_vengeance_open_dogleg_2_exit_menu" );
}

// Namespace vengeance_dogleg_2
// Params 1
// Checksum 0x8d587180, Offset: 0x1840
// Size: 0x28
function function_f476518d( e_player )
{
    level notify( #"hash_42cabc57" );
    level.var_e82cf2ee = e_player;
}

