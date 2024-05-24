#using scripts/zm/zm_zod_util;
#using scripts/zm/zm_zod_quest;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_ec1f3b4;

// Namespace namespace_ec1f3b4
// Method(s) 36 Total 36
class class_a0023ae3 {

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0xafc1ab88, Offset: 0x25c8
    // Size: 0x35c
    function function_a5e2032d() {
        var_7591ca03 = zm_zonemgr::get_zone_from_position(self.var_cac6e7ae.origin);
        if (issubstr(var_7591ca03, "burlesque")) {
            var_b42fba6b = "burlesque";
        } else if (issubstr(var_7591ca03, "gym")) {
            var_b42fba6b = "gym";
        } else if (issubstr(var_7591ca03, "brothel")) {
            var_b42fba6b = "brothel";
        } else if (issubstr(var_7591ca03, "magician")) {
            var_b42fba6b = "magician";
        } else {
            var_b42fba6b = "pap";
        }
        var_b5a606c0 = [];
        foreach (str_zone_name in level.active_zone_names) {
            if (issubstr(str_zone_name, var_b42fba6b)) {
                if (!isdefined(var_b5a606c0)) {
                    var_b5a606c0 = [];
                } else if (!isarray(var_b5a606c0)) {
                    var_b5a606c0 = array(var_b5a606c0);
                }
                var_b5a606c0[var_b5a606c0.size] = str_zone_name;
            }
        }
        a_ai_zombies = getaiteamarray(level.zombie_team);
        a_ai_zombies = arraysort(a_ai_zombies, self.var_cac6e7ae.origin);
        i = 0;
        while (i < a_ai_zombies.size) {
            var_31a4faf3 = 0;
            foreach (var_7da234a9 in var_b5a606c0) {
                if (a_ai_zombies[i] zm_zonemgr::entity_in_zone(var_7da234a9)) {
                    var_31a4faf3 = 1;
                    i++;
                    break;
                }
            }
            if (!var_31a4faf3) {
                arrayremovevalue(a_ai_zombies, a_ai_zombies[i]);
            }
        }
        return a_ai_zombies;
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0x4378e3f1, Offset: 0x2240
    // Size: 0x37a
    function function_8d5cae10() {
        level lui::screen_flash(0.2, 0.5, 1, 0.8, "white");
        wait(0.2);
        a_ai_zombies = function_a5e2032d();
        var_6b1085eb = [];
        foreach (ai_zombie in a_ai_zombies) {
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
            if (!level flag::get("special_round")) {
                if (var_f92b3d80.archetype == "margwa") {
                    level.var_e0191376++;
                    continue;
                }
                level.zombie_total++;
            }
        }
    }

    // Namespace namespace_a0023ae3
    // Params 1, eflags: 0x0
    // Checksum 0x835059c9, Offset: 0x2150
    // Size: 0xe2
    function function_19d7a318(player) {
        if (isdefined(player) && player.sessionstate === "spectator") {
            return;
        }
        if (isdefined(player) && isdefined(player.var_fed8a8e6)) {
            var_5def8893 = player getluimenu(self.var_56b146ea);
            var_b5e415a4 = player getluimenu(self.var_3dc82e65);
            if (isdefined(var_5def8893) || isdefined(var_b5e415a4)) {
                player closeluimenu(player.var_fed8a8e6);
                player.var_fed8a8e6 = undefined;
            }
        }
    }

    // Namespace namespace_a0023ae3
    // Params 1, eflags: 0x0
    // Checksum 0x6908aeeb, Offset: 0x20d8
    // Size: 0x6c
    function function_d2445eb5(player) {
        self function_19d7a318(player);
        if (isdefined(player) && player.sessionstate === "spectator") {
            return;
        }
        wait(3);
        self function_19d7a318(player);
    }

    // Namespace namespace_a0023ae3
    // Params 1, eflags: 0x0
    // Checksum 0x30a4562c, Offset: 0x2050
    // Size: 0x7c
    function function_56842015(player) {
        self function_19d7a318(player);
        if (isdefined(player) && isdefined(player.sessionstate) && player.sessionstate == "spectator") {
            return;
        }
        wait(3);
        self function_19d7a318(player);
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0xc02b5adb, Offset: 0x2038
    // Size: 0x10
    function function_4721f0d() {
        return self.var_b46f18d4 / 100;
    }

    // Namespace namespace_a0023ae3
    // Params 1, eflags: 0x0
    // Checksum 0x6ded2910, Offset: 0x1f28
    // Size: 0x102
    function function_1a94b9be(player) {
        if (isdefined(self.var_b8236eca)) {
            if (zm_utility::is_player_valid(player, 1, 1) && player istouching(self.var_b8236eca)) {
                return 1;
            } else {
                return 0;
            }
        }
        if (zm_utility::is_player_valid(player, 1, 1) && distance2dsquared(player.origin, self.var_cac6e7ae.origin) < self.var_d109e848 && player.origin[2] > self.var_cac6e7ae.origin[2] + -20) {
            return 1;
        }
        return 0;
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0x1a05b52f, Offset: 0x1e48
    // Size: 0xd6
    function function_e58747ab() {
        var_d416c150 = [];
        foreach (player in level.activeplayers) {
            if (zm_utility::is_player_valid(player) && function_1a94b9be(player)) {
                array::add(var_d416c150, player);
            }
        }
        return var_d416c150;
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0x14cbc257, Offset: 0x1e30
    // Size: 0xa
    function get_state() {
        return self.var_5fd95ddf;
    }

    // Namespace namespace_a0023ae3
    // Params 2, eflags: 0x0
    // Checksum 0x50673fe9, Offset: 0x1de8
    // Size: 0x3a
    function function_a0b7b4c(var_1062af15, var_6acb4269) {
        var_47c092c2 = var_1062af15 / var_6acb4269 * self.var_35a35f82;
        return var_47c092c2;
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0xb6c9e505, Offset: 0x1d10
    // Size: 0xca
    function function_c9ad9349() {
        foreach (zombie in self.var_a64ccb9c) {
            if (isdefined(zombie.allowdeath) && isalive(zombie) && zombie.allowdeath) {
                zombie kill();
            }
        }
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0x1a3a4bd8, Offset: 0x1bc0
    // Size: 0x148
    function function_17690ec3() {
        /#
            println("<unknown string>");
        #/
        self.var_5fd95ddf = 1;
        function_f494e855();
        function_c9ad9349();
        self.var_c2c38644 = [];
        self thread function_7a82ab47();
        foreach (player in self.var_9e054a5d) {
            if (!isdefined(player)) {
                continue;
            }
            player thread namespace_8e578893::function_6edf48d5(0);
            player.var_84f1bc44 = undefined;
            self thread function_d2445eb5(player);
        }
        [[ self.var_146da93e ]](self.var_20a1be38);
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0x421a8147, Offset: 0x19a0
    // Size: 0x216
    function function_49b4e0e3() {
        /#
            println("<unknown string>");
        #/
        self.var_5fd95ddf = 3;
        function_c9ad9349();
        foreach (s_spawn_point in self.var_c2c38644) {
            s_spawn_point delete();
        }
        self.var_c2c38644 = [];
        self thread function_8d5cae10();
        zm_unitrigger::unregister_unitrigger(self.var_28f7dec3);
        self.var_28f7dec3 = undefined;
        foreach (player in self.var_9e054a5d) {
            if (!isdefined(player)) {
                continue;
            }
            player thread namespace_8e578893::function_6edf48d5(6);
            player.var_84f1bc44 = undefined;
            self thread function_56842015(player);
            player zm_score::add_to_player_score(500);
        }
        [[ self.var_46491092 ]](self.var_20a1be38, self.var_9e054a5d);
        self notify(#"hash_383cb307");
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0xa8776fa2, Offset: 0x1850
    // Size: 0x148
    function function_7e9f0faf() {
        a_valid_spawn_points = [];
        for (var_1bbdbab3 = 0; !a_valid_spawn_points.size; var_1bbdbab3 = 1) {
            foreach (s_spawn_point in self.var_c2c38644) {
                if (!isdefined(s_spawn_point.var_dabf8ae2) || var_1bbdbab3) {
                    s_spawn_point.var_dabf8ae2 = 0;
                }
                if (!s_spawn_point.var_dabf8ae2) {
                    array::add(a_valid_spawn_points, s_spawn_point, 0);
                }
            }
            if (!a_valid_spawn_points.size) {
            }
        }
        s_spawn_point = array::random(a_valid_spawn_points);
        s_spawn_point.var_dabf8ae2 = 1;
        return s_spawn_point;
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0x726908e6, Offset: 0x1668
    // Size: 0x1e0
    function function_877a7365() {
        self endon(#"death");
        while (true) {
            var_c7ca004c = [];
            foreach (player in level.activeplayers) {
                if (isdefined(player.var_84f1bc44) && zm_utility::is_player_valid(player) && player.var_84f1bc44) {
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

    // Namespace namespace_a0023ae3
    // Params 1, eflags: 0x0
    // Checksum 0xdc74743c, Offset: 0x1620
    // Size: 0x3c
    function function_df5ae14e(ai_zombie) {
        ai_zombie waittill(#"death");
        ai_zombie clientfield::set("keeper_fx", 0);
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0x500ff50d, Offset: 0x1470
    // Size: 0x1a2
    function function_dab6014d() {
        self.var_a64ccb9c = [];
        while (self.var_5fd95ddf == 2) {
            self.var_a64ccb9c = array::remove_dead(self.var_a64ccb9c, 0);
            var_2021b6 = 4;
            if (level.round_number < 4) {
                var_2021b6 = 6;
            } else if (level.round_number < 6) {
                var_2021b6 = 5;
            }
            if (self.var_a64ccb9c.size < var_2021b6) {
                s_spawn_point = function_7e9f0faf();
                ai = zombie_utility::spawn_zombie(self.var_ce363bed[0], "defend_event_zombie", s_spawn_point);
                if (!isdefined(ai)) {
                    /#
                        println("<unknown string>");
                    #/
                    continue;
                }
                ai.var_81ac9e79 = 1;
                ai thread namespace_1f61c67f::function_2d0c5aa1(s_spawn_point);
                ai thread function_877a7365();
                array::add(self.var_a64ccb9c, ai, 0);
            }
            wait(level.zombie_vars["zombie_spawn_delay"]);
        }
    }

    // Namespace namespace_a0023ae3
    // Params 2, eflags: 0x0
    // Checksum 0x2d8c6303, Offset: 0x1308
    // Size: 0x15e
    function function_d9a5609b(var_6acb4269, var_1062af15) {
        if (var_6acb4269 == 1) {
            return 20;
        }
        if (var_6acb4269 == 2 && var_1062af15 == 1) {
            return 30;
        }
        if (var_6acb4269 == 2 && var_1062af15 == 2) {
            return 20;
        }
        if (var_6acb4269 == 3 && var_1062af15 == 1) {
            return 40;
        }
        if (var_6acb4269 == 3 && var_1062af15 == 2) {
            return 30;
        }
        if (var_6acb4269 == 3 && var_1062af15 == 3) {
            return 20;
        }
        if (var_6acb4269 == 4 && var_1062af15 == 1) {
            return 60;
        }
        if (var_6acb4269 == 4 && var_1062af15 == 2) {
            return 40;
        }
        if (var_6acb4269 == 4 && var_1062af15 == 3) {
            return 30;
        }
        if (var_6acb4269 == 4 && var_1062af15 == 4) {
            return 20;
        }
        return 30;
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0x4eb6c0e1, Offset: 0xef8
    // Size: 0x404
    function progress_think() {
        /#
            println("<unknown string>");
        #/
        self.var_b46f18d4 = 0;
        self.var_3218a534 = self.var_3895bf80;
        self.var_9e054a5d = [];
        var_db69778c = level.activeplayers.size;
        var_d416c150 = function_e58747ab();
        var_1062af15 = var_d416c150.size;
        self.var_89a7aad3 = function_d9a5609b(var_db69778c, var_1062af15);
        self.var_35a35f82 = 100 / self.var_89a7aad3 * 0.1;
        while (self.var_b46f18d4 < 100 && self.var_3218a534 > 0) {
            var_d416c150 = function_e58747ab();
            var_1062af15 = var_d416c150.size;
            foreach (player in level.activeplayers) {
                if (!zm_utility::is_player_valid(player, 1, 1)) {
                    continue;
                }
                if (function_1a94b9be(player)) {
                    if (!isdefined(player.var_84f1bc44)) {
                        player thread namespace_8e578893::function_6edf48d5(5);
                        array::add(self.var_9e054a5d, player, 0);
                        player.var_84f1bc44 = 1;
                    }
                    if (!player.var_84f1bc44) {
                        player thread namespace_8e578893::function_6edf48d5(5);
                        player.var_84f1bc44 = 1;
                        self function_19d7a318(player);
                    }
                    continue;
                }
                if (zm_utility::is_player_valid(player, 1, 1)) {
                    if (isdefined(player.var_84f1bc44) && player.var_84f1bc44) {
                        player thread namespace_8e578893::function_6edf48d5(0);
                        player.var_84f1bc44 = 0;
                        self function_19d7a318(player);
                        player.var_fed8a8e6 = player openluimenu(self.var_3dc82e65);
                    }
                }
            }
            var_2e902fc4 = self.var_35a35f82;
            self.var_b46f18d4 += var_2e902fc4;
            if (var_1062af15 > 0) {
                self.var_b46f18d4 = math::clamp(self.var_b46f18d4, 0, 100);
                self.var_3218a534 = self.var_3895bf80;
            } else {
                self.var_3218a534 -= 0.1;
            }
            wait(0.1);
        }
        if (self.var_b46f18d4 == 100) {
            function_49b4e0e3();
            return;
        }
        function_17690ec3();
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0x96cccb54, Offset: 0xd90
    // Size: 0x15c
    function function_86206edf() {
        self endon(#"hash_383cb307");
        while (true) {
            e_triggerer = self.var_28f7dec3 waittill(#"trigger");
            if (e_triggerer zm_utility::in_revive_trigger()) {
                continue;
            }
            if (!zm_utility::is_player_valid(e_triggerer, 1, 1)) {
                continue;
            }
            if (self.var_5fd95ddf != 1) {
                continue;
            }
            if (isdefined(self.var_f68b577b) && [[ self.var_f68b577b ]](self.var_20a1be38) == 0) {
                continue;
            }
            self.var_5fd95ddf = 2;
            self.var_c8286d42 = e_triggerer;
            function_f494e855();
            [[ self.m_func_start ]](self.var_20a1be38, self.var_c8286d42);
            self thread progress_think();
            self thread function_dab6014d();
            while (self.var_5fd95ddf != 1) {
                wait(1);
            }
        }
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0x8f9ff512, Offset: 0xd58
    // Size: 0x2c
    function function_f494e855() {
        if (isdefined(self.var_28f7dec3)) {
            self.var_28f7dec3 zm_unitrigger::run_visibility_function_for_all_triggers();
        }
    }

    // Namespace namespace_a0023ae3
    // Params 1, eflags: 0x0
    // Checksum 0x391efb7f, Offset: 0xc58
    // Size: 0xf4
    function function_4e035595(player) {
        self endon(#"disconnect");
        if (isdefined(player.var_b999c630) && player.var_b999c630 || !level flag::get("ritual_in_progress")) {
            return;
        }
        player.var_b999c630 = 1;
        if (zm_utility::is_player_valid(player)) {
            player thread namespace_8e578893::function_55f114f9("zmInventory.widget_quest_items", 3.5);
            player thread namespace_8e578893::function_69e0fb83("ZM_ZOD_UI_RITUAL_BUSY", 3.5);
        }
        wait(3.5);
        player.var_b999c630 = 0;
    }

    // Namespace namespace_a0023ae3
    // Params 1, eflags: 0x0
    // Checksum 0xc818e23f, Offset: 0xb90
    // Size: 0xc0
    function function_bccaba63(player) {
        b_is_visible = [[ self.stub.var_501122d5 ]]->function_c9c18baa(player);
        if (b_is_visible) {
            str_msg = [[ self.stub.var_501122d5 ]]->function_58ff5d0b(player);
            self sethintstring(str_msg);
            thread function_4e035595(player);
        } else {
            self sethintstring(%);
        }
        return b_is_visible;
    }

    // Namespace namespace_a0023ae3
    // Params 1, eflags: 0x0
    // Checksum 0x8e2e5971, Offset: 0xaf0
    // Size: 0x98
    function function_c9c18baa(player) {
        if (isdefined(player.beastmode) && player.beastmode) {
            return false;
        }
        if (isdefined(level.var_522a1f61) && level.var_522a1f61) {
            return false;
        }
        if (self.var_784ea913) {
            switch (self.var_5fd95ddf) {
            case 0:
            case 1:
                return true;
            default:
                break;
            }
        }
        return false;
    }

    // Namespace namespace_a0023ae3
    // Params 1, eflags: 0x0
    // Checksum 0x27e6d9f, Offset: 0xa80
    // Size: 0x46
    function function_58ff5d0b(player) {
        if (!self.var_784ea913) {
            return %;
        }
        switch (self.var_5fd95ddf) {
        case 0:
            return self.var_3647811a;
        case 1:
            return self.var_463d711d;
        default:
            return %;
        }
    }

    // Namespace namespace_a0023ae3
    // Params 1, eflags: 0x0
    // Checksum 0x2bce6b1e, Offset: 0xa08
    // Size: 0x6c
    function function_a7fe9183(var_a7e88950) {
        if (var_a7e88950 && self.var_5fd95ddf == 0) {
            self.var_5fd95ddf = 1;
        } else if (!var_a7e88950 && self.var_5fd95ddf == 1) {
            self.var_5fd95ddf = 0;
        }
        function_f494e855();
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0xd8419f75, Offset: 0x938
    // Size: 0xc4
    function start() {
        var_329acd7d = (110, 110, -128);
        self.var_28f7dec3 = namespace_8e578893::function_c17c0335(self.var_cac6e7ae.origin, self.var_cac6e7ae.angles, var_329acd7d, 1);
        self.var_28f7dec3.var_501122d5 = self;
        self.var_28f7dec3.prompt_and_visibility_func = self.var_602ef511;
        self.var_784ea913 = 1;
        function_f494e855();
        self thread function_86206edf();
    }

    // Namespace namespace_a0023ae3
    // Params 1, eflags: 0x0
    // Checksum 0x82f5a088, Offset: 0x8f8
    // Size: 0x34
    function function_27323b36(n_duration) {
        self.var_89a7aad3 = n_duration;
        self.var_35a35f82 = 100 / self.var_89a7aad3 * 0.1;
    }

    // Namespace namespace_a0023ae3
    // Params 2, eflags: 0x0
    // Checksum 0x58cbdd78, Offset: 0x838
    // Size: 0xb4
    function function_b9dda40b(var_8a526dce, var_11689cb) {
        self.var_b8236eca = getent(var_8a526dce, "targetname");
        self.var_52d55b67 = getent(var_11689cb, "targetname");
        /#
            assert(isdefined(self.var_b8236eca), "<unknown string>");
        #/
        /#
            assert(isdefined(self.var_52d55b67), "<unknown string>");
        #/
    }

    // Namespace namespace_a0023ae3
    // Params 4, eflags: 0x0
    // Checksum 0x4d1abdb8, Offset: 0x7d8
    // Size: 0x54
    function function_5b8cdc04(var_3c44c0e6, var_9f159069, var_12fe55ea, var_71882fb8) {
        self.var_56b146ea = var_3c44c0e6;
        self.var_3dc82e65 = var_9f159069;
        self.var_290027ee = var_12fe55ea;
        self.var_8be792c4 = var_71882fb8;
    }

    // Namespace namespace_a0023ae3
    // Params 5, eflags: 0x0
    // Checksum 0xf7e639a7, Offset: 0x768
    // Size: 0x68
    function function_4cc0ffc1(var_4204f55f, func_start, var_ca8be47e, var_8cd80362, arg1) {
        self.var_f68b577b = var_4204f55f;
        self.m_func_start = func_start;
        self.var_46491092 = var_ca8be47e;
        self.var_146da93e = var_8cd80362;
        self.var_20a1be38 = arg1;
    }

    // Namespace namespace_a0023ae3
    // Params 1, eflags: 0x0
    // Checksum 0x71fd5a1d, Offset: 0x748
    // Size: 0x18
    function function_ebd4e698(var_175bc9b5) {
        self.var_602ef511 = var_175bc9b5;
    }

    // Namespace namespace_a0023ae3
    // Params 0, eflags: 0x0
    // Checksum 0xa0dbf1b5, Offset: 0x588
    // Size: 0x1b8
    function function_7a82ab47() {
        self.var_ce363bed = getentarray("ritual_zombie_spawner", "targetname");
        a_s_spawn_points = struct::get_array(self.var_9346a886, "targetname");
        foreach (s_spawn_point in a_s_spawn_points) {
            var_f9efb018 = spawn("script_model", s_spawn_point.origin);
            var_f9efb018 setmodel("tag_origin");
            var_f9efb018.origin = s_spawn_point.origin;
            var_f9efb018.angles = s_spawn_point.angles;
            if (!isdefined(self.var_c2c38644)) {
                self.var_c2c38644 = [];
            } else if (!isarray(self.var_c2c38644)) {
                self.var_c2c38644 = array(self.var_c2c38644);
            }
            self.var_c2c38644[self.var_c2c38644.size] = var_f9efb018;
        }
    }

    // Namespace namespace_a0023ae3
    // Params 2, eflags: 0x0
    // Checksum 0x8ce06dde, Offset: 0x3f8
    // Size: 0x184
    function init(var_53ca5e30, str_spawn) {
        self.var_cac6e7ae = struct::get(var_53ca5e30, "targetname");
        self.var_9346a886 = str_spawn;
        self.var_89a7aad3 = 30;
        self.var_b46f18d4 = 0;
        self.var_35a35f82 = 100 / self.var_89a7aad3 * 0.1;
        self.var_3895bf80 = 5;
        self.var_3218a534 = self.var_3895bf80;
        self.var_a19cef5d = -36;
        self.var_d109e848 = self.var_a19cef5d * self.var_a19cef5d;
        self.var_13eba724 = self.var_a19cef5d;
        self.var_8070fe37 = self.var_13eba724 * self.var_13eba724;
        self.var_3647811a = %ZM_ZOD_DEFEND_AREA_UNAVAILABLE;
        self.var_463d711d = %ZM_ZOD_DEFEND_AREA_AVAILABLE;
        self.var_bfd4728d = %ZM_ZOD_DEFEND_AREA_IN_PROGRESS;
        self.var_602ef511 = &function_bccaba63;
        var_38851ded = &function_86206edf;
        function_7a82ab47();
        self.var_5fd95ddf = 0;
        self.var_784ea913 = 0;
        function_f494e855();
    }

}

