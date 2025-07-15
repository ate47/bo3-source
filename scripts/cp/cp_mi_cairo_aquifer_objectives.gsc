#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_aquifer_accolades;
#using scripts/cp/cp_mi_cairo_aquifer_aitest;
#using scripts/cp/cp_mi_cairo_aquifer_ambience;
#using scripts/cp/cp_mi_cairo_aquifer_boss;
#using scripts/cp/cp_mi_cairo_aquifer_fx;
#using scripts/cp/cp_mi_cairo_aquifer_interior;
#using scripts/cp/cp_mi_cairo_aquifer_sound;
#using scripts/cp/cp_mi_cairo_aquifer_utility;
#using scripts/cp/cp_mi_cairo_aquifer_water_room;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/shared/_oob;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace aquifer_obj;

// Namespace aquifer_obj
// Params 0
// Checksum 0x3441791b, Offset: 0x2bc8
// Size: 0xba
function function_5025ad5()
{
    /#
        level notify( #"hash_17a0d3bd" );
        level endon( #"hash_17a0d3bd" );
        wait 8;
        
        foreach ( player in level.players )
        {
            level.billboard_event = "<dev string:x28>";
            player notify( #"update_billboard" );
        }
    #/
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x7cba6699, Offset: 0x2c90
// Size: 0xc4
function handle_intro_dialog()
{
    level dialog::remote( "khal_the_nrc_has_already_0", 0 );
    level dialog::remote( "kane_copy_that_khalil_w_0", 0.2 );
    level dialog::remote( "hend_what_about_taylor_1", 0.15 );
    level dialog::player_say( "plyr_one_thing_at_a_time_0", 0.2 );
    level flag::set( "intro_dialog_finished" );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x4af9db32, Offset: 0x2d60
// Size: 0x2ac
function skipto_level_long_fly_in_init( str_objective, b_starting )
{
    level.var_4063f562 = "scripted";
    aquifer_util::function_61b71c43();
    hendricks = getent( "hendricks_intro", "targetname" ) spawner::spawn( 1 );
    load::function_c32ba481();
    thread aquifer_util::play_intro( hendricks );
    thread aquifer_util::intro_screen();
    objectives::set( "cp_level_aquifer_locate_aquifer" );
    thread handle_intro_dialog();
    level flag::wait_till( "intro_chryon_done" );
    wait 0.5;
    
    if ( isdefined( level.bzm_aquiferdialogue1callback ) )
    {
        level thread [[ level.bzm_aquiferdialogue1callback ]]();
    }
    
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 0 );
    thread aquifer_util::function_c1bd6415( "oob_trig", 0 );
    thread aquifer_util::function_c1bd6415( "defend_oob_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 0 );
    thread aquifer_util::function_287ca2ad( 0 );
    thread aquifer_util::function_77fde091( 0 );
    thread function_61034146( 1 );
    wait 0.5;
    level flag::wait_till( "intro_finished" );
    level clientfield::set( "gameplay_started", 1 );
    thread aquifer_util::function_c1bd6415( "oob_trig", 1 );
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0xf8e47add, Offset: 0x3018
// Size: 0x1cc
function function_61034146( bool )
{
    if ( bool )
    {
        exploder::exploder( "amb_ext_sand_vtol" );
        exploder::exploder( "amb_ext_deck_fire01" );
        exploder::exploder( "amb_ext_deck_fire02" );
        exploder::exploder( "amb_ext_deck_fire03" );
        exploder::exploder( "amb_ext_deck_fire04" );
        exploder::exploder( "amb_ext_ground" );
        exploder::exploder( "amb_ext_vista_war" );
        exploder::exploder( "amb_ext_lights" );
        exploder::exploder( "amb_ext_underwater" );
        return;
    }
    
    exploder::exploder_stop( "amb_ext_sand_vtol" );
    exploder::exploder_stop( "amb_ext_deck_fire01" );
    exploder::exploder_stop( "amb_ext_deck_fire02" );
    exploder::exploder_stop( "amb_ext_deck_fire03" );
    exploder::exploder_stop( "amb_ext_deck_fire04" );
    exploder::exploder_stop( "amb_ext_ground" );
    exploder::exploder_stop( "amb_ext_vista_war" );
    exploder::exploder_stop( "amb_ext_lights" );
    exploder::exploder_stop( "amb_ext_underwater" );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x59d23404, Offset: 0x31f0
// Size: 0x4c
function function_b3ed487d( bool )
{
    if ( bool )
    {
        exploder::exploder( "amb_underwater" );
        return;
    }
    
    exploder::kill_exploder( "amb_underwater" );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x5852a447, Offset: 0x3248
// Size: 0x4c
function function_e2d8799f( bool )
{
    if ( bool )
    {
        exploder::exploder( "amb_vtol_breach" );
        return;
    }
    
    exploder::exploder_stop( "amb_vtol_breach" );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x138e1c1c, Offset: 0x32a0
// Size: 0x4c
function function_5d32874c( bool )
{
    if ( bool )
    {
        exploder::exploder( "amb_int_post_breach" );
        return;
    }
    
    exploder::exploder_stop( "amb_int_post_breach" );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0xfd5fa569, Offset: 0x32f8
// Size: 0x4c
function function_f67ca613( bool )
{
    if ( bool )
    {
        exploder::exploder( "amb_int_runout" );
        return;
    }
    
    exploder::exploder_stop( "amb_int_runout" );
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x9419c5f1, Offset: 0x3350
// Size: 0x4c
function skipto_level_long_fly_in_done( str_objective, b_starting, b_direct, player )
{
    level struct::delete_script_bundle( "scene", "p7_fxanim_cp_aqu_war_airassault_bundle" );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0xa1eb8498, Offset: 0x33a8
// Size: 0x1fc
function function_ef5a929e( var_5d686f5c )
{
    if ( !isdefined( level.var_c8595f3e ) && var_5d686f5c )
    {
        return;
    }
    
    str_animname = "v_aqu_01_10_intro_1st_flyin_player" + self.player_num;
    n_anim_length = getanimlength( str_animname );
    self aquifer_util::player_init_heightmap_intro_state();
    self oob::disableplayeroob( 1 );
    
    if ( var_5d686f5c )
    {
        n_time_passed = ( gettime() - level.var_c8595f3e ) / 1000;
        var_5e1f5b2 = n_time_passed / n_anim_length;
        n_start_time = math::clamp( var_5e1f5b2, 0, 0.45 );
    }
    else
    {
        n_start_time = 0;
    }
    
    root = getent( "intro_scene", "targetname" );
    self aquifer_util::function_d683f26a();
    self.pvtol thread animation::play( "v_aqu_01_10_intro_1st_flyin_player" + self.player_num, root, undefined, 1, 0, 0, 0, n_start_time );
    thread aquifer_util::function_b7cf4d2d( self );
    self thread aquifer_util::function_af376a0e( "v_aqu_01_10_intro_1st_flyin_player" + self.player_num, self.player_num - 1, "v_aqu_dogfight_intro_enemy" + self.player_num, "intro_dogfight_global_active" );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x2b01440f, Offset: 0x35b0
// Size: 0xca
function function_c28ce61e( time )
{
    wait time;
    level flag::clear( "dogfighting" );
    level flagsys::clear( "dogfight_ending" );
    
    foreach ( player in level.activeplayers )
    {
        player notify( #"hash_b4a5f622" );
    }
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x76575dee, Offset: 0x3688
// Size: 0x284
function function_9239cf5c( str_objective, b_starting )
{
    level.var_4063f562 = "scripted";
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 0 );
    thread function_5025ad5();
    
    if ( b_starting )
    {
        thread function_61034146( 1 );
        load::function_a2995f22();
    }
    
    level flag::wait_till( "dogfighting" );
    wait 50;
    
    foreach ( player in level.activeplayers )
    {
        if ( isdefined( player.var_3dca6783 ) && player.var_3dca6783 > 0 )
        {
            break;
        }
        
        util::missionfailedwrapper_nodeath( &"CP_MI_CAIRO_AQUIFER_VTOL_DOGFIGHT_FAIL", &"CP_MI_CAIRO_AQUIFER_VTOL_DOGFIGHT_FAIL_HINT" );
        return;
    }
    
    level notify( #"hash_982117a3" );
    wait 3;
    level dialog::remote( "hend_we_re_taking_heavy_f_1", 0.25, "dni" );
    level flagsys::set( "dogfight_ending" );
    level flag::set( "intro_dogfight_global_active" );
    level thread dialog::remote( "kane_copy_that_we_re_cle_0", 0, "dni" );
    time = 10;
    level thread function_c28ce61e( time );
    level util::waittill_any_timeout( time, "dogfight_finished" );
    wait 1;
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 4
// Checksum 0xa94783c2, Offset: 0x3918
// Size: 0x94
function function_b3635282( str_objective, b_starting, b_direct, player )
{
    level struct::delete_script_bundle( "scene", "cin_aqu_01_10_intro_1st_flyin_main" );
    level struct::delete_script_bundle( "scene", "cin_aqu_01_10_intro_3rd_flyin_main" );
    
    if ( !b_starting )
    {
        objectives_complete( "cp_level_aquifer_locate_aquifer" );
    }
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x2892b9cb, Offset: 0x39b8
// Size: 0x1f4
function function_3230f09a( str_objective, b_starting )
{
    level flag::set( "level_long_fly_in_completed" );
    level flag::set( "inside_aquifer" );
    level flag::init( "vtol_display_target_distance", 1 );
    thread function_61034146( 1 );
    
    for ( i = 1; i <= 4 ; i++ )
    {
        aquifer_util::function_1215f9e4( i );
    }
    
    thread aquifer_util::function_c1bd6415( "oob_trig", 0 );
    thread aquifer_util::function_c1bd6415( "defend_oob_trig", 1 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 0 );
    thread aquifer_util::function_287ca2ad( 0 );
    thread aquifer_util::function_77fde091( 0 );
    level flag::wait_till( "player_active_in_level" );
    aquifer_util::init_heightmap_intro_state();
    thread aquifer_util::function_dbe3d86f();
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x7b736f3, Offset: 0x3bb8
// Size: 0x24
function function_a02afda4( str_objective, b_starting, b_direct, player )
{
    
}

/#

    // Namespace aquifer_obj
    // Params 1
    // Checksum 0x1c6b2d05, Offset: 0x3be8
    // Size: 0x78, Type: dev
    function debug_objs( txt )
    {
        self endon( #"death" );
        color = ( 1, 1, 1 );
        size = 12;
        
        while ( true )
        {
            print3d( self.origin, txt, color, 1, size );
            wait 0.05;
        }
    }

#/

// Namespace aquifer_obj
// Params 4
// Checksum 0x6836b015, Offset: 0x3c68
// Size: 0xfc
function complete_obj_when_ent_dies( obj_id, obj, ent, notify_send )
{
    ent waittill( #"death" );
    level flag::set( "can_spawn_hunters" );
    aquifer_util::explosion_launcher( obj.origin );
    
    if ( isvehicle( ent ) )
    {
        playsoundatposition( "evt_vehicle_explosion_lyr", ent.origin );
    }
    
    objectives_complete( obj_id, obj, 0 );
    level notify( notify_send );
    wait 20;
    
    if ( isdefined( obj ) )
    {
        obj delete();
    }
}

/#

    // Namespace aquifer_obj
    // Params 0
    // Checksum 0x25ab6f7e, Offset: 0x3d70
    // Size: 0x7e, Type: dev
    function debug_kill_tanks()
    {
        wait 8;
        numo = level.quad_tank_objectives.size;
        
        for ( i = 0; i < numo ; i++ )
        {
            wait 20 / numo;
            level.quad_tank_objectives[ i ] delete();
        }
    }

#/

// Namespace aquifer_obj
// Params 1
// Checksum 0x34033acd, Offset: 0x3df8
// Size: 0x17a
function defenses_vo( var_dc822a23 )
{
    if ( !( isdefined( var_dc822a23 ) && var_dc822a23 ) )
    {
        level flagsys::wait_till_clear( "dogfight_ending" );
    }
    
    level dialog::remote( "hend_alright_squad_we_ne_1", 2 );
    level flagsys::wait_till_timeout( 10, "common_defense_objectives_complete" );
    
    if ( level.obj_curr_dead == 0 )
    {
        level dialog::remote( "hend_hit_those_quad_units_0", 2 );
    }
    
    level flagsys::wait_till( "common_defense_objectives_complete" );
    level dialog::remote( "kane_good_job_khalil_ai_0", 1 );
    level dialog::remote( "khal_thanks_for_the_assis_0", 1 );
    level dialog::remote( "plyr_solid_copy_we_re_on_0", 1 );
    level dialog::remote( "hend_enemy_comms_this_0", 1 );
    level dialog::remote( "kane_we_ll_find_em_just_0", 1 );
    level notify( #"hash_a3351a62" );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x9fe11ca4, Offset: 0x3f80
// Size: 0x6c
function function_de74737( name )
{
    s = getent( name, "targetname" );
    spawned = s spawner::spawn( 1, undefined, undefined, undefined, 1 );
    return spawned;
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x387ffe3a, Offset: 0x3ff8
// Size: 0x66, Type: bool
function spawner_exists( tname )
{
    ent = getent( tname, "targetname" );
    
    if ( isdefined( ent ) && isspawner( ent ) )
    {
        return true;
    }
    
    return false;
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xc739b447, Offset: 0x4068
// Size: 0x114
function function_f5924bbd()
{
    self waittill( #"death", e_attacker );
    
    if ( isdefined( e_attacker ) )
    {
        e_org = spawn( "script_origin", self.origin );
        e_org endon( #"death" );
        var_2c0ee386 = vectortoangles( e_attacker.origin - e_org.origin );
        var_2c0ee386 = ( absangleclamp360( var_2c0ee386[ 0 ] ), var_2c0ee386[ 1 ], 0 );
        e_org.angles = var_2c0ee386;
        e_org scene::play( "p7_fxanim_cp_aqu_smoke_raven" );
        wait 0.5;
        e_org delete();
    }
}

// Namespace aquifer_obj
// Params 6
// Checksum 0x43850dc2, Offset: 0x4188
// Size: 0x4aa
function common_defenses_init( base_name, obj_main, obj_inworld, notify_send, var_396d9d43, var_a4981390 )
{
    level.quad_tank_objectives = [];
    count = 1;
    level flagsys::clear( "common_defense_objectives_complete" );
    aquifer_util::function_25207b76();
    
    while ( spawner_exists( base_name + count ) )
    {
        t = function_de74737( base_name + count );
        t.allow_movement = 0;
        level.quad_tank_objectives[ level.quad_tank_objectives.size ] = t;
        
        if ( isdefined( t.variant ) && t.variant == "rocketpod" )
        {
            t.trophy_disables = 4;
            t quadtank::remove_repulsor();
            objectives::hide_for_target( "cp_quadtank_rocket_icon", t );
            t thread function_f5924bbd();
            t thread aquifer_util::function_68714b99();
        }
        
        count++;
        util::wait_network_frame();
    }
    
    thread aquifer_util::function_6e0553f9();
    
    if ( isdefined( var_396d9d43 ) && var_396d9d43 )
    {
        return;
    }
    
    if ( level.quad_tank_objectives.size == 0 )
    {
        wait 0.5;
        level flagsys::set( "common_defense_objectives_complete" );
        return;
    }
    
    level.obj_curr_dead = 0;
    obj2 = [];
    
    for ( i = 0; i < level.quad_tank_objectives.size ; i++ )
    {
        obj2[ i ] = level.quad_tank_objectives[ i ];
    }
    
    if ( isdefined( var_a4981390 ) )
    {
        flag::wait_till( var_a4981390 );
    }
    
    objectives_set( obj_main );
    objectives_set( obj_inworld, obj2 );
    
    for ( i = 0; i < level.quad_tank_objectives.size ; i++ )
    {
        thread complete_obj_when_ent_dies( obj_inworld, obj2[ i ], level.quad_tank_objectives[ i ], notify_send );
    }
    
    wait 0.05;
    num_targets = level.quad_tank_objectives.size;
    var_3a3bf933 = [];
    var_3a3bf933[ var_3a3bf933.size ] = "hend_keep_hitting_them_w_1";
    var_3a3bf933[ var_3a3bf933.size ] = "kane_that_s_another_one_d_0";
    var_3a3bf933[ var_3a3bf933.size ] = "hend_target_down_2";
    var_3a3bf933[ var_3a3bf933.size ] = "kane_good_kill_keep_it_0";
    var_3a3bf933[ var_3a3bf933.size ] = "hend_he_s_not_coming_back_0";
    
    while ( level.obj_curr_dead < num_targets )
    {
        level waittill( notify_send );
        level.obj_curr_dead++;
        
        if ( num_targets - level.obj_curr_dead == 1 )
        {
            level thread dialog::remote( "hend_only_one_more_left_0" );
            continue;
        }
        
        if ( level.obj_curr_dead == 1 )
        {
            level thread dialog::remote( "hend_one_down_1" );
            continue;
        }
        
        if ( num_targets - level.obj_curr_dead > 1 )
        {
            level thread dialog::remote( var_3a3bf933[ randomint( var_3a3bf933.size ) ] );
        }
    }
    
    level flagsys::set( "common_defense_objectives_complete" );
    level notify( #"hash_194eb1ad" );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x40a51db0, Offset: 0x4640
// Size: 0x134
function skipto_hack_init2( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_a2995f22();
    }
    
    thread function_61034146( 1 );
    aquifer_util::init_heightmap_obj3_state();
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 1 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 1 );
    thread aquifer_util::function_c1bd6415( "defend_oob_trig", 1 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 1 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 0 );
    thread aquifer_util::function_77fde091( 0 );
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x1c421c8b, Offset: 0x4780
// Size: 0x24
function skipto_hack_done2( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x13b8c696, Offset: 0x47b0
// Size: 0x27c
function skipto_defenses_init( str_objective, b_starting )
{
    level.var_4063f562 = "piloted";
    cp_mi_cairo_aquifer_sound::function_de37a122();
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 1 );
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 1 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 1 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 1 );
    thread aquifer_util::function_c1bd6415( "defend_oob_trig", 1 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 1 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 1 );
    thread aquifer_util::function_287ca2ad( 0 );
    thread aquifer_util::function_77fde091( 0 );
    
    if ( b_starting )
    {
        load::function_a2995f22();
    }
    
    thread defenses_vo( b_starting );
    level thread aquifer_sound::function_bdb99f05();
    thread function_61034146( 1 );
    thread cp_mi_cairo_aquifer_aitest::function_25dcb860();
    thread aquifer_util::function_96450f49( "hen_def_front_", 0 );
    notify_send = "target_down";
    thread common_defenses_init( "quadtank_obj_", "cp_level_aquifer_destroy_defenses", "cp_level_aquifer_destroyme", notify_send );
    wait 0.1;
    aquifer_util::init_heightmap_intro_state();
    
    if ( isdefined( level.bzm_aquiferdialogue1_5callback ) )
    {
        level thread [[ level.bzm_aquiferdialogue1_5callback ]]();
    }
    
    level flagsys::wait_till( "common_defense_objectives_complete" );
    level waittill( #"hash_a3351a62" );
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x37b65f3d, Offset: 0x4a38
// Size: 0x44
function skipto_defenses_done( str_objective, b_starting, b_direct, player )
{
    if ( !b_starting )
    {
        objectives_complete( "cp_level_aquifer_destroy_defenses" );
    }
}

// Namespace aquifer_obj
// Params 3
// Checksum 0x714e8625, Offset: 0x4a88
// Size: 0x196
function team_within_radius_to_ent( team, ent, radius )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    guys = [];
    
    if ( team == "allies" )
    {
        guys = level.players;
    }
    else
    {
        guys = getaiteamarray( team );
    }
    
    ret = [];
    
    if ( !isdefined( radius ) )
    {
        radius = 256;
    }
    
    guys = arraysort( guys, ent.origin, 1, 16, radius );
    
    foreach ( dude in guys )
    {
        if ( !isdefined( dude ) || !isalive( dude ) )
        {
            continue;
        }
        
        if ( isvehicle( dude ) )
        {
            continue;
        }
        
        ret[ ret.size ] = dude;
    }
    
    return ret;
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x5bdc48ae, Offset: 0x4c28
// Size: 0x2cc
function defend_hack_objective( obj_id, obj, ent, notify_send )
{
    var_eae60027 = 1 + ( level.players.size - 1 ) * 0.5;
    remaining_time = 80000;
    start_time = gettime();
    
    if ( level.fast_hack )
    {
        if ( level.fast_hack > 1 )
        {
            remaining_time = level.fast_hack;
        }
        else
        {
            remaining_time = 0;
        }
    }
    
    var_ce0179c6 = remaining_time;
    var_dfd71aec = objectives::get_id_for_target( obj_id, obj );
    
    while ( remaining_time > 0 )
    {
        nearest_guys = team_within_radius_to_ent( "allies", ent, level.hack_upload_range );
        
        if ( nearest_guys.size > 0 )
        {
            remaining_time -= 50;
        }
        
        var_a40ea223 = 1 - remaining_time / var_ce0179c6;
        ent.var_a220f04a = var_a40ea223 * 100;
        objective_setprogress( var_dfd71aec, var_a40ea223 );
        
        foreach ( player in level.activeplayers )
        {
            player clientfield::set_player_uimodel( "hackUpload.percent", var_a40ea223 );
        }
        
        wait 0.05;
    }
    
    foreach ( player in level.players )
    {
        player clientfield::set_player_uimodel( "hackUpload.percent", 0 );
    }
    
    ent delete();
}

// Namespace aquifer_obj
// Params 5
// Checksum 0x20118b6d, Offset: 0x4f00
// Size: 0x22c
function complete_obj_when_hacked( obj_id, obj, obj_defend, ent, notify_send )
{
    if ( obj_id == "cp_level_aquifer_defendme" || obj_id == "cp_level_aquifer_defendme2" )
    {
        var_dfd71aec = objectives::get_id_for_target( obj_defend, obj );
        objective_setprogress( var_dfd71aec, 0 );
    }
    
    if ( ent.targetname == "exterior_hack_trig_right_1" )
    {
        level flag::wait_till( "flag_player_started_right_tower" );
    }
    
    if ( ent.targetname == "exterior_hack_trig_left_1" )
    {
        level flag::wait_till( "flag_player_started_left_tower" );
    }
    
    flag_base = ent.targetname;
    ent hacking::trigger_wait();
    flag_name = flag_base + "_started";
    
    if ( flag::exists( flag_name ) )
    {
        flag::set( flag_name );
    }
    
    ent triggerenable( 0 );
    objectives_set( obj_defend, obj );
    defend_hack_objective( obj_defend, obj, ent, notify_send );
    flag_name = flag_base + "_finished";
    
    if ( flag::exists( flag_name ) )
    {
        flag::set( flag_name );
    }
    
    level notify( notify_send );
    thread function_e2cebeb6( obj, obj_defend );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x7a3a78a6, Offset: 0x5138
// Size: 0x34
function function_e2cebeb6( obj, obj_defend )
{
    wait 5;
    objectives_complete( obj_defend, obj );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x2a2adaa9, Offset: 0x5178
// Size: 0x96
function setup_hacking( base_name )
{
    trigs = [];
    
    for ( curr_trig = 1; true ; curr_trig++ )
    {
        trig = getent( base_name + curr_trig, "targetname" );
        
        if ( !isdefined( trig ) )
        {
            break;
        }
        
        trigs[ trigs.size ] = trig;
    }
    
    return trigs;
}

// Namespace aquifer_obj
// Params 8
// Checksum 0xcdb6e005, Offset: 0x5218
// Size: 0x2da
function common_hacking_init( base_name, obj_main, obj_inworld, obj_defend, notify_send, var_f9d3d7f2, var_368eea5, var_d66abd8d )
{
    level flag::set( "can_spawn_hunters" );
    
    if ( !isdefined( var_f9d3d7f2 ) )
    {
        var_f9d3d7f2 = ( 0, 0, 0 );
    }
    
    level.hacking_trigs = setup_hacking( base_name );
    
    if ( level.hacking_trigs.size == 0 )
    {
        wait 0.5;
        level notify( #"common_hacking_objectives_complete" );
        return;
    }
    
    obj2 = [];
    
    for ( i = 0; i < level.hacking_trigs.size ; i++ )
    {
        obj2[ i ] = level.hacking_trigs[ i ].origin + var_f9d3d7f2;
    }
    
    thread objectives_set( obj_main, obj2 );
    
    for ( i = 0; i < level.hacking_trigs.size ; i++ )
    {
        thread complete_obj_when_hacked( obj_inworld, obj2[ i ], obj_defend, level.hacking_trigs[ i ], notify_send );
    }
    
    while ( isdefined( var_368eea5 ) )
    {
        if ( util::any_player_is_touching( var_368eea5, "allies" ) )
        {
            break;
        }
        
        wait 0.1;
    }
    
    thread objectives_complete( obj_main, obj2 );
    
    foreach ( trig in level.hacking_trigs )
    {
        trig thread aquifer_util::function_b86ff37e( 1, obj_inworld, var_d66abd8d );
    }
    
    num_targets = level.hacking_trigs.size;
    
    for ( curr_dead = 0; curr_dead < num_targets ; curr_dead++ )
    {
        level waittill( notify_send );
    }
    
    level notify( #"common_hacking_objectives_complete" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xa7e89753, Offset: 0x5500
// Size: 0x36, Type: bool
function player_in_vtol()
{
    if ( isdefined( self.pvtol ) && self islinkedto( self.pvtol ) )
    {
        return true;
    }
    
    return false;
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x210dfe59, Offset: 0x5540
// Size: 0x4c
function function_34231419()
{
    if ( !isdefined( level.obj_name ) || !isdefined( level.obj_structs ) )
    {
        return;
    }
    
    self thread function_eb911c76( level.obj_name, level.obj_structs );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x6617798b, Offset: 0x5598
// Size: 0x25a
function function_eb911c76( obj_name, obj_structs )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"hash_c42b010f" );
    
    while ( !self player_in_vtol() )
    {
        wait 0.05;
    }
    
    if ( isdefined( obj_structs ) )
    {
        self waittill( #"vtol_starting_landing", zone );
        level notify( #"hash_f3cbe351", zone );
        
        if ( level.var_b91023ce.size > 1 )
        {
            aquifer_util::function_fc653485();
            aquifer_util::function_1215f9e4( zone );
            
            foreach ( player in level.activeplayers )
            {
                if ( player != self )
                {
                    if ( self aquifer_util::function_5c971cb7() )
                    {
                        player aquifer_util::function_22a0413d( "landing_mode" );
                    }
                }
            }
            
            if ( !isdefined( level.var_710bdaa1 ) )
            {
                level.var_710bdaa1 = "left";
                level.var_d18b7098 = 0;
                
                if ( zone == 2 )
                {
                    level.var_710bdaa1 = "right";
                    level.var_d18b7098 = 1;
                    objectives_complete( obj_name, obj_structs[ 0 ] );
                }
                else
                {
                    objectives_complete( obj_name, obj_structs[ 1 ] );
                }
                
                wait 0.05;
            }
        }
    }
    
    while ( self player_in_vtol() )
    {
        wait 0.05;
    }
    
    level notify( #"player_landed" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xc7281377, Offset: 0x5800
// Size: 0x2c
function function_a5b8f98()
{
    if ( isdefined( level.var_4712f308 ) )
    {
        objectives::hide( level.var_4712f308, self );
    }
}

// Namespace aquifer_obj
// Params 3
// Checksum 0x8b6fb7a8, Offset: 0x5838
// Size: 0x174
function function_8c1f2dbc( obj_name, obj_structs, var_36fcba17 )
{
    wait 0.5;
    
    if ( !isdefined( var_36fcba17 ) )
    {
        var_36fcba17 = 0;
    }
    
    flag::set( "enable_vtol_landing_zones" );
    level endon( #"hash_c42b010f" );
    thread aquifer_util::function_191fff49( "landing_mode" );
    level.obj_name = obj_name;
    level.obj_structs = obj_structs;
    level callback::on_spawned( &function_34231419 );
    
    foreach ( player in level.activeplayers )
    {
        player thread function_eb911c76( obj_name, obj_structs );
    }
    
    level waittill( #"player_landed" );
    level.obj_name = undefined;
    level.obj_structs = undefined;
    callback::remove_on_spawned( &function_34231419 );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x363808ec, Offset: 0x59b8
// Size: 0x72
function function_2e932d4f( var_565ac03, obj_name )
{
    self endon( #"disconnect" );
    level endon( #"hash_fdb2d846" );
    
    while ( !self player_in_vtol() )
    {
        wait 0.05;
    }
    
    self function_44b0ba69();
    level notify( #"player_tookoff" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x36bc1587, Offset: 0x5a38
// Size: 0x96
function function_31e37f85()
{
    foreach ( player in level.activeplayers )
    {
        player function_44b0ba69();
    }
    
    level notify( #"hash_fdb2d846" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x68bcd155, Offset: 0x5ad8
// Size: 0x56
function function_44b0ba69()
{
    if ( isdefined( self.var_bd96c96f ) )
    {
        objective_state( self.var_bd96c96f, "done" );
        gameobjects::release_obj_id( self.var_bd96c96f );
        self.var_bd96c96f = undefined;
    }
}

// Namespace aquifer_obj
// Params 3
// Checksum 0xbbbdfbb6, Offset: 0x5b38
// Size: 0x240
function function_da18861f( var_565ac03, obj_name, zone )
{
    level endon( #"hash_fdb2d846" );
    wait 0.05;
    
    foreach ( player in level.activeplayers )
    {
        player.var_719c336f = randomfloatrange( 0, 3 );
        player.var_23a61090 = randomfloatrange( 0.8, 1.2 );
    }
    
    thread aquifer_util::function_191fff49( "call", zone );
    
    foreach ( player in level.activeplayers )
    {
        if ( player player_in_vtol() )
        {
            level notify( #"player_tookoff" );
            
            if ( isdefined( player.var_bd96c96f ) )
            {
                objective_state( player.var_bd96c96f, "done" );
                gameobjects::release_obj_id( player.var_bd96c96f );
                player.var_bd96c96f = undefined;
            }
            
            continue;
        }
        
        player thread function_2e932d4f( var_565ac03, obj_name );
    }
    
    level waittill( #"player_tookoff" );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x98882a23, Offset: 0x5d80
// Size: 0x17a
function function_7f0d6133( var_646c369 )
{
    foreach ( player in level.activeplayers )
    {
        if ( player player_in_vtol() )
        {
            continue;
        }
        
        player aquifer_util::function_d683f26a();
        player.var_bd96c96f = gameobjects::get_next_obj_id();
        objective_add( player.var_bd96c96f, "active", player.var_dda84f1a[ var_646c369 ].origin + ( 0, 0, 240 ), istring( "cp_level_aquifer_takeoff" ) );
        objective_setinvisibletoall( player.var_bd96c96f );
        objective_setvisibletoplayer( player.var_bd96c96f, player );
    }
}

// Namespace aquifer_obj
// Params 4
// Checksum 0xe8a0dcff, Offset: 0x5f08
// Size: 0x34
function function_ec898691( str_objective, b_starting, b_direct, player )
{
    thread function_4e30545e();
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xcb493e42, Offset: 0x5f48
// Size: 0x10c
function function_4e30545e()
{
    struct::delete_script_bundle( "scene", "cin_aqu_01_20_towerright_1st_panelrip" );
    struct::delete_script_bundle( "scene", "cin_aqu_01_20_towerright_vign_overload_enter" );
    struct::delete_script_bundle( "scene", "cin_aqu_01_20_towerleft_1st_panelrip" );
    struct::delete_script_bundle( "scene", "cin_aqu_01_20_towerleft_vign_overload_enter" );
    wait 3;
    struct::delete_script_bundle( "scene", "cin_aqu_01_20_towerleft_vign_overload_main" );
    struct::delete_script_bundle( "scene", "cin_aqu_01_20_towerleft_vign_overload_exit" );
    struct::delete_script_bundle( "scene", "cin_aqu_01_20_towerright_vign_overload_main" );
    struct::delete_script_bundle( "scene", "cin_aqu_01_20_towerright_vign_overload_exit" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x57c514b0, Offset: 0x6060
// Size: 0xa4
function function_a4dc564e()
{
    thread cp_mi_cairo_aquifer_aitest::function_2d0258ff();
    level dialog::remote( "hend_don_t_you_realize_wh_0" );
    level.kayne dialog::say( "kane_negative_hendricks_0", 0.25 );
    level.kayne dialog::say( "kane_we_can_overload_the_0", 0.25 );
    level flag::set( "finished_first_landing_vo" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xe43089de, Offset: 0x6110
// Size: 0x24
function function_b1b04e52()
{
    level dialog::remote( "kane_there_s_the_next_com_0" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x891a894e, Offset: 0x6140
// Size: 0x44
function function_e3e7229d()
{
    level flag::wait_till( "flight_to_water_vo_cleared" );
    level dialog::remote( "khal_i_can_still_read_you_0" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x5d6c5af4, Offset: 0x6190
// Size: 0x4a
function function_60c28440()
{
    level waittill( #"hash_571aa0aa" );
    
    if ( isdefined( level.bzm_aquiferdialogue1_2callback ) )
    {
        level thread [[ level.bzm_aquiferdialogue1_2callback ]]();
    }
    
    level.hacking_trigs[ 0 ] notify( #"trigger_hack", level.activeplayers[ 0 ] );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0xd8dc29f4, Offset: 0x61e8
// Size: 0x84
function function_6a7fa9c7( projectile )
{
    self endon( #"entityshutdown" );
    self endon( #"death" );
    self waittill( #"weapon_fired", projectile );
    wait 0.7;
    
    if ( isdefined( projectile ) )
    {
        projectile missile_settarget( undefined );
    }
    
    wait 4;
    
    if ( isdefined( projectile ) )
    {
        projectile delete();
    }
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x8ffe2a12, Offset: 0x6278
// Size: 0x704
function function_386c647b( str_objective, b_starting )
{
    level.var_4063f562 = "piloted";
    
    if ( isdefined( level.var_710bdaa1 ) )
    {
        level.var_a6f85f47 = 1;
    }
    
    if ( b_starting )
    {
        load::function_a2995f22();
    }
    
    level flag::set( "finished_first_landing_vo" );
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 1 );
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 1 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 1 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 1 );
    thread aquifer_util::function_c1bd6415( "defend_oob_trig", 1 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 1 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 0 );
    thread aquifer_util::function_287ca2ad( 0 );
    thread aquifer_util::function_77fde091( 0 );
    thread function_61034146( 1 );
    aquifer_util::init_heightmap_intro_state();
    var_a63b7eae = [];
    var_a63b7eae[ "left" ] = "exterior_hack_trig_left_";
    var_a63b7eae[ "right" ] = "exterior_hack_trig_right_";
    var_cd0b05cb = [];
    var_cd0b05cb[ "left" ] = "left_hack_use_trig";
    var_cd0b05cb[ "right" ] = "right_hack_use_trig";
    var_3f85d402 = 1;
    
    if ( !isdefined( level.var_710bdaa1 ) || level.var_710bdaa1 == "left" )
    {
        level.var_710bdaa1 = "right";
        aquifer_util::function_c897523d( "respawn_right_hack" );
    }
    else
    {
        var_3f85d402 = 0;
        level.var_710bdaa1 = "left";
        aquifer_util::function_c897523d( "respawn_left_hack" );
    }
    
    tr = getent( "start_spawning_zone01_enemies", "targetname" );
    tr triggerenable( 0 );
    thread aquifer_util::function_96450f49( "hen_" + level.var_710bdaa1 + "_", 1 );
    flag::set( "destroy_defenses_completed" );
    level notify( #"hash_4af9ae51" );
    cp_mi_cairo_aquifer_sound::function_de37a122();
    
    if ( b_starting )
    {
        wait 1;
    }
    
    aquifer_util::function_fc653485();
    var_368eea5 = undefined;
    
    if ( level.var_710bdaa1 == "right" )
    {
        aquifer_util::function_1215f9e4( 2 );
        var_368eea5 = getent( "vol_res_defend_kayne", "targetname" );
    }
    else
    {
        aquifer_util::function_1215f9e4( 1 );
        var_368eea5 = getent( "vol_port_defend_kayne", "targetname" );
    }
    
    var_97a3d1c2 = [];
    var_97a3d1c2[ "left" ] = "exterior_hack_trig_left_land";
    var_97a3d1c2[ "right" ] = "exterior_hack_trig_right_land";
    land = [];
    land[ land.size ] = struct::get( var_97a3d1c2[ level.var_710bdaa1 ] );
    objectives_set( "cp_level_aquifer_hack_terminals3" );
    objectives_set( "cp_level_aquifer_land", land );
    level.var_4712f308 = "cp_level_aquifer_land";
    thread function_33fdc686( 2 );
    function_8c1f2dbc( "cp_level_aquifer_land", land );
    
    if ( isdefined( level.bzm_aquiferdialogue1_4callback ) )
    {
        level thread [[ level.bzm_aquiferdialogue1_4callback ]]();
    }
    
    objectives_complete( "cp_level_aquifer_land" );
    level.var_4712f308 = undefined;
    objectives_complete( "cp_level_aquifer_hack_terminals3" );
    thread function_204cfb5c( land );
    level thread aquifer_sound::function_e703f818();
    thread function_60c28440();
    notify_send = "trigger_hacked";
    thread common_hacking_init( var_a63b7eae[ level.var_710bdaa1 ], "cp_level_aquifer_goto_comms", "cp_level_aquifer_hackme", "cp_level_aquifer_defendme2", notify_send, ( 0, 0, -256 ), var_368eea5, var_cd0b05cb[ level.var_710bdaa1 ] );
    level waittill( #"common_hacking_objectives_complete" );
    
    if ( isdefined( level.bzm_aquiferdialogue1_6callback ) )
    {
        level thread [[ level.bzm_aquiferdialogue1_6callback ]]();
    }
    
    wait 0.05;
    thread function_7f0d6133( var_3f85d402 );
    thread function_da18861f( var_97a3d1c2[ level.var_710bdaa1 ], "cp_level_aquifer_takeoff", var_3f85d402 + 1 );
    level util::waittill_any( "player_tookoff", "hotjoin_hack" );
    thread aquifer_util::function_c6b73822( "hendrix_delteme_spot" );
    level.var_a6f85f47 = undefined;
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x47f63435, Offset: 0x6988
// Size: 0x7d4
function skipto_hack_init( str_objective, b_starting )
{
    level.var_4063f562 = "piloted";
    
    if ( b_starting )
    {
        load::function_a2995f22();
        util::delay( 4, undefined, &aquifer_util::init_heightmap_intro_state, 1 );
        thread aquifer_util::function_96450f49( "hen_left_", 1 );
    }
    else
    {
        aquifer_util::init_heightmap_intro_state();
    }
    
    flag::set( "destroy_defenses_completed" );
    level notify( #"hash_4af9ae51" );
    thread function_61034146( 1 );
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 1 );
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 1 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 1 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 1 );
    thread aquifer_util::function_287ca2ad( 0 );
    thread aquifer_util::function_c1bd6415( "defend_oob_trig", 1 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 1 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 0 );
    thread aquifer_util::function_77fde091( 0 );
    cp_mi_cairo_aquifer_sound::function_de37a122();
    land = [];
    land[ land.size ] = struct::get( "exterior_hack_trig_left_land" );
    land[ land.size ] = struct::get( "exterior_hack_trig_right_land" );
    tr = getent( "start_spawning_zone01_enemies", "targetname" );
    tr triggerenable( 0 );
    objectives_set( "cp_level_aquifer_disrupt_comms" );
    objectives_set( "cp_level_aquifer_hack_terminals" );
    aquifer_util::function_fc653485();
    aquifer_util::function_1215f9e4( 1 );
    aquifer_util::function_1215f9e4( 2 );
    level.var_710bdaa1 = undefined;
    level.var_d18b7098 = 0;
    objectives_set( "cp_level_aquifer_land", land );
    level.var_4712f308 = "cp_level_aquifer_land";
    thread function_33fdc686( 1 );
    function_8c1f2dbc( "cp_level_aquifer_land", land );
    
    if ( isdefined( level.bzm_aquiferdialogue1_1callback ) )
    {
        level thread [[ level.bzm_aquiferdialogue1_1callback ]]();
    }
    
    thread function_204cfb5c( land );
    level thread aquifer_sound::function_e703f818();
    var_a63b7eae = [];
    var_a63b7eae[ "left" ] = "exterior_hack_trig_left_";
    var_a63b7eae[ "right" ] = "exterior_hack_trig_right_";
    var_cd0b05cb = [];
    var_cd0b05cb[ "left" ] = "left_hack_use_trig";
    var_cd0b05cb[ "right" ] = "right_hack_use_trig";
    var_368eea5 = undefined;
    
    if ( level.var_710bdaa1 == "right" )
    {
        var_368eea5 = getent( "vol_res_defend_kayne", "targetname" );
    }
    else
    {
        var_368eea5 = getent( "vol_port_defend_kayne", "targetname" );
    }
    
    thread aquifer_util::function_a97555a0( "enemy_vtol_riders_1", "hack_01_1_volume" );
    thread aquifer_util::function_a97555a0( "enemy_vtol_riders_2", "hack_01_2_volume" );
    thread aquifer_util::function_a97555a0( "enemy_vtol_riders_3", "hack_01_1_volume" );
    thread aquifer_util::function_a97555a0( "enemy_vtol_riders_4", "hack_01_2_volume" );
    thread function_60c28440();
    objectives_complete( "cp_level_aquifer_hack_terminals" );
    notify_send = "trigger_hacked";
    thread common_hacking_init( var_a63b7eae[ level.var_710bdaa1 ], "cp_level_aquifer_goto_comms", "cp_level_aquifer_hackme", "cp_level_aquifer_defendme", notify_send, ( 0, 0, -256 ), var_368eea5, var_cd0b05cb[ level.var_710bdaa1 ] );
    
    if ( level.var_710bdaa1 == "left" )
    {
        aquifer_util::function_c897523d( "respawn_left_hack" );
        aquifer_util::function_e1e437cb( 2 );
    }
    else
    {
        aquifer_util::function_e1e437cb( 1 );
        aquifer_util::function_c897523d( "respawn_right_hack" );
    }
    
    thread aquifer_util::function_96450f49( "hen_" + level.var_710bdaa1 + "_", 1 );
    level waittill( #"common_hacking_objectives_complete" );
    takeoff = struct::get( "exterior_hack_trig_left_land" );
    
    if ( level.var_710bdaa1 == "right" )
    {
        takeoff = struct::get( "exterior_hack_trig_right_land" );
    }
    
    var_97a3d1c2 = [];
    var_97a3d1c2[ "left" ] = "exterior_hack_trig_left_land";
    var_97a3d1c2[ "right" ] = "exterior_hack_trig_right_land";
    thread function_7f0d6133( level.var_d18b7098 );
    
    if ( isdefined( level.bzm_aquiferdialogue1_3callback ) )
    {
        level thread [[ level.bzm_aquiferdialogue1_3callback ]]();
    }
    
    thread function_da18861f( var_97a3d1c2[ level.var_710bdaa1 ], "cp_level_aquifer_takeoff", level.var_d18b7098 + 1 );
    level util::waittill_any( "player_tookoff", "hotjoin_hack" );
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x2468bb8b, Offset: 0x7168
// Size: 0x21a
function function_204cfb5c( land )
{
    objectives_complete( "cp_level_aquifer_land" );
    level.var_4712f308 = undefined;
    retval = level util::waittill_any_return( "hack_at_fifty_percent", "common_hacking_objectives_complete" );
    
    if ( isdefined( retval ) && retval == "hack_at_fifty_percent" )
    {
        level.var_4063f562 = undefined;
        
        foreach ( player in level.activeplayers )
        {
            var_cc98a8ec = isdefined( player.pvtol ) && isdefined( player.pvtol.state ) && player.pvtol.state == "landing_mode";
            
            if ( player aquifer_util::function_5c971cb7() && !var_cc98a8ec )
            {
                player thread aquifer_util::function_22a0413d( "piloted" );
            }
            
            player.pvtol notify( #"hash_c38e4003" );
            player.pvtol clientfield::set( "vtol_set_active_landing_zone_num", 0 );
            player clientfield::set_player_uimodel( "vehicle.showLandHint", 0 );
        }
    }
    
    flag::clear( "enable_vtol_landing_zones" );
    level notify( #"hash_c42b010f" );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x38bd7625, Offset: 0x7390
// Size: 0x74e
function function_33fdc686( var_52055f73 )
{
    zone = 1;
    level waittill( #"hash_f3cbe351", zone );
    var_961abda = getentarray( "landing_zone_kane", "targetname" );
    active = undefined;
    
    foreach ( lz in var_961abda )
    {
        var_60156652 = int( strtok( lz.script_noteworthy, "landing_zone_" )[ 0 ] );
        
        if ( zone == var_60156652 )
        {
            active = util::spawn_model( "tag_origin", lz.origin, lz.angles );
            break;
        }
    }
    
    if ( !isdefined( active ) )
    {
        /#
            iprintln( "<dev string:x2e>" );
        #/
        
        return;
    }
    
    if ( !isdefined( level.kane_vtol ) )
    {
        level.kane_vtol = vehicle::simple_spawn_single( "kane_vtol" );
    }
    
    if ( zone == 4 )
    {
        level.kayne = function_30343b22( "kayne_pre_water" );
    }
    else
    {
        level.kayne = function_30343b22( "kayne_hack" + zone );
    }
    
    if ( isdefined( level.kayne ) )
    {
        level.kayne setthreatbiasgroup( "players_ground" );
    }
    
    driver_offset = level.kane_vtol gettagorigin( "tag_driver" ) - level.kane_vtol.origin;
    driver_offset = ( 0, 0, driver_offset[ 2 ] );
    dock_pos = active.origin + ( 0, 0, 120 );
    start_pos = dock_pos + ( 0, 0, 3000 );
    level.kane_vtol.origin = start_pos;
    level.kane_vtol.angles = active.angles;
    wait 0.05;
    
    if ( isdefined( level.hendricks_vtol ) )
    {
        level.hendricks_vtol clientfield::set( "vtol_engines_state", 0 );
    }
    
    level.kane_vtol clientfield::set( "vtol_engines_state", 0 );
    level.kane_vtol clientfield::set( "vtol_canopy_state", 1 );
    level.kane_vtol clientfield::set( "vtol_enable_wash_fx", 1 );
    level.kane_vtol setspeed( 600, 1200, 1200 );
    level.kane_vtol setyawspeed( 59, 360, 360 );
    level.kane_vtol setvehgoalpos( dock_pos, 1 );
    level.kane_vtol settargetyaw( active.angles[ 1 ] );
    level.kane_vtol setneargoalnotifydist( 60 );
    level.kane_vtol sethoverparams( 0 );
    goal = level.kane_vtol util::waittill_any_timeout( 5, "goal", "near_goal" );
    level.var_1226dab0 = 1;
    
    switch ( var_52055f73 )
    {
        case 1:
            level.kayne colors::set_force_color( "r" );
            active thread scene::play( "cin_aqu_05_01_enter_vign_clamber", level.kayne );
            thread function_a4dc564e();
            break;
        case 2:
            level.kayne colors::set_force_color( "r" );
            active thread scene::play( "cin_aqu_05_01_enter_vign_clamber", level.kayne );
            thread function_b1b04e52();
            break;
        default:
            active thread scene::play( "cin_aqu_05_01_enter_vign_clamber", level.kayne );
            level thread function_e3e7229d();
            break;
    }
    
    cp_mi_cairo_aquifer_sound::function_de37a122( 0 );
    wait 2;
    level.kane_vtol clientfield::set( "vtol_canopy_state", 0 );
    wait 2;
    level.kane_vtol setspeed( 70, 150, 150 );
    level.kane_vtol setvehgoalpos( start_pos + ( 0, 0, 2048 ), 1 );
    goal = level.kane_vtol util::waittill_any_timeout( 5, "goal", "near_goal" );
    thread function_4d13a94b();
    level.kane_vtol clientfield::set( "vtol_enable_wash_fx", 0 );
    wait 2;
    active delete();
    level.kane_vtol delete();
    level.kane_vtol = undefined;
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xda1b4c32, Offset: 0x7ae8
// Size: 0x6c
function function_4d13a94b()
{
    ai::createinterfaceforentity( level.kayne );
    level.kayne ai::set_behavior_attribute( "cqb", 1 );
    wait 3;
    level.kayne ai::set_behavior_attribute( "cqb", 0 );
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x81c7ad27, Offset: 0x7b60
// Size: 0x2e
function skipto_hack_done( str_objective, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        return;
    }
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x2f56d10d, Offset: 0x7b98
// Size: 0x84
function vision_hint_exit_water()
{
    trig = getent( "vision_hint_exit_water", "targetname" );
    who = trig;
    
    while ( who != self )
    {
        trig waittill( #"trigger", who );
    }
    
    self hud_message::hintmessage( &"CP_MI_CAIRO_AQUIFER_ENHANCED_VISION", 5 );
}

// Namespace aquifer_obj
// Params 3
// Checksum 0x5bd3ef37, Offset: 0x7c28
// Size: 0xf4
function function_dcbdf6db( var_b53947c0, var_229b55c0, b_starting )
{
    if ( isdefined( b_starting ) && b_starting )
    {
        wait 2;
    }
    
    aquifer_util::function_fc653485();
    aquifer_util::function_1215f9e4( var_229b55c0 );
    flag::set( "enable_vtol_landing_zones" );
    land = [];
    land[ land.size ] = struct::get( var_b53947c0 );
    objectives_set( "cp_level_aquifer_land", land );
    level.var_4712f308 = "cp_level_aquifer_land";
    function_8c1f2dbc( "cp_level_aquifer_land", land, 1 );
}

// Namespace aquifer_obj
// Params 3
// Checksum 0xd8671180, Offset: 0x7d28
// Size: 0xe2
function function_d0068cf8( var_b53947c0, var_229b55c0, b_starting )
{
    if ( isdefined( b_starting ) && b_starting )
    {
        wait 2;
    }
    
    aquifer_util::function_fc653485();
    aquifer_util::function_1215f9e4( var_229b55c0 );
    flag::clear( "enable_vtol_landing_zones" );
    land = struct::get( var_b53947c0 );
    objectives_set( "cp_level_aquifer_takeoff", land );
    function_da18861f( var_b53947c0, "cp_level_aquifer_takeoff" );
    level notify( #"hash_5062a9ba" );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x81435072, Offset: 0x7e18
// Size: 0x4bc
function skipto_water_room_init( str_objective, b_starting )
{
    level.var_4063f562 = "piloted";
    thread cp_mi_cairo_aquifer_water_room::main();
    thread function_5025ad5();
    aquifer_util::function_5497473c();
    cp_mi_cairo_aquifer_sound::function_de37a122();
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    thread aquifer_util::function_287ca2ad( 0 );
    thread aquifer_util::function_c1bd6415( "defend_oob_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 1 );
    thread aquifer_util::function_77fde091( 1 );
    aquifer_util::function_c897523d( "respawn_ext_water_room" );
    objectives_complete( "cp_level_aquifer_disrupt_comms" );
    objectives_set( "cp_level_aquifer_waterroom" );
    objectives_set( "cp_level_aquifer_waterroom_land" );
    
    if ( b_starting )
    {
        load::function_a2995f22();
        function_61034146( 1 );
        function_b3ed487d( 0 );
    }
    
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 1 );
    level thread function_50ad9d6a();
    level thread aquifer_sound::function_ca2c6d9f();
    thread function_33fdc686( 3 );
    function_dcbdf6db( "water_room_land", 4, b_starting );
    objectives_complete( "cp_level_aquifer_land" );
    level.var_4712f308 = undefined;
    cp_mi_cairo_aquifer_sound::function_de37a122( 0 );
    objectives_complete( "cp_level_aquifer_waterroom_land" );
    objectives_set( "cp_level_aquifer_waterroom_enter" );
    level thread function_eee7cf7e();
    objectives::breadcrumb( "breadcrumb_water_room_a" );
    aquifer_util::function_ae0b01fe();
    level notify( #"hash_7e64f485" );
    level flag::wait_till( "flag_enter_water_moment" );
    level notify( #"hash_9fc8580a" );
    level thread aquifer_sound::function_bb8ce831();
    wait 0.5;
    objectives_complete( "cp_level_aquifer_waterroom_enter" );
    util::delay( 5, undefined, &objectives_set, "cp_level_aquifer_waterroom_last_known" );
    objectives::breadcrumb( "breadcrumb_in_water_start" );
    wait 0.5;
    level flag::wait_till( "flag_kayne_water_moment" );
    level.kayne notify( #"swim_done" );
    array::thread_all( level.players, &clientfield::set_to_player, "player_cam_bubbles", 0 );
    aquifer_util::function_c897523d( "respawn_in_data_center" );
    
    foreach ( p in level.activeplayers )
    {
        p clientfield::set_to_player( "player_bubbles_fx", 0 );
    }
    
    level waittill( #"hash_b580186f" );
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x3c7a2812, Offset: 0x82e0
// Size: 0xbc
function function_50ad9d6a()
{
    level dialog::remote( "kane_khalil_what_s_our_0" );
    wait 0.2;
    level thread lui::play_movie( "cp_aquifer_pip_HeroLocation", "pip" );
    level dialog::remote( "khal_nrc_radio_chatter_su_0" );
    level dialog::player_say( "plyr_we_can_still_get_the_0", 0.25 );
    level flag::set( "flight_to_water_vo_cleared" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x93519dd7, Offset: 0x83a8
// Size: 0x68
function function_eee7cf7e()
{
    level endon( #"hash_5067c11a" );
    
    while ( true )
    {
        var_dcc47e98 = trigger::wait_till( "to_water1" );
        trigger::use( "breadcrumb_water_room_a", "targetname", var_dcc47e98.who );
    }
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x922442f9, Offset: 0x8418
// Size: 0x644
function function_e2e38eb( str_objective, b_starting )
{
    level.var_4063f562 = "scripted";
    thread function_5025ad5();
    aquifer_util::init_heightmap_obj3_state();
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 0 );
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    thread aquifer_util::function_c1bd6415( "defend_oob_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 1 );
    thread aquifer_util::function_77fde091( 0 );
    aquifer_util::function_c897523d( "respawn_water_room_exit" );
    level scene::init( "cin_aqu_03_01_platform_1st_secureplatform" );
    clientfield::set( "water_room_exit_scenes", 1 );
    
    if ( b_starting )
    {
        load::function_a2995f22();
        level flag::init( "flag_door_explodes" );
        level flag::init( "flag_kayne_ready_trap" );
        level flag::set( "water_room_checkpoint" );
        level flag::set( "flag_door_explodes" );
        level flag::set( "flag_kayne_ready_trap" );
        cp_mi_cairo_aquifer_sound::function_de37a122( 0 );
        level.kayne = function_30343b22( "kaynewaterexit" );
        spawner::add_spawn_function_group( "water_robots", "targetname", &cp_mi_cairo_aquifer_water_room::robot_underwater_callback );
        spawner::add_spawn_function_group( "water_robots2", "targetname", &cp_mi_cairo_aquifer_water_room::robot_underwater_callback );
        thread cp_mi_cairo_aquifer_water_room::function_18af354a();
        thread cp_mi_cairo_aquifer_water_room::function_ee430caa();
        var_31b9fd4a = getent( "doubledoor_sbm", "targetname" );
        var_31b9fd4a delete();
        spawn_manager::enable( "spawn_manager_flood_robots" );
        spawn_manager::enable( "spawn_manager_water_robots" );
        struct = getent( "igc_kane_water", "targetname" );
        struct thread scene::skipto_end( "cin_aqu_03_21_server_room_doors_open" );
    }
    
    trig = getent( "water_room_trigger", "targetname" );
    struct = struct::get( trig.target, "targetname" );
    
    foreach ( p in level.activeplayers )
    {
        p clientfield::set_to_player( "player_bubbles_fx", 0 );
    }
    
    level flag::wait_till( "flag_kayne_ready_trap" );
    objectives_complete( "cp_level_aquifer_waterroom_last_known" );
    objectives_set( "cp_level_aquifer_waterroom_regroup", struct );
    level flag::wait_till( "flag_door_explodes" );
    level thread aquifer_sound::function_a2d40521();
    objectives_complete( "cp_level_aquifer_waterroom_regroup", struct );
    objectives_complete( "cp_level_aquifer_waterroom" );
    level thread function_a9d852c2();
    level flag::wait_till( "water_room_checkpoint" );
    thread cp_mi_cairo_aquifer_water_room::function_b563cc38();
    flag::clear( "enable_vtol_landing_zones" );
    objectives::breadcrumb( "breadcrumb_exit_water" );
    
    if ( isdefined( level.kayne ) )
    {
        level.kayne notify( #"swim_done" );
    }
    
    objectives_complete( "cp_level_aquifer_ambush_escape" );
    level flag::wait_till( "flag_khalil_water_exit" );
    cp_mi_cairo_aquifer_sound::function_de37a122( 0 );
    util::waittill_any( "water_exit_fade_out", "platform_scenes_done" );
    level thread function_a2ba5afd();
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xd92fc028, Offset: 0x8a68
// Size: 0xc4
function function_a2ba5afd()
{
    level lui::screen_fade_out( 0, "black", "water_igc_done" );
    util::wait_network_frame( 2 );
    aquifer_util::function_8bf8a765( 0 );
    thread aquifer_util::function_191fff49( "call", 4, 1, 0 );
    util::wait_network_frame( 2 );
    level thread lui::screen_fade_in( 0.3, "black", "water_igc_done" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x7e1f3f62, Offset: 0x8b38
// Size: 0x3c
function function_a9d852c2()
{
    level flag::wait_till( "flag_kane_start_water_escape" );
    objectives_set( "cp_level_aquifer_ambush_escape" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xa8284d1c, Offset: 0x8b80
// Size: 0x8a
function function_90eea052()
{
    foreach ( player in level.activeplayers )
    {
        player thread distscalar();
    }
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x3750b67c, Offset: 0x8c18
// Size: 0x124
function distscalar()
{
    if ( !self player_in_vtol() )
    {
        var_da1bd38e = self.var_dda84f1a[ 2 ].origin + anglestoforward( self.var_dda84f1a[ 2 ].angles ) * 250 + anglestoright( self.var_dda84f1a[ 2 ].angles ) * 48 + ( 0, 0, 60 );
        self setorigin( var_da1bd38e );
        self setplayerangles( self.var_dda84f1a[ 2 ].angles + ( 0, 180, 0 ) );
        self dontinterpolate();
    }
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x5cfa014f, Offset: 0x8d48
// Size: 0xd4
function skipto_water_room_done( str_objective, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        return;
    }
    
    wait 5;
    struct::delete_script_bundle( "scene", "cin_aqu_05_01_enter_1st_look" );
    struct::delete_script_bundle( "scene", "cin_aqu_02_01_floodroom_1st_dragged" );
    struct::delete_script_bundle( "scene", "cin_aqu_02_01_floodroom_1st_dragged_pt2" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_19_pre_water_room_kane" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_19_pre_water_room_wait_kane" );
}

// Namespace aquifer_obj
// Params 4
// Checksum 0xffd1378, Offset: 0x8e28
// Size: 0x8c
function function_829aa821( str_objective, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        return;
    }
    
    struct::delete_script_bundle( "scene", "cin_aqu_03_21_server_room_enter" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_20_water_room" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_20_water_room_idle" );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x3d263a46, Offset: 0x8ec0
// Size: 0x2b4
function function_1b47ae1f( var_dc822a23 )
{
    self endon( #"disconnect" );
    self thread aquifer_util::player_init_heightmap_intro_state( 1 );
    self aquifer_util::function_d683f26a( 0 );
    
    if ( isdefined( var_dc822a23 ) && var_dc822a23 )
    {
        if ( level flag::get( "dogfighting" ) )
        {
            if ( level.var_4063f562 == "scripted" || isdefined( level.var_4063f562 ) && level.var_4063f562 == "piloted" )
            {
                self aquifer_util::function_22a0413d( level.var_4063f562 );
            }
            else
            {
                self aquifer_util::function_22a0413d();
            }
        }
        else
        {
            self thread distscalar();
            wait 0.05;
            self thread aquifer_util::function_22a0413d( "call", 4, 1 );
        }
    }
    else
    {
        self setinvisibletoall();
        util::delay( 0.5, undefined, &setvisibletoall );
    }
    
    if ( !( isdefined( var_dc822a23 ) && var_dc822a23 && level flag::get( "dogfighting" ) ) )
    {
        self waittill( #"vtol_takeoff" );
    }
    
    while ( !self islinkedto( self.pvtol ) )
    {
        wait 0.05;
    }
    
    if ( level.skipto_current_objective[ 0 ] != "post_water_room_dogfight" )
    {
        return;
    }
    
    root = getent( "dogfighting_scene", "targetname" );
    self oob::disableplayeroob( 1 );
    self.pvtol thread animation::play( "v_aqu_03_10_platform_1st_enterdogfight_player" + self.player_num, root );
    self thread aquifer_util::function_af376a0e( "v_aqu_03_10_platform_1st_enterdogfight_player" + self.player_num, self.player_num - 1, "v_aqu_03_10_platform_1st_enterdogfight_enemy" + self.player_num, "enter_dogfight_global_active" );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x8b2f8e97, Offset: 0x9180
// Size: 0x3e4
function function_5b113d76( str_objective, b_starting )
{
    level.var_4063f562 = "scripted";
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 0 );
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 0 );
    thread aquifer_util::function_c1bd6415( "defend_oob_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 0 );
    thread aquifer_util::function_287ca2ad( 0 );
    thread aquifer_util::function_77fde091( 0 );
    cp_mi_cairo_aquifer_sound::function_de37a122();
    
    if ( b_starting )
    {
        load::function_a2995f22();
        thread function_61034146( 1 );
    }
    else
    {
        foreach ( player in level.players )
        {
            player thread function_1b47ae1f( 0 );
        }
    }
    
    objectives_set( "cp_level_aquifer_dogfight2" );
    level flag::wait_till( "dogfighting" );
    wait 50;
    
    foreach ( player in level.activeplayers )
    {
        if ( isdefined( player.var_3dca6783 ) && player.var_3dca6783 > 0 )
        {
            break;
        }
        
        util::missionfailedwrapper_nodeath( &"CP_MI_CAIRO_AQUIFER_VTOL_DOGFIGHT_FAIL", &"CP_MI_CAIRO_AQUIFER_VTOL_DOGFIGHT_FAIL_HINT" );
        return;
    }
    
    level notify( #"hash_982117a3" );
    level flagsys::set( "dogfight_ending" );
    level flag::set( "enter_dogfight_global_active" );
    wait 10;
    level flag::clear( "dogfighting" );
    level flagsys::clear( "dogfight_ending" );
    
    foreach ( player in level.activeplayers )
    {
        player notify( #"hash_b4a5f622" );
    }
    
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x36207990, Offset: 0x9570
// Size: 0x1c4
function function_427463e0( str_objective, b_starting, b_direct, player )
{
    if ( !b_starting )
    {
        objectives_complete( "cp_level_aquifer_dogfight2" );
    }
    
    struct::delete_script_bundle( "scene", "cin_aqu_03_21_server_room_explosion" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_21_server_room_idle" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_01_platform_1st_secureplatform_vtol" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_01_platform_1st_secureplatform_ambient" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_01_platform_1st_secureplatform" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_01_platform_1st_secureplatform_exit" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_10_platform_1st_enterdogfight" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_21_server_room_doors_open" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_22_water_room_escape_start" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_22_water_room_escape_fire_loop" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_22_water_room_escape_end" );
    struct::delete_script_bundle( "scene", "cin_aqu_03_22_water_room_escape_end_loop" );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x6e4b9283, Offset: 0x9740
// Size: 0x2a4
function function_fb03103d( str_objective, b_starting )
{
    level.var_4063f562 = "piloted";
    
    if ( b_starting )
    {
        load::function_a2995f22();
    }
    
    aquifer_util::init_heightmap_intro_state();
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 1 );
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 1 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 1 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 1 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 1 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 0 );
    thread aquifer_util::function_287ca2ad( 0 );
    thread aquifer_util::function_77fde091( 0 );
    cp_mi_cairo_aquifer_sound::function_de37a122();
    thread function_61034146( 1 );
    function_db369178( "quadtank_zone_mid_" );
    notify_send = "target_down";
    thread common_defenses_init( "quadtank_zone_mid_", "cp_level_aquifer_destroy_defenses3", "cp_level_aquifer_destroyme", notify_send, undefined, "show_defenses_mid_objectives" );
    thread aquifer_util::function_96450f49( "hen_def_mid_", 0 );
    thread function_380b183b();
    level thread aquifer_sound::function_bdb99f05();
    spawn_manager::enable( "spawn_manager_mid_defenses" );
    spawn_manager::enable( "spawn_manager_mid_defenses_2" );
    spawner::add_spawn_function_ai_group( "mid_defense_rpgs", &function_c0f2d8b9 );
    thread function_91c91014();
    level flagsys::wait_till( "common_defense_objectives_complete" );
    level.var_1226dab0 = 0;
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xa3c4bb40, Offset: 0x99f0
// Size: 0x10
function function_c0f2d8b9()
{
    self.dontdropweapon = 1;
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x7b8a5fab, Offset: 0x9a08
// Size: 0x120
function function_db369178( base_name )
{
    var_dd21345d = 6 + 2 + 1;
    
    while ( level.activeplayers.size == 0 )
    {
        wait 0.2;
    }
    
    removing = math::clamp( ( 3 - level.activeplayers.size ) * 2, 0, 6 );
    
    while ( removing >= 0 )
    {
        removing--;
        sp_name = base_name + var_dd21345d - removing;
        spawner = getent( sp_name, "targetname" );
        
        if ( isdefined( spawner ) )
        {
            spawner delete();
        }
        
        util::wait_network_frame();
    }
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xb3c754fc, Offset: 0x9b30
// Size: 0x8c
function function_380b183b()
{
    level flag::set( "show_defenses_mid_objectives" );
    level flagsys::wait_till( "common_defense_objectives_complete" );
    level dialog::remote( "hend_that_s_all_of_em_0", 1 );
    level dialog::remote( "kane_good_work_we_ve_got_0", 0.25 );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x9e901a93, Offset: 0x9bc8
// Size: 0xda
function function_91c91014( veh )
{
    level waittill( #"vtol_landed", player );
    guys = spawner::get_ai_group_ai( "mid_defense_rpgs" );
    
    foreach ( guy in guys )
    {
        if ( isdefined( guy ) )
        {
            guy delete();
        }
    }
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x3d721bc9, Offset: 0x9cb0
// Size: 0x44
function function_46151925( str_objective, b_starting, b_direct, player )
{
    if ( !b_starting )
    {
        objectives_complete( "cp_level_aquifer_destroy_defenses3" );
    }
}

// Namespace aquifer_obj
// Params 2
// Checksum 0xb618bea8, Offset: 0x9d00
// Size: 0x6a4
function skipto_defenses_init2( str_objective, b_starting )
{
    level.var_4063f562 = "piloted";
    
    if ( b_starting )
    {
        load::function_a2995f22();
    }
    
    aquifer_util::init_heightmap_obj3_state();
    cp_mi_cairo_aquifer_sound::function_de37a122();
    thread function_61034146( 1 );
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 0 );
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 1 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 1 );
    thread aquifer_util::function_c1bd6415( "defend_oob_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 0 );
    thread aquifer_util::function_77fde091( 0 );
    thread aquifer_util::function_287ca2ad( 1 );
    level flag::set( "water_room_checkpoint" );
    scene::init( "cin_aqu_04_securityfeed_3rd_sh010" );
    
    if ( b_starting )
    {
        level thread aquifer_sound::function_bdb99f05();
    }
    
    thread cp_mi_cairo_aquifer_aitest::handler_egyptian_defend_scenario( "flag_egyptian_hacking_completed" );
    notify_send = "target_down";
    thread common_defenses_init( "quadtank_zone03_", "cp_level_aquifer_destroy_defenses2", "cp_level_aquifer_destroyme", notify_send, 1 );
    exploder::exploder( "amb_front_defend" );
    level flag::set( "disable_player_exit_vtol" );
    egyptians_hacking();
    level flag::clear( "disable_player_exit_vtol" );
    level waittill( #"hash_476bcf62" );
    
    foreach ( player in level.activeplayers )
    {
        player thread function_474771df();
    }
    
    wait 1.5;
    thread function_efd791ac();
    wait 2;
    exploder::exploder_stop( "amb_front_defend" );
    door_right = getent( "hangar_blast_door_right", "targetname" );
    door_right hide();
    door_left = getent( "hangar_blast_door_left", "targetname" );
    door_left hide();
    
    foreach ( player in level.activeplayers )
    {
        player enableinvulnerability();
        player util::freeze_player_controls( 1 );
        player.pvtol takeplayercontrol();
    }
    
    if ( isdefined( level.bzm_aquiferdialogue4callback ) )
    {
        level thread [[ level.bzm_aquiferdialogue4callback ]]();
    }
    
    thread aquifer_util::function_ae0b01fe( 1 );
    skipto::teleport_players( "side_combat_teleport" );
    level flag::set( "flag_force_off_dust" );
    exploder::exploder( "lighting_hangar_a" );
    s = getent( "breach_scene_origin", "targetname" );
    s scene::play( "cin_aqu_04_securityfeed_3rd_sh010" );
    s scene::stop( 1 );
    door_right show();
    door_left show();
    exploder::stop_exploder( "lighting_hangar_a" );
    level notify( #"hash_dc2436e4" );
    util::clear_streamer_hint();
    level flag::clear( "flag_force_off_dust" );
    thread aquifer_util::function_191fff49( "piloted" );
    
    foreach ( player in level.activeplayers )
    {
        player util::freeze_player_controls( 0 );
    }
    
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xfb1e479c, Offset: 0xa3b0
// Size: 0xf4
function function_474771df()
{
    self endon( #"disconnect" );
    menu = self openluimenu( "SecurityCameraOverlay" );
    wait 2;
    self clientfield::set_to_player( "hijack_static_effect", 1 );
    wait 1.5;
    self clientfield::set_to_player( "hijack_static_effect", 0 );
    level waittill( #"hash_dc2436e4" );
    self closeluimenu( menu );
    self clientfield::set_to_player( "hijack_static_effect", 1 );
    wait 1;
    self clientfield::set_to_player( "hijack_static_effect", 0 );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x81a62186, Offset: 0xa4b0
// Size: 0x124
function function_efd791ac()
{
    level dialog::remote( "kane_we_re_too_late_he_0", 2.4 );
    level thread aquifer_sound::function_55376eeb();
    level dialog::player_say( "plyr_wait_beat_when_it_0" );
    level dialog::player_say( "plyr_lock_it_down_khalil_0" );
    level dialog::player_say( "plyr_there_s_still_marett_0", 1 );
    level dialog::remote( "kane_well_those_securi_0" );
    level dialog::player_say( "plyr_you_got_a_suggestion_0", 1 );
    level dialog::remote( "kane_maretti_s_still_in_t_0", 1 );
    level dialog::player_say( "plyr_copy_we_re_joining_0", 1 );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xd9a80a5d, Offset: 0xa5e0
// Size: 0x12c
function egyptians_hacking()
{
    level.hack_upload_range = 4096;
    sq = level.hack_upload_range * level.hack_upload_range;
    level.hack_upload_range = 8192;
    thread function_e5d81c9();
    notify_send = "trigger_hacked";
    wait 3;
    level.fast_hack = 50000;
    
    /#
    #/
    
    my_trig = getent( "hack_zone03_1", "targetname" );
    objectives_set( "cp_level_aquifer_security", my_trig.origin );
    level flag::wait_till( "egyptian_defend_reached" );
    wait 50;
    objectives_complete( "cp_level_aquifer_security" );
    level flag::set( "flag_egyptian_hacking_completed" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x775c3f5f, Offset: 0xa718
// Size: 0x172
function function_e5d81c9()
{
    level dialog::remote( "kane_hendricks_what_s_yo_0" );
    level dialog::remote( "hend_khalil_s_men_are_bei_0" );
    level dialog::remote( "plyr_we_re_not_gonna_let_0" );
    level dialog::remote( "kane_khalil_we_ll_cover_0" );
    level dialog::remote( "khal_we_re_being_overwhel_0", 5 );
    level dialog::remote( "khal_we_re_pinned_down_g_0", 16 );
    level flag::wait_till( "hack_zone03_1_finished" );
    cp_mi_cairo_aquifer_sound::function_de37a122( 0 );
    level dialog::remote( "khal_kane_we_have_the_c_0", 1 );
    level dialog::remote( "khal_we_re_in_i_m_patch_0", 0.25 );
    level dialog::remote( "kane_send_me_the_security_0" );
    level notify( #"hash_476bcf62" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x3550d5fb, Offset: 0xa898
// Size: 0x17a
function function_c5734389()
{
    foreach ( player in level.activeplayers )
    {
        if ( isdefined( player.pvtol ) && player islinkedto( player.pvtol ) )
        {
            player.pvtol takeplayercontrol();
            wait 0.05;
            var_da1bd38e = player.var_dda84f1a[ 3 ].origin + ( 0, 0, 900 );
            player.pvtol.origin = var_da1bd38e;
            player.pvtol.angles = player.var_dda84f1a[ 3 ].angles;
            player.pvtol returnplayercontrol();
        }
    }
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x74188e1a, Offset: 0xaa20
// Size: 0x4c
function skipto_defenses_done2( str_objective, b_starting, b_direct, player )
{
    level struct::delete_script_bundle( "scene", "cin_aqu_04_securityfeed_3rd_sh010" );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0xf625970e, Offset: 0xaa78
// Size: 0x41c
function skipto_hack_init3( str_objective, b_starting )
{
    level.var_4063f562 = "piloted";
    var_f13bfa4a = [];
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 1 );
    aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    aquifer_util::player_kill_triggers( "obj2_kill_trig", 1 );
    aquifer_util::player_kill_triggers( "obj3_kill_trig", 1 );
    aquifer_util::function_c1bd6415( "defend_oob_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 1 );
    aquifer_util::function_287ca2ad( 1 );
    thread aquifer_util::function_77fde091( 0 );
    thread aquifer_util::function_191fff49( "landing_mode" );
    scene::add_scene_func( "cin_aqu_04_20_breach_1st_rappel_main_enemies", &function_418127ed, "init" );
    scene::init( "cin_aqu_04_20_breach_1st_rappel_main" );
    scene::init( "cin_aqu_04_20_breach_1st_rappel_main_enemies" );
    
    if ( b_starting )
    {
        load::function_a2995f22();
    }
    
    level.fast_hack = 1;
    cp_mi_cairo_aquifer_sound::function_de37a122();
    level flag::set( "flag_egyptian_hacking_completed" );
    level flag::set( "hack_terminals3" );
    createthreatbiasgroup( "lcombat_air_attack" );
    thread function_aa49745a();
    thread function_408c7d50();
    aquifer_util::function_c897523d( "respawn_lcombat" );
    aquifer_util::init_heightmap_breach_state();
    thread aquifer_util::function_9cf1804b();
    thread aquifer_util::lcombat_crash_event();
    thread aquifer_util::function_367616d8();
    thread function_61034146( 1 );
    level notify( #"combat_music" );
    level thread aquifer_sound::function_b1ee6c2d();
    
    if ( b_starting )
    {
        while ( !isdefined( level.activeplayers[ 0 ].pvtol ) )
        {
            wait 0.05;
        }
    }
    
    aquifer_util::function_fc653485();
    aquifer_util::function_1215f9e4( 3 );
    wait 0.05;
    function_dcbdf6db( "exterior_support_land", 3 );
    level flag::set( "lcombat_respawn_ground" );
    objectives_complete( "cp_level_aquifer_land" );
    level.var_4712f308 = undefined;
    level notify( #"hash_6da3f34c" );
    flag::set( "player_really_landed" );
    level thread aquifer_sound::function_36cd6ee8();
    level flag::wait_till( "start_pre_breach" );
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xe3135de1, Offset: 0xaea0
// Size: 0xec
function function_aa49745a()
{
    s = struct::get( "breadcrumb_side_2" );
    objectives_set( "cp_level_aquifer_capture" );
    level waittill( #"hash_6da3f34c" );
    objectives_set( "cp_level_aquifer_capture_defend", s.origin );
    level flag::wait_till_timeout( 40, "side_combat_advance" );
    objectives_complete( "cp_level_aquifer_capture_defend", s.origin );
    objectives_set( "cp_level_aquifer_capture_hangar" );
    thread objectives::breadcrumb( "breadcrumb_side_combat" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x66e33583, Offset: 0xaf98
// Size: 0x82
function function_3cff89e8()
{
    wait_time = 1;
    wait wait_time;
    level dialog::player_say( "plyr_you_got_a_suggestion_0" );
    wait wait_time;
    level dialog::remote( "kane_maretti_s_still_in_t_0" );
    wait wait_time;
    level dialog::player_say( "plyr_copy_we_re_joining_0" );
    wait wait_time;
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x16d05f29, Offset: 0xb028
// Size: 0x434
function function_408c7d50()
{
    level.var_6657ee03 = [];
    spawners = getentarray( "egyptian_redshirt_hack_defends", "targetname" );
    
    foreach ( s in spawners )
    {
        guy = s spawner::spawn( 1 );
        guy util::magic_bullet_shield();
        level.var_6657ee03[ level.var_6657ee03.size ] = guy;
    }
    
    level.var_6657ee03[ level.var_6657ee03.size ] = function_25604491( "khalil_hack_defends" );
    level.hendricks = spawnhendricksifneeded( "hendricks_hack_defends" );
    
    if ( isdefined( level.hendricks ) )
    {
        level.hendricks util::magic_bullet_shield();
    }
    
    spawn_manager::enable( "spawn_manager_lcombat_trans_wave1" );
    thread aquifer_util::function_3ba6e66c();
    thread aquifer_util::function_dfc31fd4();
    level flag::wait_till( "player_really_landed" );
    spawn_manager::kill( "spawn_manager_lcombat_trans_wave1" );
    spawn_manager::enable( "spawn_manager_hack_zone02_4" );
    trigger::use( "lcombat_start_backwave", "targetname" );
    level flag::wait_till_timeout( 50, "side_combat_advance" );
    spawn_manager::kill( "spawn_manager_hack_zone02_4" );
    trigger::use( "lcombat_ally_move_1", "targetname" );
    thread aquifer_util::function_7d76ae16( "volume_hack_zone02_4", "volume_hack_zone02_5" );
    spawn_manager::enable( "spawn_manager_hack_zone02_5" );
    level flag::wait_till_timeout( 50, "side_combat_advance2" );
    trigger::use( "lcombat_ally_move_2", "targetname" );
    thread aquifer_util::function_7d76ae16( "volume_hack_zone02_5", "retreat_right_side" );
    spawn_manager::kill( "spawn_manager_hack_zone02_5" );
    trigger::use( "lcombat_wasp_spawntrig", "targetname" );
    level flag::wait_till_timeout( 50, "side_combat_stop" );
    thread aquifer_util::function_7d76ae16( "retreat_right_side", "volume_hack_zone02_6" );
    trigger::use( "lcombat_ally_move_4", "targetname" );
    spawn_manager::enable( "spawn_manager_hack_zone02_6" );
    trigger::use( "egyptian_redshirt_hack_defends_2ndwave_trig", "targetname" );
    trigger::wait_or_timeout( 35, "lcombat_cleanup_start_trig" );
    thread aquifer_util::function_5a160fe7();
    spawn_manager::kill( "spawn_manager_hack_zone02_6" );
    thread aquifer_util::function_f8243869();
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x5a0e58cb, Offset: 0xb468
// Size: 0x44
function skipto_hack_done3( str_objective, b_starting, b_direct, player )
{
    struct::delete_script_bundle( "scene", "cin_aqu_04_07_lowerplatform_1st_flight_main" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xbc7ebd9d, Offset: 0xb4b8
// Size: 0x24
function function_45fe5e11()
{
    level.breach_enemies = spawn_breach_enemies( "breach_enemies" );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x58bc10d9, Offset: 0xb4e8
// Size: 0x934
function skipto_breach_init( str_objective, b_starting )
{
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 1 );
    aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    aquifer_util::player_kill_triggers( "obj2_kill_trig", 1 );
    aquifer_util::player_kill_triggers( "obj3_kill_trig", 1 );
    aquifer_util::function_c1bd6415( "oob_upper_trig", 0 );
    aquifer_util::function_c1bd6415( "oob_low_trig", 1 );
    aquifer_util::function_287ca2ad( 1 );
    
    if ( b_starting )
    {
        scene::add_scene_func( "cin_aqu_04_20_breach_1st_rappel_main_enemies", &function_418127ed, "init" );
        scene::init( "cin_aqu_04_20_breach_1st_rappel_main" );
        scene::init( "cin_aqu_04_20_breach_1st_rappel_main_enemies" );
        cp_mi_cairo_aquifer_sound::function_de37a122( 0 );
        level flag::set( "side_combat_stop" );
        objectives_set( "cp_level_aquifer_capture" );
        load::function_a2995f22();
    }
    
    level notify( #"combat_music" );
    aquifer_util::function_c897523d( "none" );
    spawnhendricksifneeded( "hendricks_pre_breach" );
    level.hendricks util::magic_bullet_shield();
    struct = getent( "breach_scene_origin", "targetname" );
    level flag::wait_till( "start_pre_breach" );
    level flag::set( "breach_hangar_active" );
    thread pre_breach_scene();
    thread objectives::breadcrumb( "pre_breach_breadcrumb" );
    trigger::use( "hendricks_final_run_lcombat", "targetname" );
    level flag::wait_till_timeout( 60, "on_hangar_exterior" );
    level flag::set( "on_hangar_exterior" );
    cp_mi_cairo_aquifer_sound::function_de37a122( 0 );
    exploder::stop_exploder( "lighting_hangar_hallways_perf_lights" );
    exploder::exploder( "lighting_hangar_a" );
    level flag::set( "disable_player_enter_vtol" );
    level.hendricks = spawnhendricksifneeded( "hendricks_hangar" );
    thread handle_breach_slomo();
    level flag::clear( "start_pre_breach" );
    level notify( #"hash_409a1fc1" );
    wait 0.1;
    thread aquifer_util::function_8c7dc4c3();
    thread function_b2a5e2c2();
    level flag::wait_till( "just_breach_it" );
    level thread aquifer_sound::function_5ac17e2c();
    num = 1;
    
    foreach ( player in level.activeplayers )
    {
        var_44578351 = spawn( "script_model", struct.origin );
        var_44578351 setmodel( "p7_ven_carabiner" );
        var_44578351.targetname = "carabiner_p" + ( isdefined( num ) ? "" + num : "" );
        num++;
    }
    
    vtol = getent( "hangar_vtol_01", "targetname" );
    
    if ( isdefined( vtol ) )
    {
        vtol setscale( 0.8 );
    }
    
    thread aquifer_util::toggle_interior_doors( 1 );
    thread function_70e17249();
    level thread cp_mi_cairo_aquifer_sound::function_4e875e0d();
    level thread cp_mi_cairo_aquifer_sound::function_16a46955();
    level thread aquifer_sound::function_4de42644();
    thread function_2fcfc76( level.hendricks, "stop_chase_bullets" );
    aquifer_util::function_ae0b01fe( 1 );
    array::thread_all( level.activeplayers, &oob::disableplayeroob, 1 );
    
    if ( isdefined( level.bzm_aquiferdialogue4_1callback ) )
    {
        level thread [[ level.bzm_aquiferdialogue4_1callback ]]();
    }
    
    var_88ade69e = getent( "pre_breach_breadcrumb", "targetname" ).who;
    
    foreach ( player in level.activeplayers )
    {
        if ( isdefined( var_88ade69e ) && player == var_88ade69e )
        {
            continue;
        }
        
        if ( level.activeplayers.size == 1 )
        {
            var_b0633588 = getent( "pre_breach_zone", "targetname" );
            
            if ( player istouching( var_b0633588 ) )
            {
                player.force_short_scene_transition_effect = 1;
            }
        }
        
        player.play_scene_transition_effect = 1;
    }
    
    scene::add_scene_func( "cin_aqu_04_20_breach_1st_rappel_main_enemies", &function_f9027bac, "play" );
    scene::add_scene_func( "cin_aqu_04_20_breach_1st_rappel_main", &function_3a12692e, "play" );
    struct thread scene::play( "cin_aqu_04_20_breach_1st_rappel_main_enemies" );
    struct scene::play( "cin_aqu_04_20_breach_1st_rappel_main", level.hendricks );
    array::thread_all( level.activeplayers, &oob::disableplayeroob, 0 );
    level notify( #"breach_done" );
    
    if ( isdefined( level.hendricks ) )
    {
        util::magic_bullet_shield( level.hendricks );
        level.hendricks colors::set_force_color( "r" );
    }
    
    skipto::objective_completed( str_objective );
    objectives_complete( "cp_level_aquifer_capture_hangar" );
    array::run_all( level.players, &disableinvulnerability );
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x213fb249, Offset: 0xbe28
// Size: 0x11c
function skipto_breach_done( str_objective, b_starting, b_direct, player )
{
    vtol = getent( "hangar_vtol_01", "targetname" );
    
    if ( isdefined( vtol ) )
    {
        vtol setscale( 0.8 );
    }
    
    if ( b_starting )
    {
        objectives_set( "cp_level_aquifer_capture" );
    }
    
    thread function_5d32874c( 1 );
    level struct::delete_script_bundle( "scene", "cin_aqu_04_20_breach_1st_rappel_main" );
    level struct::delete_script_bundle( "scene", "cin_aqu_04_20_breach_1st_rappel_main_enemies" );
    level flag::set( "inside_aquifer" );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x5a36f900, Offset: 0xbf50
// Size: 0xb6
function function_f9027bac( a_ents )
{
    level flag::set( "play_breach" );
    
    foreach ( e_enemy in a_ents )
    {
        e_enemy.var_fb7ce72a = &function_c5926a75;
    }
}

// Namespace aquifer_obj
// Params 1
// Checksum 0xc4826b47, Offset: 0xc010
// Size: 0x44
function function_3a12692e( a_ents )
{
    level waittill( #"hash_48b02987" );
    array::run_all( level.players, &enableinvulnerability );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0xc76065c4, Offset: 0xc060
// Size: 0x16a
function function_418127ed( a_ents )
{
    foreach ( ai_enemy in a_ents )
    {
        util::magic_bullet_shield( ai_enemy );
        ai_enemy clientfield::set( "toggle_enemy_highlight", 1 );
    }
    
    level flag::wait_till( "play_breach" );
    
    foreach ( ai_enemy in a_ents )
    {
        util::stop_magic_bullet_shield( ai_enemy );
        ai_enemy clientfield::set( "toggle_enemy_highlight", 0 );
    }
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x708045b1, Offset: 0xc1d8
// Size: 0x18, Type: bool
function function_c5926a75( player, var_d7b19111 )
{
    return true;
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x4852ef60, Offset: 0xc1f8
// Size: 0xc4
function function_70e17249()
{
    wait 3;
    level notify( #"stop_chase_bullets" );
    wait 2.4;
    a = getent( "breach_exploder", "script_parameters" );
    
    if ( isdefined( a ) )
    {
        b = getent( "breach_exploder_victim", "targetname" );
        b = b spawner::spawn( 1 );
        wait 0.5;
        a kill();
    }
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x3aa4ccc3, Offset: 0xc2c8
// Size: 0x94
function function_bd6a294()
{
    level flag::wait_till( "init_run" );
    
    if ( level flag::get( "start_pre_breach" ) )
    {
        level endon( #"hash_409a1fc1" );
        wait 6;
        level dialog::remote( "kane_get_into_position_w_0" );
        wait 8;
        level dialog::remote( "hend_push_forward_maret_0" );
    }
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x1029692d, Offset: 0xc368
// Size: 0x4c
function function_b2a5e2c2()
{
    level endon( #"just_breach_it" );
    level flag::wait_till( "breach_vo_complete" );
    level flag::set( "just_breach_it" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x1e0daf65, Offset: 0xc3c0
// Size: 0xcc
function handle_breach_slomo()
{
    level waittill( #"slomo_on" );
    setslowmotion( 1, 0.4, 0.3 );
    level waittill( #"slomo_off" );
    setslowmotion( 0.4, 1, 0.3 );
    level waittill( #"slomo_2" );
    setslowmotion( 1, 0.3, 0.3 );
    wait 2.6;
    setslowmotion( 0.5, 1, 0.2 );
    wait 0.3;
}

// Namespace aquifer_obj
// Params 1
// Checksum 0xc4206109, Offset: 0xc498
// Size: 0x124
function spawn_breach_enemies( name )
{
    enemies = [];
    spawners = getentarray( name, "script_noteworthy" );
    
    foreach ( spawner in spawners )
    {
        spawner spawner::add_spawn_function( &function_abc982c8 );
        guy = spawner spawner::spawn( 1, spawner.targetname );
        enemies[ enemies.size ] = guy;
    }
    
    return enemies;
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x64f903fc, Offset: 0xc5c8
// Size: 0xc0
function function_abc982c8()
{
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self util::magic_bullet_shield();
    level flag::wait_till( "just_breach_it" );
    self ai::set_ignoreall( 0 );
    self ai::set_ignoreme( 0 );
    self util::stop_magic_bullet_shield();
    self waittill( #"death" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x5f577c08, Offset: 0xc690
// Size: 0x172
function show_enemies_underfloor()
{
    trig = getent( "pre_breach_zone", "targetname" );
    
    while ( level flag::get( "start_pre_breach" ) )
    {
        trig waittill( #"trigger", who );
        
        if ( !( isdefined( who.looking_through_floor ) && who.looking_through_floor ) )
        {
            if ( isplayer( who ) )
            {
                who.looking_through_floor = 1;
                who clientfield::set_to_player( "highlight_ai", 1 );
            }
        }
    }
    
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "highlight_ai", 0 );
    }
}

// Namespace aquifer_obj
// Params 0
// Checksum 0x6abc71fc, Offset: 0xc810
// Size: 0x74
function pre_breach_scene()
{
    level flag::wait_till( "start_pre_breach" );
    thread pre_breach_vo();
    level flag::set( "init_run" );
    level flag::wait_till( "on_hangar_exterior" );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xcf7f42b, Offset: 0xc890
// Size: 0xf4
function pre_breach_vo()
{
    level endon( #"hash_409a1fc1" );
    level dialog::remote( "kane_damn_it_nrc_forces_0" );
    level dialog::player_say( "plyr_kane_what_s_your_pl_0" );
    level dialog::remote( "kane_rappel_over_the_edge_0", 0.1 );
    level dialog::player_say( "plyr_there_s_still_a_rein_0", 0.1 );
    level dialog::remote( "kane_i_ll_take_care_it_0", 0.2 );
    level flag::set( "breach_vo_complete" );
    thread function_bd6a294();
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xc3b0700b, Offset: 0xc990
// Size: 0x44
function breach_vo()
{
    level.hendricks dialog::say( "hend_remember_we_need_hy_0" );
    level.hendricks dialog::say( "hend_ready_go_0" );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x71c5ddbb, Offset: 0xc9e0
// Size: 0x254
function skipto_post_breach_init( str_objective, b_starting )
{
    vtol = getent( "hangar_vtol_01", "targetname" );
    
    if ( isdefined( vtol ) )
    {
        vtol setscale( 0.8 );
    }
    
    objectives_set( "cp_level_aquifer_capture_pursue" );
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 0 );
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 1 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 1 );
    thread aquifer_util::function_287ca2ad( 1 );
    
    if ( b_starting )
    {
        cp_mi_cairo_aquifer_sound::function_de37a122( 0 );
        load::function_a2995f22();
    }
    
    level flag::wait_till( "inside_aquifer" );
    level notify( #"combat_music" );
    aquifer_util::function_8bf8a765();
    thread function_61034146( 0 );
    thread function_e2d8799f( 1 );
    thread function_5d32874c( 1 );
    level thread cp_mi_cairo_aquifer_interior::function_2fc2978c();
    thread cp_mi_cairo_aquifer_interior::post_breach_setup();
    level flag::wait_till( "inroom" );
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x713ddce3, Offset: 0xcc40
// Size: 0x44
function skipto_post_breach_done( str_objective, b_starting, b_direct, player )
{
    level flag::wait_till( "inroom" );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x626ffd4, Offset: 0xcc90
// Size: 0x484
function function_53d54ffb( str_objective, b_starting )
{
    level flag::set( "inside_aquifer" );
    level notify( #"combat_music" );
    level.hendricks = spawnhendricksifneeded( "hendricks_boss_intro" );
    level.hendricks util::magic_bullet_shield();
    level.hendricks battlechatter::function_d9f49fba( 0 );
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 0 );
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 1 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 1 );
    thread aquifer_util::function_287ca2ad( 1 );
    
    if ( b_starting )
    {
        cp_mi_cairo_aquifer_sound::function_de37a122( 0 );
        thread function_61034146( 0 );
        thread function_e2d8799f( 1 );
        thread function_5d32874c( 1 );
        objectives_set( "cp_level_aquifer_capture" );
        load::function_a2995f22();
        scene::init( "cin_aqu_07_not_yourself_3rd_shot010" );
    }
    
    level thread function_6a11f4cb();
    var_d3888511 = trigger::wait_till( "sniper_intro_igc" );
    thread function_e2d8799f( 0 );
    thread function_5d32874c( 0 );
    
    if ( isdefined( level.bzm_aquiferdialogue5callback ) )
    {
        level thread [[ level.bzm_aquiferdialogue5callback ]]();
    }
    
    level thread aquifer_sound::function_1a168f0c();
    scene::add_scene_func( "cin_aqu_07_not_yourself_3rd_shot010", &function_9480ffc2, "play" );
    scene::add_scene_func( "cin_aqu_07_not_yourself_3rd_shot130", &function_cd553ae9, "done" );
    scene::add_scene_func( "cin_aqu_07_not_yourself_3rd_shot010", &function_d90541d7, "skip_completed" );
    a_ents = [];
    
    if ( !isdefined( a_ents ) )
    {
        a_ents = [];
    }
    else if ( !isarray( a_ents ) )
    {
        a_ents = array( a_ents );
    }
    
    a_ents[ a_ents.size ] = var_d3888511.who;
    a_ents[ "hendricks" ] = level.hendricks;
    level thread scene::play( "cin_aqu_07_not_yourself_3rd_shot010", a_ents );
    level waittill( #"hash_9f84cee3" );
    ent = getent( "intro_exploder", "script_noteworthy" );
    
    if ( isdefined( ent ) )
    {
        ent kill();
    }
    
    level waittill( #"hash_cd553ae9" );
    level thread aquifer_sound::function_99caac9d();
    wait 0.2;
    savegame::checkpoint_save();
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x1d0278a7, Offset: 0xd120
// Size: 0x24
function function_7f27211( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x4e0c4dcd, Offset: 0xd150
// Size: 0x34
function function_cd553ae9( a_ents )
{
    level notify( #"hash_cd553ae9" );
    util::teleport_players_igc( "post_boss_intro" );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0xcdbe005e, Offset: 0xd190
// Size: 0x9a
function function_9480ffc2( a_ents )
{
    foreach ( player in level.players )
    {
        player thread aquifer_util::function_89eaa1b3( 1.5 );
    }
}

// Namespace aquifer_obj
// Params 1
// Checksum 0xdb0966b5, Offset: 0xd238
// Size: 0x9a
function function_d90541d7( a_ents )
{
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "hijack_static_effect", 0 );
    }
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xe8168a33, Offset: 0xd2e0
// Size: 0x4c
function function_6a11f4cb()
{
    var_ce043be7 = trigger::wait_till( "sniper_mosh" );
    var_ce043be7.who thread aquifer_util::function_89eaa1b3( 1 );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0xffee2c21, Offset: 0xd338
// Size: 0x25c
function skipto_boss_init( str_objective, b_starting )
{
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 0 );
    
    if ( b_starting )
    {
        cp_mi_cairo_aquifer_sound::function_de37a122( 0 );
        objectives_set( "cp_level_aquifer_capture" );
        load::function_a2995f22();
    }
    
    level.hendricks = spawnhendricksifneeded( "hendricks_boss" );
    level.hendricks ai::set_ignoreall( 0 );
    level flag::set( "inside_aquifer" );
    level flag::set( "inroom" );
    thread function_61034146( 0 );
    thread function_e2d8799f( 0 );
    thread function_5d32874c( 0 );
    exploder::stop_exploder( "lighting_hangar_a" );
    thread cp_mi_cairo_aquifer_boss::start_boss();
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 1 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 1 );
    thread aquifer_util::function_287ca2ad( 1 );
    aquifer_util::toggle_door( "debris_clip", 1 );
    level flag::wait_till( "hyperion_start_tree_scene" );
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 4
// Checksum 0xba245c30, Offset: 0xd5a0
// Size: 0x264
function skipto_boss_done( str_objective, b_starting, b_direct, player )
{
    if ( !b_starting )
    {
        objectives_complete( "cp_level_aquifer_capture_pursue" );
    }
    
    objectives_complete( "cp_level_aquifer_capture" );
    level struct::delete_script_bundle( "scene", "cin_aqu_07_not_yourself_3rd_shot010" );
    level struct::delete_script_bundle( "scene", "cin_aqu_07_not_yourself_3rd_shot020" );
    level struct::delete_script_bundle( "scene", "cin_aqu_07_not_yourself_3rd_shot030" );
    level struct::delete_script_bundle( "scene", "cin_aqu_07_not_yourself_3rd_shot040" );
    level struct::delete_script_bundle( "scene", "cin_aqu_07_not_yourself_3rd_shot050" );
    level struct::delete_script_bundle( "scene", "cin_aqu_07_not_yourself_3rd_shot060" );
    level struct::delete_script_bundle( "scene", "cin_aqu_07_not_yourself_3rd_shot070" );
    level struct::delete_script_bundle( "scene", "cin_aqu_07_not_yourself_3rd_shot080" );
    level struct::delete_script_bundle( "scene", "cin_aqu_07_not_yourself_3rd_shot090" );
    level struct::delete_script_bundle( "scene", "cin_aqu_07_not_yourself_3rd_shot100" );
    level struct::delete_script_bundle( "scene", "cin_aqu_07_not_yourself_3rd_shot110" );
    level struct::delete_script_bundle( "scene", "cin_aqu_07_not_yourself_3rd_shot120" );
    level struct::delete_script_bundle( "scene", "cin_aqu_07_not_yourself_3rd_shot130" );
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x7bcb5d6a, Offset: 0xd810
// Size: 0x35c
function skipto_hideout_init( str_objective, b_starting )
{
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 0 );
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 0 );
    thread aquifer_util::function_287ca2ad( 1 );
    spawnhendricksifneeded( "hendricks_hideout" );
    
    if ( b_starting )
    {
        scene::init( "cin_aqu_16_outro_3rd_sh010", level.hendricks );
        cp_mi_cairo_aquifer_sound::function_de37a122( 0 );
        thread cp_mi_cairo_aquifer_boss::function_510d0407();
        level flag::set( "inside_aquifer" );
    }
    
    level flag::set( "hyperion_start_tree_scene" );
    aquifer_util::toggle_interior_doors( 0 );
    level notify( #"combat_music" );
    thread function_61034146( 0 );
    thread function_e2d8799f( 1 );
    thread function_5d32874c( 1 );
    
    if ( b_starting )
    {
        level.hendricks util::magic_bullet_shield();
    }
    
    level.hendricks ai::set_behavior_attribute( "cqb", 0 );
    level.hendricks ai::set_behavior_attribute( "sprint", 1 );
    loc = struct::get( "hideout_obj_struct", "targetname" );
    trigger::use( "leave_hideout", "targetname" );
    clientfield::set( "toggle_pbg_banks", 1 );
    
    if ( b_starting )
    {
        aquifer_util::toggle_door( "hideout_door", 1 );
        aquifer_util::toggle_door( "hideout_doors_closed", 1 );
        load::function_a2995f22();
        cp_mi_cairo_aquifer_interior::handle_hideout( b_starting );
    }
    else
    {
        level flag::wait_till( "hyperion_start_tree_scene" );
        level waittill( #"hideout_scene_done" );
    }
    
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x1cf19b46, Offset: 0xdb78
// Size: 0x11e
function skipto_hideout_done( str_objective, b_starting, b_direct, player )
{
    level struct::delete_script_bundle( "scene", "cin_aqu_07_01_maretti_1st_dropit" );
    level struct::delete_script_bundle( "scene", "cin_aqu_05_20_boss_3rd_death_main" );
    level struct::delete_script_bundle( "scene", "cin_aqu_05_20_boss_3rd_death_sh010" );
    level struct::delete_script_bundle( "scene", "cin_aqu_05_20_boss_3rd_death_sh020" );
    level struct::delete_script_bundle( "scene", "cin_aqu_05_20_boss_3rd_death_debris" );
    level struct::delete_script_bundle( "scene", "cin_aqu_16_outro_3rd_sh010" );
    
    if ( b_starting )
    {
        return;
    }
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x28fc00c1, Offset: 0xdca0
// Size: 0x334
function function_95463da0( str_objective, b_starting )
{
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 0 );
    
    if ( b_starting )
    {
        cp_mi_cairo_aquifer_sound::function_de37a122( 0 );
        thread cp_mi_cairo_aquifer_boss::function_510d0407();
        level flag::set( "inside_aquifer" );
        load::function_a2995f22();
    }
    
    objectives_set( "cp_level_aquifer_exfil" );
    clientfield::set( "toggle_pbg_banks", 1 );
    level flag::set( "hyperion_start_tree_scene" );
    aquifer_util::toggle_interior_doors( 0 );
    
    if ( b_starting )
    {
        thread aquifer_util::toggle_door( "hideout_door", 0 );
        thread aquifer_util::toggle_door( "hideout_doors_closed", 0 );
    }
    
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 0 );
    thread aquifer_util::function_287ca2ad( 1 );
    level notify( #"combat_music" );
    thread function_61034146( 0 );
    thread function_e2d8799f( 1 );
    thread function_5d32874c( 1 );
    exploder::exploder( "lighting_hangar_b" );
    thread aquifer_util::function_44287aa3();
    spawnhendricksifneeded( "hendricks_hideout" );
    trigger::use( "leave_hideout", "targetname" );
    
    if ( b_starting )
    {
        level.hendricks util::magic_bullet_shield();
        level flag::wait_till( "in_hideout" );
        util::teleport_players_igc( "post_hideout_igc" );
    }
    
    thread objectives::breadcrumb( "start_runout_breadcrumbs" );
    thread cp_mi_cairo_aquifer_interior::function_ff024877();
    level flag::wait_till( "runout_done" );
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x1d7dddfa, Offset: 0xdfe0
// Size: 0x24
function function_fb8ad8d6( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x56aa7b4b, Offset: 0xe010
// Size: 0x594
function skipto_exfil_init( str_objective, b_starting )
{
    level flag::set( "hyperion_start_tree_scene" );
    level flag::set( "inside_aquifer" );
    aquifer_util::toggle_interior_doors( 0 );
    thread aquifer_util::toggle_door( "hideout_door", 0 );
    thread aquifer_util::toggle_door( "hideout_doors_closed", 0 );
    level thread aquifer_util::player_kill_triggers( "ground_script_kill", 0 );
    thread aquifer_util::player_kill_triggers( "obj1_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj2_kill_trig", 0 );
    thread aquifer_util::player_kill_triggers( "obj3_kill_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_upper_trig", 0 );
    thread aquifer_util::function_c1bd6415( "oob_low_trig", 0 );
    thread aquifer_util::function_287ca2ad( 1 );
    level notify( #"combat_music" );
    level.hendricks = spawnhendricksifneeded( "escape_hendricks" );
    
    if ( b_starting )
    {
        thread function_61034146( 0 );
        thread function_e2d8799f( 1 );
        thread function_5d32874c( 1 );
        exploder::exploder( "lighting_hangar_b" );
        clientfield::set( "toggle_pbg_banks", 1 );
        load::function_a2995f22();
    }
    
    level flag::wait_till_clear( "hold_for_debug_splash" );
    var_48bcb988 = trigger::wait_till( "start_exfil_igc" );
    level thread aquifer_sound::function_ae6b41cd();
    level clientfield::set( "gameplay_started", 0 );
    
    if ( isdefined( level.bzm_aquiferdialogue7_1callback ) )
    {
        level thread [[ level.bzm_aquiferdialogue7_1callback ]]();
    }
    
    util::delay( 15, undefined, &objectives_complete, "cp_level_aquifer_exfil", undefined, 0 );
    array::run_all( level.activeplayers, &enableinvulnerability );
    thread exfil_fadeout();
    struct = getent( "breach_scene_origin", "targetname" );
    level notify( #"hash_a384e425" );
    level.hendricks stopanimscripted();
    function_f67ca613( 0 );
    level.hendricks.n_script_anim_rate = undefined;
    aquifer_util::toggle_door( "crane_arm_off", 1 );
    ents = getentarray( "hangar_doors", "targetname" );
    
    foreach ( ent in ents )
    {
        ent ghost();
    }
    
    aquifer_util::toggle_door( "hangar_support", 1 );
    level thread audio::unlockfrontendmusic( "mus_aquifer_comm_tower_intro" );
    level thread cp_mi_cairo_aquifer_sound::function_850c7ab7();
    level.hendricks thread dialog::say( "hend_the_hangar_is_this_w_0", 0.5 );
    a_ents = [];
    
    if ( !isdefined( a_ents ) )
    {
        a_ents = [];
    }
    else if ( !isarray( a_ents ) )
    {
        a_ents = array( a_ents );
    }
    
    a_ents[ a_ents.size ] = var_48bcb988.who;
    a_ents[ "hendricks" ] = level.hendricks;
    struct scene::play( "cin_aqu_07_20_outro_1st_finale_main", a_ents );
    skipto::objective_completed( str_objective );
}

// Namespace aquifer_obj
// Params 0
// Checksum 0xe48b7b7b, Offset: 0xe5b0
// Size: 0x4c
function exfil_fadeout()
{
    level waittill( #"hash_944e29c7" );
    level clientfield::set( "sndIGCsnapshot", 4 );
    thread util::screen_fade_out( 2 );
}

// Namespace aquifer_obj
// Params 4
// Checksum 0x2e652afd, Offset: 0xe608
// Size: 0x8c
function skipto_exfil_done( str_objective, b_starting, b_direct, player )
{
    if ( b_starting )
    {
        return;
    }
    
    skipto::teleport_players( "breach_hangar_teleport", undefined );
    
    /#
        txt = [];
        txt[ txt.size ] = "<dev string:x45>";
        debug::debug_info_screen( txt, 6 );
    #/
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x2665e2bd, Offset: 0xe6a0
// Size: 0x94
function objectives_set( obj_id, list )
{
    objectives::set( obj_id, list );
    
    if ( !isdefined( level.var_d0cbcc7b ) )
    {
        level.var_d0cbcc7b = [];
    }
    
    if ( !isdefined( level.var_d0cbcc7b[ obj_id ] ) )
    {
        level.var_d0cbcc7b[ obj_id ] = 1;
        return;
    }
    
    level.var_d0cbcc7b[ obj_id ]++;
    objectives::show( obj_id );
}

// Namespace aquifer_obj
// Params 3
// Checksum 0xc39e2f74, Offset: 0xe740
// Size: 0xac
function objectives_complete( obj_id, list, should_hide )
{
    if ( !isdefined( should_hide ) )
    {
        should_hide = 1;
    }
    
    if ( should_hide && isdefined( level.var_d0cbcc7b ) && isdefined( level.var_d0cbcc7b[ obj_id ] ) && level.var_d0cbcc7b[ obj_id ] > 0 )
    {
        level.var_d0cbcc7b[ obj_id ]--;
        objectives::hide( obj_id );
    }
    
    objectives::complete( obj_id, list );
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x6c78bd46, Offset: 0xe7f8
// Size: 0x8a
function spawnhendricksifneeded( spawner_name )
{
    if ( !isdefined( level.hendricks ) || !isalive( level.hendricks ) )
    {
        s = getent( spawner_name, "targetname" );
        level.hendricks = s spawner::spawn( 1 );
    }
    
    return level.hendricks;
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x4a6bdce6, Offset: 0xe890
// Size: 0xa2
function function_25604491( spawner_name )
{
    if ( !isdefined( level.khalil ) || !isalive( level.khalil ) )
    {
        s = getent( spawner_name, "targetname" );
        level.khalil = s spawner::spawn( 1 );
        level.khalil util::magic_bullet_shield();
    }
    
    return level.khalil;
}

// Namespace aquifer_obj
// Params 1
// Checksum 0x171ecf83, Offset: 0xe940
// Size: 0xe2
function function_30343b22( spawner_name )
{
    if ( !isdefined( level.kayne ) || !isalive( level.kayne ) )
    {
        s = getent( spawner_name, "targetname" );
        level.kayne = s spawner::spawn( 1 );
        level.kayne util::magic_bullet_shield();
        level.kayne.script_accuracy = 0.4;
        
        if ( sessionmodeiscampaignzombiesgame() )
        {
            level.kayne.ignorevignettemodeforanimreach = 1;
        }
    }
    
    return level.kayne;
}

// Namespace aquifer_obj
// Params 2
// Checksum 0x264967a2, Offset: 0xea30
// Size: 0x120
function function_2fcfc76( who, end_notify )
{
    level endon( end_notify );
    weapon = getweapon( "ar_standard" );
    wait 0.05;
    origin_offset = -500 * anglestoforward( who.angles ) + ( 0, 0, 60 );
    
    while ( true )
    {
        target_pos = who.origin + ( randomintrange( -50, 50 ), randomintrange( -50, 50 ), 0 );
        magicbullet( weapon, who.origin + origin_offset, target_pos );
        wait 0.05;
    }
}

