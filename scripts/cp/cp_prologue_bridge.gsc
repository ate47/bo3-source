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
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace jeep_alley;

// Namespace jeep_alley
// Params 0
// Checksum 0x265a3df, Offset: 0x1490
// Size: 0x3c
function jeep_alley_start()
{
    jeep_alley_precache();
    jeep_alley_heros_init();
    level thread jeep_alley_main();
}

// Namespace jeep_alley
// Params 0
// Checksum 0x3b82d5d3, Offset: 0x14d8
// Size: 0x3e
function jeep_alley_precache()
{
    level flag::init( "sarah_wall_running" );
    level._effect[ "fx_apc_fire" ] = "fire/fx_fire_apc_bridge_prologue";
}

// Namespace jeep_alley
// Params 0
// Checksum 0xaf8ac5b7, Offset: 0x1520
// Size: 0x17c
function jeep_alley_heros_init()
{
    level.ai_theia ai::set_ignoreall( 1 );
    level.ai_theia ai::set_ignoreme( 1 );
    level.ai_theia.goalradius = 16;
    level.ai_theia.allowpain = 0;
    level.ai_theia colors::set_force_color( "c" );
    level.ai_khalil ai::set_ignoreall( 0 );
    level.ai_khalil ai::set_ignoreme( 0 );
    level.ai_khalil.goalradius = 16;
    level.ai_minister ai::set_ignoreall( 1 );
    level.ai_minister ai::set_ignoreme( 1 );
    level.ai_minister.goalradius = 16;
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_hendricks ai::set_ignoreme( 0 );
    level.ai_hendricks.goalradius = 16;
    level.ai_hendricks.allowpain = 0;
}

// Namespace jeep_alley
// Params 0
// Checksum 0x9e81a08e, Offset: 0x16a8
// Size: 0x31c
function jeep_alley_main()
{
    level scene::add_scene_func( "cin_pro_11_01_jeepalley_vign_engage_fireloop", &function_cf946de6, "play" );
    level thread scene::play( "cin_pro_11_01_jeepalley_vign_engage_fireloop" );
    level thread function_9855f3c9();
    level.ai_hendricks thread function_75853acc();
    level thread namespace_21b2c1f2::function_37906040();
    level.ai_khalil battlechatter::function_d9f49fba( 1 );
    level.ai_hendricks battlechatter::function_d9f49fba( 1 );
    level.ai_theia sethighdetail( 1 );
    level thread function_1e1e465e();
    
    if ( isdefined( level.bzm_prologuedialogue5_1callback ) )
    {
        level thread [[ level.bzm_prologuedialogue5_1callback ]]();
    }
    
    level scene::add_scene_func( "cin_pro_11_01_jeepalley_vign_engage_start", &function_fcc9ed10, "play" );
    level scene::play( "cin_pro_11_01_jeepalley_vign_engage_start" );
    level flag::wait_till( "trig_player_exits_vtol" );
    level thread function_b830a432();
    level flag::set( "sarah_wall_running" );
    level flag::init( "theia_shoot_plane" );
    level flag::init( "plane_explodes" );
    level scene::add_scene_func( "cin_pro_11_01_jeepalley_vign_engage_attack", &function_54cdd83a, "play" );
    level scene::add_scene_func( "cin_pro_11_01_jeepalley_vign_engage_attack", &function_7af067f4, "done" );
    level thread scene::play( "cin_pro_11_01_jeepalley_vign_engage_attack" );
    level thread function_87513084();
    level thread function_87f18673();
    level flag::wait_till( "player_moves_up_alley" );
    objectives::hide( "cp_level_prologue_get_to_the_surface" );
    skipto::objective_completed( "skipto_jeep_alley" );
}

// Namespace jeep_alley
// Params 1
// Checksum 0x38f038cc, Offset: 0x19d0
// Size: 0x5c
function function_54cdd83a( a_ents )
{
    level waittill( #"theia_shoot_plane" );
    level flag::set( "theia_shoot_plane" );
    level waittill( #"plane_explodes" );
    level flag::set( "plane_explodes" );
}

// Namespace jeep_alley
// Params 1
// Checksum 0x524f1e6e, Offset: 0x1a38
// Size: 0x180
function function_fcc9ed10( a_ents )
{
    a_ents[ "sarah_victim" ].cybercomtargetstatusoverride = 0;
    a_ents[ "sarah_victim" ] cybercom::cybercom_aioptout( "cybercom_fireflyswarm" );
    mdl_door_left = getent( "hall_door_slide_left", "targetname" );
    mdl_door_left connectpaths();
    wait 0.05;
    mdl_door_right = getent( "hall_door_slide_right", "targetname" );
    mdl_door_right connectpaths();
    vec_right = anglestoright( mdl_door_left.angles );
    mdl_door_left moveto( mdl_door_left.origin - vec_right * 48, 0.5 );
    mdl_door_right moveto( mdl_door_right.origin + vec_right * 48, 0.5 );
    level.var_c644a3e7 = 1;
}

// Namespace jeep_alley
// Params 0
// Checksum 0x90a6f1b4, Offset: 0x1bc0
// Size: 0x280
function function_b830a432()
{
    level endon( #"bridge_battle_done" );
    
    if ( level.var_c644a3e7 === 1 )
    {
        var_7ed6188 = getent( "t_all_players_in_vtol_collapse_hangar", "targetname" );
        
        while ( level.ai_hendricks istouching( var_7ed6188 ) || level.ai_khalil istouching( var_7ed6188 ) || level.ai_minister istouching( var_7ed6188 ) )
        {
            wait 0.1;
        }
        
        level flag::wait_till( "no_players_in_vtol_collapse_hangar" );
        var_ac769486 = getent( "clip_player_hall_doors", "targetname" );
        var_ac769486 movez( 100 * -1, 0.05 );
        mdl_door_left = getent( "hall_door_slide_left", "targetname" );
        mdl_door_right = getent( "hall_door_slide_right", "targetname" );
        vec_right = anglestoright( mdl_door_left.angles );
        mdl_door_left moveto( mdl_door_left.origin + vec_right * 48, 0.5 );
        mdl_door_right moveto( mdl_door_right.origin - vec_right * 48, 0.5 );
        wait 0.05;
        var_ac769486 disconnectpaths( 0, 0 );
        
        if ( isdefined( level.ai_pallas ) )
        {
            level.ai_pallas delete();
        }
        
        level.var_c644a3e7 = 0;
    }
}

// Namespace jeep_alley
// Params 1
// Checksum 0x957e5b4d, Offset: 0x1e48
// Size: 0x168
function function_cf946de6( a_ents )
{
    level endon( #"hash_86483bce" );
    vh_jeep = a_ents[ "jeep_alley" ];
    vh_jeep hidepart( "tag_weapon", "veh_t7_lmg_brm_world", 1 );
    level flag::wait_till( "trig_player_exits_vtol" );
    var_786c2b27 = a_ents[ "machinegun" ];
    var_6c3c4545 = getweapon( "turret_bo3_civ_truck_pickup_tech_nrc" );
    
    while ( true )
    {
        var_786c2b27 waittill( #"fire" );
        v_start_pos = var_786c2b27 gettagorigin( "tag_flash" );
        v_end_pos = v_start_pos + anglestoforward( var_786c2b27 gettagangles( "tag_flash" ) ) * 120;
        magicbullet( var_6c3c4545, v_start_pos, v_end_pos, var_786c2b27 );
    }
}

// Namespace jeep_alley
// Params 1
// Checksum 0xc3a0d48a, Offset: 0x1fb8
// Size: 0x5c
function function_7af067f4( a_ents )
{
    level notify( #"hash_86483bce" );
    a_ents[ "theia" ] thread function_467bdccf();
    a_ents[ "theia" ] sethighdetail( 0 );
}

// Namespace jeep_alley
// Params 0
// Checksum 0xdbe61809, Offset: 0x2020
// Size: 0x1a4
function function_75853acc()
{
    level flag::wait_till( "sarah_wall_running" );
    self colors::disable();
    self setgoal( getnode( "hendricks_kill_jeep_alley", "targetname" ), 1 );
    self.perfectaim = 1;
    self ai::set_behavior_attribute( "useGrenades", 0 );
    level waittill( #"hash_ec12613" );
    var_af97b78b = spawner::get_ai_group_ai( "jeep_alley_enemy" );
    
    for ( i = 0; i < var_af97b78b.size ; i++ )
    {
        if ( isalive( var_af97b78b[ i ] ) )
        {
            self ai::shoot_at_target( "shoot_until_target_dead", var_af97b78b[ i ], "j_head" );
        }
    }
    
    self.perfectaim = 0;
    self colors::enable();
    self ai::set_behavior_attribute( "useGrenades", 1 );
    trigger::use( "jeep_alley_allies_move", "targetname" );
}

// Namespace jeep_alley
// Params 0
// Checksum 0x735f7547, Offset: 0x21d0
// Size: 0x32c
function function_87513084()
{
    spawner::add_spawn_function_group( "plane_burn_victims", "targetname", &ai::set_ignoreme, 1 );
    var_5aed614f = spawner::simple_spawn( "plane_burn_victims" );
    level flag::wait_till( "theia_shoot_plane" );
    level.ai_khalil ai::set_ignoreall( 0 );
    level flag::wait_till( "plane_explodes" );
    level util::clientnotify( "sndStartFakeBattle" );
    
    foreach ( burner in var_5aed614f )
    {
        if ( isalive( burner ) )
        {
            burner thread function_d9205aac();
        }
    }
    
    level thread scene::play( "p7_fxanim_cp_prologue_plane_hanger_explode_bundle" );
    
    while ( !scene::is_ready( "p7_fxanim_cp_prologue_plane_hanger_explode_bundle" ) )
    {
        wait 0.05;
    }
    
    level thread scene::stop( "p7_fxanim_cp_prologue_plane_hanger_pristine_bundle", 1 );
    mdl_plane = getent( "plane_hanger_explode", "targetname" );
    mdl_plane setmodel( "veh_t7_mil_jet_cargo_dest" );
    
    foreach ( e_player in level.players )
    {
        e_player playrumbleonentity( "tank_damage_heavy_mp" );
        earthquake( 1, 1.5, e_player.origin, 128 );
    }
    
    level.bridge_marker = struct::get( "bridge_obj", "targetname" );
    objectives::set( "cp_waypoint_breadcrumb", level.bridge_marker );
}

// Namespace jeep_alley
// Params 0
// Checksum 0x39e3764, Offset: 0x2508
// Size: 0x5c
function function_d9205aac()
{
    var_899774be = randomintrange( 1, 9 );
    str_anim_name = "cin_gen_vign_plane_burning_0" + var_899774be;
    self thread scene::play( str_anim_name, self );
}

// Namespace jeep_alley
// Params 0
// Checksum 0xa60bb869, Offset: 0x2570
// Size: 0x124
function function_467bdccf()
{
    self setgoal( self.origin, 1 );
    var_e71bd5d8 = struct::get( "theia_bridge_target", "targetname" );
    var_a03ca40a = spawn( "script_model", var_e71bd5d8.origin );
    var_a03ca40a setmodel( "tag_origin" );
    var_a03ca40a.health = 100000;
    self thread ai::shoot_at_target( "shoot_until_target_dead", var_a03ca40a );
    level flag::wait_till( "player_left_alley" );
    var_a03ca40a kill();
    self ai::set_ignoreall( 0 );
}

// Namespace jeep_alley
// Params 0
// Checksum 0x6cd97884, Offset: 0x26a0
// Size: 0x7c
function function_9855f3c9()
{
    spawner::add_spawn_function_ai_group( "jeep_alley_enemy", &function_46e24498 );
    spawner::simple_spawn( "sp_initial_jeep_enemies" );
    level flag::wait_till( "trig_player_exits_vtol" );
    spawner::simple_spawn( "sp_jeep_alley_cqb" );
}

// Namespace jeep_alley
// Params 0
// Checksum 0x763845f5, Offset: 0x2728
// Size: 0xcc
function function_46e24498()
{
    self endon( #"death" );
    self.grenadeammo = 0;
    self ai::set_behavior_attribute( "cqb", 1 );
    self ai::set_behavior_attribute( "disablesprint", 1 );
    level flag::wait_till( "sarah_wall_running" );
    wait randomfloatrange( 0.25, 2 );
    self.health = 30;
    self ai::shoot_at_target( "shoot_until_target_dead", level.ai_theia );
}

// Namespace jeep_alley
// Params 0
// Checksum 0xab8341ec, Offset: 0x2800
// Size: 0x124
function function_87f18673()
{
    level waittill( #"hash_1e79e193" );
    level.ai_theia thread dialog::say( "hall_get_to_the_bridge_i_0" );
    level waittill( #"hash_8cc62724" );
    level.ai_theia dialog::say( "hall_exfil_ahead_push_fo_0" );
    
    if ( !level flag::get( "player_left_alley" ) )
    {
        level dialog::remote( "tayr_better_hustle_picku_0", 0.5 );
    }
    
    if ( !level flag::get( "player_left_alley" ) )
    {
        if ( !isdefined( level.ai_hyperion ) )
        {
            level.ai_hyperion = util::get_hero( "hyperion" );
        }
        
        level.ai_hyperion dialog::say( "mare_on_me_on_me_0", 0.2 );
    }
}

// Namespace jeep_alley
// Params 0
// Checksum 0x3ef17058, Offset: 0x2930
// Size: 0x4c
function function_1e1e465e()
{
    level waittill( #"hash_60a343a0" );
    level.ai_theia dialog::say( "hall_that_technical_s_min_0" );
    level thread namespace_21b2c1f2::function_b83aa9c5();
}

#namespace bridge_battle;

// Namespace bridge_battle
// Params 0
// Checksum 0x861a041f, Offset: 0x2988
// Size: 0x54
function bridge_battle_start()
{
    bridge_battle_precache();
    bridge_battle_heros_init();
    level thread bridge_battle_main();
    level thread namespace_21b2c1f2::function_b83aa9c5();
}

// Namespace bridge_battle
// Params 0
// Checksum 0xa3429ddb, Offset: 0x29e8
// Size: 0x44
function bridge_battle_precache()
{
    level flag::init( "play_bridge_nag" );
    level flag::init( "bridge_intro_chatter_done" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0x556522ee, Offset: 0x2a38
// Size: 0x1d4
function bridge_battle_heros_init()
{
    level.ai_hyperion ai::set_ignoreall( 1 );
    level.ai_hyperion ai::set_ignoreme( 1 );
    level.ai_hyperion.goalradius = 16;
    level.ai_hyperion.allowpain = 0;
    level.ai_hyperion colors::set_force_color( "p" );
    level.ai_theia ai::set_ignoreme( 1 );
    level.ai_khalil ai::set_ignoreall( 1 );
    level.ai_khalil ai::set_ignoreme( 1 );
    level.ai_khalil.goalradius = 16;
    level.ai_minister ai::set_ignoreall( 1 );
    level.ai_minister ai::set_ignoreme( 1 );
    level.ai_minister ai::set_behavior_attribute( "coverIdleOnly", 1 );
    level.ai_minister.goalradius = 16;
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_hendricks ai::set_ignoreme( 0 );
    level.ai_hendricks.goalradius = 16;
    level.ai_hendricks.allowpain = 0;
}

// Namespace bridge_battle
// Params 0
// Checksum 0xba06ca30, Offset: 0x2c18
// Size: 0x1ac
function bridge_battle_main()
{
    objectives::set( "cp_level_prologue_cross_bridge" );
    callback::on_vehicle_killed( &prologue_accolades::function_3d89871d );
    level thread function_401aadf2();
    level thread function_cd931b6e();
    level thread function_86b76a0b();
    level thread hyperion_bridge_dialog();
    level.ai_hyperion thread function_373c3957();
    exploder::exploder( "light_exploder_bridge" );
    level thread function_19d07c7a();
    function_45506c4a();
    wait 2;
    level thread function_3178e821();
    objectives::hide( "cp_level_prologue_cross_bridge" );
    savegame::checkpoint_save();
    objectives::set( "cp_level_prologue_escort_data_center" );
    level thread bridge_compromised_dialog();
    callback::remove_on_vehicle_killed( &prologue_accolades::function_3d89871d );
    building_hacking();
    skipto::objective_completed( "skipto_bridge_battle" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0x6b6bd3c6, Offset: 0x2dd0
// Size: 0x1c4
function function_cd931b6e()
{
    spawner::add_spawn_function_group( "bridge_wave_1", "script_noteworthy", &function_39c16a4a );
    spawner::add_spawn_function_group( "sp_bridge_initial", "targetname", &function_39c16a4a );
    spawner::add_spawn_function_group( "sp_bridge_secondary", "targetname", &function_39c16a4a );
    spawner::add_spawn_function_group( "bridge_enemies", "script_noteworthy", &cp_prologue_util::remove_grenades );
    spawner::simple_spawn( "sp_bridge_initial" );
    level flag::wait_till( "player_left_alley" );
    spawner::simple_spawn( "sp_bridge_front" );
    spawn_manager::enable( "CQB_spawner_right" );
    spawn_manager::enable( "CQB_spawner_left" );
    level thread function_57ae876e();
    level thread function_58b194a5();
    level thread function_2fdac05f();
    level thread function_d32d88c();
    wait 10;
    spawner::simple_spawn( "sp_bridge_secondary" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0x374f1e2c, Offset: 0x2fa0
// Size: 0x184
function function_39c16a4a()
{
    self endon( #"death" );
    
    if ( !isdefined( self.target ) )
    {
        var_257bbc01 = getent( "trig_bridge_goal_vol_1", "targetname" );
        self setgoal( var_257bbc01 );
    }
    
    level flag::wait_till( "bridge_enemies_fallback_1" );
    var_257bbc01 = getent( "trig_bridge_goal_vol_2", "targetname" );
    self setgoal( var_257bbc01 );
    level flag::wait_till( "bridge_enemies_fallback_2" );
    var_257bbc01 = getent( "trig_bridge_goal_vol_3", "targetname" );
    self setgoal( var_257bbc01 );
    level flag::wait_till( "bridge_enemies_fallback_3" );
    var_257bbc01 = getent( "trig_bridge_goal_vol_4", "targetname" );
    self setgoal( var_257bbc01 );
}

// Namespace bridge_battle
// Params 0
// Checksum 0xfa49f1c, Offset: 0x3130
// Size: 0x6c
function function_57ae876e()
{
    level endon( #"hash_babbfab3" );
    level flag::wait_till( "bring_in_jeeps" );
    spawner::waittill_ai_group_ai_count( "aig_bridge_defenders", 8 );
    spawn_manager::enable( "bridge_reinforcement_spawner", 1 );
}

// Namespace bridge_battle
// Params 0
// Checksum 0x7c4d5415, Offset: 0x31a8
// Size: 0x1dc
function function_d32d88c()
{
    level thread function_6e72a6d1();
    level flag::wait_till( "bring_in_jeeps" );
    level thread function_823e535e();
    var_4f41d1d9 = vehicle::simple_spawn_single( "bridge_jeep_right" );
    var_4f41d1d9 playsound( "evt_jeeps_pre_bridge_drive" );
    var_a2623c0a = vehicle::simple_spawn_single( "bridge_jeep_left" );
    var_a2623c0a.var_52c5472d = 1;
    var_4f41d1d9.var_52c5472d = 1;
    level thread function_c4e1973c( var_4f41d1d9 );
    level thread function_c4e1973c( var_a2623c0a );
    var_4f41d1d9 thread function_9069a713();
    var_a2623c0a thread function_9069a713();
    objectives::complete( "cp_waypoint_breadcrumb", level.bridge_marker );
    var_a2623c0a thread function_7096928d( "cp_level_prologue_destroy_jeep_left" );
    var_4f41d1d9 thread function_7096928d( "cp_level_prologue_destroy_jeep_left" );
    level.var_8c902673 = array( var_a2623c0a, var_4f41d1d9 );
    level thread function_5d5b8625();
}

// Namespace bridge_battle
// Params 0
// Checksum 0x6c7ff11b, Offset: 0x3390
// Size: 0x24
function function_6e72a6d1()
{
    wait 30;
    level flag::set( "bring_in_jeeps" );
}

// Namespace bridge_battle
// Params 1
// Checksum 0x9cebc485, Offset: 0x33c0
// Size: 0xfc
function function_7096928d( str_obj )
{
    self thread turret::disable_ai_getoff( 1, 1 );
    self waittill( #"hash_449a82fd" );
    ai_rider = self vehicle::get_rider( "gunner1" );
    ai_rider ai::set_ignoreme( 1 );
    ai_rider thread function_da187c1b( self );
    objectives::set( str_obj, self );
    self waittill( #"death" );
    
    if ( !isdefined( self.var_ceae8e35 ) )
    {
        objectives::complete( str_obj, self );
    }
    
    level flag::set( "bridge_destruction_sequence" );
}

// Namespace bridge_battle
// Params 1
// Checksum 0x1e74ea1e, Offset: 0x34c8
// Size: 0x74
function function_da187c1b( vh_jeep )
{
    self waittill( #"death" );
    wait randomfloatrange( 2, 4 );
    
    if ( isalive( vh_jeep ) )
    {
        vh_jeep kill();
    }
}

// Namespace bridge_battle
// Params 0
// Checksum 0xb0e9c6e9, Offset: 0x3548
// Size: 0x44
function function_5d5b8625()
{
    level flag::wait_till( "bridge_intro_chatter_done" );
    level.ai_hendricks dialog::say( "hend_only_way_across_the_0" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0x1a5c7f16, Offset: 0x3598
// Size: 0x24
function function_823e535e()
{
    wait 45;
    level flag::set( "bridge_destruction_sequence" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0xa66ba0a2, Offset: 0x35c8
// Size: 0x2c
function function_9069a713()
{
    self waittill( #"start_firing" );
    self turret::enable( 1, 1 );
}

// Namespace bridge_battle
// Params 0
// Checksum 0xabfc8ae9, Offset: 0x3600
// Size: 0x3c
function function_58b194a5()
{
    level flag::wait_till( "bring_in_sniper_2" );
    spawner::simple_spawn( "sp_bridge_sniper_right" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0xa3744aa3, Offset: 0x3648
// Size: 0xa4
function function_2fdac05f()
{
    level flag::wait_till( "bring_in_trucks" );
    level thread function_ec50ea55( "bridge_battle_flatbed_left_1" );
    level thread function_ec50ea55( "bridge_battle_flatbed_right_1" );
    wait 2;
    level thread function_ec50ea55( "bridge_battle_flatbed_left_2" );
    level thread function_ec50ea55( "bridge_battle_flatbed_right_2" );
}

// Namespace bridge_battle
// Params 2
// Checksum 0x57b36480, Offset: 0x36f8
// Size: 0x74
function function_58377d0( vehiclename, name )
{
    ai_rider = vehiclename vehicle::get_rider( name );
    
    if ( isdefined( ai_rider ) )
    {
        ai_rider thread vehicle::get_out();
        ai_rider thread function_39c16a4a();
    }
}

// Namespace bridge_battle
// Params 1
// Checksum 0xc38dfc25, Offset: 0x3778
// Size: 0x8c
function function_ec50ea55( str_vehicle )
{
    vh_vehicle = vehicle::simple_spawn_single( str_vehicle );
    vh_vehicle thread vehicle::go_path();
    vh_vehicle waittill( #"reached_end_node" );
    function_58377d0( vh_vehicle, "driver" );
    function_58377d0( vh_vehicle, "passenger1" );
}

// Namespace bridge_battle
// Params 1
// Checksum 0x27567842, Offset: 0x3810
// Size: 0x15c
function function_c4e1973c( vh_vehicle )
{
    vh_vehicle thread vehicle::go_path();
    vh_vehicle waittill( #"reached_end_node" );
    ai_rider = vh_vehicle vehicle::get_rider( "passenger1" );
    
    if ( isalive( ai_rider ) )
    {
        ai_rider thread vehicle::get_out();
        ai_rider thread function_39c16a4a();
    }
    
    ai_gunner = vh_vehicle vehicle::get_rider( "gunner1" );
    
    if ( isalive( ai_gunner ) )
    {
        ai_gunner waittill( #"death" );
    }
    
    ai_driver = vh_vehicle vehicle::get_rider( "driver" );
    
    if ( isalive( ai_driver ) )
    {
        ai_driver thread vehicle::get_out();
        ai_driver thread function_39c16a4a();
    }
}

// Namespace bridge_battle
// Params 0
// Checksum 0xc00bac87, Offset: 0x3978
// Size: 0x16c
function function_19d07c7a()
{
    var_82079741 = spawner::simple_spawn_single( "floodlight_left" );
    var_8386532c = spawner::simple_spawn_single( "floodlight_right" );
    var_82079741 vehicle::lights_on();
    var_8386532c vehicle::lights_on();
    level waittill( #"hash_69473677" );
    
    if ( isdefined( var_82079741 ) )
    {
        var_82079741 vehicle::lights_off();
        var_8386532c vehicle::lights_off();
        var_82079741.delete_on_death = 1;
        var_82079741 notify( #"death" );
        
        if ( !isalive( var_82079741 ) )
        {
            var_82079741 delete();
        }
        
        wait 0.05;
        var_8386532c.delete_on_death = 1;
        var_8386532c notify( #"death" );
        
        if ( !isalive( var_8386532c ) )
        {
            var_8386532c delete();
        }
    }
}

// Namespace bridge_battle
// Params 0
// Checksum 0xeed64f96, Offset: 0x3af0
// Size: 0x17c
function function_45506c4a()
{
    level flag::wait_till( "bridge_destruction_sequence" );
    level notify( #"hash_91d75f4e" );
    level thread function_61ebf180();
    battlechatter::function_d9f49fba( 0 );
    var_b729b603 = getent( "trig_bridge_vehicle_delete", "targetname" );
    level thread trigger::trigger_delete_on_touch( var_b729b603 );
    wait 2;
    level.a_veh_bridge_reinforcements = [];
    level thread bridge_vehicles_background( "bridge_macv_convoy1", 3, 2 );
    wait 1;
    level thread bridge_vehicles_background( "bridge_macv_convoy2", 3, 2 );
    wait 1.5;
    level.ai_hendricks dialog::say( "hend_reinforcements_comin_0" );
    wait 0.25;
    level.ai_hendricks dialog::say( "hend_we_re_not_getting_ac_0" );
    wait 0.4;
    level.ai_hyperion dialog::say( "mare_fuck_it_plan_b_0" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0x2dff309d, Offset: 0x3c78
// Size: 0x28a
function function_61ebf180()
{
    level waittill( #"hash_2cc5e83" );
    level thread function_b61c8c58();
    level scene::add_scene_func( "p7_fxanim_cp_prologue_bridge_bundle", &function_cefcd22a );
    level scene::add_scene_func( "p7_fxanim_cp_prologue_bridge_bundle", &function_27bfa6a0, "done" );
    level thread scene::play( "p7_fxanim_cp_prologue_bridge_bundle" );
    exploder::stop_exploder( "light_exploder_bridge" );
    array::run_all( level.a_veh_bridge_reinforcements, &function_908069e9 );
    level notify( #"hash_babbfab3" );
    trigger::use( "trig_kill_cqb_spawner_right", "targetname", undefined, 0 );
    trigger::use( "trig_kill_cqb_spawner_left", "targetname", undefined, 0 );
    trigger::use( "trig_kill_bridge_reinforcement_spawner", "targetname", undefined, 0 );
    level thread function_a34a09b4();
    wait 0.5;
    level thread namespace_21b2c1f2::function_3c37ec50();
    
    foreach ( vh_jeep in level.var_8c902673 )
    {
        if ( isalive( vh_jeep ) )
        {
            vh_jeep.var_ceae8e35 = 1;
            objectives::complete( "cp_level_prologue_destroy_jeep_left", vh_jeep );
            radiusdamage( vh_jeep.origin, 96, 1000, 500, level.ai_hendricks, "MOD_GRENADE" );
            wait 0.75;
        }
    }
}

// Namespace bridge_battle
// Params 0
// Checksum 0x6419687, Offset: 0x3f10
// Size: 0xe2
function function_a34a09b4()
{
    a_ai_axis = getaiteamarray( "axis" );
    
    foreach ( ai in a_ai_axis )
    {
        if ( isalive( ai ) )
        {
            ai ai::bloody_death();
            wait randomfloatrange( 0.1, 0.3 );
        }
    }
}

// Namespace bridge_battle
// Params 1
// Checksum 0x58000fe6, Offset: 0x4000
// Size: 0x54
function function_cefcd22a( a_ents )
{
    level thread cp_prologue_util::function_2a0bc326( level.ai_hendricks.origin, 0.5, 1.5, 5000, 5, "damage_heavy" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0x3cbba9a, Offset: 0x4060
// Size: 0x4c4
function function_b61c8c58()
{
    var_a02e914a = getent( "bridge_section_top", "targetname" );
    var_a02e914a delete();
    var_725be530 = getent( "bridge_section_bottom", "targetname" );
    var_725be530 delete();
    level thread scene::play( "bridge_tent_01" );
    var_59ff07ee = getent( "bridge_section_1", "targetname" );
    var_59ff07ee delete();
    var_57376852 = getent( "bridge_damage_origin_1", "targetname" );
    radiusdamage( var_57376852.origin, 450, 2000, 2000, undefined, "MOD_EXPLOSIVE" );
    level thread bridge_rumble();
    level waittill( #"hash_85385801" );
    level thread scene::play( "bridge_tent_02" );
    var_33fc8d85 = getent( "bridge_section_2", "targetname" );
    var_33fc8d85 delete();
    var_3134ede9 = getent( "bridge_damage_origin_2", "targetname" );
    radiusdamage( var_3134ede9.origin, 450, 2000, 2000, undefined, "MOD_EXPLOSIVE" );
    level thread bridge_rumble();
    level waittill( #"hash_5f35dd98" );
    var_dfa131c = getent( "bridge_section_3", "targetname" );
    var_dfa131c delete();
    var_b327380 = getent( "bridge_damage_origin_3", "targetname" );
    radiusdamage( var_b327380.origin, 450, 2000, 2000, undefined, "MOD_EXPLOSIVE" );
    level thread bridge_rumble();
    level waittill( #"hash_69473677" );
    level thread scene::play( "bridge_tent_03" );
    var_e7f798b3 = getentarray( "bridge_section_4", "targetname" );
    array::run_all( var_e7f798b3, &delete );
    var_1543cc5f = getent( "bridge_damage_origin_4", "targetname" );
    radiusdamage( var_1543cc5f.origin, 800, 3000, 3000, undefined, "MOD_EXPLOSIVE" );
    level thread bridge_rumble();
    var_2bb8ffb8 = getentarray( "bridge_macv_convoy1_vh", "targetname" );
    var_bd827604 = struct::get( "struct_macv_fx", "targetname" );
    var_85d8db71 = arraygetclosest( var_bd827604.origin, var_2bb8ffb8 );
    var_85d8db71 thread fx::play( "fx_apc_fire", var_85d8db71.origin, var_85d8db71.angles, undefined, 1, "tag_origin" );
}

// Namespace bridge_battle
// Params 1
// Checksum 0xc7666154, Offset: 0x4530
// Size: 0xba
function function_27bfa6a0( a_ents )
{
    showmiscmodels( "fxanim_bridge_static2" );
    util::wait_network_frame();
    
    foreach ( ent in a_ents )
    {
        ent delete();
    }
}

// Namespace bridge_battle
// Params 0
// Checksum 0xc9bf417d, Offset: 0x45f8
// Size: 0x46
function function_908069e9()
{
    for ( i = 1; i < 5 ; i++ )
    {
        self turret::stop( i );
    }
}

// Namespace bridge_battle
// Params 0
// Checksum 0x49e2c997, Offset: 0x4648
// Size: 0xc2
function bridge_rumble()
{
    foreach ( e_player in level.players )
    {
        e_player playrumbleonentity( "tank_damage_heavy_mp" );
        earthquake( 0.3, 1, e_player.origin, 128 );
    }
}

// Namespace bridge_battle
// Params 2
// Checksum 0xbb919312, Offset: 0x4718
// Size: 0x8c
function bridge_vehicles_troop_trucks( truck, spawner )
{
    vh_truck1 = vehicle::simple_spawn_single( truck );
    vh_truck1 thread vehicle::go_path();
    vh_truck1 waittill( #"reached_end_node" );
    vh_truck1 disconnectpaths();
    spawn_manager::enable( spawner );
}

// Namespace bridge_battle
// Params 3
// Checksum 0x1904fc8e, Offset: 0x47b0
// Size: 0xc4
function bridge_vehicles_background( sp_vehicle, n_amount, n_delay )
{
    for ( i = 0; i < n_amount ; i++ )
    {
        var_86cf1a8 = vehicle::simple_spawn_single_and_drive( sp_vehicle );
        level.a_veh_bridge_reinforcements[ level.a_veh_bridge_reinforcements.size ] = var_86cf1a8;
        
        if ( i == 0 )
        {
            var_86cf1a8 playsound( "evt_apc_bridge_drive" );
        }
        
        var_86cf1a8 thread function_9a998f4c();
        wait n_delay;
    }
}

// Namespace bridge_battle
// Params 0
// Checksum 0x442f490c, Offset: 0x4880
// Size: 0x116
function function_9a998f4c()
{
    self endon( #"death" );
    self waittill( #"activate_turret" );
    
    for ( i = 1; i < 5 ; i++ )
    {
        if ( level.players.size > 1 )
        {
            var_e248524d = array::get_all_closest( self.origin, level.activeplayers, undefined, 3 );
            n_index = randomintrange( 1, level.activeplayers.size );
            e_target = var_e248524d[ n_index - 1 ];
        }
        else
        {
            e_target = level.players[ 0 ];
        }
        
        self thread turret::shoot_at_target( e_target, 20, ( 0, 0, 0 ), i, 0 );
    }
}

// Namespace bridge_battle
// Params 0
// Checksum 0xce615071, Offset: 0x49a0
// Size: 0x4c
function function_86b76a0b()
{
    var_415b1e24 = getnode( "node_hendricks_bridge", "targetname" );
    level.ai_hendricks setgoal( var_415b1e24 );
}

// Namespace bridge_battle
// Params 0
// Checksum 0x477db13e, Offset: 0x49f8
// Size: 0x134
function function_373c3957()
{
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    e_orig = getent( "hyperion_teleport_point", "targetname" );
    self forceteleport( e_orig.origin, e_orig.angles, 1 );
    level flag::wait_till( "hyperion_move_up" );
    n_node = getnode( "hyperion_bridge_start", "targetname" );
    self setgoal( n_node, 1 );
    self waittill( #"goal" );
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
}

// Namespace bridge_battle
// Params 0
// Checksum 0xf9e159c2, Offset: 0x4b38
// Size: 0x11c
function hyperion_bridge_dialog()
{
    e_pa = getent( "pa_dialog_bridge", "targetname" );
    e_pa dialog::say( "nrcp_satellite_stations_m_0", 0, 1 );
    level flag::wait_till( "player_left_alley" );
    level.ai_hyperion dialog::say( "mare_exfil_is_across_the_0" );
    level.ai_hendricks dialog::say( "hend_they_ll_still_be_rig_0", 0.5 );
    level.ai_hyperion dialog::say( "mare_we_ve_set_charges_al_0", 0.3 );
    wait 1;
    level flag::set( "bridge_intro_chatter_done" );
    level function_ce74e624();
}

// Namespace bridge_battle
// Params 0
// Checksum 0x13b11cc2, Offset: 0x4c60
// Size: 0x16c
function function_ce74e624()
{
    level endon( #"hash_91d75f4e" );
    level thread function_ccb258c2();
    level thread function_ff7f8d6c();
    level flag::wait_till( "play_bridge_nag" );
    level.ai_hyperion dialog::say( "mare_bridge_s_just_ahead_0" );
    level flag::clear( "play_bridge_nag" );
    level thread function_ccb258c2();
    level flag::wait_till( "play_bridge_nag" );
    level.ai_hyperion dialog::say( "mare_keep_on_mark_we_re_0" );
    level flag::clear( "play_bridge_nag" );
    level thread function_ccb258c2();
    level flag::wait_till( "play_bridge_nag" );
    level.ai_hyperion dialog::say( "mare_move_up_move_up_0" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0xd59d03c2, Offset: 0x4dd8
// Size: 0x84
function function_ccb258c2()
{
    level endon( #"hash_91d75f4e" );
    level.var_1d513eb4 = 0;
    n_starttime = gettime();
    
    while ( true )
    {
        wait 0.5;
        level.var_1d513eb4 = ( gettime() - n_starttime ) / 1000;
        
        if ( level.var_1d513eb4 >= 20 )
        {
            level flag::set( "play_bridge_nag" );
            break;
        }
    }
}

// Namespace bridge_battle
// Params 0
// Checksum 0x51f1886d, Offset: 0x4e68
// Size: 0x80
function function_ff7f8d6c()
{
    level flag::wait_till( "bridge_enemies_fallback_1" );
    level.var_1d513eb4 = 0;
    level flag::wait_till( "bridge_enemies_fallback_3" );
    level.var_1d513eb4 = 0;
    level flag::wait_till( "bring_in_jeeps" );
    level.var_1d513eb4 = 0;
}

// Namespace bridge_battle
// Params 0
// Checksum 0x7c35cf46, Offset: 0x4ef0
// Size: 0x274
function building_hacking()
{
    level.ai_hendricks ai::set_ignoreall( 1 );
    level.ai_hyperion ai::set_ignoreall( 1 );
    level.ai_khalil ai::set_ignoreall( 1 );
    level.ai_minister ai::set_ignoreall( 1 );
    level.ai_minister ai::set_behavior_attribute( "coverIdleOnly", 0 );
    level thread function_43d4df76();
    trigger::use( "move_friendlies_to_darkroom_door" );
    var_e1017064 = level.scriptbundles[ "scene" ][ "cin_pro_12_01_darkbattle_vign_doorhack_theia_hack" ].objects[ 0 ];
    var_e1017064.takedamage = 0;
    level.ai_hyperion thread function_74a0938a();
    level thread scene::play( "cin_pro_12_01_darkbattle_vign_doorhack_theia_hack" );
    level thread function_d94fdf85();
    level thread objectives::breadcrumb( "dark_battle_breadcrumb_start" );
    level waittill( #"comm_building_hacked" );
    function_40039059();
    trigger::use( "move_friendlies_to_darkroom" );
    level waittill( #"hash_2ea5aaf1" );
    level flag::set( "activate_db_bc_2" );
    n_node = getnode( "pallas_stairs_goal", "targetname" );
    level.ai_hyperion setgoal( n_node );
    level thread function_8798d583();
    level.ai_hyperion waittill( #"goal" );
    objectives::complete( "cp_waypoint_breadcrumb" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0x26bc5a7b, Offset: 0x5170
// Size: 0x10c
function function_74a0938a()
{
    level endon( #"hash_1d62d2cc" );
    s_align = struct::get( "tag_align_darkbattle", "targetname" );
    v_destination = getstartorigin( s_align.origin, s_align.angles, "ch_pro_12_01_darkbattle_vign_doorhack_theia_hack" );
    n_cycles = 0;
    
    do
    {
        var_7a7ba497 = self.origin;
        n_cycles++;
        wait 6;
    }
    while ( distancesquared( self.origin, v_destination ) < distancesquared( var_7a7ba497, v_destination ) && n_cycles < 5 );
    
    self forceteleport( v_destination );
}

// Namespace bridge_battle
// Params 0
// Checksum 0xb23bd40, Offset: 0x5288
// Size: 0x19a
function function_40039059()
{
    level.int_building_blocker = getent( "intelligence_building_entrance_blocker", "targetname" );
    level.int_building_blocker.movedist = 300;
    level.int_building_blocker movez( -1 * level.int_building_blocker.movedist, 0.05 );
    door_l = getent( "intelstation_entry_door_l", "targetname" );
    door_r = getent( "intelstation_entry_door_r", "targetname" );
    playsoundatposition( "evt_doorhack_dooropen", door_r.origin );
    v_move = ( 54, 0, 0 );
    v_door_destination = door_l.origin + v_move;
    door_l moveto( v_door_destination, 0.5 );
    v_door_destination = door_r.origin - v_move;
    door_r moveto( v_door_destination, 0.5 );
    door_l waittill( #"movedone" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0x5bf0dff9, Offset: 0x5430
// Size: 0x224
function function_43d4df76()
{
    t_door = getent( "t_intelligence_entrance_doors", "targetname" );
    a_friendly_ai = array( level.ai_minister, level.ai_hendricks, level.ai_khalil, level.ai_hyperion );
    level thread cp_prologue_util::function_21f52196( "intelligence_doors", t_door );
    level thread cp_prologue_util::function_2e61b3e8( "intelligence_doors", t_door, a_friendly_ai );
    
    while ( !cp_prologue_util::function_cdd726fb( "intelligence_doors" ) )
    {
        wait 0.1;
    }
    
    level.int_building_blocker movez( level.int_building_blocker.movedist, 0.05 );
    door_l = getent( "intelstation_entry_door_l", "targetname" );
    door_r = getent( "intelstation_entry_door_r", "targetname" );
    door_r playsound( "evt_doorhack_doorclose" );
    v_move = ( 54, 0, 0 );
    v_door_destination = door_l.origin - v_move;
    door_l moveto( v_door_destination, 0.5 );
    v_door_destination = door_r.origin + v_move;
    door_r moveto( v_door_destination, 0.5 );
}

// Namespace bridge_battle
// Params 0
// Checksum 0x57a660cd, Offset: 0x5660
// Size: 0xac
function function_d94fdf85()
{
    ent = spawn( "script_origin", ( 13413, 2917, 442 ) );
    ent playloopsound( "evt_darkbattle_walla_pre_loop", 5 );
    level waittill( #"hash_400d768d" );
    ent stoploopsound( 3 );
    wait 0.5;
    ent playsound( "evt_darkbattle_walla_surprise_oneshot" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0x5bdc23d4, Offset: 0x5718
// Size: 0x44c
function function_3178e821()
{
    wait 18;
    vh_vtol = vehicle::simple_spawn_single( "vtol_bridge_flyby" );
    vh_vtol util::magic_bullet_shield();
    vh_vtol thread vehicle::go_path();
    vh_vtol thread cp_prologue_util::vehicle_rumble( "buzz_high", "vtol_attack_end", 0.1, 0.1, 2000, 60 );
    vh_vtol thread cp_prologue_util::function_c56034b7();
    vh_vtol vehicle::toggle_lights_group( 4, 1 );
    var_bd827604 = struct::get( "vtol_spotlight_closest", "targetname" );
    e_closest_player = arraygetclosest( var_bd827604.origin, level.players );
    vh_vtol setgunnertargetent( e_closest_player, ( 0, 0, 0 ), 2 );
    vh_vtol waittill( #"hash_808f9bca" );
    var_c9a712ab = getent( "trig_all_players_in_int_builing", "targetname" );
    vh_vtol vehicle::detach_path();
    a_flight_structs = struct::get_array( "vtol_db_pos" );
    var_3a018a9 = 0;
    
    while ( !cp_prologue_util::function_cdd726fb( "intelligence_doors" ) )
    {
        foreach ( e_player in level.activeplayers )
        {
            vh_vtol setlookatent( e_player );
            vh_vtol setgunnertargetent( e_player, ( 0, 0, 0 ), 2 );
            
            while ( isdefined( e_player ) && !e_player istouching( var_c9a712ab ) )
            {
                e_player function_62f55bbc( vh_vtol, 0 );
                var_3a018a9++;
                
                if ( var_3a018a9 % 2 == 0 )
                {
                    vh_vtol setvehgoalpos( array::random( a_flight_structs ).origin, 1 );
                }
            }
        }
        
        wait 0.5;
    }
    
    vh_vtol clearvehgoalpos();
    vh_vtol.drivepath = 1;
    var_618ce087 = getvehiclenode( "vtol_bridge_leave_nd", "targetname" );
    vh_vtol thread vehicle::get_on_and_go_path( var_618ce087 );
    vh_vtol waittill( #"reached_end_node" );
    vh_vtol util::stop_magic_bullet_shield();
    vh_vtol notify( #"vtol_attack_end" );
    vh_vtol.delete_on_death = 1;
    vh_vtol notify( #"death" );
    
    if ( !isalive( vh_vtol ) )
    {
        vh_vtol delete();
    }
}

// Namespace bridge_battle
// Params 2
// Checksum 0x8f60c902, Offset: 0x5b70
// Size: 0x16e
function function_62f55bbc( veh_vtol, var_bb290d08 )
{
    if ( !isdefined( var_bb290d08 ) )
    {
        var_bb290d08 = 0;
    }
    
    level endon( #"hash_7097d501" );
    self endon( #"death" );
    n_timer = randomfloatrange( 2, 3 ) * 20;
    
    for ( i = 0; i < n_timer ; i++ )
    {
        if ( !var_bb290d08 )
        {
            var_30299a05 = ( randomintrange( -150, 150 ), randomintrange( -150, 150 ), randomintrange( -150, 150 ) );
        }
        else
        {
            var_30299a05 = ( 0, 0, 0 );
        }
        
        magicbullet( getweapon( "turret_bo3_mil_vtol_nrc" ), veh_vtol gettagorigin( "tag_gunner_barrel3" ) + ( 0, -40, 0 ), self.origin + var_30299a05 );
        wait 0.05;
    }
}

// Namespace bridge_battle
// Params 13
// Checksum 0x9d45b405, Offset: 0x5ce8
// Size: 0x76
function function_3d8309dc( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, modelindex, psoffsettime, vsurfacenormal )
{
    return idamage * 5;
}

// Namespace bridge_battle
// Params 0
// Checksum 0xfa0e27e4, Offset: 0x5d68
// Size: 0x4c
function bridge_compromised_dialog()
{
    level.ai_hyperion dialog::say( "mare_taylor_primary_exfi_0" );
    level dialog::remote( "tayr_copy_that_rendezvou_0", undefined, "normal" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0xfb61f6b7, Offset: 0x5dc0
// Size: 0x9c
function function_8798d583()
{
    level endon( #"hash_18d7e7c0" );
    level thread function_951308f0();
    wait 10;
    level.ai_hyperion dialog::say( "mare_gotta_move_on_second_0" );
    wait 5;
    level.ai_hyperion dialog::say( "mare_move_your_ass_get_i_0" );
    wait 5;
    level.ai_hyperion dialog::say( "mare_that_drone_s_less_th_0" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0xf292a36a, Offset: 0x5e68
// Size: 0x32
function function_951308f0()
{
    level trigger::wait_till( "trig_all_players_in_int_builing" );
    level notify( #"hash_18d7e7c0" );
}

// Namespace bridge_battle
// Params 0
// Checksum 0xcab75af4, Offset: 0x5ea8
// Size: 0x124
function function_401aadf2()
{
    nd_lift_traversal = getnode( "bridge_link_1", "targetname" );
    linktraversal( nd_lift_traversal );
    nd_lift_traversal = getnode( "bridge_link_2", "targetname" );
    linktraversal( nd_lift_traversal );
    nd_lift_traversal = getnode( "bridge_link_3", "targetname" );
    linktraversal( nd_lift_traversal );
    nd_lift_traversal = getnode( "bridge_link_4", "targetname" );
    linktraversal( nd_lift_traversal );
    nd_lift_traversal = getnode( "bridge_link_5", "targetname" );
    linktraversal( nd_lift_traversal );
}

