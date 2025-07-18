#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_staff_common;
#using scripts/zm/zm_tomb_utility;

#namespace zm_weap_staff_air;

// Namespace zm_weap_staff_air
// Params 0, eflags: 0x2
// Checksum 0xa3f2b770, Offset: 0x410
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_weap_staff_air", &__init__, undefined, undefined );
}

// Namespace zm_weap_staff_air
// Params 0
// Checksum 0xf1bfe87d, Offset: 0x450
// Size: 0x16c
function __init__()
{
    level._effect[ "whirlwind" ] = "weapon/zmb_staff/fx_zmb_staff_air_ug_impact_miss";
    clientfield::register( "scriptmover", "whirlwind_play_fx", 21000, 1, "int" );
    clientfield::register( "actor", "air_staff_launch", 21000, 1, "int" );
    clientfield::register( "allplayers", "air_staff_source", 21000, 1, "int" );
    callback::on_spawned( &onplayerspawned );
    level flag::init( "whirlwind_active" );
    zm_spawner::register_zombie_damage_callback( &staff_air_zombie_damage_response );
    zm_spawner::register_zombie_death_event_callback( &staff_air_death_event );
    level.w_staff_air = getweapon( "staff_air" );
    level.w_staff_air_upgraded = getweapon( "staff_air_upgraded" );
}

// Namespace zm_weap_staff_air
// Params 0
// Checksum 0xb7c64e83, Offset: 0x5c8
// Size: 0x54
function onplayerspawned()
{
    self endon( #"disconnect" );
    self thread watch_staff_air_fired();
    self thread watch_staff_air_impact();
    self thread zm_tomb_utility::watch_staff_usage();
}

// Namespace zm_weap_staff_air
// Params 0
// Checksum 0x1e14aef2, Offset: 0x628
// Size: 0x2c
function air_projectile_delete()
{
    self endon( #"death" );
    wait 0.75;
    self delete();
}

// Namespace zm_weap_staff_air
// Params 0
// Checksum 0x9b3f49f1, Offset: 0x660
// Size: 0xf8
function watch_staff_air_fired()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"missile_fire", e_projectile, w_weapon );
        
        if ( w_weapon.name == "staff_air_upgraded" || w_weapon.name == "staff_air" )
        {
            e_projectile thread air_projectile_delete();
            wind_damage_cone( w_weapon );
            self clientfield::set( "air_staff_source", 1 );
            util::wait_network_frame();
            self clientfield::set( "air_staff_source", 0 );
        }
    }
}

// Namespace zm_weap_staff_air
// Params 0
// Checksum 0xce57585e, Offset: 0x760
// Size: 0xb0
function watch_staff_air_impact()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"projectile_impact", w_weapon, v_explode_point, n_radius, projectile );
        
        if ( w_weapon.name == "staff_air_upgraded2" || w_weapon.name == "staff_air_upgraded3" )
        {
            self thread staff_air_find_source( v_explode_point, w_weapon );
        }
    }
}

// Namespace zm_weap_staff_air
// Params 2
// Checksum 0xaa8ca3d7, Offset: 0x818
// Size: 0x184
function staff_air_find_source( v_detonate, w_weapon )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( v_detonate ) )
    {
        return;
    }
    
    a_zombies = getaiarray();
    a_zombies = util::get_array_of_closest( v_detonate, a_zombies );
    
    if ( a_zombies.size )
    {
        for ( i = 0; i < a_zombies.size ; i++ )
        {
            if ( isalive( a_zombies[ i ] ) )
            {
                if ( isdefined( a_zombies[ i ].staff_hit ) && a_zombies[ i ].staff_hit )
                {
                    continue;
                }
                
                if ( distance2dsquared( v_detonate, a_zombies[ i ].origin ) <= 10000 )
                {
                    self thread staff_air_zombie_source( a_zombies[ 0 ], w_weapon );
                    return;
                }
                
                self thread staff_air_position_source( v_detonate, w_weapon );
                return;
            }
        }
        
        return;
    }
    
    self thread staff_air_position_source( v_detonate, w_weapon );
}

// Namespace zm_weap_staff_air
// Params 2
// Checksum 0xff8d0695, Offset: 0x9a8
// Size: 0xac
function staff_air_zombie_source( ai_zombie, w_weapon )
{
    self endon( #"disconnect" );
    ai_zombie.staff_hit = 1;
    ai_zombie.is_source = 1;
    v_whirlwind_pos = ai_zombie.origin;
    self thread staff_air_position_source( v_whirlwind_pos, w_weapon );
    
    if ( !isdefined( ai_zombie.is_mechz ) )
    {
        self thread source_zombie_death( ai_zombie );
    }
}

// Namespace zm_weap_staff_air
// Params 2
// Checksum 0xdb61b19e, Offset: 0xa60
// Size: 0x23c
function staff_air_position_source( v_detonate, w_weapon )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( v_detonate ) )
    {
        return;
    }
    
    if ( level flag::get( "whirlwind_active" ) )
    {
        level notify( #"whirlwind_stopped" );
        
        while ( level flag::get( "whirlwind_active" ) )
        {
            util::wait_network_frame();
        }
        
        wait 0.3;
    }
    
    level flag::set( "whirlwind_active" );
    n_time = self.chargeshotlevel * 3.5;
    e_whirlwind = spawn( "script_model", v_detonate + ( 0, 0, 100 ) );
    e_whirlwind setmodel( "tag_origin" );
    e_whirlwind.angles = ( -90, 0, 0 );
    e_whirlwind thread zm_tomb_utility::puzzle_debug_position( "X", ( 255, 255, 0 ) );
    e_whirlwind moveto( zm_utility::groundpos_ignore_water_new( e_whirlwind.origin ), 0.05 );
    e_whirlwind waittill( #"movedone" );
    e_whirlwind clientfield::set( "whirlwind_play_fx", 1 );
    e_whirlwind thread zm_tomb_utility::whirlwind_rumble_nearby_players( "whirlwind_active" );
    e_whirlwind thread whirlwind_timeout( n_time );
    wait 0.5;
    e_whirlwind.player_owner = self;
    e_whirlwind thread whirlwind_seek_zombies( self.chargeshotlevel, w_weapon );
}

// Namespace zm_weap_staff_air
// Params 2
// Checksum 0x654a88d6, Offset: 0xca8
// Size: 0xbc
function whirlwind_seek_zombies( n_level, w_weapon )
{
    self endon( #"death" );
    self.b_found_zombies = 0;
    n_range = get_air_blast_range( n_level );
    
    while ( true )
    {
        a_zombies = staff_air_zombie_range( self.origin, n_range );
        
        if ( a_zombies.size )
        {
            self.b_found_zombies = 1;
            self thread whirlwind_kill_zombies( n_level, w_weapon );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace zm_weap_staff_air
// Params 1
// Checksum 0xbec17c94, Offset: 0xd70
// Size: 0xac
function whirlwind_timeout( n_time )
{
    self endon( #"death" );
    level util::waittill_any_timeout( n_time, "whirlwind_stopped" );
    level notify( #"whirlwind_stopped" );
    self clientfield::set( "whirlwind_play_fx", 0 );
    self notify( #"stop_debug_position" );
    level flag::clear( "whirlwind_active" );
    wait 1.5;
    self delete();
}

// Namespace zm_weap_staff_air
// Params 2
// Checksum 0x69bcfa69, Offset: 0xe28
// Size: 0xac
function move_along_ground_position( v_position, n_time )
{
    v_diff = vectornormalize( v_position - self.origin );
    v_newpos = self.origin + v_diff * 50 + ( 0, 0, 50 );
    v_ground = zm_utility::groundpos_ignore_water_new( v_newpos );
    self moveto( v_ground, n_time );
}

// Namespace zm_weap_staff_air
// Params 2
// Checksum 0x8bd63839, Offset: 0xee0
// Size: 0x2c8
function whirlwind_kill_zombies( n_level, w_weapon )
{
    self endon( #"death" );
    n_range = get_air_blast_range( n_level );
    self.n_charge_level = n_level;
    
    while ( true )
    {
        a_zombies = staff_air_zombie_range( self.origin, n_range );
        a_zombies = util::get_array_of_closest( self.origin, a_zombies );
        
        for ( i = 0; i < a_zombies.size ; i++ )
        {
            if ( !isdefined( a_zombies[ i ] ) )
            {
                continue;
            }
            
            if ( !( isdefined( a_zombies[ i ].completed_emerging_into_playable_area ) && a_zombies[ i ].completed_emerging_into_playable_area ) )
            {
                continue;
            }
            
            if ( isdefined( a_zombies[ i ].is_mechz ) && a_zombies[ i ].is_mechz )
            {
                continue;
            }
            
            if ( isdefined( self._whirlwind_attract_anim ) && self._whirlwind_attract_anim )
            {
                continue;
            }
            
            v_offset = ( 10, 10, 32 );
            
            if ( !zm_tomb_utility::bullet_trace_throttled( self.origin + v_offset, a_zombies[ i ].origin + v_offset, undefined ) )
            {
                continue;
            }
            
            if ( !isdefined( a_zombies[ i ] ) || !isalive( a_zombies[ i ] ) )
            {
                continue;
            }
            
            v_offset = ( -10, -10, 64 );
            
            if ( !zm_tomb_utility::bullet_trace_throttled( self.origin + v_offset, a_zombies[ i ].origin + v_offset, undefined ) )
            {
                continue;
            }
            
            if ( !isdefined( a_zombies[ i ] ) || !isalive( a_zombies[ i ] ) )
            {
                continue;
            }
            
            a_zombies[ i ] thread whirlwind_drag_zombie( self, w_weapon );
            wait 0.5;
        }
        
        util::wait_network_frame();
    }
}

// Namespace zm_weap_staff_air
// Params 2
// Checksum 0x9e4f41fc, Offset: 0x11b0
// Size: 0xcc
function whirlwind_drag_zombie( e_whirlwind, w_weapon )
{
    if ( isdefined( self.e_linker ) )
    {
        return;
    }
    
    self whirlwind_move_zombie( e_whirlwind );
    
    if ( isdefined( self ) && isdefined( e_whirlwind ) && level flag::get( "whirlwind_active" ) )
    {
        player = e_whirlwind.player_owner;
        self zm_tomb_utility::do_damage_network_safe( player, self.health, w_weapon, "MOD_IMPACT" );
        level thread staff_air_gib( self );
    }
}

// Namespace zm_weap_staff_air
// Params 1
// Checksum 0x93d1df45, Offset: 0x1288
// Size: 0x234
function whirlwind_move_zombie( e_whirlwind )
{
    if ( isdefined( self.e_linker ) )
    {
        return;
    }
    
    self.e_linker = spawn( "script_origin", ( 0, 0, 0 ) );
    self.e_linker.origin = self.origin;
    self.e_linker.angles = self.angles;
    self linkto( self.e_linker );
    self thread whirlwind_unlink( e_whirlwind );
    
    if ( isdefined( e_whirlwind ) )
    {
        n_dist_sq = distance2dsquared( e_whirlwind.origin, self.origin );
    }
    
    n_fling_range_sq = 900;
    
    while ( isalive( self ) && n_dist_sq > n_fling_range_sq && isdefined( e_whirlwind ) && level flag::get( "whirlwind_active" ) )
    {
        n_dist_sq = distance2dsquared( e_whirlwind.origin, self.origin );
        b_supercharged = e_whirlwind.n_charge_level == 3;
        self thread whirlwind_attract_anim( e_whirlwind.origin, b_supercharged );
        n_movetime = 1;
        
        if ( b_supercharged )
        {
            n_movetime = 0.8;
        }
        
        self.e_linker thread move_along_ground_position( e_whirlwind.origin, n_movetime );
        wait 0.05;
    }
    
    self notify( #"reached_whirlwind" );
    self.e_linker delete();
}

// Namespace zm_weap_staff_air
// Params 1
// Checksum 0xd89fdcb, Offset: 0x14c8
// Size: 0x3c
function whirlwind_unlink( e_whirlwind )
{
    self endon( #"death" );
    e_whirlwind waittill( #"death" );
    self unlink();
}

// Namespace zm_weap_staff_air
// Params 1
// Checksum 0x9e794768, Offset: 0x1510
// Size: 0xf4
function source_zombie_death( ai_zombie )
{
    self endon( #"disconnect" );
    n_range = get_air_blast_range( self.chargeshotlevel );
    tag = "J_SpineUpper";
    
    if ( ai_zombie.isdog )
    {
        tag = "J_Spine1";
    }
    
    v_source = ai_zombie gettagorigin( tag );
    ai_zombie thread staff_air_fling_zombie( self );
    a_zombies = staff_air_zombie_range( v_source, n_range );
    
    if ( !isdefined( a_zombies ) )
    {
        return;
    }
    
    self thread staff_air_proximity_kill( a_zombies );
}

// Namespace zm_weap_staff_air
// Params 1
// Checksum 0xea0eef7f, Offset: 0x1610
// Size: 0x56
function get_air_blast_range( n_charge )
{
    switch ( n_charge )
    {
        case 1:
            n_range = 100;
            break;
        default:
            n_range = 250;
            break;
    }
    
    return n_range;
}

// Namespace zm_weap_staff_air
// Params 1
// Checksum 0xd6295f9c, Offset: 0x1670
// Size: 0x8e
function staff_air_proximity_kill( a_zombies )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( a_zombies ) )
    {
        return;
    }
    
    for ( i = 0; i < a_zombies.size ; i++ )
    {
        if ( isalive( a_zombies[ i ] ) )
        {
            a_zombies[ i ] thread staff_air_fling_zombie( self );
            wait 0.05;
        }
    }
}

// Namespace zm_weap_staff_air
// Params 2
// Checksum 0x63312265, Offset: 0x1708
// Size: 0x15e
function staff_air_zombie_range( v_source, n_range )
{
    a_enemies = [];
    a_zombies = getaiarray();
    a_zombies = util::get_array_of_closest( v_source, a_zombies );
    n_range_sq = n_range * n_range;
    
    if ( isdefined( a_zombies ) )
    {
        for ( i = 0; i < a_zombies.size ; i++ )
        {
            if ( !isdefined( a_zombies[ i ] ) )
            {
                continue;
            }
            
            v_zombie_pos = a_zombies[ i ].origin;
            
            if ( isdefined( a_zombies[ i ].staff_hit ) && a_zombies[ i ].staff_hit == 1 )
            {
                continue;
            }
            
            if ( distancesquared( v_source, v_zombie_pos ) > n_range_sq )
            {
                continue;
            }
            
            a_enemies[ a_enemies.size ] = a_zombies[ i ];
        }
    }
    
    return a_enemies;
}

// Namespace zm_weap_staff_air
// Params 1
// Checksum 0xfbe45639, Offset: 0x1870
// Size: 0xbc
function staff_air_fling_zombie( player )
{
    player endon( #"disconnect" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( isdefined( self.is_source ) || math::cointoss() )
    {
        self thread zombie_launch( player, level.w_staff_air_upgraded );
        return;
    }
    
    self zm_tomb_utility::do_damage_network_safe( player, self.health, level.w_staff_air_upgraded, "MOD_IMPACT" );
    level thread staff_air_gib( self );
}

// Namespace zm_weap_staff_air
// Params 2
// Checksum 0x2a57743e, Offset: 0x1938
// Size: 0xcc
function zombie_launch( e_attacker, w_weapon )
{
    self zm_tomb_utility::do_damage_network_safe( e_attacker, self.health, w_weapon, "MOD_IMPACT" );
    
    if ( isdefined( level.ragdoll_limit_check ) && ![[ level.ragdoll_limit_check ]]() )
    {
        level thread staff_air_gib( self );
        return;
    }
    
    if ( isdefined( self.is_mechz ) && self.is_mechz )
    {
        return;
    }
    
    self startragdoll();
    self clientfield::set( "air_staff_launch", 1 );
}

// Namespace zm_weap_staff_air
// Params 2
// Checksum 0x5007a274, Offset: 0x1a10
// Size: 0x8c
function determine_launch_vector( e_attacker, ai_target )
{
    v_launch = vectornormalize( ai_target.origin - e_attacker.origin ) * randomintrange( 125, 150 ) + ( 0, 0, randomintrange( 75, 150 ) );
    return v_launch;
}

// Namespace zm_weap_staff_air
// Params 1
// Checksum 0xedb8979f, Offset: 0x1aa8
// Size: 0x4c
function staff_air_gib( ai_zombie )
{
    if ( math::cointoss() )
    {
        ai_zombie thread zm_tomb_utility::zombie_gib_all();
    }
    
    ai_zombie thread zm_tomb_utility::zombie_gib_guts();
}

// Namespace zm_weap_staff_air
// Params 13
// Checksum 0xcf913ab6, Offset: 0x1b00
// Size: 0xbc, Type: bool
function staff_air_zombie_damage_response( mod, hit_location, hit_origin, player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel )
{
    if ( self is_staff_air_damage( self.damageweapon ) && mod != "MOD_MELEE" )
    {
        self thread stun_zombie();
        return true;
    }
    
    return false;
}

// Namespace zm_weap_staff_air
// Params 1
// Checksum 0xe2520e72, Offset: 0x1bc8
// Size: 0x60, Type: bool
function is_staff_air_damage( weapon )
{
    return ( weapon.name == "staff_air" || isdefined( weapon ) && weapon.name == "staff_air_upgraded" ) && !( isdefined( self.set_beacon_damage ) && self.set_beacon_damage );
}

// Namespace zm_weap_staff_air
// Params 1
// Checksum 0x622dc4f3, Offset: 0x1c30
// Size: 0xdc
function staff_air_death_event( attacker )
{
    if ( is_staff_air_damage( self.damageweapon ) && self.damagemod != "MOD_MELEE" )
    {
        if ( isdefined( self.is_mechz ) && self.is_mechz )
        {
            return;
        }
        
        self thread zombie_utility::zombie_eye_glow_stop();
        
        if ( isdefined( level.ragdoll_limit_check ) && ![[ level.ragdoll_limit_check ]]() )
        {
            level thread staff_air_gib( self );
            return;
        }
        
        self startragdoll();
        self clientfield::set( "air_staff_launch", 1 );
    }
}

// Namespace zm_weap_staff_air
// Params 1
// Checksum 0x7072f67a, Offset: 0x1d18
// Size: 0x212
function wind_damage_cone( w_weapon )
{
    fire_angles = self getplayerangles();
    fire_origin = self getplayercamerapos();
    a_targets = getaiarray();
    a_targets = util::get_array_of_closest( self.origin, a_targets, undefined, 12, 400 );
    
    if ( w_weapon.name == "staff_air_upgraded" )
    {
        n_damage = 3300;
        n_fov = 60;
    }
    else
    {
        n_damage = 2050;
        n_fov = 45;
    }
    
    foreach ( target in a_targets )
    {
        if ( isai( target ) )
        {
            if ( util::within_fov( fire_origin, fire_angles, target gettagorigin( "j_spine4" ), cos( n_fov ) ) )
            {
                if ( self zm_powerups::is_insta_kill_active() )
                {
                    n_damage = target.health;
                }
                
                target zm_tomb_utility::do_damage_network_safe( self, n_damage, w_weapon, "MOD_IMPACT" );
            }
        }
    }
}

// Namespace zm_weap_staff_air
// Params 0
// Checksum 0x7a6f27bb, Offset: 0x1f38
// Size: 0xf8
function stun_zombie()
{
    self endon( #"death" );
    
    if ( isdefined( self.is_mechz ) && self.is_mechz )
    {
        return;
    }
    
    if ( isdefined( self.is_electrocuted ) && self.is_electrocuted )
    {
        return;
    }
    
    if ( !isdefined( self.ai_state ) || self.ai_state != "find_flesh" )
    {
        return;
    }
    
    self.forcemovementscriptstate = 1;
    self.ignoreall = 1;
    self.is_electrocuted = 1;
    tag = "J_SpineUpper";
    
    if ( self.isdog )
    {
        tag = "J_Spine1";
    }
    
    self zombie_shared::donotetracks( "stunned" );
    self.forcemovementscriptstate = 0;
    self.ignoreall = 0;
    self.is_electrocuted = 0;
}

// Namespace zm_weap_staff_air
// Params 0
// Checksum 0x62b57c7c, Offset: 0x2038
// Size: 0x70
function whirlwind_attract_anim_watch_cancel()
{
    self endon( #"death" );
    
    while ( level flag::get( "whirlwind_active" ) )
    {
        util::wait_network_frame();
    }
    
    self.deathanim = undefined;
    self stopanimscripted();
    self._whirlwind_attract_anim = 0;
}

// Namespace zm_weap_staff_air
// Params 2
// Checksum 0xbc0feea6, Offset: 0x20b0
// Size: 0x1e0
function whirlwind_attract_anim( v_attract_point, b_move_fast )
{
    if ( !isdefined( b_move_fast ) )
    {
        b_move_fast = 0;
    }
    
    self endon( #"death" );
    level endon( #"whirlwind_stopped" );
    
    if ( isdefined( self._whirlwind_attract_anim ) && self._whirlwind_attract_anim )
    {
        return;
    }
    
    v_angles_to_source = vectortoangles( v_attract_point - self.origin );
    v_source_to_target = vectortoangles( self.origin - v_attract_point );
    self.a.runblendtime = 0.9;
    
    if ( !( isdefined( self.missinglegs ) && self.missinglegs ) )
    {
        self._had_legs = 1;
    }
    else
    {
        self._had_legs = 0;
    }
    
    if ( b_move_fast )
    {
        blackboard::setblackboardattribute( self, "_whirlwind_speed", "whirlwind_fast" );
    }
    else
    {
        blackboard::setblackboardattribute( self, "_whirlwind_speed", "whirlwind_normal" );
    }
    
    if ( isdefined( self.nogravity ) && self.nogravity )
    {
        self animmode( "none" );
        self.nogravity = undefined;
    }
    
    self._whirlwind_attract_anim = 1;
    self.a.runblendtime = self._normal_run_blend_time;
    self thread whirlwind_attract_anim_watch_cancel();
    self waittill( #"reached_whirlwind" );
}

