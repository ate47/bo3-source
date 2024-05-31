#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_teleporter;
#using scripts/zm/zm_tomb_mech;
#using scripts/zm/zm_tomb_amb;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_weap_one_inch_punch;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_clone;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_d1b0a244;

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_e73fe92b
// Checksum 0x91cc9dce, Offset: 0xfe8
// Size: 0x21c
function function_e73fe92b() {
    level flag::init("foot_shot");
    level flag::init("three_robot_round");
    level flag::init("fire_link_enabled");
    level flag::init("timeout_vo_robot_0");
    level flag::init("timeout_vo_robot_1");
    level flag::init("timeout_vo_robot_2");
    level flag::init("all_robot_hatch");
    level thread function_bcb499ac();
    level.var_a4d81f61 = [];
    level.var_a4d81f61[0] = 1;
    level.var_a4d81f61[1] = 1;
    level.var_a4d81f61[2] = 1;
    var_697a7c19 = struct::get_array("giant_robot_head_exit_trigger", "script_noteworthy");
    foreach (struct in var_697a7c19) {
        function_3ec1bfe6(struct);
    }
    level thread function_a37f89ca();
    level thread function_6492173();
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_1e8f6f14
// Checksum 0xad6d319b, Offset: 0x1210
// Size: 0x3d4
function function_1e8f6f14() {
    clientfield::register("scriptmover", "register_giant_robot", 21000, 1, "int");
    clientfield::register("world", "start_anim_robot_0", 21000, 1, "int");
    clientfield::register("world", "start_anim_robot_1", 21000, 1, "int");
    clientfield::register("world", "start_anim_robot_2", 21000, 1, "int");
    clientfield::register("world", "play_foot_stomp_fx_robot_0", 21000, 2, "int");
    clientfield::register("world", "play_foot_stomp_fx_robot_1", 21000, 2, "int");
    clientfield::register("world", "play_foot_stomp_fx_robot_2", 21000, 2, "int");
    clientfield::register("world", "play_foot_open_fx_robot_0", 21000, 2, "int");
    clientfield::register("world", "play_foot_open_fx_robot_1", 21000, 2, "int");
    clientfield::register("world", "play_foot_open_fx_robot_2", 21000, 2, "int");
    clientfield::register("world", "eject_warning_fx_robot_0", 21000, 1, "int");
    clientfield::register("world", "eject_warning_fx_robot_1", 21000, 1, "int");
    clientfield::register("world", "eject_warning_fx_robot_2", 21000, 1, "int");
    clientfield::register("scriptmover", "light_foot_fx_robot", 21000, 2, "int");
    clientfield::register("allplayers", "eject_steam_fx", 21000, 1, "int");
    clientfield::register("allplayers", "all_tubes_play_eject_steam_fx", 21000, 1, "int");
    clientfield::register("allplayers", "gr_eject_player_impact_fx", 21000, 1, "int");
    clientfield::register("toplayer", "giant_robot_rumble_and_shake", 21000, 2, "int");
    clientfield::register("world", "church_ceiling_fxanim", 21000, 1, "int");
    level thread function_89fc4a1b();
    level thread function_eb3175d9();
    function_3c7db356();
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_3c7db356
// Checksum 0x1902f931, Offset: 0x15f0
// Size: 0x44
function function_3c7db356() {
    level.var_d7e51a9c = [];
    function_b86e86fa((-493, -198, 389), (0, 0, 0), 80, 64, -106);
}

// Namespace namespace_d1b0a244
// Params 5, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_b86e86fa
// Checksum 0x59dc2252, Offset: 0x1640
// Size: 0xe2
function function_b86e86fa(v_origin, v_angles, n_length, n_width, n_height) {
    trig = spawn("trigger_box", v_origin, 0, n_length, n_width, n_height);
    trig.angles = v_angles;
    if (!isdefined(level.var_d7e51a9c)) {
        level.var_d7e51a9c = [];
    } else if (!isarray(level.var_d7e51a9c)) {
        level.var_d7e51a9c = array(level.var_d7e51a9c);
    }
    level.var_d7e51a9c[level.var_d7e51a9c.size] = trig;
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_a27207b
// Checksum 0x70430052, Offset: 0x1730
// Size: 0x3a
function function_a27207b(player_down) {
    if (isdefined(player_down.var_33895e18) && player_down.var_33895e18) {
        return false;
    }
    return true;
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_89fc4a1b
// Checksum 0xebba9832, Offset: 0x1778
// Size: 0x6bc
function function_89fc4a1b() {
    while (!level flag::exists("start_zombie_round_logic")) {
        wait(0.5);
    }
    level flag::wait_till("start_zombie_round_logic");
    level.var_64f7be48 = [];
    for (i = 0; i < 3; i++) {
        level.var_a4d81f61[i] = 1;
        var_629e162f = getent("trig_stomp_kill_right_" + i, "targetname");
        var_d56716c0 = getent("trig_stomp_kill_left_" + i, "targetname");
        var_629e162f enablelinkto();
        var_d56716c0 enablelinkto();
        var_a0a20af9 = getent("clip_foot_right_" + i, "targetname");
        var_90e5bbaa = getent("clip_foot_left_" + i, "targetname");
        ai = getent("giant_robot_" + i, "targetname");
        ai setignorepauseworld(1);
        ai.v_start_origin = ai.origin;
        ai.var_7b846142 = 1;
        ai.var_582adcd3 = i;
        ai.ignore_enemy_count = 1;
        var_1265c28f = ai gettagorigin("TAG_ATTACH_HATCH_RI");
        var_6899c6b0 = ai gettagorigin("TAG_ATTACH_HATCH_LE");
        if (ai.targetname == "giant_robot_1") {
            n_offset = 80;
        } else {
            n_offset = 72;
        }
        var_629e162f.origin = var_1265c28f + (0, 0, n_offset);
        var_629e162f.angles = ai gettagangles("TAG_ATTACH_HATCH_RI");
        var_d56716c0.origin = var_6899c6b0 + (0, 0, n_offset);
        var_d56716c0.angles = ai gettagangles("TAG_ATTACH_HATCH_LE");
        wait(0.1);
        var_629e162f linkto(ai, "tag_attach_hatch_ri", (0, 0, n_offset));
        util::wait_network_frame();
        var_d56716c0 linkto(ai, "tag_attach_hatch_le", (0, 0, n_offset));
        util::wait_network_frame();
        ai.var_629e162f = var_629e162f;
        ai.var_d56716c0 = var_d56716c0;
        var_a0a20af9.origin = var_1265c28f + (0, 0, 0);
        var_90e5bbaa.origin = var_6899c6b0 + (0, 0, 0);
        var_a0a20af9.angles = ai gettagangles("TAG_ATTACH_HATCH_RI");
        var_90e5bbaa.angles = ai gettagangles("TAG_ATTACH_HATCH_LE");
        wait(0.1);
        var_a0a20af9 linkto(ai, "tag_attach_hatch_ri", (0, 0, 0));
        util::wait_network_frame();
        var_90e5bbaa linkto(ai, "tag_attach_hatch_le", (0, 0, 0));
        util::wait_network_frame();
        ai.var_a0a20af9 = var_a0a20af9;
        ai.var_90e5bbaa = var_90e5bbaa;
        ai.is_zombie = 0;
        ai.animname = "giant_robot_walker";
        ai.script_noteworthy = "giant_robot";
        ai.var_5be6d71c = "giant_robot";
        ai.ignoreall = 1;
        ai.ignoreme = 1;
        ai.ignore_game_over_death = 1;
        ai setcandamage(0);
        ai setplayercollision(1);
        ai setforcenocull();
        ai clientfield::set("register_giant_robot", 1);
        ai ghost();
        ai flag::init("robot_head_entered");
        ai flag::init("kill_trigger_active");
        level.var_64f7be48[i] = ai;
        util::wait_network_frame();
    }
    level thread function_f0c77781();
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_f0c77781
// Checksum 0x488b0eba, Offset: 0x1e40
// Size: 0x3da
function function_f0c77781() {
    var_bcef09c7 = 0;
    var_49d97e38 = -1;
    level thread function_1062d05a(1);
    level waittill(#"hash_69cd990");
    while (true) {
        if (!(level.round_number % 4) && var_bcef09c7 != level.round_number) {
            level flag::set("three_robot_round");
        }
        if (level flag::get("ee_all_staffs_placed") && !level flag::get("ee_mech_zombie_hole_opened")) {
            level flag::set("three_robot_round");
        }
        /#
            if (isdefined(level.var_5d69df3a) && level.var_5d69df3a) {
                level flag::set("giant_robot_head_exit_trigger");
            }
        #/
        if (level flag::get("three_robot_round")) {
            level.zombie_ai_limit = 22;
            var_86c0bc98 = randomint(3);
            if (var_86c0bc98 == 2 || level flag::get("all_robot_hatch")) {
                level thread function_764593e8(2);
            } else {
                level thread function_764593e8(2, 0);
            }
            wait(5);
            if (var_86c0bc98 == 0 || level flag::get("all_robot_hatch")) {
                level thread function_764593e8(0);
            } else {
                level thread function_764593e8(0, 0);
            }
            wait(5);
            if (var_86c0bc98 == 1 || level flag::get("all_robot_hatch")) {
                level thread function_764593e8(1);
            } else {
                level thread function_764593e8(1, 0);
            }
            level waittill(#"hash_e3719b6");
            level waittill(#"hash_e3719b6");
            level waittill(#"hash_e3719b6");
            wait(5);
            level.zombie_ai_limit = 24;
            var_bcef09c7 = level.round_number;
            var_49d97e38 = -1;
            level flag::clear("three_robot_round");
            continue;
        }
        if (!level flag::get("activate_zone_nml")) {
            var_86c0bc98 = randomint(2);
        } else {
            do {
                var_86c0bc98 = randomint(3);
            } while (var_86c0bc98 == var_49d97e38);
        }
        /#
            if (isdefined(level.var_1a66bae4)) {
                var_86c0bc98 = level.var_1a66bae4;
            }
        #/
        var_49d97e38 = var_86c0bc98;
        level thread function_764593e8(var_86c0bc98);
        level waittill(#"hash_e3719b6");
        wait(5);
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_1062d05a
// Checksum 0x501dd246, Offset: 0x2228
// Size: 0x1fe
function function_1062d05a(var_9a1bfdd4) {
    ai = getent("giant_robot_" + var_9a1bfdd4, "targetname");
    ai attach("veh_t7_zhd_robot_foot_hatch", "TAG_ATTACH_HATCH_LE");
    ai attach("veh_t7_zhd_robot_foot_hatch", "TAG_ATTACH_HATCH_RI");
    ai thread function_f264b734(ai.var_629e162f, ai.var_d56716c0, ai.var_a0a20af9, ai.var_90e5bbaa, undefined, 3);
    playsoundatposition("evt_footfall_robot_intro", (0, 0, 0));
    wait(0.5);
    exploder::exploder("fxexp_420");
    a_players = getplayers();
    foreach (player in a_players) {
        player clientfield::set_to_player("giant_robot_rumble_and_shake", 3);
        player thread function_6e58ffa7();
    }
    level waittill(#"hash_e3719b6");
    level notify(#"hash_69cd990");
}

// Namespace namespace_d1b0a244
// Params 2, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_764593e8
// Checksum 0xdc703171, Offset: 0x2430
// Size: 0x4e4
function function_764593e8(var_9a1bfdd4, var_1f19848b) {
    if (!isdefined(var_1f19848b)) {
        var_1f19848b = 1;
    }
    ai = getent("giant_robot_" + var_9a1bfdd4, "targetname");
    level.var_a4d81f61[var_9a1bfdd4] = 1;
    ai.var_1f19848b = var_1f19848b;
    ai flag::clear("kill_trigger_active");
    ai flag::clear("robot_head_entered");
    if (isdefined(ai.var_1f19848b) && ai.var_1f19848b) {
        var_4fb770ce = getent("target_sole_" + var_9a1bfdd4, "targetname");
    }
    if (isdefined(ai.var_1f19848b) && isdefined(var_4fb770ce) && ai.var_1f19848b) {
        var_4fb770ce setcandamage(1);
        var_4fb770ce.health = 99999;
        var_4fb770ce useanimtree(#generic);
        var_4fb770ce unlink();
    }
    wait(10);
    if (isdefined(var_4fb770ce)) {
        if (math::cointoss()) {
            ai.var_476c9a10 = "left";
        } else {
            ai.var_476c9a10 = "right";
        }
        /#
            if (isdefined(ai.var_1f19848b) && isdefined(level.var_f06a1a87) && ai.var_1f19848b) {
                ai.var_476c9a10 = level.var_f06a1a87;
            }
        #/
        if (ai.var_476c9a10 == "left") {
            var_c2a14d5c = ai gettagorigin("TAG_ATTACH_HATCH_LE");
            var_6b3e045a = ai gettagangles("TAG_ATTACH_HATCH_LE");
            ai.var_476c9a10 = "left";
            var_5d7886bf = "tag_attach_hatch_le";
            ai attach("veh_t7_zhd_robot_foot_hatch", "TAG_ATTACH_HATCH_RI");
        } else if (ai.var_476c9a10 == "right") {
            var_c2a14d5c = ai gettagorigin("TAG_ATTACH_HATCH_RI");
            var_6b3e045a = ai gettagangles("TAG_ATTACH_HATCH_RI");
            ai.var_476c9a10 = "right";
            var_5d7886bf = "tag_attach_hatch_ri";
            ai attach("veh_t7_zhd_robot_foot_hatch", "TAG_ATTACH_HATCH_LE");
        }
        var_4fb770ce.origin = var_c2a14d5c;
        var_4fb770ce.angles = var_6b3e045a;
        wait(0.1);
        var_4fb770ce linkto(ai, var_5d7886bf, (0, 0, 0));
        var_4fb770ce show();
    }
    if (!(isdefined(ai.var_1f19848b) && ai.var_1f19848b)) {
        ai attach("veh_t7_zhd_robot_foot_hatch", "TAG_ATTACH_HATCH_RI");
        ai attach("veh_t7_zhd_robot_foot_hatch", "TAG_ATTACH_HATCH_LE");
    }
    wait(0.05);
    ai thread function_f264b734(ai.var_629e162f, ai.var_d56716c0, ai.var_a0a20af9, ai.var_90e5bbaa, var_4fb770ce, var_9a1bfdd4);
}

// Namespace namespace_d1b0a244
// Params 6, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_f264b734
// Checksum 0xb63f876, Offset: 0x2920
// Size: 0x5ba
function function_f264b734(var_629e162f, var_d56716c0, var_a0a20af9, var_90e5bbaa, var_4fb770ce, var_9a1bfdd4) {
    self thread function_f63ffb82(var_9a1bfdd4);
    if (isdefined(self.var_1f19848b) && isdefined(self.var_476c9a10) && self.var_1f19848b) {
        switch (self.var_476c9a10) {
        case 57:
            self clientfield::set("light_foot_fx_robot", 1);
            break;
        case 58:
            self clientfield::set("light_foot_fx_robot", 2);
            break;
        default:
            self clientfield::set("light_foot_fx_robot", 0);
            break;
        }
    } else {
        self clientfield::set("light_foot_fx_robot", 0);
    }
    self show();
    if (isdefined(var_4fb770ce)) {
        self thread function_33a623b7(var_4fb770ce);
    }
    self.var_614b2431 = 1;
    self thread monitor_footsteps(var_629e162f, "right");
    self thread monitor_footsteps(var_d56716c0, "left");
    self thread function_a6f9605a(var_629e162f, "right");
    self thread function_a6f9605a(var_d56716c0, "left");
    self thread function_f6ff773b("right");
    self thread function_f6ff773b("left");
    self thread function_2c34b810("left");
    self thread function_2c34b810("right");
    if (isdefined(self.var_1f19848b) && isdefined(var_4fb770ce) && level.var_a4d81f61[var_9a1bfdd4] && self.var_1f19848b) {
        self thread function_8f82b5c2(var_4fb770ce);
    }
    a_players = getplayers();
    if (var_9a1bfdd4 != 3 && !(isdefined(level.var_ba0a4cee) && level.var_ba0a4cee)) {
        foreach (player in a_players) {
            player thread function_5260b944(self);
        }
    } else if (level flag::get("three_robot_round") && !(isdefined(level.var_7e49b357) && level.var_7e49b357)) {
        foreach (player in a_players) {
            player thread function_7e49b357(self);
        }
    }
    if (var_9a1bfdd4 != 3 && !(isdefined(level.var_92d5ed2f) && level.var_92d5ed2f)) {
        foreach (player in a_players) {
            player thread function_b52e0869(self);
        }
    }
    self waittill(#"hash_9132f14c");
    self.var_614b2431 = 0;
    self stopanimscripted();
    self.origin = self.v_start_origin;
    level clientfield::set("play_foot_open_fx_robot_" + self.var_582adcd3, 0);
    self clientfield::set("light_foot_fx_robot", 0);
    self ghost();
    self detachall();
    level notify(#"hash_e3719b6");
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_33a623b7
// Checksum 0xee1632a3, Offset: 0x2ee8
// Size: 0xac
function function_33a623b7(var_4fb770ce) {
    self endon(#"death");
    self endon(#"hash_9132f14c");
    util::wait_network_frame();
    var_4fb770ce clearanim(generic%root, 0);
    util::wait_network_frame();
    var_4fb770ce animscripted("hatch_anim", var_4fb770ce.origin, var_4fb770ce.angles, "ai_zm_dlc5_zombie_giant_robot_hatch_close");
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_8f82b5c2
// Checksum 0xc907a567, Offset: 0x2fa0
// Size: 0x244
function function_8f82b5c2(var_4fb770ce) {
    self endon(#"death");
    self endon(#"hash_9132f14c");
    if (isdefined(self.var_476c9a10) && self.var_476c9a10 == "left") {
        str_tag = "TAG_ATTACH_HATCH_LE";
        var_19a442f8 = 2;
    } else if (isdefined(self.var_476c9a10) && self.var_476c9a10 == "right") {
        str_tag = "TAG_ATTACH_HATCH_RI";
        var_19a442f8 = 1;
    }
    self waittill(#"hash_5ebbf30b");
    wait(1);
    amount, inflictor, direction, point, type, tagname, modelname, partname, weaponname, idflags = var_4fb770ce waittill(#"damage");
    var_4fb770ce.health = 99999;
    level.var_a4d81f61[self.var_582adcd3] = 0;
    level clientfield::set("play_foot_open_fx_robot_" + self.var_582adcd3, var_19a442f8);
    var_4fb770ce animscripted("hatch_anim", var_4fb770ce.origin, var_4fb770ce.angles, "ai_zm_dlc5_zombie_giant_robot_hatch_open");
    n_time = getanimlength(generic%ai_zm_dlc5_zombie_giant_robot_hatch_open);
    wait(n_time);
    var_4fb770ce animscripted("hatch_anim", var_4fb770ce.origin, var_4fb770ce.angles, "ai_zm_dlc5_zombie_giant_robot_hatch_open_idle");
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_bfa9d5a6
// Checksum 0x7a48f540, Offset: 0x31f0
// Size: 0xfc
function function_bfa9d5a6(var_87652dc9) {
    level endon(#"intermission");
    wait(5);
    level.var_a4d81f61[self.var_582adcd3] = 1;
    level clientfield::set("play_foot_open_fx_robot_" + self.var_582adcd3, 0);
    var_4fb770ce = getent("target_sole_" + self.var_582adcd3, "targetname");
    if (isdefined(var_4fb770ce)) {
        var_4fb770ce animscripted("hatch_anim", var_4fb770ce.origin, var_4fb770ce.angles, "ai_zm_dlc5_zombie_giant_robot_hatch_close");
        self clientfield::set("light_foot_fx_robot", 0);
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_f63ffb82
// Checksum 0x5b9bf4cf, Offset: 0x32f8
// Size: 0x23c
function function_f63ffb82(var_9a1bfdd4) {
    if (var_9a1bfdd4 != 3) {
        level clientfield::set("start_anim_robot_" + var_9a1bfdd4, 1);
        self thread function_ae0e6ab0(var_9a1bfdd4);
    }
    if (var_9a1bfdd4 == 0) {
        level scene::play("cin_tomb_giant_robot_walk_nml_intro", self);
        level scene::play("cin_tomb_giant_robot_walk_nml", self);
        level scene::play("cin_tomb_giant_robot_walk_nml_outtro", self);
        self notify(#"hash_9132f14c");
    } else if (var_9a1bfdd4 == 1) {
        level scene::play("cin_tomb_giant_robot_walk_trenches_intro", self);
        level scene::play("cin_tomb_giant_robot_walk_trenches", self);
        level scene::play("cin_tomb_giant_robot_walk_trenches_outtro", self);
        self notify(#"hash_9132f14c");
    } else if (var_9a1bfdd4 == 2) {
        level scene::play("cin_tomb_giant_robot_walk_village_intro", self);
        level scene::play("cin_tomb_giant_robot_walk_village", self);
        level scene::play("cin_tomb_giant_robot_walk_village_outtro", self);
        self notify(#"hash_9132f14c");
    } else if (var_9a1bfdd4 == 3) {
        level scene::play("cin_tomb_giant_robot_bunker_intro", self);
        self notify(#"hash_9132f14c");
    }
    if (var_9a1bfdd4 != 3) {
        level clientfield::set("start_anim_robot_" + var_9a1bfdd4, 0);
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_2c34b810
// Checksum 0xcb27e9ed, Offset: 0x3540
// Size: 0x6c
function function_2c34b810(side) {
    self thread function_6faf6f76("soundfootstart_" + side, "zmb_robot_leg_move_" + side, side);
    self thread function_6faf6f76("soundfootwarning_" + side, "zmb_robot_foot_alarm", side);
}

// Namespace namespace_d1b0a244
// Params 3, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_6faf6f76
// Checksum 0xe7a7f379, Offset: 0x35b8
// Size: 0x110
function function_6faf6f76(notetrack, alias, side) {
    self endon(#"hash_9132f14c");
    if (side == "right") {
        str_tag = "TAG_ATTACH_HATCH_RI";
    } else if (side == "left") {
        str_tag = "TAG_ATTACH_HATCH_LE";
    }
    while (true) {
        self waittill(notetrack);
        if (notetrack == "soundfootstart_left" || notetrack == "soundfootstart_right") {
            self thread function_2124e9c6(1, str_tag, side);
        } else if (notetrack == "soundfootwarning_left" || notetrack == "soundfootwarning_right") {
            self thread function_2124e9c6(0, str_tag, side);
        }
        wait(0.1);
    }
}

// Namespace namespace_d1b0a244
// Params 3, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_2124e9c6
// Checksum 0x3945a973, Offset: 0x36d0
// Size: 0x13c
function function_2124e9c6(startmove, str_tag, side) {
    if (startmove) {
        self playsoundontag("zmb_robot_leg_move_" + side, str_tag);
        wait(1.1);
        self playsoundontag("zmb_robot_foot_alarm", str_tag);
        wait(0.7);
        self playsoundontag("zmb_robot_pre_stomp_a", str_tag);
        wait(0.6);
        self playsoundontag("zmb_robot_leg_whoosh", str_tag);
        return;
    }
    self playsoundontag("zmb_robot_foot_alarm", str_tag);
    wait(0.7);
    self playsoundontag("zmb_robot_pre_stomp_a", str_tag);
    wait(0.6);
    self playsoundontag("zmb_robot_leg_whoosh", str_tag);
}

// Namespace namespace_d1b0a244
// Params 2, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_9f8e6c2d
// Checksum 0x3e5fd460, Offset: 0x3818
// Size: 0x148
function monitor_footsteps(var_37fea218, var_87652dc9) {
    self endon(#"death");
    self endon(#"hash_9132f14c");
    var_e7155cd1 = "kill_zombies_" + var_87652dc9 + "foot_1";
    var_df51e12e = "footstep_" + var_87652dc9 + "_large";
    while (true) {
        self waittillmatch(var_e7155cd1);
        self thread function_daf41dde(var_37fea218, 1, var_87652dc9);
        self waittillmatch(var_df51e12e);
        if (self.var_582adcd3 == 0 && var_87652dc9 == "left") {
            self thread function_80969c0b();
        } else if (self.var_582adcd3 == 1 && var_87652dc9 == "left") {
            self thread function_3c4e3a51();
        }
        wait(0.5);
        self thread function_daf41dde(var_37fea218, 0, var_87652dc9);
    }
}

// Namespace namespace_d1b0a244
// Params 2, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_a6f9605a
// Checksum 0x6073e67b, Offset: 0x3968
// Size: 0x170
function function_a6f9605a(var_37fea218, var_87652dc9) {
    self endon(#"death");
    self endon(#"hash_9132f14c");
    var_df51e12e = "footstep_" + var_87652dc9 + "_large";
    while (true) {
        level clientfield::set("play_foot_stomp_fx_robot_" + self.var_582adcd3, 0);
        self waittillmatch(var_df51e12e);
        if (var_87652dc9 == "right") {
            level clientfield::set("play_foot_stomp_fx_robot_" + self.var_582adcd3, 1);
        } else {
            level clientfield::set("play_foot_stomp_fx_robot_" + self.var_582adcd3, 2);
        }
        var_37fea218 thread function_c4f4ddb3(self);
        if (self.var_582adcd3 == 2) {
            self thread function_fd1be446(var_87652dc9);
        } else if (self.var_582adcd3 == 0) {
            self thread function_8d673f04(var_87652dc9);
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_f6ff773b
// Checksum 0xaf63c2cc, Offset: 0x3ae0
// Size: 0x58
function function_f6ff773b(var_87652dc9) {
    self endon(#"death");
    self endon(#"hash_9132f14c");
    while (true) {
        self waittillmatch("shadow_" + var_87652dc9);
        function_d3460cf5(var_87652dc9);
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_c4f4ddb3
// Checksum 0xaac74f11, Offset: 0x3b40
// Size: 0x232
function function_c4f4ddb3(robot) {
    a_players = getplayers();
    wait(0.2);
    foreach (player in a_players) {
        if (zombie_utility::is_player_valid(player)) {
            if (isdefined(player.var_caac9938)) {
                if (isdefined(player.var_66476b55) && player.var_66476b55) {
                    continue;
                }
                if (player.var_caac9938 == robot.var_582adcd3) {
                    player clientfield::set_to_player("giant_robot_rumble_and_shake", 2);
                } else {
                    continue;
                }
            } else {
                dist = distance(player.origin, self.origin);
                if (dist < 1500) {
                    player clientfield::set_to_player("giant_robot_rumble_and_shake", 3);
                    level notify(#"hash_d7b83fdc", player);
                } else if (dist < 3000) {
                    player clientfield::set_to_player("giant_robot_rumble_and_shake", 2);
                } else if (dist < 6000) {
                    player clientfield::set_to_player("giant_robot_rumble_and_shake", 1);
                } else {
                    continue;
                }
            }
            player thread function_6e58ffa7();
        }
    }
}

// Namespace namespace_d1b0a244
// Params 3, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_daf41dde
// Checksum 0x7f03d9dd, Offset: 0x3d80
// Size: 0x114
function function_daf41dde(var_f97acb85, b_flag, var_87652dc9) {
    if (!isdefined(var_87652dc9)) {
        var_87652dc9 = undefined;
    }
    if (b_flag) {
        self flag::set("kill_trigger_active");
        var_f97acb85 thread function_3b8ac5d4(self, var_87652dc9);
        return;
    }
    self flag::clear("kill_trigger_active");
    level notify(#"hash_d7f76c14");
    if (self flag::get("robot_head_entered")) {
        self flag::clear("robot_head_entered");
        self thread function_bfa9d5a6(var_87652dc9);
        level thread function_6e9ca2fc(self.var_582adcd3);
    }
}

// Namespace namespace_d1b0a244
// Params 2, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_3b8ac5d4
// Checksum 0x2b6e121b, Offset: 0x3ea0
// Size: 0xaec
function function_3b8ac5d4(robot, var_87652dc9) {
    level endon(#"hash_d7f76c14");
    if (var_87652dc9 == "left") {
        var_dccde714 = "TAG_ATTACH_HATCH_LE";
    } else if (var_87652dc9 == "right") {
        var_dccde714 = "TAG_ATTACH_HATCH_RI";
    }
    while (robot flag::get("kill_trigger_active")) {
        a_zombies = getaispeciesarray(level.zombie_team, "all");
        var_7aa21f35 = [];
        foreach (zombie in a_zombies) {
            if (distancesquared(zombie.origin, self.origin) < 360000) {
                if (isdefined(zombie.var_7b846142) && zombie.var_7b846142) {
                    continue;
                }
                if (isdefined(zombie.marked_for_death) && zombie.marked_for_death) {
                    continue;
                }
                if (isdefined(zombie.var_287205b2) && zombie.var_287205b2) {
                    continue;
                }
                if (zombie istouching(self)) {
                    if (isdefined(zombie.is_mechz) && zombie.is_mechz) {
                        zombie thread namespace_baebcb1::function_3f19350b();
                        continue;
                    }
                    zombie setgoalpos(zombie.origin);
                    zombie.marked_for_death = 1;
                    var_7aa21f35[var_7aa21f35.size] = zombie;
                    continue;
                }
                if (isdefined(zombie.completed_emerging_into_playable_area) && !(isdefined(zombie.is_mechz) && zombie.is_mechz) && !(isdefined(zombie.missinglegs) && zombie.missinglegs) && zombie.completed_emerging_into_playable_area) {
                    var_bb0297f9 = zombie.origin[2];
                    var_5328e21a = robot gettagorigin(var_dccde714);
                    var_6fdbc659 = var_5328e21a[2];
                    z_diff = abs(var_bb0297f9 - var_6fdbc659);
                    if (z_diff <= 100) {
                        zombie.var_36a949c6 = self.origin;
                        zombie animcustom(&namespace_c70bea9a::function_60897a18);
                    }
                }
            }
        }
        if (var_7aa21f35.size > 0) {
            level thread function_89b7808e(robot, var_7aa21f35);
            robot thread function_9bb14cac(var_87652dc9);
        }
        if (isdefined(level.var_461e417)) {
            if (level.var_461e417 istouching(self)) {
                level.var_461e417 thread function_2fc8fe95();
            }
        }
        var_4bae9c = getentarray("foot_box", "script_noteworthy");
        foreach (var_e32cd584 in var_4bae9c) {
            if (var_e32cd584 istouching(self)) {
                var_e32cd584 notify(#"hash_d1aaf42c");
            }
        }
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (zombie_utility::is_player_valid(players[i], 0, 1)) {
                if (!players[i] istouching(self)) {
                    continue;
                }
                if (players[i] function_584f7028()) {
                    continue;
                }
                if (isdefined(players[i].var_caac9938)) {
                    continue;
                }
                if (isdefined(players[i].var_33895e18) && players[i].var_33895e18) {
                    continue;
                }
                if (isdefined(robot.var_1f19848b) && !level.var_a4d81f61[robot.var_582adcd3] && isdefined(robot.var_476c9a10) && robot.var_1f19848b && issubstr(self.targetname, robot.var_476c9a10) && !self laststand::player_is_in_laststand()) {
                    players[i].ignoreme = 1;
                    players[i].var_4fea0f8a = self.origin;
                    players[i].var_b605c6c3 = 0;
                    if (robot.var_582adcd3 == 0) {
                        level thread namespace_97bec092::function_67bfec1a("head_0_teleport_player", players[i], 2, 0);
                        players[i].var_caac9938 = 0;
                    } else if (robot.var_582adcd3 == 1) {
                        level thread namespace_97bec092::function_67bfec1a("head_1_teleport_player", players[i], 2, 0);
                        players[i].var_caac9938 = 1;
                        if (players[i] zm_zonemgr::entity_in_zone("zone_bunker_4d") || players[i] zm_zonemgr::entity_in_zone("zone_bunker_4c")) {
                            players[i].var_9c02558d = 1;
                        }
                    } else {
                        level thread namespace_97bec092::function_67bfec1a("head_2_teleport_player", players[i], 2, 0);
                        players[i].var_caac9938 = 2;
                    }
                    robot flag::set("robot_head_entered");
                    players[i] playsoundtoplayer("zmb_bot_elevator_ride_up", players[i]);
                    var_bd0b4e79 = 0;
                    var_b43c0f4b = 4;
                    fade_in_time = 0.01;
                    fade_out_time = 0.2;
                    players[i] thread hud::fade_to_black_for_x_sec(var_bd0b4e79, var_b43c0f4b, fade_in_time, fade_out_time, "white");
                    var_efef78db = var_bd0b4e79 + var_b43c0f4b + fade_in_time + fade_out_time;
                    n_start_time = var_bd0b4e79 + fade_in_time;
                    players[i] thread function_52e2bb38(n_start_time);
                    players[i] thread function_628cd169(var_efef78db);
                    players[i] thread function_55b8cc10();
                    continue;
                }
                if (isdefined(players[i].var_b5843b10["has_helmet"]) && players[i].var_b5843b10["has_helmet"]) {
                    players[i] thread function_43e5f9cf(robot);
                } else {
                    players[i] thread function_4380977b(robot);
                }
                var_bd0b4e79 = 0;
                var_b43c0f4b = 5;
                fade_in_time = 0.01;
                fade_out_time = 0.2;
                players[i] thread hud::fade_to_black_for_x_sec(var_bd0b4e79, var_b43c0f4b, fade_in_time, fade_out_time, "black");
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_584f7028
// Checksum 0x89480cab, Offset: 0x4998
// Size: 0xbe
function function_584f7028() {
    var_7eaf799 = 0;
    if (isdefined(level.var_d7e51a9c)) {
        foreach (e_volume in level.var_d7e51a9c) {
            if (self istouching(e_volume)) {
                var_7eaf799 = 1;
                break;
            }
        }
    }
    return var_7eaf799;
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_4380977b
// Checksum 0xeb9cf74, Offset: 0x4a60
// Size: 0x124
function function_4380977b(robot) {
    self endon(#"death");
    self endon(#"disconnect");
    self.var_33895e18 = 1;
    self playsound("zmb_zombie_arc");
    self freezecontrols(1);
    if (self laststand::player_is_in_laststand()) {
        self shellshock("explosion", 7);
    } else {
        self dodamage(self.health, self.origin, robot);
    }
    wait(5);
    self.var_33895e18 = 0;
    if (!(isdefined(self.hostmigrationcontrolsfrozen) && self.hostmigrationcontrolsfrozen)) {
        self freezecontrols(0);
    }
    self thread function_c4ed83dc();
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_43e5f9cf
// Checksum 0x599f6c07, Offset: 0x4b90
// Size: 0x164
function function_43e5f9cf(robot) {
    self endon(#"death");
    self endon(#"disconnect");
    self.var_33895e18 = 1;
    self notify(#"hash_e2be4752");
    self playsound("zmb_zombie_arc");
    self freezecontrols(1);
    self zm_utility::function_139befeb();
    self setstance("prone");
    self shellshock("explosion", 7);
    wait(5);
    self.var_33895e18 = 0;
    if (!(isdefined(self.hostmigrationcontrolsfrozen) && self.hostmigrationcontrolsfrozen)) {
        self freezecontrols(0);
    }
    if (!(isdefined(self.var_51fad791) && self.var_51fad791)) {
        self zm_audio::create_and_play_dialog("general", "robot_crush_golden");
        self.var_51fad791 = 1;
    }
    self zm_utility::function_36f941b3();
}

// Namespace namespace_d1b0a244
// Params 2, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_89b7808e
// Checksum 0x8a3c586e, Offset: 0x4d00
// Size: 0x27e
function function_89b7808e(robot, var_7aa21f35) {
    n_interval = 0;
    for (i = 0; i < var_7aa21f35.size; i++) {
        zombie = var_7aa21f35[i];
        if (!isdefined(zombie) || !isalive(zombie)) {
            continue;
        }
        if (!(isdefined(zombie.exclude_cleanup_adding_to_total) && zombie.exclude_cleanup_adding_to_total)) {
            level.zombie_total++;
            level.zombie_respawns++;
            if (zombie.health < zombie.maxhealth) {
                if (!isdefined(level.var_5a487977[zombie.archetype])) {
                    level.var_5a487977[zombie.archetype] = [];
                }
                if (!isdefined(level.var_5a487977[zombie.archetype])) {
                    level.var_5a487977[zombie.archetype] = [];
                } else if (!isarray(level.var_5a487977[zombie.archetype])) {
                    level.var_5a487977[zombie.archetype] = array(level.var_5a487977[zombie.archetype]);
                }
                level.var_5a487977[zombie.archetype][level.var_5a487977[zombie.archetype].size] = zombie.health;
            }
        }
        zombie zombie_utility::reset_attack_spot();
        zombie dodamage(zombie.health, zombie.origin, robot);
        n_interval++;
        if (n_interval >= 4) {
            util::wait_network_frame();
            n_interval = 0;
        }
    }
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_2fc8fe95
// Checksum 0xfbb8d933, Offset: 0x4f88
// Size: 0x24
function function_2fc8fe95() {
    self endon(#"death");
    self delete();
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_80969c0b
// Checksum 0x9c1ca3cd, Offset: 0x4fb8
// Size: 0xae
function function_80969c0b() {
    s_org = struct::get("wind_tunnel_bunker", "script_noteworthy");
    var_394708d0 = self gettagorigin("TAG_ATTACH_HATCH_LE");
    if (distance2dsquared(s_org.origin, var_394708d0) < 57600) {
        level notify(#"hash_81d11860");
        wait(5);
        level notify(#"hash_57bd250e");
    }
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_3c4e3a51
// Checksum 0x616fd7fe, Offset: 0x5070
// Size: 0xae
function function_3c4e3a51() {
    s_org = struct::get("tank_bunker", "script_noteworthy");
    var_394708d0 = self gettagorigin("TAG_ATTACH_HATCH_LE");
    if (distance2dsquared(s_org.origin, var_394708d0) < 57600) {
        level notify(#"hash_10bac2c6");
        wait(5);
        level notify(#"hash_1e4d457c");
    }
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_a37f89ca
// Checksum 0x1fe04774, Offset: 0x5128
// Size: 0xe0
function function_a37f89ca() {
    e_collision = getent("clip_foot_bottom_wind", "targetname");
    e_collision notsolid();
    e_collision connectpaths();
    while (true) {
        level waittill(#"hash_81d11860");
        wait(0.1);
        e_collision solid();
        e_collision disconnectpaths();
        level waittill(#"hash_57bd250e");
        e_collision notsolid();
        e_collision connectpaths();
    }
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_6492173
// Checksum 0x66d31bf3, Offset: 0x5210
// Size: 0xe0
function function_6492173() {
    e_collision = getent("clip_foot_bottom_tank", "targetname");
    e_collision notsolid();
    e_collision connectpaths();
    while (true) {
        level waittill(#"hash_10bac2c6");
        wait(0.1);
        e_collision solid();
        e_collision disconnectpaths();
        level waittill(#"hash_1e4d457c");
        e_collision notsolid();
        e_collision connectpaths();
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_fd1be446
// Checksum 0x1cd67f34, Offset: 0x52f8
// Size: 0x134
function function_fd1be446(var_87652dc9) {
    if (var_87652dc9 == "left") {
        var_e1f8690a = self gettagorigin("TAG_ATTACH_HATCH_LE");
    } else {
        var_e1f8690a = self gettagorigin("TAG_ATTACH_HATCH_RI");
    }
    var_be7d462 = struct::get("giant_robot_church_marker", "targetname");
    n_distance = distance2dsquared(var_e1f8690a, var_be7d462.origin);
    if (n_distance < 1000000) {
        level clientfield::set("church_ceiling_fxanim", 1);
        util::wait_network_frame();
        level clientfield::set("church_ceiling_fxanim", 0);
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_8d673f04
// Checksum 0x7ce42c72, Offset: 0x5438
// Size: 0x104
function function_8d673f04(var_87652dc9) {
    if (var_87652dc9 == "left") {
        var_e1f8690a = self gettagorigin("TAG_ATTACH_HATCH_LE");
    } else {
        var_e1f8690a = self gettagorigin("TAG_ATTACH_HATCH_RI");
    }
    s_pap = struct::get("giant_robot_pap_marker", "targetname");
    wait(0.2);
    n_distance = distance2dsquared(var_e1f8690a, s_pap.origin);
    if (n_distance < 2250000) {
        level clientfield::increment("pap_monolith_ring_shake");
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_52e2bb38
// Checksum 0x3b157b64, Offset: 0x5548
// Size: 0x84
function function_52e2bb38(n_start_time) {
    self endon(#"death");
    self endon(#"disconnect");
    self.var_66476b55 = 1;
    self.dontspeak = 1;
    self clientfield::set_to_player("giant_robot_rumble_and_shake", 3);
    wait(1.5);
    self clientfield::set_to_player("player_rumble_and_shake", 4);
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_628cd169
// Checksum 0xb2b8ed62, Offset: 0x55d8
// Size: 0x118
function function_628cd169(var_efef78db) {
    self endon(#"death");
    self endon(#"disconnect");
    wait(var_efef78db);
    self clientfield::set_to_player("player_rumble_and_shake", 0);
    self clientfield::set_to_player("giant_robot_rumble_and_shake", 0);
    self.var_66476b55 = 0;
    wait(2);
    if (!level flag::get("story_vo_playing")) {
        self.dontspeak = 0;
        self zm_audio::create_and_play_dialog("general", "enter_robot");
    }
    if (!isdefined(level.var_cc40ae19) || level.var_cc40ae19 == 0) {
        level.var_cc40ae19 = 4;
        level thread namespace_54a425fe::function_5f9c184e("zone_robot_head");
        return;
    }
    level.var_cc40ae19--;
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_3ec1bfe6
// Checksum 0x9c7eb815, Offset: 0x56f8
// Size: 0x1c4
function function_3ec1bfe6(s_origin) {
    s_origin.unitrigger_stub = spawnstruct();
    s_origin.unitrigger_stub.origin = s_origin.origin;
    s_origin.unitrigger_stub.radius = 36;
    s_origin.unitrigger_stub.height = 256;
    s_origin.unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
    s_origin.unitrigger_stub.hint_string = %ZM_TOMB_EHT;
    s_origin.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_origin.unitrigger_stub.require_look_at = 1;
    s_origin.unitrigger_stub.target = s_origin.target;
    s_origin.unitrigger_stub.script_int = s_origin.script_int;
    s_origin.unitrigger_stub.is_available = 1;
    s_origin.unitrigger_stub.prompt_and_visibility_func = &function_42f46193;
    zm_unitrigger::unitrigger_force_per_player_triggers(s_origin.unitrigger_stub, 1);
    zm_unitrigger::register_static_unitrigger(s_origin.unitrigger_stub, &function_256b8200);
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_42f46193
// Checksum 0x8b337e3c, Offset: 0x58c8
// Size: 0x8a
function function_42f46193(player) {
    b_is_invis = !(isdefined(self.stub.is_available) && self.stub.is_available);
    self setinvisibletoplayer(player, b_is_invis);
    self sethintstring(self.stub.hint_string);
    return !b_is_invis;
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_1d2e5a7b
// Checksum 0xf87c40d4, Offset: 0x5960
// Size: 0x44
function function_1d2e5a7b() {
    zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
    zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &function_256b8200);
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_256b8200
// Checksum 0xe2b47d6a, Offset: 0x59b0
// Size: 0xcc
function function_256b8200() {
    self endon(#"hash_337b06b9");
    while (true) {
        player = self waittill(#"trigger");
        if (!(isdefined(self.stub.is_available) && self.stub.is_available)) {
            continue;
        }
        if (!isplayer(player) || !zombie_utility::is_player_valid(player)) {
            continue;
        }
        level thread function_2a223f4(self.stub, player);
        self.stub.is_available = 0;
    }
}

// Namespace namespace_d1b0a244
// Params 3, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_2a223f4
// Checksum 0x2d20d0e7, Offset: 0x5a88
// Size: 0x258
function function_2a223f4(s_unitrigger, player, b_timeout) {
    if (!isdefined(b_timeout)) {
        b_timeout = 0;
    }
    s_unitrigger.is_available = 0;
    s_origin = struct::get(s_unitrigger.target, "targetname");
    v_origin = s_origin.origin;
    v_angles = s_origin.angles;
    var_ea13cab5 = spawn_model("tag_origin", v_origin, v_angles);
    if (isdefined(level.var_f4eacae0)) {
        player thread [[ level.var_f4eacae0 ]](var_ea13cab5, s_origin.script_noteworthy, b_timeout);
    } else {
        player thread function_60541037(var_ea13cab5, s_origin.script_noteworthy, b_timeout);
    }
    var_2f1fc889 = player zm_clone::spawn_player_clone(player, player.origin, undefined);
    player thread function_56b8e9d5(var_ea13cab5, var_2f1fc889);
    var_2f1fc889 linkto(var_ea13cab5);
    var_2f1fc889.ignoreme = 1;
    var_2f1fc889 show();
    var_2f1fc889 detachall();
    var_2f1fc889 setvisibletoall();
    var_2f1fc889 setinvisibletoplayer(player);
    var_2f1fc889 thread function_fd52e3c3(var_ea13cab5);
    var_ea13cab5 waittill(#"movedone");
    wait(6);
    s_unitrigger.is_available = 1;
}

// Namespace namespace_d1b0a244
// Params 3, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_60541037
// Checksum 0xd3dff206, Offset: 0x5ce8
// Size: 0x7e4
function function_60541037(var_ea13cab5, var_6fc9c53, b_timeout) {
    if (!isdefined(b_timeout)) {
        b_timeout = 0;
    }
    level endon(#"intermission");
    self endon(#"hash_3f7b661c");
    w_current_weapon = self getcurrentweapon();
    self disableweapons();
    self disableoffhandweapons();
    self enableinvulnerability();
    self setstance("stand");
    self allowstand(1);
    self allowcrouch(0);
    self allowprone(0);
    self playerlinktodelta(var_ea13cab5, "tag_origin", 1, 20, 20, 20, 20);
    self setplayerangles(var_ea13cab5.angles);
    self.dontspeak = 1;
    self clientfield::set_to_player("isspeaking", 1);
    self notify(#"teleport");
    self.var_66476b55 = 1;
    self playsoundtoplayer("zmb_bot_timeout_alarm", self);
    self.old_angles = self.angles;
    if (!b_timeout) {
        self clientfield::set("eject_steam_fx", 1);
        self thread function_a5c5c0db();
        wait(3);
    }
    self stopsounds();
    util::wait_network_frame();
    self playsoundtoplayer("zmb_giantrobot_exit", self);
    self notify(#"hash_48926c19");
    self thread function_bdf1e161();
    var_ea13cab5 moveto(var_ea13cab5.origin + (0, 0, 2000), 2.5);
    self thread hud::fade_to_black_for_x_sec(0, 2, 0.5, 0, "white");
    wait(1);
    var_ea13cab5 moveto(self.var_4fea0f8a + (0, 0, 3000), 0.05);
    self thread scene::play("cin_zm_gen_player_fall_loop", self);
    self setinvisibletoall();
    self setvisibletoplayer(self);
    wait(1);
    self playsoundtoplayer("zmb_giantrobot_fall", self);
    self playerlinktodelta(var_ea13cab5, "tag_origin", 1, -76, -76, 20, 20);
    var_ea13cab5 moveto(self.var_4fea0f8a, 3, 1);
    var_ea13cab5 thread function_8f9ab8f5(self);
    var_ea13cab5 notify(#"hash_8214766e");
    self thread function_7f3680bf();
    wait(2.85);
    self thread hud::fade_to_black_for_x_sec(0, 1, 0, 0.5, "black");
    self waittill(#"hash_b576929e");
    self setvisibletoall();
    self enableweapons();
    if (isdefined(w_current_weapon) && w_current_weapon != level.weaponnone) {
        self switchtoweaponimmediate(w_current_weapon);
    }
    self enableoffhandweapons();
    self unlink();
    var_ea13cab5 delete();
    self function_6fbb7deb();
    level scene::stop("cin_zm_gen_player_fall_loop");
    self show();
    self setplayerangles(self.old_angles);
    self disableinvulnerability();
    self.dontspeak = 0;
    self allowstand(1);
    self allowcrouch(1);
    self allowprone(1);
    self clientfield::set_to_player("isspeaking", 0);
    self.var_caac9938 = undefined;
    self.var_4fea0f8a = undefined;
    self.old_angles = undefined;
    self.var_b605c6c3 = 1;
    self thread function_9df817c8();
    self thread function_d5cc02d6();
    self clientfield::set("eject_steam_fx", 0);
    var_2d08c90c = 2.5;
    self setstance("prone");
    self shellshock("explosion", var_2d08c90c);
    self.var_66476b55 = 0;
    self notify(#"hash_b03c4326");
    if (!level flag::get("story_vo_playing")) {
        self util::delay(3, undefined, &zm_audio::create_and_play_dialog, "general", "air_chute_landing");
    }
    /#
        var_f0931f09 = getdvarint("giant_robot_head_exit_trigger");
        if (isdefined(var_f0931f09) && var_f0931f09) {
            self enableinvulnerability();
        }
    #/
    wait(var_2d08c90c);
    self.ignoreme = 0;
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_7f3680bf
// Checksum 0x6c140823, Offset: 0x64d8
// Size: 0x64
function function_7f3680bf() {
    self endon(#"disconnect");
    self stopsounds();
    util::wait_network_frame();
    self playsoundtoplayer("vox_plr_" + self.characterindex + "_exit_robot_0", self);
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_fd52e3c3
// Checksum 0x3f59d8e1, Offset: 0x6548
// Size: 0x7c
function function_fd52e3c3(var_ea13cab5) {
    var_ea13cab5 waittill(#"hash_8214766e");
    self thread scene::play("cin_zm_dlc1_jump_pad_air_loop", self);
    var_ea13cab5 waittill(#"movedone");
    self thread scene::stop("cin_zm_dlc1_jump_pad_air_loop");
    self delete();
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_a5c5c0db
// Checksum 0x11d1d2b8, Offset: 0x65d0
// Size: 0x98
function function_a5c5c0db() {
    self endon(#"hash_48926c19");
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        self clientfield::set_to_player("giant_robot_rumble_and_shake", 1);
        util::wait_network_frame();
        self clientfield::set_to_player("giant_robot_rumble_and_shake", 0);
        util::wait_network_frame();
        wait(0.1);
    }
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_bdf1e161
// Checksum 0x3a96ebed, Offset: 0x6670
// Size: 0x98
function function_bdf1e161() {
    self endon(#"hash_48c54e97");
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        self clientfield::set_to_player("giant_robot_rumble_and_shake", 1);
        util::wait_network_frame();
        self clientfield::set_to_player("giant_robot_rumble_and_shake", 0);
        util::wait_network_frame();
        wait(0.1);
    }
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_9df817c8
// Checksum 0x8863c821, Offset: 0x6710
// Size: 0xbc
function function_9df817c8() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"hash_48c54e97");
    util::wait_network_frame();
    self clientfield::set_to_player("giant_robot_rumble_and_shake", 0);
    util::wait_network_frame();
    self clientfield::set_to_player("giant_robot_rumble_and_shake", 3);
    util::wait_network_frame();
    self clientfield::set_to_player("giant_robot_rumble_and_shake", 0);
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_d5cc02d6
// Checksum 0x35492541, Offset: 0x67d8
// Size: 0x122
function function_d5cc02d6() {
    self endon(#"death");
    self endon(#"disconnect");
    a_players = getplayers();
    foreach (player in a_players) {
        if (player == self) {
            continue;
        }
        if (isdefined(player.var_66476b55) && player.var_66476b55) {
            continue;
        }
        if (distance2dsquared(player.origin, self.origin) < 250000) {
            player thread function_9df817c8();
        }
    }
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_6fbb7deb
// Checksum 0x4cadb5bf, Offset: 0x6908
// Size: 0x32a
function function_6fbb7deb() {
    self endon(#"death");
    self endon(#"disconnect");
    if (isdefined(self.var_9c02558d) && self.var_9c02558d) {
        a_s_orgs = struct::get_array("tank_platform_safe_spots", "targetname");
        foreach (struct in a_s_orgs) {
            if (!positionwouldtelefrag(struct.origin)) {
                self setorigin(struct.origin);
                break;
            }
        }
        self.var_9c02558d = 0;
        return;
    }
    var_a55e33d3 = struct::get_array("giant_robot_footprint", "targetname");
    var_a55e33d3 = util::get_array_of_closest(self.var_4fea0f8a, var_a55e33d3);
    var_9be44398 = var_a55e33d3[0];
    var_71526995 = [];
    var_71526995[0] = (0, 0, 0);
    var_71526995[1] = (50, 50, 0);
    var_71526995[2] = (50, 0, 0);
    var_71526995[3] = (50, -50, 0);
    var_71526995[4] = (0, -50, 0);
    var_71526995[5] = (-50, -50, 0);
    var_71526995[6] = (-50, 0, 0);
    var_71526995[7] = (-50, 50, 0);
    var_71526995[8] = (0, 50, 0);
    for (i = 0; i < var_71526995.size; i++) {
        v_origin = var_9be44398.origin + var_71526995[i];
        v_trace_start = v_origin + (0, 0, 100);
        var_9360ea0c = playerphysicstrace(v_trace_start, v_origin);
        if (!positionwouldtelefrag(var_9360ea0c)) {
            self setorigin(var_9360ea0c);
            break;
        }
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_6e9ca2fc
// Checksum 0xa390ce8e, Offset: 0x6c40
// Size: 0x6ce
function function_6e9ca2fc(var_9a1bfdd4) {
    level endon(#"intermission");
    wait(15);
    var_55013575 = function_c9473cc(var_9a1bfdd4);
    if (var_55013575 == 0) {
        return;
    }
    while (level flag::get("maxis_audiolog_gr" + var_9a1bfdd4 + "_playing")) {
        wait(0.1);
    }
    var_55013575 = function_c9473cc(var_9a1bfdd4);
    if (var_55013575 == 0) {
        return;
    }
    level thread function_92772da8(var_9a1bfdd4);
    namespace_ad52727b::function_271ff115(var_9a1bfdd4);
    level clientfield::set("eject_warning_fx_robot_" + var_9a1bfdd4, 1);
    a_players = getplayers();
    a_players[0] clientfield::set("all_tubes_play_eject_steam_fx", 1);
    level waittill("timeout_warning_vo_complete_" + var_9a1bfdd4);
    var_697a7c19 = struct::get_array("giant_robot_head_exit_trigger", "script_noteworthy");
    var_1d92861d = [];
    foreach (trigger in var_697a7c19) {
        if (trigger.script_int == var_9a1bfdd4) {
            if (isdefined(trigger.unitrigger_stub.is_available) && trigger.unitrigger_stub.is_available) {
                zm_unitrigger::unregister_unitrigger(trigger.unitrigger_stub);
                var_1d92861d[var_1d92861d.size] = trigger;
            }
        }
    }
    a_players = getplayers();
    var_96cf0854 = [];
    foreach (player in a_players) {
        if (isdefined(player.var_caac9938) && player.var_caac9938 == var_9a1bfdd4) {
            if (!(isdefined(player.var_66476b55) && player.var_66476b55)) {
                if (player laststand::player_is_in_laststand()) {
                    if (isdefined(player.waiting_to_revive) && player.waiting_to_revive && a_players.size <= 1) {
                        level flag::set("instant_revive");
                        player.var_af9bd93e = gettime() + 1000;
                        util::wait_network_frame();
                        level flag::clear("instant_revive");
                    } else if (player bgb::is_enabled("zm_bgb_self_medication")) {
                        player bgb::take();
                        player.var_df0decf1 = undefined;
                        player.var_25b88da = 0;
                        player thread zm_laststand::bleed_out();
                        player notify(#"hash_86d94575");
                        continue;
                    } else {
                        player thread zm_laststand::bleed_out();
                        player notify(#"hash_86d94575");
                        continue;
                    }
                }
                if (isalive(player)) {
                    var_ae17f0e5 = spawn_model("tag_origin", player.origin, player.angles);
                    var_96cf0854[var_96cf0854.size] = var_ae17f0e5;
                    player function_6a28d1f7(var_9a1bfdd4, var_ae17f0e5);
                    wait(0.1);
                }
            }
        }
    }
    wait(10);
    namespace_ad52727b::function_844ce15d(var_9a1bfdd4);
    level clientfield::set("eject_warning_fx_robot_" + var_9a1bfdd4, 0);
    a_players = getplayers();
    a_players[0] clientfield::set("all_tubes_play_eject_steam_fx", 0);
    foreach (trigger in var_1d92861d) {
        if (trigger.script_int == var_9a1bfdd4) {
            trigger thread function_1d2e5a7b();
        }
    }
    if (var_96cf0854.size > 0) {
        for (i = 0; i < var_96cf0854.size; i++) {
            if (isdefined(var_96cf0854[i])) {
                var_96cf0854[i] delete();
            }
        }
    }
}

// Namespace namespace_d1b0a244
// Params 2, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_6a28d1f7
// Checksum 0x70ec89b3, Offset: 0x7318
// Size: 0x1f6
function function_6a28d1f7(var_9a1bfdd4, var_ae17f0e5) {
    self endon(#"death");
    self endon(#"disconnect");
    var_697a7c19 = struct::get_array("giant_robot_head_exit_trigger", "script_noteworthy");
    var_697a7c19 = util::get_array_of_closest(self.origin, var_697a7c19);
    foreach (trigger in var_697a7c19) {
        if (trigger.unitrigger_stub.script_int == var_9a1bfdd4) {
            if (isdefined(trigger.unitrigger_stub.is_available) && trigger.unitrigger_stub.is_available) {
                self thread function_a5c5c0db();
                trigger.unitrigger_stub.is_available = 0;
                s_tube = struct::get(trigger.target, "targetname");
                self playerlinktodelta(var_ae17f0e5, "tag_origin", 1, 20, 20, 20, 20);
                self thread function_a000f8f9(var_ae17f0e5, s_tube, trigger);
                break;
            }
        }
    }
}

// Namespace namespace_d1b0a244
// Params 3, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_a000f8f9
// Checksum 0x550a1341, Offset: 0x7518
// Size: 0x114
function function_a000f8f9(var_ae17f0e5, s_tube, trigger) {
    self endon(#"death");
    self endon(#"disconnect");
    self.var_66476b55 = 1;
    n_speed = 500;
    n_dist = distance(var_ae17f0e5.origin, s_tube.origin);
    n_time = n_dist / n_speed;
    var_ae17f0e5 moveto(s_tube.origin, n_time);
    var_ae17f0e5 waittill(#"movedone");
    var_ae17f0e5 delete();
    level thread function_2a223f4(trigger.unitrigger_stub, self, 1);
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x0
// namespace_d1b0a244<file_0>::function_aced72fa
// Checksum 0xee00b64b, Offset: 0x7638
// Size: 0x64
function function_aced72fa() {
    self endon(#"teleport");
    self endon(#"disconnect");
    self playsoundtoplayer("zmb_bot_timeout_alarm", self);
    wait(2.5);
    self playsoundtoplayer("zmb_bot_timeout_alarm", self);
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_8f9ab8f5
// Checksum 0x4d8bb1dc, Offset: 0x76a8
// Size: 0x9c
function function_8f9ab8f5(player) {
    player endon(#"death");
    player endon(#"disconnect");
    self waittill(#"movedone");
    player clientfield::set("gr_eject_player_impact_fx", 1);
    util::wait_network_frame();
    player notify(#"hash_b576929e");
    wait(1);
    player clientfield::set("gr_eject_player_impact_fx", 0);
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_55b8cc10
// Checksum 0x3fa747e8, Offset: 0x7750
// Size: 0x6c
function function_55b8cc10() {
    self endon(#"disconnect");
    self endon(#"hash_b03c4326");
    self util::waittill_either("bled_out", "gr_head_forced_bleed_out");
    self.var_9c02558d = undefined;
    self.var_66476b55 = undefined;
    self.var_caac9938 = undefined;
    self.ignoreme = 0;
    self.dontspeak = 0;
}

// Namespace namespace_d1b0a244
// Params 2, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_56b8e9d5
// Checksum 0x947f57e0, Offset: 0x77c8
// Size: 0x6c
function function_56b8e9d5(var_ea13cab5, var_2f1fc889) {
    self endon(#"hash_b03c4326");
    self waittill(#"disconnect");
    if (isdefined(var_ea13cab5)) {
        var_ea13cab5 delete();
    }
    if (isdefined(var_2f1fc889)) {
        var_2f1fc889 delete();
    }
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_6e58ffa7
// Checksum 0xa5b7b308, Offset: 0x7840
// Size: 0x4c
function function_6e58ffa7() {
    self endon(#"death");
    self endon(#"disconnect");
    util::wait_network_frame();
    self clientfield::set_to_player("giant_robot_rumble_and_shake", 0);
}

// Namespace namespace_d1b0a244
// Params 4, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_b9fd52a4
// Checksum 0xac7c54a, Offset: 0x7898
// Size: 0xb4
function spawn_model(model_name, origin, angles, n_spawnflags) {
    if (!isdefined(n_spawnflags)) {
        n_spawnflags = 0;
    }
    if (!isdefined(origin)) {
        origin = (0, 0, 0);
    }
    model = spawn("script_model", origin, n_spawnflags);
    model setmodel(model_name);
    if (isdefined(angles)) {
        model.angles = angles;
    }
    return model;
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_c9473cc
// Checksum 0x37231b3, Offset: 0x7958
// Size: 0xdc
function function_c9473cc(var_9a1bfdd4) {
    var_55013575 = 0;
    a_players = getplayers();
    foreach (player in a_players) {
        if (isdefined(player.var_caac9938) && player.var_caac9938 == var_9a1bfdd4) {
            var_55013575++;
        }
    }
    return var_55013575;
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_eb3175d9
// Checksum 0x27d6844e, Offset: 0x7a40
// Size: 0x116
function function_eb3175d9() {
    level waittill(#"intermission");
    for (i = 0; i < 3; i++) {
        var_562a8b24 = getent("giant_robot_" + i, "targetname");
        if (!isdefined(var_562a8b24)) {
            continue;
        }
        var_562a8b24 ghost();
        var_562a8b24 stopanimscripted(0.05);
        var_562a8b24 notify(#"hash_9132f14c");
        if (i == 2) {
            util::wait_network_frame();
            var_562a8b24 show();
            level thread scene::play("cin_tomb_giant_robot_walk_village", var_562a8b24);
        }
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_5260b944
// Checksum 0xf151aa57, Offset: 0x7b60
// Size: 0x110
function function_5260b944(var_562a8b24) {
    var_562a8b24 endon(#"hash_9132f14c");
    self endon(#"disconnect");
    level endon(#"hash_ba0a4cee");
    while (true) {
        if (distance2dsquared(self.origin, var_562a8b24.origin) < 16000000) {
            if (self zm_utility::is_player_looking_at(var_562a8b24.origin + (0, 0, 2000), 0.85)) {
                if (!(isdefined(self.dontspeak) && self.dontspeak)) {
                    self zm_audio::create_and_play_dialog("general", "discover_robot");
                    level.var_ba0a4cee = 1;
                    level notify(#"hash_ba0a4cee");
                    break;
                }
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_7e49b357
// Checksum 0xb836a1f4, Offset: 0x7c78
// Size: 0x110
function function_7e49b357(var_562a8b24) {
    var_562a8b24 endon(#"hash_9132f14c");
    self endon(#"disconnect");
    level endon(#"hash_7e49b357");
    while (true) {
        if (distance2dsquared(self.origin, var_562a8b24.origin) < 16000000) {
            if (self zm_utility::is_player_looking_at(var_562a8b24.origin + (0, 0, 2000), 0.85)) {
                if (!(isdefined(self.dontspeak) && self.dontspeak)) {
                    self zm_audio::create_and_play_dialog("general", "see_robots");
                    level.var_7e49b357 = 1;
                    level notify(#"hash_7e49b357");
                    break;
                }
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_b52e0869
// Checksum 0x389f7c16, Offset: 0x7d90
// Size: 0x190
function function_b52e0869(var_562a8b24) {
    var_562a8b24 endon(#"hash_9132f14c");
    self endon(#"disconnect");
    level endon(#"hash_92d5ed2f");
    while (true) {
        while (distance2dsquared(self.origin, var_562a8b24.origin) < 16000000 && self zm_utility::is_player_looking_at(var_562a8b24.origin + (0, 0, 2000), 0.7)) {
            self waittill(#"weapon_fired");
            if (distance2dsquared(self.origin, var_562a8b24.origin) < 16000000 && self zm_utility::is_player_looking_at(var_562a8b24.origin + (0, 0, 2000), 0.7)) {
                if (!(isdefined(self.dontspeak) && self.dontspeak)) {
                    self zm_audio::create_and_play_dialog("general", "shoot_robot");
                    level.var_92d5ed2f = 1;
                    level notify(#"hash_92d5ed2f");
                    return;
                }
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_d3460cf5
// Checksum 0xa2c9d39e, Offset: 0x7f28
// Size: 0x2c2
function function_d3460cf5(var_87652dc9) {
    if (var_87652dc9 == "right") {
        str_tag = "TAG_ATTACH_HATCH_RI";
    } else if (var_87652dc9 == "left") {
        str_tag = "TAG_ATTACH_HATCH_LE";
    }
    v_origin = self gettagorigin(str_tag);
    var_9864435c = struct::get_array("giant_robot_footprint_center", "targetname");
    var_36611c78 = [];
    foreach (var_efb4e08a in var_9864435c) {
        if (var_efb4e08a.script_int == self.var_582adcd3) {
            if (!isdefined(var_36611c78)) {
                var_36611c78 = [];
            } else if (!isarray(var_36611c78)) {
                var_36611c78 = array(var_36611c78);
            }
            var_36611c78[var_36611c78.size] = var_efb4e08a;
        }
    }
    if (var_36611c78.size == 0) {
        return;
    } else {
        var_36611c78 = util::get_array_of_closest(v_origin, var_36611c78);
        var_9be44398 = var_36611c78[0];
    }
    a_players = getplayers();
    foreach (player in a_players) {
        if (distance2dsquared(player.origin, var_9be44398.origin) < 160000) {
            player thread function_2325980d();
        }
    }
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_2325980d
// Checksum 0xdb3bbf35, Offset: 0x81f8
// Size: 0x146
function function_2325980d() {
    a_players = getplayers();
    foreach (player in a_players) {
        if (player == self) {
            continue;
        }
        if (distance2dsquared(self.origin, player.origin) < 640000) {
            if (player zm_utility::is_player_looking_at(self.origin + (0, 0, 60))) {
                if (!(isdefined(player.dontspeak) && player.dontspeak)) {
                    player zm_audio::create_and_play_dialog("general", "warn_robot_foot");
                    break;
                }
            }
        }
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_9bb14cac
// Checksum 0x93d3b03a, Offset: 0x8348
// Size: 0x1ac
function function_9bb14cac(var_87652dc9) {
    self endon(#"hash_9132f14c");
    if (var_87652dc9 == "right") {
        str_tag = "TAG_ATTACH_HATCH_RI";
    } else if (var_87652dc9 == "left") {
        str_tag = "TAG_ATTACH_HATCH_LE";
    }
    v_origin = self gettagorigin(str_tag);
    a_players = getplayers();
    foreach (player in a_players) {
        if (distancesquared(v_origin, player.origin) < 640000) {
            if (player zm_utility::is_player_looking_at(v_origin, 0.25)) {
                if (!(isdefined(player.dontspeak) && player.dontspeak)) {
                    player zm_audio::create_and_play_dialog("general", "robot_crush_zombie");
                    return;
                }
            }
        }
    }
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_c4ed83dc
// Checksum 0x50c22948, Offset: 0x8500
// Size: 0xbc
function function_c4ed83dc() {
    self endon(#"disconnect");
    if (self laststand::player_is_in_laststand()) {
        if (math::cointoss()) {
            var_6d937805 = 1;
        } else {
            var_6d937805 = 0;
        }
        self playsoundwithnotify("vox_plr_" + self.characterindex + "_robot_crush_player_" + var_6d937805, "sound_done" + "vox_plr_" + self.characterindex + "_robot_crush_player_" + var_6d937805);
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_92772da8
// Checksum 0x716b2b26, Offset: 0x85c8
// Size: 0x2f4
function function_92772da8(var_9a1bfdd4) {
    level flag::set("timeout_vo_robot_" + var_9a1bfdd4);
    s_origin = struct::get("eject_warning_fx_robot_" + var_9a1bfdd4, "targetname");
    var_fe164365 = spawn_model("tag_origin", s_origin.origin);
    var_fe164365 playsoundwithnotify("vox_maxi_purge_robot_0", "vox_maxi_purge_robot_0_done");
    var_fe164365 waittill(#"hash_2a437a6b");
    a_players = getplayers();
    foreach (player in a_players) {
        if (isdefined(player.var_caac9938) && player.var_caac9938 == var_9a1bfdd4) {
            if (!(isdefined(player.var_66476b55) && player.var_66476b55)) {
                if (!(isdefined(player.dontspeak) && player.dontspeak)) {
                    player zm_audio::create_and_play_dialog("general", "purge_robot");
                    break;
                }
            }
        }
    }
    while (isdefined(player.isspeaking) && isdefined(player) && player.isspeaking) {
        wait(0.1);
    }
    wait(1);
    var_fe164365 playsoundwithnotify("vox_maxi_purge_countdown_0", "vox_maxi_purge_countdown_0_done");
    var_fe164365 waittill(#"hash_6ca90988");
    wait(1);
    level notify("timeout_warning_vo_complete_" + var_9a1bfdd4);
    var_fe164365 playsoundwithnotify("vox_maxi_purge_now_0", "vox_maxi_purge_now_0_done");
    var_fe164365 waittill(#"hash_cb262163");
    var_fe164365 delete();
    level flag::clear("timeout_vo_robot_" + var_9a1bfdd4);
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_ae0e6ab0
// Checksum 0x10de0cf5, Offset: 0x88c8
// Size: 0xe2
function function_ae0e6ab0(var_9a1bfdd4) {
    wait(20);
    a_structs = struct::get_array("giant_robot_footprint_center", "targetname");
    foreach (struct in a_structs) {
        if (struct.script_int == var_9a1bfdd4) {
            struct thread function_5be74494(self);
        }
    }
}

// Namespace namespace_d1b0a244
// Params 1, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_5be74494
// Checksum 0x4352e6bb, Offset: 0x89b8
// Size: 0x1b4
function function_5be74494(var_562a8b24) {
    level endon(#"hash_2c87daff");
    var_562a8b24 endon(#"hash_9132f14c");
    while (true) {
        a_players = getplayers();
        foreach (player in a_players) {
            if (distance2dsquared(player.origin, self.origin) < 90000) {
                if (distance2dsquared(player.origin, var_562a8b24.origin) < 16000000) {
                    if (player.origin[0] > var_562a8b24.origin[0]) {
                        if (!(isdefined(player.dontspeak) && player.dontspeak)) {
                            player zm_utility::do_player_general_vox("general", "warn_robot");
                            level.var_2c87daff = 1;
                            level notify(#"hash_2c87daff");
                            return;
                        }
                    }
                }
            }
        }
        wait(1);
    }
}

// Namespace namespace_d1b0a244
// Params 0, eflags: 0x1 linked
// namespace_d1b0a244<file_0>::function_bcb499ac
// Checksum 0xec2e3c22, Offset: 0x8b78
// Size: 0x1ac
function function_bcb499ac() {
    /#
        setdvar("giant_robot_head_exit_trigger", "giant_robot_head_exit_trigger");
        setdvar("giant_robot_head_exit_trigger", "giant_robot_head_exit_trigger");
        setdvar("giant_robot_head_exit_trigger", "giant_robot_head_exit_trigger");
        setdvar("giant_robot_head_exit_trigger", "giant_robot_head_exit_trigger");
        setdvar("giant_robot_head_exit_trigger", "giant_robot_head_exit_trigger");
        setdvar("giant_robot_head_exit_trigger", "giant_robot_head_exit_trigger");
        setdvar("giant_robot_head_exit_trigger", "giant_robot_head_exit_trigger");
        adddebugcommand("giant_robot_head_exit_trigger");
        adddebugcommand("giant_robot_head_exit_trigger");
        adddebugcommand("giant_robot_head_exit_trigger");
        adddebugcommand("giant_robot_head_exit_trigger");
        adddebugcommand("giant_robot_head_exit_trigger");
        adddebugcommand("giant_robot_head_exit_trigger");
        adddebugcommand("giant_robot_head_exit_trigger");
        level thread function_4419fb9d();
    #/
}

/#

    // Namespace namespace_d1b0a244
    // Params 0, eflags: 0x1 linked
    // namespace_d1b0a244<file_0>::function_4419fb9d
    // Checksum 0x4ad1fd54, Offset: 0x8d30
    // Size: 0x4c0
    function function_4419fb9d() {
        while (true) {
            if (getdvarstring("giant_robot_head_exit_trigger") == "giant_robot_head_exit_trigger") {
                setdvar("giant_robot_head_exit_trigger", "giant_robot_head_exit_trigger");
                if (isdefined(level.var_1a66bae4) && level.var_1a66bae4 == 0) {
                    level.var_1a66bae4 = undefined;
                    iprintlnbold("giant_robot_head_exit_trigger");
                } else {
                    level.var_1a66bae4 = 0;
                    iprintlnbold("giant_robot_head_exit_trigger");
                }
            }
            if (getdvarstring("giant_robot_head_exit_trigger") == "giant_robot_head_exit_trigger") {
                setdvar("giant_robot_head_exit_trigger", "giant_robot_head_exit_trigger");
                if (isdefined(level.var_1a66bae4) && level.var_1a66bae4 == 1) {
                    level.var_1a66bae4 = undefined;
                    iprintlnbold("giant_robot_head_exit_trigger");
                } else {
                    level.var_1a66bae4 = 1;
                    iprintlnbold("giant_robot_head_exit_trigger");
                }
            }
            if (getdvarstring("giant_robot_head_exit_trigger") == "giant_robot_head_exit_trigger") {
                setdvar("giant_robot_head_exit_trigger", "giant_robot_head_exit_trigger");
                if (isdefined(level.var_1a66bae4) && level.var_1a66bae4 == 2) {
                    level.var_1a66bae4 = undefined;
                    iprintlnbold("giant_robot_head_exit_trigger");
                } else {
                    level.var_1a66bae4 = 2;
                    iprintlnbold("giant_robot_head_exit_trigger");
                }
            }
            if (getdvarstring("giant_robot_head_exit_trigger") == "giant_robot_head_exit_trigger") {
                setdvar("giant_robot_head_exit_trigger", "giant_robot_head_exit_trigger");
                if (isdefined(level.var_5d69df3a) && level.var_5d69df3a) {
                    level.var_5d69df3a = undefined;
                    iprintlnbold("giant_robot_head_exit_trigger");
                } else {
                    level.var_5d69df3a = 1;
                    iprintlnbold("giant_robot_head_exit_trigger");
                }
            }
            if (getdvarstring("giant_robot_head_exit_trigger") == "giant_robot_head_exit_trigger") {
                setdvar("giant_robot_head_exit_trigger", "giant_robot_head_exit_trigger");
                if (isdefined(level.var_f06a1a87) && level.var_f06a1a87 == "giant_robot_head_exit_trigger") {
                    level.var_f06a1a87 = undefined;
                    iprintlnbold("giant_robot_head_exit_trigger");
                } else {
                    level.var_f06a1a87 = "giant_robot_head_exit_trigger";
                    iprintlnbold("giant_robot_head_exit_trigger");
                }
            }
            if (getdvarstring("giant_robot_head_exit_trigger") == "giant_robot_head_exit_trigger") {
                setdvar("giant_robot_head_exit_trigger", "giant_robot_head_exit_trigger");
                if (isdefined(level.var_f06a1a87) && level.var_f06a1a87 == "giant_robot_head_exit_trigger") {
                    level.var_f06a1a87 = undefined;
                    iprintlnbold("giant_robot_head_exit_trigger");
                } else {
                    level.var_f06a1a87 = "giant_robot_head_exit_trigger";
                    iprintlnbold("giant_robot_head_exit_trigger");
                }
            }
            if (getdvarstring("giant_robot_head_exit_trigger") == "giant_robot_head_exit_trigger") {
                setdvar("giant_robot_head_exit_trigger", "giant_robot_head_exit_trigger");
                level flag::set("giant_robot_head_exit_trigger");
                iprintlnbold("giant_robot_head_exit_trigger");
            }
            wait(0.05);
        }
    }

#/
