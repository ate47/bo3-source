#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_chinatown_fx;
#using scripts/mp/mp_chinatown_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_chinatown;

// Namespace mp_chinatown
// Params 0, eflags: 0x0
// Checksum 0xa32fff15, Offset: 0x2b8
// Size: 0x91
function main() {
    precache();
    mp_chinatown_fx::main();
    mp_chinatown_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_chinatown");
    setdvar("compassmaxrange", "2100");
    InvalidOpCode(0xc8, "strings", "war_callsign_a", %MPUI_CALLSIGN_MAPNAME_A);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace mp_chinatown
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x458
// Size: 0x2
function precache() {
    
}

