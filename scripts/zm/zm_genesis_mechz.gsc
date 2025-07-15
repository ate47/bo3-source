#using scripts/codescripts/struct;
#using scripts/shared/ai/mechz;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_mechz;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_idgun;
#using scripts/zm/zm_genesis_portals;
#using scripts/zm/zm_genesis_round_bosses;
#using scripts/zm/zm_genesis_vo;

#namespace zm_genesis_mechz;

// Namespace zm_genesis_mechz
// Params 0, eflags: 0x2
// Checksum 0x2082694f, Offset: 0x6e0
// Size: 0x18c
function autoexec init()
{
    function_24ed806f();
    level flag::init( "can_spawn_mechz", 1 );
    spawner::add_archetype_spawn_function( "mechz", &function_d8d01032 );
    spawner::add_archetype_spawn_function( "mechz", &function_b7e11612 );
    level thread function_76e7495b();
    level.mechz_should_stun_override = &function_f517cdd6;
    level.var_7f2a926d = &mechz_health_increases;
    level.mechz_damage_override = &mechz_damage_override;
    level.var_7d2a391d = &spawn_effect;
    
    if ( ai::shouldregisterclientfieldforarchetype( "mechz" ) )
    {
        clientfield::register( "actor", "death_ray_shock_fx", 15000, 1, "int" );
    }
    
    clientfield::register( "actor", "mechz_fx_spawn", 15000, 1, "counter" );
    
    /#
        level thread function_78e44cda();
    #/
}

// Namespace zm_genesis_mechz
// Params 0, eflags: 0x4
// Checksum 0x91c5683b, Offset: 0x878
// Size: 0x1fc
function private function_24ed806f()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "castleMechzTrapService", &function_b25360f );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "genesisVortexService", &function_8746ceea );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "genesisMechzOctobombService", &function_2ffb7337 );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "castleMechzShouldMoveToTrap", &function_beb13c4b );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "castleMechzIsAtTrap", &function_fc277828 );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "castleMechzShouldAttackTrap", &function_d1cb5cbc );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "genesisMechzShouldOctobombAttack", &function_4e06a982 );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "casteMechzTrapMoveTerminate", &function_4210ca29 );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "casteMechzTrapAttackTerminate", &function_910e57ee );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "genesisMechzDestoryOctobomb", &function_78198ba2 );
    animationstatenetwork::registeranimationmocomp( "mocomp_trap_attack@mechz", &function_45f397ee, undefined, &function_9da58a6f );
    animationstatenetwork::registeranimationmocomp( "mocomp_teleport_traversal@mechz", &teleporttraversalmocompstart, undefined, undefined );
}

// Namespace zm_genesis_mechz
// Params 0, eflags: 0x4
// Checksum 0x7b4f9d99, Offset: 0xa80
// Size: 0xce
function private function_76e7495b()
{
    wait 0.5;
    a_e_traps = getentarray( "zombie_trap", "targetname" );
    
    foreach ( e_trap in a_e_traps )
    {
        if ( e_trap.script_noteworthy == "electric" )
        {
            level.electric_trap = e_trap;
        }
    }
}

// Namespace zm_genesis_mechz
// Params 1, eflags: 0x4
// Checksum 0x7283641e, Offset: 0xb58
// Size: 0x126, Type: bool
function private function_b25360f( entity )
{
    if ( isdefined( entity.var_72308ff2 ) && ( isdefined( entity.var_d77404f7 ) && entity.var_d77404f7 || entity.var_72308ff2 ) )
    {
        return true;
    }
    
    if ( level flag::get( "masher_on" ) )
    {
        if ( entity function_d8f5da34( "masher_trap_switch" ) )
        {
            return true;
        }
    }
    
    if ( isdefined( level.electric_trap ) )
    {
        if ( isdefined( level.electric_trap._trap_in_use ) && level.electric_trap._trap_in_use && !( isdefined( level.electric_trap._trap_cooling_down ) && level.electric_trap._trap_cooling_down ) )
        {
            if ( entity function_d8f5da34( "elec_trap_switch" ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_genesis_mechz
// Params 1, eflags: 0x4
// Checksum 0x72b858c2, Offset: 0xc88
// Size: 0x9e, Type: bool
function private function_604404( entity )
{
    if ( isdefined( self.react ) )
    {
        foreach ( react in self.react )
        {
            if ( react == entity )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zm_genesis_mechz
// Params 1, eflags: 0x4
// Checksum 0x200c993b, Offset: 0xd30
// Size: 0x3a
function private function_e92d3bb1( entity )
{
    if ( !isdefined( self.react ) )
    {
        self.react = [];
    }
    
    self.react[ self.react.size ] = entity;
}

// Namespace zm_genesis_mechz
// Params 1, eflags: 0x4
// Checksum 0x6c7e79b4, Offset: 0xd78
// Size: 0x1c2, Type: bool
function private function_8746ceea( entity )
{
    if ( !entity zm_ai_mechz::function_58655f2a() )
    {
        return false;
    }
    
    if ( isdefined( level.vortex_manager ) && isdefined( level.vortex_manager.a_active_vorticies ) )
    {
        foreach ( vortex in level.vortex_manager.a_active_vorticies )
        {
            if ( !vortex function_604404( entity ) )
            {
                dist_sq = distancesquared( vortex.origin, self.origin );
                
                if ( dist_sq < 9216 )
                {
                    entity.stun = 1;
                    entity.vortex = vortex;
                    
                    if ( isdefined( vortex.weapon ) && idgun::function_9b7ac6a9( vortex.weapon ) )
                    {
                        blackboard::setblackboardattribute( entity, "_zombie_damageweapon_type", "packed" );
                    }
                    
                    vortex function_e92d3bb1( entity );
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace zm_genesis_mechz
// Params 1, eflags: 0x4
// Checksum 0xcf00231a, Offset: 0xf48
// Size: 0x15a, Type: bool
function private function_2ffb7337( entity )
{
    if ( isdefined( entity.destroy_octobomb ) )
    {
        entity setgoal( entity.destroy_octobomb.origin );
        return true;
    }
    
    if ( isdefined( level.octobombs ) )
    {
        foreach ( octobomb in level.octobombs )
        {
            if ( isdefined( octobomb ) )
            {
                dist_sq = distancesquared( octobomb.origin, self.origin );
                
                if ( dist_sq < 360000 )
                {
                    entity.destroy_octobomb = octobomb;
                    entity setgoal( octobomb.origin );
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace zm_genesis_mechz
// Params 1, eflags: 0x4
// Checksum 0xef228288, Offset: 0x10b0
// Size: 0x184, Type: bool
function private function_d8f5da34( var_2dba2212 )
{
    var_3a067a8d = struct::get_array( var_2dba2212, "script_noteworthy" );
    self.s_trap = undefined;
    n_closest_dist_sq = 57600;
    
    foreach ( s_trap in var_3a067a8d )
    {
        n_dist_sq = distancesquared( s_trap.origin, self.origin );
        
        if ( n_dist_sq < n_closest_dist_sq )
        {
            n_closest_dist_sq = n_dist_sq;
            self.s_trap = s_trap;
        }
    }
    
    if ( isdefined( self.s_trap ) )
    {
        self.var_d77404f7 = 1;
        self.ignoreall = 1;
        self setgoal( self.s_trap.origin );
        self thread function_957c9419();
        return true;
    }
    
    return false;
}

// Namespace zm_genesis_mechz
// Params 0
// Checksum 0x56378946, Offset: 0x1240
// Size: 0x94
function function_957c9419()
{
    self endon( #"death" );
    wait 60;
    
    if ( isdefined( self.ignoreall ) && ( isdefined( self.var_72308ff2 ) && ( isdefined( self.var_d77404f7 ) && self.var_d77404f7 || self.var_72308ff2 ) || self.ignoreall ) )
    {
        self.var_d77404f7 = 0;
        self.var_72308ff2 = 0;
        self.ignoreall = 0;
        mechzbehavior::mechztargetservice( self );
    }
}

// Namespace zm_genesis_mechz
// Params 1
// Checksum 0x62eb8dcb, Offset: 0x12e0
// Size: 0x3a, Type: bool
function function_beb13c4b( entity )
{
    if ( isdefined( entity.var_d77404f7 ) && entity.var_d77404f7 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_genesis_mechz
// Params 1
// Checksum 0x4cf7a31, Offset: 0x1328
// Size: 0x2e, Type: bool
function function_fc277828( entity )
{
    if ( entity isatgoal() )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_genesis_mechz
// Params 1
// Checksum 0xf00a1db5, Offset: 0x1360
// Size: 0x3a, Type: bool
function function_d1cb5cbc( entity )
{
    if ( isdefined( entity.var_72308ff2 ) && entity.var_72308ff2 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_genesis_mechz
// Params 1, eflags: 0x4
// Checksum 0x8d6fdf20, Offset: 0x13a8
// Size: 0xbe, Type: bool
function private function_4e06a982( entity )
{
    if ( !isdefined( entity.destroy_octobomb ) )
    {
        return false;
    }
    
    if ( distancesquared( entity.origin, entity.destroy_octobomb.origin ) > 16384 )
    {
        return false;
    }
    
    yaw = abs( zombie_utility::getyawtospot( entity.destroy_octobomb.origin ) );
    
    if ( yaw > 45 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_genesis_mechz
// Params 1
// Checksum 0x2fdf1357, Offset: 0x1470
// Size: 0x30
function function_4210ca29( entity )
{
    entity.var_d77404f7 = 0;
    entity.var_72308ff2 = 1;
}

// Namespace zm_genesis_mechz
// Params 1
// Checksum 0xb370ce16, Offset: 0x14a8
// Size: 0xb4
function function_910e57ee( entity )
{
    entity.var_72308ff2 = 0;
    entity.ignoreall = 0;
    
    if ( isdefined( entity.s_trap ) )
    {
        if ( entity.s_trap.script_noteworthy == "masher_trap_switch" )
        {
            level flag::clear( "masher_on" );
        }
        else
        {
            level.electric_trap notify( #"trap_deactivate" );
        }
    }
    
    mechzbehavior::mechztargetservice( entity );
}

// Namespace zm_genesis_mechz
// Params 1
// Checksum 0x17184bf0, Offset: 0x1568
// Size: 0x64
function function_78198ba2( entity )
{
    if ( isdefined( entity.destroy_octobomb ) )
    {
        entity.destroy_octobomb detonate();
        entity.destroy_octobomb = undefined;
    }
    
    mechzbehavior::mechzstopflame( entity );
}

// Namespace zm_genesis_mechz
// Params 5
// Checksum 0x8af26e9a, Offset: 0x15d8
// Size: 0x84
function function_45f397ee( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    entity orientmode( "face angle", entity.s_trap.angles[ 1 ] );
    entity animmode( "normal" );
}

// Namespace zm_genesis_mechz
// Params 5
// Checksum 0xc8867e8e, Offset: 0x1668
// Size: 0x4c
function function_9da58a6f( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    entity orientmode( "face default" );
}

// Namespace zm_genesis_mechz
// Params 0
// Checksum 0x6d4acc3f, Offset: 0x16c0
// Size: 0x2ec
function mechz_health_increases()
{
    if ( !isdefined( level.mechz_last_spawn_round ) || level.round_number > level.mechz_last_spawn_round )
    {
        a_players = getplayers();
        n_player_modifier = 1;
        
        switch ( a_players.size )
        {
            case 0:
            case 1:
                n_player_modifier = 1;
                break;
            case 2:
                n_player_modifier = 1.33;
                break;
            case 3:
                n_player_modifier = 1.66;
                break;
            case 4:
                n_player_modifier = 2;
                break;
        }
        
        var_485a2c2c = level.zombie_health / level.zombie_vars[ "zombie_health_start" ];
        level.mechz_health = int( n_player_modifier * ( level.mechz_base_health + level.mechz_health_increase * var_485a2c2c ) );
        level.mechz_faceplate_health = int( n_player_modifier * ( level.var_fa14536d + level.var_1a5bb9d8 * var_485a2c2c ) );
        level.mechz_powercap_cover_health = int( n_player_modifier * ( level.mechz_powercap_cover_health + level.var_a1943286 * var_485a2c2c ) );
        level.mechz_powercap_health = int( n_player_modifier * ( level.mechz_powercap_health + level.var_9684c99e * var_485a2c2c ) );
        level.var_2cbc5b59 = int( n_player_modifier * ( level.var_3f1bf221 + level.var_158234c * var_485a2c2c ) );
        level.mechz_health = function_26beb37e( level.mechz_health, 17500, n_player_modifier );
        level.mechz_faceplate_health = function_26beb37e( level.mechz_faceplate_health, 16000, n_player_modifier );
        level.mechz_powercap_cover_health = function_26beb37e( level.mechz_powercap_cover_health, 7500, n_player_modifier );
        level.mechz_powercap_health = function_26beb37e( level.mechz_powercap_health, 5000, n_player_modifier );
        level.var_2cbc5b59 = function_26beb37e( level.var_2cbc5b59, 3500, n_player_modifier );
        level.mechz_last_spawn_round = level.round_number;
    }
}

// Namespace zm_genesis_mechz
// Params 3
// Checksum 0xd8f5e84c, Offset: 0x19b8
// Size: 0x54
function function_26beb37e( n_value, n_limit, n_player_modifier )
{
    if ( n_value >= n_limit * n_player_modifier )
    {
        n_value = int( n_limit * n_player_modifier );
    }
    
    return n_value;
}

// Namespace zm_genesis_mechz
// Params 0
// Checksum 0x3fa40fb3, Offset: 0x1a18
// Size: 0xfa
function function_d8d01032()
{
    self.idgun_damage_cb = &function_5f2149bb;
    self.var_c732138b = &function_1df1ec14;
    self.traversalspeedboost = &function_40ef38f8;
    self thread function_a2a11991();
    self thread function_b2a1b297();
    self thread function_2a26e636();
    self thread zm::update_zone_name();
    self waittill( #"death" );
    self thread function_2a2bfc25();
    
    if ( isdefined( self.var_9b31a70d ) && self.var_9b31a70d )
    {
        level.var_638dde56--;
    }
    
    level notify( #"hash_8f65ad3d" );
}

// Namespace zm_genesis_mechz
// Params 0
// Checksum 0x395bf9f3, Offset: 0x1b20
// Size: 0x64
function spawn_effect()
{
    self function_1faf1646();
    util::wait_network_frame();
    self clientfield::increment( "mechz_fx_spawn" );
    wait 1;
    self function_ee090a93();
}

// Namespace zm_genesis_mechz
// Params 0
// Checksum 0x2363b45c, Offset: 0x1b90
// Size: 0x2c
function function_b7e11612()
{
    self waittill( #"death" );
    self zm_genesis_vo::function_f7879c72( self.attacker );
}

// Namespace zm_genesis_mechz
// Params 0
// Checksum 0xf4dca2d, Offset: 0x1bc8
// Size: 0x44
function function_b2a1b297()
{
    self waittill( #"actor_corpse", mechz );
    wait 60;
    
    if ( isdefined( mechz ) )
    {
        mechz delete();
    }
}

// Namespace zm_genesis_mechz
// Params 0
// Checksum 0x89ea333c, Offset: 0x1c18
// Size: 0x244
function function_2a26e636()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( self.zone_name ) )
        {
            wait 0.1;
            continue;
        }
        
        var_225b5e15 = 1;
        var_e01c8f74 = 1;
        players = getplayers();
        
        foreach ( player in players )
        {
            if ( isdefined( player.var_a393601c ) && ( isdefined( player.var_5aef0317 ) && player.var_5aef0317 || player.var_a393601c ) )
            {
                var_225b5e15 = 0;
                var_e01c8f74 = 0;
                break;
            }
            
            if ( isdefined( player.am_i_valid ) && player.am_i_valid )
            {
                if ( !isdefined( player.zone_name ) )
                {
                    var_225b5e15 = 0;
                    var_e01c8f74 = 0;
                    break;
                }
                
                if ( isdefined( player.zone_name ) )
                {
                    if ( player.zone_name == "apothicon_interior_zone" )
                    {
                        var_e01c8f74 = 0;
                        continue;
                    }
                    
                    var_225b5e15 = 0;
                }
            }
        }
        
        var_9626d5b6 = 0;
        
        if ( self.zone_name == "apothicon_interior_zone" )
        {
            var_9626d5b6 = 1;
        }
        
        if ( var_e01c8f74 && ( var_225b5e15 && !var_9626d5b6 || var_9626d5b6 ) )
        {
            break;
        }
        
        wait 0.5;
    }
    
    self thread function_17da3db2();
}

// Namespace zm_genesis_mechz
// Params 0
// Checksum 0x7b4efa08, Offset: 0x1e68
// Size: 0x54
function function_17da3db2()
{
    wait 0.05;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
    
    wait 1.1;
    level thread zm_genesis_round_bosses::spawn_boss( "mechz" );
}

// Namespace zm_genesis_mechz
// Params 0
// Checksum 0xdfd65fd3, Offset: 0x1ec8
// Size: 0x3c
function function_a2a11991()
{
    self endon( #"death" );
    
    while ( !isdefined( self.zombie_lift_override ) )
    {
        wait 0.05;
    }
    
    self.zombie_lift_override = &function_2d571578;
}

// Namespace zm_genesis_mechz
// Params 0
// Checksum 0x7668c947, Offset: 0x1f10
// Size: 0xc4
function function_2a2bfc25()
{
    self waittill( #"hash_46c1e51d" );
    
    if ( level flag::get( "zombie_drop_powerups" ) && !( isdefined( self.no_powerups ) && self.no_powerups ) )
    {
        a_bonus_types = array( "double_points", "insta_kill", "full_ammo", "nuke" );
        str_type = array::random( a_bonus_types );
        zm_powerups::specific_powerup_drop( str_type, self.origin );
    }
}

// Namespace zm_genesis_mechz
// Params 12
// Checksum 0x127817f3, Offset: 0x1fe0
// Size: 0x64
function function_f517cdd6( inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex )
{
    
}

// Namespace zm_genesis_mechz
// Params 5
// Checksum 0x55d305a2, Offset: 0x2050
// Size: 0xdc
function teleporttraversalmocompstart( entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration )
{
    entity.is_teleporting = 1;
    entity orientmode( "face angle", entity.angles[ 1 ] );
    entity animmode( "normal" );
    
    if ( isdefined( entity.traversestartnode ) )
    {
        portal_trig = entity.traversestartnode.portal_trig;
        portal_trig thread zm_genesis_portals::portal_teleport_ai( entity );
    }
}

// Namespace zm_genesis_mechz
// Params 6
// Checksum 0xf5b7b7a4, Offset: 0x2138
// Size: 0x2c8
function function_2d571578( e_player, v_attack_source, n_push_away, n_lift_height, v_lift_offset, n_lift_speed )
{
    self endon( #"death" );
    
    if ( isdefined( self.in_gravity_trap ) && self.in_gravity_trap && e_player.gravityspikes_state === 3 )
    {
        if ( isdefined( self.var_1f5fe943 ) && self.var_1f5fe943 )
        {
            return;
        }
        
        self.var_bcecff1d = 1;
        self.var_1f5fe943 = 1;
        self dodamage( 10, self.origin );
        self.var_ab0efcf6 = self.origin;
        self thread scene::play( "cin_zm_dlc1_mechz_dth_deathray_01", self );
        self clientfield::set( "sparky_beam_fx", 1 );
        self clientfield::set( "death_ray_shock_fx", 1 );
        self playsound( "zmb_talon_electrocute" );
        n_start_time = gettime();
        
        for ( n_total_time = 0; 10 > n_total_time && e_player.gravityspikes_state === 3 ; n_total_time = ( gettime() - n_start_time ) / 1000 )
        {
            util::wait_network_frame();
        }
        
        self scene::stop( "cin_zm_dlc1_mechz_dth_deathray_01" );
        self thread function_a0b6d6b9( self );
        self clientfield::set( "sparky_beam_fx", 0 );
        self clientfield::set( "death_ray_shock_fx", 0 );
        self.var_bcecff1d = undefined;
        
        while ( e_player.gravityspikes_state === 3 )
        {
            util::wait_network_frame();
        }
        
        self.var_1f5fe943 = undefined;
        self.in_gravity_trap = undefined;
        return;
    }
    
    self dodamage( 10, self.origin );
    
    if ( !( isdefined( self.stun ) && self.stun ) )
    {
        self.stun = 1;
    }
}

// Namespace zm_genesis_mechz
// Params 1
// Checksum 0xcdd8f98b, Offset: 0x2408
// Size: 0x1a4
function function_a0b6d6b9( mechz )
{
    mechz endon( #"death" );
    
    if ( isdefined( mechz ) )
    {
        mechz scene::play( "cin_zm_dlc1_mechz_dth_deathray_02", mechz );
    }
    
    if ( isdefined( mechz ) && isalive( mechz ) && isdefined( mechz.var_ab0efcf6 ) )
    {
        v_eye_pos = mechz gettagorigin( "tag_eye" );
        
        /#
            recordline( mechz.origin, v_eye_pos, ( 0, 255, 0 ), "<dev string:x28>", mechz );
        #/
        
        trace = bullettrace( v_eye_pos, mechz.origin, 0, mechz );
        
        if ( trace[ "position" ] !== mechz.origin )
        {
            point = getclosestpointonnavmesh( trace[ "position" ], 64, 30 );
            
            if ( !isdefined( point ) )
            {
                point = mechz.var_ab0efcf6;
            }
            
            mechz forceteleport( point );
        }
    }
}

// Namespace zm_genesis_mechz
// Params 2
// Checksum 0xbe06b1aa, Offset: 0x25b8
// Size: 0xa4
function function_5f2149bb( inflictor, attacker )
{
    var_3bb42832 = level.mechz_health;
    n_damage = var_3bb42832 * 0.25 / 0.2;
    self dodamage( n_damage, self getcentroid(), inflictor, attacker, undefined, "MOD_PROJECTILE_SPLASH", 0, getweapon( "none" ) );
}

// Namespace zm_genesis_mechz
// Params 0, eflags: 0x4
// Checksum 0xf9fd1480, Offset: 0x2668
// Size: 0x34, Type: bool
function private function_1df1ec14()
{
    if ( self zm_ai_mechz::function_58655f2a() )
    {
        self.stun = 1;
        return true;
    }
    
    return false;
}

// Namespace zm_genesis_mechz
// Params 0, eflags: 0x4
// Checksum 0x868b0e29, Offset: 0x26a8
// Size: 0xae
function private function_40ef38f8()
{
    traversal = self.traversal;
    speedboost = 0;
    
    if ( traversal.abslengthtoend > 200 )
    {
        speedboost = 48;
    }
    else if ( traversal.abslengthtoend > 120 )
    {
        speedboost = 24;
    }
    else if ( traversal.abslengthtoend > 80 || traversal.absheighttoend > 80 )
    {
        speedboost = 12;
    }
    
    return speedboost;
}

// Namespace zm_genesis_mechz
// Params 2
// Checksum 0xdcc4e48e, Offset: 0x2760
// Size: 0x46
function mechz_damage_override( attacker, damage )
{
    if ( isdefined( attacker.var_bbd3efb8 ) )
    {
        damage *= attacker.var_bbd3efb8;
    }
    
    return damage;
}

// Namespace zm_genesis_mechz
// Params 0, eflags: 0x4
// Checksum 0xebf31b1c, Offset: 0x27b0
// Size: 0x6c
function private function_1faf1646()
{
    self.candamage = 0;
    self.isfrozen = 1;
    self ghost();
    self notsolid();
    self pathmode( "dont move" );
}

// Namespace zm_genesis_mechz
// Params 0, eflags: 0x4
// Checksum 0x6950a9c0, Offset: 0x2828
// Size: 0x70
function private function_ee090a93()
{
    self.isfrozen = 0;
    self show();
    self solid();
    wait 0.5;
    self pathmode( "move allowed" );
    self.candamage = 1;
}

/#

    // Namespace zm_genesis_mechz
    // Params 0
    // Checksum 0xb373f219, Offset: 0x28a0
    // Size: 0xb8, Type: dev
    function function_78e44cda()
    {
        wait 0.05;
        level waittill( #"start_zombie_round_logic" );
        wait 0.05;
        setdvar( "<dev string:x2f>", 0 );
        adddebugcommand( "<dev string:x5c>" );
        
        while ( true )
        {
            if ( getdvarint( "<dev string:x2f>" ) )
            {
                setdvar( "<dev string:x2f>", 0 );
                level thread function_eac1444a();
            }
            
            wait 0.5;
        }
    }

    // Namespace zm_genesis_mechz
    // Params 0
    // Checksum 0x5da0bfa5, Offset: 0x2960
    // Size: 0x282, Type: dev
    function function_eac1444a()
    {
        var_10b176f0 = getaiarchetypearray( "<dev string:xbc>" );
        
        foreach ( ai_mechz in var_10b176f0 )
        {
            var_efe3c52f = level.activeplayers[ 0 ] gettagorigin( "<dev string:xc2>" ) + ( 0, 0, 20 );
            var_7ddc55f4 = level.activeplayers[ 0 ] gettagorigin( "<dev string:xc2>" ) + ( 5, 0, 20 );
            var_a3ded05d = level.activeplayers[ 0 ] gettagorigin( "<dev string:xc2>" ) + ( -5, 0, 20 );
            var_31d76122 = level.activeplayers[ 0 ] gettagorigin( "<dev string:xc2>" ) + ( 0, 0, 15 );
            magicbullet( level.var_e106fba5, var_efe3c52f, ai_mechz getcentroid(), level.activeplayers[ 0 ] );
            magicbullet( level.var_791ba87b, var_7ddc55f4, ai_mechz getcentroid(), level.activeplayers[ 0 ] );
            magicbullet( level.var_5d4538da, var_a3ded05d, ai_mechz getcentroid(), level.activeplayers[ 0 ] );
            magicbullet( level.var_30611368, var_31d76122, ai_mechz getcentroid(), level.activeplayers[ 0 ] );
        }
    }

    // Namespace zm_genesis_mechz
    // Params 3
    // Checksum 0xdad1de02, Offset: 0x2bf0
    // Size: 0x5c, Type: dev
    function function_22cf3e9f( str_weapon_name, v_source, ai_mechz )
    {
        magicbullet( level.var_791ba87b, v_source, ai_mechz getcentroid(), level.activeplayers[ 0 ] );
    }

#/
