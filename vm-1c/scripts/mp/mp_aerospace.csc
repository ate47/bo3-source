#using scripts/mp/mp_aerospace_sound;
#using scripts/mp/mp_aerospace_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace mp_aerospace;

// Namespace mp_aerospace
// Params 0, eflags: 0x1 linked
// Checksum 0xbcd16c3b, Offset: 0x138
// Size: 0x5c
function main() {
    mp_aerospace_fx::main();
    mp_aerospace_sound::main();
    load::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_aerospace";
}

