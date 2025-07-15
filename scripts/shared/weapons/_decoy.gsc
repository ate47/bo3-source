#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/entityheadicons_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;

#namespace decoy;

// Namespace decoy
// Params 0
// Checksum 0xc7475156, Offset: 0x240
// Size: 0xdc
function init_shared()
{
    level.decoyweapons = [];
    level.decoyweapons[ "fullauto" ] = [];
    level.decoyweapons[ "semiauto" ] = [];
    level.decoyweapons[ "fullauto" ][ level.decoyweapons[ "fullauto" ].size ] = getweapon( "ar_accurate" );
    level.decoyweapons[ "semiauto" ][ level.decoyweapons[ "semiauto" ].size ] = getweapon( "pistol_standard" );
    callback::add_weapon_watcher( &create_watcher );
}

// Namespace decoy
// Params 0
// Checksum 0x69cd926c, Offset: 0x328
// Size: 0x88
function create_watcher()
{
    watcher = self weaponobjects::createuseweaponobjectwatcher( "nightingale", self.team );
    watcher.onspawn = &on_spawn;
    watcher.ondetonatecallback = &detonate;
    watcher.deleteondifferentobjectspawn = 0;
    watcher.headicon = 0;
}

// Namespace decoy
// Params 2
// Checksum 0xbd5ce5c2, Offset: 0x3b8
// Size: 0x12c
function on_spawn( watcher, owner )
{
    owner endon( #"disconnect" );
    self endon( #"death" );
    weaponobjects::onspawnuseweaponobject( watcher, owner );
    self.initial_velocity = self getvelocity();
    delay = 1;
    wait delay;
    decoy_time = 30;
    spawn_time = gettime();
    owner addweaponstat( self.weapon, "used", 1 );
    self thread simulate_weapon_fire( owner );
    
    while ( true )
    {
        if ( gettime() > spawn_time + decoy_time * 1000 )
        {
            self destroy( watcher, owner );
            return;
        }
        
        wait 0.05;
    }
}

// Namespace decoy
// Params 5
// Checksum 0x8621b3e, Offset: 0x4f0
// Size: 0x2d4
function move( owner, count, fire_time, main_dir, max_offset_angle )
{
    self endon( #"death" );
    self endon( #"done" );
    
    if ( !self isonground() )
    {
        return;
    }
    
    min_speed = 100;
    max_speed = 200;
    min_up_speed = 100;
    max_up_speed = 200;
    current_main_dir = randomintrange( main_dir - max_offset_angle, main_dir + max_offset_angle );
    avel = ( randomfloatrange( 800, 1800 ) * ( randomintrange( 0, 2 ) * 2 - 1 ), 0, randomfloatrange( 580, 940 ) * ( randomintrange( 0, 2 ) * 2 - 1 ) );
    intial_up = randomfloatrange( min_up_speed, max_up_speed );
    start_time = gettime();
    gravity = getdvarint( "bg_gravity" );
    
    for ( i = 0; i < 1 ; i++ )
    {
        angles = ( 0, randomintrange( current_main_dir - max_offset_angle, current_main_dir + max_offset_angle ), 0 );
        dir = anglestoforward( angles );
        dir = vectorscale( dir, randomfloatrange( min_speed, max_speed ) );
        deltatime = ( gettime() - start_time ) * 0.001;
        up = ( 0, 0, intial_up - 800 * deltatime );
        self launch( dir + up, avel );
        wait fire_time;
    }
}

// Namespace decoy
// Params 2
// Checksum 0xc401c86c, Offset: 0x7d0
// Size: 0x3c
function destroy( watcher, owner )
{
    self notify( #"done" );
    self entityheadicons::setentityheadicon( "none" );
}

// Namespace decoy
// Params 3
// Checksum 0xb9d2828e, Offset: 0x818
// Size: 0x44
function detonate( attacker, weapon, target )
{
    self notify( #"done" );
    self entityheadicons::setentityheadicon( "none" );
}

// Namespace decoy
// Params 1
// Checksum 0x6c51e50d, Offset: 0x868
// Size: 0x1a6
function simulate_weapon_fire( owner )
{
    owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"done" );
    weapon = pick_random_weapon();
    self thread watch_for_explosion( owner, weapon );
    self thread track_main_direction();
    self.max_offset_angle = 30;
    weapon_class = util::getweaponclass( weapon );
    
    switch ( weapon_class )
    {
        case "weapon_assault":
        case "weapon_cqb":
        case "weapon_hmg":
        case "weapon_lmg":
        case "weapon_smg":
            simulate_weapon_fire_machine_gun( owner, weapon );
            break;
        case "weapon_sniper":
            simulate_weapon_fire_sniper( owner, weapon );
            break;
        case "weapon_pistol":
            simulate_weapon_fire_pistol( owner, weapon );
            break;
        case "weapon_shotgun":
            simulate_weapon_fire_shotgun( owner, weapon );
            break;
        default:
            simulate_weapon_fire_machine_gun( owner, weapon );
            break;
    }
}

// Namespace decoy
// Params 2
// Checksum 0xfc2f3047, Offset: 0xa18
// Size: 0x64
function simulate_weapon_fire_machine_gun( owner, weapon )
{
    if ( weapon.issemiauto )
    {
        simulate_weapon_fire_machine_gun_semi_auto( owner, weapon );
        return;
    }
    
    simulate_weapon_fire_machine_gun_full_auto( owner, weapon );
}

// Namespace decoy
// Params 2
// Checksum 0x9a06b8c9, Offset: 0xa88
// Size: 0x158
function simulate_weapon_fire_machine_gun_semi_auto( owner, weapon )
{
    clipsize = weapon.clipsize;
    firetime = weapon.firetime;
    reloadtime = weapon.reloadtime;
    burst_spacing_min = 4;
    burst_spacing_max = 10;
    
    while ( true )
    {
        if ( clipsize <= 1 )
        {
            burst_count = 1;
        }
        else
        {
            burst_count = randomintrange( 1, clipsize );
        }
        
        self thread move( owner, burst_count, firetime, self.main_dir, self.max_offset_angle );
        self fire_burst( owner, weapon, firetime, burst_count, 1 );
        finish_while_loop( weapon, reloadtime, burst_spacing_min, burst_spacing_max );
    }
}

// Namespace decoy
// Params 2
// Checksum 0x4fed54e5, Offset: 0xbe8
// Size: 0x140
function simulate_weapon_fire_pistol( owner, weapon )
{
    clipsize = weapon.clipsize;
    firetime = weapon.firetime;
    reloadtime = weapon.reloadtime;
    burst_spacing_min = 0.5;
    burst_spacing_max = 4;
    
    while ( true )
    {
        burst_count = randomintrange( 1, clipsize );
        self thread move( owner, burst_count, firetime, self.main_dir, self.max_offset_angle );
        self fire_burst( owner, weapon, firetime, burst_count, 0 );
        finish_while_loop( weapon, reloadtime, burst_spacing_min, burst_spacing_max );
    }
}

// Namespace decoy
// Params 2
// Checksum 0xe711d714, Offset: 0xd30
// Size: 0x158
function simulate_weapon_fire_shotgun( owner, weapon )
{
    clipsize = weapon.clipsize;
    firetime = weapon.firetime;
    reloadtime = weapon.reloadtime;
    
    if ( clipsize > 2 )
    {
        clipsize = 2;
    }
    
    burst_spacing_min = 0.5;
    burst_spacing_max = 4;
    
    while ( true )
    {
        burst_count = randomintrange( 1, clipsize );
        self thread move( owner, burst_count, firetime, self.main_dir, self.max_offset_angle );
        self fire_burst( owner, weapon, firetime, burst_count, 0 );
        finish_while_loop( weapon, reloadtime, burst_spacing_min, burst_spacing_max );
    }
}

// Namespace decoy
// Params 2
// Checksum 0x12cbb3c7, Offset: 0xe90
// Size: 0x180
function simulate_weapon_fire_machine_gun_full_auto( owner, weapon )
{
    clipsize = weapon.clipsize;
    firetime = weapon.firetime;
    reloadtime = weapon.reloadtime;
    
    if ( clipsize > 30 )
    {
        clipsize = 30;
    }
    
    burst_spacing_min = 2;
    burst_spacing_max = 6;
    
    while ( true )
    {
        burst_count = randomintrange( int( clipsize * 0.6 ), clipsize );
        interrupt = 0;
        self thread move( owner, burst_count, firetime, self.main_dir, self.max_offset_angle );
        self fire_burst( owner, weapon, firetime, burst_count, interrupt );
        finish_while_loop( weapon, reloadtime, burst_spacing_min, burst_spacing_max );
    }
}

// Namespace decoy
// Params 2
// Checksum 0xd88cbb05, Offset: 0x1018
// Size: 0x150
function simulate_weapon_fire_sniper( owner, weapon )
{
    clipsize = weapon.clipsize;
    firetime = weapon.firetime;
    reloadtime = weapon.reloadtime;
    
    if ( clipsize > 2 )
    {
        clipsize = 2;
    }
    
    burst_spacing_min = 3;
    burst_spacing_max = 5;
    
    while ( true )
    {
        burst_count = randomintrange( 1, clipsize );
        self thread move( owner, burst_count, firetime, self.main_dir, self.max_offset_angle );
        self fire_burst( owner, weapon, firetime, burst_count, 0 );
        finish_while_loop( weapon, reloadtime, burst_spacing_min, burst_spacing_max );
    }
}

// Namespace decoy
// Params 5
// Checksum 0x12b29e4f, Offset: 0x1170
// Size: 0xfe
function fire_burst( owner, weapon, firetime, count, interrupt )
{
    interrupt_shot = count;
    
    if ( interrupt )
    {
        interrupt_shot = int( count * randomfloatrange( 0.6, 0.8 ) );
    }
    
    self fakefire( owner, self.origin, weapon, interrupt_shot );
    wait firetime * interrupt_shot;
    
    if ( interrupt )
    {
        self fakefire( owner, self.origin, weapon, count - interrupt_shot );
        wait firetime * ( count - interrupt_shot );
    }
}

// Namespace decoy
// Params 4
// Checksum 0xc5b877e2, Offset: 0x1278
// Size: 0x74
function finish_while_loop( weapon, reloadtime, burst_spacing_min, burst_spacing_max )
{
    if ( should_play_reload_sound() )
    {
        play_reload_sounds( weapon, reloadtime );
        return;
    }
    
    wait randomfloatrange( burst_spacing_min, burst_spacing_max );
}

// Namespace decoy
// Params 2
// Checksum 0x5d8dceb4, Offset: 0x12f8
// Size: 0x82
function play_reload_sounds( weapon, reloadtime )
{
    divy_it_up = ( reloadtime - 0.1 ) / 2;
    wait 0.1;
    self playsound( "fly_assault_reload_npc_mag_out" );
    wait divy_it_up;
    self playsound( "fly_assault_reload_npc_mag_in" );
    wait divy_it_up;
}

// Namespace decoy
// Params 2
// Checksum 0x8121e9e5, Offset: 0x1388
// Size: 0x9c
function watch_for_explosion( owner, weapon )
{
    self thread watch_for_death_before_explosion();
    owner endon( #"disconnect" );
    self endon( #"death_before_explode" );
    self waittill( #"explode", pos );
    level thread do_explosion( owner, pos, weapon, randomintrange( 5, 10 ) );
}

// Namespace decoy
// Params 0
// Checksum 0x27cbd27d, Offset: 0x1430
// Size: 0x2e
function watch_for_death_before_explosion()
{
    self waittill( #"death" );
    wait 0.1;
    
    if ( isdefined( self ) )
    {
        self notify( #"death_before_explode" );
    }
}

// Namespace decoy
// Params 4
// Checksum 0xf18c82df, Offset: 0x1468
// Size: 0x14e
function do_explosion( owner, pos, weapon, count )
{
    min_offset = 100;
    max_offset = 500;
    
    for ( i = 0; i < count ; i++ )
    {
        wait randomfloatrange( 0.1, 0.5 );
        offset = ( randomfloatrange( min_offset, max_offset ) * ( randomintrange( 0, 2 ) * 2 - 1 ), randomfloatrange( min_offset, max_offset ) * ( randomintrange( 0, 2 ) * 2 - 1 ), 0 );
        owner fakefire( owner, pos + offset, weapon, 1 );
    }
}

// Namespace decoy
// Params 0
// Checksum 0xb1f6d0e4, Offset: 0x15c0
// Size: 0xd6
function pick_random_weapon()
{
    type = "fullauto";
    
    if ( randomintrange( 0, 10 ) < 3 )
    {
        type = "semiauto";
    }
    
    randomval = randomintrange( 0, level.decoyweapons[ type ].size );
    println( "<dev string:x28>" + type + "<dev string:x35>" + level.decoyweapons[ type ][ randomval ].name );
    return level.decoyweapons[ type ][ randomval ];
}

// Namespace decoy
// Params 0
// Checksum 0xac62a783, Offset: 0x16a0
// Size: 0x2c, Type: bool
function should_play_reload_sound()
{
    if ( randomintrange( 0, 5 ) == 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace decoy
// Params 0
// Checksum 0x96bf3906, Offset: 0x16d8
// Size: 0x130
function track_main_direction()
{
    self endon( #"death" );
    self endon( #"done" );
    self.main_dir = int( vectortoangles( ( self.initial_velocity[ 0 ], self.initial_velocity[ 1 ], 0 ) )[ 1 ] );
    up = ( 0, 0, 1 );
    
    while ( true )
    {
        self waittill( #"grenade_bounce", pos, normal );
        dot = vectordot( normal, up );
        
        if ( dot < 0.5 && dot > -0.5 )
        {
            self.main_dir = int( vectortoangles( ( normal[ 0 ], normal[ 1 ], 0 ) )[ 1 ] );
        }
    }
}

