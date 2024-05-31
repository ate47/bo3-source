#using scripts/cp/_dialog;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/cp_mi_sing_biodomes;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/cp_mi_sing_biodomes_warehouse;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_36171bd3;

// Namespace namespace_36171bd3
// Params 0, eflags: 0x2
// Checksum 0x629ac5cf, Offset: 0xab8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("squad_control", &__init__, undefined, undefined);
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0xa8f848bd, Offset: 0xaf0
// Size: 0x12a
function __init__() {
    for (i = 0; i < 4; i++) {
        var_b9f5e594 = "keyline_outline_p" + i;
        clientfield::register("actor", var_b9f5e594, 1, 2, "int");
        clientfield::register("vehicle", var_b9f5e594, 1, 2, "int");
        clientfield::register("scriptmover", var_b9f5e594, 1, 3, "int");
    }
    for (i = 0; i < 4; i++) {
        var_b9f5e594 = "squad_indicator_p" + i;
        clientfield::register("actor", var_b9f5e594, 1, 1, "int");
    }
    clientfield::register("actor", "robot_camo_shader", 1, 3, "int");
    level.var_641fcd9c = [];
    level.var_a6fbf51b = 0;
    callback::on_disconnect(&on_player_disconnect);
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x666d8642, Offset: 0xc28
// Size: 0x9b
function on_player_disconnect() {
    self function_bf7e3cbb();
    if (isdefined(self.var_6884cce4)) {
        self.var_6884cce4 function_ac28ba8e();
    }
    if (isdefined(self.var_61a19dc6)) {
        for (i = 0; i < self.var_61a19dc6.size; i++) {
            self.var_61a19dc6[i] util::stop_magic_bullet_shield();
            self.var_61a19dc6[i] kill();
        }
    }
    self notify(#"hash_f4ef75a1");
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0x90c93d19, Offset: 0xcd0
// Size: 0x7a
function function_4c7ed3de(var_a6fbf51b) {
    if (!isdefined(var_a6fbf51b)) {
        var_a6fbf51b = 0;
    }
    self.var_3a11451c = 0;
    self.a_targets = [];
    self.var_38f7500 = [];
    level.var_a6fbf51b = var_a6fbf51b;
    self thread squad_init();
    self thread function_2a739664();
    self thread function_5e815292();
    self thread function_e666eb85();
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0x330e3a7d, Offset: 0xd58
// Size: 0x8b
function function_e56e9d7d(var_641fcd9c) {
    level.var_38f7500 = [];
    level.var_a6fbf51b = 0;
    foreach (var_f6c5842 in var_641fcd9c) {
        if (isalive(var_f6c5842)) {
            level function_66e5311c(var_f6c5842);
        }
    }
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0xe72ed712, Offset: 0xdf0
// Size: 0x12b
function function_e666eb85() {
    self endon(#"death");
    self waittill(#"hash_f4ef75a1");
    wait(0.5);
    foreach (var_f6c5842 in self.var_61a19dc6) {
        if (isdefined(var_f6c5842)) {
            var_f6c5842 thread function_14ec2d71();
            var_f6c5842 thread function_6142019a(self, 0);
        }
    }
    self.var_61a19dc6 = [];
    a_e_targets = getaiteamarray("axis");
    foreach (e_target in a_e_targets) {
        if (isdefined(e_target.var_6884cce4)) {
            e_target.var_6884cce4 function_ac28ba8e();
        }
    }
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x379a9646, Offset: 0xf28
// Size: 0x4a
function function_5e815292() {
    self endon(#"death");
    self endon(#"hash_f4ef75a1");
    if (level.var_a6fbf51b) {
        self thread function_e74c1cd1();
        self thread function_2a32bf5e();
        self thread function_475fb2a8();
    }
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0xd80adcd9, Offset: 0xf80
// Size: 0x149
function function_bd439085(player) {
    self endon(#"death");
    player endon(#"death");
    player endon(#"hash_f4ef75a1");
    wait(randomfloatrange(1, 3));
    var_66eaa556 = player function_16ecda76(self);
    self.var_40148675 = player function_16ecda76(self);
    self ai::set_behavior_attribute("escort_position", self.var_40148675);
    while (true) {
        if (self ai::get_behavior_attribute("move_mode") === "escort" && self.var_24cf4025) {
            self.var_40148675 = player function_16ecda76(self);
            var_860823ab = distancesquared(self.var_40148675, var_66eaa556);
            if (var_860823ab > 2500) {
                var_66eaa556 = self.var_40148675;
                self clearforcedgoal();
                self ai::set_behavior_attribute("escort_position", self.var_40148675);
            }
        }
        wait(2);
    }
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0xb4b9a470, Offset: 0x10d8
// Size: 0xb5
function function_2d3a8177(player) {
    self endon(#"death");
    player endon(#"hash_f4ef75a1");
    while (true) {
        wait(5);
        if (self ai::get_behavior_attribute("move_mode") === "escort" && self.var_24cf4025) {
            v_pos = getclosestpointonnavmesh(player.origin, 120, 32);
            if (isdefined(v_pos)) {
                self setgoal(v_pos);
                continue;
            }
            self setgoal(player.origin);
        }
    }
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0xf1835c5e, Offset: 0x1198
// Size: 0x4a
function function_16ecda76(var_6104a93b) {
    var_98c6afec = util::positionquery_pointarray(self.origin, 64, -56, 16, 16, 32);
    if (var_98c6afec.size) {
        return var_98c6afec[0];
    }
    return self.origin;
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0xe95cf663, Offset: 0x11f0
// Size: 0x72
function squad_init() {
    str_name = self.playername;
    for (i = 0; i < self.var_61a19dc6.size; i++) {
        level function_66e5311c(self.var_61a19dc6[i], self);
    }
    self thread function_ba565c66();
    self thread function_bd7db313();
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0x9828cddf, Offset: 0x1270
// Size: 0x242
function function_66e5311c(var_f6c5842, player) {
    var_f6c5842.b_moving = 0;
    var_f6c5842.var_24cf4025 = 1;
    var_f6c5842.var_99ebba13 = 0;
    var_f6c5842.str_action = "Standard";
    var_f6c5842.var_6648858 = 0;
    var_f6c5842.goalradius = -56;
    var_f6c5842.attackeraccuracy = 1;
    var_f6c5842.minwalkdistance = 600;
    var_f6c5842 ai::set_behavior_attribute("supports_super_sprint", 1);
    var_f6c5842 ai::set_behavior_attribute("can_be_meleed", 0);
    if (level.var_a6fbf51b && isplayer(player)) {
        var_f6c5842 thread function_ba02c8e3(player);
        var_f6c5842 thread function_bd439085(player);
        var_f6c5842 thread function_2d3a8177(player);
        var_f6c5842 function_6142019a(player, 1);
        var_f6c5842 ai::set_behavior_attribute("move_mode", "escort");
        player.var_e6b3078d = player getentitynumber();
    } else {
        var_f6c5842 thread function_e21506ba();
        if (level flag::get("warehouse_warlord_friendly_goal")) {
            var_ab891f49 = getent("warehouse_warlord_friendly_volume", "targetname");
            var_f6c5842 setgoal(var_ab891f49, 1);
        } else {
            var_f6c5842 ai::set_behavior_attribute("move_mode", "normal");
            var_f6c5842 colors::set_force_color("c");
        }
        var_f6c5842 function_eb13b9c0();
    }
    array::add(level.var_641fcd9c, var_f6c5842, 0);
    if (level.var_b06e31c0) {
        var_f6c5842.overrideactordamage = &function_f0bf9ac3;
    }
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x27c6ba51, Offset: 0x14c0
// Size: 0x1a
function function_eb13b9c0() {
    self clientfield::set("cybercom_setiffname", 2);
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0x24a01297, Offset: 0x14e8
// Size: 0xfd
function function_5a0dc838(player) {
    self endon(#"death");
    player endon(#"hash_f4ef75a1");
    self endon(#"hash_f383a3b8");
    if (level.var_a6fbf51b) {
        return;
    }
    while (true) {
        wait(randomintrange(6, 12));
        n_chance = randomfloatrange(0, 1);
        if (n_chance >= 0.5 && !self.var_6648858 && self.var_24cf4025) {
            self thread function_ee0e002(1, player);
            self ai::set_behavior_attribute("move_mode", "rusher");
            self.perfectaim = 1;
            wait(10);
            self ai::set_behavior_attribute("move_mode", "escort");
            self thread function_ee0e002(0, player);
            self.perfectaim = 0;
        }
    }
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x44ceac47, Offset: 0x15f0
// Size: 0x9a
function function_5d158aaf() {
    self endon(#"death");
    self clientfield::set("robot_camo_shader", 1);
    self playsound("gdt_camo_suit_on");
    self.ignoreme = 1;
    self.var_6648858 = 1;
    wait(randomintrange(3, 6));
    self clientfield::set("robot_camo_shader", 0);
    self playsound("gdt_camo_suit_off");
    self.ignoreme = 0;
    self.var_6648858 = 0;
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x92d56802, Offset: 0x1698
// Size: 0x6ba
function function_2a739664() {
    if (!level.var_a6fbf51b) {
        return;
    }
    self.var_e6b3078d = self getentitynumber();
    str_name = self.playername;
    if (self.var_e6b3078d == 0) {
        objectives::set("robot_name_1", self.var_61a19dc6[0]);
        objectives::set_value("robot_name_1", "robot1", str_name + "-" + 0);
        self.var_61a19dc6[0] thread function_b5d8eeb6("robot_name_1", self);
        self.var_61a19dc6[0] thread function_acd9c248("robot_name_1", self);
        if (self.var_61a19dc6.size > 1) {
            objectives::set("robot_name_2", self.var_61a19dc6[1]);
            objectives::set_value("robot_name_2", "robot2", str_name + "-" + 1);
            self.var_61a19dc6[1] thread function_b5d8eeb6("robot_name_2", self);
            self.var_61a19dc6[1] thread function_acd9c248("robot_name_2", self);
        }
        if (self.var_61a19dc6.size > 2) {
            objectives::set("robot_name_3", self.var_61a19dc6[2]);
            objectives::set_value("robot_name_3", "robot3", str_name + "-" + 2);
            self.var_61a19dc6[2] thread function_b5d8eeb6("robot_name_3", self);
            self.var_61a19dc6[2] thread function_acd9c248("robot_name_3", self);
        }
        if (self.var_61a19dc6.size > 3) {
            objectives::set("robot_name_4", self.var_61a19dc6[3]);
            objectives::set_value("robot_name_4", "robot4", str_name + "-" + 3);
            self.var_61a19dc6[3] thread function_b5d8eeb6("robot_name_4", self);
            self.var_61a19dc6[3] thread function_acd9c248("robot_name_4", self);
        }
        return;
    }
    if (self.var_e6b3078d == 1) {
        objectives::set("robot_name_5", self.var_61a19dc6[0]);
        objectives::set_value("robot_name_5", "robot5", str_name + "-" + 0);
        self.var_61a19dc6[0] thread function_b5d8eeb6("robot_name_5", self);
        self.var_61a19dc6[0] thread function_acd9c248("robot_name_5", self);
        objectives::set("robot_name_6", self.var_61a19dc6[1]);
        objectives::set_value("robot_name_6", "robot6", str_name + "-" + 1);
        self.var_61a19dc6[1] thread function_b5d8eeb6("robot_name_6", self);
        self.var_61a19dc6[1] thread function_acd9c248("robot_name_6", self);
        if (self.var_61a19dc6.size > 2) {
            objectives::set("robot_name_7", self.var_61a19dc6[2]);
            objectives::set_value("robot_name_7", "robot7", str_name + "-" + 2);
            self.var_61a19dc6[2] thread function_b5d8eeb6("robot_name_7", self);
            self.var_61a19dc6[2] thread function_acd9c248("robot_name_7", self);
        }
        return;
    }
    if (self.var_e6b3078d == 2) {
        objectives::set("robot_name_8", self.var_61a19dc6[0]);
        objectives::set_value("robot_name_8", "robot8", str_name + "-" + 0);
        self.var_61a19dc6[0] thread function_b5d8eeb6("robot_name_8", self);
        self.var_61a19dc6[0] thread function_acd9c248("robot_name_8", self);
        objectives::set("robot_name_9", self.var_61a19dc6[1]);
        objectives::set_value("robot_name_9", "robot9", str_name + "-" + 1);
        self.var_61a19dc6[1] thread function_b5d8eeb6("robot_name_9", self);
        self.var_61a19dc6[1] thread function_acd9c248("robot_name_9", self);
        return;
    }
    objectives::set("robot_name_10", self.var_61a19dc6[0]);
    objectives::set_value("robot_name_10", "robot10", str_name + "-" + 0);
    self.var_61a19dc6[0] thread function_b5d8eeb6("robot_name_10", self);
    self.var_61a19dc6[0] thread function_acd9c248("robot_name_10", self);
    objectives::set("robot_name_11", self.var_61a19dc6[1]);
    objectives::set_value("robot_name_11", "robot11", str_name + "-" + 1);
    self.var_61a19dc6[1] thread function_b5d8eeb6("robot_name_11", self);
    self.var_61a19dc6[1] thread function_acd9c248("robot_name_11", self);
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0x1a5a88a6, Offset: 0x1d60
// Size: 0x3a
function function_acd9c248(var_376507c0, e_player) {
    self endon(#"death");
    e_player waittill(#"hash_f4ef75a1");
    objectives::complete(var_376507c0, self);
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0xf4ed6af4, Offset: 0x1da8
// Size: 0x4a
function function_b5d8eeb6(var_376507c0, e_player) {
    e_player endon(#"hash_f4ef75a1");
    self waittill(#"death");
    objectives::complete(var_376507c0, self);
    self function_6142019a(e_player, 0);
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x31527010, Offset: 0x1e00
// Size: 0x1df
function function_2a32bf5e() {
    self endon(#"disconnect");
    self endon(#"hash_f4ef75a1");
    while (true) {
        if (!self laststand::player_is_in_laststand()) {
            a_e_targets = getaiteamarray("axis");
            for (i = 0; i < a_e_targets.size; i++) {
                n_dist = distance2dsquared(self.origin, a_e_targets[i].origin);
                if (self util::is_player_looking_at(a_e_targets[i].origin, 0.95, 0, self) && self sightconetrace(a_e_targets[i] geteye(), a_e_targets[i]) && isalive(a_e_targets[i]) && n_dist < 5760000) {
                    if (isdefined(a_e_targets[i].var_2ddc2ef9) && !a_e_targets[i].var_2ddc2ef9 && isdefined(a_e_targets[i].var_38c1e4c8) && !a_e_targets[i].var_38c1e4c8) {
                        a_e_targets[i] thread function_e228c18a(1, self);
                        a_e_targets[i].var_2ddc2ef9 = 1;
                    }
                    continue;
                }
                if (isalive(a_e_targets[i]) && isdefined(a_e_targets[i].var_38c1e4c8) && !a_e_targets[i].var_38c1e4c8) {
                    a_e_targets[i] thread function_14ec2d71(self);
                    a_e_targets[i].var_2ddc2ef9 = 0;
                }
            }
        }
        wait(3);
    }
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x609e4916, Offset: 0x1fe8
// Size: 0x6e
function function_944c781c() {
    self endon(#"death");
    self endon(#"hash_f4ef75a1");
    if (!isdefined(self.var_7ac3be1c)) {
        self.var_7ac3be1c = 0;
    }
    if (!self.var_7ac3be1c && isdefined(self.var_b1a0e508)) {
        self.var_7ac3be1c = 1;
        self lui::play_animation(self.var_b1a0e508, "Scanline");
        wait(2);
        self.var_7ac3be1c = 0;
    }
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x58d3b1fb, Offset: 0x2060
// Size: 0x2e5
function function_e74c1cd1() {
    self endon(#"disconnect");
    self endon(#"hash_f4ef75a1");
    n_trace = 1600;
    n_count = 10;
    while (true) {
        if (!self laststand::player_is_in_laststand()) {
            if (self actionslotonebuttonpressed()) {
                v_direction = anglestoforward(self getplayerangles());
                v_eye = self geteye();
                v_trace_pos = v_eye + v_direction * n_trace;
                var_84323b2d = bullettrace(v_eye, v_trace_pos, 0, self)["position"];
                v_pos = groundpos_ignore_water(var_84323b2d) + (0, 0, 5);
                v_moveto = getclosestpointonnavmesh(v_pos, 100, 32);
                n_inc = 0;
                while (self actionslotonebuttonpressed()) {
                    n_inc++;
                    if (n_inc > 2) {
                        /#
                            level util::debug_line(self.origin + (0, 0, 32), v_pos, (0, 0.25, 1), 0.25, undefined, 1);
                            v_direction = anglestoforward(self getplayerangles());
                            v_eye = self geteye();
                            v_trace_pos = v_eye + v_direction * n_trace;
                            var_84323b2d = bullettrace(v_eye, v_trace_pos, 0, self)["robot8"];
                            v_pos = groundpos_ignore_water(var_84323b2d) + (0, 0, 5);
                            v_moveto = getclosestpointonnavmesh(v_pos, 100, 32);
                        #/
                    }
                    if (n_inc >= n_count) {
                        n_inc = n_count;
                    }
                    wait(0.05);
                }
                self thread namespace_27a45d31::function_7aa89143();
                if (n_inc >= n_count) {
                    self function_5ab070f9(v_moveto);
                    self playsoundtoplayer("evt_robocommand_assign_task", self);
                } else {
                    self playsoundtoplayer("evt_robocommand_assign_task", self);
                    self function_cbb9d101();
                    self function_c90831e1();
                    self function_99f62595(v_moveto);
                }
                while (self actionslotonebuttonpressed()) {
                    wait(0.05);
                }
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0x82b98ac, Offset: 0x2350
// Size: 0x31a
function function_5ab070f9(v_moveto) {
    self endon(#"hash_f4ef75a1");
    if (isdefined(v_moveto)) {
        self thread function_bf7e3cbb();
        a_v_points = util::positionquery_pointarray(v_moveto, 16, -16, 70, 64, 40);
        if (isdefined(a_v_points) && a_v_points.size >= self.var_61a19dc6.size) {
            if (isdefined(self.var_6884cce4)) {
                self.var_6884cce4 function_ac28ba8e();
            }
            foreach (robot in self.var_61a19dc6) {
                robot function_6142019a(self, 0);
            }
            self.var_61a19dc6 = arraysortclosest(self.var_61a19dc6, self.origin);
            var_2ceb0dbc = [];
            for (i = 0; i < self.var_61a19dc6.size; i++) {
                if (self.var_61a19dc6[i].var_24cf4025) {
                    var_ea15b761 = "remove_waypoint_p" + self getentitynumber() + "_robot" + i;
                    var_2ceb0dbc[i] = level fx::play("squad_waypoint_base", a_v_points[i] + (0, 0, 4), (-90, 0, 0), var_ea15b761, 0, undefined, 1);
                    var_2ceb0dbc[i] setinvisibletoall();
                    var_2ceb0dbc[i] setvisibletoplayer(self);
                    self.var_61a19dc6[i] notify(#"moving");
                    self.var_61a19dc6[i].b_moving = 1;
                    self.var_61a19dc6[i].str_action = "Moving";
                    self.var_61a19dc6[i] notify(#"action");
                    self.var_61a19dc6[i] colors::disable();
                    self.var_61a19dc6[i] clearentitytarget();
                    self.var_61a19dc6[i] ai::set_behavior_attribute("move_mode", "normal");
                    self.var_61a19dc6[i] setgoal(a_v_points[i], 1);
                    self.var_61a19dc6[i] thread function_1214aaea();
                    self thread function_68efcbc3(self.var_61a19dc6[i], var_ea15b761);
                }
            }
        } else {
            self notify(#"hash_3b704051");
            self thread function_a5f1ef25();
        }
        return;
    }
    self notify(#"hash_3b704051");
    self thread function_a5f1ef25();
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0xa069a4d0, Offset: 0x2678
// Size: 0x67
function function_bf7e3cbb() {
    n_player = self getentitynumber();
    if (isdefined(self.var_61a19dc6)) {
        for (i = 0; i < self.var_61a19dc6.size; i++) {
            var_ea15b761 = "remove_waypoint_p" + n_player + "_robot" + i;
            level notify(var_ea15b761);
        }
    }
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0xaea7b67f, Offset: 0x26e8
// Size: 0x1aa
function function_cbb9d101() {
    if (self.var_3a11451c) {
        for (i = 0; i < self.var_38f7500.size; i++) {
            if (isdefined(self.var_38f7500[i]) && isdefined(self.var_38f7500[i].var_6884cce4)) {
                self.var_38f7500[i] notify(#"end");
                self.var_38f7500[i].var_6884cce4 function_ac28ba8e();
            }
        }
        self.var_3a11451c = 0;
    }
    if (self.a_targets.size) {
        foreach (var_f6c5842 in self.var_61a19dc6) {
            if (var_f6c5842.var_99ebba13) {
                var_f6c5842 notify(#"hash_606e31a3");
                var_f6c5842.str_action = "Standard";
                var_f6c5842 notify(#"action");
                var_f6c5842.var_99ebba13 = 0;
                var_f6c5842 clearentitytarget();
            }
        }
        for (i = 0; i < self.a_targets.size; i++) {
            if (isalive(self.a_targets[i])) {
                self.a_targets[i].var_38c1e4c8 = 0;
                self.a_targets[i] function_14ec2d71(self);
            }
        }
        self.a_targets = [];
    }
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x5db817b1, Offset: 0x28a0
// Size: 0x261
function function_c90831e1() {
    for (i = 0; i < self.var_38f7500.size; i++) {
        if (isdefined(self.var_38f7500[i])) {
            n_dist = distance2dsquared(self.origin, self.var_38f7500[i].origin);
            if (!self.var_38f7500[i].var_9145aecb && n_dist < 5760000) {
                if (self util::is_player_looking_at(self.var_38f7500[i].origin, 0.9, 0, self)) {
                    if (self.var_61a19dc6.size >= self.var_38f7500[i].n_required) {
                        self.var_38f7500[i].var_9145aecb = 1;
                        self.var_3a11451c = 1;
                        var_64e85e6d = [];
                        if (self.var_38f7500[i].script_noteworthy == "turret_hall") {
                            var_64e85e6d = arraycopy(level.var_641fcd9c);
                        } else {
                            var_e4660bfb = arraycopy(level.var_641fcd9c);
                            while (true) {
                                ai_closest = arraygetclosest(self.var_38f7500[i].origin, var_e4660bfb);
                                arrayremovevalue(var_e4660bfb, ai_closest);
                                if (ai_closest.var_24cf4025) {
                                    ai_closest.var_24cf4025 = 0;
                                    array::add(var_64e85e6d, ai_closest);
                                    if (var_64e85e6d.size > 1) {
                                        break;
                                    }
                                }
                                if (!var_e4660bfb.size) {
                                    iprintlnbold("NOT ENOUGH ROBOTS");
                                    self.var_38f7500[i].var_9145aecb = 0;
                                    self.var_3a11451c = 0;
                                    var_64e85e6d = [];
                                    break;
                                }
                                wait(0.05);
                            }
                            var_e4660bfb = [];
                        }
                        if (var_64e85e6d.size) {
                            self thread function_eaccc8a9(var_64e85e6d, self.var_38f7500[i]);
                        }
                        break;
                    }
                    iprintlnbold(self.playername + " DOES NOT HAVE ENOUGH ROBOTS");
                }
            }
        }
    }
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0x26b2d77f, Offset: 0x2b10
// Size: 0x22b
function function_9c52a47e(str_task, var_4639e1cf) {
    if (!isdefined(var_4639e1cf)) {
        var_4639e1cf = 0;
    }
    if (level.var_a6fbf51b) {
        return;
    }
    var_526a0aed = getent(str_task, "script_noteworthy");
    var_526a0aed endon(#"death");
    wait(var_4639e1cf);
    for (i = 0; i < level.var_38f7500.size; i++) {
        if (level.var_38f7500[i] === var_526a0aed && !level.var_38f7500[i].var_9145aecb) {
            while (level.var_641fcd9c.size < level.var_38f7500[i].n_required) {
                level notify(#"hash_725ff4d9");
                wait(0.05);
            }
            if (level.var_641fcd9c.size >= level.var_38f7500[i].n_required) {
                level.var_38f7500[i].var_9145aecb = 1;
                var_64e85e6d = [];
                var_e4660bfb = arraycopy(level.var_641fcd9c);
                while (true) {
                    ai_closest = arraygetclosest(level.var_38f7500[i].origin, var_e4660bfb);
                    arrayremovevalue(var_e4660bfb, ai_closest);
                    if (isalive(ai_closest) && ai_closest.var_24cf4025 && !ai_closest.iscrawler) {
                        ai_closest.var_24cf4025 = 0;
                        ai_closest util::magic_bullet_shield();
                        array::add(var_64e85e6d, ai_closest);
                        if (var_64e85e6d.size > 1) {
                            break;
                        }
                    }
                    if (!var_e4660bfb.size) {
                        level.var_38f7500[i].var_9145aecb = 0;
                        var_64e85e6d = [];
                        break;
                    }
                    wait(0.05);
                }
                var_e4660bfb = [];
                if (var_64e85e6d.size) {
                    level thread function_eaccc8a9(var_64e85e6d, level.var_38f7500[i]);
                }
                break;
            }
        }
    }
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0x6e29e4df, Offset: 0x2d48
// Size: 0x26a
function function_99f62595(v_moveto) {
    a_e_targets = getaiteamarray("axis");
    if (!self.var_3a11451c) {
        for (i = 0; i < a_e_targets.size; i++) {
            n_dist = distance2dsquared(self.origin, a_e_targets[i].origin);
            if (self util::is_player_looking_at(a_e_targets[i].origin, 0.95, 0, self) && self sightconetrace(a_e_targets[i] geteye(), a_e_targets[i]) && isalive(a_e_targets[i]) && n_dist < 5760000) {
                if (!isdefined(a_e_targets[i].var_9145aecb)) {
                    if (!isdefined(self.a_targets)) {
                        self.a_targets = [];
                    } else if (!isarray(self.a_targets)) {
                        self.a_targets = array(self.a_targets);
                    }
                    self.a_targets[self.a_targets.size] = a_e_targets[i];
                    self thread function_b5bd9226(a_e_targets[i], "target");
                    self thread function_570ccae9(a_e_targets[i]);
                }
            }
        }
    }
    if (self.a_targets.size) {
        foreach (var_f6c5842 in self.var_61a19dc6) {
            if (isalive(var_f6c5842) && var_f6c5842.var_24cf4025) {
                self thread function_32091ff6(var_f6c5842);
            }
        }
        return;
    }
    self function_5ab070f9(v_moveto);
    self playsoundtoplayer("evt_robocommand_assign_task", self);
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0xe48590e4, Offset: 0x2fc0
// Size: 0x42
function function_1214aaea() {
    self endon(#"death");
    wait(randomfloatrange(0.4, 1.2));
    if (isdefined(self)) {
        self playsound("evt_robocommand_acknowledge");
    }
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x93b485ce, Offset: 0x3010
// Size: 0x79
function function_a5f1ef25() {
    self endon(#"disconnect");
    self endon(#"hash_3b704051");
    if (isdefined(self.var_3459b224)) {
        self closeluimenu(self.var_3459b224);
        self.var_3459b224 = undefined;
    }
    self.var_3459b224 = self openluimenu("SquadInvalidPosMenu");
    wait(2);
    self closeluimenu(self.var_3459b224);
    self.var_3459b224 = undefined;
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0xd0807d38, Offset: 0x3098
// Size: 0x2e1
function function_5646c025() {
    self endon(#"disconnect");
    self endon(#"hash_f4ef75a1");
    while (true) {
        n_min_dist = 48;
        n_max_dist = 400;
        n_max_height = 48;
        if (isdefined(self.var_995495f2) && self.var_995495f2) {
            n_min_dist = 24;
            n_max_dist = 82;
            n_max_height = 0;
        }
        v_player_pos = getclosestpointonnavmesh(self.origin, 82, 32);
        if (isdefined(v_player_pos)) {
            a_v_points = util::positionquery_pointarray(v_player_pos, n_min_dist, n_max_dist, n_max_height, 100, 48);
            if (a_v_points.size >= self.var_61a19dc6.size) {
                self.var_61a19dc6 = arraysortclosest(self.var_61a19dc6, self.origin);
                for (i = 0; i < self.var_61a19dc6.size; i++) {
                    if (distance2dsquared(self.origin, self.var_61a19dc6[i].origin) > 40000) {
                        if (!self.var_61a19dc6[i].b_moving && !self.var_61a19dc6[i].var_99ebba13 && self.var_61a19dc6[i].var_24cf4025) {
                            self.var_61a19dc6[i] setgoal(a_v_points[i], 1);
                            wait(randomfloatrange(0.1, 0.3));
                        }
                    }
                }
            } else {
                var_cfd95255 = [];
                for (i = 0; i < self.var_61a19dc6.size; i++) {
                    if (distance2dsquared(self.origin, self.var_61a19dc6[i].origin) > 40000) {
                        if (!self.var_61a19dc6[i].b_moving && !self.var_61a19dc6[i].var_99ebba13 && self.var_61a19dc6[i].var_24cf4025) {
                            var_cfd95255[i] = getclosestpointonnavmesh(self.origin + (i * 50, i * 50, 0), 82, 32);
                            if (isdefined(var_cfd95255[i])) {
                                self.var_61a19dc6[i] setgoal(var_cfd95255[i], 1);
                                wait(randomfloatrange(0.1, 0.3));
                            }
                        }
                    }
                }
                var_cfd95255 = undefined;
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x9e74f015, Offset: 0x3388
// Size: 0x157
function function_475fb2a8() {
    self endon(#"disconnect");
    self endon(#"hash_f4ef75a1");
    while (true) {
        self waittill(#"player_downed");
        for (i = 0; i < self.var_61a19dc6.size; i++) {
            if (isalive(self.var_61a19dc6[i])) {
                self.var_61a19dc6[i] notify(#"hash_606e31a3");
                self.var_61a19dc6[i].var_99ebba13 = 0;
                self.var_61a19dc6[i].b_moving = 0;
                self.var_61a19dc6[i].str_action = "Standard";
                self.var_61a19dc6[i] notify(#"action");
            }
        }
        wait(0.5);
        if (self.a_targets.size) {
            foreach (e_target in self.a_targets) {
                if (isalive(e_target)) {
                    e_target thread function_14ec2d71(self);
                }
            }
        }
    }
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x40842989, Offset: 0x34e8
// Size: 0x4e
function function_3902f06d() {
    self endon(#"death");
    self endon(#"moving");
    str_msg = self util::waittill_any_timeout(20, "goal");
    if (str_msg == "goal") {
        wait(3);
    }
    self.b_moving = 0;
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0xe3161e76, Offset: 0x3540
// Size: 0xc8
function function_68efcbc3(var_f6c5842, var_ea15b761) {
    self endon(#"disconnect");
    self endon(#"hash_f4ef75a1");
    var_f6c5842 endon(#"moving");
    var_f6c5842 endon(#"death");
    str_msg = var_f6c5842 util::waittill_any_timeout(20, "goal");
    level notify(var_ea15b761);
    var_f6c5842 function_6142019a(self, 1);
    if (str_msg == "goal") {
        wait(3);
    }
    var_f6c5842 ai::set_behavior_attribute("move_mode", "escort");
    var_f6c5842.b_moving = 0;
    var_f6c5842.str_action = "Standard";
    var_f6c5842 notify(#"action");
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0xf69e61e8, Offset: 0x3610
// Size: 0x66
function function_b5bd9226(e_target, var_376507c0) {
    e_target endon(#"death");
    e_target endon(#"end");
    e_target function_14ec2d71(self);
    wait(0.05);
    e_target function_e228c18a(2, self);
    e_target.var_38c1e4c8 = 1;
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0x11b038e8, Offset: 0x3680
// Size: 0x52
function function_b2e2e2e2(e_target, var_376507c0) {
    e_target.var_6884cce4 = function_fe46cd6(var_376507c0, e_target getentitynumber(), e_target.origin + (0, 0, 72));
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0x53dc4525, Offset: 0x36e0
// Size: 0x92
function function_570ccae9(ai_target) {
    ai_target waittill(#"death");
    if (isdefined(ai_target) && isdefined(self.a_targets) && isinarray(self.a_targets, ai_target)) {
        arrayremovevalue(self.a_targets, ai_target);
    }
    if (isdefined(ai_target)) {
        ai_target function_14ec2d71();
    }
    if (isdefined(ai_target.var_6884cce4)) {
        ai_target.var_6884cce4 function_ac28ba8e();
    }
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0x3fa08d58, Offset: 0x3780
// Size: 0xd5
function function_bb612155(var_da565296) {
    var_da565296.var_9145aecb = 0;
    if (!isdefined(self.var_38f7500)) {
        self.var_38f7500 = [];
    } else if (!isarray(self.var_38f7500)) {
        self.var_38f7500 = array(self.var_38f7500);
    }
    self.var_38f7500[self.var_38f7500.size] = var_da565296;
    switch (var_da565296.script_noteworthy) {
    case 63:
        var_da565296.n_required = 2;
        break;
    case 62:
        var_da565296.n_required = 2;
        break;
    case 54:
        var_da565296.n_required = 1;
        break;
    }
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0x1be5e58e, Offset: 0x3860
// Size: 0x18d
function function_eaccc8a9(var_64e85e6d, var_da565296) {
    foreach (var_f6c5842 in var_64e85e6d) {
        if (isalive(var_f6c5842) && !var_f6c5842.iscrawler) {
            if (var_da565296.script_noteworthy == "floor_collapse") {
                var_f6c5842 ai::set_behavior_attribute("move_mode", "rambo");
            } else {
                var_f6c5842 ai::set_behavior_attribute("move_mode", "normal");
            }
            var_f6c5842 util::magic_bullet_shield();
            var_f6c5842.var_24cf4025 = 0;
            var_f6c5842 ai::disable_pain();
            var_f6c5842.ignoresuppression = 1;
            var_f6c5842 notify(#"hash_606e31a3");
            var_f6c5842 notify(#"hash_f383a3b8");
            var_f6c5842.str_action = "Interacting";
            var_f6c5842 notify(#"action");
            continue;
        }
        return;
    }
    switch (var_da565296.script_noteworthy) {
    case 63:
        self thread function_fa1babcf(var_64e85e6d, var_da565296);
        break;
    case 62:
        self thread function_62a18690(var_64e85e6d, var_da565296);
        break;
    }
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0xfe1d9618, Offset: 0x39f8
// Size: 0x448
function function_32091ff6(var_f6c5842) {
    var_f6c5842 endon(#"death");
    var_f6c5842 endon(#"hash_606e31a3");
    self endon(#"hash_f4ef75a1");
    self endon(#"disconnect");
    n_min_dist = 60;
    n_max_dist = -56;
    var_f6c5842.goalradius = 1024;
    var_f6c5842 ai::set_behavior_attribute("move_mode", "rusher");
    var_f6c5842 thread function_ee0e002(1, self);
    for (i = 0; i < self.a_targets.size; i++) {
        self.a_targets[i].var_d29e35d1 = 0;
        if (isalive(self.a_targets[i])) {
            if (self.a_targets[i].aitype === "spawner_enemy_54i_human_warlord_minigun") {
                continue;
            }
            v_target_pos = getclosestpointonnavmesh(self.a_targets[i].origin, 64, 16);
            if (isdefined(v_target_pos)) {
                a_v_points = util::positionquery_pointarray(v_target_pos, n_min_dist, n_max_dist, 70, 32, var_f6c5842);
                if (a_v_points.size >= self.var_61a19dc6.size) {
                    n_height_diff = abs(self.origin[2] - a_v_points[i][2]);
                    if (n_height_diff < -96 && distancesquared(self.origin, a_v_points[i]) < 1048576) {
                        var_f6c5842 setgoal(a_v_points[i], 1);
                    }
                    if (isactor(self.a_targets[i])) {
                        var_f6c5842 thread ai::shoot_at_target("kill_within_time", self.a_targets[i], undefined, 0.05, 100);
                    } else {
                        var_f6c5842 thread ai::shoot_at_target("shoot_until_target_dead", self.a_targets[i], undefined, 0.05, 100);
                    }
                } else {
                    var_f6c5842 ai::set_behavior_attribute("move_mode", "normal");
                    if (isactor(self.a_targets[i])) {
                        var_f6c5842 thread ai::shoot_at_target("kill_within_time", self.a_targets[i], undefined, 0.05, 100);
                    } else {
                        var_f6c5842 thread ai::shoot_at_target("shoot_until_target_dead", self.a_targets[i], undefined, 0.05, 100);
                    }
                }
            } else if (isactor(self.a_targets[i])) {
                var_f6c5842 thread ai::shoot_at_target("kill_within_time", self.a_targets[i], undefined, 0.05, 100);
            } else {
                var_f6c5842 thread ai::shoot_at_target("shoot_until_target_dead", self.a_targets[i], undefined, 0.05, 100);
            }
            self.a_targets[i].var_d29e35d1 = 1;
            var_f6c5842.var_99ebba13 = 1;
            var_f6c5842.str_action = "Attacking";
            var_f6c5842 notify(#"action");
            /#
                level util::debug_line(var_f6c5842.origin + (0, 0, 64), self.a_targets[i].origin + (0, 0, 64), (1, 0, 0), 0.1, undefined, 3);
            #/
            var_f6c5842 thread function_1214aaea();
        }
    }
    while (self.a_targets.size) {
        wait(0.05);
    }
    var_f6c5842 clearforcedgoal();
    var_f6c5842 thread function_ee0e002(0, self);
    var_f6c5842 ai::set_behavior_attribute("move_mode", "escort");
    var_f6c5842.var_99ebba13 = 0;
    var_f6c5842.str_action = "Standard";
    var_f6c5842 notify(#"action");
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0xbc16618d, Offset: 0x3e48
// Size: 0x2aa
function function_62a18690(var_64e85e6d, var_da565296) {
    level endon(#"hash_c791a545");
    if (isinarray(self.var_38f7500, var_da565296)) {
        arrayremovevalue(self.var_38f7500, var_da565296);
    }
    level thread function_4b9a48da(var_64e85e6d, "turret1_dead");
    level thread function_2b79dc3e();
    if (isdefined(var_da565296) && !level flag::get("turret1_dead")) {
        if (isalive(var_da565296)) {
            if (var_da565296 getteam() === "allies") {
                level flag::set("turret1_dead");
                return;
            }
            level thread scene::init("cin_bio_03_02_market_vign_targetkill_robot01", var_64e85e6d[0]);
            level thread scene::init("cin_bio_03_02_market_vign_targetkill_robot02", var_64e85e6d[1]);
            level util::waittill_multiple_ents(var_64e85e6d[0], "goal", var_64e85e6d[1], "goal");
            level thread scene::play("scene_turret1", "targetname", var_64e85e6d);
            var_da565296 util::magic_bullet_shield();
            level util::waittill_notify_or_timeout("floor_fall", 10);
            var_80951788 = getent("vendor_shop_turret_destroyed", "targetname");
            if (isdefined(var_80951788)) {
                var_80951788 delete();
            }
            level thread scene::play("p7_fxanim_cp_biodomes_turret_collapse_bundle");
            var_eaa951c2 = getent("turret_collapse", "targetname");
            if (isdefined(var_da565296) && isdefined(var_eaa951c2)) {
                var_da565296 linkto(var_eaa951c2, "turret_jnt");
                fx::play("ceiling_collapse", var_da565296.origin);
                playrumbleonposition("cp_biodomes_markets1_turret_collapse_rumble", var_da565296.origin);
            }
            level notify(#"hash_62a94152");
            if (isalive(var_da565296)) {
                var_da565296 util::stop_magic_bullet_shield();
                var_da565296 kill();
            }
        }
    }
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0xc5eb9136, Offset: 0x4100
// Size: 0x72
function function_2b79dc3e() {
    level endon(#"hash_62a94152");
    level flag::wait_till("turret1_dead");
    level scene::stop("cin_bio_03_02_market_vign_targetkill_robot01");
    level scene::stop("cin_bio_03_02_market_vign_targetkill_robot02");
    level scene::stop("scene_turret1", "targetname");
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0x48f44ed, Offset: 0x4180
// Size: 0x1b
function function_ee0e002(var_e33a0786, player) {
    self endon(#"death");
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0x48af2445, Offset: 0x4260
// Size: 0x82
function function_8c6434be(var_7cdd1744) {
    self endon(#"death");
    self endon(#"hash_f4ef75a1");
    if (level.var_a6fbf51b && isdefined(self.var_a8fcd329)) {
        self setluimenudata(self.var_a8fcd329, "squad_camo_amount", var_7cdd1744);
        var_a3b661c9 = %CP_MI_SING_BIODOMES_ROBOT_CAMO_ENERGY;
        self setluimenudata(self.var_a8fcd329, "squad_camo_text", var_a3b661c9);
    }
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x5f703837, Offset: 0x42f0
// Size: 0x135
function function_bd7db313() {
    self endon(#"death");
    self.var_6c93934a = 500;
    var_c9f0947a = int(self.var_6c93934a / 500 * 100);
    while (true) {
        if (level.var_31aefea8 == "objective_cloudmountain" && level.var_a6fbf51b) {
            break;
        }
        if (self.var_6c93934a < 500) {
            self.var_6c93934a = self.var_6c93934a + 20;
            if (self.var_6c93934a > 500) {
                self.var_6c93934a = 500;
            }
            var_c9f0947a = int(self.var_6c93934a / 500 * 100);
            self thread function_8c6434be(var_c9f0947a);
        }
        for (i = 0; i < self.var_61a19dc6.size; i++) {
            if (isdefined(self.var_61a19dc6[i].enemy)) {
                n_wait = 5;
                break;
            }
            n_wait = 0.5;
        }
        wait(n_wait);
    }
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0xb08ba375, Offset: 0x4430
// Size: 0x132
function function_87862943(player) {
    self endon(#"hash_8b094b58");
    self endon(#"death");
    player endon(#"death");
    if (player.var_6c93934a >= 10) {
        player.var_6c93934a -= 10;
        var_c9f0947a = int(player.var_6c93934a / 500 * 100);
        player thread function_8c6434be(var_c9f0947a);
        while (player.var_6c93934a >= 0) {
            wait(3);
            player.var_6c93934a -= 5;
            if (player.var_6c93934a < 0) {
                player.var_6c93934a = 0;
                self function_ee0e002(0, player);
            }
            var_c9f0947a = int(player.var_6c93934a / 500 * 100);
            player thread function_8c6434be(var_c9f0947a);
        }
        return;
    }
    self thread function_ee0e002(0, player);
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0xce971030, Offset: 0x4570
// Size: 0x147
function function_4b9a48da(var_64e85e6d, str_flag) {
    level flag::wait_till(str_flag);
    wait(0.5);
    foreach (var_f6c5842 in var_64e85e6d) {
        if (isalive(var_f6c5842)) {
            var_f6c5842 thread util::delay(10, "death", &util::stop_magic_bullet_shield);
            var_f6c5842.goalradius = 1024;
            var_f6c5842.ignoresuppression = 0;
            var_f6c5842 ai::set_ignoreall(0);
            var_f6c5842 ai::enable_pain();
            var_f6c5842.var_24cf4025 = 1;
            var_f6c5842.animname = undefined;
            var_f6c5842.str_action = "Standard";
            var_f6c5842 notify(#"action");
            var_f6c5842 clearforcedgoal();
            var_f6c5842 ai::set_behavior_attribute("move_mode", "normal");
        }
    }
    var_64e85e6d = [];
}

// Namespace namespace_36171bd3
// Params 3, eflags: 0x0
// Checksum 0xe421d735, Offset: 0x46c0
// Size: 0x18c
function function_cd484af8(v_goal, a_targets, str_endon) {
    self endon(#"death");
    level endon(str_endon);
    str_msg = self util::waittill_any_timeout(15, "goal");
    if (str_msg != "goal") {
        self setgoal(self.origin, 1);
        self waittill(#"goal");
        self forceteleport(v_goal);
        self setgoal(v_goal, 1);
    }
    if (isarray(a_targets)) {
        arraysortclosest(a_targets, self.origin);
        for (i = 0; i < a_targets.size; i++) {
            if (isalive(a_targets[i])) {
                self thread ai::shoot_at_target("normal", a_targets[i], undefined, 3);
                wait(3);
                if (isalive(a_targets[i])) {
                    a_targets[i] kill();
                }
            }
        }
        return;
    }
    if (isalive(a_targets)) {
        self thread ai::shoot_at_target("shoot_until_target_dead", a_targets);
        self waittill(#"stop_shoot_at_target");
    }
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0xc90d1d4b, Offset: 0x4858
// Size: 0x1aa
function function_fa1babcf(var_64e85e6d, var_da565296) {
    if (isinarray(self.var_38f7500, var_da565296)) {
        arrayremovevalue(self.var_38f7500, var_da565296);
    }
    level.var_2fd26037 colors::disable();
    level.var_2fd26037 notify(#"hash_93bef291");
    level thread function_4b9a48da(var_64e85e6d, "back_door_opened");
    level thread scene::init("cin_bio_06_01_backdoor_vign_open_hendricks", level.var_2fd26037);
    level thread scene::init("cin_bio_06_01_backdoor_vign_open_robot01", var_64e85e6d[0]);
    level thread scene::init("cin_bio_06_01_backdoor_vign_open_robot02", var_64e85e6d[1]);
    level util::waittill_multiple_ents(level.var_2fd26037, "goal", var_64e85e6d[0], "goal", var_64e85e6d[1], "goal");
    level thread function_69aa351a();
    level scene::play("scene_warehouse_door", "targetname");
    level flag::set("back_door_opened");
    level notify(#"open");
    if (isdefined(var_da565296)) {
        var_da565296 delete();
    }
    var_64e85e6d = [];
    level flag::wait_till("objective_warehouse_completed");
    level thread scene::stop("scene_warehouse_door", "targetname");
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0xfd19a5f8, Offset: 0x4a10
// Size: 0x62
function function_f5b04e6(nd_pos) {
    self endon(#"death");
    self setgoal(nd_pos, 1);
    self util::waittill_any_timeout(20, "goal");
    self clearforcedgoal();
    self.goalradius = 4;
    self.b_ready = 1;
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x616dac5a, Offset: 0x4a80
// Size: 0xb2
function function_69aa351a() {
    level waittill(#"hash_f2423fe9");
    var_b06d4473 = getent("back_door_player_clip", "targetname");
    var_b06d4473 delete();
    var_60f8f46f = getent("back_door_full_clip", "targetname");
    var_60f8f46f delete();
    var_bee08349 = getent("back_door_no_pen_clip", "targetname");
    var_bee08349 delete();
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0xb944a494, Offset: 0x4b40
// Size: 0x2a
function function_32fa03b2(n_wait, str_flag) {
    level endon(str_flag);
    wait(n_wait);
    level flag::set(str_flag);
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0xc9dd4e15, Offset: 0x4b78
// Size: 0x3a
function function_ccf72d08(var_61a19dc6, str_flag) {
    level endon(str_flag);
    array::wait_till(var_61a19dc6, "goal");
    level flag::set(str_flag);
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x2bca9b58, Offset: 0x4bc0
// Size: 0x33
function function_ba565c66() {
    self endon(#"disconnect");
    self endon(#"hash_f4ef75a1");
    if (level.var_a6fbf51b) {
        self waittill(#"hash_3484dc92");
        self notify(#"hash_f4ef75a1");
    }
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0xdb5b7440, Offset: 0x4c00
// Size: 0x23d
function function_e21506ba() {
    level endon(#"hash_b38d1391");
    level endon(#"hash_a68d9993");
    self waittill(#"death");
    arrayremovevalue(level.var_641fcd9c, self);
    n_timer = randomintrange(8, 15);
    level util::waittill_notify_or_timeout("spawn_friendly_robot", n_timer);
    var_63cc825f = 0;
    while (var_63cc825f == 0) {
        if (!level flag::get("back_door_opened")) {
            var_96336215 = getentarray("friendly_robot_reinforcement", "targetname");
            var_d5b88441 = [];
            foreach (spawner in var_96336215) {
                if (level.var_996e05eb === spawner.script_noteworthy) {
                    array::add(var_d5b88441, spawner, 0);
                }
            }
            if (var_d5b88441.size) {
                var_6bafcc3 = arraygetclosest(level.players[0].origin, var_d5b88441);
            } else {
                var_6bafcc3 = arraygetclosest(level.players[0].origin, var_96336215);
            }
            if (isdefined(var_6bafcc3)) {
                var_19ec51f9 = spawner::simple_spawn_single(var_6bafcc3);
                if (isalive(var_19ec51f9)) {
                    level function_66e5311c(var_19ec51f9);
                    var_19ec51f9.health = int(var_19ec51f9.health * 0.75);
                    var_19ec51f9.n_start_health = var_19ec51f9.health;
                    var_19ec51f9.start_health = var_19ec51f9.health;
                    var_63cc825f = 1;
                } else {
                    wait(3);
                }
            }
            continue;
        }
        break;
    }
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0xf66ddf98, Offset: 0x4e48
// Size: 0x64
function function_ba02c8e3(player) {
    self waittill(#"death");
    arrayremovevalue(player.var_61a19dc6, self);
    arrayremovevalue(level.var_641fcd9c, self);
    if (player.var_61a19dc6.size <= 0) {
        player notify(#"hash_3484dc92");
    }
}

// Namespace namespace_36171bd3
// Params 4, eflags: 0x0
// Checksum 0xb74b91ad, Offset: 0x4eb8
// Size: 0xfc
function function_fe46cd6(var_c0adf81f, var_95acca4a, v_pos, v_offset) {
    if (!isdefined(v_offset)) {
        v_offset = (0, 0, 0);
    }
    switch (var_c0adf81f) {
    case 58:
        var_5cbd0572 = "waypoint_targetneutral";
        break;
    case 102:
        var_5cbd0572 = "waypoint_captureneutral";
        break;
    case 101:
        var_5cbd0572 = "waypoint_circle_arrow_green";
        break;
    default:
        assertmsg("evt_robocommand_assign_task" + var_c0adf81f + " DOES NOT HAVE ENOUGH ROBOTS");
        break;
    }
    var_95ea7549 = objpoints::create(var_95acca4a, v_pos + v_offset, "all", var_5cbd0572, 0.75, 0.25);
    var_95ea7549 setwaypoint(0, var_5cbd0572);
    return var_95ea7549;
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x610bd8be, Offset: 0x4fc0
// Size: 0x12
function function_ac28ba8e() {
    objpoints::delete(self);
}

// Namespace namespace_36171bd3
// Params 12, eflags: 0x0
// Checksum 0xa1019ac2, Offset: 0x4fe0
// Size: 0xf1
function function_f0bf9ac3(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
    if (isdefined(eattacker) && isplayer(eattacker)) {
        if (smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_EXPLOSIVE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH") {
            return int(idamage);
        } else {
            idamage = 0;
        }
    }
    return int(idamage);
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0xbb59e521, Offset: 0x50e0
// Size: 0x32
function groundpos_ignore_water(origin) {
    return groundtrace(origin, origin + (0, 0, -100000), 0, undefined, 1)["position"];
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0xd50d0d4b, Offset: 0x5120
// Size: 0x1a
function function_a2bb4ee8() {
    return "keyline_outline_p" + self getentitynumber();
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x23ebca60, Offset: 0x5148
// Size: 0x1a
function function_4b7cb57c() {
    return "squad_indicator_p" + self getentitynumber();
}

// Namespace namespace_36171bd3
// Params 2, eflags: 0x0
// Checksum 0xdf0776ad, Offset: 0x5170
// Size: 0x4a
function function_6142019a(e_player, var_7071a6ab) {
    self endon(#"death");
    str_field = e_player function_4b7cb57c();
    self clientfield::set(str_field, var_7071a6ab);
}

// Namespace namespace_36171bd3
// Params 3, eflags: 0x0
// Checksum 0x8d40cfac, Offset: 0x51c8
// Size: 0x122
function function_e228c18a(var_5c592caf, e_player, var_199c44c9) {
    self endon(#"death");
    if (!isdefined(self.var_c3f3d0ef)) {
        self.var_c3f3d0ef = [];
    }
    a_players = getplayers();
    if (isdefined(e_player)) {
        a_players = array(e_player);
        e_player endon(#"disconnect");
    }
    foreach (player in a_players) {
        str_field = player function_a2bb4ee8();
        self clientfield::set(str_field, var_5c592caf);
        array::add(self.var_c3f3d0ef, e_player, 0);
    }
    self setforcenocull();
    self thread function_cccc1954();
}

// Namespace namespace_36171bd3
// Params 0, eflags: 0x0
// Checksum 0x2165217, Offset: 0x52f8
// Size: 0x32
function function_cccc1954() {
    self notify(#"hash_cccc1954");
    self endon(#"hash_cccc1954");
    self waittill(#"death");
    if (isdefined(self)) {
        self thread function_14ec2d71();
    }
}

// Namespace namespace_36171bd3
// Params 1, eflags: 0x0
// Checksum 0x9024628b, Offset: 0x5338
// Size: 0x10a
function function_14ec2d71(e_player) {
    a_players = getplayers();
    if (isdefined(e_player)) {
        a_players = array(e_player);
    }
    if (!isdefined(self.var_c3f3d0ef)) {
        self.var_c3f3d0ef = [];
    }
    foreach (player in a_players) {
        str_field = player function_a2bb4ee8();
        self clientfield::set(str_field, 0);
        arrayremovevalue(self.var_c3f3d0ef, player, 0);
    }
    if (isdefined(self.var_c3f3d0ef) && self.var_c3f3d0ef.size == 0) {
        self removeforcenocull();
    }
}

