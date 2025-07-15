#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_projectile_vomiting;

// Namespace zm_bgb_projectile_vomiting
// Params 0, eflags: 0x2
// Checksum 0xf631c93, Offset: 0x210
// Size: 0x34
function autoexec __init__sytem__()
{
    system::register( "zm_bgb_projectile_vomiting", &__init__, undefined, "bgb" );
}

// Namespace zm_bgb_projectile_vomiting
// Params 0
// Checksum 0x34d7b1e0, Offset: 0x250
// Size: 0xb4
function __init__()
{
    if ( !( isdefined( level.bgb_in_use ) && level.bgb_in_use ) )
    {
        return;
    }
    
    clientfield::register( "actor", "projectile_vomit", 12000, 1, "counter" );
    bgb::register( "zm_bgb_projectile_vomiting", "rounds", 5, &enable, &disable, undefined );
    bgb::register_actor_death_override( "zm_bgb_projectile_vomiting", &actor_death_override );
}

// Namespace zm_bgb_projectile_vomiting
// Params 0
// Checksum 0x99ec1590, Offset: 0x310
// Size: 0x4
function enable()
{
    
}

// Namespace zm_bgb_projectile_vomiting
// Params 0
// Checksum 0x99ec1590, Offset: 0x320
// Size: 0x4
function disable()
{
    
}

// Namespace zm_bgb_projectile_vomiting
// Params 1
// Checksum 0xad3199e8, Offset: 0x330
// Size: 0x76
function actor_death_override( attacker )
{
    if ( isdefined( self.damagemod ) )
    {
        switch ( self.damagemod )
        {
            case "MOD_EXPLOSIVE":
            case "MOD_GRENADE":
            case "MOD_GRENADE_SPLASH":
            case "MOD_PROJECTILE":
            default:
                clientfield::increment( "projectile_vomit", 1 );
                break;
        }
    }
}

