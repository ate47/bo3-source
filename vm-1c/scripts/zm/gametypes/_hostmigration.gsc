#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace hostmigration;

/#

    // Namespace hostmigration
    // Params 0, eflags: 0x0
    // namespace_6c1d04bd<file_0>::function_a8103bcf
    // Checksum 0x66100f4e, Offset: 0x268
    // Size: 0x13c
    function debug_script_structs() {
        if (isdefined(level.struct)) {
            println("waiting_for_teams" + level.struct.size);
            println("waiting_for_teams");
            for (i = 0; i < level.struct.size; i++) {
                struct = level.struct[i];
                if (isdefined(struct.targetname)) {
                    println("waiting_for_teams" + i + "waiting_for_teams" + struct.targetname);
                    continue;
                }
                println("waiting_for_teams" + i + "waiting_for_teams" + "waiting_for_teams");
            }
            return;
        }
        println("waiting_for_teams");
    }

#/

// Namespace hostmigration
// Params 0, eflags: 0x0
// namespace_6c1d04bd<file_0>::function_91ef6cc2
// Checksum 0xc43d16b6, Offset: 0x3b0
// Size: 0x88
function updatetimerpausedness() {
    shouldbestopped = isdefined(level.hostmigrationtimer);
    if (!level.timerstopped && shouldbestopped) {
        level.timerstopped = 1;
        level.timerpausetime = gettime();
        return;
    }
    if (level.timerstopped && !shouldbestopped) {
        level.timerstopped = 0;
        level.discardtime += gettime() - level.timerpausetime;
    }
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_f06c3fc
// Checksum 0x99ec1590, Offset: 0x440
// Size: 0x4
function callback_hostmigrationsave() {
    
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_1c4c1953
// Checksum 0x69b39178, Offset: 0x450
// Size: 0xc6
function callback_prehostmigrationsave() {
    zm_utility::undo_link_changes();
    if (isdefined(level._hm_should_pause_spawning) && level._hm_should_pause_spawning) {
        level flag::set("spawn_zombies");
    }
    for (i = 0; i < level.players.size; i++) {
        level.players[i] enableinvulnerability();
        level.players[i] setdstat("AfterActionReportStats", "lobbyPopup", "summary");
    }
}

// Namespace hostmigration
// Params 0, eflags: 0x0
// namespace_6c1d04bd<file_0>::function_568bba6c
// Checksum 0xf05c517d, Offset: 0x520
// Size: 0x10
function pausetimer() {
    level.migrationtimerpausetime = gettime();
}

// Namespace hostmigration
// Params 0, eflags: 0x0
// namespace_6c1d04bd<file_0>::function_bbe04eff
// Checksum 0xc45d5429, Offset: 0x538
// Size: 0x20
function resumetimer() {
    level.discardtime += gettime() - level.migrationtimerpausetime;
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_ce29b4cb
// Checksum 0x29d6dff4, Offset: 0x560
// Size: 0x68
function locktimer() {
    level endon(#"host_migration_begin");
    level endon(#"host_migration_end");
    for (;;) {
        currtime = gettime();
        wait(0.05);
        if (!level.timerstopped && isdefined(level.discardtime)) {
            level.discardtime += gettime() - currtime;
        }
    }
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_4c77da13
// Checksum 0x7fa55abd, Offset: 0x5d0
// Size: 0x89a
function callback_hostmigration() {
    zm_utility::redo_link_changes();
    setslowmotion(1, 1, 0);
    zm_utility::function_63f08cf();
    level.hostmigrationreturnedplayercount = 0;
    if (level.gameended) {
        println("waiting_for_teams" + gettime() + "waiting_for_teams");
        return;
    }
    sethostmigrationstatus(1);
    level notify(#"host_migration_begin");
    for (i = 0; i < level.players.size; i++) {
        if (isdefined(level.hostmigration_link_entity_callback)) {
            if (!isdefined(level.players[i]._host_migration_link_entity)) {
                level.players[i]._host_migration_link_entity = level.players[i] [[ level.hostmigration_link_entity_callback ]]();
            }
        }
        level.players[i] thread hostmigrationtimerthink();
    }
    if (isdefined(level.hostmigration_ai_link_entity_callback)) {
        zombies = getaiteamarray(level.zombie_team);
        if (isdefined(zombies) && zombies.size > 0) {
            foreach (zombie in zombies) {
                if (!isdefined(zombie._host_migration_link_entity)) {
                    zombie._host_migration_link_entity = zombie [[ level.hostmigration_ai_link_entity_callback ]]();
                }
            }
        }
    } else {
        zombies = getaiteamarray(level.zombie_team);
        if (isdefined(zombies) && zombies.size > 0) {
            foreach (zombie in zombies) {
                zombie.no_powerups = 1;
                zombie.marked_for_recycle = 1;
                zombie.has_been_damaged_by_player = 0;
                zombie dodamage(zombie.health + 1000, zombie.origin, zombie);
            }
        }
    }
    if (level.inprematchperiod) {
        level waittill(#"prematch_over");
    }
    println("waiting_for_teams" + gettime());
    level.hostmigrationtimer = 1;
    thread locktimer();
    if (isdefined(level.b_host_migration_force_player_respawn) && level.b_host_migration_force_player_respawn) {
        foreach (player in level.players) {
            if (zm_utility::is_player_valid(player, 0, 0)) {
                player host_migration_respawn();
            }
        }
    }
    zombies = getaiteamarray(level.zombie_team);
    if (isdefined(zombies) && zombies.size > 0) {
        foreach (zombie in zombies) {
            if (isdefined(zombie._host_migration_link_entity)) {
                ent = spawn("script_origin", zombie.origin);
                ent.angles = zombie.angles;
                zombie linkto(ent);
                ent linkto(zombie._host_migration_link_entity, "tag_origin", zombie._host_migration_link_entity worldtolocalcoords(ent.origin), ent.angles + zombie._host_migration_link_entity.angles);
                zombie._host_migration_link_helper = ent;
                zombie linkto(zombie._host_migration_link_helper);
            }
        }
    }
    level endon(#"host_migration_begin");
    should_pause_spawning = level flag::get("spawn_zombies");
    if (should_pause_spawning) {
        level flag::clear("spawn_zombies");
    }
    hostmigrationwait();
    foreach (player in level.players) {
        player thread post_migration_invulnerability();
    }
    zombies = getaiteamarray(level.zombie_team);
    if (isdefined(zombies) && zombies.size > 0) {
        foreach (zombie in zombies) {
            if (isdefined(zombie._host_migration_link_entity)) {
                zombie unlink();
                zombie._host_migration_link_helper delete();
                zombie._host_migration_link_helper = undefined;
                zombie._host_migration_link_entity = undefined;
            }
        }
    }
    if (should_pause_spawning) {
        level flag::set("spawn_zombies");
    }
    level.hostmigrationtimer = undefined;
    level._hm_should_pause_spawning = undefined;
    sethostmigrationstatus(0);
    println("waiting_for_teams" + gettime());
    level notify(#"host_migration_end");
}

// Namespace hostmigration
// Params 0, eflags: 0x0
// namespace_6c1d04bd<file_0>::function_9fa77949
// Checksum 0xa9e37ab6, Offset: 0xe78
// Size: 0xe
function post_migration_become_vulnerable() {
    self endon(#"disconnect");
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_3250e5b2
// Checksum 0x9c8798d9, Offset: 0xe90
// Size: 0x4c
function post_migration_invulnerability() {
    self endon(#"disconnect");
    var_8a32e9d8 = self enableinvulnerability();
    wait(3);
    self disableinvulnerability();
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_d783307
// Checksum 0x9b7fe140, Offset: 0xee8
// Size: 0x110
function host_migration_respawn() {
    println("waiting_for_teams");
    new_origin = undefined;
    if (isdefined(level.var_75eda423)) {
        new_origin = [[ level.var_75eda423 ]](self);
    }
    if (!isdefined(new_origin)) {
        new_origin = zm::check_for_valid_spawn_near_team(self, 1);
    }
    if (isdefined(new_origin)) {
        if (!isdefined(new_origin.angles)) {
            angles = (0, 0, 0);
        } else {
            angles = new_origin.angles;
        }
        self dontinterpolate();
        self setorigin(new_origin.origin);
        self setplayerangles(angles);
    }
    return true;
}

// Namespace hostmigration
// Params 2, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_b4083d02
// Checksum 0x1462ffe2, Offset: 0x1000
// Size: 0xb4
function matchstarttimerconsole_internal(counttime, matchstarttimer) {
    waittillframeend();
    level endon(#"match_start_timer_beginning");
    while (counttime > 0 && !level.gameended) {
        matchstarttimer thread hud::function_5e2578bc(level);
        wait(matchstarttimer.inframes * 0.05);
        matchstarttimer setvalue(counttime);
        counttime--;
        wait(1 - matchstarttimer.inframes * 0.05);
    }
}

// Namespace hostmigration
// Params 2, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_2a3bfc4e
// Checksum 0x5e36ed5e, Offset: 0x10c0
// Size: 0x264
function matchstarttimerconsole(type, duration) {
    thread function_ea08959e(duration);
    level notify(#"match_start_timer_beginning");
    wait(0.05);
    var_a2ceaf69 = hud::createserverfontstring("objective", 1.5);
    var_a2ceaf69 hud::setpoint("CENTER", "CENTER", 0, -40);
    var_a2ceaf69.sort = 1001;
    var_a2ceaf69 settext(game["strings"]["waiting_for_teams"]);
    var_a2ceaf69.foreground = 0;
    var_a2ceaf69.hidewheninmenu = 1;
    var_a2ceaf69 settext(game["strings"][type]);
    matchstarttimer = hud::createserverfontstring("objective", 2.2);
    matchstarttimer hud::setpoint("CENTER", "CENTER", 0, 0);
    matchstarttimer.sort = 1001;
    matchstarttimer.color = (1, 1, 0);
    matchstarttimer.foreground = 0;
    matchstarttimer.hidewheninmenu = 1;
    matchstarttimer hud::function_1ad5c13d();
    counttime = int(duration);
    if (counttime >= 2) {
        matchstarttimerconsole_internal(counttime, matchstarttimer);
    }
    matchstarttimer hud::destroyelem();
    var_a2ceaf69 hud::destroyelem();
}

// Namespace hostmigration
// Params 1, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_ea08959e
// Checksum 0xd4d8de13, Offset: 0x1330
// Size: 0x92
function function_ea08959e(duration) {
    array::thread_all(getplayers(), &zm::initialblack);
    fade_time = 4;
    n_black_screen = duration - fade_time;
    level thread zm::fade_out_intro_screen_zm(n_black_screen, fade_time, 1);
    wait(fade_time);
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_e2942b82
// Checksum 0x6d66783b, Offset: 0x13d0
// Size: 0x8a
function hostmigrationwait() {
    level endon(#"game_ended");
    if (level.hostmigrationreturnedplayercount < level.players.size * 2 / 3) {
        thread matchstarttimerconsole("waiting_for_teams", 20);
        hostmigrationwaitforplayers();
    }
    thread matchstarttimerconsole("match_starting_in", 9);
    wait(5);
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_7cd16b3
// Checksum 0xbf0d71d4, Offset: 0x1468
// Size: 0x14
function hostmigrationwaitforplayers() {
    level endon(#"hostmigration_enoughplayers");
    wait(15);
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_36993d4c
// Checksum 0xb34a1481, Offset: 0x1488
// Size: 0x190
function hostmigrationtimerthink_internal() {
    level endon(#"host_migration_begin");
    level endon(#"host_migration_end");
    self.hostmigrationcontrolsfrozen = 0;
    while (!isalive(self)) {
        self waittill(#"spawned");
    }
    if (isdefined(self._host_migration_link_entity)) {
        ent = spawn("script_origin", self.origin);
        ent.angles = self.angles;
        self linkto(ent);
        ent linkto(self._host_migration_link_entity, "tag_origin", self._host_migration_link_entity worldtolocalcoords(ent.origin), ent.angles + self._host_migration_link_entity.angles);
        self._host_migration_link_helper = ent;
        println("waiting_for_teams" + self._host_migration_link_entity.targetname);
    }
    self.hostmigrationcontrolsfrozen = 1;
    self freezecontrols(1);
    level waittill(#"host_migration_end");
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_41818acc
// Checksum 0x1c86dc4e, Offset: 0x1620
// Size: 0xf6
function hostmigrationtimerthink() {
    self endon(#"disconnect");
    level endon(#"host_migration_begin");
    hostmigrationtimerthink_internal();
    if (self.hostmigrationcontrolsfrozen) {
        self freezecontrols(0);
        self.hostmigrationcontrolsfrozen = 0;
        println("waiting_for_teams");
    }
    if (isdefined(self._host_migration_link_entity)) {
        self unlink();
        self._host_migration_link_helper delete();
        self._host_migration_link_helper = undefined;
        if (isdefined(self._host_migration_link_entity._post_host_migration_thread)) {
            self thread [[ self._host_migration_link_entity._post_host_migration_thread ]](self._host_migration_link_entity);
        }
        self._host_migration_link_entity = undefined;
    }
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_8ef8da7f
// Checksum 0xe10da501, Offset: 0x1720
// Size: 0x38
function waittillhostmigrationdone() {
    if (!isdefined(level.hostmigrationtimer)) {
        return 0;
    }
    starttime = gettime();
    level waittill(#"host_migration_end");
    return gettime() - starttime;
}

// Namespace hostmigration
// Params 1, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_521e5168
// Checksum 0xec32dd0d, Offset: 0x1760
// Size: 0x2c
function waittillhostmigrationstarts(duration) {
    if (isdefined(level.hostmigrationtimer)) {
        return;
    }
    level endon(#"host_migration_begin");
    wait(duration);
}

// Namespace hostmigration
// Params 1, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_ab19bd44
// Checksum 0x2cd505bd, Offset: 0x1798
// Size: 0x12c
function waitlongdurationwithhostmigrationpause(duration) {
    if (duration == 0) {
        return;
    }
    assert(duration > 0);
    starttime = gettime();
    for (endtime = gettime() + duration * 1000; gettime() < endtime; endtime += timepassed) {
        waittillhostmigrationstarts((endtime - gettime()) / 1000);
        if (isdefined(level.hostmigrationtimer)) {
            timepassed = waittillhostmigrationdone();
        }
    }
    if (gettime() != endtime) {
        println("waiting_for_teams" + gettime() + "waiting_for_teams" + endtime);
    }
    waittillhostmigrationdone();
    return gettime() - starttime;
}

// Namespace hostmigration
// Params 1, eflags: 0x0
// namespace_6c1d04bd<file_0>::function_515833bd
// Checksum 0x6a917748, Offset: 0x18d0
// Size: 0x17e
function waitlongdurationwithgameendtimeupdate(duration) {
    if (duration == 0) {
        return;
    }
    assert(duration > 0);
    starttime = gettime();
    endtime = gettime() + duration * 1000;
    while (gettime() < endtime) {
        waittillhostmigrationstarts((endtime - gettime()) / 1000);
        while (isdefined(level.hostmigrationtimer)) {
            endtime += 1000;
            setgameendtime(int(endtime));
            wait(1);
        }
    }
    /#
        if (gettime() != endtime) {
            println("waiting_for_teams" + gettime() + "waiting_for_teams" + endtime);
        }
    #/
    while (isdefined(level.hostmigrationtimer)) {
        endtime += 1000;
        setgameendtime(int(endtime));
        wait(1);
    }
    return gettime() - starttime;
}

// Namespace hostmigration
// Params 5, eflags: 0x1 linked
// namespace_6c1d04bd<file_0>::function_ca1a9d1d
// Checksum 0xbf225fb1, Offset: 0x1a58
// Size: 0x2ac
function find_alternate_player_place(v_origin, min_radius, max_radius, max_height, ignore_targetted_nodes) {
    found_node = undefined;
    a_nodes = getnodesinradiussorted(v_origin, max_radius, min_radius, max_height, "pathnodes");
    if (isdefined(a_nodes) && a_nodes.size > 0) {
        a_player_volumes = getentarray("player_volume", "script_noteworthy");
        index = a_nodes.size - 1;
        for (i = index; i >= 0; i--) {
            n_node = a_nodes[i];
            if (ignore_targetted_nodes == 1) {
                if (isdefined(n_node.target)) {
                    continue;
                }
            }
            if (!positionwouldtelefrag(n_node.origin)) {
                if (zm_utility::check_point_in_enabled_zone(n_node.origin, 1, a_player_volumes)) {
                    v_start = (n_node.origin[0], n_node.origin[1], n_node.origin[2] + 30);
                    v_end = (n_node.origin[0], n_node.origin[1], n_node.origin[2] - 30);
                    trace = bullettrace(v_start, v_end, 0, undefined);
                    if (trace["fraction"] < 1) {
                        override_abort = 0;
                        if (isdefined(level._whoswho_reject_node_override_func)) {
                            override_abort = [[ level._whoswho_reject_node_override_func ]](v_origin, n_node);
                        }
                        if (!override_abort) {
                            found_node = n_node;
                            break;
                        }
                    }
                }
            }
        }
    }
    return found_node;
}

// Namespace hostmigration
// Params 0, eflags: 0x0
// namespace_6c1d04bd<file_0>::function_b0ef837e
// Checksum 0x933975ca, Offset: 0x1d10
// Size: 0x394
function hostmigration_put_player_in_better_place() {
    spawnpoint = undefined;
    spawnpoint = find_alternate_player_place(self.origin, 50, -106, 64, 1);
    if (!isdefined(spawnpoint)) {
        spawnpoint = find_alternate_player_place(self.origin, -106, 400, 64, 1);
    }
    if (!isdefined(spawnpoint)) {
        spawnpoint = find_alternate_player_place(self.origin, 50, 400, 256, 0);
    }
    if (!isdefined(spawnpoint)) {
        spawnpoint = zm::check_for_valid_spawn_near_team(self, 1);
    }
    if (!isdefined(spawnpoint)) {
        match_string = "";
        location = level.scr_zm_map_start_location;
        if ((location == "default" || location == "") && isdefined(level.default_start_location)) {
            location = level.default_start_location;
        }
        match_string = level.scr_zm_ui_gametype + "_" + location;
        spawnpoints = [];
        structs = struct::get_array("initial_spawn", "script_noteworthy");
        if (isdefined(structs)) {
            foreach (struct in structs) {
                if (isdefined(struct.script_string)) {
                    tokens = strtok(struct.script_string, " ");
                    foreach (token in tokens) {
                        if (token == match_string) {
                            spawnpoints[spawnpoints.size] = struct;
                        }
                    }
                }
            }
        }
        if (!isdefined(spawnpoints) || spawnpoints.size == 0) {
            spawnpoints = struct::get_array("initial_spawn_points", "targetname");
        }
        assert(isdefined(spawnpoints), "waiting_for_teams");
        spawnpoint = zm::getfreespawnpoint(spawnpoints, self);
    }
    if (isdefined(spawnpoint)) {
        self setorigin(spawnpoint.origin);
    }
}

