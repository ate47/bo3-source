#using scripts/codescripts/struct;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace cybercom_tacrig_playermovement;

// Namespace cybercom_tacrig_playermovement
// Params 0
// Checksum 0x99ec1590, Offset: 0x258
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_tacrig_playermovement
// Params 0
// Checksum 0x47cfa095, Offset: 0x268
// Size: 0x9c
function main()
{
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    cybercom_tacrig::register_cybercom_rig_ability( "cybercom_playermovement", 5 );
    cybercom_tacrig::register_cybercom_rig_possession_callbacks( "cybercom_playermovement", &playermovementgive, &playermovementake );
}

// Namespace cybercom_tacrig_playermovement
// Params 0
// Checksum 0x99ec1590, Offset: 0x310
// Size: 0x4
function on_player_connect()
{
    
}

// Namespace cybercom_tacrig_playermovement
// Params 0
// Checksum 0x99ec1590, Offset: 0x320
// Size: 0x4
function on_player_spawned()
{
    
}

// Namespace cybercom_tacrig_playermovement
// Params 1
// Checksum 0xc95200f3, Offset: 0x330
// Size: 0x24
function playermovementgive( type )
{
    self thread cybercom_tacrig::turn_rig_ability_on( type );
}

// Namespace cybercom_tacrig_playermovement
// Params 1
// Checksum 0x66625d90, Offset: 0x360
// Size: 0x24
function playermovementake( type )
{
    self thread cybercom_tacrig::turn_rig_ability_off( type );
}

