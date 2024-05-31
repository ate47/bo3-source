#using scripts/cp/_skipto;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace elevator;

// Namespace elevator
// Params 0, eflags: 0x2
// namespace_6018e357<file_0>::function_2dc19561
// Checksum 0x484bd289, Offset: 0x2d8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("elevator", &__init__, undefined, undefined);
}

// Namespace elevator
// Params 0, eflags: 0x1 linked
// namespace_6018e357<file_0>::function_8c87d8eb
// Checksum 0x302ca9a0, Offset: 0x318
// Size: 0x39c
function __init__() {
    var_a383aee8 = getentarray("elevator_trigger", "targetname");
    if (var_a383aee8.size <= 0) {
        return;
    }
    var_e9a8af4f = [];
    var_aca656dd = [];
    var_6e143534 = [];
    var_3efc9d86 = [];
    for (i = 0; i < var_a383aee8.size; i++) {
        var_82ee4bd8 = getentarray(var_a383aee8[i].target, "targetname");
        for (j = 0; j < var_82ee4bd8.size; j++) {
            if (var_82ee4bd8[j].classname == "script_brushmodel") {
                trigger_target = var_82ee4bd8[j];
                break;
            }
        }
        if (!isdefined(trigger_target)) {
            assertmsg("elevator_klaxon_speaker" + var_a383aee8[i].origin);
        }
        if (isdefined(trigger_target)) {
            var_3efc9d86 = getentarray(trigger_target.target, "targetname");
            var_aca656dd[var_aca656dd.size] = trigger_target;
        }
    }
    for (i = 0; i < var_e9a8af4f.size; i++) {
        platform = getent(var_e9a8af4f[i].target, "targetname");
        if (!isdefined(platform)) {
            assertmsg("elevator_klaxon_speaker" + var_e9a8af4f[i].origin);
            continue;
        }
        counter = 0;
        for (x = 0; x < var_6e143534.size; x++) {
            if (platform == var_6e143534[x]) {
                counter++;
            }
        }
        if (counter > 0) {
            continue;
        }
        var_6e143534[var_6e143534.size] = platform;
    }
    for (i = 0; i < var_aca656dd.size; i++) {
        counter = 0;
        for (x = 0; x < var_6e143534.size; x++) {
            if (var_aca656dd[i] == var_6e143534[x]) {
                counter++;
            }
        }
        if (counter > 0) {
            continue;
        }
        var_6e143534[var_6e143534.size] = var_aca656dd[i];
    }
    array::thread_all(var_6e143534, &function_685e3ca, 0);
}

// Namespace elevator
// Params 0, eflags: 0x1 linked
// namespace_6018e357<file_0>::function_685e3ca
// Checksum 0x59508032, Offset: 0x6c0
// Size: 0x584
function function_685e3ca() {
    self setmovingplatformenabled(1);
    var_963e7dc9 = [];
    var_38b2d855 = [];
    var_de4bc4e1 = [];
    var_ccb74de5 = undefined;
    platform = self;
    var_8b70705a = platform.targetname;
    platform.var_e20864cf = 1;
    var_a383aee8 = [];
    var_7c053dd5 = getentarray(var_8b70705a, "target");
    n_start_delay = 0;
    for (i = 0; i < var_7c053dd5.size; i++) {
        if (var_7c053dd5[i].classname == "script_model" || var_7c053dd5[i].classname == "script_brushmodel") {
            var_31353764 = getent(var_7c053dd5[i].targetname, "target");
            var_a383aee8[var_a383aee8.size] = var_31353764;
            continue;
        }
        var_a383aee8[var_a383aee8.size] = var_7c053dd5[i];
    }
    var_1564576c = getentarray(platform.target, "targetname");
    var_b116754 = struct::get_array(platform.target, "targetname");
    var_3823bc4b = arraycombine(var_1564576c, var_b116754, 1, 0);
    if (var_3823bc4b.size <= 0) {
        assertmsg("elevator_klaxon_speaker" + platform.origin);
    }
    if (isdefined(var_3823bc4b)) {
        for (i = 0; i < var_3823bc4b.size; i++) {
            if (isdefined(var_3823bc4b[i].script_noteworthy)) {
                if (var_3823bc4b[i].script_noteworthy == "audio_point") {
                    var_963e7dc9[var_963e7dc9.size] = var_3823bc4b[i];
                }
                if (var_3823bc4b[i].script_noteworthy == "elevator_door") {
                    var_de4bc4e1[var_de4bc4e1.size] = var_3823bc4b[i];
                }
                if (var_3823bc4b[i].script_noteworthy == "elevator_klaxon_speaker") {
                    var_38b2d855[var_38b2d855.size] = var_3823bc4b[i];
                }
                if (var_3823bc4b[i].script_noteworthy == "platform_start") {
                    var_ccb74de5 = function_dbaa007d(var_3823bc4b[i]);
                }
            }
        }
    }
    if (!isdefined(var_ccb74de5)) {
        assertmsg("elevator_klaxon_speaker" + platform.origin);
    }
    if (isdefined(var_de4bc4e1) && var_de4bc4e1.size > 0) {
        array::thread_all(var_de4bc4e1, &function_9cdfa1cb, var_8b70705a, platform);
    }
    if (isdefined(var_38b2d855) && var_38b2d855.size > 0) {
        array::thread_all(var_38b2d855, &function_f8c94c1b, "elevator_" + var_8b70705a + "_move", "stop_" + var_8b70705a + "_movement_sound");
    }
    if (isdefined(var_963e7dc9) && var_963e7dc9.size > 0) {
        array::thread_all(var_963e7dc9, &function_f8c94c1b, "start_" + var_8b70705a + "_klaxon", "stop_" + var_8b70705a + "_klaxon");
    }
    array::thread_all(var_a383aee8, &trigger_think, var_8b70705a);
    platform.var_be2ea7e9 = spawn("script_origin", self.origin);
    platform.var_be2ea7e9 linkto(self);
    platform thread move_platform(var_ccb74de5, var_8b70705a, n_start_delay);
}

// Namespace elevator
// Params 1, eflags: 0x1 linked
// namespace_6018e357<file_0>::function_dbaa007d
// Checksum 0x90796d1c, Offset: 0xc50
// Size: 0x134
function function_dbaa007d(s_start_point) {
    var_190bcb6b = s_start_point;
    if (isdefined(var_190bcb6b.script_objective)) {
        world flag::wait_till("skipto_player_connected");
        waittillframeend();
        if (level flag::get(var_190bcb6b.script_objective + "_completed")) {
            while (true) {
                if (isdefined(var_190bcb6b.target)) {
                    var_190bcb6b = struct::get(var_190bcb6b.target, "targetname");
                } else {
                    break;
                }
                if (isdefined(var_190bcb6b.script_objective)) {
                    if (var_190bcb6b.script_objective == level.var_c0e97bd) {
                        break;
                    }
                }
            }
        }
    }
    if (isdefined(var_190bcb6b.script_wait)) {
        n_start_delay = var_190bcb6b.script_wait;
    }
    return var_190bcb6b;
}

// Namespace elevator
// Params 1, eflags: 0x1 linked
// namespace_6018e357<file_0>::function_b2dfa7a2
// Checksum 0x1bfc28c, Offset: 0xd90
// Size: 0x150
function trigger_think(var_8b70705a) {
    self endon(#"death");
    level endon(var_8b70705a + "_disabled");
    if (isdefined(level.heroes) && isdefined(self.script_string) && self.script_string == "all_heroes") {
        self thread function_5eba01bd(var_8b70705a);
    }
    while (true) {
        self trigger::wait_till();
        level notify("start_" + var_8b70705a + "_klaxon");
        level notify("close_" + var_8b70705a + "_doors");
        if (isdefined(self.script_wait)) {
            wait(self.script_wait);
        } else {
            wait(2);
        }
        level notify("elevator_" + var_8b70705a + "_move");
        level waittill("elevator_" + var_8b70705a + "_stop");
        level notify("stop_" + var_8b70705a + "_klaxon");
        level notify("open_" + var_8b70705a + "_doors");
    }
}

// Namespace elevator
// Params 1, eflags: 0x1 linked
// namespace_6018e357<file_0>::function_5eba01bd
// Checksum 0x16b19c8f, Offset: 0xee8
// Size: 0x138
function function_5eba01bd(var_8b70705a) {
    level endon("elevator_" + var_8b70705a + "_move");
    level endon(var_8b70705a + "_disabled");
    var_d93a8d4d = 0;
    wait(1);
    while (true) {
        var_d93a8d4d = 1;
        foreach (hero in level.heroes) {
            var_d93a8d4d &= hero istouching(self);
        }
        if (var_d93a8d4d) {
            self triggerenable(1);
        } else {
            self triggerenable(0);
        }
        wait(0.2);
    }
}

// Namespace elevator
// Params 2, eflags: 0x1 linked
// namespace_6018e357<file_0>::function_f8c94c1b
// Checksum 0xe5dd8ec5, Offset: 0x1028
// Size: 0x5c
function function_f8c94c1b(var_544bc7c7, notify_stop) {
    level waittill(var_544bc7c7);
    if (isdefined(self.script_sound)) {
        self thread sound::loop_in_space(level.scr_sound[self.script_sound], self.origin, notify_stop);
    }
}

// Namespace elevator
// Params 2, eflags: 0x1 linked
// namespace_6018e357<file_0>::function_9cdfa1cb
// Checksum 0x3a0bcd7b, Offset: 0x1090
// Size: 0x2d4
function function_9cdfa1cb(var_8b70705a, platform) {
    open_struct = struct::get(self.target, "targetname");
    if (!isdefined(open_struct)) {
        assertmsg("elevator_klaxon_speaker" + self.origin);
    }
    if (isdefined(open_struct.target)) {
        var_f0bc435f = struct::get(open_struct.target, "targetname");
    }
    if (!isdefined(var_f0bc435f)) {
        assertmsg("elevator_klaxon_speaker" + self.origin);
    }
    if (isdefined(open_struct.script_float)) {
        var_73345118 = open_struct.script_float;
    } else {
        var_73345118 = 1;
    }
    if (isdefined(var_f0bc435f.script_float)) {
        var_ef73127f = var_f0bc435f.script_float;
    } else {
        var_ef73127f = 1;
    }
    var_b1d2ef55 = 0;
    if (isdefined(var_f0bc435f.script_noteworthy) && var_f0bc435f.script_noteworthy == "stay_closed") {
        var_b1d2ef55 = 1;
    }
    self.origin = open_struct.origin;
    self.angles = open_struct.angles;
    var_26dfbb14 = var_f0bc435f.origin - self.origin;
    var_ebf964d9 = var_f0bc435f.angles - self.angles;
    var_9a35a990 = self.origin - var_f0bc435f.origin;
    var_35a4cf2b = self.angles - var_f0bc435f.angles;
    self thread function_f8655445(var_8b70705a, "close_", platform, var_26dfbb14, var_ebf964d9, var_ef73127f);
    if (!var_b1d2ef55) {
        self thread function_f8655445(var_8b70705a, "open_", platform, var_9a35a990, var_35a4cf2b, var_73345118);
    }
}

// Namespace elevator
// Params 6, eflags: 0x1 linked
// namespace_6018e357<file_0>::function_f8655445
// Checksum 0xfce5b524, Offset: 0x1370
// Size: 0x108
function function_f8655445(var_8b70705a, direction, platform, v_moveto, v_angles, n_time) {
    level endon(var_8b70705a + "_disabled");
    self linkto(platform);
    while (true) {
        level waittill(direction + var_8b70705a + "_doors");
        self unlink();
        self moveto(self.origin + v_moveto, n_time);
        self rotateto(self.angles + v_angles, n_time);
        wait(n_time);
        self linkto(platform);
    }
}

// Namespace elevator
// Params 3, eflags: 0x1 linked
// namespace_6018e357<file_0>::function_9d50f6ac
// Checksum 0xba4ce7d2, Offset: 0x1480
// Size: 0x504
function move_platform(var_ccb74de5, var_8b70705a, n_start_delay) {
    level endon(var_8b70705a + "_disabled");
    move_path = [];
    var_95fa47b1 = 0;
    if (isdefined(var_ccb74de5.script_objective)) {
        self.origin = var_ccb74de5.origin;
        self.angles = var_ccb74de5.angles;
    }
    self.var_8b70705a = var_8b70705a;
    if (!isdefined(move_path)) {
        move_path = [];
    } else if (!isarray(move_path)) {
        move_path = array(move_path);
    }
    move_path[move_path.size] = var_ccb74de5;
    if (isdefined(var_ccb74de5.target)) {
        var_985798ea = struct::get(var_ccb74de5.target, "targetname");
    }
    if (!isdefined(var_985798ea)) {
        return;
    }
    path = 1;
    var_eef38cd8 = var_ccb74de5;
    while (path) {
        if (isdefined(var_eef38cd8.target)) {
            var_eef38cd8 = struct::get(var_eef38cd8.target, "targetname");
            if (isdefined(var_eef38cd8) && move_path[0] != var_eef38cd8) {
                if (!isdefined(move_path)) {
                    move_path = [];
                } else if (!isarray(move_path)) {
                    move_path = array(move_path);
                }
                move_path[move_path.size] = var_eef38cd8;
            } else {
                var_95fa47b1 = 1;
                path = 0;
            }
            continue;
        }
        path = 0;
    }
    while (true) {
        level waittill("elevator_" + var_8b70705a + "_move");
        wait(n_start_delay);
        if (isdefined(level.scr_sound) && isdefined(level.scr_sound["elevator_start"])) {
            self playsound(level.scr_sound["elevator_start"]);
        }
        self playsound("veh_" + var_8b70705a + "_start");
        self.var_be2ea7e9 playloopsound("veh_" + var_8b70705a + "_loop", 0.5);
        speed = -1;
        do {
            for (i = 0; i < move_path.size; i++) {
                org = move_path[i];
                if (!isdefined(org)) {
                    continue;
                }
                if (self.origin != org.origin) {
                    speed = function_e9e4fc6f(org, speed);
                    time = distance(self.origin, org.origin) / speed;
                    time = time <= 0 ? 1 : time;
                    self moveto(org.origin, time, time / 2, time / 2);
                    self rotateto(org.angles, time, time * 0.5, time * 0.5);
                    self waittill(#"movedone");
                }
                function_8a110bd3(org, var_8b70705a);
            }
        } while (isdefined(var_95fa47b1) && var_95fa47b1);
        stop();
        move_path = array::reverse(move_path);
        self.var_e20864cf = !self.var_e20864cf;
    }
}

// Namespace elevator
// Params 0, eflags: 0x1 linked
// namespace_6018e357<file_0>::function_fcf56ab5
// Checksum 0x4c5020c7, Offset: 0x1990
// Size: 0x12c
function stop() {
    level notify("elevator_" + self.var_8b70705a + "_stop");
    level notify("stop_" + self.var_8b70705a + "_movement_sound");
    self.origin = self.origin;
    self.angles = self.angles;
    if (isdefined(self.script_sound)) {
        self playsound(level.scr_sound[self.script_sound]);
    }
    self.var_be2ea7e9 stoploopsound(0.5);
    self playsound("veh_" + self.var_8b70705a + "_stop");
    if (isdefined(level.scr_sound) && isdefined(level.scr_sound["elevator_end"])) {
        self playsound(level.scr_sound["elevator_end"]);
    }
}

// Namespace elevator
// Params 2, eflags: 0x1 linked
// namespace_6018e357<file_0>::function_8a110bd3
// Checksum 0x6c21270a, Offset: 0x1ac8
// Size: 0x124
function function_8a110bd3(node, var_8b70705a) {
    if (isdefined(node.script_notify)) {
        level notify(node.script_notify);
        self notify(node.script_notify);
    }
    if (isdefined(node.script_waittill)) {
        level util::waittill_any_ents_two(level, node.script_waittill, self, node.script_waittill);
    }
    if (isdefined(node.script_wait)) {
        self playsound("veh_" + var_8b70705a + "_dc");
        wait(node.script_wait);
        level notify("elevator_" + self.var_8b70705a + "_script_wait_done");
        self notify("elevator_" + self.var_8b70705a + "_script_wait_done");
    }
}

// Namespace elevator
// Params 2, eflags: 0x1 linked
// namespace_6018e357<file_0>::function_e9e4fc6f
// Checksum 0xf0f10bbc, Offset: 0x1bf8
// Size: 0x54
function function_e9e4fc6f(var_152c3913, speed) {
    if (speed <= 0) {
        speed = 100;
    }
    if (isdefined(var_152c3913.speed)) {
        speed = var_152c3913.speed;
    }
    return speed;
}

