#using scripts/mp/_util;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/challenges_shared;
#using scripts/codescripts/struct;

#namespace airsupport;

// Namespace airsupport
// Params 0, eflags: 0x1 linked
// Checksum 0xf27215d2, Offset: 0x358
// Size: 0x18c
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
// Params 2, eflags: 0x1 linked
// Checksum 0x4d4ac4a8, Offset: 0x4f0
// Size: 0x4c
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
// Checksum 0x10cf9677, Offset: 0x548
// Size: 0x48
function function_c92c5dd5(var_1bc5675c, var_6376ee77, usedcallback) {
    self notify(#"used");
    wait 0.05;
    return self [[ usedcallback ]](var_1bc5675c, var_6376ee77);
}

// Namespace airsupport
// Params 0, eflags: 0x1 linked
// Checksum 0xe0b98a60, Offset: 0x598
// Size: 0x5a
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
// Params 0, eflags: 0x1 linked
// Checksum 0xc69e28de, Offset: 0x600
// Size: 0x5a
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
// Params 0, eflags: 0x1 linked
// Checksum 0x1f5fb587, Offset: 0x668
// Size: 0x176
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
// Params 0, eflags: 0x1 linked
// Checksum 0x383fcc23, Offset: 0x7e8
// Size: 0x84
function clearuplocationselection() {
    event = self util::waittill_any_return("death", "disconnect", "game_ended", "used", "weapon_change", "emp_jammed", "weapon_change_complete");
    if (event != "disconnect") {
        self endlocationselection();
    }
}

// Namespace airsupport
// Params 1, eflags: 0x0
// Checksum 0xdc000094, Offset: 0x878
// Size: 0x34
function stoploopsoundaftertime(time) {
    self endon(#"death");
    wait time;
    self stoploopsound(2);
}

// Namespace airsupport
// Params 1, eflags: 0x1 linked
// Checksum 0xa3ba544e, Offset: 0x8b8
// Size: 0x64
function calculatefalltime(flyheight) {
    gravity = getdvarint("bg_gravity");
    time = sqrt(2 * flyheight / gravity);
    return time;
}

// Namespace airsupport
// Params 4, eflags: 0x1 linked
// Checksum 0x2eef3ff7, Offset: 0x928
// Size: 0x92
function calculatereleasetime(flytime, flyheight, flyspeed, bombspeedscale) {
    falltime = calculatefalltime(flyheight);
    bomb_x = flyspeed * bombspeedscale * falltime;
    release_time = bomb_x / flyspeed;
    return flytime * 0.5 - release_time;
}

// Namespace airsupport
// Params 0, eflags: 0x1 linked
// Checksum 0xf0951f8a, Offset: 0x9c8
// Size: 0x10e
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
// Checksum 0x54344857, Offset: 0xae0
// Size: 0x3f4
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
    side = vectorcross(anglestoforward(direction), (0, 0, 1));
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
// Params 10, eflags: 0x1 linked
// Checksum 0xf170a78d, Offset: 0xee0
// Size: 0x14c
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
// Params 2, eflags: 0x1 linked
// Checksum 0xc1dd2e4b, Offset: 0x1038
// Size: 0x8c
function determinegroundpoint(player, position) {
    ground = (position[0], position[1], player.origin[2]);
    trace = bullettrace(ground + (0, 0, 10000), ground, 0, undefined);
    return trace["position"];
}

// Namespace airsupport
// Params 2, eflags: 0x0
// Checksum 0x30014b87, Offset: 0x10d0
// Size: 0x4a
function determinetargetpoint(player, position) {
    point = determinegroundpoint(player, position);
    return clamptarget(point);
}

// Namespace airsupport
// Params 0, eflags: 0x1 linked
// Checksum 0xc0fa1d15, Offset: 0x1128
// Size: 0x16
function getmintargetheight() {
    return level.spawnmins[2] - 500;
}

// Namespace airsupport
// Params 0, eflags: 0x1 linked
// Checksum 0x918658cb, Offset: 0x1148
// Size: 0x16
function getmaxtargetheight() {
    return level.spawnmaxs[2] + 500;
}

// Namespace airsupport
// Params 1, eflags: 0x1 linked
// Checksum 0x273a1457, Offset: 0x1168
// Size: 0x94
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
// Params 4, eflags: 0x1 linked
// Checksum 0x233bf2cb, Offset: 0x1208
// Size: 0x8e
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
// Params 3, eflags: 0x1 linked
// Checksum 0x9c3fc95b, Offset: 0x12a0
// Size: 0x9a
function _insidenoflyzonebyindex(point, index, disregardheight) {
    height = level.noflyzones[index].height;
    if (isdefined(disregardheight)) {
        height = undefined;
    }
    return _insidecylinder(point, level.noflyzones[index].origin, level.noflyzones[index].radius, height);
}

// Namespace airsupport
// Params 1, eflags: 0x1 linked
// Checksum 0xd6e8e7db, Offset: 0x1348
// Size: 0x100
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
// Params 2, eflags: 0x1 linked
// Checksum 0x36811204, Offset: 0x1450
// Size: 0x86
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
// Params 2, eflags: 0x1 linked
// Checksum 0x8bfa5b4f, Offset: 0x14e0
// Size: 0x156
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
// Params 2, eflags: 0x1 linked
// Checksum 0x7110a680, Offset: 0x1640
// Size: 0x144
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
// Params 3, eflags: 0x1 linked
// Checksum 0xb1cdccbb, Offset: 0x1790
// Size: 0x132
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
// Params 2, eflags: 0x1 linked
// Checksum 0xe1a41d17, Offset: 0x18d0
// Size: 0x7a
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
// Params 3, eflags: 0x1 linked
// Checksum 0x9915dc5, Offset: 0x1958
// Size: 0x6e
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
// Params 2, eflags: 0x1 linked
// Checksum 0x82b6de87, Offset: 0x19d0
// Size: 0x118
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
// Params 3, eflags: 0x1 linked
// Checksum 0x3aab51e1, Offset: 0x1af0
// Size: 0x114
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
// Checksum 0xd8b13b8e, Offset: 0x1c10
// Size: 0xa4
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
// Checksum 0xbe577164, Offset: 0x1cc0
// Size: 0xa0
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
// Checksum 0x8c960f08, Offset: 0x1d68
// Size: 0x56
function append_array(dst, src) {
    for (i = 0; i < src.size; i++) {
        dst[dst.size] = src[i];
    }
}

// Namespace airsupport
// Params 6, eflags: 0x1 linked
// Checksum 0xc51ce290, Offset: 0x1dc8
// Size: 0x102
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
// Params 4, eflags: 0x1 linked
// Checksum 0xe9eb8a5b, Offset: 0x1ed8
// Size: 0x172
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
// Params 3, eflags: 0x1 linked
// Checksum 0x9d7370ab, Offset: 0x2058
// Size: 0x1b2
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
// Params 4, eflags: 0x1 linked
// Checksum 0x9cd84d68, Offset: 0x2218
// Size: 0x18a
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
// Checksum 0x289984a2, Offset: 0x23b0
// Size: 0x74
function doglassdamage(pos, radius, max, min, mod) {
    wait randomfloatrange(0.05, 0.15);
    glassradiusdamage(pos, radius, max, min, mod);
}

// Namespace airsupport
// Params 7, eflags: 0x0
// Checksum 0xfbab79ba, Offset: 0x2430
// Size: 0x418
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
// Params 0, eflags: 0x1 linked
// Checksum 0x7d46af59, Offset: 0x2850
// Size: 0x70
function getmapcenter() {
    minimaporigins = getentarray("minimap_corner", "targetname");
    if (minimaporigins.size) {
        return math::find_box_center(minimaporigins[0].origin, minimaporigins[1].origin);
    }
    return (0, 0, 0);
}

// Namespace airsupport
// Params 4, eflags: 0x1 linked
// Checksum 0xde07bbe7, Offset: 0x28c8
// Size: 0x216
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
// Params 0, eflags: 0x1 linked
// Checksum 0x7f5edb97, Offset: 0x2ae8
// Size: 0xf6
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
// Params 0, eflags: 0x1 linked
// Checksum 0x8426984d, Offset: 0x2be8
// Size: 0xfc
function initrotatingrig() {
    level.airsupport_rotator = spawn("script_model", getmapcenter() + (isdefined(level.rotator_x_offset) ? level.rotator_x_offset : 0, isdefined(level.rotator_y_offset) ? level.rotator_y_offset : 0, 1200));
    level.airsupport_rotator setmodel("tag_origin");
    level.airsupport_rotator.angles = (0, 115, 0);
    level.airsupport_rotator hide();
    level.airsupport_rotator thread rotaterig();
    level.airsupport_rotator thread swayrig();
}

// Namespace airsupport
// Params 0, eflags: 0x1 linked
// Checksum 0x8264cad6, Offset: 0x2cf0
// Size: 0x2e
function rotaterig() {
    for (;;) {
        self rotateyaw(-360, 60);
        wait 60;
    }
}

// Namespace airsupport
// Params 0, eflags: 0x1 linked
// Checksum 0xfe9f30f6, Offset: 0x2d28
// Size: 0x11e
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
// Params 1, eflags: 0x1 linked
// Checksum 0x2bdf16e4, Offset: 0x2e50
// Size: 0x34
function stoprotation(time) {
    self endon(#"death");
    wait time;
    self stoploopsound();
}

// Namespace airsupport
// Params 1, eflags: 0x1 linked
// Checksum 0xc231a83f, Offset: 0x2e90
// Size: 0xbc
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
// Params 0, eflags: 0x1 linked
// Checksum 0x303a839d, Offset: 0x2f58
// Size: 0x68
function flattenroll() {
    self endon(#"death");
    while (self.angles[2] < 0) {
        self.angles = (self.angles[0], self.angles[1], self.angles[2] + 2.5);
        wait 0.05;
    }
}

// Namespace airsupport
// Params 1, eflags: 0x1 linked
// Checksum 0x2e06faa2, Offset: 0x2fc8
// Size: 0x2a2
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
// Checksum 0xde1ab329, Offset: 0x3278
// Size: 0x1e4
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
    // Checksum 0x83e51dd, Offset: 0x3468
    // Size: 0x96
    function debug_no_fly_zones() {
        for (i = 0; i < level.noflyzones.size; i++) {
            debug_airsupport_cylinder(level.noflyzones[i].origin, level.noflyzones[i].radius, level.noflyzones[i].height, (1, 1, 1), undefined, 5000);
        }
    }

#/

// Namespace airsupport
// Params 4, eflags: 0x1 linked
// Checksum 0x70a35416, Offset: 0x3508
// Size: 0xc6
function debug_plane_line(flytime, flyspeed, pathstart, pathend) {
    thread debug_line(pathstart, pathend, (1, 1, 1));
    delta = vectornormalize(pathend - pathstart);
    for (i = 0; i < flytime; i++) {
        thread debug_star(pathstart + vectorscale(delta, i * flyspeed), (1, 0, 0));
    }
}

// Namespace airsupport
// Params 1, eflags: 0x1 linked
// Checksum 0xbc2be801, Offset: 0x35d8
// Size: 0x94
function debug_draw_bomb_explosion(prevpos) {
    self notify(#"draw_explosion");
    wait 0.05;
    self endon(#"draw_explosion");
    weapon, position = self waittill(#"projectile_impact");
    thread debug_line(prevpos, position, (0.5, 1, 0));
    thread debug_star(position, (1, 0, 0));
}

/#

    // Namespace airsupport
    // Params 3, eflags: 0x0
    // Checksum 0xa734e241, Offset: 0x3678
    // Size: 0x118
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
    // Params 4, eflags: 0x1 linked
    // Checksum 0x6ba8bb3f, Offset: 0x3798
    // Size: 0xd4
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
    // Params 5, eflags: 0x1 linked
    // Checksum 0xe6eac4a, Offset: 0x3878
    // Size: 0x11e
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
    // Params 5, eflags: 0x1 linked
    // Checksum 0x4a7c9a94, Offset: 0x39a0
    // Size: 0x9c
    function debug_print3d(message, color, ent, origin_offset, frames) {
        level.airsupport_debug = getdvarint("<dev string:x198>", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            self thread draw_text(message, color, ent, origin_offset, frames);
        }
    }

#/

// Namespace airsupport
// Params 5, eflags: 0x1 linked
// Checksum 0xa606eb83, Offset: 0x3a48
// Size: 0xec
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
// Params 3, eflags: 0x1 linked
// Checksum 0x13e48a71, Offset: 0x3b40
// Size: 0xac
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
    // Checksum 0xc97d38c7, Offset: 0x3bf8
    // Size: 0xbc
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
// Params 5, eflags: 0x1 linked
// Checksum 0x1fe407c3, Offset: 0x3cc0
// Size: 0x104
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
    // Params 6, eflags: 0x1 linked
    // Checksum 0xb12ada07, Offset: 0x3dd0
    // Size: 0xa4
    function debug_airsupport_cylinder(origin, radius, height, color, mustrenderheight, time) {
        level.airsupport_debug = getdvarint("<dev string:x198>", 0);
        if (isdefined(level.airsupport_debug) && level.airsupport_debug == 1) {
            debug_cylinder(origin, radius, height, color, mustrenderheight, time);
        }
    }

    // Namespace airsupport
    // Params 6, eflags: 0x1 linked
    // Checksum 0xc00b6e9c, Offset: 0x3e80
    // Size: 0x14c
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
// Checksum 0x6850499e, Offset: 0x3fd8
// Size: 0xa2
function getpointonline(startpoint, endpoint, ratio) {
    nextpoint = (startpoint[0] + (endpoint[0] - startpoint[0]) * ratio, startpoint[1] + (endpoint[1] - startpoint[1]) * ratio, startpoint[2] + (endpoint[2] - startpoint[2]) * ratio);
    return nextpoint;
}

// Namespace airsupport
// Params 0, eflags: 0x1 linked
// Checksum 0x81b80e91, Offset: 0x4088
// Size: 0x78
function cantargetplayerwithspecialty() {
    if (isdefined(self.specialty_nottargetedbyairsupport) && (self hasperk("specialty_nottargetedbyairsupport") || self.specialty_nottargetedbyairsupport)) {
        if (!isdefined(self.nottargettedai_underminspeedtimer) || self.nottargettedai_underminspeedtimer < getdvarint("perk_nottargetedbyai_graceperiod")) {
            return false;
        }
    }
    return true;
}

// Namespace airsupport
// Params 1, eflags: 0x1 linked
// Checksum 0xe9d6dfa2, Offset: 0x4108
// Size: 0x19e
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
            self.nottargettedai_underminspeedtimer += waitperiodmilliseconds;
        } else {
            self.nottargettedai_underminspeedtimer = 0;
        }
        wait waitperiod;
    }
}

// Namespace airsupport
// Params 0, eflags: 0x1 linked
// Checksum 0xf9c5426c, Offset: 0x42b0
// Size: 0x1c
function clearmonitoredspeed() {
    if (isdefined(self.nottargettedai_underminspeedtimer)) {
        self.nottargettedai_underminspeedtimer = 0;
    }
}

