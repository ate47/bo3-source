#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_util;
#using scripts/cp/bonuszm/_bonuszm;
#using scripts/cp/bonuszm/_bonuszm_sound;
#using scripts/cp/voice/voice_z_infection;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/util_shared;

#namespace _bonuszm_infection;

// Namespace _bonuszm_infection
// Params 0, eflags: 0x2
// Checksum 0xdedebaa1, Offset: 0xb40
// Size: 0x2c4
function autoexec init()
{
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    mapname = getdvarstring( "mapname" );
    
    if ( !issubstr( mapname, "infection" ) )
    {
        return;
    }
    
    level.riser_type = "snow";
    voice_z_infection::init_voice();
    level.bzm_infectiondialogue1callback = &function_c7784263;
    level.bzm_infectiondialogue2callback = &function_5570d328;
    level.bzm_infectiondialogue3callback = &function_7b734d91;
    level.bzm_infectiondialogue4callback = &function_397fb19e;
    level.bzm_infectiondialogue5callback = &function_5f822c07;
    level.bzm_infectiondialogue6callback = &function_ed7abccc;
    level.bzm_infectiondialogue7callback = &function_137d3735;
    level.bzm_infectiondialogue8callback = &function_7161f4b2;
    level.bzm_infectiondialogue8_1callback = &function_b0c5d8fa;
    level.bzm_infectiondialogue9callback = &function_97646f1b;
    level.bzm_infectiondialogue10callback = &function_44d98e29;
    level.bzm_infectiondialogue11callback = &function_1ed713c0;
    level.bzm_infectiondialogue12callback = &function_90de82fb;
    level.bzm_infectiondialogue13callback = &function_6adc0892;
    level.bzm_infectiondialogue14callback = &function_dce377cd;
    level.bzm_infectiondialogue15callback = &function_b6e0fd64;
    level.bzm_infectiondialogue16callback = &function_28e86c9f;
    level.bzm_infectiondialogue17callback = &function_2e5f236;
    level.bzm_infectiondialogue18callback = &function_74ed6171;
    level.bzm_infectiondialogue19callback = &function_4eeae708;
    level.bzm_infectiondialogue20callback = &function_88257448;
    level.bzm_infectiondialogue21callback = &function_ae27eeb1;
    level.bzm_infectiondialogue22callback = &function_d42a691a;
    level.bzm_infectiondialogue23callback = &function_fa2ce383;
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0xdfe85fa4, Offset: 0xe10
// Size: 0xcc
function function_c7784263()
{
    level endon( #"bzm_sceneseqended" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_deimos_was_going_to_0" );
    bonuszmsound::function_cf21d35c( "salm_it_wasn_t_odd_that_h_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_there_wasn_t_time_to_0" );
    wait 5;
    bonuszmsound::function_ef0ce9fb( "plyz_she_was_waiting_she_0" );
    level flag::wait_till( "player_exiting_downed_vtol" );
    bonuszmsound::function_ef0ce9fb( "plyz_deimos_was_using_tay_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_if_we_were_gonna_fin_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0xf70ae381, Offset: 0xee8
// Size: 0x4c
function function_5570d328()
{
    level endon( #"bzm_sceneseqended" );
    wait 6;
    bonuszmsound::function_ef0ce9fb( "plyz_i_d_interfaced_with_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_but_this_was_differe_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0x19672da3, Offset: 0xf40
// Size: 0x12c
function function_7b734d91()
{
    level endon( #"bzm_sceneseqended" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_interfacing_with_som_0" );
    bonuszmsound::function_cf21d35c( "salm_because_the_deep_sub_0" );
    bonuszmsound::function_cf21d35c( "salm_the_human_subconscio_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_but_but_you_said_0" );
    bonuszmsound::function_cf21d35c( "salm_no_i_told_you_to_ta_0" );
    
    while ( !level flag::exists( "baby_picked_up" ) )
    {
        wait 1;
    }
    
    level flag::wait_till( "baby_picked_up" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_please_why_are_you_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_why_are_you_lying_to_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_i_m_afraid_you_don_t_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0xf2c93b82, Offset: 0x1078
// Size: 0x184
function function_397fb19e()
{
    level endon( #"bzm_sceneseqended" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_lead_me_to_the_depth_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_project_corvus_2060_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_sarah_she_told_me_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_he_knew_everything_a_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_she_learned_the_coal_0" );
    bonuszmsound::function_cf21d35c( "salm_well_i_did_what_had_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_but_in_the_lab_i_saw_0" );
    bonuszmsound::function_cf21d35c( "salm_i_saw_deimos_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_you_you_did_this_y_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_i_brought_mankind_s_0" );
    wait 3;
    bonuszmsound::function_cf21d35c( "salm_after_many_years_i_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_you_you_created_the_0" );
    bonuszmsound::function_cf21d35c( "salm_well_his_undead_ser_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0x50bc5ba2, Offset: 0x1208
// Size: 0xe
function function_5f822c07()
{
    level endon( #"bzm_sceneseqended" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0x7b4f27c2, Offset: 0x1220
// Size: 0xa4
function function_ed7abccc()
{
    level endon( #"bzm_sceneseqended" );
    wait 3;
    bonuszmsound::function_ef0ce9fb( "plyz_we_we_were_built_0" );
    wait 3;
    bonuszmsound::function_ef0ce9fb( "plyz_we_created_the_very_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_he_was_a_prisoner_c_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_we_were_vehicles_for_0" );
    bonuszmsound::function_cf21d35c( "salm_that_makes_it_sound_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0x3c16fbdb, Offset: 0x12d0
// Size: 0x64
function function_137d3735()
{
    level endon( #"bzm_sceneseqended" );
    wait 3;
    bonuszmsound::function_cf21d35c( "salm_tell_me_what_did_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_failure_when_she_wa_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_we_didn_t_know_how_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0xcf9dbf1, Offset: 0x1340
// Size: 0x6c
function function_7161f4b2()
{
    level endon( #"bzm_sceneseqended" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_the_world_began_to_f_0" );
    wait 2;
    bonuszmsound::function_45809471( "deim_sarah_listen_to_t_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_he_he_was_trying_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0xa395a652, Offset: 0x13b8
// Size: 0x64
function function_b0c5d8fa()
{
    level endon( #"bzm_sceneseqended" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_her_mind_was_fractur_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_you_were_deep_within_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_you_think_i_wasn_t_s_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0x8640d503, Offset: 0x1428
// Size: 0x2c
function function_97646f1b()
{
    level endon( #"bzm_sceneseqended" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_from_the_moment_she_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0xa814ba5c, Offset: 0x1460
// Size: 0xcc
function function_44d98e29()
{
    level endon( #"bzm_sceneseqended" );
    wait 8;
    bonuszmsound::function_ef0ce9fb( "plyz_he_slaughtered_the_s_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_why_did_he_kill_them_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_the_documentation_of_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_he_was_angry_the_da_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_the_piece_hendricks_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_deimos_didn_t_want_s_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0x24f51c09, Offset: 0x1538
// Size: 0x4c
function function_1ed713c0()
{
    level endon( #"bzm_sceneseqended" );
    wait 7;
    bonuszmsound::function_ef0ce9fb( "plyz_we_were_in_foy_i_sa_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_she_told_me_to_follo_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0x4c9b68d3, Offset: 0x1590
// Size: 0x2c
function function_90de82fb()
{
    level endon( #"bzm_sceneseqended" );
    wait 12;
    bonuszmsound::function_ef0ce9fb( "plyz_there_was_a_chapel_a_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0x2daae2a4, Offset: 0x15c8
// Size: 0x64
function function_6adc0892()
{
    level endon( #"bzm_sceneseqended" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_you_re_insane_0" );
    bonuszmsound::function_cf21d35c( "salm_no_i_told_you_befor_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_he_needed_taylor_to_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0xfb9b6ec2, Offset: 0x1638
// Size: 0x4c
function function_dce377cd()
{
    level endon( #"bzm_sceneseqended" );
    wait 3;
    bonuszmsound::function_ef0ce9fb( "plyz_the_aquifers_their_0" );
    wait 4;
    bonuszmsound::function_ef0ce9fb( "plyz_deimos_couldn_t_acce_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0x21b508b, Offset: 0x1690
// Size: 0x84
function function_b6e0fd64()
{
    level endon( #"bzm_sceneseqended" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_there_s_something_i_0" );
    wait 4;
    bonuszmsound::function_ef0ce9fb( "plyz_but_deimos_wasn_t_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_no_my_child_dr_sa_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_was_wait_what_d_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0xde276e09, Offset: 0x1720
// Size: 0xd4
function function_28e86c9f()
{
    level endon( #"bzm_sceneseqended" );
    wait 2;
    bonuszmsound::function_cf21d35c( "salm_i_must_say_i_m_impr_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_they_found_you_they_0" );
    bonuszmsound::function_cf21d35c( "deim_dr_salim_was_no_all_0" );
    bonuszmsound::function_45809471( "salm_you_humans_even_whe_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_no_1" );
    bonuszmsound::function_45809471( "deim_even_now_you_still_h_0" );
    bonuszmsound::function_45809471( "deim_look_at_how_she_stru_0" );
    bonuszmsound::function_45809471( "deim_i_am_humanity_s_salv_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0xa2b70a58, Offset: 0x1800
// Size: 0xe
function function_2e5f236()
{
    level endon( #"bzm_sceneseqended" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0xbf76cf58, Offset: 0x1818
// Size: 0x64
function function_74ed6171()
{
    level endon( #"bzm_sceneseqended" );
    wait 10;
    bonuszmsound::function_ef0ce9fb( "plyz_the_tree_i_ve_seen_0" );
    bonuszmsound::function_45809471( "deim_tell_me_what_do_you_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_you_awaited_her_sacr_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0x35e44b83, Offset: 0x1888
// Size: 0x44
function function_fa2ce383()
{
    level endon( #"bzm_sceneseqended" );
    wait 1;
    bonuszmsound::function_45809471( "deim_you_you_wouldn_t_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_if_she_offered_herse_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0xba482fc5, Offset: 0x18d8
// Size: 0x2c
function function_4eeae708()
{
    level endon( #"bzm_sceneseqended" );
    wait 2;
    bonuszmsound::function_45809471( "deim_you_denied_me_my_pri_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0xc47f9571, Offset: 0x1910
// Size: 0x74
function function_88257448()
{
    level endon( #"bzm_sceneseqended" );
    wait 1;
    bonuszmsound::function_45809471( "deim_but_now_i_had_you_i_0" );
    bonuszmsound::function_45809471( "deim_sarah_may_have_told_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_they_located_taylor_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_she_said_there_was_m_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0xaf82ac4f, Offset: 0x1990
// Size: 0x44
function function_ae27eeb1()
{
    level endon( #"bzm_sceneseqended" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_i_had_to_find_taylor_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_she_said_if_i_wanted_0" );
}

// Namespace _bonuszm_infection
// Params 0
// Checksum 0x9064b1e5, Offset: 0x19e0
// Size: 0x12c
function function_d42a691a()
{
    level endon( #"bzm_sceneseqended" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_i_tried_to_approach_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_deimos_had_other_ide_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_to_get_to_her_i_had_0" );
    
    while ( !flag::exists( "cathedral_quad_tank_destroyed" ) )
    {
        wait 1;
    }
    
    level flag::wait_till( "cathedral_quad_tank_destroyed" );
    wait 10;
    bonuszmsound::function_ef0ce9fb( "plyz_she_told_me_to_appro_0" );
    wait 2;
    bonuszmsound::function_cf21d35c( "salm_sarah_couldn_t_under_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_the_ultimate_gift_d_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_relinquishing_contro_0" );
}

