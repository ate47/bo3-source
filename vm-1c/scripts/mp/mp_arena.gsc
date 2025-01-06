#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_arena_fx;
#using scripts/mp/mp_arena_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_arena;

// Namespace mp_arena
// Params 0, eflags: 0x0
// Checksum 0x5c5bbe0f, Offset: 0x150
// Size: 0xf4
function main() {
    precache();
    mp_arena_fx::main();
    mp_arena_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_arena");
    setdvar("compassmaxrange", "2100");
    level.cleandepositpoints = array((222.743, -1.71311, 64.125), (317.682, 1532.49, 160.125), (-327.224, -1275.68, 128.125), (1289, -1210.86, 128.125));
}

// Namespace mp_arena
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x250
// Size: 0x4
function precache() {
    
}

