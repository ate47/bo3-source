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

#namespace zm_asylum_ffotd;

// Namespace zm_asylum_ffotd
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1f8
// Size: 0x4
function main_start() {
    
}

// Namespace zm_asylum_ffotd
// Params 0, eflags: 0x0
// Checksum 0x73c5ce6d, Offset: 0x208
// Size: 0x44
function main_end() {
    spawncollision("collision_player_wall_64x64x10", "collider", (1256, 355.5, -59), (0, 270, 0));
}

