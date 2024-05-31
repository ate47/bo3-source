#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/cp/cp_mi_sing_blackstation_sound;
#using scripts/cp/cp_mi_sing_blackstation_utility;
#using scripts/cp/cp_mi_sing_blackstation_port;
#using scripts/cp/cp_mi_sing_blackstation_accolades;
#using scripts/cp/cp_mi_sing_blackstation;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/player_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/coop;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/codescripts/struct;

#namespace namespace_d754dd61;

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_d290ebfa
// Checksum 0x4f9717a6, Offset: 0x1298
// Size: 0x1c
function main() {
    level thread function_d3f417df();
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_fec14fdd
// Checksum 0x6b12c054, Offset: 0x12c0
// Size: 0x164
function function_fec14fdd() {
    level scene::add_scene_func("cin_bla_01_01_intro_1st", &function_1ab4414c, "play");
    level scene::add_scene_func("cin_bla_01_01_intro_1st", &function_b1896f5, "players_done");
    level scene::add_scene_func("cin_bla_01_01_intro_1st", &function_72332b44, "skip_completed");
    load::function_c32ba481();
    util::function_46d3a558(%CP_MI_SING_BLACKSTATION_INTRO_LINE_1_FULL, %CP_MI_SING_BLACKSTATION_INTRO_LINE_1_SHORT, %CP_MI_SING_BLACKSTATION_INTRO_LINE_2_FULL, %CP_MI_SING_BLACKSTATION_INTRO_LINE_2_SHORT, %CP_MI_SING_BLACKSTATION_INTRO_LINE_3_FULL, %CP_MI_SING_BLACKSTATION_INTRO_LINE_3_SHORT, %CP_MI_SING_BLACKSTATION_INTRO_LINE_4_FULL, %CP_MI_SING_BLACKSTATION_INTRO_LINE_4_SHORT, "", "", 12);
    if (isdefined(level.var_fce615e8)) {
        level thread [[ level.var_fce615e8 ]]();
    }
    level thread scene::play("cin_bla_01_01_intro_1st");
    level lui::screen_fade_out(0);
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_5c4b60ce
// Checksum 0x66ead30f, Offset: 0x1430
// Size: 0xf4
function function_5c4b60ce() {
    a_e_lights = getentarray("vtol_lights", "targetname");
    foreach (light in a_e_lights) {
        light linkto(self);
        light thread function_5a717a52();
    }
    self attach("veh_t7_mil_vtol_egypt_cabin_details_attch", "tag_body_animate");
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_5a717a52
// Checksum 0xaeade46c, Offset: 0x1530
// Size: 0x2c
function function_5a717a52() {
    level waittill(#"hash_4425647e");
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_d754dd61
// Params 1, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_1ab4414c
// Checksum 0x23d96239, Offset: 0x1568
// Size: 0x24a
function function_1ab4414c(a_ents) {
    level scene::add_scene_ordered_notetrack("intro_qzone", "notetrack_catch");
    level scene::add_scene_ordered_notetrack("intro_qzone", "notetrack_start_rain");
    level scene::add_scene_ordered_notetrack("intro_qzone", "notetrack_fall");
    level scene::add_scene_ordered_notetrack("intro_qzone", "notetrack_land");
    level scene::add_scene_ordered_notetrack("intro_qzone", "intro_done");
    level thread function_d9d7be12();
    level thread function_bc49a6ce();
    level thread function_202f6b4c();
    level thread function_211d4422();
    level thread function_2365861b();
    level thread function_cc9e7b72();
    level thread function_13820fbf();
    if (!isdefined(level.var_25647ecb)) {
        level.var_25647ecb = spawn("script_origin", (0, 0, 0));
    }
    foreach (player in level.activeplayers) {
        player switchtoweapon(getweapon("micromissile_launcher"));
    }
}

// Namespace namespace_d754dd61
// Params 1, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_b1896f5
// Checksum 0xd7c675e7, Offset: 0x17c0
// Size: 0x2c
function function_b1896f5(a_ents) {
    level util::function_93831e79("qzone_teleport_pos");
}

// Namespace namespace_d754dd61
// Params 1, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_72332b44
// Checksum 0xc1ceaf08, Offset: 0x17f8
// Size: 0xd4
function function_72332b44(a_ents) {
    util::screen_fade_out(0, "black", "hide_qzone_stream");
    level util::function_7d553ac6();
    level thread function_6c7970a2();
    level util::waittill_notify_or_timeout("qzone_streamer_read", 5);
    level notify(#"hash_7769e801");
    util::screen_fade_in(0.5, "black", "hide_qzone_stream");
    level util::function_f7beb173();
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_6c7970a2
// Checksum 0x20b35d63, Offset: 0x18d8
// Size: 0x32
function function_6c7970a2() {
    level endon(#"hash_7769e801");
    level util::streamer_wait();
    level notify(#"hash_7769e801");
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_d9d7be12
// Checksum 0x19708466, Offset: 0x1918
// Size: 0x2c
function function_d9d7be12() {
    level waittill(#"hash_e99b0752");
    level lui::screen_fade_in(3);
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_bc49a6ce
// Checksum 0xf55a4d5d, Offset: 0x1950
// Size: 0xba
function function_bc49a6ce() {
    level waittill(#"hash_a525e1f7");
    playsoundatposition("evt_player_catch_weapon", (0, 0, 0));
    foreach (player in level.activeplayers) {
        player playrumbleonentity("cp_blackstation_intro_weapon_catch");
    }
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_202f6b4c
// Checksum 0xafda8e4b, Offset: 0x1a18
// Size: 0xba
function function_202f6b4c() {
    level waittill(#"hash_8eb6a1cf");
    foreach (player in level.activeplayers) {
        player thread namespace_79e1cd97::function_6778ea09("light_se");
        player clientfield::set_to_player("toggle_rain_sprite", 1);
    }
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_211d4422
// Checksum 0x9676383d, Offset: 0x1ae0
// Size: 0xda
function function_211d4422() {
    level waittill(#"hash_fb0df4bd");
    level.var_25647ecb stoploopsound(1);
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("wind_blur", 1);
        player clientfield::set_to_player("wind_effects", 1);
    }
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_2365861b
// Checksum 0xd70fd456, Offset: 0x1bc8
// Size: 0x11c
function function_2365861b() {
    level waittill(#"hash_773822d9");
    foreach (player in level.activeplayers) {
        player playrumbleonentity("cp_blackstation_vtol_land_rumble");
        player clientfield::set_to_player("wind_blur", 0);
        player clientfield::set_to_player("wind_effects", 0);
    }
    wait(1);
    level thread namespace_79e1cd97::function_6778ea09("med_se");
    wait(2);
    clientfield::increment("qzone_debris");
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_cc9e7b72
// Checksum 0xeb499ed6, Offset: 0x1cf0
// Size: 0xfc
function function_cc9e7b72() {
    level waittill(#"hash_a5a4d60b");
    util::function_93831e79("objective_qzone");
    level flag::set("vtol_jump");
    foreach (player in level.activeplayers) {
        player thread namespace_79e1cd97::function_6778ea09("light_se");
    }
    streamerrequest("set", "cp_mi_sing_blackstation_objective_warlord_igc");
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_f197a118
// Checksum 0xc07d2098, Offset: 0x1df8
// Size: 0x54
function function_f197a118() {
    level flag::wait_till("vtol_jump");
    trigger::use("trigger_hendricks_start");
    level function_8c1c268a();
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_8c1c268a
// Checksum 0x1533f3da, Offset: 0x1e58
// Size: 0x128
function function_8c1c268a() {
    level.var_2fd26037 thread namespace_79e1cd97::function_ba29155a();
    level flag::wait_till("flag_hendricks_bodies");
    level.var_2fd26037 notify(#"hash_a2ba32d");
    level scene::add_scene_func("cin_bla_02_03_qzone_vign_executed_hendricks", &function_a2790c98);
    level scene::play("cin_bla_02_03_qzone_vign_executed_hendricks");
    if (!level flag::get("past_school")) {
        trigger::use("trigger_hendricks_street");
    }
    wait(1);
    level.var_2fd26037 thread namespace_79e1cd97::function_ba29155a();
    level flag::wait_till("warlord_intro_prep");
    level.var_2fd26037 notify(#"hash_a2ba32d");
}

// Namespace namespace_d754dd61
// Params 1, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_a2790c98
// Checksum 0x267945c2, Offset: 0x1f88
// Size: 0x4c
function function_a2790c98(a_ents) {
    level dialog::function_13b3b16a("plyr_why_would_the_immort_0", 5);
    level flag::set("executed_bodies");
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_d3f417df
// Checksum 0xca416a37, Offset: 0x1fe0
// Size: 0x154
function function_d3f417df() {
    level flag::wait_till("warlord_move_to_volume");
    trigger::use("triggercolor_b6_warlord_fallback");
    level flag::wait_till("hendricks_moveup");
    trigger::use("triggercolor_mid_qzone");
    level flag::wait_till("warlord_backup");
    trigger::use("triggercolor_hendricks_advance");
    level flag::wait_till("warlord_retreat");
    trigger::use("triggercolor_b7_debriswall_approach");
    level flag::wait_till("qzone_done");
    level thread namespace_4297372::function_973b77f9();
    level.var_2fd26037 thread dialog::say("hend_the_superstorm_s_win_0");
    level thread namespace_79e1cd97::function_d1dc735f();
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_4a444ed5
// Checksum 0xa6d864e8, Offset: 0x2140
// Size: 0x14c
function function_4a444ed5() {
    trigger::wait_till("trigger_hendricks_warlord");
    level flag::set("warlord_approach");
    if (isdefined(level.e_speaker)) {
        level.e_speaker stopsounds();
        wait(0.5);
        if (isdefined(level.e_speaker)) {
            level.e_speaker delete();
        }
        foreach (player in level.activeplayers) {
            player luinotifyevent(%offsite_comms_complete);
        }
    }
    level.var_2fd26037 dialog::say("hend_activity_ahead_sta_0", 0.5);
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_58ded41f
// Checksum 0x6682c4df, Offset: 0x2298
// Size: 0xcc
function function_58ded41f() {
    level waittill(#"hash_998c624d");
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 1);
    var_974cc07 = getnode("cover_warlord_engage", "targetname");
    level.var_2fd26037 setgoal(var_974cc07, 1);
    level.var_2fd26037 waittill(#"goal");
    level.var_2fd26037 clearforcedgoal();
    level.var_2fd26037 ai::set_behavior_attribute("cqb", 0);
}

// Namespace namespace_d754dd61
// Params 1, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_c37c7032
// Checksum 0xec81a810, Offset: 0x2370
// Size: 0x34c
function function_c37c7032(var_74cd64bc) {
    level.var_d8ffea14 = getnodearray("china_town_warlord_preferred_goal", "targetname");
    spawner::add_spawn_function_group("warlordintro_warlord", "targetname", &function_b287e148);
    if (!var_74cd64bc) {
        trigger::wait_till("trigger_warlord_igc");
    }
    foreach (player in level.activeplayers) {
        player.w_current = player getcurrentweapon();
        player player::switch_to_primary_weapon(1);
    }
    level flag::set("warlord_intro_prep");
    level.var_2fd26037 notify(#"hash_a2ba32d");
    level.var_2fd26037 ai::set_ignoreall(1);
    level thread namespace_4297372::function_4f531ae2();
    level scene::add_scene_func("cin_bla_03_warlordintro_3rd_sh010", &function_a80d0dfb, "play");
    level scene::add_scene_func("cin_bla_03_warlordintro_3rd_sh150", &function_bf6f9b2f, "play");
    level scene::add_scene_func("cin_bla_03_warlordintro_3rd_sh160", &function_d916bcc0, "done");
    level scene::add_scene_func("cin_bla_03_warlordintro_3rd_sh170", &function_26c954d8, "done");
    level scene::add_scene_func("cin_bla_03_warlordintro_3rd_sh170_hendricks", &function_ec2528a6, "play");
    if (isdefined(level.var_90895ee2)) {
        level thread [[ level.var_90895ee2 ]]();
    }
    level scene::play("cin_bla_03_warlordintro_3rd_sh010");
    level thread objectives::breadcrumb("anchor_intro_breadcrumb", "cp_level_blackstation_climb");
    level thread namespace_8b9f718f::function_109329ae();
    level flag::wait_till("warlord_fight");
    level thread namespace_4297372::function_fa2e45b8();
    level thread function_1db3da90();
}

// Namespace namespace_d754dd61
// Params 1, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_a80d0dfb
// Checksum 0xca1bf078, Offset: 0x26c8
// Size: 0x124
function function_a80d0dfb(a_ents) {
    level clientfield::set("warlord_exposure", 1);
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("toggle_rain_sprite", 0);
        player thread function_d4e7d4e4();
        player thread namespace_79e1cd97::function_6778ea09("none");
    }
    level flag::wait_till("warlord_fight");
    wait(8);
    savegame::checkpoint_save();
}

// Namespace namespace_d754dd61
// Params 1, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_d916bcc0
// Checksum 0xf1169c86, Offset: 0x27f8
// Size: 0x4c
function function_d916bcc0(a_ents) {
    level thread scene::play("cin_bla_03_warlordintro_3rd_sh170_hendricks");
    level thread scene::play("cin_bla_03_warlordintro_3rd_sh170_civs");
}

// Namespace namespace_d754dd61
// Params 1, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_26c954d8
// Checksum 0x968367b2, Offset: 0x2850
// Size: 0xfa
function function_26c954d8(a_ents) {
    level clientfield::set("warlord_exposure", 0);
    level flag::set("warlord_fight");
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("toggle_rain_sprite", 1);
        player thread namespace_79e1cd97::function_6778ea09("light_se");
    }
}

// Namespace namespace_d754dd61
// Params 1, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_ec2528a6
// Checksum 0xdf0c5b75, Offset: 0x2958
// Size: 0xd2
function function_ec2528a6(a_ents) {
    level.var_2fd26037 ai::set_ignoreall(0);
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("toggle_rain_sprite", 1);
        player switchtoweapon(player.w_current);
    }
}

// Namespace namespace_d754dd61
// Params 1, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_bf6f9b2f
// Checksum 0xcddcc07a, Offset: 0x2a38
// Size: 0xdc
function function_bf6f9b2f(a_ents) {
    level waittill(#"hash_7f71b7e6");
    var_837033c1 = a_ents["warlordintro_civilian_female"];
    var_16095f82 = a_ents["warlordintro_civilian"];
    if (isdefined(var_837033c1)) {
        var_837033c1 attach("c_civ_sing_female_wife_behead");
        var_837033c1 detach("c_civ_sing_female_wife_head");
    }
    if (isdefined(var_16095f82)) {
        var_16095f82 attach("c_civ_sing_male_husband_behead");
        var_16095f82 detach("c_civ_sing_male_husband_head");
    }
}

// Namespace namespace_d754dd61
// Params 1, eflags: 0x0
// namespace_d754dd61<file_0>::function_b5eea60c
// Checksum 0xccc84d2d, Offset: 0x2b20
// Size: 0xd4
function function_b5eea60c(a_ents) {
    var_837033c1 = a_ents["warlordintro_civilian_female"];
    var_16095f82 = a_ents["warlordintro_civilian"];
    if (isdefined(var_837033c1)) {
        var_837033c1 attach("c_civ_sing_female_wife_behead");
        var_837033c1 detach("c_civ_sing_female_wife_head");
    }
    if (isdefined(var_16095f82)) {
        var_16095f82 attach("c_civ_sing_male_husband_behead");
        var_16095f82 detach("c_civ_sing_male_husband_head");
    }
}

// Namespace namespace_d754dd61
// Params 1, eflags: 0x0
// namespace_d754dd61<file_0>::function_1dc7c14c
// Checksum 0x4882aa99, Offset: 0x2c00
// Size: 0xd4
function function_1dc7c14c(a_ents) {
    var_837033c1 = a_ents["warlordintro_civilian_female"];
    var_16095f82 = a_ents["warlordintro_civilian"];
    if (isdefined(var_837033c1)) {
        var_837033c1 attach("c_civ_sing_female_wife_behead");
        var_837033c1 detach("c_civ_sing_female_wife_head");
    }
    if (isdefined(var_16095f82)) {
        var_16095f82 attach("c_civ_sing_male_husband_behead");
        var_16095f82 detach("c_civ_sing_male_husband_head");
    }
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_d4e7d4e4
// Checksum 0x72218e25, Offset: 0x2ce0
// Size: 0x5c
function function_d4e7d4e4() {
    self endon(#"death");
    self enableinvulnerability();
    level flag::wait_till("warlord_fight");
    wait(6);
    self disableinvulnerability();
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_5d3711fa
// Checksum 0xc0a7cc20, Offset: 0x2d48
// Size: 0x6c
function function_5d3711fa() {
    self waittill(#"death");
    wait(1);
    level flag::set("warlord_backup");
    level flag::set("warlord_retreat");
    self namespace_69ee7109::function_94b1213d();
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x0
// namespace_d754dd61<file_0>::function_55e47c3e
// Checksum 0x23cd9664, Offset: 0x2dc0
// Size: 0x48
function function_55e47c3e() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self.goalradius = 1;
}

// Namespace namespace_d754dd61
// Params 1, eflags: 0x0
// namespace_d754dd61<file_0>::function_62364f6c
// Checksum 0xe8fe93de, Offset: 0x2e10
// Size: 0x17c
function function_62364f6c(var_66d4a87c) {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self util::magic_bullet_shield();
    if (isdefined(var_66d4a87c)) {
        nd_start = getnode(self.script_noteworthy, "targetname");
        self.var_2c3a4ffd = spawn("script_origin", self.origin);
        self linkto(self.var_2c3a4ffd);
        self.var_2c3a4ffd moveto(nd_start.origin, 3);
        self.var_2c3a4ffd waittill(#"movedone");
    }
    level flag::wait_till("warlord_fight");
    self unlink();
    if (isdefined(self.var_2c3a4ffd)) {
        self.var_2c3a4ffd delete();
    }
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x0
// namespace_d754dd61<file_0>::function_284a57a6
// Checksum 0xd3b28d21, Offset: 0x2f98
// Size: 0x54
function function_284a57a6() {
    self endon(#"death");
    self waittill(#"goal");
    wait(randomfloatrange(0.5, 1.5));
    self clearforcedgoal();
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_b287e148
// Checksum 0x7b8f805e, Offset: 0x2ff8
// Size: 0x1c4
function function_b287e148() {
    self endon(#"death");
    self setthreatbiasgroup("warlords");
    setthreatbias("heroes", "warlords", -1000);
    self thread function_b48ee8e();
    self.goalheight = 512;
    foreach (node in level.var_d8ffea14) {
        self namespace_69ee7109::function_da308a83(node.origin, 4000, 8000);
    }
    e_volume = getent("vol_qzone_warlord", "targetname");
    self setgoal(e_volume);
    level flag::wait_till("warlord_retreat");
    e_vol = getent("vol_fallback_warlord", "targetname");
    self setgoal(e_vol);
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_b48ee8e
// Checksum 0x9ff9da0c, Offset: 0x31c8
// Size: 0x140
function function_b48ee8e() {
    self endon(#"death");
    self thread function_5e294934();
    n_counter = 0;
    a_str_vo = [];
    a_str_vo[0] = "hend_grenades_ain_t_gonna_0";
    a_str_vo[1] = "hend_explosives_ain_t_doi_0";
    var_77987920 = [];
    var_77987920[0] = "plyr_i_hear_you_1";
    for (var_b3d77f58 = 0; !var_b3d77f58; var_b3d77f58 = 1) {
        self util::waittill_any("projectile_applyattractor", "play_meleefx");
        level.var_2fd26037 dialog::say(a_str_vo[n_counter], 0.5);
        if (!n_counter) {
            level dialog::function_13b3b16a(var_77987920[n_counter], 0.5);
        }
        n_counter++;
        if (n_counter == a_str_vo.size) {
        }
    }
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_5e294934
// Checksum 0x1d05b9d4, Offset: 0x3310
// Size: 0x5c
function function_5e294934() {
    self endon(#"death");
    wait(40);
    level.var_2fd26037 dialog::say("hend_come_on_take_that_0");
    level dialog::function_13b3b16a("plyr_i_m_on_it_1", 0.5);
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_d6aa8860
// Checksum 0xcf559c9f, Offset: 0x3378
// Size: 0x244
function function_d6aa8860() {
    level flag::wait_till("warlord_fight");
    var_45900c37 = vehicle::simple_spawn_single("truck_warlord");
    var_45900c37 vehicle::lights_off();
    var_45900c37 util::magic_bullet_shield();
    var_45900c37 thread namespace_79e1cd97::function_c262adca();
    var_45900c37 playsound("evt_tech_driveup_1");
    var_45900c37 turret::disable_ai_getoff(1, 1);
    var_45900c37 turret::enable(1, 1);
    var_45900c37 turret::disable_ai_getoff(1, 0);
    level scene::init("p7_fxanim_blackstation_warlord_intro_truck_bundle", var_45900c37);
    level thread function_e20bd5ba(3, "warlord_backup");
    wait(5);
    var_45900c37 namespace_79e1cd97::function_fae23684("passenger1");
    var_45900c37 playsound("evt_tech_driveup_2");
    level scene::play("p7_fxanim_blackstation_warlord_intro_truck_bundle", var_45900c37);
    wait(1);
    var_45900c37 thread namespace_79e1cd97::function_fae23684("driver");
    var_45900c37 thread namespace_79e1cd97::function_d01267bd(level.players.size - 1, 2, "warlord_fight_done");
    var_45900c37 util::stop_magic_bullet_shield();
    var_45900c37 makevehicleusable();
    var_45900c37 setseatoccupied(0);
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_6e4c2eec
// Checksum 0xc5cce4a3, Offset: 0x35c8
// Size: 0xa4
function function_6e4c2eec() {
    trigger::wait_till("trigger_warlord_backup");
    level flag::set("warlord_backup");
    level thread function_9986fb74();
    level thread function_8a27424();
    trigger::wait_till("trigger_warlord_reinforce");
    level flag::set("warlord_reinforce");
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_ed2f4785
// Checksum 0xde164a25, Offset: 0x3678
// Size: 0x1e4
function function_ed2f4785() {
    level flag::wait_till("warlord_backup");
    spawn_manager::enable("sm_warlord_launchers");
    util::wait_network_frame();
    spawner::simple_spawn("warlord_backup_point");
    wait(2);
    spawner::simple_spawn("warlord_backup");
    util::wait_network_frame();
    spawn_manager::enable("sm_warlord_support");
    if (level.players.size == 4) {
        util::wait_network_frame();
        spawner::simple_spawn_single("warlord_partner", &function_b287e148);
    }
    level thread function_5cbefffa();
    level flag::wait_till("warlord_reinforce");
    spawner::add_spawn_function_group("warlord_reinforce", "targetname", &function_2551879c);
    spawn_manager::enable("sm_warlord_reinforce");
    spawn_manager::wait_till_complete("sm_warlord_reinforce");
    level thread function_e20bd5ba(3, "warlord_retreat");
    level thread function_5b06f894();
    level thread function_43439f74();
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_2551879c
// Checksum 0x599c57f7, Offset: 0x3868
// Size: 0x98
function function_2551879c() {
    self ai::set_behavior_attribute("sprint", 1);
    self ai::set_ignoreall(1);
    self.goalradius = 4;
    self waittill(#"goal");
    self ai::set_behavior_attribute("sprint", 0);
    self ai::set_ignoreall(0);
    self.goalradius = 2048;
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_5cbefffa
// Checksum 0x7e3a534c, Offset: 0x3908
// Size: 0x44
function function_5cbefffa() {
    spawner::waittill_ai_group_count("group_warlord_backup", 3);
    level flag::set("warlord_reinforce");
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_43439f74
// Checksum 0x886b7408, Offset: 0x3958
// Size: 0x182
function function_43439f74() {
    while (true) {
        a_ai_enemies = getaiteamarray("axis");
        if (a_ai_enemies.size < 4) {
            break;
        }
        wait(1);
    }
    a_ai_enemies = getaiteamarray("axis");
    foreach (ai_enemy in a_ai_enemies) {
        if (isalive(ai_enemy)) {
            if (ai_enemy.archetype != "warlord" && ai_enemy.targetname !== "warlord_launcher_ai" && level.activeplayers.size) {
                e_player = level.activeplayers[randomint(level.activeplayers.size)];
                ai_enemy setgoal(e_player, 1);
            }
        }
    }
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_5b06f894
// Checksum 0x778f84b6, Offset: 0x3ae8
// Size: 0xdc
function function_5b06f894() {
    level endon(#"hash_e2a9cc43");
    while (getaiteamarray("axis").size) {
        wait(0.5);
    }
    level thread namespace_4297372::function_973b77f9();
    wait(1);
    level.var_2fd26037 dialog::say("hend_all_clear_2");
    level dialog::function_13b3b16a("plyr_that_was_one_tough_s_0", 1);
    level.var_2fd26037 dialog::say("hend_i_wouldn_t_doubt_it_0", 0.5);
    level flag::set("qzone_done");
}

// Namespace namespace_d754dd61
// Params 2, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_e20bd5ba
// Checksum 0xa296a39, Offset: 0x3bd0
// Size: 0x54
function function_e20bd5ba(var_9605ac0b, str_flag) {
    while (getaicount() > var_9605ac0b + 1) {
        wait(1);
    }
    level flag::set(str_flag);
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_8a27424
// Checksum 0xe34f37e6, Offset: 0x3c30
// Size: 0x3c
function function_8a27424() {
    level flag::wait_till("warlord_retreat");
    trigger::use("triggercolor_warlord_fallback");
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_9986fb74
// Checksum 0xeb91e986, Offset: 0x3c78
// Size: 0x50
function function_9986fb74() {
    level endon(#"hash_4df70616");
    while (true) {
        level namespace_79e1cd97::function_59c54810();
        wait(randomfloatrange(3.5, 5.5));
    }
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_1db3da90
// Checksum 0x21b40c65, Offset: 0x3cd0
// Size: 0xb2
function function_1db3da90() {
    level thread scene::play("p7_fxanim_cp_blackstation_shelter_wind_gust_bundle");
    foreach (player in level.activeplayers) {
        player playrumbleonentity("cp_blackstation_shelter_rumble");
    }
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_ec18f079
// Checksum 0x72bef0e6, Offset: 0x3d90
// Size: 0xf4
function function_ec18f079() {
    self endon(#"death");
    while (!level flag::get("warlord_intro_prep")) {
        trigger::wait_till("trigger_qzone_lowready", "targetname", self);
        self util::function_16c71b8(0);
        while (self istouching(getent("trigger_qzone_lowready", "targetname"))) {
            wait(1);
        }
        self util::function_16c71b8(1);
        self thread function_7072c5d8();
    }
    self util::function_16c71b8(0);
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_7072c5d8
// Checksum 0x1d134397, Offset: 0x3e90
// Size: 0xc0
function function_7072c5d8() {
    self notify(#"hash_ca4d6265");
    self endon(#"hash_ca4d6265");
    self endon(#"death");
    level endon(#"hash_37a7f1b3");
    while (true) {
        self waittill(#"player_revived");
        if (level flag::get("warlord_intro_prep")) {
            break;
        }
        if (!self istouching(getent("trigger_qzone_lowready", "targetname"))) {
            self util::function_16c71b8(1);
        }
    }
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_69df1ce
// Checksum 0x9fbb5a8a, Offset: 0x3f58
// Size: 0x14c
function function_69df1ce() {
    level flag::wait_till("warlord_fight");
    level.var_2fd26037 dialog::say("hend_gotta_get_to_cover_0", 1);
    level.var_2fd26037 dialog::say("hend_heads_up_we_got_a_t_0", 1);
    level flag::wait_till("warlord_backup");
    if (level.players.size > 2) {
        level.var_2fd26037 dialog::say("hend_rpg_up_high_0", 4);
    } else {
        level.var_2fd26037 dialog::say("hend_hostiles_in_the_buil_0", 4);
    }
    level.var_2fd26037 dialog::say("hend_clear_em_out_doub_0", 4);
    level.var_2fd26037 dialog::say("hend_hit_him_with_the_mic_0", 1);
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_e41dbcaa
// Checksum 0xafc58e31, Offset: 0x40b0
// Size: 0xe4
function function_e41dbcaa() {
    level flag::wait_till("vtol_jump");
    level thread namespace_4297372::function_240ac8fa();
    level.var_2fd26037 dialog::say("hend_kane_we_re_on_grou_0");
    level dialog::remote("kane_copy_that_hendricks_0", 0.5);
    wait(1);
    level flag::set("obj_goto_docks");
    trigger::wait_till("trigger_hendricks_interact");
    playsoundatposition("evt_qzone_warlord_walla", (8795, 3873, -10));
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_251d954
// Checksum 0xe302a0fa, Offset: 0x41a0
// Size: 0xac
function function_251d954() {
    level endon(#"hash_f2e469a3");
    level flag::wait_till("executed_bodies");
    wait(2.5);
    if (!level flag::get("warlord_approach")) {
        level dialog::remote("kane_if_sensitive_materia_0", 0, "dni", undefined, 1);
        wait(0.5);
        level.var_2fd26037 dialog::say("hend_understood_we_re_o_0");
    }
}

// Namespace namespace_d754dd61
// Params 2, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_6ec9ed4d
// Checksum 0x7e29f993, Offset: 0x4258
// Size: 0x17c
function function_6ec9ed4d(str_objective, var_74cd64bc) {
    load::function_73adcefc();
    namespace_79e1cd97::function_bff1a867("objective_igc");
    vehicle::add_spawn_function("vtol_intro", &function_5c4b60ce);
    var_edc6e0e1 = vehicle::simple_spawn_single("vtol_intro");
    level scene::init("cin_bla_01_01_intro_1st");
    level thread function_fec14fdd();
    level thread function_f197a118();
    level thread function_58ded41f();
    level thread namespace_79e1cd97::function_5d4fc658();
    level thread function_4a444ed5();
    level flag::wait_till("vtol_jump");
    level clientfield::set("gameplay_started", 1);
    level skipto::function_be8adfb8("objective_igc");
}

// Namespace namespace_d754dd61
// Params 4, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_25dc0657
// Checksum 0xf660a93, Offset: 0x43e0
// Size: 0x24
function function_25dc0657(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_d754dd61
// Params 2, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_a19cdfad
// Checksum 0x2f345ed0, Offset: 0x4410
// Size: 0x31c
function function_a19cdfad(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level thread function_13820fbf();
        namespace_79e1cd97::function_bff1a867("objective_qzone");
        level scene::init("cin_bla_03_warlordintro_3rd_sh010");
        load::function_a2995f22();
        level thread function_8c1c268a();
        level thread function_58ded41f();
        level thread namespace_79e1cd97::function_5d4fc658();
        level thread function_4a444ed5();
        level flag::set("vtol_jump");
        trigger::use("trigger_hendricks_start");
        foreach (player in level.players) {
            player switchtoweapon(getweapon("micromissile_launcher"));
        }
        level thread namespace_79e1cd97::function_6778ea09("light_se");
    }
    foreach (player in level.activeplayers) {
        player thread function_ec18f079();
    }
    level thread function_f9c8936b();
    level thread function_2f7b86f3();
    level thread function_e41dbcaa();
    level thread function_251d954();
    if (isdefined(level.var_43858faf)) {
        level thread [[ level.var_43858faf ]]();
    }
    level thread function_c37c7032(0);
    trigger::wait_till("trigger_warlord_igc");
    level skipto::function_be8adfb8("objective_qzone");
}

// Namespace namespace_d754dd61
// Params 4, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_58aef8b7
// Checksum 0x79551348, Offset: 0x4738
// Size: 0x24
function function_58aef8b7(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_2f7b86f3
// Checksum 0x144e0329, Offset: 0x4768
// Size: 0x3c
function function_2f7b86f3() {
    objectives::breadcrumb("qzone_breadcrumb");
    objectives::breadcrumb("warlord_intro_breadcrumb", "cp_level_blackstation_climb");
}

// Namespace namespace_d754dd61
// Params 2, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_b457621f
// Checksum 0xd0db405d, Offset: 0x47b0
// Size: 0x14c
function function_b457621f(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level thread function_13820fbf();
        namespace_79e1cd97::function_bff1a867("objective_warlord_igc");
        level thread namespace_79e1cd97::function_5d4fc658();
        level scene::init("cin_bla_03_warlordintro_3rd_sh010");
        level flag::set("obj_goto_docks");
        load::function_a2995f22();
        level thread function_c37c7032(1);
        level thread function_58ded41f();
        level thread function_da48c515();
    }
    level flag::wait_till("warlord_fight");
    level skipto::function_be8adfb8("objective_warlord_igc");
}

// Namespace namespace_d754dd61
// Params 4, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_487563c5
// Checksum 0x7a3f696, Offset: 0x4908
// Size: 0x24
function function_487563c5(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_da48c515
// Checksum 0x4a89495f, Offset: 0x4938
// Size: 0x24
function function_da48c515() {
    objectives::breadcrumb("warlord_intro_breadcrumb", "cp_level_blackstation_climb");
}

// Namespace namespace_d754dd61
// Params 2, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_f1376b81
// Checksum 0xe6cf67cf, Offset: 0x4968
// Size: 0x4f4
function function_f1376b81(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_79e1cd97::function_bff1a867("objective_warlord");
        level.var_2fd26037 ai::set_ignoreme(1);
        level.var_2fd26037 ai::set_ignoreall(1);
        level thread namespace_79e1cd97::function_5d4fc658();
        level thread function_13820fbf();
        level thread objectives::breadcrumb("anchor_intro_breadcrumb", "cp_level_blackstation_climb");
        level thread namespace_8b9f718f::function_109329ae();
        level thread scene::skipto_end("p7_fxanim_cp_blackstation_shelter_wind_gust_bundle");
        var_c7a78bed = spawner::simple_spawn_single("warlordintro_warlord", &function_5a4025b4);
        for (x = 0; x < 3; x++) {
            spawner::simple_spawn("warlord_igc_" + x, &function_5a4025b4);
        }
        level.var_d8ffea14 = getnodearray("china_town_warlord_preferred_goal", "targetname");
        var_c7a78bed thread function_5d3711fa();
        var_c7a78bed thread function_b287e148();
        level flag::set("obj_goto_docks");
        level flag::set("warlord_fight");
        level thread namespace_4297372::function_fa2e45b8();
        level thread function_58ded41f();
        level notify(#"hash_998c624d");
        load::function_a2995f22();
        wait(0.1);
        foreach (player in level.activeplayers) {
            player switchtoweapon(getweapon("micromissile_launcher"));
        }
        level.var_2fd26037 ai::set_ignoreme(0);
        level.var_2fd26037 ai::set_ignoreall(0);
    }
    level thread namespace_23567e72::function_f0b50148();
    level thread namespace_79e1cd97::function_46dd77b0();
    level thread function_d6aa8860();
    level thread function_ed2f4785();
    level thread function_6e4c2eec();
    level thread function_69df1ce();
    level thread namespace_8b9f718f::function_21f63154();
    foreach (player in level.activeplayers) {
        player util::function_16c71b8(0);
        player thread coop::function_e9f7384d();
    }
    trigger::wait_till("trigger_hendricks_hotel_approach");
    level flag::set("warlord_fight_done");
    level skipto::function_be8adfb8("objective_warlord");
}

// Namespace namespace_d754dd61
// Params 4, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_68cbd90b
// Checksum 0x53f0ae7b, Offset: 0x4e68
// Size: 0x6c
function function_68cbd90b(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level thread namespace_79e1cd97::function_d70754a2();
    showmiscmodels("lt_wharf_water");
    showmiscmodels("vista_water");
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_5a4025b4
// Checksum 0x4aaef245, Offset: 0x4ee0
// Size: 0x44
function function_5a4025b4() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    wait(3);
    self ai::set_ignoreall(0);
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_f9c8936b
// Checksum 0x77412d02, Offset: 0x4f30
// Size: 0x15a
function function_f9c8936b() {
    clientfield::set("roof_panels_init", 1);
    level thread function_f55bf5a1();
    level flag::wait_till("roof_panels");
    clientfield::set("roof_panels_play", 1);
    wait(2);
    var_b8a6ac3 = getent("trigger_roof_panels", "targetname");
    foreach (player in level.activeplayers) {
        if (player istouching(var_b8a6ac3)) {
            player playrumbleonentity("bs_wind_rumble_low");
        }
    }
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_f55bf5a1
// Checksum 0x6d27a03, Offset: 0x5098
// Size: 0x5c
function function_f55bf5a1() {
    e_panel = getent("roof_panel", "targetname");
    array::thread_all(level.activeplayers, &function_855a3b1c, e_panel);
}

// Namespace namespace_d754dd61
// Params 1, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_855a3b1c
// Checksum 0x31629277, Offset: 0x5100
// Size: 0x6c
function function_855a3b1c(e_panel) {
    self endon(#"death");
    level endon(#"hash_ce8b314b");
    self util::waittill_player_looking_at(e_panel.origin, 45, 1);
    level flag::set("roof_panels");
}

// Namespace namespace_d754dd61
// Params 0, eflags: 0x1 linked
// namespace_d754dd61<file_0>::function_13820fbf
// Checksum 0xaecc5068, Offset: 0x5178
// Size: 0xf4
function function_13820fbf() {
    objectives::set("cp_level_blackstation_qzone");
    objectives::set("cp_level_blackstation_intercept");
    level flag::wait_till("obj_goto_docks");
    objectives::set("cp_level_blackstation_intercept");
    objectives::set("cp_level_blackstation_goto_docks");
    level flag::wait_till("warlord_fight");
    objectives::set("cp_level_blackstation_neutralize");
    level flag::wait_till("qzone_done");
    objectives::complete("cp_level_blackstation_neutralize");
}

