#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_utility;

#namespace zm_ai_wasp;

// Namespace zm_ai_wasp
// Params 0, eflags: 0x2
// Checksum 0x6049cfe1, Offset: 0x2d8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_ai_wasp", &__init__, undefined, undefined );
}

// Namespace zm_ai_wasp
// Params 0
// Checksum 0xe2313690, Offset: 0x318
// Size: 0x166
function __init__()
{
    clientfield::register( "toplayer", "parasite_round_fx", 15000, 1, "counter", &parasite_round_fx, 0, 0 );
    clientfield::register( "world", "toggle_on_parasite_fog", 15000, 2, "int", &parasite_fog_on, 0, 0 );
    clientfield::register( "toplayer", "parasite_round_ring_fx", 15000, 1, "counter", &parasite_round_ring_fx, 0, 0 );
    clientfield::register( "toplayer", "genesis_parasite_damage", 15000, 1, "counter", &genesis_parasite_damage, 0, 0 );
    visionset_mgr::register_visionset_info( "zm_wasp_round_visionset", 15000, 31, undefined, "zm_wasp_round_visionset" );
    level._effect[ "parasite_round" ] = "zombie/fx_parasite_round_tell_zod_zmb";
}

// Namespace zm_ai_wasp
// Params 7
// Checksum 0xb8717701, Offset: 0x488
// Size: 0x116
function parasite_fog_on( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        for ( localclientnum = 0; localclientnum < level.localplayers.size ; localclientnum++ )
        {
            setlitfogbank( localclientnum, -1, 1, -1 );
            setworldfogactivebank( localclientnum, 2 );
        }
    }
    
    if ( newval == 2 )
    {
        for ( localclientnum = 0; localclientnum < level.localplayers.size ; localclientnum++ )
        {
            setlitfogbank( localclientnum, -1, 0, -1 );
            setworldfogactivebank( localclientnum, 1 );
        }
    }
}

// Namespace zm_ai_wasp
// Params 7
// Checksum 0x601b8a80, Offset: 0x5a8
// Size: 0xcc
function parasite_round_fx( n_local_client, n_val_old, n_val_new, b_ent_new, b_initial_snap, str_field, b_demo_jump )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    if ( isspectating( n_local_client ) )
    {
        return;
    }
    
    self.n_parasite_round_fx_id = playfxoncamera( n_local_client, level._effect[ "parasite_round" ] );
    wait 3.5;
    deletefx( n_local_client, self.n_parasite_round_fx_id );
}

// Namespace zm_ai_wasp
// Params 7
// Checksum 0x34f33b9c, Offset: 0x680
// Size: 0x9c
function parasite_round_ring_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self endon( #"disconnect" );
    
    if ( isspectating( localclientnum ) )
    {
        return;
    }
    
    self thread postfx::playpostfxbundle( "pstfx_ring_loop" );
    wait 1.5;
    self postfx::exitpostfxbundle();
}

// Namespace zm_ai_wasp
// Params 7, eflags: 0x4
// Checksum 0x3daf2eed, Offset: 0x728
// Size: 0x64
function private genesis_parasite_damage( localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump )
{
    if ( newvalue )
    {
        self postfx::playpostfxbundle( "pstfx_parasite_chaos" );
    }
}

