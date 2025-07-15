#using scripts/codescripts/struct;
#using scripts/cp/_challenges;
#using scripts/cp/_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_gadget_system_overload;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace cybercom_gadget_ravage_core;

// Namespace cybercom_gadget_ravage_core
// Params 0
// Checksum 0x99ec1590, Offset: 0x418
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_gadget_ravage_core
// Params 0
// Checksum 0x4eab8102, Offset: 0x428
// Size: 0x1a4
function main()
{
    cybercom_gadget::registerability( 0, 16 );
    level.cybercom.ravage_core = spawnstruct();
    level.cybercom.ravage_core._is_flickering = &_is_flickering;
    level.cybercom.ravage_core._on_flicker = &_on_flicker;
    level.cybercom.ravage_core._on_give = &_on_give;
    level.cybercom.ravage_core._on_take = &_on_take;
    level.cybercom.ravage_core._on_connect = &_on_connect;
    level.cybercom.ravage_core._on = &_on;
    level.cybercom.ravage_core._off = &_off;
    level.cybercom.ravage_core.weapon = getweapon( "gadget_ravage_core" );
    callback::on_spawned( &on_player_spawned );
}

// Namespace cybercom_gadget_ravage_core
// Params 0
// Checksum 0x99ec1590, Offset: 0x5d8
// Size: 0x4
function on_player_spawned()
{
    
}

// Namespace cybercom_gadget_ravage_core
// Params 1
// Checksum 0x7251ef06, Offset: 0x5e8
// Size: 0xc
function _is_flickering( slot )
{
    
}

// Namespace cybercom_gadget_ravage_core
// Params 2
// Checksum 0x3dd06780, Offset: 0x600
// Size: 0x14
function _on_flicker( slot, weapon )
{
    
}

// Namespace cybercom_gadget_ravage_core
// Params 2
// Checksum 0x2a23b567, Offset: 0x620
// Size: 0x2c
function _on_give( slot, weapon )
{
    self thread function_677ed44f( weapon );
}

// Namespace cybercom_gadget_ravage_core
// Params 2
// Checksum 0x8df9590c, Offset: 0x658
// Size: 0x22
function _on_take( slot, weapon )
{
    self notify( #"hash_343d4580" );
}

// Namespace cybercom_gadget_ravage_core
// Params 0
// Checksum 0x99ec1590, Offset: 0x688
// Size: 0x4
function _on_connect()
{
    
}

// Namespace cybercom_gadget_ravage_core
// Params 2
// Checksum 0x72f03944, Offset: 0x698
// Size: 0x14
function _on( slot, weapon )
{
    
}

// Namespace cybercom_gadget_ravage_core
// Params 2
// Checksum 0xb6821936, Offset: 0x6b8
// Size: 0x14
function _off( slot, weapon )
{
    
}

// Namespace cybercom_gadget_ravage_core
// Params 1
// Checksum 0xd6e69f2b, Offset: 0x6d8
// Size: 0x24a
function function_677ed44f( weapon )
{
    self notify( #"hash_677ed44f" );
    self endon( #"hash_677ed44f" );
    self endon( #"hash_343d4580" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        level waittill( #"ravage_core", target, attacker, damage, weapon, hitorigin );
        self notify( #"ravage_core", target, damage, weapon );
        destructserverutils::destructhitlocpieces( target, "torso_upper" );
        self notify( weapon.name + "_fired" );
        level notify( weapon.name + "_fired" );
        target hidepart( "j_chest_door" );
        target thread _corpsewatcher();
        target ai::set_behavior_attribute( "robot_lights", 1 );
        attacker thread challenges::function_96ed590f( "cybercom_uses_control" );
        
        if ( isplayer( self ) )
        {
            itemindex = getitemindexfromref( "cybercom_ravagecore" );
            
            if ( isdefined( itemindex ) )
            {
                self adddstat( "ItemStats", itemindex, "stats", "kills", "statValue", 1 );
                self adddstat( "ItemStats", itemindex, "stats", "used", "statValue", 1 );
            }
        }
        
        self waittill( #"grenade_fire" );
        self notify( #"hash_65afc94f" );
    }
}

// Namespace cybercom_gadget_ravage_core
// Params 0, eflags: 0x4
// Checksum 0xb50b5c32, Offset: 0x930
// Size: 0x44
function private _corpsewatcher()
{
    self waittill( #"actor_corpse", corpse );
    
    if ( isdefined( corpse ) )
    {
        corpse hidepart( "j_chest_door" );
    }
}

