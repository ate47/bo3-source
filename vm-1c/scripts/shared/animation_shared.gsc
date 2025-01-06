#using scripts/shared/ai_shared;
#using scripts/shared/animation_debug_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/string_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace animation;

// Namespace animation
// Params 0, eflags: 0x2
// Checksum 0xf3a6087f, Offset: 0x400
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("animation", &__init__, undefined, undefined);
}

// Namespace animation
// Params 0, eflags: 0x0
// Checksum 0xc21fee9b, Offset: 0x440
// Size: 0x64
function __init__() {
    if (getdvarstring("debug_anim_shared", "") == "") {
        setdvar("debug_anim_shared", "");
    }
    setup_notetracks();
}

// Namespace animation
// Params 3, eflags: 0x0
// Checksum 0x49d543f3, Offset: 0x4b0
// Size: 0x3c
function first_frame(animation, v_origin_or_ent, v_angles_or_tag) {
    self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0);
}

// Namespace animation
// Params 3, eflags: 0x0
// Checksum 0x8f834de8, Offset: 0x4f8
// Size: 0x4c
function last_frame(animation, v_origin_or_ent, v_angles_or_tag) {
    self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0, 0, 0, 0, 1);
}

// Namespace animation
// Params 10, eflags: 0x0
// Checksum 0xa5839b39, Offset: 0x550
// Size: 0x160
function play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, n_start_time, b_show_player_firstperson_weapon, b_unlink_after_completed) {
    if (!isdefined(n_rate)) {
        n_rate = 1;
    }
    if (!isdefined(n_blend_in)) {
        n_blend_in = 0.2;
    }
    if (!isdefined(n_blend_out)) {
        n_blend_out = 0.2;
    }
    if (!isdefined(n_lerp)) {
        n_lerp = 0;
    }
    if (!isdefined(n_start_time)) {
        n_start_time = 0;
    }
    if (!isdefined(b_show_player_firstperson_weapon)) {
        b_show_player_firstperson_weapon = 0;
    }
    if (!isdefined(b_unlink_after_completed)) {
        b_unlink_after_completed = 1;
    }
    if (sessionmodeiszombiesgame() && self isragdoll()) {
        return;
    }
    self endon(#"death");
    self thread _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, n_start_time, b_show_player_firstperson_weapon, b_unlink_after_completed);
    self waittill(#"scriptedanim");
}

// Namespace animation
// Params 1, eflags: 0x0
// Checksum 0x55008a83, Offset: 0x6b8
// Size: 0x54
function stop(n_blend) {
    if (!isdefined(n_blend)) {
        n_blend = 0.2;
    }
    flagsys::clear("scriptedanim");
    self stopanimscripted(n_blend);
}

/#

    // Namespace animation
    // Params 2, eflags: 0x0
    // Checksum 0x708ee70e, Offset: 0x718
    // Size: 0x1b4
    function debug_print(str_animation, str_msg) {
        str_dvar = getdvarstring("<dev string:x28>", "<dev string:x3a>");
        if (str_dvar != "<dev string:x3a>") {
            b_print = 0;
            if (strisnumber(str_dvar)) {
                if (int(str_dvar) > 0) {
                    b_print = 1;
                }
            } else if (isdefined(self.animname) && (issubstr(str_animation, str_dvar) || issubstr(self.animname, str_dvar))) {
                b_print = 1;
            }
            if (b_print) {
                printtoprightln(str_animation + "<dev string:x3b>" + string::function_8e23acba(str_msg, 10) + "<dev string:x3b>" + string::function_8e23acba("<dev string:x3a>" + self getentitynumber(), 4) + "<dev string:x3f>" + string::function_8e23acba("<dev string:x3a>" + gettime(), 6) + "<dev string:x42>", (1, 1, 0), -1);
            }
        }
    }

#/

// Namespace animation
// Params 10, eflags: 0x0
// Checksum 0x2c4a6fc7, Offset: 0x8d8
// Size: 0x64c
function _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, n_start_time, b_show_player_firstperson_weapon, b_unlink_after_completed) {
    self endon(#"death");
    self notify(#"new_scripted_anim");
    self endon(#"new_scripted_anim");
    /#
        debug_print(animation, "<dev string:x44>");
    #/
    flagsys::set_val("firstframe", n_rate == 0);
    flagsys::set("scripted_anim_this_frame");
    flagsys::set("scriptedanim");
    if (!isdefined(v_origin_or_ent)) {
        v_origin_or_ent = self;
    }
    b_link = 0;
    if (isdefined(self.n_script_anim_rate)) {
        n_rate = self.n_script_anim_rate;
    }
    if (isvec(v_origin_or_ent) && isvec(v_angles_or_tag)) {
        self animscripted(animation, v_origin_or_ent, v_angles_or_tag, animation, "normal", undefined, n_rate, n_blend_in, n_lerp, n_start_time, 1, b_show_player_firstperson_weapon);
    } else if (isstring(v_angles_or_tag)) {
        assert(isdefined(v_origin_or_ent.model), "<dev string:x4c>" + animation + "<dev string:x65>" + v_angles_or_tag + "<dev string:x70>");
        v_pos = v_origin_or_ent gettagorigin(v_angles_or_tag);
        v_ang = v_origin_or_ent gettagangles(v_angles_or_tag);
        if (n_lerp > 0) {
            prevorigin = self.origin;
            prevangles = self.angles;
        }
        if (!isdefined(v_pos)) {
            v_pos = v_origin_or_ent.origin;
            v_ang = v_origin_or_ent.angles;
        }
        if (isactor(self)) {
            self forceteleport(v_pos, v_ang);
        } else {
            self.origin = v_pos;
            self.angles = v_ang;
        }
        b_link = 1;
        self linkto(v_origin_or_ent, v_angles_or_tag, (0, 0, 0), (0, 0, 0));
        if (n_lerp > 0) {
            if (isactor(self)) {
                self forceteleport(prevorigin, prevangles);
            } else {
                self.origin = prevorigin;
                self.angles = prevangles;
            }
        }
        self animscripted(animation, v_pos, v_ang, animation, "normal", undefined, n_rate, n_blend_in, n_lerp, n_start_time, 1, b_show_player_firstperson_weapon);
    } else {
        v_angles = isdefined(v_origin_or_ent.angles) ? v_origin_or_ent.angles : (0, 0, 0);
        self animscripted(animation, v_origin_or_ent.origin, v_angles, animation, "normal", undefined, n_rate, n_blend_in, n_lerp, n_start_time, 1, b_show_player_firstperson_weapon);
    }
    if (isplayer(self)) {
        set_player_clamps();
    }
    /#
        self thread anim_info_render_thread(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp);
    #/
    if (!isanimlooping(animation) && n_blend_out > 0 && n_rate > 0 && n_start_time < 1) {
        if (!animhasnotetrack(animation, "start_ragdoll")) {
            self thread _blend_out(animation, n_blend_out, n_rate, n_start_time);
        }
    }
    self thread handle_notetracks(animation);
    if (getanimframecount(animation) > 1 || isanimlooping(animation)) {
        self waittillmatch(animation, "end");
    } else {
        wait 0.05;
    }
    if (isdefined(b_unlink_after_completed) && b_link && b_unlink_after_completed) {
        self unlink();
    }
    flagsys::clear("scriptedanim");
    flagsys::clear("firstframe");
    /#
        debug_print(animation, "<dev string:xa3>");
    #/
    waittillframeend();
    flagsys::clear("scripted_anim_this_frame");
}

// Namespace animation
// Params 4, eflags: 0x0
// Checksum 0x4bf8531c, Offset: 0xf30
// Size: 0x11c
function _blend_out(animation, n_blend, n_rate, n_start_time) {
    self endon(#"death");
    self endon(#"end");
    self endon(#"scriptedanim");
    self endon(#"new_scripted_anim");
    n_server_length = floor(getanimlength(animation) / 0.05) * 0.05;
    while (true) {
        n_current_time = self getanimtime(animation) * n_server_length;
        n_time_left = n_server_length - n_current_time;
        if (n_time_left <= n_blend) {
            self stopanimscripted(n_blend);
            break;
        }
        wait 0.05;
    }
}

// Namespace animation
// Params 1, eflags: 0x0
// Checksum 0x97c3831f, Offset: 0x1058
// Size: 0x5c
function _get_align_ent(e_align) {
    e = self;
    if (isdefined(e_align)) {
        e = e_align;
    }
    if (!isdefined(e.angles)) {
        e.angles = (0, 0, 0);
    }
    return e;
}

// Namespace animation
// Params 2, eflags: 0x0
// Checksum 0xbc4ce7cd, Offset: 0x10c0
// Size: 0x1e0
function _get_align_pos(v_origin_or_ent, v_angles_or_tag) {
    if (!isdefined(v_origin_or_ent)) {
        v_origin_or_ent = self.origin;
    }
    if (!isdefined(v_angles_or_tag)) {
        v_angles_or_tag = isdefined(self.angles) ? self.angles : (0, 0, 0);
    }
    s = spawnstruct();
    if (isvec(v_origin_or_ent)) {
        assert(isvec(v_angles_or_tag), "<dev string:xa9>");
        s.origin = v_origin_or_ent;
        s.angles = v_angles_or_tag;
    } else {
        e_align = _get_align_ent(v_origin_or_ent);
        if (isstring(v_angles_or_tag)) {
            s.origin = e_align gettagorigin(v_angles_or_tag);
            s.angles = e_align gettagangles(v_angles_or_tag);
        } else {
            s.origin = e_align.origin;
            s.angles = e_align.angles;
        }
    }
    if (!isdefined(s.angles)) {
        s.angles = (0, 0, 0);
    }
    return s;
}

// Namespace animation
// Params 4, eflags: 0x0
// Checksum 0x36569c1d, Offset: 0x12a8
// Size: 0x130
function teleport(animation, v_origin_or_ent, v_angles_or_tag, time) {
    if (!isdefined(time)) {
        time = 0;
    }
    s = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
    v_pos = getstartorigin(s.origin, s.angles, animation, time);
    v_ang = getstartangles(s.origin, s.angles, animation, time);
    if (isactor(self)) {
        self forceteleport(v_pos, v_ang);
        return;
    }
    self.origin = v_pos;
    self.angles = v_ang;
}

// Namespace animation
// Params 4, eflags: 0x0
// Checksum 0x31e0a4b9, Offset: 0x13e0
// Size: 0x9a
function reach(animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals) {
    if (!isdefined(b_disable_arrivals)) {
        b_disable_arrivals = 0;
    }
    self endon(#"death");
    s_tracker = spawnstruct();
    self thread _reach(s_tracker, animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals);
    s_tracker waittill(#"done");
}

// Namespace animation
// Params 5, eflags: 0x0
// Checksum 0x70f24866, Offset: 0x1488
// Size: 0x38a
function _reach(s_tracker, animation, v_origin_or_ent, v_angles_or_tag, b_disable_arrivals) {
    if (!isdefined(b_disable_arrivals)) {
        b_disable_arrivals = 0;
    }
    self endon(#"death");
    self notify(#"stop_going_to_node");
    self notify(#"new_anim_reach");
    flagsys::wait_till_clear("anim_reach");
    flagsys::set("anim_reach");
    s = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
    goal = getstartorigin(s.origin, s.angles, animation);
    n_delta = distancesquared(goal, self.origin);
    if (n_delta > 16) {
        self stopanimscripted(0.2);
        if (b_disable_arrivals) {
            if (ai::has_behavior_attribute("disablearrivals")) {
                ai::set_behavior_attribute("disablearrivals", 1);
            }
            self.stopanimdistsq = 0.0001;
        }
        if (isdefined(self.archetype) && self.archetype == "robot") {
            ai::set_behavior_attribute("rogue_control_force_goal", goal);
        } else if (ai::has_behavior_attribute("vignette_mode") && !(isdefined(self.ignorevignettemodeforanimreach) && self.ignorevignettemodeforanimreach)) {
            ai::set_behavior_attribute("vignette_mode", "fast");
        }
        self thread ai::force_goal(goal, 15, 1, undefined, 0, 1);
        /#
            self thread debug_anim_reach();
        #/
        self util::waittill_any("goal", "new_anim_reach", "new_scripted_anim", "stop_scripted_anim");
        if (ai::has_behavior_attribute("disablearrivals")) {
            ai::set_behavior_attribute("disablearrivals", 0);
            self.stopanimdistsq = 0;
        }
    } else {
        waittillframeend();
    }
    if (!(isdefined(self.archetype) && self.archetype == "robot") && ai::has_behavior_attribute("vignette_mode")) {
        ai::set_behavior_attribute("vignette_mode", "off");
    }
    flagsys::clear("anim_reach");
    s_tracker notify(#"done");
    self notify(#"reach_done");
}

/#

    // Namespace animation
    // Params 0, eflags: 0x0
    // Checksum 0x1742e918, Offset: 0x1820
    // Size: 0xa0
    function debug_anim_reach() {
        self endon(#"death");
        self endon(#"goal");
        self endon(#"new_anim_reach");
        self endon(#"new_scripted_anim");
        self endon(#"stop_scripted_anim");
        while (true) {
            level flagsys::wait_till("<dev string:xcf>");
            print3d(self.origin, "<dev string:xda>", (1, 0, 0), 1, 1, 1);
            wait 0.05;
        }
    }

#/

// Namespace animation
// Params 7, eflags: 0x0
// Checksum 0x18c31a4b, Offset: 0x18c8
// Size: 0xa4
function set_death_anim(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp) {
    self notify(#"new_death_anim");
    if (isdefined(animation)) {
        self.skipdeath = 1;
        self thread _do_death_anim(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp);
        return;
    }
    self.skipdeath = 0;
}

// Namespace animation
// Params 7, eflags: 0x0
// Checksum 0x8d6e5745, Offset: 0x1978
// Size: 0xac
function _do_death_anim(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp) {
    self endon(#"new_death_anim");
    self waittill(#"death");
    if (isdefined(self) && !self isragdoll()) {
        self play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp);
    }
}

// Namespace animation
// Params 0, eflags: 0x0
// Checksum 0xd759f501, Offset: 0x1a30
// Size: 0x4c
function set_player_clamps() {
    if (isdefined(self.player_anim_look_enabled) && self.player_anim_look_enabled) {
        self setviewclamp(self.player_anim_clamp_right, self.player_anim_clamp_left, self.player_anim_clamp_top, self.player_anim_clamp_bottom);
    }
}

// Namespace animation
// Params 2, eflags: 0x0
// Checksum 0xec189a20, Offset: 0x1a88
// Size: 0x6e
function add_notetrack_func(funcname, func) {
    if (!isdefined(level._animnotifyfuncs)) {
        level._animnotifyfuncs = [];
    }
    assert(!isdefined(level._animnotifyfuncs[funcname]), "<dev string:xe5>");
    level._animnotifyfuncs[funcname] = func;
}

// Namespace animation
// Params 4, eflags: 0x20 variadic
// Checksum 0x2d08f2b6, Offset: 0x1b00
// Size: 0x114
function add_global_notetrack_handler(str_note, func, pass_notify_params, ...) {
    if (!isdefined(level._animnotetrackhandlers)) {
        level._animnotetrackhandlers = [];
    }
    if (!isdefined(level._animnotetrackhandlers[str_note])) {
        level._animnotetrackhandlers[str_note] = [];
    }
    if (!isdefined(level._animnotetrackhandlers[str_note])) {
        level._animnotetrackhandlers[str_note] = [];
    } else if (!isarray(level._animnotetrackhandlers[str_note])) {
        level._animnotetrackhandlers[str_note] = array(level._animnotetrackhandlers[str_note]);
    }
    level._animnotetrackhandlers[str_note][level._animnotetrackhandlers[str_note].size] = array(func, pass_notify_params, vararg);
}

// Namespace animation
// Params 3, eflags: 0x0
// Checksum 0x3cc8dbf9, Offset: 0x1c20
// Size: 0x2c0
function call_notetrack_handler(str_note, param1, param2) {
    if (isdefined(level._animnotetrackhandlers[str_note])) {
        foreach (handler in level._animnotetrackhandlers[str_note]) {
            func = handler[0];
            passnotifyparams = handler[1];
            args = handler[2];
            if (passnotifyparams) {
                self [[ func ]](param1, param2);
                continue;
            }
            switch (args.size) {
            case 6:
                self [[ func ]](args[0], args[1], args[2], args[3], args[4], args[5]);
                break;
            case 5:
                self [[ func ]](args[0], args[1], args[2], args[3], args[4]);
                break;
            case 4:
                self [[ func ]](args[0], args[1], args[2], args[3]);
                break;
            case 3:
                self [[ func ]](args[0], args[1], args[2]);
                break;
            case 2:
                self [[ func ]](args[0], args[1]);
                break;
            case 1:
                self [[ func ]](args[0]);
                break;
            case 0:
                self [[ func ]]();
                break;
            default:
                assertmsg("<dev string:x108>");
                break;
            }
        }
    }
}

// Namespace animation
// Params 0, eflags: 0x0
// Checksum 0x556d1e43, Offset: 0x1ee8
// Size: 0x3c4
function setup_notetracks() {
    add_notetrack_func("flag::set", &flag::set);
    add_notetrack_func("flag::clear", &flag::clear);
    add_notetrack_func("util::break_glass", &util::break_glass);
    clientfield::register("scriptmover", "cracks_on", 1, getminbitcountfornum(4), "int");
    clientfield::register("scriptmover", "cracks_off", 1, getminbitcountfornum(4), "int");
    add_global_notetrack_handler("red_cracks_on", &cracks_on, 0, "red");
    add_global_notetrack_handler("green_cracks_on", &cracks_on, 0, "green");
    add_global_notetrack_handler("blue_cracks_on", &cracks_on, 0, "blue");
    add_global_notetrack_handler("all_cracks_on", &cracks_on, 0, "all");
    add_global_notetrack_handler("red_cracks_off", &cracks_off, 0, "red");
    add_global_notetrack_handler("green_cracks_off", &cracks_off, 0, "green");
    add_global_notetrack_handler("blue_cracks_off", &cracks_off, 0, "blue");
    add_global_notetrack_handler("all_cracks_off", &cracks_off, 0, "all");
    add_global_notetrack_handler("headlook_on", &enable_headlook, 0, 1);
    add_global_notetrack_handler("headlook_off", &enable_headlook, 0, 0);
    add_global_notetrack_handler("headlook_notorso_on", &enable_headlook_notorso, 0, 1);
    add_global_notetrack_handler("headlook_notorso_off", &enable_headlook_notorso, 0, 0);
    add_global_notetrack_handler("attach weapon", &attach_weapon, 1);
    add_global_notetrack_handler("detach weapon", &detach_weapon, 1);
    add_global_notetrack_handler("fire", &fire_weapon, 0);
}

// Namespace animation
// Params 1, eflags: 0x0
// Checksum 0xf752a967, Offset: 0x22b8
// Size: 0xae
function handle_notetracks(animation) {
    self endon(#"death");
    self endon(#"new_scripted_anim");
    while (true) {
        self waittill(animation, str_note, param1, param2);
        if (isdefined(str_note)) {
            if (str_note != "end" && str_note != "loop_end") {
                self thread call_notetrack_handler(str_note, param1, param2);
                continue;
            }
            return;
        }
    }
}

// Namespace animation
// Params 1, eflags: 0x0
// Checksum 0x2e1bd77, Offset: 0x2370
// Size: 0xbe
function cracks_on(str_type) {
    switch (str_type) {
    case "red":
        clientfield::set("cracks_on", 1);
        break;
    case "green":
        clientfield::set("cracks_on", 3);
        break;
    case "blue":
        clientfield::set("cracks_on", 2);
        break;
    case "all":
        clientfield::set("cracks_on", 4);
        break;
    }
}

// Namespace animation
// Params 1, eflags: 0x0
// Checksum 0x6cc90107, Offset: 0x2438
// Size: 0xbe
function cracks_off(str_type) {
    switch (str_type) {
    case "red":
        clientfield::set("cracks_off", 1);
        break;
    case "green":
        clientfield::set("cracks_off", 3);
        break;
    case "blue":
        clientfield::set("cracks_off", 2);
        break;
    case "all":
        clientfield::set("cracks_off", 4);
        break;
    }
}

// Namespace animation
// Params 1, eflags: 0x0
// Checksum 0x6af61482, Offset: 0x2500
// Size: 0x74
function enable_headlook(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (isactor(self)) {
        if (b_on) {
            self lookatentity(level.players[0]);
            return;
        }
        self lookatentity();
    }
}

// Namespace animation
// Params 1, eflags: 0x0
// Checksum 0x7d5f3a16, Offset: 0x2580
// Size: 0x7c
function enable_headlook_notorso(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (isactor(self)) {
        if (b_on) {
            self lookatentity(level.players[0], 1);
            return;
        }
        self lookatentity();
    }
}

// Namespace animation
// Params 1, eflags: 0x0
// Checksum 0xbc9c7bd3, Offset: 0x2608
// Size: 0x24
function is_valid_weapon(weaponobject) {
    return isdefined(weaponobject) && weaponobject != level.weaponnone;
}

// Namespace animation
// Params 2, eflags: 0x0
// Checksum 0x8bbe9ce2, Offset: 0x2638
// Size: 0x184
function attach_weapon(weaponobject, tag) {
    if (!isdefined(tag)) {
        tag = "tag_weapon_right";
    }
    if (isactor(self)) {
        if (is_valid_weapon(weaponobject)) {
            ai::gun_switchto(weaponobject.name, "right");
        } else {
            ai::gun_recall();
        }
        return;
    }
    if (!is_valid_weapon(weaponobject)) {
        weaponobject = self.last_item;
    }
    if (is_valid_weapon(weaponobject)) {
        if (self.item != level.weaponnone) {
            detach_weapon();
        }
        assert(isdefined(weaponobject.worldmodel));
        self attach(weaponobject.worldmodel, tag);
        self setentityweapon(weaponobject);
        self.gun_removed = undefined;
        self.last_item = weaponobject;
    }
}

// Namespace animation
// Params 2, eflags: 0x0
// Checksum 0x9d60ce26, Offset: 0x27c8
// Size: 0xf0
function detach_weapon(weaponobject, tag) {
    if (!isdefined(tag)) {
        tag = "tag_weapon_right";
    }
    if (isactor(self)) {
        ai::gun_remove();
        return;
    }
    if (!is_valid_weapon(weaponobject)) {
        weaponobject = self.item;
    }
    if (is_valid_weapon(weaponobject)) {
        self detach(weaponobject.worldmodel, tag);
        self setentityweapon(level.weaponnone);
    }
    self.gun_removed = 1;
}

// Namespace animation
// Params 0, eflags: 0x0
// Checksum 0x54543657, Offset: 0x28c0
// Size: 0xc4
function fire_weapon() {
    if (!isai(self)) {
        if (self.item != level.weaponnone) {
            startpos = self gettagorigin("tag_flash");
            endpos = startpos + vectorscale(anglestoforward(self gettagangles("tag_flash")), 100);
            magicbullet(self.item, startpos, endpos, self);
        }
    }
}

