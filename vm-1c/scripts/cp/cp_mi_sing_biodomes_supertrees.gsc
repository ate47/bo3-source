#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_biodomes2_sound;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes_swamp;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_hunter;

#namespace cp_mi_sing_biodomes_supertrees;

// Namespace cp_mi_sing_biodomes_supertrees
// Method(s) 7 Total 7
class class_ba668242 {

    // Namespace namespace_ba668242
    // Params 0, eflags: 0x0
    // Checksum 0xfe72b3b1, Offset: 0x7598
    // Size: 0x14c
    function constructor() {
        self.var_58955f5c = getentarray("gate_tree_1a", "targetname");
        self.var_7e16e483 = self.var_58955f5c[0].targetname;
        self.var_1484043e = self.var_58955f5c[0].target;
        self.var_ceb54ef4 = 0.25;
        self.var_8d014670 = 0.25;
        self.var_6aa78718 = self.var_58955f5c[0].origin;
        self.var_bbe2e3a7 = self.var_58955f5c[1].origin;
        self.var_63199256 = self.var_58955f5c[0].angles;
        self.var_10ff592d = self.var_58955f5c[1].angles;
        self.var_c88d0ebd = self.var_58955f5c[0].angles;
        self.var_e6756120 = self.var_58955f5c[1].angles;
    }

    // Namespace namespace_ba668242
    // Params 0, eflags: 0x0
    // Checksum 0xbb5b4c5d, Offset: 0x7d48
    // Size: 0xa
    function function_83f15319() {
        return self.var_1484043e;
    }

    // Namespace namespace_ba668242
    // Params 0, eflags: 0x0
    // Checksum 0xa3ab4062, Offset: 0x7d30
    // Size: 0xa
    function function_cabbdf40() {
        return self.var_7e16e483;
    }

    // Namespace namespace_ba668242
    // Params 0, eflags: 0x0
    // Checksum 0x99de9c09, Offset: 0x7c98
    // Size: 0x8c
    function function_c0cdf2d2() {
        self.var_58955f5c[0] rotateto(self.var_c88d0ebd, self.var_8d014670);
        self.var_58955f5c[1] rotateto(self.var_e6756120, self.var_8d014670);
        playsoundatposition("evt_zipline_gate_close", self.var_6aa78718);
        wait self.var_8d014670;
    }

    // Namespace namespace_ba668242
    // Params 0, eflags: 0x0
    // Checksum 0x3da306e3, Offset: 0x7c00
    // Size: 0x8c
    function function_c3e1dff0() {
        self.var_58955f5c[0] rotateto(self.var_63199256, self.var_ceb54ef4);
        self.var_58955f5c[1] rotateto(self.var_10ff592d, self.var_ceb54ef4);
        playsoundatposition("evt_zipline_gate_open", self.var_6aa78718);
        wait self.var_ceb54ef4;
    }

    // Namespace namespace_ba668242
    // Params 1, eflags: 0x0
    // Checksum 0x46e4bacc, Offset: 0x7700
    // Size: 0x4f4
    function init(str_gate) {
        self.var_58955f5c = getentarray(str_gate, "targetname");
        self.var_7e16e483 = str_gate;
        self.var_1484043e = self.var_58955f5c[0].target;
        self.var_6aa78718 = self.var_58955f5c[0].origin;
        self.var_bbe2e3a7 = self.var_58955f5c[1].origin;
        self.var_c88d0ebd = self.var_58955f5c[0].angles;
        self.var_e6756120 = self.var_58955f5c[1].angles;
        if (self.var_7e16e483 == "restaurant_gate_01") {
            self.var_63199256 = self.var_58955f5c[0].angles + (self.var_58955f5c[0].angles[0] + 14, self.var_58955f5c[0].angles[1] + -90, self.var_58955f5c[0].angles[2] + 0);
            self.var_10ff592d = self.var_58955f5c[1].angles + (self.var_58955f5c[1].angles[0] + -2, self.var_58955f5c[1].angles[1] + 90, self.var_58955f5c[1].angles[2] + -18);
        } else if (self.var_7e16e483 == "restaurant_gate_02") {
            self.var_63199256 = self.var_58955f5c[0].angles + (self.var_58955f5c[0].angles[0] + 2, self.var_58955f5c[0].angles[1] + -90, self.var_58955f5c[0].angles[2] + -4);
            self.var_10ff592d = self.var_58955f5c[1].angles + (self.var_58955f5c[1].angles[0] + -8, self.var_58955f5c[1].angles[1] + 90, self.var_58955f5c[1].angles[2] + -5);
        } else {
            self.var_63199256 = self.var_58955f5c[0].angles + (self.var_58955f5c[0].angles[0], self.var_58955f5c[0].angles[1] + -90, self.var_58955f5c[0].angles[2]);
            self.var_10ff592d = self.var_58955f5c[1].angles + (self.var_58955f5c[1].angles[0], self.var_58955f5c[1].angles[1] + 90, self.var_58955f5c[1].angles[2]);
        }
        var_fcd3376c = 0;
        foreach (var_82e417eb in level.var_77a37a25) {
            if ([[ var_82e417eb ]]->function_cabbdf40() == function_cabbdf40()) {
                var_fcd3376c = 1;
                break;
            }
        }
        if (!var_fcd3376c) {
            array::add(level.var_77a37a25, self);
        }
    }

}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x926215eb, Offset: 0x1cc0
// Size: 0x3bc
function main() {
    level thread function_fd35e580();
    level thread function_2387e4bd();
    level thread function_c85169ef();
    spawner::add_spawn_function_group("zipline_guys", "script_noteworthy", &function_cdb04f99);
    spawner::add_spawn_function_group("zipline_scene_guys", "script_noteworthy", &function_eb9e3e82);
    spawner::add_spawn_function_group("bridge1_runners", "script_noteworthy", &bridge1_runners);
    spawner::add_spawn_function_group("finaltree_rpg_guys", "script_noteworthy", &finaltree_rpg_guys);
    spawner::add_spawn_function_group("zipline_reinforcements", "script_noteworthy", &zipline_reinforcements);
    spawner::add_spawn_function_group("supertree_arsonists", "script_noteworthy", &supertree_arsonists);
    spawner::add_spawn_function_group("zipline_wasps", "script_noteworthy", &zipline_wasps);
    var_6cfd4078 = getentarray("reached_finaltree_triggers", "script_noteworthy");
    array::thread_all(var_6cfd4078, &function_5a80eb84);
    var_69535641 = getentarray("bridge_trigger_enter", "script_noteworthy");
    array::thread_all(var_69535641, &function_8dba42a1);
    var_c23afe76 = getentarray("bridge2_transition_triggers", "script_noteworthy");
    array::thread_all(var_c23afe76, &function_4331ad22);
    level.var_d582416e = getweapon("pistol_standard");
    level.var_8ffd4cdb = getweapon("pistol_fullauto");
    level.var_44a0465d = getweapon("pistol_burst");
    level.var_957c9ba0 = getweapon("hero_annihilator");
    level.var_17a1f194 = getweapon("pistol_standard_zipline");
    level.var_d397bc89 = getweapon("pistol_fullauto_zipline");
    level.var_80242247 = getweapon("pistol_burst_zipline");
    level.var_135a01e4 = getweapon("noweapon_zipline");
    level.var_ad139ea = getweapon("hero_annihilator_cp_zipline");
    function_7b244c18();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x6e9c0b51, Offset: 0x2088
// Size: 0x34
function function_7b244c18() {
    scene::add_scene_func("cin_bio_13_03_treefight_1st_zipline", &function_5068f9bd, "play");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 2, eflags: 0x0
// Checksum 0xf70359b, Offset: 0x20c8
// Size: 0x1fc
function objective_descend_init(str_objective, var_74cd64bc) {
    load::function_73adcefc();
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_descend_init");
    cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
    hidemiscmodels("fxanim_fish");
    load::function_a2995f22();
    var_a1a8c705 = level thread spawner::simple_spawn("sp_supertrees_tree1_explode", &function_1c60cd10);
    level clientfield::increment("supertree_fall_init", 1);
    level flag::set("start_slide");
    level thread function_65ac2d4e();
    var_be8bdabd = getent("trig_objective_descend_complete", "targetname");
    level thread util::single_thread(var_be8bdabd, &function_62260259);
    level thread function_7254f23f();
    level thread namespace_76133733::function_ec357599();
    if (isdefined(level.var_46d46f79)) {
        level thread [[ level.var_46d46f79 ]]();
    }
    trigger::wait_till("trig_objective_descend_complete");
    level thread namespace_76133733::function_683d15e();
    skipto::function_be8adfb8("objective_descend");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xbd7531a, Offset: 0x22d0
// Size: 0xd4
function function_65ac2d4e() {
    scene::add_scene_func("cin_bio_12_05_descend_vign_planc", &function_20ff3f32, "done");
    level scene::init("cin_bio_12_05_descend_vign_planc");
    level flag::wait_till("first_player_spawned");
    level thread function_492debfc();
    level scene::play("cin_bio_12_05_descend_vign_planc");
    wait 0.15;
    trigger::use("trig_move_toward_supertree", undefined, undefined, 0);
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x5321297d, Offset: 0x23b0
// Size: 0x24
function function_7254f23f() {
    level dialog::remote("kane_keep_going_just_get_0");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x22c33824, Offset: 0x23e0
// Size: 0x78
function function_62260259() {
    self endon(#"death");
    while (true) {
        self trigger::wait_till();
        player = self.who;
        self setinvisibletoplayer(player);
        player thread function_b76ad4cd();
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x81995ffb, Offset: 0x2460
// Size: 0x3c
function function_b76ad4cd() {
    self endon(#"death");
    self enableinvulnerability();
    wait 2;
    self disableinvulnerability();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 4, eflags: 0x0
// Checksum 0x6f1b39a8, Offset: 0x24a8
// Size: 0x3c
function objective_descend_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_descend_done");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xc6f5a9c8, Offset: 0x24f0
// Size: 0xa4
function function_ac17866e() {
    self ai::gun_remove();
    self ai::set_ignoreme(1);
    if (isdefined(self.target)) {
        level thread scene::play(self.target, self);
    } else {
        self kill();
    }
    self waittill(#"death");
    if (isdefined(self)) {
        self startragdoll(1);
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xa2fe8a23, Offset: 0x25a0
// Size: 0x112
function function_1c60cd10() {
    self endon(#"death");
    self.goalradius = 4;
    self.goalheight = 4;
    level waittill(#"hash_706115bc");
    var_d7f9ac76 = randomintrange(1, 4);
    wait randomfloatrange(0.25, 0.75);
    switch (var_d7f9ac76) {
    case 1:
        self thread scene::play("cin_gen_xplode_death_1", self);
        break;
    case 2:
        self thread scene::play("cin_gen_xplode_death_2", self);
        break;
    case 3:
        self thread scene::play("cin_gen_xplode_death_3", self);
        break;
    default:
        break;
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xf1f7cece, Offset: 0x26c0
// Size: 0xf4
function bridge1_runners() {
    self endon(#"death");
    nd_target = getnode(self.target, "targetname");
    if (isdefined(nd_target)) {
        self.ignoresuppression = 1;
        self.grenadeawareness = 0;
        self ai::disable_pain();
        self pushplayer(1);
        self setgoal(nd_target);
        self waittill(#"goal");
        self ai::enable_pain();
        self.grenadeawareness = 1;
        self.ignoresuppression = 0;
        self pushplayer(0);
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x8c82ba4e, Offset: 0x27c0
// Size: 0x34
function zipline_wasps() {
    self endon(#"death");
    self.health = 2;
    self thread function_9da1f0ff();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x79566d2f, Offset: 0x2800
// Size: 0xbc
function function_9da1f0ff() {
    self endon(#"death");
    str_target = self.target;
    var_840ef1ce = str_target + "_move";
    var_a8f67e26 = getent(var_840ef1ce, "targetname");
    var_ea32a33b = "trig_" + str_target;
    self trigger::wait_till(var_ea32a33b, "targetname");
    self setgoal(var_a8f67e26);
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 2, eflags: 0x0
// Checksum 0x91c2dfca, Offset: 0x28c8
// Size: 0x45c
function objective_supertrees_init(str_objective, var_74cd64bc) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_supertrees_init");
    namespace_769dc23f::function_e77dc7c0();
    namespace_769dc23f::function_e3f60acf();
    namespace_769dc23f::function_3f59ea45();
    namespace_769dc23f::function_765fa7e9();
    namespace_769dc23f::function_9ccc0413();
    level flag::init("tree2_and_tree3_pursuit_allowed");
    level flag::init("tree4_and_tree5_pursuit_allowed");
    if (var_74cd64bc) {
        cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
        level flag::wait_till("all_players_connected");
        level clientfield::increment("supertree_fall_init", 1);
        scene::add_scene_func("cin_bio_12_05_descend_vign_planc", &function_20ff3f32, "done");
        level thread scene::skipto_end("cin_bio_12_05_descend_vign_planc", undefined, undefined, 0.5);
        level thread function_492debfc(var_74cd64bc);
        var_a1a8c705 = spawner::simple_spawn("sp_supertrees_tree1_explode", &function_1c60cd10);
        level thread namespace_76133733::function_683d15e();
        hidemiscmodels("fxanim_fish");
    }
    level thread function_9c95d588();
    level thread function_d6919efd();
    level thread function_bfd61da4();
    level thread function_e0cc746();
    level.var_2fd26037 thread function_9c25cf32();
    level thread function_6738338b();
    level thread function_d656e12f();
    level.var_2fd26037 thread function_805505ea();
    level.var_2fd26037 notify(#"hash_93bef291");
    level.var_2fd26037 clearforcedgoal();
    level.var_2fd26037.goalradius = -56;
    level.var_2fd26037.goalheight = 80;
    level.var_2fd26037 colors::enable();
    level.var_2fd26037.var_fd3ee5eb = "tree1";
    level thread function_482775a2(0);
    level thread function_7c3cd57();
    trigger::wait_till("trig_supertrees_breadcrumb3");
    level flag::set("player_reached_top_finaltree");
    level waittill(#"hash_449ba453");
    cp_mi_sing_biodomes_util::function_1c1462ee("sm_supertrees_tree1_enemy1");
    cp_mi_sing_biodomes_util::function_1c1462ee("sm_supertrees_tree1_enemy2");
    cp_mi_sing_biodomes_util::function_1c1462ee("sm_supertrees_tree3_enemy1");
    cp_mi_sing_biodomes_util::function_1c1462ee("sm_supertrees_tree4_enemy1");
    cp_mi_sing_biodomes_util::function_1c1462ee("sm_supertrees_tree5_enemy1");
    cp_mi_sing_biodomes_util::function_1c1462ee("sm_supertrees_finaltree_enemy1");
    level skipto::function_be8adfb8("objective_supertrees");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0xa74c356b, Offset: 0x2d30
// Size: 0x2c
function function_20ff3f32(var_8a818774) {
    level flag::set("supertrees_intro_done");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0x988fa4fa, Offset: 0x2d68
// Size: 0xd4
function function_492debfc(var_74cd64bc) {
    if (!isdefined(var_74cd64bc)) {
        var_74cd64bc = 0;
    }
    battlechatter::function_d9f49fba(0);
    level flag::wait_till("supertrees_intro_done");
    level notify(#"hash_c8f7f782");
    level dialog::remote("kane_the_supertree_on_the_0");
    level.var_2fd26037 dialog::say("hend_copy_that_let_s_get_0");
    battlechatter::function_d9f49fba(1);
    level flag::set("supertrees_intro_vo_complete");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xb893423e, Offset: 0x2e48
// Size: 0xac
function function_9c95d588() {
    level waittill(#"hash_c8f7f782");
    var_3ecaa61 = struct::get("s_objective_treefinal", "targetname");
    objectives::set("cp_level_biodomes_supertrees_treefinal", var_3ecaa61);
    level flag::wait_till("player_ziplines_up_last_tree");
    level thread namespace_76133733::function_fcea1d9(3);
    objectives::complete("cp_level_biodomes_supertrees_treefinal");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x9fd7a6a0, Offset: 0x2f00
// Size: 0x12c
function function_d6919efd() {
    var_f652bfac = 11;
    var_2f184298 = level util::waittill_any_return("player_landed_on_tree2", "player_landed_on_tree3");
    level function_cc1f04a7(var_2f184298, var_f652bfac);
    savegame::checkpoint_save();
    var_2f184298 = level util::waittill_any_return("player_landed_on_tree4", "player_crossed_to_tree4", "player_landed_on_tree5");
    if (var_2f184298 == "player_crossed_to_tree4") {
        savegame::checkpoint_save();
    } else {
        level function_cc1f04a7(var_2f184298, var_f652bfac);
        savegame::checkpoint_save();
    }
    level util::waittill_any("player_landed_on_treefinal");
    savegame::checkpoint_save();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 2, eflags: 0x0
// Checksum 0x7e9ace80, Offset: 0x3038
// Size: 0x104
function function_cc1f04a7(var_3095dc45, n_timeout) {
    level flag::delay_set(7, "tree2_and_tree3_pursuit_allowed");
    var_aac0e4ef = function_52b6f57a(var_3095dc45);
    var_e4b1b0d6 = "vol_" + var_3095dc45;
    start_time = gettime();
    var_a4854031 = 1;
    while (var_a4854031) {
        current_time = gettime();
        var_e65455e6 = (current_time - start_time) / 1000;
        if (var_e65455e6 >= n_timeout) {
            break;
        }
        var_a4854031 = function_a4603364(var_e4b1b0d6, var_aac0e4ef);
        wait 0.25;
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 2, eflags: 0x0
// Checksum 0x690e5888, Offset: 0x3148
// Size: 0x14e
function function_a4603364(var_e4b1b0d6, var_aac0e4ef) {
    var_26884bd1 = getent(var_e4b1b0d6, "targetname");
    a_ai_enemies = getaiteamarray("axis");
    foreach (ai_enemy in a_ai_enemies) {
        if (ai_enemy istouching(var_26884bd1)) {
            return true;
        }
        if (isalive(ai_enemy) && ai_enemy.archetype === "hunter") {
            if (ai_enemy.var_aac0e4ef === var_aac0e4ef) {
                return true;
            }
        }
    }
    return false;
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x15bbdc57, Offset: 0x32a0
// Size: 0x27a
function function_bfd61da4() {
    trigger::wait_till("trig_supertrees_hunter_flyby1");
    spawn_manager::enable("sm_supertrees_finaltree_rpg");
    spawn_manager::enable("sm_supertrees_finaltree_reinforcements");
    trigger::wait_till("trig_finaltree_hendricks_zipline_go");
    spawn_manager::kill("sm_supertrees_finaltree_rpg");
    spawn_manager::kill("sm_supertrees_finaltree_reinforcements");
    var_df90cda = getactorteamarray("axis");
    foreach (ai in var_df90cda) {
        if (ai.var_fd3ee5eb === "treefinal" && !ai.var_23304c9e && ai.targetname != "sp_supertrees_finaltree_arsonists_ai") {
            foreach (player in level.activeplayers) {
                if (player.var_fd3ee5eb === "tree4" || player.var_fd3ee5eb === "tree5") {
                    ai.script_string = player.var_fd3ee5eb;
                    break;
                }
                ai.script_string = player.var_fd3ee5eb;
            }
            ai notify(#"hash_f3069794");
            ai thread function_76e355e1();
        }
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xf9135435, Offset: 0x3528
// Size: 0x338
function finaltree_rpg_guys() {
    self endon(#"death");
    level endon(#"hash_52434ccd");
    level endon(#"hash_75a4526b");
    self.var_fd3ee5eb = "treefinal";
    var_5bd22e42 = getnode(self.target, "targetname");
    if (isdefined(var_5bd22e42)) {
        self setgoal(var_5bd22e42, 1);
        self waittill(#"goal");
    }
    self.accuracy = 0.1;
    var_e6e6dfc8 = struct::get_array("s_finaltree_fake_rockets", "targetname");
    while (true) {
        e_closest_player = arraygetclosest(self.origin, level.activeplayers);
        if (isdefined(e_closest_player)) {
            var_bdb1a817 = array::random(var_e6e6dfc8);
            var_5e92b8ab = getweapon("smaw");
            var_8a86412d = 0;
            foreach (player in level.activeplayers) {
                if (player util::is_player_looking_at(var_bdb1a817.origin, 0.9, 1, player)) {
                    var_8a86412d = 1;
                    break;
                }
            }
            n_dist = distance2dsquared(e_closest_player.origin, self.origin);
            if (n_dist > self.engagemaxdist * self.engagemaxdist && !var_8a86412d) {
                magicbullet(var_5e92b8ab, var_bdb1a817.origin, e_closest_player.origin, self, e_closest_player, (400, 400, -56));
            } else {
                self thread ai::shoot_at_target("normal", e_closest_player, undefined);
            }
            if (e_closest_player.var_fd3ee5eb === "tree4" || e_closest_player.var_fd3ee5eb === "tree5") {
                break;
            }
        }
        wait 5;
    }
    self.accuracy = 1;
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x8fc6fbaf, Offset: 0x3868
// Size: 0x8c
function zipline_reinforcements() {
    self endon(#"death");
    level endon(#"hash_52434ccd");
    level endon(#"hash_75a4526b");
    if (isdefined(self.script_label)) {
        self.var_fd3ee5eb = self.script_label;
    } else {
        self.var_fd3ee5eb = "treefinal";
    }
    wait randomintrange(1, 4);
    self function_76e355e1();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x966d14b3, Offset: 0x3900
// Size: 0x1c8
function supertree_arsonists() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self.goalradius = 10;
    if (isdefined(self.script_label)) {
        self.var_fd3ee5eb = self.script_label;
    } else {
        self.var_fd3ee5eb = "treefinal";
    }
    self waittill(#"goal");
    e_align = util::spawn_model("tag_origin", self.origin, self.angles);
    var_9ef7554b = util::spawn_model("p7_container_medical_02", self.origin, self.angles);
    self thread function_e7da495a(var_9ef7554b, e_align);
    if (math::cointoss()) {
        e_align scene::play("cin_bio_13_03_treefight_vign_gas_pour_a", array(self, var_9ef7554b));
    } else {
        e_align scene::play("cin_bio_13_03_treefight_vign_gas_pour_b", array(self, var_9ef7554b));
    }
    e_align delete();
    self ai::set_ignoreall(0);
    self clearforcedgoal();
    self.goalradius = -56;
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 2, eflags: 0x0
// Checksum 0xc0b99135, Offset: 0x3ad0
// Size: 0x64
function function_e7da495a(var_9ef7554b, e_align) {
    self waittill(#"death");
    if (isdefined(var_9ef7554b)) {
        var_9ef7554b delete();
    }
    if (isdefined(e_align)) {
        e_align delete();
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xcc90b14, Offset: 0x3b40
// Size: 0x1ae
function function_76e355e1() {
    self endon(#"death");
    var_e3325966 = struct::get_array(self.var_fd3ee5eb, "script_label");
    var_e3325966 = array::randomize(var_e3325966);
    foreach (var_e60b519d in var_e3325966) {
        if (isdefined(self.script_string)) {
            if (isdefined(var_e60b519d.target)) {
                var_daa592e9 = struct::get(var_e60b519d.target, "targetname");
            } else {
                continue;
            }
            if (var_daa592e9.script_label === self.script_string) {
                self.target = var_e60b519d.targetname;
                self function_cdb04f99();
                break;
            }
            continue;
        }
        if (isdefined(var_e60b519d.target)) {
            self.target = var_e60b519d.targetname;
            self function_cdb04f99();
            break;
        }
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x6ab7a385, Offset: 0x3cf8
// Size: 0x114
function function_4331ad22() {
    self endon(#"death");
    level endon(#"hash_3a2c1be8");
    while (true) {
        self trigger::wait_till();
        if (self.targetname === "trig_supertrees_tree2_entered") {
            self.who.var_fd3ee5eb = "tree2";
        } else if (self.targetname === "trig_supertrees_tree4_entered") {
            self.who.var_fd3ee5eb = "tree4";
        }
        if (isplayer(self.who)) {
            level notify("player_crossed_to_" + self.who.var_fd3ee5eb);
            continue;
        }
        if (isactor(self.who)) {
            self.who notify("landed_on_" + self.who.var_fd3ee5eb);
        }
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x75ef32a8, Offset: 0x3e18
// Size: 0x2ec
function function_7c3cd57() {
    trigger::wait_till("trigger_supertrees_tree1_start");
    level flag::set("supertrees_tree1_started");
    if (level flag::get("supertrees_intro_vo_complete")) {
        battlechatter::function_d9f49fba(0);
        level.var_2fd26037 thread dialog::say("hend_pick_a_path_and_move_0");
        a_flags = array("tree1_interior", "tree1_exterior");
        level flag::wait_till_any(a_flags);
        if (level flag::get("tree1_interior")) {
            level dialog::function_13b3b16a("plyr_taking_interior_hen_0");
        } else {
            level dialog::function_13b3b16a("plyr_taking_exterior_hen_0");
        }
        level dialog::remote("kane_overwatch_shows_54i_0", 0.5);
        level.var_2fd26037 dialog::say("hend_that_leaning_tree_s_0");
        battlechatter::function_d9f49fba(1);
    }
    level flag::wait_till("supertrees_intro_vo_complete");
    var_9343c9b7 = getentarray("so_xiulan_supertree_loudspeaker", "targetname");
    wait 2;
    foreach (var_ea519684 in var_9343c9b7) {
        var_ea519684 thread dialog::say("xiul_immortals_hunt_dow_0", 0, 1);
    }
    battlechatter::function_d9f49fba(0);
    level.var_2fd26037 dialog::say("hend_shit_i_d_kinda_ho_0", 2);
    battlechatter::function_d9f49fba(1);
    level thread function_f6a22b91();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xe7698584, Offset: 0x4110
// Size: 0x15c
function function_f6a22b91() {
    level endon(#"hash_75a4526b");
    wait 4;
    level flag::wait_till("supertrees_hunter_arrival");
    level.var_2fd26037 dialog::say("hend_hunter_grab_some_co_0", 1);
    level.var_2fd26037 dialog::say("hend_don_t_let_that_hunte_0");
    level waittill(#"hash_38124849");
    level.var_2fd26037 thread dialog::say("hend_hunter_s_targeting_u_0");
    level waittill(#"hunter_sees_player");
    level.var_2fd26037 dialog::say("hend_hunter_moving_on_our_0");
    level waittill(#"hunter_sees_player");
    level.var_2fd26037 dialog::say("hend_eyes_up_hunter_comi_0", 6);
    level waittill(#"hunter_sees_player");
    level.var_2fd26037 dialog::say("hend_we_gotta_get_that_hu_0", 6);
    level dialog::remote("kane_there_s_no_time_hen_0");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x9be3b30f, Offset: 0x4278
// Size: 0x18c
function function_a87139db() {
    level endon(#"start_hendricks_dive");
    battlechatter::function_d9f49fba(0);
    level.var_2fd26037 dialog::say("hend_kane_they_re_trying_0");
    var_2d3d7b7 = [];
    var_2d3d7b7[0] = "kane_negative_that_s_you_0";
    var_2d3d7b7[1] = "kane_negative_that_s_you_1";
    level dialog::remote(cp_mi_sing_biodomes_util::function_7ff50323(var_2d3d7b7));
    level dialog::function_13b3b16a("plyr_what_no_plan_d_0");
    level.var_2fd26037 dialog::say("hend_now_is_not_the_time_0");
    battlechatter::function_d9f49fba(1);
    level flag::wait_till("any_player_reached_bottom_finaltree");
    battlechatter::function_d9f49fba(0);
    level.var_2fd26037 dialog::say("hend_kane_get_us_outta_h_0", 2);
    level dialog::remote("kane_get_to_the_elevators_0");
    battlechatter::function_d9f49fba(1);
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xa8f25753, Offset: 0x4410
// Size: 0x7c
function function_e0cc746() {
    var_7ec8ecac = spawner::simple_spawn_single("sp_enemy_bridge1_thrown");
    if (isalive(var_7ec8ecac)) {
        var_7ec8ecac endon(#"death");
        trigger::wait_till("trig_supertrees_hendricks_throw_bridge1");
        trigger::use("trig_supertrees_color_tree1_1");
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xf279408, Offset: 0x4498
// Size: 0x40
function function_8dba42a1() {
    while (isdefined(self)) {
        self trigger::wait_till();
        self.who thread function_3cd19f27(self);
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0xe0f7d4e4, Offset: 0x44e0
// Size: 0x94
function function_3cd19f27(var_e3ffd761) {
    self endon(#"death");
    var_e3ffd761 setinvisibletoplayer(self);
    while (self istouching(var_e3ffd761)) {
        var_ae0d7318 = randomfloatrange(1, 3);
        wait var_ae0d7318;
    }
    var_e3ffd761 setvisibletoplayer(self);
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xa7d924c4, Offset: 0x4580
// Size: 0xac
function function_805505ea() {
    trigger::wait_till("trig_supertrees_hunter_flyby1");
    level thread scene::init("cin_bio_13_02_treefight_vign_ziplinekill");
    trigger::wait_till("trig_supertrees_tree2_enemy2_zipline");
    if (spawner::get_ai_group_count("zipline_takedown") > 0) {
        level scene::play("cin_bio_13_02_treefight_vign_ziplinekill");
    }
    level flag::set("hendricks_played_supertree_takedown");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x33f5b044, Offset: 0x4638
// Size: 0x4c
function function_eb9e3e82() {
    self waittill(#"death");
    if (level scene::is_playing("cin_bio_13_02_treefight_vign_ziplinekill")) {
        level scene::stop("cin_bio_13_02_treefight_vign_ziplinekill");
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 3, eflags: 0x0
// Checksum 0x3e2ed012, Offset: 0x4690
// Size: 0xbc
function function_ff1892e(target, var_f3d436cd, var_8a5a20d0) {
    self endon(#"hash_3a2c1be8");
    self endon(#"death");
    var_8dc33a9 = util::spawn_model("tag_origin", target.origin, target.angles);
    while (true) {
        self setturrettargetent(var_8dc33a9);
        self thread vehicle_ai::fire_for_time(var_f3d436cd);
        wait var_f3d436cd + var_8a5a20d0;
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x1f94b884, Offset: 0x4758
// Size: 0x3c
function function_6738338b() {
    trigger::wait_till("trig_supertrees_finaltree_hunter");
    level thread clientfield::set("elevator_bottom_debris_play", 1);
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0xb77d4266, Offset: 0x47a0
// Size: 0x2d2
function function_482775a2(var_31b91f3a) {
    var_edc6e0e1 = spawner::simple_spawn_single("vtol_supertrees_crash");
    var_edc6e0e1 turret::enable(0, 0);
    level thread scene::init("p7_fxanim_cp_biodomes_super_tree_collapse_vtol_bundle", var_edc6e0e1);
    level thread function_a2bdd835();
    level flag::wait_till("start_supertree_crash");
    function_ebb6378a(var_edc6e0e1);
    level thread scene::play("p7_fxanim_cp_biodomes_super_tree_collapse_vtol_bundle", var_edc6e0e1);
    var_edc6e0e1 waittill(#"hash_fee929b6");
    playsoundatposition("wpn_rocket_explode", var_edc6e0e1.origin);
    level clientfield::increment("supertree_fall_play", 1);
    level thread function_3fbe7731();
    level flag::set("supertree_fall_played");
    trigger::wait_till("trig_supertrees_hunter_flyby1");
    level flag::set("supertrees_hunter_arrival");
    spawn_manager::enable("sm_supertrees_hunter");
    spawn_manager::function_740ea7ff("sm_supertrees_hunter", 1);
    var_325ce29e = spawn_manager::function_423eae50("sm_supertrees_hunter");
    var_325ce29e[0] flag::init("hunter_sees_player");
    var_325ce29e[0] thread function_de17e19c("info_volume_hunter_patrol_tree1");
    foreach (player in level.players) {
        player thread function_5f8f3618(var_325ce29e[0]);
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x6dce51c7, Offset: 0x4a80
// Size: 0x84
function function_a2bdd835() {
    for (a_enemies = getaiarray("supertrees_explode_enemies", "script_noteworthy"); a_enemies.size != 0; a_enemies = array::remove_dead(a_enemies)) {
        wait 0.05;
    }
    level flag::set("start_supertree_crash");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0xf81f49ae, Offset: 0x4b10
// Size: 0x124
function function_ebb6378a(var_edc6e0e1) {
    var_8af78429 = getweapon("hunter_rocket_turret");
    for (i = 1; i <= 2; i++) {
        s_start = struct::get("missile_attack_vtol_pos_" + i);
        magicbullet(var_8af78429, s_start.origin, var_edc6e0e1.origin + (0, 0, -64));
        wait 0.15;
    }
    var_edc6e0e1 util::waittill_notify_or_timeout("damage", 3);
    playsoundatposition("wpn_rocket_explode", var_edc6e0e1.origin);
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xb6d17693, Offset: 0x4c40
// Size: 0x34
function function_7d32eadb() {
    trigger::wait_till("trig_supertrees_finaltree_hunter");
    level thread function_6febb5e2();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xcef90922, Offset: 0x4c80
// Size: 0x24
function function_33cde320() {
    self waittill(#"death");
    level thread function_6febb5e2();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x426eaf06, Offset: 0x4cb0
// Size: 0xd2
function function_6febb5e2() {
    foreach (player in level.players) {
        if (isdefined(player getluimenu("HunterPatrolSightingMenu"))) {
            player closeluimenu(player getluimenu("HunterPatrolSightingMenu"));
        }
        player notify(#"hunter_sees_player");
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0xf99a9602, Offset: 0x4d90
// Size: 0x4e0
function function_de17e19c(var_13e51ee2) {
    self endon(#"death");
    self endon(#"hash_a2c295a");
    self.var_df1b2d54 = 0;
    var_13d45be4 = getentarray("hunter_supertree_patrol_volumes", "script_noteworthy");
    var_2ba4edf6 = getent(var_13e51ee2, "targetname");
    assert(isdefined(var_2ba4edf6), "<dev string:x28>");
    self vehicle_ai::start_scripted();
    self setvehgoalpos(var_2ba4edf6.origin, 1, 1);
    self.var_aac0e4ef = function_52b6f57a(var_2ba4edf6.targetname);
    self waittill(#"goal");
    while (true) {
        if (self flag::get("hunter_sees_player") && !level flag::get("player_reached_top_finaltree")) {
            self vehicle_ai::stop_scripted("combat");
            self setgoal(var_2ba4edf6, 1);
        }
        wait randomintrange(2, 5);
        if (self flag::get("hunter_sees_player") && !level flag::get("player_reached_top_finaltree")) {
            level notify(#"hash_38124849");
            level notify(#"hunter_sees_player");
            if (isdefined(self.attacker)) {
                var_8f2206cb = self.attacker;
            } else if (isdefined(self.enemy)) {
                var_8f2206cb = self.enemy;
            } else {
                var_8f2206cb = level.players[0];
            }
            var_2ba4edf6 = arraygetclosest(var_8f2206cb.origin, var_13d45be4);
            assert(isdefined(var_2ba4edf6), "<dev string:x28>");
            if (self.health < self.healthdefault * 0.75 && self.var_df1b2d54 === 0) {
                self.var_df1b2d54++;
                self function_d2eb46b7(var_8f2206cb);
            } else if (self.health < self.healthdefault * 0.4 && self.var_df1b2d54 === 1) {
                self.var_df1b2d54++;
                self function_d2eb46b7(var_8f2206cb);
            }
        } else {
            var_2ba4edf6 = getent(var_2ba4edf6.target, "targetname");
            assert(isdefined(var_2ba4edf6), "<dev string:x28>");
        }
        self clearlookatent();
        self vehicle_ai::start_scripted();
        self.var_aac0e4ef = function_52b6f57a(var_2ba4edf6.targetname);
        for (str_msg = "find_new_goal"; str_msg !== "goal"; str_msg = self util::waittill_any_timeout(6, "goal", "pathfind_failed")) {
            wait 1;
            n_dist_2d_sq = distance2dsquared(self.origin, var_2ba4edf6.origin);
            if (n_dist_2d_sq > 16384) {
                self setvehgoalpos(var_2ba4edf6.origin, 1, 1);
            }
        }
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0x453d3968, Offset: 0x5278
// Size: 0x5c
function function_52b6f57a(str_name) {
    var_a556a495 = strtok(str_name, "_");
    var_aac0e4ef = var_a556a495[var_a556a495.size - 1];
    return var_aac0e4ef;
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0xf0ab21e5, Offset: 0x52e0
// Size: 0xec
function function_d2eb46b7(var_8f2206cb) {
    var_2ed198ee = getentarray("hunter_supertree_retreat_volumes", "script_noteworthy");
    if (var_2ed198ee.size) {
        var_ec273240 = arraygetfarthest(var_8f2206cb.origin, var_2ed198ee);
        self clearlookatent();
        self vehicle_ai::start_scripted();
        self setvehgoalpos(var_ec273240.origin, 1, 1);
        self waittill(#"goal");
        wait randomintrange(6, 12);
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x2ad16b7c, Offset: 0x53d8
// Size: 0x364
function function_d656e12f() {
    trigger::wait_till("trig_supertrees_hunter_flyby2");
    if (spawner::get_ai_group_sentient_count("supertrees_hunter_aigroup") == 0) {
        var_ce310ae3 = spawner::simple_spawn_single("sp_hunter_supertree_boat_fire");
        var_ce310ae3 flag::init("hunter_sees_player");
    } else {
        var_2e9e2605 = spawner::get_ai_group_ai("supertrees_hunter_aigroup");
        var_ce310ae3 = var_2e9e2605[0];
    }
    var_ce310ae3 endon(#"death");
    var_ce310ae3 notify(#"hash_a2c295a");
    level thread function_f2c36556();
    var_2ba4edf6 = getent("info_volume_supertrees_hunter_patrol_end", "targetname");
    var_ce310ae3 vehicle_ai::start_scripted();
    var_ce310ae3 setvehgoalpos(var_2ba4edf6.origin, 1, 1);
    var_ce310ae3 waittill(#"goal");
    wait 2;
    var_8c0e2909 = struct::get_array("s_hunter_supertree_boat_fire", "targetname");
    assert(var_8c0e2909.size > 0, "<dev string:x5e>");
    var_8dc33a9 = util::spawn_model("tag_origin", var_8c0e2909[0].origin, var_8c0e2909[0].angles);
    var_ce310ae3 setlookatent(var_8dc33a9);
    var_ce310ae3 setturrettargetent(var_8dc33a9);
    wait 3;
    for (i = 0; i < 10; i++) {
        n_index = randomintrange(0, var_8c0e2909.size);
        e_target = var_8c0e2909[n_index];
        var_ce310ae3 hunter::function_ed543896(0, e_target.origin);
        wait 0.5;
    }
    wait 5;
    var_ce310ae3 clearlookatent();
    var_ce310ae3 clearturrettarget();
    var_8dc33a9 delete();
    var_ce310ae3 flag::set("hunter_sees_player");
    var_ce310ae3 thread function_de17e19c("info_volume_hunter_patrol_tree3");
}

/#

    // Namespace cp_mi_sing_biodomes_supertrees
    // Params 2, eflags: 0x0
    // Checksum 0xbebcaf61, Offset: 0x5748
    // Size: 0xdc
    function function_86a08a81(str_objective, var_74cd64bc) {
        cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
        level.var_2fd26037.var_fd3ee5eb = "<dev string:xb1>";
        foreach (player in level.players) {
            player.var_fd3ee5eb = "<dev string:xb1>";
        }
        level thread function_8b1a5d48();
    }

    // Namespace cp_mi_sing_biodomes_supertrees
    // Params 2, eflags: 0x0
    // Checksum 0xc61a1ea7, Offset: 0x5830
    // Size: 0xdc
    function function_6e6908bc(str_objective, var_74cd64bc) {
        cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
        level.var_2fd26037.var_fd3ee5eb = "<dev string:xb7>";
        foreach (player in level.players) {
            player.var_fd3ee5eb = "<dev string:xb7>";
        }
        level thread function_8b1a5d48();
    }

    // Namespace cp_mi_sing_biodomes_supertrees
    // Params 0, eflags: 0x0
    // Checksum 0x44143d35, Offset: 0x5918
    // Size: 0x19c
    function function_8b1a5d48() {
        level thread function_a2b40033();
        level thread function_ca1d2a2d();
        level.var_2fd26037 thread function_9c25cf32();
        level thread function_6738338b();
        level flag::set("<dev string:xbd>");
        level flag::wait_till("<dev string:xe1>");
        var_3ecaa61 = struct::get("<dev string:xf5>", "<dev string:x10b>");
        objectives::set("<dev string:x116>", var_3ecaa61);
        level thread function_9c95d588();
        level thread function_bfd61da4();
        level flag::set("<dev string:x13d>");
        var_a6557ae = getentarray("<dev string:x157>", "<dev string:x10b>");
        var_a6557ae[0] trigger::use();
        level thread function_f2c36556();
    }

#/

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x9729741e, Offset: 0x5ac0
// Size: 0x36c
function function_f2c36556() {
    spawner::simple_spawn("sp_supertrees_rpg_boat_fire", &function_b0272bca);
    level thread function_b1436bdb();
    wait 1;
    if (isdefined(level.var_4aa51716)) {
        level thread [[ level.var_4aa51716 ]]();
    }
    exploder::exploder("fx_expl_fire_prehunter_supertree");
    wait 3;
    level notify(#"hash_75a4526b");
    exploder::exploder("fx_expl_fire_posthunter_supertree");
    exploder::exploder("fx_expl_fire_arrivetop_supertree");
    exploder::exploder("fx_expl_fire_lowerplatform_supertree");
    level thread function_a87139db();
    level waittill(#"hash_52434ccd");
    level clientfield::set("boat_explosion_play", 1);
    exploder::exploder("fx_expl_fire_zip_explode");
    wait 1;
    function_44ec4f8f();
    wait 1;
    function_44ec4f8f();
    var_65051b38 = trigger::wait_till("trig_final_zipline_for_one");
    level notify(#"hash_b0ab1d93");
    foreach (player in level.players) {
        if (isdefined(player.var_23304c9e) && player.var_23304c9e) {
            player function_f74e47aa();
        }
    }
    if (level.var_2fd26037 flag::get("hendricks_on_zipline")) {
        level.var_2fd26037 function_cac74662();
    }
    level thread scene::play("cin_bio_14_01_treejump_vign_elevator_shaft_hendricks");
    level thread scene::play("cin_bio_13_03_treefight_1st_zipline", var_65051b38.who);
    level waittill(#"hash_ecb1951e");
    level util::function_93831e79("dive_start_igc");
    if (level.var_2fd26037.origin[2] < 4572) {
        level.var_2fd26037 skipto::function_d9b1ee00(struct::get("dive_start_igc_hendricks"));
    }
    level notify(#"hash_449ba453");
    level thread start_hendricks_dive();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x6354666d, Offset: 0x5e38
// Size: 0xba
function function_44ec4f8f() {
    var_beecfae5 = struct::get_array("final_zipline_explosion_location");
    foreach (struct in var_beecfae5) {
        playrumbleonposition("cp_biodomes_zipline_explosion_positional_rumble", struct.origin);
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x951c8f50, Offset: 0x5f00
// Size: 0x142
function function_b1436bdb() {
    var_5e92b8ab = getweapon("smaw");
    var_5e2b4bef = struct::get_array("s_final_supertree_fake_rocket_dests", "targetname");
    var_55ad5a1e = struct::get("s_final_supertree_fake_rocket_start", "targetname");
    if (isdefined(var_55ad5a1e) && isdefined(var_5e2b4bef)) {
        foreach (dest in var_5e2b4bef) {
            magicbullet(var_5e92b8ab, var_55ad5a1e.origin, dest.origin);
            wait 0.25;
        }
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x640fedc4, Offset: 0x6050
// Size: 0x194
function function_b0272bca() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    var_5bd22e42 = getnode(self.target, "targetname");
    if (isdefined(var_5bd22e42)) {
        self setgoal(var_5bd22e42, 1);
        self waittill(#"goal");
    }
    var_2dcf8554 = struct::get_array("s_hunter_supertree_boat_fire", "targetname");
    var_b10a5b26 = arraygetclosest(self.origin, var_2dcf8554);
    if (isdefined(var_b10a5b26)) {
        mdl_target = util::spawn_model("tag_origin", var_b10a5b26.origin, var_b10a5b26.angles);
        self thread function_f2bd3676();
        self ai::shoot_at_target("normal", mdl_target, "tag_origin", 10, 10);
        mdl_target delete();
    }
    self ai::set_ignoreall(0);
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xdb88c8c2, Offset: 0x61f0
// Size: 0x100
function function_f2bd3676() {
    self endon(#"death");
    self endon(#"stop_shoot_at_target");
    while (true) {
        foreach (player in level.activeplayers) {
            if (isdefined(player)) {
                n_dist = distance2dsquared(player.origin, self.origin);
                if (n_dist < 90000) {
                    self ai::stop_shoot_at_target();
                }
            }
        }
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0x14c99e50, Offset: 0x62f8
// Size: 0x144
function function_5068f9bd(a_ents) {
    level waittill(#"hash_a668dfbe");
    player = a_ents["player 1"];
    player fx::play("explosion_zipline_up", player.origin + (0, 0, -150), undefined, "elevator_fire_stops", 1);
    player clientfield::set_to_player("zipline_rumble_loop", 1);
    level waittill(#"elevator_fire_stops");
    player clientfield::set_to_player("zipline_rumble_loop", 0);
    var_38a15f56 = getent("fx_fire_elevator", "targetname");
    if (isdefined(var_38a15f56)) {
        var_38a15f56 fx::play("explosion_zipline_up", var_38a15f56.origin, undefined);
    }
    level thread clientfield::set("elevator_top_debris_play", 1);
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0xb71765e5, Offset: 0x6448
// Size: 0x2b8
function function_5f8f3618(var_11976e03) {
    self endon(#"disconnect");
    self endon(#"hunter_sees_player");
    self endon(#"disconnect");
    var_11976e03 endon(#"death");
    n_timer = 0;
    n_alpha = 1;
    alpha = 0;
    level thread function_7d32eadb();
    var_11976e03 thread function_33cde320();
    while (true) {
        distance_sq = distance2dsquared(self.origin, var_11976e03.origin);
        if (var_11976e03 util::is_looking_at(self, 0.5, 1) && !self laststand::player_is_in_laststand() && distance_sq <= 6250000) {
            n_timer += 0.05;
            if (n_timer > 1.25) {
                level notify(#"hash_38124849");
            }
            if (n_timer > 5) {
                n_timer = 5;
            }
            n_alpha = n_timer / 5;
        } else if (!var_11976e03 util::is_looking_at(self, 0.5, 1) || distance_sq > 6250000) {
            n_timer -= 0.05;
            if (n_timer < 0) {
                n_timer = 0;
            }
            n_alpha = n_timer / 5;
        }
        if (n_timer >= 5 || var_11976e03.health < var_11976e03.healthdefault * 0.9 || var_11976e03 flag::get("hunter_sees_player")) {
            n_timer = 0;
            var_11976e03 flag::set("hunter_sees_player");
            var_11976e03 ai::set_ignoreme(0);
            level thread function_6febb5e2();
        }
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x2be6e227, Offset: 0x6708
// Size: 0x1c4
function function_3fbe7731() {
    s_tree = struct::get("hunter_target_tree1_1", "targetname");
    assert(isdefined(s_tree), "<dev string:x175>");
    playrumbleonposition("cp_biodomes_supertree_collapse_1_rumble", s_tree.origin);
    level notify(#"hash_706115bc");
    var_c889b49e = spawner::simple_spawn("sp_supertree_tree1_wounded", &function_ac17866e);
    level thread function_5cfa83d9("sp_supertrees_treecrash_ragdolls1", 2, (80, 15, 90), 0, 0.25);
    level thread function_5cfa83d9("sp_supertrees_treecrash_ragdolls2", 2, (80, 15, 100), 0, 0.25);
    wait 4;
    playrumbleonposition("cp_biodomes_supertree_collapse_2_rumble", s_tree.origin);
    wait 5;
    playrumbleonposition("cp_biodomes_supertree_collapse_3_rumble", s_tree.origin);
    if (!spawn_manager::is_enabled("sm_supertrees_wasp1")) {
        spawn_manager::enable("sm_supertrees_wasp1");
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 5, eflags: 0x0
// Checksum 0xe6bc1882, Offset: 0x68d8
// Size: 0x18e
function function_5cfa83d9(str_spawner, var_ee8ca7aa, v_velocity, min_delay, max_delay) {
    if (!isdefined(min_delay)) {
        min_delay = 0;
    }
    if (!isdefined(max_delay)) {
        max_delay = 0.1;
    }
    for (i = 0; i < var_ee8ca7aa; i++) {
        ai = spawner::simple_spawn_single(str_spawner);
        ai startragdoll();
        var_1d83c20f = randomintrange(-5, 5);
        var_f78147a6 = randomintrange(-5, 5);
        var_d17ecd3d = randomintrange(-5, 5);
        v_velocity += (var_1d83c20f, var_f78147a6, var_d17ecd3d);
        ai launchragdoll(v_velocity);
        ai kill();
        wait randomfloatrange(min_delay, max_delay);
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 5, eflags: 0x0
// Checksum 0xb1e845e2, Offset: 0x6a70
// Size: 0x148
function function_29eec7b2(var_effa55fa, start_index, end_index, min_delay, max_delay) {
    if (!isdefined(min_delay)) {
        min_delay = 1;
    }
    if (!isdefined(max_delay)) {
        max_delay = 1;
    }
    for (i = start_index; i <= end_index; i++) {
        var_96f9f90c = struct::get(var_effa55fa + "_" + i, "targetname");
        assert(isdefined(var_96f9f90c), "<dev string:x19b>" + var_effa55fa + "<dev string:x1c2>" + i);
        self hunter::function_ed543896(0, var_96f9f90c);
        wait_time = randomfloatrange(min_delay, max_delay + 0.01);
        wait wait_time;
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x38e30017, Offset: 0x6bc0
// Size: 0x146
function function_5a80eb84() {
    while (isdefined(self) && self istriggerenabled()) {
        self trigger::wait_till();
        level flag::set("any_player_reached_bottom_finaltree");
        if (self.who == level.players[0]) {
            level flag::set("player_reached_bottom_finaltree");
            var_6cfd4078 = getentarray("reached_finaltree_triggers", "script_noteworthy");
            foreach (trigger in var_6cfd4078) {
                trigger triggerenable(0);
            }
        }
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x3de81489, Offset: 0x6d10
// Size: 0x23c
function function_9c25cf32() {
    self endon(#"hash_57ce910f");
    var_3dc3d229 = trigger::wait_till("trig_finaltree_hendricks_zipline_go");
    self flag::wait_till_clear("hendricks_on_zipline");
    if (self.var_fd3ee5eb == "tree3") {
        self.script_string = var_3dc3d229.script_label;
        self function_76e355e1();
    } else if (self.var_fd3ee5eb == "tree2") {
        self.var_fd3ee5eb = "tree4";
        self function_76e355e1();
    } else if (self.var_fd3ee5eb == "tree1") {
        if (!level flag::get("hendricks_played_supertree_takedown")) {
            level scene::stop("cin_bio_13_02_treefight_vign_ziplinekill");
        }
        self.script_string = "tree3";
        self function_76e355e1();
        self.script_string = var_3dc3d229.script_label;
        self function_76e355e1();
    }
    self.script_string = "treefinal";
    self function_76e355e1();
    level flag::set("hendricks_reached_finaltree");
    self colors::disable();
    self clearforcedgoal();
    var_dfcbd82b = getnode("hendricks_elevator_goal", "targetname");
    self setgoal(var_dfcbd82b);
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 4, eflags: 0x0
// Checksum 0x986226ea, Offset: 0x6f58
// Size: 0x5c
function objective_supertrees_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_769dc23f::function_4b47f9f6();
    namespace_769dc23f::function_16509d1f();
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_supertrees_done");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 2, eflags: 0x0
// Checksum 0xaadf41e0, Offset: 0x6fc0
// Size: 0x33c
function objective_dive_init(str_objective, var_74cd64bc) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_dive_init");
    spawn_manager::kill("sm_supertrees_hunter");
    showmiscmodels("fxanim_fish");
    level notify(#"hash_3a2c1be8");
    level thread function_a2b40033();
    if (var_74cd64bc) {
        load::function_73adcefc();
        cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
        objectives::complete("cp_level_biodomes_supertrees_treefinal");
        level flag::set("supertrees_hunter_arrival");
        level flag::set("player_reached_bottom_finaltree");
        level flag::set("player_reached_top_finaltree");
        level flag::set("any_player_reached_bottom_finaltree");
        level flag::set("hendricks_played_supertree_takedown");
        exploder::exploder("fx_expl_fire_prehunter_supertree");
        exploder::exploder("fx_expl_fire_arrivetop_supertree");
        level thread start_hendricks_dive(var_74cd64bc);
        level clientfield::set("elevator_top_debris_play", 1);
        level clientfield::set("boat_explosion_play", 1);
        level thread namespace_76133733::function_973b77f9();
        load::function_a2995f22();
    }
    level.var_2fd26037 notify(#"hash_3a2c1be8");
    level.var_2fd26037 ai::set_behavior_attribute("sprint", 0);
    level.var_2fd26037 ai::set_ignoreall(0);
    level util::clientnotify("sndRamp");
    level thread function_ca1d2a2d();
    level thread cp_mi_sing_biodomes_swamp::function_b52b6eac();
    array::thread_all(level.players, &cp_mi_sing_biodomes_swamp::function_39af75ef, "boats_go");
    level flag::wait_till("player_dive_done");
    level.var_2fd26037 ai::set_ignoreall(0);
    level skipto::function_be8adfb8("objective_dive");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xa4212bb, Offset: 0x7308
// Size: 0x42
function function_863b63b5() {
    level endon(#"start_hendricks_dive");
    wait 12;
    level.var_2fd26037 dialog::say("hend_we_re_dead_if_we_don_0");
    level notify(#"top_of_supertree_explosion");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0xc5ca9f0, Offset: 0x7358
// Size: 0x1cc
function start_hendricks_dive(var_74cd64bc) {
    if (!isdefined(var_74cd64bc)) {
        var_74cd64bc = 0;
    }
    if (var_74cd64bc) {
        level flag::wait_till("first_player_spawned");
    }
    level thread scene::play("cin_bio_14_01_treejump_vign_dive");
    wait 2;
    level notify(#"hash_3d6e28");
    if (isdefined(level.var_e32d12f3)) {
        level thread [[ level.var_e32d12f3 ]]();
    }
    var_c908f76f = struct::get("s_waypoint_supertree_jump");
    assert(isdefined(var_c908f76f), "<dev string:x1c4>");
    level objectives::set("cp_level_biodomes_jump_from_supertree", var_c908f76f);
    if (!level flag::get("start_hendricks_dive")) {
        level thread function_863b63b5();
        level flag::wait_till("start_hendricks_dive");
    }
    level.var_2fd26037 ai::set_ignoreall(1);
    level util::delay_notify(2, "top_of_supertree_explosion");
    level scene::play("cin_bio_14_01_treejump_vign_dive_end");
    level.var_2fd26037 cp_mi_sing_biodomes_swamp::function_dd9ded92();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 4, eflags: 0x0
// Checksum 0x3bec7891, Offset: 0x7530
// Size: 0x60
function objective_dive_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_dive_done");
    objectives::complete("cp_level_biodomes_jump_from_supertree");
    level.var_adcba170 = 1;
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x9246cf95, Offset: 0x7ee0
// Size: 0x64
function function_c85169ef() {
    level.var_77a37a25 = [];
    var_1f0c83ec = getentarray("zipline_gates", "script_parameters");
    array::thread_all(var_1f0c83ec, &function_b41f17f2);
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x2b95a6b8, Offset: 0x7f50
// Size: 0x38
function function_b41f17f2() {
    var_1eb88afc = new class_ba668242();
    [[ var_1eb88afc ]]->init(self.targetname);
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 2, eflags: 0x0
// Checksum 0xc4d4e077, Offset: 0x7f90
// Size: 0x1e0
function zipline_gates(e_start, var_f9abb8b0) {
    self endon(#"death");
    if (isdefined(e_start.script_parameters)) {
        foreach (var_82e417eb in level.var_77a37a25) {
            if ([[ var_82e417eb ]]->function_cabbdf40() == e_start.script_parameters) {
                var_afe093cf = var_82e417eb;
                break;
            }
        }
        foreach (var_82e417eb in level.var_77a37a25) {
            if ([[ var_82e417eb ]]->function_83f15319() == [[ var_afe093cf ]]->function_cabbdf40()) {
                var_76df13c1 = var_82e417eb;
                break;
            }
        }
    }
    if (isdefined(var_afe093cf) && isdefined(var_76df13c1)) {
        thread [[ var_afe093cf ]]->function_c3e1dff0();
        thread [[ var_76df13c1 ]]->function_c3e1dff0();
        var_f9abb8b0 waittill(#"movedone");
        thread [[ var_afe093cf ]]->function_c0cdf2d2();
        thread [[ var_76df13c1 ]]->function_c0cdf2d2();
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x5a7f8fb6, Offset: 0x8178
// Size: 0x54
function function_fd35e580() {
    var_9d26d41c = getentarray("zipline_trigger", "script_noteworthy");
    array::thread_all(var_9d26d41c, &function_36934515);
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x2e0b7c59, Offset: 0x81d8
// Size: 0x198
function function_36934515() {
    self endon(#"death");
    level flag::wait_till("all_players_connected");
    self.var_5356d2cc = util::function_14518e76(self, %cp_prompt_zipline_biodomes_use, %CP_MI_SING_BIODOMES_ZIPLINE_USE, &function_cbfdcddd);
    self.var_5356d2cc thread gameobjects::function_e0e2d0fe((1, 1, 1), 400, 0);
    s_start = struct::get(self.target, "targetname");
    assert(isdefined(s_start), "<dev string:x1f3>" + self.origin + "<dev string:x208>");
    s_end = struct::get(s_start.target, "targetname");
    assert(isdefined(s_end), "<dev string:x243>" + s_start.origin + "<dev string:x265>");
    while (true) {
        self waittill(#"hash_4032ce0f", player);
        player zipline_player(self, s_start, s_end);
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0x320ee68a, Offset: 0x8378
// Size: 0x7e
function function_cbfdcddd(player) {
    self.trigger notify(#"hash_4032ce0f", player);
    if (isdefined(self.trigger.script_parameters)) {
        if (self.trigger.script_parameters == "gate_tree_4b" || self.trigger.script_parameters == "gate_tree_5b") {
            level notify(#"hash_52434ccd");
        }
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 3, eflags: 0x0
// Checksum 0xaea49b59, Offset: 0x8400
// Size: 0x9d4
function zipline_player(trigger, s_start, s_end) {
    self endon(#"death");
    self.var_23304c9e = 1;
    var_ad470f8c = util::spawn_model("tag_origin", self.origin, s_start.angles, 0, 0);
    self playerlinktodelta(var_ad470f8c, undefined, 1, 20, 20, 15, 60);
    n_dist = distance(s_start.origin, s_end.origin);
    n_time = n_dist / 400;
    self thread function_ace0977c();
    self disableweaponcycling();
    self disableoffhandweapons();
    self allowcrouch(0);
    self allowprone(0);
    level notify(#"disable_cybercom", self, 1);
    var_ad470f8c playsoundtoplayer("evt_zipline_attach", self);
    m_player_fake = util::spawn_player_clone(self);
    var_f4ce3e5 = util::spawn_model("wpn_t7_zipline_trolley_prop", m_player_fake gettagorigin("tag_weapon_left"), m_player_fake gettagangles("tag_weapon_left"));
    var_f4ce3e5 linkto(m_player_fake, "tag_weapon_left");
    var_f4ce3e5 setowner(self);
    w_current = self.currentweapon;
    var_9f2c3e1c = self function_1caa9276();
    m_weapon_fake = util::spawn_model(var_9f2c3e1c.worldmodel, m_player_fake gettagorigin("tag_weapon_right"), m_player_fake gettagangles("tag_weapon_right"));
    m_weapon_fake linkto(m_player_fake, "tag_weapon_right");
    m_weapon_fake setowner(self);
    if (var_9f2c3e1c === level.var_135a01e4) {
        self.var_42a705b8 = 0;
        self disableweapons();
        self setclientuivisibilityflag("weapon_hud_visible", 0);
    }
    m_player_fake clientfield::set("clone_control", 1);
    var_f4ce3e5 clientfield::set("clone_control", 1);
    m_weapon_fake clientfield::set("clone_control", 1);
    self ghost();
    self.var_fd3ee5eb = s_end.script_label;
    var_ad470f8c.origin = self.origin;
    var_ad470f8c.angles = self.angles;
    if (self.var_42a705b8) {
        m_player_fake thread animation::play("pb_pistol_zipline_enter", var_ad470f8c, "tag_origin");
    } else {
        m_player_fake thread animation::play("pb_zipline_enter", var_ad470f8c, "tag_origin");
    }
    var_ad470f8c moveto(s_start.origin, 0.25);
    var_ad470f8c rotateto(s_start.angles, 0.25);
    var_ad470f8c waittill(#"movedone");
    self playrumbleonentity("cp_biodomes_zipline_attach_rumble");
    self thread zipline_gates(trigger, var_ad470f8c);
    if (self == level.players[0] && !level flag::get("player_reached_final_zipline")) {
        level.var_2fd26037 thread function_b5e8c4c0(s_start);
    }
    if (self.var_42a705b8) {
        m_player_fake thread animation::play("pb_pistol_zipline_loop", var_ad470f8c, "tag_origin");
    } else {
        m_player_fake thread animation::play("pb_zipline_loop", var_ad470f8c, "tag_origin");
    }
    self clientfield::set_to_player("zipline_speed_blur", 1);
    self clientfield::set_to_player("zipline_rumble_loop", 1);
    self playloopsound("evt_zipline_move", 0.3);
    var_ad470f8c moveto(s_end.origin, n_time, 0, 0);
    var_ad470f8c waittill(#"movedone");
    self unlink();
    v_forward = anglestoforward(self.angles);
    self setvelocity(v_forward * 300);
    self playrumbleonentity("cp_biodomes_zipline_dismount_rumble");
    self clientfield::set_to_player("zipline_rumble_loop", 0);
    self clientfield::set_to_player("zipline_speed_blur", 0);
    self stoploopsound(0.5);
    v_on_navmesh = getclosestpointonnavmesh(var_ad470f8c.origin, 72, 48);
    if (isdefined(v_on_navmesh)) {
        if (self.var_42a705b8) {
            m_player_fake thread animation::play("pb_pistol_zipline_exit", var_ad470f8c, "tag_origin");
        } else {
            m_player_fake thread animation::play("pb_zipline_exit", var_ad470f8c, "tag_origin");
        }
        var_ad470f8c moveto(v_on_navmesh, 0.25);
        var_ad470f8c waittill(#"movedone");
    } else {
        var_ccacea03 = groundtrace(self.origin, self.origin + (0, 0, -100000), 0, undefined, 1)["position"];
        var_ad470f8c moveto(var_ccacea03, 0.25);
    }
    self notify(#"hash_4d91a838");
    level notify("player_landed_on_" + self.var_fd3ee5eb);
    m_player_fake clientfield::set("clone_control", 0);
    var_f4ce3e5 clientfield::set("clone_control", 0);
    m_weapon_fake clientfield::set("clone_control", 0);
    var_ad470f8c delete();
    m_weapon_fake delete();
    var_f4ce3e5 delete();
    self show();
    m_player_fake hide();
    util::wait_network_frame();
    m_player_fake delete();
    self function_1ed1ef36();
    self takeweapon(var_9f2c3e1c);
    self switchtoweaponimmediate(w_current);
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x7767ba82, Offset: 0x8de0
// Size: 0xbc
function function_1ed1ef36() {
    if (!self.var_42a705b8) {
        self enableweapons();
        self setclientuivisibilityflag("weapon_hud_visible", 1);
    }
    self enableweaponcycling();
    self enableoffhandweapons();
    self allowcrouch(1);
    self allowprone(1);
    level notify(#"enable_cybercom", self);
    self.var_23304c9e = 0;
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xbe3bf793, Offset: 0x8ea8
// Size: 0x9c
function function_f74e47aa() {
    self notify(#"hash_9d906207");
    self unlink();
    self clientfield::set_to_player("zipline_rumble_loop", 0);
    self clientfield::set_to_player("zipline_speed_blur", 0);
    self notify(#"hash_4d91a838");
    self show();
    self function_1ed1ef36();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x66bcb3fe, Offset: 0x8f50
// Size: 0x4c
function function_ace0977c() {
    self endon(#"death");
    self enableinvulnerability();
    self waittill(#"hash_4d91a838");
    wait 2;
    self disableinvulnerability();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x21c68107, Offset: 0x8fa8
// Size: 0x5c8
function function_1caa9276() {
    self.var_42a705b8 = 0;
    if (self.currentweapon.weapclass == "pistol") {
        self.var_42a705b8 = 1;
        var_d1f13390 = self.currentweapon;
    } else {
        if (isdefined(self.weapon_array_primary)) {
            foreach (weapon in self.weapon_array_primary) {
                if (weapon.weapclass === "pistol") {
                    self.var_42a705b8 = 1;
                    var_d1f13390 = weapon;
                    break;
                }
            }
        }
        if (isdefined(self.weapon_array_sidearm)) {
            foreach (weapon in self.weapon_array_sidearm) {
                if (weapon.weapclass === "pistol") {
                    self.var_42a705b8 = 1;
                    var_d1f13390 = weapon;
                    break;
                }
            }
        }
    }
    var_64026dbd = [];
    if (isdefined(var_d1f13390)) {
        n_ammo_clip = self getweaponammoclip(var_d1f13390);
        n_ammo_stock = self getweaponammostock(var_d1f13390);
        var_64026dbd = var_d1f13390.attachments;
    }
    if (self.var_42a705b8) {
        if (var_d1f13390.rootweapon == level.var_957c9ba0) {
            var_9f2c3e1c = level.var_ad139ea;
        } else if (var_d1f13390.rootweapon == level.var_d582416e) {
            var_9f2c3e1c = level.var_17a1f194;
        } else if (var_d1f13390.rootweapon == level.var_8ffd4cdb) {
            var_9f2c3e1c.rootweapon = level.var_d397bc89;
        } else if (var_d1f13390.rootweapon == level.var_44a0465d) {
            var_9f2c3e1c = level.var_80242247;
        } else if (self.var_42a705b8) {
            var_9f2c3e1c = level.var_17a1f194;
        }
        switch (var_64026dbd.size) {
        case 1:
            var_9f2c3e1c = getweapon(var_9f2c3e1c.name, var_64026dbd[0]);
            break;
        case 2:
            var_9f2c3e1c = getweapon(var_9f2c3e1c.name, var_64026dbd[0], var_64026dbd[1]);
            break;
        case 3:
            var_9f2c3e1c = getweapon(var_9f2c3e1c.name, var_64026dbd[0], var_64026dbd[1], var_64026dbd[2]);
            break;
        case 4:
            var_9f2c3e1c = getweapon(var_9f2c3e1c.name, var_64026dbd[0], var_64026dbd[1], var_64026dbd[2], var_64026dbd[3]);
            break;
        default:
            break;
        }
    } else if (self hasweapon(level.var_957c9ba0, 1)) {
        var_9f2c3e1c = level.var_ad139ea;
    } else if (self hasweapon(level.var_d582416e, 1)) {
        var_9f2c3e1c = level.var_17a1f194;
    } else if (self hasweapon(level.var_8ffd4cdb, 1)) {
        var_9f2c3e1c = level.var_d397bc89;
    } else if (self hasweapon(level.var_44a0465d, 1)) {
        var_9f2c3e1c = level.var_80242247;
    } else {
        var_9f2c3e1c = level.var_135a01e4;
    }
    self giveweapon(var_9f2c3e1c);
    self switchtoweaponimmediate(var_9f2c3e1c);
    if (isdefined(var_d1f13390)) {
        self setweaponammoclip(var_9f2c3e1c, n_ammo_clip);
        self setweaponammostock(var_9f2c3e1c, n_ammo_stock);
        self thread function_5cab4471(var_9f2c3e1c, var_d1f13390);
    }
    return var_9f2c3e1c;
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 2, eflags: 0x0
// Checksum 0x9c193bea, Offset: 0x9578
// Size: 0x8c
function function_5cab4471(var_9f2c3e1c, var_d1f13390) {
    self endon(#"death");
    self waittill(#"hash_4d91a838");
    self setweaponammoclip(var_d1f13390, self getweaponammoclip(var_9f2c3e1c));
    self setweaponammostock(var_d1f13390, self getweaponammostock(var_9f2c3e1c));
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0xffa3bc89, Offset: 0x9610
// Size: 0xac
function function_b5e8c4c0(var_53525ae3) {
    level endon(#"player_reached_final_zipline");
    self flag::wait_till_clear("hendricks_on_zipline");
    self notify(#"hash_93bef291");
    if (!level flag::get("hendricks_played_supertree_takedown")) {
        level scene::stop("cin_bio_13_02_treefight_vign_ziplinekill");
    }
    self.target = var_53525ae3.targetname;
    self thread function_cdb04f99();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x3a531c72, Offset: 0x96c8
// Size: 0x834
function function_cdb04f99() {
    s_start = struct::get(self.target, "targetname");
    assert(isdefined(s_start), "<dev string:x2a1>" + self.origin + "<dev string:x208>");
    s_end = struct::get(s_start.target, "targetname");
    assert(isdefined(s_end), "<dev string:x243>" + s_start.origin + "<dev string:x265>");
    self.var_fd3ee5eb = s_start.script_label;
    if (self == level.var_2fd26037) {
        self endon(#"hash_57ce910f");
        self colors::disable();
        self flag::set("hendricks_on_zipline");
    }
    self endon(#"death");
    self endon(#"hash_f3069794");
    var_ccacea03 = groundtrace(s_start.origin, s_start.origin + (0, 0, -100000), 0, self, 1)["position"];
    if (isdefined(var_ccacea03)) {
        self setgoal(var_ccacea03, 1);
        var_c312dab9 = util::spawn_model("tag_origin", var_ccacea03, s_start.angles);
    } else {
        self setgoal(var_ccacea03, 1);
        var_c312dab9 = util::spawn_model("tag_origin", s_start.origin, s_start.angles);
    }
    self waittill(#"goal");
    if (self.var_fd3ee5eb == "tree4" || self == level.var_2fd26037 && self.var_fd3ee5eb == "tree5") {
        exploder::exploder("fx_expl_fire_leadzip_explode");
        level thread util::delay(1.5, undefined, &function_44ec4f8f);
    }
    self ai::set_ignoreall(0);
    self.var_23304c9e = 1;
    n_dist = distance(s_start.origin, s_end.origin);
    if (self == level.var_2fd26037) {
        n_time = n_dist / 400;
    } else {
        n_time = n_dist / 350;
        self.health = 5;
    }
    var_b39127dd = util::spawn_model("wpn_t7_zipline_trolley_prop", self gettagorigin("tag_weapon_left"), self gettagangles("tag_weapon_left"));
    var_b39127dd linkto(self, "tag_weapon_left");
    if (self == level.var_2fd26037) {
        self.var_ae65ed78 = var_b39127dd;
        self.e_mover = var_c312dab9;
    } else {
        self thread function_e87de176(array(var_c312dab9, var_b39127dd));
    }
    var_c312dab9.origin = self.origin;
    var_c312dab9.angles = self.angles;
    var_c312dab9 thread scene::play("cin_gen_traversal_zipline_enemy02_attach", self);
    self waittill(#"hash_8c8d4197");
    var_c312dab9 moveto(s_start.origin, 0.33);
    var_c312dab9 rotateto(s_start.angles, 0.33);
    var_c312dab9 waittill(#"movedone");
    var_c312dab9 thread scene::play("cin_gen_traversal_zipline_enemy02_idle", self);
    var_c312dab9 moveto(s_end.origin, n_time);
    self thread zipline_gates(s_start, var_c312dab9);
    self thread function_c936992e();
    var_c312dab9 util::waittill_notify_or_timeout("movedone", 8);
    v_on_navmesh = getclosestpointonnavmesh(var_c312dab9.origin, 72, 36);
    if (isdefined(v_on_navmesh)) {
        var_c312dab9 moveto(v_on_navmesh, 0.25);
    } else {
        var_ccacea03 = groundtrace(self.origin, self.origin + (0, 0, -100000), 0, undefined, 1)["position"];
        var_c312dab9 moveto(var_ccacea03, 0.25);
    }
    var_c312dab9 scene::play("cin_gen_traversal_zipline_enemy02_dismount", self);
    self notify(#"hash_4d91a838");
    self notify("landed_on_" + self.var_fd3ee5eb);
    self unlink();
    self.var_fd3ee5eb = s_end.script_label;
    self clearforcedgoal();
    self ai::set_behavior_attribute("sprint", 0);
    util::wait_network_frame();
    var_c312dab9 delete();
    var_b39127dd delete();
    self.var_23304c9e = 0;
    self ai::set_ignoreall(0);
    if (self == level.var_2fd26037) {
        self colors::enable();
        self flag::clear("hendricks_on_zipline");
    }
    if (self != level.var_2fd26037) {
        self.goalradius = 2000;
        self.goalheight = -56;
        self.health = self.maxhealth;
        wait randomintrange(8, 15);
        self thread function_3ca0a891();
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xe2ef113a, Offset: 0x9f08
// Size: 0x64
function function_c936992e() {
    self endon(#"death");
    self endon(#"hash_4d91a838");
    wait 9;
    if (self.current_scene === "cin_gen_traversal_zipline_enemy02_idle") {
        self stopanimscripted();
        self unlink();
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x64438a98, Offset: 0x9f78
// Size: 0x11c
function function_cac74662() {
    self notify(#"hash_57ce910f");
    self unlink();
    if (isdefined(self.var_ae65ed78)) {
        self.var_ae65ed78 delete();
    }
    if (isdefined(self.e_mover)) {
        self.e_mover scene::stop();
        self.e_mover delete();
    }
    self clearforcedgoal();
    self ai::set_behavior_attribute("sprint", 0);
    self.var_23304c9e = 0;
    self ai::set_ignoreall(0);
    self colors::enable();
    self flag::clear("hendricks_on_zipline");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0x8d94eab5, Offset: 0xa0a0
// Size: 0xea
function function_e87de176(var_4ca5dd1f) {
    self endon(#"hash_4d91a838");
    self waittill(#"death");
    if (isdefined(self)) {
        self unlink();
        self startragdoll(1);
    }
    foreach (entity in var_4ca5dd1f) {
        if (isdefined(entity)) {
            entity delete();
        }
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xd5012689, Offset: 0xa198
// Size: 0x160
function function_3ca0a891() {
    self endon(#"death");
    level endon(#"hash_3a2c1be8");
    var_53e40947 = 0;
    while (true) {
        wait randomintrange(3, 7);
        foreach (player in level.activeplayers) {
            if (player.var_fd3ee5eb === self.var_fd3ee5eb) {
                var_53e40947 = 1;
                break;
            }
            var_53e40947 = 0;
        }
        if (!var_53e40947) {
            e_closest_player = arraygetclosest(self.origin, level.activeplayers);
            if (isdefined(e_closest_player)) {
                self function_d15ea140(self.var_fd3ee5eb, e_closest_player.var_fd3ee5eb);
            }
        }
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 2, eflags: 0x0
// Checksum 0x342ab094, Offset: 0xa300
// Size: 0x78a
function function_d15ea140(var_fd3ee5eb, var_91776028) {
    self endon(#"death");
    self endon(#"hash_f3069794");
    var_8ab385b5 = struct::get_array(var_fd3ee5eb, "script_label");
    if (!var_8ab385b5.size) {
        return;
    }
    if (var_fd3ee5eb === "tree1") {
        switch (var_91776028) {
        case "tree2":
            level flag::wait_till("tree2_and_tree3_pursuit_allowed");
            self function_258f9c50(var_8ab385b5, "tree2");
            break;
        case "tree3":
            level flag::wait_till("tree2_and_tree3_pursuit_allowed");
            self function_258f9c50(var_8ab385b5, "tree3");
            break;
        case "tree4":
            self function_258f9c50(var_8ab385b5, "tree2");
            break;
        case "tree5":
            self function_258f9c50(var_8ab385b5, "tree3");
            break;
        case "treefinal":
            self function_258f9c50(var_8ab385b5, "tree3");
            break;
        default:
            break;
        }
        return;
    }
    if (var_fd3ee5eb === "tree2") {
        switch (var_91776028) {
        case "tree1":
            self function_258f9c50(var_8ab385b5, "tree1");
            break;
        case "tree3":
            self function_258f9c50(var_8ab385b5, "tree1");
            break;
        case "tree4":
            var_5bd22e42 = getnode("nd_tree4_center", "targetname");
            self setgoal(var_5bd22e42, 1);
            self waittill(#"goal");
            self.var_fd3ee5eb = "tree4";
            self thread function_3ca0a891();
            break;
        case "tree5":
            var_5bd22e42 = getnode("nd_tree4_center", "targetname");
            self setgoal(var_5bd22e42, 1);
            self waittill(#"goal");
            self.var_fd3ee5eb = "tree4";
            self thread function_3ca0a891();
            break;
        case "treefinal":
            var_5bd22e42 = getnode("nd_tree4_center", "targetname");
            self setgoal(var_5bd22e42, 1);
            self waittill(#"goal");
            self.var_fd3ee5eb = "tree4";
            break;
        default:
            break;
        }
        return;
    }
    if (var_fd3ee5eb === "tree3") {
        switch (var_91776028) {
        case "tree1":
            self function_258f9c50(var_8ab385b5, "tree1");
            break;
        case "tree2":
            self function_258f9c50(var_8ab385b5, "tree1");
            break;
        case "tree4":
            level flag::wait_till("tree4_and_tree5_pursuit_allowed");
            self function_258f9c50(var_8ab385b5, "tree4");
            break;
        case "tree5":
            level flag::wait_till("tree4_and_tree5_pursuit_allowed");
            self function_258f9c50(var_8ab385b5, "tree5");
            break;
        case "treefinal":
            self function_258f9c50(var_8ab385b5, "tree5");
            break;
        default:
            break;
        }
        return;
    }
    if (var_fd3ee5eb === "tree4") {
        switch (var_91776028) {
        case "tree1":
            self function_258f9c50(var_8ab385b5, "tree5");
            break;
        case "tree2":
            var_5bd22e42 = getnode("nd_tree2_center", "targetname");
            self setgoal(var_5bd22e42, 1);
            self waittill(#"goal");
            self.var_fd3ee5eb = "tree2";
            self thread function_3ca0a891();
            break;
        case "tree3":
            self function_258f9c50(var_8ab385b5, "tree3");
            break;
        case "tree5":
            self function_258f9c50(var_8ab385b5, "tree3");
            break;
        case "treefinal":
            self function_258f9c50(var_8ab385b5, "treefinal");
            break;
        default:
            break;
        }
        return;
    }
    if (var_fd3ee5eb === "tree5") {
        switch (var_91776028) {
        case "tree1":
            self function_258f9c50(var_8ab385b5, "tree3");
            break;
        case "tree2":
            self function_258f9c50(var_8ab385b5, "tree3");
            break;
        case "tree3":
            self function_258f9c50(var_8ab385b5, "tree3");
            break;
        case "tree4":
            self function_258f9c50(var_8ab385b5, "tree3");
            break;
        case "treefinal":
            self function_258f9c50(var_8ab385b5, "treefinal");
            break;
        default:
            break;
        }
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 2, eflags: 0x0
// Checksum 0x5577d84b, Offset: 0xaa98
// Size: 0x1f4
function function_258f9c50(var_5b5ad127, var_91776028) {
    self endon(#"death");
    self endon(#"hash_f3069794");
    var_fd729fb3 = [];
    foreach (var_5e1dc07 in var_5b5ad127) {
        if (isdefined(var_5e1dc07.target)) {
            array::add(var_fd729fb3, var_5e1dc07, 0);
        }
    }
    var_d4bb1798 = var_fd729fb3[0].targetname;
    foreach (var_5e1dc07 in var_fd729fb3) {
        s_end = struct::get(var_5e1dc07.target, "targetname");
        if (s_end.script_label === var_91776028) {
            var_d4bb1798 = var_5e1dc07.targetname;
            break;
        }
    }
    self thread function_495d7b05();
    self.target = var_d4bb1798;
    self function_cdb04f99();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xf0dca150, Offset: 0xac98
// Size: 0x10c
function function_495d7b05() {
    self endon(#"death");
    self endon(#"hash_4d91a838");
    self endon(#"hash_f3069794");
    while (true) {
        foreach (player in level.activeplayers) {
            if (player.var_fd3ee5eb === self.var_fd3ee5eb) {
                if (self.var_23304c9e === 0) {
                    self clearforcedgoal();
                    self ai::set_ignoreall(0);
                    self notify(#"hash_f3069794");
                }
            }
        }
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x7509d3ea, Offset: 0xadb0
// Size: 0xb4
function function_2387e4bd() {
    var_3fa09da0 = getent("trig_dive_fxanim_debris", "targetname");
    var_3fa09da0 thread function_af083c9b();
    var_e193b33b = getent("trig_supertrees_playerdive_play", "targetname");
    var_e193b33b thread function_644d430e();
    level thread scene::add_scene_func("cin_bio_14_01_treejump_vign_dive_end", &hendricks_dive, "done");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0x958f2c16, Offset: 0xae70
// Size: 0x2c
function hendricks_dive(str_scene) {
    level flag::set("hendricks_dive");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xf4e114d, Offset: 0xaea8
// Size: 0xd4
function function_a2b40033() {
    var_e05caeb2 = getent("trig_supertrees_finaltree_hurt", "targetname");
    assert(isdefined(var_e05caeb2), "<dev string:x2b4>");
    var_e05caeb2 triggerenable(0);
    level waittill(#"top_of_supertree_explosion");
    var_e05caeb2 triggerenable(1);
    playrumbleonposition("cp_biodomes_final_tree_explosion_rumble", var_e05caeb2.origin);
    exploder::exploder("fx_expl_fire_deathtop_supertree");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x1d33c8d, Offset: 0xaf88
// Size: 0x2c
function function_ca1d2a2d() {
    level waittill(#"hash_76e22d2b");
    exploder::exploder("fx_expl_fire_descendlast_supertree");
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x30e85486, Offset: 0xafc0
// Size: 0x60
function function_af083c9b() {
    while (isdefined(self)) {
        self trigger::wait_till();
        player = self.who;
        player clientfield::set_to_player("supertree_jump_debris_play", 1);
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0xf232e0ca, Offset: 0xb028
// Size: 0x88
function function_644d430e() {
    while (isdefined(self)) {
        self trigger::wait_till();
        player = self.who;
        level util::clientnotify("sndRampEnd");
        player thread function_a04a0f57(self);
        player thread function_9eb272bb();
    }
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 1, eflags: 0x0
// Checksum 0xc9d4167f, Offset: 0xb0b8
// Size: 0x18c
function function_a04a0f57(trigger) {
    self endon(#"death");
    level notify(#"hash_76e22d2b");
    trigger setinvisibletoplayer(self);
    self enableinvulnerability();
    var_2d103051 = struct::get("fake_tag_align_supertree_dive_p" + self getentitynumber(), "targetname");
    if (isdefined(var_2d103051)) {
        var_2d103051 scene::play("cin_bio_14_01_treejump_1st_dive", self);
    } else {
        level scene::play("cin_bio_14_01_treejump_1st_dive", self);
    }
    var_57a51f3c = getent("vista_water", "targetname");
    if (isdefined(var_57a51f3c)) {
        var_57a51f3c delete();
    }
    level flag::set("player_dive_done");
    wait 2;
    trigger setvisibletoplayer(self);
    self disableinvulnerability();
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x2415a6d4, Offset: 0xb250
// Size: 0x7c
function function_9eb272bb() {
    self endon(#"death");
    self waittill(#"hash_786c0556");
    self clientfield::set_to_player("dive_wind_rumble_loop", 1);
    self waittill(#"hash_76ed094c");
    thread function_c59ffff();
    self clientfield::set_to_player("dive_wind_rumble_loop", 0);
}

// Namespace cp_mi_sing_biodomes_supertrees
// Params 0, eflags: 0x0
// Checksum 0x13c97bdb, Offset: 0xb2d8
// Size: 0x84
function function_c59ffff() {
    var_be2ea7e9 = spawn("script_origin", (-3498, 1773, 406));
    if (isdefined(var_be2ea7e9)) {
        var_be2ea7e9 playloopsound("amb_post_dive_battle", 1);
        wait 120;
        var_be2ea7e9 delete();
    }
}

