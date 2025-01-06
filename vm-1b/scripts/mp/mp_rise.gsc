#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/mp_rise_amb;
#using scripts/mp/mp_rise_fx;
#using scripts/shared/compass;

#namespace mp_rise;

// Namespace mp_rise
// Params 0, eflags: 0x0
// Checksum 0xe928d880, Offset: 0x290
// Size: 0x81
function main() {
    mp_rise_fx::main();
    load::main();
    compass::setupminimap("compass_map_mp_rise");
    mp_rise_amb::main();
    setdvar("compassmaxrange", "2100");
    InvalidOpCode(0xc8, "strings", "war_callsign_a", %MPUI_CALLSIGN_MAPNAME_A);
    // Unknown operator (0xc8, t7_1b, PC)
}

