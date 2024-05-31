#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_root_cinematics;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/gametypes/_save;
#using scripts/codescripts/struct;

#namespace namespace_6a04e6cd;

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_d290ebfa
// Checksum 0xcee10a82, Offset: 0xbe0
// Size: 0xd4
function main() {
    init_clientfields();
    var_b2a6f229 = getentarray("root_zurich_spawners", "script_noteworthy");
    array::thread_all(var_b2a6f229, &spawner::add_spawn_function, &util::function_65ba133d);
    var_603657ba = getentarray("root_zurich_robot_spawners", "script_noteworthy");
    array::thread_all(var_603657ba, &spawner::add_spawn_function, &namespace_8e9083ff::function_d8c91e6b);
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_2ea898a8
// Checksum 0x3211216d, Offset: 0xcc0
// Size: 0x124
function init_clientfields() {
    clientfield::register("scriptmover", "zurich_snow_rise", 1, 1, "counter");
    clientfield::register("toplayer", "reflection_extracam", 1, 1, "int");
    clientfield::register("toplayer", "zurich_vinewall_init", 1, 1, "int");
    clientfield::register("world", "root_vine_cleanup", 1, 1, "counter");
    clientfield::register("toplayer", "mirror_break", 1, 1, "int");
    clientfield::register("scriptmover", "mirror_warp", 1, 1, "int");
}

// Namespace namespace_6a04e6cd
// Params 2, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_9c1fc2fd
// Checksum 0xf51f0584, Offset: 0xdf0
// Size: 0x2e4
function function_9c1fc2fd(str_objective, var_74cd64bc) {
    load::function_73adcefc();
    if (var_74cd64bc) {
        level util::screen_fade_out(0);
    }
    level scene::init("cin_zur_12_01_root_1st_mirror_01");
    if (isdefined(level.var_405a73a5)) {
        level thread [[ level.var_405a73a5 ]]();
    }
    var_4ccf970 = namespace_8e9083ff::function_a00fa665(str_objective);
    exploder::exploder("zurich_lightning_exp");
    namespace_8e9083ff::function_4d032f25(1, 0.5);
    spawner::add_spawn_function_group("raven_ambush_ai", "script_parameters", &namespace_8e9083ff::function_aceff870);
    level thread function_2d897f84(str_objective);
    level thread function_187dfb55();
    level thread function_8182f3c5();
    level thread function_9831305d();
    load::function_a2995f22();
    skipto::teleport_players(str_objective, 1);
    array::thread_all(level.players, &util::function_df6eb506, 1);
    array::thread_all(level.players, &clientfield::set_to_player, "zurich_vinewall_init", 1);
    level namespace_8e9083ff::function_b0f0dd1f(1, "light_snow");
    level thread function_aa95075d(str_objective);
    level thread function_53a7bcca();
    level thread namespace_8e9083ff::function_a03f30f2(str_objective, "root_zurich_vortex", "root_zurich_regroup");
    level thread namespace_8e9083ff::function_dd842585(str_objective, "root_zurich_vortex", "t_root_zurich_vortex");
    level waittill(str_objective + "enter_vortex");
    level thread namespace_67110270::function_973b77f9();
    level thread function_95b88092("root_zurich_vortex", 0);
}

// Namespace namespace_6a04e6cd
// Params 2, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_95b88092
// Checksum 0x1921466e, Offset: 0x10e0
// Size: 0x2c4
function function_95b88092(str_objective, var_74cd64bc) {
    if (isdefined(var_74cd64bc) && var_74cd64bc) {
        load::function_73adcefc();
        load::function_a2995f22();
        skipto::teleport_players(str_objective, 0);
        namespace_8e9083ff::function_4d032f25(1, 0.5);
        foreach (e_player in level.activeplayers) {
            e_player thread util::function_df6eb506(1);
        }
    }
    if (isdefined(level.var_45d30b5a)) {
        level thread [[ level.var_45d30b5a ]]();
    }
    level thread scene::init("zurich_fxanim_heart_ceiling", "targetname");
    exploder::exploder("heartLightsZurich");
    level thread namespace_67110270::function_973b77f9();
    level util::clientnotify("stZURmus");
    level thread function_1ef8526e();
    level namespace_8e9083ff::function_c90e23b6(str_objective);
    level.var_1c26230b thread namespace_8e9083ff::function_fe5160df(1);
    if (level.players === 1) {
        savegame::checkpoint_save();
    }
    var_8fb0849a = namespace_8e9083ff::function_a1851f86(str_objective);
    var_8fb0849a waittill(#"hash_40b1a9d9");
    level thread namespace_bbb4ee72::function_b319df2(str_objective, var_8fb0849a.var_90971f20.e_player);
    if (isdefined(level.var_3e0291d0)) {
        [[ level.var_3e0291d0 ]]();
    }
    videostop("cp_zurich_env_corvusmonitor");
    exploder::stop_exploder("zurich_lightning_exp");
}

// Namespace namespace_6a04e6cd
// Params 4, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_1a4dfaaa
// Checksum 0xaf5b749, Offset: 0x13b0
// Size: 0x132
function function_1a4dfaaa(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level notify(#"hash_c955b42d");
    level namespace_8e9083ff::function_b0f0dd1f(0);
    level clientfield::increment("root_vine_cleanup");
    level thread namespace_8e9083ff::function_4a00a473("root_zurich");
    level util::clientnotify("stp_mus");
    foreach (e_player in level.activeplayers) {
        e_player thread util::function_df6eb506(0);
    }
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_a61dfb7
// Checksum 0xfe09517c, Offset: 0x14f0
// Size: 0x2cc
function function_a61dfb7() {
    level endon(#"hash_1d98ceef");
    level flag::wait_till("flag_monologue_zurich_root_01");
    level dialog::function_13b3b16a("plyr_i_don_t_understand_0", 3);
    level dialog::function_13b3b16a("plyr_talk_to_me_please_0", 3);
    level dialog::function_13b3b16a("plyr_i_don_t_know_what_s_0", 3);
    level dialog::function_13b3b16a("plyr_i_don_t_know_what_to_0", 3);
    level flag::wait_till("flag_monologue_zurich_root_02");
    level dialog::function_13b3b16a("plyr_i_know_corvus_is_ins_0", 3);
    level dialog::function_13b3b16a("plyr_i_know_it_s_trying_t_0", 3);
    level dialog::function_13b3b16a("plyr_i_want_to_get_it_out_0", 3);
    level dialog::function_13b3b16a("plyr_i_have_to_keep_going_0", 3);
    level dialog::function_13b3b16a("plyr_i_have_to_finish_thi_0", 3);
    level flag::wait_till("flag_monologue_zurich_root_03");
    level dialog::function_13b3b16a("plyr_i_m_coming_for_you_c_0", 3);
    level dialog::function_13b3b16a("plyr_you_destroyed_my_tea_0", 3);
    level dialog::function_13b3b16a("plyr_you_destroyed_my_fri_0", 3);
    level dialog::function_13b3b16a("plyr_i_m_going_to_find_yo_0", 3);
    level flag::wait_till("flag_monologue_zurich_root_04");
    level dialog::function_13b3b16a("plyr_do_you_hear_me_0", 3);
    level dialog::function_13b3b16a("plyr_it_doesn_t_matter_wh_0", 3);
    level dialog::function_13b3b16a("plyr_i_will_not_let_go_0", 3);
    level dialog::function_13b3b16a("plyr_do_you_hear_me_i_wi_0", 3);
    level flag::set("flag_monologue_zurich_root_04_done");
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_1ef8526e
// Checksum 0x7c08b7b5, Offset: 0x17c8
// Size: 0x8c
function function_1ef8526e() {
    level endon(#"hash_1d98ceef");
    level flag::wait_till("flag_monologue_zurich_root_04_done");
    level dialog::remote("salm_the_human_mind_holds_0", 4, "NO_DNI");
    level dialog::remote("salm_our_ability_to_analy_0", 1, "NO_DNI");
}

// Namespace namespace_6a04e6cd
// Params 1, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_9dd2872e
// Checksum 0xaffecda8, Offset: 0x1860
// Size: 0xcc
function function_9dd2872e(str_objective) {
    level endon(str_objective + "enter_vortex");
    level notify(#"hash_d3c69346");
    level thread namespace_67110270::function_ff7a72bf();
    level.var_1c26230b dialog::say("tayr_all_this_shit_around_1", 1);
    level.var_1c26230b dialog::say("tayr_corvus_is_messing_wi_0", 1);
    level.var_1c26230b dialog::say("tayr_just_stay_with_me_0", 1);
    level thread function_a61dfb7();
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_53a7bcca
// Checksum 0x3ba2962, Offset: 0x1938
// Size: 0x13a
function function_53a7bcca() {
    e_trig = trigger::wait_till("t_zurichroot_2", "script_noteworthy");
    var_1f6e1fda = getaiteamarray("axis", "team3");
    foreach (ai_enemy in var_1f6e1fda) {
        if (distance(e_trig.who.origin, ai_enemy.origin) > 2000) {
            util::stop_magic_bullet_shield(ai_enemy);
            ai_enemy kill();
        }
    }
}

// Namespace namespace_6a04e6cd
// Params 1, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_aa95075d
// Checksum 0x14b7830d, Offset: 0x1a80
// Size: 0x2bc
function function_aa95075d(str_objective) {
    util::wait_network_frame();
    scene::add_scene_func("p7_fxanim_cp_zurich_mirror_bundle", &function_b8580c84, "init");
    scene::init("p7_fxanim_cp_zurich_mirror_bundle");
    level thread function_c88fe82();
    level thread namespace_67110270::function_973b77f9();
    var_a3612ddd = 0;
    foreach (player in level.players) {
        var_a3612ddd++;
        player thread function_2a895f94(var_a3612ddd);
    }
    level waittill(#"hash_3e3847fd");
    wait(1);
    level thread util::screen_fade_in(1);
    array::thread_all(level.players, &clientfield::increment_to_player, "postfx_transition");
    playsoundatposition("evt_clearing_trans_in", (0, 0, 0));
    level waittill(#"hash_1f51b705");
    level thread scene::play("cin_zur_12_01_root_1st_mirror_taylor_cam");
    level waittill(#"hash_c27a3d1");
    level thread scene::play("p7_fxanim_cp_zurich_mirror_bundle");
    level waittill(#"hash_e01132f9");
    util::clear_streamer_hint();
    savegame::checkpoint_save();
    level namespace_8e9083ff::function_c90e23b6(str_objective, "breadcrumb_zurichroot_5");
    level.var_1c26230b thread namespace_8e9083ff::function_fe5160df(1);
    wait(2);
    level function_3292451c();
    level thread function_9dd2872e(str_objective);
    videostart("cp_zurich_env_corvusmonitor", 1);
}

// Namespace namespace_6a04e6cd
// Params 1, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_b8580c84
// Checksum 0x37feffb2, Offset: 0x1d48
// Size: 0x11c
function function_b8580c84(a_ents) {
    var_29613ea0 = a_ents["zurich_mirror_start"];
    array::thread_all(level.players, &clientfield::set_to_player, "reflection_extracam", 1);
    array::thread_all(level.players, &clientfield::set_to_player, "mirror_break", 1);
    level notify(#"hash_3e3847fd");
    level waittill(#"hash_80b2a624");
    var_29613ea0 clientfield::set("mirror_warp", 1);
    var_29613ea0 playsound("evt_mirror_warp_taylor");
    level waittill(#"hash_1f51b705");
    var_29613ea0 clientfield::set("mirror_warp", 0);
}

// Namespace namespace_6a04e6cd
// Params 1, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_2a895f94
// Checksum 0x146b700c, Offset: 0x1e70
// Size: 0x422
function function_2a895f94(var_a3612ddd) {
    self endon(#"disconnect");
    self endon(#"death");
    scene::add_scene_func("cin_zur_12_01_root_1st_mirror_taylor_0" + var_a3612ddd, &function_cbebe415, "play");
    var_b16f0715 = [];
    var_e0cf565f = array::exclude(level.players, array(self));
    foreach (var_5abbae22 in var_e0cf565f) {
        var_52b4a338 = util::spawn_player_clone(var_5abbae22);
        var_52b4a338.var_f5434f17 = util::spawn_model("tag_origin", var_52b4a338 gettagorigin("tag_weapon_right"), var_52b4a338 gettagangles("tag_weapon_right"));
        e_weapon = var_5abbae22.currentweapon;
        var_52b4a338.var_f5434f17 useweaponmodel(e_weapon, e_weapon.worldmodel, var_5abbae22 getweaponoptions(e_weapon));
        var_52b4a338.var_f5434f17 linkto(var_52b4a338, "tag_weapon_right");
        foreach (e_player in var_e0cf565f) {
            var_52b4a338 setinvisibletoplayer(e_player, 1);
            var_52b4a338.var_f5434f17 setinvisibletoplayer(e_player, 1);
        }
        array::add(var_b16f0715, var_52b4a338);
    }
    self setinvisibletoall();
    self thread function_2398f048(var_b16f0715, var_a3612ddd);
    array::add(var_b16f0715, self);
    level thread scene::play("cin_zur_12_01_root_1st_mirror_taylor_0" + var_a3612ddd);
    level scene::play("cin_zur_12_01_root_1st_mirror_0" + var_a3612ddd, var_b16f0715);
    util::function_93831e79("root_zurich_start");
    var_b16f0715 = array::exclude(var_b16f0715, array(self));
    array::run_all(var_b16f0715, &delete);
    self show();
    self setvisibletoall();
    level notify(#"hash_e01132f9");
}

// Namespace namespace_6a04e6cd
// Params 2, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_2398f048
// Checksum 0xc80b72a4, Offset: 0x22a0
// Size: 0x1bc
function function_2398f048(var_b16f0715, var_a3612ddd) {
    self endon(#"disconnect");
    self endon(#"death");
    level waittill(#"hash_1f51b705");
    var_182ef0f0 = scene::get_existing_ent("taylor_0" + var_a3612ddd);
    var_182ef0f0 setvisibletoplayer(self);
    wait(0.5);
    foreach (var_52b4a338 in var_b16f0715) {
        if (isdefined(var_52b4a338.var_f5434f17)) {
            var_52b4a338.var_f5434f17 unlink();
            var_52b4a338.var_f5434f17 delete();
        }
    }
    array::run_all(var_b16f0715, &setinvisibletoplayer, self, 1);
    self hide();
    level waittill(#"hash_e01132f9");
    wait(3);
    self clientfield::set_to_player("reflection_extracam", 0);
}

// Namespace namespace_6a04e6cd
// Params 1, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_cbebe415
// Checksum 0x49a68373, Offset: 0x2468
// Size: 0x92
function function_cbebe415(a_ents) {
    foreach (var_182ef0f0 in a_ents) {
        var_182ef0f0 setinvisibletoall();
    }
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_9831305d
// Checksum 0x24e2de13, Offset: 0x2508
// Size: 0x1c4
function function_9831305d() {
    var_b6e5ad19 = getentarray("zurich_popup_poles", "targetname");
    for (i = 0; i < var_b6e5ad19.size; i++) {
        var_b6e5ad19[i].end_pos = var_b6e5ad19[i].origin;
        if (isdefined(var_b6e5ad19[i].target)) {
            var_fb3442a9 = struct::get_array(var_b6e5ad19[i].target, "targetname");
            for (j = 0; j < var_fb3442a9.size; j++) {
                if (var_fb3442a9[j].script_noteworthy === "start_pos") {
                    var_b6e5ad19[i].start_pos = var_fb3442a9[j].origin;
                    var_b6e5ad19[i] moveto(var_b6e5ad19[i].start_pos, 0.05);
                    continue;
                }
                if (var_fb3442a9[j].script_noteworthy === "fx_pos") {
                    var_b6e5ad19[i].fx_pos = var_fb3442a9[j];
                }
            }
        }
    }
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_3292451c
// Checksum 0x5e19ee15, Offset: 0x26d8
// Size: 0x1cc
function function_3292451c() {
    var_6fbeca4a = 1;
    for (var_6fe9b606 = getent("popup_pole_" + var_6fbeca4a, "script_noteworthy"); isdefined(var_6fe9b606); var_6fe9b606 = getent("popup_pole_" + var_6fbeca4a, "script_noteworthy")) {
        var_6fe9b606 moveto(var_6fe9b606.end_pos, 0.5);
        v_ground = groundtrace(var_6fe9b606.fx_pos.origin, var_6fe9b606.origin, 0, var_6fe9b606)["position"];
        var_f33892ac = util::spawn_model("tag_origin", v_ground, var_6fe9b606.angles);
        var_6fe9b606 waittill(#"movedone");
        var_f33892ac clientfield::increment("zurich_snow_rise");
        playsoundatposition("evt_roots_grow", var_f33892ac.origin);
        var_f33892ac thread function_df835392();
        exploder::exploder("lgt_zurichpole_exp_" + var_6fbeca4a);
        var_6fbeca4a++;
    }
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_c88fe82
// Checksum 0x588b62d9, Offset: 0x28b0
// Size: 0x144
function function_c88fe82() {
    level dialog::remote("mcor_you_ever_say_or_do_s_0", 1, "NO_DNI");
    level dialog::remote("tayr_maretti_is_that_yo_0", 1, "NO_DNI");
    level dialog::remote("mcor_maybe_it_wasn_t_you_0", 1, "NO_DNI");
    level dialog::remote("mcor_maybe_it_was_someone_0", 1, "NO_DNI");
    level dialog::remote("tayr_what_the_fuck_0", 1, "NO_DNI");
    level dialog::function_13b3b16a("plyr_taylor_3", 1);
    level dialog::function_13b3b16a("plyr_are_you_still_with_m_0", 1);
}

// Namespace namespace_6a04e6cd
// Params 1, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_2d897f84
// Checksum 0x9b6e11b2, Offset: 0x2a00
// Size: 0x13e
function function_2d897f84(str_objective) {
    level endon(str_objective + "_done");
    level endon(#"hash_c955b42d");
    for (var_b1cdbf1d = 1; true; var_b1cdbf1d++) {
        var_f6e695c0 = struct::get("breadcrumb_zurichroot_" + var_b1cdbf1d, "targetname");
        var_b1fe230f = getent("t_zurichroot_" + var_b1cdbf1d, "script_noteworthy");
        if (!isdefined(var_f6e695c0) || !isdefined(var_b1fe230f)) {
            return;
        }
        objectives::set("cp_waypoint_breadcrumb", var_f6e695c0);
        var_b1fe230f waittill(#"trigger");
        level notify(#"next_checkpoint");
        savegame::checkpoint_save();
        objectives::complete("cp_waypoint_breadcrumb", var_f6e695c0);
    }
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_8182f3c5
// Checksum 0x26632d43, Offset: 0x2b48
// Size: 0x54
function function_8182f3c5() {
    var_3e269f89 = getentarray("zurich_vinewall_trig", "targetname");
    array::thread_all(var_3e269f89, &function_ddbd0859);
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_ddbd0859
// Checksum 0x2b9d12a6, Offset: 0x2ba8
// Size: 0x292
function function_ddbd0859() {
    var_4cb02780 = getentarray(self.target, "targetname");
    for (i = 0; i < var_4cb02780.size; i++) {
        var_4cb02780[i].end_pos = var_4cb02780[i].origin;
        if (isdefined(var_4cb02780[i].script_string)) {
            var_4cb02780[i] thread function_e8047245();
        }
        if (isdefined(var_4cb02780[i].target)) {
            var_fb3442a9 = struct::get_array(var_4cb02780[i].target, "targetname");
            for (j = 0; j < var_fb3442a9.size; j++) {
                if (var_fb3442a9[j].script_noteworthy === "start_pos") {
                    var_4cb02780[i].start_pos = var_fb3442a9[j].origin;
                    var_4cb02780[i] moveto(var_4cb02780[i].start_pos, 0.05);
                }
            }
        }
        if (!isdefined(var_4cb02780[i].start_pos)) {
            var_4cb02780[i] movez(-128, 0.05);
        }
    }
    self waittill(#"trigger");
    foreach (var_ec523dd5 in var_4cb02780) {
        var_ec523dd5 thread function_300319e3();
    }
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_300319e3
// Checksum 0xd56a291c, Offset: 0x2e48
// Size: 0x1d0
function function_300319e3() {
    n_time = randomfloatrange(0.2, 0.75);
    wait(n_time);
    self moveto(self.end_pos, n_time);
    if (isdefined(self.target)) {
        var_abc323ed = struct::get_array(self.target, "targetname");
        for (i = 0; i < var_abc323ed.size; i++) {
            if (var_abc323ed[i].script_noteworthy === "fx_pos") {
                v_ground = groundtrace(var_abc323ed[i].origin, self.origin, 0, self)["position"];
                var_f33892ac = util::spawn_model("tag_origin", v_ground, var_abc323ed[i].angles);
                self waittill(#"movedone");
                var_f33892ac clientfield::increment("zurich_snow_rise");
                playsoundatposition("evt_roots_grow", var_abc323ed[i].origin);
                var_f33892ac thread function_df835392();
                return;
            }
        }
    }
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_e8047245
// Checksum 0xcbff9721, Offset: 0x3020
// Size: 0x14a
function function_e8047245() {
    var_a8a64a67 = getnodearray(self.script_string, "targetname");
    foreach (var_974cc07 in var_a8a64a67) {
        setenablenode(var_974cc07, 0);
    }
    self waittill(#"movedone");
    foreach (var_974cc07 in var_a8a64a67) {
        setenablenode(var_974cc07, 1);
    }
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_df835392
// Checksum 0x19c13b44, Offset: 0x3178
// Size: 0x1c
function function_df835392() {
    wait(3);
    self delete();
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_187dfb55
// Checksum 0x48f2ccfb, Offset: 0x31a0
// Size: 0x1a4
function function_187dfb55() {
    scene::add_scene_func("p7_fxanim_cp_zurich_roots_train_bundle", &function_74c17b69, "play");
    scene::add_scene_func("p7_fxanim_cp_zurich_roots_train_bundle", &namespace_8e9083ff::function_9f90bc0f, "done", "zurich_root_completed");
    level thread scene::init("p7_fxanim_cp_zurich_roots_train_bundle");
    level flag::wait_till("flag_start_zurich_train_logic");
    level thread function_b9295ca8();
    level thread function_ddc2d04e();
    level flag::wait_till("flag_zurich_root_final_encounter_complete");
    objectives::breadcrumb("t_zurichroot_traincars");
    trigger::wait_till("t_zurichroot_traincars");
    spawn_manager::kill("sm_zurich_root_end_rushers");
    playsoundatposition("evt_roots_train_start", (-21602, -25483, 1681));
    level thread function_a85c54c7();
    level scene::play("p7_fxanim_cp_zurich_roots_train_bundle");
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_a85c54c7
// Checksum 0x4477b264, Offset: 0x3350
// Size: 0x5c
function function_a85c54c7() {
    level waittill(#"hash_bf94f0c3");
    getent("zur_root_train_blocker", "targetname") delete();
    objectives::breadcrumb("t_breadcrumb_zurichroot_exit");
}

// Namespace namespace_6a04e6cd
// Params 1, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_74c17b69
// Checksum 0x19cb0fae, Offset: 0x33b8
// Size: 0x9a
function function_74c17b69(a_ents) {
    foreach (e_ent in a_ents) {
        e_ent playrumbleonentity("cp_infection_hideout_stretch");
    }
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_b9295ca8
// Checksum 0xd2a8b5d6, Offset: 0x3460
// Size: 0x4c
function function_b9295ca8() {
    level endon(#"hash_e0d2827d");
    spawn_manager::function_27bf2e8("sm_zurich_root_end", 2);
    level flag::set("flag_zurich_root_final_encounter_complete");
}

// Namespace namespace_6a04e6cd
// Params 0, eflags: 0x1 linked
// namespace_6a04e6cd<file_0>::function_ddc2d04e
// Checksum 0x3fb53a5d, Offset: 0x34b8
// Size: 0x34
function function_ddc2d04e() {
    level endon(#"hash_e0d2827d");
    wait(60);
    level flag::set("flag_zurich_root_final_encounter_complete");
}

