#using scripts/mp/mp_western_sound;
#using scripts/mp/mp_western_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/compass;
#using scripts/shared/util_shared;
#using scripts/shared/_oob;
#using scripts/codescripts/struct;

#namespace namespace_866151e1;

// Namespace namespace_866151e1
// Params 0, eflags: 0x1 linked
// Checksum 0x100e9159, Offset: 0x170
// Size: 0xfc
function main() {
    precache();
    namespace_6bc29a36::main();
    namespace_47e70ea9::main();
    load::main();
    compass::setupminimap("compass_map_mp_western");
    setdvar("compassmaxrange", "2100");
    level.cleandepositpoints = array((437.78, -102.978, -47.875), (-1243.35, 275.134, -59.3878), (49.4596, -1096.53, -95.0967), (1277.44, -40.5919, -56.1511));
}

// Namespace namespace_866151e1
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x278
// Size: 0x4
function precache() {
    
}

