#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_blackstation;
#using scripts/cp/cp_mi_sing_blackstation_accolades;
#using scripts/cp/cp_mi_sing_blackstation_port;
#using scripts/cp/cp_mi_sing_blackstation_sound;
#using scripts/cp/cp_mi_sing_blackstation_utility;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/coop;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/player_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#namespace cp_mi_sing_blackstation_qzone;

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x4f9717a6, Offset: 0x1298
// Size: 0x1c
function main()
{
    level thread hendricks_warlord_fight_path();
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x6b12c054, Offset: 0x12c0
// Size: 0x164
function vtol_intro()
{
    level scene::add_scene_func( "cin_bla_01_01_intro_1st", &intro_scene, "play" );
    level scene::add_scene_func( "cin_bla_01_01_intro_1st", &function_b1896f5, "players_done" );
    level scene::add_scene_func( "cin_bla_01_01_intro_1st", &function_72332b44, "skip_completed" );
    load::function_c32ba481();
    util::do_chyron_text( &"CP_MI_SING_BLACKSTATION_INTRO_LINE_1_FULL", &"CP_MI_SING_BLACKSTATION_INTRO_LINE_1_SHORT", &"CP_MI_SING_BLACKSTATION_INTRO_LINE_2_FULL", &"CP_MI_SING_BLACKSTATION_INTRO_LINE_2_SHORT", &"CP_MI_SING_BLACKSTATION_INTRO_LINE_3_FULL", &"CP_MI_SING_BLACKSTATION_INTRO_LINE_3_SHORT", &"CP_MI_SING_BLACKSTATION_INTRO_LINE_4_FULL", &"CP_MI_SING_BLACKSTATION_INTRO_LINE_4_SHORT", "", "", 12 );
    
    if ( isdefined( level.bzm_blackstationdialogue1callback ) )
    {
        level thread [[ level.bzm_blackstationdialogue1callback ]]();
    }
    
    level thread scene::play( "cin_bla_01_01_intro_1st" );
    level lui::screen_fade_out( 0 );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x66ead30f, Offset: 0x1430
// Size: 0xf4
function vtol_lights()
{
    a_e_lights = getentarray( "vtol_lights", "targetname" );
    
    foreach ( light in a_e_lights )
    {
        light linkto( self );
        light thread vtol_light_cleanup();
    }
    
    self attach( "veh_t7_mil_vtol_egypt_cabin_details_attch", "tag_body_animate" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xaeade46c, Offset: 0x1530
// Size: 0x2c
function vtol_light_cleanup()
{
    level waittill( #"notetrack_fall" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 1
// Checksum 0x23d96239, Offset: 0x1568
// Size: 0x24a
function intro_scene( a_ents )
{
    level scene::add_scene_ordered_notetrack( "intro_qzone", "notetrack_catch" );
    level scene::add_scene_ordered_notetrack( "intro_qzone", "notetrack_start_rain" );
    level scene::add_scene_ordered_notetrack( "intro_qzone", "notetrack_fall" );
    level scene::add_scene_ordered_notetrack( "intro_qzone", "notetrack_land" );
    level scene::add_scene_ordered_notetrack( "intro_qzone", "intro_done" );
    level thread function_d9d7be12();
    level thread function_bc49a6ce();
    level thread function_202f6b4c();
    level thread function_211d4422();
    level thread function_2365861b();
    level thread function_cc9e7b72();
    level thread function_13820fbf();
    
    if ( !isdefined( level.var_25647ecb ) )
    {
        level.var_25647ecb = spawn( "script_origin", ( 0, 0, 0 ) );
    }
    
    foreach ( player in level.activeplayers )
    {
        player switchtoweapon( getweapon( "micromissile_launcher" ) );
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 1
// Checksum 0xd7c675e7, Offset: 0x17c0
// Size: 0x2c
function function_b1896f5( a_ents )
{
    level util::teleport_players_igc( "qzone_teleport_pos" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 1
// Checksum 0xc1ceaf08, Offset: 0x17f8
// Size: 0xd4
function function_72332b44( a_ents )
{
    util::screen_fade_out( 0, "black", "hide_qzone_stream" );
    level util::player_lock_control();
    level thread function_6c7970a2();
    level util::waittill_notify_or_timeout( "qzone_streamer_read", 5 );
    level notify( #"qzone_streamer_read" );
    util::screen_fade_in( 0.5, "black", "hide_qzone_stream" );
    level util::player_unlock_control();
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x20b35d63, Offset: 0x18d8
// Size: 0x32
function function_6c7970a2()
{
    level endon( #"qzone_streamer_read" );
    level util::streamer_wait();
    level notify( #"qzone_streamer_read" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x19708466, Offset: 0x1918
// Size: 0x2c
function function_d9d7be12()
{
    level waittill( #"hash_e99b0752" );
    level lui::screen_fade_in( 3 );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xf55a4d5d, Offset: 0x1950
// Size: 0xba
function function_bc49a6ce()
{
    level waittill( #"hash_a525e1f7" );
    playsoundatposition( "evt_player_catch_weapon", ( 0, 0, 0 ) );
    
    foreach ( player in level.activeplayers )
    {
        player playrumbleonentity( "cp_blackstation_intro_weapon_catch" );
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xafda8e4b, Offset: 0x1a18
// Size: 0xba
function function_202f6b4c()
{
    level waittill( #"hash_8eb6a1cf" );
    
    foreach ( player in level.activeplayers )
    {
        player thread blackstation_utility::player_rain_intensity( "light_se" );
        player clientfield::set_to_player( "toggle_rain_sprite", 1 );
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x9676383d, Offset: 0x1ae0
// Size: 0xda
function function_211d4422()
{
    level waittill( #"hash_fb0df4bd" );
    level.var_25647ecb stoploopsound( 1 );
    
    foreach ( player in level.activeplayers )
    {
        player clientfield::set_to_player( "wind_blur", 1 );
        player clientfield::set_to_player( "wind_effects", 1 );
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xd70fd456, Offset: 0x1bc8
// Size: 0x11c
function function_2365861b()
{
    level waittill( #"hash_773822d9" );
    
    foreach ( player in level.activeplayers )
    {
        player playrumbleonentity( "cp_blackstation_vtol_land_rumble" );
        player clientfield::set_to_player( "wind_blur", 0 );
        player clientfield::set_to_player( "wind_effects", 0 );
    }
    
    wait 1;
    level thread blackstation_utility::player_rain_intensity( "med_se" );
    wait 2;
    clientfield::increment( "qzone_debris" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xeb499ed6, Offset: 0x1cf0
// Size: 0xfc
function function_cc9e7b72()
{
    level waittill( #"hash_a5a4d60b" );
    util::teleport_players_igc( "objective_qzone" );
    level flag::set( "vtol_jump" );
    
    foreach ( player in level.activeplayers )
    {
        player thread blackstation_utility::player_rain_intensity( "light_se" );
    }
    
    streamerrequest( "set", "cp_mi_sing_blackstation_objective_warlord_igc" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xc07d2098, Offset: 0x1df8
// Size: 0x54
function hendricks_qzone_path_igc()
{
    level flag::wait_till( "vtol_jump" );
    trigger::use( "trigger_hendricks_start" );
    level hendricks_qzone_path();
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x1533f3da, Offset: 0x1e58
// Size: 0x128
function hendricks_qzone_path()
{
    level.ai_hendricks thread blackstation_utility::dynamic_run_speed();
    level flag::wait_till( "flag_hendricks_bodies" );
    level.ai_hendricks notify( #"stop_dynamic_run_speed" );
    level scene::add_scene_func( "cin_bla_02_03_qzone_vign_executed_hendricks", &function_a2790c98 );
    level scene::play( "cin_bla_02_03_qzone_vign_executed_hendricks" );
    
    if ( !level flag::get( "past_school" ) )
    {
        trigger::use( "trigger_hendricks_street" );
    }
    
    wait 1;
    level.ai_hendricks thread blackstation_utility::dynamic_run_speed();
    level flag::wait_till( "warlord_intro_prep" );
    level.ai_hendricks notify( #"stop_dynamic_run_speed" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 1
// Checksum 0x267945c2, Offset: 0x1f88
// Size: 0x4c
function function_a2790c98( a_ents )
{
    level dialog::player_say( "plyr_why_would_the_immort_0", 5 );
    level flag::set( "executed_bodies" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xca416a37, Offset: 0x1fe0
// Size: 0x154
function hendricks_warlord_fight_path()
{
    level flag::wait_till( "warlord_move_to_volume" );
    trigger::use( "triggercolor_b6_warlord_fallback" );
    level flag::wait_till( "hendricks_moveup" );
    trigger::use( "triggercolor_mid_qzone" );
    level flag::wait_till( "warlord_backup" );
    trigger::use( "triggercolor_hendricks_advance" );
    level flag::wait_till( "warlord_retreat" );
    trigger::use( "triggercolor_b7_debriswall_approach" );
    level flag::wait_till( "qzone_done" );
    level thread namespace_4297372::function_973b77f9();
    level.ai_hendricks thread dialog::say( "hend_the_superstorm_s_win_0" );
    level thread blackstation_utility::hendricks_debris_traversal_ready();
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xa6d864e8, Offset: 0x2140
// Size: 0x14c
function vo_warlord_intro()
{
    trigger::wait_till( "trigger_hendricks_warlord" );
    level flag::set( "warlord_approach" );
    
    if ( isdefined( level.e_speaker ) )
    {
        level.e_speaker stopsounds();
        wait 0.5;
        
        if ( isdefined( level.e_speaker ) )
        {
            level.e_speaker delete();
        }
        
        foreach ( player in level.activeplayers )
        {
            player luinotifyevent( &"offsite_comms_complete" );
        }
    }
    
    level.ai_hendricks dialog::say( "hend_activity_ahead_sta_0", 0.5 );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x6682c4df, Offset: 0x2298
// Size: 0xcc
function hendricks_warlord_fight()
{
    level waittill( #"hash_998c624d" );
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 1 );
    nd_cover = getnode( "cover_warlord_engage", "targetname" );
    level.ai_hendricks setgoal( nd_cover, 1 );
    level.ai_hendricks waittill( #"goal" );
    level.ai_hendricks clearforcedgoal();
    level.ai_hendricks ai::set_behavior_attribute( "cqb", 0 );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 1
// Checksum 0xec81a810, Offset: 0x2370
// Size: 0x34c
function interact_warlord_intro( b_starting )
{
    level.var_d8ffea14 = getnodearray( "china_town_warlord_preferred_goal", "targetname" );
    spawner::add_spawn_function_group( "warlordintro_warlord", "targetname", &warlord_retreat );
    
    if ( !b_starting )
    {
        trigger::wait_till( "trigger_warlord_igc" );
    }
    
    foreach ( player in level.activeplayers )
    {
        player.w_current = player getcurrentweapon();
        player player::switch_to_primary_weapon( 1 );
    }
    
    level flag::set( "warlord_intro_prep" );
    level.ai_hendricks notify( #"stop_dynamic_run_speed" );
    level.ai_hendricks ai::set_ignoreall( 1 );
    level thread namespace_4297372::function_4f531ae2();
    level scene::add_scene_func( "cin_bla_03_warlordintro_3rd_sh010", &function_a80d0dfb, "play" );
    level scene::add_scene_func( "cin_bla_03_warlordintro_3rd_sh150", &function_bf6f9b2f, "play" );
    level scene::add_scene_func( "cin_bla_03_warlordintro_3rd_sh160", &function_d916bcc0, "done" );
    level scene::add_scene_func( "cin_bla_03_warlordintro_3rd_sh170", &function_26c954d8, "done" );
    level scene::add_scene_func( "cin_bla_03_warlordintro_3rd_sh170_hendricks", &function_ec2528a6, "play" );
    
    if ( isdefined( level.bzm_blackstationdialogue3callback ) )
    {
        level thread [[ level.bzm_blackstationdialogue3callback ]]();
    }
    
    level scene::play( "cin_bla_03_warlordintro_3rd_sh010" );
    level thread objectives::breadcrumb( "anchor_intro_breadcrumb", "cp_level_blackstation_climb" );
    level thread cp_mi_sing_blackstation_port::debris_mound_breadcrumb();
    level flag::wait_till( "warlord_fight" );
    level thread namespace_4297372::function_fa2e45b8();
    level thread shelter_blow_away();
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 1
// Checksum 0xca1bf078, Offset: 0x26c8
// Size: 0x124
function function_a80d0dfb( a_ents )
{
    level clientfield::set( "warlord_exposure", 1 );
    
    foreach ( player in level.activeplayers )
    {
        player clientfield::set_to_player( "toggle_rain_sprite", 0 );
        player thread function_d4e7d4e4();
        player thread blackstation_utility::player_rain_intensity( "none" );
    }
    
    level flag::wait_till( "warlord_fight" );
    wait 8;
    savegame::checkpoint_save();
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 1
// Checksum 0xf1169c86, Offset: 0x27f8
// Size: 0x4c
function function_d916bcc0( a_ents )
{
    level thread scene::play( "cin_bla_03_warlordintro_3rd_sh170_hendricks" );
    level thread scene::play( "cin_bla_03_warlordintro_3rd_sh170_civs" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 1
// Checksum 0x968367b2, Offset: 0x2850
// Size: 0xfa
function function_26c954d8( a_ents )
{
    level clientfield::set( "warlord_exposure", 0 );
    level flag::set( "warlord_fight" );
    
    foreach ( player in level.activeplayers )
    {
        player clientfield::set_to_player( "toggle_rain_sprite", 1 );
        player thread blackstation_utility::player_rain_intensity( "light_se" );
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 1
// Checksum 0xdf0c5b75, Offset: 0x2958
// Size: 0xd2
function function_ec2528a6( a_ents )
{
    level.ai_hendricks ai::set_ignoreall( 0 );
    
    foreach ( player in level.activeplayers )
    {
        player clientfield::set_to_player( "toggle_rain_sprite", 1 );
        player switchtoweapon( player.w_current );
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 1
// Checksum 0xcddcc07a, Offset: 0x2a38
// Size: 0xdc
function function_bf6f9b2f( a_ents )
{
    level waittill( #"hash_7f71b7e6" );
    var_837033c1 = a_ents[ "warlordintro_civilian_female" ];
    var_16095f82 = a_ents[ "warlordintro_civilian" ];
    
    if ( isdefined( var_837033c1 ) )
    {
        var_837033c1 attach( "c_civ_sing_female_wife_behead" );
        var_837033c1 detach( "c_civ_sing_female_wife_head" );
    }
    
    if ( isdefined( var_16095f82 ) )
    {
        var_16095f82 attach( "c_civ_sing_male_husband_behead" );
        var_16095f82 detach( "c_civ_sing_male_husband_head" );
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 1
// Checksum 0xccc84d2d, Offset: 0x2b20
// Size: 0xd4
function function_b5eea60c( a_ents )
{
    var_837033c1 = a_ents[ "warlordintro_civilian_female" ];
    var_16095f82 = a_ents[ "warlordintro_civilian" ];
    
    if ( isdefined( var_837033c1 ) )
    {
        var_837033c1 attach( "c_civ_sing_female_wife_behead" );
        var_837033c1 detach( "c_civ_sing_female_wife_head" );
    }
    
    if ( isdefined( var_16095f82 ) )
    {
        var_16095f82 attach( "c_civ_sing_male_husband_behead" );
        var_16095f82 detach( "c_civ_sing_male_husband_head" );
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 1
// Checksum 0x4882aa99, Offset: 0x2c00
// Size: 0xd4
function function_1dc7c14c( a_ents )
{
    var_837033c1 = a_ents[ "warlordintro_civilian_female" ];
    var_16095f82 = a_ents[ "warlordintro_civilian" ];
    
    if ( isdefined( var_837033c1 ) )
    {
        var_837033c1 attach( "c_civ_sing_female_wife_behead" );
        var_837033c1 detach( "c_civ_sing_female_wife_head" );
    }
    
    if ( isdefined( var_16095f82 ) )
    {
        var_16095f82 attach( "c_civ_sing_male_husband_behead" );
        var_16095f82 detach( "c_civ_sing_male_husband_head" );
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x72218e25, Offset: 0x2ce0
// Size: 0x5c
function function_d4e7d4e4()
{
    self endon( #"death" );
    self enableinvulnerability();
    level flag::wait_till( "warlord_fight" );
    wait 6;
    self disableinvulnerability();
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xc0a7cc20, Offset: 0x2d48
// Size: 0x6c
function warlord_death_watcher()
{
    self waittill( #"death" );
    wait 1;
    level flag::set( "warlord_backup" );
    level flag::set( "warlord_retreat" );
    self warlordinterface::clearallpreferedpoints();
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x23cd9664, Offset: 0x2dc0
// Size: 0x48
function civ_spawn_func()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self.goalradius = 1;
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 1
// Checksum 0xe8fe93de, Offset: 0x2e10
// Size: 0x17c
function warlord_intro_spawn_func( b_enemy )
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    self ai::set_ignoreme( 1 );
    self util::magic_bullet_shield();
    
    if ( isdefined( b_enemy ) )
    {
        nd_start = getnode( self.script_noteworthy, "targetname" );
        self.e_org = spawn( "script_origin", self.origin );
        self linkto( self.e_org );
        self.e_org moveto( nd_start.origin, 3 );
        self.e_org waittill( #"movedone" );
    }
    
    level flag::wait_till( "warlord_fight" );
    self unlink();
    
    if ( isdefined( self.e_org ) )
    {
        self.e_org delete();
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xd3b28d21, Offset: 0x2f98
// Size: 0x54
function clear_force_goal()
{
    self endon( #"death" );
    self waittill( #"goal" );
    wait randomfloatrange( 0.5, 1.5 );
    self clearforcedgoal();
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x7b8f805e, Offset: 0x2ff8
// Size: 0x1c4
function warlord_retreat()
{
    self endon( #"death" );
    self setthreatbiasgroup( "warlords" );
    setthreatbias( "heroes", "warlords", -1000 );
    self thread function_b48ee8e();
    self.goalheight = 512;
    
    foreach ( node in level.var_d8ffea14 )
    {
        self warlordinterface::addpreferedpoint( node.origin, 4000, 8000 );
    }
    
    e_volume = getent( "vol_qzone_warlord", "targetname" );
    self setgoal( e_volume );
    level flag::wait_till( "warlord_retreat" );
    e_vol = getent( "vol_fallback_warlord", "targetname" );
    self setgoal( e_vol );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x9ff9da0c, Offset: 0x31c8
// Size: 0x140
function function_b48ee8e()
{
    self endon( #"death" );
    self thread function_5e294934();
    n_counter = 0;
    a_str_vo = [];
    a_str_vo[ 0 ] = "hend_grenades_ain_t_gonna_0";
    a_str_vo[ 1 ] = "hend_explosives_ain_t_doi_0";
    var_77987920 = [];
    var_77987920[ 0 ] = "plyr_i_hear_you_1";
    
    for ( var_b3d77f58 = 0; !var_b3d77f58 ; var_b3d77f58 = 1 )
    {
        self util::waittill_any( "projectile_applyattractor", "play_meleefx" );
        level.ai_hendricks dialog::say( a_str_vo[ n_counter ], 0.5 );
        
        if ( !n_counter )
        {
            level dialog::player_say( var_77987920[ n_counter ], 0.5 );
        }
        
        n_counter++;
        
        if ( n_counter == a_str_vo.size )
        {
        }
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x1d05b9d4, Offset: 0x3310
// Size: 0x5c
function function_5e294934()
{
    self endon( #"death" );
    wait 40;
    level.ai_hendricks dialog::say( "hend_come_on_take_that_0" );
    level dialog::player_say( "plyr_i_m_on_it_1", 0.5 );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xcf559c9f, Offset: 0x3378
// Size: 0x244
function spawn_truck_warlord()
{
    level flag::wait_till( "warlord_fight" );
    vh_truck = vehicle::simple_spawn_single( "truck_warlord" );
    vh_truck vehicle::lights_off();
    vh_truck util::magic_bullet_shield();
    vh_truck thread blackstation_utility::protect_riders();
    vh_truck playsound( "evt_tech_driveup_1" );
    vh_truck turret::disable_ai_getoff( 1, 1 );
    vh_truck turret::enable( 1, 1 );
    vh_truck turret::disable_ai_getoff( 1, 0 );
    level scene::init( "p7_fxanim_blackstation_warlord_intro_truck_bundle", vh_truck );
    level thread enemy_count_watcher( 3, "warlord_backup" );
    wait 5;
    vh_truck blackstation_utility::truck_unload( "passenger1" );
    vh_truck playsound( "evt_tech_driveup_2" );
    level scene::play( "p7_fxanim_blackstation_warlord_intro_truck_bundle", vh_truck );
    wait 1;
    vh_truck thread blackstation_utility::truck_unload( "driver" );
    vh_truck thread blackstation_utility::truck_gunner_replace( level.players.size - 1, 2, "warlord_fight_done" );
    vh_truck util::stop_magic_bullet_shield();
    vh_truck makevehicleusable();
    vh_truck setseatoccupied( 0 );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xc5cce4a3, Offset: 0x35c8
// Size: 0xa4
function warlord_backup_trigger()
{
    trigger::wait_till( "trigger_warlord_backup" );
    level flag::set( "warlord_backup" );
    level thread start_background_debris();
    level thread enemy_fallback();
    trigger::wait_till( "trigger_warlord_reinforce" );
    level flag::set( "warlord_reinforce" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xde164a25, Offset: 0x3678
// Size: 0x1e4
function spawn_warlord_backup()
{
    level flag::wait_till( "warlord_backup" );
    spawn_manager::enable( "sm_warlord_launchers" );
    util::wait_network_frame();
    spawner::simple_spawn( "warlord_backup_point" );
    wait 2;
    spawner::simple_spawn( "warlord_backup" );
    util::wait_network_frame();
    spawn_manager::enable( "sm_warlord_support" );
    
    if ( level.players.size == 4 )
    {
        util::wait_network_frame();
        spawner::simple_spawn_single( "warlord_partner", &warlord_retreat );
    }
    
    level thread warlord_backup_monitor();
    level flag::wait_till( "warlord_reinforce" );
    spawner::add_spawn_function_group( "warlord_reinforce", "targetname", &warlord_reinforce_spawnfunc );
    spawn_manager::enable( "sm_warlord_reinforce" );
    spawn_manager::wait_till_complete( "sm_warlord_reinforce" );
    level thread enemy_count_watcher( 3, "warlord_retreat" );
    level thread enemy_all_dead();
    level thread function_43439f74();
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x599c57f7, Offset: 0x3868
// Size: 0x98
function warlord_reinforce_spawnfunc()
{
    self ai::set_behavior_attribute( "sprint", 1 );
    self ai::set_ignoreall( 1 );
    self.goalradius = 4;
    self waittill( #"goal" );
    self ai::set_behavior_attribute( "sprint", 0 );
    self ai::set_ignoreall( 0 );
    self.goalradius = 2048;
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x7e3a534c, Offset: 0x3908
// Size: 0x44
function warlord_backup_monitor()
{
    spawner::waittill_ai_group_count( "group_warlord_backup", 3 );
    level flag::set( "warlord_reinforce" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x886b7408, Offset: 0x3958
// Size: 0x182
function function_43439f74()
{
    while ( true )
    {
        a_ai_enemies = getaiteamarray( "axis" );
        
        if ( a_ai_enemies.size < 4 )
        {
            break;
        }
        
        wait 1;
    }
    
    a_ai_enemies = getaiteamarray( "axis" );
    
    foreach ( ai_enemy in a_ai_enemies )
    {
        if ( isalive( ai_enemy ) )
        {
            if ( ai_enemy.archetype != "warlord" && ai_enemy.targetname !== "warlord_launcher_ai" && level.activeplayers.size )
            {
                e_player = level.activeplayers[ randomint( level.activeplayers.size ) ];
                ai_enemy setgoal( e_player, 1 );
            }
        }
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x778f84b6, Offset: 0x3ae8
// Size: 0xdc
function enemy_all_dead()
{
    level endon( #"debris_path_one_ready" );
    
    while ( getaiteamarray( "axis" ).size )
    {
        wait 0.5;
    }
    
    level thread namespace_4297372::function_973b77f9();
    wait 1;
    level.ai_hendricks dialog::say( "hend_all_clear_2" );
    level dialog::player_say( "plyr_that_was_one_tough_s_0", 1 );
    level.ai_hendricks dialog::say( "hend_i_wouldn_t_doubt_it_0", 0.5 );
    level flag::set( "qzone_done" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 2
// Checksum 0xa296a39, Offset: 0x3bd0
// Size: 0x54
function enemy_count_watcher( n_aicount, str_flag )
{
    while ( getaicount() > n_aicount + 1 )
    {
        wait 1;
    }
    
    level flag::set( str_flag );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xe34f37e6, Offset: 0x3c30
// Size: 0x3c
function enemy_fallback()
{
    level flag::wait_till( "warlord_retreat" );
    trigger::use( "triggercolor_warlord_fallback" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xeb91e986, Offset: 0x3c78
// Size: 0x50
function start_background_debris()
{
    level endon( #"warlord_fight_done" );
    
    while ( true )
    {
        level blackstation_utility::setup_random_debris();
        wait randomfloatrange( 3.5, 5.5 );
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x21b40c65, Offset: 0x3cd0
// Size: 0xb2
function shelter_blow_away()
{
    level thread scene::play( "p7_fxanim_cp_blackstation_shelter_wind_gust_bundle" );
    
    foreach ( player in level.activeplayers )
    {
        player playrumbleonentity( "cp_blackstation_shelter_rumble" );
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x72bef0e6, Offset: 0x3d90
// Size: 0xf4
function function_ec18f079()
{
    self endon( #"death" );
    
    while ( !level flag::get( "warlord_intro_prep" ) )
    {
        trigger::wait_till( "trigger_qzone_lowready", "targetname", self );
        self util::set_low_ready( 0 );
        
        while ( self istouching( getent( "trigger_qzone_lowready", "targetname" ) ) )
        {
            wait 1;
        }
        
        self util::set_low_ready( 1 );
        self thread function_7072c5d8();
    }
    
    self util::set_low_ready( 0 );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x1d134397, Offset: 0x3e90
// Size: 0xc0
function function_7072c5d8()
{
    self notify( #"hash_ca4d6265" );
    self endon( #"hash_ca4d6265" );
    self endon( #"death" );
    level endon( #"warlord_intro_prep" );
    
    while ( true )
    {
        self waittill( #"player_revived" );
        
        if ( level flag::get( "warlord_intro_prep" ) )
        {
            break;
        }
        
        if ( !self istouching( getent( "trigger_qzone_lowready", "targetname" ) ) )
        {
            self util::set_low_ready( 1 );
        }
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x9fbb5a8a, Offset: 0x3f58
// Size: 0x14c
function function_69df1ce()
{
    level flag::wait_till( "warlord_fight" );
    level.ai_hendricks dialog::say( "hend_gotta_get_to_cover_0", 1 );
    level.ai_hendricks dialog::say( "hend_heads_up_we_got_a_t_0", 1 );
    level flag::wait_till( "warlord_backup" );
    
    if ( level.players.size > 2 )
    {
        level.ai_hendricks dialog::say( "hend_rpg_up_high_0", 4 );
    }
    else
    {
        level.ai_hendricks dialog::say( "hend_hostiles_in_the_buil_0", 4 );
    }
    
    level.ai_hendricks dialog::say( "hend_clear_em_out_doub_0", 4 );
    level.ai_hendricks dialog::say( "hend_hit_him_with_the_mic_0", 1 );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xafc58e31, Offset: 0x40b0
// Size: 0xe4
function vo_qzone()
{
    level flag::wait_till( "vtol_jump" );
    level thread namespace_4297372::function_240ac8fa();
    level.ai_hendricks dialog::say( "hend_kane_we_re_on_grou_0" );
    level dialog::remote( "kane_copy_that_hendricks_0", 0.5 );
    wait 1;
    level flag::set( "obj_goto_docks" );
    trigger::wait_till( "trigger_hendricks_interact" );
    playsoundatposition( "evt_qzone_warlord_walla", ( 8795, 3873, -10 ) );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xe302a0fa, Offset: 0x41a0
// Size: 0xac
function function_251d954()
{
    level endon( #"warlord_approach" );
    level flag::wait_till( "executed_bodies" );
    wait 2.5;
    
    if ( !level flag::get( "warlord_approach" ) )
    {
        level dialog::remote( "kane_if_sensitive_materia_0", 0, "dni", undefined, 1 );
        wait 0.5;
        level.ai_hendricks dialog::say( "hend_understood_we_re_o_0" );
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 2
// Checksum 0x7e29f993, Offset: 0x4258
// Size: 0x17c
function objective_igc_init( str_objective, b_starting )
{
    load::function_73adcefc();
    blackstation_utility::init_hendricks( "objective_igc" );
    vehicle::add_spawn_function( "vtol_intro", &vtol_lights );
    vh_vtol = vehicle::simple_spawn_single( "vtol_intro" );
    level scene::init( "cin_bla_01_01_intro_1st" );
    level thread vtol_intro();
    level thread hendricks_qzone_path_igc();
    level thread hendricks_warlord_fight();
    level thread blackstation_utility::dead_civilians();
    level thread vo_warlord_intro();
    level flag::wait_till( "vtol_jump" );
    level clientfield::set( "gameplay_started", 1 );
    level skipto::objective_completed( "objective_igc" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 4
// Checksum 0xf660a93, Offset: 0x43e0
// Size: 0x24
function objective_igc_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 2
// Checksum 0x2f345ed0, Offset: 0x4410
// Size: 0x31c
function objective_qzone_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level thread function_13820fbf();
        blackstation_utility::init_hendricks( "objective_qzone" );
        level scene::init( "cin_bla_03_warlordintro_3rd_sh010" );
        load::function_a2995f22();
        level thread hendricks_qzone_path();
        level thread hendricks_warlord_fight();
        level thread blackstation_utility::dead_civilians();
        level thread vo_warlord_intro();
        level flag::set( "vtol_jump" );
        trigger::use( "trigger_hendricks_start" );
        
        foreach ( player in level.players )
        {
            player switchtoweapon( getweapon( "micromissile_launcher" ) );
        }
        
        level thread blackstation_utility::player_rain_intensity( "light_se" );
    }
    
    foreach ( player in level.activeplayers )
    {
        player thread function_ec18f079();
    }
    
    level thread function_f9c8936b();
    level thread function_2f7b86f3();
    level thread vo_qzone();
    level thread function_251d954();
    
    if ( isdefined( level.bzm_blackstationdialogue2callback ) )
    {
        level thread [[ level.bzm_blackstationdialogue2callback ]]();
    }
    
    level thread interact_warlord_intro( 0 );
    trigger::wait_till( "trigger_warlord_igc" );
    level skipto::objective_completed( "objective_qzone" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 4
// Checksum 0x79551348, Offset: 0x4738
// Size: 0x24
function objective_qzone_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x144e0329, Offset: 0x4768
// Size: 0x3c
function function_2f7b86f3()
{
    objectives::breadcrumb( "qzone_breadcrumb" );
    objectives::breadcrumb( "warlord_intro_breadcrumb", "cp_level_blackstation_climb" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 2
// Checksum 0xd0db405d, Offset: 0x47b0
// Size: 0x14c
function objective_warlord_igc_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        level thread function_13820fbf();
        blackstation_utility::init_hendricks( "objective_warlord_igc" );
        level thread blackstation_utility::dead_civilians();
        level scene::init( "cin_bla_03_warlordintro_3rd_sh010" );
        level flag::set( "obj_goto_docks" );
        load::function_a2995f22();
        level thread interact_warlord_intro( 1 );
        level thread hendricks_warlord_fight();
        level thread function_da48c515();
    }
    
    level flag::wait_till( "warlord_fight" );
    level skipto::objective_completed( "objective_warlord_igc" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 4
// Checksum 0x7a3f696, Offset: 0x4908
// Size: 0x24
function objective_warlord_igc_done( str_objective, b_starting, b_direct, player )
{
    
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x4a89495f, Offset: 0x4938
// Size: 0x24
function function_da48c515()
{
    objectives::breadcrumb( "warlord_intro_breadcrumb", "cp_level_blackstation_climb" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 2
// Checksum 0xe6cf67cf, Offset: 0x4968
// Size: 0x4f4
function objective_warlord_init( str_objective, b_starting )
{
    if ( b_starting )
    {
        load::function_73adcefc();
        blackstation_utility::init_hendricks( "objective_warlord" );
        level.ai_hendricks ai::set_ignoreme( 1 );
        level.ai_hendricks ai::set_ignoreall( 1 );
        level thread blackstation_utility::dead_civilians();
        level thread function_13820fbf();
        level thread objectives::breadcrumb( "anchor_intro_breadcrumb", "cp_level_blackstation_climb" );
        level thread cp_mi_sing_blackstation_port::debris_mound_breadcrumb();
        level thread scene::skipto_end( "p7_fxanim_cp_blackstation_shelter_wind_gust_bundle" );
        ai_warlord = spawner::simple_spawn_single( "warlordintro_warlord", &ignore_players );
        
        for ( x = 0; x < 3 ; x++ )
        {
            spawner::simple_spawn( "warlord_igc_" + x, &ignore_players );
        }
        
        level.var_d8ffea14 = getnodearray( "china_town_warlord_preferred_goal", "targetname" );
        ai_warlord thread warlord_death_watcher();
        ai_warlord thread warlord_retreat();
        level flag::set( "obj_goto_docks" );
        level flag::set( "warlord_fight" );
        level thread namespace_4297372::function_fa2e45b8();
        level thread hendricks_warlord_fight();
        level notify( #"hash_998c624d" );
        load::function_a2995f22();
        wait 0.1;
        
        foreach ( player in level.activeplayers )
        {
            player switchtoweapon( getweapon( "micromissile_launcher" ) );
        }
        
        level.ai_hendricks ai::set_ignoreme( 0 );
        level.ai_hendricks ai::set_ignoreall( 0 );
    }
    
    level thread blackstation_accolades::function_f0b50148();
    level thread blackstation_utility::function_46dd77b0();
    level thread spawn_truck_warlord();
    level thread spawn_warlord_backup();
    level thread warlord_backup_trigger();
    level thread function_69df1ce();
    level thread cp_mi_sing_blackstation_port::function_21f63154();
    
    foreach ( player in level.activeplayers )
    {
        player util::set_low_ready( 0 );
        player thread coop::function_e9f7384d();
    }
    
    trigger::wait_till( "trigger_hendricks_hotel_approach" );
    level flag::set( "warlord_fight_done" );
    level skipto::objective_completed( "objective_warlord" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 4
// Checksum 0x53f0ae7b, Offset: 0x4e68
// Size: 0x6c
function objective_warlord_done( str_objective, b_starting, b_direct, player )
{
    level thread blackstation_utility::function_d70754a2();
    showmiscmodels( "lt_wharf_water" );
    showmiscmodels( "vista_water" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x4aaef245, Offset: 0x4ee0
// Size: 0x44
function ignore_players()
{
    self endon( #"death" );
    self ai::set_ignoreall( 1 );
    wait 3;
    self ai::set_ignoreall( 0 );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x77412d02, Offset: 0x4f30
// Size: 0x15a
function function_f9c8936b()
{
    clientfield::set( "roof_panels_init", 1 );
    level thread function_f55bf5a1();
    level flag::wait_till( "roof_panels" );
    clientfield::set( "roof_panels_play", 1 );
    wait 2;
    var_b8a6ac3 = getent( "trigger_roof_panels", "targetname" );
    
    foreach ( player in level.activeplayers )
    {
        if ( player istouching( var_b8a6ac3 ) )
        {
            player playrumbleonentity( "bs_wind_rumble_low" );
        }
    }
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0x6d27a03, Offset: 0x5098
// Size: 0x5c
function function_f55bf5a1()
{
    e_panel = getent( "roof_panel", "targetname" );
    array::thread_all( level.activeplayers, &function_855a3b1c, e_panel );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 1
// Checksum 0x31629277, Offset: 0x5100
// Size: 0x6c
function function_855a3b1c( e_panel )
{
    self endon( #"death" );
    level endon( #"roof_panels" );
    self util::waittill_player_looking_at( e_panel.origin, 45, 1 );
    level flag::set( "roof_panels" );
}

// Namespace cp_mi_sing_blackstation_qzone
// Params 0
// Checksum 0xaecc5068, Offset: 0x5178
// Size: 0xf4
function function_13820fbf()
{
    objectives::set( "cp_level_blackstation_qzone" );
    objectives::set( "cp_level_blackstation_intercept" );
    level flag::wait_till( "obj_goto_docks" );
    objectives::set( "cp_level_blackstation_intercept" );
    objectives::set( "cp_level_blackstation_goto_docks" );
    level flag::wait_till( "warlord_fight" );
    objectives::set( "cp_level_blackstation_neutralize" );
    level flag::wait_till( "qzone_done" );
    objectives::complete( "cp_level_blackstation_neutralize" );
}

