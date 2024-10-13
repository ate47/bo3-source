#using scripts/mp/mp_veiled_heyday_sound;
#using scripts/mp/mp_veiled_heyday_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace mp_veiled_heyday;

// Namespace mp_veiled_heyday
// Params 0, eflags: 0x1 linked
// Checksum 0x6911c69e, Offset: 0x140
// Size: 0x5c
function main() {
    mp_veiled_heyday_fx::main();
    mp_veiled_heyday_sound::main();
    load::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_veiled";
}

