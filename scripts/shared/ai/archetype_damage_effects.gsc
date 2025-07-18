#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/math_shared;

#namespace archetype_damage_effects;

// Namespace archetype_damage_effects
// Params 0, eflags: 0x2
// Checksum 0x25729624, Offset: 0x208
// Size: 0xe4
function autoexec main()
{
    clientfield::register( "actor", "arch_actor_fire_fx", 1, 2, "int" );
    clientfield::register( "actor", "arch_actor_char", 1, 2, "int" );
    callback::on_actor_damage( &onactordamagecallback );
    callback::on_vehicle_damage( &onvehicledamagecallback );
    callback::on_actor_killed( &onactorkilledcallback );
    callback::on_vehicle_killed( &onvehiclekilledcallback );
}

// Namespace archetype_damage_effects
// Params 1
// Checksum 0x15d56ac5, Offset: 0x2f8
// Size: 0x24
function onactordamagecallback( params )
{
    onactordamage( params );
}

// Namespace archetype_damage_effects
// Params 1
// Checksum 0xdf17122b, Offset: 0x328
// Size: 0x24
function onvehicledamagecallback( params )
{
    onvehicledamage( params );
}

// Namespace archetype_damage_effects
// Params 1
// Checksum 0x18abf46b, Offset: 0x358
// Size: 0x6e
function onactorkilledcallback( params )
{
    onactorkilled();
    
    switch ( self.archetype )
    {
        case "human":
            onhumankilled();
            break;
        default:
            onrobotkilled();
            break;
    }
}

// Namespace archetype_damage_effects
// Params 1
// Checksum 0x95693ed5, Offset: 0x3d0
// Size: 0x24
function onvehiclekilledcallback( params )
{
    onvehiclekilled( params );
}

// Namespace archetype_damage_effects
// Params 1
// Checksum 0x90504447, Offset: 0x400
// Size: 0xc
function onactordamage( params )
{
    
}

// Namespace archetype_damage_effects
// Params 1
// Checksum 0x12f19214, Offset: 0x418
// Size: 0x24
function onvehicledamage( params )
{
    onvehiclekilled( params );
}

// Namespace archetype_damage_effects
// Params 0
// Checksum 0x48e1ff5a, Offset: 0x448
// Size: 0x7c
function onactorkilled()
{
    if ( isdefined( self.damagemod ) )
    {
        if ( self.damagemod == "MOD_BURNED" )
        {
            if ( isdefined( self.damageweapon ) && isdefined( self.damageweapon.specialpain ) && self.damageweapon.specialpain == 0 )
            {
                self clientfield::set( "arch_actor_fire_fx", 2 );
            }
        }
    }
}

// Namespace archetype_damage_effects
// Params 0
// Checksum 0x99ec1590, Offset: 0x4d0
// Size: 0x4
function onhumankilled()
{
    
}

// Namespace archetype_damage_effects
// Params 0
// Checksum 0x99ec1590, Offset: 0x4e0
// Size: 0x4
function onrobotkilled()
{
    
}

// Namespace archetype_damage_effects
// Params 1
// Checksum 0x8cb7853b, Offset: 0x4f0
// Size: 0xc
function onvehiclekilled( params )
{
    
}

