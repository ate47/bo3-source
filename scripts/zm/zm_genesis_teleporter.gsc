#using scripts/zm/_zm_weap_ball;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_timer;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_util;
#using scripts/zm/zm_genesis_vo;
#using scripts/zm/zm_genesis_util;
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

#namespace namespace_b2e08b6c;

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x2
// Checksum 0x3d532866, Offset: 0x598
// Size: 0x3c
function function_2dc19561() {
    system::register("zm_genesis_teleporter", &__init__, &__main__, undefined);
}

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x1 linked
// Checksum 0xfb2cbbc5, Offset: 0x5e0
// Size: 0x124
function __init__() {
    level.var_bcadbc9d = 4;
    level.var_484fbc43 = 45;
    /#
        if (getdvarint("targetname") > 0) {
            level.var_484fbc43 = 3;
        }
    #/
    level.var_18879020 = 0;
    level.var_47f4765c = 0;
    level flag::init("genesis_teleporter_used");
    visionset_mgr::register_info("overlay", "zm_factory_teleport", 15000, 61, 1, 1);
    visionset_mgr::register_info("overlay", "zm_genesis_transported", 15000, 20, 15, 1, &visionset_mgr::duration_lerp_thread_per_player, 0);
    clientfield::register("toplayer", "player_shadowman_teleport_hijack_fx", 15000, 1, "int");
}

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x1 linked
// Checksum 0xe1cb0d98, Offset: 0x710
// Size: 0x15e
function __main__() {
    level.var_7d7ca0ea = getent("t_teleport_pad_ee", "targetname");
    level.var_7d7ca0ea thread function_49539bfb();
    level.var_7d7ca0ea thread function_b6d07c17();
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

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x1 linked
// Checksum 0xd1447263, Offset: 0x878
// Size: 0x140
function function_b6d07c17() {
    while (true) {
        self.var_d0866ff4 = [];
        foreach (e_player in level.activeplayers) {
            if (zombie_utility::is_player_valid(e_player) && self function_5f4a2230(e_player)) {
                if (!isdefined(self.var_d0866ff4)) {
                    self.var_d0866ff4 = [];
                } else if (!isarray(self.var_d0866ff4)) {
                    self.var_d0866ff4 = array(self.var_d0866ff4);
                }
                self.var_d0866ff4[self.var_d0866ff4.size] = e_player;
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x1 linked
// Checksum 0xc8e1a26a, Offset: 0x9c0
// Size: 0x130
function function_49539bfb() {
    self setcursorhint("HINT_NOICON");
    self sethintstring(%);
    level waittill(#"hash_a5c99c2");
    self thread function_811ca812();
    while (true) {
        self sethintstring(%);
        level flag::wait_till("teleporter_on");
        exploder::exploder("ee_teleporter_on");
        exploder::exploder("lgt_teleporter_powered");
        level flag::wait_till_clear("teleporter_on");
        exploder::stop_exploder("ee_teleporter_on");
        exploder::stop_exploder("lgt_teleporter_powered");
    }
}

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x1 linked
// Checksum 0x79adc3b5, Offset: 0xaf8
// Size: 0x18a
function function_811ca812() {
    level thread namespace_c149ef1::function_14ee80c6();
    while (true) {
        e_player = self waittill(#"trigger");
        if (zm_utility::is_player_valid(e_player) && !level.var_18879020) {
            var_12b659cf = 0;
            if (level flag::get("toys_collected") && !level flag::get("boss_fight")) {
                var_12b659cf = 1;
            }
            if (!function_7ae798cc(e_player)) {
                continue;
            }
            self playsound("evt_teleporter_warmup");
            self thread function_5f0f1e6d(1);
            b_result = self function_264f93ff(var_12b659cf);
            self thread function_5f0f1e6d(0);
            level flag::clear("teleporter_on");
            if (b_result) {
                level notify(#"hash_944787dd", e_player);
            }
        }
    }
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x1 linked
// Checksum 0xccc811a8, Offset: 0xc90
// Size: 0x10c
function function_7ae798cc(e_who) {
    if (!level flag::get("teleporter_on")) {
        return false;
    }
    if (e_who.is_drinking > 0) {
        return false;
    }
    if (e_who zm_utility::in_revive_trigger()) {
        return false;
    }
    if (!array::is_touching(level.activeplayers, self)) {
        return false;
    }
    if (zm_utility::is_player_valid(e_who)) {
        if (!e_who zm_score::can_player_purchase(0)) {
            e_who zm_audio::create_and_play_dialog("general", "transport_deny");
            return false;
        } else {
            e_who zm_score::minus_to_player_score(0);
            return true;
        }
    }
    return false;
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x1 linked
// Checksum 0x620543d8, Offset: 0xda8
// Size: 0x570
function function_264f93ff(var_12b659cf) {
    if (!isdefined(var_12b659cf)) {
        var_12b659cf = 0;
    }
    exploder::exploder("ee_teleporter_fx");
    self thread function_f5a06c(level.var_bcadbc9d);
    self thread function_40b54710(20, 300);
    if (var_12b659cf) {
        foreach (e_player in level.players) {
            e_player zm_utility::create_streamer_hint(struct::get_array("dark_arena_teleport_hijack", "targetname")[0].origin, struct::get_array("dark_arena_teleport_hijack", "targetname")[0].angles, 1);
        }
        var_2950e51 = struct::get_array("dark_arena_teleport_hijack", "targetname");
        wait(2);
        self notify(#"hash_d75099e");
        namespace_cb655c88::function_342295d8("dark_arena2_zone");
        namespace_cb655c88::function_342295d8("dark_arena_zone");
        b_result = self function_67eda94(var_2950e51);
        if (!b_result) {
            return 0;
        }
        level flag::set("boss_fight");
        return;
    }
    foreach (e_player in level.players) {
        e_player zm_utility::create_streamer_hint(struct::get_array("sams_room_pos", "script_noteworthy")[0].origin, struct::get_array("sams_room_pos", "script_noteworthy")[0].angles, 1, level.var_bcadbc9d + 4);
        e_player clientfield::set_to_player("player_light_exploder", 2);
    }
    a_s_pos = struct::get_array(self.target, "targetname");
    var_221e828b = [];
    var_785e8821 = [];
    for (i = 0; i < a_s_pos.size; i++) {
        if (a_s_pos[i].script_noteworthy === "sams_room_pos") {
            array::add(var_221e828b, a_s_pos[i], 0);
            continue;
        }
        if (a_s_pos[i].script_noteworthy === "teleporter_pos") {
            array::add(var_785e8821, a_s_pos[i], 0);
        }
    }
    wait(2);
    self notify(#"hash_d75099e");
    namespace_cb655c88::function_342295d8("samanthas_room_zone");
    b_result = self function_f898dba2(var_221e828b, var_12b659cf);
    if (!b_result) {
        return 0;
    }
    if (!var_12b659cf) {
        wait(30);
        exploder::exploder("ee_teleporter_fx");
        e_player zm_utility::create_streamer_hint(var_785e8821[0].origin, var_785e8821[0].angles, 1, level.var_bcadbc9d + 2);
        self function_f3d057eb(var_785e8821);
        e_player clientfield::set_to_player("player_light_exploder", 1);
        namespace_cb655c88::function_342295d8("samanthas_room_zone", 0);
        level thread namespace_c149ef1::function_60fe98c4();
    }
    return 1;
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x1 linked
// Checksum 0x44876906, Offset: 0x1320
// Size: 0x9a
function function_5f0f1e6d(var_855ca94a) {
    foreach (e_player in level.players) {
        self setinvisibletoplayer(e_player, var_855ca94a);
    }
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x1 linked
// Checksum 0x9e533b02, Offset: 0x13c8
// Size: 0x5e
function function_5f4a2230(player) {
    n_dist_sq = distance2dsquared(player.origin, self.origin);
    if (n_dist_sq < 5184) {
        return true;
    }
    return false;
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x1 linked
// Checksum 0xc6913e33, Offset: 0x1430
// Size: 0x3c
function function_f5a06c(n_duration) {
    array::thread_all(level.activeplayers, &function_5e48550f, self, n_duration);
}

// Namespace namespace_b2e08b6c
// Params 2, eflags: 0x1 linked
// Checksum 0x1afead1, Offset: 0x1478
// Size: 0x180
function function_5e48550f(var_7d7ca0ea, n_duration) {
    var_7d7ca0ea endon(#"hash_d75099e");
    n_start_time = gettime();
    n_total_time = 0;
    while (n_total_time < n_duration) {
        if (array::contains(var_7d7ca0ea.var_d0866ff4, self)) {
            visionset_mgr::activate("overlay", "zm_trap_electric", self, 1.25, 1.25);
            self playrumbleonentity("zm_castle_pulsing_rumble");
            while (n_total_time < n_duration && array::contains(var_7d7ca0ea.var_d0866ff4, self)) {
                n_current_time = gettime();
                n_total_time = (n_current_time - n_start_time) / 1000;
                util::wait_network_frame();
            }
            visionset_mgr::deactivate("overlay", "zm_trap_electric", self);
        }
        n_current_time = gettime();
        n_total_time = (n_current_time - n_start_time) / 1000;
        util::wait_network_frame();
    }
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x1 linked
// Checksum 0x5c88fec, Offset: 0x1600
// Size: 0x2a
function function_67eda94(a_s_pos) {
    return self teleport_players(a_s_pos, 1, 0, 1);
}

// Namespace namespace_b2e08b6c
// Params 2, eflags: 0x1 linked
// Checksum 0x510b23ef, Offset: 0x1638
// Size: 0x42
function function_f898dba2(a_s_pos, var_6bd63d0d) {
    level notify(#"hash_a14d03aa");
    return self teleport_players(a_s_pos, 1, var_6bd63d0d);
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x1 linked
// Checksum 0x54ea62a6, Offset: 0x1688
// Size: 0x2a
function function_f3d057eb(a_s_pos) {
    return self teleport_players(a_s_pos, 0, 1);
}

// Namespace namespace_b2e08b6c
// Params 4, eflags: 0x1 linked
// Checksum 0xd02d9483, Offset: 0x16c0
// Size: 0x942
function teleport_players(a_s_pos, var_1bac7e2b, var_e11d2975, var_6bd63d0d) {
    if (!isdefined(var_6bd63d0d)) {
        var_6bd63d0d = 0;
    }
    level flag::set("genesis_teleporter_used");
    var_5529cca0 = 24;
    var_a80e3914 = struct::get_array("teleport_room_pos", "targetname");
    var_c172b345 = 1;
    foreach (e_player in level.activeplayers) {
        if (!array::contains(self.var_d0866ff4, e_player)) {
            var_c172b345 = 0;
        }
    }
    if (var_e11d2975 || var_c172b345) {
        var_19ff0dfb = [];
        var_daad3c3c = (0, 0, 49);
        var_6b55b1c4 = (0, 0, 20);
        var_3abe10e2 = (0, 0, 0);
        var_d9543609 = undefined;
        for (i = 0; i < level.players.size; i++) {
            e_player = level.players[i];
            if (isdefined(e_player.b_teleported) && !var_1bac7e2b && (var_1bac7e2b || e_player.b_teleported)) {
                if (isdefined(var_a80e3914[i])) {
                    e_player.b_teleporting = 1;
                    visionset_mgr::deactivate("overlay", "zm_trap_electric", e_player);
                    if (var_6bd63d0d) {
                        e_player clientfield::set_to_player("player_shadowman_teleport_hijack_fx", 1);
                    } else {
                        visionset_mgr::activate("overlay", "zm_factory_teleport", e_player);
                    }
                    if (e_player hasweapon(level.ballweapon)) {
                        var_d9543609 = e_player.carryobject;
                    }
                    e_player disableoffhandweapons();
                    e_player disableweapons();
                    if (e_player getstance() == "prone") {
                        var_e2a6e15f = var_a80e3914[i].origin + var_daad3c3c;
                    } else if (e_player getstance() == "crouch") {
                        var_e2a6e15f = var_a80e3914[i].origin + var_6b55b1c4;
                    } else {
                        var_e2a6e15f = var_a80e3914[i].origin + var_3abe10e2;
                    }
                    array::add(var_19ff0dfb, e_player, 0);
                    e_player.var_601ebf01 = util::spawn_model("tag_origin", e_player.origin, e_player.angles);
                    e_player linkto(e_player.var_601ebf01);
                    e_player dontinterpolate();
                    e_player.var_601ebf01 dontinterpolate();
                    e_player.var_601ebf01.origin = var_e2a6e15f;
                    e_player.var_601ebf01.angles = var_a80e3914[i].angles;
                    e_player freezecontrols(1);
                    util::wait_network_frame();
                    if (isdefined(e_player)) {
                        util::setclientsysstate("levelNotify", "black_box_start", e_player);
                        e_player.var_601ebf01.angles = var_a80e3914[i].angles;
                    }
                }
            }
        }
        if (var_1bac7e2b && var_19ff0dfb.size == level.activeplayers.size) {
            if (level flag::get("spawn_zombies")) {
                level flag::clear("spawn_zombies");
            }
        }
        wait(level.var_bcadbc9d);
        array::random(a_s_pos) thread function_40b54710(undefined, 300);
        for (i = 0; i < level.activeplayers.size; i++) {
            util::setclientsysstate("levelNotify", "black_box_end", level.activeplayers[i]);
        }
        util::wait_network_frame();
        for (i = 0; i < var_19ff0dfb.size; i++) {
            e_player = var_19ff0dfb[i];
            if (!isdefined(e_player)) {
                continue;
            }
            e_player unlink();
            if (positionwouldtelefrag(a_s_pos[i].origin)) {
                e_player setorigin(a_s_pos[i].origin + (randomfloatrange(-16, 16), randomfloatrange(-16, 16), 0));
            } else {
                e_player setorigin(a_s_pos[i].origin);
            }
            e_player setplayerangles(a_s_pos[i].angles);
            if (var_6bd63d0d) {
                e_player clientfield::set_to_player("player_shadowman_teleport_hijack_fx", 0);
            } else {
                visionset_mgr::deactivate("overlay", "zm_factory_teleport", e_player);
            }
            if (isdefined(var_d9543609)) {
                var_d9543609 ball::function_98827162(0);
            }
            e_player enableweapons();
            e_player enableoffhandweapons();
            e_player freezecontrols(0);
            e_player thread function_77a0f55b();
            e_player.var_601ebf01 delete();
            if (var_1bac7e2b) {
                e_player.b_teleported = 1;
            } else {
                e_player.b_teleported = undefined;
            }
            e_player.b_teleporting = 0;
        }
        if (!var_1bac7e2b) {
            level.var_47f4765c++;
            level flag::set("spawn_zombies");
            if (level.var_47f4765c == 1 || level.var_47f4765c % 3 == 0) {
                playsoundatposition("vox_maxis_teleporter_pa_success_0", a_s_pos[0].origin);
            }
        }
        return 1;
    }
    return 0;
}

// Namespace namespace_b2e08b6c
// Params 2, eflags: 0x1 linked
// Checksum 0xbc34b907, Offset: 0x2010
// Size: 0x1c6
function function_40b54710(n_max_zombies, n_range) {
    a_ai_zombies = getaiteamarray(level.zombie_team);
    a_ai_zombies = util::get_array_of_closest(self.origin, a_ai_zombies, undefined, n_max_zombies, n_range);
    for (i = 0; i < a_ai_zombies.size; i++) {
        wait(randomfloatrange(0.2, 0.3));
        if (!isdefined(a_ai_zombies[i])) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(a_ai_zombies[i])) {
            continue;
        }
        if (a_ai_zombies[i].archetype === "mechz" || a_ai_zombies[i].archetype === "margwa") {
            continue;
        }
        if (!a_ai_zombies[i].isdog) {
            a_ai_zombies[i] zombie_utility::zombie_head_gib();
        }
        a_ai_zombies[i] dodamage(10000, a_ai_zombies[i].origin);
        playsoundatposition("nuked", a_ai_zombies[i].origin);
    }
}

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x0
// Checksum 0x73271cdc, Offset: 0x21e0
// Size: 0xba
function function_aabb419a() {
    self endon(#"hash_d75099e");
    while (true) {
        wait(1.7);
        for (i = 0; i < level.players.size; i++) {
            if (isdefined(level.players[i])) {
                if (array::contains(self.var_d0866ff4, level.players[i])) {
                    util::setclientsysstate("levelNotify", "t2d", level.players[i]);
                }
            }
        }
    }
}

// Namespace namespace_b2e08b6c
// Params 2, eflags: 0x1 linked
// Checksum 0xefc7e856, Offset: 0x22a8
// Size: 0xaa
function function_77a0f55b(var_edc2ee2a, var_66f7e6b9) {
    if (getdvarstring("genesisAftereffectOverride") == "-1") {
        self thread [[ level.teleport_ae_funcs[randomint(level.teleport_ae_funcs.size)] ]]();
        return;
    }
    self thread [[ level.teleport_ae_funcs[int(getdvarstring("genesisAftereffectOverride"))] ]]();
}

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x1 linked
// Checksum 0xc110e397, Offset: 0x2360
// Size: 0x44
function function_ef0e774f() {
    /#
        println("targetname");
    #/
    self shellshock("explosion", 4);
}

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x1 linked
// Checksum 0x666fdf70, Offset: 0x23b0
// Size: 0x44
function function_fd27ac1b() {
    /#
        println("targetname");
    #/
    self shellshock("electrocution", 4);
}

// Namespace namespace_b2e08b6c
// Params 0, eflags: 0x1 linked
// Checksum 0x5c98aa18, Offset: 0x2400
// Size: 0x24
function function_f710e21c() {
    util::setclientsysstate("levelNotify", "tae", self);
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x1 linked
// Checksum 0x51b8c6c6, Offset: 0x2430
// Size: 0x2c
function function_340c1c45(localclientnum) {
    util::setclientsysstate("levelNotify", "tae", self);
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x1 linked
// Checksum 0x1be41346, Offset: 0x2468
// Size: 0x2c
function function_2c0612f7(localclientnum) {
    util::setclientsysstate("levelNotify", "tae", self);
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x1 linked
// Checksum 0xc90e9ca9, Offset: 0x24a0
// Size: 0x2c
function function_5716654b(localclientnum) {
    util::setclientsysstate("levelNotify", "tae", self);
}

// Namespace namespace_b2e08b6c
// Params 1, eflags: 0x1 linked
// Checksum 0x27c860ab, Offset: 0x24d8
// Size: 0x2c
function function_9fcee6e8(localclientnum) {
    util::setclientsysstate("levelNotify", "tae", self);
}

