#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace zm_genesis_teleporter;

// Namespace zm_genesis_teleporter
// Params 0, eflags: 0x2
// Checksum 0xe154829c, Offset: 0x2b8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_genesis_teleporter", &__init__, undefined, undefined );
}

// Namespace zm_genesis_teleporter
// Params 0
// Checksum 0x34fc89d8, Offset: 0x2f8
// Size: 0xe4
function __init__()
{
    visionset_mgr::register_overlay_info_style_transported( "zm_genesis", 15000, 15, 2 );
    visionset_mgr::register_overlay_info_style_postfx_bundle( "zm_factory_teleport", 15000, 1, "pstfx_zm_wormhole" );
    clientfield::register( "toplayer", "player_shadowman_teleport_hijack_fx", 15000, 1, "int", &player_shadowman_teleport_hijack_fx, 0, 0 );
    level thread setup_teleport_aftereffects();
    level thread wait_for_black_box();
    level thread wait_for_teleport_aftereffect();
}

// Namespace zm_genesis_teleporter
// Params 0
// Checksum 0x1fe45154, Offset: 0x3e8
// Size: 0x126
function setup_teleport_aftereffects()
{
    util::waitforclient( 0 );
    level.teleport_ae_funcs = [];
    
    if ( getlocalplayers().size == 1 )
    {
        level.teleport_ae_funcs[ level.teleport_ae_funcs.size ] = &teleport_aftereffect_fov;
    }
    
    level.teleport_ae_funcs[ level.teleport_ae_funcs.size ] = &teleport_aftereffect_shellshock;
    level.teleport_ae_funcs[ level.teleport_ae_funcs.size ] = &teleport_aftereffect_shellshock_electric;
    level.teleport_ae_funcs[ level.teleport_ae_funcs.size ] = &teleport_aftereffect_bw_vision;
    level.teleport_ae_funcs[ level.teleport_ae_funcs.size ] = &teleport_aftereffect_red_vision;
    level.teleport_ae_funcs[ level.teleport_ae_funcs.size ] = &teleport_aftereffect_flashy_vision;
    level.teleport_ae_funcs[ level.teleport_ae_funcs.size ] = &teleport_aftereffect_flare_vision;
}

// Namespace zm_genesis_teleporter
// Params 0
// Checksum 0x912d161a, Offset: 0x518
// Size: 0x100
function wait_for_black_box()
{
    secondclientnum = -1;
    
    while ( true )
    {
        level waittill( #"black_box_start", localclientnum );
        assert( isdefined( localclientnum ) );
        savedvis = getvisionsetnaked( localclientnum );
        playsound( 0, "evt_teleport_2d_fnt", ( 0, 0, 0 ) );
        visionsetnaked( localclientnum, "default", 0 );
        
        while ( secondclientnum != localclientnum )
        {
            level waittill( #"black_box_end", secondclientnum );
        }
        
        visionsetnaked( localclientnum, savedvis, 0 );
    }
}

// Namespace zm_genesis_teleporter
// Params 0
// Checksum 0xc454fcd8, Offset: 0x620
// Size: 0xc6
function wait_for_teleport_aftereffect()
{
    while ( true )
    {
        level waittill( #"tae", localclientnum );
        
        if ( getdvarstring( "genesisAftereffectOverride" ) == "-1" )
        {
            self thread [[ level.teleport_ae_funcs[ randomint( level.teleport_ae_funcs.size ) ] ]]( localclientnum );
            continue;
        }
        
        self thread [[ level.teleport_ae_funcs[ int( getdvarstring( "genesisAftereffectOverride" ) ) ] ]]( localclientnum );
    }
}

// Namespace zm_genesis_teleporter
// Params 1
// Checksum 0xa60904fe, Offset: 0x6f0
// Size: 0x14
function teleport_aftereffect_shellshock( localclientnum )
{
    wait 0.05;
}

// Namespace zm_genesis_teleporter
// Params 1
// Checksum 0x2ea1af97, Offset: 0x710
// Size: 0x14
function teleport_aftereffect_shellshock_electric( localclientnum )
{
    wait 0.05;
}

// Namespace zm_genesis_teleporter
// Params 1
// Checksum 0x86c61373, Offset: 0x730
// Size: 0xda
function teleport_aftereffect_fov( localclientnum )
{
    println( "<dev string:x28>" );
    var_bd22d384 = 30;
    var_b27ddf7 = getdvarfloat( "cg_fov_default" );
    n_duration = 0.5;
    i = 0;
    
    while ( i < n_duration )
    {
        n_fov = var_bd22d384 + ( var_b27ddf7 - var_bd22d384 ) * i / n_duration;
        wait 0.017;
        i += 0.017;
    }
}

// Namespace zm_genesis_teleporter
// Params 1
// Checksum 0x41a1454, Offset: 0x818
// Size: 0x9c
function teleport_aftereffect_bw_vision( localclientnum )
{
    println( "<dev string:x3f>" );
    savedvis = getvisionsetnaked( localclientnum );
    visionsetnaked( localclientnum, "cheat_bw_invert_contrast", 0.4 );
    wait 1.25;
    visionsetnaked( localclientnum, savedvis, 1 );
}

// Namespace zm_genesis_teleporter
// Params 1
// Checksum 0x16e56de9, Offset: 0x8c0
// Size: 0x9c
function teleport_aftereffect_red_vision( localclientnum )
{
    println( "<dev string:x56>" );
    savedvis = getvisionsetnaked( localclientnum );
    visionsetnaked( localclientnum, "zombie_turned", 0.4 );
    wait 1.25;
    visionsetnaked( localclientnum, savedvis, 1 );
}

// Namespace zm_genesis_teleporter
// Params 1
// Checksum 0xd7c7fc32, Offset: 0x968
// Size: 0xdc
function teleport_aftereffect_flashy_vision( localclientnum )
{
    println( "<dev string:x6d>" );
    savedvis = getvisionsetnaked( localclientnum );
    visionsetnaked( localclientnum, "cheat_bw_invert_contrast", 0.1 );
    wait 0.4;
    visionsetnaked( localclientnum, "cheat_bw_contrast", 0.1 );
    wait 0.4;
    wait 0.4;
    wait 0.4;
    visionsetnaked( localclientnum, savedvis, 5 );
}

// Namespace zm_genesis_teleporter
// Params 1
// Checksum 0x97ae5704, Offset: 0xa50
// Size: 0x9c
function teleport_aftereffect_flare_vision( localclientnum )
{
    println( "<dev string:x87>" );
    savedvis = getvisionsetnaked( localclientnum );
    visionsetnaked( localclientnum, "flare", 0.4 );
    wait 1.25;
    visionsetnaked( localclientnum, savedvis, 1 );
}

// Namespace zm_genesis_teleporter
// Params 7
// Checksum 0xfa4265bd, Offset: 0xaf8
// Size: 0xde
function player_shadowman_teleport_hijack_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self notify( #"player_shadowman_teleport_hijack_fx" );
    self endon( #"player_shadowman_teleport_hijack_fx" );
    
    if ( newval )
    {
        if ( isdemoplaying() && demoisanyfreemovecamera() )
        {
            return;
        }
        
        self thread function_bad0a94c( localclientnum );
        self thread postfx::playpostfxbundle( "pstfx_zm_wormhole" );
        return;
    }
    
    self notify( #"player_shadowman_teleport_hijack_fx_done" );
}

// Namespace zm_genesis_teleporter
// Params 1
// Checksum 0xb1c6acf3, Offset: 0xbe0
// Size: 0x4c
function function_bad0a94c( localclientnum )
{
    self util::waittill_any( "player_shadowman_teleport_hijack_fx", "player_shadowman_teleport_hijack_fx_done" );
    self postfx::exitpostfxbundle();
}

