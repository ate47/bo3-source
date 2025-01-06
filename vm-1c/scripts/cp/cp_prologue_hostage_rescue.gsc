#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_eth_prologue;
#using scripts/cp/cp_mi_eth_prologue_accolades;
#using scripts/cp/cp_mi_eth_prologue_fx;
#using scripts/cp/cp_mi_eth_prologue_sound;
#using scripts/cp/cp_prologue_apc;
#using scripts/cp/cp_prologue_cyber_soldiers;
#using scripts/cp/cp_prologue_hangars;
#using scripts/cp/cp_prologue_util;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/doors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace namespace_ab720c84;

// Namespace namespace_ab720c84
// Params 1, eflags: 0x0
// Checksum 0x2e6db1b7, Offset: 0x2260
// Size: 0xe4
function function_7af85b91(str_objective) {
    function_8176e458();
    spawner::add_spawn_function_group("fuel_tunnel_ai", "script_noteworthy", &cp_prologue_util::function_35be2939, "fuel_tunnel_alerted", 1024);
    if (!isdefined(level.var_2fd26037)) {
        level.var_2fd26037 = util::function_740f8516("hendricks");
        cp_mi_eth_prologue::function_bff1a867("skipto_hostage_1_hendricks");
        skipto::teleport_ai(str_objective);
    }
    level.var_2fd26037.ignoreme = 1;
    level thread function_dbff3ab4();
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0xa59f99fe, Offset: 0x2350
// Size: 0x44
function function_8176e458() {
    level thread scene::init("cin_pro_06_01_hostage_vign_rollgrenade");
    level thread scene::init("p7_fxanim_cp_prologue_underground_truck_explode_bundle");
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x69e2f064, Offset: 0x23a0
// Size: 0x1a4
function function_dbff3ab4() {
    level thread cp_prologue_util::function_950d1c3b(1);
    level thread function_ca7de8e8();
    objectives::set("cp_level_prologue_free_the_minister");
    battlechatter::function_d9f49fba(1);
    cp_prologue_util::function_47a62798(1);
    level.var_2fd26037 thread function_672c874();
    trigger::wait_till("hendricks_rollgrenade");
    array::thread_all(level.players, &function_df74ca81);
    level.var_2fd26037 waittill(#"hash_ff2562ea");
    level thread function_88ddc4d5();
    level flag::set("fuel_tunnel_alerted");
    level thread function_5d78fd66();
    level thread function_f41e9505();
    level thread cp_prologue_util::function_8f7b1e06("t_fuel_tunnel_ai_fallback_controller", "info_fuel_tunnel_fallback_begin", "info_fuel_tunnel_fallback_end");
    level waittill(#"hash_5d08c61e");
    skipto::function_be8adfb8("skipto_hostage_1");
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0xdd03fe32, Offset: 0x2550
// Size: 0x34
function function_5d78fd66() {
    wait 1.5;
    level thread cp_prologue_util::function_a7eac508("sp_fuel_tunnel_explosion_runners", undefined, 1024, undefined);
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x77d354a1, Offset: 0x2590
// Size: 0x3a4
function function_ca7de8e8() {
    a_ai_enemies = getaiteamarray("axis");
    foreach (ai_enemy in a_ai_enemies) {
        ai_enemy delete();
    }
    level thread function_b7afdf3a();
    level thread function_e14a508d();
    spawn_manager::enable("sm_fuel_tunnel");
    spawner::simple_spawn("sp_fuel_depot_staging");
    level thread function_c1e0b282();
    level thread function_ee3c7f46();
    level thread function_d9bab593("t_fuel_tunnel_left_door", "fueltunnel_spawnclosetdoor_2", "sp_fuel_tunnel_left_door", "info_fuel_tunnel_left_door", "info_fuel_tunnel_fallback_end", 0);
    level thread function_d9bab593("t_fuel_tunnel_right_door", "fueltunnel_spawnclosetdoor_3", "sp_fuel_tunnel_right_door", "info_fuel_tunnel_right_door", "info_fuel_tunnel_fallback_end");
    level thread cp_prologue_util::function_8f7b1e06("t_fueling_bridge_attacker", "info_fueling_bridge_attacker", "info_grenade_truck_guys_fallback");
    level thread function_12ac9114();
    level.var_2fd26037 waittill(#"hash_ff2562ea");
    level thread cp_prologue_util::function_e0fb6da9("s_enemy_moveup_point_0", 100, 15, 1, 1, 6, "info_fuel_tunnel_fallback_end", "info_grenade_truck_guys_fallback");
    level thread cp_prologue_util::function_e0fb6da9("s_enemy_moveup_point_1", 100, 15, 1, 1, 6, "info_fuel_tunnel_fallback_end", "info_grenade_truck_guys_fallback");
    level thread cp_prologue_util::function_e0fb6da9("s_enemy_moveup_point_2", 100, 15, 1, 1, 6, "info_fuel_tunnel_fallback_end", "info_grenade_truck_guys_fallback");
    level thread cp_prologue_util::function_e0fb6da9("s_enemy_moveup_point_forklift", -76, 8, 1, 1, 8, "info_fuel_tunnel_fallback_end", "info_grenade_truck_guys_fallback");
    level thread cp_prologue_util::function_e0fb6da9("s_enemy_moveup_point_4", 100, 5, 1, 1, 2, "info_fuel_tunnel_fallback_end", "info_grenade_truck_guys_fallback");
    level thread cp_prologue_util::function_e0fb6da9("s_enemy_moveup_point_5", 100, 5, 1, 1, 2, "info_fuel_tunnel_fallback_end", "info_grenade_truck_guys_fallback");
    level thread function_50d18609();
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x7666d252, Offset: 0x2940
// Size: 0x3c
function function_b7afdf3a() {
    trigger::wait_till("t_fueling_tunnel_alert_enemy");
    level flag::set("fuel_tunnel_alerted");
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0xf63c9d09, Offset: 0x2988
// Size: 0xba
function function_e14a508d() {
    a_ents = getentarray("sp_fueling_stairwell_intro_guys", "targetname");
    for (i = 0; i < a_ents.size; i++) {
        e_ent = a_ents[i] spawner::spawn();
        e_ent.overrideactordamage = &function_e93a75b6;
        e_ent.goalradius = 32;
    }
    level notify(#"hash_db677f8c");
}

// Namespace namespace_ab720c84
// Params 13, eflags: 0x0
// Checksum 0xc6c793a0, Offset: 0x2a50
// Size: 0xa6
function function_e93a75b6(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
    if (isdefined(eattacker) && !isplayer(eattacker)) {
        idamage = self.health + 1;
    }
    return idamage;
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0xfef665f4, Offset: 0x2b00
// Size: 0xec
function function_88ddc4d5() {
    level scene::add_scene_func("p7_fxanim_cp_prologue_underground_truck_explode_bundle", &function_70b550de);
    level thread scene::play("p7_fxanim_cp_prologue_underground_truck_explode_bundle");
    level clientfield::set("fuel_depot_truck_explosion", 1);
    var_4d2c50ee = getent("orig_fuel_tunnel_explosion", "targetname");
    level.var_2fd26037 radiusdamage(var_4d2c50ee.origin, 300, 2001, 2000, undefined, "MOD_EXPLOSIVE");
}

// Namespace namespace_ab720c84
// Params 1, eflags: 0x0
// Checksum 0x5246f697, Offset: 0x2bf8
// Size: 0x8c
function function_70b550de(a_ents) {
    a_ents["underground_truck_explode"] waittill(#"hash_5ec0d21e");
    a_ents["underground_truck_explode"] setmodel("veh_t7_civ_truck_med_cargo_egypt_dead");
    var_f33f812b = getent("fuel_truck_faxnim_clip", "targetname");
    var_f33f812b solid();
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x56fc34ce, Offset: 0x2c90
// Size: 0x34
function function_f41e9505() {
    wait 0.5;
    level thread cp_prologue_util::function_8f7b1e06(undefined, "info_grenade_truck_guys", "info_grenade_truck_guys_fallback");
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x480c41f4, Offset: 0x2cd0
// Size: 0x214
function function_ee3c7f46() {
    trigger::wait_till("t_spawn_machine_gunner");
    var_9bc6eb0e = getent("fueltunnel_spawnclosetdoor_1", "targetname");
    var_9bc6eb0e rotateto(var_9bc6eb0e.angles + (0, -150, 0), 0.5);
    var_9bc6eb0e playsound("evt_spawner_door_open");
    var_8e7793a5 = getent("info_fuel_tunnel_fallback_end", "targetname");
    a_ai = getentarray("sp_fuel_tunnel_upper_door", "targetname");
    a_players = getplayers();
    if (a_players.size == 1) {
        n_num_to_spawn = 1;
    } else if (a_players.size == 2) {
        n_num_to_spawn = 2;
    } else {
        n_num_to_spawn = 5;
    }
    if (n_num_to_spawn > a_ai.size) {
        n_num_to_spawn = a_ai.size;
    }
    for (i = 0; i < n_num_to_spawn; i++) {
        e_ent = a_ai[i] spawner::spawn();
        e_ent thread cp_prologue_util::function_8e9f617f(1024, undefined);
        wait 0.5;
    }
    level thread function_3964d78d();
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0xf1761e99, Offset: 0x2ef0
// Size: 0x2ac
function function_3964d78d() {
    e_volume = getent("info_final_tunnel_attackers", "targetname");
    ready = 0;
    while (!ready) {
        if (level.var_2fd26037 istouching(e_volume)) {
            ready = 1;
        }
        a_players = getplayers();
        for (i = 0; i < a_players.size; i++) {
            if (a_players[i] istouching(e_volume)) {
                ready = 1;
            }
        }
        wait 0.05;
    }
    var_fe3db664 = getentarray("sp_fuel_tunnel_stairs_attackers", "targetname");
    for (i = 0; i < var_fe3db664.size; i++) {
        e_ent = var_fe3db664[i] spawner::spawn();
        nd_target = getnode(e_ent.target, "targetname");
        e_ent.goalradius = -116;
        e_ent setgoal(nd_target.origin);
    }
    while (true) {
        var_f04bd8f5 = cp_prologue_util::function_609c412a("info_fuel_tunnel_upper_door", 1);
        if (!var_f04bd8f5) {
            break;
        }
        wait 0.05;
    }
    var_9bc6eb0e = getent("fueltunnel_spawnclosetdoor_1", "targetname");
    var_9bc6eb0e rotateto(var_9bc6eb0e.angles - (0, -150, 0), 0.5);
    var_9bc6eb0e playsound("evt_spawner_door_close");
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x2b96221, Offset: 0x31a8
// Size: 0x40c
function function_672c874() {
    self function_8b6e6abe();
    level flag::wait_till("start_grenade_roll");
    level thread scene::play("cin_pro_06_01_hostage_vign_rollgrenade", level.var_2fd26037);
    level util::delay(0.5, undefined, &trigger::use, "t_script_color_allies_r510");
    level.var_2fd26037 waittill(#"hash_ff2562ea");
    level thread cp_prologue_util::function_2a0bc326(level.var_2fd26037.origin, 0.65, 1.2, 800, 4);
    level.var_2fd26037 ai::set_pacifist(0);
    level.var_2fd26037 ai::set_ignoreme(0);
    level.var_2fd26037 ai::set_ignoreall(0);
    s_struct = struct::get("s_truck_explosion_origin", "targetname");
    physicsexplosionsphere(s_struct.origin, -1, -2, 0.3, 25, 400);
    wait 0.1;
    var_ff31c6f9 = getentarray("truck_red_barrel", "script_noteworthy");
    foreach (piece in var_ff31c6f9) {
        if (isdefined(piece) && piece.targetname == "destructible") {
            piece dodamage(5000, piece.origin, level.var_2fd26037);
        }
    }
    wait 0.3;
    var_7bb33476 = getnode("nd_grenade_throw", "targetname");
    setenablenode(var_7bb33476, 0);
    trigger::use("t_script_color_allies_r520");
    cp_prologue_util::function_d1f1caad("t_script_color_allies_r530");
    cp_prologue_util::function_d1f1caad("t_script_color_allies_r540");
    scene::play("cin_pro_06_01_hostage_vign_jumpdown");
    self colors::enable();
    self setgoal(self.origin);
    wait 1;
    trigger::use("t_script_color_allies_r550");
    wait 1;
    self waittill(#"goal");
    self.goalradius = 256;
    cp_prologue_util::function_d1f1caad("t_script_color_allies_r560");
    function_7a05bbf();
    if (getplayers().size == 1) {
        level notify(#"hash_bf9ccb51");
    }
    self thread function_5dc67e92();
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x2b08fda, Offset: 0x35c0
// Size: 0x1e4
function function_5dc67e92() {
    self endon(#"hash_89827d0f");
    e_volume = getent("info_fuel_tunnel_fallback_end", "targetname");
    while (true) {
        a_ai = cp_prologue_util::function_68b8f4af(e_volume);
        if (a_ai.size <= 3) {
            array::thread_all(a_ai, &ai::bloody_death, randomintrange(6, 8));
        }
        if (a_ai.size <= 1) {
            break;
        }
        wait 0.05;
    }
    e_trigger = getent("t_script_color_allies_r580", "targetname");
    if (isdefined(e_trigger)) {
        e_trigger delete();
    }
    self thread function_386e6074();
    function_1ddfda41();
    nd_node = getnode("nd_fueling_tunnel_exit", "targetname");
    self setgoal(nd_node.origin);
    self.goalradius = 64;
    self util::waittill_notify_or_timeout("goal", 15);
    self notify(#"hash_8882daa6");
    self thread function_c9d7d48a();
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x142c6a1c, Offset: 0x37b0
// Size: 0xd4
function function_386e6074() {
    var_72634645 = spawnstruct();
    var_72634645.origin = (5742, -1122, -328);
    var_72634645.angles = (0, 270, 0);
    var_f3ec8a31 = spawn("trigger_box", (5728, -1308, -276), 0, 300, 300, 300);
    var_f3ec8a31 waittill(#"trigger");
    self colors::function_89827d0f(var_72634645, 350, 1, &function_bbaa282a);
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0xe7148e9b, Offset: 0x3890
// Size: 0xa4
function function_bbaa282a() {
    wait 0.5;
    nd_node = getnode("nd_fueling_tunnel_exit", "targetname");
    self setgoal(nd_node.origin);
    self.goalradius = 64;
    self util::waittill_notify_or_timeout("goal", 15);
    self thread function_c9d7d48a();
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x55bedac1, Offset: 0x3940
// Size: 0xa4
function function_7a05bbf() {
    while (true) {
        e_trigger = getent("t_script_color_allies_r570", "targetname");
        if (!isdefined(e_trigger)) {
            break;
        }
        var_f04bd8f5 = cp_prologue_util::function_609c412a("info_fuel_tunnel_fallback_end", 0);
        if (var_f04bd8f5 <= 3) {
            trigger::use("t_script_color_allies_r570");
            break;
        }
        wait 0.05;
    }
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x9d3e02fe, Offset: 0x39f0
// Size: 0x204
function function_1ddfda41() {
    e_volume = getent("info_fueling_tunnel_balcony", "targetname");
    a_enemy = cp_prologue_util::function_68b8f4af(e_volume);
    for (i = 0; i < a_enemy.size; i++) {
        self getperfectinfo(a_enemy[i], 1);
        a_enemy[i].overrideactordamage = &function_e93a75b6;
    }
    nd_node = getnode("nd_fueling_tunnel_top_stairs", "targetname");
    self setgoal(nd_node.origin);
    self.goalradius = 64;
    self waittill(#"goal");
    while (true) {
        a_enemy = cp_prologue_util::function_68b8f4af(e_volume);
        if (a_enemy.size == 0) {
            break;
        }
        wait 0.05;
    }
    for (var_1f6e1fda = getaiteamarray("axis"); var_1f6e1fda.size > 0; var_1f6e1fda = getaiteamarray("axis")) {
        var_1f6e1fda[0] ai::bloody_death();
        wait randomfloatrange(0.666667, 1.33333);
    }
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x272bdfc6, Offset: 0x3c00
// Size: 0xcc
function function_50d18609() {
    level waittill(#"hash_bf9ccb51");
    a_nodes = getnodearray("nd_fueling_end", "targetname");
    for (i = 0; i < a_nodes.size; i++) {
        nd_node = a_nodes[i];
        setenablenode(nd_node, 0);
    }
    wait 2;
    cp_prologue_util::function_8f7b1e06(undefined, "info_fuel_tunnel_fallback_end", "info_fueling_flush_out_volume");
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x74021e69, Offset: 0x3cd8
// Size: 0x224
function function_8b6e6abe() {
    level flag::wait_till("hendricks_exit_cam_room");
    wait 0.5;
    level thread function_1479714d();
    self ai::set_behavior_attribute("can_melee", 0);
    self colors::disable();
    nd_node = getnode("nd_hendricks_attack_fueling_start_guys", "targetname");
    self.perfectaim = 1;
    self.goalradius = 32;
    self ai::force_goal(nd_node);
    wait 1;
    a_enemy = spawner::get_ai_group_ai("tunnel_1st_contact_guys");
    foreach (enemy in a_enemy) {
        if (isdefined(enemy) && isalive(enemy)) {
            self ai::shoot_at_target("shoot_until_target_dead", enemy);
        }
    }
    spawner::waittill_ai_group_cleared("tunnel_1st_contact_guys");
    self.perfectaim = 0;
    self.goalradius = 512;
    self ai::set_behavior_attribute("can_melee", 1);
    self colors::enable();
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x870848ca, Offset: 0x3f08
// Size: 0x264
function function_c9d7d48a() {
    e_volume = getent("info_fueling_tunnel_exit_area", "targetname");
    while (true) {
        num_players = cp_prologue_util::function_fcb42941(e_volume);
        if (num_players > 0) {
            break;
        }
        wait 0.05;
    }
    level thread namespace_21b2c1f2::function_d4c52995();
    wait 0.15;
    level scene::add_scene_func("cin_pro_06_02_hostage_vign_getminister_hendricks_airlock", &function_5729b9e7, "play");
    level scene::play("cin_pro_06_02_hostage_vign_getminister_hendricks_airlock");
    n_node = getnode("nd_hendricks_jail_setup", "targetname");
    level.var_2fd26037 setgoal(n_node, 1);
    wait 0.5;
    level notify(#"hash_5d08c61e");
    s_struct = struct::get("s_close_security_door", "targetname");
    while (true) {
        v_forward = anglestoforward(s_struct.angles);
        v_dir = vectornormalize(s_struct.origin - level.var_2fd26037.origin);
        dp = vectordot(v_forward, v_dir);
        if (dp < 0) {
            break;
        }
        wait 0.1;
    }
    cp_prologue_util::function_9d611fab("s_close_security_door", undefined);
    level thread function_6ae70954(0);
}

// Namespace namespace_ab720c84
// Params 1, eflags: 0x0
// Checksum 0x4f67794e, Offset: 0x4178
// Size: 0x34
function function_5729b9e7(a_ents) {
    level waittill(#"hash_5729b9e7");
    level function_6ae70954(1);
}

// Namespace namespace_ab720c84
// Params 1, eflags: 0x0
// Checksum 0x7e6f6aa2, Offset: 0x41b8
// Size: 0x214
function function_6ae70954(open_door) {
    exploder::exploder("fx_exploder_door_vacuum");
    var_bcc5e65a = getent("holdingcells_entrydoor_1", "targetname");
    var_96c36bf1 = getent("holdingcells_entrydoor_2", "targetname");
    if (open_door) {
        exploder::exploder("light_exploder_prison_door");
        var_bcc5e65a movex(64, 1, 0.1, 0.2);
        var_bcc5e65a playsound("evt_fueldepot_door_open");
        wait 0.25;
        var_96c36bf1 movex(64, 1, 0.1, 0.2);
        var_96c36bf1 playsound("evt_fueldepot_door_open");
        return;
    }
    exploder::stop_exploder("light_exploder_prison_door");
    var_96c36bf1 movex(-64, 1, 0.1, 0.2);
    var_96c36bf1 playsound("evt_fueldepot_door_close");
    wait 0.25;
    var_bcc5e65a movex(-64, 1, 0.1, 0.2);
    var_bcc5e65a playsound("evt_fueldepot_door_close");
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x426fcb2e, Offset: 0x43d8
// Size: 0x3c
function function_df74ca81() {
    self endon(#"death");
    self waittill(#"weapon_fired");
    level flag::set("fuel_tunnel_alerted");
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0xe9884a88, Offset: 0x4420
// Size: 0x74
function function_1479714d() {
    trigger::wait_till("t_spawn_machine_gunner");
    wait 1;
    level.var_2fd26037 dialog::say("hend_gunner_up_top_0");
    level waittill(#"hash_5d08c61e");
    level.var_2fd26037 dialog::say("hend_cell_block_ahead_on_0");
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0x7072e264, Offset: 0x44a0
// Size: 0x40
function function_c1e0b282() {
    trigger::wait_till("t_spawn_machine_gunner");
    var_cf0db380 = spawner::simple_spawn_single("fuel_tunnel_mg_guy");
}

// Namespace namespace_ab720c84
// Params 6, eflags: 0x0
// Checksum 0xe59d1a0f, Offset: 0x44e8
// Size: 0x284
function function_d9bab593(str_trigger, str_door, var_a9ea049a, var_137809d6, var_343b0267, var_bfba634f) {
    if (!isdefined(var_bfba634f)) {
        var_bfba634f = 1;
    }
    e_trigger = getent(str_trigger, "targetname");
    e_trigger waittill(#"trigger");
    e_door = getent(str_door, "targetname");
    e_door rotateto(e_door.angles + (0, -110, 0), 0.5);
    e_door playsound("evt_spawner_door_open");
    var_ab891f49 = getent(var_343b0267, "targetname");
    a_ai = getentarray(var_a9ea049a, "targetname");
    for (i = 0; i < a_ai.size; i++) {
        e_ent = a_ai[i] spawner::spawn();
        e_ent setgoal(var_ab891f49);
        wait 1.5;
    }
    if (!var_bfba634f) {
        return;
    }
    wait 1;
    while (true) {
        var_f04bd8f5 = cp_prologue_util::function_609c412a(var_137809d6, 1);
        if (!var_f04bd8f5) {
            break;
        }
        wait 0.05;
    }
    e_door rotateto(e_door.angles + (0, 110, 0), 0.5);
    e_door playsound("evt_spawner_door_close");
}

// Namespace namespace_ab720c84
// Params 0, eflags: 0x0
// Checksum 0xf943c0b0, Offset: 0x4778
// Size: 0x194
function function_12ac9114() {
    var_1e913765 = getent("sp_stair_runners", "targetname");
    e_volume = getent("info_fuel_tunnel_fallback_end", "targetname");
    level thread function_6ae70954(1);
    level flag::wait_till("fuel_tunnel_stair_runners_1");
    ai_enemy = var_1e913765 spawner::spawn();
    ai_enemy setgoal(e_volume);
    wait 1.5;
    ai_enemy = var_1e913765 spawner::spawn();
    ai_enemy setgoal(e_volume);
    level flag::wait_till("fuel_tunnel_stair_runners_2");
    ai_enemy = var_1e913765 spawner::spawn();
    ai_enemy setgoal(e_volume);
    wait 3;
    level thread function_6ae70954(0);
}

#namespace prison;

// Namespace prison
// Params 1, eflags: 0x0
// Checksum 0x7b6030ac, Offset: 0x4918
// Size: 0x254
function function_955cbf0d(str_objective) {
    function_8ee087ec();
    if (!isdefined(level.var_2fd26037)) {
        level.var_2fd26037 = util::function_740f8516("hendricks");
        cp_mi_eth_prologue::function_bff1a867("skipto_prison_hendricks");
        skipto::teleport_ai(str_objective);
    }
    if (!isdefined(level.var_4d5a4697)) {
        level.var_4d5a4697 = util::function_740f8516("minister");
        level.var_4d5a4697.ignoreme = 1;
        level.var_4d5a4697.ignoreall = 1;
        cp_mi_eth_prologue::function_211ff3c7("skipto_prison_minister");
        level.var_4d5a4697.goalradius = 64;
    }
    if (!isdefined(level.var_9db406db)) {
        level.var_9db406db = util::function_740f8516("khalil");
        level.var_9db406db.ignoreme = 1;
        level.var_9db406db.ignoreall = 1;
        cp_mi_eth_prologue::function_c117302b("skipto_prison_khalil");
        level.var_9db406db.goalradius = 64;
    }
    trigger::use("t_prison_respawns_disable", "targetname", undefined, 0);
    battlechatter::function_d9f49fba(0);
    cp_prologue_util::function_47a62798(1);
    level.var_2fd26037.pacifist = 0;
    level.var_2fd26037.ignoreme = 0;
    level flag::init("khalil_door_breached");
    level flag::init("player_interrogation_breach");
    level thread function_13bbee98();
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x4b78
// Size: 0x4
function function_8ee087ec() {
    
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x192956ff, Offset: 0x4b88
// Size: 0x16c
function function_13bbee98() {
    level thread cp_prologue_util::function_950d1c3b(1);
    level thread function_b317c15f();
    level thread scene::init("cin_pro_06_03_hostage_1st_khalil_intro_rescue");
    namespace_52f8de11::function_bfe70f02();
    level thread function_f50dec65();
    level thread function_771ca4c3();
    var_beb17601 = getent("collision_observation_door", "targetname");
    var_ddb80384 = getent("observation_door", "targetname");
    var_beb17601 linkto(var_ddb80384);
    level thread function_ef1899fb();
    level.var_2fd26037 thread function_299a41be();
    level thread function_15c51270();
    level thread function_37b5c7e0();
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x570d7d2b, Offset: 0x4d00
// Size: 0x74
function function_f50dec65() {
    level thread util::function_d8eaed3d(3);
    level waittill(#"hash_516cb5e4");
    util::clear_streamer_hint();
    level thread util::function_d8eaed3d(4);
    level waittill(#"hash_29445f62");
    util::clear_streamer_hint();
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x9b10c9f8, Offset: 0x4d80
// Size: 0x1ec
function function_771ca4c3() {
    objectives::set("cp_level_prologue_free_the_minister");
    callback::on_ai_killed(&namespace_61c634f2::function_c58a9e36);
    level flag::wait_till("player_entered_observation");
    objectives::complete("cp_level_prologue_goto_minister_door");
    level waittill(#"hash_a859aef4");
    objectives::complete("cp_level_prologue_free_the_minister");
    savegame::checkpoint_save();
    level waittill(#"hash_ed07bf8c");
    trigger::use("t_prison_respawns_enable", "targetname", undefined, 0);
    s_pos = struct::get("s_objective_khalil_cell", "targetname");
    objectives::set("cp_level_prologue_goto_khalil_door", s_pos);
    objectives::set("cp_level_prologue_free_khalil");
    level flag::wait_till("khalil_door_breached");
    objectives::complete("cp_level_prologue_goto_minister_door");
    objectives::complete("cp_level_prologue_free_khalil");
    callback::remove_on_ai_killed(&namespace_61c634f2::function_c58a9e36);
    objectives::set("cp_level_prologue_get_to_the_surface");
    level waittill(#"hash_f83eeed5");
    level thread objectives::breadcrumb("post_prison_breadcrumb_start");
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x2d9d08b, Offset: 0x4f78
// Size: 0xcc
function function_299a41be() {
    nd_node = getnode("nd_hendricks_jail_setup", "targetname");
    self setgoal(nd_node, 1);
    self waittill(#"goal");
    level flag::wait_till("post_up_minister_breach");
    level thread function_a1ad4aa7();
    self sethighdetail(1);
    function_a859aef4();
    self sethighdetail(0);
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x87e2748f, Offset: 0x5050
// Size: 0x54
function function_22b149da() {
    level waittill(#"hash_5ea48ae9");
    level thread namespace_21b2c1f2::function_1c0460dd();
    level waittill(#"hash_35308140");
    level.var_2fd26037 dialog::say("hend_depot_ahead_will_be_0");
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x83e23e6e, Offset: 0x50b0
// Size: 0x2c
function function_f48bd4a7() {
    level waittill(#"hash_1dd905ef");
    exploder::exploder("light_exploder_prison_exit");
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x11c999f0, Offset: 0x50e8
// Size: 0x1ea
function function_a859aef4() {
    var_6553bad6 = getent("trig_use_khalil_door", "targetname");
    var_6553bad6 triggerenable(0);
    level thread scene::play("cin_pro_06_03_hostage_vign_breach_hendrickscover");
    level flag::wait_till("player_entered_observation");
    level thread function_b8c0a930();
    if (isdefined(level.var_57de23a9)) {
        level thread [[ level.var_57de23a9 ]]();
    }
    level flag::wait_till_any(array("interrogation_finished", "player_breached_early"));
    level thread scene::play("cin_pro_06_03_hostage_vign_breach");
    level thread scene::play("cin_pro_06_03_hostage_vign_breach_hend_min");
    level notify(#"hash_a859aef4");
    level.var_4d5a4697.overrideactordamage = undefined;
    level waittill(#"hash_ed07bf8c");
    var_6553bad6 triggerenable(1);
    var_d86e08d0 = util::function_14518e76(var_6553bad6, %cp_prompt_enteralt_prologue_khalil_breach, %CP_MI_ETH_PROLOGUE_DOOR_BREACH, &function_28af2208);
    var_d86e08d0 thread gameobjects::function_e0e2d0fe((1, 1, 1), 800, 0);
    level notify(#"hash_bd4342ed");
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0xfff10dfc, Offset: 0x52e0
// Size: 0x54
function function_db5cf0d5() {
    self endon(#"death");
    level endon(#"player_breached_early");
    level endon(#"interrogation_finished");
    self waittill(#"weapon_fired");
    level flag::set("player_breached_early");
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x4c7331ec, Offset: 0x5340
// Size: 0x34
function function_a1ad4aa7() {
    level waittill(#"hash_5e84ced9");
    level clientfield::set("interrogate_physics", 1);
}

// Namespace prison
// Params 1, eflags: 0x0
// Checksum 0x6ca8042, Offset: 0x5380
// Size: 0x18c
function function_28af2208(e_player) {
    self gameobjects::disable_object();
    array::run_all(level.players, &util::function_16c71b8, 1);
    callback::on_spawned(&cp_mi_eth_prologue::function_4d4f1d4f);
    level thread function_2137acd9();
    level flag::set("khalil_door_breached");
    level thread scene::play("cin_pro_06_03_hostage_1st_khalil_intro_player_rescue", e_player);
    level thread scene::play("cin_pro_06_03_hostage_1st_khalil_intro_rescue");
    level.var_9db406db sethighdetail(1);
    level thread function_22b149da();
    level thread function_f48bd4a7();
    level waittill(#"hash_f83eeed5");
    level.var_9db406db sethighdetail(0);
    level notify(#"hash_29445f62");
    skipto::function_be8adfb8("skipto_prison");
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x65a902a6, Offset: 0x5518
// Size: 0x84
function function_2137acd9() {
    wait 42;
    array::run_all(level.players, &util::function_16c71b8, 0);
    callback::remove_on_spawned(&cp_mi_eth_prologue::function_4d4f1d4f);
    level thread cp_prologue_util::function_77308ba7();
    level thread function_fae1bd07();
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0xbd72f079, Offset: 0x55a8
// Size: 0x5c
function function_fae1bd07() {
    playsoundatposition("amb_walla_troops_1", (6175, -1548, -157));
    wait 8;
    playsoundatposition("amb_walla_troops_0", (6129, -1037, -266));
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x3161f09f, Offset: 0x5610
// Size: 0x24
function function_b8c0a930() {
    level.var_4d5a4697.overrideactordamage = &function_9b720436;
}

// Namespace prison
// Params 13, eflags: 0x0
// Checksum 0x5063ce04, Offset: 0x5640
// Size: 0x134
function function_9b720436(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
    if (isdefined(eattacker) && isplayer(eattacker)) {
        if (isdefined(weapon) && (idamage <= 1 || weapon.isemp)) {
            idamage = 0;
        }
        if (!isdefined(self.var_28e02422)) {
            self.var_28e02422 = 0;
        }
        self.var_28e02422 += idamage;
        if (self.var_28e02422 >= self.maxhealth) {
            util::function_207f8667(%CP_MI_ETH_PROLOGUE_MINISTER_SHOT, %SCRIPT_MISSIONFAIL_WATCH_FIRE);
        } else {
            idamage = 0;
        }
    }
    return idamage;
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x999322ee, Offset: 0x5780
// Size: 0xac
function function_ef1899fb() {
    var_130a032 = getent("trig_use_minister_door", "targetname");
    var_130a032 triggerenable(1);
    var_e0897b20 = util::function_14518e76(var_130a032, %cp_prompt_enteralt_prologue_minister_breach, %CP_MI_ETH_PROLOGUE_DOOR_BREACH, &function_b0c29b02);
    var_e0897b20 thread gameobjects::function_e0e2d0fe((1, 1, 1), 800, 0);
}

// Namespace prison
// Params 1, eflags: 0x0
// Checksum 0x3068bb35, Offset: 0x5838
// Size: 0x18c
function function_b0c29b02(e_player) {
    self.trigger triggerenable(0);
    self gameobjects::disable_object();
    foreach (var_12195048 in level.activeplayers) {
        var_12195048 util::function_16c71b8(1);
        var_12195048 thread function_db5cf0d5();
    }
    callback::on_spawned(&cp_mi_eth_prologue::function_4d4f1d4f);
    level flag::set("player_interrogation_breach");
    level scene::play("cin_pro_06_03_hostage_vign_breach_playerbreach", e_player);
    level notify(#"hash_516cb5e4");
    level thread dialog::function_13b3b16a("plyr_interrogator_has_his_0", 3);
    level thread function_813f55a8();
}

// Namespace prison
// Params 1, eflags: 0x0
// Checksum 0x597e5e14, Offset: 0x59d0
// Size: 0x6c
function function_f8d7f50a(a_ents) {
    e_door = a_ents["observation_door"];
    e_door setmodel("p7_door_metal_security_02_rt_keypad");
    level waittill(#"hash_18c83555");
    e_door setmodel("p7_door_metal_security_02_rt_keypad_damage");
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0xd06242c1, Offset: 0x5a48
// Size: 0xf4
function function_b317c15f() {
    level scene::add_scene_func("cin_pro_06_03_hostage_vign_breach_interrogation", &function_b8d7b823, "init");
    level scene::init("cin_pro_06_03_hostage_vign_breach_interrogation");
    level waittill(#"hash_5c0ece37");
    scene::add_scene_func("cin_pro_06_03_hostage_vign_breach_guardloop", &function_53775c4d, "play");
    level thread scene::play("cin_pro_06_03_hostage_vign_breach_guardloop");
    level scene::play("cin_pro_06_03_hostage_vign_breach_interrogation");
    level flag::set("interrogation_finished");
}

// Namespace prison
// Params 1, eflags: 0x0
// Checksum 0x8a26a2ad, Offset: 0x5b48
// Size: 0x174
function function_b8d7b823(a_ents) {
    a_ents["interrogator"].var_69dd5d62 = 0;
    a_ents["interrogator"] cybercom::function_59965309("cybercom_fireflyswarm");
    level waittill(#"hash_7890ba26");
    level.var_2fd26037 dialog::say("hend_on_my_mark_0");
    wait 1;
    level.var_2fd26037 thread dialog::say("hend_three_two_go_0");
    level thread namespace_21b2c1f2::function_2f85277b();
    wait 1;
    foreach (e_player in level.activeplayers) {
        e_player util::function_16c71b8(0);
    }
    callback::remove_on_spawned(&cp_mi_eth_prologue::function_4d4f1d4f);
}

// Namespace prison
// Params 1, eflags: 0x0
// Checksum 0xc9d56732, Offset: 0x5cc8
// Size: 0xba
function function_53775c4d(a_ents) {
    foreach (ai_guard in a_ents) {
        ai_guard.var_c54411a6 = 1;
        ai_guard.var_69dd5d62 = 0;
        ai_guard cybercom::function_59965309("cybercom_fireflyswarm");
    }
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0xc752078b, Offset: 0x5d90
// Size: 0xd4
function function_813f55a8() {
    trigger::wait_till("trig_dam_int_room");
    level thread cp_prologue_util::function_2a0bc326(level.var_2fd26037.origin, 0.3, 0.75, 5000, 10, "damage_heavy");
    var_d3079b09 = getent("int_room_sound_wall", "targetname");
    var_d3079b09 delete();
    hidemiscmodels("interrogation_glass_hologram");
    exploder::exploder("fx_exploder_glass_screen");
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x6ab64a9e, Offset: 0x5e70
// Size: 0x74
function function_15c51270() {
    level thread function_88b82e8a();
    level waittill(#"hash_a859aef4");
    level thread function_b1d2594d();
    level flag::wait_till("khalil_door_breached");
    level thread namespace_21b2c1f2::function_fb4a2ce1();
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0xc7f11e40, Offset: 0x5ef0
// Size: 0x34
function function_88b82e8a() {
    level endon(#"player_interrogation_breach");
    wait 17;
    level.var_2fd26037 dialog::say("hend_that_exfil_won_t_wai_0");
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x82af6675, Offset: 0x5f30
// Size: 0x6c
function function_b1d2594d() {
    level endon(#"khalil_door_breached");
    level waittill(#"hash_bd4342ed");
    wait 20;
    level.var_2fd26037 dialog::say("hend_sooner_we_get_khalil_0");
    wait 15;
    level.var_2fd26037 dialog::say("hend_they_re_gonna_be_on_0");
}

// Namespace prison
// Params 0, eflags: 0x0
// Checksum 0x5718fef9, Offset: 0x5fa8
// Size: 0xa4
function function_37b5c7e0() {
    level thread function_c11e5214("trig_volume_prisoner1_cell", "pris_please_please_help_0");
    level thread function_c11e5214("trig_volume_prisoner2_cell", "pris_get_us_out_of_here_0");
    level thread function_c11e5214("trig_volume_prisoner3_cell", "pris_don_t_leave_me_here_0");
    level thread function_c11e5214("trig_volume_prisoner4_cell", "pris_please_help_us_0");
}

// Namespace prison
// Params 2, eflags: 0x0
// Checksum 0x726de23e, Offset: 0x6058
// Size: 0x5c
function function_c11e5214(str_trigger, str_vo) {
    level trigger::wait_till(str_trigger, "targetname", undefined, 0);
    level.var_2fd26037 dialog::say(str_vo);
}

#namespace namespace_52f8de11;

// Namespace namespace_52f8de11
// Params 1, eflags: 0x0
// Checksum 0x227ca899, Offset: 0x60c0
// Size: 0xf4
function function_72514870(str_objective) {
    function_6141027f();
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_4d5a4697 ai::set_ignoreall(0);
    battlechatter::function_d9f49fba(1);
    cp_prologue_util::function_47a62798(1);
    spawner::add_spawn_function_group("bridge_attacker", "script_noteworthy", &Hangar::function_33ec51ea);
    level thread function_b8fd868b();
    trigger::wait_till("t_start_lift_battle");
    skipto::function_be8adfb8("skipto_security_desk");
}

// Namespace namespace_52f8de11
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x61c0
// Size: 0x4
function function_6141027f() {
    
}

// Namespace namespace_52f8de11
// Params 0, eflags: 0x0
// Checksum 0xd8b20055, Offset: 0x61d0
// Size: 0xe4
function function_b8fd868b() {
    level thread cp_prologue_util::function_950d1c3b(1);
    level thread function_e6af47cb();
    level thread function_5e374f7a();
    var_88e2cef7 = getent("trig_open_weapons_room", "targetname");
    var_88e2cef7 triggerenable(1);
    level flag::wait_till("open_weapons_room");
    level thread namespace_21b2c1f2::function_6c35b4f3();
    level thread function_b60a26e8();
}

// Namespace namespace_52f8de11
// Params 0, eflags: 0x0
// Checksum 0x2375ac3, Offset: 0x62c0
// Size: 0x38
function function_bfe70f02() {
    if (!isdefined(level.var_e5ed7cda)) {
        scene::init("cin_pro_07_01_securitydesk_vign_weapons_doorinit");
        level.var_e5ed7cda = 1;
    }
}

// Namespace namespace_52f8de11
// Params 0, eflags: 0x0
// Checksum 0x7ef4ebf6, Offset: 0x6300
// Size: 0x8c
function function_5e374f7a() {
    level flag::wait_till("open_weapons_room");
    level waittill(#"hash_ecefb6c8");
    level thread function_4fd5aaec();
    wait 1;
    level thread function_bce54c0b();
    level thread function_36113d75();
    level thread function_680575de();
}

// Namespace namespace_52f8de11
// Params 0, eflags: 0x0
// Checksum 0xce883277, Offset: 0x6398
// Size: 0x29e
function function_4fd5aaec() {
    a_ai = getentarray("sp_armory_lift_area_1st_attacker", "targetname");
    for (i = 0; i < a_ai.size; i++) {
        e_ent = a_ai[i] spawner::spawn();
        nd_node = getnode(e_ent.target, "targetname");
        e_ent.goalradius = 64;
        e_ent setgoal(nd_node.origin);
        e_ent thread cp_prologue_util::function_8e9f617f(256, 1);
    }
    e_volume = getent("info_armory_enemy_pushup", "targetname");
    a_ai = getentarray("sp_armory_lift_area_attackers", "targetname");
    for (i = 0; i < a_ai.size; i++) {
        e_ent = a_ai[i] spawner::spawn();
        e_ent setgoal(e_volume);
        e_ent thread cp_prologue_util::function_8e9f617f(512, 1);
    }
    e_volume = getent("info_armory_wave2", "targetname");
    a_ai = getentarray("sp_armory_lift_area_attackers_part2", "targetname");
    for (i = 0; i < a_ai.size; i++) {
        e_ent = a_ai[i] spawner::spawn();
        e_ent setgoal(e_volume);
        e_ent thread cp_prologue_util::function_8e9f617f(512, 1);
    }
}

// Namespace namespace_52f8de11
// Params 0, eflags: 0x0
// Checksum 0x6ec3de8f, Offset: 0x6640
// Size: 0xa4
function function_bce54c0b() {
    a_spawners = getentarray("sp_armory_walkway_attackers", "targetname");
    for (i = 0; i < a_spawners.size; i++) {
        e_ent = a_spawners[i] spawner::spawn();
        wait 1.5;
    }
    wait 3;
    level thread function_ad03757a();
}

// Namespace namespace_52f8de11
// Params 0, eflags: 0x0
// Checksum 0x57a2607b, Offset: 0x66f0
// Size: 0xc4
function function_36113d75() {
    level thread cp_prologue_util::function_e0fb6da9("s_armory_moveup_start", -16, 7, 1, 1, 3, "info_armory_wave2", "info_armory_enemy_pushup");
    level thread cp_prologue_util::function_e0fb6da9("s_armory_moveup_point_left", -16, 4, 1, 1, 6, "info_armory_wave2", "info_armory_enemy_pushup");
    level thread cp_prologue_util::function_e0fb6da9("s_armory_moveup_point_right", -16, 4, 1, 1, 6, "info_armory_wave2", "info_armory_enemy_pushup");
}

// Namespace namespace_52f8de11
// Params 0, eflags: 0x0
// Checksum 0xa9a98a4d, Offset: 0x67c0
// Size: 0x10c
function function_e6af47cb() {
    level flag::wait_till("open_weapons_room");
    level.var_2fd26037 setgoal(level.var_2fd26037.origin);
    level.var_2fd26037 clearforcedgoal();
    level.var_2fd26037.goalradius = 64;
    level thread function_473b7de8();
    wait 2;
    trigger::use("trig_armory_color");
    cp_prologue_util::function_d1f1caad("t_script_color_allies_r2010");
    cp_prologue_util::function_d1f1caad("t_script_color_allies_r2020");
    cp_prologue_util::function_d1f1caad("t_script_color_allies_r2030");
    cp_prologue_util::function_d1f1caad("t_script_color_allies_r2040");
}

// Namespace namespace_52f8de11
// Params 0, eflags: 0x0
// Checksum 0x3b59a3de, Offset: 0x68d8
// Size: 0x10c
function function_473b7de8() {
    while (!scene::is_ready("cin_pro_07_01_securitydesk_vign_weapons")) {
        wait 0.05;
    }
    scene::add_scene_func("cin_pro_07_01_securitydesk_vign_weapons", &function_d4401b52);
    scene::play("cin_pro_07_01_securitydesk_vign_weapons");
    level notify(#"hash_69db142c");
    nd_node = getnode("nd_khalil_armory_battle", "targetname");
    level.var_9db406db.goalradius = 64;
    level.var_9db406db setgoal(nd_node.origin);
    level.var_9db406db waittill(#"goal");
    level.var_9db406db.goalradius = 512;
}

// Namespace namespace_52f8de11
// Params 1, eflags: 0x0
// Checksum 0x6c33af91, Offset: 0x69f0
// Size: 0xd4
function function_d4401b52(a_ents) {
    level endon(#"security_desk_done");
    level.var_4d5a4697 ai::gun_remove();
    level.var_9db406db ai::gun_remove();
    level.var_4d5a4697 waittill(#"hash_c89e55c9");
    a_ents["arak_m"] hide();
    level.var_4d5a4697 ai::gun_recall();
    level.var_9db406db waittill(#"hash_2dc522e9");
    a_ents["arak_k"] hide();
    level.var_9db406db ai::gun_recall();
}

// Namespace namespace_52f8de11
// Params 0, eflags: 0x0
// Checksum 0x589803b0, Offset: 0x6ad0
// Size: 0xd8
function function_ad03757a() {
    wait 3;
    a_ai = spawner::get_ai_group_ai("security_balcony");
    if (a_ai.size > 0) {
        var_b5dd40c7 = array::random(a_ai);
        var_b5dd40c7 scene::play("cin_pro_07_01_securitydesk_vign_dropdown", var_b5dd40c7);
        if (isalive(var_b5dd40c7)) {
            var_b5dd40c7 setgoal(var_b5dd40c7.origin);
            var_b5dd40c7.goalradius = 512;
        }
    }
}

// Namespace namespace_52f8de11
// Params 0, eflags: 0x0
// Checksum 0xb94dc2d0, Offset: 0x6bb0
// Size: 0xb6
function function_680575de() {
    cp_prologue_util::function_520255e3("t_armory_wave2", 5);
    var_fe3db664 = getentarray("sp_armory_wave2", "targetname");
    for (i = 0; i < var_fe3db664.size; i++) {
        e_ent = var_fe3db664[i] spawner::spawn();
        e_ent thread function_2fa59109();
    }
}

// Namespace namespace_52f8de11
// Params 0, eflags: 0x0
// Checksum 0x6fd31327, Offset: 0x6c70
// Size: 0x4c
function function_2fa59109() {
    e_volume = getent("info_armory_wave2", "targetname");
    self setgoal(e_volume);
}

// Namespace namespace_52f8de11
// Params 0, eflags: 0x0
// Checksum 0x2976fa64, Offset: 0x6cc8
// Size: 0x24
function function_d9f4b7bc() {
    level.var_9db406db thread dialog::say("khal_i_need_to_get_my_wea_0");
}

// Namespace namespace_52f8de11
// Params 0, eflags: 0x0
// Checksum 0xb379975f, Offset: 0x6cf8
// Size: 0x4c
function function_b60a26e8() {
    objectives::set("cp_level_prologue_defend_khalil", level.var_9db406db);
    level waittill(#"hash_69db142c");
    objectives::complete("cp_level_prologue_defend_khalil");
}

#namespace namespace_e80bc418;

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0xf8213853, Offset: 0x6d50
// Size: 0x70
function function_7280b87c() {
    level flag::init("lift_arrived");
    level flag::init("crane_in_position");
    level flag::init("crane_dropped");
    level.var_1dd14818 = 0;
}

// Namespace namespace_e80bc418
// Params 1, eflags: 0x0
// Checksum 0x46c7131e, Offset: 0x6dc8
// Size: 0x364
function function_68538fd(str_objective) {
    function_7280b87c();
    if (!isdefined(level.var_2fd26037)) {
        level.var_2fd26037 = util::function_740f8516("hendricks");
        cp_mi_eth_prologue::function_bff1a867();
        level.var_2fd26037.goalradius = 16;
        level.var_4d5a4697 = util::function_740f8516("minister");
        cp_mi_eth_prologue::function_211ff3c7();
        level.var_4d5a4697 ai::set_ignoreme(1);
        level.var_9db406db = util::function_740f8516("khalil");
        cp_mi_eth_prologue::function_c117302b();
        level.var_9db406db ai::set_ignoreme(1);
        skipto::teleport_ai(str_objective);
    }
    callback::on_ai_killed(&namespace_61c634f2::function_cbaf37cd);
    t_regroup_lift = getent("t_regroup_lift", "targetname");
    t_regroup_lift triggerenable(0);
    trigger::use("t_lift_respawns_disable");
    exploder::stop_exploder("light_exploder_prison_exit");
    level.var_2fd26037 ai::set_ignoreall(0);
    level.var_4d5a4697 ai::set_ignoreall(0);
    battlechatter::function_d9f49fba(1);
    cp_prologue_util::function_47a62798(1);
    level thread function_9793598c();
    level thread function_5517d018();
    level thread function_6fabe3da();
    level thread function_b17bd9c5();
    function_e97f7dba();
    t_regroup_lift = getent("t_regroup_lift", "targetname");
    t_regroup_lift triggerenable(1);
    trigger::use("t_lift_respawns_enable");
    level thread function_a3dbf6a2();
    level thread function_613d7b39();
    level waittill(#"hash_b100689e");
    callback::remove_on_ai_killed(&namespace_61c634f2::function_cbaf37cd);
    skipto::function_be8adfb8("skipto_lift_escape");
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x1b610609, Offset: 0x7138
// Size: 0x2ec
function function_9793598c() {
    level thread function_b1017ede();
    level thread cp_prologue_util::function_e0fb6da9("s_lift_enemy_moveup_point_1", -126, 10, 1, 2, 10, "v_lift_fallback", "info_lift_start_right_side");
    level thread function_eeb1c74e();
    level thread function_30a5bc5();
    level thread function_c8950894();
    level thread function_a86c4e88();
    level thread cp_prologue_util::function_40e4b0cf("sm_lift_start_left_side", "sp_lift_start_left_side", "info_lift_start_left_side");
    if (level.activeplayers.size > 1) {
        level thread cp_prologue_util::function_40e4b0cf("sm_lift_start_right_side", "sp_lift_start_right_side", "info_lift_start_right_side");
    } else {
        spawn_manager::kill("sm_lift_start_right_side");
    }
    level thread function_8a1821e("t_left_start_fallback", "info_left_start_fallback", "v_lift_fallback");
    level thread function_8a1821e("t_right_start_fallback", "info_lift_start_right_side", "v_lift_fallback");
    level thread function_8949fadf();
    level thread function_51da5fc6();
    trigger::wait_till("t_lift_reinforcements", undefined, undefined, 0);
    a_spawners = getentarray("sp_stairs_guy_wave2", "targetname");
    foreach (sp_spawner in a_spawners) {
        sp_spawner spawner::spawn();
    }
    level thread cp_prologue_util::function_40e4b0cf("sm_lift_final_attackers", "sp_lift_final_attackers", "v_lift_fallback");
    level thread function_93c4d161();
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x6e6dc19a, Offset: 0x7430
// Size: 0x244
function function_b1017ede() {
    level endon(#"hash_631a1949");
    a_players = getplayers();
    if (a_players.size > 1) {
        return;
    }
    start_time = gettime();
    var_c2798c63 = getent("info_lift_players_camping", "targetname");
    var_a9dae27c = getent("info_lift_area_volume", "targetname");
    while (true) {
        e_player = getplayers()[0];
        time = gettime();
        if (e_player istouching(var_c2798c63)) {
            dt = (time - start_time) / 1000;
            if (dt > 15) {
                var_f2c0d323 = 0;
                a_enemy = cp_prologue_util::function_68b8f4af(var_a9dae27c);
                for (i = 0; i < a_enemy.size; i++) {
                    e_enemy = a_enemy[i];
                    if (!isdefined(e_enemy.var_4383fc69)) {
                        e_enemy.var_4383fc69 = 1;
                        e_enemy.goalradius = -56;
                        e_enemy setgoal(e_player.origin);
                        start_time = time;
                        var_f2c0d323 = 1;
                        break;
                    }
                }
                if (!var_f2c0d323) {
                    return;
                }
            }
        } else {
            start_time = time;
        }
        wait 0.05;
    }
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x47c76b03, Offset: 0x7680
// Size: 0x44
function function_a86c4e88() {
    cp_prologue_util::function_d1f1caad("t_lift_intro_runners");
    wait 10;
    level thread cp_prologue_util::function_a7eac508("sp_lift_intro_rightside_backup", undefined, undefined, undefined);
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0xc7b6544f, Offset: 0x76d0
// Size: 0x27e
function function_eeb1c74e() {
    level flag::wait_till("lift_arrived");
    wait 10;
    var_91737097 = getent("info_lift_area_volume", "targetname");
    var_2320a476 = getent("info_lift_start_area_volume", "targetname");
    while (true) {
        if (isdefined(level.var_1f5f8798) && level.var_1f5f8798) {
            return;
        }
        a_ai = getaiteamarray("axis");
        count = 0;
        for (i = 0; i < a_ai.size; i++) {
            if (a_ai[i] istouching(var_2320a476)) {
                count++;
            }
        }
        if (count <= 2) {
            break;
        }
        wait 0.05;
    }
    a_ai = getaiteamarray("axis");
    a_enemy = [];
    for (i = 0; i < a_ai.size; i++) {
        e_ent = a_ai[i];
        if (e_ent istouching(var_91737097) && !e_ent istouching(var_2320a476)) {
            a_enemy[a_enemy.size] = e_ent;
        }
    }
    count = a_enemy.size;
    if (count > 3) {
        count = 3;
    }
    for (i = 0; i < count; i++) {
        e_ent = a_enemy[i];
        e_ent setgoal(var_2320a476);
    }
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x3d443e64, Offset: 0x7958
// Size: 0x44
function function_30a5bc5() {
    cp_prologue_util::function_d1f1caad("t_lift_intro_runners");
    level thread cp_prologue_util::function_a7eac508("sp_lift_intro_runners", 64, 64, undefined);
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x28f049d6, Offset: 0x79a8
// Size: 0x34
function function_c8950894() {
    cp_prologue_util::function_d1f1caad("t_intro_guys_on_bridge");
    cp_prologue_util::function_73acb160("sp_lift_stairs_intro_guys", undefined);
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0xaad521ef, Offset: 0x79e8
// Size: 0x1d4
function function_b17bd9c5() {
    level.var_2fd26037.script_accuracy = 0.6;
    level.var_4d5a4697.script_accuracy = 0.6;
    level.var_9db406db.script_accuracy = 0.6;
    level thread function_17d64396();
    trigger::use("t_script_color_allies_r920");
    trigger::wait_till("t_script_color_allies_r950");
    level flag::wait_till("crane_in_position");
    if (!level flag::get("crane_dropped")) {
        e_target = util::spawn_model("tag_origin", struct::get("s_destroy_pipes", "targetname").origin);
        e_target.health = 1000;
        level.var_2fd26037 ai::shoot_at_target("normal", e_target, "tag_origin", 3);
        e_target delete();
        t_damage = getent("crane_damage_trigger", "targetname");
        if (isdefined(t_damage)) {
            t_damage useby(level.var_2fd26037);
        }
    }
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x75c614e3, Offset: 0x7bc8
// Size: 0x19c
function function_e97f7dba() {
    spawner::waittill_ai_group_cleared("lift_area");
    level thread namespace_21b2c1f2::function_49fef8f4();
    level thread function_d4734ff1();
    level thread function_6f04ae03();
    level.var_2fd26037 thread function_add8f6bb();
    level.var_9db406db thread function_f92b76b7();
    level.var_4d5a4697 thread function_c3ab179b();
    level flag::wait_till("hendricks_in_lift");
    level flag::wait_till("minister_in_lift");
    level flag::wait_till("khalil_in_lift");
    while (!level scene::is_ready("cin_pro_09_01_intro_1st_cybersoldiers_diaz_attack") || !level scene::is_ready("cin_pro_09_01_intro_1st_cybersoldiers_maretti_attack") || !level scene::is_ready("cin_pro_09_01_intro_1st_cybersoldiers_sarah_attack") || !level scene::is_ready("cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack")) {
        wait 0.05;
    }
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x2d37bfa0, Offset: 0x7d70
// Size: 0x10c
function function_17d64396() {
    cp_prologue_util::function_d1f1caad("entering_lift_fight");
    start_time = gettime();
    while (true) {
        time = gettime();
        dt = (time - start_time) / 1000;
        if (dt > 10) {
            var_f04bd8f5 = cp_prologue_util::function_609c412a("info_lift_start_area_volume", 0);
            if (var_f04bd8f5 <= 2) {
                break;
            }
        }
        wait 0.05;
    }
    e_trigger = getent("t_script_color_allies_r930", "targetname");
    if (isdefined(e_trigger)) {
        trigger::use("t_script_color_allies_r930");
    }
}

// Namespace namespace_e80bc418
// Params 3, eflags: 0x0
// Checksum 0x47bfec4d, Offset: 0x7e88
// Size: 0x156
function function_8a1821e(str_trigger, var_fc9c675e, var_62ec3b42) {
    e_trigger = getent(str_trigger, "targetname");
    if (isdefined(e_trigger)) {
        e_trigger waittill(#"trigger");
    }
    var_cc6832b6 = getent(var_fc9c675e, "targetname");
    var_97e01c0a = getent(var_62ec3b42, "targetname");
    a_ai = getaiteamarray("axis");
    for (i = 0; i < a_ai.size; i++) {
        e_ent = a_ai[i];
        if (e_ent istouching(var_cc6832b6)) {
            e_ent setgoalvolume(var_97e01c0a);
        }
    }
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x9a46799e, Offset: 0x7fe8
// Size: 0x84
function function_d4734ff1() {
    level thread scene::init("cin_pro_09_01_intro_1st_cybersoldiers_diaz_attack");
    level thread scene::init("cin_pro_09_01_intro_1st_cybersoldiers_maretti_attack");
    level thread scene::init("cin_pro_09_01_intro_1st_cybersoldiers_sarah_attack");
    level thread scene::init("cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack");
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x6d7bec2, Offset: 0x8078
// Size: 0x360
function function_a3dbf6a2() {
    trigger::wait_till("t_lift_interior");
    var_d39a9d5b = getent("player_lift_clip", "targetname");
    var_d39a9d5b movez(124, 0.05);
    level.var_5b3ac1ed = 1;
    level scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_elevator_ride", &namespace_dccf27b3::function_679e7da9, "play");
    level thread scene::play("cin_pro_09_01_intro_1st_cybersoldiers_lift_pushbutton");
    level.var_4d5a4697.goalradius = 16;
    level.var_4d5a4697.goalheight = 1600;
    level.var_4d5a4697 setgoal(level.var_4d5a4697.origin);
    level.var_9db406db.goalradius = 16;
    level.var_9db406db.goalheight = 1600;
    level.var_9db406db setgoal(level.var_9db406db.origin);
    level notify(#"hash_3e51db3e");
    level thread function_45ed0d4b(0, 1.5);
    level waittill(#"hash_9e4059e6");
    level.e_lift = getent("freight_lift", "targetname");
    level.e_lift setmovingplatformenabled(1);
    level.e_lift playsound("evt_freight_lift_start");
    level.var_7b90133a = spawn("script_origin", level.e_lift.origin);
    level.var_7b90133a linkto(level.e_lift);
    level.var_7b90133a playloopsound("evt_freight_lift_loop");
    level thread function_4d214c02(1);
    level thread function_e19320a1(1);
    level.e_lift thread scene::play("cin_pro_09_01_intro_1st_cybersoldiers_elevator");
    level.var_3dce3f88 movez(270, 16.3);
    level.var_3dce3f88 thread function_5bd223b0();
    wait 16.3 - 2;
    setdvar("grenadeAllowRigidBodyPhysics", "1");
    level notify(#"hash_b100689e");
    level.var_b100689e = 1;
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0xeabb26e4, Offset: 0x83e0
// Size: 0x12e
function function_5bd223b0() {
    self endon(#"death");
    self waittill(#"movedone");
    t_bottom = getent("t_lift_interior", "targetname");
    a_s_spots = struct::get_array("lift_left_behind", "targetname");
    for (i = 0; i < level.activeplayers.size; i++) {
        player = level.activeplayers[i];
        if (player istouching(t_bottom)) {
            player setorigin(a_s_spots[i].origin);
            player setplayerangles(a_s_spots[i].angles);
        }
    }
}

// Namespace namespace_e80bc418
// Params 1, eflags: 0x0
// Checksum 0xc2815efa, Offset: 0x8518
// Size: 0x164
function function_e19320a1(n_delay) {
    if (!isdefined(n_delay)) {
        n_delay = 0.05;
    }
    wait n_delay;
    exploder::stop_exploder("light_exploder_lift_inside");
    exploder::exploder("light_exploder_lift_rising");
    exploder::exploder("light_exploder_igc_cybersoldier");
    exploder::exploder("fx_exploder_door_open_dust");
    mdl_door_left = getent("hangar_lift_door_left", "targetname");
    mdl_door_right = getent("hangar_lift_door_right", "targetname");
    playsoundatposition("evt_freight_lift_abovedoor", mdl_door_right.origin);
    mdl_door_left movey(104, 5);
    mdl_door_right movey(104 * -1, 5);
}

// Namespace namespace_e80bc418
// Params 1, eflags: 0x0
// Checksum 0xedf71bbf, Offset: 0x8688
// Size: 0x1b0
function function_4d214c02(delay) {
    wait delay;
    while (!(isdefined(level.var_b100689e) && level.var_b100689e)) {
        foreach (player in level.players) {
            player playrumbleonentity("cp_prologue_rumble_lift");
        }
        wait 0.5;
    }
    start_time = gettime();
    while (true) {
        time = gettime();
        dt = (time - start_time) / 1000;
        if (dt > 8) {
            break;
        }
        foreach (player in level.players) {
            player playrumbleonentity("cp_prologue_rumble_lift");
        }
        wait 0.5;
    }
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x44c7de3b, Offset: 0x8840
// Size: 0x2c
function function_17ecef2() {
    self.script_accuracy = 0.5;
    self.overrideactordamage = &function_10ffa58e;
}

// Namespace namespace_e80bc418
// Params 13, eflags: 0x0
// Checksum 0xbf17d8ae, Offset: 0x8878
// Size: 0xb8
function function_10ffa58e(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
    if (self.health - idamage <= 0) {
        if (isdefined(eattacker) && isplayer(eattacker)) {
            eattacker notify(#"hash_38f375b6");
        }
    }
    return idamage;
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x8dd56f83, Offset: 0x8938
// Size: 0xf6
function function_613d7b39() {
    level waittill(#"hash_b100689e");
    wait 2;
    if (isdefined(level.var_90cd4b44)) {
        cp_mi_eth_prologue::function_6a77bdd4(level.var_90cd4b44);
    }
    if (isdefined(level.var_5fbe7226)) {
        cp_mi_eth_prologue::function_6a77bdd4(level.var_5fbe7226);
    }
    level.var_4d5a4697.goalheight = 80;
    level.var_9db406db.goalheight = 80;
    a_ai = getaiteamarray("axis");
    for (i = 0; i < a_ai.size; i++) {
        a_ai[i] delete();
    }
}

// Namespace namespace_e80bc418
// Params 2, eflags: 0x0
// Checksum 0x51272aff, Offset: 0x8a38
// Size: 0xea
function cleanup(var_95c5d6ed, var_5feb916c) {
    spawn_manager::kill(var_95c5d6ed);
    var_db932442 = spawner::get_ai_group_ai(var_5feb916c);
    foreach (var_1bed86d6 in var_db932442) {
        if (isalive(var_1bed86d6)) {
            var_1bed86d6 delete();
        }
    }
}

// Namespace namespace_e80bc418
// Params 1, eflags: 0x0
// Checksum 0x61b88850, Offset: 0x8b30
// Size: 0x8c
function function_9b5132a1(str_s_target) {
    s_target = struct::get(str_s_target, "targetname");
    self.var_5ddefd36 = undefined;
    self.goalradius = -128;
    self setgoalpos(s_target.origin);
    self waittill(#"goal");
    self.var_5ddefd36 = 1;
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x4b1c3849, Offset: 0x8bc8
// Size: 0x8c
function function_add8f6bb() {
    self colors::disable();
    scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_elevator_ride_start_hendricks", &function_3703e000, "play");
    level scene::play("cin_pro_09_01_intro_1st_cybersoldiers_elevator_ride_start_hendricks");
    level flag::set("hendricks_in_lift");
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x2bda4124, Offset: 0x8c60
// Size: 0xbc
function function_c3ab179b() {
    self ai::set_behavior_attribute("vignette_mode", "slow");
    scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_elevator_ride_start_minister", &function_6d36e736, "play");
    level scene::play("cin_pro_09_01_intro_1st_cybersoldiers_elevator_ride_start_minister");
    self setgoal(self.origin, 1);
    level flag::set("minister_in_lift");
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x9764ead7, Offset: 0x8d28
// Size: 0xbc
function function_f92b76b7() {
    self ai::set_behavior_attribute("vignette_mode", "slow");
    scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_elevator_ride_start_khalil", &function_789cecd6, "play");
    level scene::play("cin_pro_09_01_intro_1st_cybersoldiers_elevator_ride_start_khalil");
    self setgoal(self.origin, 1);
    level flag::set("khalil_in_lift");
}

// Namespace namespace_e80bc418
// Params 1, eflags: 0x0
// Checksum 0x73023c63, Offset: 0x8df0
// Size: 0x3c
function function_3703e000(a_ents) {
    level endon(#"hendricks_in_lift");
    wait 6;
    level flag::set("hendricks_in_lift");
}

// Namespace namespace_e80bc418
// Params 1, eflags: 0x0
// Checksum 0x4c79b06e, Offset: 0x8e38
// Size: 0x3c
function function_6d36e736(a_ents) {
    level endon(#"minister_in_lift");
    wait 4;
    level flag::set("minister_in_lift");
}

// Namespace namespace_e80bc418
// Params 1, eflags: 0x0
// Checksum 0x567afc6c, Offset: 0x8e80
// Size: 0x3c
function function_789cecd6(a_ents) {
    level endon(#"khalil_in_lift");
    wait 6.7;
    level flag::set("khalil_in_lift");
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x7469cbd8, Offset: 0x8ec8
// Size: 0x80
function function_8949fadf() {
    e_trigger = getent("t_lift_player_advances", "targetname");
    if (isdefined(e_trigger)) {
        e_trigger waittill(#"trigger");
    }
    level thread cp_prologue_util::function_a7eac508("sp_lift_player_advances", 64, 64, undefined);
    level.var_1f5f8798 = 1;
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0xf19dc9d7, Offset: 0x8f50
// Size: 0x49c
function function_51da5fc6() {
    level.e_lift = getent("freight_lift", "targetname");
    level.var_3dce3f88 = spawn("script_model", level.e_lift.origin);
    level.e_lift linkto(level.var_3dce3f88);
    level.e_lift setmovingplatformenabled(1);
    level.e_lift thread function_f2f20b35();
    exploder::exploder("light_exploder_lift_inside");
    function_dfbe3c61();
    a_spawners = getentarray("sp_lift_reinforcements", "targetname");
    for (i = 0; i < a_spawners.size; i++) {
        a_spawners[i] spawner::add_spawn_function(&function_38a8e28b);
        a_spawners[i] spawner::spawn();
    }
    v_down = (0, 0, -1);
    dist = 354;
    move_time = 5;
    var_519d9482 = level.e_lift.origin + v_down * dist;
    level.var_3dce3f88 moveto(var_519d9482, move_time);
    level.e_lift = getent("freight_lift", "targetname");
    level.e_lift playsound("evt_freight_lift_start");
    var_7b90133a = spawn("script_origin", level.e_lift.origin);
    var_7b90133a linkto(level.e_lift);
    var_7b90133a playloopsound("evt_freight_lift_loop");
    level.var_3dce3f88 waittill(#"movedone");
    level.var_3dce3f88 scene::init("cin_pro_08_01_liftescape_vign_lift_doorsopen", level.e_lift);
    var_7b90133a stoploopsound(0.1);
    setdvar("grenadeAllowRigidBodyPhysics", "0");
    open_time = 1.5;
    level thread function_45ed0d4b(1, open_time);
    wait open_time + 0.1;
    var_950ed8c6 = getnode("n_lift_entrance_begin3", "targetname");
    linktraversal(var_950ed8c6);
    level flag::set("lift_arrived");
    a_nodes = getnodearray("nd_exit_lift", "targetname");
    a_ai = getentarray("sp_lift_reinforcements_ai", "targetname");
    for (i = 0; i < a_ai.size; i++) {
        a_ai[i] thread function_c6db42e4(a_nodes[i]);
    }
    wait 1;
    level.var_2fd26037 dialog::say("hend_spotted_more_reinfor_0");
}

// Namespace namespace_e80bc418
// Params 1, eflags: 0x0
// Checksum 0x910488e1, Offset: 0x93f8
// Size: 0x74
function function_c6db42e4(nd_node) {
    self endon(#"death");
    self util::stop_magic_bullet_shield();
    self.goalradius = 64;
    self setgoal(nd_node.origin);
    self waittill(#"goal");
    self.goalradius = 1024;
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x5f5b4038, Offset: 0x9478
// Size: 0x34
function function_38a8e28b() {
    self.goalradius = 64;
    self.var_37b94263 = 1;
    self util::magic_bullet_shield();
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0xffc41143, Offset: 0x94b8
// Size: 0x226
function function_93c4d161() {
    e_volume = getent("info_lift_start_area_volume", "targetname");
    while (true) {
        var_b9c84787 = getaiteamarray("axis");
        if (var_b9c84787.size < 5) {
            a_enemy = cp_prologue_util::function_68b8f4af(e_volume);
            if (a_enemy.size < 3) {
                break;
            }
        }
        wait 0.05;
    }
    var_d6bb42cf = getent("v_lift_fallback", "targetname");
    for (i = 0; i < a_enemy.size; i++) {
        var_f4b1d057 = a_enemy[i];
        var_f4b1d057 setgoal(var_d6bb42cf);
    }
    var_d6bb42cf = getent("info_lift_area_volume", "targetname");
    while (true) {
        a_enemy = cp_prologue_util::function_68b8f4af(e_volume);
        if (a_enemy.size <= 1) {
            break;
        }
        wait 0.05;
    }
    for (i = 0; i < a_enemy.size; i++) {
        e_player = getplayers()[0];
        e_enemy = a_enemy[i];
        e_enemy.goalradius = -56;
        e_enemy setgoal(e_player);
    }
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x7b084ec6, Offset: 0x96e8
// Size: 0x106
function function_dfbe3c61() {
    cp_prologue_util::function_d1f1caad("entering_lift_fight");
    start_time = gettime();
    while (true) {
        time = gettime();
        dt = (time - start_time) / 1000;
        if (dt > 20) {
            e_trigger = getent("t_lift_reinforcements", "targetname");
            if (!isdefined(e_trigger)) {
                break;
            }
            var_f04bd8f5 = cp_prologue_util::function_609c412a("info_lift_area_volume", 0);
            if (var_f04bd8f5 < 3) {
                break;
            }
        }
        wait 0.05;
    }
    level notify(#"hash_631a1949");
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x5fafe553, Offset: 0x97f8
// Size: 0x304
function function_f2f20b35() {
    probe_lift = getent("probe_lift", "targetname");
    probe_lift linkto(self);
    light_lift = getent("light_lift", "targetname");
    light_lift linkto(self);
    var_51875481 = getentarray("light_lift_02", "targetname");
    foreach (light in var_51875481) {
        light linkto(self);
    }
    var_51875481 = getentarray("light_lift_03", "targetname");
    foreach (light in var_51875481) {
        light linkto(self);
    }
    var_51875481 = getentarray("light_lift_panel_anim01", "targetname");
    foreach (light in var_51875481) {
        light linkto(self);
    }
    light_lift = getent("light_lift_panel_anim02", "targetname");
    light_lift linkto(self);
    level waittill(#"hash_a1a67fd8");
    exploder::exploder("light_lift_panel_green");
}

// Namespace namespace_e80bc418
// Params 2, eflags: 0x0
// Checksum 0x79cf6136, Offset: 0x9b08
// Size: 0x31c
function function_45ed0d4b(open_door, move_time) {
    var_507d66a5 = getent("lift_door_top", "targetname");
    var_3d3eb4dd = getent("lift_door_bottom", "targetname");
    v_up = (0, 0, 1);
    move_amount = 100;
    if (open_door) {
        if (level.var_1dd14818 == 1) {
            return;
        }
        v_dest = var_507d66a5.origin + v_up * move_amount;
        var_507d66a5 moveto(v_dest, move_time);
        v_dest = var_3d3eb4dd.origin + v_up * move_amount * -1;
        var_3d3eb4dd moveto(v_dest, move_time);
        level.var_1dd14818 = 1;
    } else {
        if (level.var_1dd14818 == 0) {
            return;
        }
        v_dest = var_507d66a5.origin + v_up * move_amount * -1;
        var_507d66a5 moveto(v_dest, move_time);
        v_dest = var_3d3eb4dd.origin + v_up * move_amount;
        var_3d3eb4dd moveto(v_dest, move_time);
        level.var_1dd14818 = 0;
    }
    var_3d3eb4dd playsound("evt_freight_elev_door_start");
    var_cc8ae729 = spawn("script_origin", var_3d3eb4dd.origin);
    var_cc8ae729 linkto(var_3d3eb4dd);
    var_cc8ae729 playloopsound("evt_freight_elev_door_loop");
    wait move_time;
    var_3d3eb4dd playsound("evt_freight_elev_door_stop");
    var_cc8ae729 stoploopsound(0.1);
    if (open_door) {
        level.var_3dce3f88 scene::play("cin_pro_08_01_liftescape_vign_lift_doorsopen", level.e_lift);
        return;
    }
    level.var_3dce3f88 scene::play("cin_pro_08_01_liftescape_vign_lift_doorsclose", level.e_lift);
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x8bc0c0c6, Offset: 0x9e30
// Size: 0x36c
function function_5517d018() {
    e_trigger = getent("crane_damage_trigger", "targetname");
    e_trigger triggerenable(0);
    cp_prologue_util::function_d1f1caad("t_intro_guys_on_bridge");
    level thread scene::play("p7_fxanim_cp_prologue_ceiling_underground_crane_bundle", "scriptbundlename");
    level waittill(#"crane_in_position");
    level flag::set("crane_in_position");
    e_trigger triggerenable(1);
    e_trigger waittill(#"trigger", e_who);
    e_trigger delete();
    level thread scene::play("p7_fxanim_cp_prologue_ceiling_underground_crane_shot_bundle");
    level waittill(#"hash_1cda5581");
    level flag::set("crane_dropped");
    a_ai = getaiteamarray("axis");
    e_volume = getent("info_crane_drop", "targetname");
    for (i = 0; i < a_ai.size; i++) {
        if (isalive(a_ai[i]) && a_ai[i] istouching(e_volume)) {
            a_ai[i] kill();
            if (isplayer(e_who)) {
                namespace_61c634f2::function_d248b92b(e_who);
            }
        }
    }
    foreach (player in level.players) {
        if (player istouching(e_volume)) {
            player dodamage(500, e_volume.origin);
        }
    }
    e_volume delete();
    e_coll = getent("lifttunnel_pipecollision", "targetname");
    e_coll movez(-80, 0.05);
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0x1e70b52c, Offset: 0xa1a8
// Size: 0xb4
function function_6fabe3da() {
    trigger::wait_till("entering_lift_fight");
    level.var_2fd26037 dialog::say("hend_that_s_our_exit_car_0");
    cp_prologue_util::function_520255e3("t_lift_reinforcements", 60);
    level.var_2fd26037 dialog::say("hend_elevator_s_right_the_0");
    level waittill(#"hash_3e51db3e");
    level thread namespace_21b2c1f2::function_9f50ebc2();
    level thread namespace_21b2c1f2::function_c4c71c7();
}

// Namespace namespace_e80bc418
// Params 0, eflags: 0x0
// Checksum 0xf2aff467, Offset: 0xa268
// Size: 0x54
function function_6f04ae03() {
    level endon(#"hash_3e51db3e");
    level.var_2fd26037 dialog::say("hend_let_s_move_get_to_t_0");
    wait 15;
    level.var_2fd26037 dialog::say("hend_keep_pushing_forward_0");
}

