#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_murders;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace forest_surreal;

// Namespace forest_surreal
// Params 4, eflags: 0x0
// Checksum 0xc8ed4f2c, Offset: 0x15b0
// Size: 0x7a
function cleanup(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_f25bd8c8::function_ecd2ed4();
    var_ce40c475 = getentarray("world_falls_away_chasm", "targetname");
    array::run_all(var_ce40c475, &show);
}

// Namespace forest_surreal
// Params 2, eflags: 0x0
// Checksum 0x78b36892, Offset: 0x1638
// Size: 0x252
function main(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        objectives::set("cp_level_infection_follow_sarah");
        infection_util::function_cbc167();
        level.var_42189297 = util::function_740f8516("sarah");
        level.var_42189297 clientfield::set("sarah_objective_light", 1);
    }
    setup_spawners();
    if (true) {
        infection_util::function_c8d7e76("world_falls_away_reverse_anim");
    }
    function_4f978753();
    function_7f95f75e();
    level thread function_203e4c9c();
    level thread function_df55595f();
    level thread function_7c54e6ee();
    level thread function_59de9d07();
    level thread function_56b28f61();
    level thread function_e8d77ec8();
    if (var_74cd64bc) {
        load::function_a2995f22();
        level thread infection_util::function_3fe1f72("t_sarah_bastogne_objective_", 8, &function_32a538b9);
        infection_util::function_1cdb9014();
    }
    level thread transition_to_night();
    level thread function_e80ccf78();
    level thread function_483493cf();
    if (true) {
        level thread function_1120dd46();
    }
    if (false) {
        e_player = getplayers()[0];
        e_player.ignoreme = 1;
    }
    e_trigger = getent("forest_surreal_skipto_complete", "targetname");
    e_trigger waittill(#"trigger");
    level notify(#"hash_1b4a12e5");
    level thread skipto::function_be8adfb8(str_objective);
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xac1362a9, Offset: 0x1898
// Size: 0xd2
function function_633271eb() {
    level thread infection_util::function_f6d49772("t_salm_from_the_trials_unde_1", "salm_from_the_trials_unde_1", "end_salm_forest_dialog");
    level thread infection_util::function_f6d49772("t_salm_for_the_safety_of_my_1", "salm_for_the_safety_of_my_1", "end_salm_forest_dialog");
    level thread infection_util::function_f6d49772("t_salm_my_presentation_to_t_1", "salm_my_presentation_to_t_1", "end_salm_forest_dialog");
    level thread infection_util::function_f6d49772("t_salm_subject_e_38_crimi_1", "salm_subject_e_38_crimi_1", "end_salm_forest_dialog");
    level waittill(#"hash_1b6ae018");
    level thread infection_util::function_f6d49772("t_salm_at_the_time_of_his_a_1", "salm_at_the_time_of_his_a_1", "end_salm_forest_dialog");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xe4a70d08, Offset: 0x1978
// Size: 0x1a
function function_e80ccf78() {
    wait 0.2;
    infection_util::function_3ea445de();
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0x306f4790, Offset: 0x19a0
// Size: 0x4a
function function_95040800(dist) {
    self endon(#"death");
    while (self infection_util::player_can_see_me(dist)) {
        wait 0.1;
    }
    if (isdefined(self)) {
        self infection_util::function_5e78ab8c();
    }
}

// Namespace forest_surreal
// Params 2, eflags: 0x0
// Checksum 0x82b4695, Offset: 0x19f8
// Size: 0x3a
function dev_black_station_intro(str_objective, var_74cd64bc) {
    function_f4ab002c();
    level thread namespace_47ecfa2f::function_fbe0ab05("black_station", 0);
}

// Namespace forest_surreal
// Params 4, eflags: 0x0
// Checksum 0x2dbcda6, Offset: 0x1a40
// Size: 0x22
function function_503c0a2(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace forest_surreal
// Params 2, eflags: 0x0
// Checksum 0xf5e76ff, Offset: 0x1a70
// Size: 0x232
function forest_wolves(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
    }
    function_7b244c18();
    level thread function_e15b5dc7();
    level thread function_e9f75cf5();
    wait 0.1;
    if (false) {
        e_player = getplayers()[0];
        e_player.ignoreme = 1;
    }
    if (!isdefined(level.var_bce99b53)) {
        level thread function_4f978753();
    }
    if (true) {
        level thread infection_util::function_c8d7e76("world_falls_away_wolf_reverse_anim");
    }
    namespace_f25bd8c8::function_341d8f7a();
    namespace_f25bd8c8::function_8c0b0cd0();
    namespace_f25bd8c8::function_aea367c1();
    if (var_74cd64bc) {
        var_7d116593 = struct::get("s_forest_wolves_lighting_hint", "targetname");
        infection_util::function_7aca917c(var_7d116593.origin);
        objectives::set("cp_level_infection_follow_sarah");
        level.var_42189297 = util::function_740f8516("sarah");
        setup_spawners();
        function_7f95f75e();
        level thread namespace_bed101ee::function_daeb8be9();
        load::function_a2995f22();
        level.var_42189297 clientfield::set("sarah_objective_light", 1);
        level thread infection_util::function_3fe1f72("t_sarah_bastogne_objective_", 13, &function_32a538b9);
    }
    level thread function_4e7bce99();
    function_7b0c81e4();
    function_80ea1787();
    level thread skipto::function_be8adfb8(str_objective);
}

// Namespace forest_surreal
// Params 4, eflags: 0x0
// Checksum 0xa33f90a0, Offset: 0x1cb0
// Size: 0x22
function function_71196f64(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x8acb3550, Offset: 0x1ce0
// Size: 0x32
function function_e9f75cf5() {
    trigger::wait_till("t_plrf_sarah_who_was_tha_0");
    level dialog::function_13b3b16a("plyr_sarah_who_was_tha_0");
}

// Namespace forest_surreal
// Params 2, eflags: 0x0
// Checksum 0x47500524, Offset: 0x1d20
// Size: 0x72
function forest_sky_bridge(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        load::function_a2995f22();
        function_7519eaff();
    }
    function_42297537();
    level notify(#"hash_5d80c772");
    level thread skipto::function_be8adfb8(str_objective);
}

// Namespace forest_surreal
// Params 4, eflags: 0x0
// Checksum 0xfbdd2371, Offset: 0x1da0
// Size: 0x22
function function_dd270bfd(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x7e73818f, Offset: 0x1dd0
// Size: 0x32
function function_42297537() {
    trigger::wait_till("t_cross_sky_bridge");
    objectives::complete("cp_level_infection_cross_chasm");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xa815c184, Offset: 0x1e10
// Size: 0x16a
function function_7519eaff() {
    level util::clientnotify("chasm_wind");
    namespace_47ecfa2f::function_d7cb3668();
    playsoundatposition("evt_pullapart_world", (0, 0, 0));
    objectives::set("cp_level_infection_follow_sarah");
    function_7f95f75e();
    level thread namespace_bed101ee::function_daeb8be9();
    var_d8d55e31 = getentarray("world_falls_away_chasm", "targetname");
    for (i = 0; i < var_d8d55e31.size; i++) {
        str_name = var_d8d55e31[i].target;
        if (isdefined(str_name)) {
            s_struct = struct::get(str_name, "targetname");
            var_d8d55e31[i].origin = s_struct.origin;
        }
    }
    level thread function_e6cc7e28(1);
    exploder::exploder("light_wfa_end");
    var_d8d55e31[0] playloopsound("evt_pullapart_world_looper", 3);
    level thread function_12c8020a();
}

// Namespace forest_surreal
// Params 2, eflags: 0x0
// Checksum 0x12d7cc78, Offset: 0x1f88
// Size: 0x92
function forest_tunnel(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        function_7519eaff();
        objectives::complete("cp_level_infection_cross_chasm");
        load::function_a2995f22();
    } else {
        level thread namespace_47ecfa2f::function_d7cb3668();
    }
    function_f4ab002c();
    level thread skipto::function_be8adfb8(str_objective);
}

// Namespace forest_surreal
// Params 4, eflags: 0x0
// Checksum 0x570b524e, Offset: 0x2028
// Size: 0x82
function function_de606506(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    exploder::exploder_stop("lgt_forest_tunnel_02");
    exploder::exploder_stop("lgt_forest_tunnel_03");
    exploder::exploder_stop("lgt_forest_tunnel_04");
    exploder::exploder_stop("lgt_forest_tunnel_05");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x3492dd5d, Offset: 0x20b8
// Size: 0x109
function transition_to_night() {
    level thread function_97f6881();
    level thread lui::screen_flash(0.1, 1, 1, 0.3, "white");
    s_sound_origin = struct::get("world_falls_away_start_struct", "targetname");
    playsoundatposition("evt_night_transition", s_sound_origin.origin);
    level thread namespace_bed101ee::function_daeb8be9();
    s_struct = struct::get("s_night_transition", "targetname");
    for (count = 0; count < 20; count++) {
        playrumbleonposition("cp_infection_world_falls_break_rumble", s_struct.origin);
        util::wait_network_frame();
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xdc285050, Offset: 0x21d0
// Size: 0xc2
function function_7b244c18() {
    scene::add_scene_func("cin_inf_07_03_worldfallsaway_vign_pain", &function_5f558686, "play");
    scene::add_scene_func("cin_inf_07_03_worldfallsaway_vign_pain", &infection_util::function_c32dc5f6, "init");
    scene::add_scene_func("cin_inf_07_03_worldfallsaway_vign_pain", &infection_util::function_368baff9, "play");
    scene::add_scene_func("cin_inf_07_02_worldfallsaway_vign_direwolves_eating", &function_6d6d7d71, "init");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xe639e2cf, Offset: 0x22a0
// Size: 0xa2
function setup_spawners() {
    infection_util::function_aa0ddbc3(1);
    spawner::add_spawn_function_group("sm_bastogne_hill_guys_1", "targetname", &function_c6b52615);
    spawner::add_spawn_function_group("world_falls_away_intro_guys", "targetname", &function_c6b52615);
    spawner::add_spawn_function_group("wolf", "script_noteworthy", &function_21caff3e);
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xfb008339, Offset: 0x2350
// Size: 0x8b
function function_7f95f75e() {
    a_triggers = getentarray("falling_death", "targetname");
    foreach (trigger in a_triggers) {
        trigger thread function_c8049804();
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x724da06f, Offset: 0x23e8
// Size: 0x6d
function function_c8049804() {
    while (true) {
        self waittill(#"trigger", who);
        if (isplayer(who) && !(isdefined(who.var_e7c2cbb4) && who.var_e7c2cbb4)) {
            who thread function_2f645114();
        }
        util::wait_network_frame();
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x65cd597, Offset: 0x2460
// Size: 0x72
function function_2f645114() {
    self endon(#"death");
    self.var_e7c2cbb4 = 1;
    wait 1;
    self function_173f6520();
    self.var_e7c2cbb4 = 0;
    self dodamage(self.health / 10, self.origin);
    if (self.health < 1) {
        self.health = 1;
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xab54c73b, Offset: 0x24e0
// Size: 0x282
function function_173f6520() {
    self endon(#"death");
    var_6194780b = level.var_31aefea8;
    var_624a0b0b = spawnlogic::get_spawnpoint_array("cp_coop_respawn");
    var_24307637 = skipto::function_c13ce5f8(self, var_624a0b0b, var_6194780b);
    assert(var_24307637.size, "<dev string:x28>");
    var_4bd163fe = arraygetclosest(self.origin, var_24307637);
    if (positionwouldtelefrag(var_4bd163fe.origin)) {
        foreach (s_point in var_24307637) {
            if (s_point !== var_4bd163fe) {
                var_4bd163fe = s_point;
                break;
            }
        }
    }
    self.var_e7c2cbb4 = 1;
    self enableinvulnerability();
    self setinvisibletoall();
    self util::freeze_player_controls(1);
    self.ignoreme = 1;
    self clientfield::increment_to_player("postfx_igc");
    util::wait_network_frame();
    self setorigin(var_4bd163fe.origin);
    self setplayerangles(var_4bd163fe.angles);
    if (sessionmodeiscampaignzombiesgame()) {
        if (isdefined(level.var_203903e)) {
            [[ level.var_203903e ]](self, 4);
        }
    } else {
        self util::streamer_wait();
    }
    self setvisibletoall();
    self clientfield::set("player_spawn_fx", 1);
    self util::delay(0.5, "death", &clientfield::set, "player_spawn_fx", 0);
    wait 1.5;
    self util::freeze_player_controls(0);
    wait 2;
    self disableinvulnerability();
    self.ignoreme = 0;
    self.var_e7c2cbb4 = 0;
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x31d6964b, Offset: 0x2770
// Size: 0x52
function function_4f978753() {
    level.var_bce99b53 = 1;
    a_pieces = getentarray("bastogne_world_falls_away", "script_noteworthy");
    level thread array::thread_all(a_pieces, &function_10eef3d1);
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x8601e303, Offset: 0x27d0
// Size: 0x202
function function_10eef3d1() {
    if (self.classname == "script_model") {
        str_debug = self.model;
    } else {
        str_debug = self.origin;
    }
    if (!isdefined(self.target)) {
        return;
    }
    s_struct = struct::get(self.target, "targetname");
    if (!isdefined(s_struct)) {
        return;
    }
    s_struct.moving_platform = self;
    self.var_efe20130 = 0;
    v_pos = s_struct.origin;
    radius = 1260;
    if (isdefined(s_struct.radius)) {
        radius = s_struct.radius;
    }
    level thread function_7b6b3089(s_struct, radius);
    level waittill(s_struct.script_string);
    if (isdefined(self.script_string) && self.script_string == "moving_platform") {
        self.var_1912831c = 1;
        self setmovingplatformenabled(1);
    } else {
        self.var_1912831c = 0;
    }
    var_6e456024 = s_struct.origin;
    self function_c7aa396d();
    time = randomfloatrange(0.5, 1);
    self thread function_7e730dc3("cp_infection_world_falls_break_rumble", time, 1);
    self playsound("evt_small_flyaway_rumble");
    if (self.var_1912831c == 0) {
        wait time;
    }
    self function_a44c8b8c(var_6e456024, self.var_1912831c, undefined);
    self function_38c395f4();
    wait 1;
    self function_7c90d18c(var_6e456024);
    self delete();
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x9348421, Offset: 0x29e0
// Size: 0xb4
function function_38c395f4() {
    self.var_efe20130 = 1;
    self.var_db9ec4c4 = 80;
    self.var_385072d7 = 1.7;
    self.var_b6d84394 = 0.8;
    if (randomint(100) > 60) {
        self.var_db9ec4c4 = self.var_db9ec4c4 + randomintrange(20, 50);
    }
    self notify(#"hash_6db7529d");
    wait 0.05;
    self movez(self.var_db9ec4c4, self.var_385072d7, self.var_b6d84394, self.var_b6d84394);
    self waittill(#"movedone");
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0x38db7e99, Offset: 0x2aa0
// Size: 0x14c
function function_7c90d18c(v_pos) {
    self notify(#"hash_89c47e3d");
    var_85419cfe = randomfloatrange(1.2, 2.5);
    self thread function_7e730dc3("cp_infection_world_falls_away_rumble", var_85419cfe, 1);
    var_ab2048f4 = 0.28;
    var_f92960c = var_85419cfe;
    var_dd43e5e9 = 1850;
    earthquake(var_ab2048f4, var_f92960c, v_pos, var_dd43e5e9);
    playsoundatposition("evt_small_flyaway_go", v_pos);
    function_1b8bf759(self.model);
    if (self.var_1912831c) {
        self movez(-3000, 5.5, 2);
    } else {
        self movez(-3000, 5.5, 2);
    }
    self waittill(#"movedone");
}

// Namespace forest_surreal
// Params 3, eflags: 0x0
// Checksum 0xcb9202e2, Offset: 0x2bf8
// Size: 0x10a
function function_a44c8b8c(var_6e456024, var_1912831c, rumble) {
    var_ab2048f4 = 0.28;
    var_f92960c = randomfloatrange(0.5, 1.5);
    var_dd43e5e9 = 1850;
    if (var_1912831c) {
        var_f92960c = 1;
    }
    if (isdefined(rumble)) {
        if (self == level) {
            var_b2dab111 = util::spawn_model("tag_origin", var_6e456024);
            var_b2dab111.script_objective = "forest_wolves";
            util::wait_network_frame();
            var_b2dab111 thread function_3d3371d5();
        } else {
            self thread function_3d3371d5();
        }
    }
    earthquake(var_ab2048f4, var_f92960c, var_6e456024, var_dd43e5e9);
    wait var_f92960c;
    playsoundatposition("evt_small_flyaway_start", var_6e456024);
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xefb9853b, Offset: 0x2d10
// Size: 0x91
function function_3d3371d5() {
    self endon(#"death");
    for (count = 0; count < 10; count++) {
        self clientfield::increment("cp_infection_world_falls_break_rumble", 1);
        util::wait_network_frame();
    }
    wait 1;
    for (count = 0; count < 20; count++) {
        self clientfield::increment("cp_infection_world_falls_break_rumble", 1);
        util::wait_network_frame();
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x95286ca2, Offset: 0x2db0
// Size: 0x79
function function_67df7c1f() {
    str_name = self.model + "_skirt";
    var_4176ece1 = getentarray(str_name, "targetname");
    if (isdefined(var_4176ece1)) {
        for (i = 0; i < var_4176ece1.size; i++) {
            var_4176ece1[i] thread function_2b2b27eb(self);
        }
    }
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0xe83348b1, Offset: 0x2e38
// Size: 0x1a
function function_2b2b27eb(var_cc46221b) {
    self delete();
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0x923aa9c6, Offset: 0x2e60
// Size: 0x18a
function function_1b8bf759(str_model_name) {
    size = str_model_name.size;
    var_7c077f26 = str_model_name[size - 3] + str_model_name[size - 2] + str_model_name[size - 1];
    str_name = "light_wfa_" + var_7c077f26;
    var_a140185b = [];
    var_a140185b[var_a140185b.size] = "light_wfa_003";
    var_a140185b[var_a140185b.size] = "light_wfa_017";
    var_a140185b[var_a140185b.size] = "light_wfa_028";
    var_a140185b[var_a140185b.size] = "light_wfa_034";
    var_a140185b[var_a140185b.size] = "light_wfa_049";
    var_a140185b[var_a140185b.size] = "light_wfa_060";
    var_a140185b[var_a140185b.size] = "light_wfa_069";
    var_a140185b[var_a140185b.size] = "light_wfa_080";
    var_a140185b[var_a140185b.size] = "light_wfa_088";
    var_a140185b[var_a140185b.size] = "light_wfa_092";
    var_a140185b[var_a140185b.size] = "light_wfa_100";
    var_a140185b[var_a140185b.size] = "light_wfa_106";
    var_a140185b[var_a140185b.size] = "light_wfa_125";
    var_a140185b[var_a140185b.size] = "light_wfa_133";
    var_a140185b[var_a140185b.size] = "light_wfa_135";
    var_a140185b[var_a140185b.size] = "light_wfa_136";
    var_a140185b[var_a140185b.size] = "light_wfa_138";
    var_a140185b[var_a140185b.size] = "light_wfa_143";
    found = 0;
    for (i = 0; i < var_a140185b.size; i++) {
        if (str_name == var_a140185b[i]) {
            found = 1;
            break;
        }
    }
    if (found) {
        exploder::exploder(str_name);
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xf620e29c, Offset: 0x2ff8
// Size: 0x7a
function function_c7aa396d() {
    self thread function_67df7c1f();
    self clientfield::increment("wfa_steam_sound", 1);
    str_identifier = getsubstr(self.model, 20, self.model.size);
    str_exploder = "forest_surreal_groundfall_steam_" + str_identifier;
    exploder::exploder(str_exploder);
}

// Namespace forest_surreal
// Params 3, eflags: 0x0
// Checksum 0x65c9565d, Offset: 0x3080
// Size: 0x4b
function function_7e730dc3(str_name, var_524f5a91, n_wait) {
    for (i = 0; i < var_524f5a91; i++) {
        self clientfield::increment(str_name, 1);
        wait n_wait;
    }
}

// Namespace forest_surreal
// Params 2, eflags: 0x0
// Checksum 0x8c21d4b6, Offset: 0x30d8
// Size: 0xf5
function function_7b6b3089(s_struct, radius) {
    level endon(#"hash_62ab67ff");
    wait 0.1;
    if (isdefined(s_struct.active)) {
        return;
    }
    s_struct.active = 1;
    while (true) {
        if (isdefined(s_struct.triggered)) {
            return;
        }
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            e_player = a_players[i];
            dist = distance2d(s_struct.origin, e_player.origin);
            if (dist < radius) {
                level notify(s_struct.script_string);
                s_struct.triggered = 1;
                return;
            }
        }
        wait 0.5;
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x1b9a632e, Offset: 0x31d8
// Size: 0x162
function function_b090c84d() {
    trigger::wait_till("t_lgt_forest_tunnel_02", "targetname");
    exploder::exploder("lgt_forest_tunnel_02");
    playsoundatposition("evt_tunnel_lights_on_01", (2813, -589, -605));
    trigger::wait_till("t_lgt_forest_tunnel_03", "targetname");
    exploder::exploder("lgt_forest_tunnel_03");
    playsoundatposition("evt_tunnel_lights_on_02", (3030, -493, -636));
    trigger::wait_till("t_lgt_forest_tunnel_04", "targetname");
    exploder::exploder("lgt_forest_tunnel_04");
    playsoundatposition("evt_tunnel_lights_on_03", (3651, -641, -620));
    trigger::wait_till("t_lgt_forest_tunnel_05", "targetname");
    exploder::exploder("lgt_forest_tunnel_05");
    playsoundatposition("evt_tunnel_lights_on_04", (3489, -1158, -657));
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xe60c9938, Offset: 0x3348
// Size: 0xba
function function_12c8020a() {
    level thread scene::play("p7_fxanim_gp_wire_thick_01_bundle");
    exploder::exploder("lgt_forest_tunnel_01");
    trigger::wait_till("cave_entrance", "targetname");
    playsoundatposition("evt_tunnel_lights_on_01", (2438, 63, -644));
    objectives::complete("cp_waypoint_breadcrumb");
    level thread function_b090c84d();
    level waittill(#"hash_5d80c772");
    scene::stop("p7_fxanim_gp_wire_thick_01_bundle");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x7b94887f, Offset: 0x3410
// Size: 0x92
function function_97f6881() {
    level dialog::function_13b3b16a("plyr_why_are_we_here_sar_0", 1);
    infection_util::function_637cd603();
    level dialog::remote("hall_don_t_you_know_0", 1, "NO_DNI");
    infection_util::function_637cd603();
    level dialog::remote("hall_so_much_suffering_s_0", 1, "NO_DNI");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x67aa027, Offset: 0x34b0
// Size: 0x62
function function_caee3551() {
    level waittill(#"hash_973240bd");
    level dialog::function_13b3b16a("plyr_what_the_hell_2", 0.5);
    infection_util::function_637cd603();
    level dialog::remote("hall_the_dire_wolves_a_0", 0, "NO_DNI");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xb38d09c9, Offset: 0x3520
// Size: 0x6a
function function_4e7bce99() {
    level endon(#"hash_fcccf4c9");
    trigger::wait_till("t_ending_dogs");
    level dialog::say("corv_listen_only_to_the_s_0");
    level dialog::say("corv_let_your_mind_relax_0");
    level dialog::say("corv_imagine_yourself_in_0");
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0x5f6274e8, Offset: 0x3598
// Size: 0x6f
function function_5f558686(a_ents) {
    var_dc5e890e = a_ents["sarah"];
    var_dc5e890e setteam("allies");
    e_player = infection_util::function_586b8f7b(a_ents["sarah"].origin);
    var_dc5e890e waittill(#"hash_b5d56b2c");
    level notify(#"hash_b5d56b2c");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x3afad367, Offset: 0x3610
// Size: 0xa9
function function_7c54e6ee() {
    e_trigger = getent("t_runner_before_pit", "targetname");
    e_trigger waittill(#"trigger");
    var_215f11e1 = getentarray("sp_runner_before_pit", "targetname");
    for (i = 0; i < var_215f11e1.size; i++) {
        spawner::simple_spawn_single(var_215f11e1[i], &function_e372c0cc, 0);
        util::wait_network_frame();
    }
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0x1abbb485, Offset: 0x36c8
// Size: 0x42
function function_e372c0cc(var_fdd83dd8) {
    self endon(#"death");
    self.goalradius = 94;
    self waittill(#"goal");
    if (!(isdefined(var_fdd83dd8) && var_fdd83dd8)) {
        self.goalradius = 1024;
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xc0552460, Offset: 0x3718
// Size: 0x52
function function_c6b52615() {
    if (isdefined(self.script_noteworthy) && self.script_string == "fall_to_death") {
        self.ignoreall = 1;
        self.goalradius = 64;
        debug_line(self);
        return;
    }
    self thread infection_util::function_b86426b1();
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xb8a1cc24, Offset: 0x3778
// Size: 0xea
function function_7b0c81e4() {
    level.var_9b646a7c = 400;
    level.var_59ce54fe = 1000;
    level thread function_1032e35f();
    e_trigger = getent("wolves_attack_in_trench", "targetname");
    e_trigger waittill(#"trigger");
    level notify(#"hash_bc20f93d");
    level thread function_caee3551();
    level thread function_b3ec6692();
    level thread function_74df0f52();
    level thread function_94a91f66();
    level thread function_bbfdb42e();
    level thread function_ded57b7b();
    level thread function_feeec702();
    level thread function_3f16df71();
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xfe7c8e6a, Offset: 0x3870
// Size: 0x4a
function function_74df0f52() {
    level thread scene::play("cin_inf_07_02_worldfallsaway_vign_direwolf_entrance");
    level thread scene::play("cin_inf_07_02_worldfallsaway_vign_direwolf_entrance_bunker");
    level thread scene::init("dude_getting_eaten_in_trench");
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0x57a14739, Offset: 0x38c8
// Size: 0x142
function function_6d6d7d71(a_ents) {
    var_75443889 = a_ents["dude_getting_eaten"];
    var_75443889.ignoreme = 1;
    var_75443889 cybercom::function_59965309("cybercom_fireflyswarm");
    looping = 1;
    while (looping) {
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            dist = distance(self.origin, a_players[i].origin);
            if (dist < 600) {
                looping = 0;
                break;
            }
        }
        var_2da301ea = a_ents["intro_wolf_eating_1"];
        var_7a08781 = a_ents["intro_wolf_eating_2"];
        if (!isalive(var_2da301ea) || !isalive(var_7a08781)) {
            looping = 0;
            break;
        }
        wait 0.05;
    }
    level thread scene::play(self.targetname);
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xdef677bb, Offset: 0x3a18
// Size: 0xab
function function_94a91f66() {
    var_f02d4245 = struct::get_array("wolf_intro_howl_struct", "targetname");
    level notify(#"hash_973240bd");
    foreach (struct in var_f02d4245) {
        playsoundatposition("aml_dire_wolf_howl", struct.origin);
        wait 0.25;
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xd40707f3, Offset: 0x3ad0
// Size: 0x82
function function_c1fecd2() {
    a_spawners = getentarray("trench_dogs_coop", "targetname");
    for (i = 0; i < a_spawners.size; i++) {
        spawner::simple_spawn_single(a_spawners[i]);
        util::wait_network_frame();
    }
    spawn_manager::enable("sm_trench_dogs_wave2");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x3d6c52f, Offset: 0x3b60
// Size: 0x4a
function function_bbfdb42e() {
    e_trigger = getent("t_jumping_dogs_after_trench", "targetname");
    e_trigger waittill(#"trigger");
    spawn_manager::enable("sm_dogs_left_side");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x8afa454d, Offset: 0x3bb8
// Size: 0x4a
function function_ded57b7b() {
    e_trigger = getent("t_jumping_dogs_after_trench", "targetname");
    e_trigger waittill(#"trigger");
    spawn_manager::enable("sm_dogs_right_side");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x709181a6, Offset: 0x3c10
// Size: 0xea
function function_feeec702() {
    level endon(#"world_falls_away_ravine_start");
    level thread function_c0aa5a1d();
    level thread function_4014524e();
    while (true) {
        if (isdefined(level.var_f6c9b8d) && level.var_f6c9b8d && isdefined(level.var_efe7c3d0)) {
            break;
        }
        wait 0.05;
    }
    while (true) {
        time = gettime();
        dt = (time - level.var_efe7c3d0) / 1000;
        if (dt > 5) {
            break;
        }
        wait 0.05;
    }
    level notify(#"hash_119eb2e2");
    level notify(#"hash_da1fa42e");
    level.var_9b646a7c = -6;
    level.var_59ce54fe = 600;
    spawn_manager::enable("sm_ending_dogs_left");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x90c95a64, Offset: 0x3d08
// Size: 0x2a
function function_3f16df71() {
    level endon(#"world_falls_away_ravine_start");
    level waittill(#"hash_da1fa42e");
    spawn_manager::enable("sm_ending_dogs_right");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x4794175e, Offset: 0x3d40
// Size: 0x3e
function function_c0aa5a1d() {
    e_trigger = getent("t_ending_dogs", "targetname");
    e_trigger waittill(#"trigger");
    level.var_f6c9b8d = 1;
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xc27ef0f1, Offset: 0x3d88
// Size: 0x165
function function_4014524e() {
    s_struct = struct::get("s_turn_off_eyecandy_wolves", "targetname");
    v_forward = anglestoforward(s_struct.angles);
    while (true) {
        if (spawn_manager::is_complete("sm_dogs_left_side") && spawn_manager::is_complete("sm_dogs_right_side")) {
            if (!isdefined(level.var_efe7c3d0)) {
                level.var_efe7c3d0 = gettime();
            }
            a_players = getplayers();
            var_a540aa3f = 0;
            for (i = 0; i < a_players.size; i++) {
                e_player = a_players[i];
                v_dir = e_player.origin - s_struct.origin;
                v_dir = vectornormalize(v_dir);
                dp = vectordot(v_dir, v_forward);
                if (dp > 0.2) {
                    var_a540aa3f++;
                }
            }
            if (var_a540aa3f == a_players.size) {
                break;
            }
        }
        wait 0.05;
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x5624100e, Offset: 0x3ef8
// Size: 0x142
function function_21caff3e() {
    self endon(#"death");
    if (!isdefined(level.var_9b646a7c)) {
        return;
    }
    self.overrideactordamage = &function_8e74fa1d;
    if (!(isdefined(self.script_noteworthy) && self.script_noteworthy == "no_audio")) {
        playsoundatposition("aml_dire_wolf_howl", self.origin);
        self thread infection_util::zmbaivox_notifyconvert();
    }
    initial_delay = 0;
    if (isdefined(self.script_string) && self.script_string == "sprinter") {
        self ai::set_behavior_attribute("sprint", 1);
        return;
    }
    if (isdefined(self.script_string) && self.script_string == "stalker") {
        initial_delay = randomintrange(6, 12);
    }
    dist = randomintrange(level.var_9b646a7c, level.var_59ce54fe);
    if (isdefined(self.script_float)) {
        dist = self.script_float;
    }
    self thread function_64eb5e51(initial_delay, dist);
}

// Namespace forest_surreal
// Params 12, eflags: 0x0
// Checksum 0x9b6c37db, Offset: 0x4048
// Size: 0x83
function function_8e74fa1d(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
    if (isdefined(eattacker) && !isplayer(eattacker)) {
        idamage = 0;
    }
    return idamage;
}

// Namespace forest_surreal
// Params 2, eflags: 0x0
// Checksum 0x256d8163, Offset: 0x40d8
// Size: 0xa3
function function_64eb5e51(initial_delay, var_8b419c2c) {
    self endon(#"death");
    self endon(#"hash_a25de9d9");
    if (isdefined(initial_delay)) {
        wait initial_delay;
    }
    while (true) {
        dist = function_5eb85ef8(self.origin);
        if (dist < var_8b419c2c) {
            self ai::set_behavior_attribute("sprint", 1);
            return;
        }
        delay = randomfloatrange(0, 1);
        wait delay;
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x70db951b, Offset: 0x4188
// Size: 0xb1
function function_76ecbe6c() {
    level.var_b7fd3339 = 0;
    var_215f11e1 = getentarray("sp_enemy_trench", "targetname");
    for (i = 0; i < var_215f11e1.size; i++) {
        e_ent = spawner::simple_spawn_single(var_215f11e1[i]);
        e_ent.name = "";
        e_ent thread function_e372c0cc(1);
        e_ent thread function_d0e3a59f();
        e_ent.goalradius = 64;
        util::wait_network_frame();
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xfe76853b, Offset: 0x4248
// Size: 0x12
function function_d0e3a59f() {
    self waittill(#"death");
    level.var_b7fd3339++;
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0xa8c1b949, Offset: 0x4268
// Size: 0x8b
function function_5eb85ef8(pos) {
    closest = 999999;
    a_players = getplayers();
    for (i = 0; i < a_players.size; i++) {
        dist = distance(a_players[i].origin, pos);
        if (dist < closest) {
            closest = dist;
        }
    }
    return closest;
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0x7ed2b5ce, Offset: 0x4300
// Size: 0x12b
function function_13e4875f(var_3d9a88e4) {
    var_6c6c766a = 1000;
    v_pos = self.origin;
    v_forward = vectornormalize(anglestoforward(self.angles));
    if (var_3d9a88e4) {
        v_pos = (v_pos[0], v_pos[1], 0);
    }
    a_players = getplayers();
    for (i = 0; i < a_players.size; i++) {
        player_origin = a_players[i].origin;
        if (var_3d9a88e4) {
            player_origin = (player_origin[0], player_origin[1], 0);
        }
        v_dir = vectornormalize(player_origin - v_pos);
        dp = vectordot(v_forward, v_dir);
        if (dp < var_6c6c766a) {
            var_6c6c766a = dp;
        }
    }
    return var_6c6c766a;
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x911c6b01, Offset: 0x4438
// Size: 0x42
function function_b3ec6692() {
    start_pos = struct::get_array("dog_eyecandy_startpath");
    array::thread_all(start_pos, &function_b51d137e);
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xf5e537ce, Offset: 0x4488
// Size: 0xd3
function function_b51d137e() {
    level endon(#"world_falls_away_ravine_start");
    level endon(#"hash_787c5631");
    level endon(#"hash_119eb2e2");
    while (true) {
        dog_spawner = getent("sp_eyecandy_wolf", "targetname");
        wolf = spawner::simple_spawn_single(dog_spawner);
        wolf thread function_29f6ad78(self);
        if (isdefined(self.script_vector)) {
            delay = randomfloatrange(self.script_vector[0], self.script_vector[1]);
        } else {
            delay = randomfloatrange(53, 55);
        }
        wait delay;
    }
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0xfa2fb536, Offset: 0x4568
// Size: 0x172
function function_29f6ad78(s_path) {
    self endon(#"death");
    if (!isdefined(level.var_663306c5)) {
        level.var_663306c5 = 0;
    }
    self notify(#"hash_a25de9d9");
    self thread function_be227518(level.var_663306c5, 15);
    level.var_663306c5 += 1;
    if (level.var_663306c5 > 6) {
        level.var_663306c5 = 0;
    }
    self.goalradius = 32;
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    while (true) {
        if (!s_path infection_util::player_can_see_me(50)) {
            break;
        }
        wait 0.25;
    }
    self forceteleport(s_path.origin, s_path.angles);
    next_pos = s_path;
    while (true) {
        if (isdefined(next_pos.target)) {
            next_pos = struct::get(next_pos.target, "targetname");
        } else {
            break;
        }
        self setgoalpos(next_pos.origin, 1, 32);
        self waittill(#"goal");
    }
    self delete();
}

// Namespace forest_surreal
// Params 2, eflags: 0x0
// Checksum 0xb3bef290, Offset: 0x46e8
// Size: 0x92
function function_be227518(delay, var_741adebb) {
    self endon(#"death");
    start_time = gettime();
    wait delay;
    self ai::set_behavior_attribute("sprint", 1);
    while (true) {
        time = gettime();
        dt = (time - start_time) / 1000;
        if (dt > var_741adebb) {
            break;
        }
        wait 0.1;
    }
    self delete();
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x7fd5884f, Offset: 0x4788
// Size: 0x1a
function function_1032e35f() {
    level.is_player_valid_override = &function_b0e703cd;
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0x397d4a21, Offset: 0x47b0
// Size: 0x36
function function_b0e703cd(player) {
    a_spawners = getentarray("sp_enemy_trench", "targetname");
    return true;
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x6aff9516, Offset: 0x47f0
// Size: 0x11a
function function_32a538b9() {
    objectives::set("cp_level_infection_gather_ravine", self);
    self thread scene::init("cin_inf_07_03_worldfallsaway_vign_pain", self);
    level notify(#"hash_32a538b9");
    trigger::wait_till("world_falls_away_ravine_start");
    level notify(#"hash_fcccf4c9");
    if (isdefined(level.var_c30ca873)) {
        level thread [[ level.var_c30ca873 ]]();
    }
    objectives::complete("cp_level_infection_gather_ravine", self);
    self thread scene::play("cin_inf_07_03_worldfallsaway_vign_pain", self);
    namespace_f25bd8c8::function_a2179c84();
    namespace_f25bd8c8::function_74b401d8();
    namespace_f25bd8c8::function_b3cf52bf();
    level waittill(#"hash_f9d3621d");
    self thread infection_util::function_9110a277(1);
    self.var_5d21e1c9 = 0;
    self waittill(#"scene_done");
    self delete();
    level.var_63a5e024 = 1;
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xe2289a53, Offset: 0x4918
// Size: 0x7a
function function_80ea1787() {
    level flag::init("chasm_open");
    level waittill(#"hash_32a538b9");
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    trigger::wait_till("world_falls_away_ravine_start");
    level notify(#"world_falls_away_ravine_start");
    level thread function_6431cdb6();
    function_66e4f276();
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xf499cfdc, Offset: 0x49a0
// Size: 0x1e2
function function_66e4f276() {
    level waittill(#"hash_b5d56b2c");
    level thread function_e6cc7e28();
    level util::clientnotify("chasm_wind");
    playsoundatposition("evt_pullapart_world", (0, 0, 0));
    level thread function_8c0b59c6();
    exploder::exploder("light_wfa_end");
    var_d8d55e31 = getentarray("world_falls_away_chasm", "targetname");
    assert(isdefined(var_d8d55e31), "<dev string:x5e>");
    level thread function_d135cab9(12, 5, 5);
    for (i = 0; i < var_d8d55e31.size; i++) {
        str_name = var_d8d55e31[i].target;
        if (isdefined(str_name)) {
            s_struct = struct::get(str_name, "targetname");
            target_position = s_struct.origin;
            var_d8d55e31[i] setmovingplatformenabled(1);
            var_d8d55e31[i] moveto(target_position, 12, 5, 5);
        }
    }
    var_d8d55e31[0] waittill(#"movedone");
    var_d8d55e31[0] playloopsound("evt_pullapart_world_looper", 3);
    level thread function_12c8020a();
    level flag::set("chasm_open");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x2311a04b, Offset: 0x4b90
// Size: 0x1aa
function function_8c0b59c6() {
    var_aba57974 = struct::get("chasm_earthquake_start_struct", "targetname");
    assert(isdefined(var_aba57974), "<dev string:x87>");
    var_d8d55e31 = getentarray("world_falls_away_chasm", "targetname");
    assert(isdefined(var_d8d55e31), "<dev string:xbe>");
    var_b35a0c4d = var_d8d55e31[0];
    var_be1f149f = spawn("script_origin", var_aba57974.origin);
    var_be1f149f linkto(var_b35a0c4d);
    while (!level flag::get("chasm_open")) {
        earthquake(0.18, 0.05 * 4, var_be1f149f.origin, 3000);
        infection_util::function_7b8c138f(var_be1f149f, 3000, 2);
        playrumbleonposition("cp_infection_world_falls_break_rumble", var_be1f149f.origin);
        wait 0.05;
    }
    earthquake(0.25, 2, var_be1f149f.origin, 3000);
    var_be1f149f delete();
}

// Namespace forest_surreal
// Params 3, eflags: 0x0
// Checksum 0xc8d4b711, Offset: 0x4d48
// Size: 0xaa
function function_d135cab9(move_time, accel_time, decel_time) {
    e_ent = getent("world_falls_away_chasm_blocker", "targetname");
    s_struct = struct::get(e_ent.target, "targetname");
    e_ent moveto(s_struct.origin, move_time, accel_time, decel_time);
    e_ent waittill(#"movedone");
    e_ent delete();
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0x50ced728, Offset: 0x4e00
// Size: 0x3da
function function_e6cc7e28(b_skip) {
    if (!isdefined(b_skip)) {
        b_skip = 0;
    }
    scene::add_scene_func("p7_fxanim_cp_infection_rock_mountain_bundle", &function_2e0c5214, "play");
    if (b_skip) {
        level scene::skipto_end("p7_fxanim_cp_infection_rock_mountain_bundle");
        level scene::skipto_end("p7_fxanim_cp_infection_rock_bridge_floaters_bundle");
        level scene::skipto_end("p7_fxanim_cp_infection_rock_bridge_p1_bundle");
        level scene::skipto_end("p7_fxanim_cp_infection_rock_bridge_p2_bundle");
        level scene::skipto_end("p7_fxanim_cp_infection_rock_bridge_p3_bundle");
        exploder::exploder("worldfallsaway_cave_separating");
        var_be2ea7e9 = spawn("script_origin", (938, -123, -648));
        var_be2ea7e9 playloopsound("evt_rock_bridge_loop", 0.5);
    } else {
        level thread scene::play("p7_fxanim_cp_infection_rock_mountain_bundle");
        level thread scene::play("p7_fxanim_cp_infection_rock_bridge_floaters_bundle");
        exploder::exploder("worldfallsaway_cave_separating");
        level thread scene::play("p7_fxanim_cp_infection_rock_bridge_p1_bundle");
        level thread scene::play("p7_fxanim_cp_infection_rock_bridge_p2_bundle");
        scene::play("p7_fxanim_cp_infection_rock_bridge_p3_bundle");
        var_be2ea7e9 = spawn("script_origin", (938, -123, -648));
        var_be2ea7e9 playloopsound("evt_rock_bridge_loop", 0.5);
        wait 0.5;
    }
    objectives::set("cp_level_infection_cross_chasm");
    level thread objectives::breadcrumb("cave_entrance");
    var_c1b53c54 = getentarray("chasm_entrance_player_clip", "targetname");
    array::run_all(var_c1b53c54, &delete);
    foreach (player in level.players) {
        player thread function_baefbe37();
    }
    infection_util::function_9d611fab("s_ravine_drop_marker_p3");
    level notify(#"hash_7303e8be");
    level notify(#"end_salm_forest_dialog");
    level thread scene::play("p7_fxanim_cp_infection_rock_bridge_p3_end_bundle");
    level thread function_43a1f475("rock_bridge_p3");
    wait 0.5;
    level thread scene::play("p7_fxanim_cp_infection_rock_bridge_p2_end_bundle");
    level thread function_43a1f475("rock_bridge_p2");
    wait 0.5;
    level thread scene::play("p7_fxanim_cp_infection_rock_bridge_p1_end_bundle");
    level thread function_43a1f475("rock_bridge_p1");
    var_be2ea7e9 stoploopsound(0.5);
    var_be2ea7e9 delete();
    level waittill(#"hash_5d80c772");
    level thread scene::stop("p7_fxanim_cp_infection_rock_bridge_floaters_bundle");
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0x4feb2ad2, Offset: 0x51e8
// Size: 0x10a
function function_43a1f475(str_rock) {
    mdl_rock = getent(str_rock, "targetname");
    var_9636be2f = getentarray(str_rock + "_clip", "targetname");
    var_7b12f4c7 = strtok(str_rock, "rock_bridge_p");
    var_8f915eab = "platform_" + var_7b12f4c7[0] + "_jnt";
    array::run_all(var_9636be2f, &linkto, mdl_rock, var_8f915eab);
    if (isdefined(mdl_rock._o_scene)) {
        mdl_rock._o_scene._e_root util::waittill_notify_or_timeout("scene_done", 10);
    }
    array::run_all(var_9636be2f, &delete);
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xcf1548b3, Offset: 0x5300
// Size: 0x95
function function_baefbe37() {
    self endon(#"death");
    level endon(#"hash_7303e8be");
    s_destination = struct::get("s_cave_entrance", "targetname");
    while (true) {
        wait 3;
        if (!self infection_util::function_72268bc2(s_destination, 0.1)) {
            level thread objectives::show("cp_waypoint_breadcrumb", self);
            continue;
        }
        level thread objectives::hide("cp_waypoint_breadcrumb", self);
    }
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0x3437e70, Offset: 0x53a0
// Size: 0x5a
function function_2e0c5214(a_ents) {
    e_effect = a_ents["rock_mountain"];
    e_rock = getent("final_position_3", "target");
    e_effect linkto(e_rock);
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xcf7b947f, Offset: 0x5408
// Size: 0xb1
function function_6431cdb6() {
    if (!spawn_manager::is_complete("sm_ending_dogs_left")) {
        spawn_manager::disable("sm_ending_dogs_left");
    }
    if (!spawn_manager::is_complete("sm_ending_dogs_right")) {
        spawn_manager::disable("sm_ending_dogs_right");
    }
    a_ai = getaiteamarray("team3");
    for (i = 0; i < a_ai.size; i++) {
        a_ai[i] kill();
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xd08199b8, Offset: 0x54c8
// Size: 0xa2
function function_f4ab002c() {
    trigger = getent("black_station_start_trigger", "targetname");
    trigger waittill(#"trigger", who);
    util::screen_fade_out(1, "black");
    level notify(#"end_salm_forest_dialog");
    level notify(#"hash_82ddc1bc");
    var_d8d55e31 = getentarray("world_falls_away_chasm", "targetname");
    var_d8d55e31[0] stoploopsound(5);
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xa78e0883, Offset: 0x5578
// Size: 0x82
function function_1120dd46() {
    level thread function_4db909ec("t_world_falls_away_intro", "world_falls_away_intro_falling_guys");
    level thread function_4db909ec("sm_world_falls_away_middle", "world_falls_away_middle_falling_guys");
    level thread function_4db909ec("t_left_side_fallers_1", "world_falls_away_left_1_falling_guys");
    level thread function_4db909ec("t_left_side_fallers_1", "wfa_middle_path_falling_guys");
}

// Namespace forest_surreal
// Params 2, eflags: 0x0
// Checksum 0x7035fd27, Offset: 0x5608
// Size: 0x141
function function_4db909ec(str_trigger, var_a9ea049a) {
    e_trigger = getent(str_trigger, "targetname");
    if (isdefined(e_trigger)) {
        e_trigger waittill(#"trigger");
        a_spawners = getentarray(var_a9ea049a, "targetname");
        for (i = 0; i < a_spawners.size; i++) {
            s_struct = struct::get(a_spawners[i].script_string, "script_noteworthy");
            var_ec70521 = s_struct.moving_platform;
            if (isdefined(var_ec70521) && !var_ec70521.var_efe20130) {
                e_ent = spawner::simple_spawn_single(a_spawners[i], &function_eaa02a0f);
                infection_util::function_426fde37(e_ent, "FALLING_GUYS");
                util::wait_network_frame();
                continue;
            }
            /#
                iprintlnbold("<dev string:xe9>");
            #/
        }
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xc1099c67, Offset: 0x5758
// Size: 0x1e2
function function_eaa02a0f() {
    self endon(#"death");
    if (isdefined(self.radius)) {
        self.goalradius = self.radius;
    }
    if (isdefined(self.script_noteworthy) && issubstr(self.script_noteworthy, "cin_")) {
        self.goalradius = 64;
        var_bc98b3ec = self.script_noteworthy;
    }
    if (isdefined(self.target)) {
        self thread function_8d96a449();
    }
    s_struct = struct::get(self.script_string, "script_noteworthy");
    var_ec70521 = s_struct.moving_platform;
    if (isdefined(var_ec70521)) {
        var_ec70521 waittill(#"hash_6db7529d");
        self.ignoreall = 1;
        wait var_ec70521.var_385072d7;
        if (true) {
            if (isdefined(var_bc98b3ec)) {
                wait 0.2;
                self thread scene::play(var_bc98b3ec, self);
                wait 1.2;
                self kill();
                return;
            }
        }
        var_f54739c6 = function_ca0fce6a();
        if (true) {
            self thread scene::play(var_f54739c6, self);
        }
        var_ec70521 waittill(#"hash_89c47e3d");
        if (true) {
            self scene::stop(var_f54739c6);
        }
        if (true) {
            if (!isdefined(level.var_fddc24b0)) {
                function_bd957f29();
            }
            str_anim = function_3f85f0b6();
            scene::play(str_anim, self);
        } else {
            wait 5;
        }
    }
    self delete();
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x5107ee9d, Offset: 0x5948
// Size: 0xd4
function function_ca0fce6a() {
    if (!isdefined(level.var_981a94f3)) {
        level.var_981a94f3 = 0;
    }
    switch (level.var_981a94f3) {
    case 0:
        str_animation = "cin_gen_vign_offbalance_a";
        break;
    case 1:
        str_animation = "cin_gen_vign_offbalance_b";
        break;
    case 2:
        str_animation = "cin_gen_vign_offbalance";
        break;
    case 3:
        str_animation = "cin_gen_vign_offbalance_left";
        break;
    case 4:
        str_animation = "cin_gen_vign_offbalance_right";
        break;
    case 5:
    default:
        str_animation = "cin_gen_vign_offbalance_center";
        break;
    }
    level.var_981a94f3++;
    if (level.var_981a94f3 > 1) {
        level.var_981a94f3 = 0;
    }
    return str_animation;
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xfcdbaf8d, Offset: 0x5a28
// Size: 0x20
function function_8d96a449() {
    self endon(#"death");
    self.goalradius = 64;
    self waittill(#"goal");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x43ea3bfb, Offset: 0x5a50
// Size: 0xe3
function function_bd957f29() {
    level.var_7506ce6e = 0;
    level.var_12d36490 = [];
    if (!isdefined(level.var_12d36490)) {
        level.var_12d36490 = [];
    } else if (!isarray(level.var_12d36490)) {
        level.var_12d36490 = array(level.var_12d36490);
    }
    level.var_12d36490[level.var_12d36490.size] = "cin_gen_vign_fall_left";
    if (!isdefined(level.var_12d36490)) {
        level.var_12d36490 = [];
    } else if (!isarray(level.var_12d36490)) {
        level.var_12d36490 = array(level.var_12d36490);
    }
    level.var_12d36490[level.var_12d36490.size] = "cin_gen_vign_fall_right";
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xcee40efd, Offset: 0x5b40
// Size: 0x44
function function_3f85f0b6() {
    str_anim = level.var_12d36490[level.var_7506ce6e];
    level.var_7506ce6e++;
    if (level.var_7506ce6e >= level.var_12d36490.size) {
        level.var_7506ce6e = 0;
    }
    return str_anim;
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x5fd38942, Offset: 0x5b90
// Size: 0x4a
function function_203e4c9c() {
    e_trigger = getent("t_move_1st_falling_guys", "targetname");
    e_trigger waittill(#"trigger");
    spawn_manager::enable("sm_world_falls_away_intro");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xa51dd54a, Offset: 0x5be8
// Size: 0x5a
function function_ba7fed00() {
    self endon(#"death");
    if (isdefined(self.script_noteworthy)) {
        self.goalradius = 48;
        n_node = getnode(self.script_noteworthy, "targetname");
        self setgoal(n_node.origin);
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xda5742a6, Offset: 0x5c50
// Size: 0x4a
function function_df55595f() {
    e_trigger = getent("t_wfa_middle_path", "targetname");
    e_trigger waittill(#"trigger");
    spawn_manager::enable("sm_wfa_middle_path");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x5659dc8c, Offset: 0x5ca8
// Size: 0x162
function function_483493cf() {
    var_d9e81f75 = "p7_fxanim_cp_infection_world_falling_116_bundle";
    var_ffea99de = "p7_fxanim_cp_infection_world_falling_117_bundle";
    var_25ed1447 = "p7_fxanim_cp_infection_world_falling_132_bundle";
    level thread scene::init(var_d9e81f75);
    util::wait_network_frame();
    level thread scene::init(var_ffea99de);
    util::wait_network_frame();
    level thread scene::init(var_25ed1447);
    e_trigger = getent("t_fancy_falling_pieces_at_start", "targetname");
    e_trigger waittill(#"trigger");
    s_struct = struct::get("s_fancy_falling_pieces_at_start", "targetname");
    var_6e456024 = s_struct.origin;
    level thread function_a44c8b8c(var_6e456024, 0, 1);
    if (isdefined(level.var_90ce01fb)) {
        level thread [[ level.var_90ce01fb ]]();
    }
    level thread scene::play(var_d9e81f75);
    wait 0.75;
    level thread scene::play(var_ffea99de);
    wait 1.25;
    level thread scene::play(var_25ed1447);
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x3759398, Offset: 0x5e18
// Size: 0x32
function function_59de9d07() {
    function_dbd2f56e();
    level waittill(#"hash_bc20f93d");
    infection_util::function_b016b536("FALLING_GUYS", 1);
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x310baeb, Offset: 0x5e58
// Size: 0x2a
function function_e15b5dc7() {
    level thread function_26a859a();
    level waittill(#"hash_82ddc1bc");
    level thread function_82ddc1bc();
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x8457b341, Offset: 0x5e90
// Size: 0x18b
function function_dbd2f56e() {
    colors::kill_color_replacements();
    a_allies = getaiteamarray("allies");
    foreach (ai in a_allies) {
        if (isdefined(ai.targetname)) {
            if (issubstr(ai.targetname, "friendly_guys_bastogne_")) {
                ai thread function_95040800(512);
            }
        }
    }
    var_addf374e = getaiteamarray("axis");
    foreach (ai in var_addf374e) {
        if (isdefined(ai.targetname)) {
            if (issubstr(ai.targetname, "reverse_anim_") || issubstr(ai.targetname, "sm_bastogne_reinforcements_")) {
                ai thread function_95040800(1024);
            }
        }
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x6701f559, Offset: 0x6028
// Size: 0x1d9
function function_26a859a() {
    a_ai = getaiteamarray("axis");
    if (isdefined(a_ai)) {
        if (a_ai.size > 0) {
            var_1152223f = infection_util::function_9e5ed1ac(a_ai);
            var_98e1d684 = var_1152223f.size - 0;
            for (i = 0; i < var_98e1d684; i++) {
                n_index = var_1152223f.size - 1 - i;
                var_1152223f[n_index] util::stop_magic_bullet_shield();
                var_1152223f[n_index] thread function_95040800(512);
            }
        }
    }
    var_912ac17e = getent("world_falls_apart_soldier_kill_volume", "targetname");
    a_ai = getaiteamarray("axis");
    if (isdefined(a_ai)) {
        for (i = 0; i < a_ai.size; i++) {
            if (a_ai[i] istouching(var_912ac17e)) {
                a_ai[i].ignoreme = 1;
            }
        }
    }
    e_trigger = getent("t_jumping_dogs_after_trench", "targetname");
    e_trigger waittill(#"trigger");
    a_ai = getaiteamarray("axis");
    if (isdefined(a_ai)) {
        for (i = 0; i < a_ai.size; i++) {
            if (a_ai[i] istouching(var_912ac17e)) {
                a_ai[i] thread function_95040800(512);
            }
        }
    }
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xa77fd673, Offset: 0x6210
// Size: 0x52
function function_82ddc1bc() {
    infection_util::function_aa0ddbc3(0);
    infection_util::function_3ea445de();
    infection_util::function_674ecd85();
    infection_util::function_b32291d7("reverse_anim_trigger", "script_noteworthy");
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xe3ef5dd1, Offset: 0x6270
// Size: 0x7a
function function_56b28f61() {
    scene::add_scene_func("cin_gen_vign_fall_fall", &function_a2c7b004, "play");
    var_c917e48d = struct::get_array("hanging_on_ledge_dude", "targetname");
    level thread array::spread_all(var_c917e48d, &function_a9e95fee);
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x752fc70c, Offset: 0x62f8
// Size: 0x52
function function_a9e95fee() {
    level endon(#"hash_bc20f93d");
    level waittill(self.script_string);
    buffer_time = 2;
    wait 2.7 + buffer_time;
    if (isdefined(self.script_delay)) {
        wait self.script_delay;
    }
    self scene::play();
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0xee9e5d9e, Offset: 0x6358
// Size: 0x4a
function function_e8d77ec8() {
    var_c917e48d = struct::get_array("hanging_on_ledge_dude_background", "targetname");
    level thread array::spread_all(var_c917e48d, &function_7daee669);
}

// Namespace forest_surreal
// Params 0, eflags: 0x0
// Checksum 0x78b42eeb, Offset: 0x63b0
// Size: 0x6a
function function_7daee669() {
    level endon(#"hash_bc20f93d");
    var_fcf5da5e = getent(self.target, "targetname");
    var_fcf5da5e waittill(#"trigger", player);
    if (isdefined(self.script_delay)) {
        wait self.script_delay;
    }
    self scene::play();
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0x23ecfdfc, Offset: 0x6428
// Size: 0xa
function function_a2c7b004(a_ents) {
    
}

// Namespace forest_surreal
// Params 1, eflags: 0x0
// Checksum 0xc8228f2d, Offset: 0x6440
// Size: 0x75
function debug_line(e_ent) {
    e_ent endon(#"death");
    while (true) {
        v_start = e_ent.origin;
        v_end = v_start + (0, 0, 1000);
        v_col = (1, 1, 1);
        /#
            line(v_start, v_end, v_col);
        #/
        wait 0.1;
    }
}

