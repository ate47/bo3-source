#using scripts/zm/_zm_devgui;
#using scripts/zm/zm_genesis_wasp;
#using scripts/zm/zm_genesis_sound;
#using scripts/zm/zm_genesis_spiders;
#using scripts/zm/zm_genesis_shadowman;
#using scripts/zm/zm_genesis_vo;
#using scripts/zm/zm_genesis_util;
#using scripts/zm/zm_genesis_apothicon_fury;
#using scripts/zm/zm_genesis_ai_spawning;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weap_gravityspikes;
#using scripts/zm/_zm_weap_ball;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_traps;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_shadow_zombie;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_genesis_random_weapon;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_light_zombie;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_ai_mechz;
#using scripts/zm/_zm_ai_margwa_no_idgun;
#using scripts/zm/_zm_ai_margwa_elemental;
#using scripts/zm/_zm_genesis_spiders;
#using scripts/zm/_zm;
#using scripts/shared/vehicles/_parasite;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/margwa;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#using_animtree("zm_genesis");

#namespace namespace_f153ce01;

// Namespace namespace_f153ce01
// Method(s) 28 Total 28
class class_d90687be {

    // Namespace namespace_d90687be
    // Params 1, eflags: 0x1 linked
    // Checksum 0x492a759d, Offset: 0x5588
    // Size: 0x1a0
    function function_7e9f0faf(var_b852cbf7) {
        a_valid_spawn_points = [];
        var_1bbdbab3 = 0;
        while (!a_valid_spawn_points.size) {
            foreach (s_spawn_point in self.var_4ff05dea) {
                if (!isdefined(s_spawn_point.var_dabf8ae2) || var_1bbdbab3) {
                    s_spawn_point.var_dabf8ae2 = 0;
                }
                var_ce040708 = isdefined(s_spawn_point.var_4ef230e4) && (!var_b852cbf7 || s_spawn_point.var_4ef230e4);
                if (!s_spawn_point.var_dabf8ae2 && var_ce040708) {
                    array::add(a_valid_spawn_points, s_spawn_point, 0);
                }
            }
            if (!a_valid_spawn_points.size) {
                var_1bbdbab3 = 1;
            }
            wait(0.1);
        }
        s_spawn_point = array::random(a_valid_spawn_points);
        s_spawn_point.var_dabf8ae2 = 1;
        return s_spawn_point;
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1f0355e1, Offset: 0x53a8
    // Size: 0x1d8
    function function_877a7365() {
        self endon(#"death");
        while (true) {
            var_c7ca004c = [];
            foreach (player in level.activeplayers) {
                if (zm_utility::is_player_valid(player) && function_2a75673(player)) {
                    if (!isdefined(var_c7ca004c)) {
                        var_c7ca004c = [];
                    } else if (!isarray(var_c7ca004c)) {
                        var_c7ca004c = array(var_c7ca004c);
                    }
                    var_c7ca004c[var_c7ca004c.size] = player;
                }
            }
            e_target_player = array::random(var_c7ca004c);
            while (isalive(e_target_player) && !(isdefined(e_target_player.beastmode) && e_target_player.beastmode) && !e_target_player laststand::player_is_in_laststand()) {
                self setgoal(e_target_player);
                self waittill(#"goal");
            }
            wait(0.1);
        }
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0x33107df3, Offset: 0x4f18
    // Size: 0x482
    function function_523eee15() {
        var_efcfca6d = [];
        var_166a783a = getaiteamarray("axis");
        foreach (e_ent in var_166a783a) {
            if (e_ent.archetype == "parasite") {
                if (!isdefined(var_efcfca6d)) {
                    var_efcfca6d = [];
                } else if (!isarray(var_efcfca6d)) {
                    var_efcfca6d = array(var_efcfca6d);
                }
                var_efcfca6d[var_efcfca6d.size] = e_ent;
            }
        }
        var_eb96527b = getent("dark_arena_zone_active_trig", "targetname");
        foreach (var_acaa35c2 in var_efcfca6d) {
            if (var_acaa35c2 istouching(var_eb96527b)) {
                if (!isdefined(self.var_eeb77e19)) {
                    self.var_eeb77e19 = [];
                } else if (!isarray(self.var_eeb77e19)) {
                    self.var_eeb77e19 = array(self.var_eeb77e19);
                }
                self.var_eeb77e19[self.var_eeb77e19.size] = var_acaa35c2;
            }
        }
        if (!isdefined(self.var_eeb77e19)) {
            return;
        }
        var_2f263630 = self.var_eeb77e19;
        var_341c99f8 = [];
        foreach (var_1faf0ec5 in var_2f263630) {
            if (!isdefined(var_1faf0ec5)) {
                continue;
            }
            if (isdefined(var_1faf0ec5.ignore_nuke) && var_1faf0ec5.ignore_nuke) {
                continue;
            }
            if (isdefined(var_1faf0ec5.marked_for_death) && var_1faf0ec5.marked_for_death) {
                continue;
            }
            if (isdefined(var_1faf0ec5.nuke_damage_func)) {
                var_1faf0ec5 thread [[ var_1faf0ec5.nuke_damage_func ]]();
                continue;
            }
            var_1faf0ec5.marked_for_death = 1;
            var_1faf0ec5.nuked = 1;
            var_341c99f8[var_341c99f8.size] = var_1faf0ec5;
        }
        foreach (i, var_ab7516d5 in var_341c99f8) {
            if (!isdefined(var_ab7516d5)) {
                continue;
            }
            if (i < 5) {
                var_ab7516d5 thread zombie_death::flame_death_fx();
            }
            var_ab7516d5 dodamage(var_ab7516d5.health, var_ab7516d5.origin);
        }
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0xe663cbdb, Offset: 0x4d60
    // Size: 0x1aa
    function function_43fd7d6e() {
        if (!isdefined(self.var_2da522a2)) {
            return;
        }
        a_ai = self.var_2da522a2;
        var_52ec51cb = [];
        foreach (ai in a_ai) {
            if (!isdefined(ai)) {
                continue;
            }
            if (isdefined(ai.marked_for_death) && ai.marked_for_death) {
                continue;
            }
            ai.marked_for_death = 1;
            ai.nuked = 1;
            var_52ec51cb[var_52ec51cb.size] = ai;
        }
        foreach (ai_nuked in var_52ec51cb) {
            if (!isdefined(ai_nuked)) {
                continue;
            }
            ai_nuked kill();
        }
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0x77ceaac1, Offset: 0x4a58
    // Size: 0x2fa
    function function_2d4b8dda() {
        if (!isdefined(self.var_2cf2d836)) {
            return;
        }
        a_ai_zombies = self.var_2cf2d836;
        var_6b1085eb = [];
        foreach (ai_zombie in a_ai_zombies) {
            if (!isdefined(ai_zombie)) {
                continue;
            }
            if (isdefined(ai_zombie.ignore_nuke) && ai_zombie.ignore_nuke) {
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
        foreach (i, var_f92b3d80 in var_6b1085eb) {
            if (!isdefined(var_f92b3d80)) {
                continue;
            }
            if (zm_utility::is_magic_bullet_shield_enabled(var_f92b3d80)) {
                continue;
            }
            if (i < 5 && !(isdefined(var_f92b3d80.isdog) && var_f92b3d80.isdog)) {
                var_f92b3d80 thread zombie_death::flame_death_fx();
            }
            if (!(isdefined(var_f92b3d80.isdog) && var_f92b3d80.isdog)) {
                if (!(isdefined(var_f92b3d80.no_gib) && var_f92b3d80.no_gib)) {
                    var_f92b3d80 zombie_utility::zombie_head_gib();
                }
            }
            var_f92b3d80 dodamage(var_f92b3d80.health, var_f92b3d80.origin);
        }
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1e845759, Offset: 0x49a0
    // Size: 0xac
    function function_b4aac082() {
        level.zombie_ai_limit = level.var_b89abaf8;
        level lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
        wait(0.2);
        self thread function_2d4b8dda();
        self thread function_43fd7d6e();
        wait(0.5);
        self thread function_523eee15();
    }

    // Namespace namespace_d90687be
    // Params 1, eflags: 0x1 linked
    // Checksum 0x12c670b3, Offset: 0x48c0
    // Size: 0xd2
    function function_34c1d454(var_87c8152d) {
        self.var_dacf61a8 = [];
        while (level clientfield::get("circle_state") == 3) {
            self.var_dacf61a8 = array::remove_dead(self.var_dacf61a8, 0);
            if (level.var_435967f3 < level.var_e10b491b) {
                ai = namespace_f153ce01::function_2ed620e8(var_87c8152d);
                if (isdefined(ai)) {
                    array::add(self.var_dacf61a8, ai, 0);
                }
            }
            wait(level.zombie_vars["zombie_spawn_delay"]);
        }
    }

    // Namespace namespace_d90687be
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5ff847f4, Offset: 0x47b0
    // Size: 0x106
    function function_e4dbca5a(var_87c8152d) {
        level notify(#"hash_e4dbca5a");
        level endon(#"hash_e4dbca5a");
        level endon(#"hash_45115ebd");
        self.var_2da522a2 = [];
        while (true) {
            self.var_2da522a2 = array::remove_dead(self.var_2da522a2, 0);
            var_4dc249a = level.var_beccbadb < level.var_c4133b63;
            var_4f4cf7d7 = level.var_beccbadb - level.var_de72c885 < level.var_42ec150d;
            if (var_4dc249a && var_4f4cf7d7) {
                ai = namespace_f153ce01::function_5a4ec2e2(var_87c8152d);
                array::add(self.var_2da522a2, ai, 0);
            }
            wait(5);
        }
    }

    // Namespace namespace_d90687be
    // Params 1, eflags: 0x1 linked
    // Checksum 0x9836b97a, Offset: 0x4658
    // Size: 0x14a
    function function_531007c0(e_player) {
        queryresult = positionquery_source_navigation(e_player.origin + (0, 0, randomintrange(40, 100)), 300, 600, 10, 10, "navvolume_small");
        a_points = array::randomize(queryresult.data);
        foreach (point in a_points) {
            if (bullettracepassed(point.origin, e_player.origin, 0, e_player)) {
                return point;
            }
        }
        return a_points[0];
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8292f448, Offset: 0x4028
    // Size: 0x622
    function function_17f3b496() {
        level endon(#"hash_45115ebd");
        self.var_eeb77e19 = [];
        while (level clientfield::get("circle_state") == 3) {
            self.var_eeb77e19 = array::remove_dead(self.var_eeb77e19, 0);
            var_16d0ce4b = 16;
            if (level.var_f98b3213 < 4) {
                var_16d0ce4b = 8;
            } else if (level.var_f98b3213 < 6) {
                var_16d0ce4b = 12;
            }
            e_player = array::random(function_e33fa65f());
            if (!isdefined(e_player)) {
                continue;
            }
            spawn_point = function_531007c0(e_player);
            if (self.var_eeb77e19.size < var_16d0ce4b) {
                if (isdefined(spawn_point)) {
                    var_6a724b3a = spawn_point.origin;
                    v_ground = bullettrace(spawn_point.origin + (0, 0, 40), spawn_point.origin + (0, 0, 40) + (0, 0, -100000), 0, undefined)["position"];
                    if (distancesquared(v_ground, spawn_point.origin) < 1600) {
                        var_6a724b3a = v_ground + (0, 0, 40);
                    }
                    queryresult = positionquery_source_navigation(var_6a724b3a, 0, 80, 80, 15, "navvolume_small");
                    a_points = array::randomize(queryresult.data);
                    var_8d090f42 = [];
                    var_4eb24b0 = 0;
                    foreach (point in a_points) {
                        str_zone = zm_zonemgr::get_zone_from_position(point.origin, 1);
                        if (str_zone == "dark_arena_zone" || isdefined(str_zone) && str_zone == "dark_arena2_zone") {
                            if (bullettracepassed(point.origin, spawn_point.origin, 0, e_player)) {
                                if (!isdefined(var_8d090f42)) {
                                    var_8d090f42 = [];
                                } else if (!isarray(var_8d090f42)) {
                                    var_8d090f42 = array(var_8d090f42);
                                }
                                var_8d090f42[var_8d090f42.size] = point.origin;
                                var_4eb24b0++;
                                if (var_4eb24b0 >= 1) {
                                    break;
                                }
                            }
                        }
                    }
                    if (var_8d090f42.size >= 1) {
                        n_spawn = 0;
                        while (n_spawn < 1) {
                            for (i = var_8d090f42.size - 1; i >= 0; i--) {
                                v_origin = var_8d090f42[i];
                                level.var_c03323ec[0].origin = v_origin;
                                ai = zombie_utility::spawn_zombie(level.var_c03323ec[0]);
                                if (isdefined(ai)) {
                                    array::add(self.var_eeb77e19, ai, 0);
                                    ai parasite::function_61692488(e_player);
                                    level thread namespace_3425d4b9::function_198fe8b9(ai, v_origin);
                                    arrayremoveindex(var_8d090f42, i);
                                    ai.ignore_enemy_count = 1;
                                    ai.var_bdb9d21d = 1;
                                    ai.no_damage_points = 1;
                                    ai.deathpoints_already_given = 1;
                                    if (isdefined(level.var_300c5ed6)) {
                                        ai thread [[ level.var_300c5ed6 ]]();
                                    }
                                    n_spawn++;
                                    wait(randomfloatrange(0.0666667, 0.133333));
                                    break;
                                }
                                wait(randomfloatrange(0.0666667, 0.133333));
                            }
                        }
                        var_420916f7 = 1;
                    }
                    util::wait_network_frame();
                }
            }
            wait(level.zombie_vars["zombie_spawn_delay"]);
        }
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3cda432, Offset: 0x3ee0
    // Size: 0x13e
    function function_7ebc257e() {
        self.var_8c5f9971 = [];
        var_d12aa484 = struct::get_array("arena_spider_spawner", "targetname");
        while (level clientfield::get("circle_state") == 3) {
            self.var_8c5f9971 = array::remove_dead(self.var_8c5f9971, 0);
            var_9e20b46f = 12;
            if (self.var_8c5f9971.size < var_9e20b46f) {
                s_spawn_point = array::random(var_d12aa484);
                level.var_718361fb = namespace_35610d96::function_3f180afe();
                ai = namespace_27f8b154::function_f4bd92a2(1, s_spawn_point);
                array::add(self.var_8c5f9971, ai, 0);
            }
            wait(1);
        }
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0x462b34e8, Offset: 0x3c90
    // Size: 0x244
    function function_352c3c15() {
        if (level.var_42e19a0b == 1) {
            var_72214acc = randomintrange(0, 4);
            if (var_72214acc == 0) {
                self thread namespace_57695b4d::function_1b1bb1b();
            } else if (var_72214acc == 1) {
                self thread namespace_57695b4d::function_f4defbc2();
            }
            return;
        }
        if (level.var_42e19a0b == 2) {
            if (randomintrange(0, 4) > 0) {
                var_72214acc = randomintrange(0, 4);
                if (var_72214acc == 0) {
                    self thread namespace_57695b4d::function_1b1bb1b();
                } else if (var_72214acc == 1) {
                    self thread namespace_57695b4d::function_f4defbc2();
                } else if (var_72214acc == 2) {
                    self thread namespace_6727c59c::function_a35db70f();
                } else if (var_72214acc == 3) {
                    self thread namespace_df1a4a92::function_1b2b62b();
                }
            }
            return;
        }
        if (level.var_42e19a0b == 3) {
            var_72214acc = randomintrange(0, 4);
            if (var_72214acc == 0) {
                self thread namespace_57695b4d::function_1b1bb1b();
                return;
            }
            if (var_72214acc == 1) {
                self thread namespace_57695b4d::function_1b1bb1b();
                return;
            }
            if (var_72214acc == 2) {
                self thread namespace_6727c59c::function_a35db70f();
                return;
            }
            if (var_72214acc == 3) {
                self thread namespace_df1a4a92::function_1b2b62b();
            }
        }
    }

    // Namespace namespace_d90687be
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2ecdc0f, Offset: 0x39e0
    // Size: 0x2a4
    function function_422556eb(s_spawn_point) {
        e_spawner = getent("spawner_zm_genesis_apothicon_zombie", "targetname");
        ai = zombie_utility::spawn_zombie(e_spawner, "arena_zombie", s_spawn_point);
        if (!isdefined(ai)) {
            /#
                println("int");
            #/
            return;
        }
        ai endon(#"death");
        ai._rise_spot = s_spawn_point;
        ai.var_7879ec72 = 1;
        ai thread namespace_f153ce01::function_ffcee12c(s_spawn_point);
        ai thread function_877a7365();
        if (level flag::get("book_runes_success") && !level flag::get("final_boss_started") && !level flag::get("arena_vanilla_zombie_override")) {
            var_87c8152d = level clientfield::get("circle_challenge_identity");
            switch (var_87c8152d) {
            case 3:
                ai thread namespace_57695b4d::function_1b1bb1b();
                break;
            case 2:
                ai thread namespace_cb655c88::function_c8040935(2);
                break;
            case 0:
                ai thread namespace_6727c59c::function_a35db70f();
                break;
            case 1:
                ai thread namespace_df1a4a92::function_1b2b62b();
                break;
            case 4:
                ai thread function_352c3c15();
                break;
            }
        }
        array::add(self.var_2cf2d836, ai, 0);
        ai waittill(#"completed_emerging_into_playable_area");
        ai.no_powerups = 1;
        ai.no_damage_points = 1;
        ai.deathpoints_already_given = 1;
    }

    // Namespace namespace_d90687be
    // Params 2, eflags: 0x1 linked
    // Checksum 0xbf90c50f, Offset: 0x37f8
    // Size: 0x1e0
    function function_a1c7821d(var_b852cbf7, var_3f571692) {
        if (!isdefined(var_3f571692)) {
            var_3f571692 = 12;
        }
        level notify(#"hash_6d73b616");
        level endon(#"hash_6d73b616");
        level endon(#"hash_45115ebd");
        level endon(#"hash_1ec5d376");
        level.var_b89abaf8 = level.zombie_ai_limit;
        level.zombie_ai_limit = 16;
        self.var_2cf2d836 = [];
        while (true) {
            if (!level flag::get("final_boss_started")) {
                wait(level.zombie_vars["zombie_spawn_delay"]);
            } else {
                wait(0.5);
            }
            if (isdefined(level.var_8e402c12)) {
                var_3f571692 = level.var_8e402c12;
                level.var_8e402c12 = undefined;
            }
            self.var_2cf2d836 = array::remove_dead(self.var_2cf2d836, 0);
            level flag::clear("spawn_zombies");
            while (getfreeactorcount() < 1) {
                util::wait_network_frame();
            }
            level flag::set("spawn_zombies");
            if (self.var_2cf2d836.size >= var_3f571692) {
                continue;
            }
            s_spawn_point = function_7e9f0faf(var_b852cbf7);
            if (isdefined(s_spawn_point)) {
                function_422556eb(s_spawn_point);
            }
        }
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbbd79693, Offset: 0x3768
    // Size: 0x86
    function function_15c5e1() {
        foreach (s_spawn_point in self.var_4ff05dea) {
            s_spawn_point.var_4ef230e4 = 0;
        }
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0x1e02883d, Offset: 0x3628
    // Size: 0x134
    function function_cba8ad32() {
        level notify(#"hash_cba8ad32");
        level endon(#"hash_cba8ad32");
        level clientfield::set("arena_state", 4);
        level clientfield::set("circle_state", 5);
        wait(5);
        while (true) {
            players = level.activeplayers;
            foreach (player in players) {
                if (function_2a75673(player)) {
                    player dodamage(15, player.origin);
                }
            }
            wait(1);
        }
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0x43fa0f0b, Offset: 0x3588
    // Size: 0x92
    function function_f115a4c8() {
        level notify(#"hash_f115a4c8");
        level endon(#"hash_f115a4c8");
        level endon(#"hash_78e9c51c");
        wait(30);
        for (i = 0; i < 5; i++) {
            /#
                iprintlnbold("int" + 5 - i);
            #/
            wait(1);
        }
        level notify(#"hash_b7da93ea");
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4ffd5793, Offset: 0x3540
    // Size: 0x3c
    function function_32374471() {
        level endon(#"hash_b7da93ea");
        while (true) {
            level thread function_f115a4c8();
            level waittill(#"hash_78e9c51c");
        }
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0xbd11f13c, Offset: 0x3300
    // Size: 0x236
    function function_15715797() {
        level endon(#"hash_fa713eaf");
        level flag::wait_till("test_activate_arena");
        while (true) {
            level flag::wait_till("test_activate_arena");
            players = level.activeplayers;
            foreach (player in players) {
                level notify(#"hash_1c04ac7f", player);
            }
            level clientfield::set("arena_state", 1);
            level clientfield::set("circle_state", 1);
            wait(0.1);
            level clientfield::set("circle_state", 2);
            level flag::wait_till("arena_timer");
            level thread function_32374471();
            level waittill(#"hash_b7da93ea");
            level thread function_cba8ad32();
            level flag::wait_till_clear("test_activate_arena");
            flag::clear("test_activate_arena");
            level clientfield::set("arena_state", 0);
            level clientfield::set("circle_state", 0);
            level notify(#"hash_cba8ad32");
        }
    }

    // Namespace namespace_d90687be
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb3595042, Offset: 0x3228
    // Size: 0xcc
    function function_4d8d73c5(player) {
        str_zone = zm_zonemgr::get_zone_from_position(player.origin + (0, 0, 32), 1);
        if (isdefined(str_zone)) {
            if (str_zone == "zm_theater_balcony_zone" || str_zone == "zm_theater_zone" || str_zone == "zm_theater_projection_zone" || str_zone == "zm_theater_foyer_zone" || str_zone == "zm_theater_hallway_zone" || str_zone == "zm_theater_jump_zone" || str_zone == "zm_theater_stage_zone") {
                return true;
            }
        }
        return false;
    }

    // Namespace namespace_d90687be
    // Params 1, eflags: 0x1 linked
    // Checksum 0x440e9f06, Offset: 0x31b0
    // Size: 0x6c
    function function_2a75673(player) {
        str_zone = zm_zonemgr::get_zone_from_position(player.origin, 1);
        if (isdefined(str_zone)) {
            if (str_zone == "dark_arena_zone" || str_zone == "dark_arena2_zone") {
                return true;
            }
        }
        return false;
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0x80814b9, Offset: 0x30d0
    // Size: 0xd6
    function function_e33fa65f() {
        var_a5d8479 = [];
        foreach (e_player in level.activeplayers) {
            if (zm_utility::is_player_valid(e_player) && function_2a75673(e_player)) {
                array::add(var_a5d8479, e_player);
            }
        }
        return var_a5d8479;
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0xfef04a0d, Offset: 0x2fe8
    // Size: 0xe0
    function function_87ecf9f6() {
        var_33f28c72 = 0;
        var_caac2b25 = function_e33fa65f();
        foreach (player in var_caac2b25) {
            if (zm_utility::is_player_valid(player) && function_2a75673(player)) {
                var_33f28c72 += 1;
            }
        }
        return var_33f28c72;
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0x64004e20, Offset: 0x2f98
    // Size: 0x44
    function function_b074bb56() {
        self.var_6d226cbc -= 1;
        if (self.var_6d226cbc == 0) {
            level flag::clear("test_activate_arena");
        }
    }

    // Namespace namespace_d90687be
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe27faa76, Offset: 0x2f20
    // Size: 0x6c
    function function_ea39787e(player) {
        array::add(self.var_ff517d49, player);
        self.var_6d226cbc += 1;
        level notify(#"hash_78e9c51c", player);
        level flag::set("arena_occupied_by_player");
    }

    // Namespace namespace_d90687be
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5566fd76, Offset: 0x2e80
    // Size: 0x94
    function init() {
        self.var_ff517d49 = [];
        self.var_6d226cbc = 0;
        self.var_95ceb5f7 = getent("dark_arena_volume", "targetname");
        self.var_4ff05dea = struct::get_array("arena_scripted_zombie_spawn", "targetname");
        namespace_f153ce01::function_c1402204();
        level thread function_15715797();
    }

}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x2
// Checksum 0xbc2b76ac, Offset: 0x1e78
// Size: 0x3c
function function_2dc19561() {
    system::register("zm_genesis_arena", &__init__, &__main__, undefined);
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xdee9a09a, Offset: 0x1ec0
// Size: 0xac4
function __init__() {
    level._effect["zapper"] = "dlc0/factory/fx_elec_trap_factory";
    level._effect["light_challenge_safezone_end"] = "dlc4/genesis/fx_arena_safe_area_end";
    level thread function_6f772f30();
    level thread namespace_cb655c88::function_748dfcde("dark_arena_zone_active_trig", "arena_wallrun_active");
    level thread namespace_cb655c88::function_88777efd("dark_arena_zone_active_trig", "arena_lowgrav_active");
    clientfield::register("world", "arena_state", 15000, getminbitcountfornum(5), "int");
    clientfield::register("world", "circle_state", 15000, getminbitcountfornum(6), "int");
    clientfield::register("world", "circle_challenge_identity", 15000, getminbitcountfornum(6), "int");
    clientfield::register("world", "summoning_key_charge_state", 15000, getminbitcountfornum(4), "int");
    clientfield::register("toplayer", "fire_postfx_set", 15000, 1, "int");
    clientfield::register("scriptmover", "fire_column", 15000, 1, "int");
    clientfield::register("toplayer", "darkness_postfx_set", 15000, 1, "int");
    clientfield::register("toplayer", "electricity_postfx_set", 15000, 1, "int");
    clientfield::register("world", "light_challenge_floor", 15000, 1, "int");
    clientfield::register("actor", "arena_margwa_init", 15000, 1, "int");
    clientfield::register("scriptmover", "arena_tornado", 15000, 1, "int");
    clientfield::register("scriptmover", "arena_shadow_pillar", 15000, 1, "int");
    clientfield::register("world", "arena_timeout_warning", 15000, 1, "int");
    clientfield::register("scriptmover", "elec_wall_tell", 15000, 1, "counter");
    clientfield::register("toplayer", "powerup_visual_marker", 15000, 2, "int");
    level._effect["powerup_column"] = "dlc4/genesis/fx_darkarena_powerup_pillar";
    clientfield::register("world", "summoning_key_pickup", 15000, getminbitcountfornum(3), "int");
    clientfield::register("world", "basin_state_0", 15000, getminbitcountfornum(5), "int");
    clientfield::register("world", "basin_state_1", 15000, getminbitcountfornum(5), "int");
    clientfield::register("world", "basin_state_2", 15000, getminbitcountfornum(5), "int");
    clientfield::register("world", "basin_state_3", 15000, getminbitcountfornum(5), "int");
    clientfield::register("scriptmover", "runeprison_rock_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "runeprison_explode_fx", 5000, 1, "int");
    level.var_42e19a0b = 1;
    clientfield::register("scriptmover", "summoning_circle_fx", 15000, 1, "int");
    level.var_f98b3213 = 0;
    level.var_c4133b63 = 1;
    level.var_42ec150d = 4;
    level.var_beccbadb = 0;
    level.var_90280eb8 = 1;
    level.var_435967f3 = 0;
    level.var_fe2fb4b9 = -1;
    level.var_43e34f20 = [];
    level.var_43e34f20[0] = &function_48ffe1e9;
    level.var_43e34f20[1] = &function_2bacd397;
    level.var_43e34f20[2] = &function_f1e6c2a7;
    level.var_43e34f20[3] = &function_f1aed0c6;
    level.var_5afa678d = [];
    level.var_5afa678d[0] = &function_876e8a3c;
    level.var_5afa678d[1] = &function_d2a9fa8c;
    level.var_5afa678d[2] = &function_56b687ac;
    level.var_5afa678d[3] = &function_c78d187b;
    level flag::init("test_activate_arena");
    level flag::init("devgui_end_challenge");
    level flag::init("boss_rush_phase_1");
    level flag::init("boss_rush_phase_2");
    level flag::init("arena_timer", 1);
    level flag::init("arena_zombie_priority");
    level flag::init("arena_occupied_by_player");
    level flag::init("arena_vanilla_zombie_override");
    level flag::init("custom_challenge");
    level flag::init("custom_challenge_wallrun");
    level flag::init("custom_challenge_lowgrav");
    level flag::init("custom_challenge_smoke");
    level flag::init("custom_challenge_bridge");
    level flag::init("custom_challenge_fire");
    level flag::init("custom_challenge_elec");
    level flag::init("custom_challenge_cursetraps");
    level flag::init("final_boss_started");
    level flag::init("final_boss_summoning_key_in_play");
    level flag::init("final_boss_vulnerable");
    level flag::init("final_boss_at_deaths_door");
    level flag::init("final_boss_defeated");
    level flag::init("special_win");
    for (i = 0; i < 5; i++) {
        var_60c1e5f7 = "arena_challenge_complete_" + i;
        level flag::init(var_60c1e5f7);
    }
    for (i = 4; i < 6; i++) {
        var_5a2492d5 = function_6ab2d662(i);
        var_60c1e5f7 = var_5a2492d5 + "_rq_done";
        level flag::init(var_60c1e5f7);
    }
    level thread function_dd27cfe0();
    /#
        level thread function_cc5cac5f();
        level thread function_3745c6c8();
    #/
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xabbb8c4c, Offset: 0x2990
// Size: 0xf4
function __main__() {
    setdvar("doublejump_enabled", 1);
    setdvar("playerEnergy_enabled", 1);
    setdvar("wallrun_enabled", 1);
    setdvar("bg_lowGravity", 300);
    setdvar("wallRun_maxTimeMs_zm", 10000);
    setdvar("playerEnergy_maxReserve_zm", -56);
    setdvar("wallRun_peakTest_zm", 0);
    level thread function_3dbace38();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x11f199cf, Offset: 0x2a90
// Size: 0x224
function function_dd27cfe0() {
    var_7fdcd3a8 = getent("arena_wallrun_center_a", "targetname");
    var_7fdcd3a8.v_start = var_7fdcd3a8.origin;
    var_7fdcd3a8 moveto(var_7fdcd3a8.v_start - (0, 0, 1000), 0.01);
    var_7fdcd3a8 ghost();
    var_c0132a00 = getent("rift_entrance_rune_portal", "targetname");
    var_c0132a00 ghost();
    level waittill(#"start_zombie_round_logic");
    level.var_d90687be = new class_d90687be();
    [[ level.var_d90687be ]]->init();
    level waittill(#"hash_5eb88f4a");
    var_c0132a00 show();
    var_c0132a00 hidepart("tag_electricity_on");
    var_c0132a00 hidepart("tag_fire_on");
    var_c0132a00 hidepart("tag_light_on");
    var_c0132a00 hidepart("tag_shadow_on");
    var_c0132a00 playloopsound("zmb_main_runey_circle_lp", 2);
    var_c0132a00 clientfield::set("summoning_circle_fx", 1);
    exploder::exploder("fxexp_370");
    exploder::exploder("lgtexp_projector_rune");
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x0
// Checksum 0xafda147e, Offset: 0x2cc0
// Size: 0x94
function function_869c4353(str_name) {
    e_platform = getent(str_name, "targetname");
    v_origin = e_platform.origin;
    v_offset = (0, 0, 192);
    e_platform moveto(v_origin - v_offset, 1);
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xba93fe78, Offset: 0x2d60
// Size: 0x118
function function_6f772f30() {
    level endon(#"end_game");
    level notify(#"hash_a3369c1f");
    level endon(#"hash_a3369c1f");
    while (true) {
        level waittill(#"host_migration_end");
        setdvar("doublejump_enabled", 1);
        setdvar("playerEnergy_enabled", 1);
        setdvar("wallrun_enabled", 1);
        setdvar("bg_lowGravity", 300);
        setdvar("wallRun_maxTimeMs_zm", 10000);
        setdvar("playerEnergy_maxReserve_zm", -56);
        setdvar("wallRun_peakTest_zm", 0);
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x91daf2dc, Offset: 0x5cc0
// Size: 0x1d4
function function_ffcee12c(s_spawn_point) {
    self endon(#"death");
    self.script_string = "find_flesh";
    self setphysparams(15, 0, 72);
    self.ignore_enemy_count = 1;
    self.deathpoints_already_given = 1;
    self.var_8ac75273 = 1;
    self.exclude_cleanup_adding_to_total = 1;
    self.no_powerups = 1;
    self zombie_utility::zombie_eye_glow();
    util::wait_network_frame();
    if (level flag::get("book_runes_success")) {
        if (self.zombie_move_speed === "walk") {
            self zombie_utility::set_zombie_run_cycle("run");
        }
    } else {
        if (!isdefined(level.var_c8508622)) {
            function_ac6877f7();
        }
        level.var_c8508622--;
    }
    find_flesh_struct_string = "find_flesh";
    self notify(#"zombie_custom_think_done", find_flesh_struct_string);
    self.nocrawler = 1;
    self.no_powerups = 1;
    self waittill(#"completed_emerging_into_playable_area");
    self.no_powerups = 1;
    if (!level flag::get("book_runes_success")) {
        if (level.var_c8508622 < 0) {
            self thread function_2a690b3b();
            function_ac6877f7();
        }
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xb6859f4d, Offset: 0x5ea0
// Size: 0x34
function function_2a690b3b() {
    self waittill(#"death");
    zm_powerups::specific_powerup_drop("full_ammo", self.origin);
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x44cf0fee, Offset: 0x5ee0
// Size: 0x40
function function_ac6877f7() {
    level.var_c8508622 = randomintrange(25, 45);
    level.var_c8508622 *= level.activeplayers.size;
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0xecd6f4dc, Offset: 0x5f28
// Size: 0x7e
function function_6ab2d662(var_87c8152d) {
    switch (var_87c8152d) {
    case 0:
        return "light";
    case 1:
        return "shadow";
    case 2:
        return "fire";
    case 3:
        return "electricity";
    case 5:
        return "blood";
    case 4:
        return "weapon";
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xbb36dc1a, Offset: 0x5fb0
// Size: 0x7e
function function_e05cf870() {
    var_53c2d5b3 = level clientfield::get("arena_state");
    if (var_53c2d5b3 != 1) {
        return false;
    }
    var_ba27cc22 = level clientfield::get("circle_state");
    if (var_ba27cc22 != 2) {
        return false;
    }
    return true;
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x0
// Checksum 0x103d4ed7, Offset: 0x6038
// Size: 0x138
function function_2cca8355() {
    self endon(#"death");
    while (true) {
        player = self waittill(#"trigger");
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        if (function_e05cf870() == 0) {
            continue;
        }
        if (level flag::get("arena_challenge_complete_" + self.stub.var_87c8152d)) {
            continue;
        }
        if (level flag::get(self.stub.var_60c1e5f7) == 0) {
            continue;
        }
        level.var_a7414746 = player;
        function_6a03c1d4(self.stub.var_87c8152d, level.var_f98b3213);
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0x4d47e52a, Offset: 0x6178
// Size: 0x31c
function function_6a03c1d4(var_87c8152d, var_eadfbdd4) {
    if (level.var_fe2fb4b9 != -1) {
        level notify(#"hash_45115ebd");
        func_cleanup = level.var_5afa678d[level.var_fe2fb4b9];
        level [[ func_cleanup ]]();
    }
    level.var_fe2fb4b9 = var_87c8152d;
    level notify(#"hash_f115a4c8");
    level clientfield::set("circle_challenge_identity", var_87c8152d);
    level clientfield::set("arena_state", 2);
    level clientfield::set("circle_state", 3);
    level.var_42ec150d = function_607249fd();
    level.var_beccbadb = 0;
    level.var_de72c885 = 0;
    level.var_435967f3 = 0;
    level.var_278e37cd = 0;
    if (level flag::get("custom_challenge")) {
        /#
            iprintlnbold("int");
            iprintlnbold("int" + level flag::get("int") + "int" + level flag::get("int") + "int" + level flag::get("int"));
            iprintlnbold("int" + level flag::get("int") + "int" + level flag::get("int") + "int" + level flag::get("int") + "int" + level flag::get("int"));
        #/
        function_3cc5d8a6(var_eadfbdd4);
        return;
    }
    /#
        iprintlnbold("int" + function_6ab2d662(var_87c8152d));
    #/
    var_cecde52d = level.var_43e34f20[var_87c8152d];
    level thread [[ var_cecde52d ]](var_87c8152d, var_eadfbdd4);
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x56240967, Offset: 0x64a0
// Size: 0x11e
function function_3dbace38() {
    for (i = 0; i < 4; i++) {
        e_pillar = getent("pillar_element_" + i, "targetname");
        for (j = 0; j < 4; j++) {
            str_name = function_6ab2d662(j);
            e_pillar hidepart("tag_" + str_name);
        }
        e_pillar showpart("tag_default");
    }
    if (isdefined(level.var_48b697ad)) {
        exploder::stop_exploder(level.var_48b697ad);
        level.var_48b697ad = undefined;
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0xbdc318e2, Offset: 0x65c8
// Size: 0x20c
function function_b6ddba23(var_6c0518cd) {
    for (i = 0; i < 4; i++) {
        e_pillar = getent("pillar_element_" + i, "targetname");
        e_pillar hidepart("tag_default");
        str_name = function_6ab2d662(var_6c0518cd);
        e_pillar showpart("tag_" + str_name);
    }
    switch (var_6c0518cd) {
    case 0:
        str_exploder = "fxexp_081";
        playsoundatposition("zmb_bossrush_element_light", (0, 0, 0));
        break;
    case 1:
        str_exploder = "fxexp_084";
        playsoundatposition("zmb_bossrush_element_shadow", (0, 0, 0));
        break;
    case 3:
        str_exploder = "fxexp_087";
        playsoundatposition("zmb_bossrush_element_electricity", (0, 0, 0));
        break;
    case 2:
        playsoundatposition("zmb_bossrush_element_fire", (0, 0, 0));
        break;
    }
    if (isdefined(level.var_48b697ad)) {
        exploder::stop_exploder(level.var_48b697ad);
    }
    if (isdefined(str_exploder)) {
        level.var_48b697ad = str_exploder;
        exploder::exploder(level.var_48b697ad);
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x36afce79, Offset: 0x67e0
// Size: 0x104
function function_3cc5d8a6(var_eadfbdd4) {
    if (!isdefined(var_eadfbdd4)) {
        var_eadfbdd4 = 0;
    }
    if (level flag::get("custom_challenge_wallrun")) {
        level flag::set("arena_wallrun_active");
    }
    if (level flag::get("custom_challenge_lowgrav")) {
        level flag::set("arena_lowgrav_active");
    }
    if (level flag::get("custom_challenge_smoke")) {
        function_c5938cab(1);
    }
    function_44d21c21(level flag::get("custom_challenge_bridge"));
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x0
// Checksum 0xc7420c74, Offset: 0x68f0
// Size: 0xd4
function function_32197961() {
    if (level flag::get("custom_challenge_wallrun")) {
        level flag::clear("arena_wallrun_active");
    }
    if (level flag::get("custom_challenge_lowgrav")) {
        level flag::clear("arena_lowgrav_active");
    }
    if (level flag::get("custom_challenge_smoke")) {
        function_c5938cab(0);
    }
    function_44d21c21(0);
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x31fd85ab, Offset: 0x69d0
// Size: 0xc4
function function_607249fd() {
    var_93107413 = 0;
    players = level.activeplayers;
    foreach (player in players) {
        if ([[ level.var_d90687be ]]->function_2a75673(player)) {
            var_93107413 += 1;
        }
    }
    return var_93107413;
}

// Namespace namespace_f153ce01
// Params 4, eflags: 0x1 linked
// Checksum 0xbc7fb652, Offset: 0x6aa0
// Size: 0x38c
function function_48ffe1e9(var_87c8152d, var_eadfbdd4, var_e78a4f30, var_47a4362c) {
    if (!isdefined(var_eadfbdd4)) {
        var_eadfbdd4 = 0;
    }
    if (!isdefined(var_e78a4f30)) {
        var_e78a4f30 = 0;
    }
    if (!isdefined(var_47a4362c)) {
        var_47a4362c = 0;
    }
    level thread function_b6ddba23(var_87c8152d);
    if (var_e78a4f30 == 0) {
        level.var_beccbadb = 0;
        level.var_de72c885 = 0;
        level.var_c4133b63 = 3;
    }
    if (var_47a4362c == 1) {
        level.var_beccbadb = 0;
        level.var_de72c885 = 0;
        level.var_c4133b63 = 2;
    }
    players = level.activeplayers;
    foreach (player in players) {
        if ([[ level.var_d90687be ]]->function_2a75673(player)) {
            player thread function_d41481d2();
        }
    }
    exploder::exploder("lgt_darkarena_nuetral");
    exploder::exploder("lgt_darkarena_light_quest");
    for (x = 1; x < 4; x++) {
        for (y = 0; y < 5; y++) {
            var_495730fe = function_7d8f4dd0(x, y);
            var_495730fe.var_9391fde5 = 0;
            var_495730fe.n_x = x;
            var_495730fe.n_y = y;
        }
    }
    level clientfield::set("light_challenge_floor", 1);
    level thread function_df89e25c();
    players = level.activeplayers;
    foreach (player in players) {
        if ([[ level.var_d90687be ]]->function_2a75673(player)) {
            player thread function_e883aed0();
        }
    }
    if (var_e78a4f30 == 0) {
        wait(3);
        thread [[ level.var_d90687be ]]->function_a1c7821d(0);
        thread [[ level.var_d90687be ]]->function_e4dbca5a(var_87c8152d);
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0xa4563ded, Offset: 0x6e38
// Size: 0x184
function function_876e8a3c(var_e78a4f30, var_47a4362c) {
    if (!isdefined(var_e78a4f30)) {
        var_e78a4f30 = 0;
    }
    if (!isdefined(var_47a4362c)) {
        var_47a4362c = 0;
    }
    level.var_fe2fb4b9 = -1;
    level thread function_3dbace38();
    level notify(#"hash_45115ebd");
    level notify(#"hash_236ae2f0");
    exploder::stop_exploder("lgt_darkarena_nuetral");
    exploder::stop_exploder("lgt_darkarena_light_quest");
    for (x = 1; x < 4; x++) {
        for (y = 0; y < 5; y++) {
            exploder::stop_exploder("lgt_darkarena_light_safezone_" + x + "_" + y + "_safe");
            exploder::stop_exploder("lgt_darkarena_light_safezone_" + x + "_" + y + "_danger");
        }
    }
    level clientfield::set("light_challenge_floor", 0);
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x90ddd55e, Offset: 0x6fc8
// Size: 0xb0
function function_d41481d2() {
    self allowdoublejump(1);
    self setperk("specialty_lowgravity");
    self.var_7dd18a0 = 1;
    level util::waittill_any("arena_challenge_ended", "light_challenge_ended");
    self allowdoublejump(0);
    self unsetperk("specialty_lowgravity");
    self.var_7dd18a0 = 0;
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x11e3456, Offset: 0x7080
// Size: 0x2e8
function function_e883aed0() {
    level endon(#"hash_45115ebd");
    level endon(#"hash_236ae2f0");
    if (!isdefined(self.var_c08f97f)) {
        self.var_c08f97f = 0;
    }
    if (!isdefined(self.var_fe2d0be6)) {
        self.var_fe2d0be6 = 0;
    }
    var_ba0ff41 = [];
    for (x = 1; x < 4; x++) {
        for (y = 0; y < 5; y++) {
            var_495730fe = function_7d8f4dd0(x, y);
            if (!isdefined(var_ba0ff41)) {
                var_ba0ff41 = [];
            } else if (!isarray(var_ba0ff41)) {
                var_ba0ff41 = array(var_ba0ff41);
            }
            var_ba0ff41[var_ba0ff41.size] = var_495730fe;
        }
    }
    while (true) {
        if (self laststand::player_is_in_laststand()) {
            self.var_fe2d0be6 = 0;
            wait(0.2);
            continue;
        }
        if (!self isonground()) {
            wait(0.2);
            continue;
        }
        var_be0f0621 = arraygetclosest(self.origin, var_ba0ff41);
        n_dist = distance2dsquared(self.origin, var_be0f0621.origin);
        self.var_c08f97f = n_dist > 16384 || !(isdefined(var_be0f0621.var_9391fde5) && var_be0f0621.var_9391fde5);
        if (self.var_c08f97f) {
            self.var_fe2d0be6 += 1;
            if (self.var_fe2d0be6 > 3) {
                var_ba5b7fb9 = self.maxhealth * 0.002 * (self.var_fe2d0be6 - 3);
                self dodamage(var_ba5b7fb9, self.origin, undefined, undefined, undefined, "MOD_BURNED", 0, getweapon("incendiary_fire"));
            }
        } else {
            self.var_fe2d0be6 = 0;
            var_be0f0621 notify(#"hash_ded217c8");
        }
        wait(0.2);
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x5deb1d4e, Offset: 0x7370
// Size: 0x9c
function function_df89e25c() {
    level thread function_8a121ebd(1, 2);
    level thread function_8a121ebd(2, 2);
    level thread function_8a121ebd(3, 2);
    level thread function_8a121ebd(2, 4);
    level thread function_8a121ebd(2, 0);
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xa1cada0, Offset: 0x7418
// Size: 0x122
function function_73ff31ff() {
    var_b687ed6e = [];
    for (x = 1; x < 4; x++) {
        for (y = 0; y < 5; y++) {
            var_495730fe = function_7d8f4dd0(x, y);
            if (!(isdefined(var_495730fe.var_9391fde5) && var_495730fe.var_9391fde5)) {
                if (!isdefined(var_b687ed6e)) {
                    var_b687ed6e = [];
                } else if (!isarray(var_b687ed6e)) {
                    var_b687ed6e = array(var_b687ed6e);
                }
                var_b687ed6e[var_b687ed6e.size] = var_495730fe;
            }
        }
    }
    return array::random(var_b687ed6e);
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0xb9989966, Offset: 0x7548
// Size: 0x6c
function function_7d8f4dd0(n_x, n_y) {
    var_9814a6d8 = "arena_light_safepoint_" + n_x + "_" + n_y;
    var_495730fe = struct::get(var_9814a6d8, "targetname");
    return var_495730fe;
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x423894b7, Offset: 0x75c0
// Size: 0x1a4
function function_9f6208b0() {
    level endon(#"hash_45115ebd");
    level endon(#"hash_236ae2f0");
    self.var_9391fde5 = 1;
    exploder::exploder("lgt_darkarena_light_safezone_" + self.n_x + "_" + self.n_y + "_safe");
    self waittill(#"hash_ded217c8");
    wait(7);
    exploder::stop_exploder("lgt_darkarena_light_safezone_" + self.n_x + "_" + self.n_y + "_safe");
    exploder::exploder("lgt_darkarena_light_safezone_" + self.n_x + "_" + self.n_y + "_danger");
    var_996dc28e = function_73ff31ff();
    var_996dc28e thread function_9f6208b0();
    wait(5);
    exploder::stop_exploder("lgt_darkarena_light_safezone_" + self.n_x + "_" + self.n_y + "_danger");
    playfx(level._effect["light_challenge_safezone_end"], self.origin);
    wait(1);
    self.var_9391fde5 = 0;
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x0
// Checksum 0x67c763c3, Offset: 0x7770
// Size: 0x80
function function_14dd4384(v_origin, fxid) {
    var_89576631 = spawn("script_model", v_origin);
    var_89576631 setmodel("tag_origin");
    playfxontag(fxid, var_89576631, "tag_origin");
    return var_89576631;
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0x2eb7fde0, Offset: 0x77f8
// Size: 0x4c
function function_8a121ebd(n_x, n_y) {
    var_495730fe = function_7d8f4dd0(n_x, n_y);
    var_495730fe thread function_9f6208b0();
}

// Namespace namespace_f153ce01
// Params 4, eflags: 0x1 linked
// Checksum 0xf99e2f3f, Offset: 0x7850
// Size: 0x208
function function_2bacd397(var_87c8152d, var_eadfbdd4, var_e78a4f30, var_47a4362c) {
    if (!isdefined(var_eadfbdd4)) {
        var_eadfbdd4 = 0;
    }
    if (!isdefined(var_e78a4f30)) {
        var_e78a4f30 = 0;
    }
    if (!isdefined(var_47a4362c)) {
        var_47a4362c = 0;
    }
    level thread function_b6ddba23(var_87c8152d);
    if (var_e78a4f30 == 0) {
        level.var_beccbadb = 0;
        level.var_de72c885 = 0;
        level.var_c4133b63 = 3;
    }
    if (var_47a4362c == 1) {
        level.var_beccbadb = 0;
        level.var_de72c885 = 0;
        level.var_c4133b63 = 2;
    }
    exploder::exploder("lgt_darkarena_nuetral");
    exploder::exploder("lgt_darkarena_shadowquest");
    level thread function_80340a8d(0, 16);
    level thread function_80340a8d(4, 16);
    level thread function_80340a8d(8, 16);
    level thread function_80340a8d(12, 16);
    for (i = 0; i < 4; i++) {
        level thread function_27c3331e(i);
    }
    if (var_e78a4f30 == 0) {
        thread [[ level.var_d90687be ]]->function_a1c7821d(0);
        thread [[ level.var_d90687be ]]->function_e4dbca5a(var_87c8152d);
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0x7297dd3, Offset: 0x7a60
// Size: 0x226
function function_80340a8d(n_path_index, var_45868921) {
    level endon(#"hash_45115ebd");
    level endon(#"hash_29f84ef2");
    var_60d3617 = -128;
    var_e453ffc4 = struct::get("arena_shadow_tornado_0_" + n_path_index, "targetname");
    var_f3364be4 = util::spawn_model("tag_origin", var_e453ffc4.origin, (-90, 0, 0));
    if (!isdefined(level.var_633c0362)) {
        level.var_633c0362 = [];
    }
    if (!isdefined(level.var_633c0362)) {
        level.var_633c0362 = [];
    } else if (!isarray(level.var_633c0362)) {
        level.var_633c0362 = array(level.var_633c0362);
    }
    level.var_633c0362[level.var_633c0362.size] = var_f3364be4;
    level thread function_5a0567f1(var_f3364be4);
    while (true) {
        n_path_index += 1;
        if (n_path_index == var_45868921) {
            n_path_index = 0;
        }
        var_e453ffc4 = struct::get("arena_shadow_tornado_0_" + n_path_index, "targetname");
        var_7487d535 = distance(var_e453ffc4.origin, var_f3364be4.origin);
        var_c4f71af2 = var_7487d535 / var_60d3617;
        var_f3364be4 moveto(var_e453ffc4.origin, var_c4f71af2);
        wait(var_c4f71af2);
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0xe9e93a2b, Offset: 0x7c90
// Size: 0x174
function function_5a0567f1(var_f3364be4) {
    level endon(#"hash_45115ebd");
    level endon(#"hash_29f84ef2");
    var_56169cc1 = 0;
    while (!var_56169cc1) {
        var_56169cc1 = 1;
        a_players = arraycopy(level.activeplayers);
        foreach (player in a_players) {
            if (isdefined(player) && distancesquared(var_f3364be4.origin, player.origin) < 36864) {
                var_56169cc1 = 0;
            }
        }
        util::wait_network_frame();
    }
    var_f3364be4 clientfield::set("arena_tornado", 1);
    var_f3364be4 thread function_2b740dcf();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x74c310a4, Offset: 0x7e10
// Size: 0x1b0
function function_2b740dcf() {
    level endon(#"hash_45115ebd");
    level endon(#"hash_29f84ef2");
    self notify(#"hash_2b740dcf");
    self endon(#"hash_2b740dcf");
    self endon(#"delete");
    players = arraycopy(level.activeplayers);
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        players = arraycopy(level.activeplayers);
        foreach (player in players) {
            if (isdefined(player) && isdefined(self)) {
                if (distancesquared(player.origin, self.origin) < 9216) {
                    player dodamage(10, player.origin, undefined, undefined, undefined, "MOD_BURNED", 0, getweapon("incendiary_fire"));
                    level thread function_de3937fa(player);
                }
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x0
// Checksum 0x5989cad1, Offset: 0x7fc8
// Size: 0x36
function function_306a8062() {
    level endon(#"hash_306a8062");
    while (true) {
        function_c5938cab(1);
        wait(3);
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x0
// Checksum 0xa67111fc, Offset: 0x8008
// Size: 0xb6
function function_88f5a59c(var_862980ee) {
    level endon(#"hash_306a8062");
    if (isdefined(var_862980ee)) {
        var_e0a3b3d7 = var_862980ee;
    } else {
    }
    for (var_e0a3b3d7 = 0; true; var_e0a3b3d7 = 0) {
        namespace_cb655c88::function_c3266652("arena_smoke_perimeter_" + var_e0a3b3d7, 1);
        level thread function_ab5cd340(var_e0a3b3d7);
        wait(0.1);
        var_e0a3b3d7 += 1;
        if (var_e0a3b3d7 >= -56) {
        }
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x8013237d, Offset: 0x80c8
// Size: 0x158
function function_ab5cd340(var_e0a3b3d7) {
    var_c99b0356 = struct::get("arena_smoke_perimeter_" + var_e0a3b3d7, "targetname");
    n_start_time = gettime();
    while (gettime() - n_start_time < 1) {
        a_players = arraycopy(level.activeplayers);
        foreach (player in a_players) {
            if (distancesquared(player.origin, var_c99b0356.origin) < 16384) {
                level thread function_de3937fa(player);
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0xc1d599de, Offset: 0x8228
// Size: 0x74
function function_de3937fa(player) {
    player notify(#"hash_de3937fa");
    player endon(#"hash_de3937fa");
    player clientfield::set_to_player("darkness_postfx_set", 1);
    wait(5);
    player clientfield::set_to_player("darkness_postfx_set", 0);
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xbe7ed98b, Offset: 0x82a8
// Size: 0x4e
function function_2f3b6dab() {
    for (i = 0; i < -56; i++) {
        namespace_cb655c88::function_7c229e48("arena_smoke_perimeter_" + i);
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0xd1fbe09, Offset: 0x8300
// Size: 0x232
function function_d2a9fa8c(var_e78a4f30, var_47a4362c) {
    if (!isdefined(var_e78a4f30)) {
        var_e78a4f30 = 0;
    }
    if (!isdefined(var_47a4362c)) {
        var_47a4362c = 0;
    }
    level.var_fe2fb4b9 = -1;
    level thread function_3dbace38();
    a_players = arraycopy(level.activeplayers);
    foreach (player in a_players) {
        player clientfield::set_to_player("darkness_postfx_set", 0);
    }
    level notify(#"hash_306a8062");
    namespace_cb655c88::function_7c229e48("arena_smoke_spider_spawn");
    exploder::stop_exploder("lgt_darkarena_nuetral");
    exploder::stop_exploder("lgt_darkarena_shadowquest");
    function_c5938cab(0);
    function_2f3b6dab();
    foreach (var_f3364be4 in level.var_633c0362) {
        if (isdefined(var_f3364be4)) {
            var_f3364be4 clientfield::set("arena_tornado", 0);
            var_f3364be4 delete();
        }
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x1410a695, Offset: 0x8540
// Size: 0x45c
function function_c5938cab(b_on) {
    var_c3f79192 = [];
    if (!isdefined(var_c3f79192)) {
        var_c3f79192 = [];
    } else if (!isarray(var_c3f79192)) {
        var_c3f79192 = array(var_c3f79192);
    }
    var_c3f79192[var_c3f79192.size] = "arena_smoke_left";
    if (!isdefined(var_c3f79192)) {
        var_c3f79192 = [];
    } else if (!isarray(var_c3f79192)) {
        var_c3f79192 = array(var_c3f79192);
    }
    var_c3f79192[var_c3f79192.size] = "arena_smoke_right";
    if (!isdefined(var_c3f79192)) {
        var_c3f79192 = [];
    } else if (!isarray(var_c3f79192)) {
        var_c3f79192 = array(var_c3f79192);
    }
    var_c3f79192[var_c3f79192.size] = "arena_smoke_front";
    if (!isdefined(var_c3f79192)) {
        var_c3f79192 = [];
    } else if (!isarray(var_c3f79192)) {
        var_c3f79192 = array(var_c3f79192);
    }
    var_c3f79192[var_c3f79192.size] = "arena_smoke_back";
    if (!isdefined(var_c3f79192)) {
        var_c3f79192 = [];
    } else if (!isarray(var_c3f79192)) {
        var_c3f79192 = array(var_c3f79192);
    }
    var_c3f79192[var_c3f79192.size] = "arena_smoke_center_left";
    if (!isdefined(var_c3f79192)) {
        var_c3f79192 = [];
    } else if (!isarray(var_c3f79192)) {
        var_c3f79192 = array(var_c3f79192);
    }
    var_c3f79192[var_c3f79192.size] = "arena_smoke_center_right";
    if (!isdefined(var_c3f79192)) {
        var_c3f79192 = [];
    } else if (!isarray(var_c3f79192)) {
        var_c3f79192 = array(var_c3f79192);
    }
    var_c3f79192[var_c3f79192.size] = "arena_smoke_center_back";
    foreach (var_36655503 in var_c3f79192) {
        namespace_cb655c88::function_7c229e48(var_36655503);
    }
    if (b_on) {
        for (i = 0; i < 3; i++) {
            namespace_cb655c88::function_c3266652(array::random(var_c3f79192), undefined, 0.5);
        }
        return;
    }
    namespace_cb655c88::function_7c229e48("arena_smoke_left");
    namespace_cb655c88::function_7c229e48("arena_smoke_right");
    namespace_cb655c88::function_7c229e48("arena_smoke_front");
    namespace_cb655c88::function_7c229e48("arena_smoke_back");
    namespace_cb655c88::function_7c229e48("arena_smoke_center_left");
    namespace_cb655c88::function_7c229e48("arena_smoke_center_right");
    namespace_cb655c88::function_7c229e48("arena_smoke_center_back");
}

// Namespace namespace_f153ce01
// Params 3, eflags: 0x1 linked
// Checksum 0xcd0ee085, Offset: 0x89a8
// Size: 0x78c
function function_e462dab8(b_on, var_98176bbc, var_8a2d164) {
    if (!isdefined(var_8a2d164)) {
        var_8a2d164 = 10;
    }
    thread [[ level.var_d90687be ]]->function_15c5e1();
    function_1df8c24(b_on, var_98176bbc);
    var_d4a18b68 = [];
    if (!isdefined(var_d4a18b68)) {
        var_d4a18b68 = [];
    } else if (!isarray(var_d4a18b68)) {
        var_d4a18b68 = array(var_d4a18b68);
    }
    var_d4a18b68[var_d4a18b68.size] = "arena_scripted_zombie_pillar";
    switch (var_98176bbc) {
    case 0:
        if (!isdefined(var_d4a18b68)) {
            var_d4a18b68 = [];
        } else if (!isarray(var_d4a18b68)) {
            var_d4a18b68 = array(var_d4a18b68);
        }
        var_d4a18b68[var_d4a18b68.size] = "arena_scripted_zombie_front";
        if (!isdefined(var_d4a18b68)) {
            var_d4a18b68 = [];
        } else if (!isarray(var_d4a18b68)) {
            var_d4a18b68 = array(var_d4a18b68);
        }
        var_d4a18b68[var_d4a18b68.size] = "arena_scripted_zombie_front_left";
        if (!isdefined(var_d4a18b68)) {
            var_d4a18b68 = [];
        } else if (!isarray(var_d4a18b68)) {
            var_d4a18b68 = array(var_d4a18b68);
        }
        var_d4a18b68[var_d4a18b68.size] = "arena_scripted_zombie_front_right";
        break;
    case 1:
        if (!isdefined(var_d4a18b68)) {
            var_d4a18b68 = [];
        } else if (!isarray(var_d4a18b68)) {
            var_d4a18b68 = array(var_d4a18b68);
        }
        var_d4a18b68[var_d4a18b68.size] = "arena_scripted_zombie_back";
        if (!isdefined(var_d4a18b68)) {
            var_d4a18b68 = [];
        } else if (!isarray(var_d4a18b68)) {
            var_d4a18b68 = array(var_d4a18b68);
        }
        var_d4a18b68[var_d4a18b68.size] = "arena_scripted_zombie_back_left";
        if (!isdefined(var_d4a18b68)) {
            var_d4a18b68 = [];
        } else if (!isarray(var_d4a18b68)) {
            var_d4a18b68 = array(var_d4a18b68);
        }
        var_d4a18b68[var_d4a18b68.size] = "arena_scripted_zombie_back_right";
        break;
    case 2:
        if (!isdefined(var_d4a18b68)) {
            var_d4a18b68 = [];
        } else if (!isarray(var_d4a18b68)) {
            var_d4a18b68 = array(var_d4a18b68);
        }
        var_d4a18b68[var_d4a18b68.size] = "arena_scripted_zombie_left";
        if (!isdefined(var_d4a18b68)) {
            var_d4a18b68 = [];
        } else if (!isarray(var_d4a18b68)) {
            var_d4a18b68 = array(var_d4a18b68);
        }
        var_d4a18b68[var_d4a18b68.size] = "arena_scripted_zombie_front_left";
        if (!isdefined(var_d4a18b68)) {
            var_d4a18b68 = [];
        } else if (!isarray(var_d4a18b68)) {
            var_d4a18b68 = array(var_d4a18b68);
        }
        var_d4a18b68[var_d4a18b68.size] = "arena_scripted_zombie_back_left";
        break;
    case 3:
        if (!isdefined(var_d4a18b68)) {
            var_d4a18b68 = [];
        } else if (!isarray(var_d4a18b68)) {
            var_d4a18b68 = array(var_d4a18b68);
        }
        var_d4a18b68[var_d4a18b68.size] = "arena_scripted_zombie_right";
        if (!isdefined(var_d4a18b68)) {
            var_d4a18b68 = [];
        } else if (!isarray(var_d4a18b68)) {
            var_d4a18b68 = array(var_d4a18b68);
        }
        var_d4a18b68[var_d4a18b68.size] = "arena_scripted_zombie_front_right";
        if (!isdefined(var_d4a18b68)) {
            var_d4a18b68 = [];
        } else if (!isarray(var_d4a18b68)) {
            var_d4a18b68 = array(var_d4a18b68);
        }
        var_d4a18b68[var_d4a18b68.size] = "arena_scripted_zombie_back_right";
        break;
    }
    var_f7894032 = [];
    foreach (var_5704a921 in var_d4a18b68) {
        var_a5b51858 = struct::get_array(var_5704a921, "script_noteworthy");
        foreach (s_spawner in var_a5b51858) {
            if (!isdefined(var_f7894032)) {
                var_f7894032 = [];
            } else if (!isarray(var_f7894032)) {
                var_f7894032 = array(var_f7894032);
            }
            var_f7894032[var_f7894032.size] = s_spawner;
        }
    }
    foreach (var_ed54bf23 in var_f7894032) {
        var_ed54bf23.var_4ef230e4 = 1;
    }
    wait(10);
    function_1df8c24(0, var_98176bbc);
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0xe017bf5a, Offset: 0x9140
// Size: 0x120
function function_1df8c24(b_on, var_98176bbc) {
    if (b_on) {
        exploder::exploder("fxexp_0" + var_98176bbc + "1");
        wait(2);
        exploder::stop_exploder("fxexp_0" + var_98176bbc + "1");
        exploder::exploder("fxexp_0" + var_98176bbc + "2");
        level thread function_d81d4dd8(var_98176bbc);
        return;
    }
    exploder::stop_exploder("fxexp_0" + var_98176bbc + "2");
    exploder::exploder("fxexp_0" + var_98176bbc + "3");
    level notify("arena_challenge_flame_wall_damage_thread_" + var_98176bbc);
}

// Namespace namespace_f153ce01
// Params 4, eflags: 0x1 linked
// Checksum 0x62996eed, Offset: 0x9268
// Size: 0x188
function function_f1e6c2a7(var_87c8152d, var_eadfbdd4, var_e78a4f30, var_47a4362c) {
    if (!isdefined(var_eadfbdd4)) {
        var_eadfbdd4 = 0;
    }
    if (!isdefined(var_e78a4f30)) {
        var_e78a4f30 = 0;
    }
    if (!isdefined(var_47a4362c)) {
        var_47a4362c = 0;
    }
    level thread function_b6ddba23(var_87c8152d);
    if (var_e78a4f30 == 0) {
        level.var_beccbadb = 0;
        level.var_de72c885 = 0;
        level.var_c4133b63 = 3;
    }
    if (var_47a4362c == 1) {
        level.var_beccbadb = 0;
        level.var_de72c885 = 0;
        level.var_c4133b63 = 2;
    }
    exploder::exploder("lgt_darkarena_nuetral");
    exploder::exploder("lgt_darkarena_firequest");
    level thread function_e499e553();
    level thread function_82a0458d();
    level thread function_e06bfc41();
    if (var_e78a4f30 == 0) {
        thread [[ level.var_d90687be ]]->function_a1c7821d(1);
        thread [[ level.var_d90687be ]]->function_e4dbca5a(var_87c8152d);
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x7814963a, Offset: 0x93f8
// Size: 0x86
function function_82a0458d() {
    for (i = 0; i < 10; i++) {
        var_eeb53a6c = struct::get("arena_lava_upper_" + i);
        level thread function_36c2a88b(var_eeb53a6c.origin);
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x5977c2f5, Offset: 0x9488
// Size: 0x8c
function function_e06bfc41() {
    level endon(#"hash_45115ebd");
    level endon(#"hash_82cca6b6");
    for (var_44ed020 = randomintrange(0, 4); true; var_44ed020 = function_320bc09(4, var_44ed020)) {
        level thread function_a0aeb892(var_44ed020);
        wait(31);
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0xa845c9f5, Offset: 0x9520
// Size: 0x12c
function function_a0aeb892(var_93c52a20) {
    var_6da45390 = struct::get("arena_pillar_lava_" + var_93c52a20, "targetname");
    var_8f719caf = util::spawn_model("p7_fxanim_zm_gen_dark_arena_lava_01_mod", var_6da45390.origin, (0, randomintrange(0, 360), 0));
    var_8f719caf thread function_4706cfff(30000, 1);
    util::waittill_any_timeout(31, "arena_challenge_ended", "fire_challenge_ended");
    var_8f719caf clientfield::set("fire_column", 0);
    util::wait_network_frame();
    var_8f719caf delete();
    util::wait_network_frame();
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0x4f58ff7e, Offset: 0x9658
// Size: 0x3f0
function function_4706cfff(n_duration, var_325cfa0d) {
    if (!isdefined(var_325cfa0d)) {
        var_325cfa0d = 0;
    }
    level endon(#"hash_45115ebd");
    level endon(#"hash_82cca6b6");
    self endon(#"delete");
    if (var_325cfa0d) {
        self clientfield::set("fire_column", 1);
        var_112f4912 = 4;
    } else {
        var_112f4912 = 0.75;
    }
    n_rate = 1 / n_duration / -76;
    var_c8ec0774 = var_112f4912 - 0.25;
    n_start_time = gettime();
    n_time_elapsed = gettime() - n_start_time;
    var_a8c2ff4b = 0;
    var_e2b185cf = n_duration * 0.9;
    if (var_325cfa0d) {
        self thread scene::play("p7_fxanim_zm_gen_dark_arena_lava_01_bundle", self);
    } else {
        self thread scene::play("p7_fxanim_zm_gen_dark_arena_lava_01_small_bundle", self);
    }
    while (n_time_elapsed < n_duration) {
        if (!isdefined(self)) {
            return;
        }
        n_time_elapsed = gettime() - n_start_time;
        var_615956ca = sin(n_time_elapsed * n_rate);
        var_615956ca = abs(var_615956ca);
        n_scale = 0.25 + var_615956ca * var_c8ec0774;
        if (var_325cfa0d && n_time_elapsed > var_e2b185cf && !var_a8c2ff4b) {
            self clientfield::set("fire_column", 0);
            var_a8c2ff4b = 1;
        }
        players = level.activeplayers;
        foreach (player in players) {
            var_14f93b92 = distance2dsquared(player.origin, self.origin) < pow(n_scale * 116, 2);
            var_9cad7403 = player.origin[2] < self.origin[2] + 8;
            if (var_14f93b92 && var_9cad7403 && player isonground()) {
                player dodamage(10, player.origin, undefined, undefined, undefined, "MOD_BURNED", 0, getweapon("incendiary_fire"));
                level thread function_33b2cd3e(player);
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x7a6ed9cf, Offset: 0x9a50
// Size: 0x240
function function_d81d4dd8(var_7c34c9a5) {
    level notify("arena_challenge_flame_wall_damage_thread_" + var_7c34c9a5);
    level endon("arena_challenge_flame_wall_damage_thread_" + var_7c34c9a5);
    level endon(#"hash_45115ebd");
    level endon(#"hash_82cca6b6");
    var_7b45393e = getentarray("arena_flame_wall_" + var_7c34c9a5, "targetname");
    while (true) {
        foreach (e_trigger in var_7b45393e) {
            players = arraycopy(level.activeplayers);
            foreach (player in players) {
                if (isdefined(player) && player istouching(e_trigger)) {
                    player dodamage(player.maxhealth * 0.05, player.origin, undefined, undefined, undefined, "MOD_BURNED", 0, getweapon("incendiary_fire"));
                    level thread function_33b2cd3e(player);
                }
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x0
// Checksum 0x4e150802, Offset: 0x9c98
// Size: 0x148
function function_e3782b49() {
    level endon(#"hash_45115ebd");
    level endon(#"hash_82cca6b6");
    self endon(#"delete");
    while (true) {
        players = level.activeplayers;
        foreach (player in players) {
            if (player istouching(self)) {
                player dodamage(10, player.origin, undefined, undefined, undefined, "MOD_BURNED", 0, getweapon("incendiary_fire"));
                level thread function_33b2cd3e(player);
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0x64714315, Offset: 0x9de8
// Size: 0x200
function function_36c2a88b(v_spawn_pos, n_wait) {
    wait(randomfloatrange(0.5, 17.5));
    while (level.var_fe2fb4b9 == 2) {
        var_2f0b203b = util::spawn_model("tag_origin", v_spawn_pos + (0, 0, -25), (0, randomintrange(0, 360), 0));
        util::wait_network_frame();
        var_2f0b203b clientfield::set("runeprison_rock_fx", 1);
        wait(3);
        var_2f0b203b clientfield::set("runeprison_explode_fx", 1);
        var_8f719caf = util::spawn_model("p7_fxanim_zm_gen_dark_arena_lava_01_small_mod", v_spawn_pos + (0, 0, -13), (0, randomintrange(0, 360), 0));
        var_8f719caf function_4706cfff(8500);
        var_8f719caf delete();
        var_2f0b203b clientfield::set("runeprison_rock_fx", 0);
        wait(6);
        var_2f0b203b delete();
        wait(randomfloatrange(5, 17.5 / 2));
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x25ce5371, Offset: 0x9ff0
// Size: 0xb0
function function_e499e553() {
    level endon(#"hash_45115ebd");
    level endon(#"hash_82cca6b6");
    while (true) {
        var_98176bbc = randomint(5);
        level thread function_e462dab8(1, var_98176bbc);
        wait(5);
        var_98176bbc = randomintrange(5, 8);
        level thread function_e462dab8(1, var_98176bbc);
        wait(5);
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0x4cec685d, Offset: 0xa0a8
// Size: 0x118
function function_56b687ac(var_e78a4f30, var_47a4362c) {
    if (!isdefined(var_e78a4f30)) {
        var_e78a4f30 = 0;
    }
    if (!isdefined(var_47a4362c)) {
        var_47a4362c = 0;
    }
    level.var_fe2fb4b9 = -1;
    level thread function_3dbace38();
    level notify(#"hash_45115ebd");
    level notify(#"hash_82cca6b6");
    exploder::stop_exploder("lgt_darkarena_nuetral");
    exploder::stop_exploder("lgt_darkarena_firequest");
    for (i = 0; i < 8; i++) {
        level thread function_e462dab8(0, i);
    }
    if (!level flag::get("final_boss_started")) {
        thread [[ level.var_d90687be ]]->function_15c5e1();
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x4df74e8a, Offset: 0xa1c8
// Size: 0x74
function function_33b2cd3e(player) {
    player notify(#"hash_33b2cd3e");
    player endon(#"hash_33b2cd3e");
    player clientfield::set_to_player("fire_postfx_set", 1);
    wait(2);
    player clientfield::set_to_player("fire_postfx_set", 0);
}

// Namespace namespace_f153ce01
// Params 4, eflags: 0x1 linked
// Checksum 0xa1cd77d3, Offset: 0xa248
// Size: 0x18c
function function_f1aed0c6(var_87c8152d, var_eadfbdd4, var_e78a4f30, var_47a4362c) {
    if (!isdefined(var_eadfbdd4)) {
        var_eadfbdd4 = 0;
    }
    if (!isdefined(var_e78a4f30)) {
        var_e78a4f30 = 0;
    }
    if (!isdefined(var_47a4362c)) {
        var_47a4362c = 0;
    }
    level thread function_b6ddba23(var_87c8152d);
    if (var_e78a4f30 == 0) {
        level.var_beccbadb = 0;
        level.var_de72c885 = 0;
        level.var_c4133b63 = 3;
    }
    if (var_47a4362c == 1) {
        level.var_beccbadb = 0;
        level.var_de72c885 = 0;
        level.var_c4133b63 = 2;
    }
    level.var_867977f0 = [];
    level thread function_c0d6adb6();
    level thread function_e2a11bad();
    level thread function_ffce63a9();
    exploder::exploder("lgt_darkarena_nuetral");
    exploder::exploder("lgt_darkarena_electric_quest");
    if (var_e78a4f30 == 0) {
        thread [[ level.var_d90687be ]]->function_a1c7821d(0);
        thread [[ level.var_d90687be ]]->function_e4dbca5a(var_87c8152d);
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0xb5689d71, Offset: 0xa3e0
// Size: 0xdc
function function_c78d187b(var_e78a4f30, var_47a4362c) {
    if (!isdefined(var_e78a4f30)) {
        var_e78a4f30 = 0;
    }
    if (!isdefined(var_47a4362c)) {
        var_47a4362c = 0;
    }
    level.var_fe2fb4b9 = -1;
    level thread function_3dbace38();
    level.var_435967f3 = 0;
    level notify(#"hash_c0d6adb6");
    exploder::stop_exploder("lgt_darkarena_nuetral");
    exploder::stop_exploder("lgt_darkarena_electric_quest");
    if (isdefined(level.var_867977f0)) {
        array::thread_all(level.var_867977f0, &function_4d79d831);
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x51b12b9d, Offset: 0xa4c8
// Size: 0x2d6
function function_c0d6adb6() {
    level endon(#"hash_c0d6adb6");
    level endon(#"hash_45115ebd");
    level endon(#"hash_57ad5f83");
    var_4054c946 = 4;
    var_665743af = 4;
    var_5c856d1f = randomintrange(0, 4);
    switch (var_5c856d1f) {
    case 0:
        var_665743af -= 1;
        break;
    case 1:
        var_665743af += 1;
        break;
    case 2:
        var_4054c946 -= 1;
        break;
    case 3:
        var_4054c946 += 1;
        break;
    }
    while (true) {
        b_reverse_dir = 0;
        if (var_5c856d1f == 2 || var_5c856d1f == 1) {
            b_reverse_dir = 1;
        }
        str_name = "arena_fence_" + var_4054c946 + "_" + var_665743af;
        var_44622ece = struct::get(str_name, "targetname");
        level thread function_cc9c82c8(var_44622ece, 3, undefined, b_reverse_dir, 1);
        wait(0.75);
        switch (var_5c856d1f) {
        case 0:
            var_665743af += 1;
            break;
        case 1:
            var_665743af -= 1;
            break;
        case 2:
            var_4054c946 -= 1;
            break;
        case 3:
            var_4054c946 += 1;
            break;
        }
        var_5c856d1f = function_1bd87d75(var_4054c946, var_665743af, var_5c856d1f);
        switch (var_5c856d1f) {
        case 0:
            var_665743af += 1;
            break;
        case 1:
            var_665743af -= 1;
            break;
        case 2:
            var_4054c946 -= 1;
            break;
        case 3:
            var_4054c946 += 1;
            break;
        }
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x10189fa5, Offset: 0xa7a8
// Size: 0x126
function function_e2a11bad() {
    level endon(#"hash_45115ebd");
    level endon(#"hash_57ad5f83");
    var_bcc7a104 = 0;
    var_d5c2ef73 = 6;
    while (true) {
        var_bcc7a104 += 1;
        if (var_bcc7a104 > 3) {
            var_bcc7a104 = 0;
        }
        str_name = "arena_fence_ext_low_" + var_bcc7a104;
        level thread function_5e9f49d2(str_name, 7, (0, 0, -192), 0, 2);
        var_d5c2ef73 += 1;
        if (var_d5c2ef73 > 7) {
            var_d5c2ef73 = 4;
        }
        str_name = "arena_fence_ext_low_" + var_d5c2ef73;
        level thread function_5e9f49d2(str_name, 7, (0, 0, -192), 0, 2);
        wait(5);
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x466ce170, Offset: 0xa8d8
// Size: 0xf0
function function_ffce63a9() {
    level endon(#"hash_45115ebd");
    level endon(#"hash_57ad5f83");
    var_c2d82f9b = array(0, 1, 2, 3, 4, 5);
    while (true) {
        var_c2d82f9b = array::randomize(var_c2d82f9b);
        for (i = 0; i < 3; i++) {
            str_name = "arena_fence_ext_high_" + var_c2d82f9b[i];
            level thread function_5e9f49d2(str_name, 7, (0, 0, -192), 0, 3);
        }
        wait(5);
    }
}

// Namespace namespace_f153ce01
// Params 3, eflags: 0x1 linked
// Checksum 0x668f5f90, Offset: 0xa9d0
// Size: 0x2e0
function function_1bd87d75(var_4054c946, var_665743af, var_5c856d1f) {
    if (var_4054c946 == 0 && var_665743af == 0) {
        if (var_5c856d1f == 1) {
            return 3;
        } else {
            return 0;
        }
    }
    if (var_4054c946 == 8 && var_665743af == 0) {
        if (var_5c856d1f == 1) {
            return 2;
        } else {
            return 0;
        }
    }
    if (var_4054c946 == 0 && var_665743af == 8) {
        if (var_5c856d1f == 0) {
            return 3;
        } else {
            return 1;
        }
    }
    if (var_4054c946 == 8 && var_665743af == 8) {
        if (var_5c856d1f == 0) {
            return 2;
        } else {
            return 1;
        }
    }
    var_47c6b9e2 = function_c3557b99(var_5c856d1f);
    if (function_401ee1f7(var_4054c946, var_665743af)) {
        if (var_4054c946 == 4 && var_665743af == 0) {
            var_6af9e605 = array(2, 0, 3);
        }
        if (var_4054c946 == 0 && var_665743af == 4) {
            var_6af9e605 = array(1, 0, 3);
        }
        if (var_4054c946 == 4 && var_665743af == 8) {
            var_6af9e605 = array(2, 1, 3);
        }
        if (var_4054c946 == 8 && var_665743af == 4) {
            var_6af9e605 = array(2, 0, 1);
        }
        var_6af9e605 = namespace_cb655c88::array_remove(var_6af9e605, var_47c6b9e2);
        return array::random(var_6af9e605);
    }
    if (var_4054c946 == 4 && var_665743af == 4) {
        var_6af9e605 = array(2, 0, 3, 1);
        var_6af9e605 = namespace_cb655c88::array_remove(var_6af9e605, var_47c6b9e2);
        return array::random(var_6af9e605);
    }
    return var_5c856d1f;
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0xd094907e, Offset: 0xacb8
// Size: 0x88
function function_401ee1f7(var_4054c946, var_665743af) {
    if (var_4054c946 == 8 && (var_4054c946 == 4 && (var_4054c946 == 0 && (var_4054c946 == 4 && var_665743af == 0 || var_665743af == 4) || var_665743af == 8) || var_665743af == 4)) {
        return true;
    }
    return false;
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x842d8479, Offset: 0xad48
// Size: 0x58
function function_c3557b99(var_94edb8e1) {
    if (var_94edb8e1 == 0) {
        return 1;
    }
    if (var_94edb8e1 == 1) {
        return 0;
    }
    if (var_94edb8e1 == 2) {
        return 3;
    }
    if (var_94edb8e1 == 3) {
        return 2;
    }
}

// Namespace namespace_f153ce01
// Params 5, eflags: 0x1 linked
// Checksum 0x58b2a8e9, Offset: 0xada8
// Size: 0xf2
function function_5e9f49d2(str_name, n_duration, v_offset, b_reverse_dir, var_b222a396) {
    var_659d66d1 = struct::get_array(str_name, "targetname");
    foreach (var_44622ece in var_659d66d1) {
        level thread function_cc9c82c8(var_44622ece, n_duration, v_offset, b_reverse_dir, var_b222a396);
    }
}

// Namespace namespace_f153ce01
// Params 5, eflags: 0x1 linked
// Checksum 0x26d1d6f0, Offset: 0xaea8
// Size: 0x354
function function_cc9c82c8(var_44622ece, n_duration, v_offset, b_reverse_dir, var_b222a396) {
    if (isdefined(var_44622ece.var_1771513c) && var_44622ece.var_1771513c) {
        return;
    }
    var_44622ece.var_1771513c = 1;
    if (var_b222a396 == 3) {
        var_21d644c = util::spawn_model("p7_fxanim_zm_gen_dark_arena_moving_wall_02_mod", var_44622ece.origin, var_44622ece.angles);
    } else {
        var_21d644c = util::spawn_model("p7_fxanim_zm_gen_dark_arena_moving_wall_mod", var_44622ece.origin, var_44622ece.angles);
    }
    if (isdefined(b_reverse_dir) && b_reverse_dir) {
        var_21d644c.angles += (0, 180, 0);
    }
    var_21d644c notsolid();
    util::wait_network_frame();
    var_21d644c clientfield::increment("elec_wall_tell");
    wait(1);
    switch (var_b222a396) {
    case 1:
        var_7146001e = "p7_fxanim_zm_gen_dark_arena_moving_wall_rise_anim";
        var_117d442a = "p7_fxanim_zm_gen_dark_arena_moving_wall_fall_anim";
        break;
    case 2:
        var_7146001e = "p7_fxanim_zm_gen_dark_arena_moving_wall_rise02_anim";
        var_117d442a = "p7_fxanim_zm_gen_dark_arena_moving_wall_fall02_anim";
        break;
    case 3:
        var_7146001e = "p7_fxanim_zm_gen_dark_arena_moving_wall_02_rise_anim";
        var_117d442a = "p7_fxanim_zm_gen_dark_arena_moving_wall_02_fall_anim";
        break;
    }
    var_21d644c useanimtree(#zm_genesis);
    var_21d644c thread animation::play(var_7146001e, undefined, undefined, 1);
    v_origin = var_44622ece.origin;
    if (!isdefined(v_offset)) {
        v_offset = (0, 0, 128);
    }
    wait(0.5);
    var_21d644c solid();
    var_21d644c thread function_48791cb7();
    wait(0.5);
    if (isdefined(n_duration)) {
        wait(n_duration);
    } else {
        level util::waittill_any("arena_challenge_ended", "electricity_challenge_ended");
    }
    var_21d644c animation::play(var_117d442a, undefined, undefined, 1);
    var_21d644c delete();
    var_44622ece.var_1771513c = 0;
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xca81b8bb, Offset: 0xb208
// Size: 0x138
function function_48791cb7() {
    level endon(#"hash_45115ebd");
    level endon(#"hash_57ad5f83");
    self notify(#"hash_48791cb7");
    self endon(#"hash_48791cb7");
    self endon(#"delete");
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        foreach (player in level.activeplayers) {
            if (isdefined(player) && distancesquared(player.origin, self.origin - (0, 0, 63)) < 6400) {
                level thread function_d1ced388(player);
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x5135ee07, Offset: 0xb348
// Size: 0x64
function function_d1ced388(player) {
    player dodamage(10, player.origin, undefined, undefined, undefined, "MOD_ELECTROCUTED", 0);
    /#
        iprintlnbold("int");
    #/
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xb144a05a, Offset: 0xb3b8
// Size: 0x4c
function function_4d79d831() {
    if (isdefined(self.var_f7726300)) {
        self connectpaths();
        self moveto(self.var_f7726300, 1);
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x7e73725a, Offset: 0xb410
// Size: 0x2e4
function function_27c3331e(var_50a530a1) {
    switch (var_50a530a1) {
    case 0:
        n_start_index = 0;
        break;
    case 1:
        n_start_index = 2;
        break;
    case 2:
        n_start_index = 4;
        break;
    case 3:
        n_start_index = 6;
        break;
    }
    s_start = struct::get("arena_shadow_column_" + n_start_index, "targetname");
    var_e728df08 = util::spawn_model("p7_zm_gen_shadow_q_pillar", s_start.origin + (0, 0, 896), s_start.angles);
    var_44febfef = util::spawn_model("p7_zm_gen_shadow_q_pillar_collision", var_e728df08.origin, var_e728df08.angles);
    var_44febfef enablelinkto();
    var_44febfef linkto(var_e728df08);
    var_e728df08 moveto(s_start.origin, 3);
    var_e728df08 playsound("zmb_bossrush_shadow_pillar_lower");
    wait(3);
    var_e728df08 thread function_61e62395(n_start_index);
    var_e728df08 clientfield::set("arena_shadow_pillar", 1);
    var_e728df08 thread function_a7750926();
    level util::waittill_any("arena_challenge_ended", "shadow_challenge_ended");
    var_e728df08 clientfield::set("arena_shadow_pillar", 0);
    var_e728df08 moveto(var_e728df08.origin + (0, 0, 896), 3);
    var_e728df08 playsound("zmb_bossrush_shadow_pillar_rise");
    wait(3);
    var_e728df08 delete();
    var_44febfef delete();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x4a5e779b, Offset: 0xb700
// Size: 0x138
function function_a7750926() {
    level endon(#"hash_45115ebd");
    level endon(#"hash_29f84ef2");
    self notify(#"hash_a7750926");
    self endon(#"hash_a7750926");
    self endon(#"delete");
    players = arraycopy(level.activeplayers);
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        foreach (player in players) {
            if (distancesquared(player.origin, self.origin) < 6400) {
                level thread function_88cd4fe1(player);
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0xeca19622, Offset: 0xb840
// Size: 0x64
function function_88cd4fe1(player) {
    player dodamage(10, player.origin, undefined, undefined, undefined, "MOD_ELECTROCUTED", 0);
    /#
        iprintlnbold("int");
    #/
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x8f7e337d, Offset: 0xb8b0
// Size: 0x130
function function_61e62395(var_50a530a1) {
    level endon(#"hash_45115ebd");
    level endon(#"hash_29f84ef2");
    var_c951867e = var_50a530a1;
    while (true) {
        wait(3);
        var_c951867e += 1;
        if (var_c951867e > 7) {
            var_c951867e = 0;
        }
        s_next = struct::get("arena_shadow_column_" + var_c951867e, "targetname");
        self moveto(s_next.origin, 6);
        self playloopsound("zmb_bossrush_shadow_pillar_lp", 0.25);
        wait(6);
        self stoploopsound(0.25);
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0xa256e85c, Offset: 0xb9e8
// Size: 0xca
function function_320bc09(n_max, var_b1f69aca) {
    var_372e59c5 = [];
    for (i = 0; i < n_max; i++) {
        if (i != var_b1f69aca) {
            if (!isdefined(var_372e59c5)) {
                var_372e59c5 = [];
            } else if (!isarray(var_372e59c5)) {
                var_372e59c5 = array(var_372e59c5);
            }
            var_372e59c5[var_372e59c5.size] = i;
        }
    }
    return array::random(var_372e59c5);
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0xb7dd519a, Offset: 0xbac0
// Size: 0x250
function function_5a4ec2e2(var_87c8152d) {
    if (!isdefined(var_87c8152d)) {
        var_87c8152d = 0;
    }
    if (!isdefined(level.var_beccbadb)) {
        level.var_beccbadb = 0;
    }
    if (!isdefined(level.var_359cfe42)) {
        level.var_359cfe42 = 0;
    }
    a_s_loc = struct::get_array("arena_boss_spawnpoint", "targetname");
    if (isdefined(level.var_a0e9e53)) {
        arrayremovevalue(a_s_loc, level.var_a0e9e53);
    }
    s_loc = array::random(a_s_loc);
    level.var_a0e9e53 = s_loc;
    if (var_87c8152d == 2) {
        var_f4b1d057 = namespace_3de4ab6f::function_75b161ab(undefined, s_loc);
    } else if (var_87c8152d == 1) {
        var_f4b1d057 = namespace_3de4ab6f::function_26efbc37(undefined, s_loc);
    } else {
        var_f4b1d057 = namespace_ca5ef87d::function_8a0708c2(s_loc);
        var_f4b1d057 clientfield::set("arena_margwa_init", 1);
    }
    if (isdefined(var_f4b1d057)) {
        level.var_beccbadb += 1;
        level.var_359cfe42 += 1;
        level.var_95981590 = var_f4b1d057;
        level notify(#"hash_c484afcb");
        var_f4b1d057.b_ignore_cleanup = 1;
        var_f4b1d057.no_powerups = 1;
        n_health = level.round_number * 100 + 100;
        var_f4b1d057 namespace_c96301ee::function_53ce09a(n_health);
        var_f4b1d057 thread function_730e8210(var_87c8152d);
    }
    return var_f4b1d057;
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x6dea77d1, Offset: 0xbd18
// Size: 0x142
function function_2ed620e8(var_87c8152d) {
    if (!isdefined(var_87c8152d)) {
        var_87c8152d = 0;
    }
    a_s_loc = struct::get_array("arena_boss_spawnpoint", "targetname");
    s_loc = array::random(a_s_loc);
    var_f4b1d057 = namespace_ef567265::function_53c37648(s_loc, 0);
    if (isdefined(var_f4b1d057)) {
        level.var_435967f3 += 1;
        level.var_359cfe42 += 1;
        var_f4b1d057.no_powerups = 1;
        var_f4b1d057 thread function_ebe65636();
        util::wait_network_frame();
        var_f4b1d057.b_ignore_cleanup = 1;
        level notify(#"hash_b4c3cb33");
        var_f4b1d057 thread function_77127ffa(var_87c8152d);
        return var_f4b1d057;
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x832d0cc5, Offset: 0xbe68
// Size: 0x15c
function function_730e8210(var_87c8152d) {
    self waittill(#"death");
    level.var_de72c885 += 1;
    level.var_beccbadb -= 1;
    level.var_359cfe42 -= 1;
    if (level flag::get("boss_fight")) {
        return;
    }
    if (level flag::get("final_boss_started")) {
        return;
    }
    if (level.var_de72c885 == level.var_c4133b63) {
        if (level flag::get("boss_rush_phase_1")) {
            level notify(#"hash_45115ebd");
            func_cleanup = level.var_5afa678d[var_87c8152d];
            level [[ func_cleanup ]]();
            level notify(#"hash_e59686ee");
            return;
        }
        if (level flag::get("boss_rush_phase_2")) {
            level notify(#"hash_7ea88c9e");
            return;
        }
        level thread function_c2578b2a();
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x62b1eebd, Offset: 0xbfd0
// Size: 0x74
function function_77127ffa(var_87c8152d) {
    self waittill(#"death");
    level.var_278e37cd += 1;
    if (level flag::get("final_boss_started")) {
        return;
    }
    if (level.var_278e37cd == level.var_90280eb8) {
        function_c2578b2a();
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x115ec09e, Offset: 0xc050
// Size: 0x284
function function_c2578b2a() {
    if (level flag::get("boss_fight")) {
        return;
    }
    var_87c8152d = level clientfield::get("circle_challenge_identity");
    level notify(#"hash_45115ebd");
    thread [[ level.var_d90687be ]]->function_b4aac082();
    if (level flag::get("custom_challenge")) {
        function_c5938cab(0);
        level flag::clear("custom_challenge");
    } else {
        func_cleanup = level.var_5afa678d[var_87c8152d];
        level thread [[ func_cleanup ]]();
    }
    /#
        iprintlnbold("int");
    #/
    level flag::set("arena_challenge_complete_" + var_87c8152d);
    if (level flag::get("devgui_end_challenge")) {
        /#
            iprintlnbold("int");
        #/
        level clientfield::set("arena_state", 1);
        level clientfield::set("circle_state", 4);
        wait(3);
        level clientfield::set("circle_state", 2);
        thread [[ level.var_d90687be ]]->function_32374471();
        level flag::clear("devgui_end_challenge");
        return;
    }
    if (!level flag::get("final_boss_defeated")) {
        wait(7);
        level clientfield::set("arena_state", 3);
        thread [[ level.var_d90687be ]]->function_32374471();
        level util::waittill_any("arena_picked_up_reward", "arena_shutdown_thread");
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xb254c38c, Offset: 0xc2e0
// Size: 0xe4
function function_ae8e44d6() {
    level.var_eb7b7914 = 0;
    level.var_a0135c54 = 6;
    level notify(#"hash_f115a4c8");
    level clientfield::set("arena_state", 4);
    level clientfield::set("circle_state", 0);
    level clientfield::set("summoning_key_pickup", 1);
    wait(5);
    level thread function_ac440107();
    level flag::wait_till("book_runes_success");
    level notify(#"hash_45115ebd");
    thread [[ level.var_d90687be ]]->function_b4aac082();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x9be1b2d6, Offset: 0xc3d0
// Size: 0xba
function function_ac440107() {
    level endon(#"hash_ca02f3d4");
    while (!level flag::get("book_runes_success")) {
        level flag::wait_till("arena_occupied_by_player");
        thread [[ level.var_d90687be ]]->function_a1c7821d(0, 10);
        level thread function_d9624751();
        level flag::wait_till_clear("arena_occupied_by_player");
        level notify(#"hash_d9624751");
        level notify(#"hash_6d73b616");
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xb9155383, Offset: 0xc498
// Size: 0x2c
function function_32419cfe() {
    level endon(#"hash_6760e3ae");
    wait(14);
    level thread function_39df21f9();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x14f5b099, Offset: 0xc4d0
// Size: 0x34
function function_e3fb6380() {
    level endon(#"hash_6760e3ae");
    wait(14 * 4.4);
    level thread function_39df21f9();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xb39acaaf, Offset: 0xc510
// Size: 0xf4
function function_b1b0d2b0() {
    var_78a22131 = struct::get("arena_shadowman_stage_center", "targetname");
    var_78a22131 namespace_553efdc::function_8888a532(0, 1, 1);
    var_78a22131 notify(#"hash_42d111a0");
    mdl_shield = spawn("script_model", var_78a22131.var_94d7beef.origin);
    mdl_shield setmodel("p7_zm_gen_margwa_orb_red");
    mdl_shield linkto(var_78a22131.var_94d7beef);
    mdl_shield notsolid();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x65090709, Offset: 0xc610
// Size: 0x47a
function function_655271b9() {
    level notify(#"hash_f115a4c8");
    var_6400c095 = array(6, 8, 10, 12);
    var_3e836e2f = array(4, 5, 6, 8);
    level.var_beccbadb = 0;
    level.var_c4133b63 = 2;
    level.var_de72c885 = 0;
    level.var_a0135c54 = var_3e836e2f[0];
    level.var_435967f3 = 0;
    level.var_e10b491b = 1;
    level.var_359cfe42 = 0;
    level.var_b9b689ce = 3;
    level.var_8e402c12 = var_6400c095[0];
    var_c6fda37e = struct::get_array("dark_arena_teleport_hijack", "targetname");
    for (i = 0; i < level.activeplayers.size; i++) {
        level.activeplayers[i] thread function_56668973(var_c6fda37e[i]);
    }
    level thread namespace_42091091::function_936d084f();
    level thread function_7719ec7(4);
    wait(4);
    level flag::set("boss_rush_phase_1");
    level notify(#"hash_f115a4c8");
    level thread function_389f8efe();
    for (i = 0; i < level.var_6000c357.size; i++) {
        clientfield::set("summoning_key_charge_state", i);
        level flag::set("arena_vanilla_zombie_override");
        if (i > 0) {
            level thread function_7719ec7(15);
            wait(15);
        }
        level thread function_7b82ff07(6);
        var_6c0518cd = level.var_6000c357[i];
        level.var_8e402c12 = var_6400c095[i];
        level.var_a0135c54 = var_3e836e2f[i];
        level clientfield::set("circle_challenge_identity", var_6c0518cd);
        level clientfield::set("arena_state", 2);
        level clientfield::set("circle_state", 3);
        level flag::clear("arena_vanilla_zombie_override");
        var_cecde52d = level.var_43e34f20[var_6c0518cd];
        level thread [[ var_cecde52d ]](var_6c0518cd, 0, 0, 1);
        level thread function_d9624751();
        level waittill(#"hash_e59686ee");
        playsoundatposition("zmb_bossrush_round_over", (0, 0, 0));
        thread [[ level.var_d90687be ]]->function_b4aac082();
        level thread function_7b82ff07(6);
    }
    wait(1);
    thread [[ level.var_d90687be ]]->function_b4aac082();
    level thread namespace_42091091::function_d73dcf42();
    wait(3);
    playsoundatposition("zmb_main_completion_big", (0, 0, 0));
    /#
        iprintlnbold("int");
    #/
    level flag::clear("boss_rush_phase_1");
    level notify(#"hash_7af29ab");
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0xe8ab08ca, Offset: 0xca98
// Size: 0x4c
function function_7719ec7(time) {
    level endon(#"hash_675baa5d");
    level endon(#"hash_1ec5d376");
    wait(time - 1.9);
    playsoundatposition("zmb_bossrush_element_start", (0, 0, 0));
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x7eb7bf09, Offset: 0xcaf0
// Size: 0xac
function function_389f8efe() {
    var_2c8e8252 = struct::get("arena_powerup_point", "targetname");
    powerup = level thread zm_powerups::specific_powerup_drop("full_ammo", var_2c8e8252.origin, undefined, undefined, undefined, undefined, 1);
    level flag::wait_till_clear("test_activate_arena");
    if (isdefined(powerup)) {
        powerup thread zm_powerups::powerup_delete();
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x639fb071, Offset: 0xcba8
// Size: 0x110
function function_d9624751() {
    level notify(#"hash_d9624751");
    level endon(#"hash_d9624751");
    level endon(#"hash_e59686ee");
    if (!isdefined(level.var_eb7b7914)) {
        level.var_eb7b7914 = 0;
    }
    while (true) {
        if (level.var_eb7b7914 < level.var_a0135c54) {
            var_ea9e640b = randomintrange(0, 8);
            s_spawnpoint = struct::get("arena_fury_" + var_ea9e640b, "targetname");
            level thread function_e6146239(s_spawnpoint, 1);
            wait(3);
            continue;
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0xb423e743, Offset: 0xccc0
// Size: 0x3ec
function function_56668973(s_goto) {
    if (distancesquared(self.origin, s_goto.origin) < 589824) {
        return;
    }
    self thread lui::screen_flash(0.1, 0.5, 0.5, 1, "white");
    var_daad3c3c = (0, 0, 49);
    var_6b55b1c4 = (0, 0, 20);
    var_3abe10e2 = (0, 0, 0);
    self disableoffhandweapons();
    self disableweapons();
    if (self getstance() == "prone") {
        var_e2a6e15f = s_goto.origin + var_daad3c3c;
    } else if (self getstance() == "crouch") {
        var_e2a6e15f = s_goto.origin + var_6b55b1c4;
    } else {
        var_e2a6e15f = s_goto.origin + var_3abe10e2;
    }
    self.var_601ebf01 = util::spawn_model("tag_origin", self.origin, self.angles);
    self linkto(self.var_601ebf01);
    self dontinterpolate();
    self.var_601ebf01 dontinterpolate();
    self.var_601ebf01.origin = var_e2a6e15f;
    self.var_601ebf01.angles = s_goto.angles;
    self freezecontrols(1);
    util::wait_network_frame();
    if (isdefined(self)) {
        self.var_601ebf01.angles = s_goto.angles;
    }
    wait(0.5);
    self unlink();
    if (positionwouldtelefrag(s_goto.origin)) {
        self setorigin(s_goto.origin + (randomfloatrange(-16, 16), randomfloatrange(-16, 16), 0));
    } else {
        self setorigin(s_goto.origin);
    }
    self setplayerangles(s_goto.angles);
    self enableweapons();
    self enableoffhandweapons();
    self freezecontrols(0);
    self.var_601ebf01 delete();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x519045e1, Offset: 0xd0b8
// Size: 0xee
function function_63b428de() {
    level flag::set("boss_rush_phase_2");
    level.var_beccbadb = 0;
    level.var_de72c885 = 0;
    level.var_c4133b63 = 4;
    level thread function_292fd4ff();
    level thread function_aa6f9476();
    level waittill(#"hash_7ea88c9e");
    level notify(#"hash_45115ebd");
    func_cleanup = level.var_5afa678d[level.var_cbc0c05a];
    level [[ func_cleanup ]]();
    /#
        iprintlnbold("int");
    #/
    wait(2);
    level notify(#"hash_7af29ab");
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xddd75668, Offset: 0xd1b0
// Size: 0x1ee
function function_aa6f9476() {
    level endon(#"hash_7ea88c9e");
    while (true) {
        var_cecde52d = level.var_43e34f20[0];
        level thread [[ var_cecde52d ]](0, 0, 1, 0);
        level.var_cbc0c05a = 0;
        wait(30);
        level notify(#"hash_45115ebd");
        func_cleanup = level.var_5afa678d[0];
        level [[ func_cleanup ]]();
        wait(1);
        var_cecde52d = level.var_43e34f20[3];
        level thread [[ var_cecde52d ]](3, 0, 1, 0);
        level.var_cbc0c05a = 3;
        wait(30);
        level notify(#"hash_45115ebd");
        func_cleanup = level.var_5afa678d[3];
        level [[ func_cleanup ]]();
        wait(1);
        var_cecde52d = level.var_43e34f20[2];
        level thread [[ var_cecde52d ]](2, 0, 1, 0);
        level.var_cbc0c05a = 2;
        wait(30);
        level notify(#"hash_45115ebd");
        func_cleanup = level.var_5afa678d[2];
        level [[ func_cleanup ]]();
        wait(1);
        var_cecde52d = level.var_43e34f20[1];
        level thread [[ var_cecde52d ]](1, 0, 1, 0);
        level.var_cbc0c05a = 1;
        wait(30);
        level notify(#"hash_45115ebd");
        func_cleanup = level.var_5afa678d[1];
        level [[ func_cleanup ]]();
        wait(1);
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x32f2a21c, Offset: 0xd3a8
// Size: 0xf6
function function_292fd4ff() {
    var_2da522a2 = [];
    level endon(#"hash_7ea88c9e");
    while (level.var_beccbadb < 4) {
        var_2da522a2 = array::remove_dead(var_2da522a2, 0);
        var_cee51300 = level.var_beccbadb - level.var_de72c885;
        if (var_cee51300 < 4) {
            ai = function_5a4ec2e2();
            array::add(var_2da522a2, ai, 0);
        } else {
            while (var_cee51300 >= 4) {
                var_cee51300 = level.var_beccbadb - level.var_de72c885;
                wait(0.5);
            }
        }
        wait(5);
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0xfaf90706, Offset: 0xd4a8
// Size: 0xa4
function function_e6146239(s_spawnpoint, var_cbc1f143) {
    if (!isdefined(var_cbc1f143)) {
        var_cbc1f143 = 0;
    }
    v_origin = s_spawnpoint.origin;
    v_angles = s_spawnpoint.angles;
    if (!isdefined(v_angles)) {
        v_angles = (0, 0, 0);
    }
    if (var_cbc1f143) {
        namespace_484ba32a::function_1f0a0b52(v_origin);
    }
    function_439458e5(v_origin, v_angles);
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0x6b30694d, Offset: 0xd558
// Size: 0x20c
function function_439458e5(v_origin, v_angles) {
    var_ecb2c615 = spawnactor("spawner_zm_genesis_apothicon_fury", v_origin, v_angles, undefined, 1, 1);
    if (!isdefined(var_ecb2c615)) {
        return;
    }
    var_ecb2c615.spawn_time = gettime();
    var_ecb2c615.no_powerups = 1;
    var_ecb2c615.exclude_cleanup_adding_to_total = 1;
    var_ecb2c615.no_damage_points = 1;
    var_ecb2c615.deathpoints_already_given = 1;
    level.var_eb7b7914 += 1;
    var_ecb2c615 thread function_d0ff3ef8();
    var_ecb2c615 thread zm::update_zone_name();
    if (isdefined(var_ecb2c615)) {
        var_ecb2c615 endon(#"death");
        level thread namespace_484ba32a::function_6cc52664(var_ecb2c615.origin);
        var_ecb2c615.voiceprefix = "fury";
        var_ecb2c615.animname = "fury";
        var_ecb2c615 thread zm_spawner::play_ambient_zombie_vocals();
        var_ecb2c615 thread zm_audio::zmbaivox_notifyconvert();
        var_ecb2c615 playsound("zmb_vocals_fury_spawn");
        var_ecb2c615.health = level.zombie_health;
        var_ecb2c615.heroweapon_kill_power = 2;
        wait(1);
        var_ecb2c615.zombie_think_done = 1;
        var_ecb2c615 ai::set_behavior_attribute("move_speed", "sprint");
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x8531aa17, Offset: 0xd770
// Size: 0x24
function function_d0ff3ef8() {
    self waittill(#"death");
    level.var_eb7b7914 -= 1;
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x0
// Checksum 0x928f6e8e, Offset: 0xd7a0
// Size: 0x84
function function_ec36b14b(n_challenge_index) {
    level.var_beccbadb = 0;
    level.var_de72c885 = 0;
    level clientfield::set("circle_challenge_identity", n_challenge_index);
    var_cecde52d = level.var_43e34f20[n_challenge_index];
    level thread [[ var_cecde52d ]](n_challenge_index, 0, 0, 1);
    level waittill(#"hash_e59686ee");
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0xc91e564c, Offset: 0xd830
// Size: 0x140
function function_11a85c29(var_e5cba04c) {
    if (!isdefined(var_e5cba04c)) {
        var_e5cba04c = 0;
    }
    if (var_e5cba04c) {
        var_c6fda37e = struct::get_array("dark_arena_teleport_hijack", "targetname");
        for (i = 0; i < level.activeplayers.size; i++) {
            level.activeplayers[i] thread function_56668973(var_c6fda37e[i]);
        }
        wait(1);
        level notify(#"hash_f115a4c8");
    }
    exploder::exploder("fxexp_089");
    playsoundatposition("zmb_summoning_key_ball_spawn", (-828, -8546, -3760));
    level clientfield::set("summoning_key_pickup", 2);
    wait(3);
    level thread function_8780614b();
    level waittill(#"hash_f81a82d1");
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xc2fcc135, Offset: 0xd978
// Size: 0x1d2
function function_8780614b() {
    n_width = -128;
    n_height = -128;
    n_length = -128;
    s_loc = struct::get("arena_reward_pickup", "targetname");
    s_loc.unitrigger_stub = spawnstruct();
    s_loc.unitrigger_stub.origin = s_loc.origin;
    s_loc.unitrigger_stub.angles = s_loc.angles;
    s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_loc.unitrigger_stub.script_width = n_width;
    s_loc.unitrigger_stub.script_height = n_height;
    s_loc.unitrigger_stub.script_length = n_length;
    s_loc.unitrigger_stub.require_look_at = 0;
    s_loc.unitrigger_stub.prompt_and_visibility_func = &function_60c0ecd3;
    zm_unitrigger::register_static_unitrigger(s_loc.unitrigger_stub, &function_9307f775);
    return s_loc.unitrigger_stub;
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0xd4739deb, Offset: 0xdb58
// Size: 0x86
function function_60c0ecd3(player) {
    var_141c477d = level clientfield::get("summoning_key_pickup");
    if (var_141c477d == 2) {
        self sethintstring("");
        return true;
    }
    self sethintstring("");
    return false;
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x32dcf5df, Offset: 0xdbe8
// Size: 0xda
function function_9307f775() {
    while (true) {
        e_triggerer = self waittill(#"trigger");
        if (e_triggerer zm_utility::in_revive_trigger()) {
            continue;
        }
        if (!zm_utility::is_player_valid(e_triggerer, 1, 1)) {
            continue;
        }
        var_141c477d = level clientfield::get("summoning_key_pickup");
        if (var_141c477d != 2) {
            continue;
        }
        function_1aa64a8(e_triggerer);
        level thread namespace_c149ef1::function_47713f03(e_triggerer);
        return;
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x733fe8b, Offset: 0xdcd0
// Size: 0x7a
function function_1aa64a8(e_triggerer) {
    level clientfield::set("summoning_key_pickup", 0);
    playsoundatposition("zmb_summoning_ball_pickup", e_triggerer.origin);
    ball::function_5faeea5e(e_triggerer);
    level notify(#"hash_f81a82d1");
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x40d605f7, Offset: 0xdd58
// Size: 0x4b4
function function_386f30f4() {
    if (level flag::get("final_boss_started")) {
        return;
    }
    level thread namespace_c149ef1::function_5f2a1c13();
    level flag::set("book_runes_success");
    level flag::set("final_boss_started");
    level thread namespace_42091091::function_e9341208();
    level notify(#"hash_b7da93ea");
    level notify(#"hash_f115a4c8");
    level notify(#"hash_fa713eaf");
    level clientfield::set("arena_state", 4);
    level clientfield::set("circle_state", 0);
    level clientfield::set("sophia_state", 1);
    level.var_beccbadb = 0;
    level.var_de72c885 = 0;
    level.var_c4133b63 = 2;
    level.var_42ec150d = 1;
    level.var_435967f3 = 0;
    level.var_278e37cd = 0;
    level.var_e10b491b = 2;
    level.var_2fe260b8 = 1;
    level.var_eb7b7914 = 0;
    level.var_a0135c54 = 4;
    level.var_359cfe42 = 0;
    level.var_b9b689ce = 3;
    level.var_338630d6 = 0;
    level.var_dba75e2a = 6;
    level.var_68377af0 = [];
    for (i = 0; i <= 12; i++) {
        level.var_d7e8c63e[i] = struct::get("boss_shadowman_4_" + i, "targetname");
    }
    for (i = 0; i < 12; i++) {
        n_index = randomint(12);
        s_temp = level.var_d7e8c63e[n_index];
        level.var_d7e8c63e[n_index] = level.var_d7e8c63e[i];
        level.var_d7e8c63e[i] = s_temp;
    }
    if (!isdefined(level.var_5d85ddf7)) {
        level.var_5d85ddf7 = [];
    }
    s_loc = struct::get("boss_shadowman_4");
    level.var_5b08e991 = util::spawn_model("c_zom_dlc4_shadowman_fb", s_loc.origin, s_loc.angles);
    level.var_5b08e991 useanimtree(#zm_genesis);
    level.var_5b08e991 clientfield::set("shadowman_fx", 1);
    level.var_5b08e991 playsound("zmb_shadowman_tele_in");
    level.var_5b08e991.health = 1000000;
    level.var_5b08e991 thread animation::play("ai_zm_dlc4_shadowman_idle");
    level.var_5b08e991 setcandamage(1);
    level.var_5b08e991 clientfield::set("boss_clone_fx", 2);
    level.var_5b08e991 thread function_47c38473();
    function_a295f22c();
    level thread function_fcac048f();
    level thread function_444d6737();
    thread [[ level.var_d90687be ]]->function_a1c7821d(0);
    level thread function_5c0b3137();
    level thread function_f71c240d();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xb31d7665, Offset: 0xe218
// Size: 0x3c
function function_fcac048f() {
    level.var_74f93a5e = 0;
    function_9faf5035();
    level thread function_ae6bd0ce();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x30a7cbcc, Offset: 0xe260
// Size: 0x25e
function function_ae6bd0ce() {
    level notify(#"hash_ae6bd0ce");
    level endon(#"hash_ae6bd0ce");
    level endon(#"hash_1ec5d376");
    var_7de627cf = 5;
    var_97562c6c = 30;
    var_84b1a277 = array(0, 1, 2, 3);
    var_84b1a277 = array::randomize(var_84b1a277);
    while (!level flag::get("final_boss_defeated")) {
        if (level flag::get("final_boss_vulnerable")) {
            flag::wait_till_clear("final_boss_vulnerable");
            continue;
        }
        level.var_5b08e991 function_1a4e2d94(var_7de627cf, undefined);
        if (level flag::get("final_boss_vulnerable")) {
            flag::wait_till_clear("final_boss_vulnerable");
            continue;
        }
        var_e7d6a3ca = var_84b1a277[level.var_74f93a5e];
        level.var_74f93a5e += 1;
        if (level.var_74f93a5e > var_84b1a277.size) {
            level.var_74f93a5e = 0;
            var_84b1a277 = array::randomize(var_84b1a277);
            var_e7d6a3ca = var_84b1a277[level.var_74f93a5e];
            if (var_84b1a277[0] == var_e7d6a3ca) {
                var_84b1a277 = array::reverse(var_84b1a277);
            }
            function_9faf5035();
        }
        function_60c23a57(var_e7d6a3ca);
        level util::waittill_any_timeout(var_97562c6c, "final_boss_defeated", "final_boss_shadowman_attack_thread");
        function_2de2733c();
        wait(15);
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xd234f6a8, Offset: 0xe4c8
// Size: 0x5a
function function_9faf5035() {
    thread [[ level.var_d90687be ]]->function_a1c7821d(0);
    thread [[ level.var_d90687be ]]->function_e4dbca5a(0);
    if (level.var_435967f3 < level.var_e10b491b) {
        function_2ed620e8(0);
    }
    wait(45);
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x6b514851, Offset: 0xe530
// Size: 0xe2
function function_7b82ff07(var_b35c2422) {
    level notify(#"hash_7b82ff07");
    level endon(#"hash_7b82ff07");
    players = arraycopy(level.activeplayers);
    foreach (player in players) {
        if (isdefined(player)) {
            player clientfield::set_to_player("player_rumble_and_shake", var_b35c2422);
        }
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0xd412c431, Offset: 0xe620
// Size: 0x2fc
function function_1a4e2d94(var_572b6f62, var_8fc8c481) {
    if (!isdefined(var_8fc8c481)) {
        var_8fc8c481 = 1;
    }
    level endon(#"hash_675baa5d");
    level endon(#"hash_1ec5d376");
    self animation::stop();
    level thread function_7b82ff07(5);
    self clientfield::set("shadowman_fx", 3);
    self playsound("zmb_shadowman_spell_start");
    self playloopsound("zmb_shadowman_spell_loop", 0.75);
    self clearanim("ai_zm_dlc4_shadowman_idle", 0);
    self animation::play("ai_zm_dlc4_shadowman_attack_aoe_charge_intro", undefined, undefined, var_8fc8c481);
    self animation::stop();
    self clientfield::set("shadowman_fx", 4);
    self clearanim("ai_zm_dlc4_shadowman_attack_aoe_charge_intro", 0);
    self thread animation::play("ai_zm_dlc4_shadowman_attack_aoe_charge_loop", undefined, undefined, var_8fc8c481);
    wait(var_572b6f62);
    level thread function_7719ec7(2.6);
    level thread function_7b82ff07(6);
    self animation::stop();
    self clientfield::set("shadowman_fx", 5);
    self stoploopsound(0.1);
    self playsound("zmb_shadowman_spell_cast");
    self clearanim("ai_zm_dlc4_shadowman_attack_aoe_charge_loop", 0);
    self animation::play("ai_zm_dlc4_shadowman_attack_aoe_charge_deploy", undefined, undefined, var_8fc8c481);
    self clientfield::set("shadowman_fx", 6);
    self clearanim("ai_zm_dlc4_shadowman_attack_aoe_charge_deploy", 0);
    self thread animation::play("ai_zm_dlc4_shadowman_idle", undefined, undefined, var_8fc8c481);
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xf4ba34e, Offset: 0xe928
// Size: 0x358
function function_47c38473() {
    level notify(#"hash_47c38473");
    level endon(#"hash_47c38473");
    level endon(#"hash_1ec5d376");
    level.var_3ba63921 = 0;
    var_90530d3 = 0;
    while (true) {
        self.health = 1000000;
        amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon = self waittill(#"damage");
        if (!level flag::get("final_boss_vulnerable")) {
            continue;
        }
        if (isplayer(attacker)) {
            attacker show_hit_marker();
        }
        playfx(level._effect["shadowman_impact_fx"], point);
        var_90530d3 += amount;
        n_player_count = level.activeplayers.size;
        var_d6a1b83c = 0.5 + 0.5 * (n_player_count - 1) / 3;
        var_9bd75db5 = 2000 * var_d6a1b83c;
        if (var_90530d3 >= var_9bd75db5) {
            function_2de2733c();
            var_90530d3 = 0;
            level.var_3ba63921 += randomintrange(1, 3);
            if (level flag::get("hope_done")) {
                level.var_3ba63921++;
            }
            if (level.var_3ba63921 >= 11) {
                level thread namespace_42091091::function_ecd49d9c();
            }
            if (level.var_3ba63921 >= 12) {
                level.var_3ba63921 = 12;
                if (level flag::get("hope_done")) {
                    level.var_5b08e991 clientfield::set("hope_spark", 1);
                }
                level flag::set("final_boss_at_deaths_door");
            }
            self function_284b1884(level.var_d7e8c63e[level.var_3ba63921], 0.1);
            level.var_5b08e991 clientfield::set("boss_clone_fx", 1);
            level.var_5b08e991 thread function_d3b47fbf();
        }
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xd92570fe, Offset: 0xec88
// Size: 0x74
function function_d3b47fbf() {
    level endon(#"hash_258c9a94");
    level endon(#"hash_3e95c772");
    self animation::play("ai_zm_dlc4_shadowman_captured_intro", undefined, undefined, 1);
    if (isdefined(self)) {
        self thread animation::play("ai_zm_dlc4_shadowman_captured_loop", undefined, undefined, 1);
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xc935ac8a, Offset: 0xed08
// Size: 0x88
function show_hit_marker() {
    if (isdefined(self) && isdefined(self.hud_damagefeedback)) {
        self.hud_damagefeedback setshader("damage_feedback", 24, 48);
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x2550a48, Offset: 0xed98
// Size: 0x22c
function function_1c231424() {
    level endon(#"hash_1ec5d376");
    if (!isdefined(level.var_3dc17f7b)) {
        level.var_3dc17f7b = 1;
    } else {
        level.var_3dc17f7b += 1;
        if (level.var_3dc17f7b % 4 == 0) {
            level thread function_45ea8994();
        }
    }
    level.var_5b08e991 clientfield::set("boss_clone_fx", 1);
    level flag::set("final_boss_vulnerable");
    level thread function_7b82ff07(6);
    level thread function_6de6b768();
    wait(10 + level.var_3dc17f7b * 5);
    if (level flag::get("hope_done") && level.var_3ba63921 >= 12) {
        wait(15);
        level.var_5b08e991 clientfield::set("hope_spark", 0);
    }
    level.var_5b08e991 clientfield::set("boss_clone_fx", 2);
    level flag::clear("final_boss_vulnerable");
    var_a8869736 = struct::get("boss_shadowman_4", "targetname");
    level.var_5b08e991 function_284b1884(var_a8869736, 0.1);
    level flag::clear("final_boss_at_deaths_door");
    level.var_3ba63921 = 0;
    function_a295f22c();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x49ba4caa, Offset: 0xefd0
// Size: 0xc4
function function_6de6b768() {
    if (isdefined(level.var_7ec1d3f3)) {
        return;
    }
    var_2c8e8252 = struct::get("arena_powerup_point", "targetname");
    level.var_7ec1d3f3 = level thread zm_powerups::specific_powerup_drop("full_ammo", var_2c8e8252.origin, undefined, undefined, undefined, undefined, 1);
    level flag::wait_till_clear("test_activate_arena");
    if (isdefined(level.var_7ec1d3f3)) {
        level.var_7ec1d3f3 thread zm_powerups::powerup_delete();
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xb8e228eb, Offset: 0xf0a0
// Size: 0x340
function function_a295f22c() {
    level endon(#"hash_1ec5d376");
    level.var_5b08e991 clearanim("ai_zm_dlc4_shadowman_idle", 0);
    level.var_5b08e991 animation::play("ai_zm_dlc4_shadowman_attack_aoe_charge_intro", undefined, undefined, 1);
    level.var_5b08e991 animation::stop();
    level thread function_7b82ff07(5);
    level.var_5b08e991 clientfield::set("shadowman_fx", 4);
    level.var_5b08e991 clearanim("ai_zm_dlc4_shadowman_attack_aoe_charge_intro", 0);
    level.var_5b08e991 thread animation::play("ai_zm_dlc4_shadowman_attack_aoe_charge_loop", undefined, undefined, 1);
    wait(1);
    level.var_5b08e991 animation::stop();
    level.var_5b08e991 clientfield::set("shadowman_fx", 5);
    level thread function_7b82ff07(6);
    level.var_5b08e991 stoploopsound(0.1);
    level.var_5b08e991 playsound("zmb_shadowman_spell_cast");
    level.var_5b08e991 clearanim("ai_zm_dlc4_shadowman_attack_aoe_charge_loop", 0);
    level.var_5b08e991 animation::play("ai_zm_dlc4_shadowman_attack_aoe_charge_deploy", undefined, undefined, 1);
    level.var_5b08e991 clientfield::set("shadowman_fx", 6);
    level.var_5b08e991 clearanim("ai_zm_dlc4_shadowman_attack_aoe_charge_deploy", 0);
    level.var_5b08e991 thread animation::play("ai_zm_dlc4_shadowman_idle", undefined, undefined, 1);
    level clientfield::set("sophia_state", 2);
    if (level.var_359cfe42 < level.var_b9b689ce) {
        var_bd2592aa = randomfloatrange(0, 1);
        if (var_bd2592aa < 0.25 && level.var_435967f3 < level.var_e10b491b) {
            function_47e5fca7();
        } else if (level.var_beccbadb < level.var_c4133b63) {
            function_67a2532f();
        }
    }
    thread [[ level.var_d90687be ]]->function_a1c7821d(0);
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x3a5301d6, Offset: 0xf3e8
// Size: 0xf8
function function_47e5fca7() {
    a_s_loc = struct::get_array("arena_boss_spawnpoint", "targetname");
    s_loc = array::random(a_s_loc);
    var_f4b1d057 = namespace_ef567265::function_53c37648(s_loc, 0);
    util::wait_network_frame();
    if (isdefined(var_f4b1d057)) {
        var_f4b1d057.b_ignore_cleanup = 1;
        level notify(#"hash_b4c3cb33");
        level.var_435967f3 += 1;
        level.var_359cfe42 += 1;
        var_f4b1d057 thread function_ebe65636();
    }
    return var_f4b1d057;
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x567ff075, Offset: 0xf4e8
// Size: 0x38
function function_ebe65636() {
    self waittill(#"death");
    level.var_435967f3 -= 1;
    level.var_359cfe42 -= 1;
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xe6501d96, Offset: 0xf528
// Size: 0x48
function function_67a2532f() {
    level.var_beccbadb += 1;
    level.var_359cfe42 += 1;
    ai = function_5a4ec2e2();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xc36301a9, Offset: 0xf578
// Size: 0x4e
function function_45ea8994() {
    for (i = 0; i < 4; i++) {
        level clientfield::set("basin_state_" + i, 1);
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0xbe71d62f, Offset: 0xf5d0
// Size: 0x13c
function function_284b1884(s_target, var_685eb707) {
    if (!isdefined(var_685eb707)) {
        var_685eb707 = 0.1;
    }
    self animation::stop();
    self clientfield::set("shadowman_fx", 2);
    self playsound("zmb_shadowman_tele_out");
    self hide();
    self.origin = s_target.origin;
    if (isdefined(s_target.angles)) {
        self.angles = s_target.angles;
    }
    wait(var_685eb707);
    self clientfield::set("shadowman_fx", 1);
    self playsound("zmb_shadowman_tele_in");
    self show();
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0xa3233bff, Offset: 0xf718
// Size: 0x84
function function_60c23a57(var_6c0518cd) {
    level clientfield::set("circle_challenge_identity", var_6c0518cd);
    var_cecde52d = level.var_43e34f20[var_6c0518cd];
    level thread [[ var_cecde52d ]](var_6c0518cd, 0, 1, 0);
    level.var_cbc0c05a = var_6c0518cd;
    thread [[ level.var_d90687be ]]->function_e4dbca5a(var_6c0518cd);
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xa9c77df8, Offset: 0xf7a8
// Size: 0x128
function function_5c0b3137() {
    level notify(#"hash_5c0b3137");
    level endon(#"hash_5c0b3137");
    level endon(#"hash_1ec5d376");
    if (!isdefined(level.var_eb7b7914)) {
        level.var_eb7b7914 = 0;
    }
    while (true) {
        if (level.var_eb7b7914 < level.var_a0135c54) {
            var_ea9e640b = randomintrange(0, 8);
            s_spawnpoint = struct::get("arena_fury_" + var_ea9e640b, "targetname");
            level thread function_e6146239(s_spawnpoint);
            wait(randomintrange(5, 8));
            continue;
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xa0f3ad3, Offset: 0xf8d8
// Size: 0x110
function function_f71c240d() {
    level notify(#"hash_f71c240d");
    level endon(#"hash_f71c240d");
    level endon(#"hash_1ec5d376");
    if (!isdefined(level.var_338630d6)) {
        level.var_338630d6 = 0;
    }
    while (true) {
        if (level.var_338630d6 < level.var_dba75e2a) {
            var_bac4e70 = randomintrange(0, 4);
            s_spawnpoint = struct::get("arena_keeper_" + var_bac4e70, "targetname");
            level thread function_ff611187(s_spawnpoint);
            wait(3);
            continue;
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x28a17729, Offset: 0xf9f0
// Size: 0x74
function function_ff611187(s_spawnpoint) {
    v_origin = s_spawnpoint.origin;
    v_angles = s_spawnpoint.angles;
    if (!isdefined(v_angles)) {
        v_angles = (0, 0, 0);
    }
    function_4888688f(v_origin, v_angles);
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0x39ebae74, Offset: 0xfa70
// Size: 0x1a8
function function_4888688f(v_origin, v_angles) {
    var_d88e6f5f = spawnactor("spawner_zm_genesis_keeper", v_origin, v_angles, undefined, 1, 1);
    if (isdefined(var_d88e6f5f)) {
        level.var_338630d6 += 1;
        var_d88e6f5f.spawn_time = gettime();
        var_d88e6f5f.var_b8385ee5 = 1;
        var_d88e6f5f.health = level.zombie_health;
        var_d88e6f5f.no_powerups = 1;
        var_d88e6f5f thread zm::update_zone_name();
        var_d88e6f5f thread function_83144009();
        level thread namespace_484ba32a::function_6cc52664(var_d88e6f5f.origin);
        var_d88e6f5f.voiceprefix = "keeper";
        var_d88e6f5f.animname = "keeper";
        var_d88e6f5f thread zm_spawner::play_ambient_zombie_vocals();
        var_d88e6f5f thread zm_audio::zmbaivox_notifyconvert();
        wait(1.3);
        var_d88e6f5f.zombie_think_done = 1;
        var_d88e6f5f.heroweapon_kill_power = 2;
        var_d88e6f5f thread zombie_utility::round_spawn_failsafe();
    }
    return var_d88e6f5f;
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xbc6ffb44, Offset: 0xfc20
// Size: 0x24
function function_83144009() {
    self waittill(#"death");
    level.var_338630d6 -= 1;
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x9c3f5153, Offset: 0xfc50
// Size: 0x7c
function function_2de2733c() {
    var_6c0518cd = level clientfield::get("circle_challenge_identity");
    level notify(#"hash_45115ebd");
    func_cleanup = level.var_5afa678d[var_6c0518cd];
    level [[ func_cleanup ]]();
    thread [[ level.var_d90687be ]]->function_a1c7821d(0);
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xf2aa786, Offset: 0xfcd8
// Size: 0x5e
function function_444d6737() {
    level thread function_205c3adf();
    for (i = 0; i < 4; i++) {
        level thread function_9c25c847(i);
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0xc3806b30, Offset: 0xfd40
// Size: 0x20c
function function_9c25c847(var_549b41ba) {
    n_width = -128;
    n_height = -128;
    n_length = -128;
    s_loc = struct::get("clientside_key_" + var_549b41ba, "targetname");
    level clientfield::set("basin_state_" + var_549b41ba, 1);
    s_loc.unitrigger_stub = spawnstruct();
    s_loc.unitrigger_stub.origin = s_loc.origin;
    s_loc.unitrigger_stub.angles = s_loc.angles;
    s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_loc.unitrigger_stub.script_width = n_width;
    s_loc.unitrigger_stub.script_height = n_height;
    s_loc.unitrigger_stub.script_length = n_length;
    s_loc.unitrigger_stub.require_look_at = 0;
    s_loc.unitrigger_stub.var_549b41ba = var_549b41ba;
    s_loc.unitrigger_stub.prompt_and_visibility_func = &function_5a68c25f;
    zm_unitrigger::register_static_unitrigger(s_loc.unitrigger_stub, &function_f20e5aa1);
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0xcef8b854, Offset: 0xff58
// Size: 0x11e
function function_5a68c25f(player) {
    if (level flag::get("final_boss_defeated")) {
        return false;
    }
    var_c386eb4d = level clientfield::get("basin_state_" + self.stub.var_549b41ba);
    if (var_c386eb4d == 1 && level.var_2fe260b8 == 1) {
        self sethintstring("");
        return true;
    } else if (var_c386eb4d == 4) {
        return false;
    } else if (var_c386eb4d == 3 && level.var_2fe260b8 == 0) {
        self sethintstring("");
        return true;
    }
    self sethintstring("");
    return false;
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xfe9780ed, Offset: 0x10080
// Size: 0x228
function function_f20e5aa1() {
    while (true) {
        e_triggerer = self waittill(#"trigger");
        if (e_triggerer zm_utility::in_revive_trigger()) {
            continue;
        }
        if (!zm_utility::is_player_valid(e_triggerer, 1, 1)) {
            continue;
        }
        var_c386eb4d = level clientfield::get("basin_state_" + self.stub.var_549b41ba);
        if (var_c386eb4d == 3) {
            level clientfield::set("basin_state_" + self.stub.var_549b41ba, 4);
            ball::function_5faeea5e(e_triggerer);
            e_triggerer playsound("zmb_finalfight_key_pickup");
            level.var_2fe260b8 = 2;
            level thread function_867f6495();
        } else if (var_c386eb4d == 1 && level.var_2fe260b8 == 1) {
            level clientfield::set("basin_state_" + self.stub.var_549b41ba, 2);
            level.var_2fe260b8 = 0;
            level.var_40ffc71d = 0;
            level thread function_4ea58c0(self.stub.var_549b41ba);
            level.var_a6e673dd = struct::get("clientside_key_" + self.stub.var_549b41ba, "targetname");
        }
        self.stub zm_unitrigger::run_visibility_function_for_all_triggers();
    }
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x2d1ccdde, Offset: 0x102b0
// Size: 0x70
function function_4ea58c0(var_549b41ba) {
    while (true) {
        if (level.var_40ffc71d >= 15) {
            level.var_a6e673dd = undefined;
            level clientfield::set("basin_state_" + var_549b41ba, 3);
            return;
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x113f5e6d, Offset: 0x10328
// Size: 0x248
function function_867f6495() {
    level notify(#"hash_867f6495");
    level endon(#"hash_867f6495");
    level endon(#"hash_1ec5d376");
    var_cb6acc3e = undefined;
    while (true) {
        e_ball = level.ball;
        var_d6ba68c5 = e_ball.visuals[0];
        var_766335a0 = var_d6ba68c5.origin;
        if (isdefined(e_ball.carrier)) {
            util::wait_network_frame();
            continue;
        } else if (isdefined(var_cb6acc3e) && var_766335a0 != var_cb6acc3e) {
            var_af8a18df = struct::get("boss_sophia_hover", "targetname");
            var_32769d76 = pointonsegmentnearesttopoint(var_766335a0, var_cb6acc3e, var_af8a18df.origin);
            var_bcf81f62 = var_32769d76 - var_af8a18df.origin;
            n_length = length(var_bcf81f62);
            if (n_length < -128) {
                level.ball thread ball::function_a41df27c();
                level thread namespace_c149ef1::function_8c5fea67(e_ball.lastcarrier);
                level clientfield::set("sophia_state", 3);
                level.var_2fe260b8 = 1;
                /#
                    iprintlnbold("int");
                #/
                level thread function_1c231424();
                return;
            }
        }
        var_cb6acc3e = var_766335a0;
        util::wait_network_frame();
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xc31e2fe2, Offset: 0x10578
// Size: 0x1d2
function function_205c3adf() {
    n_width = -96;
    n_height = -96;
    n_length = -96;
    s_loc = struct::get("ee_book_arena", "targetname");
    s_loc.unitrigger_stub = spawnstruct();
    s_loc.unitrigger_stub.origin = s_loc.origin;
    s_loc.unitrigger_stub.angles = s_loc.angles;
    s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_loc.unitrigger_stub.script_width = n_width;
    s_loc.unitrigger_stub.script_height = n_height;
    s_loc.unitrigger_stub.script_length = n_length;
    s_loc.unitrigger_stub.require_look_at = 0;
    s_loc.unitrigger_stub.prompt_and_visibility_func = &function_debdfa37;
    zm_unitrigger::register_static_unitrigger(s_loc.unitrigger_stub, &function_798c9ac9);
    return s_loc.unitrigger_stub;
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x16494f57, Offset: 0x10758
// Size: 0x74
function function_debdfa37(player) {
    if (level flag::get("final_boss_defeated")) {
        return false;
    }
    if (level flag::get("final_boss_at_deaths_door")) {
        self sethintstring("");
        return true;
    }
    return false;
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x162cff41, Offset: 0x107d8
// Size: 0xc2
function function_798c9ac9() {
    while (true) {
        e_triggerer = self waittill(#"trigger");
        if (e_triggerer zm_utility::in_revive_trigger()) {
            continue;
        }
        if (!zm_utility::is_player_valid(e_triggerer, 1, 1)) {
            continue;
        }
        if (level flag::get("final_boss_defeated")) {
            continue;
        }
        if (!level flag::get("final_boss_at_deaths_door")) {
            continue;
        }
        level thread function_ab0e7bbf();
        return;
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xce1401ee, Offset: 0x108a8
// Size: 0x264
function function_ab0e7bbf() {
    var_eb26d898 = level.var_5b08e991 clientfield::get("hope_spark");
    if (var_eb26d898) {
        level flag::set("special_win");
    }
    level flag::set("final_boss_defeated");
    level clientfield::set("boss_beam_state", 1);
    var_87c8152d = level clientfield::get("circle_challenge_identity");
    level notify(#"hash_45115ebd");
    func_cleanup = level.var_5afa678d[var_87c8152d];
    level thread [[ func_cleanup ]]();
    level flag::clear("spawn_zombies");
    level thread function_ab51bfd();
    playsoundatposition("zmb_finalfight_shadowman_die", level.var_5b08e991.origin);
    level thread namespace_c149ef1::function_dfd31c20();
    wait(3);
    level thread namespace_42091091::function_d73dcf42();
    playsoundatposition("zmb_shadowman_transition", (0, 0, 0));
    level lui::screen_fade_out(2, "white");
    level clientfield::set("boss_beam_state", 0);
    if (isdefined(level.var_5b08e991)) {
        level.var_5b08e991 delete();
    }
    wait(3);
    level thread lui::screen_fade_in(2.5, "white");
    function_7fd60b47();
    level flag::set("ending_room");
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xc8243fa6, Offset: 0x10b18
// Size: 0x368
function function_7fd60b47() {
    wait(2);
    foreach (player in level.players) {
        scoreevents::processscoreevent("main_EE_quest_genesis", player);
        player addplayerstat("DARKOPS_GENESIS_EE", 1);
    }
    wait(2);
    var_d028d3a8 = array("ZOD", "FACTORY", "CASTLE", "ISLAND", "STALINGRAD");
    var_ce48d9bb = [];
    foreach (player in level.players) {
        foreach (var_1493eda1 in var_d028d3a8) {
            var_dc163518 = player zm_stats::get_global_stat("DARKOPS_" + var_1493eda1 + "_SUPER_EE") > 0;
            if (var_dc163518) {
                var_ce48d9bb[var_1493eda1] = 1;
            }
        }
    }
    if (var_d028d3a8.size == var_ce48d9bb.size) {
        foreach (player in level.players) {
            var_f36c96f9 = player zm_stats::get_global_stat("DARKOPS_GENESIS_SUPER_EE") > 0;
            if (!var_f36c96f9) {
                player addplayerstat("DARKOPS_GENESIS_SUPER_EE", 1);
                player function_c35c1036();
            }
        }
    }
    wait(2);
    level notify(#"hash_91a3107");
    wait(2);
    if (function_43049e1e()) {
        level notify(#"hash_154abf47");
        wait(2);
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x4833e553, Offset: 0x10e88
// Size: 0x92
function function_78325935() {
    if (!isdefined(level.var_f0cbb403)) {
        rowcount = tablelookuprowcount("gamedata/tables/zm/zm_paragonRankTable.csv");
        lastrow = tablelookuprow("gamedata/tables/zm/zm_paragonRankTable.csv", rowcount - 1);
        level.var_f0cbb403 = int(lastrow[7]);
    }
    return level.var_f0cbb403;
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x445fa489, Offset: 0x10f28
// Size: 0x188
function function_c35c1036() {
    var_65bc96f9 = 1000000;
    var_b58b4125 = self zm_stats::get_global_stat("PLEVEL") == level.maxprestige;
    if (var_b58b4125) {
        var_4223990f = function_78325935();
        var_68756b4b = self zm_stats::get_global_stat("PARAGON_RANKXP");
    } else {
        var_4223990f = rank::getrankinfomaxxp(level.maxrank);
        var_68756b4b = self zm_stats::get_global_stat("RANKXP");
    }
    if (var_4223990f - var_68756b4b < 1000000 * level.xpscale) {
        var_65bc96f9 = var_4223990f - var_68756b4b;
        var_65bc96f9 *= 1 / level.xpscale;
    }
    self addrankxpvalue("main_ee_quest_all", int(var_65bc96f9));
    if (isdefined(level.scoreongiveplayerscore)) {
        [[ level.scoreongiveplayerscore ]]("main_ee_quest_all", self, undefined, undefined, undefined);
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x4d79c477, Offset: 0x110b8
// Size: 0x246
function function_43049e1e() {
    var_d028d3a8 = array("ZOD", "FACTORY", "CASTLE", "ISLAND", "STALINGRAD");
    var_61d59a5a = [];
    foreach (player in level.players) {
        foreach (var_1493eda1 in var_d028d3a8) {
            var_dc163518 = player zm_stats::get_global_stat("DARKOPS_" + var_1493eda1 + "_SUPER_EE") > 0;
            var_9d5e869 = isinarray(var_61d59a5a, var_1493eda1);
            if (var_dc163518 && !var_9d5e869) {
                if (!isdefined(var_61d59a5a)) {
                    var_61d59a5a = [];
                } else if (!isarray(var_61d59a5a)) {
                    var_61d59a5a = array(var_61d59a5a);
                }
                var_61d59a5a[var_61d59a5a.size] = var_1493eda1;
            }
        }
    }
    /#
        iprintlnbold("int" + var_61d59a5a.size + "int");
    #/
    if (var_61d59a5a.size == var_d028d3a8.size) {
        return true;
    }
    return false;
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xda661e28, Offset: 0x11308
// Size: 0x1b2
function function_ab51bfd() {
    a_ai_enemies = getaiteamarray("axis");
    foreach (ai in a_ai_enemies) {
        if (isalive(ai)) {
            ai.marked_for_death = 1;
            ai ai::set_ignoreall(1);
        }
        util::wait_network_frame();
    }
    foreach (ai in a_ai_enemies) {
        if (isalive(ai)) {
            ai dodamage(ai.health + 666, ai.origin);
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x0
// Checksum 0x41849198, Offset: 0x114c8
// Size: 0x1aa
function function_5c3f8f6b() {
    if (!isdefined(level.var_977b6d5b)) {
        return;
    }
    a_ai = level.var_977b6d5b;
    var_52ec51cb = [];
    foreach (ai in a_ai) {
        if (!isdefined(ai)) {
            continue;
        }
        if (isdefined(ai.marked_for_death) && ai.marked_for_death) {
            continue;
        }
        ai.marked_for_death = 1;
        ai.nuked = 1;
        var_52ec51cb[var_52ec51cb.size] = ai;
    }
    foreach (ai_nuked in var_52ec51cb) {
        if (!isdefined(ai_nuked)) {
            continue;
        }
        ai_nuked kill();
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x204ae52c, Offset: 0x11680
// Size: 0x3c
function function_c1402204() {
    level flag::init("rift_entrance_open");
    level thread function_4b9028e6();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xa20bb630, Offset: 0x116c8
// Size: 0x110
function function_4b9028e6() {
    level endon(#"hash_15617ebe");
    level.var_b1b99f8d = [];
    level waittill(#"hash_5eb88f4a");
    var_c0132a00 = getent("rift_entrance_rune_portal", "targetname");
    while (true) {
        if (function_64d5ef9() && level.var_b1b99f8d.size >= 4) {
            var_12e29d53 = array::get_all_closest(var_c0132a00.origin, level.activeplayers, undefined, undefined, 84);
            if (var_12e29d53.size == level.activeplayers.size) {
                level flag::set("rift_entrance_open");
                function_ceedfe1c();
            }
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xde3a3331, Offset: 0x117e0
// Size: 0x2a4
function function_ceedfe1c() {
    var_71abf438 = [];
    for (i = 0; i < 4; i++) {
        s_point = struct::get("arena_entrance_point_" + i, "targetname");
        if (!isdefined(var_71abf438)) {
            var_71abf438 = [];
        } else if (!isarray(var_71abf438)) {
            var_71abf438 = array(var_71abf438);
        }
        var_71abf438[var_71abf438.size] = s_point;
    }
    namespace_cb655c88::function_342295d8("dark_arena2_zone");
    namespace_cb655c88::function_342295d8("dark_arena_zone");
    a_players = arraycopy(level.activeplayers);
    foreach (player in a_players) {
        if (isdefined(player.b_teleporting) && player.b_teleporting) {
            continue;
        }
        if (isplayer(player)) {
            player setstance("stand");
            playfx(level._effect["portal_3p"], player.origin);
            player playlocalsound("zmb_teleporter_teleport_2d");
            playsoundatposition("zmb_teleporter_teleport_out", player.origin);
            self thread function_14c1c18d(player, var_71abf438, 3);
        }
    }
    wait(3);
    level thread function_32419cfe();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0xe7c031d2, Offset: 0x11a90
// Size: 0x64
function function_64d5ef9() {
    return !level flag::get("book_runes_in_progress") && !level flag::get("book_runes_failed") && !level flag::get("book_runes_success");
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x18b46c83, Offset: 0x11b00
// Size: 0x2ec
function function_b1e065cd() {
    var_e9469e74 = 0;
    var_71abf438 = [];
    var_edface0 = 3;
    while (!var_e9469e74) {
        foreach (e_player in level.activeplayers) {
            if (e_player flag::get("has_ball")) {
                var_e9469e74 = 1;
                e_player waittill(#"weapon_change_complete");
            }
        }
        wait(0.1);
    }
    wait(1);
    for (i = 0; i < 4; i++) {
        s_point = struct::get("arena_exit_point_" + i, "targetname");
        if (!isdefined(var_71abf438)) {
            var_71abf438 = [];
        } else if (!isarray(var_71abf438)) {
            var_71abf438 = array(var_71abf438);
        }
        var_71abf438[var_71abf438.size] = s_point;
    }
    foreach (var_5ee55fde in level.players) {
        if (!isalive(var_5ee55fde)) {
            continue;
        }
        playfx(level._effect["portal_3p"], var_5ee55fde.origin);
        var_5ee55fde playlocalsound("zmb_teleporter_teleport_2d");
        playsoundatposition("zmb_teleporter_teleport_out", var_5ee55fde.origin);
        self thread function_14c1c18d(var_5ee55fde, var_71abf438, var_edface0);
    }
    level flag::clear("arena_occupied_by_player");
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x0
// Checksum 0x7ca418dd, Offset: 0x11df8
// Size: 0x16c
function function_79a1b871(e_triggerer) {
    var_87c8152d = level clientfield::get("circle_challenge_identity");
    var_71abf438 = [];
    s_point = struct::get("arena_reward_exit_point_" + var_87c8152d, "targetname");
    if (!isdefined(var_71abf438)) {
        var_71abf438 = [];
    } else if (!isarray(var_71abf438)) {
        var_71abf438 = array(var_71abf438);
    }
    var_71abf438[var_71abf438.size] = s_point;
    level function_14c1c18d(e_triggerer, var_71abf438, 3);
    wait(0.2);
    level.var_abc41d2[var_87c8152d] notify(#"trigger", e_triggerer);
    wait(0.1);
    w_current = e_triggerer getcurrentweapon();
    e_triggerer givemaxammo(w_current);
}

// Namespace namespace_f153ce01
// Params 4, eflags: 0x1 linked
// Checksum 0x9730ea30, Offset: 0x11f70
// Size: 0x844
function function_14c1c18d(player, var_71abf438, var_edface0, show_fx) {
    if (!isdefined(show_fx)) {
        show_fx = 1;
    }
    player endon(#"disconnect");
    player.b_teleporting = 1;
    player.teleport_location = player.origin;
    player zm_utility::create_streamer_hint(var_71abf438[0].origin, var_71abf438[0].angles, 1);
    if (show_fx) {
        player clientfield::set_to_player("player_shadowman_teleport_hijack_fx", 1);
    }
    n_pos = player.characterindex;
    prone_offset = (0, 0, 49);
    crouch_offset = (0, 0, 20);
    var_7cac5f2f = (0, 0, 0);
    var_594457ea = struct::get("teleport_room_" + n_pos, "targetname");
    var_d9543609 = undefined;
    if (player hasweapon(level.ballweapon)) {
        var_d9543609 = player.carryobject;
    }
    player disableoffhandweapons();
    player disableweapons();
    player freezecontrols(1);
    util::wait_network_frame();
    if (player getstance() == "prone") {
        desired_origin = var_594457ea.origin + prone_offset;
    } else if (player getstance() == "crouch") {
        desired_origin = var_594457ea.origin + crouch_offset;
    } else {
        desired_origin = var_594457ea.origin + var_7cac5f2f;
    }
    player.teleport_origin = spawn("script_model", player.origin);
    player.teleport_origin setmodel("tag_origin");
    player.teleport_origin.angles = player.angles;
    player playerlinktoabsolute(player.teleport_origin, "tag_origin");
    player.teleport_origin.origin = desired_origin;
    player.teleport_origin.angles = var_594457ea.angles;
    util::wait_network_frame();
    player.teleport_origin.angles = var_594457ea.angles;
    wait(var_edface0);
    level flag::clear("arena_occupied_by_player");
    if (show_fx) {
        player clientfield::set_to_player("player_shadowman_teleport_hijack_fx", 0);
    }
    a_players = getplayers();
    arrayremovevalue(a_players, player);
    s_pos = var_71abf438[player.characterindex];
    playfx(level._effect["portal_3p"], s_pos.origin);
    player unlink();
    playsoundatposition("zmb_teleporter_teleport_in", s_pos.origin);
    if (isdefined(player.teleport_origin)) {
        player.teleport_origin delete();
        player.teleport_origin = undefined;
    }
    player setorigin(s_pos.origin);
    player setplayerangles(s_pos.angles);
    player.zone_name = player zm_utility::get_current_zone();
    if ([[ level.var_d90687be ]]->function_2a75673(player)) {
        [[ level.var_d90687be ]]->function_ea39787e(player);
    }
    a_ai = getaiarray();
    a_aoe_ai = arraysortclosest(a_ai, s_pos.origin, a_ai.size, 0, -56);
    foreach (ai in a_aoe_ai) {
        if (isactor(ai)) {
            if (ai.archetype === "zombie") {
                playfx(level._effect["beast_return_aoe_kill"], ai gettagorigin("j_spineupper"));
            } else {
                playfx(level._effect["beast_return_aoe_kill"], ai.origin);
            }
            ai.marked_for_recycle = 1;
            ai.has_been_damaged_by_player = 0;
            ai.deathpoints_already_given = 1;
            ai.no_powerups = 1;
            ai dodamage(ai.health + 1000, s_pos.origin, player);
        }
    }
    player enableweapons();
    player enableoffhandweapons();
    player freezecontrols(level.intermission);
    wait(0.05);
    if (isdefined(var_d9543609)) {
        wait(0.05);
        var_d9543609 ball::function_98827162(0, s_pos.origin);
    }
    player.b_teleporting = 0;
}

// Namespace namespace_f153ce01
// Params 1, eflags: 0x1 linked
// Checksum 0x44c9a24c, Offset: 0x127c0
// Size: 0x124
function function_44d21c21(b_on) {
    var_8de6057e = getent("arena_bridge_center", "targetname");
    if (b_on) {
        var_8de6057e.is_on = 1;
        var_8de6057e moveto(var_8de6057e.v_start, 0.01);
        var_8de6057e show();
        var_8de6057e connectpaths();
        return;
    }
    var_8de6057e.is_on = 0;
    var_8de6057e ghost();
    var_8de6057e moveto(var_8de6057e.v_start - (0, 0, 1000), 0.01);
    var_8de6057e disconnectpaths();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x0
// Checksum 0x61d5141e, Offset: 0x128f0
// Size: 0xb2
function function_f2c00181() {
    while (true) {
        player = self waittill(#"trigger");
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        level thread function_adbf2990(self.stub, player);
        level notify(#"hash_6e3ae83");
        break;
    }
}

// Namespace namespace_f153ce01
// Params 2, eflags: 0x1 linked
// Checksum 0xe243b670, Offset: 0x129b0
// Size: 0x3c2
function function_adbf2990(var_91089b66, player) {
    if (player.var_887585ba == 0) {
        var_87f03818 = getweapon("hero_gravityspikes_melee");
        player zm_weapons::weapon_give(var_87f03818, 0, 1);
        player thread zm_equipment::show_hint_text(%ZM_GENESIS_GRAVITYSPIKE_USE_HINT, 3);
        player gadgetpowerset(player gadgetgetslot(var_87f03818), 100);
        player zm_weap_gravityspikes::update_gravityspikes_state(2);
    }
    var_71abf438 = [];
    for (i = 0; i < 4; i++) {
        s_point = struct::get("arena_exit_point_" + i, "targetname");
        if (!isdefined(var_71abf438)) {
            var_71abf438 = [];
        } else if (!isarray(var_71abf438)) {
            var_71abf438 = array(var_71abf438);
        }
        var_71abf438[var_71abf438.size] = s_point;
    }
    foreach (e_player in level.activeplayers) {
        if ([[ level.var_d90687be ]]->function_2a75673(e_player)) {
            playfx(level._effect["portal_3p"], e_player.origin);
            e_player playlocalsound("zmb_teleporter_teleport_2d");
            playsoundatposition("zmb_teleporter_teleport_out", e_player.origin);
            if (e_player == self) {
                var_87c8152d = level clientfield::get("circle_challenge_identity");
                var_c93fda2c = [];
                s_point = struct::get("arena_reward_exit_point_" + var_87c8152d, "targetname");
                if (!isdefined(var_c93fda2c)) {
                    var_c93fda2c = [];
                } else if (!isarray(var_c93fda2c)) {
                    var_c93fda2c = array(var_c93fda2c);
                }
                var_c93fda2c[var_c93fda2c.size] = s_point;
                level thread function_14c1c18d(e_player, var_c93fda2c, 3);
                continue;
            }
            level thread function_14c1c18d(e_player, var_71abf438, 3);
        }
    }
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x53849472, Offset: 0x12d80
// Size: 0x44
function function_39df21f9() {
    level endon(#"hash_6760e3ae");
    level clientfield::set("arena_timeout_warning", 1);
    wait(6);
    level thread function_6cc51202();
}

// Namespace namespace_f153ce01
// Params 0, eflags: 0x1 linked
// Checksum 0x93087961, Offset: 0x12dd0
// Size: 0x2cc
function function_6cc51202() {
    level notify(#"hash_45115ebd");
    var_71abf438 = [];
    for (i = 0; i < 4; i++) {
        s_point = struct::get("arena_exit_point_" + i, "targetname");
        if (!isdefined(var_71abf438)) {
            var_71abf438 = [];
        } else if (!isarray(var_71abf438)) {
            var_71abf438 = array(var_71abf438);
        }
        var_71abf438[var_71abf438.size] = s_point;
    }
    a_players = arraycopy(level.activeplayers);
    foreach (e_player in a_players) {
        if ([[ level.var_d90687be ]]->function_2a75673(e_player)) {
            playfx(level._effect["portal_3p"], e_player.origin);
            e_player playlocalsound("zmb_teleporter_teleport_2d");
            playsoundatposition("zmb_teleporter_teleport_out", e_player.origin);
            level thread function_14c1c18d(e_player, var_71abf438, 3);
        }
    }
    level clientfield::set("arena_timeout_warning", 0);
    level flag::clear("arena_occupied_by_player");
    level flag::set("book_runes_failed");
    level flag::clear("rift_entrance_open");
    level waittill(#"start_of_round");
    level flag::clear("book_runes_failed");
}

/#

    // Namespace namespace_f153ce01
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf590948a, Offset: 0x130a8
    // Size: 0x194
    function function_3745c6c8() {
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_506d0aab);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_db4e54c1);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_5addbab1);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_4f66f424);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_e4990d03);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 2, &function_e4990d03);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 3, &function_e4990d03);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0xeea1a02c, Offset: 0x13248
    // Size: 0xee
    function function_e4990d03(n_val) {
        function_5addbab1(n_val);
        util::wait_network_frame();
        function_db4e54c1(n_val);
        util::wait_network_frame();
        function_506d0aab(n_val);
        util::wait_network_frame();
        switch (n_val) {
        case 1:
            break;
        case 2:
            level thread zm_devgui::zombie_devgui_goto_round(6);
            break;
        case 3:
            level thread zm_devgui::zombie_devgui_goto_round(13);
            break;
        }
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x4d2d1ce7, Offset: 0x13340
    // Size: 0x1c2
    function function_506d0aab(n_val) {
        var_f52163c3 = array(0, 1, 2, 3, 5, 4);
        foreach (var_f4121fa3 in var_f52163c3) {
            level thread function_c4923f72(var_f4121fa3);
        }
        level thread zm_devgui::zombie_devgui_open_sesame();
        util::wait_network_frame();
        level thread function_4f66f424(n_val);
        util::wait_network_frame();
        foreach (e_player in level.activeplayers) {
            e_player disableinvulnerability();
            e_player thread zm_devgui::zombie_devgui_equipment_give("int");
        }
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7152032, Offset: 0x13510
    // Size: 0xd2
    function function_4f66f424(n_val) {
        players = level.activeplayers;
        for (i = 0; i < players.size; i++) {
            s_teleport = struct::get("int" + i, "int");
            players[i] setorigin(s_teleport.origin);
            players[i].angles = s_teleport.angles;
        }
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0xa9cbf263, Offset: 0x135f0
    // Size: 0x84
    function function_5addbab1(n_val) {
        setdvar("int", "int");
        wait(1);
        setdvar("int", "int");
        wait(1);
        setdvar("int", "int");
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0xab329635, Offset: 0x13680
    // Size: 0x3c
    function function_db4e54c1(n_val) {
        array::thread_all(level.activeplayers, &zm_utility::function_82a5cc4);
    }

    // Namespace namespace_f153ce01
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf2720ea2, Offset: 0x136c8
    // Size: 0xb0c
    function function_cc5cac5f() {
        level thread namespace_cb655c88::function_72260d3a("int", "int", 0, &function_c4923f72);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_c4923f72);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 2, &function_c4923f72);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 3, &function_c4923f72);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 0, &function_251f28c);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_251f28c);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 2, &function_251f28c);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 3, &function_251f28c);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 0, &function_871092c9);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_871092c9);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 2, &function_871092c9);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 4, &function_871092c9);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 0, &function_59d78fe0);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_59d78fe0);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 2, &function_59d78fe0);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 3, &function_59d78fe0);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 4, &function_59d78fe0);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 5, &function_59d78fe0);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 0, &function_9efa2460);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_9efa2460);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 2, &function_9efa2460);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 3, &function_9efa2460);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_10d73de7);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_3e3aa4a2);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 2, &function_3e3aa4a2);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_88f1ee45);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 0, &function_88f1ee45);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_ef5cc959);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_7104ee61);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_bc5b95af);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 0, &function_bc5b95af);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_fe9efe30);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 0, &function_fe9efe30);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_8a771d77);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 0, &function_8a771d77);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_82a40293);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 0, &function_82a40293);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 2, &function_ce0fad48);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 3, &function_ce0fad48);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_11f7a042);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 2, &function_11f7a042);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 3, &function_11f7a042);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 4, &function_11f7a042);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 0, &function_4e3a221e);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_f8dfefdd);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 0, &function_f8dfefdd);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_1189737f);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_4dd54050);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_cdccd485);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_995cb46);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_3cf095ce);
        level thread namespace_cb655c88::function_72260d3a("int", "int", 1, &function_60a02f3a);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x7d84b156, Offset: 0x141e0
    // Size: 0x2c
    function function_60a02f3a(n_val) {
        level flag::set("int");
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0xcc344ba6, Offset: 0x14218
    // Size: 0x24
    function function_cdccd485(n_val) {
        level thread function_b1b0d2b0();
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe16bec00, Offset: 0x14248
    // Size: 0x44
    function function_10d73de7(n_val) {
        level flag::set("int");
        level thread function_c2578b2a();
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8f0f58a1, Offset: 0x14298
    // Size: 0xe2
    function function_4dd54050(n_val) {
        var_83d6000c = struct::get_array("int", "int");
        foreach (var_59b850ac in var_83d6000c) {
            playfx(level._effect["int"], var_59b850ac.origin);
        }
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x8a95b106, Offset: 0x14388
    // Size: 0x64
    function function_88f1ee45(n_val) {
        iprintlnbold("int");
        if (n_val > 0) {
            function_44d21c21(1);
            return;
        }
        function_44d21c21(0);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0xe3d6008c, Offset: 0x143f8
    // Size: 0xa4
    function function_11f7a042(n_val) {
        switch (n_val) {
        case 1:
            level.var_c4133b63 = 1;
            break;
        case 2:
            level.var_c4133b63 = 3;
            break;
        case 3:
            level.var_c4133b63 = 10;
            break;
        case 4:
            level.var_c4133b63 = 20;
            break;
        }
        iprintlnbold("int" + level.var_c4133b63);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0xea361929, Offset: 0x144a8
    // Size: 0xde
    function function_c4923f72(var_87c8152d) {
        switch (var_87c8152d) {
        case 0:
            level.activeplayers[0] namespace_cb655c88::function_bb26d959(2);
            break;
        case 1:
            level.activeplayers[0] namespace_cb655c88::function_bb26d959(3);
            break;
        case 2:
            level.activeplayers[0] namespace_cb655c88::function_bb26d959(1);
            break;
        case 3:
            level.activeplayers[0] namespace_cb655c88::function_bb26d959(0);
            break;
        }
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0xad4f41dc, Offset: 0x14590
    // Size: 0x64
    function function_251f28c(var_87c8152d) {
        var_5a2492d5 = function_6ab2d662(var_87c8152d);
        var_60c1e5f7 = var_5a2492d5 + "int";
        level flag::clear(var_60c1e5f7);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6c3e93fd, Offset: 0x14600
    // Size: 0x34
    function function_871092c9(n_val) {
        level clientfield::set("int", n_val);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x17daac21, Offset: 0x14640
    // Size: 0x34
    function function_59d78fe0(n_val) {
        level clientfield::set("int", n_val);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0xfaeeb4b8, Offset: 0x14680
    // Size: 0x3c
    function function_9efa2460(n_val) {
        level notify(#"hash_6760e3ae");
        function_6a03c1d4(n_val, level.var_f98b3213);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3caf4812, Offset: 0x146c8
    // Size: 0xc8
    function function_ce0fad48(n_val) {
        if (n_val == 2) {
            self.var_e3b39dfc = 1;
            level.var_dbc3a0ef notify(#"hash_c7ccf077");
            level.var_42e19a0b = 2;
            level.var_dbc3a0ef.var_f60bc0ed = 2;
            return;
        }
        if (n_val == 3) {
            self.var_e3b39dfc = 1;
            level.var_dbc3a0ef notify(#"hash_c7ccf077");
            level.var_dbc3a0ef notify(#"hash_a1ca760e");
            level.var_42e19a0b = 3;
            level.var_dbc3a0ef.var_f60bc0ed = 4;
        }
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3f38e044, Offset: 0x14798
    // Size: 0x5c
    function function_f8dfefdd(n_val) {
        if (n_val > 0) {
            level flag::set("int");
            return;
        }
        level flag::clear("int");
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x34ed7669, Offset: 0x14800
    // Size: 0x12a
    function function_1189737f(n_val) {
        players = level.activeplayers;
        foreach (player in players) {
            var_8e5264b2 = struct::get("int" + player.characterindex, "int");
            player setorigin(var_8e5264b2.origin);
            player setplayerangles(var_8e5264b2.angles);
            [[ level.var_d90687be ]]->function_ea39787e(player);
        }
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x850f44e8, Offset: 0x14938
    // Size: 0x4c
    function function_ef5cc959(n_val) {
        level flag::set("int");
        function_6a03c1d4(0, level.var_f98b3213);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x4c7d147e, Offset: 0x14990
    // Size: 0x3bc
    function function_7104ee61(n_val) {
        a_str_flags = [];
        if (!isdefined(a_str_flags)) {
            a_str_flags = [];
        } else if (!isarray(a_str_flags)) {
            a_str_flags = array(a_str_flags);
        }
        a_str_flags[a_str_flags.size] = "int";
        if (!isdefined(a_str_flags)) {
            a_str_flags = [];
        } else if (!isarray(a_str_flags)) {
            a_str_flags = array(a_str_flags);
        }
        a_str_flags[a_str_flags.size] = "int";
        if (!isdefined(a_str_flags)) {
            a_str_flags = [];
        } else if (!isarray(a_str_flags)) {
            a_str_flags = array(a_str_flags);
        }
        a_str_flags[a_str_flags.size] = "int";
        if (!isdefined(a_str_flags)) {
            a_str_flags = [];
        } else if (!isarray(a_str_flags)) {
            a_str_flags = array(a_str_flags);
        }
        a_str_flags[a_str_flags.size] = "int";
        if (!isdefined(a_str_flags)) {
            a_str_flags = [];
        } else if (!isarray(a_str_flags)) {
            a_str_flags = array(a_str_flags);
        }
        a_str_flags[a_str_flags.size] = "int";
        if (!isdefined(a_str_flags)) {
            a_str_flags = [];
        } else if (!isarray(a_str_flags)) {
            a_str_flags = array(a_str_flags);
        }
        a_str_flags[a_str_flags.size] = "int";
        if (!isdefined(a_str_flags)) {
            a_str_flags = [];
        } else if (!isarray(a_str_flags)) {
            a_str_flags = array(a_str_flags);
        }
        a_str_flags[a_str_flags.size] = "int";
        foreach (str_flag in a_str_flags) {
            if (math::cointoss()) {
                level flag::set("int" + str_flag);
                continue;
            }
            level flag::clear("int" + str_flag);
        }
        level flag::set("int");
        function_6a03c1d4(0, level.var_f98b3213);
    }

    // Namespace namespace_f153ce01
    // Params 2, eflags: 0x1 linked
    // Checksum 0x2a678c21, Offset: 0x14d58
    // Size: 0x6c
    function function_9bc9cf70(str_msg, n_val) {
        if (n_val > 0) {
            iprintlnbold(str_msg + "int");
            return;
        }
        iprintlnbold(str_msg + "int");
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x709d0d7b, Offset: 0x14dd0
    // Size: 0x4c
    function function_bc5b95af(n_val) {
        level flag::set("int");
        function_9bc9cf70("int", n_val);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1ab632ef, Offset: 0x14e28
    // Size: 0x4c
    function function_fe9efe30(n_val) {
        level flag::set("int");
        function_9bc9cf70("int", n_val);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x80cb2abd, Offset: 0x14e80
    // Size: 0x4c
    function function_8a771d77(n_val) {
        level flag::set("int");
        function_9bc9cf70("int", n_val);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0xc8fbfb17, Offset: 0x14ed8
    // Size: 0x4c
    function function_82a40293(n_val) {
        level flag::set("int");
        function_9bc9cf70("int", n_val);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x0
    // Checksum 0xafa74eda, Offset: 0x14f30
    // Size: 0x4c
    function function_d968aba8(n_val) {
        level flag::set("int");
        function_9bc9cf70("int", n_val);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x0
    // Checksum 0x4db7e293, Offset: 0x14f88
    // Size: 0x4c
    function function_9808fea3(n_val) {
        level flag::set("int");
        function_9bc9cf70("int", n_val);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x0
    // Checksum 0x244309e5, Offset: 0x14fe0
    // Size: 0x4c
    function function_23d9750e(n_val) {
        level flag::set("int");
        function_9bc9cf70("int", n_val);
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x38a920c3, Offset: 0x15038
    // Size: 0x1c
    function function_4e3a221e(n_val) {
        level.var_f98b3213 = n_val;
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0xac68f1c1, Offset: 0x15060
    // Size: 0xac
    function function_3e3aa4a2(n_val) {
        if (n_val == 1) {
            level thread function_655271b9();
            return;
        }
        if (n_val == 2) {
            level notify(#"hash_f115a4c8");
            level clientfield::set("int", 2);
            level clientfield::set("int", 3);
            level thread function_63b428de();
        }
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x3936b7eb, Offset: 0x15118
    // Size: 0x24
    function function_995cb46(n_val) {
        level thread function_386f30f4();
    }

    // Namespace namespace_f153ce01
    // Params 1, eflags: 0x1 linked
    // Checksum 0x2a82f5b7, Offset: 0x15148
    // Size: 0x4c
    function function_3cf095ce(n_val) {
        if (isdefined(level.var_5b08e991)) {
            level thread function_205c3adf();
            level function_ab0e7bbf();
        }
    }

#/
