#using scripts/cp/_skipto;
#using scripts/shared/ai_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/array_shared;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/cp_mi_eth_prologue;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/_dialog;
#using scripts/cp/_util;
#using scripts/cp/_load;
#using scripts/shared/callbacks_shared;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_dccf27b3;

// Namespace namespace_dccf27b3
// Params 0, eflags: 0x0
// Checksum 0xc382570b, Offset: 0x6f0
// Size: 0x22
function function_23ed1506() {
    function_936b4205();
    level thread function_68ad0269();
}

// Namespace namespace_dccf27b3
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x720
// Size: 0x2
function function_936b4205() {
    
}

// Namespace namespace_dccf27b3
// Params 0, eflags: 0x0
// Checksum 0x47e46b8a, Offset: 0x730
// Size: 0x1fa
function function_68ad0269() {
    level thread cp_prologue_util::function_950d1c3b(0);
    level thread ai_cleanup();
    level thread function_26f3c859();
    level thread function_55b2b7ce();
    level thread function_e3957b4();
    level.var_2fd26037 clearforcedgoal();
    level.var_2fd26037 setgoal(level.var_2fd26037.origin, 1);
    level.var_5d4087a6 = util::function_740f8516("hyperion");
    level.var_7f246cd7 = util::function_740f8516("pallas");
    level.var_92d245e2 = util::function_740f8516("prometheus");
    level.var_f58c9f31 = util::function_740f8516("theia");
    level.var_92d245e2 sethighdetail(1);
    level.var_2fd26037 sethighdetail(1);
    function_9f230ee1();
    cp_prologue_util::function_47a62798(0);
    array::run_all(level.players, &util::function_16c71b8, 0);
    callback::remove_on_spawned(&cp_mi_eth_prologue::function_4d4f1d4f);
    level notify(#"hash_e1626ff0");
    level.var_92d245e2 sethighdetail(0);
    level.var_2fd26037 sethighdetail(0);
    skipto::function_be8adfb8("skipto_intro_cyber_soldiers");
}

// Namespace namespace_dccf27b3
// Params 0, eflags: 0x0
// Checksum 0x44887c13, Offset: 0x938
// Size: 0x42
function function_55b2b7ce() {
    level waittill(#"hash_999aab74");
    var_771bcc8f = getent("cyber_solider_intro_lift_clip", "targetname");
    var_771bcc8f delete();
}

// Namespace namespace_dccf27b3
// Params 0, eflags: 0x0
// Checksum 0xa47dbbc8, Offset: 0x988
// Size: 0x162
function function_26f3c859() {
    wait 20;
    level thread scene::play("p7_fxanim_cp_prologue_hangar_doors_02_bundle");
    cyber_hangar_gate_r_pos = getent("cyber_hangar_gate_r_pos", "targetname");
    cyber_hangar_gate_r_pos playsound("evt_hangar_start_r");
    cyber_hangar_gate_r_pos playloopsound("evt_hangar_loop_r");
    cyber_hangar_gate_l_pos = getent("cyber_hangar_gate_l_pos", "targetname");
    cyber_hangar_gate_l_pos playsound("evt_hangar_start_l");
    cyber_hangar_gate_l_pos playloopsound("evt_hangar_loop_l");
    level waittill(#"hash_8e385112");
    cyber_hangar_gate_r_pos playsound("evt_hangar_stop_r");
    cyber_hangar_gate_l_pos playsound("evt_hangar_stop_l");
    cyber_hangar_gate_r_pos stoploopsound(0.1);
    cyber_hangar_gate_l_pos stoploopsound(0.1);
    level util::clientnotify("sndBW");
    umbragate_set("umbra_gate_hangar_02", 0);
}

// Namespace namespace_dccf27b3
// Params 1, eflags: 0x0
// Checksum 0xf8c92bc0, Offset: 0xaf8
// Size: 0x62
function function_4ed5ddb9(var_5b01a37b) {
    n_node = getnode(var_5b01a37b, "targetname");
    self forceteleport(n_node.origin, n_node.angles, 1);
    self setgoal(n_node);
}

// Namespace namespace_dccf27b3
// Params 1, eflags: 0x0
// Checksum 0x6e7c536d, Offset: 0xb68
// Size: 0x62
function function_b75b4d97(var_6c5c89e1) {
    if (isdefined(var_6c5c89e1)) {
        var_9de10fe3 = getnode(var_6c5c89e1, "targetname");
        self setgoal(var_9de10fe3, 1, 16);
        return;
    }
    self setgoal(self.origin, 1, 16);
}

// Namespace namespace_dccf27b3
// Params 0, eflags: 0x0
// Checksum 0x7acac25, Offset: 0xbd8
// Size: 0x22
function function_9f230ee1() {
    level waittill(#"hash_af22422d");
    exploder::exploder_stop("light_exploder_igc_cybersoldier");
}

// Namespace namespace_dccf27b3
// Params 1, eflags: 0x0
// Checksum 0xed0be025, Offset: 0xc08
// Size: 0x233
function function_679e7da9(a_ents) {
    level thread function_ac290386();
    scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack", &namespace_21b2c1f2::function_43ead72c, "play");
    scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack", &function_39b556d, "play");
    scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack", &function_e98e1240, "play");
    scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_sarah_attack", &function_4e5acf5e, "play");
    scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack", &function_a21df404, "play");
    scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_confrontation_hkm", &function_89f840a1, "play");
    scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_confrontation_hkm", &function_d71a5c1b, "play");
    scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_confrontation", &function_73293683, "play");
    if (isdefined(level.var_fba4a2cc)) {
        level thread [[ level.var_fba4a2cc ]]();
    }
    level thread scene::play("cin_pro_09_01_intro_1st_cybersoldiers_diaz_attack");
    level thread scene::play("cin_pro_09_01_intro_1st_cybersoldiers_maretti_attack");
    level thread scene::play("cin_pro_09_01_intro_1st_cybersoldiers_sarah_attack");
    level thread scene::play("cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack");
    level waittill(#"hash_afbcd4e8");
    util::clear_streamer_hint();
    level notify(#"hash_af22422d");
}

// Namespace namespace_dccf27b3
// Params 1, eflags: 0x0
// Checksum 0x148e0e4f, Offset: 0xe48
// Size: 0x62
function function_d71a5c1b(a_ents) {
    level waittill(#"hash_60921fc7");
    level.var_2fd26037 thread function_b75b4d97("node_cyber_hendricks");
    level.var_9db406db thread function_b75b4d97();
    level.var_4d5a4697 thread function_b75b4d97();
}

// Namespace namespace_dccf27b3
// Params 1, eflags: 0x0
// Checksum 0xdf549722, Offset: 0xeb8
// Size: 0x7a
function function_73293683(a_ents) {
    level waittill(#"hash_afbcd4e8");
    level.var_92d245e2 thread function_b75b4d97();
    level.var_5d4087a6 thread function_b75b4d97();
    level.var_7f246cd7 thread function_b75b4d97("node_cyber_diaz");
    level.var_f58c9f31 thread function_b75b4d97();
}

// Namespace namespace_dccf27b3
// Params 0, eflags: 0x0
// Checksum 0x5ee43fe3, Offset: 0xf40
// Size: 0xca
function function_ac290386() {
    level waittill(#"hash_b7587dcc");
    level waittill(#"hash_63ae24ea");
    array::run_all(level.players, &util::function_16c71b8, 1);
    callback::on_spawned(&cp_mi_eth_prologue::function_4d4f1d4f);
    array::thread_all(level.players, &cp_mi_eth_prologue::function_7072c5d8);
    level waittill(#"hash_af43d596");
    playsoundatposition("evt_soldierintro_walla_panic_1", (6859, 886, -65));
    playsoundatposition("evt_soldierintro_walla_panic_2", (6870, 598, -59));
}

// Namespace namespace_dccf27b3
// Params 1, eflags: 0x0
// Checksum 0xe2862f08, Offset: 0x1018
// Size: 0xca
function function_89f840a1(a_ents) {
    var_9db406db = a_ents["khalil"];
    var_4d5a4697 = a_ents["minister"];
    var_9db406db.goalradius = 32;
    var_4d5a4697.goalradius = 32;
    level waittill(#"hash_fd263aff");
    var_4d5a4697 setgoal(var_4d5a4697.origin);
    var_4d5a4697 ai::set_behavior_attribute("vignette_mode", "fast");
    level waittill(#"hash_19175c89");
    var_9db406db setgoal(var_9db406db.origin);
    var_9db406db ai::set_behavior_attribute("vignette_mode", "fast");
}

// Namespace namespace_dccf27b3
// Params 1, eflags: 0x0
// Checksum 0xe607f23d, Offset: 0x10f0
// Size: 0x52
function function_39b556d(a_ents) {
    var_7b00e29e = a_ents["pallas"];
    var_7b00e29e function_9110a277(1, 0);
    var_7b00e29e waittill(#"hash_c22232d8");
    var_7b00e29e function_9110a277(0);
}

// Namespace namespace_dccf27b3
// Params 1, eflags: 0x0
// Checksum 0xbff1fc5a, Offset: 0x1150
// Size: 0xca
function function_e98e1240(a_ents) {
    var_7b00e29e = a_ents["prometheus"];
    var_7b00e29e function_9110a277(1, 0);
    var_7b00e29e waittill(#"hash_c22232d8");
    var_7b00e29e function_9110a277(0);
    var_7b00e29e waittill(#"cloak");
    var_9de10fe3 = getnode("nd_taylor_after_intro", "targetname");
    var_7b00e29e setgoal(var_9de10fe3);
    var_7b00e29e function_9110a277(1, 1);
    wait 2;
    var_7b00e29e ghost();
}

// Namespace namespace_dccf27b3
// Params 1, eflags: 0x0
// Checksum 0xf75bd149, Offset: 0x1228
// Size: 0xca
function function_4e5acf5e(a_ents) {
    var_7b00e29e = a_ents["theia"];
    var_7b00e29e function_9110a277(1, 0);
    var_7b00e29e waittill(#"hash_c22232d8");
    var_7b00e29e function_9110a277(0);
    var_7b00e29e waittill(#"cloak");
    var_9de10fe3 = getnode("nd_theia_after_intro", "targetname");
    var_7b00e29e setgoal(var_9de10fe3);
    var_7b00e29e function_9110a277(1, 1);
    wait 2;
    var_7b00e29e ghost();
}

// Namespace namespace_dccf27b3
// Params 1, eflags: 0x0
// Checksum 0xb75a8568, Offset: 0x1300
// Size: 0x9a
function function_a21df404(a_ents) {
    var_7b00e29e = a_ents["hyperion"];
    var_7b00e29e waittill(#"cloak");
    var_9de10fe3 = getnode("nd_hyperion_after_intro", "targetname");
    var_7b00e29e setgoal(var_9de10fe3);
    var_7b00e29e function_9110a277(1, 1);
    wait 1.5;
    var_7b00e29e ghost();
}

// Namespace namespace_dccf27b3
// Params 2, eflags: 0x0
// Checksum 0x4096e0b4, Offset: 0x13a8
// Size: 0xaa
function function_9110a277(var_e33a0786, b_use_spawn_fx) {
    if (!isdefined(b_use_spawn_fx)) {
        b_use_spawn_fx = 1;
    }
    self endon(#"death");
    if (var_e33a0786 == 1) {
        self playsoundontag("gdt_activecamo_on_npc", "tag_eye");
    } else {
        self playsoundontag("gdt_activecamo_off_npc", "tag_eye");
    }
    if (isdefined(b_use_spawn_fx) && b_use_spawn_fx) {
        self clientfield::set("cyber_soldier_camo", 2);
        wait 2;
    }
    self clientfield::set("cyber_soldier_camo", var_e33a0786);
}

// Namespace namespace_dccf27b3
// Params 0, eflags: 0x0
// Checksum 0x27f2507f, Offset: 0x1460
// Size: 0x3a
function function_8bf0b925() {
    var_950ed8c6 = getnode("ms_lift_exit1_begin", "targetname");
    linktraversal(var_950ed8c6);
}

// Namespace namespace_dccf27b3
// Params 0, eflags: 0x0
// Checksum 0x3bd8827b, Offset: 0x14a8
// Size: 0x132
function function_e3957b4() {
    if (!isdefined(level.var_3dce3f88)) {
        level.var_3dce3f88 = spawn("script_model", level.var_be31aa9a.origin);
        level.var_be31aa9a linkto(level.var_3dce3f88);
    }
    level.var_3dce3f88 movez(-36, 12.3);
    level.var_3dce3f88 waittill(#"movedone");
    level.var_2fd26037 clearforcedgoal();
    level.var_2fd26037 setgoal(level.var_2fd26037.origin, 1);
    level thread function_8bf0b925();
    level.var_9db406db unlink();
    level.var_7b90133a stoploopsound(0.1);
    level.var_be31aa9a playsound("evt_freight_lift_stop");
}

// Namespace namespace_dccf27b3
// Params 0, eflags: 0x0
// Checksum 0x9e7f7384, Offset: 0x15e8
// Size: 0x112
function function_f9753551() {
    level.var_be31aa9a = getent("freight_lift", "targetname");
    level.var_be31aa9a playsound("evt_freight_lift_start");
    level.var_7b90133a = spawn("script_origin", level.var_be31aa9a.origin);
    level.var_7b90133a linkto(level.var_be31aa9a);
    level.var_7b90133a playloopsound("evt_freight_lift_loop");
    level.var_1dd14818 = 1;
    level.var_3dce3f88 movez(-354, 0.05);
    level.var_3dce3f88 waittill(#"movedone");
    level.var_7b90133a stoploopsound(0.1);
}

// Namespace namespace_dccf27b3
// Params 0, eflags: 0x0
// Checksum 0x23809f36, Offset: 0x1708
// Size: 0x9b
function ai_cleanup() {
    a_ais = getaiteamarray("axis");
    foreach (ai in a_ais) {
        if (isalive(ai)) {
            ai delete();
        }
    }
}

