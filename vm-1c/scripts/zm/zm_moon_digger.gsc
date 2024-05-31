#using scripts/zm/zm_moon_gravity;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/zm_moon;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_equip_hacker;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_98c95ca3;

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_4ad5a124
// Checksum 0x60296f2d, Offset: 0xb00
// Size: 0x320
function function_4ad5a124() {
    level.var_d00ac1bc = 240;
    level flag::init("teleporter_digger_hacked");
    level flag::init("teleporter_digger_hacked_before_breached");
    level flag::init("start_teleporter_digger");
    level flag::init("start_hangar_digger");
    level flag::init("hangar_digger_hacked");
    level flag::init("hangar_digger_hacked_before_breached");
    level flag::init("start_biodome_digger");
    level flag::init("biodome_digger_hacked");
    level flag::init("biodome_digger_hacked_before_breached");
    level flag::init("hide_diggers");
    level flag::init("init_diggers");
    level flag::set("init_diggers");
    level flag::init("teleporter_breached");
    level flag::init("hangar_breached");
    level flag::init("biodome_breached");
    level flag::init("teleporter_blocked");
    level flag::init("hangar_blocked");
    level flag::init("both_tunnels_breached");
    level flag::init("both_tunnels_blocked");
    level flag::init("digger_moving");
    level.var_3943b1da = array("teleporter", "hangar", "biodome");
    if (!isdefined(level.var_4b290403)) {
        level.var_4b290403 = 1;
    }
    if (isdefined(level.quantum_bomb_register_result_func)) {
        [[ level.quantum_bomb_register_result_func ]]("remove_digger", &function_5e5934a9, 75, &function_babe0dab);
    }
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_583ec468
// Checksum 0x2dbcfdaf, Offset: 0xe28
// Size: 0x1c
function function_583ec468() {
    level thread function_34122388();
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_34122388
// Checksum 0xe2c7c29c, Offset: 0xe50
// Size: 0x1d4
function function_34122388() {
    level thread function_7bd90791("digger_hangar_blocker", "hangar_digger_switch", "start_hangar_digger", "hangar_digger_hacked", "hangar_digger_hacked_before_breached", "hangar_breached", &function_81ac11, "hangar");
    level thread function_7bd90791("digger_teleporter_blocker", "teleporter_digger_switch", "start_teleporter_digger", "teleporter_digger_hacked", "teleporter_digger_hacked_before_breached", "teleporter_breached", &function_81ac11, "teleporter");
    level thread function_7bd90791(undefined, "biodome_digger_switch", "start_biodome_digger", "biodome_digger_hacked", "biodome_digger_hacked_before_breached", "biodome_breached", &function_3b33179c, "biodome");
    level thread function_a6dd3f5b();
    level thread function_efd48321();
    var_3943b1da = getentarray("digger_body", "targetname");
    level function_c497263d();
    array::thread_all(var_3943b1da, &function_3700ca5e);
    level thread function_e5e6daea();
    wait(0.5);
    level flag::clear("init_diggers");
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_c497263d
// Checksum 0xe351979f, Offset: 0x1030
// Size: 0x44c
function function_c497263d() {
    for (i = 0; i < 3; i++) {
        switch (i) {
        case 0:
            var_794a1037 = "biodome_digger_stopped";
            var_3d838929 = "lgt_exploder_digger_biodome";
            var_ebcc585f = "lgt_exploder_dig_biodome_alt";
            var_575a869f = "lgt_exploder_dig_biodome_arrived";
            var_f78a8481 = "biodome_digger_body_lights";
            var_7dbee661 = "biodome_digger_arm_lights";
            break;
        case 1:
            var_794a1037 = "teleporter_digger_stopped";
            var_3d838929 = "lgt_exploder_digger_teleporter";
            var_ebcc585f = "lgt_exploder_dig_teleporter_alt";
            var_575a869f = "lgt_exploder_dig_teleporter_arrived";
            var_f78a8481 = "teleporter_digger_body_lights";
            var_7dbee661 = "teleporter_digger_arm_lights";
            break;
        case 2:
            var_794a1037 = "stop_hangar_digger";
            var_3d838929 = "lgt_exploder_digger_hangar";
            var_ebcc585f = "lgt_exploder_dig_hangar_alt";
            var_575a869f = "lgt_exploder_dig_hangar_arrived";
            var_f78a8481 = "hangar_digger_body_lights";
            var_7dbee661 = "hangar_digger_arm_lights";
            break;
        }
        var_beb7660e = getent(var_794a1037, "script_string");
        var_beb7660e.var_3d838929 = var_3d838929;
        var_beb7660e.var_ebcc585f = var_ebcc585f;
        var_beb7660e.var_575a869f = var_575a869f;
        var_a68e698 = undefined;
        var_f31f3fa4 = getentarray(var_beb7660e.target, "targetname");
        foreach (mdl_target in var_f31f3fa4) {
            if (mdl_target.model == "p7_zm_moo_crane_mining_arm") {
                var_beb7660e.var_26dbb029 = mdl_target;
                var_a68e698 = mdl_target;
                break;
            }
        }
        var_d0939dba = getentarray(var_f78a8481, "targetname");
        var_beb7660e.var_d0939dba = var_d0939dba;
        foreach (e_light in var_d0939dba) {
            e_light linkto(var_beb7660e);
        }
        if (isdefined(var_a68e698)) {
            var_3b91d0ec = getentarray(var_7dbee661, "targetname");
            var_a68e698.var_3b91d0ec = var_3b91d0ec;
            foreach (e_light in var_3b91d0ec) {
                e_light linkto(var_a68e698);
            }
        }
    }
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_efd48321
// Checksum 0x442e4a69, Offset: 0x1488
// Size: 0x2e4
function function_efd48321() {
    level endon(#"hash_37cc5047");
    level flag::wait_till("power_on");
    wait(30);
    var_4a84f147 = level.round_number;
    var_4af90c8e = 0;
    if (randomint(100) >= 90) {
        function_f257c559();
        var_4a84f147 = level.round_number;
        var_4af90c8e = 1;
    }
    for (rnd = 0; !var_4af90c8e; rnd++) {
        level waittill(#"between_round_over");
        if (level flag::exists("teleporter_used") && level flag::get("teleporter_used")) {
            continue;
        }
        if (randomint(100) >= 90 || rnd > 2) {
            function_f257c559();
            var_4a84f147 = level.round_number;
            var_4af90c8e = 1;
        }
    }
    while (true) {
        level waittill(#"between_round_over");
        if (level flag::exists("teleporter_used") && level flag::get("teleporter_used")) {
            continue;
        }
        if (level flag::get("digger_moving")) {
            continue;
        }
        if (level.round_number < 10) {
            var_9a8e492 = 3;
            var_18eb9cdc = 8;
        } else {
            var_9a8e492 = 2;
            var_18eb9cdc = 8;
        }
        diff = abs(level.round_number - var_4a84f147);
        if (diff >= var_9a8e492 && diff < var_18eb9cdc) {
            if (randomint(100) >= 80) {
                function_f257c559();
                var_4a84f147 = level.round_number;
            }
            continue;
        }
        if (diff >= var_18eb9cdc) {
            function_f257c559();
            var_4a84f147 = level.round_number;
        }
    }
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_f257c559
// Checksum 0xa5e2f855, Offset: 0x1778
// Size: 0x1dc
function function_f257c559(var_9500b0cb) {
    if (isdefined(var_9500b0cb)) {
        level flag::set("start_" + var_9500b0cb + "_digger");
        level thread function_d3f24b48(var_9500b0cb, 0);
        level thread function_88e64937(var_9500b0cb);
        wait(1);
        level notify(var_9500b0cb + "_vox_timer_stop");
        level thread function_c3fd2aff(var_9500b0cb);
        return;
    }
    var_19e36857 = [];
    for (i = 0; i < level.var_3943b1da.size; i++) {
        if (!level flag::get("start_" + level.var_3943b1da[i] + "_digger")) {
            var_19e36857[var_19e36857.size] = level.var_3943b1da[i];
        }
    }
    if (var_19e36857.size > 0) {
        var_c994f73b = array::random(var_19e36857);
        level flag::set("start_" + var_c994f73b + "_digger");
        level thread function_d3f24b48(var_c994f73b, 0);
        level thread function_88e64937(var_c994f73b);
        wait(1);
        level thread function_c3fd2aff(var_c994f73b);
    }
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_88e64937
// Checksum 0xef32ed6c, Offset: 0x1960
// Size: 0xac
function function_88e64937(var_1873609b) {
    level thread namespace_fd83f37::function_5e318772("vox_mcomp_digger_start_", var_1873609b);
    wait(7);
    if (!(isdefined(level.var_5f225972) && level.var_5f225972)) {
        return;
    }
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("digger", "incoming");
}

// Namespace namespace_98c95ca3
// Params 2, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_d3f24b48
// Checksum 0x11b1f013, Offset: 0x1a18
// Size: 0x10e
function function_d3f24b48(var_1873609b, pause) {
    switch (var_1873609b) {
    case 20:
        if (!pause) {
            util::clientnotify("Dz3");
        } else {
            util::clientnotify("Dz3e");
        }
        break;
    case 21:
        if (!pause) {
            util::clientnotify("Dz2");
        } else {
            util::clientnotify("Dz2e");
        }
        break;
    case 19:
        if (!pause) {
            util::clientnotify("Dz5");
        } else {
            util::clientnotify("Dz5e");
        }
        break;
    }
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_3700ca5e
// Checksum 0x98f24a38, Offset: 0x1b30
// Size: 0x58c
function function_3700ca5e() {
    targets = getentarray(self.target, "targetname");
    if (targets[0].model == "p7_zm_moo_crane_mining_body_vista") {
        tracks = targets[0];
        arm = targets[1];
    } else {
        arm = targets[0];
        tracks = targets[1];
    }
    if (self.script_string == "teleporter_digger_stopped") {
        tracks = targets[0];
        arm = targets[1];
    } else {
        arm = targets[0];
        tracks = targets[1];
    }
    var_8d95170f = getent(arm.target, "targetname");
    blade = getent(var_8d95170f.target, "targetname");
    blade linkto(var_8d95170f);
    var_8d95170f linkto(arm);
    arm linkto(self);
    self linkto(tracks);
    tracks clientfield::set("digger_moving", 0);
    arm clientfield::set("digger_arm_fx", 0);
    exploder::delete_exploder_on_clients(self.var_3d838929);
    self.arm = arm;
    switch (tracks.target) {
    case 74:
        self.var_1873609b = "hangar";
        self.var_d29700f5 = -45;
        self.up_angle = 45;
        self.zones = array("cata_right_start_zone", "cata_right_middle_zone", "cata_right_end_zone");
        break;
    case 73:
        self.var_1873609b = "teleporter";
        self.var_d29700f5 = -52;
        self.up_angle = 52;
        self.zones = array("cata_left_middle_zone", "cata_left_start_zone");
        self.var_2b7d2064 = 0;
        break;
    case 72:
        self.var_1873609b = "biodome";
        self.var_d29700f5 = -20;
        self.up_angle = 20;
        self.zones = array("forest_zone");
        break;
    }
    self.var_17841a3a = self.var_1873609b + "_digger_hacked";
    self.var_fe977b51 = self.var_1873609b + "_digger_hacked_before_breached";
    self.var_b8e5b06e = self.var_1873609b + "_breached";
    self.start_flag = "start_" + self.var_1873609b + "_digger";
    self.var_2b7d2064 = 0;
    tracks function_2bb21065(self, undefined, arm);
    self endon(self.var_1873609b + "_digger_hacked");
    self stoploopsound(2);
    self playsound("evt_dig_move_stop");
    self unlink();
    level.var_8c7eb10b = 11;
    level.var_707d5f0c = 80;
    level.var_659ba770 = 1;
    var_dd8605a5 = randomintrange(-1, 1);
    var_860340f9 = max(1, abs(var_dd8605a5)) * 0.3;
    arm unlink();
    arm.og_angles = arm.angles;
    self thread function_4b1beba1(arm, var_8d95170f, tracks);
    self thread function_56fe869a(arm, var_8d95170f, tracks);
    self thread function_e6b78977(arm, var_8d95170f, tracks);
}

// Namespace namespace_98c95ca3
// Params 3, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_4b1beba1
// Checksum 0x1d360f41, Offset: 0x20c8
// Size: 0x10c
function function_4b1beba1(arm, var_8d95170f, tracks) {
    self endon(#"hash_dc4741ca");
    self waittill(#"hash_519d0063");
    exploder::delete_exploder_on_clients(self.var_575a869f);
    var_8d95170f linkto(arm);
    arm linkto(self);
    self linkto(tracks);
    tracks function_2bb21065(self, 1, arm);
    level flag::clear(self.var_17841a3a);
    level flag::clear(self.start_flag);
    self thread function_3700ca5e();
}

// Namespace namespace_98c95ca3
// Params 3, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_56fe869a
// Checksum 0xf9479a4a, Offset: 0x21e0
// Size: 0xbc
function function_56fe869a(arm, var_8d95170f, tracks) {
    self endon(#"hash_aade995f");
    while (true) {
        var_1873609b = level waittill(#"hash_afbd2526");
        if (var_1873609b == self.var_1873609b) {
            level flag::clear(self.var_17841a3a);
            level flag::clear(self.start_flag);
            self notify(#"hash_dc4741ca");
            self thread function_3700ca5e();
            break;
        }
    }
}

// Namespace namespace_98c95ca3
// Params 3, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_c1bda8ef
// Checksum 0xe11dabd9, Offset: 0x22a8
// Size: 0x5b6
function function_c1bda8ef(arm, var_8d95170f, tracks) {
    self endon(self.var_17841a3a);
    wait(8);
    if (level flag::get(self.var_17841a3a)) {
        return;
    }
    level notify(#"hash_1137a109", self.var_1873609b, self.zones);
    switch (self.var_1873609b) {
    case 20:
        exploder::exploder("fxexp_101");
        level flag::set("hangar_breached");
        level flag::set("hangar_blocked");
        if (isdefined(level.var_91fcdd2c)) {
            level.var_91fcdd2c show();
        }
        earthquake(0.5, 3, level.var_91fcdd2c.origin, 1500);
        util::clientnotify("sl1");
        util::clientnotify("sl7");
        level.zones["cata_right_start_zone"].adjacent_zones["cata_right_middle_zone"].is_connected = 0;
        level.zones["cata_right_middle_zone"].adjacent_zones["cata_right_start_zone"].is_connected = 0;
        break;
    case 21:
        exploder::exploder("fxexp_111");
        level flag::set("teleporter_breached");
        level flag::set("teleporter_blocked");
        if (isdefined(level.var_b486df40)) {
            level.var_b486df40 show();
        }
        earthquake(0.5, 3, level.var_b486df40.origin, 1500);
        util::clientnotify("sl2");
        util::clientnotify("sl3");
        level.zones["airlock_west2_zone"].adjacent_zones["cata_left_middle_zone"].is_connected = 0;
        level.zones["cata_left_middle_zone"].adjacent_zones["airlock_west2_zone"].is_connected = 0;
        break;
    case 19:
        break;
    }
    if (level flag::get("hangar_breached") && level flag::get("teleporter_breached")) {
        level flag::set("both_tunnels_breached");
    }
    if (level flag::get("teleporter_blocked") && level flag::get("hangar_blocked")) {
        level flag::set("both_tunnels_blocked");
    } else {
        level flag::clear("both_tunnels_blocked");
    }
    arm waittill(#"rotatedone");
    arm playsound("evt_dig_arm_stop");
    var_8d95170f unlink();
    switch (self.var_1873609b) {
    case 20:
        var_8d95170f playloopsound("evt_dig_wheel_loop1", 1);
        break;
    case 21:
        var_8d95170f playloopsound("evt_dig_wheel_loop1", 1);
        break;
    case 19:
        var_8d95170f playloopsound("evt_dig_wheel_loop2", 1);
        break;
    }
    var_8d95170f clientfield::set("digger_digging", 1);
    var_8d95170f rotatepitch(720, 5, level.var_659ba770, level.var_659ba770);
    var_3ef9f2b0 = (0, arm.angles[1] + -76, arm.angles[2]);
    forward = anglestoforward(var_3ef9f2b0);
    wait(2);
    self.var_aad1a032 = undefined;
}

// Namespace namespace_98c95ca3
// Params 3, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_e6b78977
// Checksum 0xc0a4936e, Offset: 0x2868
// Size: 0x57a
function function_e6b78977(arm, var_8d95170f, tracks) {
    arm clientfield::set("digger_arm_fx", 1);
    tracks clientfield::set("digger_moving", 1);
    exploder::exploder(self.var_3d838929);
    exploder::exploder(self.var_575a869f);
    if (!level flag::get(self.var_17841a3a)) {
        if (!(isdefined(self.var_2b7d2064) && self.var_2b7d2064)) {
            self notify(#"hash_aade995f");
            self.var_2b7d2064 = 1;
            self.var_aad1a032 = 1;
            arm unlink();
            arm playsound("evt_dig_arm_move");
            arm rotatepitch(self.var_d29700f5, level.var_8c7eb10b, level.var_8c7eb10b / 4, level.var_8c7eb10b / 4);
            self thread function_c1bda8ef(arm, var_8d95170f, tracks);
        }
        while (!level flag::get(self.var_17841a3a)) {
            if (!var_8d95170f islinkedto(arm)) {
                var_8d95170f rotatepitch(360, 3);
            }
            wait(3);
        }
    }
    while (isdefined(self.var_aad1a032) && self.var_aad1a032 && !level flag::get(self.var_17841a3a)) {
        wait(0.1);
    }
    if (isdefined(self.var_2b7d2064) && self.var_2b7d2064) {
        self.var_aad1a032 = 1;
        self.var_2b7d2064 = 0;
        var_8d95170f stoploopsound(2);
        var_8d95170f clientfield::set("digger_digging", 0);
        var_8d95170f linkto(arm);
        arm playsound("evt_dig_arm_move");
        arm rotatepitch(self.up_angle, level.var_8c7eb10b, level.var_8c7eb10b / 4, level.var_8c7eb10b / 4);
        wait(2);
        level notify(#"hash_e2c7960", self.var_1873609b);
        switch (self.var_1873609b) {
        case 20:
            exploder::stop_exploder("fxexp_101");
            if (level flag::get("tunnel_11_door1")) {
                level.zones["cata_right_start_zone"].adjacent_zones["cata_right_middle_zone"].is_connected = 1;
                level.zones["cata_right_middle_zone"].adjacent_zones["cata_right_start_zone"].is_connected = 1;
            }
            level flag::clear("hangar_blocked");
            level flag::clear("both_tunnels_blocked");
            break;
        case 21:
            exploder::stop_exploder("fxexp_111");
            if (level flag::get("catacombs_west4")) {
                level.zones["airlock_west2_zone"].adjacent_zones["cata_left_middle_zone"].is_connected = 1;
                level.zones["cata_left_middle_zone"].adjacent_zones["airlock_west2_zone"].is_connected = 1;
            }
            level flag::clear("teleporter_blocked");
            level flag::clear("both_tunnels_blocked");
            break;
        }
        arm waittill(#"rotatedone");
        arm linkto(self);
        arm playsound("evt_dig_arm_stop");
        self.var_aad1a032 = undefined;
        self notify(#"hash_519d0063");
    }
}

// Namespace namespace_98c95ca3
// Params 8, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_7bd90791
// Checksum 0xde988cb5, Offset: 0x2df0
// Size: 0x364
function function_7bd90791(var_87803301, trig_name, start_flag, var_17841a3a, var_fe977b51, var_b8e5b06e, var_927b527a, var_1873609b) {
    if (isdefined(var_87803301)) {
        dmg_trig = getent("digger_" + var_1873609b + "_dmg", "targetname");
        blocker = getent(var_87803301, "targetname");
        if (var_1873609b == "teleporter") {
            dmg_trig.origin += (0, -20, 0);
            blocker.origin += (0, -20, 0);
        }
        level thread [[ var_927b527a ]](blocker, var_1873609b, dmg_trig);
    }
    if (!isdefined(var_87803301) && isdefined(var_927b527a)) {
        level thread [[ var_927b527a ]](var_1873609b);
    }
    trig = getent(trig_name, "targetname");
    struct = spawnstruct();
    struct.origin = trig.origin - (0, 0, 12);
    struct.script_int = -1000;
    struct.script_float = 5;
    struct.var_1873609b = var_1873609b;
    struct.var_17841a3a = var_17841a3a;
    struct.var_fe977b51 = var_fe977b51;
    struct.var_b8e5b06e = var_b8e5b06e;
    struct.start_flag = start_flag;
    struct.var_db47953c = (255, 0, 0);
    struct.radius = 64;
    struct.height = 64;
    struct.var_2cb6d1fc = %ZM_MOON_DISABLE_DIGGER;
    struct.var_39787651 = 1;
    struct.var_9aa3be3b = 1;
    trig usetriggerrequirelookat();
    trig setcursorhint("HINT_NOICON");
    trig thread namespace_6d813654::function_4edfe9fb();
    trig sethintstring(%ZM_MOON_NO_HACK);
    trig thread function_bd81d4d9(start_flag, var_17841a3a, struct);
}

// Namespace namespace_98c95ca3
// Params 3, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_bd81d4d9
// Checksum 0xa77f8452, Offset: 0x3160
// Size: 0x2a8
function function_bd81d4d9(start_flag, var_17841a3a, struct) {
    while (true) {
        if (!level flag::get(start_flag)) {
            namespace_6d813654::function_fcbe2f17(struct);
            self sethintstring(%ZM_MOON_NO_HACK);
        }
        level flag::wait_till(start_flag);
        if (!level flag::get(var_17841a3a)) {
            namespace_6d813654::function_66764564(struct, &function_62213886, &function_8483b0fd);
            self sethintstring(%ZM_MOON_SYSTEM_ONLINE);
            switch (struct.var_1873609b) {
            case 20:
                level clientfield::set("HCA", 1);
                break;
            case 21:
                level clientfield::set("TCA", 1);
                break;
            case 19:
                level clientfield::set("BCA", 1);
                break;
            }
        }
        level flag::wait_till(var_17841a3a);
        namespace_6d813654::function_fcbe2f17(struct);
        self sethintstring(%ZM_MOON_NO_HACK);
        switch (struct.var_1873609b) {
        case 20:
            level clientfield::set("HCA", 0);
            break;
        case 21:
            level clientfield::set("TCA", 0);
            break;
        case 19:
            level clientfield::set("BCA", 0);
            break;
        }
        level flag::wait_till_clear(var_17841a3a);
        wait(0.05);
    }
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_62213886
// Checksum 0x38fe3e38, Offset: 0x3410
// Size: 0x13a
function function_62213886(hacker) {
    level thread function_d3f24b48(self.var_1873609b, 1);
    hacker thread zm_audio::create_and_play_dialog("digger", "hacked");
    level thread function_3dfd2854(self.var_1873609b);
    level flag::set(self.var_17841a3a);
    if (!level flag::get(self.var_b8e5b06e)) {
        level flag::set(self.var_fe977b51);
    }
    level notify(self.var_1873609b + "_vox_timer_stop");
    while (true) {
        var_1873609b = level waittill(#"hash_936a1fb6");
        if (var_1873609b == self.var_1873609b) {
            break;
        }
    }
    level notify(#"hash_afbd2526", self.var_1873609b);
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_3dfd2854
// Checksum 0x120ca481, Offset: 0x3558
// Size: 0x34
function function_3dfd2854(var_19127c3b) {
    wait(4);
    level thread namespace_fd83f37::function_5e318772("vox_mcomp_digger_hacked_", var_19127c3b);
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_8483b0fd
// Checksum 0x65b20db0, Offset: 0x3598
// Size: 0x36
function function_8483b0fd(player) {
    if (!level flag::get(self.var_17841a3a)) {
        return true;
    }
    return false;
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_3b33179c
// Checksum 0x48d2987e, Offset: 0x35d8
// Size: 0x14e
function function_3b33179c(var_1873609b) {
    while (true) {
        name, zones = level waittill(#"hash_1137a109");
        if (name == var_1873609b) {
            level flag::set("biodome_breached");
            level thread function_f6d8a091();
            for (i = 0; i < zones.size; i++) {
                zone = zones[i];
                var_7b46c2ad = getentarray(zone, "targetname");
                for (x = 0; x < var_7b46c2ad.size; x++) {
                    var_7b46c2ad[x].script_string = "lowgravity";
                }
                level thread namespace_a9e990ad::function_8820a302(zone);
            }
            break;
        }
    }
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_f6d8a091
// Checksum 0x5252f7, Offset: 0x3730
// Size: 0x6c
function function_f6d8a091() {
    util::clientnotify("BIO");
    level clientfield::set("BIO", 1);
    exploder::exploder("fxexp_200");
    exploder::delete_exploder_on_clients("fxexp_1100");
}

// Namespace namespace_98c95ca3
// Params 3, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_81ac11
// Checksum 0x6bfb6488, Offset: 0x37a8
// Size: 0x1f2
function function_81ac11(blocker, var_1873609b, dmg_trig) {
    dmg_trig triggerenable(0);
    dmg_trig thread function_12acc3ef();
    level thread function_553b8da4(blocker, var_1873609b, dmg_trig);
    while (true) {
        name, zones = level waittill(#"hash_1137a109");
        if (name == var_1873609b) {
            blocker movez(-512, 0.05, 0.05);
            blocker waittill(#"movedone");
            blocker disconnectpaths();
            blocker thread function_ea2c0e1d();
            dmg_trig triggerenable(1);
            for (i = 0; i < zones.size; i++) {
                zone = zones[i];
                var_7b46c2ad = getentarray(zone, "targetname");
                for (x = 0; x < var_7b46c2ad.size; x++) {
                    var_7b46c2ad[x].script_string = "lowgravity";
                }
                level thread namespace_a9e990ad::function_8820a302(zone);
            }
        }
    }
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_12acc3ef
// Checksum 0xd8984f12, Offset: 0x39a8
// Size: 0xe8
function function_12acc3ef() {
    while (true) {
        player = self waittill(#"trigger");
        if (!zombie_utility::is_player_valid(player) && !(isdefined(player.var_b7c1339f) && player.var_b7c1339f)) {
            continue;
        }
        if (!player laststand::player_is_in_laststand()) {
            if (player hasperk("specialty_armorvest")) {
                player dodamage(100, player.origin);
            }
            level thread function_8c738482(self, player);
        }
    }
}

// Namespace namespace_98c95ca3
// Params 2, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_8c738482
// Checksum 0xdbc9c600, Offset: 0x3a98
// Size: 0x24e
function function_8c738482(trig, player) {
    player endon(#"disconnect");
    player.var_b7c1339f = 1;
    var_39c349d3 = trig.origin;
    var_c90aa992 = trig.origin;
    var_601feca6 = trig.origin;
    var_85312e91 = 50;
    var_1848d0a6 = player geteye();
    dist = distance(var_39c349d3, var_1848d0a6);
    scale = 1 - dist / var_85312e91;
    if (scale < 0) {
        scale = 0;
    }
    pulse = randomintrange(20, 45);
    dir = (player.origin[0] - trig.origin[0], player.origin[1] - trig.origin[1], 0);
    dir = vectornormalize(dir);
    dir += (0, 0, 1);
    dir *= pulse;
    player setorigin(player.origin + (0, 0, 0.1));
    player_velocity = dir;
    player setvelocity(player_velocity);
    wait(2);
    player.var_b7c1339f = undefined;
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_ea2c0e1d
// Checksum 0x2aabfe7d, Offset: 0x3cf0
// Size: 0x184
function function_ea2c0e1d() {
    self endon(#"hash_cfd9e60");
    while (true) {
        if (isdefined(self.trigger_off)) {
            wait(0.05);
            continue;
        }
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (players[i] istouching(self)) {
                if (!players[i] laststand::player_is_in_laststand()) {
                    players[i] function_29d71ba8();
                }
            }
        }
        zombies = getaiarray();
        for (i = 0; i < zombies.size; i++) {
            if (isdefined(zombies[i]) && zombies[i] istouching(self)) {
                zombies[i] thread function_de5622c8();
                util::wait_network_frame();
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_29d71ba8
// Checksum 0xad9177c9, Offset: 0x3e80
// Size: 0x1c
function function_29d71ba8() {
    self thread namespace_3dc929b6::function_8678e513();
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_de5622c8
// Checksum 0x89bc86ef, Offset: 0x3ea8
// Size: 0xdc
function function_de5622c8() {
    self endon(#"death");
    fwd = anglestoforward(zm_utility::flat_angle(self.angles));
    var_3df26f9f = vectorscale(fwd, -56);
    var_615f7c66 = (var_3df26f9f[0], var_3df26f9f[1], 20);
    self launchragdoll(var_615f7c66, self.origin);
    util::wait_network_frame();
    self dodamage(self.health + 666, self.origin);
}

// Namespace namespace_98c95ca3
// Params 3, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_553b8da4
// Checksum 0xcaabade4, Offset: 0x3f90
// Size: 0xb8
function function_553b8da4(blocker, var_1873609b, dmg_trig) {
    while (true) {
        name = level waittill(#"hash_e2c7960");
        if (name == var_1873609b) {
            blocker connectpaths();
            blocker movez(512, 0.05, 0.05);
            dmg_trig triggerenable(0);
            blocker notify(#"hash_cfd9e60");
        }
    }
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_a6dd3f5b
// Checksum 0x95af6c82, Offset: 0x4050
// Size: 0xc0
function function_a6dd3f5b() {
    level endon(#"intermission");
    var_3943b1da = getentarray("digger_body", "targetname");
    while (true) {
        level flag::wait_till("enter_nml");
        array::thread_all(var_3943b1da, &function_58d10195, 0);
        flag::wait_till_clear("enter_nml");
        array::thread_all(var_3943b1da, &function_58d10195, 1);
    }
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_58d10195
// Checksum 0x680b595e, Offset: 0x4118
// Size: 0x26c
function function_58d10195(visible) {
    targets = getentarray(self.target, "targetname");
    if (targets[0].model == "p7_zm_moo_crane_mining_body_vista") {
        tracks = targets[0];
        arm = targets[1];
    } else {
        arm = targets[0];
        tracks = targets[1];
    }
    if (self.script_string == "teleporter_digger_stopped") {
        tracks = targets[0];
        arm = targets[1];
    } else {
        arm = targets[0];
        tracks = targets[1];
    }
    var_8d95170f = getent(arm.target, "targetname");
    blade = getent(var_8d95170f.target, "targetname");
    if (!visible) {
        level clientfield::set("DH", 1);
        blade hide();
        arm hide();
        tracks hide();
        self hide();
        return;
    }
    level clientfield::set("DH", 0);
    blade function_267c538a();
    arm function_267c538a();
    tracks function_267c538a();
    self function_267c538a();
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_267c538a
// Checksum 0x18428e03, Offset: 0x4390
// Size: 0xa2
function function_267c538a() {
    self show();
    foreach (player in level.players) {
        player givededicatedshadow(self);
    }
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_c3fd2aff
// Checksum 0x73d95691, Offset: 0x4440
// Size: 0x1fc
function function_c3fd2aff(var_1873609b) {
    level endon(var_1873609b + "_vox_timer_stop");
    time_left = level.var_d00ac1bc;
    var_4edf5e50 = 0;
    var_8f86e1c6 = 0;
    var_c4b9b009 = 0;
    var_52e687b0 = 0;
    var_1f3059da = gettime();
    while (time_left > 0) {
        curr_time = gettime();
        var_9de18ef6 = (curr_time - var_1f3059da) / 1000;
        time_left = level.var_d00ac1bc - var_9de18ef6;
        if (time_left <= 180 && !var_4edf5e50) {
            level thread namespace_fd83f37::function_5e318772("vox_mcomp_digger_start_", var_1873609b);
            var_4edf5e50 = 1;
        }
        if (time_left <= 120 && !var_8f86e1c6) {
            level thread namespace_fd83f37::function_5e318772("vox_mcomp_digger_start_", var_1873609b);
            var_8f86e1c6 = 1;
        }
        if (time_left <= 60 && !var_c4b9b009) {
            level thread namespace_fd83f37::function_5e318772("vox_mcomp_digger_time_60_", var_1873609b);
            var_c4b9b009 = 1;
        }
        if (time_left <= 30 && !var_52e687b0) {
            level thread namespace_fd83f37::function_5e318772("vox_mcomp_digger_time_30_", var_1873609b);
            var_52e687b0 = 1;
        }
        wait(1);
    }
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x0
// namespace_98c95ca3<file_0>::function_e8bb02b7
// Checksum 0x567022b8, Offset: 0x4648
// Size: 0x5c
function function_e8bb02b7(var_19127c3b) {
    level endon(#"hash_1137a109");
    for (i = 0; i < 500; i++) {
        iprintlnbold(i);
        wait(1);
    }
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_e5e6daea
// Checksum 0x76eaaf47, Offset: 0x46b0
// Size: 0x80
function function_e5e6daea() {
    while (true) {
        var_19127c3b, zones = level waittill(#"hash_1137a109");
        level thread function_e2291272(var_19127c3b);
        level thread function_7be2d810(var_19127c3b);
        level thread function_7041b4ac(zones);
    }
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_7be2d810
// Checksum 0x1d078abb, Offset: 0x4738
// Size: 0x1ce
function function_7be2d810(var_19127c3b) {
    switch (var_19127c3b) {
    case 20:
        level clientfield::increment("Az3b");
        level.var_778c3308["3b"] = 1;
        level flag::wait_till("tunnel_11_door1");
        level clientfield::increment("Az3a");
        level.var_778c3308["3a"] = 1;
        level flag::wait_till("tunnel_11_door2");
        level clientfield::increment("Az3c");
        level.var_778c3308["3c"] = 1;
        break;
    case 21:
        level clientfield::increment("Az2b");
        level.var_778c3308["2b"] = 1;
        level flag::wait_till("tunnel_6_door1");
        level clientfield::increment("Az2a");
        level.var_778c3308["2a"] = 1;
        break;
    case 19:
        level clientfield::increment("Az5");
        level.var_778c3308["5"] = 1;
        break;
    }
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_e2291272
// Checksum 0xa942f213, Offset: 0x4910
// Size: 0xbc
function function_e2291272(var_19127c3b) {
    if (!level.var_5f225972) {
        return;
    }
    playsoundatposition("evt_breach_alarm", (0, 0, 0));
    wait(1.5);
    if (!level.var_5f225972) {
        return;
    }
    playsoundatposition("evt_breach_alarm", (0, 0, 0));
    wait(1.5);
    if (!level.var_5f225972) {
        return;
    }
    playsoundatposition("evt_breach_alarm", (0, 0, 0));
    wait(2);
    level thread namespace_fd83f37::function_5e318772("vox_mcomp_digger_breach_", var_19127c3b);
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_7041b4ac
// Checksum 0xc325dd22, Offset: 0x49d8
// Size: 0x15a
function function_7041b4ac(zones) {
    players = getplayers();
    for (i = 0; i < zones.size; i++) {
        zone = zones[i];
        var_7b46c2ad = getentarray(zone, "targetname");
        for (x = 0; x < var_7b46c2ad.size; x++) {
            for (j = 0; j < players.size; j++) {
                if (zombie_utility::is_player_valid(players[j]) && players[j] istouching(var_7b46c2ad[x])) {
                    players[j] thread zm_audio::create_and_play_dialog("digger", "breach");
                }
            }
        }
    }
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_b42cb602
// Checksum 0xa2def36d, Offset: 0x4b40
// Size: 0x11e
function function_b42cb602(start_node) {
    start_node.previous_node = undefined;
    linked_nodes = [];
    linked_nodes[linked_nodes.size] = start_node;
    cur_node = start_node;
    while (true) {
        if (isdefined(cur_node.target)) {
            next_node = getvehiclenode(cur_node.target, "targetname");
            previous_node = cur_node;
            cur_node.next_node = next_node;
            cur_node = getvehiclenode(cur_node.target, "targetname");
            cur_node.previous_node = previous_node;
            linked_nodes[linked_nodes.size] = cur_node;
            continue;
        }
        break;
    }
    return linked_nodes;
}

// Namespace namespace_98c95ca3
// Params 3, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_7ef2b10a
// Checksum 0x251b7996, Offset: 0x4c68
// Size: 0x64
function function_7ef2b10a(origin, color, time) {
    /#
        if (!isdefined(time)) {
            time = 1000;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        debugstar(origin, time, color);
    #/
}

// Namespace namespace_98c95ca3
// Params 0, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_f3e06bd3
// Checksum 0x69539a04, Offset: 0x4cd8
// Size: 0x150
function function_f3e06bd3() {
    path_start_node = getvehiclenode(self.target, "targetname");
    var_7f566780 = 0;
    self.var_52cc5b1f = 0;
    start_node = path_start_node;
    while (isdefined(start_node.target)) {
        next_node = getvehiclenode(start_node.target, "targetname");
        if (isdefined(next_node)) {
            length = length(next_node.origin - start_node.origin);
            self.var_52cc5b1f += length;
            start_node = next_node;
            function_7ef2b10a(start_node.origin, (1, 1, 1), 1000);
            var_7f566780++;
        }
    }
    self.var_194457df = self.var_52cc5b1f / level.var_d00ac1bc;
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_86fb2310
// Checksum 0x6339ceeb, Offset: 0x4e30
// Size: 0x17c
function function_86fb2310(path_start_node) {
    var_7f566780 = 0;
    self.var_52cc5b1f = 0;
    start_node = path_start_node;
    while (isdefined(start_node.target)) {
        next_node = getvehiclenode(start_node.target, "targetname");
        if (isdefined(next_node)) {
            length = length(next_node.origin - start_node.origin);
            self.var_52cc5b1f += length;
            start_node = next_node;
            function_7ef2b10a(start_node.origin, (1, 1, 1), 1000);
            var_7f566780++;
        }
    }
    curr_time = gettime();
    var_9de18ef6 = (curr_time - self.start_time) / 1000;
    time_left = level.var_d00ac1bc - var_9de18ef6;
    self.var_194457df = self.var_52cc5b1f / time_left;
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_7b5ffa5e
// Checksum 0x30df0681, Offset: 0x4fb8
// Size: 0x15c
function function_7b5ffa5e(var_b4ecbf81) {
    /#
        elem = newhudelem();
        elem.hidewheninmenu = 1;
        elem.horzalign = "biodome_digger_hacked_before_breached";
        elem.vertalign = "biodome_digger_hacked_before_breached";
        elem.alignx = "biodome_digger_hacked_before_breached";
        elem.aligny = "biodome_digger_hacked_before_breached";
        elem.x = 0;
        elem.y = 0;
        elem.foreground = 1;
        elem.font = "biodome_digger_hacked_before_breached";
        elem.fontscale = 2;
        elem.color = (1, 1, 1);
        elem.alpha = 1;
        elem settimer(var_b4ecbf81);
        wait(var_b4ecbf81 + 3);
        elem destroy();
    #/
}

// Namespace namespace_98c95ca3
// Params 3, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_2bb21065
// Checksum 0x6c83f305, Offset: 0x5120
// Size: 0xd62
function function_2bb21065(body, reverse, arm) {
    var_8337b6f4 = undefined;
    var_183d9ca1 = undefined;
    direction = undefined;
    fraction = 0;
    var_e2d3866f = 0;
    path_start_node = getvehiclenode(self.target, "targetname");
    linked_nodes = function_b42cb602(path_start_node);
    self thread function_f3e06bd3();
    if (level flag::get("init_diggers")) {
        self.origin = path_start_node.origin;
        self.angles = path_start_node.angles;
    }
    if (isdefined(body.start_flag)) {
        level flag::wait_till(body.start_flag);
    }
    if (!isdefined(reverse)) {
        current_node = path_start_node;
        next_node = linked_nodes[0].next_node;
        fx_name = "digger_treadfx_fwd";
        level flag::set("digger_moving");
    } else {
        current_node = linked_nodes[linked_nodes.size - 1];
        next_node = linked_nodes[linked_nodes.size - 1].previous_node;
        fx_name = "digger_treadfx_bkwd";
        self.var_194457df = 5;
        level flag::clear("digger_moving");
    }
    body playsound("evt_dig_move_start");
    self clientfield::set("digger_moving", 1);
    arm clientfield::set("digger_arm_fx", 1);
    exploder::exploder(body.var_3d838929);
    exploder::exploder(body.var_ebcc585f);
    body playloopsound("evt_dig_move_loop", 0.5);
    if (body.var_1873609b == "hangar") {
        exploder::exploder("fxexp_102");
    } else if (body.var_1873609b == "teleporter") {
        exploder::exploder("fxexp_112");
    }
    self.start_time = gettime();
    level thread function_7b5ffa5e(level.var_d00ac1bc);
    while (!var_e2d3866f) {
        if (level flag::get(body.var_17841a3a)) {
            direction = "bkwd";
            if (level flag::get("digger_moving")) {
                level flag::clear("digger_moving");
            }
        } else {
            if (!level flag::get("digger_moving")) {
                level flag::set("digger_moving");
            }
            direction = "fwd";
        }
        var_40925d18 = (1, 0, 0);
        if (isdefined(var_8337b6f4)) {
            var_40925d18 = current_node.origin - var_8337b6f4.origin;
            var_40925d18 = vectornormalize(var_40925d18);
        } else {
            var_40925d18 = anglestoforward(self.angles);
        }
        var_2c916324 = next_node.origin - current_node.origin;
        var_2c916324 = vectornormalize(var_2c916324);
        if (direction == "fwd") {
            if (isdefined(current_node.next_node) && isdefined(current_node.next_node.next_node)) {
                var_183d9ca1 = current_node.next_node.next_node.origin - next_node.origin;
            } else {
                end_time = gettime();
                total_time = end_time - self.start_time;
                var_e2d3866f = 1;
            }
        } else if (isdefined(current_node.previous_node) && isdefined(current_node.previous_node.previous_node)) {
            var_183d9ca1 = current_node.previous_node.previous_node.origin - next_node.origin;
        } else {
            end_time = gettime();
            total_time = end_time - self.start_time;
            var_e2d3866f = 1;
        }
        var_183d9ca1 = vectornormalize(var_183d9ca1);
        var_e85ecb02 = var_2c916324 + var_183d9ca1;
        var_e85ecb02 = vectornormalize(var_e85ecb02);
        var_fee2b807 = var_40925d18 + var_2c916324;
        var_fee2b807 = vectornormalize(var_fee2b807);
        origin = self.origin;
        var_18293161 = origin - current_node.origin;
        var_597f7512 = next_node.origin - origin;
        var_20200d20 = vectordot(var_18293161, var_fee2b807);
        d2 = vectordot(var_597f7512, var_e85ecb02);
        if (d2 < 0) {
            var_8337b6f4 = current_node;
            current_node = next_node;
            if (direction == "fwd") {
                next_node = current_node.next_node;
                self thread function_86fb2310(current_node);
                continue;
            } else {
                next_node = current_node.previous_node;
                self thread function_86fb2310(current_node);
                continue;
            }
        } else if (var_20200d20 < 0) {
            var_20200d20 = vectordot(var_2c916324, var_18293161);
            if (var_20200d20 < 0) {
                fraction = 0;
            } else {
                var_d5be9527 = length(next_node.origin - current_node.origin);
                dist = length(var_597f7512);
                fraction = 1 - dist / var_d5be9527;
                fraction = math::clamp(fraction, 0, 1);
                if (fraction > 0.95) {
                    var_8337b6f4 = current_node;
                    current_node = next_node;
                    if (direction == "fwd") {
                        next_node = current_node.next_node;
                        self thread function_86fb2310(current_node);
                        continue;
                    } else {
                        next_node = current_node.previous_node;
                        self thread function_86fb2310(current_node);
                        continue;
                    }
                }
            }
        }
        fraction = var_20200d20 / (var_20200d20 + d2);
        speed = current_node.speed + (next_node.speed - current_node.speed) * fraction;
        speed = speed * 0.5 * level.var_4b290403;
        var_5a2edc36 = current_node.lookahead + (next_node.lookahead - current_node.lookahead) * fraction;
        var_acd781bf = current_node.lookahead * speed;
        var_88037f44 = length(next_node.origin - current_node.origin);
        dist = fraction * var_88037f44 + var_acd781bf;
        look_pos = (0, 0, 0);
        if (dist > var_88037f44) {
            delta = dist - var_88037f44;
            look_pos = next_node.origin + var_183d9ca1 * delta;
        } else {
            look_pos = self.origin + var_2c916324 * dist;
        }
        var_6534c00 = vectornormalize(look_pos - self.origin);
        if (direction == "fwd") {
            velocity = var_6534c00 * self.var_194457df * level.var_4b290403;
        } else {
            velocity = var_6534c00 * speed;
        }
        self.origin += velocity * 0.05;
        var_5a2edc36 = current_node.lookahead + (next_node.lookahead - current_node.lookahead) * fraction;
        self.angles = current_node.angles + (next_node.angles - current_node.angles) * fraction;
        wait(0.05);
    }
    if (body.var_1873609b == "hangar") {
        exploder::stop_exploder("fxexp_102");
    } else if (body.var_1873609b == "teleporter") {
        exploder::stop_exploder("fxexp_112");
    }
    self clientfield::set("digger_moving", 0);
    arm clientfield::set("digger_arm_fx", 0);
    exploder::delete_exploder_on_clients(body.var_3d838929);
    exploder::delete_exploder_on_clients(body.var_ebcc585f);
    level flag::clear("digger_moving");
    level notify(#"hash_936a1fb6", body.var_1873609b);
    self notify(#"path_end");
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_babe0dab
// Checksum 0x50e11624, Offset: 0x5e90
// Size: 0x10c
function function_babe0dab(position) {
    if (!level flag::get("both_tunnels_breached")) {
        return false;
    }
    range_squared = 360000;
    var_cc02698b = getent("digger_hangar_blocker", "targetname");
    if (distancesquared(var_cc02698b.origin, position) < range_squared) {
        return true;
    }
    var_685248be = getent("digger_teleporter_blocker", "targetname");
    if (distancesquared(var_685248be.origin, position) < range_squared) {
        return true;
    }
    return false;
}

// Namespace namespace_98c95ca3
// Params 1, eflags: 0x1 linked
// namespace_98c95ca3<file_0>::function_5e5934a9
// Checksum 0x96540ab0, Offset: 0x5fa8
// Size: 0x140
function function_5e5934a9(position) {
    range_squared = 360000;
    var_cc02698b = getent("digger_hangar_blocker", "targetname");
    if (distancesquared(var_cc02698b.origin, position) < range_squared) {
        level flag::set("hangar_digger_hacked");
        [[ level.var_9acc1b55 ]](position);
    }
    var_685248be = getent("digger_teleporter_blocker", "targetname");
    if (distancesquared(var_685248be.origin, position) < range_squared) {
        level flag::set("teleporter_digger_hacked");
        [[ level.var_9acc1b55 ]](position);
    }
}

