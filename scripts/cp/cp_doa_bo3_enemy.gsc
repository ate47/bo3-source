#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/cp_doa_bo3_fx;
#using scripts/cp/cp_doa_bo3_sound;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_enemy_boss;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/util_shared;

#namespace bo3_enemy;

// Namespace bo3_enemy
// Params 0
// Checksum 0xa727e1b2, Offset: 0xce0
// Size: 0x8c
function init()
{
    behaviortreenetworkutility::registerbehaviortreescriptapi( "doaWarlordShouldSDoSpecial", &doaWarlordShouldSDoSpecial );
    behaviortreenetworkutility::registerbehaviortreeaction( "doaWarlordSpecialAction", &function_c9e4e727, &function_c238a312, undefined );
    behaviortreenetworkutility::registerbehaviortreescriptapi( "doaWarlordUpdateToGoal", &doaWarlordUpdateToGoal );
}

// Namespace bo3_enemy
// Params 2
// Checksum 0xd6022e23, Offset: 0xd78
// Size: 0x7b4
function function_65762352( classname, var_3a9f2119 )
{
    if ( !isdefined( level.doa.enemyspawners ) )
    {
        level.doa.enemyspawners = getspawnerarray();
    }
    
    if ( !isdefined( var_3a9f2119 ) )
    {
        foreach ( spawner in level.doa.enemyspawners )
        {
            if ( isdefined( spawner.archetype ) && spawner.archetype == classname || spawner.classname == "script_vehicle" && issubstr( spawner.vehicletype, classname ) )
            {
                var_3a9f2119 = spawner;
                break;
            }
            
            if ( spawner.classname == classname )
            {
                var_3a9f2119 = spawner;
                break;
            }
            
            if ( isdefined( spawner.script_parameters ) )
            {
                type = strtok( spawner.script_parameters, ":" );
                
                if ( classname == type[ 1 ] )
                {
                    var_3a9f2119 = spawner;
                    break;
                }
            }
        }
    }
    
    if ( isdefined( var_3a9f2119 ) )
    {
        def = spawnstruct();
        def.var_83bae1f8 = 4000;
        def.maxhitpoints = 4000;
        def.forcespawn = 1;
        spots = doa_utility::function_308fa126( 32 );
        loc = spawnstruct();
        
        if ( isdefined( spots ) && spots.size > 0 )
        {
            loc.origin = spots[ randomint( spots.size ) ];
        }
        else
        {
            return;
        }
        
        loc.angles = ( 0, 0, 0 );
        
        if ( issubstr( classname, "spider" ) )
        {
            function_ee2c4b95( var_3a9f2119, loc, def );
            return;
        }
        
        if ( issubstr( classname, "smokeman" ) )
        {
            function_b9980eda( var_3a9f2119, loc, def );
            return;
        }
        
        if ( issubstr( classname, "parasite_purple" ) )
        {
            function_33525e11( var_3a9f2119, loc, def );
            return;
        }
        
        if ( issubstr( classname, "parasite" ) )
        {
            function_1631202b( var_3a9f2119, loc, def );
            return;
        }
        
        if ( issubstr( classname, "meatball" ) )
        {
            function_fb051310( var_3a9f2119, loc, def );
            return;
        }
        
        if ( issubstr( classname, "cellbreaker" ) )
        {
            function_5e86b6fa( var_3a9f2119, loc, def );
            return;
        }
        
        if ( issubstr( classname, "riser" ) )
        {
            function_45849d81( var_3a9f2119, loc, def );
            return;
        }
        
        if ( issubstr( classname, "skeleton" ) )
        {
            doa_enemy::function_a4e16560( getent( "spawner_zombietron_skeleton", "targetname" ), loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
            return;
        }
        
        if ( issubstr( classname, "collector" ) )
        {
            function_53b44cb7( spawner, loc, def, 1 );
            return;
        }
        
        if ( issubstr( classname, "mannequin_female" ) )
        {
            function_92159541( spawner, loc, def );
            return;
        }
        
        if ( issubstr( classname, "basic" ) )
        {
            doa_enemy::function_a4e16560( getent( "doa_basic_spawner", "targetname" ), loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
            return;
        }
        
        if ( issubstr( classname, "warlord" ) )
        {
            function_a0d7d949( var_3a9f2119, loc, def );
            return;
        }
        
        if ( issubstr( classname, "_dog" ) )
        {
            function_bb3b0416( var_3a9f2119, loc, def );
            return;
        }
        
        if ( issubstr( classname, "_robot" ) )
        {
            function_4d2a4a76( var_3a9f2119, loc, def );
            return;
        }
        
        if ( issubstr( classname, "silverback" ) )
        {
            function_36aa8b6c( loc );
            return;
        }
        
        if ( issubstr( classname, "margwa" ) )
        {
            doa_enemy::function_a4e16560( getent( "doa_margwa_spawner", "targetname" ), loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
        }
    }
}

// Namespace bo3_enemy
// Params 1
// Checksum 0x450dfe93, Offset: 0x1538
// Size: 0x218
function function_36aa8b6c( loc )
{
    ai = doa_enemy::function_a4e16560( level.doa.var_55dddb3a, loc, 1 );
    
    if ( isdefined( ai ) )
    {
        ai.spawner = level.doa.var_55dddb3a;
        ai.team = "axis";
        ai.boss = 1;
        ai.health = getdvarint( "scr_boss_silverback_health", 2000000 );
        ai.maxhealth = ai.health;
        ai.ignorevortices = 1;
        ai.non_zombie = 1;
        ai.takedamage = 0;
        ai.meleedamage = 20000;
        ai doa_fx::function_285a2999( "cyber_eye" );
        ai forceteleport( loc.origin, loc.angles );
        ai notify( #"hash_10fd80ee" );
        ai notify( #"hash_6e8326fc" );
        ai notify( #"hash_6dcbb83e" );
        ai notify( #"hash_d96c599c" );
        ai notify( #"hash_48b8c577" );
        ai notify( #"hash_67a97d62" );
        
        if ( isdefined( level.doa.var_2836c8ee ) && level.doa.var_2836c8ee )
        {
            ai thread doa_fx::function_285a2999( "spawnZombie" );
        }
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 3
// Checksum 0x11676b75, Offset: 0x1758
// Size: 0x200
function function_a0d7d949( spawner, loc, def )
{
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
    
    if ( isdefined( ai ) )
    {
        ai.spawner = spawner;
        ai.team = "axis";
        ai.health = def.var_83bae1f8 + 150 * level.doa.round_number;
        
        if ( isdefined( def.maxhitpoints ) && ai.health > def.maxhitpoints )
        {
            ai.health = def.maxhitpoints;
        }
        
        ai.maxhealth = ai.health;
        ai.ignorevortices = 1;
        ai.non_zombie = 1;
        ai.var_55361ee6 = randomint( 3 );
        ai.nextspecial = 0;
        ai.doa.var_da2f5272 = 1;
        
        if ( isdefined( level.doa.var_2836c8ee ) && level.doa.var_2836c8ee )
        {
            ai thread doa_fx::function_285a2999( "spawnZombie" );
        }
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 3
// Checksum 0xd9f3c085, Offset: 0x1960
// Size: 0x288
function function_bb3b0416( spawner, loc, def )
{
    spawn_set = level.doa.arenas[ level.doa.current_arena ].name + "_enemy_spawn";
    
    if ( level.doa.spawners[ spawn_set ][ "wolf" ].size == 0 )
    {
        return;
    }
    
    loc = level.doa.spawners[ spawn_set ][ "wolf" ][ randomint( level.doa.spawners[ spawn_set ][ "wolf" ].size ) ];
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
    
    if ( isdefined( ai ) )
    {
        ai.spawner = spawner;
        ai.team = "axis";
        ai.health = def.var_83bae1f8 + 150 * level.doa.round_number;
        ai.meleedamage = 50;
        
        if ( isdefined( def.maxhitpoints ) && ai.health > def.maxhitpoints )
        {
            ai.health = def.maxhitpoints;
        }
        
        ai.maxhealth = ai.health;
        ai.non_zombie = 1;
        ai.var_d538832c = 1;
        
        if ( isdefined( level.doa.var_2836c8ee ) && level.doa.var_2836c8ee )
        {
            ai thread doa_fx::function_285a2999( "spawnZombie" );
        }
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 3
// Checksum 0x52adf71, Offset: 0x1bf0
// Size: 0x318
function function_92159541( spawner, loc, def )
{
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
    
    if ( isdefined( ai ) )
    {
        ai.spawner = spawner;
        ai.team = "axis";
        ai.health = def.var_83bae1f8 + 150 * level.doa.round_number;
        
        if ( isdefined( def.maxhitpoints ) && ai.health > def.maxhitpoints )
        {
            ai.health = def.maxhitpoints;
        }
        
        ai.maxhealth = ai.health;
        ai.ignorevortices = 1;
        ai.non_zombie = 1;
        ai.var_de3055b5 = 1;
        ai.ignoreall = 1;
        ai.doa.var_da2f5272 = 1;
        
        if ( isdefined( level.doa.var_2836c8ee ) && level.doa.var_2836c8ee )
        {
            ai thread doa_fx::function_285a2999( "spawnZombie" );
        }
        
        ai thread doa_fx::function_285a2999( "blue_eyes" );
        spots = doa_utility::function_8fc4387a( 32 );
        ai.var_8f12ed02 = spots[ randomint( spots.size ) ].origin;
        ai setgoal( ai.var_8f12ed02 );
        ai notify( #"hash_6e8326fc" );
        ai notify( #"hash_d96c599c" );
        ai thread function_8b898788();
        ai thread function_471897();
        ai thread function_b18c6347();
        ai thread function_d4107a2a();
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 0
// Checksum 0x6735a9cc, Offset: 0x1f10
// Size: 0x2a8
function function_8b898788()
{
    self.damage_trigger = spawn( "trigger_radius", self.origin, 3, 40, 50 );
    self.damage_trigger endon( #"death" );
    self.damage_trigger thread doa_utility::function_981c685d( self );
    self.damage_trigger enablelinkto();
    self.damage_trigger linkto( self );
    
    while ( isdefined( self ) )
    {
        self.damage_trigger waittill( #"trigger", guy );
        
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( guy == self )
        {
            continue;
        }
        
        if ( isdefined( guy.var_de3055b5 ) && guy.var_de3055b5 )
        {
            continue;
        }
        
        if ( isdefined( guy.boss ) && guy.boss )
        {
            continue;
        }
        
        if ( guy.health <= 0 || !( isdefined( guy.takedamage ) && guy.takedamage ) )
        {
            continue;
        }
        
        if ( isvehicle( guy ) )
        {
            continue;
        }
        
        guy thread doa_sound::function_90118d8c( "zmb_hazard_hit" );
        guy thread doa_fx::function_285a2999( "hazard_electric" );
        
        if ( !isplayer( guy ) )
        {
            dir = guy.origin - self.damage_trigger.origin;
            dir = vectornormalize( dir );
            guy launchragdoll( dir * 100 );
        }
        
        util::wait_network_frame();
        
        if ( isdefined( guy ) )
        {
            guy.tesla_death = 1;
            guy dodamage( guy.health + 500, guy.origin );
        }
    }
}

// Namespace bo3_enemy
// Params 0
// Checksum 0x685a7769, Offset: 0x21c0
// Size: 0x90
function function_b18c6347()
{
    self endon( #"death" );
    self thread doa_fx::function_285a2999( "player_shield_short" );
    self thread doa_fx::function_285a2999( "electrical_surge" );
    invultime = gettime() + 3000;
    
    while ( gettime() < invultime )
    {
        self.takedamage = 0;
        wait 0.05;
    }
    
    self.takedamage = 1;
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xc58096f4, Offset: 0x2258
// Size: 0x1f4
function function_d4107a2a()
{
    self endon( #"death" );
    
    while ( !self isatgoal() )
    {
        wait 0.05;
    }
    
    self thread doa_fx::function_285a2999( "tesla_shock_eyes" );
    self thread doa_sound::function_90118d8c( "zmb_hazard_hit" );
    self thread doa_fx::function_285a2999( "hazard_electric" );
    wait 1;
    self thread doa_sound::function_90118d8c( "zmb_hazard_hit" );
    self thread doa_fx::function_285a2999( "hazard_electric" );
    wait 1;
    self thread doa_sound::function_90118d8c( "zmb_hazard_hit" );
    self thread doa_fx::function_285a2999( "hazard_electric" );
    wait 1;
    self thread doa_sound::function_90118d8c( "zmb_hazard_hit" );
    self thread doa_fx::function_285a2999( "hazard_electric" );
    wait 1;
    self thread doa_sound::function_90118d8c( "zmb_hazard_hit" );
    self thread doa_fx::function_285a2999( "hazard_electric" );
    level thread function_7517e6b7( self.origin );
    self.takedamage = 1;
    self.tesla_death = 1;
    self dodamage( self.health + 501, self.origin );
}

// Namespace bo3_enemy
// Params 1
// Checksum 0x29b941f8, Offset: 0x2458
// Size: 0x30c
function function_7517e6b7( origin )
{
    level endon( #"exit_taken" );
    
    if ( !mayspawnentity() )
    {
        return;
    }
    
    if ( !mayspawnfakeentity() )
    {
        return;
    }
    
    if ( isdefined( level.doa.var_2f019708 ) && level.doa.var_2f019708 && level.doa.hazards.size > 30 )
    {
        return;
    }
    
    if ( !isdefined( level.doa.var_f6ba7ed2 ) )
    {
        return;
    }
    
    origin = doa_hazard::function_3341776e( origin );
    
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    hazard = spawn( "script_model", origin + ( 0, 0, -120 ) );
    level.doa.hazards[ level.doa.hazards.size ] = hazard;
    hazard.targetname = "hazard";
    hazard setmodel( level.doa.var_f6ba7ed2.model );
    hazard.def = level.doa.var_f6ba7ed2;
    hazard.hazard_type = 3;
    hazard thread function_b3a0f63();
    hazard moveto( origin, 2 );
    playsoundatposition( "evt_pole", hazard.origin );
    
    if ( isdefined( level.doa.var_f6ba7ed2.width ) && isdefined( level.doa.var_f6ba7ed2.height ) )
    {
        hazard.trigger = spawn( "trigger_radius", origin, 3, level.doa.var_f6ba7ed2.width, level.doa.var_f6ba7ed2.height );
        
        if ( !isdefined( hazard.trigger ) )
        {
            hazard delete();
            return;
        }
        
        hazard.trigger.targetname = "hazard";
    }
    
    wait 2;
    
    if ( isdefined( hazard ) )
    {
        hazard thread doa_hazard::function_5d31907f();
    }
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xcd0676c4, Offset: 0x2770
// Size: 0x34
function function_471897()
{
    self waittill( #"death" );
    
    if ( isdefined( self.damage_trigger ) )
    {
        self.damage_trigger delete();
    }
}

// Namespace bo3_enemy
// Params 0
// Checksum 0x98e565d1, Offset: 0x27b0
// Size: 0x80
function function_b3a0f63()
{
    self endon( #"death" );
    self endon( #"movedone" );
    timeout = gettime() + 2100;
    
    while ( gettime() < timeout )
    {
        self thread doa_fx::function_285a2999( "tesla_shock" );
        wait randomfloatrange( 0.1, 0.4 );
    }
}

// Namespace bo3_enemy
// Params 3
// Checksum 0xecd9eeda, Offset: 0x2838
// Size: 0x1c8
function function_5e86b6fa( spawner, loc, def )
{
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
    
    if ( isdefined( ai ) )
    {
        ai.spawner = spawner;
        ai.team = "axis";
        
        if ( isdefined( def ) )
        {
            ai.health = def.var_83bae1f8 + 150 * level.doa.round_number;
            
            if ( isdefined( def.maxhitpoints ) && ai.health > def.maxhitpoints )
            {
                ai.health = def.maxhitpoints;
            }
        }
        
        ai.zombie_move_speed = "walk";
        ai.ignorevortices = 1;
        ai.maxhealth = ai.health;
        ai.doa.var_da2f5272 = 1;
        ai thread droptoground();
        ai thread function_9a5d69ac();
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 5
// Checksum 0xe7feee9a, Offset: 0x2a08
// Size: 0x594
function droptoground( origin, trailfx, impactfx, var_96214f04, var_7c5f2b05 )
{
    if ( !isdefined( impactfx ) )
    {
        impactfx = "turret_impact";
    }
    
    if ( !isdefined( var_96214f04 ) )
    {
        var_96214f04 = 1;
    }
    
    if ( !isdefined( var_7c5f2b05 ) )
    {
        var_7c5f2b05 = 1;
    }
    
    self endon( #"death" );
    self.dropping = 1;
    self.ignoreall = 1;
    
    if ( !isdefined( origin ) )
    {
        goalpoints = doa_utility::function_308fa126( 10 );
        goalpoint = goalpoints[ randomint( goalpoints.size ) ];
    }
    else
    {
        goalpoint = origin;
    }
    
    if ( var_7c5f2b05 )
    {
        dst = spawn( "script_model", goalpoint + ( randomfloatrange( -100, 100 ), randomfloatrange( -100, 100 ), 0 ) + ( 0, 0, 12 ) );
    }
    else
    {
        dst = spawn( "script_model", goalpoint + ( 0, 0, 12 ) );
    }
    
    dst.targetname = "dropToGround";
    dst setmodel( "tag_origin" );
    dst.angles = ( 0, randomint( 180 ), 0 );
    
    if ( isdefined( var_96214f04 ) && var_96214f04 )
    {
        dst thread doa_fx::function_285a2999( "incoming_impact" );
    }
    
    dst thread doa_utility::function_1bd67aef( 3 );
    pos = dst.origin + ( 0, 0, 2000 );
    
    if ( isactor( self ) )
    {
        self forceteleport( pos, dst.angles );
    }
    else
    {
        self.origin = pos;
    }
    
    org = spawn( "script_model", pos );
    org.targetname = "dropToGroundOrg";
    org setmodel( "tag_origin" );
    
    if ( isdefined( trailfx ) )
    {
        org thread doa_fx::function_285a2999( trailfx );
    }
    
    org thread doa_utility::function_1bd67aef( 2 );
    self enablelinkto();
    org enablelinkto();
    self linkto( org, "tag_origin" );
    org moveto( dst.origin, 1.2 );
    org thread doa_sound::function_90118d8c( "zmb_enemy_incoming" );
    org util::waittill_any_timeout( 1.5, "movedone" );
    org thread doa_sound::function_90118d8c( "zmb_enemy_impact" );
    physicsexplosionsphere( dst.origin, 200, 128, 3 );
    playrumbleonposition( "grenade_rumble", dst.origin );
    self unlink();
    
    if ( isactor( self ) )
    {
        self forceteleport( dst.origin, dst.angles );
    }
    else
    {
        self.origin = dst.origin;
    }
    
    dst thread doa_fx::function_285a2999( impactfx );
    util::wait_network_frame();
    self.ignoreall = 0;
    self.dropping = undefined;
    
    if ( isdefined( org ) )
    {
        org delete();
    }
    
    if ( isdefined( dst ) )
    {
        dst delete();
    }
}

// Namespace bo3_enemy
// Params 0, eflags: 0x4
// Checksum 0x3c24fbb8, Offset: 0x2fa8
// Size: 0x94
function private function_9a5d69ac()
{
    self endon( #"death" );
    self.zombie_move_speed = "walk";
    self util::waittill_any_timeout( 30, "damage" );
    
    if ( level.players.size == 1 && self.zombie_move_speed == "sprint" )
    {
        self thread doa_utility::function_ba30b321( 30 );
    }
    
    self.zombie_move_speed = "sprint";
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xbff6a035, Offset: 0x3048
// Size: 0x74
function function_a1f1cd46()
{
    self waittill( #"death" );
    
    if ( isdefined( self ) && isdefined( self.origin ) )
    {
        physicsexplosionsphere( self.origin, 128, 128, 2 );
        radiusdamage( self.origin, 48, 100, 100 );
    }
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xea51bfcd, Offset: 0x30c8
// Size: 0x8
function function_d45df351()
{
    return 125;
}

// Namespace bo3_enemy
// Params 3
// Checksum 0x8e0db57e, Offset: 0x30d8
// Size: 0x268
function function_4d2a4a76( spawner, loc, def )
{
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
    
    if ( isdefined( ai ) )
    {
        ai ai::set_behavior_attribute( "rogue_allow_pregib", 0 );
        ai.spawner = spawner;
        ai.health = def.var_83bae1f8 + 150 * level.doa.round_number;
        
        if ( isdefined( def.maxhitpoints ) && ai.health > def.maxhitpoints )
        {
            ai.health = def.maxhitpoints;
        }
        
        ai.maxhealth = ai.health;
        ai.non_zombie = 1;
        ai.ignorevortices = 1;
        ai.var_d538832c = 1;
        ai.custom_damage_func = &function_d45df351;
        ai ai::set_behavior_attribute( "rogue_control", "forced_level_3" );
        ai ai::set_behavior_attribute( "rogue_control_speed", "sprint" );
        ai.team = "axis";
        ai thread function_a1f1cd46();
        
        if ( isdefined( level.doa.var_2836c8ee ) && level.doa.var_2836c8ee )
        {
            ai thread doa_fx::function_285a2999( "spawnZombie" );
        }
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xa6655e47, Offset: 0x3348
// Size: 0x8
function function_d4213fbb()
{
    return 125;
}

// Namespace bo3_enemy
// Params 6
// Checksum 0x2a730891, Offset: 0x3358
// Size: 0x2f8
function function_fb051310( spawner, loc, def, droptoground, hp, force )
{
    if ( !isdefined( droptoground ) )
    {
        droptoground = 1;
    }
    
    if ( !isdefined( force ) )
    {
        force = 0;
    }
    
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : force || 0 );
    
    if ( isdefined( ai ) )
    {
        ai.team = "axis";
        
        if ( isdefined( def ) )
        {
            ai.health = def.var_83bae1f8;
        }
        else
        {
            ai.health = 1000;
        }
        
        ai.health += 150 * level.doa.round_number;
        
        if ( isdefined( hp ) )
        {
            ai.health = hp;
        }
        
        if ( isdefined( def ) && isdefined( def.maxhitpoints ) && ai.health > def.maxhitpoints )
        {
            ai.health = def.maxhitpoints;
        }
        
        ai.maxhealth = ai.health;
        ai.spawner = spawner;
        ai.var_ad61c13d = 1;
        ai.non_zombie = 1;
        ai.def = def;
        ai.untouchable = 1;
        ai.custom_damage_func = &function_d4213fbb;
        ai callback::add_callback( #"hash_acb66515", &function_7ebf419e );
        ai thread doa_utility::function_dbcf48a0( 1 );
        ai thread function_5f1a1e65( -50000 );
        
        if ( isdefined( droptoground ) && droptoground )
        {
            ai thread droptoground( undefined, "meatball_trail", "meatball_impact" );
        }
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 1
// Checksum 0xeaa22db, Offset: 0x3658
// Size: 0x58
function function_5f1a1e65( var_b48b7b5d )
{
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        if ( self.origin[ 2 ] <= var_b48b7b5d )
        {
            self delete();
        }
        
        wait 0.2;
    }
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xf084d199, Offset: 0x36b8
// Size: 0x374
function function_7ebf419e()
{
    if ( isdefined( self.var_802ce72 ) && self.var_802ce72 )
    {
        return;
    }
    
    if ( !isdefined( level.doa.var_b2669ad0 ) )
    {
        level.doa.var_b2669ad0 = [];
        level.doa.var_b2669ad0[ "medium" ] = getent( "spawner_meatball_med", "targetname" );
        level.doa.var_b2669ad0[ "small" ] = getent( "spawner_meatball_small", "targetname" );
    }
    
    loc = spawnstruct();
    loc.angles = self.angles;
    loc.origin = self.origin;
    loc.def = self.def;
    level cp_doa_bo3_fx::raps_explode_fx( loc.origin );
    
    if ( self.model == "veh_t7_drone_insanity_elemental_v2_large" )
    {
        function_fb051310( level.doa.var_b2669ad0[ "medium" ], loc, loc.def, 0, 600, 1 );
        loc.origin += ( randomfloatrange( -40, 40 ), randomfloatrange( -40, 40 ), 32 );
        level cp_doa_bo3_fx::raps_explode_fx( loc.origin );
        function_fb051310( level.doa.var_b2669ad0[ "medium" ], loc, loc.def, 0, 600, 1 );
        return;
    }
    
    if ( self.model == "veh_t7_drone_insanity_elemental_v2_med" )
    {
        function_fb051310( level.doa.var_b2669ad0[ "small" ], loc, loc.def, 0, 100, 1 );
        loc.origin += ( randomfloatrange( -40, 40 ), randomfloatrange( -40, 40 ), 32 );
        level cp_doa_bo3_fx::raps_explode_fx( loc.origin );
        function_fb051310( level.doa.var_b2669ad0[ "small" ], loc, loc.def, 0, 100, 1 );
    }
}

// Namespace bo3_enemy
// Params 0
// Checksum 0x3d065a00, Offset: 0x3a38
// Size: 0x54
function function_307cc86e()
{
    self endon( #"death" );
    self waittill( #"goal" );
    self setgoal( doa_arena::function_2a9d778d() + ( 0, 0, 42 ), 0 );
}

// Namespace bo3_enemy
// Params 3
// Checksum 0x389e16, Offset: 0x3a98
// Size: 0x3c8
function function_1631202b( spawner, loc, def )
{
    if ( isdefined( level.doa.arenas[ level.doa.current_arena ].var_fe390b01 ) && level.doa.arenas[ level.doa.current_arena ].var_fe390b01.size )
    {
        loc = level.doa.arenas[ level.doa.current_arena ].var_fe390b01[ randomint( level.doa.arenas[ level.doa.current_arena ].var_fe390b01.size ) ];
    }
    
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
    
    if ( isdefined( ai ) )
    {
        ai.team = "axis";
        
        if ( isdefined( def ) )
        {
            ai.health = def.var_83bae1f8 + 150 * level.doa.round_number;
            
            if ( isdefined( def.maxhitpoints ) && ai.health > def.maxhitpoints )
            {
                ai.health = def.maxhitpoints;
            }
        }
        else
        {
            ai.health = 100;
        }
        
        ai.maxhealth = ai.health;
        ai.spawner = spawner;
        ai.non_zombie = 1;
        ai.holdfire = 0;
        ai.var_b7e79322 = 1;
        ai.var_65e0af26 = 1;
        ai.var_ad61c13d = 1;
        ai.meleedamage = 0;
        ai.squelch_damage_overlay = 1;
        ai.goalradius = 512;
        goal = doa_arena::function_2a9d778d();
        spots = doa_utility::function_308fa126();
        
        if ( isdefined( spots ) && spots.size )
        {
            goal = spots[ randomint( spots.size ) ];
        }
        
        goal += ( 0, 0, 42 );
        ai setgoal( goal, 1 );
        ai.updatesight = 1;
        ai thread function_307cc86e();
        ai thread doa_fx::function_285a2999( "spawnZombie" );
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 3
// Checksum 0x53d36d3f, Offset: 0x3e68
// Size: 0x1b0
function function_ee2c4b95( spawner, loc, def )
{
    if ( !isdefined( spawner ) )
    {
        spawner = level.doa.var_4720602e;
    }
    
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
    
    if ( isdefined( ai ) )
    {
        ai.maxhealth = ai.health;
        ai.var_ad61c13d = 1;
        ai.non_zombie = 1;
        ai.var_f4795bf = 1;
        ai.meleedamage = 50;
        ai.squelch_damage_overlay = 1;
        ai.updatesight = 1;
        ai.team = "axis";
        ai.health = 2000 + 150 * level.doa.round_number;
        goal = doa_arena::function_2a9d778d();
        ai setgoal( goal );
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 1
// Checksum 0xc68da95d, Offset: 0x4020
// Size: 0xc2
function function_e59bd7c5( carrier )
{
    if ( !isdefined( level.doa.var_4720602e ) )
    {
        level.doa.var_4720602e = getent( "doa_spider", "targetname" );
    }
    
    loc = spawnstruct();
    loc.origin = carrier.origin;
    loc.angles = carrier.angles;
    return function_ee2c4b95( undefined, loc, undefined );
}

// Namespace bo3_enemy
// Params 0
// Checksum 0x3f9d4a00, Offset: 0x40f0
// Size: 0x5e
function function_3dc77ad7()
{
    origin = self.origin;
    self waittill( #"death" );
    
    /#
        doa_utility::debugmsg( "<dev string:x28>" + origin );
    #/
    
    level notify( #"hash_842cebcb", origin );
}

// Namespace bo3_enemy
// Params 0
// Checksum 0x5d8ecd76, Offset: 0x4158
// Size: 0x1c
function function_e4004164()
{
    self delete();
}

// Namespace bo3_enemy
// Params 0
// Checksum 0x1e5aa1e8, Offset: 0x4180
// Size: 0x88
function function_deb6cf13()
{
    self endon( #"death" );
    origin = self.origin;
    self.takedamage = 1;
    
    while ( true )
    {
        self waittill( #"damage", damage );
        
        /#
            doa_utility::debugmsg( "<dev string:x40>" + damage + "<dev string:x56>" + self.health );
        #/
    }
}

// Namespace bo3_enemy
// Params 1
// Checksum 0x99a75888, Offset: 0x4210
// Size: 0x94
function function_70320f4a( time )
{
    if ( !isdefined( time ) )
    {
        time = 5;
    }
    
    self endon( #"death" );
    self clientfield::set( "heartbeat", 7 );
    wait time;
    level notify( #"hash_842cebcb", self.origin );
    level thread function_e59bd7c5( self );
    self function_e4004164();
}

// Namespace bo3_enemy
// Params 1
// Checksum 0xa103aac6, Offset: 0x42b0
// Size: 0x134
function function_197752f7( lifetime )
{
    if ( !isdefined( lifetime ) )
    {
        lifetime = 15;
    }
    
    self endon( #"death" );
    self solid();
    self setmodel( "zombietron_spider_egg_invis" );
    self enableaimassist();
    self thread function_8fe0340c();
    self clientfield::set( "heartbeat", 6 );
    lifetime += randomint( lifetime >> 1 );
    self thread function_3dc77ad7();
    self thread function_e0df2a3e();
    self util::waittill_any_timeout( lifetime, "hatchNow" );
    self thread function_70320f4a();
}

// Namespace bo3_enemy
// Params 0
// Checksum 0x426dd6f7, Offset: 0x43f0
// Size: 0x44
function function_e0df2a3e()
{
    self thread doa_utility::function_783519c1( "opening_exits", 1 );
    self thread doa_utility::function_783519c1( "exit_taken", 1 );
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xadf7cacb, Offset: 0x4440
// Size: 0x80
function function_8fe0340c()
{
    self endon( #"death" );
    
    while ( true )
    {
        level waittill( #"hash_842cebcb", origin );
        distsq = distancesquared( self.origin, origin );
        
        if ( distsq < 72 * 72 )
        {
            self notify( #"hatchNow" );
            return;
        }
    }
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xa0d1af29, Offset: 0x44c8
// Size: 0x54
function function_517ce292()
{
    self waittill( #"death" );
    arrayremovevalue( level.doa.hazards, self );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace bo3_enemy
// Params 4
// Checksum 0xe764f91a, Offset: 0x4528
// Size: 0x258
function function_7512c5ee( spawner, loc, def, forced )
{
    if ( !isdefined( forced ) )
    {
        forced = 0;
    }
    
    canspawn = function_129ef3d();
    
    if ( !( isdefined( canspawn ) && canspawn ) )
    {
        return;
    }
    
    spawner = level.doa.var_c838db72[ randomint( level.doa.var_c838db72.size ) ];
    
    if ( !isdefined( spawner ) )
    {
        return;
    }
    
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
    
    if ( isdefined( ai ) )
    {
        ai.team = "axis";
        ai.health = ( isdefined( def ) ? def.var_83bae1f8 : 2000 ) + 150 * level.doa.round_number;
        
        if ( isdefined( def ) && isdefined( def.maxhitpoints ) && ai.health > def.maxhitpoints )
        {
            ai.health = def.maxhitpoints;
        }
        
        ai.maxhealth = ai.health;
        ai.non_zombie = 1;
        ai thread function_4c047459();
        
        if ( isdefined( level.doa.var_2836c8ee ) && level.doa.var_2836c8ee )
        {
            ai thread doa_fx::function_285a2999( "spawnZombie" );
        }
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xd7280b3, Offset: 0x4788
// Size: 0x1e, Type: bool
function function_129ef3d()
{
    if ( !mayspawnentity() )
    {
        return false;
    }
    
    return true;
}

// Namespace bo3_enemy
// Params 0
// Checksum 0x495ab5ba, Offset: 0x47b0
// Size: 0x1f4
function function_4c047459()
{
    self endon( #"death" );
    self.zombie_move_speed = "sprint";
    goalpoints = doa_utility::function_308fa126( 10 );
    goalpoint = goalpoints[ randomint( goalpoints.size ) ] + ( randomintrange( -80, 80 ), randomintrange( -80, 80 ), 0 );
    self.var_8f12ed02 = getclosestpointonnavmesh( goalpoint, 20, 16 );
    
    if ( !isdefined( self.var_8f12ed02 ) )
    {
        return;
    }
    
    egg = function_ecbf1358( self.origin, self.angles, 1 );
    egg linkto( self, "tag_origin", ( 0, 0, 54 ) );
    egg thread function_45f23318( self );
    self doa_enemy::function_d30fe558( self.var_8f12ed02, 1 );
    self waittill( #"goal" );
    self.var_8f12ed02 = undefined;
    
    if ( isdefined( egg ) )
    {
        egg unlink();
        egg.origin = self.origin + ( 0, 0, 8 );
        egg.angles = self.angles;
        egg thread function_197752f7();
    }
}

// Namespace bo3_enemy
// Params 3
// Checksum 0xfbf90d0e, Offset: 0x49b0
// Size: 0x1be
function function_ecbf1358( origin, angles, carried )
{
    if ( !isdefined( carried ) )
    {
        carried = 0;
    }
    
    if ( !mayspawnentity() )
    {
        return;
    }
    
    egg = spawn( "script_model", origin );
    egg.targetname = "zombietron_spider_egg";
    egg setmodel( "zombietron_spider_egg" );
    egg setscale( 0.5 );
    egg.death_func = &function_e4004164;
    egg.health = 2000;
    egg.takedamage = 1;
    egg.team = "axis";
    egg notsolid();
    egg thread function_517ce292();
    egg thread function_deb6cf13();
    egg.angles = angles;
    
    if ( !carried )
    {
        egg thread function_197752f7();
    }
    
    level.doa.hazards[ level.doa.hazards.size ] = egg;
    return egg;
}

// Namespace bo3_enemy
// Params 3
// Checksum 0xa9b05891, Offset: 0x4b78
// Size: 0x3b8
function function_33525e11( spawner, loc, def )
{
    if ( isdefined( level.doa.arenas[ level.doa.current_arena ].var_fe390b01 ) && level.doa.arenas[ level.doa.current_arena ].var_fe390b01.size )
    {
        loc = level.doa.arenas[ level.doa.current_arena ].var_fe390b01[ randomint( level.doa.arenas[ level.doa.current_arena ].var_fe390b01.size ) ];
    }
    
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
    
    if ( isdefined( ai ) )
    {
        ai.team = "axis";
        
        if ( isdefined( def ) )
        {
            ai.health = def.var_83bae1f8 + 150 * level.doa.round_number;
            
            if ( isdefined( def.maxhitpoints ) && ai.health > def.maxhitpoints )
            {
                ai.health = def.maxhitpoints;
            }
        }
        else
        {
            ai.health = 100;
        }
        
        ai.maxhealth = ai.health;
        ai.spawner = spawner;
        ai.non_zombie = 1;
        ai.var_b7e79322 = 1;
        ai.var_dcdf7239 = 1;
        ai.holdfire = 0;
        ai.meleedamage = 0;
        ai.squelch_damage_overlay = 1;
        ai.goalradius = 512;
        goal = doa_arena::function_2a9d778d();
        spots = doa_utility::function_308fa126();
        
        if ( isdefined( spots ) && spots.size )
        {
            goal = spots[ randomint( spots.size ) ];
        }
        
        goal += ( 0, 0, 42 );
        ai setgoal( goal, 1 );
        ai thread function_307cc86e();
        ai.updatesight = 1;
        ai thread doa_fx::function_285a2999( "spawnZombie" );
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 3
// Checksum 0xf77e3281, Offset: 0x4f38
// Size: 0x210
function function_ce9bce16( spawner, loc, def )
{
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
    
    if ( isdefined( ai ) )
    {
        ai.team = "axis";
        ai.health = def.var_83bae1f8 + 150 * level.doa.round_number;
        
        if ( isdefined( def.maxhitpoints ) && ai.health > def.maxhitpoints )
        {
            ai.health = def.maxhitpoints;
        }
        
        ai.maxhealth = ai.health;
        ai.spawner = spawner;
        ai.squelch_damage_overlay = 1;
        ai.goalradius = 64;
        
        if ( isdefined( level.doa.var_2836c8ee ) && level.doa.var_2836c8ee )
        {
            ai thread doa_fx::function_285a2999( "spawnZombie" );
        }
        
        if ( level.players.size == 1 && ai.zombie_move_speed == "sprint" )
        {
            ai thread doa_utility::function_ba30b321( randomintrange( 15, 30 ) );
        }
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 4
// Checksum 0x5864b6ec, Offset: 0x5150
// Size: 0x2c0
function function_b9980eda( spawner, loc, def, teleport )
{
    if ( !isdefined( teleport ) )
    {
        teleport = 1;
    }
    
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
    
    if ( isdefined( ai ) )
    {
        ai.team = "axis";
        
        if ( isdefined( def ) )
        {
            ai.health = def.var_83bae1f8 + 150 * level.doa.round_number;
            
            if ( isdefined( def.maxhitpoints ) && ai.health > def.maxhitpoints )
            {
                ai.health = def.maxhitpoints;
            }
        }
        else
        {
            ai.health = 2000 + 150 * level.doa.round_number;
        }
        
        ai.maxhealth = ai.health;
        ai.spawner = spawner;
        ai.squelch_damage_overlay = 1;
        ai.goalradius = 64;
        ai.teleports = randomint( 2 ) + 1;
        ai.var_2ea42113 = 20;
        ai.nofire = 1;
        ai.non_zombie = 1;
        ai.zombie_move_speed = "sprint";
        ai.no_ragdoll = 1;
        aiutility::addaioverridedamagecallback( ai, &function_c1b5c042 );
        
        if ( isdefined( teleport ) && teleport )
        {
            ai thread shadowteleportmenow( 1 );
            ai playloopsound( "zmb_smokeman_looper" );
        }
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 2
// Checksum 0xe80376f1, Offset: 0x5418
// Size: 0x100
function function_ef4fa49d( &spots, mindist )
{
    if ( !isdefined( mindist ) )
    {
        mindist = 300;
    }
    
    mindistsq = mindist * mindist;
    newspots = [];
    
    foreach ( spot in spots )
    {
        if ( distancesquared( spot.origin, self.origin ) >= mindistsq )
        {
            newspots[ newspots.size ] = spot;
        }
    }
    
    return newspots;
}

// Namespace bo3_enemy
// Params 1
// Checksum 0x9af476a2, Offset: 0x5520
// Size: 0x482
function shadowteleportmenow( initial )
{
    if ( !isdefined( initial ) )
    {
        initial = 0;
    }
    
    self endon( #"death" );
    
    if ( isdefined( self.intransition ) )
    {
        return;
    }
    
    self.intransition = 1;
    
    if ( !initial )
    {
        self.teleports--;
    }
    
    spots = doa_utility::function_8fc4387a( 20 );
    var_5eccf055 = function_ef4fa49d( spots );
    
    if ( var_5eccf055.size > 0 )
    {
        if ( var_5eccf055.size == 1 )
        {
            goal = var_5eccf055[ 0 ];
        }
        else
        {
            goal = var_5eccf055[ randomint( var_5eccf055.size ) ];
        }
    }
    
    if ( !isdefined( goal ) )
    {
        goal = arraygetfarthest( self.origin, spots );
    }
    
    self.ignoreall = 1;
    self.takedamage = 0;
    self thread doa_fx::function_285a2999( "shadow_fade" );
    wait 0.1;
    org = spawn( "script_model", self.origin + ( 0, 0, 40 ) );
    org setmodel( "tag_origin" );
    org.takedamage = 0;
    org.targetname = "shadowTeleportMeNow";
    org thread doa_utility::function_981c685d( self );
    org.teleports = self.teleports;
    org.spawner = self.spawner;
    org thread doa_fx::function_285a2999( "shadow_move" );
    org thread doa_fx::function_285a2999( "shadow_glow" );
    org thread doa_sound::function_90118d8c( "zmb_enemy_smokeman_poof" );
    wait 0.3;
    self ghost();
    self notsolid();
    self setplayercollision( 0 );
    self linkto( org );
    org moveto( goal.origin + ( 0, 0, 40 ), 2 );
    org util::waittill_any_timeout( 2.1, "movedone" );
    org thread doa_fx::function_285a2999( "shadow_appear" );
    wait 1;
    org thread doa_sound::function_90118d8c( "zmb_enemy_smokeman_wings" );
    wait 1;
    self thread doa_sound::function_90118d8c( "zmb_enemy_smokeman_poof" );
    self unlink();
    self forceteleport( org.origin );
    self show();
    self solid();
    self setplayercollision( 1 );
    self thread doa_fx::function_285a2999( "spawnZombie" );
    org delete();
    wait 1;
    self.ignoreall = 0;
    self.takedamage = 1;
    self.intransition = undefined;
}

// Namespace bo3_enemy
// Params 15
// Checksum 0x412482d2, Offset: 0x59b0
// Size: 0x148
function function_c1b5c042( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal )
{
    if ( self.teleports > 0 )
    {
        if ( idamage >= self.health )
        {
            idamage = self.health - 1;
        }
        
        self thread shadowteleportmenow();
    }
    
    if ( self.health == 1 )
    {
        self thread doa_fx::function_285a2999( "shadow_die" );
        self show();
        self.takedamage = 0;
        self.aioverridedamage = undefined;
        self thread doa_utility::function_ba30b321( 0.1, eattacker, smeansofdeath );
    }
    
    return idamage;
}

// Namespace bo3_enemy
// Params 2
// Checksum 0x647c8e47, Offset: 0x5b00
// Size: 0x44
function function_575e3933( spawner, loc )
{
    ai = doa_enemy::function_a4e16560( spawner, loc, 1 );
    return ai;
}

// Namespace bo3_enemy
// Params 2
// Checksum 0xa2af06d0, Offset: 0x5b50
// Size: 0x68
function function_862e15fa( spawner, loc )
{
    ai = doa_enemy::function_a4e16560( spawner, loc, 1 );
    
    if ( isdefined( ai ) )
    {
        ai thread function_b6d31d3a( loc );
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 3
// Checksum 0x47b5cd81, Offset: 0x5bc0
// Size: 0x280
function function_17de14f1( spawner, loc, def )
{
    if ( !isdefined( level.doa.var_e0d67a74 ) || level.doa.var_e0d67a74.size == 0 )
    {
        return;
    }
    
    loc = level.doa.var_e0d67a74[ randomint( level.doa.var_e0d67a74.size ) ];
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
    
    if ( isdefined( ai ) )
    {
        ai thread function_b6d31d3a( loc, 0, "zombie_bloodriser_fx" );
        ai.spawner = spawner;
        ai.team = "axis";
        ai.var_ad61c13d = 1;
        
        if ( isdefined( def ) )
        {
            ai.health = def.var_83bae1f8 + 150 * level.doa.round_number;
            
            if ( isdefined( def.maxhitpoints ) && ai.health > def.maxhitpoints )
            {
                ai.health = def.maxhitpoints;
            }
        }
        
        ai.maxhealth = ai.health;
        
        if ( ai.zombie_move_speed == "walk" )
        {
            ai.zombie_move_speed = "run";
        }
        
        if ( level.players.size == 1 && ai.zombie_move_speed == "sprint" )
        {
            ai thread doa_utility::function_ba30b321( randomintrange( 15, 30 ) );
        }
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 3
// Checksum 0x1c56757d, Offset: 0x5e48
// Size: 0x358
function function_45849d81( spawner, loc, def )
{
    if ( !isdefined( loc ) && level.doa.var_e0d67a74.size == 0 )
    {
        return undefined;
    }
    
    if ( isdefined( level.doa.var_d0cde02c ) && isdefined( def ) && level.doa.var_d0cde02c == def )
    {
        loc = undefined;
        
        if ( !( isdefined( def.initialized ) && def.initialized ) )
        {
            level thread function_28cdab69( def );
        }
    }
    
    if ( !isdefined( loc ) )
    {
        loc = level.doa.var_e0d67a74[ randomint( level.doa.var_e0d67a74.size ) ];
    }
    
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
    
    if ( isdefined( ai ) )
    {
        var_8e0955df = 0;
        
        if ( isdefined( level.doa.var_d0cde02c ) && isdefined( def ) && level.doa.var_d0cde02c == def )
        {
            level thread function_be745286( def, ai );
            var_8e0955df = 1;
        }
        
        ai thread function_b6d31d3a( loc, var_8e0955df );
        ai.spawner = spawner;
        ai.team = "axis";
        
        if ( isdefined( def ) )
        {
            ai.health = def.var_83bae1f8 + 150 * level.doa.round_number;
            
            if ( isdefined( def.maxhitpoints ) && ai.health > def.maxhitpoints )
            {
                ai.health = def.maxhitpoints;
            }
        }
        
        ai.maxhealth = ai.health;
        
        if ( ai.zombie_move_speed == "walk" )
        {
            ai.zombie_move_speed = "run";
        }
        
        if ( level.players.size == 1 && ai.zombie_move_speed == "sprint" )
        {
            ai thread doa_utility::function_ba30b321( randomintrange( 15, 30 ) );
        }
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 1, eflags: 0x4
// Checksum 0xbc4259cb, Offset: 0x61a8
// Size: 0x15e
function private function_28cdab69( def )
{
    def.initialized = 1;
    def.var_40c7a009 = 0;
    targetsize = level.doa.var_e0d67a74.size;
    
    while ( level flag::get( "doa_round_spawning" ) && !level flag::get( "doa_game_is_over" ) )
    {
        maxwait = 10000 + gettime();
        
        while ( gettime() < maxwait && def.var_40c7a009 < targetsize && !level flag::get( "doa_game_is_over" ) && flag::get( "doa_round_spawning" ) )
        {
            wait 0.1;
        }
        
        targetsize = int( targetsize * 0.9 );
        level notify( #"hash_36d5bf57" );
        wait 5;
    }
    
    level notify( #"hash_36d5bf57" );
}

// Namespace bo3_enemy
// Params 2, eflags: 0x4
// Checksum 0xd3bca543, Offset: 0x6310
// Size: 0x3c
function private function_1ee8b18c( def, ai )
{
    ai endon( #"hash_9757351b" );
    ai waittill( #"death" );
    def.var_40c7a009--;
}

// Namespace bo3_enemy
// Params 2, eflags: 0x4
// Checksum 0xa70a5c0d, Offset: 0x6358
// Size: 0xa4
function private function_be745286( def, ai )
{
    ai endon( #"death" );
    ai thread function_1ee8b18c( def, ai );
    def.var_40c7a009++;
    ai.ignoreall = 1;
    level waittill( #"hash_36d5bf57" );
    
    if ( isdefined( ai ) )
    {
        ai notify( #"hash_9757351b" );
        ai.ignoreall = 0;
        def.var_40c7a009--;
    }
}

// Namespace bo3_enemy
// Params 4, eflags: 0x4
// Checksum 0xc692fa53, Offset: 0x6408
// Size: 0x292
function private function_b6d31d3a( spot, hold, fx, var_3d98e879 )
{
    if ( !isdefined( hold ) )
    {
        hold = 0;
    }
    
    if ( !isdefined( fx ) )
    {
        fx = "zombie_riser_fx";
    }
    
    if ( !isdefined( var_3d98e879 ) )
    {
        var_3d98e879 = "ai_zombie_traverse_ground_climbout_fast";
    }
    
    self endon( #"death" );
    self.rising = 1;
    self.anchor = spawn( "script_origin", self.origin );
    self.anchor thread doa_utility::function_981c685d( self );
    self.anchor.angles = self.angles;
    self linkto( self.anchor );
    
    if ( !isdefined( spot.angles ) )
    {
        spot.angles = ( 0, 0, 0 );
    }
    
    self ghost();
    self notsolid();
    
    if ( hold )
    {
        level waittill( #"hash_36d5bf57" );
    }
    
    wait randomfloatrange( 0, 0.25 );
    self unlink();
    
    if ( isdefined( self.anchor ) )
    {
        self.anchor delete();
    }
    
    self thread function_2f0633b5();
    level thread function_7c9f5521( self, spot );
    self clientfield::set( fx, 1 );
    self orientmode( "face default" );
    self animscripted( "rise_anim", self.origin, self.angles, var_3d98e879 );
    self waittill( #"end" );
    self solid();
    self notify( #"rise_anim_finished" );
    self.rising = undefined;
}

// Namespace bo3_enemy
// Params 0, eflags: 0x4
// Checksum 0xe4a672c1, Offset: 0x66a8
// Size: 0x34
function private function_2f0633b5()
{
    self endon( #"death" );
    wait 0.5;
    
    if ( isdefined( self ) )
    {
        self show();
    }
}

// Namespace bo3_enemy
// Params 2, eflags: 0x4
// Checksum 0x36c88a16, Offset: 0x66e8
// Size: 0xa4
function private function_7c9f5521( zombie, spot )
{
    zombie endon( #"rise_anim_finished" );
    
    while ( isdefined( zombie ) && isdefined( zombie.health ) && zombie.health > 1 )
    {
        zombie waittill( #"damage", amount );
    }
    
    if ( isdefined( zombie ) )
    {
        zombie.deathanim = "zm_rise_death_in";
        zombie stopanimscripted();
    }
}

// Namespace bo3_enemy
// Params 1
// Checksum 0x5b32da12, Offset: 0x6798
// Size: 0x82
function doaWarlordShouldSDoSpecial( var_bbd280b0 )
{
    if ( isdefined( var_bbd280b0.var_9aa7ba9b ) )
    {
        return 1;
    }
    
    if ( !isdefined( var_bbd280b0.var_55361ee6 ) )
    {
        return 0;
    }
    
    if ( var_bbd280b0.var_55361ee6 <= 0 )
    {
        return 0;
    }
    
    if ( !isdefined( var_bbd280b0.var_8f12ed02 ) )
    {
        return 0;
    }
    
    return var_bbd280b0 isatgoal();
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xe13c372a, Offset: 0x6828
// Size: 0x1be
function doWarlordPlantAnimation()
{
    self endon( #"death" );
    waittillframeend();
    
    if ( isalive( self ) && !self isragdoll() )
    {
        self.var_30fc80e6 = 1;
        self animscripted( "plant_anim", self.origin, self.angles, "ai_wrlrd_stn_combat_doa_plant_mine" );
        self waittillmatch( #"plant_anim", "planted" );
    }
    
    self.var_55361ee6 -= 1;
    bomb = spawn( "script_model", self.origin );
    bomb.targetname = "doWarlordPlantAnimation";
    bomb setmodel( "zombietron_Warlord_mine" );
    bomb playsound( "zmb_bomb_initialized" );
    bomb playloopsound( "zmb_bomb_looper", 1 );
    bomb thread doa_fx::function_285a2999( "explo_warning_light" );
    bomb thread function_97fb783( 5 );
    bomb.takedamage = 1;
    self waittillmatch( #"plant_anim", "end" );
    self.var_30fc80e6 = undefined;
}

// Namespace bo3_enemy
// Params 2
// Checksum 0x77a9e81f, Offset: 0x69f0
// Size: 0xb8
function function_c9e4e727( var_bbd280b0, asmstatename )
{
    if ( isdefined( var_bbd280b0.var_30fc80e6 ) )
    {
        return 5;
    }
    
    if ( var_bbd280b0.nextspecial > gettime() )
    {
        return 5;
    }
    
    var_bbd280b0 thread doWarlordPlantAnimation();
    var_bbd280b0.var_8f12ed02 = undefined;
    var_bbd280b0.nextspecial = gettime() + randomintrange( 3, 8 ) * 1000;
    animationstatenetworkutility::requeststate( var_bbd280b0, asmstatename );
    return 5;
}

// Namespace bo3_enemy
// Params 2
// Checksum 0xf9c5e58e, Offset: 0x6ab0
// Size: 0x4c
function function_c238a312( var_bbd280b0, asmstatename )
{
    if ( isdefined( var_bbd280b0.var_30fc80e6 ) )
    {
        return 5;
    }
    
    if ( var_bbd280b0.nextspecial > gettime() )
    {
        return 5;
    }
    
    return 4;
}

// Namespace bo3_enemy
// Params 1
// Checksum 0x35a181ca, Offset: 0x6b08
// Size: 0xcc
function function_97fb783( fusetime )
{
    wait fusetime;
    self util::waittill_any_timeout( fusetime, "damage" );
    radiusdamage( self.origin, 72, 10000, 0, undefined, "MOD_GAS" );
    self playsound( "zmb_bomb_explode" );
    self thread doa_fx::function_285a2999( "def_explode" );
    util::wait_network_frame();
    self delete();
}

// Namespace bo3_enemy
// Params 1
// Checksum 0x12221ccb, Offset: 0x6be0
// Size: 0x3a6, Type: bool
function doaWarlordUpdateToGoal( behaviortreeentity )
{
    if ( level flag::get( "doa_game_is_over" ) )
    {
        behaviortreeentity doa_enemy::function_d30fe558( behaviortreeentity.origin );
        return true;
    }
    
    if ( isdefined( behaviortreeentity.doa ) && behaviortreeentity.doa.stunned != 0 )
    {
        if ( !( isdefined( behaviortreeentity.doa.var_da2f5272 ) && behaviortreeentity.doa.var_da2f5272 ) )
        {
            behaviortreeentity doa_enemy::function_d30fe558( behaviortreeentity.doa.original_origin, behaviortreeentity.doa.stunned == 1 );
            behaviortreeentity.doa.stunned = 2;
        }
        else
        {
            behaviortreeentity doa_enemy::function_d30fe558( behaviortreeentity.origin );
        }
        
        return true;
    }
    
    if ( isdefined( behaviortreeentity.var_55361ee6 ) && behaviortreeentity.var_55361ee6 > 0 )
    {
        if ( !isdefined( behaviortreeentity.var_8f12ed02 ) )
        {
            goalpoints = doa_utility::function_308fa126( 30 );
            goalpoint = goalpoints[ randomint( goalpoints.size ) ];
            points = util::positionquery_pointarray( goalpoint, 0, 512, 70, 80, 64 );
            
            if ( points.size > 0 )
            {
                behaviortreeentity.var_8f12ed02 = getclosestpointonnavmesh( points[ randomint( points.size ) ], 20, 16 );
                
                if ( !isdefined( behaviortreeentity.var_8f12ed02 ) )
                {
                    behaviortreeentity.var_8f12ed02 = goalpoint;
                }
                
                behaviortreeentity doa_enemy::function_d30fe558( behaviortreeentity.var_8f12ed02 );
            }
        }
        else
        {
            behaviortreeentity doa_enemy::function_d30fe558( behaviortreeentity.var_8f12ed02 );
            return true;
        }
    }
    
    if ( isdefined( behaviortreeentity.enemy ) )
    {
        behaviortreeentity.favoriteenemy = behaviortreeentity.enemy;
        point = getclosestpointonnavmesh( behaviortreeentity.favoriteenemy.origin, 20, 16 );
        
        if ( isdefined( point ) )
        {
            behaviortreeentity.lastknownenemypos = point;
            behaviortreeentity doa_enemy::function_d30fe558( behaviortreeentity.lastknownenemypos );
        }
        
        return true;
    }
    
    behaviortreeentity doa_enemy::function_d30fe558( behaviortreeentity.origin );
    return false;
}

// Namespace bo3_enemy
// Params 4
// Checksum 0xeee8c80a, Offset: 0x6f90
// Size: 0x240
function function_53b44cb7( spawner, loc, def, forced )
{
    if ( !isdefined( forced ) )
    {
        forced = 0;
    }
    
    if ( isdefined( level.doa.var_d0cde02c ) && level.doa.var_d0cde02c == def || forced )
    {
        canspawn = 1;
    }
    else
    {
        canspawn = function_c783bef2();
    }
    
    if ( !canspawn )
    {
        return undefined;
    }
    
    ai = doa_enemy::function_a4e16560( spawner, loc, isdefined( def ) ? isdefined( def.forcespawn ) && def.forcespawn : 0 );
    
    if ( isdefined( ai ) )
    {
        ai.spawner = spawner;
        ai.team = "axis";
        ai.health = def.var_83bae1f8 + 150 * level.doa.round_number;
        
        if ( isdefined( def.maxhitpoints ) && ai.health > def.maxhitpoints )
        {
            ai.health = def.maxhitpoints;
        }
        
        ai.maxhealth = ai.health;
        ai.non_zombie = 1;
        ai thread function_772a04fe();
        
        if ( isdefined( level.doa.var_2836c8ee ) && level.doa.var_2836c8ee )
        {
            ai thread doa_fx::function_285a2999( "spawnZombie" );
        }
    }
    
    return ai;
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xc49a0eb7, Offset: 0x71d8
// Size: 0x12
function function_c783bef2()
{
    return doa_hazard::function_cda60edb();
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xc0713486, Offset: 0x71f8
// Size: 0x24c
function function_772a04fe()
{
    self endon( #"death" );
    self.zombie_move_speed = "sprint";
    goalpoints = doa_utility::function_308fa126( 10 );
    goalpoint = goalpoints[ randomint( goalpoints.size ) ] + ( randomintrange( -80, 80 ), randomintrange( -80, 80 ), 0 );
    self.var_8f12ed02 = getclosestpointonnavmesh( goalpoint, 20, 16 );
    
    if ( !isdefined( self.var_8f12ed02 ) )
    {
        return;
    }
    
    level.doa.var_932f9d4d = gettime();
    trashcan = spawn( "script_model", self.origin );
    trashcan.targetname = "trashcan";
    trashcan setmodel( "zombietron_trashcan" );
    trashcan linkto( self, "tag_origin", ( 0, 0, 54 ) );
    trashcan thread function_45f23318( self );
    self doa_enemy::function_d30fe558( self.var_8f12ed02, 1 );
    trashcan thread doa_hazard::function_d8d20160();
    self waittill( #"goal" );
    self.var_8f12ed02 = undefined;
    
    if ( isdefined( trashcan ) )
    {
        trashcan notify( #"dropped" );
        trashcan unlink();
        trashcan.origin = self.origin + ( 0, 0, 32 );
        trashcan.angles = ( 0, 0, 0 );
    }
}

// Namespace bo3_enemy
// Params 1, eflags: 0x4
// Checksum 0x29a05752, Offset: 0x7450
// Size: 0x50
function private function_45f23318( ai )
{
    self endon( #"death" );
    ai endon( #"goal" );
    ai waittill( #"death" );
    
    if ( isdefined( self.death_func ) )
    {
        self [[ self.death_func ]]();
    }
}

// Namespace bo3_enemy
// Params 0
// Checksum 0x9204838a, Offset: 0x74a8
// Size: 0x8c
function function_7e51c1d2()
{
    level util::waittill_any( "margwaAllDone", "player_challenge_failure" );
    level clientfield::set( "activateBanner", 0 );
    
    if ( isdefined( level.doa.margwa ) )
    {
        level waittill( #"fade_out_complete" );
        level.doa.margwa delete();
    }
}

// Namespace bo3_enemy
// Params 2
// Checksum 0x7db95efc, Offset: 0x7540
// Size: 0x120
function margwaspawn( loc, bossbattle )
{
    if ( !isdefined( bossbattle ) )
    {
        bossbattle = 0;
    }
    
    margwa = doa_enemy::function_a4e16560( getent( "doa_margwa_spawner", "targetname" ), loc, 1 );
    margwa.ignorevortices = 1;
    margwa.boss = 1;
    margwa notify( #"hash_6e8326fc" );
    margwa notify( #"hash_d96c599c" );
    margwa notify( #"hash_48b8c577" );
    margwa droptoground( undefined, "fire_trail", "turret_impact", 1, 0 );
    margwa.bossbattle = bossbattle;
    margwa thread function_c0147a11();
    return margwa;
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xfbf0338f, Offset: 0x7668
// Size: 0x402
function function_4ce6d0ea()
{
    level endon( #"player_challenge_failure" );
    level thread function_7e51c1d2();
    level notify( #"hash_e2918623" );
    setdvar( "scr_margwa_footstep_eq_radius", 0 );
    
    foreach ( player in doa_player_utility::function_5eb6e4d1() )
    {
        player notify( #"hash_d28ba89d" );
    }
    
    level thread doa_utility::function_c5f3ece8( &"DOA_UNDERBOSS", undefined, 6, ( 1, 0, 0 ) );
    level.voice playsound( "vox_doaa_underboss_battle" );
    level notify( #"hash_ba37290e", "bossbattle" );
    wait 1;
    level thread doa_utility::function_37fb5c23( &"CP_DOA_BO3_MARGWA_LAIR", undefined, 5, ( 1, 0, 0 ) );
    arenacenter = doa_arena::function_61d60e0b();
    loc = spawnstruct();
    loc.angles = ( 0, 0, 0 );
    loc.origin = arenacenter + ( 0, 0, 3000 );
    level.doa.margwa = margwaspawn( loc, 1 );
    players = getplayers();
    
    for ( i = 0; i < players.size ; i++ )
    {
        players[ i ] freezecontrols( 0 );
    }
    
    level clientfield::set( "activateBanner", 4 );
    level.doa.margwa waittill( #"death" );
    level clientfield::set( "activateBanner", 0 );
    level flag::set( "doa_round_paused" );
    doa_utility::function_1ced251e();
    level.doa.var_677d1262 = 0;
    level thread doa_utility::function_c5f3ece8( &"CP_DOA_BO3_MARGWA_DEFEATED", undefined, 6, ( 1, 0, 0 ) );
    wait 4;
    level thread doa_utility::function_37fb5c23( &"CP_DOA_BO3_MARGWA_DEFEATED2", undefined, 5, ( 1, 0, 0 ) );
    wait 6.5;
    level flag::clear( "doa_round_paused" );
    level flag::clear( "doa_round_active" );
    doa_utility::function_1ced251e();
    level thread doa_pickups::spawnmoneyglob( 0, 10, 0.1 );
    level thread doa_pickups::spawnmoneyglob( 1, 2, randomfloatrange( 2, 4 ) );
    level notify( #"margwaAllDone" );
}

// Namespace bo3_enemy
// Params 0, eflags: 0x4
// Checksum 0x39d501e4, Offset: 0x7a78
// Size: 0xe8
function private function_e8a17069()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( getdvarint( "scr_doa_soak_think", 0 ) )
        {
            damage = int( self.maxhealth * randomfloatrange( 0.1, 0.2 ) );
            attacker = doa_player_utility::function_35f36dec( self.origin );
            self dodamage( damage, self.origin, attacker, attacker );
        }
        
        wait randomint( 10 );
    }
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xc76b1fe3, Offset: 0x7b68
// Size: 0x14e
function function_62d794a5()
{
    level.doa.var_d0cde02c = level.doa.var_83a65bc6;
    level.doa.var_83a65bc6.var_84aef63e = getdvarint( "scr_doa_margwa_default_parasites_enraged", 16 );
    level.doa.var_83a65bc6.var_3ceda880 = 1;
    oldcount = level.doa.rules.max_enemy_count;
    level.doa.rules.max_enemy_count = 40;
    wait getdvarint( "scr_doa_margwa_enraged_duration", 10 );
    level.doa.rules.max_enemy_count = oldcount;
    level.doa.var_83a65bc6.var_84aef63e = getdvarint( "scr_doa_margwa_default_parasites", 0 );
    level.doa.var_83a65bc6.var_3ceda880 = 0;
    level.doa.var_d0cde02c = undefined;
}

// Namespace bo3_enemy
// Params 0, eflags: 0x4
// Checksum 0xf4c52146, Offset: 0x7cc0
// Size: 0x40
function private function_13109fad()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_2f07c48c" );
        level thread function_62d794a5();
    }
}

// Namespace bo3_enemy
// Params 0, eflags: 0x4
// Checksum 0xf419b2ed, Offset: 0x7d08
// Size: 0x310
function private function_c0147a11()
{
    wait 0.05;
    self endon( #"death" );
    self.takedamage = 1;
    self.health = getplayers().size * 250000 + ( 1 + level.doa.var_da96f13c ) * 300000;
    self.maxhealth = self.health;
    self.var_d3627554 = int( self.health * 0.8 );
    self.var_b220d777 = int( self.health * 0.5 );
    self.var_e6ea564a = int( self.health * 0.2 );
    self.goalradius = 16;
    self.goalheight = 256;
    self.overrideactordamage = &margwadamage;
    self.zombie_move_speed = "walk";
    self thread function_1c99c7cd();
    self thread function_e8a17069();
    self thread function_13109fad();
    
    /#
        if ( isdefined( level.doa.dev_level_skipped ) )
        {
            self thread doa_boss::function_76b30cc1();
        }
    #/
    
    if ( isdefined( level.doa.margwa ) && level.doa.margwa == self )
    {
        while ( self.health > 0 )
        {
            lasthealth = self.health;
            self waittill( #"damage", damage, attacker );
            data = doa_utility::clamp( self.health / self.maxhealth, 0, 1 );
            level clientfield::set( "pumpBannerBar", data );
            
            if ( isdefined( attacker ) && isplayer( attacker ) )
            {
                attacker doa_score::function_80eb303( int( damage * 0.25 ), 1 );
            }
            
            /#
                doa_utility::debugmsg( "<dev string:x67>" + self.health );
            #/
        }
    }
}

// Namespace bo3_enemy
// Params 12
// Checksum 0x72b9b59a, Offset: 0x8020
// Size: 0x440
function margwadamage( inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex )
{
    if ( self.health >= self.var_d3627554 && self.health - damage < self.var_d3627554 )
    {
        self notify( #"hash_2f07c48c" );
        modelhit = "c_zom_margwa_chunks_le";
        
        if ( isdefined( self.bossbattle ) && self.bossbattle )
        {
            level thread doa_round::function_691ef36b();
            level thread doa_round::function_703bb8b2( 30 );
            level thread doa_round::function_87703158( 1 );
        }
        
        org = spawn( "script_model", self gettagorigin( "J_Head_LE" ) );
        org.targetname = "margwa1";
        org setmodel( "tag_origin" );
        level doa_pickups::function_3238133b( "zombietron_heart", self.origin, 1, 1, 90 );
    }
    else if ( self.health >= self.var_b220d777 && self.health - damage < self.var_b220d777 )
    {
        self notify( #"hash_2f07c48c" );
        modelhit = "c_zom_margwa_chunks_ri";
        org = spawn( "script_model", self gettagorigin( "J_Head_RI" ) );
        org.targetname = "margwa1";
        org setmodel( "tag_origin" );
        level doa_pickups::function_3238133b( "zombietron_heart", self.origin, 1, 1, 90 );
    }
    else if ( self.health >= self.var_e6ea564a && self.health - damage < self.var_e6ea564a )
    {
        self notify( #"hash_2f07c48c" );
        modelhit = "c_zom_margwa_chunks_mid";
        org = spawn( "script_model", self gettagorigin( "J_Head" ) );
        org.targetname = "margwa1";
        org setmodel( "tag_origin" );
        level doa_pickups::function_3238133b( "zombietron_heart", self.origin, 1, 1, 90 );
    }
    
    if ( isdefined( modelhit ) )
    {
        headinfo = self.head[ modelhit ];
        headinfo.health = 0;
        self margwaupdatemovespeed();
        self detach( modelhit );
        self attach( headinfo.gore );
        self.headattached--;
        self.headdestroyed = modelhit;
        self thread function_7ee81ba4( org );
    }
    
    return damage;
}

// Namespace bo3_enemy
// Params 1, eflags: 0x4
// Checksum 0xe3bcd2fa, Offset: 0x8468
// Size: 0x4c
function private function_7ee81ba4( org )
{
    org thread doa_fx::function_285a2999( "margwa_head_explode" );
    wait 1;
    org delete();
}

// Namespace bo3_enemy
// Params 0, eflags: 0x4
// Checksum 0x14cb7732, Offset: 0x84c0
// Size: 0xdc
function private margwaupdatemovespeed()
{
    if ( self.zombie_move_speed == "walk" )
    {
        self.zombie_move_speed = "run";
        self asmsetanimationrate( 0.8 );
        blackboard::setblackboardattribute( self, "_locomotion_speed", "locomotion_speed_run" );
        return;
    }
    
    if ( self.zombie_move_speed == "run" )
    {
        self.zombie_move_speed = "sprint";
        self asmsetanimationrate( 1 );
        blackboard::setblackboardattribute( self, "_locomotion_speed", "locomotion_speed_sprint" );
    }
}

// Namespace bo3_enemy
// Params 0, eflags: 0x4
// Checksum 0x348e59ff, Offset: 0x85a8
// Size: 0x130
function private function_1c99c7cd()
{
    trigger = spawn( "trigger_radius", self.origin, 2, 40, 50 );
    trigger.targetname = "margwaDamag";
    trigger enablelinkto();
    trigger linkto( self, "tag_origin" );
    trigger endon( #"death" );
    trigger thread doa_utility::function_783519c1( "exit_taken", 1 );
    trigger thread doa_utility::function_981c685d( self );
    
    while ( isdefined( self ) )
    {
        trigger waittill( #"trigger", guy );
        
        if ( isdefined( self ) )
        {
            guy dodamage( 665, guy.origin, self, self );
        }
    }
}

// Namespace bo3_enemy
// Params 0
// Checksum 0xfc4f5f47, Offset: 0x86e0
// Size: 0x242
function function_771e3915()
{
    level notify( #"hash_93296b5" );
    level endon( #"hash_93296b5" );
    level endon( #"doa_game_is_over" );
    extrawait = 0;
    
    while ( true )
    {
        wait 90 + extrawait;
        extrawait = 0;
        
        if ( isdefined( level.doa.challenge_room ) )
        {
            continue;
        }
        
        if ( level flag::get( "doa_round_spawning" ) )
        {
            roll = randomint( 100 );
            
            if ( roll < 25 )
            {
                name = "parasite";
                count = 8;
                extrawait = 30;
            }
            else if ( roll < 50 )
            {
                name = "smokeman";
                count = 8;
                extrawait = 60;
            }
            else if ( roll < 75 )
            {
                name = "riser";
                count = 5;
                extrawait = 0;
            }
            else if ( roll < 85 )
            {
                name = "warlord";
                count = 2;
                extrawait = 0;
            }
            else if ( roll < 95 )
            {
                name = "_dog";
                count = 2;
                extrawait = 60;
            }
            else
            {
                name = "veh_meatball";
                count = 1;
                extrawait = 90;
            }
        }
        
        spawner = level.doa.enemyspawners[ name ];
        
        if ( isdefined( spawner ) )
        {
            while ( count )
            {
                wait 0.3;
                level thread function_65762352( name, spawner );
                count--;
            }
        }
    }
}

