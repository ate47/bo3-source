#using scripts/codescripts/struct;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/shared/callbacks_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;

#namespace spawnlogic;

// Namespace spawnlogic
// Params 0, eflags: 0x2
// Checksum 0x49e9d531, Offset: 0x288
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("spawnlogic", &__init__, undefined, undefined);
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0x1abd3ce, Offset: 0x2c0
// Size: 0x22
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0xf2ebe029, Offset: 0x2f0
// Size: 0x372
function init() {
    /#
        if (getdvarstring("<dev string:x28>") == "<dev string:x3c>") {
            setdvar("<dev string:x28>", 0);
        }
        level.storespawndata = getdvarint("<dev string:x28>");
        if (getdvarstring("<dev string:x3d>") == "<dev string:x3c>") {
            setdvar("<dev string:x3d>", 0);
        }
        if (getdvarstring("<dev string:x4a>") == "<dev string:x3c>") {
            setdvar("<dev string:x4a>", 0.25);
        }
        thread function_d320505c();
    #/
    level.spawnlogic_deaths = [];
    level.spawnlogic_spawnkills = [];
    level.players = [];
    level.grenades = [];
    level.pipebombs = [];
    level.numplayerswaitingtoenterkillcam = 0;
    level.convert_spawns_to_structs = getdvarint("spawnsystem_convert_spawns_to_structs");
    println("<dev string:x5b>");
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    level.spawnminsmaxsprimed = 0;
    if (isdefined(level.safespawns)) {
        for (i = 0; i < level.safespawns.size; i++) {
            level.safespawns[i] spawnpoint_init();
        }
    }
    if (getdvarstring("scr_spawn_enemyavoiddist") == "") {
        setdvar("scr_spawn_enemyavoiddist", "800");
    }
    if (getdvarstring("scr_spawn_enemyavoidweight") == "") {
        setdvar("scr_spawn_enemyavoidweight", "0");
    }
    /#
        if (getdvarstring("<dev string:x8f>") == "<dev string:x3c>") {
            setdvar("<dev string:x8f>", "<dev string:x9f>");
        }
        if (getdvarstring("<dev string:xa1>") == "<dev string:x3c>") {
            setdvar("<dev string:xa1>", "<dev string:x9f>");
        }
        if (getdvarint("<dev string:xa1>") > 0) {
            thread function_76bb9fb8();
            thread function_403f0d14();
            thread function_9ce570b0();
        }
        if (level.storespawndata) {
            thread function_8384886e();
        }
        if (getdvarstring("<dev string:xb5>") == "<dev string:x3c>") {
            setdvar("<dev string:xb5>", "<dev string:x9f>");
        }
        thread function_f415b14();
        thread function_e2e4ca72();
    #/
}

// Namespace spawnlogic
// Params 3, eflags: 0x0
// Checksum 0xf6e079f4, Offset: 0x670
// Size: 0x1d7
function add_spawn_points_internal(team, spawnpoints, list) {
    if (!isdefined(list)) {
        list = 0;
    }
    oldspawnpoints = [];
    if (level.teamspawnpoints[team].size) {
        oldspawnpoints = level.teamspawnpoints[team];
    }
    if (isdefined(level.allowedgameobjects) && level.convert_spawns_to_structs) {
        for (i = spawnpoints.size - 1; i >= 0; i--) {
            if (!gameobjects::entity_is_allowed(spawnpoints[i], level.allowedgameobjects)) {
                spawnpoints[i] = undefined;
            }
        }
        arrayremovevalue(spawnpoints, undefined);
    }
    level.teamspawnpoints[team] = spawnpoints;
    if (!isdefined(level.spawnpoints)) {
        level.spawnpoints = [];
    }
    for (index = 0; index < level.teamspawnpoints[team].size; index++) {
        spawnpoint = level.teamspawnpoints[team][index];
        if (!isdefined(spawnpoint.inited)) {
            spawnpoint spawnpoint_init();
            level.spawnpoints[level.spawnpoints.size] = spawnpoint;
        }
    }
    for (index = 0; index < oldspawnpoints.size; index++) {
        origin = oldspawnpoints[index].origin;
        level.spawnmins = math::expand_mins(level.spawnmins, origin);
        level.spawnmaxs = math::expand_maxs(level.spawnmaxs, origin);
        level.teamspawnpoints[team][level.teamspawnpoints[team].size] = oldspawnpoints[index];
    }
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0x73eb91ad, Offset: 0x850
// Size: 0x69
function clear_spawn_points() {
    foreach (team in level.teams) {
        level.teamspawnpoints[team] = [];
    }
    level.spawnpoints = [];
    level.var_b1370bf0 = undefined;
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x45b12333, Offset: 0x8c8
// Size: 0x8e
function add_spawn_points(team, spawnpointname) {
    add_spawn_point_classname(spawnpointname);
    add_spawn_point_team_classname(team, spawnpointname);
    add_spawn_points_internal(team, get_spawnpoint_array(spawnpointname));
    if (!level.teamspawnpoints[team].size) {
        assert(level.teamspawnpoints[team].size, "<dev string:xc6>" + spawnpointname + "<dev string:xd3>");
        wait 1;
        return;
    }
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x8d47aa7f, Offset: 0x960
// Size: 0x59
function rebuild_spawn_points(team) {
    level.teamspawnpoints[team] = [];
    for (index = 0; index < level.spawn_point_team_class_names[team].size; index++) {
        add_spawn_points_internal(team, level.spawn_point_team_class_names[team][index]);
    }
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x6f56cffb, Offset: 0x9c8
// Size: 0x109
function place_spawn_points(spawnpointname) {
    add_spawn_point_classname(spawnpointname);
    spawnpoints = get_spawnpoint_array(spawnpointname);
    /#
        if (!isdefined(level.extraspawnpointsused)) {
            level.extraspawnpointsused = [];
        }
    #/
    if (!spawnpoints.size) {
        println("<dev string:xf0>" + spawnpointname + "<dev string:xd3>");
        assert(spawnpoints.size, "<dev string:xf0>" + spawnpointname + "<dev string:xd3>");
        callback::abort_level();
        wait 1;
        return;
    }
    for (index = 0; index < spawnpoints.size; index++) {
        spawnpoints[index] spawnpoint_init();
        /#
            spawnpoints[index].fakeclassname = spawnpointname;
            level.extraspawnpointsused[level.extraspawnpointsused.size] = spawnpoints[index];
        #/
    }
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xe64afd44, Offset: 0xae0
// Size: 0x79
function drop_spawn_points(spawnpointname) {
    spawnpoints = get_spawnpoint_array(spawnpointname);
    if (!spawnpoints.size) {
        println("<dev string:xf0>" + spawnpointname + "<dev string:xd3>");
        return;
    }
    for (index = 0; index < spawnpoints.size; index++) {
        placespawnpoint(spawnpoints[index]);
    }
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x73d4e17c, Offset: 0xb68
// Size: 0x2f
function add_spawn_point_classname(spawnpointclassname) {
    if (!isdefined(level.spawn_point_class_names)) {
        level.spawn_point_class_names = [];
    }
    level.spawn_point_class_names[level.spawn_point_class_names.size] = spawnpointclassname;
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x6c147038, Offset: 0xba0
// Size: 0x2c
function add_spawn_point_team_classname(team, spawnpointclassname) {
    level.spawn_point_team_class_names[team][level.spawn_point_team_class_names[team].size] = spawnpointclassname;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x586f53ce, Offset: 0xbd8
// Size: 0x52
function function_12d810b4(var_9bc4adf6) {
    if (isdefined(level.convert_spawns_to_structs) && level.convert_spawns_to_structs) {
        return struct::get_array(var_9bc4adf6, "targetname");
    }
    return getentarray(var_9bc4adf6, "classname");
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xa0198151, Offset: 0xc38
// Size: 0x7b
function get_spawnpoint_array(classname) {
    spawnpoints = function_12d810b4(classname);
    if (!isdefined(level.extraspawnpoints) || !isdefined(level.extraspawnpoints[classname])) {
        return spawnpoints;
    }
    for (i = 0; i < level.extraspawnpoints[classname].size; i++) {
        spawnpoints[spawnpoints.size] = level.extraspawnpoints[classname][i];
    }
    return spawnpoints;
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0x423f4af5, Offset: 0xcc0
// Size: 0xe6
function spawnpoint_init() {
    spawnpoint = self;
    origin = spawnpoint.origin;
    if (!level.spawnminsmaxsprimed) {
        level.spawnmins = origin;
        level.spawnmaxs = origin;
        level.spawnminsmaxsprimed = 1;
    } else {
        level.spawnmins = math::expand_mins(level.spawnmins, origin);
        level.spawnmaxs = math::expand_maxs(level.spawnmaxs, origin);
    }
    placespawnpoint(spawnpoint);
    spawnpoint.forward = anglestoforward(spawnpoint.angles);
    spawnpoint.sighttracepoint = spawnpoint.origin + (0, 0, 50);
    spawnpoint.inited = 1;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xcdff0d0f, Offset: 0xdb0
// Size: 0x12
function function_7f4a71b0(team) {
    return level.teamspawnpoints[team];
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x6c3ea580, Offset: 0xdd0
// Size: 0x18c
function get_spawnpoint_final(spawnpoints, useweights) {
    bestspawnpoint = undefined;
    if (!isdefined(spawnpoints) || spawnpoints.size == 0) {
        return undefined;
    }
    if (!isdefined(useweights)) {
        useweights = 1;
    }
    if (useweights) {
        bestspawnpoint = function_f714995a(spawnpoints);
        thread function_f5751b11(spawnpoints);
    } else {
        for (i = 0; i < spawnpoints.size; i++) {
            if (isdefined(self.lastspawnpoint) && self.lastspawnpoint == spawnpoints[i]) {
                continue;
            }
            if (positionwouldtelefrag(spawnpoints[i].origin)) {
                continue;
            }
            bestspawnpoint = spawnpoints[i];
            break;
        }
        if (!isdefined(bestspawnpoint)) {
            if (isdefined(self.lastspawnpoint) && !positionwouldtelefrag(self.lastspawnpoint.origin)) {
                for (i = 0; i < spawnpoints.size; i++) {
                    if (spawnpoints[i] == self.lastspawnpoint) {
                        bestspawnpoint = spawnpoints[i];
                        break;
                    }
                }
            }
        }
    }
    if (!isdefined(bestspawnpoint)) {
        if (useweights) {
            bestspawnpoint = spawnpoints[randomint(spawnpoints.size)];
        } else {
            bestspawnpoint = spawnpoints[0];
        }
    }
    self finalize_spawnpoint_choice(bestspawnpoint);
    /#
        self function_75321ef(spawnpoints, useweights, bestspawnpoint);
    #/
    return bestspawnpoint;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x41baf90, Offset: 0xf68
// Size: 0x3e
function finalize_spawnpoint_choice(spawnpoint) {
    time = gettime();
    self.lastspawnpoint = spawnpoint;
    self.lastspawntime = time;
    spawnpoint.lastspawnedplayer = self;
    spawnpoint.lastspawntime = time;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x518414bf, Offset: 0xfb0
// Size: 0x1f1
function function_f714995a(spawnpoints) {
    maxsighttracedspawnpoints = 3;
    for (var_ded856b0 = 0; var_ded856b0 <= maxsighttracedspawnpoints; var_ded856b0++) {
        bestspawnpoints = [];
        bestweight = undefined;
        bestspawnpoint = undefined;
        for (i = 0; i < spawnpoints.size; i++) {
            if (!isdefined(bestweight) || spawnpoints[i].weight > bestweight) {
                if (positionwouldtelefrag(spawnpoints[i].origin)) {
                    continue;
                }
                bestspawnpoints = [];
                bestspawnpoints[0] = spawnpoints[i];
                bestweight = spawnpoints[i].weight;
                continue;
            }
            if (spawnpoints[i].weight == bestweight) {
                if (positionwouldtelefrag(spawnpoints[i].origin)) {
                    continue;
                }
                bestspawnpoints[bestspawnpoints.size] = spawnpoints[i];
            }
        }
        if (bestspawnpoints.size == 0) {
            return undefined;
        }
        bestspawnpoint = bestspawnpoints[randomint(bestspawnpoints.size)];
        if (var_ded856b0 == maxsighttracedspawnpoints) {
            return bestspawnpoint;
        }
        if (isdefined(bestspawnpoint.lastsighttracetime) && bestspawnpoint.lastsighttracetime == gettime()) {
            return bestspawnpoint;
        }
        if (!function_b7cf3433(bestspawnpoint)) {
            return bestspawnpoint;
        }
        penalty = function_e40b0d5e();
        /#
            if (level.storespawndata || level.debugspawning) {
                bestspawnpoint.spawndata[bestspawnpoint.spawndata.size] = "<dev string:xf6>" + penalty;
            }
        #/
        bestspawnpoint.weight -= penalty;
        bestspawnpoint.lastsighttracetime = gettime();
    }
}

/#

    // Namespace spawnlogic
    // Params 1, eflags: 0x0
    // Checksum 0xde95254f, Offset: 0x11b0
    // Size: 0x119
    function function_d46f7aa7(spawnpoint) {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (!isalive(player) || player.sessionstate != "<dev string:x111>") {
                continue;
            }
            if (level.teambased && player.team == self.team) {
                continue;
            }
            losexists = bullettracepassed(player.origin + (0, 0, 50), spawnpoint.sighttracepoint, 0, undefined);
            if (losexists) {
                thread function_c12fba5f(spawnpoint.sighttracepoint, player.origin + (0, 0, 50), self.name, player.name);
            }
        }
    }

    // Namespace spawnlogic
    // Params 4, eflags: 0x0
    // Checksum 0xfa270874, Offset: 0x12d8
    // Size: 0xb1
    function function_c12fba5f(start, end, name1, name2) {
        dist = distance(start, end);
        for (i = 0; i < -56; i++) {
            line(start, end, (1, 0, 0));
            print3d(start, "<dev string:x119>" + name1 + "<dev string:x125>" + dist);
            print3d(end, name2);
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 3, eflags: 0x0
    // Checksum 0x3164686d, Offset: 0x1398
    // Size: 0x642
    function function_75321ef(spawnpoints, useweights, bestspawnpoint) {
        if (!isdefined(level.storespawndata) || !level.storespawndata) {
            return;
        }
        level.storespawndata = getdvarint("<dev string:x28>");
        if (!level.storespawndata) {
            return;
        }
        if (!isdefined(level.spawnid)) {
            level.spawngameid = randomint(100);
            level.spawnid = 0;
        }
        if (bestspawnpoint.classname == "<dev string:x12f>") {
            return;
        }
        level.spawnid++;
        file = openfile("<dev string:x146>", "<dev string:x154>");
        fprintfields(file, level.spawngameid + "<dev string:x15b>" + level.spawnid + "<dev string:x15d>" + spawnpoints.size + "<dev string:x15d>" + self.name);
        for (i = 0; i < spawnpoints.size; i++) {
            str = function_88dd1973(spawnpoints[i].origin) + "<dev string:x15d>";
            if (spawnpoints[i] == bestspawnpoint) {
                str += "<dev string:x15f>";
            } else {
                str += "<dev string:x162>";
            }
            if (!useweights) {
                str += "<dev string:x162>";
            } else {
                str += spawnpoints[i].weight + "<dev string:x15d>";
            }
            if (!isdefined(spawnpoints[i].spawndata)) {
                spawnpoints[i].spawndata = [];
            }
            if (!isdefined(spawnpoints[i].sightchecks)) {
                spawnpoints[i].sightchecks = [];
            }
            str += spawnpoints[i].spawndata.size + "<dev string:x15d>";
            for (j = 0; j < spawnpoints[i].spawndata.size; j++) {
                str += spawnpoints[i].spawndata[j] + "<dev string:x15d>";
            }
            str += spawnpoints[i].sightchecks.size + "<dev string:x15d>";
            for (j = 0; j < spawnpoints[i].sightchecks.size; j++) {
                str += spawnpoints[i].sightchecks[j].penalty + "<dev string:x15d>" + function_88dd1973(spawnpoints[i].origin) + "<dev string:x15d>";
            }
            fprintfields(file, str);
        }
        obj = spawnstruct();
        function_b8bbe7f3(obj);
        numallies = 0;
        numenemies = 0;
        str = "<dev string:x3c>";
        for (i = 0; i < obj.allies.size; i++) {
            if (obj.allies[i] == self) {
                continue;
            }
            numallies++;
            str += function_88dd1973(obj.allies[i].origin) + "<dev string:x15d>";
        }
        for (i = 0; i < obj.enemies.size; i++) {
            numenemies++;
            str += function_88dd1973(obj.enemies[i].origin) + "<dev string:x15d>";
        }
        str = numallies + "<dev string:x15d>" + numenemies + "<dev string:x15d>" + str;
        fprintfields(file, str);
        otherdata = [];
        if (isdefined(level.bombguy)) {
            index = otherdata.size;
            otherdata[index] = spawnstruct();
            otherdata[index].origin = level.bombguy.origin + (0, 0, 20);
            otherdata[index].text = "<dev string:x165>";
        } else if (isdefined(level.bombpos)) {
            index = otherdata.size;
            otherdata[index] = spawnstruct();
            otherdata[index].origin = level.bombpos;
            otherdata[index].text = "<dev string:x171>";
        }
        if (isdefined(level.flags)) {
            for (i = 0; i < level.flags.size; i++) {
                index = otherdata.size;
                otherdata[index] = spawnstruct();
                otherdata[index].origin = level.flags[i].origin;
                otherdata[index].text = level.flags[i].useobj gameobjects::get_owner_team() + "<dev string:x176>";
            }
        }
        str = otherdata.size + "<dev string:x15d>";
        for (i = 0; i < otherdata.size; i++) {
            str += function_88dd1973(otherdata[i].origin) + "<dev string:x15d>" + otherdata[i].text + "<dev string:x15d>";
        }
        fprintfields(file, str);
        closefile(file);
        thisspawnid = level.spawngameid + "<dev string:x15b>" + level.spawnid;
        if (isdefined(self.thisspawnid)) {
        }
        self.thisspawnid = thisspawnid;
    }

    // Namespace spawnlogic
    // Params 2, eflags: 0x0
    // Checksum 0x657850ae, Offset: 0x19e8
    // Size: 0x832
    function function_78353cbc(desiredid, relativepos) {
        file = openfile("<dev string:x146>", "<dev string:x17c>");
        if (file < 0) {
            return;
        }
        oldspawndata = level.curspawndata;
        level.curspawndata = undefined;
        prev = undefined;
        prevthisplayer = undefined;
        lookingfornextthisplayer = 0;
        lookingfornext = 0;
        if (isdefined(relativepos) && !isdefined(oldspawndata)) {
            return;
        }
        while (true) {
            if (freadln(file) <= 0) {
                break;
            }
            data = spawnstruct();
            data.id = fgetarg(file, 0);
            numspawns = int(fgetarg(file, 1));
            if (numspawns > 256) {
                break;
            }
            data.playername = fgetarg(file, 2);
            data.spawnpoints = [];
            data.friends = [];
            data.enemies = [];
            data.otherdata = [];
            for (i = 0; i < numspawns; i++) {
                if (freadln(file) <= 0) {
                    break;
                }
                spawnpoint = spawnstruct();
                spawnpoint.origin = function_a76187dd(fgetarg(file, 0));
                spawnpoint.winner = int(fgetarg(file, 1));
                spawnpoint.weight = int(fgetarg(file, 2));
                spawnpoint.data = [];
                spawnpoint.sightchecks = [];
                if (i == 0) {
                    data.minweight = spawnpoint.weight;
                    data.maxweight = spawnpoint.weight;
                } else {
                    if (spawnpoint.weight < data.minweight) {
                        data.minweight = spawnpoint.weight;
                    }
                    if (spawnpoint.weight > data.maxweight) {
                        data.maxweight = spawnpoint.weight;
                    }
                }
                argnum = 4;
                numdata = int(fgetarg(file, 3));
                if (numdata > 256) {
                    break;
                }
                for (j = 0; j < numdata; j++) {
                    spawnpoint.data[spawnpoint.data.size] = fgetarg(file, argnum);
                    argnum++;
                }
                numsightchecks = int(fgetarg(file, argnum));
                argnum++;
                if (numsightchecks > 256) {
                    break;
                }
                for (j = 0; j < numsightchecks; j++) {
                    index = spawnpoint.sightchecks.size;
                    spawnpoint.sightchecks[index] = spawnstruct();
                    spawnpoint.sightchecks[index].penalty = int(fgetarg(file, argnum));
                    argnum++;
                    spawnpoint.sightchecks[index].origin = function_a76187dd(fgetarg(file, argnum));
                    argnum++;
                }
                data.spawnpoints[data.spawnpoints.size] = spawnpoint;
            }
            if (!isdefined(data.minweight)) {
                data.minweight = -1;
                data.maxweight = 0;
            }
            if (data.minweight == data.maxweight) {
                data.minweight -= 1;
            }
            if (freadln(file) <= 0) {
                break;
            }
            numfriends = int(fgetarg(file, 0));
            numenemies = int(fgetarg(file, 1));
            if (numfriends > 32 || numenemies > 32) {
                break;
            }
            argnum = 2;
            for (i = 0; i < numfriends; i++) {
                data.friends[data.friends.size] = function_a76187dd(fgetarg(file, argnum));
                argnum++;
            }
            for (i = 0; i < numenemies; i++) {
                data.enemies[data.enemies.size] = function_a76187dd(fgetarg(file, argnum));
                argnum++;
            }
            if (freadln(file) <= 0) {
                break;
            }
            numotherdata = int(fgetarg(file, 0));
            argnum = 1;
            for (i = 0; i < numotherdata; i++) {
                otherdata = spawnstruct();
                otherdata.origin = function_a76187dd(fgetarg(file, argnum));
                argnum++;
                otherdata.text = fgetarg(file, argnum);
                argnum++;
                data.otherdata[data.otherdata.size] = otherdata;
            }
            if (isdefined(relativepos)) {
                if (relativepos == "<dev string:x181>") {
                    if (data.id == oldspawndata.id) {
                        level.curspawndata = prevthisplayer;
                        break;
                    }
                } else if (relativepos == "<dev string:x190>") {
                    if (data.id == oldspawndata.id) {
                        level.curspawndata = prev;
                        break;
                    }
                } else if (relativepos == "<dev string:x195>") {
                    if (lookingfornextthisplayer) {
                        level.curspawndata = data;
                        break;
                    } else if (data.id == oldspawndata.id) {
                        lookingfornextthisplayer = 1;
                    }
                } else if (relativepos == "<dev string:x1a4>") {
                    if (lookingfornext) {
                        level.curspawndata = data;
                        break;
                    } else if (data.id == oldspawndata.id) {
                        lookingfornext = 1;
                    }
                }
            } else if (data.id == desiredid) {
                level.curspawndata = data;
                break;
            }
            prev = data;
            if (isdefined(oldspawndata) && data.playername == oldspawndata.playername) {
                prevthisplayer = data;
            }
        }
        closefile(file);
    }

    // Namespace spawnlogic
    // Params 0, eflags: 0x0
    // Checksum 0x4823db7c, Offset: 0x2228
    // Size: 0x359
    function function_363025a() {
        level notify(#"drawing_spawn_data");
        level endon(#"drawing_spawn_data");
        textoffset = (0, 0, -12);
        while (true) {
            if (!isdefined(level.curspawndata)) {
                wait 0.5;
                continue;
            }
            for (i = 0; i < level.curspawndata.friends.size; i++) {
                print3d(level.curspawndata.friends[i], "<dev string:x1a9>", (0.5, 1, 0.5), 1, 5);
            }
            for (i = 0; i < level.curspawndata.enemies.size; i++) {
                print3d(level.curspawndata.enemies[i], "<dev string:x1ac>", (1, 0.5, 0.5), 1, 5);
            }
            for (i = 0; i < level.curspawndata.otherdata.size; i++) {
                print3d(level.curspawndata.otherdata[i].origin, level.curspawndata.otherdata[i].text, (0.5, 0.75, 1), 1, 2);
            }
            for (i = 0; i < level.curspawndata.spawnpoints.size; i++) {
                sp = level.curspawndata.spawnpoints[i];
                orig = sp.sighttracepoint;
                if (sp.winner) {
                    print3d(orig, level.curspawndata.playername + "<dev string:x1af>", (0.5, 0.5, 1), 1, 2);
                    orig += textoffset;
                }
                amnt = (sp.weight - level.curspawndata.minweight) / (level.curspawndata.maxweight - level.curspawndata.minweight);
                print3d(orig, "<dev string:x1bd>" + sp.weight, (1 - amnt, amnt, 0.5));
                orig += textoffset;
                for (j = 0; j < sp.data.size; j++) {
                    print3d(orig, sp.data[j], (1, 1, 1));
                    orig += textoffset;
                }
                for (j = 0; j < sp.sightchecks.size; j++) {
                    print3d(orig, "<dev string:x1c6>" + sp.sightchecks[j].penalty, (1, 0.5, 0.5));
                    orig += textoffset;
                }
            }
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 1, eflags: 0x0
    // Checksum 0xb8dc5510, Offset: 0x2590
    // Size: 0x63
    function function_88dd1973(vec) {
        return int(vec[0]) + "<dev string:x1d5>" + int(vec[1]) + "<dev string:x1d5>" + int(vec[2]);
    }

    // Namespace spawnlogic
    // Params 1, eflags: 0x0
    // Checksum 0xe1ab45b7, Offset: 0x2600
    // Size: 0x6b
    function function_a76187dd(str) {
        parts = strtok(str, "<dev string:x1d5>");
        if (parts.size != 3) {
            return (0, 0, 0);
        }
        return (int(parts[0]), int(parts[1]), int(parts[2]));
    }

#/

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x67447ae4, Offset: 0x2678
// Size: 0x81
function get_spawnpoint_random(spawnpoints) {
    if (!isdefined(spawnpoints)) {
        return undefined;
    }
    for (i = 0; i < spawnpoints.size; i++) {
        j = randomint(spawnpoints.size);
        spawnpoint = spawnpoints[i];
        spawnpoints[i] = spawnpoints[j];
        spawnpoints[j] = spawnpoint;
    }
    return get_spawnpoint_final(spawnpoints, 0);
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0xd692cb89, Offset: 0x2708
// Size: 0x83
function function_375588a3() {
    aliveplayers = [];
    for (i = 0; i < level.players.size; i++) {
        if (!isdefined(level.players[i])) {
            continue;
        }
        player = level.players[i];
        if (player.sessionstate != "playing" || player == self) {
            continue;
        }
        aliveplayers[aliveplayers.size] = player;
    }
    return aliveplayers;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xddd0b05f, Offset: 0x2798
// Size: 0x16e
function function_b8bbe7f3(obj) {
    if (level.teambased) {
        assert(isdefined(level.teams[self.team]));
        obj.allies = level.aliveplayers[self.team];
        obj.enemies = undefined;
        foreach (team in level.teams) {
            if (team == self.team) {
                continue;
            }
            if (!isdefined(obj.enemies)) {
                obj.enemies = level.aliveplayers[team];
                continue;
            }
            foreach (player in level.aliveplayers[team]) {
                obj.enemies[obj.enemies.size] = player;
            }
        }
        return;
    }
    obj.allies = [];
    obj.enemies = level.activeplayers;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x8d1f0116, Offset: 0x2910
// Size: 0x85
function function_57cf2c61(spawnpoints) {
    for (i = 0; i < spawnpoints.size; i++) {
        spawnpoints[i].weight = 0;
    }
    /#
        if (level.storespawndata || level.debugspawning) {
            for (i = 0; i < spawnpoints.size; i++) {
                spawnpoints[i].spawndata = [];
                spawnpoints[i].sightchecks = [];
            }
        }
    #/
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x77b2ec6e, Offset: 0x29a0
// Size: 0x41c
function function_a8b6ae24(spawnpoints, favoredspawnpoints) {
    if (!isdefined(spawnpoints)) {
        return undefined;
    }
    /#
        if (getdvarstring("<dev string:x1d7>") == "<dev string:x3c>") {
            setdvar("<dev string:x1d7>", "<dev string:x9f>");
        }
        if (getdvarstring("<dev string:x1d7>") == "<dev string:x1ea>") {
            return get_spawnpoint_random(spawnpoints);
        }
    #/
    if (getdvarint("scr_spawnsimple") > 0) {
        return get_spawnpoint_random(spawnpoints);
    }
    begin();
    k_favored_spawn_point_bonus = 25000;
    function_57cf2c61(spawnpoints);
    obj = spawnstruct();
    function_b8bbe7f3(obj);
    numplayers = obj.allies.size + obj.enemies.size;
    allieddistanceweight = 2;
    myteam = self.team;
    for (i = 0; i < spawnpoints.size; i++) {
        spawnpoint = spawnpoints[i];
        if (!isdefined(spawnpoint.numplayersatlastupdate)) {
            spawnpoint.numplayersatlastupdate = 0;
        }
        if (spawnpoint.numplayersatlastupdate > 0) {
            allydistsum = spawnpoint.distsum[myteam];
            enemydistsum = spawnpoint.enemydistsum[myteam];
            spawnpoint.weight = (enemydistsum - allieddistanceweight * allydistsum) / spawnpoint.numplayersatlastupdate;
            /#
                if (level.storespawndata || level.debugspawning) {
                    spawnpoint.spawndata[spawnpoint.spawndata.size] = "<dev string:x1ec>" + int(spawnpoint.weight) + "<dev string:x1fa>" + int(enemydistsum) + "<dev string:x1ff>" + allieddistanceweight + "<dev string:x203>" + int(allydistsum) + "<dev string:x205>" + spawnpoint.numplayersatlastupdate;
                }
            #/
            continue;
        }
        spawnpoint.weight = 0;
        /#
            if (level.storespawndata || level.debugspawning) {
                spawnpoint.spawndata[spawnpoint.spawndata.size] = "<dev string:x20a>";
            }
        #/
    }
    if (isdefined(favoredspawnpoints)) {
        for (i = 0; i < favoredspawnpoints.size; i++) {
            if (isdefined(favoredspawnpoints[i].weight)) {
                favoredspawnpoints[i].weight = favoredspawnpoints[i].weight + k_favored_spawn_point_bonus;
                continue;
            }
            favoredspawnpoints[i].weight = k_favored_spawn_point_bonus;
        }
    }
    function_ad490295(spawnpoints);
    function_147ebda5(spawnpoints, 1);
    function_3ed62c9(spawnpoints);
    function_ab118dbe(spawnpoints, 1);
    result = get_spawnpoint_final(spawnpoints);
    /#
        if (getdvarstring("<dev string:x219>") == "<dev string:x3c>") {
            setdvar("<dev string:x219>", "<dev string:x9f>");
        }
        if (getdvarstring("<dev string:x219>") == "<dev string:x1ea>") {
            function_d46f7aa7(result);
        }
    #/
    return result;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xee96353a, Offset: 0x2dc8
// Size: 0x1d1
function function_a1a08e8b(spawnpoints) {
    if (!isdefined(spawnpoints)) {
        return undefined;
    }
    begin();
    function_57cf2c61(spawnpoints);
    aliveplayers = function_375588a3();
    idealdist = 1600;
    baddist = 1200;
    if (aliveplayers.size > 0) {
        for (i = 0; i < spawnpoints.size; i++) {
            totaldistfromideal = 0;
            nearbybadamount = 0;
            for (j = 0; j < aliveplayers.size; j++) {
                dist = distance(spawnpoints[i].origin, aliveplayers[j].origin);
                if (dist < baddist) {
                    nearbybadamount += (baddist - dist) / baddist;
                }
                distfromideal = abs(dist - idealdist);
                totaldistfromideal += distfromideal;
            }
            avgdistfromideal = totaldistfromideal / aliveplayers.size;
            welldistancedamount = (idealdist - avgdistfromideal) / idealdist;
            spawnpoints[i].weight = welldistancedamount - nearbybadamount * 2 + randomfloat(0.2);
        }
    }
    function_ad490295(spawnpoints);
    function_147ebda5(spawnpoints, 0);
    function_3ed62c9(spawnpoints);
    function_ab118dbe(spawnpoints, 0);
    return get_spawnpoint_final(spawnpoints);
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0xee545dd5, Offset: 0x2fa8
// Size: 0x42
function begin() {
    /#
        level.storespawndata = getdvarint("<dev string:x28>");
        level.debugspawning = getdvarint("<dev string:xa1>") > 0;
    #/
}

/#

    // Namespace spawnlogic
    // Params 0, eflags: 0x0
    // Checksum 0x15fa7faa, Offset: 0x2ff8
    // Size: 0x83
    function function_f415b14() {
        while (true) {
            while (true) {
                if (getdvarint("<dev string:xb5>") > 0) {
                    break;
                }
                wait 0.05;
            }
            thread function_91a6180();
            while (true) {
                if (getdvarint("<dev string:xb5>") <= 0) {
                    break;
                }
                wait 0.05;
            }
            level notify(#"stop_spawn_profile");
        }
    }

    // Namespace spawnlogic
    // Params 0, eflags: 0x0
    // Checksum 0xe7bb674a, Offset: 0x3088
    // Size: 0xc5
    function function_91a6180() {
        level endon(#"stop_spawn_profile");
        while (true) {
            if (level.players.size > 0 && level.spawnpoints.size > 0) {
                playernum = randomint(level.players.size);
                player = level.players[playernum];
                attempt = 1;
                while (!isdefined(player) && attempt < level.players.size) {
                    playernum = (playernum + 1) % level.players.size;
                    attempt++;
                    player = level.players[playernum];
                }
                player function_a8b6ae24(level.spawnpoints);
            }
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 0, eflags: 0x0
    // Checksum 0xf5f3e099, Offset: 0x3158
    // Size: 0x3f
    function function_e2e4ca72() {
        while (true) {
            if (getdvarint("<dev string:x22b>") < 1) {
                wait 3;
                continue;
            }
            thread function_ee9ff5a7();
            return;
        }
    }

    // Namespace spawnlogic
    // Params 0, eflags: 0x0
    // Checksum 0x971db58a, Offset: 0x31a0
    // Size: 0x435
    function function_ee9ff5a7() {
        w = 20;
        h = 20;
        weightscale = 0.1;
        fakespawnpoints = [];
        corners = getentarray("<dev string:x23a>", "<dev string:x249>");
        if (corners.size != 2) {
            println("<dev string:x254>");
            return;
        }
        min = corners[0].origin;
        max = corners[0].origin;
        if (corners[1].origin[0] > max[0]) {
            max = (corners[1].origin[0], max[1], max[2]);
        } else {
            min = (corners[1].origin[0], min[1], min[2]);
        }
        if (corners[1].origin[1] > max[1]) {
            max = (max[0], corners[1].origin[1], max[2]);
        } else {
            min = (min[0], corners[1].origin[1], min[2]);
        }
        i = 0;
        for (y = 0; y < h; y++) {
            yamnt = y / (h - 1);
            for (x = 0; x < w; x++) {
                xamnt = x / (w - 1);
                fakespawnpoints[i] = spawnstruct();
                fakespawnpoints[i].origin = (min[0] * xamnt + max[0] * (1 - xamnt), min[1] * yamnt + max[1] * (1 - yamnt), min[2]);
                fakespawnpoints[i].angles = (0, 0, 0);
                fakespawnpoints[i].forward = anglestoforward(fakespawnpoints[i].angles);
                fakespawnpoints[i].sighttracepoint = fakespawnpoints[i].origin;
                i++;
            }
        }
        didweights = 0;
        while (true) {
            spawni = 0;
            numiters = 5;
            for (i = 0; i < numiters; i++) {
                if (!level.players.size || !isdefined(level.players[0].team) || level.players[0].team == "<dev string:x27d>" || !isdefined(level.players[0].curclass)) {
                    break;
                }
                endspawni = spawni + fakespawnpoints.size / numiters;
                if (i == numiters - 1) {
                    endspawni = fakespawnpoints.size;
                }
                while (spawni < endspawni) {
                    function_bb6a45e8(fakespawnpoints[spawni]);
                    spawni++;
                }
                if (didweights) {
                    level.players[0] function_714f6572(fakespawnpoints, w, h, weightscale);
                }
                wait 0.05;
            }
            if (!level.players.size || !isdefined(level.players[0].team) || level.players[0].team == "<dev string:x27d>" || !isdefined(level.players[0].curclass)) {
                wait 1;
                continue;
            }
            level.players[0] function_a8b6ae24(fakespawnpoints);
            for (i = 0; i < fakespawnpoints.size; i++) {
                function_3bdbf842(fakespawnpoints[i], weightscale);
            }
            didweights = 1;
            level.players[0] function_714f6572(fakespawnpoints, w, h, weightscale);
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 4, eflags: 0x0
    // Checksum 0x9cfdea34, Offset: 0x35e0
    // Size: 0xd9
    function function_714f6572(fakespawnpoints, w, h, weightscale) {
        i = 0;
        for (y = 0; y < h; y++) {
            yamnt = y / (h - 1);
            for (x = 0; x < w; x++) {
                xamnt = x / (w - 1);
                if (y > 0) {
                    function_8965f304(fakespawnpoints[i], fakespawnpoints[i - w], weightscale);
                }
                if (x > 0) {
                    function_8965f304(fakespawnpoints[i], fakespawnpoints[i - 1], weightscale);
                }
                i++;
            }
        }
    }

    // Namespace spawnlogic
    // Params 2, eflags: 0x0
    // Checksum 0x109ad4fd, Offset: 0x36c8
    // Size: 0x46
    function function_3bdbf842(s1, weightscale) {
        s1.visible = 1;
        if (s1.weight < -1000 / weightscale) {
            s1.visible = 0;
        }
    }

    // Namespace spawnlogic
    // Params 3, eflags: 0x0
    // Checksum 0x227c6b54, Offset: 0x3718
    // Size: 0x9a
    function function_8965f304(s1, s2, weightscale) {
        if (!s1.visible || !s2.visible) {
            return;
        }
        p1 = s1.origin + (0, 0, s1.weight * weightscale + 100);
        p2 = s2.origin + (0, 0, s2.weight * weightscale + 100);
        line(p1, p2, (1, 1, 1));
    }

    // Namespace spawnlogic
    // Params 0, eflags: 0x0
    // Checksum 0x2355ac9d, Offset: 0x37c0
    // Size: 0x299
    function function_d320505c() {
        while (true) {
            if (getdvarint("<dev string:x3d>") < 1) {
                wait 3;
                continue;
            }
            if (!isdefined(level.players)) {
                wait 0.05;
                continue;
            }
            bots = [];
            for (i = 0; i < level.players.size; i++) {
                if (!isdefined(level.players[i])) {
                    continue;
                }
                if (level.players[i].sessionstate == "<dev string:x111>" && issubstr(level.players[i].name, "<dev string:x287>")) {
                    bots[bots.size] = level.players[i];
                }
            }
            if (bots.size > 0) {
                if (getdvarint("<dev string:x3d>") == 1) {
                    killer = bots[randomint(bots.size)];
                    victim = bots[randomint(bots.size)];
                    victim thread [[ level.callbackplayerdamage ]](killer, killer, 1000, 0, "<dev string:x28b>", level.weaponnone, (0, 0, 0), (0, 0, 0), "<dev string:x29c>", (0, 0, 0), 0, 0, (1, 0, 0));
                } else {
                    numkills = getdvarint("<dev string:x3d>");
                    lastvictim = undefined;
                    for (index = 0; index < numkills; index++) {
                        killer = bots[randomint(bots.size)];
                        for (victim = bots[randomint(bots.size)]; isdefined(lastvictim) && victim == lastvictim; victim = bots[randomint(bots.size)]) {
                        }
                        victim thread [[ level.callbackplayerdamage ]](killer, killer, 1000, 0, "<dev string:x28b>", "<dev string:x29c>", (0, 0, 0), (0, 0, 0), "<dev string:x29c>", (0, 0, 0), 0, 0, (1, 0, 0));
                        lastvictim = victim;
                    }
                }
            }
            if (getdvarstring("<dev string:x4a>") != "<dev string:x3c>") {
                wait getdvarfloat("<dev string:x4a>");
                continue;
            }
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 0, eflags: 0x0
    // Checksum 0x4da3a7ca, Offset: 0x3a68
    // Size: 0x17d
    function function_8384886e() {
        setdvar("<dev string:x2a1>", "<dev string:x3c>");
        prevval = getdvarstring("<dev string:x2a1>");
        prevrelval = getdvarstring("<dev string:x2b1>");
        readthistime = 0;
        while (true) {
            val = getdvarstring("<dev string:x2a1>");
            relval = undefined;
            if (!isdefined(val) || val == prevval) {
                relval = getdvarstring("<dev string:x2b1>");
                if (isdefined(relval) && relval != "<dev string:x3c>") {
                    setdvar("<dev string:x2b1>", "<dev string:x3c>");
                } else {
                    wait 0.5;
                    continue;
                }
            }
            prevval = val;
            readthistime = 0;
            function_78353cbc(val, relval);
            if (!isdefined(level.curspawndata)) {
                println("<dev string:x2c2>");
            } else {
                println("<dev string:x2d9>" + level.curspawndata.id);
            }
            thread function_363025a();
        }
    }

    // Namespace spawnlogic
    // Params 0, eflags: 0x0
    // Checksum 0x18e5a021, Offset: 0x3bf0
    // Size: 0x391
    function function_76bb9fb8() {
        while (true) {
            if (getdvarstring("<dev string:xa1>") == "<dev string:x9f>") {
                wait 3;
                continue;
            }
            time = gettime();
            for (i = 0; i < level.spawnlogic_deaths.size; i++) {
                if (isdefined(level.spawnlogic_deaths[i].los)) {
                    line(level.spawnlogic_deaths[i].org, level.spawnlogic_deaths[i].killorg, (1, 0, 0));
                } else {
                    line(level.spawnlogic_deaths[i].org, level.spawnlogic_deaths[i].killorg, (1, 1, 1));
                }
                killer = level.spawnlogic_deaths[i].killer;
                if (isdefined(killer) && isalive(killer)) {
                    line(level.spawnlogic_deaths[i].killorg, killer.origin, (0.4, 0.4, 0.8));
                }
            }
            for (p = 0; p < level.players.size; p++) {
                if (!isdefined(level.players[p])) {
                    continue;
                }
                if (isdefined(level.players[p].spawnlogic_killdist)) {
                    print3d(level.players[p].origin + (0, 0, 64), level.players[p].spawnlogic_killdist, (1, 1, 1));
                }
            }
            oldspawnkills = level.spawnlogic_spawnkills;
            level.spawnlogic_spawnkills = [];
            for (i = 0; i < oldspawnkills.size; i++) {
                spawnkill = oldspawnkills[i];
                if (spawnkill.var_349bc34) {
                    line(spawnkill.spawnpointorigin, spawnkill.dierorigin, (0.4, 0.5, 0.4));
                    line(spawnkill.dierorigin, spawnkill.killerorigin, (0, 1, 1));
                    print3d(spawnkill.dierorigin + (0, 0, 32), "<dev string:x2eb>", (0, 1, 1));
                } else {
                    line(spawnkill.spawnpointorigin, spawnkill.killerorigin, (0.4, 0.5, 0.4));
                    line(spawnkill.killerorigin, spawnkill.dierorigin, (0, 1, 1));
                    print3d(spawnkill.dierorigin + (0, 0, 32), "<dev string:x2f8>", (0, 1, 1));
                }
                if (time - spawnkill.time < 60000) {
                    level.spawnlogic_spawnkills[level.spawnlogic_spawnkills.size] = oldspawnkills[i];
                }
            }
            wait 0.05;
        }
    }

#/

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0x1cf8e6ac, Offset: 0x3f90
// Size: 0x41
function function_403f0d14() {
    while (true) {
        if (getdvarstring("scr_spawnpointdebug") == "0") {
            wait 3;
            continue;
        }
        function_1acf6a5c();
        wait 3;
    }
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x7ff04cee, Offset: 0x3fe0
// Size: 0x221
function function_f5751b11(spawnpoints) {
    level notify(#"stop_spawn_weight_debug");
    level endon(#"stop_spawn_weight_debug");
    /#
        while (true) {
            if (getdvarstring("<dev string:xa1>") == "<dev string:x9f>") {
                wait 3;
                continue;
            }
            textoffset = (0, 0, -12);
            for (i = 0; i < spawnpoints.size; i++) {
                amnt = 1 * (1 - spawnpoints[i].weight / -100000);
                if (amnt < 0) {
                    amnt = 0;
                }
                if (amnt > 1) {
                    amnt = 1;
                }
                orig = spawnpoints[i].origin + (0, 0, 80);
                print3d(orig, int(spawnpoints[i].weight), (1, amnt, 0.5));
                orig += textoffset;
                if (isdefined(spawnpoints[i].spawndata)) {
                    for (j = 0; j < spawnpoints[i].spawndata.size; j++) {
                        print3d(orig, spawnpoints[i].spawndata[j], (0.5, 0.5, 0.5));
                        orig += textoffset;
                    }
                }
                if (isdefined(spawnpoints[i].sightchecks)) {
                    for (j = 0; j < spawnpoints[i].sightchecks.size; j++) {
                        if (spawnpoints[i].sightchecks[j].penalty == 0) {
                            continue;
                        }
                        print3d(orig, "<dev string:x303>" + spawnpoints[i].sightchecks[j].penalty, (0.5, 0.5, 0.5));
                        orig += textoffset;
                    }
                }
            }
            wait 0.05;
        }
    #/
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0x7f6a9fa3, Offset: 0x4210
// Size: 0xbd
function function_9ce570b0() {
    while (true) {
        if (getdvarstring("scr_spawnpointprofile") != "1") {
            wait 3;
            continue;
        }
        for (i = 0; i < level.spawnpoints.size; i++) {
            level.spawnpoints[i].weight = randomint(10000);
        }
        if (level.players.size > 0) {
            level.players[randomint(level.players.size)] function_a8b6ae24(level.spawnpoints);
        }
        wait 0.05;
    }
}

/#

    // Namespace spawnlogic
    // Params 2, eflags: 0x0
    // Checksum 0x31774e0f, Offset: 0x42d8
    // Size: 0xa9
    function function_d98d4227(players, origin) {
        if (getdvarstring("<dev string:xa1>") == "<dev string:x9f>") {
            return;
        }
        starttime = gettime();
        while (true) {
            for (i = 0; i < players.size; i++) {
                line(players[i].origin, origin, (0.5, 1, 0.5));
            }
            if (gettime() - starttime > 5000) {
                return;
            }
            wait 0.05;
        }
    }

#/

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x45adaad8, Offset: 0x4390
// Size: 0x12
function function_d5c89a1f(dier, killer) {
    
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xe7aea5e9, Offset: 0x43b0
// Size: 0xd5
function function_bf793871(deathinfo) {
    for (i = 0; i < level.spawnlogic_deaths.size; i++) {
        if (level.spawnlogic_deaths[i].killer == deathinfo.killer) {
            dist = distance(level.spawnlogic_deaths[i].org, deathinfo.org);
            if (dist > -56) {
                continue;
            }
            dist = distance(level.spawnlogic_deaths[i].killorg, deathinfo.killorg);
            if (dist > -56) {
                continue;
            }
            level.spawnlogic_deaths[i].remove = 1;
        }
    }
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0xa01e327e, Offset: 0x4490
// Size: 0x161
function function_1acf6a5c() {
    time = gettime();
    for (i = 0; i < level.spawnlogic_deaths.size; i++) {
        deathinfo = level.spawnlogic_deaths[i];
        if (time - deathinfo.time > 90000 || !isdefined(deathinfo.killer) || !isalive(deathinfo.killer) || !isdefined(level.teams[deathinfo.killer.team]) || distance(deathinfo.killer.origin, deathinfo.killorg) > 400) {
            level.spawnlogic_deaths[i].remove = 1;
        }
    }
    oldarray = level.spawnlogic_deaths;
    level.spawnlogic_deaths = [];
    start = 0;
    if (oldarray.size - 1024 > 0) {
        start = oldarray.size - 1024;
    }
    for (i = start; i < oldarray.size; i++) {
        if (!isdefined(oldarray[i].remove)) {
            level.spawnlogic_deaths[level.spawnlogic_deaths.size] = oldarray[i];
        }
    }
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xc187b564, Offset: 0x4600
// Size: 0xf5
function function_cb4bd6bd(playerorigin) {
    pos = self.origin + level.var_67efebc4;
    playerpos = playerorigin + (0, 0, 32);
    distsqrd = distancesquared(pos, playerpos);
    forward = anglestoforward(self.angles);
    if (distsqrd < level.var_bbbc02ee * level.var_bbbc02ee) {
        playerdir = vectornormalize(playerpos - pos);
        angle = acos(vectordot(playerdir, forward));
        if (angle < level.var_545a87d2) {
            return true;
        }
    }
    return false;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x660c2665, Offset: 0x4700
// Size: 0x197
function function_3ed62c9(spawnpoints) {
    if (getdvarstring("scr_spawnpointnewlogic") == "0") {
        return;
    }
    weapondamagepenalty = 100000;
    if (getdvarstring("scr_spawnpointweaponpenalty") != "" && getdvarstring("scr_spawnpointweaponpenalty") != "0") {
        weapondamagepenalty = getdvarfloat("scr_spawnpointweaponpenalty");
    }
    mingrenadedistsquared = 62500;
    for (i = 0; i < spawnpoints.size; i++) {
        for (j = 0; j < level.grenades.size; j++) {
            if (!isdefined(level.grenades[j])) {
                continue;
            }
            if (distancesquared(spawnpoints[i].origin, level.grenades[j].origin) < mingrenadedistsquared) {
                spawnpoints[i].weight = spawnpoints[i].weight - weapondamagepenalty;
                /#
                    if (level.storespawndata || level.debugspawning) {
                        spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "<dev string:x315>" + int(weapondamagepenalty);
                    }
                #/
            }
        }
    }
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0xfb719bfa, Offset: 0x48a0
// Size: 0x5d
function function_d43d261c() {
    spawnpointindex = 0;
    while (true) {
        wait 0.05;
        if (!isdefined(level.spawnpoints)) {
            return;
        }
        spawnpointindex = (spawnpointindex + 1) % level.spawnpoints.size;
        spawnpoint = level.spawnpoints[spawnpointindex];
        function_bb6a45e8(spawnpoint);
    }
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0xc86115d8, Offset: 0x4908
// Size: 0x87
function function_30934c61(skip_team, sums) {
    value = 0;
    foreach (team in level.teams) {
        if (team == skip_team) {
            continue;
        }
        value += sums[team];
    }
    return value;
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x642caf9f, Offset: 0x4998
// Size: 0x93
function function_5218c147(skip_team, mindists) {
    dist = 9999999;
    foreach (team in level.teams) {
        if (team == skip_team) {
            continue;
        }
        if (dist > mindists[team]) {
            dist = mindists[team];
        }
    }
    return dist;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xd6c46988, Offset: 0x4a38
// Size: 0x4db
function function_bb6a45e8(spawnpoint) {
    if (level.teambased) {
        sights = [];
        foreach (team in level.teams) {
            spawnpoint.enemysights[team] = 0;
            sights[team] = 0;
            spawnpoint.nearbyplayers[team] = [];
        }
    } else {
        spawnpoint.enemysights = 0;
        spawnpoint.nearbyplayers["all"] = [];
    }
    spawnpointdir = spawnpoint.forward;
    debug = 0;
    /#
        debug = getdvarint("<dev string:xa1>") > 0;
    #/
    mindist = [];
    distsum = [];
    if (!level.teambased) {
        mindist["all"] = 9999999;
    }
    foreach (team in level.teams) {
        spawnpoint.distsum[team] = 0;
        spawnpoint.enemydistsum[team] = 0;
        spawnpoint.minenemydist[team] = 9999999;
        mindist[team] = 9999999;
    }
    spawnpoint.numplayersatlastupdate = 0;
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (player.sessionstate != "playing") {
            continue;
        }
        diff = player.origin - spawnpoint.origin;
        diff = (diff[0], diff[1], 0);
        dist = length(diff);
        team = "all";
        if (level.teambased) {
            team = player.team;
        }
        if (dist < 1024) {
            spawnpoint.nearbyplayers[team][spawnpoint.nearbyplayers[team].size] = player;
        }
        if (dist < mindist[team]) {
            mindist[team] = dist;
        }
        distsum[team] = distsum[team] + dist;
        spawnpoint.numplayersatlastupdate++;
        pdir = anglestoforward(player.angles);
        if (vectordot(spawnpointdir, diff) < 0 && vectordot(pdir, diff) > 0) {
            continue;
        }
        losexists = bullettracepassed(player.origin + (0, 0, 50), spawnpoint.sighttracepoint, 0, undefined);
        spawnpoint.lastsighttracetime = gettime();
        if (losexists) {
            if (level.teambased) {
                sights[player.team]++;
            } else {
                spawnpoint.enemysights++;
            }
            /#
                if (debug) {
                    line(player.origin + (0, 0, 50), spawnpoint.sighttracepoint, (0.5, 1, 0.5));
                }
            #/
        }
    }
    if (level.teambased) {
        foreach (team in level.teams) {
            spawnpoint.enemysights[team] = function_30934c61(team, sights);
            spawnpoint.minenemydist[team] = function_5218c147(team, mindist);
            spawnpoint.distsum[team] = distsum[team];
            spawnpoint.enemydistsum[team] = function_30934c61(team, distsum);
        }
        return;
    }
    spawnpoint.distsum["all"] = distsum["all"];
    spawnpoint.enemydistsum["all"] = distsum["all"];
    spawnpoint.minenemydist["all"] = mindist["all"];
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0x6a298d33, Offset: 0x4f20
// Size: 0x61
function function_e40b0d5e() {
    if (getdvarstring("scr_spawnpointlospenalty") != "" && getdvarstring("scr_spawnpointlospenalty") != "0") {
        return getdvarfloat("scr_spawnpointlospenalty");
    }
    return 100000;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xfcb0cc7f, Offset: 0x4f90
// Size: 0x209
function function_b7cf3433(spawnpoint) {
    if (!isdefined(spawnpoint.nearbyplayers)) {
        return false;
    }
    closest = undefined;
    closestdistsq = undefined;
    secondclosest = undefined;
    secondclosestdistsq = undefined;
    foreach (team in spawnpoint.nearbyplayers) {
        if (team == self.team) {
            continue;
        }
        for (i = 0; i < spawnpoint.nearbyplayers[team].size; i++) {
            player = spawnpoint.nearbyplayers[team][i];
            if (!isdefined(player)) {
                continue;
            }
            if (player.sessionstate != "playing") {
                continue;
            }
            if (player == self) {
                continue;
            }
            distsq = distancesquared(spawnpoint.origin, player.origin);
            if (!isdefined(closest) || distsq < closestdistsq) {
                secondclosest = closest;
                secondclosestdistsq = closestdistsq;
                closest = player;
                closestdistsq = distsq;
                continue;
            }
            if (!isdefined(secondclosest) || distsq < secondclosestdistsq) {
                secondclosest = player;
                secondclosestdistsq = distsq;
            }
        }
    }
    if (isdefined(closest)) {
        if (bullettracepassed(closest.origin + (0, 0, 50), spawnpoint.sighttracepoint, 0, undefined)) {
            return true;
        }
    }
    if (isdefined(secondclosest)) {
        if (bullettracepassed(secondclosest.origin + (0, 0, 50), spawnpoint.sighttracepoint, 0, undefined)) {
            return true;
        }
    }
    return false;
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x594fa90, Offset: 0x51a8
// Size: 0x3f1
function function_ab118dbe(spawnpoints, teambased) {
    if (getdvarstring("scr_spawnpointnewlogic") == "0") {
        return;
    }
    lospenalty = function_e40b0d5e();
    mindistteam = self.team;
    if (teambased) {
        for (i = 0; i < spawnpoints.size; i++) {
            if (!isdefined(spawnpoints[i].enemysights)) {
                continue;
            }
            penalty = lospenalty * spawnpoints[i].enemysights[self.team];
            spawnpoints[i].weight = spawnpoints[i].weight - penalty;
            /#
                if (level.storespawndata || level.debugspawning) {
                    index = spawnpoints[i].sightchecks.size;
                    spawnpoints[i].sightchecks[index] = spawnstruct();
                    spawnpoints[i].sightchecks[index].penalty = penalty;
                }
            #/
        }
    } else {
        for (i = 0; i < spawnpoints.size; i++) {
            if (!isdefined(spawnpoints[i].enemysights)) {
                continue;
            }
            penalty = lospenalty * spawnpoints[i].enemysights;
            spawnpoints[i].weight = spawnpoints[i].weight - penalty;
            /#
                if (level.storespawndata || level.debugspawning) {
                    index = spawnpoints[i].sightchecks.size;
                    spawnpoints[i].sightchecks[index] = spawnstruct();
                    spawnpoints[i].sightchecks[index].penalty = penalty;
                }
            #/
        }
        mindistteam = "all";
    }
    avoidweight = getdvarfloat("scr_spawn_enemyavoidweight");
    if (avoidweight != 0) {
        nearbyenemyouterrange = getdvarfloat("scr_spawn_enemyavoiddist");
        nearbyenemyouterrangesq = nearbyenemyouterrange * nearbyenemyouterrange;
        nearbyenemypenalty = 1500 * avoidweight;
        nearbyenemyminorpenalty = 800 * avoidweight;
        lastattackerorigin = (-99999, -99999, -99999);
        lastdeathpos = (-99999, -99999, -99999);
        if (isalive(self.lastattacker)) {
            lastattackerorigin = self.lastattacker.origin;
        }
        if (isdefined(self.lastdeathpos)) {
            lastdeathpos = self.lastdeathpos;
        }
        for (i = 0; i < spawnpoints.size; i++) {
            mindist = spawnpoints[i].minenemydist[mindistteam];
            if (mindist < nearbyenemyouterrange * 2) {
                penalty = nearbyenemyminorpenalty * (1 - mindist / nearbyenemyouterrange * 2);
                if (mindist < nearbyenemyouterrange) {
                    penalty += nearbyenemypenalty * (1 - mindist / nearbyenemyouterrange);
                }
                if (penalty > 0) {
                    spawnpoints[i].weight = spawnpoints[i].weight - penalty;
                    /#
                        if (level.storespawndata || level.debugspawning) {
                            spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "<dev string:x329>" + int(spawnpoints[i].minenemydist[mindistteam]) + "<dev string:x33b>" + int(penalty);
                        }
                    #/
                }
            }
        }
    }
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x20986cbb, Offset: 0x55a8
// Size: 0x1eb
function function_147ebda5(spawnpoints, teambased) {
    if (getdvarstring("scr_spawnpointnewlogic") == "0") {
        return;
    }
    time = gettime();
    maxtime = 10000;
    maxdistsq = 1048576;
    for (i = 0; i < spawnpoints.size; i++) {
        spawnpoint = spawnpoints[i];
        if (!isdefined(spawnpoint.lastspawnedplayer) || !isdefined(spawnpoint.lastspawntime) || !isalive(spawnpoint.lastspawnedplayer)) {
            continue;
        }
        if (spawnpoint.lastspawnedplayer == self) {
            continue;
        }
        if (teambased && spawnpoint.lastspawnedplayer.team == self.team) {
            continue;
        }
        timepassed = time - spawnpoint.lastspawntime;
        if (timepassed < maxtime) {
            distsq = distancesquared(spawnpoint.lastspawnedplayer.origin, spawnpoint.origin);
            if (distsq < maxdistsq) {
                worsen = 5000 * (1 - distsq / maxdistsq) * (1 - timepassed / maxtime);
                spawnpoint.weight -= worsen;
                /#
                    if (level.storespawndata || level.debugspawning) {
                        spawnpoint.spawndata[spawnpoint.spawndata.size] = "<dev string:x345>" + worsen;
                    }
                #/
            } else {
                spawnpoint.lastspawnedplayer = undefined;
            }
            continue;
        }
        spawnpoint.lastspawnedplayer = undefined;
    }
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x1437dc6f, Offset: 0x57a0
// Size: 0xc5
function function_ad490295(spawnpoints) {
    if (getdvarstring("scr_spawnpointnewlogic") == "0") {
        return;
    }
    if (!isdefined(self.lastspawnpoint)) {
        return;
    }
    for (i = 0; i < spawnpoints.size; i++) {
        if (spawnpoints[i] == self.lastspawnpoint) {
            spawnpoints[i].weight = spawnpoints[i].weight - 50000;
            /#
                if (level.storespawndata || level.debugspawning) {
                    spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "<dev string:x35a>";
                }
            #/
            break;
        }
    }
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0xe5ea480c, Offset: 0x5870
// Size: 0x76
function get_random_intermission_point() {
    spawnpoints = function_12d810b4("mp_global_intermission");
    if (!spawnpoints.size) {
        spawnpoints = function_12d810b4("info_player_start");
    }
    assert(spawnpoints.size);
    spawnpoint = get_spawnpoint_random(spawnpoints);
    return spawnpoint;
}

