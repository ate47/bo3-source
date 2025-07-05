#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/system_shared;

#namespace spawnlogic;

// Namespace spawnlogic
// Params 0, eflags: 0x2
// Checksum 0x13ec583f, Offset: 0x210
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("spawnlogic", &__init__, undefined, undefined);
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0x70e22872, Offset: 0x250
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&main);
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0xe63cc88e, Offset: 0x280
// Size: 0x3bc
function main() {
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
        thread loopbotspawns();
    #/
    level.spawnlogic_deaths = [];
    level.spawnlogic_spawnkills = [];
    level.players = [];
    level.grenades = [];
    level.pipebombs = [];
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    level.spawnminsmaxsprimed = 0;
    if (isdefined(level.safespawns)) {
        for (i = 0; i < level.safespawns.size; i++) {
            level.safespawns[i] spawnpointinit();
        }
    }
    if (getdvarstring("scr_spawn_enemyavoiddist") == "") {
        setdvar("scr_spawn_enemyavoiddist", "800");
    }
    if (getdvarstring("scr_spawn_enemyavoidweight") == "") {
        setdvar("scr_spawn_enemyavoidweight", "0");
    }
    /#
        if (getdvarstring("<dev string:x5b>") == "<dev string:x3c>") {
            setdvar("<dev string:x5b>", "<dev string:x6b>");
        }
        if (getdvarstring("<dev string:x6d>") == "<dev string:x3c>") {
            setdvar("<dev string:x6d>", "<dev string:x6b>");
        }
        if (getdvarint("<dev string:x6d>") > 0) {
            thread showdeathsdebug();
            thread updatedeathinfodebug();
            thread profiledebug();
        }
        if (level.storespawndata) {
            thread allowspawndatareading();
        }
        if (getdvarstring("<dev string:x81>") == "<dev string:x3c>") {
            setdvar("<dev string:x81>", "<dev string:x6b>");
        }
        thread watchspawnprofile();
        thread spawngraphcheck();
    #/
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x741b132f, Offset: 0x648
// Size: 0x76
function findboxcenter(mins, maxs) {
    center = (0, 0, 0);
    center = maxs - mins;
    center = (center[0] / 2, center[1] / 2, center[2] / 2) + mins;
    return center;
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x6ec732d3, Offset: 0x6c8
// Size: 0xce
function expandmins(mins, point) {
    if (mins[0] > point[0]) {
        mins = (point[0], mins[1], mins[2]);
    }
    if (mins[1] > point[1]) {
        mins = (mins[0], point[1], mins[2]);
    }
    if (mins[2] > point[2]) {
        mins = (mins[0], mins[1], point[2]);
    }
    return mins;
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x2695103b, Offset: 0x7a0
// Size: 0xce
function expandmaxs(maxs, point) {
    if (maxs[0] < point[0]) {
        maxs = (point[0], maxs[1], maxs[2]);
    }
    if (maxs[1] < point[1]) {
        maxs = (maxs[0], point[1], maxs[2]);
    }
    if (maxs[2] < point[2]) {
        maxs = (maxs[0], maxs[1], point[2]);
    }
    return maxs;
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x968f6d4e, Offset: 0x878
// Size: 0x234
function addspawnpointsinternal(team, spawnpointname) {
    oldspawnpoints = [];
    if (level.teamspawnpoints[team].size) {
        oldspawnpoints = level.teamspawnpoints[team];
    }
    level.teamspawnpoints[team] = getspawnpointarray(spawnpointname);
    if (!isdefined(level.spawnpoints)) {
        level.spawnpoints = [];
    }
    for (index = 0; index < level.teamspawnpoints[team].size; index++) {
        spawnpoint = level.teamspawnpoints[team][index];
        if (!isdefined(spawnpoint.inited)) {
            spawnpoint spawnpointinit();
            level.spawnpoints[level.spawnpoints.size] = spawnpoint;
        }
    }
    for (index = 0; index < oldspawnpoints.size; index++) {
        origin = oldspawnpoints[index].origin;
        level.spawnmins = expandmins(level.spawnmins, origin);
        level.spawnmaxs = expandmaxs(level.spawnmaxs, origin);
        level.teamspawnpoints[team][level.teamspawnpoints[team].size] = oldspawnpoints[index];
    }
    if (!level.teamspawnpoints[team].size) {
        println("<dev string:x92>" + spawnpointname + "<dev string:x9f>");
        callback::abort_level();
        wait 1;
        return;
    }
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0xcf32eeb9, Offset: 0xab8
// Size: 0x9a
function clearspawnpoints() {
    foreach (team in level.teams) {
        level.teamspawnpoints[team] = [];
    }
    level.spawnpoints = [];
    level.unified_spawn_points = undefined;
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x6b27c310, Offset: 0xb60
// Size: 0x5c
function addspawnpoints(team, spawnpointname) {
    addspawnpointclassname(spawnpointname);
    addspawnpointteamclassname(team, spawnpointname);
    addspawnpointsinternal(team, spawnpointname);
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x8b7a34be, Offset: 0xbc8
// Size: 0x7e
function rebuildspawnpoints(team) {
    level.teamspawnpoints[team] = [];
    for (index = 0; index < level.spawn_point_team_class_names[team].size; index++) {
        addspawnpointsinternal(team, level.spawn_point_team_class_names[team][index]);
    }
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xf05a11b3, Offset: 0xc50
// Size: 0x138
function placespawnpoints(spawnpointname) {
    addspawnpointclassname(spawnpointname);
    spawnpoints = getspawnpointarray(spawnpointname);
    /#
        if (!isdefined(level.extraspawnpointsused)) {
            level.extraspawnpointsused = [];
        }
    #/
    if (!spawnpoints.size) {
        println("<dev string:xbc>" + spawnpointname + "<dev string:x9f>");
        callback::abort_level();
        wait 1;
        return;
    }
    for (index = 0; index < spawnpoints.size; index++) {
        spawnpoints[index] spawnpointinit();
        /#
            spawnpoints[index].fakeclassname = spawnpointname;
            level.extraspawnpointsused[level.extraspawnpointsused.size] = spawnpoints[index];
        #/
    }
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x2828f42, Offset: 0xd90
// Size: 0xae
function dropspawnpoints(spawnpointname) {
    spawnpoints = getspawnpointarray(spawnpointname);
    if (!spawnpoints.size) {
        println("<dev string:xbc>" + spawnpointname + "<dev string:x9f>");
        return;
    }
    for (index = 0; index < spawnpoints.size; index++) {
        spawnpoints[index] placespawnpoint();
    }
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xa21098c8, Offset: 0xe48
// Size: 0x3a
function addspawnpointclassname(spawnpointclassname) {
    if (!isdefined(level.spawn_point_class_names)) {
        level.spawn_point_class_names = [];
    }
    level.spawn_point_class_names[level.spawn_point_class_names.size] = spawnpointclassname;
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x614ef82b, Offset: 0xe90
// Size: 0x38
function addspawnpointteamclassname(team, spawnpointclassname) {
    level.spawn_point_team_class_names[team][level.spawn_point_team_class_names[team].size] = spawnpointclassname;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x121e7d34, Offset: 0xed0
// Size: 0xba
function getspawnpointarray(classname) {
    spawnpoints = getentarray(classname, "classname");
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
// Checksum 0x490b5164, Offset: 0xf98
// Size: 0x138
function spawnpointinit() {
    spawnpoint = self;
    origin = spawnpoint.origin;
    if (!level.spawnminsmaxsprimed) {
        level.spawnmins = origin;
        level.spawnmaxs = origin;
        level.spawnminsmaxsprimed = 1;
    } else {
        level.spawnmins = expandmins(level.spawnmins, origin);
        level.spawnmaxs = expandmaxs(level.spawnmaxs, origin);
    }
    spawnpoint placespawnpoint();
    spawnpoint.forward = anglestoforward(spawnpoint.angles);
    spawnpoint.sighttracepoint = spawnpoint.origin + (0, 0, 50);
    spawnpoint.inited = 1;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x24c23f10, Offset: 0x10d8
// Size: 0x18
function getteamspawnpoints(team) {
    return level.teamspawnpoints[team];
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0xa35be266, Offset: 0x10f8
// Size: 0x240
function getspawnpoint_final(spawnpoints, useweights) {
    bestspawnpoint = undefined;
    if (!isdefined(spawnpoints) || spawnpoints.size == 0) {
        return undefined;
    }
    if (!isdefined(useweights)) {
        useweights = 1;
    }
    if (useweights) {
        bestspawnpoint = getbestweightedspawnpoint(spawnpoints);
        thread spawnweightdebug(spawnpoints);
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
    self finalizespawnpointchoice(bestspawnpoint);
    /#
        self storespawndata(spawnpoints, useweights, bestspawnpoint);
    #/
    return bestspawnpoint;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x53f90906, Offset: 0x1340
// Size: 0x58
function finalizespawnpointchoice(spawnpoint) {
    time = gettime();
    self.lastspawnpoint = spawnpoint;
    self.lastspawntime = time;
    spawnpoint.lastspawnedplayer = self;
    spawnpoint.lastspawntime = time;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xc848704, Offset: 0x13a0
// Size: 0x2b6
function getbestweightedspawnpoint(spawnpoints) {
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
        if (!lastminutesighttraces(bestspawnpoint)) {
            return bestspawnpoint;
        }
        penalty = getlospenalty();
        /#
            if (level.storespawndata || level.debugspawning) {
                bestspawnpoint.spawndata[bestspawnpoint.spawndata.size] = "<dev string:xc2>" + penalty;
            }
        #/
        bestspawnpoint.weight -= penalty;
        bestspawnpoint.lastsighttracetime = gettime();
    }
}

/#

    // Namespace spawnlogic
    // Params 1, eflags: 0x0
    // Checksum 0x7de1d6ab, Offset: 0x1660
    // Size: 0x156
    function checkbad(spawnpoint) {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (!isalive(player) || player.sessionstate != "<dev string:xdd>") {
                continue;
            }
            if (level.teambased && player.team == self.team) {
                continue;
            }
            losexists = bullettracepassed(player.origin + (0, 0, 50), spawnpoint.sighttracepoint, 0, undefined);
            if (losexists) {
                thread badspawnline(spawnpoint.sighttracepoint, player.origin + (0, 0, 50), self.name, player.name);
            }
        }
    }

    // Namespace spawnlogic
    // Params 4, eflags: 0x0
    // Checksum 0x8a759258, Offset: 0x17c0
    // Size: 0xe6
    function badspawnline(start, end, name1, name2) {
        dist = distance(start, end);
        for (i = 0; i < -56; i++) {
            line(start, end, (1, 0, 0));
            print3d(start, "<dev string:xe5>" + name1 + "<dev string:xf1>" + dist);
            print3d(end, name2);
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 3, eflags: 0x0
    // Checksum 0xc1db8be5, Offset: 0x18b0
    // Size: 0x88c
    function storespawndata(spawnpoints, useweights, bestspawnpoint) {
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
        if (bestspawnpoint.classname == "<dev string:xfb>") {
            return;
        }
        level.spawnid++;
        file = openfile("<dev string:x112>", "<dev string:x120>");
        fprintfields(file, level.spawngameid + "<dev string:x127>" + level.spawnid + "<dev string:x129>" + spawnpoints.size + "<dev string:x129>" + self.name);
        for (i = 0; i < spawnpoints.size; i++) {
            str = vectostr(spawnpoints[i].origin) + "<dev string:x129>";
            if (spawnpoints[i] == bestspawnpoint) {
                str += "<dev string:x12b>";
            } else {
                str += "<dev string:x12e>";
            }
            if (!useweights) {
                str += "<dev string:x12e>";
            } else {
                str += spawnpoints[i].weight + "<dev string:x129>";
            }
            if (!isdefined(spawnpoints[i].spawndata)) {
                spawnpoints[i].spawndata = [];
            }
            if (!isdefined(spawnpoints[i].sightchecks)) {
                spawnpoints[i].sightchecks = [];
            }
            str += spawnpoints[i].spawndata.size + "<dev string:x129>";
            for (j = 0; j < spawnpoints[i].spawndata.size; j++) {
                str += spawnpoints[i].spawndata[j] + "<dev string:x129>";
            }
            str += spawnpoints[i].sightchecks.size + "<dev string:x129>";
            for (j = 0; j < spawnpoints[i].sightchecks.size; j++) {
                str += spawnpoints[i].sightchecks[j].penalty + "<dev string:x129>" + vectostr(spawnpoints[i].origin) + "<dev string:x129>";
            }
            fprintfields(file, str);
        }
        obj = spawnstruct();
        getallalliedandenemyplayers(obj);
        numallies = 0;
        numenemies = 0;
        str = "<dev string:x3c>";
        for (i = 0; i < obj.allies.size; i++) {
            if (obj.allies[i] == self) {
                continue;
            }
            numallies++;
            str += vectostr(obj.allies[i].origin) + "<dev string:x129>";
        }
        for (i = 0; i < obj.enemies.size; i++) {
            numenemies++;
            str += vectostr(obj.enemies[i].origin) + "<dev string:x129>";
        }
        str = numallies + "<dev string:x129>" + numenemies + "<dev string:x129>" + str;
        fprintfields(file, str);
        otherdata = [];
        if (isdefined(level.bombguy)) {
            index = otherdata.size;
            otherdata[index] = spawnstruct();
            otherdata[index].origin = level.bombguy.origin + (0, 0, 20);
            otherdata[index].text = "<dev string:x131>";
        } else if (isdefined(level.bombpos)) {
            index = otherdata.size;
            otherdata[index] = spawnstruct();
            otherdata[index].origin = level.bombpos;
            otherdata[index].text = "<dev string:x13d>";
        }
        if (isdefined(level.flags)) {
            for (i = 0; i < level.flags.size; i++) {
                index = otherdata.size;
                otherdata[index] = spawnstruct();
                otherdata[index].origin = level.flags[i].origin;
                otherdata[index].text = level.flags[i].useobj gameobjects::get_owner_team() + "<dev string:x142>";
            }
        }
        str = otherdata.size + "<dev string:x129>";
        for (i = 0; i < otherdata.size; i++) {
            str += vectostr(otherdata[i].origin) + "<dev string:x129>" + otherdata[i].text + "<dev string:x129>";
        }
        fprintfields(file, str);
        closefile(file);
        thisspawnid = level.spawngameid + "<dev string:x127>" + level.spawnid;
        if (isdefined(self.thisspawnid)) {
        }
        self.thisspawnid = thisspawnid;
    }

    // Namespace spawnlogic
    // Params 2, eflags: 0x0
    // Checksum 0x8a29c334, Offset: 0x2148
    // Size: 0xb34
    function readspawndata(desiredid, relativepos) {
        file = openfile("<dev string:x112>", "<dev string:x148>");
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
                spawnpoint.origin = strtovec(fgetarg(file, 0));
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
                    spawnpoint.sightchecks[index].origin = strtovec(fgetarg(file, argnum));
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
                data.friends[data.friends.size] = strtovec(fgetarg(file, argnum));
                argnum++;
            }
            for (i = 0; i < numenemies; i++) {
                data.enemies[data.enemies.size] = strtovec(fgetarg(file, argnum));
                argnum++;
            }
            if (freadln(file) <= 0) {
                break;
            }
            numotherdata = int(fgetarg(file, 0));
            argnum = 1;
            for (i = 0; i < numotherdata; i++) {
                otherdata = spawnstruct();
                otherdata.origin = strtovec(fgetarg(file, argnum));
                argnum++;
                otherdata.text = fgetarg(file, argnum);
                argnum++;
                data.otherdata[data.otherdata.size] = otherdata;
            }
            if (isdefined(relativepos)) {
                if (relativepos == "<dev string:x14d>") {
                    if (data.id == oldspawndata.id) {
                        level.curspawndata = prevthisplayer;
                        break;
                    }
                } else if (relativepos == "<dev string:x15c>") {
                    if (data.id == oldspawndata.id) {
                        level.curspawndata = prev;
                        break;
                    }
                } else if (relativepos == "<dev string:x161>") {
                    if (lookingfornextthisplayer) {
                        level.curspawndata = data;
                        break;
                    } else if (data.id == oldspawndata.id) {
                        lookingfornextthisplayer = 1;
                    }
                } else if (relativepos == "<dev string:x170>") {
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
    // Checksum 0x17a5399a, Offset: 0x2c88
    // Size: 0x474
    function drawspawndata() {
        level notify(#"drawing_spawn_data");
        level endon(#"drawing_spawn_data");
        textoffset = (0, 0, -12);
        while (true) {
            if (!isdefined(level.curspawndata)) {
                wait 0.5;
                continue;
            }
            for (i = 0; i < level.curspawndata.friends.size; i++) {
                print3d(level.curspawndata.friends[i], "<dev string:x175>", (0.5, 1, 0.5), 1, 5);
            }
            for (i = 0; i < level.curspawndata.enemies.size; i++) {
                print3d(level.curspawndata.enemies[i], "<dev string:x178>", (1, 0.5, 0.5), 1, 5);
            }
            for (i = 0; i < level.curspawndata.otherdata.size; i++) {
                print3d(level.curspawndata.otherdata[i].origin, level.curspawndata.otherdata[i].text, (0.5, 0.75, 1), 1, 2);
            }
            for (i = 0; i < level.curspawndata.spawnpoints.size; i++) {
                sp = level.curspawndata.spawnpoints[i];
                orig = sp.sighttracepoint;
                if (sp.winner) {
                    print3d(orig, level.curspawndata.playername + "<dev string:x17b>", (0.5, 0.5, 1), 1, 2);
                    orig += textoffset;
                }
                amnt = (sp.weight - level.curspawndata.minweight) / (level.curspawndata.maxweight - level.curspawndata.minweight);
                print3d(orig, "<dev string:x189>" + sp.weight, (1 - amnt, amnt, 0.5));
                orig += textoffset;
                for (j = 0; j < sp.data.size; j++) {
                    print3d(orig, sp.data[j], (1, 1, 1));
                    orig += textoffset;
                }
                for (j = 0; j < sp.sightchecks.size; j++) {
                    print3d(orig, "<dev string:x192>" + sp.sightchecks[j].penalty, (1, 0.5, 0.5));
                    orig += textoffset;
                }
            }
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 1, eflags: 0x0
    // Checksum 0xb721d12e, Offset: 0x3108
    // Size: 0x7e
    function vectostr(vec) {
        return int(vec[0]) + "<dev string:x1a1>" + int(vec[1]) + "<dev string:x1a1>" + int(vec[2]);
    }

    // Namespace spawnlogic
    // Params 1, eflags: 0x0
    // Checksum 0x38eda5a8, Offset: 0x3190
    // Size: 0x9e
    function strtovec(str) {
        parts = strtok(str, "<dev string:x1a1>");
        if (parts.size != 3) {
            return (0, 0, 0);
        }
        return (int(parts[0]), int(parts[1]), int(parts[2]));
    }

#/

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x3ab2d852, Offset: 0x3238
// Size: 0xc2
function getspawnpoint_random(spawnpoints) {
    if (!isdefined(spawnpoints)) {
        return undefined;
    }
    for (i = 0; i < spawnpoints.size; i++) {
        j = randomint(spawnpoints.size);
        spawnpoint = spawnpoints[i];
        spawnpoints[i] = spawnpoints[j];
        spawnpoints[j] = spawnpoint;
    }
    return getspawnpoint_final(spawnpoints, 0);
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0x201d9ef9, Offset: 0x3308
// Size: 0xda
function getallotherplayers() {
    aliveplayers = [];
    for (i = 0; i < level.players.size; i++) {
        if (!isdefined(level.players[i])) {
            continue;
        }
        player = level.players[i];
        if (player.sessionstate != "playing" || player == self) {
            continue;
        }
        if (isdefined(level.customalivecheck)) {
            if (![[ level.customalivecheck ]](player)) {
                continue;
            }
        }
        aliveplayers[aliveplayers.size] = player;
    }
    return aliveplayers;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x8f16f09e, Offset: 0x33f0
// Size: 0x19c
function getallalliedandenemyplayers(obj) {
    if (level.teambased) {
        assert(isdefined(level.teams[self.team]));
        obj.allies = [];
        obj.enemies = [];
        for (i = 0; i < level.players.size; i++) {
            if (!isdefined(level.players[i])) {
                continue;
            }
            player = level.players[i];
            if (player.sessionstate != "playing" || player == self) {
                continue;
            }
            if (isdefined(level.customalivecheck)) {
                if (![[ level.customalivecheck ]](player)) {
                    continue;
                }
            }
            if (player.team == self.team) {
                obj.allies[obj.allies.size] = player;
                continue;
            }
            obj.enemies[obj.enemies.size] = player;
        }
        return;
    }
    obj.allies = [];
    obj.enemies = level.activeplayers;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xa0b322d1, Offset: 0x3598
// Size: 0xba
function initweights(spawnpoints) {
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
// Params 1, eflags: 0x0
// Checksum 0xb7bd9453, Offset: 0x3660
// Size: 0x2c2
function spawnpointupdate_zm(spawnpoint) {
    foreach (team in level.teams) {
        spawnpoint.distsum[team] = 0;
        spawnpoint.enemydistsum[team] = 0;
    }
    players = getplayers();
    spawnpoint.numplayersatlastupdate = players.size;
    foreach (player in players) {
        if (!isdefined(player)) {
            continue;
        }
        if (player.sessionstate != "playing") {
            continue;
        }
        if (isdefined(level.customalivecheck)) {
            if (![[ level.customalivecheck ]](player)) {
                continue;
            }
        }
        dist = distance(spawnpoint.origin, player.origin);
        spawnpoint.distsum[player.team] = spawnpoint.distsum[player.team] + dist;
        foreach (team in level.teams) {
            if (team != player.team) {
                spawnpoint.enemydistsum[team] = spawnpoint.enemydistsum[team] + dist;
            }
        }
    }
}

// Namespace spawnlogic
// Params 4, eflags: 0x0
// Checksum 0x6bd52e60, Offset: 0x3930
// Size: 0x5b8
function getspawnpoint_nearteam(spawnpoints, favoredspawnpoints, forceallydistanceweight, forceenemydistanceweight) {
    if (!isdefined(spawnpoints)) {
        return undefined;
    }
    /#
        if (getdvarstring("<dev string:x1a3>") == "<dev string:x3c>") {
            setdvar("<dev string:x1a3>", "<dev string:x6b>");
        }
        if (getdvarstring("<dev string:x1a3>") == "<dev string:x1b6>") {
            return getspawnpoint_random(spawnpoints);
        }
    #/
    if (getdvarint("scr_spawnsimple") > 0) {
        return getspawnpoint_random(spawnpoints);
    }
    spawnlogic_begin();
    k_favored_spawn_point_bonus = 25000;
    initweights(spawnpoints);
    obj = spawnstruct();
    getallalliedandenemyplayers(obj);
    numplayers = obj.allies.size + obj.enemies.size;
    allieddistanceweight = 2;
    if (isdefined(forceallydistanceweight)) {
        allieddistanceweight = forceallydistanceweight;
    }
    enemydistanceweight = 1;
    if (isdefined(forceenemydistanceweight)) {
        enemydistanceweight = forceenemydistanceweight;
    }
    myteam = self.team;
    for (i = 0; i < spawnpoints.size; i++) {
        spawnpoint = spawnpoints[i];
        spawnpointupdate_zm(spawnpoint);
        if (!isdefined(spawnpoint.numplayersatlastupdate)) {
            spawnpoint.numplayersatlastupdate = 0;
        }
        if (spawnpoint.numplayersatlastupdate > 0) {
            allydistsum = spawnpoint.distsum[myteam];
            enemydistsum = spawnpoint.enemydistsum[myteam];
            spawnpoint.weight = (enemydistanceweight * enemydistsum - allieddistanceweight * allydistsum) / spawnpoint.numplayersatlastupdate;
            /#
                if (level.storespawndata || level.debugspawning) {
                    spawnpoint.spawndata[spawnpoint.spawndata.size] = "<dev string:x1b8>" + int(spawnpoint.weight) + "<dev string:x1c6>" + enemydistanceweight + "<dev string:x1cb>" + int(enemydistsum) + "<dev string:x1cd>" + allieddistanceweight + "<dev string:x1cb>" + int(allydistsum) + "<dev string:x1d1>" + spawnpoint.numplayersatlastupdate;
                }
            #/
            continue;
        }
        spawnpoint.weight = 0;
        /#
            if (level.storespawndata || level.debugspawning) {
                spawnpoint.spawndata[spawnpoint.spawndata.size] = "<dev string:x1d6>";
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
    avoidsamespawn(spawnpoints);
    avoidspawnreuse(spawnpoints, 1);
    avoidweapondamage(spawnpoints);
    avoidvisibleenemies(spawnpoints, 1);
    result = getspawnpoint_final(spawnpoints);
    /#
        if (getdvarstring("<dev string:x1e5>") == "<dev string:x3c>") {
            setdvar("<dev string:x1e5>", "<dev string:x6b>");
        }
        if (getdvarstring("<dev string:x1e5>") == "<dev string:x1b6>") {
            checkbad(result);
        }
    #/
    return result;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x6c1e115a, Offset: 0x3ef0
// Size: 0x29a
function getspawnpoint_dm(spawnpoints) {
    if (!isdefined(spawnpoints)) {
        return undefined;
    }
    spawnlogic_begin();
    initweights(spawnpoints);
    aliveplayers = getallotherplayers();
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
    avoidsamespawn(spawnpoints);
    avoidspawnreuse(spawnpoints, 0);
    avoidweapondamage(spawnpoints);
    avoidvisibleenemies(spawnpoints, 0);
    return getspawnpoint_final(spawnpoints);
}

// Namespace spawnlogic
// Params 5, eflags: 0x0
// Checksum 0x7fb84081, Offset: 0x4198
// Size: 0x372
function getspawnpoint_turned(spawnpoints, idealdist, baddist, idealdistteam, baddistteam) {
    if (!isdefined(spawnpoints)) {
        return undefined;
    }
    spawnlogic_begin();
    initweights(spawnpoints);
    aliveplayers = getallotherplayers();
    if (!isdefined(idealdist)) {
        idealdist = 1600;
    }
    if (!isdefined(idealdistteam)) {
        idealdistteam = 1200;
    }
    if (!isdefined(baddist)) {
        baddist = 1200;
    }
    if (!isdefined(baddistteam)) {
        baddistteam = 600;
    }
    myteam = self.team;
    if (aliveplayers.size > 0) {
        for (i = 0; i < spawnpoints.size; i++) {
            totaldistfromideal = 0;
            nearbybadamount = 0;
            for (j = 0; j < aliveplayers.size; j++) {
                dist = distance(spawnpoints[i].origin, aliveplayers[j].origin);
                distfromideal = 0;
                if (aliveplayers[j].team == myteam) {
                    if (dist < baddistteam) {
                        nearbybadamount += (baddistteam - dist) / baddistteam;
                    }
                    distfromideal = abs(dist - idealdistteam);
                } else {
                    if (dist < baddist) {
                        nearbybadamount += (baddist - dist) / baddist;
                    }
                    distfromideal = abs(dist - idealdist);
                }
                totaldistfromideal += distfromideal;
            }
            avgdistfromideal = totaldistfromideal / aliveplayers.size;
            welldistancedamount = (idealdist - avgdistfromideal) / idealdist;
            spawnpoints[i].weight = welldistancedamount - nearbybadamount * 2 + randomfloat(0.2);
        }
    }
    avoidsamespawn(spawnpoints);
    avoidspawnreuse(spawnpoints, 0);
    avoidweapondamage(spawnpoints);
    avoidvisibleenemies(spawnpoints, 0);
    return getspawnpoint_final(spawnpoints);
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0xaf347363, Offset: 0x4518
// Size: 0x50
function spawnlogic_begin() {
    /#
        level.storespawndata = getdvarint("<dev string:x28>");
        level.debugspawning = getdvarint("<dev string:x6d>") > 0;
    #/
}

/#

    // Namespace spawnlogic
    // Params 0, eflags: 0x0
    // Checksum 0xdab55ff4, Offset: 0x4570
    // Size: 0xa6
    function watchspawnprofile() {
        while (true) {
            while (true) {
                if (getdvarint("<dev string:x81>") > 0) {
                    break;
                }
                wait 0.05;
            }
            thread spawnprofile();
            while (true) {
                if (getdvarint("<dev string:x81>") <= 0) {
                    break;
                }
                wait 0.05;
            }
            level notify(#"stop_spawn_profile");
        }
    }

    // Namespace spawnlogic
    // Params 0, eflags: 0x0
    // Checksum 0x540b0a0a, Offset: 0x4620
    // Size: 0x110
    function spawnprofile() {
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
                player getspawnpoint_nearteam(level.spawnpoints);
            }
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 0, eflags: 0x0
    // Checksum 0x929da1d3, Offset: 0x4738
    // Size: 0x5a
    function spawngraphcheck() {
        while (true) {
            if (getdvarint("<dev string:x1f7>") < 1) {
                wait 3;
                continue;
            }
            thread spawngraph();
            return;
        }
    }

    // Namespace spawnlogic
    // Params 0, eflags: 0x0
    // Checksum 0xe787aa5f, Offset: 0x47a0
    // Size: 0x650
    function spawngraph() {
        w = 20;
        h = 20;
        weightscale = 0.1;
        fakespawnpoints = [];
        corners = getentarray("<dev string:x206>", "<dev string:x215>");
        if (corners.size != 2) {
            println("<dev string:x220>");
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
                if (!level.players.size || !isdefined(level.players[0].team) || level.players[0].team == "<dev string:x249>" || !isdefined(level.players[0].curclass)) {
                    break;
                }
                endspawni = spawni + fakespawnpoints.size / numiters;
                if (i == numiters - 1) {
                    endspawni = fakespawnpoints.size;
                }
                while (spawni < endspawni) {
                    spawnpointupdate(fakespawnpoints[spawni]);
                    spawni++;
                }
                if (didweights) {
                    level.players[0] drawspawngraph(fakespawnpoints, w, h, weightscale);
                }
                wait 0.05;
            }
            if (!level.players.size || !isdefined(level.players[0].team) || level.players[0].team == "<dev string:x249>" || !isdefined(level.players[0].curclass)) {
                wait 1;
                continue;
            }
            level.players[0] getspawnpoint_nearteam(fakespawnpoints);
            for (i = 0; i < fakespawnpoints.size; i++) {
                setupspawngraphpoint(fakespawnpoints[i], weightscale);
            }
            didweights = 1;
            level.players[0] drawspawngraph(fakespawnpoints, w, h, weightscale);
            wait 0.05;
        }
    }

    // Namespace spawnlogic
    // Params 4, eflags: 0x0
    // Checksum 0x5b6b27cb, Offset: 0x4df8
    // Size: 0x146
    function drawspawngraph(fakespawnpoints, w, h, weightscale) {
        i = 0;
        for (y = 0; y < h; y++) {
            yamnt = y / (h - 1);
            for (x = 0; x < w; x++) {
                xamnt = x / (w - 1);
                if (y > 0) {
                    spawngraphline(fakespawnpoints[i], fakespawnpoints[i - w], weightscale);
                }
                if (x > 0) {
                    spawngraphline(fakespawnpoints[i], fakespawnpoints[i - 1], weightscale);
                }
                i++;
            }
        }
    }

    // Namespace spawnlogic
    // Params 2, eflags: 0x0
    // Checksum 0xac5c3dea, Offset: 0x4f48
    // Size: 0x5c
    function setupspawngraphpoint(s1, weightscale) {
        s1.visible = 1;
        if (s1.weight < -1000 / weightscale) {
            s1.visible = 0;
        }
    }

    // Namespace spawnlogic
    // Params 3, eflags: 0x0
    // Checksum 0x64048e45, Offset: 0x4fb0
    // Size: 0xdc
    function spawngraphline(s1, s2, weightscale) {
        if (!s1.visible || !s2.visible) {
            return;
        }
        p1 = s1.origin + (0, 0, s1.weight * weightscale + 100);
        p2 = s2.origin + (0, 0, s2.weight * weightscale + 100);
        line(p1, p2, (1, 1, 1));
    }

    // Namespace spawnlogic
    // Params 0, eflags: 0x0
    // Checksum 0x98cea030, Offset: 0x5098
    // Size: 0x364
    function loopbotspawns() {
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
                if (level.players[i].sessionstate == "<dev string:xdd>" && issubstr(level.players[i].name, "<dev string:x253>")) {
                    bots[bots.size] = level.players[i];
                }
            }
            if (bots.size > 0) {
                if (getdvarint("<dev string:x3d>") == 1) {
                    killer = bots[randomint(bots.size)];
                    victim = bots[randomint(bots.size)];
                    victim thread [[ level.callbackplayerdamage ]](killer, killer, 1000, 0, "<dev string:x257>", level.weaponnone, (0, 0, 0), (0, 0, 0), "<dev string:x268>", 0, 0);
                } else {
                    numkills = getdvarint("<dev string:x3d>");
                    lastvictim = undefined;
                    for (index = 0; index < numkills; index++) {
                        killer = bots[randomint(bots.size)];
                        for (victim = bots[randomint(bots.size)]; isdefined(lastvictim) && victim == lastvictim; victim = bots[randomint(bots.size)]) {
                        }
                        victim thread [[ level.callbackplayerdamage ]](killer, killer, 1000, 0, "<dev string:x257>", level.weaponnone, (0, 0, 0), (0, 0, 0), "<dev string:x268>", 0, 0);
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
    // Checksum 0xd7c6a2f5, Offset: 0x5408
    // Size: 0x1e8
    function allowspawndatareading() {
        setdvar("<dev string:x26d>", "<dev string:x3c>");
        prevval = getdvarstring("<dev string:x26d>");
        prevrelval = getdvarstring("<dev string:x27d>");
        readthistime = 0;
        while (true) {
            val = getdvarstring("<dev string:x26d>");
            relval = undefined;
            if (!isdefined(val) || val == prevval) {
                relval = getdvarstring("<dev string:x27d>");
                if (isdefined(relval) && relval != "<dev string:x3c>") {
                    setdvar("<dev string:x27d>", "<dev string:x3c>");
                } else {
                    wait 0.5;
                    continue;
                }
            }
            prevval = val;
            readthistime = 0;
            readspawndata(val, relval);
            if (!isdefined(level.curspawndata)) {
                println("<dev string:x28e>");
            } else {
                println("<dev string:x2a5>" + level.curspawndata.id);
            }
            thread drawspawndata();
        }
    }

    // Namespace spawnlogic
    // Params 0, eflags: 0x0
    // Checksum 0xf11662c6, Offset: 0x55f8
    // Size: 0x4b0
    function showdeathsdebug() {
        while (true) {
            if (getdvarstring("<dev string:x6d>") == "<dev string:x6b>") {
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
                    print3d(spawnkill.dierorigin + (0, 0, 32), "<dev string:x2b7>", (0, 1, 1));
                } else {
                    line(spawnkill.spawnpointorigin, spawnkill.killerorigin, (0.4, 0.5, 0.4));
                    line(spawnkill.killerorigin, spawnkill.dierorigin, (0, 1, 1));
                    print3d(spawnkill.dierorigin + (0, 0, 32), "<dev string:x2c4>", (0, 1, 1));
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
// Checksum 0x27e6c2d3, Offset: 0x5ab0
// Size: 0x56
function updatedeathinfodebug() {
    while (true) {
        if (getdvarstring("scr_spawnpointdebug") == "0") {
            wait 3;
            continue;
        }
        updatedeathinfo();
        wait 3;
    }
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xeaa47d9b, Offset: 0x5b10
// Size: 0x314
function spawnweightdebug(spawnpoints) {
    level notify(#"stop_spawn_weight_debug");
    level endon(#"stop_spawn_weight_debug");
    /#
        while (true) {
            if (getdvarstring("<dev string:x6d>") == "<dev string:x6b>") {
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
                        print3d(orig, "<dev string:x2cf>" + spawnpoints[i].sightchecks[j].penalty, (0.5, 0.5, 0.5));
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
// Checksum 0xe733e3a6, Offset: 0x5e30
// Size: 0xf0
function profiledebug() {
    while (true) {
        if (getdvarstring("scr_spawnpointprofile") != "1") {
            wait 3;
            continue;
        }
        for (i = 0; i < level.spawnpoints.size; i++) {
            level.spawnpoints[i].weight = randomint(10000);
        }
        if (level.players.size > 0) {
            level.players[randomint(level.players.size)] getspawnpoint_nearteam(level.spawnpoints);
        }
        wait 0.05;
    }
}

/#

    // Namespace spawnlogic
    // Params 2, eflags: 0x0
    // Checksum 0x7ba1d82, Offset: 0x5f28
    // Size: 0xe0
    function debugnearbyplayers(players, origin) {
        if (getdvarstring("<dev string:x6d>") == "<dev string:x6b>") {
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
// Checksum 0xe5057095, Offset: 0x6010
// Size: 0x14
function deathoccured(dier, killer) {
    
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0x69b44222, Offset: 0x6030
// Size: 0x122
function checkforsimilardeaths(deathinfo) {
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
// Checksum 0x80deb82a, Offset: 0x6160
// Size: 0x1e4
function updatedeathinfo() {
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
// Checksum 0x5b7cc3f8, Offset: 0x6350
// Size: 0x128
function function_479a5f79(playerorigin) {
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
// Checksum 0xb89cc5f1, Offset: 0x6480
// Size: 0x212
function avoidweapondamage(spawnpoints) {
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
                        spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "<dev string:x2e1>" + int(weapondamagepenalty);
                    }
                #/
            }
        }
    }
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0xe111f332, Offset: 0x66a0
// Size: 0x80
function spawnperframeupdate() {
    spawnpointindex = 0;
    while (true) {
        wait 0.05;
        if (!isdefined(level.spawnpoints)) {
            return;
        }
        spawnpointindex = (spawnpointindex + 1) % level.spawnpoints.size;
        spawnpoint = level.spawnpoints[spawnpointindex];
        spawnpointupdate(spawnpoint);
    }
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0xcd200160, Offset: 0x6728
// Size: 0xc0
function getnonteamsum(skip_team, sums) {
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
// Checksum 0x6a5824de, Offset: 0x67f0
// Size: 0xd2
function getnonteammindist(skip_team, mindists) {
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
// Checksum 0x3c5136f0, Offset: 0x68d0
// Size: 0x6ea
function spawnpointupdate(spawnpoint) {
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
        debug = getdvarint("<dev string:x6d>") > 0;
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
            spawnpoint.enemysights[team] = getnonteamsum(team, sights);
            spawnpoint.minenemydist[team] = getnonteammindist(team, mindist);
            spawnpoint.distsum[team] = distsum[team];
            spawnpoint.enemydistsum[team] = getnonteamsum(team, distsum);
        }
        return;
    }
    spawnpoint.distsum["all"] = distsum["all"];
    spawnpoint.enemydistsum["all"] = distsum["all"];
    spawnpoint.minenemydist["all"] = mindist["all"];
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0xbd6eb74e, Offset: 0x6fc8
// Size: 0x72
function getlospenalty() {
    if (getdvarstring("scr_spawnpointlospenalty") != "" && getdvarstring("scr_spawnpointlospenalty") != "0") {
        return getdvarfloat("scr_spawnpointlospenalty");
    }
    return 100000;
}

// Namespace spawnlogic
// Params 1, eflags: 0x0
// Checksum 0xe13c53b5, Offset: 0x7048
// Size: 0x2de
function lastminutesighttraces(spawnpoint) {
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
// Checksum 0x948783b1, Offset: 0x7330
// Size: 0x570
function avoidvisibleenemies(spawnpoints, teambased) {
    if (getdvarstring("scr_spawnpointnewlogic") == "0") {
        return;
    }
    lospenalty = getlospenalty();
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
                            spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "<dev string:x2f5>" + int(spawnpoints[i].minenemydist[mindistteam]) + "<dev string:x307>" + int(penalty);
                        }
                    #/
                }
            }
        }
    }
}

// Namespace spawnlogic
// Params 2, eflags: 0x0
// Checksum 0x406cb07e, Offset: 0x78a8
// Size: 0x28c
function avoidspawnreuse(spawnpoints, teambased) {
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
                        spawnpoint.spawndata[spawnpoint.spawndata.size] = "<dev string:x311>" + worsen;
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
// Checksum 0xe09d2051, Offset: 0x7b40
// Size: 0x104
function avoidsamespawn(spawnpoints) {
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
                    spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "<dev string:x326>";
                }
            #/
            break;
        }
    }
}

// Namespace spawnlogic
// Params 0, eflags: 0x0
// Checksum 0x45c34536, Offset: 0x7c50
// Size: 0xa4
function getrandomintermissionpoint() {
    spawnpoints = getentarray("mp_global_intermission", "classname");
    if (!spawnpoints.size) {
        spawnpoints = getentarray("info_player_start", "classname");
    }
    assert(spawnpoints.size);
    spawnpoint = getspawnpoint_random(spawnpoints);
    return spawnpoint;
}

