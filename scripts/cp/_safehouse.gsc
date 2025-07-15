#using scripts/codescripts/struct;
#using scripts/cp/_challenges;
#using scripts/cp/_decorations;
#using scripts/cp/_dialog;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_training_sim;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_globallogic_player;
#using scripts/cp/gametypes/_loadout;
#using scripts/cp/gametypes/_save;
#using scripts/cp/voice/voice_safehouse;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/music_shared;
#using scripts/shared/player_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons_shared;

#namespace safehouse;

// Namespace safehouse
// Params 0, eflags: 0x2
// Checksum 0x96ce0db4, Offset: 0x2630
// Size: 0x3c
function autoexec __init__sytem__()
{
    system::register( "safehouse", &__init__, &__main__, undefined );
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0xfd257a1f, Offset: 0x2678
// Size: 0x8fc
function private __init__()
{
    level.is_safehouse = 1;
    str_queued_level = getdvarstring( "cp_queued_level", "" );
    
    if ( world.is_first_time_flow !== 0 && str_queued_level == "cp_mi_eth_prologue" )
    {
        level.is_first_time_flow = 1;
    }
    
    if ( !isdefined( world.highest_map_reached ) )
    {
        world.highest_map_reached = "cp_mi_eth_prologue";
    }
    
    if ( !isdefined( world.next_map ) )
    {
        world.next_map = "cp_mi_eth_prologue";
    }
    
    level.next_map = str_queued_level != "" ? str_queued_level : world.next_map;
    level.last_map = world.last_map;
    
    /#
        if ( getdvarstring( "<dev string:x28>" ) == "<dev string:x38>" )
        {
            world.highest_map_reached = "<dev string:x3a>";
        }
        
        var_de99b1ca = getdvarstring( "<dev string:x51>", "<dev string:x5a>" );
        
        if ( var_de99b1ca != "<dev string:x5a>" )
        {
            level.last_map = var_de99b1ca;
        }
        
        printtoprightln( "<dev string:x5b>" + level.next_map, ( 1, 1, 1 ), -1 );
    #/
    
    if ( isdefined( world.show_aar ) && world.show_aar && isdefined( level.last_map ) )
    {
        level.show_aar = 1;
        world.show_aar = undefined;
    }
    
    world.is_first_time_flow = 0;
    util::set_player_start_flag( "start_player" );
    voice_safehouse::init_voice();
    function_769e64f9();
    function_cf4c3bd8();
    scene::add_scene_func( "cin_saf_ram_readyroom_3rd_pre100_player01", &function_51970da0, "play" );
    scene::add_scene_func( "cin_saf_ram_readyroom_3rd_pre100_player01_enter", &function_51970da0, "play" );
    scene::add_scene_func( "cin_saf_ram_readyroom_3rd_pre100_player02", &function_51970da0, "play" );
    scene::add_scene_func( "cin_saf_ram_readyroom_3rd_pre100_player02_enter", &function_51970da0, "play" );
    scene::add_scene_func( "cin_saf_ram_readyroom_3rd_pre100_player03", &function_51970da0, "play" );
    scene::add_scene_func( "cin_saf_ram_readyroom_3rd_pre100_player03_enter", &function_51970da0, "play" );
    scene::add_scene_func( "cin_saf_ram_readyroom_3rd_pre100_player04", &function_51970da0, "play" );
    scene::add_scene_func( "cin_saf_ram_readyroom_3rd_pre100_player04_enter", &function_51970da0, "play" );
    scene::add_scene_func( "p7_fxanim_cp_safehouse_crates_plastic_tech_bundle", &function_a35cc107, "play" );
    scene::add_scene_func( "p7_fxanim_cp_safehouse_crates_plastic_tech_close_bundle", &function_6ca97001, "done" );
    scene::add_scene_func( "p7_fxanim_cp_safehouse_locker_metal_barrack_bundle", &function_2cafba2, "play" );
    scene::add_scene_func( "p7_fxanim_cp_safehouse_locker_metal_barrack_close_bundle", &function_ffeaa7c4, "done" );
    clientfield::register( "world", "nextMap", 1, 6, "int" );
    clientfield::register( "world", "near_gun_rack", 1, 1, "int" );
    clientfield::register( "world", "toggle_console_1", 1, 1, "int" );
    clientfield::register( "world", "toggle_console_2", 1, 1, "int" );
    clientfield::register( "world", "toggle_console_3", 1, 1, "int" );
    clientfield::register( "world", "toggle_console_4", 1, 1, "int" );
    clientfield::register( "scriptmover", "player_clone", 1, 1, "int" );
    clientfield::register( "scriptmover", "training_sim_extracam", 1, getminbitcountfornum( 4 ), "int" );
    clientfield::register( "scriptmover", "gun_rack_init", 1, getminbitcountfornum( 1 ), "int" );
    clientfield::register( "toplayer", "sh_exit_duck_active", 1, 1, "int" );
    clientfield::register( "clientuimodel", "safehouse.inClientBunk", 1, 2, "int" );
    clientfield::register( "clientuimodel", "safehouse.inTrainingSim", 1, 1, "int" );
    level flag::init( "player_entering_ready_room" );
    level flag::init( "player_exiting_ready_room" );
    level flag::init( "player_near_gun_rack" );
    callback::on_connect( &on_player_connect );
    callback::on_disconnect( &on_player_disconnect );
    callback::on_spawned( &on_player_spawned );
    callback::on_player_killed( &on_player_killed );
    callback::on_loadout( &function_bcfa7205 );
    callback::on_loadout( &function_c6f2aa2b );
    hidemiscmodels( "training_sim_extracam_screen_on1" );
    hidemiscmodels( "training_sim_extracam_screen_on2" );
    hidemiscmodels( "training_sim_extracam_screen_on3" );
    hidemiscmodels( "training_sim_extracam_screen_on4" );
    
    if ( !isdefined( level.var_b57a1b14 ) )
    {
        level.var_b57a1b14 = [];
    }
    
    function_3d4973d1();
    objectives::set( "cp_safehouse_ready_room" );
    objectives::set( "cp_safehouse_training_start" );
    objectives::set( "cp_safehouse_training_nextround" );
    level thread function_6eee8df0();
    level thread function_23a33dca();
}

// Namespace safehouse
// Params 0
// Checksum 0x554072e6, Offset: 0x2f80
// Size: 0x1746
function function_3d4973d1()
{
    level.ambient_vo_ent = getent( "ambient_vo_ent", "targetname" );
    
    switch ( level.next_map )
    {
        case "cp_mi_eth_prologue":
            pre = "pre" + ( math::cointoss() ? "m" : "f" );
            news = "new" + ( math::cointoss() ? "m" : "f" );
            function_77cfa54b( pre + "_this_morning_member_0", undefined, "ambient" );
            function_77cfa54b( pre + "_this_administration_0", 2, "ambient" );
            function_77cfa54b( pre + "_we_will_continue_to_0", 2, "ambient" );
            function_77cfa54b( news + "_in_just_a_few_short_0", undefined, "ambient" );
            function_77cfa54b( news + "_with_the_capture_of_0", 2, "ambient" );
            function_77cfa54b( news + "_the_wa_have_denied_s_0", 2, "ambient" );
            break;
        default:
            news = "new" + ( math::cointoss() ? "m" : "f" );
            sci = "sci" + ( math::cointoss() ? "m" : "f" );
            function_77cfa54b( news + "_though_a_spokesperso_0", undefined, "ambient" );
            function_77cfa54b( news + "_with_the_minister_no_0", 2, "ambient" );
            function_77cfa54b( news + "_certainly_many_are_0", 2, "ambient" );
            function_77cfa54b( sci + "_there_s_no_doubt_tha_0", undefined, "ambient" );
            function_77cfa54b( sci + "_the_increasing_preva_0", 2, "ambient" );
            function_77cfa54b( sci + "_the_development_of_d_0", 2, "ambient" );
            function_77cfa54b( sci + "_ironically_however_0", 2, "ambient" );
            break;
        case "cp_mi_sing_blackstation":
            function_77cfa54b( "plyr_hey_hendricks_beat_0", 1, "player" );
            function_77cfa54b( "hend_singapore_one_of_my_0", 1, "remote" );
            function_77cfa54b( "plyr_oh_yeah_this_is_a_0", 1, "player" );
            function_77cfa54b( "hend_glad_you_remember_0", 1, "remote" );
            function_77cfa54b( "plyr_ah_they_re_always_w_0", 1, "player" );
            pre = "pre" + ( math::cointoss() ? "m" : "f" );
            sci = "sci" + ( math::cointoss() ? "m" : "f" );
            news = "new" + ( math::cointoss() ? "m" : "f" );
            function_77cfa54b( pre + "_while_it_is_true_tha_0", undefined, "ambient" );
            function_77cfa54b( pre + "_though_the_cause_of_0", 2, "ambient" );
            function_77cfa54b( sci + "_one_of_the_key_probl_0", undefined, "ambient" );
            function_77cfa54b( sci + "_in_the_chaos_of_the_0", 2, "ambient" );
            function_77cfa54b( sci + "_what_we_do_know_for_0", 2, "ambient" );
            function_77cfa54b( news + "_on_the_anniversary_o_0", undefined, "ambient" );
            function_77cfa54b( news + "_despite_the_many_eff_0", 2, "ambient" );
            function_77cfa54b( news + "_the_emergence_of_cri_0", 2, "ambient" );
            break;
        case "cp_mi_sing_biodomes":
        case "cp_mi_sing_biodomes2":
            function_77cfa54b( "hend_so_i_wanted_to_ask_0", 1, "remote" );
            function_77cfa54b( "plyr_kane_said_they_re_of_0", 1, "player" );
            function_77cfa54b( "hend_i_m_not_so_sure_i_t_0", 1, "remote" );
            function_77cfa54b( "plyr_i_think_you_re_being_0", 1, "player" );
            function_77cfa54b( "hend_i_guess_we_ll_see_0", 1, "remote" );
            pre = "pre" + ( math::cointoss() ? "m" : "f" );
            news = "new" + ( math::cointoss() ? "m" : "f" );
            function_77cfa54b( pre + "_in_light_of_today_s_0", undefined, "ambient" );
            function_77cfa54b( pre + "_we_are_coordinating_0", 2, "ambient" );
            function_77cfa54b( news + "_the_scale_of_these_i_0", undefined, "ambient" );
            function_77cfa54b( news + "_hundreds_of_thousand_0", 2, "ambient" );
            function_77cfa54b( news + "_it_s_going_to_take_a_0", 2, "ambient" );
            break;
        case "cp_mi_sing_sgen":
            function_77cfa54b( "hend_so_according_to_kan_0", 1, "remote" );
            function_77cfa54b( "plyr_about_what_i_did_to_0", 1, "player" );
            function_77cfa54b( "hend_i_know_beat_i_a_0", 1, "remote" );
            function_77cfa54b( "plyr_kane_said_that_whate_0", 1, "player" );
            pre = "pre" + ( math::cointoss() ? "m" : "f" );
            news = "new" + ( math::cointoss() ? "m" : "f" );
            function_77cfa54b( pre + "_in_recent_days_we_ha_0", undefined, "ambient" );
            function_77cfa54b( pre + "_however_the_allega_0", 2, "ambient" );
            function_77cfa54b( pre + "_the_inflammatory_acc_0", 2, "ambient" );
            function_77cfa54b( pre + "_i_ask_that_members_o_0", 2, "ambient" );
            function_77cfa54b( news + "_while_we_do_not_know_0", 3, "ambient" );
            break;
        case "cp_mi_sing_vengeance":
            function_77cfa54b( "hend_i_m_telling_you_now_0", 1, "remote" );
            function_77cfa54b( "plyr_this_isn_t_up_for_di_0", 1, "player" );
            function_77cfa54b( "hend_you_know_they_want_u_0", 1, "remote" );
            function_77cfa54b( "plyr_it_s_not_our_actions_0", 1, "player" );
            pre = "pre" + ( math::cointoss() ? "m" : "f" );
            sci = "sci" + ( math::cointoss() ? "m" : "f" );
            news = "new" + ( math::cointoss() ? "m" : "f" );
            function_77cfa54b( pre + "_as_i_said_before_w_0", undefined, "ambient" );
            function_77cfa54b( news + "_it_s_hard_to_imagine_0", 2, "ambient" );
            function_77cfa54b( sci + "_the_suggestion_that_0", undefined, "ambient" );
            function_77cfa54b( sci + "_certainly_various_r_0", 2, "ambient" );
            break;
        case "cp_mi_cairo_ramses":
        case "cp_mi_cairo_ramses2":
            function_77cfa54b( "hend_how_is_she_1", 1, "remote" );
            function_77cfa54b( "plyr_she_s_strong_meds_0", 1, "player" );
            function_77cfa54b( "hend_so_you_re_okay_wit_0", 1, "remote" );
            function_77cfa54b( "plyr_okay_with_what_hend_0", 1, "player" );
            function_77cfa54b( "hend_okay_with_the_fact_t_0", 1, "remote" );
            function_77cfa54b( "plyr_they_leaked_classifi_0", 1, "player" );
            pre = "pre" + ( math::cointoss() ? "m" : "f" );
            news = "new" + ( math::cointoss() ? "m" : "f" );
            function_77cfa54b( pre + "_the_actions_perpetra_0", undefined, "ambient" );
            function_77cfa54b( pre + "_at_this_time_we_are_0", 2, "ambient" );
            function_77cfa54b( pre + "_as_this_time_those_0", 2, "ambient" );
            function_77cfa54b( news + "_ground_forces_contin_0", undefined, "ambient" );
            function_77cfa54b( news + "_already_suffering_un_0", 2, "ambient" );
            break;
        case "cp_mi_cairo_infection":
        case "cp_mi_cairo_infection2":
        case "cp_mi_cairo_infection3":
            function_77cfa54b( "kane_wake_up_beat_ther_0", 1, "remote" );
            function_77cfa54b( "plyr_where_s_hendricks_0", 1, "player" );
            function_77cfa54b( "kane_he_s_asleep_i_m_run_0", 1, "remote" );
            function_77cfa54b( "plyr_can_i_trust_you_0", 1, "player" );
            function_77cfa54b( "kane_how_about_i_tell_you_0", 1, "remote" );
            function_77cfa54b( "plyr_taylor_s_still_speak_0", 1, "player" );
            function_77cfa54b( "kane_i_think_his_dni_ha_0", 1, "remote" );
            function_77cfa54b( "plyr_but_we_can_track_the_0", 1, "player" );
            news = "new" + ( math::cointoss() ? "m" : "f" );
            sci = "sci" + ( math::cointoss() ? "m" : "f" );
            function_77cfa54b( news + "_yesterday_saw_some_o_0", undefined, "ambient" );
            function_77cfa54b( news + "_ramses_station_one_0", 2, "ambient" );
            function_77cfa54b( news + "_while_allied_forces_0", 2, "ambient" );
            function_77cfa54b( news + "_the_outcome_was_perh_0", 2, "ambient" );
            function_77cfa54b( sci + "_there_s_a_long_histo_0", undefined, "ambient" );
            function_77cfa54b( sci + "_there_is_every_reaso_0", 2, "ambient" );
            break;
        case "cp_mi_cairo_aquifer":
            function_77cfa54b( "kane_prep_to_move_out_0", 1, "remote" );
            function_77cfa54b( "kane_once_again_we_ve_go_0", 1, "remote" );
            function_77cfa54b( "plyr_how_do_they_do_it_k_0", 1, "player" );
            function_77cfa54b( "kane_maybe_one_day_the_wa_0", 1, "remote" );
            pre = "pre" + ( math::cointoss() ? "m" : "f" );
            sci = "sci" + ( math::cointoss() ? "m" : "f" );
            function_77cfa54b( pre + "_in_coordination_with_0", undefined, "ambient" );
            function_77cfa54b( pre + "_at_this_moment_we_a_0", 2, "ambient" );
            function_77cfa54b( sci + "_having_personally_re_0", undefined, "ambient" );
            function_77cfa54b( sci + "_the_use_of_human_exp_0", 2, "ambient" );
            function_77cfa54b( sci + "_doctor_salim_s_resea_0", 2, "ambient" );
            function_77cfa54b( sci + "_in_terms_of_ethics_0", 2, "ambient" );
            break;
        case "cp_mi_cairo_lotus":
        case "cp_mi_cairo_lotus2":
        case "cp_mi_cairo_lotus3":
            function_77cfa54b( "plyr_kane_about_what_ha_0", 1, "player" );
            function_77cfa54b( "kane_we_can_t_focus_on_th_0", 1, "remote" );
            function_77cfa54b( "plyr_the_infection_the_0", 1, "player" );
            function_77cfa54b( "kane_all_we_can_do_is_hop_0", 1, "remote" );
            function_77cfa54b( "plyr_it_may_not_be_offici_0", 1, "player" );
            function_77cfa54b( "kane_his_heart_s_in_the_r_0", 1, "remote" );
            pre = "pre" + ( math::cointoss() ? "m" : "f" );
            news = "new" + ( math::cointoss() ? "m" : "f" );
            function_77cfa54b( news + "_today_we_received_a_0", undefined, "ambient" );
            function_77cfa54b( news + "_it_quickly_became_ev_0", 2, "ambient" );
            function_77cfa54b( pre + "_today_we_pledge_our_0", undefined, "ambient" );
            function_77cfa54b( pre + "_their_bravery_in_the_0", 2, "ambient" );
            break;
        case "cp_mi_zurich_coalescence":
            function_77cfa54b( "corv_listen_only_to_the_s_3", 1, "player" );
            function_77cfa54b( "corv_let_your_mind_relax_3", 1, "player" );
            function_77cfa54b( "corv_let_your_thoughts_dr_1", 1, "player" );
            function_77cfa54b( "corv_let_the_bad_memories_0", 1, "player" );
            function_77cfa54b( "corv_let_peace_be_upon_yo_0", 1, "player" );
            function_77cfa54b( "corv_you_are_in_control_0", 1, "player" );
            function_77cfa54b( "corv_imagine_yourself_1", 1, "player" );
            break;
    }
}

// Namespace safehouse
// Params 0
// Checksum 0xfea9f2fb, Offset: 0x46d0
// Size: 0x1b2
function function_9423672b()
{
    self endon( #"disconnect" );
    trigger::wait_till( "main_room_trigger", "targetname", self );
    
    if ( isarray( level.var_836d6d34 ) )
    {
        foreach ( var_39b18b57 in level.var_836d6d34 )
        {
            str_line = var_39b18b57[ 0 ];
            n_wait = var_39b18b57[ 1 ];
            str_type = var_39b18b57[ 2 ];
            function_3913c855( n_wait );
            
            if ( str_type == "remote" )
            {
                level dialog::remote( str_line, 0, undefined, self );
                continue;
            }
            
            if ( str_type == "ambient" )
            {
                level.ambient_vo_ent dialog::say( str_line, 0, 1, self );
                continue;
            }
            
            if ( str_type == "player" )
            {
                self dialog::player_say( str_line );
            }
        }
    }
}

// Namespace safehouse
// Params 1
// Checksum 0xbad3101e, Offset: 0x4890
// Size: 0xae
function function_3913c855( n_wait )
{
    var_3784d0f4 = array( "in_ready_room", "in_aar", "in_training_sim", "interacting", "safehouse_menu_open" );
    
    do
    {
        if ( !isdefined( n_wait ) )
        {
            n_wait = randomfloatrange( 5, 10 );
        }
        
        wait n_wait;
    }
    while ( !isalive( self ) || flag::get_any( var_3784d0f4 ) );
}

// Namespace safehouse
// Params 3
// Checksum 0x5d59fe70, Offset: 0x4948
// Size: 0xa6
function function_77cfa54b( str_line, n_wait, str_type )
{
    if ( !isdefined( level.var_836d6d34 ) )
    {
        level.var_836d6d34 = [];
    }
    else if ( !isarray( level.var_836d6d34 ) )
    {
        level.var_836d6d34 = array( level.var_836d6d34 );
    }
    
    level.var_836d6d34[ level.var_836d6d34.size ] = array( str_line, n_wait, str_type );
}

// Namespace safehouse
// Params 1
// Checksum 0x962d1126, Offset: 0x49f8
// Size: 0x28c
function function_51970da0( a_ents )
{
    e_player = a_ents[ "player 1" ];
    
    /#
        if ( issubstr( e_player.current_scene, "<dev string:x68>" ) )
        {
            n_index = 1;
        }
        else if ( issubstr( e_player.current_scene, "<dev string:x71>" ) )
        {
            n_index = 2;
        }
        else if ( issubstr( e_player.current_scene, "<dev string:x7a>" ) )
        {
            n_index = 3;
        }
        else if ( issubstr( e_player.current_scene, "<dev string:x83>" ) )
        {
            n_index = 4;
        }
    #/
    
    if ( !isdefined( n_index ) )
    {
        n_index = e_player.n_ready_room_index + 1;
    }
    
    if ( isdefined( e_player.primaryloadoutweapon ) )
    {
        mdl_weapon = a_ents[ "player" + n_index + "_ready_room_weapon" ];
        mdl_weapon setmodel( e_player.primaryloadoutweapon.worldmodel );
    }
    
    var_12aba86 = getent( "player_" + n_index + "_sidearm", "targetname" );
    
    if ( weapons::is_side_arm( e_player.secondaryloadoutweapon.rootweapon ) )
    {
        var_12aba86 setmodel( e_player.secondaryloadoutweapon.worldmodel );
        var_12aba86 show();
    }
    else
    {
        var_12aba86 hide();
    }
    
    e_player util::waittill_either( "left_ready_room", "disconnect" );
    var_12aba86 hide();
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0x1f5bc0f7, Offset: 0x4c90
// Size: 0x94
function private __main__()
{
    level thread function_4dff3e80();
    init_rooms();
    init_stations();
    callback::on_connect( &player_claim_room );
    callback::on_disconnect( &player_unclaim_room );
    level thread function_124e0cdc();
}

// Namespace safehouse
// Params 0
// Checksum 0x7833b4ed, Offset: 0x4d30
// Size: 0x3c
function function_124e0cdc()
{
    wait 0.05;
    level clientfield::set( "nextMap", getmaporder( level.next_map ) );
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0xad58332b, Offset: 0x4d78
// Size: 0xcc
function private on_player_connect()
{
    self.disableclassselection = 1;
    self flag::init( "in_ready_room" );
    self flag::init( "in_aar" );
    self flag::init( "in_training_sim" );
    self flag::init( "loadout_dirty" );
    self flag::init( "interacting" );
    self flag::init( "safehouse_menu_open" );
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0x2e310925, Offset: 0x4e50
// Size: 0x84
function private on_player_disconnect()
{
    if ( flag::get( "in_ready_room" ) )
    {
        flag::clear( "in_ready_room" );
        _player_free_ready_room_position();
    }
    
    function_680cf465();
    
    if ( isdefined( self.var_bcf382f5 ) && self.var_bcf382f5 )
    {
        level.var_f0ba161d function_a8271940();
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x2421c5fb, Offset: 0x4ee0
// Size: 0x54
function function_10650e35()
{
    var_4fb0aa1e = self getluimenu( "MissionRecordVaultScreens" );
    
    if ( !isdefined( var_4fb0aa1e ) )
    {
        self openluimenu( "MissionRecordVaultScreens" );
    }
}

// Namespace safehouse
// Params 0
// Checksum 0xdb892397, Offset: 0x4f40
// Size: 0x54
function function_b439510f()
{
    var_4fb0aa1e = self getluimenu( "MissionRecordVaultScreens" );
    
    if ( isdefined( var_4fb0aa1e ) )
    {
        self closeluimenu( var_4fb0aa1e );
    }
}

// Namespace safehouse
// Params 0
// Checksum 0xdeabc6cd, Offset: 0x4fa0
// Size: 0x316
function function_9f9f6524()
{
    var_c02de660 = skipto::function_23eda99c();
    var_2c222f16 = 4;
    
    foreach ( mission in var_c02de660 )
    {
        var_a4b6fa1f = self getdstat( "PlayerStatsByMap", mission, "highestStats", "HIGHEST_DIFFICULTY" );
        
        if ( var_a4b6fa1f < var_2c222f16 )
        {
            var_2c222f16 = var_a4b6fa1f;
        }
    }
    
    var_b60694c2 = var_c02de660.size;
    
    if ( var_b60694c2 > 0 )
    {
        switch ( var_2c222f16 )
        {
            case 4:
                if ( self getdstat( "PlayerStatsList", "CAREER_DIFFICULTY_REAL", "statValue" ) < var_b60694c2 )
                {
                    self setdstat( "PlayerStatsList", "CAREER_DIFFICULTY_REAL", "statValue", var_b60694c2 - 1 );
                    self challenges::function_96ed590f( "CAREER_DIFFICULTY_REAL" );
                    self.var_3e93cde7 = 1;
                }
            case 3:
                if ( self getdstat( "PlayerStatsList", "CAREER_DIFFICULTY_VET", "statValue" ) < var_b60694c2 )
                {
                    self setdstat( "PlayerStatsList", "CAREER_DIFFICULTY_VET", "statValue", var_b60694c2 - 1 );
                    self challenges::function_96ed590f( "CAREER_DIFFICULTY_VET" );
                    self.var_3e93cde7 = 1;
                }
            case 2:
                if ( self getdstat( "PlayerStatsList", "CAREER_DIFFICULTY_HARD", "statValue" ) < var_b60694c2 )
                {
                    self setdstat( "PlayerStatsList", "CAREER_DIFFICULTY_HARD", "statValue", var_b60694c2 - 1 );
                    self challenges::function_96ed590f( "CAREER_DIFFICULTY_HARD" );
                    self.var_3e93cde7 = 1;
                }
                
                break;
            default:
                break;
        }
    }
}

// Namespace safehouse
// Params 0
// Checksum 0xc6434e7f, Offset: 0x52c0
// Size: 0x218
function function_e32f1d3f()
{
    var_c02de660 = skipto::function_23eda99c();
    var_8466305e = 1;
    var_c88e4145 = 0;
    
    foreach ( mission in var_c02de660 )
    {
        for ( i = 0; i < 19 ; i++ )
        {
            if ( self getdstat( "PlayerStatsByMap", mission, "accolades", i, "state" ) )
            {
                var_c88e4145++;
            }
        }
        
        var_58ce61a8 = 16;
        
        if ( mission == "cp_mi_cairo_ramses" )
        {
            var_58ce61a8 = 17;
        }
        else if ( mission == "cp_mi_cairo_aquifer" )
        {
            var_58ce61a8 = 15;
        }
        
        if ( var_c88e4145 < var_58ce61a8 )
        {
            var_8466305e = 0;
        }
    }
    
    var_80abe1b = self getdstat( "PlayerStatsList", "CAREER_ACCOLADES", "ChallengeValue" );
    
    if ( var_80abe1b < var_c88e4145 )
    {
        self challenges::function_96ed590f( "CAREER_ACCOLADES", var_c88e4145 - var_80abe1b );
    }
    
    if ( var_8466305e )
    {
        self givedecoration( "cp_medal_all_accolades" );
        self.var_3e93cde7 = 1;
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x7dde5a61, Offset: 0x54e0
// Size: 0x1d4
function function_8c92e6bf()
{
    var_fa172d86 = 512;
    var_95e2df39 = 588;
    
    if ( self decorations::function_25328f50( "cp_medal_all_calling_cards" ) )
    {
        return;
    }
    
    if ( self getdstat( "PlayerStatsList", "koth_gamemode_mastery", "challengeValue" ) < 2 )
    {
        return;
    }
    
    var_b6b6d8ed = 1;
    
    for ( index = var_fa172d86; index <= var_95e2df39 ; index++ )
    {
        statname = tablelookup( "gamedata/stats/cp/statsmilestones3.csv", 0, index, 4 );
        targetvalue = int( tablelookup( "gamedata/stats/cp/statsmilestones3.csv", 0, index, 2 ) );
        
        if ( statname == "career_decorations" || statname == "career_mastery" )
        {
            targetvalue -= 1;
        }
        
        statvalue = self getdstat( "PlayerStatsList", statname, "challengeValue" );
        
        if ( statvalue < targetvalue )
        {
            var_b6b6d8ed = 0;
            break;
        }
    }
    
    if ( var_b6b6d8ed )
    {
        self givedecoration( "cp_medal_all_calling_cards" );
    }
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0x91cfb2f1, Offset: 0x56c0
// Size: 0x474
function private on_player_spawned()
{
    self.disableclassselection = 0;
    self.var_32218fc7 = 1;
    function_b11df48f();
    self thread function_9423672b();
    
    if ( isdefined( self.training_dummy ) )
    {
        self thread function_1a70861a();
    }
    else
    {
        function_10650e35();
        self globallogic_player::function_7bdf5497();
        
        if ( self decorations::function_e72fc18() && !self decorations::function_25328f50( "cp_medal_all_accolades" ) )
        {
            self givedecoration( "cp_medal_all_accolades" );
            self.var_3e93cde7 = 1;
        }
        
        if ( self givemissingunlocktokens() )
        {
            self.var_3e93cde7 = 1;
        }
        
        var_62f6e136 = self getdstat( "unlocks", 0 );
        var_7f6b97ce = self getdstat( "PlayerStatsList", "CAREER_TOKENS", "statValue" );
        
        if ( var_62f6e136 > var_7f6b97ce )
        {
            self addplayerstat( "career_tokens", var_62f6e136 - var_7f6b97ce );
            self.var_3e93cde7 = 1;
        }
        
        if ( self decorations::function_bea4ff57() )
        {
            self givedecoration( "cp_medal_all_weapon_unlocks" );
        }
        
        self function_9f9f6524();
        self function_e32f1d3f();
        self function_8c92e6bf();
        uploadstats( self );
        
        if ( isdefined( self.var_3e93cde7 ) && self.var_3e93cde7 )
        {
            self util::waittill_notify_or_timeout( "stats_changed", 2 );
            self.var_3e93cde7 = undefined;
        }
        
        if ( isdefined( self savegame::get_player_data( "show_aar" ) ) && self savegame::get_player_data( "show_aar" ) )
        {
            setdvar( "last_map", level.last_map );
            self savegame::set_player_data( "show_aar", undefined );
            self thread function_c2ba6d68();
        }
        else
        {
            self thread function_390094e6();
        }
        
        self thread function_a24e854d();
        var_162c6190 = getentarray( "m_terminal_asleep", "targetname" );
        
        if ( var_162c6190.size > 0 )
        {
            var_69c1a63b = arraygetclosest( self.origin, var_162c6190 );
            var_69c1a63b show();
        }
        
        var_162c6190 = getentarray( "m_terminal_awake", "targetname" );
        
        if ( var_162c6190.size > 0 )
        {
            var_cdc7765d = arraygetclosest( self.origin, var_162c6190 );
            var_cdc7765d hide();
        }
    }
    
    oed::ev_activate_on_player( 0 );
    oed::tmode_activate_on_player( 0 );
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0x23863ff5, Offset: 0x5b40
// Size: 0x1c
function private on_player_killed()
{
    self undolaststand();
}

// Namespace safehouse
// Params 1
// Checksum 0x6ed6c0d1, Offset: 0x5b68
// Size: 0x142
function function_a85e8026( n_num )
{
    var_fb7bdf69 = array( "pdv_screens_1", "pdv_screens_2", "pdv_screens_3" );
    
    foreach ( var_3c359681 in var_fb7bdf69 )
    {
        if ( strendswith( var_3c359681, n_num ) )
        {
            array::run_all( getentarray( var_3c359681, "targetname" ), &show );
            continue;
        }
        
        array::run_all( getentarray( var_3c359681, "targetname" ), &hide );
    }
}

// Namespace safehouse
// Params 0
// Checksum 0xff6f4aff, Offset: 0x5cb8
// Size: 0x210
function function_f380969b()
{
    var_67bda5a5 = self getdstat( "currentRankXP" );
    currentRankXP = self rank::getrankxpstat();
    hasSeenMaxLevelNotification = self getdstat( "hasSeenMaxLevelNotification" );
    
    if ( hasSeenMaxLevelNotification != 1 && currentRankXP >= rank::getrankinfominxp( level.ranktable.size - 1 ) )
    {
        menuhandle = self openluimenu( "CPMaxLevelNotification" );
        self setdstat( "hasSeenMaxLevelNotification", 1 );
        uploadstats( self );
    }
    else
    {
        menuhandle = self openluimenu( "RewardsOverlayCP" );
    }
    
    level.var_ac964c36 = 0;
    self waittill( #"menuresponse", menu, response );
    
    while ( response != "closed" )
    {
        self waittill( #"menuresponse", menu, response );
    }
    
    self closeluimenu( menuhandle );
    self thread function_390094e6();
    self globallogic_player::function_4cef9872( getrootmapname() );
    self globallogic_player::function_a5ac6877();
    level.var_ac964c36 = 1;
}

// Namespace safehouse
// Params 0
// Checksum 0xf755fe2f, Offset: 0x5ed0
// Size: 0x15c
function function_c2ba6d68()
{
    self flag::set( "in_aar" );
    s_scene = struct::get( "aar_camera", "targetname" );
    s_scenedef = struct::get_script_bundle( "scene", s_scene.scriptbundlename );
    align = scene::get_existing_ent( s_scenedef.aligntarget, 0, 1 );
    music::setmusicstate( "aar", self );
    camanimscripted( self, s_scenedef.cameraswitcher, gettime(), align.origin, align.angles );
    self function_f380969b();
    endcamanimscripted( self );
    self flag::clear( "in_aar" );
}

// Namespace safehouse
// Params 0
// Checksum 0x9e877cf8, Offset: 0x6038
// Size: 0x1c
function function_b11df48f()
{
    self util::set_low_ready( 1 );
}

// Namespace safehouse
// Params 0
// Checksum 0x76e0a0c3, Offset: 0x6060
// Size: 0xd2
function function_bcfa7205()
{
    a_weaponlist = self getweaponslist();
    
    foreach ( weapon in a_weaponlist )
    {
        if ( isdefined( weapon.isheroweapon ) && weapon.isheroweapon )
        {
            self takeweapon( weapon );
        }
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x5ee6cc15, Offset: 0x6140
// Size: 0x242
function function_c6f2aa2b()
{
    if ( !getdvarint( "tu1_safehouseDisableVarixScope", 1 ) )
    {
        return;
    }
    
    if ( isdefined( self.var_8201758a ) && self.var_8201758a )
    {
        return;
    }
    
    weaponlist = self getweaponslist();
    
    foreach ( weapon in weaponlist )
    {
        if ( !isdefined( weapon ) )
        {
            continue;
        }
        
        attachments = [];
        var_b0d06620 = 0;
        
        foreach ( attachment in weapon.attachments )
        {
            if ( attachment != "dualoptic" )
            {
                attachments[ attachments.size ] = attachment;
                continue;
            }
            
            var_b0d06620 = 1;
        }
        
        if ( var_b0d06620 )
        {
            if ( isdefined( weapon.rootweapon ) )
            {
                newweapon = getweapon( weapon.rootweapon.name, attachments );
                self takeweapon( weapon );
                self giveweapon( newweapon );
                self switchtoweapon( newweapon );
            }
        }
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x1c194014, Offset: 0x6390
// Size: 0x152
function function_cf4c3bd8()
{
    var_162c6190 = getentarray( "m_terminal_asleep", "targetname" );
    
    foreach ( screen in var_162c6190 )
    {
        screen show();
    }
    
    var_162c6190 = getentarray( "m_terminal_awake", "targetname" );
    
    foreach ( screen in var_162c6190 )
    {
        screen hide();
    }
}

// Namespace safehouse
// Params 5
// Checksum 0x7467738f, Offset: 0x64f0
// Size: 0x1e0
function init_interactive_prompt( trigger, objectiveid, normaltext, func_on_use, var_72fcb946 )
{
    if ( !isdefined( var_72fcb946 ) )
    {
        var_72fcb946 = 1;
    }
    
    trigger sethintstring( normaltext );
    trigger setcursorhint( "HINT_INTERACTIVE_PROMPT" );
    game_object = gameobjects::create_use_object( "any", trigger, array( trigger ), ( 0, 0, 0 ), objectiveid );
    game_object gameobjects::allow_use( "any" );
    game_object gameobjects::set_use_time( 0.35 );
    game_object gameobjects::set_owner_team( "allies" );
    game_object gameobjects::set_visible_team( "any" );
    game_object.single_use = 0;
    game_object.trigger usetriggerrequirelookat();
    game_object.origin = game_object.origin;
    game_object.angles = game_object.angles;
    
    if ( isdefined( func_on_use ) )
    {
        if ( var_72fcb946 )
        {
            game_object.onuse_thread = 1;
        }
        
        game_object.onuse = func_on_use;
    }
    
    return game_object;
}

// Namespace safehouse
// Params 1
// Checksum 0x7420001d, Offset: 0x66d8
// Size: 0x6c
function function_e04cba0f( e_player )
{
    self gameobjects::hide_waypoint( e_player );
    
    if ( isdefined( e_player ) )
    {
        self.trigger setinvisibletoplayer( e_player );
        return;
    }
    
    self.trigger setinvisibletoall();
}

// Namespace safehouse
// Params 1
// Checksum 0xf8dd8bd1, Offset: 0x6750
// Size: 0x6c
function function_a8271940( e_player )
{
    self gameobjects::show_waypoint( e_player );
    
    if ( isdefined( e_player ) )
    {
        self.trigger setvisibletoplayer( e_player );
        return;
    }
    
    self.trigger setvisibletoall();
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0x86e06951, Offset: 0x67c8
// Size: 0xd4
function private function_4dff3e80()
{
    level thread function_ed69417e();
    _init_ready_room_positions();
    level flag::wait_till( "first_player_spawned" );
    wait 5;
    t_start = getent( "trig_start_level", "targetname" );
    level.var_f0ba161d = init_interactive_prompt( t_start, &"cp_safehouse_ready_room", &"CP_SH_CAIRO_READY_ROOM2", &function_431ca329 );
    level thread function_4fade07a();
}

// Namespace safehouse
// Params 0
// Checksum 0xd5a2a46d, Offset: 0x68a8
// Size: 0xd4
function function_2c93055()
{
    if ( !isdefined( level.var_669268d8 ) )
    {
        level.var_669268d8 = 0;
    }
    
    if ( !level flag::exists( "players_received_stats" ) )
    {
        level flag::init( "players_received_stats" );
    }
    
    self util::waittill_notify_or_timeout( "stats_changed", 2 );
    level.var_669268d8++;
    connectedplayers = getnumconnectedplayers();
    
    if ( level.var_669268d8 >= connectedplayers )
    {
        level flag::set( "players_received_stats" );
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x7b75af62, Offset: 0x6988
// Size: 0x2c
function function_fdaf55aa()
{
    level flag::wait_till_timeout( 3, "players_received_stats" );
}

// Namespace safehouse
// Params 0
// Checksum 0x2890ef8e, Offset: 0x69c0
// Size: 0x54c
function function_ed69417e()
{
    level flag::init( "all_players_ready" );
    level flag::wait_till( "all_players_ready" );
    level clientfield::set( "gameplay_started", 0 );
    enablelobbyjoins( 0 );
    
    foreach ( player in level.players )
    {
        player savegame::set_player_data( get_savegame_name( level.next_map ) + "_class", player.curclass );
    }
    
    util::wait_network_frame( 3 );
    
    foreach ( player in level.players )
    {
        player scene::stop();
    }
    
    a_players = [];
    
    foreach ( player in level.players )
    {
        a_players[ "player " + player.n_ready_room_index + 1 ] = player;
    }
    
    level thread scene::play( "cin_saf_ram_readyroom_3rd_pre200", a_players );
    
    if ( isdefined( level.var_f3db725a ) )
    {
        array::run_all( level.players, level.var_f3db725a );
    }
    
    util::wait_network_frame( 3 );
    level thread lui::screen_fade_in( 0.2 );
    level waittill( #"hash_44c344f7" );
    
    foreach ( player in level.players )
    {
        player clientfield::set_to_player( "sh_exit_duck_active", 1 );
    }
    
    level lui::screen_fade_out( 0 );
    skipto::set_current_skipto( "" );
    
    /#
        printtoprightln( "<dev string:x8c>" + level.next_map, ( 1, 1, 1 ) );
    #/
    
    str_movie = getmapintromovie( level.next_map );
    
    if ( isdefined( str_movie ) )
    {
        switchmap_setloadingmovie( str_movie );
    }
    
    switchmap_load( level.next_map );
    wait 1;
    
    foreach ( e_player in level.players )
    {
        e_player globallogic_player::function_4cef9872( getrootmapname( level.next_map ) );
        e_player thread function_2c93055();
    }
    
    function_fdaf55aa();
    setdvar( "cp_queued_level", "" );
    switchmap_switch();
}

// Namespace safehouse
// Params 2, eflags: 0x4
// Checksum 0xf174228e, Offset: 0x6f18
// Size: 0x34
function private _delay_close_menu( delay, menuhandle )
{
    wait delay;
    self closeluimenu( menuhandle );
}

// Namespace safehouse
// Params 1
// Checksum 0xde0130a9, Offset: 0x6f58
// Size: 0x36
function get_savegame_name( levelname )
{
    switch ( levelname )
    {
        case "cp_mi_cairo_infection":
        case "cp_mi_cairo_infection2":
        case "cp_mi_cairo_infection3":
            return "infection";
        case "cp_mi_cairo_lotus":
        case "cp_mi_cairo_lotus2":
        case "cp_mi_cairo_lotus3":
            return "lotus";
        case "cp_mi_cairo_ramses":
        case "cp_mi_cairo_ramses2":
            return "ramses";
        case "cp_mi_sing_biodomes":
        default:
            return "biodomes";
    }
}

// Namespace safehouse
// Params 1
// Checksum 0x87a82d73, Offset: 0x6ff8
// Size: 0x3a0
function function_109cf997( menuname )
{
    if ( !isdefined( menuname ) )
    {
        menuname = game[ "menu_changeclass" ];
    }
    
    self.disableclasscallback = 1;
    self.var_8201758a = undefined;
    self clientfield::set_player_uimodel( "hudItems.cybercoreSelectMenuDisabled", 0 );
    
    if ( level.next_map == "cp_mi_zurich_newworld" || menuname != "chooseClass_TrainingSim" && level.next_map == "cp_mi_eth_prologue" )
    {
        if ( self ishost() )
        {
            var_6a7a1c33 = self getdstat( "highestMapReached" ) > getmaporder( level.next_map );
        }
        else
        {
            var_6a7a1c33 = self getdstat( "PlayerStatsByMap", level.next_map, "hasBeenCompleted" );
        }
        
        if ( !var_6a7a1c33 )
        {
            self clientfield::set_player_uimodel( "hudItems.cybercoreSelectMenuDisabled", 1 );
        }
    }
    
    if ( menuname === "chooseClass_TrainingSim" )
    {
        lui_menu = self openluimenu( menuname );
    }
    else
    {
        lui_menu = self openmenu( menuname );
    }
    
    var_17b2131d = 1;
    
    while ( true )
    {
        self waittill( #"menuresponse", menu, response );
        
        if ( menu == menuname )
        {
            if ( response == "cancel" )
            {
                var_17b2131d = 0;
            }
            else
            {
                responsearray = strtok( response, "," );
                
                if ( responsearray.size > 1 )
                {
                    str_class_chosen = responsearray[ 0 ];
                    clientnum = int( responsearray[ 1 ] );
                    altplayer = util::getplayerfromclientnum( clientnum );
                }
                else
                {
                    str_class_chosen = response;
                }
                
                player_class = self loadout::getclasschoice( str_class_chosen );
                self flag::wait_till_clear( "loadout_dirty" );
                
                if ( menuname == "chooseClass_TrainingSim" )
                {
                    self.var_8201758a = 1;
                }
                
                function_5b426a60( player_class, altplayer );
                
                if ( menuname == "chooseClass_TrainingSim" )
                {
                    self thread function_cbe945e8( player_class, altplayer );
                    self closemenu( menuname );
                }
            }
            
            break;
        }
    }
    
    self thread function_a20a5ae3();
    return var_17b2131d;
}

// Namespace safehouse
// Params 2
// Checksum 0x65eba6f8, Offset: 0x73a0
// Size: 0xb0
function function_cbe945e8( player_class, altplayer )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    time = gettime();
    
    while ( gettime() < time + 7000 )
    {
        msg = self util::waittill_any_timeout( 1, "loadout_changed" );
        
        if ( msg === "loadout_changed" )
        {
            function_5b426a60( player_class, altplayer );
        }
    }
}

// Namespace safehouse
// Params 2
// Checksum 0x4e85ad54, Offset: 0x7458
// Size: 0xfc
function function_5b426a60( player_class, altplayer )
{
    self savegame::set_player_data( "playerClass", player_class );
    
    if ( isdefined( altplayer ) )
    {
        xuid = altplayer getxuid();
        self savegame::set_player_data( "altPlayerID", xuid );
    }
    else
    {
        self savegame::set_player_data( "altPlayerID", undefined );
    }
    
    self loadout::setclass( player_class );
    self.tag_stowed_back = undefined;
    self.tag_stowed_hip = undefined;
    self loadout::giveloadout( self.pers[ "team" ], player_class, undefined, altplayer );
}

// Namespace safehouse
// Params 0
// Checksum 0xee189486, Offset: 0x7560
// Size: 0x24
function function_a20a5ae3()
{
    self endon( #"death" );
    wait 0.05;
    self.disableclasscallback = 0;
}

// Namespace safehouse
// Params 0
// Checksum 0xe9061ac4, Offset: 0x7590
// Size: 0x560
function function_4fade07a()
{
    level endon( #"all_players_ready" );
    var_f38ba567 = 60;
    var_42bb7bd2 = var_f38ba567;
    
    while ( true )
    {
        if ( !isdefined( level.activeplayers ) || level.activeplayers.size <= 1 )
        {
            wait 1;
            continue;
        }
        
        var_ac5bcf56 = 0;
        
        foreach ( player in level.activeplayers )
        {
            if ( player flag::get( "in_ready_room" ) )
            {
                var_ac5bcf56++;
            }
            
            handle = player getluimenu( "MissionStarting" );
            
            if ( !isdefined( handle ) )
            {
                player openluimenu( "MissionStarting" );
            }
        }
        
        if ( var_ac5bcf56 >= level.activeplayers.size * 0.5 )
        {
            var_42bb7bd2 -= 1;
            
            foreach ( player in level.activeplayers )
            {
                player luinotifyevent( &"mission_starting_countdown", 1, int( max( 0, var_42bb7bd2 ) ) );
                player playsound( "uin_timer" );
            }
        }
        else
        {
            var_42bb7bd2 = var_f38ba567;
            
            foreach ( player in level.activeplayers )
            {
                player luinotifyevent( &"mission_starting_hide", 0 );
            }
        }
        
        if ( var_42bb7bd2 < -1 )
        {
            foreach ( player in level.activeplayers )
            {
                if ( !isdefined( player.n_ready_room_index ) )
                {
                    player _player_get_ready_room_position();
                    player closemenu( game[ "menu_changeclass" ] );
                    handle = player getluimenu( "chooseClass_TrainingSim" );
                    
                    if ( isdefined( handle ) )
                    {
                        player closeluimenu( handle );
                    }
                    
                    handle = player getluimenu( "MissionStarting" );
                    
                    if ( isdefined( handle ) )
                    {
                        player closeluimenu( handle );
                    }
                }
                
                playerclass = player savegame::get_player_data( "playerClass", undefined );
                
                if ( !isdefined( playerclass ) || playerclass == "CLASS_CUSTOM10" )
                {
                    player_class = player loadout::getclasschoice( "custom0" );
                    player function_5b426a60( player_class, player );
                }
                
                if ( player.musicplaying === 1 )
                {
                    function_f97da4( player );
                }
            }
            
            level thread function_56c8845e();
            level thread lui::screen_fade_out( 0 );
            level flag::set( "all_players_ready" );
            var_42bb7bd2 = var_f38ba567;
        }
        
        wait 1;
    }
}

// Namespace safehouse
// Params 1, eflags: 0x4
// Checksum 0xe6ef4ebf, Offset: 0x7af8
// Size: 0x24
function private function_431ca329( player )
{
    player _player_enter_ready_room();
}

// Namespace safehouse
// Params 1, eflags: 0x4
// Checksum 0xc068dc2e, Offset: 0x7b28
// Size: 0x4c
function private function_26cb0f6b( var_39dfa0b1 )
{
    self endon( #"disconnect" );
    self endon( #"left_ready_room" );
    level waittill( #"all_players_ready" );
    self closeluimenu( var_39dfa0b1 );
}

// Namespace safehouse
// Params 0, eflags: 0x4
// Checksum 0xb474a, Offset: 0x7b80
// Size: 0x74c
function private _player_enter_ready_room()
{
    level endon( #"all_players_ready" );
    self endon( #"disconnect" );
    
    if ( self ishost() && level.next_map == savegame_getsavedmap() )
    {
        lui_menu = self openluimenu( "OverwriteProgressWarning" );
        var_4a0f7886 = 1;
        
        while ( true )
        {
            self waittill( #"menuresponse", menu, response );
            
            if ( menu == "OverwriteProgressWarning" )
            {
                if ( response == "cancel" )
                {
                    var_4a0f7886 = 0;
                }
                
                break;
            }
        }
        
        self closeluimenu( lui_menu );
        
        if ( !var_4a0f7886 )
        {
            return;
        }
        
        setdvar( "ui_blocksaves", "0" );
    }
    
    if ( true )
    {
        self.var_bcf382f5 = 1;
        level.var_f0ba161d function_e04cba0f();
        self util::delay( 2, undefined, &lui::screen_fade_out, 0.2 );
        s_bundle = struct::get( "scene_enter_readyroom", "targetname" );
        camanimscripted( self, s_bundle.script_string, gettime(), s_bundle.origin, s_bundle.angles );
        s_bundle scene::play( self );
        level.var_f0ba161d function_a8271940();
        self.var_bcf382f5 = undefined;
    }
    else
    {
        self.var_16b21c9 = self.origin;
        self.var_1b4f3317 = self getplayerangles();
        self hide();
        level.var_f0ba161d function_e04cba0f( self );
        self.var_bcf382f5 = 1;
        fade_out();
    }
    
    self thread function_7a07bdbf();
    
    if ( self.musicplaying === 1 )
    {
        function_f97da4( self );
    }
    
    if ( function_109cf997() )
    {
        function_a0cce87c();
        self util::show_hud( 0 );
        missionoverviewmenu = self openluimenu( "MissionOverviewScreen" );
        self setluimenudata( missionoverviewmenu, "showMissionOverview", 1 );
        self setluimenudata( missionoverviewmenu, "showMissionSelect", 0 );
        self thread function_26cb0f6b( missionoverviewmenu );
        
        while ( true )
        {
            self waittill( #"menuresponse", menu, response );
            
            if ( menu == "MissionRecordVaultMenu" && response == "closed" )
            {
                break;
            }
        }
        
        fade_out();
        
        while ( level flag::get( "player_exiting_ready_room" ) )
        {
            wait 0.05;
        }
        
        level flag::set( "player_exiting_ready_room" );
        self thread function_390094e6();
        self scene::stop();
        var_c821d9d1 = self closeluimenu( missionoverviewmenu );
        self util::show_hud( 1 );
        self notify( #"left_ready_room" );
        self flag::clear( "in_ready_room" );
        self _player_free_ready_room_position();
        endcamanimscripted( self );
    }
    
    if ( isdefined( level.var_58373e3b ) )
    {
        [[ level.var_f3db725a ]]();
    }
    
    if ( true )
    {
        level.var_f0ba161d function_e04cba0f();
        self.var_bcf382f5 = 1;
        self thread function_390094e6();
        s_bundle = struct::get( "scene_exit_readyroom", "targetname" );
        s_bundle scene::init( self );
        wait 0.3;
        fade_in( 0.3 );
        camanimscripted( self, s_bundle.script_string, gettime(), s_bundle.origin, s_bundle.angles );
        s_bundle scene::play( self );
        endcamanimscripted( self );
        level.var_f0ba161d function_a8271940();
        self.var_bcf382f5 = undefined;
    }
    else
    {
        if ( isdefined( self.var_16b21c9 ) )
        {
            fade_out();
            self setorigin( self.var_16b21c9 );
            self setplayerangles( self.var_1b4f3317 );
        }
        else
        {
            function_c2bd8252();
        }
        
        fade_in( 0.3 );
        level.var_f0ba161d function_a8271940( self );
    }
    
    level flag::clear( "player_exiting_ready_room" );
}

// Namespace safehouse
// Params 0
// Checksum 0x71fa9441, Offset: 0x82d8
// Size: 0x2cc
function function_a0cce87c()
{
    self endon( #"disconnect" );
    self endon( #"left_ready_room" );
    level endon( #"all_players_ready" );
    self flag::set( "in_ready_room" );
    fade_out( 0 );
    
    if ( isdefined( level.var_8ea79b65 ) )
    {
        [[ level.var_8ea79b65 ]]();
    }
    
    self _player_get_ready_room_position();
    
    do
    {
        wait 0.05;
    }
    while ( level flag::get( "player_entering_ready_room" ) );
    
    level flag::set( "player_entering_ready_room" );
    self function_54a3b25a();
    self show();
    fade_in();
    var_4ebceea0 = level.a_ready_room[ self.n_ready_room_index ].var_b156618f;
    s_scene = struct::get_script_bundle( "scene", var_4ebceea0 );
    align = scene::get_existing_ent( s_scene.aligntarget, 0, 1 );
    
    foreach ( player in level.activeplayers )
    {
        if ( player flag::get( "in_ready_room" ) )
        {
            camanimscripted( player, s_scene.cameraswitcher, gettime(), align.origin, align.angles );
        }
    }
    
    self scene::play( level.a_ready_room[ self.n_ready_room_index ].var_1fffaf0, self );
    level flag::clear( "player_entering_ready_room" );
    self thread _player_wait_in_ready_room();
}

// Namespace safehouse
// Params 0
// Checksum 0xbf76cc92, Offset: 0x85b0
// Size: 0x44
function function_23a33dca()
{
    level flag::wait_till( "all_players_connected" );
    level clientfield::set( "gameplay_started", 1 );
}

// Namespace safehouse
// Params 0
// Checksum 0x4ddf3b1f, Offset: 0x8600
// Size: 0x16a
function function_6eee8df0()
{
    level flag::wait_till( "all_players_connected" );
    
    while ( true )
    {
        wait 0.05;
        n_ready = 0;
        
        foreach ( player in level.players )
        {
            if ( player flag::get( "in_ready_room" ) )
            {
                n_ready++;
            }
        }
        
        if ( n_ready == getlobbyclientcount() && !getdvarint( "scr_safehouse_test", 0 ) )
        {
            level thread function_56c8845e();
            level thread lui::screen_fade_out( 0 );
            level flag::set( "all_players_ready" );
            return;
        }
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x5b02d7ed, Offset: 0x8778
// Size: 0x246
function _player_wait_in_ready_room()
{
    self endon( #"disconnect" );
    self endon( #"left_ready_room" );
    level endon( #"all_players_ready" );
    self thread scene::play( level.a_ready_room[ self.n_ready_room_index ].str_player_scene, self );
    
    for ( n_cam_index = 0; true ; n_cam_index = 0 )
    {
        level flag::wait_till_clear( "player_entering_ready_room" );
        var_4ebceea0 = level.a_ready_room[ self.n_ready_room_index ].a_str_xcam[ n_cam_index ];
        s_scene = struct::get_script_bundle( "scene", var_4ebceea0 );
        align = scene::get_existing_ent( s_scene.aligntarget, 0, 1 );
        camanimscripted( self, s_scene.cameraswitcher, gettime(), align.origin, align.angles );
        n_time = getcamanimtime( var_4ebceea0 );
        
        if ( n_time < 0.05 )
        {
            n_time = 5;
        }
        else
        {
            n_time /= 0.05;
            n_time += 0.0001;
            n_time = floor( n_time );
            n_time *= 0.05;
        }
        
        level flag::wait_till_timeout( n_time, "player_entering_ready_room" );
        n_cam_index++;
        
        if ( n_cam_index == level.a_ready_room[ self.n_ready_room_index ].a_str_xcam.size )
        {
        }
    }
}

// Namespace safehouse
// Params 0
// Checksum 0xff456b30, Offset: 0x89c8
// Size: 0x8e
function function_769e64f9()
{
    for ( i = 1; i <= 4 ; i++ )
    {
        var_12aba86 = getent( "player_" + i + "_sidearm", "targetname" );
        
        if ( isdefined( var_12aba86 ) )
        {
            var_12aba86 hide();
        }
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x533a2333, Offset: 0x8a60
// Size: 0xea
function function_54a3b25a()
{
    foreach ( player in level.activeplayers )
    {
        if ( player != self && !player flag::get( "in_ready_room" ) )
        {
            var_c10220c5 = self getentitynumber();
            player luinotifyevent( &"comms_event_message", 2, &"CP_SH_CAIRO_PLAYER_READY", var_c10220c5 );
        }
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x6ba2c01d, Offset: 0x8b58
// Size: 0x426
function _init_ready_room_positions()
{
    level.a_ready_room[ 0 ] = spawnstruct();
    level.a_ready_room[ 0 ].b_occupied = 0;
    level.a_ready_room[ 0 ].str_player_scene = "cin_saf_ram_readyroom_3rd_pre100_player01";
    level.a_ready_room[ 0 ].var_1fffaf0 = "cin_saf_ram_readyroom_3rd_pre100_player01_enter";
    level.a_ready_room[ 0 ].var_b156618f = "cin_saf_ram_readyroom_3rd_pre100_p1_entrance_cam";
    level.a_ready_room[ 0 ].a_str_xcam[ 0 ] = "cin_saf_ram_readyroom_3rd_pre100_p1_cam01";
    level.a_ready_room[ 0 ].a_str_xcam[ 1 ] = "cin_saf_ram_readyroom_3rd_pre100_p1_cam02";
    level.a_ready_room[ 0 ].a_str_xcam[ 2 ] = "cin_saf_ram_readyroom_3rd_pre100_p1_cam03";
    level.a_ready_room[ 1 ] = spawnstruct();
    level.a_ready_room[ 1 ].b_occupied = 0;
    level.a_ready_room[ 1 ].str_player_scene = "cin_saf_ram_readyroom_3rd_pre100_player02";
    level.a_ready_room[ 1 ].var_1fffaf0 = "cin_saf_ram_readyroom_3rd_pre100_player02_enter";
    level.a_ready_room[ 1 ].var_b156618f = "cin_saf_ram_readyroom_3rd_pre100_p2_entrance_cam";
    level.a_ready_room[ 1 ].a_str_xcam[ 0 ] = "cin_saf_ram_readyroom_3rd_pre100_p2_cam01";
    level.a_ready_room[ 1 ].a_str_xcam[ 1 ] = "cin_saf_ram_readyroom_3rd_pre100_p2_cam02";
    level.a_ready_room[ 1 ].a_str_xcam[ 2 ] = "cin_saf_ram_readyroom_3rd_pre100_p2_cam03";
    level.a_ready_room[ 2 ] = spawnstruct();
    level.a_ready_room[ 2 ].b_occupied = 0;
    level.a_ready_room[ 2 ].str_player_scene = "cin_saf_ram_readyroom_3rd_pre100_player03";
    level.a_ready_room[ 2 ].var_1fffaf0 = "cin_saf_ram_readyroom_3rd_pre100_player03_enter";
    level.a_ready_room[ 2 ].var_b156618f = "cin_saf_ram_readyroom_3rd_pre100_p3_entrance_cam";
    level.a_ready_room[ 2 ].a_str_xcam[ 0 ] = "cin_saf_ram_readyroom_3rd_pre100_p3_cam01";
    level.a_ready_room[ 2 ].a_str_xcam[ 1 ] = "cin_saf_ram_readyroom_3rd_pre100_p3_cam02";
    level.a_ready_room[ 2 ].a_str_xcam[ 2 ] = "cin_saf_ram_readyroom_3rd_pre100_p3_cam03";
    level.a_ready_room[ 3 ] = spawnstruct();
    level.a_ready_room[ 3 ].b_occupied = 0;
    level.a_ready_room[ 3 ].str_player_scene = "cin_saf_ram_readyroom_3rd_pre100_player04";
    level.a_ready_room[ 3 ].var_1fffaf0 = "cin_saf_ram_readyroom_3rd_pre100_player04_enter";
    level.a_ready_room[ 3 ].var_b156618f = "cin_saf_ram_readyroom_3rd_pre100_p4_entrance_cam";
    level.a_ready_room[ 3 ].a_str_xcam[ 0 ] = "cin_saf_ram_readyroom_3rd_pre100_p4_cam01";
    level.a_ready_room[ 3 ].a_str_xcam[ 1 ] = "cin_saf_ram_readyroom_3rd_pre100_p4_cam02";
    level.a_ready_room[ 3 ].a_str_xcam[ 2 ] = "cin_saf_ram_readyroom_3rd_pre100_p4_cam03";
}

// Namespace safehouse
// Params 0
// Checksum 0xdf78abc5, Offset: 0x8f88
// Size: 0xfc
function _player_get_ready_room_position()
{
    if ( getdvarint( "scr_safehouse_test", 0 ) )
    {
        if ( !isdefined( level.temp_index ) )
        {
            level.temp_index = 0;
        }
        else
        {
            level.temp_index++;
            
            if ( level.temp_index == level.a_ready_room.size )
            {
                level.temp_index = 0;
            }
        }
        
        self.n_ready_room_index = level.temp_index;
        return level.temp_index;
    }
    
    for ( n_index = 0; n_index < level.a_ready_room.size ; n_index++ )
    {
        if ( level.a_ready_room[ n_index ].b_occupied == 0 )
        {
            level.a_ready_room[ n_index ].b_occupied = 1;
            self.n_ready_room_index = n_index;
            return n_index;
        }
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x4ac1fdde, Offset: 0x9090
// Size: 0x2e
function _player_free_ready_room_position()
{
    level.a_ready_room[ self.n_ready_room_index ].b_occupied = 0;
    self.n_ready_room_index = undefined;
}

// Namespace safehouse
// Params 0
// Checksum 0x1628c932, Offset: 0x90c8
// Size: 0x4fc
function init_rooms()
{
    level.rooms = [];
    
    for ( n_player_index = 0; n_player_index < 4 ; n_player_index++ )
    {
        level.rooms[ n_player_index ] = spawnstruct();
        level.rooms[ n_player_index ].b_claimed = 0;
        var_14f1f567 = getentarray( "player_bunk_" + n_player_index, "targetname" );
        
        foreach ( var_6e887f87 in var_14f1f567 )
        {
            switch ( var_6e887f87.script_noteworthy )
            {
                case "data_vault":
                    level.rooms[ n_player_index ].t_vault = var_6e887f87;
                    level.rooms[ n_player_index ].var_71dcdd3e = init_interactive_prompt( var_6e887f87, &"cp_safehouse_data_vault", &"CP_SH_CAIRO_DATA_VAULT2", &vault_think, 0 );
                    level.rooms[ n_player_index ].var_71dcdd3e.n_player_index = n_player_index;
                    level.rooms[ n_player_index ].var_71dcdd3e function_e04cba0f();
                    break;
                default:
                    level.rooms[ n_player_index ].t_wardrobe = var_6e887f87;
                    level.rooms[ n_player_index ].var_a0711246 = init_interactive_prompt( var_6e887f87, &"cp_safehouse_wardrobe", &"CP_SH_CAIRO_WARDROBE2", &wardrobe_think, 0 );
                    level.rooms[ n_player_index ].var_a0711246.n_player_index = n_player_index;
                    level.rooms[ n_player_index ].var_a0711246 function_e04cba0f();
                    break;
                case "foot_locker":
                    level.rooms[ n_player_index ].t_locker = var_6e887f87;
                    level.rooms[ n_player_index ].var_6caeba6e = init_interactive_prompt( var_6e887f87, &"cp_safehouse_collectibles", &"CP_SH_CAIRO_COLLECTIBLES2", &locker_think, 1 );
                    level.rooms[ n_player_index ].var_6caeba6e.n_player_index = n_player_index;
                    level.rooms[ n_player_index ].var_6caeba6e function_e04cba0f();
                    break;
                case "medal_case":
                    level.rooms[ n_player_index ].var_b8276d03 = var_6e887f87;
                    level.rooms[ n_player_index ].var_46f52946 = init_interactive_prompt( var_6e887f87, &"cp_safehouse_medal_case", &"CP_SH_CAIRO_MEDAL_CASE2", &function_7e1ee6bb, 1 );
                    level.rooms[ n_player_index ].var_46f52946.n_player_index = n_player_index;
                    level.rooms[ n_player_index ].var_46f52946 function_e04cba0f();
                    break;
                case "bunk_volume":
                    level.rooms[ n_player_index ].e_volume = var_6e887f87;
                    break;
                case "bunk_door_clip":
                    level.rooms[ n_player_index ].var_ac769486 = var_6e887f87;
                    break;
            }
        }
    }
    
    level.t_mission_vault = getent( "t_mission_vault", "targetname" );
    init_interactive_prompt( level.t_mission_vault, &"cp_safehouse_mission_data", &"CP_SH_CAIRO_MISSION_DATA2", &function_495a58b6, 1 );
}

// Namespace safehouse
// Params 0
// Checksum 0x717e880e, Offset: 0x95d0
// Size: 0x64
function init_stations()
{
    level thread printer_think();
    level thread gun_rack_think();
    level thread console_think();
    level thread function_2b0247d1();
}

// Namespace safehouse
// Params 0
// Checksum 0xd3a49566, Offset: 0x9640
// Size: 0xf2
function printer_think()
{
    thread function_980a453e();
    a_str_scenes[ 0 ] = "p7_fxanim_gp_3d_printer_object01_01_bundle";
    a_str_scenes[ 1 ] = "p7_fxanim_gp_3d_printer_object01_02_bundle";
    a_str_scenes[ 2 ] = "p7_fxanim_gp_3d_printer_object01_03_bundle";
    m_printer = getent( "printer", "targetname" );
    
    while ( true )
    {
        a_str_scenes = array::randomize( a_str_scenes );
        
        for ( i = 0; i < a_str_scenes.size ; i++ )
        {
            m_printer scene::play( a_str_scenes[ i ] );
        }
    }
}

// Namespace safehouse
// Params 0
// Checksum 0xf45e94af, Offset: 0x9740
// Size: 0x9c
function function_980a453e()
{
    t_printer = getent( "t_printer", "targetname" );
    
    if ( isdefined( t_printer ) )
    {
        if ( sessionmodeisonlinegame() )
        {
            init_interactive_prompt( t_printer, &"cp_safehouse_printer", &"CP_SH_CAIRO_PRINTER2", &function_d116f488, 1 );
            return;
        }
        
        t_printer delete();
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x9339e741, Offset: 0x97e8
// Size: 0x74
function function_2fad03f()
{
    var_f531e9c8 = self decorations::function_7006b9ad();
    var_5b1e85ea = self decorations::function_45ddfa6();
    
    if ( var_f531e9c8 && var_5b1e85ea )
    {
        self givedecoration( "cp_medal_all_tokens" );
    }
}

// Namespace safehouse
// Params 1
// Checksum 0x3108fbf0, Offset: 0x9868
// Size: 0x2c
function function_d116f488( player )
{
    player function_711d3c1( "WeaponDesigner" );
}

// Namespace safehouse
// Params 0
// Checksum 0x7c180a43, Offset: 0x98a0
// Size: 0xf2
function function_2b0247d1()
{
    thread function_36069a7();
    a_str_scenes[ 0 ] = "p7_fxanim_gp_robot_arm_doctor_01_bundle";
    a_str_scenes[ 1 ] = "p7_fxanim_gp_robot_arm_doctor_02_bundle";
    a_str_scenes[ 2 ] = "p7_fxanim_gp_robot_arm_doctor_03_bundle";
    var_ecf502d = getent( "arm_doctor", "targetname" );
    
    while ( true )
    {
        a_str_scenes = array::randomize( a_str_scenes );
        
        for ( i = 0; i < a_str_scenes.size ; i++ )
        {
            var_ecf502d scene::play( a_str_scenes[ i ] );
        }
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x5e8290d, Offset: 0x99a0
// Size: 0x6c
function function_36069a7()
{
    t_cybercore = getent( "t_cybercore", "targetname" );
    
    if ( isdefined( t_cybercore ) )
    {
        init_interactive_prompt( t_cybercore, &"cp_safehouse_cybercore", &"CP_SH_CAIRO_CYBERCORE2", &function_b34dec6f, 1 );
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x4bd20f55, Offset: 0x9a18
// Size: 0x124
function function_e17b7386()
{
    self endon( #"disconnect" );
    
    if ( !self flag::exists( "cybercom_upgrade_check" ) )
    {
        self flag::init( "cybercom_upgrade_check" );
    }
    
    if ( self flag::get( "cybercom_upgrade_check" ) )
    {
        return;
    }
    
    self flag::set( "cybercom_upgrade_check" );
    self util::waittill_notify_or_timeout( "stats_changed", 5 );
    
    if ( self decorations::function_45ddfa6() )
    {
        self givedecoration( "cp_medal_all_cybercores" );
        self function_2fad03f();
    }
    
    self flag::clear( "cybercom_upgrade_check" );
}

// Namespace safehouse
// Params 1
// Checksum 0x7797f5f0, Offset: 0x9b48
// Size: 0x44
function function_b34dec6f( player )
{
    player function_711d3c1( "CybercoreUpgrade" );
    player thread function_e17b7386();
}

// Namespace safehouse
// Params 0
// Checksum 0xb9681aa2, Offset: 0x9b98
// Size: 0xd4
function gun_rack_think()
{
    wait 0.05;
    var_d880a1f1 = getent( "gunrack", "targetname" );
    var_d880a1f1 clientfield::set( "gun_rack_init", 1 );
    t_gun_rack = getent( "t_gun_rack", "targetname" );
    init_interactive_prompt( t_gun_rack, &"cp_safehouse_gun_rack", &"CP_SH_CAIRO_GUN_RACK2", &function_b0863559 );
    t_gun_rack thread gun_rack_proximity_check();
}

// Namespace safehouse
// Params 1
// Checksum 0x3ed149f6, Offset: 0x9c78
// Size: 0xe4
function function_862aff95( e_player )
{
    e_player endon( #"death" );
    e_player util::waittill_any( "loadout_changed_timeout", "loadout_changed" );
    e_player flag::clear( "loadout_dirty" );
    e_player loadout::giveloadout( e_player.team, e_player.curclass, e_player.var_dc236bc8 );
    e_player util::waittill_any_timeout( 2, "stats_changed" );
    e_player function_2fad03f();
    e_player notify( #"gun_rack_loadout_changed_handled" );
}

// Namespace safehouse
// Params 1
// Checksum 0x22604e9b, Offset: 0x9d68
// Size: 0xd0
function function_b0863559( e_player )
{
    e_player flag::set_val( "loadout_dirty", 1 );
    thread function_862aff95( e_player );
    e_player function_711d3c1( "chooseClass" );
    e_player updateunlockedattachmentbits();
    var_58b8cb81 = e_player util::waittill_any_timeout( 7, "gun_rack_loadout_changed_handled" );
    
    if ( var_58b8cb81 == "timeout" )
    {
        e_player notify( #"loadout_changed_timeout" );
    }
}

// Namespace safehouse
// Params 1
// Checksum 0xb13f46ae, Offset: 0x9e40
// Size: 0x110
function function_711d3c1( menuref )
{
    self endon( #"death" );
    self flag::set( "safehouse_menu_open" );
    self hideviewmodel();
    luimenu = self openluimenu( menuref );
    level.var_ac964c36 = 0;
    
    do
    {
        self waittill( #"menuresponse", menu, response );
    }
    while ( response != "closed" );
    
    self showviewmodel();
    self flag::clear( "safehouse_menu_open" );
    self thread _delay_close_menu( 0.5, luimenu );
    level.var_ac964c36 = 1;
}

// Namespace safehouse
// Params 0
// Checksum 0xb408de2f, Offset: 0x9f58
// Size: 0x148
function gun_rack_proximity_check()
{
    b_gun_deployed = 0;
    m_gun_rack = getent( "gunrack", "targetname" );
    
    while ( true )
    {
        if ( level flag::get( "player_near_gun_rack" ) && !b_gun_deployed )
        {
            level clientfield::set( "near_gun_rack", 1 );
            m_gun_rack thread scene::play( "p7_fxanim_cp_safehouse_cairo_gunrack_open_bundle" );
            b_gun_deployed = 1;
            wait 6;
        }
        else if ( !level flag::get( "player_near_gun_rack" ) && b_gun_deployed )
        {
            level clientfield::set( "near_gun_rack", 0 );
            m_gun_rack thread scene::play( "p7_fxanim_cp_safehouse_cairo_gunrack_close_bundle" );
            b_gun_deployed = 0;
            wait 4;
        }
        
        wait 0.05;
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x53410373, Offset: 0xa0a8
// Size: 0x44
function console_think()
{
    array::thread_all( getentarray( "chair", "script_noteworthy" ), &function_df2a7519 );
}

// Namespace safehouse
// Params 0
// Checksum 0x487b5eec, Offset: 0xa0f8
// Size: 0x31c
function function_df2a7519()
{
    self flag::init( "player_in_chair" );
    t_use = getent( "training_trig" + self.script_int, "targetname" );
    t_use usetriggerrequirelookat();
    t_proximity = spawn( "trigger_radius", self.origin, 0, 150, 128 );
    prompt = init_interactive_prompt( t_use, &"cp_safehouse_training", &"CP_SH_CAIRO_TRAINING2", &function_fda1c8b5 );
    prompt.var_524f5f14 = self;
    self.var_10c03d0c = 0;
    
    while ( true )
    {
        self flag::wait_till_clear( "player_in_chair" );
        prompt function_a8271940();
        b_player_near = 0;
        
        foreach ( e_player in level.players )
        {
            if ( e_player istouching( t_proximity ) && e_player util::is_player_looking_at( self.origin, 0.5, 0 ) )
            {
                b_player_near = 1;
            }
        }
        
        if ( b_player_near && !self.var_10c03d0c )
        {
            self scene::play( "p7_fxanim_cp_safehouse_chair_console_" + self.script_int + "_open_bundle" );
            self.var_10c03d0c = 1;
            t_use setvisibletoall();
        }
        else if ( !b_player_near && self.var_10c03d0c )
        {
            t_use setinvisibletoall();
            self scene::play( "p7_fxanim_cp_safehouse_chair_console_" + self.script_int + "_close_bundle" );
            self.var_10c03d0c = 0;
        }
        
        wait 0.05;
    }
}

// Namespace safehouse
// Params 1
// Checksum 0xac674738, Offset: 0xa420
// Size: 0x21c
function function_fda1c8b5( e_player )
{
    str_dir = "left";
    
    if ( self.var_524f5f14.script_int < 3 )
    {
        str_dir = "right";
    }
    
    level.var_f0ba161d function_e04cba0f( e_player );
    objectives::hide( "cp_safehouse_ready_room", e_player );
    e_player.var_597c2939 = self.var_524f5f14;
    e_player.var_8ea3df31 = str_dir;
    self.var_524f5f14.prompt = self;
    self.var_524f5f14 flag::set( "player_in_chair" );
    self function_e04cba0f();
    self.var_524f5f14 scene::play( "cin_saf_ram_training_1st_getin_" + str_dir, e_player );
    level clientfield::set( "toggle_console_" + self.var_524f5f14.script_int, 1 );
    self.var_524f5f14 scene::play( "p7_fxanim_cp_safehouse_chair_console_" + self.var_524f5f14.script_int + "_close_bundle" );
    self.var_524f5f14.var_10c03d0c = 0;
    e_player lui::screen_fade_out( 0.6, "black" );
    e_player.var_67b6f3d0 = e_player.curclass;
    e_player lui::screen_fade_in( 0, "black" );
    e_player thread function_ecca1245();
}

// Namespace safehouse
// Params 0
// Checksum 0xe443ad33, Offset: 0xa648
// Size: 0x9e
function function_a153016()
{
    for ( i = 0; i < 6 ; i++ )
    {
        var_b53e21eb = self getdstat( "PlayerStatsByMap", "cp_sh_cairo", "completedDifficulties", i );
        self setdstat( "PlayerStatsByMap", "cp_sh_cairo", "previousCompletedDifficulties", i, var_b53e21eb );
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x66054996, Offset: 0xa6f0
// Size: 0x224
function function_ecca1245()
{
    self endon( #"disconnect" );
    w_player = self getcurrentweapon();
    self flag::set( "in_training_sim" );
    self thread lui::screen_fade_in( 0, "black" );
    
    if ( self function_109cf997( "chooseClass_TrainingSim" ) )
    {
        self thread lui::screen_fade_out( 0, "white" );
        self globallogic_player::function_4cef9872( getrootmapname() );
        self function_a153016();
        self.var_597c2939 function_29532574( self, self.var_8ea3df31, w_player );
        self clientfield::set_player_uimodel( "safehouse.inTrainingSim", 1 );
        self function_c550ee23( self.var_597c2939.script_int );
        return;
    }
    
    self closemenu( "chooseClass_TrainingSim" );
    self closemenu( "FullBlack" );
    self thread lui::screen_fade_in( 1, "black" );
    self function_6ebf2134();
    
    if ( isalive( self ) )
    {
        self flag::clear( "in_training_sim" );
    }
}

// Namespace safehouse
// Params 0
// Checksum 0xfc272b07, Offset: 0xa920
// Size: 0x1bc
function function_1a70861a()
{
    self endon( #"disconnect" );
    self hide();
    var_17c60336 = "cin_saf_ram_training_1st_sit_" + self.var_8ea3df31;
    s_scenedef = struct::get_script_bundle( "scene", var_17c60336 );
    
    if ( isdefined( s_scenedef ) && isdefined( s_scenedef.objects ) && s_scenedef.objects.size > 0 )
    {
        s_scenedef.objects[ 0 ].lerptime = 0;
        s_scenedef.objects[ 0 ].cameratween = 0;
        s_scenedef.objects[ 0 ].mainblend = 0.01;
    }
    
    self.var_597c2939 thread scene::play( var_17c60336, self );
    wait 0.05;
    self show();
    wait 0.05;
    self.training_dummy delete();
    self.var_f5434f17 delete();
    namespace_c550ee23::function_3206b93a();
    self closemenu( "FullBlack" );
    self thread function_ecca1245();
}

// Namespace safehouse
// Params 0
// Checksum 0x3cc9a179, Offset: 0xaae8
// Size: 0xdc
function function_680cf465()
{
    if ( isdefined( self.var_597c2939 ) )
    {
        self.var_597c2939.prompt function_a8271940();
        self.var_597c2939.var_10c03d0c = 1;
        self.var_597c2939 flag::clear( "player_in_chair" );
        level clientfield::set( "toggle_console_" + self.var_597c2939.script_int, 0 );
    }
    
    if ( isdefined( self.training_dummy ) )
    {
        self.training_dummy delete();
        self.var_f5434f17 delete();
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x46cc9bfc, Offset: 0xabd0
// Size: 0xfc
function function_6ebf2134()
{
    function_5b426a60( self.var_67b6f3d0 );
    self.var_597c2939 scene::play( "p7_fxanim_cp_safehouse_chair_console_" + self.var_597c2939.script_int + "_open_bundle" );
    self.var_597c2939 scene::play( "cin_saf_ram_training_1st_getout_" + self.var_8ea3df31, self );
    self clientfield::set_player_uimodel( "safehouse.inTrainingSim", 0 );
    self function_680cf465();
    wait 1;
    function_10650e35();
    level.var_f0ba161d function_a8271940( self );
    objectives::show( "cp_safehouse_ready_room", self );
}

// Namespace safehouse
// Params 3
// Checksum 0xaca81059, Offset: 0xacd8
// Size: 0x1ac
function function_29532574( e_player, str_dir, w_player )
{
    e_player.training_dummy = util::spawn_player_clone( e_player );
    e_player.training_dummy clientfield::set( "player_clone", 1 );
    e_player.var_f5434f17 = util::spawn_model( "tag_origin", e_player.training_dummy gettagorigin( "tag_weapon_right" ), e_player.training_dummy gettagangles( "tag_weapon_right" ) );
    e_player.var_f5434f17 useweaponmodel( w_player, w_player.worldmodel, e_player getweaponoptions( w_player ) );
    e_player.var_f5434f17 linkto( e_player.training_dummy, "tag_weapon_right" );
    e_player.var_10aaa336 = ( 0, 0, e_player.origin[ 2 ] - 10000 );
    self thread scene::play( "cin_saf_ram_training_1st_sit_fake_" + str_dir, e_player.training_dummy );
}

// Namespace safehouse
// Params 1
// Checksum 0xae4ac2d7, Offset: 0xae90
// Size: 0x174
function function_c550ee23( n_num )
{
    self endon( #"disconnect" );
    function_b439510f();
    util::wait_network_frame();
    self thread function_d850faa0( n_num );
    self closemenu( "FullBlack" );
    namespace_c550ee23::run( "training_sim_" + n_num );
    b_alive = 1;
    
    if ( !isalive( self ) )
    {
        b_alive = 0;
        self util::waittill_either( "cp_deathcam_ended", "spawned" );
    }
    
    self openmenu( "FullBlack" );
    
    /#
        while ( self isinmovemode( "<dev string:x9c>", "<dev string:xa0>" ) )
        {
            wait 0.05;
        }
    #/
    
    if ( b_alive )
    {
        function_b11df48f();
        self thread function_1a70861a();
    }
}

// Namespace safehouse
// Params 1
// Checksum 0xa7c12937, Offset: 0xb010
// Size: 0x2c4
function function_d850faa0( n_num )
{
    self waittill( #"hash_ce89933d" );
    v_org = self localtoworldcoords( ( -45, -15, 60 ) );
    e_cam = util::spawn_model( "tag_origin", v_org, combineangles( self.angles, ( -10, 5, 0 ) ) );
    e_cam linkto( self );
    hidemiscmodels( "training_sim_extracam_screen_off" + n_num );
    showmiscmodels( "training_sim_extracam_screen_on" + n_num );
    function_f7f318a5( n_num, 1 );
    
    while ( isdefined( self.var_24c69c09 ) && isdefined( self ) && self.var_24c69c09 )
    {
        var_4f93c6de = 0;
        
        foreach ( player in level.activeplayers )
        {
            if ( player != self && !( isdefined( player.var_24c69c09 ) && player.var_24c69c09 ) )
            {
                var_4f93c6de = 1;
                break;
            }
        }
        
        e_cam clientfield::set( "training_sim_extracam", var_4f93c6de ? n_num : 0 );
        util::wait_network_frame();
    }
    
    e_cam clientfield::set( "training_sim_extracam", 0 );
    function_f7f318a5( n_num, 0 );
    util::wait_network_frame();
    e_cam delete();
    hidemiscmodels( "training_sim_extracam_screen_on" + n_num );
    showmiscmodels( "training_sim_extracam_screen_off" + n_num );
}

// Namespace safehouse
// Params 2
// Checksum 0x3869acb7, Offset: 0xb2e0
// Size: 0x168
function function_f7f318a5( n_num, b_on )
{
    level.var_b57a1b14[ n_num ] = b_on;
    var_fa621f28 = [];
    var_fa621f28[ 1 ] = 0;
    var_fa621f28[ 2 ] = 0;
    var_fa621f28[ 3 ] = 0;
    var_fa621f28[ 4 ] = 0;
    
    for ( monitor = 1; monitor <= 4 ; monitor++ )
    {
        for ( cam = 1; cam <= 4 ; cam++ )
        {
            if ( isdefined( level.var_b57a1b14[ cam ] ) && level.var_b57a1b14[ cam ] && !( isdefined( var_fa621f28[ monitor ] ) && var_fa621f28[ monitor ] ) )
            {
                showmiscmodels( "wall_extracam" + monitor + cam );
                var_fa621f28[ monitor ] = 1;
                continue;
            }
            
            hidemiscmodels( "wall_extracam" + monitor + cam );
        }
    }
}

// Namespace safehouse
// Params 1
// Checksum 0xa058e578, Offset: 0xb450
// Size: 0x2c8
function locker_think( player )
{
    player endon( #"death" );
    player clientfield::set_player_uimodel( "safehouse.inClientBunk", self.trigger.e_owner getentitynumber() );
    player function_2cc92070();
    s_chest = function_342806c6( "scriptbundle_collectibles", "script_noteworthy", self.n_player_index );
    
    if ( isdefined( s_chest ) )
    {
        if ( !isdefined( s_chest.b_open ) )
        {
            s_chest.b_open = 0;
        }
        
        if ( !isdefined( s_chest.var_78c06f4d ) )
        {
            s_chest.var_78c06f4d = 0;
        }
        
        s_chest.b_open++;
        s_chest thread close_locker( player );
        
        if ( s_chest.b_open == 1 )
        {
            while ( s_chest.var_78c06f4d )
            {
                s_chest waittill( #"closed" );
            }
            
            s_chest scene::play();
        }
    }
    
    self.trigger setinvisibletoplayer( player );
    menu_name = undefined;
    
    if ( player === self.trigger.e_owner )
    {
        menu_name = "BrowseCollectibles";
    }
    else
    {
        menu_name = "InspectingCollectibles";
    }
    
    player openluimenu( menu_name );
    player util::show_hud( 0 );
    level.var_ac964c36 = 0;
    
    do
    {
        player waittill( #"menuresponse", menu, response );
    }
    while ( menu != menu_name && response != "closed" );
    
    player util::show_hud( 1 );
    self.trigger setvisibletoplayer( player );
    player function_24f12dbc();
    player notify( #"close_locker" );
    level.var_ac964c36 = 1;
}

// Namespace safehouse
// Params 1
// Checksum 0xe16fd60e, Offset: 0xb720
// Size: 0x54
function function_a35cc107( a_ents )
{
    while ( self.b_open )
    {
        self waittill( #"close" );
    }
    
    self.var_78c06f4d = 1;
    self scene::play( "p7_fxanim_cp_safehouse_crates_plastic_tech_close_bundle", a_ents );
}

// Namespace safehouse
// Params 1
// Checksum 0x7bf36852, Offset: 0xb780
// Size: 0x44
function function_6ca97001( a_ents )
{
    self.var_78c06f4d = 0;
    self notify( #"closed" );
    self scene::init( "p7_fxanim_cp_safehouse_crates_plastic_tech_bundle" );
}

// Namespace safehouse
// Params 1
// Checksum 0x4bd7102, Offset: 0xb7d0
// Size: 0x56
function close_locker( player )
{
    player util::waittill_either( "death", "close_locker" );
    self.b_open--;
    
    if ( self.b_open == 0 )
    {
        self notify( #"close" );
    }
}

// Namespace safehouse
// Params 1
// Checksum 0xce52f7c7, Offset: 0xb830
// Size: 0x198
function function_7e1ee6bb( player )
{
    self.trigger endon( #"death" );
    self.trigger triggerenable( 0 );
    self function_e04cba0f();
    player clientfield::set_player_uimodel( "safehouse.inClientBunk", self.trigger.e_owner getentitynumber() );
    player openluimenu( "InspectMedalCase" );
    player util::show_hud( 0 );
    level.var_ac964c36 = 0;
    player function_2cc92070();
    
    do
    {
        player waittill( #"menuresponse", menu, response );
    }
    while ( menu != "InspectMedalCase" && response != "closed" );
    
    player function_24f12dbc();
    self.trigger triggerenable( 1 );
    player util::show_hud( 1 );
    self function_a8271940();
    level.var_ac964c36 = 1;
}

// Namespace safehouse
// Params 1
// Checksum 0xac992687, Offset: 0xb9d0
// Size: 0xc4
function function_495a58b6( player )
{
    self.trigger setinvisibletoplayer( player );
    player hideviewmodel();
    player function_2cc92070();
    player function_c26d52c3();
    self.trigger setvisibletoplayer( player );
    player showviewmodel();
    player function_24f12dbc();
}

// Namespace safehouse
// Params 0
// Checksum 0x9ebaa5c2, Offset: 0xbaa0
// Size: 0x188
function function_c26d52c3()
{
    menuhandle = self openluimenu( "MissionRecordVaultMenu" );
    self util::show_hud( 0 );
    level.var_ac964c36 = 0;
    self setluimenudata( menuhandle, "highestMapReached", world.highest_map_reached );
    self setluimenudata( menuhandle, "showMissionSelect", self ishost() );
    self waittill( #"menuresponse", menu, response );
    
    while ( response != "closed" )
    {
        level.next_map = response;
        level clientfield::set( "nextMap", getmaporder( level.next_map ) );
        level notify( #"hash_2456008" );
        self waittill( #"menuresponse", menu, response );
    }
    
    self util::show_hud( 1 );
    self closeluimenu( menuhandle );
    level.var_ac964c36 = 1;
}

// Namespace safehouse
// Params 0
// Checksum 0x71c608f8, Offset: 0xbc30
// Size: 0x24
function function_3374f9fe()
{
    level waittill( #"switchmap_preload_finished" );
    switchmap_switch();
}

// Namespace safehouse
// Params 1
// Checksum 0xa942d200, Offset: 0xbc60
// Size: 0xc4
function function_f97da4( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player setcontrolleruimodelvalue( "MusicPlayer.state", "stop" );
    player notify( #"music_stop" );
    player.musicplaying = 0;
    
    if ( isdefined( player.var_c6ff6155 ) )
    {
        alias = tablelookupcolumnforrow( "gamedata/tables/common/music_player.csv", player.var_c6ff6155, 1 );
        player stopsound( alias );
    }
}

// Namespace safehouse
// Params 2
// Checksum 0xf916c62f, Offset: 0xbd30
// Size: 0x2b4
function function_648c6218( player, var_d60677e0 )
{
    if ( !isdefined( var_d60677e0 ) )
    {
        var_d60677e0 = 0;
    }
    
    if ( !isdefined( player.var_c6ff6155 ) )
    {
        player.var_c6ff6155 = 0;
    }
    
    var_ccb4b066 = tablelookuprowcount( "gamedata/tables/common/music_player.csv" );
    
    while ( player.var_c6ff6155 < 0 )
    {
        player.var_c6ff6155 += var_ccb4b066;
    }
    
    player.var_c6ff6155 %= var_ccb4b066;
    
    for ( alias = tablelookupcolumnforrow( "gamedata/tables/common/music_player.csv", player.var_c6ff6155, 1 ); !player checkifsongunlocked( alias ) ; alias = tablelookupcolumnforrow( "gamedata/tables/common/music_player.csv", player.var_c6ff6155, 1 ) )
    {
        player.var_c6ff6155 += var_d60677e0 ? -1 : 1;
        player.var_c6ff6155 %= var_ccb4b066;
    }
    
    title = tablelookupcolumnforrow( "gamedata/tables/common/music_player.csv", player.var_c6ff6155, 2 );
    artist = tablelookupcolumnforrow( "gamedata/tables/common/music_player.csv", player.var_c6ff6155, 3 );
    var_e862021a = tablelookupcolumnforrow( "gamedata/tables/common/music_player.csv", player.var_c6ff6155, 4 );
    player setcontrolleruimodelvalue( "MusicPlayer.title", title );
    player setcontrolleruimodelvalue( "MusicPlayer.artist", artist );
    player setcontrolleruimodelvalue( "MusicPlayer.artist2", var_e862021a );
}

// Namespace safehouse
// Params 0
// Checksum 0x5d64e662, Offset: 0xbff0
// Size: 0x134
function function_2ce69251()
{
    self endon( #"music_stop" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        function_648c6218( self );
        alias = tablelookupcolumnforrow( "gamedata/tables/common/music_player.csv", self.var_c6ff6155, 1 );
        self setcontrolleruimodelvalue( "MusicPlayer.state", "play" );
        self playsoundtoplayer( alias, self );
        len = float( soundgetplaybacktime( alias ) ) / 1000;
        util::waittill_notify_or_timeout( "music_change", len + 3 );
        self stopsound( alias );
        self.var_c6ff6155 += 1;
    }
}

// Namespace safehouse
// Params 1
// Checksum 0xa3e5c82d, Offset: 0xc130
// Size: 0x7b8
function vault_think( player )
{
    player endon( #"death" );
    player hideviewmodel();
    var_162c6190 = getentarray( "m_terminal_asleep", "targetname" );
    var_2f902017 = getentarray( "m_terminal_awake", "targetname" );
    var_69c1a63b = arraygetclosest( player.origin, var_162c6190 );
    var_cdc7765d = arraygetclosest( player.origin, var_2f902017 );
    var_cdc7765d show();
    var_69c1a63b hide();
    player function_b439510f();
    menuhandle = player openluimenu( "PersonalDataVaultMenu" );
    player util::show_hud( 0 );
    level.var_ac964c36 = 0;
    player function_2cc92070();
    function_648c6218( player );
    s_cam = struct::get( "tag_align_desk_0" + self.n_player_index + 1, "targetname" );
    camanimscripted( player, "c_saf_collectible_computer_in", gettime(), s_cam.origin, s_cam.angles );
    var_4f81b21 = "";
    
    do
    {
        player waittill( #"menuresponse", menu, response );
        
        switch ( response )
        {
            case "doa2":
                foreach ( player in getplayers() )
                {
                    function_f97da4( player );
                }
                
                level thread function_973b77f9();
                switchmap_setloadingmovie( "cp_doa_bo3_load_loadingmovie" );
                switchmap_load( "cp_doa_bo3", "doa" );
                wait 8;
                switchmap_switch();
                
                foreach ( player in getplayers() )
                {
                    playerentnum = player getentitynumber();
                    player setcharacterbodytype( 0, 0 );
                    player setcharacterbodystyle( 0 );
                    player setcharacterhelmetstyle( 0 );
                }
                
                break;
            case "musicTrackBack":
                if ( player.musicplaying === 1 )
                {
                    player.var_c6ff6155 -= 1;
                    function_648c6218( player, 1 );
                    player.var_c6ff6155 -= 1;
                    player notify( #"music_change" );
                }
                else
                {
                    player.var_c6ff6155 -= 1;
                    function_648c6218( player, 1 );
                }
                
                break;
            default:
                if ( !isdefined( player.var_c6ff6155 ) )
                {
                    player.var_c6ff6155 = 0;
                    player.musicplaying = 0;
                }
                
                if ( player.musicplaying === 1 )
                {
                    alias = tablelookupcolumnforrow( "gamedata/tables/common/music_player.csv", player.var_c6ff6155, 1 );
                    player setcontrolleruimodelvalue( "MusicPlayer.state", "stop" );
                    player stopsound( alias );
                    player notify( #"music_stop" );
                    player.musicplaying = 0;
                    player thread function_390094e6();
                }
                else
                {
                    player notify( #"music_stop" );
                    player thread function_2ce69251();
                    player.musicplaying = 1;
                    level thread function_973b77f9( player );
                }
                
                break;
            case "musicTrackNext":
                if ( player.musicplaying === 1 )
                {
                    player notify( #"music_change" );
                }
                else
                {
                    player.var_c6ff6155 += 1;
                    function_648c6218( player );
                }
                
                break;
        }
    }
    while ( response != "closed" );
    
    player function_10650e35();
    player util::show_hud( 1 );
    player closeluimenu( menuhandle );
    endcamanimscripted( player );
    var_69c1a63b show();
    var_cdc7765d hide();
    player showviewmodel();
    player function_24f12dbc();
    level.var_ac964c36 = 1;
}

// Namespace safehouse
// Params 1
// Checksum 0xe20fc1de, Offset: 0xc8f0
// Size: 0x238
function wardrobe_think( player )
{
    player endon( #"death" );
    self.trigger triggerenable( 0 );
    player function_2cc92070();
    level.var_f0ba161d function_e04cba0f( player );
    var_394acf93 = function_342806c6( "scriptbundle_wardrobe", "script_noteworthy", self.n_player_index );
    var_394acf93 thread close_wardrobe( player );
    var_394acf93 scene::play();
    player lui::screen_fade_out( 0 );
    player util::delay( 0.5, "disconnect", &lui::screen_fade_in, 0.5 );
    player openluimenu( "PersonalizeCharacter" );
    player util::show_hud( 0 );
    level.var_ac964c36 = 0;
    
    do
    {
        player waittill( #"menuresponse", menu, response );
    }
    while ( menu != "PersonalizeCharacter" || response != "closed" );
    
    player resetcharactercustomization();
    player function_24f12dbc();
    self.trigger triggerenable( 1 );
    level.var_f0ba161d function_a8271940( player );
    player notify( #"close_wardrobe" );
    level.var_ac964c36 = 1;
}

// Namespace safehouse
// Params 1
// Checksum 0xa9ed4d5f, Offset: 0xcb30
// Size: 0x3c
function function_2cafba2( a_ents )
{
    self waittill( #"close" );
    self scene::play( "p7_fxanim_cp_safehouse_locker_metal_barrack_close_bundle", a_ents );
}

// Namespace safehouse
// Params 1
// Checksum 0x532c0f9c, Offset: 0xcb78
// Size: 0x2c
function function_ffeaa7c4( a_ents )
{
    self scene::init( "p7_fxanim_cp_safehouse_locker_metal_barrack_bundle" );
}

// Namespace safehouse
// Params 1
// Checksum 0x418fee22, Offset: 0xcbb0
// Size: 0x42
function close_wardrobe( player )
{
    player util::waittill_either( "death", "close_wardrobe" );
    self notify( #"close" );
}

// Namespace safehouse
// Params 0
// Checksum 0x9cbb4d68, Offset: 0xcc00
// Size: 0x204
function player_claim_room()
{
    n_player = self getentitynumber();
    level.rooms[ n_player ].b_claimed = 1;
    level.rooms[ n_player ].t_locker.e_owner = self;
    level.rooms[ n_player ].var_b8276d03.e_owner = self;
    level.rooms[ n_player ].var_71dcdd3e function_a8271940( self );
    level.rooms[ n_player ].var_a0711246 function_a8271940( self );
    level.rooms[ n_player ].var_6caeba6e function_a8271940();
    level.rooms[ n_player ].var_46f52946 function_a8271940();
    level.rooms[ n_player ].t_vault triggerenable( 1 );
    level.rooms[ n_player ].t_wardrobe triggerenable( 1 );
    level.rooms[ n_player ].t_locker triggerenable( 1 );
    level.rooms[ n_player ].var_b8276d03 triggerenable( 1 );
    self thread function_e1f7d265( n_player );
}

// Namespace safehouse
// Params 1
// Checksum 0xe28db1b5, Offset: 0xce10
// Size: 0x180
function function_e1f7d265( n_player )
{
    while ( true )
    {
        var_29c18c11 = getentarray( "medals", "script_noteworthy" );
        var_29c18c11 = getentarrayfromarray( var_29c18c11, "player_bunk_" + n_player, "targetname" );
        a_decorations = self getdecorations();
        
        for ( i = 0; i < var_29c18c11.size ; i++ )
        {
            var_889a5942 = var_29c18c11[ i ];
            var_292c51bd = a_decorations[ i ];
            
            if ( isdefined( var_292c51bd.medalearned ) && isdefined( var_292c51bd ) && var_292c51bd.medalearned )
            {
                var_889a5942 setmodel( var_292c51bd.model );
                var_889a5942 show();
                continue;
            }
            
            var_889a5942 hide();
        }
        
        level waittill( #"decoration_awarded" );
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x8190806f, Offset: 0xcf98
// Size: 0x30c
function function_a24e854d()
{
    self endon( #"death" );
    
    if ( level.var_2e24ecad === 1 )
    {
        return;
    }
    
    n_player = self getentitynumber();
    
    if ( world.cp_bunk_anim_type === 1 )
    {
        var_ce111e02 = function_342806c6( "getup_desk", "script_noteworthy", n_player );
    }
    else
    {
        var_ce111e02 = function_342806c6( "getup_bed", "script_noteworthy", n_player );
    }
    
    var_ce111e02 scene::init( self );
    self hide();
    self util::streamer_wait( undefined, 0, 10 );
    setdvar( "ui_allowDisplayContinue", 1 );
    
    if ( isloadingcinematicplaying() )
    {
        do
        {
            wait 0.05;
        }
        while ( isloadingcinematicplaying() );
    }
    else
    {
        wait 1;
    }
    
    self util::streamer_wait( undefined, 0, 10 );
    self flag::wait_till_clear( "in_aar" );
    self show();
    m_bunk_door = getent( "bunk_" + n_player + 1 + "_door", "targetname" );
    
    if ( isdefined( m_bunk_door ) )
    {
        m_bunk_door thread scene::play( "p7_fxanim_cp_safehouse_door_bunk_" + n_player + 1 + "_open_bundle" );
    }
    
    wait 1.8;
    
    if ( isdefined( level.rooms[ n_player ].var_ac769486 ) )
    {
        level.rooms[ n_player ].var_ac769486 notsolid();
    }
    
    self flag::set( "start_player" );
    var_ce111e02 scene::play( self );
    self util::show_hud( 1 );
    objectives::hide( "cp_safehouse_training_start", self );
    objectives::hide( "cp_safehouse_training_nextround", self );
}

// Namespace safehouse
// Params 0
// Checksum 0x722db1c, Offset: 0xd2b0
// Size: 0x294
function player_unclaim_room()
{
    n_player = self getentitynumber();
    level.rooms[ n_player ].var_ac769486 solid();
    
    foreach ( e_player in level.players )
    {
        if ( e_player != self && e_player istouching( level.rooms[ n_player ].e_volume ) )
        {
            e_player thread function_c2bd8252();
        }
    }
    
    level.rooms[ n_player ].b_claimed = 0;
    level.rooms[ n_player ].t_locker.e_owner = undefined;
    level.rooms[ n_player ].var_b8276d03.e_owner = undefined;
    level.rooms[ n_player ].var_71dcdd3e function_e04cba0f();
    level.rooms[ n_player ].var_a0711246 function_e04cba0f();
    level.rooms[ n_player ].var_6caeba6e function_e04cba0f();
    level.rooms[ n_player ].var_46f52946 function_e04cba0f();
    m_bunk_door = getent( "bunk_" + n_player + 1 + "_door", "targetname" );
    
    if ( isdefined( m_bunk_door ) )
    {
        m_bunk_door thread scene::play( "p7_fxanim_cp_safehouse_door_bunk_" + n_player + 1 + "_close_bundle" );
        wait 2.5;
    }
}

// Namespace safehouse
// Params 0
// Checksum 0xec92333c, Offset: 0xd550
// Size: 0x1a4
function function_c2bd8252()
{
    self endon( #"disconnect" );
    var_512dfdf0 = array( "InspectMedalCase", "InspectingCollectibles" );
    
    foreach ( menuname in var_512dfdf0 )
    {
        luimenu = self getluimenu( menuname );
        
        if ( isdefined( luimenu ) )
        {
            self closemenu( menuname );
            self notify( #"menuresponse", menuname, "cancel" );
        }
    }
    
    fade_out();
    self scene::stop();
    self player::simple_respawn();
    self thread loadout::giveloadout( self.team, self.curclass, level.var_dc236bc8 );
    self function_b11df48f();
    fade_in();
}

// Namespace safehouse
// Params 1
// Checksum 0x43e0682f, Offset: 0xd700
// Size: 0x3c
function fade_out( n_time )
{
    if ( !isdefined( n_time ) )
    {
        n_time = 0.5;
    }
    
    lui::screen_fade_out( n_time );
}

// Namespace safehouse
// Params 1
// Checksum 0xfb60bc3d, Offset: 0xd748
// Size: 0x3c
function fade_in( n_time )
{
    if ( !isdefined( n_time ) )
    {
        n_time = 0.5;
    }
    
    self thread lui::screen_fade_in( n_time );
}

// Namespace safehouse
// Params 0
// Checksum 0xb1b4e8f5, Offset: 0xd790
// Size: 0x3c
function function_2cc92070()
{
    self flag::set( "interacting" );
    self thread function_dd07584d();
}

// Namespace safehouse
// Params 0
// Checksum 0xf7e4952e, Offset: 0xd7d8
// Size: 0xa4
function function_dd07584d()
{
    foreach ( player in level.players )
    {
        player setinvisibletoplayer( self );
    }
    
    scene::init( "player_inspection", self );
}

// Namespace safehouse
// Params 0
// Checksum 0xbf87ccbe, Offset: 0xd888
// Size: 0xcc
function function_24f12dbc()
{
    foreach ( player in level.players )
    {
        player setvisibletoplayer( self );
    }
    
    self thread scene::play( "player_inspection", self );
    self flag::clear( "interacting" );
}

// Namespace safehouse
// Params 3
// Checksum 0x726ab99c, Offset: 0xd960
// Size: 0x13c
function function_6dacc745( str_value, str_key, var_27cdf02a )
{
    a_return = [];
    var_9cc495a4 = struct::get_array( str_value, str_key );
    
    foreach ( s_bundle in var_9cc495a4 )
    {
        if ( s_bundle.targetname === "player_bunk_" + var_27cdf02a )
        {
            if ( !isdefined( a_return ) )
            {
                a_return = [];
            }
            else if ( !isarray( a_return ) )
            {
                a_return = array( a_return );
            }
            
            a_return[ a_return.size ] = s_bundle;
        }
    }
    
    return a_return;
}

// Namespace safehouse
// Params 3
// Checksum 0xc7b340b1, Offset: 0xdaa8
// Size: 0x8e
function function_342806c6( str_value, str_key, var_27cdf02a )
{
    a_return = function_6dacc745( str_value, str_key, var_27cdf02a );
    assert( a_return.size < 2, "<dev string:xa7>" );
    
    if ( a_return.size == 1 )
    {
        return a_return[ 0 ];
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x3ce97e2, Offset: 0xdb40
// Size: 0x44
function function_390094e6()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"hash_3a6467f0" );
    wait 2;
    music::setmusicstate( "underscore", self );
}

// Namespace safehouse
// Params 1
// Checksum 0x8afbb7f9, Offset: 0xdb90
// Size: 0xe2
function function_973b77f9( dude )
{
    if ( isdefined( dude ) )
    {
        dude notify( #"hash_3a6467f0" );
        music::setmusicstate( "none", dude );
        return;
    }
    
    foreach ( player in level.players )
    {
        player notify( #"hash_3a6467f0" );
        music::setmusicstate( "none", player );
    }
}

// Namespace safehouse
// Params 0
// Checksum 0x7db3629a, Offset: 0xdc80
// Size: 0x1c
function function_7a07bdbf()
{
    music::setmusicstate( "ready_room", self );
}

// Namespace safehouse
// Params 0
// Checksum 0xbb7c709f, Offset: 0xdca8
// Size: 0xa4
function function_56c8845e()
{
    foreach ( player in level.players )
    {
        player notify( #"hash_3a6467f0" );
    }
    
    wait 1;
    music::setmusicstate( "next_mission" );
}

