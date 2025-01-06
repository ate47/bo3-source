#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_siegebot_theia;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection_fx;
#using scripts/cp/cp_mi_cairo_infection_patch_c;
#using scripts/cp/cp_mi_cairo_infection_sgen_test_chamber;
#using scripts/cp/cp_mi_cairo_infection_sim_reality_starts;
#using scripts/cp/cp_mi_cairo_infection_sound;
#using scripts/cp/cp_mi_cairo_infection_theia_battle;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;

#namespace cp_mi_cairo_infection;

// Namespace cp_mi_cairo_infection
// Params 0, eflags: 0x0
// Checksum 0x2a899235, Offset: 0x5f8
// Size: 0xc4
function main() {
    init_clientfields();
    util::function_57b966c8(&force_streamer, 11);
    cp_mi_cairo_infection_fx::main();
    cp_mi_cairo_infection_sound::main();
    cp_mi_cairo_infection_theia_battle::main();
    cp_mi_cairo_infection_sim_reality_starts::main();
    cp_mi_cairo_infection_sgen_test_chamber::main();
    load::main();
    util::waitforclient(0);
    cp_mi_cairo_infection_patch_c::function_7403e82b();
}

// Namespace cp_mi_cairo_infection
// Params 0, eflags: 0x0
// Checksum 0xc202d5df, Offset: 0x6c8
// Size: 0x4c
function init_clientfields() {
    clientfield::register("world", "set_exposure_bank", 1, 2, "int", &set_exposure_bank, 0, 0);
}

// Namespace cp_mi_cairo_infection
// Params 1, eflags: 0x0
// Checksum 0x2289709a, Offset: 0x720
// Size: 0x3da
function force_streamer(n_zone) {
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

// Namespace cp_mi_cairo_infection
// Params 7, eflags: 0x0
// Checksum 0x6c1d0b05, Offset: 0xb08
// Size: 0x64
function set_exposure_bank(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != oldval) {
        setexposureactivebank(localclientnum, newval);
    }
}

