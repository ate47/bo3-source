#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_gibs;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/util_shared;

#namespace namespace_cdb9a8fe;

// Namespace namespace_cdb9a8fe
// Params 0, eflags: 0x4
// Checksum 0xf3d360ad, Offset: 0x400
// Size: 0x221
function private function_542758d0() {
    level.doa.var_f5e35752 = [];
    level.doa.var_5a609640 = [];
    challenges = struct::get_array("doa_challenge_def");
    for (i = 0; i < challenges.size; i++) {
        var_d0cde02c = challenges[i];
        var_72085a07 = spawnstruct();
        var_72085a07.spawner = getent(var_d0cde02c.target, "targetname");
        var_72085a07.spawner.var_d0cde02c = var_d0cde02c;
        assert(isdefined(var_d0cde02c.script_noteworthy));
        var_72085a07.number = int(var_d0cde02c.script_noteworthy);
        if (isdefined(level.doa.var_d18af0d)) {
            [[ level.doa.var_d18af0d ]](var_72085a07);
        }
        if (!isdefined(var_72085a07.round)) {
            var_72085a07.round = var_72085a07.number * 4 + 4;
        }
        if (!isdefined(var_72085a07.spawnchance)) {
            var_72085a07.spawnchance = level.doa.rules.var_c53b19d1;
        }
        if (!isdefined(var_72085a07.var_84aef63e)) {
            var_72085a07.var_84aef63e = level.doa.rules.var_1faeb8d5;
        }
        if (!isdefined(var_72085a07.spawnfunc)) {
            var_72085a07.spawnfunc = &doa_enemy::function_a4e16560;
        }
        if (!isdefined(var_72085a07.var_83bae1f8)) {
            var_72085a07.var_83bae1f8 = level.doa.rules.var_466591b1;
        }
        level.doa.var_5a609640[level.doa.var_5a609640.size] = var_72085a07;
    }
}

// Namespace namespace_cdb9a8fe
// Params 1, eflags: 0x4
// Checksum 0x9a9c2e94, Offset: 0x630
// Size: 0x65
function private function_e4d3cd1d(round) {
    for (i = 0; i < level.doa.var_5a609640.size; i++) {
        if (level.doa.var_5a609640[i].round == round) {
            return level.doa.var_5a609640[i];
        }
    }
}

// Namespace namespace_cdb9a8fe
// Params 0, eflags: 0x4
// Checksum 0xa996a2a4, Offset: 0x6a0
// Size: 0x14c
function private function_5f5d09ae() {
    def = function_e4d3cd1d(level.doa.round_number);
    if (!isdefined(def)) {
        return;
    }
    level thread namespace_49107f3a::function_c5f3ece8(%DOA_CHALLENGE, undefined, 6, (1, 0, 0));
    level.voice playsound("vox_doaa_challenge_round");
    level thread namespace_49107f3a::function_37fb5c23(def.title, undefined, 5, (1, 0, 0));
    level.doa.var_d0cde02c = def;
    if (isdefined(def.var_84aef63e)) {
        if (isdefined(def.var_3ceda880) && def.var_3ceda880) {
            level.doa.rules.max_enemy_count = def.var_84aef63e;
        }
        if (level.doa.rules.max_enemy_count < def.var_84aef63e) {
            level.doa.rules.max_enemy_count = def.var_84aef63e;
        }
    }
    if (isdefined(def.var_965be9)) {
        level thread [[ def.var_965be9 ]](def);
    }
}

// Namespace namespace_cdb9a8fe
// Params 0, eflags: 0x0
// Checksum 0xa246f616, Offset: 0x7f8
// Size: 0xe1
function function_691ef36b() {
    level.doa.var_c838db72 = [];
    spawners = getentarray("doa_basic_spawner", "targetname");
    for (i = 0; i < spawners.size; i++) {
        if (!isdefined(spawners[i].script_noteworthy)) {
            spawners[i].script_noteworthy = 1;
        }
        if (int(spawners[i].script_noteworthy) <= level.doa.round_number) {
            spawners[i].var_8d1af144 = 1;
            level.doa.var_c838db72[level.doa.var_c838db72.size] = spawners[i];
        }
    }
}

// Namespace namespace_cdb9a8fe
// Params 1, eflags: 0x0
// Checksum 0xee44c358, Offset: 0x8e8
// Size: 0x1bc
function function_c81e1083(name) {
    setname = name + "_enemy_spawn";
    spawners = struct::get_array(setname);
    level.doa.spawners[setname] = [];
    level.doa.spawners[setname]["top"] = [];
    level.doa.spawners[setname]["bottom"] = [];
    level.doa.spawners[setname]["left"] = [];
    level.doa.spawners[setname]["right"] = [];
    for (i = 0; i < spawners.size; i++) {
        side = spawners[i].script_noteworthy;
        size = level.doa.spawners[setname][side].size;
        level.doa.spawners[setname][side][size] = spawners[i];
    }
    level.doa.spawners[setname]["boss"] = struct::get_array(name + "_no_traverse_spawn");
    level.doa.spawners[setname]["wolf"] = struct::get_array(name + "_no_traverse_spawn");
    level.doa.spawners[setname]["skeleton"] = struct::get_array(name + "_no_traverse_spawn");
}

// Namespace namespace_cdb9a8fe
// Params 0, eflags: 0x0
// Checksum 0x159c152c, Offset: 0xab0
// Size: 0x4a5
function main() {
    level endon(#"doa_game_restart");
    foreach (player in getplayers()) {
        player thread namespace_831a4a7c::function_7d7a7fde();
    }
    level thread function_d87cb356();
    function_542758d0();
    function_d9345c74();
    while (!level flag::get("doa_game_is_over")) {
        namespace_49107f3a::debugmsg("Round " + level.doa.round_number + " starting at:" + gettime());
        level.doa.rules.max_enemy_count = namespace_3ca3c537::function_b0e9983(namespace_3ca3c537::function_d2d75f5d());
        level.doa.var_a3a11449 = 0;
        function_5f5d09ae();
        function_691ef36b();
        function_703bb8b2(level.doa.round_number);
        if (isdefined(level.doa.var_c95041ea)) {
            var_ca7f54a6 = level [[ level.doa.var_c95041ea ]]();
        }
        /#
            if (isdefined(level.doa.var_33749c8)) {
                flag::clear("<dev string:x28>");
                namespace_49107f3a::function_f798b582();
                wait 1;
                namespace_49107f3a::function_f798b582();
            }
        #/
        if (!(isdefined(var_ca7f54a6) && var_ca7f54a6)) {
            if (!isdefined(level.doa.var_33749c8)) {
                flag::set("doa_round_active");
                if (isdefined(level.doa.var_d0cde02c)) {
                    level notify(#"hash_ba37290e", "challenge");
                } else {
                    level notify(#"hash_ba37290e");
                }
                function_87703158();
            }
            namespace_49107f3a::function_c157030a();
            waittillframeend();
            level.doa.var_5cd9f23f = gettime();
            namespace_49107f3a::debugmsg("Round " + level.doa.round_number + " ended at:" + level.doa.var_5cd9f23f);
            flag::clear("doa_round_active");
            level notify(#"doa_round_is_over");
            if (level flag::get("doa_game_is_over")) {
                break;
            }
            level.doa.var_b351e5fb = 0;
            while (level flag::get("doa_round_paused")) {
                wait 0.05;
                continue;
            }
            level thread namespace_a7e6beb5::function_22d0e830(0, 3);
            var_d2d5db8a = namespace_3ca3c537::function_78c7b56e();
        } else {
            level waittill(#"bossEventComplete");
        }
        if (level flag::get("doa_game_is_over")) {
            break;
        }
        level.doa.zombie_move_speed += level.doa.var_c9e1c854;
        level.doa.zombie_health += level.doa.var_792b9741;
        level.doa.round_number++;
        level.doa.var_6f2c52d8 = undefined;
        function_d9345c74();
        function_55762a85();
        namespace_d88e3a06::function_7a8a936b();
        if (isdefined(var_d2d5db8a) && var_d2d5db8a) {
            level thread namespace_3ca3c537::function_e88371e5();
        }
        namespace_831a4a7c::function_82e3b1cb();
        level notify(#"hash_31680c6");
        namespace_49107f3a::function_390adefe();
    }
}

// Namespace namespace_cdb9a8fe
// Params 0, eflags: 0x4
// Checksum 0x5ca32c5, Offset: 0xf60
// Size: 0x97
function private function_d87cb356() {
    self notify(#"hash_d87cb356");
    self endon(#"hash_d87cb356");
    level endon(#"doa_game_restart");
    while (!level flag::get("doa_game_is_over")) {
        level.doa.var_5890c17b = 0;
        while (level flag::get("doa_round_active")) {
            wait 1;
        }
        level.doa.var_5890c17b = 1;
        while (!level flag::get("doa_round_active")) {
            wait 1;
        }
    }
}

// Namespace namespace_cdb9a8fe
// Params 1, eflags: 0x0
// Checksum 0x2571e831, Offset: 0x1000
// Size: 0x191
function function_40bfe842(entnum) {
    if (!isdefined(entnum)) {
        entnum = 0;
    }
    if (isdefined(level.doa.var_a3a11449) && level.doa.var_a3a11449) {
        switch (entnum) {
        case 0:
            var_3c70b682 = "top";
            break;
        case 1:
            var_3c70b682 = "bottom";
            break;
        case 2:
            var_3c70b682 = "left";
            break;
        default:
            var_3c70b682 = "right";
            break;
        }
    } else {
        var_3c70b682 = level.doa.var_3f3f577d;
    }
    if (level.doa.var_458c27d != 0) {
        points = level.doa.arenas[level.doa.var_90873830].var_f616a3b7[var_3c70b682];
        if (isdefined(points) && points.size) {
            if (!isdefined(points[entnum])) {
                namespace_49107f3a::debugmsg("MISSING " + level.doa.var_90873830 + "_exit_start_" + level.doa.var_3f3f577d + " for player " + entnum);
                return points[0].origin;
            }
            return points[entnum].origin;
        }
    }
    return namespace_831a4a7c::function_68ece679(entnum).origin;
}

// Namespace namespace_cdb9a8fe
// Params 2, eflags: 0x0
// Checksum 0xf733313, Offset: 0x11a0
// Size: 0x8e
function function_f581d585(point, facepoint) {
    if (isdefined(self.doa.vehicle)) {
        self.doa.vehicle.angles = vectortoangles(facepoint - point);
        self.doa.vehicle.origin = point + (0, 0, 72);
        self.doa.vehicle.groundpos = point;
    }
}

// Namespace namespace_cdb9a8fe
// Params 2, eflags: 0x0
// Checksum 0x9e3ebe0, Offset: 0x1238
// Size: 0x21a
function function_fe0946ac(spawn_origin, var_97887a95) {
    if (!isdefined(var_97887a95)) {
        var_97887a95 = 1;
    }
    self endon(#"disconnect");
    while (!isdefined(self.doa)) {
        wait 0.05;
    }
    if (!isdefined(spawn_origin)) {
        spawn_origin = function_40bfe842(self.entnum);
    }
    arenacenter = namespace_3ca3c537::function_61d60e0b();
    self thread namespace_831a4a7c::function_7d7a7fde();
    foreach (guardian in self.doa.var_af875fb7) {
        if (isdefined(guardian)) {
            guardian forceteleport(spawn_origin + (randomintrange(-60, 60), randomintrange(-60, 60), 0), self.angles);
        }
    }
    if (isdefined(self.doa) && isdefined(self.doa.vehicle)) {
        self thread function_f581d585(spawn_origin, arenacenter);
    } else {
        if (!isdefined(self.doa.var_3b383993)) {
            self.doa.var_f4a883ed = undefined;
            self disableinvulnerability();
        }
        self setorigin(spawn_origin);
    }
    angles = vectortoangles(arenacenter - self.origin);
    self setplayerangles((0, angles[1], 0));
    self notify(#"hash_75f413cb");
    if (var_97887a95) {
        self thread namespace_831a4a7c::function_b5843d4f(level.doa.var_458c27d == 3);
        self thread namespace_831a4a7c::turnOnFlashlight(level.doa.var_458c27d == 3);
    }
}

// Namespace namespace_cdb9a8fe
// Params 1, eflags: 0x0
// Checksum 0xca486ec3, Offset: 0x1460
// Size: 0x53
function function_55762a85(spawn_origin) {
    stopallrumbles();
    array::thread_all(getplayers(), &function_fe0946ac, spawn_origin);
    level notify(#"hash_3b6e1e2");
}

// Namespace namespace_cdb9a8fe
// Params 1, eflags: 0x4
// Checksum 0x478f286, Offset: 0x14c0
// Size: 0x69
function private function_ff7f941a(def) {
    num = namespace_49107f3a::function_2f0d697f(def.spawner);
    if (num >= def.var_84aef63e) {
        return false;
    }
    if (isdefined(def.var_a0b2e897) && namespace_3ca3c537::function_d2d75f5d() != def.var_a0b2e897) {
        return false;
    }
    return true;
}

// Namespace namespace_cdb9a8fe
// Params 2, eflags: 0x0
// Checksum 0x1a8e2bcd, Offset: 0x1538
// Size: 0x3de
function function_21a582ff(current_wave, endnote) {
    if (isdefined(endnote)) {
        level endon(endnote);
    }
    level.doa.var_19563cb8++;
    spawn_locations = level.doa.var_c984ad24[current_wave.spawn_side];
    time = current_wave.var_b051bab1;
    time = time * 1000 + gettime();
    while (gettime() < time) {
        if (level flag::get("doa_game_is_over")) {
            break;
        }
        wait getdvarfloat("scr_doa_spawn_delay", 0.35);
        spawnpoint = spawn_locations[randomint(spawn_locations.size)];
        var_48be25f5 = level.doa.var_c838db72[randomint(level.doa.var_c838db72.size)];
        if (isdefined(level.doa.var_d0cde02c) && function_ff7f941a(level.doa.var_d0cde02c)) {
            var_48be25f5 = level.doa.var_d0cde02c.spawner;
            ai = [[ level.doa.var_d0cde02c.spawnfunc ]](var_48be25f5, spawnpoint, level.doa.var_d0cde02c);
            if (isdefined(ai)) {
                ai.var_d3c93fe9 = 1;
                var_48be25f5 = undefined;
            }
        }
        if (isdefined(level.doa.var_d0cde02c.var_3ceda880) && isdefined(level.doa.var_d0cde02c) && level.doa.var_d0cde02c.var_3ceda880) {
            continue;
        }
        if (isdefined(var_48be25f5)) {
            ai = doa_enemy::function_a4e16560(var_48be25f5, spawnpoint);
            if (isdefined(ai)) {
                ai thread zombie_utility::zombie_gib_on_damage();
                ai.tesla_head_gib_func = &namespace_fba031c8::function_deb7df37;
            }
        }
        if (isdefined(level.doa.arenas[level.doa.var_90873830].var_f06f27e8)) {
            ai = [[ level.doa.arenas[level.doa.var_90873830].var_f06f27e8 ]]();
        }
        if (level.doa.var_f5e35752.size && gettime() > level.doa.var_4481ad9) {
            var_9f7a6d48 = level.doa.var_f5e35752[randomint(level.doa.var_f5e35752.size)];
            if (isdefined(var_9f7a6d48.cooldown)) {
                if (gettime() < var_9f7a6d48.cooldown) {
                    continue;
                }
                var_9f7a6d48.cooldown = gettime() + var_9f7a6d48.var_759562f7;
            }
            roll = var_9f7a6d48.spawnchance * 100;
            if (randomint(100) > roll) {
                continue;
            }
            spawnpoint = spawn_locations[randomint(spawn_locations.size)];
            ai = [[ var_9f7a6d48.spawnfunc ]](var_9f7a6d48.spawner, spawnpoint, var_9f7a6d48);
            level.doa.var_4481ad9 = gettime() + level.doa.rules.var_72d934b2;
        }
    }
    level.doa.var_19563cb8--;
}

// Namespace namespace_cdb9a8fe
// Params 1, eflags: 0x0
// Checksum 0x3a27ee33, Offset: 0x1920
// Size: 0x272
function function_87703158(bossRound) {
    if (!isdefined(bossRound)) {
        bossRound = 0;
    }
    level notify(#"hash_50be1db3");
    level endon(#"hash_50be1db3");
    flag::set("doa_round_spawning");
    level notify(#"hash_c87feb68");
    level lui::screen_close_menu();
    level.doa.round_start_time = gettime();
    level.doa.var_5cd9f23f = undefined;
    level.doa.var_e0d67a74 = struct::get_array(namespace_3ca3c537::function_d2d75f5d() + "_rise_spot");
    spawn_set = level.doa.arenas[level.doa.var_90873830].name + "_enemy_spawn";
    level.doa.var_c984ad24 = level.doa.spawners[spawn_set];
    level.doa.var_19563cb8 = 0;
    do {
        for (wave = 0; wave < level.doa.var_d9933f22.size; wave++) {
            while (level flag::get("doa_round_paused")) {
                wait 0.05;
            }
            if (level flag::get("doa_game_is_over")) {
                break;
            }
            if (!level flag::get("doa_round_active")) {
                break;
            }
            level.doa.current_wave = level.doa.var_d9933f22[wave];
            level thread function_21a582ff(level.doa.current_wave);
            wait level.doa.current_wave.var_1112b648;
        }
        if (level flag::get("doa_game_is_over")) {
            break;
        }
        if (!level flag::get("doa_round_active")) {
            break;
        }
    } while (bossRound);
    while (level.doa.var_19563cb8 > 0) {
        wait 1;
    }
    flag::clear("doa_round_spawning");
}

// Namespace namespace_cdb9a8fe
// Params 2, eflags: 0x4
// Checksum 0xa9ac1101, Offset: 0x1ba0
// Size: 0xb8
function private function_da304666(wave_number, round_number) {
    wave = spawnstruct();
    wave.var_b051bab1 = 1 + randomfloatrange(0, 1 + wave_number * 0.3) + randomfloatrange(0, 1 + round_number * 0.2);
    wave.spawn_side = namespace_49107f3a::function_5b4fbaef();
    wave.var_1112b648 = 1 + randomfloatrange(0, wave.var_b051bab1 * 0.6);
    return wave;
}

// Namespace namespace_cdb9a8fe
// Params 1, eflags: 0x0
// Checksum 0x77a1e207, Offset: 0x1c60
// Size: 0x121
function function_703bb8b2(round_number) {
    level.doa.var_d9933f22 = [];
    max = level.doa.rules.var_57cac10a + level.doa.var_da96f13c * level.doa.rules.var_57cac10a;
    waves = 6 + int(round_number * 1.2);
    if (waves > max) {
        waves = max;
    }
    if (isdefined(level.doa.var_d0cde02c) && isdefined(level.doa.var_d0cde02c.var_474e643b)) {
        waves = level.doa.var_d0cde02c.var_474e643b;
    }
    for (i = 0; i < waves; i++) {
        level.doa.var_d9933f22[i] = function_da304666(i, round_number);
    }
}

// Namespace namespace_cdb9a8fe
// Params 0, eflags: 0x4
// Checksum 0xba4fe20d, Offset: 0x1d90
// Size: 0x1a7
function private function_d9345c74() {
    level thread namespace_a7e6beb5::function_c1869ec8();
    level thread namespace_49107f3a::clearallcorpses();
    level.doa.var_e0d67a74 = [];
    /#
        if (isdefined(level.doa.var_33749c8)) {
            if (level.doa.round_number > level.doa.var_33749c8) {
                level.doa.var_33749c8 = undefined;
                setdvar("<dev string:x39>", "<dev string:x43>");
            }
        }
    #/
    if (isdefined(level.doa.teleporter)) {
        if (isdefined(level.doa.teleporter.trigger)) {
            level.doa.teleporter.trigger delete();
        }
        level.doa.teleporter delete();
    }
    if (isdefined(level.doa.var_d0cde02c) && !(isdefined(level.doa.var_d0cde02c.var_79c72134) && level.doa.var_d0cde02c.var_79c72134)) {
        level.doa.var_f5e35752[level.doa.var_f5e35752.size] = level.doa.var_d0cde02c;
    }
    level.doa.var_d0cde02c = undefined;
    level notify(#"exit_taken");
}

