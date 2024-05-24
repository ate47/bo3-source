#using scripts/mp/mp_havoc_sound;
#using scripts/mp/mp_havoc_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/shared/_oob;
#using scripts/shared/compass;
#using scripts/codescripts/struct;

#namespace namespace_7deb8b28;

// Namespace namespace_7deb8b28
// Params 0, eflags: 0x1 linked
// Checksum 0xbbbbf0d1, Offset: 0x188
// Size: 0x154
function main() {
    trigger = spawn("trigger_radius_out_of_bounds", (1957.05, 1538.25, -112.32), 0, 125, 350);
    trigger thread oob::run_oob_trigger();
    precache();
    namespace_923df269::main();
    namespace_5261409c::main();
    load::main();
    compass::setupminimap("compass_map_mp_havoc");
    setdvar("compassmaxrange", "2100");
    level.cleandepositpoints = array((1.29624, -584.847, 136.125), (-1513.77, -791.715, 8.125), (419.803, 1107.09, 8.93066), (300.251, -1300.87, 8.125));
}

// Namespace namespace_7deb8b28
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x2e8
// Size: 0x4
function precache() {
    
}

