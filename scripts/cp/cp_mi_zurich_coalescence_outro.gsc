#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_coalescence_root_cinematics;
#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_hq;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_globallogic_player;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/music_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace zurich_outro;

// Namespace zurich_outro
// Params 2
// Checksum 0xf0dcf114, Offset: 0xde0
// Size: 0x8c
function function_8c381165( str_objective, b_starting )
{
    load::function_73adcefc();
    load::function_a2995f22();
    skipto::teleport_players( str_objective, 0 );
    
    if ( !( isdefined( level.var_a2c60984 ) && level.var_a2c60984 ) )
    {
        level function_4fa5eed();
    }
    
    skipto::objective_completed( str_objective );
}

// Namespace zurich_outro
// Params 4
// Checksum 0x3135cc99, Offset: 0xe78
// Size: 0x24
function function_7c294f88( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace zurich_outro
// Params 0
// Checksum 0xf7c02a42, Offset: 0xea8
// Size: 0xe4
function function_4fa5eed()
{
    util::screen_fade_out( 0 );
    array::thread_all( level.players, &function_73b35f7b, 1 );
    wait 1;
    level thread function_4163ce88();
    
    if ( isdefined( level.bzm_zurichdialogue21callback ) )
    {
        level thread [[ level.bzm_zurichdialogue21callback ]]();
    }
    
    root_cinematics::function_c7ab7e12( "cp_zurich_fs_flyaway" );
    level util::screen_fade_out( 0, "white" );
    array::thread_all( level.players, &function_ba91aecf );
}

// Namespace zurich_outro
// Params 0
// Checksum 0xa32c9e52, Offset: 0xf98
// Size: 0x104
function function_4163ce88()
{
    level endon( #"movie_done" );
    wait 0.2;
    level dialog::remote( "tcor_it_s_all_wrong_0", 1, "NO_DNI" );
    level dialog::remote( "tcor_it_was_supposed_to_m_0", 1, "NO_DNI" );
    level dialog::remote( "tcor_there_s_so_much_nois_0", 1, "NO_DNI" );
    level dialog::remote( "tcor_i_don_t_even_know_yo_0", 1, "NO_DNI" );
    level dialog::remote( "tcor_who_are_you_0", 1, "NO_DNI" );
}

// Namespace zurich_outro
// Params 2
// Checksum 0xece0228, Offset: 0x10a8
// Size: 0x1dc
function function_618d5a98( str_objective, b_starting )
{
    level flag::wait_till( "all_players_spawned" );
    util::set_streamer_hint( 9 );
    util::screen_fade_out( 0, "white" );
    scene::add_scene_func( "cin_zur_20_01_plaza_1st_fight_it_player_end", &function_c5c8c18b, "play" );
    scene::add_scene_func( "cin_zur_20_01_plaza_1st_fight_it", &function_feb59ad0, "init" );
    level scene::init( "cin_zur_20_01_plaza_1st_fight_it" );
    level scene::init( "cin_zur_20_01_plaza_1st_fight_it_player_end" );
    level scene::init( "cin_zur_20_01_plaza_1st_fight_it_player_start" );
    level thread zurich_util::player_weather( 0 );
    level thread zurich_util::enable_surreal_ai_fx( 0 );
    array::thread_all( level.players, &function_354b619b, 1 );
    level clientfield::set( "gameplay_started", 1 );
    level function_2e5f51e9();
    skipto::objective_completed( str_objective );
}

// Namespace zurich_outro
// Params 4
// Checksum 0xe408c32e, Offset: 0x1290
// Size: 0x24
function function_d9ccb9e3( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace zurich_outro
// Params 2
// Checksum 0x92af599c, Offset: 0x12c0
// Size: 0x2dc
function function_313f113( str_objective, b_starting )
{
    level flag::wait_till( "all_players_spawned" );
    level flag::init( "atrium_hack_objective_start" );
    
    if ( b_starting )
    {
        util::screen_fade_out( 0, "black" );
        array::thread_all( level.players, &function_354b619b, 0 );
        level thread zurich_util::enable_surreal_ai_fx( 0 );
        skipto::teleport_players( str_objective, 0 );
        wait 2;
        level thread util::screen_fade_in( 2, "black" );
        level thread function_81b8760e();
    }
    
    setdvar( "r_skyRotation", 244 );
    
    if ( isdefined( level.bzm_zurichdialogue23callback ) )
    {
        level thread [[ level.bzm_zurichdialogue23callback ]]();
    }
    
    level scene::init( "p7_fxanim_cp_zurich_coalescence_tower_door_exit_bundle" );
    level thread function_51e389ee();
    umbragate_set( "hq_exit_umbra_gate", 1 );
    umbragate_set( "hq_atrium_umbra_gate", 1 );
    level thread zurich_util::function_11b424e5( 1 );
    array::thread_all( level.players, &larry_the_limper );
    level flag::set( "flag_enable_zurich_ending" );
    level thread function_5cd9d899();
    level thread function_b56fbb21();
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        level thread function_3ec4c691();
    }
    else
    {
        level thread function_1cc6775d();
    }
    
    level thread function_4590fc90();
    level thread function_2381bb7();
    level thread zurich_util::function_df1fc23b( 0 );
}

// Namespace zurich_outro
// Params 4
// Checksum 0xf5c3ee31, Offset: 0x15a8
// Size: 0x24
function function_f2f0f1ec( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace zurich_outro
// Params 0
// Checksum 0xb46ce9d7, Offset: 0x15d8
// Size: 0x11c
function function_51e389ee()
{
    s_start = struct::get( "outro_stairs_door_breadcrumb" );
    objectives::set( "cp_waypoint_breadcrumb", s_start );
    level flag::wait_till( "flag_open_atrium_exit_door" );
    objectives::complete( "cp_waypoint_breadcrumb" );
    s_end = struct::get( "outro_lobby_door_struct_trig" );
    objectives::set( "cp_waypoint_breadcrumb", s_end );
    zurich_util::function_1b3dfa61( "outro_lobby_door_struct_trig", undefined, 256 );
    objectives::complete( "cp_waypoint_breadcrumb" );
    wait 0.05;
    level flag::set( "atrium_hack_objective_start" );
}

// Namespace zurich_outro
// Params 0
// Checksum 0xa1a1ba08, Offset: 0x1700
// Size: 0x1a4
function function_5cd9d899()
{
    level endon( #"flag_start_zurich_outro" );
    level thread function_c0ced31c();
    level flag::wait_till( "flag_taylor_outro_vo_01" );
    level dialog::remote( "tayr_listen_only_to_the_s_0", 1, "NO_DNI" );
    level dialog::remote( "tayr_let_your_mind_relax_0", 1, "NO_DNI" );
    level flag::wait_till( "flag_taylor_outro_vo_02" );
    level dialog::remote( "tayr_let_your_thoughts_dr_0", 1, "NO_DNI" );
    level dialog::remote( "tayr_let_the_bad_memories_0", 1, "NO_DNI" );
    level flag::wait_till( "flag_taylor_outro_vo_03" );
    level dialog::remote( "tayr_let_peace_be_upon_yo_0", 1, "NO_DNI" );
    level dialog::remote( "tayr_you_are_in_control_0", 1, "NO_DNI" );
}

// Namespace zurich_outro
// Params 0
// Checksum 0xa5d5588d, Offset: 0x18b0
// Size: 0x4c
function function_c0ced31c()
{
    level endon( #"flag_start_zurich_outro" );
    zurich_util::function_1b3dfa61( "hq_outro_vo_03_struct_trig", undefined, 256 );
    level flag::set( "flag_taylor_outro_vo_03" );
}

// Namespace zurich_outro
// Params 1
// Checksum 0x9ead3384, Offset: 0x1908
// Size: 0xc4
function function_354b619b( var_495fe8ae )
{
    self endon( #"disconnect" );
    w_pistol = getweapon( "pistol_standard" );
    self takeallweapons();
    self giveweapon( w_pistol );
    self switchtoweaponimmediate( w_pistol );
    
    if ( var_495fe8ae )
    {
        level waittill( #"hash_d0254e87" );
    }
    
    self setweaponammoclip( w_pistol, 5 );
    self setweaponammostock( w_pistol, 0 );
}

// Namespace zurich_outro
// Params 0
// Checksum 0x739aa0dc, Offset: 0x19d8
// Size: 0x2ac
function function_2e5f51e9()
{
    scene::add_scene_func( "cin_zur_20_01_plaza_1st_fight_it", &zurich_util::function_f3e247d6, "play" );
    scene::add_scene_func( "cin_zur_20_01_plaza_1st_fight_it_player_start", &function_8cd36a50, "play" );
    level thread function_6b79134a();
    level thread function_e2a2e56e();
    level thread function_cbc763a7();
    level thread function_f0e5d1d();
    level thread util::screen_fade_in( 2, "white" );
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        array::thread_all( level.players, &clientfield::increment_to_player, "postfx_futz" );
    }
    
    level thread scene::play( "cin_zur_20_01_plaza_1st_fight_it" );
    
    if ( isdefined( level.bzm_hideallmagicboxescallback ) )
    {
        level thread [[ level.bzm_hideallmagicboxescallback ]]();
    }
    
    if ( isdefined( level.bzm_zurichdialogue22callback ) )
    {
        level thread [[ level.bzm_zurichdialogue22callback ]]();
    }
    
    level thread namespace_67110270::function_b01ef29c();
    level scene::play( "cin_zur_20_01_plaza_1st_fight_it_player_start" );
    var_a3612ddd = 0;
    
    foreach ( player in level.players )
    {
        var_a3612ddd++;
        player thread function_4f4dfd03( var_a3612ddd );
    }
    
    level waittill( #"hash_ce40edcd" );
    level scene::play( "cin_zur_20_01_plaza_1st_fight_it_player_end" );
    level util::teleport_players_igc( "server_interior" );
    util::clear_streamer_hint();
}

// Namespace zurich_outro
// Params 0
// Checksum 0xe56ed5e2, Offset: 0x1c90
// Size: 0x54
function function_6b79134a()
{
    level waittill( #"hash_e160de52" );
    exploder::exploder( "serverrm_corvuscorelight" );
    level waittill( #"hash_3d45f38a" );
    exploder::stop_exploder( "serverrm_corvuscorelight" );
}

// Namespace zurich_outro
// Params 1
// Checksum 0x704e90a2, Offset: 0x1cf0
// Size: 0xdc
function function_feb59ad0( a_ents )
{
    e_light = getent( "corvusGut", "targetname" );
    var_f4a14f07 = a_ents[ "corvus" ];
    v_angles = var_f4a14f07 gettagangles( "j_spine4" );
    v_angles += ( 90, 0, 0 );
    v_origin = ( 0, -10, 0 );
    
    if ( isdefined( var_f4a14f07 ) )
    {
        e_light linkto( var_f4a14f07, "j_spine4", v_origin, v_angles );
    }
}

// Namespace zurich_outro
// Params 1
// Checksum 0x89a40350, Offset: 0x1dd8
// Size: 0x74
function function_8cd36a50( a_ents )
{
    e_player = a_ents[ "player 1" ];
    wait 1;
    
    if ( isdefined( e_player ) )
    {
        e_player cybercom::cybercom_armpulse( 1 );
        e_player playrumbleonentity( "damage_heavy" );
    }
}

// Namespace zurich_outro
// Params 1
// Checksum 0x7d8affc6, Offset: 0x1e58
// Size: 0x7c
function function_c5c8c18b( a_ents )
{
    e_player = a_ents[ "player 1" ];
    level waittill( #"hash_e3f86dc" );
    
    if ( isdefined( e_player ) )
    {
        e_player cybercom::cybercom_armpulse( 1 );
        e_player playrumbleonentity( "cp_infection_hideout_stretch" );
    }
}

// Namespace zurich_outro
// Params 0
// Checksum 0xd0266281, Offset: 0x1ee0
// Size: 0x12
function function_a3652dec()
{
    level notify( #"hash_e69e5818" );
}

// Namespace zurich_outro
// Params 0
// Checksum 0x1b743f28, Offset: 0x1f00
// Size: 0x4c
function function_e2a2e56e()
{
    level scene::init( "p7_fxanim_cp_zurich_server_room_debris_bundle" );
    level waittill( #"hash_2a9df746" );
    level scene::play( "p7_fxanim_cp_zurich_server_room_debris_bundle" );
}

// Namespace zurich_outro
// Params 0
// Checksum 0xb05657db, Offset: 0x1f58
// Size: 0x44
function function_f0e5d1d()
{
    hidemiscmodels( "server_interior_dead_bodies" );
    level waittill( #"dead_bodies" );
    showmiscmodels( "server_interior_dead_bodies" );
}

// Namespace zurich_outro
// Params 0
// Checksum 0xf2c66af3, Offset: 0x1fa8
// Size: 0xc4
function function_cbc763a7()
{
    var_ddc9cb80 = getent( "server_interior_igc_wiping_screen", "targetname" );
    var_cb8cc4ef = getent( "server_interior_igc_wiped_screen", "targetname" );
    var_cb8cc4ef hide();
    level waittill( #"hash_fefb8213" );
    var_cb8cc4ef show();
    var_ddc9cb80 hide();
    level thread function_81b8760e();
}

// Namespace zurich_outro
// Params 1
// Checksum 0xc31bc267, Offset: 0x2078
// Size: 0x1ba
function function_4f4dfd03( var_a3612ddd )
{
    self setinvisibletoall();
    level notify( #"hash_2a9df746" );
    level notify( #"hash_d0254e87" );
    self freezecontrols( 1 );
    wait 0.15;
    str_origin = struct::get( "outro_server_scene_struct_0" + var_a3612ddd );
    var_ad470f8c = util::spawn_model( "tag_origin", str_origin.origin, str_origin.angles );
    self playerlinktodelta( var_ad470f8c, "tag_origin", 1, 20, 20, 15, 60 );
    self util::magic_bullet_shield();
    self freezecontrols( 0 );
    self thread function_e611368a();
    level waittill( #"hash_e0529ad4" );
    self util::stop_magic_bullet_shield();
    self unlink();
    var_ad470f8c delete();
    self setvisibletoall();
    level notify( #"hash_ce40edcd" );
}

// Namespace zurich_outro
// Params 0
// Checksum 0xb7ea1415, Offset: 0x2240
// Size: 0xbc
function function_b56fbb21()
{
    level flag::wait_till( "flag_open_atrium_exit_door" );
    a_door = getentarray( "hq_lobby_exit_clip", "targetname" );
    array::run_all( a_door, &movez, 100, 1.5 );
    array::run_all( a_door, &playsound, "evt_outro_atrium_door" );
    level thread function_36745581();
}

// Namespace zurich_outro
// Params 0
// Checksum 0x1caca02a, Offset: 0x2308
// Size: 0xbc
function function_36745581()
{
    var_2c578566 = spawn( "script_origin", ( -7389, 36096, 138 ) );
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        var_2c578566 playloopsound( "evt_bonuszm_zombies_dist", 1 );
    }
    else
    {
        var_2c578566 playloopsound( "evt_outro_vtol_dist", 1 );
    }
    
    level waittill( #"hash_8271ee50" );
    var_2c578566 stoploopsound( 7 );
}

// Namespace zurich_outro
// Params 0
// Checksum 0xa487a530, Offset: 0x23d0
// Size: 0xa4
function function_81b8760e()
{
    array::run_all( level.players, &setclientuivisibilityflag, "weapon_hud_visible", 0 );
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    level util::clientnotify( "sndPA" );
    array::thread_all( level.players, &function_51e85b80 );
    level thread connection_interrupted( 1 );
}

// Namespace zurich_outro
// Params 0
// Checksum 0xc9e5d8f5, Offset: 0x2480
// Size: 0x90
function function_e611368a()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    self endon( #"disconnect" );
    level endon( #"hash_e0529ad4" );
    
    while ( true )
    {
        self playrumbleonentity( "damage_light" );
        earthquake( 0.3, 0.5, self.origin, 128 );
        wait 0.25;
    }
}

// Namespace zurich_outro
// Params 0
// Checksum 0x1478d488, Offset: 0x2518
// Size: 0x424
function function_51e85b80()
{
    self endon( #"disconnect" );
    
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    self thread function_d06b32b2();
    self.var_322cc58c = self openluimenu( "DniWipe" );
    self setluimenudata( self.var_322cc58c, "frac", 0 );
    self setluimenudata( self.var_322cc58c, "Die", 0 );
    self setluimenudata( self.var_322cc58c, "percentage", 0 );
    self setluimenudata( self.var_322cc58c, "percentageVisible", 0 );
    wait 1;
    self setluimenudata( self.var_322cc58c, "duration", 10000 );
    self setluimenudata( self.var_322cc58c, "frac", 0 );
    self setluimenudata( self.var_322cc58c, "percentageVisible", 1 );
    wait 1;
    self setluimenudata( self.var_322cc58c, "frac", 0.2 );
    self thread function_865309a9( 20 );
    wait 10;
    level flag::wait_till( "flag_fill_purging_bar_40" );
    self setluimenudata( self.var_322cc58c, "frac", 0.4 );
    self thread function_865309a9( 40 );
    wait 10;
    level flag::wait_till( "flag_fill_purging_bar_60" );
    self setluimenudata( self.var_322cc58c, "frac", 0.6 );
    self thread function_865309a9( 60 );
    wait 10;
    level flag::wait_till( "flag_fill_purging_bar_80" );
    self setluimenudata( self.var_322cc58c, "frac", 0.8 );
    self thread function_865309a9( 80 );
    wait 10;
    level waittill( #"hash_2e3e5b0a" );
    self setluimenudata( self.var_322cc58c, "frac", 1 );
    self thread function_865309a9( 100 );
    wait 10;
    self setluimenudata( self.var_322cc58c, "frac", 1 );
    self setluimenudata( self.var_322cc58c, "percentageVisible", 0 );
    wait 0.1;
    self setluimenudata( self.var_322cc58c, "Die", 1 );
    wait 3;
    self closeluimenu( self.var_322cc58c );
}

// Namespace zurich_outro
// Params 1
// Checksum 0xa78e2ab4, Offset: 0x2948
// Size: 0x76
function function_865309a9( var_ea6d6bd2 )
{
    for ( i = var_ea6d6bd2 - 20; i < var_ea6d6bd2 + 1 ; i++ )
    {
        self setluimenudata( self.var_322cc58c, "percentage", i / 100 );
        wait 0.5;
    }
}

// Namespace zurich_outro
// Params 0
// Checksum 0x5d877b92, Offset: 0x29c8
// Size: 0x104
function function_d06b32b2()
{
    trigger::wait_till( "trig_hud_update_01", "targetname", self );
    level flag::set( "flag_taylor_outro_vo_01" );
    level flag::set( "flag_fill_purging_bar_40" );
    trigger::wait_till( "trig_hud_update_02", "targetname", self );
    level flag::set( "flag_taylor_outro_vo_02" );
    level flag::set( "flag_fill_purging_bar_60" );
    trigger::wait_till( "trig_hud_update_03", "targetname", self );
    level flag::set( "flag_fill_purging_bar_80" );
}

// Namespace zurich_outro
// Params 1
// Checksum 0x8316291, Offset: 0x2ad8
// Size: 0x64
function connection_interrupted( is_on )
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    if ( isdefined( is_on ) && is_on )
    {
        level thread zurich_util::function_5f63b2f1( 1 );
        return;
    }
    
    level thread zurich_util::function_5f63b2f1( 0 );
}

// Namespace zurich_outro
// Params 0
// Checksum 0x9ce0372a, Offset: 0x2b48
// Size: 0x29c
function function_1cc6775d()
{
    scene::add_scene_func( "cin_zur_20_01_plaza_1st_commander", &function_95ed5d29, "play" );
    scene::add_scene_func( "cin_zur_20_01_plaza_1st_commander", &function_a947c3b3, "done" );
    level flag::wait_till( "atrium_hack_objective_start" );
    level thread function_80c5347c();
    level thread function_f568befc();
    spawner::add_global_spawn_function( "allies", &util::ai_frost_breath );
    var_5cca3f31 = getent( "trig_enable_zuirch_ending", "targetname" );
    e_who = var_5cca3f31 zurich_util::function_d1996775();
    level thread zurich_util::function_df1fc23b( 1 );
    level notify( #"hash_21ddc441" );
    level zurich_util::player_weather( 1, "reverse_snow" );
    level flag::set( "flag_start_zurich_outro" );
    level notify( #"hash_8271ee50" );
    music::setmusicstate( "none" );
    level util::clientnotify( "sndPA" );
    level thread audio::unlockfrontendmusic( "mus_coalescence_theme_intro" );
    level thread audio::unlockfrontendmusic( "mus_through_the_trees_intro" );
    level thread audio::unlockfrontendmusic( "mus_i_live_orchestral_intro" );
    level thread audio::unlockfrontendmusic( "mus_unstoppable_intro" );
    level clientfield::set( "gameplay_started", 0 );
    level thread scene::play( "cin_zur_20_01_plaza_1st_commander", e_who );
}

// Namespace zurich_outro
// Params 1
// Checksum 0x11b5d634, Offset: 0x2df0
// Size: 0xd4
function function_95ed5d29( a_ents )
{
    level endon( #"hash_d71a6b5a" );
    level notify( #"hash_2e3e5b0a" );
    level thread connection_interrupted( 0 );
    level thread zurich_util::function_d0e3bb4( 1 );
    var_ccbdc630 = getent( "coalescence_gate", "targetname" );
    level scene::play( "p7_fxanim_cp_zurich_coalescence_tower_door_exit_bundle" );
    var_ccbdc630 notsolid();
    umbragate_set( "hq_atrium_umbra_gate", 1 );
}

// Namespace zurich_outro
// Params 1
// Checksum 0x9d11da39, Offset: 0x2ed0
// Size: 0x13c
function function_a947c3b3( a_ents )
{
    scene::waittill_skip_sequence_completed();
    level util::screen_message_delete();
    util::screen_fade_out( 0 );
    level clientfield::set( "sndIGCsnapshot", 5 );
    music::setmusicstate( "i_live_credits" );
    playsoundatposition( "evt_bonuszm_ending_toblack", ( 0, 0, 0 ) );
    level thread zurich_util::function_d0e3bb4( 0 );
    
    if ( isdefined( self.var_322cc58c ) )
    {
        self closeluimenu( self.var_322cc58c );
    }
    
    wait 2;
    objectives::complete( "cp_level_zurich_end_obj" );
    trigger::use( "trig_zurich_end", "targetname" );
    skipto::objective_completed( "zurich_outro" );
}

// Namespace zurich_outro
// Params 0
// Checksum 0x5f1d7b49, Offset: 0x3018
// Size: 0x6c
function function_2381bb7()
{
    level clientfield::set( "set_post_color_grade_bank", 1 );
    array::thread_all( level.players, &zurich_util::set_world_fog, 1 );
    exploder::exploder( "plaza_lights" );
}

// Namespace zurich_outro
// Params 0
// Checksum 0x793e4f94, Offset: 0x3090
// Size: 0x174
function function_4590fc90()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    level zurich_util::function_33ec653f( "zurich_outro_dead_robot_node_spawn_manager", undefined, 0.25, &function_710df260 );
    level zurich_util::function_33ec653f( "zurich_outro_solider_idle_struct_spawn_manager", undefined, 0.25, &function_29d8cf02 );
    spawner::simple_spawn_single( "plaza_battle_boss", &function_536749f9 );
    level waittill( #"hash_21ddc441" );
    level thread scene::play( "outro_ambient_execution", "targetname" );
    
    for ( i = 1; i < 5 ; i++ )
    {
        level thread zurich_util::function_33ec653f( "zurich_outro_solider_patrol_struct_spawn_manager_0" + i, undefined, 0.15, &function_83b161ee, "zurich_outro_solider_patrol_struct_spawner_0" + i );
    }
    
    level thread zurich_util::function_33ec653f( "zurich_outro_solider_patrol", undefined, undefined, &function_9f8eef7b );
}

// Namespace zurich_outro
// Params 0
// Checksum 0xc3dd1e84, Offset: 0x3210
// Size: 0x84
function function_536749f9()
{
    var_dbb2d033 = getnode( "zurich_outro_quadtank_death", "targetname" );
    self.origin = var_dbb2d033.origin;
    self.angles = var_dbb2d033.angles;
    self dodamage( self.health, self.origin );
}

// Namespace zurich_outro
// Params 0
// Checksum 0x3a359f93, Offset: 0x32a0
// Size: 0x2c
function function_710df260()
{
    self dodamage( self.health, self.origin );
}

// Namespace zurich_outro
// Params 0
// Checksum 0x6acdcc28, Offset: 0x32d8
// Size: 0x34
function function_29d8cf02()
{
    util::wait_network_frame();
    self scene::play( "sb_t7_c_nrc_assault_idle", self );
}

// Namespace zurich_outro
// Params 1
// Checksum 0xf768fc38, Offset: 0x3318
// Size: 0xb4
function function_83b161ee( nd_goal )
{
    self ai::set_ignoreall( 1 );
    wait randomfloatrange( 0.15, 0.5 );
    self clearforcedgoal();
    self ai::patrol( getnode( nd_goal, "targetname" ) );
    self waittill( #"goal" );
    self scene::play( "sb_t7_c_nrc_assault_idle", self );
}

// Namespace zurich_outro
// Params 0
// Checksum 0x4d6f5b86, Offset: 0x33d8
// Size: 0x24
function function_9f8eef7b()
{
    self ai::set_behavior_attribute( "patrol", 1 );
}

// Namespace zurich_outro
// Params 0
// Checksum 0xb12aeb21, Offset: 0x3408
// Size: 0x64
function function_80c5347c()
{
    var_f201bfb1 = struct::get_array( "outro_ambients", "targetname" );
    
    if ( !var_f201bfb1.size )
    {
        return;
    }
    
    level thread scene::play( "outro_ambients", "targetname" );
}

// Namespace zurich_outro
// Params 0
// Checksum 0x19eb8dbd, Offset: 0x3478
// Size: 0xb4
function function_f568befc()
{
    level scene::init( "p7_fxanim_cp_zurich_vtol_landing_end_bundle" );
    var_c5ac3179 = struct::get_array( "s_outro_air_vtol", "targetname" );
    array::thread_all( var_c5ac3179, &function_e26a2c57 );
    level flag::wait_till( "flag_start_zurich_outro" );
    level scene::play( "p7_fxanim_cp_zurich_vtol_landing_end_bundle" );
}

// Namespace zurich_outro
// Params 0
// Checksum 0x15645fa9, Offset: 0x3538
// Size: 0xfc
function function_e26a2c57()
{
    level._effect[ "vtol_exhaust" ] = "vehicle/fx_vtol_mil_egypt_thruster_side";
    var_2ec6deda = util::spawn_model( "veh_t7_mil_vtol_egypt", self.origin, self.angles );
    var_2ec6deda.fx_veh = [];
    var_2ec6deda.var_fdcf75a9 = self;
    var_2ec6deda.n_speed = 900;
    playfxontag( level._effect[ "vtol_exhaust" ], var_2ec6deda, "tag_fx_engine_left" );
    playfxontag( level._effect[ "vtol_exhaust" ], var_2ec6deda, "tag_fx_engine_right" );
    var_2ec6deda thread function_ffeb5fe9();
}

// Namespace zurich_outro
// Params 0
// Checksum 0x2243eda3, Offset: 0x3640
// Size: 0x15c
function function_ffeb5fe9()
{
    s_start = self.var_fdcf75a9;
    s_next = struct::get( s_start.target, "targetname" );
    level flag::wait_till( "flag_start_zurich_outro" );
    n_distance = distance( s_start.origin, s_next.origin );
    n_time = n_distance / self.n_speed;
    self moveto( s_next.origin, n_time );
    self rotateto( s_next.angles, n_time );
    self waittill( #"movedone" );
    
    if ( self.model === "veh_t7_mil_vtol_egypt" )
    {
        self thread function_61438a39();
        level waittill( #"hash_d71a6b5a" );
    }
    
    self delete();
}

// Namespace zurich_outro
// Params 0
// Checksum 0xaa75216b, Offset: 0x37a8
// Size: 0x146
function function_61438a39()
{
    level endon( #"hash_d71a6b5a" );
    var_8d7eab33 = self.angles;
    n_start_pos = self.origin;
    
    while ( true )
    {
        var_200a7636 = randomfloatrange( -10, 10 );
        var_cebf203c = randomfloatrange( -8, 8 );
        n_time = randomfloatrange( 0.2, 0.5 );
        self movez( var_200a7636, n_time );
        self rotateroll( var_cebf203c, n_time );
        wait n_time;
        self moveto( n_start_pos, n_time );
        self rotateto( var_8d7eab33, n_time );
        wait n_time;
    }
}

// Namespace zurich_outro
// Params 1
// Checksum 0x3dba23f1, Offset: 0x38f8
// Size: 0xec
function function_73b35f7b( b_locked )
{
    self util::freeze_player_controls( 1 );
    self disableweapons();
    self enableinvulnerability();
    self util::show_hud( 0 );
    self setclientuivisibilityflag( "weapon_hud_visible", 0 );
    
    if ( isdefined( b_locked ) && b_locked )
    {
        self.mdl_anchor = util::spawn_model( "tag_origin", self.origin, self.angles );
        self playerlinkto( self.mdl_anchor );
    }
}

// Namespace zurich_outro
// Params 0
// Checksum 0xf5667c9b, Offset: 0x39f0
// Size: 0xbc
function function_ba91aecf()
{
    self util::freeze_player_controls( 0 );
    self enableweapons();
    self disableinvulnerability();
    self util::show_hud( 1 );
    self setclientuivisibilityflag( "weapon_hud_visible", 1 );
    
    if ( isdefined( self.mdl_anchor ) )
    {
        self unlink();
        self.mdl_anchor delete();
    }
}

// Namespace zurich_outro
// Params 0
// Checksum 0x1c9fb087, Offset: 0x3ab8
// Size: 0x2fc
function larry_the_limper()
{
    if ( sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    self endon( #"disconnect" );
    self endon( #"death" );
    self.var_ea4a62a = util::spawn_model( "tag_origin" );
    self playersetgroundreferenceent( self.var_ea4a62a );
    self setmovespeedscale( 0.85 );
    var_d0f99889 = [];
    
    if ( !isdefined( var_d0f99889 ) )
    {
        var_d0f99889 = [];
    }
    else if ( !isarray( var_d0f99889 ) )
    {
        var_d0f99889 = array( var_d0f99889 );
    }
    
    var_d0f99889[ var_d0f99889.size ] = &decent_leftlimp;
    
    if ( !isdefined( var_d0f99889 ) )
    {
        var_d0f99889 = [];
    }
    else if ( !isarray( var_d0f99889 ) )
    {
        var_d0f99889 = array( var_d0f99889 );
    }
    
    var_d0f99889[ var_d0f99889.size ] = &decent_rightlimp;
    
    if ( !isdefined( var_d0f99889 ) )
    {
        var_d0f99889 = [];
    }
    else if ( !isarray( var_d0f99889 ) )
    {
        var_d0f99889 = array( var_d0f99889 );
    }
    
    var_d0f99889[ var_d0f99889.size ] = &decent_straight_limp;
    
    if ( !isdefined( var_d0f99889 ) )
    {
        var_d0f99889 = [];
    }
    else if ( !isarray( var_d0f99889 ) )
    {
        var_d0f99889 = array( var_d0f99889 );
    }
    
    var_d0f99889[ var_d0f99889.size ] = &decent_leftlimp;
    decent_straight_limp();
    self thread player_velocity_tracker();
    wait 0.05;
    
    while ( true )
    {
        if ( self.player_speed > 1 )
        {
            var_e3e6bb68 = var_d0f99889[ randomint( var_d0f99889.size ) ];
            [[ var_e3e6bb68 ]]();
            larry_the_limper_tweaktech();
            self playersetgroundreferenceent( self.var_ea4a62a );
            self limp_loop();
            continue;
        }
        
        wait 0.05;
    }
}

// Namespace zurich_outro
// Params 0
// Checksum 0x646d4621, Offset: 0x3dc0
// Size: 0x26c
function limp_loop()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"player_not_moving" );
    self setblur( 0.5, 0.5 );
    var_f7fdecc8 = ( level.var_a8cde67a, level.var_ced060e3, level.var_5cc8f1a8 );
    v_angles = self adjust_angles_to_player( var_f7fdecc8 );
    self thread player_speed_set( level.var_b353f4c4, level.var_cd2a14bf );
    self.var_ea4a62a rotateto( v_angles, level.var_f2f6bb73, level.var_98baefb2, level.var_cca7fbf6 );
    wait level.var_71452859;
    self setblur( 0, 0.5 );
    var_5b669c4e = ( level.var_3786492b, level.var_1183cec2, level.var_eb815459 );
    v_angles = self adjust_angles_to_player( var_5b669c4e );
    self thread player_speed_set( level.var_9ab04381, level.var_1fe3ba00 );
    self.var_ea4a62a rotateto( v_angles, level.var_f82f9c0e, level.var_d0d9c3d3, level.var_f929cce9 );
    wait level.var_3830f2ec;
    self thread player_speed_set( level.var_29ea0d2, level.var_2bd8595 );
    var_9fb101a3 = ( level.var_6cd24960, level.var_92d4c3c9, level.var_b8d73e32 );
    v_angles = self adjust_angles_to_player( var_9fb101a3 );
    self.var_ea4a62a rotateto( v_angles, level.var_1756af11, level.var_9de91a84, level.var_b5195d4 );
    wait level.var_ca92fecf;
}

// Namespace zurich_outro
// Params 0
// Checksum 0x6d6edf56, Offset: 0x4038
// Size: 0x124
function player_velocity_tracker()
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    for ( var_7ba6849c = 0; true ; var_7ba6849c = self.player_speed )
    {
        v_player_velocity = self getvelocity();
        self.player_speed = abs( v_player_velocity[ 0 ] ) + abs( v_player_velocity[ 1 ] );
        
        if ( self.player_speed < 1 && var_7ba6849c > 1 )
        {
            self notify( #"player_not_moving" );
            self.var_ea4a62a rotateto( ( 0, 0, 0 ), 1 );
            wait 0.5;
        }
        
        if ( self.player_speed > 1 && self.player_speed < 40 )
        {
            larry_the_limper_tweaktech_halved();
        }
        
        wait 0.05;
    }
}

// Namespace zurich_outro
// Params 0
// Checksum 0x15fee990, Offset: 0x4168
// Size: 0x1b4
function larry_the_limper_tweaktech()
{
    level.var_a8cde67a = level.var_8f8774d5;
    level.var_ced060e3 = level.var_6984fa6c;
    level.var_5cc8f1a8 = level.var_db8c69a7;
    level.var_f2f6bb73 = level.var_8d8840b7;
    level.var_98baefb2 = level.var_40f1057e;
    level.var_cca7fbf6 = level.var_cd24949a;
    level.var_71452859 = level.var_66ae20ea;
    level.var_b353f4c4 = level.var_c396df85;
    level.var_cd2a14bf = level.var_ae4f1734;
    level.var_3786492b = level.var_3781f860;
    level.var_1183cec2 = level.var_5d8472c9;
    level.var_eb815459 = level.var_8386ed32;
    level.var_f82f9c0e = level.var_6210de6e;
    level.var_d0d9c3d3 = level.var_dd3790f3;
    level.var_f929cce9 = level.var_2abf0589;
    level.var_3830f2ec = level.var_eac13797;
    level.var_9ab04381 = level.var_3f9e1bba;
    level.var_1fe3ba00 = level.var_80d43aed;
    level.var_6cd24960 = level.var_4d68f84b;
    level.var_92d4c3c9 = level.var_27667de2;
    level.var_b8d73e32 = level.var_1640379;
    level.var_1756af11 = level.var_49b7a58d;
    level.var_9de91a84 = level.var_373e9d48;
    level.var_b5195d4 = level.var_a109eca0;
    level.var_ca92fecf = level.var_f8205536;
    level.var_29ea0d2 = level.var_235b23b;
    level.var_2bd8595 = level.var_6dcb06fa;
}

// Namespace zurich_outro
// Params 0
// Checksum 0x84339780, Offset: 0x4328
// Size: 0x1b4
function larry_the_limper_tweaktech_fast()
{
    level.var_a8cde67a = level.var_8f8774d5;
    level.var_ced060e3 = level.var_6984fa6c;
    level.var_5cc8f1a8 = level.var_db8c69a7;
    level.var_f2f6bb73 = level.var_8d8840b7;
    level.var_98baefb2 = level.var_40f1057e;
    level.var_cca7fbf6 = level.var_cd24949a;
    level.var_71452859 = level.var_66ae20ea;
    level.var_b353f4c4 = level.var_c396df85;
    level.var_cd2a14bf = level.var_ae4f1734;
    level.var_3786492b = level.var_3781f860;
    level.var_1183cec2 = level.var_5d8472c9;
    level.var_eb815459 = level.var_8386ed32;
    level.var_f82f9c0e = level.var_6210de6e;
    level.var_d0d9c3d3 = level.var_dd3790f3;
    level.var_f929cce9 = level.var_2abf0589;
    level.var_3830f2ec = level.var_eac13797;
    level.var_9ab04381 = level.var_3f9e1bba;
    level.var_1fe3ba00 = level.var_80d43aed;
    level.var_6cd24960 = level.var_4d68f84b;
    level.var_92d4c3c9 = level.var_27667de2;
    level.var_b8d73e32 = level.var_1640379;
    level.var_1756af11 = level.var_49b7a58d;
    level.var_9de91a84 = level.var_373e9d48;
    level.var_b5195d4 = level.var_a109eca0;
    level.var_ca92fecf = level.var_f8205536;
    level.var_29ea0d2 = level.var_235b23b;
    level.var_2bd8595 = level.var_6dcb06fa;
}

// Namespace zurich_outro
// Params 0
// Checksum 0xa56751f9, Offset: 0x44e8
// Size: 0x28c
function larry_the_limper_tweaktech_halved()
{
    level.var_a8cde67a = 0.8 * level.var_8f8774d5;
    level.var_ced060e3 = 0.8 * level.var_6984fa6c;
    level.var_5cc8f1a8 = 0.8 * level.var_db8c69a7;
    level.var_f2f6bb73 = 0.8 * level.var_8d8840b7;
    level.var_98baefb2 = 0.8 * level.var_40f1057e;
    level.var_cca7fbf6 = 0.8 * level.var_cd24949a;
    level.var_71452859 = 0.8 * level.var_66ae20ea;
    level.var_b353f4c4 = 0.8 * level.var_c396df85;
    level.var_cd2a14bf = 0.8 * level.var_ae4f1734;
    level.var_3786492b = 0.8 * level.var_3781f860;
    level.var_1183cec2 = 0.8 * level.var_5d8472c9;
    level.var_eb815459 = 0.8 * level.var_8386ed32;
    level.var_f82f9c0e = 0.8 * level.var_6210de6e;
    level.var_d0d9c3d3 = 0.8 * level.var_dd3790f3;
    level.var_f929cce9 = 0.8 * level.var_2abf0589;
    level.var_3830f2ec = 0.8 * level.var_eac13797;
    level.var_9ab04381 = 0.8 * level.var_3f9e1bba;
    level.var_1fe3ba00 = 0.8 * level.var_80d43aed;
    level.var_6cd24960 = 0.8 * level.var_4d68f84b;
    level.var_92d4c3c9 = 0.8 * level.var_27667de2;
    level.var_b8d73e32 = 0.8 * level.var_1640379;
    level.var_1756af11 = 0.8 * level.var_49b7a58d;
    level.var_9de91a84 = 0.8 * level.var_373e9d48;
    level.var_b5195d4 = 0.8 * level.var_a109eca0;
    level.var_ca92fecf = 0.8 * level.var_f8205536;
    level.var_29ea0d2 = 0.8 * level.var_235b23b;
    level.var_2bd8595 = 0.8 * level.var_6dcb06fa;
}

// Namespace zurich_outro
// Params 0
// Checksum 0xdb641c9d, Offset: 0x4780
// Size: 0x184
function decent_straight_limp()
{
    level.var_8f8774d5 = 0;
    level.var_6984fa6c = 0;
    level.var_db8c69a7 = 1;
    level.var_8d8840b7 = 0.6;
    level.var_40f1057e = 0.55;
    level.var_cd24949a = 0.05;
    level.var_66ae20ea = 0.6;
    level.var_c396df85 = 120;
    level.var_ae4f1734 = 0.2;
    level.var_3781f860 = 0;
    level.var_5d8472c9 = 0;
    level.var_8386ed32 = 4;
    level.var_6210de6e = 0.4;
    level.var_dd3790f3 = 0.35;
    level.var_2abf0589 = 0.05;
    level.var_eac13797 = 0.4;
    level.var_3f9e1bba = 130;
    level.var_80d43aed = 0.2;
    level.var_4d68f84b = 0;
    level.var_27667de2 = 0;
    level.var_1640379 = 0;
    level.var_49b7a58d = 0.5;
    level.var_373e9d48 = 0.45;
    level.var_a109eca0 = 0.05;
    level.var_f8205536 = 0.5;
    level.var_235b23b = 40;
    level.var_6dcb06fa = 0.5;
}

// Namespace zurich_outro
// Params 0
// Checksum 0x91ecb5b6, Offset: 0x4910
// Size: 0x184
function decent_leftlimp()
{
    level.var_8f8774d5 = 0;
    level.var_6984fa6c = 5;
    level.var_db8c69a7 = -1;
    level.var_8d8840b7 = 0.6;
    level.var_40f1057e = 0.55;
    level.var_cd24949a = 0.05;
    level.var_66ae20ea = 0.6;
    level.var_c396df85 = 120;
    level.var_ae4f1734 = 0.2;
    level.var_3781f860 = 0;
    level.var_5d8472c9 = 1;
    level.var_8386ed32 = 3;
    level.var_6210de6e = 0.4;
    level.var_dd3790f3 = 0.35;
    level.var_2abf0589 = 0.05;
    level.var_eac13797 = 0.4;
    level.var_3f9e1bba = 130;
    level.var_80d43aed = 0.2;
    level.var_4d68f84b = 0;
    level.var_27667de2 = 0;
    level.var_1640379 = 0;
    level.var_49b7a58d = 0.5;
    level.var_373e9d48 = 0.45;
    level.var_a109eca0 = 0.05;
    level.var_f8205536 = 0.5;
    level.var_235b23b = 40;
    level.var_6dcb06fa = 0.5;
}

// Namespace zurich_outro
// Params 0
// Checksum 0x21d2a417, Offset: 0x4aa0
// Size: 0x188
function decent_rightlimp()
{
    level.var_8f8774d5 = -2;
    level.var_6984fa6c = -5;
    level.var_db8c69a7 = 3.5;
    level.var_8d8840b7 = 0.35;
    level.var_40f1057e = 0.3;
    level.var_cd24949a = 0.05;
    level.var_66ae20ea = 0.5;
    level.var_c396df85 = 105;
    level.var_ae4f1734 = 0.35;
    level.var_3781f860 = 1;
    level.var_5d8472c9 = -1;
    level.var_8386ed32 = 2;
    level.var_6210de6e = 0.5;
    level.var_dd3790f3 = 0.35;
    level.var_2abf0589 = 0.05;
    level.var_eac13797 = 0.4;
    level.var_3f9e1bba = 130;
    level.var_80d43aed = 0.2;
    level.var_4d68f84b = 0;
    level.var_27667de2 = 0;
    level.var_1640379 = 0;
    level.var_49b7a58d = 0.5;
    level.var_373e9d48 = 0.25;
    level.var_a109eca0 = 0.05;
    level.var_f8205536 = 0.5;
    level.var_235b23b = 90;
    level.var_6dcb06fa = 0.2;
}

// Namespace zurich_outro
// Params 1
// Checksum 0x6dd167a3, Offset: 0x4c30
// Size: 0x138
function adjust_angles_to_player( var_cb29ad00 )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    v_pa = var_cb29ad00[ 0 ];
    v_ra = var_cb29ad00[ 2 ];
    var_7d94cf0c = anglestoright( self.angles );
    var_637af9e8 = anglestoforward( self.angles );
    var_22f51d2d = ( var_7d94cf0c[ 0 ], 0, var_7d94cf0c[ 1 ] * -1 );
    var_67abfb41 = ( var_637af9e8[ 0 ], 0, var_637af9e8[ 1 ] * -1 );
    v_angles = var_22f51d2d * v_pa;
    v_angles += var_67abfb41 * v_ra;
    return v_angles + ( 0, var_cb29ad00[ 1 ], 0 );
}

// Namespace zurich_outro
// Params 2
// Checksum 0xea8fcbb1, Offset: 0x4d70
// Size: 0x1a4
function player_speed_set( n_speed, n_time )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    var_6d63a9b5 = getdvarint( "g_speed" );
    var_f44c8c7e = n_speed;
    
    if ( isdefined( self._player_speed_modifier ) )
    {
        var_f44c8c7e = n_speed * self._player_speed_modifier;
    }
    
    if ( !isdefined( self.g_speed ) )
    {
        self.g_speed = var_6d63a9b5;
    }
    
    n_range = var_f44c8c7e - var_6d63a9b5;
    n_interval = 0.05;
    n_cycles = n_time / n_interval;
    n_fraction = n_range / n_cycles;
    
    while ( abs( var_f44c8c7e - var_6d63a9b5 ) > abs( n_fraction * 1.1 ) )
    {
        var_6d63a9b5 += n_fraction;
        setdvar( "g_speed", int( var_6d63a9b5 ) );
        wait n_interval;
    }
    
    setdvar( "g_speed", var_f44c8c7e );
}

// Namespace zurich_outro
// Params 0
// Checksum 0x677de91a, Offset: 0x4f20
// Size: 0x4ac
function function_3ec4c691()
{
    var_5cca3f31 = getent( "trig_enable_zuirch_ending", "targetname" );
    var_5cca3f31.origin += ( 0, 0, 1000 );
    var_5cca3f31 triggerenable( 0 );
    level.var_64b9a8b0 = 1;
    level scene::init( "cin_zmcp_20_01_plaza_1st_outro" );
    scene::add_scene_func( "cin_zmcp_20_01_plaza_1st_outro", &function_95ed5d29, "play" );
    scene::add_scene_func( "cin_zmcp_20_01_plaza_1st_outro", &function_72f4ee18, "play" );
    scene::add_scene_func( "cin_zmcp_20_01_plaza_1st_player", &function_93ffcbdf, "play" );
    scene::add_scene_func( "cin_zmcp_20_01_plaza_1st_player", &function_7e39583d, "done" );
    level flag::wait_till( "atrium_hack_objective_start" );
    level flag::wait_till( "BZM_ZURICHDialogue23" );
    var_5cca3f31 = getent( "trig_enable_zuirch_ending", "targetname" );
    var_5cca3f31.origin += ( 0, 0, -1000 );
    wait 0.2;
    var_5cca3f31 zurich_util::function_d1996775();
    level notify( #"hash_21ddc441" );
    level clientfield::set( "set_post_color_grade_bank", 1 );
    array::thread_all( level.players, &zurich_util::set_world_fog, 1 );
    exploder::exploder( "plaza_lights" );
    level zurich_util::player_weather( 1, "reverse_snow" );
    level flag::set( "flag_start_zurich_outro" );
    
    if ( isdefined( level.bzm_zurichdialogue24callback ) )
    {
        level thread [[ level.bzm_zurichdialogue24callback ]]();
    }
    
    foreach ( player in level.activeplayers )
    {
        var_4044e31f = player getweaponslistprimaries();
        
        foreach ( weapon in var_4044e31f )
        {
            if ( weapon.isheroweapon )
            {
                player takeweapon( weapon );
            }
        }
    }
    
    music::setmusicstate( "none" );
    playsoundatposition( "evt_bonuszm_ending_zombies", ( 0, 0, 0 ) );
    level clientfield::set( "gameplay_started", 0 );
    level thread scene::play( "cin_zmcp_20_01_plaza_1st_player" );
    level thread scene::play( "cin_zmcp_20_01_plaza_1st_outro" );
}

// Namespace zurich_outro
// Params 1
// Checksum 0x4f39d3f8, Offset: 0x53d8
// Size: 0x2a2
function function_7e39583d( players )
{
    self endon( #"death" );
    
    foreach ( player in level.players )
    {
        foreach ( var_e6ef2725 in level.players )
        {
            player setinvisibletoplayer( var_e6ef2725, 1 );
        }
        
        player freezecontrols( 0 );
        player setclientuivisibilityflag( "hud_visible", 0 );
        player setclientuivisibilityflag( "weapon_hud_visible", 0 );
        var_4044e31f = player getweaponslistprimaries();
        
        foreach ( weapon in var_4044e31f )
        {
            player takeweapon( weapon );
        }
        
        shotgun = getweapon( "shotgun_pump" );
        player giveweapon( shotgun );
        player setweaponammoclip( shotgun, shotgun.clipsize );
        player switchtoweapon( shotgun );
    }
}

// Namespace zurich_outro
// Params 1
// Checksum 0xcac08b1d, Offset: 0x5688
// Size: 0x30c
function function_93ffcbdf( a_ents )
{
    if ( isdefined( level.bzm_zurichdialogue25callback ) )
    {
        [[ level.bzm_zurichdialogue25callback ]]();
    }
    
    playsoundatposition( "evt_bonuszm_ending_toblack", ( 0, 0, 0 ) );
    level clientfield::set( "sndIGCsnapshot", 5 );
    level util::screen_message_delete();
    util::screen_fade_out( 0 );
    music::setmusicstate( "i_live_credits" );
    wait 1;
    
    foreach ( player in level.players )
    {
        foreach ( var_e6ef2725 in level.players )
        {
            player setinvisibletoplayer( var_e6ef2725, 0 );
        }
        
        var_4044e31f = player getweaponslistprimaries();
        
        foreach ( weapon in var_4044e31f )
        {
            player takeweapon( weapon );
            player freezecontrols( 1 );
            player util::set_low_ready( 1 );
        }
    }
    
    if ( isdefined( self.var_322cc58c ) )
    {
        self closeluimenu( self.var_322cc58c );
    }
    
    objectives::complete( "cp_level_zurich_end_obj" );
    trigger::use( "trig_zurich_end", "targetname" );
    skipto::objective_completed( "zurich_outro" );
}

// Namespace zurich_outro
// Params 1
// Checksum 0x6487cc74, Offset: 0x59a0
// Size: 0x92
function function_72f4ee18( a_ents )
{
    foreach ( ent in a_ents )
    {
        ent sethighdetail( 1 );
    }
}

