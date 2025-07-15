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
#using scripts/cp/cp_prologue_bridge;
#using scripts/cp/cp_prologue_cyber_soldiers;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
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

#namespace hangar;

// Namespace hangar
// Params 0
// Checksum 0x1b8199d1, Offset: 0x1ac8
// Size: 0x9c
function hangar_start()
{
    hangar_precache();
    hangar_heros_init();
    spawner::add_spawn_function_group( "hangar01_balcony_ai", "script_noteworthy", &ai_think );
    spawner::add_spawn_function_group( "catwalk_stair_enemy", "targetname", &ai_ignore_then_move );
    level thread hangar_main();
}

// Namespace hangar
// Params 0
// Checksum 0x5eb40e3e, Offset: 0x1b70
// Size: 0x9c
function hangar_precache()
{
    flag::init( "alert_plane_hangar_enemies" );
    level flag::init( "plane_hangar_hendricks_ready_flag" );
    level flag::init( "plane_hangar_khalil_ready_flag" );
    level flag::init( "plane_hangar_minister_ready_flag" );
    level flag::init( "fireflies_used" );
}

// Namespace hangar
// Params 0
// Checksum 0x781cc63c, Offset: 0x1c18
// Size: 0x2f8
function hangar_heros_init()
{
    level.ai_prometheus ai::set_ignoreall( 1 );
    level.ai_prometheus ai::set_ignoreme( 1 );
    level.ai_prometheus.goalradius = 16;
    level.ai_theia ai::set_ignoreall( 1 );
    level.ai_theia ai::set_ignoreme( 1 );
    level.ai_theia.goalradius = 16;
    level.ai_theia.allowpain = 0;
    level.ai_theia colors::set_force_color( "c" );
    level.ai_pallas ai::set_ignoreall( 1 );
    level.ai_pallas ai::set_ignoreme( 1 );
    level.ai_pallas.goalradius = 16;
    level.ai_pallas.allowpain = 0;
    level.ai_pallas colors::set_force_color( "o" );
    level.ai_hyperion ai::set_ignoreall( 1 );
    level.ai_hyperion ai::set_ignoreme( 1 );
    level.ai_hyperion.goalradius = 16;
    level.ai_hyperion.allowpain = 0;
    level.ai_hyperion colors::set_force_color( "p" );
    level.ai_hendricks ai::set_ignoreall( 1 );
    level.ai_hendricks ai::set_ignoreme( 1 );
    level.ai_hendricks.goalradius = 16;
    level.ai_hendricks.allowpain = 0;
    level.ai_khalil ai::set_ignoreall( 1 );
    level.ai_khalil ai::set_ignoreme( 1 );
    level.ai_khalil.goalradius = 16;
    level.ai_minister ai::set_ignoreall( 1 );
    level.ai_minister ai::set_ignoreme( 1 );
    level.ai_minister.goalradius = 16;
}

// Namespace hangar
// Params 0
// Checksum 0xbdaf13ed, Offset: 0x1f18
// Size: 0x1fc
function hangar_main()
{
    level thread hangar_vtol_flyby();
    level thread scene::init( "p7_fxanim_cp_prologue_hangar_window_rip_bundle" );
    level thread namespace_21b2c1f2::function_46333a8a();
    level util::clientnotify( "sndStartFakeBattle" );
    level thread function_6ad5d018();
    level thread allied_ai_movements();
    level thread function_4cf04b95();
    level thread function_30b7d0f9();
    level thread function_b439650f();
    level thread function_644150a();
    vehicle::add_spawn_function( "vtol_collapse_apc_initial", &function_75381a71 );
    level.var_fac57550 = vehicle::simple_spawn_single( "vtol_collapse_apc_initial" );
    wait 0.15;
    level.ai_hendricks thread function_d418516( level.var_fac57550 );
    level.ai_khalil thread function_d418516( level.var_fac57550 );
    level.ai_pallas thread pallas_jump_hangar();
    function_e966c1c0( 0 );
    level flag::wait_till( "plane_hangar_complete" );
    skipto::objective_completed( "skipto_hangar" );
}

// Namespace hangar
// Params 0
// Checksum 0xdd6fd973, Offset: 0x2120
// Size: 0x74
function function_b439650f()
{
    level endon( #"hash_71456dc2" );
    wait 60;
    level flag::set( "move_plane_hangar_vehicles" );
    level flag::set( "move_plane_hangar_enemies" );
    wait 60;
    level flag::set( "move_catwalk_enemies" );
}

// Namespace hangar
// Params 0
// Checksum 0xef3dd4eb, Offset: 0x21a0
// Size: 0x122
function function_75381a71()
{
    wait 1;
    
    foreach ( ai_rider in self.riders )
    {
        ai_rider thread util::magic_bullet_shield();
    }
    
    level waittill( #"hash_7452e7a8" );
    
    foreach ( ai_rider in self.riders )
    {
        ai_rider thread util::stop_magic_bullet_shield();
    }
}

// Namespace hangar
// Params 0
// Checksum 0x536c3bd3, Offset: 0x22d0
// Size: 0x54
function hangar_vtol_flyby()
{
    self endon( #"hash_d11bfa2f" );
    level flag::wait_till( "hangar_vtol_flyby" );
    level thread cp_prologue_util::function_42da021e( "vh_vtol_flyby", 119, 100 );
}

// Namespace hangar
// Params 0
// Checksum 0x40143cba, Offset: 0x2330
// Size: 0x364
function function_4cf04b95()
{
    spawner::add_spawn_function_group( "aig_plane_hangar_enemies_main", "script_aigroup", &cp_prologue_util::remove_grenades );
    level flag::wait_till( "spawn_plane_hangar_enemies" );
    spawner::simple_spawn( "catwalk_window_enemies", &function_55a0215c );
    spawner::simple_spawn( "shooter_enemy", &function_c9e0c14b );
    var_a2da570f = spawner::simple_spawn( "sp_plane_hangar_initial_right", &function_4514b4cf );
    var_c5fb606f = getent( "plane_hangar_goal_vol_right_1", "targetname" );
    var_53f3f134 = getent( "plane_hangar_goal_vol_right_2", "targetname" );
    var_79f66b9d = getent( "plane_hangar_goal_vol_rear_2", "targetname" );
    array::thread_all( var_a2da570f, &function_fb6ce428, var_c5fb606f, var_53f3f134, var_79f66b9d );
    
    if ( level.players.size > 2 )
    {
        var_e39e4320 = spawner::simple_spawn( "sp_plane_hangar_initial_left", &function_4514b4cf );
        var_48c65824 = getent( "plane_hangar_goal_vol_left_1", "targetname" );
        var_bacdc75f = getent( "plane_hangar_goal_vol_left_2", "targetname" );
        var_94cb4cf6 = getent( "plane_hangar_goal_vol_rear_2", "targetname" );
        array::thread_all( var_e39e4320, &function_fb6ce428, var_48c65824, var_bacdc75f, var_94cb4cf6 );
    }
    
    level thread function_8f45c05e();
    array::thread_all( level.players, &function_2af9c6c4 );
    spawner::add_spawn_function_group( "catwalk_battle_enemy_wave2", "targetname", &function_147616e2 );
    level flag::wait_till( "alert_plane_hangar_enemies" );
    savegame::checkpoint_save();
    spawn_manager::enable( "catwalk_enemy_wave2" );
    level thread function_2810938e();
}

// Namespace hangar
// Params 0
// Checksum 0x25d4e8f3, Offset: 0x26a0
// Size: 0xe4
function function_4514b4cf()
{
    self endon( #"death" );
    self.goalradius = 16;
    self setgoal( self.origin, 1 );
    self setignoreent( level.ai_pallas, 1 );
    level.ai_pallas setignoreent( self, 1 );
    level flag::wait_till( "plane_hangar_enemies_fallback1" );
    wait 5;
    self setignoreent( level.ai_pallas, 0 );
    level.ai_pallas setignoreent( self, 0 );
}

// Namespace hangar
// Params 0
// Checksum 0x87fb2dcb, Offset: 0x2790
// Size: 0x2c
function function_8f45c05e()
{
    level waittill( #"window_broken" );
    level flag::set( "alert_plane_hangar_enemies" );
}

// Namespace hangar
// Params 0
// Checksum 0x3ad81d57, Offset: 0x27c8
// Size: 0x2c
function function_2af9c6c4()
{
    self waittill( #"weapon_fired" );
    level flag::set( "alert_plane_hangar_enemies" );
}

// Namespace hangar
// Params 3
// Checksum 0xa8f46499, Offset: 0x2800
// Size: 0x18c
function function_fb6ce428( var_3cee21ba, var_16eba751, var_f0e92ce8 )
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self setgoal( self.origin );
    level flag::wait_till( "alert_plane_hangar_enemies" );
    self ai::set_ignoreall( 0 );
    self setgoal( var_3cee21ba );
    level flag::wait_till( "plane_hangar_enemies_fallback1" );
    self ai::set_ignoreall( 1 );
    self setgoal( var_16eba751 );
    self waittill( #"goal" );
    self ai::set_ignoreall( 0 );
    level flag::wait_till( "plane_hangar_enemies_fallback2" );
    self ai::set_ignoreall( 1 );
    self setgoal( var_f0e92ce8 );
    self waittill( #"goal" );
    self ai::set_ignoreall( 0 );
}

// Namespace hangar
// Params 0
// Checksum 0xb97cf20e, Offset: 0x2998
// Size: 0xbc
function function_147616e2()
{
    self endon( #"death" );
    var_5136eb95 = getent( "plane_hangar_goal_vol_rear_1", "targetname" );
    var_773965fe = getent( "plane_hangar_goal_vol_rear_2", "targetname" );
    self setgoal( var_5136eb95 );
    level flag::wait_till( "plane_hangar_enemies_fallback2" );
    self setgoal( var_773965fe );
}

// Namespace hangar
// Params 0
// Checksum 0x123bb60d, Offset: 0x2a60
// Size: 0x1b4
function function_c9e0c14b()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self setgoal( self.origin );
    self.goalradius = 16;
    level flag::wait_till( "alert_plane_hangar_enemies" );
    self ai::set_ignoreall( 0 );
    var_bd827604 = struct::get( "plane_hangar_window", "targetname" );
    var_6c9f55e = util::get_closest_player( var_bd827604.origin, "allies" );
    self ai::shoot_at_target( "normal", var_6c9f55e, undefined, 5 );
    var_c5fb606f = getent( "plane_hangar_goal_vol_right_1", "targetname" );
    var_53f3f134 = getent( "plane_hangar_goal_vol_right_2", "targetname" );
    var_79f66b9d = getent( "plane_hangar_goal_vol_right_3", "targetname" );
    self function_fb6ce428( var_c5fb606f, var_53f3f134, var_79f66b9d );
}

// Namespace hangar
// Params 0
// Checksum 0xeacd336a, Offset: 0x2c20
// Size: 0xcc
function function_55a0215c()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self setgoal( self.origin, 1 );
    level flag::wait_till( "move_catwalk_enemies" );
    n_goal = getnode( self.script_noteworthy, "targetname" );
    self setgoal( n_goal, 1 );
    self waittill( #"goal" );
    self ai::set_ignoreall( 0 );
}

// Namespace hangar
// Params 3
// Checksum 0xbf01e4a, Offset: 0x2cf8
// Size: 0xbc
function function_4ee77dbb( vehiclename, name, targets )
{
    ai_rider = vehiclename vehicle::get_rider( name );
    
    if ( isdefined( ai_rider ) )
    {
        ai_rider thread vehicle::get_out();
        ai_rider thread function_4514b4cf();
        
        if ( targets.size == 3 )
        {
            ai_rider thread function_fb6ce428( targets[ 0 ], targets[ 1 ], targets[ 2 ] );
        }
    }
}

// Namespace hangar
// Params 0
// Checksum 0x9fe58d83, Offset: 0x2dc0
// Size: 0x354
function function_30b7d0f9()
{
    var_c2777dd9 = "p7_fxanim_cp_prologue_hangar_doors_03_bundle";
    level thread scene::init( var_c2777dd9 );
    level flag::wait_till( "spawn_plane_hangar_enemies" );
    vh_jeep = vehicle::simple_spawn_single( "plane_hangar_jeep" );
    var_a9993ca4 = vehicle::simple_spawn_single( "plane_hangar_flatbed" );
    vh_jeep vehicle::get_on_path( vh_jeep.target );
    var_a9993ca4 vehicle::get_on_path( var_a9993ca4.target );
    level flag::wait_till( "move_plane_hangar_vehicles" );
    vh_jeep thread vehicle::go_path();
    vh_jeep thread function_28d41b1d();
    vh_jeep playsound( "evt_hangar_jeep_driveaway" );
    wait 1;
    var_280d5f68 = getent( "plane_hangar_gate_l", "targetname" );
    var_3c301126 = getent( "plane_hangar_gate_r", "targetname" );
    var_9c7511b4 = struct::get( "plane_hangar_gate_move_pos_l", "targetname" );
    var_205c499a = struct::get( "plane_hangar_gate_move_pos_r", "targetname" );
    level thread hangar_gate_close( 0, var_280d5f68, var_3c301126, var_9c7511b4, var_205c499a, var_c2777dd9, "umbra_gate_hangar_03" );
    var_a9993ca4 thread vehicle::go_path();
    var_a9993ca4 playsound( "evt_hangar_truck_drivestop" );
    var_a9993ca4 waittill( #"reached_end_node" );
    var_9b59c867[ 0 ] = getent( "plane_hangar_goal_vol_right_1", "targetname" );
    var_9b59c867[ 1 ] = getent( "plane_hangar_goal_vol_right_2", "targetname" );
    var_9b59c867[ 2 ] = getent( "plane_hangar_goal_vol_right_3", "targetname" );
    function_4ee77dbb( var_a9993ca4, "driver", var_9b59c867 );
    function_4ee77dbb( var_a9993ca4, "passenger1", var_9b59c867 );
}

// Namespace hangar
// Params 0
// Checksum 0xd81ba7e5, Offset: 0x3120
// Size: 0xe4
function function_28d41b1d()
{
    self endon( #"death" );
    self waittill( #"reached_end_node" );
    ai_driver = self vehicle::get_rider( "driver" );
    ai_rider = self vehicle::get_rider( "passenger1" );
    ai_driver delete();
    ai_rider delete();
    self.delete_on_death = 1;
    self notify( #"death" );
    
    if ( !isalive( self ) )
    {
        self delete();
    }
}

// Namespace hangar
// Params 0
// Checksum 0x72c6d307, Offset: 0x3210
// Size: 0x1ec
function function_2810938e()
{
    self endon( #"hash_d11bfa2f" );
    level flag::wait_till( "alert_plane_hangar_enemies" );
    level thread function_ed437e33();
    level flag::wait_till( "plane_hangar_enemies_fallback3" );
    spawn_manager::kill( "catwalk_enemy_wave2" );
    var_bfff0f24 = getentarray( "plane_hangar_enemies", "script_noteworthy", 1 );
    var_1d61ec5e = struct::get( "plane_to_vtol_fallback_origin", "targetname" );
    var_f6f0207c = array::get_all_closest( var_1d61ec5e.origin, var_bfff0f24, undefined, 10 );
    level thread function_19352a82( var_f6f0207c );
    var_46b9d820 = getent( "trig_vtol_goal_vol_rear", "targetname" );
    
    for ( i = 0; i < var_f6f0207c.size ; i++ )
    {
        var_f6f0207c[ i ] setgoal( var_46b9d820 );
    }
    
    function_e966c1c0( 1 );
    wait 5;
    trigger::use( "plane_hangar_empty_color_allies", "targetname" );
}

// Namespace hangar
// Params 0
// Checksum 0x248ea2a7, Offset: 0x3408
// Size: 0x4c
function function_ed437e33()
{
    spawner::waittill_ai_group_ai_count( "aig_plane_hangar_enemies_main", 5 );
    level flag::set( "plane_hangar_enemies_fallback3" );
}

// Namespace hangar
// Params 1
// Checksum 0x8c3bcf3, Offset: 0x3460
// Size: 0x9c
function function_f1b38a6e( var_234899cf )
{
    var_e70be898 = self.origin;
    wait 10;
    
    if ( distancesquared( self.origin, var_e70be898 ) < 262144 )
    {
        nd_goal = getnode( var_234899cf, "targetname" );
        self forceteleport( nd_goal.origin );
    }
}

// Namespace hangar
// Params 0
// Checksum 0x17b2896e, Offset: 0x3508
// Size: 0x38c
function allied_ai_movements()
{
    level.ai_khalil ai::set_behavior_attribute( "vignette_mode", "off" );
    level.ai_minister ai::set_behavior_attribute( "vignette_mode", "off" );
    level.ai_hendricks colors::enable();
    trigger::use( "hangar_move_friendlies_1", "targetname" );
    level.ai_khalil thread function_f1b38a6e( "node_cyber_khalil" );
    level.ai_minister thread function_f1b38a6e( "node_cyber_minister" );
    level flag::wait_till( "trig_hangar01_enemies" );
    wait 4.5;
    level.ai_hendricks colors::disable();
    level.ai_khalil colors::disable();
    level.ai_minister colors::disable();
    level.ai_hendricks thread function_3683e3dd( "cin_pro_10_01_hangar_vign_traverse_hendricks_start_idle" );
    wait 1;
    level.ai_khalil thread function_7ae90dbb( "cin_pro_10_01_hangar_vign_traverse_khalil_start_idle" );
    wait 2.5;
    level.ai_minister thread function_7a87693b( "cin_pro_10_01_hangar_vign_traverse_minister_start_idle" );
    level thread function_bae363ed();
    level flag::wait_till( "pallas_jump_inside_catwalk" );
    
    if ( level.players.size == 1 )
    {
        level thread function_e6515192();
    }
    
    function_cf13969b();
    level waittill( #"hash_fdcdf647" );
    level.ai_hendricks colors::enable();
    trigger::use( "t_hangar02_move_allies", undefined, undefined, 0 );
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_hendricks ai::set_ignoreme( 0 );
    level thread scene::play( "cin_pro_10_01_hangar_vign_traverse_khalil_end_idle" );
    level thread scene::play( "cin_pro_10_01_hangar_vign_traverse_minister_end_idle" );
    wait 3;
    level thread scene::stop( "cin_pro_10_01_hangar_vign_traverse_khalil_end_idle" );
    level thread scene::stop( "cin_pro_10_01_hangar_vign_traverse_minister_end_idle" );
    level.ai_khalil colors::enable();
    level.ai_minister util::delay( 2, undefined, &colors::enable );
    level.ai_khalil ai::set_ignoreall( 0 );
    level.ai_khalil ai::set_ignoreme( 0 );
}

// Namespace hangar
// Params 1
// Checksum 0x52f57f5a, Offset: 0x38a0
// Size: 0xdc
function function_3683e3dd( var_c2777dd9 )
{
    self ai::set_behavior_attribute( "disablearrivals", 1 );
    var_9d01e85c = getnode( "hendricks_traversal_goal_1", "targetname" );
    self setgoal( var_9d01e85c, 1 );
    self waittill( #"goal" );
    self ai::set_behavior_attribute( "disablearrivals", 0 );
    level thread scene::play( var_c2777dd9 );
    level waittill( #"hash_9aebec3d" );
    level flag::set( "plane_hangar_hendricks_ready_flag" );
}

// Namespace hangar
// Params 1
// Checksum 0xc444c969, Offset: 0x3988
// Size: 0x18c
function function_7ae90dbb( var_c2777dd9 )
{
    self ai::set_behavior_attribute( "disablearrivals", 1 );
    var_9d01e85c = getnode( "khalil_traversal_goal_1", "targetname" );
    self setgoal( var_9d01e85c, 1 );
    self waittill( #"goal" );
    var_f095797 = getnode( "khalil_traversal_goal_2", "targetname" );
    self setgoal( var_f095797, 1 );
    self waittill( #"goal" );
    var_e906dd2e = getnode( "khalil_traversal_goal_3", "targetname" );
    self setgoal( var_e906dd2e, 1 );
    self waittill( #"goal" );
    self ai::set_behavior_attribute( "disablearrivals", 0 );
    level thread scene::play( var_c2777dd9 );
    level waittill( #"hash_bdaa4f6d" );
    level flag::set( "plane_hangar_khalil_ready_flag" );
}

// Namespace hangar
// Params 1
// Checksum 0xac6c9832, Offset: 0x3b20
// Size: 0x18c
function function_7a87693b( var_c2777dd9 )
{
    self ai::set_behavior_attribute( "disablearrivals", 1 );
    var_9d01e85c = getnode( "minister_traversal_goal_1", "targetname" );
    self setgoal( var_9d01e85c, 1 );
    self waittill( #"goal" );
    var_f095797 = getnode( "minister_traversal_goal_2", "targetname" );
    self setgoal( var_f095797, 1 );
    self waittill( #"goal" );
    var_e906dd2e = getnode( "minister_traversal_goal_3", "targetname" );
    self setgoal( var_e906dd2e, 1 );
    self waittill( #"goal" );
    self ai::set_behavior_attribute( "disablearrivals", 0 );
    level thread scene::play( var_c2777dd9 );
    level waittill( #"hash_b0db1711" );
    level flag::set( "plane_hangar_minister_ready_flag" );
}

// Namespace hangar
// Params 0
// Checksum 0xaac4a37c, Offset: 0x3cb8
// Size: 0x7a
function function_cf13969b()
{
    level endon( #"hash_e4850787" );
    level flag::wait_till_all( array( "plane_hangar_hendricks_ready_flag", "plane_hangar_khalil_ready_flag", "plane_hangar_minister_ready_flag" ) );
    level scene::play( "cin_pro_10_01_hangar_vign_traverse_hendricks_khalil_minister_move_01" );
    level notify( #"hash_f38af553" );
}

// Namespace hangar
// Params 0
// Checksum 0x5d23ff7e, Offset: 0x3d40
// Size: 0x13c
function function_e6515192()
{
    level endon( #"hash_f38af553" );
    level flag::wait_till_all( array( "plane_hangar_hendricks_ready_flag", "plane_hangar_khalil_ready_flag", "plane_hangar_minister_ready_flag" ) );
    level flag::wait_till( "expedite_hangar_entrance" );
    s_door_loc = struct::get( "s_hangar_door", "targetname" );
    array::thread_all( level.players, &util::waittill_player_not_looking_at, s_door_loc.origin );
    level notify( #"hash_e4850787" );
    
    if ( !scene::is_playing( "cin_pro_10_01_hangar_vign_traverse_hendricks_khalil_minister_move_01" ) )
    {
        level thread scene::skipto_end( "cin_pro_10_01_hangar_vign_traverse_hendricks_khalil_minister_move_01", undefined, undefined, 0.65 );
    }
    
    wait 0.1;
    level.ai_hendricks stopanimscripted();
}

// Namespace hangar
// Params 0
// Checksum 0x84312c58, Offset: 0x3e88
// Size: 0x124
function function_bae363ed()
{
    level waittill( #"hash_e4850787" );
    var_280d5f68 = getent( "hangar02_door_left", "targetname" );
    var_3c301126 = getent( "hangar02_door_right", "targetname" );
    var_1f6ed387 = getent( "plane_hangar_side_door_left", "targetname" );
    var_fcd5dfa1 = getent( "plane_hangar_side_door_right", "targetname" );
    var_280d5f68 moveto( var_1f6ed387.origin, 0.5 );
    var_3c301126 moveto( var_fcd5dfa1.origin, 0.5 );
}

// Namespace hangar
// Params 0
// Checksum 0xaa0a571f, Offset: 0x3fb8
// Size: 0x124
function pallas_stun()
{
    level flag::wait_till( "trig_hangar01_enemies" );
    a_sp_spawners = getspawnerarray( "hangar01_enemy", "script_aigroup" );
    a_ai_array = spawner::simple_spawn( a_sp_spawners );
    array::thread_all( a_ai_array, &function_211f2948 );
    array::thread_all( a_ai_array, &function_b5a28004 );
    level thread function_c218ce54();
    level scene::play( "cin_pro_10_01_hanger_vign_sensory_overload_start" );
    level thread objectives::breadcrumb( "hangar_breadcrumb_2" );
    level thread function_25e65862();
}

// Namespace hangar
// Params 0
// Checksum 0x49cb639c, Offset: 0x40e8
// Size: 0x54
function function_c218ce54()
{
    level waittill( #"remove_blocker" );
    mdl_blocker = getent( "stun_cin_blocker", "targetname" );
    mdl_blocker delete();
}

// Namespace hangar
// Params 0
// Checksum 0xa88a998e, Offset: 0x4148
// Size: 0x2c
function function_25e65862()
{
    wait 3;
    level.ai_pallas thread dialog::say( "diaz_move_into_the_next_h_0" );
}

// Namespace hangar
// Params 0
// Checksum 0x257d7202, Offset: 0x4180
// Size: 0x2c
function function_b5a28004()
{
    self endon( #"death" );
    wait 30;
    self kill();
}

// Namespace hangar
// Params 0
// Checksum 0xf65392bf, Offset: 0x41b8
// Size: 0xd4
function function_211f2948()
{
    self setcontents( 8192 );
    self.dontdropweapon = 1;
    self setmaxhealth( 15 );
    self ai::set_ignoreme( 1 );
    self ai::set_ignoreall( 1 );
    self thread function_fd0a6295();
    self cybercom::cybercom_aioptout( "cybercom_fireflyswarm" );
    self waittill( #"death" );
    self startragdoll( 1 );
}

// Namespace hangar
// Params 0
// Checksum 0xa88513f9, Offset: 0x4298
// Size: 0x6c
function function_fd0a6295()
{
    self endon( #"death" );
    self waittill( #"hash_b19658ba" );
    self notify( #"bhtn_action_notify", "reactSensory" );
    self playsound( "gdt_sensory_feedback_start" );
    self playloopsound( "gdt_sensory_feedback_lp_upg" );
}

// Namespace hangar
// Params 0
// Checksum 0x2b8d30, Offset: 0x4310
// Size: 0x64
function function_aaf033f6()
{
    self endon( #"death" );
    self waittill( #"reach_done" );
    var_be53b69c = getnode( "pallas_hangar_anim_start", "targetname" );
    self setgoal( var_be53b69c, 1 );
}

// Namespace hangar
// Params 0
// Checksum 0xa73c1e42, Offset: 0x4380
// Size: 0x9c
function function_644150a()
{
    sndent = spawn( "script_origin", ( 7553, 1157, 207 ) );
    sndent playloopsound( "evt_sensory_dudes_walla", 2 );
    level flag::wait_till( "trig_hangar01_enemies" );
    wait 3;
    sndent delete();
}

// Namespace hangar
// Params 0
// Checksum 0xdbf60e50, Offset: 0x4428
// Size: 0x37c
function pallas_jump_hangar()
{
    self colors::disable();
    self thread function_aaf033f6();
    level.ai_pallas pallas_stun();
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self ai::set_behavior_attribute( "sprint", 1 );
    level thread function_e0540704();
    level flag::wait_till( "pallas_jump_inside_catwalk" );
    level flag::set( "spawn_plane_hangar_enemies" );
    level notify( #"hash_28b81543" );
    level thread function_507f685c();
    self colors::set_force_color( "o" );
    level thread function_d11463aa();
    level scene::play( "cin_pro_10_01_hangar_vign_breakwindow" );
    self ai::set_behavior_attribute( "sprint", 0 );
    level thread scene::play( "cin_pro_10_04_hangar_vign_leap_new_run_across" );
    n_node = getnode( "pallas_temp_catwalk_end", "targetname" );
    self setgoal( n_node, 1 );
    self waittill( #"goal" );
    self thread function_ee8e1349();
    wait 0.5;
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    self setgoal( n_node, 1 );
    level thread plane_hangar_breakout();
    level flag::wait_till( "pallas_jump_to_window" );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    level thread scene::add_scene_func( "cin_pro_10_04_hangar_vign_leap_new_wing2window", &pallas_waiting_at_window, "done" );
    level notify( #"hash_35d2241b" );
    level flag::wait_till( "fireflies_used" );
    self thread scene::play( "cin_pro_10_04_hangar_vign_leap_new_wing2window" );
    level waittill( #"hash_d4a94cc6" );
    level clientfield::set( "diaz_break_1", 2 );
}

// Namespace hangar
// Params 0
// Checksum 0x2e2f1ee5, Offset: 0x47b0
// Size: 0x7c
function function_d11463aa()
{
    level waittill( #"window_broken" );
    level thread scene::play( "p7_fxanim_cp_prologue_hangar_window_rip_bundle" );
    level waittill( #"hash_cab72ab7" );
    mdl_window = getent( "hangar_glass_window", "targetname" );
    mdl_window delete();
}

// Namespace hangar
// Params 0
// Checksum 0xa2de58e8, Offset: 0x4838
// Size: 0x19c
function function_ee8e1349()
{
    array::thread_all( level.players, &function_b81dfc22 );
    level thread function_2d8450d7();
    level waittill( #"hash_35d2241b" );
    level thread function_cc32afb9();
    a_targets = getentarray( "catwalk_window_enemies_ai", "targetname" );
    
    if ( a_targets.size > 0 )
    {
        self cybercom::function_d240e350( "cybercom_fireflyswarm", a_targets );
    }
    else
    {
        var_78e3eaf1 = getentarray( "plane_hangar_enemies", "script_noteworthy", 1 );
        var_262dcd37 = struct::get( "plane_to_vtol_fallback_origin", "targetname" );
        var_e2ceaf11 = array::get_all_closest( var_262dcd37.origin, var_78e3eaf1, undefined, 3 );
        self cybercom::function_d240e350( "cybercom_fireflyswarm", var_e2ceaf11 );
    }
    
    level flag::set( "fireflies_used" );
}

// Namespace hangar
// Params 0
// Checksum 0xaeba9423, Offset: 0x49e0
// Size: 0x78
function function_cc32afb9()
{
    level endon( #"plane_hangar_complete" );
    level.var_95790224 = [];
    
    while ( true )
    {
        level waittill( #"cybercom_swarm_released", swarm );
        level.var_95790224[ level.var_95790224.size ] = swarm;
        
        if ( swarm.owner == self )
        {
            swarm.ignoreme = 1;
        }
    }
}

// Namespace hangar
// Params 0
// Checksum 0x8d97b0c3, Offset: 0x4a60
// Size: 0x62
function function_b81dfc22()
{
    self endon( #"death" );
    wait 0.5;
    self util::waittill_player_looking_at( level.ai_pallas.origin + ( 0, 0, 50 ), 30 );
    level notify( #"hash_35d2241b" );
}

// Namespace hangar
// Params 0
// Checksum 0xcfa1e76c, Offset: 0x4ad0
// Size: 0x16
function function_2d8450d7()
{
    wait 15;
    level notify( #"hash_35d2241b" );
}

// Namespace hangar
// Params 1
// Checksum 0x7e1c158d, Offset: 0x4af0
// Size: 0x2c
function pallas_waiting_at_window( a_ents )
{
    level flag::set( "pallas_at_window" );
}

// Namespace hangar
// Params 0
// Checksum 0x665bb58a, Offset: 0x4b28
// Size: 0x94
function function_e0540704()
{
    level endon( #"hash_28b81543" );
    self waittill( #"goal" );
    wait 4;
    level.ai_pallas dialog::say( "diaz_pick_up_the_damn_pac_0" );
    wait 4;
    level.ai_pallas dialog::say( "diaz_you_wanna_get_the_mi_0" );
    wait 5;
    level.ai_pallas dialog::say( "diaz_we_gotta_move_to_exf_0" );
}

// Namespace hangar
// Params 0
// Checksum 0x9387bdbf, Offset: 0x4bc8
// Size: 0xa4
function function_507f685c()
{
    level waittill( #"hash_bf327f23" );
    level.ai_pallas dialog::say( "diaz_on_my_position_let_0" );
    level flag::wait_till( "move_plane_hangar_enemies" );
    e_pa = getent( "pa_hangar_dialog", "targetname" );
    e_pa dialog::say( "nrcp_infiltrators_moving_0", 0, 1 );
}

// Namespace hangar
// Params 0
// Checksum 0x73cba09c, Offset: 0x4c78
// Size: 0x44
function plane_hangar_breakout()
{
    level flag::wait_till( "plane_hangar_enemies_fallback3" );
    level flag::set( "pallas_jump_to_window" );
}

// Namespace hangar
// Params 0
// Checksum 0x22e7190c, Offset: 0x4cc8
// Size: 0x5c
function prometheus_vtol_hangar()
{
    e_target = getent( "cyber_soldiers_hangar_target", "targetname" );
    self thread ai::shoot_at_target( "normal", e_target, undefined, 100, 10000 );
}

// Namespace hangar
// Params 1
// Checksum 0x74b6e677, Offset: 0x4d30
// Size: 0x6c
function ai_teleport( ai_node )
{
    node = getnode( ai_node, "targetname" );
    self forceteleport( node.origin, node.angles, 1 );
}

// Namespace hangar
// Params 0
// Checksum 0x8b526cbe, Offset: 0x4da8
// Size: 0x108
function ai_ignore_then_move()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    
    if ( isdefined( self.target ) )
    {
        n_goalradius = self.goalradius;
        nd = getnode( self.target, "targetname" );
        
        if ( isdefined( nd ) )
        {
            self ai::force_goal( nd, 64, 1, undefined, 1 );
            self ai::set_ignoreall( 0 );
            self ai::set_ignoreme( 0 );
        }
        
        if ( isdefined( self.radius ) )
        {
            self.goalradius = self.radius;
        }
    }
}

// Namespace hangar
// Params 0
// Checksum 0xbe77485a, Offset: 0x4eb8
// Size: 0x74
function ai_think()
{
    self endon( #"death" );
    self.goalradius = 16;
    
    if ( isdefined( self.target ) )
    {
        node = getnode( self.target, "targetname" );
        self setgoal( node, 1 );
    }
}

// Namespace hangar
// Params 0
// Checksum 0xf2ea3269, Offset: 0x4f38
// Size: 0x102
function function_6ad5d018()
{
    level.ai_prometheus thread function_47f306da( "prometheus_hangar_goal" );
    level.ai_theia thread function_47f306da( "theia_hangar_goal" );
    level.ai_hyperion thread function_47f306da( "hyperion_hangar_goal" );
    level thread function_90b59893();
    spawner::add_spawn_function_group( "hangar_ambient_ai", "script_noteworthy", &function_5f6c69c0 );
    spawn_manager::enable( "sm_hangar_ambient_combat" );
    level thread function_1053dd4e();
    spawn_manager::wait_till_cleared( "sm_hangar_ambient_combat" );
    level notify( #"hash_bf48d580" );
}

// Namespace hangar
// Params 0
// Checksum 0x802f2782, Offset: 0x5048
// Size: 0x13c
function function_1053dd4e()
{
    self endon( #"hash_bf48d580" );
    level flag::wait_till( "side_cyberbattle_go" );
    array::thread_all( level.players, &function_1232fdd1 );
    level waittill( #"hash_8f285b1d" );
    wait 1;
    a_enemies = spawner::get_ai_group_ai( "hangar_ambient_ai" );
    
    if ( a_enemies.size > 0 )
    {
        level.ai_prometheus cybercom::function_d240e350( "cybercom_immolation", a_enemies );
    }
    
    wait 3;
    level.ai_theia cybercom::function_d240e350( "cybercom_smokescreen" );
    wait 4;
    a_enemies = spawner::get_ai_group_ai( "hangar_ambient_ai" );
    
    if ( a_enemies.size > 0 )
    {
        level.ai_hyperion cybercom::function_d240e350( "cybercom_immolation", a_enemies );
    }
}

// Namespace hangar
// Params 0
// Checksum 0x8426d243, Offset: 0x5190
// Size: 0x62
function function_1232fdd1()
{
    self endon( #"hash_8f285b1d" );
    wait 0.5;
    self util::waittill_player_looking_at( level.ai_theia.origin + ( 0, 0, 64 ), 90, 1 );
    level notify( #"hash_8f285b1d" );
}

// Namespace hangar
// Params 0
// Checksum 0xace1865b, Offset: 0x5200
// Size: 0xf0
function function_90b59893()
{
    level endon( #"hash_bf48d580" );
    var_8164b942 = getentarray( "origin_ambient_grenade", "targetname" );
    
    while ( true )
    {
        n_rand = randomintrange( 4, 8 );
        wait n_rand;
        var_b311d2b0 = randomintrange( 0, var_8164b942.size );
        level.ai_hendricks magicgrenadetype( getweapon( "frag_grenade" ), var_8164b942[ var_b311d2b0 ].origin, ( 0, 0, 0 ), 0.05 );
    }
}

// Namespace hangar
// Params 2
// Checksum 0xa35da687, Offset: 0x52f8
// Size: 0x254
function function_47f306da( s_node, b_starting )
{
    n_node = getnode( s_node, "targetname" );
    self forceteleport( n_node.origin, n_node.angles, 1 );
    self setgoal( n_node );
    wait 0.5;
    self show();
    self intro_cyber_soldiers::actor_camo( 0 );
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    a_ais = getaiteamarray( "axis", "axis" );
    
    foreach ( ai in a_ais )
    {
        if ( ai.script_noteworthy !== "hangar_ambient_ai" )
        {
            self setignoreent( ai, 1 );
        }
    }
    
    self.attackeraccuracy = 0.5;
    level waittill( #"hash_bf48d580" );
    n_goal = getnode( n_node.target, "targetname" );
    self setgoal( n_goal );
    self waittill( #"goal" );
    self delete();
}

// Namespace hangar
// Params 0
// Checksum 0x53db373d, Offset: 0x5558
// Size: 0x224
function function_5f6c69c0()
{
    self.attackeraccuracy = 1;
    self.goalradius = 16;
    self.disable_score_events = 1;
    a_ais = getaiteamarray( "allies", "allies" );
    
    foreach ( ai in a_ais )
    {
        if ( isdefined( ai.targetname ) && ai.targetname != "theia_ai" && ai.targetname != "hyperion_ai" && ai.targetname != "prometheus_ai" )
        {
            self setignoreent( ai, 1 );
        }
    }
    
    foreach ( player in level.players )
    {
        self setignoreent( player, 1 );
    }
    
    var_257bbc01 = getent( "t_ambiant_hangar_goal_volume", "targetname" );
    self setgoal( var_257bbc01 );
}

// Namespace hangar
// Params 0
// Checksum 0xa6f9e0e1, Offset: 0x5788
// Size: 0x78
function catwalk_fxanim()
{
    trig = getent( "wing_r", "targetname" );
    
    while ( true )
    {
        trig waittill( #"trigger" );
        exploder::exploder( "fx_exploder_wing_bullet01" );
        exploder::exploder( "fx_exploder_wing_bullet02" );
    }
}

// Namespace hangar
// Params 0
// Checksum 0x2459dad1, Offset: 0x5808
// Size: 0x54
function vtol_collapse_start()
{
    level thread namespace_21b2c1f2::function_46333a8a();
    vtol_collapse_precache();
    vtol_collapse_heros_init();
    level thread vtol_collapse_main();
}

// Namespace hangar
// Params 0
// Checksum 0xf0d05dc7, Offset: 0x5868
// Size: 0x64
function vtol_collapse_precache()
{
    level flag::init( "door_close" );
    level flag::init( "hend_grenade_timeout" );
    level flag::init( "vtol_hit" );
}

// Namespace hangar
// Params 0
// Checksum 0x6beb86ad, Offset: 0x58d8
// Size: 0x130
function vtol_collapse_heros_init()
{
    level.ai_prometheus ai::set_ignoreall( 1 );
    level.ai_prometheus ai::set_ignoreme( 1 );
    level.ai_prometheus.goalradius = 16;
    level.ai_pallas.goalradius = 16;
    level.ai_pallas.allowpain = 0;
    level.ai_pallas colors::set_force_color( "o" );
    level.ai_hendricks.goalradius = 16;
    level.ai_hendricks.allowpain = 0;
    level.ai_khalil.goalradius = 16;
    level.ai_minister ai::set_ignoreall( 1 );
    level.ai_minister ai::set_ignoreme( 1 );
    level.ai_minister.goalradius = 16;
}

// Namespace hangar
// Params 0
// Checksum 0x28a17c20, Offset: 0x5a10
// Size: 0x25c
function vtol_collapse_main()
{
    level thread cp_prologue_util::function_42da021e( "vh_vtol_flyby_b", 50, 100 );
    level thread function_4422735b();
    level thread function_8efb9b5c();
    level.ai_pallas thread function_f9196d1d();
    level flag::wait_till( "hanger3_battle_event" );
    level.ai_hendricks thread function_414c1d0();
    level.ai_hendricks thread hendricks_movement_handler();
    level thread function_9ada4a46();
    level thread function_9ea7f8ae();
    level.ai_khalil ai::set_ignoreall( 1 );
    level.ai_khalil ai::set_ignoreme( 1 );
    level thread function_55039e89();
    level thread function_e37c0060();
    level waittill( #"hash_8413e49c" );
    level flag::wait_till( "hangar_5_bc" );
    level thread objectives::breadcrumb( "hangar_breadcrumb_5" );
    function_d81a4ec();
    level.ai_pallas colors::enable();
    trigger::use( "vtol_hangar_empty_color_allies", "targetname" );
    level thread namespace_21b2c1f2::function_973b77f9();
    level flag::wait_till( "hangar3_backdoor" );
    function_e966c1c0( 0 );
    skipto::objective_completed( "skipto_vtol_collapse" );
}

// Namespace hangar
// Params 0
// Checksum 0x162e137c, Offset: 0x5c78
// Size: 0x25e
function function_4422735b()
{
    t_door = getent( "vtol_collapse_door_open", "targetname" );
    a_friendly_ai = array( level.ai_minister, level.ai_hendricks, level.ai_khalil );
    level thread cp_prologue_util::function_21f52196( "vtol_collapse_doors", t_door );
    level thread cp_prologue_util::function_2e61b3e8( "vtol_collapse_doors", t_door, a_friendly_ai );
    
    while ( !cp_prologue_util::function_cdd726fb( "vtol_collapse_doors" ) )
    {
        wait 0.1;
    }
    
    var_ac769486 = getent( "clip_player_vtol_collapse_backtrack_doorway", "targetname" );
    var_ac769486 movez( 100 * -1, 0.05 );
    mdl_door_left = getent( "vtol_hangar_in_l", "targetname" );
    mdl_door_right = getent( "vtol_hangar_in_r", "targetname" );
    vec_right = anglestoright( mdl_door_left.angles );
    mdl_door_left moveto( mdl_door_left.origin - vec_right * 50, 0.5 );
    mdl_door_right moveto( mdl_door_right.origin + vec_right * 44, 0.5 );
    level notify( #"hash_3e92d474" );
    level notify( #"hash_e3977daa" );
}

// Namespace hangar
// Params 0
// Checksum 0x67d68b1, Offset: 0x5ee0
// Size: 0x3c
function function_d43c2e1a()
{
    level endon( #"death" );
    level waittill( #"hash_cb897bce" );
    level thread clientfield::set( "vtol_missile_explode_trash_fx", 1 );
}

// Namespace hangar
// Params 0
// Checksum 0x6707e3a5, Offset: 0x5f28
// Size: 0x134
function function_9ea7f8ae()
{
    var_fa1b3fb2 = getent( "trig_dam_vtol_collapse", "targetname" );
    var_fa1b3fb2 setcandamage( 0 );
    level flag::wait_till( "2nd_hangar_apc_in_pos" );
    level flag::wait_till( "vtol_destroy_obj" );
    var_fa1b3fb2 setcandamage( 1 );
    e_objective = getent( "vtol_hangar_missile_objective", "targetname" );
    objectives::set( "cp_level_prologue_destroy", e_objective.origin );
    var_fa1b3fb2 trigger::wait_till();
    level notify( #"hash_36ad3c2e" );
    level flag::set( "vtol_hit" );
}

// Namespace hangar
// Params 0
// Checksum 0x8fe631b7, Offset: 0x6068
// Size: 0xd4
function function_414c1d0()
{
    level endon( #"hash_36ad3c2e" );
    n_goal = getnode( "n_hendricks_grenade", "targetname" );
    self setgoal( n_goal );
    self waittill( #"goal" );
    self thread function_23e5e896();
    level flag::wait_till( "hend_grenade_timeout" );
    
    /#
        iprintln( "<dev string:x28>" );
    #/
    
    wait 2;
    level flag::set( "vtol_hit" );
}

// Namespace hangar
// Params 0
// Checksum 0xbccd46c5, Offset: 0x6148
// Size: 0xe4
function function_23e5e896()
{
    level endon( #"hash_36ad3c2e" );
    self dialog::say( "hend_our_weapons_are_no_g_0" );
    
    if ( vehicle::is_corpse( level.var_199de689 ) )
    {
        wait 1;
    }
    else
    {
        level waittill( #"vtol_apc_dialog" );
    }
    
    self thread dialog::say( "hend_we_gotta_bring_down_1", 0.25 );
    wait 1;
    level flag::set( "vtol_destroy_obj" );
    wait 7;
    self dialog::say( "hend_we_ain_t_doing_shit_0" );
    wait 5;
    level flag::set( "hend_grenade_timeout" );
}

// Namespace hangar
// Params 0
// Checksum 0x1b2d1b48, Offset: 0x6238
// Size: 0x7c
function function_10ed8bd7()
{
    n_timepassed = 0;
    n_starttime = gettime();
    
    while ( true )
    {
        wait 0.5;
        n_timepassed = ( gettime() - n_starttime ) / 1000;
        
        if ( n_timepassed >= 20 )
        {
            break;
        }
    }
    
    level flag::set( "hend_grenade_timeout" );
}

// Namespace hangar
// Params 0
// Checksum 0xe6c53003, Offset: 0x62c0
// Size: 0xcc
function hendricks_movement_handler()
{
    self colors::disable();
    level waittill( #"hash_8413e49c" );
    level thread function_15ce0cb4();
    self colors::enable();
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    level.ai_pallas ai::set_ignoreall( 0 );
    level.ai_pallas ai::set_ignoreme( 0 );
    trigger::use( "vtol_hendricks_move_up_initial" );
}

// Namespace hangar
// Params 0
// Checksum 0x74408061, Offset: 0x6398
// Size: 0x24
function function_15ce0cb4()
{
    level.ai_hendricks dialog::say( "hend_apc_s_out_of_commiss_0" );
}

// Namespace hangar
// Params 1
// Checksum 0xf2ccfdd0, Offset: 0x63c8
// Size: 0xa2
function function_d418516( var_c83dc06e )
{
    foreach ( ai_rider in var_c83dc06e.riders )
    {
        self setignoreent( ai_rider, 1 );
    }
}

// Namespace hangar
// Params 0
// Checksum 0x9a6293b3, Offset: 0x6478
// Size: 0x20c
function function_55039e89()
{
    spawner::add_spawn_function_group( "sp_vtol_initial", "targetname", &function_d7dad356 );
    spawner::add_spawn_function_group( "sp_vtol_initial", "targetname", &cp_prologue_util::remove_grenades );
    spawner::simple_spawn( "sp_vtol_initial" );
    spawner::add_spawn_function_group( "sp_vtol_hangar_sideroom", "targetname", &function_d7dad356 );
    spawner::add_spawn_function_group( "sp_vtol_hangar_sideroom", "targetname", &cp_prologue_util::remove_grenades );
    spawner::simple_spawn( "sp_vtol_hangar_sideroom" );
    spawner::add_spawn_function_group( "aig_vtol_hangar_lower", "script_aigroup", &function_b7846718 );
    spawner::add_spawn_function_group( "aig_vtol_hangar_lower", "script_aigroup", &cp_prologue_util::remove_grenades );
    spawn_manager::enable( "sm_vtol_hangar_rear" );
    spawner::add_spawn_function_group( "aig_vtol_hangar_upper", "script_aigroup", &function_5d48dce7 );
    spawner::add_spawn_function_group( "aig_vtol_hangar_upper", "script_aigroup", &cp_prologue_util::remove_grenades );
    spawn_manager::enable( "sm_vtol_hangar_upper" );
    level waittill( #"vtol_explosion" );
    spawner::simple_spawn( "sp_vtol_hangar_top_front" );
}

// Namespace hangar
// Params 0
// Checksum 0x4d434afa, Offset: 0x6690
// Size: 0x104
function function_d7dad356()
{
    self endon( #"death" );
    self thread function_f547728f();
    self thread function_f647689b();
    self thread return_fire();
    self thread function_1e82f4b7();
    level waittill( #"hash_d2de9e1f" );
    self ai::set_ignoreall( 1 );
    var_3f0f1f46 = getent( "trig_vtol_goal_vol_rear", "targetname" );
    self setgoal( var_3f0f1f46 );
    self waittill( #"goal" );
    self ai::set_ignoreall( 1 );
}

// Namespace hangar
// Params 0
// Checksum 0x4aeaf074, Offset: 0x67a0
// Size: 0x104
function function_1e82f4b7()
{
    self endon( #"death" );
    level flag::wait_till( "door_close" );
    var_c9aed927 = getentarray( "outside_hangar_check", "targetname" );
    
    foreach ( var_26778947 in var_c9aed927 )
    {
        if ( self istouching( var_26778947 ) && isdefined( self ) )
        {
            self delete();
            return;
        }
    }
}

// Namespace hangar
// Params 0
// Checksum 0xb3297d52, Offset: 0x68b0
// Size: 0x94
function function_b7846718()
{
    self thread function_f547728f();
    self thread function_f647689b();
    self thread return_fire();
    var_3f0f1f46 = getent( "trig_vtol_goal_vol_rear", "targetname" );
    self setgoal( var_3f0f1f46 );
}

// Namespace hangar
// Params 0
// Checksum 0x99fdd4c9, Offset: 0x6950
// Size: 0x7c
function function_5d48dce7()
{
    self thread function_f547728f();
    self thread function_f647689b();
    self thread return_fire();
    self.goalradius = 16;
    trigger::use( "vtol_hangar_upper_color", "targetname" );
}

// Namespace hangar
// Params 0
// Checksum 0x6e5d7e79, Offset: 0x69d8
// Size: 0x54
function return_fire()
{
    self util::waittill_any( "damage", "bulletwhizby", "pain", "proximity" );
    self ai::set_ignoreall( 0 );
}

// Namespace hangar
// Params 0
// Checksum 0x20607cdf, Offset: 0x6a38
// Size: 0x94
function function_f647689b()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    level util::waittill_any( "vtol_hit", "vtol_hangar_player_leaves_cover" );
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
}

// Namespace hangar
// Params 0
// Checksum 0x6d2aa3e, Offset: 0x6ad8
// Size: 0x38
function function_f547728f()
{
    self endon( #"death" );
    self.script_accuracy = 0.5;
    level waittill( #"hash_8413e49c" );
    self.script_accuracy = 1;
}

// Namespace hangar
// Params 0
// Checksum 0x7aa2911a, Offset: 0x6b18
// Size: 0x28a
function function_d81a4ec()
{
    level thread function_114b96c0();
    level flag::wait_till( "vtol_final_fallback" );
    spawn_manager::kill( "sm_vtol_hangar_upper" );
    spawn_manager::kill( "sm_vtol_hangar_rear" );
    var_2373d08e = getent( "trig_vtol_goal_vol_fallback_final", "targetname" );
    var_f694cded = spawner::get_ai_group_ai( "aig_vtol_hangar_lower" );
    a_ai_initial = spawner::get_ai_group_ai( "aig_vtol_hangar_initial" );
    var_7fc45f7c = spawner::get_ai_group_ai( "aig_plane_hangar_enemies_main" );
    array::run_all( var_f694cded, &cleargoalvolume );
    array::run_all( a_ai_initial, &cleargoalvolume );
    array::run_all( var_7fc45f7c, &cleargoalvolume );
    array::run_all( var_f694cded, &setgoal, var_2373d08e );
    array::run_all( a_ai_initial, &setgoal, var_2373d08e );
    array::run_all( var_7fc45f7c, &setgoal, var_2373d08e );
    trigger::use( "vtol_hangar_upper_retreat", "targetname" );
    level thread function_c1bac28();
    spawner::waittill_ai_group_ai_count( "aig_vtol_hangar_lower", 0 );
    spawner::waittill_ai_group_ai_count( "aig_vtol_hangar_upper", 0 );
    spawner::waittill_ai_group_ai_count( "aig_vtol_hangar_initial", 0 );
    spawner::waittill_ai_group_ai_count( "aig_plane_hangar_enemies_main", 0 );
    wait 2;
}

// Namespace hangar
// Params 0
// Checksum 0x53a24afb, Offset: 0x6db0
// Size: 0x21a
function function_c1bac28()
{
    level thread function_f6c934d0();
    wait 15;
    var_d2315634 = getent( "trig_vtol_goal_vol_fallback_final_defend_exit", "targetname" );
    var_4b64857a = spawner::get_ai_group_ai( "aig_vtol_hangar_upper" );
    var_f694cded = spawner::get_ai_group_ai( "aig_vtol_hangar_lower" );
    a_ai_initial = spawner::get_ai_group_ai( "aig_vtol_hangar_initial" );
    var_7fc45f7c = spawner::get_ai_group_ai( "aig_plane_hangar_enemies_main" );
    var_20cedf03 = arraycombine( var_4b64857a, var_f694cded, 0, 0 );
    var_20cedf03 = arraycombine( var_20cedf03, a_ai_initial, 0, 0 );
    var_20cedf03 = arraycombine( var_20cedf03, var_7fc45f7c, 0, 0 );
    
    foreach ( enemy in var_20cedf03 )
    {
        if ( isalive( enemy ) )
        {
            enemy cleargoalvolume();
            wait 0.1;
            enemy setgoalvolume( var_d2315634 );
        }
    }
}

// Namespace hangar
// Params 0
// Checksum 0x271fbe6a, Offset: 0x6fd8
// Size: 0x3c
function function_f6c934d0()
{
    level thread util::set_streamer_hint( 6 );
    level waittill( #"hash_fc98480b" );
    util::clear_streamer_hint();
}

// Namespace hangar
// Params 0
// Checksum 0xf447287b, Offset: 0x7020
// Size: 0x7c
function function_896f0868()
{
    e_closest_player = arraygetclosest( self.origin, level.activeplayers );
    self.goalradius = 128;
    self setgoalentity( e_closest_player );
    self ai::set_behavior_attribute( "move_mode", "rambo" );
}

// Namespace hangar
// Params 0
// Checksum 0x1c4f2721, Offset: 0x70a8
// Size: 0x9c
function function_114b96c0()
{
    var_25002d73 = 6;
    
    while ( var_25002d73 > 5 )
    {
        var_25002d73 = spawner::get_ai_group_sentient_count( "aig_vtol_hangar_lower" ) + spawner::get_ai_group_sentient_count( "aig_vtol_hangar_initial" ) + spawner::get_ai_group_sentient_count( "aig_plane_hangar_enemies_main" );
        wait 0.5;
    }
    
    level flag::set( "vtol_final_fallback" );
}

// Namespace hangar
// Params 1
// Checksum 0x85cf9813, Offset: 0x7150
// Size: 0xb6
function function_19352a82( a_ai_enemy )
{
    foreach ( ai_speaker in a_ai_enemy )
    {
        if ( isalive( ai_speaker ) )
        {
            ai_speaker dialog::say( "nrcg_fall_back_fall_back_0" );
            break;
        }
    }
}

// Namespace hangar
// Params 0
// Checksum 0x37156aed, Offset: 0x7210
// Size: 0x3fc
function function_8efb9b5c()
{
    level thread function_8bd46c9();
    
    foreach ( player in level.players )
    {
        player.overrideplayerdamage = &function_e8443509;
    }
    
    a_e_targets = getentarray( "first_apc_target", "targetname" );
    t_hit = getent( "t_dam_apc_squibs", "targetname" );
    
    foreach ( e_target in a_e_targets )
    {
        if ( isalive( level.var_fac57550 ) )
        {
            level.var_fac57550 thread turret::shoot_at_target( e_target, 2.25, ( 0, 0, 0 ), 1, 0 );
            level.var_fac57550 thread turret::shoot_at_target( e_target, 2.25, ( 0, 0, 0 ), 2, 0 );
            level thread function_5792f76d( t_hit, e_target.origin );
            wait 2.25;
            level notify( #"hash_1a6f8b52" );
        }
    }
    
    wait 2.25;
    
    foreach ( player in level.players )
    {
        player.overrideplayerdamage = undefined;
    }
    
    level.fire_time_min = 1;
    level.fire_time_max = 2;
    level.fire_wait_min = 0.25;
    level.fire_wait_max = 0.5;
    
    if ( isalive( level.var_fac57550 ) )
    {
        level.var_fac57550 turret::set_burst_parameters( level.fire_time_min, level.fire_time_max, level.fire_wait_min, level.fire_wait_max, 1 );
        level.var_fac57550 turret::set_burst_parameters( level.fire_time_min, level.fire_time_max, level.fire_wait_min, level.fire_wait_max, 2 );
        level.var_fac57550 turret::enable( 1, 1 );
        level.var_fac57550 turret::enable( 2, 1 );
        level.var_fac57550 turret::disable_ai_getoff( 1, 1 );
        level.var_fac57550 turret::disable_ai_getoff( 2, 1 );
    }
}

// Namespace hangar
// Params 2
// Checksum 0x85f6416d, Offset: 0x7618
// Size: 0x94
function function_5792f76d( t_hit, v_loc )
{
    self endon( #"death" );
    level endon( #"vtol_collapse_done" );
    level endon( #"hash_1a6f8b52" );
    t_hit waittill( #"trigger", e_who );
    
    if ( e_who.team === "axis" )
    {
        physicsexplosionsphere( v_loc, 250, 250, 0.7 );
    }
}

// Namespace hangar
// Params 0
// Checksum 0xda8d8393, Offset: 0x76b8
// Size: 0x4d4
function function_8bd46c9()
{
    level flag::wait_till( "activate_initial_apc" );
    level thread function_b5a6b879();
    vehicle::add_spawn_function( "vtol_collapse_apc", &function_75381a71 );
    var_199de689 = vehicle::simple_spawn_single_and_drive( "vtol_collapse_apc" );
    level.var_199de689 = var_199de689;
    e_target = getent( "second_apc_target", "targetname" );
    var_199de689 thread turret::shoot_at_target( e_target, 2, ( 0, 0, 0 ), 1, 0 );
    var_199de689 thread turret::shoot_at_target( e_target, 2, ( 0, 0, 0 ), 2, 0 );
    wait 2;
    var_199de689 turret::set_burst_parameters( level.fire_time_min, level.fire_time_max, level.fire_wait_min, level.fire_wait_max, 1 );
    var_199de689 turret::set_burst_parameters( level.fire_time_min, level.fire_time_max, level.fire_wait_min, level.fire_wait_max, 2 );
    var_199de689 turret::enable( 1, 1 );
    var_199de689 turret::enable( 2, 1 );
    var_199de689 turret::disable_ai_getoff( 1, 1 );
    var_199de689 turret::disable_ai_getoff( 2, 1 );
    var_199de689 waittill( #"reached_end_node" );
    var_199de689 thread function_a2041661();
    level flag::set( "2nd_hangar_apc_in_pos" );
    level thread function_d43c2e1a();
    level flag::wait_till( "vtol_hit" );
    level notify( #"hash_7452e7a8" );
    objectives::complete( "cp_level_prologue_destroy" );
    level thread function_2226d83();
    level thread scene::play( "p7_fxanim_cp_prologue_vtol_hangar_bundle" );
    e_vtol = getent( "vtol_hangar_drop", "targetname" );
    e_vtol thread cp_prologue_util::function_d723979e( "swap_vtol_to_destroyed", "veh_t7_mil_vtol_nrc_no_interior_d", "vtol_collapse_done" );
    level notify( #"hash_5a11bfd7" );
    var_199de689 delete();
    wait 0.05;
    level.var_fac57550 delete();
    level waittill( #"vtol_explosion" );
    var_fa3fe683 = getent( "vtol_hangar_explosion_origin", "targetname" );
    radiusdamage( var_fa3fe683.origin, 400, 2000, 800 );
    physicsexplosioncylinder( var_fa3fe683.origin, 1200, 800, 0.5 );
    level function_ce858cd3( 1 );
    var_1b63031d = getent( "vtol_ai_blockers", "targetname" );
    var_1b63031d movez( 700, 0.05 );
    util::delay( 3, undefined, &function_62732b9d, var_fa3fe683.origin );
}

// Namespace hangar
// Params 2
// Checksum 0xa9879df6, Offset: 0x7b98
// Size: 0x13e
function function_62732b9d( s_origin, n_radius )
{
    if ( !isdefined( n_radius ) )
    {
        n_radius = 400;
    }
    
    deletecorpses = [];
    
    foreach ( corpse in getcorpsearray() )
    {
        if ( distance2d( corpse.origin, s_origin ) < n_radius )
        {
            deletecorpses[ deletecorpses.size ] = corpse;
        }
    }
    
    for ( index = 0; index < deletecorpses.size ; index++ )
    {
        deletecorpses[ index ] delete();
    }
}

// Namespace hangar
// Params 0
// Checksum 0x3c7fec43, Offset: 0x7ce0
// Size: 0xc4
function function_2226d83()
{
    var_c9510c8e = getent( "vtol_hangar_explosion_origin", "targetname" );
    level waittill( #"missile_explosion" );
    playrumbleonposition( "cp_prologue_rumble_hangar_vtol_collapse_rocket_fall", var_c9510c8e.origin );
    level waittill( #"vtol_explosion" );
    playrumbleonposition( "cp_prologue_rumble_hangar_vtol_collapse_explosion", var_c9510c8e.origin );
    level waittill( #"hash_98f09713" );
    playrumbleonposition( "cp_prologue_rumble_hangar_vtol_collapse_hit_ground", var_c9510c8e.origin );
}

// Namespace hangar
// Params 0
// Checksum 0xdd0c6848, Offset: 0x7db0
// Size: 0x124
function function_b5a6b879()
{
    var_280d5f68 = getent( "hangar_gate_l", "targetname" );
    var_3c301126 = getent( "hangar_gate_r", "targetname" );
    var_9c7511b4 = struct::get( "hangar_gate_move_pos_l", "targetname" );
    var_205c499a = struct::get( "hangar_gate_move_pos_r", "targetname" );
    var_c2777dd9 = "p7_fxanim_cp_prologue_hangar_door_bundle";
    level hangar_gate_close( 0, var_280d5f68, var_3c301126, var_9c7511b4, var_205c499a, var_c2777dd9, "umbra_gate_hangar_04" );
    level flag::set( "door_close" );
}

// Namespace hangar
// Params 0
// Checksum 0x657c09ae, Offset: 0x7ee0
// Size: 0x324
function function_f9196d1d()
{
    level flag::wait_till( "friendlies_jump_out_window" );
    level thread prometheus_cover_fire();
    level flag::wait_till( "pallas_at_window" );
    level thread scene::play( "cin_pro_10_04_hangar_vign_leap_new_jump_across" );
    level waittill( #"hash_aea6d25d" );
    level clientfield::set( "diaz_break_2", 2 );
    var_9e34fc53 = getnode( "n_pallas_vtol_tp", "targetname" );
    level.ai_pallas setgoal( var_9e34fc53 );
    level waittill( #"hash_8413e49c" );
    trigger::use( "pallas_move_up_initial" );
    level flag::wait_till( "diaz_ready_to_concuss" );
    self colors::disable();
    var_5cbb67a5 = getnode( "diaz_concuss_node", "targetname" );
    self setgoal( var_5cbb67a5, 1 );
    self waittill( #"goal" );
    array::thread_all( level.players, &function_5b79ea07 );
    level thread function_570a8f9e();
    level waittill( #"hash_4939dbfa" );
    level thread scene::play( "cin_pro_10_03_hangar_vign_concussive" );
    level waittill( #"hash_bd8e9605" );
    self cybercom::function_d240e350( "cybercom_concussive", undefined, 0 );
    self clearforcedgoal();
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    var_c3c81269 = getnode( "diaz_concuss_cover_node", "targetname" );
    self setgoal( var_c3c81269, 1 );
    self waittill( #"goal" );
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    function_e966c1c0( 1 );
}

// Namespace hangar
// Params 0
// Checksum 0x6fa33c89, Offset: 0x8210
// Size: 0x52
function function_5b79ea07()
{
    wait 0.5;
    self util::waittill_player_looking_at( level.ai_pallas.origin + ( 0, 0, 64 ), 90 );
    level notify( #"hash_4939dbfa" );
}

// Namespace hangar
// Params 0
// Checksum 0x5d25b98c, Offset: 0x8270
// Size: 0x16
function function_570a8f9e()
{
    wait 5;
    level notify( #"hash_4939dbfa" );
}

// Namespace hangar
// Params 0
// Checksum 0xa753dcbc, Offset: 0x8290
// Size: 0x1da
function prometheus_cover_fire()
{
    spawner::add_spawn_function_ai_group( "taylor_fodder_ai", &function_e3e4f0b8 );
    level flag::wait_till( "friendlies_jump_out_window" );
    level.ai_prometheus thread scene::play( "cin_pro_10_04_hangar_vign_coverfire_prometheus" );
    level thread function_5f5d84df();
    wait 1.5;
    spawn_manager::enable( "hangars_taylor_vign_fodder_manager" );
    level.ai_prometheus dialog::say( "tayr_get_to_exfil_i_got_0" );
    level.ai_prometheus thread function_e547f97a();
    level waittill( #"hash_e3977daa" );
    spawn_manager::disable( "hangars_taylor_vign_fodder_manager" );
    level notify( #"hash_71f2cae" );
    level.ai_prometheus delete();
    var_886e8d99 = getentarray( "hangars_taylor_vign_fodder_spawner_ai", "targetname" );
    
    foreach ( fodder in var_886e8d99 )
    {
        fodder delete();
    }
}

// Namespace hangar
// Params 0
// Checksum 0x6a77c238, Offset: 0x8478
// Size: 0x148
function function_e547f97a()
{
    self endon( #"death" );
    level endon( #"hash_e3977daa" );
    level endon( #"hash_5565b88d" );
    
    while ( true )
    {
        a_enemies = spawner::get_ai_group_ai( "taylor_fodder_ai" );
        
        if ( a_enemies.size === 0 )
        {
            wait 2;
            continue;
        }
        
        foreach ( enemy in a_enemies )
        {
            if ( isalive( enemy ) )
            {
                self ai::shoot_at_target( "normal", enemy, undefined, randomfloatrange( 1, 3 ) );
            }
        }
        
        wait 1.5;
    }
}

// Namespace hangar
// Params 0
// Checksum 0x4b148ff1, Offset: 0x85c8
// Size: 0x136
function function_5f5d84df()
{
    level endon( #"hash_73facd66" );
    level endon( #"hash_5565b88d" );
    
    while ( true )
    {
        level flag::wait_till( "player_in_taylor_coverfire" );
        spawn_manager::enable( "hangars_taylor_vign_fodder_manager" );
        level flag::wait_till_clear( "player_in_taylor_coverfire" );
        spawn_manager::disable( "hangars_taylor_vign_fodder_manager" );
        a_enemies = spawner::get_ai_group_ai( "taylor_fodder_ai" );
        
        foreach ( enemy in a_enemies )
        {
            enemy delete();
        }
    }
}

// Namespace hangar
// Params 0
// Checksum 0x7a6daa2d, Offset: 0x8708
// Size: 0x102
function function_e3e4f0b8()
{
    self endon( #"death" );
    level endon( #"hash_71f2cae" );
    self.attackeraccuracy = 1;
    self.goalradius = 32;
    self.disable_score_events = 1;
    
    if ( isdefined( level.ai_prometheus ) )
    {
        self ai::shoot_at_target( "normal", level.ai_prometheus, undefined, 1000 );
    }
    
    foreach ( player in level.players )
    {
        self setignoreent( player, 1 );
    }
}

// Namespace hangar
// Params 0
// Checksum 0xafd62008, Offset: 0x8818
// Size: 0x7c
function function_e37c0060()
{
    level waittill( #"hash_8413e49c" );
    wait 6;
    level dialog::remote( "hall_diaz_i_m_in_positio_0", undefined, "normal" );
    level.ai_pallas dialog::say( "diaz_copy_that_to_us_h_0" );
    level flag::set( "hangar_5_bc" );
}

// Namespace hangar
// Params 13
// Checksum 0x9c8e27fe, Offset: 0x88a0
// Size: 0x80
function function_e8443509( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, modelindex, psoffsettime, vsurfacenormal )
{
    if ( einflictor === level.var_fac57550 )
    {
        return 0;
    }
}

// Namespace hangar
// Params 0
// Checksum 0x1960b4fb, Offset: 0x8928
// Size: 0xcc
function function_a2041661()
{
    ai_driver = self vehicle::get_rider( "driver" );
    
    if ( isalive( ai_driver ) )
    {
        ai_driver endon( #"death" );
        ai_driver vehicle::get_out();
        n_node = getnode( "vtol_driver_node", "targetname" );
        ai_driver setgoal( n_node, 1 );
        ai_driver util::stop_magic_bullet_shield();
    }
}

// Namespace hangar
// Params 7
// Checksum 0x7f86be11, Offset: 0x8a00
// Size: 0x2dc
function hangar_gate_close( b_restarting, var_280d5f68, var_3c301126, var_9c7511b4, var_205c499a, var_c2777dd9, var_902e27b5 )
{
    if ( b_restarting )
    {
        var_280d5f68 moveto( var_9c7511b4.origin, 0.05 );
        var_3c301126 moveto( var_205c499a.origin, 0.05 );
        level thread scene::skipto_end( var_c2777dd9 );
        var_3c301126 disconnectpaths();
        var_280d5f68 disconnectpaths();
        return;
    }
    
    level thread scene::play( var_c2777dd9 );
    var_280d5f68 moveto( var_9c7511b4.origin, 6 );
    var_3c301126 moveto( var_205c499a.origin, 6 );
    sndnum = randomint( 2 );
    var_280d5f68 playsound( "evt_hangar_door_start_l_" + sndnum );
    var_3c301126 playsound( "evt_hangar_door_start_r_" + sndnum );
    var_280d5f68 playloopsound( "evt_hangar_door_loop_l", 2 );
    var_3c301126 playloopsound( "evt_hangar_door_loop_r", 2 );
    var_3c301126 waittill( #"movedone" );
    var_3c301126 disconnectpaths();
    var_280d5f68 disconnectpaths();
    var_280d5f68 stoploopsound( 0.25 );
    var_3c301126 stoploopsound( 0.25 );
    var_280d5f68 playsound( "evt_hangar_door_stop_l" );
    var_3c301126 playsound( "evt_hangar_door_stop_r" );
    
    if ( isdefined( var_902e27b5 ) )
    {
        umbragate_set( var_902e27b5, 0 );
    }
}

// Namespace hangar
// Params 0
// Checksum 0xca9e620c, Offset: 0x8ce8
// Size: 0xe4
function function_10ab649()
{
    var_280d5f68 = getent( "plane_hangar_out_l", "targetname" );
    var_3c301126 = getent( "plane_hangar_out_r", "targetname" );
    s_door_loc = struct::get( "plane_hangar_exit_close", "targetname" );
    var_280d5f68 moveto( s_door_loc.origin, 0.5 );
    var_3c301126 moveto( s_door_loc.origin, 0.5 );
}

// Namespace hangar
// Params 0
// Checksum 0x64dec6f6, Offset: 0x8dd8
// Size: 0xec
function function_9ada4a46()
{
    level endon( #"hash_cb897bce" );
    var_32400ae0 = getent( "trig_dam_vtol_grenade_accolade", "targetname" );
    var_32400ae0 setcandamage( 0 );
    level flag::wait_till( "2nd_hangar_apc_in_pos" );
    wait 0.5;
    var_32400ae0 setcandamage( 1 );
    var_32400ae0 trigger::wait_till();
    
    if ( isplayer( var_32400ae0.who ) )
    {
        prologue_accolades::function_470fe5d8( var_32400ae0.who );
    }
}

// Namespace hangar
// Params 1
// Checksum 0x7c0cc7ba, Offset: 0x8ed0
// Size: 0x48
function function_e966c1c0( b_aim )
{
    level.ai_hendricks.perfectaim = b_aim;
    level.ai_khalil.perfectaim = b_aim;
    level.ai_pallas.perfectaim = b_aim;
}

// Namespace hangar
// Params 2
// Checksum 0x22ce66cc, Offset: 0x8f20
// Size: 0x294
function dynamic_run_speed( var_c047ec73, var_3b15866b )
{
    if ( !isdefined( var_c047ec73 ) )
    {
        var_c047ec73 = 250;
    }
    
    if ( !isdefined( var_3b15866b ) )
    {
        var_3b15866b = var_c047ec73 * 0.5;
    }
    
    self notify( #"start_dynamic_run_speed" );
    self endon( #"death" );
    self endon( #"start_dynamic_run_speed" );
    self endon( #"stop_dynamic_run_speed" );
    self thread stop_dynamic_run_speed();
    
    while ( true )
    {
        wait 0.05;
        
        if ( !isdefined( self.goalpos ) )
        {
            continue;
        }
        
        v_goal = self.goalpos;
        e_player = arraygetclosest( v_goal, level.players );
        e_closest = arraygetclosest( v_goal, array( e_player, self ) );
        n_dist = distance2dsquared( self.origin, e_player.origin );
        is_behind = isplayer( e_closest );
        
        if ( n_dist < var_3b15866b * var_3b15866b || is_behind )
        {
            self ai::set_behavior_attribute( "cqb", 0 );
            self ai::set_behavior_attribute( "sprint", 1 );
            continue;
        }
        
        if ( n_dist < var_c047ec73 * var_c047ec73 )
        {
            self ai::set_behavior_attribute( "cqb", 0 );
            self ai::set_behavior_attribute( "sprint", 0 );
            continue;
        }
        
        if ( n_dist > var_c047ec73 * var_c047ec73 * 1.25 )
        {
            self ai::set_behavior_attribute( "cqb", 1 );
            self ai::set_behavior_attribute( "sprint", 0 );
            continue;
        }
    }
}

// Namespace hangar
// Params 0
// Checksum 0x1b5ab6f9, Offset: 0x91c0
// Size: 0x64
function stop_dynamic_run_speed()
{
    self endon( #"start_dynamic_run_speed" );
    self endon( #"death" );
    self waittill( #"stop_dynamic_run_speed" );
    self ai::set_behavior_attribute( "cqb", 0 );
    self ai::set_behavior_attribute( "sprint", 0 );
}

// Namespace hangar
// Params 1
// Checksum 0x5b8ca4cc, Offset: 0x9230
// Size: 0xdc
function function_ce858cd3( b_up )
{
    if ( !isdefined( b_up ) )
    {
        b_up = 0;
    }
    
    e_collision = getent( "hangar_vtol_crash_clip", "targetname" );
    e_collision connectpaths();
    
    if ( b_up )
    {
        e_collision movez( 1000, 0.05 );
    }
    else
    {
        e_collision movez( -1000, 0.05 );
    }
    
    wait 0.05;
    
    if ( isdefined( e_collision ) )
    {
        e_collision disconnectpaths( 0, 0 );
    }
}

// Namespace hangar
// Params 1
// Checksum 0xa7bb8fac, Offset: 0x9318
// Size: 0xcc
function function_d3c9b1d1( params )
{
    if ( !isdefined( level.ai_pallas ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_fa73812c ) )
    {
        level.var_fa73812c = 1;
        level.var_446343dd = 0;
    }
    
    var_efeac590 = gettime();
    
    if ( level.var_fa73812c || isplayer( params.eattacker ) && 10000 < var_efeac590 - level.var_446343dd )
    {
        level.ai_pallas notify( #"scriptedbc", "generic_encourage" );
        level.var_446343dd = var_efeac590;
        level.var_fa73812c = 0;
    }
}

