#using scripts/mp/mp_aerospace_sound;
#using scripts/mp/mp_aerospace_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_228a7338;

// Namespace namespace_228a7338
// Params 0, eflags: 0x1 linked
// Checksum 0xbcd16c3b, Offset: 0x138
// Size: 0x5c
function main() {
    namespace_32af6759::main();
    namespace_8a2f364c::main();
    load::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_aerospace";
}

