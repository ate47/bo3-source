#using scripts/cp/cp_mi_sing_sgen_util;
#using scripts/cp/cp_mi_sing_sgen_sound;
#using scripts/cp/cp_mi_sing_sgen_accolades;
#using scripts/cp/cp_mi_sing_sgen;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_hazard;
#using scripts/cp/_dialog;
#using scripts/codescripts/struct;

#namespace cp_mi_sing_sgen_silo_swim;

// Namespace cp_mi_sing_sgen_silo_swim
// Params 2, eflags: 0x0
// Checksum 0x4eb1fdc7, Offset: 0xdb8
// Size: 0x23a
function function_d64c7d65(var_468a2e2f, var_74cd64bc) {
    if (var_74cd64bc) {
        level clientfield::set("w_underwater_state", 1);
        spawner::add_global_spawn_function("axis", &namespace_cba4cc55::function_a527e6f9);
        objectives::complete("cp_level_sgen_enter_sgen_no_pointer");
        objectives::complete("cp_level_sgen_investigate_sgen");
        objectives::complete("cp_level_sgen_locate_emf");
        objectives::complete("cp_level_sgen_descend_into_core");
        objectives::complete("cp_level_sgen_goto_signal_source");
        objectives::complete("cp_level_sgen_goto_server_room");
        objectives::complete("cp_level_sgen_confront_pallas");
        objectives::set("cp_level_sgen_get_to_surface");
        load::function_a2995f22();
        foreach (player in level.players) {
            player clientfield::set_to_player("water_motes", 1);
            player thread hazard::function_e9b126ef(15, 0.25);
        }
    }
    level.var_2fd26037 = util::function_740f8516("hendricks");
    level.var_2fd26037 colors::set_force_color("r");
    setdvar("player_swimTime", 5000);
    level thread main();
    namespace_99202726::function_f3915502();
    exploder::exploder("lights_sgen_swimup");
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 4, eflags: 0x0
// Checksum 0x5702911a, Offset: 0x1000
// Size: 0x3a
function function_9670e43f(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    objectives::complete("cp_level_sgen_get_to_surface");
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x24f840a9, Offset: 0x1048
// Size: 0xea
function main() {
    level thread function_454f17f5();
    level thread function_adfc879d();
    level thread function_5faf4875();
    level thread function_931453ff();
    level thread function_e5892d8b();
    level thread function_ed258e83();
    level thread function_141e6fb1();
    level thread function_4479a58d();
    level thread sgen_end_igc();
    level thread function_13a4841b();
    level thread function_732b54da();
    level thread function_78227c49();
    level flag::wait_till("player_in_fan_vent");
    level thread function_1b1cd649();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x9e2a17ad, Offset: 0x1140
// Size: 0x1a
function function_141e6fb1() {
    objectives::breadcrumb("silo_swim_breadcrumb");
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0xcb62f6d2, Offset: 0x1168
// Size: 0x73
function function_732b54da() {
    wait 3;
    foreach (player in level.activeplayers) {
        player util::show_hint_text(%COOP_SWIM_INSTRUCTIONS, 0, undefined, 2);
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0xeec206a9, Offset: 0x11e8
// Size: 0x95
function function_adfc879d() {
    var_26e0d148 = (0, 30, 0);
    var_339ee53e = getent("trig_water_flow", "targetname");
    while (true) {
        e_player = var_339ee53e waittill(#"trigger");
        v_velocity = e_player getvelocity();
        v_velocity += var_26e0d148;
        e_player setvelocity(v_velocity);
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0xd420bca9, Offset: 0x1288
// Size: 0x152
function function_4479a58d() {
    level endon(#"silo_complete");
    level thread function_72e5fd1f();
    level flag::set("important_vo_playing");
    level.var_2fd26037 dialog::say("hend_alright_stay_on_my_0");
    level dialog::remote("kane_heads_up_spotted_a_0", 0.5);
    level.var_2fd26037 dialog::say("hend_take_out_those_charg_0", 0.7);
    level flag::clear("important_vo_playing");
    level flag::wait_till("silo_swim_bridge_collapse");
    level flag::set("important_vo_playing");
    level.var_2fd26037 dialog::say("hend_bridge_coming_down_0");
    level dialog::remote("kane_hang_on_something_s_0", 1);
    level dialog::remote("kane_futz_we_hav_0", 0.5);
    level flag::clear("important_vo_playing");
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0xa544f606, Offset: 0x13e8
// Size: 0x163
function function_72e5fd1f() {
    var_c2758464 = 0.2;
    var_eb553ac9 = 0;
    while (!level flag::get("silo_complete")) {
        if (level.activeplayers.size == 0) {
            return;
        }
        n_fraction = level.activeplayers[0] hazard::function_b78a859e("o2");
        if (n_fraction > var_c2758464) {
            if (!level flag::get("important_vo_playing")) {
                switch (var_eb553ac9) {
                case 0:
                    level.var_2fd26037 dialog::say("hend_we_gotta_get_up_ther_0");
                    break;
                case 1:
                    level.var_2fd26037 dialog::say("hend_your_o2_levels_are_d_0");
                    break;
                case 2:
                    level.var_2fd26037 dialog::say("hend_your_o2_level_s_crit_0");
                    break;
                case 3:
                    level.var_2fd26037 dialog::say("hend_go_go_go_1");
                    break;
                }
            }
            var_eb553ac9++;
            var_c2758464 += 0.2;
        }
        wait 1;
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x59d88740, Offset: 0x1558
// Size: 0xea
function function_e5892d8b() {
    array::thread_all(getentarray("drowning_trigger", "targetname"), &function_48cb67f6);
    level flag::wait_till_any(array("ai_drowning", "hendricks_move_up_5"));
    util::delay(randomfloatrange(0.5, 1), undefined, &scene::play, "cin_sgen_25_02_siloswim_vign_windowbang_54i02_drowning");
    util::delay(randomfloatrange(2, 3), undefined, &scene::play, "cin_sgen_25_02_siloswim_vign_windowbang_54i03_drowning");
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x3921d019, Offset: 0x1650
// Size: 0x15a
function function_5faf4875() {
    level.var_ebb3767b = getent("silo_swim_safe_area", "targetname");
    var_94dd2adf = struct::get_array("static_depth_charge", "targetname");
    foreach (var_cb85ae7c in var_94dd2adf) {
        var_cb85ae7c thread function_da28fd56();
        util::wait_network_frame();
    }
    var_15c854f8 = vehicle::simple_spawn_single("depth_charge_carrier");
    var_15c854f8 util::magic_bullet_shield();
    var_15c854f8 sethoverparams(10, 10, 10);
    var_15c854f8 thread function_267dcc4e();
    level flag::wait_till("silo_complete");
    wait 3;
    var_15c854f8 util::stop_magic_bullet_shield();
    var_15c854f8 util::self_delete();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x29de62ce, Offset: 0x17b8
// Size: 0x1fa
function function_931453ff() {
    level endon(#"silo_complete");
    var_c568c095 = getent("hendricks_kill_bot", "script_noteworthy");
    var_c568c095 spawner::add_spawn_function(&function_9d7c6fb3);
    spawn_manager::enable("sm_under_silo_swim_robots");
    trigger::wait_till("silo_hendricks_start_trigger", undefined, undefined, 0);
    level scene::play("cin_sgen_25_01_siloswim_vign_coverswim_hendricks_1st_point");
    var_64e85e6d = getaispeciesarray("axis", "robot");
    array::wait_till(var_64e85e6d, "death");
    if (!flag::get("hendricks_move_to_under_fan")) {
        level thread scene::play("cin_sgen_25_01_siloswim_vign_coverswim_hendricks_1st_point_wait");
        level flag::wait_till("hendricks_move_to_under_fan");
    }
    level scene::play("cin_sgen_25_01_siloswim_vign_coverswim_hendricks_shaft");
    level flag::wait_till("player_in_fan_vent");
    level scene::play("cin_sgen_25_01_siloswim_vign_coverswim_hendricks_thru_shaft");
    level thread scene::play("cin_sgen_25_01_siloswim_vign_coverswim_hendricks_upper_tunnel");
    level flag::wait_till("hendricks_move_up_4");
    level scene::play("cin_sgen_25_01_siloswim_vign_coverswim_hendricks_balconies");
    level flag::wait_till("hendricks_move_up_5");
    level scene::play("cin_sgen_25_01_siloswim_vign_coverswim_hendricks_rocks");
    level scene::play("cin_sgen_25_01_siloswim_vign_coverswim_hendricks_surface");
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x40f37525, Offset: 0x19c0
// Size: 0x42
function function_9d7c6fb3() {
    self endon(#"death");
    self settargetentity(level.var_2fd26037);
    level.var_2fd26037 waittill(#"hash_f4673288");
    self kill();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x40e35457, Offset: 0x1a10
// Size: 0xc9
function function_267dcc4e() {
    level endon(#"silo_complete");
    var_fe6e315e = struct::get_array("moving_depth_charge", "targetname");
    var_fe6e315e = array::get_all_closest(self.origin, var_fe6e315e);
    var_afd8b3ef = 0;
    n_delay = 1 - (level.players.size - 1) * 0.17;
    while (true) {
        var_afd8b3ef = var_afd8b3ef < var_fe6e315e.size ? var_afd8b3ef + 1 : 0;
        if (isdefined(var_fe6e315e[var_afd8b3ef])) {
            self thread function_26a0a902("script_model", var_fe6e315e[var_afd8b3ef]);
        }
        wait n_delay;
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x1f561331, Offset: 0x1ae8
// Size: 0x26
function function_da28fd56() {
    var_2d4569cf = self function_26a0a902("script_model", undefined);
    return var_2d4569cf;
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 3, eflags: 0x0
// Checksum 0xe0d5ea5c, Offset: 0x1b18
// Size: 0x19c
function function_26a0a902(str_type, s_start, var_253d1f97) {
    if (!isdefined(str_type)) {
        str_type = "script_model";
    }
    if (!isdefined(var_253d1f97)) {
        var_253d1f97 = 0;
    }
    self endon(#"death");
    if (level flag::get("silo_complete")) {
        return;
    }
    if (!isdefined(self)) {
        return;
    }
    var_2d4569cf = undefined;
    if (str_type === "script_model") {
        var_2d4569cf = self function_dabb79d8();
        if (isdefined(s_start)) {
            var_2d4569cf.targetname = "depth_charger_dive";
            var_2d4569cf thread function_c51242e1(s_start, var_253d1f97);
        } else {
            var_2d4569cf.targetname = "depth_charger_static";
            var_2d4569cf thread util::delay(randomfloatrange(0.5, 5), undefined, &function_607790f9, 5, 8, 18);
        }
        if (!var_253d1f97) {
            var_2d4569cf thread function_c775e8da(400);
        }
    } else {
        var_2d4569cf = self function_f51a7ebb();
        var_2d4569cf.origin = self.origin;
        var_2d4569cf.angles = self.angles;
        var_2d4569cf thread function_66b2e4a2();
        var_2d4569cf thread function_c51242e1(s_start, var_253d1f97);
        if (self.classname === "script_model") {
            self util::self_delete();
        }
    }
    return var_2d4569cf;
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 1, eflags: 0x0
// Checksum 0xfbceeec2, Offset: 0x1cc0
// Size: 0x9c
function function_f51a7ebb(v_origin) {
    var_25e2c218 = undefined;
    while (!isdefined(var_25e2c218)) {
        var_25e2c218 = vehicle::simple_spawn_single("depth_charge_spawner", 1);
        util::wait_network_frame();
    }
    var_25e2c218 thread function_d2d42898();
    var_25e2c218 setneargoalnotifydist(105 / 2);
    var_25e2c218 oed::enable_thermal();
    var_25e2c218 clientfield::set("sm_depth_charge_fx", 2);
    return var_25e2c218;
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0xc9a50750, Offset: 0x1d68
// Size: 0xdc
function function_dabb79d8() {
    var_5a16524f = util::spawn_model("veh_t7_drone_depth_charge", self.origin, (randomint(360), randomint(360), randomint(360)));
    if (isdefined(var_5a16524f)) {
        var_5a16524f.script_noteworthy = "depth_charge_model";
        var_5a16524f setcandamage(1);
        var_5a16524f.health = 999999;
        var_5a16524f clientfield::set("sm_depth_charge_fx", 1);
        var_5a16524f enableaimassist();
        var_5a16524f thread function_9e34c3b5();
        var_5a16524f oed::enable_thermal();
    }
    return var_5a16524f;
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 2, eflags: 0x0
// Checksum 0x554e596a, Offset: 0x1e50
// Size: 0x2aa
function function_c51242e1(s_target, var_253d1f97) {
    self endon(#"death");
    self endon(#"hash_75409bb6");
    if (!isvehicle(self)) {
        if (isdefined(var_253d1f97) && var_253d1f97) {
            self thread function_46012050();
        }
    } else if (!isdefined(s_target)) {
        s_target = isdefined(self.var_ab9199df) ? self.var_ab9199df : array::random(level.players);
    }
    if (isvehicle(self)) {
        n_fuse_time = gettime() + 3000;
    }
    while (isdefined(s_target)) {
        n_distance = distance(self.origin, s_target.origin);
        n_time = n_distance / -56;
        if (isvehicle(self)) {
            if (self istouching(level.var_ebb3767b) || gettime() >= n_fuse_time) {
                break;
            }
            if (isplayer(s_target)) {
                self setvehgoalpos(self getclosestpointonnavvolume(s_target geteye(), 512), 1, 1);
            } else {
                self setvehgoalpos(s_target.origin, 1, 1);
            }
            wait 0.5;
            if (distancesquared(self.origin, s_target.origin) <= 30625) {
                break;
            }
        } else if (n_time) {
            self moveto(s_target.origin, n_time);
            self waittill(#"movedone");
        }
        if (isvehicle(self)) {
            if (!isplayer(s_target) && (!isdefined(s_target) || !(isdefined(var_253d1f97) && var_253d1f97))) {
                s_target = isdefined(self.var_ab9199df) ? self.var_ab9199df : array::random(level.players);
            }
            continue;
        }
        s_target = isdefined(s_target.target) ? struct::get(s_target.target, "targetname") : undefined;
    }
    self thread function_6493f00e();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x3366ea59, Offset: 0x2108
// Size: 0x7a
function function_9e34c3b5() {
    self endon(#"death");
    damage, e_attacker = self waittill(#"damage");
    if (isplayer(e_attacker)) {
        namespace_99202726::function_e85e2afd(e_attacker);
    }
    self thread function_6493f00e(isdefined(e_attacker) && isplayer(e_attacker));
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x5815ab5a, Offset: 0x2190
// Size: 0x19a
function function_46012050() {
    self endon(#"death");
    self endon(#"hash_75409bb6");
    var_c4ebe9e7 = -10000;
    n_start_time = gettime();
    while (true) {
        foreach (player in level.activeplayers) {
            if (player.origin[2] > var_c4ebe9e7) {
                var_c4ebe9e7 = player.origin[2];
            }
        }
        if (self.origin[2] <= var_c4ebe9e7 + 512) {
            break;
        }
        wait 1;
    }
    var_90462d11 = var_c4ebe9e7;
    foreach (player in level.activeplayers) {
        if (player.origin[2] < var_90462d11) {
            var_90462d11 = player.origin[2];
        }
    }
    n_distance = self.origin[2] - var_90462d11 - -128;
    n_time = n_distance / -56;
    if (n_time > 0) {
        wait randomfloat(n_time);
    }
    self thread function_6493f00e();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 1, eflags: 0x0
// Checksum 0xa1c5b158, Offset: 0x2338
// Size: 0x111
function function_c775e8da(var_7a998a01) {
    if (!isdefined(var_7a998a01)) {
        var_7a998a01 = 400;
    }
    level endon(#"silo_complete");
    self endon(#"hash_75409bb6");
    self endon(#"death");
    self thread function_207a5a6f();
    while (true) {
        foreach (player in level.players) {
            if (!player istouching(level.var_ebb3767b) && !player isinmovemode("ufo", "noclip")) {
                if (distancesquared(player.origin, self.origin) < var_7a998a01 * var_7a998a01) {
                    self.var_ab9199df = player;
                    self notify(#"hash_75409bb6");
                }
            }
        }
        wait 0.1;
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x98b16683, Offset: 0x2458
// Size: 0x8a
function function_207a5a6f() {
    self endon(#"death");
    self waittill(#"hash_75409bb6");
    self playsound("veh_depth_charge_locked");
    self playloopsound("veh_depth_charge_chase", 0.5);
    if (!level flag::get("silo_complete")) {
        self thread function_26a0a902("script_vehicle");
        return;
    }
    self thread function_6493f00e();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 1, eflags: 0x0
// Checksum 0x191485d2, Offset: 0x24f0
// Size: 0x20b
function function_6493f00e(var_e0c598de) {
    if (!isdefined(var_e0c598de)) {
        var_e0c598de = 0;
    }
    if (!isdefined(self)) {
        return;
    }
    v_origin = self.origin;
    radiusdamage(v_origin, -81, 50, 15, self);
    playrumbleonposition("grenade_rumble", v_origin);
    earthquake(0.5, 0.5, v_origin, -106);
    if (self.classname === "script_model") {
        playfx(level._effect["depth_charge_explosion"], v_origin);
        playsoundatposition("exp_drone_underwater", v_origin);
        self util::self_delete();
    } else {
        self dodamage(self.health + 1000, self.origin, undefined, self, "none", "MOD_EXPLOSIVE");
    }
    wait 0.1;
    if (isdefined(var_e0c598de) && var_e0c598de) {
        var_f83c5536 = arraycombine(getentarray("depth_charge_model", "script_noteworthy"), getentarray("dept_charge_spawner_vh", "targetname"), 0, 0);
        var_f83c5536 = arraysortclosest(var_f83c5536, v_origin, 5, 0, 105);
        foreach (var_2d4569cf in var_f83c5536) {
            if (isdefined(var_2d4569cf)) {
                var_2d4569cf thread function_6493f00e();
                util::wait_network_frame();
            }
        }
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x117c8786, Offset: 0x2708
// Size: 0x1ca
function function_78227c49() {
    hidemiscmodels("silo_bridge_collapse_static");
    level scene::init("bridge_collapse", "targetname");
    level flag::wait_till("player_in_fan_vent");
    scene::add_scene_func("p7_fxanim_cp_sgen_bridge_silo_collapse_bundle", &function_38bb8243, "play");
    a_s_targets = struct::get_array("bridge_collapse_dp_target", "targetname");
    foreach (s_target in a_s_targets) {
        playfx(level._effect["depth_charge_explosion"], s_target.origin);
        playsoundatposition("exp_drone_underwater", s_target.origin);
        wait 0.1 + randomint(3) * 0.1;
    }
    level flag::wait_till("silo_swim_take_out");
    level flag::set("silo_swim_bridge_collapse");
    level scene::play("bridge_collapse", "targetname");
    showmiscmodels("silo_bridge_collapse_static");
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 1, eflags: 0x0
// Checksum 0x577b60ec, Offset: 0x28e0
// Size: 0x1ba
function function_38bb8243(a_ents) {
    var_edef565e = getent("bridge_side1", "targetname");
    var_edef565e enablelinkto();
    var_edef565e linkto(a_ents["bridge_silo_collapse"], "bridge_main_fall_01_jnt");
    var_c7ecdbf5 = getent("bridge_side2", "targetname");
    var_c7ecdbf5 enablelinkto();
    var_c7ecdbf5 linkto(a_ents["bridge_silo_collapse"], "bridge_main_fall_02_jnt");
    while (level scene::is_playing("p7_fxanim_cp_sgen_bridge_silo_collapse_bundle")) {
        var_5d11d4ef = getentarray("depth_charger_static", "targetname");
        foreach (var_2d4569cf in var_5d11d4ef) {
            if (var_2d4569cf istouching(var_edef565e) || var_2d4569cf istouching(var_c7ecdbf5)) {
                var_2d4569cf thread function_6493f00e();
            }
        }
        wait 0.05;
    }
    var_edef565e delete();
    var_c7ecdbf5 delete();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x1781fd71, Offset: 0x2aa8
// Size: 0x19a
function function_1b1cd649() {
    s_start = struct::get("rock_suicide_drone");
    var_5a16524f = s_start function_da28fd56();
    level flag::wait_till("hendricks_move_up_4");
    t_damage = getent("rock_slide_trigger", "targetname");
    t_damage triggerenable(0);
    a_ai_bots = spawner::simple_spawn("rock_fall_bots");
    foreach (ai_bot in a_ai_bots) {
        ai_bot.maxsightdist = 562500;
        ai_bot.script_accuracy = 0.5;
    }
    trigger::wait_till("trig_rock_slide");
    if (isdefined(var_5a16524f)) {
        var_5a16524f thread function_6493f00e();
        level thread scene::play("p7_fxanim_cp_sgen_boulder_silo_depth_charge_bundle");
        level waittill(#"hash_fbf5202b");
        t_damage triggerenable(1);
        level waittill(#"hash_562dd11c");
        t_damage delete();
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0xcffe43ca, Offset: 0x2c50
// Size: 0x152
function function_13a4841b() {
    level flag::set("silo_swim_take_out");
    level thread namespace_d40478f6::function_5d6d7c60();
    var_493378a9 = struct::get_array("under_silo_depth_charge", "targetname");
    var_8c2654e3 = [];
    for (i = 0; i < var_493378a9.size; i++) {
        var_456985ba = 0;
        if (var_493378a9[i].script_noteworthy === "ignore_player") {
            var_456985ba = 1;
        }
        var_8c2654e3[i] = var_493378a9[i] function_26a0a902("script_model", undefined, var_456985ba);
        if (isdefined(var_493378a9[i].target)) {
            s_target = struct::get(var_493378a9[i].target, "targetname");
            var_8c2654e3[i] thread function_dd461d67(s_target);
        }
        wait 0.3;
    }
    array::wait_till(var_8c2654e3, "death");
    level flag::set("hendricks_move_to_under_fan");
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 1, eflags: 0x0
// Checksum 0xcdc4f831, Offset: 0x2db0
// Size: 0x172
function function_dd461d67(s_target) {
    self endon(#"death");
    trigger::wait_till("depth_charge_swarm_trigger");
    n_distance = distance(self.origin, s_target.origin);
    n_time = n_distance / -56;
    self notify(#"hash_34674350");
    self moveto(s_target.origin, n_time);
    self waittill(#"movedone");
    if (s_target.script_noteworthy === "detonate") {
        var_c1470355 = getaiteamarray("axis");
        foreach (ai in var_c1470355) {
            if (isalive(ai) && distance(ai.origin, self.origin) < 400) {
                ai kill();
            }
        }
        self thread function_6493f00e();
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 2, eflags: 0x0
// Checksum 0x70672be2, Offset: 0x2f30
// Size: 0x55
function function_7cf2db52(var_aa2d33b, n_alpha) {
    if (!isdefined(var_aa2d33b)) {
        var_aa2d33b = 0.6;
    }
    if (!isdefined(n_alpha)) {
        n_alpha = 1;
    }
    level lui::screen_fade(var_aa2d33b, n_alpha, 0, "black", 0);
    wait var_aa2d33b;
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 2, eflags: 0x0
// Checksum 0x1251f624, Offset: 0x2f90
// Size: 0x55
function function_1e6ee4b9(var_4b1adf24, n_alpha) {
    if (!isdefined(var_4b1adf24)) {
        var_4b1adf24 = 0.4;
    }
    if (!isdefined(n_alpha)) {
        n_alpha = 1;
    }
    level lui::screen_fade(var_4b1adf24, 0, n_alpha, "black", 1);
    wait var_4b1adf24;
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x8840700d, Offset: 0x2ff0
// Size: 0x24b
function sgen_end_igc() {
    flag::wait_till("silo_complete");
    objectives::complete("cp_level_sgen_get_to_surface");
    namespace_99202726::function_fde8c3ce();
    array::thread_all(level.players, &function_55b80798);
    level function_7cf2db52();
    array::thread_all(getaiteamarray("axis"), &util::self_delete);
    level util::function_d8eaed3d(5);
    level thread function_ff4696f8();
    level thread namespace_d40478f6::function_973b77f9();
    level util::clientnotify("tuwco");
    wait 2;
    if (isdefined(level.var_649f9c84)) {
        level thread [[ level.var_649f9c84 ]]();
    }
    level thread function_1e6ee4b9();
    level util::delay("fade_out_grab", undefined, &function_7cf2db52);
    scene::add_scene_func("cin_sgen_26_01_lobbyexit_1st_escape_grab", &function_bd2c7078, "done");
    level thread scene::play("cin_sgen_26_01_lobbyexit_1st_escape_grab");
    level waittill(#"fade_out_grab");
    if (!scene::function_b1f75ee9()) {
        util::screen_fade_out(0.6);
    } else {
        util::screen_fade_out(0);
    }
    level waittill(#"hash_bffd177e");
    foreach (player in level.activeplayers) {
        player disableusability();
        player disableoffhandweapons();
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 1, eflags: 0x0
// Checksum 0x2c369054, Offset: 0x3248
// Size: 0x82
function function_bd2c7078(a_ents) {
    level thread function_1e6ee4b9();
    level util::delay("final_fade_out", undefined, &function_88c4a050);
    level thread namespace_d40478f6::play_outro();
    level thread audio::unlockfrontendmusic("mus_sgen_diaz_theme_intro");
    level thread scene::play("p7_fxanim_cp_sgen_end_building_collapse_debris_bundle");
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x4890b1dc, Offset: 0x32d8
// Size: 0x72
function function_55b80798() {
    self enableinvulnerability();
    self playrumbleonentity("damage_heavy");
    self clientfield::set_to_player("water_motes", 0);
    self hazard::function_60455f28("o2");
    self hazard::function_12231466("o2");
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x77627fda, Offset: 0x3358
// Size: 0x32
function function_ff4696f8() {
    exploder::kill_exploder("lights_sgen_swimup");
    exploder::exploder("lights_sgen_afterswim");
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 1, eflags: 0x0
// Checksum 0x32754f51, Offset: 0x3398
// Size: 0x4a
function function_88c4a050(a_ents) {
    level util::screen_fade_out(0.6);
    util::clear_streamer_hint();
    skipto::function_be8adfb8("silo_swim");
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0xdb614da6, Offset: 0x33f0
// Size: 0x4a
function function_d2d42898() {
    level endon(#"silo_complete");
    self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    self ghost();
    wait 1;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x51676ddb, Offset: 0x3448
// Size: 0x32
function function_66b2e4a2() {
    self endon(#"death");
    level flag::wait_till("silo_complete");
    self delete();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x57da9ce2, Offset: 0x3488
// Size: 0x142
function function_ed258e83() {
    level thread function_a025b41e();
    trigger::wait_till("start_silo_fx_debris");
    level clientfield::set("silo_debris", 1);
    util::wait_network_frame();
    trigger::wait_till("silo_debris");
    level clientfield::set("silo_debris", 2);
    util::wait_network_frame();
    level flag::wait_till("hendricks_move_up_4");
    level clientfield::set("silo_debris", 3);
    util::wait_network_frame();
    level flag::wait_till("hendricks_move_up_5");
    level clientfield::set("silo_debris", 4);
    util::wait_network_frame();
    level flag::wait_till("silo_complete");
    level clientfield::set("silo_debris", 6);
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x19658b5b, Offset: 0x35d8
// Size: 0x42
function function_a025b41e() {
    level flag::wait_till("ai_drowning");
    level clientfield::set("silo_debris", 5);
    util::wait_network_frame();
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 3, eflags: 0x0
// Checksum 0x316d37f0, Offset: 0x3628
// Size: 0x1a9
function function_607790f9(n_time, n_min, n_max) {
    if (!isdefined(n_time)) {
        n_time = 10;
    }
    if (!isdefined(n_min)) {
        n_min = 1;
    }
    if (!isdefined(n_max)) {
        n_max = 3;
    }
    level endon(#"silo_complete");
    self endon(#"death");
    self endon(#"hash_34674350");
    var_61cf9b22 = self.origin;
    var_175d1224 = self.angles;
    while (true) {
        v_movement = (randomintrange(n_min, n_max), randomintrange(n_min, n_max), randomintrange(n_min, n_max)) * 0.75;
        v_rotation = (randomintrange(n_min, n_max), randomintrange(n_min, n_max), randomintrange(n_min, n_max));
        self moveto(var_61cf9b22 + v_movement, n_time, 0.5, 0.5);
        self rotateto(var_175d1224 + v_rotation, n_time, 0.5, 0.5);
        wait n_time;
        self moveto(var_61cf9b22 - v_movement, n_time, 0.5, 0.5);
        self rotateto(var_175d1224 - v_rotation, n_time, 0.5, 0.5);
        wait n_time;
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x9e736424, Offset: 0x37e0
// Size: 0xc3
function function_48cb67f6() {
    var_eb48c16a = struct::get_array(self.target);
    array::thread_all(var_eb48c16a, &scene::init);
    self trigger::wait_till();
    foreach (n_index, s_bundle in var_eb48c16a) {
        s_bundle thread util::delay((n_index + 1) / 5, undefined, &scene::play);
    }
}

// Namespace cp_mi_sing_sgen_silo_swim
// Params 0, eflags: 0x0
// Checksum 0x69f1f0ca, Offset: 0x38b0
// Size: 0x173
function function_454f17f5() {
    level flag::wait_till("player_in_fan_vent");
    foreach (player in level.activeplayers) {
        player thread hazard::function_e9b126ef(20, 0.6);
    }
    level flag::wait_till("hendricks_move_up_5");
    foreach (player in level.activeplayers) {
        player thread hazard::function_e9b126ef(25, 0.9);
    }
    level flag::wait_till("final_breath");
    foreach (player in level.activeplayers) {
        player thread hazard::function_e9b126ef(5, 1);
    }
}

