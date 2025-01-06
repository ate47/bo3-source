#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_biodome_fx;
#using scripts/mp/mp_biodome_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_biodome;

// Namespace mp_biodome
// Params 0, eflags: 0x0
// Checksum 0x58f7553, Offset: 0x2c0
// Size: 0xa9
function main() {
    precache();
    setdvar("phys_buoyancy", 1);
    mp_biodome_fx::main();
    mp_biodome_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_biodome");
    setdvar("compassmaxrange", "2100");
    InvalidOpCode(0xc8, "strings", "war_callsign_a", %MPUI_CALLSIGN_MAPNAME_A);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace mp_biodome
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x478
// Size: 0x2
function precache() {
    
}

