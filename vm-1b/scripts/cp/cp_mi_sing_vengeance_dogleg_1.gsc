#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_vengeance_accolades;
#using scripts/cp/cp_mi_sing_vengeance_quadtank_alley;
#using scripts/cp/cp_mi_sing_vengeance_sound;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/stealth;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_level;
#using scripts/shared/stealth_status;
#using scripts/shared/stealth_vo;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace namespace_445ee992;

// Namespace namespace_445ee992
// Params 2, eflags: 0x0
// Checksum 0x90922823, Offset: 0x1308
// Size: 0x1f2
function function_36184f5d(str_objective, var_74cd64bc) {
    level thread function_ced218b0();
    if (var_74cd64bc) {
        load::function_73adcefc();
        namespace_63b4601c::function_b87f9c13(str_objective, var_74cd64bc);
        namespace_63b4601c::function_66773296("hendricks", str_objective);
        callback::on_spawned(&namespace_63b4601c::give_hero_weapon);
        level.var_2fd26037 ai::set_ignoreall(1);
        level.var_2fd26037 ai::set_ignoreme(1);
        level.var_2fd26037 colors::disable();
        level.var_2fd26037.goalradius = 32;
        level.var_2fd26037 setgoal(level.var_2fd26037.origin);
        namespace_63b4601c::function_e00864bd("dogleg_1_umbra_gate", 1, "dogleg_1_gate");
        objectives::set("cp_level_vengeance_rescue_kane");
        objectives::set("cp_level_vengeance_go_to_safehouse");
        objectives::hide("cp_level_vengeance_go_to_safehouse");
        level thread namespace_9fd035::function_dad71f51("tension_loop_2");
        level.var_4c62d05f = level.players[0];
        scene::init("cin_ven_04_10_cafedoor_1st_sh010");
        util::function_d8eaed3d(3);
        load::function_a2995f22();
    }
    namespace_63b4601c::function_4e8207e9("dogleg_1");
    function_803e1db9(str_objective, var_74cd64bc);
}

// Namespace namespace_445ee992
// Params 2, eflags: 0x0
// Checksum 0x7a75e746, Offset: 0x1508
// Size: 0x2c3
function function_803e1db9(str_objective, var_74cd64bc) {
    level flag::set("dogleg_1_begin");
    level thread function_254de1e5();
    function_e17e849c();
    stealth::reset();
    namespace_523da15d::function_e887345e();
    namespace_523da15d::function_eda4634d();
    level thread function_7272ed9d();
    level thread dogleg_1_wasps();
    level.quadtank_alley_intro_org = struct::get("quadtank_alley_intro_org");
    level.quadtank_alley_intro_org scene::init("cin_ven_04_30_quadalleydoor_1st");
    level thread function_6236563e();
    level.dogleg_1_patroller_spawners = spawner::simple_spawn("dogleg_1_patroller_spawners", &namespace_63b4601c::function_b62b56ba);
    level thread function_6c25c493(var_74cd64bc);
    level thread function_1909c582();
    level thread function_6fdd2184();
    level thread function_3c2b6e87();
    level thread function_842de716();
    level.lineup_kill_scripted_node = struct::get("lineup_kill_scripted_node", "targetname");
    level.lineup_kill_scripted_node thread scene::init("cin_ven_03_20_storelineup_vign_exit");
    storelineup_door3_clip = getent("storelineup_door3_clip", "targetname");
    if (isdefined(storelineup_door3_clip)) {
        storelineup_door3_clip solid();
        storelineup_door3_clip disconnectpaths();
    }
    storelineup_door3_open_clip = getent("storelineup_door3_open_clip", "targetname");
    storelineup_door3_open_clip delete();
    triggers = getentarray("dogleg_1_stealth_checkpoint_trigger", "targetname");
    foreach (trigger in triggers) {
        trigger thread namespace_63b4601c::function_f9c94344();
    }
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x2e6fe2e5, Offset: 0x17d8
// Size: 0x8b
function function_254de1e5() {
    a_allies = getaiteamarray("allies");
    foreach (ally in a_allies) {
        if (isdefined(ally.remote_owner)) {
            ally delete();
        }
    }
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x9d9862eb, Offset: 0x1870
// Size: 0x19a
function function_e17e849c() {
    level.dogleg_1_intro_org = struct::get("dogleg_1_intro_org");
    namespace_63b4601c::function_ac2b4535("cin_ven_04_10_cafedoor_1st_sh100", "cafe_igc_teleport");
    level thread function_798b0fec();
    level thread function_d45f757d();
    if (isdefined(level.var_95299f90)) {
        level thread [[ level.var_95299f90 ]]();
    }
    level.dogleg_1_intro_org thread scene::play("cin_ven_04_10_cafedoor_1st_sh010", level.var_4c62d05f);
    level.var_2fd26037 thread function_58b57a69();
    level waittill(#"hash_a60d391c");
    level thread function_668cc6df();
    level thread function_e9e34547();
    level waittill(#"hash_2b965a47");
    if (isdefined(level.var_63599d)) {
        level thread [[ level.var_63599d ]]();
    }
    level thread namespace_9fd035::function_dad71f51("tension_loop_2");
    foreach (player in level.players) {
        player thread function_fd7fd40d();
    }
    util::clear_streamer_hint();
    savegame::checkpoint_save();
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x4d43baaa, Offset: 0x1a18
// Size: 0x92
function function_fd7fd40d() {
    self endon(#"death");
    self endon(#"disconnect");
    self thread function_8e0d7da8();
    weap = getweapon("ar_marksman_veng_hero_weap");
    if (!self hasweapon(weap)) {
        self giveweapon(weap);
    }
    self switchtoweaponimmediate(weap);
    self thread namespace_63b4601c::function_12a1b6a0();
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0xf5409f25, Offset: 0x1ab8
// Size: 0x5a
function function_8e0d7da8() {
    self endon(#"death");
    self endon(#"disconnect");
    self hideviewmodel();
    weap = getweapon("ar_marksman_veng_hero_weap");
    wait 0.15;
    self showviewmodel();
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x71cd07b4, Offset: 0x1b20
// Size: 0x202
function function_798b0fec() {
    level endon(#"hash_2b965a47");
    level dialog::remote("tayr_you_don_t_understand_1", 0, "no_dni");
    level thread namespace_9fd035::function_862430bd();
    util::clientnotify("sndLRstop");
    level notify(#"hash_15e32f84");
    level.var_2fd26037 waittill(#"hash_a89f76ac");
    level.var_2fd26037 namespace_63b4601c::function_5fbec645("hend_you_sold_us_out_you_0");
    level dialog::remote("tayr_i_told_the_truth_0", 0, "no_dni");
    level dialog::remote("tayr_behind_a_slick_corpo_0", 0, "no_dni");
    level dialog::remote("tayr_experiments_that_wou_0", 0, "no_dni");
    level dialog::remote("tayr_ask_yourself_who_s_0", 0, "no_dni");
    level dialog::remote("tayr_the_people_who_survi_0", 0, "no_dni");
    level dialog::remote("tayr_or_the_fucking_suits_0", 0, "no_dni");
    level dialog::remote("tayr_the_immortals_built_0", 0, "no_dni");
    level dialog::remote("tayr_maybe_they_want_reve_0", 0, "no_dni");
    level dialog::remote("tayr_maybe_they_just_want_0", 0, "no_dni");
    level dialog::remote("tayr_either_way_you_can_0", 0, "no_dni");
    level dialog::remote("hend_taylor_taylor_0", 0, "no_dni");
    dialog::function_13b3b16a("plyr_kane_how_the_hell_0");
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x9b23b1fd, Offset: 0x1d30
// Size: 0xca
function function_d45f757d() {
    level waittill(#"hash_73c7894d");
    molotov_civilian = getent("molotov_civilian", "targetname");
    if (isdefined(molotov_civilian)) {
        molotov_civilian thread namespace_63b4601c::function_f6af6062();
    }
    molotov_civilian2 = getent("molotov_civilian2", "targetname");
    if (isdefined(molotov_civilian2)) {
        molotov_civilian2 thread namespace_63b4601c::function_f6af6062();
    }
    molotov_civilian3 = getent("molotov_civilian3", "targetname");
    if (isdefined(molotov_civilian3)) {
        molotov_civilian3 thread namespace_63b4601c::function_f6af6062();
    }
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0xba2f5406, Offset: 0x1e08
// Size: 0x6a
function function_842de716() {
    dogleg_1_entrance_door_clip = getent("dogleg_1_entrance_door_clip", "targetname");
    if (isdefined(dogleg_1_entrance_door_clip)) {
        dogleg_1_entrance_door_clip notsolid();
        dogleg_1_entrance_door_clip connectpaths();
        wait 0.05;
        dogleg_1_entrance_door_clip delete();
    }
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x87c08a28, Offset: 0x1e80
// Size: 0xb3
function function_7272ed9d() {
    killing_streets_lineup_kill_ai_blockers = getentarray("killing_streets_lineup_kill_ai_blockers", "targetname");
    foreach (ent in killing_streets_lineup_kill_ai_blockers) {
        ent notsolid();
        ent connectpaths();
        wait 0.05;
        ent delete();
    }
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0xd654ef91, Offset: 0x1f40
// Size: 0x8a
function function_58b57a69() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self colors::disable();
    self ai::set_behavior_attribute("cqb", 1);
    self.goalradius = 32;
    self setgoal(self.origin);
    self waittill(#"hash_8e639ede");
    self delete();
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x7b5dc314, Offset: 0x1fd8
// Size: 0x52
function dogleg_1_wasps() {
    level.dogleg_1_wasps = spawner::simple_spawn("dogleg_1_wasps", &function_b5dfff73);
    level.var_4843e321 = level.dogleg_1_wasps.size;
    namespace_523da15d::function_cae14a51();
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x8ad5fc1b, Offset: 0x2038
// Size: 0x62
function function_b5dfff73() {
    dogleg_1_wasp_gv = getent("dogleg_1_wasp_gv", "targetname");
    if (isdefined(dogleg_1_wasp_gv)) {
        self clearforcedgoal();
        self cleargoalvolume();
        self setgoal(dogleg_1_wasp_gv);
    }
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x777f1b91, Offset: 0x20a8
// Size: 0x1aa
function function_668cc6df() {
    level.cafe_execution_org = struct::get("cafe_execution_org");
    spawner::add_spawn_function_group("cafe_execution_civ_spawners", "script_noteworthy", &function_d6204097);
    spawner::add_spawn_function_group("cafe_execution_thug_spawners", "script_noteworthy", &function_631eb91d);
    spawner::add_spawn_function_group("cafe_execution_thug_spawners", "script_noteworthy", &function_1fef873);
    level.cafe_execution_org scene::init("cin_ven_04_20_cafeexecution_vign_intro");
    while (!level scene::is_ready("cin_ven_04_20_cafeexecution_vign_intro")) {
        wait 0.05;
    }
    level.cafe_execution_54i_thug_a_ai = getent("cafe_execution_54i_thug_a_ai", "targetname", 1);
    level.cafe_execution_civ_01_ai = getent("cafe_execution_civ_01_ai", "targetname", 1);
    level.cafe_execution_civ_02_ai = getent("cafe_execution_civ_02_ai", "targetname", 1);
    level.cafe_execution_civ_03_ai = getent("cafe_execution_civ_03_ai", "targetname", 1);
    level thread function_dbe2f523();
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x31aeecb0, Offset: 0x2260
// Size: 0x192
function function_d6204097() {
    self endon(#"death");
    self.team = "allies";
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self ai::set_behavior_attribute("panic", 0);
    self.health = 1;
    self util::waittill_either("try_to_escape", "kill_me");
    if (!level flag::get("cafe_execution_thug_dead")) {
        self.takedamage = 1;
        self.skipdeath = 1;
        self.allowdeath = 1;
        self kill();
        return;
    }
    self stopanimscripted();
    self.civilian = 1;
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
    self animation::play(self.script_parameters, level.cafe_execution_org.origin, level.cafe_execution_org.angles);
    if (isdefined(self.target)) {
        node = getnode(self.target, "targetname");
        self thread namespace_63b4601c::function_3d5f97bd(node);
    }
    self ai::set_behavior_attribute("panic", 1);
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x1409899b, Offset: 0x2400
// Size: 0x32
function function_631eb91d() {
    self endon(#"death");
    self waittill(#"alert");
    level.cafe_execution_org scene::play("cin_ven_04_20_cafeexecution_vign_intro");
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0xad4cce1a, Offset: 0x2440
// Size: 0x8f
function function_1fef873() {
    self waittill(#"death");
    level flag::set("cafe_execution_thug_dead");
    for (i = 1; i < 6; i++) {
        guy = getent("cafe_execution_civ_0" + i + "_ai", "targetname");
        if (isdefined(guy) && isalive(guy)) {
            guy notify(#"try_to_escape");
        }
    }
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0xe36947da, Offset: 0x24d8
// Size: 0x14a
function function_dbe2f523() {
    level.cafe_execution_54i_thug_a_ai endon(#"death");
    level.cafe_execution_civ_01_ai endon(#"death");
    level.cafe_execution_civ_02_ai endon(#"death");
    level.cafe_execution_civ_03_ai endon(#"death");
    level.cafe_execution_54i_thug_a_ai endon(#"alert");
    level.cafe_execution_54i_thug_a_ai endon(#"fake_alert");
    trigger = getent("cafeexecution_vign_vo_trigger", "targetname");
    trigger waittill(#"trigger");
    level.cafe_execution_54i_thug_a_ai namespace_63b4601c::function_5fbec645("ffim1_all_your_money_won_t_1");
    wait 0.5;
    level.cafe_execution_54i_thug_a_ai namespace_63b4601c::function_5fbec645("ffim2_laughter_2");
    wait 0.5;
    level.cafe_execution_civ_01_ai namespace_63b4601c::function_5fbec645("mciv_stoooop_noooooo_0");
    wait 1;
    level.cafe_execution_civ_02_ai namespace_63b4601c::function_5fbec645("mciv_let_me_go_please_0");
    wait 0.5;
    level.cafe_execution_54i_thug_a_ai namespace_63b4601c::function_5fbec645("ffim3_laughter_3");
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x85f65502, Offset: 0x2630
// Size: 0x162
function function_ced218b0() {
    level.cafe_burning_org = struct::get("cafe_burning_org");
    spawner::add_spawn_function_group("cafe_burning_54i_thug_a", "targetname", &function_8b8b9516);
    spawner::add_spawn_function_group("cafe_burning_54i_thug_b", "targetname", &function_97ac3293);
    spawner::add_spawn_function_group("cafe_burning_civ_01", "targetname", &function_8ac1fffe);
    spawner::add_spawn_function_group("cafe_burning_civ_02", "targetname", &function_8ac1fffe);
    spawner::add_spawn_function_group("cafe_burning_civ_03", "targetname", &function_8ac1fffe);
    scene::add_scene_func("cin_ven_04_20_cafeburning_vign_loop", &function_924af258, "init", 1);
    level.cafe_burning_org scene::init("cin_ven_04_20_cafeburning_vign_loop");
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0xb0ced8f4, Offset: 0x27a0
// Size: 0x22a
function function_e9e34547() {
    scene::add_scene_func("cin_ven_04_20_cafeburning_vign_loop", &function_924af258, "play");
    level.cafe_burning_org thread scene::play("cin_ven_04_20_cafeburning_vign_loop");
    wait 1;
    level.cafe_burning_54i_thug_a_ai = getent("cafe_burning_54i_thug_a_ai", "targetname", 1);
    level.cafe_burning_54i_thug_b_ai = getent("cafe_burning_54i_thug_b_ai", "targetname", 1);
    level.cafe_burning_civ_01_ai = getent("cafe_burning_civ_01_ai", "targetname", 1);
    level.cafe_burning_civ_03_ai = getent("cafe_burning_civ_02_ai", "targetname", 1);
    level.cafe_burning_civ_02_ai = getent("cafe_burning_civ_03_ai", "targetname", 1);
    level thread function_558e4ac8();
    level.cafe_burning_54i_thug_a_ai thread namespace_63b4601c::function_394ba9b5(level.cafe_burning_54i_thug_b_ai);
    level.cafe_burning_54i_thug_b_ai thread namespace_63b4601c::function_394ba9b5(level.cafe_burning_54i_thug_a_ai);
    level.cafe_burning_54i_thug_a_ai thread namespace_63b4601c::function_d468b73d("death", array(level.cafe_burning_civ_01_ai, level.cafe_burning_civ_02_ai, level.cafe_burning_civ_03_ai), "cafe_burning_check_for_escape");
    enemy_array = [];
    enemy_array[0] = level.cafe_burning_54i_thug_a_ai;
    enemy_array[1] = level.cafe_burning_54i_thug_b_ai;
    level.cafe_burning_civ_01_ai thread function_dc4e86b5(enemy_array);
    level.cafe_burning_civ_02_ai thread function_dc4e86b5(enemy_array);
    level.cafe_burning_civ_03_ai thread function_dc4e86b5(enemy_array);
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x2be10dde, Offset: 0x29d8
// Size: 0x19a
function function_558e4ac8() {
    level.cafe_burning_54i_thug_a_ai endon(#"death");
    level.cafe_burning_54i_thug_b_ai endon(#"death");
    level.cafe_burning_civ_01_ai endon(#"death");
    level.cafe_burning_civ_03_ai endon(#"death");
    level.cafe_burning_civ_02_ai endon(#"death");
    level.cafe_burning_54i_thug_a_ai endon(#"alert");
    level.cafe_burning_54i_thug_b_ai endon(#"alert");
    level.cafe_burning_54i_thug_a_ai endon(#"fake_alert");
    level.cafe_burning_54i_thug_b_ai endon(#"fake_alert");
    trigger = getent("cafeburning_vign_vo_trigger", "targetname");
    trigger waittill(#"trigger");
    level.cafe_burning_54i_thug_a_ai namespace_63b4601c::function_5fbec645("ffim1_now_we_re_the_ones_w_1");
    wait 1;
    level.cafe_burning_54i_thug_b_ai namespace_63b4601c::function_5fbec645("ffim2_laughter_3");
    wait 1;
    level.cafe_burning_civ_01_ai namespace_63b4601c::function_5fbec645("mciv_no_please_noooooo_0");
    wait 1.5;
    level.cafe_burning_civ_02_ai namespace_63b4601c::function_5fbec645("mciv_stop_i_have_childre_0");
    wait 0.5;
    level.cafe_burning_54i_thug_a_ai namespace_63b4601c::function_5fbec645("ffim1_your_children_will_j_0");
    wait 0.5;
    level.cafe_burning_54i_thug_b_ai namespace_63b4601c::function_5fbec645("ffim3_laughter_3");
}

// Namespace namespace_445ee992
// Params 2, eflags: 0x0
// Checksum 0xc2b2f426, Offset: 0x2b80
// Size: 0xcb
function function_924af258(a_ents, hide_me) {
    if (isdefined(hide_me)) {
        foreach (ent in a_ents) {
            ent hide();
        }
        return;
    }
    foreach (ent in a_ents) {
        ent show();
    }
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x5ad37e4a, Offset: 0x2c58
// Size: 0xb2
function function_8b8b9516() {
    self endon(#"death");
    self ai::set_behavior_attribute("can_melee", 0);
    var_ccf9b73f = util::spawn_anim_model("p7_ven_gascan_static");
    var_ccf9b73f linkto(self, "tag_weapon_chest", (0, 0, 0), (0, 0, 0));
    self thread function_78c388c0(var_ccf9b73f);
    self thread namespace_63b4601c::function_57b69bd6(var_ccf9b73f);
    self waittill(#"fake_alert");
    if (isdefined(self.silenced) && self.silenced) {
        return;
    }
    self stopanimscripted();
}

// Namespace namespace_445ee992
// Params 1, eflags: 0x0
// Checksum 0x7d80d22a, Offset: 0x2d18
// Size: 0x1a
function function_78c388c0(var_ccf9b73f) {
    function_3f42ba98(var_ccf9b73f);
}

// Namespace namespace_445ee992
// Params 1, eflags: 0x0
// Checksum 0xa652bc22, Offset: 0x2d40
// Size: 0x26d
function function_3f42ba98(var_ccf9b73f) {
    self endon(#"death");
    self endon(#"fake_alert");
    self endon(#"alert");
    while (true) {
        level waittill(#"hash_e239447e");
        playfxontag(level._effect["fx_fuel_pour_far_ven"], var_ccf9b73f, "tag_fx");
        level waittill(#"hash_bc36ca15");
        playfxontag(level._effect["fx_fuel_pour_far_ven"], var_ccf9b73f, "tag_fx");
        level waittill(#"hash_96344fac");
        playfxontag(level._effect["fx_fuel_pour_far_ven"], var_ccf9b73f, "tag_fx");
        level waittill(#"hash_7031d543");
        playfxontag(level._effect["fx_fuel_pour_far_ven"], var_ccf9b73f, "tag_fx");
        level waittill(#"hash_4a2f5ada");
        playfxontag(level._effect["fx_fuel_pour_far_ven"], var_ccf9b73f, "tag_fx");
        level waittill(#"hash_242ce071");
        playfxontag(level._effect["fx_fuel_pour_far_ven"], var_ccf9b73f, "tag_fx");
        level waittill(#"hash_fe2a6608");
        playfxontag(level._effect["fx_fuel_pour_far_ven"], var_ccf9b73f, "tag_fx");
        level waittill(#"hash_d827eb9f");
        playfxontag(level._effect["fx_fuel_pour_far_ven"], var_ccf9b73f, "tag_fx");
        level waittill(#"hash_b2257136");
        playfxontag(level._effect["fx_fuel_pour_far_ven"], var_ccf9b73f, "tag_fx");
        level waittill(#"hash_be9dc60a");
        playfxontag(level._effect["fx_fuel_pour_far_ven"], var_ccf9b73f, "tag_fx");
        level waittill(#"hash_e4a04073");
        playfxontag(level._effect["fx_fuel_pour_far_ven"], var_ccf9b73f, "tag_fx");
        level waittill(#"hash_7298d138");
        playfxontag(level._effect["fx_fuel_pour_far_ven"], var_ccf9b73f, "tag_fx");
    }
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0xc7c21220, Offset: 0x2fb8
// Size: 0xba
function function_97ac3293() {
    self endon(#"death");
    self thread watch_for_death();
    wait 0.2;
    self thread function_a44271e3();
    self util::waittill_any("alert", "fake_alert");
    level notify(#"cafeburning_flare_enemy_alert");
    if (isdefined(self.silenced) && self.silenced) {
        return;
    }
    level.cafe_burning_org thread scene::play("cin_ven_04_20_cafeburning_vign_main");
    self waittill(#"cafe_burning_match_thrown");
    level flag::set("cafe_burning_match_thrown");
    self.allowdeath = 1;
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x8dbd15b2, Offset: 0x3080
// Size: 0xba
function function_a44271e3() {
    level endon(#"dogleg_1_end");
    while (isalive(self)) {
        cafe_burning_flare = getent("cafe_burning_flare", "targetname", 1);
        if (isdefined(cafe_burning_flare)) {
            break;
        }
        wait 0.05;
    }
    if (!isalive(self) && !isdefined(cafe_burning_flare)) {
        level.cafe_burning_org scene::stop("cin_ven_04_20_cafeburning_vign_loop");
        return;
    }
    self thread namespace_63b4601c::function_1ed65aa(array(cafe_burning_flare));
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0xc67379a8, Offset: 0x3148
// Size: 0x17
function watch_for_death() {
    self waittill(#"death");
    level notify(#"cafeburning_flare_enemy_dead");
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0xb9fd2e9a, Offset: 0x3168
// Size: 0x1b2
function function_8ac1fffe() {
    self endon(#"death");
    self.team = "allies";
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self ai::set_behavior_attribute("panic", 0);
    self.health = 1;
    self.goalradius = 32;
    msg = level util::waittill_any_return("cafeburning_flare_enemy_alert", "cafeburning_flare_enemy_dead");
    if (msg == "cafeburning_flare_enemy_dead") {
        self stopanimscripted();
        self.civilian = 1;
        self ai::set_ignoreme(0);
        self ai::set_ignoreall(0);
        level.cafe_burning_org scene::play(self.script_parameters);
        if (isdefined(self.target)) {
            node = getnode(self.target, "targetname");
            self thread namespace_63b4601c::function_3d5f97bd(node, undefined, undefined, 1024);
        }
        self ai::set_behavior_attribute("panic", 1);
        return;
    }
    self waittill(#"cafe_burning_check_for_escape");
    playsoundatposition("evt_civ_group_burn", (21564, -86, -120));
    self namespace_63b4601c::function_f6af6062(0);
    self namespace_63b4601c::function_f6af6062(0);
    self namespace_63b4601c::function_f6af6062(0);
}

// Namespace namespace_445ee992
// Params 1, eflags: 0x0
// Checksum 0x2741453f, Offset: 0x3328
// Size: 0xb3
function function_dc4e86b5(enemy_array) {
    level endon(#"dogleg_1_end");
    level endon(#"stealth_discovered");
    self waittill(#"damage", damage, attacker);
    if (isplayer(attacker)) {
        foreach (enemy in enemy_array) {
            if (isdefined(enemy)) {
                enemy thread stealth_level::wake_all();
            }
        }
    }
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0xaeba9ae3, Offset: 0x33e8
// Size: 0x4f2
function function_3c2b6e87() {
    level endon(#"dogleg_1_end");
    level.cafe_molotov_org = struct::get("cafe_molotov_org");
    spawner::add_spawn_function_group("cafe_molotov_civ_spawners", "script_noteworthy", &function_147bbbbf);
    var_932d1fc6 = [];
    var_932d1fc6[0] = spawner::simple_spawn_single("cafe_molotov_thug_a", undefined, undefined, undefined, undefined, undefined, undefined, 1);
    var_932d1fc6[1] = util::spawn_anim_model("p7_emergency_flare");
    var_932d1fc6[2] = util::spawn_anim_model("p7_bottle_glass_liquor_03");
    var_932d1fc6[3] = util::spawn_anim_model("p7_bottle_glass_liquor_03");
    var_932d1fc6[4] = util::spawn_anim_model("p7_bottle_glass_liquor_03");
    var_932d1fc6[5] = util::spawn_anim_model("p7_bottle_glass_liquor_03");
    a_objects = [];
    a_objects[0] = var_932d1fc6[1];
    a_objects[1] = var_932d1fc6[2];
    a_objects[2] = var_932d1fc6[3];
    a_objects[3] = var_932d1fc6[4];
    a_objects[4] = var_932d1fc6[5];
    wait 0.2;
    level.cafe_molotov_org thread scene::play("cin_ven_04_20_cafemolotovflush_vign_intro", var_932d1fc6);
    wait 0.2;
    var_932d1fc6[0] thread namespace_63b4601c::function_7122594d(a_objects);
    wait 14;
    level.cafe_molotov_org thread scene::play("cin_ven_04_20_cafemolotovflush_vign_civa");
    wait 0.05;
    guy = getent("cafe_molotov_civ_01_ai", "targetname");
    if (isdefined(guy)) {
        guy thread namespace_63b4601c::function_f6af6062();
    }
    wait randomfloatrange(4, 8);
    level.cafe_molotov_org thread scene::play("cin_ven_04_20_cafemolotovflush_vign_civb");
    wait 0.05;
    guy = getent("cafe_molotov_civ_02_ai", "targetname");
    if (isdefined(guy)) {
        guy thread namespace_63b4601c::function_f6af6062();
    }
    wait randomfloatrange(4, 8);
    level.cafe_molotov_org thread scene::play("cin_ven_04_20_cafemolotovflush_vign_civc");
    wait 0.05;
    guy = getent("cafe_molotov_civ_03_ai", "targetname");
    if (isdefined(guy)) {
        guy thread namespace_63b4601c::function_f6af6062();
    }
    wait randomfloatrange(4, 8);
    level.cafe_molotov_org thread scene::play("cin_ven_04_20_cafemolotovflush_vign_civd");
    wait 0.05;
    guy = getent("cafe_molotov_civ_04_ai", "targetname");
    if (isdefined(guy)) {
        guy thread namespace_63b4601c::function_f6af6062();
    }
    wait randomfloatrange(4, 8);
    level.cafe_molotov_org thread scene::play("cin_ven_04_20_cafemolotovflush_vign_cive");
    wait 0.05;
    guy = getent("cafe_molotov_civ_05_ai", "targetname");
    if (isdefined(guy)) {
        guy thread namespace_63b4601c::function_f6af6062();
    }
    wait randomfloatrange(4, 8);
    level.cafe_molotov_org thread scene::play("cin_ven_04_20_cafemolotovflush_vign_civf");
    wait 0.05;
    guy = getent("cafe_molotov_civ_06_ai", "targetname");
    if (isdefined(guy)) {
        guy thread namespace_63b4601c::function_f6af6062();
    }
    wait randomfloatrange(4, 8);
    level.cafe_molotov_org thread scene::play("cin_ven_04_20_cafemolotovflush_vign_civg");
    wait 0.05;
    guy = getent("cafe_molotov_civ_07_ai", "targetname");
    if (isdefined(guy)) {
        guy thread namespace_63b4601c::function_f6af6062();
    }
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x6223731c, Offset: 0x38e8
// Size: 0x5a
function function_147bbbbf() {
    self endon(#"death");
    self.team = "allies";
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self ai::set_behavior_attribute("panic", 0);
    self.health = 1;
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0xd195c7ae, Offset: 0x3950
// Size: 0x23a
function function_6236563e() {
    wait 3;
    goto_quadtank_alley_obj_org = struct::get("goto_quadtank_alley_obj_org", "targetname");
    objectives::set("cp_level_vengeance_goto_quadtank_alley", goto_quadtank_alley_obj_org);
    quadtank_alley_intro_trigger = getent("quadtank_alley_intro_trigger", "script_noteworthy");
    quadtank_alley_intro_trigger triggerenable(0);
    msg = level util::waittill_any_return("goto_quadtank_alley_trigger_touched", "stealth_discovered");
    if (msg == "stealth_discovered") {
        objectives::hide("cp_level_vengeance_goto_quadtank_alley");
        objectives::set("cp_level_vengeance_clear_area");
        level flag::wait_till_clear("stealth_discovered");
        objectives::show("cp_level_vengeance_goto_quadtank_alley");
        objectives::hide("cp_level_vengeance_clear_area");
        level flag::wait_till("goto_quadtank_alley_trigger_touched");
    }
    objectives::hide("cp_level_vengeance_goto_quadtank_alley");
    quadtank_alley_intro_trigger triggerenable(1);
    var_ca0e9b65 = util::function_14518e76(quadtank_alley_intro_trigger, %cp_prompt_enter_ven_gate, %CP_MI_SING_VENGEANCE_HINT_OPEN, &function_9c72eea2);
    objectives::set("cp_level_vengeance_open_quadtank_alley_menu");
    level thread namespace_63b4601c::function_8a63fd6b(quadtank_alley_intro_trigger, undefined, "cp_level_vengeance_open_quadtank_alley_menu", "start_quadtank_alley_intro", "cp_level_vengeance_clear_area", var_ca0e9b65);
    level flag::wait_till("start_quadtank_alley_intro");
    var_ca0e9b65 gameobjects::disable_object();
    objectives::hide("cp_level_vengeance_open_quadtank_alley_menu");
}

// Namespace namespace_445ee992
// Params 1, eflags: 0x0
// Checksum 0xc8b96ea9, Offset: 0x3b98
// Size: 0x1e
function function_9c72eea2(e_player) {
    level notify(#"quadtank_alley_activated");
    level.var_4c62d05f = e_player;
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x80ed8e7a, Offset: 0x3bc0
// Size: 0x2a
function function_1909c582() {
    level endon(#"dogleg_1_end");
    level flag::wait_till("stealth_combat");
    level.var_508337f6 = 1;
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x3e8379a6, Offset: 0x3bf8
// Size: 0xe2
function function_6fdd2184() {
    level endon(#"dogleg_1_end");
    level flag::wait_till("stealth_discovered");
    stealth::function_26f24c93(0);
    level thread namespace_63b4601c::function_80840124();
    level thread function_adb6f63(5);
    while (true) {
        guys = getaiteamarray("axis");
        if (isdefined(guys) && guys.size <= 0 || !isdefined(guys)) {
            break;
        }
        wait 0.1;
    }
    namespace_63b4601c::function_ee75acde("hend_that_s_the_last_of_0");
    level flag::clear("stealth_combat");
    level flag::clear("stealth_discovered");
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0x1f0af770, Offset: 0x3ce8
// Size: 0x3a
function function_24a63cea() {
    self endon(#"death");
    if (isdefined(self.var_66a618ee) && self.var_66a618ee) {
        self ai::set_behavior_attribute("sprint", 1);
    }
}

// Namespace namespace_445ee992
// Params 4, eflags: 0x0
// Checksum 0x796a5701, Offset: 0x3d30
// Size: 0x32a
function function_8db83207(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level flag::set("dogleg_1_end");
    level notify(#"hash_bab8795");
    level flag::clear("combat_enemies_retreating");
    level function_e775c7d8();
    namespace_523da15d::function_a4b67c57();
    namespace_523da15d::function_82266abb();
    namespace_63b4601c::function_4e8207e9("dogleg_1", 0);
    if (isdefined(var_74cd64bc) && (!isdefined(var_74cd64bc) || var_74cd64bc == 0)) {
        namespace_63b4601c::function_66773296("hendricks", str_objective);
        namespace_63b4601c::function_ac2b4535("cin_ven_04_30_quadalleydoor_1st", "quadalleydoor_igc_teleport");
        spawner::add_spawn_function_group("quadteaser_qt", "script_noteworthy", &namespace_6f44bbbf::function_5c60b4ee);
        level thread namespace_6f44bbbf::function_32620a97();
        level thread namespace_6f44bbbf::function_323d0a39();
        level util::waittill_notify_or_timeout("quadtank_alley_activated", 1);
        if (isdefined(level.var_552d576a)) {
            level thread [[ level.var_552d576a ]]();
        }
        level.quadtank_alley_intro_org thread scene::play("cin_ven_04_30_quadalleydoor_1st", level.var_4c62d05f);
        level waittill(#"hash_57cf6a02");
        var_7d044b82 = struct::get("quad_alley_door_physics", "targetname");
        physicsexplosionsphere(var_7d044b82.origin, 64, 48, 1);
    }
    level struct::function_368120a1("scene", "cin_ven_04_10_cafedoor_1st_sh010");
    level struct::function_368120a1("scene", "cin_ven_04_10_cafedoor_3rd_sh020");
    level struct::function_368120a1("scene", "cin_ven_04_10_cafedoor_3rd_sh030");
    level struct::function_368120a1("scene", "cin_ven_04_10_cafedoor_3rd_sh040");
    level struct::function_368120a1("scene", "cin_ven_04_10_cafedoor_3rd_sh050");
    level struct::function_368120a1("scene", "cin_ven_04_10_cafedoor_3rd_sh060");
    level struct::function_368120a1("scene", "cin_ven_04_10_cafedoor_3rd_sh070");
    level struct::function_368120a1("scene", "cin_ven_04_10_cafedoor_3rd_sh080");
    level struct::function_368120a1("scene", "cin_ven_04_10_cafedoor_3rd_sh090");
    level struct::function_368120a1("scene", "cin_ven_04_10_cafedoor_1st_sh100");
}

// Namespace namespace_445ee992
// Params 0, eflags: 0x0
// Checksum 0xde11b506, Offset: 0x4068
// Size: 0xdb
function function_e775c7d8() {
    array::thread_all(getaiteamarray("axis"), &util::self_delete);
    array::run_all(getcorpsearray(), &delete);
    if (isdefined(level.dogleg_1_wasps)) {
        foreach (enemy in level.dogleg_1_wasps) {
            if (isdefined(enemy)) {
                enemy delete();
            }
        }
    }
}

// Namespace namespace_445ee992
// Params 1, eflags: 0x0
// Checksum 0x65be6c5, Offset: 0x4150
// Size: 0x20d
function function_adb6f63(var_f02766b0) {
    level endon(#"dogleg_1_end");
    if (!isdefined(var_f02766b0)) {
        var_f02766b0 = 3;
    }
    while (true) {
        guys = getaiteamarray("axis");
        if (isdefined(guys) && guys.size <= var_f02766b0) {
            foreach (guy in guys) {
                if (isdefined(guy) && isalive(guy)) {
                    if (isvehicle(guy)) {
                        dogleg_1_wasp_retreat_nodes = struct::get_array("dogleg_1_wasp_retreat_nodes", "targetname");
                        node = array::random(dogleg_1_wasp_retreat_nodes);
                        guy thread namespace_63b4601c::function_3d5f97bd(node);
                    }
                    node = getnodearraysorted("dogleg_1_retreat_nodes", "targetname", guy.origin, 4096);
                    if (isdefined(node[0])) {
                        if (guy ai::has_behavior_attribute("sprint")) {
                            guy ai::set_behavior_attribute("sprint", 1);
                        }
                        guy thread namespace_63b4601c::function_3d5f97bd(node[0]);
                        continue;
                    }
                    a_ai = array(guy);
                    level thread namespace_63b4601c::function_ff5f379(a_ai, 1024);
                }
            }
            level flag::set("combat_enemies_retreating");
            break;
        }
        wait 1;
    }
}

// Namespace namespace_445ee992
// Params 1, eflags: 0x0
// Checksum 0xb91ee919, Offset: 0x4368
// Size: 0x52
function function_6c25c493(var_74cd64bc) {
    level endon(#"stealth_discovered");
    stealth::function_26f24c93(1);
    flag::wait_till("dogleg_1_stealth_motivator_01");
    flag::wait_till("dogleg_1_stealth_motivator_02");
}

