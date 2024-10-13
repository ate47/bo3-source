#using scripts/mp/mp_arena_sound;
#using scripts/mp/mp_arena_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace mp_arena;

// Namespace mp_arena
// Params 0, eflags: 0x1 linked
// Checksum 0x8dbe2465, Offset: 0x128
// Size: 0x5c
function main() {
    mp_arena_fx::main();
    mp_arena_sound::main();
    load::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_arena";
}

