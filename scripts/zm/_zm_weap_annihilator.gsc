#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;

#namespace zm_weap_annihilator;

// Namespace zm_weap_annihilator
// Params 0, eflags: 0x2
// Checksum 0x6925665e, Offset: 0x260
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_weap_annihilator", &__init__, undefined, undefined );
}

// Namespace zm_weap_annihilator
// Params 0
// Checksum 0x6ae0438f, Offset: 0x2a0
// Size: 0x5c
function __init__()
{
    zm_spawner::register_zombie_death_event_callback( &check_annihilator_death );
    zm_hero_weapon::register_hero_weapon( "hero_annihilator" );
    level.weaponannihilator = getweapon( "hero_annihilator" );
}

// Namespace zm_weap_annihilator
// Params 1
// Checksum 0x660b6305, Offset: 0x308
// Size: 0x74
function check_annihilator_death( attacker )
{
    if ( isdefined( self.damageweapon ) && !( self.damageweapon === level.weaponnone ) )
    {
        if ( self.damageweapon === level.weaponannihilator )
        {
            self zombie_utility::gib_random_parts();
            gibserverutils::annihilate( self );
        }
    }
}

