#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_mapping_drone;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/cp/cp_mi_sing_sgen_accolades;
#using scripts/cp/cp_mi_sing_sgen_enter_silo;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_testing_lab_igc;
#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace cp_mi_sing_sgen_fallen_soldiers;

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 2, eflags: 0x0
// Checksum 0x291e3c16, Offset: 0x1028
// Size: 0x2aa
function function_73eb52a7(str_objective, var_74cd64bc) {
    level flag::init("kane_robots_convo_done");
    level flag::init("fallen_soldiers_hendricks_ready_to_enter_dayroom");
    level thread function_68f0b726();
    spawner::add_spawn_function_group("fallen_soldiers_spawner", "script_noteworthy", &function_fbd51610);
    spawner::add_spawn_function_group("fallen_soldiers_start_awake", "script_noteworthy", &function_bebe324d);
    if (var_74cd64bc) {
        load::function_73adcefc();
        sgen::function_bff1a867(str_objective);
        nd_post_jump_downs = getnode("nd_post_jump_downs", "targetname");
        level.var_2fd26037 thread ai::force_goal(nd_post_jump_downs, 32);
        level battlechatter::function_d9f49fba(0);
        level clientfield::set("w_underwater_state", 1);
        level clientfield::set("fallen_soldiers_client_fxanims", 1);
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::set("cp_level_sgen_find_recon_drone", level.var_ea764859);
        level thread namespace_d40478f6::function_71f06599();
        mapping_drone::spawn_drone(undefined, 0);
        playfxontag(level._effect["drone_sparks"], level.var_ea764859, "tag_origin");
        load::function_a2995f22();
    }
    for (x = 0; x < 6; x++) {
        array::run_all(getentarray("robot0" + x, "targetname"), &delete);
    }
    main();
    skipto::function_be8adfb8("fallen_soldiers");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 4, eflags: 0x0
// Checksum 0x13f99af9, Offset: 0x12e0
// Size: 0x112
function function_51f4af5d(str_objective, var_d6b1856a, var_e4cd2b8b, player) {
    for (x = 0; x < 6; x++) {
        array::thread_all(getentarray("robot0" + x, "targetname"), &util::self_delete);
    }
    exploder::delete_exploder_on_clients("fallen_soldiers_decon_spray");
    struct::function_368120a1("scene", "cin_sgen_12_01_corvus_vign_secret_entrance_hendricks");
    struct::function_368120a1("scene", "cin_sgen_12_01_corvus_vign_dayroom");
    struct::function_368120a1("scene", "cin_sgen_13_01_fallensoldiers_vign_grab_start");
    struct::function_368120a1("scene", "cin_sgen_13_01_fallensoldiers_vign_grab_end");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0xac1ecbf6, Offset: 0x1400
// Size: 0x1b2
function main() {
    level.var_2fd26037.goalradius = 16;
    level.var_2fd26037 colors::disable();
    level thread scene::init("cin_sgen_14_humanlab_3rd_sh005");
    level thread vo();
    level thread function_ab5cee74();
    level thread function_b2ddfb27();
    level thread namespace_d40478f6::function_973b77f9();
    function_6596c28b();
    level flag::wait_till_timeout(40, "fallen_soldiers_hendricks_ready_to_enter_dayroom");
    trigger::wait_or_timeout(5, "fallen_soldiers_encounter_clear_trig");
    level notify(#"hash_aa9b4587");
    level thread function_f7879f6f();
    function_edc1192b(20, "fallen_soldiers_robots_cleared");
    level.var_2fd26037 setgoal(getnode("fallen_soldiers_hendricks_dayroom_enter_node", "targetname"), 1);
    level flag::wait_till("fallen_soldiers_dayroom_started");
    spawner::waittill_ai_group_cleared("fallen_soldiers_extra_robots");
    level.var_2fd26037 waittill(#"goal");
    wait 0.5;
    function_5ed260ac();
    trigger::wait_till("fallen_soldiers_exit_zone_trig");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0x31c8aa60, Offset: 0x15c0
// Size: 0xda
function function_99e352d9() {
    level endon(#"fallen_soldiers_robots_cleared");
    level.var_2fd26037 setgoal(getnode("fallen_soldiers_hendricks_decon_door_exit_node", "targetname"), 1);
    level.var_2fd26037 waittill(#"goal");
    level.var_2fd26037 function_2b5c3469("fallen_soldiers_hendricks_decon_exit_zone_aitrig");
    level.var_2fd26037 ai::set_ignoreme(0);
    level flag::wait_till("fallen_soldiers_lockerroom_second_spawn");
    level.var_2fd26037 function_2b5c3469("fallen_soldiers_hendricks_dayroom_approach_aitrig");
    level flag::set("fallen_soldiers_hendricks_ready_to_enter_dayroom");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0x43bfedec, Offset: 0x16a8
// Size: 0x65
function function_568e0f1b() {
    var_aaf02c35 = getent("fallen_soldiers_left_first_spawn_trig", "targetname");
    var_d07fc618 = getent("fallen_soldiers_right_first_spawn_trig", "targetname");
    var_aaf02c35 endon(#"death");
    var_d07fc618 waittill(#"death");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 2, eflags: 0x0
// Checksum 0xc49679a8, Offset: 0x1718
// Size: 0x16a
function function_2b5c3469(str_key, str_val) {
    if (!isdefined(str_val)) {
        str_val = "targetname";
    }
    self endon(#"death");
    level endon(#"fallen_soldiers_robots_cleared");
    var_68d8f035 = getent(str_key, str_val);
    var_12859611 = getnode(var_68d8f035.target, "targetname");
    var_68d8f035 endon(#"death");
    do {
        var_68d8f035 waittill(#"trigger");
        var_f580cae3 = 0;
        var_64e85e6d = getaispeciesarray("team3", "robot");
        foreach (var_f6c5842 in var_64e85e6d) {
            if (isalive(var_f6c5842) && var_f6c5842 istouching(self)) {
                var_f580cae3++;
            }
        }
        wait 1.5;
    } while (var_f580cae3 > 0);
    self setgoal(var_12859611);
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0xf8c094ec, Offset: 0x1890
// Size: 0x2ca
function function_b2ddfb27() {
    var_f0e94a11 = getent("trig_testing_lab_door", "targetname");
    var_f0e94a11 triggerenable(0);
    level thread namespace_cba4cc55::set_door_state("fallen_soldiers_decon_hallway_door", "close");
    level scene::add_scene_func("cin_sgen_12_01_corvus_vign_secret_entrance_hendricks", &drone_breadcrumb, "init");
    level scene::init("cin_sgen_12_01_corvus_vign_secret_entrance_hendricks");
    level flag::wait_till("player_entered_corvus");
    level flag::wait_till("hendricks_corvus_examination");
    if (isdefined(level.var_aedd8570)) {
        level thread [[ level.var_aedd8570 ]]();
    }
    level scene::add_scene_func("cin_sgen_12_01_corvus_vign_secret_entrance_hendricks", &function_1c39896e, "play");
    level scene::play("cin_sgen_12_01_corvus_vign_secret_entrance_hendricks");
    level thread namespace_d40478f6::function_22982c6e();
    level.var_2fd26037 waittill(#"goal");
    wait 0.5;
    level scene::init("cin_sgen_13_01_fallensoldiers_vign_grab_start");
    trigger::wait_till("fallen_soldiers_enter_decon_trig");
    level thread namespace_cba4cc55::set_door_state("fallen_soldiers_enter_door", "open");
    level notify(#"hash_3b302c78");
    trigger::wait_till("fallen_soldiers_hendricks_grab_start", undefined, undefined, 0);
    level scene::play("cin_sgen_13_01_fallensoldiers_vign_grab_start");
    var_3ab04d1b = getent("decontamination_room_trigger", "targetname");
    var_3ab04d1b namespace_cba4cc55::function_36a6e271(1, array(level.var_2fd26037));
    level notify(#"hash_b0f8d01");
    level thread namespace_cba4cc55::set_door_state("fallen_soldiers_enter_door", "close");
    level notify(#"hash_c74ae0a4");
    wait 1.3;
    scene::add_scene_func("cin_sgen_13_01_fallensoldiers_vign_grab_end", &function_2f485a41);
    level scene::play("cin_sgen_13_01_fallensoldiers_vign_grab_end");
    level flag::set("fallen_soldiers_hendricks_ready");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 1, eflags: 0x0
// Checksum 0x3b904a86, Offset: 0x1b68
// Size: 0x7b
function function_2f485a41(a_ents) {
    foreach (var_6104a93b in a_ents) {
        if (var_6104a93b.targetname == "fallen_soldiers_grab_robot") {
            var_6104a93b thread function_d43d6872();
        }
    }
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0xfc98b6f, Offset: 0x1bf0
// Size: 0x42
function function_d43d6872() {
    self waittill(#"lights_on");
    self clientfield::set("play_cia_robot_rogue_control", 1);
    self waittill(#"hash_4289520f");
    self clientfield::set("play_cia_robot_rogue_control", 0);
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 1, eflags: 0x0
// Checksum 0x6f58441b, Offset: 0x1c40
// Size: 0x8b
function function_1c39896e(a_ents) {
    level waittill(#"hash_8fb37212");
    level flag::set("fallen_soldiers_hendricks_approaching_exit");
    level.var_2fd26037 setgoal(getnode("fallen_soldiers_hendricks_decon_ready_node", "targetname"), 1);
    level thread namespace_cba4cc55::set_door_state("fallen_soldiers_decon_hallway_door", "open");
    level notify(#"hash_b8163f70");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0xba05d5be, Offset: 0x1cd8
// Size: 0x2c2
function function_6596c28b() {
    var_3d011d2a = getentarray("fallen_soldiers_robot_trigger", "script_noteworthy");
    var_dc854c29 = getent("fallen_soldiers_spawner", "targetname");
    var_99abfd05 = getentarray("fallen_soldiers_walkeup_looktrig", "targetname");
    array::thread_all(var_99abfd05, &function_7d5168cb);
    foreach (var_10e4a34a in var_3d011d2a) {
        var_10e4a34a thread function_80a49394(var_dc854c29);
    }
    level thread namespace_cba4cc55::set_door_state("fallen_soldiers_enter_door", "close");
    level flag::wait_till("fallen_soldiers_hendricks_ready");
    level flag::set("fallen_soldiers_robots_wakeup_started");
    playsoundatposition("evt_decon_light_breaker", (828, -1411, -4552));
    exploder::exploder("fallen_soldiers_decon_spray");
    exploder::exploder("lgt_light_deconroom");
    level.var_2fd26037.goalradius = 16;
    level.var_2fd26037 ai::set_ignoreme(1);
    level.var_2fd26037 setgoal(getnode("fallen_soldiers_hendricks_decon_battle_node", "targetname"), 1);
    var_59101dfd = getent("fallen_soldiers_decon_room_wake_trig", "targetname");
    var_59101dfd waittill(#"death");
    function_edc1192b(7, "fallen_soldiers_robots_decon_room_cleared");
    spawn_manager::enable("fallen_soldiers_decon_room_door_rushers_spawnmanager");
    level notify(#"hash_2454d800");
    level thread namespace_cba4cc55::set_door_state("fallen_soldiers_exit_door", "open");
    spawn_manager::wait_till_complete("fallen_soldiers_decon_room_door_rushers_spawnmanager");
    level thread function_99e352d9();
    trigger::wait_till("fallen_soldiers_decon_room_exit_trig");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0x2487639e, Offset: 0x1fa8
// Size: 0x53
function function_5ed260ac() {
    level scene::add_scene_func("cin_sgen_12_01_corvus_vign_dayroom", &function_3dbe13f9, "play");
    level scene::play("cin_sgen_12_01_corvus_vign_dayroom");
    level notify(#"hash_96a30d1b");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 1, eflags: 0x0
// Checksum 0x42c852cd, Offset: 0x2008
// Size: 0x92
function function_3dbe13f9(a_ents) {
    level.var_2fd26037 colors::disable();
    level.var_2fd26037.goalradius = 16;
    level.var_2fd26037 setgoal(getnode("fallen_soldiers_hendricks_hack_door_node", "targetname"), 1);
    level.var_2fd26037 waittill(#"goal");
    level.var_2fd26037 clearforcedgoal();
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0xf53f7654, Offset: 0x20a8
// Size: 0x21a
function vo() {
    util::waittill_any("player_saw_drone", "hendricks_approaching_drone");
    level thread namespace_d40478f6::function_55f6ee71();
    level dialog::function_13b3b16a("plyr_what_the_hell_happen_0");
    level notify(#"hash_d840edf1");
    level thread namespace_d40478f6::function_973b77f9();
    objectives::complete("cp_level_sgen_find_recon_drone");
    level waittill(#"hash_3b302c78");
    level dialog::function_13b3b16a("plyr_what_s_going_on_here_0", 1.5);
    level waittill(#"hash_c74ae0a4");
    playsoundatposition("evt_decon_alarm", (796, -1406, -4604));
    level thread namespace_d40478f6::function_3eb3d06();
    level waittill(#"hash_2b998700");
    level.var_2fd26037 dialog::say("hend_what_the_hell_0");
    level battlechatter::function_d9f49fba(1);
    level waittill(#"hash_2454d800");
    objectives::set("cp_level_sgen_goto_signal_source");
    level waittill(#"hash_2cbed988");
    level flag::wait_till("fallen_soldiers_robots_cleared");
    level battlechatter::function_d9f49fba(0);
    level thread namespace_d40478f6::function_973b77f9();
    level thread function_c1c96249();
    level.var_2fd26037 dialog::say("hend_area_clear_stay_ale_0", 1.5);
    level dialog::function_13b3b16a("plyr_kane_you_ever_see_a_0", 0.2);
    level dialog::remote("kane_i_ve_never_seen_any_0", 0.2);
    level thread function_fe403015();
    level flag::set("kane_robots_convo_done");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0xa90bfa5d, Offset: 0x22d0
// Size: 0x5a
function function_fe403015() {
    trigger::wait_till("fallen_soldiers_enter_reception_looktrig");
    level thread namespace_d40478f6::function_973b77f9();
    level flag::wait_till("kane_robots_convo_done");
    level dialog::remote("kane_according_to_the_gps_0");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0xeac01970, Offset: 0x2338
// Size: 0xaf
function function_c1c96249() {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    level endon(#"hash_89d9c0f");
    level endon(#"hash_c1907e5d");
    var_337b3942 = getent("dayroom_salim_speaker", "targetname");
    for (i = 1; i < 6; i++) {
        var_2050b70 = "vox_sgen_visual_extracts_00" + i + "_salm";
        var_337b3942 playsoundwithnotify(var_2050b70, "sounddone");
        var_337b3942 waittill(#"sounddone");
        wait 5;
    }
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0x5d61762c, Offset: 0x23f0
// Size: 0xd3
function function_68f0b726() {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    var_277885f5 = getentarray("trig_salim_journal_use", "targetname");
    level.var_38cfe33a = [];
    level.var_d0b26d28 = 0;
    foreach (trigger in var_277885f5) {
        level.var_38cfe33a[trigger.script_int] = util::function_14518e76(trigger, %cp_prompt_dni_sgen_access_journal, %CP_MI_SING_SGEN_ACCESS_JOURNAL, &function_a43abada);
    }
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0x440fa36a, Offset: 0x24d0
// Size: 0x32
function function_88a16751() {
    self stopsounds();
    wait 0.1;
    self playsound("evt_salim_speaker_destroy");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0x7f2aa840, Offset: 0x2510
// Size: 0x1b2
function function_a43abada() {
    var_6a8436fc = self getlinkedent();
    var_c50aa484 = spawn("script_origin", self.origin);
    level.var_d0b26d28++;
    level notify(#"hash_c1907e5d");
    var_337b3942 = getent("dayroom_salim_speaker", "targetname");
    var_337b3942 thread function_88a16751();
    switch (level.var_d0b26d28) {
    case 1:
        var_55df1164 = "vox_sgen_medical_logs_001_salm";
        break;
    case 2:
        var_55df1164 = "vox_sgen_medical_logs_002_salm";
        break;
    case 3:
        var_55df1164 = "vox_sgen_medical_logs_003_salm";
        break;
    case 4:
        var_55df1164 = "vox_sgen_medical_logs_004_salm";
        break;
    case 5:
        var_55df1164 = "vox_sgen_medical_logs_005_salm";
        break;
    case 6:
        var_55df1164 = "vox_sgen_medical_logs_006_salm";
        break;
    case 7:
        var_55df1164 = "vox_sgen_medical_logs_007_salm";
        break;
    }
    if (isdefined(level.var_79b63714)) {
        level.var_79b63714 stopsounds();
    }
    var_c50aa484 playsound(var_55df1164);
    level.var_79b63714 = var_c50aa484;
    if (level.var_d0b26d28 == 7) {
        namespace_99202726::function_c75f9c25();
    }
    self gameobjects::destroy_object(1);
    self delete();
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 2, eflags: 0x0
// Checksum 0x1393331c, Offset: 0x26d0
// Size: 0x4a
function function_edc1192b(n_timeout, str_flag) {
    level thread function_516039af(str_flag);
    level flag::wait_till_timeout(n_timeout, str_flag);
    level flag::set(str_flag);
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0x673b995f, Offset: 0x2728
// Size: 0xa5
function function_7d5168cb() {
    self endon(#"death");
    level endon(#"hash_aa9b4587");
    var_c9cf27c4 = struct::get(self.target, "targetname");
    var_7f788a1 = getent(var_c9cf27c4.target, "targetname");
    var_7f788a1 endon(#"death");
    while (true) {
        self waittill(#"trigger");
        if (isdefined(var_7f788a1)) {
            var_7f788a1 trigger::use();
            continue;
        }
        self delete();
    }
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 1, eflags: 0x0
// Checksum 0x9fa6e811, Offset: 0x27d8
// Size: 0x16a
function function_80a49394(var_dc854c29) {
    self endon(#"death");
    level endon(#"hash_aa9b4587");
    assert(isdefined(self.target), "<dev string:x28>" + self.origin);
    var_64e85e6d = [];
    var_b6944555 = struct::get_array(self.target);
    foreach (n_count, s_scriptbundle in var_b6944555) {
        var_64e85e6d[n_count] = spawner::simple_spawn_single(var_dc854c29);
        s_scriptbundle thread scene::init(var_64e85e6d[n_count]);
    }
    level flag::wait_till("fallen_soldiers_robots_wakeup_started");
    foreach (n_count, s_scriptbundle in var_b6944555) {
        if (isalive(var_64e85e6d[n_count])) {
            self function_ae64ae2(var_64e85e6d[n_count], s_scriptbundle);
        }
    }
    self delete();
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 2, eflags: 0x0
// Checksum 0x841e891, Offset: 0x2950
// Size: 0x93
function function_ae64ae2(var_f6c5842, s_scriptbundle) {
    level endon(#"hash_aa9b4587");
    var_f6c5842 endon(#"death");
    self endon(#"death");
    self util::waittill_any_ents(var_f6c5842, "damage", self, "trigger");
    wait randomfloatrange(0.1, 0.25);
    var_f6c5842 function_89ba9422();
    s_scriptbundle scene::play(var_f6c5842);
    level notify(#"hash_2cbed988");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0x159c104b, Offset: 0x29f0
// Size: 0xa2
function function_31e3341a() {
    var_ec24660 = namespace_cba4cc55::function_411dc61b(1.3, -0.25);
    var_39dd968a = namespace_cba4cc55::function_411dc61b(2.4, -0.51);
    if (var_ec24660 < 0) {
        var_ec24660 = 0;
    }
    if (var_39dd968a <= 0) {
        var_39dd968a = 0.2;
    }
    wait randomfloatrange(var_ec24660, var_39dd968a);
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0xd1579469, Offset: 0x2aa0
// Size: 0x4a
function function_fbd51610() {
    self.team = "team3";
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self ai::set_behavior_attribute("robot_lights", 2);
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0x8dedb7f7, Offset: 0x2af8
// Size: 0xe2
function function_bebe324d() {
    self endon(#"death");
    self.team = "team3";
    self.var_164093db = 1;
    n_level = 2;
    if (isdefined(self.script_int)) {
        n_level = self.script_int;
    }
    if (isdefined(self.script_string)) {
        if (self.script_string == "crawler") {
            self.crawlerlifetime = gettime() + randomintrange(20000, 30000);
            self ai::set_behavior_attribute("force_crawler", "remove_legs");
            self ai::set_behavior_attribute("rogue_control", "forced_level_1");
        }
        return;
    }
    self ai::set_behavior_attribute("rogue_control", "forced_level_" + n_level);
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0x8cc5b1ad, Offset: 0x2be8
// Size: 0x7a
function function_89ba9422() {
    self.var_164093db = 1;
    self playsound("evt_robot_ambush_arise");
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
    self ai::set_behavior_attribute("robot_lights", 0);
    self ai::set_behavior_attribute("rogue_control", "forced_level_2");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 1, eflags: 0x0
// Checksum 0x42c0d99f, Offset: 0x2c70
// Size: 0x5a
function function_516039af(str_flag) {
    level endon(str_flag);
    var_64e85e6d = getaispeciesarray("team3", "robot");
    var_64e85e6d function_15debd57(str_flag);
    level flag::set(str_flag);
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 1, eflags: 0x0
// Checksum 0x2f782ba, Offset: 0x2cd8
// Size: 0x91
function function_15debd57(str_ender) {
    level endon(str_ender);
    foreach (var_f6c5842 in self) {
        if (isdefined(var_f6c5842.var_164093db) && isalive(var_f6c5842) && var_f6c5842.var_164093db) {
            var_f6c5842 waittill(#"death");
        }
    }
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0x97f5c61e, Offset: 0x2d78
// Size: 0x32
function function_f7879f6f() {
    trigger::wait_till("fallen_soldiers_encounter_clear_trig", undefined, undefined, 0);
    spawn_manager::kill("fallen_soldiers_mid_encounter_group");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 0, eflags: 0x0
// Checksum 0x9465b76, Offset: 0x2db8
// Size: 0x9a
function function_ab5cee74() {
    level waittill(#"hash_b8163f70");
    objectives::set("cp_level_sgen_goto_signal_source");
    level thread objectives::breadcrumb("fallen_soldiers_decon_breadcrumb");
    level waittill(#"hash_b0f8d01");
    objectives::complete("cp_waypoint_breadcrumb");
    level waittill(#"hash_2454d800");
    level thread objectives::breadcrumb("fallen_soldiers_decon_room_breadcrumb_start");
    level waittill(#"hash_96a30d1b");
    level thread objectives::breadcrumb("fallen_soldiers_end_breadcrumb_trig");
}

// Namespace cp_mi_sing_sgen_fallen_soldiers
// Params 1, eflags: 0x0
// Checksum 0xc0ef62d8, Offset: 0x2e60
// Size: 0x62
function drone_breadcrumb(a_ents) {
    objectives::set("cp_waypoint_breadcrumb", a_ents["mapping_drone"]);
    trigger::wait_till("fallen_soldiers_drone_intro_looktrig");
    objectives::complete("cp_waypoint_breadcrumb", a_ents["mapping_drone"]);
}

