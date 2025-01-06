#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_veiled_fx;
#using scripts/mp/mp_veiled_sound;
#using scripts/shared/util_shared;

#namespace mp_veiled;

// Namespace mp_veiled
// Params 0, eflags: 0x1 linked
// Checksum 0x5daef1e1, Offset: 0x128
// Size: 0x5c
function main() {
    mp_veiled_fx::main();
    mp_veiled_sound::main();
    load::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_veiled";
}

