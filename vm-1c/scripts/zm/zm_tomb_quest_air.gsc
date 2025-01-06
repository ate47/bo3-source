#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_vo;

#namespace zm_tomb_quest_air;

// Namespace zm_tomb_quest_air
// Params 0, eflags: 0x0
// Checksum 0x8a90b643, Offset: 0x348
// Size: 0x1ec
function main() {
    level flag::init("air_puzzle_1_complete");
    level flag::init("air_puzzle_2_complete");
    level flag::init("air_upgrade_available");
    function_97f0d6a7();
    function_4d617b5a();
    zm_tomb_vo::function_446b06b3(2, "vox_sam_wind_puz_solve_1");
    zm_tomb_vo::function_446b06b3(2, "vox_sam_wind_puz_solve_0");
    zm_tomb_vo::function_446b06b3(2, "vox_sam_wind_puz_solve_2");
    level thread zm_tomb_vo::function_d22bb7("puzzle", "try_puzzle", "vo_try_puzzle_air1");
    level thread zm_tomb_vo::function_d22bb7("puzzle", "try_puzzle", "vo_try_puzzle_air2");
    level thread function_fd44e0ac();
    level flag::wait_till("air_puzzle_1_complete");
    playsoundatposition("zmb_squest_step1_finished", (0, 0, 0));
    level thread function_c489b40f();
    level thread zm_tomb_utility::function_d0dc88b2(5, 3);
    level thread function_df52fcab();
}

// Namespace zm_tomb_quest_air
// Params 0, eflags: 0x0
// Checksum 0x16f86a2e, Offset: 0x540
// Size: 0xb2
function function_97f0d6a7() {
    level.var_de988972 = getentarray("ceiling_ring", "script_noteworthy");
    foreach (e_ring in level.var_de988972) {
        e_ring function_ed5a3c20();
    }
}

// Namespace zm_tomb_quest_air
// Params 0, eflags: 0x0
// Checksum 0x9430c1cb, Offset: 0x600
// Size: 0x12e
function function_c489b40f() {
    for (i = 1; i <= 3; i++) {
        n_move = (4 - i) * 20;
        e_ring = getent("ceiling_ring_0" + i, "targetname");
        e_ring rotateyaw(360, 1.5, 0.5, 0);
        e_ring movez(n_move, 1.5, 0.5, 0);
        e_ring playsound("zmb_squest_wind_ring_turn");
        e_ring waittill(#"movedone");
        e_ring playsound("zmb_squest_wind_ring_stop");
    }
}

// Namespace zm_tomb_quest_air
// Params 0, eflags: 0x0
// Checksum 0x66d2ffe0, Offset: 0x738
// Size: 0x2c
function function_fd44e0ac() {
    array::thread_all(level.var_de988972, &function_4dd1fb51);
}

// Namespace zm_tomb_quest_air
// Params 0, eflags: 0x0
// Checksum 0x48475ed5, Offset: 0x770
// Size: 0xaa
function function_54076542() {
    var_5ae7d2a5 = 0;
    foreach (e_ring in level.var_de988972) {
        if (e_ring.script_int != e_ring.position) {
            return false;
        }
    }
    return true;
}

// Namespace zm_tomb_quest_air
// Params 0, eflags: 0x0
// Checksum 0x8a82fef7, Offset: 0x828
// Size: 0x84
function function_d9a378d7() {
    var_d37a39fd = randomintrange(1, 4);
    self.position = (self.script_int + var_d37a39fd) % 4;
    function_4686b585();
    assert(self.position != self.script_int);
}

// Namespace zm_tomb_quest_air
// Params 0, eflags: 0x0
// Checksum 0x3d06eafb, Offset: 0x8b8
// Size: 0xcc
function function_4686b585() {
    new_angles = (self.angles[0], self.position * 90, self.angles[2]);
    self rotateto(new_angles, 0.5, 0.2, 0.2);
    exploder::exploder("fxexp_600");
    self playsound("zmb_squest_wind_ring_turn");
    self waittill(#"rotatedone");
    self playsound("zmb_squest_wind_ring_stop");
}

// Namespace zm_tomb_quest_air
// Params 0, eflags: 0x0
// Checksum 0x172adbb6, Offset: 0x990
// Size: 0xec
function function_e9a8f60b() {
    self.position = (self.position + 1) % 4;
    /#
        if (self.position == self.script_int) {
            iprintlnbold("<dev string:x28>");
        }
    #/
    self function_4686b585();
    solved = function_54076542();
    if (solved && !level flag::get("air_puzzle_1_complete")) {
        self thread zm_tomb_vo::function_2af394fb(2);
        level flag::set("air_puzzle_1_complete");
    }
}

// Namespace zm_tomb_quest_air
// Params 0, eflags: 0x0
// Checksum 0x47058b13, Offset: 0xa88
// Size: 0x10
function function_ed5a3c20() {
    self.position = 0;
}

// Namespace zm_tomb_quest_air
// Params 0, eflags: 0x0
// Checksum 0x6b48f217, Offset: 0xaa0
// Size: 0x346
function function_4dd1fb51() {
    level endon(#"air_puzzle_1_complete");
    self setcandamage(1);
    self.position = 0;
    function_d9a378d7();
    var_5faddb59 = 0;
    var_8218dfc8 = 120 * 120;
    var_ad195647 = -76 * -76;
    var_104a0542 = -16 * -16;
    var_9d64b269 = 300 * 300;
    while (true) {
        self waittill(#"damage", damage, attacker, direction_vec, point, mod, tagname, modelname, partname, weaponname);
        if (weaponname.name == "staff_air") {
            var_a9ffa3fc = 0;
            var_234d771c = distance2dsquared(point, self.origin);
            if (issubstr(self.targetname, "01") && var_234d771c <= var_8218dfc8) {
                var_a9ffa3fc = 1;
            } else if (issubstr(self.targetname, "02") && var_234d771c > var_8218dfc8 && var_234d771c <= var_ad195647) {
                var_a9ffa3fc = 1;
            } else if (issubstr(self.targetname, "03") && var_234d771c > var_ad195647 && var_234d771c <= var_104a0542) {
                var_a9ffa3fc = 1;
            } else if (issubstr(self.targetname, "04") && var_234d771c > var_104a0542 && var_234d771c <= var_9d64b269) {
                var_a9ffa3fc = 1;
            }
            if (var_a9ffa3fc) {
                level notify(#"vo_try_puzzle_air1", attacker);
                self function_e9a8f60b();
                zm_tomb_utility::rumble_nearby_players(self.origin, 1500, 2);
                var_5faddb59++;
                if (var_5faddb59 % 4 == 0) {
                    level notify(#"vo_puzzle_bad", attacker);
                }
            }
            continue;
        }
        level notify(#"vo_puzzle_confused", attacker);
    }
}

// Namespace zm_tomb_quest_air
// Params 0, eflags: 0x0
// Checksum 0x71d7637, Offset: 0xdf0
// Size: 0xea
function function_4d617b5a() {
    var_f66c6353 = struct::get_array("puzzle_smoke_origin", "targetname");
    foreach (var_5fa5bb35 in var_f66c6353) {
        var_5fa5bb35.var_ee718f9a = getent(var_5fa5bb35.target, "targetname");
        var_5fa5bb35.var_ee718f9a ghost();
    }
}

// Namespace zm_tomb_quest_air
// Params 0, eflags: 0x0
// Checksum 0x361044c2, Offset: 0xee8
// Size: 0x294
function function_df52fcab() {
    var_f66c6353 = struct::get_array("puzzle_smoke_origin", "targetname");
    foreach (var_5fa5bb35 in var_f66c6353) {
        var_5fa5bb35 thread air_puzzle_smoke();
    }
    var_3481edfa = level.var_b0d8f1fe["staff_air"].w_weapon;
    while (true) {
        level waittill(#"hash_e9869ec8");
        var_e2061f0c = 1;
        foreach (var_5fa5bb35 in var_f66c6353) {
            if (!var_5fa5bb35.solved) {
                var_e2061f0c = 0;
            }
        }
        if (var_e2061f0c) {
            a_players = getplayers();
            foreach (e_player in a_players) {
                if (e_player hasweapon(var_3481edfa)) {
                    e_player thread zm_tomb_vo::function_2af394fb(2);
                    break;
                }
            }
            level flag::set("air_puzzle_2_complete");
            level thread zm_tomb_utility::function_95f226b8();
            break;
        }
    }
}

// Namespace zm_tomb_quest_air
// Params 0, eflags: 0x0
// Checksum 0x8f6acf75, Offset: 0x1188
// Size: 0x1ac
function air_puzzle_smoke() {
    self.e_fx = spawn("script_model", self.origin);
    self.e_fx.angles = self.angles;
    self.e_fx setmodel("tag_origin");
    self.e_fx playloopsound("zmb_squest_wind_incense_loop", 2);
    s_dest = struct::get("puzzle_smoke_dest", "targetname");
    playfxontag(level._effect["air_puzzle_smoke"], self.e_fx, "tag_origin");
    self thread function_4bcffb18();
    level flag::wait_till("air_puzzle_2_complete");
    self.e_fx movez(-1000, 1, 0.1, 0.1);
    self.e_fx waittill(#"movedone");
    wait 5;
    self.e_fx delete();
    self.var_ee718f9a delete();
}

// Namespace zm_tomb_quest_air
// Params 0, eflags: 0x0
// Checksum 0xddb8c68, Offset: 0x1340
// Size: 0x2fa
function function_4bcffb18() {
    level endon(#"air_puzzle_2_complete");
    self endon(#"death");
    s_dest = struct::get("puzzle_smoke_dest", "targetname");
    var_b5c0c152 = vectornormalize(s_dest.origin - self.origin);
    var_4077fca8 = cos(self.script_int);
    self.solved = 0;
    self.var_ee718f9a setcandamage(1);
    var_1e198702 = 0;
    while (true) {
        self.var_ee718f9a waittill(#"damage", damage, attacker, direction_vec, point, mod, tagname, modelname, partname, weaponname);
        if (weaponname.name == "staff_air") {
            level notify(#"vo_try_puzzle_air2", attacker);
            new_yaw = math::vec_to_angles(direction_vec);
            var_8e5103e3 = (0, new_yaw, 0);
            self.e_fx rotateto(var_8e5103e3, 1, 0.3, 0.3);
            self.e_fx waittill(#"rotatedone");
            f_dot = vectordot(var_b5c0c152, direction_vec);
            self.solved = f_dot > var_4077fca8;
            if (!self.solved) {
                var_1e198702++;
                if (var_1e198702 > 4) {
                    level notify(#"vo_puzzle_confused", attacker);
                }
            } else if (randomint(100) < 10) {
                level notify(#"vo_puzzle_good", attacker);
            }
            level notify(#"hash_e9869ec8");
            continue;
        }
        if (issubstr(weaponname, "staff")) {
            level notify(#"vo_puzzle_bad", attacker);
        }
    }
}

