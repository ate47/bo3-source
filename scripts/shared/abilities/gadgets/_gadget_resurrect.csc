#using scripts/codescripts/struct;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_power;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/postfx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace _gadget_resurrect;

// Namespace _gadget_resurrect
// Params 0, eflags: 0x2
// Checksum 0xdff43c91, Offset: 0x2f0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_resurrect", &__init__, undefined, undefined );
}

// Namespace _gadget_resurrect
// Params 0
// Checksum 0x49398cdb, Offset: 0x330
// Size: 0x114
function __init__()
{
    clientfield::register( "allplayers", "resurrecting", 1, 1, "int", &player_resurrect_changed, 0, 1 );
    clientfield::register( "toplayer", "resurrect_state", 1, 2, "int", &player_resurrect_state_changed, 0, 1 );
    duplicate_render::set_dr_filter_offscreen( "resurrecting", 99, "resurrecting", undefined, 2, "mc/hud_keyline_resurrect", 0 );
    visionset_mgr::register_visionset_info( "resurrect", 1, 16, undefined, "mp_ability_resurrection" );
    visionset_mgr::register_visionset_info( "resurrect_up", 1, 16, undefined, "mp_ability_wakeup" );
}

// Namespace _gadget_resurrect
// Params 7
// Checksum 0x6589ad80, Offset: 0x450
// Size: 0x64
function player_resurrect_changed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    self duplicate_render::update_dr_flag( localclientnum, "resurrecting", newval );
}

// Namespace _gadget_resurrect
// Params 1
// Checksum 0x9c7b59f, Offset: 0x4c0
// Size: 0x64
function resurrect_down_fx( localclientnum )
{
    self endon( #"entityshutdown" );
    self endon( #"finish_rejack" );
    self thread postfx::playpostfxbundle( "pstfx_resurrection_close" );
    wait 0.5;
    self thread postfx::playpostfxbundle( "pstfx_resurrection_pus" );
}

// Namespace _gadget_resurrect
// Params 1
// Checksum 0xf86bbc03, Offset: 0x530
// Size: 0x3c
function resurrect_up_fx( localclientnum )
{
    self endon( #"entityshutdown" );
    self notify( #"finish_rejack" );
    self thread postfx::playpostfxbundle( "pstfx_resurrection_open" );
}

// Namespace _gadget_resurrect
// Params 7
// Checksum 0xd1e9cc35, Offset: 0x578
// Size: 0xa4
function player_resurrect_state_changed( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump )
{
    if ( newval == 1 )
    {
        self thread resurrect_down_fx( localclientnum );
        return;
    }
    
    if ( newval == 2 )
    {
        self thread resurrect_up_fx( localclientnum );
        return;
    }
    
    self thread postfx::stoppostfxbundle();
}

