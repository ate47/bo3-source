#using scripts/mp/mp_arena_sound;
#using scripts/mp/mp_arena_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_487ad092;

// Namespace namespace_487ad092
// Params 0, eflags: 0x1 linked
// namespace_487ad092<file_0>::function_d290ebfa
// Checksum 0x8dbe2465, Offset: 0x128
// Size: 0x5c
function main() {
    namespace_6d277d37::main();
    namespace_1b1d095e::main();
    load::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_arena";
}

