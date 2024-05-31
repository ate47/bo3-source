#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_96203a67;

// Namespace namespace_96203a67
// Params 0, eflags: 0x2
// namespace_96203a67<file_0>::function_2dc19561
// Checksum 0xa7481c0e, Offset: 0x160
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_trap_fire", &__init__, undefined, undefined);
}

// Namespace namespace_96203a67
// Params 0, eflags: 0x1 linked
// namespace_96203a67<file_0>::function_8c87d8eb
// Checksum 0xd5e3e2a7, Offset: 0x1a0
// Size: 0xe2
function __init__() {
    a_traps = struct::get_array("trap_fire", "targetname");
    foreach (trap in a_traps) {
        clientfield::register("world", trap.script_noteworthy, 21000, 1, "int", &trap_fx_monitor, 0, 0);
    }
}

// Namespace namespace_96203a67
// Params 7, eflags: 0x1 linked
// namespace_96203a67<file_0>::function_9b0b8f8e
// Checksum 0x92b72f08, Offset: 0x290
// Size: 0x172
function trap_fx_monitor(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    exploder_name = "trap_fire_" + fieldname;
    if (newval) {
        exploder::exploder(exploder_name);
    } else {
        exploder::stop_exploder(exploder_name);
    }
    var_b0b39f79 = struct::get_array(fieldname, "targetname");
    foreach (point in var_b0b39f79) {
        if (!isdefined(point.script_noteworthy)) {
            if (newval) {
                point thread asset_pool_scriptbundlelist();
                continue;
            }
            point thread function_dc960b46();
        }
    }
}

// Namespace namespace_96203a67
// Params 0, eflags: 0x1 linked
// namespace_96203a67<file_0>::function_a7c75d32
// Checksum 0xd5b0be98, Offset: 0x410
// Size: 0x12c
function asset_pool_scriptbundlelist() {
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
        self.loopfx[i] = playfx(i, level._effect["fire_trap"], self.origin, forward, up, 0);
    }
}

// Namespace namespace_96203a67
// Params 0, eflags: 0x1 linked
// namespace_96203a67<file_0>::function_dc960b46
// Checksum 0x1d332b26, Offset: 0x548
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

