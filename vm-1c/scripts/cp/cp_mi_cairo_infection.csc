#using scripts/cp/cp_mi_cairo_infection_patch_c;
#using scripts/cp/_siegebot_theia;
#using scripts/cp/cp_mi_cairo_infection_sgen_test_chamber;
#using scripts/cp/cp_mi_cairo_infection_sim_reality_starts;
#using scripts/cp/cp_mi_cairo_infection_theia_battle;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_sound;
#using scripts/cp/cp_mi_cairo_infection_fx;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/codescripts/struct;

#namespace namespace_1477b376;

// Namespace namespace_1477b376
// Params 0, eflags: 0x0
// Checksum 0x2a899235, Offset: 0x5f8
// Size: 0xc4
function main() {
    init_clientfields();
    util::function_57b966c8(&function_71f88fc, 11);
    namespace_dff03fd3::main();
    namespace_5fae4ea::main();
    namespace_c024ffd::main();
    namespace_34269b51::main();
    namespace_c7c6fa6::main();
    load::main();
    util::waitforclient(0);
    namespace_f397b667::function_7403e82b();
}

// Namespace namespace_1477b376
// Params 0, eflags: 0x0
// Checksum 0xc202d5df, Offset: 0x6c8
// Size: 0x4c
function init_clientfields() {
    clientfield::register("world", "set_exposure_bank", 1, 2, "int", &function_1e832062, 0, 0);
}

// Namespace namespace_1477b376
// Params 1, eflags: 0x0
// Checksum 0x2289709a, Offset: 0x720
// Size: 0x3da
function function_71f88fc(n_zone) {
    switch (n_zone) {
    case 1:
        forcestreamxmodel("veh_t7_mil_vtol_egypt_cabin_details_attch");
        forcestreamxmodel("veh_t7_mil_vtol_egypt_cabin_details_attch_screenglows");
        forcestreamxmodel("veh_t7_mil_vtol_egypt_screens_d1");
        break;
    case 6:
        forcestreamxmodel("c_spc_decayman_stage1_fb");
        forcestreamxmodel("c_spc_decayman_stage1_tout_fb");
        forcestreamxmodel("c_spc_decayman_stage2_tin_fb");
        forcestreamxmodel("c_spc_decayman_stage2_fb");
        forcestreamxmodel("c_spc_decayman_stage2_tout_fb");
        forcestreamxmodel("c_spc_decayman_stage3_tin_fb");
        forcestreamxmodel("c_spc_decayman_stage3_fb");
        forcestreamxmodel("c_spc_decayman_stage4_fb");
        break;
    case 9:
        forcestreambundle("cin_inf_04_humanlabdeath_3rd_sh150");
        forcestreamxmodel("c_spc_decayman_stage1_fb");
        forcestreamxmodel("c_spc_decayman_stage1_tout_fb");
        forcestreamxmodel("c_spc_decayman_stage2_tin_fb");
        forcestreamxmodel("c_spc_decayman_stage2_fb");
        forcestreamxmodel("c_spc_decayman_stage2_tout_fb");
        forcestreamxmodel("c_spc_decayman_stage3_tin_fb");
        forcestreamxmodel("c_spc_decayman_stage3_fb");
        forcestreamxmodel("c_spc_decayman_stage4_fb");
        break;
    case 3:
        forcestreamxmodel("c_hro_sarah_base_body");
        forcestreamxmodel("c_hro_sarah_base_head");
        forcestreambundle("cin_inf_04_02_sarah_vign_01");
        forcestreamxmodel("c_hro_maretti_base_body");
        forcestreamxmodel("c_hro_maretti_base_head");
        forcestreamxmodel("c_hro_taylor_base_body");
        forcestreamxmodel("c_hro_taylor_base_head");
        forcestreamxmodel("c_hro_diaz_base_body");
        forcestreamxmodel("c_hro_diaz_base_head");
        forcestreambundle("cin_inf_05_taylorinfected_3rd_sh010");
        forcestreambundle("cin_inf_05_taylorinfected_3rd_sh020");
        forcestreambundle("cin_inf_05_taylorinfected_3rd_sh030");
        forcestreambundle("cin_inf_05_taylorinfected_3rd_sh040");
        forcestreambundle("cin_inf_05_taylorinfected_3rd_sh050");
        forcestreambundle("cin_inf_05_taylorinfected_3rd_sh060");
        forcestreambundle("cin_inf_05_taylorinfected_3rd_sh070");
        forcestreambundle("cin_inf_05_taylorinfected_3rd_sh080");
        break;
    default:
        break;
    }
}

// Namespace namespace_1477b376
// Params 7, eflags: 0x0
// Checksum 0x6c1d0b05, Offset: 0xb08
// Size: 0x64
function function_1e832062(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != oldval) {
        setexposureactivebank(localclientnum, newval);
    }
}

