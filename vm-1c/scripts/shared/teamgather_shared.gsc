#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/doors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_8e0c9c8f;

// Namespace namespace_8e0c9c8f
// Method(s) 29 Total 29
class class_c164643e {

    var var_463cf559;

    // Namespace namespace_c164643e
    // Params 0, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_9b385ca5
    // Checksum 0x582a1c21, Offset: 0x590
    // Size: 0x74
    function constructor() {
        self.e_gameobject = undefined;
        self.var_58308c20 = 2;
        self.var_8b14783f = (1, 1, 1);
        self.var_88796c43 = 0;
        self.var_352f3198 = 0;
        self.var_9166aa4c = 0;
        self.var_97e89e39 = undefined;
        self.var_88796c43 = 0;
        self.var_551fe492 = 0;
    }

    // Namespace namespace_c164643e
    // Params 0, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_df2cf6ef
    // Checksum 0xef59db9b, Offset: 0x25e0
    // Size: 0xa4
    function function_df2cf6ef() {
        a_players = [];
        var_a0561c95 = getplayers();
        for (i = 0; i < var_a0561c95.size; i++) {
            e_player = var_a0561c95[i];
            if (e_player.sessionstate == "playing") {
                a_players[a_players.size] = e_player;
            }
        }
        return a_players;
    }

    // Namespace namespace_c164643e
    // Params 0, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_c6f593e0
    // Checksum 0xd67c85d1, Offset: 0x2540
    // Size: 0x98
    function function_c6f593e0() {
        time_remaining = int(function_26ebee10());
        time_remaining += 1;
        if (time_remaining > 10) {
            time_remaining = 10;
        }
        if (time_remaining > 10) {
            time_remaining = 10;
        } else if (time_remaining < 1) {
            time_remaining = 1;
        }
        return time_remaining;
    }

    // Namespace namespace_c164643e
    // Params 0, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_26ebee10
    // Checksum 0x6028b0f7, Offset: 0x24d0
    // Size: 0x62
    function function_26ebee10() {
        time = gettime();
        dt = (time - self.e_gameobject.start_time) / 1000;
        time_remaining = self.e_gameobject.total_time - dt;
        return time_remaining;
    }

    // Namespace namespace_c164643e
    // Params 1, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_a650579b
    // Checksum 0x893d1dff, Offset: 0x2490
    // Size: 0x34
    function function_a650579b(total_time) {
        self.e_gameobject.start_time = gettime();
        self.e_gameobject.total_time = total_time;
    }

    // Namespace namespace_c164643e
    // Params 9, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_f5a9ba65
    // Checksum 0xe2b8f3ae, Offset: 0x22d8
    // Size: 0x1b0
    function function_f5a9ba65(alignx, aligny, horzalign, vertalign, xoffset, yoffset, fontscale, color, str_text) {
        hud_elem = newclienthudelem(self);
        hud_elem.elemtype = "font";
        hud_elem.font = "objective";
        hud_elem.alignx = alignx;
        hud_elem.aligny = aligny;
        hud_elem.horzalign = horzalign;
        hud_elem.vertalign = vertalign;
        hud_elem.x += xoffset;
        hud_elem.y += yoffset;
        hud_elem.foreground = 1;
        hud_elem.fontscale = fontscale;
        hud_elem.alpha = 1;
        hud_elem.color = color;
        hud_elem.hidewheninmenu = 1;
        hud_elem settext(str_text);
        return hud_elem;
    }

    // Namespace namespace_c164643e
    // Params 1, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_8facc748
    // Checksum 0x9b300d72, Offset: 0x1ea8
    // Size: 0x424
    function function_8facc748(e_player) {
        e_player endon(#"disconnect");
        var_2feafad7 = -76;
        var_9bce0ee1 = 0;
        var_9d21dc7c = var_2feafad7;
        var_79a345fb = e_player function_f5a9ba65("center", "middle", "center", "top", var_9bce0ee1, var_9d21dc7c, self.var_58308c20, self.var_8b14783f, "");
        var_79a345fb settext(%TEAM_GATHER_PLAYER_STARTING_EVENT, self.var_c79b817a);
        var_9bce0ee1 = -118;
        var_9d21dc7c = var_2feafad7 + 40;
        var_2f2b830d = e_player function_f5a9ba65("left", "middle", "center", "top", var_9bce0ee1, var_9d21dc7c, self.var_58308c20, self.var_8b14783f, "");
        var_9bce0ee1 = 54;
        var_9d21dc7c = var_2feafad7 + 40;
        var_81ab2919 = e_player function_f5a9ba65("left", "middle", "center", "top", var_9bce0ee1, var_9d21dc7c, self.var_58308c20, self.var_8b14783f, "");
        var_9bce0ee1 = 0;
        var_9d21dc7c = var_2feafad7 + 80;
        var_e402428d = e_player function_f5a9ba65("center", "middle", "center", "top", var_9bce0ee1, var_9d21dc7c, self.var_58308c20, self.var_8b14783f, "");
        var_fa37b4c3 = array("0", %TEAM_GATHER_START_IN_1, %TEAM_GATHER_START_IN_2, %TEAM_GATHER_START_IN_3, %TEAM_GATHER_START_IN_4, %TEAM_GATHER_START_IN_5, %TEAM_GATHER_START_IN_6, %TEAM_GATHER_START_IN_7, %TEAM_GATHER_START_IN_8, %TEAM_GATHER_START_IN_9, %TEAM_GATHER_START_IN_10);
        while (!function_4e2f7254()) {
            var_2f2b830d settext(%TEAM_GATHER_NUM_PLAYERS, int(self.var_9166aa4c), int(self.var_352f3198));
            time_remaining = function_c6f593e0();
            var_81ab2919 settext(var_fa37b4c3[time_remaining]);
            if (isdefined(e_player.var_392a9880) && e_player.var_392a9880) {
                var_e402428d settext("");
            } else {
                var_e402428d settext(%TEAM_GATHER_HOLD_TO_GO_NOW);
            }
            wait(0.05);
        }
        var_79a345fb destroy();
        var_2f2b830d destroy();
        var_81ab2919 destroy();
        var_e402428d destroy();
    }

    // Namespace namespace_c164643e
    // Params 1, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_7451b38f
    // Checksum 0x5a0c539c, Offset: 0x1bb0
    // Size: 0x2ec
    function function_7451b38f(e_player) {
        e_player endon(#"disconnect");
        var_2feafad7 = -76;
        var_9bce0ee1 = 0;
        var_9d21dc7c = var_2feafad7;
        var_6780bff4 = e_player function_f5a9ba65("center", "middle", "center", "top", var_9bce0ee1, var_9d21dc7c, self.var_58308c20, self.var_8b14783f, %TEAM_GATHER_TEAM_STEALTH_ENTER);
        var_9bce0ee1 = 0;
        var_9d21dc7c = var_2feafad7 + 100;
        var_29a6199e = e_player function_f5a9ba65("center", "middle", "center", "top", var_9bce0ee1, var_9d21dc7c, self.var_58308c20, self.var_8b14783f, "");
        var_9bce0ee1 = -45;
        var_9d21dc7c = var_2feafad7 + -126;
        var_6b6fe792 = e_player function_f5a9ba65("left", "middle", "center", "top", var_9bce0ee1, var_9d21dc7c, self.var_58308c20, self.var_8b14783f, "");
        var_8ee8faf7 = array("0", %TEAM_GATHER_TIME_REMAINING_1, %TEAM_GATHER_TIME_REMAINING_2, %TEAM_GATHER_TIME_REMAINING_3, %TEAM_GATHER_TIME_REMAINING_4, %TEAM_GATHER_TIME_REMAINING_5, %TEAM_GATHER_TIME_REMAINING_6, %TEAM_GATHER_TIME_REMAINING_7, %TEAM_GATHER_TIME_REMAINING_8, %TEAM_GATHER_TIME_REMAINING_9, %TEAM_GATHER_TIME_REMAINING_10);
        while (!function_4e2f7254()) {
            var_29a6199e settext(%TEAM_GATHER_PLAYERS_READY, self.var_9166aa4c, self.var_352f3198);
            time_remaining = function_c6f593e0();
            var_6b6fe792 settext(var_8ee8faf7[time_remaining]);
            wait(0.05);
        }
        var_6780bff4 destroy();
        var_29a6199e destroy();
        var_6b6fe792 destroy();
    }

    // Namespace namespace_c164643e
    // Params 1, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_a35ad84d
    // Checksum 0xd45779a8, Offset: 0x1850
    // Size: 0x354
    function function_a35ad84d(e_player) {
        a_players = function_df2cf6ef();
        while (true) {
            x_offset = randomfloatrange((-46 - 42) * -1, -46 - 42);
            y_offset = randomfloatrange((-46 - 42) * -1, -46 - 42);
            e_player.var_7b9bb893 = (self.var_f27d9ff9[0] + x_offset, self.var_f27d9ff9[1] + y_offset, self.var_f27d9ff9[2]);
            reject = 0;
            for (i = 0; i < a_players.size; i++) {
                if (e_player != a_players[i]) {
                    dist = distance2d(e_player.origin, a_players[i].origin);
                    if (dist < 84) {
                        reject = 1;
                        break;
                    }
                }
            }
            if (!reject) {
                v_forward = anglestoforward(self.var_d97afe29);
                v_dir = vectornormalize(e_player.var_7b9bb893 - self.var_cb45be0);
                dp = vectordot(v_forward, v_dir);
                if (dp > -0.5) {
                    reject = 1;
                }
            }
            if (reject) {
                break;
            }
            if (!positionwouldtelefrag(e_player.var_7b9bb893)) {
                break;
            }
        }
        e_player setorigin(e_player.var_7b9bb893);
        var_b6c055a3 = (self.var_cb45be0[0], self.var_cb45be0[1], self.var_cb45be0[2]);
        v1 = (e_player.var_7b9bb893[0], e_player.var_7b9bb893[1], self.var_cb45be0[2]);
        v_dir = vectornormalize(var_b6c055a3 - v1);
        v_angles = vectortoangles(v_dir);
        e_player setplayerangles(v_angles);
    }

    // Namespace namespace_c164643e
    // Params 1, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_4c4c18b
    // Checksum 0xc6eaad37, Offset: 0x1808
    // Size: 0x3c
    function function_4c4c18b(e_player) {
        if (e_player usebuttonpressed()) {
            function_a35ad84d(e_player);
        }
    }

    // Namespace namespace_c164643e
    // Params 1, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_41ba5350
    // Checksum 0x492ec5ea, Offset: 0x1788
    // Size: 0x74
    function function_41ba5350(var_dc4f7447) {
        if (var_dc4f7447) {
            if (self util::function_31827fe8()) {
                self util::function_f9e9f0f0();
            }
            return;
        }
        if (!self util::function_31827fe8()) {
            self util::function_ee182f5d();
        }
    }

    // Namespace namespace_c164643e
    // Params 1, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_f1c7b863
    // Checksum 0x7a97be5a, Offset: 0x15c8
    // Size: 0x1b2
    function function_f1c7b863(e_player) {
        var_10ecfd0d = 1;
        n_dist = distance2d(e_player.origin, self.var_f27d9ff9);
        if (n_dist > -46) {
            var_10ecfd0d = 0;
        } else {
            v_start_pos = (e_player.origin[0], e_player.origin[1], e_player.origin[2] + 32);
            v_end_pos = (self.var_f27d9ff9[0], self.var_f27d9ff9[1], self.var_f27d9ff9[2]);
            if (e_player.origin[2] - v_end_pos[2] < -64) {
                var_10ecfd0d = 0;
            }
            v_trace = bullettrace(v_start_pos, v_end_pos, 0, undefined);
            v_trace_pos = v_trace["position"];
            dz = abs(v_trace_pos[2] - self.var_f27d9ff9[2]);
            if (dz > 64) {
                var_10ecfd0d = 0;
            }
        }
        return var_10ecfd0d;
    }

    // Namespace namespace_c164643e
    // Params 1, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_a08ae386
    // Checksum 0x82001d62, Offset: 0x1408
    // Size: 0x1b6
    function function_a08ae386(var_7e0ac2e7) {
        a_players = function_df2cf6ef();
        self.var_352f3198 = a_players.size;
        for (i = 0; i < a_players.size; i++) {
            a_players[i].var_392a9880 = undefined;
        }
        self.var_9166aa4c = 0;
        for (i = 0; i < a_players.size; i++) {
            e_player = a_players[i];
            e_player.var_392a9880 = function_f1c7b863(e_player);
            if (isdefined(var_7e0ac2e7) && var_7e0ac2e7 && !(isdefined(e_player.var_392a9880) && e_player.var_392a9880)) {
                function_a35ad84d(e_player);
            }
            if (isdefined(e_player.var_392a9880) && e_player.var_392a9880) {
                e_player function_41ba5350(1);
                self.var_9166aa4c++;
                continue;
            }
            e_player function_41ba5350(0);
            if (e_player != self.var_c79b817a) {
                function_4c4c18b(e_player);
            }
        }
    }

    // Namespace namespace_c164643e
    // Params 1, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_bfc58301
    // Checksum 0x2f62d74e, Offset: 0x1370
    // Size: 0x8c
    function function_bfc58301(in_position) {
        if (isdefined(in_position) && in_position) {
            if (!isdefined(self.var_463cf559)) {
                self.var_463cf559 = gettime();
            }
            time = gettime();
            dt = (time - self.var_463cf559) / 1000;
            if (dt >= 0) {
                return true;
            }
        } else {
            var_463cf559 = undefined;
        }
        return false;
    }

    // Namespace namespace_c164643e
    // Params 0, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_d8ac3b5b
    // Checksum 0xa39f96af, Offset: 0x1170
    // Size: 0x1f2
    function function_d8ac3b5b() {
        while (!function_4e2f7254()) {
            function_a08ae386(0);
            if (self.var_9166aa4c == 0) {
                function_b8c81ff2(0);
                break;
            }
            if (self.var_352f3198 > 0 && self.var_9166aa4c >= self.var_352f3198) {
                if (function_bfc58301(1)) {
                    function_b8c81ff2(1);
                    break;
                }
            } else {
                function_bfc58301(0);
            }
            time_remaining = function_26ebee10();
            if (time_remaining <= 0) {
                function_b8c81ff2(1);
                break;
            }
            wait(0.05);
        }
        if (self.var_551fe492 == 1) {
            function_a08ae386(1);
        }
        a_players = function_df2cf6ef();
        for (i = 0; i < a_players.size; i++) {
            e_player = a_players[i];
            if (isdefined(e_player.var_392a9880) && e_player.var_392a9880) {
                e_player util::function_ee182f5d();
            }
            e_player.var_392a9880 = undefined;
        }
        return self.var_551fe492;
    }

    // Namespace namespace_c164643e
    // Params 1, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_b8c81ff2
    // Checksum 0x84696ff8, Offset: 0x1140
    // Size: 0x24
    function function_b8c81ff2(success) {
        self.var_88796c43 = 1;
        self.var_551fe492 = success;
    }

    // Namespace namespace_c164643e
    // Params 0, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_4e2f7254
    // Checksum 0x6902c4b5, Offset: 0x1128
    // Size: 0xa
    function function_4e2f7254() {
        return self.var_88796c43;
    }

    // Namespace namespace_c164643e
    // Params 0, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_97102848
    // Checksum 0xde8e0f5f, Offset: 0x1060
    // Size: 0xbe
    function function_97102848() {
        a_players = function_df2cf6ef();
        if (a_players.size <= 1) {
            return;
        }
        for (i = 0; i < a_players.size; i++) {
            e_player = a_players[i];
            if (e_player == self.var_c79b817a) {
                self thread function_7451b38f(e_player);
                continue;
            }
            self thread function_8facc748(e_player);
        }
    }

    // Namespace namespace_c164643e
    // Params 0, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_2577197
    // Checksum 0x4bc46af0, Offset: 0x1008
    // Size: 0x4c
    function function_2577197() {
        function_a650579b(10);
        function_97102848();
        b_success = function_d8ac3b5b();
        return b_success;
    }

    // Namespace namespace_c164643e
    // Params 1, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_e2cd815e
    // Checksum 0xea81b126, Offset: 0xf88
    // Size: 0x74
    function function_e2cd815e(var_2700658f) {
        if (isdefined(self.var_525802a7)) {
            if (isdefined(var_2700658f) && var_2700658f) {
                self.var_525802a7 clientfield::set("teamgather_material", 1);
                return;
            }
            self.var_525802a7 clientfield::set("teamgather_material", 0);
        }
    }

    // Namespace namespace_c164643e
    // Params 0, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_12bb2630
    // Checksum 0x9ab9bf60, Offset: 0xf38
    // Size: 0x48
    function function_12bb2630() {
        if (!(isdefined(0) && 0)) {
            return;
        }
        if (isdefined(self.var_97e89e39)) {
            self.var_97e89e39 delete();
            self.var_97e89e39 = undefined;
        }
    }

    // Namespace namespace_c164643e
    // Params 0, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_410a6547
    // Checksum 0xd8e157f3, Offset: 0xe20
    // Size: 0x10c
    function function_410a6547() {
        if (!(isdefined(0) && 0)) {
            return;
        }
        v_pos = self.var_f27d9ff9;
        v_start = (v_pos[0], v_pos[1], v_pos[2] + 20);
        v_end = (v_pos[0], v_pos[1], v_pos[2] - 94);
        trace = bullettrace(v_start, v_end, 0, undefined);
        var_385f2bd = trace["position"];
        self.var_97e89e39 = spawnfx("_t6/misc/fx_ui_flagbase_pmc", var_385f2bd);
        triggerfx(self.var_97e89e39);
    }

    // Namespace namespace_c164643e
    // Params 1, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_339c6254
    // Checksum 0xb2fa7dc5, Offset: 0xde8
    // Size: 0x2e
    function function_339c6254(player) {
        self.var_450b6a55.var_c79b817a = player;
        self notify(#"hash_256742bb");
    }

    // Namespace namespace_c164643e
    // Params 4, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_4b53c3c4
    // Checksum 0xaaac6ce8, Offset: 0xa78
    // Size: 0x368
    function function_4b53c3c4(v_pos, str_model, var_3764261a, var_26abb593) {
        n_radius = 48;
        e_trigger = spawn("trigger_radius_use", v_pos, 0, n_radius, 30);
        e_trigger triggerignoreteam();
        e_trigger setvisibletoall();
        e_trigger setteamfortrigger("none");
        e_trigger usetriggerrequirelookat();
        e_trigger setcursorhint("HINT_NOICON");
        var_8879551d = (0, 0, 0);
        if (isdefined(str_model)) {
            var_cbf03a71[0] = spawn("script_model", v_pos + var_8879551d);
            var_cbf03a71[0] setmodel(str_model);
        } else {
            var_cbf03a71 = [];
        }
        var_63ec40bb = undefined;
        var_e51b2d2d = "allies";
        var_f0367d9a = e_trigger;
        var_4a284043 = (0, 0, -5);
        e_object = gameobjects::create_use_object(var_e51b2d2d, var_f0367d9a, var_cbf03a71, var_4a284043, var_63ec40bb);
        e_object gameobjects::allow_use("any");
        e_object gameobjects::set_use_time(0);
        e_object gameobjects::set_use_text("");
        e_object gameobjects::set_use_hint_text(var_3764261a);
        e_object gameobjects::set_visible_team("any");
        e_object.onuse = &function_339c6254;
        e_object gameobjects::set_3d_icon("friendly", "T7_hud_prompt_press_64");
        e_object gameobjects::set_3d_icon("enemy", "T7_hud_prompt_press_64");
        e_object gameobjects::set_2d_icon("friendly", "T7_hud_prompt_press_64");
        e_object gameobjects::set_2d_icon("enemy", "T7_hud_prompt_press_64");
        e_object thread gameobjects::function_e0e2d0fe((1, 1, 1), 840, 1, var_26abb593);
        return e_object;
    }

    // Namespace namespace_c164643e
    // Params 0, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_eb461ebc
    // Checksum 0x577e6d7d, Offset: 0x930
    // Size: 0x13e
    function function_eb461ebc() {
        var_9bce0ee1 = 0;
        var_9d21dc7c = -76;
        a_players = function_df2cf6ef();
        for (i = 0; i < a_players.size; i++) {
            e_player = a_players[i];
            e_player.var_65930d27 = e_player function_f5a9ba65("center", "middle", "center", "top", var_9bce0ee1, var_9d21dc7c, self.var_58308c20, self.var_8b14783f, %TEAM_GATHER_TEAM_EVENT_ABORTED);
        }
        wait(0);
        for (i = 0; i < a_players.size; i++) {
            e_player = a_players[i];
            e_player.var_65930d27 destroy();
        }
    }

    // Namespace namespace_c164643e
    // Params 0, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_6bf5c5db
    // Checksum 0xc0fe96ea, Offset: 0x7e0
    // Size: 0x146
    function function_6bf5c5db() {
        if (0 > 0) {
            var_9bce0ee1 = 0;
            var_9d21dc7c = -76;
            a_players = function_df2cf6ef();
            for (i = 0; i < a_players.size; i++) {
                e_player = a_players[i];
                e_player.var_639d6222 = e_player function_f5a9ba65("center", "middle", "center", "top", var_9bce0ee1, var_9d21dc7c, self.var_58308c20, self.var_8b14783f, %TEAM_GATHER_GATHER_SUCCESS);
            }
            wait(0);
            for (i = 0; i < a_players.size; i++) {
                e_player = a_players[i];
                e_player.var_639d6222 destroy();
            }
        }
    }

    // Namespace namespace_c164643e
    // Params 4, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_96944ac3
    // Checksum 0x88adeee4, Offset: 0x660
    // Size: 0x178
    function function_96944ac3(var_dca393d5, var_14428255, var_320d982, var_df688ed3) {
        self.var_cb45be0 = var_dca393d5;
        self.var_d97afe29 = var_14428255;
        self.var_525802a7 = var_df688ed3;
        self.var_f27d9ff9 = var_320d982;
        self.e_gameobject = function_4b53c3c4(var_dca393d5, undefined, %TEAM_GATHER_HOLD_FOR_TEAM_ENTER, self.var_525802a7);
        self.e_gameobject.var_450b6a55 = self;
        self.e_gameobject waittill(#"hash_256742bb");
        self.e_gameobject gameobjects::disable_object();
        function_410a6547();
        function_e2cd815e(1);
        b_success = function_2577197();
        function_12bb2630();
        function_e2cd815e(0);
        if (isdefined(b_success) && b_success) {
            function_6bf5c5db();
        } else {
            function_eb461ebc();
        }
        return b_success;
    }

    // Namespace namespace_c164643e
    // Params 0, eflags: 0x1 linked
    // namespace_c164643e<file_0>::function_32e49d5b
    // Checksum 0xfcafa201, Offset: 0x620
    // Size: 0x34
    function cleanup() {
        function_12bb2630();
        self.e_gameobject gameobjects::destroy_object(1, 1);
    }

}

// Namespace namespace_8e0c9c8f
// Params 3, eflags: 0x0
// namespace_8e0c9c8f<file_0>::function_cefe00a9
// Checksum 0x1e8f92ba, Offset: 0x2c30
// Size: 0x1c4
function function_cefe00a9(var_dca393d5, var_14428255, var_df688ed3) {
    v_forward = anglestoforward(var_14428255);
    var_320d982 = var_dca393d5 + v_forward * -100;
    v_start = (var_320d982[0], var_320d982[1], var_320d982[2] + 20);
    v_end = (var_320d982[0], var_320d982[1], var_320d982[2] - 100);
    v_trace = bullettrace(v_start, v_end, 0, undefined);
    var_385f2bd = v_trace["position"];
    var_320d982 = (var_320d982[0], var_320d982[1], var_385f2bd[2] + 10);
    var_450b6a55 = new class_c164643e();
    success = [[ var_450b6a55 ]]->function_96944ac3(var_dca393d5, var_14428255, var_320d982, var_df688ed3);
    if (success) {
        e_player = var_450b6a55.var_c79b817a;
    } else {
        e_player = undefined;
    }
    [[ var_450b6a55 ]]->cleanup();
    return e_player;
}

// Namespace namespace_8e0c9c8f
// Params 2, eflags: 0x0
// namespace_8e0c9c8f<file_0>::function_a8111e80
// Checksum 0xe9e65ecd, Offset: 0x2e00
// Size: 0x68
function function_a8111e80(v1, v2) {
    level notify(#"hash_62ab67ff");
    self endon(#"hash_62ab67ff");
    while (true) {
        /#
            line(v1, v2, (0, 0, 1));
        #/
        wait(0.1);
    }
}

