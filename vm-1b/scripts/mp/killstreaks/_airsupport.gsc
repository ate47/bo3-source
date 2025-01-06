#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/shared/challenges_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/weapons/_weapons;

#namespace airsupport;

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0x65f7af66, Offset: 0x358
// Size: 0x15a
function init() {
    if (!isdefined(level.airsupportheightscale)) {
        level.airsupportheightscale = 1;
    }
    level.airsupportheightscale = getdvarint("scr_airsupportHeightScale", level.airsupportheightscale);
    level.noflyzones = [];
    level.noflyzones = getentarray("no_fly_zone", "targetname");
    airsupport_heights = struct::get_array("air_support_height", "targetname");
    /#
        if (airsupport_heights.size > 1) {
            util::error("<dev string:x28>");
        }
    #/
    airsupport_heights = getentarray("air_support_height", "targetname");
    /#
        if (airsupport_heights.size > 0) {
            util::error("<dev string:x64>");
        }
    #/
    heli_height_meshes = getentarray("heli_height_lock", "classname");
    /#
        if (heli_height_meshes.size > 1) {
            util::error("<dev string:xc7>");
        }
    #/
    initrotatingrig();
}

// Namespace airsupport
// Params 2, eflags: 0x0
// Checksum 0x99850ddb, Offset: 0x4c0
// Size: 0x34
function function_b49a99ff(location, usedcallback) {
    self notify(#"used");
    wait 0.05;
    if (isdefined(usedcallback)) {
        return self [[ usedcallback ]](location);
    }
    return 1;
}

// Namespace airsupport
// Params 3, eflags: 0x0
// Checksum 0x758a5a8, Offset: 0x500
// Size: 0x34
function function_c92c5dd5(var_1bc5675c, var_6376ee77, usedcallback) {
    self notify(#"used");
    wait 0.05;
    return self [[ usedcallback ]](var_1bc5675c, var_6376ee77);
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0xbd301c, Offset: 0x540
// Size: 0x3f
function endselectionongameend() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"cancel_location");
    self endon(#"used");
    self endon(#"host_migration_begin");
    level waittill(#"game_ended");
    self notify(#"game_ended");
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0x7059431c, Offset: 0x588
// Size: 0x3f
function endselectiononhostmigration() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"cancel_location");
    self endon(#"used");
    self endon(#"game_ended");
    level waittill(#"host_migration_begin");
    self notify(#"cancel_location");
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0x9b51b424, Offset: 0x5d0
// Size: 0x137
function endselectionthink() {
    assert(isplayer(self));
    assert(isalive(self));
    assert(isdefined(self.selectinglocation));
    assert(self.selectinglocation == 1);
    self thread endselectionongameend();
    self thread endselectiononhostmigration();
    event = self util::waittill_any_return("death", "disconnect", "cancel_location", "game_ended", "used", "weapon_change", "emp_jammed");
    if (event != "disconnect") {
        self.selectinglocation = undefined;
        self thread clearuplocationselection();
    }
    if (event != "used") {
        self notify(#"confirm_location", undefined, undefined);
    }
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0x4cf21b73, Offset: 0x710
// Size: 0x72
function clearuplocationselection() {
    event = self util::waittill_any_return("death", "disconnect", "game_ended", "used", "weapon_change", "emp_jammed", "weapon_change_complete");
    if (event != "disconnect") {
        self endlocationselection();
    }
}

// Namespace airsupport
// Params 1, eflags: 0x0
// Checksum 0x4cba4ea, Offset: 0x790
// Size: 0x2a
function stoploopsoundaftertime(time) {
    self endon(#"death");
    wait time;
    self stoploopsound(2);
}

// Namespace airsupport
// Params 1, eflags: 0x0
// Checksum 0x16292b30, Offset: 0x7c8
// Size: 0x4e
function calculatefalltime(flyheight) {
    gravity = getdvarint("bg_gravity");
    time = sqrt(2 * flyheight / gravity);
    return time;
}

// Namespace airsupport
// Params 4, eflags: 0x0
// Checksum 0xf8e115b9, Offset: 0x820
// Size: 0x6d
function calculatereleasetime(flytime, flyheight, flyspeed, bombspeedscale) {
    falltime = calculatefalltime(flyheight);
    bomb_x = flyspeed * bombspeedscale * falltime;
    release_time = bomb_x / flyspeed;
    return flytime * 0.5 - release_time;
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0x66d60803, Offset: 0x898
// Size: 0xdf
function getminimumflyheight() {
    airsupport_height = struct::get("air_support_height", "targetname");
    if (isdefined(airsupport_height)) {
        planeflyheight = airsupport_height.origin[2];
    } else {
        println("<dev string:x103>");
        planeflyheight = 850;
        if (isdefined(level.airsupportheightscale)) {
            level.airsupportheightscale = getdvarint("scr_airsupportHeightScale", level.airsupportheightscale);
            planeflyheight *= getdvarint("scr_airsupportHeightScale", level.airsupportheightscale);
        }
        if (isdefined(level.forceairsupportmapheight)) {
            planeflyheight += level.forceairsupportmapheight;
        }
    }
    return planeflyheight;
}

// Namespace airsupport
// Params 1, eflags: 0x0
// Checksum 0x32d05ec9, Offset: 0x980
// Size: 0x2da
function callstrike(flightplan) {
    level.bomberdamagedents = [];
    level.bomberdamagedentscount = 0;
    level.bomberdamagedentsindex = 0;
    assert(flightplan.distance != 0, "<dev string:x152>");
    planehalfdistance = flightplan.distance / 2;
    path = getstrikepath(flightplan.target, flightplan.height, planehalfdistance);
    startpoint = path["start"];
    endpoint = path["end"];
    flightplan.height = path["height"];
    direction = path["direction"];
    d = length(startpoint - endpoint);
    flytime = d / flightplan.speed;
    bombtime = calculatereleasetime(flytime, flightplan.height, flightplan.speed, flightplan.bombspeedscale);
    if (bombtime < 0) {
        bombtime = 0;
    }
    assert(flytime > bombtime);
    flightplan.owner endon(#"disconnect");
    requireddeathcount = flightplan.owner.deathcount;
    side = weaponobjects::vectorcross(anglestoforward(direction), (0, 0, 1));
    plane_seperation = 25;
    side_offset = vectorscale(side, plane_seperation);
    level thread planestrike(flightplan.owner, requireddeathcount, startpoint, endpoint, bombtime, flytime, flightplan.speed, flightplan.bombspeedscale, direction, flightplan.planespawncallback);
    wait flightplan.planespacing;
    level thread planestrike(flightplan.owner, requireddeathcount, startpoint + side_offset, endpoint + side_offset, bombtime, flytime, flightplan.speed, flightplan.bombspeedscale, direction, flightplan.planespawncallback);
    wait flightplan.planespacing;
    side_offset = vectorscale(side, -1 * plane_seperation);
    level thread planestrike(flightplan.owner, requireddeathcount, startpoint + side_offset, endpoint + side_offset, bombtime, flytime, flightplan.speed, flightplan.bombspeedscale, direction, flightplan.planespawncallback);
}

// Namespace airsupport
// Params 10, eflags: 0x0
// Checksum 0x242720a5, Offset: 0xc68
// Size: 0xfa
function planestrike(owner, requireddeathcount, pathstart, pathend, bombtime, flytime, flyspeed, bombspeedscale, direction, planespawnedfunction) {
    if (!isdefined(owner)) {
        return;
    }
    plane = spawnplane(owner, "script_model", pathstart);
    plane.angles = direction;
    plane moveto(pathend, flytime, 0, 0);
    thread debug_plane_line(flytime, flyspeed, pathstart, pathend);
    if (isdefined(planespawnedfunction)) {
        plane [[ planespawnedfunction ]](owner, requireddeathcount, pathstart, pathend, bombtime, bombspeedscale, flytime, flyspeed);
    }
    wait flytime;
    plane notify(#"delete");
    plane delete();
}

// Namespace airsupport
// Params 2, eflags: 0x0
// Checksum 0x6497b17c, Offset: 0xd70
// Size: 0x64
function determinegroundpoint(player, position) {
    ground = (position[0], position[1], player.origin[2]);
    trace = bullettrace(ground + (0, 0, 10000), ground, 0, undefined);
    return trace["position"];
}

// Namespace airsupport
// Params 2, eflags: 0x0
// Checksum 0xe1097008, Offset: 0xde0
// Size: 0x39
function determinetargetpoint(player, position) {
    point = determinegroundpoint(player, position);
    return clamptarget(point);
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0x2a3d8fd5, Offset: 0xe28
// Size: 0xe
function getmintargetheight() {
    return level.spawnmins[2] - 500;
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0x4a4c38b4, Offset: 0xe40
// Size: 0xe
function getmaxtargetheight() {
    return level.spawnmaxs[2] + 500;
}

// Namespace airsupport
// Params 1, eflags: 0x0
// Checksum 0x85d5190, Offset: 0xe58
// Size: 0x65
function clamptarget(target) {
    min = getmintargetheight();
    max = getmaxtargetheight();
    if (target[2] < min) {
        target[2] = min;
    }
    if (target[2] > max) {
        target[2] = max;
    }
    return target;
}

// Namespace airsupport
// Params 4, eflags: 0x0
// Checksum 0x7132e721, Offset: 0xec8
// Size: 0x69
function _insidecylinder(point, base, radius, height) {
    if (isdefined(height)) {
        if (point[2] > base[2] + height) {
            return false;
        }
    }
    dist = distance2d(point, base);
    if (dist < radius) {
        return true;
    }
    return false;
}

// Namespace airsupport
// Params 3, eflags: 0x0
// Checksum 0x244298a1, Offset: 0xf40
// Size: 0x71
function _insidenoflyzonebyindex(point, index, disregardheight) {
    height = level.noflyzones[index].height;
    if (isdefined(disregardheight)) {
        height = undefined;
    }
    return _insidecylinder(point, level.noflyzones[index].origin, level.noflyzones[index].radius, height);
}

// Namespace airsupport
// Params 1, eflags: 0x0
// Checksum 0x76bede9a, Offset: 0xfc0
// Size: 0xaf
function getnoflyzoneheight(point) {
    height = point[2];
    origin = undefined;
    for (i = 0; i < level.noflyzones.size; i++) {
        if (_insidenoflyzonebyindex(point, i)) {
            if (height < level.noflyzones[i].height) {
                height = level.noflyzones[i].height;
                origin = level.noflyzones[i].origin;
            }
        }
    }
    if (!isdefined(origin)) {
        return point[2];
    }
    return origin[2] + height;
}

// Namespace airsupport
// Params 2, eflags: 0x0
// Checksum 0xd753abc2, Offset: 0x1078
// Size: 0x5f
function insidenoflyzones(point, disregardheight) {
    noflyzones = [];
    for (i = 0; i < level.noflyzones.size; i++) {
        if (_insidenoflyzonebyindex(point, i, disregardheight)) {
            noflyzones[noflyzones.size] = i;
        }
    }
    return noflyzones;
}

// Namespace airsupport
// Params 2, eflags: 0x0
// Checksum 0x437ff946, Offset: 0x10e0
// Size: 0xf0
function crossesnoflyzone(start, end) {
    for (i = 0; i < level.noflyzones.size; i++) {
        point = math::closest_point_on_line(level.noflyzones[i].origin + (0, 0, 0.5 * level.noflyzones[i].height), start, end);
        dist = distance2d(point, level.noflyzones[i].origin);
        if (point[2] > level.noflyzones[i].origin[2] + level.noflyzones[i].height) {
            continue;
        }
        if (dist < level.noflyzones[i].radius) {
            return i;
        }
    }
    return undefined;
}

// Namespace airsupport
// Params 2, eflags: 0x0
// Checksum 0xbdd4ca0d, Offset: 0x11d8
// Size: 0xe7
function crossesnoflyzones(start, end) {
    zones = [];
    for (i = 0; i < level.noflyzones.size; i++) {
        point = math::closest_point_on_line(level.noflyzones[i].origin, start, end);
        dist = distance2d(point, level.noflyzones[i].origin);
        if (point[2] > level.noflyzones[i].origin[2] + level.noflyzones[i].height) {
            continue;
        }
        if (dist < level.noflyzones[i].radius) {
            zones[zones.size] = i;
        }
    }
    return zones;
}

// Namespace airsupport
// Params 3, eflags: 0x0
// Checksum 0xb70bad8b, Offset: 0x12c8
// Size: 0xe5
function getnoflyzoneheightcrossed(start, end, minheight) {
    height = minheight;
    for (i = 0; i < level.noflyzones.size; i++) {
        point = math::closest_point_on_line(level.noflyzones[i].origin, start, end);
        dist = distance2d(point, level.noflyzones[i].origin);
        if (dist < level.noflyzones[i].radius) {
            if (height < level.noflyzones[i].height) {
                height = level.noflyzones[i].height;
            }
        }
    }
    return height;
}

// Namespace airsupport
// Params 2, eflags: 0x0
// Checksum 0x76b58e55, Offset: 0x13b8
// Size: 0x52
function _shouldignorenoflyzone(noflyzone, noflyzones) {
    if (!isdefined(noflyzone)) {
        return true;
    }
    for (i = 0; i < noflyzones.size; i++) {
        if (isdefined(noflyzones[i]) && noflyzones[i] == noflyzone) {
            return true;
        }
    }
    return false;
}

// Namespace airsupport
// Params 3, eflags: 0x0
// Checksum 0x9649b4a3, Offset: 0x1418
// Size: 0x59
function _shouldignorestartgoalnoflyzone(noflyzone, startnoflyzones, goalnoflyzones) {
    if (!isdefined(noflyzone)) {
        return true;
    }
    if (_shouldignorenoflyzone(noflyzone, startnoflyzones)) {
        return true;
    }
    if (_shouldignorenoflyzone(noflyzone, goalnoflyzones)) {
        return true;
    }
    return false;
}

// Namespace airsupport
// Params 2, eflags: 0x0
// Checksum 0xf5cb65c7, Offset: 0x1480
// Size: 0xc4
function gethelipath(start, goal) {
    startnoflyzones = insidenoflyzones(start, 1);
    thread debug_line(start, goal, (1, 1, 1));
    goalnoflyzones = insidenoflyzones(goal);
    if (goalnoflyzones.size) {
        goal = (goal[0], goal[1], getnoflyzoneheight(goal));
    }
    goal_points = calculatepath(start, goal, startnoflyzones, goalnoflyzones);
    if (!isdefined(goal_points)) {
        return undefined;
    }
    assert(goal_points.size >= 1);
    return goal_points;
}

// Namespace airsupport
// Params 3, eflags: 0x0
// Checksum 0x4eceeb4a, Offset: 0x1550
// Size: 0xd0
function followpath(path, donenotify, stopatgoal) {
    for (i = 0; i < path.size - 1; i++) {
        self setvehgoalpos(path[i], 0);
        thread debug_line(self.origin, path[i], (1, 1, 0));
        self waittill(#"goal");
    }
    self setvehgoalpos(path[path.size - 1], stopatgoal);
    thread debug_line(self.origin, path[i], (1, 1, 0));
    self waittill(#"goal");
    if (isdefined(donenotify)) {
        self notify(donenotify);
    }
}

// Namespace airsupport
// Params 3, eflags: 0x0
// Checksum 0x512c47e5, Offset: 0x1628
// Size: 0x7a
function setgoalposition(goal, donenotify, stopatgoal) {
    if (!isdefined(stopatgoal)) {
        stopatgoal = 1;
    }
    start = self.origin;
    goal_points = gethelipath(start, goal);
    if (!isdefined(goal_points)) {
        goal_points = [];
        goal_points[0] = goal;
    }
    followpath(goal_points, donenotify, stopatgoal);
}

// Namespace airsupport
// Params 4, eflags: 0x0
// Checksum 0xa647b2aa, Offset: 0x16b0
// Size: 0x77
function clearpath(start, end, startnoflyzone, goalnoflyzone) {
    noflyzones = crossesnoflyzones(start, end);
    for (i = 0; i < noflyzones.size; i++) {
        if (!_shouldignorestartgoalnoflyzone(noflyzones[i], startnoflyzone, goalnoflyzone)) {
            return false;
        }
    }
    return true;
}

// Namespace airsupport
// Params 2, eflags: 0x0
// Checksum 0x670cb958, Offset: 0x1730
// Size: 0x39
function append_array(dst, src) {
    for (i = 0; i < src.size; i++) {
        dst[dst.size] = src[i];
    }
}

// Namespace airsupport
// Params 6, eflags: 0x0
// Checksum 0x24a5c0a0, Offset: 0x1778
// Size: 0xb8
function calculatepath_r(start, end, points, startnoflyzones, goalnoflyzones, depth) {
    depth--;
    if (depth <= 0) {
        points[points.size] = end;
        return points;
    }
    noflyzones = crossesnoflyzones(start, end);
    for (i = 0; i < noflyzones.size; i++) {
        noflyzone = noflyzones[i];
        if (!_shouldignorestartgoalnoflyzone(noflyzone, startnoflyzones, goalnoflyzones)) {
            return undefined;
        }
    }
    points[points.size] = end;
    return points;
}

// Namespace airsupport
// Params 4, eflags: 0x0
// Checksum 0x34e7e720, Offset: 0x1838
// Size: 0xfb
function calculatepath(start, end, startnoflyzones, goalnoflyzones) {
    points = [];
    points = calculatepath_r(start, end, points, startnoflyzones, goalnoflyzones, 3);
    if (!isdefined(points)) {
        return undefined;
    }
    assert(points.size >= 1);
    debug_sphere(points[points.size - 1], 10, (1, 0, 0), 1, 1000);
    point = start;
    for (i = 0; i < points.size; i++) {
        thread debug_line(point, points[i], (0, 1, 0));
        debug_sphere(points[i], 10, (0, 0, 1), 1, 1000);
        point = points[i];
    }
    return points;
}

// Namespace airsupport
// Params 3, eflags: 0x0
// Checksum 0x2ebd72ad, Offset: 0x1940
// Size: 0x127
function _getstrikepathstartandend(goal, yaw, halfdistance) {
    direction = (0, yaw, 0);
    startpoint = goal + vectorscale(anglestoforward(direction), -1 * halfdistance);
    endpoint = goal + vectorscale(anglestoforward(direction), halfdistance);
    noflyzone = crossesnoflyzone(startpoint, endpoint);
    path = [];
    if (isdefined(noflyzone)) {
        path["noFlyZone"] = noflyzone;
        startpoint = (startpoint[0], startpoint[1], level.noflyzones[noflyzone].origin[2] + level.noflyzones[noflyzone].height);
        endpoint = (endpoint[0], endpoint[1], startpoint[2]);
    } else {
        path["noFlyZone"] = undefined;
    }
    path["start"] = startpoint;
    path["end"] = endpoint;
    path["direction"] = direction;
    return path;
}

// Namespace airsupport
// Params 4, eflags: 0x0
// Checksum 0x6e95c9dd, Offset: 0x1a70
// Size: 0x117
function getstrikepath(target, height, halfdistance, yaw) {
    noflyzoneheight = getnoflyzoneheight(target);
    worldheight = target[2] + height;
    if (noflyzoneheight > worldheight) {
        worldheight = noflyzoneheight;
    }
    goal = (target[0], target[1], worldheight);
    path = [];
    if (!isdefined(yaw) || yaw != "random") {
        for (i = 0; i < 3; i++) {
            path = _getstrikepathstartandend(goal, randomint(360), halfdistance);
            if (!isdefined(path["noFlyZone"])) {
                break;
            }
        }
    } else {
        path = _getstrikepathstartandend(goal, yaw, halfdistance);
    }
    path["height"] = worldheight - target[2];
    return path;
}

// Namespace airsupport
// Params 5, eflags: 0x0
// Checksum 0x7cd26456, Offset: 0x1b90
// Size: 0x62
function doglassdamage(pos, radius, max, min, mod) {
    wait randomfloatrange(0.05, 0.15);
    glassradiusdamage(pos, radius, max, min, mod);
}

// Namespace airsupport
// Params 7, eflags: 0x0
// Checksum 0x66729364, Offset: 0x1c00
// Size: 0x2d8
function entlosradiusdamage(ent, pos, radius, max, min, owner, einflictor) {
    dist = distance(pos, ent.damagecenter);
    if (ent.isplayer || ent.isactor) {
        assumed_ceiling_height = 800;
        eye_position = ent.entity geteye();
        head_height = eye_position[2];
        debug_display_time = 4000;
        trace = weapons::damage_trace(ent.entity.origin, ent.entity.origin + (0, 0, assumed_ceiling_height), 0, undefined);
        indoors = trace["fraction"] != 1;
        if (indoors) {
            test_point = trace["position"];
            debug_star(test_point, (0, 1, 0), debug_display_time);
            trace = weapons::damage_trace((test_point[0], test_point[1], head_height), (pos[0], pos[1], head_height), 0, undefined);
            indoors = trace["fraction"] != 1;
            if (indoors) {
                debug_star((pos[0], pos[1], head_height), (0, 1, 0), debug_display_time);
                dist *= 4;
                if (dist > radius) {
                    return false;
                }
            } else {
                debug_star((pos[0], pos[1], head_height), (1, 0, 0), debug_display_time);
                trace = weapons::damage_trace((pos[0], pos[1], head_height), pos, 0, undefined);
                indoors = trace["fraction"] != 1;
                if (indoors) {
                    debug_star(pos, (0, 1, 0), debug_display_time);
                    dist *= 4;
                    if (dist > radius) {
                        return false;
                    }
                } else {
                    debug_star(pos, (1, 0, 0), debug_display_time);
                }
            }
        } else {
            debug_star(ent.entity.origin + (0, 0, assumed_ceiling_height), (1, 0, 0), debug_display_time);
        }
    }
    ent.damage = int(max + (min - max) * dist / radius);
    ent.pos = pos;
    ent.damageowner = owner;
    ent.einflictor = einflictor;
    return true;
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0x26750300, Offset: 0x1ee0
// Size: 0x5c
function getmapcenter() {
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size) {
        return math::find_box_center(minimaporigins[0].origin, minimaporigins[1].origin);
    }
    return (0, 0, 0);
}

// Namespace airsupport
// Params 4, eflags: 0x0
// Checksum 0x91035527, Offset: 0x1f48
// Size: 0x17f
function getrandommappoint(x_offset, y_offset, map_x_percentage, map_y_percentage) {
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size) {
        rand_x = 0;
        rand_y = 0;
        if (minimaporigins[0].origin[0] < minimaporigins[1].origin[0]) {
            rand_x = randomfloatrange(minimaporigins[0].origin[0] * map_x_percentage, minimaporigins[1].origin[0] * map_x_percentage);
            rand_y = randomfloatrange(minimaporigins[0].origin[1] * map_y_percentage, minimaporigins[1].origin[1] * map_y_percentage);
        } else {
            rand_x = randomfloatrange(minimaporigins[1].origin[0] * map_x_percentage, minimaporigins[0].origin[0] * map_x_percentage);
            rand_y = randomfloatrange(minimaporigins[1].origin[1] * map_y_percentage, minimaporigins[0].origin[1] * map_y_percentage);
        }
        return (x_offset + rand_x, y_offset + rand_y, 0);
    }
    return (x_offset, y_offset, 0);
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0xee1f2f65, Offset: 0x20d0
// Size: 0xbb
function getmaxmapwidth() {
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size) {
        x = abs(minimaporigins[0].origin[0] - minimaporigins[1].origin[0]);
        y = abs(minimaporigins[0].origin[1] - minimaporigins[1].origin[1]);
        return max(x, y);
    }
    return 0;
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0xd5d2c64c, Offset: 0x2198
// Size: 0xe2
function initrotatingrig() {
    level.airsupport_rotator = spawn("script_model", getmapcenter() + (isdefined(level.rotator_x_offset) ? level.rotator_x_offset : 0, isdefined(level.rotator_y_offset) ? level.rotator_y_offset : 0, 1200));
    level.airsupport_rotator setmodel("tag_origin");
    level.airsupport_rotator.angles = (0, 115, 0);
    level.airsupport_rotator hide();
    level.airsupport_rotator thread rotaterig();
    level.airsupport_rotator thread swayrig();
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0x62edcd15, Offset: 0x2288
// Size: 0x21
function rotaterig() {
    for (;;) {
        self rotateyaw(-360, 60);
        wait 60;
    }
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0x67c9f8b2, Offset: 0x22b8
// Size: 0xc9
function swayrig() {
    centerorigin = self.origin;
    for (;;) {
        z = randomintrange(-200, -100);
        time = randomintrange(3, 6);
        self moveto(centerorigin + (0, 0, z), time, 1, 1);
        wait time;
        z = randomintrange(100, -56);
        time = randomintrange(3, 6);
        self moveto(centerorigin + (0, 0, z), time, 1, 1);
        wait time;
    }
}

// Namespace airsupport
// Params 1, eflags: 0x0
// Checksum 0xc4e2ec59, Offset: 0x2390
// Size: 0x2a
function stoprotation(time) {
    self endon(#"death");
    wait time;
    self stoploopsound();
}

// Namespace airsupport
// Params 1, eflags: 0x0
// Checksum 0x7e203d46, Offset: 0x23c8
// Size: 0x89
function flattenyaw(goal) {
    self endon(#"death");
    increment = 3;
    if (self.angles[1] > goal) {
        increment *= -1;
    }
    while (abs(self.angles[1] - goal) > 3) {
        self.angles = (self.angles[0], self.angles[1] + increment, self.angles[2]);
        wait 0.05;
    }
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0x595ee2cd, Offset: 0x2460
// Size: 0x51
function flattenroll() {
    self endon(#"death");
    while (self.angles[2] < 0) {
        self.angles = (self.angles[0], self.angles[1], self.angles[2] + 2.5);
        wait 0.05;
    }
}

// Namespace airsupport
// Params 1, eflags: 0x0
// Checksum 0xf4e10139, Offset: 0x24c0
// Size: 0x1cb
function leave(duration) {
    self unlink();
    self thread stoprotation(1);
    tries = 10;
    yaw = 0;
    while (tries > 0) {
        exitvector = anglestoforward(self.angles + (0, yaw, 0)) * 20000;
        exitpoint = (self.origin[0] + exitvector[0], self.origin[1] + exitvector[1], self.origin[2] - 2500);
        exitpoint = self.origin + exitvector;
        nfz = crossesnoflyzone(self.origin, exitpoint);
        if (isdefined(nfz)) {
            if (tries != 1) {
                if (tries % 2 == 1) {
                    yaw *= -1;
                } else {
                    yaw += 10;
                    yaw *= -1;
                }
            }
            tries--;
            continue;
        }
        tries = 0;
    }
    self thread flattenyaw(self.angles[1] + yaw);
    if (self.angles[2] != 0) {
        self thread flattenroll();
    }
    if (isvehicle(self)) {
        self setspeed(length(exitvector) / duration / 17.6, 60);
        self setvehgoalpos(exitpoint, 0, 0);
    } else {
        self moveto(exitpoint, duration, 0, 0);
    }
    self notify(#"leaving");
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0x4c75bb94, Offset: 0x2698
// Size: 0x176
function getrandomhelicopterstartorigin() {
    dist = -1 * getdvarint("scr_supplydropIncomingDistance", 10000);
    pathrandomness = 100;
    direction = (0, randomintrange(-2, 3), 0);
    start_origin = anglestoforward(direction) * dist;
    start_origin += ((randomfloat(2) - 1) * pathrandomness, (randomfloat(2) - 1) * pathrandomness, 0);
    /#
        if (getdvarint("<dev string:x183>", 0)) {
            if (level.noflyzones.size) {
                index = randomintrange(0, level.noflyzones.size);
                delta = level.noflyzones[index].origin;
                delta = (delta[0] + randomint(10), delta[1] + randomint(10), 0);
                delta = vectornormalize(delta);
                start_origin = delta * dist;
            }
        }
    #/
    return start_origin;
}

/#

    // Namespace airsupport
    // Params 0, eflags: 0x0
    // Checksum 0x9f51d237, Offset: 0x2818
    // Size: 0x69
    function debug_no_fly_zones() {
        for (i = 0; i < level.noflyzones.size; i++) {
            debug_airsupport_cylinder(level.noflyzones[i].origin, level.noflyzones[i].radius, level.noflyzones[i].height, (1, 1, 1), undefined, 5000);
        }
    }

#/

// Namespace airsupport
// Params 4, eflags: 0x0
// Checksum 0x9be5c354, Offset: 0x2890
// Size: 0x91
function debug_plane_line(flytime, flyspeed, pathstart, pathend) {
    thread debug_line(pathstart, pathend, (1, 1, 1));
    delta = vectornormalize(pathend - pathstart);
    for (i = 0; i < flytime; i++) {
        thread debug_star(pathstart + vectorscale(delta, i * flyspeed), (1, 0, 0));
    }
}

// Namespace airsupport
// Params 1, eflags: 0x0
// Checksum 0xe31319d5, Offset: 0x2930
// Size: 0x6a
function debug_draw_bomb_explosion(prevpos) {
    self notify(#"draw_explosion");
    wait 0.05;
    self endon(#"draw_explosion");
    self waittill(#"projectile_impact", weapon, position);
    thread debug_line(prevpos, position, (0.5, 1, 0));
    thread debug_star(position, (1, 0, 0));
}

/#

    // Namespace airsupport
    // Params 3, eflags: 0x0
    // Checksum 0xae1f1e86, Offset: 0x29a8
    // Size: 0xe5
    function debug_draw_bomb_path(projectile, color, time) {
        self endon(#"death");
        level.airsupport_debug = getdvarint("<dev string:x198>", 0);
        if (!isdefined(color)) {
            color = (0.5, 1, 0);
        }
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            prevpos = self.origin;
            while (isdefined(self.origin)) {
                thread debug_line(prevpos, self.origin, color, time);
                prevpos = self.origin;
                if (isdefined(projectile) && projectile) {
                    thread debug_draw_bomb_explosion(prevpos);
                }
                wait 0.2;
            }
        }
    }

    // Namespace airsupport
    // Params 4, eflags: 0x0
    // Checksum 0x773f4804, Offset: 0x2a98
    // Size: 0xaa
    function debug_print3d_simple(message, ent, offset, frames) {
        level.airsupport_debug = getdvarint("<dev string:x198>", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            if (isdefined(frames)) {
                thread draw_text(message, (0.8, 0.8, 0.8), ent, offset, frames);
                return;
            }
            thread draw_text(message, (0.8, 0.8, 0.8), ent, offset, 0);
        }
    }

    // Namespace airsupport
    // Params 5, eflags: 0x0
    // Checksum 0x4ba656ea, Offset: 0x2b50
    // Size: 0xd9
    function draw_text(msg, color, ent, offset, frames) {
        if (frames == 0) {
            while (isdefined(ent) && isdefined(ent.origin)) {
                print3d(ent.origin + offset, msg, color, 0.5, 4);
                wait 0.05;
            }
            return;
        }
        for (i = 0; i < frames; i++) {
            if (!isdefined(ent)) {
                break;
            }
            print3d(ent.origin + offset, msg, color, 0.5, 4);
            wait 0.05;
        }
    }

    // Namespace airsupport
    // Params 5, eflags: 0x0
    // Checksum 0x9a0c8ae7, Offset: 0x2c38
    // Size: 0x82
    function debug_print3d(message, color, ent, origin_offset, frames) {
        level.airsupport_debug = getdvarint("<dev string:x198>", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            self thread draw_text(message, color, ent, origin_offset, frames);
        }
    }

#/

// Namespace airsupport
// Params 5, eflags: 0x0
// Checksum 0xd987a2f3, Offset: 0x2cc8
// Size: 0xba
function debug_line(from, to, color, time, depthtest) {
    /#
        level.airsupport_debug = getdvarint("<dev string:x198>", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            if (distancesquared(from, to) < 0.01) {
                return;
            }
            if (!isdefined(time)) {
                time = 1000;
            }
            if (!isdefined(depthtest)) {
                depthtest = 1;
            }
            line(from, to, color, 1, depthtest, time);
        }
    #/
}

// Namespace airsupport
// Params 3, eflags: 0x0
// Checksum 0x3b4157f, Offset: 0x2d90
// Size: 0x8a
function debug_star(origin, color, time) {
    /#
        level.airsupport_debug = getdvarint("<dev string:x198>", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            if (!isdefined(time)) {
                time = 1000;
            }
            if (!isdefined(color)) {
                color = (1, 1, 1);
            }
            debugstar(origin, time, color);
        }
    #/
}

/#

    // Namespace airsupport
    // Params 4, eflags: 0x0
    // Checksum 0x53ac376f, Offset: 0x2e28
    // Size: 0x92
    function debug_circle(origin, radius, color, time) {
        level.airsupport_debug = getdvarint("<dev string:x198>", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            if (!isdefined(time)) {
                time = 1000;
            }
            if (!isdefined(color)) {
                color = (1, 1, 1);
            }
            circle(origin, radius, color, 1, 1, time);
        }
    }

#/

// Namespace airsupport
// Params 5, eflags: 0x0
// Checksum 0x4a033035, Offset: 0x2ec8
// Size: 0xca
function debug_sphere(origin, radius, color, alpha, time) {
    /#
        level.airsupport_debug = getdvarint("<dev string:x198>", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            if (!isdefined(time)) {
                time = 1000;
            }
            if (!isdefined(color)) {
                color = (1, 1, 1);
            }
            sides = int(10 * (1 + int(radius / 100)));
            sphere(origin, radius, color, alpha, 1, sides, time);
        }
    #/
}

/#

    // Namespace airsupport
    // Params 6, eflags: 0x0
    // Checksum 0x215728f1, Offset: 0x2fa0
    // Size: 0x8a
    function debug_airsupport_cylinder(origin, radius, height, color, mustrenderheight, time) {
        level.airsupport_debug = getdvarint("<dev string:x198>", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            debug_cylinder(origin, radius, height, color, mustrenderheight, time);
        }
    }

    // Namespace airsupport
    // Params 6, eflags: 0x0
    // Checksum 0x1c060732, Offset: 0x3038
    // Size: 0xe2
    function debug_cylinder(origin, radius, height, color, mustrenderheight, time) {
        subdivision = 600;
        if (!isdefined(time)) {
            time = 1000;
        }
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        count = height / subdivision;
        for (i = 0; i < count; i++) {
            point = origin + (0, 0, i * subdivision);
            circle(point, radius, color, 1, 1, time);
        }
        if (isdefined(mustrenderheight)) {
            point = origin + (0, 0, mustrenderheight);
            circle(point, radius, color, 1, 1, time);
        }
    }

#/

// Namespace airsupport
// Params 3, eflags: 0x0
// Checksum 0x98e1c83a, Offset: 0x3128
// Size: 0x61
function getpointonline(startpoint, endpoint, ratio) {
    nextpoint = (startpoint[0] + (endpoint[0] - startpoint[0]) * ratio, startpoint[1] + (endpoint[1] - startpoint[1]) * ratio, startpoint[2] + (endpoint[2] - startpoint[2]) * ratio);
    return nextpoint;
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0x4120eb50, Offset: 0x3198
// Size: 0x69
function cantargetplayerwithspecialty() {
    if (isdefined(self.specialty_nottargetedbyairsupport) && (self hasperk("specialty_nottargetedbyairsupport") || self.specialty_nottargetedbyairsupport)) {
        if (!isdefined(self.nottargettedai_underminspeedtimer) || self.nottargettedai_underminspeedtimer < getdvarint("perk_nottargetedbyai_graceperiod")) {
            return false;
        }
    }
    return true;
}

// Namespace airsupport
// Params 1, eflags: 0x0
// Checksum 0x9b6bb55d, Offset: 0x3210
// Size: 0x141
function monitorspeed(spawnprotectiontime) {
    self endon(#"death");
    self endon(#"disconnect");
    if (self hasperk("specialty_nottargetedbyairsupport") == 0) {
        return;
    }
    getdvarstring("perk_nottargetted_graceperiod");
    graceperiod = getdvarint("perk_nottargetedbyai_graceperiod");
    minspeed = getdvarint("perk_nottargetedbyai_min_speed");
    minspeedsq = minspeed * minspeed;
    waitperiod = 0.25;
    waitperiodmilliseconds = waitperiod * 1000;
    if (minspeedsq == 0) {
        return;
    }
    self.nottargettedai_underminspeedtimer = 0;
    if (isdefined(spawnprotectiontime)) {
        wait spawnprotectiontime;
    }
    while (true) {
        velocity = self getvelocity();
        speedsq = lengthsquared(velocity);
        if (speedsq < minspeedsq) {
            self.nottargettedai_underminspeedtimer = self.nottargettedai_underminspeedtimer + waitperiodmilliseconds;
        } else {
            self.nottargettedai_underminspeedtimer = 0;
        }
        wait waitperiod;
    }
}

// Namespace airsupport
// Params 0, eflags: 0x0
// Checksum 0x427dc60c, Offset: 0x3360
// Size: 0x16
function clearmonitoredspeed() {
    if (isdefined(self.nottargettedai_underminspeedtimer)) {
        self.nottargettedai_underminspeedtimer = 0;
    }
}

