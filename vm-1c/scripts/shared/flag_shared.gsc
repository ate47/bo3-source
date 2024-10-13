#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;

#namespace flag;

// Namespace flag
// Params 3, eflags: 0x1 linked
// Checksum 0x906b7e21, Offset: 0xd0
// Size: 0x116
function init(str_flag, b_val, b_is_trigger) {
    if (!isdefined(b_val)) {
        b_val = 0;
    }
    if (!isdefined(b_is_trigger)) {
        b_is_trigger = 0;
    }
    if (!isdefined(self.flag)) {
        self.flag = [];
    }
    /#
        if (!isdefined(level.first_frame)) {
            assert(!isdefined(self.flag[str_flag]), "<dev string:x28>" + str_flag + "<dev string:x50>");
        }
    #/
    self.flag[str_flag] = b_val;
    if (b_is_trigger) {
        if (!isdefined(level.trigger_flags)) {
            trigger::init_flags();
            level.trigger_flags[str_flag] = [];
            return;
        }
        if (!isdefined(level.trigger_flags[str_flag])) {
            level.trigger_flags[str_flag] = [];
        }
    }
}

// Namespace flag
// Params 1, eflags: 0x1 linked
// Checksum 0x9ba4d2b2, Offset: 0x1f0
// Size: 0x26
function exists(str_flag) {
    return isdefined(self.flag) && isdefined(self.flag[str_flag]);
}

// Namespace flag
// Params 1, eflags: 0x1 linked
// Checksum 0x5100b753, Offset: 0x220
// Size: 0x7c
function set(str_flag) {
    assert(exists(str_flag), "<dev string:x5d>" + str_flag + "<dev string:x78>");
    self.flag[str_flag] = 1;
    self notify(str_flag);
    trigger::set_flag_permissions(str_flag);
}

// Namespace flag
// Params 3, eflags: 0x1 linked
// Checksum 0x1486e9a4, Offset: 0x2a8
// Size: 0x3c
function delay_set(n_delay, str_flag, str_cancel) {
    self thread _delay_set(n_delay, str_flag, str_cancel);
}

// Namespace flag
// Params 3, eflags: 0x1 linked
// Checksum 0x41cc8d76, Offset: 0x2f0
// Size: 0x54
function _delay_set(n_delay, str_flag, str_cancel) {
    if (isdefined(str_cancel)) {
        self endon(str_cancel);
    }
    self endon(#"death");
    wait n_delay;
    set(str_flag);
}

// Namespace flag
// Params 2, eflags: 0x1 linked
// Checksum 0xf4117306, Offset: 0x350
// Size: 0x74
function set_val(str_flag, b_val) {
    assert(isdefined(b_val), "<dev string:x92>");
    if (b_val) {
        set(str_flag);
        return;
    }
    clear(str_flag);
}

// Namespace flag
// Params 2, eflags: 0x1 linked
// Checksum 0x8d443d9, Offset: 0x3d0
// Size: 0x6c
function set_for_time(n_time, str_flag) {
    self notify("__flag::set_for_time__" + str_flag);
    self endon("__flag::set_for_time__" + str_flag);
    set(str_flag);
    wait n_time;
    clear(str_flag);
}

// Namespace flag
// Params 1, eflags: 0x1 linked
// Checksum 0x1c0c5805, Offset: 0x448
// Size: 0x8c
function clear(str_flag) {
    assert(exists(str_flag), "<dev string:xbe>" + str_flag + "<dev string:x78>");
    if (self.flag[str_flag]) {
        self.flag[str_flag] = 0;
        self notify(str_flag);
        trigger::set_flag_permissions(str_flag);
    }
}

// Namespace flag
// Params 1, eflags: 0x1 linked
// Checksum 0xff17cde4, Offset: 0x4e0
// Size: 0x54
function toggle(str_flag) {
    if (get(str_flag)) {
        clear(str_flag);
        return;
    }
    set(str_flag);
}

// Namespace flag
// Params 1, eflags: 0x1 linked
// Checksum 0xcd6a653a, Offset: 0x540
// Size: 0x58
function get(str_flag) {
    assert(exists(str_flag), "<dev string:xdb>" + str_flag + "<dev string:x78>");
    return self.flag[str_flag];
}

// Namespace flag
// Params 1, eflags: 0x1 linked
// Checksum 0xb956e6ef, Offset: 0x5a0
// Size: 0x9c
function get_any(&array) {
    foreach (str_flag in array) {
        if (get(str_flag)) {
            return true;
        }
    }
    return false;
}

// Namespace flag
// Params 1, eflags: 0x1 linked
// Checksum 0x9c60c397, Offset: 0x648
// Size: 0x3c
function wait_till(str_flag) {
    self endon(#"death");
    while (!get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flag
// Params 2, eflags: 0x1 linked
// Checksum 0x670cd85a, Offset: 0x690
// Size: 0x84
function wait_till_timeout(n_timeout, str_flag) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till(str_flag);
}

// Namespace flag
// Params 1, eflags: 0x1 linked
// Checksum 0x8b83ec54, Offset: 0x720
// Size: 0x84
function wait_till_all(a_flags) {
    self endon(#"death");
    for (i = 0; i < a_flags.size; i++) {
        str_flag = a_flags[i];
        if (!get(str_flag)) {
            self waittill(str_flag);
            i = -1;
        }
    }
}

// Namespace flag
// Params 2, eflags: 0x0
// Checksum 0x9099fb24, Offset: 0x7b0
// Size: 0x84
function wait_till_all_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_all(a_flags);
}

// Namespace flag
// Params 1, eflags: 0x1 linked
// Checksum 0xf22a5af4, Offset: 0x840
// Size: 0xbc
function wait_till_any(a_flags) {
    self endon(#"death");
    foreach (flag in a_flags) {
        if (get(flag)) {
            return flag;
        }
    }
    util::function_c7f20692(a_flags);
}

// Namespace flag
// Params 2, eflags: 0x1 linked
// Checksum 0x5a0b8ba7, Offset: 0x908
// Size: 0x84
function wait_till_any_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_any(a_flags);
}

// Namespace flag
// Params 1, eflags: 0x1 linked
// Checksum 0xdd403661, Offset: 0x998
// Size: 0x3c
function wait_till_clear(str_flag) {
    self endon(#"death");
    while (get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flag
// Params 2, eflags: 0x1 linked
// Checksum 0x5c0b5b60, Offset: 0x9e0
// Size: 0x84
function wait_till_clear_timeout(n_timeout, str_flag) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear(str_flag);
}

// Namespace flag
// Params 1, eflags: 0x1 linked
// Checksum 0xf8cb7874, Offset: 0xa70
// Size: 0x84
function wait_till_clear_all(a_flags) {
    self endon(#"death");
    for (i = 0; i < a_flags.size; i++) {
        str_flag = a_flags[i];
        if (get(str_flag)) {
            self waittill(str_flag);
            i = -1;
        }
    }
}

// Namespace flag
// Params 2, eflags: 0x0
// Checksum 0x96b22658, Offset: 0xb00
// Size: 0x84
function wait_till_clear_all_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear_all(a_flags);
}

// Namespace flag
// Params 1, eflags: 0x1 linked
// Checksum 0x2d75f0a3, Offset: 0xb90
// Size: 0xc8
function wait_till_clear_any(a_flags) {
    self endon(#"death");
    while (true) {
        foreach (flag in a_flags) {
            if (!get(flag)) {
                return flag;
            }
        }
        util::function_c7f20692(a_flags);
    }
}

// Namespace flag
// Params 2, eflags: 0x1 linked
// Checksum 0xf6d4d6b1, Offset: 0xc60
// Size: 0x84
function wait_till_clear_any_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear_any(a_flags);
}

// Namespace flag
// Params 1, eflags: 0x1 linked
// Checksum 0xd99b4579, Offset: 0xcf0
// Size: 0x54
function delete(str_flag) {
    if (isdefined(self.flag[str_flag])) {
        self.flag[str_flag] = undefined;
        return;
    }
    println("<dev string:xef>" + str_flag);
}

// Namespace flag
// Params 0, eflags: 0x1 linked
// Checksum 0x3014e84, Offset: 0xd50
// Size: 0x34
function script_flag_wait() {
    if (isdefined(self.script_flag_wait)) {
        self wait_till(self.script_flag_wait);
        return true;
    }
    return false;
}

