#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;

#namespace zm_theater_ffotd;

// Namespace zm_theater_ffotd
// Params 0
// Checksum 0x99ec1590, Offset: 0x2a0
// Size: 0x4
function main_start()
{
    
}

// Namespace zm_theater_ffotd
// Params 0
// Checksum 0x80826b6d, Offset: 0x2b0
// Size: 0x364
function main_end()
{
    spawncollision( "collision_player_wall_256x256x10", "collider", ( 366, -1491, 208 ), ( 0, 270, 0 ) );
    spawncollision( "collision_player_256x256x256", "collider", ( -976, 1660, -48 ), ( 0, 0, 0 ) );
    spawncollision( "collision_player_wall_256x256x10", "collider", ( -737, 1637, 224 ), ( 0, 270, 0 ) );
    spawncollision( "collision_player_slick_wedge_32x128", "collider", ( -1668.5, -581, 113 ), ( 270, 0, 0 ) );
    spawncollision( "collision_player_wall_256x256x10", "collider", ( -1454.26, -308.955, 311.017 ), ( 0, 64.7, 0 ) );
    spawncollision( "collision_player_slick_wedge_32x128", "collider", ( -911.5, 1214.5, 80 ), ( 270, 0, 0 ) );
    spawncollision( "collision_player_slick_wedge_32x128", "collider", ( -779, 1663, 96 ), ( 270, 180, 0 ) );
    spawncollision( "collision_player_slick_wedge_32x128", "collider", ( 415.5, 1924.5, 96 ), ( 270, 180, 0 ) );
    spawncollision( "collision_player_wall_64x64x10", "collider", ( 584.5, -546, 455 ), ( 0, 356.599, 0 ) );
    spawncollision( "collision_player_wall_64x64x10", "collider", ( 577.5, -723, 455 ), ( 0, 0, 0 ) );
    spawncollision( "collision_player_slick_wedge_32x256", "collider", ( 407.5, -1356.5, 240 ), ( 270, 90, 0 ) );
    spawncollision( "collision_player_slick_wedge_32x128", "collider", ( 171, -1519, 193 ), ( 270, 0, 0 ) );
    spawncollision( "collision_player_wall_128x128x10", "collider", ( -136.5, -518.5, 140.5 ), ( 0, 273.899, 0 ) );
    zm::spawn_kill_brush( ( -968, 1603.5, -2.5 ), 110, 50 );
}

