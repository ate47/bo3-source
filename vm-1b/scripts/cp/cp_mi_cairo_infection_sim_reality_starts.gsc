#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection_sgen_test_chamber;
#using scripts/cp/cp_mi_cairo_infection_sound;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/player_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;

#namespace sim_reality_starts;

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0xb3933347, Offset: 0x938
// Size: 0x4a
function main() {
    /#
        iprintlnbold("<dev string:x28>");
    #/
    init_flags();
    init_client_field_callback_funcs();
    function_7b244c18();
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0xddb26cc5, Offset: 0x990
// Size: 0x1a
function init_flags() {
    level flag::init("baby_picked_up");
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0x1e80061f, Offset: 0x9b8
// Size: 0x25a
function init_client_field_callback_funcs() {
    clientfield::register("toplayer", "sim_out_of_bound", 1, 1, "counter");
    clientfield::register("world", "sim_lgt_tree_glow_01", 1, 1, "int");
    clientfield::register("world", "sim_lgt_tree_glow_02", 1, 1, "int");
    clientfield::register("world", "sim_lgt_tree_glow_03", 1, 1, "int");
    clientfield::register("world", "sim_lgt_tree_glow_04", 1, 1, "int");
    clientfield::register("world", "sim_lgt_tree_glow_05", 1, 1, "int");
    clientfield::register("world", "lgt_tree_glow_05_fade_out", 1, 1, "int");
    clientfield::register("world", "sim_lgt_tree_glow_all_off", 1, 1, "int");
    clientfield::register("toplayer", "pstfx_frost_up", 1, 1, "counter");
    clientfield::register("toplayer", "pstfx_frost_down", 1, 1, "counter");
    clientfield::register("toplayer", "pstfx_frost_up_baby", 1, 1, "counter");
    clientfield::register("toplayer", "pstfx_exit_all", 1, 1, "counter");
    clientfield::register("scriptmover", "infection_baby_shader", 1, 1, "int");
    clientfield::register("world", "toggle_sim_fog_banks", 1, 1, "int");
    clientfield::register("world", "break_baby", 1, 1, "int");
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xc20
// Size: 0x2
function function_7b244c18() {
    
}

// Namespace sim_reality_starts
// Params 2, eflags: 0x0
// Checksum 0x6ffe1e30, Offset: 0xc30
// Size: 0x24a
function function_d78d6232(str_objective, var_74cd64bc) {
    /#
        iprintlnbold("<dev string:x41>");
    #/
    if (var_74cd64bc) {
        load::function_73adcefc();
        level thread scene::init("cin_inf_04_01_birthai_vign_deathpose");
    }
    infection_util::function_1cdb9014();
    clientfield::set("toggle_sim_fog_banks", 1);
    level util::set_lighting_state(0);
    skipto::teleport_players(str_objective);
    if (var_74cd64bc) {
        load::function_a2995f22();
    }
    foreach (e_player in level.activeplayers) {
        e_player player::switch_to_primary_weapon(1);
    }
    clientfield::set("sim_lgt_tree_glow_01", 1);
    array::thread_all(level.players, &infection_util::function_9f10c537);
    level thread function_43e9cbbf();
    if (isdefined(level.var_46584a9c)) {
        level thread [[ level.var_46584a9c ]]();
    }
    level thread scene::play("cin_inf_04_01_birthai_1st_crying_init");
    level thread function_e2a1f622();
    level thread function_3c6bbd12();
    level thread function_12c0aa84();
    level thread function_f2e3184d();
    level thread function_2baf7f93();
    level thread function_e7b91ace();
    level thread function_30f163f9();
    level thread function_8742cfd3();
    level thread function_96fb6d2b();
    level thread function_bcfde794();
    level thread function_e30061fd();
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0xa7dfcfc6, Offset: 0xe88
// Size: 0x1a
function function_f6fce5f1() {
    level scene::init("cin_inf_04_01_birthai_vign_deathpose");
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0x5db0a108, Offset: 0xeb0
// Size: 0x1a
function function_e7b91ace() {
    level scene::play("cin_inf_04_01_birthai_vign_deathpose");
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0x5276b2ad, Offset: 0xed8
// Size: 0x6b
function function_c52039f4() {
    foreach (player in level.players) {
        player playrumbleonentity("damage_heavy");
    }
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0x38ee2774, Offset: 0xf50
// Size: 0x19a
function function_30f163f9() {
    level thread function_3b662fed();
    trigger::wait_till("t_vo_thea_where_am_i_what_s_0");
    clientfield::set("sim_lgt_tree_glow_02", 1);
    level thread namespace_eccdd5d1::function_8e8e5a12();
    function_c52039f4();
    playsoundatposition("evt_tree_light", (-24528, -25283, 3712));
    level thread namespace_eccdd5d1::function_14588839();
    trigger::wait_till("t_plyr_i_hear_a_baby_crying_0");
    level dialog::function_13b3b16a("plyr_i_hear_a_baby_crying_0", 1);
    level dialog::function_13b3b16a("plyr_hello_is_anyone_th_0");
    trigger::wait_till("t_lgt_tree_glow_03");
    trigger::wait_till("t_plyr_i_don_t_know_if_you_0");
    level dialog::function_13b3b16a("plyr_i_don_t_know_if_you_0");
    trigger::wait_till("t_plyr_hall_0");
    level dialog::function_13b3b16a("plyr_hall_0");
    level dialog::function_13b3b16a("hall_what_did_you_do_to_m_0", 0.6);
    level dialog::function_13b3b16a("plyr_i_tried_to_interface_0", 2.3);
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0xb72f5e93, Offset: 0x10f8
// Size: 0x42
function function_3b662fed() {
    wait 3.5;
    level dialog::function_13b3b16a("plyr_kane_hendricks_0", 1);
    objectives::set("cp_level_infection_extract_intel");
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0xf33963c5, Offset: 0x1148
// Size: 0x5a
function function_e2a1f622() {
    trigger::wait_till("t_salm_mr_krueger_beat_0");
    t_salm_mr_krueger_beat_0 = getent("t_salm_mr_krueger_beat_0", "targetname");
    t_salm_mr_krueger_beat_0 dialog::say("salm_mr_krueger_beat_0", 0, 1);
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0x9c36409c, Offset: 0x11b0
// Size: 0x5a
function function_3c6bbd12() {
    trigger::wait_till("t_krue_oh_i_understand_do_0");
    t_salm_mr_krueger_beat_0 = getent("t_krue_oh_i_understand_do_0", "targetname");
    t_salm_mr_krueger_beat_0 dialog::say("krue_oh_i_understand_do_0", 0, 1);
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0x17db5e75, Offset: 0x1218
// Size: 0x5a
function function_12c0aa84() {
    trigger::wait_till("t_salm_please_listen_to_wh_0");
    t_salm_mr_krueger_beat_0 = getent("t_salm_please_listen_to_wh_0", "targetname");
    t_salm_mr_krueger_beat_0 dialog::say("salm_please_listen_to_wh_0", 0, 1);
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0x62b4753, Offset: 0x1280
// Size: 0x5a
function function_f2e3184d() {
    trigger::wait_till("t_krue_we_re_standing_on_th_1");
    t_salm_mr_krueger_beat_0 = getent("t_krue_we_re_standing_on_th_1", "targetname");
    t_salm_mr_krueger_beat_0 dialog::say("krue_we_re_standing_on_th_1", 0, 1);
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0x378181f, Offset: 0x12e8
// Size: 0x5a
function function_2baf7f93() {
    trigger::wait_till("t_krue_zurich_is_where_the_1");
    t_salm_mr_krueger_beat_0 = getent("t_krue_zurich_is_where_the_1", "targetname");
    t_salm_mr_krueger_beat_0 dialog::say("krue_zurich_is_where_the_1", 0, 1);
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0x3a4f6b36, Offset: 0x1350
// Size: 0x8a
function function_96fb6d2b() {
    trigger::wait_till("t_lgt_tree_glow_03");
    level thread namespace_eccdd5d1::function_688bdfa9();
    clientfield::set("sim_lgt_tree_glow_03", 1);
    function_c52039f4();
    playsoundatposition("evt_tree_light", (-24934, -23881, 3803));
    playsoundatposition("evt_baby_cry", (0, 0, 0));
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0x43dc230c, Offset: 0x13e8
// Size: 0x8a
function function_bcfde794() {
    trigger::wait_till("t_lgt_tree_glow_04");
    level thread namespace_eccdd5d1::function_42896540();
    clientfield::set("sim_lgt_tree_glow_04", 1);
    function_c52039f4();
    playsoundatposition("evt_tree_light", (-24574, -22663, 4172));
    playsoundatposition("evt_baby_cry", (0, 0, 0));
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0x980ffd09, Offset: 0x1480
// Size: 0x8a
function function_e30061fd() {
    trigger::wait_till("t_lgt_tree_glow_05");
    level thread namespace_eccdd5d1::function_4c9abe1f();
    clientfield::set("sim_lgt_tree_glow_05", 1);
    function_c52039f4();
    playsoundatposition("evt_tree_light", (-23716, -21731, 4429));
    playsoundatposition("evt_baby_cry", (0, 0, 0));
}

// Namespace sim_reality_starts
// Params 4, eflags: 0x0
// Checksum 0x52940c2d, Offset: 0x1518
// Size: 0x7a
function function_2d3d4bcc(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    clientfield::set("toggle_sim_fog_banks", 0);
    clientfield::set("sim_lgt_tree_glow_all_off", 1);
    infection_util::function_3ea445de();
    objectives::complete("cp_level_infection_extract_intel");
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0x1136abd1, Offset: 0x15a0
// Size: 0xba
function function_43e9cbbf() {
    level.var_ff59b31e = 0;
    array::thread_all(level.players, &function_ca04578e);
    callback::on_spawned(&function_ca04578e);
    array::thread_all(getentarray("t_warm", "script_noteworthy"), &function_cdf731ff);
    level waittill(#"hash_744b1b8e");
    callback::remove_on_spawned(&function_ca04578e);
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0x5eb56f3e, Offset: 0x1668
// Size: 0x1e
function function_cdf731ff() {
    self waittill(#"trigger");
    self.b_activated = 1;
    level.var_ff59b31e++;
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0xa3637379, Offset: 0x1690
// Size: 0x1e9
function function_ca04578e() {
    level endon(#"hash_744b1b8e");
    self endon(#"death");
    var_803084e1 = getentarray("t_warm", "script_noteworthy");
    var_4902d28 = getentarray("t_cold", "script_noteworthy");
    while (true) {
        wait 1.5;
        str_status = "out_of_bounds";
        foreach (t_warm in var_803084e1) {
            if (self istouching(t_warm) && t_warm.b_activated === 1) {
                str_status = "warm";
            }
        }
        if (str_status != "warm") {
            foreach (t_cold in var_4902d28) {
                if (self istouching(t_cold)) {
                    str_status = "cold";
                }
            }
        }
        switch (str_status) {
        case "warm":
            self clientfield::increment_to_player("pstfx_frost_down", 1);
            break;
        case "cold":
            self clientfield::increment_to_player("pstfx_frost_up", 1);
            break;
        case "out_of_bounds":
            self function_ed57c386();
            break;
        }
    }
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0x68acc0b, Offset: 0x1888
// Size: 0x132
function function_ed57c386() {
    self freezecontrols(1);
    var_1b259f9b = struct::get_array("s_sim_out_of_bound_warp_" + level.var_ff59b31e);
    self thread hud::fade_to_black_for_x_sec(0, 1, 0.5, 1, "white");
    wait 0.5;
    self clientfield::increment_to_player("sim_out_of_bound");
    self clientfield::set("player_spawn_fx", 1);
    self setorigin(var_1b259f9b[self getentitynumber()].origin);
    self setplayerangles(var_1b259f9b[self getentitynumber()].angles);
    wait 0.5;
    self clientfield::set("player_spawn_fx", 0);
    self freezecontrols(0);
}

// Namespace sim_reality_starts
// Params 0, eflags: 0x0
// Checksum 0xc73c8907, Offset: 0x19c8
// Size: 0x1e2
function function_8742cfd3() {
    trigger::wait_till("pod_open_anim_trig");
    level thread scene::play("cin_inf_04_01_birthai_1st_crying_init_loop");
    var_be695670 = struct::get("pick_up_baby_objective_pos", "targetname");
    t_baby_use = getent("t_baby_use", "targetname");
    t_baby_use.e_gameobject = util::function_14518e76(t_baby_use, %cp_level_infection_gather_baby, %CP_MI_CAIRO_INFECTION_T_BABY_USE, &function_b4750e7c);
    util::wait_network_frame();
    level thread sgen_test_chamber::function_a29f7cbd();
    t_baby_use waittill(#"hash_2d864e11", player);
    objectives::complete("cp_level_infection_gather_baby");
    level clientfield::set("lgt_tree_glow_05_fade_out", 1);
    level thread namespace_eccdd5d1::function_582799a6();
    if (isdefined(player)) {
        /#
            iprintlnbold("<dev string:x59>");
        #/
        t_baby_use.e_gameobject gameobjects::disable_object();
        scene::add_scene_func("cin_inf_04_01_birthai_1st_crying", &function_3372b3a, "play");
        level flag::set("baby_picked_up");
        level scene::play("cin_inf_04_01_birthai_1st_crying", player);
        level notify(#"hash_744b1b8e");
        skipto::function_be8adfb8("sim_reality_starts");
    }
}

// Namespace sim_reality_starts
// Params 1, eflags: 0x0
// Checksum 0xea52bf22, Offset: 0x1bb8
// Size: 0x1e
function function_b4750e7c(player) {
    self.trigger notify(#"hash_2d864e11", player);
}

// Namespace sim_reality_starts
// Params 1, eflags: 0x0
// Checksum 0x312bae01, Offset: 0x1be0
// Size: 0x182
function function_3372b3a(a_ents) {
    /#
        iprintlnbold("<dev string:x74>");
    #/
    foreach (player in level.activeplayers) {
        player thread clientfield::increment_to_player("pstfx_exit_all");
    }
    var_c2cb9b70 = a_ents["baby"];
    level waittill(#"hash_d1cdd7c");
    var_c2cb9b70 clientfield::set("infection_baby_shader", 1);
    level waittill(#"hash_ad6cab7b");
    var_c2cb9b70 ghost();
    level clientfield::set("break_baby", 1);
    level waittill(#"hash_1fd5443a");
    foreach (player in level.activeplayers) {
        player thread clientfield::increment_to_player("pstfx_frost_up_baby", 1);
    }
    level waittill(#"hash_35e91f99");
    level thread util::screen_fade_out(1, "white");
}

