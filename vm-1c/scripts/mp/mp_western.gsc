#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_western_fx;
#using scripts/mp/mp_western_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_western;

// Namespace mp_western
// Params 0, eflags: 0x0
// Checksum 0xe8b09aa1, Offset: 0x158
// Size: 0xfc
function main() {
    precache();
    mp_western_fx::main();
    mp_western_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_western");
    setdvar("compassmaxrange", "2100");
    level.cleandepositpoints = array((437.78, -102.978, -47.875), (-1243.35, 275.134, -59.3878), (49.4596, -1096.53, -95.0967), (1277.44, -40.5919, -56.1511));
}

// Namespace mp_western
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x260
// Size: 0x4
function precache() {
    
}

