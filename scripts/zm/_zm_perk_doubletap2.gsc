#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades_system;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_perk_doubletap2;

// Namespace zm_perk_doubletap2
// Params 0, eflags: 0x2
// Checksum 0xfe3cdd3, Offset: 0x340
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_perk_doubletap2", &__init__, undefined, undefined );
}

// Namespace zm_perk_doubletap2
// Params 0
// Checksum 0x7f94f4b7, Offset: 0x380
// Size: 0x14
function __init__()
{
    enable_doubletap2_perk_for_level();
}

// Namespace zm_perk_doubletap2
// Params 0
// Checksum 0x5b4c718f, Offset: 0x3a0
// Size: 0xf4
function enable_doubletap2_perk_for_level()
{
    zm_perks::register_perk_basic_info( "specialty_doubletap2", "doubletap", 2000, &"ZOMBIE_PERK_DOUBLETAP", getweapon( "zombie_perk_bottle_doubletap" ) );
    zm_perks::register_perk_precache_func( "specialty_doubletap2", &doubletap2_precache );
    zm_perks::register_perk_clientfields( "specialty_doubletap2", &doubletap2_register_clientfield, &doubletap2_set_clientfield );
    zm_perks::register_perk_machine( "specialty_doubletap2", &doubletap2_perk_machine_setup );
    zm_perks::register_perk_host_migration_params( "specialty_doubletap2", "vending_doubletap", "doubletap2_light" );
}

// Namespace zm_perk_doubletap2
// Params 0
// Checksum 0xaed6a9f8, Offset: 0x4a0
// Size: 0xe0
function doubletap2_precache()
{
    if ( isdefined( level.doubletap2_precache_override_func ) )
    {
        [[ level.doubletap2_precache_override_func ]]();
        return;
    }
    
    level._effect[ "doubletap2_light" ] = "zombie/fx_perk_doubletap2_zmb";
    level.machine_assets[ "specialty_doubletap2" ] = spawnstruct();
    level.machine_assets[ "specialty_doubletap2" ].weapon = getweapon( "zombie_perk_bottle_doubletap" );
    level.machine_assets[ "specialty_doubletap2" ].off_model = "p7_zm_vending_doubletap2";
    level.machine_assets[ "specialty_doubletap2" ].on_model = "p7_zm_vending_doubletap2";
}

// Namespace zm_perk_doubletap2
// Params 0
// Checksum 0x4c984806, Offset: 0x588
// Size: 0x34
function doubletap2_register_clientfield()
{
    clientfield::register( "clientuimodel", "hudItems.perks.doubletap2", 1, 2, "int" );
}

// Namespace zm_perk_doubletap2
// Params 1
// Checksum 0x4bb3f590, Offset: 0x5c8
// Size: 0x2c
function doubletap2_set_clientfield( state )
{
    self clientfield::set_player_uimodel( "hudItems.perks.doubletap2", state );
}

// Namespace zm_perk_doubletap2
// Params 4
// Checksum 0xa9a0aa0c, Offset: 0x600
// Size: 0xbc
function doubletap2_perk_machine_setup( use_trigger, perk_machine, bump_trigger, collision )
{
    use_trigger.script_sound = "mus_perks_doubletap_jingle";
    use_trigger.script_string = "tap_perk";
    use_trigger.script_label = "mus_perks_doubletap_sting";
    use_trigger.target = "vending_doubletap";
    perk_machine.script_string = "tap_perk";
    perk_machine.targetname = "vending_doubletap";
    
    if ( isdefined( bump_trigger ) )
    {
        bump_trigger.script_string = "tap_perk";
    }
}

