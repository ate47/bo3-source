#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_perks;

#namespace zm_perk_sleight_of_hand;

// Namespace zm_perk_sleight_of_hand
// Params 0, eflags: 0x2
// Checksum 0x513e051c, Offset: 0x1b0
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_perk_sleight_of_hand", &__init__, undefined, undefined );
}

// Namespace zm_perk_sleight_of_hand
// Params 0
// Checksum 0xc92504b5, Offset: 0x1f0
// Size: 0x14
function __init__()
{
    enable_sleight_of_hand_perk_for_level();
}

// Namespace zm_perk_sleight_of_hand
// Params 0
// Checksum 0x4b590523, Offset: 0x210
// Size: 0x84
function enable_sleight_of_hand_perk_for_level()
{
    zm_perks::register_perk_clientfields( "specialty_fastreload", &sleight_of_hand_client_field_func, &sleight_of_hand_code_callback_func );
    zm_perks::register_perk_effects( "specialty_fastreload", "sleight_light" );
    zm_perks::register_perk_init_thread( "specialty_fastreload", &init_sleight_of_hand );
}

// Namespace zm_perk_sleight_of_hand
// Params 0
// Checksum 0xc6a7a0d0, Offset: 0x2a0
// Size: 0x36
function init_sleight_of_hand()
{
    if ( isdefined( level.enable_magic ) && level.enable_magic )
    {
        level._effect[ "sleight_light" ] = "zombie/fx_perk_sleight_of_hand_zmb";
    }
}

// Namespace zm_perk_sleight_of_hand
// Params 0
// Checksum 0x960f7ce2, Offset: 0x2e0
// Size: 0x3c
function sleight_of_hand_client_field_func()
{
    clientfield::register( "clientuimodel", "hudItems.perks.sleight_of_hand", 1, 2, "int", undefined, 0, 1 );
}

// Namespace zm_perk_sleight_of_hand
// Params 0
// Checksum 0x99ec1590, Offset: 0x328
// Size: 0x4
function sleight_of_hand_code_callback_func()
{
    
}

