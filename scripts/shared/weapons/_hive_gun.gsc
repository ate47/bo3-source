#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/killcam_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace hive_gun;

// Namespace hive_gun
// Params 0
// Checksum 0x433c8a4f, Offset: 0x600
// Size: 0x2a4
function init_shared()
{
    level.firefly_pod_weapon = getweapon( "hero_chemicalgelgun" );
    level.firefly_pod_secondary_explosion_weapon = getweapon( "hive_gungun_secondary_explosion" );
    level.firefly_debug = getdvarint( "scr_firefly_debug", 0 );
    level.firefly_pod_detection_radius = getdvarint( "scr_fireflyPodDetectionRadius", 150 );
    level.firefly_pod_grace_period = getdvarfloat( "scr_fireflyPodGracePeriod", 0 );
    level.firefly_pod_activation_time = getdvarfloat( "scr_fireflyPodActivationTime", 1 );
    level.firefly_pod_partial_move_percent = getdvarfloat( "scr_fireflyPartialMovePercent", 0.8 );
    
    if ( !isdefined( level.vsmgr_prio_overlay_gel_splat ) )
    {
        level.vsmgr_prio_overlay_gel_splat = 21;
    }
    
    level.fireflies_spawn_height = getdvarint( "betty_jump_height_onground", 55 );
    level.fireflies_spawn_height_wall = getdvarint( "betty_jump_height_wall", 20 );
    level.fireflies_spawn_height_wall_angle = getdvarint( "betty_onground_angle_threshold", 30 );
    level.fireflies_spawn_height_wall_angle_cos = cos( level.fireflies_spawn_height_wall_angle );
    level.fireflies_emit_time = getdvarfloat( "scr_firefly_emit_time", 0.2 );
    level.fireflies_min_speed = getdvarint( "scr_firefly_min_speed", 400 );
    level.fireflies_attack_speed_scale = getdvarfloat( "scr_firefly_attack_attack_speed_scale", 1.75 );
    level.fireflies_collision_check_interval = getdvarfloat( "scr_firefly_collision_check_interval", 0.2 );
    callback::add_weapon_damage( level.firefly_pod_weapon, &on_damage_firefly_pod );
    level thread register();
    
    /#
        level thread update_dvars();
    #/
}

/#

    // Namespace hive_gun
    // Params 0
    // Checksum 0xb3962c5a, Offset: 0x8b0
    // Size: 0x88, Type: dev
    function update_dvars()
    {
        while ( true )
        {
            wait 1;
            level.fireflies_min_speed = getdvarint( "<dev string:x28>", 250 );
            level.fireflies_attack_speed_scale = getdvarfloat( "<dev string:x3a>", 1.15 );
            level.firefly_debug = getdvarint( "<dev string:x60>", 0 );
        }
    }

#/

// Namespace hive_gun
// Params 0
// Checksum 0x9355c1f7, Offset: 0x940
// Size: 0x94
function register()
{
    clientfield::register( "scriptmover", "firefly_state", 1, 3, "int" );
    clientfield::register( "toplayer", "fireflies_attacking", 1, 1, "int" );
    clientfield::register( "toplayer", "fireflies_chasing", 1, 1, "int" );
}

// Namespace hive_gun
// Params 0
// Checksum 0x54dab11b, Offset: 0x9e0
// Size: 0x1f0
function createfireflypodwatcher()
{
    watcher = self weaponobjects::createproximityweaponobjectwatcher( "hero_chemicalgelgun", self.team );
    watcher.onspawn = &on_spawn_firefly_pod;
    watcher.watchforfire = 1;
    watcher.hackable = 0;
    watcher.headicon = 0;
    watcher.activatefx = 1;
    watcher.ownergetsassist = 1;
    watcher.ignoredirection = 1;
    watcher.immediatedetonation = 1;
    watcher.detectiongraceperiod = level.firefly_pod_grace_period;
    watcher.detonateradius = level.firefly_pod_detection_radius;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 0;
    watcher.ondetonatecallback = &firefly_pod_detonate;
    watcher.activationdelay = level.firefly_pod_activation_time;
    watcher.activatesound = "wpn_gelgun_blob_burst";
    watcher.shoulddamage = &firefly_pod_should_damage;
    watcher.deleteonplayerspawn = 1;
    watcher.timeout = getdvarfloat( "scr_firefly_pod_timeout", 0 );
    watcher.ignorevehicles = 0;
    watcher.ignoreai = 0;
    watcher.onsupplementaldetonatecallback = &firefly_death;
}

// Namespace hive_gun
// Params 2
// Checksum 0x1c6e6f67, Offset: 0xbd8
// Size: 0xa4
function on_spawn_firefly_pod( watcher, owner )
{
    weaponobjects::onspawnproximityweaponobject( watcher, owner );
    self playloopsound( "wpn_gelgun_blob_alert_lp", 1 );
    self endon( #"death" );
    self waittill( #"stationary" );
    self setmodel( "wpn_t7_hero_chemgun_residue3_grn" );
    self setenemymodel( "wpn_t7_hero_chemgun_residue3_org" );
}

// Namespace hive_gun
// Params 0
// Checksum 0xb4001b6, Offset: 0xc88
// Size: 0x34
function start_damage_effects()
{
    /#
        if ( isgodmode( self ) )
        {
            return;
        }
    #/
    
    self thread end_damage_effects();
}

// Namespace hive_gun
// Params 0
// Checksum 0xcfd5eb45, Offset: 0xcc8
// Size: 0x1c
function end_damage_effects()
{
    self endon( #"disconnect" );
    self waittill( #"death" );
}

// Namespace hive_gun
// Params 5
// Checksum 0x9889e0cb, Offset: 0xcf0
// Size: 0x4e
function on_damage_firefly_pod( eattacker, einflictor, weapon, meansofdeath, damage )
{
    if ( "MOD_GRENADE" != meansofdeath && "MOD_GRENADE_SPLASH" != meansofdeath )
    {
        return;
    }
}

// Namespace hive_gun
// Params 0
// Checksum 0xe28aaa6, Offset: 0xd48
// Size: 0x21c
function spawn_firefly_mover()
{
    firefly_mover = spawn( "script_model", self.origin );
    firefly_mover.angles = self.angles;
    firefly_mover setmodel( "tag_origin" );
    firefly_mover.owner = self.owner;
    firefly_mover.killcamoffset = ( 0, 0, getdvarfloat( "scr_fireflies_start_height", 8 ) );
    firefly_mover.weapon = getweapon( "hero_firefly_swarm" );
    firefly_mover.takedamage = 1;
    firefly_mover.soundmod = "firefly";
    firefly_mover.team = self.team;
    killcament = spawn( "script_model", firefly_mover.origin + firefly_mover.killcamoffset );
    killcament.angles = ( 0, 0, 0 );
    killcament setmodel( "tag_origin" );
    killcament setweapon( firefly_mover.weapon );
    killcament killcam::store_killcam_entity_on_entity( self );
    firefly_mover.killcament = killcament;
    self.firefly_mover = firefly_mover;
    firefly_mover.debug_time = 1;
    firefly_mover thread firefly_mover_damage();
    weaponobjects::add_supplemental_object( firefly_mover );
}

// Namespace hive_gun
// Params 0
// Checksum 0x39898357, Offset: 0xf70
// Size: 0xa8
function firefly_mover_damage()
{
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags );
        self thread firefly_death();
    }
}

// Namespace hive_gun
// Params 0
// Checksum 0x62c835e5, Offset: 0x1020
// Size: 0x5c
function kill_firefly_mover()
{
    if ( isdefined( self.firefly_mover ) )
    {
        if ( isdefined( self.firefly_mover.killcament ) )
        {
            self.firefly_mover.killcament delete();
        }
        
        self.firefly_mover delete();
    }
}

// Namespace hive_gun
// Params 3
// Checksum 0xc75d01b8, Offset: 0x1088
// Size: 0x184
function firefly_pod_detonate( attacker, weapon, target )
{
    if ( !isdefined( target ) || !isdefined( target.team ) || !isdefined( self.team ) || self.team == target.team )
    {
        if ( isdefined( weapon ) && weapon.isvalid )
        {
            if ( isdefined( attacker ) )
            {
                if ( self.owner util::isenemyplayer( attacker ) )
                {
                    attacker challenges::destroyedexplosive( weapon );
                    scoreevents::processscoreevent( "destroyed_fireflyhive", attacker, self.owner, weapon );
                }
            }
        }
        
        self firefly_pod_destroyed();
        return;
    }
    
    self spawn_firefly_mover();
    self.firefly_mover thread firefly_watch_for_target_death( target );
    self.firefly_mover thread firefly_watch_for_game_ended( target );
    self thread firefly_pod_release_fireflies( attacker, target );
}

// Namespace hive_gun
// Params 0
// Checksum 0xc14e9337, Offset: 0x1218
// Size: 0xbc
function firefly_pod_destroyed()
{
    fx_ent = playfx( "weapon/fx_hero_chem_gun_blob_death", self.origin );
    fx_ent.team = self.team;
    playsoundatposition( "wpn_gelgun_blob_destroy", self.origin );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    self kill_firefly_mover();
    self delete();
}

// Namespace hive_gun
// Params 2
// Checksum 0xc54307b, Offset: 0x12e0
// Size: 0x84
function firefly_killcam_move( position, time )
{
    if ( !isdefined( self.killcament ) )
    {
        return;
    }
    
    self endon( #"death" );
    wait 0.5;
    accel = 0;
    decel = 0;
    self.killcament moveto( position, time, accel, decel );
}

// Namespace hive_gun
// Params 0
// Checksum 0xaa80568e, Offset: 0x1370
// Size: 0x54
function firefly_killcam_stop()
{
    self notify( #"stop_killcam" );
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament moveto( self.killcament.origin, 0.1, 0, 0 );
    }
}

// Namespace hive_gun
// Params 2
// Checksum 0x5f80c162, Offset: 0x13d0
// Size: 0x90
function firefly_move( position, time )
{
    self endon( #"death" );
    accel = 0;
    decel = 0;
    self thread firefly_killcam_move( position, time );
    self moveto( position, time, accel, decel );
    self waittill( #"movedone" );
}

// Namespace hive_gun
// Params 4
// Checksum 0x8f4acd32, Offset: 0x1468
// Size: 0xd6
function firefly_partial_move( target, position, time, percent )
{
    self endon( #"death" );
    self endon( #"stop_killcam" );
    accel = 0;
    decel = 0;
    self thread firefly_killcam_move( position, time );
    self moveto( position, time, accel, decel );
    self thread firefly_check_for_collisions( target, position, time );
    wait time * percent;
    self notify( #"movedone" );
}

// Namespace hive_gun
// Params 2
// Checksum 0x6a159a27, Offset: 0x1548
// Size: 0x48
function firefly_rotate( angles, time )
{
    self endon( #"death" );
    self rotateto( angles, time, 0, 0 );
    self waittill( #"rotatedone" );
}

// Namespace hive_gun
// Params 3
// Checksum 0xf8989617, Offset: 0x1598
// Size: 0x148
function firefly_check_for_collisions( target, move_to, time )
{
    self endon( #"death" );
    self endon( #"movedone" );
    original_position = self.origin;
    dir = vectornormalize( move_to - self.origin );
    dist = distance( self.origin, move_to );
    speed = dist / time;
    delta = dir * speed * level.fireflies_collision_check_interval;
    
    while ( true )
    {
        if ( !firefly_check_move( self.origin + delta, target ) )
        {
            self thread firefly_death();
            self playsound( "wpn_gelgun_hive_wall_impact" );
        }
        
        wait level.fireflies_collision_check_interval;
    }
}

// Namespace hive_gun
// Params 3
// Checksum 0x7681b6ce, Offset: 0x16e8
// Size: 0x88
function firefly_pod_rotated_point( degrees, radius, height )
{
    angles = ( 0, degrees, 0 );
    forward = ( radius, 0, 0 );
    point = rotatepoint( forward, angles );
    return self.spawn_origin + point + ( 0, 0, height );
}

// Namespace hive_gun
// Params 0
// Checksum 0x47639ef1, Offset: 0x1778
// Size: 0x6a
function firefly_pod_random_point()
{
    return firefly_pod_rotated_point( randomint( 359 ), randomint( level.fireflies_radius ), randomintrange( level.fireflies_height_variance * -1, level.fireflies_height_variance ) );
}

// Namespace hive_gun
// Params 0
// Checksum 0x5faf359a, Offset: 0x17f0
// Size: 0x130
function firefly_pod_random_movement()
{
    self endon( #"death" );
    self endon( #"attacking" );
    
    while ( true )
    {
        point = firefly_pod_random_point();
        delta = point - self.origin;
        angles = vectortoangles( delta );
        firefly_rotate( angles, 0.15 );
        dist = length( delta );
        time = 0.01;
        
        if ( dist > 0 )
        {
            time = dist / level.fireflies_min_speed;
        }
        
        firefly_move( point, time );
        wait randomfloatrange( 0.1, 0.7 );
    }
}

// Namespace hive_gun
// Params 3
// Checksum 0x1f04058e, Offset: 0x1928
// Size: 0x1b4
function firefly_spyrograph_patrol( degrees, increment, radius )
{
    self endon( #"death" );
    self endon( #"attacking" );
    current_degrees = randomint( int( 360 / degrees ) ) * degrees;
    height_offset = 0;
    
    while ( true )
    {
        point = firefly_pod_rotated_point( current_degrees, radius, height_offset );
        delta = point - self.origin;
        angles = ( 0, current_degrees, 0 );
        thread firefly_rotate( angles, 0.15 );
        dist = length( delta );
        time = 0.01;
        
        if ( dist > 0 )
        {
            time = dist / level.fireflies_min_speed;
        }
        
        firefly_move( point, time );
        wait randomfloatrange( 0.1, 0.3 );
        current_degrees = ( current_degrees + degrees * increment ) % 360;
    }
}

// Namespace hive_gun
// Params 1
// Checksum 0x1a8e06c9, Offset: 0x1ae8
// Size: 0x2c8
function firefly_damage_target( target )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    target endon( #"disconnect" );
    target endon( #"death" );
    target endon( #"entering_last_stand" );
    damage = 25;
    damage_delay = 0.1;
    weapon = self.weapon;
    target playsound( "wpn_gelgun_hive_attack" );
    target notify( #"snd_burn_scream" );
    remaining_hits = 10;
    
    if ( !isplayer( target ) )
    {
        remaining_hits = 4;
    }
    
    while ( remaining_hits > 0 )
    {
        wait damage_delay;
        target dodamage( damage, self.origin, self.owner, self, "", "MOD_IMPACT", 0, weapon );
        remaining_hits -= 1;
        
        if ( isalive( target ) && isplayer( target ) )
        {
            bodytype = target getcharacterbodytype();
            
            if ( bodytype >= 0 )
            {
                bodytypefields = getcharacterfields( bodytype, currentsessionmode() );
                
                if ( isdefined( bodytypefields.digitalblood ) ? bodytypefields.digitalblood : 0 )
                {
                    playfxontag( "weapon/fx_hero_firefly_sparks_os", target, "J_SpineLower" );
                }
                else
                {
                    playfxontag( "weapon/fx_hero_firefly_blood_os", target, "J_SpineLower" );
                }
            }
            else
            {
                playfxontag( "weapon/fx_hero_firefly_blood_os", target, "J_SpineLower" );
            }
            
            continue;
        }
        
        if ( !isplayer( target ) )
        {
            playfxontag( "weapon/fx_hero_firefly_sparks_os", target, "tag_origin" );
        }
    }
}

// Namespace hive_gun
// Params 1
// Checksum 0xfaaea03f, Offset: 0x1db8
// Size: 0xcc
function firefly_watch_for_target_death( target )
{
    self endon( #"death" );
    
    if ( isalive( target ) )
    {
        target util::waittill_any( "death", "flashback", "game_ended" );
    }
    
    if ( isplayer( target ) )
    {
        target clientfield::set_to_player( "fireflies_attacking", 0 );
        target clientfield::set_to_player( "fireflies_chasing", 0 );
    }
    
    self thread firefly_death();
}

// Namespace hive_gun
// Params 1
// Checksum 0x80cc0fe0, Offset: 0x1e90
// Size: 0xac
function firefly_watch_for_game_ended( target )
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    
    if ( isalive( target ) && isplayer( target ) )
    {
        target clientfield::set_to_player( "fireflies_attacking", 0 );
        target clientfield::set_to_player( "fireflies_chasing", 0 );
    }
    
    self thread firefly_death();
}

// Namespace hive_gun
// Params 0
// Checksum 0x2e2a705b, Offset: 0x1f48
// Size: 0x14c
function firefly_death()
{
    println( "<dev string:x72>" + self getentnum() );
    self clientfield::set( "firefly_state", 5 );
    self playsound( "wpn_gelgun_hive_die" );
    
    if ( isdefined( self.target_entity ) && isplayer( self.target_entity ) )
    {
        self.target_entity clientfield::set_to_player( "fireflies_attacking", 0 );
        self.target_entity clientfield::set_to_player( "fireflies_chasing", 0 );
    }
    
    waittillframeend();
    thread cleanup_killcam_entity( self.killcament );
    
    if ( isdefined( self ) )
    {
        println( "<dev string:x81>" + self getentnum() );
        self delete();
    }
}

// Namespace hive_gun
// Params 1
// Checksum 0x83010d30, Offset: 0x20a0
// Size: 0x34
function cleanup_killcam_entity( killcament )
{
    wait 5;
    
    if ( isdefined( killcament ) )
    {
        killcament delete();
    }
}

// Namespace hive_gun
// Params 1
// Checksum 0xab9381fb, Offset: 0x20e0
// Size: 0x7c
function get_attack_speed( target )
{
    velocity = target getvelocity();
    speed = length( velocity ) * level.fireflies_attack_speed_scale;
    
    if ( speed < level.fireflies_min_speed )
    {
        speed = level.fireflies_min_speed;
    }
    
    return speed;
}

// Namespace hive_gun
// Params 2
// Checksum 0xbcbcd5a4, Offset: 0x2168
// Size: 0x204
function firefly_attack( target, state )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    target endon( #"entering_last_stand" );
    self thread firefly_killcam_stop();
    self clientfield::set( "firefly_state", state );
    
    if ( isplayer( target ) )
    {
        target clientfield::set_to_player( "fireflies_attacking", 1 );
    }
    
    target_origin = target.origin + ( 0, 0, 50 );
    delta = self.origin - target_origin;
    dist = length( delta );
    time = 0.01;
    
    if ( dist > 0 )
    {
        speed = get_attack_speed( target );
        time = dist / speed;
    }
    
    self.enemy = target;
    firefly_move( target_origin, time );
    
    if ( !isdefined( target ) || !isalive( target ) )
    {
        return;
    }
    
    self linkto( target );
    wait time;
    
    if ( !isalive( target ) )
    {
        return;
    }
    
    self thread firefly_damage_target( target );
}

// Namespace hive_gun
// Params 1
// Checksum 0xb466ff50, Offset: 0x2378
// Size: 0xaa
function get_crumb_position( target )
{
    height = 50;
    
    if ( isplayer( target ) )
    {
        stance = target getstance();
        
        if ( stance == "crouch" )
        {
            height = 30;
        }
        else if ( stance == "prone" )
        {
            height = 15;
        }
    }
    
    return target.origin + ( 0, 0, height );
}

/#

    // Namespace hive_gun
    // Params 1
    // Checksum 0x5b9bfcd5, Offset: 0x2430
    // Size: 0x154, Type: dev
    function target_bread_crumbs_render( target )
    {
        self endon( #"death" );
        self endon( #"attack" );
        
        while ( true )
        {
            previous_crumb = self.origin;
            
            for ( i = 0; i < self.target_breadcrumbs.size ; i++ )
            {
                if ( self.target_breadcrumb_current_index + i > self.target_breadcrumb_last_added )
                {
                    break;
                }
                
                crumb_index = ( self.target_breadcrumb_current_index + i ) % self.target_breadcrumbs.size;
                crumb = self.target_breadcrumbs[ crumb_index ];
                sphere( crumb, 2, ( 0, 1, 0 ), 1, 1, 10, self.debug_time );
                
                if ( i > 0 )
                {
                    line( previous_crumb, crumb, ( 0, 1, 0 ), 1, 1, self.debug_time );
                }
                
                previous_crumb = crumb;
            }
            
            wait 0.05;
        }
    }

#/

// Namespace hive_gun
// Params 1
// Checksum 0xab284d2e, Offset: 0x2590
// Size: 0x19e
function target_bread_crumbs( target )
{
    self endon( #"death" );
    target endon( #"death" );
    self.target_breadcrumbs = [];
    self.target_breadcrumb_current_index = 0;
    self.target_breadcrumb_last_added = 0;
    minimum_delta_sqr = 400;
    self.max_crumbs = 20;
    self.target_breadcrumbs[ self.target_breadcrumb_last_added ] = get_crumb_position( target );
    
    /#
        if ( level.firefly_debug )
        {
            self thread target_bread_crumbs_render( target );
        }
    #/
    
    while ( true )
    {
        wait 0.25;
        previous_crumb_index = self.target_breadcrumb_last_added % self.max_crumbs;
        potential_crumb_position = get_crumb_position( target );
        
        if ( distancesquared( potential_crumb_position, self.target_breadcrumbs[ previous_crumb_index ] ) > minimum_delta_sqr )
        {
            self.target_breadcrumb_last_added++;
            
            if ( self.target_breadcrumb_last_added >= self.target_breadcrumb_current_index + self.max_crumbs )
            {
                self.target_breadcrumb_current_index = self.target_breadcrumb_last_added - self.max_crumbs + 1;
            }
            
            self.target_breadcrumbs[ self.target_breadcrumb_last_added % self.max_crumbs ] = potential_crumb_position;
        }
    }
}

// Namespace hive_gun
// Params 1
// Checksum 0xa5ddb3c, Offset: 0x2738
// Size: 0x88
function get_target_bread_crumb( target )
{
    if ( self.target_breadcrumb_current_index > self.target_breadcrumb_last_added )
    {
        return get_crumb_position( target );
    }
    
    current_index = self.target_breadcrumb_current_index % self.max_crumbs;
    
    if ( !isdefined( self.target_breadcrumbs[ current_index ] ) )
    {
        return get_crumb_position( target );
    }
    
    return self.target_breadcrumbs[ current_index ];
}

// Namespace hive_gun
// Params 2
// Checksum 0x3497311d, Offset: 0x27c8
// Size: 0x4c
function firefly_check_move( position, target )
{
    passed = bullettracepassed( self.origin, position, 0, self, target );
    return passed;
}

// Namespace hive_gun
// Params 1
// Checksum 0x146b36a, Offset: 0x2820
// Size: 0x2f0
function firefly_chase( target )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    target endon( #"death" );
    target endon( #"entering_last_stand" );
    self clientfield::set( "firefly_state", 2 );
    
    if ( isplayer( target ) )
    {
        target clientfield::set_to_player( "fireflies_chasing", 1 );
    }
    
    max_distance = 500;
    attack_distance = 50;
    max_offset = 10;
    up = ( 0, 0, 1 );
    
    while ( true )
    {
        target_origin = target.origin + ( 0, 0, 50 );
        delta = target_origin - self.origin;
        dist = length( delta );
        
        if ( dist <= attack_distance && firefly_check_move( target_origin, target ) )
        {
            thread firefly_attack( target, 3 );
            return;
        }
        else
        {
            target_origin = get_target_bread_crumb( target );
            
            /#
                if ( level.firefly_debug )
                {
                    sphere( self.origin, 2, ( 1, 0, 0 ), 1, 1, 10, self.debug_time );
                }
            #/
        }
        
        delta = target_origin - self.origin;
        angles = vectortoangles( delta );
        thread firefly_rotate( angles, 0.15 );
        dist = length( delta );
        time = 0.01;
        
        if ( dist > 0 )
        {
            speed = get_attack_speed( target );
            time = dist / speed;
        }
        
        firefly_partial_move( target, target_origin, time, level.firefly_pod_partial_move_percent );
        self.target_breadcrumb_current_index++;
    }
}

// Namespace hive_gun
// Params 3
// Checksum 0xcce2d3c4, Offset: 0x2b18
// Size: 0x20c
function firefly_pod_start( start_pos, target, linked )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self notify( #"attack" );
    
    /#
        if ( level.firefly_debug )
        {
            sphere( self.origin, 4, ( 1, 0, 0 ), 1, 1, 10, self.debug_time );
        }
    #/
    
    level.fireflies_height_variance = 30;
    level.fireflies_radius = 100;
    self.target_origin_at_start = target.origin;
    self.target_entity = target;
    
    if ( linked )
    {
        thread firefly_attack( target, 4 );
        return;
    }
    else
    {
        thread target_bread_crumbs( target );
        self moveto( start_pos, level.fireflies_emit_time, 0, level.fireflies_emit_time );
        self waittill( #"movedone" );
        
        if ( isdefined( target ) && isdefined( target.origin ) )
        {
            delta = target.origin - self.origin;
            angles = vectortoangles( delta );
            self.angles = angles;
            self thread firefly_chase( target );
        }
    }
    
    wait 30;
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    self delete();
}

// Namespace hive_gun
// Params 2
// Checksum 0x5349593b, Offset: 0x2d30
// Size: 0x204
function firefly_pod_release_fireflies( attacker, target )
{
    jumpdir = vectornormalize( anglestoup( self.angles ) );
    
    if ( jumpdir[ 2 ] > level.fireflies_spawn_height_wall_angle_cos )
    {
        jumpheight = level.fireflies_spawn_height;
    }
    else
    {
        jumpheight = level.fireflies_spawn_height_wall;
    }
    
    explodepos = self.origin + jumpdir * jumpheight;
    self.firefly_mover.spawn_origin = explodepos;
    linked_to = self getlinkedent();
    linked = linked_to === target;
    
    if ( !linked )
    {
        fx_ent = playfx( "weapon/fx_hero_firefly_start", self.origin, anglestoup( self.angles ) );
        fx_ent.team = self.team;
        self.firefly_mover clientfield::set( "firefly_state", 1 );
        self.firefly_mover.killcament moveto( explodepos + self.firefly_mover.killcamoffset, level.fireflies_emit_time, 0, level.fireflies_emit_time );
    }
    
    self.firefly_mover thread firefly_pod_start( explodepos, target, linked );
    self delete();
}

// Namespace hive_gun
// Params 4
// Checksum 0x1271cf06, Offset: 0x2f40
// Size: 0x80, Type: bool
function firefly_pod_should_damage( watcher, attacker, weapon, damage )
{
    if ( weapon == watcher.weapon )
    {
        return false;
    }
    
    if ( weapon.isemp || weapon.destroysequipment )
    {
        return true;
    }
    
    if ( self.damagetaken < 15 )
    {
        return false;
    }
    
    return true;
}

