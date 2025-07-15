#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_squad_control;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_biodomes;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes_sound;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai/robot_phalanx;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/warlord;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace cp_mi_sing_biodomes_markets;

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xc12b205f, Offset: 0x1a30
// Size: 0x25c
function main()
{
    a_markets1_hendricks_scenes_triggers = getentarray( "hendricks_markets1_scene_triggers", "script_noteworthy" );
    level thread array::thread_all( a_markets1_hendricks_scenes_triggers, &hendricks_market1_scenes_trigger );
    spawner::add_spawn_function_group( "sp_markets1_warlord", "targetname", &function_7ff66080 );
    spawner::add_spawn_function_group( "sp_markets2_warlord", "targetname", &function_ff2bafac );
    spawner::add_spawn_function_group( "headpop_guys", "script_noteworthy", &headpop_tracking );
    spawner::add_spawn_function_group( "markets2_rpg_tower", "script_noteworthy", &markets2_rpg_tower );
    spawner::add_spawn_function_group( "markets2_ambush_guys", "script_noteworthy", &markets2_ambush_guys );
    spawner::add_spawn_function_group( "sp_markets2_bridge_retreat", "targetname", &markets2_bridge_retreaters );
    spawner::add_spawn_function_group( "markets2_robot_rushers", "script_noteworthy", &markets2_robot_rushers );
    level.a_prisoner_ai = [];
    spawner::add_spawn_function_group( "sp_markets1_start_anim", "script_noteworthy", &ai::force_goal, undefined, 64 );
    spawner::add_spawn_function_group( "sp_markets1_weapongrab_leader", "targetname", &function_4a0994ae );
    spawner::add_spawn_function_group( "markets1_magic_rpg", "script_noteworthy", &markets1_magic_rpg );
    setup_scenes();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x1df60365, Offset: 0x1c98
// Size: 0x94
function setup_scenes()
{
    level scene::add_scene_func( "cin_bio_03_01_market_vign_hendricksmoment_throw", &function_a5040920, "play" );
    level scene::add_scene_func( "cin_bio_03_01_market_vign_hendricksmoment_rush", &function_f4e90efd, "play" );
    level scene::add_scene_func( "cin_bio_04_01_market2_vign_explode", &function_b27f1679, "play" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1
// Checksum 0x3fe17e08, Offset: 0x1d38
// Size: 0x24c
function function_afd92016( str_side )
{
    level endon( #"hash_efa973e9" );
    var_1d92694f = getent( "dumpster_markets1_push_sideways_" + str_side, "targetname" );
    var_1d92694f disconnectpaths();
    s_align = struct::get( "markets1_push_sideways_" + str_side );
    s_align scene::init( s_align.scriptbundlename, var_1d92694f );
    nd_cover = getnode( "nd_markets1_push_sideways_" + str_side, "targetname" );
    setenablenode( nd_cover, 0 );
    trigger::wait_till( "trig_markets1_push_sideways_" + str_side );
    var_a715f176 = spawner::simple_spawn_single( "sp_markets1_push_sideways_" + str_side );
    var_a715f176 ai::set_behavior_attribute( "sprint", 1 );
    var_a715f176 endon( #"death" );
    var_a715f176 function_d87e0a34( 1024 );
    var_1d92694f connectpaths();
    a_ents = array( var_a715f176, var_1d92694f );
    s_align thread function_73bcc8bf( var_a715f176, var_1d92694f );
    s_align scene::play( "cin_gen_aie_push_cover_sideways_no_dynpath", a_ents );
    s_align notify( #"hash_5c016b54" );
    setenablenode( nd_cover, 1 );
    var_1d92694f disconnectpaths();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 2
// Checksum 0x639d9d39, Offset: 0x1f90
// Size: 0x64
function function_73bcc8bf( var_a715f176, var_1d92694f )
{
    self endon( #"hash_5c016b54" );
    var_a715f176 waittill( #"death" );
    self scene::stop( "cin_gen_aie_push_cover_sideways_no_dynpath" );
    var_1d92694f disconnectpaths();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1
// Checksum 0x3fecaf8e, Offset: 0x2000
// Size: 0x25c
function function_d3cdcc7a( str_side )
{
    level endon( #"hash_efa973e9" );
    var_db712e4f = getent( "table_markets1_flip_" + str_side, "targetname" );
    var_db712e4f disconnectpaths();
    s_align = struct::get( "markets1_flip_" + str_side );
    s_align scene::init( "cin_gen_aie_table_flip_no_dynpath", var_db712e4f );
    var_f377c056 = getnode( "nd_markets1_flip_" + str_side, "targetname" );
    setenablenode( var_f377c056, 0 );
    trigger::wait_till( "trig_markets1_flip_" + str_side );
    var_7f7b2bb8 = spawner::simple_spawn_single( "sp_markets1_flip_" + str_side );
    var_7f7b2bb8 ai::set_behavior_attribute( "sprint", 1 );
    var_7f7b2bb8 endon( #"death" );
    var_7f7b2bb8 function_d87e0a34( 1024 );
    a_ents = array( var_7f7b2bb8, var_db712e4f );
    s_align thread function_2188c8d1( var_7f7b2bb8, var_db712e4f );
    s_align thread scene::play( "cin_gen_aie_table_flip_no_dynpath", a_ents );
    var_db712e4f waittill( #"connect_paths" );
    var_db712e4f connectpaths();
    var_7f7b2bb8 waittill( #"enable_node" );
    setenablenode( var_f377c056, 1 );
    var_db712e4f thread function_1d148f52();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 2
// Checksum 0x473eee0c, Offset: 0x2268
// Size: 0x64
function function_2188c8d1( var_7f7b2bb8, var_db712e4f )
{
    var_7f7b2bb8 endon( #"enable_node" );
    var_7f7b2bb8 waittill( #"death" );
    self scene::stop( "cin_gen_aie_table_flip_no_dynpath" );
    var_db712e4f disconnectpaths();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xbe7a14af, Offset: 0x22d8
// Size: 0x24
function function_1d148f52()
{
    self waittill( #"disconnect_paths" );
    self disconnectpaths();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xa154b5ea, Offset: 0x2308
// Size: 0x530
function function_174b2742()
{
    level endon( #"hash_9bb53038" );
    trigger::wait_till( "trig_markets1_warlord" );
    spawn_manager::wait_till_complete( "sm_markets1_warlord" );
    
    while ( true )
    {
        var_11657e7b = spawn_manager::get_ai( "sm_markets1_warlord" );
        
        foreach ( ai_warlord in var_11657e7b )
        {
            ai_warlord.var_8e7be685 = [];
            
            foreach ( player in level.activeplayers )
            {
                n_dist_sq = distancesquared( ai_warlord.origin, player.origin );
                
                if ( !isdefined( ai_warlord.var_8e7be685 ) )
                {
                    ai_warlord.var_8e7be685 = [];
                }
                else if ( !isarray( ai_warlord.var_8e7be685 ) )
                {
                    ai_warlord.var_8e7be685 = array( ai_warlord.var_8e7be685 );
                }
                
                ai_warlord.var_8e7be685[ ai_warlord.var_8e7be685.size ] = n_dist_sq;
            }
            
            ai_warlord.e_target = undefined;
        }
        
        for ( i = 0; i < level.activeplayers.size ; i++ )
        {
            var_43b73530 = undefined;
            n_dist_sq_closest = undefined;
            var_ab1697de = undefined;
            
            foreach ( ai_warlord in var_11657e7b )
            {
                if ( isdefined( ai_warlord.var_8e7be685 ) )
                {
                    for ( i = 0; i < ai_warlord.var_8e7be685.size ; i++ )
                    {
                        if ( isdefined( ai_warlord.var_8e7be685[ i ] ) && ( !isdefined( n_dist_sq_closest ) || ai_warlord.var_8e7be685[ i ] < n_dist_sq_closest ) )
                        {
                            n_dist_sq_closest = ai_warlord.var_8e7be685[ i ];
                            var_ab1697de = i;
                            var_43b73530 = ai_warlord;
                        }
                    }
                }
            }
            
            var_43b73530.e_target = level.activeplayers[ var_ab1697de ];
            var_43b73530.var_8e7be685 = undefined;
            
            foreach ( ai_warlord in var_11657e7b )
            {
                if ( isdefined( ai_warlord.var_8e7be685 ) )
                {
                    ai_warlord.var_8e7be685[ var_ab1697de ] = undefined;
                }
            }
        }
        
        if ( var_11657e7b.size > level.activeplayers.size )
        {
            foreach ( ai_warlord in var_11657e7b )
            {
                if ( !isdefined( ai_warlord.e_target ) )
                {
                    ai_warlord.e_target = arraysortclosest( level.activeplayers, ai_warlord.origin, 1 )[ 0 ];
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x5b195511, Offset: 0x2840
// Size: 0x190
function function_7ff66080()
{
    self endon( #"death" );
    self thread function_5a24feff();
    self.e_target = undefined;
    self.var_8fa11c4a = undefined;
    self cp_mi_sing_biodomes_util::function_f61c0df8( "nd_market1_warlord", 2, 3 );
    var_e812ecff = getent( "vol_markets1_warlord_last", "targetname" );
    a_volumes = getentarray( "vol_markets1_warlord", "script_noteworthy" );
    
    while ( true )
    {
        if ( isdefined( self.e_target ) )
        {
            if ( self.e_target istouching( var_e812ecff ) )
            {
                var_bf84b114 = var_e812ecff;
            }
            else
            {
                var_bf84b114 = arraysortclosest( a_volumes, self.e_target.origin, 1 )[ 0 ];
            }
            
            if ( !isdefined( self.var_8fa11c4a ) || self.var_8fa11c4a !== var_bf84b114 )
            {
                self.var_8fa11c4a = var_bf84b114;
                self setgoal( self.var_8fa11c4a, 1 );
            }
        }
        
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x72b2f8e, Offset: 0x29d8
// Size: 0x14a
function function_5a24feff()
{
    self endon( #"death" );
    level endon( #"warlord_vo_done" );
    var_9f460d03 = 0;
    
    while ( !var_9f460d03 )
    {
        foreach ( player in level.activeplayers )
        {
            if ( player islookingat( self ) )
            {
                var_9f460d03 = 1;
                break;
            }
        }
        
        wait 0.25;
    }
    
    level util::delay_notify( 5, "warlord_vo_done" );
    level flag::wait_till( "markets1_intro_dialogue_done" );
    level thread dialog::remote( "kane_warlord_get_to_cove_0" );
    level notify( #"warlord_vo_done" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 2
// Checksum 0x345babb2, Offset: 0x2b30
// Size: 0x4cc
function objective_markets_start_init( str_objective, b_starting )
{
    objectives::set( "cp_level_biodomes_cloud_mountain" );
    cp_mi_sing_biodomes_util::objective_message( "objective_markets_start_init" );
    
    if ( b_starting )
    {
        cp_mi_sing_biodomes_util::init_hendricks( str_objective );
        level thread cp_mi_sing_biodomes::igc_party( 1 );
        level thread cp_mi_sing_biodomes_util::function_753a859( str_objective );
        level waittill( #"end_igc" );
        streamerrequest( "clear", "cin_bio_02_04_gunplay_vign_stab" );
        level thread namespace_f1b4cbbc::function_fa2e45b8();
    }
    
    if ( isdefined( level.bzmloadoutchangecallback ) )
    {
        level thread [[ level.bzmloadoutchangecallback ]]();
    }
    
    level thread cp_mi_sing_biodomes_util::function_cc20e187( "markets1", 1 );
    level.var_996e05eb = "friendly_spawns_markets_start";
    trigger::use( "trig_hendricks_color_marketst1" );
    level flag::set( "markets1_enemies_alert" );
    objectives::set( "cp_waypoint_breadcrumb", struct::get( "breadcrumb_markets1" ) );
    objectives::hide( "cp_waypoint_breadcrumb" );
    savegame::checkpoint_save();
    level thread namespace_f1b4cbbc::function_fa2e45b8();
    level thread function_174b2742();
    level thread function_afd92016( "left" );
    level thread function_d3cdcc7a( "left" );
    level thread function_afd92016( "right" );
    level thread function_d3cdcc7a( "right" );
    trigger::wait_till( "trig_markets1_combat2" );
    level thread cp_mi_sing_biodomes_util::aigroup_retreat( "markets1_retreaters_left", "info_volume_markets1_left", 2, 4 );
    level thread cp_mi_sing_biodomes_util::aigroup_retreat( "markets1_retreaters_right", "info_volume_markets1_right", 2, 4 );
    trigger::wait_till( "trig_markets1_pushback" );
    spawn_manager::kill( "sm_markets1_combat0" );
    spawn_manager::kill( "sm_markets1_combat1" );
    spawn_manager::kill( "sm_markets1_combat2" );
    spawn_manager::kill( "sm_markets1_combat3" );
    level thread cp_mi_sing_biodomes_util::aigroup_retreat( "markets1_snipers", "info_volume_markets1_rear", 1, 4 );
    level thread cp_mi_sing_biodomes_util::aigroup_retreat( "markets1_retreaters", "info_volume_markets1_rear", 1, 4 );
    level thread cp_mi_sing_biodomes_util::aigroup_retreat( "markets1_retreaters_left", "info_volume_markets1_rear", 2, 4 );
    level thread cp_mi_sing_biodomes_util::aigroup_retreat( "markets1_retreaters_right", "info_volume_markets1_rear", 1, 3 );
    level thread cp_mi_sing_biodomes_util::aigroup_retreat( "markets1_retreaters_last", "info_volume_markets1_rear", 3, 6 );
    level scene::init( "p7_fxanim_cp_biodomes_cafe_window_break_right_bundle" );
    level scene::init( "p7_fxanim_cp_biodomes_cafe_window_break_left_bundle" );
    trigger::wait_till( "trig_markets_rpg" );
    level notify( #"hash_efa973e9" );
    level skipto::objective_completed( "objective_markets_start" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x8b891904, Offset: 0x3008
// Size: 0x4c
function function_4a0994ae()
{
    self waittill( #"death" );
    
    if ( level scene::is_playing( "cin_bio_03_01_market_aie_weapons" ) )
    {
        level scene::stop( "cin_bio_03_01_market_aie_weapons" );
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x62314a17, Offset: 0x3060
// Size: 0x1ac
function spawn_markets1_enemies()
{
    level thread scene::add_scene_func( "cin_gen_aie_table_react", &function_c7cb9a93, "done" );
    level waittill( #"igc_at_window" );
    spawner::simple_spawn( "sp_markets1_friendly_robot_start" );
    spawn_manager::enable( "sm_markets1_combat0" );
    spawn_manager::enable( "sm_markets1_combat1" );
    level.turret_markets1 = spawner::simple_spawn_single( "turret_markets1" );
    level.turret_markets1 thread function_70da4f9b();
    level thread vo_markets1();
    level thread function_b1e84c2();
    trigger::use( "trig_markets1_combat1" );
    level thread scene::play( "cin_bio_03_01_market_vign_engage" );
    level thread scene::play( "cin_bio_03_01_market_aie_weapons" );
    level thread scene::play( "cin_gen_aie_table_react" );
    wait 2;
    level flag::set( "markets1_enemies_alert" );
    level clientfield::set( "sndIGCsnapshot", 0 );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1
// Checksum 0xe535934a, Offset: 0x3218
// Size: 0x148
function function_d87e0a34( var_78850f88 )
{
    n_distance_sq = var_78850f88 * var_78850f88;
    var_9f460d03 = 0;
    
    while ( !var_9f460d03 )
    {
        foreach ( player in level.activeplayers )
        {
            n_distance = distance2dsquared( player.origin, self.origin );
            
            if ( player util::is_looking_at( self, 0.6, 1 ) && n_distance < 1000000 || n_distance < n_distance_sq )
            {
                var_9f460d03 = 1;
                break;
            }
        }
        
        wait 0.25;
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xd4661320, Offset: 0x3368
// Size: 0x1ec
function vo_markets1()
{
    while ( !isdefined( level.ai_hendricks ) )
    {
        wait 0.05;
    }
    
    battlechatter::function_d9f49fba( 0 );
    level dialog::player_say( "plyr_plan_b_0" );
    level.ai_hendricks dialog::say( "hend_plan_b_into_comms_0" );
    level dialog::player_say( "plyr_i_thought_you_and_da_0" );
    level.ai_hendricks dialog::say( "hend_yeah_so_did_i_0" );
    level dialog::remote( "kane_robot_squad_activati_0", 1 );
    level.ai_hendricks dialog::say( "hend_you_finished_triangu_0", 3 );
    level dialog::remote( "kane_got_em_data_drives_0" );
    level.ai_hendricks dialog::say( "hend_are_you_fucking_kidd_0" );
    level dialog::player_say( "plyr_how_much_do_you_wann_0" );
    level dialog::remote( "kane_overwatch_shows_cdp_0" );
    objectives::show( "cp_waypoint_breadcrumb" );
    level.ai_hendricks dialog::say( "hend_you_kidding_me_wha_0" );
    battlechatter::function_d9f49fba( 1 );
    level flag::set( "markets1_intro_dialogue_done" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xde795d1a, Offset: 0x3560
// Size: 0x1ac
function function_b1e84c2()
{
    trigger::wait_till( "trig_markets1_combat3" );
    var_bd9defd6 = spawner::get_ai_group_sentient_count( "markets1_snipers" );
    
    if ( var_bd9defd6 > 0 )
    {
        a_dialogue_lines = [];
        a_dialogue_lines[ 0 ] = "hend_i_got_eyes_on_a_snip_0";
        a_dialogue_lines[ 1 ] = "hend_hostile_sniper_ahead_0";
        a_dialogue_lines[ 2 ] = "hend_eyes_up_sniper_in_p_0";
        level.ai_hendricks dialog::say( cp_mi_sing_biodomes_util::vo_pick_random_line( a_dialogue_lines ), 3 );
    }
    
    var_207c708e = spawner::get_ai_group_sentient_count( "markets1_riotshields" );
    
    if ( var_207c708e > 0 )
    {
        a_dialogue_lines = [];
        a_dialogue_lines[ 0 ] = "hend_riot_gear_incoming_0";
        a_dialogue_lines[ 1 ] = "hend_eyes_on_riot_gear_0";
        a_dialogue_lines[ 2 ] = "hend_riot_shields_comin_0";
        level.ai_hendricks dialog::say( cp_mi_sing_biodomes_util::vo_pick_random_line( a_dialogue_lines ), 3 );
    }
    
    level flag::wait_till( "markets1_enemies_retreating" );
    level.ai_hendricks thread dialog::say( "hend_they_re_falling_back_0", 5 );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xa93b5417, Offset: 0x3718
// Size: 0xa8
function hendricks_market1_scenes_trigger()
{
    self endon( #"death" );
    
    while ( self istriggerenabled() )
    {
        self trigger::wait_till();
        
        if ( self.who == level.players[ 0 ] )
        {
            if ( isstring( self.target ) )
            {
                level.ai_hendricks thread hendricks_markets1_scenes( self.target );
            }
            
            self triggerenable( 0 );
        }
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1
// Checksum 0xffa1bb21, Offset: 0x37c8
// Size: 0xbc
function hendricks_markets1_scenes( str_node_name )
{
    switch ( str_node_name )
    {
        case "nd_hendricks_wok1":
            level.ai_hendricks thread function_1485f7dc();
            break;
        case "nd_hendricks_shelves":
            level.ai_hendricks thread function_a67aaa62();
            break;
        default:
            break;
    }
    
    nd_hendricks = getnode( str_node_name, "targetname" );
    
    if ( isdefined( nd_hendricks ) )
    {
        self setgoal( nd_hendricks );
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x5ed74c27, Offset: 0x3890
// Size: 0x44
function function_a67aaa62()
{
    level scene::init( "cin_bio_03_01_market_vign_hendricksmoment_rush" );
    self waittill( #"goal" );
    function_2e1ac4d4();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xa81aef17, Offset: 0x38e0
// Size: 0x114
function function_2e1ac4d4()
{
    str_color_trig = "trig_hendricks_moment_colors_right";
    ai_shelf_death = spawner::simple_spawn_single( "sp_markets1_shelfguy" );
    
    if ( isalive( ai_shelf_death ) )
    {
        ai_shelf_death ai::set_ignoreme( 1 );
        level scene::add_scene_func( "cin_bio_03_01_market_vign_hendricksmoment_rush_enemy", &function_3a8d91fc, "play" );
        level thread function_a3bac88( "cin_bio_03_01_market_vign_hendricksmoment_rush", ai_shelf_death, str_color_trig );
        level scene::play( "cin_bio_03_01_market_vign_hendricksmoment_rush_enemy", ai_shelf_death );
        return;
    }
    
    level thread function_a3bac88( "cin_bio_03_01_market_vign_hendricksmoment_rush", undefined, str_color_trig );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1
// Checksum 0xce099330, Offset: 0x3a00
// Size: 0x2c
function function_3a8d91fc( a_ents )
{
    level scene::play( "cin_bio_03_01_market_vign_hendricksmoment_rush" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xbaded923, Offset: 0x3a38
// Size: 0x84
function function_1485f7dc()
{
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    level scene::add_scene_func( "cin_bio_03_01_market_vign_hendricksmoment_throw", &function_b347511d, "init" );
    level scene::init( "cin_bio_03_01_market_vign_hendricksmoment_throw" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1
// Checksum 0x8f3ae7c0, Offset: 0x3ac8
// Size: 0xfc
function function_b347511d( a_ents )
{
    str_color_trig = "trig_hendricks_color_markets1_left1";
    ai_enemy_thrown = spawner::simple_spawn_single( "sp_hendricks_enemy_throw_1" );
    
    if ( isalive( ai_enemy_thrown ) )
    {
        level scene::add_scene_func( "cin_bio_03_01_market_vign_hendricksmoment_throw_enemy", &function_af620536, "play" );
        level thread function_a3bac88( "cin_bio_03_01_market_vign_hendricksmoment_throw", ai_enemy_thrown, str_color_trig );
        level scene::play( "cin_bio_03_01_market_vign_hendricksmoment_throw_enemy", ai_enemy_thrown );
        return;
    }
    
    level thread function_a3bac88( "cin_bio_03_01_market_vign_hendricksmoment_throw", undefined, str_color_trig );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1
// Checksum 0x57ddbb29, Offset: 0x3bd0
// Size: 0x5c
function function_af620536( a_ents )
{
    level scene::play( "cin_bio_03_01_market_vign_hendricksmoment_throw" );
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_hendricks ai::set_ignoreme( 0 );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 3
// Checksum 0x66bbb217, Offset: 0x3c38
// Size: 0xb4
function function_a3bac88( str_scene, ai_enemy, str_color_trig )
{
    if ( isalive( ai_enemy ) )
    {
        ai_enemy waittill( #"death" );
    }
    
    level scene::stop( str_scene );
    wait 0.15;
    level.ai_hendricks ai::set_ignoreall( 0 );
    level.ai_hendricks ai::set_ignoreme( 0 );
    trigger::use( str_color_trig, "targetname", undefined, 0 );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1
// Checksum 0x8f33ee38, Offset: 0x3cf8
// Size: 0x18
function function_a5040920( a_ents )
{
    level waittill( #"hash_d1c9c0a9" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1
// Checksum 0x44082075, Offset: 0x3d18
// Size: 0x7c
function function_f4e90efd( a_ents )
{
    level waittill( #"hash_a04c5e57" );
    var_8fbeee65 = getent( "plaster_walls_01", "targetname" );
    var_8fbeee65 notsolid();
    level scene::play( "p7_fxanim_cp_newworld_plaster_walls_01_bundle" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1
// Checksum 0x2d4db6f7, Offset: 0x3da0
// Size: 0x5c
function spawn_markets1_hero_moment_enemy( str_scene )
{
    self.goalradius = 8;
    self ai::set_ignoreme( 1 );
    self waittill( #"death" );
    level scene::stop( str_scene );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1
// Checksum 0xa54ea933, Offset: 0x3e08
// Size: 0x94
function function_c7cb9a93( a_ents )
{
    var_524f5f14 = getent( "sp_markets_table_react_chair", "targetname" );
    e_table = getent( "sp_markets_table_react_table", "targetname" );
    var_524f5f14 disconnectpaths();
    e_table disconnectpaths();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 4
// Checksum 0xc4c9f5f1, Offset: 0x3ea8
// Size: 0x3c
function objective_markets_start_done( str_objective, b_starting, b_direct, player )
{
    cp_mi_sing_biodomes_util::objective_message( "objective_markets_start_done" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 2
// Checksum 0xac04bd40, Offset: 0x3ef0
// Size: 0x35c
function objective_markets_rpg_init( str_objective, b_starting )
{
    cp_mi_sing_biodomes_util::objective_message( "objective_markets_rpg_init" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        cp_mi_sing_biodomes_util::init_hendricks( str_objective );
        cp_mi_sing_biodomes::function_cef897cf( str_objective );
        level scene::init( "p7_fxanim_cp_biodomes_cafe_window_break_right_bundle" );
        level scene::init( "p7_fxanim_cp_biodomes_cafe_window_break_left_bundle" );
        level.turret_markets1 = spawner::simple_spawn_single( "turret_markets1" );
        level.turret_markets1 thread function_70da4f9b();
        level thread clientfield::set( "party_house_shutter", 1 );
        level thread clientfield::set( "party_house_destruction", 1 );
        level thread cp_mi_sing_biodomes_util::function_753a859( str_objective );
        objectives::set( "cp_level_biodomes_cloud_mountain" );
        objectives::set( "cp_waypoint_breadcrumb", struct::get( "breadcrumb_markets1" ) );
        level thread cp_mi_sing_biodomes_util::function_cc20e187( "markets1" );
        load::function_a2995f22();
        trigger::use( "t_pre_turret1" );
        level thread namespace_f1b4cbbc::function_fa2e45b8();
    }
    
    level.var_996e05eb = "friendly_spawns_markets_rpg";
    showmiscmodels( "fxanim_nursery" );
    showmiscmodels( "fxanim_markets2" );
    spawner::add_spawn_function_group( "markets1_rpgguy", "script_noteworthy", &function_c008e227 );
    trigger::wait_till( "trig_markets_rpg" );
    spawner::simple_spawn_single( "sp_markets_rpg_dome_break", &markets1_magic_rpg );
    spawn_manager::enable( "sm_markets_rpg_nest" );
    level thread function_1711aacb();
    level thread function_e7229eec();
    wait 0.5;
    
    if ( isalive( level.turret_markets1 ) )
    {
        level.turret_markets1 thread function_ac861f96();
    }
    
    trigger::wait_till( "t_zoo_tunnel" );
    level notify( #"hash_4893df48" );
    level skipto::objective_completed( "objective_markets_rpg" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x1f13756e, Offset: 0x4258
// Size: 0x13c
function function_ac861f96()
{
    self endon( #"death" );
    e_turret_target = getent( "turret_shutter_target", "targetname" );
    self.ignoreall = 0;
    self.ignoreme = 0;
    var_6f458912 = getent( "market_turret_clip", "targetname" );
    var_6f458912 delete();
    self thread turret::shoot_at_target( e_turret_target, 3, ( 0, 0, 0 ), 0 );
    self waittill( #"turret_on_target" );
    self cybercom::cybercom_aiclearoptout( "cybercom_hijack" );
    e_turret_target movez( 64, 3 );
    level flag::set( "turret1" );
    level scene::play( "p7_fxanim_cp_biodomes_cafe_window_break_right_bundle" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x6adeeb2c, Offset: 0x43a0
// Size: 0x74
function function_c008e227()
{
    self waittill( #"goal" );
    var_fedce7e9 = getent( "market_rpg_clip", "targetname" );
    var_fedce7e9 delete();
    level scene::play( "p7_fxanim_cp_biodomes_cafe_window_break_left_bundle" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x808eaa0d, Offset: 0x4420
// Size: 0xf4
function function_1711aacb()
{
    level endon( #"turret1_dead" );
    level endon( #"hash_4893df48" );
    level flag::wait_till( "turret1" );
    level.ai_hendricks dialog::say( "hend_take_out_that_turret_1", 1 );
    level thread squad_control::squad_assign_task_independent( "floor_collapse" );
    wait 6;
    level.ai_hendricks dialog::say( "hend_we_gotta_take_out_th_1" );
    wait 8;
    level.ai_hendricks dialog::say( "hend_we_ain_t_movin_with_0" );
    wait 10;
    level.ai_hendricks dialog::say( "hend_bring_down_that_turr_0" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x2a4d7b25, Offset: 0x4520
// Size: 0x64
function function_e7229eec()
{
    level endon( #"hash_4893df48" );
    spawn_manager::wait_till_cleared( "sm_markets_rpg_nest" );
    level flag::wait_till( "turret1_dead" );
    level.ai_hendricks dialog::say( "hend_area_clear_0" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x6633cfa0, Offset: 0x4590
// Size: 0xc4
function markets_shutters_open()
{
    level scene::skipto_end( "p7_fxanim_cp_biodomes_cafe_window_break_left_bundle" );
    level scene::skipto_end( "p7_fxanim_cp_biodomes_cafe_window_break_right_bundle" );
    turret_shutter_clip = getent( "market_turret_clip", "targetname" );
    turret_shutter_clip delete();
    rpg_shutter_clip = getent( "market_rpg_clip", "targetname" );
    rpg_shutter_clip delete();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1
// Checksum 0xd8069fdb, Offset: 0x4660
// Size: 0x184
function window_knockdown( str_model )
{
    e_markets_window = getent( str_model, "targetname" );
    assert( isdefined( e_markets_window ), str_model + "<dev string:x28>" );
    s_window_dest = struct::get( e_markets_window.target, "targetname" );
    assert( isdefined( s_window_dest ), str_model + "<dev string:x46>" );
    
    if ( isdefined( e_markets_window ) && isdefined( s_window_dest ) )
    {
        fx_angle = e_markets_window.angles - ( 0, 90, 0 );
        e_markets_window fx::play( "dirt_impact", e_markets_window.origin, fx_angle, 4 );
        e_markets_window moveto( s_window_dest.origin, 0.5 );
        e_markets_window rotateto( s_window_dest.angles, 0.5 );
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xa834dd56, Offset: 0x47f0
// Size: 0x164
function markets1_magic_rpg()
{
    self waittill( #"death" );
    var_9faa0c88 = getweapon( "smaw" );
    v_rocket_launch = self gettagorigin( "tag_aim" );
    s_rocket_hit = struct::get( "markets1_magic_rpg_dest", "targetname" );
    e_rocket = magicbullet( var_9faa0c88, v_rocket_launch + ( 5, 5, 5 ), s_rocket_hit.origin );
    e_rocket waittill( #"death" );
    playrumbleonposition( "cp_biodomes_rpg_dome_rumble", s_rocket_hit.origin );
    level clientfield::set( "dome_glass_break", 1 );
    var_1842712c = getent( "rpg_dome_glass_clip", "targetname" );
    var_1842712c delete();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 4
// Checksum 0x68977b36, Offset: 0x4960
// Size: 0x6c
function objective_markets_rpg_done( str_objective, b_starting, b_direct, player )
{
    cp_mi_sing_biodomes_util::objective_message( "objective_markets_rpg_done" );
    objectives::complete( "cp_waypoint_breadcrumb", struct::get( "breadcrumb_markets1" ) );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 2
// Checksum 0xb22b0830, Offset: 0x49d8
// Size: 0x43c
function objective_markets2_start_init( str_objective, b_starting )
{
    cp_mi_sing_biodomes_util::objective_message( "objective_markets2_start_init" );
    level thread function_11549ce5();
    level thread markets2_bridge_retract();
    level thread function_4ef9f5db();
    level thread function_1c8db87();
    
    if ( b_starting )
    {
        load::function_73adcefc();
        array::delete_all( getentarray( "triggers_markets1", "script_noteworthy" ) );
        cp_mi_sing_biodomes_util::init_hendricks( str_objective );
        cp_mi_sing_biodomes::function_cef897cf( str_objective );
        level thread clientfield::set( "party_house_shutter", 1 );
        level thread clientfield::set( "party_house_destruction", 1 );
        level.turret_markets1 = spawner::simple_spawn_single( "turret_markets1" );
        level.turret_markets1 kill();
        thread markets_shutters_open();
        level thread cp_mi_sing_biodomes_util::function_753a859( str_objective );
        level thread cp_mi_sing_biodomes_util::function_cc20e187( "markets1" );
        objectives::set( "cp_level_biodomes_cloud_mountain" );
        load::function_a2995f22();
        level thread namespace_f1b4cbbc::function_fa2e45b8();
    }
    
    if ( isdefined( level.bzm_biodialogue2_2callback ) )
    {
        level thread [[ level.bzm_biodialogue2_2callback ]]();
    }
    
    level thread cp_mi_sing_biodomes_util::function_cc20e187( "markets2", 1 );
    level thread cp_mi_sing_biodomes_util::function_cc20e187( "warehouse", 1 );
    level.var_996e05eb = "friendly_spawns_markets2_tunnel";
    level scene::init( "p7_fxanim_cp_biodomes_market_bridge_bundle" );
    spawn_markets2_enemies();
    cp_mi_sing_biodomes_util::enable_traversals( 0, "markets2_bridge_traversals", "script_noteworthy" );
    hidemiscmodels( "fxanim_party_house" );
    showmiscmodels( "fxanim_warehouse" );
    trigger::wait_till( "trig_warehouse_entrance" );
    cp_mi_sing_biodomes_util::kill_previous_spawns( "sm_markets1_combat0" );
    cp_mi_sing_biodomes_util::kill_previous_spawns( "sm_markets1_combat1" );
    cp_mi_sing_biodomes_util::kill_previous_spawns( "sm_markets1_combat2" );
    cp_mi_sing_biodomes_util::kill_previous_spawns( "sm_markets1_combat3" );
    cp_mi_sing_biodomes_util::kill_previous_spawns( "sm_markets_rpg_nest" );
    
    if ( isalive( level.turret_markets1 ) )
    {
        level.turret_markets1 util::stop_magic_bullet_shield();
        level.turret_markets1 kill();
    }
    
    if ( isalive( level.turret_markets2 ) )
    {
        level.turret_markets2 util::stop_magic_bullet_shield();
        level.turret_markets2 kill();
    }
    
    level skipto::objective_completed( "objective_markets2_start" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x16f59913, Offset: 0x4e20
// Size: 0x1e4
function function_11549ce5()
{
    objectives::set( "cp_waypoint_breadcrumb", struct::get( "breadcrumb_markets2_pit" ) );
    trigger::wait_till( "trig_markets2_combat2b" );
    objectives::complete( "cp_waypoint_breadcrumb", struct::get( "breadcrumb_markets2_pit" ) );
    objectives::set( "cp_waypoint_breadcrumb", struct::get( "breadcrumb_markets2_arch" ) );
    trigger::wait_till( "trig_markets2_turret_intro" );
    objectives::complete( "cp_waypoint_breadcrumb", struct::get( "breadcrumb_markets2_arch" ) );
    objectives::set( "cp_waypoint_breadcrumb", struct::get( "breadcrumb_markets2_bridge" ) );
    trigger::wait_till( "trig_markets2_combat3" );
    objectives::complete( "cp_waypoint_breadcrumb", struct::get( "breadcrumb_markets2_bridge" ) );
    objectives::set( "cp_waypoint_breadcrumb", struct::get( "breadcrumb_markets2_end" ) );
    trigger::wait_till( "trig_warehouse_entrance" );
    objectives::complete( "cp_waypoint_breadcrumb", struct::get( "breadcrumb_markets2_end" ) );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xca2c98d1, Offset: 0x5010
// Size: 0x1ec
function spawn_markets2_enemies()
{
    level thread vo_markets2();
    trigger::wait_till( "trig_markets2_hendricks_pit" );
    trigger::use( "trig_hendricks_color_markets2_pit" );
    spawn_manager::enable( "sm_markets2_combat0" );
    level.turret_markets2 = spawner::simple_spawn_single( "turret_markets2" );
    level.turret_markets2 thread function_9e873c98();
    level.turret_markets2 thread markets2_turret_hint_fire();
    level flag::set( "turret2" );
    trigger::wait_till( "trig_markets2_combat2" );
    level.ai_hendricks notify( #"player_in_pit" );
    level.ai_hendricks notify( #"started_arch_scene" );
    level notify( #"prisoners_enabled" );
    level.ai_hendricks thread hendricks_arch_scene();
    trigger::wait_till( "trig_markets2_turret_intro" );
    level.var_996e05eb = "friendly_spawns_markets2_waterfall";
    spawn_manager::enable( "sm_markets2_combat2c" );
    spawn_manager::enable( "sm_markets2_warlord" );
    level thread function_306c7d29();
    level.ai_hendricks notify( #"player_past_arch" );
    level thread cp_mi_sing_biodomes_util::aigroup_retreat( "markets2_retreaters", "info_volume_markets2_rear", 0, 0.1 );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x86e9a655, Offset: 0x5208
// Size: 0xec
function markets2_ambush_guys()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self ai::set_behavior_attribute( "coverIdleOnly", 1 );
    level util::waittill_notify_or_timeout( "player_in_pit", 5 );
    wait randomfloatrange( 0, 0.5 );
    self ai::set_behavior_attribute( "coverIdleOnly", 0 );
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x76ac64, Offset: 0x5300
// Size: 0x224
function hendricks_arch_scene()
{
    self notify( #"started_arch_scene" );
    level flag::wait_till( "hendricks_markets2_arch_throw" );
    ai_arch_throw = spawner::simple_spawn_single( "sp_arch_thrown_off", &function_8fcead5c, "markets2_hendricks_throw_arch", 1 );
    level scene::play( "markets2_hendricks_throw_arch", "targetname", array( self, ai_arch_throw ) );
    nd_hendricks = getnode( "cover_hendricks_arch", "targetname" );
    self setgoal( nd_hendricks );
    level flag::wait_till( "hendricks_markets2_wallrun" );
    ai_balcony_throw = spawner::simple_spawn_single( "sp_hendricks_wallrun_fodder", &function_8fcead5c, "cin_bio_04_03_market2_vign_wallrun", 0 );
    level scene::play( "cin_bio_04_03_market2_vign_wallrun", array( self, ai_balcony_throw ) );
    nd_hendricks = getnode( "nd_hendricks_window_after_wallrun", "targetname" );
    self thread ai::force_goal( nd_hendricks, 12, 1, "goal", 1 );
    self waittill( #"goal" );
    self clearforcedgoal();
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 2
// Checksum 0xf5a08a95, Offset: 0x5530
// Size: 0x9c
function function_8fcead5c( str_scene, var_5d5638aa )
{
    self.goalradius = 8;
    self.goalheight = 8;
    self ai::set_ignoreme( 1 );
    self waittill( #"death" );
    
    if ( var_5d5638aa )
    {
        level scene::stop( str_scene, "targetname" );
        return;
    }
    
    level scene::stop( str_scene );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1
// Checksum 0xf537fd18, Offset: 0x55d8
// Size: 0x4c
function stop_hendricks_throws( str_scene_targetname )
{
    level endon( #"enemy_thrown_off" );
    self waittill( #"death" );
    wait 0.5;
    level scene::stop( str_scene_targetname, "targetname" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x16e930c2, Offset: 0x5630
// Size: 0x13c
function vo_markets2()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    level dialog::remote( "kane_heads_up_got_54i_r_0" );
    var_d65ac7cc = trigger::wait_till( "trig_markets2_turret_intro" );
    level.ai_hendricks dialog::say( "hend_moving_up_gimme_som_0" );
    
    if ( var_d65ac7cc.script_label == "path_arch" )
    {
        level dialog::player_say( "plyr_covering_go_0" );
    }
    
    trigger::wait_till( "trig_rpg_tower_vo" );
    
    if ( !level flag::get( "markets2_tower_destroyed" ) )
    {
        level thread dialog::player_say( "plyr_got_an_rpg_in_that_t_0" );
    }
    
    level endon( #"turret2_dead" );
    wait 8;
    level.ai_hendricks dialog::say( "hend_we_gotta_take_out_th_1" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 1
// Checksum 0x1a9cba5b, Offset: 0x5778
// Size: 0x7e
function function_b27f1679( a_ents )
{
    level notify( #"hash_ad26056f" );
    
    for ( i = 1; i <= 3 ; i++ )
    {
        a_ents[ "sp_civilian_headpop" + i ].var_70a4ef5f = a_ents[ "bomb_collar_" + i ];
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xd3ddcf9f, Offset: 0x5800
// Size: 0x1bc
function headpop_tracking()
{
    self endon( #"death" );
    self util::magic_bullet_shield();
    self ai::gun_remove();
    level waittill( #"hash_ad26056f" );
    self waittill( #"head_pop" );
    self.var_70a4ef5f hide();
    playrumbleonposition( "cp_biodomes_headpop_rumble", self.origin );
    
    foreach ( player in level.players )
    {
        distance = distance2dsquared( player.origin, self.origin );
        
        if ( distance < 160000 && self cansee( player ) )
        {
            player dodamage( player.health * 0.1, self.origin );
        }
    }
    
    self util::stop_magic_bullet_shield();
    gibserverutils::gibhead( self );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xf250c391, Offset: 0x59c8
// Size: 0x214
function function_1c8db87()
{
    var_6f261beb = 6;
    var_80110940 = 4;
    var_72e94765 = [];
    
    for ( m = 1; m <= var_6f261beb ; m++ )
    {
        var_83491dca = spawner::simple_spawn_single( "bound_civ_male" );
        var_83491dca.animname = "prisoner_male_0" + m;
        var_83491dca.overrideactordamage = &function_c1c247f6;
        
        if ( !isdefined( var_72e94765 ) )
        {
            var_72e94765 = [];
        }
        else if ( !isarray( var_72e94765 ) )
        {
            var_72e94765 = array( var_72e94765 );
        }
        
        var_72e94765[ var_72e94765.size ] = var_83491dca;
    }
    
    for ( f = 1; f <= var_80110940 ; f++ )
    {
        var_83491dca = spawner::simple_spawn_single( "bound_civ_female" );
        var_83491dca.animname = "prisoner_female_0" + f;
        var_83491dca.overrideactordamage = &function_c1c247f6;
        
        if ( !isdefined( var_72e94765 ) )
        {
            var_72e94765 = [];
        }
        else if ( !isarray( var_72e94765 ) )
        {
            var_72e94765 = array( var_72e94765 );
        }
        
        var_72e94765[ var_72e94765.size ] = var_83491dca;
    }
    
    level scene::play( "cin_bio_04_01_market2_vign_caged", var_72e94765 );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xa63f8f86, Offset: 0x5be8
// Size: 0x1fa
function function_4ef9f5db()
{
    var_64bc5989 = struct::get_array( "prisoner_aligns", "script_noteworthy" );
    var_d71a37a5 = spawn( "script_origin", ( 9944, 12957, -163 ) );
    var_d71a37a5 playloopsound( "amb_slaves_a" );
    var_fd1cb20e = spawn( "script_origin", ( 9895, 13170, -163 ) );
    var_fd1cb20e playloopsound( "amb_slaves_b" );
    
    foreach ( s_align in var_64bc5989 )
    {
        var_83491dca = spawner::simple_spawn_single( s_align.script_string );
        
        if ( s_align.script_label == "male" )
        {
            str_scene_name = "cin_bio_04_01_market2_vign_bound_civ01";
        }
        else
        {
            str_scene_name = "cin_bio_04_01_market2_vign_bound_civ02";
        }
        
        s_align thread scene::play( str_scene_name, var_83491dca );
        wait 1;
        var_83491dca kill();
        wait randomfloatrange( 0, 2 );
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x3fbc8dbb, Offset: 0x5df0
// Size: 0xb2
function function_dbb91fcf()
{
    var_64bc5989 = struct::get_array( "prisoner_aligns", "script_noteworthy" );
    
    foreach ( s_align in var_64bc5989 )
    {
        s_align scene::stop();
    }
}

// Namespace cp_mi_sing_biodomes_markets
// Params 15
// Checksum 0xa5c85736, Offset: 0x5eb0
// Size: 0x102
function function_c1c247f6( e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, v_damage_origin, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name, v_surface_normal )
{
    var_f6896234 = isinarray( array( "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE" ), str_means_of_death );
    
    if ( var_f6896234 && e_attacker isbadguy() )
    {
        n_damage = 0;
    }
    
    return n_damage;
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x1eb03d9, Offset: 0x5fc0
// Size: 0x11c
function markets2_turret_hint_fire()
{
    self endon( #"death" );
    trigger::wait_till( "trig_markets2_turret_intro" );
    s_markets2_turret_target = struct::get( "s_markets2_turret_target", "targetname" );
    m_turret_target = util::spawn_model( "tag_origin", s_markets2_turret_target.origin, s_markets2_turret_target.angles );
    level.turret_markets2 turret::set_target( m_turret_target, ( 0, 0, 0 ), 0 );
    m_turret_target movex( 40, 3 );
    m_turret_target movey( -200, 3 );
    m_turret_target waittill( #"movedone" );
    level.turret_markets2 turret::clear_target( 0 );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x98641d4b, Offset: 0x60e8
// Size: 0x1ac
function markets2_rpg_tower()
{
    level thread function_226ac1e4();
    self waittill( #"death" );
    var_9faa0c88 = getweapon( "smaw" );
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        tag = "tag_eye";
    }
    else
    {
        tag = "tag_aim";
    }
    
    v_rocket_launch = self gettagorigin( "tag_aim" );
    v_origin = self.origin;
    var_2f7fd5db = self.damageweapon;
    
    if ( var_2f7fd5db == getweapon( "gadget_mrpukey" ) )
    {
        wait 2;
    }
    else
    {
        wait 0.5;
    }
    
    magicbullet( var_9faa0c88, v_rocket_launch, v_origin );
    playrumbleonposition( "cp_biodomes_rpg_tower_rumble", v_origin );
    level notify( #"hash_f311a0e2" );
    level flag::set( "markets2_tower_destroyed" );
    level scene::play( "p7_fxanim_cp_biodomes_guard_tower_warehouse_bundle" );
    biodomes_accolades::function_b5cf7b68();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xf03fae81, Offset: 0x62a0
// Size: 0xd8
function function_226ac1e4()
{
    trigger::wait_till( "trig_markets2_rpg_tower_warning" );
    var_9faa0c88 = getweapon( "smaw" );
    var_11fd5f3f = struct::get( "markets2_rpg_tower_warning_launch", "targetname" );
    var_6beedec9 = struct::get( "markets2_rpg_tower_warning_target", "targetname" );
    e_rocket = magicbullet( var_9faa0c88, var_11fd5f3f.origin, var_6beedec9.origin );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xe260348c, Offset: 0x6380
// Size: 0xc4
function markets2_bridge_retreaters()
{
    self endon( #"death" );
    level endon( #"bridge_destroyed" );
    self thread function_e143a359();
    self ai::set_ignoreall( 1 );
    nd_goal = getnode( self.target, "targetname" );
    
    if ( isdefined( nd_goal ) )
    {
        self ai::force_goal( nd_goal, 12, 0, "goal", 0, 1 );
        self waittill( #"goal" );
    }
    
    self ai::set_ignoreall( 0 );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x1fcf8403, Offset: 0x6450
// Size: 0x54
function function_e143a359()
{
    self endon( #"goal" );
    self endon( #"death" );
    level waittill( #"bridge_destroyed" );
    self ai::set_ignoreall( 0 );
    self clearforcedgoal();
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x24cf0fc1, Offset: 0x64b0
// Size: 0x34
function markets2_robot_rushers()
{
    self endon( #"death" );
    self ai::set_behavior_attribute( "move_mode", "rusher" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x3415cd27, Offset: 0x64f0
// Size: 0x31c
function markets2_bridge_retract()
{
    level endon( #"markets2_end" );
    trigger::wait_till( "trig_markets2_turret_intro" );
    var_b31ff87c = spawner::simple_spawn_single( "sp_bridge_controller" );
    
    if ( isalive( var_b31ff87c ) )
    {
        level thread scene::play( "cin_bio_04_01_market2_vign_bridge_destroy", var_b31ff87c );
        level thread util::delay_notify( 15, "retract_bridge" );
        level util::waittill_any_ents_two( level, "retract_bridge", var_b31ff87c, "death" );
        
        if ( level scene::is_playing( "cin_bio_04_01_market2_vign_bridge_destroy" ) )
        {
            level scene::stop( "cin_bio_04_01_market2_vign_bridge_destroy" );
        }
    }
    
    level thread scene::play( "p7_fxanim_cp_biodomes_market_bridge_bundle" );
    var_97268a8e = struct::get( "breadcrumb_markets2_bridge", "targetname" );
    
    if ( isdefined( var_97268a8e ) )
    {
        playrumbleonposition( "cp_biodomes_markets2_bridge_rumble", var_97268a8e.origin );
        
        foreach ( player in level.activeplayers )
        {
            distance = distance2dsquared( player.origin, var_97268a8e.origin );
            
            if ( distance < 160000 )
            {
                player dodamage( player.health * 0.1, var_97268a8e.origin );
            }
        }
    }
    
    e_bridge_collision = getent( "markets2_bridge_collision", "targetname" );
    
    if ( isdefined( e_bridge_collision ) )
    {
        e_bridge_collision notsolid();
        e_bridge_collision disconnectpaths();
    }
    
    level notify( #"bridge_destroyed" );
    cp_mi_sing_biodomes_util::enable_traversals( 1, "markets2_bridge_traversals", "script_noteworthy" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xfb16f445, Offset: 0x6818
// Size: 0xfc
function function_306c7d29()
{
    trigger::wait_till( "trig_markets2_robot_colors_end" );
    level.var_996e05eb = "friendly_spawns_markets2_warlord";
    v_start = struct::get( "phalanx_markets2_start" ).origin;
    v_end = struct::get( "phalanx_markets2_end" ).origin;
    n_phalanx = 4;
    
    if ( level.players.size >= 2 )
    {
        n_phalanx = 6;
    }
    
    phalanx = new robotphalanx();
    [[ phalanx ]]->initialize( "phanalx_wedge", v_start, v_end, 2, n_phalanx );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0xf658412, Offset: 0x6920
// Size: 0x7c
function function_ff2bafac()
{
    self endon( #"death" );
    self setthreatbiasgroup( "warlords" );
    setthreatbias( "heroes", "warlords", -9999 );
    self cp_mi_sing_biodomes_util::function_f61c0df8( "node_warlord_markets2_preferred", 1, 2 );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 4
// Checksum 0x3ec3e05c, Offset: 0x69a8
// Size: 0x4a
function objective_markets2_start_done( str_objective, b_starting, b_direct, player )
{
    cp_mi_sing_biodomes_util::objective_message( "objective_markets2_start_done" );
    level notify( #"markets2_end" );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x29ec344d, Offset: 0x6a00
// Size: 0x10c
function function_70da4f9b()
{
    self.b_keylined = 0;
    self.b_targeted = 0;
    level.turret_markets1.ignoreall = 1;
    level.turret_markets1.ignoreme = 1;
    self cybercom::cybercom_aioptout( "cybercom_hijack" );
    self.script_noteworthy = "floor_collapse";
    level.turret_markets1 turret::set_on_target_angle( 1, 0 );
    self waittill( #"death" );
    level flag::set( "turret1_dead" );
    nd_hendricks = getnode( "cover_hendricks_headpopper", "targetname" );
    level.ai_hendricks setgoal( nd_hendricks, 1 );
}

// Namespace cp_mi_sing_biodomes_markets
// Params 0
// Checksum 0x5776a114, Offset: 0x6b18
// Size: 0x3c
function function_9e873c98()
{
    self waittill( #"death" );
    level flag::set( "turret2_dead" );
    savegame::checkpoint_save();
}

