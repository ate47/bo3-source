#using scripts/mp/mp_miniature_ant;
#using scripts/mp/mp_miniature_fly;
#using scripts/mp/mp_miniature_ladybug;
#using scripts/mp/mp_miniature_sound;
#using scripts/mp/mp_miniature_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/compass;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace namespace_58677593;

// Namespace namespace_58677593
// Params 0, eflags: 0x1 linked
// Checksum 0x6732c01b, Offset: 0x1e8
// Size: 0x12c
function main() {
    precache();
    namespace_91ce62cc::main();
    namespace_d016ed63::main();
    namespace_6b1ea3e0::main();
    namespace_5bde54f9::main();
    namespace_33aa6d71::main();
    load::main();
    compass::setupminimap("compass_map_mp_miniature");
    setdvar("compassmaxrange", "2100");
    level.cleandepositpoints = array((431.556, 153.622, 637.125), (1527.05, 1526.02, 640.125), (1283.92, -675.126, 640.125), (-906.502, 415.09, 544.125));
}

// Namespace namespace_58677593
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x320
// Size: 0x4
function precache() {
    
}

