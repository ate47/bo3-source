#using scripts/codescripts/struct;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace mapping_drone;

// Namespace mapping_drone
// Params 2, eflags: 0x0
// Checksum 0xfea59928, Offset: 0x248
// Size: 0x180
function spawn_drone(var_cc525a1a, b_active) {
    if (!isdefined(b_active)) {
        b_active = 1;
    }
    level.var_ea764859 = vehicle::simple_spawn_single("mapping_drone");
    level.var_ea764859.animname = "mapping_drone";
    level.var_ea764859 setcandamage(0);
    level.var_ea764859 notsolid();
    level.var_ea764859 sethoverparams(20, 5, 10);
    level.var_ea764859.drivepath = 1;
    if (!b_active) {
        level.var_ea764859 vehicle::lights_off();
        level.var_ea764859 vehicle::toggle_sounds(0);
    }
    if (isdefined(var_cc525a1a)) {
        nd_start = getvehiclenode(var_cc525a1a, "targetname");
        level.var_ea764859.origin = nd_start.origin;
        level.var_ea764859.angles = nd_start.angles;
    }
}

// Namespace mapping_drone
// Params 3, eflags: 0x0
// Checksum 0x218d5d8c, Offset: 0x3d0
// Size: 0x104
function follow_path(var_cc525a1a, str_flag, var_178571be) {
    if (isdefined(str_flag) && !level flag::get(str_flag)) {
        nd_start = getvehiclenode(var_cc525a1a, "targetname");
        self setvehgoalpos(nd_start.origin, 1);
        level flag::wait_till(str_flag);
        self clearvehgoalpos();
    }
    if (isdefined(var_178571be)) {
        self thread [[ var_178571be ]]();
    }
    self thread function_fb6d201d();
    self vehicle::get_on_and_go_path(var_cc525a1a);
}

// Namespace mapping_drone
// Params 1, eflags: 0x0
// Checksum 0x9c0e144f, Offset: 0x4e0
// Size: 0x3c
function function_6a8adcf6(n_speed) {
    self.var_764bad40 = n_speed;
    self setspeed(self.var_764bad40, 35, 35);
}

// Namespace mapping_drone
// Params 0, eflags: 0x0
// Checksum 0x162d9e4c, Offset: 0x528
// Size: 0xe
function function_2dde6e87() {
    self.var_764bad40 = undefined;
}

// Namespace mapping_drone
// Params 1, eflags: 0x0
// Checksum 0xead26998, Offset: 0x540
// Size: 0x54
function function_74191a2(b_stealth) {
    if (!isdefined(b_stealth)) {
        b_stealth = 1;
    }
    if (b_stealth) {
        self vehicle::lights_off();
        return;
    }
    self vehicle::lights_on();
}

// Namespace mapping_drone
// Params 0, eflags: 0x0
// Checksum 0x6a7a756c, Offset: 0x5a0
// Size: 0x468
function function_fb6d201d() {
    self endon(#"hash_c4902f95");
    self endon(#"reached_end_node");
    var_c119f9f1 = cos(89);
    /#
        self thread function_3c36d48d();
    #/
    self.n_speed = 0;
    while (true) {
        if (isdefined(self.var_764bad40)) {
            self.n_speed = self.var_764bad40;
            self setspeed(self.var_764bad40, 35, 35);
            wait 0.05;
            continue;
        }
        var_11d57f72 = 10000;
        var_1d0de873 = 9000000;
        var_60a5e1bc = 0;
        var_a8dc514 = 0;
        b_wait_for_player = 0;
        foreach (player in level.players) {
            if (!isalive(player)) {
                continue;
            }
            var_b55746b1 = player.origin[2] + 72 - self.origin[2];
            n_dist_sq = distancesquared(player.origin, self.origin);
            if (var_b55746b1 < var_11d57f72) {
                var_11d57f72 = var_b55746b1;
            }
            if (n_dist_sq < var_1d0de873) {
                var_1d0de873 = n_dist_sq;
            }
            if (var_11d57f72 < -104 * -1) {
                var_a8dc514 = 1;
                continue;
            }
            if (abs(var_b55746b1) < 96) {
                if (util::within_fov(self.origin, self.angles, player.origin, var_c119f9f1)) {
                    var_60a5e1bc = 1;
                }
            }
        }
        if (!var_a8dc514 && !var_60a5e1bc && var_1d0de873 > 2250000) {
            b_wait_for_player = 1;
        }
        if (!b_wait_for_player) {
            if (var_a8dc514) {
                self.n_speed = 35;
            } else if (var_1d0de873 <= 562500 || var_60a5e1bc) {
                self.n_speed = 25;
            } else {
                self.n_speed = 5;
            }
            if (level flag::get("drone_scanning")) {
                self vehicle::resume_path();
                level flag::clear("drone_scanning");
            }
        } else {
            self.n_speed = 0;
            self vehicle::pause_path();
            if (!level flag::get("drone_scanning")) {
                self thread function_517ced56(60, 90, 15, 50);
            }
        }
        self setspeed(self.n_speed, 35, 35);
        wait 0.05;
    }
}

/#

    // Namespace mapping_drone
    // Params 0, eflags: 0x0
    // Checksum 0xe080b7f1, Offset: 0xa10
    // Size: 0xea
    function function_3c36d48d() {
        self endon(#"hash_c4902f95");
        self endon(#"reached_end_node");
        while (true) {
            wait 1;
            switch (self.n_speed) {
            case 35:
                iprintln("<dev string:x28>");
                break;
            case 25:
                iprintln("<dev string:x3b>");
                break;
            case 5:
                iprintln("<dev string:x4d>");
                break;
            default:
                iprintln("<dev string:x60>");
                break;
            }
        }
    }

#/

// Namespace mapping_drone
// Params 4, eflags: 0x0
// Checksum 0xfe7f8847, Offset: 0xb08
// Size: 0x204
function function_517ced56(var_d3dc91f3, var_c6f8c0e6, var_6813d241, var_2e2d306e) {
    if (!isdefined(var_d3dc91f3)) {
        var_d3dc91f3 = 90;
    }
    if (!isdefined(var_c6f8c0e6)) {
        var_c6f8c0e6 = 90;
    }
    if (!isdefined(var_6813d241)) {
        var_6813d241 = 10;
    }
    if (!isdefined(var_2e2d306e)) {
        var_2e2d306e = 30;
    }
    level flag::set("drone_scanning");
    var_84ced1da = spawn("script_origin", self.origin);
    var_84ced1da.angles = self.angles;
    self linkto(var_84ced1da);
    var_1337ab43 = self.angles;
    while (level flag::get("drone_scanning")) {
        var_5721da1 = (randomfloatrange(var_6813d241 * -1, var_2e2d306e), randomfloatrange(var_d3dc91f3 * -1, var_c6f8c0e6), 0);
        var_e6df4d78 = var_1337ab43 + var_5721da1;
        var_84ced1da rotateto(var_e6df4d78, 0.5, 0.2, 0.2);
        var_84ced1da waittill(#"rotatedone");
        wait randomfloatrange(1, 2);
    }
    var_84ced1da delete();
}

// Namespace mapping_drone
// Params 1, eflags: 0x0
// Checksum 0xcb3fe5e2, Offset: 0xd18
// Size: 0x1bc
function function_4f6daa65(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (b_on) {
        self clientfield::set("extra_cam_ent", 1);
        foreach (player in level.activeplayers) {
            player.var_5b63852a = player openluimenu("drone_pip");
        }
        return;
    }
    foreach (player in level.activeplayers) {
        if (isdefined(player.var_5b63852a)) {
            player thread function_dbc35f5e(player.var_5b63852a, 1.25);
            player.var_5b63852a = undefined;
        }
    }
    self clientfield::set("extra_cam_ent", 0);
}

// Namespace mapping_drone
// Params 2, eflags: 0x4
// Checksum 0x4f0ff879, Offset: 0xee0
// Size: 0x5c
function private function_dbc35f5e(var_c2dc2b72, delay) {
    self setluimenudata(var_c2dc2b72, "close_current_menu", 1);
    wait delay;
    self closeluimenu(var_c2dc2b72);
}

