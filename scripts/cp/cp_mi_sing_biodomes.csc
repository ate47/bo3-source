#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_squad_control;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_biodomes_fx;
#using scripts/cp/cp_mi_sing_biodomes_patch_c;
#using scripts/cp/cp_mi_sing_biodomes_sound;
#using scripts/shared/clientfield_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_sing_biodomes;

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0xf6711b1d, Offset: 0x768
// Size: 0x94
function main()
{
    clientfields_init();
    util::set_streamer_hint_function( &force_streamer, 2 );
    cp_mi_sing_biodomes_fx::main();
    cp_mi_sing_biodomes_sound::main();
    load::main();
    util::waitforclient( 0 );
    cp_mi_sing_biodomes_patch_c::function_7403e82b();
}

// Namespace cp_mi_sing_biodomes
// Params 0
// Checksum 0x7ada69b5, Offset: 0x808
// Size: 0x4cc
function clientfields_init()
{
    clientfield::register( "toplayer", "player_dust_fx", 1, 1, "int", &function_b33fd8cd, 0, 0 );
    clientfield::register( "toplayer", "player_waterfall_pstfx", 1, 1, "int", &player_waterfall_callback, 0, 0 );
    clientfield::register( "toplayer", "bullet_disconnect_pstfx", 1, 1, "int", &bullet_disconnect_callback, 0, 0 );
    clientfield::register( "toplayer", "zipline_speed_blur", 1, 1, "int", &zipline_speed_blur, 0, 0 );
    clientfield::register( "toplayer", "umbra_tome_markets2", 1, 1, "counter", &umbra_tome_markets2, 0, 0 );
    clientfield::register( "scriptmover", "waiter_blood_shader", 1, 1, "int", &function_81199318, 0, 0 );
    clientfield::register( "world", "set_exposure_bank", 1, 1, "int", &set_exposure_bank, 0, 0 );
    clientfield::register( "world", "party_house_shutter", 1, 1, "int", &party_house_shutter, 0, 0 );
    clientfield::register( "world", "party_house_destruction", 1, 1, "int", &party_house_destruction, 0, 0 );
    clientfield::register( "world", "dome_glass_break", 1, 1, "int", &dome_glass_break, 0, 0 );
    clientfield::register( "world", "warehouse_window_break", 1, 1, "int", &warehouse_window_break, 0, 0 );
    clientfield::register( "world", "control_room_window_break", 1, 1, "int", &control_room_window_break, 0, 0 );
    clientfield::register( "toplayer", "server_extra_cam", 1, 5, "int", &server_extra_cam, 0, 0 );
    clientfield::register( "toplayer", "server_interact_cam", 1, 3, "int", &server_interact_cam, 0, 0 );
    clientfield::register( "world", "cloud_mountain_crows", 1, 2, "int", &cloud_mountain_crows, 0, 0 );
    clientfield::register( "world", "fighttothedome_exfil_rope", 1, 2, "int", &fighttothedome_exfil_rope, 0, 0 );
    clientfield::register( "world", "fighttothedome_exfil_rope_sim_player", 1, 1, "int", &fighttothedome_exfil_rope_sim_player, 0, 0 );
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0x34d4c0eb, Offset: 0xce0
// Size: 0x126
function player_bullet_transition( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    switch ( newval )
    {
        case 2:
            self thread postfx::playpostfxbundle( "pstfx_vehicle_takeover_fade_in" );
            playsound( 0, "gdt_securitybreach_transition_in", ( 0, 0, 0 ) );
            break;
        case 3:
            self thread postfx::playpostfxbundle( "pstfx_vehicle_takeover_fade_out" );
            playsound( 0, "gdt_securitybreach_transition_out", ( 0, 0, 0 ) );
            break;
        case 1:
            self thread postfx::stoppostfxbundle();
            break;
        case 4:
            self thread postfx::playpostfxbundle( "pstfx_vehicle_takeover_white" );
            break;
    }
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0xae8c06d8, Offset: 0xe10
// Size: 0x5c
function umbra_tome_markets2( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    umbra_settometriggeronce( localclientnum, "markets2" );
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0xfd450113, Offset: 0xe78
// Size: 0x3c
function player_waterfall_callback( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0xd6509ba8, Offset: 0xf00
// Size: 0x7c
function bullet_disconnect_callback( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        self thread postfx::playpostfxbundle( "pstfx_dni_screen_futz" );
        return;
    }
    
    self thread postfx::stoppostfxbundle();
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0x31b689d6, Offset: 0xf88
// Size: 0x94
function zipline_speed_blur( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        enablespeedblur( localclientnum, 0.07, 0.55, 0.9, 0, 100, 100 );
        return;
    }
    
    disablespeedblur( localclientnum );
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0x897e0ae2, Offset: 0x1028
// Size: 0x130
function function_81199318( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"entityshutdown" );
    n_start_time = gettime();
    b_is_updating = 1;
    
    while ( b_is_updating )
    {
        n_time = gettime();
        var_348e23ad = ( n_time - n_start_time ) / 1000;
        
        if ( var_348e23ad >= 4 )
        {
            var_348e23ad = 4;
            b_is_updating = 0;
        }
        
        var_cba49b4e = 0.9 * var_348e23ad / 4;
        self mapshaderconstant( localclientnum, 0, "scriptVector0", var_cba49b4e, 0, 0 );
        wait 0.01;
    }
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0x92ced728, Offset: 0x1160
// Size: 0x64
function party_house_shutter( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_biodomes_roll_up_door_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0x6b4cd45d, Offset: 0x11d0
// Size: 0xa4
function party_house_destruction( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_biodomes_party_house_bundle" );
        level thread scene::play( "p7_fxanim_gp_lantern_paper_04_red_single_bundle" );
        level thread scene::play( "p7_fxanim_gp_lantern_paper_03_red_single_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0x2712e5c7, Offset: 0x1280
// Size: 0x64
function dome_glass_break( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_biodomes_rpg_dome_glass_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0xeebf8efc, Offset: 0x12f0
// Size: 0x64
function warehouse_window_break( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_biodomes_warehouse_glass_break_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0x7739d6b1, Offset: 0x1360
// Size: 0x64
function control_room_window_break( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_biodomes_server_room_window_break_02_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0x4e953b70, Offset: 0x13d0
// Size: 0x94
function cloud_mountain_crows( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        level thread scene::init( "p7_fxanim_cp_biodomes_crow_takeoff_bundle" );
        return;
    }
    
    if ( newval == 2 )
    {
        level thread scene::play( "p7_fxanim_cp_biodomes_crow_takeoff_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0x280c0abc, Offset: 0x1470
// Size: 0x134
function fighttothedome_exfil_rope( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        scene::add_scene_func( "p7_fxanim_cp_biodomes_rope_sim_player_bundle", &function_1f0ba50, "init" );
        level thread scene::init( "p7_fxanim_cp_biodomes_rope_drop_player_bundle" );
        level thread scene::init( "p7_fxanim_cp_biodomes_rope_sim_player_bundle" );
        wait 1;
        level thread scene::play( "p7_fxanim_cp_biodomes_rope_drop_hendricks_bundle" );
        return;
    }
    
    if ( newval == 2 )
    {
        level thread scene::stop( "p7_fxanim_cp_biodomes_rope_drop_hendricks_bundle", 1 );
        level thread scene::play( "p7_fxanim_cp_biodomes_rope_drop_player_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes
// Params 1
// Checksum 0xbfb6788, Offset: 0x15b0
// Size: 0x2c
function function_1f0ba50( a_ents )
{
    a_ents[ "rope_sim_player" ] hide();
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0xe7747c11, Offset: 0x15e8
// Size: 0x94
function fighttothedome_exfil_rope_sim_player( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        scene::add_scene_func( "p7_fxanim_cp_biodomes_rope_sim_player_bundle", &function_be7ae167, "play" );
        level thread scene::play( "p7_fxanim_cp_biodomes_rope_sim_player_bundle" );
    }
}

// Namespace cp_mi_sing_biodomes
// Params 1
// Checksum 0x64192f3f, Offset: 0x1688
// Size: 0x2c
function function_be7ae167( a_ents )
{
    a_ents[ "rope_sim_player" ] show();
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0xa745fe02, Offset: 0x16c0
// Size: 0x21e
function server_extra_cam( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    e_xcam1 = getent( localclientnum, "server_camera1", "targetname" );
    e_xcam2 = getent( localclientnum, "server_camera2", "targetname" );
    e_xcam3 = getent( localclientnum, "server_camera3", "targetname" );
    e_xcam4 = getent( localclientnum, "server_camera4", "targetname" );
    
    switch ( newval )
    {
        case 0:
            break;
        case 1:
            e_xcam2 setextracam( 0 );
            break;
        case 2:
            e_xcam1 setextracam( 0 );
            break;
        case 3:
            e_xcam3 setextracam( 0 );
            e_xcam3 rotateyaw( 35, 2 );
            break;
        case 4:
            e_xcam4 setextracam( 0 );
            break;
        case 5:
            e_xcam3 setextracam( 0 );
            e_xcam3 rotateyaw( -35, 2 );
            break;
    }
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0xf3470e3b, Offset: 0x18e8
// Size: 0x5c
function server_interact_cam( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    
}

// Namespace cp_mi_sing_biodomes
// Params 1
// Checksum 0xf3d3da9e, Offset: 0x1ac0
// Size: 0xde
function force_streamer( n_zone )
{
    switch ( n_zone )
    {
        case 1:
            streamtexturelist( "cp_mi_sing_biodomes" );
            forcestreambundle( "cin_bio_01_01_party_1st_drinks" );
            forcestreambundle( "cin_bio_01_01_party_1st_drinks_part2" );
            forcestreambundle( "p7_fxanim_cp_biodomes_party_house_drinks_bundle" );
            forcestreambundle( "p7_fxanim_cp_biodomes_roll_up_door_bundle" );
            break;
        case 2:
            forcestreamxmodel( "c_54i_supp_body" );
            forcestreamxmodel( "c_54i_supp_head1" );
            break;
    }
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0x36424dfc, Offset: 0x1ba8
// Size: 0x7c
function set_exposure_bank( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        setexposureactivebank( localclientnum, 4 );
        return;
    }
    
    setexposureactivebank( localclientnum, 1 );
}

// Namespace cp_mi_sing_biodomes
// Params 7
// Checksum 0xc1357463, Offset: 0x1c30
// Size: 0xec
function function_b33fd8cd( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        if ( isdefined( self.n_fx_id ) )
        {
            deletefx( localclientnum, self.n_fx_id, 1 );
        }
        
        self.n_fx_id = playfxoncamera( localclientnum, level._effect[ "player_dust" ], ( 0, 0, 0 ), ( 1, 0, 0 ), ( 0, 0, 1 ) );
        return;
    }
    
    if ( isdefined( self.n_fx_id ) )
    {
        deletefx( localclientnum, self.n_fx_id, 1 );
    }
}

