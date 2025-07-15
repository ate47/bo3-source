#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_infection_fx;
#using scripts/mp/mp_infection_sound;
#using scripts/shared/util_shared;

#namespace mp_infection;

// Namespace mp_infection
// Params 0
// Checksum 0x1bee8b2b, Offset: 0x138
// Size: 0x5c
function main()
{
    mp_infection_fx::main();
    mp_infection_sound::main();
    load::main();
    util::waitforclient( 0 );
    level.endgamexcamname = "ui_cam_endgame_mp_infection";
}

