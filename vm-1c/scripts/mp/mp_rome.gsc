#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_rome_fx;
#using scripts/mp/mp_rome_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_rome;

// Namespace mp_rome
// Params 0, eflags: 0x0
// Checksum 0xe53b71ba, Offset: 0x150
// Size: 0xfc
function main() {
    precache();
    mp_rome_fx::main();
    mp_rome_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_rome");
    setdvar("compassmaxrange", "2100");
    level.cleandepositpoints = array((1178.15, -2020.82, 294.125), (2647.03, -119.764, 216.125), (249.819, 944.336, 180.125), (-378.629, -1073.84, 352.125));
}

// Namespace mp_rome
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x258
// Size: 0x4
function precache() {
    
}

