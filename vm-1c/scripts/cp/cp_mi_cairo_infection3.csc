#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection3_fx;
#using scripts/cp/cp_mi_cairo_infection3_patch_c;
#using scripts/cp/cp_mi_cairo_infection3_sound;
#using scripts/cp/cp_mi_cairo_infection_hideout_outro;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_zombies;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_infection3;

// Namespace cp_mi_cairo_infection3
// Params 0, eflags: 0x0
// Checksum 0x8130ce34, Offset: 0x220
// Size: 0xa4
function main() {
    util::function_57b966c8(&force_streamer, 11);
    cp_mi_cairo_infection3_fx::main();
    cp_mi_cairo_infection3_sound::main();
    namespace_b0a87e94::main();
    namespace_6473bd03::main();
    load::main();
    util::waitforclient(0);
    cp_mi_cairo_infection3_patch_c::function_7403e82b();
}

// Namespace cp_mi_cairo_infection3
// Params 1, eflags: 0x0
// Checksum 0x6acf8025, Offset: 0x2d0
// Size: 0x72
function force_streamer(n_zone) {
    switch (n_zone) {
    case 4:
        forcestreambundle("cin_inf_14_04_sarah_vign_05");
        break;
    case 10:
        forcestreamxmodel("c_hro_salim_base_fb");
        break;
    default:
        break;
    }
}

