#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_newworld_fx;
#using scripts/cp/cp_mi_zurich_newworld_patch_c;
#using scripts/cp/cp_mi_zurich_newworld_sound;
#using scripts/cp/cp_mi_zurich_newworld_util;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_zurich_newworld;

// Namespace cp_mi_zurich_newworld
// Params 0
// Checksum 0x1d003013, Offset: 0xd68
// Size: 0x94
function main()
{
    util::set_streamer_hint_function( &force_streamer, 10 );
    init_clientfields();
    cp_mi_zurich_newworld_fx::main();
    cp_mi_zurich_newworld_sound::main();
    load::main();
    util::waitforclient( 0 );
    cp_mi_zurich_newworld_patch_c::function_7403e82b();
}

// Namespace cp_mi_zurich_newworld
// Params 0
// Checksum 0xdf4634b7, Offset: 0xe08
// Size: 0x8dc
function init_clientfields()
{
    clientfield::register( "actor", "diaz_camo_shader", 1, 2, "int", &ent_camo_material_callback, 0, 1 );
    duplicate_render::set_dr_filter_framebuffer( "active_camo", 90, "actor_camo_on", "", 0, "mc/hud_outline_predator_camo_active_inf", 0 );
    duplicate_render::set_dr_filter_framebuffer( "active_camo_flicker", 80, "actor_camo_flicker", "", 0, "mc/hud_outline_predator_camo_disruption_inf", 0 );
    clientfield::register( "vehicle", "name_diaz_wasp", 1, 1, "int", &name_diaz_wasp, 0, 1 );
    clientfield::register( "scriptmover", "weakpoint", 1, 1, "int", &weakpoint, 0, 0 );
    duplicate_render::set_dr_filter_offscreen( "weakpoint_keyline", 100, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z", 2, "mc/hud_outline_model_z_orange", 1 );
    clientfield::register( "world", "factory_exterior_vents", 1, 1, "int", &factory_exterior_vents, 0, 0 );
    clientfield::register( "scriptmover", "open_vat_doors", 1, 1, "int", &function_2920b522, 0, 0 );
    clientfield::register( "world", "chase_pedestrian_blockers", 1, 1, "int", &chase_pedestrian_blockers, 0, 0 );
    clientfield::register( "toplayer", "chase_train_rumble", 1, 1, "int", &chase_train_rumble, 0, 0 );
    clientfield::register( "world", "spinning_vent_fxanim", 1, 1, "int", &spinning_vent_fxanim, 0, 0 );
    clientfield::register( "world", "crane_fxanim", 1, 1, "int", &crane_fxanim, 0, 0 );
    clientfield::register( "toplayer", "ability_wheel_tutorial", 1, 1, "int", &ability_wheel_tutorial, 0, 0 );
    clientfield::register( "world", "underground_subway_debris", 1, 2, "int", &underground_subway_debris, 0, 0 );
    clientfield::register( "world", "underground_subway_wires", 1, 1, "int", &function_9eeb165f, 0, 0 );
    clientfield::register( "world", "inbound_igc_glass", 1, 2, "int", &inbound_igc_glass, 0, 0 );
    clientfield::register( "world", "train_robot_swing_glass_left", 1, 2, "int", &train_robot_swing_glass_left, 0, 0 );
    clientfield::register( "world", "train_robot_swing_glass_right", 1, 2, "int", &train_robot_swing_glass_right, 0, 0 );
    clientfield::register( "world", "train_robot_swing_left_extra", 1, 1, "int", &function_54711778, 0, 0 );
    clientfield::register( "world", "train_robot_swing_right_extra", 1, 1, "int", &function_92f89bed, 0, 0 );
    clientfield::register( "world", "train_dropdown_glass", 1, 2, "int", &train_dropdown_glass, 0, 0 );
    clientfield::register( "world", "train_lockdown_glass_left", 1, 2, "int", &train_lockdown_glass_left, 0, 0 );
    clientfield::register( "world", "train_lockdown_glass_right", 1, 2, "int", &train_lockdown_glass_right, 0, 0 );
    clientfield::register( "world", "train_lockdown_shutters_1", 1, 1, "int", &train_lockdown_shutters_1, 0, 0 );
    clientfield::register( "world", "train_lockdown_shutters_2", 1, 1, "int", &train_lockdown_shutters_2, 0, 0 );
    clientfield::register( "world", "train_lockdown_shutters_3", 1, 1, "int", &train_lockdown_shutters_3, 0, 0 );
    clientfield::register( "world", "train_lockdown_shutters_4", 1, 1, "int", &train_lockdown_shutters_4, 0, 0 );
    clientfield::register( "world", "train_lockdown_shutters_5", 1, 1, "int", &train_lockdown_shutters_5, 0, 0 );
    clientfield::register( "actor", "train_throw_robot_corpses", 1, 1, "int", &function_b758d8f, 0, 0 );
    clientfield::register( "scriptmover", "train_throw_robot_corpses", 1, 1, "int", &function_b758d8f, 0, 0 );
    clientfield::register( "world", "train_brake_flaps", 1, 2, "int", &train_brake_flaps, 0, 0 );
    clientfield::register( "world", "sndTrainContext", 1, 2, "int", &cp_mi_zurich_newworld_sound::sndTrainContext, 0, 0 );
}

// Namespace cp_mi_zurich_newworld
// Params 1
// Checksum 0x1ece4ad5, Offset: 0x16f0
// Size: 0x2be
function force_streamer( n_zone )
{
    switch ( n_zone )
    {
        case 1:
            break;
        case 2:
            forcestreamxmodel( "c_hro_taylor_base_fb" );
            forcestreamxmodel( "c_hro_diaz_base" );
            forcestreambundle( "cin_new_02_01_pallasintro_vign_appear" );
            forcestreambundle( "cin_new_02_01_pallasintro_vign_appear_player" );
            break;
        case 3:
            forcestreamxmodel( "c_hro_taylor_base_fb" );
            forcestreamxmodel( "c_hro_diaz_base" );
            forcestreambundle( "cin_new_04_01_insideman_1st_hack_sh010" );
            forcestreambundle( "cin_new_04_01_insideman_1st_hack_sh320" );
            forcestreambundle( "p7_fxanim_cp_sgen_charging_station_break_02_bundle" );
            forcestreambundle( "cin_sgen_16_01_charging_station_aie_awaken_robot03" );
            forcestreambundle( "cin_sgen_16_01_charging_station_aie_awaken_robot04" );
            break;
        case 6:
            forcestreamxmodel( "c_hro_taylor_base_fb" );
            forcestreamxmodel( "c_hro_maretti_base_fb" );
            forcestreambundle( "cin_new_10_01_pinneddown_1st_explanation" );
            break;
        case 7:
            forcestreambundle( "cin_new_13_01_stagingroom_1st_guidance" );
            break;
        case 8:
            forcestreamxmodel( "c_hro_taylor_base_fb" );
            forcestreambundle( "cin_new_14_01_inbound_1st_preptalk" );
            forcestreambundle( "p7_fxanim_cp_newworld_train_glass_01_bundle" );
            break;
        case 9:
            forcestreamxmodel( "c_hro_taylor_base_fb" );
            forcestreambundle( "p7_fxanim_cp_newworld_train_end_bundle" );
            forcestreambundle( "cin_new_16_01_detachbombcar_1st_detach" );
            break;
        case 10:
            forcestreambundle( "cin_new_17_01_wakingup_1st_reveal" );
            forcestreambundle( "p7_fxanim_cp_newworld_curtain_bundle" );
            break;
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0xb31b7d20, Offset: 0x19b8
// Size: 0x94
function factory_exterior_vents( local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        smodelanimcmd( "factory_vents", "pause" );
        return;
    }
    
    smodelanimcmd( "factory_vents", "unpause" );
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0x631cf453, Offset: 0x1a58
// Size: 0xa4
function ent_camo_material_callback( local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self duplicate_render::set_dr_flag( "actor_camo_flicker", newval == 2 );
    self duplicate_render::set_dr_flag( "actor_camo_on", newval != 0 );
    self duplicate_render::change_dr_flags( local_client_num );
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0x557bb92a, Offset: 0x1b08
// Size: 0xcc
function weakpoint( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self duplicate_render::change_dr_flags( localclientnum, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z" );
        self weakpoint_enable( 2 );
        return;
    }
    
    self duplicate_render::change_dr_flags( localclientnum, "weakpoint_keyline_hide_z", "weakpoint_keyline_show_z" );
    self weakpoint_enable( 0 );
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0x8fbb0d25, Offset: 0x1be0
// Size: 0x64
function name_diaz_wasp( local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self setdrawname( "Diaz", 1 );
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0xfa0c5d1e, Offset: 0x1c50
// Size: 0x84
function chase_pedestrian_blockers( local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        function_1583bd50( local_client_num, 1 );
        return;
    }
    
    function_1583bd50( local_client_num, 0 );
}

// Namespace cp_mi_zurich_newworld
// Params 2
// Checksum 0xc6d7ec7b, Offset: 0x1ce0
// Size: 0x272
function function_1583bd50( localclientnum, var_f4d36bbd )
{
    if ( !isdefined( var_f4d36bbd ) )
    {
        var_f4d36bbd = 1;
    }
    
    if ( var_f4d36bbd )
    {
        var_9da3bffd = 1;
    }
    else
    {
        var_9da3bffd = -1;
    }
    
    var_929d2c59 = getentarray( localclientnum, "train_ped_blocker_right", "targetname" );
    
    foreach ( e_blocker in var_929d2c59 )
    {
        if ( e_blocker.script_noteworthy === "train_ped_blocker_mirrored" )
        {
            e_blocker movex( 64 * var_9da3bffd, 0.5 );
            continue;
        }
        
        e_blocker movex( 64 * var_9da3bffd * -1, 0.5 );
    }
    
    var_ba59f2a4 = getentarray( localclientnum, "train_ped_blocker_left", "targetname" );
    
    foreach ( e_blocker in var_ba59f2a4 )
    {
        if ( e_blocker.script_noteworthy === "train_ped_blocker_mirrored" )
        {
            e_blocker movex( 64 * var_9da3bffd * -1, 0.5 );
            continue;
        }
        
        e_blocker movex( 64 * var_9da3bffd, 0.5 );
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0xe6de1e94, Offset: 0x1f60
// Size: 0x94
function chase_train_rumble( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self playrumblelooponentity( localclientnum, "cp_newworld_rumble_chase_train_near" );
        return;
    }
    
    self stoprumble( localclientnum, "cp_newworld_rumble_chase_train_near" );
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0xa4193bb8, Offset: 0x2000
// Size: 0xcc
function spinning_vent_fxanim( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        level thread scene::play( "p7_fxanim_gp_vent_roof_wobble_bundle" );
        level thread scene::play( "p7_fxanim_gp_vent_roof_slow_bundle" );
        return;
    }
    
    level thread scene::stop( "p7_fxanim_gp_vent_roof_wobble_bundle", 1 );
    level thread scene::stop( "p7_fxanim_gp_vent_roof_slow_bundle", 1 );
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0x64854150, Offset: 0x20d8
// Size: 0xcc
function crane_fxanim( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        level thread scene::play( "p7_fxanim_gp_crane_hook_small_01_bundle" );
        level thread scene::play( "p7_fxanim_gp_crane_pallet_01_bundle" );
        return;
    }
    
    level thread scene::stop( "p7_fxanim_gp_crane_hook_small_01_bundle", 1 );
    level thread scene::stop( "p7_fxanim_gp_crane_pallet_01_bundle", 1 );
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0xbb8fc06d, Offset: 0x21b0
// Size: 0x3c
function ability_wheel_tutorial( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0xae6b064a, Offset: 0x21f8
// Size: 0xac
function underground_subway_debris( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        scene::init( "p7_fxanim_cp_newworld_subway_debris_01_bundle" );
        return;
    }
    
    if ( newval == 2 )
    {
        scene::play( "p7_fxanim_cp_newworld_subway_debris_01_bundle" );
        return;
    }
    
    scene::stop( "p7_fxanim_cp_newworld_subway_debris_01_bundle", 1 );
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0xae206d12, Offset: 0x22b0
// Size: 0xe4
function inbound_igc_glass( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        scene::init( "p7_fxanim_cp_newworld_train_glass_01_bundle" );
        return;
    }
    
    if ( newval == 2 )
    {
        scene::play( "p7_fxanim_cp_newworld_train_glass_01_bundle" );
        return;
    }
    
    e_glass = getent( localclientnum, "newworld_train_glass_01", "targetname" );
    
    if ( isdefined( e_glass ) )
    {
        e_glass delete();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0xc25c284b, Offset: 0x23a0
// Size: 0x16a
function train_robot_swing_glass_left( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        scene::init( "p7_fxanim_cp_newworld_train_glass_02_bundle" );
        return;
    }
    
    if ( newval == 2 )
    {
        s_scene = struct::get( "train_glass_left_01", "targetname" );
        s_scene scene::play();
        return;
    }
    
    a_e_glass = getentarray( localclientnum, "newworld_train_glass_02", "targetname" );
    
    foreach ( e_glass in a_e_glass )
    {
        e_glass delete();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0x7d382f42, Offset: 0x2518
// Size: 0x16a
function train_robot_swing_glass_right( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        scene::init( "p7_fxanim_cp_newworld_train_glass_03_bundle" );
        return;
    }
    
    if ( newval == 2 )
    {
        s_scene = struct::get( "train_glass_right_02", "targetname" );
        s_scene scene::play();
        return;
    }
    
    a_e_glass = getentarray( localclientnum, "newworld_train_glass_03", "targetname" );
    
    foreach ( e_glass in a_e_glass )
    {
        e_glass delete();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0xe413309, Offset: 0x2690
// Size: 0x8c
function function_54711778( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        s_scene = struct::get( "train_glass_left_02", "targetname" );
        s_scene scene::play();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0xa1fa10ca, Offset: 0x2728
// Size: 0x8c
function function_92f89bed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        s_scene = struct::get( "train_glass_right_02", "targetname" );
        s_scene scene::play();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0xfbbd417a, Offset: 0x27c0
// Size: 0xe4
function train_dropdown_glass( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        scene::init( "p7_fxanim_cp_newworld_train_glass_06_bundle" );
        return;
    }
    
    if ( newval == 2 )
    {
        scene::play( "p7_fxanim_cp_newworld_train_glass_06_bundle" );
        return;
    }
    
    e_glass = getent( localclientnum, "newworld_train_glass_06", "targetname" );
    
    if ( isdefined( e_glass ) )
    {
        e_glass delete();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0x6c447fd1, Offset: 0x28b0
// Size: 0x10c
function train_lockdown_glass_left( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        scene::init( "p7_fxanim_cp_newworld_train_glass_04_bundle" );
        return;
    }
    
    if ( newval == 2 )
    {
        scene::play( "p7_fxanim_cp_newworld_train_glass_04_bundle" );
        audio::playloopat( "amb_train_window_wind", ( -20401, 15614, 4293 ) );
        return;
    }
    
    e_glass = getent( localclientnum, "newworld_train_glass_04", "targetname" );
    
    if ( isdefined( e_glass ) )
    {
        e_glass delete();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0xfa08f401, Offset: 0x29c8
// Size: 0xf2
function train_lockdown_glass_right( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        scene::init( "p7_fxanim_cp_newworld_train_glass_05_bundle" );
    }
    else if ( newval == 2 )
    {
        scene::play( "p7_fxanim_cp_newworld_train_glass_05_bundle" );
    }
    else
    {
        e_glass = getent( localclientnum, "newworld_train_glass_05", "targetname" );
        
        if ( isdefined( e_glass ) )
        {
            e_glass delete();
        }
    }
    
    level notify( #"hash_6b336e59" );
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0x951ada5a, Offset: 0x2ac8
// Size: 0x142
function train_lockdown_shutters_1( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        s_scene = struct::get( "train_shutter_01", "targetname" );
        s_scene scene::play();
        return;
    }
    
    var_d4260265 = getentarray( localclientnum, "newworld_train_shutters_01", "targetname" );
    
    foreach ( e_fx_anim in var_d4260265 )
    {
        e_fx_anim delete();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0x89aa7ec2, Offset: 0x2c18
// Size: 0x8c
function train_lockdown_shutters_2( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        s_scene = struct::get( "train_shutter_02", "targetname" );
        s_scene scene::play();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0x4c1bbe3e, Offset: 0x2cb0
// Size: 0x8c
function train_lockdown_shutters_3( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        s_scene = struct::get( "train_shutter_03", "targetname" );
        s_scene scene::play();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0xc4a2307d, Offset: 0x2d48
// Size: 0x8c
function train_lockdown_shutters_4( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        s_scene = struct::get( "train_shutter_04", "targetname" );
        s_scene scene::play();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0x117b8102, Offset: 0x2de0
// Size: 0x8c
function train_lockdown_shutters_5( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        s_scene = struct::get( "train_shutter_05", "targetname" );
        s_scene scene::play();
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0x8559655e, Offset: 0x2e78
// Size: 0x96
function function_b758d8f( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self.n_time = gettime();
        self thread function_965a6439( localclientnum );
        self thread function_a860cb86( localclientnum );
        return;
    }
    
    level notify( #"hash_4ce164a6" );
}

// Namespace cp_mi_zurich_newworld
// Params 1
// Checksum 0xf67fdfc, Offset: 0x2f18
// Size: 0x1a4
function function_965a6439( localclientnum )
{
    level endon( #"hash_4ce164a6" );
    self endon( #"death" );
    
    if ( isdefined( 10 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 10, "timeout" );
    }
    
    var_5cf8a2dd = getent( localclientnum, "train_bad_area_corpses", "targetname" );
    
    while ( isdefined( self ) )
    {
        if ( self istouching( var_5cf8a2dd ) )
        {
            n_x = randomfloatrange( 700, 800 );
            n_y = randomfloatrange( -100, 100 );
            n_z = randomfloatrange( 10, 100 );
            self launchragdoll( ( n_x, n_y, n_z ) );
            self thread newworld_util::function_52bc98a1( localclientnum );
            break;
        }
        
        wait 0.05;
    }
}

// Namespace cp_mi_zurich_newworld
// Params 1
// Checksum 0xbb857e31, Offset: 0x30c8
// Size: 0x3e4
function function_a860cb86( localclientnum )
{
    level endon( #"hash_4ce164a6" );
    self endon( #"death" );
    
    if ( isdefined( 10 ) )
    {
        __s = spawnstruct();
        __s endon( #"timeout" );
        __s util::delay_notify( 10, "timeout" );
    }
    
    var_accfeb6 = getentarray( localclientnum, "train_roof_brakeflap_trigger", "targetname" );
    var_623b9b = getentarray( localclientnum, "train_roof_flap", "targetname" );
    
    while ( isdefined( self ) )
    {
        foreach ( var_4f00cbcf in var_accfeb6 )
        {
            if ( self istouching( var_4f00cbcf ) && self.var_2c3c4e50 !== var_4f00cbcf )
            {
                self.var_2c3c4e50 = var_4f00cbcf;
                var_9881fa10 = arraygetclosest( self.origin, var_623b9b );
                
                if ( !( isdefined( var_9881fa10.var_a3256cdc ) && var_9881fa10.var_a3256cdc ) )
                {
                    n_time_delta = -1;
                    
                    if ( isdefined( self.n_time ) )
                    {
                        n_time_end = gettime();
                        n_time_delta = n_time_end - self.n_time;
                    }
                    
                    if ( !isdefined( self.n_modifier ) )
                    {
                        if ( math::cointoss() == 1 )
                        {
                            self.n_modifier = 1;
                        }
                        else
                        {
                            self.n_modifier = -1;
                        }
                    }
                    
                    if ( n_time_delta <= 300 )
                    {
                        n_y = randomfloatrange( 10, 30 ) * self.n_modifier;
                        n_z = randomfloatrange( 40, 50 );
                    }
                    else if ( n_time_delta > 300 && n_time_delta <= 600 )
                    {
                        n_y = randomfloatrange( 30, 50 ) * self.n_modifier;
                        n_z = randomfloatrange( 50, 60 );
                    }
                    else
                    {
                        n_y = randomfloatrange( 50, 70 ) * self.n_modifier;
                        n_z = randomfloatrange( 60, 70 );
                    }
                    
                    self launchragdoll( ( 0, n_y, n_z ) );
                    level thread function_a251bd0b( localclientnum, var_9881fa10 );
                    wait 0.25;
                    break;
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace cp_mi_zurich_newworld
// Params 2
// Checksum 0xb0927fe1, Offset: 0x34b8
// Size: 0xbc
function function_a251bd0b( localclientnum, var_9881fa10 )
{
    var_9881fa10.var_a3256cdc = 1;
    var_9881fa10 notify( #"hash_47e64fc0" );
    var_9881fa10 rotatepitch( 25, 0.25 );
    var_9881fa10 waittill( #"rotatedone" );
    var_9881fa10 rotatepitch( -25, 0.5 );
    var_9881fa10 thread train_brake_flaps_ambient_movement( localclientnum );
    wait 0.5;
    var_9881fa10.var_a3256cdc = 0;
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0x9adca36c, Offset: 0x3580
// Size: 0x3ba
function train_brake_flaps( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        a_e_flaps = getentarray( localclientnum, "train_roof_flap", "targetname" );
        
        foreach ( e_flap in a_e_flaps )
        {
            e_flap.angles = ( 90, 0, 0 );
        }
        
        return;
    }
    
    if ( newval == 0 )
    {
        s_back = struct::get( "front_of_the_train", "targetname" );
        a_e_flaps = getentarray( localclientnum, "train_roof_flap", "targetname" );
        a_e_flaps = array::get_all_closest( s_back.origin, a_e_flaps );
        n_count = 0;
        
        foreach ( e_flap in a_e_flaps )
        {
            if ( !isdefined( e_flap ) )
            {
                break;
            }
            
            e_flap rotatepitch( -90, 0.5 );
            e_flap thread train_brake_flaps_ambient_movement( localclientnum );
            e_flap thread newworld_util::function_ff1b6796( localclientnum );
            e_flap playloopsound( "evt_airbreak_loop" );
            e_flap playsound( 0, "evt_airbreak_deploy" );
            n_count++;
            
            if ( n_count % 3 == 0 )
            {
                wait 0.25;
            }
        }
        
        return;
    }
    
    if ( newval == 2 )
    {
        level notify( #"newworld_train_complete" );
        a_e_flaps = getentarray( localclientnum, "train_roof_flap", "targetname" );
        
        foreach ( e_flap in a_e_flaps )
        {
            if ( isdefined( e_flap.var_f3f44e9 ) )
            {
                e_flap.var_f3f44e9 delete();
            }
            
            e_flap delete();
        }
    }
}

// Namespace cp_mi_zurich_newworld
// Params 1
// Checksum 0x3475560b, Offset: 0x3948
// Size: 0xf4
function train_brake_flaps_ambient_movement( localclientnum )
{
    level endon( #"newworld_train_complete" );
    self endon( #"hash_47e64fc0" );
    self waittill( #"rotatedone" );
    
    while ( true )
    {
        n_rotate_amount = randomfloatrange( 2, 5 );
        n_rotate_time = randomfloatrange( 0.15, 0.25 );
        self rotatepitch( n_rotate_amount, n_rotate_time );
        self waittill( #"rotatedone" );
        n_rotate_amount *= -1;
        self rotatepitch( n_rotate_amount, n_rotate_time );
        self waittill( #"rotatedone" );
    }
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0x6bebaa4c, Offset: 0x3a48
// Size: 0x274
function function_2920b522( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    var_280d5f68 = arraygetclosest( self.origin, getentarray( localclientnum, "vat_door_left", "targetname" ) );
    var_3c301126 = arraygetclosest( self.origin, getentarray( localclientnum, "vat_door_right", "targetname" ) );
    v_side = anglestoright( var_280d5f68.angles );
    
    if ( newval )
    {
        v_pos_left = var_280d5f68.origin + v_side * 60;
        var_280d5f68 moveto( v_pos_left, 1.5 );
        v_pos_right = var_3c301126.origin + v_side * 60 * -1;
        var_3c301126 moveto( v_pos_right, 1.5 );
        var_3c301126 playsound( 0, "evt_vat_door_open" );
        return;
    }
    
    v_pos_left = var_280d5f68.origin + v_side * 60 * -1;
    var_280d5f68 moveto( v_pos_left, 1.5 );
    v_pos_right = var_3c301126.origin + v_side * 60;
    var_3c301126 moveto( v_pos_right, 1.5 );
    var_3c301126 playsound( 0, "evt_vat_door_close" );
}

// Namespace cp_mi_zurich_newworld
// Params 7
// Checksum 0x869ace88, Offset: 0x3cc8
// Size: 0x10c
function function_9eeb165f( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_gp_wire_sparking_xsml_bundle" );
        level thread scene::play( "p7_fxanim_gp_wire_sparking_xsml_thick_bundle" );
        level thread scene::play( "p7_fxanim_gp_wire_sparking_sml_bundle" );
        return;
    }
    
    level scene::stop( "p7_fxanim_gp_wire_sparking_xsml_thick_bundle", 1 );
    level scene::stop( "p7_fxanim_gp_wire_sparking_xsml_bundle", 1 );
    level scene::stop( "p7_fxanim_gp_wire_sparking_sml_bundle", 1 );
}

