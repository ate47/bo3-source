#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_fate;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/system_shared;

#namespace namespace_2f63e553;

// Namespace namespace_2f63e553
// Params 0, eflags: 0x0
// Checksum 0x9df719d3, Offset: 0x638
// Size: 0x1cd
function function_40206fdf() {
    level endon(#"hash_1684cf71");
    for (;;) {
        if (true) {
            
        }
        player = getplayers()[0];
        wait 0.05;
        if (level.debugCamera != 1 || !isdefined(player)) {
            break;
        }
    }
    InvalidOpCode(0xc1, 22, randomint(-1));
    // Unknown operator (0xc1, t7_1b, PC)
}

// Namespace namespace_2f63e553
// Params 0, eflags: 0x0
// Checksum 0x7092ea6e, Offset: 0x810
// Size: 0xa3
function function_35d58a26() {
    while (doa_player_utility::function_5eb6e4d1().size == 0) {
        wait 0.05;
    }
    namespace_49107f3a::debugmsg("Hail to the King baby!");
    foreach (player in doa_player_utility::function_5eb6e4d1()) {
        player thread function_92c840a6(1);
    }
}

// Namespace namespace_2f63e553
// Params 0, eflags: 0x0
// Checksum 0x8ddc7c11, Offset: 0x8c0
// Size: 0x3a2
function setupdevgui() {
    /#
        execdevgui("<dev string:x28>");
        level thread function_c18f4e35();
        level thread function_40206fdf();
        level.debugCamera = 0;
        level.fixCameraOn = 0;
        level.doa.var_e5a69065 = 0;
        var_fcdf780c = "<dev string:x41>";
        index = 1;
        var_9ba2319f = index;
        var_9c0bafd1 = level.doa.rules.var_88c0b67b;
        foreach (arena in level.doa.arenas) {
            if (isdefined(arena.var_63b4dab3) && arena.var_63b4dab3) {
                continue;
            }
            name = arena.name + "<dev string:x61>" + var_9ba2319f + "<dev string:x65>" + var_9c0bafd1 + "<dev string:x67>" + index;
            index++;
            cmd = var_fcdf780c + name + "<dev string:x6b>" + arena.name + "<dev string:x97>";
            adddebugcommand(cmd);
            var_9ba2319f += level.doa.rules.var_88c0b67b;
            var_9c0bafd1 += level.doa.rules.var_88c0b67b;
        }
        InvalidOpCode(0xc9);
        // Unknown operator (0xc9, t7_1b, PC)
    #/
    if (getdvarint("scr_doa_kingme_soak_think", 0)) {
        setdvar("scr_doa_kingme_soak_think", 0);
        setdvar("scr_doa_soak_think", 1);
        level thread function_35d58a26();
    }
    if (getdvarint("scr_doa_soak_think", 0) && !(isdefined(level.var_1575b6db) && level.var_1575b6db)) {
        level thread function_a3bba13d();
    }
}

// Namespace namespace_2f63e553
// Params 1, eflags: 0x0
// Checksum 0xac229eb5, Offset: 0xc70
// Size: 0xc1
function function_92c840a6(delay) {
    if (!isdefined(delay)) {
        delay = 0.1;
    }
    self notify(#"hash_92c840a6");
    self endon(#"hash_92c840a6");
    self endon(#"disconnect");
    wait delay;
    while (true) {
        if (self.doa.lives <= 3) {
            self.doa.lives = 9;
        }
        if (self.doa.bombs <= 1) {
            self.doa.bombs = 9;
        }
        if (self.doa.var_c5e98ad6 <= 1) {
            self.doa.var_c5e98ad6 = 9;
        }
        wait 0.05;
    }
}

// Namespace namespace_2f63e553
// Params 1, eflags: 0x0
// Checksum 0x4d1bfb0d, Offset: 0xd40
// Size: 0x1ba
function function_a4d5519a(pickup) {
    self endon(#"disconnect");
    pickup endon(#"death");
    wait randomfloatrange(0.1, 1);
    if (self isinmovemode("ufo", "noclip")) {
        return;
    }
    level thread namespace_49107f3a::debug_circle(pickup.origin + (0, 0, 20), 30, 3, doa_player_utility::function_fea7ed75(self.entnum));
    level thread namespace_49107f3a::debug_line(self.origin + (0, 0, 20), pickup.origin + (0, 0, 20), 3, doa_player_utility::function_fea7ed75(self.entnum));
    yaw = namespace_49107f3a::function_fa8a86e8(self, pickup);
    if (!isdefined(yaw)) {
        return;
    }
    angles = (0, yaw, 0);
    self setplayerangles(angles);
    wait 2;
    yaw = namespace_49107f3a::function_fa8a86e8(self, pickup);
    if (!isdefined(yaw)) {
        return;
    }
    angles = (0, yaw, 0);
    self setplayerangles(angles);
    self.doa.var_3be905bb = 1;
    namespace_49107f3a::debugmsg("Bot is boosting at pickup:" + pickup.def.var_bcc88c39 + ".  Boosts Left:" + self.doa.var_c5e98ad6);
}

// Namespace namespace_2f63e553
// Params 0, eflags: 0x0
// Checksum 0x9fcb758a, Offset: 0xf08
// Size: 0xdd
function function_733651c() {
    self endon(#"disconnect");
    self notify(#"hash_733651c");
    self endon(#"hash_733651c");
    level endon(#"hash_e20ba07c");
    while (true) {
        if (isdefined(self.doa.var_c5e98ad6) && self.doa.var_c5e98ad6) {
            var_6792dc08 = getentarray("a_pickup_item", "script_noteworthy");
            if (var_6792dc08.size > 0) {
                var_a49668c4 = var_6792dc08[randomint(var_6792dc08.size)];
            }
            if (isdefined(var_a49668c4) && isdefined(var_a49668c4.trigger)) {
                self thread function_a4d5519a(var_a49668c4);
            }
        }
        wait randomint(10);
    }
}

// Namespace namespace_2f63e553
// Params 0, eflags: 0x0
// Checksum 0x90963b1c, Offset: 0xff0
// Size: 0x3a
function function_7abdb1e8() {
    level notify(#"hash_7abdb1e8");
    level endon(#"hash_7abdb1e8");
    level waittill(#"hash_e20ba07c");
    level.var_1575b6db = 0;
    namespace_49107f3a::debugmsg("DOA Soak Test [OFF]");
}

// Namespace namespace_2f63e553
// Params 0, eflags: 0x0
// Checksum 0xd7800dae, Offset: 0x1038
// Size: 0x501
function function_a3bba13d() {
    level notify(#"hash_a3bba13d");
    level endon(#"hash_a3bba13d");
    level endon(#"hash_e20ba07c");
    botcount = 0;
    level thread function_7abdb1e8();
    level.var_1575b6db = 1;
    namespace_49107f3a::debugmsg("DOA Soak Test [ON]");
    adddebugcommand("set bot_AllowMovement 0; set bot_PressAttackBtn 1; set bot_PressMeleeBtn 0; set scr_botsAllowKillstreaks 0; set bot_AllowGrenades 1");
    while (level.var_1575b6db) {
        foreach (guy in doa_player_utility::function_5eb6e4d1()) {
            guy thread function_733651c();
            if (guy isinmovemode("ufo", "noclip")) {
                wait 0.4;
                continue;
            }
            roll = randomint(100);
            if (roll > 90) {
                guy setplayerangles((0, randomint(360), 0));
                guy.doa.var_3be905bb = 1;
                namespace_49107f3a::debugmsg("Bot is boosting.  Boosts Left:" + guy.doa.var_c5e98ad6);
            }
            if (roll < 10) {
                guy.doa.var_f2870a9e = 1;
                namespace_49107f3a::debugmsg("Bot is dropping nuke.  Bombs Left:" + guy.doa.bombs);
            }
        }
        if (botcount > 0 && randomint(100) > 50) {
            adddebugcommand("set devgui_bot remove");
            botcount--;
            namespace_49107f3a::debugmsg("Bot is being removed.   Count=" + botcount);
        } else if (botcount < 3 && randomint(100) > 70) {
            adddebugcommand("set devgui_bot add");
            botcount++;
            namespace_49107f3a::debugmsg("Bot is being added.  Count=" + botcount);
        }
        wait randomintrange(5, 20);
        if (level.doa.var_b1698a42.var_cadf4b04.size > 0) {
            i = 0;
            foreach (guy in doa_player_utility::function_5eb6e4d1()) {
                guy setorigin(level.doa.var_b1698a42.var_cadf4b04[i].origin);
                i++;
            }
            wait 30;
        }
        if (isdefined(level.doa.boss.takedamage) && isdefined(level.doa.boss) && level.doa.boss.takedamage) {
            level.doa.boss dodamage(30000, level.doa.boss.origin);
        }
        if (!level flag::get("doa_round_active")) {
            if (level.doa.var_53d0f8a7.size > 0) {
                wait 5;
                foreach (exit in level.doa.var_53d0f8a7) {
                    exit thread namespace_49107f3a::function_a4d1f25e("trigger", randomfloatrange(0.5, 1));
                }
                continue;
            }
            if (isdefined(level.doa.teleporter) && isdefined(level.doa.teleporter.trigger)) {
                wait 5;
                if (isdefined(level.doa.teleporter) && isdefined(level.doa.teleporter.trigger)) {
                    level.doa.teleporter.trigger notify(#"trigger");
                }
            }
        }
    }
}

// Namespace namespace_2f63e553
// Params 0, eflags: 0x0
// Checksum 0x95ef4f3d, Offset: 0x1548
// Size: 0x3d
function function_f24eee41() {
    level endon(#"fixedCamDebug");
    lockspot = self.origin;
    while (true) {
        self setorigin(lockspot);
        wait 0.05;
    }
}

// Namespace namespace_2f63e553
// Params 0, eflags: 0x0
// Checksum 0x4372d80e, Offset: 0x1590
// Size: 0x10a5
function function_c18f4e35() {
    setdvar("zombie_devgui", "");
    setdvar("scr_spawn_pickup", "");
    setdvar("scr_spawn_room_name", "");
    setdvar("scr_spawn_room", "");
    while (true) {
        if (getdvarint("scr_doa_kingme_soak_think", 0)) {
            setdvar("scr_doa_kingme_soak_think", 0);
            setdvar("scr_doa_soak_think", 1);
            namespace_49107f3a::debugmsg("Hail to the King baby!");
            foreach (player in doa_player_utility::function_5eb6e4d1()) {
                player thread function_92c840a6();
            }
        }
        if (getdvarint("scr_doa_soak_think", 0)) {
            if (!(isdefined(level.var_1575b6db) && level.var_1575b6db)) {
                level thread function_a3bba13d();
            }
        } else if (isdefined(level.var_1575b6db) && level.var_1575b6db) {
            level notify(#"hash_e20ba07c");
        }
        cmd = getdvarstring("zombie_devgui");
        if (cmd == "") {
            wait 0.5;
            continue;
        }
        namespace_49107f3a::debugmsg("Devgui Cmd-->" + cmd);
        switch (cmd) {
        case "outro":
            players = doa_player_utility::function_5eb6e4d1();
            for (i = 0; i < players.size; i++) {
                players[i].doa.lives = 0;
                players[i] dodamage(players[i].health + 100, players[i].origin);
            }
            break;
        case "joyride":
            level.doa.rules.var_cd899ae7 = 9999;
            level.doa.rules.var_91e6add5 = 9999;
            level.doa.rules.var_7196fe3d = 9999;
            level.doa.rules.var_8b15034d = 9999;
            break;
        case "doasoak":
            setdvar("scr_doa_soak_think", !getdvarint("scr_doa_soak_think", 0));
            break;
        case "fixedCamDebug":
            if (level.debugCamera != 1) {
                level.debugCamera = 1;
            } else {
                level.debugCamera = 0;
            }
            namespace_49107f3a::debugmsg("camera debug FIX ARENA CAM LOC [" + (level.debugCamera == 1 ? "ON" : "OFF") + "]");
            level clientfield::set("debugCamera", level.debugCamera);
            level notify(#"fixedCamDebug");
            if (level.debugCamera == 1) {
                foreach (player in getplayers()) {
                    player thread function_f24eee41();
                }
            }
            break;
        case "fixedCamOn":
            level.fixCameraOn = !level.fixCameraOn;
            namespace_49107f3a::debugmsg("camera FIX CAM[" + (level.fixCameraOn ? "ON" : "OFF") + "]");
            level clientfield::set("fixCameraOn", level.fixCameraOn ? 1 : 0);
            break;
        case "money":
            namespace_49107f3a::debugmsg("big money, BIG PRIZES!");
            level thread namespace_a7e6beb5::function_22d0e830();
            level thread namespace_a7e6beb5::function_22d0e830(1);
            break;
        case "gem":
            namespace_49107f3a::debugmsg("Gem Launching!");
            players = doa_player_utility::function_5eb6e4d1();
            for (i = 0; i < players.size; i++) {
                level thread namespace_a7e6beb5::function_16237a19(players[i].origin, 4, 10, 1, 1);
            }
            break;
        case "gemX":
            namespace_49107f3a::debugmsg("Gem Launching!");
            players = doa_player_utility::function_5eb6e4d1();
            scale = int(getdvarstring("scr_spawn_pickup"));
            for (i = 0; i < players.size; i++) {
                level thread namespace_a7e6beb5::function_16237a19(players[i].origin, 1, 10, 1, 1, scale);
            }
            break;
        case "king":
            namespace_49107f3a::debugmsg("Hail to the King baby!");
            foreach (player in doa_player_utility::function_5eb6e4d1()) {
                player thread function_92c840a6();
            }
            break;
        case "pickup":
            namespace_49107f3a::debugmsg("spawning pickup " + getdvarstring("scr_spawn_pickup"));
            level namespace_a7e6beb5::function_3238133b(getdvarstring("scr_spawn_pickup"));
            break;
        case "magic_room":
            level.doa.var_161fb2a1 = getdvarint("scr_spawn_room");
            if (level.doa.var_161fb2a1 == 13) {
                level.doa.var_94073ca5 = getdvarstring("scr_spawn_room_name");
            }
            if (level.doa.var_161fb2a1 == 10) {
                players = doa_player_utility::function_5eb6e4d1();
                for (i = 1; i < players.size; i++) {
                    if (players[i].doa.fate == 0) {
                        players[i] namespace_23f188a4::function_194ede2e(randomintrange(1, 5));
                    }
                }
            }
            flag::clear("doa_round_active");
            namespace_49107f3a::function_1ced251e();
            setdvar("scr_spawn_room_name", "");
            setdvar("scr_spawn_room", "");
            break;
        case "UnderBossRound":
            level.doa.var_bae65231 = 1;
            flag::clear("doa_round_active");
            namespace_49107f3a::function_1ced251e();
            break;
        case "bossRound":
            level.doa.var_602737ab = 1;
            flag::clear("doa_round_active");
            namespace_49107f3a::function_1ced251e();
            break;
        case "fate":
            type = getdvarint("scr_spawn_pickup");
            namespace_49107f3a::debugmsg("Fating you ->" + type);
            level.doa.var_5effb8dd = 1;
            players = doa_player_utility::function_5eb6e4d1();
            for (i = 0; i < players.size; i++) {
                if (type < 10) {
                    players[i] namespace_23f188a4::function_194ede2e(type);
                    continue;
                }
                type1 = type - 9;
                players[i] namespace_23f188a4::function_194ede2e(type1);
                wait 1;
                players[i] namespace_23f188a4::function_194ede2e(type);
            }
            break;
        case "all_pickups":
            namespace_49107f3a::debugmsg("Spawning All Pickups");
            for (i = 0; i < level.doa.pickups.items.size; i++) {
                level namespace_a7e6beb5::function_3238133b(level.doa.pickups.items[i].var_bcc88c39);
            }
            break;
        case "nurgles":
            namespace_49107f3a::debugmsg("Spawning Nurgles");
            level thread namespace_a7e6beb5::function_eaf49506(32, undefined, 120);
            break;
        case "arena":
            InvalidOpCode(0xc9, namespace_3ca3c537::function_5835533a(getdvarstring("scr_spawn_room_name")));
            // Unknown operator (0xc9, t7_1b, PC)
        case "warp":
            flag::clear("doa_round_active");
            level.doa.var_b5c260bb = namespace_3ca3c537::function_5835533a(getdvarstring("scr_spawn_room_name"));
            level.doa.var_458c27d = level.doa.rules.var_88c0b67b - 1;
            round_number = level.doa.var_b5c260bb * level.doa.rules.var_88c0b67b;
            foreach (room in level.doa.var_ec2bff7b) {
                if (round_number > room.minround) {
                    room.var_57ce7582[room.var_57ce7582.size] = round_number;
                }
            }
            var_7dce6dce = 1;
            while (var_7dce6dce) {
                var_7dce6dce = 0;
                foreach (room in level.doa.var_ec2bff7b) {
                    if (isdefined(room.var_6f369ab4) && room.var_57ce7582.size >= room.var_6f369ab4) {
                        arrayremovevalue(level.doa.var_ec2bff7b, room, 0);
                        var_7dce6dce = 1;
                        break;
                    }
                }
            }
            namespace_49107f3a::debugmsg("Warp To Arena =" + getdvarstring("scr_spawn_room_name") + " idx=" + level.doa.var_b5c260bb);
            setdvar("scr_spawn_room_name", "");
            namespace_49107f3a::function_1ced251e();
            break;
        case "aispawn":
            if (isdefined(level.doa.var_e6fd0e17)) {
                [[ level.doa.var_e6fd0e17 ]](getdvarstring("scr_spawn_name"));
            }
            break;
        case "round":
            level.doa.var_33749c8 = getdvarint(#"hash_d81b6e19") - 1;
            flag::clear("doa_round_active");
            setdvar("timescale", "10");
            namespace_49107f3a::function_1ced251e();
            break;
        case "lap_next":
            level.doa.var_da96f13c++;
            flag::clear("doa_round_active");
            namespace_49107f3a::function_1ced251e();
            break;
        case "round_next":
            flag::clear("doa_round_active");
            namespace_49107f3a::function_1ced251e();
            break;
        case "open_exits":
            level.doa.var_638a5ffc = "all";
            flag::clear("doa_round_active");
            namespace_49107f3a::function_1ced251e();
            break;
        case "kill_all_enemy":
            flag::clear("doa_round_active");
            namespace_49107f3a::function_f798b582(1);
            namespace_49107f3a::function_1ced251e();
            namespace_49107f3a::clearallcorpses();
            level clientfield::set("cleanupGiblets", 1);
            break;
        case "kill":
            namespace_49107f3a::debugmsg("death has been notified ...");
            players = doa_player_utility::function_5eb6e4d1();
            if (players.size == 1) {
                player = players[0];
            } else {
                player = players[randomint(players.size)];
            }
            player dodamage(player.health + 100, player.origin);
            break;
        case "kill_all":
            namespace_49107f3a::debugmsg("death to all...");
            players = doa_player_utility::function_5eb6e4d1();
            for (i = 0; i < players.size; i++) {
                players[i] dodamage(players[i].health + 100, players[i].origin);
            }
            break;
        case "debug_invul":
            level.doa.var_e5a69065 = !level.doa.var_e5a69065;
            break;
        }
        setdvar("zombie_devgui", "");
    }
}

// Namespace namespace_2f63e553
// Params 4, eflags: 0x0
// Checksum 0x9a9fd957, Offset: 0x2640
// Size: 0x165
function function_5e6b8376(origin, radius, time, color) {
    if (!isdefined(color)) {
        color = (0, 1, 0);
    }
    /#
        level endon(#"hash_48b870e4");
        self endon(#"death");
        var_9f8f8bbe = 0.05;
        circleres = 16;
        var_242ed014 = circleres / 2;
        circleinc = 360 / circleres;
        circleres++;
        timer = gettime() + time * 1000;
        while (gettime() < timer) {
            plotpoints = [];
            rad = 0;
            wait var_9f8f8bbe;
            players = getplayers();
            angletoplayer = vectortoangles(origin - players[0].origin);
            for (i = 0; i < circleres; i++) {
                plotpoints[plotpoints.size] = origin + vectorscale(anglestoforward(angletoplayer + (rad, 90, 0)), radius) + (0, 0, 12);
                rad += circleinc;
            }
            plotpoints(plotpoints, color, var_9f8f8bbe);
        }
    #/
}

// Namespace namespace_2f63e553
// Params 3, eflags: 0x0
// Checksum 0x8c54a61b, Offset: 0x27b0
// Size: 0xa9
function plotpoints(plotpoints, var_c75b4e78, var_8bb7be29) {
    if (!isdefined(var_8bb7be29)) {
        var_8bb7be29 = 1;
    }
    /#
        if (plotpoints.size == 0) {
            return;
        }
        lastpoint = plotpoints[0];
        for (var_8bb7be29 = int(var_8bb7be29); var_8bb7be29; var_8bb7be29--) {
            for (i = 1; i < plotpoints.size; i++) {
                line(lastpoint, plotpoints[i], var_c75b4e78, 1, var_8bb7be29);
                lastpoint = plotpoints[i];
            }
            wait 0.05;
        }
    #/
}

// Namespace namespace_2f63e553
// Params 5, eflags: 0x0
// Checksum 0xacee36d2, Offset: 0x2868
// Size: 0x201
function drawcylinder(pos, rad, height, var_8bb7be29, color) {
    if (!isdefined(var_8bb7be29)) {
        var_8bb7be29 = 1;
    }
    if (!isdefined(color)) {
        color = (0, 0, 0);
    }
    /#
        self endon(#"stop_cylinder");
        self endon(#"death");
        currad = rad;
        curheight = height;
        for (var_8bb7be29 = int(var_8bb7be29); var_8bb7be29; var_8bb7be29--) {
            for (r = 0; r < 20; r++) {
                theta = r / 20 * 360;
                theta2 = (r + 1) / 20 * 360;
                line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color);
                line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color);
                line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color);
            }
            wait 0.05;
        }
    #/
}

/#

    // Namespace namespace_2f63e553
    // Params 0, eflags: 0x0
    // Checksum 0xe4893091, Offset: 0x2a78
    // Size: 0x16d
    function debugorigin() {
        self notify(#"hash_707e044");
        self endon(#"hash_707e044");
        self endon(#"death");
        for (;;) {
            forward = anglestoforward(self.angles);
            forwardfar = vectorscale(forward, 30);
            forwardclose = vectorscale(forward, 20);
            right = anglestoright(self.angles);
            left = vectorscale(right, -10);
            right = vectorscale(right, 10);
            line(self.origin, self.origin + forwardfar, (0.9, 0.7, 0.6), 0.9);
            line(self.origin + forwardfar, self.origin + forwardclose + right, (0.9, 0.7, 0.6), 0.9);
            line(self.origin + forwardfar, self.origin + forwardclose + left, (0.9, 0.7, 0.6), 0.9);
            wait 0.05;
        }
    }

#/

// Namespace namespace_2f63e553
// Params 4, eflags: 0x0
// Checksum 0x363bdd94, Offset: 0x2bf0
// Size: 0x12d
function function_a0e51d80(point, timesec, size, color) {
    end = gettime() + timesec * 1000;
    halfwidth = int(size / 2);
    var_a84bd888 = point + (halfwidth * -1, 0, 0);
    l2 = point + (halfwidth, 0, 0);
    var_5e2b69e1 = point + (0, halfwidth * -1, 0);
    var_842de44a = point + (0, halfwidth, 0);
    var_e4d48d14 = point + (0, 0, halfwidth * -1);
    var_56dbfc4f = point + (0, 0, halfwidth);
    while (end > gettime()) {
        /#
            line(var_a84bd888, l2, color, 1, 0, 1);
            line(var_5e2b69e1, var_842de44a, color, 1, 0, 1);
            line(var_e4d48d14, var_56dbfc4f, color, 1, 0, 1);
        #/
        wait 0.05;
    }
}

// Namespace namespace_2f63e553
// Params 4, eflags: 0x0
// Checksum 0x418d9bae, Offset: 0x2d28
// Size: 0x65
function debugline(p1, p2, timesec, color) {
    end = gettime() + timesec * 1000;
    while (end > gettime()) {
        /#
            line(p1, p2, color, 1, 0, 1);
        #/
        wait 0.05;
    }
}

