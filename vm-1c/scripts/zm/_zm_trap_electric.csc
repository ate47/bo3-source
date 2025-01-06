#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace zm_trap_electric;

// Namespace zm_trap_electric
// Params 0, eflags: 0x2
// Checksum 0x1c36e2a2, Offset: 0x170
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_trap_electric", &__init__, undefined, undefined);
}

// Namespace zm_trap_electric
// Params 0, eflags: 0x0
// Checksum 0x1b722f94, Offset: 0x1b0
// Size: 0x10a
function __init__() {
    visionset_mgr::register_overlay_info_style_electrified("zm_trap_electric", 1, 15, 1.25);
    a_traps = struct::get_array("trap_electric", "targetname");
    foreach (trap in a_traps) {
        clientfield::register("world", trap.script_noteworthy, 1, 1, "int", &trap_fx_monitor, 0, 0);
    }
}

// Namespace zm_trap_electric
// Params 7, eflags: 0x0
// Checksum 0x38308540, Offset: 0x2c8
// Size: 0x172
function trap_fx_monitor(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    exploder_name = "trap_electric_" + fieldname;
    if (newval) {
        exploder::exploder(exploder_name);
    } else {
        exploder::stop_exploder(exploder_name);
    }
    var_b0b39f79 = struct::get_array(fieldname, "targetname");
    foreach (point in var_b0b39f79) {
        if (!isdefined(point.script_noteworthy)) {
            if (newval) {
                point thread function_1fc3f4ef();
                continue;
            }
            point thread function_dc960b46();
        }
    }
}

// Namespace zm_trap_electric
// Params 0, eflags: 0x0
// Checksum 0x5fb48458, Offset: 0x448
// Size: 0x12c
function function_1fc3f4ef() {
    ang = self.angles;
    forward = anglestoforward(ang);
    up = anglestoup(ang);
    if (isdefined(self.loopfx) && self.loopfx.size) {
        function_dc960b46();
    }
    if (!isdefined(self.loopfx)) {
        self.loopfx = [];
    }
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        self.loopfx[i] = playfx(i, level._effect["zapper"], self.origin, forward, up, 0);
    }
}

// Namespace zm_trap_electric
// Params 0, eflags: 0x0
// Checksum 0xaaa25249, Offset: 0x580
// Size: 0x88
function function_dc960b46() {
    players = getlocalplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(self.loopfx[i])) {
            stopfx(i, self.loopfx[i]);
        }
    }
    self.loopfx = [];
}

