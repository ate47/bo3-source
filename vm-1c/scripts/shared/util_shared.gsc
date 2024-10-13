#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;

#using_animtree("generic");
#using_animtree("all_player");

#namespace util;

// Namespace util
// Params 5, eflags: 0x1 linked
// Checksum 0xf567718d, Offset: 0xa98
// Size: 0x2c
function empty(a, b, c, d, e) {
    
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xc5e03b92, Offset: 0xad0
// Size: 0xd2
function wait_network_frame(n_count) {
    if (!isdefined(n_count)) {
        n_count = 1;
    }
    if (numremoteclients()) {
        for (i = 0; i < n_count; i++) {
            snapshot_ids = getsnapshotindexarray();
            for (acked = undefined; !isdefined(acked); acked = snapshotacknowledged(snapshot_ids)) {
                level waittill(#"snapacknowledged");
            }
        }
        return;
    }
    wait 0.1 * n_count;
}

// Namespace util
// Params 4, eflags: 0x1 linked
// Checksum 0xed6e48d2, Offset: 0xbb0
// Size: 0x2a0
function streamer_wait(n_stream_request_id, n_wait_frames, n_timeout, var_9636cf89) {
    if (!isdefined(n_wait_frames)) {
        n_wait_frames = 0;
    }
    if (!isdefined(n_timeout)) {
        n_timeout = 0;
    }
    if (!isdefined(var_9636cf89)) {
        var_9636cf89 = 1;
    }
    level endon(#"hash_b28e9639");
    if (n_wait_frames > 0) {
        wait_network_frame(n_wait_frames);
    }
    if (isdefined(var_9636cf89) && sessionmodeiscampaignzombiesgame() && var_9636cf89) {
        if (!n_timeout) {
            n_timeout = 7;
        }
    }
    timeout = gettime() + n_timeout * 1000;
    if (self == level) {
        n_num_streamers_ready = 0;
        do {
            wait_network_frame();
            n_num_streamers_ready = 0;
            foreach (player in getplayers()) {
                if (isdefined(n_stream_request_id) ? player isstreamerready(n_stream_request_id) : player isstreamerready()) {
                    n_num_streamers_ready++;
                }
            }
            if (n_timeout > 0 && gettime() > timeout) {
                break;
            }
        } while (n_num_streamers_ready < max(1, getplayers().size));
        return;
    }
    self endon(#"disconnect");
    do {
        wait_network_frame();
        if (n_timeout > 0 && gettime() > timeout) {
            break;
        }
    } while (!(isdefined(n_stream_request_id) ? self isstreamerready(n_stream_request_id) : self isstreamerready()));
}

/#

    // Namespace util
    // Params 3, eflags: 0x1 linked
    // Checksum 0x899edffb, Offset: 0xe58
    // Size: 0x86
    function draw_debug_line(start, end, timer) {
        for (i = 0; i < timer * 20; i++) {
            line(start, end, (1, 1, 0.5));
            wait 0.05;
        }
    }

    // Namespace util
    // Params 6, eflags: 0x1 linked
    // Checksum 0xaa6a427e, Offset: 0xee8
    // Size: 0xb4
    function debug_line(start, end, color, alpha, depthtest, duration) {
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        if (!isdefined(alpha)) {
            alpha = 1;
        }
        if (!isdefined(depthtest)) {
            depthtest = 0;
        }
        if (!isdefined(duration)) {
            duration = 100;
        }
        line(start, end, color, alpha, depthtest, duration);
    }

    // Namespace util
    // Params 8, eflags: 0x1 linked
    // Checksum 0x20251a7a, Offset: 0xfa8
    // Size: 0xdc
    function debug_spherical_cone(origin, domeapex, angle, slices, color, alpha, depthtest, duration) {
        if (!isdefined(slices)) {
            slices = 10;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        if (!isdefined(alpha)) {
            alpha = 1;
        }
        if (!isdefined(depthtest)) {
            depthtest = 0;
        }
        if (!isdefined(duration)) {
            duration = 100;
        }
        sphericalcone(origin, domeapex, angle, slices, color, alpha, depthtest, duration);
    }

    // Namespace util
    // Params 5, eflags: 0x1 linked
    // Checksum 0xb68f69b4, Offset: 0x1090
    // Size: 0xcc
    function debug_sphere(origin, radius, color, alpha, time) {
        if (!isdefined(time)) {
            time = 1000;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        sides = int(10 * (1 + int(radius) % 100));
        sphere(origin, radius, color, alpha, 1, sides, time);
    }

#/

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x160f1e6a, Offset: 0x1168
// Size: 0x1e
function function_d18b0f46(msg) {
    self waittillmatch(msg, "end");
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xbb916e55, Offset: 0x1190
// Size: 0x38
function track(spot_to_track) {
    if (isdefined(self.current_target)) {
        if (spot_to_track == self.current_target) {
            return;
        }
    }
    self.current_target = spot_to_track;
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0x7277804f, Offset: 0x11d0
// Size: 0x58
function waittill_string(msg, ent) {
    if (msg != "death") {
        self endon(#"death");
    }
    ent endon(#"die");
    self waittill(msg);
    ent notify(#"returned", msg);
}

// Namespace util
// Params 3, eflags: 0x1 linked
// Checksum 0x502ff31f, Offset: 0x1230
// Size: 0x50
function waittill_level_string(msg, ent, otherent) {
    otherent endon(#"death");
    ent endon(#"die");
    level waittill(msg);
    ent notify(#"returned", msg);
}

// Namespace util
// Params 1, eflags: 0x21 linked variadic
// Checksum 0xf39c1963, Offset: 0x1288
// Size: 0xaa
function waittill_multiple(...) {
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    for (i = 0; i < vararg.size; i++) {
        self thread _waitlogic(s_tracker, vararg[i]);
    }
    if (s_tracker._wait_count > 0) {
        s_tracker waittill(#"waitlogic_finished");
    }
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xfaf43561, Offset: 0x1340
// Size: 0x26
function waittill_either(msg1, msg2) {
    self endon(msg1);
    self waittill(msg2);
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x73f9f2b4, Offset: 0x1370
// Size: 0xb4
function break_glass(n_radius) {
    if (!isdefined(n_radius)) {
        n_radius = 50;
    }
    n_radius = float(n_radius);
    if (n_radius == -1) {
        v_origin_offset = (0, 0, 0);
        n_radius = 100;
    } else {
        v_origin_offset = (0, 0, 40);
    }
    glassradiusdamage(self.origin + v_origin_offset, n_radius, 500, 500);
}

// Namespace util
// Params 1, eflags: 0x21 linked variadic
// Checksum 0xc4c8467, Offset: 0x1430
// Size: 0x1e2
function waittill_multiple_ents(...) {
    a_ents = [];
    a_notifies = [];
    for (i = 0; i < vararg.size; i++) {
        if (i % 2) {
            if (!isdefined(a_notifies)) {
                a_notifies = [];
            } else if (!isarray(a_notifies)) {
                a_notifies = array(a_notifies);
            }
            a_notifies[a_notifies.size] = vararg[i];
            continue;
        }
        if (!isdefined(a_ents)) {
            a_ents = [];
        } else if (!isarray(a_ents)) {
            a_ents = array(a_ents);
        }
        a_ents[a_ents.size] = vararg[i];
    }
    s_tracker = spawnstruct();
    s_tracker._wait_count = 0;
    for (i = 0; i < a_ents.size; i++) {
        ent = a_ents[i];
        if (isdefined(ent)) {
            ent thread _waitlogic(s_tracker, a_notifies[i]);
        }
    }
    if (s_tracker._wait_count > 0) {
        s_tracker waittill(#"waitlogic_finished");
    }
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xc3a6c319, Offset: 0x1620
// Size: 0xd0
function _waitlogic(s_tracker, notifies) {
    s_tracker._wait_count++;
    if (!isdefined(notifies)) {
        notifies = [];
    } else if (!isarray(notifies)) {
        notifies = array(notifies);
    }
    notifies[notifies.size] = "death";
    function_c7f20692(notifies);
    s_tracker._wait_count--;
    if (s_tracker._wait_count == 0) {
        s_tracker notify(#"waitlogic_finished");
    }
}

// Namespace util
// Params 7, eflags: 0x1 linked
// Checksum 0x8440f153, Offset: 0x16f8
// Size: 0x268
function waittill_any_return(string1, string2, string3, string4, string5, string6, string7) {
    if (!isdefined(string7) || (!isdefined(string6) || (!isdefined(string5) || (!isdefined(string4) || (!isdefined(string3) || (!isdefined(string2) || (!isdefined(string1) || string1 != "death") && string2 != "death") && string3 != "death") && string4 != "death") && string5 != "death") && string6 != "death") && string7 != "death") {
        self endon(#"death");
    }
    ent = spawnstruct();
    if (isdefined(string1)) {
        self thread waittill_string(string1, ent);
    }
    if (isdefined(string2)) {
        self thread waittill_string(string2, ent);
    }
    if (isdefined(string3)) {
        self thread waittill_string(string3, ent);
    }
    if (isdefined(string4)) {
        self thread waittill_string(string4, ent);
    }
    if (isdefined(string5)) {
        self thread waittill_string(string5, ent);
    }
    if (isdefined(string6)) {
        self thread waittill_string(string6, ent);
    }
    if (isdefined(string7)) {
        self thread waittill_string(string7, ent);
    }
    msg = ent waittill(#"returned");
    ent notify(#"die");
    return msg;
}

// Namespace util
// Params 1, eflags: 0x21 linked variadic
// Checksum 0x4c6ef606, Offset: 0x1968
// Size: 0x1cc
function function_183e3618(...) {
    var_b8b3f0f8 = spawnstruct();
    e_current = self;
    var_f15f2959 = 0;
    if (strisnumber(vararg[0])) {
        n_timeout = vararg[0];
        var_f15f2959++;
        if (n_timeout > 0) {
            var_b8b3f0f8 thread _timeout(n_timeout);
        }
    }
    if (isarray(vararg[var_f15f2959])) {
        a_params = vararg[var_f15f2959];
        n_start_index = 0;
    } else {
        a_params = vararg;
        n_start_index = var_f15f2959;
    }
    for (i = n_start_index; i < a_params.size; i++) {
        if (!isstring(a_params[i])) {
            e_current = a_params[i];
            continue;
        }
        if (isdefined(e_current)) {
            e_current thread waittill_string(a_params[i], var_b8b3f0f8);
        }
    }
    str_notify = var_b8b3f0f8 waittill(#"returned");
    var_b8b3f0f8 notify(#"die");
    return str_notify;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x49ba8c12, Offset: 0x1b40
// Size: 0x118
function function_ec87322b(a_notifies) {
    if (isinarray(a_notifies, "death")) {
        self endon(#"death");
    }
    s_tracker = spawnstruct();
    foreach (str_notify in a_notifies) {
        if (isdefined(str_notify)) {
            self thread waittill_string(str_notify, s_tracker);
        }
    }
    msg = s_tracker waittill(#"returned");
    s_tracker notify(#"die");
    return msg;
}

// Namespace util
// Params 6, eflags: 0x1 linked
// Checksum 0x85988244, Offset: 0x1c60
// Size: 0x94
function waittill_any(var_d5de4b6f, var_63d6dc34, var_89d9569d, var_17d1e762, var_3dd461cb, var_cbccf290) {
    assert(isdefined(var_d5de4b6f));
    function_c7f20692(array(var_d5de4b6f, var_63d6dc34, var_89d9569d, var_17d1e762, var_3dd461cb, var_cbccf290));
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xfe9828ce, Offset: 0x1d00
// Size: 0xdc
function function_c7f20692(a_notifies) {
    if (!isdefined(a_notifies)) {
        a_notifies = [];
    } else if (!isarray(a_notifies)) {
        a_notifies = array(a_notifies);
    }
    assert(isdefined(a_notifies[0]), "<dev string:x28>");
    for (i = 1; i < a_notifies.size; i++) {
        if (isdefined(a_notifies[i])) {
            self endon(a_notifies[i]);
        }
    }
    self waittill(a_notifies[0]);
}

// Namespace util
// Params 6, eflags: 0x1 linked
// Checksum 0x878d6df4, Offset: 0x1de8
// Size: 0x1f0
function waittill_any_timeout(n_timeout, string1, string2, string3, string4, string5) {
    if (!isdefined(string5) || (!isdefined(string4) || (!isdefined(string3) || (!isdefined(string2) || (!isdefined(string1) || string1 != "death") && string2 != "death") && string3 != "death") && string4 != "death") && string5 != "death") {
        self endon(#"death");
    }
    ent = spawnstruct();
    if (isdefined(string1)) {
        self thread waittill_string(string1, ent);
    }
    if (isdefined(string2)) {
        self thread waittill_string(string2, ent);
    }
    if (isdefined(string3)) {
        self thread waittill_string(string3, ent);
    }
    if (isdefined(string4)) {
        self thread waittill_string(string4, ent);
    }
    if (isdefined(string5)) {
        self thread waittill_string(string5, ent);
    }
    ent thread _timeout(n_timeout);
    msg = ent waittill(#"returned");
    ent notify(#"die");
    return msg;
}

// Namespace util
// Params 7, eflags: 0x1 linked
// Checksum 0x937eaaff, Offset: 0x1fe0
// Size: 0x1a0
function waittill_level_any_timeout(n_timeout, otherent, string1, string2, string3, string4, string5) {
    otherent endon(#"death");
    ent = spawnstruct();
    if (isdefined(string1)) {
        level thread waittill_level_string(string1, ent, otherent);
    }
    if (isdefined(string2)) {
        level thread waittill_level_string(string2, ent, otherent);
    }
    if (isdefined(string3)) {
        level thread waittill_level_string(string3, ent, otherent);
    }
    if (isdefined(string4)) {
        level thread waittill_level_string(string4, ent, otherent);
    }
    if (isdefined(string5)) {
        level thread waittill_level_string(string5, ent, otherent);
    }
    if (isdefined(otherent)) {
        otherent thread waittill_string("death", ent);
    }
    ent thread _timeout(n_timeout);
    msg = ent waittill(#"returned");
    ent notify(#"die");
    return msg;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x930b4d6d, Offset: 0x2188
// Size: 0x32
function _timeout(delay) {
    self endon(#"die");
    wait delay;
    self notify(#"returned", "timeout");
}

// Namespace util
// Params 14, eflags: 0x1 linked
// Checksum 0x6feebc0e, Offset: 0x21c8
// Size: 0x174
function waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7) {
    assert(isdefined(ent1));
    assert(isdefined(string1));
    if (isdefined(ent2) && isdefined(string2)) {
        ent2 endon(string2);
    }
    if (isdefined(ent3) && isdefined(string3)) {
        ent3 endon(string3);
    }
    if (isdefined(ent4) && isdefined(string4)) {
        ent4 endon(string4);
    }
    if (isdefined(ent5) && isdefined(string5)) {
        ent5 endon(string5);
    }
    if (isdefined(ent6) && isdefined(string6)) {
        ent6 endon(string6);
    }
    if (isdefined(ent7) && isdefined(string7)) {
        ent7 endon(string7);
    }
    ent1 waittill(string1);
}

// Namespace util
// Params 4, eflags: 0x1 linked
// Checksum 0xc5d3ee7e, Offset: 0x2348
// Size: 0x8e
function waittill_any_ents_two(ent1, string1, ent2, string2) {
    assert(isdefined(ent1));
    assert(isdefined(string1));
    if (isdefined(ent2) && isdefined(string2)) {
        ent2 endon(string2);
    }
    ent1 waittill(string1);
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x2ebc088d, Offset: 0x23e0
// Size: 0x20
function isflashed() {
    if (!isdefined(self.flashendtime)) {
        return false;
    }
    return gettime() < self.flashendtime;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x384a53e0, Offset: 0x2408
// Size: 0x20
function isstunned() {
    if (!isdefined(self.flashendtime)) {
        return false;
    }
    return gettime() < self.flashendtime;
}

// Namespace util
// Params 8, eflags: 0x1 linked
// Checksum 0xb717bcd5, Offset: 0x2430
// Size: 0x16e
function single_func(entity, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    if (!isdefined(entity)) {
        entity = level;
    }
    if (isdefined(arg6)) {
        return entity [[ func ]](arg1, arg2, arg3, arg4, arg5, arg6);
    }
    if (isdefined(arg5)) {
        return entity [[ func ]](arg1, arg2, arg3, arg4, arg5);
    }
    if (isdefined(arg4)) {
        return entity [[ func ]](arg1, arg2, arg3, arg4);
    }
    if (isdefined(arg3)) {
        return entity [[ func ]](arg1, arg2, arg3);
    }
    if (isdefined(arg2)) {
        return entity [[ func ]](arg1, arg2);
    }
    if (isdefined(arg1)) {
        return entity [[ func ]](arg1);
    }
    return entity [[ func ]]();
}

// Namespace util
// Params 7, eflags: 0x0
// Checksum 0x4edc8ace, Offset: 0x25a8
// Size: 0xe8
function new_func(func, arg1, arg2, arg3, arg4, arg5, arg6) {
    s_func = spawnstruct();
    s_func.func = func;
    s_func.arg1 = arg1;
    s_func.arg2 = arg2;
    s_func.arg3 = arg3;
    s_func.arg4 = arg4;
    s_func.arg5 = arg5;
    s_func.arg6 = arg6;
    return s_func;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x24bbd6af, Offset: 0x2698
// Size: 0x72
function call_func(s_func) {
    return single_func(self, s_func.func, s_func.arg1, s_func.arg2, s_func.arg3, s_func.arg4, s_func.arg5, s_func.arg6);
}

// Namespace util
// Params 8, eflags: 0x1 linked
// Checksum 0x99d39132, Offset: 0x2718
// Size: 0x184
function single_thread(entity, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    assert(isdefined(entity), "<dev string:x6d>");
    if (isdefined(arg6)) {
        entity thread [[ func ]](arg1, arg2, arg3, arg4, arg5, arg6);
        return;
    }
    if (isdefined(arg5)) {
        entity thread [[ func ]](arg1, arg2, arg3, arg4, arg5);
        return;
    }
    if (isdefined(arg4)) {
        entity thread [[ func ]](arg1, arg2, arg3, arg4);
        return;
    }
    if (isdefined(arg3)) {
        entity thread [[ func ]](arg1, arg2, arg3);
        return;
    }
    if (isdefined(arg2)) {
        entity thread [[ func ]](arg1, arg2);
        return;
    }
    if (isdefined(arg1)) {
        entity thread [[ func ]](arg1);
        return;
    }
    entity thread [[ func ]]();
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xd8472350, Offset: 0x28a8
// Size: 0x88
function script_delay() {
    if (isdefined(self.script_delay)) {
        wait self.script_delay;
        return true;
    } else if (isdefined(self.script_delay_min) && isdefined(self.script_delay_max)) {
        if (self.script_delay_max > self.script_delay_min) {
            wait randomfloatrange(self.script_delay_min, self.script_delay_max);
        } else {
            wait self.script_delay_min;
        }
        return true;
    }
    return false;
}

// Namespace util
// Params 8, eflags: 0x1 linked
// Checksum 0x8d188c1, Offset: 0x2938
// Size: 0xcc
function timeout(n_time, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    if (isdefined(n_time)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s delay_notify(n_time, "timeout");
    }
    single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x640cfc76, Offset: 0x2a10
// Size: 0xaa
function create_flags_and_return_tokens(flags) {
    tokens = strtok(flags, " ");
    for (i = 0; i < tokens.size; i++) {
        if (!level flag::exists(tokens[i])) {
            level flag::init(tokens[i], undefined, 1);
        }
    }
    return tokens;
}

/#

    // Namespace util
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb15bb138, Offset: 0x2ac8
    // Size: 0x64
    function fileprint_start(file) {
        filename = file;
        file = openfile(filename, "<dev string:x9e>");
        level.fileprint = file;
        level.fileprintlinecount = 0;
        level.fileprint_filename = filename;
    }

    // Namespace util
    // Params 1, eflags: 0x0
    // Checksum 0x22631536, Offset: 0x2b38
    // Size: 0x64
    function fileprint_map_start(file) {
        file = "<dev string:xa4>" + file + "<dev string:xb0>";
        fileprint_start(file);
        level.fileprint_mapentcount = 0;
        fileprint_map_header(1);
    }

    // Namespace util
    // Params 2, eflags: 0x1 linked
    // Checksum 0x9960efaa, Offset: 0x2ba8
    // Size: 0x64
    function fileprint_chk(file, str) {
        level.fileprintlinecount++;
        if (level.fileprintlinecount > 400) {
            wait 0.05;
            level.fileprintlinecount++;
            level.fileprintlinecount = 0;
        }
        fprintln(file, str);
    }

#/

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x95328f7f, Offset: 0x2c18
// Size: 0xf4
function fileprint_map_header(binclude_blank_worldspawn) {
    if (!isdefined(binclude_blank_worldspawn)) {
        binclude_blank_worldspawn = 0;
    }
    assert(isdefined(level.fileprint));
    /#
        fileprint_chk(level.fileprint, "<dev string:xb5>");
        fileprint_chk(level.fileprint, "<dev string:xbd>");
        fileprint_chk(level.fileprint, "<dev string:xd8>");
        if (!binclude_blank_worldspawn) {
            return;
        }
        fileprint_map_entity_start();
        fileprint_map_keypairprint("<dev string:xe8>", "<dev string:xf2>");
        fileprint_map_entity_end();
    #/
}

/#

    // Namespace util
    // Params 2, eflags: 0x1 linked
    // Checksum 0xbd95b79b, Offset: 0x2d18
    // Size: 0x7c
    function fileprint_map_keypairprint(key1, key2) {
        assert(isdefined(level.fileprint));
        fileprint_chk(level.fileprint, "<dev string:xfd>" + key1 + "<dev string:xff>" + key2 + "<dev string:xfd>");
    }

    // Namespace util
    // Params 0, eflags: 0x1 linked
    // Checksum 0xd6ecf47f, Offset: 0x2da0
    // Size: 0xac
    function fileprint_map_entity_start() {
        assert(!isdefined(level.fileprint_entitystart));
        level.fileprint_entitystart = 1;
        assert(isdefined(level.fileprint));
        fileprint_chk(level.fileprint, "<dev string:x103>" + level.fileprint_mapentcount);
        fileprint_chk(level.fileprint, "<dev string:x10e>");
        level.fileprint_mapentcount++;
    }

    // Namespace util
    // Params 0, eflags: 0x1 linked
    // Checksum 0x420399c5, Offset: 0x2e58
    // Size: 0x74
    function fileprint_map_entity_end() {
        assert(isdefined(level.fileprint_entitystart));
        assert(isdefined(level.fileprint));
        level.fileprint_entitystart = undefined;
        fileprint_chk(level.fileprint, "<dev string:x110>");
    }

    // Namespace util
    // Params 0, eflags: 0x0
    // Checksum 0xa7ec44f9, Offset: 0x2ed8
    // Size: 0x25e
    function fileprint_end() {
        assert(!isdefined(level.fileprint_entitystart));
        saved = closefile(level.fileprint);
        if (saved != 1) {
            println("<dev string:x112>");
            println("<dev string:x136>");
            println("<dev string:x138>");
            println("<dev string:x14b>" + level.fileprint_filename);
            println("<dev string:x15c>");
            println("<dev string:x193>");
            println("<dev string:x1cf>");
            println("<dev string:x20b>");
            println("<dev string:x251>");
            println("<dev string:x136>");
            println("<dev string:x26b>");
            println("<dev string:x2ae>");
            println("<dev string:x2f2>");
            println("<dev string:x32e>");
            println("<dev string:x372>");
            println("<dev string:x3af>");
            println("<dev string:x3ee>");
            println("<dev string:x136>");
            println("<dev string:x112>");
            println("<dev string:x431>");
        }
        level.fileprint = undefined;
        level.fileprint_filename = undefined;
    }

    // Namespace util
    // Params 1, eflags: 0x0
    // Checksum 0x90472f71, Offset: 0x3140
    // Size: 0x64
    function fileprint_radiant_vec(vector) {
        string = "<dev string:x45d>" + vector[0] + "<dev string:x136>" + vector[1] + "<dev string:x136>" + vector[2] + "<dev string:x45d>";
        return string;
    }

#/

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xa529e94, Offset: 0x31b0
// Size: 0x3e
function death_notify_wrapper(attacker, damagetype) {
    level notify(#"face", "death", self);
    self notify(#"death", attacker, damagetype);
}

// Namespace util
// Params 9, eflags: 0x1 linked
// Checksum 0xcf9f8be3, Offset: 0x31f8
// Size: 0x92
function damage_notify_wrapper(damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags) {
    level notify(#"face", "damage", self);
    self notify(#"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags);
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x7f145899, Offset: 0x3298
// Size: 0x26
function explode_notify_wrapper() {
    level notify(#"face", "explode", self);
    self notify(#"explode");
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x7851d5d7, Offset: 0x32c8
// Size: 0x26
function alert_notify_wrapper() {
    level notify(#"face", "alert", self);
    self notify(#"alert");
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x86f3f8d9, Offset: 0x32f8
// Size: 0x26
function shoot_notify_wrapper() {
    level notify(#"face", "shoot", self);
    self notify(#"shoot");
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0xc2917e90, Offset: 0x3328
// Size: 0x26
function melee_notify_wrapper() {
    level notify(#"face", "melee", self);
    self notify(#"melee");
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x5b39e015, Offset: 0x3358
// Size: 0xc
function isusabilityenabled() {
    return !self.disabledusability;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xcc0896ee, Offset: 0x3370
// Size: 0x24
function _disableusability() {
    self.disabledusability++;
    self disableusability();
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xe4810dee, Offset: 0x33a0
// Size: 0x4c
function _enableusability() {
    self.disabledusability--;
    assert(self.disabledusability >= 0);
    if (!self.disabledusability) {
        self enableusability();
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x849256fd, Offset: 0x33f8
// Size: 0x24
function resetusability() {
    self.disabledusability = 0;
    self enableusability();
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x353f58d5, Offset: 0x3428
// Size: 0x3c
function function_f9e9f0f0() {
    if (!isdefined(self.disabledweapon)) {
        self.disabledweapon = 0;
    }
    self.disabledweapon++;
    self disableweapons();
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xe7808e32, Offset: 0x3470
// Size: 0x3c
function function_ee182f5d() {
    if (self.disabledweapon > 0) {
        self.disabledweapon--;
        if (!self.disabledweapon) {
            self enableweapons();
        }
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x557c22f2, Offset: 0x34b8
// Size: 0xc
function function_31827fe8() {
    return !self.disabledweapon;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x21b9989, Offset: 0x34d0
// Size: 0xf4
function orient_to_normal(normal) {
    hor_normal = (normal[0], normal[1], 0);
    hor_length = length(hor_normal);
    if (!hor_length) {
        return (0, 0, 0);
    }
    hor_dir = vectornormalize(hor_normal);
    neg_height = normal[2] * -1;
    tangent = (hor_dir[0] * neg_height, hor_dir[1] * neg_height, hor_length);
    plant_angle = vectortoangles(tangent);
    return plant_angle;
}

// Namespace util
// Params 9, eflags: 0x1 linked
// Checksum 0xf0f60ed0, Offset: 0x35d0
// Size: 0x84
function delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self thread _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util
// Params 9, eflags: 0x1 linked
// Checksum 0x900c6d85, Offset: 0x3660
// Size: 0xc4
function _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self endon(#"death");
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    if (isstring(time_or_notify)) {
        self waittill(time_or_notify);
    } else {
        wait time_or_notify;
    }
    single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util
// Params 9, eflags: 0x1 linked
// Checksum 0xc439c538, Offset: 0x3730
// Size: 0x84
function delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self thread _delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util
// Params 9, eflags: 0x1 linked
// Checksum 0x4b1d49fd, Offset: 0x37c0
// Size: 0xac
function _delay_network_frames(n_frames, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6) {
    self endon(#"entityshutdown");
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    wait_network_frame(n_frames);
    single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

// Namespace util
// Params 8, eflags: 0x1 linked
// Checksum 0xb2a47f6b, Offset: 0x3878
// Size: 0x7c
function delay_notify(time_or_notify, str_notify, str_endon, arg1, arg2, arg3, arg4, arg5) {
    self thread _delay_notify(time_or_notify, str_notify, str_endon, arg1, arg2, arg3, arg4, arg5);
}

// Namespace util
// Params 8, eflags: 0x1 linked
// Checksum 0xfe893ee8, Offset: 0x3900
// Size: 0xa8
function _delay_notify(time_or_notify, str_notify, str_endon, arg1, arg2, arg3, arg4, arg5) {
    self endon(#"death");
    if (isdefined(str_endon)) {
        self endon(str_endon);
    }
    if (isstring(time_or_notify)) {
        self waittill(time_or_notify);
    } else {
        wait time_or_notify;
    }
    self notify(str_notify, arg1, arg2, arg3, arg4, arg5);
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xefb2a1c8, Offset: 0x39b0
// Size: 0x5c
function get_closest_player(org, str_team) {
    players = getplayers(str_team);
    return arraysort(players, org, 1, 1)[0];
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x76fd5bc0, Offset: 0x3a18
// Size: 0xec
function registerclientsys(ssysname) {
    if (!isdefined(level._clientsys)) {
        level._clientsys = [];
    }
    if (level._clientsys.size >= 32) {
        assertmsg("<dev string:x45e>");
        return;
    }
    if (isdefined(level._clientsys[ssysname])) {
        assertmsg("<dev string:x47f>" + ssysname);
        return;
    }
    level._clientsys[ssysname] = spawnstruct();
    level._clientsys[ssysname].sysid = clientsysregister(ssysname);
}

// Namespace util
// Params 3, eflags: 0x1 linked
// Checksum 0xce16f5f8, Offset: 0x3b10
// Size: 0x118
function setclientsysstate(ssysname, ssysstate, player) {
    if (!isdefined(level._clientsys)) {
        assertmsg("<dev string:x4a7>");
        return;
    }
    if (!isdefined(level._clientsys[ssysname])) {
        assertmsg("<dev string:x4e4>" + ssysname);
        return;
    }
    if (isdefined(player)) {
        player clientsyssetstate(level._clientsys[ssysname].sysid, ssysstate);
        return;
    }
    clientsyssetstate(level._clientsys[ssysname].sysid, ssysstate);
    level._clientsys[ssysname].sysstate = ssysstate;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xb5e55da9, Offset: 0x3c30
// Size: 0xc6
function getclientsysstate(ssysname) {
    if (!isdefined(level._clientsys)) {
        assertmsg("<dev string:x515>");
        return "";
    }
    if (!isdefined(level._clientsys[ssysname])) {
        assertmsg("<dev string:x555>" + ssysname + "<dev string:x564>");
        return "";
    }
    if (isdefined(level._clientsys[ssysname].sysstate)) {
        return level._clientsys[ssysname].sysstate;
    }
    return "";
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x10ae3da9, Offset: 0x3d00
// Size: 0x6c
function clientnotify(event) {
    if (level.clientscripts) {
        if (isplayer(self)) {
            setclientsysstate("levelNotify", event, self);
            return;
        }
        setclientsysstate("levelNotify", event);
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x133bf790, Offset: 0x3d78
// Size: 0x42
function coopgame() {
    return sessionmodeisonlinegame() || sessionmodeissystemlink() || issplitscreen();
}

// Namespace util
// Params 4, eflags: 0x1 linked
// Checksum 0x65dcbe5d, Offset: 0x3dc8
// Size: 0x1da
function is_looking_at(ent_or_org, n_dot_range, do_trace, v_offset) {
    if (!isdefined(n_dot_range)) {
        n_dot_range = 0.67;
    }
    if (!isdefined(do_trace)) {
        do_trace = 0;
    }
    assert(isdefined(ent_or_org), "<dev string:x591>");
    v_point = isvec(ent_or_org) ? ent_or_org : ent_or_org.origin;
    if (isvec(v_offset)) {
        v_point += v_offset;
    }
    b_can_see = 0;
    b_use_tag_eye = 0;
    if (isplayer(self) || isai(self)) {
        b_use_tag_eye = 1;
    }
    n_dot = self math::get_dot_direction(v_point, 0, 1, "forward", b_use_tag_eye);
    if (n_dot > n_dot_range) {
        if (do_trace) {
            v_eye = self get_eye();
            b_can_see = sighttracepassed(v_eye, v_point, 0, ent_or_org);
        } else {
            b_can_see = 1;
        }
    }
    return b_can_see;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x3747916f, Offset: 0x3fb0
// Size: 0xc4
function get_eye() {
    if (isplayer(self)) {
        linked_ent = self getlinkedent();
        if (isdefined(linked_ent) && getdvarint("cg_cameraUseTagCamera") > 0) {
            camera = linked_ent gettagorigin("tag_camera");
            if (isdefined(camera)) {
                return camera;
            }
        }
    }
    pos = self geteye();
    return pos;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xac1840f3, Offset: 0x4080
// Size: 0x24
function is_ads() {
    return self playerads() > 0.5;
}

// Namespace util
// Params 5, eflags: 0x1 linked
// Checksum 0x99f64631, Offset: 0x40b0
// Size: 0xec
function spawn_model(model_name, origin, angles, n_spawnflags, b_throttle) {
    if (!isdefined(n_spawnflags)) {
        n_spawnflags = 0;
    }
    if (!isdefined(b_throttle)) {
        b_throttle = 0;
    }
    if (b_throttle) {
        spawner::global_spawn_throttle(1);
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

// Namespace util
// Params 5, eflags: 0x1 linked
// Checksum 0xd250ea5e, Offset: 0x41a8
// Size: 0xa4
function spawn_anim_model(model_name, origin, angles, n_spawnflags, b_throttle) {
    if (!isdefined(n_spawnflags)) {
        n_spawnflags = 0;
    }
    model = spawn_model(model_name, origin, angles, n_spawnflags, b_throttle);
    model useanimtree(#generic);
    model.animtree = "generic";
    return model;
}

// Namespace util
// Params 4, eflags: 0x1 linked
// Checksum 0xd032c41d, Offset: 0x4258
// Size: 0x9c
function spawn_anim_player_model(model_name, origin, angles, n_spawnflags) {
    if (!isdefined(n_spawnflags)) {
        n_spawnflags = 0;
    }
    model = spawn_model(model_name, origin, angles, n_spawnflags);
    model useanimtree(#all_player);
    model.animtree = "all_player";
    return model;
}

// Namespace util
// Params 4, eflags: 0x1 linked
// Checksum 0xa20d3ad6, Offset: 0x4300
// Size: 0xc4
function waittill_player_looking_at(origin, arc_angle_degrees, do_trace, e_ignore) {
    if (!isdefined(arc_angle_degrees)) {
        arc_angle_degrees = 90;
    }
    self endon(#"death");
    arc_angle_degrees = absangleclamp360(arc_angle_degrees);
    dot = cos(arc_angle_degrees * 0.5);
    while (!is_player_looking_at(origin, dot, do_trace, e_ignore)) {
        wait 0.05;
    }
}

// Namespace util
// Params 3, eflags: 0x1 linked
// Checksum 0x465dc933, Offset: 0x43d0
// Size: 0x54
function waittill_player_not_looking_at(origin, dot, do_trace) {
    self endon(#"death");
    while (is_player_looking_at(origin, dot, do_trace)) {
        wait 0.05;
    }
}

// Namespace util
// Params 4, eflags: 0x1 linked
// Checksum 0x5c5791e6, Offset: 0x4430
// Size: 0x160
function is_player_looking_at(origin, dot, do_trace, ignore_ent) {
    assert(isplayer(self), "<dev string:x5c9>");
    if (!isdefined(dot)) {
        dot = 0.7;
    }
    if (!isdefined(do_trace)) {
        do_trace = 1;
    }
    eye = self get_eye();
    delta_vec = vectornormalize(origin - eye);
    view_vec = anglestoforward(self getplayerangles());
    new_dot = vectordot(delta_vec, view_vec);
    if (new_dot >= dot) {
        if (do_trace) {
            return bullettracepassed(origin, eye, 0, ignore_ent);
        } else {
            return 1;
        }
    }
    return 0;
}

// Namespace util
// Params 5, eflags: 0x1 linked
// Checksum 0x2d839133, Offset: 0x4598
// Size: 0x74
function wait_endon(waittime, endonstring, endonstring2, endonstring3, endonstring4) {
    self endon(endonstring);
    if (isdefined(endonstring2)) {
        self endon(endonstring2);
    }
    if (isdefined(endonstring3)) {
        self endon(endonstring3);
    }
    if (isdefined(endonstring4)) {
        self endon(endonstring4);
    }
    wait waittime;
    return true;
}

// Namespace util
// Params 5, eflags: 0x1 linked
// Checksum 0xd1e55d02, Offset: 0x4618
// Size: 0x86
function waittillendonthreaded(waitcondition, callback, endcondition1, endcondition2, endcondition3) {
    if (isdefined(endcondition1)) {
        self endon(endcondition1);
    }
    if (isdefined(endcondition2)) {
        self endon(endcondition2);
    }
    if (isdefined(endcondition3)) {
        self endon(endcondition3);
    }
    self waittill(waitcondition);
    if (isdefined(callback)) {
        [[ callback ]](waitcondition);
    }
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xabe50925, Offset: 0x46a8
// Size: 0x50
function new_timer(n_timer_length) {
    s_timer = spawnstruct();
    s_timer.n_time_created = gettime();
    s_timer.n_length = n_timer_length;
    return s_timer;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x844ff1f2, Offset: 0x4700
// Size: 0x20
function get_time() {
    t_now = gettime();
    return t_now - self.n_time_created;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xe6971794, Offset: 0x4728
// Size: 0x18
function get_time_in_seconds() {
    return get_time() / 1000;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x4de86be0, Offset: 0x4748
// Size: 0x52
function get_time_frac(n_end_time) {
    if (!isdefined(n_end_time)) {
        n_end_time = self.n_length;
    }
    return lerpfloat(0, 1, get_time_in_seconds() / n_end_time);
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xef79d6f7, Offset: 0x47a8
// Size: 0x58
function get_time_left() {
    if (isdefined(self.n_length)) {
        n_current_time = get_time_in_seconds();
        return max(self.n_length - n_current_time, 0);
    }
    return -1;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x320c693a, Offset: 0x4808
// Size: 0x16
function is_time_left() {
    return get_time_left() != 0;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x5b9bd5c2, Offset: 0x4828
// Size: 0x6c
function timer_wait(n_wait) {
    if (isdefined(self.n_length)) {
        n_wait = min(n_wait, get_time_left());
    }
    wait n_wait;
    n_current_time = get_time_in_seconds();
    return n_current_time;
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x7cb18fb0, Offset: 0x48a0
// Size: 0x34
function is_primary_damage(meansofdeath) {
    if (meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET") {
        return true;
    }
    return false;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x7f2c84a4, Offset: 0x48e0
// Size: 0x44
function delete_on_death(ent) {
    ent endon(#"death");
    self waittill(#"death");
    if (isdefined(ent)) {
        ent delete();
    }
}

// Namespace util
// Params 3, eflags: 0x1 linked
// Checksum 0x25fa6d63, Offset: 0x4930
// Size: 0xac
function delete_on_death_or_notify(e_to_delete, str_notify, str_clientfield) {
    if (!isdefined(str_clientfield)) {
        str_clientfield = undefined;
    }
    e_to_delete endon(#"death");
    self waittill_either("death", str_notify);
    if (isdefined(e_to_delete)) {
        if (isdefined(str_clientfield)) {
            e_to_delete clientfield::set(str_clientfield, 0);
            wait 0.1;
        }
        e_to_delete delete();
    }
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xa2896e, Offset: 0x49e8
// Size: 0xa4
function wait_till_not_touching(e_to_check, e_to_touch) {
    assert(isdefined(e_to_check), "<dev string:x5f7>");
    assert(isdefined(e_to_touch), "<dev string:x635>");
    e_to_check endon(#"death");
    e_to_touch endon(#"death");
    while (e_to_check istouching(e_to_touch)) {
        wait 0.05;
    }
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xc4a4d302, Offset: 0x4a98
// Size: 0xd4
function any_player_is_touching(ent, str_team) {
    foreach (player in getplayers(str_team)) {
        if (isalive(player) && player istouching(ent)) {
            return true;
        }
    }
    return false;
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0x6399cb0, Offset: 0x4b78
// Size: 0x26
function waittill_notify_or_timeout(msg, timer) {
    self endon(msg);
    wait timer;
    return true;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xe182dcd9, Offset: 0x4ba8
// Size: 0x104
function set_console_status() {
    if (!isdefined(level.console)) {
        level.console = getdvarstring("consoleGame") == "true";
    } else {
        assert(level.console == getdvarstring("<dev string:x673>") == "<dev string:x67f>", "<dev string:x684>");
    }
    if (!isdefined(level.consolexenon)) {
        level.xenon = getdvarstring("xenonGame") == "true";
        return;
    }
    assert(level.xenon == getdvarstring("<dev string:x6a7>") == "<dev string:x67f>", "<dev string:x6b1>");
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xa37347c5, Offset: 0x4cb8
// Size: 0x14
function waittill_asset_loaded(str_type, str_name) {
    
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x4e2e00b3, Offset: 0x4cd8
// Size: 0x190
function script_wait(var_bfefeedc) {
    if (!isdefined(var_bfefeedc)) {
        var_bfefeedc = 0;
    }
    var_714358d = 1;
    if (var_bfefeedc) {
        players = getplayers();
        if (players.size == 2) {
            var_714358d = 0.7;
        } else if (players.size == 3) {
            var_714358d = 0.4;
        } else if (players.size == 4) {
            var_714358d = 0.1;
        }
    }
    starttime = gettime();
    if (isdefined(self.script_wait)) {
        wait self.script_wait * var_714358d;
        if (isdefined(self.script_wait_add)) {
            self.script_wait += self.script_wait_add;
        }
    } else if (isdefined(self.script_wait_min) && isdefined(self.script_wait_max)) {
        wait randomfloatrange(self.script_wait_min, self.script_wait_max) * var_714358d;
        if (isdefined(self.script_wait_add)) {
            self.script_wait_min += self.script_wait_add;
            self.script_wait_max += self.script_wait_add;
        }
    }
    return gettime() - starttime;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xdefcf40d, Offset: 0x4e70
// Size: 0x16
function is_killstreaks_enabled() {
    return isdefined(level.killstreaksenabled) && level.killstreaksenabled;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xe8fc524, Offset: 0x4e90
// Size: 0x1c
function is_flashbanged() {
    return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xcce9549, Offset: 0x4eb8
// Size: 0x110
function magic_bullet_shield(ent) {
    if (!isdefined(ent)) {
        ent = self;
    }
    ent.allowdeath = 0;
    ent.magic_bullet_shield = 1;
    /#
        ent notify(#"_stop_magic_bullet_shield_debug");
        level thread debug_magic_bullet_shield_death(ent);
    #/
    assert(isalive(ent), "<dev string:x6d2>");
    if (isai(ent)) {
        if (isactor(ent)) {
            ent bloodimpact("hero");
        }
        ent.attackeraccuracy = 0.1;
    }
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x41717b7, Offset: 0x4fd0
// Size: 0x9c
function debug_magic_bullet_shield_death(guy) {
    targetname = "none";
    if (isdefined(guy.targetname)) {
        targetname = guy.targetname;
    }
    guy endon(#"stop_magic_bullet_shield");
    guy endon(#"_stop_magic_bullet_shield_debug");
    guy waittill(#"death");
    assert(!isdefined(guy), "<dev string:x70e>" + targetname);
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xd6051e10, Offset: 0x5078
// Size: 0x258
function spawn_player_clone(player, animname) {
    playerclone = spawn("script_model", player.origin);
    playerclone.angles = player.angles;
    bodymodel = player getcharacterbodymodel();
    playerclone setmodel(bodymodel);
    headmodel = player getcharacterheadmodel();
    if (isdefined(headmodel)) {
        playerclone attach(headmodel, "");
    }
    var_f1a3fa15 = player getcharacterhelmetmodel();
    if (isdefined(var_f1a3fa15)) {
        playerclone attach(var_f1a3fa15, "");
    }
    var_6f30937d = player getcharacterbodyrenderoptions();
    playerclone setbodyrenderoptions(var_6f30937d, var_6f30937d, var_6f30937d);
    playerclone useanimtree(#all_player);
    if (isdefined(animname)) {
        playerclone animscripted("clone_anim", playerclone.origin, playerclone.angles, animname);
    }
    playerclone.health = 100;
    playerclone setowner(player);
    playerclone.team = player.team;
    playerclone solid();
    return playerclone;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xbad221cd, Offset: 0x52d8
// Size: 0xb0
function stop_magic_bullet_shield(ent) {
    if (!isdefined(ent)) {
        ent = self;
    }
    ent.allowdeath = 1;
    ent.magic_bullet_shield = undefined;
    if (isai(ent)) {
        if (isactor(ent)) {
            ent bloodimpact("normal");
        }
        ent.attackeraccuracy = 1;
    }
    ent notify(#"stop_magic_bullet_shield");
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x34ca433b, Offset: 0x5390
// Size: 0x1c
function function_7e983921() {
    if (level.roundlimit == 1) {
        return true;
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x8e80e42e, Offset: 0x53b8
// Size: 0x2e
function function_d2c2af67() {
    if (level.roundlimit > 1 && game["roundsplayed"] == 0) {
        return true;
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0xdfbf5345, Offset: 0x53f0
// Size: 0x3a
function function_43686c3c() {
    if (level.roundlimit > 1 && game["roundsplayed"] >= level.roundlimit - 1) {
        return true;
    }
    return false;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xb264467b, Offset: 0x5438
// Size: 0x1c
function get_rounds_won(team) {
    return game["roundswon"][team];
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x249207d, Offset: 0x5460
// Size: 0xbe
function function_cfde690(skip_team) {
    roundswon = 0;
    foreach (team in level.teams) {
        if (team == skip_team) {
            continue;
        }
        roundswon += game["roundswon"][team];
    }
    return roundswon;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x236717cb, Offset: 0x5528
// Size: 0xe
function get_rounds_played() {
    return game["roundsplayed"];
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x50501c2b, Offset: 0x5540
// Size: 0x2c
function function_b8a26ad8() {
    if (level.roundlimit != 1 && level.roundwinlimit != 1) {
        return true;
    }
    return false;
}

// Namespace util
// Params 4, eflags: 0x1 linked
// Checksum 0xcbc349db, Offset: 0x5578
// Size: 0xa2
function within_fov(start_origin, start_angles, end_origin, fov) {
    normal = vectornormalize(end_origin - start_origin);
    forward = anglestoforward(start_angles);
    dot = vectordot(forward, normal);
    return dot >= fov;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x45995387, Offset: 0x5628
// Size: 0x11c
function button_held_think(which_button) {
    self endon(#"disconnect");
    if (!isdefined(self._holding_button)) {
        self._holding_button = [];
    }
    self._holding_button[which_button] = 0;
    time_started = 0;
    while (true) {
        if (self._holding_button[which_button]) {
            if (!self [[ level._button_funcs[which_button] ]]()) {
                self._holding_button[which_button] = 0;
            }
        } else if (self [[ level._button_funcs[which_button] ]]()) {
            if (time_started == 0) {
                time_started = gettime();
            }
            if (gettime() - time_started > -6) {
                self._holding_button[which_button] = 1;
            }
        } else if (time_started != 0) {
            time_started = 0;
        }
        wait 0.05;
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x92383585, Offset: 0x5750
// Size: 0x4c
function use_button_held() {
    init_button_wrappers();
    if (!isdefined(self._use_button_think_threaded)) {
        self thread button_held_think(0);
        self._use_button_think_threaded = 1;
    }
    return self._holding_button[0];
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xebebe79a, Offset: 0x57a8
// Size: 0x54
function stance_button_held() {
    init_button_wrappers();
    if (!isdefined(self._stance_button_think_threaded)) {
        self thread button_held_think(1);
        self._stance_button_think_threaded = 1;
    }
    return self._holding_button[1];
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x2cbe4896, Offset: 0x5808
// Size: 0x54
function ads_button_held() {
    init_button_wrappers();
    if (!isdefined(self._ads_button_think_threaded)) {
        self thread button_held_think(2);
        self._ads_button_think_threaded = 1;
    }
    return self._holding_button[2];
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x7e75347a, Offset: 0x5868
// Size: 0x54
function attack_button_held() {
    init_button_wrappers();
    if (!isdefined(self._attack_button_think_threaded)) {
        self thread button_held_think(3);
        self._attack_button_think_threaded = 1;
    }
    return self._holding_button[3];
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0xd497489f, Offset: 0x58c8
// Size: 0x54
function button_right_held() {
    init_button_wrappers();
    if (!isdefined(self._dpad_right_button_think_threaded)) {
        self thread button_held_think(6);
        self._dpad_right_button_think_threaded = 1;
    }
    return self._holding_button[6];
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x9a819cd3, Offset: 0x5928
// Size: 0x2c
function waittill_use_button_pressed() {
    while (!self usebuttonpressed()) {
        wait 0.05;
    }
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x4c45126d, Offset: 0x5960
// Size: 0x2c
function waittill_use_button_held() {
    while (!self use_button_held()) {
        wait 0.05;
    }
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x408d80dc, Offset: 0x5998
// Size: 0x2c
function waittill_stance_button_pressed() {
    while (!self stancebuttonpressed()) {
        wait 0.05;
    }
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0xbd1fefcd, Offset: 0x59d0
// Size: 0x2c
function waittill_stance_button_held() {
    while (!self stance_button_held()) {
        wait 0.05;
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xfb49759e, Offset: 0x5a08
// Size: 0x2c
function waittill_attack_button_pressed() {
    while (!self attackbuttonpressed()) {
        wait 0.05;
    }
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x99111c7b, Offset: 0x5a40
// Size: 0x2c
function waittill_ads_button_pressed() {
    while (!self adsbuttonpressed()) {
        wait 0.05;
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xfdc442a1, Offset: 0x5a78
// Size: 0x2c
function waittill_vehicle_move_up_button_pressed() {
    while (!self vehiclemoveupbuttonpressed()) {
        wait 0.05;
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x3b07c602, Offset: 0x5ab0
// Size: 0xe2
function init_button_wrappers() {
    if (!isdefined(level._button_funcs)) {
        level._button_funcs[0] = &usebuttonpressed;
        level._button_funcs[2] = &adsbuttonpressed;
        level._button_funcs[3] = &attackbuttonpressed;
        level._button_funcs[1] = &stancebuttonpressed;
        level._button_funcs[6] = &actionslotfourbuttonpressed;
        /#
            level._button_funcs[4] = &up_button_pressed;
            level._button_funcs[5] = &down_button_pressed;
        #/
    }
}

/#

    // Namespace util
    // Params 0, eflags: 0x1 linked
    // Checksum 0x9770c448, Offset: 0x5ba0
    // Size: 0x5e
    function up_button_held() {
        init_button_wrappers();
        if (!isdefined(self._up_button_think_threaded)) {
            self thread button_held_think(4);
            self._up_button_think_threaded = 1;
        }
        return self._holding_button[4];
    }

    // Namespace util
    // Params 0, eflags: 0x1 linked
    // Checksum 0x193b944, Offset: 0x5c08
    // Size: 0x5e
    function down_button_held() {
        init_button_wrappers();
        if (!isdefined(self._down_button_think_threaded)) {
            self thread button_held_think(5);
            self._down_button_think_threaded = 1;
        }
        return self._holding_button[5];
    }

    // Namespace util
    // Params 0, eflags: 0x1 linked
    // Checksum 0x209f1ac9, Offset: 0x5c70
    // Size: 0x44
    function up_button_pressed() {
        return self buttonpressed("<dev string:x745>") || self buttonpressed("<dev string:x74d>");
    }

    // Namespace util
    // Params 0, eflags: 0x0
    // Checksum 0xda85da42, Offset: 0x5cc0
    // Size: 0x2c
    function waittill_up_button_pressed() {
        while (!self up_button_pressed()) {
            wait 0.05;
        }
    }

    // Namespace util
    // Params 0, eflags: 0x1 linked
    // Checksum 0x29ecbe16, Offset: 0x5cf8
    // Size: 0x44
    function down_button_pressed() {
        return self buttonpressed("<dev string:x755>") || self buttonpressed("<dev string:x75f>");
    }

    // Namespace util
    // Params 0, eflags: 0x0
    // Checksum 0xa37ed3df, Offset: 0x5d48
    // Size: 0x2c
    function waittill_down_button_pressed() {
        while (!self down_button_pressed()) {
            wait 0.05;
        }
    }

#/

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x1b2cc398, Offset: 0x5d80
// Size: 0x64
function freeze_player_controls(b_frozen) {
    if (!isdefined(b_frozen)) {
        b_frozen = 1;
    }
    if (isdefined(level.hostmigrationtimer)) {
        b_frozen = 1;
    }
    if (b_frozen || !level.gameended) {
        self freezecontrols(b_frozen);
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xc029f559, Offset: 0x5df0
// Size: 0x4c
function is_bot() {
    return isplayer(self) && isdefined(self.pers["isBot"]) && self.pers["isBot"] != 0;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xdd357881, Offset: 0x5e48
// Size: 0x16
function ishacked() {
    return isdefined(self.hacked) && self.hacked;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x9b3af3b6, Offset: 0x5e68
// Size: 0x90
function getlastweapon() {
    last_weapon = undefined;
    if (isdefined(self.lastnonkillstreakweapon) && self hasweapon(self.lastnonkillstreakweapon)) {
        last_weapon = self.lastnonkillstreakweapon;
    } else if (isdefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
        last_weapon = self.lastdroppableweapon;
    }
    return last_weapon;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x484d35a, Offset: 0x5f00
// Size: 0x8c
function isenemyplayer(player) {
    assert(isdefined(player));
    if (!isplayer(player)) {
        return false;
    }
    if (level.teambased) {
        if (player.team == self.team) {
            return false;
        }
    } else if (player == self) {
        return false;
    }
    return true;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x101dabe2, Offset: 0x5f98
// Size: 0x2c
function waittillslowprocessallowed() {
    while (level.lastslowprocessframe == gettime()) {
        wait 0.05;
    }
    level.lastslowprocessframe = gettime();
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x8dd2bb7b, Offset: 0x5fd0
// Size: 0x12
function get_start_time() {
    return getmicrosecondsraw();
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0xbdd83c1a, Offset: 0x5ff0
// Size: 0xec
function note_elapsed_time(start_time, label) {
    if (!isdefined(label)) {
        label = "unknown";
    }
    /#
        elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
        if (!isdefined(start_time)) {
            return;
        }
        elapsed_time *= 0.001;
        if (!level.orbis) {
            elapsed_time = int(elapsed_time);
        }
        msg = label + "<dev string:x769>" + elapsed_time + "<dev string:x779>";
        iprintln(msg);
    #/
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0x80050702, Offset: 0x60e8
// Size: 0x82
function get_elapsed_time(start_time, end_time) {
    if (!isdefined(end_time)) {
        end_time = getmicrosecondsraw();
    }
    if (!isdefined(start_time)) {
        return undefined;
    }
    elapsed_time = end_time - start_time;
    if (elapsed_time < 0) {
        elapsed_time += -2147483648;
    }
    return elapsed_time;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x3c7d4ae5, Offset: 0x6178
// Size: 0x4e
function mayapplyscreeneffect() {
    assert(isdefined(self));
    assert(isplayer(self));
    return !isdefined(self.viewlockedentity);
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xa8cbf491, Offset: 0x61d0
// Size: 0x98
function waittillnotmoving() {
    if (self ishacked()) {
        wait 0.05;
        return;
    }
    if (self.classname == "grenade") {
        self waittill(#"stationary");
        return;
    }
    for (prevorigin = self.origin; true; prevorigin = self.origin) {
        wait 0.15;
        if (self.origin == prevorigin) {
            break;
        }
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xa55d7523, Offset: 0x6270
// Size: 0x64
function waittillrollingornotmoving() {
    if (self ishacked()) {
        wait 0.05;
        return "stationary";
    }
    movestate = self waittill_any_return("stationary", "rolling");
    return movestate;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x4150021d, Offset: 0x62e0
// Size: 0x4c
function function_bc37a245() {
    if (sessionmodeiscampaigngame()) {
        return "gamedata/stats/cp/cp_statstable.csv";
    }
    if (sessionmodeiszombiesgame()) {
        return "gamedata/stats/zm/zm_statstable.csv";
    }
    return "gamedata/stats/mp/mp_statstable.csv";
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x970d5e25, Offset: 0x6338
// Size: 0xfe
function getweaponclass(weapon) {
    if (weapon == level.weaponnone) {
        return undefined;
    }
    if (!weapon.isvalid) {
        return undefined;
    }
    if (!isdefined(level.weaponclassarray)) {
        level.weaponclassarray = [];
    }
    if (isdefined(level.weaponclassarray[weapon])) {
        return level.weaponclassarray[weapon];
    }
    baseweaponparam = [[ level.var_2453cf4a ]](weapon);
    baseweaponindex = getbaseweaponitemindex(baseweaponparam);
    weaponclass = tablelookup(function_bc37a245(), 0, baseweaponindex, 2);
    level.weaponclassarray[weapon] = weaponclass;
    return weaponclass;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xef6ca5d9, Offset: 0x6440
// Size: 0xc
function isusingremote() {
    return isdefined(self.usingremote);
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x2281f4b6, Offset: 0x6458
// Size: 0x84
function deleteaftertime(time) {
    assert(isdefined(self));
    assert(isdefined(time));
    assert(time >= 0.05);
    self thread deleteaftertimethread(time);
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x6ef2befa, Offset: 0x64e8
// Size: 0x34
function deleteaftertimethread(time) {
    self endon(#"death");
    wait time;
    self delete();
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xcb4a837c, Offset: 0x6528
// Size: 0x3a
function waitfortime(time) {
    if (!isdefined(time)) {
        time = 0;
    }
    if (time > 0) {
        wait time;
    }
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xabb97701, Offset: 0x6570
// Size: 0x8c
function waitfortimeandnetworkframe(time) {
    if (!isdefined(time)) {
        time = 0;
    }
    start_time_ms = gettime();
    wait_network_frame();
    elapsed_time = (gettime() - start_time_ms) * 0.001;
    remaining_time = time - elapsed_time;
    if (remaining_time > 0) {
        wait remaining_time;
    }
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x4800dd1c, Offset: 0x6608
// Size: 0x54
function deleteaftertimeandnetworkframe(time) {
    assert(isdefined(self));
    waitfortimeandnetworkframe(time);
    self delete();
}

/#

    // Namespace util
    // Params 7, eflags: 0x1 linked
    // Checksum 0xb3c1deef, Offset: 0x6668
    // Size: 0x84
    function drawcylinder(pos, rad, height, duration, stop_notify, color, alpha) {
        if (!isdefined(duration)) {
            duration = 0;
        }
        level thread drawcylinder_think(pos, rad, height, duration, stop_notify, color, alpha);
    }

    // Namespace util
    // Params 7, eflags: 0x1 linked
    // Checksum 0xb48d5914, Offset: 0x66f8
    // Size: 0x314
    function drawcylinder_think(pos, rad, height, seconds, stop_notify, color, alpha) {
        if (isdefined(stop_notify)) {
            level endon(stop_notify);
        }
        stop_time = gettime() + seconds * 1000;
        currad = rad;
        curheight = height;
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        if (!isdefined(alpha)) {
            alpha = 1;
        }
        for (;;) {
            if (seconds > 0 && stop_time <= gettime()) {
                return;
            }
            for (r = 0; r < 20; r++) {
                theta = r / 20 * 360;
                theta2 = (r + 1) / 20 * 360;
                line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color, alpha);
                line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color, alpha);
                line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color, alpha);
            }
            wait 0.05;
        }
    }

#/

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xa59401c9, Offset: 0x6a18
// Size: 0xbc
function function_c664826a(teamname) {
    var_8461c9aa = spawn_array_struct();
    if (isdefined(teamname) && isdefined(level.aliveplayers) && isdefined(level.aliveplayers[teamname])) {
        for (i = 0; i < level.aliveplayers[teamname].size; i++) {
            var_8461c9aa.a[var_8461c9aa.a.size] = level.aliveplayers[teamname][i];
        }
    }
    return var_8461c9aa;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xb1dcc58f, Offset: 0x6ae0
// Size: 0x162
function function_a791434c(var_a0b1334a) {
    var_8461c9aa = spawn_array_struct();
    if (isdefined(var_a0b1334a) && isdefined(level.aliveplayers)) {
        foreach (team in level.teams) {
            if (team == var_a0b1334a) {
                continue;
            }
            foreach (player in level.aliveplayers[team]) {
                var_8461c9aa.a[var_8461c9aa.a.size] = player;
            }
        }
    }
    return var_8461c9aa;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x101f37f6, Offset: 0x6c50
// Size: 0xfa
function function_1edbd8() {
    var_93bfc6ee = spawn_array_struct();
    if (isdefined(level.aliveplayers)) {
        keys = getarraykeys(level.aliveplayers);
        for (i = 0; i < keys.size; i++) {
            team = keys[i];
            for (j = 0; j < level.aliveplayers[team].size; j++) {
                var_93bfc6ee.a[var_93bfc6ee.a.size] = level.aliveplayers[team][j];
            }
        }
    }
    return var_93bfc6ee;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xb1a1b181, Offset: 0x6d58
// Size: 0x34
function spawn_array_struct() {
    s = spawnstruct();
    s.a = [];
    return s;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x5fde2e9, Offset: 0x6d98
// Size: 0x74
function gethostplayer() {
    players = getplayers();
    for (index = 0; index < players.size; index++) {
        if (players[index] ishost()) {
            return players[index];
        }
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xa1dc7f68, Offset: 0x6e18
// Size: 0x74
function gethostplayerforbots() {
    players = getplayers();
    for (index = 0; index < players.size; index++) {
        if (players[index] ishostforbots()) {
            return players[index];
        }
    }
}

// Namespace util
// Params 5, eflags: 0x1 linked
// Checksum 0x9ca2cfd, Offset: 0x6e98
// Size: 0x328
function get_array_of_closest(org, array, excluders, max, maxdist) {
    if (!isdefined(max)) {
        max = array.size;
    }
    if (!isdefined(excluders)) {
        excluders = [];
    }
    maxdists2rd = undefined;
    if (isdefined(maxdist)) {
        maxdists2rd = maxdist * maxdist;
    }
    dist = [];
    index = [];
    for (i = 0; i < array.size; i++) {
        if (!isdefined(array[i])) {
            continue;
        }
        if (isinarray(excluders, array[i])) {
            continue;
        }
        if (isvec(array[i])) {
            length = distancesquared(org, array[i]);
        } else {
            length = distancesquared(org, array[i].origin);
        }
        if (isdefined(maxdists2rd) && maxdists2rd < length) {
            continue;
        }
        dist[dist.size] = length;
        index[index.size] = i;
    }
    for (;;) {
        change = 0;
        for (i = 0; i < dist.size - 1; i++) {
            if (dist[i] <= dist[i + 1]) {
                continue;
            }
            change = 1;
            temp = dist[i];
            dist[i] = dist[i + 1];
            dist[i + 1] = temp;
            temp = index[i];
            index[i] = index[i + 1];
            index[i + 1] = temp;
        }
        if (!change) {
            break;
        }
    }
    newarray = [];
    if (max > dist.size) {
        max = dist.size;
    }
    for (i = 0; i < max; i++) {
        newarray[i] = array[index[i]];
    }
    return newarray;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x449d6d98, Offset: 0x71c8
// Size: 0x144
function set_lighting_state(n_state) {
    if (isdefined(n_state)) {
        self.lighting_state = n_state;
    } else {
        self.lighting_state = level.lighting_state;
    }
    if (isdefined(self.lighting_state)) {
        if (self == level) {
            if (isdefined(level.activeplayers)) {
                foreach (player in level.activeplayers) {
                    player set_lighting_state(level.lighting_state);
                }
            }
            return;
        }
        if (isplayer(self)) {
            self setlightingstate(self.lighting_state);
            return;
        }
        assertmsg("<dev string:x77d>");
    }
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x7cc5229d, Offset: 0x7318
// Size: 0x144
function set_sun_shadow_split_distance(f_distance) {
    if (isdefined(f_distance)) {
        self.sun_shadow_split_distance = f_distance;
    } else {
        self.sun_shadow_split_distance = level.sun_shadow_split_distance;
    }
    if (isdefined(self.sun_shadow_split_distance)) {
        if (self == level) {
            if (isdefined(level.activeplayers)) {
                foreach (player in level.activeplayers) {
                    player set_sun_shadow_split_distance(level.sun_shadow_split_distance);
                }
            }
            return;
        }
        if (isplayer(self)) {
            self setsunshadowsplitdistance(self.sun_shadow_split_distance);
            return;
        }
        assertmsg("<dev string:x7af>");
    }
}

// Namespace util
// Params 4, eflags: 0x1 linked
// Checksum 0xf9b150a4, Offset: 0x7468
// Size: 0x49c
function auto_delete(n_mode, n_min_time_alive, n_dist_horizontal, n_dist_vertical) {
    if (!isdefined(n_mode)) {
        n_mode = 1;
    }
    if (!isdefined(n_min_time_alive)) {
        n_min_time_alive = 0;
    }
    if (!isdefined(n_dist_horizontal)) {
        n_dist_horizontal = 0;
    }
    if (!isdefined(n_dist_vertical)) {
        n_dist_vertical = 0;
    }
    self endon(#"death");
    self notify(#"__auto_delete__");
    self endon(#"__auto_delete__");
    level flag::wait_till("all_players_spawned");
    if (isdefined(level.heroes) && isinarray(level.heroes, self)) {
        return;
    }
    if (n_mode & 16 || n_mode == 1 || n_mode == 8) {
        n_mode |= 2;
        n_mode |= 4;
    }
    n_think_time = 1;
    n_tests_to_do = 2;
    n_dot_check = 0;
    if (n_mode & 16) {
        n_think_time = 0.2;
        n_tests_to_do = 1;
        n_dot_check = 0.4;
    }
    for (n_test_count = 0; true; n_test_count = 0) {
        do {
            wait randomfloatrange(n_think_time - n_think_time / 3, n_think_time + n_think_time / 3);
        } while (isdefined(self.birthtime) && (gettime() - self.birthtime) / 1000 < n_min_time_alive);
        n_tests_passed = 0;
        foreach (player in level.players) {
            if (n_dist_horizontal && distance2dsquared(self.origin, player.origin) < n_dist_horizontal) {
                continue;
            }
            if (n_dist_vertical && abs(self.origin[2] - player.origin[2]) < n_dist_vertical) {
                continue;
            }
            v_eye = player geteye();
            b_behind = 0;
            if (n_mode & 2) {
                v_facing = anglestoforward(player getplayerangles());
                v_to_ent = vectornormalize(self.origin - v_eye);
                n_dot = vectordot(v_facing, v_to_ent);
                if (n_dot < n_dot_check) {
                    b_behind = 1;
                    if (!(n_mode & 1)) {
                        n_tests_passed++;
                        continue;
                    }
                }
            }
            if (n_mode & 4) {
                if (!self sightconetrace(v_eye, player)) {
                    if (b_behind || !(n_mode & 1)) {
                        n_tests_passed++;
                    }
                }
            }
        }
        if (n_tests_passed == level.players.size) {
            n_test_count++;
            if (n_test_count < n_tests_to_do) {
                continue;
            }
            self notify(#"_disable_reinforcement");
            self delete();
            continue;
        }
    }
}

// Namespace util
// Params 5, eflags: 0x1 linked
// Checksum 0x20a20f9b, Offset: 0x7910
// Size: 0x3f2
function query_ents(&a_kvps_match, b_match_all, &a_kvps_ingnore, b_ignore_spawners, b_match_substrings) {
    if (!isdefined(b_match_all)) {
        b_match_all = 1;
    }
    if (!isdefined(b_ignore_spawners)) {
        b_ignore_spawners = 0;
    }
    if (!isdefined(b_match_substrings)) {
        b_match_substrings = 0;
    }
    a_ret = [];
    if (b_match_substrings) {
        a_all_ents = getentarray();
        b_first = 1;
        foreach (k, v in a_kvps_match) {
            a_ents = _query_ents_by_substring_helper(a_all_ents, v, k, b_ignore_spawners);
            if (b_first) {
                a_ret = a_ents;
                b_first = 0;
                continue;
            }
            if (b_match_all) {
                a_ret = arrayintersect(a_ret, a_ents);
                continue;
            }
            a_ret = arraycombine(a_ret, a_ents, 0, 0);
        }
        if (isdefined(a_kvps_ingnore)) {
            foreach (k, v in a_kvps_ingnore) {
                a_ents = _query_ents_by_substring_helper(a_all_ents, v, k, b_ignore_spawners);
                a_ret = array::exclude(a_ret, a_ents);
            }
        }
    } else {
        b_first = 1;
        foreach (k, v in a_kvps_match) {
            a_ents = getentarray(v, k);
            if (b_first) {
                a_ret = a_ents;
                b_first = 0;
                continue;
            }
            if (b_match_all) {
                a_ret = arrayintersect(a_ret, a_ents);
                continue;
            }
            a_ret = arraycombine(a_ret, a_ents, 0, 0);
        }
        if (isdefined(a_kvps_ingnore)) {
            foreach (k, v in a_kvps_ingnore) {
                a_ents = getentarray(v, k);
                a_ret = array::exclude(a_ret, a_ents);
            }
        }
    }
    return a_ret;
}

// Namespace util
// Params 4, eflags: 0x1 linked
// Checksum 0xa1a1c160, Offset: 0x7d10
// Size: 0x60c
function _query_ents_by_substring_helper(&a_ents, str_value, str_key, b_ignore_spawners) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    if (!isdefined(b_ignore_spawners)) {
        b_ignore_spawners = 0;
    }
    a_ret = [];
    foreach (ent in a_ents) {
        if (b_ignore_spawners && isspawner(ent)) {
            continue;
        }
        switch (str_key) {
        case "targetname":
            if (isstring(ent.targetname) && issubstr(ent.targetname, str_value)) {
                if (!isdefined(a_ret)) {
                    a_ret = [];
                } else if (!isarray(a_ret)) {
                    a_ret = array(a_ret);
                }
                a_ret[a_ret.size] = ent;
            }
            break;
        case "script_noteworthy":
            if (isstring(ent.script_noteworthy) && issubstr(ent.script_noteworthy, str_value)) {
                if (!isdefined(a_ret)) {
                    a_ret = [];
                } else if (!isarray(a_ret)) {
                    a_ret = array(a_ret);
                }
                a_ret[a_ret.size] = ent;
            }
            break;
        case "classname":
            if (isstring(ent.classname) && issubstr(ent.classname, str_value)) {
                if (!isdefined(a_ret)) {
                    a_ret = [];
                } else if (!isarray(a_ret)) {
                    a_ret = array(a_ret);
                }
                a_ret[a_ret.size] = ent;
            }
            break;
        case "vehicletype":
            if (isstring(ent.vehicletype) && issubstr(ent.vehicletype, str_value)) {
                if (!isdefined(a_ret)) {
                    a_ret = [];
                } else if (!isarray(a_ret)) {
                    a_ret = array(a_ret);
                }
                a_ret[a_ret.size] = ent;
            }
            break;
        case "script_string":
            if (isstring(ent.script_string) && issubstr(ent.script_string, str_value)) {
                if (!isdefined(a_ret)) {
                    a_ret = [];
                } else if (!isarray(a_ret)) {
                    a_ret = array(a_ret);
                }
                a_ret[a_ret.size] = ent;
            }
            break;
        case "script_color_axis":
            if (isstring(ent.script_color_axis) && issubstr(ent.script_color_axis, str_value)) {
                if (!isdefined(a_ret)) {
                    a_ret = [];
                } else if (!isarray(a_ret)) {
                    a_ret = array(a_ret);
                }
                a_ret[a_ret.size] = ent;
            }
            break;
        case "script_color_allies":
            if (isstring(ent.script_color_axis) && issubstr(ent.script_color_axis, str_value)) {
                if (!isdefined(a_ret)) {
                    a_ret = [];
                } else if (!isarray(a_ret)) {
                    a_ret = array(a_ret);
                }
                a_ret[a_ret.size] = ent;
            }
            break;
        default:
            assert("<dev string:x7ec>" + str_key + "<dev string:x7ff>");
            break;
        }
    }
    return a_ret;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xa847374c, Offset: 0x8328
// Size: 0x34e
function get_weapon_by_name(weapon_name) {
    split = strtok(weapon_name, "+");
    switch (split.size) {
    case 1:
    default:
        weapon = getweapon(split[0]);
        break;
    case 2:
        weapon = getweapon(split[0], split[1]);
        break;
    case 3:
        weapon = getweapon(split[0], split[1], split[2]);
        break;
    case 4:
        weapon = getweapon(split[0], split[1], split[2], split[3]);
        break;
    case 5:
        weapon = getweapon(split[0], split[1], split[2], split[3], split[4]);
        break;
    case 6:
        weapon = getweapon(split[0], split[1], split[2], split[3], split[4], split[5]);
        break;
    case 7:
        weapon = getweapon(split[0], split[1], split[2], split[3], split[4], split[5], split[6]);
        break;
    case 8:
        weapon = getweapon(split[0], split[1], split[2], split[3], split[4], split[5], split[6], split[7]);
        break;
    case 9:
        weapon = getweapon(split[0], split[1], split[2], split[3], split[4], split[5], split[6], split[7], split[8]);
        break;
    }
    return weapon;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xc171afc9, Offset: 0x8680
// Size: 0x72
function is_female() {
    gender = self getplayergendertype(currentsessionmode());
    b_female = 0;
    if (isdefined(gender) && gender == "female") {
        b_female = 1;
    }
    return b_female;
}

// Namespace util
// Params 6, eflags: 0x1 linked
// Checksum 0x2020085f, Offset: 0x8700
// Size: 0x196
function positionquery_pointarray(origin, minsearchradius, maxsearchradius, halfheight, innerspacing, reachableby_ent) {
    if (isdefined(reachableby_ent)) {
        queryresult = positionquery_source_navigation(origin, minsearchradius, maxsearchradius, halfheight, innerspacing, reachableby_ent);
    } else {
        queryresult = positionquery_source_navigation(origin, minsearchradius, maxsearchradius, halfheight, innerspacing);
    }
    pointarray = [];
    foreach (pointstruct in queryresult.data) {
        if (!isdefined(pointarray)) {
            pointarray = [];
        } else if (!isarray(pointarray)) {
            pointarray = array(pointarray);
        }
        pointarray[pointarray.size] = pointstruct.origin;
    }
    return pointarray;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xaeadf2dc, Offset: 0x88a0
// Size: 0xa2
function totalplayercount() {
    count = 0;
    foreach (team in level.teams) {
        count += level.playercount[team];
    }
    return count;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x92cff701, Offset: 0x8950
// Size: 0x16
function isrankenabled() {
    return isdefined(level.rankenabled) && level.rankenabled;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xe0cbb521, Offset: 0x8970
// Size: 0x1c
function isoneround() {
    if (level.roundlimit == 1) {
        return true;
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x9cabc86c, Offset: 0x8998
// Size: 0x2e
function isfirstround() {
    if (level.roundlimit > 1 && game["roundsplayed"] == 0) {
        return true;
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x36f62146, Offset: 0x89d0
// Size: 0x3a
function islastround() {
    if (level.roundlimit > 1 && game["roundsplayed"] >= level.roundlimit - 1) {
        return true;
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x347ab8c3, Offset: 0x8a18
// Size: 0xae
function waslastround() {
    if (level.forcedend) {
        return true;
    }
    if (isdefined(level.shouldplayovertimeround)) {
        if ([[ level.shouldplayovertimeround ]]()) {
            level.nextroundisovertime = 1;
            return false;
        } else if (isdefined(game["overtime_round"])) {
            return true;
        }
    }
    if (hitroundlimit() || hitscorelimit() || hitroundwinlimit()) {
        return true;
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xb23bdf08, Offset: 0x8ad0
// Size: 0x34
function hitroundlimit() {
    if (level.roundlimit <= 0) {
        return false;
    }
    return getroundsplayed() >= level.roundlimit;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xfaa9d468, Offset: 0x8b10
// Size: 0x9e
function anyteamhitroundwinlimit() {
    foreach (team in level.teams) {
        if (getroundswon(team) >= level.roundwinlimit) {
            return true;
        }
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x91d81fa0, Offset: 0x8bb8
// Size: 0xca
function anyteamhitroundlimitwithdraws() {
    tie_wins = game["roundswon"]["tie"];
    foreach (team in level.teams) {
        if (getroundswon(team) + tie_wins >= level.roundwinlimit) {
            return true;
        }
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x89fe85, Offset: 0x8c90
// Size: 0x11c
function function_daaaa3c1() {
    var_43ba493d = 0;
    winning_team = undefined;
    foreach (team in level.teams) {
        wins = getroundswon(team);
        if (!isdefined(winning_team)) {
            var_43ba493d = wins;
            winning_team = team;
            continue;
        }
        if (wins == var_43ba493d) {
            winning_team = "tie";
            continue;
        }
        if (wins > var_43ba493d) {
            var_43ba493d = wins;
            winning_team = team;
        }
    }
    return winning_team;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xe5eb4b51, Offset: 0x8db8
// Size: 0x80
function hitroundwinlimit() {
    if (!isdefined(level.roundwinlimit) || level.roundwinlimit <= 0) {
        return false;
    }
    if (anyteamhitroundwinlimit()) {
        return true;
    }
    if (anyteamhitroundlimitwithdraws()) {
        if (function_daaaa3c1() != "tie") {
            return true;
        }
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x96bb2848, Offset: 0x8e40
// Size: 0x9a
function any_team_hit_score_limit() {
    foreach (team in level.teams) {
        if (game["teamScores"][team] >= level.scorelimit) {
            return true;
        }
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xb8bfdb7b, Offset: 0x8ee8
// Size: 0xce
function hitscorelimit() {
    if (level.scoreroundwinbased) {
        return false;
    }
    if (level.scorelimit <= 0) {
        return false;
    }
    if (level.teambased) {
        if (any_team_hit_score_limit()) {
            return true;
        }
    } else {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (isdefined(player.pointstowin) && player.pointstowin >= level.scorelimit) {
                return true;
            }
        }
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x873bde19, Offset: 0x8fc0
// Size: 0x1e
function get_current_round_score_limit() {
    return level.roundscorelimit * (game["roundsplayed"] + 1);
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xca854c44, Offset: 0x8fe8
// Size: 0xb4
function any_team_hit_round_score_limit() {
    round_score_limit = get_current_round_score_limit();
    foreach (team in level.teams) {
        if (game["teamScores"][team] >= round_score_limit) {
            return true;
        }
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x83a31c5a, Offset: 0x90a8
// Size: 0xda
function hitroundscorelimit() {
    if (level.roundscorelimit <= 0) {
        return false;
    }
    if (level.teambased) {
        if (any_team_hit_round_score_limit()) {
            return true;
        }
    } else {
        roundscorelimit = get_current_round_score_limit();
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (isdefined(player.pointstowin) && player.pointstowin >= roundscorelimit) {
                return true;
            }
        }
    }
    return false;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xbd2e2cf8, Offset: 0x9190
// Size: 0x1c
function getroundswon(team) {
    return game["roundswon"][team];
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0xf2dba2cf, Offset: 0x91b8
// Size: 0xbe
function getotherteamsroundswon(skip_team) {
    roundswon = 0;
    foreach (team in level.teams) {
        if (team == skip_team) {
            continue;
        }
        roundswon += game["roundswon"][team];
    }
    return roundswon;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xe6ff0484, Offset: 0x9280
// Size: 0xe
function getroundsplayed() {
    return game["roundsplayed"];
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xa2f4addd, Offset: 0x9298
// Size: 0x2c
function isroundbased() {
    if (level.roundlimit != 1 && level.roundwinlimit != 1) {
        return true;
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x1fabb68, Offset: 0x92d0
// Size: 0x2e
function getcurrentgamemode() {
    if (gamemodeismode(6)) {
        return "leaguematch";
    }
    return "publicmatch";
}

// Namespace util
// Params 6, eflags: 0x1 linked
// Checksum 0xcbde9a9a, Offset: 0x9308
// Size: 0x13c
function ground_position(v_start, n_max_dist, n_ground_offset, e_ignore, b_ignore_water, b_ignore_glass) {
    if (!isdefined(n_max_dist)) {
        n_max_dist = 5000;
    }
    if (!isdefined(n_ground_offset)) {
        n_ground_offset = 0;
    }
    if (!isdefined(b_ignore_water)) {
        b_ignore_water = 0;
    }
    if (!isdefined(b_ignore_glass)) {
        b_ignore_glass = 0;
    }
    v_trace_start = v_start + (0, 0, 5);
    v_trace_end = v_trace_start + (0, 0, (n_max_dist + 5) * -1);
    a_trace = groundtrace(v_trace_start, v_trace_end, 0, e_ignore, b_ignore_water, b_ignore_glass);
    if (a_trace["surfacetype"] != "none") {
        return (a_trace["position"] + (0, 0, n_ground_offset));
    }
    return v_start;
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0x4884d367, Offset: 0x9450
// Size: 0x2c
function delayed_notify(str_notify, f_delay_seconds) {
    wait f_delay_seconds;
    if (isdefined(self)) {
        self notify(str_notify);
    }
}

// Namespace util
// Params 2, eflags: 0x0
// Checksum 0x181f7ae1, Offset: 0x9488
// Size: 0x74
function delayed_delete(str_notify, f_delay_seconds) {
    assert(isentity(self));
    wait f_delay_seconds;
    if (isdefined(self) && isentity(self)) {
        self delete();
    }
}

// Namespace util
// Params 11, eflags: 0x1 linked
// Checksum 0x964edc9, Offset: 0x9508
// Size: 0x1ac
function function_46d3a558(var_5b9e7d6a, var_b6f6ffa9, var_8e6b5bc3, var_9817cc42, var_e68fbbe4, var_838069df, var_b1a5ab8d, var_8f247060, var_fea4654e, var_bd4a51b5, n_duration) {
    if (!isdefined(var_fea4654e)) {
        var_fea4654e = "";
    }
    if (!isdefined(var_bd4a51b5)) {
        var_bd4a51b5 = "";
    }
    level.chyron_text_active = 1;
    level flagsys::set("chyron_active");
    if (!isdefined(n_duration)) {
        n_duration = 12;
    }
    foreach (player in level.players) {
        player thread function_9155d925(var_5b9e7d6a, var_b6f6ffa9, var_8e6b5bc3, var_9817cc42, var_e68fbbe4, var_838069df, var_b1a5ab8d, var_8f247060, var_fea4654e, var_bd4a51b5, n_duration);
    }
    level waittill(#"chyron_menu_closed");
    level.chyron_text_active = undefined;
    level flagsys::clear("chyron_active");
}

// Namespace util
// Params 11, eflags: 0x1 linked
// Checksum 0xcffbe204, Offset: 0x96c0
// Size: 0x384
function function_9155d925(var_5b9e7d6a, var_b6f6ffa9, var_8e6b5bc3, var_9817cc42, var_e68fbbe4, var_838069df, var_b1a5ab8d, var_8f247060, var_fea4654e, var_bd4a51b5, n_duration) {
    if (!isdefined(var_fea4654e)) {
        var_fea4654e = "";
    }
    if (!isdefined(var_bd4a51b5)) {
        var_bd4a51b5 = "";
    }
    self endon(#"disconnect");
    assert(isdefined(n_duration), "<dev string:x81c>");
    var_c2dc2b72 = self openluimenu("CPChyron");
    self setluimenudata(var_c2dc2b72, "line1full", var_5b9e7d6a);
    self setluimenudata(var_c2dc2b72, "line1short", var_b6f6ffa9);
    self setluimenudata(var_c2dc2b72, "line2full", var_8e6b5bc3);
    self setluimenudata(var_c2dc2b72, "line2short", var_9817cc42);
    mapname = getdvarstring("mapname");
    var_8acee1d9 = 0;
    if (mapname == "cp_mi_eth_prologue" && sessionmodeiscampaignzombiesgame()) {
        var_8acee1d9 = 1;
    }
    if (!var_8acee1d9) {
        self setluimenudata(var_c2dc2b72, "line3full", var_e68fbbe4);
        self setluimenudata(var_c2dc2b72, "line3short", var_838069df);
    }
    if (!sessionmodeiscampaignzombiesgame()) {
        self setluimenudata(var_c2dc2b72, "line4full", var_b1a5ab8d);
        self setluimenudata(var_c2dc2b72, "line4short", var_8f247060);
        self setluimenudata(var_c2dc2b72, "line5full", var_fea4654e);
        self setluimenudata(var_c2dc2b72, "line5short", var_bd4a51b5);
    }
    waittillframeend();
    self notify(#"chyron_menu_open");
    level notify(#"chyron_menu_open");
    do {
        menu, response = self waittill(#"menuresponse");
    } while (menu != "CPChyron" || response != "closed");
    self notify(#"chyron_menu_closed");
    level notify(#"chyron_menu_closed");
    wait 5;
    self closeluimenu(var_c2dc2b72);
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x4a8ad5a0, Offset: 0x9a50
// Size: 0x2e
function function_3eb32a89(str_next_map) {
    switch (str_next_map) {
    case "cp_mi_sing_biodomes":
    case "cp_mi_sing_blackstation":
    case "cp_mi_sing_sgen":
        return "cp_sh_singapore";
    case "cp_mi_cairo_aquifer":
    case "cp_mi_cairo_infection":
    case "cp_mi_cairo_lotus":
        return "cp_sh_cairo";
    default:
        return "cp_sh_mobile";
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xf7ed560f, Offset: 0x9ac8
// Size: 0x70
function is_safehouse() {
    mapname = tolower(getdvarstring("mapname"));
    if (mapname == "cp_sh_cairo" || mapname == "cp_sh_mobile" || mapname == "cp_sh_singapore") {
        return true;
    }
    return false;
}

// Namespace util
// Params 0, eflags: 0x0
// Checksum 0x43f45cc6, Offset: 0x9b40
// Size: 0x4a
function is_new_cp_map() {
    mapname = tolower(getdvarstring("mapname"));
    switch (mapname) {
    case "cp_mi_cairo_aquifer":
    case "cp_mi_cairo_infection":
    case "cp_mi_cairo_lotus":
    case "cp_mi_cairo_ramses":
    case "cp_mi_eth_prologue":
    case "cp_mi_sing_biodomes":
    case "cp_mi_sing_blackstation":
    case "cp_mi_sing_chinatown":
    case "cp_mi_sing_sgen":
    case "cp_mi_sing_vengeance":
    case "cp_mi_zurich_coalescene":
    case "cp_mi_zurich_newworld":
        return true;
    default:
        return false;
    }
}

/#

    // Namespace util
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7032df76, Offset: 0x9c08
    // Size: 0x5c
    function add_queued_debug_command(cmd) {
        if (!isdefined(level.dbg_cmd_queue)) {
            level thread queued_debug_commands();
        }
        if (isdefined(level.dbg_cmd_queue)) {
            array::push(level.dbg_cmd_queue, cmd, 0);
        }
    }

    // Namespace util
    // Params 0, eflags: 0x1 linked
    // Checksum 0x68553086, Offset: 0x9c70
    // Size: 0xa8
    function queued_debug_commands() {
        self notify(#"queued_debug_commands");
        self endon(#"queued_debug_commands");
        if (!isdefined(level.dbg_cmd_queue)) {
            level.dbg_cmd_queue = [];
        }
        while (true) {
            wait 0.05;
            if (level.dbg_cmd_queue.size == 0) {
                level.dbg_cmd_queue = undefined;
                return;
            }
            cmd = array::pop_front(level.dbg_cmd_queue, 0);
            adddebugcommand(cmd);
        }
    }

#/

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x18bd3c9, Offset: 0x9d20
// Size: 0x13c
function function_7d553ac6() {
    if (self == level) {
        foreach (e_player in level.activeplayers) {
            e_player freeze_player_controls(1);
            e_player scene::set_igc_active(1);
            level notify(#"disable_cybercom", e_player, 1);
            e_player show_hud(0);
        }
        return;
    }
    self freeze_player_controls(1);
    self scene::set_igc_active(1);
    level notify(#"disable_cybercom", self, 1);
    self show_hud(0);
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xbd91552d, Offset: 0x9e68
// Size: 0x13c
function function_f7beb173() {
    if (self == level) {
        foreach (e_player in level.activeplayers) {
            e_player freeze_player_controls(0);
            e_player scene::set_igc_active(0);
            level notify(#"enable_cybercom", e_player);
            e_player show_hud(1);
        }
        return;
    }
    self freeze_player_controls(0);
    self scene::set_igc_active(0);
    level notify(#"enable_cybercom", e_player);
    self show_hud(1);
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xa5ee6dd2, Offset: 0x9fb0
// Size: 0xb4
function show_hud(b_show) {
    if (b_show) {
        if (!(isdefined(self.var_6c56bb) && self.var_6c56bb)) {
            if (!self flagsys::get("playing_movie_hide_hud")) {
                if (!scene::is_igc_active()) {
                    if (!(isdefined(self.var_a954e196) && self.var_a954e196)) {
                        self setclientuivisibilityflag("hud_visible", 1);
                    }
                }
            }
        }
        return;
    }
    self setclientuivisibilityflag("hud_visible", 0);
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x7751e1cb, Offset: 0xa070
// Size: 0x42
function array_copy_if_array(any_var) {
    return isarray(any_var) ? arraycopy(any_var) : any_var;
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xd5f568cc, Offset: 0xa0c0
// Size: 0x6a
function is_item_purchased(ref) {
    itemindex = getitemindexfromref(ref);
    return itemindex < 0 || itemindex >= 256 ? 0 : self isitempurchased(itemindex);
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xab3a1c31, Offset: 0xa138
// Size: 0x3a
function has_purchased_perk_equipped(ref) {
    return self hasperk(ref) && self is_item_purchased(ref);
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0x7ab246f9, Offset: 0xa180
// Size: 0x64
function has_purchased_perk_equipped_with_specific_stat(single_perk_ref, stats_table_ref) {
    if (isplayer(self)) {
        return (self hasperk(single_perk_ref) && self is_item_purchased(stats_table_ref));
    }
    return 0;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xbde4192f, Offset: 0xa1f0
// Size: 0x1a
function has_flak_jacket_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped("specialty_flakjacket");
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x59932efc, Offset: 0xa218
// Size: 0x2a
function has_blind_eye_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_nottargetedbyairsupport", "specialty_nottargetedbyairsupport|specialty_nokillstreakreticle");
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x9d68080b, Offset: 0xa250
// Size: 0x1a
function has_ghost_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped("specialty_gpsjammer");
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x151a8403, Offset: 0xa278
// Size: 0x2a
function has_tactical_mask_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_stunprotection", "specialty_stunprotection|specialty_flashprotection|specialty_proximityprotection");
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x15f70c5e, Offset: 0xa2b0
// Size: 0x2a
function has_hacker_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_showenemyequipment", "specialty_showenemyequipment|specialty_showscorestreakicons|specialty_showenemyvehicles");
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x6515334d, Offset: 0xa2e8
// Size: 0x2a
function has_cold_blooded_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_nottargetedbyaitank", "specialty_nottargetedbyaitank|specialty_nottargetedbyraps|specialty_nottargetedbysentry|specialty_nottargetedbyrobot|specialty_immunenvthermal");
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xf0b0a969, Offset: 0xa320
// Size: 0x2a
function has_hard_wired_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_immunecounteruav", "specialty_immunecounteruav|specialty_immuneemp|specialty_immunetriggerc4|specialty_immunetriggershock|specialty_immunetriggerbetty|specialty_sixthsensejammer|specialty_trackerjammer|specialty_immunesmoke");
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x778970b4, Offset: 0xa358
// Size: 0x2a
function has_gung_ho_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_sprintfire", "specialty_sprintfire|specialty_sprintgrenadelethal|specialty_sprintgrenadetactical|specialty_sprintequipment");
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x91d6d0cf, Offset: 0xa390
// Size: 0x2a
function has_fast_hands_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_fastweaponswitch", "specialty_fastweaponswitch|specialty_sprintrecovery|specialty_sprintfirerecovery");
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x687f0449, Offset: 0xa3c8
// Size: 0x1a
function has_scavenger_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped("specialty_scavenger");
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xc70ca53, Offset: 0xa3f0
// Size: 0x2a
function has_jetquiet_perk_purchased_and_equipped() {
    return self has_purchased_perk_equipped_with_specific_stat("specialty_jetquiet", "specialty_jetnoradar|specialty_jetquiet");
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xe75e7f2a, Offset: 0xa428
// Size: 0x1a
function has_awareness_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped("specialty_loudenemies");
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xcafbc055, Offset: 0xa450
// Size: 0x1a
function has_ninja_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped("specialty_quieter");
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x5b7ca752, Offset: 0xa478
// Size: 0x1a
function has_toughness_perk_purchased_and_equipped() {
    return has_purchased_perk_equipped("specialty_bulletflinch");
}

// Namespace util
// Params 1, eflags: 0x0
// Checksum 0x74db5ff, Offset: 0xa4a0
// Size: 0x58
function str_strip_lh(str) {
    if (strendswith(str, "_lh")) {
        return getsubstr(str, 0, str.size - 3);
    }
    return str;
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x332f1b1e, Offset: 0xa500
// Size: 0x168
function trackwallrunningdistance() {
    self endon(#"disconnect");
    self.movementtracking.wallrunning = spawnstruct();
    self.movementtracking.wallrunning.distance = 0;
    self.movementtracking.wallrunning.count = 0;
    self.movementtracking.wallrunning.time = 0;
    while (true) {
        self waittill(#"wallrun_begin");
        startpos = self.origin;
        starttime = gettime();
        self.movementtracking.wallrunning.count++;
        self waittill(#"wallrun_end");
        self.movementtracking.wallrunning.distance += distance(startpos, self.origin);
        self.movementtracking.wallrunning.time += gettime() - starttime;
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0xf475eed6, Offset: 0xa670
// Size: 0x168
function tracksprintdistance() {
    self endon(#"disconnect");
    self.movementtracking.sprinting = spawnstruct();
    self.movementtracking.sprinting.distance = 0;
    self.movementtracking.sprinting.count = 0;
    self.movementtracking.sprinting.time = 0;
    while (true) {
        self waittill(#"sprint_begin");
        startpos = self.origin;
        starttime = gettime();
        self.movementtracking.sprinting.count++;
        self waittill(#"sprint_end");
        self.movementtracking.sprinting.distance += distance(startpos, self.origin);
        self.movementtracking.sprinting.time += gettime() - starttime;
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x6157e4de, Offset: 0xa7e0
// Size: 0x168
function trackdoublejumpdistance() {
    self endon(#"disconnect");
    self.movementtracking.doublejump = spawnstruct();
    self.movementtracking.doublejump.distance = 0;
    self.movementtracking.doublejump.count = 0;
    self.movementtracking.doublejump.time = 0;
    while (true) {
        self waittill(#"doublejump_begin");
        startpos = self.origin;
        starttime = gettime();
        self.movementtracking.doublejump.count++;
        self waittill(#"doublejump_end");
        self.movementtracking.doublejump.distance += distance(startpos, self.origin);
        self.movementtracking.doublejump.time += gettime() - starttime;
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x26193b6b, Offset: 0xa950
// Size: 0x70
function getplayspacecenter() {
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size) {
        return math::find_box_center(minimaporigins[0].origin, minimaporigins[1].origin);
    }
    return (0, 0, 0);
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x949f992b, Offset: 0xa9c8
// Size: 0xf6
function getplayspacemaxwidth() {
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size) {
        x = abs(minimaporigins[0].origin[0] - minimaporigins[1].origin[0]);
        y = abs(minimaporigins[0].origin[1] - minimaporigins[1].origin[1]);
        return max(x, y);
    }
    return 0;
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0xe2c4a529, Offset: 0xaac8
// Size: 0x4c
function add_devgui(menu_path, commands) {
    adddebugcommand("devgui_cmd \"" + menu_path + "\" \"" + commands + "\"\n");
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0x842121ec, Offset: 0xab20
// Size: 0x34
function remove_devgui(menu_path) {
    adddebugcommand("devgui_remove \"" + menu_path + "\"\n");
}

// Namespace util
// Params 2, eflags: 0x1 linked
// Checksum 0x7737f3af, Offset: 0xab60
// Size: 0x4c
function function_a4c90358(var_a2fce333, amount) {
    if (getdvarint("live_enableCounters", 0)) {
        incrementcounter(var_a2fce333, amount);
    }
}

// Namespace util
// Params 0, eflags: 0x1 linked
// Checksum 0x94a69868, Offset: 0xabb8
// Size: 0x34
function function_ad904acd() {
    if (getdvarint("live_enableCounters", 0)) {
        function_3a323142();
    }
}

// Namespace util
// Params 1, eflags: 0x1 linked
// Checksum 0xa47abc26, Offset: 0xabf8
// Size: 0x44
function function_522d8c7d(amount) {
    if (getdvarint("ui_enablePromoTracking", 0)) {
        function_a4c90358("zmhd_thermometer", amount);
    }
}

