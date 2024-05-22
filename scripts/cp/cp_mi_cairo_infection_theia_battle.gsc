#using scripts/cp/cp_mi_cairo_infection_sound;
#using scripts/cp/_siegebot_theia;
#using scripts/cp/cp_mi_cairo_infection_sim_reality_starts;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/gametypes/coop;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/cp/_debug;
#using scripts/shared/math_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/codescripts/struct;

#namespace namespace_c3900363;

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xb7f95371, Offset: 0x1340
// Size: 0x18e
function main() {
    function_7b244c18();
    level flag::init("player_exiting_downed_vtol");
    level flag::init("vtol_intro_complete");
    level flag::init("sarah_battle_friendly_spawned");
    level flag::init("sarah_defeated");
    level flag::init("sarah_interface_started");
    level flag::init("sarah_interface_done");
    level.var_b9a15c1e = getentarray("inf_wrecked_vtol", "targetname");
    level.var_377e3a8 = getent("sarah_bash2_clip", "targetname");
    if (isdefined(level.var_377e3a8)) {
        level.var_377e3a8 notsolid();
        level.var_377e3a8 connectpaths();
    }
    init_clientfields();
    level._effect["crashed_vtol_exp_fx"] = "explosions/fx_exp_quadtank_death_sm";
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xac6c0ba8, Offset: 0x14d8
// Size: 0xec
function init_clientfields() {
    n_clientbits = getminbitcountfornum(8);
    clientfield::register("world", "building_destruction_callback", 1, n_clientbits, "int");
    clientfield::register("world", "building_end_callback", 1, 1, "int");
    clientfield::register("world", "vtol_fog_bank", 1, 1, "int");
    clientfield::register("scriptmover", "sarah_tac_mode_disable", 1, 1, "int");
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x7f618689, Offset: 0x15d0
// Size: 0x11c
function function_7b244c18() {
    scene::add_scene_func("cin_inf_03_01_interface_1st_dni_02", &function_3a66ee4d);
    scene::add_scene_func("cin_inf_01_01_vtolarrival_1st_encounter_v2", &function_c087a5cf);
    scene::add_scene_func("cin_inf_01_01_vtolarrival_1st_encounter_v2", &function_1bb0323c);
    scene::add_scene_func("cin_inf_01_01_vtolarrival_1st_encounter_v2", &function_45d8cfab);
    scene::add_scene_func("cin_inf_01_01_vtolarrival_1st_encounter_v2", &function_56c9a7f3);
    scene::add_scene_func("cin_inf_02_01_vign_interface_siegebot_bash", &function_68861104);
    scene::add_scene_func("cin_inf_02_01_vign_interface_siegebot_bash_2", &function_24b31974);
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x55883963, Offset: 0x16f8
// Size: 0x28c
function function_b127971() {
    var_2aa82b86 = getent("vtol_intro", "targetname");
    var_2aa82b86 showpart("tag_console_center_screen_animate_d0");
    var_2aa82b86 showpart("tag_console_left_screen_animate_d0");
    var_2aa82b86 showpart("tag_console_right_screen_animate_d0");
    var_2aa82b86 attach("veh_t7_mil_vtol_egypt_cabin_details_attch", "tag_body_animate");
    var_2aa82b86 attach("veh_t7_mil_vtol_egypt_cabin_details_attch_screenglows", "tag_body_animate");
    var_b2c5be8 = getent("vtol_nose", "targetname");
    var_b2c5be8 enablelinkto();
    var_b2c5be8 linkto(var_2aa82b86);
    var_b2c5be8 thread function_d147e0e1();
    var_5c4b60ce = getentarray("light_vtol_flyin", "targetname");
    foreach (light in var_5c4b60ce) {
        light linkto(var_2aa82b86);
        light thread function_5a717a52();
    }
    var_785aaccf = getent("light_vtol_flyin_spotlight", "targetname");
    if (isdefined(var_785aaccf)) {
        var_785aaccf linkto(var_2aa82b86, "tag_winch");
        var_785aaccf thread function_5a717a52();
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x597b6fc8, Offset: 0x1990
// Size: 0x44
function function_5a717a52() {
    level flag::wait_till("player_exiting_downed_vtol");
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x89ca2f8e, Offset: 0x19e0
// Size: 0x24c
function function_d147e0e1() {
    num_parts = 5;
    self hidepart("tag_glass_d1_animate");
    for (i = 1; i <= num_parts; i++) {
        self hidepart("tag_glass" + i + "_d1_animate");
    }
    self hidepart("tag_glass_d2_animate");
    for (i = 1; i <= num_parts; i++) {
        self hidepart("tag_glass" + i + "_d2_animate");
    }
    self hidepart("tag_glass4_d3_animate");
    level waittill(#"hash_3692720b");
    self attach("veh_t7_mil_vtol_egypt_screens_d1", "tag_nose_animate");
    self hidepart("tag_glass_animate");
    for (i = 1; i <= num_parts; i++) {
        self hidepart("tag_glass" + i + "_animate");
    }
    self showpart("tag_glass_d2_animate");
    for (i = 1; i <= num_parts; i++) {
        self showpart("tag_glass" + i + "_d2_animate");
    }
    level flag::wait_till("player_exiting_downed_vtol");
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x8f23112e, Offset: 0x1c38
// Size: 0xa8
function function_674469e5() {
    while (true) {
        level waittill(#"hash_380ae1f4");
        if (randomint(100) > 60) {
            level.var_2fd26037 dialog::say("hend_javelin_missiles_inc_0", 1);
            continue;
        }
        if (randomint(100) < 40) {
            level.var_2fd26037 dialog::say("hend_javelin_s_inbound_0", 1);
        }
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xc5c7589d, Offset: 0x1ce8
// Size: 0x34
function function_65daad32() {
    if (!level.var_a2488e6f) {
        level.var_2fd26037 dialog::say("hend_explosive_spikes_inc_0", 1);
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xc46ddc74, Offset: 0x1d28
// Size: 0x6c
function function_dd8a78c6() {
    level.var_42189297 endon(#"death");
    level waittill(#"hash_9f92e1e");
    level.var_42189297 thread function_179a0141();
    level.var_42189297 thread function_d47c7e44();
    level thread function_674469e5();
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xcace8cbf, Offset: 0x1da0
// Size: 0x1ea
function function_179a0141() {
    self endon(#"death");
    var_2c8bd13b = 0;
    while (true) {
        while (self vehicle_ai::get_current_state() == "groundCombat") {
            wait(2);
        }
        while (isdefined(level.var_a2488e6f) && level.var_a2488e6f) {
            wait(0.1);
        }
        level.var_a2488e6f = 1;
        str_state = self vehicle_ai::get_current_state();
        if (str_state == "combat" || str_state == "prepareDeath") {
            var_2c8bd13b++;
            if (var_2c8bd13b == 1) {
                level.var_2fd26037 dialog::say("hend_eyes_up_hall_s_take_0", 2);
            } else if (var_2c8bd13b == 2) {
            }
            while (self vehicle_ai::get_current_state() == "combat" || self vehicle_ai::get_current_state() == "pain" || self vehicle_ai::get_current_state() == "prepareDeath") {
                wait(2);
            }
        } else if (str_state == "jumpUp" || str_state == "jumpDown") {
            level.var_2fd26037 dialog::say("hend_she_s_on_the_move_0", 1);
        }
        level.var_a2488e6f = 0;
        wait(1);
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x8ce46970, Offset: 0x1f98
// Size: 0x260
function function_d47c7e44() {
    self endon(#"death");
    self thread function_7ef9b3ab();
    n_start_health = self.health;
    self thread function_3d8d9969();
    while (self.health > n_start_health * 0.7) {
        wait(0.1);
    }
    while (isdefined(level.var_a2488e6f) && level.var_a2488e6f) {
        wait(0.1);
    }
    level.var_a2488e6f = 1;
    level dialog::remote("kane_siege_bot_operating_0", 1);
    level.var_2fd26037 dialog::say("hend_we_gotta_get_through_0", 1);
    level.var_a2488e6f = 0;
    while (self.health > n_start_health * 0.4) {
        wait(0.1);
    }
    while (isdefined(level.var_a2488e6f) && level.var_a2488e6f) {
        wait(0.1);
    }
    level.var_a2488e6f = 1;
    level dialog::remote("kane_siege_bot_now_operat_0", 1);
    level.var_2fd26037 dialog::say("hend_her_shields_won_t_ho_0", 1);
    level.var_a2488e6f = 0;
    while (self.health > n_start_health * 0.1) {
        wait(0.1);
    }
    while (isdefined(level.var_a2488e6f) && level.var_a2488e6f) {
        wait(0.1);
    }
    level.var_a2488e6f = 1;
    level dialog::remote("kane_siege_bot_energy_dow_0", 1);
    level dialog::remote("kane_she_s_our_only_lead_0", 1);
    level.var_a2488e6f = 0;
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x3d4a0df8, Offset: 0x2200
// Size: 0x20
function function_7ef9b3ab() {
    self waittill(#"death");
    wait(3);
    level.var_a2488e6f = 0;
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xc14d54bf, Offset: 0x2228
// Size: 0x70
function function_3d8d9969() {
    self waittill(#"death");
    while (isdefined(level.var_a2488e6f) && level.var_a2488e6f) {
        wait(0.1);
    }
    level.var_a2488e6f = 1;
    level dialog::remote("kane_she_s_down_she_s_do_0", 1);
    level.var_a2488e6f = 0;
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0xa9bf52bd, Offset: 0x22a0
// Size: 0x144
function function_6e5389(a_ents) {
    level.var_42189297 endon(#"death");
    level flag::wait_till("sarah_battle_friendly_spawned");
    battlechatter::function_d9f49fba(0);
    level.var_9db406db dialog::say("khal_mech_suit_hostile_h_0");
    level dialog::remote("kane_looks_like_sarah_hal_0", 0.5);
    level dialog::function_13b3b16a("plyr_you_got_a_fix_on_tay_0", 2);
    level dialog::remote("kane_negative_0", 0.7);
    level dialog::function_13b3b16a("plyr_then_the_only_way_to_0", 1);
    level notify(#"hash_9f92e1e");
    level.var_9e921465 = 1;
    battlechatter::function_d9f49fba(1);
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x15330a3b, Offset: 0x23f0
// Size: 0xcc
function function_2ffaa595() {
    while (isdefined(level.var_a2488e6f) && level.var_a2488e6f) {
        wait(0.05);
    }
    level dialog::remote("kane_hurry_you_have_to_0", 0.5);
    function_b38700c3("kane_we_need_a_full_extra_0", 1);
    function_b38700c3("kane_i_know_this_isn_t_ea_0", 7);
    function_b38700c3("kane_no_sign_of_taylor_an_0", 8);
    function_b38700c3("kane_her_systems_are_fail_0", 5);
}

// Namespace namespace_c3900363
// Params 2, eflags: 0x0
// Checksum 0x148515c6, Offset: 0x24c8
// Size: 0x84
function function_b38700c3(str_vo_alias, n_delay) {
    if (!isdefined(n_delay)) {
        n_delay = 0;
    }
    if (!level flag::get("sarah_interface_started")) {
        wait(n_delay);
        if (!level flag::get("sarah_interface_started")) {
            level dialog::remote(str_vo_alias);
        }
    }
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0xcd9d7d21, Offset: 0x2558
// Size: 0x10c
function function_3a66ee4d(a_ents) {
    if (!scene::function_b1f75ee9()) {
        level waittill(#"hash_4ad123af");
        foreach (player in level.activeplayers) {
            player cybercom::function_f8669cbf(1);
            player clientfield::increment_to_player("hack_dni_fx");
        }
        level.players[0] waittill(#"hash_814598ff");
        level thread namespace_36cbf523::function_eaf9c027("cp_infection_fs_interface");
    }
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0x291ca292, Offset: 0x2670
// Size: 0x34
function function_45d8cfab(a_ents) {
    level waittill(#"hash_45d8cfab");
    level scene::init("cin_inf_02_01_vign_interface_siegebot_bash");
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0x51f52440, Offset: 0x26b0
// Size: 0x6c
function function_56c9a7f3(a_ents) {
    if (!scene::function_b1f75ee9()) {
        level waittill(#"hash_9903f6a6");
        level util::delay(1, undefined, &function_f508734c);
        return;
    }
    level thread function_f508734c();
}

// Namespace namespace_c3900363
// Params 2, eflags: 0x0
// Checksum 0x8d1f352c, Offset: 0x2728
// Size: 0x394
function function_e25e4f9(str_objective, var_74cd64bc) {
    /#
        iprintlnbold("veh_t7_mil_vtol_egypt_screens_d1");
    #/
    load::function_73adcefc();
    objectives::set("cp_level_infection_find_dr");
    level function_b127971();
    function_516efb66();
    level.var_2fd26037 = util::function_740f8516("hendricks");
    level scene::init("cin_inf_01_01_vtolarrival_1st_encounter_wires");
    level scene::init("cin_inf_01_01_vtolarrival_1st_encounter_v2");
    function_48e3f00e();
    level clientfield::set("vtol_fog_bank", 1);
    level thread function_69d9e05d();
    level thread function_4dd97558();
    level thread function_3513c0b9();
    level util::function_d8eaed3d(1);
    load::function_c32ba481();
    util::function_46d3a558(%CP_MI_CAIRO_INFECTION_INTRO_LINE_1_FULL, %CP_MI_CAIRO_INFECTION_INTRO_LINE_1_SHORT, %CP_MI_CAIRO_INFECTION_INTRO_LINE_2_FULL, %CP_MI_CAIRO_INFECTION_INTRO_LINE_2_SHORT, %CP_MI_CAIRO_INFECTION_INTRO_LINE_3_FULL, %CP_MI_CAIRO_INFECTION_INTRO_LINE_3_SHORT, %CP_MI_CAIRO_INFECTION_INTRO_LINE_4_FULL, %CP_MI_CAIRO_INFECTION_INTRO_LINE_4_SHORT);
    if (isdefined(level.var_9e37b96)) {
        level thread [[ level.var_9e37b96 ]]();
    }
    level thread namespace_eccdd5d1::play_intro();
    level scene::add_scene_func("cin_inf_01_01_vtolarrival_1st_encounter_v2", &function_8b952c00);
    level scene::add_scene_func("cin_inf_01_01_vtolarrival_1st_encounter_v2", &function_3cb73539, "skip_completed");
    level thread scene::play("cin_inf_01_01_vtolarrival_1st_encounter_wires");
    level thread scene::play("cin_inf_01_01_vtolarrival_1st_encounter_sarah_cockpit_loop");
    level thread scene::play("cin_inf_01_01_vtolarrival_1st_encounter_v2");
    level flag::wait_till("player_exiting_downed_vtol");
    level clientfield::set("gameplay_started", 1);
    function_99e62b85();
    level scene::stop("cin_inf_01_01_vtolarrival_1st_encounter_wires");
    objectives::complete("cp_level_infection_find_dr");
    scene::function_f69c7a83();
    util::wait_network_frame();
    level thread util::clear_streamer_hint();
    skipto::function_be8adfb8("vtol_arrival");
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0xc214a475, Offset: 0x2ac8
// Size: 0x4c
function function_8b952c00(a_ents) {
    level waittill(#"teleport_players");
    level flag::set("player_exiting_downed_vtol");
    util::function_93831e79("vtol_arrival_coop_teleport");
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0xb2f02b5f, Offset: 0x2b20
// Size: 0x46a
function function_3cb73539(a_ents) {
    var_cca89d10 = array("intro_friendly_vtol", "vtol_intro_veh1", "vtol_intro_veh3", "intro_friendly_vtol_vh");
    foreach (str_vehicle in var_cca89d10) {
        a_vehicles = getentarray(str_vehicle, "targetname");
        foreach (var_91e835c9 in a_vehicles) {
            if (isdefined(var_91e835c9)) {
                var_91e835c9.delete_on_death = 1;
                var_91e835c9 notify(#"death");
                if (!isalive(var_91e835c9)) {
                    var_91e835c9 delete();
                }
            }
        }
    }
    var_8da4fac5 = getentarray("vtol_intro_veh1", "targetname");
    var_b3a7752e = getentarray("vtol_intro_veh2", "targetname");
    var_d9a9ef97 = getentarray("vtol_intro_veh3", "targetname");
    foreach (var_a66cc9c4 in var_8da4fac5) {
        var_a66cc9c4.delete_on_death = 1;
        var_a66cc9c4 notify(#"death");
        if (!isalive(var_a66cc9c4)) {
            var_a66cc9c4 delete();
        }
    }
    foreach (var_a66cc9c4 in var_b3a7752e) {
        var_a66cc9c4.delete_on_death = 1;
        var_a66cc9c4 notify(#"death");
        if (!isalive(var_a66cc9c4)) {
            var_a66cc9c4 delete();
        }
    }
    foreach (var_a66cc9c4 in var_d9a9ef97) {
        var_a66cc9c4.delete_on_death = 1;
        var_a66cc9c4 notify(#"death");
        if (!isalive(var_a66cc9c4)) {
            var_a66cc9c4 delete();
        }
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x70e4d20e, Offset: 0x2f98
// Size: 0x382
function function_69d9e05d() {
    foreach (e_piece in level.var_b9a15c1e) {
        e_piece hide();
    }
    var_5ff14e42 = getentarray("sarah_battle_launcher", "targetname");
    foreach (var_7e2968b3 in var_5ff14e42) {
        var_7e2968b3 ghost();
    }
    var_f0770462 = getentarray("sarah_battle_destructible", "script_noteworthy");
    foreach (e_destructible in var_f0770462) {
        e_destructible ghost();
    }
    var_da5600e3 = getentarray("sarah_battle_ammo", "targetname");
    foreach (var_4abed703 in var_da5600e3) {
        if (isdefined(var_4abed703.gameobject)) {
            var_4abed703.gameobject gameobjects::set_model_visibility(0);
        }
    }
    level waittill(#"hash_9903f6a6");
    var_5865e335 = spawner::get_ai_group_ai("intro_friendly");
    foreach (var_bba6ddda in var_5865e335) {
        if (isdefined(var_bba6ddda)) {
            var_bba6ddda delete();
        }
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x6652ad1b, Offset: 0x3328
// Size: 0x324
function function_4dd97558() {
    level waittill(#"hash_29e5a5dd");
    foreach (e_piece in level.var_b9a15c1e) {
        e_piece show();
    }
    function_a081beb1();
    var_5ff14e42 = getentarray("sarah_battle_launcher", "targetname");
    foreach (var_7e2968b3 in var_5ff14e42) {
        var_7e2968b3 show();
        util::wait_network_frame();
    }
    var_f0770462 = getentarray("sarah_battle_destructible", "script_noteworthy");
    foreach (e_destructible in var_f0770462) {
        e_destructible show();
        util::wait_network_frame();
    }
    var_da5600e3 = getentarray("sarah_battle_ammo", "targetname");
    foreach (var_4abed703 in var_da5600e3) {
        if (isdefined(var_4abed703.gameobject)) {
            var_4abed703.gameobject gameobjects::set_model_visibility(1);
        }
        util::wait_network_frame();
    }
    exploder::exploder("sarah_battle_fire");
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0x3f8fab0e, Offset: 0x3658
// Size: 0x8c
function function_1bb0323c(a_ents) {
    if (!scene::function_b1f75ee9()) {
        if (level.var_c0e97bd == "vtol_arrival") {
            a_ents["sarah_siegebot"] vehicle::lights_off();
            a_ents["sarah_siegebot"] waittill(#"turn_on_lights");
            a_ents["sarah_siegebot"] vehicle::lights_on();
        }
    }
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0x39d1fa54, Offset: 0x36f0
// Size: 0x74
function function_c087a5cf(a_ents) {
    var_edc6e0e1 = a_ents["vtol_intro"];
    if (level.var_c0e97bd == "vtol_arrival") {
        level waittill(#"hash_9903f6a6");
    }
    var_edc6e0e1 hidepart("tag_wing_left_animate", var_edc6e0e1.model, 1);
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xaa2e82, Offset: 0x3770
// Size: 0x7c
function function_99e62b85() {
    var_f2fdc837 = struct::get("s_sarah_battle_hendricks_start_pos");
    level.var_2fd26037 = util::function_740f8516("hendricks");
    level.var_2fd26037 forceteleport(var_f2fdc837.origin, var_f2fdc837.angles);
}

// Namespace namespace_c3900363
// Params 2, eflags: 0x0
// Checksum 0x1a6cd674, Offset: 0x37f8
// Size: 0x3fc
function function_8721a9e0(str_objective, var_74cd64bc) {
    /#
        iprintlnbold("kane_siege_bot_energy_dow_0");
    #/
    if (!var_74cd64bc) {
        array::thread_all(level.players, &namespace_36cbf523::function_e905c73c);
    }
    level.var_9e921465 = 0;
    level.var_a2488e6f = 0;
    level.var_2fd26037 = util::function_740f8516("hendricks");
    level.overrideplayerdamage = &function_6255dfdc;
    if (var_74cd64bc) {
        load::function_73adcefc();
        exploder::exploder("sarah_battle_fire");
        function_48e3f00e();
        level thread function_8f97d54e(1);
        function_516efb66(var_74cd64bc);
        level thread scene::init("cin_inf_02_01_vign_interface_siegebot_bash");
        level thread scene::init("cin_inf_01_01_vtolarrival_1st_encounter_v2");
        level flag::set("vtol_intro_complete");
        level thread function_3513c0b9();
        load::function_a2995f22();
        level thread scene::skipto_end("cin_inf_01_01_vtolarrival_1st_encounter_v2", undefined, undefined, 0.85, 1);
        level waittill(#"hash_29e5a5dd");
        level thread function_f508734c();
        level flag::wait_till("player_exiting_downed_vtol");
        util::function_93831e79("vtol_arrival_coop_teleport");
        function_99e62b85();
    }
    level thread namespace_eccdd5d1::function_97020766();
    array::thread_all(level.activeplayers, &coop::function_e9f7384d);
    exploder::exploder("sarah_battle_vtol_crash_fire");
    level.var_42189297 ai::set_ignoreme(0);
    level thread function_90de550e();
    level thread function_6e5389();
    level thread function_dd8a78c6();
    level thread function_a6425c73();
    function_96914e16();
    objectives::set("cp_level_infection_defeat_sarah", level.var_42189297);
    for (i = 0; i < level.players.size; i++) {
        level.players[i] disableinvulnerability();
        level.players[i] namespace_f25bd8c8::function_ad15914d();
    }
    level flag::wait_till("sarah_battle_friendly_spawned");
    level.var_2fd26037 thread function_a2d6949a();
    level.var_9db406db thread function_a2d6949a();
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0x3f5772aa, Offset: 0x3c00
// Size: 0x30c
function function_516efb66(var_6e2f783e) {
    if (!isdefined(var_6e2f783e)) {
        var_6e2f783e = 0;
    }
    level.var_42189297 = spawner::simple_spawn_single("sarah_boss");
    level.var_42189297 ai::set_ignoreall(1);
    level.var_42189297 ai::set_ignoreme(1);
    level.var_42189297.targetname = "sarah_siegebot";
    level.var_42189297 vehicle_ai::start_scripted();
    var_729f9335 = level.var_42189297 gettagorigin("tag_driver");
    var_febde835 = level.var_42189297 gettagangles("tag_driver");
    level.var_156d60f = util::spawn_model("c_hro_sarah_base", var_729f9335, var_febde835);
    level.var_156d60f sethighdetail(0);
    level.var_156d60f.targetname = "sarah_driver";
    level.var_156d60f clientfield::set("sarah_tac_mode_disable", 1);
    if (var_6e2f783e) {
        level.var_156d60f function_76887c27();
    }
    createthreatbiasgroup("sarah_battle_seigebot");
    createthreatbiasgroup("players");
    setthreatbias("players", "sarah_battle_seigebot", 1000);
    level thread function_f5fcb226();
    callback::on_spawned(&on_player_spawn);
    level.var_42189297 setthreatbiasgroup("sarah_battle_seigebot");
    foreach (player in level.players) {
        player setthreatbiasgroup("players");
        player.var_47b86c9b = gettime();
    }
    function_70662d17();
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xba1b36a0, Offset: 0x3f18
// Size: 0x74
function function_70662d17() {
    if (level.players.size <= 1) {
        threatbias = 900;
    } else {
        threatbias = 1000 + 300 * level.players.size - 1;
    }
    setthreatbias("players", "sarah_battle_seigebot", threatbias);
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x9dfbc2b, Offset: 0x3f98
// Size: 0x44
function on_player_spawn() {
    self setthreatbiasgroup("players");
    self.var_47b86c9b = gettime();
    function_70662d17();
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x5116a90f, Offset: 0x3fe8
// Size: 0x4c
function function_f5fcb226() {
    level.var_42189297 endon(#"death");
    clone = level waittill(#"clonedentity");
    clone setthreatbiasgroup("players");
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xb2ce1887, Offset: 0x4040
// Size: 0x330
function function_24cf26d5() {
    level.var_42189297 endon(#"death");
    var_cda8dd73 = [];
    array::add(var_cda8dd73, level.var_2fd26037, 0);
    array::add(var_cda8dd73, level.var_9db406db, 0);
    while (true) {
        target_origin = level waittill(#"hash_879719b9");
        var_a4a6d439 = arraygetclosest(target_origin, var_cda8dd73);
        if (level.var_9e921465) {
            level thread function_65daad32();
        }
        var_974cc07 = function_9c1377d2(target_origin);
        if (var_a4a6d439 == level.var_2fd26037) {
            team = "team_hendricks";
        } else {
            team = "team_khalil";
        }
        var_3ced446f = getentarray(team, "script_noteworthy");
        foreach (ai in var_3ced446f) {
            ai.var_4cb70d71 = ai.goalradius;
            ai.goalradius = 512;
        }
        var_a4a6d439 ai::set_ignoreall(1);
        var_a4a6d439 ai::force_goal(var_974cc07, 32);
        var_a4a6d439 waittill(#"goal");
        var_a4a6d439 clearforcedgoal();
        var_a4a6d439 ai::set_ignoreall(0);
        var_3ced446f = getentarray(team, "script_noteworthy");
        foreach (ai in var_3ced446f) {
            if (isdefined(ai.var_4cb70d71)) {
                ai.goalradius = ai.var_4cb70d71;
                ai.var_4cb70d71 = undefined;
            }
        }
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xbc4867b, Offset: 0x4378
// Size: 0x84
function function_3513c0b9() {
    var_10364988 = getentarray("building_trigs", "targetname");
    var_10364988 array::thread_all(var_10364988, &function_19bda85d);
    if (level.var_c0e97bd == "vtol_arrival") {
        level thread function_ef7f1d9f();
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x64a5fc4e, Offset: 0x4408
// Size: 0x180
function function_19bda85d() {
    self.var_10f44b5 = 0;
    self.var_e848e1ba = 1;
    if (isdefined(self.script_int)) {
        self.var_e848e1ba = self.script_int;
    }
    level.var_42189297 endon(#"death");
    level flag::wait_till("vtol_intro_complete");
    while (true) {
        who = self waittill(#"trigger");
        if (who == level.var_42189297) {
            if (self.script_noteworthy === "building_b" && self.var_10f44b5 == 0) {
                level notify(#"hash_f5d02307");
                level.var_42189297.var_a92e753f = 1;
            }
            if (self.var_e848e1ba <= 2) {
                level thread function_3c458698(self.var_e848e1ba);
            } else {
                level clientfield::set("building_destruction_callback", self.var_e848e1ba);
            }
            self.var_10f44b5++;
            self.var_e848e1ba++;
            if (self.var_10f44b5 == 2) {
                return;
            }
            while (who istouching(self)) {
                wait(0.1);
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xd2f8526c, Offset: 0x4590
// Size: 0x104
function function_ef7f1d9f() {
    var_db07a21e = getent("building_a", "script_noteworthy");
    var_db07a21e.var_10f44b5 = 0;
    var_db07a21e.var_e848e1ba = 1;
    level waittill(#"hash_3692720b");
    if (!scene::function_b1f75ee9()) {
        level function_3c458698(var_db07a21e.var_e848e1ba);
    } else {
        level thread function_8f97d54e(1);
    }
    var_db07a21e.var_10f44b5++;
    var_db07a21e.var_e848e1ba++;
    level waittill(#"hash_76c03f01");
    level flag::set("vtol_intro_complete");
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xbb17f1c6, Offset: 0x46a0
// Size: 0xae
function function_a081beb1() {
    var_b6b51414 = getentarray("sarah_battle_launcher", "targetname");
    for (i = 0; i < var_b6b51414.size; i++) {
        if (isdefined(var_b6b51414[i].script_int) && var_b6b51414[i].script_int > level.players.size) {
            var_b6b51414[i] delete();
        }
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xf183c349, Offset: 0x4758
// Size: 0x198
function function_a5a3b915() {
    level.var_42189297 endon(#"death");
    a_s_start_points = struct::get_array("sarah_battle_magic_rpg", "targetname");
    weapon = getweapon("launcher_standard");
    while (true) {
        s_start_point = array::random(a_s_start_points);
        v_target = level.var_42189297.origin;
        var_19b59544 = (v_target[0] + randomfloatrange(100 * -1, 100), v_target[1] + randomfloatrange(100 * -1, 100), v_target[2] + randomfloatrange(100 * -1, 100));
        magicbullet(weapon, s_start_point.origin, var_19b59544);
        wait(randomfloatrange(2, 6));
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xe9ecda7, Offset: 0x48f8
// Size: 0x124
function function_a6425c73() {
    var_6748b62b = struct::get("crashed_vtol_explosion", "targetname");
    if (!isdefined(var_6748b62b)) {
        return;
    }
    forward = anglestoforward(var_6748b62b.angles);
    for (player = array::random(level.players); true; player = array::random(level.players)) {
        if (player namespace_36cbf523::function_a84dcdf8(var_6748b62b)) {
            playfx(level._effect["crashed_vtol_exp_fx"], var_6748b62b.origin, forward);
            return;
        }
        wait(0.1);
        if (!isdefined(player)) {
        }
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x7852668a, Offset: 0x4a28
// Size: 0x228
function function_f508734c() {
    level.var_42189297 endon(#"death");
    level.var_9db406db = util::function_740f8516("khalil");
    level thread function_acea9315();
    level thread function_cc12870c();
    level thread function_5acf54bf();
    spawner::add_spawn_function_ai_group("initial_egypt_army", &function_278b6566);
    spawner::add_spawn_function_ai_group("reinforce_egypt_army", &function_ed2505ff);
    spawner::simple_spawn("sp_ally_egypt_army");
    level flag::set("sarah_battle_friendly_spawned");
    spawner::waittill_ai_group_amount_killed("initial_egypt_army", 4);
    var_e2f02570 = getentarray("t_reinforce", "targetname");
    var_e2f02570 = array::randomize(var_e2f02570);
    foreach (var_b75ca74d in var_e2f02570) {
        var_b75ca74d trigger::use();
        wait(randomfloatrange(7, 12));
        level notify(#"hash_d8096db5");
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x8e262280, Offset: 0x4c58
// Size: 0x34
function function_278b6566() {
    self setgoal(level.var_9db406db, 0, 1024);
    self.script_noteworthy = "team_khalil";
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x6a78b7ec, Offset: 0x4c98
// Size: 0x154
function function_ed2505ff() {
    self endon(#"death");
    self.overrideactordamage = &function_1853d81a;
    self.accuracy = 0.2;
    self ai::set_ignoreme(1);
    self waittill(#"exited_vehicle");
    var_ab891f49 = getent("goal_volume_" + self.script_string, "targetname");
    self setgoal(var_ab891f49);
    self waittill(#"goal");
    self ai::set_ignoreme(0);
    wait(10);
    if (math::cointoss()) {
        self setgoal(level.var_9db406db, 0, 1024);
        self.script_noteworthy = "team_khalil";
        return;
    }
    self setgoal(level.var_2fd26037, 0, 1024);
    self.script_noteworthy = "team_hendricks";
}

// Namespace namespace_c3900363
// Params 13, eflags: 0x0
// Checksum 0xfb768831, Offset: 0x4df8
// Size: 0xa6
function function_1853d81a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
    if (weapon == getweapon("spike_charge_siegebot_theia")) {
        idamage = self.health + 100;
    }
    return idamage;
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xd234a773, Offset: 0x4ea8
// Size: 0xb8
function function_acea9315() {
    spawner::add_spawn_function_ai_group("friendly_wasp", &function_6c7a52c3);
    while (!level flag::get("sarah_defeated")) {
        if (spawner::get_ai_group_sentient_count("friendly_wasp") < 3) {
            spawner::simple_spawn_single("mg_wasp_ally");
        }
        wait(randomfloatrange(3, 8));
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x4b9f7656, Offset: 0x4f68
// Size: 0xb4
function function_6c7a52c3() {
    self endon(#"death");
    self.var_66ff806d = 1;
    self.accuracy_turret = 0.2;
    self.no_group = 1;
    self setteam("allies");
    wait(randomfloatrange(15, 25));
    if (!level flag::get("sarah_defeated")) {
        self kill();
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x624881e2, Offset: 0x5028
// Size: 0x13a
function function_b3d20adf() {
    level flag::wait_till("sarah_defeated");
    var_6e403395 = getentarray("amws_ally_intro_ai", "targetname");
    var_6e403395 = arraycombine(var_6e403395, getentarray("amws_ally_ai", "targetname"), 0, 0);
    foreach (var_69837b75 in var_6e403395) {
        var_69837b75 ai::set_ignoreall(1);
        var_69837b75.goalradius = 16;
        var_69837b75 vehicle_ai::start_scripted();
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x1f1f1d5, Offset: 0x5170
// Size: 0xf8
function function_cc12870c() {
    level thread function_b3d20adf();
    while (!level flag::get("sarah_defeated")) {
        if (spawner::get_ai_group_sentient_count("friendly_amws") < 2) {
            var_31e90922 = spawner::simple_spawn_single("amws_ally");
            var_31e90922.accuracy_turret = 0.2;
            var_31e90922.health = -126;
            var_31e90922 setteam("allies");
        }
        wait(randomfloatrange(10, 20));
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x244f543d, Offset: 0x5270
// Size: 0x126
function function_a2d6949a() {
    self endon(#"death");
    level.var_42189297 endon(#"death");
    while (true) {
        n_dist = distance(self.origin, level.var_42189297.origin);
        if (n_dist < 256 || n_dist > 1200) {
            self ai::set_ignoreall(1);
            var_974cc07 = function_9c1377d2(level.var_42189297.origin);
            self ai::force_goal(var_974cc07, 32, 1);
            self waittill(#"goal");
            self clearforcedgoal();
            self ai::set_ignoreall(0);
        }
        wait(1);
    }
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0x50ec6321, Offset: 0x53a0
// Size: 0x15e
function function_9c1377d2(v_pos) {
    var_9b71f11e = getnodearray("hero_cover", "targetname");
    var_8cc07584 = var_9b71f11e[0];
    n_dist = 0;
    foreach (node in var_9b71f11e) {
        var_c4e1f800 = distance(v_pos, node.origin);
        if (var_c4e1f800 > n_dist && var_c4e1f800 > 256 && var_c4e1f800 < 1200 && !isnodeoccupied(node)) {
            var_8cc07584 = node;
            n_dist = var_c4e1f800;
        }
    }
    return var_8cc07584;
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x7cfd0313, Offset: 0x5508
// Size: 0x84
function function_5acf54bf() {
    level.var_42189297 endon(#"death");
    level waittill(#"hash_f5d02307");
    level thread function_e2f2e8a7("veh_spawn_technical_1", 1);
    spawner::waittill_ai_group_ai_count("initial_egypt_army", 4);
    level thread function_e2f2e8a7("veh_spawn_technical_2");
}

// Namespace namespace_c3900363
// Params 2, eflags: 0x0
// Checksum 0x4829c9f6, Offset: 0x5598
// Size: 0x25c
function function_e2f2e8a7(var_7edf3031, var_473f0c60) {
    if (!isdefined(var_473f0c60)) {
        var_473f0c60 = 0;
    }
    if (!isdefined(var_7edf3031)) {
        return;
    }
    e_spawner = getent(var_7edf3031, "targetname");
    var_3ed4170d = spawner::simple_spawn_single(e_spawner);
    if (!isdefined(var_3ed4170d)) {
        return;
    }
    var_44762fa4 = spawner::simple_spawn_single("technical_driver");
    var_44762fa4 thread vehicle::get_in(var_3ed4170d, "driver", 1);
    var_dfb53de7 = spawner::simple_spawn_single("technical_gunner");
    var_dfb53de7 thread vehicle::get_in(var_3ed4170d, "gunner1", 1);
    var_e2a955ea = getvehiclenode(var_7edf3031 + "_start", "targetname");
    var_3ed4170d thread vehicle::get_on_and_go_path(var_e2a955ea);
    var_3ed4170d util::magic_bullet_shield();
    var_3ed4170d waittill(#"reached_end_node");
    if (isdefined(var_473f0c60) && var_473f0c60) {
        var_3ed4170d.driver = var_44762fa4;
        var_3ed4170d.gunner = var_dfb53de7;
        level.var_42189297 thread function_36b2a27b(var_3ed4170d);
        return;
    }
    var_3ed4170d util::stop_magic_bullet_shield();
    if (isalive(var_44762fa4)) {
        var_44762fa4 thread vehicle::get_out();
    }
    if (isalive(var_dfb53de7)) {
        var_dfb53de7 thread vehicle::get_out();
    }
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0xac61aace, Offset: 0x5800
// Size: 0x124
function function_36b2a27b(vehicle) {
    vehicle.gunner.targetname = "truck_gunner";
    level util::waittill_either("theia_finished_platform_attack", "theia_preparing_javelin_attack");
    vehicle delete();
    vehicle.driver delete();
    self vehicle_ai::start_scripted();
    self scene::play("cin_inf_02_01_vign_interface_siegebot_bash_2", self);
    self vehicle_ai::set_state("groundCombat");
    self.var_a92e753f = 0;
    if (isdefined(level.var_377e3a8)) {
        level.var_377e3a8 solid();
        level.var_377e3a8 disconnectpaths();
    }
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0x57e61823, Offset: 0x5930
// Size: 0x4c
function function_24b31974(a_ents) {
    a_ents["sarah_siegebot"] waittill(#"hash_fc589d16");
    a_ents["truck_bash"] setmodel("veh_t7_civ_truck_pickup_tech_egypt_dead");
}

// Namespace namespace_c3900363
// Params b, eflags: 0x0
// Checksum 0x49515ad5, Offset: 0x5988
// Size: 0xcc
function function_6255dfdc(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
    var_bdc821cf = 3;
    if (weapon == getweapon("spike_charge_siegebot_theia")) {
        if (isdefined(self.var_16bcd6ff) && self.var_16bcd6ff + var_bdc821cf * 1000 > gettime()) {
            return 0;
        } else {
            self.var_16bcd6ff = gettime();
        }
    }
    return idamage;
}

// Namespace namespace_c3900363
// Params 2, eflags: 0x0
// Checksum 0xfb77bfdb, Offset: 0x5a60
// Size: 0x324
function function_6714d6be(str_objective, var_74cd64bc) {
    /#
        iprintlnbold("CP_MI_CAIRO_INFECTION_INTRO_LINE_4_SHORT");
    #/
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        var_6de1bb68 = struct::get("hendricks_start_pos_sarah_battle_end", "targetname");
        level.var_2fd26037 forceteleport(var_6de1bb68.origin, var_6de1bb68.angles);
        level.var_9db406db = util::function_740f8516("khalil");
        var_28daa962 = struct::get("khalil_start_pos_sarah_battle_end", "targetname");
        level.var_9db406db forceteleport(var_28daa962.origin, var_28daa962.angles);
        function_516efb66(var_74cd64bc);
        level.var_42189297 vehicle_ai::set_state("groundCombat");
        level.var_42189297 util::stop_magic_bullet_shield();
        level.var_42189297 namespace_a28cc5ab::function_d56305c8(0);
        level.var_42189297 vehicle::lights_off();
        level.var_42189297 dodamage(level.var_42189297.health + 10000, level.var_42189297.origin, level.players[0]);
    }
    level thread function_d7904bda();
    if (var_74cd64bc) {
        function_48e3f00e();
        exploder::exploder("sarah_battle_vtol_crash_fire");
        exploder::exploder("sarah_battle_fire");
        level flag::set("vtol_intro_complete");
        level clientfield::set("building_end_callback", 1);
        level thread function_8f97d54e(1);
        level thread function_8f97d54e(2);
        level thread function_c05c7cfe();
        load::function_a2995f22();
    }
    battlechatter::function_d9f49fba(0);
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0xc10d79cc, Offset: 0x5d90
// Size: 0xa6
function function_cbf00d30(str_menu) {
    foreach (e_player in level.players) {
        e_player.var_3e317885 = e_player openluimenu(str_menu);
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x2a3a51e7, Offset: 0x5e40
// Size: 0xb8
function function_96914e16() {
    foreach (e_player in level.players) {
        if (isdefined(e_player.var_3e317885)) {
            e_player closeluimenu(e_player.var_3e317885);
            e_player.var_3e317885 = undefined;
        }
    }
}

// Namespace namespace_c3900363
// Params 4, eflags: 0x0
// Checksum 0x27a62c40, Offset: 0x5f00
// Size: 0x94
function function_f72443b3(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    /#
        iprintlnbold("intro_friendly");
    #/
    level clientfield::set("vtol_fog_bank", 0);
    objectives::complete("cp_level_infection_find_dr");
    function_cf47c514(0);
}

// Namespace namespace_c3900363
// Params 4, eflags: 0x0
// Checksum 0x9a6ffe0, Offset: 0x5fa0
// Size: 0x74
function function_eaebdc16(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    /#
        iprintlnbold("sarah_battle_magic_rpg");
    #/
    util::delay(0.1, undefined, &function_cf47c514, 1);
}

// Namespace namespace_c3900363
// Params 4, eflags: 0x0
// Checksum 0x8f6092e8, Offset: 0x6020
// Size: 0xae
function function_e6eaed98(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    /#
        iprintlnbold("veh_spawn_technical_1");
    #/
    allies = getaiteamarray("allies");
    for (i = 0; i < allies.size; i++) {
        allies[i] delete();
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xd1c14c54, Offset: 0x60d8
// Size: 0x90
function clean_up() {
    level.overrideplayerdamage = undefined;
    foreach (player in level.players) {
        self.var_16bcd6ff = undefined;
        self.var_47b86c9b = undefined;
    }
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0xf7ad56d7, Offset: 0x6170
// Size: 0x7c
function function_cf47c514(b_enable) {
    var_2a95256 = getent("sarah_siegebot_death_clip", "targetname");
    if (isdefined(var_2a95256)) {
        if (b_enable) {
            var_2a95256 show();
            return;
        }
        var_2a95256 hide();
    }
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x7af243d8, Offset: 0x61f8
// Size: 0x1bc
function function_d7904bda() {
    var_b1a4293e = util::spawn_model("tag_origin", level.var_42189297.origin, level.var_42189297.angles);
    var_b1a4293e.targetname = "tag_align_sarah";
    clean_up();
    scene::add_scene_func("cin_inf_03_01_interface_1st_dni_02", &function_ed02c344, "init");
    level scene::init("cin_inf_03_01_interface_1st_dni_02");
    level thread function_2ffaa595();
    level flag::wait_till("sarah_interface_done");
    level.var_2fd26037 util::unmake_hero("hendricks");
    level.var_2fd26037 util::self_delete();
    level.var_9db406db util::unmake_hero("khalil");
    level.var_9db406db util::self_delete();
    if (isdefined(level.var_156d60f)) {
        level.var_156d60f delete();
    }
    var_b1a4293e delete();
    skipto::function_be8adfb8("sarah_battle_end");
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0x50111cb4, Offset: 0x63c0
// Size: 0x302
function function_ed02c344(a_ents) {
    wait(1);
    var_7d116593 = struct::get("s_sim_reality_lighting_hint", "targetname");
    level thread namespace_36cbf523::function_7aca917c(var_7d116593.origin);
    var_b7f41419 = spawn("trigger_radius_use", a_ents["sarah_driver"].origin + (0, 0, 15), 0, 125, -112);
    var_b7f41419 triggerignoreteam();
    var_b7f41419 setvisibletoall();
    var_b7f41419 setteamfortrigger("none");
    var_b7f41419 usetriggerrequirelookat();
    /#
        debugstar(var_b7f41419.origin, 1000, (1, 0, 0));
    #/
    var_b7f41419.e_gameobject = util::function_14518e76(var_b7f41419, %cp_level_infection_interface_sarah, %CP_MI_CAIRO_INFECTION_T_DNI, &function_795efef);
    while (true) {
        player = var_b7f41419 waittill(#"hash_6453bafb");
        level thread namespace_eccdd5d1::function_a693b757();
        if (isplayer(player)) {
            var_b7f41419.e_gameobject gameobjects::disable_object();
            var_b7f41419 delete();
            objectives::complete("cp_level_infection_interface_sarah");
            level flag::set("sarah_interface_started");
            if (isdefined(level.var_612d3f9)) {
                level thread [[ level.var_612d3f9 ]]();
            }
            level.var_efa959f1 = 0;
            scene::add_scene_func("cin_inf_03_01_interface_1st_dni_02", &function_271fa79e, "skip_completed");
            level thread scene::play("cin_inf_03_01_interface_1st_dni_02", player);
            level thread namespace_b2b18209::function_f6fce5f1();
            function_3b4ccd2e();
            level flag::set("sarah_interface_done");
            return;
        }
    }
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0x9a2c7470, Offset: 0x66d0
// Size: 0x18
function function_271fa79e(a_ents) {
    level.var_efa959f1 = 1;
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0xb59cb62f, Offset: 0x66f0
// Size: 0x4e
function function_3b4ccd2e() {
    for (var_85c195bd = 0; var_85c195bd < 24 && !level.var_efa959f1; var_85c195bd += 0.1) {
        wait(0.1);
    }
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0xee762a10, Offset: 0x6748
// Size: 0x24
function function_795efef(player) {
    self.trigger notify(#"hash_6453bafb", player);
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x646223ed, Offset: 0x6778
// Size: 0x174
function function_90de550e() {
    level scene::play("cin_inf_02_01_vign_interface_siegebot_bash");
    level scene::init("cin_inf_02_01_vign_interface_siegebot_death");
    level.var_156d60f thread function_76887c27();
    level.var_42189297 ai::set_ignoreall(0);
    level.var_42189297 vehicle_ai::stop_scripted("groundCombat");
    level thread function_a5a3b915();
    level thread function_24cf26d5();
    level.var_42189297 waittill(#"death");
    level thread namespace_eccdd5d1::function_973b77f9();
    level flag::set("sarah_defeated");
    objectives::complete("cp_level_infection_defeat_sarah");
    level scene::play("cin_inf_02_01_vign_interface_siegebot_death");
    skipto::function_be8adfb8("sarah_battle");
    level thread function_c05c7cfe();
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x921e6b1e, Offset: 0x68f8
// Size: 0x24
function function_76887c27() {
    level.var_42189297 thread scene::play("cin_inf_01_01_vtolarrival_1st_encounter_sarah_cockpit_loop", self);
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0xf406617b, Offset: 0x6928
// Size: 0xfc
function function_68861104(a_ents) {
    var_1e13503b = a_ents["sarah_truck_bash"];
    var_1e13503b.do_scripted_crash = 0;
    var_1e13503b.deathmodel_attached = 1;
    var_1e13503b waittill(#"explode");
    var_1e13503b notify(#"death");
    var_1e13503b setmodel(var_1e13503b.deathmodel);
    var_bead0234 = struct::get("s_siegebot_bash_explosion", "targetname");
    level.var_42189297 magicgrenadetype(getweapon("frag_grenade"), var_bead0234.origin, (0, 0, 1), 0);
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x305a1e52, Offset: 0x6a30
// Size: 0x37a
function function_c05c7cfe() {
    var_3ced446f = getaispeciesarray("allies", "human");
    var_87840852 = getnodearray("nd_post_sarah", "script_noteworthy");
    var_51c45f53 = getnodearray("nd_post_sarah_hendricks", "script_noteworthy");
    var_a7b9f562 = var_87840852.size + 1;
    for (i = 0; i < var_3ced446f.size; i++) {
        if (isalive(var_3ced446f[i]) && !var_3ced446f[i] util::is_hero()) {
            var_2540d664 = 1;
            foreach (e_player in level.activeplayers) {
                if (e_player util::is_player_looking_at(var_3ced446f[i].origin + (0, 0, 40))) {
                    var_2540d664 = 0;
                }
            }
            if (var_2540d664) {
                var_3ced446f[i] kill();
            }
        }
    }
    var_bc0bb597 = 0;
    foreach (var_3b8db917 in var_3ced446f) {
        if (isalive(var_3b8db917)) {
            var_3b8db917.goalradius = -128;
            var_3b8db917 clearentitytarget();
            var_3b8db917 cleargoalvolume();
            var_3b8db917 clearforcedgoal();
            var_3b8db917 ai::set_ignoreall(1);
            if (var_3b8db917 == level.var_2fd26037) {
                var_3b8db917 setgoal(var_51c45f53[0], 1);
                continue;
            }
            var_3b8db917 setgoal(var_87840852[var_bc0bb597], 1, -128, -128);
            var_bc0bb597++;
            if (var_bc0bb597 == var_87840852.size) {
                return;
            }
        }
    }
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0xb97747cb, Offset: 0x6db8
// Size: 0xc4
function function_5ee3bff5(end_pos) {
    self endon(#"death");
    self endon(#"goal");
    level endon(#"hash_eeb362cc");
    var_7e5d2524 = randomintrange(-128, 256);
    var_e73aacd3 = vectornormalize(self.origin - end_pos) * var_7e5d2524;
    v_goal = end_pos + var_e73aacd3;
    self setgoalpos(v_goal, 1);
}

// Namespace namespace_c3900363
// Params 0, eflags: 0x0
// Checksum 0x1fe9e2a, Offset: 0x6e88
// Size: 0xbe
function function_48e3f00e() {
    for (i = 1; i <= 2; i++) {
        str_name = "p7_fxanim_cp_infection_sarah_building_0" + i + "_bundle";
        var_666ebfcb = struct::get(str_name, "scriptbundlename");
        if (isdefined(var_666ebfcb)) {
            level thread scene::init(str_name);
        }
        function_6712dcb2("m_sarah_building_0" + i, 0);
    }
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0x33590271, Offset: 0x6f50
// Size: 0xa4
function function_3c458698(var_b6dcd715) {
    str_name = "p7_fxanim_cp_infection_sarah_building_0" + var_b6dcd715 + "_bundle";
    var_666ebfcb = struct::get(str_name, "scriptbundlename");
    if (isdefined(var_666ebfcb)) {
        level scene::play(str_name);
        function_6712dcb2("m_sarah_building_0" + var_b6dcd715, 1);
    }
}

// Namespace namespace_c3900363
// Params 1, eflags: 0x0
// Checksum 0xd91448ba, Offset: 0x7000
// Size: 0x7c
function function_8f97d54e(var_b6dcd715) {
    str_name = "p7_fxanim_cp_infection_sarah_building_0" + var_b6dcd715 + "_bundle";
    var_666ebfcb = struct::get(str_name, "scriptbundlename");
    if (isdefined(var_666ebfcb)) {
        level thread scene::skipto_end(str_name);
    }
}

// Namespace namespace_c3900363
// Params 2, eflags: 0x0
// Checksum 0x6cb4bb41, Offset: 0x7088
// Size: 0x15a
function function_6712dcb2(str_targetname, b_show) {
    if (!isdefined(b_show)) {
        b_show = 1;
    }
    var_5cee1345 = getentarray(str_targetname, "targetname");
    if (b_show) {
        foreach (model in var_5cee1345) {
            model show();
        }
        return;
    }
    foreach (model in var_5cee1345) {
        model ghost();
    }
}

