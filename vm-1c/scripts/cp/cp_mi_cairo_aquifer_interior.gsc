#using scripts/cp/cp_mi_cairo_aquifer_objectives;
#using scripts/cp/cp_mi_cairo_aquifer_utility;
#using scripts/cp/cp_mi_cairo_aquifer_sound;
#using scripts/cp/gametypes/_save;
#using scripts/shared/exploder_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_objectives;
#using scripts/cp/_dialog;
#using scripts/cp/_debug;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/_load;

#namespace cp_mi_cairo_aquifer_interior;

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x1 linked
// Checksum 0xa6c0236f, Offset: 0xa20
// Size: 0xfc
function function_608c4683() {
    aquifer_util::function_75ab4ede(1);
    guy = namespace_84eb777e::function_eb16c4f5("hendricks_hangar");
    guy util::magic_bullet_shield();
    guy.script_ignoreme = 1;
    guy.baseaccuracy = 0.25;
    level.hendricks thread dialog::say("hend_maretti_s_escaping_t_0");
    clientfield::set("hide_sand_storm", 1);
    thread function_afb6fe67();
    thread function_a8f7f041();
    thread function_2fde871a();
    thread function_3a330f78();
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x1 linked
// Checksum 0x10ae76fe, Offset: 0xb28
// Size: 0x1fc
function function_afb6fe67() {
    thread function_bd50ac83();
    util::delay(5, undefined, &scene::init, "cin_aqu_07_not_yourself_3rd_shot010");
    spawn_manager::wait_till_complete("main_hangar_enemies");
    guys = spawn_manager::function_423eae50("main_hangar_enemies");
    spawn_manager::function_27bf2e8("main_hangar_enemies", int(max(2, int(guys.size / 3))));
    thread aquifer_util::function_9f296d9f("extras_exposed");
    thread aquifer_util::function_9f296d9f("hendricks_move_up_hangar");
    util::delay(1, undefined, &trigger::use, "hangar_enemies_exposed", "targetname");
    spawn_manager::wait_till_cleared("main_hangar_enemies");
    level.hendricks.baseaccuracy = 10;
    spawn_manager::wait_till_cleared("hangar_breach_extras");
    level flag::set("start_interior_breadcrumbs");
    trigger::use("hendricks_leave_hangar", "targetname");
    level.hendricks battlechatter::function_d9f49fba(0);
    level.hendricks.baseaccuracy = 0.25;
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x1 linked
// Checksum 0x2fd97059, Offset: 0xd30
// Size: 0x4c
function function_2fde871a() {
    level flag::wait_till_any(array("start_interior_breadcrumbs", "chase_vo1"));
    objectives::breadcrumb("start_interior_breadcrumbs");
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x1 linked
// Checksum 0xacb8793d, Offset: 0xd88
// Size: 0xce
function function_2fc2978c() {
    var_2b309d3d = getentarray("spawn_manager", "classname");
    foreach (sm in var_2b309d3d) {
        if (sm.name === "pre_boss_enemies") {
            sm.script_wait_min = 1.5;
        }
    }
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x0
// Checksum 0x27aac76, Offset: 0xe60
// Size: 0xac
function function_a4c59129() {
    util::magic_bullet_shield(self);
    ai::createinterfaceforentity(self);
    self ai::set_behavior_attribute("sprint", 1);
    self ai::disable_pain();
    trigger::use("promethius_flee_hangar", "targetname");
    self waittill(#"goal");
    self delete();
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x1 linked
// Checksum 0xe6e19f7a, Offset: 0xf18
// Size: 0x6c
function function_bd50ac83() {
    spawn_manager::enable("hangar_breach_extras");
    spawn_manager::wait_till_complete("hangar_breach_extras");
    spawn_manager::function_27bf2e8("hangar_breach_extras", 2);
    trigger::use("extras_exposed");
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x0
// Checksum 0xea546a42, Offset: 0xf90
// Size: 0x4c
function function_3fd5eb17() {
    util::screen_fade_out(0.25, "white");
    wait 0.25;
    util::screen_fade_in(2, "white");
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x1 linked
// Checksum 0x28aa47dc, Offset: 0xfe8
// Size: 0x314
function function_3a330f78() {
    var_87942fa5 = getentarray("icy", "targetname");
    array::run_all(var_87942fa5, &hide);
    level flag::wait_till("snow_vo");
    savegame::checkpoint_save();
    level thread dialog::remote("corv_let_your_mind_relax_2", undefined, "corvus");
    level flag::wait_till("flag_snow_room");
    if (isdefined(level.var_d08c6690)) {
        level thread [[ level.var_d08c6690 ]]();
    }
    exploder::exploder("amb_int_tank_room");
    array::thread_all(level.activeplayers, &aquifer_util::function_89eaa1b3, 1);
    wait 1;
    array::thread_all(level.activeplayers, &aquifer_util::function_716b5d66, 1);
    wait 5;
    level flag::wait_till_clear("flag_snow_room");
    exploder::exploder_stop("amb_int_tank_room");
    array::thread_all(level.activeplayers, &aquifer_util::function_89eaa1b3, 1);
    wait 1;
    array::thread_all(level.activeplayers, &aquifer_util::function_716b5d66, 0);
    level.hendricks battlechatter::function_d9f49fba(1);
    level flag::wait_till("exit_round_room");
    level.hendricks battlechatter::function_d9f49fba(0);
    level.hendricks ai::set_ignoreall(1);
    var_e27965fa = spawn_manager::function_423eae50("roundroom_allies");
    var_bc76eb91 = spawn_manager::function_423eae50("roundroom_enemies");
    guys = arraycombine(var_e27965fa, var_bc76eb91, 1, 1);
    array::thread_all(guys, &aquifer_util::delete_me);
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 1, eflags: 0x1 linked
// Checksum 0x26f720b3, Offset: 0x1308
// Size: 0xec
function function_1d5b05a(var_74cd64bc) {
    if (!isdefined(var_74cd64bc)) {
        var_74cd64bc = 0;
    }
    if (!var_74cd64bc) {
        aquifer_util::function_2085bf94("hideout_door", 1);
        aquifer_util::function_2085bf94("hideout_doors_closed", 1);
    }
    if (isdefined(level.var_5bfe1c70)) {
        level thread [[ level.var_5bfe1c70 ]]();
    }
    namespace_84eb777e::function_f67ca613(1);
    scene::play("cin_aqu_16_outro_3rd_sh010", level.hendricks);
    level waittill(#"hash_a35499d1");
    level thread namespace_71a63eac::function_a1e074db();
    util::function_93831e79("post_hideout_igc");
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x1 linked
// Checksum 0x9642f7c4, Offset: 0x1400
// Size: 0x276
function function_ff024877() {
    thread aquifer_util::function_2085bf94("hideout_door", 0);
    thread aquifer_util::function_2085bf94("hideout_doors_closed", 0);
    thread namespace_84eb777e::function_e2d8799f(1);
    thread namespace_84eb777e::function_5d32874c(1);
    thread function_397e963e();
    skipto::function_be8adfb8("hideout");
    savegame::checkpoint_save();
    array::run_all(level.activeplayers, &setmovespeedscale, 0.7);
    thread function_291b34c9();
    thread function_c48c4f99();
    thread function_25357c2e();
    thread function_3a77d1bf();
    var_8a6d11 = function_246476fd(0, "cin_aqu_07_10_escape_vign_run_hendricks_a", "cin_aqu_07_10_escape_vign_wait_hendricks_a", "cin_aqu_07_10_escape_vign_wait_loop_hendricks_a", "run_out_cinematic1", 1, "hend_runout_a");
    var_8a6d11 = function_246476fd(var_8a6d11, "cin_aqu_07_10_escape_vign_run_hendricks_b", "cin_aqu_07_10_escape_vign_wait_hendricks_b", "cin_aqu_07_10_escape_vign_wait_loop_hendricks_a", "run_out_cinematic1", 1, "hend_runout_b");
    var_8a6d11 = function_246476fd(var_8a6d11, "cin_aqu_07_10_escape_vign_run_hendricks_c", "cin_aqu_07_10_escape_vign_wait_hendricks_c", "cin_aqu_07_10_escape_vign_wait_loop_hendricks_a", "run_out_cinematic1", 1, "hend_runout_c");
    var_8a6d11 = function_246476fd(var_8a6d11, "cin_aqu_07_10_escape_vign_run_hendricks_d", "cin_aqu_07_10_escape_vign_wait_hendricks_d", "cin_aqu_07_10_escape_vign_wait_loop_hendricks_a", "run_out_cinematic2", 1, "hend_runout_d");
    if (var_8a6d11) {
        var_8a6d11 = function_246476fd(var_8a6d11, "cin_aqu_07_10_escape_vign_run_hendricks_e", undefined, undefined, "run_out_cinematic2", 0, undefined);
    }
    level.hendricks.n_script_anim_rate = undefined;
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x1 linked
// Checksum 0x541d4435, Offset: 0x1680
// Size: 0x94
function function_3a77d1bf() {
    struct = getent("run_out_cinematic2", "targetname");
    struct scene::init("cin_aqu_07_10_escape_vign_crush_death_ally");
    level waittill(#"collapse");
    thread aquifer_util::function_2085bf94("ceiling_ac_unit", 1);
    struct scene::play("cin_aqu_07_10_escape_vign_crush_death_ally");
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x0
// Checksum 0xc5a082ef, Offset: 0x1720
// Size: 0x40
function function_64386226() {
    level endon(#"hash_a384e425");
    while (true) {
        level waittill(#"collapse");
        iprintlnbold("COLLAPSE START");
    }
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x1 linked
// Checksum 0x2dfeda84, Offset: 0x1768
// Size: 0x278
function function_291b34c9() {
    level endon(#"hash_a384e425");
    while (true) {
        level waittill(#"shake");
        earthquake(0.5, 2, level.hendricks.origin, 1000);
        level thread cp_mi_cairo_aquifer_sound::function_5d0cee98();
        var_e817acd1 = array("pb_aqu_07_10_escape_vign_stagger_l_player", "pb_aqu_07_10_escape_vign_stagger_r_player");
        array::run_all(level.activeplayers, &setmovespeedscale, 0.5);
        array::run_all(level.activeplayers, &allowsprint, 0);
        foreach (player in level.activeplayers) {
            anim_name = array::random(var_e817acd1);
            player thread animation::play(anim_name, player.origin, player.angles, 1, 0, 0, 0);
        }
        array::run_all(level.activeplayers, &setmovespeedscale, 0.2);
        wait 0.8;
        array::run_all(level.activeplayers, &setmovespeedscale, 0.7);
        array::run_all(level.activeplayers, &allowsprint, 1);
    }
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x1 linked
// Checksum 0x3c046076, Offset: 0x19e8
// Size: 0x1ea
function function_c48c4f99() {
    level endon(#"hash_a384e425");
    while (true) {
        level util::delay_notify(randomfloatrange(2, 5), "minishake", "shake");
        ret = level util::waittill_any_return("shake", "minishake");
        if (ret == "minishake") {
            exploder::exploder("cin_runout_rattles");
            earthquake(randomfloatrange(0.3, 0.4), 1.25, level.hendricks.origin, 1000);
            level thread cp_mi_cairo_aquifer_sound::function_f8835fe9();
            array::run_all(level.activeplayers, &setmovespeedscale, 0.5);
            array::run_all(level.activeplayers, &allowsprint, 0);
            wait 0.25;
            array::run_all(level.activeplayers, &setmovespeedscale, 0.7);
            array::run_all(level.activeplayers, &allowsprint, 1);
            continue;
        }
        wait 3;
    }
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x0
// Checksum 0x2e4fb903, Offset: 0x1be0
// Size: 0x64
function function_e916ac0e() {
    level.hendricks dialog::say("hend_kane_we_re_uploadin_0");
    level dialog::remote("kane_got_it_good_work_0");
    level dialog::remote("kane_the_nrc_have_capture_0");
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x1 linked
// Checksum 0xb2f4ec3b, Offset: 0x1c50
// Size: 0x5c
function function_397e963e() {
    level thread cp_mi_cairo_aquifer_sound::function_b01c9f8();
    level dialog::remote("kane_the_nrc_have_launche_0");
    level dialog::function_13b3b16a("plyr_don_t_need_to_tell_u_1");
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 7, eflags: 0x1 linked
// Checksum 0x1d736380, Offset: 0x1cb8
// Size: 0x292
function function_246476fd(var_8a6d11, var_f17304b7, var_75422735, var_b6b983f4, var_426bda58, var_2d3b4a98, var_6bf6eac8) {
    struct = getent(var_426bda58, "targetname");
    var_482ba61c = 1.2;
    level.hendricks.n_script_anim_rate = var_482ba61c;
    if (var_8a6d11) {
        struct scene::init(var_f17304b7, level.hendricks);
        level waittill(#"hash_20aa8e12");
    }
    scene::add_scene_func(var_f17304b7, &function_8ed6a39f, "done");
    struct thread scene::play(var_f17304b7, level.hendricks);
    ret = level util::waittill_any_return(var_6bf6eac8, "splice", "run_scene_done");
    if ((ret == "splice" || isdefined(var_75422735) && isdefined(var_b6b983f4) && isdefined(var_6bf6eac8) && ret == "run_scene_done") && !level flag::get(var_6bf6eac8)) {
        struct scene::stop(var_f17304b7, 0);
        struct scene::play(var_75422735, level.hendricks);
        level.hendricks.n_script_anim_rate = undefined;
        if (var_2d3b4a98) {
            level.hendricks thread scene::play(var_b6b983f4, level.hendricks);
        } else {
            struct thread scene::play(var_b6b983f4, level.hendricks);
        }
        level flag::wait_till(var_6bf6eac8);
        level.hendricks stopanimscripted();
        return 1;
    }
    struct waittill(#"scene_done");
    return 0;
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 1, eflags: 0x1 linked
// Checksum 0xf132ea5c, Offset: 0x1f58
// Size: 0x1a
function function_8ed6a39f(a_ents) {
    level notify(#"run_scene_done");
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x1 linked
// Checksum 0x27fcafd7, Offset: 0x1f80
// Size: 0x114
function function_a8f7f041() {
    level flag::wait_till("chase_vo1");
    savegame::checkpoint_save();
    level.hendricks thread dialog::say("hend_maretti_went_this_wa_0");
    level flag::wait_till("chase_vo2");
    level.hendricks thread dialog::say("hend_move_faster_we_can_0");
    level flag::wait_till("chase_vo3");
    level dialog::function_13b3b16a("plyr_hendricks_0");
    level dialog::function_13b3b16a("plyr_slow_down_0", 2);
    level dialog::function_13b3b16a("plyr_hey_listen_to_me_0", 2);
}

// Namespace cp_mi_cairo_aquifer_interior
// Params 0, eflags: 0x1 linked
// Checksum 0xa760b906, Offset: 0x20a0
// Size: 0x34e
function function_25357c2e() {
    var_296988d3 = [];
    if (!isdefined(var_296988d3)) {
        var_296988d3 = [];
    } else if (!isarray(var_296988d3)) {
        var_296988d3 = array(var_296988d3);
    }
    var_296988d3[var_296988d3.size] = "plyr_we_need_to_get_back_0";
    if (!isdefined(var_296988d3)) {
        var_296988d3 = [];
    } else if (!isarray(var_296988d3)) {
        var_296988d3 = array(var_296988d3);
    }
    var_296988d3[var_296988d3.size] = "kane_you_need_to_get_out_0";
    if (!isdefined(var_296988d3)) {
        var_296988d3 = [];
    } else if (!isarray(var_296988d3)) {
        var_296988d3 = array(var_296988d3);
    }
    var_296988d3[var_296988d3.size] = "hend_keep_moving_this_pl_0";
    if (!isdefined(var_296988d3)) {
        var_296988d3 = [];
    } else if (!isarray(var_296988d3)) {
        var_296988d3 = array(var_296988d3);
    }
    var_296988d3[var_296988d3.size] = "skip";
    if (!isdefined(var_296988d3)) {
        var_296988d3 = [];
    } else if (!isarray(var_296988d3)) {
        var_296988d3 = array(var_296988d3);
    }
    var_296988d3[var_296988d3.size] = "hend_watch_out_1";
    if (!isdefined(var_296988d3)) {
        var_296988d3 = [];
    } else if (!isarray(var_296988d3)) {
        var_296988d3 = array(var_296988d3);
    }
    var_296988d3[var_296988d3.size] = "hend_keep_up_0";
    for (i = 0; i < var_296988d3.size; i++) {
        level waittill(#"shake");
        wait 2;
        if (var_296988d3[i] != "skip") {
            if (i == 0) {
                dialog::function_13b3b16a(var_296988d3[i]);
                continue;
            }
            if (i == 1) {
                level dialog::remote(var_296988d3[i]);
                i++;
                level.hendricks dialog::say(var_296988d3[i]);
                continue;
            }
            level.hendricks dialog::say(var_296988d3[i]);
        }
    }
}

