#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace zm_factory_teleporter;

// Namespace zm_factory_teleporter
// Params 0, eflags: 0x2
// Checksum 0x2c0dc174, Offset: 0x1b0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_factory_teleporter", &__init__, undefined, undefined );
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x3dfbb13e, Offset: 0x1f0
// Size: 0x74
function __init__()
{
    visionset_mgr::register_overlay_info_style_postfx_bundle( "zm_factory_teleport", 1, 1, "pstfx_zm_der_teleport" );
    level thread setup_teleport_aftereffects();
    level thread wait_for_black_box();
    level thread wait_for_teleport_aftereffect();
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0x85db533d, Offset: 0x270
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

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0xbb9a0535, Offset: 0x3a0
// Size: 0xd8
function wait_for_black_box()
{
    secondclientnum = -1;
    
    while ( true )
    {
        level waittill( #"black_box_start", localclientnum );
        assert( isdefined( localclientnum ) );
        savedvis = getvisionsetnaked( localclientnum );
        visionsetnaked( localclientnum, "default", 0 );
        
        while ( secondclientnum != localclientnum )
        {
            level waittill( #"black_box_end", secondclientnum );
        }
        
        visionsetnaked( localclientnum, savedvis, 0 );
    }
}

// Namespace zm_factory_teleporter
// Params 0
// Checksum 0xd5c5543f, Offset: 0x480
// Size: 0xc6
function wait_for_teleport_aftereffect()
{
    while ( true )
    {
        level waittill( #"tae", localclientnum );
        
        if ( getdvarstring( "factoryAftereffectOverride" ) == "-1" )
        {
            self thread [[ level.teleport_ae_funcs[ randomint( level.teleport_ae_funcs.size ) ] ]]( localclientnum );
            continue;
        }
        
        self thread [[ level.teleport_ae_funcs[ int( getdvarstring( "factoryAftereffectOverride" ) ) ] ]]( localclientnum );
    }
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0xe2575983, Offset: 0x550
// Size: 0x14
function teleport_aftereffect_shellshock( localclientnum )
{
    wait 0.05;
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0xcac0e792, Offset: 0x570
// Size: 0x14
function teleport_aftereffect_shellshock_electric( localclientnum )
{
    wait 0.05;
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0x16725859, Offset: 0x590
// Size: 0xda
function teleport_aftereffect_fov( localclientnum )
{
    println( "<dev string:x28>" );
    start_fov = 30;
    end_fov = getdvarfloat( "cg_fov_default" );
    duration = 0.5;
    i = 0;
    
    while ( i < duration )
    {
        fov = start_fov + ( end_fov - start_fov ) * i / duration;
        wait 0.017;
        i += 0.017;
    }
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0xad5d515, Offset: 0x678
// Size: 0x9c
function teleport_aftereffect_bw_vision( localclientnum )
{
    println( "<dev string:x3f>" );
    savedvis = getvisionsetnaked( localclientnum );
    visionsetnaked( localclientnum, "cheat_bw_invert_contrast", 0.4 );
    wait 1.25;
    visionsetnaked( localclientnum, savedvis, 1 );
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0x1a38c860, Offset: 0x720
// Size: 0x9c
function teleport_aftereffect_red_vision( localclientnum )
{
    println( "<dev string:x56>" );
    savedvis = getvisionsetnaked( localclientnum );
    visionsetnaked( localclientnum, "zombie_turned", 0.4 );
    wait 1.25;
    visionsetnaked( localclientnum, savedvis, 1 );
}

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0x840a0575, Offset: 0x7c8
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

// Namespace zm_factory_teleporter
// Params 1
// Checksum 0xc483d9cf, Offset: 0x8b0
// Size: 0x9c
function teleport_aftereffect_flare_vision( localclientnum )
{
    println( "<dev string:x87>" );
    savedvis = getvisionsetnaked( localclientnum );
    visionsetnaked( localclientnum, "flare", 0.4 );
    wait 1.25;
    visionsetnaked( localclientnum, savedvis, 1 );
}

