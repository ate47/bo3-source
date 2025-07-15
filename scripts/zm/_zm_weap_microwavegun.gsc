#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_weap_microwavegun;

// Namespace zm_weap_microwavegun
// Params 0, eflags: 0x2
// Checksum 0x85f96191, Offset: 0x650
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_weap_microwavegun", &__init__, undefined, undefined );
}

// Namespace zm_weap_microwavegun
// Params 0
// Checksum 0x908c6f5, Offset: 0x690
// Size: 0x304
function __init__()
{
    clientfield::register( "actor", "toggle_microwavegun_hit_response", 21000, 1, "int" );
    clientfield::register( "actor", "toggle_microwavegun_expand_response", 21000, 1, "int" );
    clientfield::register( "clientuimodel", "hudItems.showDpadLeft_WaveGun", 21000, 1, "int" );
    clientfield::register( "clientuimodel", "hudItems.dpadLeftAmmo", 21000, 5, "int" );
    zm_spawner::register_zombie_damage_callback( &microwavegun_zombie_damage_response );
    zm_spawner::register_zombie_death_animscript_callback( &microwavegun_zombie_death_response );
    zombie_utility::set_zombie_var( "microwavegun_cylinder_radius", 180 );
    zombie_utility::set_zombie_var( "microwavegun_sizzle_range", 480 );
    level._effect[ "microwavegun_zap_shock_dw" ] = "dlc5/zmb_weapon/fx_zap_shock_dw";
    level._effect[ "microwavegun_zap_shock_eyes_dw" ] = "dlc5/zmb_weapon/fx_zap_shock_eyes_dw";
    level._effect[ "microwavegun_zap_shock_lh" ] = "dlc5/zmb_weapon/fx_zap_shock_lh";
    level._effect[ "microwavegun_zap_shock_eyes_lh" ] = "dlc5/zmb_weapon/fx_zap_shock_eyes_lh";
    level._effect[ "microwavegun_zap_shock_ug" ] = "dlc5/zmb_weapon/fx_zap_shock_ug";
    level._effect[ "microwavegun_zap_shock_eyes_ug" ] = "dlc5/zmb_weapon/fx_zap_shock_eyes_ug";
    animationstatenetwork::registernotetrackhandlerfunction( "expand", &function_5c6b11a6 );
    animationstatenetwork::registernotetrackhandlerfunction( "explode", &function_f8d8850f );
    level thread microwavegun_on_player_connect();
    level._microwaveable_objects = [];
    level.w_microwavegun = getweapon( "microwavegun" );
    level.w_microwavegun_upgraded = getweapon( "microwavegun_upgraded" );
    level.w_microwavegundw = getweapon( "microwavegundw" );
    level.w_microwavegundw_upgraded = getweapon( "microwavegundw_upgraded" );
    callback::on_spawned( &on_player_spawned );
}

// Namespace zm_weap_microwavegun
// Params 0
// Checksum 0xc3e82734, Offset: 0x9a0
// Size: 0x1c
function on_player_spawned()
{
    self thread function_8f95fde5();
}

// Namespace zm_weap_microwavegun
// Params 0
// Checksum 0x6a5fffe7, Offset: 0x9c8
// Size: 0x15e
function function_8f95fde5()
{
    self notify( #"hash_8f95fde5" );
    self endon( #"hash_8f95fde5" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"weapon_give", weapon );
        weapon = zm_weapons::get_nonalternate_weapon( weapon );
        
        if ( weapon == level.w_microwavegundw || weapon == level.w_microwavegundw_upgraded )
        {
            self clientfield::set_player_uimodel( "hudItems.showDpadLeft_WaveGun", 1 );
            self.var_59dcbbd4 = zm_weapons::is_weapon_upgraded( weapon );
            self thread function_1402f75f();
            continue;
        }
        
        if ( !self zm_weapons::has_weapon_or_upgrade( level.w_microwavegundw ) )
        {
            self clientfield::set_player_uimodel( "hudItems.showDpadLeft_WaveGun", 0 );
            self clientfield::set_player_uimodel( "hudItems.dpadLeftAmmo", 0 );
            self notify( #"hash_e3517683" );
            self.var_59dcbbd4 = undefined;
        }
    }
}

// Namespace zm_weap_microwavegun
// Params 0
// Checksum 0xc0a7a079, Offset: 0xb30
// Size: 0x100
function function_1402f75f()
{
    self notify( #"hash_1402f75f" );
    self endon( #"hash_1402f75f" );
    self endon( #"hash_e3517683" );
    self endon( #"disconnect" );
    self.var_db2418ce = 1;
    
    while ( true )
    {
        if ( isdefined( self.var_59dcbbd4 ) )
        {
            if ( self.var_59dcbbd4 )
            {
                ammocount = self getammocount( level.w_microwavegun_upgraded );
            }
            else
            {
                ammocount = self getammocount( level.w_microwavegun );
            }
            
            self clientfield::set_player_uimodel( "hudItems.dpadLeftAmmo", ammocount );
        }
        else
        {
            self clientfield::set_player_uimodel( "hudItems.dpadLeftAmmo", 0 );
        }
        
        wait 0.05;
    }
}

// Namespace zm_weap_microwavegun
// Params 1
// Checksum 0xb021d907, Offset: 0xc38
// Size: 0x2c
function add_microwaveable_object( ent )
{
    array::add( level._microwaveable_objects, ent, 0 );
}

// Namespace zm_weap_microwavegun
// Params 1
// Checksum 0xbf5eb938, Offset: 0xc70
// Size: 0x2c
function remove_microwaveable_object( ent )
{
    arrayremovevalue( level._microwaveable_objects, ent );
}

// Namespace zm_weap_microwavegun
// Params 0
// Checksum 0xa4222416, Offset: 0xca8
// Size: 0x38
function microwavegun_on_player_connect()
{
    for ( ;; )
    {
        level waittill( #"connecting", player );
        player thread wait_for_microwavegun_fired();
    }
}

// Namespace zm_weap_microwavegun
// Params 0
// Checksum 0x3bf57649, Offset: 0xce8
// Size: 0x90
function wait_for_microwavegun_fired()
{
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    
    for ( ;; )
    {
        self waittill( #"weapon_fired" );
        currentweapon = self getcurrentweapon();
        
        if ( currentweapon == level.w_microwavegun || currentweapon == level.w_microwavegun_upgraded )
        {
            self thread microwavegun_fired( currentweapon == level.w_microwavegun_upgraded );
        }
    }
}

// Namespace zm_weap_microwavegun
// Params 0
// Checksum 0x7c31e53d, Offset: 0xd80
// Size: 0x4c
function microwavegun_network_choke()
{
    level.microwavegun_network_choke_count++;
    
    if ( !( level.microwavegun_network_choke_count % 10 ) )
    {
        util::wait_network_frame();
        util::wait_network_frame();
        util::wait_network_frame();
    }
}

// Namespace zm_weap_microwavegun
// Params 1
// Checksum 0x7368de20, Offset: 0xdd8
// Size: 0x104
function microwavegun_fired( upgraded )
{
    if ( !isdefined( level.microwavegun_sizzle_enemies ) )
    {
        level.microwavegun_sizzle_enemies = [];
        level.microwavegun_sizzle_vecs = [];
    }
    
    self microwavegun_get_enemies_in_range( upgraded, 0 );
    self microwavegun_get_enemies_in_range( upgraded, 1 );
    level.microwavegun_network_choke_count = 0;
    
    for ( i = 0; i < level.microwavegun_sizzle_enemies.size ; i++ )
    {
        microwavegun_network_choke();
        level.microwavegun_sizzle_enemies[ i ] thread microwavegun_sizzle_zombie( self, level.microwavegun_sizzle_vecs[ i ], i );
    }
    
    level.microwavegun_sizzle_enemies = [];
    level.microwavegun_sizzle_vecs = [];
}

// Namespace zm_weap_microwavegun
// Params 2
// Checksum 0x2f821297, Offset: 0xee8
// Size: 0x5d4
function microwavegun_get_enemies_in_range( upgraded, microwaveable_objects )
{
    view_pos = self getweaponmuzzlepoint();
    test_list = [];
    range = level.zombie_vars[ "microwavegun_sizzle_range" ];
    cylinder_radius = level.zombie_vars[ "microwavegun_cylinder_radius" ];
    
    if ( microwaveable_objects )
    {
        test_list = level._microwaveable_objects;
        range *= 10;
        cylinder_radius *= 10;
    }
    else
    {
        test_list = zombie_utility::get_round_enemy_array();
    }
    
    zombies = util::get_array_of_closest( view_pos, test_list, undefined, undefined, range );
    
    if ( !isdefined( zombies ) )
    {
        return;
    }
    
    sizzle_range_squared = range * range;
    cylinder_radius_squared = cylinder_radius * cylinder_radius;
    forward_view_angles = self getweaponforwarddir();
    end_pos = view_pos + vectorscale( forward_view_angles, range );
    
    /#
        if ( 2 == getdvarint( "<dev string:x28>" ) )
        {
            near_circle_pos = view_pos + vectorscale( forward_view_angles, 2 );
            circle( near_circle_pos, cylinder_radius, ( 1, 0, 0 ), 0, 0, 100 );
            line( near_circle_pos, end_pos, ( 0, 0, 1 ), 1, 0, 100 );
            circle( end_pos, cylinder_radius, ( 1, 0, 0 ), 0, 0, 100 );
        }
    #/
    
    for ( i = 0; i < zombies.size ; i++ )
    {
        if ( isai( zombies[ i ] ) && ( !isdefined( zombies[ i ] ) || !isalive( zombies[ i ] ) ) )
        {
            continue;
        }
        
        test_origin = zombies[ i ] getcentroid();
        test_range_squared = distancesquared( view_pos, test_origin );
        
        if ( test_range_squared > sizzle_range_squared )
        {
            zombies[ i ] microwavegun_debug_print( "range", ( 1, 0, 0 ) );
            return;
        }
        
        normal = vectornormalize( test_origin - view_pos );
        dot = vectordot( forward_view_angles, normal );
        
        if ( 0 > dot )
        {
            zombies[ i ] microwavegun_debug_print( "dot", ( 1, 0, 0 ) );
            continue;
        }
        
        radial_origin = pointonsegmentnearesttopoint( view_pos, end_pos, test_origin );
        
        if ( distancesquared( test_origin, radial_origin ) > cylinder_radius_squared )
        {
            zombies[ i ] microwavegun_debug_print( "cylinder", ( 1, 0, 0 ) );
            continue;
        }
        
        if ( 0 == zombies[ i ] damageconetrace( view_pos, self ) )
        {
            zombies[ i ] microwavegun_debug_print( "cone", ( 1, 0, 0 ) );
            continue;
        }
        
        if ( isai( zombies[ i ] ) )
        {
            level.microwavegun_sizzle_enemies[ level.microwavegun_sizzle_enemies.size ] = zombies[ i ];
            dist_mult = ( sizzle_range_squared - test_range_squared ) / sizzle_range_squared;
            sizzle_vec = vectornormalize( test_origin - view_pos );
            
            if ( 5000 < test_range_squared )
            {
                sizzle_vec += vectornormalize( test_origin - radial_origin );
            }
            
            sizzle_vec = ( sizzle_vec[ 0 ], sizzle_vec[ 1 ], abs( sizzle_vec[ 2 ] ) );
            sizzle_vec = vectorscale( sizzle_vec, 100 + 100 * dist_mult );
            level.microwavegun_sizzle_vecs[ level.microwavegun_sizzle_vecs.size ] = sizzle_vec;
            continue;
        }
        
        zombies[ i ] notify( #"microwaved", self );
    }
}

// Namespace zm_weap_microwavegun
// Params 2
// Checksum 0xbd766163, Offset: 0x14c8
// Size: 0x8c
function microwavegun_debug_print( msg, color )
{
    /#
        if ( !getdvarint( "<dev string:x28>" ) )
        {
            return;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        print3d( self.origin + ( 0, 0, 60 ), msg, color, 1, 1, 40 );
    #/
}

// Namespace zm_weap_microwavegun
// Params 3
// Checksum 0x83d8d031, Offset: 0x1560
// Size: 0x2b4
function microwavegun_sizzle_zombie( player, sizzle_vec, index )
{
    if ( !isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( isdefined( self.microwavegun_sizzle_func ) )
    {
        self [[ self.microwavegun_sizzle_func ]]( player );
        return;
    }
    
    self.no_gib = 1;
    self.gibbed = 1;
    self.skipautoragdoll = 1;
    self.microwavegun_death = 1;
    self dodamage( self.health + 666, player.origin, player );
    
    if ( self.health <= 0 )
    {
        points = 10;
        
        if ( !index )
        {
            points = zm_score::get_zombie_death_player_points();
        }
        else if ( 1 == index )
        {
            points = 30;
        }
        
        player zm_score::player_add_points( "thundergun_fling", points );
        instant_explode = 0;
        
        if ( self.isdog )
        {
            self.a.nodeath = undefined;
            instant_explode = 1;
        }
        
        if ( isdefined( self.in_the_ceiling ) && ( isdefined( self.is_traversing ) && self.is_traversing || self.in_the_ceiling ) )
        {
            self.deathanim = undefined;
            instant_explode = 1;
        }
        
        if ( instant_explode )
        {
            if ( isdefined( self.animname ) && self.animname != "astro_zombie" )
            {
                self thread setup_microwavegun_vox( player );
            }
            
            self clientfield::set( "toggle_microwavegun_expand_response", 1 );
            self thread microwavegun_sizzle_death_ending();
            return;
        }
        
        if ( isdefined( self.animname ) && self.animname != "astro_zombie" )
        {
            self thread setup_microwavegun_vox( player, 6 );
        }
        
        self clientfield::set( "toggle_microwavegun_hit_response", 1 );
        self.nodeathragdoll = 1;
        self.handle_death_notetracks = &microwavegun_handle_death_notetracks;
    }
}

// Namespace zm_weap_microwavegun
// Params 1
// Checksum 0x6b8cc7fb, Offset: 0x1820
// Size: 0x84
function microwavegun_handle_death_notetracks( note )
{
    if ( note == "expand" )
    {
        self clientfield::set( "toggle_microwavegun_expand_response", 1 );
        return;
    }
    
    if ( note == "explode" )
    {
        self clientfield::set( "toggle_microwavegun_expand_response", 0 );
        self thread microwavegun_sizzle_death_ending();
    }
}

// Namespace zm_weap_microwavegun
// Params 0
// Checksum 0x5f0d0fe8, Offset: 0x18b0
// Size: 0x44
function microwavegun_sizzle_death_ending()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self ghost();
    wait 0.1;
    self zm_utility::self_delete();
}

// Namespace zm_weap_microwavegun
// Params 3
// Checksum 0xe1161be3, Offset: 0x1900
// Size: 0x184
function microwavegun_dw_zombie_hit_response_internal( mod, damageweapon, player )
{
    player endon( #"disconnect" );
    
    if ( !isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( self.isdog )
    {
        self.a.nodeath = undefined;
    }
    
    if ( isdefined( self.is_traversing ) && self.is_traversing )
    {
        self.deathanim = undefined;
    }
    
    self.skipautoragdoll = 1;
    self.microwavegun_dw_death = 1;
    self thread microwavegun_zap_death_fx( damageweapon );
    
    if ( isdefined( self.microwavegun_zap_damage_func ) )
    {
        self [[ self.microwavegun_zap_damage_func ]]( player );
        return;
    }
    else
    {
        self dodamage( self.health + 666, self.origin, player );
    }
    
    player zm_score::player_add_points( "death", "", "" );
    
    if ( randomintrange( 0, 101 ) >= 75 )
    {
        player thread zm_audio::create_and_play_dialog( "kill", "micro_dual" );
    }
}

// Namespace zm_weap_microwavegun
// Params 1
// Checksum 0xe3157613, Offset: 0x1a90
// Size: 0x92
function microwavegun_zap_get_shock_fx( weapon )
{
    if ( weapon == getweapon( "microwavegundw" ) )
    {
        return level._effect[ "microwavegun_zap_shock_dw" ];
    }
    
    if ( weapon == getweapon( "microwavegunlh" ) )
    {
        return level._effect[ "microwavegun_zap_shock_lh" ];
    }
    
    return level._effect[ "microwavegun_zap_shock_ug" ];
}

// Namespace zm_weap_microwavegun
// Params 1
// Checksum 0xc9ae30ff, Offset: 0x1b30
// Size: 0x92
function microwavegun_zap_get_shock_eyes_fx( weapon )
{
    if ( weapon == getweapon( "microwavegundw" ) )
    {
        return level._effect[ "microwavegun_zap_shock_eyes_dw" ];
    }
    
    if ( weapon == getweapon( "microwavegunlh" ) )
    {
        return level._effect[ "microwavegun_zap_shock_eyes_lh" ];
    }
    
    return level._effect[ "microwavegun_zap_shock_eyes_ug" ];
}

// Namespace zm_weap_microwavegun
// Params 1
// Checksum 0x3d5487c7, Offset: 0x1bd0
// Size: 0x4c
function microwavegun_zap_head_gib( weapon )
{
    self endon( #"death" );
    zm_net::network_safe_play_fx_on_tag( "microwavegun_zap_death_fx", 2, microwavegun_zap_get_shock_eyes_fx( weapon ), self, "J_Eyeball_LE" );
}

// Namespace zm_weap_microwavegun
// Params 1
// Checksum 0xacd041fa, Offset: 0x1c28
// Size: 0xf4
function microwavegun_zap_death_fx( weapon )
{
    tag = "J_SpineUpper";
    
    if ( self.isdog )
    {
        tag = "J_Spine1";
    }
    
    zm_net::network_safe_play_fx_on_tag( "microwavegun_zap_death_fx", 2, microwavegun_zap_get_shock_fx( weapon ), self, tag );
    self playsound( "wpn_imp_tesla" );
    
    if ( isdefined( self.head_gibbed ) && self.head_gibbed )
    {
        return;
    }
    
    if ( isdefined( self.microwavegun_zap_head_gib_func ) )
    {
        self thread [[ self.microwavegun_zap_head_gib_func ]]( weapon );
        return;
    }
    
    if ( "quad_zombie" != self.animname )
    {
        self thread microwavegun_zap_head_gib( weapon );
    }
}

// Namespace zm_weap_microwavegun
// Params 13
// Checksum 0x6b7e186, Offset: 0x1d28
// Size: 0xb4, Type: bool
function microwavegun_zombie_damage_response( str_mod, str_hit_location, v_hit_origin, e_attacker, n_amount, w_weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel )
{
    if ( self is_microwavegun_dw_damage() )
    {
        self thread microwavegun_dw_zombie_hit_response_internal( str_mod, self.damageweapon, e_attacker );
        return true;
    }
    
    return false;
}

// Namespace zm_weap_microwavegun
// Params 0
// Checksum 0x88726fca, Offset: 0x1de8
// Size: 0xa8, Type: bool
function microwavegun_zombie_death_response()
{
    if ( self enemy_killed_by_dw_microwavegun() )
    {
        if ( isdefined( self.attacker ) && isdefined( level.hero_power_update ) )
        {
            level thread [[ level.hero_power_update ]]( self.attacker, self );
        }
        
        return true;
    }
    else if ( self enemy_killed_by_microwavegun() )
    {
        if ( isdefined( self.attacker ) && isdefined( level.hero_power_update ) )
        {
            level thread [[ level.hero_power_update ]]( self.attacker, self );
        }
        
        return true;
    }
    
    return false;
}

// Namespace zm_weap_microwavegun
// Params 0
// Checksum 0x853f8321, Offset: 0x1e98
// Size: 0xa0, Type: bool
function is_microwavegun_dw_damage()
{
    return ( self.damageweapon == getweapon( "microwavegundw" ) || self.damageweapon == getweapon( "microwavegundw_upgraded" ) || self.damageweapon == getweapon( "microwavegunlh" ) || isdefined( self.damageweapon ) && self.damageweapon == getweapon( "microwavegunlh_upgraded" ) ) && self.damagemod == "MOD_IMPACT";
}

// Namespace zm_weap_microwavegun
// Params 0
// Checksum 0xa7ac0d97, Offset: 0x1f40
// Size: 0x16, Type: bool
function enemy_killed_by_dw_microwavegun()
{
    return isdefined( self.microwavegun_dw_death ) && self.microwavegun_dw_death;
}

// Namespace zm_weap_microwavegun
// Params 0
// Checksum 0xf1972cee, Offset: 0x1f60
// Size: 0x5c, Type: bool
function is_microwavegun_damage()
{
    return self.damagemod != "MOD_GRENADE" && ( self.damageweapon == level.w_microwavegun || isdefined( self.damageweapon ) && self.damageweapon == level.w_microwavegun_upgraded ) && self.damagemod != "MOD_GRENADE_SPLASH";
}

// Namespace zm_weap_microwavegun
// Params 0
// Checksum 0x5124e6f8, Offset: 0x1fc8
// Size: 0x16, Type: bool
function enemy_killed_by_microwavegun()
{
    return isdefined( self.microwavegun_death ) && self.microwavegun_death;
}

// Namespace zm_weap_microwavegun
// Params 0
// Checksum 0xbc2b4748, Offset: 0x1fe8
// Size: 0x110
function microwavegun_sound_thread()
{
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    
    for ( ;; )
    {
        result = self util::waittill_any_return( "grenade_fire", "death", "player_downed", "weapon_change", "grenade_pullback" );
        
        if ( !isdefined( result ) )
        {
            continue;
        }
        
        if ( ( result == "weapon_change" || result == "grenade_fire" ) && self getcurrentweapon() == level.w_microwavegun )
        {
            self playloopsound( "tesla_idle", 0.25 );
            continue;
        }
        
        self notify( #"weap_away" );
        self stoploopsound( 0.25 );
    }
}

// Namespace zm_weap_microwavegun
// Params 2
// Checksum 0x83826ae9, Offset: 0x2100
// Size: 0x9c
function setup_microwavegun_vox( player, waittime )
{
    level notify( #"force_end_microwave_vox" );
    level endon( #"force_end_microwave_vox" );
    
    if ( !isdefined( waittime ) )
    {
        waittime = 0.05;
    }
    
    wait waittime;
    
    if ( 50 > randomintrange( 1, 100 ) && isdefined( player ) )
    {
        player thread zm_audio::create_and_play_dialog( "kill", "micro_single" );
    }
}

// Namespace zm_weap_microwavegun
// Params 1
// Checksum 0xba4713c1, Offset: 0x21a8
// Size: 0x2c
function function_5c6b11a6( entity )
{
    self clientfield::set( "toggle_microwavegun_expand_response", 1 );
}

// Namespace zm_weap_microwavegun
// Params 1
// Checksum 0xbcf33dc7, Offset: 0x21e0
// Size: 0x44
function function_f8d8850f( entity )
{
    self clientfield::set( "toggle_microwavegun_expand_response", 0 );
    self thread microwavegun_sizzle_death_ending();
}

