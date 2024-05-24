#using scripts/mp/mp_apartments_lighting;
#using scripts/mp/mp_apartments_fx;
#using scripts/mp/mp_apartments_amb;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace mp_apartments;

// Namespace mp_apartments
// Params 0, eflags: 0x1 linked
// Checksum 0x794abeb4, Offset: 0x168
// Size: 0xbc
function main() {
    load::main();
    namespace_8a0e01ed::main();
    thread namespace_ad0e5c15::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_apartments";
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
    /#
        println("<unknown string>");
    #/
}

