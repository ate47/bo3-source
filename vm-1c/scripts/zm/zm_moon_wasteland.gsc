#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_dogs;
#using scripts/zm/_zm_equip_hacker;
#using scripts/zm/_zm_hackables_perks;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_moon_teleporter;

#namespace zm_moon_wasteland;

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0xd6f064a, Offset: 0x538
// Size: 0x314
function function_884440ef() {
    level flag::init("enter_nml");
    level flag::init("teleporter_used");
    level flag::init("start_supersprint");
    level flag::init("between_rounds");
    level flag::init("teleported_to_nml");
    var_cd70fc20 = getentarray("nml_area1_spawners", "targetname");
    var_3f786b5b = getentarray("nml_area2_spawners", "targetname");
    array::thread_all(var_cd70fc20, &spawner::add_spawn_function, &zm_spawner::zombie_spawn_init);
    array::thread_all(var_cd70fc20, &spawner::add_spawn_function, &zombie_utility::round_spawn_failsafe);
    array::thread_all(var_3f786b5b, &spawner::add_spawn_function, &zm_spawner::zombie_spawn_init);
    array::thread_all(var_3f786b5b, &spawner::add_spawn_function, &zombie_utility::round_spawn_failsafe);
    level.var_5f225972 = 0;
    level.var_a4d659b6 = 0;
    level.initial_spawn = 1;
    level.var_63a990b5 = 0;
    level.var_f74ebab2 = 100;
    level._effect["lightning_dog_spawn"] = "zombie/fx_dog_lightning_buildup_zmb";
    function_c60b0756();
    zm_zonemgr::zone_init("nml_zone");
    zm_moon_teleporter::function_986fd39c();
    ent = getent("nml_dogs_volume", "targetname");
    ent thread function_d1f14a0d();
    level.var_5bc8eb7b = 0;
    function_5e5b8f49();
    level.var_96653785 = -1;
    level thread function_5086f101();
    level thread zm_moon_teleporter::function_6454df1b();
    level.var_73779694 = 2000;
    level.var_dce9c91d = 1024;
    level.var_e7251657 = 5760000;
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0xf2762ca9, Offset: 0x858
// Size: 0x9c
function function_5086f101() {
    level flag::wait_till("begin_spawning");
    level thread function_eaa8b4ed();
    level thread zm_moon_teleporter::function_78f5cb79();
    teleporter = getent("generator_teleporter", "targetname");
    zm_moon_teleporter::function_cf379b01(teleporter, 0);
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0xeb51d92a, Offset: 0x900
// Size: 0x24
function function_eaa8b4ed() {
    level.var_d0368f1e = 0;
    wait 30;
    level.var_d0368f1e = 1;
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0x80753610, Offset: 0x930
// Size: 0xbc
function function_1b79fc40() {
    if (isdefined(level.round_number)) {
        if (level flag::get("between_rounds")) {
            level.var_267b8fc0 = level.round_number + 1;
            level.var_f128ba27 = [[ level.max_zombie_func ]](level.zombie_vars["zombie_max_ai"]);
        } else {
            level.var_267b8fc0 = level.round_number;
        }
    } else {
        level.var_267b8fc0 = 1;
    }
    level.round_spawn_func = &function_a1461bd7;
    function_6d2087e4(level.var_267b8fc0);
}

// Namespace zm_moon_wasteland
// Params 1, eflags: 0x0
// Checksum 0x408ebb49, Offset: 0x9f8
// Size: 0xf2
function function_fcb42941(volume) {
    players = getplayers();
    var_15a6c4a3 = 0;
    for (i = 0; i < players.size; i++) {
        ent = players[i];
        if (!isalive(ent) || !isplayer(ent) || ent.sessionstate == "spectator") {
            continue;
        }
        if (ent istouching(volume)) {
            var_15a6c4a3++;
        }
    }
    return var_15a6c4a3;
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0xa8e9e154, Offset: 0xaf8
// Size: 0x38
function function_d1f14a0d() {
    while (true) {
        level.var_5bc8eb7b = function_fcb42941(self);
        wait 1.3;
    }
}

// Namespace zm_moon_wasteland
// Params 6, eflags: 0x0
// Checksum 0x2f1fb5ac, Offset: 0xb38
// Size: 0x88
function init_hint_hudelem(x, y, alignx, aligny, fontscale, alpha) {
    self.x = x;
    self.y = y;
    self.alignx = alignx;
    self.aligny = aligny;
    self.fontscale = fontscale;
    self.alpha = alpha;
    self.sort = 20;
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0xef3b4106, Offset: 0xbc8
// Size: 0xb0
function function_c60b0756() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        player.var_e742bbb5 = function_25deb972(player);
        player.var_e742bbb5 settext(%NULL_EMPTY);
    }
    level.var_ca23fc25 = 0;
}

// Namespace zm_moon_wasteland
// Params 1, eflags: 0x0
// Checksum 0xd5b94683, Offset: 0xc80
// Size: 0x70
function function_25deb972(player) {
    var_e742bbb5 = newclienthudelem(player);
    var_e742bbb5 init_hint_hudelem(320, -116, "center", "bottom", 1.6, 1);
    return var_e742bbb5;
}

// Namespace zm_moon_wasteland
// Params 1, eflags: 0x0
// Checksum 0x7107694, Offset: 0xcf8
// Size: 0xc
function function_cc61ff9a(message) {
    
}

// Namespace zm_moon_wasteland
// Params 1, eflags: 0x0
// Checksum 0x83a0e7f8, Offset: 0xd10
// Size: 0x1d4
function function_6d2087e4(target_round) {
    zombies = getaiarray();
    if (isdefined(zombies)) {
        for (i = 0; i < zombies.size; i++) {
            if (isdefined(zombies[i].var_e5e875ef) && zombies[i].var_e5e875ef) {
                continue;
            }
            if (isdefined(zombies[i].var_d98ae1ca)) {
                zombies[i].var_d98ae1ca delete();
            }
            zombies[i] zombie_utility::reset_attack_spot();
            zombies[i] notify(#"zombie_delete");
            zombies[i] delete();
        }
    }
    level.zombie_health = level.zombie_vars["zombie_health_start"];
    zombie_utility::ai_calculate_health(level.var_267b8fc0);
    level.zombie_total = 0;
    zm::set_round_number(level.var_267b8fc0);
    level.round_number = zm::get_round_number();
    level.var_3b18dd9 = " ";
    level thread function_4230ab0();
    level waittill(#"between_round_over");
    if (isdefined(level.var_3b18dd9)) {
    }
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0x6dc56176, Offset: 0xef0
// Size: 0x4c
function function_4230ab0() {
    level endon(#"restart_round");
    while (isdefined(level.var_3b18dd9)) {
        if (isdefined(level.var_3b18dd9)) {
            if (isdefined(level.var_4a0303e9)) {
            }
            if (isdefined(level.var_70057e52)) {
            }
        }
        wait 1;
    }
}

// Namespace zm_moon_wasteland
// Params 1, eflags: 0x0
// Checksum 0xb544db29, Offset: 0xf48
// Size: 0x20e
function function_d694caf4(target_round) {
    if (target_round < 1) {
        target_round = 1;
    }
    level.var_3b18dd9 = undefined;
    level.zombie_health = level.zombie_vars["zombie_health_start"];
    level.zombie_total = 0;
    zombie_utility::ai_calculate_health(target_round);
    level notify(#"restart_round");
    level.var_49486970 = 1;
    zombies = getaispeciesarray(level.zombie_team, "all");
    if (isdefined(zombies)) {
        for (i = 0; i < zombies.size; i++) {
            if (isdefined(zombies[i].var_e5e875ef) && zombies[i].var_e5e875ef) {
                continue;
            }
            if (zombies[i].isdog) {
                zombies[i] dodamage(zombies[i].health + 10, zombies[i].origin);
                continue;
            }
            if (isdefined(zombies[i].var_d98ae1ca)) {
                zombies[i].var_d98ae1ca delete();
            }
            zombies[i] zombie_utility::reset_attack_spot();
            zombies[i] notify(#"zombie_delete");
            zombies[i] delete();
        }
    }
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0x29e13313, Offset: 0x1160
// Size: 0x950
function function_a1461bd7() {
    level endon(#"restart_round");
    level.dog_targets = getplayers();
    for (i = 0; i < level.dog_targets.size; i++) {
        level.dog_targets[i].hunted_by = 0;
    }
    level.var_e55cd01d = gettime();
    var_1f9a4153 = 2000;
    var_fb0cf2ca = -10000;
    var_40443086 = 3000;
    var_3dbd8408 = 9500;
    var_326193de = 25000;
    var_1df966b3 = 2100;
    var_f2e5a4af = 35000;
    cooldown_time = 16000;
    var_6873bfb7 = 26000;
    var_728eaa61 = 20;
    var_ebc056f9 = level.var_e55cd01d + var_326193de;
    mode = "normal_spawning";
    area = 1;
    level thread function_69673721();
    while (true) {
        current_time = gettime();
        var_9dd37d09 = 0;
        zombies = getaispeciesarray(level.zombie_team, "all");
        while (zombies.size >= var_728eaa61) {
            zombies = getaispeciesarray(level.zombie_team, "all");
            wait 0.5;
        }
        switch (mode) {
        case "normal_spawning":
            if (level.initial_spawn == 1) {
                spawn_a_zombie(10, "nml_zone_spawner", 0.01, 1);
            } else {
                ai = spawn_a_zombie(var_728eaa61, "nml_zone_spawner", 0.01, 1);
                if (isdefined(ai)) {
                    move_speed = "sprint";
                    if (level flag::get("start_supersprint")) {
                        move_speed = "super_sprint";
                    }
                    ai function_3eb8ebf9(move_speed);
                    if (isdefined(ai.var_b5a92f62)) {
                        ai.var_b5a92f62 = move_speed;
                    }
                }
            }
            if (current_time > var_ebc056f9) {
                var_ebc056f9 = current_time + var_1df966b3;
                mode = "preparing_spawn_wave";
                level thread function_c3a00f2(var_ebc056f9);
            }
            break;
        case "preparing_spawn_wave":
            zombies = getaispeciesarray(level.zombie_team);
            for (i = 0; i < zombies.size; i++) {
                if (!zombies[i].missinglegs && zombies[i].animname == "zombie") {
                    move_speed = "sprint";
                    if (level flag::get("start_supersprint")) {
                        move_speed = "super_sprint";
                    }
                    zombies[i] zombie_utility::set_zombie_run_cycle(move_speed);
                    level.initial_spawn = 0;
                    level notify(#"hash_d3411c2");
                    if (isdefined(zombies[i].var_b5a92f62)) {
                        zombies[i].var_b5a92f62 = move_speed;
                    }
                }
            }
            if (current_time > var_ebc056f9) {
                level notify(#"hash_f6e04283");
                mode = "spawn_wave_active";
                if (area == 1) {
                    area = 2;
                    level thread function_210401f1(var_728eaa61, "nml_area2_spawners");
                } else {
                    area = 1;
                    level thread function_210401f1(var_728eaa61, "nml_area1_spawners");
                }
                var_ebc056f9 = current_time + var_f2e5a4af;
            }
            var_9dd37d09 = 0.1;
            break;
        case "spawn_wave_active":
            if (current_time < var_ebc056f9) {
                if (randomfloatrange(0, 1) < 0.05) {
                    ai = spawn_a_zombie(var_728eaa61, "nml_zone_spawner", 0.01, 1);
                    if (isdefined(ai)) {
                        ai.var_a7d1d70c = 1;
                        move_speed = "sprint";
                        if (level flag::get("start_supersprint")) {
                            move_speed = "super_sprint";
                        }
                        ai function_3eb8ebf9(move_speed);
                        if (isdefined(ai.var_b5a92f62)) {
                            ai.var_b5a92f62 = move_speed;
                        }
                    }
                }
            } else {
                level notify(#"hash_2b5925c6");
                mode = "wave_finished_cooldown";
                var_ebc056f9 = current_time + cooldown_time;
            }
            break;
        case "wave_finished_cooldown":
            if (current_time > var_ebc056f9) {
                var_ebc056f9 = current_time + var_6873bfb7;
                mode = "normal_spawning";
            }
            var_9dd37d09 = 0.01;
            break;
        }
        var_f759844f = 0;
        if (current_time - level.var_e55cd01d > var_1f9a4153) {
            var_e6ffb226 = 0;
            players = getplayers();
            if (players.size <= 1) {
                dt = current_time - var_fb0cf2ca;
                if (dt < 0) {
                    var_e6ffb226 = 1;
                } else {
                    var_fb0cf2ca = current_time + randomfloatrange(var_40443086, var_3dbd8408);
                }
            }
            if (mode == "preparing_spawn_wave") {
                var_e6ffb226 = 1;
            }
            if (!var_e6ffb226 && level.var_d0368f1e == 1) {
                var_f759844f = level.var_5bc8eb7b;
                if (var_f759844f) {
                    dogs = getaispeciesarray(level.zombie_team, "zombie_dog");
                    var_f759844f *= 2;
                    if (dogs.size < var_f759844f) {
                        ai = zm_ai_dogs::function_6fafe689();
                        var_21d456c7 = getaispeciesarray(level.zombie_team, "zombie_dog");
                        if (isdefined(var_21d456c7)) {
                            for (i = 0; i < var_21d456c7.size; i++) {
                                var_21d456c7[i].maxhealth = int(level.var_f74ebab2);
                                var_21d456c7[i].health = int(level.var_f74ebab2);
                            }
                        }
                    }
                }
            }
        }
        if (var_9dd37d09 != 0) {
            wait var_9dd37d09;
            continue;
        }
        wait randomfloatrange(0.1, 0.8);
    }
}

// Namespace zm_moon_wasteland
// Params 1, eflags: 0x0
// Checksum 0x9b1f0938, Offset: 0x1ab8
// Size: 0x84
function function_3eb8ebf9(move_speed) {
    self endon(#"death");
    time = gettime();
    while (true) {
        if (isdefined(self.zombie_init_done) && self.zombie_init_done) {
            break;
        }
        if (gettime() > time + 500) {
            break;
        }
        wait 0.05;
    }
    self zombie_utility::set_zombie_run_cycle(move_speed);
}

// Namespace zm_moon_wasteland
// Params 2, eflags: 0x0
// Checksum 0x253fb15c, Offset: 0x1b48
// Size: 0x160
function function_210401f1(var_f2e71509, var_c194e88d) {
    level endon(#"hash_2b5925c6");
    level endon(#"restart_round");
    while (true) {
        zombies = getaispeciesarray(level.zombie_team, "all");
        if (zombies.size < var_f2e71509) {
            ai = spawn_a_zombie(var_f2e71509, var_c194e88d, 0.01, 1);
            if (isdefined(ai)) {
                ai.var_a7d1d70c = 1;
                move_speed = "sprint";
                if (level flag::get("start_supersprint")) {
                    move_speed = "super_sprint";
                }
                ai function_3eb8ebf9(move_speed);
                if (isdefined(ai.var_b5a92f62)) {
                    ai.var_b5a92f62 = move_speed;
                }
            }
        }
        wait randomfloatrange(0.3, 1);
    }
}

// Namespace zm_moon_wasteland
// Params 4, eflags: 0x0
// Checksum 0x678b6b69, Offset: 0x1cb0
// Size: 0x18c
function spawn_a_zombie(var_728eaa61, var_c194e88d, wait_delay, var_cd0301af) {
    zombies = getaispeciesarray(level.zombie_team);
    if (zombies.size >= var_728eaa61) {
        return undefined;
    }
    var_71aee853 = getentarray("nml_zone_spawner", "targetname");
    e_spawner = array::random(var_71aee853);
    var_50f2968b = struct::get_array(var_c194e88d, "targetname");
    s_spawn_loc = array::random(var_50f2968b);
    ai = zombie_utility::spawn_zombie(e_spawner, var_c194e88d, s_spawn_loc);
    if (isdefined(ai)) {
        if (isdefined(var_cd0301af) && var_cd0301af) {
            ai.var_a7d1d70c = 1;
        }
        if (isdefined(level.var_ce1cee99) && level.var_ce1cee99) {
            ai.var_a1c47c25 = &function_d94d6b87;
            ai.var_5d7f396c = [];
        }
    }
    return ai;
}

// Namespace zm_moon_wasteland
// Params 1, eflags: 0x0
// Checksum 0xd14d700f, Offset: 0x1e48
// Size: 0x92
function function_c3a00f2(var_ebc056f9) {
    level endon(#"hash_f6e04283");
    level endon(#"restart_round");
    for (time = 0; time < var_ebc056f9; time = gettime()) {
        level thread function_4b533fbd();
        wait_time = randomfloatrange(0.25, 0.35);
        wait wait_time;
    }
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0x51905871, Offset: 0x1ee8
// Size: 0x156
function function_4b533fbd() {
    var_8efd8cc8 = 0;
    players = getplayers();
    pos = (0, 0, 0);
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (zombie_utility::is_player_valid(player)) {
            pos += player.origin;
            var_8efd8cc8++;
        }
    }
    if (!var_8efd8cc8) {
        return;
    }
    var_a8f5c16d = (pos[0] / var_8efd8cc8, pos[1] / var_8efd8cc8, pos[2] / var_8efd8cc8);
    thread function_2747b8e1("damage_heavy");
    scale = 0.4;
    duration = 1;
    radius = 16800;
}

// Namespace zm_moon_wasteland
// Params 5, eflags: 0x0
// Checksum 0xc92d6f51, Offset: 0x2048
// Size: 0x15e
function function_2747b8e1(var_b1959c71, var_8221d0bd, var_58e4d11d, var_6425fdcd, var_8681ab1) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(var_6425fdcd) && isdefined(var_8681ab1) && isdefined(var_58e4d11d)) {
            if (distance(players[i].origin, var_58e4d11d) < var_6425fdcd) {
                players[i] playrumbleonentity(var_b1959c71);
            } else if (distance(players[i].origin, var_58e4d11d) < var_8681ab1) {
                players[i] playrumbleonentity(var_8221d0bd);
            }
            continue;
        }
        players[i] playrumbleonentity(var_b1959c71);
    }
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0xeb639e61, Offset: 0x21b0
// Size: 0xb4
function function_5e5b8f49() {
    var_212a84d3 = struct::get("nml_perk_location_helper", "script_noteworthy");
    var_6967f2d5 = 4200;
    level.var_e7398c7f = function_3511c0e6("vending_sleight", "speedcola_perk", var_212a84d3.origin, var_6967f2d5);
    level.var_a8dfd91d = function_3511c0e6("vending_jugg", "jugg_perk", var_212a84d3.origin, var_6967f2d5);
}

// Namespace zm_moon_wasteland
// Params 4, eflags: 0x0
// Checksum 0x2f2d7972, Offset: 0x2270
// Size: 0x1ee
function function_3511c0e6(var_dd4a2a, var_b51b785f, var_c8582f65, var_20b120f) {
    names = [];
    names[0] = var_dd4a2a;
    names[1] = "zombie_vending";
    ent_array = [];
    for (i = 0; i < names.size; i++) {
        ents = getentarray(names[i], "targetname");
        for (j = 0; j < ents.size; j++) {
            ent = ents[j];
            if (isdefined(ent.script_string) && ent.script_string == var_b51b785f) {
                if (abs(var_c8582f65[0] - ent.origin[0]) < var_20b120f && abs(var_c8582f65[1] - ent.origin[1]) < var_20b120f && abs(var_c8582f65[2] - ent.origin[2]) < var_20b120f) {
                    ent_array[ent_array.size] = ent;
                }
            }
        }
    }
    return ent_array;
}

// Namespace zm_moon_wasteland
// Params 3, eflags: 0x0
// Checksum 0xf1ed20a9, Offset: 0x2468
// Size: 0x15c
function function_3cd89969(dist, time, accel) {
    ent = level.var_e7398c7f[0];
    pos = (ent.origin[0], ent.origin[1], ent.origin[2] + dist);
    ent moveto(pos, time, accel, accel);
    level.var_e7398c7f[1] triggerenable(0);
    ent = level.var_a8dfd91d[0];
    pos = (ent.origin[0], ent.origin[1], ent.origin[2] + dist);
    ent moveto(pos, time, accel, accel);
    level.var_a8dfd91d[1] triggerenable(0);
}

// Namespace zm_moon_wasteland
// Params 3, eflags: 0x0
// Checksum 0x1c322213, Offset: 0x25d0
// Size: 0x29c
function function_d7a504c5(cola, jug, moving) {
    if (!isdefined(moving)) {
        moving = 0;
    }
    if (cola) {
        level.var_e7398c7f[0] hide();
    } else {
        level.var_e7398c7f[0] show();
    }
    if (jug) {
        level.var_a8dfd91d[0] hide();
    } else {
        level.var_a8dfd91d[0] show();
    }
    if (moving) {
        level.var_e7398c7f[1] triggerenable(0);
        level.var_a8dfd91d[1] triggerenable(0);
        if (isdefined(level.var_e7398c7f[1].hackable)) {
            zm_equip_hacker::function_fcbe2f17(level.var_e7398c7f[1].hackable);
        }
        if (isdefined(level.var_a8dfd91d[1].hackable)) {
            zm_equip_hacker::function_fcbe2f17(level.var_a8dfd91d[1].hackable);
        }
        return;
    }
    hackable = undefined;
    if (cola) {
        level.var_a8dfd91d[1] triggerenable(1);
        if (isdefined(level.var_a8dfd91d[1].hackable)) {
            hackable = level.var_a8dfd91d[1].hackable;
        }
    } else {
        level.var_e7398c7f[1] triggerenable(1);
        if (isdefined(level.var_e7398c7f[1].hackable)) {
            hackable = level.var_e7398c7f[1].hackable;
        }
    }
    zm_equip_hacker::function_66764564(hackable, &namespace_75cc53cb::function_b4d7ca0b, &namespace_75cc53cb::function_194e8dfe);
}

// Namespace zm_moon_wasteland
// Params 2, eflags: 0x0
// Checksum 0xd3d69435, Offset: 0x2878
// Size: 0x76
function function_ee0803e7(var_441885c4, moving) {
    switch (var_441885c4) {
    case 0:
        function_d7a504c5(0, 1, moving);
        break;
    case 1:
        function_d7a504c5(1, 0, moving);
        break;
    }
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0x521c7385, Offset: 0x28f8
// Size: 0x1ec
function function_36db1e4f() {
    top_height = 1200;
    fall_time = 4;
    var_ba2f8dac = 20;
    var_441885c4 = randomintrange(0, 2);
    ent = level.var_e7398c7f[0];
    level thread function_6c558342(ent.origin);
    function_3cd89969(top_height, 0.01, 0.001);
    wait 0.3;
    function_d7a504c5(0, 0, 1);
    wait 1;
    function_3cd89969(top_height * -1, fall_time, 1.5);
    var_82a5f74b = fall_time / var_ba2f8dac;
    for (i = 0; i < var_ba2f8dac; i++) {
        function_ee0803e7(var_441885c4, 1);
        wait var_82a5f74b;
        var_441885c4++;
        if (var_441885c4 > 1) {
            var_441885c4 = 0;
        }
    }
    while (var_441885c4 == level.var_96653785) {
        var_441885c4 = randomintrange(0, 2);
    }
    level.var_96653785 = var_441885c4;
    function_ee0803e7(var_441885c4, 0);
}

// Namespace zm_moon_wasteland
// Params 1, eflags: 0x0
// Checksum 0x13c07103, Offset: 0x2af0
// Size: 0xac
function function_6c558342(pos) {
    wait 0.15;
    playfx(level._effect["lightning_dog_spawn"], pos);
    playsoundatposition("zmb_hellhound_bolt", pos);
    wait 1.1;
    playfx(level._effect["lightning_dog_spawn"], pos);
    playsoundatposition("zmb_hellhound_bolt", pos);
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0x396c1ed4, Offset: 0x2ba8
// Size: 0x88
function function_69673721() {
    wait 2;
    level endon(#"restart_round");
    while (level flag::get("enter_nml")) {
        zombies = getaispeciesarray(level.zombie_team, "all");
        if (zombies.size >= 2) {
            level.zombie_total = 100;
            return;
        }
        wait 1;
    }
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0x21f8672, Offset: 0x2c38
// Size: 0x28
function function_a3faf371() {
    level.var_ce1cee99 = 0;
    level waittill(#"hash_f6e04283");
    level.var_ce1cee99 = 1;
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0x14193e0d, Offset: 0x2c68
// Size: 0x388
function function_5bde87b7() {
    self endon(#"hash_ada028f0");
    level waittill(#"hash_d3411c2");
    level.var_7c33b564 = level.var_267b8fc0;
    while (level flag::get("enter_nml")) {
        if (!level.var_5f225972) {
            level.var_7c33b564++;
            level thread zm_utility::play_sound_2d("evt_nomans_warning");
            zombies = getaispeciesarray(level.zombie_team, "zombie");
            for (i = 0; i < zombies.size; i++) {
                if (isdefined(zombies[i].head_gibbed) && (isdefined(zombies[i].gibbed) && (zombies[i].health != level.zombie_health || zombies[i].gibbed) || zombies[i].head_gibbed)) {
                    arrayremovevalue(zombies, zombies[i]);
                }
            }
            zombie_utility::ai_calculate_health(level.var_7c33b564);
            for (i = 0; i < zombies.size; i++) {
                if (isdefined(zombies[i].head_gibbed) && (isdefined(zombies[i].gibbed) && zombies[i].gibbed || zombies[i].head_gibbed)) {
                    continue;
                }
                zombies[i].health = level.zombie_health;
                if (isdefined(level.var_ce1cee99) && level.var_ce1cee99) {
                    zombies[i].var_a1c47c25 = &function_d94d6b87;
                    zombies[i].var_5d7f396c = [];
                }
            }
            level thread function_efebdfd9();
            var_21d456c7 = getaispeciesarray(level.zombie_team, "zombie_dog");
            if (isdefined(var_21d456c7)) {
                for (i = 0; i < var_21d456c7.size; i++) {
                    var_21d456c7[i].maxhealth = int(level.var_f74ebab2);
                    var_21d456c7[i].health = int(level.var_f74ebab2);
                }
            }
        }
        if (level.var_7c33b564 == 6) {
            level flag::set("start_supersprint");
        }
        wait 20;
    }
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0xb87f4f5d, Offset: 0x2ff8
// Size: 0xd0
function function_efebdfd9() {
    if (level.var_7c33b564 < 4) {
        level.var_f74ebab2 = 100;
        return;
    }
    if (level.var_7c33b564 >= 4 && level.var_7c33b564 < 6) {
        level.var_f74ebab2 = 400;
        return;
    }
    if (level.var_7c33b564 >= 6 && level.var_7c33b564 < 15) {
        level.var_f74ebab2 = 800;
        return;
    }
    if (level.var_7c33b564 >= 15 && level.var_7c33b564 < 30) {
        level.var_f74ebab2 = 1200;
        return;
    }
    if (level.var_7c33b564 >= 30) {
        level.var_f74ebab2 = 1600;
    }
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0xa5a5b073, Offset: 0x30d0
// Size: 0x2e
function function_d94d6b87() {
    if (self function_e37869c6()) {
        return "step";
    }
    return "none";
}

// Namespace zm_moon_wasteland
// Params 0, eflags: 0x0
// Checksum 0xb04ede6e, Offset: 0x3108
// Size: 0x12c
function function_e37869c6() {
    if (gettime() - self.a.var_e9e7350d < level.var_73779694) {
        return false;
    }
    if (!isdefined(self.enemy)) {
        return false;
    }
    if (self.a.pose != "stand") {
        return false;
    }
    var_4d1b293b = distancesquared(self.origin, self.enemy.origin);
    if (var_4d1b293b < level.var_dce9c91d) {
        return false;
    }
    if (var_4d1b293b > level.var_e7251657) {
        return false;
    }
    if (!isdefined(self.pathgoalpos) || distancesquared(self.origin, self.pathgoalpos) < level.var_dce9c91d) {
        return false;
    }
    if (abs(self getmotionangle()) > 15) {
        return false;
    }
    return true;
}

