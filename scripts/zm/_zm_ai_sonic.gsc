#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_thundergun;

#namespace zm_ai_sonic;

// Namespace zm_ai_sonic
// Params 0, eflags: 0x2
// Checksum 0x78099771, Offset: 0x6a8
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_ai_sonic", &__init__, &__main__, undefined );
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x3cfb12fc, Offset: 0x6f0
// Size: 0x44
function __init__()
{
    init_clientfields();
    _sonic_initfx();
    _sonic_initsounds();
    registerbehaviorscriptfunctions();
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x9d17e027, Offset: 0x740
// Size: 0x234
function __main__()
{
    level.soniczombiesenabled = 1;
    level.soniczombieminroundwait = 1;
    level.soniczombiemaxroundwait = 3;
    level.soniczombieroundrequirement = 4;
    level.nextsonicspawnround = level.soniczombieroundrequirement + randomintrange( 0, level.soniczombiemaxroundwait + 1 );
    level.sonicplayerdamage = 10;
    level.sonicscreamdamageradius = 300;
    level.sonicscreamattackradius = 240;
    level.sonicscreamattackdebouncemin = 3;
    level.sonicscreamattackdebouncemax = 9;
    level.sonicscreamattacknext = 0;
    level.sonichealthmultiplier = 2.5;
    level.sonic_zombie_spawners = getentarray( "sonic_zombie_spawner", "script_noteworthy" );
    zombie_utility::set_zombie_var( "thundergun_knockdown_damage", 15 );
    level.thundergun_gib_refs = [];
    level.thundergun_gib_refs[ level.thundergun_gib_refs.size ] = "guts";
    level.thundergun_gib_refs[ level.thundergun_gib_refs.size ] = "right_arm";
    level.thundergun_gib_refs[ level.thundergun_gib_refs.size ] = "left_arm";
    array::thread_all( level.sonic_zombie_spawners, &spawner::add_spawn_function, &sonic_zombie_spawn );
    array::thread_all( level.sonic_zombie_spawners, &spawner::add_spawn_function, &zombie_utility::round_spawn_failsafe );
    zm_spawner::register_zombie_damage_callback( &_sonic_damage_callback );
    level thread function_1249f13c();
    println( "<dev string:x28>" + level.nextsonicspawnround );
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x2f8a1de7, Offset: 0x980
// Size: 0xa4
function registerbehaviorscriptfunctions()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "sonicAttackInitialize", &sonicattackinitialize );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "sonicAttackTerminate", &sonicattackterminate );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "sonicCanAttack", &soniccanattack );
    animationstatenetwork::registernotetrackhandlerfunction( "sonic_fire", &function_cd107cf );
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0xacabaa2f, Offset: 0xa30
// Size: 0x34
function init_clientfields()
{
    clientfield::register( "actor", "issonic", 21000, 1, "int" );
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0xdb257ce4, Offset: 0xa70
// Size: 0x56
function _sonic_initfx()
{
    level._effect[ "sonic_explosion" ] = "dlc5/temple/fx_ztem_sonic_zombie";
    level._effect[ "sonic_spawn" ] = "dlc5/temple/fx_ztem_sonic_zombie_spawn";
    level._effect[ "sonic_attack" ] = "dlc5/temple/fx_ztem_sonic_zombie_attack";
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x2452bb0d, Offset: 0xad0
// Size: 0xa
function function_8b9e6756()
{
    return level.sonic_zombie_spawners;
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0xb4a667c9, Offset: 0xae8
// Size: 0x14
function function_1ebbce9b()
{
    return level.zm_loc_types[ "napalm_location" ];
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0xa336a26, Offset: 0xb08
// Size: 0x108
function function_1249f13c()
{
    level waittill( #"start_of_round" );
    
    while ( true )
    {
        if ( function_89ce0aca() )
        {
            spawner_list = function_8b9e6756();
            location_list = function_1ebbce9b();
            spawner = array::random( spawner_list );
            location = array::random( location_list );
            ai = zombie_utility::spawn_zombie( spawner, spawner.targetname, location );
            
            if ( isdefined( ai ) )
            {
                ai.spawn_point_override = location;
            }
        }
        
        wait 3;
    }
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x417ecae8, Offset: 0xc18
// Size: 0xfc
function function_56fe13df()
{
    self endon( #"death" );
    spot = self.spawn_point_override;
    self.spawn_point = spot;
    
    if ( isdefined( spot.target ) )
    {
        self.target = spot.target;
    }
    
    if ( isdefined( spot.zone_name ) )
    {
        self.zone_name = spot.zone_name;
    }
    
    if ( isdefined( spot.script_parameters ) )
    {
        self.script_parameters = spot.script_parameters;
    }
    
    self thread zm_spawner::do_zombie_rise( spot );
    playsoundatposition( "evt_sonic_spawn", self.origin );
    thread function_332b9adf();
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0xbd9e0475, Offset: 0xd20
// Size: 0x6c
function function_332b9adf()
{
    wait 3;
    players = getplayers();
    players[ randomintrange( 0, players.size ) ] thread zm_audio::create_and_play_dialog( "general", "sonic_spawn" );
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x18cd50ea, Offset: 0xd98
// Size: 0x160
function _sonic_initsounds()
{
    level.zmb_vox[ "sonic_zombie" ] = [];
    level.zmb_vox[ "sonic_zombie" ][ "ambient" ] = "sonic_ambient";
    level.zmb_vox[ "sonic_zombie" ][ "sprint" ] = "sonic_ambient";
    level.zmb_vox[ "sonic_zombie" ][ "attack" ] = "sonic_attack";
    level.zmb_vox[ "sonic_zombie" ][ "teardown" ] = "sonic_attack";
    level.zmb_vox[ "sonic_zombie" ][ "taunt" ] = "sonic_ambient";
    level.zmb_vox[ "sonic_zombie" ][ "behind" ] = "sonic_ambient";
    level.zmb_vox[ "sonic_zombie" ][ "death" ] = "sonic_explode";
    level.zmb_vox[ "sonic_zombie" ][ "crawler" ] = "sonic_ambient";
    level.zmb_vox[ "sonic_zombie" ][ "scream" ] = "sonic_scream";
}

// Namespace zm_ai_sonic
// Params 1
// Checksum 0xec98bf7a, Offset: 0xf00
// Size: 0x70, Type: bool
function _entity_in_zone( zone )
{
    for ( i = 0; i < zone.volumes.size ; i++ )
    {
        if ( self istouching( zone.volumes[ i ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0xc0909cf6, Offset: 0xf78
// Size: 0xd4, Type: bool
function function_89ce0aca()
{
    if ( !isdefined( level.soniczombiesenabled ) || level.soniczombiesenabled == 0 || level.sonic_zombie_spawners.size == 0 )
    {
        return false;
    }
    
    if ( isdefined( level.soniczombiecount ) && level.soniczombiecount > 0 )
    {
        return false;
    }
    
    /#
        if ( getdvarint( "<dev string:x44>" ) != 0 )
        {
            return true;
        }
    #/
    
    if ( level.nextsonicspawnround > level.round_number )
    {
        return false;
    }
    
    if ( level.var_57ecc1a3 >= level.round_number )
    {
        return false;
    }
    
    if ( level.zombie_total == 0 )
    {
        return false;
    }
    
    return level.zombie_total < level.zombiesleftbeforesonicspawn;
}

// Namespace zm_ai_sonic
// Params 1
// Checksum 0xf6f06fe5, Offset: 0x1058
// Size: 0x25c
function sonic_zombie_spawn( animname_set )
{
    self.custom_location = &function_56fe13df;
    zm_spawner::zombie_spawn_init( animname_set );
    level.var_57ecc1a3 = level.round_number;
    
    /#
        println( "<dev string:x5b>" );
        setdvar( "<dev string:x44>", 0 );
    #/
    
    self.animname = "sonic_zombie";
    self clientfield::set( "issonic", 1 );
    self.maxhealth = int( self.maxhealth * level.sonichealthmultiplier );
    self.health = self.maxhealth;
    self.ignore_enemy_count = 1;
    self.sonicscreamattackdebouncemin = 6;
    self.sonicscreamattackdebouncemax = 10;
    self.death_knockdown_range = 480;
    self.death_gib_range = 360;
    self.death_fling_range = 240;
    self.death_scream_range = 480;
    self _updatenextscreamtime();
    self.deathfunction = &sonic_zombie_death;
    self._zombie_shrink_callback = &_sonic_shrink;
    self._zombie_unshrink_callback = &_sonic_unshrink;
    self.monkey_bolt_taunts = &sonic_monkey_bolt_taunts;
    self thread _zombie_runeffects();
    self thread _zombie_initsidestep();
    self thread _zombie_death_watch();
    self thread sonic_zombie_count_watch();
    self.zombie_move_speed = "walk";
    self.zombie_arms_position = "up";
    self.variant_type = randomint( 3 );
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x290400b6, Offset: 0x12c0
// Size: 0x10
function _zombie_initsidestep()
{
    self.zombie_can_sidestep = 1;
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x77d859dc, Offset: 0x12d8
// Size: 0x2c
function _zombie_death_watch()
{
    self waittill( #"death" );
    self clientfield::set( "issonic", 0 );
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0xb2c73337, Offset: 0x1310
// Size: 0x1a
function _zombie_ambient_sounds()
{
    self endon( #"death" );
    
    while ( true )
    {
    }
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x1b1319cd, Offset: 0x1338
// Size: 0x4c
function _updatenextscreamtime()
{
    self.sonicscreamattacknext = gettime();
    self.sonicscreamattacknext += randomintrange( self.sonicscreamattackdebouncemin * 1000, self.sonicscreamattackdebouncemax * 1000 );
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x9468199b, Offset: 0x1390
// Size: 0x1c, Type: bool
function _canscreamnow()
{
    if ( gettime() > self.sonicscreamattacknext )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_ai_sonic
// Params 1, eflags: 0x4
// Checksum 0xdae38123, Offset: 0x13b8
// Size: 0x190, Type: bool
function private soniccanattack( entity )
{
    if ( entity.animname !== "sonic_zombie" )
    {
        return false;
    }
    
    if ( !isdefined( entity.favoriteenemy ) || !isplayer( entity.favoriteenemy ) )
    {
        return false;
    }
    
    hashead = !( isdefined( entity.head_gibbed ) && entity.head_gibbed );
    notmini = !( isdefined( entity.shrinked ) && entity.shrinked );
    screamtime = level _canscreamnow() && entity _canscreamnow();
    
    if ( screamtime && !entity.ignoreall && !( isdefined( entity.is_traversing ) && entity.is_traversing ) && hashead && notmini )
    {
        blurplayers = entity _zombie_any_players_in_blur_area();
        
        if ( blurplayers )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_ai_sonic
// Params 2, eflags: 0x4
// Checksum 0x4864a892, Offset: 0x1550
// Size: 0x44
function private sonicattackinitialize( entity, asmstatename )
{
    level _updatenextscreamtime();
    entity _updatenextscreamtime();
}

// Namespace zm_ai_sonic
// Params 1, eflags: 0x4
// Checksum 0x2a15cf98, Offset: 0x15a0
// Size: 0x44
function private function_cd107cf( entity )
{
    if ( entity.animname !== "sonic_zombie" )
    {
        return;
    }
    
    entity _zombie_screamattack();
}

// Namespace zm_ai_sonic
// Params 2, eflags: 0x4
// Checksum 0x5dbcc21, Offset: 0x15f0
// Size: 0x2c
function private sonicattackterminate( entity, asmstatename )
{
    entity _zombie_scream_attack_done();
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x8e38ee17, Offset: 0x1628
// Size: 0x7c
function _zombie_screamattack()
{
    self playsound( "zmb_vocals_sonic_scream" );
    self thread _zombie_playscreamfx();
    players = getplayers();
    array::thread_all( players, &_player_screamattackwatch, self );
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0xb62e5555, Offset: 0x16b0
// Size: 0x6e
function _zombie_scream_attack_done()
{
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] notify( #"scream_watch_done" );
    }
    
    self notify( #"scream_attack_done" );
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0xa2f84c6e, Offset: 0x1728
// Size: 0x174
function _zombie_playscreamfx()
{
    if ( isdefined( self.screamfx ) )
    {
        self.screamfx delete();
    }
    
    tag = "tag_eye";
    origin = self gettagorigin( tag );
    self.screamfx = spawn( "script_model", origin );
    self.screamfx setmodel( "tag_origin" );
    self.screamfx.angles = self gettagangles( tag );
    self.screamfx linkto( self, tag );
    playfxontag( level._effect[ "sonic_attack" ], self.screamfx, "tag_origin" );
    self util::waittill_any( "death", "scream_attack_done", "shrink" );
    self.screamfx delete();
}

// Namespace zm_ai_sonic
// Params 1
// Checksum 0x5c0281ef, Offset: 0x18a8
// Size: 0xb4
function _player_screamattackwatch( sonic_zombie )
{
    self endon( #"death" );
    self endon( #"scream_watch_done" );
    sonic_zombie endon( #"death" );
    self.screamattackblur = 0;
    
    while ( true )
    {
        if ( self _player_in_blur_area( sonic_zombie ) )
        {
            break;
        }
        
        wait 0.1;
    }
    
    self thread _player_sonicblurvision( sonic_zombie );
    self thread zm_audio::create_and_play_dialog( "general", "sonic_hit" );
}

// Namespace zm_ai_sonic
// Params 1
// Checksum 0x1ff92c28, Offset: 0x1968
// Size: 0x148, Type: bool
function _player_in_blur_area( sonic_zombie )
{
    if ( abs( self.origin[ 2 ] - sonic_zombie.origin[ 2 ] ) > 70 )
    {
        return false;
    }
    
    radiussqr = level.sonicscreamdamageradius * level.sonicscreamdamageradius;
    
    if ( distance2dsquared( self.origin, sonic_zombie.origin ) > radiussqr )
    {
        return false;
    }
    
    dirtoplayer = self.origin - sonic_zombie.origin;
    dirtoplayer = vectornormalize( dirtoplayer );
    sonicdir = anglestoforward( sonic_zombie.angles );
    dot = vectordot( dirtoplayer, sonicdir );
    
    if ( dot < 0.4 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0xece3b7f9, Offset: 0x1ab8
// Size: 0xb0, Type: bool
function _zombie_any_players_in_blur_area()
{
    if ( isdefined( level.intermission ) && level.intermission )
    {
        return false;
    }
    
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( zombie_utility::is_player_valid( player ) && player _player_in_blur_area( self ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_ai_sonic
// Params 1
// Checksum 0xa371e3d3, Offset: 0x1b70
// Size: 0xf8
function _player_sonicblurvision( zombie )
{
    self endon( #"disconnect" );
    level endon( #"intermission" );
    
    if ( !self.screamattackblur )
    {
        mini = isdefined( zombie.shrinked ) && isdefined( zombie ) && zombie.shrinked;
        self.screamattackblur = 1;
        
        if ( mini )
        {
            self _player_screamattackdamage( 1, 2, 0.2, "damage_light", zombie );
        }
        else
        {
            self _player_screamattackdamage( 4, 5, 0.2, "damage_heavy", zombie );
        }
        
        self.screamattackblur = 0;
    }
}

// Namespace zm_ai_sonic
// Params 5
// Checksum 0x9e49146f, Offset: 0x1c70
// Size: 0x10c
function _player_screamattackdamage( time, blurscale, earthquakescale, rumble, attacker )
{
    self thread _player_blurfailsafe();
    earthquake( earthquakescale, 3, attacker.origin, level.sonicscreamdamageradius, self );
    visionset_mgr::activate( "overlay", "zm_ai_screecher_blur", self );
    self playrumbleonentity( rumble );
    self _player_screamattack_wait( time );
    visionset_mgr::deactivate( "overlay", "zm_ai_screecher_blur", self );
    self notify( #"blur_cleared" );
    self stoprumble( rumble );
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x844824af, Offset: 0x1d88
// Size: 0x4c
function _player_blurfailsafe()
{
    self endon( #"disconnect" );
    self endon( #"blur_cleared" );
    level waittill( #"intermission" );
    visionset_mgr::deactivate( "overlay", "zm_ai_screecher_blur", self );
}

// Namespace zm_ai_sonic
// Params 1
// Checksum 0xcc1da95e, Offset: 0x1de0
// Size: 0x28
function _player_screamattack_wait( time )
{
    self endon( #"disconnect" );
    level endon( #"intermission" );
    wait time;
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x99ec1590, Offset: 0x1e10
// Size: 0x4
function _player_soniczombiedeath_doublevision()
{
    
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x99ec1590, Offset: 0x1e20
// Size: 0x4
function _zombie_runeffects()
{
    
}

// Namespace zm_ai_sonic
// Params 2
// Checksum 0x96ddda01, Offset: 0x1e30
// Size: 0xf0
function _zombie_setupfxonjoint( jointname, fxname )
{
    origin = self gettagorigin( jointname );
    effectent = spawn( "script_model", origin );
    effectent setmodel( "tag_origin" );
    effectent.angles = self gettagangles( jointname );
    effectent linkto( self, jointname );
    playfxontag( level._effect[ fxname ], effectent, "tag_origin" );
    return effectent;
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0xca1ea914, Offset: 0x1f28
// Size: 0x12e
function _zombie_getnearbyplayers()
{
    nearbyplayers = [];
    radiussqr = level.sonicscreamattackradius * level.sonicscreamattackradius;
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( !zombie_utility::is_player_valid( players[ i ] ) )
        {
            continue;
        }
        
        playerorigin = players[ i ].origin;
        
        if ( abs( playerorigin[ 2 ] - self.origin[ 2 ] ) > 70 )
        {
            continue;
        }
        
        if ( distance2dsquared( playerorigin, self.origin ) > radiussqr )
        {
            continue;
        }
        
        nearbyplayers[ nearbyplayers.size ] = players[ i ];
    }
    
    return nearbyplayers;
}

// Namespace zm_ai_sonic
// Params 8
// Checksum 0x60198ac8, Offset: 0x2060
// Size: 0x142
function sonic_zombie_death( einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime )
{
    self playsound( "evt_sonic_explode" );
    
    if ( isdefined( level._effect[ "sonic_explosion" ] ) )
    {
        playfxontag( level._effect[ "sonic_explosion" ], self, "J_SpineLower" );
    }
    
    if ( isdefined( self.attacker ) && isplayer( self.attacker ) )
    {
        self.attacker thread zm_audio::create_and_play_dialog( "kill", "sonic" );
    }
    
    self thread _sonic_zombie_death_scream( self.attacker );
    _sonic_zombie_death_explode( self.attacker );
    return self zm_spawner::zombie_death_animscript();
}

// Namespace zm_ai_sonic
// Params 1
// Checksum 0x7b976cbd, Offset: 0x21b0
// Size: 0xd4
function zombie_sonic_scream_death( attacker )
{
    self endon( #"death" );
    randomwait = randomfloatrange( 0, 1 );
    wait randomwait;
    self.no_powerups = 1;
    self zombie_utility::zombie_eye_glow_stop();
    self playsound( "evt_zombies_head_explode" );
    self zombie_utility::zombie_head_gib();
    self dodamage( self.health + 666, self.origin, attacker );
}

// Namespace zm_ai_sonic
// Params 1
// Checksum 0xad3569af, Offset: 0x2290
// Size: 0xc6
function _sonic_zombie_death_scream( attacker )
{
    zombies = _sonic_zombie_get_enemies_in_scream_range();
    
    for ( i = 0; i < zombies.size ; i++ )
    {
        if ( !isdefined( zombies[ i ] ) )
        {
            continue;
        }
        
        if ( zm_utility::is_magic_bullet_shield_enabled( zombies[ i ] ) )
        {
            continue;
        }
        
        if ( self.animname == "monkey_zombie" )
        {
            continue;
        }
        
        zombies[ i ] thread zombie_sonic_scream_death( attacker );
    }
}

// Namespace zm_ai_sonic
// Params 1
// Checksum 0xcdaccf05, Offset: 0x2360
// Size: 0x174
function _sonic_zombie_death_explode( attacker )
{
    physicsexplosioncylinder( self.origin, 600, 240, 1 );
    
    if ( !isdefined( level.soniczombie_knockdown_enemies ) )
    {
        level.soniczombie_knockdown_enemies = [];
        level.soniczombie_knockdown_gib = [];
        level.soniczombie_fling_enemies = [];
        level.soniczombie_fling_vecs = [];
    }
    
    self _sonic_zombie_get_enemies_in_range();
    level.sonic_zombie_network_choke_count = 0;
    
    for ( i = 0; i < level.soniczombie_fling_enemies.size ; i++ )
    {
        level.soniczombie_fling_enemies[ i ] thread _soniczombie_fling_zombie( attacker, level.soniczombie_fling_vecs[ i ], i );
    }
    
    for ( i = 0; i < level.soniczombie_knockdown_enemies.size ; i++ )
    {
        level.soniczombie_knockdown_enemies[ i ] thread _soniczombie_knockdown_zombie( attacker, level.soniczombie_knockdown_gib[ i ] );
    }
    
    level.soniczombie_knockdown_enemies = [];
    level.soniczombie_knockdown_gib = [];
    level.soniczombie_fling_enemies = [];
    level.soniczombie_fling_vecs = [];
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x287c7b38, Offset: 0x24e0
// Size: 0x4c
function _sonic_zombie_network_choke()
{
    level.sonic_zombie_network_choke_count++;
    
    if ( !( level.sonic_zombie_network_choke_count % 10 ) )
    {
        util::wait_network_frame();
        util::wait_network_frame();
        util::wait_network_frame();
    }
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0xe17bf652, Offset: 0x2538
// Size: 0x158
function _sonic_zombie_get_enemies_in_scream_range()
{
    return_zombies = [];
    center = self getcentroid();
    zombies = array::get_all_closest( center, getaispeciesarray( "axis", "all" ), undefined, undefined, self.death_scream_range );
    
    if ( isdefined( zombies ) )
    {
        for ( i = 0; i < zombies.size ; i++ )
        {
            if ( !isdefined( zombies[ i ] ) || !isalive( zombies[ i ] ) )
            {
                continue;
            }
            
            test_origin = zombies[ i ] getcentroid();
            
            if ( !bullettracepassed( center, test_origin, 0, undefined ) )
            {
                continue;
            }
            
            return_zombies[ return_zombies.size ] = zombies[ i ];
        }
    }
    
    return return_zombies;
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x4b05b43e, Offset: 0x2698
// Size: 0x31c
function _sonic_zombie_get_enemies_in_range()
{
    center = self getcentroid();
    zombies = array::get_all_closest( center, getaispeciesarray( "axis", "all" ), undefined, undefined, self.death_knockdown_range );
    
    if ( !isdefined( zombies ) )
    {
        return;
    }
    
    knockdown_range_squared = self.death_knockdown_range * self.death_knockdown_range;
    gib_range_squared = self.death_gib_range * self.death_gib_range;
    fling_range_squared = self.death_fling_range * self.death_fling_range;
    
    for ( i = 0; i < zombies.size ; i++ )
    {
        if ( !isdefined( zombies[ i ] ) || !isalive( zombies[ i ] ) )
        {
            continue;
        }
        
        test_origin = zombies[ i ] getcentroid();
        test_range_squared = distancesquared( center, test_origin );
        
        if ( test_range_squared > knockdown_range_squared )
        {
            return;
        }
        
        if ( !bullettracepassed( center, test_origin, 0, undefined ) )
        {
            continue;
        }
        
        if ( test_range_squared < fling_range_squared )
        {
            level.soniczombie_fling_enemies[ level.soniczombie_fling_enemies.size ] = zombies[ i ];
            dist_mult = ( fling_range_squared - test_range_squared ) / fling_range_squared;
            fling_vec = vectornormalize( test_origin - center );
            fling_vec = ( fling_vec[ 0 ], fling_vec[ 1 ], abs( fling_vec[ 2 ] ) );
            fling_vec = vectorscale( fling_vec, 100 + 100 * dist_mult );
            level.soniczombie_fling_vecs[ level.soniczombie_fling_vecs.size ] = fling_vec;
            continue;
        }
        
        if ( test_range_squared < gib_range_squared )
        {
            level.soniczombie_knockdown_enemies[ level.soniczombie_knockdown_enemies.size ] = zombies[ i ];
            level.soniczombie_knockdown_gib[ level.soniczombie_knockdown_gib.size ] = 1;
            continue;
        }
        
        level.soniczombie_knockdown_enemies[ level.soniczombie_knockdown_enemies.size ] = zombies[ i ];
        level.soniczombie_knockdown_gib[ level.soniczombie_knockdown_gib.size ] = 0;
    }
}

// Namespace zm_ai_sonic
// Params 3
// Checksum 0xbfd33633, Offset: 0x29c0
// Size: 0x11c
function _soniczombie_fling_zombie( player, fling_vec, index )
{
    if ( !isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
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
        self startragdoll();
        self launchragdoll( fling_vec );
    }
}

// Namespace zm_ai_sonic
// Params 2
// Checksum 0x2be2f860, Offset: 0x2ae8
// Size: 0x104
function _soniczombie_knockdown_zombie( player, gib )
{
    self endon( #"death" );
    
    if ( !isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( isdefined( self.thundergun_knockdown_func ) )
    {
        self.lander_knockdown = 1;
        self [[ self.thundergun_knockdown_func ]]( player, gib );
        return;
    }
    
    if ( gib )
    {
        self.a.gib_ref = array::random( level.thundergun_gib_refs );
        self thread zombie_death::do_gib();
    }
    
    self.thundergun_handle_pain_notetracks = &zm_weap_thundergun::handle_thundergun_pain_notetracks;
    self dodamage( 20, player.origin, player );
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x99ec1590, Offset: 0x2bf8
// Size: 0x4
function _sonic_shrink()
{
    
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x99ec1590, Offset: 0x2c08
// Size: 0x4
function _sonic_unshrink()
{
    
}

// Namespace zm_ai_sonic
// Params 0
// Checksum 0x9fe60b79, Offset: 0x2c18
// Size: 0x130
function sonic_zombie_count_watch()
{
    if ( !isdefined( level.soniczombiecount ) )
    {
        level.soniczombiecount = 0;
    }
    
    level.soniczombiecount++;
    self waittill( #"death" );
    level.soniczombiecount--;
    
    if ( isdefined( self.shrinked ) && self.shrinked )
    {
        level.nextsonicspawnround = level.round_number + 1;
    }
    else
    {
        level.nextsonicspawnround = level.round_number + randomintrange( level.soniczombieminroundwait, level.soniczombiemaxroundwait + 1 );
    }
    
    println( "<dev string:x28>" + level.nextsonicspawnround );
    attacker = self.attacker;
    
    if ( isdefined( attacker.screamattackblur ) && isdefined( attacker ) && isplayer( attacker ) && attacker.screamattackblur )
    {
        attacker notify( #"blinded_by_the_fright_achieved" );
    }
}

// Namespace zm_ai_sonic
// Params 13
// Checksum 0x75688dfb, Offset: 0x2d50
// Size: 0x14c, Type: bool
function _sonic_damage_callback( str_mod, str_hit_location, v_hit_origin, e_player, n_amount, w_weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel )
{
    if ( isdefined( self.lander_knockdown ) && self.lander_knockdown )
    {
        return false;
    }
    
    if ( self.classname == "actor_spawner_zm_temple_sonic" )
    {
        if ( !isdefined( self.damagecount ) )
        {
            self.damagecount = 0;
        }
        
        if ( self.damagecount % int( getplayers().size * level.sonichealthmultiplier ) == 0 )
        {
            e_player zm_score::player_add_points( "thundergun_fling", 10, str_hit_location, self.isdog );
        }
        
        self.damagecount++;
        self thread zm_powerups::check_for_instakill( e_player, str_mod, str_hit_location );
        return true;
    }
    
    return false;
}

// Namespace zm_ai_sonic
// Params 1
// Checksum 0xc7b4810a, Offset: 0x2ea8
// Size: 0x1e, Type: bool
function sonic_monkey_bolt_taunts( monkey_bolt )
{
    return isdefined( self.in_the_ground ) && self.in_the_ground;
}

