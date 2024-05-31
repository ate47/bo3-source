#using scripts/cp/cp_prologue_player_sacrifice;
#using scripts/cp/cp_prologue_robot_reveal;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/cp_mi_eth_prologue_accolades;
#using scripts/cp/cp_mi_eth_prologue;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/_util;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/cp/_accolades;
#using scripts/codescripts/struct;

#namespace apc;

// Namespace apc
// Params 2, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_61ebdfad
// Checksum 0x8bd17989, Offset: 0x21e8
// Size: 0x1ba
function function_61ebdfad(objective, var_96ecaade) {
    cp_mi_eth_prologue::function_77d9dff("objective_apc_init");
    if (var_96ecaade) {
        load::function_73adcefc();
        level thread namespace_2cb3876f::function_cfabe921();
        mdl_clip = getent("clip_ai_garage", "targetname");
        mdl_clip movez(-200, 0.05);
        level.var_92d245e2 = util::function_740f8516("prometheus");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        skipto::teleport_ai(objective, level.heroes);
        load::function_a2995f22();
        level namespace_2cb3876f::function_6a5f89cb("skipto_apc_ai");
        trigger::use("triggercolor_allies_garage");
        level function_50d6bf35("vehicle_apc_hijack_node", 0);
        level flag::set("players_in_garage");
    }
    level flag::init("failed_apc_boarding");
    level.var_1a71fabf = 0;
    function_a0321b9a();
    if (isdefined(level.var_88610be3)) {
        level thread [[ level.var_88610be3 ]]();
    }
    apc_main();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_a0321b9a
// Checksum 0x414cbaa3, Offset: 0x23b0
// Size: 0x9a
function function_a0321b9a() {
    if (scene::is_playing("cin_pro_13_01_vtoltackle_vign_takedown")) {
        var_e006a077 = scene::get_existing_ent("vtol");
        if (isdefined(var_e006a077)) {
            var_e006a077.delete_on_death = 1;
            var_e006a077 notify(#"death");
            if (!isalive(var_e006a077)) {
                var_e006a077 delete();
            }
        }
        scene::stop("cin_pro_13_01_vtoltackle_vign_takedown");
    }
}

// Namespace apc
// Params 4, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_c92883a
// Checksum 0x7cf3bf2e, Offset: 0x2458
// Size: 0x5a
function function_c92883a(name, var_74cd64bc, var_e4cd2b8b, player) {
    level scene::init("p7_fxanim_cp_prologue_pump_station_crash_bundle");
    level.friendlyfiredisabled = 1;
    cp_mi_eth_prologue::function_77d9dff("apc_done");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_3ee236cf
// Checksum 0x906c30a7, Offset: 0x24c0
// Size: 0x172
function apc_main() {
    battlechatter::function_d9f49fba(0);
    level thread function_258a16c();
    level thread function_651e7b34(1);
    level thread function_b31512cf();
    level thread function_599ebca1();
    level thread function_a4abb20e();
    level.var_92d245e2 setgoal(getnode("nd_taylor_garage", "targetname"), 1);
    level scene::play("cin_pro_15_01_opendoor_vign_getinside_new_hendricks_and_prometheus");
    level flag::set("apc_ready");
    level thread function_5c746711();
    level flag::wait_till("players_are_in_apc");
    level flag::wait_till("ai_in_apc");
    level.var_2fd26037 vehicle::get_in(level.apc, "driver", 1);
    level thread function_5c1321b9();
    if (!level flag::get("failed_apc_boarding")) {
        skipto::function_be8adfb8("skipto_apc");
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_a4abb20e
// Checksum 0x5bbd820b, Offset: 0x2640
// Size: 0x22
function function_a4abb20e() {
    level waittill(#"hash_ef5b1f55");
    level util::clientnotify("sndStartGarage");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_599ebca1
// Checksum 0xd31ff232, Offset: 0x2670
// Size: 0x52
function function_599ebca1() {
    wait(45);
    if (!level flag::get("apc_unlocked")) {
        level.var_2fd26037 dialog::say("hend_i_got_the_wheel_gra_0");
    }
    level flag::set("apc_unlocked");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_5c746711
// Checksum 0xd7481e53, Offset: 0x26d0
// Size: 0x72
function function_5c746711() {
    level flag::wait_till("garage_dent");
    if (!level flag::get("players_are_in_apc")) {
        level thread function_1b4b1ac0();
        util::waittill_notify_or_timeout("players_are_in_apc", 5);
    }
    level flag::set("garage_breach");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_1b4b1ac0
// Checksum 0xd1b9e0a4, Offset: 0x2750
// Size: 0x62
function function_1b4b1ac0() {
    level endon(#"hash_8b0e5eab");
    if (!level flag::get("players_are_in_apc")) {
        level.var_2fd26037 dialog::say("hend_we_re_out_of_time_g_0");
        wait(5);
        level.var_2fd26037 dialog::say("hend_that_drone_won_t_wai_0");
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_b31512cf
// Checksum 0x23f247cc, Offset: 0x27c0
// Size: 0x133
function function_b31512cf() {
    level flag::wait_till("players_are_in_apc");
    level thread function_4792c4cc();
    level flag::wait_till("apc_thru_door");
    radiusdamage(struct::get("apc_door_exp").origin, -56, 1000, 800, undefined, "MOD_EXPLOSIVE");
    exploder::exploder("fx_exploder_fog_part_01");
    level thread scene::play("p7_fxanim_cp_prologue_apc_door_03_break_bundle");
    level flag::set("spawn_road_robots");
    foreach (player in level.activeplayers) {
        player playrumbleonentity("cp_prologue_rumble_apc_offroad");
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_833cbef4
// Checksum 0x3b328932, Offset: 0x2900
// Size: 0x3a
function function_833cbef4() {
    self waittill(#"picked_up_collectible");
    level thread util::delay(10, "player_picked_up_collectible", &flag::set, "garage_dent");
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_651e7b34
// Checksum 0xc2fc5f50, Offset: 0x2948
// Size: 0x552
function function_651e7b34(var_aa0f824f) {
    if (var_aa0f824f) {
        level flag::wait_till("apc_unlocked");
    }
    level thread util::delay(15, "player_picked_up_collectible", &flag::set, "garage_dent");
    array::thread_all(level.activeplayers, &function_833cbef4);
    callback::on_spawned(&function_833cbef4);
    level flag::wait_till("garage_dent");
    callback::remove_on_spawned(&function_833cbef4);
    spawner::simple_spawn("garage_robot_attackers", &function_dccdf588);
    level scene::play("p7_fxanim_cp_prologue_apc_door_03_dent_bundle");
    if (level flag::get("players_are_in_apc")) {
        return;
    }
    level thread scene::play("p7_fxanim_cp_prologue_apc_door_03_fail_bundle");
    mdl_clip = getent("clip_garage_exit", "targetname");
    if (isdefined(mdl_clip)) {
        mdl_clip delete();
    }
    var_be61cb01 = getent("clip_garage_door", "targetname");
    if (isdefined(var_be61cb01)) {
        var_be61cb01 delete();
    }
    level waittill(#"hash_93057b55");
    wait(2);
    if (level flag::get("players_are_in_apc") || level.var_1a71fabf >= level.activeplayers.size) {
        return;
    }
    level flag::set("failed_apc_boarding");
    var_6ca49220 = [];
    var_6ca49220[0] = getent("trig_apc_gunner1", "script_noteworthy");
    var_6ca49220[1] = getent("trig_apc_gunner2", "script_noteworthy");
    var_6ca49220[2] = getent("trig_apc_gunner3", "script_noteworthy");
    var_6ca49220[3] = getent("trig_apc_gunner4", "script_noteworthy");
    foreach (var_66b9fddf in var_6ca49220) {
        if (isdefined(var_66b9fddf.var_5356d2cc)) {
            var_66b9fddf.var_5356d2cc gameobjects::disable_object();
        }
        var_66b9fddf delete();
    }
    var_1f75b80a = struct::get_array("garage_fail_rockets", "targetname");
    var_8af78429 = getweapon("launcher_standard_magic_bullet");
    foreach (s_start in var_1f75b80a) {
        magicbullet(var_8af78429, s_start.origin, struct::get(s_start.target, "targetname").origin);
        wait(0.15);
    }
    util::unmake_hero("ally_01");
    util::unmake_hero("ally_02");
    util::unmake_hero("ally_03");
    util::unmake_hero("hendricks");
    foreach (player in level.activeplayers) {
        if (isdefined(player)) {
            player thread namespace_835fda7e::function_c794d3c2(100, 100, 1, 0);
            wait(0.15);
        }
    }
    wait(0.25);
    level.apc.overridevehicledamage = undefined;
    level.apc setcandamage(1);
    level.apc dodamage(level.apc.health + 1, level.apc.origin);
    wait(1);
    util::function_207f8667(%CP_MI_ETH_PROLOGUE_GARAGE_FAIL);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_4792c4cc
// Checksum 0xdb1aa799, Offset: 0x2ea8
// Size: 0x15d
function function_4792c4cc() {
    level endon(#"hash_b21dcc36");
    level endon(#"hash_98a72693");
    var_be61cb01 = getent("clip_garage_door", "targetname");
    if (!isdefined(var_be61cb01)) {
        return;
    }
    var_be61cb01 setcandamage(1);
    while (true) {
        damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags = var_be61cb01 waittill(#"damage");
        if (isdefined(weapon) && isdefined(weapon.name)) {
            if (weapon.name == "turret_bo3_mil_macv_gunner1" || weapon.name == "turret_bo3_mil_macv_gunner2" || weapon.name == "turret_bo3_mil_macv_gunner3" || weapon.name == "turret_bo3_mil_macv_gunner4") {
                var_be61cb01 delete();
                level flag::set("apc_thru_door");
            }
        }
    }
}

// Namespace apc
// Params 2, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_50d6bf35
// Checksum 0x48d617cb, Offset: 0x3010
// Size: 0x1b2
function function_50d6bf35(var_6c5c89e1, b_start) {
    vehicle::add_spawn_function("apc", &function_c695b790, b_start);
    var_503961a8 = 0;
    var_9c9766b2 = 0;
    if (var_6c5c89e1 == "nd_stall_start") {
        level.apc = vehicle::simple_spawn_single("apc_stall");
        level.apc.animname = "apc";
        var_503961a8 = 1;
        var_9c9766b2 = 1;
    } else {
        level.apc = vehicle::simple_spawn_single("apc");
        level.apc setcandamage(0);
        level.apc setseatoccupied(1, 1);
        level.apc setseatoccupied(2, 1);
        level.apc setseatoccupied(3, 1);
        level.apc setseatoccupied(4, 1);
    }
    level flag::wait_till("all_players_spawned");
    level function_87f36425(var_6c5c89e1, b_start);
    level function_faafa578();
    level thread function_38362d1e();
    level.apc thread function_8dc833e9(var_503961a8, var_9c9766b2);
    setdvar("vehicle_selfCollision", 1);
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_c695b790
// Checksum 0x67514072, Offset: 0x31d0
// Size: 0x102
function function_c695b790(b_start) {
    self vehicle::lights_off();
    level flag::wait_till("players_are_in_apc");
    playsoundatposition("veh_apc_startup", self.origin);
    self playloopsound("veh_apc_idle", 3);
    level util::clientnotify("sndStopGarage");
    if (!b_start) {
        foreach (player in level.activeplayers) {
            player playrumbleonentity("cp_prologue_rumble_apc_engine_start");
        }
    }
    wait(1);
    self vehicle::lights_on();
}

// Namespace apc
// Params 2, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_8dc833e9
// Checksum 0xadef94fa, Offset: 0x32e0
// Size: 0xc5
function function_8dc833e9(var_503961a8, var_d74d752a) {
    if (!isdefined(var_503961a8)) {
        var_503961a8 = 0;
    }
    if (!isdefined(var_d74d752a)) {
        var_d74d752a = 0;
    }
    self endon(#"death");
    self endon(#"hash_ab8f1b97");
    var_adc2b62f = [];
    var_adc2b62f[0] = level._effect["apc_dmg_low"];
    var_adc2b62f[1] = level._effect["apc_dmg_high"];
    n_current = 0;
    while (true) {
        if (var_d74d752a == 0) {
            self waittill(#"hash_96522489");
        }
        playfxontag(var_adc2b62f[n_current], self, "tag_origin");
        n_current++;
        if (var_d74d752a > 0) {
            var_d74d752a--;
        }
        if (n_current >= var_adc2b62f.size) {
            return;
        }
    }
}

/#

    // Namespace apc
    // Params 0, eflags: 0x0
    // namespace_1eb7e8f5<file_0>::function_514ce5dd
    // Checksum 0x38c510d1, Offset: 0x33b0
    // Size: 0x9d
    function function_514ce5dd() {
        while (true) {
            while (!level.players[0] jumpbuttonpressed() || !level.players[0] attackbuttonpressed()) {
                wait(0.05);
            }
            level.apc notify(#"hash_96522489");
            while (level.players[0] jumpbuttonpressed() || level.players[0] attackbuttonpressed()) {
                wait(0.05);
            }
        }
    }

#/

// Namespace apc
// Params 2, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_87f36425
// Checksum 0xf7ace21a, Offset: 0x3458
// Size: 0xa2
function function_87f36425(var_6c5c89e1, b_start) {
    level thread function_2309bb98(var_6c5c89e1, b_start);
    if (level.var_31aefea8 != "skipto_apc_rail_stall" && level.var_31aefea8 != "skipto_apc_rail") {
        level thread function_ade89a8a();
    }
    level thread function_29c3397f();
    level.apc makevehicleunusable();
    level.apc setseatoccupied(0);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_81a9e31c
// Checksum 0xf9c3cdcb, Offset: 0x3508
// Size: 0x10a
function function_81a9e31c() {
    level.var_586b4bd0 = 0;
    level.var_4480630f = array("gunner1", "gunner2", "gunner3", "gunner4");
    var_3f213c83 = getentarray("t_enter_apc", "targetname");
    array::run_all(var_3f213c83, &triggerenable, 0);
    var_718396de = getent("m_tunnel_vtol_death", "targetname");
    var_718396de hide();
    level thread scene::init("p7_fxanim_cp_prologue_apc_door_01_open_bundle");
    level thread scene::init("p7_fxanim_cp_prologue_apc_door_02_open_bundle");
    level thread scene::init("p7_fxanim_cp_prologue_apc_door_03_dent_bundle");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_258a16c
// Checksum 0xdbe6bce7, Offset: 0x3620
// Size: 0x72
function function_258a16c() {
    if (isdefined(level.var_f58c9f31)) {
        level.var_f58c9f31 delete();
    }
    if (isdefined(level.var_7f246cd7)) {
        level.var_7f246cd7 delete();
    }
    if (isdefined(level.var_5d4087a6)) {
        level.var_5d4087a6 delete();
    }
    namespace_12501af4::function_c2619de1();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_7ef8f611
// Checksum 0x799c6456, Offset: 0x36a0
// Size: 0x59
function function_7ef8f611() {
    a_ai = getaiteamarray("axis");
    if (isdefined(a_ai)) {
        for (i = 0; i < a_ai.size; i++) {
            a_ai[i] delete();
        }
    }
}

// Namespace apc
// Params 2, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_c1b99214
// Checksum 0x5b113493, Offset: 0x3708
// Size: 0x21a
function function_c1b99214(objective, var_74cd64bc) {
    cp_mi_eth_prologue::function_77d9dff("objective_apc_rail_init");
    if (var_74cd64bc) {
        load::function_73adcefc();
        level thread namespace_2cb3876f::function_cfabe921();
        battlechatter::function_d9f49fba(0);
        level.var_92d245e2 = util::function_740f8516("prometheus");
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level namespace_2cb3876f::function_6a5f89cb("skipto_apc_rail_ai");
        level function_50d6bf35("vehicle_apc_hijack_node", 1);
        load::function_a2995f22();
        level function_26fb0662();
        level.var_92d245e2 setgoal(level.var_92d245e2.origin, 1);
        level.var_2fd26037 setgoal(level.var_2fd26037.origin, 1);
        level.var_2fd26037 vehicle::get_in(level.apc, "driver", 1);
        level flag::set("apc_unlocked");
        level flag::set("apc_ready");
        level thread function_5c1321b9();
        level thread function_b31512cf();
        level thread function_651e7b34(0);
        level thread function_599ebca1();
        wait(0.1);
        level flag::set("garage_dent");
        level thread function_e928ca6f();
    }
    function_e41aeec0();
}

// Namespace apc
// Params 4, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_961480e7
// Checksum 0xfdb8121a, Offset: 0x3930
// Size: 0x3a
function function_961480e7(name, var_74cd64bc, var_e4cd2b8b, player) {
    cp_mi_eth_prologue::function_77d9dff("apc_rail_done");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_e41aeec0
// Checksum 0xc5bf14de, Offset: 0x3978
// Size: 0x222
function function_e41aeec0() {
    level.apc setmodel("veh_t7_mil_macv_prologue_optimized");
    var_b7007b04 = vehicle::simple_spawn("truck_parked_one");
    foreach (var_a9993ca4 in var_b7007b04) {
        var_a9993ca4.overridevehicledamage = &function_2923c71;
        var_a9993ca4.overridevehiclekilled = &function_afd7b227;
    }
    var_45900c37 = vehicle::simple_spawn_single("truck_challenge_1");
    var_45900c37.overridevehiclekilled = &function_afd7b227;
    var_45900c37.overridevehicledamage = &function_2923c71;
    level thread function_2f99d976();
    level thread function_3a615091();
    level flag::wait_till("players_are_in_apc");
    level flag::wait_till("ai_in_apc");
    wait(1);
    mdl_clip = getent("clip_garage_exit", "targetname");
    if (isdefined(mdl_clip)) {
        mdl_clip delete();
    }
    level thread function_8ff9807e();
    level thread function_8d1d7010();
    level thread function_83f90899();
    level thread function_9e863a52();
    level thread function_4b0777ee();
    level thread function_809f2e11();
    level thread function_4eae0e09();
    exploder::exploder("light_exploder_rails_stall");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_2f99d976
// Checksum 0x8c7bb37f, Offset: 0x3ba8
// Size: 0xea
function function_2f99d976() {
    level flag::wait_till("apc_rail_begin");
    level.var_2fd26037 dialog::say("hend_get_ready_we_gotta_0", 0.5);
    level flag::wait_till("apc_thru_door");
    level thread namespace_21b2c1f2::function_da98f0c7();
    var_49b32118 = getent("pa_nrc_warning", "targetname");
    var_49b32118 dialog::say("nrcp_infiltrators_moving_1", 0.5, 1);
    trigger::wait_till("t_apc_sees_vtols");
    level.var_2fd26037 dialog::say("hend_focus_fire_on_that_b_0");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_3a615091
// Checksum 0xb117184, Offset: 0x3ca0
// Size: 0xb2
function function_3a615091() {
    trigger::wait_till("trigger_reached_roadblock");
    level.var_2fd26037 dialog::say("hend_we_gotta_take_a_deto_0", 0.5);
    trigger::wait_till("trigger_roadblock_bypass");
    level.var_2fd26037 dialog::say("hend_apc_from_the_right_0");
    trigger::wait_till("ambush_vtol_takeoff");
    level.var_2fd26037 dialog::say("hend_inbound_vtol_redire_0", 1);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_4b0777ee
// Checksum 0x4aee07a, Offset: 0x3d60
// Size: 0x1aa
function function_4b0777ee() {
    vehicle::add_spawn_function("garage_truck1", &namespace_2cb3876f::function_9af14b02, "reached_roadblock", 3);
    vehicle::add_spawn_function("garage_truck2", &namespace_2cb3876f::function_9af14b02, "reached_roadblock", 3);
    vehicle::add_spawn_function("garage_truck2", &function_67348f4b);
    spawner::add_spawn_function_group("group_garage_trucker", "script_aigroup", &namespace_2cb3876f::function_1db6047f, "trigger_spawn_roadblock");
    trigger::wait_till("trigger_door_smash");
    var_b337b3dc = vehicle::simple_spawn_single("garage_truck1");
    var_b337b3dc.overridevehicledamage = &function_2923c71;
    var_b337b3dc.overridevehiclekilled = &function_afd7b227;
    trigger::wait_till("trig_cleanup_intro_garage");
    wait(1.5);
    var_253f2317 = vehicle::simple_spawn_single("garage_truck2");
    var_253f2317.overridevehicledamage = &function_2923c71;
    var_253f2317.overridevehiclekilled = &function_afd7b227;
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_9e863a52
// Checksum 0x3b5d7eee, Offset: 0x3f18
// Size: 0x112
function function_9e863a52() {
    level flag::wait_till("apc_thru_door");
    vehicle::add_spawn_function("vtol_right", &function_5cc1f320);
    vehicle::add_spawn_function("vtol_left", &function_282b068c);
    vehicle::add_spawn_function("truck_parked_1", &function_9b11b2b2);
    vehicle::simple_spawn_single("vtol_right");
    vehicle::simple_spawn_single("vtol_left");
    trigger::wait_till("t_helipad_guys");
    var_45900c37 = vehicle::simple_spawn_single("truck_parked_1");
    var_45900c37.overridevehiclekilled = &function_afd7b227;
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_9b11b2b2
// Checksum 0x85a873e7, Offset: 0x4038
// Size: 0x7a
function function_9b11b2b2() {
    self endon(#"death");
    self.overridevehicledamage = &function_2923c71;
    self vehicle::lights_off();
    trigger::wait_till("t_rail_ambush_apc");
    self.delete_on_death = 1;
    self notify(#"death");
    if (!isalive(self)) {
        self delete();
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_5cc1f320
// Checksum 0x483985a6, Offset: 0x40c0
// Size: 0x15a
function function_5cc1f320() {
    self endon(#"death");
    self.overridevehiclekilled = &function_a6ea2383;
    self vehicle::lights_off();
    self vehicle::toggle_sounds(0);
    self.do_scripted_crash = 0;
    trigger::wait_till("t_apc_sees_vtols");
    self vehicle::lights_on();
    self playsoundontag("evt_apcrail_vtol1_takeoff", "tag_barrel");
    self thread function_d20ef450();
    wait(0.25);
    self thread vehicle::get_on_and_go_path(getvehiclenode(self.target, "targetname"));
    wait(0.5);
    self.do_scripted_crash = 1;
    for (i = 0; i < 3; i++) {
        self turret::enable(i, 0);
    }
    self waittill(#"reached_end_node");
    self.delete_on_death = 1;
    self notify(#"death");
    if (!isalive(self)) {
        self delete();
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_282b068c
// Checksum 0xa789a61a, Offset: 0x4228
// Size: 0xba
function function_282b068c() {
    self endon(#"death");
    self.overridevehiclekilled = &function_a6ea2383;
    self vehicle::toggle_sounds(0);
    self thread function_826bc065();
    spawn_manager::enable("sm_vtol_guard");
    level flag::wait_till("robot_swarm");
    spawn_manager::kill("sm_vtol_guard", 1);
    self.delete_on_death = 1;
    self notify(#"death");
    if (!isalive(self)) {
        self delete();
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_826bc065
// Checksum 0xc921b6de, Offset: 0x42f0
// Size: 0x32
function function_826bc065() {
    position = self.origin;
    self waittill(#"death");
    playsoundatposition("evt_apcride_vtolpad_explo", position);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_3d6b0c2e
// Checksum 0x1bd665fc, Offset: 0x4330
// Size: 0x42
function function_3d6b0c2e() {
    self endon(#"death");
    self waittill(#"reached_end_node");
    wait(1);
    self thread function_a942e878(level.apc.origin, level.apc.origin);
}

// Namespace apc
// Params 3, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_a942e878
// Checksum 0xa81b22d1, Offset: 0x4380
// Size: 0xe9
function function_a942e878(var_cd13e495, var_8f45fdaa, var_da05687c) {
    self endon(#"death");
    v_left = self gettagorigin("tag_rocket_left");
    v_right = self gettagorigin("tag_rocket_right");
    if (isdefined(var_da05687c)) {
        var_8af78429 = getweapon(var_da05687c);
    } else {
        var_8af78429 = getweapon("hunter_rocket_turret");
    }
    var_b76e95dc = [];
    var_b76e95dc[0] = magicbullet(var_8af78429, v_left, var_cd13e495, self);
    wait(0.2);
    var_b76e95dc[1] = magicbullet(var_8af78429, v_right, var_8f45fdaa, self);
    return var_b76e95dc;
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_83f90899
// Checksum 0xc482eb35, Offset: 0x4478
// Size: 0x192
function function_83f90899() {
    var_866451b = vehicle::simple_spawn_single("attack_ambush_vtol");
    var_866451b.overridevehiclekilled = &function_a6ea2383;
    var_866451b util::magic_bullet_shield();
    var_866451b thread function_7d33cac1();
    spawner::add_spawn_function_group("apex_garage_humans", "targetname", &function_4dbae164);
    level thread function_e3e24f64("intro_road_humans", "trig_first_crawler", "trig_cleanup_apex_garage");
    level thread function_5b0849af();
    level thread function_e3e24f64("apex_garage_humans", "trig_cleanup_intro_garage", "trig_cleanup_apex_garage");
    level thread function_b6adac49();
    level thread function_3da7ede0();
    level thread function_ff99c927();
    level thread function_e3e24f64("helipad_human", "trigger_helipad_guards", "trigger_roadblock_bypass");
    level thread function_3c04ed4b();
    level flag::wait_till("spawn_road_robots");
    spawner::simple_spawn("intro_road_robots", &function_722f45c3);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_4dbae164
// Checksum 0x5dcce3f7, Offset: 0x4618
// Size: 0x72
function function_4dbae164() {
    s_goal = struct::get("garage_guy_pos");
    a_v_points = util::positionquery_pointarray(s_goal.origin, 64, -56, 70, 40);
    self setgoal(a_v_points[randomint(a_v_points.size)], 1);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_722f45c3
// Checksum 0xfb5746e5, Offset: 0x4698
// Size: 0x32
function function_722f45c3() {
    self endon(#"death");
    trigger::wait_till("trig_cleanup_apex_garage");
    self delete();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_ff99c927
// Checksum 0x9ea39fc, Offset: 0x46d8
// Size: 0x15a
function function_ff99c927() {
    spawner::add_spawn_function_group("roadblock_guard", "targetname", &function_b3a3ec26);
    spawner::add_spawn_function_group("group_roadblock", "script_aigroup", &namespace_2cb3876f::function_1db6047f, "t_offroad_enemies");
    spawner::add_spawn_function_group("parking_guard", "script_aigroup", &namespace_2cb3876f::function_1db6047f, "t_offroad_enemies");
    trigger::wait_till("trigger_garage_cleanup");
    spawn_manager::enable("sm_roadblock_guard");
    trigger::wait_till("trigger_spawn_roadblock");
    wait(6);
    spawner::simple_spawn_single("parking_guard1", &function_a22f604f, "truck_parked_1", "driver");
    spawner::simple_spawn_single("parking_guard2", &function_a22f604f, "truck_parked_1", "gunner1");
}

// Namespace apc
// Params 2, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_a22f604f
// Checksum 0x24e560d4, Offset: 0x4840
// Size: 0x6a
function function_a22f604f(str_vehicle, str_pos) {
    self endon(#"death");
    var_1d874f37 = getent(str_vehicle + "_vh", "targetname");
    if (isalive(var_1d874f37)) {
        self thread vehicle::get_in(var_1d874f37, str_pos, 0);
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_b3a3ec26
// Checksum 0xe4fa65c1, Offset: 0x48b8
// Size: 0x7a
function function_b3a3ec26() {
    self endon(#"death");
    level flag::wait_till("reached_roadblock");
    self ai::set_ignoreall(1);
    self setgoal(struct::get(self.script_noteworthy).origin, 1);
    self waittill(#"goal");
    self delete();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_3da7ede0
// Checksum 0x1bf85599, Offset: 0x4940
// Size: 0x14a
function function_3da7ede0() {
    level flag::wait_till("spawn_roadblock");
    var_1e13503b = vehicle::simple_spawn_single("macv_roadblock");
    var_1e13503b.overridevehicledamage = &function_2923c71;
    var_1e13503b.overridevehiclekilled = &function_afd7b227;
    var_1e13503b endon(#"death");
    var_1e13503b thread vehicle::get_on_and_go_path(getvehiclenode(var_1e13503b.target, "targetname"));
    for (i = 1; i <= 2; i++) {
        var_1e13503b thread turret::disable_ai_getoff(i, 1);
        var_1e13503b thread turret::shoot_at_target(level.apc, 3, undefined, i, 0);
    }
    wait(3);
    for (i = 1; i <= 4; i++) {
        var_1e13503b turret::enable(i, 1);
    }
    level flag::wait_till("player_in_tunnel");
    var_1e13503b thread namespace_2cb3876f::function_3a642801();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_b6adac49
// Checksum 0x1732a8d2, Offset: 0x4a98
// Size: 0x64
function function_b6adac49() {
    level flag::wait_till("spawn_roadblock");
    vehicle::add_spawn_function("helipad_roadbloack_trucks", &function_ea1ff9c4);
    var_11e46f4e = vehicle::simple_spawn("helipad_roadbloack_trucks");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_ea1ff9c4
// Checksum 0x962841bc, Offset: 0x4b08
// Size: 0x102
function function_ea1ff9c4() {
    self endon(#"death");
    self.overridevehicledamage = &function_2923c71;
    self.overridevehiclekilled = &function_afd7b227;
    self thread vehicle::get_on_and_go_path(getvehiclenode(self.target, "targetname"));
    self thread function_178c0a7a();
    v_offset = (randomintrange(-80, 80), randomintrange(-80, 80), randomintrange(80, 100));
    self thread turret::shoot_at_target(level.apc, 8, v_offset, 1, 0);
    level flag::wait_till("player_in_tunnel");
    self thread namespace_2cb3876f::function_3a642801();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_178c0a7a
// Checksum 0xd8befff4, Offset: 0x4c18
// Size: 0x9b
function function_178c0a7a() {
    self endon(#"death");
    self waittill(#"reached_end_node");
    foreach (ai_rider in self.riders) {
        if (isalive(ai_rider) && ai_rider.script_startingposition != "gunner1") {
            ai_rider thread namespace_2cb3876f::function_2f943869();
        }
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_3c04ed4b
// Checksum 0x22d99895, Offset: 0x4cc0
// Size: 0xaa
function function_3c04ed4b() {
    trigger::wait_till("trigger_chaser");
    vehicle::add_spawn_function("macv_chaser1", &function_61f3859c);
    vehicle::simple_spawn("macv_chaser1");
    if (level.activeplayers.size > 1) {
        vehicle::add_spawn_function("macv_chaser2", &function_61f3859c);
        vehicle::simple_spawn("macv_chaser2");
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_61f3859c
// Checksum 0xb3df70a, Offset: 0x4d78
// Size: 0x142
function function_61f3859c() {
    self endon(#"death");
    self util::magic_bullet_shield();
    self.overridevehicledamage = &function_2923c71;
    self.overridevehiclekilled = &function_afd7b227;
    self thread vehicle::get_on_and_go_path(getvehiclenode(self.target, "targetname"));
    self thread function_3ef12439();
    for (i = 1; i <= 4; i++) {
        self thread turret::shoot_at_target(level.apc, 8, undefined, i, 0);
    }
    self waittill(#"hash_63884d2d");
    self util::stop_magic_bullet_shield();
    trigger::wait_till("ambush_vtol_takeoff");
    for (i = 1; i <= 4; i++) {
        self thread turret::stop(i);
    }
    self notify(#"hash_b6c30be8");
    self waittill(#"reached_end_node");
    self kill();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_3ef12439
// Checksum 0xe1e510d2, Offset: 0x4ec8
// Size: 0x4a
function function_3ef12439() {
    self endon(#"hash_b6c30be8");
    self waittill(#"death");
    if (self.is_talking === 1) {
        self waittill(#"hash_90f83311");
    }
    level.var_2fd26037 dialog::say("hend_nice_fucking_shootin_0");
}

// Namespace apc
// Params 3, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_e3e24f64
// Checksum 0x28c9e939, Offset: 0x4f20
// Size: 0x10b
function function_e3e24f64(str_spawner, var_421fd9c7, var_fe7e3b3a) {
    var_6d6eaca4 = str_spawner + "_ai";
    if (isdefined(var_421fd9c7)) {
        trigger::wait_till(var_421fd9c7);
    }
    spawner::simple_spawn(str_spawner, &function_322a61a9);
    e_trigger = getent(var_fe7e3b3a, "targetname");
    e_trigger waittill(#"trigger");
    var_3f508c44 = getentarray(var_6d6eaca4, "targetname");
    foreach (var_5abbae22 in var_3f508c44) {
        if (isdefined(var_5abbae22)) {
            var_5abbae22 delete();
        }
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_322a61a9
// Checksum 0x48174c93, Offset: 0x5038
// Size: 0x1a
function function_322a61a9() {
    self.overrideactordamage = &function_d73ad05a;
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_1d1df80f
// Checksum 0x23a9ea34, Offset: 0x5060
// Size: 0x7a
function function_1d1df80f() {
    self endon(#"death");
    var_d28b337 = getvehiclenode("nd_humans_run_away", "script_noteworthy");
    var_d28b337 waittill(#"trigger");
    var_19c8d8db = getnode("nd_humans_run_away", "targetname");
    self thread ai::force_goal(var_19c8d8db, 32, 1);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_dccdf588
// Checksum 0xa5de08b7, Offset: 0x50e8
// Size: 0xaa
function function_dccdf588() {
    self endon(#"death");
    self.goalradius = 4;
    self setgoal(self.origin, 1);
    self thread function_eccbf04a();
    level flag::wait_till("apc_thru_door");
    self ai::set_ignoreall(0);
    var_20c0a07b = getvehiclenode("nd_cleanup_garage_attackers", "script_noteworthy");
    var_20c0a07b waittill(#"trigger");
    self delete();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_eccbf04a
// Checksum 0x42c775d8, Offset: 0x51a0
// Size: 0x42
function function_eccbf04a() {
    level endon(#"hash_b21dcc36");
    level waittill(#"hash_98a72693");
    self ai::set_ignoreall(0);
    self ai::set_behavior_attribute("move_mode", "rusher");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_5b0849af
// Checksum 0x493f8586, Offset: 0x51f0
// Size: 0x35
function function_5b0849af() {
    var_474ca92e = getvehiclenode("nd_open_garage", "script_noteworthy");
    var_474ca92e waittill(#"trigger");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_8ff9807e
// Checksum 0x771db720, Offset: 0x5230
// Size: 0x26a
function function_8ff9807e() {
    level flag::set("apc_rail_begin");
    level.apc playsound("evt_apc_railstart");
    level thread function_5e86daf4();
    level.apc.goalradius = -126;
    level.apc thread vehicle::get_on_and_go_path(getvehiclenode("vehicle_apc_hijack_node", "targetname"));
    level.apc thread function_b328d415();
    level.apc thread function_4d508278();
    level.apc thread function_9d87900e();
    level thread function_b86a90c3();
    level thread function_e928ca6f();
    level thread function_97fa5e1d();
    trigger::wait_till("t_rail_ambush_apc");
    level thread scene::play("p7_fxanim_cp_prologue_pump_station_crash_bundle");
    foreach (player in level.activeplayers) {
        player playrumbleonentity("cp_prologue_rumble_apc_offroad");
    }
    level.apc waittill(#"reached_end_node");
    level.apc stoploopsound(2);
    foreach (player in level.activeplayers) {
        player playrumbleonentity("cp_prologue_rumble_apc_offroad");
    }
    namespace_2cb3876f::function_b50f5d52();
    exploder::stop_exploder("light_exploder_rails_stall");
    skipto::function_be8adfb8("skipto_apc_rail");
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_e928ca6f
// Checksum 0x6b6e40ce, Offset: 0x54a8
// Size: 0x112
function function_e928ca6f(var_1af3ff57) {
    if (!isdefined(var_1af3ff57)) {
        var_1af3ff57 = 0;
    }
    level notify(#"hash_d9c09629");
    level endon(#"hash_d9c09629");
    if (!isdefined(level.var_f9bd5790)) {
        level.var_f9bd5790 = [];
        if (!var_1af3ff57) {
            level.var_f9bd5790["first_turnaround"] = &function_da78deb1;
            level.var_aaf3820c = array("first_turnaround", "vtol_tunnel");
        } else {
            level.var_aaf3820c = array("vtol_tunnel");
        }
        level.var_f9bd5790["vtol_tunnel"] = &function_9eeeaa5d;
    }
    level thread function_be3e569a();
    level flag::wait_till("apc_rail_fail");
    level [[ level.var_f9bd5790[level.var_b5d119f0] ]]();
    util::function_207f8667(%CP_MI_ETH_PROLOGUE_GARAGE_FAIL);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_da78deb1
// Checksum 0x30c98281, Offset: 0x55c8
// Size: 0x10b
function function_da78deb1() {
    var_6e104714 = (0, 0, 48);
    var_1f75b80a = struct::get_array("apc_fail_rocket_structs", "targetname");
    var_8af78429 = getweapon("launcher_standard_magic_bullet");
    for (i = 0; i < 2; i++) {
        var_b76e95dc = [];
        var_b76e95dc[0] = magicbullet(var_8af78429, var_1f75b80a[0].origin, level.apc.origin + var_6e104714, undefined, level.apc);
        wait(0.1);
        var_b76e95dc[1] = magicbullet(var_8af78429, var_1f75b80a[1].origin, level.apc.origin + var_6e104714, undefined, level.apc);
    }
    var_b76e95dc[0] waittill(#"death");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_9eeeaa5d
// Checksum 0x9398d1a3, Offset: 0x56e0
// Size: 0x84
function function_9eeeaa5d() {
    level notify(#"hash_8b1044c1");
    var_edc6e0e1 = getent("fxanim_vtol_tunnel", "targetname", 1);
    var_b76e95dc = var_edc6e0e1 function_a942e878(level.apc.origin, level.apc.origin, "launcher_standard_magic_bullet");
    var_b76e95dc[var_b76e95dc.size - 1] waittill(#"death");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_be3e569a
// Checksum 0x949b66b7, Offset: 0x5770
// Size: 0x149
function function_be3e569a() {
    level endon(#"hash_d9c09629");
    for (i = 0; i < level.var_aaf3820c.size; i++) {
        level.var_b5d119f0 = level.var_aaf3820c[i];
        foreach (player in level.players) {
            player.var_52a8c6b = 0;
            player thread function_2de9c217();
        }
        level waittill(#"hash_9d265855");
        var_c25b6cc2 = 1;
        foreach (player in level.players) {
            if (isdefined(player.var_52a8c6b) && player.var_52a8c6b) {
                var_c25b6cc2 = 0;
            }
        }
        if (var_c25b6cc2) {
            flag::set("apc_rail_fail");
            return;
        }
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_2de9c217
// Checksum 0x703fa55c, Offset: 0x58c8
// Size: 0x51
function function_2de9c217() {
    self notify(#"hash_837aa23e");
    self endon(#"death");
    self endon(#"hash_837aa23e");
    level endon(#"hash_d9c09629");
    while (true) {
        if (self attackbuttonpressed()) {
            self.var_52a8c6b = 1;
            return;
        }
        wait(0.05);
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_b86a90c3
// Checksum 0x8e5b4759, Offset: 0x5928
// Size: 0x5a
function function_b86a90c3() {
    var_4253be48 = getvehiclenode("nd_garage_attackers", "script_noteworthy");
    var_4253be48 waittill(#"trigger");
    level.apc thread function_219a1e60();
    function_6ac512e();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_97fa5e1d
// Checksum 0x7b9fd94, Offset: 0x5990
// Size: 0x9a
function function_97fa5e1d() {
    level flag::wait_till("delete_garage_allies");
    if (isdefined(level.var_92d245e2)) {
        level.var_92d245e2 delete();
    }
    if (isdefined(level.var_f58c9f31)) {
        level.var_f58c9f31 delete();
    }
    if (isdefined(level.var_7f246cd7)) {
        level.var_7f246cd7 delete();
    }
    if (isdefined(level.var_5d4087a6)) {
        level.var_5d4087a6 delete();
    }
}

// Namespace apc
// Params 2, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_2ac0c49
// Checksum 0xfd4757df, Offset: 0x5a38
// Size: 0x20a
function function_2ac0c49(objective, var_74cd64bc) {
    cp_mi_eth_prologue::function_77d9dff("objective_apc_rail_stall_init");
    if (var_74cd64bc) {
        load::function_73adcefc();
        level thread scene::skipto_end("p7_fxanim_cp_prologue_pump_station_crash_bundle");
        level thread namespace_2cb3876f::function_cfabe921();
        battlechatter::function_d9f49fba(0);
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level namespace_2cb3876f::function_6a5f89cb("skipto_apc_rail_stall_ai");
        level function_50d6bf35("nd_stall_start", 0);
        load::function_a2995f22();
        exploder::exploder("fx_exploder_fog_part_01");
        level function_26fb0662();
        level.var_2fd26037 vehicle::get_in(level.apc, "driver", 1);
        var_8d053b4 = getent("t_rail_ambush_apc", "targetname");
        physicsexplosioncylinder(var_8d053b4.origin, -106, -106, 2);
        level flag::wait_till("players_are_in_apc");
        level flag::set("apc_unlocked");
        level flag::set("apc_ready");
        level thread function_5c1321b9();
        level thread function_599ebca1();
        level thread function_809f2e11();
        level thread function_e928ca6f(1);
    }
    function_fa4b82f9();
}

// Namespace apc
// Params 4, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_fbfbaee6
// Checksum 0x276061c7, Offset: 0x5c50
// Size: 0x18a
function function_fbfbaee6(name, var_74cd64bc, var_e4cd2b8b, player) {
    exploder::stop_exploder("light_exploder_cameraroom");
    exploder::stop_exploder("light_exploder_prison_door");
    exploder::stop_exploder("light_exploder_prison_exit");
    exploder::stop_exploder("light_exploder_torture_rooms");
    exploder::stop_exploder("light_lift_panel_red");
    exploder::stop_exploder("light_lift_panel_green");
    exploder::stop_exploder("light_exploder_lift_inside");
    exploder::stop_exploder("light_exploder_lift_rising");
    exploder::stop_exploder("light_exploder_igc_cybersoldier");
    exploder::stop_exploder("light_exploder_bridge");
    exploder::stop_exploder("light_exploder_darkbattle");
    exploder::stop_exploder("light_exploder_vtol_tackle_fire");
    level.friendlyfiredisabled = 0;
    cp_mi_eth_prologue::function_77d9dff("apc_rail_stall_done");
    if (isdefined(level.apc)) {
        level.apc setmodel("veh_t7_mil_macv");
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_fa4b82f9
// Checksum 0x1dbae9ec, Offset: 0x5de8
// Size: 0x4f2
function function_fa4b82f9() {
    namespace_2cb3876f::function_b50f5d52();
    var_b7007b04 = vehicle::simple_spawn("truck_parked_two");
    foreach (var_a9993ca4 in var_b7007b04) {
        var_a9993ca4.overridevehicledamage = &function_2923c71;
    }
    var_45900c37 = vehicle::simple_spawn_single("truck_challenge_2");
    var_45900c37.overridevehicledamage = &function_2923c71;
    var_45900c37.overridevehiclekilled = &function_afd7b227;
    level.apc vehicle::lights_off();
    level thread function_4c84e244();
    level thread function_855b7b87();
    level thread function_7bfe936c();
    level thread function_2e621ac9();
    level thread function_643f155c();
    level thread function_80e4d901();
    level thread function_5c3fc7c6();
    level thread function_370bf66();
    if (isdefined(level.var_5e84772b)) {
        level thread [[ level.var_5e84772b ]]();
    }
    level flag::wait_till("apc_resume");
    level.apc playsound("evt_apc_vtol_takeoff");
    level.apc playloopsound("veh_railapc_move_lp", 3);
    nd_start = getvehiclenode("nd_stall_start", "targetname");
    level.apc util::delay(1, undefined, &vehicle::get_on_and_go_path, nd_start);
    vehicle::add_spawn_function("tunnel_chase_apc", &namespace_2cb3876f::function_bd761fba, "tunnel_vtol_hit");
    vehicle::add_spawn_function("tunnel_truck", &namespace_2cb3876f::function_bd761fba, "tunnel_vtol_hit");
    var_418b69a6 = vehicle::simple_spawn_single_and_drive("tunnel_chase_apc");
    var_418b69a6.overridevehicledamage = &function_2923c71;
    var_418b69a6.overridevehiclekilled = &function_afd7b227;
    var_e71aed84 = vehicle::simple_spawn_single("tunnel_truck");
    var_e71aed84.overridevehicledamage = &function_2923c71;
    var_e71aed84.overridevehiclekilled = &function_afd7b227;
    level thread function_2ceecfc0();
    level thread function_870b1c2();
    level thread function_e3e24f64("tunnel_roadblock_guard", "trigger_tunnel_guards", "trig_cleanup_tunnel_roadblock");
    var_919a5632 = getent("trig_player_in_tunnel", "targetname");
    var_919a5632 waittill(#"trigger");
    level flag::set("player_in_tunnel");
    level thread function_704f0351();
    level thread function_f0e1f99();
    level.apc waittill(#"reached_end_node");
    level.apc stoploopsound(2);
    level.apc clearvehgoalpos();
    level thread function_aac37081();
    foreach (e_player in level.players) {
        e_player notify(#"hash_ee92aeb6");
    }
    level flag::set("apc_crash");
    level thread namespace_21b2c1f2::function_27bc11a3();
    level flag::wait_till("apc_done");
    skipto::function_be8adfb8("skipto_apc_rail_stall");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_aac37081
// Checksum 0x88618acf, Offset: 0x62e8
// Size: 0x2fa
function function_aac37081() {
    level thread namespace_2cb3876f::function_b50f5d52();
    level thread scene::add_scene_func("cin_pro_17_01_robotdefend_vign_apc_exit_frontleft", &function_a51eb84, "done");
    level thread scene::add_scene_func("cin_pro_17_01_robotdefend_vign_apc_exit_frontleft", &namespace_835fda7e::function_a4e4e77d, "play");
    s_scene = struct::get("tag_align_robot_defend2");
    foreach (player in level.activeplayers) {
        if (player.vehicleposition == 1) {
            player.var_26e12b3 = "cin_pro_17_01_robotdefend_vign_apc_exit_frontleft";
            continue;
        }
        if (player.vehicleposition == 2) {
            player.var_26e12b3 = "cin_pro_17_01_robotdefend_vign_apc_exit_frontright";
            continue;
        }
        if (player.vehicleposition == 3) {
            player.var_26e12b3 = "cin_pro_17_01_robotdefend_vign_apc_exit_rearright";
            continue;
        }
        if (player.vehicleposition == 4) {
            player.var_26e12b3 = "cin_pro_17_01_robotdefend_vign_apc_exit_rearleft";
        }
    }
    level thread function_1aa160fc();
    level thread function_7fd9539();
    level namespace_2cb3876f::function_12ce22ee();
    level.var_2fd26037 thread vehicle::get_out();
    foreach (var_e4463170 in level.a_ai_allies) {
        if (isalive(var_e4463170)) {
            var_e4463170 thread vehicle::get_out();
        }
    }
    level thread scene::play("cin_pro_17_01_robotdefend_vign_apc_exit_apc");
    level thread scene::play("cin_pro_17_01_robotdefend_vign_apc_exit_ai");
    level thread scene::play("cin_pro_17_01_robotdefend_vign_apc_exit_hendricks");
    foreach (player in level.activeplayers) {
        if (isalive(player)) {
            level thread scene::play(player.var_26e12b3, player);
        }
    }
    level waittill(#"hash_68000fca");
    level thread namespace_835fda7e::function_8e9f8d38();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_7fd9539
// Checksum 0xb6f6c817, Offset: 0x65f0
// Size: 0x42
function function_7fd9539() {
    level waittill(#"hash_bb097890");
    level util::clientnotify("sndAPC");
    level waittill(#"hash_3c7fea6f");
    level util::clientnotify("sndAPCend");
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_a51eb84
// Checksum 0x74527ef9, Offset: 0x6640
// Size: 0x22
function function_a51eb84(a_ents) {
    level flag::set("apc_done");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_f0e1f99
// Checksum 0x53e7621b, Offset: 0x6670
// Size: 0x2a2
function function_f0e1f99() {
    s_rpg = struct::get("rpg_shot");
    var_7693abd3 = struct::get("derail_1");
    var_48c3c98 = struct::get("derail_2");
    s_exp = struct::get("explosion_derail");
    var_8af78429 = getweapon("launcher_standard");
    level.apc waittill(#"hash_5c1321b9");
    magicbullet(var_8af78429, s_rpg.origin, var_7693abd3.origin);
    wait(0.3);
    level thread fx::play("gen_explosion", struct::get(var_7693abd3.target).origin);
    playsoundatposition("wpn_rocket_explode", struct::get(var_7693abd3.target).origin);
    level.apc waittill(#"hash_492aff01");
    magicbullet(var_8af78429, s_rpg.origin, var_48c3c98.origin);
    wait(0.3);
    level thread fx::play("gen_explosion", struct::get(var_48c3c98.target).origin);
    playsoundatposition("wpn_rocket_explode", struct::get(var_48c3c98.target).origin);
    level.apc waittill(#"hash_c98eccfe");
    wait(0.5);
    magicbullet(var_8af78429, s_rpg.origin, s_exp.origin);
    wait(0.3);
    level thread fx::play("gen_explosion", struct::get(s_exp.target).origin);
    playsoundatposition("wpn_rocket_explode", struct::get(s_exp.target).origin);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_4c84e244
// Checksum 0x7e9e833a, Offset: 0x6920
// Size: 0xea
function function_4c84e244() {
    level flag::set("robot_swarm");
    level thread namespace_21b2c1f2::function_27bc11a3();
    level.var_2fd26037 dialog::say("hend_fuck_damn_piece_of_0", 0.5);
    level thread function_abe568bf();
    wait(2);
    level.var_2fd26037 dialog::say("khal_jacob_start_the_dam_0", 1);
    level.var_2fd26037 dialog::say("hend_what_the_hell_do_you_0", 0.5);
    level.var_2fd26037 dialog::say("hend_hold_them_back_this_0", 0.3);
    wait(5);
    level flag::set("apc_restart");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_855b7b87
// Checksum 0x53bf9fcd, Offset: 0x6a18
// Size: 0x82
function function_855b7b87() {
    level flag::wait_till("apc_engine_started");
    level flag::set("apc_resume");
    level thread namespace_21b2c1f2::function_8feece84();
    level.var_2fd26037 dialog::say("hend_we_re_good_let_s_fu_0");
    level.var_2fd26037 dialog::say("hend_take_out_that_afv_0", 1);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_7bfe936c
// Checksum 0x95517cb9, Offset: 0x6aa8
// Size: 0x15a
function function_7bfe936c() {
    trigger::wait_till("trig_cleanup_tunnel_roadblock");
    level.var_2fd26037 dialog::say("hend_buzzard_dead_ahead_0");
    level.apc dialog::say("dops_drone_in_range_thir_0", 0.5, 1);
    level.apc dialog::say("dops_sending_drop_coordin_0", 1);
    level flag::wait_till("tunnel_vtol_hit");
    level.apc notify(#"hash_96522489");
    level.apc dialog::say("tayr_hendricks_additiona_0", 0.5, 1);
    level.var_2fd26037 dialog::say("hend_copy_that_2", 0.15);
    level flag::wait_till("obs_collapse");
    level.var_2fd26037 dialog::say("hend_going_offroad_exfil_0");
    level.var_2fd26037 dialog::say("hend_fuck_we_re_coming_i_0", 0.15);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_704f0351
// Checksum 0x62a0f348, Offset: 0x6c10
// Size: 0x102
function function_704f0351() {
    vehicle::add_spawn_function("last_truck", &function_6cb71a05);
    vehicle::add_spawn_function("truck_divert1", &function_6cb71a05);
    trigger::wait_till("trigger_truck_divert");
    var_5bde7cd3 = vehicle::simple_spawn_single("truck_divert1");
    var_5bde7cd3.overridevehiclekilled = &function_4ddf39a4;
    trigger::wait_till("trigger_last_roadblock");
    vehicle::simple_spawn("last_truck");
    spawner::simple_spawn("checkpoint_guard");
    wait(1);
    exploder::exploder("light_exploder_rails_roadblock");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_6cb71a05
// Checksum 0x4bab0f0f, Offset: 0x6d20
// Size: 0x102
function function_6cb71a05() {
    self endon(#"death");
    self.overridevehicledamage = &function_2923c71;
    self.overridevehiclekilled = &function_afd7b227;
    self thread vehicle::get_on_and_go_path(getvehiclenode(self.target, "targetname"));
    v_offset = (randomintrange(-80, 80), randomintrange(-80, 80), randomintrange(80, 100));
    self thread turret::shoot_at_target(level.apc, 8, v_offset, 1, 0);
    level flag::wait_till("apc_crash");
    level thread namespace_21b2c1f2::function_27bc11a3();
    self thread namespace_2cb3876f::function_3a642801();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_fbbf6635
// Checksum 0x4ca1b025, Offset: 0x6e30
// Size: 0x102
function function_fbbf6635() {
    self endon(#"death");
    self.overridevehicledamage = &function_2923c71;
    self.overridevehiclekilled = &function_afd7b227;
    self thread vehicle::get_on_and_go_path(getvehiclenode(self.target, "targetname"));
    v_offset = (randomintrange(-80, 80), randomintrange(-80, 80), randomintrange(80, 100));
    self thread turret::shoot_at_target(level.apc, 8, v_offset, 1, 0);
    level flag::wait_till("apc_crash");
    level thread namespace_21b2c1f2::function_27bc11a3();
    self thread namespace_2cb3876f::function_3a642801();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_643f155c
// Checksum 0x1e1c2f9c, Offset: 0x6f40
// Size: 0x14d
function function_643f155c() {
    spawner::add_spawn_function_group("group_ambush_truck", "script_aigroup", &namespace_2cb3876f::function_1db6047f, "apc_hits_truck_in_tunnel");
    var_b23a66fe = vehicle::add_spawn_function("stall_truck", &function_b82df867);
    var_8c37ec95 = vehicle::add_spawn_function("stall_truck_rear", &function_b82df867);
    level flag::wait_till("robot_swarm");
    var_11e46f4e = vehicle::simple_spawn("stall_truck");
    foreach (var_45900c37 in var_11e46f4e) {
        if (level.activeplayers.size > 1) {
            var_f0049a8 = vehicle::simple_spawn("stall_truck_rear");
        }
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_b82df867
// Checksum 0x783fb5df, Offset: 0x7098
// Size: 0x102
function function_b82df867() {
    self endon(#"death");
    self util::magic_bullet_shield();
    self vehicle::lights_off();
    self thread vehicle::get_on_and_go_path(getvehiclenode(self.target, "targetname"));
    self waittill(#"hash_63884d2d");
    wait(2);
    self util::stop_magic_bullet_shield();
    self turret::enable(1, 1);
    self.overridevehicledamage = &function_2923c71;
    self.overridevehiclekilled = &function_afd7b227;
    self waittill(#"reached_end_node");
    self vehicle::lights_on();
    trigger::wait_till("trig_player_in_tunnel");
    self thread namespace_2cb3876f::function_3a642801();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_2e621ac9
// Checksum 0x62764ba9, Offset: 0x71a8
// Size: 0x162
function function_2e621ac9() {
    level flag::wait_till("robot_swarm");
    wait(2);
    level thread function_fc2d6bf3();
    spawner::add_spawn_function_group("ambush_robots_front", "targetname", &function_d8b959d6);
    spawn_manager::enable("sm_ambush_robots_front");
    if (level.activeplayers.size > 1) {
        spawner::add_spawn_function_group("ambush_robots_rear", "targetname", &function_d8b959d6);
        spawn_manager::enable("sm_ambush_robots_rear");
        level thread function_27ee29e6();
        level thread function_4446fa95();
    }
    level thread function_b4145fc1();
    level thread function_35eded54();
    trigger::wait_till("trigger_tunnel_entrance");
    spawn_manager::kill("sm_ambush_robots_front");
    if (level.activeplayers.size > 1) {
        spawn_manager::kill("sm_ambush_robots_rear");
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_d8b959d6
// Checksum 0x2302ffeb, Offset: 0x7318
// Size: 0x9a
function function_d8b959d6() {
    self endon(#"death");
    self ai::set_behavior_attribute("move_mode", "marching");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    wait(1);
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    trigger::wait_till("t_spawn_tunnel_roadblock");
    self delete();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_fc2d6bf3
// Checksum 0xa906da3f, Offset: 0x73c0
// Size: 0x107
function function_fc2d6bf3() {
    level endon(#"hash_2a6578a1");
    var_87783e2a = 4000;
    while (true) {
        var_d96f8b8b = [];
        foreach (corpse in getcorpsearray()) {
            if (isdefined(corpse.birthtime) && isdefined(corpse.archetype) && corpse.archetype == "robot" && corpse.birthtime + var_87783e2a < gettime()) {
                var_d96f8b8b[var_d96f8b8b.size] = corpse;
            }
        }
        for (index = 0; index < var_d96f8b8b.size; index++) {
            var_d96f8b8b[index] delete();
        }
        wait(var_87783e2a / 1000 / 2);
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_abe568bf
// Checksum 0x4306c59d, Offset: 0x74d0
// Size: 0x1b2
function function_abe568bf() {
    while (!level flag::get("apc_restart")) {
        level.apc playsound("evt_apc_start_fail");
        foreach (player in level.activeplayers) {
            player playrumbleonentity("cp_prologue_rumble_apc_engine_restart");
        }
        exploder::exploder("light_exploder_headlight_flicker_01");
        wait(1.5);
        exploder::stop_exploder("light_exploder_headlight_flicker_01");
        wait(randomfloatrange(0.5, 1));
    }
    level.apc playsound("evt_apc_start_success");
    foreach (player in level.activeplayers) {
        player playrumbleonentity("cp_prologue_rumble_apc_engine_start");
    }
    wait(1.5);
    level.apc vehicle::lights_on();
    level flag::set("apc_engine_started");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_2ceecfc0
// Checksum 0x360390de, Offset: 0x7690
// Size: 0x42
function function_2ceecfc0() {
    trigger::wait_till("t_spawn_tunnel_roadblock");
    spawner::simple_spawn("tunnel_guard", &function_97127072);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_97127072
// Checksum 0x924df5de, Offset: 0x76e0
// Size: 0x10a
function function_97127072() {
    self endon(#"death");
    level flag::wait_till("player_in_tunnel");
    if (self.script_noteworthy === "runner_delay") {
        wait(1);
        self setgoal(struct::get("struct_tunnel_safe").origin);
    } else if (self.script_noteworthy === "runner") {
        wait(randomfloatrange(0.1, 0.6));
        self setgoal(struct::get("struct_tunnel_safe").origin);
    }
    self ai::set_ignoreall(1);
    trigger::wait_till("trigger_tunnel_exit");
    self delete();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_870b1c2
// Checksum 0x6679c77f, Offset: 0x77f8
// Size: 0xc2
function function_870b1c2() {
    level flag::wait_till("player_in_tunnel");
    level thread scene::add_scene_func("p7_fxanim_cp_prologue_vtol_tunnel_rail_bundle", &function_a8eae8ac, "init");
    level thread scene::add_scene_func("p7_fxanim_cp_prologue_vtol_tunnel_rail_bundle", &function_3d3711ec, "done");
    var_2749762c = getvehiclenode("nd_spawn_tunnel_vtol", "script_noteworthy");
    var_2749762c waittill(#"trigger");
    level thread scene::init("p7_fxanim_cp_prologue_vtol_tunnel_rail_bundle");
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_a8eae8ac
// Checksum 0xf3e1509c, Offset: 0x78c8
// Size: 0xc2
function function_a8eae8ac(a_ents) {
    level endon(#"hash_8b1044c1");
    var_edc6e0e1 = a_ents["fxanim_vtol_tunnel"];
    var_edc6e0e1 endon(#"death");
    var_edc6e0e1 util::magic_bullet_shield();
    wait(1);
    var_edc6e0e1 thread function_f5dde0f6();
    var_edc6e0e1 thread function_95580b5();
    var_edc6e0e1 thread function_a59f4d1f();
    wait(2);
    var_edc6e0e1 util::stop_magic_bullet_shield();
    var_edc6e0e1.overridevehicledamage = &function_70cc1e9c;
    level thread scene::play("p7_fxanim_cp_prologue_vtol_tunnel_rail_bundle");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_95580b5
// Checksum 0xdc1512f0, Offset: 0x7998
// Size: 0x17a
function function_95580b5() {
    level flag::wait_till("tunnel_vtol_hit");
    self thread fx::play("gen_explosion", self.origin, self.angles);
    playsoundatposition("wpn_rocket_explode", self.origin);
    earthquake(0.5, 0.5, level.apc.origin, 400);
    self vehicle::toggle_sounds(0);
    self playsound("evt_apcrail_tunnel_vtol_crash");
    exploder::stop_exploder("fx_exploder_fog_part_01");
    exploder::exploder("fx_exploder_fog_part_02");
    level waittill(#"hash_e63c708a");
    foreach (player in level.activeplayers) {
        player playrumbleonentity("cp_prologue_rumble_apc_offroad");
    }
    self vehicle::toggle_exhaust_fx(0);
    wait(1);
    self vehicle::lights_off();
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_3d3711ec
// Checksum 0xc79c302e, Offset: 0x7b20
// Size: 0xaa
function function_3d3711ec(a_ents) {
    var_edc6e0e1 = a_ents["fxanim_vtol_tunnel"];
    var_edc6e0e1 thread fx::play("gen_explosion", var_edc6e0e1.origin);
    playsoundatposition("wpn_rocket_explode", var_edc6e0e1.origin);
    earthquake(0.5, 0.5, level.apc.origin, 400);
    exploder::exploder("light_exploder_defend_vtol_crash");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_a59f4d1f
// Checksum 0xbdb5d88d, Offset: 0x7bd8
// Size: 0xfa
function function_a59f4d1f() {
    self endon(#"death");
    wait(5);
    self thread fx::play("gen_explosion", self.origin, self.angles);
    playsoundatposition("wpn_rocket_explode", self.origin);
    wait(2);
    self thread fx::play("gen_explosion", self.origin, self.angles);
    playsoundatposition("wpn_rocket_explode", self.origin);
    self setmodel("veh_t7_mil_vtol_nrc_no_interior_d");
    wait(3);
    self thread fx::play("gen_explosion", self.origin, self.angles);
    playsoundatposition("wpn_rocket_explode", self.origin);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_5c3fc7c6
// Checksum 0xe6338fa, Offset: 0x7ce0
// Size: 0x182
function function_5c3fc7c6() {
    trigger::wait_till("trigger_tower_rpg");
    level thread tower_rpg();
    var_9a278800 = struct::get("tower_top");
    s_base = struct::get("tower_base");
    var_ac05cd45 = struct::get("tower_road");
    s_rpg = struct::get("rpg_checkpoint");
    var_8af78429 = getweapon("launcher_standard_magic_bullet");
    var_848a02ee = magicbullet(var_8af78429, s_rpg.origin, var_9a278800.origin);
    var_848a02ee thread function_5a046dfa("fx_exploder_vtol_crash_rail", "top");
    wait(0.5);
    magicbullet(var_8af78429, s_rpg.origin, var_ac05cd45.origin);
    wait(0.4);
    var_848a02ee = magicbullet(var_8af78429, s_rpg.origin, s_base.origin);
    var_848a02ee thread function_5a046dfa("fx_exploder_rail_tower", "base");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_97ca9c14
// Checksum 0x7ce2c4ac, Offset: 0x7e70
// Size: 0xc1
function tower_rpg() {
    s_rpg = struct::get("rpg_checkpoint");
    var_5a40a77b = struct::get("tower_apc");
    var_8af78429 = getweapon("launcher_standard");
    v_offset = (0, 0, 0);
    for (i = 0; i < 3; i++) {
        magicbullet(var_8af78429, s_rpg.origin, var_5a40a77b.origin + v_offset);
        v_offset = (-80, 0, 0);
        wait(1);
    }
}

// Namespace apc
// Params 2, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_5a046dfa
// Checksum 0x6dd5f647, Offset: 0x7f40
// Size: 0x18b
function function_5a046dfa(str_exploder, str_location) {
    self util::waittill_any("death", "explode");
    exploder::exploder(str_exploder);
    if (str_location == "top") {
        level thread clientfield::set("apc_rail_tower_collapse", 1);
        util::wait_network_frame();
        util::wait_network_frame();
        var_553f6c78 = getentarray("guard_tower", "targetname");
        foreach (mdl_tower in var_553f6c78) {
            mdl_tower hide();
        }
        level flag::set("obs_collapse");
        wait(4);
        foreach (player in level.activeplayers) {
            player playrumbleonentity("cp_prologue_rumble_pod_land");
        }
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_370bf66
// Checksum 0xe83cdfea, Offset: 0x80d8
// Size: 0x9a
function function_370bf66() {
    trigger::wait_till("trigger_gate_exit");
    exploder::exploder("light_exploder_defend_tower_crash");
    level namespace_2cb3876f::function_b50f5d52();
    spawner::simple_spawn_single("tower_guard", &function_a55e088c);
    level flag::wait_till("obs_collapse");
    exploder::stop_exploder("light_exploder_defend_tower_crash");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_a55e088c
// Checksum 0x4bcddaa3, Offset: 0x8180
// Size: 0x5a
function function_a55e088c() {
    self endon(#"death");
    level flag::wait_till("obs_collapse");
    self startragdoll();
    self launchragdoll((-100, 50, 80));
    self kill();
}

// Namespace apc
// Params 15, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_70cc1e9c
// Checksum 0xcbb1a4e1, Offset: 0x81e8
// Size: 0x15b
function function_70cc1e9c(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(self.targetname) && self.targetname == "fxanim_vtol_tunnel") {
        level flag::set("tunnel_vtol_hit");
        if (isdefined(eattacker) && isplayer(eattacker) && !isdefined(eattacker.var_bbbdbd12) && self.var_88c09c1c !== 1) {
            eattacker.var_bbbdbd12 = 1;
            self.var_88c09c1c = 1;
            level thread namespace_61c634f2::function_51213eb7();
        }
        idamage = 0;
    } else if (isdefined(weapon) && isdefined(weapon.name)) {
        if (weapon.name == "turret_bo3_mil_macv_gunner1" || weapon.name == "turret_bo3_mil_macv_gunner2") {
            idamage *= 0.1;
        }
    }
    return idamage;
}

// Namespace apc
// Params 8, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_a6ea2383
// Checksum 0x71b23f36, Offset: 0x8350
// Size: 0xf2
function function_a6ea2383(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    if (isdefined(eattacker) && isplayer(eattacker) && self.var_88c09c1c !== 1) {
        self.var_88c09c1c = 1;
        level thread namespace_61c634f2::function_51213eb7();
    }
    self setmodel("veh_t7_mil_vtol_nrc_no_interior_d");
    playfxontag(level._effect["vtol_death_explosion"], self, "tag_origin");
    playfxontag(level._effect["vtol_death_smoke"], self, "tag_origin");
}

// Namespace apc
// Params 8, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_afd7b227
// Checksum 0x72ef2216, Offset: 0x8450
// Size: 0x72
function function_afd7b227(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    self.ignoreme = 1;
    if (isdefined(eattacker) && isplayer(eattacker)) {
        namespace_61c634f2::function_2b1ec44e();
    }
}

// Namespace apc
// Params 8, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_4ddf39a4
// Checksum 0x220459cd, Offset: 0x84d0
// Size: 0xe2
function function_4ddf39a4(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    self function_afd7b227(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    var_35ab7d45 = anglestoforward(self.angles) * -1;
    self vehicle::detach_path();
    self launchvehicle((0, 0, 180) + var_35ab7d45 * 5, (randomfloatrange(5, 10), randomfloatrange(-5, 5), 0), 1, 0, 1);
}

// Namespace apc
// Params 2, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_a7743280
// Checksum 0xe19a72b, Offset: 0x85c0
// Size: 0x19a
function function_a7743280(var_521a0327, var_6d6eaca4) {
    if (isdefined(self.script_float)) {
        wait(self.script_float);
    }
    var_f4b1d057 = self spawner::spawn();
    var_f4b1d057 endon(#"death");
    var_f4b1d057 cp_mi_eth_prologue::function_b6ef2c4e(var_6d6eaca4);
    var_f4b1d057.overrideactordamage = &function_d73ad05a;
    if (!isdefined(self.script_parameters)) {
        if (!isdefined(level.var_44d40179)) {
            level.var_44d40179 = 1;
        }
        if (level.var_44d40179 == 0) {
            var_f4b1d057.ignoreall = 1;
        }
        level.var_44d40179++;
        if (level.var_44d40179 > 1) {
            level.var_44d40179 = 0;
        }
    }
    if (isdefined(self.script_noteworthy) && self.script_noteworthy == "sprinter") {
        var_f4b1d057 ai::set_behavior_attribute("sprint", 1);
    } else {
        switch (var_521a0327) {
        case 0:
            var_f4b1d057 ai::set_behavior_attribute("move_mode", "marching");
            break;
        case 1:
            break;
        case 2:
            var_f4b1d057 ai::set_behavior_attribute("sprint", 1);
            break;
        }
    }
    if (isdefined(var_f4b1d057.script_string)) {
        var_f4b1d057 thread namespace_2cb3876f::function_8abaca05();
        return;
    }
    var_f4b1d057.goalradius = 64;
}

// Namespace apc
// Params 14, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_d73ad05a
// Checksum 0x3431f035, Offset: 0x8768
// Size: 0x26c
function function_d73ad05a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, modelindex, psoffsettime, bonename, vsurfacenormal) {
    if (isdefined(smeansofdeath) && smeansofdeath == "MOD_CRUSH") {
        if (!isdefined(self.var_7d8fa639)) {
            self.var_7d8fa639 = 1;
            self startragdoll(1);
            var_a8775778 = randomfloatrange(-60, 60);
            v_launch = (var_a8775778, 0, randomfloatrange(40, -116));
            v_launch += anglestoforward(einflictor.angles) * -6;
            self launchragdoll(v_launch, "J_SpineUpper");
        }
    } else if (isdefined(weapon) && isdefined(weapon.name)) {
        if (!isdefined(self.var_7d8fa639)) {
            if (weapon.name == "turret_bo3_mil_macv_gunner1" || weapon.name == "turret_bo3_mil_macv_gunner2") {
                self.var_7d8fa639 = 1;
                self startragdoll(1);
                v_launch = (0, 0, 50);
                v_launch += anglestoforward(einflictor.angles) * 120;
                self launchragdoll(v_launch, "J_SpineUpper");
            } else if (weapon.name == "turret_bo3_mil_macv_gunner3" || weapon.name == "turret_bo3_mil_macv_gunner4") {
                self.var_7d8fa639 = 1;
                self startragdoll(1);
                v_launch = (0, 0, randomfloatrange(30, 90));
                v_launch += anglestoforward(einflictor.angles) * 120;
                self launchragdoll(v_launch, "J_SpineUpper");
            }
        }
    }
    return idamage;
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_b4145fc1
// Checksum 0x576afb00, Offset: 0x89e0
// Size: 0xad
function function_b4145fc1() {
    level endon(#"hash_2a6578a1");
    level endon(#"hash_f776796b");
    n_vo = 0;
    wait(randomfloatrange(4.5, 5.5));
    while (true) {
        var_f6c5842 = spawner::simple_spawn_single("robot_crawler");
        if (isalive(var_f6c5842)) {
            level.apc scene::play("cin_pro_16_02_apc_vign_stall_attack_left_front", var_f6c5842);
        }
        wait(randomfloatrange(3, 5));
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_27ee29e6
// Checksum 0x69c7d7b3, Offset: 0x8a98
// Size: 0xad
function function_27ee29e6() {
    level endon(#"hash_2a6578a1");
    level endon(#"hash_baebe028");
    n_vo = 0;
    wait(randomfloatrange(4, 5.5));
    while (true) {
        var_f6c5842 = spawner::simple_spawn_single("robot_crawler");
        if (isalive(var_f6c5842)) {
            level.apc scene::play("cin_pro_16_02_apc_vign_stall_attack_left_rear", var_f6c5842);
        }
        wait(randomfloatrange(3, 5));
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_35eded54
// Checksum 0xdd2263ca, Offset: 0x8b50
// Size: 0xa5
function function_35eded54() {
    level endon(#"hash_2a6578a1");
    level endon(#"hash_916c56a6");
    wait(randomfloatrange(4.5, 5.5));
    while (true) {
        var_f6c5842 = spawner::simple_spawn_single("robot_crawler");
        if (isalive(var_f6c5842)) {
            level.apc scene::play("cin_pro_16_02_apc_vign_stall_attack_right_front", var_f6c5842);
        }
        wait(randomfloatrange(3, 5));
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_4446fa95
// Checksum 0x56d73d6, Offset: 0x8c00
// Size: 0xad
function function_4446fa95() {
    level endon(#"hash_2a6578a1");
    level endon(#"hash_3437fba3");
    n_vo = 0;
    wait(randomfloatrange(4, 5.5));
    while (true) {
        var_f6c5842 = spawner::simple_spawn_single("robot_crawler");
        if (isalive(var_f6c5842)) {
            level.apc scene::play("cin_pro_16_02_apc_vign_stall_attack_right_rear", var_f6c5842);
        }
        wait(randomfloatrange(3, 5));
    }
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_98b546ae
// Checksum 0x27d709, Offset: 0x8cb8
// Size: 0xba
function function_98b546ae(str_position) {
    switch (str_position) {
    case 289:
        str_scene = "cin_pro_16_02_apc_vign_flung_robot_left_front_01";
        break;
    case 290:
        str_scene = "cin_pro_16_02_apc_vign_flung_robot_left_rear_01";
        break;
    case 291:
        str_scene = "cin_pro_16_02_apc_vign_flung_robot_right_front_01";
        break;
    }
    var_f6c5842 = spawner::simple_spawn_single("robot_crawler", &function_d6c9484a);
    if (isalive(var_f6c5842)) {
        level.apc scene::play(str_scene, var_f6c5842);
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_d6c9484a
// Checksum 0x7222f3ec, Offset: 0x8d80
// Size: 0x22
function function_d6c9484a() {
    self endon(#"death");
    level waittill(#"flung");
    self kill();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_9d87900e
// Checksum 0x25dbf741, Offset: 0x8db0
// Size: 0x87
function function_9d87900e() {
    level endon(#"hash_5d671c7b");
    while (true) {
        level waittill(#"hash_4f0dddd");
        foreach (player in level.activeplayers) {
            player playrumbleonentity("cp_prologue_rumble_apc_robot_land");
        }
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_b328d415
// Checksum 0x8df99c2a, Offset: 0x8e40
// Size: 0x65
function function_b328d415() {
    while (!level flag::get("apc_crash")) {
        self waittill(#"hash_760fecd0");
        var_f6c5842 = spawner::simple_spawn_single("robot_crawler");
        var_f6c5842 thread function_61f0ff7a("left");
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_4d508278
// Checksum 0x99c9c86d, Offset: 0x8eb0
// Size: 0x65
function function_4d508278() {
    while (!level flag::get("apc_crash")) {
        self waittill(#"hash_2f6ab0ff");
        var_f6c5842 = spawner::simple_spawn_single("robot_crawler");
        var_f6c5842 thread function_61f0ff7a("right");
    }
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_61f0ff7a
// Checksum 0x656ce517, Offset: 0x8f20
// Size: 0xa2
function function_61f0ff7a(str_dir) {
    self endon(#"death");
    if (str_dir == "left") {
        level.apc scene::play("cin_pro_16_02_apc_vign_truck_jump", self);
        level.apc scene::play("cin_pro_16_02_apc_vign_flung_robot_left_front_01", self);
        return;
    }
    level.apc scene::play("cin_pro_16_02_apc_vign_truck_jump2", self);
    level.apc scene::play("cin_pro_16_02_apc_vign_flung_robot_right_front_01", self);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_7d33cac1
// Checksum 0x2c877306, Offset: 0x8fd0
// Size: 0x312
function function_7d33cac1() {
    self endon(#"death");
    trigger::wait_till("ambush_vtol_takeoff");
    level.apc notify(#"hash_96522489");
    var_9d1abae9 = getvehiclenode("nd_tunnel_vtol_ambush_start", "targetname");
    self thread vehicle::get_on_and_go_path(var_9d1abae9);
    var_d47f85df = getvehiclenode("nd_vtol_ambush_fire", "script_noteworthy");
    var_d47f85df waittill(#"trigger");
    for (i = 0; i < 3; i++) {
        self turret::enable(i, 0);
    }
    wait(3.75);
    level thread function_f907ad59();
    a_structs = struct::get_array("tunnel_vtol_target", "targetname");
    a_structs = arraysortclosest(a_structs, level.apc.origin);
    for (i = 0; i < a_structs.size; i++) {
        v_target_pos = a_structs[i].origin;
        self thread fire_missiles(v_target_pos, "launcher_standard_dud", i > 3);
        wait(0.25);
        if (i == 3) {
            self util::stop_magic_bullet_shield();
        }
    }
    self util::stop_magic_bullet_shield();
    for (i = 0; i < 3; i++) {
        self turret::disable(i);
    }
    var_6abcce89 = getvehiclenode("nd_vtol_fire_at_tunnel", "script_noteworthy");
    var_6abcce89 waittill(#"trigger");
    a_structs = struct::get_array("tunnel_vtol_target_2", "targetname");
    for (i = 0; i < 5; i++) {
        v_dir = anglestoforward(self.angles);
        v_start_pos = self.origin + v_dir * 20;
        v_target_pos = a_structs[i].origin;
        self thread fire_missiles(v_target_pos, "launcher_standard_dud");
        wait(0.2);
    }
    level flag::wait_till("player_in_tunnel");
    self util::stop_magic_bullet_shield();
    self.delete_on_death = 1;
    self notify(#"death");
    if (!isalive(self)) {
        self delete();
    }
}

// Namespace apc
// Params 3, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_dd092bdf
// Checksum 0xab96870f, Offset: 0x92f0
// Size: 0x10a
function fire_missiles(v_target_pos, str_weapon, var_e18bd372) {
    if (!isdefined(str_weapon)) {
        str_weapon = "launcher_standard";
    }
    if (!isdefined(var_e18bd372)) {
        var_e18bd372 = 1;
    }
    var_8af78429 = getweapon(str_weapon);
    v_left = self gettagorigin("tag_rocket_left");
    v_right = self gettagorigin("tag_rocket_right");
    var_b40fa37e = magicbullet(var_8af78429, v_left, v_target_pos, self);
    if (var_e18bd372) {
        var_b40fa37e thread function_322383f6(v_target_pos);
    }
    wait(0.1);
    var_6e0d4ab5 = magicbullet(var_8af78429, v_right, v_target_pos, self);
    if (var_e18bd372) {
        var_6e0d4ab5 thread function_322383f6(v_target_pos);
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_f907ad59
// Checksum 0xb3b5e46c, Offset: 0x9408
// Size: 0x61
function function_f907ad59() {
    level waittill(#"hash_250db3b8");
    for (i = 0; i < 4; i++) {
        earthquake(0.65, 0.65, level.apc.origin, 400);
        wait(0.25);
    }
}

// Namespace apc
// Params 14, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_6034914b
// Checksum 0x155d64d2, Offset: 0x9478
// Size: 0xb4
function function_6034914b(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, modelindex, psoffsettime, bonename, vsurfacenormal) {
    if (!isdefined(self.var_7d8fa639)) {
        self.var_7d8fa639 = 1;
        self thread function_6a19cf15(anglestoforward(einflictor.angles));
    }
    return idamage;
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_6a19cf15
// Checksum 0xd4571114, Offset: 0x9538
// Size: 0xca
function function_6a19cf15(v_forward) {
    self endon(#"death");
    wait(0.1);
    if (scene::is_active(self.var_904f3930)) {
        scene::stop(self.var_904f3930);
    }
    wait(0.1);
    self startragdoll(1);
    var_a8775778 = randomfloatrange(-50, 50);
    v_launch = (var_a8775778, 0, randomfloatrange(40, -116));
    v_launch += v_forward * 600;
    self launchragdoll(v_launch, "J_SpineUpper");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_b64436c8
// Checksum 0x151af51a, Offset: 0x9610
// Size: 0xcb
function function_b64436c8() {
    self.overridevehicledamage = &function_2923c71;
    self.var_a5f37229 = [];
    self.var_a5f37229[self.var_a5f37229.size] = 0;
    self.var_a5f37229[self.var_a5f37229.size] = 0;
    self.var_a5f37229[self.var_a5f37229.size] = 0;
    self.var_a5f37229[self.var_a5f37229.size] = 0;
    self.var_a5f37229[self.var_a5f37229.size] = 0;
    self.var_7b32e45e = [];
    self.var_7b32e45e[self.var_7b32e45e.size] = 0;
    self.var_7b32e45e[self.var_7b32e45e.size] = 0;
    self.var_7b32e45e[self.var_7b32e45e.size] = 0;
    self.var_7b32e45e[self.var_7b32e45e.size] = 0;
    self.var_7b32e45e[self.var_7b32e45e.size] = 0;
}

// Namespace apc
// Params 2, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_2309bb98
// Checksum 0xf8a2da39, Offset: 0x96e8
// Size: 0x7a
function function_2309bb98(var_33cce320, var_2843fc54) {
    level.apc function_b64436c8();
    if (var_2843fc54) {
        nd_start = getvehiclenode(var_33cce320, "targetname");
        level.apc thread vehicle::get_on_path(nd_start);
    }
    level flag::wait_till("players_are_in_apc");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_29c3397f
// Checksum 0x9e614478, Offset: 0x9770
// Size: 0x42
function function_29c3397f() {
    while (true) {
        if (level.var_586b4bd0 >= level.players.size) {
            break;
        }
        wait(0.05);
    }
    level flag::set("players_are_in_apc");
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_7713da2c
// Checksum 0xcad1cb9e, Offset: 0x97c0
// Size: 0xd5
function function_7713da2c(turret_index) {
    self endon(#"death");
    var_4a84d252 = 0;
    var_637fcbf0 = 0;
    while (isdefined(self)) {
        if (isdefined(self.viewlockedentity)) {
            var_1d8d45a5 = var_4a84d252;
            var_4a84d252 = self.viewlockedentity getturretheatvalue(turret_index);
            var_f0d797d6 = var_637fcbf0;
            var_637fcbf0 = self.viewlockedentity isvehicleturretoverheating(turret_index);
            if (var_1d8d45a5 != var_4a84d252 || var_f0d797d6 != var_637fcbf0) {
                if (isdefined(self.var_ccf0d8ef)) {
                    self setluimenudata(self.var_ccf0d8ef, "frac", var_4a84d252 / 100);
                }
            }
        }
        wait(0.05);
    }
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_a3024193
// Checksum 0xfc9e4ada, Offset: 0x98a0
// Size: 0x152
function function_a3024193(var_cf0e873a) {
    switch (var_cf0e873a) {
    case 45:
        turret_index = 4;
        function_beac5c93(turret_index);
        level.apc scene::play("cin_pro_15_01_opendoor_1st_mount_player04", self);
        break;
    case 42:
        turret_index = 1;
        function_beac5c93(turret_index);
        level.apc scene::play("cin_pro_15_01_opendoor_1st_mount_player02", self);
        break;
    case 44:
        turret_index = 3;
        function_beac5c93(turret_index);
        level.apc scene::play("cin_pro_15_01_opendoor_1st_mount_player03", self);
        break;
    case 43:
        turret_index = 2;
        function_beac5c93(turret_index);
        level.apc scene::play("cin_pro_15_01_opendoor_1st_mount_player01", self);
        break;
    }
    if (!level flag::get("failed_apc_boarding")) {
        self thread function_59329589(turret_index);
    }
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_beac5c93
// Checksum 0x68b94045, Offset: 0x9a00
// Size: 0x7b
function function_beac5c93(n_index) {
    foreach (var_e4463170 in level.var_681ad194) {
        if (var_e4463170.var_19c9fb9b === n_index) {
            var_e4463170 delete();
        }
    }
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_59329589
// Checksum 0x1335bd86, Offset: 0x9a88
// Size: 0xea
function function_59329589(turret_index) {
    level.apc.var_a5f37229[turret_index] = 1;
    self.turret_index = turret_index;
    self.overrideplayerdamage = &function_b0d8e1ce;
    level.apc setseatoccupied(turret_index, 0);
    level.apc usevehicle(self, turret_index);
    if (turret_index <= 2) {
        self.var_ccf0d8ef = self openluimenu("APCTurretHUD");
        self setluimenudata(self.var_ccf0d8ef, "frac", 0);
        self thread function_7713da2c(turret_index);
    }
    level.var_586b4bd0++;
    self.allowdeath = 0;
    self thread namespace_2cb3876f::give_max_ammo();
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_fc1b1b72
// Checksum 0xaa4de618, Offset: 0x9b80
// Size: 0x6a
function function_fc1b1b72() {
    var_19c9fb9b = 0;
    for (i = 1; i < 5; i++) {
        var_cf0db380 = level.apc getseatoccupant(i);
        if (!isdefined(var_cf0db380)) {
            var_19c9fb9b = i;
        }
    }
    self function_59329589(var_19c9fb9b);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_1aa160fc
// Checksum 0xe3617826, Offset: 0x9bf8
// Size: 0x93
function function_1aa160fc() {
    level flag::clear("players_are_in_apc");
    foreach (player in level.activeplayers) {
        player thread function_dcb847ab();
    }
    level.var_586b4bd0 = 0;
    level.var_7f13e303 = undefined;
    level notify(#"hash_7acfacb8");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_dcb847ab
// Checksum 0xb2d7bd8e, Offset: 0x9c98
// Size: 0x77
function function_dcb847ab() {
    level.apc useby(self);
    self.allowdeath = 1;
    self.overrideplayerdamage = undefined;
    self.var_161a3f68 = undefined;
    if (isdefined(self.var_ccf0d8ef)) {
        self closeluimenu(self.var_ccf0d8ef);
    }
    if (isdefined(self.turret_index)) {
        level.apc.var_a5f37229[self.turret_index] = 0;
    }
}

// Namespace apc
// Params 15, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_2923c71
// Checksum 0xe6691567, Offset: 0x9d18
// Size: 0x17b
function function_2923c71(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (self.team == "allies") {
        idamage = 0;
    } else if (isdefined(eattacker) && isactor(eattacker)) {
        idamage *= 0.1;
    } else if (isdefined(weapon) && isdefined(weapon.name)) {
        if (weapon.name == "turret_bo3_mil_macv_gunner1" || weapon.name == "turret_bo3_mil_macv_gunner2") {
            if (self.vehicletype == "veh_bo3_mil_macv_prologue_enemy") {
                idamage *= 20;
            } else {
                idamage *= 0.3;
            }
        } else if (weapon.name == "turret_bo3_mil_macv_gunner3" || weapon.name == "turret_bo3_mil_macv_gunner4") {
            if (self.vehicletype == "veh_bo3_mil_macv_prologue_enemy") {
                idamage *= 8;
            } else {
                idamage *= 1;
            }
        }
    }
    return idamage;
}

// Namespace apc
// Params 13, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_b0d8e1ce
// Checksum 0x5932a7f8, Offset: 0x9ea0
// Size: 0x103
function function_b0d8e1ce(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, modelindex, psoffsettime, vsurfacenormal) {
    self endon(#"hash_ee92aeb6");
    if (idamage >= self.health) {
        idamage = self.health - 10;
        if (idamage <= 0) {
            idamage = 0;
        }
    }
    if (isdefined(weapon) && isdefined(weapon.name)) {
        if (weapon.name == "turret_bo3_mil_macv_gunner1" || weapon.name == "turret_bo3_mil_macv_gunner2" || weapon.name == "turret_bo3_mil_macv_gunner3" || weapon.name == "turret_bo3_mil_macv_gunner4") {
            idamage = 0;
        }
    }
    return idamage;
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_ade89a8a
// Checksum 0xb156ee6d, Offset: 0x9fb0
// Size: 0x1d3
function function_ade89a8a() {
    level flag::wait_till("apc_unlocked");
    level.var_6ca49220 = [];
    level.var_6ca49220[0] = getent("trig_apc_gunner1", "script_noteworthy");
    level.var_6ca49220[1] = getent("trig_apc_gunner2", "script_noteworthy");
    level.var_6ca49220[2] = getent("trig_apc_gunner3", "script_noteworthy");
    level.var_6ca49220[3] = getent("trig_apc_gunner4", "script_noteworthy");
    for (i = 0; i < level.activeplayers.size; i++) {
        level thread function_ae49644a(level.var_6ca49220[i]);
    }
    callback::on_spawned(&function_29852c1d);
    level flag::wait_till("players_are_in_apc");
    callback::remove_on_spawned(&function_29852c1d);
    foreach (var_b957e40 in level.var_6ca49220) {
        if (isdefined(var_b957e40.var_5356d2cc)) {
            var_b957e40.var_5356d2cc gameobjects::disable_object();
        }
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_29852c1d
// Checksum 0x181ceb4b, Offset: 0xa190
// Size: 0x4a
function function_29852c1d() {
    n_player = self getentitynumber();
    if (!level.var_6ca49220[n_player] istriggerenabled()) {
        level thread function_ae49644a(level.var_6ca49220[n_player]);
    }
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_ae49644a
// Checksum 0xb1b77e, Offset: 0xa1e8
// Size: 0x9a
function function_ae49644a(t_trigger) {
    if (t_trigger.script_noteworthy == "trig_apc_gunner3" || t_trigger.script_noteworthy == "trig_apc_gunner4") {
        var_41d5b347 = %CP_MI_ETH_PROLOGUE_MOUNT_APC_GR;
    } else {
        var_41d5b347 = %CP_MI_ETH_PROLOGUE_MOUNT_APC_MG;
    }
    t_trigger triggerenable(1);
    t_trigger.var_5356d2cc = util::function_14518e76(t_trigger, %cp_prompt_entervehicle_prologue_apc, var_41d5b347, &function_c8b0c865);
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_c8b0c865
// Checksum 0xdc28fab3, Offset: 0xa290
// Size: 0x42
function function_c8b0c865(e_player) {
    e_player thread function_a3024193(self.trigger.script_noteworthy);
    self gameobjects::disable_object();
    level.var_1a71fabf++;
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_38362d1e
// Checksum 0xf509390e, Offset: 0xa2e0
// Size: 0x1a2
function function_38362d1e() {
    var_88aa978 = 1;
    if (level.var_31aefea8 == "skipto_robot_horde") {
        level flag::wait_till("garage_open");
        var_88aa978 = 0;
    }
    if (isdefined(level.var_4480630f)) {
        for (i = level.players.size; i <= level.var_4480630f.size; i++) {
            if (isdefined(level.a_ai_allies[0])) {
                str_seat = level.var_4480630f[i];
                level.a_ai_allies[0] thread vehicle::get_in(level.apc, str_seat, var_88aa978);
                level.a_ai_allies[0].var_19c9fb9b = i + 1;
                level.apc thread turret::disable_ai_getoff(i, 1);
                if (level.var_31aefea8 == "skipto_robot_horde") {
                    level.a_ai_allies[0] ai::set_ignoreall(1);
                    level.a_ai_allies[0] ai::set_behavior_attribute("vignette_mode", "fast");
                    level.a_ai_allies[0] thread function_2839eeb9();
                }
                arrayremovevalue(level.a_ai_allies, level.a_ai_allies[0]);
            }
        }
    }
    level.var_4480630f = [];
    level.a_ai_allies = [];
    wait(5);
    level flag::set("ai_in_apc");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_2839eeb9
// Checksum 0x5ae3b959, Offset: 0xa490
// Size: 0x52
function function_2839eeb9() {
    self endon(#"death");
    self flagsys::wait_till("in_vehicle");
    self ai::set_ignoreall(0);
    self ai::set_behavior_attribute("vignette_mode", "off");
}

// Namespace apc
// Params 2, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_ba89f624
// Checksum 0xabfd7903, Offset: 0xa4f0
// Size: 0x6a
function function_ba89f624(v_start_pos, v_target_pos) {
    var_8af78429 = getweapon("launcher_standard");
    var_19b02fe9 = magicbullet(var_8af78429, v_start_pos, v_target_pos, self);
    var_19b02fe9 thread function_322383f6(v_target_pos);
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_322383f6
// Checksum 0xf5d851a3, Offset: 0xa568
// Size: 0x93
function function_322383f6(v_target_pos) {
    self endon(#"death");
    while (true) {
        dist = distance(self.origin, v_target_pos);
        if (dist < 100) {
            break;
        }
        wait(0.05);
    }
    playfx("explosions/fx_exp_generic_lg", v_target_pos);
    playsoundatposition("wpn_rocket_explode", self.origin);
    level notify(#"hash_250db3b8");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_f5dde0f6
// Checksum 0x5c0e2403, Offset: 0xa608
// Size: 0x109
function function_f5dde0f6() {
    self endon(#"death");
    level endon(#"hash_5d671c7b");
    level endon(#"hash_8b1044c1");
    var_85dc60d5 = array("vtol_tunnel_target_left_2", "vtol_tunnel_target_left_3");
    var_a65a9e36 = array("vtol_tunnel_target_right_2", "vtol_tunnel_target_right_3");
    self thread function_9cf9688c();
    wait(0.3);
    for (i = 0; i < var_85dc60d5.size; i++) {
        var_cd13e495 = struct::get(var_85dc60d5[i]).origin;
        var_8f45fdaa = struct::get(var_a65a9e36[i]).origin;
        self function_a942e878(var_cd13e495, var_8f45fdaa);
        wait(0.3);
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_9cf9688c
// Checksum 0x81ee51c7, Offset: 0xa720
// Size: 0x114
function function_9cf9688c() {
    var_cd13e495 = struct::get("vtol_tunnel_target_left_1").origin;
    var_8f45fdaa = struct::get("vtol_tunnel_target_right_1").origin;
    v_left = self gettagorigin("tag_rocket_left");
    v_right = self gettagorigin("tag_rocket_right");
    var_8af78429 = getweapon("hunter_rocket_turret");
    var_8c1f89f1 = magicbullet(var_8af78429, v_left, var_cd13e495, self);
    var_8c1f89f1 thread function_b0cea2cc(var_cd13e495);
    wait(0.2);
    var_cb1d049c = magicbullet(var_8af78429, v_right, var_8f45fdaa, self);
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_b0cea2cc
// Checksum 0x3d909458, Offset: 0xa840
// Size: 0xb2
function function_b0cea2cc(v_pos) {
    self waittill(#"death");
    level clientfield::set("tunnel_wall_explode", 1);
    foreach (player in level.activeplayers) {
        player playrumbleonentity("cp_prologue_rumble_apc_offroad");
    }
    radiusdamage(v_pos, -56, 1000, 800, undefined, "MOD_EXPLOSIVE");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_219a1e60
// Checksum 0xe484bbc0, Offset: 0xa900
// Size: 0x59
function function_219a1e60() {
    for (i = 1; i < 5; i++) {
        if (self.var_a5f37229[i] == 0) {
            turret_index = i;
            self.var_7b32e45e[turret_index] = 1;
            self turret::enable(turret_index, 0);
        }
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_6ac512e
// Checksum 0xe9506c6c, Offset: 0xa968
// Size: 0x199
function function_6ac512e() {
    for (turret_index = 1; turret_index <= 4; turret_index++) {
        if (turret_index == 1 || turret_index == 2) {
            var_41d1cac6 = randomfloatrange(0.9, 1.2);
            var_26dc9f18 = randomfloatrange(1.6, 2.4);
            var_130ee436 = randomfloatrange(1.6, 1.9);
            var_b86905a8 = randomfloatrange(2.4, 2.9);
            level.apc turret::set_burst_parameters(var_41d1cac6, var_26dc9f18, var_130ee436, var_b86905a8, turret_index);
        }
        if (turret_index == 3 || turret_index == 4) {
            var_41d1cac6 = randomfloatrange(0.9, 1.2);
            var_26dc9f18 = randomfloatrange(1.6, 2.4);
            var_130ee436 = randomfloatrange(5, 6);
            var_b86905a8 = randomfloatrange(6.5, 7.5);
            level.apc turret::set_burst_parameters(var_41d1cac6, var_26dc9f18, var_130ee436, var_b86905a8, turret_index);
        }
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_745449bd
// Checksum 0x6d5ccf9d, Offset: 0xab10
// Size: 0x199
function function_745449bd() {
    for (turret_index = 1; turret_index < 5; turret_index++) {
        if (turret_index == 1 || turret_index == 2) {
            var_41d1cac6 = randomfloatrange(0.9, 1.2);
            var_26dc9f18 = randomfloatrange(1.3, 1.8);
            var_130ee436 = randomfloatrange(3.5, 3.8);
            var_b86905a8 = randomfloatrange(4.5, 4.9);
            level.apc turret::set_burst_parameters(var_41d1cac6, var_26dc9f18, var_130ee436, var_b86905a8, turret_index);
        }
        if (turret_index == 3 || turret_index == 4) {
            var_41d1cac6 = randomfloatrange(0.9, 1.2);
            var_26dc9f18 = randomfloatrange(1.3, 1.8);
            var_130ee436 = randomfloatrange(3.5, 3.8);
            var_b86905a8 = randomfloatrange(4.5, 4.9);
            level.apc turret::set_burst_parameters(var_41d1cac6, var_26dc9f18, var_130ee436, var_b86905a8, turret_index);
        }
    }
}

// Namespace apc
// Params 6, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_52284865
// Checksum 0xe1bfbb1a, Offset: 0xacb8
// Size: 0x1b9
function function_52284865(a_blockers, velocity, var_961f6182, var_fe65d31b, var_3cb8ff6f, var_d1bb8a11) {
    for (i = 0; i < a_blockers.size; i++) {
        e_ent = a_blockers[i];
        if (!isdefined(e_ent.var_b01758c4)) {
            v_dir = vectornormalize(e_ent.origin - level.apc.origin);
            v_velocity = v_dir * velocity;
            if (isdefined(var_d1bb8a11) && isdefined(var_3cb8ff6f)) {
                v_up = (0, 0, 1);
                v_side = vectorcross(v_dir, v_up);
                var_612f807a = randomfloatrange(var_3cb8ff6f, var_d1bb8a11);
                v_velocity += v_side * var_612f807a;
            }
            e_ent thread function_12bef3f6(v_velocity);
        }
    }
    for (i = 0; i < var_fe65d31b; i++) {
        earthquake(var_961f6182, var_961f6182, level.apc.origin, 400);
        a_players = getplayers();
        for (j = 0; j < a_players.size; j++) {
            a_players[j] playrumbleonentity("damage_heavy");
        }
        wait(0.1);
    }
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_12bef3f6
// Checksum 0x5d641ec5, Offset: 0xae80
// Size: 0x42
function function_12bef3f6(v_velocity) {
    self endon(#"death");
    self physicslaunch(self.origin, v_velocity);
    wait(0.1);
    self notsolid();
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_f6778ee2
// Checksum 0x4dbbb85d, Offset: 0xaed0
// Size: 0x69
function function_f6778ee2(a_triggers) {
    for (i = 0; i < a_triggers.size; i++) {
        e_trigger = getent(a_triggers[i], "targetname");
        level thread function_ae670a39("cleanup_apc", a_triggers[i]);
    }
}

// Namespace apc
// Params 2, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_ae670a39
// Checksum 0x4dff5635, Offset: 0xaf48
// Size: 0x106
function function_ae670a39(var_cc890dd4, var_b22a2ac4) {
    level endon(var_cc890dd4);
    e_trigger = getent(var_b22a2ac4, "targetname");
    e_trigger waittill(#"trigger");
    level notify(#"hash_6e31b2e3");
    e_ent = getent(var_b22a2ac4, "target");
    if (isdefined(e_ent) && !(isdefined(e_ent.var_b01758c4) && e_ent.var_b01758c4)) {
        v_dir = vectornormalize(e_ent.origin - level.apc.origin);
        v_velocity = v_dir * 250;
        e_ent notsolid();
        e_ent physicslaunch(e_ent.origin, v_velocity);
        e_ent.var_b01758c4 = 1;
    }
}

// Namespace apc
// Params 1, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_3bf8c3f4
// Checksum 0xbb272600, Offset: 0xb058
// Size: 0x142
function function_3bf8c3f4(var_5c70e0a7) {
    var_2a04238a = namespace_2cb3876f::function_125042c0();
    array::add(var_2a04238a, level.var_2fd26037);
    array::run_all(var_2a04238a, &ai::set_ignoreall, var_5c70e0a7);
    array::run_all(var_2a04238a, &ai::set_ignoreme, var_5c70e0a7);
    if (var_5c70e0a7) {
        level.apc turret::disable(1);
        level.apc turret::disable(2);
        level.apc turret::disable(3);
        level.apc turret::disable(4);
        return;
    }
    level.apc turret::disable(1);
    level.apc turret::disable(2);
    level.apc turret::disable(3);
    level.apc turret::disable(4);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_faafa578
// Checksum 0x1609e543, Offset: 0xb1a8
// Size: 0x9a
function function_faafa578() {
    level.a_ai_allies = [];
    if (isdefined(level.var_681ad194[1])) {
        arrayinsert(level.a_ai_allies, level.var_681ad194[1], 0);
    }
    if (isdefined(level.var_681ad194[2])) {
        arrayinsert(level.a_ai_allies, level.var_681ad194[2], 0);
    }
    if (isdefined(level.var_681ad194[3])) {
        arrayinsert(level.a_ai_allies, level.var_681ad194[3], 0);
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_4eae0e09
// Checksum 0xa0d0eec8, Offset: 0xb250
// Size: 0x82
function function_4eae0e09() {
    var_4072b6ba = getent("trigger_parkinglot_light", "targetname");
    var_4072b6ba waittill(#"trigger");
    s_pos = struct::get(var_4072b6ba.target);
    physicsexplosioncylinder(s_pos.origin, 60, 60, 0.5);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_80e4d901
// Checksum 0x200af72b, Offset: 0xb2e0
// Size: 0x27a
function function_80e4d901() {
    var_4072b6ba = getent("trigger_light_post", "targetname");
    var_4072b6ba waittill(#"trigger");
    var_4072b6ba playsound("evt_apc_impact_pole");
    s_pos = struct::get(var_4072b6ba.target);
    physicsexplosioncylinder(s_pos.origin, 60, 60, 0.5);
    t_entrance = getent("trigger_entrance_gate", "targetname");
    t_entrance waittill(#"trigger");
    t_entrance playsound("evt_apc_impact_entrance");
    level thread function_98b546ae("right_front");
    s_pos = struct::get(t_entrance.target);
    physicsexplosioncylinder(s_pos.origin, 300, 300, 25);
    var_fbe4f40c = getent("trigger_scaffold", "targetname");
    var_fbe4f40c waittill(#"trigger");
    var_fbe4f40c playsound("evt_apc_impact_scaffolding");
    physicsexplosioncylinder(var_fbe4f40c.origin, 300, 300, 25);
    t_exit = getent("trigger_gate_exit", "targetname");
    t_exit waittill(#"trigger");
    t_exit playsound("evt_apc_impact_entrance");
    s_pos = struct::get(t_exit.target);
    physicsexplosioncylinder(s_pos.origin, 300, 300, 25);
    var_48cab5aa = getent("trigger_cones", "targetname");
    var_48cab5aa waittill(#"trigger");
    physicsexplosioncylinder(var_48cab5aa.origin, 300, 300, 25);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_26fb0662
// Checksum 0x2e6110a4, Offset: 0xb568
// Size: 0x61
function function_26fb0662() {
    var_751ebe80 = array(1, 2, 3, 4);
    for (i = 0; i < level.players.size; i++) {
        level.players[i] thread function_59329589(var_751ebe80[i]);
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_5c1321b9
// Checksum 0x6056e863, Offset: 0xb5d8
// Size: 0x8b
function function_5c1321b9() {
    var_1d80939f = getentarray("trigger_apc_bump", "targetname");
    foreach (var_4e0a32bf in var_1d80939f) {
        var_4e0a32bf thread function_efa6317e();
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_efa6317e
// Checksum 0x46471cc4, Offset: 0xb670
// Size: 0xcf
function function_efa6317e() {
    self waittill(#"trigger");
    n_time = 0;
    if (isdefined(self.script_int)) {
        n_time = self.script_int;
    }
    do {
        foreach (player in level.activeplayers) {
            player playrumbleonentity("cp_prologue_rumble_apc_offroad");
        }
        n_random_wait = randomfloatrange(0.25, 0.5);
        wait(n_random_wait);
        n_time -= n_random_wait;
    } while (n_time > 0);
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_8d1d7010
// Checksum 0xd42c044a, Offset: 0xb748
// Size: 0xba
function function_8d1d7010() {
    var_fe4ba9bc = getentarray("rail_barrel_1", "script_noteworthy");
    foreach (ent in var_fe4ba9bc) {
        if (ent.classname == "script_model") {
            var_8a4f1b19 = ent;
            break;
        }
    }
    var_8a4f1b19 waittill(#"broken");
    level scene::play("p7_fxanim_cp_prologue_apc_rail_building_explode01_bundle");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_67348f4b
// Checksum 0x6e2f22b4, Offset: 0xb810
// Size: 0x22
function function_67348f4b() {
    self waittill(#"death");
    level scene::play("p7_fxanim_cp_prologue_apc_rail_building_explode02_bundle");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_809f2e11
// Checksum 0x59648238, Offset: 0xb840
// Size: 0xca
function function_809f2e11() {
    level thread function_7ed5512("trig_first_crawler", "evt_apc_first_turn");
    level thread function_7ed5512("trigger_reached_roadblock", "evt_apc_roadblock_oneshot", 0.25);
    level thread function_7ed5512("trig_cleanup_offroad", "evt_apc_vtol_crash", 0.15, 1);
    level thread function_7ed5512("apc_hits_truck_in_tunnel", "evt_apc_tunnel_turn", 0, 1);
    level thread function_7ed5512("trigger_last_roadblock", "evt_apc_final_skid", 3.5);
    level thread function_d77cc705();
}

// Namespace apc
// Params 4, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_7ed5512
// Checksum 0x8c330901, Offset: 0xb918
// Size: 0xca
function function_7ed5512(var_41e1bdd2, alias, delay, var_b131fff1) {
    if (!isdefined(delay)) {
        delay = 0;
    }
    if (!isdefined(var_b131fff1)) {
        var_b131fff1 = 0;
    }
    if (isdefined(var_b131fff1) && var_b131fff1) {
        while (true) {
            trig = trigger::wait_till(var_41e1bdd2);
            if (isdefined(level.apc) && trig.who == level.apc) {
                break;
            }
        }
    } else {
        trig = trigger::wait_till(var_41e1bdd2);
    }
    wait(delay);
    if (isdefined(level.apc)) {
        level.apc playsound(alias);
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_d77cc705
// Checksum 0xc5e39a54, Offset: 0xb9f0
// Size: 0x9a
function function_d77cc705() {
    trigger::wait_till("trigger_roadblock_bypass");
    if (isdefined(level.apc)) {
        level.apc playloopsound("veh_railapc_dirt_lp", 1.5);
    }
    trigger::wait_till("ambush_vtol_takeoff");
    wait(1.5);
    if (isdefined(level.apc)) {
        level.apc playloopsound("veh_railapc_move_lp", 1.5);
    }
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_d20ef450
// Checksum 0xc47e4e76, Offset: 0xba98
// Size: 0x3a
function function_d20ef450() {
    self waittill(#"death");
    self stopsound("evt_apcrail_vtol1_takeoff");
    self playsound("evt_apcrail_vtol1_crash");
}

// Namespace apc
// Params 0, eflags: 0x0
// namespace_1eb7e8f5<file_0>::function_5e86daf4
// Checksum 0x7e43b868, Offset: 0xbae0
// Size: 0x22
function function_5e86daf4() {
    wait(2);
    level.apc playloopsound("veh_railapc_move_lp", 2);
}

