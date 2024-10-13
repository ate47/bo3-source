#using scripts/shared/ai/zombie_utility;
#using scripts/zm/_zm_audio;
#using scripts/zm/zm_stalingrad_dragon;
#using scripts/zm/_zm_ai_sentinel_drone;
#using scripts/zm/_zm_ai_raz;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_stalingrad_util;

// Namespace zm_stalingrad_util
// Params 0, eflags: 0x1 linked
// Checksum 0xe2f3bf56, Offset: 0x610
// Size: 0x4c
function main() {
    level thread function_828240c9();
    level thread flag_init();
    level thread function_28c0c208();
}

// Namespace zm_stalingrad_util
// Params 0, eflags: 0x1 linked
// Checksum 0xd064adfb, Offset: 0x668
// Size: 0x64
function flag_init() {
    level flag::init("wave_event_raz_spawning_active");
    level flag::init("wave_event_sentinel_spawning_active");
    level flag::init("wave_event_zombies_complete");
}

// Namespace zm_stalingrad_util
// Params 0, eflags: 0x1 linked
// Checksum 0x350ce5d5, Offset: 0x6d8
// Size: 0x4c
function function_828240c9() {
    level waittill(#"start_zombie_round_logic");
    if (isdefined(level._custom_powerups["shield_charge"])) {
        arrayremoveindex(level._custom_powerups, "shield_charge", 1);
    }
}

// Namespace zm_stalingrad_util
// Params 0, eflags: 0x1 linked
// Checksum 0xd330d8ff, Offset: 0x730
// Size: 0x76
function function_e7c75cf0() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        e_player = players[i];
        e_player zm::spectator_respawn_player();
    }
}

// Namespace zm_stalingrad_util
// Params 0, eflags: 0x1 linked
// Checksum 0xb6de9779, Offset: 0x7b0
// Size: 0x190
function function_3fbe7d5f() {
    while (isdefined(self)) {
        waittime = randomfloatrange(2.5, 5);
        yaw = randomint(360);
        if (yaw > 300) {
            yaw = 300;
        } else if (yaw < 60) {
            yaw = 60;
        }
        yaw = self.angles[1] + yaw;
        new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
        self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
        if (isdefined(self.worldgundw)) {
            self.worldgundw rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
        }
        wait randomfloat(waittime - 0.1);
    }
}

// Namespace zm_stalingrad_util
// Params 0, eflags: 0x1 linked
// Checksum 0xb3bbdc95, Offset: 0x948
// Size: 0x40
function function_acd04dc9() {
    self endon(#"death");
    if (!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
        self waittill(#"completed_emerging_into_playable_area");
    }
    self.no_powerups = 1;
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0x4aca42cc, Offset: 0x990
// Size: 0xc4
function function_1af75b1b(n_distance) {
    foreach (e_player in level.players) {
        if (zm_utility::is_player_valid(e_player, 0, 1) && function_86b1188c(n_distance, self, e_player)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_stalingrad_util
// Params 3, eflags: 0x1 linked
// Checksum 0xc6bb90f3, Offset: 0xa60
// Size: 0x7e
function function_86b1188c(n_distance, var_d21815c4, var_441f84ff) {
    var_31dc18aa = n_distance * n_distance;
    var_2931dc75 = distancesquared(var_d21815c4.origin, var_441f84ff.origin);
    if (var_2931dc75 <= var_31dc18aa) {
        return true;
    }
    return false;
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0x6e3e2ca0, Offset: 0xae8
// Size: 0xac
function function_2f621485(b_disable) {
    if (!isdefined(b_disable)) {
        b_disable = 1;
    }
    if (b_disable && level flag::get("pack_machine_in_use")) {
        level flag::wait_till_clear("pack_machine_in_use");
    }
    var_1ac74da9 = getent("pack_a_punch", "script_noteworthy");
    var_1ac74da9 triggerenable(!b_disable);
}

// Namespace zm_stalingrad_util
// Params 4, eflags: 0x1 linked
// Checksum 0xc5d6dd9a, Offset: 0xba0
// Size: 0x14a
function function_f8043960(var_57216c49, e_volume, var_50efb072, var_2f65a401) {
    if (!isdefined(e_volume)) {
        e_volume = undefined;
    }
    if (!isdefined(var_50efb072)) {
        var_50efb072 = 1;
    }
    if (!isdefined(var_2f65a401)) {
        var_2f65a401 = undefined;
    }
    while (true) {
        e_player = level waittill(#"hash_fbd59317");
        if (isdefined(var_2f65a401) && ![[ var_2f65a401 ]](e_player)) {
            continue;
        }
        if (isdefined(e_volume) && !e_player istouching(e_volume)) {
            continue;
        }
        var_5572b89 = e_player function_7fbdcc5f(var_57216c49);
        if (isdefined(e_player)) {
            e_player.var_9d9ac25d = undefined;
        }
        if (isdefined(var_5572b89) && var_5572b89) {
            if (isdefined(e_volume) && var_50efb072) {
                e_volume delete();
            }
            return;
        }
    }
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0x1c2701b7, Offset: 0xcf8
// Size: 0x96
function function_7fbdcc5f(var_57216c49) {
    self endon(#"death");
    self.var_4bd1ce6b endon(#"death");
    self.var_9d9ac25d = 1;
    self.var_4bd1ce6b vehicle_ai::start_scripted();
    var_5572b89 = self [[ var_57216c49 ]]();
    self.var_4bd1ce6b vehicle_ai::stop_scripted();
    if (isdefined(var_5572b89) && var_5572b89) {
        return true;
    }
    return false;
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0x610a1bb, Offset: 0xd98
// Size: 0x5a2
function function_adf4d1d0(a_ai_zombies) {
    var_63baafec = !isdefined(a_ai_zombies);
    if (var_63baafec) {
        a_ai_zombies = getaiteamarray(level.zombie_team);
    }
    var_6b1085eb = [];
    foreach (ai_zombie in a_ai_zombies) {
        ai_zombie.no_powerups = 1;
        ai_zombie.deathpoints_already_given = 1;
        if (isdefined(ai_zombie.var_81e263d5) && ai_zombie.var_81e263d5) {
            continue;
        }
        if (isdefined(ai_zombie.marked_for_death) && ai_zombie.marked_for_death) {
            continue;
        }
        if (isdefined(ai_zombie.nuke_damage_func)) {
            ai_zombie thread [[ ai_zombie.nuke_damage_func ]]();
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(ai_zombie)) {
            continue;
        }
        ai_zombie.marked_for_death = 1;
        ai_zombie.nuked = 1;
        var_6b1085eb[var_6b1085eb.size] = ai_zombie;
    }
    foreach (var_f92b3d80 in var_6b1085eb) {
        if (!isdefined(var_f92b3d80)) {
            continue;
        }
        if (zm_utility::is_magic_bullet_shield_enabled(var_f92b3d80)) {
            continue;
        }
        if (isdefined(var_f92b3d80.var_81e263d5) && var_f92b3d80.var_81e263d5) {
            continue;
        }
        var_f92b3d80 dodamage(var_f92b3d80.health, var_f92b3d80.origin);
        if (!(isdefined(var_f92b3d80.exclude_cleanup_adding_to_total) && var_f92b3d80.exclude_cleanup_adding_to_total) && !level flag::get("special_round")) {
            level.zombie_total++;
        }
        wait randomfloatrange(0.05, 0.15);
    }
    if (var_63baafec) {
        a_ai_raz = getaiarchetypearray("raz");
        foreach (ai_raz in a_ai_raz) {
            if (isdefined(ai_raz.var_81e263d5) && ai_raz.var_81e263d5) {
                continue;
            }
            if (!(isdefined(ai_raz.exclude_cleanup_adding_to_total) && ai_raz.exclude_cleanup_adding_to_total) && !level flag::get("special_round")) {
                level.zombie_total++;
            }
            ai_raz.no_powerups = 1;
            ai_raz kill();
        }
        var_1916d2ed = getaiarchetypearray("sentinel_drone");
        foreach (var_663b2442 in var_1916d2ed) {
            if (isdefined(var_663b2442.var_81e263d5) && var_663b2442.var_81e263d5) {
                continue;
            }
            if (!(isdefined(var_663b2442.exclude_cleanup_adding_to_total) && var_663b2442.exclude_cleanup_adding_to_total) && !level flag::get("special_round")) {
                level.zombie_total++;
            }
            var_663b2442.no_powerups = 1;
            var_663b2442 kill();
        }
    }
}

// Namespace zm_stalingrad_util
// Params 2, eflags: 0x1 linked
// Checksum 0x6a2fa752, Offset: 0x1348
// Size: 0xfc
function function_3804dbf1(var_da005640, str_endon) {
    if (!isdefined(var_da005640)) {
        var_da005640 = 1;
    }
    if (!isdefined(str_endon)) {
        str_endon = undefined;
    }
    if (var_da005640) {
        if (isdefined(str_endon)) {
            level endon(str_endon);
        }
        if (!level flag::get("spawn_zombies")) {
            level flag::wait_till("spawn_zombies");
        }
        level.disable_nuke_delay_spawning = 1;
        level flag::clear("spawn_zombies");
        return;
    }
    if (isdefined(str_endon)) {
        level notify(str_endon);
    }
    level.disable_nuke_delay_spawning = 1;
    level flag::set("spawn_zombies");
}

// Namespace zm_stalingrad_util
// Params 8, eflags: 0x1 linked
// Checksum 0x2723446f, Offset: 0x1450
// Size: 0x544
function function_f70dde0b(var_f328e82, a_s_spawnpoints, var_9c84987b, var_2494b61e, var_dc7b7a0f, n_max_zombies, str_notify, var_d965b1c7) {
    if (!isdefined(var_2494b61e)) {
        var_2494b61e = 24;
    }
    if (!isdefined(var_dc7b7a0f)) {
        var_dc7b7a0f = 0.05;
    }
    if (!isdefined(var_d965b1c7)) {
        var_d965b1c7 = 0;
    }
    assert(isdefined(var_f328e82), "<dev string:x28>");
    assert(isdefined(a_s_spawnpoints), "<dev string:x47>");
    assert(isdefined(var_9c84987b), "<dev string:x78>");
    level notify(#"hash_91fef4b1");
    level endon(#"hash_91fef4b1");
    level flag::clear("wave_event_zombies_complete");
    if (isdefined(str_notify)) {
        level endon(str_notify);
    }
    if (!isdefined(n_max_zombies)) {
        assert(isdefined(str_notify), "<dev string:x99>");
        var_54939bf3 = 1;
    }
    var_9a8fc4a4 = [];
    var_613bb82b = 0;
    if (isdefined(level.var_c3c3ffc5)) {
        level.var_c3c3ffc5 = array::filter(level.var_c3c3ffc5, 0, &function_91d64824);
        var_9a8fc4a4 = arraycopy(level.var_c3c3ffc5);
        var_9a8fc4a4 = array::filter(var_9a8fc4a4, 0, &function_46cd1314);
        level.var_b1d4e9a1 = var_9a8fc4a4.size;
    } else {
        level.var_c3c3ffc5 = [];
        level.var_b1d4e9a1 = 0;
    }
    level.var_258441ba = 0;
    if (isarray(var_f328e82)) {
        e_spawner = array::random(var_f328e82);
    } else {
        e_spawner = var_f328e82;
    }
    while (isdefined(var_54939bf3) && var_54939bf3 || var_613bb82b < n_max_zombies) {
        var_9a8fc4a4 = array::filter(var_9a8fc4a4, 0, &function_91d64824);
        while (isdefined(var_54939bf3) && var_54939bf3 || var_9a8fc4a4.size < var_2494b61e && var_613bb82b < n_max_zombies) {
            var_9a8fc4a4 = array::filter(var_9a8fc4a4, 0, &function_91d64824);
            level function_58cdc394();
            level function_9b76f612("zombie");
            s_spawn_point = function_7e9f0faf(a_s_spawnpoints);
            ai = zombie_utility::spawn_zombie(e_spawner, var_9c84987b, s_spawn_point);
            if (isdefined(ai)) {
                if (!isdefined(var_9a8fc4a4)) {
                    var_9a8fc4a4 = [];
                } else if (!isarray(var_9a8fc4a4)) {
                    var_9a8fc4a4 = array(var_9a8fc4a4);
                }
                var_9a8fc4a4[var_9a8fc4a4.size] = ai;
                if (!isdefined(level.var_c3c3ffc5)) {
                    level.var_c3c3ffc5 = [];
                } else if (!isarray(level.var_c3c3ffc5)) {
                    level.var_c3c3ffc5 = array(level.var_c3c3ffc5);
                }
                level.var_c3c3ffc5[level.var_c3c3ffc5.size] = ai;
                var_613bb82b++;
                ai thread function_ff194e31(var_d965b1c7);
            }
            wait var_dc7b7a0f;
        }
        wait 0.05;
    }
    while (var_9a8fc4a4.size > 0) {
        var_9a8fc4a4 = array::filter(var_9a8fc4a4, 0, &function_91d64824);
        wait 0.5;
    }
    level flag::set("wave_event_zombies_complete");
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0xb7bbb461, Offset: 0x19a0
// Size: 0xac
function function_9b76f612(var_56d259ba) {
    var_eec0f058 = 0;
    if (isdefined(level.var_9ddab511)) {
    }
    for (var_eec0f058 = level [[ level.var_9ddab511 ]](var_56d259ba); isdefined(level.var_4209c599) && level.var_4209c599 || var_eec0f058; var_eec0f058 = level [[ level.var_9ddab511 ]](var_56d259ba)) {
        wait randomfloatrange(0.1, 0.2);
        if (var_eec0f058) {
        }
    }
    level.var_4209c599 = 1;
}

// Namespace zm_stalingrad_util
// Params 0, eflags: 0x1 linked
// Checksum 0x2e2a638a, Offset: 0x1a58
// Size: 0x2c
function function_28c0c208() {
    while (true) {
        util::wait_network_frame();
        level.var_4209c599 = 0;
    }
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0xa39409df, Offset: 0x1a90
// Size: 0x70
function function_91d64824(val) {
    return isalive(val) && !(isdefined(val.aat_turned) && val.aat_turned) && !(isdefined(val.var_1d3a1f9e) && val.var_1d3a1f9e);
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0x6864f0e1, Offset: 0x1b08
// Size: 0x78
function function_46cd1314(val) {
    return isalive(val) && !(isdefined(val.aat_turned) && val.aat_turned) && isdefined(val.archetype) && val.archetype == "zombie";
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0xce31d24a, Offset: 0x1b88
// Size: 0x50
function function_412874e(val) {
    return isalive(val) && isdefined(val.archetype) && val.archetype == "raz";
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0x642c5bd5, Offset: 0x1be0
// Size: 0x50
function function_f0610596(val) {
    return isalive(val) && isdefined(val.archetype) && val.archetype == "sentinel_drone";
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0x7fb587c4, Offset: 0x1c38
// Size: 0xf0
function function_ff194e31(var_d965b1c7) {
    self endon(#"death");
    self thread function_b74ff7d4();
    self setphysparams(15, 0, 72);
    self.ignore_enemy_count = 1;
    self.exclude_cleanup_adding_to_total = 1;
    self.sword_kill_power = 2;
    self.heroweapon_kill_power = 2;
    util::wait_network_frame();
    if (!var_d965b1c7) {
        self.no_damage_points = 1;
        self.deathpoints_already_given = 1;
        self thread function_acd04dc9();
    }
    self zombie_utility::set_zombie_run_cycle("sprint");
    self.nocrawler = 1;
}

// Namespace zm_stalingrad_util
// Params 0, eflags: 0x1 linked
// Checksum 0x8206d0e3, Offset: 0x1d30
// Size: 0x5c
function function_b74ff7d4() {
    ai_zombie = self;
    e_attacker = ai_zombie waittill(#"death");
    if (isplayer(e_attacker)) {
        [[ level.hero_power_update ]](e_attacker, ai_zombie);
    }
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x0
// Checksum 0xd7799767, Offset: 0x1d98
// Size: 0x2c
function function_d182335a(ai_zombie) {
    level.var_b1d4e9a1++;
    ai_zombie waittill(#"death");
    level.var_258441ba++;
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0xd38d5a5a, Offset: 0x1dd0
// Size: 0x158
function function_7e9f0faf(a_s_spawnpoints) {
    var_1bbdbab3 = 0;
    a_valid_spawn_points = [];
    while (!a_valid_spawn_points.size) {
        foreach (s_spawn_point in a_s_spawnpoints) {
            if (!isdefined(s_spawn_point.var_dabf8ae2) || var_1bbdbab3) {
                s_spawn_point.var_dabf8ae2 = 0;
            }
            if (!s_spawn_point.var_dabf8ae2) {
                array::add(a_valid_spawn_points, s_spawn_point, 0);
            }
        }
        if (!a_valid_spawn_points.size) {
            var_1bbdbab3 = 1;
        }
        wait 0.05;
    }
    s_spawn_point = array::random(a_valid_spawn_points);
    s_spawn_point.var_dabf8ae2 = 1;
    return s_spawn_point;
}

// Namespace zm_stalingrad_util
// Params 7, eflags: 0x1 linked
// Checksum 0x12cf87bd, Offset: 0x1f30
// Size: 0x5ea
function function_b55ebb81(a_spawnpoints, var_2b71b5b4, var_15eb9a52, var_f92c3865, var_b4fcee85, var_3642df18, var_ee8c6a82) {
    if (!isdefined(var_ee8c6a82)) {
        var_ee8c6a82 = 0;
    }
    level notify(#"turbine_idle");
    level endon(#"turbine_idle");
    if (isdefined(var_3642df18)) {
        level endon(var_3642df18);
        level thread function_4334972f("wave_event_raz_complete", var_3642df18, "wave_event_raz_spawning_active");
    }
    if (!isdefined(var_2b71b5b4)) {
        assert(isdefined(var_3642df18), "<dev string:xe3>");
        var_54939bf3 = 1;
    }
    if (var_f92c3865 < 0.1) {
        var_f92c3865 = 0.1;
    }
    if (isdefined(var_ee8c6a82) && var_ee8c6a82) {
        var_60d8c6a2 = 0;
    }
    level flag::set("wave_event_raz_spawning_active");
    var_4751753a = [];
    var_766273f0 = 0;
    while (isdefined(var_b4fcee85) && !isdefined(level.var_c3c3ffc5)) {
        wait 0.05;
    }
    if (isdefined(level.var_c3c3ffc5)) {
        level.var_c3c3ffc5 = array::filter(level.var_c3c3ffc5, 0, &function_91d64824);
        var_4751753a = arraycopy(level.var_c3c3ffc5);
        var_4751753a = array::filter(var_4751753a, 0, &function_412874e);
        var_766273f0 = var_4751753a.size;
    }
    util::wait_network_frame();
    while ((isdefined(var_54939bf3) && var_54939bf3 || var_766273f0 < var_2b71b5b4) && level flag::get("wave_event_raz_spawning_active")) {
        var_4751753a = array::remove_dead(var_4751753a, 0);
        while ((isdefined(var_54939bf3) && var_54939bf3 || var_4751753a.size < var_15eb9a52 && var_766273f0 < var_2b71b5b4) && level flag::get("wave_event_raz_spawning_active")) {
            var_4751753a = array::remove_dead(var_4751753a, 0);
            level function_9b76f612("raz");
            ai_raz = function_432cdad9(a_spawnpoints);
            if (isalive(ai_raz)) {
                ai_raz.no_powerups = 1;
                ai_raz.no_damage_points = 1;
                ai_raz.deathpoints_already_given = 1;
                if (!isdefined(var_4751753a)) {
                    var_4751753a = [];
                } else if (!isarray(var_4751753a)) {
                    var_4751753a = array(var_4751753a);
                }
                var_4751753a[var_4751753a.size] = ai_raz;
                if (!isdefined(level.var_c3c3ffc5)) {
                    level.var_c3c3ffc5 = [];
                } else if (!isarray(level.var_c3c3ffc5)) {
                    level.var_c3c3ffc5 = array(level.var_c3c3ffc5);
                }
                level.var_c3c3ffc5[level.var_c3c3ffc5.size] = ai_raz;
                ai_raz function_d48ad6b4();
                var_766273f0++;
                if (isdefined(var_ee8c6a82) && var_ee8c6a82) {
                    if (isdefined(level.var_141e2500) && level.var_141e2500 && var_60d8c6a2 >= 3) {
                        level.var_141e2500 = 0;
                        var_60d8c6a2 = 0;
                    } else {
                        level.var_141e2500 = 1;
                        var_60d8c6a2++;
                    }
                }
                if (isdefined(level.var_141e2500) && level.var_141e2500) {
                    ai_raz.var_815e6068 = gettime();
                }
            }
            level function_a03df69f(var_f92c3865, var_b4fcee85, var_3642df18);
        }
        util::wait_network_frame();
        if (isdefined(var_2b71b5b4) && level flag::get("wave_event_zombies_complete")) {
            var_15eb9a52 = var_2b71b5b4;
        }
    }
    while (var_4751753a.size > 0 && level flag::get("wave_event_raz_spawning_active")) {
        var_4751753a = array::remove_dead(var_4751753a, 0);
        wait 0.05;
    }
    level flag::clear("wave_event_raz_spawning_active");
    level notify(#"wave_event_raz_complete");
}

// Namespace zm_stalingrad_util
// Params 3, eflags: 0x1 linked
// Checksum 0x9589e0f, Offset: 0x2528
// Size: 0x44
function function_4334972f(str_endon, var_3642df18, var_1d9f5031) {
    level endon(str_endon);
    level waittill(var_3642df18);
    level flag::clear(var_1d9f5031);
}

// Namespace zm_stalingrad_util
// Params 2, eflags: 0x1 linked
// Checksum 0xc2a181f6, Offset: 0x2578
// Size: 0x24c
function function_432cdad9(a_spawnpoints, var_e41e673a) {
    players = getplayers();
    var_19764360 = namespace_1c31c03d::get_favorite_enemy();
    if (isdefined(level.var_a3559c05)) {
        s_spawn_loc = [[ level.var_a3559c05 ]](level.var_6bca5baa, var_19764360);
    } else if (isdefined(a_spawnpoints)) {
        s_spawn_loc = function_77b29938(a_spawnpoints);
    } else if (level.zm_loc_types["raz_location"].size > 0) {
        s_spawn_loc = array::random(level.zm_loc_types["raz_location"]);
    }
    if (!isdefined(s_spawn_loc)) {
        return undefined;
    }
    ai = namespace_1c31c03d::function_665a13cd(level.var_6bca5baa[0]);
    if (isdefined(ai)) {
        ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
        ai.script_string = s_spawn_loc.script_string;
        ai.find_flesh_struct_string = ai.script_string;
        ai.sword_kill_power = 4;
        ai.heroweapon_kill_power = 4;
        if (isdefined(var_19764360)) {
            ai.favoriteenemy = var_19764360;
            ai.favoriteenemy.hunted_by++;
        }
        if (isdefined(var_e41e673a)) {
            ai thread [[ var_e41e673a ]]();
        }
        playsoundatposition("zmb_raz_spawn", s_spawn_loc.origin);
        return ai;
    }
    return undefined;
}

// Namespace zm_stalingrad_util
// Params 3, eflags: 0x1 linked
// Checksum 0xfa040559, Offset: 0x27d0
// Size: 0x118
function function_a03df69f(var_f92c3865, var_b4fcee85, var_3642df18) {
    level notify(#"hash_7794a855");
    level endon(#"hash_7794a855");
    if (isdefined(var_3642df18)) {
        level endon(var_3642df18);
    }
    if (!isdefined(var_b4fcee85)) {
        wait var_f92c3865;
        return;
    }
    var_c0068ac4 = level.var_258441ba;
    level.var_c3c3ffc5 = array::remove_dead(level.var_c3c3ffc5, 0);
    var_5c19739a = gettime() / 1000;
    do {
        var_bd4301c0 = level.var_258441ba - var_c0068ac4;
        n_time_current = gettime() / 1000;
        n_time_elapsed = n_time_current - var_5c19739a;
        wait 0.05;
    } while (var_bd4301c0 < var_b4fcee85 && n_time_elapsed < var_f92c3865);
}

// Namespace zm_stalingrad_util
// Params 2, eflags: 0x1 linked
// Checksum 0x333d667, Offset: 0x28f0
// Size: 0x1b8
function function_77b29938(a_spawners, var_19764360) {
    var_1bbdbab3 = 0;
    if (isdefined(a_spawners)) {
        a_spawnpoints = arraycopy(a_spawners);
    } else {
        a_spawnpoints = arraycopy(level.zm_loc_types["raz_location"]);
    }
    a_valid_spawn_points = [];
    while (!a_valid_spawn_points.size) {
        foreach (s_spawn_point in a_spawnpoints) {
            if (!isdefined(s_spawn_point.var_dabf8ae2) || var_1bbdbab3) {
                s_spawn_point.var_dabf8ae2 = 0;
            }
            if (!s_spawn_point.var_dabf8ae2) {
                array::add(a_valid_spawn_points, s_spawn_point, 0);
            }
        }
        if (!a_valid_spawn_points.size) {
            var_1bbdbab3 = 1;
        }
        wait 0.05;
    }
    s_spawn_point = array::random(a_valid_spawn_points);
    s_spawn_point.var_dabf8ae2 = 1;
    return s_spawn_point;
}

// Namespace zm_stalingrad_util
// Params 5, eflags: 0x1 linked
// Checksum 0x38ac350a, Offset: 0x2ab0
// Size: 0x4ba
function function_923f7f72(var_af22dd13, var_ed448d3b, var_e25e1ccc, var_b4fcee85, var_3642df18) {
    level notify(#"hash_93ef69e7");
    level endon(#"hash_93ef69e7");
    if (isdefined(var_3642df18)) {
        level endon(var_3642df18);
        level thread function_4334972f("wave_event_sentinels_complete", var_3642df18, "wave_event_sentinel_spawning_active");
    }
    if (var_e25e1ccc < 0.1) {
        var_e25e1ccc = 0.1;
    }
    if (!isdefined(var_af22dd13)) {
        var_54939bf3 = 1;
    }
    level flag::set("wave_event_sentinel_spawning_active");
    var_5e8e8152 = [];
    var_469adf27 = 0;
    while (!isdefined(level.var_c3c3ffc5)) {
        wait 0.05;
    }
    if (isdefined(level.var_c3c3ffc5)) {
        level.var_c3c3ffc5 = array::filter(level.var_c3c3ffc5, 0, &function_91d64824);
        var_5e8e8152 = arraycopy(level.var_c3c3ffc5);
        var_5e8e8152 = array::filter(var_5e8e8152, 0, &function_f0610596);
        var_469adf27 = var_5e8e8152.size;
    }
    util::wait_network_frame();
    while ((isdefined(var_54939bf3) && var_54939bf3 || var_469adf27 < var_af22dd13) && level flag::get("wave_event_sentinel_spawning_active")) {
        var_5e8e8152 = array::remove_dead(var_5e8e8152, 0);
        while ((isdefined(var_54939bf3) && var_54939bf3 || var_5e8e8152.size < var_ed448d3b && var_469adf27 < var_af22dd13) && level flag::get("wave_event_sentinel_spawning_active")) {
            var_5e8e8152 = array::remove_dead(var_5e8e8152, 0);
            level function_9b76f612("sentinel");
            var_663b2442 = function_70e59bda();
            if (isalive(var_663b2442)) {
                var_663b2442.no_powerups = 1;
                var_663b2442.no_damage_points = 1;
                var_663b2442.deathpoints_already_given = 1;
                if (!isdefined(var_5e8e8152)) {
                    var_5e8e8152 = [];
                } else if (!isarray(var_5e8e8152)) {
                    var_5e8e8152 = array(var_5e8e8152);
                }
                var_5e8e8152[var_5e8e8152.size] = var_663b2442;
                if (!isdefined(level.var_c3c3ffc5)) {
                    level.var_c3c3ffc5 = [];
                } else if (!isarray(level.var_c3c3ffc5)) {
                    level.var_c3c3ffc5 = array(level.var_c3c3ffc5);
                }
                level.var_c3c3ffc5[level.var_c3c3ffc5.size] = var_663b2442;
                var_663b2442 function_d48ad6b4();
                var_469adf27++;
            }
            wait var_e25e1ccc;
            if (level flag::get("wave_event_zombies_complete")) {
                var_ed448d3b = var_af22dd13;
            }
        }
        util::wait_network_frame();
    }
    while (var_5e8e8152.size > 0 && level flag::get("wave_event_sentinel_spawning_active")) {
        var_5e8e8152 = array::remove_dead(var_5e8e8152, 0);
        wait 0.05;
    }
    level flag::clear("wave_event_sentinel_spawning_active");
    level notify(#"wave_event_sentinels_complete");
}

// Namespace zm_stalingrad_util
// Params 2, eflags: 0x1 linked
// Checksum 0x4d606f55, Offset: 0x2f78
// Size: 0x124
function function_70e59bda(var_e41e673a, var_1d8ab289) {
    if (isdefined(var_1d8ab289)) {
        s_spawn_loc = var_1d8ab289;
    } else if (isdefined(level.var_809d579e)) {
        s_spawn_loc = [[ level.var_809d579e ]](level.var_fda4b3f3);
    } else {
        s_spawn_loc = namespace_8bc21961::function_f9c9e7e0();
    }
    if (!isdefined(s_spawn_loc)) {
        return undefined;
    }
    ai = namespace_8bc21961::function_fded8158(level.var_fda4b3f3[0]);
    if (isdefined(ai)) {
        ai thread namespace_8bc21961::function_b27530eb(s_spawn_loc.origin);
        if (isdefined(var_e41e673a)) {
            ai thread [[ var_e41e673a ]]();
        }
        ai.sword_kill_power = 4;
        ai.heroweapon_kill_power = 4;
        return ai;
    }
    return undefined;
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x0
// Checksum 0xa6f2a445, Offset: 0x30a8
// Size: 0x1b0
function function_383b110b(a_spawners) {
    var_1bbdbab3 = 0;
    if (isdefined(a_spawners)) {
        a_spawnpoints = arraycopy(a_spawners);
    } else {
        a_spawnpoints = arraycopy(level.zm_loc_types["sentinel_location"]);
    }
    a_valid_spawn_points = [];
    while (!a_valid_spawn_points.size) {
        foreach (s_spawn_point in a_spawnpoints) {
            if (!isdefined(s_spawn_point.var_1565f394) || var_1bbdbab3) {
                s_spawn_point.var_1565f394 = 0;
            }
            if (!s_spawn_point.var_1565f394) {
                array::add(a_valid_spawn_points, s_spawn_point, 0);
            }
        }
        if (!a_valid_spawn_points.size) {
            var_1bbdbab3 = 1;
        }
        wait 0.05;
    }
    s_spawn_point = array::random(a_valid_spawn_points);
    s_spawn_point.var_1565f394 = 1;
    return s_spawn_point;
}

// Namespace zm_stalingrad_util
// Params 0, eflags: 0x1 linked
// Checksum 0x38db81ac, Offset: 0x3260
// Size: 0x1a4
function function_d48ad6b4() {
    level.var_c3c3ffc5 = array::remove_dead(level.var_c3c3ffc5, 0);
    if (isdefined(level.var_5fe02c5a)) {
        var_456e8c26 = level.var_5fe02c5a;
    } else {
        var_456e8c26 = level.zombie_ai_limit;
    }
    if (level.var_c3c3ffc5.size > var_456e8c26) {
        n_to_kill = level.var_c3c3ffc5.size - var_456e8c26;
        if (isvehicle(self)) {
            n_to_kill++;
        }
        for (i = 0; i < n_to_kill; i++) {
            do {
                ai_target = array::random(level.var_c3c3ffc5);
                wait 0.05;
            } while (!level function_4614e0e9(ai_target));
            ai_target.var_1d3a1f9e = 1;
            wait 0.05;
            if (function_4614e0e9(ai_target)) {
                ai_target kill();
            }
            level.var_c3c3ffc5 = array::remove_dead(level.var_c3c3ffc5, 0);
            if (level.var_c3c3ffc5.size <= var_456e8c26) {
                break;
            }
        }
        return true;
    }
    return false;
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0x4611a9c4, Offset: 0x3410
// Size: 0x56
function function_4614e0e9(ai_target) {
    if (!isdefined(ai_target)) {
        return false;
    }
    if (ai_target.archetype !== "zombie" || zm_utility::is_magic_bullet_shield_enabled(ai_target)) {
        return false;
    }
    return true;
}

// Namespace zm_stalingrad_util
// Params 0, eflags: 0x1 linked
// Checksum 0x6717f33d, Offset: 0x3470
// Size: 0x48
function function_58cdc394() {
    while (level.var_c3c3ffc5.size >= level.zombie_ai_limit) {
        level.var_c3c3ffc5 = array::remove_dead(level.var_c3c3ffc5, 0);
        wait 0.05;
    }
}

// Namespace zm_stalingrad_util
// Params 4, eflags: 0x1 linked
// Checksum 0x8a215ce9, Offset: 0x34c0
// Size: 0x334
function function_5eeabbe0(var_47ee7db6, nd_path_start, var_f08b56c6, str_notify) {
    self.var_fa6d2a24 = 1;
    self zm_utility::function_139befeb();
    self bgb::suspend_weapon_cycling();
    self.bgb_disabled = 1;
    self.var_13f86a82 = spawner::simple_spawn_single(var_47ee7db6);
    self.var_13f86a82 setignorepauseworld(1);
    self.var_13f86a82 setacceleration(500);
    self.var_13f86a82 setturningability(0.3);
    self.var_13f86a82.origin = self.origin;
    self setplayerangles(self.var_13f86a82.angles);
    self.var_13f86a82.e_parent = self;
    self notify(#"hash_94217b77");
    switch (nd_path_start.targetname) {
    case "sewer_ride_start":
        exploder::exploder("fxexp_501");
        break;
    case "ee_sewer_rail_start":
        exploder::exploder("fxexp_503");
    default:
        break;
    }
    self playerlinktodelta(self.var_13f86a82, undefined, 1, 20, 20, 15, 60);
    self.var_13f86a82 vehicle::get_on_path(nd_path_start);
    self playsound("evt_zipline_attach");
    self thread function_6efec755(var_f08b56c6);
    self util::magic_bullet_shield();
    self.var_13f86a82 waittill(#"hash_a93c476");
    self.var_fa6d2a24 = 0;
    self zm_utility::function_36f941b3();
    self.bgb_disabled = 0;
    self bgb::resume_weapon_cycling();
    if (isdefined(str_notify)) {
        level notify(str_notify);
    }
    if (!(isdefined(level.var_2de93bbe) && level.var_2de93bbe) && nd_path_start.targetname != "ee_sewer_rail_start") {
        self zm_audio::create_and_play_dialog("transport", "sewer");
    }
    self util::stop_magic_bullet_shield();
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0x9d2cfd3a, Offset: 0x3800
// Size: 0x1de
function function_6efec755(var_f08b56c6) {
    self endon(#"disconnect");
    self endon(#"switch_rail");
    self.var_13f86a82 thread function_13629b3a();
    self clientfield::set_to_player("tp_water_sheeting", 1);
    self.var_13f86a82 vehicle::go_path();
    if (isdefined(var_f08b56c6)) {
        self.var_13f86a82.origin = var_f08b56c6.origin;
        self.origin = var_f08b56c6.origin;
        self setplayerangles(var_f08b56c6.angles);
        self.var_13f86a82 vehicle::get_on_path(var_f08b56c6);
        self.var_13f86a82 vehicle::go_path();
    }
    self.var_13f86a82 notify(#"hash_a93c476");
    self clientfield::increment_to_player("sewer_landing_rumble");
    self playsound("zmb_stalingrad_sewer_air_land");
    self stoploopsound(0.4);
    self unlink();
    self clientfield::set_to_player("tp_water_sheeting", 0);
    wait 0.3;
    self.var_13f86a82 delete();
    self.var_a0a9409e = undefined;
}

// Namespace zm_stalingrad_util
// Params 0, eflags: 0x1 linked
// Checksum 0xf57cbc5e, Offset: 0x39e8
// Size: 0xe4
function function_ab2df0ca() {
    self endon(#"hash_a93c476");
    self endon(#"disconnect");
    self waittill(#"hash_94217b77");
    self.var_13f86a82 waittill(#"hash_c4eac163");
    self clientfield::set_to_player("drown_stage", 4);
    wait 0.5;
    self lui::screen_fade_out(1.5);
    self.var_13f86a82 util::waittill_notify_or_timeout("sewer_fade_up", 3);
    self lui::screen_fade_in(1);
    self clientfield::set_to_player("drown_stage", 0);
}

// Namespace zm_stalingrad_util
// Params 0, eflags: 0x1 linked
// Checksum 0x89bb7519, Offset: 0x3ad8
// Size: 0x50
function function_13629b3a() {
    self endon(#"hash_a93c476");
    while (true) {
        playfxontag(level._effect["current_effect"], self, "tag_origin");
        wait 0.1;
    }
}

// Namespace zm_stalingrad_util
// Params 0, eflags: 0x1 linked
// Checksum 0x6e04e75d, Offset: 0x3b30
// Size: 0x40
function function_eda4b163() {
    while (true) {
        self trigger::wait_till();
        exploder::exploder(self.script_string);
    }
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0xbfbc9f26, Offset: 0x3b78
// Size: 0xd4
function function_4da6e8(b_open) {
    var_2e1f1409 = getent("dept_occluder", "targetname");
    if (b_open) {
        var_2e1f1409 ghost();
        var_2e1f1409 notsolid();
        umbragate_set("umbragate1", 1);
        return;
    }
    var_2e1f1409 show();
    var_2e1f1409 solid();
    umbragate_set("umbragate1", 0);
}

// Namespace zm_stalingrad_util
// Params 2, eflags: 0x1 linked
// Checksum 0x77afd827, Offset: 0x3c58
// Size: 0x1e4
function function_903f6b36(b_turn_on, str_identifier) {
    if (!isdefined(str_identifier)) {
        str_identifier = undefined;
    }
    if (!isdefined(str_identifier)) {
        str_identifier = self.script_noteworthy;
        var_144a9df9 = getentarray(str_identifier, "targetname");
    } else {
        var_144a9df9 = getentarray(str_identifier + "_switch", "targetname");
    }
    if (b_turn_on) {
        str_scene = "p7_fxanim_zm_stal_power_switch_on_bundle";
        exploder::exploder(str_identifier + "_red");
        exploder::stop_exploder(str_identifier + "_green");
    } else {
        str_scene = "p7_fxanim_zm_stal_power_switch_reset_bundle";
    }
    foreach (e_switch in var_144a9df9) {
        e_switch thread scene::play(str_scene, e_switch);
    }
    wait 1;
    if (!b_turn_on) {
        exploder::exploder(str_identifier + "_green");
        exploder::stop_exploder(str_identifier + "_red");
    }
}

// Namespace zm_stalingrad_util
// Params 1, eflags: 0x1 linked
// Checksum 0x704789ec, Offset: 0x3e48
// Size: 0x40
function function_c66f2957(s_point) {
    return s_point.script_noteworthy === "spawn_location" || s_point.script_noteworthy === "riser_location";
}

