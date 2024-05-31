#using scripts/mp/mp_infection_sound;
#using scripts/mp/mp_infection_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_82e4b148;

// Namespace namespace_82e4b148
// Params 0, eflags: 0x1 linked
// namespace_82e4b148<file_0>::function_d290ebfa
// Checksum 0x1bee8b2b, Offset: 0x138
// Size: 0x5c
function main() {
    namespace_5d379c9::main();
    namespace_83fbe97c::main();
    load::main();
    util::waitforclient(0);
    level.endgamexcamname = "ui_cam_endgame_mp_infection";
}

