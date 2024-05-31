#using scripts/shared/system_shared;
#using scripts/shared/shaderanim_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/animation_debug_shared;

#namespace animation;

// Namespace animation
// Params 0, eflags: 0x2
// namespace_1fb6a2e5<file_0>::function_2dc19561
// Checksum 0xe0ac7f5e, Offset: 0x348
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("animation", &__init__, undefined, undefined);
}

// Namespace animation
// Params 0, eflags: 0x1 linked
// namespace_1fb6a2e5<file_0>::function_8c87d8eb
// Checksum 0x25da405, Offset: 0x388
// Size: 0xc4
function __init__() {
    clientfield::register("scriptmover", "cracks_on", 1, getminbitcountfornum(4), "int", &cf_cracks_on, 0, 0);
    clientfield::register("scriptmover", "cracks_off", 1, getminbitcountfornum(4), "int", &cf_cracks_off, 0, 0);
    setup_notetracks();
}

// Namespace animation
// Params 3, eflags: 0x0
// namespace_1fb6a2e5<file_0>::function_f968e47b
// Checksum 0x311d4031, Offset: 0x458
// Size: 0x3c
function first_frame(animation, v_origin_or_ent, v_angles_or_tag) {
    self thread play(animation, v_origin_or_ent, v_angles_or_tag, 0);
}

// Namespace animation
// Params 8, eflags: 0x1 linked
// namespace_1fb6a2e5<file_0>::function_43718187
// Checksum 0xdf4d2215, Offset: 0x4a0
// Size: 0xe8
function play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, b_link) {
    if (!isdefined(n_rate)) {
        n_rate = 1;
    }
    if (!isdefined(n_blend_in)) {
        n_blend_in = 0.2;
    }
    if (!isdefined(n_blend_out)) {
        n_blend_out = 0.2;
    }
    if (!isdefined(b_link)) {
        b_link = 0;
    }
    self endon(#"entityshutdown");
    self thread _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, b_link);
    self waittill(#"scriptedanim");
}

// Namespace animation
// Params 8, eflags: 0x1 linked
// namespace_1fb6a2e5<file_0>::function_55e4ea96
// Checksum 0x5831fc01, Offset: 0x590
// Size: 0x3f4
function _play(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp, b_link) {
    if (!isdefined(n_rate)) {
        n_rate = 1;
    }
    if (!isdefined(n_blend_in)) {
        n_blend_in = 0.2;
    }
    if (!isdefined(n_blend_out)) {
        n_blend_out = 0.2;
    }
    if (!isdefined(b_link)) {
        b_link = 0;
    }
    self endon(#"entityshutdown");
    self notify(#"new_scripted_anim");
    self endon(#"new_scripted_anim");
    flagsys::set_val("firstframe", n_rate == 0);
    flagsys::set("scripted_anim_this_frame");
    flagsys::set("scriptedanim");
    if (!isdefined(v_origin_or_ent)) {
        v_origin_or_ent = self;
    }
    if (isvec(v_origin_or_ent) && isvec(v_angles_or_tag)) {
        self animscripted("_anim_notify_", v_origin_or_ent, v_angles_or_tag, animation, n_blend_in, n_rate);
    } else if (isstring(v_angles_or_tag)) {
        assert(isdefined(v_origin_or_ent.model), "_anim_notify_" + animation + "_anim_notify_" + v_angles_or_tag + "_anim_notify_");
        v_pos = v_origin_or_ent gettagorigin(v_angles_or_tag);
        v_ang = v_origin_or_ent gettagangles(v_angles_or_tag);
        self.origin = v_pos;
        self.angles = v_ang;
        b_link = 1;
        self animscripted("_anim_notify_", self.origin, self.angles, animation, n_blend_in, n_rate);
    } else {
        v_angles = isdefined(v_origin_or_ent.angles) ? v_origin_or_ent.angles : (0, 0, 0);
        self animscripted("_anim_notify_", v_origin_or_ent.origin, v_angles, animation, n_blend_in, n_rate);
    }
    if (!b_link) {
        self unlink();
    }
    /#
        self thread anim_info_render_thread(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp);
    #/
    self thread handle_notetracks();
    self waittill_end();
    if (b_link) {
        self unlink();
    }
    flagsys::clear("scriptedanim");
    flagsys::clear("firstframe");
    waittillframeend();
    flagsys::clear("scripted_anim_this_frame");
}

// Namespace animation
// Params 0, eflags: 0x5 linked
// namespace_1fb6a2e5<file_0>::function_27f73339
// Checksum 0xc638e379, Offset: 0x990
// Size: 0x26
function private waittill_end() {
    level endon(#"demo_jump");
    self waittillmatch(#"_anim_notify_", "end");
}

// Namespace animation
// Params 1, eflags: 0x1 linked
// namespace_1fb6a2e5<file_0>::function_bdd3d4ac
// Checksum 0xa063394e, Offset: 0x9c0
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
// Params 2, eflags: 0x1 linked
// namespace_1fb6a2e5<file_0>::function_910a9e45
// Checksum 0x60bfaee6, Offset: 0xa28
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
        assert(isvec(v_angles_or_tag), "_anim_notify_");
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
// Params 4, eflags: 0x1 linked
// namespace_1fb6a2e5<file_0>::function_468623ab
// Checksum 0x4b654a82, Offset: 0xc10
// Size: 0x158
function play_siege(str_anim, str_shot, n_rate, b_loop) {
    if (!isdefined(str_shot)) {
        str_shot = "default";
    }
    if (!isdefined(n_rate)) {
        n_rate = 1;
    }
    if (!isdefined(b_loop)) {
        b_loop = 0;
    }
    level endon(#"demo_jump");
    self endon(#"entityshutdown");
    if (!isdefined(str_shot)) {
        str_shot = "default";
    }
    if (n_rate == 0) {
        self siegecmd("set_anim", str_anim, "set_shot", str_shot, "pause", "goto_start");
    } else {
        self siegecmd("set_anim", str_anim, "set_shot", str_shot, "unpause", "set_playback_speed", n_rate, "send_end_events", 1, b_loop ? "loop" : "unloop");
    }
    self waittill(#"end");
}

// Namespace animation
// Params 2, eflags: 0x1 linked
// namespace_1fb6a2e5<file_0>::function_7faf432b
// Checksum 0xbdc28941, Offset: 0xd70
// Size: 0x6e
function add_notetrack_func(funcname, func) {
    if (!isdefined(level._animnotifyfuncs)) {
        level._animnotifyfuncs = [];
    }
    assert(!isdefined(level._animnotifyfuncs[funcname]), "_anim_notify_");
    level._animnotifyfuncs[funcname] = func;
}

// Namespace animation
// Params 3, eflags: 0x21 linked
// namespace_1fb6a2e5<file_0>::function_ed9df341
// Checksum 0xa1d627fb, Offset: 0xde8
// Size: 0x104
function add_global_notetrack_handler(str_note, func, ...) {
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
    level._animnotetrackhandlers[str_note][level._animnotetrackhandlers[str_note].size] = array(func, vararg);
}

// Namespace animation
// Params 1, eflags: 0x1 linked
// namespace_1fb6a2e5<file_0>::function_cf69a798
// Checksum 0xe356f2bc, Offset: 0xef8
// Size: 0x280
function call_notetrack_handler(str_note) {
    if (isdefined(level._animnotetrackhandlers) && isdefined(level._animnotetrackhandlers[str_note])) {
        foreach (handler in level._animnotetrackhandlers[str_note]) {
            func = handler[0];
            args = handler[1];
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
                assertmsg("_anim_notify_");
                break;
            }
        }
    }
}

// Namespace animation
// Params 0, eflags: 0x1 linked
// namespace_1fb6a2e5<file_0>::function_d685d237
// Checksum 0x17b050d, Offset: 0x1180
// Size: 0x224
function setup_notetracks() {
    add_notetrack_func("flag::set", &flag::set);
    add_notetrack_func("flag::clear", &flag::clear);
    add_notetrack_func("postfx::PlayPostFxBundle", &postfx::playpostfxbundle);
    add_notetrack_func("postfx::StopPostFxBundle", &postfx::stoppostfxbundle);
    add_global_notetrack_handler("red_cracks_on", &cracks_on, "red");
    add_global_notetrack_handler("green_cracks_on", &cracks_on, "green");
    add_global_notetrack_handler("blue_cracks_on", &cracks_on, "blue");
    add_global_notetrack_handler("all_cracks_on", &cracks_on, "all");
    add_global_notetrack_handler("red_cracks_off", &cracks_off, "red");
    add_global_notetrack_handler("green_cracks_off", &cracks_off, "green");
    add_global_notetrack_handler("blue_cracks_off", &cracks_off, "blue");
    add_global_notetrack_handler("all_cracks_off", &cracks_off, "all");
}

// Namespace animation
// Params 0, eflags: 0x1 linked
// namespace_1fb6a2e5<file_0>::function_2ee5dc76
// Checksum 0x85fa08c8, Offset: 0x13b0
// Size: 0x7e
function handle_notetracks() {
    level endon(#"demo_jump");
    self endon(#"entityshutdown");
    while (true) {
        str_note = self waittill(#"_anim_notify_");
        if (str_note != "end" && str_note != "loop_end") {
            self thread call_notetrack_handler(str_note);
            continue;
        }
        return;
    }
}

// Namespace animation
// Params 1, eflags: 0x1 linked
// namespace_1fb6a2e5<file_0>::function_381464a4
// Checksum 0x1e682765, Offset: 0x1438
// Size: 0xbe
function cracks_on(str_type) {
    switch (str_type) {
    case 24:
        cf_cracks_on(self.localclientnum, 0, 1);
        break;
    case 26:
        cf_cracks_on(self.localclientnum, 0, 3);
        break;
    case 28:
        cf_cracks_on(self.localclientnum, 0, 2);
        break;
    case 30:
        cf_cracks_on(self.localclientnum, 0, 4);
        break;
    }
}

// Namespace animation
// Params 1, eflags: 0x1 linked
// namespace_1fb6a2e5<file_0>::function_565d2c52
// Checksum 0xb65b2c21, Offset: 0x1500
// Size: 0xbe
function cracks_off(str_type) {
    switch (str_type) {
    case 24:
        cf_cracks_off(self.localclientnum, 0, 1);
        break;
    case 26:
        cf_cracks_off(self.localclientnum, 0, 3);
        break;
    case 28:
        cf_cracks_off(self.localclientnum, 0, 2);
        break;
    case 30:
        cf_cracks_off(self.localclientnum, 0, 4);
        break;
    }
}

// Namespace animation
// Params 7, eflags: 0x1 linked
// namespace_1fb6a2e5<file_0>::function_6970a598
// Checksum 0xbdee7454, Offset: 0x15c8
// Size: 0x192
function cf_cracks_on(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 3, 0, 1);
        break;
    case 3:
        shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 3, 0, 1);
        break;
    case 2:
        shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 3, 0, 1);
        break;
    case 4:
        shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 3, 0, 1);
        shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 3, 0, 1);
        shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 3, 0, 1);
        break;
    }
}

// Namespace animation
// Params 7, eflags: 0x1 linked
// namespace_1fb6a2e5<file_0>::function_40400b06
// Checksum 0xa1d888f6, Offset: 0x1768
// Size: 0x17a
function cf_cracks_off(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 0, 1, 0);
        break;
    case 3:
        shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 0, 1, 0);
        break;
    case 2:
        shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 0, 1, 0);
        break;
    case 4:
        shaderanim::animate_crack(localclientnum, "scriptVector1", 0, 0, 1, 0);
        shaderanim::animate_crack(localclientnum, "scriptVector2", 0, 0, 1, 0);
        shaderanim::animate_crack(localclientnum, "scriptVector3", 0, 0, 1, 0);
        break;
    }
}

