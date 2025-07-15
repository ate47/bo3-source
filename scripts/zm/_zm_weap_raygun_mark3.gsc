#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;

#namespace _zm_weap_raygun_mark3;

// Namespace _zm_weap_raygun_mark3
// Params 0, eflags: 0x2
// Checksum 0x83ccf4e0, Offset: 0x3e0
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_weap_raygun_mark3", &__init__, &__main__, undefined );
}

// Namespace _zm_weap_raygun_mark3
// Params 0
// Checksum 0xe6cd86ae, Offset: 0x428
// Size: 0x294
function __init__()
{
    level.w_raygun_mark3 = getweapon( "raygun_mark3" );
    level.w_raygun_mark3lh = getweapon( "raygun_mark3lh" );
    level.w_raygun_mark3_upgraded = getweapon( "raygun_mark3_upgraded" );
    level.w_raygun_mark3lh_upgraded = getweapon( "raygun_mark3lh_upgraded" );
    zm_utility::register_slowdown( "raygun_mark3lh", 0.7, 2 );
    zm_utility::register_slowdown( "raygun_mark3lh_upgraded", 0.5, 3 );
    zm_spawner::register_zombie_damage_callback( &raygun_mark3_damage_response );
    clientfield::register( "scriptmover", "slow_vortex_fx", 12000, 2, "int" );
    clientfield::register( "actor", "ai_disintegrate", 12000, 1, "int" );
    clientfield::register( "vehicle", "ai_disintegrate", 12000, 1, "int" );
    clientfield::register( "actor", "ai_slow_vortex_fx", 12000, 2, "int" );
    clientfield::register( "vehicle", "ai_slow_vortex_fx", 12000, 2, "int" );
    visionset_mgr::register_info( "visionset", "raygun_mark3_vortex_visionset", 12000, 24, 30, 1, &visionset_mgr::ramp_in_out_thread_per_player, 1 );
    visionset_mgr::register_info( "overlay", "raygun_mark3_vortex_blur", 12000, 24, 30, 1, &visionset_mgr::ramp_in_out_thread_per_player, 1 );
    callback::on_connect( &watch_raygun_impact );
}

// Namespace _zm_weap_raygun_mark3
// Params 0
// Checksum 0x99ec1590, Offset: 0x6c8
// Size: 0x4
function __main__()
{
    
}

// Namespace _zm_weap_raygun_mark3
// Params 1
// Checksum 0x5a416114, Offset: 0x6d8
// Size: 0x34, Type: bool
function is_slow_raygun( weapon )
{
    if ( weapon === level.w_raygun_mark3lh || weapon === level.w_raygun_mark3lh_upgraded )
    {
        return true;
    }
    
    return false;
}

// Namespace _zm_weap_raygun_mark3
// Params 1
// Checksum 0xdea183e6, Offset: 0x718
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
// Checksum 0x53f7ac4f, Offset: 0x758
// Size: 0x76
function raygun_vortex_reposition( v_impact_origin )
{
    v_nearest_navmesh_point = getclosestpointonnavmesh( v_impact_origin, 50, 32 );
    
    if ( isdefined( v_nearest_navmesh_point ) )
    {
        v_vortex_origin = v_nearest_navmesh_point + ( 0, 0, 32 );
    }
    else
    {
        v_vortex_origin = v_impact_origin;
    }
    
    return v_vortex_origin;
}

// Namespace _zm_weap_raygun_mark3
// Params 0
// Checksum 0xf442aeec, Offset: 0x7d8
// Size: 0xd8
function watch_raygun_impact()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"projectile_impact", w_weapon, v_pos, n_radius, e_projectile, v_normal );
        v_pos_final = raygun_vortex_reposition( v_pos + v_normal * 32 );
        
        if ( is_slow_raygun( w_weapon ) )
        {
            self thread start_slow_vortex( w_weapon, v_pos, v_pos_final, n_radius, e_projectile, v_normal );
        }
    }
}

// Namespace _zm_weap_raygun_mark3
// Params 6
// Checksum 0x49eb2492, Offset: 0x8b8
// Size: 0x18c
function start_slow_vortex( w_weapon, v_pos, v_pos_final, n_radius, e_attacker, v_normal )
{
    self endon( #"disconnect" );
    mdl_vortex = spawn( "script_model", v_pos );
    mdl_vortex setmodel( "p7_fxanim_zm_stal_ray_gun_ball_mod" );
    playsoundatposition( "wpn_mk3_orb_created", mdl_vortex.origin );
    mdl_vortex.angles = ( 270, 0, 0 );
    mdl_vortex clientfield::set( "slow_vortex_fx", 1 );
    util::wait_network_frame();
    mdl_vortex moveto( v_pos_final, 0.1 );
    util::wait_network_frame();
    mdl_vortex.health = 100000;
    mdl_vortex.takedamage = 1;
    mdl_vortex thread pulse_damage( self, w_weapon );
    mdl_vortex thread wait_for_beam_damage();
}

// Namespace _zm_weap_raygun_mark3
// Params 2
// Checksum 0xea3fdb37, Offset: 0xa50
// Size: 0x444
function pulse_damage( e_owner, w_weapon )
{
    self endon( #"death" );
    self.n_damage_type = 1;
    self.n_end_time = gettime() + 3000;
    self.e_owner = e_owner;
    
    if ( w_weapon == level.w_raygun_mark3lh )
    {
    }
    else
    {
        playsoundatposition( "wpn_mk3_orb_zark_far", self.origin );
    }
    
    while ( gettime() <= self.n_end_time )
    {
        if ( self.n_damage_type == 1 )
        {
            n_radius = 128;
            
            if ( w_weapon == level.w_raygun_mark3lh )
            {
                n_pulse_damage = 50;
            }
            else
            {
                n_pulse_damage = 100;
            }
        }
        else
        {
            n_radius = 128;
            playsoundatposition( "wpn_mk3_orb_zark_far", self.origin );
            
            if ( w_weapon == level.w_raygun_mark3lh )
            {
                n_pulse_damage = 1000;
            }
            else
            {
                n_pulse_damage = 5000;
            }
        }
        
        n_radius_squared = n_radius * n_radius;
        a_ai = getaiteamarray( "axis" );
        
        foreach ( ai in a_ai )
        {
            if ( isdefined( ai.b_ignore_mark3_pulse_damage ) && ai.b_ignore_mark3_pulse_damage )
            {
                continue;
            }
            
            if ( distancesquared( self.origin, ai.origin ) <= n_radius_squared )
            {
                ai thread apply_vortex_fx( self.n_damage_type, 2 );
                
                if ( ai.health > n_pulse_damage )
                {
                    ai dodamage( n_pulse_damage, self.origin, e_owner, self, undefined, "MOD_UNKNOWN", 0, w_weapon );
                    continue;
                }
                
                if ( self.n_damage_type == 2 )
                {
                    ai thread disintegrate_zombie( self, e_owner, w_weapon );
                }
            }
        }
        
        foreach ( e_player in level.activeplayers )
        {
            if ( isdefined( e_player ) && !( isdefined( e_player.raygun_mark3_vision_on ) && e_player.raygun_mark3_vision_on ) )
            {
                if ( distance( e_player.origin, self.origin ) < float( n_radius / 2 ) )
                {
                    e_player thread player_vortex_visionset();
                }
            }
        }
        
        wait 0.5;
    }
    
    self clientfield::set( "slow_vortex_fx", 0 );
    playsoundatposition( "wpn_mk3_orb_disappear", self.origin );
    self delete();
}

// Namespace _zm_weap_raygun_mark3
// Params 0
// Checksum 0xae61586b, Offset: 0xea0
// Size: 0xbc
function player_vortex_visionset()
{
    self notify( #"player_vortex_visionset" );
    self endon( #"player_vortex_visionset" );
    self endon( #"death" );
    thread visionset_mgr::activate( "visionset", "raygun_mark3_vortex_visionset", self, 0.25, 2, 0.25 );
    thread visionset_mgr::activate( "overlay", "raygun_mark3_vortex_blur", self, 0.25, 2, 0.25 );
    self.raygun_mark3_vision_on = 1;
    wait 2.5;
    self.raygun_mark3_vision_on = 0;
}

// Namespace _zm_weap_raygun_mark3
// Params 0
// Checksum 0x5a0afb37, Offset: 0xf68
// Size: 0x1c8
function wait_for_beam_damage()
{
    self endon( #"death" );
    self playloopsound( "wpn_mk3_orb_loop" );
    
    while ( true )
    {
        self waittill( #"damage", n_damage, e_attacker, v_direction, v_point, str_means_of_death, str_tag_name, str_model_name, str_part_name, w_weapon );
        
        if ( is_beam_raygun( w_weapon ) )
        {
            self stoploopsound();
            self setmodel( "tag_origin" );
            self playloopsound( "wpn_mk3_orb_loop_activated" );
            self.takedamage = 0;
            self.n_damage_type = 2;
            self clientfield::set( "slow_vortex_fx", self.n_damage_type );
            self.n_end_time = gettime() + 3000;
            wait 3;
            playsoundatposition( "wpn_mk3_orb_disappear", self.origin );
            self delete();
            return;
        }
        
        self.health = 100000;
    }
}

// Namespace _zm_weap_raygun_mark3
// Params 13
// Checksum 0xb6669e31, Offset: 0x1138
// Size: 0x154
function raygun_mark3_damage_response( str_mod, str_hit_location, v_hit_origin, e_player, n_amount, w_weapon, v_direction, str_tag, str_model, str_part, n_flags, e_inflictor, n_chargelevel )
{
    if ( isdefined( w_weapon ) )
    {
        if ( w_weapon == level.w_raygun_mark3lh || w_weapon == level.w_raygun_mark3lh_upgraded )
        {
            if ( isdefined( self.func_raygun_mark3_damage_response ) )
            {
                return [[ self.func_raygun_mark3_damage_response ]]( str_mod, str_hit_location, v_hit_origin, e_player, n_amount, w_weapon, v_direction, str_tag, str_model, str_part, n_flags, e_inflictor, n_chargelevel );
            }
            
            if ( w_weapon == level.w_raygun_mark3lh )
            {
                self thread zm_utility::slowdown_ai( "raygun_mark3lh" );
                return 1;
            }
            else if ( w_weapon == level.w_raygun_mark3lh_upgraded )
            {
                self thread zm_utility::slowdown_ai( "raygun_mark3lh_upgraded" );
                return 1;
            }
        }
    }
    
    return 0;
}

// Namespace _zm_weap_raygun_mark3
// Params 2
// Checksum 0xa395dba5, Offset: 0x1298
// Size: 0x164
function apply_vortex_fx( n_damage_type, n_time )
{
    self notify( #"apply_vortex_fx" );
    self endon( #"apply_vortex_fx" );
    self endon( #"death" );
    
    if ( !( isdefined( self.b_vortex_fx_applied ) && self.b_vortex_fx_applied ) )
    {
        self.b_vortex_fx_applied = 1;
        
        if ( isdefined( self.allowpain ) && self.allowpain )
        {
            self.b_old_allow_pain = 1;
            self ai::disable_pain();
        }
        
        if ( n_damage_type == 1 )
        {
            self clientfield::set( "ai_slow_vortex_fx", 1 );
        }
        else
        {
            self clientfield::set( "ai_slow_vortex_fx", 2 );
        }
    }
    
    util::waittill_any_timeout( n_time, "death", "apply_vortex_fx" );
    
    if ( isdefined( self.b_old_allow_pain ) && self.b_old_allow_pain )
    {
        self ai::enable_pain();
    }
    
    self clientfield::set( "ai_slow_vortex_fx", 0 );
}

// Namespace _zm_weap_raygun_mark3
// Params 3
// Checksum 0xfc7ca3bc, Offset: 0x1408
// Size: 0x1ac
function disintegrate_zombie( e_inflictor, e_attacker, w_weapon )
{
    self endon( #"death" );
    
    if ( isdefined( self.b_disintegrating ) && self.b_disintegrating )
    {
        return;
    }
    
    self.b_disintegrating = 1;
    self clientfield::set( "ai_disintegrate", 1 );
    
    if ( isvehicle( self ) )
    {
        self ai::set_ignoreall( 1 );
        wait 1.1;
        self ghost();
        self dodamage( self.health, self.origin, e_attacker, e_inflictor, undefined, "MOD_UNKNOWN", 0, w_weapon );
        return;
    }
    
    self scene::play( "cin_zm_dlc3_zombie_dth_deathray_0" + randomintrange( 1, 5 ), self );
    self clientfield::set( "ai_slow_vortex_fx", 0 );
    util::wait_network_frame();
    self ghost();
    self dodamage( self.health, self.origin, e_attacker, e_inflictor, undefined, "MOD_UNKNOWN", 0, w_weapon );
}

