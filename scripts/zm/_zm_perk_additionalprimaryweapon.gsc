#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
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
#using scripts/zm/_zm_weapons;

#namespace zm_perk_additionalprimaryweapon;

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x2
// Checksum 0x30b0fd44, Offset: 0x3f8
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_perk_additionalprimaryweapon", &__init__, undefined, undefined );
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0
// Checksum 0x7c3e0a70, Offset: 0x438
// Size: 0x5c
function __init__()
{
    level.additionalprimaryweapon_limit = 3;
    enable_additional_primary_weapon_perk_for_level();
    callback::on_laststand( &on_laststand );
    level.return_additionalprimaryweapon = &return_additionalprimaryweapon;
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0
// Checksum 0xa43a21a7, Offset: 0x4a0
// Size: 0x12c
function enable_additional_primary_weapon_perk_for_level()
{
    zm_perks::register_perk_basic_info( "specialty_additionalprimaryweapon", "additionalprimaryweapon", 4000, &"ZOMBIE_PERK_ADDITIONALPRIMARYWEAPON", getweapon( "zombie_perk_bottle_additionalprimaryweapon" ) );
    zm_perks::register_perk_precache_func( "specialty_additionalprimaryweapon", &additional_primary_weapon_precache );
    zm_perks::register_perk_clientfields( "specialty_additionalprimaryweapon", &additional_primary_weapon_register_clientfield, &additional_primary_weapon_set_clientfield );
    zm_perks::register_perk_machine( "specialty_additionalprimaryweapon", &additional_primary_weapon_perk_machine_setup );
    zm_perks::register_perk_threads( "specialty_additionalprimaryweapon", &give_additional_primary_weapon_perk, &take_additional_primary_weapon_perk );
    zm_perks::register_perk_host_migration_params( "specialty_additionalprimaryweapon", "vending_additionalprimaryweapon", "additionalprimaryweapon_light" );
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0
// Checksum 0xf5f7b29, Offset: 0x5d8
// Size: 0xe0
function additional_primary_weapon_precache()
{
    if ( isdefined( level.additional_primary_weapon_precache_override_func ) )
    {
        [[ level.additional_primary_weapon_precache_override_func ]]();
        return;
    }
    
    level._effect[ "additionalprimaryweapon_light" ] = "zombie/fx_perk_mule_kick_zmb";
    level.machine_assets[ "specialty_additionalprimaryweapon" ] = spawnstruct();
    level.machine_assets[ "specialty_additionalprimaryweapon" ].weapon = getweapon( "zombie_perk_bottle_additionalprimaryweapon" );
    level.machine_assets[ "specialty_additionalprimaryweapon" ].off_model = "p7_zm_vending_three_gun";
    level.machine_assets[ "specialty_additionalprimaryweapon" ].on_model = "p7_zm_vending_three_gun";
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0
// Checksum 0x6c70af9, Offset: 0x6c0
// Size: 0x34
function additional_primary_weapon_register_clientfield()
{
    clientfield::register( "clientuimodel", "hudItems.perks.additional_primary_weapon", 1, 2, "int" );
}

// Namespace zm_perk_additionalprimaryweapon
// Params 1
// Checksum 0x104f1cc7, Offset: 0x700
// Size: 0x2c
function additional_primary_weapon_set_clientfield( state )
{
    self clientfield::set_player_uimodel( "hudItems.perks.additional_primary_weapon", state );
}

// Namespace zm_perk_additionalprimaryweapon
// Params 4
// Checksum 0x4e1e7c8b, Offset: 0x738
// Size: 0xbc
function additional_primary_weapon_perk_machine_setup( use_trigger, perk_machine, bump_trigger, collision )
{
    use_trigger.script_sound = "mus_perks_mulekick_jingle";
    use_trigger.script_string = "tap_perk";
    use_trigger.script_label = "mus_perks_mulekick_sting";
    use_trigger.target = "vending_additionalprimaryweapon";
    perk_machine.script_string = "tap_perk";
    perk_machine.targetname = "vending_additionalprimaryweapon";
    
    if ( isdefined( bump_trigger ) )
    {
        bump_trigger.script_string = "tap_perk";
    }
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0
// Checksum 0x99ec1590, Offset: 0x800
// Size: 0x4
function give_additional_primary_weapon_perk()
{
    
}

// Namespace zm_perk_additionalprimaryweapon
// Params 3
// Checksum 0xbe89ae0c, Offset: 0x810
// Size: 0x44
function take_additional_primary_weapon_perk( b_pause, str_perk, str_result )
{
    if ( b_pause || str_result == str_perk )
    {
        self take_additionalprimaryweapon();
    }
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0
// Checksum 0xbd11f220, Offset: 0x860
// Size: 0x1ec
function take_additionalprimaryweapon()
{
    weapon_to_take = level.weaponnone;
    
    if ( isdefined( self._retain_perks_array[ "specialty_additionalprimaryweapon" ] ) && isdefined( self._retain_perks_array ) && ( isdefined( self._retain_perks ) && self._retain_perks || self._retain_perks_array[ "specialty_additionalprimaryweapon" ] ) )
    {
        return weapon_to_take;
    }
    
    primary_weapons_that_can_be_taken = [];
    primaryweapons = self getweaponslistprimaries();
    
    for ( i = 0; i < primaryweapons.size ; i++ )
    {
        if ( zm_weapons::is_weapon_included( primaryweapons[ i ] ) || zm_weapons::is_weapon_upgraded( primaryweapons[ i ] ) )
        {
            primary_weapons_that_can_be_taken[ primary_weapons_that_can_be_taken.size ] = primaryweapons[ i ];
        }
    }
    
    self.weapons_taken_by_losing_specialty_additionalprimaryweapon = [];
    pwtcbt = primary_weapons_that_can_be_taken.size;
    
    while ( pwtcbt >= 3 )
    {
        weapon_to_take = primary_weapons_that_can_be_taken[ pwtcbt - 1 ];
        self.weapons_taken_by_losing_specialty_additionalprimaryweapon[ weapon_to_take ] = zm_weapons::get_player_weapondata( self, weapon_to_take );
        pwtcbt--;
        
        if ( weapon_to_take == self getcurrentweapon() )
        {
            self switchtoweapon( primary_weapons_that_can_be_taken[ 0 ] );
        }
        
        self takeweapon( weapon_to_take );
    }
    
    return weapon_to_take;
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0
// Checksum 0xccd52124, Offset: 0xa58
// Size: 0x44
function on_laststand()
{
    if ( self hasperk( "specialty_additionalprimaryweapon" ) )
    {
        self.weapon_taken_by_losing_specialty_additionalprimaryweapon = take_additionalprimaryweapon();
    }
}

// Namespace zm_perk_additionalprimaryweapon
// Params 1
// Checksum 0x6a398694, Offset: 0xaa8
// Size: 0x5c
function return_additionalprimaryweapon( w_returning )
{
    if ( isdefined( self.weapons_taken_by_losing_specialty_additionalprimaryweapon[ w_returning ] ) )
    {
        self zm_weapons::weapondata_give( self.weapons_taken_by_losing_specialty_additionalprimaryweapon[ w_returning ] );
        return;
    }
    
    self zm_weapons::give_build_kit_weapon( w_returning );
}

