#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_util;
#using scripts/cp/bonuszm/_bonuszm;
#using scripts/cp/bonuszm/_bonuszm_sound;
#using scripts/cp/voice/voice_z_blackstation;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/util_shared;

#namespace _bonuszm_blackstation;

// Namespace _bonuszm_blackstation
// Params 0, eflags: 0x2
// Checksum 0x9de3a588, Offset: 0x960
// Size: 0x1bc
function autoexec init()
{
    function_f5c30bc9();
    
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    mapname = getdvarstring( "mapname" );
    
    if ( !issubstr( mapname, "blackstation" ) )
    {
        return;
    }
    
    voice_z_blackstation::init_voice();
    level.bzm_blackstationdialogue1callback = &function_96eb55bd;
    level.bzm_blackstationdialogue2callback = &function_bcedd026;
    level.bzm_blackstationdialogue3callback = &function_e2f04a8f;
    level.bzm_blackstationdialogue3_1callback = &function_72835fe7;
    level.bzm_blackstationdialogue3_2callback = &function_7bf0ac;
    level.bzm_blackstationdialogue3_3callback = &function_267e6b15;
    level.bzm_blackstationdialogue3_4callback = &function_b476fbda;
    level.bzm_blackstationdialogue3_5callback = &function_da797643;
    level.bzm_blackstationdialogue4callback = &function_d8def1b0;
    level.bzm_blackstationdialogue4_1callback = &function_eaea4ccc;
    level.bzm_blackstationdialogue4_2callback = &function_5cf1bc07;
    level.bzm_blackstationdialogue4_3callback = &function_36ef419e;
    level.bzm_blackstationdialogue5callback = &function_fee16c19;
}

// Namespace _bonuszm_blackstation
// Params 0
// Checksum 0x42e56f7d, Offset: 0xb28
// Size: 0xf2
function function_f5c30bc9()
{
    wait 2;
    locationarray = [];
    array::add( locationarray, ( 1689, -8229, 242 ) );
    array::add( locationarray, ( 1389, -8470, 170 ) );
    
    foreach ( location in locationarray )
    {
        radiusdamage( location, 100, 400, 200 );
    }
}

// Namespace _bonuszm_blackstation
// Params 0
// Checksum 0x5e96a1b0, Offset: 0xc28
// Size: 0x124
function function_96eb55bd()
{
    level endon( #"bzm_sceneseqended" );
    wait 6;
    bonuszmsound::function_ef0ce9fb( "plyz_the_singapore_quaran_0" );
    wait 2;
    bonuszmsound::function_cf21d35c( "salm_bad_memories_0" );
    wait 0.5;
    bonuszmsound::function_ef0ce9fb( "plyz_you_know_damn_well_i_0" );
    wait 4;
    bonuszmsound::function_ef0ce9fb( "plyz_we_d_be_in_and_out_q_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_find_out_who_this_de_0" );
    wait 13;
    bonuszmsound::function_ef0ce9fb( "plyz_for_security_purpose_0" );
    bonuszmsound::function_cf21d35c( "salm_the_lock_i_assume_w_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_the_key_that_was_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_after_the_docks_our_0" );
}

// Namespace _bonuszm_blackstation
// Params 0
// Checksum 0x1d810f60, Offset: 0xd58
// Size: 0xe
function function_bcedd026()
{
    level endon( #"bzm_sceneseqended" );
}

// Namespace _bonuszm_blackstation
// Params 0
// Checksum 0xb43e4552, Offset: 0xd70
// Size: 0xd4
function function_e2f04a8f()
{
    level endon( #"bzm_sceneseqended" );
    wait 3;
    bonuszmsound::function_cf21d35c( "salm_more_vultures_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_praying_on_the_weak_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_after_the_safehouse_0" );
    bonuszmsound::function_cf21d35c( "salm_why_didn_t_you_step_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_calculated_risks_we_0" );
    bonuszmsound::function_cf21d35c( "salm_but_there_s_always_a_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_chance_is_a_billion_0" );
}

// Namespace _bonuszm_blackstation
// Params 0
// Checksum 0x6bc0f971, Offset: 0xe50
// Size: 0x2c
function function_72835fe7()
{
    level endon( #"bzm_sceneseqended" );
    wait 5;
    bonuszmsound::function_ef0ce9fb( "plyz_the_winds_were_picki_0" );
}

// Namespace _bonuszm_blackstation
// Params 0
// Checksum 0xed173589, Offset: 0xe88
// Size: 0x64
function function_7bf0ac()
{
    level endon( #"bzm_sceneseqended" );
    bonuszmsound::function_ef0ce9fb( "plyz_the_plan_was_to_wait_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_the_missiles_were_in_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_hendricks_said_fuck_0" );
}

// Namespace _bonuszm_blackstation
// Params 0
// Checksum 0x2b263eb6, Offset: 0xef8
// Size: 0x64
function function_267e6b15()
{
    level endon( #"bzm_sceneseqended" );
    level flag::wait_till( "container_console_active" );
    bonuszmsound::function_ef0ce9fb( "plyz_we_secured_the_first_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_hendricks_moved_to_s_0" );
}

// Namespace _bonuszm_blackstation
// Params 0
// Checksum 0x90c231c1, Offset: 0xf68
// Size: 0x6c
function function_b476fbda()
{
    level endon( #"bzm_sceneseqended" );
    wait 12;
    bonuszmsound::function_ef0ce9fb( "plyz_but_of_course_the_su_0" );
    wait 3;
    bonuszmsound::function_ef0ce9fb( "plyz_the_barge_ripped_fre_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_and_hang_on_for_dear_0" );
}

// Namespace _bonuszm_blackstation
// Params 0
// Checksum 0xb0a057ff, Offset: 0xfe0
// Size: 0x44
function function_da797643()
{
    level endon( #"bzm_sceneseqended" );
    bonuszmsound::function_ef0ce9fb( "plyz_we_d_been_set_to_ren_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_we_cut_through_the_f_0" );
}

// Namespace _bonuszm_blackstation
// Params 0
// Checksum 0x43ae0c98, Offset: 0x1030
// Size: 0x234
function function_d8def1b0()
{
    level endon( #"bzm_sceneseqended" );
    wait 1.5;
    bonuszmsound::function_ef0ce9fb( "plyz_with_the_dead_cleare_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_turns_out_we_weren_t_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_a_vulture_got_the_dr_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_you_were_a_payday_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_we_were_deadkillers_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_but_you_were_there_t_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_maybe_in_2070_when_w_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_kane_made_quick_work_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "salm_she_was_well_trained_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_it_didn_t_matter_sh_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_what_had_gone_wrong_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_we_hadn_t_taken_the_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_so_much_for_maintain_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "salm_but_kane_was_resourc_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_adapt_or_die_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_yeah_adapt_or_die_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_we_d_regroup_with_he_0" );
}

// Namespace _bonuszm_blackstation
// Params 0
// Checksum 0x2ce90d2a, Offset: 0x1270
// Size: 0xe
function function_eaea4ccc()
{
    level endon( #"bzm_sceneseqended" );
}

// Namespace _bonuszm_blackstation
// Params 0
// Checksum 0xfb231739, Offset: 0x1288
// Size: 0xc4
function function_5cf1bc07()
{
    level endon( #"bzm_sceneseqended" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_with_their_comms_scr_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_now_to_get_the_drive_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_you_couldn_t_take_be_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_the_feeling_had_latc_0" );
    bonuszmsound::function_cf21d35c( "salm_some_thing_not_so_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_i_just_felt_somet_0" );
}

// Namespace _bonuszm_blackstation
// Params 0
// Checksum 0x2a016f2f, Offset: 0x1358
// Size: 0xac
function function_36ef419e()
{
    level endon( #"bzm_sceneseqended" );
    wait 4;
    bonuszmsound::function_ef0ce9fb( "plyz_by_the_time_we_rende_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_what_was_kane_s_plan_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_hit_em_in_the_gulle_0" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_like_yourself_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_like_a_berserker_li_0" );
}

// Namespace _bonuszm_blackstation
// Params 0
// Checksum 0x6cdf8add, Offset: 0x1410
// Size: 0x1bc
function function_fee16c19()
{
    level endon( #"bzm_sceneseqended" );
    wait 1;
    bonuszmsound::function_cf21d35c( "salm_what_did_you_find_in_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_slaughtered_cia_staf_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_it_was_a_gruesome_sc_0" );
    bonuszmsound::function_cf21d35c( "salm_what_did_you_learn_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_we_found_a_dossie_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_they_fused_them_toge_0" );
    bonuszmsound::function_cf21d35c( "salm_control_them_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_those_corpses_below_0" );
    bonuszmsound::function_cf21d35c( "salm_the_gateway_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_the_gateway_to_malum_0" );
    bonuszmsound::function_cf21d35c( "salm_deimos_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_deimos_someone_did_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_there_was_also_infor_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_dolos_demigoddess_o_0" );
    bonuszmsound::function_cf21d35c( "salm_and_the_researcher_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_yes_it_was_wait_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_it_said_dr_salim_i_0" );
}

