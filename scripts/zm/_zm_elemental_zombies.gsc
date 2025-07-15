#using scripts/codescripts/struct;
#using scripts/shared/_burnplayer;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_devgui;

#namespace zm_elemental_zombie;

// Namespace zm_elemental_zombie
// Params 0, eflags: 0x2
// Checksum 0x1a2c8a6, Offset: 0x5b0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_elemental_zombie", &__init__, undefined, undefined );
}

// Namespace zm_elemental_zombie
// Params 0
// Checksum 0xcf092cc1, Offset: 0x5f0
// Size: 0x44
function __init__()
{
    register_clientfields();
    
    /#
        execdevgui( "<dev string:x28>" );
        thread function_f6901b6a();
    #/
}

// Namespace zm_elemental_zombie
// Params 0, eflags: 0x4
// Checksum 0x7253fbc5, Offset: 0x640
// Size: 0x124
function private register_clientfields()
{
    clientfield::register( "actor", "sparky_zombie_spark_fx", 1, 1, "int" );
    clientfield::register( "actor", "sparky_zombie_death_fx", 1, 1, "int" );
    clientfield::register( "actor", "napalm_zombie_death_fx", 1, 1, "int" );
    clientfield::register( "actor", "sparky_damaged_fx", 1, 1, "counter" );
    clientfield::register( "actor", "napalm_damaged_fx", 1, 1, "counter" );
    clientfield::register( "actor", "napalm_sfx", 11000, 1, "int" );
}

// Namespace zm_elemental_zombie
// Params 0
// Checksum 0xf0110717, Offset: 0x770
// Size: 0x264
function function_1b1bb1b()
{
    ai_zombie = self;
    
    if ( !isalive( ai_zombie ) )
    {
        return;
    }
    
    var_199ecc3a = function_4aeed0a5( "sparky" );
    
    if ( !isdefined( level.var_1ae26ca5 ) || var_199ecc3a < level.var_1ae26ca5 )
    {
        if ( !isdefined( ai_zombie.is_elemental_zombie ) || ai_zombie.is_elemental_zombie == 0 )
        {
            ai_zombie.is_elemental_zombie = 1;
            ai_zombie.var_9a02a614 = "sparky";
            ai_zombie clientfield::set( "sparky_zombie_spark_fx", 1 );
            ai_zombie.health = int( ai_zombie.health * 1.5 );
            ai_zombie thread function_d9226011();
            ai_zombie thread function_2987b6dc();
            
            if ( ai_zombie.iscrawler === 1 )
            {
                var_f4a5c99 = array( "ai_zm_dlc1_zombie_crawl_turn_sparky_a", "ai_zm_dlc1_zombie_crawl_turn_sparky_b", "ai_zm_dlc1_zombie_crawl_turn_sparky_c", "ai_zm_dlc1_zombie_crawl_turn_sparky_d", "ai_zm_dlc1_zombie_crawl_turn_sparky_e" );
            }
            else
            {
                var_f4a5c99 = array( "ai_zm_dlc1_zombie_turn_sparky_a", "ai_zm_dlc1_zombie_turn_sparky_b", "ai_zm_dlc1_zombie_turn_sparky_c", "ai_zm_dlc1_zombie_turn_sparky_d", "ai_zm_dlc1_zombie_turn_sparky_e" );
            }
            
            if ( isdefined( ai_zombie ) && !isdefined( ai_zombie.traversestartnode ) && !( isdefined( self.var_bb98125f ) && self.var_bb98125f ) )
            {
                ai_zombie animation::play( array::random( var_f4a5c99 ), ai_zombie, undefined, 1, 0.2, 0.2 );
            }
        }
    }
}

// Namespace zm_elemental_zombie
// Params 0
// Checksum 0x9d8b369a, Offset: 0x9e0
// Size: 0x174
function function_f4defbc2()
{
    if ( isdefined( self ) )
    {
        ai_zombie = self;
        var_ac4641b = function_4aeed0a5( "napalm" );
        
        if ( !isdefined( level.var_bd64e31e ) || var_ac4641b < level.var_bd64e31e )
        {
            if ( !isdefined( ai_zombie.is_elemental_zombie ) || ai_zombie.is_elemental_zombie == 0 )
            {
                ai_zombie.is_elemental_zombie = 1;
                ai_zombie.var_9a02a614 = "napalm";
                ai_zombie clientfield::set( "arch_actor_fire_fx", 1 );
                ai_zombie clientfield::set( "napalm_sfx", 1 );
                ai_zombie.health = int( ai_zombie.health * 0.75 );
                ai_zombie thread napalm_zombie_death();
                ai_zombie thread function_d070bfba();
                ai_zombie zombie_utility::set_zombie_run_cycle( "sprint" );
            }
        }
    }
}

// Namespace zm_elemental_zombie
// Params 0
// Checksum 0xd74a2c3f, Offset: 0xb60
// Size: 0x78
function function_2987b6dc()
{
    self endon( #"entityshutdown" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage" );
        
        if ( randomint( 100 ) < 50 )
        {
            self clientfield::increment( "sparky_damaged_fx" );
        }
        
        wait 0.05;
    }
}

// Namespace zm_elemental_zombie
// Params 0
// Checksum 0x8e85bd04, Offset: 0xbe0
// Size: 0x78
function function_d070bfba()
{
    self endon( #"entityshutdown" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage" );
        
        if ( randomint( 100 ) < 50 )
        {
            self clientfield::increment( "napalm_damaged_fx" );
        }
        
        wait 0.05;
    }
}

// Namespace zm_elemental_zombie
// Params 0
// Checksum 0x4f30462b, Offset: 0xc60
// Size: 0xec
function function_d9226011()
{
    ai_zombie = self;
    ai_zombie waittill( #"death", attacker );
    
    if ( !isdefined( ai_zombie ) || ai_zombie.nuked === 1 )
    {
        return;
    }
    
    ai_zombie clientfield::set( "sparky_zombie_death_fx", 1 );
    ai_zombie zombie_utility::gib_random_parts();
    gibserverutils::annihilate( ai_zombie );
    radiusdamage( ai_zombie.origin + ( 0, 0, 35 ), 128, 70, 30, self, "MOD_EXPLOSIVE" );
}

// Namespace zm_elemental_zombie
// Params 0
// Checksum 0x3b319540, Offset: 0xd58
// Size: 0x13c
function napalm_zombie_death()
{
    ai_zombie = self;
    ai_zombie waittill( #"death", attacker );
    
    if ( !isdefined( ai_zombie ) || ai_zombie.nuked === 1 )
    {
        return;
    }
    
    ai_zombie clientfield::set( "napalm_zombie_death_fx", 1 );
    ai_zombie zombie_utility::gib_random_parts();
    gibserverutils::annihilate( ai_zombie );
    
    if ( isdefined( ai_zombie.var_36b5dab ) && ( isdefined( level.var_36b5dab ) && level.var_36b5dab || ai_zombie.var_36b5dab ) )
    {
        ai_zombie.custom_player_shellshock = &function_e6cd7e78;
    }
    
    radiusdamage( ai_zombie.origin + ( 0, 0, 35 ), 128, 70, 30, self, "MOD_EXPLOSIVE" );
}

// Namespace zm_elemental_zombie
// Params 5
// Checksum 0x4b4a28fc, Offset: 0xea0
// Size: 0x74
function function_e6cd7e78( damage, attacker, direction_vec, point, mod )
{
    if ( getdvarstring( "blurpain" ) == "on" )
    {
        self shellshock( "pain_zm", 0.5 );
    }
}

// Namespace zm_elemental_zombie
// Params 0
// Checksum 0x72bb41c7, Offset: 0xf20
// Size: 0x64
function function_d41418b8()
{
    a_zombies = getaiarchetypearray( "zombie" );
    a_filtered_zombies = array::filter( a_zombies, 0, &function_b804eb62 );
    return a_filtered_zombies;
}

// Namespace zm_elemental_zombie
// Params 1
// Checksum 0xdc4c9f9a, Offset: 0xf90
// Size: 0x6c
function function_c50e890f( type )
{
    a_zombies = getaiarchetypearray( "zombie" );
    a_filtered_zombies = array::filter( a_zombies, 0, &function_361f6caa, type );
    return a_filtered_zombies;
}

// Namespace zm_elemental_zombie
// Params 1
// Checksum 0x96918936, Offset: 0x1008
// Size: 0x36
function function_4aeed0a5( type )
{
    a_zombies = function_c50e890f( type );
    return a_zombies.size;
}

// Namespace zm_elemental_zombie
// Params 2
// Checksum 0x2f762ef0, Offset: 0x1048
// Size: 0x28, Type: bool
function function_361f6caa( ai_zombie, type )
{
    return ai_zombie.var_9a02a614 === type;
}

// Namespace zm_elemental_zombie
// Params 1
// Checksum 0x735f2321, Offset: 0x1078
// Size: 0x20, Type: bool
function function_b804eb62( ai_zombie )
{
    return ai_zombie.is_elemental_zombie !== 1;
}

/#

    // Namespace zm_elemental_zombie
    // Params 0
    // Checksum 0xba93fa13, Offset: 0x10a0
    // Size: 0x44, Type: dev
    function function_f6901b6a()
    {
        level flagsys::wait_till( "<dev string:x51>" );
        zm_devgui::add_custom_devgui_callback( &function_2d0e7f4 );
    }

    // Namespace zm_elemental_zombie
    // Params 1
    // Checksum 0x45688692, Offset: 0x10f0
    // Size: 0x28e, Type: dev
    function function_2d0e7f4( cmd )
    {
        switch ( cmd )
        {
            default:
                a_zombies = function_d41418b8();
                
                if ( a_zombies.size > 0 )
                {
                    a_zombies = arraysortclosest( a_zombies, level.players[ 0 ].origin );
                    a_zombies[ 0 ] function_1b1bb1b();
                }
                
                break;
            case "<dev string:x84>":
                a_zombies = function_d41418b8();
                
                if ( a_zombies.size > 0 )
                {
                    a_zombies = arraysortclosest( a_zombies, level.players[ 0 ].origin );
                    a_zombies[ 0 ] function_f4defbc2();
                }
                
                break;
            case "<dev string:x9d>":
                a_zombies = function_d41418b8();
                
                if ( a_zombies.size > 0 )
                {
                    foreach ( zombie in a_zombies )
                    {
                        zombie function_1b1bb1b();
                    }
                }
                
                break;
            case "<dev string:xb4>":
                a_zombies = function_d41418b8();
                
                if ( a_zombies.size > 0 )
                {
                    foreach ( zombie in a_zombies )
                    {
                        zombie function_f4defbc2();
                    }
                }
                
                break;
        }
    }

#/
