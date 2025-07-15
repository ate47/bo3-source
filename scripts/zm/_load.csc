#using scripts/codescripts/struct;
#using scripts/shared/_oob;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/archetype_shared/archetype_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/clientfaceanim_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/footsteps_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/load_shared;
#using scripts/shared/music_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/zm/_ambient;
#using scripts/zm/_callbacks;
#using scripts/zm/_destructible;
#using scripts/zm/_global_fx;
#using scripts/zm/_radiant_live_update;
#using scripts/zm/_sticky_grenade;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_playerhealth;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_traps;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/gametypes/_weaponobjects;

#namespace load;

// Namespace load
// Params 3
// Checksum 0xeea521ca, Offset: 0x4f0
// Size: 0x3a
function levelnotifyhandler( clientnum, state, oldstate )
{
    if ( state != "" )
    {
        level notify( state, clientnum );
    }
}

// Namespace load
// Params 2
// Checksum 0x8aa5a2bb, Offset: 0x538
// Size: 0x14
function warnmissilelocking( localclientnum, set )
{
    
}

// Namespace load
// Params 2
// Checksum 0x45712abb, Offset: 0x558
// Size: 0x14
function warnmissilelocked( localclientnum, set )
{
    
}

// Namespace load
// Params 2
// Checksum 0x836bfe92, Offset: 0x578
// Size: 0x14
function warnmissilefired( localclientnum, set )
{
    
}

// Namespace load
// Params 0
// Checksum 0x12999f87, Offset: 0x598
// Size: 0x14c
function main()
{
    assert( isdefined( level.first_frame ), "<dev string:x28>" );
    zm::init();
    level thread server_time();
    level thread util::init_utility();
    util::register_system( "levelNotify", &levelnotifyhandler );
    register_clientfields();
    level.createfx_disable_fx = getdvarint( "disable_fx" ) == 1;
    
    if ( isdefined( level._uses_sticky_grenades ) && level._uses_sticky_grenades )
    {
        level thread _sticky_grenade::main();
    }
    
    system::wait_till( "all" );
    level thread art_review();
    level flagsys::set( "load_main_complete" );
}

// Namespace load
// Params 0
// Checksum 0x6d016e91, Offset: 0x6f0
// Size: 0x30
function server_time()
{
    for ( ;; )
    {
        level.servertime = getservertime( 0 );
        wait 0.01;
    }
}

// Namespace load
// Params 0
// Checksum 0xd69ff95c, Offset: 0x728
// Size: 0xf4
function register_clientfields()
{
    clientfield::register( "allplayers", "zmbLastStand", 1, 1, "int", &zm::laststand, 0, 1 );
    clientfield::register( "clientuimodel", "zmhud.swordEnergy", 1, 7, "float", undefined, 0, 0 );
    clientfield::register( "clientuimodel", "zmhud.swordState", 1, 4, "int", undefined, 0, 0 );
    clientfield::register( "clientuimodel", "zmhud.swordChargeUpdate", 1, 1, "counter", undefined, 0, 0 );
}

