#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_util;
#using scripts/cp/bonuszm/_bonuszm;
#using scripts/cp/bonuszm/_bonuszm_sound;
#using scripts/cp/voice/voice_z_lotus;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;

#namespace _bonuszm_lotus;

// Namespace _bonuszm_lotus
// Params 0, eflags: 0x2
// Checksum 0x5021996b, Offset: 0x8a0
// Size: 0x27c
function autoexec init()
{
    if ( !sessionmodeiscampaignzombiesgame() )
    {
        return;
    }
    
    mapname = getdvarstring( "mapname" );
    
    if ( !issubstr( mapname, "lotus" ) )
    {
        return;
    }
    
    voice_z_lotus::init_voice();
    level.bzm_lotusdialogue1callback = &function_b3638a15;
    level.bzm_lotusdialogue2callback = &function_d966047e;
    level.bzm_lotusdialogue2_1callback = &function_7aa93e6e;
    level.bzm_lotusdialogue2_2callback = &function_54a6c405;
    level.bzm_lotusdialogue2_3callback = &function_2ea4499c;
    level.bzm_lotusdialogue2_4callback = &function_8a1cf33;
    level.bzm_lotusdialogue3callback = &function_ff687ee7;
    level.bzm_lotusdialogue3_2callback = &function_cdf5cbb4;
    level.bzm_lotusdialogue4callback = &function_f5572608;
    level.bzm_lotusdialogue4_1callback = &function_b86427d4;
    level.bzm_lotusdialogue4_2callback = &function_2a6b970f;
    level.bzm_lotusdialogue6callback = &function_415c1ada;
    level.bzm_lotusdialogue7callback = &function_675e9543;
    level.bzm_lotusdialogue7_1callback = &function_d8e54d73;
    level.bzm_lotusdialogue8callback = &function_5d4d3c64;
    level.bzm_lotusdialogue9callback = &function_834fb6cd;
    level.bzm_lotusdialogue10callback = &function_5a3b6b5f;
    level.bzm_lotusdialogue11callback = &function_3438f0f6;
    level.bzm_lotusdialogue12callback = &function_e36768d;
    level.bzm_lotusdialogue13callback = &function_e833fc24;
    level.bzm_lotusdialogue14callback = &function_c23181bb;
    function_91402721();
}

// Namespace _bonuszm_lotus
// Params 0, eflags: 0x4
// Checksum 0xc97cf12a, Offset: 0xb28
// Size: 0x24
function private function_91402721()
{
    callback::on_spawned( &function_b89e0be4 );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0x99ec1590, Offset: 0xb58
// Size: 0x4
function function_b89e0be4()
{
    
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0xfb7cdbe8, Offset: 0xb68
// Size: 0x84
function function_b3638a15()
{
    level endon( #"bzm_sceneseqended" );
    bonuszmsound::function_ef0ce9fb( "plyz_lotus_tower_was_one_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_that_fucker_was_a_ma_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_khalil_and_the_egypt_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_we_took_out_hakim_s_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0x865d40c7, Offset: 0xbf8
// Size: 0x8c
function function_d966047e()
{
    level endon( #"bzm_sceneseqended" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_we_made_quick_work_o_0" );
    wait 10;
    bonuszmsound::function_ef0ce9fb( "plyz_khalil_spoke_to_the_0" );
    level flag::wait_till( "start_stair_shoot" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_khalil_had_a_mobile_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0x8ffc7943, Offset: 0xc90
// Size: 0x24
function function_7aa93e6e()
{
    level endon( #"bzm_sceneseqended" );
    bonuszmsound::function_ef0ce9fb( "plyz_once_we_took_the_sec_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0xcc5880a5, Offset: 0xcc0
// Size: 0x2c
function function_54a6c405()
{
    level endon( #"bzm_sceneseqended" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_and_then_we_were_com_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0xb77d854c, Offset: 0xcf8
// Size: 0x44
function function_2ea4499c()
{
    level endon( #"bzm_sceneseqended" );
    bonuszmsound::function_ef0ce9fb( "plyz_the_security_station_0" );
    wait 9;
    bonuszmsound::function_45809471( "deim_i_wonder_how_did_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0x709c04c6, Offset: 0xd48
// Size: 0xe
function function_8a1cf33()
{
    level endon( #"bzm_sceneseqended" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0xb4665da0, Offset: 0xd60
// Size: 0xac
function function_ff687ee7()
{
    level endon( #"bzm_sceneseqended" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_one_by_one_he_d_watc_0" );
    wait 2;
    bonuszmsound::function_45809471( "deim_and_your_man_john_t_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_he_was_in_a_detentio_0" );
    wait 1;
    bonuszmsound::function_45809471( "deim_he_waited_for_you_i_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_fuck_you_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0xdb103637, Offset: 0xe18
// Size: 0x1a
function function_cdf5cbb4()
{
    level endon( #"bzm_sceneseqended" );
    wait 1;
    wait 1;
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0x4f6de80d, Offset: 0xe40
// Size: 0x104
function function_f5572608()
{
    level endon( #"bzm_sceneseqended" );
    wait 4;
    bonuszmsound::function_ef0ce9fb( "plyz_and_there_he_was_jo_0" );
    wait 1;
    bonuszmsound::function_45809471( "deim_and_you_hesitated_0" );
    wait 1;
    bonuszmsound::function_45809471( "deim_you_felt_compassion_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_no_it_was_hendricks_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_this_would_be_one_of_0" );
    wait 4;
    bonuszmsound::function_ef0ce9fb( "plyz_watching_taylor_walk_0" );
    bonuszmsound::function_45809471( "deim_but_as_you_always_di_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_this_was_the_world_w_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0x549b439a, Offset: 0xf50
// Size: 0x2c
function function_b86427d4()
{
    level endon( #"bzm_sceneseqended" );
    wait 4;
    bonuszmsound::function_ef0ce9fb( "plyz_taylor_was_gunning_f_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0xbf289192, Offset: 0xf88
// Size: 0x3c
function function_2a6b970f()
{
    level endon( #"bzm_sceneseqended" );
    bonuszmsound::function_45809471( "deim_what_happened_when_y_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_a_a_malfunction_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0x8a95960, Offset: 0xfd0
// Size: 0x2c
function function_415c1ada()
{
    level endon( #"bzm_sceneseqended" );
    wait 3;
    bonuszmsound::function_ef0ce9fb( "plyz_we_snapped_out_of_ou_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0xc693bfd8, Offset: 0x1008
// Size: 0xc4
function function_675e9543()
{
    level endon( #"bzm_sceneseqended" );
    wait 1;
    bonuszmsound::function_45809471( "deim_i_must_admit_this_0" );
    bonuszmsound::function_45809471( "deim_by_this_time_you_kne_0" );
    bonuszmsound::function_45809471( "deim_i_gave_him_something_0" );
    bonuszmsound::function_45809471( "deim_we_know_what_happens_0" );
    bonuszmsound::function_45809471( "deim_but_right_then_you_h_0" );
    bonuszmsound::function_45809471( "deim_i_wanted_to_test_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_over_comms_kane_tol_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0x35674998, Offset: 0x10d8
// Size: 0xc4
function function_d8e54d73()
{
    level endon( #"bzm_sceneseqended" );
    wait 1;
    bonuszmsound::function_45809471( "deim_i_must_admit_this_0" );
    bonuszmsound::function_45809471( "deim_by_this_time_you_kne_0" );
    bonuszmsound::function_45809471( "deim_i_gave_him_something_0" );
    bonuszmsound::function_45809471( "deim_we_know_what_happens_0" );
    bonuszmsound::function_45809471( "deim_but_right_then_you_h_0" );
    bonuszmsound::function_45809471( "deim_i_wanted_to_test_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_over_comms_kane_tol_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0x99b35741, Offset: 0x11a8
// Size: 0xe
function function_5d4d3c64()
{
    level endon( #"bzm_sceneseqended" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0xbd1ff7c3, Offset: 0x11c0
// Size: 0x1b4
function function_834fb6cd()
{
    level endon( #"bzm_sceneseqended" );
    wait 10;
    bonuszmsound::function_ef0ce9fb( "plyz_the_airship_crashed_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_i_was_stuck_trapped_0" );
    bonuszmsound::function_45809471( "deim_i_d_gotten_over_my_c_0" );
    bonuszmsound::function_45809471( "deim_and_taylor_was_just_0" );
    bonuszmsound::function_45809471( "deim_you_raised_your_hand_0" );
    bonuszmsound::function_45809471( "deim_but_something_happen_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_he_told_me_he_had_to_0" );
    wait 4;
    bonuszmsound::function_ef0ce9fb( "plyz_he_was_ripping_out_h_0" );
    wait 2;
    bonuszmsound::function_45809471( "deim_what_did_he_say_to_y_0" );
    wait 3;
    bonuszmsound::function_ef0ce9fb( "plyz_he_asked_me_about_th_0" );
    wait 4;
    bonuszmsound::function_45809471( "deim_and_then_my_final_pu_0" );
    wait 1;
    bonuszmsound::function_ef0ce9fb( "plyz_no_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_from_coalescence_0" );
    bonuszmsound::function_45809471( "deim_you_humans_and_your_0" );
    wait 1;
    bonuszmsound::function_45809471( "deim_so_i_gave_you_your_e_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0x858110f9, Offset: 0x1380
// Size: 0xec
function function_5a3b6b5f()
{
    level endon( #"bzm_sceneseqended" );
    wait 2;
    bonuszmsound::function_45809471( "deim_but_your_guardian_0" );
    wait 1;
    bonuszmsound::function_45809471( "deim_she_saved_you_0" );
    wait 1;
    bonuszmsound::function_45809471( "deim_you_must_have_been_t_0" );
    wait 1;
    bonuszmsound::function_45809471( "deim_what_s_it_like_to_e_0" );
    wait 1;
    bonuszmsound::function_45809471( "deim_the_naivety_of_your_0" );
    wait 1;
    bonuszmsound::function_b4a3e925( "dolo_do_as_he_asks_give_0" );
    wait 2;
    bonuszmsound::function_ef0ce9fb( "plyz_just_that_we_were_go_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0x5544b7c3, Offset: 0x1478
// Size: 0x74
function function_3438f0f6()
{
    level endon( #"bzm_sceneseqended" );
    bonuszmsound::function_ef0ce9fb( "plyz_hendricks_had_been_s_0" );
    wait 1;
    bonuszmsound::function_45809471( "deim_i_enlightened_him_l_0" );
    bonuszmsound::function_ef0ce9fb( "plyz_right_this_war_with_0" );
    bonuszmsound::function_45809471( "deim_don_t_you_dare_fu_0" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0xb1ebb326, Offset: 0x14f8
// Size: 0x3c
function function_e36768d()
{
    level endon( #"bzm_sceneseqended" );
    bonuszmsound::function_b4a3e925( "dolo_do_as_he_asks_give_0" );
    bonuszmsound::function_b4a3e925( "dolo_remember_the_trut_1" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0x42bb3ea2, Offset: 0x1540
// Size: 0x3c
function function_e833fc24()
{
    level endon( #"bzm_sceneseqended" );
    bonuszmsound::function_b4a3e925( "dolo_do_as_he_asks_let_h_1" );
    bonuszmsound::function_b4a3e925( "dolo_offer_yourself_to_hi_1" );
}

// Namespace _bonuszm_lotus
// Params 0
// Checksum 0xcf9e6e92, Offset: 0x1588
// Size: 0x5c
function function_c23181bb()
{
    level endon( #"bzm_sceneseqended" );
    wait 2;
    bonuszmsound::function_b4a3e925( "dolo_let_them_come_0" );
    bonuszmsound::function_b4a3e925( "dolo_like_puppets_on_stri_0" );
    bonuszmsound::function_b4a3e925( "dolo_what_choice_do_you_h_0" );
}

