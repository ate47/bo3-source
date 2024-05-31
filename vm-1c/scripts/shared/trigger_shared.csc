#namespace trigger;

// Namespace trigger
// Params 3, eflags: 0x1 linked
// Checksum 0x369ef334, Offset: 0x78
// Size: 0xfc
function function_thread(ent, on_enter_payload, on_exit_payload) {
    ent endon(#"entityshutdown");
    if (ent ent_already_in(self)) {
        return;
    }
    add_to_ent(ent, self);
    if (isdefined(on_enter_payload)) {
        [[ on_enter_payload ]](ent);
    }
    while (isdefined(ent) && ent istouching(self)) {
        wait(0.016);
    }
    if (isdefined(ent) && isdefined(on_exit_payload)) {
        [[ on_exit_payload ]](ent);
    }
    if (isdefined(ent)) {
        remove_from_ent(ent, self);
    }
}

// Namespace trigger
// Params 1, eflags: 0x1 linked
// Checksum 0xeaf7149e, Offset: 0x180
// Size: 0x70
function ent_already_in(trig) {
    if (!isdefined(self._triggers)) {
        return false;
    }
    if (!isdefined(self._triggers[trig getentitynumber()])) {
        return false;
    }
    if (!self._triggers[trig getentitynumber()]) {
        return false;
    }
    return true;
}

// Namespace trigger
// Params 2, eflags: 0x1 linked
// Checksum 0x196bfb39, Offset: 0x1f8
// Size: 0x62
function add_to_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        ent._triggers = [];
    }
    ent._triggers[trig getentitynumber()] = 1;
}

// Namespace trigger
// Params 2, eflags: 0x1 linked
// Checksum 0x9138aded, Offset: 0x268
// Size: 0x82
function remove_from_ent(ent, trig) {
    if (!isdefined(ent._triggers)) {
        return;
    }
    if (!isdefined(ent._triggers[trig getentitynumber()])) {
        return;
    }
    ent._triggers[trig getentitynumber()] = 0;
}

// Namespace trigger
// Params 2, eflags: 0x0
// Checksum 0xfd01048d, Offset: 0x2f8
// Size: 0x44
function death_monitor(ent, ender) {
    ent waittill(#"death");
    self endon(ender);
    self remove_from_ent(ent);
}

