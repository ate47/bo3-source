#using scripts/cp/cp_mi_sing_sgen_pallas;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace cp_mi_sing_sgen_revenge_igc;

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 2, eflags: 0x1 linked
// Checksum 0x90247713, Offset: 0x3f8
// Size: 0x1fc
function function_cc756659(str_objective, var_74cd64bc) {
    showmiscmodels("sgen_ocean_water");
    if (var_74cd64bc) {
        util::function_d8eaed3d(4);
        level scene::init("cin_sgen_20_twinrevenge_3rd_sh010");
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::complete("cp_level_sgen_descend_into_core");
        objectives::complete("cp_level_sgen_goto_signal_source");
        objectives::complete("cp_level_sgen_goto_server_room");
        objectives::complete("cp_level_sgen_confront_pallas");
        sgen::function_bff1a867(str_objective);
        level thread cp_mi_sing_sgen_pallas::function_4ef8cf79();
        load::function_a2995f22();
        level scene::play("cin_sgen_20_twinrevenge_3rd_sh010");
    }
    level waittill(#"hash_3f04e63f");
    util::clear_streamer_hint();
    util::wait_network_frame();
    level util::function_7d553ac6();
    streamerrequest("clear", "cin_sgen_19_ghost_3rd");
    streamerrequest("clear", "cin_sgen_20_twinrevenge_3rd");
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 4, eflags: 0x1 linked
// Checksum 0xe59384a6, Offset: 0x600
// Size: 0x3c
function function_b2f95c13(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    hidemiscmodels("sgen_ocean_water");
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 0, eflags: 0x1 linked
// Checksum 0x640e21ca, Offset: 0x648
// Size: 0x1dc
function function_a8e314e9() {
    level scene::add_scene_func("cin_sgen_20_twinrevenge_3rd_sh010", &set_exposure_bank, "play", 3);
    level scene::add_scene_func("cin_sgen_20_twinrevenge_3rd_sh010_nohint", &set_exposure_bank, "play", 3);
    level scene::add_scene_func("cin_sgen_20_twinrevenge_3rd_sh070", &set_exposure_bank, "play", 3);
    level scene::add_scene_func("cin_sgen_20_twinrevenge_3rd_sh070", &function_ac7d11ce, "play");
    level scene::add_scene_func("cin_sgen_20_twinrevenge_3rd_sh080", &function_867a9765, "play");
    level scene::add_scene_func("cin_sgen_20_twinrevenge_3rd_sh090", &function_a1234ba5, "play");
    level scene::add_scene_func("cin_sgen_20_twinrevenge_3rd_sh090", &function_46e34900, "done");
    if (sessionmodeiscampaignzombiesgame()) {
        level scene::add_scene_func("cin_sgen_20_twinrevenge_3rd_sh010", &function_c52866de, "play");
        level scene::add_scene_func("cin_sgen_20_twinrevenge_3rd_sh010_nohint", &function_c52866de, "play");
    }
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 1, eflags: 0x1 linked
// Checksum 0x3a6000c3, Offset: 0x830
// Size: 0x28
function function_c52866de(a_ents) {
    if (isdefined(level.var_847128ad)) {
        level thread [[ level.var_847128ad ]]();
    }
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 1, eflags: 0x1 linked
// Checksum 0x16ba821b, Offset: 0x860
// Size: 0x3c
function function_a1234ba5(a_ents) {
    level waittill(#"hash_a1234ba5");
    util::screen_fade_out(0, "black", "hide_trans_flood");
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 1, eflags: 0x1 linked
// Checksum 0x8f6bc434, Offset: 0x8a8
// Size: 0x64
function function_46e34900(a_ents) {
    util::clear_streamer_hint();
    set_exposure_bank(a_ents, 0);
    skipto::teleport("flood_combat");
    skipto::function_be8adfb8("twin_revenge");
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 1, eflags: 0x1 linked
// Checksum 0x226c020b, Offset: 0x918
// Size: 0x5c
function function_ac7d11ce(a_ents) {
    wait 1;
    level clientfield::set("w_twin_igc_fxanim", 1);
    wait 1;
    level clientfield::set("w_twin_igc_fxanim", 2);
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 1, eflags: 0x1 linked
// Checksum 0x35d7f110, Offset: 0x980
// Size: 0x34
function function_867a9765(a_ents) {
    wait 1;
    level clientfield::set("w_twin_igc_fxanim", 3);
}

// Namespace cp_mi_sing_sgen_revenge_igc
// Params 2, eflags: 0x1 linked
// Checksum 0x2e73e3bd, Offset: 0x9c0
// Size: 0x34
function set_exposure_bank(a_ents, b_set) {
    level clientfield::set("set_exposure_bank", b_set);
}

