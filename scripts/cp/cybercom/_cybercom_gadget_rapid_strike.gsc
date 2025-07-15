#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/abilities/_ability_util;
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

#namespace cybercom_gadget_rapid_strike;

// Namespace cybercom_gadget_rapid_strike
// Params 0
// Checksum 0x99ec1590, Offset: 0x340
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_gadget_rapid_strike
// Params 0
// Checksum 0xe0dcc19c, Offset: 0x350
// Size: 0x174
function main()
{
    cybercom_gadget::registerability( 1, 64 );
    callback::on_spawned( &on_player_spawned );
    level.cybercom.rapid_strike = spawnstruct();
    level.cybercom.rapid_strike._is_flickering = &_is_flickering;
    level.cybercom.rapid_strike._on_flicker = &_on_flicker;
    level.cybercom.rapid_strike._on_give = &_on_give;
    level.cybercom.rapid_strike._on_take = &_on_take;
    level.cybercom.rapid_strike._on_connect = &_on_connect;
    level.cybercom.rapid_strike._on = &_on;
    level.cybercom.rapid_strike._off = &_off;
}

// Namespace cybercom_gadget_rapid_strike
// Params 0
// Checksum 0x99ec1590, Offset: 0x4d0
// Size: 0x4
function on_player_spawned()
{
    
}

// Namespace cybercom_gadget_rapid_strike
// Params 1
// Checksum 0x847bb4e8, Offset: 0x4e0
// Size: 0xc
function _is_flickering( slot )
{
    
}

// Namespace cybercom_gadget_rapid_strike
// Params 2
// Checksum 0x3a188ef5, Offset: 0x4f8
// Size: 0x14
function _on_flicker( slot, weapon )
{
    
}

// Namespace cybercom_gadget_rapid_strike
// Params 2
// Checksum 0xf5ffacc3, Offset: 0x518
// Size: 0x2c
function _on_give( slot, weapon )
{
    self thread function_677ed44f( weapon );
}

// Namespace cybercom_gadget_rapid_strike
// Params 2
// Checksum 0x46483f67, Offset: 0x550
// Size: 0x22
function _on_take( slot, weapon )
{
    self notify( #"hash_343d4580" );
}

// Namespace cybercom_gadget_rapid_strike
// Params 0
// Checksum 0x99ec1590, Offset: 0x580
// Size: 0x4
function _on_connect()
{
    
}

// Namespace cybercom_gadget_rapid_strike
// Params 2
// Checksum 0x833df0b, Offset: 0x590
// Size: 0x14
function _on( slot, weapon )
{
    
}

// Namespace cybercom_gadget_rapid_strike
// Params 2
// Checksum 0x7e5e915c, Offset: 0x5b0
// Size: 0x14
function _off( slot, weapon )
{
    
}

// Namespace cybercom_gadget_rapid_strike
// Params 1
// Checksum 0x5e0d018a, Offset: 0x5d0
// Size: 0x190
function function_677ed44f( weapon )
{
    self notify( #"hash_677ed44f" );
    self endon( #"hash_677ed44f" );
    self endon( #"hash_343d4580" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        level waittill( #"rapid_strike", target, attacker, damage, weapon, hitorigin );
        self notify( weapon.name + "_fired" );
        level notify( weapon.name + "_fired" );
        wait 0.05;
        
        if ( isdefined( target ) )
        {
        }
        
        if ( isplayer( self ) )
        {
            itemindex = getitemindexfromref( "cybercom_rapidstrike" );
            
            if ( isdefined( itemindex ) )
            {
                self adddstat( "ItemStats", itemindex, "stats", "kills", "statValue", 1 );
                self adddstat( "ItemStats", itemindex, "stats", "used", "statValue", 1 );
            }
        }
    }
}

