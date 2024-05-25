#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/cp_mi_zurich_coalescence_root_singapore;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_plaza_battle;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_street;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_f815059a;

// Namespace namespace_f815059a
// Params 2, eflags: 0x0
// Checksum 0x534b7f7b, Offset: 0xd50
// Size: 0xea
function function_9c1fc2fd(str_objective, var_74cd64bc) {
    load::function_73adcefc();
    level flag::init("intro_igc_ready");
    level flag::init("intro_squad_ready_move");
    function_a1dcdc1();
    level scene::init("cin_zur_01_01_intro_1st_lost_contact");
    load::function_a2995f22();
    level thread util::function_46d3a558(%CP_MI_ZURICH_COALESCENCE_INTRO_LINE_1_FULL, "", %CP_MI_ZURICH_COALESCENCE_INTRO_LINE_2_FULL, %CP_MI_ZURICH_COALESCENCE_INTRO_LINE_2_SHORT, %CP_MI_ZURICH_COALESCENCE_INTRO_LINE_3_FULL, %CP_MI_ZURICH_COALESCENCE_INTRO_LINE_3_SHORT, %CP_MI_ZURICH_COALESCENCE_INTRO_LINE_4_FULL, %CP_MI_ZURICH_COALESCENCE_INTRO_LINE_4_FULL);
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_f815059a
// Params 4, eflags: 0x0
// Checksum 0x7ca6e734, Offset: 0xe48
// Size: 0x102
function function_1a4dfaaa(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_8e9083ff::function_4d032f25(0);
    level thread namespace_3d19ef22::function_c38b8260();
    umbragate_set("hq_atrium_umbra_gate", 0);
    umbragate_set("hq_entrance_umbra_gate", 0);
    umbragate_set("hq_exit_umbra_gate", 0);
    umbragate_set("garage_umbra_gate", 0);
    var_fb9735b9 = [];
    var_fb9735b9[0] = getent("plaza_battle_blast_door_left", "targetname");
    var_fb9735b9[1] = getent("plaza_battle_blast_door_right", "targetname");
    array::delete_all(var_fb9735b9);
}

// Namespace namespace_f815059a
// Params 2, eflags: 0x0
// Checksum 0xb3e74d73, Offset: 0xf58
// Size: 0x2c2
function function_9940e82f(str_objective, var_74cd64bc) {
    spawner::add_spawn_function_group("intro_ai", "script_noteworthy", &function_56e5aa4d);
    if (var_74cd64bc) {
        load::function_73adcefc();
        level flag::init("intro_igc_ready");
        level flag::init("intro_squad_ready_move");
        scene::add_scene_func("cin_zur_01_01_intro_1st_lost_contact", &function_a1dcdc1, "init");
        level scene::init("cin_zur_01_01_intro_1st_lost_contact");
    }
    level namespace_8e9083ff::function_da579a5d(str_objective, 1);
    level.var_ebb30c1a = [];
    level thread namespace_1beb9396::function_48166ad7();
    level thread namespace_8e9083ff::function_2361541e("street");
    level thread function_e3750802();
    level clientfield::set("intro_ambience", 1);
    exploder::exploder("streets_tower_wasp_swarm");
    level clientfield::set("zurich_city_ambience", 1);
    if (var_74cd64bc) {
        load::function_a2995f22();
    } else {
        level waittill(#"chyron_menu_closed");
        level thread util::screen_fade_in(2);
    }
    level thread function_37ee22ee();
    level flag::wait_till("intro_igc_ready");
    scene::add_scene_func("cin_zur_01_01_intro_1st_lost_contact", &function_b8f105c6, "play");
    scene::add_scene_func("cin_zur_01_01_intro_1st_lost_contact", &function_5e558eb, "done");
    level thread scene::play("cin_zur_01_01_intro_1st_lost_contact");
    array::thread_all(level.players, &namespace_8e9083ff::function_41753e77, "dni_futz");
    if (isdefined(level.var_741defc2)) {
        level thread [[ level.var_741defc2 ]]();
    }
    level waittill(#"hash_1b75d876");
    level thread namespace_1beb9396::function_1be1a835();
    if (isdefined(str_objective)) {
        skipto::function_be8adfb8(str_objective);
    }
}

// Namespace namespace_f815059a
// Params 4, eflags: 0x0
// Checksum 0x3884675c, Offset: 0x1228
// Size: 0x4a
function function_40b9b738(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::set("cp_level_zurich_assault_hq_obj");
    namespace_8e9083ff::function_4d032f25(0);
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0xf8625225, Offset: 0x1280
// Size: 0x2d3
function function_ab4451a1() {
    level endon(#"hash_e0d14dc8");
    n_count = 0;
    a_mdl_doors = [];
    var_ae75b4be = struct::get_array("skybar_rollup_door");
    foreach (i, s_door in var_ae75b4be) {
        wait(0.05);
        a_mdl_doors[i] = util::spawn_model("p7_loading_dock_rollup_door", s_door.origin, s_door.angles);
        a_mdl_doors[i].script_objective = "garage";
    }
    array::thread_all(a_mdl_doors, &function_52073baf);
    while (true) {
        level waittill(#"hash_443f3c33");
        a_mdl_doors = array::randomize(a_mdl_doors);
        foreach (mdl in a_mdl_doors) {
            wait(0.15);
            mdl movez(85, randomfloatrange(0.9, 1.2));
        }
        mdl waittill(#"movedone");
        if (!n_count) {
            var_c522d6c9 = namespace_8e9083ff::function_33ec653f("skybar_raven_enemy_spawn_manager", undefined, undefined, &namespace_8e9083ff::function_d065a580);
            n_count++;
        } else {
            var_c522d6c9 = namespace_8e9083ff::function_33ec653f("skybar_raven_enemy_spawn_manager2", undefined, undefined, &namespace_8e9083ff::function_d065a580);
            n_count--;
        }
        wait(randomfloatrange(3, 3.6));
        a_mdl_doors = array::randomize(a_mdl_doors);
        foreach (mdl in a_mdl_doors) {
            wait(0.15);
            mdl movez(85 * -1, randomfloatrange(0.9, 1.2));
        }
        mdl waittill(#"movedone");
        level notify(#"hash_2fa6d91");
    }
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0x9947ef24, Offset: 0x1560
// Size: 0x97
function function_52073baf() {
    self endon(#"death");
    while (true) {
        self setcandamage(1);
        self.health = 999999;
        n_damage, e_attacker, _, _, str_damage_type = self waittill(#"damage");
        if (isplayer(e_attacker)) {
            level notify(#"hash_443f3c33");
            self setcandamage(0);
            level waittill(#"hash_2fa6d91");
        }
    }
}

// Namespace namespace_f815059a
// Params 2, eflags: 0x0
// Checksum 0x2eb3a25c, Offset: 0x1600
// Size: 0x2ca
function function_8fb45492(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        spawner::add_spawn_function_group("intro_ai", "script_noteworthy", &function_56e5aa4d);
        level flag::set("intro_squad_ready_move");
        level namespace_8e9083ff::function_da579a5d(str_objective, 1);
        level.var_ebb30c1a = [];
        level thread function_e3750802();
        level clientfield::set("intro_ambience", 1);
        exploder::exploder("streets_tower_wasp_swarm");
        level clientfield::set("zurich_city_ambience", 1);
        namespace_1beb9396::function_48166ad7();
        scene::add_scene_func("cin_zur_01_01_intro_1st_lost_contact", &function_4ef4b654, "play");
        scene::add_scene_func("cin_zur_01_01_intro_1st_lost_contact", &function_5e558eb, "done");
        level scene::skipto_end("cin_zur_01_01_intro_1st_lost_contact");
        level thread function_37ee22ee();
        level thread namespace_1beb9396::function_1be1a835();
        load::function_a2995f22();
    }
    level thread namespace_67110270::function_db37681();
    foreach (e_player in level.activeplayers) {
        e_player util::function_df6eb506(1);
        e_player thread namespace_1beb9396::function_2e5e657b();
    }
    savegame::checkpoint_save();
    level thread scene::play("p7_fxanim_cp_zurich_hunter_start_01_bundle");
    level thread function_51e389ee();
    level thread function_3eb0da5f();
    level thread function_ddcc04ff();
    level thread function_ab4451a1();
    level thread function_da30164f();
    trigger::wait_till("zurich_intro_exit_zone_trig");
    if (isdefined(str_objective)) {
        skipto::function_be8adfb8(str_objective);
    }
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0xd9a6b562, Offset: 0x18d8
// Size: 0x92
function function_37ee22ee() {
    trigger::use("intro_kane_colors_start_colortrig");
    level flag::wait_till("intro_squad_ready_move");
    trigger::use("intro_allies_colors_start_colortrig");
    trigger::wait_till("intro_breadcrumb_trig", undefined, undefined, 0);
    trigger::use("zurich_street_start_colortrig");
    trigger::wait_till("zurich_intro_exit_zone_trig");
}

// Namespace namespace_f815059a
// Params 4, eflags: 0x0
// Checksum 0x7aeff8de, Offset: 0x1978
// Size: 0x32
function function_cf4ddc29(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    namespace_8e9083ff::function_4d032f25(0);
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0xdad851b2, Offset: 0x19b8
// Size: 0x4a
function function_3eb0da5f() {
    level scene::play("p7_fxanim_cp_zurich_car_crash_stuck_bundle");
    trigger::wait_till("intro_breadcrumb_trig2", undefined, undefined, 0);
    level scene::stop("p7_fxanim_cp_zurich_car_crash_stuck_bundle");
}

// Namespace namespace_f815059a
// Params 1, eflags: 0x0
// Checksum 0x850552c3, Offset: 0x1a10
// Size: 0x62
function function_d9b234c1(nd_start) {
    if (!isdefined(nd_start)) {
        nd_start = getnode(self.target, "targetname");
    }
    self.script_objective = "street";
    self.team = "allies";
    self function_84f0b3d2(nd_start);
}

// Namespace namespace_f815059a
// Params 1, eflags: 0x0
// Checksum 0xc1161825, Offset: 0x1a80
// Size: 0xca
function function_84f0b3d2(nd_start) {
    self endon(#"death");
    self notify(#"hash_4db6b0c5");
    self endon(#"hash_4db6b0c5");
    self forceteleport(nd_start.origin);
    wait(0.05);
    while (isdefined(nd_start.target)) {
        var_ff0d12d2 = getnode(nd_start.target, "targetname");
        self ai::force_goal(var_ff0d12d2, 32, 0, "stop_running");
        nd_start = var_ff0d12d2;
    }
    self ai::set_behavior_attribute("panic", 1);
    self ai_cleanup();
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0x8605e9c3, Offset: 0x1b58
// Size: 0x22
function function_51e389ee() {
    objectives::breadcrumb("intro_breadcrumb_trig", "cp_waypoint_breadcrumb");
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0xbb957afb, Offset: 0x1b88
// Size: 0x24
function function_e3750802() {
    var_295a1e1f = namespace_8e9083ff::function_f9afa212("zurich_intro_camera");
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0x1f9ef520, Offset: 0x1bb8
// Size: 0x3a
function function_9b46fb9() {
    var_295a1e1f = getentarray("zurich_intro_camera_ai", "targetname");
    array::delete_all(var_295a1e1f);
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0xdc56b8e7, Offset: 0x1c00
// Size: 0x10a
function function_a1dcdc1() {
    level.var_4fc7570c = spawner::simple_spawn_single("zurich_intro_redshirts_right_1", &function_56e5aa4d);
    level.var_c1cec647 = spawner::simple_spawn_single("zurich_intro_redshirts_right_2", &function_56e5aa4d);
    level.var_726eb89c = getnode("intro_ally_hunter_vignette_rpg", "targetname") namespace_8e9083ff::function_a569867c(undefined, &function_56e5aa4d);
    level.var_e47627d7 = getnode("intro_ally_hunter_vignette_support", "targetname") namespace_8e9083ff::function_a569867c(undefined, &function_56e5aa4d);
    level flag::set("intro_igc_ready");
}

// Namespace namespace_f815059a
// Params 1, eflags: 0x0
// Checksum 0x50c4877, Offset: 0x1d18
// Size: 0x66a
function function_b8f105c6(a_ents) {
    var_d587a688 = getnode("zurich_intro_redshirt_run_by_node", "targetname");
    var_ae4ab21f = getnode("zurich_intro_sitrep_node", "targetname");
    a_ents["zurich_intro_sitrep_guy"].allowbattlechatter["bc"] = 0;
    a_ents["zurich_intro_sitrep_guy"] ai::set_ignoreme(1);
    a_ents["zurich_intro_sitrep_guy"] thread function_56e5aa4d();
    a_ents["kane"].allowbattlechatter["bc"] = 0;
    a_ents["kane"] ai::set_ignoreme(1);
    foreach (e_player in level.activeplayers) {
        e_player.ignoreme = 1;
    }
    level thread function_6e68a9b();
    level thread function_a294dd02();
    level thread function_5f96c3e7();
    level thread function_e7f6d0c8();
    level thread function_73361364(a_ents);
    wait(0.05);
    ai_sniper = getnode("intro_robot_balcony_sniper", "targetname") namespace_8e9083ff::function_a569867c(undefined, &function_b82ef7f0);
    a_ents["zurich_intro_sitrep_guy"] setgoal(var_ae4ab21f);
    a_ents["zurich_intro_sitrep_guy"] waittill(#"hash_2b365e46");
    var_782205f8 = getvehiclenode("intro_hunter_kill_node", "targetname") namespace_8e9083ff::function_a569867c(undefined, &function_5568741b);
    level.var_726eb89c thread function_663b5805(var_782205f8);
    var_9bcc4bde = spawner::simple_spawn_single("zurich_intro_redshirts_right_3", &function_56e5aa4d);
    var_9faa0c88 = getweapon("launcher_standard");
    s_rpg = struct::get("intro_magic_bullet_scene_spot2");
    s_target = struct::get(s_rpg.target);
    var_3c91fda1 = magicbullet(var_9faa0c88, s_rpg.origin, s_target.origin);
    var_3c91fda1.team = "allies";
    a_ents["zurich_intro_sitrep_guy"] thread function_d8d72142();
    wait(0.05);
    var_b7bd6d68 = spawner::simple_spawn_single("zurich_intro_redshirts_right_5", &function_56e5aa4d);
    a_ents["kane"] waittill(#"hash_c8804d8f");
    level.var_726eb89c delete();
    level.var_e47627d7 delete();
    var_b7bd6d68 delete();
    if (ai_sniper.weapon !== level.weaponnone) {
        magicbullet(ai_sniper.weapon, ai_sniper gettagorigin("tag_flash"), a_ents["zurich_intro_sitrep_guy"] geteye() + (0, 16, 32));
    }
    a_ents["kane"] waittill(#"hash_5752b84e");
    a_ents["zurich_intro_sitrep_guy"] thread function_d8d72142();
    var_9de10fe3 = getnode(level.var_c1cec647.script_noteworthy, "targetname");
    level.var_c1cec647 setgoal(var_9de10fe3);
    a_ents["kane"] waittill(#"hash_300ae2a3");
    a_ents["zurich_intro_sitrep_guy"] thread function_d8d72142();
    var_edc6e0e1 = getvehiclenode("street_intro_vtol", "targetname") namespace_8e9083ff::function_a569867c(undefined, &namespace_1beb9396::function_b8380f70);
    var_ddbfe7d1 = spawner::simple_spawn_single("zurich_intro_redshirts_right_4", &function_56e5aa4d);
    var_9de10fe3 = getnode(level.var_4fc7570c.script_noteworthy, "targetname");
    level.var_4fc7570c setgoal(var_9de10fe3);
    a_ents["kane"] waittill(#"hash_602a6061");
    var_61a68fbf = spawner::simple_spawn_single("zurich_intro_support", &function_56e5aa4d);
    var_61a68fbf setgoal(var_d587a688);
    a_ents["kane"] waittill(#"hash_54d3aa25");
    var_22ec8e08 = spawner::simple_spawn_single("intro_street_front_siegebot", &function_19017cb9);
    if (isalive(var_782205f8)) {
        var_782205f8 kill();
    }
}

// Namespace namespace_f815059a
// Params 1, eflags: 0x0
// Checksum 0x3ef17dfb, Offset: 0x2390
// Size: 0x9a
function function_663b5805(var_782205f8) {
    self endon(#"death");
    var_782205f8 endon(#"death");
    var_782205f8 waittill(#"hash_77b2a1ab");
    self setentitytarget(var_782205f8);
    magicbullet(self.weapon, self gettagorigin("tag_flash"), var_782205f8.origin);
    var_782205f8 vehicle::god_off();
    wait(1);
    var_782205f8 kill();
}

// Namespace namespace_f815059a
// Params 1, eflags: 0x0
// Checksum 0x27a94483, Offset: 0x2438
// Size: 0x32
function function_73361364(a_ents) {
    a_ents["kane"] waittill(#"hash_300ae2a3");
    level thread scene::play("p7_fxanim_cp_zurich_hunter_start_02_bundle");
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0xbf123532, Offset: 0x2478
// Size: 0xaa
function function_b82ef7f0() {
    self endon(#"death");
    self util::magic_bullet_shield();
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    level waittill(#"hash_1b75d876");
    self util::stop_magic_bullet_shield();
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    self.overrideactordamage = &namespace_8e9083ff::function_8ac3f026;
    level.var_3d556bcd ai::shoot_at_target("shoot_until_target_dead", self);
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0xe245cfa8, Offset: 0x2530
// Size: 0x8a
function function_5568741b() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self dodamage(int(self.health / 2), self.origin);
    self vehicle::god_on();
    self waittill(#"reached_end_node");
    self setvehgoalpos(self.origin, 1);
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0xd78d7d23, Offset: 0x25c8
// Size: 0x251
function function_d8d72142() {
    self endon(#"death");
    level endon(#"hash_1b75d876");
    n_offset = 32;
    var_3f44bbce = struct::get_array("intro_magic_bullet_scene_spot");
    w_weapon = self.weapon;
    for (i = 0; i < 36; i++) {
        s_weapon = array::random(var_3f44bbce);
        a_s_targets = struct::get_array(s_weapon.target);
        s_target = array::random(a_s_targets);
        var_8d661004 = (randomintrange(n_offset * -1, n_offset), randomintrange(n_offset * -1, n_offset), randomintrange(n_offset * -1, n_offset));
        magicbullet(w_weapon, s_weapon.origin + var_8d661004, s_target.origin + var_8d661004);
        wait(randomfloatrange(0.25, 0.32));
    }
    wait(1.2);
    for (i = 0; i < 19; i++) {
        s_weapon = array::random(var_3f44bbce);
        a_s_targets = struct::get_array(s_weapon.target);
        s_target = array::random(a_s_targets);
        var_8d661004 = (randomintrange(n_offset * -1, n_offset), randomintrange(n_offset * -1, n_offset), randomintrange(n_offset * -1, n_offset));
        magicbullet(w_weapon, s_weapon.origin + var_8d661004, s_target.origin + var_8d661004);
        wait(randomfloatrange(0.25, 0.32));
    }
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0x53ee880a, Offset: 0x2828
// Size: 0x7b
function function_6e68a9b() {
    level endon(#"hash_1b75d876");
    wait(0.05);
    while (true) {
        for (a_ai = namespace_8e9083ff::function_33ec653f("intro_street_robots_spawn_manager", undefined, undefined, &function_56e5aa4d); a_ai.size > 1; a_ai = array::remove_dead(a_ai)) {
            array::wait_any(a_ai, "death");
        }
    }
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0xfdf156c1, Offset: 0x28b0
// Size: 0x9a
function function_56e5aa4d() {
    self endon(#"death");
    self.script_accuracy = 0.1;
    if (self.team == "allies") {
        util::magic_bullet_shield(self);
        if (self.script_aigroup === "intro_hero_redshirts") {
            return;
        }
        level flag::wait_till("intro_squad_ready_move");
        self util::stop_magic_bullet_shield();
        self ai::set_ignoreme(0);
        return;
    }
    self.overrideactordamage = &namespace_8e9083ff::function_8ac3f026;
}

// Namespace namespace_f815059a
// Params 1, eflags: 0x0
// Checksum 0xaa63d10f, Offset: 0x2958
// Size: 0x271
function function_5e558eb(a_ents) {
    level clientfield::set("set_exposure_bank", 0);
    var_35a3121c = spawner::get_ai_group_ai("intro_squad_right");
    for (i = 0; i < level.players.size; i++) {
        if (!isalive(var_35a3121c[i])) {
            continue;
        }
        var_35a3121c[i] util::stop_magic_bullet_shield();
        var_35a3121c[i] kill();
    }
    level flag::set("intro_squad_ready_move");
    util::function_93831e79("intro_igc_player");
    a_ai_allies = getaiteamarray("allies");
    foreach (ai in a_ai_allies) {
        if (ai util::is_hero()) {
            continue;
        }
        ai.script_accuracy = 0.1;
    }
    a_ents["zurich_intro_sitrep_guy"].allowbattlechatter["bc"] = 1;
    a_ents["kane"].allowbattlechatter["bc"] = 1;
    foreach (e_player in level.activeplayers) {
        e_player.ignoreme = 0;
    }
    var_51a7831a = spawner::get_ai_group_ai("intro_street_front_siegebot");
    if (isalive(var_51a7831a)) {
        var_51a7831a kill();
    }
    level.var_4fc7570c = undefined;
    level.var_c1cec647 = undefined;
    level.var_726eb89c = undefined;
    level.var_e47627d7 = undefined;
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0xedb5413c, Offset: 0x2bd8
// Size: 0x18a
function function_19017cb9() {
    self endon(#"death");
    self ai::set_ignoreme(1);
    nd_start = getnode("intro_street_front_siegebot_start_node", "targetname");
    var_a8015c01 = getnode(nd_start.target, "targetname");
    s_rpg = struct::get("intro_magic_rpg_spot");
    var_2d4ab0e6 = struct::get("intro_magic_rpg_spot2");
    var_9faa0c88 = getweapon("launcher_standard");
    self setvehgoalpos(nd_start.origin, 1, 1);
    wait(3.5);
    self setvehgoalpos(var_a8015c01.origin, 1, 1);
    wait(1.3);
    magicbullet(var_9faa0c88, s_rpg.origin, self geteye());
    wait(1.5);
    magicbullet(var_9faa0c88, s_rpg.origin, self geteye());
    wait(0.98);
    self kill();
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0x5686586, Offset: 0x2d70
// Size: 0x16d
function function_a294dd02() {
    level endon(#"hash_1b75d876");
    n_offset = -128;
    var_fccc406f = struct::get_array("intro_magic_rpg_spot_enemy");
    var_9faa0c88 = getweapon("launcher_standard");
    while (true) {
        s_rpg = array::random(var_fccc406f);
        a_s_targets = struct::get_array(s_rpg.target);
        s_target = array::random(a_s_targets);
        var_8d661004 = (randomintrange(n_offset * -1, n_offset), randomintrange(n_offset * -1, n_offset), randomintrange(n_offset * -1, n_offset));
        var_3c91fda1 = magicbullet(var_9faa0c88, s_rpg.origin + var_8d661004, s_target.origin + var_8d661004);
        var_3c91fda1.team = "allies";
        wait(randomfloatrange(1.1, 3.1));
    }
}

// Namespace namespace_f815059a
// Params 1, eflags: 0x0
// Checksum 0xc044aadf, Offset: 0x2ee8
// Size: 0x334
function function_4ef4b654(a_ents) {
    level clientfield::set("set_exposure_bank", 1);
    var_4fc7570c = spawner::simple_spawn_single("zurich_intro_redshirts_right_1");
    var_c1cec647 = spawner::simple_spawn_single("zurich_intro_redshirts_right_2");
    var_61a68fbf = spawner::simple_spawn_single("zurich_intro_support");
    var_b982e5d0 = spawner::get_ai_group_ai("intro_squad_right");
    var_d587a688 = getnode("zurich_intro_redshirt_run_by_node", "targetname");
    var_ae4ab21f = getnode("zurich_intro_sitrep_node", "targetname");
    var_35a3121c = [];
    var_35a3121c = arraycombine(var_b982e5d0, var_35a3121c, 0, 0);
    if (!isdefined(var_35a3121c)) {
        var_35a3121c = [];
    } else if (!isarray(var_35a3121c)) {
        var_35a3121c = array(var_35a3121c);
    }
    var_35a3121c[var_35a3121c.size] = var_61a68fbf;
    if (!isdefined(var_35a3121c)) {
        var_35a3121c = [];
    } else if (!isarray(var_35a3121c)) {
        var_35a3121c = array(var_35a3121c);
    }
    var_35a3121c[var_35a3121c.size] = a_ents["zurich_intro_sitrep_guy"];
    foreach (ai in var_35a3121c) {
        ai.script_accuracy = 0.1;
    }
    level thread function_e7f6d0c8();
    var_61a68fbf forceteleport(var_d587a688.origin, var_d587a688.angles);
    a_ents["zurich_intro_sitrep_guy"] forceteleport(var_ae4ab21f.origin, var_ae4ab21f.angles);
    foreach (ai in var_b982e5d0) {
        var_9de10fe3 = getnode(ai.script_noteworthy, "targetname");
        ai forceteleport(var_9de10fe3.origin, var_9de10fe3.angles);
        ai setgoal(var_9de10fe3);
    }
    var_9bcc4bde = spawner::simple_spawn_single("zurich_intro_redshirts_right_3");
    var_ddbfe7d1 = spawner::simple_spawn_single("zurich_intro_redshirts_right_4");
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0x450f9744, Offset: 0x3228
// Size: 0xc2
function function_da30164f() {
    level endon(#"hash_e0d14dc8");
    var_6a6344b5 = struct::get("street_choke_throw_look_point");
    var_1a20be33 = getent("street_balcony_choke_throw_trig", "targetname");
    var_1a20be33 endon(#"death");
    if (!isdefined(var_1a20be33)) {
        return;
    }
    level flag::wait_till_timeout(6, "intro_player_ready");
    do {
        wait(0.5);
    } while (!namespace_8e9083ff::function_f8645b6(-1, var_6a6344b5.origin, 0.99));
    var_1a20be33 trigger::use();
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0x5765008a, Offset: 0x32f8
// Size: 0x1a1
function function_5f96c3e7() {
    var_e4f90b1a = getentarray("zurich_ambient_outdoor_civ", "targetname");
    var_7b2d1a16 = getnodearray("intro_street_civ_path", "targetname");
    var_ceb52e2a = [];
    for (i = 0; i < 3; i++) {
        foreach (nd in var_7b2d1a16) {
            var_a023ad9b = array::random(var_e4f90b1a);
            var_ceb52e2a[i] = spawner::simple_spawn_single(var_a023ad9b, &function_d9b234c1, nd);
            var_ceb52e2a[i] playloopsound("evt_intro_civilian_loop");
            wait(randomfloatrange(0.9, 1.8));
        }
        if (level flag::get("intro_second_wave_civs_start")) {
            break;
        }
        wait(randomfloatrange(1.34, 3));
    }
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0xd3b48ec8, Offset: 0x34a8
// Size: 0x1a2
function function_e7f6d0c8() {
    var_e4f90b1a = getentarray("zurich_ambient_outdoor_civ", "targetname");
    level flag::wait_till("intro_second_wave_civs_start");
    var_7b2d1a16 = getnodearray("intro_garage_civ_path", "targetname");
    for (i = 0; i < 1; i++) {
        foreach (nd in var_7b2d1a16) {
            var_a023ad9b = array::random(var_e4f90b1a);
            var_ceb52e2a[i] = spawner::simple_spawn_single(var_a023ad9b, &function_d9b234c1, nd);
            wait(randomfloatrange(0.7, 1.4));
        }
        wait(randomfloatrange(0.5, 1.1));
    }
    level flag::wait_till("street_civs_start");
    function_9b9c35d7();
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0x4906004b, Offset: 0x3658
// Size: 0x113
function function_9b9c35d7() {
    var_e4f90b1a = getentarray("zurich_ambient_outdoor_civ", "targetname");
    var_7b2d1a16 = getnodearray("intro_garage2_civ_path", "targetname");
    foreach (i, nd in var_7b2d1a16) {
        var_a023ad9b = array::random(var_e4f90b1a);
        var_ceb52e2a[i] = spawner::simple_spawn_single(var_a023ad9b, &function_d9b234c1, nd);
        wait(randomfloatrange(0.5, 1.1));
    }
}

// Namespace namespace_f815059a
// Params 0, eflags: 0x0
// Checksum 0xbb43e152, Offset: 0x3778
// Size: 0xda
function function_ddcc04ff() {
    var_b2bb8a85 = getvehiclenode("intro_quadtank_spot_right", "targetname");
    var_f3200b3f = spawner::simple_spawn_single("zurich_ambient_quadtank");
    var_f3200b3f ai::set_ignoreme(1);
    var_f3200b3f vehicle_ai::start_scripted();
    var_f3200b3f thread vehicle::get_on_and_go_path(var_b2bb8a85);
    while (!level flag::get("street_civs_start")) {
        var_f3200b3f vehicle::get_on_and_go_path(var_b2bb8a85);
        wait(randomfloatrange(2, 4));
    }
    var_f3200b3f thread ai_cleanup();
}

// Namespace namespace_f815059a
// Params 1, eflags: 0x0
// Checksum 0x642f079c, Offset: 0x3860
// Size: 0x79
function ai_cleanup(n_dist) {
    if (!isdefined(n_dist)) {
        n_dist = 512;
    }
    self endon(#"death");
    while (true) {
        if (!(isdefined(self namespace_8e9083ff::player_can_see_me(n_dist)) && self namespace_8e9083ff::player_can_see_me(n_dist))) {
            if (isalive(self)) {
                self delete();
            }
        }
        wait(2);
    }
}

