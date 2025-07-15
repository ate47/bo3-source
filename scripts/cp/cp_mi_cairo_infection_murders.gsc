#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_village;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace blackstation_murders;

// Namespace blackstation_murders
// Params 4
// Checksum 0xcb950bd1, Offset: 0x868
// Size: 0x24
function cleanup( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace blackstation_murders
// Params 0
// Checksum 0xed352d8e, Offset: 0x898
// Size: 0x24
function main()
{
    init_clientfields();
    setup_scenes();
}

// Namespace blackstation_murders
// Params 0
// Checksum 0x69764644, Offset: 0x8c8
// Size: 0x44
function function_d7cb3668()
{
    level scene::init( "cin_inf_07_04_sarah_vign_03" );
    level scene::init( "cin_inf_08_blackstation_3rd_sh010" );
}

// Namespace blackstation_murders
// Params 2
// Checksum 0xf728beaa, Offset: 0x918
// Size: 0x184
function murders_main( str_objective, b_starting )
{
    objectives::complete( "cp_level_infection_cross_chasm" );
    
    if ( b_starting )
    {
        load::function_73adcefc();
        level thread scene::init( "cin_inf_07_04_sarah_vign_03" );
        level thread scene::init( "cin_inf_08_blackstation_3rd_sh010" );
        load::function_a2995f22();
    }
    
    level clientfield::set( "black_station_ceiling_fxanim", 1 );
    players_enter_black_station();
    level thread namespace_bed101ee::function_973b77f9();
    array::thread_all( level.players, &infection_util::player_enter_cinematic );
    black_station_murders_scene();
    level thread ceiling_panels_fly_away();
    wait 4;
    array::thread_all( level.players, &infection_util::player_leave_cinematic );
    players_fly_through_ceiling();
    level thread skipto::objective_completed( str_objective );
}

// Namespace blackstation_murders
// Params 0
// Checksum 0xf1430b36, Offset: 0xaa8
// Size: 0xf4
function init_clientfields()
{
    clientfield::register( "world", "black_station_ceiling_fxanim", 1, 2, "int" );
    clientfield::register( "world", "igc_blackscreen_fade_in", 1, 1, "counter" );
    clientfield::register( "world", "igc_blackscreen_fade_in_immediate", 1, 1, "counter" );
    clientfield::register( "world", "igc_blackscreen_fade_out_immediate", 1, 1, "counter" );
    clientfield::register( "toplayer", "japanese_graphic_content_hide", 1, 1, "int" );
}

// Namespace blackstation_murders
// Params 0
// Checksum 0x686a8dda, Offset: 0xba8
// Size: 0x364
function setup_scenes()
{
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh010", &scene_3rd_sh010_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh020", &scene_3rd_sh020_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh030", &scene_3rd_sh030_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh040", &scene_3rd_sh040_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh050", &scene_3rd_sh050_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh060", &scene_3rd_sh060_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh070", &scene_3rd_sh070_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh080", &scene_3rd_sh080_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh090", &scene_3rd_sh090_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh090", &scene_3rd_sh090_done, "done" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh100", &scene_3rd_sh100_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh100", &scene_3rd_sh100_done, "done" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh110", &scene_3rd_sh110_play, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh110", &function_b1fccc96, "play" );
    scene::add_scene_func( "cin_inf_08_blackstation_3rd_sh110", &function_86c218d2, "done" );
    scene::add_scene_func( "cin_inf_08_03_blackstation_vign_aftermath", &function_46acf97b, "init" );
    scene::add_scene_func( "cin_inf_08_03_blackstation_vign_aftermath", &scene_aftermath_start, "play" );
    scene::add_scene_func( "cin_inf_08_03_blackstation_vign_aftermath", &scene_aftermath_done, "done" );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x5b40a8a6, Offset: 0xf18
// Size: 0x104
function players_enter_black_station( str_objective )
{
    if ( isdefined( level.bzm_infectiondialogue9callback ) )
    {
        level thread [[ level.bzm_infectiondialogue9callback ]]();
    }
    
    util::delay( 0.5, undefined, &function_cd24b21 );
    level thread namespace_bed101ee::function_973b77f9();
    scene::add_scene_func( "cin_inf_07_04_sarah_vign_03", &function_e53568f3, "play" );
    level thread scene::play( "cin_inf_07_04_sarah_vign_03" );
    level waittill( #"hash_e4b0eeea" );
    util::screen_fade_out( 0, "black" );
    level thread util::screen_fade_in( 1, "black" );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xbb39fa84, Offset: 0x1028
// Size: 0x2c
function function_e53568f3( a_ents )
{
    level thread util::screen_fade_in( 1, "black" );
}

// Namespace blackstation_murders
// Params 0
// Checksum 0x126dbf3e, Offset: 0x1060
// Size: 0x64
function function_cd24b21()
{
    level thread util::clear_streamer_hint();
    var_7d116593 = struct::get( "tag_align_infection_blackstation", "targetname" );
    infection_util::function_7aca917c( var_7d116593.origin );
}

// Namespace blackstation_murders
// Params 0
// Checksum 0x7900e722, Offset: 0x10d0
// Size: 0x144
function black_station_murders_scene()
{
    if ( isdefined( level.bzm_infectiondialogue10callback ) )
    {
        level thread [[ level.bzm_infectiondialogue10callback ]]();
    }
    
    level thread namespace_bed101ee::function_c4d41b74();
    level thread japanese_graphic_content_hide();
    level thread scene::play( "cin_inf_08_blackstation_3rd_sh010" );
    level waittill( #"hash_90d6ffa3" );
    skipto::teleport_players( "black_station" );
    level thread scene::play( "cin_inf_08_03_blackstation_vign_aftermath" );
    array::thread_all( level.players, &clientfield::set_to_player, "japanese_graphic_content_hide", 0 );
    level thread scene::init( "cin_inf_10_01_foy_aie_reversemortar" );
    level thread scene::init( "cin_inf_10_02_foy_aie_reversewallexplosion_suppressor" );
    level waittill( #"hash_e6a81b1c" );
    level thread namespace_bed101ee::function_973b77f9();
}

// Namespace blackstation_murders
// Params 0
// Checksum 0xf67717cb, Offset: 0x1220
// Size: 0xa0
function japanese_graphic_content_hide()
{
    level endon( #"hash_90d6ffa3" );
    
    while ( true )
    {
        level waittill( #"hash_b95052ad" );
        array::thread_all( level.players, &clientfield::set_to_player, "japanese_graphic_content_hide", 1 );
        level waittill( #"hash_aefb6286" );
        array::thread_all( level.players, &clientfield::set_to_player, "japanese_graphic_content_hide", 0 );
    }
}

// Namespace blackstation_murders
// Params 0
// Checksum 0xf413c780, Offset: 0x12c8
// Size: 0x44
function ceiling_panels_fly_away()
{
    level clientfield::set( "black_station_ceiling_fxanim", 2 );
    wait 0.8;
    exploder::exploder( "lgt_bstation_probe_ceiling_change" );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x6874a92e, Offset: 0x1318
// Size: 0x2c
function function_8b29fc51( a_ents )
{
    level scene::add_player_linked_scene( "p7_fxanim_cp_infection_reverse_house_01_bundle" );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x792d89e2, Offset: 0x1350
// Size: 0x8c
function function_bc8265b7( a_ents )
{
    level thread util::clear_streamer_hint();
    level thread village::function_1bf08d19();
    var_7d116593 = struct::get( "s_foy_lighting_hint", "targetname" );
    level thread infection_util::function_7aca917c( var_7d116593.origin );
}

// Namespace blackstation_murders
// Params 0
// Checksum 0xe05216d7, Offset: 0x13e8
// Size: 0x84
function players_fly_through_ceiling()
{
    level scene::add_scene_func( "cin_inf_09_01_flippingworld_1st_risefal", &function_bc8265b7, "play" );
    level scene::add_scene_func( "cin_inf_09_01_flippingworld_1st_risefal", &function_8b29fc51, "done" );
    level scene::play( "cin_inf_09_01_flippingworld_1st_risefal" );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x86dc9fc5, Offset: 0x1478
// Size: 0x13a
function function_46acf97b( a_ents )
{
    level.var_9db198cc = a_ents;
    
    foreach ( ent in a_ents )
    {
        if ( isdefined( ent.targetname ) )
        {
            if ( ent.targetname != "sarah" && ent.targetname != "taylor" && ent.targetname != "diaz" && ent.targetname != "maretti" )
            {
                ent ghost();
            }
            
            continue;
        }
        
        ent ghost();
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xf3404643, Offset: 0x15c0
// Size: 0xa2
function function_b1fccc96( a_ents )
{
    if ( isdefined( level.var_9db198cc ) )
    {
        foreach ( ent in level.var_9db198cc )
        {
            ent show();
        }
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xe850ad8e, Offset: 0x1670
// Size: 0x10a
function scene_aftermath_start( a_ents )
{
    a_ents[ "sarah" ] ai::set_ignoreall( 1 );
    a_ents[ "taylor" ] ai::set_ignoreall( 1 );
    a_ents[ "maretti" ] ai::set_ignoreall( 1 );
    
    foreach ( ent in a_ents )
    {
        ent show();
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x8a0e7046, Offset: 0x1788
// Size: 0xba
function scene_aftermath_done( a_ents )
{
    level flag::wait_till( "black_station_completed" );
    
    foreach ( ent in a_ents )
    {
        if ( isdefined( ent ) )
        {
            ent delete();
        }
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x6fa165ba, Offset: 0x1850
// Size: 0x14c
function vo_aftermath( a_ents )
{
    level dialog::remote( "hall_the_said_they_needed_0", 0 );
    level dialog::remote( "hall_we_were_marked_for_t_0", 0 );
    level dialog::remote( "hall_but_by_the_time_w_0", 0 );
    level dialog::remote( "hall_we_knew_they_d_send_0", 1 );
    level dialog::player_say( "plyr_that_wasn_t_what_hap_0", 0 );
    level dialog::player_say( "plyr_we_saw_the_footage_f_0", 0 );
    level dialog::player_say( "plyr_you_denied_them_thei_0", 1 );
    level dialog::remote( "hall_oh_my_god_0", 0 );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x2dbcd549, Offset: 0x19a8
// Size: 0x9c
function scene_3rd_sh010_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot010" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot010" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x417fcb25, Offset: 0x1a50
// Size: 0x9c
function scene_3rd_sh020_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot020" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot020" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x75f2654a, Offset: 0x1af8
// Size: 0x9c
function scene_3rd_sh030_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot030" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot030" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x861ad500, Offset: 0x1ba0
// Size: 0x9c
function scene_3rd_sh040_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot040" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot040" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xc33a335d, Offset: 0x1c48
// Size: 0x9c
function scene_3rd_sh050_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot050" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot050" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xae9b74ba, Offset: 0x1cf0
// Size: 0x9c
function scene_3rd_sh060_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot060" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot060" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x27d47c8f, Offset: 0x1d98
// Size: 0x9c
function scene_3rd_sh070_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot070" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot070" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xc9d76c4e, Offset: 0x1e40
// Size: 0x9c
function scene_3rd_sh080_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot080" );
        level clientfield::increment( "igc_blackscreen_fade_in", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot080" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xdb40403d, Offset: 0x1ee8
// Size: 0x74
function scene_3rd_sh090_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot090" );
        level clientfield::increment( "igc_blackscreen_fade_in_immediate", 1 );
    }
    
    level scene::init( "cin_inf_08_03_blackstation_vign_aftermath" );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x9cc895a2, Offset: 0x1f68
// Size: 0x34
function scene_3rd_sh090_done( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder_stop( "inf_bs_shot090" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x392def38, Offset: 0x1fa8
// Size: 0x34
function scene_3rd_sh100_play( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot100" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0x5dfe785, Offset: 0x1fe8
// Size: 0x34
function scene_3rd_sh100_done( a_ents )
{
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder_stop( "inf_bs_shot100" );
    }
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xbaf48f41, Offset: 0x2028
// Size: 0xcc
function scene_3rd_sh110_play( a_ents )
{
    level util::set_streamer_hint( 2 );
    
    if ( !scene::is_skipping_in_progress() )
    {
        exploder::exploder( "inf_bs_shot110" );
        level clientfield::increment( "igc_blackscreen_fade_in_immediate", 1 );
        level waittill( #"start_blackscreen" );
        level clientfield::increment( "igc_blackscreen_fade_out_immediate", 1 );
        exploder::exploder_stop( "inf_bs_shot110" );
    }
    
    exploder::exploder( "lgt_bstation_probe_igc_to_gameplay" );
}

// Namespace blackstation_murders
// Params 1
// Checksum 0xd160ec68, Offset: 0x2100
// Size: 0x2c
function function_86c218d2( a_ents )
{
    level clientfield::increment( "igc_blackscreen_fade_in_immediate", 1 );
}

