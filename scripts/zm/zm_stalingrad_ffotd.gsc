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

#namespace zm_stalingrad_ffotd;

// Namespace zm_stalingrad_ffotd
// Params 0
// Checksum 0x932ba43e, Offset: 0x230
// Size: 0x104
function main_start()
{
    spawncollision( "collision_player_wall_256x256x10", "collider", ( 988, 3524, 380 ), ( 0, 90, 0 ) );
    spawncollision( "collision_player_wall_256x256x10", "collider", ( 988, 3524, 636 ), ( 0, 90, 0 ) );
    spawncollision( "collision_player_64x64x128", "collider", ( -1184, 2947, 224 ), ( 0, -45, 0 ) );
    spawncollision( "collision_player_64x64x128", "collider", ( -1224, 2971, 224 ), ( 0, -17, 0 ) );
}

// Namespace zm_stalingrad_ffotd
// Params 0
// Checksum 0xe7c00023, Offset: 0x340
// Size: 0x1c
function main_end()
{
    level function_30409839();
}

// Namespace zm_stalingrad_ffotd
// Params 0
// Checksum 0x6fd428df, Offset: 0x368
// Size: 0xdc
function function_30409839()
{
    var_5d655ddb = struct::get_array( "intermission", "targetname" );
    
    foreach ( var_13e6937b in var_5d655ddb )
    {
        if ( var_13e6937b.origin == ( -3106, 2242, 653 ) )
        {
            var_13e6937b struct::delete();
            return;
        }
    }
}

