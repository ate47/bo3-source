#using scripts/codescripts/struct;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_collectibles;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_biodomes2_fx;
#using scripts/cp/cp_mi_sing_biodomes2_patch;
#using scripts/cp/cp_mi_sing_biodomes2_sound;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes_supertrees;
#using scripts/cp/cp_mi_sing_biodomes_swamp;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/teamgather_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace cp_mi_sing_biodomes2;

// Namespace cp_mi_sing_biodomes2
// Params 0
// Checksum 0xae859658, Offset: 0xc88
// Size: 0x34
function setup_rex_starts()
{
    util::add_gametype( "coop" );
    util::add_gametype( "cpzm" );
}

// Namespace cp_mi_sing_biodomes2
// Params 0
// Checksum 0xba83fd96, Offset: 0xcc8
// Size: 0x1d4
function main()
{
    if ( sessionmodeiscampaignzombiesgame() && -1 )
    {
        setclearanceceiling( 34 );
    }
    else
    {
        setclearanceceiling( 30 );
    }
    
    savegame::set_mission_name( "biodomes" );
    biodomes_accolades::function_4d39a2af();
    precache();
    clientfields_init();
    flag_init();
    level_init();
    cp_mi_sing_biodomes2_fx::main();
    cp_mi_sing_biodomes2_sound::main();
    cp_mi_sing_biodomes_supertrees::main();
    cp_mi_sing_biodomes_swamp::main();
    setup_skiptos();
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    spawner::add_global_spawn_function( "axis", &on_actor_spawned );
    load::main();
    cp_mi_sing_biodomes2_patch::function_7403e82b();
    createthreatbiasgroup( "heroes" );
    objectives::complete( "cp_level_biodomes_mainobj_capture_data_drives" );
    objectives::complete( "cp_level_biodomes_mainobj_upload_data" );
}

// Namespace cp_mi_sing_biodomes2
// Params 0
// Checksum 0x8ea86820, Offset: 0xea8
// Size: 0xaa
function precache()
{
    level._effect[ "explosion_zipline_up" ] = "explosions/fx_exp_elvsft_biodome";
    level._effect[ "boat_sparks" ] = "electric/fx_elec_sparks_boat_scrape_biodomes";
    level._effect[ "depth_charge" ] = "explosions/fx_exp_underwater_depth_charge";
    level._effect[ "boat_trail" ] = "vehicle/fx_spray_fan_boat";
    level._effect[ "boat_land_splash" ] = "vehicle/fx_splash_front_fan_boat";
    level._effect[ "boat_grass" ] = "vehicle/fx_grass_front_fan_boat";
}

// Namespace cp_mi_sing_biodomes2
// Params 0
// Checksum 0x7c25ea29, Offset: 0xf60
// Size: 0x454
function clientfields_init()
{
    clientfield::register( "toplayer", "dive_wind_rumble_loop", 1, 1, "int" );
    clientfield::register( "toplayer", "set_underwater_fx", 1, 1, "int" );
    clientfield::register( "toplayer", "sound_evt_boat_rattle", 1, 1, "counter" );
    clientfield::register( "toplayer", "zipline_speed_blur", 1, 1, "int" );
    clientfield::register( "toplayer", "zipline_rumble_loop", 1, 1, "int" );
    clientfield::register( "toplayer", "supertree_jump_debris_play", 1, 1, "int" );
    clientfield::register( "world", "boat_explosion_play", 1, 1, "int" );
    clientfield::register( "world", "elevator_top_debris_play", 1, 1, "int" );
    clientfield::register( "world", "elevator_bottom_debris_play", 1, 1, "int" );
    clientfield::register( "world", "tall_grass_init", 1, 1, "int" );
    clientfield::register( "world", "tall_grass_play", 1, 1, "int" );
    clientfield::register( "world", "supertree_fall_init", 1, 1, "counter" );
    clientfield::register( "world", "supertree_fall_play", 1, 1, "counter" );
    clientfield::register( "world", "ferriswheel_fall_play", 1, 1, "int" );
    clientfield::register( "allplayers", "zipline_sound_loop", 1, 1, "int" );
    clientfield::register( "vehicle", "boat_disable_sfx", 1, 1, "int" );
    clientfield::register( "vehicle", "sound_evt_boat_scrape_impact", 1, 1, "counter" );
    clientfield::register( "vehicle", "sound_veh_airboat_jump", 1, 1, "counter" );
    clientfield::register( "vehicle", "sound_veh_airboat_jump_air", 1, 1, "counter" );
    clientfield::register( "vehicle", "sound_veh_airboat_land", 1, 1, "counter" );
    clientfield::register( "vehicle", "sound_veh_airboat_ramp_hit", 1, 1, "counter" );
    clientfield::register( "vehicle", "sound_veh_airboat_start", 1, 1, "counter" );
    clientfield::register( "scriptmover", "clone_control", 1, 1, "int" );
}

// Namespace cp_mi_sing_biodomes2
// Params 0
// Checksum 0x8231a28c, Offset: 0x13c0
// Size: 0x324
function flag_init()
{
    level flag::init( "start_slide" );
    level flag::init( "supertrees_intro_done" );
    level flag::init( "supertrees_intro_vo_complete" );
    level flag::init( "supertrees_hunter_arrival" );
    level flag::init( "hunter_missiles_go" );
    level flag::init( "hendricks_dive" );
    level flag::init( "player_dive_done" );
    level flag::init( "hendricks_boat_waiting" );
    level flag::init( "hendricks_onboard" );
    level flag::init( "boats_init" );
    level flag::init( "all_players_on_boats" );
    level flag::init( "boats_ready_to_depart" );
    level flag::init( "boat_rail_begin" );
    level flag::init( "boats_go" );
    level flag::init( "swamp_tanker_exploded" );
    level flag::init( "supertrees_tree1_started" );
    level flag::init( "hendricks_played_supertree_takedown" );
    level flag::init( "hendricks_reached_finaltree" );
    level flag::init( "player_reached_final_zipline" );
    level flag::init( "any_player_reached_bottom_finaltree" );
    level flag::init( "player_reached_bottom_finaltree" );
    level flag::init( "start_hendricks_dive" );
    level flag::init( "player_reached_top_finaltree" );
    level flag::init( "supertree_fall_played" );
    level flag::init( "dock_enemies_take_cover" );
}

// Namespace cp_mi_sing_biodomes2
// Params 0
// Checksum 0x676a5264, Offset: 0x16f0
// Size: 0xc2
function level_init()
{
    level.override_robot_damage = 1;
    a_hide_ents = getentarray( "start_hidden", "script_noteworthy" );
    
    foreach ( ent in a_hide_ents )
    {
        ent hide();
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 0
// Checksum 0xbf1e60b7, Offset: 0x17c0
// Size: 0x40
function on_actor_spawned()
{
    if ( isdefined( self.script_label ) )
    {
        self.str_current_tree = self.script_label;
    }
    else
    {
        self.str_current_tree = "tree1";
    }
    
    self.b_using_zipline = 0;
}

// Namespace cp_mi_sing_biodomes2
// Params 0
// Checksum 0x461e80f9, Offset: 0x1808
// Size: 0x84
function on_player_connect()
{
    self flag::init( "player_on_boat" );
    self.b_bled_out = 0;
    self thread monitor_player_bleed_out();
    self.b_using_zipline = 0;
    
    if ( level flag::get( "supertree_fall_played" ) )
    {
        exploder::exploder( "fx_expl_supertree_collapse" );
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 0
// Checksum 0x2ca6b4f6, Offset: 0x1898
// Size: 0x1dc
function on_player_spawned()
{
    self endon( #"death" );
    
    if ( level.skipto_point === "objective_descend" )
    {
        self thread player_spawn_descend();
    }
    
    if ( level.skipto_point === "objective_descend" || level.skipto_point === "objective_supertrees" )
    {
        self.str_current_tree = "tree1";
    }
    
    self thread cp_mi_sing_biodomes_swamp::player_onto_boat_tracking();
    
    if ( level.skipto_point == "objective_swamps" )
    {
        self thread cp_mi_sing_biodomes_swamp::function_39af75ef( "boats_go" );
    }
    
    if ( level.skipto_point == "objective_swamps" || level.skipto_point == "dev_swamp_rail" || level.skipto_point == "dev_swamp_rail_final_scene" )
    {
        if ( level.activeplayers.size > 2 && !level flag::get( "boats_go" ) )
        {
            cp_mi_sing_biodomes_swamp::function_c98db861( 0 );
        }
        else if ( level.activeplayers.size > 2 && level flag::get( "boats_go" ) )
        {
            cp_mi_sing_biodomes_swamp::function_e5108e73( 0 );
        }
        
        if ( level flag::get( "boats_ready_to_depart" ) )
        {
            self.var_32218fc7 = 1;
            self thread cp_mi_sing_biodomes_swamp::force_player_onboard();
        }
    }
    
    cp_mi_sing_biodomes_util::function_d28654c9();
}

// Namespace cp_mi_sing_biodomes2
// Params 0
// Checksum 0x58cc1ed4, Offset: 0x1a80
// Size: 0x22c
function player_spawn_descend()
{
    self endon( #"death" );
    level flag::wait_till( "start_slide" );
    s_start = struct::get( "descend_player" + self getentitynumber(), "targetname" );
    
    if ( !isdefined( s_start ) )
    {
        return;
    }
    
    e_playermover = util::spawn_model( "tag_origin", s_start.origin, s_start.angles );
    e_playermover thread scene::play( "cin_bio_12_05_descend_1st_planc_player_slideloop", self );
    
    while ( isdefined( s_start.target ) )
    {
        s_end = struct::get( s_start.target, "targetname" );
        n_dist = distance( s_start.origin, s_end.origin );
        n_time = n_dist / 16 * 17.6;
        e_playermover moveto( s_end.origin, n_time );
        wait n_time - 0.05;
        s_start = s_end;
    }
    
    v_velocity = e_playermover getvelocity();
    self setvelocity( v_velocity );
    e_playermover scene::stop( "cin_bio_12_05_descend_1st_planc_player_slideloop" );
    e_playermover delete();
}

// Namespace cp_mi_sing_biodomes2
// Params 0
// Checksum 0x7e0979ab, Offset: 0x1cb8
// Size: 0x28
function monitor_player_bleed_out()
{
    self endon( #"disconnect" );
    self waittill( #"bled_out" );
    self.b_bled_out = 1;
}

// Namespace cp_mi_sing_biodomes2
// Params 0
// Checksum 0xb8850ecb, Offset: 0x1ce8
// Size: 0x164
function setup_skiptos()
{
    skipto::function_d68e678e( "objective_descend", &cp_mi_sing_biodomes_supertrees::objective_descend_init, undefined, &cp_mi_sing_biodomes_supertrees::objective_descend_done );
    skipto::add( "objective_supertrees", &cp_mi_sing_biodomes_supertrees::objective_supertrees_init, undefined, &cp_mi_sing_biodomes_supertrees::objective_supertrees_done );
    skipto::function_d68e678e( "objective_dive", &cp_mi_sing_biodomes_supertrees::objective_dive_init, undefined, &cp_mi_sing_biodomes_supertrees::objective_dive_done );
    skipto::function_d68e678e( "objective_swamps", &cp_mi_sing_biodomes_swamp::objective_swamps_init, undefined, &cp_mi_sing_biodomes_swamp::objective_swamps_done );
    
    /#
        skipto::add_dev( "<dev string:x28>", &cp_mi_sing_biodomes_supertrees::function_86a08a81 );
        skipto::add_dev( "<dev string:x41>", &cp_mi_sing_biodomes_supertrees::function_6e6908bc );
        skipto::add_dev( "<dev string:x5b>", &cp_mi_sing_biodomes_swamp::dev_swamp_rail_init );
    #/
}

