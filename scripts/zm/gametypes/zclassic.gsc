#using scripts/codescripts/struct;
#using scripts/shared/math_shared;
#using scripts/zm/_zm_stats;
#using scripts/zm/gametypes/_zm_gametype;

#namespace zclassic;

// Namespace zclassic
// Params 0
// Checksum 0xc3eb8d6b, Offset: 0x110
// Size: 0x74
function main()
{
    zm_gametype::main();
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level._game_module_custom_spawn_init_func = &zm_gametype::custom_spawn_init_func;
    level._game_module_stat_update_func = &zm_stats::survival_classic_custom_stat_update;
}

// Namespace zclassic
// Params 0
// Checksum 0xec319984, Offset: 0x190
// Size: 0x24
function onprecachegametype()
{
    level.playersuicideallowed = 1;
    level.canplayersuicide = &zm_gametype::canplayersuicide;
}

// Namespace zclassic
// Params 0
// Checksum 0xe1c16f5e, Offset: 0x1c0
// Size: 0x154
function onstartgametype()
{
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    structs = struct::get_array( "player_respawn_point", "targetname" );
    
    foreach ( struct in structs )
    {
        level.spawnmins = math::expand_mins( level.spawnmins, struct.origin );
        level.spawnmaxs = math::expand_maxs( level.spawnmaxs, struct.origin );
    }
    
    level.mapcenter = math::find_box_center( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
}

