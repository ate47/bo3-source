#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/cp_mi_cairo_ramses_sound;
#using scripts/cp/cp_mi_cairo_ramses_fx;
#using scripts/cp/cp_mi_cairo_ramses_station_walk;
#using scripts/cp/cp_mi_cairo_ramses_station_fight;
#using scripts/cp/cp_mi_cairo_ramses_level_start;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/compass;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_e55eaf53;

// Namespace namespace_e55eaf53
// Params 1, eflags: 0x0
// Checksum 0xd438461a, Offset: 0x898
// Size: 0x192
function main(var_74cd64bc) {
    level flag::init("raps_door_used");
    precache();
    if (var_74cd64bc) {
        function_e29f0dd6();
        level thread function_2ed0dd8e();
        level scene::skipto_end("cin_ram_02_04_walk_1st_introduce_04");
        level thread namespace_7434c6b7::function_bc43c2f8(0);
        load::function_a2995f22();
        function_b760b954();
        namespace_391e4301::function_e7ebe596();
    }
    function_c99967dc(1);
    scene::add_scene_func("cin_ram_02_interview_3rd_sh010", &function_57bc36e6, "play");
    scene::add_scene_func("cin_ram_02_interview_3rd_sh270", &namespace_391e4301::function_eabc6e2f, "play");
    scene::add_scene_func("cin_ram_02_interview_3rd_sh270", &function_830dd1fa, "done");
    scene::add_scene_func("cin_ram_02_interview_3rd_sh270", &function_57bc36e6, "done", 0);
    function_bf7cc686(var_74cd64bc);
}

// Namespace namespace_e55eaf53
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xa38
// Size: 0x2
function precache() {
    
}

// Namespace namespace_e55eaf53
// Params 0, eflags: 0x0
// Checksum 0xfc34ca93, Offset: 0xa48
// Size: 0x82
function function_e29f0dd6() {
    level.var_2fd26037 = util::function_740f8516("hendricks");
    level.var_7a9855f3 = util::function_740f8516("rachel");
    level.var_9db406db = util::function_740f8516("khalil");
    skipto::teleport_ai("interview_dr_nasser", level.var_9db406db);
}

// Namespace namespace_e55eaf53
// Params 0, eflags: 0x0
// Checksum 0x9c1695fa, Offset: 0xad8
// Size: 0x32
function function_2ed0dd8e() {
    level thread scene::init("cin_ram_02_interview_3rd_sh010_static_props");
    scene::play("cin_ram_02_04_interview_salim_wait");
}

// Namespace namespace_e55eaf53
// Params 0, eflags: 0x0
// Checksum 0xbbf6e264, Offset: 0xb18
// Size: 0x2a
function function_1bcd464b() {
    self notify(#"hash_638e4884");
    self util::function_16c71b8(1);
    self setmovespeedscale(1);
}

// Namespace namespace_e55eaf53
// Params 1, eflags: 0x0
// Checksum 0xf2e4da8e, Offset: 0xb50
// Size: 0x142
function function_bf7cc686(var_74cd64bc) {
    if (!var_74cd64bc) {
        foreach (e_player in level.activeplayers) {
            e_player thread function_1bcd464b();
        }
    }
    function_6a80eecf();
    level flag::wait_till("dr_nasser_interview_started");
    namespace_391e4301::function_e7ebe596(0);
    level thread namespace_e4c0c552::function_53de5c02();
    level thread namespace_bedc6a60::function_e5ed2910();
    function_e9053432();
    if (isdefined(level.var_d34cc407)) {
        level thread [[ level.var_d34cc407 ]]();
    }
    level scene::play("cin_ram_02_interview_3rd_sh010", level.var_c8b5ad07);
    level flag::wait_till("raps_door_used");
    skipto::function_be8adfb8("interview_dr_nasser");
}

// Namespace namespace_e55eaf53
// Params 1, eflags: 0x0
// Checksum 0x12a8542d, Offset: 0xca0
// Size: 0xe2
function function_830dd1fa(a_ents) {
    level thread function_7995f971();
    function_c99967dc(2);
    objectives::complete("cp_level_ramses_interrogate_salim");
    objectives::complete("cp_level_ramses_determine_what_salim_knows");
    namespace_391e4301::function_e7ebe596();
    level.var_9db406db thread function_370a5671();
    level util::clientnotify("alert_on");
    level thread function_66a8939();
    battlechatter::function_d9f49fba(1, "bc");
    level thread namespace_7434c6b7::function_bbd12ed2(0);
    level thread function_7452fdb5();
}

// Namespace namespace_e55eaf53
// Params 0, eflags: 0x0
// Checksum 0x584c5b58, Offset: 0xd90
// Size: 0x10a
function function_7995f971() {
    scene::add_scene_func("cin_ram_02_04_interview_part04", &function_f568f95f, "players_done");
    if (scene::function_b1f75ee9()) {
        wait(0.25);
        level thread scene::play("cin_ram_02_04_interview_part04");
    }
    level waittill(#"hash_362049d4");
    objectives::set("cp_level_ramses_protect_salim");
    array::thread_all(getentarray("mobile_armory", "script_noteworthy"), &oed::function_e228c18a, 1);
    level thread scene::init("cin_ram_03_01_defend_1st_rapsintro");
    function_e4a01869();
    function_7648e769();
    level thread namespace_bedc6a60::function_91e74b85();
}

// Namespace namespace_e55eaf53
// Params 1, eflags: 0x0
// Checksum 0x6f920761, Offset: 0xea8
// Size: 0x22
function function_f568f95f(a_ents) {
    util::function_93831e79("interview_igc_done");
}

// Namespace namespace_e55eaf53
// Params 0, eflags: 0x0
// Checksum 0x2e7a9908, Offset: 0xed8
// Size: 0x62
function function_370a5671() {
    var_8279bcd1 = struct::get("defend_ramses_station_khalil_start_spot", "targetname");
    self clearforcedgoal();
    self.goalradius = 32;
    self forceteleport(var_8279bcd1.origin, var_8279bcd1.angles);
}

// Namespace namespace_e55eaf53
// Params 2, eflags: 0x0
// Checksum 0x1a819aed, Offset: 0xf48
// Size: 0x1e
function function_57bc36e6(a_ents, b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
}

// Namespace namespace_e55eaf53
// Params 0, eflags: 0x0
// Checksum 0xe42bd19e, Offset: 0xf70
// Size: 0x8a
function function_66a8939() {
    sndent = spawn("script_origin", (7763, -48, 53));
    sndent playloopsound("evt_postint_battle_walla", 0.25);
    flag::wait_till("raps_door_used");
    sndent stoploopsound(2);
    wait(2);
    sndent delete();
}

// Namespace namespace_e55eaf53
// Params 1, eflags: 0x0
// Checksum 0x4763884, Offset: 0x1008
// Size: 0x92
function function_7452fdb5(a_ents) {
    scene::init("cin_ram_03_01_defend_1st_rapsintro_doors_only");
    var_94312345 = getent("raps_intro_door_clip", "targetname");
    var_da30185c = struct::get(var_94312345.target, "targetname");
    var_94312345 moveto(var_da30185c.origin, 0.05);
}

// Namespace namespace_e55eaf53
// Params 2, eflags: 0x0
// Checksum 0x27ba2b01, Offset: 0x10a8
// Size: 0x18b
function function_6a80eecf(var_41b16c2b, var_a083aff5) {
    if (!isdefined(var_a083aff5)) {
        var_a083aff5 = 0;
    }
    if (isdefined(var_41b16c2b)) {
        level waittill(var_41b16c2b);
    }
    if (var_a083aff5) {
        level flag::wait_till("rs_walkthrough_safehouse_enter");
    }
    var_80f9be56 = getent("armory_door_collision", "targetname");
    var_80f9be56 solid();
    var_9224b839 = getentarray("interrogation_door", "targetname");
    var_169a71c6 = struct::get("armory_door_down", "targetname");
    foreach (e_piece in var_9224b839) {
        e_piece.old_origin = e_piece.origin;
        var_5d789cd = (e_piece.origin[0], e_piece.origin[1], var_169a71c6.origin[2]);
        e_piece moveto(var_5d789cd, 1.5);
        e_piece playsound("evt_postint_door_open");
    }
}

// Namespace namespace_e55eaf53
// Params 1, eflags: 0x0
// Checksum 0xf3e85b91, Offset: 0x1240
// Size: 0x123
function function_e4a01869(a_ents) {
    var_9224b839 = getentarray("interrogation_door", "targetname");
    var_169a71c6 = struct::get("armory_door_down", "targetname");
    var_80f9be56 = getent("armory_door_collision", "targetname");
    var_80f9be56 notsolid();
    foreach (e_piece in var_9224b839) {
        if (isdefined(e_piece.old_origin)) {
            e_piece moveto(e_piece.old_origin, 1.5);
            e_piece playsound("evt_postint_door_open");
        }
    }
}

// Namespace namespace_e55eaf53
// Params 0, eflags: 0x0
// Checksum 0xd3c6ca46, Offset: 0x1370
// Size: 0x102
function function_b760b954() {
    var_fc044dad = struct::get("interview_start_obj", "targetname");
    cmodel2_t = spawn("trigger_radius_use", var_fc044dad.origin + (-15, 0, 20), 0, 64, 64);
    cmodel2_t triggerignoreteam();
    cmodel2_t setvisibletoall();
    cmodel2_t usetriggerrequirelookat();
    cmodel2_t setteamfortrigger("none");
    objectives::complete("cp_level_ramses_determine_what_salim_knows");
    util::function_14518e76(cmodel2_t, %cp_level_ramses_start_interview, %CP_MI_CAIRO_RAMSES_START_INTERVIEW, &function_4f753dd2);
}

// Namespace namespace_e55eaf53
// Params 1, eflags: 0x0
// Checksum 0x38506d2e, Offset: 0x1480
// Size: 0x52
function function_4f753dd2(e_player) {
    level.var_c8b5ad07 = e_player;
    level flag::set("dr_nasser_interview_started");
    objectives::complete("cp_level_ramses_start_interview");
    self gameobjects::destroy_object(1);
}

// Namespace namespace_e55eaf53
// Params 0, eflags: 0x0
// Checksum 0xa2fa56fe, Offset: 0x14e0
// Size: 0xd2
function function_7648e769() {
    s_exit = struct::get("interview_exit_obj", "targetname");
    t_exit = spawn("trigger_radius_use", s_exit.origin, 0, 100, 64);
    t_exit triggerignoreteam();
    t_exit setvisibletoall();
    t_exit setteamfortrigger("none");
    util::function_14518e76(t_exit, %cp_level_ramses_exit_interview, %CP_MI_CAIRO_RAMSES_EXIT_INTERVIEW, &function_c4bcf67b);
}

// Namespace namespace_e55eaf53
// Params 1, eflags: 0x0
// Checksum 0x1504ea77, Offset: 0x15c0
// Size: 0x6a
function function_c4bcf67b(e_player) {
    level.var_be0fc6c8 = e_player;
    level flag::set("raps_door_used");
    objectives::complete("cp_level_ramses_exit_interview");
    objectives::set("cp_level_ramses_defend_station");
    self gameobjects::destroy_object(1);
}

// Namespace namespace_e55eaf53
// Params 1, eflags: 0x0
// Checksum 0x70d790ab, Offset: 0x1638
// Size: 0xea
function function_c99967dc(var_2f9491f0) {
    if (!isdefined(var_2f9491f0)) {
        var_2f9491f0 = 0;
    }
    var_f5b75111 = getent("nasser_interview_screen_before", "targetname");
    var_9f1f82be = getent("nasser_interview_screen_after", "targetname");
    if (var_2f9491f0 == 0) {
        var_f5b75111 hide();
        var_9f1f82be hide();
        return;
    }
    if (var_2f9491f0 == 1) {
        var_f5b75111 show();
        var_9f1f82be hide();
        return;
    }
    if (var_2f9491f0 == 2) {
        var_f5b75111 hide();
        var_9f1f82be hide();
    }
}

// Namespace namespace_e55eaf53
// Params 0, eflags: 0x0
// Checksum 0x89b45a0d, Offset: 0x1730
// Size: 0x1eb
function function_e9053432() {
    var_89a5068f = [];
    if (!isdefined(var_89a5068f)) {
        var_89a5068f = [];
    } else if (!isarray(var_89a5068f)) {
        var_89a5068f = array(var_89a5068f);
    }
    var_89a5068f[var_89a5068f.size] = "cin_ram_02_04_walk_1st_introduce_01";
    if (!isdefined(var_89a5068f)) {
        var_89a5068f = [];
    } else if (!isarray(var_89a5068f)) {
        var_89a5068f = array(var_89a5068f);
    }
    var_89a5068f[var_89a5068f.size] = "cin_ram_02_04_walk_1st_introduce_02";
    if (!isdefined(var_89a5068f)) {
        var_89a5068f = [];
    } else if (!isarray(var_89a5068f)) {
        var_89a5068f = array(var_89a5068f);
    }
    var_89a5068f[var_89a5068f.size] = "cin_ram_02_04_walk_1st_introduce_03";
    if (!isdefined(var_89a5068f)) {
        var_89a5068f = [];
    } else if (!isarray(var_89a5068f)) {
        var_89a5068f = array(var_89a5068f);
    }
    var_89a5068f[var_89a5068f.size] = "cin_ram_02_04_walk_1st_introduce_04";
    if (!isdefined(var_89a5068f)) {
        var_89a5068f = [];
    } else if (!isarray(var_89a5068f)) {
        var_89a5068f = array(var_89a5068f);
    }
    var_89a5068f[var_89a5068f.size] = "cin_ram_02_04_interview_part01_static_props";
    foreach (str_anim in var_89a5068f) {
        if (scene::is_active(str_anim)) {
            scene::stop(str_anim);
        }
    }
}

