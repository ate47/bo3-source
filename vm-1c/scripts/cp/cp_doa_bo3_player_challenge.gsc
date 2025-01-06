#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/cp_doa_bo3_enemy;
#using scripts/cp/cp_doa_bo3_fx;
#using scripts/cp/cp_doa_bo3_sound;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_chicken_pickup;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_fate;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_gibs;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/cp/doa/_doa_vehicle_pickup;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;

#using_animtree("critter");

#namespace namespace_df93fc7c;

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0x584205e, Offset: 0xf50
// Size: 0xdc
function function_4c171b8e() {
    self endon(#"disconnect");
    while (!isdefined(self.doa)) {
        wait 0.05;
    }
    waittillframeend();
    startpoints = struct::get_array("spiral_player_spawnpoint");
    self freezecontrols(!level flag::get("doa_challenge_running"));
    spot = startpoints[self.entnum];
    self setorigin(spot.origin);
    self setplayerangles(spot.angles);
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0xdc565969, Offset: 0x1038
// Size: 0x7a
function function_bb59f698() {
    level endon(#"hash_16154574");
    level endon(#"player_challenge_failure");
    trigger = getent("spiral_killAllEnemy", "targetname");
    trigger waittill(#"trigger");
    level thread namespace_49107f3a::function_f798b582();
    level notify(#"hash_16154574");
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x3c09361a, Offset: 0x10c0
// Size: 0x7ac
function function_31c377e(room) {
    room.text = %CP_DOA_BO3_CHALLENGE_ROOM_SPIRAL;
    room.title = %CP_DOA_BO3_TITLE_ROOM_SPIRAL;
    room.vox = "vox_doaa_temple_fortress";
    room.var_e5c8b9e7 = level.doa.var_bc9b7c71;
    level.doa.var_bc9b7c71 = &function_4c171b8e;
    level thread namespace_3ca3c537::function_4586479a(0);
    level thread function_bb59f698();
    room.glow = [];
    glow = spawn("script_model", namespace_3ca3c537::function_61d60e0b() + (0, 0, 36));
    glow.targetname = "spiralglow1";
    glow setmodel("tag_origin");
    glow thread namespace_eaa992c::function_285a2999("glow_blue");
    room.glow[room.glow.size] = glow;
    glow = spawn("script_model", namespace_3ca3c537::function_61d60e0b() + (0, 0, 72));
    glow.targetname = "spiralglow2";
    glow setmodel("tag_origin");
    glow thread namespace_eaa992c::function_285a2999("glow_blue");
    room.glow[room.glow.size] = glow;
    glow = spawn("script_model", namespace_3ca3c537::function_61d60e0b() + (0, 0, 128));
    glow.targetname = "spiralglow3";
    glow setmodel("tag_origin");
    glow thread namespace_eaa992c::function_285a2999("glow_blue");
    room.glow[room.glow.size] = glow;
    glow = spawn("script_model", namespace_3ca3c537::function_61d60e0b() + (0, 0, 160));
    glow.targetname = "spiralglow4";
    glow setmodel("tag_origin");
    glow thread namespace_eaa992c::function_285a2999("glow_blue");
    room.glow[room.glow.size] = glow;
    barricades = struct::get_array(room.name + "_destructible", "targetname");
    count = 0;
    foreach (item in barricades) {
        blocker = spawn("script_model", item.origin);
        blocker.targetname = "blockerSpiral";
        blocker.angles = item.angles;
        blocker setmodel(item.script_noteworthy);
        blocker solid();
        blocker.targetname = room.name + "_blocker";
        blocker thread function_e1b0de53(item.script_parameters);
        count++;
        if (count > 10) {
            wait 0.05;
            count = 0;
        }
    }
    var_2b8e59af = getentarray(room.name + "_barrier_trigger", "targetname");
    foreach (trigger in var_2b8e59af) {
        trigger thread triggernotify();
    }
    rewards = struct::get_array(room.name + "_challenge_reward");
    foreach (item in rewards) {
        namespace_a7e6beb5::function_3238133b(item.script_noteworthy, item.origin, 1, 0);
    }
    foreach (player in getplayers()) {
        player thread function_4c171b8e();
    }
    level flag::set("doa_challenge_ready");
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0x952940e0, Offset: 0x1878
// Size: 0xa4
function function_ffe2a6ea() {
    wait randomfloatrange(0, 1);
    self moveto((self.origin[0], self.origin[1], self.origin[2] + 2000), 1);
    self util::waittill_any_timeout(1.5, "movedone");
    self delete();
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0x497498fc, Offset: 0x1928
// Size: 0xc2
function triggernotify() {
    target = getent(self.target, "targetname");
    target.origin = (target.origin[0], target.origin[1], int(target.script_parameters));
    self waittill(#"trigger");
    target.origin += (0, 0, 1000);
    level notify(self.script_parameters);
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xacd3cfb3, Offset: 0x19f8
// Size: 0x4c
function function_e1b0de53(note) {
    level endon(#"hash_16154574");
    level endon(#"player_challenge_failure");
    self.var_e2b2db7a = 1;
    level waittill(note);
    self thread function_ffe2a6ea();
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x75fcdadf, Offset: 0x1a50
// Size: 0x1fe
function function_8e0e22bb(room) {
    level endon(#"hash_16154574");
    level endon(#"player_challenge_failure");
    foreach (player in getplayers()) {
        player freezecontrols(1);
        player.room = room;
    }
    level waittill(#"hash_97276c43");
    level flag::set("doa_challenge_running");
    foreach (player in getplayers()) {
        player freezecontrols(0);
        player notify(#"hash_d28ba89d");
    }
    level thread function_533483a3(room);
    if (isdefined(level.var_1575b6db) && level.var_1575b6db) {
        level thread namespace_49107f3a::function_80409246("teleporter_triggered", 10);
    }
    level waittill(#"teleporter_triggered");
    level notify(#"hash_16154574");
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xe3d59817, Offset: 0x1c58
// Size: 0x1c
function function_47a3686b(room) {
    namespace_a7e6beb5::function_c1869ec8();
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x1590e2b1, Offset: 0x1c80
// Size: 0xb2
function function_7823dbb8(room) {
    axis = getaiteamarray("axis");
    foreach (guy in axis) {
        guy kill();
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x458f3eff, Offset: 0x1d40
// Size: 0x234
function function_eee6e911(room) {
    ents = getentarray(room.name + "_blocker", "targetname");
    foreach (ent in ents) {
        ent delete();
    }
    if (isdefined(level.doa.teleporter)) {
        level.doa.teleporter.trigger delete();
        level.doa.teleporter delete();
        level.doa.teleporter = undefined;
    }
    foreach (glow in room.glow) {
        if (isdefined(glow)) {
            glow delete();
        }
    }
    level.doa.var_e9339daa = namespace_3ca3c537::function_5835533a("temple");
    namespace_3ca3c537::function_5af67667(level.doa.var_e9339daa, 1);
    namespace_23f188a4::function_77ed1bae();
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x5 linked
// Checksum 0xe9cb8ecf, Offset: 0x1f80
// Size: 0x32a
function private function_533483a3(room) {
    level endon(#"hash_16154574");
    level endon(#"player_challenge_failure");
    level.doa.var_e0d67a74 = struct::get_array(room.name + "_rise_spot");
    var_48be25f5 = getent("spawner_zombietron_skeleton", "targetname");
    while (true) {
        axis = getaiteamarray("axis");
        if (axis.size < 40) {
            var_e1a06452 = randomintrange(3, 10);
            if (axis.size + var_e1a06452 > 40) {
                var_e1a06452 = 40 - axis.size;
            }
            var_1db14d86 = getplayers().size * 500;
            while (var_e1a06452) {
                var_e1a06452--;
                ai = namespace_51bd792::function_45849d81(var_48be25f5, undefined, undefined);
                if (isdefined(ai)) {
                    ai hidepart("TAG_WEAPON_LEFT");
                    ai setavoidancemask("avoid none");
                    ai function_1762804b(0);
                    ai.var_ad61c13d = 1;
                    ai.is_skeleton = 1;
                    ai.var_52b0b328 = 1;
                    ai.doa.points = undefined;
                    ai notify(#"hash_6e8326fc");
                    roll = randomint(100);
                    if (roll < 20) {
                        ai.zombie_move_speed = "super_sprint";
                    } else if (roll < 45) {
                        ai.zombie_move_speed = "sprint";
                    } else if (roll < 80) {
                        ai.zombie_move_speed = "run";
                    } else {
                        ai.zombie_move_speed = "walk";
                    }
                    ai.health = 500 + var_1db14d86;
                    ai thread function_c0808a91();
                }
                wait 0.05;
            }
        }
        wait 1;
    }
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0xdeca6a86, Offset: 0x22b8
// Size: 0x108
function function_c0808a91() {
    self endon(#"death");
    while (true) {
        if (isdefined(self.var_535aff84)) {
            foreach (player in getplayers()) {
                idx = isdefined(player.entnum) ? player.entnum : player getentitynumber();
                self.var_535aff84[idx] = gettime() + 1000;
            }
        }
        wait 0.5;
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x85e7af3d, Offset: 0x23c8
// Size: 0x2e4
function function_b6c25c3c(spot) {
    self endon(#"disconnect");
    while (!isdefined(self.doa)) {
        wait 0.05;
    }
    waittillframeend();
    if (!isdefined(spot)) {
        startpoints = struct::get_array("tankmaze_player_spawnpoint");
        spot = startpoints[self.entnum];
    }
    self.room = level.doa.var_52cccfb6;
    tank = getent("doa_tankmaze_spawner", "targetname") spawner::spawn(1);
    self setorigin(spot.origin);
    tank setmodel("veh_t7_mil_tank_tiger_zombietron_" + namespace_831a4a7c::function_ee495f41(self.entnum));
    tank.origin = spot.origin;
    tank.spawnpoint = spot.origin;
    tank.angles = spot.angles;
    tank.spawnangles = spot.angles;
    tank.team = "allies";
    tank thread function_9c687a5d(self);
    tank usevehicle(self, 0);
    tank makeunusable();
    tank.owner = self;
    tank makesentient();
    self.doa.vehicle = tank;
    self.doa.var_3024fd0f = 1;
    self.doa.var_3e3bcaa1 = 1;
    self.doa.var_f219339a = 0;
    self.ignoreme = 1;
    self freezecontrols(!level flag::get("doa_challenge_running"));
    wait 0.05;
    self thread function_810ced6b();
    self namespace_5e6c5d1f::function_8397461e();
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x28bbc71f, Offset: 0x26b8
// Size: 0x23c
function function_6aa91f48(room) {
    level clientfield::set("set_scoreHidden", 1);
    room.var_dc49d6a4 = level.callbackvehicledamage;
    level.callbackvehicledamage = &function_fe1ce5f1;
    room.var_e5c8b9e7 = level.doa.var_bc9b7c71;
    level.doa.var_bc9b7c71 = &function_b6c25c3c;
    room.text = %CP_DOA_BO3_CHALLENGE_ROOM_TANKMAZE;
    room.title = %CP_DOA_BO3_TITLE_ROOM_TANKMAZE;
    room.vox = "vox_doaa_tank_vault";
    room.var_674e3329 = 1;
    room.var_a1af0216 = struct::get_array("tankmaze_enemy", "script_noteworthy");
    room.var_4f002f93 = struct::get_array("tankmaze_gemspot", "script_noteworthy");
    room.var_e01f23f0 = [];
    room.host_migration = &function_c2b99e74;
    level thread function_246d3adb(room);
    level thread tankmaze_EnemySpawner(room);
    foreach (player in getplayers()) {
        player thread function_b6c25c3c();
    }
    level thread function_ee260997(room);
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xfd250ce9, Offset: 0x2900
// Size: 0x49a
function function_246d3adb(room) {
    total = room.var_4f002f93.size;
    var_82361971 = int(ceil(total / 80));
    arena = level.doa.arenas[namespace_3ca3c537::function_5835533a(room.name)];
    var_86a35fbd = struct::get(arena.entity.target, "targetname");
    while (isdefined(var_86a35fbd) && total > 0) {
        var_2bb5aeba = 0;
        while (isdefined(var_86a35fbd) && var_2bb5aeba < var_82361971) {
            reward = "zombietron_beryl";
            if (isdefined(var_86a35fbd.script_parameters)) {
                switch (var_86a35fbd.script_parameters) {
                case "1":
                case "2":
                case "3":
                    reward = "zombietron_beryl";
                    break;
                default:
                    reward = var_86a35fbd.script_parameters;
                    scale = 1;
                    break;
                }
            }
            item = namespace_a7e6beb5::function_2d8cb175(reward, var_86a35fbd.origin, 1, 0, 0, isdefined(scale) ? scale : 2, 0, 0, 1, 0)[0];
            item namespace_a7e6beb5::function_32110b7d();
            item.trigger triggerenable(0);
            room.var_e01f23f0[room.var_e01f23f0.size] = item;
            if (isdefined(var_86a35fbd.target)) {
                var_86a35fbd = struct::get(var_86a35fbd.target, "targetname");
            } else {
                var_86a35fbd = undefined;
            }
            var_2bb5aeba++;
            total--;
        }
        wait 0.05;
    }
    curtick = 0;
    room.var_e01f23f0 = array::remove_undefined(room.var_e01f23f0);
    foreach (gem in room.var_e01f23f0) {
        if (isdefined(gem)) {
            gem namespace_a7e6beb5::function_fbc5b316();
        }
        curtick++;
        if (curtick == var_82361971) {
            util::wait_network_frame();
            curtick = 0;
        }
    }
    level waittill(#"hash_c8bd32b9");
    foreach (gem in room.var_e01f23f0) {
        if (isdefined(gem) && isdefined(gem.trigger)) {
            gem.trigger triggerenable(1);
        }
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x10f7222b, Offset: 0x2da8
// Size: 0x40
function function_5900e5de(room) {
    level endon(#"hash_16154574");
    level endon(#"player_challenge_failure");
    self waittill(#"death");
    room.var_74415e9d--;
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xa1dfe2ad, Offset: 0x2df0
// Size: 0x56
function function_a1151ae3(room) {
    room.var_74415e9d++;
    self thread function_5900e5de(room);
    self endon(#"death");
    level endon(#"hash_16154574");
    level endon(#"player_challenge_failure");
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x6d05b244, Offset: 0x2e50
// Size: 0x370
function tankmaze_EnemySpawner(room) {
    level endon(#"hash_16154574");
    level endon(#"player_challenge_failure");
    room.var_74415e9d = 0;
    level waittill(#"hash_c8bd32b9");
    while (true) {
        if (room.var_74415e9d < 4 + getplayers().size) {
            spot = room.var_a1af0216[randomint(room.var_a1af0216.size)];
            var_7ad30272 = spot.origin + (0, 0, 2000);
            spawner = getent("spawner_doa_tankmaze_amws", "targetname");
            fake = spawn("script_model", var_7ad30272);
            fake.targetname = "tankmaze_EnemySpawner";
            fake setmodel(level.doa.var_4aa90d77);
            fake.angles = spot.angles;
            fake thread namespace_eaa992c::function_285a2999("fire_trail");
            fake playsound("evt_amws_incoming");
            fake moveto(spot.origin, 0.75);
            fake thread namespace_49107f3a::function_1bd67aef(1);
            fake util::waittill_any_timeout(0.8, "movedone");
            playrumbleonposition("explosion_generic", spot.origin);
            fake delete();
            amws = spawner spawner::spawn(1);
            if (isdefined(amws)) {
                amws.origin = spot.origin;
                amws.angles = spot.angles;
                amws.health = 100;
                amws.team = "axis";
                amws thread namespace_eaa992c::function_285a2999("turret_impact");
                amws.script_noteworthy = "tankmaze_enemy";
                amws thread function_a1151ae3(room);
            }
            wait 1 + 4 - getplayers().size;
        }
        wait 0.05;
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x4d12511b, Offset: 0x31c8
// Size: 0x9c
function function_ee260997(room) {
    level waittill(#"hash_97276c43");
    level notify(#"hash_b0d5a848");
    wait 1;
    level clientfield::set("startCountdown", 3);
    wait 4;
    level clientfield::set("startCountdown", 0);
    level notify(#"hash_c8bd32b9");
    level flag::set("doa_challenge_ready");
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xa426efa5, Offset: 0x3270
// Size: 0x212
function function_5f0b67a9(room) {
    foreach (player in getplayers()) {
        player freezecontrols(1);
    }
    level waittill(#"hash_c8bd32b9");
    level flag::set("doa_challenge_running");
    foreach (player in getplayers()) {
        player freezecontrols(0);
    }
    if (getdvarint("scr_doa_soak_think", 0) > 1) {
        totaltime = 5000;
    } else {
        totaltime = (room.timeout - 1) * 1000;
    }
    timeleft = gettime() + totaltime;
    while (gettime() < timeleft) {
        wait 0.5;
    }
    level clientfield::set("pumpBannerBar", 0);
    util::wait_network_frame();
    level notify(#"hash_16154574");
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x7aaf7505, Offset: 0x3490
// Size: 0xc
function function_9e5e0a15(room) {
    
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x4ab8f1e3, Offset: 0x34a8
// Size: 0xc
function function_a25fc96(room) {
    
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x9e9d9272, Offset: 0x34c0
// Size: 0x25c
function function_f1915ffb(room) {
    namespace_a7e6beb5::function_c1869ec8();
    level thread namespace_49107f3a::function_f798b582();
    players = getplayers();
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        player notify(#"hash_7c5410c4");
        if (isdefined(player.doa)) {
            if (isdefined(player.doa.vehicle)) {
                player.doa.vehicle usevehicle(player, 0);
                player.doa.vehicle delete();
                player.doa.vehicle = undefined;
            }
            player namespace_831a4a7c::function_7d7a7fde();
            if (!isdefined(player)) {
                continue;
            }
            player disableinvulnerability();
            player.doa.var_3024fd0f = undefined;
            player.doa.var_3e3bcaa1 = undefined;
        }
        player.ignoreme = 0;
        player namespace_2848f8c2::function_d41a4517();
    }
    level.doa.var_bc9b7c71 = room.var_e5c8b9e7;
    level.callbackvehicledamage = room.var_dc49d6a4;
    level clientfield::set("set_scoreHidden", 0);
}

// Namespace namespace_df93fc7c
// Params 14, eflags: 0x1 linked
// Checksum 0x2e62be29, Offset: 0x3728
// Size: 0x5a4
function function_fe1ce5f1(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname) {
    if (self.team == "axis") {
        self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
        return;
    }
    if (isdefined(self.var_a4ac052c) && gettime() < self.var_a4ac052c) {
        return 0;
    }
    player = self.owner;
    player cleardamageindicator();
    idamage = 0;
    scale = 0;
    switch (smeansofdeath) {
    case "MOD_RIFLE_BULLET":
        scale = 0.1;
        break;
    case "MOD_PROJECTILE":
        scale = 1;
        break;
    case "MOD_EXPLOSIVE":
        scale = 0.4;
        break;
    }
    if (scale == 0) {
        return;
    }
    var_516eed4b = int(getdvarint("scr_doa_tankMazeMaxGems", 10) * scale);
    var_b427d4ac = player.doa.multiplier;
    self.var_a4ac052c = gettime() + 5000;
    if (player.doa.fate == 2 || player.doa.fate == 11) {
        var_b427d4ac--;
    }
    if (player.doa.var_d55e6679 == 0 && var_b427d4ac == 0) {
        return idamage;
    }
    var_8cfdcf73 = randomintrange(0, int(level.doa.rules.var_d55e6679 * scale * getdvarfloat("scr_doa_tankMazeIncScalar", 0.25)));
    player.doa.var_d55e6679 -= var_8cfdcf73;
    if (var_b427d4ac > 1) {
        player.doa.multiplier -= 1;
        player.doa.var_d55e6679 += level.doa.rules.var_d55e6679;
    }
    if (player.doa.var_d55e6679 < 0) {
        player.doa.var_d55e6679 = 0;
    }
    player.room.var_e01f23f0 = array::remove_undefined(player.room.var_e01f23f0);
    while (var_516eed4b && player.room.var_e01f23f0.size < 275) {
        switch (randomint(5)) {
        case 0:
            reward = "zombietron_emerald";
            break;
        case 1:
            reward = "zombietron_ruby";
            break;
        case 2:
            reward = "zombietron_diamond";
            break;
        case 3:
            reward = "zombietron_sapphire";
            break;
        case 4:
            reward = "zombietron_beryl";
            break;
        }
        reward = "zombietron_beryl";
        player.room.var_e01f23f0[player.room.var_e01f23f0.size] = level namespace_a7e6beb5::function_16237a19(self.origin + (0, 0, 48), 1, 70, 1, 1, 2, reward, 0.2, 1, 0, 0)[0];
        var_516eed4b--;
    }
    return idamage;
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x596e1741, Offset: 0x3cd8
// Size: 0x31a
function function_c2b99e74(room) {
    /#
        namespace_49107f3a::debugmsg("<dev string:x28>");
    #/
    foreach (player in getplayers()) {
        player freezecontrols(1);
        if (isdefined(player.doa.vehicle) && player.doa.vehicle getvehicleowner() == player) {
            /#
                namespace_49107f3a::debugmsg("<dev string:x45>" + player.name);
            #/
            player.doa.vehicle makeusable();
            player.doa.vehicle usevehicle(player, 0);
            player ghost();
        }
    }
    util::wait_network_frame();
    foreach (player in getplayers()) {
        if (isdefined(player.doa.vehicle)) {
            /#
                namespace_49107f3a::debugmsg("<dev string:x5d>" + player.name);
            #/
            player.doa.vehicle usevehicle(player, 0);
            player.doa.vehicle makeunusable();
            player show();
        }
        player freezecontrols(!level flag::get("doa_challenge_running"));
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x7d4bad4c, Offset: 0x4000
// Size: 0x3c
function function_9c687a5d(player) {
    self endon(#"death");
    player waittill(#"disconnect");
    self delete();
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x7d93e241, Offset: 0x4048
// Size: 0x42c
function function_14e75d7a(spot) {
    self endon(#"disconnect");
    while (!isdefined(self.doa)) {
        wait 0.05;
    }
    waittillframeend();
    if (!isdefined(spot)) {
        startpoints = struct::get_array("redins_player_spawnpoint");
        spot = startpoints[self.entnum];
    }
    self.var_b1c8a8a2 = self.doa.bombs;
    self.var_e9aff98 = self.doa.var_c5e98ad6;
    var_f3a9458e = getent("doa_redins_truck", "targetname");
    truck = var_f3a9458e spawner::spawn(1);
    self setorigin(spot.origin);
    truck.origin = spot.origin;
    truck.spawnpoint = spot.origin;
    truck.angles = spot.angles;
    truck.spawnangles = spot.angles;
    truck.team = self.team;
    truck thread function_9c687a5d(self);
    truck usevehicle(self, 0);
    truck makeunusable();
    truck.takedamage = 0;
    truck.var_f71159da = 0;
    truck.owner = self;
    truck setmodel("veh_t7_civ_truck_pickup_tech_nrc_mini_" + namespace_831a4a7c::function_ee495f41(self.entnum));
    self.doa.vehicle = truck;
    self.doa.var_de24aff7 = 0;
    self.doa.var_37efabf7 = 1;
    self.doa.var_3024fd0f = 1;
    self.doa.var_3e3bcaa1 = 1;
    self thread function_c71e611c(truck);
    self thread function_d64204d9();
    self.doa.var_f219339a = 0;
    self.doa.gpr2 = 0;
    level clientfield::set("set_ui_gprDOA" + self.entnum, 0);
    level clientfield::set("set_ui_gpr2DOA" + self.entnum, 0);
    self.doa.bombs = level.doa.var_52cccfb6.var_2f400c3b;
    self.doa.var_c5e98ad6 = self.doa.var_37efabf7;
    self freezecontrols(!level flag::get("doa_challenge_running"));
    wait 0.05;
    self enableinvulnerability();
    self thread function_810ced6b();
    self namespace_5e6c5d1f::function_8397461e();
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0xb6897c7d, Offset: 0x4480
// Size: 0x1c
function function_810ced6b() {
    wait 1;
    self namespace_2848f8c2::function_d460de4b();
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x2eb73fda, Offset: 0x44a8
// Size: 0x2bc
function function_ba487e2a(room) {
    level clientfield::set("set_scoreHidden", 1);
    room.var_e5c8b9e7 = level.doa.var_bc9b7c71;
    level.doa.var_bc9b7c71 = &function_14e75d7a;
    room.text = %CP_DOA_BO3_CHALLENGE_ROOM_REDINS;
    room.title = %CP_DOA_BO3_TITLE_ROOM_REDINS;
    room.vox = "vox_doaa_redins_rally";
    room.var_674e3329 = 1;
    room.var_2f400c3b = math::clamp(2 + getplayers().size * 2, 4, 8);
    room.var_462dd92 = 50 + room.var_2f400c3b * 5;
    room.host_migration = &function_c2b99e74;
    if (getdvarint("scr_doa_soak_think", 0) > 1) {
        room.var_462dd92 = 10;
    }
    room.var_b57e2384 = room.var_462dd92;
    level thread function_36c315b();
    level thread function_e812f929();
    level clientfield::set("set_ui_GlobalGPR0", room.var_b57e2384);
    foreach (player in getplayers()) {
        player thread function_14e75d7a();
    }
    level thread namespace_1a381543::function_68fdd800();
    level thread function_10aa3e48(room);
    level flag::set("doa_challenge_ready");
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x9a0113a0, Offset: 0x4770
// Size: 0x28a
function function_f14ef72f(room) {
    foreach (player in getplayers()) {
        player freezecontrols(1);
        player.room = room;
    }
    level waittill(#"hash_7b0c2638");
    level flag::set("doa_challenge_running");
    foreach (player in getplayers()) {
        player freezecontrols(0);
    }
    level thread function_3ed913b4(room);
    level thread function_455c43ca();
    while (room.var_b57e2384 > 0) {
        msg = level util::waittill_any_timeout(1, "redins_rally_complete");
        if (msg == "redins_rally_complete") {
            room.var_25c09afd = %CP_DOA_BO3_REDINS_TITLE2_SUCCESS;
            level notify(#"hash_16154574");
            return;
        }
        room.var_b57e2384 -= 1;
        level clientfield::set("set_ui_GlobalGPR0", room.var_b57e2384);
    }
    room.var_25c09afd = %CP_DOA_BO3_REDINS_TITLE2_FAIL;
    level notify(#"player_challenge_failure");
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x2b431bbe, Offset: 0x4a08
// Size: 0x122
function function_10aa3e48(room) {
    level waittill(#"hash_dec47e9f");
    level clientfield::set("redinstutorial", 1);
    level clientfield::set("redinsinstruct", room.var_2f400c3b + (room.var_b57e2384 << 4));
    level waittill(#"hash_97276c43");
    wait 1;
    level clientfield::set("startCountdown", 3);
    wait 4;
    level clientfield::set("redinstutorial", 0);
    level clientfield::set("startCountdown", 0);
    level clientfield::set("redinsinstruct", 0);
    level notify(#"hash_7b0c2638");
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x5f30c1db, Offset: 0x4b38
// Size: 0xc
function function_e13abd74(room) {
    
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x643f4b0f, Offset: 0x4b50
// Size: 0xc
function function_9d1b24f7(room) {
    
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0xabcf65a6, Offset: 0x4b68
// Size: 0x1aa
function function_455c43ca() {
    level endon(#"redins_rally_complete");
    level endon(#"hash_16154574");
    level endon(#"player_challenge_failure");
    level endon(#"hash_9bc1268b");
    level waittill(#"hash_d9dd7818");
    var_48be25f5 = getent("doa_basic_spawner", "targetname");
    spawnpoints = struct::get_array("redins_riser_spot");
    while (true) {
        count = namespace_49107f3a::function_b99d78c7();
        if (count < getdvarint("scr_redins_enemy_count", 16)) {
            ai = namespace_51bd792::function_45849d81(var_48be25f5, spawnpoints[randomint(spawnpoints.size)], undefined);
            ai forceteleport(ai.origin, (0, randomint(360), 0));
            ai.doa.var_4d252af6 = 1;
            wait randomfloatrange(0.1, 2);
            continue;
        }
        wait 3;
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x4ab544a5, Offset: 0x4d20
// Size: 0x384
function function_ce5fc0d(room) {
    namespace_a7e6beb5::function_c1869ec8();
    level thread namespace_49107f3a::function_f798b582();
    namespace_49107f3a::function_c157030a();
    waittillframeend();
    foreach (player in getplayers()) {
        player notify(#"hash_7c5410c4");
        if (isdefined(player.doa)) {
            if (isdefined(player.doa.vehicle)) {
                player.doa.vehicle usevehicle(player, 0);
                player.doa.vehicle delete();
                player.doa.vehicle = undefined;
            }
            player namespace_831a4a7c::function_7d7a7fde();
            player disableinvulnerability();
            player.doa.var_3024fd0f = undefined;
            player.doa.var_f30b49ec = 1;
            player.doa.var_3e3bcaa1 = undefined;
            player.doa.var_e651a75e = undefined;
            player.doa.bombs = player.var_b1c8a8a2;
            player.doa.var_c5e98ad6 = player.var_e9aff98;
        }
        player namespace_2848f8c2::function_d41a4517();
    }
    spots = struct::get_array("redins_pickup_location");
    level notify(#"hash_37480f48");
    foreach (spot in spots) {
        if (isdefined(spot.gem)) {
            spot.gem delete();
        }
    }
    level.doa.var_bc9b7c71 = room.var_e5c8b9e7;
    level clientfield::set("set_scoreHidden", 0);
    level clientfield::set("redinsExploder", 0);
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0x6c79c7df, Offset: 0x50b0
// Size: 0xb4
function function_67b5ba67() {
    var_efa02a6c = getent("redins_finish_line", "targetname");
    level endon(#"player_challenge_failure");
    level endon(#"hash_16154574");
    while (true) {
        var_efa02a6c waittill(#"trigger", truck);
        if (truck.var_f71159da == level.doa.var_c93ed68a) {
            truck.var_bbda805b = 1;
            truck.var_f71159da = 0;
        }
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x4c34f18b, Offset: 0x5170
// Size: 0x6be
function function_3ed913b4(room) {
    level endon(#"player_challenge_failure");
    level endon(#"hash_16154574");
    var_e0762056 = getentarray("redins_trigger_lap_latch", "targetname");
    foreach (trigger in var_e0762056) {
        trigger thread function_c218114a();
    }
    level thread function_67b5ba67();
    winner = undefined;
    var_64c1db98 = 0;
    while (!isdefined(winner)) {
        players = getplayers();
        foreach (player in players) {
            if (!isdefined(player.doa) || !isdefined(player.doa.vehicle)) {
                continue;
            }
            if (isdefined(player.doa.vehicle.var_bbda805b) && player.doa.vehicle.var_bbda805b) {
                player.doa.vehicle.var_bbda805b = undefined;
                switch (players.size) {
                case 1:
                    bonus = 8;
                    break;
                case 2:
                    bonus = 4;
                    break;
                case 3:
                    bonus = 3;
                    break;
                case 4:
                default:
                    bonus = 2;
                    break;
                }
                room.var_b57e2384 += bonus;
                if (room.var_b57e2384 > room.var_462dd92) {
                    room.var_b57e2384 = room.var_462dd92;
                }
                level clientfield::set("set_ui_GlobalGPR0", room.var_b57e2384);
                player.doa.var_de24aff7++;
                playsoundatposition("evt_lap_complete", (0, 0, 0));
                level notify(#"hash_d9dd7818");
                level notify(#"hash_6c12b0a2", player);
            }
            player.doa.bombs = room.var_2f400c3b - player.doa.var_de24aff7;
            player.doa.var_c5e98ad6 = player.doa.var_37efabf7;
            if (player.doa.var_de24aff7 == room.var_2f400c3b - 1 && !(isdefined(var_64c1db98) && var_64c1db98)) {
                var_64c1db98 = 1;
                playsoundatposition("evt_final_lap", (0, 0, 0));
                level clientfield::set("redinsExploder", 1);
                level thread namespace_49107f3a::function_c5f3ece8(%CP_DOA_BO3_LAST_LAP);
                continue;
            }
            if (player.doa.var_de24aff7 >= room.var_2f400c3b) {
                level clientfield::set("redinsExploder", 2);
                winner = player;
                break;
            }
        }
        wait 0.1;
    }
    foreach (player in getplayers()) {
        if (isdefined(player.doa.vehicle)) {
            player.doa.vehicle setbrake(1);
            player.doa.vehicle setspeedimmediate(0);
            player.doa.var_e651a75e = 1;
        }
    }
    level thread namespace_49107f3a::function_c5f3ece8(%CP_DOA_BO3_REDINS_WINNER);
    wait 4;
    level thread namespace_49107f3a::function_37fb5c23(winner.name);
    winner.doa.var_74c73153++;
    spots = struct::get_array("redins_pickup_location");
    level notify(#"hash_e1dc3538");
    winner thread namespace_831a4a7c::function_139199e1();
    level notify(#"redins_rally_complete", winner);
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x0
// Checksum 0x7fcf4ec0, Offset: 0x5838
// Size: 0xac
function function_2228a040(item) {
    self endon(#"disconnect");
    item endon(#"death");
    item.trigger triggerenable(0);
    self thread namespace_a7e6beb5::function_30768f24(item, 1);
    self waittill(#"hash_30768f24");
    item.trigger triggerenable(1);
    item.trigger notify(#"trigger", self);
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0x7823e39a, Offset: 0x58f0
// Size: 0xac
function function_c218114a() {
    level endon(#"redins_rally_complete");
    level endon(#"player_challenge_failure");
    var_6c0d141d = int(self.script_parameters);
    level function_bbb36dbe(var_6c0d141d);
    while (true) {
        self waittill(#"trigger", truck);
        truck.var_f71159da |= 1 << var_6c0d141d;
        /#
        #/
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xae532e53, Offset: 0x59a8
// Size: 0x60
function function_bbb36dbe(flag) {
    if (!isdefined(level.doa.var_c93ed68a)) {
        level.doa.var_c93ed68a = 0;
    }
    level.doa.var_c93ed68a |= 1 << flag;
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0x214035ae, Offset: 0x5a10
// Size: 0xbc
function function_fa6d5f56() {
    self endon(#"death");
    if (self clientfield::get("toggle_lights_group1")) {
        self vehicle::toggle_lights_group(1, 0);
        util::wait_network_frame();
    }
    self vehicle::toggle_lights_group(1, 1);
    self playsound("veh_doa_boost");
    wait 3;
    self vehicle::toggle_lights_group(1, 0);
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xe12e46de, Offset: 0x5ad8
// Size: 0x1b6
function function_c71e611c(vehicle) {
    level endon(#"redins_rally_complete");
    level endon(#"player_challenge_failure");
    self notify(#"hash_89f9d324");
    self endon(#"hash_89f9d324");
    self endon(#"disconnect");
    vehicle endon(#"death");
    level.launchforce = 500;
    vehicle vehicle::toggle_lights_group(1, 0);
    while (true) {
        wait 0.05;
        if (!level flag::get("doa_challenge_running")) {
            continue;
        }
        if (isdefined(self.doa.vehicle) && self changeseatbuttonpressed() && self.doa.var_37efabf7 > 0 && !(isdefined(self.doa.var_e651a75e) && self.doa.var_e651a75e)) {
            self.doa.var_37efabf7--;
            curdir = (level.launchforce, 0, 0);
            vehicle launchvehicle(curdir, (0, 0, 0), 1);
            vehicle thread function_fa6d5f56();
            while (self changeseatbuttonpressed()) {
                wait 0.05;
            }
            wait 1;
        }
    }
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0x970b61cd, Offset: 0x5c98
// Size: 0x4c
function function_36c315b() {
    var_7817fe3c = getentarray("redins_water_hazard", "targetname");
    level thread function_41ecdf7e(var_7817fe3c);
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0x2febcf83, Offset: 0x5cf0
// Size: 0xc2
function function_e812f929() {
    level endon(#"redins_rally_complete");
    level endon(#"player_challenge_failure");
    spots = struct::get_array("redins_pickup_location");
    foreach (spot in spots) {
        spot thread function_fb199a7c();
    }
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0xc1d36911, Offset: 0x5dc0
// Size: 0x1e8
function function_fb199a7c() {
    level endon(#"redins_rally_complete");
    level endon(#"player_challenge_failure");
    level endon(#"hash_e1dc3538");
    var_df3be8f1 = getent(self.target, "targetname");
    self.gem = namespace_a7e6beb5::function_16237a19(self.origin, 1, 0, 0, 0, 5, self.script_noteworthy, undefined, 0, 0)[0];
    while (true) {
        var_df3be8f1 waittill(#"trigger", truck);
        if (isplayer(truck)) {
            continue;
        }
        if (isdefined(truck) && isdefined(truck.owner) && isdefined(self.gem)) {
            self.gem.trigger notify(#"trigger", truck.owner);
        }
        truck.owner.doa.gpr2++;
        level clientfield::set("set_ui_gpr2DOA" + truck.owner.entnum, truck.owner.doa.gpr2);
        wait randomintrange(15, 45);
        self.gem = namespace_a7e6beb5::function_16237a19(self.origin, 1, 0, 0, 0, 5, self.script_noteworthy, undefined, 0, 0)[0];
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xbcc6b6fa, Offset: 0x5fb0
// Size: 0x368
function function_41ecdf7e(triggers) {
    level endon(#"redins_rally_complete");
    level endon(#"player_challenge_failure");
    while (true) {
        players = getplayers();
        foreach (player in players) {
            if (!isdefined(player.doa)) {
                continue;
            }
            if (isdefined(player.doa.vehicle)) {
                truck = player.doa.vehicle;
            } else {
                continue;
            }
            touching = 0;
            foreach (trigger in triggers) {
                if (truck istouching(trigger)) {
                    touching = 1;
                }
            }
            if (touching) {
                dir = truck getvelocity();
                len = length(dir);
                if (len > -6) {
                    dir = vectornormalize(dir) * 300;
                }
                dir *= -0.2;
                truck launchvehicle(dir, truck.origin + (0, 0, 9));
                if (len > 50) {
                    forward = anglestoforward(truck.angles);
                    playfxontag(level._effect["truck_splash"], truck, "tag_grill_d0");
                    playfxontag(level._effect["truck_splash"], truck, "tag_bumper_rear_d0");
                }
                player.doa.var_e651a75e = 1;
                continue;
            }
            player.doa.var_e651a75e = 0;
        }
        wait 0.1;
    }
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0xb5161a51, Offset: 0x6320
// Size: 0x1ac
function function_d64204d9() {
    level endon(#"redins_rally_complete");
    level endon(#"hash_16154574");
    level endon(#"player_challenge_failure");
    self endon(#"disconnect");
    self.doa.var_8779c24b = 0;
    while (true) {
        self waittill(#"hash_108fd845");
        if (!isdefined(self.room)) {
            continue;
        }
        self.doa.var_8779c24b++;
        self.doa.var_f219339a++;
        level clientfield::set("set_ui_gprDOA" + self.entnum, self.doa.var_f219339a);
        self.room.var_b57e2384 += 1;
        level clientfield::set("set_ui_GlobalGPR0", self.room.var_b57e2384);
        if (self.doa.var_8779c24b >= getdvarint("scr_redins_enemy_count", 1)) {
            self.doa.var_8779c24b = 0;
            self.doa.var_37efabf7++;
            if (self.doa.var_37efabf7 > 3) {
                self.doa.var_37efabf7 = 3;
            }
            self.doa.var_c5e98ad6 = self.doa.var_37efabf7;
        }
    }
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0x694f1f85, Offset: 0x64d8
// Size: 0x3bc
function function_dae418ed() {
    self endon(#"disconnect");
    while (!isdefined(self.doa)) {
        wait 0.05;
    }
    waittillframeend();
    startpoints = struct::get_array("truck_soccer_player_spawnpoint");
    foreach (point in startpoints) {
        if (self.entnum == int(point.script_noteworthy)) {
            spot = point;
            break;
        }
    }
    var_f3a9458e = getent("doa_redins_truck", "targetname");
    truck = var_f3a9458e spawner::spawn(1);
    truck setmodel("veh_t7_civ_truck_pickup_tech_nrc_mini_" + namespace_831a4a7c::function_ee495f41(self.entnum));
    truck.origin = spot.origin;
    truck.spawnpoint = spot.origin;
    truck.angles = spot.angles;
    truck.spawnangles = spot.angles;
    truck thread function_9c687a5d(self);
    truck usevehicle(self, 0);
    truck makeunusable();
    truck.takedamage = 0;
    truck.team = self.team;
    truck.owner = self;
    truck.owner.doa.var_e9fdebdf = int(spot.script_parameters);
    self.doa.vehicle = truck;
    self.doa.var_3024fd0f = 1;
    self.doa.var_3e3bcaa1 = 1;
    self thread function_e619ee5(truck);
    truck thread namespace_eaa992c::function_285a2999("gem_trail_" + namespace_831a4a7c::function_ee495f41(self.entnum));
    self freezecontrols(!level flag::get("doa_challenge_running"));
    wait 0.05;
    self enableinvulnerability();
    self thread function_810ced6b();
    self namespace_5e6c5d1f::function_8397461e();
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x64f5f6a0, Offset: 0x68a0
// Size: 0x364
function function_c7e4d911(room) {
    room.var_e5c8b9e7 = level.doa.var_bc9b7c71;
    level.doa.var_bc9b7c71 = &function_dae418ed;
    room.text = %CP_DOA_BO3_CHALLENGE_ROOM_TRUCKSOCCER;
    room.title = %CP_DOA_BO3_TITLE_ROOM_TRUCKSOCCER;
    room.vox = "vox_doaa_chicken_bowl";
    room.var_7daa1c03 = struct::get("truck_soccer_ball", "targetname");
    room.var_14ee1a58 = getent("doa_mork_veh", "targetname");
    room.var_d88cc53c = namespace_3ca3c537::function_dc34896f();
    room.host_migration = &function_c2b99e74;
    room.var_677f63c8 = [];
    room.var_efbfafed = 0;
    foreach (player in getplayers()) {
        player thread function_dae418ed();
    }
    triggers = getentarray("truck_soccerr_goal_trigger", "targetname");
    foreach (trigger in triggers) {
        trigger thread function_71be5ae5(room);
    }
    triggers = getentarray("truck_soccer_blowTrigger", "targetname");
    foreach (trigger in triggers) {
        trigger thread trucksoccer_BlowTriggerThink(room);
    }
    level thread function_88777838(room);
    level flag::set("doa_challenge_ready");
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xc8c11d9b, Offset: 0x6c10
// Size: 0x15c
function function_5284e8dc(room) {
    level endon(#"trucksoccer_rally_complete");
    if (room.var_677f63c8.size > getdvarint("scr_doa_chicken_balls_max", 3)) {
        return;
    }
    room.var_14ee1a58.ignorespawninglimit = 1;
    var_29833f21 = room.var_14ee1a58 spawner::spawn(1, undefined, (0, 0, 0));
    var_29833f21.origin = room.var_7daa1c03.origin;
    wait 0.05;
    var_29833f21.health = 6000;
    var_29833f21.var_6977f7b9 = 1;
    var_29833f21 launchvehicle((0, 0, 100), (0, 0, 0), 1, 1);
    room.var_677f63c8[room.var_677f63c8.size] = var_29833f21;
    var_29833f21 thread function_76dd5557(room);
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x63f59c27, Offset: 0x6d78
// Size: 0x168
function function_76dd5557(room) {
    self endon(#"death");
    wait 8;
    while (true) {
        if (isdefined(self) && !self istouching(room.var_d88cc53c)) {
            arrayremovevalue(room.var_677f63c8, self);
            self delete();
        }
        if (isdefined(self.var_a2d7b04a)) {
            self.var_a2d7b04a thread function_db9097e4(room);
            self thread namespace_1a381543::function_90118d8c("zmb_eggbowl_goal");
            level thread function_8f4c809d(room, self.var_a2d7b04a);
            arrayremovevalue(room.var_677f63c8, self);
            wait 5;
            self thread namespace_eaa992c::function_285a2999("egg_hatch");
            util::wait_network_frame();
            self delete();
        }
        wait 0.05;
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xe88a10d1, Offset: 0x6ee8
// Size: 0x3e
function function_90585f48(room) {
    level endon(#"trucksoccer_rally_complete");
    while (true) {
        level thread function_5284e8dc(room);
        wait 8;
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x754a7181, Offset: 0x6f30
// Size: 0x1b2
function function_ebb572b(player) {
    var_516eed4b = randomint(6) + 1;
    switch (player.entnum) {
    case 0:
        gem = "zombietron_emerald";
        break;
    case 1:
        gem = "zombietron_sapphire";
        break;
    case 2:
        gem = "zombietron_ruby";
        break;
    case 3:
        gem = "zombietron_beryl";
        break;
    }
    items = level namespace_a7e6beb5::function_16237a19(self.origin, var_516eed4b, 2, 0, 0, 3, gem);
    wait 1;
    foreach (item in items) {
        if (!isdefined(item)) {
            continue;
        }
        if (isdefined(item.trigger)) {
            item.trigger notify(#"trigger", player);
        }
        wait 0.5;
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x2166ca00, Offset: 0x70f0
// Size: 0xa2
function function_db9097e4(room) {
    foreach (player in self.var_f1e29613) {
        if (!isdefined(player)) {
            continue;
        }
        self thread function_ebb572b(player);
    }
}

// Namespace namespace_df93fc7c
// Params 2, eflags: 0x1 linked
// Checksum 0x6c501e7a, Offset: 0x71a0
// Size: 0xce
function function_7c9617ef(var_7bb420a0, goaltrigger) {
    self endon(#"death");
    level waittill(#"hash_130fa748");
    while (true) {
        self moveto(goaltrigger.var_363b3ac2[var_7bb420a0].origin, goaltrigger.movetime);
        self util::waittill_any_timeout(goaltrigger.movetime + 0.25, "movedone");
        var_7bb420a0++;
        if (var_7bb420a0 >= goaltrigger.var_363b3ac2.size) {
            var_7bb420a0 = 0;
        }
    }
}

// Namespace namespace_df93fc7c
// Params 2, eflags: 0x1 linked
// Checksum 0x3f70f413, Offset: 0x7278
// Size: 0x734
function function_60fcd122(room, goaltrigger) {
    level endon(#"trucksoccer_rally_complete");
    goaltrigger.movetime = getdvarfloat("scr_doa_chicken_bowl_glow_default_speed", 1.25);
    goaltrigger.var_363b3ac2 = [];
    goaltrigger.var_363b3ac2[goaltrigger.var_363b3ac2.size] = struct::get(goaltrigger.target, "targetname");
    goaltrigger.colors = strtok(goaltrigger.var_363b3ac2[0].script_parameters, " ");
    for (next = struct::get(goaltrigger.var_363b3ac2[0].target, "targetname"); next != goaltrigger.var_363b3ac2[0]; next = struct::get(next.target, "targetname")) {
        goaltrigger.var_363b3ac2[goaltrigger.var_363b3ac2.size] = next;
    }
    idx = 1;
    foreach (glow in goaltrigger.var_363b3ac2) {
        glow.org = spawn("script_model", glow.origin);
        glow.org.targetname = "glowOrg";
        glow.org setmodel("tag_origin");
        glow.org thread function_7c9617ef(idx, goaltrigger);
        idx++;
        if (idx >= goaltrigger.var_363b3ac2.size) {
            idx = 0;
        }
    }
    var_f14ce542 = 0;
    while (true) {
        if (goaltrigger.var_f1e29613.size == 0) {
            if (goaltrigger.var_f1e29613.size != var_f14ce542) {
                foreach (glow in goaltrigger.var_363b3ac2) {
                    if (!isdefined(glow.org)) {
                        continue;
                    }
                    foreach (color in goaltrigger.colors) {
                        glow.org thread namespace_eaa992c::turnofffx("gem_trail_" + color);
                    }
                }
                var_f14ce542 = 0;
            }
            wait 0.05;
            continue;
        }
        if (goaltrigger.var_f1e29613.size != var_f14ce542) {
            count = 0;
            foreach (glow in goaltrigger.var_363b3ac2) {
                if (!isdefined(glow.org)) {
                    continue;
                }
                foreach (color in goaltrigger.colors) {
                    glow.org thread namespace_eaa992c::turnofffx("gem_trail_" + color);
                }
                count++;
            }
            while (count > 0) {
                level util::waittill_any_timeout(1, "off_fx_queue_processed", "trucksoccer_rally_complete");
                count--;
            }
            idx = 0;
            foreach (glow in goaltrigger.var_363b3ac2) {
                if (!isdefined(glow.org)) {
                    continue;
                }
                player = goaltrigger.var_f1e29613[idx];
                idx++;
                if (idx >= goaltrigger.var_f1e29613.size) {
                    idx = 0;
                }
                if (isdefined(player)) {
                    glow.org thread namespace_eaa992c::function_285a2999("gem_trail_" + namespace_831a4a7c::function_ee495f41(player.entnum));
                }
            }
            var_f14ce542 = goaltrigger.var_f1e29613.size;
        }
        wait 0.05;
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xbb709a70, Offset: 0x79b8
// Size: 0x248
function trucksoccer_BlowTriggerThink(room) {
    level endon(#"trucksoccer_rally_complete");
    self.org = spawn("script_model", self.origin);
    self.org.targetname = "trucksoccer_BlowTriggerThink";
    self.org setmodel("tag_origin");
    self.org thread namespace_eaa992c::function_285a2999("blow_hole");
    while (true) {
        self waittill(#"trigger", guy);
        if (!isdefined(guy)) {
            continue;
        }
        if (isactor(guy) && !(isdefined(guy.launched) && guy.launched)) {
            guy startragdoll();
            guy launchragdoll((0, 0, -36 + randomint(40)));
            guy.launched = 1;
            guy thread namespace_49107f3a::function_ba30b321(0.2);
            continue;
        }
        if (isdefined(guy.var_6977f7b9) && guy.var_6977f7b9) {
            guy launchvehicle((0, 0, getdvarint("scr_doa_chicken_bowl_blow_force", 5)), (0, 0, 0), 1);
            continue;
        }
        if (isvehicle(guy)) {
            guy launchvehicle((0, 0, getdvarint("scr_doa_chicken_bowl_blow_force", 50)), (0, 0, 0), 1);
        }
    }
}

// Namespace namespace_df93fc7c
// Params 2, eflags: 0x1 linked
// Checksum 0x51dbd4eb, Offset: 0x7c08
// Size: 0xc0
function function_8f4c809d(room, goaltrigger) {
    level endon(#"trucksoccer_rally_complete");
    goaltrigger notify(#"hash_8f4c809d");
    goaltrigger endon(#"hash_8f4c809d");
    room.var_efbfafed++;
    goaltrigger.movetime = getdvarfloat("scr_doa_chicken_bowl_glow_goal_speed", 0.1);
    wait getdvarfloat("scr_doa_chicken_bowl_glow_celebrate_time", 4);
    goaltrigger.movetime = getdvarfloat("scr_doa_chicken_bowl_glow_default_speed", 1.25);
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xbe388ba4, Offset: 0x7cd0
// Size: 0x268
function function_71be5ae5(room) {
    level endon(#"trucksoccer_rally_complete");
    self.var_f1e29613 = [];
    self.myteam = int(self.script_noteworthy);
    level thread function_60fcd122(room, self);
    while (true) {
        foreach (var_29833f21 in room.var_677f63c8) {
            if (isdefined(var_29833f21) && var_29833f21 istouching(self)) {
                var_29833f21.var_a2d7b04a = self;
            }
        }
        var_9365e303 = 0;
        players = getplayers();
        self.var_f1e29613 = [];
        foreach (player in players) {
            if (!isdefined(player)) {
                continue;
            }
            if (!isdefined(player.doa)) {
                continue;
            }
            if (isdefined(player.doa.var_e9fdebdf) && player.doa.var_e9fdebdf == self.myteam) {
                if (!isinarray(self.var_f1e29613, player)) {
                    self.var_f1e29613[self.var_f1e29613.size] = player;
                }
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xd6b17b88, Offset: 0x7f40
// Size: 0x72
function function_88777838(room) {
    level waittill(#"hash_97276c43");
    wait 1;
    level clientfield::set("startCountdown", 3);
    wait 4;
    level clientfield::set("startCountdown", 0);
    level notify(#"hash_130fa748");
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xb6831738, Offset: 0x7fc0
// Size: 0xc
function function_92349eb6(room) {
    
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xd380a261, Offset: 0x7fd8
// Size: 0xc
function function_fd4f5419(room) {
    
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x45046aa7, Offset: 0x7ff0
// Size: 0x2cc
function function_2ea4cb82(room) {
    foreach (player in getplayers()) {
        player freezecontrols(1);
        player.room = room;
        if (isdefined(player.doa)) {
            player.doa.var_1951557 = 1;
        }
    }
    level waittill(#"hash_130fa748");
    level flag::set("doa_challenge_running");
    foreach (player in getplayers()) {
        player freezecontrols(0);
        player.room = room;
        if (isdefined(player.doa)) {
            player.doa.var_1951557 = undefined;
        }
    }
    level thread function_55e9043d();
    level thread function_90585f48(room);
    if (getdvarint("scr_doa_soak_think", 0) > 1) {
        wait 5;
    } else {
        wait room.timeout - 1;
    }
    if (room.var_efbfafed > getplayers().size * 3) {
        level notify(#"hash_16154574");
    } else {
        level notify(#"player_challenge_failure");
    }
    playsoundatposition("zmb_eggbowl_whistle", (0, 0, 0));
    level notify(#"trucksoccer_rally_complete");
    namespace_a7e6beb5::function_c1869ec8();
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xd2d3b733, Offset: 0x82c8
// Size: 0x222
function function_baa38e65(room) {
    triggers = getentarray("truck_soccerr_goal_trigger", "targetname");
    foreach (trigger in triggers) {
        if (isdefined(trigger.var_363b3ac2)) {
            foreach (var_18af6993 in trigger.var_363b3ac2) {
                if (isdefined(var_18af6993.org)) {
                    var_18af6993.org delete();
                }
            }
        }
    }
    triggers = getentarray("truck_soccer_blowTrigger", "targetname");
    foreach (trigger in triggers) {
        if (isdefined(trigger.org)) {
            trigger.org delete();
        }
    }
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0x18c9fdca, Offset: 0x84f8
// Size: 0x1e2
function function_55e9043d() {
    level endon(#"hash_16154574");
    level endon(#"player_challenge_failure");
    level endon(#"trucksoccer_rally_complete");
    while (true) {
        level waittill(#"hash_c62f5087", left);
        if (left == 50) {
            break;
        }
    }
    var_48be25f5 = getent("doa_basic_spawner", "targetname");
    spawnpoints = struct::get_array("truck_soccer_dirt_spawner");
    while (true) {
        count = namespace_49107f3a::function_b99d78c7();
        if (count < getdvarint("scr_trucksoccer_enemy_count", 50)) {
            ai = namespace_51bd792::function_45849d81(var_48be25f5, spawnpoints[randomint(spawnpoints.size)], undefined);
            if (isdefined(ai)) {
                ai forceteleport(ai.origin, (0, randomint(360), 0));
                ai notify(#"hash_6e8326fc");
                ai thread namespace_49107f3a::function_24245456(level, "trucksoccer_rally_complete");
            }
            wait randomfloatrange(0.05, 0.4);
            continue;
        }
        wait 3;
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xc3360678, Offset: 0x86e8
// Size: 0x2b2
function function_b3939e94(room) {
    level notify(#"trucksoccer_rally_complete");
    namespace_a7e6beb5::function_c1869ec8();
    level thread namespace_49107f3a::function_f798b582();
    function_baa38e65(room);
    foreach (player in getplayers()) {
        player notify(#"hash_7c5410c4");
        if (isdefined(player) && isdefined(player.doa)) {
            if (isdefined(player.doa.vehicle)) {
                player.doa.vehicle usevehicle(player, 0);
                player.doa.vehicle delete();
                player.doa.vehicle = undefined;
            }
            player.doa.var_3024fd0f = undefined;
            player.doa.var_3e3bcaa1 = undefined;
            player disableinvulnerability();
            player thread namespace_831a4a7c::turnplayershieldon(0);
            player namespace_2848f8c2::function_d41a4517();
        }
    }
    level.doa.var_bc9b7c71 = room.var_e5c8b9e7;
    foreach (egg in room.var_677f63c8) {
        if (isdefined(egg)) {
            egg delete();
        }
    }
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x0
// Checksum 0x3477ac80, Offset: 0x89a8
// Size: 0xbc
function function_6274a031() {
    self endon(#"death");
    if (self clientfield::get("toggle_lights_group1")) {
        self vehicle::toggle_lights_group(1, 0);
        util::wait_network_frame();
    }
    self vehicle::toggle_lights_group(1, 1);
    self playsound("veh_doa_boost");
    wait 3;
    self vehicle::toggle_lights_group(1, 0);
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xa47a4758, Offset: 0x8a70
// Size: 0x1e0
function function_e619ee5(vehicle) {
    level endon(#"trucksoccer_rally_complete");
    level endon(#"player_challenge_failure");
    self notify(#"hash_2747daf7");
    self endon(#"hash_2747daf7");
    self endon(#"disconnect");
    vehicle endon(#"death");
    level.launchforce = 500;
    vehicle vehicle::toggle_lights_group(1, 0);
    self.doa.var_f6a4f3f = 0;
    while (true) {
        wait 0.05;
        if (!level flag::get("doa_challenge_running")) {
            continue;
        }
        if (isdefined(self.doa.vehicle) && self changeseatbuttonpressed() && gettime() > self.doa.var_f6a4f3f && !(isdefined(self.doa.var_1951557) && self.doa.var_1951557)) {
            self.doa.var_f6a4f3f = gettime() + getdvarint("scr_doa_chicken_bowl_boostinterval", 4000);
            curdir = (level.launchforce, 0, 0);
            vehicle launchvehicle(curdir, (0, 0, 0), 1);
            vehicle thread function_fa6d5f56();
            while (self changeseatbuttonpressed()) {
                wait 0.05;
            }
        }
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xa4ca3f8d, Offset: 0x8c58
// Size: 0x280
function function_c0485deb(def) {
    level endon(#"exit_taken");
    wait 7;
    level thread function_c35db0c1();
    var_a558424 = struct::get_array("farm_cow_spawn", "script_noteworthy");
    level.doa.var_99f9e71a["top"] = [];
    level.doa.var_99f9e71a["bottom"] = [];
    level.doa.var_99f9e71a["right"] = [];
    level.doa.var_99f9e71a["left"] = [];
    foreach (cow in var_a558424) {
        level.doa.var_99f9e71a[cow.script_parameters][level.doa.var_99f9e71a[cow.script_parameters].size] = cow;
    }
    var_1d44023c = namespace_49107f3a::function_5b4fbaef();
    var_f11f9ddc = var_1d44023c;
    while (level flag::get("doa_round_spawning")) {
        side = namespace_49107f3a::function_5b4fbaef();
        if (side == var_1d44023c || side == var_f11f9ddc) {
            wait 0.05;
            continue;
        }
        var_f11f9ddc = var_1d44023c;
        var_1d44023c = side;
        level function_dfbad276(randomintrange(5, 10), side);
        wait randomintrange(1, 3);
    }
}

// Namespace namespace_df93fc7c
// Params 2, eflags: 0x1 linked
// Checksum 0x5a525e22, Offset: 0x8ee0
// Size: 0x526
function function_dfbad276(number, startside) {
    level endon(#"exit_taken");
    spawn_locations = level.doa.var_99f9e71a[startside];
    while (number > 0) {
        spawn_point = spawn_locations[randomint(spawn_locations.size)];
        var_2d4a3b56 = struct::get(spawn_point.target, "targetname");
        trace = bullettrace(spawn_point.origin, spawn_point.origin + (0, 0, -500), 0, undefined);
        spawn_point = (spawn_point.origin[0], spawn_point.origin[1], trace["position"][2]);
        trace = bullettrace(var_2d4a3b56.origin, var_2d4a3b56.origin + (0, 0, -500), 0, undefined);
        var_2d4a3b56 = (var_2d4a3b56.origin[0], var_2d4a3b56.origin[1], trace["position"][2]);
        desired_angles = vectortoangles(var_2d4a3b56 - spawn_point);
        desired_yaw = angleclamp180(desired_angles[1]);
        cow = spawn("script_model", spawn_point);
        cow.targetname = "cow";
        cow.angles = (0, desired_yaw + 90, 0);
        cow setmodel("zombietron_water_buffalo");
        cow makefakeai();
        cow setcandamage(1);
        cow.health = 3999999;
        cow.team = "axis";
        cow.script_noteworthy = "cow";
        cow.var_755108a1 = distance(cow.origin, var_2d4a3b56);
        cow.move_time = cow.var_755108a1 / getdvarint("cp_doa_cow_run_units_per_sec", -49);
        cow setplayercollision(1);
        cow playloopsound("zmb_cow_run_lp", 2);
        if (randomint(getdvarint("cp_doa_sacred_cow_chance", 20)) == 0) {
            cow.var_67e71889 = 1;
            cow thread namespace_eaa992c::function_285a2999("cow_sacred");
        }
        trigger = spawn("trigger_radius", cow.origin + (0, 0, -10), 3, 34, 100);
        trigger.targetname = "cow";
        trigger enablelinkto();
        trigger linkto(cow);
        trigger thread function_d1dd8def(cow);
        trigger thread namespace_49107f3a::function_981c685d(cow);
        cow.trigger = trigger;
        cow thread function_9cee4436(var_2d4a3b56);
        cow thread function_57ff2866();
        wait randomfloatrange(0.65, 2.5);
        number--;
    }
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x0
// Checksum 0x1e11e6ba, Offset: 0x9410
// Size: 0x86
function function_caf96f2d() {
    self endon(#"death");
    self useanimtree(#critter);
    while (true) {
        self animscripted("anim", self.origin, self.angles, self.animation);
        self waittillmatch(#"anim", "end");
    }
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0x6647c26b, Offset: 0x94a0
// Size: 0x2a
function function_c9a224d9() {
    self endon(#"death");
    level waittill(#"exit_taken");
    self notify(#"hash_822ea49f");
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0xb1fb16e2, Offset: 0x94d8
// Size: 0x64
function function_57ff2866() {
    self endon(#"death");
    self thread function_c9a224d9();
    self waittill(#"hash_822ea49f");
    util::wait_network_frame();
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0xf43c9c52, Offset: 0x9548
// Size: 0xee
function function_9cee4436(dest) {
    self endon(#"death");
    self useanimtree(#critter);
    self.animation = randomint(2) ? critter%a_water_buffalo_run_a : critter%a_water_buffalo_run_b;
    self clientfield::set("runcowanim", 1);
    self thread function_3c416d7e();
    self moveto(dest, self.move_time, 0, 0);
    self waittill(#"movedone");
    self notify(#"hash_822ea49f");
}

// Namespace namespace_df93fc7c
// Params 1, eflags: 0x1 linked
// Checksum 0x61a5472f, Offset: 0x9640
// Size: 0x278
function function_d1dd8def(cow) {
    cow endon(#"death");
    while (true) {
        self waittill(#"trigger", guy);
        if (!isdefined(guy)) {
            continue;
        }
        if (isdefined(guy.launched)) {
            continue;
        }
        if (!issentient(guy)) {
            continue;
        }
        if (!(isdefined(guy.takedamage) && guy.takedamage)) {
            continue;
        }
        if (isdefined(guy.boss)) {
            continue;
        }
        guy playsound("zmb_buffalo_impact");
        if (!isplayer(guy)) {
            if (!isvehicle(guy)) {
                guy clientfield::set("zombie_rhino_explosion", 1);
                namespace_fba031c8::trygibbinglimb(guy, 5000);
                namespace_fba031c8::trygibbinglegs(guy, 5000, undefined, 1);
                guy setplayercollision(0);
                guy startragdoll();
                guy launchragdoll((0, 0, 220));
                guy.launched = 1;
                guy playsound("zmb_ragdoll_launched");
                guy thread namespace_49107f3a::function_ba30b321(0.2);
            } else {
                guy kill(guy.origin);
            }
            continue;
        }
        guy dodamage(guy.health + 1000, guy.origin, undefined, undefined, "MOD_EXPLOSIVE");
    }
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0xa72d981b, Offset: 0x98c0
// Size: 0x2c4
function function_3c416d7e() {
    self endon(#"death");
    while (true) {
        self waittill(#"damage", damagetaken, attacker, dir, point, var_e5f012d6, model, tag, part, weapon, flags);
        if (var_e5f012d6 == "MOD_PROJECTILE" || var_e5f012d6 == "MOD_GRENADE" || var_e5f012d6 == "MOD_CRUSH" || weapon == level.doa.var_69899304) {
            if (isdefined(attacker)) {
                if (isdefined(attacker.owner)) {
                    attacker = attacker.owner;
                }
                if (isplayer(attacker)) {
                    attacker.doa.var_ec573900++;
                }
            }
            self thread namespace_eaa992c::function_285a2999("cow_explode");
            self playsound("zmb_cow_explode");
            self notify(#"hash_822ea49f");
            if (isdefined(self.var_67e71889)) {
                if (isplayer(attacker)) {
                    attacker.doa.var_130471f++;
                }
                self playsound("zmb_cow_explode_gold");
                location = self.origin;
                var_888caf9f = namespace_831a4a7c::function_5eb6e4d1().size + 10;
                maxamount = namespace_831a4a7c::function_5eb6e4d1().size + 20;
                level thread namespace_a7e6beb5::function_16237a19(location, randomintrange(var_888caf9f, maxamount), 85, 1, 1, 1, undefined, 0);
                self.var_67e71889 = undefined;
            }
            continue;
        }
        self.health += damagetaken;
    }
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0xcf675a3e, Offset: 0x9b90
// Size: 0xc0
function function_204c35f0() {
    level endon(#"exit_taken");
    while (level flag::get("doa_round_active") && !level flag::get("doa_game_is_over")) {
        side = namespace_49107f3a::function_5b4fbaef();
        function_dfbad276(randomintrange(2, 6), side);
        wait randomintrange(10, 30);
    }
}

// Namespace namespace_df93fc7c
// Params 0, eflags: 0x1 linked
// Checksum 0x139eb767, Offset: 0x9c58
// Size: 0x58
function function_c35db0c1() {
    level endon(#"teleporter_triggered");
    while (!level flag::get("doa_game_is_over")) {
        level waittill(#"hash_c87feb68");
        wait 10;
        level thread function_204c35f0();
    }
}

