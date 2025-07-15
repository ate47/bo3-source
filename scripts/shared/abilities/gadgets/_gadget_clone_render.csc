#using scripts/codescripts/struct;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/system_shared;

#namespace _gadget_clone_render;

// Namespace _gadget_clone_render
// Params 0, eflags: 0x2
// Checksum 0x59a3dd01, Offset: 0x218
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "gadget_clone_render", &__init__, undefined, undefined );
}

// Namespace _gadget_clone_render
// Params 0
// Checksum 0x71194902, Offset: 0x258
// Size: 0xd4
function __init__()
{
    duplicate_render::set_dr_filter_framebuffer( "clone_ally", 90, "clone_ally_on", "clone_damage", 0, "mc/ability_clone_ally", 0 );
    duplicate_render::set_dr_filter_framebuffer( "clone_enemy", 90, "clone_enemy_on", "clone_damage", 0, "mc/ability_clone_enemy", 0 );
    duplicate_render::set_dr_filter_framebuffer( "clone_damage_ally", 90, "clone_ally_on,clone_damage", undefined, 0, "mc/ability_clone_ally_damage", 0 );
    duplicate_render::set_dr_filter_framebuffer( "clone_damage_enemy", 90, "clone_enemy_on,clone_damage", undefined, 0, "mc/ability_clone_enemy_damage", 0 );
}

#namespace gadget_clone_render;

// Namespace gadget_clone_render
// Params 1
// Checksum 0x4609929, Offset: 0x338
// Size: 0xa4
function transition_shader( localclientnum )
{
    self endon( #"entityshutdown" );
    self endon( #"clone_shader_off" );
    rampinshader = 0;
    
    while ( rampinshader < 1 )
    {
        if ( isdefined( self ) )
        {
            self mapshaderconstant( localclientnum, 0, "scriptVector3", 1, rampinshader, 0, 0.04 );
        }
        
        rampinshader += 0.04;
        wait 0.016;
    }
}

