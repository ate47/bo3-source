#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_oed;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue_patch_c;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/exploder_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace cp_mi_eth_prologue;

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x2f3da00b, Offset: 0xa80
// Size: 0x104
function main()
{
    util::set_streamer_hint_function( &force_streamer, 7 );
    precache_scripted_fx();
    clientfields_init();
    cp_mi_eth_prologue_fx::main();
    cp_mi_eth_prologue_sound::main();
    visionset_mgr::fog_vol_to_visionset_set_info( 0, "cp_mi_eth_prologue", 0 );
    visionset_mgr::fog_vol_to_visionset_set_info( 1, "cp_mi_eth_prologue", 0 );
    load::main();
    util::waitforclient( 0 );
    setdvar( "sv_mapswitch", 1 );
    cp_mi_eth_prologue_patch_c::function_7403e82b();
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x45e3de9e, Offset: 0xb90
// Size: 0x1e
function precache_scripted_fx()
{
    level._effect[ "player_tunnel_dust" ] = "dirt/fx_dust_motes_player_loop_lite";
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0xbc24811e, Offset: 0xbb8
// Size: 0x6a4
function clientfields_init()
{
    clientfield::register( "world", "tunnel_wall_explode", 1, 1, "int", &tunnel_wall_explode, 0, 0 );
    clientfield::register( "toplayer", "unlimited_sprint_off", 1, 1, "int", &function_9e6eac31, 0, 0 );
    clientfield::register( "world", "apc_rail_tower_collapse", 1, 1, "int", &apc_rail_tower_collapse, 1, 0 );
    clientfield::register( "world", "vtol_missile_explode_trash_fx", 1, 1, "int", &vtol_missile_explode_trash_fx, 1, 0 );
    clientfield::register( "toplayer", "turn_on_multicam", 1, 3, "int", &player_turn_on_extra_cam, 0, 0 );
    clientfield::register( "world", "setup_security_cameras", 1, 1, "int", &setup_security_cameras, 0, 0 );
    clientfield::register( "scriptmover", "update_camera_position", 1, 4, "int", &function_9fd7493, 0, 0 );
    clientfield::register( "world", "interrogate_physics", 1, 1, "int", &function_a1ad4aa7, 0, 0 );
    clientfield::register( "toplayer", "set_cam_lookat_object", 1, 4, "int", &set_cam_lookat_object, 0, 0 );
    clientfield::register( "toplayer", "sndCameraScanner", 1, 3, "int", &sndCameraScanner, 0, 0 );
    clientfield::register( "world", "blend_in_cleanup", 1, 1, "int", &blend_in_cleanup, 0, 0 );
    clientfield::register( "world", "fuel_depot_truck_explosion", 1, 1, "int", &fuel_depot_truck_explosion, 0, 0 );
    clientfield::register( "toplayer", "turn_off_tacmode_vfx", 1, 1, "int", &function_7e8cf38d, 0, 0 );
    clientfield::register( "toplayer", "dropship_rumble_loop", 1, 1, "int", &function_d376a908, 0, 0 );
    clientfield::register( "toplayer", "apc_speed_blur", 1, 1, "int", &apc_speed_blur, 0, 0 );
    clientfield::register( "world", "diaz_break_1", 1, 2, "int", &function_35a91904, 0, 0 );
    clientfield::register( "world", "diaz_break_2", 1, 2, "int", &function_a7b0883f, 0, 0 );
    clientfield::register( "toplayer", "player_tunnel_dust_fx_on_off", 1, 1, "int", &cp_mi_eth_prologue_fx::player_tunnel_dust_fx_on_off, 0, 0 );
    clientfield::register( "toplayer", "player_tunnel_dust_fx", 1, 1, "int", &cp_mi_eth_prologue_fx::function_ba9197c, 0, 0 );
    clientfield::register( "toplayer", "player_blood_splatter", 1, 1, "int", &cp_mi_eth_prologue_fx::player_blood_splatter, 0, 0 );
    clientfield::register( "actor", "cyber_soldier_camo", 1, 2, "int", &ent_camo_material_callback, 0, 1 );
    duplicate_render::set_dr_filter_framebuffer( "active_camo", 90, "actor_camo_on", "", 0, "mc/hud_outline_predator_camo_active_inf", 0 );
    duplicate_render::set_dr_filter_framebuffer( "active_camo_flicker", 80, "actor_camo_flicker", "", 0, "mc/hud_outline_predator_camo_disruption_inf", 0 );
    clientfield::register( "world", "toggle_security_camera_pbg_bank", 1, 1, "int", &function_c9395227, 0, 0 );
}

// Namespace cp_mi_eth_prologue
// Params 1
// Checksum 0x37c8da34, Offset: 0x1268
// Size: 0x106
function force_streamer( n_index )
{
    switch ( n_index )
    {
        case 1:
            break;
        case 2:
            forcestreambundle( "cin_pro_05_01_securitycam_1st_stealth_kill_closedoor" );
            break;
        case 3:
            forcestreambundle( "cin_pro_06_03_hostage_vign_breach_playerbreach" );
            forcestreamxmodel( "p7_door_metal_security_02_rt_keypad" );
            break;
        case 4:
            forcestreambundle( "cin_pro_06_03_hostage_1st_khalil_intro_player_rescue" );
            break;
        case 5:
            forcestreambundle( "cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack" );
            break;
        case 6:
            forcestreambundle( "cin_pro_11_01_jeepalley_vign_engage_start" );
            break;
    }
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0xcc40aa1f, Offset: 0x1378
// Size: 0xa4
function ent_camo_material_callback( local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self duplicate_render::set_dr_flag( "actor_camo_flicker", newval == 2 );
    self duplicate_render::set_dr_flag( "actor_camo_on", newval != 0 );
    self duplicate_render::change_dr_flags( local_client_num );
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0x5c186a64, Offset: 0x1428
// Size: 0x94
function apc_speed_blur( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        enablespeedblur( localclientnum, 0.25, 0.9, 1, 0, 1, 1, 1 );
        return;
    }
    
    disablespeedblur( localclientnum );
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0x1abcc81d, Offset: 0x14c8
// Size: 0x94
function function_d376a908( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self playrumblelooponentity( localclientnum, "cp_prologue_rumble_dropship" );
        return;
    }
    
    self stoprumble( localclientnum, "cp_prologue_rumble_dropship" );
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0x2533a992, Offset: 0x1568
// Size: 0x64
function tunnel_wall_explode( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "p7_fxanim_cp_prologue_apc_rail_wall_explode_bundle" );
    }
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0xe1be65c9, Offset: 0x15d8
// Size: 0xbc
function function_9e6eac31( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        setdvar( "player_sprintUnlimited", 0 );
        setdvar( "slide_forceBaseSlide", 1 );
        return;
    }
    
    setdvar( "player_sprintUnlimited", 1 );
    setdvar( "slide_forceBaseSlide", 0 );
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0xd31a259b, Offset: 0x16a0
// Size: 0x154
function player_turn_on_extra_cam( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        setdvar( "r_extracam_custom_aspectratio", 2.85 );
        e_camera = getent( localclientnum, "s_security_cam_hallway", "targetname" );
        e_camera setextracam( 0 );
        e_camera setextracamfocallength( 0, e_camera.var_81a24d4e );
        level thread function_5f6dad34( localclientnum, 1 );
    }
    
    level thread function_5f6dad34( localclientnum, 0 );
    level.active_extra_cam = 0;
    
    if ( newval )
    {
        set_cam_lookat_object( localclientnum, oldval, 0, bnewent, binitialsnap, fieldname, bwastimejump );
    }
}

// Namespace cp_mi_eth_prologue
// Params 2
// Checksum 0x651506de, Offset: 0x1800
// Size: 0x254
function function_5f6dad34( localclientnum, b_on )
{
    if ( !isdefined( level.var_4073afd6 ) )
    {
        level.var_4073afd6 = getent( localclientnum, "security_pstfx_screen", "targetname" );
    }
    
    level.var_4073afd6 notify( #"hash_5f6dad34" );
    level.var_4073afd6 endon( #"hash_5f6dad34" );
    level.var_4073afd6 mapshaderconstant( localclientnum, 0, "ScriptVector0" );
    level.var_4073afd6 mapshaderconstant( localclientnum, 1, "ScriptVector1" );
    
    if ( b_on )
    {
        level.var_4073afd6 setshaderconstant( localclientnum, 0, 1, 0, 0, 0 );
        
        while ( true )
        {
            starttime = gettime();
            i = gettime() - starttime;
            
            while ( i < 2000 && isdefined( self ) )
            {
                st = i / 1000;
                
                if ( st <= 1 )
                {
                    level.var_4073afd6 setshaderconstant( localclientnum, 1, 0, 0, st, 0 );
                }
                else if ( st > 1 )
                {
                    level.var_4073afd6 setshaderconstant( localclientnum, 1, 0, 0, math::linear_map( 2 - st, 0, 1, 0, 1 ), 0 );
                }
                
                i = gettime() - starttime;
                wait 0.016;
            }
        }
        
        return;
    }
    
    level.var_4073afd6 setshaderconstant( localclientnum, 0, 0, 0, 0, 0 );
    level.var_4073afd6 setshaderconstant( localclientnum, 1, 0, 0, 0, 0 );
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0x125b6dd, Offset: 0x1a60
// Size: 0xd4
function function_9fd7493( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( level.a_cam_objects ) )
    {
        return;
    }
    
    n_index = newval;
    
    if ( n_index == 9 )
    {
        n_index = 0;
    }
    
    if ( isdefined( level.a_cam_objects[ localclientnum ][ n_index ] ) )
    {
        level.a_cam_objects[ localclientnum ][ n_index ].origin = self.origin;
        level.a_cam_objects[ localclientnum ][ n_index ].angles = self.angles;
    }
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0x5f0c3479, Offset: 0x1b40
// Size: 0x124
function set_cam_lookat_object( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( !isdefined( level.a_cam_objects ) || level.a_cam_objects.size == 0 )
    {
        return;
    }
    
    e_camera = level.a_cam_objects[ localclientnum ][ newval ];
    
    if ( isdefined( e_camera ) )
    {
        if ( !util::is_mature() && e_camera.var_6516b558 )
        {
            e_camera setextracam( level.active_extra_cam, 64, 36 );
        }
        else
        {
            e_camera setextracam( level.active_extra_cam, 1024, 768 );
        }
        
        e_camera setextracamfocallength( level.active_extra_cam, e_camera.var_81a24d4e );
    }
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0x465380df, Offset: 0x1c70
// Size: 0x19e
function sndCameraScanner( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    switch ( newval )
    {
        case 1:
            playsound( 0, "evt_camera_scan_start", ( 0, 0, 0 ) );
            self.loopid = self playloopsound( "evt_camera_scan_lp", 1 );
            break;
        case 2:
            playsound( 0, "evt_camera_scan_nomatch", ( 0, 0, 0 ) );
            
            if ( isdefined( self.loopid ) )
            {
                self stoploopsound( self.loopid, 0.5 );
            }
            
            break;
        case 3:
            playsound( 0, "evt_camera_scan_match", ( 0, 0, 0 ) );
            
            if ( isdefined( self.loopid ) )
            {
                self stoploopsound( self.loopid, 0.5 );
            }
            
            break;
        default:
            if ( isdefined( self.loopid ) )
            {
                self stoploopsound( self.loopid, 0.5 );
            }
            
            break;
    }
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0xb47fc66f, Offset: 0x1e18
// Size: 0x39c
function setup_security_cameras( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        if ( !isdefined( level.a_cam_objects ) )
        {
            level.a_cam_objects = [];
        }
        
        if ( !isdefined( level.a_cam_objects[ localclientnum ] ) )
        {
            level.a_cam_objects[ localclientnum ] = [];
            level.a_cam_objects[ localclientnum ][ level.a_cam_objects[ localclientnum ].size ] = function_b0867fa6( localclientnum, "s_security_cam_hallway", 28 );
            level.a_cam_objects[ localclientnum ][ level.a_cam_objects[ localclientnum ].size ] = function_b0867fa6( localclientnum, "s_security_interrogation", 45 );
            level.a_cam_objects[ localclientnum ][ level.a_cam_objects[ localclientnum ].size ] = function_b0867fa6( localclientnum, "s_security_cower_on_floor", 50 );
            level.a_cam_objects[ localclientnum ][ level.a_cam_objects[ localclientnum ].size ] = function_b0867fa6( localclientnum, "s_security_beating", 24, 1 );
            level.a_cam_objects[ localclientnum ][ level.a_cam_objects[ localclientnum ].size ] = function_b0867fa6( localclientnum, "s_security_bound_in_chair", 35, 1 );
            level.a_cam_objects[ localclientnum ][ level.a_cam_objects[ localclientnum ].size ] = function_b0867fa6( localclientnum, "s_security_torture", 35, 0 );
            level.a_cam_objects[ localclientnum ][ level.a_cam_objects[ localclientnum ].size ] = function_b0867fa6( localclientnum, "s_security_lying_on_bed", 30, 1 );
            level.a_cam_objects[ localclientnum ][ level.a_cam_objects[ localclientnum ].size ] = function_b0867fa6( localclientnum, "s_security_cam_minister_waterboard", 35, 1 );
            level.a_cam_objects[ localclientnum ][ level.a_cam_objects[ localclientnum ].size ] = function_b0867fa6( localclientnum, "s_security_standing_wall", 38, 1 );
        }
        
        return;
    }
    
    if ( isdefined( level.a_cam_objects[ localclientnum ] ) )
    {
        for ( i = 0; i < level.a_cam_objects[ localclientnum ].size ; i++ )
        {
            level.a_cam_objects[ localclientnum ][ i ] clearextracam();
            level.a_cam_objects[ localclientnum ][ i ] delete();
            level.a_cam_objects[ localclientnum ][ i ] = undefined;
        }
    }
    
    level.a_cam_objects[ localclientnum ] = undefined;
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0x25c245fc, Offset: 0x21c0
// Size: 0x7c
function function_c9395227( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        setpbgactivebank( localclientnum, 2 );
        return;
    }
    
    setpbgactivebank( localclientnum, 1 );
}

// Namespace cp_mi_eth_prologue
// Params 4
// Checksum 0xe7a57c7, Offset: 0x2248
// Size: 0xa4
function function_b0867fa6( localclientnum, str_camera, var_81a24d4e, var_6516b558 )
{
    if ( !isdefined( var_81a24d4e ) )
    {
        var_81a24d4e = 14.64;
    }
    
    if ( !isdefined( var_6516b558 ) )
    {
        var_6516b558 = 0;
    }
    
    e_camera = getent( localclientnum, str_camera, "targetname" );
    e_camera.var_81a24d4e = var_81a24d4e;
    e_camera.var_6516b558 = var_6516b558;
    return e_camera;
}

// Namespace cp_mi_eth_prologue
// Params 0
// Checksum 0x9f0a1c90, Offset: 0x22f8
// Size: 0x11e
function function_cd98eb8d()
{
    self endon( #"death" );
    level endon( #"blend_in_cleanup" );
    v_angles = ( 0, -20, 0 );
    n_move_time = 4;
    n_wait_time = 5;
    self rotateto( self.angles + v_angles, n_move_time / 2 );
    wait n_wait_time / 2;
    
    while ( true )
    {
        v_angles = ( 0, 40, 0 );
        self rotateto( self.angles + v_angles, n_move_time );
        wait n_wait_time;
        v_angles = ( 0, -40, 0 );
        self rotateto( self.angles + v_angles, n_move_time );
        wait n_wait_time;
    }
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0xbe19cf5e, Offset: 0x2420
// Size: 0x112
function function_a1ad4aa7( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    var_8b68ce61 = struct::get_array( "s_interrogation_physics", "targetname" );
    
    foreach ( struct in var_8b68ce61 )
    {
        physicsexplosionsphere( localclientnum, struct.origin, 100, 1, 10, 99, 100, 1, 1 );
    }
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0xc9a24a4e, Offset: 0x2540
// Size: 0x12c
function blend_in_cleanup( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level notify( #"blend_in_cleanup" );
    scene::stop( "tower_sparking_wire_01", "targetname" );
    scene::stop( "tower_sparking_wire_02", "targetname" );
    scene::stop( "tower_sparking_wire_03", "targetname" );
    scene::stop( "tower_sparking_wire_04", "targetname" );
    scene::stop( "tower_sparking_wire_05", "targetname" );
    scene::stop( "tower_sparking_wire_06", "targetname" );
    scene::stop( "tower_sparking_wire_07", "targetname" );
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0x37f7099e, Offset: 0x2678
// Size: 0x9c
function fuel_depot_truck_explosion( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    level thread scene::play( "p7_fxanim_gp_trash_newspaper_burst_out_01_bundle" );
    level thread scene::play( "p7_fxanim_gp_trash_newspaper_burst_up_01_bundle" );
    level thread scene::play( "p7_fxanim_gp_trash_paper_burst_up_01_bundle" );
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0x7569db4, Offset: 0x2720
// Size: 0x6c
function apc_rail_tower_collapse( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "rail_tower_collapse_start", "targetname" );
    }
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0x602fe7f3, Offset: 0x2798
// Size: 0x94
function vtol_missile_explode_trash_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level thread scene::play( "vtol_hangar_trash_01", "targetname" );
        level thread scene::play( "vtol_hangar_trash_02", "targetname" );
    }
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0x2f643157, Offset: 0x2838
// Size: 0x50
function function_7e8cf38d( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval )
    {
        level.var_e46224ba = 1;
    }
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0x640a373a, Offset: 0x2890
// Size: 0x84
function function_35a91904( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        scene::init( "p7_fxanim_cp_prologue_window_break_hangar_01_bundle" );
        return;
    }
    
    scene::play( "p7_fxanim_cp_prologue_window_break_hangar_01_bundle" );
}

// Namespace cp_mi_eth_prologue
// Params 7
// Checksum 0x4807b2aa, Offset: 0x2920
// Size: 0x84
function function_a7b0883f( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        scene::init( "p7_fxanim_cp_prologue_window_break_hangar_02_bundle" );
        return;
    }
    
    scene::play( "p7_fxanim_cp_prologue_window_break_hangar_02_bundle" );
}

