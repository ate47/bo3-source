#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/table_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_attackables;

// Namespace zm_attackables
// Params 0, eflags: 0x2
// Checksum 0xd3ad68f8, Offset: 0x2f8
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "zm_attackables", &__init__, &__main__, undefined );
}

// Namespace zm_attackables
// Params 0
// Checksum 0xab6f11d8, Offset: 0x340
// Size: 0x1a6
function __init__()
{
    level.attackablecallback = &attackable_callback;
    level.attackables = struct::get_array( "scriptbundle_attackables", "classname" );
    
    foreach ( attackable in level.attackables )
    {
        attackable.bundle = struct::get_script_bundle( "attackables", attackable.scriptbundlename );
        
        if ( isdefined( attackable.target ) )
        {
            attackable.slot = struct::get_array( attackable.target, "targetname" );
        }
        
        attackable.is_active = 0;
        attackable.health = attackable.bundle.max_health;
        
        if ( getdvarint( "zm_attackables" ) > 0 )
        {
            attackable.is_active = 1;
            attackable.health = 1000;
        }
    }
}

// Namespace zm_attackables
// Params 0
// Checksum 0x99ec1590, Offset: 0x4f0
// Size: 0x4
function __main__()
{
    
}

// Namespace zm_attackables
// Params 0
// Checksum 0xb1b7fe98, Offset: 0x500
// Size: 0x15c
function get_attackable()
{
    foreach ( attackable in level.attackables )
    {
        if ( !( isdefined( attackable.is_active ) && attackable.is_active ) )
        {
            continue;
        }
        
        dist = distance( self.origin, attackable.origin );
        
        if ( dist < attackable.bundle.aggro_distance )
        {
            if ( attackable get_attackable_slot( self ) )
            {
                return attackable;
            }
        }
        
        /#
            if ( getdvarint( "<dev string:x28>" ) > 1 )
            {
                if ( attackable get_attackable_slot( self ) )
                {
                    return attackable;
                }
            }
        #/
    }
    
    return undefined;
}

// Namespace zm_attackables
// Params 1
// Checksum 0x61fb08c, Offset: 0x668
// Size: 0xd6, Type: bool
function get_attackable_slot( entity )
{
    self clear_slots();
    
    foreach ( slot in self.slot )
    {
        if ( !isdefined( slot.entity ) )
        {
            slot.entity = entity;
            entity.attackable_slot = slot;
            return true;
        }
    }
    
    return false;
}

// Namespace zm_attackables
// Params 0, eflags: 0x4
// Checksum 0xd7af7903, Offset: 0x748
// Size: 0xe4
function private clear_slots()
{
    foreach ( slot in self.slot )
    {
        if ( !isalive( slot.entity ) )
        {
            slot.entity = undefined;
            continue;
        }
        
        if ( isdefined( slot.entity.missinglegs ) && slot.entity.missinglegs )
        {
            slot.entity = undefined;
        }
    }
}

// Namespace zm_attackables
// Params 0
// Checksum 0x6e4e8d03, Offset: 0x838
// Size: 0x38
function activate()
{
    self.is_active = 1;
    
    if ( self.health <= 0 )
    {
        self.health = self.bundle.max_health;
    }
}

// Namespace zm_attackables
// Params 0
// Checksum 0xb70a0ad9, Offset: 0x878
// Size: 0x10
function deactivate()
{
    self.is_active = 0;
}

// Namespace zm_attackables
// Params 1
// Checksum 0x1522f874, Offset: 0x890
// Size: 0x74
function do_damage( damage )
{
    self.health -= damage;
    self notify( #"attackable_damaged" );
    
    if ( self.health <= 0 )
    {
        self notify( #"attackable_deactivated" );
        
        if ( !( isdefined( self.b_deferred_deactivation ) && self.b_deferred_deactivation ) )
        {
            self deactivate();
        }
    }
}

// Namespace zm_attackables
// Params 1
// Checksum 0xbf7f2ea3, Offset: 0x910
// Size: 0x9c
function attackable_callback( entity )
{
    if ( self.scriptbundlename === "zm_island_trap_plant_attackable" || entity.archetype === "thrasher" && self.scriptbundlename === "zm_island_trap_plant_upgraded_attackable" )
    {
        self do_damage( self.health );
        return;
    }
    
    self do_damage( entity.meleeweapon.meleedamage );
}

