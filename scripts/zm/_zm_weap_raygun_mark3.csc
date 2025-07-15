#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/fx_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace _zm_weap_raygun_mark3;

// Namespace _zm_weap_raygun_mark3
// Params 0, eflags: 0x2
// Checksum 0x304a131a, Offset: 0x468
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_weap_raygun_mark3", &__init__, undefined, undefined );
}

// Namespace _zm_weap_raygun_mark3
// Params 0
// Checksum 0xeaa6cf0, Offset: 0x4a8
// Size: 0x2c4
function __init__()
{
    level.w_raygun_mark3 = getweapon( "raygun_mark3" );
    level.w_raygun_mark3_upgraded = getweapon( "raygun_mark3_upgraded" );
    level._effect[ "raygun_ai_slow_vortex_small" ] = "dlc3/stalingrad/fx_raygun_l_projectile_blackhole_sm_hit";
    level._effect[ "raygun_ai_slow_vortex_large" ] = "dlc3/stalingrad/fx_raygun_l_projectile_blackhole_lg_hit";
    level._effect[ "raygun_slow_vortex_small" ] = "dlc3/stalingrad/fx_raygun_l_projectile_blackhole_sm";
    level._effect[ "raygun_slow_vortex_large" ] = "dlc3/stalingrad/fx_raygun_l_projectile_blackhole_lg";
    clientfield::register( "scriptmover", "slow_vortex_fx", 12000, 2, "int", &slow_vortex_fx, 0, 0 );
    clientfield::register( "actor", "ai_disintegrate", 12000, 1, "int", &ai_disintegrate, 0, 0 );
    clientfield::register( "vehicle", "ai_disintegrate", 12000, 1, "int", &ai_disintegrate, 0, 0 );
    clientfield::register( "actor", "ai_slow_vortex_fx", 12000, 2, "int", &ai_slow_vortex_fx, 0, 0 );
    clientfield::register( "vehicle", "ai_slow_vortex_fx", 12000, 2, "int", &ai_slow_vortex_fx, 0, 0 );
    visionset_mgr::register_visionset_info( "raygun_mark3_vortex_visionset", 1, 30, undefined, "zm_idgun_vortex" );
    visionset_mgr::register_overlay_info_style_speed_blur( "raygun_mark3_vortex_blur", 1, 30, 0.08, 0.75, 0.9 );
    duplicate_render::set_dr_filter_framebuffer( "dissolve", 10, "dissolve_on", undefined, 0, "mc/mtl_c_zom_dlc3_zombie_dissolve_base", 0 );
    callback::on_localclient_connect( &monitor_raygun_mark3 );
}

// Namespace _zm_weap_raygun_mark3
// Params 1
// Checksum 0x8322bb81, Offset: 0x778
// Size: 0x34, Type: bool
function is_beam_raygun( weapon )
{
    if ( weapon === level.w_raygun_mark3 || weapon === level.w_raygun_mark3_upgraded )
    {
        return true;
    }
    
    return false;
}

// Namespace _zm_weap_raygun_mark3
// Params 1
// Checksum 0xe800478a, Offset: 0x7b8
// Size: 0x100
function monitor_raygun_mark3( n_local_client )
{
    player = getlocalplayer( n_local_client );
    player endon( #"death" );
    
    while ( true )
    {
        player waittill( #"weapon_change", weapon );
        
        if ( is_beam_raygun( weapon ) )
        {
            player mapshaderconstant( n_local_client, 0, "scriptVector2", 0, 1, 0, 0 );
            player thread glow_monitor( n_local_client );
            continue;
        }
        
        player notify( #"glow_monitor" );
        player mapshaderconstant( n_local_client, 0, "scriptVector2", 0, 0, 0, 0 );
    }
}

// Namespace _zm_weap_raygun_mark3
// Params 1
// Checksum 0xb9a9b102, Offset: 0x8c0
// Size: 0xc8
function glow_monitor( n_local_client )
{
    self notify( #"glow_monitor" );
    self endon( #"glow_monitor" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill_notetrack( "clamps_open" );
        self mapshaderconstant( n_local_client, 0, "scriptVector2", 0, 0, 0, 0 );
        self waittill_notetrack( "clamps_close" );
        self mapshaderconstant( n_local_client, 0, "scriptVector2", 0, 1, 0, 0 );
    }
}

// Namespace _zm_weap_raygun_mark3
// Params 1
// Checksum 0x6f4bed28, Offset: 0x990
// Size: 0x58
function waittill_notetrack( str_notetrack )
{
    self endon( #"glow_monitor" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"notetrack", str_note );
        
        if ( str_note == str_notetrack )
        {
            return;
        }
    }
}

// Namespace _zm_weap_raygun_mark3
// Params 7
// Checksum 0x6714f73, Offset: 0x9f0
// Size: 0x134
function slow_vortex_fx( n_local_client, n_old, n_new, b_new_ent, b_initial_snap, str_field, b_was_time_jump )
{
    if ( isdefined( self.fx_slow_vortex ) )
    {
        killfx( n_local_client, self.fx_slow_vortex );
    }
    
    if ( n_new )
    {
        if ( n_new == 1 )
        {
            self.fx_slow_vortex = playfxontag( n_local_client, level._effect[ "raygun_slow_vortex_small" ], self, "tag_origin" );
        }
        else
        {
            self.fx_slow_vortex = playfxontag( n_local_client, level._effect[ "raygun_slow_vortex_large" ], self, "tag_origin" );
            self playrumbleonentity( n_local_client, "artillery_rumble" );
        }
        
        self thread vortex_shake_and_rumble( n_local_client, n_new );
    }
}

// Namespace _zm_weap_raygun_mark3
// Params 7
// Checksum 0x71253cc3, Offset: 0xb30
// Size: 0x154
function ai_slow_vortex_fx( n_local_client, n_old, n_new, b_new_ent, b_initial_snap, str_field, b_was_time_jump )
{
    if ( n_new )
    {
        if ( n_new == 1 )
        {
            self.fx_ai_slow_vortex = playfxontag( n_local_client, level._effect[ "raygun_ai_slow_vortex_small" ], self, "J_SpineUpper" );
            self thread zombie_blacken( n_local_client, 1 );
        }
        else
        {
            self.fx_ai_slow_vortex = playfxontag( n_local_client, level._effect[ "raygun_ai_slow_vortex_large" ], self, "J_SpineUpper" );
            self thread zombie_blacken( n_local_client, 1 );
        }
        
        return;
    }
    
    if ( isdefined( self.fx_ai_slow_vortex ) )
    {
        killfx( n_local_client, self.fx_ai_slow_vortex );
        self thread zombie_blacken( n_local_client, 0 );
    }
}

// Namespace _zm_weap_raygun_mark3
// Params 2
// Checksum 0xe0070e9f, Offset: 0xc90
// Size: 0xa0
function vortex_shake_and_rumble( n_local_client, n_damage_level )
{
    self notify( #"vortex_shake_and_rumble" );
    self endon( #"vortex_shake_and_rumble" );
    self endon( #"entity_shutdown" );
    
    if ( n_damage_level == 1 )
    {
        str_rumble = "raygun_mark3_vortex_sm";
    }
    else
    {
        str_rumble = "raygun_mark3_vortex_lg";
    }
    
    while ( isdefined( self ) )
    {
        self playrumbleonentity( n_local_client, str_rumble );
        wait 0.083;
    }
}

// Namespace _zm_weap_raygun_mark3
// Params 2
// Checksum 0x921731ec, Offset: 0xd38
// Size: 0x120
function zombie_blacken( n_local_client, b_blacken )
{
    self endon( #"entity_shutdown" );
    
    if ( !isdefined( self.n_blacken ) )
    {
        self.n_blacken = 0;
    }
    
    if ( b_blacken )
    {
        while ( isdefined( self ) && self.n_blacken < 1 )
        {
            self.n_blacken += 0.2;
            self mapshaderconstant( n_local_client, 0, "scriptVector0", self.n_blacken );
            wait 0.05;
        }
        
        return;
    }
    
    while ( isdefined( self ) && self.n_blacken > 0 )
    {
        self.n_blacken -= 0.2;
        self mapshaderconstant( n_local_client, 0, "scriptVector0", self.n_blacken );
        wait 0.05;
    }
}

// Namespace _zm_weap_raygun_mark3
// Params 7
// Checksum 0xfc9f7296, Offset: 0xe60
// Size: 0x124
function ai_disintegrate( n_local_client, n_old, n_new, b_new_ent, b_initial_snap, str_field, b_was_time_jump )
{
    self endon( #"entity_shutdown" );
    self duplicate_render::set_dr_flag( "dissolve_on", n_new );
    self duplicate_render::update_dr_filters( n_local_client );
    self.n_dissolve = 1;
    
    while ( isdefined( self ) && self.n_dissolve > 0 )
    {
        self mapshaderconstant( n_local_client, 0, "scriptVector0", self.n_dissolve );
        self.n_dissolve -= 0.0166;
        wait 0.0166;
    }
    
    if ( isdefined( self ) )
    {
        self mapshaderconstant( n_local_client, 0, "scriptVector0", 0 );
    }
}

