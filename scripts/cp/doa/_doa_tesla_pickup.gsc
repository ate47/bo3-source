#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_gibs;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;

#namespace doa_tesla;

// Namespace doa_tesla
// Params 0
// Checksum 0x7a44167f, Offset: 0x460
// Size: 0xec
function init()
{
    level.weaponzmteslagun = getweapon( "tesla_gun" );
    level.weaponzmteslagunupgraded = getweapon( "tesla_gun_upgraded" );
    level.doa.rules.tesla_max_arcs = 5;
    level.doa.rules.tesla_max_enemies_killed = 20;
    level.doa.rules.tesla_radius_start = 300;
    level.doa.rules.tesla_radius_decay = 20;
    level.doa.rules.tesla_head_gib_chance = 50;
    level.doa.rules.var_37d05402 = 30;
}

// Namespace doa_tesla
// Params 0
// Checksum 0xfeadcea, Offset: 0x558
// Size: 0x5e
function tesla_discharge_mechanic()
{
    self endon( #"tesla_discharge_mechanic" );
    self notify( #"tesla_discharge_mechanic" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self.tesla_discharge = 1;
        self waittill( #"tesla_discharged" );
        self.tesla_discharge = 0;
        wait 2;
    }
}

// Namespace doa_tesla
// Params 1
// Checksum 0xed26d94f, Offset: 0x5c0
// Size: 0x42, Type: bool
function tesla_ok_to_discharge( player )
{
    if ( !isdefined( player.tesla_discharge ) )
    {
        return true;
    }
    
    if ( player.tesla_discharge == 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace doa_tesla
// Params 1
// Checksum 0x78fec1cf, Offset: 0x610
// Size: 0xf4
function tesla_damage_init( player )
{
    player endon( #"disconnect" );
    player endon( #"death" );
    waittillframeend();
    
    if ( !tesla_ok_to_discharge( player ) )
    {
        return;
    }
    
    if ( isdefined( self.zombie_tesla_hit ) && self.zombie_tesla_hit )
    {
        return;
    }
    
    player.tesla_enemies = undefined;
    player.tesla_enemies_hit = 1;
    player.tesla_powerup_dropped = 0;
    player notify( #"tesla_discharged" );
    self thread doa_fx::function_285a2999( "tesla_shock" );
    
    if ( !( isdefined( self.boss ) && self.boss ) )
    {
        self tesla_arc_damage( self, player, 0 );
    }
    
    player.tesla_enemies_hit = 0;
}

// Namespace doa_tesla
// Params 3
// Checksum 0xdbfa5fb6, Offset: 0x710
// Size: 0x20e
function tesla_arc_damage( source_enemy, player, arc_num )
{
    player endon( #"disconnect" );
    player endon( #"death" );
    tesla_flag_hit( self, 1 );
    radius_decay = level.doa.rules.tesla_radius_decay * arc_num;
    enemies = tesla_get_enemies_in_area( self gettagorigin( "j_head" ), level.doa.rules.tesla_radius_start - radius_decay, player );
    tesla_flag_hit( enemies, 1 );
    self thread tesla_do_damage( source_enemy, arc_num, player );
    
    for ( i = 0; i < enemies.size ; i++ )
    {
        if ( enemies[ i ] == self )
        {
            continue;
        }
        
        if ( isdefined( enemies[ i ].boss ) && enemies[ i ].boss == 1 )
        {
            continue;
        }
        
        if ( tesla_end_arc_damage( arc_num + 1, player.tesla_enemies_hit ) )
        {
            tesla_flag_hit( enemies[ i ], 0 );
            continue;
        }
        
        player.tesla_enemies_hit++;
        enemies[ i ] thread tesla_arc_damage( self, player, arc_num + 1 );
    }
}

// Namespace doa_tesla
// Params 2
// Checksum 0xe143672, Offset: 0x928
// Size: 0xbc, Type: bool
function tesla_end_arc_damage( arc_num, enemies_hit_num )
{
    if ( arc_num >= level.doa.rules.tesla_max_arcs )
    {
        return true;
    }
    
    if ( enemies_hit_num >= level.doa.rules.tesla_max_enemies_killed )
    {
        return true;
    }
    
    radius_decay = level.doa.rules.tesla_radius_decay * arc_num;
    
    if ( level.doa.rules.tesla_radius_start - radius_decay <= 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace doa_tesla
// Params 3
// Checksum 0x5783b256, Offset: 0x9f0
// Size: 0x1e8
function tesla_get_enemies_in_area( origin, distance, player )
{
    distance_squared = distance * distance;
    enemies = [];
    
    if ( !isdefined( player.tesla_enemies ) )
    {
        player.tesla_enemies = getaispeciesarray( "axis", "all" );
        player.tesla_enemies = util::get_array_of_closest( origin, player.tesla_enemies );
    }
    
    zombies = player.tesla_enemies;
    
    if ( isdefined( zombies ) )
    {
        for ( i = 0; i < zombies.size ; i++ )
        {
            if ( !isdefined( zombies[ i ] ) )
            {
                continue;
            }
            
            test_origin = zombies[ i ] gettagorigin( "j_head" );
            
            if ( isdefined( zombies[ i ].zombie_tesla_hit ) && zombies[ i ].zombie_tesla_hit == 1 )
            {
                continue;
            }
            
            if ( distancesquared( origin, test_origin ) > distance_squared )
            {
                continue;
            }
            
            if ( !bullettracepassed( origin, test_origin, 0, undefined ) )
            {
                continue;
            }
            
            enemies[ enemies.size ] = zombies[ i ];
        }
    }
    
    return enemies;
}

// Namespace doa_tesla
// Params 2
// Checksum 0xa6185ff4, Offset: 0xbe0
// Size: 0x90
function tesla_flag_hit( enemy, hit )
{
    if ( !isdefined( enemy ) )
    {
        return;
    }
    
    if ( isarray( enemy ) )
    {
        for ( i = 0; i < enemy.size ; i++ )
        {
            enemy[ i ].zombie_tesla_hit = hit;
        }
        
        return;
    }
    
    enemy.zombie_tesla_hit = hit;
}

// Namespace doa_tesla
// Params 3
// Checksum 0xd915e289, Offset: 0xc78
// Size: 0x1f4
function tesla_do_damage( source_enemy, arc_num, player )
{
    player endon( #"disconnect" );
    timetowait = 0.2 * arc_num;
    
    if ( timetowait > 0 )
    {
        wait timetowait;
    }
    
    if ( !isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( isdefined( source_enemy ) && source_enemy != self )
    {
        source_enemy tesla_play_arc_fx( self );
    }
    
    if ( !isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
    self.tesla_death = 1;
    self thread tesla_play_death_fx( arc_num );
    origin = player.origin;
    
    if ( isdefined( source_enemy ) && source_enemy != self )
    {
        origin = source_enemy.origin;
    }
    
    if ( self.archetype == "zombie" )
    {
        self clientfield::set( "zombie_gut_explosion", 1 );
    }
    
    if ( self.archetype == "robot" )
    {
        self doa_gib::function_7b3e39cb();
    }
    
    if ( isdefined( self.tesla_damage_func ) )
    {
        self [[ self.tesla_damage_func ]]( origin, player );
        return;
    }
    
    self dodamage( self.health + 666, origin, player, player );
}

// Namespace doa_tesla
// Params 1
// Checksum 0x23bd0038, Offset: 0xe78
// Size: 0x90
function tesla_play_death_fx( arc_num )
{
    if ( arc_num > 1 )
    {
        self thread doa_fx::function_285a2999( "tesla_shock_eyes" );
    }
    
    self thread doa_fx::function_285a2999( "tesla_shock" );
    self thread doa_sound::function_90118d8c( "zmb_pwup_coco_impact" );
    
    if ( isdefined( self.tesla_head_gib_func ) )
    {
        [[ self.tesla_head_gib_func ]]();
    }
}

// Namespace doa_tesla
// Params 1
// Checksum 0x93c713fe, Offset: 0xf10
// Size: 0x28c
function tesla_play_arc_fx( target )
{
    if ( !isdefined( self ) || !isdefined( target ) )
    {
        wait getdvarfloat( "scr_arc_travel_time", 0.05 );
        return;
    }
    
    tag = "J_SpineUpper";
    
    if ( self.isdog )
    {
        tag = "J_Spine1";
    }
    
    target_tag = "J_SpineUpper";
    
    if ( target.isdog )
    {
        target_tag = "J_Spine1";
    }
    
    origin = self gettagorigin( tag );
    target_origin = target gettagorigin( target_tag );
    distsq = distancesquared( origin, target_origin );
    var_3d719a1d = distsq / 128 * 128;
    timemove = var_3d719a1d * getdvarfloat( "scr_arc_travel_time", 0.05 );
    
    if ( timemove < 0.2 )
    {
        timemove = 0.2;
    }
    
    fxorg = spawn( "script_model", origin );
    fxorg.targetname = "tesla_trail";
    fxorg setmodel( "tag_origin" );
    fxorg thread doa_fx::function_285a2999( "tesla_trail" );
    fxorg thread doa_sound::function_90118d8c( "zmb_pwup_coco_bounce" );
    fxorg moveto( target_origin, timemove );
    fxorg util::waittill_any_timeout( timemove + 1, "movedone" );
    fxorg delete();
}

/#

    // Namespace doa_tesla
    // Params 2
    // Checksum 0xe464f405, Offset: 0x11a8
    // Size: 0x6c, Type: dev
    function tesla_debug_arc( origin, distance )
    {
        if ( getdvarint( #"hash_fa91ea91" ) != 3 )
        {
            return;
        }
        
        start = gettime();
        
        while ( gettime() < start + 3000 )
        {
            wait 0.05;
        }
    }

#/

// Namespace doa_tesla
// Params 0
// Checksum 0x5a82eab7, Offset: 0x1220
// Size: 0x16, Type: bool
function enemy_killed_by_tesla()
{
    return isdefined( self.tesla_death ) && self.tesla_death;
}

// Namespace doa_tesla
// Params 2
// Checksum 0x4d86147e, Offset: 0x1240
// Size: 0xf4, Type: bool
function function_395fdfb8( guy, attacker )
{
    if ( !isdefined( guy ) )
    {
        return false;
    }
    
    if ( isdefined( guy.boss ) && guy.boss )
    {
        return false;
    }
    
    if ( isdefined( guy.tesla_death ) && ( isdefined( guy.damagedby ) && guy.damagedby == "tesla" || guy.tesla_death ) )
    {
        return false;
    }
    
    if ( tesla_ok_to_discharge( attacker ) )
    {
        guy.damagedby = "tesla";
        guy thread tesla_damage_init( attacker );
        return true;
    }
    
    return false;
}

// Namespace doa_tesla
// Params 2
// Checksum 0x56ffb1cc, Offset: 0x1340
// Size: 0x84
function tesla_blockers_damage_trigger( player, note )
{
    player endon( note );
    player endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"trigger", guy );
        
        if ( level thread function_395fdfb8( guy, player ) )
        {
            self.triggered = 1;
            break;
        }
    }
}

// Namespace doa_tesla
// Params 2
// Checksum 0x8da5be2b, Offset: 0x13d0
// Size: 0xee
function tesla_blockers_timeout( org, note )
{
    self endon( note );
    self endon( #"disconnect" );
    org playloopsound( "zmb_pwup_coco_loop" );
    level doa_utility::function_124b9a08();
    wait self doa_utility::function_1ded48e6( level.doa.rules.var_37d05402 );
    org stopsounds();
    org stoploopsound( 0.5 );
    self thread doa_sound::function_90118d8c( "zmb_pwup_coco_end" );
    self notify( note );
}

// Namespace doa_tesla
// Params 2
// Checksum 0xe9abe27b, Offset: 0x14c8
// Size: 0xac
function function_ccf71744( org, vel )
{
    self moveto( org.origin, 0.5 );
    self util::waittill_any_timeout( 1, "movedone" );
    vel *= 0.4;
    self thread doa_fx::function_285a2999( "tesla_launch" );
    self physicslaunch( self.origin, vel );
}

// Namespace doa_tesla
// Params 1
// Checksum 0x5cdb3f0b, Offset: 0x1580
// Size: 0x124
function function_89843a06( player )
{
    self endon( #"death" );
    player waittill( #"disconnect" );
    
    for ( i = 0; i < self.triggers.size ; i++ )
    {
        if ( isdefined( self.triggers[ i ] ) )
        {
            self.triggers[ i ] delete();
            self.objects[ i ] unlink();
        }
    }
    
    wait 2;
    
    for ( i = 0; i < self.objects.size ; i++ )
    {
        if ( isdefined( self.objects[ i ] ) )
        {
            self.objects[ i ] delete();
        }
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace doa_tesla
// Params 2
// Checksum 0xeb6ca3e1, Offset: 0x16b0
// Size: 0x224
function tesla_blockers_cleanup( org, note )
{
    self util::waittill_any( note, "disconnect", "player_died", "kill_shield", "doa_playerVehiclePickup" );
    
    if ( isdefined( self ) )
    {
        self notify( note );
    }
    
    if ( isdefined( org ) )
    {
        for ( i = 0; i < org.triggers.size ; i++ )
        {
            if ( isdefined( org.triggers[ i ] ) )
            {
                org.triggers[ i ] delete();
                org.objects[ i ] unlink();
                
                if ( isdefined( self ) )
                {
                    vel = org.objects[ i ].origin - self.origin;
                    org.objects[ i ] thread function_ccf71744( org, vel );
                }
            }
        }
    }
    
    wait 2;
    
    if ( isdefined( org ) )
    {
        for ( i = 0; i < org.objects.size ; i++ )
        {
            if ( isdefined( org.objects[ i ] ) )
            {
                org.objects[ i ] delete();
            }
        }
    }
    
    if ( isdefined( self ) )
    {
        self.doa.tesla_blockers = undefined;
    }
    
    if ( isdefined( org ) )
    {
        org delete();
    }
}

// Namespace doa_tesla
// Params 2
// Checksum 0xcad648f4, Offset: 0x18e0
// Size: 0x13c
function tesla_blockers_deletion_monitors( org, note )
{
    self endon( note );
    org endon( #"death" );
    count = 0;
    
    while ( true )
    {
        for ( i = 0; i < org.objects.size ; i++ )
        {
            if ( isdefined( org.triggers[ i ] ) && isdefined( org.triggers[ i ].triggered ) )
            {
                org.triggers[ i ] delete();
                org.objects[ i ] delete();
                count++;
                
                if ( count >= 4 )
                {
                    org stoploopsound( 0.5 );
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace doa_tesla
// Params 2
// Checksum 0xfed77a14, Offset: 0x1a28
// Size: 0x76
function tesla_blockers_move( org, note )
{
    self endon( note );
    org endon( #"death" );
    
    while ( true )
    {
        org rotateto( org.angles + ( 0, 180, 0 ), 1 );
        wait 1;
    }
}

// Namespace doa_tesla
// Params 1
// Checksum 0x85ca1aa1, Offset: 0x1aa8
// Size: 0xc6
function tesla_blockers_fx( org )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    for ( i = 0; i < org.objects.size ; i++ )
    {
        if ( isdefined( org.objects[ i ] ) )
        {
            org.objects[ i ] thread doa_fx::function_285a2999( "tesla_trail" );
            org.objects[ i ] thread doa_fx::function_285a2999( "tesla_ball" );
        }
    }
}

// Namespace doa_tesla
// Params 0
// Checksum 0x44d991c9, Offset: 0x1b78
// Size: 0x92c
function tesla_blockers_update()
{
    note = doa_utility::function_2ccf4b82( "end_tesla_pickup" );
    self endon( note );
    self thread tesla_discharge_mechanic();
    
    if ( !mayspawnentity() )
    {
        return;
    }
    
    org = spawn( "script_model", self.origin );
    org.targetname = "tesla_blockers_update";
    org.angles = ( 0, randomint( 180 ), 0 );
    org.triggers = [];
    org.objects = [];
    def = doa_pickups::function_bac08508( 6 );
    self.doa.tesla_blockers = org;
    org setmodel( "tag_origin" );
    org linkto( self, "tag_origin" );
    
    if ( mayspawnentity() && mayspawnfakeentity() )
    {
        tesla = spawn( "script_model", self.origin );
        tesla.targetname = "teslaball1";
        tesla setmodel( level.doa.var_f6e22ab8 );
        tesla setscale( def.scale );
        tesla linkto( org, "tag_origin", ( 0, 60, 50 ) );
        trigger = spawn( "trigger_radius", tesla.origin, 9, 18, 50 );
        trigger.targetname = "tesla1";
        trigger enablelinkto();
        trigger linkto( tesla );
        trigger thread tesla_blockers_damage_trigger( self, note );
        org.objects[ org.objects.size ] = tesla;
        org.triggers[ org.triggers.size ] = trigger;
    }
    
    if ( mayspawnentity() && mayspawnfakeentity() )
    {
        tesla = spawn( "script_model", self.origin );
        tesla.targetname = "teslaball2";
        tesla setmodel( level.doa.var_f6e22ab8 );
        tesla setscale( def.scale );
        tesla linkto( org, "tag_origin", ( 0, -60, 50 ) );
        trigger = spawn( "trigger_radius", tesla.origin, 9, 18, 50 );
        trigger.targetname = "tesla2";
        trigger enablelinkto();
        trigger linkto( tesla );
        trigger thread tesla_blockers_damage_trigger( self, note );
        org.objects[ org.objects.size ] = tesla;
        org.triggers[ org.triggers.size ] = trigger;
    }
    
    if ( mayspawnentity() && mayspawnfakeentity() )
    {
        tesla = spawn( "script_model", self.origin );
        tesla.targetname = "teslaball3";
        tesla setmodel( level.doa.var_f6e22ab8 );
        tesla setscale( def.scale );
        tesla linkto( org, "tag_origin", ( 60, 0, 50 ) );
        trigger = spawn( "trigger_radius", tesla.origin, 9, 18, 50 );
        trigger.targetname = "tesla3";
        trigger enablelinkto();
        trigger linkto( tesla );
        trigger thread tesla_blockers_damage_trigger( self, note );
        org.objects[ org.objects.size ] = tesla;
        org.triggers[ org.triggers.size ] = trigger;
    }
    
    if ( mayspawnentity() && mayspawnfakeentity() )
    {
        tesla = spawn( "script_model", self.origin );
        tesla.targetname = "teslaball4";
        tesla setmodel( level.doa.var_f6e22ab8 );
        tesla setscale( def.scale );
        tesla linkto( org, "tag_origin", ( -60, 0, 50 ) );
        trigger = spawn( "trigger_radius", tesla.origin, 9, 18, 50 );
        trigger.targetname = "tesla4";
        trigger enablelinkto();
        trigger linkto( tesla );
        trigger thread tesla_blockers_damage_trigger( self, note );
        org.objects[ org.objects.size ] = tesla;
        org.triggers[ org.triggers.size ] = trigger;
    }
    
    util::wait_network_frame();
    self thread tesla_blockers_move( org, note );
    self thread tesla_blockers_fx( org );
    self thread tesla_blockers_deletion_monitors( org, note );
    self thread tesla_blockers_timeout( org, note );
    self thread tesla_blockers_cleanup( org, note );
    org thread function_89843a06( self );
}

