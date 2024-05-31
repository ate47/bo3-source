#using scripts/zm/zm_castle_util;
#using scripts/zm/zm_castle_teleporter;
#using scripts/zm/zm_castle_ee;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_melee_weapon;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("zm_castle");

#namespace namespace_61c0be00;

// Namespace namespace_61c0be00
// Method(s) 9 Total 9
class class_66e46dd {

    // Namespace namespace_66e46dd
    // Params 0, eflags: 0x1 linked
    // namespace_66e46dd<file_0>::function_4217f0a1
    // Checksum 0x387bedb3, Offset: 0x2998
    // Size: 0xa0
    function function_4217f0a1() {
        self.var_16cc14d0 setcandamage(1);
        while (true) {
            self.var_16cc14d0.health = 1000000;
            damage, attacker = self.var_16cc14d0 waittill(#"damage");
            if (!self.var_41660b94) {
                continue;
            }
            self.var_a802d3d9 = 0;
            wait(3);
            self.var_a802d3d9 = 1;
        }
    }

    // Namespace namespace_66e46dd
    // Params 0, eflags: 0x1 linked
    // namespace_66e46dd<file_0>::function_1a856336
    // Checksum 0xefbee88a, Offset: 0x28f0
    // Size: 0xa0
    function function_1a856336() {
        self.var_2eb50ca2 setcandamage(1);
        while (true) {
            self.var_2eb50ca2.health = 1000000;
            damage, attacker = self.var_2eb50ca2 waittill(#"damage");
            if (!self.var_41660b94) {
                continue;
            }
            self.var_11a8191e = 0;
            wait(3);
            self.var_11a8191e = 1;
        }
    }

    // Namespace namespace_66e46dd
    // Params 1, eflags: 0x1 linked
    // namespace_66e46dd<file_0>::function_1401a672
    // Checksum 0xd8f70d5, Offset: 0x28d0
    // Size: 0x18
    function function_1401a672(var_fc7b760) {
        self.var_41660b94 = var_fc7b760;
    }

    // Namespace namespace_66e46dd
    // Params 0, eflags: 0x1 linked
    // namespace_66e46dd<file_0>::function_755ccf7d
    // Checksum 0xbb7f0504, Offset: 0x27e0
    // Size: 0xe4
    function function_755ccf7d() {
        var_8b79520 = array("zone_great_hall", "zone_great_hall_upper", "zone_great_hall_upper_left", "zone_armory", "zone_undercroft_chapel", "zone_courtyard", "zone_courtyard_edge");
        foreach (var_348ee409 in var_8b79520) {
            if (zm_zonemgr::any_player_in_zone(var_348ee409)) {
                return true;
            }
        }
        return false;
    }

    // Namespace namespace_66e46dd
    // Params 0, eflags: 0x1 linked
    // namespace_66e46dd<file_0>::function_290563e9
    // Checksum 0x2f030fca, Offset: 0x2448
    // Size: 0x390
    function function_290563e9() {
        while (true) {
            if (!function_755ccf7d()) {
                wait(0.5);
                continue;
            }
            if (level flag::get("ee_disco_inferno") == 1) {
                self.var_5ae81506 = 4;
            } else {
                self.var_5ae81506 = 1;
            }
            self.var_c86771bb rotateyaw(self.var_b548cd69 * self.var_f35c15fb * self.var_5ae81506, 0.5);
            self.var_d6478e9 rotateyaw(self.var_b548cd69 * self.var_9abb59c4 * self.var_90e84049 * self.var_5ae81506, 0.5);
            if (self.var_11a8191e) {
                self.var_d502c153 rotateyaw(self.var_b548cd69 * self.var_9abb59c4 * self.var_5ae81506, 0.5);
                self.var_2eb50ca2 rotateyaw(self.var_b548cd69 * self.var_9abb59c4 * self.var_5ae81506, 0.5);
            }
            if (self.var_a802d3d9) {
                self.var_16cc14d0 rotateyaw(self.var_b548cd69 * self.var_f35c15fb * self.var_95126c9c * self.var_5ae81506, 0.5);
            }
            if (!self.var_11a8191e && !self.var_a802d3d9) {
                var_d536dea5 = self.var_d502c153.angles;
                var_74c90acc = self.var_16cc14d0.angles;
                var_5375e06e = abs(int(var_d536dea5[1] + -114) % 360);
                var_7b4ccc8b = int(abs(var_74c90acc[1])) % 360;
                if (var_74c90acc[1] < 0) {
                    var_15a04435 = 360 - var_7b4ccc8b;
                } else {
                    var_15a04435 = var_7b4ccc8b;
                }
                var_a0dd62e5 = abs(var_5375e06e - var_15a04435);
                if (var_a0dd62e5 > -76) {
                    var_a0dd62e5 = 360 - var_a0dd62e5;
                }
                /#
                    iprintlnbold("int" + var_5375e06e + "int" + var_15a04435 + "int" + var_a0dd62e5);
                #/
                if (var_a0dd62e5 <= 45) {
                    level flag::set("ee_disco_inferno");
                    self.var_11a8191e = 1;
                    self.var_a802d3d9 = 1;
                }
            }
            wait(0.5);
        }
    }

    // Namespace namespace_66e46dd
    // Params 0, eflags: 0x1 linked
    // namespace_66e46dd<file_0>::function_34fb19f
    // Checksum 0xc0211716, Offset: 0x23f0
    // Size: 0x4c
    function start() {
        self thread function_290563e9();
        self thread function_1a856336();
        self thread function_4217f0a1();
    }

    // Namespace namespace_66e46dd
    // Params 0, eflags: 0x1 linked
    // namespace_66e46dd<file_0>::function_c35e6aab
    // Checksum 0x9b45f11e, Offset: 0x2268
    // Size: 0x180
    function init() {
        self.var_41660b94 = 1;
        self.var_11a8191e = 1;
        self.var_a802d3d9 = 1;
        self.var_c86771bb = getent("ee_disco_earth", "targetname");
        self.var_d502c153 = getent("ee_disco_arm_moon", "targetname");
        self.var_16cc14d0 = getent("ee_disco_arm_rocket", "targetname");
        self.var_2eb50ca2 = getent("ee_disco_moon", "targetname");
        self.var_d6478e9 = getent("ee_disco_moon_rocket", "targetname");
        self.var_2eb50ca2 linkto(self.var_d502c153, "tag_moon");
        self.var_d6478e9 linkto(self.var_d502c153, "tag_moon");
        self.var_b548cd69 = 5;
        self.var_f35c15fb = 1;
        self.var_95126c9c = -3;
        self.var_9abb59c4 = 2;
        self.var_90e84049 = 3;
    }

}

// Namespace namespace_61c0be00
// Method(s) 12 Total 12
class class_d7100ae3 {

    // Namespace namespace_d7100ae3
    // Params 0, eflags: 0x1 linked
    // namespace_d7100ae3<file_0>::function_4db73fa1
    // Checksum 0x4e5ff5a, Offset: 0x4660
    // Size: 0x5c
    function function_4db73fa1() {
        self.var_f3797cc9 = !self.var_f3797cc9;
        /#
            if (self.var_f3797cc9) {
                iprintlnbold("int");
                return;
            }
            iprintlnbold("int");
        #/
    }

    // Namespace namespace_d7100ae3
    // Params 0, eflags: 0x1 linked
    // namespace_d7100ae3<file_0>::function_aa7c5ce2
    // Checksum 0xe49f8012, Offset: 0x4640
    // Size: 0x14
    function function_aa7c5ce2() {
        self.var_f3c3ca5a = !self.var_f3c3ca5a;
    }

    // Namespace namespace_d7100ae3
    // Params 1, eflags: 0x1 linked
    // namespace_d7100ae3<file_0>::function_9b5dc008
    // Checksum 0xb5dbcf55, Offset: 0x4610
    // Size: 0x24
    function set_active(b_on) {
        if (self.var_2ed6212f) {
            return;
        }
        self.var_f3c3ca5a = b_on;
    }

    // Namespace namespace_d7100ae3
    // Params 0, eflags: 0x1 linked
    // namespace_d7100ae3<file_0>::function_719601e4
    // Checksum 0xe06f50eb, Offset: 0x4518
    // Size: 0xf0
    function function_719601e4() {
        self.var_8b97288d namespace_744abc1c::create_unitrigger();
        while (true) {
            self.var_8b97288d waittill(#"trigger_activated");
            self function_aa7c5ce2();
            self.var_8b97288d playsound("evt_lever");
            if (self.var_f3c3ca5a) {
                self notify(#"hash_da8088ad");
                self.var_23036e82 = 0;
            }
            self.var_8b97288d rotatepitch(60, 0.333);
            wait(0.333);
            self.var_8b97288d rotatepitch(-60, 0.2);
            wait(0.2);
        }
    }

    // Namespace namespace_d7100ae3
    // Params 0, eflags: 0x1 linked
    // namespace_d7100ae3<file_0>::function_1f5408aa
    // Checksum 0xaa89d86a, Offset: 0x44e0
    // Size: 0x2c
    function function_1f5408aa() {
        if (self.var_a117a15d == 9 && self.var_246b41b3 == 35) {
            return true;
        }
        return false;
    }

    // Namespace namespace_d7100ae3
    // Params 0, eflags: 0x1 linked
    // namespace_d7100ae3<file_0>::function_da8088ad
    // Checksum 0xa71f706e, Offset: 0x4400
    // Size: 0xd8
    function function_da8088ad() {
        self notify(#"hash_da8088ad");
        self endon(#"hash_da8088ad");
        self.var_23036e82 = 1;
        while (true) {
            var_6443dac9 = randomfloatrange(5, 15);
            wait(var_6443dac9);
            level clientfield::increment("clocktower_flash");
            if (function_1f5408aa()) {
                namespace_61c0be00::function_779bfe1e();
                self.var_1ed02f45 playsound("evt_clock_comp");
                function_614407e2();
            }
        }
    }

    // Namespace namespace_d7100ae3
    // Params 0, eflags: 0x1 linked
    // namespace_d7100ae3<file_0>::function_614407e2
    // Checksum 0x3b3523d, Offset: 0x42d0
    // Size: 0x124
    function function_614407e2() {
        self.var_246b41b3++;
        if (self.var_246b41b3 == 60) {
            self.var_246b41b3 = 0;
            self.var_a117a15d++;
        }
        if (self.var_a117a15d == 12) {
            self.var_a117a15d = 0;
        }
        self.var_5c546253 rotatepitch(-6, 0.05);
        self.var_5c546253 playsound("evt_min_hand");
        if (self.var_246b41b3 % 12 == 0) {
            self.var_1ed02f45 rotatepitch(-6, 0.05);
            self.var_1ed02f45 playsound("evt_hour_hand");
        }
        if (self.var_f3797cc9 && function_1f5408aa()) {
            self set_active(0);
        }
    }

    // Namespace namespace_d7100ae3
    // Params 3, eflags: 0x1 linked
    // namespace_d7100ae3<file_0>::function_ec1f5e9
    // Checksum 0xfb054445, Offset: 0x40c8
    // Size: 0x1fc
    function function_ec1f5e9(var_8deda1b1, n_minutes, var_1133e63b) {
        if (!isdefined(var_1133e63b)) {
            var_1133e63b = 20;
        }
        var_3e7e6c38 = self.var_f3c3ca5a;
        self set_active(0);
        self.var_2ed6212f = 1;
        var_16c3da4f = n_minutes - self.var_246b41b3;
        if (var_16c3da4f < 0) {
            var_16c3da4f = 60 + var_16c3da4f;
        }
        var_2dc617a1 = var_8deda1b1 - self.var_a117a15d;
        if (var_2dc617a1 < 0) {
            var_2dc617a1 = 12 + var_2dc617a1;
        }
        /#
            iprintln("int" + var_2dc617a1 + "int" + var_16c3da4f);
        #/
        self.var_5c546253 rotatepitch(-6 * var_16c3da4f, 0.05 * var_16c3da4f * 1 / var_1133e63b);
        self.var_1ed02f45 rotatepitch(-30 * var_2dc617a1, 0.05 * var_2dc617a1 * 1 / var_1133e63b);
        self.var_246b41b3 = n_minutes;
        self.var_a117a15d = var_8deda1b1;
        /#
            iprintln("int" + self.var_a117a15d + "int" + self.var_246b41b3);
        #/
        self.var_2ed6212f = 0;
        self set_active(var_3e7e6c38);
    }

    // Namespace namespace_d7100ae3
    // Params 0, eflags: 0x1 linked
    // namespace_d7100ae3<file_0>::function_34fb19f
    // Checksum 0x30c25be8, Offset: 0x4048
    // Size: 0x78
    function start() {
        self thread function_719601e4();
        while (true) {
            if (self.var_f3c3ca5a) {
                function_614407e2();
            }
            if (!self.var_f3c3ca5a) {
                if (!self.var_23036e82) {
                    self thread function_da8088ad();
                }
            }
            wait(0.4);
        }
    }

    // Namespace namespace_d7100ae3
    // Params 0, eflags: 0x1 linked
    // namespace_d7100ae3<file_0>::function_c35e6aab
    // Checksum 0xde192ad0, Offset: 0x3f78
    // Size: 0xc4
    function init() {
        self.var_5c546253 = getent("ee_clocktower_minute_hand", "targetname");
        self.var_1ed02f45 = getent("ee_clocktower_hour_hand", "targetname");
        self.var_8b97288d = getent("ee_clocktower_activation_switch", "targetname");
        self.var_f3c3ca5a = 0;
        self.var_246b41b3 = 0;
        self.var_a117a15d = 0;
        self.var_23036e82 = 0;
        self.var_f3797cc9 = 0;
        self.var_2ed6212f = 0;
    }

}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x2
// namespace_61c0be00<file_0>::function_2dc19561
// Checksum 0xff5bc96e, Offset: 0xcd8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_zod_ee_side", &__init__, undefined, undefined);
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_8c87d8eb
// Checksum 0x4c371d8f, Offset: 0xd18
// Size: 0x13c
function __init__() {
    level._effect["def_explode"] = "explosions/fx_exp_grenade_default";
    level._effect["mechz_rocket_punch"] = "dlc1/castle/fx_mech_jump_booster_loop";
    clientfield::register("world", "clocktower_flash", 5000, 1, "counter");
    clientfield::register("world", "sndUEB", 5000, 1, "int");
    clientfield::register("actor", "plunger_exploding_ai", 5000, 1, "int");
    clientfield::register("toplayer", "plunger_charged_strike", 5000, 1, "counter");
    zm::register_player_damage_callback(&function_b98927d4);
    zm::register_actor_damage_callback(&function_f10f1879);
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_d290ebfa
// Checksum 0x98420f2a, Offset: 0xe60
// Size: 0xfc
function main() {
    level.var_e1885a4b = &function_e1885a4b;
    level thread function_e437a08f();
    init_flags();
    level waittill(#"start_zombie_round_logic");
    level thread init_objects();
    function_70b74a2d();
    function_b8645c20();
    function_fd2e0e37();
    function_769b2ff();
    function_7998107();
    function_9e325d85();
    /#
        if (getdvarint("int") > 0) {
            level thread function_d6026710();
        }
    #/
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_37af8a07
// Checksum 0xca197ef6, Offset: 0xf68
// Size: 0xe4
function init_flags() {
    level flag::init("play_vocals");
    level flag::init("ee_power_clocktower");
    level flag::init("ee_claw_hat");
    level flag::init("ee_disco_inferno");
    level flag::init("ee_power_wallrun_teleport");
    level flag::init("ee_music_box_turning");
    level flag::init("plunger_teleport_on");
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_452b0b5a
// Checksum 0x53763ba3, Offset: 0x1058
// Size: 0xc0
function init_objects() {
    level.var_818b7815 = new class_66e46dd();
    [[ level.var_818b7815 ]]->init();
    level thread function_e3163325();
    level.var_9f94326b = new class_d7100ae3();
    [[ level.var_9f94326b ]]->init();
    [[ level.var_9f94326b ]]->function_ec1f5e9(1, 15);
    level flag::wait_till("ee_power_clocktower");
    [[ level.var_9f94326b ]]->start();
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_70b74a2d
// Checksum 0xb5a0aea7, Offset: 0x1120
// Size: 0xac
function function_70b74a2d() {
    level thread function_5c600852();
    level thread function_553b8e23();
    level thread spare_change();
    level thread function_7c237ecb();
    level thread function_52c08eab();
    level thread function_4eb3851();
    level thread function_c691b60();
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_e3163325
// Checksum 0x2d50199c, Offset: 0x11d8
// Size: 0x38
function function_e3163325() {
    level flag::wait_till("power_on");
    [[ level.var_818b7815 ]]->start();
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_c691b60
// Checksum 0xded9d366, Offset: 0x1218
// Size: 0x18e
function function_c691b60() {
    for (i = 0; i < 5; i++) {
        var_2de8cf5e = struct::get_array("ee_groph_reels_" + i, "targetname");
        foreach (s_reel in var_2de8cf5e) {
            var_df5776d8 = util::spawn_model(s_reel.model, s_reel.origin, s_reel.angles);
            s_reel.var_df5776d8 = var_df5776d8;
            s_reel.var_df5776d8 thread function_2db2bf79();
        }
        if (i == 0) {
            level thread function_374ac18c(var_2de8cf5e, i);
            continue;
        }
        level thread function_6bf381de(var_2de8cf5e, i);
    }
}

// Namespace namespace_61c0be00
// Params 2, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_6bf381de
// Checksum 0xe6ef533, Offset: 0x13b0
// Size: 0xa8
function function_6bf381de(var_2de8cf5e, var_bee8e45) {
    while (true) {
        var_2de8cf5e[0] namespace_744abc1c::create_unitrigger();
        var_2de8cf5e[0] waittill(#"trigger_activated");
        function_972992c4(var_2de8cf5e, 1);
        var_2de8cf5e[0].var_df5776d8 function_ffa9011b(var_bee8e45);
        function_972992c4(var_2de8cf5e, 0);
    }
}

// Namespace namespace_61c0be00
// Params 2, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_374ac18c
// Checksum 0x1390ecb1, Offset: 0x1460
// Size: 0x180
function function_374ac18c(var_2de8cf5e, var_bee8e45) {
    var_2de8cf5e[0].var_df5776d8 setcandamage(1);
    while (true) {
        var_2de8cf5e[0].var_df5776d8.health = 1000000;
        damage, attacker, dir, loc, type, model, tag, part, weapon, flags = var_2de8cf5e[0].var_df5776d8 waittill(#"damage");
        if (!isdefined(attacker) || !isplayer(attacker)) {
            continue;
        }
        function_972992c4(var_2de8cf5e, 1);
        var_2de8cf5e[0].var_df5776d8 function_ffa9011b(var_bee8e45);
        function_972992c4(var_2de8cf5e, 0);
    }
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_ffa9011b
// Checksum 0x4b3c2788, Offset: 0x15e8
// Size: 0x48
function function_ffa9011b(var_bee8e45) {
    self playsoundwithnotify("vox_grop_groph_radio_stem_" + var_bee8e45 + 1, "sounddone");
    self waittill(#"sounddone");
}

// Namespace namespace_61c0be00
// Params 2, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_972992c4
// Checksum 0xc73b926e, Offset: 0x1638
// Size: 0xb2
function function_972992c4(var_2de8cf5e, b_on) {
    foreach (s_reel in var_2de8cf5e) {
        if (isdefined(s_reel.var_df5776d8)) {
            s_reel.var_df5776d8.var_a02b0d5a = b_on;
        }
    }
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_2db2bf79
// Checksum 0xe95ea75c, Offset: 0x16f8
// Size: 0x50
function function_2db2bf79() {
    while (true) {
        if (isdefined(self.var_a02b0d5a) && self.var_a02b0d5a) {
            self rotateroll(-30, 0.2);
        }
        wait(0.2);
    }
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_e437a08f
// Checksum 0x22706cc0, Offset: 0x1750
// Size: 0x84
function function_e437a08f() {
    var_2c4303b6 = struct::get("ee_music_box");
    level.var_6d5fd229 = util::spawn_model("p7_fxanim_zm_castle_music_box_mod", var_2c4303b6.origin, var_2c4303b6.angles);
    level.var_6d5fd229 useanimtree(#zm_castle);
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_4eb3851
// Checksum 0x2f39159c, Offset: 0x17e0
// Size: 0xdc
function function_4eb3851() {
    level thread function_4e9df779();
    while (true) {
        level.var_6d5fd229 namespace_744abc1c::create_unitrigger();
        level.var_6d5fd229 waittill(#"trigger_activated");
        level flag::set("ee_music_box_turning");
        zm_unitrigger::unregister_unitrigger(level.var_6d5fd229.s_unitrigger);
        level.var_6d5fd229 playsound("mus_samantha_musicbox");
        wait(36);
        level flag::clear("ee_music_box_turning");
        level waittill(#"hash_22c84c8b");
    }
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_4e9df779
// Checksum 0x9e51227f, Offset: 0x18c8
// Size: 0xa2
function function_4e9df779() {
    while (true) {
        level.var_6d5fd229 animation::first_frame("p7_fxanim_zm_castle_music_box_anim");
        level flag::wait_till("ee_music_box_turning");
        while (level flag::get("ee_music_box_turning")) {
            level.var_6d5fd229 animation::play("p7_fxanim_zm_castle_music_box_anim");
        }
        level notify(#"hash_22c84c8b");
    }
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_7998107
// Checksum 0xf2f35abc, Offset: 0x1978
// Size: 0x214
function function_7998107() {
    level.var_37c0c840 = [];
    for (i = 0; i < 3; i++) {
        var_d5409ac0 = struct::get("ee_flying_skull_" + i);
        level.var_37c0c840[i] = util::spawn_model("rune_prison_death_skull", var_d5409ac0.origin, var_d5409ac0.angles);
        level.var_37c0c840[i] flag::init("skull_revealed");
        level.var_37c0c840[i] setcandamage(1);
        level.var_37c0c840[i] thread function_e26b6053();
        level.var_37c0c840[i] thread function_27da29cb();
        level.var_37c0c840[i] setinvisibletoall();
    }
    players = level.activeplayers;
    foreach (player in players) {
        player thread function_5c351802();
    }
    callback::on_spawned(&function_5c351802);
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_5c351802
// Checksum 0xc07ddffd, Offset: 0x1b98
// Size: 0x46
function function_5c351802() {
    for (i = 0; i < 3; i++) {
        self thread function_2f183e13(i);
    }
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_2f183e13
// Checksum 0x6397b2d1, Offset: 0x1be8
// Size: 0xf8
function function_2f183e13(n_index) {
    level.var_37c0c840[n_index] endon(#"hash_7a2f636b");
    if (!isdefined(level.var_37c0c840[n_index])) {
        return;
    }
    if (level.var_37c0c840[n_index] flag::get("skull_revealed")) {
        return;
    }
    while (true) {
        self waittill(#"bgb_bubble_blow_complete");
        if (self bgb::is_active("zm_bgb_in_plain_sight")) {
            level.var_37c0c840[n_index] setvisibletoplayer(self);
            self waittill(#"activation_complete");
            level.var_37c0c840[n_index] setinvisibletoplayer(self);
        }
    }
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_e26b6053
// Checksum 0x8b9c5715, Offset: 0x1ce8
// Size: 0x194
function function_e26b6053() {
    for (b_shot = 0; !b_shot; b_shot = 1) {
        self.health = 1000000;
        damage, attacker, dir, loc, type, model, tag, part, weapon, flags = self waittill(#"damage");
        if (isdefined(attacker) && isplayer(attacker) && attacker bgb::is_active("zm_bgb_in_plain_sight")) {
            if (function_ab61ab31(weapon)) {
            }
        }
    }
    function_44ea752c();
    self flag::set("skull_revealed");
    playfx(level._effect["def_explode"], self.origin);
    self delete();
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_ab61ab31
// Checksum 0xb23cbd68, Offset: 0x1e88
// Size: 0x32
function function_ab61ab31(weapon) {
    return issubstr(weapon.name, "elemental_bow");
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_44ea752c
// Checksum 0xae669535, Offset: 0x1ec8
// Size: 0x80
function function_44ea752c() {
    if (!isdefined(level.var_a0554b26)) {
        level.var_a0554b26 = 0;
    }
    function_dbc1fb93(level.var_a0554b26);
    level.var_a0554b26++;
    playsoundatposition("zmb_ee_skpower_" + level.var_a0554b26, (0, 0, 0));
    if (level.var_a0554b26 == 3) {
        level.var_9bf9e084 = 1;
    }
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_dbc1fb93
// Checksum 0xec4a9f21, Offset: 0x1f50
// Size: 0xc4
function function_dbc1fb93(var_d237c2be) {
    if (!isdefined(level.var_478986c0)) {
        level.var_478986c0 = [];
    }
    var_fff40961 = struct::get("ee_skull_pile_" + var_d237c2be);
    level.var_478986c0[var_d237c2be] = util::spawn_model("rune_prison_death_skull", var_fff40961.origin, var_fff40961.angles);
    if (var_d237c2be == 2) {
        level.var_478986c0[var_d237c2be] thread function_67a47b1c();
    }
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_67a47b1c
// Checksum 0x4330d5ea, Offset: 0x2020
// Size: 0x134
function function_67a47b1c() {
    self namespace_744abc1c::create_unitrigger();
    self waittill(#"trigger_activated");
    if (level.var_9bf9e084 == 0) {
        return;
    }
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
    level.var_9bf9e084 = 0;
    playsoundatposition("zmb_ee_skpower_deactivate", (0, 0, 0));
    for (i = 0; i < 3; i++) {
        if (isdefined(level.var_478986c0[i])) {
            playfx(level._effect["def_explode"], level.var_478986c0[i].origin);
            level.var_478986c0[i] delete();
        }
        wait(0.5);
    }
    level thread function_3c992a71();
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_3c992a71
// Checksum 0x95b80be4, Offset: 0x2160
// Size: 0x34
function function_3c992a71() {
    level.var_a0554b26 = 0;
    level.var_478986c0 = [];
    level thread function_7998107();
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_27da29cb
// Checksum 0xa1d4fca8, Offset: 0x21a0
// Size: 0xc0
function function_27da29cb() {
    self endon(#"hash_7a2f636b");
    var_43af6ca7 = self.origin[2];
    while (true) {
        n_current_time = gettime();
        n_offset = sin(n_current_time * 0.1) * 16;
        v_origin = self.origin;
        self.origin = (v_origin[0], v_origin[1], var_43af6ca7 + n_offset);
        wait(0.05);
    }
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_769b2ff
// Checksum 0xae1affdf, Offset: 0x2c40
// Size: 0x126
function function_769b2ff() {
    level.var_23825200 = [];
    for (i = 0; i < 3; i++) {
        var_95164560 = struct::get("ee_claw_" + i + "_start");
        level.var_23825200[i] = util::spawn_model("c_t6_zom_mech_claw", var_95164560.origin, var_95164560.angles);
        level.var_23825200[i] flag::init("mechz_claw_revealed");
        level.var_23825200[i] setcandamage(1);
        level.var_23825200[i] thread function_e249cd7(i);
    }
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x0
// namespace_61c0be00<file_0>::function_5d2ff09a
// Checksum 0x500aa027, Offset: 0x2d70
// Size: 0x46
function function_5d2ff09a() {
    for (i = 0; i < 3; i++) {
        function_c02b51fb(i);
    }
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_c02b51fb
// Checksum 0x4c39fac6, Offset: 0x2dc0
// Size: 0xe0
function function_c02b51fb(n_index) {
    level.var_23825200[n_index] endon(#"hash_8a2ede71");
    if (level.var_23825200[n_index] flag::get("mechz_claw_revealed")) {
        return;
    }
    while (true) {
        self waittill(#"bgb_bubble_blow_complete");
        if (self bgb::is_active("zm_bgb_in_plain_sight")) {
            level.var_23825200[n_index] setvisibletoplayer(self);
            self waittill(#"activation_complete");
            level.var_23825200[n_index] setinvisibletoplayer(self);
        }
    }
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_e249cd7
// Checksum 0xcc789a3e, Offset: 0x2ea8
// Size: 0x32c
function function_e249cd7(n_index) {
    var_8b9b7897 = 0;
    while (!var_8b9b7897) {
        self.health = 1000000;
        var_354439b5 = self function_64e6de56();
        if (!var_354439b5) {
            continue;
        }
        var_8b9b7897 = 1;
        self playsound("zmb_ee_mechz_imp");
        self setcandamage(0);
    }
    self flag::set("mechz_claw_revealed");
    self setvisibletoall();
    var_7ddcf23 = struct::get("ee_claw_" + n_index + "_fell");
    self moveto(var_7ddcf23.origin, 0.333);
    self thread function_4767e6ca();
    wait(0.333);
    self setcandamage(1);
    var_f9f3d790 = 0;
    while (!var_f9f3d790) {
        self.health = 1000000;
        var_354439b5 = self function_64e6de56();
        if (!var_354439b5) {
            continue;
        }
        var_f9f3d790 = 1;
        self playsound("zmb_ee_mechz_activate");
        self playloopsound("zmb_ee_mechz_fire_lp", 0.1);
    }
    var_197d929 = struct::get("ee_claw_" + n_index + "_shot");
    self thread function_d23efff2();
    playfxontag(level._effect["mechz_rocket_punch"], self, "fx_rocket");
    self moveto(var_197d929.origin, 1);
    wait(1);
    self playsound("zmb_ee_mechz_explode");
    playfx(level._effect["def_explode"], self.origin);
    self notify(#"hash_d23efff2");
    self delete();
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_4767e6ca
// Checksum 0xd82e44b2, Offset: 0x31e0
// Size: 0x2c
function function_4767e6ca() {
    self waittill(#"movedone");
    self playsound("zmb_ee_mechz_fallimp");
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_64e6de56
// Checksum 0x7840601e, Offset: 0x3218
// Size: 0x188
function function_64e6de56() {
    damage, attacker, direction_vec, point, type, tagname, modelname, partname, weapon, inflictor = self waittill(#"damage");
    if (type === "MOD_GRENADE" || type === "MOD_GRENADE_SPLASH" || type === "MOD_EXPLOSIVE" || type === "MOD_EXPLOSIVE_SPLASH") {
        return false;
    }
    if (function_ab61ab31(weapon)) {
        var_64deb4b = spawn("script_origin", point);
        if (!var_64deb4b istouching(self)) {
            var_64deb4b delete();
            return false;
        }
        var_64deb4b delete();
    }
    if (!isdefined(attacker) || !isplayer(attacker)) {
        return false;
    }
    return true;
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_d23efff2
// Checksum 0x484e73d4, Offset: 0x33a8
// Size: 0x200
function function_d23efff2() {
    self endon(#"hash_d23efff2");
    while (true) {
        a_enemies = getactorteamarray("axis");
        foreach (e_enemy in a_enemies) {
            dist2 = distancesquared(self.origin, e_enemy.origin);
            if (dist2 < 16384) {
                if (isdefined(e_enemy) && isalive(e_enemy)) {
                    if (isdefined(e_enemy.archetype) && e_enemy.archetype == "mechz") {
                        e_enemy dodamage(self.health * 777, e_enemy.origin);
                        if (!isdefined(level.var_708b5a49)) {
                            level.var_708b5a49 = 1;
                        } else {
                            level.var_708b5a49++;
                        }
                        if (level.var_708b5a49 == 3) {
                            function_90b13c3d();
                        }
                        continue;
                    }
                    if (isdefined(e_enemy.archetype) && e_enemy.archetype == "zombie") {
                        e_enemy thread zombie_death::do_gib();
                    }
                }
            }
        }
        wait(0.2);
    }
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_d249c76c
// Checksum 0xccb5559c, Offset: 0x35b0
// Size: 0x2c
function function_d249c76c() {
    self attach("c_t6_zom_mech_claw_hat", "j_head");
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_90b13c3d
// Checksum 0xa2ff3fa6, Offset: 0x35e8
// Size: 0xd4
function function_90b13c3d() {
    players = level.activeplayers;
    foreach (player in players) {
        player function_d249c76c();
    }
    level flag::set("ee_claw_hat");
    callback::on_spawned(&function_d249c76c);
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_b8645c20
// Checksum 0x9e344412, Offset: 0x36c8
// Size: 0x24
function function_b8645c20() {
    level.var_91b525ed = 0;
    function_79e1bd74(0);
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_79e1bd74
// Checksum 0x5d134458, Offset: 0x36f8
// Size: 0xdc
function function_79e1bd74(n_level) {
    a_str_models = array("p7_zm_ctl_newspaper_01_parade", "p7_zm_ctl_newspaper_01_attacks", "p7_zm_ctl_newspaper_01_outbreak");
    str_model = a_str_models[n_level];
    if (!isdefined(level.var_31e6a027)) {
        var_21231084 = struct::get("ee_newspaper");
        level.var_31e6a027 = util::spawn_model(str_model, var_21231084.origin, var_21231084.angles);
        return;
    }
    level.var_31e6a027 setmodel(str_model);
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_fd2e0e37
// Checksum 0x21ce5a87, Offset: 0x37e0
// Size: 0xa4
function function_fd2e0e37() {
    level.var_f4166c4f = 0;
    s_loc = struct::get("ee_plunger_pickup");
    level.var_163864b7 = util::spawn_model("wpn_t7_zmb_dlc1_plunger_world", s_loc.origin, s_loc.angles);
    level thread function_4811d22b();
    function_56e07512(s_loc);
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_4811d22b
// Checksum 0x825cdad9, Offset: 0x3890
// Size: 0xa0
function function_4811d22b() {
    level endon(#"hash_4811d22b");
    level.var_163864b7 setinvisibletoall();
    while (true) {
        level flag::wait_till("plunger_teleport_on");
        level.var_163864b7 setvisibletoall();
        level flag::wait_till_clear("plunger_teleport_on");
        level.var_163864b7 setinvisibletoall();
    }
}

// Namespace namespace_61c0be00
// Params 10, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_b98927d4
// Checksum 0x5d0e4394, Offset: 0x3938
// Size: 0x12a
function function_b98927d4(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime) {
    if (level flag::get("ee_claw_hat") && eattacker.archetype == "mechz") {
        switch (smeansofdeath) {
        case 80:
            idamage *= 0.5;
            break;
        case 79:
            idamage *= 0.5;
            break;
        case 81:
            idamage *= 0.5;
            break;
        }
        idamage = int(idamage);
        return idamage;
    }
    return -1;
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_52c08eab
// Checksum 0x76ee9b6e, Offset: 0x3a70
// Size: 0x128
function function_52c08eab() {
    while (true) {
        level flag::wait_till("ee_disco_inferno");
        [[ level.var_818b7815 ]]->function_1401a672(0);
        level.var_818b7815.var_c86771bb playsound("mus_ee_disco");
        level thread lui::screen_flash(0.15, 0.1, 0.5, 1, "white");
        wait(0.15);
        exploder::exploder("disco_lgt");
        wait(52);
        exploder::exploder_stop("disco_lgt");
        level flag::clear("ee_disco_inferno");
        [[ level.var_818b7815 ]]->function_1401a672(1);
    }
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_7c237ecb
// Checksum 0xf1ff9847, Offset: 0x3ba0
// Size: 0x314
function function_7c237ecb(var_f00386ff) {
    if (!isdefined(var_f00386ff)) {
        var_f00386ff = 0;
    }
    if (!sessionmodeisonlinegame() && !var_f00386ff) {
        return;
    }
    var_c27c9236 = struct::get("ee_plant_present");
    var_15cfdc94 = util::spawn_model("p7_zm_ctl_plant_decor_sprout", var_c27c9236.origin, var_c27c9236.angles);
    var_15cfdc94 namespace_744abc1c::create_unitrigger();
    var_15cfdc94 waittill(#"trigger_activated");
    zm_unitrigger::unregister_unitrigger(var_15cfdc94.s_unitrigger);
    var_15cfdc94 hide();
    var_1f6712bd = struct::get("ee_plant_past");
    var_4bb0e877 = util::spawn_model("p7_zm_ctl_plant_decor_sprout", var_1f6712bd.origin, var_1f6712bd.angles);
    var_4bb0e877 hide();
    var_1f6712bd namespace_744abc1c::create_unitrigger();
    var_1f6712bd waittill(#"trigger_activated");
    zm_unitrigger::unregister_unitrigger(var_1f6712bd.s_unitrigger);
    var_4bb0e877 show();
    var_f6cbed0f = struct::get("ee_plant_gobblegum");
    var_15cfdc94 setmodel("p7_zm_ctl_plant_decor_grown");
    var_15cfdc94 show();
    var_acadbb15 = util::spawn_model("p7_zm_zod_bubblegum_machine_gumball_white", var_f6cbed0f.origin, var_f6cbed0f.angles);
    var_15cfdc94 namespace_744abc1c::create_unitrigger();
    player = var_15cfdc94 waittill(#"trigger_activated");
    zm_unitrigger::unregister_unitrigger(var_15cfdc94.s_unitrigger);
    var_acadbb15 delete();
    player.var_b287be = bgb::function_d51db887();
    player thread bgb::bgb_gumball_anim(player.var_b287be, 0);
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_e1885a4b
// Checksum 0xfcd423d3, Offset: 0x3ec0
// Size: 0xac
function function_e1885a4b(mdl_spike) {
    if (isdefined(level.var_714fae39) && level.var_714fae39 && level flag::get("ee_power_clocktower") == 0) {
        var_3d98ac09 = getent("clocktower_power_trig", "targetname");
        if (mdl_spike istouching(var_3d98ac09)) {
            level flag::set("ee_power_clocktower");
        }
    }
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_9e325d85
// Checksum 0xb7e8c520, Offset: 0x4958
// Size: 0xbc
function function_9e325d85() {
    for (i = 0; i < 4; i++) {
        var_634fac89 = getent("ee_undercroft_wallrun_" + i, "targetname");
        var_634fac89 thread function_81d41eb8(i);
    }
    var_3294f1d9 = getent("ee_undercroft_wallrun_reset", "targetname");
    var_3294f1d9 thread function_8d508e48();
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_779bfe1e
// Checksum 0xb37ded2f, Offset: 0x4a20
// Size: 0x5c
function function_779bfe1e() {
    exploder::exploder("fxexp_600");
    level flag::set("ee_power_wallrun_teleport");
    level clientfield::set("sndUEB", 1);
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_421bb7db
// Checksum 0xcb055d2a, Offset: 0x4a88
// Size: 0x5c
function function_421bb7db() {
    exploder::stop_exploder("fxexp_600");
    level flag::clear("ee_power_wallrun_teleport");
    level clientfield::set("sndUEB", 0);
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_81d41eb8
// Checksum 0x54721a85, Offset: 0x4af0
// Size: 0x16c
function function_81d41eb8(var_7f701981) {
    while (true) {
        player = self waittill(#"trigger");
        if (level flag::get("ee_power_wallrun_teleport") == 0) {
            continue;
        }
        if (isdefined(player.var_48391945) && var_7f701981 != player.var_48391945) {
            var_32ceceb2 = function_6ad38393(player, var_7f701981);
            if (isdefined(player.var_6670513f) && player.var_6670513f == var_32ceceb2) {
                player.var_130b9781++;
            } else if (!isdefined(player.var_6670513f)) {
                player.var_130b9781 = 1;
            }
            player.var_6670513f = var_32ceceb2;
        }
        if (player.var_130b9781 === 8) {
            function_27b3a99c(player);
        }
        player.var_48391945 = var_7f701981;
    }
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_8d508e48
// Checksum 0x651f1aca, Offset: 0x4c68
// Size: 0x46
function function_8d508e48() {
    while (true) {
        player = self waittill(#"trigger");
        player.var_130b9781 = 0;
        player.var_48391945 = undefined;
    }
}

// Namespace namespace_61c0be00
// Params 2, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_6ad38393
// Checksum 0x38191ccd, Offset: 0x4cb8
// Size: 0x98
function function_6ad38393(player, var_7f701981) {
    if (player.var_48391945 == 0 && (player.var_48391945 > var_7f701981 || var_7f701981 == 3)) {
        return 1;
    }
    if (var_7f701981 == 0 && (player.var_48391945 < var_7f701981 || player.var_48391945 == 3)) {
        return 0;
    }
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_27b3a99c
// Checksum 0x17951d21, Offset: 0x4d58
// Size: 0x224
function function_27b3a99c(player) {
    level.var_f4166c4f++;
    level flag::set("plunger_teleport_on");
    zm_zonemgr::enable_zone("zone_past_laboratory");
    visionset_mgr::activate("overlay", "zm_factory_teleport", player, level.var_bcadbc9d, level.var_bcadbc9d);
    s_dest = struct::get("ee_teleport_to_plunger_" + player.characterindex, "targetname");
    function_aaacffb2(player, s_dest);
    wait(0.05);
    player clientfield::set_to_player("ee_quest_back_in_time_postfx", 1);
    var_f9d5e23a = player hasweapon(getweapon("knife_plunger"));
    wait(10);
    s_return = struct::get("ee_teleport_return_from_plunger_" + player.characterindex, "targetname");
    player clientfield::set_to_player("ee_quest_back_in_time_postfx", 0);
    visionset_mgr::activate("overlay", "zm_factory_teleport", player, level.var_bcadbc9d, level.var_bcadbc9d);
    function_aaacffb2(player, s_return);
    level.var_f4166c4f--;
    if (level.var_f4166c4f == 0) {
        level flag::clear("plunger_teleport_on");
    }
    function_421bb7db();
}

// Namespace namespace_61c0be00
// Params 2, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_aaacffb2
// Checksum 0x9da8ff6f, Offset: 0x4f88
// Size: 0x4d4
function function_aaacffb2(player, s_dest) {
    var_daad3c3c = (0, 0, 49);
    var_6b55b1c4 = (0, 0, 20);
    var_3abe10e2 = (0, 0, 0);
    var_d3263bfe = getent("teleport_room_" + player.characterindex, "targetname");
    player zm_utility::create_streamer_hint(s_dest.origin, s_dest.angles, 0.25);
    if (isdefined(var_d3263bfe)) {
        visionset_mgr::deactivate("overlay", "zm_trap_electric", player);
        visionset_mgr::activate("overlay", "zm_factory_teleport", player);
        player disableoffhandweapons();
        player disableweapons();
        if (player getstance() == "prone") {
            desired_origin = var_d3263bfe.origin + var_daad3c3c;
        } else if (player getstance() == "crouch") {
            desired_origin = var_d3263bfe.origin + var_6b55b1c4;
        } else {
            desired_origin = var_d3263bfe.origin + var_3abe10e2;
        }
        player.var_39386de = spawn("script_origin", player.origin);
        player.var_39386de.angles = player.angles;
        player linkto(player.var_39386de);
        player.var_39386de.origin = desired_origin;
        player freezecontrols(1);
        util::wait_network_frame();
        if (isdefined(player)) {
            util::setclientsysstate("levelNotify", "black_box_start", player);
            player.var_39386de.angles = var_d3263bfe.angles;
        }
    }
    wait(2);
    s_dest thread namespace_fa1b0620::function_40b54710(undefined, 300);
    for (i = 0; i < level.activeplayers.size; i++) {
        util::setclientsysstate("levelNotify", "black_box_end", level.activeplayers[i]);
    }
    util::wait_network_frame();
    if (!isdefined(player)) {
        return;
    }
    player unlink();
    if (isdefined(player.var_39386de)) {
        player.var_39386de delete();
        player.var_39386de = undefined;
    }
    visionset_mgr::deactivate("overlay", "zm_factory_teleport", player);
    player enableweapons();
    player enableoffhandweapons();
    player setorigin(s_dest.origin);
    player setplayerangles(s_dest.angles);
    player freezecontrols(0);
    player thread namespace_fa1b0620::function_77a0f55b();
    player zm_utility::clear_streamer_hint();
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_56e07512
// Checksum 0xb2ca3b4a, Offset: 0x5468
// Size: 0x17c
function function_56e07512(s_loc) {
    s_loc.unitrigger_stub = spawnstruct();
    s_loc.unitrigger_stub.origin = s_loc.origin;
    s_loc.unitrigger_stub.angles = s_loc.angles;
    s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_loc.unitrigger_stub.script_width = -128;
    s_loc.unitrigger_stub.script_height = -128;
    s_loc.unitrigger_stub.script_length = -128;
    s_loc.unitrigger_stub.require_look_at = 1;
    s_loc.unitrigger_stub.prompt_and_visibility_func = &function_dbab79d5;
    zm_unitrigger::register_static_unitrigger(s_loc.unitrigger_stub, &function_6527501a);
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_dbab79d5
// Checksum 0x18475529, Offset: 0x55f0
// Size: 0xa2
function function_dbab79d5(player) {
    b_is_invis = 0;
    var_f9d5e23a = player hasweapon(getweapon("knife_plunger"));
    if (var_f9d5e23a) {
        b_is_invis = 1;
    }
    if (level.var_f4166c4f == 0) {
        b_is_invis = 1;
    }
    self setinvisibletoplayer(player, b_is_invis);
    return !b_is_invis;
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_6527501a
// Checksum 0x76852c8d, Offset: 0x56a0
// Size: 0xf4
function function_6527501a() {
    while (true) {
        player = self waittill(#"trigger");
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        var_f9d5e23a = player hasweapon(getweapon("knife_plunger"));
        if (var_f9d5e23a) {
            continue;
        }
        if (level.var_f4166c4f == 0) {
            continue;
        }
        level thread function_b7365949(self.stub, player);
        break;
    }
}

// Namespace namespace_61c0be00
// Params 2, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_b7365949
// Checksum 0x41b461df, Offset: 0x57a0
// Size: 0x15c
function function_b7365949(var_91089b66, player) {
    level notify(#"hash_4811d22b");
    level.var_163864b7 delete();
    function_421bb7db();
    zm_spawner::register_zombie_death_event_callback(&function_8d95ec46);
    players = level.activeplayers;
    foreach (player in level.activeplayers) {
        if (isdefined(player) && isalive(player)) {
            player thread function_45b9eba4();
        }
    }
    callback::on_spawned(&function_45b9eba4);
    var_91089b66 zm_unitrigger::run_visibility_function_for_all_triggers();
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_45b9eba4
// Checksum 0xe1993545, Offset: 0x5908
// Size: 0x6c
function function_45b9eba4() {
    self.var_82aee9e9 = &function_9ce92341;
    self zm_melee_weapon::award_melee_weapon("knife_plunger");
    self thread function_9daec9e3();
    self thread function_1fcb04d7();
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_9ce92341
// Checksum 0x99ec1590, Offset: 0x5980
// Size: 0x4
function function_9ce92341() {
    
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_1fcb04d7
// Checksum 0xa7186f86, Offset: 0x5990
// Size: 0x26
function function_1fcb04d7() {
    self endon(#"disconnect");
    self waittill(#"bled_out");
    self.var_82aee9e9 = undefined;
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_9daec9e3
// Checksum 0xd78ffa30, Offset: 0x59c0
// Size: 0x98
function function_9daec9e3() {
    self endon(#"disconnect");
    var_7c4fe278 = getweapon("knife_plunger");
    while (true) {
        weapon = self waittill(#"weapon_melee");
        if (weapon == var_7c4fe278 && isdefined(self.var_ea5424ae) && self.var_ea5424ae > 0) {
            self clientfield::increment_to_player("plunger_charged_strike");
        }
    }
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_c7bb86e5
// Checksum 0x51532645, Offset: 0x5a60
// Size: 0xac
function function_c7bb86e5(attacker) {
    if (!isdefined(attacker.var_ea5424ae)) {
        attacker.var_ea5424ae = 0;
    }
    attacker.var_ea5424ae++;
    /#
        iprintln("int" + attacker.var_ea5424ae);
    #/
    wait(60);
    attacker.var_ea5424ae--;
    /#
        iprintln("int" + attacker.var_ea5424ae);
    #/
}

// Namespace namespace_61c0be00
// Params 1, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_8d95ec46
// Checksum 0x671ea8a3, Offset: 0x5b18
// Size: 0x5c
function function_8d95ec46(e_attacker) {
    var_7c4fe278 = getweapon("knife_plunger");
    if (var_7c4fe278 == self.damageweapon) {
        self zombie_utility::zombie_head_gib();
        return true;
    }
    return false;
}

// Namespace namespace_61c0be00
// Params 12, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_f10f1879
// Checksum 0x6770bacd, Offset: 0x5b80
// Size: 0x16e
function function_f10f1879(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    var_7c4fe278 = getweapon("knife_plunger");
    if (weapon == var_7c4fe278 && isdefined(attacker) && isplayer(attacker) && isdefined(attacker.var_ea5424ae) && attacker.var_ea5424ae > 0) {
        damage = 777 * self.health;
        if (isdefined(self)) {
            self thread function_beeeab78();
        }
        level.var_91b525ed++;
        if (level.var_91b525ed >= 16) {
            function_79e1bd74(2);
        } else if (level.var_91b525ed >= 4) {
            function_79e1bd74(1);
        }
        return damage;
    }
    return -1;
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_beeeab78
// Checksum 0x5fe2d3ed, Offset: 0x5cf8
// Size: 0x84
function function_beeeab78() {
    self clientfield::set("plunger_exploding_ai", 1);
    self zombie_utility::zombie_eye_glow_stop();
    wait(0.15);
    self ghost();
    self util::delay(0.15, undefined, &zm_utility::self_delete);
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_5c600852
// Checksum 0x74117f31, Offset: 0x5d88
// Size: 0xac
function function_5c600852() {
    level.var_89ad28cd = 0;
    var_d959ac05 = getentarray("hs_gramophone", "targetname");
    array::thread_all(var_d959ac05, &function_db46cccd);
    while (true) {
        level waittill(#"hash_9c9fb305");
        if (level.var_89ad28cd == var_d959ac05.size) {
            break;
        }
    }
    level thread zm_audio::sndmusicsystem_playstate("requiem");
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_db46cccd
// Checksum 0xaada0f17, Offset: 0x5e40
// Size: 0x16c
function function_db46cccd() {
    self namespace_744abc1c::create_unitrigger();
    self playloopsound("zmb_ee_gramophone_lp", 1);
    /#
        self thread namespace_744abc1c::function_8faf1d24((0, 0, 255), "int");
    #/
    while (!(isdefined(self.b_activated) && self.b_activated)) {
        self waittill(#"trigger_activated");
        if (isdefined(level.musicsystemoverride) && (isdefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4 || level.musicsystemoverride)) {
            continue;
        }
        if (!(isdefined(self.b_activated) && self.b_activated)) {
            self.b_activated = 1;
            level.var_89ad28cd++;
            level notify(#"hash_9c9fb305");
            self stoploopsound(0.2);
        }
        self playsound("zmb_ee_gramophone_activate");
    }
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_553b8e23
// Checksum 0xcbf24f7a, Offset: 0x5fb8
// Size: 0xcc
function function_553b8e23() {
    level.var_51d5c50c = 0;
    var_c911c0a2 = struct::get_array("hs_bear", "targetname");
    array::thread_all(var_c911c0a2, &function_4b02c768);
    while (true) {
        level waittill(#"hash_c3f82290");
        if (level.var_51d5c50c == var_c911c0a2.size) {
            break;
        }
    }
    level thread zm_audio::sndmusicsystem_playstate("dead_again");
    level thread audio::unlockfrontendmusic("mus_dead_again_intro");
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_4b02c768
// Checksum 0xd3bad858, Offset: 0x6090
// Size: 0x1bc
function function_4b02c768() {
    e_origin = spawn("script_origin", self.origin);
    e_origin namespace_744abc1c::create_unitrigger();
    e_origin playloopsound("zmb_ee_bear_lp", 1);
    /#
        e_origin thread namespace_744abc1c::function_8faf1d24((0, 0, 255), "int");
    #/
    while (!(isdefined(e_origin.b_activated) && e_origin.b_activated)) {
        e_origin waittill(#"trigger_activated");
        if (isdefined(level.musicsystemoverride) && (isdefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4 || level.musicsystemoverride)) {
            continue;
        }
        if (!(isdefined(e_origin.b_activated) && e_origin.b_activated)) {
            e_origin.b_activated = 1;
            level.var_51d5c50c++;
            level notify(#"hash_c3f82290");
            e_origin stoploopsound(0.2);
        }
        e_origin playsound("zmb_ee_bear_activate");
    }
    zm_unitrigger::unregister_unitrigger(e_origin.s_unitrigger);
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_47cf1165
// Checksum 0xfe7f2d97, Offset: 0x6258
// Size: 0xd2
function spare_change() {
    a_triggers = getentarray("audio_bump_trigger", "targetname");
    foreach (t_audio_bump in a_triggers) {
        if (t_audio_bump.script_sound === "zmb_perks_bump_bottle") {
            t_audio_bump thread check_for_change();
        }
    }
}

// Namespace namespace_61c0be00
// Params 0, eflags: 0x1 linked
// namespace_61c0be00<file_0>::function_8ac7562
// Checksum 0x7e6cf6a0, Offset: 0x6338
// Size: 0x9c
function check_for_change() {
    while (true) {
        e_player = self waittill(#"trigger");
        if (e_player getstance() == "prone") {
            e_player zm_score::add_to_player_score(100);
            zm_utility::play_sound_at_pos("purchase", e_player.origin);
            break;
        }
        wait(0.15);
    }
}

/#

    // Namespace namespace_61c0be00
    // Params 0, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_d6026710
    // Checksum 0x7dd7519a, Offset: 0x63e0
    // Size: 0x3bc
    function function_d6026710() {
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_3d627178);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_f0dc1bf3);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 0, &function_3388f3a3);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_3388f3a3);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 2, &function_3388f3a3);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_239f31ac);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_8f84cfff);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_e6679107);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_71626c1a);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_c8b68402);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_14004ce0);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_5b000c75);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_4e8ebeb2);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_d40e8eab);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_ce8b131c);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_71bd024b);
        level thread namespace_744abc1c::function_72260d3a("int", "int", 1, &function_ad9da95f);
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_f0dc1bf3
    // Checksum 0xb21bb1db, Offset: 0x67a8
    // Size: 0x2c
    function function_f0dc1bf3(n_val) {
        level flag::set("int");
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_3d627178
    // Checksum 0xc1d2ce0f, Offset: 0x67e0
    // Size: 0x24
    function function_3d627178(n_val) {
        function_90b13c3d();
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_ce8b131c
    // Checksum 0xe52de3c4, Offset: 0x6810
    // Size: 0xca
    function function_ce8b131c(n_val) {
        zm_spawner::register_zombie_death_event_callback(&function_8d95ec46);
        players = level.activeplayers;
        foreach (player in players) {
            player thread function_45b9eba4();
        }
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_3388f3a3
    // Checksum 0x352c00e0, Offset: 0x68e8
    // Size: 0x24
    function function_3388f3a3(n_val) {
        function_79e1bd74(n_val);
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_14004ce0
    // Checksum 0x154cf854, Offset: 0x6918
    // Size: 0x24
    function function_14004ce0(n_val) {
        function_779bfe1e();
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_5b000c75
    // Checksum 0xe7b76203, Offset: 0x6948
    // Size: 0x24
    function function_5b000c75(n_val) {
        function_421bb7db();
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_ad9da95f
    // Checksum 0x92d0e1de, Offset: 0x6978
    // Size: 0x2c
    function function_ad9da95f(n_val) {
        zm_zonemgr::enable_zone("int");
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_4e8ebeb2
    // Checksum 0x6a12ebdd, Offset: 0x69b0
    // Size: 0xaa
    function function_4e8ebeb2(n_val) {
        players = level.activeplayers;
        foreach (player in players) {
            level thread function_27b3a99c(player);
        }
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_d40e8eab
    // Checksum 0x249b36f8, Offset: 0x6a68
    // Size: 0xaa
    function function_d40e8eab(n_val) {
        players = level.activeplayers;
        foreach (player in players) {
            level thread function_c7bb86e5(player);
        }
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_71bd024b
    // Checksum 0x2f8a9bba, Offset: 0x6b20
    // Size: 0x2c
    function function_71bd024b(n_val) {
        level thread function_7c237ecb(1);
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_239f31ac
    // Checksum 0xabdec8a7, Offset: 0x6b58
    // Size: 0x2c
    function function_239f31ac(n_val) {
        level flag::set("int");
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_8f84cfff
    // Checksum 0x9241b1ae, Offset: 0x6b90
    // Size: 0x24
    function function_8f84cfff(n_val) {
        [[ level.var_9f94326b ]]->function_aa7c5ce2();
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_e6679107
    // Checksum 0xe3690858, Offset: 0x6bc0
    // Size: 0x24
    function function_e6679107(n_val) {
        [[ level.var_9f94326b ]]->function_4db73fa1();
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_71626c1a
    // Checksum 0xc2a0917f, Offset: 0x6bf0
    // Size: 0x2c
    function function_71626c1a(n_val) {
        [[ level.var_9f94326b ]]->function_ec1f5e9(1, 15);
    }

    // Namespace namespace_61c0be00
    // Params 1, eflags: 0x1 linked
    // namespace_61c0be00<file_0>::function_c8b68402
    // Checksum 0xc689db41, Offset: 0x6c28
    // Size: 0x2c
    function function_c8b68402(n_val) {
        [[ level.var_9f94326b ]]->function_ec1f5e9(9, 35);
    }

#/
