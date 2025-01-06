#using scripts/codescripts/struct;
#using scripts/cp/_objectives;
#using scripts/cp/_util;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;

#namespace objectives;

// Namespace objectives
// Method(s) 13 Total 13
class class_60c78d95 {

    // Namespace namespace_60c78d95
    // Params 0, eflags: 0x0
    // Checksum 0xe72e69a1, Offset: 0xff0
    // Size: 0x6
    function function_9fe364f() {
        return false;
    }

    // Namespace namespace_60c78d95
    // Params 1, eflags: 0x0
    // Checksum 0xa755aac, Offset: 0xf28
    // Size: 0xba
    function function_e95d8ccb(e_target) {
        foreach (i, obj_id in self.m_a_game_obj) {
            ent = self.m_a_targets[i];
            if (isdefined(ent) && ent == e_target) {
                return obj_id;
            }
        }
        return -1;
    }

    // Namespace namespace_60c78d95
    // Params 1, eflags: 0x0
    // Checksum 0xf39d87d3, Offset: 0xe50
    // Size: 0xcc
    function function_c0eaea6e(e_target) {
        foreach (i, obj_id in self.m_a_game_obj) {
            ent = self.m_a_targets[i];
            if (isdefined(ent) && ent == e_target) {
                objective_state(obj_id, "active");
                return;
            }
        }
    }

    // Namespace namespace_60c78d95
    // Params 1, eflags: 0x0
    // Checksum 0xea5d996c, Offset: 0xd78
    // Size: 0xcc
    function function_66c6f97b(e_target) {
        foreach (i, obj_id in self.m_a_game_obj) {
            ent = self.m_a_targets[i];
            if (isdefined(ent) && ent == e_target) {
                objective_state(obj_id, "invisible");
                return;
            }
        }
    }

    // Namespace namespace_60c78d95
    // Params 1, eflags: 0x0
    // Checksum 0x395b10e7, Offset: 0xc08
    // Size: 0x162
    function show(e_player) {
        if (isdefined(e_player)) {
            assert(isplayer(e_player), "<dev string:x5b>");
            foreach (obj_id in self.m_a_game_obj) {
                objective_setvisibletoplayer(obj_id, e_player);
            }
            return;
        }
        foreach (obj_id in self.m_a_game_obj) {
            objective_setvisibletoall(obj_id);
        }
    }

    // Namespace namespace_60c78d95
    // Params 1, eflags: 0x0
    // Checksum 0x8b597ffd, Offset: 0xa98
    // Size: 0x162
    function hide(e_player) {
        if (isdefined(e_player)) {
            assert(isplayer(e_player), "<dev string:x28>");
            foreach (obj_id in self.m_a_game_obj) {
                objective_setinvisibletoplayer(obj_id, e_player);
            }
            return;
        }
        foreach (obj_id in self.m_a_game_obj) {
            objective_setinvisibletoall(obj_id);
        }
    }

    // Namespace namespace_60c78d95
    // Params 1, eflags: 0x0
    // Checksum 0xb18f993a, Offset: 0x820
    // Size: 0x26c
    function complete(var_3f17add1) {
        if (var_3f17add1.size > 0) {
            foreach (target in var_3f17add1) {
                for (i = self.m_a_targets.size - 1; i >= 0; i--) {
                    if (self.m_a_targets[i] == target) {
                        objective_state(self.m_a_game_obj[i], "done");
                        arrayremoveindex(self.m_a_game_obj, i);
                        arrayremoveindex(self.m_a_targets, i);
                        break;
                    }
                }
            }
        } else {
            foreach (var_47ca997a in self.m_a_game_obj) {
                objective_state(var_47ca997a, "done");
            }
            for (i = self.m_a_targets.size - 1; i >= 0; i--) {
                arrayremoveindex(self.m_a_game_obj, i);
                arrayremoveindex(self.m_a_targets, i);
            }
        }
        if (self.m_a_game_obj.size == 0) {
            arrayremovevalue(level.a_objectives, self, 1);
        }
    }

    // Namespace namespace_60c78d95
    // Params 1, eflags: 0x0
    // Checksum 0x38f22e8a, Offset: 0x668
    // Size: 0x1ac
    function function_56036d16(target) {
        if (isinarray(self.m_a_targets, target)) {
            return;
        }
        var_2d7defd1 = undefined;
        if (self.m_a_targets.size < self.m_a_game_obj.size) {
            var_2d7defd1 = self.m_a_game_obj[self.m_a_game_obj.size - 1];
        } else {
            var_2d7defd1 = gameobjects::get_next_obj_id();
            array::add(self.m_a_game_obj, var_2d7defd1);
        }
        if (isvec(target) || isentity(target)) {
            objective_add(var_2d7defd1, "active", target, istring(self.m_str_type));
        } else {
            objective_add(var_2d7defd1, "active", target.origin, istring(self.m_str_type));
        }
        array::add(self.m_a_targets, target);
        assert(self.m_a_targets.size == self.m_a_game_obj.size);
    }

    // Namespace namespace_60c78d95
    // Params 2, eflags: 0x0
    // Checksum 0xc55be099, Offset: 0x600
    // Size: 0x5c
    function function_1b8e225f(var_4bf4f2cf, var_9049b0da) {
        function_99cfbd30("obj_x", var_4bf4f2cf);
        if (isdefined(var_9049b0da)) {
            function_99cfbd30("obj_y", var_9049b0da);
        }
    }

    // Namespace namespace_60c78d95
    // Params 2, eflags: 0x0
    // Checksum 0x7b090724, Offset: 0x5a8
    // Size: 0x4c
    function function_99cfbd30(var_f85419ab, value) {
        var_2d7defd1 = self.m_a_game_obj[0];
        objective_setuimodelvalue(var_2d7defd1, var_f85419ab, value);
    }

    // Namespace namespace_60c78d95
    // Params 3, eflags: 0x0
    // Checksum 0xd71af9bb, Offset: 0x3c0
    // Size: 0x1dc
    function init(str_type, var_6497c82d, b_done) {
        if (!isdefined(b_done)) {
            b_done = 0;
        }
        self.m_a_targets = [];
        self.m_a_game_obj = [];
        self.m_str_type = str_type;
        if (b_done) {
            var_2d7defd1 = gameobjects::get_next_obj_id();
            self.m_a_game_obj = array(var_2d7defd1);
            objective_add(var_2d7defd1, "done", (0, 0, 0), istring(str_type));
            return;
        }
        if (isdefined(var_6497c82d) && var_6497c82d.size > 0) {
            foreach (target in var_6497c82d) {
                function_56036d16(target);
            }
            return;
        }
        var_2d7defd1 = gameobjects::get_next_obj_id();
        self.m_a_game_obj = array(var_2d7defd1);
        objective_add(var_2d7defd1, "active", (0, 0, 0), istring(str_type));
    }

}

// Namespace objectives
// Method(s) 12 Total 18
class class_1d3048b8 : class_60c78d95 {

    // Namespace namespace_1d3048b8
    // Params 0, eflags: 0x0
    // Checksum 0xef999e9c, Offset: 0x1d48
    // Size: 0xa
    function is_done() {
        return self.m_done;
    }

    // Namespace namespace_1d3048b8
    // Params 0, eflags: 0x0
    // Checksum 0x3fe0c49d, Offset: 0x1d38
    // Size: 0x8
    function function_9fe364f() {
        return true;
    }

    // Namespace namespace_1d3048b8
    // Params 1, eflags: 0x0
    // Checksum 0xff77e1ab, Offset: 0x1a50
    // Size: 0x2dc
    function function_1c66b4d2(player) {
        level endon("breadcrumb_" + self.m_str_type);
        level endon("breadcrumb_" + self.m_str_type + "_complete");
        player endon(#"death");
        var_b93b5b10 = self.var_d76d218f;
        entnum = player getentitynumber();
        obj_id = self.m_a_player_game_obj[entnum];
        objective_setvisibletoplayer(obj_id, player);
        do {
            var_fe6eb061 = getent(var_b93b5b10, "targetname");
            if (isdefined(var_fe6eb061)) {
                if (isdefined(var_fe6eb061.target)) {
                    if (isdefined(var_fe6eb061.script_flag_true)) {
                        objective_setinvisibletoplayer(obj_id, player);
                        level flag::wait_till(var_fe6eb061.script_flag_true);
                        objective_setvisibletoplayer(obj_id, player);
                    }
                    s_current = struct::get(var_fe6eb061.target, "targetname");
                    if (isdefined(s_current)) {
                        function_e3023aa1(player, s_current);
                    } else {
                        function_e3023aa1(player, var_fe6eb061);
                    }
                } else {
                    function_e3023aa1(player, var_fe6eb061);
                }
                var_b93b5b10 = var_fe6eb061.target;
                var_fe6eb061 trigger::wait_till(undefined, undefined, player);
                continue;
            }
            var_b93b5b10 = undefined;
        } while (isdefined(var_b93b5b10));
        objective_setinvisibletoplayer(obj_id, player);
        foreach (player in level.players) {
            player.var_924bb3b8 = undefined;
        }
        self.m_done = 1;
    }

    // Namespace namespace_1d3048b8
    // Params 2, eflags: 0x4
    // Checksum 0xdf5c259e, Offset: 0x1910
    // Size: 0x134
    function private function_e3023aa1(player, target) {
        entnum = player getentitynumber();
        obj_id = self.m_a_player_game_obj[entnum];
        var_a5b46d2f = 72;
        v_pos = target;
        if (!isvec(target)) {
            v_pos = target.origin;
            if (isdefined(target.script_height)) {
                var_a5b46d2f = target.script_height;
            }
        }
        v_pos = util::ground_position(v_pos, 300, var_a5b46d2f);
        player.var_924bb3b8 = v_pos;
        objective_position(obj_id, v_pos);
        objective_state(obj_id, "active");
    }

    // Namespace namespace_1d3048b8
    // Params 1, eflags: 0x0
    // Checksum 0x7d679bc9, Offset: 0x1850
    // Size: 0xb4
    function function_5c0f636a(player) {
        entnum = player getentitynumber();
        obj_id = self.m_a_player_game_obj[entnum];
        objective_setinvisibletoall(obj_id);
        objective_setvisibletoplayer(obj_id, player);
        objective_state(obj_id, "active");
        thread function_1c66b4d2(player);
    }

    // Namespace namespace_1d3048b8
    // Params 1, eflags: 0x0
    // Checksum 0x33d25588, Offset: 0x1798
    // Size: 0xaa
    function start(var_b93b5b10) {
        self.var_d76d218f = var_b93b5b10;
        self.m_done = 0;
        foreach (player in level.players) {
            function_5c0f636a(player);
        }
    }

    // Namespace namespace_1d3048b8
    // Params 1, eflags: 0x0
    // Checksum 0x30f9045, Offset: 0x1690
    // Size: 0xfe
    function show(e_player) {
        if (isdefined(e_player)) {
            assert(isplayer(e_player), "<dev string:x8e>");
            entnum = e_player getentitynumber();
            obj_id = self.m_a_player_game_obj[entnum];
            objective_setvisibletoplayer(obj_id, e_player);
            return;
        }
        for (i = 0; i < 4; i++) {
            obj_id = self.m_a_player_game_obj[i];
            objective_setvisibletoplayerbyindex(obj_id, i);
        }
    }

    // Namespace namespace_1d3048b8
    // Params 1, eflags: 0x0
    // Checksum 0x811d1ab3, Offset: 0x1588
    // Size: 0xfe
    function hide(e_player) {
        if (isdefined(e_player)) {
            assert(isplayer(e_player), "<dev string:x8e>");
            entnum = e_player getentitynumber();
            obj_id = self.m_a_player_game_obj[entnum];
            objective_setinvisibletoplayer(obj_id, e_player);
            return;
        }
        for (i = 0; i < 4; i++) {
            obj_id = self.m_a_player_game_obj[i];
            objective_setinvisibletoplayerbyindex(obj_id, i);
        }
    }

    // Namespace namespace_1d3048b8
    // Params 1, eflags: 0x0
    // Checksum 0xed9e6446, Offset: 0x1458
    // Size: 0x124
    function complete(var_3f17add1) {
        level notify("breadcrumb_" + self.m_str_type + "_complete");
        for (i = 0; i < 4; i++) {
            obj_id = self.m_a_player_game_obj[i];
            objective_state(obj_id, "done");
        }
        foreach (player in level.players) {
            player.var_924bb3b8 = undefined;
        }
        namespace_60c78d95::complete(var_3f17add1);
    }

    // Namespace namespace_1d3048b8
    // Params 3, eflags: 0x0
    // Checksum 0xc2fabe03, Offset: 0x12d0
    // Size: 0x17c
    function init(str_type, var_6497c82d, b_done) {
        if (!isdefined(b_done)) {
            b_done = 0;
        }
        namespace_60c78d95::init(str_type, var_6497c82d, b_done);
        self.var_d76d218f = "";
        self.m_done = b_done;
        self.m_a_player_game_obj = [];
        for (i = 0; i < 4; i++) {
            obj_id = gameobjects::get_next_obj_id();
            self.m_a_player_game_obj[i] = obj_id;
            if (self.m_done) {
                objective_add(obj_id, "done", (0, 0, 0), istring(self.m_str_type));
                continue;
            }
            objective_add(obj_id, "empty", (0, 0, 0), istring(self.m_str_type));
        }
        obj_id = self.m_a_game_obj[0];
        objective_setinvisibletoall(obj_id);
    }

}

// Namespace objectives
// Params 0, eflags: 0x2
// Checksum 0xb5c7ab63, Offset: 0x2260
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("objectives", &__init__, undefined, undefined);
}

// Namespace objectives
// Params 0, eflags: 0x0
// Checksum 0xffb95eb8, Offset: 0x22a0
// Size: 0x3c
function __init__() {
    level.a_objectives = [];
    level.var_f07569b2 = 0;
    callback::on_spawned(&on_player_spawned);
}

// Namespace objectives
// Params 3, eflags: 0x0
// Checksum 0xe5311779, Offset: 0x22e8
// Size: 0x1c2
function set(var_c0adf81f, var_3f17add1, var_464fc58b) {
    if (!isdefined(level.a_objectives)) {
        level.a_objectives = [];
    }
    if (!isdefined(var_464fc58b)) {
        var_464fc58b = 0;
    }
    if (!isdefined(var_3f17add1)) {
        var_3f17add1 = [];
    } else if (!isarray(var_3f17add1)) {
        var_3f17add1 = array(var_3f17add1);
    }
    var_14191e40 = undefined;
    if (isdefined(level.a_objectives[var_c0adf81f])) {
        var_14191e40 = level.a_objectives[var_c0adf81f];
        if (isdefined(var_3f17add1)) {
            foreach (target in var_3f17add1) {
                [[ var_14191e40 ]]->function_56036d16(target);
            }
        }
    } else {
        if (var_464fc58b) {
            var_14191e40 = new class_1d3048b8();
        } else {
            var_14191e40 = new class_60c78d95();
        }
        [[ var_14191e40 ]]->init(var_c0adf81f, var_3f17add1);
        level.a_objectives[var_c0adf81f] = var_14191e40;
    }
    return var_14191e40;
}

// Namespace objectives
// Params 2, eflags: 0x0
// Checksum 0x73b7b942, Offset: 0x24b8
// Size: 0x116
function complete(var_c0adf81f, var_3f17add1) {
    if (!isdefined(var_3f17add1)) {
        var_3f17add1 = [];
    } else if (!isarray(var_3f17add1)) {
        var_3f17add1 = array(var_3f17add1);
    }
    if (isdefined(level.a_objectives[var_c0adf81f])) {
        var_14191e40 = level.a_objectives[var_c0adf81f];
        [[ var_14191e40 ]]->complete(var_3f17add1);
        return;
    }
    if (var_c0adf81f == "cp_waypoint_breadcrumb") {
        var_14191e40 = new class_1d3048b8();
    } else {
        var_14191e40 = new class_60c78d95();
    }
    [[ var_14191e40 ]]->init(var_c0adf81f, undefined, 1);
    level.a_objectives[var_c0adf81f] = var_14191e40;
}

// Namespace objectives
// Params 2, eflags: 0x0
// Checksum 0x9ebb1b12, Offset: 0x25d8
// Size: 0xa0
function function_a5d62963(var_15231088, a_targets) {
    if (!isdefined(a_targets)) {
        a_targets = [];
    } else if (!isarray(a_targets)) {
        a_targets = array(a_targets);
    }
    o_obj = set(var_15231088, a_targets);
    [[ o_obj ]]->function_1b8e225f(0, a_targets.size);
}

// Namespace objectives
// Params 3, eflags: 0x0
// Checksum 0x3b343737, Offset: 0x2680
// Size: 0x58
function function_1b8e225f(var_15231088, var_4bf4f2cf, var_9049b0da) {
    o_obj = level.a_objectives[var_15231088];
    if (isdefined(o_obj)) {
        [[ o_obj ]]->function_1b8e225f(var_4bf4f2cf, var_9049b0da);
    }
}

// Namespace objectives
// Params 3, eflags: 0x0
// Checksum 0x3d66a80e, Offset: 0x26e0
// Size: 0x58
function set_value(var_15231088, var_f85419ab, value) {
    o_obj = level.a_objectives[var_15231088];
    if (isdefined(o_obj)) {
        [[ o_obj ]]->function_99cfbd30(var_f85419ab, value);
    }
}

// Namespace objectives
// Params 3, eflags: 0x0
// Checksum 0xab32e7af, Offset: 0x2740
// Size: 0x114
function breadcrumb(var_b93b5b10, var_15231088, var_684f50be) {
    if (!isdefined(var_15231088)) {
        var_15231088 = "cp_waypoint_breadcrumb";
    }
    if (!isdefined(var_684f50be)) {
        var_684f50be = 1;
    }
    level notify("breadcrumb_" + var_15231088);
    level endon("breadcrumb_" + var_15231088);
    if (isdefined(level.a_objectives[var_15231088])) {
        complete(var_15231088);
    }
    var_14191e40 = set(var_15231088, undefined, 1);
    [[ var_14191e40 ]]->start(var_b93b5b10);
    while (![[ var_14191e40 ]]->is_done()) {
        wait 0.05;
    }
    if (var_684f50be) {
        complete(var_15231088);
    }
}

// Namespace objectives
// Params 2, eflags: 0x0
// Checksum 0x725ddd3b, Offset: 0x2860
// Size: 0x7c
function hide(var_c0adf81f, e_player) {
    if (isdefined(level.a_objectives[var_c0adf81f])) {
        var_14191e40 = level.a_objectives[var_c0adf81f];
        [[ var_14191e40 ]]->hide(e_player);
        return;
    }
    assert(0, "<dev string:xcb>");
}

// Namespace objectives
// Params 2, eflags: 0x0
// Checksum 0xa326bcfc, Offset: 0x28e8
// Size: 0x7c
function function_66c6f97b(var_c0adf81f, e_target) {
    if (isdefined(level.a_objectives[var_c0adf81f])) {
        var_14191e40 = level.a_objectives[var_c0adf81f];
        [[ var_14191e40 ]]->function_66c6f97b(e_target);
        return;
    }
    assert(0, "<dev string:xcb>");
}

// Namespace objectives
// Params 2, eflags: 0x0
// Checksum 0xe9c9ce84, Offset: 0x2970
// Size: 0x7c
function show(var_c0adf81f, e_player) {
    if (isdefined(level.a_objectives[var_c0adf81f])) {
        var_14191e40 = level.a_objectives[var_c0adf81f];
        [[ var_14191e40 ]]->show(e_player);
        return;
    }
    assert(0, "<dev string:x10c>");
}

// Namespace objectives
// Params 2, eflags: 0x0
// Checksum 0xb48bd41, Offset: 0x29f8
// Size: 0x7c
function function_c0eaea6e(var_c0adf81f, e_target) {
    if (isdefined(level.a_objectives[var_c0adf81f])) {
        var_14191e40 = level.a_objectives[var_c0adf81f];
        [[ var_14191e40 ]]->function_c0eaea6e(e_target);
        return;
    }
    assert(0, "<dev string:xcb>");
}

// Namespace objectives
// Params 2, eflags: 0x0
// Checksum 0xf1481587, Offset: 0x2a80
// Size: 0xa0
function function_e95d8ccb(var_c0adf81f, e_target) {
    id = -1;
    if (isdefined(level.a_objectives[var_c0adf81f])) {
        var_14191e40 = level.a_objectives[var_c0adf81f];
        id = [[ var_14191e40 ]]->function_e95d8ccb(e_target);
    }
    if (id < 0) {
        assert(0, "<dev string:x14d>");
    }
    return id;
}

// Namespace objectives
// Params 1, eflags: 0x0
// Checksum 0x8fe357eb, Offset: 0x2b28
// Size: 0xa2
function function_43241b6f(var_b555fce7) {
    foreach (player in level.players) {
        util::function_964b7eb7(player, istring(var_b555fce7));
    }
}

// Namespace objectives
// Params 4, eflags: 0x0
// Checksum 0x55c2d488, Offset: 0x2bd8
// Size: 0x1d8
function function_fe46cd6(var_c0adf81f, var_95acca4a, v_pos, v_offset) {
    if (!isdefined(v_offset)) {
        v_offset = (0, 0, 0);
    }
    switch (var_c0adf81f) {
    case "target":
        var_5cbd0572 = "waypoint_targetneutral";
        break;
    case "capture":
        var_5cbd0572 = "waypoint_capture";
        break;
    case "capture_a":
        var_5cbd0572 = "waypoint_capture_a";
        break;
    case "capture_b":
        var_5cbd0572 = "waypoint_capture_b";
        break;
    case "capture_c":
        var_5cbd0572 = "waypoint_capture_c";
        break;
    case "defend":
        var_5cbd0572 = "waypoint_defend";
        break;
    case "defend_a":
        var_5cbd0572 = "waypoint_defend_a";
        break;
    case "defend_b":
        var_5cbd0572 = "waypoint_defend_b";
        break;
    case "defend_c":
        var_5cbd0572 = "waypoint_defend_c";
        break;
    case "return":
        var_5cbd0572 = "waypoint_return";
        break;
    default:
        assertmsg("<dev string:x18c>" + var_c0adf81f + "<dev string:x193>");
        break;
    }
    var_95ea7549 = objpoints::create(var_95acca4a, v_pos + v_offset, "all", var_5cbd0572);
    var_95ea7549 setwaypoint(1, var_5cbd0572);
    return var_95ea7549;
}

// Namespace objectives
// Params 0, eflags: 0x0
// Checksum 0xfd79d6b6, Offset: 0x2db8
// Size: 0x1c
function function_ac28ba8e() {
    objpoints::delete(self);
}

// Namespace objectives
// Params 0, eflags: 0x4
// Checksum 0x76e69d94, Offset: 0x2de0
// Size: 0xbe
function private on_player_spawned() {
    if (isdefined(level.a_objectives)) {
        foreach (var_14191e40 in level.a_objectives) {
            if ([[ var_14191e40 ]]->function_9fe364f() && ![[ var_14191e40 ]]->is_done()) {
                [[ var_14191e40 ]]->function_5c0f636a(self);
            }
        }
    }
}

