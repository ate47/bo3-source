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
#using scripts/shared/weapons_shared;

#namespace cybercom_tacrig_copycat;

// Namespace cybercom_tacrig_copycat
// Params 0
// Checksum 0x99ec1590, Offset: 0x268
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_tacrig_copycat
// Params 0
// Checksum 0x82dfc26c, Offset: 0x278
// Size: 0x9c
function main()
{
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    cybercom_tacrig::register_cybercom_rig_ability( "cybercom_copycat", 6 );
    cybercom_tacrig::register_cybercom_rig_possession_callbacks( "cybercom_copycat", &copycatgive, &copycattake );
}

// Namespace cybercom_tacrig_copycat
// Params 0
// Checksum 0x99ec1590, Offset: 0x320
// Size: 0x4
function on_player_connect()
{
    
}

// Namespace cybercom_tacrig_copycat
// Params 0
// Checksum 0x99ec1590, Offset: 0x330
// Size: 0x4
function on_player_spawned()
{
    
}

// Namespace cybercom_tacrig_copycat
// Params 1
// Checksum 0x2aa30e24, Offset: 0x340
// Size: 0x24
function copycatgive( type )
{
    self thread cybercom_tacrig::turn_rig_ability_on( type );
}

// Namespace cybercom_tacrig_copycat
// Params 1
// Checksum 0x6c97d0a7, Offset: 0x370
// Size: 0x32
function copycattake( type )
{
    self thread cybercom_tacrig::turn_rig_ability_off( type );
    self notify( #"copycattake" );
}

