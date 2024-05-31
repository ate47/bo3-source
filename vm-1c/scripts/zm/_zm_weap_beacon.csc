#using scripts/shared/clientfield_shared;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/codescripts/struct;

#namespace namespace_ba8619ac;

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_c35e6aab
// Checksum 0x6fcd52f9, Offset: 0x358
// Size: 0x204
function init() {
    level.w_beacon = getweapon("beacon");
    level.var_67735adb = "wpn_t7_zmb_hd_g_strike_world";
    level._effect["beacon_glow"] = "dlc5/tomb/fx_tomb_beacon_glow";
    level._effect["beacon_launch_fx"] = "dlc5/tomb/fx_tomb_beacon_launch";
    level._effect["beacon_shell_explosion"] = "dlc5/tomb/fx_tomb_beacon_exp";
    level._effect["beacon_shell_trail"] = "dlc5/tomb/fx_tomb_beacon_trail";
    clientfield::register("world", "play_launch_artillery_fx_robot_0", 21000, 1, "int", &function_59491961, 0, 0);
    clientfield::register("world", "play_launch_artillery_fx_robot_1", 21000, 1, "int", &function_59491961, 0, 0);
    clientfield::register("world", "play_launch_artillery_fx_robot_2", 21000, 1, "int", &function_59491961, 0, 0);
    clientfield::register("scriptmover", "play_beacon_fx", 21000, 1, "int", &function_dc4ed336, 0, 0);
    clientfield::register("scriptmover", "play_artillery_barrage", 21000, 2, "int", &function_1e3322d1, 0, 0);
}

// Namespace namespace_ba8619ac
// Params 7, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_59491961
// Checksum 0x2310849f, Offset: 0x568
// Size: 0x154
function function_59491961(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (issubstr(fieldname, 0)) {
        var_f6c5842 = level.var_64f7be48[localclientnum][0];
    } else if (issubstr(fieldname, 1)) {
        var_f6c5842 = level.var_64f7be48[localclientnum][1];
    } else {
        var_f6c5842 = level.var_64f7be48[localclientnum][2];
    }
    if (newval == 1) {
        playfx(localclientnum, level._effect["beacon_launch_fx"], var_f6c5842 gettagorigin("tag_rocketpod"));
        level thread function_d391c94e(var_f6c5842 gettagorigin("tag_rocketpod"));
    }
}

// Namespace namespace_ba8619ac
// Params 1, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_d391c94e
// Checksum 0xac61e5ef, Offset: 0x6c8
// Size: 0x7e
function function_d391c94e(origin) {
    playsound(0, "zmb_homingbeacon_missiile_alarm", origin);
    for (i = 0; i < 5; i++) {
        playsound(0, "zmb_homingbeacon_missile_fire", origin);
        wait(0.15);
    }
}

// Namespace namespace_ba8619ac
// Params 7, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_dc4ed336
// Checksum 0x59668049, Offset: 0x750
// Size: 0xb0
function function_dc4ed336(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"hash_962e0148");
    while (isdefined(self)) {
        playsound(0, "evt_beacon_beep", self.origin);
        playfxontag(localclientnum, level._effect["beacon_glow"], self, "origin_animate_jnt");
        wait(1.5);
    }
}

// Namespace namespace_ba8619ac
// Params 7, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_1e3322d1
// Checksum 0x58bce7c3, Offset: 0x808
// Size: 0x2ba
function function_1e3322d1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 0) {
        return;
    }
    if (newval == 1) {
        if (!isdefined(self.var_6357a0d6)) {
            self.var_6357a0d6 = [];
        }
        if (!isdefined(self.var_6357a0d6[localclientnum])) {
            self.var_6357a0d6[localclientnum] = self function_2978ee2d();
        }
        if (!isdefined(self.var_14202479)) {
            self.var_14202479 = [];
        }
        if (!isdefined(self.var_14202479[localclientnum])) {
            self.var_14202479[localclientnum] = self function_14e104a0();
        }
    }
    if (newval == 2) {
        if (!isdefined(self.var_6357a0d6)) {
            self.var_6357a0d6 = [];
        }
        if (!isdefined(self.var_6357a0d6[localclientnum])) {
            self.var_6357a0d6[localclientnum] = self function_8752cc8a();
        }
        if (!isdefined(self.var_14202479)) {
            self.var_14202479 = [];
        }
        if (!isdefined(self.var_14202479[localclientnum])) {
            self.var_14202479[localclientnum] = self function_a6461985();
        }
    }
    if (!isdefined(self.var_f510f618)) {
        self.var_f510f618 = [];
    }
    if (!isdefined(self.var_f510f618[localclientnum])) {
        self.var_f510f618[localclientnum] = 0;
    }
    n_index = self.var_f510f618[localclientnum];
    v_start = self.origin + self.var_14202479[localclientnum][n_index];
    shell = spawn(localclientnum, v_start, "script_model");
    shell.angles = (-90, 0, 0);
    shell setmodel("tag_origin");
    shell thread function_3700164e(self, n_index, v_start, localclientnum);
    self.var_f510f618[localclientnum]++;
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_2978ee2d
// Checksum 0x6319ac46, Offset: 0xad0
// Size: 0x88
function function_2978ee2d() {
    var_a6604bff = [];
    var_a6604bff[0] = (0, 0, 0);
    var_a6604bff[1] = (-72, 72, 0);
    var_a6604bff[2] = (72, 72, 0);
    var_a6604bff[3] = (72, -72, 0);
    var_a6604bff[4] = (-72, -72, 0);
    return var_a6604bff;
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_14e104a0
// Checksum 0x2d221072, Offset: 0xb60
// Size: 0x96
function function_14e104a0() {
    var_a6604bff = [];
    var_a6604bff[0] = (0, 0, 8500);
    var_a6604bff[1] = (-6500, 6500, 8500);
    var_a6604bff[2] = (6500, 6500, 8500);
    var_a6604bff[3] = (6500, -6500, 8500);
    var_a6604bff[4] = (-6500, -6500, 8500);
    return var_a6604bff;
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_8752cc8a
// Checksum 0x9c82acc5, Offset: 0xc00
// Size: 0x178
function function_8752cc8a() {
    var_a6604bff = [];
    var_a6604bff[0] = (0, 0, 0);
    var_a6604bff[1] = (-72, 72, 0);
    var_a6604bff[2] = (72, 72, 0);
    var_a6604bff[3] = (72, -72, 0);
    var_a6604bff[4] = (-72, -72, 0);
    var_a6604bff[5] = (-72, 72, 0);
    var_a6604bff[6] = (72, 72, 0);
    var_a6604bff[7] = (72, -72, 0);
    var_a6604bff[8] = (-72, -72, 0);
    var_a6604bff[9] = (-72, 72, 0);
    var_a6604bff[10] = (72, 72, 0);
    var_a6604bff[11] = (72, -72, 0);
    var_a6604bff[12] = (-72, -72, 0);
    var_a6604bff[13] = (-72, 72, 0);
    var_a6604bff[14] = (72, 72, 0);
    return var_a6604bff;
}

// Namespace namespace_ba8619ac
// Params 0, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_a6461985
// Checksum 0xf9455fbb, Offset: 0xd80
// Size: 0x19a
function function_a6461985() {
    var_a6604bff = [];
    var_a6604bff[0] = (0, 0, 8500);
    var_a6604bff[1] = (-6500, 6500, 8500);
    var_a6604bff[2] = (6500, 6500, 8500);
    var_a6604bff[3] = (6500, -6500, 8500);
    var_a6604bff[4] = (-6500, -6500, 8500);
    var_a6604bff[5] = (-6500, 6500, 8500);
    var_a6604bff[6] = (6500, 6500, 8500);
    var_a6604bff[7] = (6500, -6500, 8500);
    var_a6604bff[8] = (-6500, -6500, 8500);
    var_a6604bff[9] = (-6500, 6500, 8500);
    var_a6604bff[10] = (6500, 6500, 8500);
    var_a6604bff[11] = (6500, -6500, 8500);
    var_a6604bff[12] = (-6500, -6500, 8500);
    var_a6604bff[13] = (-6500, 6500, 8500);
    var_a6604bff[14] = (6500, 6500, 8500);
    return var_a6604bff;
}

// Namespace namespace_ba8619ac
// Params 4, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_3700164e
// Checksum 0xa062f7ea, Offset: 0xf28
// Size: 0x1d4
function function_3700164e(model, index, v_start, localclientnum) {
    v_land = model.origin + model.var_6357a0d6[localclientnum][index];
    var_671ea392 = v_start - (0, 0, 5000);
    trace = bullettrace(var_671ea392, v_land, 0, undefined);
    v_land = trace["position"];
    self moveto(v_land, 3);
    playfxontag(localclientnum, level._effect["beacon_shell_trail"], self, "tag_origin");
    self playsound(0, "zmb_homingbeacon_missile_boom");
    self thread function_42cb41ec(v_land);
    self waittill(#"movedone");
    if (index == 1) {
        model notify(#"hash_962e0148");
    }
    playfx(localclientnum, level._effect["beacon_shell_explosion"], self.origin);
    playsound(0, "wpn_rocket_explode", self.origin);
    self delete();
}

// Namespace namespace_ba8619ac
// Params 1, eflags: 0x1 linked
// namespace_ba8619ac<file_0>::function_42cb41ec
// Checksum 0xc674da7, Offset: 0x1108
// Size: 0x34
function function_42cb41ec(origin) {
    wait(2);
    playsound(0, "zmb_homingbeacon_missile_incoming", origin);
}

