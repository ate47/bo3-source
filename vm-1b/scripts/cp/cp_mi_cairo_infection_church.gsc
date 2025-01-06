#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_objectives;
#using scripts/cp/_quadtank_util;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cp_mi_cairo_infection_village_surreal;
#using scripts/cp/gametypes/coop;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;

#namespace church;

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x1815ad15, Offset: 0xa88
// Size: 0x52
function init_client_field_callback_funcs() {
    clientfield::register("world", "light_church_int_cath_all", 1, 1, "int");
    clientfield::register("world", "toggle_cathedral_fog_banks", 1, 1, "int");
}

// Namespace church
// Params 4, eflags: 0x0
// Checksum 0xd02b0225, Offset: 0xae8
// Size: 0x4a
function function_7c4081cb(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    array::thread_all(level.players, &infection_util::function_e905c73c);
}

// Namespace church
// Params 4, eflags: 0x0
// Checksum 0xf0aa76ac, Offset: 0xb40
// Size: 0x6a
function function_9fdc48d2(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    infection_util::function_aa0ddbc3(0);
    array::thread_all(level.players, &infection_util::function_e905c73c);
    level thread function_bcf5c753();
}

// Namespace church
// Params 2, eflags: 0x0
// Checksum 0x49199a58, Offset: 0xbb8
// Size: 0x26a
function function_56c1b3cc(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
    }
    level thread function_85611d5b();
    scene::add_scene_func("p7_fxanim_cp_infection_church_explode_01_bundle", &function_9ad74a02, "play");
    scene::add_scene_func("p7_fxanim_cp_infection_church_explode_02_bundle", &function_e3cbb3ec, "play");
    scene::add_scene_func("p7_fxanim_cp_infection_church_tank_02_bundle", &function_99a9f593, "done");
    scene::add_scene_func("cin_inf_11_04_fold_vign_walk_end_unreveal", &function_8c83aff9, "play");
    var_e9020a33 = util::function_740f8516("sarah");
    if (var_74cd64bc) {
        function_1319db1b();
        load::function_a2995f22();
    }
    array::thread_all(level.players, &infection_util::function_9f10c537);
    if (var_74cd64bc) {
        var_e9020a33 thread scene::play("cin_inf_11_04_fold_vign_walk_end", var_e9020a33);
    }
    if (isdefined(level.var_44ab3893)) {
        level thread [[ level.var_44ab3893 ]]();
    }
    wait 2;
    var_e9020a33 thread scene::play("cin_inf_11_04_fold_vign_walk_end_unreveal", var_e9020a33);
    wait 3;
    level thread scene::play("p7_fxanim_cp_infection_church_tank_01_bundle");
    level thread scene::play("p7_fxanim_cp_infection_church_explode_01_bundle");
    level waittill(#"hash_29e5a19f");
    level thread scene::play("p7_fxanim_cp_infection_church_tank_02_bundle");
    level thread scene::play("p7_fxanim_cp_infection_church_explode_02_bundle");
    function_8aabc20e();
    level waittill(#"hash_ad9dbc82");
    level clientfield::set("light_church_int_all", 0);
    level clientfield::set("light_church_int_cath_all", 0);
}

// Namespace church
// Params 1, eflags: 0x0
// Checksum 0x9d8a4016, Offset: 0xe30
// Size: 0x4a
function function_8c83aff9(a_ents) {
    a_ents["sarah"] clientfield::set("sarah_body_light", 0);
    a_ents["sarah"] thread infection_util::function_9110a277(1);
}

// Namespace church
// Params 2, eflags: 0x0
// Checksum 0x4bdba1e8, Offset: 0xe88
// Size: 0x1ba
function function_cbb5d383(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
    }
    setup_spawners();
    function_f46b47c();
    trig = getent("cathedral_sarah_at_altar", "targetname");
    trig triggerenable(0);
    exploder::exploder("fx_light_cathedral_lightning");
    exploder::exploder("cathedral_alter_candle_lights");
    if (var_74cd64bc) {
        load::function_a2995f22();
        spawn_quad_tank();
    }
    namespace_f25bd8c8::function_211b07c5();
    if (level.players.size > 0) {
        function_c63f5a62();
    }
    level flag::wait_till("cathedral_quad_tank_destroyed");
    objectives::complete("cp_level_infection_destroy_quadtank");
    util::delay(2, undefined, &namespace_f25bd8c8::function_2c8ffdaf);
    function_e5a6d1b6();
    if (isdefined(level.var_c4dba52c)) {
        [[ level.var_c4dba52c ]]();
    }
    function_611a9795();
    function_6d3642e();
    function_4043ed0a();
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0xdf45947f, Offset: 0x1050
// Size: 0x4a
function function_bb28f49a() {
    level dialog::function_13b3b16a("plyr_what_the_fuck_0", 1);
    level thread dialog::remote("hall_brute_force_somet_0", 0, "NO_DNI");
}

// Namespace church
// Params 2, eflags: 0x0
// Checksum 0x5e57a5c4, Offset: 0x10a8
// Size: 0x82
function dev_cathedral_outro(str_objective, var_74cd64bc) {
    level flag::init("sarah_distance_objective");
    level thread function_f46b47c();
    function_611a9795();
    function_6d3642e();
    function_4043ed0a();
    level thread skipto::function_be8adfb8("dev_cathedral_outro");
}

// Namespace church
// Params 4, eflags: 0x0
// Checksum 0xe6d045b6, Offset: 0x1138
// Size: 0x22
function function_956d2096(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x60b3f848, Offset: 0x1168
// Size: 0xa2
function setup_spawners() {
    spawner::add_spawn_function_group("sm_cathedral_guys", "script_noteworthy", &infection_util::function_b86426b1);
    spawner::add_spawn_function_group("sm_cathedral_guys", "script_noteworthy", &function_64a8118d);
    infection_util::function_aa0ddbc3(1);
    level flag::init("cathedral_quad_tank_destroyed");
    level flag::init("sarah_distance_objective");
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x5f1dba3f, Offset: 0x1218
// Size: 0x62
function function_1319db1b() {
    scene::add_scene_func("p7_fxanim_cp_infection_church_explode_01_bundle", &function_452b629a, "init");
    scene::init("p7_fxanim_cp_infection_church_explode_01_bundle");
    level clientfield::set("light_church_int_cath_all", 1);
}

// Namespace church
// Params 1, eflags: 0x0
// Checksum 0x41c6ea58, Offset: 0x1288
// Size: 0x1a
function function_452b629a(a_ents) {
    a_ents[0] setforcenocull();
}

// Namespace church
// Params 1, eflags: 0x0
// Checksum 0x8f6425ed, Offset: 0x12b0
// Size: 0x162
function spawn_quad_tank(var_5152e048) {
    array::thread_all(level.activeplayers, &coop::function_e9f7384d);
    var_6ba9931 = getent("quad_tank_cathedral", "script_noteworthy");
    var_1b1b9e26 = spawner::simple_spawn_single(var_6ba9931, &function_526e9212);
    if (isdefined(var_5152e048)) {
        var_1b1b9e26.origin = var_5152e048.origin;
        var_1b1b9e26.angles = var_5152e048.angles;
    }
    scene::add_scene_func("cin_inf_11_05_fold_vign_qtbirth", &function_50768ebe, "done");
    level thread scene::play("cin_inf_11_05_fold_vign_qtbirth", var_1b1b9e26);
    level thread scene::play("cin_inf_11_05_fold_vign_tigertank");
    level thread function_bb28f49a();
    var_ab891f49 = getent("quadtank_goal_volume", "targetname");
    var_1b1b9e26 setgoal(var_ab891f49);
}

// Namespace church
// Params 1, eflags: 0x0
// Checksum 0x33fb0503, Offset: 0x1420
// Size: 0x13
function function_50768ebe(var_38fa6e84) {
    level notify(#"hash_50768ebe");
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x148c5d3c, Offset: 0x1440
// Size: 0xba
function function_526e9212() {
    self util::function_e218424d();
    self quadtank::function_4c6ee4cc(0);
    self waittill(#"turn_on");
    self quadtank::function_fefa9078();
    level waittill(#"hash_50768ebe");
    self quadtank::function_4c6ee4cc(1);
    self thread function_74e24b66();
    self thread function_1828efd2();
    self thread function_3546987d();
    self thread namespace_855113f3::function_35209d64();
    self waittill(#"death");
    level flag::set("cathedral_quad_tank_destroyed");
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x6d232c1a, Offset: 0x1508
// Size: 0x105
function function_74e24b66() {
    self endon(#"death");
    while (true) {
        self util::waittill_either("trophy_system_disabled", "trophy_system_destroyed");
        ai_enemy = spawn_manager::function_423eae50("sm_cathedral_lower");
        for (i = 0; i < ai_enemy.size; i++) {
            if (i < 5 && distance2dsquared(self.origin, ai_enemy[i].origin) > 40000) {
                self thread function_b26e24ab(ai_enemy[i]);
            }
        }
        self waittill(#"hash_f015cdf7");
        ai_enemy = spawn_manager::function_423eae50("sm_cathedral_lower");
        for (i = 0; i < ai_enemy.size; i++) {
            ai_enemy[i] clearforcedgoal();
        }
    }
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x3e626d12, Offset: 0x1618
// Size: 0x8a
function function_1828efd2() {
    self endon(#"death");
    self thread function_6a01df15("church_pillars_explode_01", "p7_fxanim_cp_infection_church_pillars_explode_01_bundle");
    self thread function_6a01df15("church_pillars_explode_02", "p7_fxanim_cp_infection_church_pillars_explode_02_bundle");
    self thread function_6a01df15("church_pillars_explode_03", "p7_fxanim_cp_infection_church_pillars_explode_03_bundle");
    self thread function_6a01df15("church_pillars_explode_04", "p7_fxanim_cp_infection_church_pillars_explode_04_bundle");
}

// Namespace church
// Params 2, eflags: 0x0
// Checksum 0x8888a707, Offset: 0x16b0
// Size: 0xc2
function function_6a01df15(e_trig, var_65f65be) {
    self endon(#"death");
    trigger::wait_till(e_trig);
    trig = getent(e_trig, "targetname");
    e_target = spawn("script_origin", trig.origin);
    self setturrettargetent(e_target);
    self waittill(#"turret_on_target");
    self fireweapon(0, e_target);
    level scene::play(var_65f65be, "scriptbundlename");
}

// Namespace church
// Params 1, eflags: 0x0
// Checksum 0x192c9f9a, Offset: 0x1780
// Size: 0xcd
function function_b26e24ab(ai) {
    self endon(#"hash_f015cdf7");
    self endon(#"death");
    ai endon(#"death");
    n_min_dist = -106;
    n_max_dist = 350;
    n_max_height = 48;
    while (true) {
        a_v_points = [];
        a_v_points = util::positionquery_pointarray(self.origin, n_min_dist, n_max_dist, n_max_height, 70, ai);
        if (a_v_points.size) {
            ai setgoal(array::random(a_v_points), 1);
        }
        wait randomfloatrange(0.5, 1);
    }
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0xb20f24c8, Offset: 0x1858
// Size: 0x32
function function_3546987d() {
    objectives::complete("cp_level_infection_follow_sarah");
    objectives::set("cp_level_infection_destroy_quadtank", self);
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x1b42665a, Offset: 0x1898
// Size: 0x142
function function_f46b47c() {
    level scene::init("p7_fxanim_cp_infection_church_pillars_explode_01_bundle", "scriptbundlename");
    level scene::init("p7_fxanim_cp_infection_church_pillars_explode_02_bundle", "scriptbundlename");
    level scene::init("p7_fxanim_cp_infection_church_pillars_explode_03_bundle", "scriptbundlename");
    level scene::init("p7_fxanim_cp_infection_church_pillars_explode_04_bundle", "scriptbundlename");
    scene::add_scene_func("cin_inf_11_06_fold_vign_hell", &function_517e0167, "init");
    scene::add_scene_func("cin_inf_11_06_fold_vign_hell", &function_a4194ec3, "play");
    scene::add_scene_func("p7_fxanim_cp_infection_cathedral_floor_bundle", &function_d0dfc621, "play");
    scene::add_scene_func("cin_inf_12_01_underwater_1st_fall_01", &function_5661e491, "play");
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x538068c, Offset: 0x19e8
// Size: 0xa7
function function_e5a6d1b6() {
    var_357e383d = 0;
    a_ai = getaiteamarray("axis");
    for (a_ai = array::remove_dead(a_ai, 0); a_ai.size > 0 && var_357e383d < 3; a_ai = array::remove_dead(a_ai, 0)) {
        wait 0.1;
        var_357e383d += 0.1;
        a_ai = getaiteamarray("axis");
    }
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0xb806d3b4, Offset: 0x1a98
// Size: 0x8a
function function_96d3596c() {
    spawn_manager::enable("sm_cathedral_upper");
    spawn_manager::enable("sm_cathedral_lower");
    trigger::wait_or_timeout(20, "cathedral_intro_reverse");
    if (level.players.size <= 2) {
        spawn_manager::function_41cd3a68(21);
    }
    if (level.players.size >= 3) {
        spawn_manager::function_41cd3a68(31);
    }
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x9a28c09f, Offset: 0x1b30
// Size: 0xa2
function function_c63f5a62() {
    infection_util::function_c8d7e76("cathedral_reverse_anim");
    level thread function_96d3596c();
    level thread namespace_bed101ee::function_b716312();
    level flag::wait_till("cathedral_quad_tank_destroyed");
    spawn_manager::kill("sm_cathedral_upper");
    spawn_manager::kill("sm_cathedral_lower");
    util::wait_network_frame();
    level thread function_bcf5c753();
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x33a7a451, Offset: 0x1be0
// Size: 0x71
function function_bcf5c753() {
    a_ai = getaiteamarray("axis");
    for (i = 0; i < a_ai.size; i++) {
        if (isalive(a_ai[i])) {
            a_ai[i] kill();
            wait 0.1;
        }
    }
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x330139c2, Offset: 0x1c60
// Size: 0x1a
function function_611a9795() {
    level scene::init("cin_inf_11_06_fold_vign_hell");
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x9dec1b0a, Offset: 0x1c88
// Size: 0xca
function function_6d3642e() {
    trig = getent("cathedral_sarah_at_altar", "targetname");
    trig triggerenable(1);
    trig waittill(#"trigger", who);
    level.var_26e8728a = who;
    level flag::set("sarah_distance_objective");
    objectives::complete("cp_level_infection_confront_sarah");
    level thread namespace_bed101ee::function_af130cfc();
    array::thread_all(level.players, &infection_util::function_9f10c537);
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0xbaf12870, Offset: 0x1d60
// Size: 0x42
function function_4043ed0a() {
    level scene::play("cin_inf_11_06_fold_vign_hell", level.var_26e8728a);
    level waittill(#"hash_319c8cf7");
    level thread skipto::function_be8adfb8("cathedral");
}

// Namespace church
// Params 1, eflags: 0x0
// Checksum 0xee04a524, Offset: 0x1db0
// Size: 0x1a
function function_5661e491(a_ents) {
    level thread namespace_bed101ee::function_973b77f9();
}

// Namespace church
// Params 1, eflags: 0x0
// Checksum 0x937ab38c, Offset: 0x1dd8
// Size: 0xab
function function_d0dfc621(a_ents) {
    level clientfield::set("cathedral_water_state", 1);
    foreach (player in level.players) {
        player thread function_50bfe0b5(6, 1);
        earthquake(0.22, 7, player.origin, -106);
    }
}

// Namespace church
// Params 1, eflags: 0x0
// Checksum 0xfa6983b6, Offset: 0x1e90
// Size: 0x5a
function function_517e0167(a_ents) {
    if (!level flag::get("sarah_distance_objective")) {
        objectives::set("cp_level_infection_confront_sarah", a_ents["sarah"]);
    }
    a_ents["sarah"] thread infection_util::function_9110a277(0);
}

// Namespace church
// Params 1, eflags: 0x0
// Checksum 0xbefe00b1, Offset: 0x1ef8
// Size: 0xaa
function function_a4194ec3(a_ents) {
    level clientfield::set("toggle_cathedral_fog_banks", 1);
    level thread scene::init("cin_inf_12_01_underwater_1st_fall_underwater02");
    level waittill(#"hash_bd8dec38");
    a_ents["sarah"] thread infection_util::function_9110a277(1);
    level thread scene::init("p7_fxanim_cp_infection_cathedral_floor_bundle");
    level thread function_ee14f7e6();
    level waittill(#"hash_88307bc9");
    level thread scene::play("p7_fxanim_cp_infection_cathedral_floor_bundle");
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0xcf8d922f, Offset: 0x1fb0
// Size: 0x42
function function_ee14f7e6() {
    while (!scene::is_ready("p7_fxanim_cp_infection_cathedral_floor_bundle")) {
        wait 0.05;
    }
    hidemiscmodels("inf_cathedral_floor_fxanim");
}

// Namespace church
// Params 2, eflags: 0x0
// Checksum 0x163d5787, Offset: 0x2000
// Size: 0x4b
function function_50bfe0b5(var_524f5a91, n_wait) {
    self endon(#"death");
    for (i = 0; i < var_524f5a91; i++) {
        self playrumbleonentity("cp_infection_floor_break");
        wait n_wait;
    }
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x5cd6120, Offset: 0x2058
// Size: 0x2eb
function function_85611d5b() {
    level thread namespace_bed101ee::function_973b77f9();
    a_doors = getentarray("church_door", "targetname");
    assert(a_doors.size, "<dev string:x28>");
    var_5c953c1c = [];
    foreach (m_door in a_doors) {
        assert(isdefined(m_door.script_int), "<dev string:x60>" + m_door.origin + "<dev string:x83>");
        assert(isdefined(m_door.target), "<dev string:x60>" + m_door.origin + "<dev string:xce>");
        s_rotate = struct::get(m_door.target, "targetname");
        var_be1f149f = spawn("script_origin", s_rotate.origin);
        m_door linkto(var_be1f149f);
        var_be1f149f rotateyaw(m_door.script_int, 1.5, 0.25, 0.25);
        var_be1f149f playsound("evt_church_doors_close");
        if (!isdefined(var_5c953c1c)) {
            var_5c953c1c = [];
        } else if (!isarray(var_5c953c1c)) {
            var_5c953c1c = array(var_5c953c1c);
        }
        var_5c953c1c[var_5c953c1c.size] = var_be1f149f;
    }
    wait 1.5;
    foreach (player in level.players) {
        player playrumbleonentity("damage_heavy");
    }
    foreach (var_be1f149f in var_5c953c1c) {
        var_be1f149f delete();
    }
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x22937a3f, Offset: 0x2350
// Size: 0x222
function function_8aabc20e() {
    s_start = struct::get("church_in_foy", "targetname");
    assert(isdefined(s_start), "<dev string:xe6>");
    s_end = struct::get("church_inside_cathedral", "targetname");
    assert(isdefined(s_end), "<dev string:x119>");
    var_4e7ce67b = util::spawn_model("tag_origin", s_start.origin, s_start.angles);
    var_fc400d58 = util::spawn_model("tag_origin", s_end.origin, s_end.angles);
    foreach (player in level.players) {
        var_85536595 = var_4e7ce67b worldtolocalcoords(player.origin);
        var_baf9d36 = var_fc400d58 localtoworldcoords(var_85536595);
        v_angles = combineangles(var_fc400d58.angles - var_4e7ce67b.angles, player getplayerangles());
        player setorigin(var_baf9d36);
        player setplayerangles(v_angles);
    }
    var_4e7ce67b delete();
    var_fc400d58 delete();
    skipto::function_be8adfb8("church");
}

// Namespace church
// Params 1, eflags: 0x0
// Checksum 0x348d75ca, Offset: 0x2580
// Size: 0x52
function function_9ad74a02(a_ents) {
    level waittill(#"hash_252cf940");
    level clientfield::set("light_church_int_all", 1);
    array::spread_all(level.players, &function_252cf940, a_ents[0]);
}

// Namespace church
// Params 1, eflags: 0x0
// Checksum 0x5091564a, Offset: 0x25e0
// Size: 0xea
function function_252cf940(var_4aa3a795) {
    var_89c338ec = var_4aa3a795.origin - self.origin;
    var_89c338ec = vectornormalize(var_89c338ec);
    v_forward = anglestoforward(self.angles);
    var_ab382970 = vectordot(var_89c338ec, v_forward);
    if (var_ab382970 >= 0) {
        var_a6cdd544 = -1;
    } else {
        var_a6cdd544 = 1;
    }
    v_dir = anglestoforward(self.angles);
    var_e03fdb7 = var_a6cdd544 * 1200;
    self setvelocity(v_dir * var_e03fdb7);
}

// Namespace church
// Params 1, eflags: 0x0
// Checksum 0x7f452c04, Offset: 0x26d8
// Size: 0x3a
function function_e3cbb3ec(a_ents) {
    a_ents[0] setforcenocull();
    level waittill(#"hash_99bc006e");
    a_ents[0] notsolid();
}

// Namespace church
// Params 1, eflags: 0x0
// Checksum 0xaf741ed9, Offset: 0x2720
// Size: 0x32
function function_99a9f593(a_ents) {
    var_f793f80e = a_ents["tiger_tank_cinematic"];
    spawn_quad_tank(var_f793f80e);
}

// Namespace church
// Params 0, eflags: 0x0
// Checksum 0x8d2aa139, Offset: 0x2760
// Size: 0x12
function function_64a8118d() {
    self.script_accuracy = 0.7;
}

