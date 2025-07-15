#using scripts/codescripts/struct;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_tactical_rig_proximitydeterrent;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_save;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace cybercom_tacrig_emergencyreserve;

// Namespace cybercom_tacrig_emergencyreserve
// Params 0
// Checksum 0x99ec1590, Offset: 0x3b0
// Size: 0x4
function init()
{
    
}

// Namespace cybercom_tacrig_emergencyreserve
// Params 0
// Checksum 0x7cde4f48, Offset: 0x3c0
// Size: 0x114
function main()
{
    callback::on_connect( &on_player_connect );
    callback::on_spawned( &on_player_spawned );
    setdvar( "scr_emergency_reserve_timer", 5 );
    setdvar( "scr_emergency_reserve_timer_upgraded", 8 );
    cybercom_tacrig::register_cybercom_rig_ability( "cybercom_emergencyreserve", 3 );
    cybercom_tacrig::register_cybercom_rig_possession_callbacks( "cybercom_emergencyreserve", &emergencyreservegive, &emergencyreservetake );
    cybercom_tacrig::register_cybercom_rig_activation_callbacks( "cybercom_emergencyreserve", &emergencyreserveactivate, &emergencyreservedeactivate );
}

// Namespace cybercom_tacrig_emergencyreserve
// Params 0
// Checksum 0x99ec1590, Offset: 0x4e0
// Size: 0x4
function on_player_connect()
{
    
}

// Namespace cybercom_tacrig_emergencyreserve
// Params 0
// Checksum 0x99ec1590, Offset: 0x4f0
// Size: 0x4
function on_player_spawned()
{
    
}

// Namespace cybercom_tacrig_emergencyreserve
// Params 1
// Checksum 0xf0f22155, Offset: 0x500
// Size: 0x54
function emergencyreservegive( type )
{
    self.lives = self savegame::get_player_data( "lives", 1 );
    self clientfield::set_to_player( "sndTacRig", 1 );
}

// Namespace cybercom_tacrig_emergencyreserve
// Params 1
// Checksum 0x788928ab, Offset: 0x560
// Size: 0x34
function emergencyreservetake( type )
{
    self.lives = 0;
    self clientfield::set_to_player( "sndTacRig", 0 );
}

// Namespace cybercom_tacrig_emergencyreserve
// Params 1
// Checksum 0x896ea942, Offset: 0x5a0
// Size: 0xbc
function emergencyreserveactivate( type )
{
    if ( self.lives < 1 )
    {
        return;
    }
    
    if ( self hascybercomrig( "cybercom_emergencyreserve" ) == 2 )
    {
        level thread cybercom_tacrig_proximitydeterrent::function_c0ba5acc( self );
    }
    
    self cybercom_tacrig::turn_rig_ability_off( "cybercom_emergencyreserve" );
    self playlocalsound( "gdt_cybercore_regen_godown" );
    playfx( "player/fx_plyr_ability_emergency_reserve_1p", self.origin );
}

// Namespace cybercom_tacrig_emergencyreserve
// Params 1
// Checksum 0xe9eee012, Offset: 0x668
// Size: 0xc
function emergencyreservedeactivate( type )
{
    
}

// Namespace cybercom_tacrig_emergencyreserve
// Params 1
// Checksum 0xe549a3da, Offset: 0x680
// Size: 0xa8, Type: bool
function validdeathtypesforemergencyreserve( smeansofdeath )
{
    if ( isdefined( smeansofdeath ) )
    {
        return ( issubstr( smeansofdeath, "_BULLET" ) || issubstr( smeansofdeath, "_GRENADE" ) || issubstr( smeansofdeath, "_MELEE" ) || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_SUICIDE" || smeansofdeath == "MOD_HEAD_SHOT" );
    }
    
    return false;
}

