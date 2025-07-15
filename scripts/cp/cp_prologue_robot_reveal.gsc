#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_eth_prologue;
#using scripts/cp/cp_mi_eth_prologue_accolades;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_prologue_apc;
#using scripts/cp/cp_prologue_hangars;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace robot_horde;

// Namespace robot_horde
// Params 0
// Checksum 0xcff8e5b1, Offset: 0xdd8
// Size: 0xac
function robot_horde_start()
{
    level robot_horde_precache();
    level robot_horde_heros_init();
    spawner::add_spawn_function_group( "sp_initial_robots", "targetname", &robot_horde );
    spawner::add_spawn_function_group( "robot_aigroup", "script_aigroup", &robot_horde );
    level thread robot_horde_main();
}

// Namespace robot_horde
// Params 0
// Checksum 0x80667d8, Offset: 0xe90
// Size: 0x4c
function robot_horde_precache()
{
    trig_color = getent( "vtol_tackle_color", "targetname" );
    trig_color triggerenable( 0 );
}

// Namespace robot_horde
// Params 0
// Checksum 0x2e087367, Offset: 0xee8
// Size: 0x298
function robot_horde_heros_init()
{
    level.ai_theia ai::set_ignoreall( 1 );
    level.ai_theia ai::set_ignoreme( 1 );
    level.ai_theia.goalradius = 16;
    level.ai_theia.allowpain = 0;
    level.ai_prometheus ai::set_ignoreall( 1 );
    level.ai_prometheus ai::set_ignoreme( 1 );
    level.ai_prometheus.goalradius = 16;
    level.ai_prometheus.allowpain = 0;
    level.ai_hyperion ai::set_ignoreall( 1 );
    level.ai_hyperion ai::set_ignoreme( 1 );
    level.ai_hyperion.goalradius = 16;
    level.ai_hyperion.allowpain = 0;
    level.ai_pallas ai::set_ignoreall( 1 );
    level.ai_pallas ai::set_ignoreme( 1 );
    level.ai_pallas.goalradius = 16;
    level.ai_pallas.allowpain = 0;
    level.ai_hendricks ai::set_ignoreall( 1 );
    level.ai_hendricks ai::set_ignoreme( 1 );
    level.ai_hendricks.goalradius = 16;
    level.ai_khalil ai::set_ignoreall( 1 );
    level.ai_khalil ai::set_ignoreme( 1 );
    level.ai_khalil.goalradius = 16;
    level.ai_minister ai::set_ignoreall( 1 );
    level.ai_minister ai::set_ignoreme( 1 );
    level.ai_minister.goalradius = 16;
}

// Namespace robot_horde
// Params 0
// Checksum 0xb52848ff, Offset: 0x1188
// Size: 0x7b4
function robot_horde_main()
{
    battlechatter::function_d9f49fba( 0 );
    level thread hend_min_khalil_handler();
    level thread cybersoldier_handler();
    level thread clip_ai_garage();
    level thread clip_player_garage();
    level thread function_38c8ec92();
    level thread function_9fb290a5();
    level thread function_94976a83();
    level thread function_4a895a11();
    level thread objectives::breadcrumb( "breadcrumb_robot_horde" );
    level thread function_96157f5d();
    a_ai_allies = cp_prologue_util::get_ai_allies();
    
    foreach ( ai_ally in a_ai_allies )
    {
        ai_ally ai::set_behavior_attribute( "cqb", 1 );
    }
    
    level flag::wait_till( "player_in_alley" );
    cp_prologue_util::cleanup_enemies();
    a_ai_allies = cp_prologue_util::get_ai_allies();
    a_ai_allies[ a_ai_allies.size ] = level.ai_theia;
    a_ai_allies[ a_ai_allies.size ] = level.ai_hendricks;
    a_ai_allies[ a_ai_allies.size ] = level.ai_khalil;
    a_ai_allies[ a_ai_allies.size ] = level.ai_pallas;
    a_ai_allies[ a_ai_allies.size ] = level.ai_hyperion;
    
    foreach ( ai_ally in a_ai_allies )
    {
        ai_ally ai::set_ignoreall( 1 );
        ai_ally ai::set_ignoreme( 1 );
    }
    
    level thread spawn_robot_horde();
    level thread function_59071a25();
    level thread function_f7a7c69a();
    util::delay( 0.5, undefined, &exploder::exploder, "fx_exploder_fog_light_horde" );
    savegame::checkpoint_save();
    level flag::wait_till( "robot_contact" );
    level.ai_theia ai::set_ignoreall( 0 );
    level.ai_pallas ai::set_ignoreall( 0 );
    level.ai_hyperion ai::set_ignoreall( 0 );
    
    foreach ( ai_ally in a_ai_allies )
    {
        ai_ally ai::set_ignoreall( 0 );
        ai_ally thread function_54900cca();
    }
    
    level thread remove_clips();
    wait 8;
    level flag::set( "open_fire" );
    
    foreach ( ai_ally in a_ai_allies )
    {
        ai_ally ai::set_behavior_attribute( "cqb", 0 );
    }
    
    level apc::function_50d6bf35( "vehicle_apc_hijack_node", 0 );
    level thread function_d105c430();
    callback::on_spawned( &function_51a9314a );
    level thread function_51280ee5();
    level flag::wait_till( "garage_open" );
    objectives::complete( "cp_level_prologue_defend_theia", level.ai_prometheus );
    level.garage_door = struct::get( "garage_door", "targetname" );
    objectives::set( "cp_waypoint_breadcrumb", level.garage_door );
    trigger::use( "triggercolor_allies_garage" );
    scene::add_scene_func( "cin_pro_15_01_opendoor_vign_getinside_khalil_minister_hendricks", &function_21350de5, "play" );
    level thread scene::play( "cin_pro_15_01_opendoor_vign_getinside_khalil_minister_hendricks" );
    level waittill( #"hash_e41afc83" );
    level.ai_hendricks setgoal( level.ai_hendricks.origin, 1 );
    level flag::wait_till( "players_in_garage" );
    level flag::wait_till( "allies_in_garage" );
    objectives::complete( "cp_level_prologue_find_vehicle" );
    objectives::set( "cp_level_prologue_goto_exfil" );
    level flag::wait_till( "garage_closed" );
    level flag::wait_till( "minister_apc_done" );
    callback::remove_on_spawned( &function_51a9314a );
    skipto::objective_completed( "skipto_robot_horde" );
}

// Namespace robot_horde
// Params 0
// Checksum 0x5c706a68, Offset: 0x1948
// Size: 0x74
function function_96157f5d()
{
    t_robot_horde_oob = getent( "t_robot_horde_oob", "targetname" );
    
    if ( isdefined( t_robot_horde_oob ) )
    {
        level flag::wait_till( "vo_robot" );
        wait 1.9;
        t_robot_horde_oob triggerenable( 1 );
    }
}

// Namespace robot_horde
// Params 1
// Checksum 0x5d6752c2, Offset: 0x19c8
// Size: 0x54
function function_21350de5( a_ents )
{
    var_94848710 = a_ents[ "minister" ];
    var_94848710 waittill( #"death" );
    level flag::set( "minister_apc_done" );
}

// Namespace robot_horde
// Params 0
// Checksum 0x4aec78af, Offset: 0x1a28
// Size: 0x3c
function function_4a895a11()
{
    level waittill( #"sndStartFakeBattle" );
    wait 1;
    playsoundatposition( "evt_robot_fake_battle", ( 15815, -745, 497 ) );
}

// Namespace robot_horde
// Params 0
// Checksum 0x2cf03a12, Offset: 0x1a70
// Size: 0xa4
function function_94976a83()
{
    trigger::use( "triggercolor_allies_stairs" );
    trigger::wait_till( "triggercolor_alley" );
    trigger::use( "triggercolor_allies_alley" );
    level flag::wait_till( "player_in_alley" );
    trigger::use( "triggercolor_allies_alley" );
    wait 1.5;
    trigger::use( "robot_defend_color_chain1" );
}

// Namespace robot_horde
// Params 0
// Checksum 0x15d23ae6, Offset: 0x1b20
// Size: 0x94
function function_54900cca()
{
    self endon( #"death" );
    level flag::wait_till( "garage_enter" );
    self.ignoresuppression = 1;
    wait 3;
    self ai::set_ignoreall( 1 );
    level flag::wait_till( "allies_in_garage" );
    self.ignoresuppression = 0;
    self ai::set_ignoreall( 0 );
}

// Namespace robot_horde
// Params 0
// Checksum 0x74610c44, Offset: 0x1bc0
// Size: 0x74
function function_59071a25()
{
    trigger::wait_till( "player_inside_garage" );
    level flag::set( "players_in_garage" );
    level thread namespace_21b2c1f2::function_fb0b7bb6();
    objectives::complete( "cp_waypoint_breadcrumb", level.garage_door );
}

// Namespace robot_horde
// Params 0
// Checksum 0x9634bea7, Offset: 0x1c40
// Size: 0x11c
function function_f7a7c69a()
{
    t_entrance = getent( "player_inside_garage", "targetname" );
    a_ai_allies = cp_prologue_util::get_ai_allies();
    
    foreach ( ai_ally in a_ai_allies )
    {
        while ( isalive( ai_ally ) && !ai_ally istouching( t_entrance ) )
        {
            wait 0.1;
        }
    }
    
    level flag::set( "allies_in_garage" );
}

// Namespace robot_horde
// Params 0
// Checksum 0x2df9512e, Offset: 0x1d68
// Size: 0x13c
function spawn_robot_horde()
{
    level flag::wait_till( "spawn_robot_horde" );
    
    if ( isdefined( level.bzm_prologuedialogue5_3callback ) )
    {
        level thread [[ level.bzm_prologuedialogue5_3callback ]]();
    }
    
    spawn_manager::enable( "sm_initial_robots" );
    wait 3;
    spawn_manager::enable( "sm_robot_horde1" );
    wait 1;
    spawn_manager::enable( "sm_robot_horde2" );
    wait 1;
    spawn_manager::enable( "sm_robot_horde3" );
    level flag::wait_till( "players_in_garage" );
    spawn_manager::kill( "sm_initial_robots" );
    spawn_manager::kill( "sm_robot_horde1" );
    spawn_manager::kill( "sm_robot_horde2" );
    spawn_manager::kill( "sm_robot_horde3" );
}

// Namespace robot_horde
// Params 0
// Checksum 0x423552ed, Offset: 0x1eb0
// Size: 0x144
function function_9fb290a5()
{
    struct = struct::get( "sndRobotRattle", "targetname" );
    struct2 = struct::get( struct.target, "targetname" );
    ent = spawn( "script_model", struct.origin );
    
    while ( !flag::get( "players_in_garage" ) )
    {
        ent playsound( "evt_robot_reveal_step" );
        wait 0.3;
        ent clientfield::set( "sndRattle", 1 );
        wait 0.8;
        ent clientfield::set( "sndRattle", 0 );
    }
    
    ent playloopsound( "evt_robot_fake_battle_lp", 5 );
}

// Namespace robot_horde
// Params 0
// Checksum 0x4e76cf15, Offset: 0x2000
// Size: 0x144
function function_51280ee5()
{
    level flag::wait_till( "garage_open" );
    level thread scene::play( "p7_fxanim_cp_prologue_apc_door_01_open_bundle" );
    wait 0.3;
    level thread scene::play( "p7_fxanim_cp_prologue_apc_door_02_open_bundle" );
    trigger::use( "t_motorpool_spawns_enable", "targetname" );
    level flag::wait_till( "players_in_garage" );
    level flag::wait_till( "allies_in_garage" );
    level thread scene::play( "p7_fxanim_cp_prologue_apc_door_01_close_bundle" );
    wait 0.3;
    level flag::set( "garage_closed" );
    level scene::play( "p7_fxanim_cp_prologue_apc_door_02_close_bundle" );
    function_c2619de1();
}

// Namespace robot_horde
// Params 0
// Checksum 0xd70f9f75, Offset: 0x2150
// Size: 0x142
function function_c2619de1()
{
    t_kill_robots_inside_garage = getent( "t_kill_robots_inside_garage", "targetname" );
    a_ai_enemies = getaiteamarray( "axis" );
    
    foreach ( ai_enemy in a_ai_enemies )
    {
        if ( isalive( ai_enemy ) )
        {
            if ( ai_enemy istouching( t_kill_robots_inside_garage ) )
            {
                ai_enemy ai::bloody_death( randomfloat( 0.25 ) );
                continue;
            }
            
            ai_enemy delete();
        }
    }
}

// Namespace robot_horde
// Params 0
// Checksum 0x6d1ece4f, Offset: 0x22a0
// Size: 0x8a
function function_d105c430()
{
    foreach ( player in level.players )
    {
        player thread function_51a9314a();
    }
}

// Namespace robot_horde
// Params 0
// Checksum 0x303967d8, Offset: 0x2338
// Size: 0x74
function function_51a9314a()
{
    self endon( #"death" );
    self.n_attackeraccuracy = self.attackeraccuracy;
    self.attackeraccuracy = 0;
    self thread function_10302408();
    level flag::wait_till( "players_in_garage" );
    self.attackeraccuracy = self.n_attackeraccuracy;
}

// Namespace robot_horde
// Params 0
// Checksum 0xfd0fa3f6, Offset: 0x23b8
// Size: 0x50
function function_10302408()
{
    level endon( #"prometheus_at_apc" );
    self endon( #"death" );
    
    while ( self.attackeraccuracy < 1 )
    {
        wait 1;
        self.attackeraccuracy += 0.1;
    }
}

// Namespace robot_horde
// Params 0
// Checksum 0xcdd7cb1c, Offset: 0x2410
// Size: 0x98
function robot_horde()
{
    level endon( #"garage_closed" );
    self endon( #"death" );
    self.goalradius = 32;
    self thread function_e583f6c3();
    self thread robot_stop();
    self thread robot_speed();
    self waittill( #"goal" );
    self.goalradius = 2048;
    wait 3;
    self.perfectaim = 1;
}

// Namespace robot_horde
// Params 0
// Checksum 0xc55137e8, Offset: 0x24b0
// Size: 0x64
function robot_stop()
{
    self endon( #"death" );
    level flag::wait_till( "garage_closed" );
    self setgoal( self.origin, 1 );
    self ai::set_ignoreall( 1 );
}

// Namespace robot_horde
// Params 0
// Checksum 0x62eaf59b, Offset: 0x2520
// Size: 0x54
function robot_speed()
{
    self endon( #"death" );
    level flag::wait_till( "garage_open" );
    wait 5;
    self ai::set_behavior_attribute( "move_mode", "marching" );
}

// Namespace robot_horde
// Params 0
// Checksum 0x9d459a34, Offset: 0x2580
// Size: 0x64
function function_e583f6c3()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    level flag::wait_till( "open_fire" );
    wait 3;
    self ai::set_ignoreall( 0 );
}

// Namespace robot_horde
// Params 0
// Checksum 0xf5a19524, Offset: 0x25f0
// Size: 0x1a2
function hend_min_khalil_handler()
{
    level.ai_hendricks colors::disable();
    level.ai_khalil colors::disable();
    level.ai_minister colors::disable();
    level.ai_hendricks thread function_85de96a6( "hendricks" );
    level.ai_khalil thread function_85de96a6( "khalil" );
    level.ai_minister thread function_85de96a6( "minister" );
    util::waittill_multiple( "hendricks_ready", "khalil_ready", "minister_ready" );
    level flag::wait_till( "goto_alley" );
    level thread scene::play( "cin_pro_14_01_robothorde_vign_dismantle" );
    level.ai_hendricks clearforcedgoal();
    level.ai_khalil clearforcedgoal();
    level.ai_minister clearforcedgoal();
    level thread function_20e7e38e();
    level flag::wait_till( "prometheus_stop_directing" );
    level notify( #"hash_8f3f5759" );
}

// Namespace robot_horde
// Params 1
// Checksum 0x55cd2ddb, Offset: 0x27a0
// Size: 0x7c
function function_85de96a6( str_name )
{
    nd_goal = getnode( str_name + "_robot_entry", "targetname" );
    self setgoal( nd_goal, 1 );
    self waittill( #"goal" );
    level notify( str_name + "_ready" );
}

// Namespace robot_horde
// Params 0
// Checksum 0xd926897, Offset: 0x2828
// Size: 0x84
function function_20e7e38e()
{
    self endon( #"hash_8f3f5759" );
    wait 5;
    level.ai_hendricks dialog::say( "hend_c_mon_exfil_s_just_0" );
    wait 5;
    level.ai_hendricks dialog::say( "hend_we_gotta_get_the_min_0" );
    wait 5;
    level.ai_hendricks dialog::say( "hend_we_can_t_miss_our_pi_0" );
}

// Namespace robot_horde
// Params 0
// Checksum 0xfb3bec18, Offset: 0x28b8
// Size: 0x244
function cybersoldier_handler()
{
    level thread function_c091ae43();
    level thread function_82869bf4();
    level thread function_f4e0744a();
    level thread scene::add_scene_func( "cin_pro_14_01_robothorde_vign_directing", &taylor_direct, "play" );
    
    if ( !level flag::get( "prom_point" ) )
    {
        level thread scene::play( "cin_pro_14_01_robothorde_vign_directing" );
        level flag::wait_till( "taylor_direct" );
    }
    
    level flag::wait_till( "prom_point" );
    level scene::play( "cin_pro_14_01_robothorde_vign_directing_pointing" );
    
    if ( !level flag::get( "prometheus_stop_directing" ) )
    {
        level thread scene::play( "cin_pro_14_01_robothorde_vign_directing" );
    }
    
    level flag::wait_till( "spawn_robot_horde" );
    wait 2;
    level thread scene::play( "cin_pro_14_01_robothorde_vign_dismantle_new_prometheus" );
    level waittill( #"prometheus_hacking" );
    objectives::set( "cp_level_prologue_defend_theia", level.ai_prometheus );
    level flag::wait_till( "garage_open" );
    level scene::play( "cin_pro_15_01_opendoor_vign_getinside_new_prometheus_move" );
    level.ai_prometheus setgoal( level.ai_prometheus.origin, 1 );
}

// Namespace robot_horde
// Params 1
// Checksum 0x119aa1f2, Offset: 0x2b08
// Size: 0x2c
function taylor_direct( a_ents )
{
    level flag::set( "taylor_direct" );
}

// Namespace robot_horde
// Params 0
// Checksum 0x16046980, Offset: 0x2b40
// Size: 0x64
function function_c091ae43()
{
    level thread scene::play( "cin_pro_14_01_robothorde_vign_dismantle_theia" );
    level flag::wait_till( "garage_open" );
    level thread scene::play( "cin_pro_14_01_robothorde_vign_dismantle_theia_shoot" );
}

// Namespace robot_horde
// Params 0
// Checksum 0xaf16bbf5, Offset: 0x2bb0
// Size: 0x64
function function_82869bf4()
{
    level thread scene::play( "cin_pro_14_01_robothorde_vign_dismantle_diaz" );
    level flag::wait_till( "garage_open" );
    level thread scene::play( "cin_pro_14_01_robothorde_vign_dismantle_diaz_shoot" );
}

// Namespace robot_horde
// Params 0
// Checksum 0xa250517e, Offset: 0x2c20
// Size: 0x64
function function_f4e0744a()
{
    level thread scene::play( "cin_pro_14_01_robothorde_vign_dismantle_maretti" );
    level flag::wait_till( "garage_open" );
    level thread scene::play( "cin_pro_14_01_robothorde_vign_dismantle_maretti_shoot" );
}

// Namespace robot_horde
// Params 0
// Checksum 0x1402ea2b, Offset: 0x2c90
// Size: 0x394
function function_38c8ec92()
{
    level endon( #"hash_e41afc83" );
    e_pa = getent( "pa_nrc_warning", "targetname" );
    e_pa dialog::say( "nrcp_warning_nrc_grunt_i_0", 0, 1 );
    level flag::wait_till( "player_in_alley" );
    function_e3231637( 1 );
    level.ai_hyperion dialog::say( "mare_you_guys_hear_tha_0", 0.5 );
    level.ai_pallas dialog::say( "diaz_you_re_hearing_thing_0", 0.5 );
    level flag::set( "spawn_robot_horde" );
    level thread namespace_21b2c1f2::function_448421b7();
    level.ai_hyperion dialog::say( "mare_hey_fuck_you_0", 0.5 );
    level.ai_hendricks dialog::say( "hend_shut_up_i_hear_it_t_0", 0.5 );
    level flag::set( "robot_contact" );
    level.ai_hendricks dialog::say( "hend_holy_shit_0", 0.5 );
    level.ai_hyperion dialog::say( "mare_contact_contact_0", 0.5 );
    wait 0.5;
    function_e3231637( 0 );
    level.ai_pallas dialog::say( "diaz_incoming_bots_a_s_0", 0.5 );
    level.ai_prometheus dialog::say( "tayr_we_need_that_door_op_0", 0.5 );
    level.ai_prometheus dialog::say( "tayr_give_us_some_cover_f_0" );
    level flag::set( "garage_open" );
    level.ai_prometheus dialog::say( "tayr_get_inside_go_go_0", 0.6 );
    level.ai_hyperion dialog::say( "mare_get_to_the_extract_0", 1 );
    level.ai_hyperion dialog::say( "mare_we_ll_deal_with_robo_0", 0.35 );
    level.ai_theia dialog::say( "hall_get_the_minister_ins_0", 0.5 );
    level thread namespace_21b2c1f2::function_37a511a();
    
    if ( !level flag::get( "players_in_garage" ) && !sessionmodeiscampaignzombiesgame() )
    {
        level thread function_f0042481();
    }
}

// Namespace robot_horde
// Params 1
// Checksum 0x85e235f0, Offset: 0x3030
// Size: 0xca
function function_e3231637( var_8a4b0c9 )
{
    if ( isdefined( level.var_681ad194 ) )
    {
        foreach ( e_soldier in level.var_681ad194 )
        {
            e_soldier ai::set_pacifist( var_8a4b0c9 );
            
            if ( var_8a4b0c9 )
            {
                wait randomfloatrange( 0.1, 0.75 );
            }
        }
    }
}

// Namespace robot_horde
// Params 0
// Checksum 0x3f3e2563, Offset: 0x3108
// Size: 0xf4
function function_f0042481()
{
    level endon( #"players_in_garage" );
    wait 4;
    level.ai_prometheus dialog::say( "tayr_you_re_dead_out_ther_0" );
    wait 5;
    level.ai_prometheus dialog::say( "tayr_we_gotta_move_come_0" );
    wait 5;
    level.ai_prometheus dialog::say( "tayr_drone_s_almost_here_0" );
    wait 5;
    level notify( #"failed" );
    spawn_manager::kill( "sm_robot_horde1" );
    spawn_manager::kill( "sm_robot_horde2" );
    spawn_manager::kill( "sm_robot_horde3" );
    util::missionfailedwrapper_nodeath( &"CP_MI_ETH_PROLOGUE_GARAGE_FAIL" );
}

// Namespace robot_horde
// Params 1
// Checksum 0xb71bde2e, Offset: 0x3208
// Size: 0x6c
function set_cyber_soliders_goal( ent )
{
    level.ai_pallas setgoal( level.ai_pallas.origin, 1 );
    level.ai_hyperion setgoal( level.ai_hyperion.origin, 1 );
}

// Namespace robot_horde
// Params 0
// Checksum 0xc662dff4, Offset: 0x3280
// Size: 0xd2
function remove_clips()
{
    level flag::wait_till( "cyber_soldiers_kill_robots" );
    clips = getentarray( "robot_clip", "targetname" );
    
    foreach ( clip in clips )
    {
        clip delete();
    }
}

// Namespace robot_horde
// Params 0
// Checksum 0x7a7801c4, Offset: 0x3360
// Size: 0xf4
function clip_player_garage()
{
    e_lift_door = getent( "clip_player_garage", "targetname" );
    e_lift_door movez( 200 * -1, 0.05 );
    level flag::wait_till( "garage_open" );
    e_lift_door movez( 200, 2 );
    e_lift_door waittill( #"movedone" );
    level flag::wait_till( "players_in_garage" );
    e_lift_door movez( 200 * -1, 0.05 );
}

// Namespace robot_horde
// Params 0
// Checksum 0x58e01218, Offset: 0x3460
// Size: 0xf4
function clip_ai_garage()
{
    mdl_clip = getent( "clip_ai_garage", "targetname" );
    level flag::wait_till( "garage_open" );
    mdl_clip notsolid();
    mdl_clip connectpaths();
    level flag::set( "garage_enter" );
    level flag::wait_till( "garage_closed" );
    wait 1;
    mdl_clip solid();
    mdl_clip disconnectpaths();
}

