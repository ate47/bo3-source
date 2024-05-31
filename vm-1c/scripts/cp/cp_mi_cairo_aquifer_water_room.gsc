#using scripts/cp/cp_mi_cairo_aquifer_sound;
#using scripts/cp/gametypes/_save;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/cp/cp_mi_cairo_aquifer_ambience;
#using scripts/cp/cp_mi_cairo_aquifer_objectives;
#using scripts/cp/cp_mi_cairo_aquifer_utility;
#using scripts/shared/fx_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/math_shared;
#using scripts/cp/_hazard;
#using scripts/shared/colors_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/array_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_objectives;
#using scripts/cp/_dialog;
#using scripts/cp/_debug;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/_load;

#namespace namespace_967f4af8;

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_d290ebfa
// Checksum 0xe5a01181, Offset: 0xdb0
// Size: 0x124
function main() {
    level._effect["emp_flash"] = "_t6/weapon/emp/fx_emp_explosion";
    thread init_flags();
    thread function_60f7b1b6();
    thread function_1ecf48ef();
    thread function_4a90c357();
    thread function_ee430caa();
    thread function_a1b52577();
    thread function_18af354a();
    spawner::add_spawn_function_group("water_robots", "targetname", &function_a527e6f9);
    spawner::add_spawn_function_group("water_robots2", "targetname", &function_a527e6f9);
    spawner::add_spawn_function_group("water_robots3", "targetname", &function_a527e6f9);
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_37af8a07
// Checksum 0xeb475bac, Offset: 0xee0
// Size: 0x84
function init_flags() {
    level flag::init("flag_kayne_ready_trap");
    level flag::init("door_explodes");
    level flag::init("flag_door_explodes");
    level flag::init("flag_double_doors_open");
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_60f7b1b6
// Checksum 0xb708c701, Offset: 0xf70
// Size: 0xa4
function function_60f7b1b6() {
    level endon(#"hash_ee3f7dc5");
    struct = getent("igc_kane_khalil_1", "targetname");
    level flag::wait_till("flag_kayne_pre_water");
    wait(6);
    struct scene::play("cin_aqu_03_19_pre_water_room_kane", level.var_89ea8991);
    struct scene::play("cin_aqu_03_19_pre_water_room_wait_kane", level.var_89ea8991);
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_1ecf48ef
// Checksum 0x4d807c32, Offset: 0x1020
// Size: 0x364
function function_1ecf48ef() {
    level endon(#"hash_47f08523");
    scene::add_scene_func("cin_aqu_05_01_enter_1st_look", &function_3d8a313e, "play");
    scene::init("cin_aqu_05_01_enter_1st_look");
    level waittill(#"hash_7e64f485");
    var_5b5cfed1 = trigger::wait_till("water_room_igc");
    struct = getent("igc_kane_khalil_1", "targetname");
    level notify(#"hash_ee3f7dc5");
    if (isdefined(level.var_e45bdc20)) {
        level thread [[ level.var_e45bdc20 ]]();
    }
    if (isdefined(level.var_89ea8991) && isalive(level.var_89ea8991)) {
        level.var_89ea8991 delete();
    }
    namespace_84eb777e::function_b3ed487d(1);
    exploder::exploder_stop("lighting_server_perf_lights");
    function_cd377710();
    struct scene::play("cin_aqu_05_01_enter_1st_look", var_5b5cfed1.who);
    namespace_84eb777e::function_61034146(0);
    level flag::set("inside_water_room");
    util::function_93831e79("igc_enter_water_structs");
    level.var_89ea8991 namespace_84eb777e::function_30343b22("kayne_waterroom_swim");
    level.var_89ea8991 thread function_8fdcc95b(1);
    savegame::checkpoint_save();
    setdvar("player_swimSpeed", 80);
    if (isdefined(level.var_dcefc59)) {
        level thread [[ level.var_dcefc59 ]]();
    }
    foreach (p in level.players) {
        p thread function_913d882();
    }
    thread function_645f7873();
    thread function_408f0fb5();
    struct scene::play("cin_aqu_03_20_water_room", level.var_89ea8991);
    struct thread scene::play("cin_aqu_03_20_water_room_idle", level.var_89ea8991);
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_cd377710
// Checksum 0x7acb3cba, Offset: 0x1390
// Size: 0x12a
function function_cd377710() {
    foreach (player in level.activeplayers) {
        if (isdefined(player getlinkedent())) {
            player.var_8fedf36c notify(#"hash_c38e4003");
            player unlink();
            player.var_8fedf36c.state = undefined;
            player.var_8fedf36c clientfield::set("vtol_canopy_state", 0);
            player.var_8fedf36c clientfield::set("vtol_enable_wash_fx", 0);
            wait(0.05);
        }
    }
}

// Namespace namespace_967f4af8
// Params 1, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_3d8a313e
// Checksum 0xd6e906b1, Offset: 0x14c8
// Size: 0x24
function function_3d8a313e(a_ents) {
    namespace_786319bb::function_c897523d("respawn_in_water_room");
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_4a90c357
// Checksum 0x288db59c, Offset: 0x14f8
// Size: 0x29c
function function_4a90c357() {
    level flag::wait_till("flag_kayne_water_moment");
    setdvar("player_swimSpeed", 30);
    level notify(#"hash_47f08523");
    level flag::set("inside_data_center");
    foreach (p in level.activeplayers) {
        p clientfield::set_to_player("player_bubbles_fx", 0);
    }
    level thread lui::screen_fade_out(1);
    wait(1);
    level.var_89ea8991 stopanimscripted();
    setdvar("player_swimSpeed", -106);
    level.var_89ea8991 clientfield::set("kane_bubbles_fx", 0);
    thread function_3ed240f1();
    var_31b9fd4a = getent("doubledoor_sbm", "targetname");
    var_31b9fd4a hide();
    level thread namespace_71a63eac::function_8210b658();
    level thread scene::play("cin_aqu_02_01_floodroom_1st_dragged", level.var_89ea8991);
    level waittill(#"hash_b580186f");
    level notify(#"hash_8f79547f");
    level thread namespace_71a63eac::function_e18f629a();
    util::function_93831e79("igc_post_water_structs");
    setdvar("player_swimSpeed", -106);
    thread function_a079b7e3();
    savegame::checkpoint_save();
    thread function_8aec0a4c();
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_8aec0a4c
// Checksum 0x9a3abe90, Offset: 0x17a0
// Size: 0x20c
function function_8aec0a4c() {
    level endon(#"hash_66250ae7");
    trig = getent("trig_trap_door", "targetname");
    trig triggerenable(0);
    struct = getent("igc_kane_water", "targetname");
    var_31b9fd4a = getent("doubledoor_sbm", "targetname");
    var_31b9fd4a show();
    struct scene::play("cin_aqu_03_21_server_room_enter", level.var_89ea8991);
    struct thread scene::play("cin_aqu_03_21_server_room_idle", level.var_89ea8991);
    level flag::set("flag_kayne_ready_trap");
    thread function_cc9a0395();
    trig triggerenable(1);
    level flag::wait_till("flag_maretti_trap_door");
    level notify(#"hash_eb6a1c8b");
    level.var_89ea8991 scene::stop(1);
    struct thread scene::play("cin_aqu_03_21_server_room_explosion", level.var_89ea8991);
    if (isdefined(level.var_24d74b55)) {
        level thread [[ level.var_24d74b55 ]]();
    }
    level.var_89ea8991 dialog::say("kane_on_me_0");
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_cc9a0395
// Checksum 0x3c3e34a5, Offset: 0x19b8
// Size: 0xfc
function function_cc9a0395() {
    level endon(#"hash_eb6a1c8b");
    wait(2);
    level.var_89ea8991 dialog::say("kane_come_on_get_in_pos_0");
    wait(6);
    level.var_89ea8991 dialog::say("kane_hurry_it_up_0");
    wait(12);
    level.var_89ea8991 dialog::say("kane_come_on_get_in_pos_0");
    wait(20);
    level.var_89ea8991 dialog::say("kane_hurry_it_up_0");
    wait(25);
    level.var_89ea8991 dialog::say("kane_come_on_get_in_pos_0");
    wait(30);
    level.var_89ea8991 dialog::say("kane_hurry_it_up_0");
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_c1808198
// Checksum 0xf8e3184c, Offset: 0x1ac0
// Size: 0xca
function function_c1808198() {
    foreach (p in level.activeplayers) {
        p thread namespace_786319bb::function_89eaa1b3(1.5);
        p hazard::do_damage("o2", 85);
        p thread function_498a7d66();
    }
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_498a7d66
// Checksum 0x45e1feab, Offset: 0x1b98
// Size: 0x54
function function_498a7d66() {
    self endon(#"disconnect");
    self clientfield::set_to_player("player_bubbles_fx", 1);
    wait(2);
    self clientfield::set_to_player("player_bubbles_fx", 0);
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_ee430caa
// Checksum 0x6c165947, Offset: 0x1bf8
// Size: 0x44c
function function_ee430caa() {
    var_99b9d1f2 = trigger::wait_till("water_room_exit_igc");
    level thread namespace_71a63eac::function_973b77f9();
    level notify(#"hash_9f732141");
    level notify(#"hash_bf1c950c");
    namespace_786319bb::function_8bf8a765(1);
    level flag::clear("inside_data_center");
    namespace_84eb777e::function_61034146(1);
    namespace_84eb777e::function_b3ed487d(0);
    exploder::exploder("lighting_server_perf_lights");
    var_ebc124a5 = spawner::get_ai_group_ai("interior_robots");
    var_19e0145d = spawner::get_ai_group_ai("interior_robots_stairs");
    var_f3dd99f4 = spawner::get_ai_group_ai("interior_robots_water");
    var_a40e8c9b = arraycombine(var_ebc124a5, var_19e0145d, 0, 0);
    var_8a13f363 = arraycombine(var_a40e8c9b, var_f3dd99f4, 0, 0);
    foreach (i in var_8a13f363) {
        if (isdefined(i)) {
            i delete();
        }
    }
    if (isdefined(level.var_89ea8991) && isalive(level.var_89ea8991)) {
        level.var_89ea8991 delete();
    }
    if (isdefined(level.var_a8ebf9fc)) {
        level thread [[ level.var_a8ebf9fc ]]();
    }
    thread function_ddc03444();
    struct = getent("igc_kane_khalil_1", "targetname");
    if (!isdefined(level.activeplayers[0].var_8fedf36c)) {
        level.activeplayers[0] namespace_786319bb::function_d683f26a(0);
    }
    level.activeplayers[0].var_8fedf36c show();
    struct thread scene::play("cin_aqu_03_01_platform_1st_secureplatform_vtol", level.activeplayers[0].var_8fedf36c);
    clientfield::set("water_room_exit_scenes", 0);
    struct scene::play("cin_aqu_03_01_platform_1st_secureplatform", var_99b9d1f2.who);
    thread function_430fd872();
    struct scene::play("cin_aqu_03_01_platform_1st_secureplatform_exit");
    level notify(#"hash_2ff2d753");
    struct scene::stop("cin_aqu_03_20_water_room_body_loop", 1);
    savegame::checkpoint_save();
    level flag::set("flag_khalil_water_igc_done");
    struct scene::stop("cin_aqu_03_01_platform_1st_secureplatform");
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_430fd872
// Checksum 0x92039143, Offset: 0x2050
// Size: 0x9c
function function_430fd872() {
    level dialog::remote("hend_we_ve_got_additional_0");
    wait(1);
    level dialog::function_13b3b16a("plyr_copy_that_we_re_on_0");
    wait(4);
    level dialog::function_13b3b16a("plyr_i_see_em_multiple_0");
    level thread namespace_71a63eac::function_b1ee6c2d();
    wait(1);
    level dialog::function_13b3b16a("kane_copy_i_see_em_too_0");
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_ddc03444
// Checksum 0x47a11f9e, Offset: 0x20f8
// Size: 0xe4
function function_ddc03444() {
    var_c0155443 = struct::get("water_room_flyby_1", "targetname");
    var_4e0de508 = struct::get("water_room_flyby_2", "targetname");
    wait(3);
    var_c0155443 scene::play(var_c0155443.scriptbundlename);
    var_c0155443 scene::stop(1);
    wait(8);
    var_4e0de508 scene::play(var_4e0de508.scriptbundlename);
    var_4e0de508 scene::stop(1);
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_a079b7e3
// Checksum 0x153a874f, Offset: 0x21e8
// Size: 0x8c
function function_a079b7e3() {
    level dialog::remote("khal_something_s_jamming_0", 2);
    level dialog::function_13b3b16a("plyr_something_doesn_t_fe_0", 3);
    level.var_89ea8991 dialog::say("kane_yeah_i_got_that_same_0");
    level.var_89ea8991 dialog::say("kane_up_here_ready_weapo_0", 2);
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x0
// namespace_967f4af8<file_0>::function_26031755
// Checksum 0xa83d5152, Offset: 0x2280
// Size: 0x34
function function_26031755() {
    playfxontag(level._effect["emp_flash"], self, "tag_origin");
}

// Namespace namespace_967f4af8
// Params 1, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_7dadf7b8
// Checksum 0x8ac5ca08, Offset: 0x22c0
// Size: 0x70
function emprumbleloop(duration) {
    self endon(#"emp_rumble_loop");
    self notify(#"emp_rumble_loop");
    goaltime = gettime() + duration * 1000;
    while (gettime() < goaltime) {
        self playrumbleonentity("damage_heavy");
        wait(0.05);
    }
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_5357a1e2
// Checksum 0x4ba2cb77, Offset: 0x2338
// Size: 0x64
function checktoturnoffemp() {
    if (isdefined(self)) {
        self.empgrenaded = 0;
        shutdownemprebootindicatormenu();
        self setempjammed(0);
        self clientfield::set_to_player("empd", 0);
    }
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_2498a3ca
// Checksum 0xc6abb6a6, Offset: 0x23a8
// Size: 0x54
function shutdownemprebootindicatormenu() {
    emprebootmenu = self getluimenu("EmpRebootIndicator");
    if (isdefined(emprebootmenu)) {
        self closeluimenu(emprebootmenu);
    }
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_4f725f0b
// Checksum 0xdb3edf2, Offset: 0x2408
// Size: 0x1c4
function function_4f725f0b() {
    self endon(#"disconnect");
    self enableinvulnerability();
    self.empduration = 7;
    self.empgrenaded = 1;
    self shellshock("emp_shock", 1);
    self clientfield::set_to_player("empd", 1);
    self.empstarttime = gettime();
    self.empendtime = self.empstarttime + self.empduration * 1000;
    emprebootmenu = self openluimenu("EmpRebootIndicator");
    self setluimenudata(emprebootmenu, "endTime", int(self.empendtime));
    self setluimenudata(emprebootmenu, "startTime", int(self.empstarttime));
    self thread emprumbleloop(0.75);
    self setempjammed(1);
    wait(7);
    if (isdefined(self)) {
        self notify(#"empgrenadetimedout");
        self checktoturnoffemp();
    }
    self disableinvulnerability();
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_408f0fb5
// Checksum 0x7806bd47, Offset: 0x25d8
// Size: 0x1fc
function function_408f0fb5() {
    level endon(#"hash_47f08523");
    level flag::wait_till("flag_player_start_drown sequence");
    level flag::wait_till("water_corvus_vo_cleared");
    foreach (p in level.activeplayers) {
        p thread function_4f725f0b();
    }
    setdvar("player_swimSpeed", 95);
    level notify(#"hash_781a429d");
    level thread namespace_1d1d22be::function_69386a6b();
    function_846f1215(0.5);
    level thread namespace_1d1d22be::function_decbd389();
    wait(2);
    setdvar("player_swimSpeed", 80);
    function_846f1215(0.65);
    level thread namespace_1d1d22be::function_4ce4df2();
    wait(2);
    setdvar("player_swimSpeed", 50);
    function_846f1215(0.8);
    level thread namespace_1d1d22be::function_2ad0c85b();
    wait(2);
    level flag::set("flag_kayne_water_moment");
}

// Namespace namespace_967f4af8
// Params 1, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_846f1215
// Checksum 0x43a32278, Offset: 0x27e0
// Size: 0xd2
function function_846f1215(n_alpha) {
    foreach (p in level.activeplayers) {
        p thread function_45676b91(n_alpha);
        p hazard::do_damage("o2", 20);
        p thread function_498a7d66();
    }
}

// Namespace namespace_967f4af8
// Params 1, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_45676b91
// Checksum 0x76bc628f, Offset: 0x28c0
// Size: 0x4c
function function_45676b91(n_alpha) {
    self endon(#"disconnect");
    self util::function_c04ace5b(n_alpha, 1);
    self util::function_c04ace5b(0, 1);
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_645f7873
// Checksum 0xab8698ac, Offset: 0x2918
// Size: 0x15c
function function_645f7873() {
    level endon(#"hash_47f08523");
    setdvar("player_swimSpeed", 95);
    wait(0.5);
    level thread namespace_1d1d22be::function_fc716128();
    thread function_c1808198();
    level dialog::remote("corv_listen_only_to_the_s_2", undefined, "corvus");
    wait(0.2);
    level thread namespace_1d1d22be::function_6e78d063();
    thread function_c1808198();
    level dialog::remote("corv_imagine_yourself_0", undefined, "corvus");
    wait(0.2);
    level thread namespace_1d1d22be::function_487655fa();
    thread function_c1808198();
    level dialog::remote("corv_in_a_frozen_fore_0", undefined, "corvus");
    level flag::set("water_corvus_vo_cleared");
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x0
// namespace_967f4af8<file_0>::function_ba41df77
// Checksum 0xbaeada78, Offset: 0x2a80
// Size: 0x6c
function function_ba41df77() {
    thread util::screen_fade_out(0.55, "white");
    wait(0.55);
    util::screen_fade_out(0, "white");
    util::screen_fade_in(0.55, "white");
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x0
// namespace_967f4af8<file_0>::function_e367262c
// Checksum 0x1855a16e, Offset: 0x2af8
// Size: 0x4c
function function_e367262c() {
    self hazard::function_459e5eff("o2", 0);
    self hazard::do_damage("o2", 50);
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_913d882
// Checksum 0xf685b4fa, Offset: 0x2b50
// Size: 0xb8
function function_913d882() {
    self endon(#"disconnect");
    self notify(#"hash_1fffa65c");
    self endon(#"death");
    self endon(#"hash_1fffa65c");
    while (true) {
        if (self.sessionstate == "playing" && isalive(self) && self isplayerunderwater() && !(isdefined(self.var_5ea9c8b7) && self.var_5ea9c8b7)) {
            self thread function_41018429();
        }
        wait(0.5);
    }
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_41018429
// Checksum 0xeafc9e38, Offset: 0x2c10
// Size: 0xe8
function function_41018429() {
    self notify(#"hash_8f1abd30");
    self endon(#"hash_8f1abd30");
    self endon(#"death");
    self.var_5ea9c8b7 = 1;
    self hazard::function_459e5eff("o2", 0);
    for (var_dd075cd2 = 1; self isplayerunderwater(); var_dd075cd2 = self hazard::do_damage("o2", 5)) {
        wait(1);
    }
    self hazard::function_459e5eff("o2", 1);
    self.var_5ea9c8b7 = 0;
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_a1923020
// Checksum 0x96f756ae, Offset: 0x2d00
// Size: 0x2c
function function_a1923020() {
    level waittill(#"hash_a57da79e");
    level flag::set("flag_door_explodes");
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_a1b52577
// Checksum 0x109b04e8, Offset: 0x2d38
// Size: 0x20c
function function_a1b52577() {
    thread function_a1923020();
    level flag::wait_till_all(array("flag_maretti_trap_door", "flag_kayne_ready_trap", "flag_door_explodes"));
    exploder::exploder("server_room_boobytrap");
    level thread namespace_1d1d22be::function_ceaeaa5a();
    var_5b8892d8 = getent("mdl_trapdoor", "targetname");
    var_5b8892d8 delete();
    level thread function_cb3decf1();
    thread function_a05b1c8c();
    level notify(#"hash_66250ae7");
    wait(2);
    level dialog::remote("khal_kane_do_you_read_me_0");
    level dialog::remote("khal_there_s_multiple_con_0");
    level.var_89ea8991 dialog::say("kane_taylor_and_maretti_0");
    level thread namespace_71a63eac::function_a2d40521();
    level dialog::remote("khal_kane_you_have_to_go_0");
    thread function_71af9864();
    level flag::set("water_room_checkpoint");
    level.var_89ea8991 colors::set_force_color("r");
    trigger::use("breadcrumb_exit_water", "targetname");
    savegame::checkpoint_save();
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_71af9864
// Checksum 0x85d9812c, Offset: 0x2f50
// Size: 0xf4
function function_71af9864() {
    spawn_manager::enable("spawn_manager_flood_robots");
    spawn_manager::enable("spawn_manager_water_robots");
    spawn_manager::enable("spawn_manager_flood_robots2");
    wait(2);
    struct = getent("igc_kane_water", "targetname");
    struct thread scene::play("cin_aqu_03_21_server_room_doors_open");
    level thread namespace_1d1d22be::function_ed6114d2();
    var_31b9fd4a = getent("doubledoor_sbm", "targetname");
    var_31b9fd4a delete();
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_b563cc38
// Checksum 0xfc1543f5, Offset: 0x3050
// Size: 0x3c
function function_b563cc38() {
    spawner::waittill_ai_group_cleared("interior_robots_stairs");
    level flag::set("flag_kane_start_water_escape");
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_18af354a
// Checksum 0x222f3b2e, Offset: 0x3098
// Size: 0x10c
function function_18af354a() {
    level flag::wait_till("flag_kane_start_water_escape");
    exploder::exploder("lighting_water_exit");
    foreach (p in level.players) {
        p thread function_913d882();
    }
    level.var_89ea8991 ai::set_ignoreme(1);
    level.var_89ea8991 thread function_8fdcc95b(5);
    thread function_67c72b6();
}

// Namespace namespace_967f4af8
// Params 1, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_8fdcc95b
// Checksum 0xf6dd97dd, Offset: 0x31b0
// Size: 0x5c
function function_8fdcc95b(delay) {
    if (isdefined(delay)) {
        wait(delay);
    }
    self fx::play("bubbles", self.origin, (0, 0, 0), "swim_done", 1, "j_spineupper", 1);
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_67c72b6
// Checksum 0x7dfc2cef, Offset: 0x3218
// Size: 0x104
function function_67c72b6() {
    level endon(#"hash_bf1c950c");
    struct = getent("igc_kane_water", "targetname");
    struct scene::play("cin_aqu_03_22_water_room_escape_start", level.var_89ea8991);
    struct thread scene::play("cin_aqu_03_22_water_room_escape_fire_loop", level.var_89ea8991);
    spawner::waittill_ai_group_cleared("interior_robots_water");
    level.var_89ea8991 stopanimscripted();
    struct scene::play("cin_aqu_03_22_water_room_escape_end", level.var_89ea8991);
    struct scene::play("cin_aqu_03_22_water_room_escape_end_loop", level.var_89ea8991);
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_cb3decf1
// Checksum 0x53ced520, Offset: 0x3328
// Size: 0x1aa
function function_cb3decf1() {
    var_e9dd177b = getent("trig_trap_door", "targetname");
    var_568fff7e = getent("inner_explosion_area", "targetname");
    foreach (player in level.activeplayers) {
        if (player istouching(var_e9dd177b)) {
            if (player istouching(var_568fff7e)) {
                player thread function_a476832a(0.5, 4);
                earthquake(0.7, 1.2, player.origin, 1000);
            } else {
                earthquake(0.6, 1, player.origin, 800);
            }
            player playrumbleonentity("damage_heavy");
        }
    }
}

// Namespace namespace_967f4af8
// Params 2, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_a476832a
// Checksum 0xc597b4af, Offset: 0x34e0
// Size: 0x3c
function function_a476832a(delay, duration) {
    wait(delay);
    self shellshock("proximity_grenade", duration);
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_a05b1c8c
// Checksum 0xb679127c, Offset: 0x3528
// Size: 0x2c2
function function_a05b1c8c() {
    closest = level.activeplayers[0];
    var_e34a3797 = [];
    var_52aa09ce = getent("look_at_kane_origin", "targetname");
    var_be38fd90 = getent("door_trap_origin", "targetname");
    foreach (player in level.activeplayers) {
        if (distance(player.origin, var_be38fd90.origin) < -81) {
            array::add(var_e34a3797, player);
        }
    }
    if (var_e34a3797.size < 1) {
        foreach (player in level.activeplayers) {
            if (distance(player.origin, var_be38fd90.origin) < distance(closest.origin, var_be38fd90.origin)) {
                closest = player;
            }
        }
        array::add(var_e34a3797, closest);
    }
    foreach (player in var_e34a3797) {
        thread function_a0faf694(player, var_52aa09ce, var_be38fd90);
    }
}

// Namespace namespace_967f4af8
// Params 3, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_a0faf694
// Checksum 0xeb54c5da, Offset: 0x37f8
// Size: 0x25c
function function_a0faf694(var_4b70f64, var_52aa09ce, var_be38fd90) {
    rotator = spawn("script_origin", var_4b70f64.origin);
    rotator.angles = var_4b70f64 getplayerangles();
    var_4b70f64 playerlinkto(rotator, undefined, 1, 0, 0, 0, 0);
    player_eye = var_4b70f64 geteye();
    if (distance(var_4b70f64.origin, var_be38fd90.origin) < -81) {
        if (var_4b70f64.origin[1] < var_be38fd90.origin[1]) {
            rotator moveto(rotator.origin + (0, 40, 0), 0.3, 0.15, 0.15);
        }
        rotator rotateto(vectortoangles(var_52aa09ce.origin - var_4b70f64.origin), 0.7, 0.3, 0.3);
    } else {
        rotator rotateto(vectortoangles(var_52aa09ce.origin - player_eye), 0.7, 0.3, 0.3);
    }
    rotator waittill(#"rotatedone");
    var_4b70f64 unlink();
    rotator delete();
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_a527e6f9
// Checksum 0xd0a3853d, Offset: 0x3a60
// Size: 0x94
function function_a527e6f9() {
    self.script_accuracy = 0.3;
    self.health = 100;
    self.skipdeath = 1;
    self asmsetanimationrate(0.7);
    self clientfield::set("robot_bubbles_fx", 1);
    self waittill(#"death");
    if (isdefined(self)) {
        self startragdoll();
    }
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x0
// namespace_967f4af8<file_0>::function_3b4d25aa
// Checksum 0x4c4b12b5, Offset: 0x3b00
// Size: 0x6c
function function_3b4d25aa() {
    self ai::set_behavior_attribute("rogue_control_speed", "sprint");
    self ai::set_behavior_attribute("rogue_control", "forced_level_2");
    self ai::set_ignoreme(1);
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_3ed240f1
// Checksum 0x8a9e5d29, Offset: 0x3b78
// Size: 0x24
function function_3ed240f1() {
    level.var_75756ef4 = 0;
    thread function_8492aced();
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x1 linked
// namespace_967f4af8<file_0>::function_8492aced
// Checksum 0x66287dad, Offset: 0x3ba8
// Size: 0x14c
function function_8492aced() {
    level waittill(#"hash_43565802");
    lui::screen_fade_out(0, "black");
    wait(0.25);
    level waittill(#"hash_f26c95d0");
    lui::screen_fade_in(1, "black");
    level waittill(#"hash_43565802");
    lui::screen_fade_out(0.5, "black");
    level waittill(#"hash_f26c95d0");
    util::screen_fade_out(0, "black");
    level thread util::screen_fade_in(1, "black");
    level waittill(#"hash_43565802");
    lui::screen_fade_out(0.5, "black");
    level waittill(#"hash_f26c95d0");
    util::screen_fade_out(0, "black");
    level thread util::screen_fade_in(1, "black");
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x0
// namespace_967f4af8<file_0>::function_c67c64fe
// Checksum 0xbbad9b36, Offset: 0x3d00
// Size: 0x60
function function_c67c64fe() {
    level endon(#"hash_8f79547f");
    while (true) {
        level waittill(#"hash_f26c95d0");
        if (level.var_75756ef4 == 1) {
            level.var_75756ef4 = 0;
            thread lui::screen_fade_in(0.5);
        }
    }
}

// Namespace namespace_967f4af8
// Params 0, eflags: 0x0
// namespace_967f4af8<file_0>::function_e787e359
// Checksum 0x7a5ec2c1, Offset: 0x3d68
// Size: 0x60
function fade_to_black() {
    level endon(#"hash_8f79547f");
    while (true) {
        level waittill(#"hash_43565802");
        if (level.var_75756ef4 == 0) {
            level.var_75756ef4 = 1;
            thread lui::screen_fade_out(0.5);
        }
    }
}

