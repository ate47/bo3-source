#using scripts/codescripts/struct;
#using scripts/cp/_collectibles;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_infection2_sound;
#using scripts/cp/cp_mi_cairo_infection_accolades;
#using scripts/cp/cp_mi_cairo_infection_church;
#using scripts/cp/cp_mi_cairo_infection_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/coop;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace namespace_4e2074f4;

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x2
// Checksum 0x928ebd9b, Offset: 0x10a0
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("infection_village_surreal", &__init__, undefined, undefined);
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x1457cd59, Offset: 0x10d8
// Size: 0x42
function __init__() {
    function_83bed3e4();
    spawner::add_spawn_function_group("sp_tiger_tank_fold", "targetname", &function_e310ea1e);
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x21a685c9, Offset: 0x1128
// Size: 0x11a
function init_client_field_callback_funcs() {
    clientfield::register("world", "infection_fold_debris_1", 1, 1, "counter");
    clientfield::register("world", "infection_fold_debris_2", 1, 1, "int");
    clientfield::register("world", "infection_fold_debris_3", 1, 1, "int");
    clientfield::register("world", "infection_fold_debris_4", 1, 1, "int");
    clientfield::register("world", "light_church_ext_window", 1, 1, "int");
    clientfield::register("world", "light_church_int_all", 1, 1, "int");
    clientfield::register("world", "dynent_catcher", 1, 1, "int");
}

// Namespace namespace_4e2074f4
// Params 4, eflags: 0x0
// Checksum 0xfd62762c, Offset: 0x1250
// Size: 0x2b
function cleanup(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level notify(#"end_salm_fold_dialog");
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xbad59ff0, Offset: 0x1288
// Size: 0x32
function function_a1dc825e() {
    function_9a0f8909();
    setup_spawners();
    function_a8ccd78c();
}

// Namespace namespace_4e2074f4
// Params 2, eflags: 0x0
// Checksum 0xdd127332, Offset: 0x12c8
// Size: 0x442
function main(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level util::function_d8eaed3d(11);
        function_9a0f8909();
        setup_spawners();
        function_a8ccd78c();
        level thread scene::init("cin_inf_11_02_fold_1st_airlock");
    }
    infection_util::function_67137b13();
    collectibles::function_93523442("p7_nc_cai_inf_06", 300, (0, 0, 0));
    level.tank_activated = 0;
    level.var_9fc31553 = 0;
    level thread function_29e53c05();
    level thread function_bb707466();
    level thread function_81e49583();
    level thread function_51a0e924();
    level thread function_6d19283f();
    level thread function_1c2ef59f();
    level thread function_aa278664();
    level thread function_d02a00cd();
    level thread function_5e229192();
    level thread function_4d4c8709();
    level thread function_274a0ca0();
    level thread function_315b657f();
    level thread function_5f1b3809();
    level thread function_6a6562a7();
    level thread infection_util::function_e14494e9("sm_fold_guys_1", "sm_fold_guys_tank", "t_sm_fold_guys_1_reinforce", 5, 2);
    function_d90d60f3(1);
    church::function_1319db1b();
    if (isdefined(level.var_d68aea9e)) {
        level thread [[ level.var_d68aea9e ]]();
    }
    if (!sessionmodeiscampaignzombiesgame()) {
        function_f9d285ed();
        level thread function_46d91cb3();
    }
    level clientfield::set("dynent_catcher", 1);
    if (var_74cd64bc) {
        load::function_a2995f22();
    }
    array::thread_all(level.players, &infection_util::function_9f10c537);
    level thread namespace_bed101ee::function_b00d2653();
    if (!var_74cd64bc) {
        level.var_42189297 = util::function_740f8516("sarah");
        level.var_42189297 clientfield::set("sarah_body_light", 0);
    } else {
        objectives::set("cp_level_infection_follow_sarah");
    }
    level thread util::screen_fade_in(2, "white", "foy_white");
    level scene::play("cin_inf_11_02_fold_1st_airlock");
    level thread infection_util::function_3fe1f72("t_sarah_fold_objective_", 0, &function_75ddceb0);
    util::function_93831e79(str_objective);
    wait 1.25;
    array::thread_all(level.players, &infection_util::function_e905c73c);
    streamerrequest("clear", "cin_inf_11_02_fold_1st_airlock");
    level thread util::clear_streamer_hint();
    level thread function_2d8736c7();
    level thread function_b1600743();
    level thread function_4ecccd1c();
    level thread function_e6ee1935();
    battlechatter::function_d9f49fba(1);
    infection_util::function_1cdb9014(3);
    level thread function_20f82ee2();
    function_daf631fe();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xe3c820da, Offset: 0x1718
// Size: 0x52
function function_633271eb() {
    level thread infection_util::function_f6d49772("t_salm_i_am_increasingly_co_1", "salm_i_am_increasingly_co_1", "end_salm_fold_dialog");
    level thread infection_util::function_f6d49772("t_salm_in_the_wake_of_recen_1", "salm_in_the_wake_of_recen_1", "end_salm_fold_dialog");
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x50b87a94, Offset: 0x1778
// Size: 0x5e
function function_f9d285ed() {
    level.var_c3d19bc2 = new class_ce2d510();
    var_cb7ecfda = vehicle::simple_spawn_single("sp_fold_turret_01");
    [[ level.var_c3d19bc2 ]]->function_66f910ed(var_cb7ecfda, "sp_fold_turret_01_gunner", "t_fold_turret_01_gunner");
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x958c91fb, Offset: 0x17e0
// Size: 0x2a
function function_46d91cb3() {
    trigger::wait_till("t_fold_turret_01_enable");
    [[ level.var_c3d19bc2 ]]->function_2919200c();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xce1fa391, Offset: 0x1818
// Size: 0x32a
function function_a8ccd78c() {
    level.var_8d647ad = getentarray("m_bank_explode", "targetname");
    infection_util::function_9d8bcc37(level.var_8d647ad);
    level.var_8eb32cc3 = getentarray("m_fountain_explode", "targetname");
    infection_util::function_9d8bcc37(level.var_8eb32cc3);
    level.var_78620d04 = getentarray("m_reverse_sniper_building", "targetname");
    infection_util::function_9d8bcc37(level.var_78620d04);
    level.var_f3637081 = getentarray("m_reverse_boarding_house", "targetname");
    infection_util::function_9d8bcc37(level.var_f3637081);
    scene::add_scene_func("p7_fxanim_cp_infection_bank_explode_bundle", &function_6f5e3bfb, "done");
    scene::add_scene_func("p7_fxanim_cp_infection_fountain_explode_bundle", &function_d9766bf5, "done");
    scene::add_scene_func("p7_fxanim_cp_infection_reverse_sniper_building_01_bundle", &function_ba41bc6a, "done");
    scene::add_scene_func("p7_fxanim_cp_infection_reverse_boarding_house_bundle", &function_6096a6cf, "done");
    infection_util::function_1926d38d("p7_fxanim_cp_infection_fountain_explode_bundle", "s_infection_fountain_explode_bundle", "t_infection_fountain_explode_bundle_inner", "t_infection_fountain_explode_bundle_outter");
    infection_util::function_1926d38d("p7_fxanim_cp_infection_reverse_wall_02_bundle", "s_infection_reverse_wall_02_bundle", "t_infection_reverse_wall_02_bundle_inner", "t_infection_reverse_wall_02_bundle_outter");
    infection_util::function_1926d38d("p7_fxanim_cp_infection_reverse_sniper_building_01_bundle", "s_infection_reverse_sniper_building_01_bundle", "t_infection_reverse_sniper_building_01_bundle_inner", "t_infection_reverse_sniper_building_01_bundle_outter");
    infection_util::function_1926d38d("p7_fxanim_cp_infection_reverse_boarding_house_bundle", "s_infection_reverse_boarding_house_bundle", "t_infection_reverse_boarding_house_bundle_inner", "t_infection_reverse_boarding_house_bundle_outter");
    infection_util::function_1926d38d("p7_fxanim_cp_infection_tombstone_reverse_01_bundle", "s_infection_tombstone_reverse_01_bundle", "t_infection_tombstone_reverse_01_bundle_inner", "t_infection_tombstone_reverse_01_bundle_outter");
    infection_util::function_1926d38d("p7_fxanim_cp_infection_tombstone_reverse_02_bundle", "s_infection_tombstone_reverse_02_bundle", "t_infection_tombstone_reverse_02_bundle_inner", "t_infection_tombstone_reverse_02_bundle_outter");
    infection_util::function_1926d38d("p7_fxanim_cp_infection_tombstone_reverse_03_bundle", "s_infection_tombstone_reverse_03_bundle", "t_infection_tombstone_reverse_03_bundle_inner", "t_infection_tombstone_reverse_03_bundle_outter");
    level scene::init("p7_fxanim_cp_infection_tank_wall_break_bundle");
}

// Namespace namespace_4e2074f4
// Params 1, eflags: 0x0
// Checksum 0x9f424e, Offset: 0x1b50
// Size: 0x22
function function_6f5e3bfb(a_ents) {
    infection_util::function_bdea6c61(level.var_8d647ad);
}

// Namespace namespace_4e2074f4
// Params 1, eflags: 0x0
// Checksum 0xf16041ab, Offset: 0x1b80
// Size: 0x22
function function_d9766bf5(a_ents) {
    infection_util::function_bdea6c61(level.var_8eb32cc3);
}

// Namespace namespace_4e2074f4
// Params 1, eflags: 0x0
// Checksum 0xf87e95e5, Offset: 0x1bb0
// Size: 0x22
function function_ba41bc6a(a_ents) {
    infection_util::function_bdea6c61(level.var_78620d04);
}

// Namespace namespace_4e2074f4
// Params 1, eflags: 0x0
// Checksum 0x6f941e46, Offset: 0x1be0
// Size: 0x22
function function_6096a6cf(a_ents) {
    infection_util::function_bdea6c61(level.var_f3637081);
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x951bf42a, Offset: 0x1c10
// Size: 0x1b2
function function_83bed3e4() {
    scene::add_scene_func("cin_inf_10_02_bastogne_vign_reversefall2floor_suppressor", &function_27a6bc61, "play");
    scene::add_scene_func("cin_inf_10_02_bastogne_vign_reversemortar2floor_sniper", &infection_util::function_2a5e3b2a, "play");
    scene::add_scene_func("cin_inf_10_02_foy_aie_reverseshot_1_suppressor", &infection_util::function_2a5e3b2a, "play");
    scene::add_scene_func("cin_inf_10_02_foy_aie_reverseshot_5_sniper", &infection_util::function_2a5e3b2a, "play");
    scene::add_scene_func("cin_inf_11_03_fold_vign_reverse_sniper", &infection_util::function_2a5e3b2a, "play");
    scene::add_scene_func("cin_inf_11_02_fold_1st_airlock", &infection_util::function_23e59afd, "play");
    scene::add_scene_func("cin_inf_11_02_fold_1st_airlock", &infection_util::function_e2eba6da, "done");
    scene::add_scene_func("cin_inf_11_02_fold_1st_airlock", &function_3824b768, "play");
    scene::add_scene_func("cin_inf_11_02_fold_1st_airlock", &function_a8d640c7, "done");
}

// Namespace namespace_4e2074f4
// Params 1, eflags: 0x0
// Checksum 0x46202f85, Offset: 0x1dd0
// Size: 0x22
function function_3824b768(a_ents) {
    level clientfield::increment("infection_fold_debris_1", 1);
}

// Namespace namespace_4e2074f4
// Params 1, eflags: 0x0
// Checksum 0xb63a753c, Offset: 0x1e00
// Size: 0x22
function function_a8d640c7(a_ents) {
    level thread scene::play("p7_fxanim_cp_infection_bank_explode_bundle");
}

// Namespace namespace_4e2074f4
// Params 1, eflags: 0x0
// Checksum 0x7519e398, Offset: 0x1e30
// Size: 0xbb
function function_27a6bc61(a_ents) {
    e_volume = getent("t_sp_fold_guys_2_ai", "targetname");
    foreach (ent in a_ents) {
        if (isactor(ent)) {
            ent infection_util::function_dc649ed7(0);
            ent thread infection_util::function_e62729fb(e_volume);
        }
    }
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x7242e0fd, Offset: 0x1ef8
// Size: 0x3a
function function_4ecccd1c() {
    spawn_manager::enable("sm_fold_guys_0");
    wait 5.5;
    spawn_manager::enable("sm_fold_guys_1");
}

// Namespace namespace_4e2074f4
// Params 1, eflags: 0x0
// Checksum 0xcc771e8c, Offset: 0x1f40
// Size: 0x5a
function function_d90d60f3(b_enable) {
    if (b_enable) {
        setdvar("phys_gravity_dir", (0, 1, -0.35));
        level.var_74bd7d24 = 1;
        return;
    }
    setdvar("phys_gravity_dir", (0, 0, 1));
    level.var_74bd7d24 = 0;
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xd280170e, Offset: 0x1fa8
// Size: 0x52
function setup_spawners() {
    spawner::add_global_spawn_function("axis", &infection_util::function_2f6bf570);
    infection_util::function_aa0ddbc3(1, 5);
    infection_util::function_c8d7e76("fold_reverse_anims");
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xac00deb7, Offset: 0x2008
// Size: 0x8a
function function_e310ea1e() {
    level.var_335e3b92 = new class_2e121905();
    [[ level.var_335e3b92 ]]->function_147315f(self, "sp_tank_gunner", "");
    [[ level.var_335e3b92 ]]->function_d4274a7(1);
    self util::function_e218424d();
    self cybercom::function_59965309("cybercom_surge");
    namespace_f25bd8c8::function_7356f9fd();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x54e64f68, Offset: 0x20a0
// Size: 0x112
function function_daf631fe() {
    trigger::wait_till("t_church_interior");
    s_foy_gather_point_church = struct::get("s_foy_gather_point_church", "targetname");
    objectives::complete("cp_level_infection_gather_church", s_foy_gather_point_church);
    level thread namespace_bed101ee::function_973b77f9();
    if (isdefined(level.var_335e3b92)) {
        [[ level.var_335e3b92 ]]->delete_ai();
    }
    function_d90d60f3(0);
    infection_util::function_3ea445de();
    infection_util::function_aa0ddbc3(1, 0);
    spawner::remove_global_spawn_function("axis", &infection_util::function_2f6bf570);
    level clientfield::set("dynent_catcher", 0);
    level thread skipto::function_be8adfb8("village_inception");
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xd92bfc36, Offset: 0x21c0
// Size: 0x2a
function function_16cd546() {
    wait 1;
    level dialog::remote("hall_the_german_tiger_tan_0", 1, "NO_DNI");
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xa863cfa8, Offset: 0x21f8
// Size: 0x1a
function function_9a0f8909() {
    spawner::simple_spawn_single("sp_tiger_tank_fold");
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xd2e25910, Offset: 0x2220
// Size: 0x1c2
function function_b366d9e9() {
    if (!level.tank_activated) {
        array::thread_all(level.activeplayers, &coop::function_e9f7384d);
        level.tank_activated = 1;
        var_dc01a2cf = getent("t_sarah_fold_objective_1", "targetname");
        if (isdefined(var_dc01a2cf)) {
            trigger::use("t_sarah_fold_objective_1");
        }
        level thread function_16cd546();
        nd_start = getvehiclenode("nd_tank_path", "targetname");
        level thread scene::play("p7_fxanim_cp_infection_tank_wall_break_bundle");
        [[ level.var_335e3b92 ]]->function_d4274a7(0);
        level.var_335e3b92.m_vehicle thread vehicle::get_on_and_go_path(nd_start);
        level.var_335e3b92.m_vehicle thread vehicle_rumble();
        foreach (player in level.players) {
            earthquake(0.22, 3.5, player.origin, -106);
        }
        wait 3.5;
        [[ level.var_335e3b92 ]]->function_ce839946();
        level thread function_aa3464ca();
    }
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x7ad112b7, Offset: 0x23f0
// Size: 0x59
function vehicle_rumble() {
    self endon(#"death");
    while (true) {
        if (abs(self getspeedmph()) < 10) {
            self playrumbleonentity("tank_rumble");
        }
        wait 1;
    }
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xc6659e66, Offset: 0x2458
// Size: 0x42
function function_aa3464ca() {
    while (isalive(level.var_335e3b92.m_vehicle)) {
        wait 0.1;
    }
    wait 3;
    function_d4f810d();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x34475807, Offset: 0x24a8
// Size: 0x32
function function_1c2ef59f() {
    level endon(#"hash_6ee94cb6");
    trigger::wait_till("t_tank_retreat_1");
    [[ level.var_335e3b92 ]]->function_f7f47181();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x1b578b6, Offset: 0x24e8
// Size: 0x2a
function function_aa278664() {
    trigger::wait_till("t_tank_retreat_2");
    [[ level.var_335e3b92 ]]->function_f7f47181();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xf307af67, Offset: 0x2520
// Size: 0x32
function function_d02a00cd() {
    level endon(#"hash_6ee94cb6");
    trigger::wait_till("t_tank_retreat_3");
    [[ level.var_335e3b92 ]]->function_f7f47181();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x334b1895, Offset: 0x2560
// Size: 0x2a
function function_5e229192() {
    trigger::wait_till("t_tank_retreat_4");
    [[ level.var_335e3b92 ]]->function_f7f47181();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x998a10fc, Offset: 0x2598
// Size: 0x6a
function function_b1600743() {
    self endon(#"hash_2d8736c7");
    array::spread_all(level.players, &infection_util::function_c6e0527c, "s_tank_lookat", 2, "lookat_tank");
    level waittill(#"lookat_tank");
    level notify(#"hash_b1600743");
    function_b366d9e9();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xa6f3c37d, Offset: 0x2610
// Size: 0x52
function function_51a0e924() {
    array::spread_all(level.players, &infection_util::function_c6e0527c, "s_church_lookat", 2, "lookat_church", 2600);
    level waittill(#"lookat_church");
    function_8dc356ff();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x68d56974, Offset: 0x2670
// Size: 0x2a
function function_6d19283f() {
    trigger::wait_till("t_church_lookat");
    function_8dc356ff();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xd92106f0, Offset: 0x26a8
// Size: 0x42
function function_8dc356ff() {
    if (!level.var_9fc31553) {
        level.var_9fc31553 = 1;
        spawner::simple_spawn_single("sp_chruch_mg_01");
        spawner::simple_spawn_single("sp_chruch_mg_02");
    }
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xb5c8d5d6, Offset: 0x26f8
// Size: 0x3a
function function_2d8736c7() {
    self endon(#"hash_b1600743");
    trigger::wait_till("t_tank");
    level notify(#"hash_2d8736c7");
    function_b366d9e9();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x20984d91, Offset: 0x2740
// Size: 0x9a
function function_6a6562a7() {
    trigger::wait_till("t_cemetery_retreat");
    level thread infection_util::function_642da963("sp_fold_guys_tank_ai", "t_sp_fold_guys_3_ai");
    level thread infection_util::function_642da963("sp_fold_guys_2_ai", "t_sp_fold_guys_3_ai");
    level thread infection_util::function_810ccf7("t_foy_guys_0_and_1_retreat_goal_2", "t_sp_fold_guys_3_ai");
    level thread infection_util::function_810ccf7("t_sp_fold_guys_2_ai", "t_sp_fold_guys_3_ai");
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xd7b83509, Offset: 0x27e8
// Size: 0x32
function function_4d4c8709() {
    trigger::wait_till("t_infection_fold_debris_2");
    level clientfield::set("infection_fold_debris_2", 1);
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xcf0f6f2e, Offset: 0x2828
// Size: 0x32
function function_274a0ca0() {
    trigger::wait_till("t_infection_fold_debris_3");
    level clientfield::set("infection_fold_debris_3", 1);
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x9b9a267, Offset: 0x2868
// Size: 0x32
function function_315b657f() {
    trigger::wait_till("t_infection_fold_debris_4");
    level clientfield::set("infection_fold_debris_4", 1);
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xa0a78a46, Offset: 0x28a8
// Size: 0x3a
function function_29e53c05() {
    trigger::wait_till("t_bank_retreat");
    level thread infection_util::function_810ccf7("t_bank", "t_foy_guys_0_and_1_retreat_goal");
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xcc504a08, Offset: 0x28f0
// Size: 0x82
function function_5f1b3809() {
    trigger::wait_till("t_foy_guys_0_and_1_retreat");
    level thread infection_util::function_642da963("sp_fold_guys_0_ai", "t_foy_guys_0_and_1_retreat_goal");
    level thread infection_util::function_642da963("sp_fold_guys_1_ai", "t_foy_guys_0_and_1_retreat_goal");
    wait 5.5;
    level thread infection_util::function_642da963("sp_fold_guys_1_ai", "t_foy_guys_0_and_1_retreat_goal");
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xb44c1441, Offset: 0x2980
// Size: 0x3a
function function_bb707466() {
    trigger::wait_till("t_foy_guys_0_and_1_retreat_2");
    level thread infection_util::function_810ccf7("t_foy_guys_0_and_1_retreat_goal", "t_foy_guys_0_and_1_retreat_goal_2");
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x799d114a, Offset: 0x29c8
// Size: 0x2a
function function_81e49583() {
    trigger::wait_till("t_sm_fold_guys_4");
    function_d4f810d();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0xd269888a, Offset: 0x2a00
// Size: 0x32
function function_d4f810d() {
    if (!spawn_manager::is_enabled("sm_fold_guys_4")) {
        spawn_manager::enable("sm_fold_guys_4");
    }
}

// Namespace namespace_4e2074f4
// Params 1, eflags: 0x0
// Checksum 0x234a6a6e, Offset: 0x2a40
// Size: 0x6b
function function_34fbad21(a_ents) {
    foreach (ent in a_ents) {
        ent ai::set_ignoreme(1);
    }
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x756d229f, Offset: 0x2ab8
// Size: 0x3a
function function_75ddceb0() {
    self endon(#"death");
    level notify(#"hash_75ddceb0");
    self util::unmake_hero("sarah");
    self util::self_delete();
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x59fba61e, Offset: 0x2b00
// Size: 0xda
function function_e6ee1935() {
    level waittill(#"hash_75ddceb0");
    util::wait_network_frame();
    level clientfield::set("light_church_ext_window", 1);
    level.var_42189297 = util::function_740f8516("sarah");
    level.var_42189297 clientfield::set("sarah_body_light", 1);
    level.var_42189297 thread scene::play("cin_inf_11_04_fold_vign_walk_end", level.var_42189297);
    s_foy_gather_point_church = struct::get("s_foy_gather_point_church", "targetname");
    objectives::set("cp_level_infection_gather_church", s_foy_gather_point_church);
}

// Namespace namespace_4e2074f4
// Params 0, eflags: 0x0
// Checksum 0x7c537a66, Offset: 0x2be8
// Size: 0x2a
function function_20f82ee2() {
    trigger::wait_till("t_cemetery_retreat");
    savegame::checkpoint_save();
}

