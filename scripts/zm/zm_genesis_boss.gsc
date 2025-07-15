#using scripts/codescripts/struct;
#using scripts/shared/ai/margwa;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_parasite;
#using scripts/zm/_zm_ai_margwa_no_idgun;
#using scripts/zm/_zm_ai_mechz;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_genesis_spiders;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_light_zombie;
#using scripts/zm/_zm_powerup_genesis_random_weapon;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_shadow_zombie;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_traps;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_gravityspikes;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_genesis_arena;
#using scripts/zm/zm_genesis_shadowman;
#using scripts/zm/zm_genesis_spiders;
#using scripts/zm/zm_genesis_util;
#using scripts/zm/zm_genesis_wasp;

#namespace zm_genesis_boss;

// Namespace zm_genesis_boss
// Params 0, eflags: 0x2
// Checksum 0x292cb0db, Offset: 0x5d8
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_genesis_boss", &__init__, &__main__, undefined );
}

// Namespace zm_genesis_boss
// Params 0
// Checksum 0xac8f5a80, Offset: 0x620
// Size: 0xec
function __init__()
{
    clientfield::register( "scriptmover", "boss_clone_fx", 15000, getminbitcountfornum( 3 ), "int" );
    clientfield::register( "world", "sophia_state", 15000, getminbitcountfornum( 4 ), "int" );
    clientfield::register( "world", "boss_beam_state", 15000, 1, "int" );
    
    /#
        if ( getdvarint( "<dev string:x28>" ) > 0 )
        {
            level thread devgui_boss();
        }
    #/
}

// Namespace zm_genesis_boss
// Params 0
// Checksum 0x79bf1c3f, Offset: 0x718
// Size: 0xc
function __main__()
{
    wait 0.1;
}

/#

    // Namespace zm_genesis_boss
    // Params 0
    // Checksum 0x80e6d00f, Offset: 0x730
    // Size: 0x74, Type: dev
    function devgui_boss()
    {
        level thread zm_genesis_util::setup_devgui_func( "<dev string:x35>", "<dev string:x5c>", 0, &function_92d90d50 );
        level thread zm_genesis_util::setup_devgui_func( "<dev string:x6e>", "<dev string:x5c>", 2, &function_92d90d50 );
    }

    // Namespace zm_genesis_boss
    // Params 1
    // Checksum 0x68a5ba7, Offset: 0x7b0
    // Size: 0x34, Type: dev
    function function_92d90d50( n_val )
    {
        level thread clientfield::set( "<dev string:x96>", n_val );
    }

#/
