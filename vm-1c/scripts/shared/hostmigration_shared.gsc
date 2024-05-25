#using scripts/shared/util_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hud_shared;
#using scripts/codescripts/struct;

#namespace hostmigration;

/#

    // Namespace hostmigration
    // Params 0, eflags: 0x0
    // Checksum 0x4000573a, Offset: 0x160
    // Size: 0x13c
    function debug_script_structs() {
        if (isdefined(level.struct)) {
            println("<unknown string>" + level.struct.size);
            println("<unknown string>");
            for (i = 0; i < level.struct.size; i++) {
                struct = level.struct[i];
                if (isdefined(struct.targetname)) {
                    println("<unknown string>" + i + "<unknown string>" + struct.targetname);
                    continue;
                }
                println("<unknown string>" + i + "<unknown string>" + "<unknown string>");
            }
            return;
        }
        println("<unknown string>");
    }

#/

// Namespace hostmigration
// Params 0, eflags: 0x0
// Checksum 0xd27d2531, Offset: 0x2a8
// Size: 0xa0
function updatetimerpausedness() {
    shouldbestopped = isdefined(level.hostmigrationtimer);
    if (!level.timerstopped && shouldbestopped) {
        level.timerstopped = 1;
        level.playabletimerstopped = 1;
        level.timerpausetime = gettime();
        return;
    }
    if (level.timerstopped && !shouldbestopped) {
        level.timerstopped = 0;
        level.playabletimerstopped = 0;
        level.discardtime += gettime() - level.timerpausetime;
    }
}

// Namespace hostmigration
// Params 0, eflags: 0x0
// Checksum 0xe2660599, Offset: 0x350
// Size: 0x10
function pausetimer() {
    level.migrationtimerpausetime = gettime();
}

// Namespace hostmigration
// Params 0, eflags: 0x0
// Checksum 0xd51a2b5b, Offset: 0x368
// Size: 0x20
function resumetimer() {
    level.discardtime += gettime() - level.migrationtimerpausetime;
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// Checksum 0x75c48429, Offset: 0x390
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
// Params 2, eflags: 0x1 linked
// Checksum 0xf83530b, Offset: 0x400
// Size: 0xf4
function matchstarttimerconsole_internal(counttime, matchstarttimer) {
    waittillframeend();
    level endon(#"match_start_timer_beginning");
    while (counttime > 0 && !level.gameended) {
        matchstarttimer thread hud::function_5e2578bc(level);
        wait(matchstarttimer.inframes * 0.05);
        matchstarttimer setvalue(counttime);
        if (counttime == 2) {
            visionsetnaked(getdvarstring("mapname"), 3);
        }
        counttime--;
        wait(1 - matchstarttimer.inframes * 0.05);
    }
}

// Namespace hostmigration
// Params 2, eflags: 0x1 linked
// Checksum 0xc73e526c, Offset: 0x500
// Size: 0x27c
function matchstarttimerconsole(type, duration) {
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
    if (isdefined(level.host_migration_activate_visionset_func)) {
        level thread [[ level.host_migration_activate_visionset_func ]]();
    }
    if (counttime >= 2) {
        matchstarttimerconsole_internal(counttime, matchstarttimer);
    }
    if (isdefined(level.host_migration_deactivate_visionset_func)) {
        level thread [[ level.host_migration_deactivate_visionset_func ]]();
    }
    matchstarttimer hud::destroyelem();
    var_a2ceaf69 hud::destroyelem();
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// Checksum 0xca552724, Offset: 0x788
// Size: 0x9a
function hostmigrationwait() {
    level endon(#"game_ended");
    if (level.hostmigrationreturnedplayercount < level.players.size * 2 / 3) {
        thread matchstarttimerconsole("waiting_for_teams", 20);
        hostmigrationwaitforplayers();
    }
    level notify(#"host_migration_countdown_begin");
    thread matchstarttimerconsole("match_starting_in", 5);
    wait(5);
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// Checksum 0xb75eb330, Offset: 0x830
// Size: 0x2c
function waittillhostmigrationcountdown() {
    level endon(#"host_migration_end");
    if (!isdefined(level.hostmigrationtimer)) {
        return;
    }
    level waittill(#"host_migration_countdown_begin");
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// Checksum 0xed5748dc, Offset: 0x868
// Size: 0x14
function hostmigrationwaitforplayers() {
    level endon(#"hostmigration_enoughplayers");
    wait(15);
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// Checksum 0x5d666d2f, Offset: 0x888
// Size: 0x80
function hostmigrationtimerthink_internal() {
    level endon(#"host_migration_begin");
    level endon(#"host_migration_end");
    self.hostmigrationcontrolsfrozen = 0;
    while (!isalive(self)) {
        self waittill(#"spawned");
    }
    self.hostmigrationcontrolsfrozen = 1;
    self freezecontrols(1);
    level waittill(#"host_migration_end");
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// Checksum 0xa4899c94, Offset: 0x910
// Size: 0x4c
function hostmigrationtimerthink() {
    self endon(#"disconnect");
    level endon(#"host_migration_begin");
    hostmigrationtimerthink_internal();
    if (self.hostmigrationcontrolsfrozen) {
        self freezecontrols(0);
    }
}

// Namespace hostmigration
// Params 0, eflags: 0x1 linked
// Checksum 0xbde13e63, Offset: 0x968
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
// Checksum 0x8056c80d, Offset: 0x9a8
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
// Checksum 0x29cb3318, Offset: 0x9e0
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
    /#
        if (gettime() != endtime) {
            println("<unknown string>" + gettime() + "<unknown string>" + endtime);
        }
    #/
    waittillhostmigrationdone();
    return gettime() - starttime;
}

// Namespace hostmigration
// Params 1, eflags: 0x0
// Checksum 0x3577f787, Offset: 0xb18
// Size: 0x14e
function waitlongdurationwithhostmigrationpauseemp(duration) {
    if (duration == 0) {
        return;
    }
    assert(duration > 0);
    starttime = gettime();
    empendtime = gettime() + duration * 1000;
    level.empendtime = empendtime;
    while (gettime() < empendtime) {
        waittillhostmigrationstarts((empendtime - gettime()) / 1000);
        if (isdefined(level.hostmigrationtimer)) {
            timepassed = waittillhostmigrationdone();
            if (isdefined(empendtime)) {
                empendtime += timepassed;
            }
        }
    }
    /#
        if (gettime() != empendtime) {
            println("<unknown string>" + gettime() + "<unknown string>" + empendtime);
        }
    #/
    waittillhostmigrationdone();
    level.empendtime = undefined;
    return gettime() - starttime;
}

// Namespace hostmigration
// Params 1, eflags: 0x0
// Checksum 0x8e79bbde, Offset: 0xc70
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
            println("<unknown string>" + gettime() + "<unknown string>" + endtime);
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
// Params 1, eflags: 0x1 linked
// Checksum 0xf7ea8bee, Offset: 0xdf8
// Size: 0xe8
function migrationawarewait(durationms) {
    waittillhostmigrationdone();
    endtime = gettime() + durationms;
    timeremaining = durationms;
    while (true) {
        event = level util::waittill_level_any_timeout(timeremaining / 1000, self, "game_ended", "host_migration_begin");
        if (!isdefined(event)) {
            return;
        }
        if (event != "host_migration_begin") {
            return;
        }
        timeremaining = endtime - gettime();
        if (timeremaining <= 0) {
            return;
        }
        endtime = gettime() + durationms;
        waittillhostmigrationdone();
    }
}

