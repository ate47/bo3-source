#using scripts/zm/zm_factory;
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
#using scripts/shared/music_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_4c372a0;

// Namespace namespace_4c372a0
// Params 0, eflags: 0x2
// namespace_4c372a0<file_0>::function_2dc19561
// Checksum 0x91a8c2ae, Offset: 0x740
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_factory_teleporter", &__init__, &__main__, undefined);
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_8c87d8eb
// Checksum 0x660d51b4, Offset: 0x788
// Size: 0x16c
function __init__() {
    level.var_75926bba = -126;
    level thread function_a759ee63();
    level.teleport = [];
    level.var_69cf0939 = 0;
    level.countdown = 0;
    level.var_276703f8 = 2;
    level.var_b01bd818 = 1500;
    level.var_659e2a08 = 5;
    level.var_7f034e97 = 0;
    level.var_65513821 = -1;
    level.var_850a7fc = 0;
    level.var_ed70cfe7 = [];
    level.var_ed70cfe7[0] = "a";
    level.var_ed70cfe7[1] = "c";
    level.var_ed70cfe7[2] = "b";
    level flag::init("teleporter_pad_link_1");
    level flag::init("teleporter_pad_link_2");
    level flag::init("teleporter_pad_link_3");
    visionset_mgr::register_info("overlay", "zm_factory_teleport", 1, 61, 1, 1);
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_5b6b9132
// Checksum 0x2bb30da1, Offset: 0x900
// Size: 0x256
function __main__() {
    for (i = 0; i < 3; i++) {
        trig = getent("trigger_teleport_pad_" + i, "targetname");
        if (isdefined(trig)) {
            level.var_cf938a0[i] = trig;
        }
    }
    level thread function_49539bfb(0);
    level thread function_49539bfb(1);
    level thread function_49539bfb(2);
    level thread function_8811855f();
    level thread function_38e41c6c();
    level.var_c7e50b48 = 1;
    var_a1bdb971 = getent("packapunch_see", "targetname");
    if (isdefined(var_a1bdb971)) {
        var_a1bdb971 thread function_4035141c();
    }
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

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_38e41c6c
// Checksum 0xffd88330, Offset: 0xb60
// Size: 0x336
function function_38e41c6c() {
    collision = spawn("script_model", (-56, 467, -99));
    collision setmodel("collision_wall_128x128x10");
    collision.angles = (0, 0, 0);
    collision hide();
    door = getent("pack_door", "targetname");
    door movez(-50, 0.05, 0);
    wait(1);
    level flag::wait_till("start_zombie_round_logic");
    door movez(50, 1.5, 0);
    door playsound("evt_packa_door_1");
    wait(2);
    collision delete();
    level flag::wait_till("teleporter_pad_link_1");
    door movez(-35, 1.5, 1);
    door playsound("evt_packa_door_2");
    door thread function_ac5b8a1b();
    wait(2);
    level flag::wait_till("teleporter_pad_link_2");
    door movez(-25, 1.5, 1);
    door playsound("evt_packa_door_2");
    wait(2);
    level flag::wait_till("teleporter_pad_link_3");
    door movez(-60, 1.5, 1);
    door playsound("evt_packa_door_2");
    clip = getentarray("pack_door_clip", "targetname");
    for (i = 0; i < clip.size; i++) {
        clip[i] connectpaths();
        clip[i] delete();
    }
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_a45ef40c
// Checksum 0xff47d615, Offset: 0xea0
// Size: 0x12e
function function_a45ef40c() {
    for (i = 0; i < level.var_cf938a0.size; i++) {
        level.var_cf938a0[i] sethintstring(%ZOMBIE_TELEPORT_COOLDOWN);
        level.var_cf938a0[i] function_5f0f1e6d(0);
    }
    level.var_7f034e97 = 1;
    wait(level.var_659e2a08);
    level.var_7f034e97 = 0;
    for (i = 0; i < level.var_cf938a0.size; i++) {
        if (level.var_cf938a0[i].teleport_active) {
            level.var_cf938a0[i] sethintstring(%ZOMBIE_TELEPORT_TO_CORE);
            continue;
        }
        level.var_cf938a0[i] sethintstring(%ZOMBIE_LINK_TPAD);
    }
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_49539bfb
// Checksum 0xfc60d137, Offset: 0xfd8
// Size: 0x3dc
function function_49539bfb(index) {
    var_83efbf69 = getent("tele_help_" + index, "targetname");
    if (isdefined(var_83efbf69)) {
        var_83efbf69 thread function_9c2f8bc2();
    }
    active = 0;
    level.teleport[index] = "waiting";
    trigger = level.var_cf938a0[index];
    trigger setcursorhint("HINT_NOICON");
    trigger sethintstring(%ZOMBIE_NEED_POWER);
    level flag::wait_till("power_on");
    trigger sethintstring(%ZOMBIE_POWER_UP_TPAD);
    trigger.teleport_active = 0;
    if (isdefined(trigger)) {
        while (!active) {
            trigger waittill(#"trigger");
            if (level.var_69cf0939 < 3) {
                var_c2fccfd7 = getent("trigger_teleport_core", "targetname");
                var_c2fccfd7 function_5f0f1e6d(0);
            }
            for (i = 0; i < level.var_cf938a0.size; i++) {
                level.var_cf938a0[i] function_5f0f1e6d(1);
            }
            level.teleport[index] = "timer_on";
            trigger thread function_5283c96a(index, 30);
            function_c1021075("countdown", trigger);
            while (level.teleport[index] == "timer_on") {
                wait(0.05);
            }
            if (level.teleport[index] == "active") {
                active = 1;
                level util::clientnotify("pw" + index);
                level util::clientnotify("tp" + index);
                function_602be549(index);
                trigger thread player_teleporting(index);
            } else {
                for (i = 0; i < level.var_cf938a0.size; i++) {
                    level.var_cf938a0[i] function_5f0f1e6d(0);
                }
            }
            wait(0.05);
        }
        if (level.var_7f034e97) {
            trigger sethintstring(%ZOMBIE_TELEPORT_COOLDOWN);
            trigger function_5f0f1e6d(0);
            trigger.teleport_active = 1;
            return;
        }
        trigger thread function_811ca812(index);
    }
}

// Namespace namespace_4c372a0
// Params 2, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_5283c96a
// Checksum 0x8485c858, Offset: 0x13c0
// Size: 0x154
function function_5283c96a(index, time) {
    self endon(#"hash_b7fb6a59");
    if (level.var_65513821 < 0) {
        level.var_65513821 = index;
    }
    level.countdown++;
    self thread function_6bb61cf7();
    level util::clientnotify("TRf");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] thread namespace_9ffa5e0::start_timer(time + 1, "stop_countdown");
    }
    wait(time + 1);
    if (level.var_65513821 == index) {
        level.var_65513821 = -1;
    }
    level.teleport[index] = "timer_off";
    level util::clientnotify("TRs");
    level.countdown--;
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_6bb61cf7
// Checksum 0x5ea3d68e, Offset: 0x1520
// Size: 0x13c
function function_6bb61cf7() {
    self endon(#"hash_b7fb6a59");
    var_1cb7ccb9 = spawn("script_origin", (0, 0, 0));
    var_1cb7ccb9 thread function_aad04527();
    level thread zm_factory::function_5369a434("vox_maxis_teleporter_ultimatum_0");
    count = 30;
    num = 11;
    while (count > 0) {
        play = count == 20 || count == 15 || count <= 10;
        if (play) {
            level thread zm_factory::function_5369a434("vox_maxis_teleporter_count_" + num, undefined, 1);
            num--;
        }
        wait(1);
        count--;
    }
    level notify(#"hash_b7fb6a59");
    level thread zm_factory::function_5369a434("vox_maxis_teleporter_expired_0");
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_aad04527
// Checksum 0x977560f1, Offset: 0x1668
// Size: 0xec
function function_aad04527() {
    level util::delay(0, undefined, &zm_audio::sndmusicsystem_playstate, "timer");
    self playloopsound("evt_clock_tick_1sec");
    level waittill(#"hash_b7fb6a59");
    if (isdefined(level.musicsystem.currentstate) && level.musicsystem.currentstate == "timer") {
        level thread zm_audio::sndmusicsystem_stopandflush();
        music::setmusicstate("none");
    }
    self stoploopsound(0);
    self delete();
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_811ca812
// Checksum 0xd3666f00, Offset: 0x1760
// Size: 0x130
function function_811ca812(index) {
    self setcursorhint("HINT_NOICON");
    self.teleport_active = 1;
    user = undefined;
    while (true) {
        user = self waittill(#"trigger");
        if (zm_utility::is_player_valid(user) && user zm_score::can_player_purchase(level.var_b01bd818) && !level.var_7f034e97) {
            for (i = 0; i < level.var_cf938a0.size; i++) {
                level.var_cf938a0[i] function_5f0f1e6d(1);
            }
            user zm_score::minus_to_player_score(level.var_b01bd818);
            self player_teleporting(index);
        }
    }
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_f3eef534
// Checksum 0xa74f6ab9, Offset: 0x1898
// Size: 0x230
function player_teleporting(index) {
    var_1219cefe = gettime() - level.var_850a7fc;
    exploder::exploder_duration("teleporter_" + level.var_ed70cfe7[index] + "_teleporting", 5.3);
    exploder::exploder_duration("mainframe_warm_up", 4.8);
    level util::clientnotify("tpw" + index);
    level thread zm_factory::function_5369a434("vox_maxis_teleporter_success_0");
    self thread function_5e48550f(level.var_276703f8);
    self thread function_aabb419a();
    self thread function_40b54710(20, 300);
    wait(level.var_276703f8);
    self notify(#"hash_d75099e");
    self thread zm_factory::function_c7b37638();
    self teleport_players();
    if (level.var_7f034e97 == 0) {
        thread function_a45ef40c();
    }
    wait(2);
    ss = struct::get("teleporter_powerup", "targetname");
    if (isdefined(ss)) {
        ss thread zm_powerups::function_b347edb5(ss.origin);
    }
    if (var_1219cefe < 60000 && level.var_69cf0939 == 3 && level.round_number > 20) {
        thread zm_utility::play_sound_2d("vox_sam_nospawn");
    }
    level.var_850a7fc = gettime();
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_5f0f1e6d
// Checksum 0xcbba02aa, Offset: 0x1ad0
// Size: 0x86
function function_5f0f1e6d(enable) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i])) {
            self setinvisibletoplayer(players[i], enable);
        }
    }
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_5f4a2230
// Checksum 0xee9a7e5a, Offset: 0x1b60
// Size: 0x8e
function function_5f4a2230(player) {
    radius = 88;
    var_ba2701a9 = 2;
    dist = distance2d(player.origin, self.origin);
    var_291de433 = radius * var_ba2701a9;
    if (dist < var_291de433) {
        return true;
    }
    return false;
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_5e48550f
// Checksum 0x5a44095f, Offset: 0x1bf8
// Size: 0xb6
function function_5e48550f(duration) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i])) {
            if (self function_5f4a2230(players[i])) {
                visionset_mgr::activate("overlay", "zm_trap_electric", players[i], 1.25, 1.25);
            }
        }
    }
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_552e05fb
// Checksum 0x2acd89de, Offset: 0x1cb8
// Size: 0x8b4
function teleport_players() {
    player_radius = 16;
    players = getplayers();
    var_1ec3415f = [];
    occupied = [];
    var_594457ea = [];
    players_touching = [];
    var_3d64f026 = 0;
    prone_offset = (0, 0, 49);
    crouch_offset = (0, 0, 20);
    var_7cac5f2f = (0, 0, 0);
    for (i = 0; i < 4; i++) {
        var_1ec3415f[i] = getent("origin_teleport_player_" + i, "targetname");
        occupied[i] = 0;
        var_594457ea[i] = getent("teleport_room_" + i, "targetname");
        if (isdefined(players[i])) {
            if (self function_5f4a2230(players[i])) {
                players[i].b_teleporting = 1;
                players_touching[var_3d64f026] = i;
                var_3d64f026++;
                if (isdefined(var_594457ea[i])) {
                    visionset_mgr::deactivate("overlay", "zm_trap_electric", players[i]);
                    visionset_mgr::activate("overlay", "zm_factory_teleport", players[i]);
                    players[i] disableoffhandweapons();
                    players[i] disableweapons();
                    if (players[i] getstance() == "prone") {
                        desired_origin = var_594457ea[i].origin + prone_offset;
                    } else if (players[i] getstance() == "crouch") {
                        desired_origin = var_594457ea[i].origin + crouch_offset;
                    } else {
                        desired_origin = var_594457ea[i].origin + var_7cac5f2f;
                    }
                    players[i].teleport_origin = spawn("script_origin", players[i].origin);
                    players[i].teleport_origin.angles = players[i].angles;
                    players[i] linkto(players[i].teleport_origin);
                    players[i].teleport_origin.origin = desired_origin;
                    players[i] freezecontrols(1);
                    util::wait_network_frame();
                    if (isdefined(players[i])) {
                        util::setclientsysstate("levelNotify", "black_box_start", players[i]);
                        players[i].teleport_origin.angles = var_594457ea[i].angles;
                    }
                }
            }
        }
    }
    wait(2);
    core = getent("trigger_teleport_core", "targetname");
    core thread function_40b54710(undefined, 300);
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i])) {
            for (j = 0; j < 4; j++) {
                if (!occupied[j]) {
                    dist = distance2d(var_1ec3415f[j].origin, players[i].origin);
                    if (dist < player_radius) {
                        occupied[j] = 1;
                    }
                }
            }
            util::setclientsysstate("levelNotify", "black_box_end", players[i]);
        }
    }
    util::wait_network_frame();
    for (i = 0; i < players_touching.size; i++) {
        var_3d64f026 = players_touching[i];
        player = players[var_3d64f026];
        if (!isdefined(player)) {
            continue;
        }
        slot = i;
        start = 0;
        while (occupied[slot] && start < 4) {
            start++;
            slot++;
            if (slot >= 4) {
                slot = 0;
            }
        }
        occupied[slot] = 1;
        var_a7e8db69 = "origin_teleport_player_" + slot;
        var_f86bdb69 = getent(var_a7e8db69, "targetname");
        player unlink();
        assert(isdefined(player.teleport_origin));
        player.teleport_origin delete();
        player.teleport_origin = undefined;
        visionset_mgr::deactivate("overlay", "zm_factory_teleport", player);
        player enableweapons();
        player enableoffhandweapons();
        player setorigin(var_1ec3415f[slot].origin);
        player setplayerangles(var_1ec3415f[slot].angles);
        player freezecontrols(0);
        player thread function_77a0f55b();
        var_82050ffe = randomintrange(1, 100);
        if (var_82050ffe <= 2) {
        }
        player.b_teleporting = 0;
    }
    exploder::exploder_duration("mainframe_arrival", 1.7);
    exploder::exploder_duration("mainframe_steam", 14.6);
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_85be3ff2
// Checksum 0xe420c0be, Offset: 0x2578
// Size: 0x100
function function_85be3ff2() {
    self setcursorhint("HINT_NOICON");
    while (true) {
        if (!level flag::get("power_on")) {
            self sethintstring(%ZOMBIE_NEED_POWER);
        } else if (function_f3a68d87()) {
            self sethintstring(%ZOMBIE_LINK_TPAD);
        } else if (level.var_69cf0939 == 0) {
            self sethintstring(%ZOMBIE_INACTIVE_TPAD);
        } else {
            self sethintstring("");
        }
        wait(0.05);
    }
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_8811855f
// Checksum 0x18bc7a90, Offset: 0x2680
// Size: 0x428
function function_8811855f() {
    trigger = getent("trigger_teleport_core", "targetname");
    if (isdefined(trigger)) {
        trigger thread function_85be3ff2();
        level flag::wait_till("power_on");
        /#
            if (getdvarint("overlay") >= 6) {
                for (i = 0; i < level.teleport.size; i++) {
                    level.teleport[i] = "overlay";
                }
            }
        #/
        while (true) {
            if (function_f3a68d87()) {
                cheat = 0;
                /#
                    if (getdvarint("overlay") >= 6) {
                        cheat = 1;
                    }
                #/
                if (!cheat) {
                    trigger waittill(#"trigger");
                }
                for (i = 0; i < level.teleport.size; i++) {
                    if (isdefined(level.teleport[i])) {
                        if (level.teleport[i] == "timer_on") {
                            level.teleport[i] = "active";
                            level.var_69cf0939++;
                            level flag::set("teleporter_pad_link_" + level.var_69cf0939);
                            level thread zm_factory::function_5369a434("vox_maxis_teleporter_" + i + "active_0");
                            level util::delay(10, undefined, &zm_audio::sndmusicsystem_playstate, "teleporter_" + level.var_69cf0939);
                            exploder::exploder("teleporter_" + level.var_ed70cfe7[i] + "_linked");
                            exploder::exploder("lgt_teleporter_" + level.var_ed70cfe7[i] + "_linked");
                            exploder::exploder_duration("mainframe_steam", 14.6);
                            if (level.var_69cf0939 == 3) {
                                exploder::exploder_duration("mainframe_link_all", 4.6);
                                exploder::exploder("mainframe_ambient");
                                level util::clientnotify("pap1");
                                function_c1021075("linkall", trigger);
                                earthquake(0.3, 2, trigger.origin, 3700);
                            }
                            pad = "trigger_teleport_pad_" + i;
                            var_de0bda1 = getent(pad, "targetname");
                            var_de0bda1 function_b7fb6a59();
                            level util::clientnotify("TRs");
                            level.var_65513821 = -1;
                        }
                    }
                }
            }
            wait(0.05);
        }
    }
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_b7fb6a59
// Checksum 0xedb4d5c3, Offset: 0x2ab0
// Size: 0x80
function function_b7fb6a59() {
    self notify(#"hash_b7fb6a59");
    level notify(#"hash_b7fb6a59");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] notify(#"hash_b7fb6a59");
    }
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_f3a68d87
// Checksum 0x7d903a8d, Offset: 0x2b38
// Size: 0x72
function function_f3a68d87() {
    if (isdefined(level.teleport)) {
        for (i = 0; i < level.teleport.size; i++) {
            if (isdefined(level.teleport[i])) {
                if (level.teleport[i] == "timer_on") {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_aabb419a
// Checksum 0x12fd169c, Offset: 0x2bb8
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

// Namespace namespace_4c372a0
// Params 2, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_40b54710
// Checksum 0xf4b7a4ca, Offset: 0x2c90
// Size: 0x17e
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
        if (!zombies[i].isdog) {
            zombies[i] zombie_utility::zombie_head_gib();
        }
        zombies[i] dodamage(10000, zombies[i].origin);
        playsoundatposition("nuked", zombies[i].origin);
    }
}

// Namespace namespace_4c372a0
// Params 2, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_c1021075
// Checksum 0x22e4a439, Offset: 0x2e18
// Size: 0x140
function function_c1021075(var_2ae83290, location) {
    if (!isdefined(location)) {
        self thread function_9113fdce(var_2ae83290, 2);
        return;
    }
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (distance(players[i].origin, location.origin) < 64) {
            switch (var_2ae83290) {
            case 72:
                players[i] thread function_9113fdce("tele_linkall");
                break;
            case 30:
                players[i] thread function_9113fdce("tele_count", 3);
                break;
            }
        }
    }
}

// Namespace namespace_4c372a0
// Params 2, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_9113fdce
// Checksum 0x5fe4ebab, Offset: 0x2f60
// Size: 0x2c
function function_9113fdce(var_58d36ef3, var_edba2860) {
    if (!isdefined(var_edba2860)) {
        var_edba2860 = 0;
    }
    wait(var_edba2860);
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_9c2f8bc2
// Checksum 0x8a4c7ac1, Offset: 0x2f98
// Size: 0xb0
function function_9c2f8bc2() {
    level endon(#"hash_8a65419b");
    while (true) {
        who = self waittill(#"trigger");
        if (level flag::get("power_on")) {
            who thread function_9113fdce("tele_help");
            level notify(#"hash_8a65419b");
        }
        while (isdefined(who) && who istouching(self)) {
            wait(0.1);
        }
    }
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_4035141c
// Checksum 0x7d45dfc9, Offset: 0x3050
// Size: 0x5c
function function_4035141c() {
    wait(10);
    if (!level flag::get("teleporter_pad_link_3")) {
        who = self waittill(#"trigger");
        who thread function_9113fdce("perk_packa_see");
    }
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_602be549
// Checksum 0xae12c567, Offset: 0x30b8
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

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_77a0f55b
// Checksum 0x50d9b2, Offset: 0x3180
// Size: 0x9a
function function_77a0f55b() {
    if (getdvarstring("factoryAftereffectOverride") == "-1") {
        self thread [[ level.teleport_ae_funcs[randomint(level.teleport_ae_funcs.size)] ]]();
        return;
    }
    self thread [[ level.teleport_ae_funcs[int(getdvarstring("factoryAftereffectOverride"))] ]]();
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_ef0e774f
// Checksum 0x509b45fb, Offset: 0x3228
// Size: 0x44
function function_ef0e774f() {
    println("overlay");
    self shellshock("explosion", 4);
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_fd27ac1b
// Checksum 0xe24ffd95, Offset: 0x3278
// Size: 0x44
function function_fd27ac1b() {
    println("overlay");
    self shellshock("electrocution", 4);
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_f710e21c
// Checksum 0xeaf2bad, Offset: 0x32c8
// Size: 0x24
function function_f710e21c() {
    util::setclientsysstate("levelNotify", "tae", self);
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_340c1c45
// Checksum 0x9c685e9, Offset: 0x32f8
// Size: 0x2c
function function_340c1c45(localclientnum) {
    util::setclientsysstate("levelNotify", "tae", self);
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_2c0612f7
// Checksum 0x3d87ea37, Offset: 0x3330
// Size: 0x2c
function function_2c0612f7(localclientnum) {
    util::setclientsysstate("levelNotify", "tae", self);
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_5716654b
// Checksum 0x715742, Offset: 0x3368
// Size: 0x2c
function function_5716654b(localclientnum) {
    util::setclientsysstate("levelNotify", "tae", self);
}

// Namespace namespace_4c372a0
// Params 1, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_9fcee6e8
// Checksum 0x3646d2a3, Offset: 0x33a0
// Size: 0x2c
function function_9fcee6e8(localclientnum) {
    util::setclientsysstate("levelNotify", "tae", self);
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_ac5b8a1b
// Checksum 0x934b1147, Offset: 0x33d8
// Size: 0x76
function function_ac5b8a1b() {
    while (!level flag::get("teleporter_pad_link_3")) {
        rand = randomintrange(4, 16);
        self playsound("evt_packa_door_hitch");
        wait(rand);
    }
}

// Namespace namespace_4c372a0
// Params 0, eflags: 0x1 linked
// namespace_4c372a0<file_0>::function_a759ee63
// Checksum 0x1b2c580b, Offset: 0x3458
// Size: 0xf4
function function_a759ee63() {
    collision = spawn("script_model", (-106, -2294, -40));
    collision setmodel("collision_wall_128x128x10");
    collision.angles = (0, 37.2, 0);
    collision hide();
    collision = spawn("script_model", (-1208, -439, 363));
    collision setmodel("collision_wall_128x128x10");
    collision.angles = (0, 0, 0);
    collision hide();
}

