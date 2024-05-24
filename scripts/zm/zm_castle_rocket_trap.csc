#using scripts/shared/audio_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_ee5f5b26;

// Namespace namespace_ee5f5b26
// Params 0, eflags: 0x0
// Checksum 0x102861ed, Offset: 0x270
// Size: 0x14
function main() {
    register_clientfields();
}

// Namespace namespace_ee5f5b26
// Params 0, eflags: 0x0
// Checksum 0x5f7bc4b5, Offset: 0x290
// Size: 0x124
function register_clientfields() {
    clientfield::register("world", "rocket_trap_warning_smoke", 1, 1, "int", &function_9fc6fce2, 0, 0);
    clientfield::register("world", "rocket_trap_warning_fire", 1, 1, "int", &function_455f796b, 0, 0);
    clientfield::register("world", "sndRocketAlarm", 5000, 2, "int", &function_b50ae7c1, 0, 0);
    clientfield::register("world", "sndRocketTrap", 5000, 3, "int", &function_f38bdbaf, 0, 0);
}

// Namespace namespace_ee5f5b26
// Params 7, eflags: 0x0
// Checksum 0xbc4e0b2e, Offset: 0x3c0
// Size: 0x1be
function function_9fc6fce2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_52d911b7 = struct::get("rocket_trap_warning_smoke", "targetname");
    v_forward = anglestoforward(var_52d911b7.angles);
    v_up = anglestoup(var_52d911b7.angles);
    if (isdefined(var_52d911b7.var_e709b4fd)) {
        for (j = 0; j < var_52d911b7.var_e709b4fd.size; j++) {
            deletefx(localclientnum, var_52d911b7.var_e709b4fd[j], 0);
        }
        var_52d911b7.var_e709b4fd = [];
    }
    if (newval) {
        if (!isdefined(var_52d911b7.var_e709b4fd)) {
            var_52d911b7.var_e709b4fd = [];
        }
        var_52d911b7.var_e709b4fd[localclientnum] = playfx(localclientnum, level._effect["rocket_warning_smoke"], var_52d911b7.origin, v_forward, v_up, 0);
    }
}

// Namespace namespace_ee5f5b26
// Params 7, eflags: 0x0
// Checksum 0x3d4737cd, Offset: 0x588
// Size: 0x1dc
function function_455f796b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_52d911b7 = struct::get("rocket_trap_warning_fire", "targetname");
    v_forward = anglestoforward(var_52d911b7.angles);
    v_up = anglestoup(var_52d911b7.angles);
    if (isdefined(var_52d911b7.var_e709b4fd)) {
        for (j = 0; j < var_52d911b7.var_e709b4fd.size; j++) {
            deletefx(localclientnum, var_52d911b7.var_e709b4fd[j], 0);
        }
        var_52d911b7.var_e709b4fd = [];
    }
    if (newval) {
        if (!isdefined(var_52d911b7.var_e709b4fd)) {
            var_52d911b7.var_e709b4fd = [];
        }
        var_52d911b7.var_e709b4fd[localclientnum] = playfx(localclientnum, level._effect["rocket_warning_fire"], var_52d911b7.origin, v_forward, v_up, 0);
        return;
    }
    function_bdb5a3e2(localclientnum);
}

// Namespace namespace_ee5f5b26
// Params 1, eflags: 0x0
// Checksum 0xfe04f401, Offset: 0x770
// Size: 0x1bc
function function_bdb5a3e2(localclientnum) {
    var_52d911b7 = struct::get("rocket_trap_blast", "targetname");
    v_forward = anglestoforward(var_52d911b7.angles);
    v_up = anglestoup(var_52d911b7.angles);
    n_fx_id = playfx(localclientnum, level._effect["rocket_side_blast"], var_52d911b7.origin, v_forward, v_up, 0);
    wait(0.4);
    var_a62b9cd7 = struct::get_array("rocket_trap_side_blast", "targetname");
    foreach (var_b25c0a2d in var_a62b9cd7) {
        var_b25c0a2d thread function_c1e8be(localclientnum);
    }
    wait(20);
    deletefx(localclientnum, n_fx_id, 0);
}

// Namespace namespace_ee5f5b26
// Params 1, eflags: 0x0
// Checksum 0xfa2d34a0, Offset: 0x938
// Size: 0xdc
function function_c1e8be(localclientnum) {
    v_forward = anglestoforward(self.angles);
    v_up = anglestoup(self.angles);
    wait(randomfloatrange(0, 1));
    n_id = playfx(localclientnum, level._effect["rocket_side_blast"], self.origin, v_forward, v_up, 0);
    wait(20);
    deletefx(localclientnum, n_id, 0);
}

// Namespace namespace_ee5f5b26
// Params 7, eflags: 0x0
// Checksum 0xbea0761d, Offset: 0xa20
// Size: 0x104
function function_b50ae7c1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (newval == 1) {
            audio::playloopat("evt_rocket_trap_alarm", (4202, -2096, -1438));
            audio::playloopat("evt_rocket_trap_alarm_dist", (4202, -2096, -1437));
        }
        if (newval == 2) {
            audio::stoploopat("evt_rocket_trap_alarm", (4202, -2096, -1438));
            audio::stoploopat("evt_rocket_trap_alarm_dist", (4202, -2096, -1437));
        }
    }
}

// Namespace namespace_ee5f5b26
// Params 7, eflags: 0x0
// Checksum 0x65b9e015, Offset: 0xb30
// Size: 0x1e4
function function_f38bdbaf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_dc3c5ca7 = (4202, -2249, -2127);
    if (newval) {
        if (newval == 1) {
            audio::playloopat("evt_rocket_trap_smoke", var_dc3c5ca7);
        }
        if (newval == 2) {
            audio::stoploopat("evt_rocket_trap_smoke", var_dc3c5ca7);
            audio::playloopat("evt_rocket_trap_ignite", var_dc3c5ca7);
            playsound(0, "evt_rocket_trap_ignite_one_shot", var_dc3c5ca7);
        }
        if (newval == 3) {
            audio::stoploopat("evt_rocket_trap_ignite", var_dc3c5ca7);
            audio::playloopat("evt_rocket_trap_burn", var_dc3c5ca7);
            playsound(0, "evt_rocket_trap_burn_one_shot", var_dc3c5ca7);
            audio::playloopat("evt_rocket_trap_burn_dist", var_dc3c5ca7 + (0, 0, 1000));
        }
        if (newval == 4) {
            audio::stoploopat("evt_rocket_trap_burn", var_dc3c5ca7);
            audio::stoploopat("evt_rocket_trap_burn_dist", var_dc3c5ca7 + (0, 0, 1000));
        }
    }
}

