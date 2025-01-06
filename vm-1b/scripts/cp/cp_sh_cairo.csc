#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_safehouse;
#using scripts/cp/_util;
#using scripts/cp/cp_sh_cairo_fx;
#using scripts/cp/cp_sh_cairo_sound;
#using scripts/shared/callbacks_shared;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace cp_sh_cairo;

// Namespace cp_sh_cairo
// Params 0, eflags: 0x0
// Checksum 0x3815ecb2, Offset: 0x198
// Size: 0x42
function main() {
    cp_sh_cairo_fx::main();
    cp_sh_cairo_sound::main();
    load::main();
    util::waitforclient(0);
}

