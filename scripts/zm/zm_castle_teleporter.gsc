#using scripts/zm/zm_castle_ee;
#using scripts/zm/zm_castle_mechz;
#using scripts/zm/zm_castle_vo;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_timer;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_util;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_fa1b0620;

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x2
// Checksum 0x56caff5b, Offset: 0x6a0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_castle_teleporter", &__init__, &__main__, undefined);
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0x65dcb24, Offset: 0x6e8
// Size: 0x1f4
function __init__() {
    level.var_75926bba = -126;
    level.teleport = [];
    level.var_69cf0939 = 0;
    level.countdown = 0;
    level.var_bcadbc9d = 2;
    level.var_484fbc43 = 45;
    /#
        if (getdvarint("past_laboratory_telepoints") > 0) {
            level.var_484fbc43 = 3;
        }
    #/
    level.var_7f034e97 = 0;
    level.var_46eb4efb = 0;
    level.var_47f4765c = 0;
    level flag::init("castle_teleporter_used");
    visionset_mgr::register_info("overlay", "zm_factory_teleport", 5000, 61, 1, 1);
    visionset_mgr::register_info("overlay", "zm_castle_transported", 1, 20, 15, 1, &visionset_mgr::duration_lerp_thread_per_player, 0);
    clientfield::register("world", "ee_quest_time_travel_ready", 5000, 1, "int");
    clientfield::register("toplayer", "ee_quest_back_in_time_teleport_fx", 5000, 1, "int");
    clientfield::register("toplayer", "ee_quest_back_in_time_postfx", 5000, 1, "int");
    clientfield::register("toplayer", "ee_quest_back_in_time_sfx", 5000, 1, "int");
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0xe27615d9, Offset: 0x8e8
// Size: 0x1d6
function __main__() {
    var_a0cf8f2b = getentarray("trigger_teleport_pad", "targetname");
    foreach (n_index, e_trig in var_a0cf8f2b) {
        level.var_27b3c884[n_index] = e_trig;
        e_trig thread function_49539bfb();
    }
    level.var_c7e50b48 = 1;
    level.teleport_ae_funcs = [];
    if (!issplitscreen()) {
        level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_f710e21c;
    }
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_ef0e774f;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_fd27ac1b;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_340c1c45;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_2c0612f7;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_5716654b;
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &function_9fcee6e8;
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0x2b01a53e, Offset: 0xac8
// Size: 0x202
function function_a45ef40c() {
    foreach (t_trig in level.var_27b3c884) {
        t_trig sethintstring(%ZOMBIE_TELEPORT_COOLDOWN);
        t_trig function_5f0f1e6d(0);
    }
    level.var_7f034e97 = 1;
    array::thread_all(level.var_27b3c884, &function_68ebacd3);
    wait(level.var_484fbc43);
    level.var_7f034e97 = 0;
    foreach (t_trig in level.var_27b3c884) {
        if (level flag::get("rocket_firing")) {
            t_trig sethintstring(%ZM_CASTLE_TELEPORT_LOCKED);
            continue;
        }
        if (isdefined(t_trig.var_1c5080fe) && t_trig.var_1c5080fe) {
            t_trig sethintstring(%ZM_CASTLE_TELEPORT_USE, 500);
            continue;
        }
        t_trig sethintstring(%ZOMBIE_LINK_TPAD);
    }
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0xb9923b19, Offset: 0xcd8
// Size: 0xfc
function function_68ebacd3() {
    self.var_eb37ce09 = undefined;
    wait(10);
    while (level.var_7f034e97) {
        if (!isdefined(self.var_eb37ce09)) {
            foreach (e_player in level.activeplayers) {
                if (e_player istouching(self)) {
                    if (!level flag::get("rocket_firing")) {
                        self thread function_798f36c();
                    }
                }
            }
        }
        wait(0.4);
    }
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0xe1b81d01, Offset: 0xde0
// Size: 0x14c
function function_798f36c() {
    self.var_eb37ce09 = gettime();
    playsoundatposition("vox_maxis_teleporter_pa_recharging_0", self.origin);
    while (level.var_7f034e97) {
        if (gettime() - self.var_eb37ce09 > 16000) {
            foreach (e_player in level.activeplayers) {
                if (e_player istouching(self)) {
                    self.var_eb37ce09 = gettime();
                    playsoundatposition("vox_maxis_teleporter_pa_recharging_0", self.origin);
                }
            }
        }
        wait(1);
    }
    self.var_eb37ce09 = undefined;
    wait(3);
    playsoundatposition("vox_maxis_teleporter_pa_available_0", self.origin);
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0x524a40cd, Offset: 0xf38
// Size: 0x10a
function function_ee24bc2e() {
    foreach (t_trig in level.var_27b3c884) {
        if (level flag::get("rocket_firing")) {
            t_trig sethintstring(%ZM_CASTLE_TELEPORT_LOCKED);
            continue;
        }
        if (level.var_7f034e97 == 1) {
            t_trig sethintstring(%ZOMBIE_TELEPORT_COOLDOWN);
            continue;
        }
        t_trig sethintstring(%ZM_CASTLE_TELEPORT_USE, 500);
    }
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x4
// Checksum 0x9161ddc4, Offset: 0x1050
// Size: 0xfc
function private update_trigger_visibility() {
    self endon(#"death");
    while (true) {
        for (i = 0; i < level.players.size; i++) {
            if (distancesquared(level.players[i].origin, self.origin) < 16384) {
                if (level.players[i].is_drinking > 0) {
                    self setinvisibletoplayer(level.players[i], 1);
                    continue;
                }
                self setinvisibletoplayer(level.players[i], 0);
            }
        }
        wait(0.25);
    }
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0xaa5e7c0e, Offset: 0x1158
// Size: 0x94
function function_49539bfb() {
    self setcursorhint("HINT_NOICON");
    self sethintstring(%ZOMBIE_NEED_POWER);
    level flag::wait_till("power_on");
    self thread function_811ca812();
    self thread update_trigger_visibility();
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0xb2481b61, Offset: 0x11f8
// Size: 0x200
function function_811ca812() {
    self setcursorhint("HINT_NOICON");
    self.var_1c5080fe = 1;
    e_player = undefined;
    self sethintstring(%ZM_CASTLE_TELEPORT_USE, 500);
    exploder::exploder("fxexp_100");
    while (true) {
        e_player = self waittill(#"trigger");
        if (zm_utility::is_player_valid(e_player) && !level.var_7f034e97 && !level flag::get("rocket_firing") && level flag::get("time_travel_teleporter_ready")) {
            if (function_6b3344b4()) {
                if (!function_ad16f13c(e_player)) {
                    continue;
                }
                self playsound("evt_teleporter_warmup");
                self function_264f93ff(1, 0);
            }
            continue;
        }
        if (zm_utility::is_player_valid(e_player) && !level.var_7f034e97 && !level flag::get("rocket_firing")) {
            if (!function_ad16f13c(e_player)) {
                continue;
            }
            self playsound("evt_teleporter_warmup");
            self function_264f93ff(0);
        }
    }
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0x2314db02, Offset: 0x1400
// Size: 0xcc
function function_ad16f13c(e_who) {
    if (e_who.is_drinking > 0) {
        return false;
    }
    if (e_who zm_utility::in_revive_trigger()) {
        return false;
    }
    if (zm_utility::is_player_valid(e_who)) {
        if (!e_who zm_score::can_player_purchase(500)) {
            e_who zm_audio::create_and_play_dialog("general", "transport_deny");
            return false;
        } else {
            e_who zm_score::minus_to_player_score(500);
            return true;
        }
    }
    return false;
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0x794f4920, Offset: 0x14d8
// Size: 0x19c
function function_6b3344b4() {
    var_a0cf8f2b = getentarray("trigger_teleport_pad", "targetname");
    var_d30fe07b = 1;
    players = level.activeplayers;
    foreach (player in players) {
        var_1a19680c = 0;
        foreach (e_trig in var_a0cf8f2b) {
            if (player istouching(e_trig)) {
                var_1a19680c = 1;
            }
        }
        if (!isalive(player) || !var_1a19680c) {
            var_d30fe07b = 0;
        }
    }
    return var_d30fe07b;
}

// Namespace namespace_fa1b0620
// Params 2, eflags: 0x0
// Checksum 0xcea68181, Offset: 0x1680
// Size: 0x594
function function_264f93ff(var_edc2ee2a, var_66f7e6b9) {
    if (!isdefined(var_edc2ee2a)) {
        var_edc2ee2a = 0;
    }
    if (!isdefined(var_66f7e6b9)) {
        var_66f7e6b9 = 0;
    }
    array::thread_all(level.var_27b3c884, &function_5f0f1e6d, 1);
    if (var_edc2ee2a && !var_66f7e6b9) {
        level.disable_nuke_delay_spawning = 1;
        level flag::clear("spawn_zombies");
        namespace_c93e4c32::function_5db6ba34();
    }
    var_1219cefe = gettime() - level.var_46eb4efb;
    exploder::exploder("fxexp_101");
    self thread function_f5a06c(level.var_bcadbc9d);
    if (!var_edc2ee2a) {
        self thread function_40b54710(20, 300);
    }
    if (var_edc2ee2a && !var_66f7e6b9) {
        level thread namespace_c93e4c32::function_2c1aa78f();
    }
    foreach (player in level.players) {
        if (player.zone_name === "zone_v10_pad") {
            player zm_utility::create_streamer_hint(struct::get_array(self.target, "targetname")[0].origin, struct::get_array(self.target, "targetname")[0].angles, 1);
        }
        if (var_edc2ee2a) {
            if (var_66f7e6b9) {
                player clientfield::set_to_player("ee_quest_back_in_time_sfx", 0);
                continue;
            }
            player clientfield::set_to_player("ee_quest_back_in_time_sfx", 1);
        }
    }
    wait(level.var_bcadbc9d);
    self notify(#"hash_d75099e");
    if (var_edc2ee2a && !var_66f7e6b9) {
        if (!level flag::get("dimension_set")) {
            namespace_c93e4c32::function_3918d831("safe_code_past");
        }
    }
    self teleport_players(var_edc2ee2a, var_66f7e6b9);
    if (var_edc2ee2a) {
        if (var_66f7e6b9) {
            if (self.script_int === 0) {
                level thread function_e421dd3f();
            } else {
                s_spawn_pos = struct::get("ee_mechz_time_lab", "targetname");
                playfx(level._effect["lightning_dog_spawn"], s_spawn_pos.origin);
                var_99c3dd59 = namespace_48131a3f::function_314d744b(0, s_spawn_pos, 0);
                var_99c3dd59.no_damage_points = 1;
                var_99c3dd59.deathpoints_already_given = 1;
                var_99c3dd59.exclude_cleanup_adding_to_total = 1;
            }
            level flag::set("spawn_zombies");
            level.disable_nuke_delay_spawning = 0;
        } else {
            wait(0.5);
            level notify(#"hash_59b7ed");
        }
    }
    if (level.var_7f034e97 == 0 && !level flag::get("time_travel_teleporter_ready")) {
        thread function_a45ef40c();
    }
    wait(2);
    ss = struct::get("teleporter_powerup", "targetname");
    if (isdefined(ss)) {
        ss thread zm_powerups::function_b347edb5(ss.origin);
    }
    level.var_46eb4efb = gettime();
    if (var_edc2ee2a && !var_66f7e6b9) {
        level flag::clear("time_travel_teleporter_ready");
        wait(33);
        self function_264f93ff(1, 1);
        level thread namespace_97ddfc0d::function_8b0b26a6();
        namespace_c93e4c32::function_71152937();
    }
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0x513f3fd4, Offset: 0x1c20
// Size: 0x124
function function_e421dd3f() {
    level notify(#"hash_bff04a2b");
    level endon(#"hash_bff04a2b");
    var_9e5ac8d1 = getent("trig_mechz_ee_a10", "targetname");
    e_who = var_9e5ac8d1 waittill(#"trigger");
    s_spawn_pos = arraygetclosest(e_who.origin, level.zm_loc_types["mechz_location"]);
    if (isplayer(e_who) && isdefined(s_spawn_pos)) {
        var_99c3dd59 = namespace_48131a3f::function_314d744b(0, s_spawn_pos, 1);
        var_99c3dd59.no_damage_points = 1;
        var_99c3dd59.deathpoints_already_given = 1;
        var_99c3dd59.exclude_cleanup_adding_to_total = 1;
    }
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0xd87939af, Offset: 0x1d50
// Size: 0xb2
function function_5f0f1e6d(enable) {
    players = getplayers();
    foreach (player in players) {
        self setinvisibletoplayer(player, enable);
    }
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0x353c1b13, Offset: 0x1e10
// Size: 0x5e
function function_5f4a2230(player) {
    n_dist_sq = distancesquared(player.origin, self.origin);
    if (n_dist_sq < 30625) {
        return true;
    }
    return false;
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0xf4620ad, Offset: 0x1e78
// Size: 0x3c
function function_f5a06c(n_duration) {
    array::thread_all(level.activeplayers, &function_5e48550f, self, n_duration);
}

// Namespace namespace_fa1b0620
// Params 2, eflags: 0x0
// Checksum 0x5d0c1e7e, Offset: 0x1ec0
// Size: 0x170
function function_5e48550f(var_7d7ca0ea, n_duration) {
    var_7d7ca0ea endon(#"hash_d75099e");
    n_start_time = gettime();
    n_total_time = 0;
    while (n_total_time < n_duration) {
        if (var_7d7ca0ea function_5f4a2230(self)) {
            visionset_mgr::activate("overlay", "zm_factory_teleport", self, n_duration, n_duration);
            self playrumbleonentity("zm_castle_pulsing_rumble");
            while (n_total_time < n_duration && var_7d7ca0ea function_5f4a2230(self)) {
                n_current_time = gettime();
                n_total_time = (n_current_time - n_start_time) / 1000;
                util::wait_network_frame();
            }
            visionset_mgr::deactivate("overlay", "zm_factory_teleport", self);
        }
        n_current_time = gettime();
        n_total_time = (n_current_time - n_start_time) / 1000;
        util::wait_network_frame();
    }
}

// Namespace namespace_fa1b0620
// Params 2, eflags: 0x0
// Checksum 0x4b1697df, Offset: 0x2038
// Size: 0x93c
function teleport_players(var_edc2ee2a, var_66f7e6b9) {
    if (!isdefined(var_edc2ee2a)) {
        var_edc2ee2a = 0;
    }
    if (!isdefined(var_66f7e6b9)) {
        var_66f7e6b9 = 0;
    }
    level flag::set("castle_teleporter_used");
    var_5529cca0 = 24;
    if (var_edc2ee2a && !var_66f7e6b9) {
        var_764d9cb = struct::get_array("past_laboratory_telepoints", "targetname");
    } else {
        var_764d9cb = struct::get_array(self.target, "targetname");
    }
    var_492a5e1e = struct::get_array("teleport_room_pos", "targetname");
    var_19ff0dfb = [];
    var_daad3c3c = (0, 0, 49);
    var_6b55b1c4 = (0, 0, 20);
    var_3abe10e2 = (0, 0, 0);
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (var_edc2ee2a) {
            if (var_66f7e6b9) {
                level flag::clear("time_travel_teleporter_ready");
            }
        }
        var_fcd1ef5d = var_764d9cb[i].origin;
        var_a9d3e161 = var_764d9cb[i].angles;
        if (var_edc2ee2a || self function_5f4a2230(player)) {
            if (var_edc2ee2a && var_66f7e6b9) {
                player clientfield::set_to_player("ee_quest_back_in_time_postfx", 0);
            }
            if (var_edc2ee2a) {
                if (var_66f7e6b9) {
                    player clientfield::set_to_player("ee_quest_back_in_time_sfx", 0);
                } else {
                    player clientfield::set_to_player("ee_quest_back_in_time_sfx", 1);
                }
            }
            if (isdefined(var_492a5e1e[i])) {
                visionset_mgr::deactivate("overlay", "zm_trap_electric", player);
                if (var_edc2ee2a) {
                    player clientfield::set_to_player("ee_quest_back_in_time_teleport_fx", 1);
                } else {
                    visionset_mgr::activate("overlay", "zm_factory_teleport", player);
                }
                player disableoffhandweapons();
                player disableweapons();
                player.b_teleporting = 1;
                if (player getstance() == "prone") {
                    desired_origin = var_492a5e1e[i].origin + var_daad3c3c;
                } else if (player getstance() == "crouch") {
                    desired_origin = var_492a5e1e[i].origin + var_6b55b1c4;
                } else {
                    desired_origin = var_492a5e1e[i].origin + var_3abe10e2;
                }
                array::add(var_19ff0dfb, player, 0);
                player.var_601ebf01 = util::spawn_model("tag_origin", player.origin, player.angles);
                player linkto(player.var_601ebf01);
                player dontinterpolate();
                player.var_601ebf01 dontinterpolate();
                player.var_601ebf01.origin = desired_origin;
                player.var_601ebf01.angles = var_492a5e1e[i].angles;
                player freezecontrols(1);
                util::wait_network_frame();
                if (isdefined(player)) {
                    util::setclientsysstate("levelNotify", "black_box_start", player);
                    player.var_601ebf01.angles = var_492a5e1e[i].angles;
                }
            }
            continue;
        }
        visionset_mgr::deactivate("overlay", "zm_factory_teleport", player);
    }
    wait(2);
    array::random(var_764d9cb) thread function_40b54710(undefined, 300);
    for (i = 0; i < level.activeplayers.size; i++) {
        util::setclientsysstate("levelNotify", "black_box_end", level.activeplayers[i]);
    }
    util::wait_network_frame();
    for (i = 0; i < var_19ff0dfb.size; i++) {
        player = var_19ff0dfb[i];
        if (!isdefined(player)) {
            continue;
        }
        player unlink();
        if (positionwouldtelefrag(var_764d9cb[i].origin)) {
            player setorigin(var_764d9cb[i].origin + (randomfloatrange(-16, 16), randomfloatrange(-16, 16), 0));
        } else {
            player setorigin(var_764d9cb[i].origin);
        }
        player setplayerangles(var_764d9cb[i].angles);
        if (var_edc2ee2a) {
            player clientfield::set_to_player("ee_quest_back_in_time_teleport_fx", 0);
        }
        visionset_mgr::deactivate("overlay", "zm_factory_teleport", player);
        player enableweapons();
        player enableoffhandweapons();
        player.b_teleporting = undefined;
        player freezecontrols(0);
        player thread function_77a0f55b();
        if (var_edc2ee2a && !var_66f7e6b9) {
            player thread function_4a0d1595();
        }
        player zm_utility::clear_streamer_hint();
        player.var_601ebf01 delete();
    }
    level.var_47f4765c++;
    if (level.var_47f4765c == 1 || level.var_47f4765c % 3 == 0) {
        playsoundatposition("vox_maxis_teleporter_pa_success_0", var_764d9cb[0].origin);
    }
    exploder::exploder("fxexp_102");
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0x69a7d862, Offset: 0x2980
// Size: 0x68
function function_4a0d1595() {
    wait(0.05);
    self clientfield::set_to_player("ee_quest_back_in_time_postfx", 1);
    self disableoffhandweapons();
    self disableweapons();
    self.b_teleporting = 1;
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0xf46083c3, Offset: 0x29f0
// Size: 0xca
function function_aabb419a() {
    self endon(#"hash_d75099e");
    while (true) {
        players = getplayers();
        wait(1.7);
        for (i = 0; i < players.size; i++) {
            if (isdefined(players[i])) {
                if (self function_5f4a2230(players[i])) {
                    util::setclientsysstate("levelNotify", "t2d", players[i]);
                }
            }
        }
    }
}

// Namespace namespace_fa1b0620
// Params 2, eflags: 0x0
// Checksum 0x882e209f, Offset: 0x2ac8
// Size: 0x1a6
function function_40b54710(var_728eaa61, range) {
    zombies = getaispeciesarray(level.zombie_team);
    zombies = util::get_array_of_closest(self.origin, zombies, undefined, var_728eaa61, range);
    for (i = 0; i < zombies.size; i++) {
        wait(randomfloatrange(0.2, 0.3));
        if (!isdefined(zombies[i])) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
            continue;
        }
        if (zombies[i].archetype === "mechz") {
            continue;
        }
        if (!zombies[i].isdog) {
            zombies[i] zombie_utility::zombie_head_gib();
        }
        zombies[i] dodamage(10000, zombies[i].origin);
        playsoundatposition("nuked", zombies[i].origin);
    }
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0x903f5298, Offset: 0x2c78
// Size: 0xbe
function function_602be549(index) {
    targ = struct::get("pad_" + index + "_wire", "targetname");
    if (!isdefined(targ)) {
        return;
    }
    while (isdefined(targ)) {
        if (isdefined(targ.target)) {
            target = struct::get(targ.target, "targetname");
            wait(0.1);
            targ = target;
            continue;
        }
        break;
    }
}

// Namespace namespace_fa1b0620
// Params 2, eflags: 0x0
// Checksum 0xda80d117, Offset: 0x2d40
// Size: 0xaa
function function_77a0f55b(var_edc2ee2a, var_66f7e6b9) {
    if (getdvarstring("castleAftereffectOverride") == "-1") {
        self thread [[ level.teleport_ae_funcs[randomint(level.teleport_ae_funcs.size)] ]]();
        return;
    }
    self thread [[ level.teleport_ae_funcs[int(getdvarstring("castleAftereffectOverride"))] ]]();
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0x8a0c923e, Offset: 0x2df8
// Size: 0x44
function function_ef0e774f() {
    /#
        println("nuked");
    #/
    self shellshock("explosion", 4);
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0xa484be94, Offset: 0x2e48
// Size: 0x44
function function_fd27ac1b() {
    /#
        println("<unknown string>");
    #/
    self shellshock("electrocution", 4);
}

// Namespace namespace_fa1b0620
// Params 0, eflags: 0x0
// Checksum 0xfde4bf05, Offset: 0x2e98
// Size: 0x24
function function_f710e21c() {
    util::setclientsysstate("levelNotify", "tae", self);
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0x725114c2, Offset: 0x2ec8
// Size: 0x2c
function function_340c1c45(localclientnum) {
    util::setclientsysstate("levelNotify", "tae", self);
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0xfdd97e9e, Offset: 0x2f00
// Size: 0x2c
function function_2c0612f7(localclientnum) {
    util::setclientsysstate("levelNotify", "tae", self);
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0x9bf752c0, Offset: 0x2f38
// Size: 0x2c
function function_5716654b(localclientnum) {
    util::setclientsysstate("levelNotify", "tae", self);
}

// Namespace namespace_fa1b0620
// Params 1, eflags: 0x0
// Checksum 0xfee3d8ed, Offset: 0x2f70
// Size: 0x2c
function function_9fcee6e8(localclientnum) {
    util::setclientsysstate("levelNotify", "tae", self);
}

