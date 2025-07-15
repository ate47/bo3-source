#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/_vehicle_platform;
#using scripts/cp/cp_mi_cairo_lotus3_sound;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_globallogic_ui;
#using scripts/cp/lotus_accolades;
#using scripts/cp/lotus_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/player_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace lotus_boss_battle;

// Namespace lotus_boss_battle
// Params 2
// Checksum 0xe820367b, Offset: 0x12e0
// Size: 0x254
function prometheus_intro_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level.ai_hendricks = util::get_hero( "hendricks" );
        var_4b8428ba = getent( "p_intro_glass_window", "targetname" );
        var_4b8428ba delete();
        level scene::init( "cin_lot_11_tower2ascent_3rd_sh060_halfway" );
    }
    
    level function_fc9a646b( "hide" );
    level thread destructible_cover();
    level.var_1df069b5 = 0;
    level.var_2e49e915 = 0;
    function_428ff2f();
    function_750a4f4c();
    level scene::add_scene_func( "cin_lot_15_taylorintro_3rd_sh050", &function_1d2443e2, "done" );
    level scene::add_scene_func( "cin_lot_11_tower2ascent_3rd_sh120", &function_a7f02ddb, "done" );
    
    if ( b_starting )
    {
        load::function_a2995f22();
        
        if ( isdefined( level.bzm_lotusdialogue7_1callback ) )
        {
            level thread [[ level.bzm_lotusdialogue7_1callback ]]();
        }
        
        level scene::play( "cin_lot_11_tower2ascent_3rd_sh060_halfway" );
    }
    
    level waittill( #"hash_a7f02ddb" );
    
    if ( isdefined( level.bzm_lotusdialogue8callback ) )
    {
        level thread [[ level.bzm_lotusdialogue8callback ]]();
    }
    
    level waittill( #"hash_59f31b4d" );
    level thread function_c40186f4();
    level waittill( #"hash_41bb6835" );
    level util::teleport_players_igc( "boss_battle" );
    skipto::objective_completed( "prometheus_intro" );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x749f2fe2, Offset: 0x1540
// Size: 0xb2
function function_750a4f4c()
{
    var_7b183fd7 = getentarray( "atrium01_mobile_shop", "targetname" );
    
    foreach ( e_item in var_7b183fd7 )
    {
        e_item delete();
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xd1e5159e, Offset: 0x1600
// Size: 0x6c
function function_c40186f4()
{
    var_dc105c2b = lotus_util::function_8108bdb8( "shed_explosion_a", "hero_shed_piece", undefined );
    var_dc105c2b lotus_util::function_aabc561a( "mobile_shop_fall_explosion" );
    level function_fc9a646b( "show" );
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0x23c40955, Offset: 0x1678
// Size: 0x17a
function function_fc9a646b( var_158cd2ca )
{
    if ( !isdefined( var_158cd2ca ) )
    {
        var_158cd2ca = "hide";
    }
    
    a_debris = getentarray( "area_shed_debris_1", "targetname" );
    
    if ( var_158cd2ca == "show" )
    {
        foreach ( piece in a_debris )
        {
            if ( isdefined( piece ) )
            {
                piece show();
            }
        }
        
        return;
    }
    
    foreach ( piece in a_debris )
    {
        if ( isdefined( piece ) )
        {
            piece hide();
        }
    }
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0xe888fe92, Offset: 0x1800
// Size: 0x1a
function function_a7f02ddb( a_ents )
{
    level notify( #"hash_a7f02ddb" );
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0xd16f10a4, Offset: 0x1828
// Size: 0x1a
function function_1d2443e2( a_ents )
{
    level notify( #"hash_41bb6835" );
}

// Namespace lotus_boss_battle
// Params 4
// Checksum 0x80c56195, Offset: 0x1850
// Size: 0x24
function prometheus_intro_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace lotus_boss_battle
// Params 2
// Checksum 0x3a4b2deb, Offset: 0x1880
// Size: 0x784
function old_friend_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        function_428ff2f();
    }
    
    level scene::add_scene_func( "cin_lot_17_oldfriend_3rd_sh190", &function_eaf57a3, "done" );
    level scene::add_scene_func( "cin_lot_17_oldfriend_3rd_sh070", &function_90b04eba, "done" );
    level scene::add_scene_func( "cin_lot_17_oldfriend_3rd_sh080", &function_623303f2, "done" );
    level scene::add_scene_func( "cin_lot_17_oldfriend_3rd_sh090", &function_90b04eba, "done" );
    level scene::add_scene_func( "cin_lot_17_oldfriend_3rd_sh140", &function_623303f2, "done" );
    level scene::add_scene_func( "cin_lot_17_oldfriend_3rd_sh150", &function_90b04eba, "done" );
    level scene::add_scene_func( "cin_lot_17_oldfriend_3rd_sh160", &function_623303f2, "done" );
    level scene::add_scene_func( "cin_lot_17_oldfriend_3rd_sh220", &function_90b04eba, "done" );
    scene::add_scene_func( "cin_lot_17_01_oldfriend_1st_wakeup", &end_fade_out, "skip_started" );
    scene::add_scene_func( "cin_lot_17_01_oldfriend_1st_wakeup", &function_4d425f2a, "done" );
    var_8e1ab582 = getentarray( "of_igc_railing", "targetname" );
    
    foreach ( var_d1610bbf in var_8e1ab582 )
    {
        var_d1610bbf hide();
    }
    
    if ( isdefined( level.vh_gunship ) )
    {
        level.vh_gunship delete();
    }
    
    s_scene = struct::get( "gunship_down_fxanim", "targetname" );
    
    if ( b_starting )
    {
        s_scene scene::init();
        level scene::init( "cin_lot_17_oldfriend_3rd_sh010" );
        load::function_a2995f22();
    }
    
    foreach ( player in level.players )
    {
        player player::switch_to_primary_weapon( 1 );
        player.script_ignoreme = 1;
    }
    
    level clientfield::set( "gameplay_started", 0 );
    level thread namespace_3bad5a01::function_dae48a54();
    level scene::play( "cin_lot_17_oldfriend_3rd_sh010" );
    level waittill( #"hash_65ad50c6" );
    
    if ( isdefined( level.bzm_lotusdialogue9callback ) )
    {
        level thread [[ level.bzm_lotusdialogue9callback ]]();
    }
    
    s_scene thread scene::play();
    var_9541c781 = getentarray( "gunship_fall", "targetname" );
    
    foreach ( var_e9d5eee1 in var_9541c781 )
    {
        var_e9d5eee1 hide();
    }
    
    level waittill( #"hash_c2926439" );
    e_taylor = getent( "taylor", "targetname" );
    e_taylor setmodel( "c_hro_taylor_base_bullet_wound" );
    level waittill( #"hash_4868cda0" );
    level thread function_5bb13a75();
    
    if ( !scene::is_skipping_in_progress() )
    {
        util::screen_fade_out( 3, "black", "old_friend_hospital_transition" );
    }
    
    level waittill( #"hash_e43285f9" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        util::screen_fade_in( 3, "black", "old_friend_hospital_transition" );
    }
    
    level thread audio::unlockfrontendmusic( "mus_lotus_theme_intro" );
    level thread namespace_3bad5a01::function_6be50b2c();
    
    if ( isdefined( level.bzm_lotusdialogue10callback ) )
    {
        level thread [[ level.bzm_lotusdialogue10callback ]]();
    }
    
    level waittill( #"hash_4f90f275" );
    var_4af4348c = getent( "rachel", "targetname" );
    var_4af4348c detach( "c_hro_rachel_egypt_scarf" );
    level waittill( #"hash_6adfba7a" );
    
    if ( !scene::is_skipping_in_progress() )
    {
        level clientfield::set( "sndIGCsnapshot", 4 );
        level thread util::screen_fade_out( 1, "white" );
    }
    
    streamerrequest( "clear" );
    skipto::objective_completed( "old_friend" );
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0x50c94626, Offset: 0x2010
// Size: 0x24
function function_4d425f2a( a_ents )
{
    skipto::objective_completed( "old_friend" );
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0x4ed2bdf2, Offset: 0x2040
// Size: 0xd4
function end_fade_out( a_ents )
{
    level clientfield::set( "sndIGCsnapshot", 4 );
    
    foreach ( player in level.activeplayers )
    {
        player setlowready( 1 );
    }
    
    util::screen_fade_out( 0, "black" );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x8582deaa, Offset: 0x2120
// Size: 0x3a4
function function_eaf57a3()
{
    cin_lot_debris_piece_01 = getent( "cin_lot_debris_piece_01", "targetname" );
    cin_lot_debris_piece_02 = getent( "cin_lot_debris_piece_02", "targetname" );
    cin_lot_debris_piece_03 = getent( "cin_lot_debris_piece_03", "targetname" );
    cin_lot_debris_piece_04 = getent( "cin_lot_debris_piece_04", "targetname" );
    cin_lot_debris_piece_05 = getent( "cin_lot_debris_piece_05", "targetname" );
    cin_lot_debris_piece_06 = getent( "cin_lot_debris_piece_06", "targetname" );
    cin_lot_debris_piece_07 = getent( "cin_lot_debris_piece_07", "targetname" );
    cin_lot_debris_piece_08 = getent( "cin_lot_debris_piece_08", "targetname" );
    cin_lot_debris_piece_09 = getent( "cin_lot_debris_piece_09", "targetname" );
    cin_lot_debris_piece_10 = getent( "cin_lot_debris_piece_10", "targetname" );
    cin_lot_debris_piece_11 = getent( "cin_lot_debris_piece_11", "targetname" );
    cin_lot_debris_piece_12 = getent( "cin_lot_debris_piece_12", "targetname" );
    cin_lot_debris_piece_13 = getent( "cin_lot_debris_piece_13", "targetname" );
    cin_lot_debris_piece_01 delete();
    cin_lot_debris_piece_02 delete();
    cin_lot_debris_piece_03 delete();
    cin_lot_debris_piece_04 delete();
    cin_lot_debris_piece_05 delete();
    cin_lot_debris_piece_06 delete();
    cin_lot_debris_piece_07 delete();
    cin_lot_debris_piece_08 delete();
    cin_lot_debris_piece_09 delete();
    cin_lot_debris_piece_10 delete();
    cin_lot_debris_piece_11 delete();
    cin_lot_debris_piece_12 delete();
    cin_lot_debris_piece_13 delete();
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x4113ca4, Offset: 0x24d0
// Size: 0x9c
function function_d9f5f2cf()
{
    self vehicle::toggle_sounds( 0 );
    self vehicle::toggle_exhaust_fx( 0 );
    self turret::disable( 0 );
    self vehicle::toggle_lights_group( 1, 0 );
    self vehicle::toggle_lights_group( 2, 0 );
    self clientfield::set( "gunship_rumble_off", 1 );
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0x4628d6c7, Offset: 0x2578
// Size: 0x2c
function function_90b04eba( a_ents )
{
    a_ents[ "mothership" ] ghost();
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0x96c3dbc, Offset: 0x25b0
// Size: 0x2c
function function_623303f2( a_ents )
{
    a_ents[ "mothership" ] show();
}

// Namespace lotus_boss_battle
// Params 4
// Checksum 0x9675ef99, Offset: 0x25e8
// Size: 0x24
function old_friend_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x7c2c24fa, Offset: 0x2618
// Size: 0x54
function function_5bb13a75()
{
    wait 3;
    var_f9749701 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_f9749701 playloopsound( "amb_heart_monitor_2d", 1 );
}

// Namespace lotus_boss_battle
// Params 2
// Checksum 0x7170a6a, Offset: 0x2678
// Size: 0x25c
function boss_battle_main( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        function_428ff2f();
        level thread function_c40186f4();
        level thread destructible_cover();
    }
    else
    {
        if ( isalive( level.ai_hendricks ) )
        {
            level.ai_hendricks delete();
        }
        
        skipto::teleport( str_objective );
    }
    
    s_scene = struct::get( "gunship_down_fxanim", "targetname" );
    s_scene scene::init();
    objectives::complete( "cp_level_lotus_capture_taylor" );
    objectives::set( "cp_level_lotus_leviathan" );
    lotus_accolades::function_a2c4c634();
    boss_battle_inits();
    setup_boss_mobile_shop();
    str_armory = "ms_r4";
    level thread call_first_armory( str_armory );
    
    if ( b_starting )
    {
        load::function_a2995f22();
    }
    
    level.vh_gunship = spawner::simple_spawn_single( "gunship" );
    level.vh_gunship thread gunship_logic();
    level notify( #"hash_a450f864" );
    exploder::exploder( "fx_boss_battle_ambients" );
    level thread start_vo();
    level waittill( #"gunship_almost_dead" );
    level thread namespace_3bad5a01::function_973b77f9();
    wait 2;
    skipto::objective_completed( "boss_battle" );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x285a7462, Offset: 0x28e0
// Size: 0xd4
function start_vo()
{
    level thread namespace_3bad5a01::function_d6e5b30();
    wait 0.5;
    level flag::set( "ready_to_move_first_armory_vo" );
    level dialog::remote( "kane_leviathans_are_heavy_0" );
    level dialog::remote( "kane_mobile_armories_on_t_0" );
    objectives::set( "cp_level_lotus_leviathan_destroy" );
    level flag::set( "story_vo_completed" );
    wait 5;
    level thread function_eb80777c();
}

// Namespace lotus_boss_battle
// Params 2
// Checksum 0x3c042ff5, Offset: 0x29c0
// Size: 0xca
function function_309d7a5a( var_24d48af, wait_time )
{
    if ( !isdefined( level.var_2e49e915 ) )
    {
        level.var_2e49e915 = 0;
    }
    
    if ( level flag::get( "story_vo_completed" ) && !isdefined( level.var_1d581e7 ) && level.var_2e49e915 == 0 )
    {
        level.var_1d581e7 = var_24d48af;
        level.var_1df069b5 = 1;
        dialog::remote( var_24d48af );
        level.var_1df069b5 = 0;
        
        if ( !isdefined( wait_time ) )
        {
            wait_time = 5;
        }
        
        wait wait_time;
        level.var_1d581e7 = undefined;
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xf08d2854, Offset: 0x2a98
// Size: 0x266
function boss_battle_inits()
{
    level flag::init( "call_next_mobile_shop" );
    level flag::init( "call_next_mobile_armory" );
    level flag::init( "gunship_in_transition" );
    level flag::init( "story_vo_completed" );
    level flag::init( "gunship_high_out_of_battle" );
    level flag::set( "flag_roof_battle_kill_trigger_enable" );
    level.n_times_without_reward = 0;
    level flag::init( "first_missile_fired_vo" );
    level flag::init( "first_mobile_armory_vo" );
    level flag::init( "ready_to_move_first_armory_vo" );
    level flag::init( "stop_dialog_remote" );
    level.var_fadf752 = [];
    level.var_fadf752[ 0 ] = "plyr_kane_you_telling_me_0";
    level.var_fadf752[ 1 ] = "plyr_kane_you_telling_me_1";
    level.kane_missiles = [];
    level.kane_missiles[ 0 ] = "kane_leviathan_deploying_1";
    level.kane_missiles[ 1 ] = "kane_grab_cover_incoming_0";
    level.kane_missiles[ 2 ] = "kane_missiles_incoming_0";
    level.var_ead3caed = [];
    level.var_ead3caed[ 0 ] = "kane_leviathan_deploying_0";
    level.var_ead3caed[ 1 ] = "kane_incoming_raps_0";
    level.var_ead3caed[ 2 ] = "kane_nrc_airship_deployin_0";
    level.var_4483235d = [];
    level.var_4483235d[ 0 ] = "kane_leviathan_deploying_2";
    level.var_4483235d[ 1 ] = "kane_heads_up_hounds_inc_0";
    level.var_4483235d[ 2 ] = "kane_nrc_airship_sending_0";
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x8faaf31a, Offset: 0x2d08
// Size: 0x7b8
function function_eb80777c()
{
    wait 8;
    level function_80fdeb82();
    level.var_2e49e915 = 1;
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::remote( "tayr_welcome_back_2" );
    }
    
    level.var_2e49e915 = 0;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::player_say( "plyr_taylor_you_need_to_0" );
    }
    
    level.var_2e49e915 = 0;
    rand_wait = 3 + randomint( 5 );
    wait rand_wait;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::remote( "tayr_do_you_know_what_s_h_1" );
    }
    
    level.var_2e49e915 = 0;
    wait 1;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::player_say( "plyr_i_know_you_can_hear_0" );
    }
    
    level.var_2e49e915 = 0;
    rand_wait = 3 + randomint( 5 );
    wait rand_wait;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::remote( "tayr_you_ve_got_a_long_wa_1" );
    }
    
    level.var_2e49e915 = 0;
    wait 1;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::player_say( "plyr_what_s_happening_to_1" );
    }
    
    level.var_2e49e915 = 0;
    rand_wait = 3 + randomint( 5 );
    wait rand_wait;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::remote( "tayr_your_dni_may_show_yo_1" );
    }
    
    level.var_2e49e915 = 0;
    wait 1;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::player_say( "plyr_you_don_t_have_to_be_0" );
    }
    
    level.var_2e49e915 = 0;
    rand_wait = 3 + randomint( 5 );
    wait rand_wait;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::remote( "tayr_you_were_with_sarah_0" );
    }
    
    level.var_2e49e915 = 0;
    wait 0.5;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::player_say( "plyr_you_re_right_i_was_0" );
    }
    
    level.var_2e49e915 = 0;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::player_say( "plyr_i_also_know_it_wasn_0" );
    }
    
    level.var_2e49e915 = 0;
    rand_wait = 3 + randomint( 5 );
    wait rand_wait;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::remote( "tayr_clock_s_ticking_new_1" );
    }
    
    level.var_2e49e915 = 0;
    wait 1;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::player_say( "plyr_you_know_me_you_can_2" );
    }
    
    level.var_2e49e915 = 0;
    rand_wait = 3 + randomint( 5 );
    wait rand_wait;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::player_say( "plyr_it_s_not_too_late_to_2" );
    }
    
    level.var_2e49e915 = 0;
    wait 1;
    level.var_2e49e915 = 1;
    level function_80fdeb82();
    
    if ( !level flag::get( "stop_dialog_remote" ) )
    {
        level dialog::remote( "tayr_sometimes_you_have_1" );
    }
    
    level.var_2e49e915 = 0;
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x560d9c6a, Offset: 0x34c8
// Size: 0x2c
function function_80fdeb82()
{
    level endon( #"gunship_almost_dead" );
    
    while ( level.var_1df069b5 == 1 )
    {
        wait 0.1;
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xd5976c58, Offset: 0x3500
// Size: 0x22a
function destructible_cover()
{
    a_destructible_pieces = getentarray( "hero_shed_piece", "targetname" );
    
    foreach ( mdl_destructible_piece in a_destructible_pieces )
    {
        if ( mdl_destructible_piece.script_fxid != "shed_explosion_a" )
        {
            mdl_destructible_piece thread lotus_util::destructible_watch( "mobile_shop_fall_explosion" );
        }
    }
    
    a_destructible_pieces = getentarray( "roof_shed_piece_l", "targetname" );
    
    foreach ( mdl_destructible_piece in a_destructible_pieces )
    {
        mdl_destructible_piece thread lotus_util::destructible_watch( "mobile_shop_fall_explosion" );
    }
    
    a_destructible_pieces = getentarray( "roof_shed_piece_r", "targetname" );
    
    foreach ( mdl_destructible_piece in a_destructible_pieces )
    {
        mdl_destructible_piece thread lotus_util::destructible_watch( "mobile_shop_fall_explosion" );
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x652daa12, Offset: 0x3738
// Size: 0x30
function init_player_hunters()
{
    player_hunters = getentarray( "boss_player_hunter", "targetname" );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x9548706c, Offset: 0x3770
// Size: 0x292
function setup_boss_mobile_shop()
{
    level.a_ms_info = [];
    setup_boss_mobile_shop_info( "ms_l1", 0 );
    setup_boss_mobile_shop_info( "ms_l2", 1 );
    setup_boss_mobile_shop_info( "ms_l3", 5 );
    setup_boss_mobile_shop_info( "ms_l4", 3 );
    setup_boss_mobile_shop_info( "ms_r1", 3 );
    setup_boss_mobile_shop_info( "ms_r2", 2 );
    setup_boss_mobile_shop_info( "ms_r3", 4 );
    setup_boss_mobile_shop_info( "ms_r4", 0 );
    level.a_o_mobile_platform = [];
    level.a_mobile_shops = [];
    setup_moving_platform( "ms_l1" );
    setup_moving_platform( "ms_l2" );
    setup_moving_platform( "ms_l3" );
    setup_moving_platform( "ms_l4" );
    setup_moving_platform( "ms_r1" );
    setup_moving_platform( "ms_r2" );
    setup_moving_platform( "ms_r3" );
    setup_moving_platform( "ms_r4" );
    a_raps_slow = getentarray( "raps_slow", "targetname" );
    
    foreach ( t_raps_slow in a_raps_slow )
    {
        t_raps_slow triggerenable( 0 );
    }
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0x9cd68e2c, Offset: 0x3a10
// Size: 0x9e
function setup_moving_platform( str_name )
{
    level.a_mobile_shops[ str_name ] = lotus_util::mobile_shop_setup( str_name + "_group", 1, 0, 1, undefined, 1 );
    o_mobile_shop = new cvehicleplatform();
    [[ o_mobile_shop ]]->init( str_name, str_name + "_start_up" );
    level.a_o_mobile_platform[ str_name ] = o_mobile_shop;
}

// Namespace lotus_boss_battle
// Params 3
// Checksum 0x92ae0bac, Offset: 0x3ab8
// Size: 0xe8
function setup_boss_mobile_shop_info( str_name, n_gunship_index, str_location )
{
    level.a_ms_info[ str_name ] = spawnstruct();
    level.a_ms_info[ str_name ].b_was_normal = 0;
    level.a_ms_info[ str_name ].b_was_armory = 0;
    level.a_ms_info[ str_name ].n_gunship_index = n_gunship_index;
    s_ms_end = struct::get( str_name + "_1", "targetname" );
    level.a_ms_info[ str_name ].v_origin = s_ms_end.origin;
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0x3808bdd2, Offset: 0x3ba8
// Size: 0xfc
function call_first_armory( str_armory )
{
    level.s_mobile_shop = level.a_ms_info[ str_armory ];
    level flag::wait_till( "first_player_spawned" );
    level flag::wait_till( "ready_to_move_first_armory_vo" );
    level thread move_mobile_shop( "ms_r2", "other" );
    level thread move_mobile_shop( "ms_r3", "minigun" );
    level thread move_mobile_shop( "ms_l1", "other" );
    level thread move_mobile_shop( "ms_l4", "minigun" );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xaf817921, Offset: 0x3cb0
// Size: 0x1ac
function gunship_first_missile_target()
{
    self.e_override_missile_target = getent( "gunship_first_missile_target", "targetname" );
    mdl_weapon_clip = getent( "bb_start_weapon_clip", "targetname" );
    mdl_weapon_clip setcandamage( 1 );
    mdl_weapon_clip.health = 10000;
    mdl_weapon_clip endon( #"death" );
    
    while ( true )
    {
        mdl_weapon_clip waittill( #"damage", n_damage, e_attacker, v_vector, v_point, str_means_of_death, str_string_1, str_string_2, str_string_3, w_weapon );
        
        if ( str_means_of_death == "MOD_PROJECTILE" || e_attacker.vehicletype === "veh_bo3_mil_gunship_nrc" && str_means_of_death == "MOD_PROJECTILE_SPLASH" )
        {
            self.e_override_missile_target delete();
            self.e_override_missile_target = undefined;
            mdl_weapon_clip delete();
        }
        
        mdl_weapon_clip.health = 10000;
        wait 0.05;
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xf6b7269a, Offset: 0x3e68
// Size: 0x64
function mobile_shop_logic()
{
    level flag::wait_till( "ready_to_move_first_armory_vo" );
    level thread function_309d7a5a( "kane_mobile_armories_on_t_0" );
    level flag::set( "first_mobile_armory_vo" );
}

// Namespace lotus_boss_battle
// Params 2
// Checksum 0x9f9145b2, Offset: 0x3ed8
// Size: 0xb6a
function move_mobile_shop( str_name, str_armory_type )
{
    level.a_ms_info[ str_name ].str_state = "normal";
    level.a_ms_info[ str_name ].b_was_normal = 1;
    level.s_mobile_shop = level.a_ms_info[ str_name ];
    str_groupname = str_name + "_group";
    var_526507d5 = str_name + "_gate";
    var_7b6485f6 = getentarray( var_526507d5, "targetname" );
    b_armory = 0;
    
    if ( str_armory_type == "minigun" )
    {
        b_armory = 1;
    }
    
    e_mobile_shop = level.a_mobile_shops[ str_name ];
    
    if ( str_armory_type == "minigun" )
    {
        foreach ( e_minigun_auto in e_mobile_shop.a_miniguns )
        {
            t_minigun_auto = e_minigun_auto lotus_util::minigun_usable( 1, 1 );
            t_minigun_auto linkto( e_mobile_shop );
        }
    }
    else
    {
        foreach ( e_weapon in e_mobile_shop.a_weapons )
        {
            t_weapon = e_weapon lotus_util::mobile_weapon_usable( e_weapon.script_string );
            t_weapon linkto( e_mobile_shop );
        }
    }
    
    o_mobile_platform = level.a_o_mobile_platform[ str_name ];
    vh_mobile = [[ o_mobile_platform ]]->get_platform_vehicle();
    vh_mobile resetdestructible();
    vh_mobile clearvehgoalpos();
    [[ o_mobile_platform ]]->set_node_start( str_name + "_start_up" );
    trigger::use( "trig_" + str_name, "script_noteworthy" );
    level waittill( "vehicle_platform_" + str_name + "_stop" );
    
    foreach ( var_a43047cf in var_7b6485f6 )
    {
        var_a43047cf thread function_d2dd0256( 38, 0.5 );
    }
    
    a_traversals = [];
    
    if ( !isdefined( a_traversals ) )
    {
        a_traversals = [];
    }
    else if ( !isarray( a_traversals ) )
    {
        a_traversals = array( a_traversals );
    }
    
    a_traversals[ a_traversals.size ] = getnode( str_name + "_in_begin", "targetname" );
    
    if ( !isdefined( a_traversals ) )
    {
        a_traversals = [];
    }
    else if ( !isarray( a_traversals ) )
    {
        a_traversals = array( a_traversals );
    }
    
    a_traversals[ a_traversals.size ] = getnode( str_name + "_out_begin", "targetname" );
    
    foreach ( nd_traversal in a_traversals )
    {
        if ( isdefined( nd_traversal ) )
        {
            linktraversal( nd_traversal );
        }
    }
    
    t_raps_slow = getent( "trig_slow_" + str_name, "script_noteworthy" );
    t_raps_slow triggerenable( 1 );
    level notify( #"new_mobile_shop_arrived" );
    
    if ( str_armory_type == "minigun" )
    {
        var_8b943ba8 = 1;
        
        foreach ( player in level.activeplayers )
        {
            if ( issubstr( player.currentweapon.name, "minigun" ) )
            {
                var_8b943ba8 = 0;
            }
        }
        
        if ( var_8b943ba8 )
        {
            level thread function_309d7a5a( "kane_get_that_minigun_fro_0" );
        }
    }
    
    level waittill( #"gunship_almost_dead" );
    waittill_mobile_shop_empty( str_name );
    
    foreach ( var_a43047cf in var_7b6485f6 )
    {
        var_a43047cf thread function_ee5df555( 38, 0.5 );
    }
    
    vh_mobile clearvehgoalpos();
    [[ o_mobile_platform ]]->set_node_start( str_name + "_start_down" );
    trigger::use( "trig_" + str_name, "script_noteworthy" );
    t_raps_slow = getent( "trig_slow_" + str_name, "script_noteworthy" );
    t_raps_slow triggerenable( 0 );
    
    if ( str_armory_type == "minigun" )
    {
        foreach ( e_minigun_auto in e_mobile_shop.a_miniguns )
        {
            if ( isdefined( e_minigun_auto ) )
            {
                if ( isdefined( e_minigun_auto.t_minigun_auto ) )
                {
                    e_minigun_auto.t_minigun_auto delete();
                }
            }
        }
    }
    
    foreach ( nd_traversal in a_traversals )
    {
        if ( isdefined( nd_traversal ) )
        {
            unlinktraversal( nd_traversal );
        }
    }
    
    level waittill( "vehicle_platform_" + str_name + "_stop" );
    
    if ( str_armory_type == "minigun" )
    {
        foreach ( e_minigun_auto in e_mobile_shop.a_miniguns )
        {
            if ( isdefined( e_minigun_auto ) )
            {
                e_minigun_auto notify( #"minigun_turret_cleanup" );
            }
        }
    }
    
    foreach ( mdl_destructible in e_mobile_shop.a_destructibles )
    {
        mdl_destructible show();
        mdl_destructible solid();
    }
    
    foreach ( e_weapon in e_mobile_shop.a_weapons )
    {
        e_weapon hide();
    }
}

// Namespace lotus_boss_battle
// Params 2
// Checksum 0x90b8e5f0, Offset: 0x4a50
// Size: 0x44
function function_ee5df555( distance, move_time )
{
    self moveto( self.origin + ( 0, 0, distance ), move_time );
}

// Namespace lotus_boss_battle
// Params 2
// Checksum 0xbbe7d296, Offset: 0x4aa0
// Size: 0x44
function function_d2dd0256( distance, move_time )
{
    self moveto( self.origin - ( 0, 0, distance ), move_time );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xedc967c0, Offset: 0x4af0
// Size: 0x214
function mobile_armory_type()
{
    a_possible_types = array( "none", "none", "minigun" );
    w_minigun = getweapon( "minigun_lotus" );
    n_player_with_minigun = 0;
    
    foreach ( player in level.players )
    {
        if ( player hasweapon( w_minigun ) )
        {
            n_player_with_minigun++;
        }
    }
    
    if ( n_player_with_minigun != level.players.size )
    {
        if ( !isdefined( a_possible_types ) )
        {
            a_possible_types = [];
        }
        else if ( !isarray( a_possible_types ) )
        {
            a_possible_types = array( a_possible_types );
        }
        
        a_possible_types[ a_possible_types.size ] = "minigun";
    }
    
    str_armory_type = array::random( a_possible_types );
    
    if ( str_armory_type != "none" )
    {
        level.n_times_without_reward = 0;
    }
    else
    {
        level.n_times_without_reward++;
        
        if ( level.n_times_without_reward > 2 )
        {
            arrayremovevalue( a_possible_types, "none" );
            str_armory_type = array::random( a_possible_types );
        }
    }
    
    return str_armory_type;
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0x13e1dee9, Offset: 0x4d10
// Size: 0x16c
function find_mobile_shop_distance_closest_to_a_player( str_name )
{
    n_dist_sq_closest = distance2dsquared( level.players[ 0 ].origin, level.a_ms_info[ str_name ].v_origin );
    
    foreach ( player in level.players )
    {
        n_dist_sq = distance2dsquared( player.origin, level.a_ms_info[ str_name ].v_origin );
        
        if ( n_dist_sq < n_dist_sq_closest )
        {
            n_dist_sq_closest = n_dist_sq;
        }
    }
    
    a_closest_dist_sq_info = spawnstruct();
    a_closest_dist_sq_info.str_name = str_name;
    a_closest_dist_sq_info.n_dist_sq = n_dist_sq_closest;
    return a_closest_dist_sq_info;
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0x5ca4f16f, Offset: 0x4e88
// Size: 0x184
function waittill_mobile_shop_empty( str_name )
{
    e_volume = getent( "vol_" + str_name, "targetname" );
    b_someone_in_mobile = 1;
    
    while ( isdefined( b_someone_in_mobile ) && b_someone_in_mobile )
    {
        n_checked = 0;
        a_checks = getentarray( "gunship_raps_ai", "targetname" );
        a_checks = arraycombine( a_checks, level.players, 0, 0 );
        
        foreach ( e_check in a_checks )
        {
            if ( e_check istouching( e_volume ) )
            {
                break;
            }
            
            n_checked++;
        }
        
        if ( n_checked == a_checks.size )
        {
            b_someone_in_mobile = 0;
        }
        
        wait 0.05;
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x1efbdf7b, Offset: 0x5018
// Size: 0x3ec
function gunship_logic()
{
    self endon( #"death" );
    level thread function_e0652cc();
    setsaveddvar( "vehicle_selfCollision", 1 );
    self useanimtree( $generic );
    self.n_health_min = self.health * 0.01;
    self.n_index_prev = 0;
    self.n_index_current = 0;
    self.n_index_next = 0;
    self.n_index_goal = level.s_mobile_shop.n_gunship_index;
    self.overridevehicledamage = &gunship_damage_override;
    self.var_af439c86 = 0;
    self.var_e7f801f1 = 0;
    self.goalradius = 999999;
    self.goalheight = 4000;
    self setgoal( self.origin, 0, self.goalradius, self.goalheight );
    self setneargoalnotifydist( self.radius * 0.5 );
    self.nocybercom = 1;
    assert( isdefined( self.scriptbundlesettings ) );
    self.settings = struct::get_script_bundle( "vehiclecustomsettings", self.scriptbundlesettings );
    self vehicle::toggle_lights_group( 1, 1 );
    self vehicle::toggle_lights_group( 2, 1 );
    self.ignorefirefly = 1;
    self.ignoredecoy = 1;
    self vehicle_ai::initthreatbias();
    self.gunship_targets = [];
    self flag::init( "gunship_can_shoot" );
    self flag::init( "missiles_not_firing" );
    self flag::init( "gunship_over_roof" );
    self flag::set( "gunship_can_shoot" );
    self flag::set( "missiles_not_firing" );
    t_gunship_body = getent( "gunship_body", "targetname" );
    t_gunship_body enablelinkto();
    t_gunship_body linkto( self );
    t_gunship_body thread gunship_shooting_at_body( self );
    self thread gunship_target_logic();
    self thread gunship_health_watch();
    self thread gunship_weakpoint();
    self.var_c3733510 = 0;
    self thread function_d41b2661();
    self.var_f7041287 = 0;
    self thread gunship_health_half_watch();
    self thread gunship_almost_dead();
    self gunship_brain();
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xdf7b09f, Offset: 0x5410
// Size: 0x150
function function_e0652cc()
{
    while ( true )
    {
        level waittill( #"save_restore" );
        wait 1;
        
        if ( isdefined( level.vh_gunship ) )
        {
            if ( level.vh_gunship.var_e507c83f[ "tag_target_fan_right_outer" ] )
            {
                level.vh_gunship globallogic_ui::createweakpointwidget( &"tag_target_fan_right_outer", 4000, 7500 );
            }
            
            if ( level.vh_gunship.var_e507c83f[ "tag_target_fan_right_inner" ] )
            {
                level.vh_gunship globallogic_ui::createweakpointwidget( &"tag_target_fan_right_inner", 4000, 7500 );
            }
            
            if ( level.vh_gunship.var_e507c83f[ "tag_target_fan_left_inner" ] )
            {
                level.vh_gunship globallogic_ui::createweakpointwidget( &"tag_target_fan_left_inner", 4000, 7500 );
            }
            
            if ( level.vh_gunship.var_e507c83f[ "tag_target_fan_left_outer" ] )
            {
                level.vh_gunship globallogic_ui::createweakpointwidget( &"tag_target_fan_left_outer", 4000, 7500 );
            }
        }
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x41da688f, Offset: 0x5568
// Size: 0x18
function function_d41b2661()
{
    wait 10;
    self.var_c3733510 = 1;
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xa2201d86, Offset: 0x5588
// Size: 0x7a0
function getnextmoveposition_tactical()
{
    selfdisttotarget = distance2d( self.origin, self.e_target.origin );
    gooddist = 0.5 * ( self.settings.engagementdistmin + self.settings.engagementdistmax );
    closedist = 1.2 * gooddist;
    fardist = 3 * gooddist;
    querymultiplier = mapfloat( closedist, fardist, 1, 3, selfdisttotarget );
    preferedheightrange = 0.5 * ( self.settings.engagementheightmax - self.settings.engagementheightmin );
    randomness = 300;
    queryresult = positionquery_source_navigation( self.origin, self.radius + 500, 10000, 1000, self.radius * 0.4, self, self.radius * 0.4 );
    
    if ( !( isdefined( queryresult.centeronnav ) && queryresult.centeronnav ) && !level flag::get( "gunship_high_out_of_battle" ) )
    {
        var_5740256e = self getclosestpointonnavvolume( self.origin, self.radius + 500 );
        
        if ( isdefined( var_5740256e ) )
        {
            self.var_ec9be5b1 = queryresult.centeronnav;
            
            /#
                iprintlnbold( "<dev string:x28>" );
            #/
            
            return var_5740256e;
        }
    }
    
    positionquery_filter_distancetogoal( queryresult, self );
    vehicle_ai::positionquery_filter_outofgoalanchor( queryresult );
    self vehicle_ai::positionquery_filter_engagementdist( queryresult, self.e_target, self.settings.engagementdistmin, self.settings.engagementdistmax );
    goalheight = self.e_target.origin[ 2 ] + 0.5 * ( self.settings.engagementheightmin + self.settings.engagementheightmax );
    
    foreach ( point in queryresult.data )
    {
        /#
            if ( !isdefined( point._scoredebug ) )
            {
                point._scoredebug = [];
            }
            
            point._scoredebug[ "<dev string:x4c>" ] = randomfloatrange( 0, randomness );
        #/
        
        point.score += randomfloatrange( 0, randomness );
        
        /#
            if ( !isdefined( point._scoredebug ) )
            {
                point._scoredebug = [];
            }
            
            point._scoredebug[ "<dev string:x53>" ] = point.distawayfromengagementarea * -1;
        #/
        
        point.score += point.distawayfromengagementarea * -1;
        distfrompreferredheight = abs( point.origin[ 2 ] - goalheight );
        
        if ( distfrompreferredheight > preferedheightrange )
        {
            /#
                if ( !isdefined( point._scoredebug ) )
                {
                    point._scoredebug = [];
                }
                
                point._scoredebug[ "<dev string:x62>" ] = distfrompreferredheight * -1;
            #/
            
            point.score += distfrompreferredheight * -1;
        }
    }
    
    vehicle_ai::positionquery_postprocess_sortscore( queryresult );
    positionquery_filter_sight( queryresult, self.e_target.origin, self geteye() - self.origin, self, 1, self.e_target );
    best_point = undefined;
    
    foreach ( point in queryresult.data )
    {
        if ( isdefined( point.visibility ) && point.visibility )
        {
            best_point = point;
            break;
        }
    }
    
    if ( !isdefined( best_point ) )
    {
        if ( isdefined( queryresult.data[ 0 ] ) )
        {
            best_point = queryresult.data[ 0 ];
        }
    }
    
    self vehicle_ai::positionquery_debugscores( queryresult );
    
    /#
        if ( isdefined( getdvarint( "<dev string:x69>" ) ) && getdvarint( "<dev string:x69>" ) )
        {
            if ( isdefined( best_point ) )
            {
                recordline( self.origin, best_point.origin, ( 0.3, 1, 0 ) );
            }
            
            recordline( self.origin, self.e_target.origin, ( 1, 0, 0.4 ) );
        }
    #/
    
    returnpoint = self.origin;
    self.var_ec9be5b1 = queryresult.centeronnav;
    
    if ( isdefined( best_point ) )
    {
        returnpoint = best_point.origin;
    }
    
    return returnpoint;
}

// Namespace lotus_boss_battle
// Params 3
// Checksum 0x3fc1301b, Offset: 0x5d30
// Size: 0x1ec
function delay_target_toenemy_thread( point, enemy, timetohit )
{
    self endon( #"death" );
    enemy endon( #"death" );
    enemy endon( #"disconnect" );
    
    if ( !isdefined( self.faketargetent ) )
    {
        self.faketargetent = spawn( "script_origin", point );
    }
    
    self.faketargetent unlink();
    self.faketargetent.origin = point;
    self setturrettargetent( self.faketargetent );
    self waittill( #"turret_on_target" );
    timestart = gettime();
    offset = ( 0, 0, 0 );
    
    if ( issentient( enemy ) )
    {
        offset = enemy geteye() - enemy.origin;
    }
    
    while ( gettime() < timestart + timetohit * 1000 )
    {
        self.faketargetent.origin = lerpvector( point, enemy.origin + offset, ( gettime() - timestart ) / timetohit * 1000 );
        wait 0.05;
    }
    
    self.faketargetent.origin = enemy.origin + offset;
    wait 0.05;
    self.faketargetent linkto( enemy );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x601e65ff, Offset: 0x5f28
// Size: 0x1a8
function attack_thread_mainturret()
{
    self endon( #"death" );
    self endon( #"hash_2e91796b" );
    
    while ( true )
    {
        if ( !level flag::get( "gunship_high_out_of_battle" ) )
        {
            enemy = self.e_target;
            
            if ( isdefined( enemy ) )
            {
                if ( self vehcansee( enemy ) )
                {
                    vectorfromenemy = vectornormalize( ( ( self.origin - enemy.origin )[ 0 ], ( self.origin - enemy.origin )[ 1 ], 0 ) );
                    self thread delay_target_toenemy_thread( enemy.origin + vectorfromenemy * 200, enemy, 1 );
                    self waittill( #"turret_on_target" );
                    self vehicle_ai::fire_for_time( 1.5 + randomfloat( 0.5 ) );
                    wait 2 + randomfloat( 0.4 );
                }
                else
                {
                    wait 0.1;
                }
            }
            else
            {
                self clearturrettarget();
                wait 0.2;
            }
        }
        
        wait 0.05;
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xb20b60a5, Offset: 0x60d8
// Size: 0x468
function gunship_brain()
{
    self endon( #"death" );
    self endon( #"prepare_to_die" );
    self.var_16f2fd07 = 0;
    s_armory_old = level.s_mobile_shop;
    n_switch_times = 0;
    n_times_without_raps = 0;
    self thread attack_thread_mainturret();
    
    while ( true )
    {
        if ( self.var_16f2fd07 )
        {
            wait 0.05;
            continue;
        }
        
        if ( level flag::get( "gunship_high_out_of_battle" ) )
        {
            var_ef088aca = struct::get_array( "gunship_out_of_fight_point", "targetname" );
            dist_sq = 1955032704;
            
            foreach ( position in var_ef088aca )
            {
                if ( distancesquared( position.origin, self.origin ) < dist_sq )
                {
                    var_1b28c94b = position;
                    dist_sq = distancesquared( position.origin, self.origin );
                }
            }
            
            self setvehgoalpos( var_1b28c94b.origin, 1, 0 );
            self vehicle_ai::waittill_pathing_done();
            wait 0.05;
            continue;
        }
        
        if ( isdefined( level.s_mobile_shop ) )
        {
            if ( isdefined( self.var_b5b6b568 ) && isdefined( self.var_d24de693 ) && randomint( 100 ) < 100 && self.var_d24de693 && self.var_b5b6b568 )
            {
                self.var_1e900bbc = 1;
            }
            
            self setspeed( self.settings.defaultmovespeed );
            
            if ( isdefined( self.inpain ) && self.inpain )
            {
                wait 0.1;
                continue;
            }
            
            if ( !isdefined( self.e_target ) )
            {
                wait 0.25;
                continue;
            }
            
            if ( isdefined( self.var_f7041287 ) && self.var_f7041287 )
            {
                self gunship_missile_attack_logic();
                self.var_f7041287 = 0;
            }
            
            if ( isdefined( self.var_7c83c7b9 ) && self.var_7c83c7b9 )
            {
                self gunship_roof_transition();
                continue;
            }
            
            returnpoint = getnextmoveposition_tactical();
            self.current_pathto_pos = returnpoint;
            
            if ( isdefined( self.current_pathto_pos ) )
            {
                if ( isdefined( self.var_ec9be5b1 ) && self.var_ec9be5b1 )
                {
                    self setvehgoalpos( self.current_pathto_pos, 1, 1 );
                    self vehicle_ai::waittill_pathing_done();
                }
                else
                {
                    self setvehgoalpos( self.current_pathto_pos, 1, 0 );
                    self vehicle_ai::waittill_pathing_done();
                }
            }
            
            if ( self.var_c3733510 && randomint( 100 ) < 30 )
            {
                self gunship_missile_attack_logic();
            }
        }
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x6a21e9eb, Offset: 0x6548
// Size: 0x9c
function waittill_raps_left_alive()
{
    a_raps = getentarray( "gunship_raps_ai", "targetname" );
    level.var_36a074b0 = gettime();
    
    while ( a_raps.size > 2 && gettime() - level.var_36a074b0 < 20000 )
    {
        wait 0.05;
        a_raps = getentarray( "gunship_raps_ai", "targetname" );
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x10054056, Offset: 0x65f0
// Size: 0x9c
function function_7a689af4()
{
    a_amws = getentarray( "gunship_amws_ai", "targetname" );
    level.var_5b028c20 = gettime();
    
    while ( a_amws.size > 2 && gettime() - level.var_5b028c20 < 20000 )
    {
        wait 0.05;
        a_amws = getentarray( "gunship_amws_ai", "targetname" );
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xc2b9caa, Offset: 0x6698
// Size: 0x84
function function_fabd65a5()
{
    self.var_16f2fd07 = 1;
    self setvehgoalpos( self.origin + ( 0, 0, 3000 ), 1, 1 );
    self vehicle_ai::waittill_pathing_done();
    self.var_16f2fd07 = 0;
    level flag::set_val( "gunship_high_out_of_battle", 0 );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x17a249f4, Offset: 0x6728
// Size: 0x2bc
function gunship_weakpoint()
{
    level flag::wait_till( "all_players_spawned" );
    wait 0.5;
    self globallogic_ui::createweakpointwidget( &"tag_target_fan_right_outer", 4000, 7500 );
    self globallogic_ui::createweakpointwidget( &"tag_target_fan_right_inner", 4000, 7500 );
    self globallogic_ui::createweakpointwidget( &"tag_target_fan_left_inner", 4000, 7500 );
    self globallogic_ui::createweakpointwidget( &"tag_target_fan_left_outer", 4000, 7500 );
    self.var_e507c83f = [];
    self.var_e507c83f[ "tag_target_fan_right_outer" ] = 1;
    self.var_e507c83f[ "tag_target_fan_right_inner" ] = 1;
    self.var_e507c83f[ "tag_target_fan_left_inner" ] = 1;
    self.var_e507c83f[ "tag_target_fan_left_outer" ] = 1;
    a_weakpoints = getentarray( "gunship_weakpoint", "targetname" );
    self.a_weakpoints = a_weakpoints;
    self.var_fd056e61 = [];
    
    foreach ( e_weakpoint in a_weakpoints )
    {
        e_weakpoint linkto( self );
        target_set( e_weakpoint );
        var_f4bd5505 = "fan_" + e_weakpoint.script_noteworthy + "_hurt";
        level.destructible_callbacks[ var_f4bd5505 ] = &function_9eab29c4;
        str_weakpoint_break_notify = "fan_" + e_weakpoint.script_noteworthy + "_destroyed";
        level.destructible_callbacks[ str_weakpoint_break_notify ] = &function_6c18838;
        self.var_fd056e61[ str_weakpoint_break_notify ] = e_weakpoint;
    }
}

// Namespace lotus_boss_battle
// Params 2
// Checksum 0x46e9b065, Offset: 0x69f0
// Size: 0x8c
function function_6c18838( var_ffec1daa, e_attacker )
{
    self gunship_weakpoint_remove_ui( self.var_fd056e61[ var_ffec1daa ].script_int );
    self.var_af439c86 += 1;
    self.var_e7f801f1 += 1;
    self.var_fd056e61[ var_ffec1daa ] delete();
}

// Namespace lotus_boss_battle
// Params 2
// Checksum 0xc4f0b425, Offset: 0x6a88
// Size: 0x28
function function_9eab29c4( var_ffec1daa, e_attacker )
{
    self.var_e7f801f1 += 1;
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0x5015ab19, Offset: 0x6ab8
// Size: 0x12a
function gunship_weakpoint_remove_ui( n_id )
{
    switch ( n_id )
    {
        case 1:
            self globallogic_ui::destroyweakpointwidget( &"tag_target_fan_right_outer" );
            self.var_e507c83f[ "tag_target_fan_right_outer" ] = 0;
            break;
        case 2:
            self globallogic_ui::destroyweakpointwidget( &"tag_target_fan_right_inner" );
            self.var_e507c83f[ "tag_target_fan_right_inner" ] = 0;
            break;
        case 3:
            self globallogic_ui::destroyweakpointwidget( &"tag_target_fan_left_inner" );
            self.var_e507c83f[ "tag_target_fan_left_inner" ] = 0;
            break;
        case 4:
            self globallogic_ui::destroyweakpointwidget( &"tag_target_fan_left_outer" );
            self.var_e507c83f[ "tag_target_fan_left_outer" ] = 0;
            break;
        default:
            break;
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x1a620aeb, Offset: 0x6bf0
// Size: 0x412
function gunship_almost_dead()
{
    while ( self.var_af439c86 < 4 )
    {
        wait 0.05;
    }
    
    a_flags = [];
    
    if ( !isdefined( a_flags ) )
    {
        a_flags = [];
    }
    else if ( !isarray( a_flags ) )
    {
        a_flags = array( a_flags );
    }
    
    a_flags[ a_flags.size ] = "gunship_can_shoot";
    
    if ( !isdefined( a_flags ) )
    {
        a_flags = [];
    }
    else if ( !isarray( a_flags ) )
    {
        a_flags = array( a_flags );
    }
    
    a_flags[ a_flags.size ] = "missiles_not_firing";
    self flag::wait_till_all( a_flags );
    self notify( #"end_dropping_raps" );
    self notify( #"end_missile_attack" );
    self notify( #"prepare_to_die" );
    self turret::disable( 0 );
    a_weakpoints = getentarray( "gunship_weakpoint", "targetname" );
    
    foreach ( e_weakpoint in a_weakpoints )
    {
        self gunship_weakpoint_remove_ui( e_weakpoint.script_int );
    }
    
    self notify( #"end_previous_path_logic" );
    self setspeed( 50 );
    s_position = struct::get( "of_gunship_start_pos" );
    self set_veh_goal_pos( s_position.origin, 1, 0 );
    self waittill( #"near_goal" );
    level notify( #"gunship_almost_dead" );
    level flag::set( "stop_dialog_remote" );
    a_raps = getentarray( "gunship_raps_ai", "targetname" );
    
    foreach ( ai_rap in a_raps )
    {
        ai_rap delete();
    }
    
    a_amws = getentarray( "gunship_amws_ai", "targetname" );
    
    foreach ( ai_amws in a_amws )
    {
        ai_amws delete();
    }
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0x30c20b47, Offset: 0x7010
// Size: 0x76
function gunship_shooting_at_body( vh_gunship )
{
    vh_gunship endon( #"gunship_health_less_than_half" );
    
    while ( true )
    {
        self waittill( #"trigger", triggerer );
        
        if ( isplayer( triggerer ) )
        {
            triggerer util::show_hint_text( &"CP_MI_CAIRO_LOTUS_LEVIATHAN_HINT", 1 );
        }
        
        wait 30;
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xf2c2c67b, Offset: 0x7090
// Size: 0x114
function gunship_health_watch()
{
    self endon( #"death" );
    n_health_percent = self.n_health_min;
    n_health_checkpoint = self.health - n_health_percent;
    n_health_half = self.health / 2;
    var_2f7d2047 = self.health * 0.75;
    self thread function_66246a8b();
    
    while ( true )
    {
        if ( self.health < n_health_checkpoint )
        {
            self notify( #"gunship_health_decreased" );
            n_health_checkpoint = self.health - n_health_percent;
        }
        
        if ( self.var_e7f801f1 >= 4 )
        {
            self notify( #"gunship_health_less_than_half" );
        }
        
        if ( self.var_e7f801f1 >= 2 )
        {
            self notify( #"hash_cf300440" );
        }
        
        wait 0.05;
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x6fa9fe8, Offset: 0x71b0
// Size: 0x74
function gunship_health_half_watch()
{
    self endon( #"death" );
    self.n_acceleration = 30;
    self waittill( #"gunship_health_less_than_half" );
    self.var_d24de693 = 1;
    self.n_acceleration = 54;
    self thread gunship_roof_transistion_increase();
    level scene::init( "cin_lot_17_oldfriend_3rd_sh010" );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x8235f29b, Offset: 0x7230
// Size: 0x2c
function gunship_roof_transistion_increase()
{
    self endon( #"death" );
    
    while ( true )
    {
        self notify( #"gunship_go_over_roof" );
        wait 10;
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xf7970e05, Offset: 0x7268
// Size: 0x7e
function function_66246a8b()
{
    self endon( #"death" );
    self waittill( #"hash_cf300440" );
    
    while ( true )
    {
        self.var_7c83c7b9 = 1;
        self waittill( #"hash_fe14afa0" );
        waittill_raps_left_alive();
        function_7a689af4();
        self function_fabd65a5();
        wait 40;
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xf1bbcc70, Offset: 0x72f0
// Size: 0x650
function gunship_roof_transition()
{
    self setspeed( 3 * self.settings.defaultmovespeed );
    var_166cf772 = [];
    var_34168a41 = [];
    var_736e1fad = [];
    a_raps_spawn_pos = getentarray( "raps_ship_pos", "targetname" );
    var_b78c14cc = getentarray( "raps_aim_pos", "targetname" );
    var_3df07ee9 = arraysortclosest( a_raps_spawn_pos, self.origin );
    var_3d2fc9e7 = arraysortclosest( var_b78c14cc, self.origin );
    
    if ( randomint( 100 ) < 50 )
    {
        str_side = "left";
    }
    else
    {
        str_side = "right";
    }
    
    var_e296d6b4 = get_raps_per_player() * level.players.size;
    
    foreach ( a_position in var_3df07ee9 )
    {
        if ( a_position.script_string == str_side )
        {
            var_34168a41[ var_34168a41.size ] = var_e296d6b4 / ( 3 - var_166cf772.size );
            var_e296d6b4 -= var_34168a41[ var_34168a41.size - 1 ];
            var_736e1fad[ var_736e1fad.size ] = a_position;
        }
    }
    
    foreach ( a_position in var_3d2fc9e7 )
    {
        if ( a_position.script_string == str_side )
        {
            var_166cf772[ var_166cf772.size ] = a_position;
        }
    }
    
    if ( self setvehgoalpos( var_736e1fad[ randomint( 2 ) ].origin, 1, 1 ) )
    {
        self setlookatent( var_736e1fad[ 2 ] );
        self.var_77116e68 = 1;
        self vehicle_ai::waittill_pathing_done();
    }
    
    wait 2;
    level clientfield::set( "city_sky", 1 );
    var_7099d5e = function_8a8d7d66();
    
    if ( isdefined( self.var_b5b6b568 ) && isdefined( self.var_1e900bbc ) && self.var_1e900bbc && self.var_b5b6b568 )
    {
        for ( j = 0; j < 3 ; j++ )
        {
            a_amws = getentarray( "gunship_amws_ai", "targetname" );
            
            if ( a_amws.size < var_7099d5e )
            {
                self.var_3e8f6c24 = var_166cf772[ j ].origin;
                self.var_6ded64ae = var_34168a41[ j ];
                self function_1f2b3ab5();
            }
        }
        
        wait 2;
    }
    
    for ( j = 0; j < 3 ; j++ )
    {
        a_raps = getentarray( "gunship_raps_ai", "targetname" );
        
        if ( a_raps.size < var_7099d5e )
        {
            self.var_3e8f6c24 = var_166cf772[ j ].origin;
            self.var_6ded64ae = var_34168a41[ j ];
            self gunship_raps_logic();
        }
    }
    
    wait 2;
    
    for ( j = 0; j < 3 ; j++ )
    {
        a_raps = getentarray( "gunship_raps_ai", "targetname" );
        
        if ( a_raps.size < var_7099d5e )
        {
            self.var_3e8f6c24 = var_166cf772[ j ].origin;
            self.var_6ded64ae = var_34168a41[ j ];
            self gunship_raps_logic();
        }
    }
    
    n_wait = 0.05;
    wait n_wait;
    self notify( #"hash_fe14afa0" );
    self.var_77116e68 = 0;
    self.var_b5b6b568 = 1;
    
    if ( isdefined( self.var_894468a1 ) && self.var_894468a1 )
    {
        self.var_1e900bbc = 0;
    }
    
    self.var_7c83c7b9 = 0;
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x1c33b76d, Offset: 0x7948
// Size: 0x19c
function gunship_over_roof_rumble()
{
    self endon( #"death" );
    self flag::set( "gunship_over_roof" );
    array::run_all( level.players, &playrumbleonentity, "damage_light" );
    wait 0.25;
    
    while ( self flag::get( "gunship_over_roof" ) )
    {
        array::run_all( level.players, &playrumbleonentity, "damage_heavy" );
        
        foreach ( player in level.players )
        {
            earthquake( 0.5, 0.15, player.origin, 64 );
        }
        
        wait 0.15;
    }
    
    array::run_all( level.players, &playrumbleonentity, "damage_light" );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x17365feb, Offset: 0x7af0
// Size: 0x34
function gunship_stop_rumble()
{
    self endon( #"death" );
    wait 2;
    self flag::clear( "gunship_over_roof" );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x9a47affe, Offset: 0x7b30
// Size: 0x64
function slightly_opposite_position()
{
    n_index_opp = ( self.n_index_goal + 3 ) % 6;
    
    if ( n_index_opp == 0 )
    {
        n_index_goto = 1;
    }
    else
    {
        n_index_goto = 2;
    }
    
    return n_index_goto;
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0xf4a809e9, Offset: 0x7ba0
// Size: 0x1e
function raps_spawning_timer( n_wait )
{
    wait n_wait;
    level notify( #"spawn_boss_raps" );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x7f153fc5, Offset: 0x7bc8
// Size: 0x1a0
function debug_gunship()
{
    self endon( #"death" );
    
    while ( true )
    {
        v_tag_origin = self gettagorigin( "tag_rocket1" );
        a_trace_1 = bullettrace( v_tag_origin, level.players[ 0 ].origin, 0, self );
        util::debug_line( v_tag_origin, level.players[ 0 ].origin, ( 1, 0, 0 ), 0.8, 0, 1 );
        v_tag_origin = self gettagorigin( "tag_rocket2" );
        a_trace_2 = bullettrace( v_tag_origin, level.players[ 0 ].origin, 0, self );
        util::debug_line( v_tag_origin, level.players[ 0 ].origin, ( 1, 0, 0 ), 0.8, 0, 1 );
        
        if ( a_trace_1[ "fraction" ] < 0.59 || a_trace_2[ "fraction" ] < 0.59 )
        {
            iprintlnbold( "don't shoot" );
        }
        
        wait 0.05;
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x5aba626c, Offset: 0x7d70
// Size: 0x3f4
function gunship_wasp_logic()
{
    self endon( #"death" );
    a_wasp = getentarray( "boss_wasp", "targetname" );
    a_wasp_alive = [];
    
    while ( true )
    {
        level waittill( #"spawn_boss_wasp" );
        
        if ( isdefined( self.e_target ) && self.e_target.sessionstate == "playing" )
        {
            a_wasp_alive = array::remove_undefined( a_wasp_alive );
            n_wasps_max = 4 * level.players.size;
            a_wasp_targets = level.players;
            
            foreach ( e_player in level.players )
            {
                if ( e_player != self.e_target )
                {
                    if ( !isdefined( a_wasp_targets ) )
                    {
                        a_wasp_targets = [];
                    }
                    else if ( !isarray( a_wasp_targets ) )
                    {
                        a_wasp_targets = array( a_wasp_targets );
                    }
                    
                    a_wasp_targets[ a_wasp_targets.size ] = e_player;
                }
            }
            
            n_target_index = 0;
            
            for ( i = 0; i < n_wasps_max ; i++ )
            {
                a_wasp_closest = arraysortclosest( a_wasp, a_wasp_targets[ n_target_index ].origin );
                ai_wasp = spawner::simple_spawn_single( a_wasp_closest[ 0 ] );
                ai_wasp.origin = self gettagorigin( "tag_bomb" );
                ai_wasp.angles = self gettagangles( "tag_bomb" );
                n_x_offset = randomint( 2 ) ? 256 : -256;
                n_y_offset = randomint( 2 ) ? 256 : -256;
                v_goal_pos = a_wasp_targets[ n_target_index ].origin + ( n_x_offset, n_y_offset, 64 );
                b_found_goal = ai_wasp setgoal( v_goal_pos, 1 );
                ai_wasp thread wait_to_cleargoal();
                
                if ( !isdefined( a_wasp_alive ) )
                {
                    a_wasp_alive = [];
                }
                else if ( !isarray( a_wasp_alive ) )
                {
                    a_wasp_alive = array( a_wasp_alive );
                }
                
                a_wasp_alive[ a_wasp_alive.size ] = ai_wasp;
                n_target_index++;
                
                if ( n_target_index == a_wasp_targets.size )
                {
                    n_target_index = 0;
                }
            }
            
            wait 15;
        }
        
        wait 0.05;
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x608ce4b9, Offset: 0x8170
// Size: 0x34
function wait_to_cleargoal()
{
    self endon( #"death" );
    self waittill( #"goal" );
    self clearforcedgoal();
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x17cb4b3, Offset: 0x81b0
// Size: 0x20c
function function_a6b9e99b()
{
    if ( isdefined( self.e_target ) )
    {
        var_9cb05100 = getentarray( "boss_minion_hunter", "targetname" );
        self.var_5a36be60 = function_f8f08291();
        
        for ( i = 0; i < function_f8f08291() ; i++ )
        {
            ai_hunter = spawner::simple_spawn_single( var_9cb05100[ 0 ] );
            ai_hunter thread watch_for_death( self );
            ai_hunter thread watch_for_team_change( self );
            ai_hunter vehicle_ai::set_state( "scripted" );
            ai_hunter.origin = self gettagorigin( "tag_bomb" );
            ai_hunter.angles = self gettagangles( "tag_bomb" );
            var_63055781 = ( ai_hunter.origin[ 0 ], ai_hunter.origin[ 1 ], ai_hunter.origin[ 2 ] - 600 );
            ai_hunter set_veh_goal_pos( var_63055781, 1, 1 );
            ai_hunter waittill( #"near_goal" );
            ai_hunter vehicle_ai::set_state( "combat" );
            wait 0.05;
        }
        
        self.var_382c873 = 1;
    }
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0xc393bb98, Offset: 0x83c8
// Size: 0x28
function watch_for_death( gunship )
{
    self waittill( #"death" );
    gunship.var_5a36be60--;
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0xcb339464, Offset: 0x83f8
// Size: 0x60
function watch_for_team_change( gunship )
{
    self endon( #"death" );
    oldteam = self.team;
    
    while ( true )
    {
        if ( oldteam != self.team )
        {
            break;
        }
        
        wait 5;
    }
    
    gunship.var_5a36be60--;
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xf03a2ce1, Offset: 0x8460
// Size: 0x214
function gunship_raps_logic()
{
    if ( isdefined( self.e_target ) && isplayer( self.e_target ) && self.e_target.sessionstate == "playing" )
    {
        assert( isdefined( self.var_3e8f6c24 ) );
        assert( isdefined( self.var_6ded64ae ) );
        var_6ee22718 = self.var_6ded64ae;
        self playsound( "veh_raps_launch" );
        
        for ( i = 0; i < var_6ee22718 ; i++ )
        {
            ai_raps = spawner::simple_spawn_single( "gunship_raps" );
            
            if ( ai_raps.archetype == "raps" )
            {
                ai_raps.var_2f8cff2 = 1;
            }
            
            ai_raps.origin = self gettagorigin( "tag_origin" ) + ( 0, 0, 512 );
            ai_raps util::set_rogue_controlled();
            ai_raps clientfield::set( "play_raps_trail_fx", 1 );
            ai_raps thread function_853d3b2b( self.var_3e8f6c24 );
            wait 0.15;
        }
        
        level flag::set_val( "gunship_high_out_of_battle", 1 );
        level thread function_309d7a5a( array::random( level.var_ead3caed ) );
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xca5ee236, Offset: 0x8680
// Size: 0x1d0
function function_1f2b3ab5()
{
    if ( isdefined( self.e_target ) && isplayer( self.e_target ) && self.e_target.sessionstate == "playing" )
    {
        assert( isdefined( self.var_3e8f6c24 ) );
        assert( isdefined( self.var_6ded64ae ) );
        var_483569a0 = self.var_6ded64ae;
        self playsound( "veh_raps_launch" );
        
        for ( i = 0; i < var_483569a0 ; i++ )
        {
            ai_amws = spawner::simple_spawn_single( "gunship_amws" );
            ai_amws.origin = self gettagorigin( "tag_origin" ) + ( 0, 0, 512 );
            ai_amws util::set_rogue_controlled();
            ai_amws thread function_853d3b2b( self.var_3e8f6c24 );
            wait 0.15;
        }
        
        level flag::set_val( "gunship_high_out_of_battle", 1 );
        level thread function_309d7a5a( array::random( level.var_4483235d ) );
    }
    
    self.var_894468a1 = 1;
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0xcb57afca, Offset: 0x8858
// Size: 0xb4
function function_853d3b2b( var_ff72f147 )
{
    self endon( #"death" );
    self vehicle_ai::set_state( "scripted" );
    self launchvehicle( ( 0, 0, 200 ) );
    wait 1;
    self applyballistictarget( var_ff72f147 );
    self thread sndwaituntillanding( var_ff72f147 );
    wait 5.5;
    self vehicle_ai::set_state( "combat" );
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0xd02b36c0, Offset: 0x8918
// Size: 0x11c
function sndwaituntillanding( var_b748b5a5 )
{
    self endon( #"death" );
    self vehicle::toggle_sounds( 0 );
    
    if ( getdvarint( "tu1_lotusBossSkeetShoot", 1 ) )
    {
        while ( !isdefined( getclosestpointonnavmesh( self.origin, 200 ) ) )
        {
            wait 0.1;
        }
    }
    else
    {
        while ( distance( self.origin, var_b748b5a5 ) > 400 )
        {
            wait 0.1;
        }
    }
    
    if ( isdefined( self.var_2f8cff2 ) )
    {
        self.var_2f8cff2 = 0;
    }
    
    self playsound( "veh_raps_first_land" );
    self clientfield::set( "play_raps_trail_fx", 0 );
    self vehicle::toggle_sounds( 1 );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x7d76ad6f, Offset: 0x8a40
// Size: 0xaa
function get_raps_per_player()
{
    switch ( level.players.size )
    {
        case 1:
            n_count = 3;
            break;
        case 2:
            n_count = 2;
            break;
        case 3:
            n_count = 2;
            break;
        case 4:
            n_count = 2;
            break;
        default:
            break;
    }
    
    return n_count;
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x5ba1ca7c, Offset: 0x8af8
// Size: 0x8a
function function_8a8d7d66()
{
    switch ( level.players.size )
    {
        case 1:
            n_count = 12;
            break;
        case 2:
            n_count = 20;
            break;
        case 3:
            n_count = 24;
            break;
        case 4:
            n_count = 32;
            break;
        default:
            break;
    }
    
    return n_count;
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xc524f9a0, Offset: 0x8b90
// Size: 0xaa
function function_f8f08291()
{
    switch ( level.players.size )
    {
        case 1:
            n_count = 1;
            break;
        case 2:
            n_count = 2;
            break;
        case 3:
            n_count = 2;
            break;
        case 4:
            n_count = 3;
            break;
        default:
            break;
    }
    
    return n_count;
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xfa2e9c0a, Offset: 0x8c48
// Size: 0x492
function gunship_missile_attack_logic()
{
    self endon( #"death" );
    self endon( #"end_missile_attack" );
    n_missile_set_max = level.activeplayers.size;
    
    if ( isdefined( self.gunship_targets ) && self.gunship_targets.size != 0 )
    {
        n_missile_set_max = self.gunship_targets.size;
    }
    
    self setgunnerturretontargetrange( 0, 1 );
    self setgunnerturretontargetrange( 1, 1 );
    n_missile_set_count = 0;
    self.n_missiles_launched = 0;
    
    if ( isdefined( self.e_target ) && !level flag::get( "gunship_high_out_of_battle" ) )
    {
        playsoundatposition( "evt_boss_rocket_prime", self.origin );
        self notify( #"hash_2e91796b" );
        self playsoundwithnotify( "evt_boss_rocket_charge", "sound_done" );
        self waittill( #"sound_done" );
        level thread function_309d7a5a( array::random( level.kane_missiles ) );
        
        if ( !level flag::get( "first_missile_fired_vo" ) )
        {
            level flag::set( "first_missile_fired_vo" );
        }
        
        v_forward = anglestoforward( self.angles );
        v_origin_1 = self gettagorigin( "tag_gunner_turret1" );
        v_target_pos_1 = v_origin_1 + v_forward * 1024;
        self setgunnertargetvec( v_target_pos_1, 0 );
        v_origin_2 = self gettagorigin( "tag_gunner_turret2" );
        v_target_pos_2 = v_origin_2 + v_forward * 1024;
        self setgunnertargetvec( v_target_pos_2, 1 );
        self waittill( #"gunner_turret_on_target" );
        
        for ( i = 0; i < n_missile_set_max ; i++ )
        {
            wait 0.1;
            self gunship_fire_missile( 0 );
            wait 0.1;
            self gunship_fire_missile( 1 );
        }
        
        wait 1;
        
        foreach ( e_player in level.players )
        {
            if ( isdefined( e_player.e_fake ) )
            {
                e_player.e_fake unlink();
            }
        }
        
        self util::waittill_notify_or_timeout( "all_missiles_destroyed", 6.45 );
        self thread attack_thread_mainturret();
        n_missile_set_count = 0;
        
        foreach ( e_player in level.players )
        {
            if ( isdefined( e_player.e_fake ) )
            {
                e_player.e_fake delete();
            }
        }
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x477ed191, Offset: 0x90e8
// Size: 0x1a4
function gunship_wait_to_fire_missiles()
{
    v_tag_origin = self gettagorigin( "tag_rocket1" );
    a_trace_1 = bullettrace( v_tag_origin, self.e_target.origin, 0, self );
    v_tag_origin = self gettagorigin( "tag_rocket2" );
    
    for ( a_trace_2 = bullettrace( v_tag_origin, self.e_target.origin, 0, self ); a_trace_1[ "fraction" ] < 0.59 || a_trace_2[ "fraction" ] < 0.59 ; a_trace_2 = bullettrace( v_tag_origin, self.e_target.origin, 0, self ) )
    {
        wait 0.05;
        v_tag_origin = self gettagorigin( "tag_rocket1" );
        a_trace_1 = bullettrace( v_tag_origin, self.e_target.origin, 0, self );
        v_tag_origin = self gettagorigin( "tag_rocket2" );
    }
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0xe3566370, Offset: 0x9298
// Size: 0x10c
function gunship_fire_missile( n_gunner_index )
{
    e_target = self gunship_missile_target();
    n_tag_id = n_gunner_index + 1;
    str_tag = "tag_rocket" + n_tag_id;
    v_tag_origin = self gettagorigin( str_tag );
    w_gunship_cannon = getweapon( "gunship_cannon" );
    e_missile = magicbullet( w_gunship_cannon, v_tag_origin, v_tag_origin + ( 0, 0, 1024 ), self, e_target );
    e_missile thread gunship_missile_death_logic( self );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x6a1cdceb, Offset: 0x93b0
// Size: 0x15c
function gunship_missile_target()
{
    e_missile_target = undefined;
    
    if ( isdefined( self.e_override_missile_target ) )
    {
        e_missile_target = self.e_override_missile_target;
    }
    else
    {
        a_targets = arraysortclosest( self.gunship_targets, level.s_mobile_shop.v_origin );
        n_mod = int( self.n_missiles_launched / 2 );
        
        if ( n_mod >= a_targets.size )
        {
            n_mod = a_targets.size - 1;
        }
        
        e_target = a_targets[ n_mod ];
        
        if ( !isdefined( e_target.e_fake ) )
        {
            e_target.e_fake = spawn( "script_model", e_target.origin, 0 );
            e_target.e_fake linkto( e_target );
        }
        
        e_missile_target = e_target.e_fake;
    }
    
    self.n_missiles_launched++;
    return e_missile_target;
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0xa0806f05, Offset: 0x9518
// Size: 0x4c
function gunship_missile_death_logic( vh_gunship )
{
    self waittill( #"death" );
    vh_gunship.n_missiles_launched--;
    
    if ( vh_gunship.n_missiles_launched == 0 )
    {
        vh_gunship notify( #"all_missiles_destroyed" );
    }
}

// Namespace lotus_boss_battle
// Params 3
// Checksum 0xb9fc0a64, Offset: 0x9570
// Size: 0x74
function set_veh_goal_pos( v_origin, b_stop, b_navigation )
{
    n_goal_found = self setvehgoalpos( v_origin, b_stop );
    
    /#
        if ( !( isdefined( n_goal_found ) && n_goal_found ) )
        {
            iprintlnbold( "<dev string:x81>" );
        }
    #/
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0x9e56c304, Offset: 0x95f0
// Size: 0x3c0
function gunship_path_logic( n_index_goal )
{
    self endon( #"death" );
    self notify( #"end_previous_path_logic" );
    self endon( #"end_previous_path_logic" );
    self.n_index_goal = n_index_goal;
    str_goal_name = "gunship_pos_" + self.n_index_goal;
    str_target_name = str_goal_name;
    str_traverse = "clockwise";
    s_gunship_position = struct::get( "gunship_pos_" + self.n_index_current, "targetname" );
    
    if ( self.n_index_current != self.n_index_goal )
    {
        self flag::clear( "gunship_can_shoot" );
        str_traverse = self gunship_traverse_path();
        
        if ( str_traverse == "counterclockwise" )
        {
            str_target_name = self gunship_path_counterclockwise( s_gunship_position, str_goal_name );
        }
        else
        {
            str_target_name = self gunship_path_clockwise( s_gunship_position, str_goal_name );
        }
        
        self flag::set( "gunship_can_shoot" );
    }
    
    s_position = struct::get( str_target_name, "targetname" );
    s_position_left = struct::get( s_position.target, "targetname" );
    s_position_right = struct::get( s_position.script_string, "targetname" );
    
    while ( true )
    {
        self notify( #"gunship_in_position" );
        self.n_index_next = s_position.script_int;
        self set_veh_goal_pos( s_position.origin, 0, 1 );
        self waittill( #"near_goal" );
        self.n_index_prev = self.n_index_current;
        self.n_index_current = s_position.script_int;
        
        if ( str_traverse == "counterclockwise" )
        {
            self.n_index_next = s_position_right.script_int;
            self set_veh_goal_pos( s_position_right.origin, 1, 1 );
            self waittill( #"near_goal" );
            self.n_index_prev = self.n_index_current;
            self.n_index_current = s_position_right.script_int;
            str_traverse = "clockwise";
        }
        else
        {
            self.n_index_next = s_position_left.script_int;
            self set_veh_goal_pos( s_position_left.origin, 1, 1 );
            self waittill( #"near_goal" );
            self.n_index_prev = self.n_index_current;
            self.n_index_current = s_position_left.script_int;
            str_traverse = "counterclockwise";
        }
        
        wait 0.05;
    }
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x4ab9ff7c, Offset: 0x99b8
// Size: 0xd8
function gunship_traverse_path()
{
    n_clockwise = 5 - self.n_index_current;
    
    if ( self.n_index_current > self.n_index_goal )
    {
        n_clockwise += self.n_index_goal + 1;
    }
    
    n_counterclockwise = self.n_index_current - self.n_index_goal;
    
    if ( self.n_index_current < self.n_index_goal )
    {
        n_counterclockwise += 6;
    }
    
    if ( n_counterclockwise < n_clockwise )
    {
        str_traverse = "counterclockwise";
    }
    else
    {
        str_traverse = "clockwise";
    }
    
    return str_traverse;
}

// Namespace lotus_boss_battle
// Params 2
// Checksum 0x49ffae14, Offset: 0x9a98
// Size: 0xfc
function gunship_path_clockwise( s_gunship_position, str_goal_name )
{
    for ( str_target_name = s_gunship_position.target; str_target_name != str_goal_name ; str_target_name = s_position.target )
    {
        s_position = struct::get( str_target_name, "targetname" );
        self.n_index_next = s_position.script_int;
        self set_veh_goal_pos( s_position.origin, 0, 1 );
        self waittill( #"near_goal" );
        self.n_index_prev = self.n_index_current;
        self.n_index_current = s_position.script_int;
    }
    
    return str_target_name;
}

// Namespace lotus_boss_battle
// Params 2
// Checksum 0x4d3cb10b, Offset: 0x9ba0
// Size: 0xfc
function gunship_path_counterclockwise( s_gunship_position, str_goal_name )
{
    for ( str_target_name = s_gunship_position.script_string; str_target_name != str_goal_name ; str_target_name = s_position.script_string )
    {
        s_position = struct::get( str_target_name, "targetname" );
        self.n_index_next = s_position.script_int;
        self set_veh_goal_pos( s_position.origin, 0, 1 );
        self waittill( #"near_goal" );
        self.n_index_prev = self.n_index_current;
        self.n_index_current = s_position.script_int;
    }
    
    return str_target_name;
}

// Namespace lotus_boss_battle
// Params 1, eflags: 0x4
// Checksum 0x919c9332, Offset: 0x9ca8
// Size: 0x12c, Type: bool
function private is_gunship_target_valid( target )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( isplayer( target ) && target.sessionstate == "spectator" )
    {
        return false;
    }
    
    if ( isplayer( target ) && target.sessionstate == "intermission" )
    {
        return false;
    }
    
    if ( isdefined( self.intermission ) && self.intermission )
    {
        return false;
    }
    
    if ( isdefined( target.ignoreme ) && target.ignoreme )
    {
        return false;
    }
    
    if ( target isnotarget() )
    {
        return false;
    }
    
    if ( self.team == target.team )
    {
        return false;
    }
    
    return true;
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x46392c7f, Offset: 0x9de0
// Size: 0x12c
function update_gunship_targets()
{
    self endon( #"death" );
    pruned_target_list = [];
    
    do
    {
        target_list = arraycombine( level.players, getaiteamarray( "allies" ), 0, 0 );
        
        if ( target_list.size > 0 )
        {
            foreach ( gunship_target in target_list )
            {
                if ( is_gunship_target_valid( gunship_target ) )
                {
                    pruned_target_list[ pruned_target_list.size ] = gunship_target;
                }
            }
        }
        
        wait 0.05;
    }
    while ( pruned_target_list.size == 0 );
    
    self.gunship_targets = pruned_target_list;
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0x1be9a7b8, Offset: 0x9f18
// Size: 0x2a0
function gunship_target_logic()
{
    self endon( #"death" );
    self update_gunship_targets();
    self.e_target = self.gunship_targets[ 0 ];
    
    if ( !( isdefined( self.var_77116e68 ) && self.var_77116e68 ) && isdefined( self.e_target ) )
    {
        self setlookatent( self.e_target );
    }
    
    while ( !isdefined( level.s_mobile_shop ) )
    {
        wait 0.05;
    }
    
    while ( true )
    {
        self update_gunship_targets();
        e_gunship_target = self.gunship_targets[ 0 ];
        
        if ( isdefined( e_gunship_target ) )
        {
            n_dist_sq_min = distance2dsquared( e_gunship_target.origin, level.s_mobile_shop.v_origin );
        }
        
        foreach ( target in self.gunship_targets )
        {
            n_dist_sq = distance2dsquared( target.origin, level.s_mobile_shop.v_origin );
            
            if ( n_dist_sq < n_dist_sq_min )
            {
                e_gunship_target = target;
                n_dist_sq_min = n_dist_sq;
            }
        }
        
        if ( isdefined( self.e_target ) && isdefined( e_gunship_target ) && e_gunship_target != self.e_target )
        {
            self.e_target = e_gunship_target;
        }
        else if ( !is_gunship_target_valid( self.e_target ) )
        {
            self.e_target = undefined;
            
            if ( isdefined( e_gunship_target ) )
            {
                self.e_target = e_gunship_target;
            }
        }
        
        if ( !( isdefined( self.var_77116e68 ) && self.var_77116e68 ) && isdefined( self.e_target ) )
        {
            self setlookatent( self.e_target );
        }
        
        wait 0.5;
    }
}

// Namespace lotus_boss_battle
// Params 15
// Checksum 0x16a5c068, Offset: 0xa1c0
// Size: 0x23c
function gunship_damage_override( e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, v_damage_origin, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name, v_surface_normal )
{
    switch ( level.players.size )
    {
        case 1:
            n_damage = int( n_damage * 3 );
            break;
        case 2:
            n_damage = int( n_damage * 2.25 );
            break;
        case 3:
            n_damage = int( n_damage * 1.5 );
            break;
        case 4:
            n_damage = int( n_damage * 1 );
            break;
        default:
            break;
    }
    
    n_health_after_damage = self.health - n_damage;
    
    if ( self.health < self.n_health_min )
    {
        n_damage = 0;
    }
    else if ( n_health_after_damage < self.n_health_min )
    {
        n_damage = self.health - self.n_health_min + 1;
    }
    
    if ( isdefined( self.var_e507c83f[ str_part_name ] ) && self.var_e507c83f[ str_part_name ] )
    {
        if ( n_damage > 0 )
        {
            self thread function_1ccd0b11( str_part_name );
        }
    }
    else
    {
        n_damage = 0;
    }
    
    return n_damage;
}

// Namespace lotus_boss_battle
// Params 1
// Checksum 0xb2bff3cb, Offset: 0xa408
// Size: 0x1e6
function function_1ccd0b11( part_name )
{
    self endon( #"death" );
    
    switch ( part_name )
    {
        case "tag_target_fan_left_outer":
            if ( !self clientfield::get( "boss_left_outer_fx" ) )
            {
                self clientfield::set( "boss_left_outer_fx", 1 );
                wait 0.2;
                self clientfield::set( "boss_left_outer_fx", 0 );
            }
            
            break;
        case "tag_target_fan_left_inner":
            if ( !self clientfield::get( "boss_left_inner_fx" ) )
            {
                self clientfield::set( "boss_left_inner_fx", 1 );
                wait 0.2;
                self clientfield::set( "boss_left_inner_fx", 0 );
            }
            
            break;
        case "tag_target_fan_right_inner":
            if ( !self clientfield::get( "boss_right_inner_fx" ) )
            {
                self clientfield::set( "boss_right_inner_fx", 1 );
                wait 0.2;
                self clientfield::set( "boss_right_inner_fx", 0 );
            }
            
            break;
        default:
            if ( !self clientfield::get( "boss_right_outer_fx" ) )
            {
                self clientfield::set( "boss_right_outer_fx", 1 );
                wait 0.2;
                self clientfield::set( "boss_right_outer_fx", 0 );
            }
            
            break;
    }
}

// Namespace lotus_boss_battle
// Params 4
// Checksum 0xe762999f, Offset: 0xa5f8
// Size: 0x54
function boss_battle_done( str_objective, b_starting, b_direct, player )
{
    objectives::complete( "cp_level_lotus_leviathan" );
    objectives::complete( "cp_level_lotus_leviathan_destroy" );
}

// Namespace lotus_boss_battle
// Params 0
// Checksum 0xabafcb4b, Offset: 0xa658
// Size: 0xb2
function function_428ff2f()
{
    var_f29f9112 = getentarray( "roof_ammo_caches", "prefabname" );
    
    foreach ( cache in var_f29f9112 )
    {
        cache show();
    }
}

