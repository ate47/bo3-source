#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/mp_apartments_amb;
#using scripts/mp/mp_apartments_fx;
#using scripts/mp/mp_apartments_lighting;
#using scripts/shared/util_shared;

#namespace mp_apartments;

// Namespace mp_apartments
// Params 0, eflags: 0x0
// Checksum 0x43f5fe0d, Offset: 0x168
// Size: 0x9a
function main() {
    load::main();
    mp_apartments_fx::main();
    thread mp_apartments_amb::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_apartments";
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
    println("<dev string:x28>");
}

