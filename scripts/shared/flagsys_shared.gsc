#using scripts/shared/util_shared;

#namespace flagsys;

// Namespace flagsys
// Params 1, eflags: 0x1 linked
// Checksum 0xeab4858e, Offset: 0xb0
// Size: 0x40
function set(str_flag) {
    if (!isdefined(self.flag)) {
        self.flag = [];
    }
    self.flag[str_flag] = 1;
    self notify(str_flag);
}

// Namespace flagsys
// Params 2, eflags: 0x0
// Checksum 0x5ac33aee, Offset: 0xf8
// Size: 0x6c
function set_for_time(n_time, str_flag) {
    self notify("__flag::set_for_time__" + str_flag);
    self endon("__flag::set_for_time__" + str_flag);
    set(str_flag);
    wait(n_time);
    clear(str_flag);
}

// Namespace flagsys
// Params 1, eflags: 0x1 linked
// Checksum 0x10582181, Offset: 0x170
// Size: 0x52
function clear(str_flag) {
    if (isdefined(self.flag[str_flag]) && isdefined(self.flag) && self.flag[str_flag]) {
        self.flag[str_flag] = undefined;
        self notify(str_flag);
    }
}

// Namespace flagsys
// Params 2, eflags: 0x1 linked
// Checksum 0xbdc3b18b, Offset: 0x1d0
// Size: 0x74
function set_val(str_flag, b_val) {
    /#
        assert(isdefined(b_val), "<unknown string>");
    #/
    if (b_val) {
        set(str_flag);
        return;
    }
    clear(str_flag);
}

// Namespace flagsys
// Params 1, eflags: 0x0
// Checksum 0x310554ee, Offset: 0x250
// Size: 0x34
function toggle(str_flag) {
    set(!get(str_flag));
}

// Namespace flagsys
// Params 1, eflags: 0x1 linked
// Checksum 0x3d973e8, Offset: 0x290
// Size: 0x38
function get(str_flag) {
    return isdefined(self.flag[str_flag]) && isdefined(self.flag) && self.flag[str_flag];
}

// Namespace flagsys
// Params 1, eflags: 0x1 linked
// Checksum 0x3fd209fc, Offset: 0x2d0
// Size: 0x3c
function wait_till(str_flag) {
    self endon(#"death");
    while (!get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flagsys
// Params 2, eflags: 0x0
// Checksum 0x380e9abd, Offset: 0x318
// Size: 0x84
function wait_till_timeout(n_timeout, str_flag) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till(str_flag);
}

// Namespace flagsys
// Params 1, eflags: 0x1 linked
// Checksum 0xe21d243e, Offset: 0x3a8
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

// Namespace flagsys
// Params 2, eflags: 0x0
// Checksum 0xf015659d, Offset: 0x438
// Size: 0x84
function wait_till_all_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_all(a_flags);
}

// Namespace flagsys
// Params 1, eflags: 0x1 linked
// Checksum 0xf74a662d, Offset: 0x4c8
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

// Namespace flagsys
// Params 2, eflags: 0x0
// Checksum 0xe6513c0e, Offset: 0x590
// Size: 0x84
function wait_till_any_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_any(a_flags);
}

// Namespace flagsys
// Params 1, eflags: 0x1 linked
// Checksum 0xd747c3a8, Offset: 0x620
// Size: 0x3c
function wait_till_clear(str_flag) {
    self endon(#"death");
    while (get(str_flag)) {
        self waittill(str_flag);
    }
}

// Namespace flagsys
// Params 2, eflags: 0x0
// Checksum 0x485c766d, Offset: 0x668
// Size: 0x84
function wait_till_clear_timeout(n_timeout, str_flag) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear(str_flag);
}

// Namespace flagsys
// Params 1, eflags: 0x1 linked
// Checksum 0xd63e1c11, Offset: 0x6f8
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

// Namespace flagsys
// Params 2, eflags: 0x0
// Checksum 0xee9b0012, Offset: 0x788
// Size: 0x84
function wait_till_clear_all_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear_all(a_flags);
}

// Namespace flagsys
// Params 1, eflags: 0x1 linked
// Checksum 0x56a435d8, Offset: 0x818
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

// Namespace flagsys
// Params 2, eflags: 0x0
// Checksum 0x34535b6b, Offset: 0x8e8
// Size: 0x84
function wait_till_clear_any_timeout(n_timeout, a_flags) {
    if (isdefined(n_timeout)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(n_timeout, "timeout");
    }
    wait_till_clear_any(a_flags);
}

// Namespace flagsys
// Params 1, eflags: 0x0
// Checksum 0x1254a035, Offset: 0x978
// Size: 0x24
function delete(str_flag) {
    clear(str_flag);
}

// Namespace flagsys
// Params 0, eflags: 0x0
// Checksum 0x30c6b159, Offset: 0x9a8
// Size: 0x34
function script_flag_wait() {
    if (isdefined(self.script_flag_wait)) {
        self wait_till(self.script_flag_wait);
        return true;
    }
    return false;
}

