#using scripts/cp/_scoreevents;
#using scripts/cp/_laststand;
#using scripts/cp/_pickups;
#using scripts/cp/_util;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace pickups;

// Namespace pickups
// Method(s) 13 Total 38
class class_9ae542c5 : class_d63e16f5 {

    // Namespace namespace_9ae542c5
    // Params 0, eflags: 0x0
    // Checksum 0x6ee9770b, Offset: 0x3c8
    // Size: 0xe6
    function constructor() {
        self.var_b40c8b78 = 1;
        self.var_74ef8b0c = 0;
        self.var_e7b9c303 = -128;
        self.var_6aa5050d = 256;
        self.var_90a8298c = 2;
        self.var_af900c85 = (0, 0, 0);
        self.var_dcf4479e = 0;
        self.var_db666eb1 = (45, 0, 0);
        self.var_2655604d = 64;
        self.var_ba68bd3 = 0;
        self.var_f4821922 = 1;
        self.var_5c6e11a4 = [];
        self.var_5c6e11a4[0] = &function_915789e0;
        self.var_c7279522 = [];
        self.var_c7279522[0] = &function_f84750dc;
    }

    // Namespace namespace_9ae542c5
    // Params 1, eflags: 0x0
    // Checksum 0xffb7b0cf, Offset: 0xad0
    // Size: 0x34
    function function_f84750dc(e_triggerer) {
        function_4d925e68(e_triggerer.origin, e_triggerer.angles);
    }

    // Namespace namespace_9ae542c5
    // Params 1, eflags: 0x0
    // Checksum 0x112051c1, Offset: 0xa88
    // Size: 0x3c
    function function_915789e0(e_triggerer) {
        self.var_a6c557b4 delete();
        self.var_52e14d7c setinvisibletoall();
    }

    // Namespace namespace_9ae542c5
    // Params 0, eflags: 0x0
    // Checksum 0x6bed268a, Offset: 0xa50
    // Size: 0x30
    function function_d2e1e79d() {
        if (self.var_74ef8b0c > 0) {
            return;
        }
        if (self.var_b40c8b78 > 0) {
            wait(self.var_b40c8b78);
        }
    }

    // Namespace namespace_9ae542c5
    // Params 0, eflags: 0x0
    // Checksum 0xfa6d1213, Offset: 0xa30
    // Size: 0x12
    function function_cefc7c8b() {
        self notify(#"hash_f9bc44a3");
    }

    // Namespace namespace_9ae542c5
    // Params 0, eflags: 0x0
    // Checksum 0x27912ab0, Offset: 0x988
    // Size: 0x9e
    function function_ac20c633() {
        self endon(#"hash_2f46dd38");
        for (n_time_remaining = self.var_dcf4479e; n_time_remaining >= 0 && isdefined(self.var_a6c557b4); n_time_remaining -= 1) {
            /#
                print3d(self.var_a6c557b4.origin + (0, 0, 15), n_time_remaining, (1, 0, 0), 1, 1, 20);
            #/
            wait(1);
        }
    }

    // Namespace namespace_9ae542c5
    // Params 0, eflags: 0x0
    // Checksum 0x356dd499, Offset: 0x910
    // Size: 0x6c
    function function_107b02f9() {
        self endon(#"hash_2f46dd38");
        if (self.var_dcf4479e <= 0) {
            return;
        }
        self thread function_ac20c633();
        wait(self.var_dcf4479e);
        if (isdefined(self.var_c07a933c)) {
            [[ self.var_c07a933c ]]();
            return;
        }
        function_cefc7c8b();
    }

    // Namespace namespace_9ae542c5
    // Params 2, eflags: 0x0
    // Checksum 0x908a9c1c, Offset: 0x638
    // Size: 0x2cc
    function function_4d925e68(v_pos, v_angles) {
        if (!isdefined(self.var_a6c557b4)) {
            self.var_a6c557b4 = util::spawn_model(self.var_c65ad26d, v_pos + (0, 0, self.var_ba68bd3), v_angles);
            self.var_a6c557b4 notsolid();
            if (isdefined(self.var_1fd664a9)) {
                playfxontag(self.var_1fd664a9, self.var_a6c557b4, "tag_origin");
            }
        }
        self.var_ec6c2cf4 = "Press and hold ^3[{+activate}]^7 to pick up " + self.var_1c709f79;
        if (!isdefined(self.var_52e14d7c)) {
            e_trigger = namespace_d63e16f5::function_89293eac(v_pos);
            namespace_d63e16f5::function_2180809b(e_trigger);
        }
        self.var_52e14d7c setvisibletoall();
        self.var_52e14d7c.origin = v_pos;
        self.var_52e14d7c notify(#"hash_2e14467e");
        self.var_52e14d7c notify(#"hash_4e236be4", 1);
        self.var_52e14d7c sethintstring(self.var_ec6c2cf4);
        self.var_52e14d7c.var_23a943a5 = self.var_1c709f79;
        if (!isdefined(self.var_52e14d7c.targetname)) {
            var_7e16e483 = "";
            var_8b14ca2b = strtok(tolower(self.var_1c709f79), " ");
            foreach (n_index, var_d928705c in var_8b14ca2b) {
                if (n_index > 0) {
                    var_7e16e483 += "_";
                }
                var_7e16e483 += var_d928705c;
            }
            self.var_52e14d7c.targetname = "trigger_" + var_7e16e483;
        }
        if (self.var_f4821922) {
            self thread namespace_d63e16f5::function_a72a316b();
        }
    }

    // Namespace namespace_9ae542c5
    // Params 2, eflags: 0x0
    // Checksum 0xad595426, Offset: 0x598
    // Size: 0x98
    function function_2156149c(v_pos, v_angles) {
        while (true) {
            if (isdefined(self.var_22e59a35)) {
                [[ self.var_22e59a35 ]](v_pos, v_angles);
            } else {
                self.var_2cb2c9c5 = "Press ^3[{+usereload}]^7 to drop " + self.var_1c709f79;
                function_4d925e68(v_pos, v_angles);
            }
            self waittill(#"hash_f9bc44a3");
            function_d2e1e79d();
        }
    }

    // Namespace namespace_9ae542c5
    // Params 2, eflags: 0x0
    // Checksum 0x6734b55, Offset: 0x560
    // Size: 0x2c
    function function_8f5ea154(v_pos, v_angles) {
        function_2156149c(v_pos, v_angles);
    }

    // Namespace namespace_9ae542c5
    // Params 1, eflags: 0x0
    // Checksum 0x6e49965b, Offset: 0x4f8
    // Size: 0x5c
    function function_8e0147fa(str_struct) {
        if (!isdefined(str_struct.angles)) {
            str_struct.angles = (0, 0, 0);
        }
        function_2156149c(str_struct.origin, str_struct.angles);
    }

    // Namespace namespace_9ae542c5
    // Params 0, eflags: 0x0
    // Checksum 0x2322ea50, Offset: 0x4b8
    // Size: 0x32
    function function_e57da5ad() {
        if (isdefined(self.var_ce54c88c)) {
            return self.var_ce54c88c;
        } else if (isdefined(self.var_a6c557b4)) {
            return self.var_a6c557b4;
        }
        return undefined;
    }

}

// Namespace pickups
// Method(s) 27 Total 27
class class_d63e16f5 {

    var var_8407f02a;

    // Namespace namespace_d63e16f5
    // Params 0, eflags: 0x0
    // Checksum 0xf8b46e77, Offset: 0x12b0
    // Size: 0x7c
    function constructor() {
        self.var_caa76426 = 1;
        self.var_ed97ef12 = 0;
        self.var_f4821922 = 0;
        self.var_6c8f4632 = 36;
        self.var_2269b061 = -128;
        self.var_bc6dcf34 = 72;
        self.var_c665189f = -128;
        self.var_352ef9 = &function_4cf916cc;
        self.var_1c709f79 = "Item";
    }

    // Namespace namespace_d63e16f5
    // Params 4, eflags: 0x0
    // Checksum 0x6eb896d7, Offset: 0x2188
    // Size: 0x168
    function spawn_interact_trigger(v_origin, n_radius, n_height, str_hint) {
        /#
            assert(isdefined(v_origin), "<unknown string>");
        #/
        /#
            assert(isdefined(n_radius), "<unknown string>");
        #/
        /#
            assert(isdefined(n_height), "<unknown string>");
        #/
        e_trigger = spawn("trigger_radius", v_origin, 0, n_radius, n_height);
        e_trigger triggerignoreteam();
        e_trigger setvisibletoall();
        e_trigger setteamfortrigger("none");
        e_trigger setcursorhint("HINT_NOICON");
        if (isdefined(str_hint)) {
            e_trigger sethintstring(str_hint);
        }
        return e_trigger;
    }

    // Namespace namespace_d63e16f5
    // Params 1, eflags: 0x0
    // Checksum 0x1ea0c7, Offset: 0x2118
    // Size: 0x68
    function function_89293eac(v_origin) {
        e_trigger = spawn_interact_trigger(v_origin, self.var_6c8f4632, self.var_2269b061, "");
        e_trigger sethintlowpriority(1);
        return e_trigger;
    }

    // Namespace namespace_d63e16f5
    // Params 1, eflags: 0x0
    // Checksum 0x9111d7ee, Offset: 0x20c0
    // Size: 0x4c
    function function_8da22d7f(v_origin) {
        var_f36962fb = spawn_interact_trigger(v_origin, self.var_bc6dcf34, self.var_c665189f, "Bring Toolbox to repair");
        return var_f36962fb;
    }

    // Namespace namespace_d63e16f5
    // Params 1, eflags: 0x0
    // Checksum 0x2f2e6149, Offset: 0x2048
    // Size: 0x6c
    function drop_on_death(e_triggerer) {
        self notify(#"drop_on_death");
        self endon(#"drop_on_death");
        e_triggerer util::waittill_any("player_downed", "death");
        if (isdefined(self.var_cc8132d)) {
            drop(e_triggerer);
        }
    }

    // Namespace namespace_d63e16f5
    // Params 0, eflags: 0x0
    // Checksum 0x3f68bc31, Offset: 0x2008
    // Size: 0x34
    function function_979623bc() {
        self endon(#"player_downed");
        while (self usebuttonpressed()) {
            wait(0.05);
        }
    }

    // Namespace namespace_d63e16f5
    // Params 0, eflags: 0x0
    // Checksum 0x7ecaf472, Offset: 0x1fc0
    // Size: 0x3e
    function function_c9dff8e3() {
        self endon(#"hash_3f7b661c");
        self.var_8407f02a = 1;
        self function_979623bc();
        var_8407f02a = undefined;
    }

    // Namespace namespace_d63e16f5
    // Params 0, eflags: 0x0
    // Checksum 0xe215b463, Offset: 0x1f40
    // Size: 0x78
    function destroy() {
        if (isdefined(self.var_cc8132d)) {
            function_e6fe8187(self.var_cc8132d);
            self.var_cc8132d util::function_79f9f98d();
        }
        if (isdefined(self.var_ce54c88c)) {
            self.var_ce54c88c delete();
        }
        self.var_cc8132d = undefined;
    }

    // Namespace namespace_d63e16f5
    // Params 1, eflags: 0x0
    // Checksum 0x46c8c2e1, Offset: 0x1eb8
    // Size: 0x7e
    function remove(e_triggerer) {
        function_e6fe8187(e_triggerer);
        e_triggerer util::function_79f9f98d();
        if (isdefined(self.var_ce54c88c)) {
            self.var_ce54c88c delete();
        }
        self.var_cc8132d = undefined;
        self notify(#"hash_f9bc44a3");
    }

    // Namespace namespace_d63e16f5
    // Params 1, eflags: 0x0
    // Checksum 0xbe645fbc, Offset: 0x1d80
    // Size: 0x12c
    function drop(e_triggerer) {
        function_e6fe8187(e_triggerer);
        e_triggerer util::function_79f9f98d();
        if (isdefined(self.var_ce54c88c)) {
            self.var_ce54c88c delete();
        }
        if (isdefined(self.var_c7279522)) {
            foreach (drop_func in self.var_c7279522) {
                [[ drop_func ]](e_triggerer);
            }
        }
        self.var_cc8132d = undefined;
        self thread function_a72a316b();
        e_triggerer thread function_c9dff8e3();
    }

    // Namespace namespace_d63e16f5
    // Params 1, eflags: 0x0
    // Checksum 0x578db70b, Offset: 0x1cf0
    // Size: 0x84
    function function_e6fe8187(e_triggerer) {
        e_triggerer endon(#"death");
        e_triggerer endon(#"player_downed");
        if (!e_triggerer.var_ca526183) {
            return;
        }
        e_triggerer notify(#"hash_e6fe8187");
        e_triggerer enableweapons();
        e_triggerer.var_ca526183 = 0;
        e_triggerer allowjump(1);
    }

    // Namespace namespace_d63e16f5
    // Params 1, eflags: 0x0
    // Checksum 0xb599f0f8, Offset: 0x1ac0
    // Size: 0x228
    function function_43cba6c4(e_triggerer) {
        e_triggerer endon(#"hash_e6fe8187");
        e_triggerer endon(#"death");
        e_triggerer endon(#"player_downed");
        var_b9f3ddcc = e_triggerer geteye();
        v_player_angles = e_triggerer getplayerangles();
        v_player_angles += self.var_db666eb1;
        v_player_angles = anglestoforward(v_player_angles);
        v_angles = e_triggerer.angles + self.var_af900c85;
        v_origin = var_b9f3ddcc + v_player_angles * self.var_2655604d;
        if (!isdefined(self.var_4f46ac84)) {
            if (isdefined(self.var_c65ad26d)) {
                self.var_4f46ac84 = self.var_c65ad26d;
            } else {
                self.var_4f46ac84 = "script_origin";
            }
        }
        self.var_ce54c88c = util::spawn_model(self.var_4f46ac84, v_origin, v_angles);
        self.var_ce54c88c notsolid();
        while (isdefined(self.var_ce54c88c)) {
            var_b9f3ddcc = e_triggerer geteye();
            v_player_angles = e_triggerer getplayerangles();
            v_player_angles += self.var_db666eb1;
            v_player_angles = anglestoforward(v_player_angles);
            self.var_ce54c88c.angles = e_triggerer.angles + self.var_af900c85;
            self.var_ce54c88c.origin = var_b9f3ddcc + v_player_angles * self.var_2655604d;
            wait(0.05);
        }
    }

    // Namespace namespace_d63e16f5
    // Params 1, eflags: 0x0
    // Checksum 0x44a73738, Offset: 0x1a00
    // Size: 0xb4
    function function_516d02e5(e_triggerer) {
        e_triggerer endon(#"hash_e6fe8187");
        e_triggerer endon(#"death");
        e_triggerer endon(#"player_downed");
        self thread drop_on_death(e_triggerer);
        while (e_triggerer usebuttonpressed()) {
            wait(0.05);
        }
        while (!e_triggerer usebuttonpressed()) {
            wait(0.05);
        }
        self thread drop(e_triggerer);
    }

    // Namespace namespace_d63e16f5
    // Params 1, eflags: 0x0
    // Checksum 0x20051ae, Offset: 0x19c0
    // Size: 0x34
    function function_53a994b(player) {
        player notify(#"hash_8d73907f");
        player util::function_79f9f98d();
    }

    // Namespace namespace_d63e16f5
    // Params 1, eflags: 0x0
    // Checksum 0x2bef749c, Offset: 0x1938
    // Size: 0x80
    function function_7ddfdcb4(player) {
        self endon(#"death");
        player endon(#"death");
        player endon(#"hash_8d73907f");
        while (true) {
            player util::function_67cfce72(function_5d22fd8a(), undefined, undefined, 0, 0.35);
            wait(0.35);
        }
    }

    // Namespace namespace_d63e16f5
    // Params 1, eflags: 0x0
    // Checksum 0x61ec9e7d, Offset: 0x18f8
    // Size: 0x34
    function function_3bbb0063(player) {
        player util::function_67cfce72(function_5d22fd8a());
    }

    // Namespace namespace_d63e16f5
    // Params 0, eflags: 0x0
    // Checksum 0x24eecae5, Offset: 0x18d8
    // Size: 0x14
    function function_5d22fd8a() {
        return "Press ^3[{+usereload}]^7 to drop " + self.var_1c709f79;
    }

    // Namespace namespace_d63e16f5
    // Params 1, eflags: 0x0
    // Checksum 0xe4f384fb, Offset: 0x1758
    // Size: 0x174
    function carry(e_triggerer) {
        e_triggerer endon(#"death");
        e_triggerer endon(#"player_downed");
        e_triggerer.var_11120dca = self;
        self.var_cc8132d = e_triggerer;
        self.var_52e14d7c notify(#"hash_4e236be4", 0);
        self notify(#"hash_2f46dd38");
        e_triggerer disableweapons();
        wait(0.5);
        if (isdefined(self.var_5c6e11a4)) {
            foreach (var_f9c63f75 in self.var_5c6e11a4) {
                self thread [[ var_f9c63f75 ]](e_triggerer);
            }
        } else {
            e_triggerer allowjump(0);
        }
        self thread function_3bbb0063(e_triggerer);
        self thread function_43cba6c4(e_triggerer);
        self thread function_516d02e5(e_triggerer);
    }

    // Namespace namespace_d63e16f5
    // Params 0, eflags: 0x0
    // Checksum 0xbd8cc8f3, Offset: 0x1570
    // Size: 0x1da
    function function_a72a316b() {
        self notify(#"hash_a72a316b");
        self endon(#"hash_a72a316b");
        self endon(#"unmake");
        while (true) {
            wait(0.05);
            if (!isdefined(self.var_52e14d7c)) {
                return;
            }
            e_triggerer = self.var_52e14d7c waittill(#"trigger");
            if (isdefined(e_triggerer.var_ca526183) && e_triggerer.var_ca526183) {
                self.var_52e14d7c sethintstringforplayer(e_triggerer, "");
                continue;
            }
            if (!self.var_f4821922) {
                continue;
            }
            if (isdefined(e_triggerer.var_8407f02a) && e_triggerer.var_8407f02a) {
                continue;
            }
            if (!e_triggerer util::use_button_held()) {
                continue;
            }
            if (isdefined(self.var_f83480ac) && ![[ self.var_f83480ac ]]()) {
                continue;
            }
            if (!isdefined(self.var_52e14d7c)) {
                return;
            }
            if (!e_triggerer istouching(self.var_52e14d7c)) {
                continue;
            }
            if (isdefined(e_triggerer.var_ca526183) && e_triggerer.var_ca526183) {
                continue;
            }
            if (e_triggerer laststand::player_is_in_laststand()) {
                continue;
            }
            e_triggerer.var_ca526183 = 1;
            self thread carry(e_triggerer);
            return;
        }
    }

    // Namespace namespace_d63e16f5
    // Params 0, eflags: 0x0
    // Checksum 0xbae3018c, Offset: 0x1548
    // Size: 0x1e
    function function_e57a30c3() {
        self.var_f4821922 = 0;
        self notify(#"hash_a72a316b");
    }

    // Namespace namespace_d63e16f5
    // Params 0, eflags: 0x0
    // Checksum 0x35dfcf4f, Offset: 0x1518
    // Size: 0x24
    function function_4cfc5130() {
        self.var_f4821922 = 1;
        self thread function_a72a316b();
    }

    // Namespace namespace_d63e16f5
    // Params 1, eflags: 0x0
    // Checksum 0xe5f1bd89, Offset: 0x14d8
    // Size: 0x38
    function function_2180809b(e_trigger) {
        /#
            assert(!isdefined(self.var_52e14d7c));
        #/
        self.var_52e14d7c = e_trigger;
    }

    // Namespace namespace_d63e16f5
    // Params 0, eflags: 0x0
    // Checksum 0xebaebeff, Offset: 0x1418
    // Size: 0xb8
    function function_b718b73f() {
        self endon(#"unmake");
        while (true) {
            player = self.var_52e14d7c waittill(#"trigger");
            if (isdefined(player.var_ca526183) && player.var_ca526183 && player.var_11120dca.var_1c709f79 == "Toolbox") {
                [[ player.var_11120dca ]]->remove(player);
                [[ self.var_352ef9 ]](player);
            }
            wait(0.05);
        }
    }

    // Namespace namespace_d63e16f5
    // Params 1, eflags: 0x0
    // Checksum 0x602ac1cf, Offset: 0x13d0
    // Size: 0x3c
    function function_4cf916cc(player) {
        self notify(#"hash_4cf916cc");
        if (isdefined(self.var_9c969a83)) {
            self thread [[ self.var_9c969a83 ]](player);
        }
    }

    // Namespace namespace_d63e16f5
    // Params 0, eflags: 0x0
    // Checksum 0xabdbaa18, Offset: 0x1350
    // Size: 0x74
    function function_ca929547() {
        if (isdefined(self.var_ecab686c)) {
            self thread [[ self.var_ecab686c ]]();
            return;
        }
        while (isdefined(self.var_52e14d7c)) {
            if (!self.var_caa76426) {
                self.var_52e14d7c sethintstring("Bring Toolbox to repair");
                wait(0.05);
                continue;
            }
            wait(0.05);
        }
    }

    // Namespace namespace_d63e16f5
    // Params 0, eflags: 0x0
    // Checksum 0x70dd5230, Offset: 0x1338
    // Size: 0xa
    function function_7dc67c6() {
        return self.var_cc8132d;
    }

}

