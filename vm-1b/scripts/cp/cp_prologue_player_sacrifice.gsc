#using scripts/cp/cp_prologue_util;
#using scripts/cp/cp_prologue_robot_reveal;
#using scripts/cp/cp_prologue_hangars;
#using scripts/cp/cp_prologue_apc;
#using scripts/cp/cp_mi_eth_prologue_accolades;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_835fda7e;

// Namespace namespace_835fda7e
// Params 1, eflags: 0x0
// namespace_835fda7e<file_0>::function_5dcf4c9a
// Checksum 0xd80750cb, Offset: 0x1110
// Size: 0x17a
function function_5dcf4c9a(var_74cd64bc) {
    level flag::wait_till("apc_done");
    function_312356f();
    level thread function_a4e65a71();
    level thread function_d8ccdb23();
    level thread function_e92ad8ae();
    level thread function_cc4c4e16();
    level thread function_10b855b0();
    level thread function_2772c15e();
    level thread function_6ba94a8();
    level thread function_637fae36();
    level thread function_2e776cf4();
    level thread function_b5284617();
    level thread function_21c12b92();
    level.var_27b46342 = arraycombine(getaiteamarray("allies"), level.activeplayers, 0, 0);
    level flag::wait_till("pod_go");
    if (isdefined(level.var_853e9314)) {
        level thread [[ level.var_853e9314 ]]();
    }
    level flag::wait_till("pod_gone");
    skipto::function_be8adfb8("skipto_robot_defend");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_21c12b92
// Checksum 0xe1de5c44, Offset: 0x1298
// Size: 0x73
function function_21c12b92() {
    foreach (player in level.activeplayers) {
        player.var_c34702c6 = 0;
        player thread function_ae9ce6f0();
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_ae9ce6f0
// Checksum 0xeb1d81db, Offset: 0x1318
// Size: 0x63
function function_ae9ce6f0() {
    self endon(#"disconnect");
    self endon(#"hash_99343b5f");
    level endon(#"hash_9d83ef5");
    while (true) {
        wpn_current = self waittill(#"weapon_fired");
        if (wpn_current.weapclass !== "pistol") {
            self.var_c34702c6 = 1;
            self notify(#"hash_99343b5f");
        }
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_fe88fdb1
// Checksum 0x69e2f871, Offset: 0x1388
// Size: 0x7b
function function_fe88fdb1() {
    foreach (player in level.activeplayers) {
        if (!(isdefined(player.var_c34702c6) && player.var_c34702c6)) {
            namespace_61c634f2::function_51c49e5(player);
        }
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_2e776cf4
// Checksum 0x43a59ff9, Offset: 0x1410
// Size: 0x1a2
function function_2e776cf4() {
    level flag::wait_till("pod_go");
    var_fccc406f = struct::get_array("rpg_begin");
    s_pod = struct::get("pod_pos");
    var_90911853 = getweapon("launcher_standard_magic_bullet");
    foreach (s_rpg in var_fccc406f) {
        wait(1);
        magicbullet(var_90911853, s_rpg.origin, s_pod.origin);
    }
    wait(0.3);
    level thread function_9716eddb();
    foreach (player in level.activeplayers) {
        player enableinvulnerability();
    }
    level flag::wait_till("pod_gone");
    level flag::set("rpg_done");
    level thread function_fe88fdb1();
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_9716eddb
// Checksum 0x5ab62958, Offset: 0x15c0
// Size: 0x12d
function function_9716eddb() {
    level endon(#"hash_2e90f258");
    var_fccc406f = struct::get_array("rpg_begin");
    var_90911853 = getweapon("launcher_standard_magic_bullet");
    while (true) {
        foreach (s_rpg in var_fccc406f) {
            v_offset = (randomintrange(-100, 100), randomintrange(-100, 100), randomintrange(-100, 100));
            magicbullet(var_90911853, s_rpg.origin, struct::get(s_rpg.target).origin + v_offset);
            wait(0.75);
        }
        wait(1.5);
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_d8ccdb23
// Checksum 0x6b576417, Offset: 0x16f8
// Size: 0xe2
function function_d8ccdb23() {
    level.var_4d5a4697.accuracy = 0.5;
    level.var_4d5a4697.grenadeammo = 0;
    level.var_4d5a4697 ai::set_ignoreall(1);
    level.var_9db406db ai::set_ignoreall(1);
    level.var_4d5a4697 ai::set_behavior_attribute("cqb", 1);
    level.var_9db406db ai::set_behavior_attribute("cqb", 1);
    level flag::wait_till("minister_pos");
    level.var_4d5a4697 ai::set_ignoreall(0);
    level.var_9db406db ai::set_ignoreall(0);
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_637fae36
// Checksum 0xe9fe97ac, Offset: 0x17e8
// Size: 0x132
function function_637fae36() {
    var_27606155 = getentarray("trigger_ob_defend", "targetname");
    foreach (var_a57773f5 in var_27606155) {
        var_a57773f5 triggerenable(1);
    }
    var_b957e40 = getent("trigger_apc_reinforce", "targetname");
    var_b957e40 triggerenable(0);
    var_f3fb06d8 = getent("trigger_pod_lz", "targetname");
    var_f3fb06d8 triggerenable(0);
    level flag::wait_till("shift_defend");
    var_b957e40 triggerenable(1);
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_a4e4e77d
// Checksum 0x2a2eb27e, Offset: 0x1928
// Size: 0xeb
function function_a4e4e77d() {
    level waittill(#"hash_da66fd91");
    foreach (player in level.activeplayers) {
        player playrumbleonentity("cp_prologue_rumble_apc_offroad");
    }
    foreach (player in level.players) {
        player shellshock("default", 5);
        player.overrideplayerdamage = &function_947bfdac;
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_8e9f8d38
// Checksum 0xb21c4161, Offset: 0x1a20
// Size: 0xdb
function function_8e9f8d38() {
    level.var_2fd26037 forceteleport(struct::get("skipto_robot_defend_hendricks").origin);
    level namespace_2cb3876f::function_12ce22ee();
    foreach (var_e4463170 in level.a_ai_allies) {
        var_e4463170.goalradius = 16;
        var_e4463170 forceteleport(struct::get("skipto_robot_defend_" + var_e4463170.targetname).origin);
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_a4e65a71
// Checksum 0x94717eb7, Offset: 0x1b08
// Size: 0x23f
function function_a4e65a71() {
    wait(1);
    vehicle::simple_spawn_single("defend_truck_3");
    vehicle::simple_spawn_single("defend_truck_4");
    level thread function_ff1a7b45();
    level flag::wait_till("shift_defend");
    level thread function_633f337();
    level flag::set("pod_waypoint");
    level thread function_b0cce50c();
    wait(5);
    spawner::simple_spawn_single("robot_defend_rpg");
    vehicle::simple_spawn_single("defend_truck_1");
    wait(1);
    vehicle::simple_spawn_single("defend_truck_2");
    level.var_d3659748 = vehicle::simple_spawn_single("defend_apc_3");
    level flag::wait_till("goto_pod");
    wait(3);
    level thread function_da3c5a9d();
    var_d3659748 = vehicle::simple_spawn_single("defend_apc_2");
    var_d3659748 thread function_2d1c6af3();
    wait(2);
    level flag::set("start_defend_countdown");
    if (level.players.size > 1) {
        foreach (player in level.players) {
            player.attackeraccuracy = 0.5;
        }
        return;
    }
    foreach (player in level.players) {
        player.attackeraccuracy = 0.4;
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_633f337
// Checksum 0xc3e7d773, Offset: 0x1d50
// Size: 0x2ca
function function_633f337() {
    level flag::wait_till("minister_pos");
    spawn_manager::enable("sm_robot_defend_tower");
    util::delay(5, undefined, &spawn_manager::disable, "sm_robot_defend_tower");
    wait(5);
    spawn_manager::enable("sm_apc_reinforce");
    level flag::wait_till("start_defend_countdown");
    spawn_manager::enable("sm_robot_pod");
    wait(2);
    spawn_manager::enable("sm_hilltop_guard");
    spawn_manager::enable("sm_perimeter_guard");
    wait(3);
    spawn_manager::enable("sm_robot_defend_tower");
    spawn_manager::enable("sm_defend_rpg");
    level waittill(#"hash_2ac435dc");
    spawn_manager::disable("sm_robot_defend_tower");
    spawn_manager::disable("sm_robot_pod");
    spawn_manager::disable("sm_hilltop_guard");
    spawn_manager::disable("sm_perimeter_guard");
    spawn_manager::disable("sm_defend_rpg");
    level waittill(#"hash_935fbb41");
    savegame::checkpoint_save();
    wait(2);
    spawn_manager::enable("sm_robot_defend_tower");
    spawn_manager::enable("sm_robot_pod");
    wait(2);
    spawn_manager::enable("sm_hilltop_guard");
    spawn_manager::enable("sm_perimeter_guard");
    wait(2);
    spawn_manager::enable("sm_defend_rpg");
    wait(1);
    spawn_manager::kill("sm_robot_pod");
    spawn_manager::kill("sm_robot_defend_tower");
    spawn_manager::enable("sm_robot_swarm");
    level flag::wait_till("pod_go");
    level thread namespace_21b2c1f2::function_fcb67450();
    spawn_manager::kill("sm_hilltop_guard");
    spawn_manager::kill("sm_perimeter_guard");
    spawn_manager::kill("sm_defend_rpg");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_ff1a7b45
// Checksum 0x6b41c5a2, Offset: 0x2028
// Size: 0xe2
function function_ff1a7b45() {
    wait(0.1);
    var_ff3ca8ae = getent("defend_truck_3_vh", "targetname");
    var_413044a1 = getent("defend_truck_4_vh", "targetname");
    var_977a939e = var_ff3ca8ae vehicle::function_ad4ec07a("gunner1");
    var_d96e2f91 = var_413044a1 vehicle::function_ad4ec07a("gunner1");
    while (isalive(var_977a939e) || isalive(var_d96e2f91)) {
        wait(1);
    }
    level flag::set("shift_defend");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_2d1c6af3
// Checksum 0xc86ffa7, Offset: 0x2118
// Size: 0x32
function function_2d1c6af3() {
    self setcandamage(0);
    self waittill(#"reached_end_node");
    wait(5);
    self setcandamage(1);
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_40fd81b
// Checksum 0x67a60f26, Offset: 0x2158
// Size: 0x19d
function function_40fd81b() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self.grenadeammo = 0;
    self.goalradius = 16;
    wait(randomfloatrange(2, 3.5));
    var_90911853 = getweapon("launcher_standard_magic_bullet");
    var_f8e04bb3 = self gettagorigin("tag_flash");
    while (true) {
        var_5aebca26 = level.var_27b46342[randomint(level.var_27b46342.size)];
        if (isdefined(var_5aebca26)) {
            v_offset = (randomintrange(-100, 100), randomintrange(-100, 100), randomintrange(90, 100));
            e_target = util::spawn_model("tag_origin", var_5aebca26.origin + v_offset);
            e_target.health = 100;
            self ai::shoot_at_target("normal", e_target, "tag_origin", undefined);
            e_target delete();
            wait(randomfloatrange(4, 5.5));
        }
        wait(0.1);
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_54454538
// Checksum 0xfcbaccd2, Offset: 0x2300
// Size: 0x222
function function_54454538() {
    self endon(#"death");
    self thread function_32c0959c();
    self thread function_3b49905c();
    self util::magic_bullet_shield();
    self ai::disable_pain();
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self.grenadeammo = 0;
    self.goalradius = 16;
    self waittill(#"goal");
    var_5aebca26 = getent("rpg_target", "targetname");
    var_5aebca26.health = 1;
    var_90911853 = getweapon("launcher_standard_magic_bullet");
    var_f8e04bb3 = self gettagorigin("tag_flash");
    wait(1);
    if (!isdefined(var_f8e04bb3)) {
        var_f8e04bb3 = self.origin;
    }
    e_projectile = magicbullet(var_90911853, var_f8e04bb3, var_5aebca26.origin);
    e_projectile waittill(#"death");
    e_projectile thread fx::play("rock_explosion", e_projectile.origin);
    wait(1);
    v_offset = (40, 0, 72);
    var_5aebca26 moveto(level.activeplayers[randomint(level.activeplayers.size)].origin + v_offset, 0.05);
    self thread ai::shoot_at_target("normal", var_5aebca26, undefined, undefined);
    self waittill(#"stop_shoot_at_target");
    self util::stop_magic_bullet_shield();
    self ai::enable_pain();
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    var_5aebca26 delete();
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_3b49905c
// Checksum 0x3a2ea32, Offset: 0x2530
// Size: 0x32
function function_3b49905c() {
    self endon(#"death");
    level flag::wait_till("apc_arrive");
    self util::stop_magic_bullet_shield();
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_32c0959c
// Checksum 0x383305b7, Offset: 0x2570
// Size: 0x32
function function_32c0959c() {
    self waittill(#"death");
    if (level.players.size > 1) {
        spawner::simple_spawn_single("rpg_coop");
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_4b1fb716
// Checksum 0x95552ae7, Offset: 0x25b0
// Size: 0x52
function function_4b1fb716() {
    self endon(#"death");
    self.goalradius = 4;
    self ai::set_behavior_attribute("sprint", 1);
    self waittill(#"goal");
    self ai::set_behavior_attribute("sprint", 0);
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_64dd8530
// Checksum 0x1f8e21c0, Offset: 0x2610
// Size: 0x12
function function_64dd8530() {
    self endon(#"death");
    self.grenadeammo = 0;
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_96551790
// Checksum 0xfa9d4e19, Offset: 0x2630
// Size: 0x3a
function function_96551790() {
    self endon(#"death");
    self.grenadeammo = 0;
    spawner::waittill_ai_group_count("group_defend_1", 1);
    self kill();
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_b9081af
// Checksum 0x595c760d, Offset: 0x2678
// Size: 0x2a
function function_b9081af() {
    self endon(#"death");
    self colors::set_force_color("o");
    self.grenadeammo = 0;
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_7f708ee
// Checksum 0x13171115, Offset: 0x26b0
// Size: 0x12
function function_7f708ee() {
    self endon(#"death");
    self.grenadeammo = 0;
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_bf932181
// Checksum 0x5a117b53, Offset: 0x26d0
// Size: 0x5a
function function_bf932181() {
    self endon(#"death");
    self.goalradius = 4;
    self ai::set_behavior_attribute("move_mode", "rambo");
    self waittill(#"goal");
    self ai::set_behavior_attribute("move_mode", "normal");
}

// Namespace namespace_835fda7e
// Params 2, eflags: 0x0
// namespace_835fda7e<file_0>::function_c3228115
// Checksum 0xe101c31e, Offset: 0x2738
// Size: 0xfa
function function_c3228115(var_a917e7b9, var_cf1a6222) {
    self endon(#"death");
    self thread turret::disable_ai_getoff(var_a917e7b9, 1);
    self thread turret::disable_ai_getoff(var_cf1a6222, 1);
    self turret::enable(var_a917e7b9, 1);
    self turret::enable(var_cf1a6222, 1);
    self thread vehicle::get_on_and_go_path(getvehiclenode(self.target, "targetname"));
    self waittill(#"reached_end_node");
    wait(1);
    var_44762fa4 = self vehicle::function_ad4ec07a("driver");
    if (isalive(var_44762fa4)) {
        var_44762fa4 thread vehicle::get_out();
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_45c35350
// Checksum 0x4d08efa5, Offset: 0x2840
// Size: 0x172
function function_45c35350() {
    self endon(#"death");
    self util::magic_bullet_shield();
    self thread turret::disable_ai_getoff(1, 1);
    self turret::enable(1, 1);
    self thread vehicle::get_on_and_go_path(getvehiclenode(self.target, "targetname"));
    wait(1);
    self waittill(#"reached_end_node");
    self util::stop_magic_bullet_shield();
    foreach (ai_rider in self.riders) {
        if (isalive(ai_rider) && ai_rider.script_startingposition != "gunner1") {
            ai_rider thread namespace_2cb3876f::function_2f943869();
        }
    }
    n_wait_time = randomfloatrange(20, 20 + randomfloat(20));
    wait(n_wait_time);
    self kill();
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_b2d7edae
// Checksum 0x7e40663a, Offset: 0x29c0
// Size: 0x1a3
function function_b2d7edae() {
    self endon(#"death");
    self util::magic_bullet_shield();
    self thread turret::disable_ai_getoff(1, 1);
    self turret::enable(1, 1);
    self thread vehicle::get_on_and_go_path(getvehiclenode(self.target, "targetname"));
    wait(1);
    foreach (ai_rider in self.riders) {
        if (isalive(ai_rider) && ai_rider.script_startingposition == "gunner1") {
            self thread function_58b0f8d8(ai_rider);
        }
    }
    self waittill(#"reached_end_node");
    self util::stop_magic_bullet_shield();
    foreach (ai_rider in self.riders) {
        if (isalive(ai_rider) && ai_rider.script_startingposition != "gunner1") {
            ai_rider thread namespace_2cb3876f::function_2f943869();
        }
    }
}

// Namespace namespace_835fda7e
// Params 1, eflags: 0x0
// namespace_835fda7e<file_0>::function_58b0f8d8
// Checksum 0xcf2cb796, Offset: 0x2b70
// Size: 0x62
function function_58b0f8d8(var_dfb53de7) {
    self endon(#"death");
    self waittill(#"reached_end_node");
    if (isalive(var_dfb53de7)) {
        var_dfb53de7 waittill(#"death");
    } else {
        wait(2);
    }
    self dodamage(self.health + 1, self.origin);
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_98ae774
// Checksum 0x826c2092, Offset: 0x2be0
// Size: 0x52
function function_98ae774() {
    self endon(#"death");
    if (randomint(6) < 2) {
        self namespace_2cb3876f::function_29c76f59();
        return;
    }
    self ai::set_behavior_attribute("move_mode", "marching");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_9d374
// Checksum 0xc19b9682, Offset: 0x2c40
// Size: 0xb2
function function_9d374() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self namespace_2cb3876f::function_29c76f59();
    s_goal = struct::get("pod_pos");
    a_v_points = [];
    while (a_v_points.size == 0) {
        a_v_points = util::positionquery_pointarray(s_goal.origin, 64, 400, 70, 40);
        wait(0.25);
    }
    self setgoal(a_v_points[randomint(a_v_points.size)], 1);
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_cc4c4e16
// Checksum 0xcf38ddb9, Offset: 0x2d00
// Size: 0x6a
function function_cc4c4e16() {
    level flag::wait_till("shift_defend");
    level thread namespace_2cb3876f::function_47a62798(1);
    level flag::wait_till("pod_arrive");
    level thread namespace_2cb3876f::function_a5398264("rambo");
    level thread namespace_2cb3876f::function_db027040(1);
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_e92ad8ae
// Checksum 0x574d10e, Offset: 0x2d78
// Size: 0xf2
function function_e92ad8ae() {
    wait(1);
    trigger::use("trig_defend_position_allies1");
    level flag::wait_till("shift_defend");
    level flag::wait_till("pod_arrive");
    savegame::checkpoint_save();
    level thread function_f76b808e();
    level.var_2fd26037 colors::disable();
    level.var_9db406db colors::disable();
    level.var_4d5a4697 colors::disable();
    trigger::use("trig_defend_position_allies2");
    wait(3);
    trigger::use("triggercolor_minister");
    wait(8);
    level thread function_9282c858();
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_f76b808e
// Checksum 0x5ca57569, Offset: 0x2e78
// Size: 0x142
function function_f76b808e() {
    level scene::add_scene_func("cin_pro_17_02_robotdefend_vign_hookup_minsterlloop", &function_4dc9c2f9, "play");
    level scene::add_scene_func("cin_pro_17_02_robotdefend_vign_hookup_khalilloop", &function_4e2b6779, "play");
    level scene::add_scene_func("cin_pro_17_02_robotdefend_vign_hookup_hendricksloop", &function_8600d87b, "play");
    level thread scene::play("cin_pro_17_02_robotdefend_vign_hookup_minsterlloop");
    level thread scene::play("cin_pro_17_02_robotdefend_vign_hookup_khalilloop");
    level thread scene::play("cin_pro_17_02_robotdefend_vign_hookup_hendricksloop");
    level thread function_5443e6cb();
    level thread function_deb83f0d();
    level flag::wait_till("ready_load");
    level scene::play("cin_pro_17_02_robotdefend_vign_hookup");
    level scene::play("cin_pro_17_02_robotdefend_vign_hookup_loop");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_deb83f0d
// Checksum 0xbb3cf773, Offset: 0x2fc8
// Size: 0x22
function function_deb83f0d() {
    level endon(#"hash_3b063ae9");
    wait(15);
    level flag::set("ready_load");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_5443e6cb
// Checksum 0x49b1533c, Offset: 0x2ff8
// Size: 0x4a
function function_5443e6cb() {
    level endon(#"hash_3b063ae9");
    level util::waittill_multiple("hendricks_ready", "khalil_ready", "minister_ready");
    level flag::set("ready_load");
}

// Namespace namespace_835fda7e
// Params 1, eflags: 0x0
// namespace_835fda7e<file_0>::function_4dc9c2f9
// Checksum 0x6e3a2264, Offset: 0x3050
// Size: 0x13
function function_4dc9c2f9(a_ents) {
    level notify(#"hash_43c7040");
}

// Namespace namespace_835fda7e
// Params 1, eflags: 0x0
// namespace_835fda7e<file_0>::function_4e2b6779
// Checksum 0x178555e4, Offset: 0x3070
// Size: 0x13
function function_4e2b6779(a_ents) {
    level notify(#"hash_fecf35c0");
}

// Namespace namespace_835fda7e
// Params 1, eflags: 0x0
// namespace_835fda7e<file_0>::function_8600d87b
// Checksum 0xa3b42b94, Offset: 0x3090
// Size: 0x13
function function_8600d87b(a_ents) {
    level notify(#"hash_a4aaeab6");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_10b855b0
// Checksum 0xdcb6f410, Offset: 0x30b0
// Size: 0x92
function function_10b855b0() {
    level flag::wait_till("shift_defend");
    trigger::use("triggercolor_enemy_path");
    level flag::wait_till("apc_reinforce");
    trigger::use("triggercolor_enemy_pod");
    level flag::wait_till("goto_pod");
    trigger::use("triggercolor_enemy_end");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_b0cce50c
// Checksum 0xe053fe5f, Offset: 0x3150
// Size: 0x152
function function_b0cce50c() {
    s_pod = struct::get("pod_pos");
    s_defend = struct::get("pod_defend");
    wait(2);
    objectives::set("cp_waypoint_breadcrumb", s_pod);
    var_f3fb06d8 = getent("trigger_pod_lz", "targetname");
    var_6848ea7f = getent("trigger_apc_reinforce", "targetname");
    var_f3fb06d8 triggerenable(1);
    var_6848ea7f thread function_a950a3ec();
    level thread function_a3ac9ae0();
    level flag::wait_till("pod_arrive");
    var_f3fb06d8 waittill(#"trigger");
    objectives::complete("cp_waypoint_breadcrumb", s_pod);
    objectives::hide("cp_level_prologue_goto_exfil");
    objectives::set("cp_level_prologue_defend_pod", s_defend);
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_a3ac9ae0
// Checksum 0xafb6211c, Offset: 0x32b0
// Size: 0x3a
function function_a3ac9ae0() {
    level endon(#"hash_2ef4a1f0");
    spawn_manager::function_27bf2e8("sm_apc_reinforce", 2);
    wait(10);
    level flag::set("goto_pod");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_a950a3ec
// Checksum 0x7aeda340, Offset: 0x32f8
// Size: 0xaa
function function_a950a3ec() {
    level endon(#"hash_2ef4a1f0");
    foreach (player in level.players) {
        self thread function_cd56c2cf(player);
    }
    level.var_fc71d8f = 0;
    while (level.var_fc71d8f < level.players.size) {
        wait(0.5);
    }
    level flag::set("goto_pod");
}

// Namespace namespace_835fda7e
// Params 1, eflags: 0x0
// namespace_835fda7e<file_0>::function_cd56c2cf
// Checksum 0x681eb847, Offset: 0x33b0
// Size: 0x41
function function_cd56c2cf(player) {
    level endon(#"hash_2ef4a1f0");
    while (true) {
        e_entity = self waittill(#"trigger");
        if (e_entity == player) {
            level.var_fc71d8f++;
        }
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_b5284617
// Checksum 0xe6bd200c, Offset: 0x3400
// Size: 0x252
function function_b5284617() {
    level.e_blocker = getent("brush_pod", "targetname");
    vehicle::add_spawn_function("fxanim_vtol_pod", &function_de0720c1);
    vehicle::add_spawn_function("fxanim_pod", &function_52d9a509);
    level thread scene::play("p7_fxanim_cp_prologue_vtol_pod_drop_off_bundle");
    level thread function_45756e82();
    level thread function_aba4324();
    level thread function_c0fa2edc();
    level thread function_2063548d();
    level waittill(#"hash_39aa5979");
    level flag::set("pod_on_ground");
    foreach (player in level.activeplayers) {
        player playrumbleonentity("cp_prologue_rumble_pod_land");
    }
    wait(3);
    level flag::set("pod_arrive");
    level flag::wait_till("ready_load");
    level thread function_6947ce3();
    level thread function_7a733ec7();
    level flag::set("dropship_return");
    arrayremovevalue(level.var_27b46342, level.var_4d5a4697);
    arrayremovevalue(level.var_27b46342, level.var_9db406db);
    arrayremovevalue(level.var_27b46342, level.var_2fd26037);
    level flag::wait_till("pod_go");
    level scene::play("cin_pro_17_02_robotdefend_vign_hookup_explosion");
}

// Namespace namespace_835fda7e
// Params 1, eflags: 0x0
// namespace_835fda7e<file_0>::function_4f43b0cc
// Checksum 0x3120c5f5, Offset: 0x3660
// Size: 0x22
function function_4f43b0cc(a_ents) {
    exploder::exploder_stop("light_exploder_defend_radio_tower");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_7a733ec7
// Checksum 0xdae25c2a, Offset: 0x3690
// Size: 0x10b
function function_7a733ec7() {
    level waittill(#"hash_b9036ca8");
    exploder::exploder("fx_exploder_vtol_pod_rotorwash");
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("dropship_rumble_loop", 1);
    }
    level waittill(#"hash_958c9db6");
    exploder::stop_exploder("fx_exploder_vtol_pod_rotorwash");
    foreach (player in level.activeplayers) {
        player clientfield::set_to_player("dropship_rumble_loop", 0);
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_2063548d
// Checksum 0xee773d62, Offset: 0x37a8
// Size: 0x232
function function_2063548d() {
    level flag::wait_till("pod_loaded");
    objectives::complete("cp_level_prologue_defend_pod");
    objectives::set("cp_level_prologue_get_out_alive");
    level.activeplayers[0] playloopsound("evt_outro_tinnitus_lp", 4);
    level thread function_e7a97be1();
    array::run_all(level.players, &util::function_16c71b8, 1);
    function_657fb683();
    level thread util::screen_fade_in(1, "black", "cinematic_fader");
    level flag::set("pod_go");
    level thread function_f7af5999();
    scene::add_scene_func("cin_pro_17_02_robotdefend_vign_hookup_player", &function_6e3b3bec, "play");
    level thread scene::play("cin_pro_17_02_robotdefend_vign_hookup_player");
    level util::clientnotify("sndOS1");
    level waittill(#"hash_7176ec93");
    level util::clientnotify("sndOS2");
    foreach (player in level.players) {
        player playrumbleonentity("damage_heavy");
    }
    level thread util::screen_fade_out(0.75, "black", "cinematic_fader");
    level vo_end();
    level flag::set("pod_gone");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_e7a97be1
// Checksum 0xba3141f2, Offset: 0x39e8
// Size: 0x22
function function_e7a97be1() {
    wait(10);
    level.activeplayers[0] stoploopsound(5);
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_657fb683
// Checksum 0x7987bc60, Offset: 0x3a18
// Size: 0xc2
function function_657fb683() {
    foreach (player in level.players) {
        if (isalive(player)) {
            player thread function_c794d3c2();
            player thread scene::play("cin_pro_17_02_robotdefend_vign_hookup_player_explosion");
        }
    }
    wait(0.75);
    util::screen_fade_out(0.5, "black", "cinematic_fader");
}

// Namespace namespace_835fda7e
// Params 4, eflags: 0x0
// namespace_835fda7e<file_0>::function_c794d3c2
// Checksum 0x6b1a622, Offset: 0x3ae8
// Size: 0x182
function function_c794d3c2(n_height, var_7ad049d6, var_9bd58d85, var_688fa2d2) {
    if (!isdefined(n_height)) {
        n_height = 300;
    }
    if (!isdefined(var_7ad049d6)) {
        var_7ad049d6 = 100;
    }
    if (!isdefined(var_9bd58d85)) {
        var_9bd58d85 = 1;
    }
    if (!isdefined(var_688fa2d2)) {
        var_688fa2d2 = 1;
    }
    self endon(#"death");
    self enableinvulnerability();
    var_46ff2245 = anglestoforward(self.angles);
    var_652493a5 = var_46ff2245 * var_7ad049d6;
    var_f720f8d7 = self.origin + (0, 0, n_height) + var_652493a5;
    var_f9f8910c = self.origin + var_652493a5;
    var_90911853 = getweapon("launcher_standard_magic_bullet");
    magicbullet(var_90911853, var_f720f8d7, var_f9f8910c);
    self playsoundtoplayer("evt_outro_explosion", self);
    wait(0.25);
    level thread fx::play("rock_explosion", var_f9f8910c);
    if (var_9bd58d85) {
        self playrumbleonentity("cp_prologue_rumble_pod_land");
    }
    if (var_688fa2d2) {
        self shellshock("default", 7);
    }
    self disableinvulnerability();
}

// Namespace namespace_835fda7e
// Params 1, eflags: 0x0
// namespace_835fda7e<file_0>::function_6e3b3bec
// Checksum 0x8154d966, Offset: 0x3c78
// Size: 0xa2
function function_6e3b3bec(a_ents) {
    var_a5eb4761 = struct::get("s_rocket_player_hookup", "targetname");
    var_2c7e0a5a = struct::get(var_a5eb4761.target, "targetname");
    level waittill(#"hash_37113ae1");
    var_90911853 = getweapon("launcher_standard_magic_bullet");
    magicbullet(var_90911853, var_a5eb4761.origin, var_2c7e0a5a.origin);
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_f7af5999
// Checksum 0x86cacf5, Offset: 0x3d28
// Size: 0x7a
function function_f7af5999() {
    level.var_2fd26037 dialog::say("hend_wait_my_team_s_still_0", 0.5);
    level.apc dialog::say("dops_negative_airspace_i_0", 0.5, 1);
    level.var_2fd26037 dialog::say("hend_no_no_no_no_fu_0", 0.5);
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_de0720c1
// Checksum 0xba5ca3fe, Offset: 0x3db0
// Size: 0x6a
function function_de0720c1() {
    self endon(#"death");
    self util::magic_bullet_shield();
    if (level flag::get("start_defend_countdown")) {
        self thread fx::play("dropship_spotlight", self.origin, self.angles, "notetrack_cease_fire", 1, "tag_fx_light_frontspot_ll");
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_52d9a509
// Checksum 0x3e8dde9d, Offset: 0x3e28
// Size: 0xe2
function function_52d9a509() {
    self util::magic_bullet_shield();
    var_a3781dbd = getent("pod_panel", "targetname");
    var_730a7fb0 = (-1.9, 53.5, 79.5);
    var_162bfcbf = (-180, 0, 0);
    var_17250c53 = vectortoangles(var_162bfcbf);
    var_a3781dbd linkto(self, "tag_origin", var_730a7fb0, var_17250c53);
    level flag::wait_till("pod_on_ground");
    radiusdamage(self.origin, -6, -106, -106, undefined, "MOD_EXPLOSIVE");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_aba4324
// Checksum 0x400c9f5, Offset: 0x3f18
// Size: 0xb3
function function_aba4324() {
    wait(3.5);
    var_edc6e0e1 = getent("fxanim_vtol_pod", "animname");
    var_dc6cf86c = struct::get_array("rpg_vtol");
    foreach (s_rpg in var_dc6cf86c) {
        var_edc6e0e1 thread function_3df1f906(s_rpg);
    }
}

// Namespace namespace_835fda7e
// Params 1, eflags: 0x0
// namespace_835fda7e<file_0>::function_3df1f906
// Checksum 0xeb243089, Offset: 0x3fd8
// Size: 0xd9
function function_3df1f906(s_rpg) {
    self endon(#"death");
    var_90911853 = getweapon("launcher_standard");
    for (i = 0; i < 8; i++) {
        v_offset = (randomintrange(-1500, -1300), randomintrange(-100, 100), randomintrange(-100, 100));
        magicbullet(var_90911853, s_rpg.origin, self.origin + v_offset);
        wait(randomfloatrange(1, 2));
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_6947ce3
// Checksum 0x943abd26, Offset: 0x40c0
// Size: 0x52
function function_6947ce3() {
    wait(1);
    var_f5882947 = getent("fxanim_vtol_pod", "animname");
    var_f5882947 thread function_34d9d6a7();
    level waittill(#"hash_27dfe41d");
    level thread function_94856821();
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_94856821
// Checksum 0x58868d00, Offset: 0x4120
// Size: 0xd1
function function_94856821() {
    n_dist_sq = 902500;
    s_pos = struct::get("pod_pos");
    a_e_targets = getaiarchetypearray("robot");
    for (i = 0; i < a_e_targets.size; i++) {
        if (distance2dsquared(s_pos.origin, a_e_targets[i].origin) <= n_dist_sq) {
            if (isalive(a_e_targets[i])) {
                a_e_targets[i] ai::set_behavior_attribute("force_crawler", "gib_legs");
            }
        }
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_34d9d6a7
// Checksum 0xc6ea5b44, Offset: 0x4200
// Size: 0x1ab
function function_34d9d6a7() {
    level waittill(#"hash_2ac435dc");
    level scene::add_scene_func("p7_fxanim_cp_prologue_tower_vtol_collapse_v2_bundle", &function_4f43b0cc);
    level thread scene::play("p7_fxanim_cp_prologue_tower_vtol_collapse_v2_bundle");
    exploder::exploder_stop("light_exploder_defend_radio_tower");
    var_28ca079b = 360000;
    var_ace21635 = 1000000;
    s_pos = struct::get("pod_pos");
    a_e_targets = getaiteamarray("axis");
    for (i = 0; i < a_e_targets.size; i++) {
        if (isalive(a_e_targets[i])) {
            n_dist = distance2dsquared(s_pos.origin, a_e_targets[i].origin);
            if (a_e_targets[i].archetype === "human" && n_dist >= var_28ca079b && n_dist <= var_ace21635) {
                self function_114d2017(a_e_targets[i]);
            } else if (a_e_targets[i].archetype === "robot" && n_dist >= var_ace21635) {
                self function_114d2017(a_e_targets[i]);
            }
            wait(0.5);
        }
    }
    level notify(#"hash_27dfe41d");
}

// Namespace namespace_835fda7e
// Params 1, eflags: 0x0
// namespace_835fda7e<file_0>::function_114d2017
// Checksum 0x3020f983, Offset: 0x43b8
// Size: 0x12a
function function_114d2017(e_target) {
    var_8af78429 = getweapon("launcher_standard");
    var_9fab05ff = self gettagorigin("tag_fx_rocket_pod_l");
    v_target = e_target.origin;
    v_offset = (randomintrange(-100, 100), randomintrange(-100, 100), randomintrange(-80, 80));
    e_missile = magicbullet(var_8af78429, var_9fab05ff, v_target);
    e_missile thread function_1082845c(v_target + v_offset);
    wait(0.5);
    var_4bd7a161 = self gettagorigin("tag_fx_rocket_pod_r");
    e_missile = magicbullet(var_8af78429, var_4bd7a161, v_target + v_offset);
    e_missile thread function_1082845c(v_target + v_offset);
}

// Namespace namespace_835fda7e
// Params 1, eflags: 0x0
// namespace_835fda7e<file_0>::function_1082845c
// Checksum 0xec4392ae, Offset: 0x44f0
// Size: 0x3a
function function_1082845c(v_target) {
    self waittill(#"death");
    radiusdamage(v_target, 100, 1500, 500, undefined, "MOD_EXPLOSIVE");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_c0fa2edc
// Checksum 0x6757cc76, Offset: 0x4538
// Size: 0x22
function function_c0fa2edc() {
    level waittill(#"hash_1a9aaaa8");
    level.e_blocker delete();
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_312356f
// Checksum 0x1cd6e352, Offset: 0x4568
// Size: 0x422
function function_312356f() {
    vehicle::add_spawn_function("defend_truck_1", &function_45c35350);
    vehicle::add_spawn_function("defend_truck_2", &function_45c35350);
    vehicle::add_spawn_function("defend_truck_3", &function_b2d7edae);
    vehicle::add_spawn_function("defend_truck_4", &function_b2d7edae);
    vehicle::add_spawn_function("defend_apc_2", &function_c3228115, 1, 2);
    vehicle::add_spawn_function("defend_apc_3", &function_c3228115, 1, 2);
    spawner::add_spawn_function_group("ridge_guy", "targetname", &function_64dd8530);
    spawner::add_spawn_function_group("apc3_crew", "targetname", &function_4b1fb716);
    spawner::add_spawn_function_group("apc_reinforce", "targetname", &function_4b1fb716);
    spawner::add_spawn_function_group("group_defend_1", "script_aigroup", &function_96551790);
    spawner::add_spawn_function_group("rpg_intro", "script_aigroup", &function_54454538);
    spawner::add_spawn_function_group("group_apc", "script_aigroup", &function_b9081af);
    spawner::add_spawn_function_group("group_reinforce_1", "script_aigroup", &function_7f708ee);
    spawner::add_spawn_function_group("group_reinforce_2", "script_aigroup", &function_bf932181);
    spawner::add_spawn_function_group("group_reinforce_3", "script_aigroup", &function_7f708ee);
    spawner::add_spawn_function_group("group_defend_2", "script_aigroup", &function_b9081af);
    spawner::add_spawn_function_group("group_defend_3", "script_aigroup", &function_b9081af);
    spawner::add_spawn_function_group("group_pod_right", "script_aigroup", &function_b9081af);
    spawner::add_spawn_function_group("group_pod_left", "script_aigroup", &function_b9081af);
    spawner::add_spawn_function_group("group_pod_robot", "script_aigroup", &function_98ae774);
    spawner::add_spawn_function_group("defend_rpg", "targetname", &function_40fd81b);
    spawner::add_spawn_function_group("robot_swarm", "targetname", &function_9d374);
    spawner::add_spawn_function_group("group_tower_defender", "script_aigroup", &function_7f708ee);
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_2772c15e
// Checksum 0x4a34dc62, Offset: 0x4998
// Size: 0x1a
function function_2772c15e() {
    exploder::exploder("fx_exploder_background_exp_muz");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_6ba94a8
// Checksum 0x62aecf4c, Offset: 0x49c0
// Size: 0x312
function function_6ba94a8() {
    battlechatter::function_d9f49fba(0);
    level thread namespace_21b2c1f2::function_92382f5c();
    level.var_2fd26037 dialog::say("hend_there_s_our_ride_0");
    level.apc dialog::say("dops_exfil_pod_first_pass_0", 0.2, 1);
    level flag::wait_till("pod_on_ground");
    level.apc dialog::say("dops_exfil_pod_dropping_0", 0.5, 1);
    level.var_2fd26037 dialog::say("hend_nrc_reinforcements_c_0", 1);
    battlechatter::function_d9f49fba(1);
    level flag::wait_till("shift_defend");
    battlechatter::function_d9f49fba(0);
    level.var_9db406db dialog::say("khal_minister_are_you_al_0", 0.5);
    level.var_4d5a4697 dialog::say("said_i_m_fine_i_m_fine_0", 0.5);
    level flag::set("minister_pos");
    level.var_2fd26037 dialog::say("hend_we_gotta_get_the_hel_1");
    battlechatter::function_d9f49fba(1);
    level flag::wait_till("pod_waypoint");
    battlechatter::function_d9f49fba(0);
    level thread function_77fe86ff();
    var_49b32118 = getent("pa_comm_tower", "targetname");
    var_49b32118 dialog::say("nrcp_infiltrators_cornere_0", 0.2, 1);
    battlechatter::function_d9f49fba(1);
    level flag::wait_till("dropship_return");
    battlechatter::function_d9f49fba(0);
    level dialog::remote("dops_drone_concentrating_0");
    level waittill(#"hash_2bc95ac2");
    level.apc dialog::say("dops_drone_is_in_position_0", 1, 1);
    level.var_2fd26037 dialog::say("hend_secure_get_your_ass_1", 0.25);
    level flag::set("pod_loaded");
    level.var_2fd26037 dialog::say("hend_get_your_ass_over_he_2", 1);
    level dialog::remote("dops_drone_ready_to_move_0");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_77fe86ff
// Checksum 0x4487fb8, Offset: 0x4ce0
// Size: 0x82
function function_77fe86ff() {
    level endon(#"hash_ba5c153");
    level flag::wait_till("pod_loaded");
    wait(5);
    level.var_2fd26037 dialog::say("hend_get_your_ass_over_he_1");
    wait(6);
    level.var_2fd26037 dialog::say("hend_we_gotta_go_come_on_0");
    wait(6);
    level.var_2fd26037 dialog::say("hend_the_drone_can_t_take_0");
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_da3c5a9d
// Checksum 0x18d3ae15, Offset: 0x4d70
// Size: 0x22
function function_da3c5a9d() {
    level.var_2fd26037 dialog::say("hend_apc_from_the_right_0", 3);
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_9282c858
// Checksum 0x4e2adde6, Offset: 0x4da0
// Size: 0x9a
function function_9282c858() {
    level endon(#"hash_7673dfe9");
    wait(3);
    if (!level.var_fc71d8f) {
        level.var_2fd26037 dialog::say("hend_move_move_move_0");
        wait(3);
        level.var_2fd26037 dialog::say("hend_get_over_here_come_0");
        wait(3);
        level.var_2fd26037 dialog::say("hend_i_need_you_on_my_pos_1");
        wait(3);
        level.var_2fd26037 dialog::say("hend_that_drone_ll_be_her_1");
    }
}

// Namespace namespace_835fda7e
// Params 0, eflags: 0x0
// namespace_835fda7e<file_0>::function_7098f5fa
// Checksum 0xa002b357, Offset: 0x4e48
// Size: 0x2a
function vo_end() {
    level.var_2fd26037 dialog::say("tayr_inbound_two_minutes_0", 0.5);
}

// Namespace namespace_835fda7e
// Params 13, eflags: 0x0
// namespace_835fda7e<file_0>::function_947bfdac
// Checksum 0xbb235180, Offset: 0x4e80
// Size: 0xb3
function function_947bfdac(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, modelindex, psoffsettime, vsurfacenormal) {
    if (isdefined(weapon) && isdefined(weapon.name)) {
        if (weapon.name == "turret_bo3_mil_macv_gunner3" || weapon.name == "turret_bo3_mil_macv_gunner4") {
            idamage *= 0.05;
        }
    }
    return idamage;
}

// Namespace namespace_835fda7e
// Params 1, eflags: 0x0
// namespace_835fda7e<file_0>::function_45756e82
// Checksum 0xf190140d, Offset: 0x4f40
// Size: 0x7d
function function_45756e82(var_1fd9b48b) {
    if (!isdefined(var_1fd9b48b)) {
        var_1fd9b48b = "chicken_zone";
    }
    level endon(#"hash_7d7d7481");
    var_e512db80 = getent(var_1fd9b48b + "_trigger", "targetname");
    while (true) {
        e_who = var_e512db80 waittill(#"trigger");
        e_who function_d311c75a(var_1fd9b48b);
    }
}

// Namespace namespace_835fda7e
// Params 1, eflags: 0x0
// namespace_835fda7e<file_0>::function_d311c75a
// Checksum 0x834c6267, Offset: 0x4fc8
// Size: 0x1f9
function function_d311c75a(var_1fd9b48b) {
    self endon(#"death");
    str_endon = "player_exited_" + var_1fd9b48b;
    level endon(str_endon);
    level thread function_4d64d2f6(var_1fd9b48b);
    wait(7);
    var_4e9a9978 = var_1fd9b48b + "_target";
    var_592faea1 = struct::get_array(var_1fd9b48b + "_src");
    var_9a93fef1 = struct::get_array(var_1fd9b48b + "_src2");
    a_s_targets = struct::get_array(var_4e9a9978, "targetname");
    var_60057f63 = getweapon("launcher_standard");
    while (true) {
        var_51b841d8 = array::random(var_9a93fef1);
        magicbullet(var_60057f63, var_51b841d8.origin, self.origin);
        for (i = 0; i < 3; i++) {
            function_e78f61a0(var_60057f63, var_592faea1, a_s_targets);
            wait(1);
        }
        wait(1);
        for (i = 0; i < 4; i++) {
            var_55ad5a1e = array::random(var_592faea1);
            magicbullet(var_60057f63, var_55ad5a1e.origin, self.origin);
            wait(1);
            var_51b841d8 = array::random(var_9a93fef1);
            magicbullet(var_60057f63, var_51b841d8.origin, self.origin);
            wait(1);
        }
        wait(3);
    }
}

// Namespace namespace_835fda7e
// Params 3, eflags: 0x0
// namespace_835fda7e<file_0>::function_e78f61a0
// Checksum 0x924d7390, Offset: 0x51d0
// Size: 0x6a
function function_e78f61a0(w_weapon, var_a35aa0b0, a_s_targets) {
    s_start = array::random(var_a35aa0b0);
    s_target = array::random(a_s_targets);
    magicbullet(w_weapon, s_start.origin, s_target.origin);
}

// Namespace namespace_835fda7e
// Params 1, eflags: 0x0
// namespace_835fda7e<file_0>::function_4d64d2f6
// Checksum 0x35a84e19, Offset: 0x5248
// Size: 0x5c
function function_4d64d2f6(var_1fd9b48b) {
    level endon(#"death");
    level endon(#"hash_7d7d7481");
    var_fe2701d = "player_touching_" + var_1fd9b48b;
    level flag::wait_till_clear(var_fe2701d);
    str_endon = "player_exited_" + var_1fd9b48b;
    level notify(str_endon);
}

