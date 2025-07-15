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

#namespace cybercom_tacrig_sensorybuffer;

// Namespace cybercom_tacrig_sensorybuffer
// Params 0
// Checksum 0x99ec1590, Offset: 0x298
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_tacrig_sensorybuffer
// Params 0
// Checksum 0x887217cd, Offset: 0x2a8
// Size: 0xd4
function main()
{
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    cybercom_tacrig::register_cybercom_rig_ability( "cybercom_sensorybuffer", 4 );
    cybercom_tacrig::register_cybercom_rig_possession_callbacks( "cybercom_sensorybuffer", &sensorybuffergive, &sensorybuffertake );
    cybercom_tacrig::register_cybercom_rig_activation_callbacks( "cybercom_sensorybuffer", &sensorybufferactivate, &sensorybufferdeactivate );
}

// Namespace cybercom_tacrig_sensorybuffer
// Params 0
// Checksum 0x99ec1590, Offset: 0x388
// Size: 0x4
function on_player_connect()
{
    
}

// Namespace cybercom_tacrig_sensorybuffer
// Params 0
// Checksum 0x99ec1590, Offset: 0x398
// Size: 0x4
function on_player_spawned()
{
    
}

// Namespace cybercom_tacrig_sensorybuffer
// Params 1
// Checksum 0x46778232, Offset: 0x3a8
// Size: 0x24
function sensorybuffergive( type )
{
    self thread cybercom_tacrig::turn_rig_ability_on( type );
}

// Namespace cybercom_tacrig_sensorybuffer
// Params 1
// Checksum 0x7bd3152, Offset: 0x3d8
// Size: 0x24
function sensorybuffertake( type )
{
    self thread cybercom_tacrig::turn_rig_ability_off( type );
}

// Namespace cybercom_tacrig_sensorybuffer
// Params 1
// Checksum 0xee152609, Offset: 0x408
// Size: 0x8c
function sensorybufferactivate( type )
{
    self setperk( "specialty_bulletflinch" );
    self setperk( "specialty_flashprotection" );
    
    if ( self hascybercomrig( type ) == 2 )
    {
        self setperk( "specialty_flakjacket" );
    }
}

// Namespace cybercom_tacrig_sensorybuffer
// Params 1
// Checksum 0x2b53e040, Offset: 0x4a0
// Size: 0x8c
function sensorybufferdeactivate( type )
{
    self unsetperk( "specialty_bulletflinch" );
    self unsetperk( "specialty_flashprotection" );
    
    if ( self hascybercomrig( type ) == 2 )
    {
        self unsetperk( "specialty_flakjacket" );
    }
}

