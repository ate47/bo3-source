#using scripts/codescripts/struct;
#using scripts/cp/_turret_sentry;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;

#namespace doa_turret;

// Namespace doa_turret
// Params 0
// Checksum 0x1a615fc7, Offset: 0x520
// Size: 0x3c6
function init()
{
    level.doa.mini_turrets = getentarray( "doa_turret", "targetname" );
    
    for ( i = 0; i < level.doa.mini_turrets.size ; i++ )
    {
        turret = level.doa.mini_turrets[ i ];
        turret.var_d211e48d = 0;
        turret.is_attacking = 0;
        turret.original_location = level.doa.mini_turrets[ i ].origin;
        turret.deployed = 0;
        turret.script_delay_min = 0.25;
        turret.script_delay_max = 0.5;
        turret.script_burst_min = 0.5;
        turret.script_burst_max = 1.5;
        turret.ignoreme = 1;
        turret.takedamage = 0;
        turret.minigun = 1;
        turret notsolid();
        turret thread sentry_turret::function_b2e9d990();
        turret thread sentry_turret::function_e6f10cc7();
        turret thread sentry_turret::function_ebdfd4e4( "allies" );
        turret thread turretthink();
    }
    
    level.doa.var_4ede341 = getentarray( "doa_grenade_turret", "targetname" );
    
    for ( i = 0; i < level.doa.var_4ede341.size ; i++ )
    {
        turret = level.doa.var_4ede341[ i ];
        turret.var_d211e48d = 0;
        turret.is_attacking = 0;
        turret.original_location = level.doa.var_4ede341[ i ].origin;
        turret.deployed = 0;
        turret.grenade = 1;
        turret.script_delay_min = 0.25;
        turret.script_delay_max = 0.5;
        turret.script_burst_min = 0.5;
        turret.script_burst_max = 1.5;
        turret.ignoreme = 1;
        turret.takedamage = 0;
        turret notsolid();
        turret thread sentry_turret::function_b2e9d990();
        turret thread sentry_turret::function_e6f10cc7();
        turret thread sentry_turret::function_ebdfd4e4( "allies" );
        turret thread turretthink();
    }
}

// Namespace doa_turret
// Params 1
// Checksum 0x61b91ed1, Offset: 0x8f0
// Size: 0x3a4
function missile_logic( fake )
{
    self waittill( #"missile_fire", missile, weap );
    missile endon( #"death" );
    fake thread doa_utility::function_981c685d( missile );
    missile missile_settarget( fake );
    uptime = gettime() + getdvarfloat( "scr_doa_missile_upwardMax", 2 ) * 1000;
    
    while ( gettime() < uptime && isdefined( fake ) && isdefined( missile ) )
    {
        if ( getdvarfloat( "scr_doa_missile_debug", 0 ) )
        {
            level thread doa_dev::function_a0e51d80( missile.origin, 4, 24, ( 1, 0, 0 ) );
        }
        
        distsq = distancesquared( missile.origin, fake.origin );
        
        if ( distsq < getdvarint( "scr_doa_missile_travel_reached_dist", 96 ) * getdvarint( "scr_doa_missile_travel_reached_dist", 96 ) )
        {
            break;
        }
        
        if ( isdefined( fake.var_5525f623 ) )
        {
            distsq = distancesquared( missile.origin, fake.var_5525f623.origin );
            
            if ( distsq < getdvarint( "scr_doa_missile_detonate_range", 96 ) * getdvarint( "scr_doa_missile_detonate_range", 96 ) )
            {
                if ( isdefined( missile ) )
                {
                    missile detonate();
                }
                
                break;
            }
        }
        
        wait 0.05;
    }
    
    if ( isdefined( fake.var_5525f623 ) )
    {
        enemy = fake.var_5525f623;
        missile missile_settarget( enemy );
    }
    
    fake delete();
    
    while ( isdefined( enemy ) && isdefined( missile ) )
    {
        if ( getdvarfloat( "scr_doa_missile_debug", 0 ) )
        {
            level thread doa_dev::function_a0e51d80( missile.origin, 4, 24, ( 0, 1, 0 ) );
        }
        
        distsq = distancesquared( missile.origin, enemy.origin );
        
        if ( distsq < getdvarint( "scr_doa_missile_detonate_range", 96 ) * getdvarint( "scr_doa_missile_detonate_range", 96 ) )
        {
            break;
        }
        
        wait 0.05;
    }
    
    if ( isdefined( missile ) )
    {
        missile detonate();
    }
}

// Namespace doa_turret
// Params 2
// Checksum 0x569738a1, Offset: 0xca0
// Size: 0x12c
function turret_FakeUpTarget( index, enemy )
{
    if ( !isdefined( enemy ) )
    {
        return;
    }
    
    pos = self.origin + ( enemy.origin - self.origin ) * 0.5 + ( 0, 0, getdvarint( "scr_doa_missile_travel_height", 650 ) );
    fake = spawn( "script_model", pos );
    fake.targetname = "turret_FakeUpTarget";
    fake setmodel( "tag_origin" );
    fake.var_5525f623 = enemy;
    self thread missile_logic( fake );
    self fireweapon( index, fake, undefined, self.owner );
}

// Namespace doa_turret
// Params 2
// Checksum 0x1166a2fb, Offset: 0xdd8
// Size: 0x18c
function weapon_FakeUpTarget( weapon, enemy )
{
    if ( !isdefined( enemy ) )
    {
        return;
    }
    
    v_spawn = self gettagorigin( "tag_flash" );
    v_dir = self gettagangles( "tag_flash" );
    
    if ( !isdefined( v_spawn ) )
    {
        return;
    }
    
    pos = self.origin + ( enemy.origin - self.origin ) * 0.5 + ( 0, 0, getdvarint( "scr_doa_missile_travel_height", 650 ) );
    fake = spawn( "script_model", pos );
    fake.targetname = "weapon_FakeUpTarget";
    fake setmodel( "tag_origin" );
    fake.var_5525f623 = enemy;
    self thread missile_logic( fake );
    magicbullet( weapon, v_spawn, v_spawn + 50 * v_dir, self );
}

// Namespace doa_turret
// Params 2
// Checksum 0xd0948813, Offset: 0xf70
// Size: 0x6c
function turret_fire( index, enemy )
{
    if ( isdefined( self.grenade ) && self.grenade )
    {
        self thread turret_FakeUpTarget( index, enemy );
        return;
    }
    
    self fireweapon( index, enemy, undefined, self.owner );
}

// Namespace doa_turret
// Params 0
// Checksum 0x3f1b1af1, Offset: 0xfe8
// Size: 0x90
function turretthink()
{
    while ( true )
    {
        self waittill( #"hash_f843176e" );
        self sentry_turret::function_21af94b3();
        self thread turret_target();
        self thread function_2c414dda();
        self notify( #"start_scan" );
        self waittill( #"turret_expired" );
        self sentry_turret::function_e6f10cc7();
    }
}

// Namespace doa_turret
// Params 0
// Checksum 0xa19b572c, Offset: 0x1080
// Size: 0x158
function turret_target()
{
    self endon( #"death" );
    self endon( #"turret_expired" );
    self waittill( #"start_scan" );
    
    while ( true )
    {
        if ( !isdefined( self.e_target ) )
        {
            a_enemy = self doa_utility::getclosesttome( getaiteamarray( "axis" ) );
            
            if ( isdefined( a_enemy.boss ) && ( !isdefined( a_enemy ) || a_enemy.boss ) )
            {
                wait 1;
                continue;
            }
            
            self.e_target = a_enemy;
        }
        
        self setturrettargetent( self.e_target );
        self.var_d211e48d = 0;
        
        if ( !self.is_attacking )
        {
            self thread function_2c414dda();
        }
        
        self notify( #"hash_dc8a04ab" );
        
        while ( isalive( self.e_target ) )
        {
            wait 0.5;
        }
        
        self notify( #"lost_target" );
        self.is_attacking = 0;
        wait 0.5;
    }
}

// Namespace doa_turret
// Params 2
// Checksum 0x934ae733, Offset: 0x11e0
// Size: 0x124
function function_4deaa5de( totalfiretime, enemy )
{
    self endon( #"death" );
    weapon = self seatgetweapon( 0 );
    firetime = weapon.firetime;
    time = 0;
    is_minigun = 0;
    
    if ( isdefined( self.minigun ) && self.minigun )
    {
        self setturretspinning( 1 );
        wait 0.5;
    }
    
    while ( time < totalfiretime )
    {
        self thread turret_fire( 0, enemy );
        wait firetime;
        time += firetime;
    }
    
    if ( isdefined( self.minigun ) && self.minigun )
    {
        self setturretspinning( 0 );
    }
}

// Namespace doa_turret
// Params 0
// Checksum 0x90bf6e20, Offset: 0x1310
// Size: 0x128
function function_2c414dda()
{
    self notify( #"hash_2c414dda" );
    self endon( #"hash_2c414dda" );
    self endon( #"death" );
    self endon( #"lost_target" );
    self endon( #"turret_expired" );
    self waittill( #"hash_dc8a04ab" );
    self.turretrotscale = 6;
    self sentry_turret::sentry_turret_alert_sound();
    self.is_attacking = 1;
    offset = ( 0, 0, 0 );
    
    if ( isdefined( self.grenade ) )
    {
        offset = ( 0, 0, -56 );
    }
    
    while ( isdefined( self.e_target ) && isalive( self.e_target ) )
    {
        self setturrettargetent( self.e_target, offset );
        self function_4deaa5de( 2, self.e_target );
        wait 0.2;
    }
}

// Namespace doa_turret
// Params 1
// Checksum 0x22a70d8e, Offset: 0x1440
// Size: 0xd4, Type: bool
function canspawnturret( var_a6f28f3b )
{
    if ( !isdefined( var_a6f28f3b ) )
    {
        var_a6f28f3b = 0;
    }
    
    if ( isdefined( level.doa.magical_exit_taken ) && level.doa.magical_exit_taken )
    {
        return false;
    }
    
    turretarray = level.doa.mini_turrets;
    
    if ( var_a6f28f3b == 1 )
    {
        turretarray = level.doa.var_4ede341;
    }
    
    for ( i = 0; i < turretarray.size ; i++ )
    {
        if ( !turretarray[ i ].deployed )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace doa_turret
// Params 2
// Checksum 0xe02bc7e4, Offset: 0x1520
// Size: 0x56e
function function_eabe8c0( player, var_a6f28f3b )
{
    if ( !isdefined( var_a6f28f3b ) )
    {
        var_a6f28f3b = 0;
    }
    
    mini_turret = undefined;
    turretarray = level.doa.mini_turrets;
    
    if ( var_a6f28f3b == 1 )
    {
        turretarray = level.doa.var_4ede341;
    }
    
    for ( i = 0; i < turretarray.size ; i++ )
    {
        if ( !turretarray[ i ].deployed )
        {
            mini_turret = turretarray[ i ];
            break;
        }
    }
    
    if ( !isdefined( mini_turret ) )
    {
        return;
    }
    
    mini_turret.deployed = 1;
    mini_turret.autonomous = 1;
    droptarget = player.origin + ( 0, 0, 2200 );
    mini_turret.origin = droptarget;
    mini_turret thread doa_sound::function_90118d8c( "evt_turret_incoming" );
    target = player.origin;
    
    if ( isdefined( player.doa.vehicle ) )
    {
        hitp = playerphysicstrace( player.origin + ( 0, 0, 72 ), player.origin + ( 0, 0, -500 ) );
        target = ( player.origin[ 0 ], player.origin[ 1 ], hitp[ 2 ] );
    }
    
    mini_turret thread doa_utility::function_a98c85b2( target, 0.5 );
    mini_turret util::waittill_any_timeout( 1, "movedone" );
    mini_turret.owner = player;
    mini_turret cleartargetentity();
    mini_turret thread doa_fx::function_285a2999( "turret_impact" );
    mini_turret thread doa_sound::function_90118d8c( "evt_turret_land" );
    physicsexplosionsphere( mini_turret.origin, 200, 128, 2 );
    mini_turret radiusdamage( mini_turret.origin, 72, 10000, 10000 );
    playrumbleonposition( "explosion_generic", mini_turret.origin );
    mini_turret notify( #"hash_f843176e" );
    mini_turret laseroff();
    
    if ( isdefined( player ) )
    {
        time_left = gettime() + player doa_utility::function_1ded48e6( level.doa.rules.var_7daebb69 * 1000 );
        fx = doa_player_utility::function_ee495f41( player.entnum );
        mini_turret thread doa_fx::function_285a2999( "player_trail_" + fx );
    }
    else
    {
        time_left = gettime() + level.doa.rules.var_7daebb69 * 1000;
    }
    
    mini_turret thread function_dfe832b7( time_left, "turret_expired" );
    mini_turret waittill( #"turret_expired" );
    mini_turret thread doa_sound::function_90118d8c( "evt_turret_takeoff" );
    mini_turret thread doa_fx::function_285a2999( "veh_takeoff" );
    mini_turret thread doa_fx::function_285a2999( "crater_dust" );
    mini_turret thread doa_utility::function_a98c85b2( droptarget, 1 );
    
    if ( isdefined( fx ) )
    {
        mini_turret thread doa_fx::turnofffx( "player_trail_" + fx );
    }
    
    wait 1;
    mini_turret thread doa_utility::function_a98c85b2( mini_turret.original_location, 1 );
    mini_turret.deployed = 0;
    mini_turret.owner = undefined;
    mini_turret.autonomous = undefined;
}

// Namespace doa_turret
// Params 1
// Checksum 0x652ca5f8, Offset: 0x1a98
// Size: 0x140
function function_a0d09d25( player )
{
    self endon( #"death" );
    self endon( #"hash_7a0ce382" );
    weapon = getweapon( "zombietron_sprinkler_launcher" );
    top = self.origin + ( 0, 0, 32 );
    
    while ( true )
    {
        self rotateto( self.angles + ( 0, 8, 0 ), 0.1 );
        wait 0.1;
        forward = anglestoforward( self.angles + ( 0, 0, randomfloatrange( 100, 500 ) ) );
        magicbullet( weapon, top, top + forward * 1000, isdefined( player ) ? player : self );
    }
}

// Namespace doa_turret
// Params 2
// Checksum 0xfadcc137, Offset: 0x1be0
// Size: 0x4cc
function function_3ce8bf1c( player, origin )
{
    dropspot = origin + ( 0, 0, 800 );
    sprinkler = spawn( "script_model", dropspot );
    sprinkler.targetname = "sprinkler";
    sprinkler setmodel( level.doa.var_304b4b41 );
    def = doa_pickups::function_bac08508( 20 );
    sprinkler setscale( def.scale );
    sprinkler notsolid();
    target = player.origin;
    
    if ( isdefined( player.doa.vehicle ) )
    {
        hitp = playerphysicstrace( player.origin + ( 0, 0, 72 ), player.origin + ( 0, 0, -500 ) );
        target = ( player.origin[ 0 ], player.origin[ 1 ], hitp[ 2 ] );
    }
    
    mark = target + ( 0, 0, 12 );
    sprinkler thread doa_sound::function_90118d8c( "evt_sprinkler_incoming" );
    sprinkler thread doa_utility::function_a98c85b2( mark, 0.5 );
    sprinkler util::waittill_any_timeout( 1, "movedone" );
    sprinkler thread doa_sound::function_90118d8c( "evt_sprinkler_land" );
    sprinkler thread doa_fx::function_285a2999( "sprinkler_land" );
    
    if ( isdefined( player ) )
    {
        fx = doa_player_utility::function_ee495f41( player.entnum );
        sprinkler thread doa_fx::function_285a2999( "player_trail_" + fx );
    }
    
    physicsexplosionsphere( mark, 200, 128, 3 );
    sprinkler radiusdamage( mark, 72, 10000, 10000 );
    playrumbleonposition( "explosion_generic", mark );
    wait 1;
    sprinkler playloopsound( "evt_sprinkler_loop", 0.5 );
    sprinkler thread doa_fx::function_285a2999( "sprinkler_active" );
    sprinkler thread function_a0d09d25( player );
    wait player doa_utility::function_1ded48e6( level.doa.rules.var_213b65db );
    sprinkler thread doa_fx::turnofffx( "sprinkler_active" );
    wait 2;
    sprinkler thread doa_sound::function_90118d8c( "evt_sprinkler_takeoff" );
    sprinkler thread doa_fx::function_285a2999( "sprinkler_takeoff" );
    sprinkler stoploopsound( 2 );
    
    if ( isdefined( fx ) )
    {
        sprinkler thread doa_fx::turnofffx( "player_trail_" + fx );
    }
    
    sprinkler thread doa_utility::function_a98c85b2( dropspot, 0.5 );
    sprinkler util::waittill_any_timeout( 1, "movedone" );
    sprinkler delete();
}

// Namespace doa_turret
// Params 2, eflags: 0x4
// Checksum 0xfa1fd0ab, Offset: 0x20b8
// Size: 0xa6
function private function_dfe832b7( timeleft, note )
{
    while ( gettime() < timeleft )
    {
        if ( level flag::get( "doa_round_active" ) )
        {
            wait 1;
            continue;
        }
        
        if ( doa_utility::function_b99d78c7() == 0 )
        {
            wait randomfloatrange( 0, 1.4 );
            self notify( note );
            break;
        }
        
        wait 1;
    }
    
    if ( isdefined( self ) )
    {
        self notify( note );
    }
}

// Namespace doa_turret
// Params 2
// Checksum 0x7a2cb0fc, Offset: 0x2168
// Size: 0x6ec
function amwsPickupUpdate( player, origin )
{
    team = player.team;
    time_left = gettime() + player doa_utility::function_1ded48e6( level.doa.rules.var_3c441789 * 1000 );
    angles = player.angles;
    dropspot = origin + ( 0, 0, 800 );
    spawner = getent( "doa_amws", "targetname" );
    
    if ( !isdefined( spawner ) )
    {
        return;
    }
    
    target = player.origin;
    
    if ( isdefined( player.doa.vehicle ) )
    {
        hitp = playerphysicstrace( player.origin + ( 0, 0, 72 ), player.origin + ( 0, 0, -500 ) );
        target = ( player.origin[ 0 ], player.origin[ 1 ], hitp[ 2 ] );
    }
    
    mark = target + ( 0, 0, 16 );
    fake = spawn( "script_model", dropspot );
    fake.targetname = "amwsPickupUpdate";
    fake setmodel( level.doa.var_4aa90d77 );
    fake.angles = angles;
    fake thread doa_fx::function_285a2999( "fire_trail" );
    fake thread doa_sound::function_90118d8c( "evt_turret_incoming" );
    fake moveto( mark, 0.5 );
    fake util::waittill_any_timeout( 1, "movedone" );
    physicsexplosionsphere( mark, 200, 128, 3 );
    fake radiusdamage( mark, 72, 10000, 10000 );
    playrumbleonposition( "explosion_generic", mark );
    fake delete();
    amws = spawner spawner::spawn( 1 );
    note = doa_utility::function_2ccf4b82( "amws_done" );
    
    if ( isdefined( amws ) )
    {
        amws.origin = mark;
        amws.angles = angles;
        amws.health = 10000;
        amws.team = team;
        amws.owner = player;
        amws.autonomous = 1;
        amws notsolid();
        amws thread function_43d18fa4( player, note );
        amws thread doa_fx::function_285a2999( "turret_impact" );
        amws thread doa_sound::function_90118d8c( "evt_turret_land" );
        amws.overridevehicledamage = &function_f3ee1c57;
        level.doa.var_1332e37a[ level.doa.var_1332e37a.size ] = amws;
        amws thread doa_pickups::function_9908c4ec();
    }
    
    if ( isdefined( player ) && isdefined( amws ) )
    {
        fx = doa_player_utility::function_ee495f41( player.entnum );
        amws thread doa_fx::function_285a2999( "player_trail_" + fx );
    }
    
    level thread function_dfe832b7( time_left, note );
    level waittill( note );
    
    if ( isdefined( amws ) && isdefined( fx ) )
    {
        amws thread doa_fx::turnofffx( "player_trail_" + fx );
    }
    
    if ( isdefined( amws ) )
    {
        fake = spawn( "script_model", amws.origin );
        fake.targetname = "amwsPickupUpdate2";
        fake setmodel( level.doa.var_4aa90d77 );
        fake.angles = amws.angles;
        fake thread doa_sound::function_90118d8c( "evt_turret_takeoff" );
        amws delete();
        fake thread doa_fx::function_285a2999( "veh_takeoff" );
        fake thread doa_fx::function_285a2999( "crater_dust" );
        fake moveto( dropspot, 0.5 );
        fake util::waittill_any_timeout( 1, "movedone" );
        fake delete();
    }
}

// Namespace doa_turret
// Params 15
// Checksum 0xf675efcc, Offset: 0x2860
// Size: 0xa0
function function_f3ee1c57( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal )
{
    if ( isdefined( smeansofdeath ) && smeansofdeath == "MOD_MELEE" )
    {
        return idamage;
    }
    
    return 0;
}

// Namespace doa_turret
// Params 2, eflags: 0x4
// Checksum 0xd5f59049, Offset: 0x2908
// Size: 0x66
function private function_43d18fa4( player, note )
{
    self endon( #"death" );
    level endon( note );
    
    while ( isdefined( player ) )
    {
        self setgoalpos( player.origin, 0, 300 );
        wait 1;
    }
}

