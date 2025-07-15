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

#namespace cybercom_tacrig_multicore;

// Namespace cybercom_tacrig_multicore
// Params 0
// Checksum 0x99ec1590, Offset: 0x248
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_tacrig_multicore
// Params 0
// Checksum 0xab333ce6, Offset: 0x258
// Size: 0x9c
function main()
{
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    cybercom_tacrig::register_cybercom_rig_ability( "cybercom_multicore", 7 );
    cybercom_tacrig::register_cybercom_rig_possession_callbacks( "cybercom_multicore", &multicoregive, &multicoretake );
}

// Namespace cybercom_tacrig_multicore
// Params 0
// Checksum 0x99ec1590, Offset: 0x300
// Size: 0x4
function on_player_connect()
{
    
}

// Namespace cybercom_tacrig_multicore
// Params 0
// Checksum 0x99ec1590, Offset: 0x310
// Size: 0x4
function on_player_spawned()
{
    
}

// Namespace cybercom_tacrig_multicore
// Params 1
// Checksum 0x278a6cc2, Offset: 0x320
// Size: 0x24
function multicoregive( type )
{
    self thread cybercom_tacrig::turn_rig_ability_on( type );
}

// Namespace cybercom_tacrig_multicore
// Params 1
// Checksum 0xcd4df2ba, Offset: 0x350
// Size: 0x24
function multicoretake( type )
{
    self thread cybercom_tacrig::turn_rig_ability_off( type );
}

