#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;

#namespace zombie_utility;

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x3391397, Offset: 0x748
// Size: 0xd0
function zombiespawnsetup() {
    self.zombie_move_speed = "walk";
    if (!isdefined(self.zombie_arms_position)) {
        if (randomint(2) == 0) {
            self.zombie_arms_position = "up";
        } else {
            self.zombie_arms_position = "down";
        }
    }
    self.missinglegs = 0;
    self setavoidancemask("avoid none");
    self function_1762804b(1);
    clientfield::set("zombie", 1);
    self.ignorepathenemyfightdist = 1;
}

// Namespace zombie_utility
// Params 3, eflags: 0x1 linked
// Checksum 0x884fff41, Offset: 0x820
// Size: 0x2e6
function get_closest_valid_player(origin, ignore_player, ignore_laststand_players) {
    if (!isdefined(ignore_laststand_players)) {
        ignore_laststand_players = 0;
    }
    pixbeginevent("get_closest_valid_player");
    valid_player_found = 0;
    targets = getplayers();
    if (isdefined(level.closest_player_targets_override)) {
        targets = [[ level.closest_player_targets_override ]]();
    }
    if (isdefined(ignore_player)) {
        for (i = 0; i < ignore_player.size; i++) {
            arrayremovevalue(targets, ignore_player[i]);
        }
    }
    done = 1;
    while (targets.size && !done) {
        done = 1;
        for (i = 0; i < targets.size; i++) {
            target = targets[i];
            if (!is_player_valid(target, 1, ignore_laststand_players)) {
                arrayremovevalue(targets, target);
                done = 0;
                break;
            }
        }
    }
    if (targets.size == 0) {
        pixendevent();
        return undefined;
    }
    if (isdefined(self.closest_player_override)) {
        target = [[ self.closest_player_override ]](origin, targets);
    } else if (isdefined(level.closest_player_override)) {
        target = [[ level.closest_player_override ]](origin, targets);
    }
    if (isdefined(target)) {
        pixendevent();
        return target;
    }
    sortedpotentialtargets = arraysortclosest(targets, self.origin);
    while (sortedpotentialtargets.size) {
        if (is_player_valid(sortedpotentialtargets[0], 1, ignore_laststand_players)) {
            pixendevent();
            return sortedpotentialtargets[0];
        }
        arrayremovevalue(sortedpotentialtargets, sortedpotentialtargets[0]);
    }
    pixendevent();
    return undefined;
}

// Namespace zombie_utility
// Params 3, eflags: 0x1 linked
// Checksum 0xd3ea5f4, Offset: 0xb10
// Size: 0x1a0
function is_player_valid(player, checkignoremeflag, ignore_laststand_players) {
    if (!isdefined(player)) {
        return 0;
    }
    if (!isalive(player)) {
        return 0;
    }
    if (!isplayer(player)) {
        return 0;
    }
    if (isdefined(player.is_zombie) && player.is_zombie == 1) {
        return 0;
    }
    if (player.sessionstate == "spectator") {
        return 0;
    }
    if (player.sessionstate == "intermission") {
        return 0;
    }
    if (isdefined(player.intermission) && player.intermission) {
        return 0;
    }
    if (!(isdefined(ignore_laststand_players) && ignore_laststand_players)) {
        if (player laststand::player_is_in_laststand()) {
            return 0;
        }
    }
    if (player isnotarget()) {
        return 0;
    }
    if (isdefined(checkignoremeflag) && checkignoremeflag && player.ignoreme) {
        return 0;
    }
    if (isdefined(level.is_player_valid_override)) {
        return [[ level.is_player_valid_override ]](player);
    }
    return 1;
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x4169ad05, Offset: 0xcb8
// Size: 0x4a
function append_missing_legs_suffix(animstate) {
    if (self.missinglegs && self hasanimstatefromasd(animstate + "_crawl")) {
        return (animstate + "_crawl");
    }
    return animstate;
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xa97fcbdd, Offset: 0xd10
// Size: 0x80
function initanimtree(animscript) {
    if (animscript != "pain" && animscript != "death") {
        self.a.special = "none";
    }
    assert(isdefined(animscript), "<dev string:x28>");
    self.a.script = animscript;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x4f1fb2ef, Offset: 0xd98
// Size: 0xa6
function updateanimpose() {
    assert(self.a.movement == "<dev string:x51>" || self.a.movement == "<dev string:x56>" || self.a.movement == "<dev string:x5b>", "<dev string:x5f>" + self.a.pose + "<dev string:x6f>" + self.a.movement);
    self.desired_anim_pose = undefined;
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x4dfd7a80, Offset: 0xe48
// Size: 0x214
function initialize(animscript) {
    if (isdefined(self.longdeathstarting)) {
        if (animscript != "pain" && animscript != "death") {
            self dodamage(self.health + 100, self.origin);
        }
        if (animscript != "pain") {
            self.longdeathstarting = undefined;
            self notify(#"kill_long_death");
        }
    }
    if (isdefined(self.a.mayonlydie) && animscript != "death") {
        self dodamage(self.health + 100, self.origin);
    }
    if (isdefined(self.a.postscriptfunc)) {
        scriptfunc = self.a.postscriptfunc;
        self.a.postscriptfunc = undefined;
        [[ scriptfunc ]](animscript);
    }
    if (animscript != "death") {
        self.a.nodeath = 0;
    }
    self.isholdinggrenade = undefined;
    self.covernode = undefined;
    self.changingcoverpos = 0;
    self.a.scriptstarttime = gettime();
    self.a.atconcealmentnode = 0;
    if (self.node.type == "Conceal Crouch" || isdefined(self.node) && self.node.type == "Conceal Stand") {
        self.a.atconcealmentnode = 1;
    }
    initanimtree(animscript);
    updateanimpose();
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x40933a12, Offset: 0x1068
// Size: 0xa4
function getnodeyawtoorigin(pos) {
    if (isdefined(self.node)) {
        yaw = self.node.angles[1] - getyaw(pos);
    } else {
        yaw = self.angles[1] - getyaw(pos);
    }
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x46671ff6, Offset: 0x1118
// Size: 0x15c
function getnodeyawtoenemy() {
    pos = undefined;
    if (isvalidenemy(self.enemy)) {
        pos = self.enemy.origin;
    } else {
        if (isdefined(self.node)) {
            forward = anglestoforward(self.node.angles);
        } else {
            forward = anglestoforward(self.angles);
        }
        forward = vectorscale(forward, -106);
        pos = self.origin + forward;
    }
    if (isdefined(self.node)) {
        yaw = self.node.angles[1] - getyaw(pos);
    } else {
        yaw = self.angles[1] - getyaw(pos);
    }
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xbc46f941, Offset: 0x1280
// Size: 0x144
function getcovernodeyawtoenemy() {
    pos = undefined;
    if (isvalidenemy(self.enemy)) {
        pos = self.enemy.origin;
    } else {
        forward = anglestoforward(self.covernode.angles + self.animarray["angle_step_out"][self.a.cornermode]);
        forward = vectorscale(forward, -106);
        pos = self.origin + forward;
    }
    yaw = self.covernode.angles[1] + self.animarray["angle_step_out"][self.a.cornermode] - getyaw(pos);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xba0e7779, Offset: 0x13d0
// Size: 0x74
function getyawtospot(spot) {
    pos = spot;
    yaw = self.angles[1] - getyaw(pos);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x39f9e1f6, Offset: 0x1450
// Size: 0xe4
function getyawtoenemy() {
    pos = undefined;
    if (isvalidenemy(self.enemy)) {
        pos = self.enemy.origin;
    } else {
        forward = anglestoforward(self.angles);
        forward = vectorscale(forward, -106);
        pos = self.origin + forward;
    }
    yaw = self.angles[1] - getyaw(pos);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xd2926167, Offset: 0x1540
// Size: 0x42
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x7ec814e7, Offset: 0x1590
// Size: 0x6a
function getyaw2d(org) {
    angles = vectortoangles((org[0], org[1], 0) - (self.origin[0], self.origin[1], 0));
    return angles[1];
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x91006c28, Offset: 0x1608
// Size: 0xb0
function absyawtoenemy() {
    assert(isvalidenemy(self.enemy));
    yaw = self.angles[1] - getyaw(self.enemy.origin);
    yaw = angleclamp180(yaw);
    if (yaw < 0) {
        yaw = -1 * yaw;
    }
    return yaw;
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x296b2bad, Offset: 0x16c0
// Size: 0xb0
function absyawtoenemy2d() {
    assert(isvalidenemy(self.enemy));
    yaw = self.angles[1] - getyaw2d(self.enemy.origin);
    yaw = angleclamp180(yaw);
    if (yaw < 0) {
        yaw = -1 * yaw;
    }
    return yaw;
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x626b22a4, Offset: 0x1778
// Size: 0x78
function absyawtoorigin(org) {
    yaw = self.angles[1] - getyaw(org);
    yaw = angleclamp180(yaw);
    if (yaw < 0) {
        yaw = -1 * yaw;
    }
    return yaw;
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x158b181e, Offset: 0x17f8
// Size: 0x68
function absyawtoangles(angles) {
    yaw = self.angles[1] - angles;
    yaw = angleclamp180(yaw);
    if (yaw < 0) {
        yaw = -1 * yaw;
    }
    return yaw;
}

// Namespace zombie_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x74dd03db, Offset: 0x1868
// Size: 0x4a
function getyawfromorigin(org, start) {
    angles = vectortoangles(org - start);
    return angles[1];
}

// Namespace zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x553c0875, Offset: 0x18c0
// Size: 0x8c
function getyawtotag(tag, org) {
    yaw = self gettagangles(tag)[1] - getyawfromorigin(org, self gettagorigin(tag));
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xdeaa4f52, Offset: 0x1958
// Size: 0x5c
function getyawtoorigin(org) {
    yaw = self.angles[1] - getyaw(org);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x273f7fdc, Offset: 0x19c0
// Size: 0x74
function geteyeyawtoorigin(org) {
    yaw = self gettagangles("TAG_EYE")[1] - getyaw(org);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xb3c45013, Offset: 0x1a40
// Size: 0x8c
function getcovernodeyawtoorigin(org) {
    yaw = self.covernode.angles[1] + self.animarray["angle_step_out"][self.a.cornermode] - getyaw(org);
    yaw = angleclamp180(yaw);
    return yaw;
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xf6ae4fb6, Offset: 0x1ad8
// Size: 0x4a
function isstanceallowedwrapper(stance) {
    if (isdefined(self.covernode)) {
        return self.covernode doesnodeallowstance(stance);
    }
    return self isstanceallowed(stance);
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x767b0b2, Offset: 0x1b30
// Size: 0x64
function getclaimednode() {
    mynode = self.node;
    if (isdefined(self.covernode) && (self nearnode(mynode) || isdefined(mynode) && mynode == self.covernode)) {
        return mynode;
    }
    return undefined;
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x5be591d9, Offset: 0x1ba0
// Size: 0x3e
function getnodetype() {
    mynode = getclaimednode();
    if (isdefined(mynode)) {
        return mynode.type;
    }
    return "none";
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x31ab9b92, Offset: 0x1be8
// Size: 0x46
function getnodedirection() {
    mynode = getclaimednode();
    if (isdefined(mynode)) {
        return mynode.angles[1];
    }
    return self.desiredangle;
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x4628d046, Offset: 0x1c38
// Size: 0x62
function getnodeforward() {
    mynode = getclaimednode();
    if (isdefined(mynode)) {
        return anglestoforward(mynode.angles);
    }
    return anglestoforward(self.angles);
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x90526271, Offset: 0x1ca8
// Size: 0x3e
function getnodeorigin() {
    mynode = getclaimednode();
    if (isdefined(mynode)) {
        return mynode.origin;
    }
    return self.origin;
}

// Namespace zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x3ae2699, Offset: 0x1cf0
// Size: 0x58
function safemod(a, b) {
    result = int(a) % b;
    result += b;
    return result % b;
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xfb967858, Offset: 0x1d50
// Size: 0x56
function angleclamp(angle) {
    anglefrac = angle / 360;
    angle = (anglefrac - floor(anglefrac)) * 360;
    return angle;
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x1b8b7754, Offset: 0x1db0
// Size: 0x266
function quadrantanimweights(yaw) {
    forwardweight = (90 - abs(yaw)) / 90;
    leftweight = (90 - absangleclamp180(abs(yaw - 90))) / 90;
    result["front"] = 0;
    result["right"] = 0;
    result["back"] = 0;
    result["left"] = 0;
    if (isdefined(self.alwaysrunforward)) {
        assert(self.alwaysrunforward);
        result["front"] = 1;
        return result;
    }
    useleans = getdvarint("ai_useLeanRunAnimations");
    if (forwardweight > 0) {
        result["front"] = forwardweight;
        if (leftweight > 0) {
            result["left"] = leftweight;
        } else {
            result["right"] = -1 * leftweight;
        }
    } else if (useleans) {
        result["back"] = -1 * forwardweight;
        if (leftweight > 0) {
            result["left"] = leftweight;
        } else {
            result["right"] = -1 * leftweight;
        }
    } else {
        backweight = -1 * forwardweight;
        if (leftweight > backweight) {
            result["left"] = 1;
        } else if (leftweight < forwardweight) {
            result["right"] = 1;
        } else {
            result["back"] = 1;
        }
    }
    return result;
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x2e9eec92, Offset: 0x2020
// Size: 0xac
function getquadrant(angle) {
    angle = angleclamp(angle);
    if (angle < 45 || angle > 315) {
        quadrant = "front";
    } else if (angle < -121) {
        quadrant = "left";
    } else if (angle < -31) {
        quadrant = "back";
    } else {
        quadrant = "right";
    }
    return quadrant;
}

// Namespace zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x78a05e0e, Offset: 0x20d8
// Size: 0x60
function isinset(input, set) {
    for (i = set.size - 1; i >= 0; i--) {
        if (input == set[i]) {
            return true;
        }
    }
    return false;
}

// Namespace zombie_utility
// Params 3, eflags: 0x0
// Checksum 0xe063b167, Offset: 0x2140
// Size: 0x3e
function notifyaftertime(notifystring, killmestring, time) {
    self endon(#"death");
    self endon(killmestring);
    wait time;
    self notify(notifystring);
}

/#

    // Namespace zombie_utility
    // Params 4, eflags: 0x0
    // Checksum 0x2756dd78, Offset: 0x2188
    // Size: 0x96
    function drawstringtime(msg, org, color, timer) {
        maxtime = timer * 20;
        for (i = 0; i < maxtime; i++) {
            print3d(org, msg, color, 1, 1);
            wait 0.05;
        }
    }

    // Namespace zombie_utility
    // Params 1, eflags: 0x0
    // Checksum 0x82b288bb, Offset: 0x2228
    // Size: 0x100
    function showlastenemysightpos(string) {
        self notify(#"hash_a5fb63c6");
        self endon(#"hash_a5fb63c6");
        self endon(#"death");
        if (!isvalidenemy(self.enemy)) {
            return;
        }
        if (self.enemy.team == "<dev string:x71>") {
            color = (0.4, 0.7, 1);
        } else {
            color = (1, 0.7, 0.4);
        }
        while (true) {
            wait 0.05;
            if (!isdefined(self.lastenemysightpos)) {
                continue;
            }
            print3d(self.lastenemysightpos, string, color, 1, 2.15);
        }
    }

#/

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xc4e4f278, Offset: 0x2330
// Size: 0x16
function debugtimeout() {
    wait 5;
    self notify(#"timeout");
}

// Namespace zombie_utility
// Params 3, eflags: 0x1 linked
// Checksum 0xa52b3da9, Offset: 0x2350
// Size: 0x120
function debugposinternal(org, string, size) {
    /#
        self endon(#"death");
        self notify("<dev string:x78>" + org);
        self endon("<dev string:x78>" + org);
        ent = spawnstruct();
        ent thread debugtimeout();
        ent endon(#"timeout");
        if (self.enemy.team == "<dev string:x71>") {
            color = (0.4, 0.7, 1);
        } else {
            color = (1, 0.7, 0.4);
        }
        while (true) {
            wait 0.05;
            print3d(org, string, color, 1, size);
        }
    #/
}

// Namespace zombie_utility
// Params 2, eflags: 0x0
// Checksum 0xa32aa93e, Offset: 0x2478
// Size: 0x34
function debugpos(org, string) {
    thread debugposinternal(org, string, 2.15);
}

// Namespace zombie_utility
// Params 3, eflags: 0x0
// Checksum 0x96bba678, Offset: 0x24b8
// Size: 0x3c
function debugpossize(org, string, size) {
    thread debugposinternal(org, string, size);
}

// Namespace zombie_utility
// Params 4, eflags: 0x1 linked
// Checksum 0xdc4373fc, Offset: 0x2500
// Size: 0xa0
function showdebugproc(frompoint, topoint, color, printtime) {
    /#
        self endon(#"death");
        timer = printtime * 20;
        for (i = 0; i < timer; i += 1) {
            wait 0.05;
            line(frompoint, topoint, color);
        }
    #/
}

// Namespace zombie_utility
// Params 4, eflags: 0x0
// Checksum 0x6d667a80, Offset: 0x25a8
// Size: 0x5c
function showdebugline(frompoint, topoint, color, printtime) {
    self thread showdebugproc(frompoint, topoint + (0, 0, -5), color, printtime);
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xcc6799fc, Offset: 0x2610
// Size: 0x33a
function getnodeoffset(node) {
    if (isdefined(node.offset)) {
        return node.offset;
    }
    cover_left_crouch_offset = (-26, 0.4, 36);
    cover_left_stand_offset = (-32, 7, 63);
    cover_right_crouch_offset = (43.5, 11, 36);
    cover_right_stand_offset = (36, 8.3, 63);
    cover_crouch_offset = (3.5, -12.5, 45);
    cover_stand_offset = (-3.7, -22, 63);
    cornernode = 0;
    nodeoffset = (0, 0, 0);
    right = anglestoright(node.angles);
    forward = anglestoforward(node.angles);
    switch (node.type) {
    case "Cover Left":
    case "Cover Left Wide":
        if (node isnodedontstand() && !node isnodedontcrouch()) {
            nodeoffset = calculatenodeoffset(right, forward, cover_left_crouch_offset);
        } else {
            nodeoffset = calculatenodeoffset(right, forward, cover_left_stand_offset);
        }
        break;
    case "Cover Right":
    case "Cover Right Wide":
        if (node isnodedontstand() && !node isnodedontcrouch()) {
            nodeoffset = calculatenodeoffset(right, forward, cover_right_crouch_offset);
        } else {
            nodeoffset = calculatenodeoffset(right, forward, cover_right_stand_offset);
        }
        break;
    case "Conceal Stand":
    case "Cover Stand":
    case "Turret":
        nodeoffset = calculatenodeoffset(right, forward, cover_stand_offset);
        break;
    case "Conceal Crouch":
    case "Cover Crouch":
    case "Cover Crouch Window":
        nodeoffset = calculatenodeoffset(right, forward, cover_crouch_offset);
        break;
    }
    node.offset = nodeoffset;
    return node.offset;
}

// Namespace zombie_utility
// Params 3, eflags: 0x1 linked
// Checksum 0x8935161, Offset: 0x2958
// Size: 0x4e
function calculatenodeoffset(right, forward, baseoffset) {
    return vectorscale(right, baseoffset[0]) + vectorscale(forward, baseoffset[1]) + (0, 0, baseoffset[2]);
}

// Namespace zombie_utility
// Params 3, eflags: 0x0
// Checksum 0x44efd1d8, Offset: 0x29b0
// Size: 0xe6
function checkpitchvisibility(frompoint, topoint, atnode) {
    pitch = angleclamp180(vectortoangles(topoint - frompoint)[0]);
    if (abs(pitch) > 45) {
        if (isdefined(atnode) && atnode.type != "Cover Crouch" && atnode.type != "Conceal Crouch") {
            return false;
        }
        if (pitch > 45 || pitch < anim.covercrouchleanpitch - 45) {
            return false;
        }
    }
    return true;
}

/#

    // Namespace zombie_utility
    // Params 3, eflags: 0x0
    // Checksum 0x45d4391, Offset: 0x2aa0
    // Size: 0x78
    function showlines(start, end, end2) {
        for (;;) {
            line(start, end, (1, 0, 0), 1);
            wait 0.05;
            line(start, end2, (0, 0, 1), 1);
            wait 0.05;
        }
    }

#/

// Namespace zombie_utility
// Params 2, eflags: 0x0
// Checksum 0xa67f333a, Offset: 0x2b20
// Size: 0x198
function anim_array(animarray, animweights) {
    total_anims = animarray.size;
    idleanim = randomint(total_anims);
    assert(total_anims);
    assert(animarray.size == animweights.size);
    if (total_anims == 1) {
        return animarray[0];
    }
    weights = 0;
    total_weight = 0;
    for (i = 0; i < total_anims; i++) {
        total_weight += animweights[i];
    }
    anim_play = randomfloat(total_weight);
    current_weight = 0;
    for (i = 0; i < total_anims; i++) {
        current_weight += animweights[i];
        if (anim_play >= current_weight) {
            continue;
        }
        idleanim = i;
        break;
    }
    return animarray[idleanim];
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xcf57c382, Offset: 0x2cc0
// Size: 0x38
function notforcedcover() {
    return self.a.forced_cover == "none" || self.a.forced_cover == "Show";
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x60bef587, Offset: 0x2d00
// Size: 0x34
function forcedcover(msg) {
    return isdefined(self.a.forced_cover) && self.a.forced_cover == msg;
}

/#

    // Namespace zombie_utility
    // Params 6, eflags: 0x0
    // Checksum 0xd38243ec, Offset: 0x2d40
    // Size: 0xa6
    function print3dtime(timer, org, msg, color, alpha, scale) {
        newtime = timer / 0.05;
        for (i = 0; i < newtime; i++) {
            print3d(org, msg, color, alpha, scale);
            wait 0.05;
        }
    }

    // Namespace zombie_utility
    // Params 5, eflags: 0x0
    // Checksum 0x762fc8c1, Offset: 0x2df0
    // Size: 0xd6
    function print3drise(org, msg, color, alpha, scale) {
        newtime = 100;
        up = 0;
        org = org;
        for (i = 0; i < newtime; i++) {
            up += 0.5;
            print3d(org + (0, 0, up), msg, color, alpha, scale);
            wait 0.05;
        }
    }

#/

// Namespace zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x7b09756, Offset: 0x2ed0
// Size: 0x42
function crossproduct(vec1, vec2) {
    return vec1[0] * vec2[1] - vec1[1] * vec2[0] > 0;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xdb7ec4c7, Offset: 0x2f20
// Size: 0x2a
function scriptchange() {
    self.a.current_script = "none";
    self notify(anim.scriptchange);
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xf526f987, Offset: 0x2f58
// Size: 0x1c
function delayedscriptchange() {
    wait 0.05;
    scriptchange();
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x6cf78475, Offset: 0x2f80
// Size: 0x32
function sawenemymove(timer) {
    if (!isdefined(timer)) {
        timer = 500;
    }
    return gettime() - self.personalsighttime < timer;
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xf1397bf3, Offset: 0x2fc0
// Size: 0x3a
function canthrowgrenade() {
    if (!self.grenadeammo) {
        return 0;
    }
    if (self.script_forcegrenade) {
        return 1;
    }
    return isplayer(self.enemy);
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x761aa871, Offset: 0x3008
// Size: 0x110
function random_weight(array) {
    idleanim = randomint(array.size);
    if (array.size > 1) {
        anim_weight = 0;
        for (i = 0; i < array.size; i++) {
            anim_weight += array[i];
        }
        anim_play = randomfloat(anim_weight);
        anim_weight = 0;
        for (i = 0; i < array.size; i++) {
            anim_weight += array[i];
            if (anim_play < anim_weight) {
                idleanim = i;
                break;
            }
        }
    }
    return idleanim;
}

// Namespace zombie_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x9506e38d, Offset: 0x3120
// Size: 0xd4
function setfootstepeffect(name, fx) {
    assert(isdefined(name), "<dev string:x84>");
    assert(isdefined(fx), "<dev string:xae>");
    if (!isdefined(anim.optionalstepeffects)) {
        anim.optionalstepeffects = [];
    }
    anim.optionalstepeffects[anim.optionalstepeffects.size] = name;
    level._effect["step_" + name] = fx;
    anim.optionalstepeffectfunction = &zombie_shared::playfootstepeffect;
}

/#

    // Namespace zombie_utility
    // Params 2, eflags: 0x0
    // Checksum 0x552355f3, Offset: 0x3200
    // Size: 0x78
    function persistentdebugline(start, end) {
        self endon(#"death");
        level notify(#"newdebugline");
        level endon(#"newdebugline");
        for (;;) {
            line(start, end, (0.3, 1, 0), 1);
            wait 0.05;
        }
    }

#/

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x143612e6, Offset: 0x3280
// Size: 0x16
function isnodedontstand() {
    return (self.spawnflags & 4) == 4;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x2c2e7ffa, Offset: 0x32a0
// Size: 0x16
function isnodedontcrouch() {
    return (self.spawnflags & 8) == 8;
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x421e081f, Offset: 0x32c0
// Size: 0x76
function doesnodeallowstance(stance) {
    if (stance == "stand") {
        return !self isnodedontstand();
    }
    assert(stance == "<dev string:xd6>");
    return !self isnodedontcrouch();
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x93e9d02a, Offset: 0x3340
// Size: 0xb8
function animarray(animname) {
    assert(isdefined(self.a.array));
    /#
        if (!isdefined(self.a.array[animname])) {
            dumpanimarray();
            assert(isdefined(self.a.array[animname]), "<dev string:xdd>" + animname + "<dev string:xed>");
        }
    #/
    return self.a.array[animname];
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x254f2535, Offset: 0x3400
// Size: 0xbe
function animarrayanyexist(animname) {
    assert(isdefined(self.a.array));
    /#
        if (!isdefined(self.a.array[animname])) {
            dumpanimarray();
            assert(isdefined(self.a.array[animname]), "<dev string:xdd>" + animname + "<dev string:xed>");
        }
    #/
    return self.a.array[animname].size > 0;
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xa9064623, Offset: 0x34c8
// Size: 0x14e
function animarraypickrandom(animname) {
    assert(isdefined(self.a.array));
    /#
        if (!isdefined(self.a.array[animname])) {
            dumpanimarray();
            assert(isdefined(self.a.array[animname]), "<dev string:xdd>" + animname + "<dev string:xed>");
        }
    #/
    assert(self.a.array[animname].size > 0);
    if (self.a.array[animname].size > 1) {
        index = randomint(self.a.array[animname].size);
    } else {
        index = 0;
    }
    return self.a.array[animname][index];
}

/#

    // Namespace zombie_utility
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8e04679c, Offset: 0x3620
    // Size: 0x14e
    function dumpanimarray() {
        println("<dev string:xfe>");
        keys = getarraykeys(self.a.array);
        for (i = 0; i < keys.size; i++) {
            if (isarray(self.a.array[keys[i]])) {
                println("<dev string:x10c>" + keys[i] + "<dev string:x116>" + self.a.array[keys[i]].size + "<dev string:x12c>");
                continue;
            }
            println("<dev string:x10c>" + keys[i] + "<dev string:x12e>", self.a.array[keys[i]]);
        }
    }

#/

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xaf180f87, Offset: 0x3778
// Size: 0x52
function getanimendpos(theanim) {
    movedelta = getmovedelta(theanim, 0, 1, self);
    return self localtoworldcoords(movedelta);
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x1e99411e, Offset: 0x37d8
// Size: 0x1e
function isvalidenemy(enemy) {
    if (!isdefined(enemy)) {
        return false;
    }
    return true;
}

// Namespace zombie_utility
// Params 12, eflags: 0x1 linked
// Checksum 0xca1ce13c, Offset: 0x3800
// Size: 0x226
function damagelocationisany(a, b, c, d, e, f, g, h, i, j, k, ovr) {
    if (!isdefined(self.damagelocation)) {
        return false;
    }
    if (!isdefined(a)) {
        return false;
    }
    if (self.damagelocation == a) {
        return true;
    }
    if (!isdefined(b)) {
        return false;
    }
    if (self.damagelocation == b) {
        return true;
    }
    if (!isdefined(c)) {
        return false;
    }
    if (self.damagelocation == c) {
        return true;
    }
    if (!isdefined(d)) {
        return false;
    }
    if (self.damagelocation == d) {
        return true;
    }
    if (!isdefined(e)) {
        return false;
    }
    if (self.damagelocation == e) {
        return true;
    }
    if (!isdefined(f)) {
        return false;
    }
    if (self.damagelocation == f) {
        return true;
    }
    if (!isdefined(g)) {
        return false;
    }
    if (self.damagelocation == g) {
        return true;
    }
    if (!isdefined(h)) {
        return false;
    }
    if (self.damagelocation == h) {
        return true;
    }
    if (!isdefined(i)) {
        return false;
    }
    if (self.damagelocation == i) {
        return true;
    }
    if (!isdefined(j)) {
        return false;
    }
    if (self.damagelocation == j) {
        return true;
    }
    if (!isdefined(k)) {
        return false;
    }
    if (self.damagelocation == k) {
        return true;
    }
    assert(!isdefined(ovr));
    return false;
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x34a3ad80, Offset: 0x3a30
// Size: 0xf8
function ragdolldeath(moveanim) {
    self endon(#"killanimscript");
    lastorg = self.origin;
    movevec = (0, 0, 0);
    for (;;) {
        wait 0.05;
        force = distance(self.origin, lastorg);
        lastorg = self.origin;
        if (self.health == 1) {
            self.a.nodeath = 1;
            self startragdoll();
            wait 0.05;
            physicsexplosionsphere(lastorg, 600, 0, force * 0.1);
            self notify(#"killanimscript");
            return;
        }
    }
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x8b67d632, Offset: 0x3b30
// Size: 0x16
function iscqbwalking() {
    return isdefined(self.cqbwalking) && self.cqbwalking;
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x4056df3, Offset: 0x3b50
// Size: 0x16
function squared(value) {
    return value * value;
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x2cfc6f7c, Offset: 0x3b70
// Size: 0x2c
function randomizeidleset() {
    self.a.idleset = randomint(2);
}

// Namespace zombie_utility
// Params 2, eflags: 0x0
// Checksum 0x6a8584fd, Offset: 0x3ba8
// Size: 0x66
function getrandomintfromseed(intseed, intmax) {
    assert(intmax > 0);
    index = intseed % anim.randominttablesize;
    return anim.randominttable[index] % intmax;
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x17a77267, Offset: 0x3c18
// Size: 0x16
function is_banzai() {
    return isdefined(self.banzai) && self.banzai;
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xb9912d43, Offset: 0x3c38
// Size: 0x16
function function_ef2e22f8() {
    return isdefined(self.var_b327e32a) && self.var_b327e32a;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x9698d414, Offset: 0x3c58
// Size: 0x22
function is_zombie() {
    if (isdefined(self.is_zombie) && self.is_zombie) {
        return true;
    }
    return false;
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0xee783b6f, Offset: 0x3c88
// Size: 0x22
function is_civilian() {
    if (isdefined(self.is_civilian) && self.is_civilian) {
        return true;
    }
    return false;
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0x14ece863, Offset: 0x3cb8
// Size: 0x68
function is_skeleton(skeleton) {
    if (skeleton == "base" && issubstr(function_614fad13(), "scaled")) {
        return true;
    }
    return function_614fad13() == skeleton;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xc4cc3f44, Offset: 0x3d28
// Size: 0x24
function function_614fad13() {
    if (isdefined(self.skeleton)) {
        return self.skeleton;
    }
    return "base";
}

// Namespace zombie_utility
// Params 2, eflags: 0x0
// Checksum 0xe1b5945, Offset: 0x3d58
// Size: 0xf4
function set_orient_mode(mode, val1) {
    /#
        if (level.dog_debug_orient == self getentnum()) {
            if (isdefined(val1)) {
                println("<dev string:x135>" + mode + "<dev string:x6f>" + val1 + "<dev string:x6f>" + gettime());
            } else {
                println("<dev string:x135>" + mode + "<dev string:x6f>" + gettime());
            }
        }
    #/
    if (isdefined(val1)) {
        self orientmode(mode, val1);
        return;
    }
    self orientmode(mode);
}

/#

    // Namespace zombie_utility
    // Params 1, eflags: 0x0
    // Checksum 0x288a36a5, Offset: 0x3e58
    // Size: 0x9c
    function debug_anim_print(text) {
        if (isdefined(level.dog_debug_anims) && level.dog_debug_anims) {
            println(text + "<dev string:x6f>" + gettime());
        }
        if (isdefined(level.dog_debug_anims_ent) && level.dog_debug_anims_ent == self getentnum()) {
            println(text + "<dev string:x6f>" + gettime());
        }
    }

    // Namespace zombie_utility
    // Params 2, eflags: 0x0
    // Checksum 0xa4b466e9, Offset: 0x3f00
    // Size: 0x194
    function debug_turn_print(text, line) {
        if (isdefined(level.dog_debug_turns) && level.dog_debug_turns == self getentnum()) {
            duration = -56;
            currentyawcolor = (1, 1, 1);
            lookaheadyawcolor = (1, 0, 0);
            desiredyawcolor = (1, 1, 0);
            currentyaw = angleclamp180(self.angles[1]);
            desiredyaw = angleclamp180(self.desiredangle);
            lookaheaddir = self.lookaheaddir;
            lookaheadangles = vectortoangles(lookaheaddir);
            lookaheadyaw = angleclamp180(lookaheadangles[1]);
            println(text + "<dev string:x6f>" + gettime() + "<dev string:x151>" + currentyaw + "<dev string:x158>" + lookaheadyaw + "<dev string:x160>" + desiredyaw);
        }
    }

#/

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x5e9098ab, Offset: 0x40a0
// Size: 0x30
function function_e0c8af4f() {
    /#
        return function_65ee983f("<dev string:x16b>", "<dev string:x182>");
    #/
    return 1;
}

// Namespace zombie_utility
// Params 0, eflags: 0x0
// Checksum 0x1e00fa8f, Offset: 0x40d8
// Size: 0x30
function function_5f551b9c() {
    /#
        return function_65ee983f("<dev string:x184>", "<dev string:x182>");
    #/
    return 1;
}

// Namespace zombie_utility
// Params 5, eflags: 0x1 linked
// Checksum 0x5e3be6f9, Offset: 0x4110
// Size: 0x14e
function set_zombie_var(zvar, value, is_float, column, is_team_based) {
    if (!isdefined(is_float)) {
        is_float = 0;
    }
    if (!isdefined(column)) {
        column = 1;
    }
    if (!isdefined(is_team_based)) {
        is_team_based = 0;
    }
    if (!isdefined(level.zombie_vars)) {
        level.zombie_vars = [];
    }
    if (is_team_based) {
        foreach (team in level.teams) {
            if (!isdefined(level.zombie_vars[team])) {
                level.zombie_vars[team] = [];
            }
            level.zombie_vars[team][zvar] = value;
        }
    } else {
        level.zombie_vars[zvar] = value;
    }
    return value;
}

// Namespace zombie_utility
// Params 4, eflags: 0x1 linked
// Checksum 0xde68798f, Offset: 0x4268
// Size: 0x372
function spawn_zombie(spawner, target_name, spawn_point, round_number) {
    if (!isdefined(spawner)) {
        println("<dev string:x19d>");
        return undefined;
    }
    while (getfreeactorcount() < 1) {
        wait 0.05;
    }
    spawner.script_moveoverride = 1;
    if (isdefined(spawner.script_forcespawn) && spawner.script_forcespawn) {
        if (sessionmodeiscampaignzombiesgame()) {
            guy = spawner spawner::spawn(1);
        } else if (isactorspawner(spawner) && isdefined(level.overridezombiespawn)) {
            guy = [[ level.overridezombiespawn ]]();
        } else {
            guy = spawner spawnfromspawner(0, 1);
        }
        if (!zombie_spawn_failed(guy)) {
            guy.spawn_time = gettime();
            if (isdefined(level.giveextrazombies)) {
                guy [[ level.giveextrazombies ]]();
            }
            guy enableaimassist();
            if (isdefined(round_number)) {
                guy._starting_round_number = round_number;
            }
            guy.team = level.zombie_team;
            if (isactor(guy)) {
                guy clearentityowner();
            }
            level.zombiemeleeplayercounter = 0;
            if (isactor(guy)) {
                guy forceteleport(spawner.origin);
            }
            guy show();
            spawner.count = 666;
            if (isdefined(target_name)) {
                guy.targetname = target_name;
            }
            if (isdefined(spawn_point) && isdefined(level.move_spawn_func)) {
                guy thread [[ level.move_spawn_func ]](spawn_point);
            }
            /#
                if (isdefined(spawner.zm_variant_type)) {
                    guy.variant_type = spawner.zm_variant_type;
                }
            #/
            return guy;
        } else {
            println("<dev string:x1c5>", spawner.origin);
            return undefined;
        }
    } else {
        println("<dev string:x204>", spawner.origin);
        return undefined;
    }
    return undefined;
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x53195f75, Offset: 0x45e8
// Size: 0x4e
function zombie_spawn_failed(spawn) {
    if (isdefined(spawn) && isalive(spawn)) {
        if (isalive(spawn)) {
            return false;
        }
    }
    return true;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x6a7f14c4, Offset: 0x4640
// Size: 0xee
function get_desired_origin() {
    if (isdefined(self.target)) {
        ent = getent(self.target, "targetname");
        if (!isdefined(ent)) {
            ent = struct::get(self.target, "targetname");
        }
        if (!isdefined(ent)) {
            ent = getnode(self.target, "targetname");
        }
        assert(isdefined(ent), "<dev string:x23f>" + self.target + "<dev string:x26b>" + self.origin);
        return ent.origin;
    }
    return undefined;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x472329f3, Offset: 0x4738
// Size: 0x70
function hide_pop() {
    self endon(#"death");
    self ghost();
    wait 0.5;
    if (isdefined(self)) {
        self show();
        util::wait_network_frame();
        if (isdefined(self)) {
            self.create_eyes = 1;
        }
    }
}

// Namespace zombie_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x5cfc9630, Offset: 0x47b0
// Size: 0x34
function handle_rise_notetracks(note, spot) {
    self thread finish_rise_notetracks(note, spot);
}

// Namespace zombie_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xecc86d9b, Offset: 0x47f0
// Size: 0x64
function finish_rise_notetracks(note, spot) {
    if (note == "deathout" || note == "deathhigh") {
        self.zombie_rise_death_out = 1;
        self notify(#"zombie_rise_death_out");
        wait 2;
        spot notify(#"stop_zombie_rise_fx");
    }
}

// Namespace zombie_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xbcf13e9, Offset: 0x4860
// Size: 0xdc
function zombie_rise_death(zombie, spot) {
    zombie.zombie_rise_death_out = 0;
    zombie endon(#"rise_anim_finished");
    while (isdefined(zombie) && isdefined(zombie.health) && zombie.health > 1) {
        amount = zombie waittill(#"damage");
    }
    if (isdefined(spot)) {
        spot notify(#"stop_zombie_rise_fx");
    }
    if (isdefined(zombie)) {
        zombie.deathanim = zombie get_rise_death_anim();
        zombie stopanimscripted();
    }
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xcb082283, Offset: 0x4948
// Size: 0x36
function get_rise_death_anim() {
    if (self.zombie_rise_death_out) {
        return "zm_rise_death_out";
    }
    self.noragdoll = 1;
    self.nodeathragdoll = 1;
    return "zm_rise_death_in";
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x2fad8c84, Offset: 0x4988
// Size: 0x5e
function reset_attack_spot() {
    if (isdefined(self.attacking_node)) {
        node = self.attacking_node;
        index = self.attacking_spot_index;
        node.attack_spots_taken[index] = 0;
        self.attacking_node = undefined;
        self.attacking_spot_index = undefined;
    }
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x5995f8fb, Offset: 0x49f0
// Size: 0x24
function zombie_gut_explosion() {
    self.guts_explosion = 1;
    gibserverutils::annihilate(self);
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x49741c37, Offset: 0x4a20
// Size: 0x84
function delayed_zombie_eye_glow() {
    self endon(#"zombie_delete");
    self endon(#"death");
    if (isdefined(self.in_the_ceiling) && (isdefined(self.in_the_ground) && self.in_the_ground || self.in_the_ceiling)) {
        while (!isdefined(self.create_eyes)) {
            wait 0.1;
        }
    } else {
        wait 0.5;
    }
    self zombie_eye_glow();
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xf1dc83d2, Offset: 0x4ab0
// Size: 0x6c
function zombie_eye_glow() {
    if (!isdefined(self) || !isactor(self)) {
        return;
    }
    if (!isdefined(self.no_eye_glow) || !self.no_eye_glow) {
        self clientfield::set("zombie_has_eyes", 1);
    }
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x54ef903f, Offset: 0x4b28
// Size: 0x64
function zombie_eye_glow_stop() {
    if (!isdefined(self) || !isactor(self)) {
        return;
    }
    if (!isdefined(self.no_eye_glow) || !self.no_eye_glow) {
        self clientfield::set("zombie_has_eyes", 0);
    }
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x7a6832ed, Offset: 0x4b98
// Size: 0x114
function round_spawn_failsafe_debug_draw() {
    self endon(#"death");
    for (prevorigin = self.origin; true; prevorigin = self.origin) {
        if (isdefined(level.toggle_keyline_always) && level.toggle_keyline_always) {
            self clientfield::set("zombie_keyline_render", 1);
            wait 1;
            continue;
        }
        wait 4;
        if (isdefined(self.lastchunk_destroy_time)) {
            if (gettime() - self.lastchunk_destroy_time < 8000) {
                continue;
            }
        }
        if (distancesquared(self.origin, prevorigin) < 576) {
            self clientfield::set("zombie_keyline_render", 1);
            continue;
        }
        self clientfield::set("zombie_keyline_render", 0);
    }
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x7bb333e6, Offset: 0x4cb8
// Size: 0x2d8
function round_spawn_failsafe() {
    self endon(#"death");
    if (isdefined(level.debug_keyline_zombies) && level.debug_keyline_zombies) {
        self thread round_spawn_failsafe_debug_draw();
    }
    for (prevorigin = self.origin; true; prevorigin = self.origin) {
        if (!level.zombie_vars["zombie_use_failsafe"]) {
            return;
        }
        if (isdefined(self.ignore_round_spawn_failsafe) && self.ignore_round_spawn_failsafe) {
            return;
        }
        if (!isdefined(level.failsafe_waittime)) {
            level.failsafe_waittime = 30;
        }
        wait level.failsafe_waittime;
        if (self.missinglegs) {
            wait 10;
        }
        if (isdefined(self.is_inert) && self.is_inert) {
            continue;
        }
        if (isdefined(self.lastchunk_destroy_time)) {
            if (gettime() - self.lastchunk_destroy_time < 8000) {
                continue;
            }
        }
        if (self.origin[2] < level.zombie_vars["below_world_check"]) {
            if (isdefined(level.put_timed_out_zombies_back_in_queue) && level.put_timed_out_zombies_back_in_queue && !level flag::get("special_round") && !(isdefined(self.isscreecher) && self.isscreecher)) {
                level.zombie_total++;
                level.zombie_total_subtract++;
            }
            self dodamage(self.health + 100, (0, 0, 0));
            break;
        }
        if (distancesquared(self.origin, prevorigin) < 576) {
            if (isdefined(level.var_383fcce5)) {
                self thread [[ level.var_383fcce5 ]](prevorigin);
            } else {
                if (isdefined(level.put_timed_out_zombies_back_in_queue) && level.put_timed_out_zombies_back_in_queue && !level flag::get("special_round")) {
                    if (!self.ignoreall && !(isdefined(self.nuked) && self.nuked) && !(isdefined(self.marked_for_death) && self.marked_for_death) && !(isdefined(self.isscreecher) && self.isscreecher) && !self.missinglegs) {
                        level.zombie_total++;
                        level.zombie_total_subtract++;
                    }
                }
                level.zombies_timeout_playspace++;
                self dodamage(self.health + 100, (0, 0, 0));
            }
            break;
        }
    }
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x27390e04, Offset: 0x4f98
// Size: 0x106
function ai_calculate_health(round_number) {
    level.zombie_health = level.zombie_vars["zombie_health_start"];
    for (i = 2; i <= round_number; i++) {
        if (i >= 10) {
            old_health = level.zombie_health;
            level.zombie_health += int(level.zombie_health * level.zombie_vars["zombie_health_increase_multiplier"]);
            if (level.zombie_health < old_health) {
                level.zombie_health = old_health;
                return;
            }
            continue;
        }
        level.zombie_health = int(level.zombie_health + level.zombie_vars["zombie_health_increase"]);
    }
}

// Namespace zombie_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xd1eca8dd, Offset: 0x50a8
// Size: 0x17c
function default_max_zombie_func(max_num, n_round) {
    /#
        count = getdvarint("<dev string:x271>", -1);
        if (count > -1) {
            return count;
        }
    #/
    max = max_num;
    if (n_round < 2) {
        max = int(max_num * 0.25);
    } else if (n_round < 3) {
        max = int(max_num * 0.3);
    } else if (n_round < 4) {
        max = int(max_num * 0.5);
    } else if (n_round < 5) {
        max = int(max_num * 0.7);
    } else if (n_round < 6) {
        max = int(max_num * 0.9);
    }
    return max;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xe5253599, Offset: 0x5230
// Size: 0x17c
function function_9d8e8d95() {
    if (level.round_number <= 3) {
        return;
    }
    level endon(#"intermission");
    level endon(#"end_of_round");
    level endon(#"restart_round");
    level endon(#"kill_round");
    while (level.zombie_total > 4) {
        wait 3;
    }
    for (a_ai_zombies = get_round_enemy_array(); a_ai_zombies.size > 0 || level.zombie_total > 0; a_ai_zombies = get_round_enemy_array()) {
        if (a_ai_zombies.size == 1) {
            ai_zombie = a_ai_zombies[0];
            if (isalive(ai_zombie)) {
                if (isdefined(level.var_9d8e8d95)) {
                    ai_zombie thread [[ level.var_9d8e8d95 ]]();
                } else if (!(ai_zombie.zombie_move_speed === "sprint")) {
                    ai_zombie set_zombie_run_cycle("sprint");
                    ai_zombie.var_ad16df15 = ai_zombie.zombie_move_speed;
                }
            }
        }
        wait 0.5;
    }
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xb303db9, Offset: 0x53b8
// Size: 0x26
function get_current_zombie_count() {
    enemies = get_round_enemy_array();
    return enemies.size;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xbe85ff5a, Offset: 0x53e8
// Size: 0xfe
function get_round_enemy_array() {
    a_ai_enemies = [];
    a_ai_valid_enemies = [];
    a_ai_enemies = getaiteamarray(level.zombie_team);
    for (i = 0; i < a_ai_enemies.size; i++) {
        if (isdefined(a_ai_enemies[i].ignore_enemy_count) && a_ai_enemies[i].ignore_enemy_count) {
            continue;
        }
        if (!isdefined(a_ai_valid_enemies)) {
            a_ai_valid_enemies = [];
        } else if (!isarray(a_ai_valid_enemies)) {
            a_ai_valid_enemies = array(a_ai_valid_enemies);
        }
        a_ai_valid_enemies[a_ai_valid_enemies.size] = a_ai_enemies[i];
    }
    return a_ai_valid_enemies;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x4dcc1c4d, Offset: 0x54f0
// Size: 0xf6
function get_zombie_array() {
    enemies = [];
    valid_enemies = [];
    enemies = getaispeciesarray(level.zombie_team, "all");
    for (i = 0; i < enemies.size; i++) {
        if (enemies[i].archetype == "zombie") {
            if (!isdefined(valid_enemies)) {
                valid_enemies = [];
            } else if (!isarray(valid_enemies)) {
                valid_enemies = array(valid_enemies);
            }
            valid_enemies[valid_enemies.size] = enemies[i];
        }
    }
    return valid_enemies;
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0x9c8ff1f7, Offset: 0x55f0
// Size: 0x30
function set_zombie_run_cycle_override_value(new_move_speed) {
    set_zombie_run_cycle(new_move_speed);
    self.zombie_move_speed_override = new_move_speed;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x7965ef61, Offset: 0x5628
// Size: 0x3c
function set_zombie_run_cycle_restore_from_override() {
    str_restore_move_speed = self.zombie_move_speed_restore;
    self.zombie_move_speed_override = undefined;
    set_zombie_run_cycle(str_restore_move_speed);
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xbe17265d, Offset: 0x5670
// Size: 0x28c
function set_zombie_run_cycle(new_move_speed) {
    if (isdefined(self.zombie_move_speed_override)) {
        self.zombie_move_speed_restore = new_move_speed;
        return;
    }
    self.var_ad16df15 = self.zombie_move_speed;
    if (isdefined(new_move_speed)) {
        self.zombie_move_speed = new_move_speed;
    } else if (level.gamedifficulty == 0) {
        self function_66508f36();
    } else {
        self function_f752bf09();
    }
    if (isdefined(level.zm_variant_type_max)) {
        /#
            if (false) {
                debug_variant_type = getdvarint("<dev string:x284>", -1);
                if (debug_variant_type != -1) {
                    if (debug_variant_type <= level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]) {
                        self.variant_type = debug_variant_type;
                    } else {
                        self.variant_type = level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position] - 1;
                    }
                } else {
                    self.variant_type = randomint(level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
                }
            }
        #/
        if (self.archetype === "zombie") {
            if (isdefined(self.zm_variant_type_max)) {
                self.variant_type = randomint(self.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
            } else if (isdefined(level.zm_variant_type_max[self.zombie_move_speed])) {
                self.variant_type = randomint(level.zm_variant_type_max[self.zombie_move_speed][self.zombie_arms_position]);
            } else {
                errormsg("<dev string:x29c>" + self.zombie_move_speed);
                self.variant_type = 0;
            }
        }
    }
    self.needs_run_update = 1;
    self notify(#"needs_run_update");
    self.deathanim = self append_missing_legs_suffix("zm_death");
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x9c29aca9, Offset: 0x5908
// Size: 0xc8
function function_f752bf09() {
    if (isdefined(level.var_46409ea5)) {
        self.zombie_move_speed = "run";
        level.var_46409ea5--;
        if (level.var_46409ea5 <= 0) {
            level.var_46409ea5 = undefined;
        }
        return;
    }
    rand = randomintrange(level.zombie_move_speed, level.zombie_move_speed + 35);
    if (rand <= 35) {
        self.zombie_move_speed = "walk";
        return;
    }
    if (rand <= 70) {
        self.zombie_move_speed = "run";
        return;
    }
    self.zombie_move_speed = "sprint";
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x65d99e22, Offset: 0x59d8
// Size: 0x6c
function function_66508f36() {
    rand = randomintrange(level.zombie_move_speed, level.zombie_move_speed + 25);
    if (rand <= 35) {
        self.zombie_move_speed = "walk";
        return;
    }
    self.zombie_move_speed = "run";
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xe7fe41de, Offset: 0x5a50
// Size: 0x264
function setup_zombie_knockdown(entity) {
    self.knockdown = 1;
    zombie_to_entity = entity.origin - self.origin;
    zombie_to_entity_2d = vectornormalize((zombie_to_entity[0], zombie_to_entity[1], 0));
    zombie_forward = anglestoforward(self.angles);
    zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
    zombie_right = anglestoright(self.angles);
    zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
    dot = vectordot(zombie_to_entity_2d, zombie_forward_2d);
    if (dot >= 0.5) {
        self.knockdown_direction = "front";
        self.getup_direction = "getup_back";
        return;
    }
    if (dot < 0.5 && dot > -0.5) {
        dot = vectordot(zombie_to_entity_2d, zombie_right_2d);
        if (dot > 0) {
            self.knockdown_direction = "right";
            if (math::cointoss()) {
                self.getup_direction = "getup_back";
            } else {
                self.getup_direction = "getup_belly";
            }
        } else {
            self.knockdown_direction = "left";
            self.getup_direction = "getup_belly";
        }
        return;
    }
    self.knockdown_direction = "back";
    self.getup_direction = "getup_belly";
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x9e9b23d4, Offset: 0x5cc0
// Size: 0x76
function clear_all_corpses() {
    corpse_array = getcorpsearray();
    for (i = 0; i < corpse_array.size; i++) {
        if (isdefined(corpse_array[i])) {
            corpse_array[i] delete();
        }
    }
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x51b706a6, Offset: 0x5d40
// Size: 0x7e
function get_current_actor_count() {
    count = 0;
    actors = getaispeciesarray(level.zombie_team, "all");
    if (isdefined(actors)) {
        count += actors.size;
    }
    count += get_current_corpse_count();
    return count;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x76a9ac16, Offset: 0x5dc8
// Size: 0x34
function get_current_corpse_count() {
    corpse_array = getcorpsearray();
    if (isdefined(corpse_array)) {
        return corpse_array.size;
    }
    return 0;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xefe1521d, Offset: 0x5e08
// Size: 0x4f8
function zombie_gib_on_damage() {
    while (true) {
        amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon = self waittill(#"damage");
        if (!isdefined(self)) {
            return;
        }
        if (!self zombie_should_gib(amount, attacker, type)) {
            continue;
        }
        if (self head_should_gib(attacker, type, point) && type != "MOD_BURNED") {
            self zombie_head_gib(attacker, type);
            continue;
        }
        if (!(isdefined(self.gibbed) && self.gibbed) && isdefined(self.damagelocation)) {
            if (self damagelocationisany("head", "helmet", "neck")) {
                continue;
            }
            self.stumble = undefined;
            switch (self.damagelocation) {
            case "torso_lower":
            case "torso_upper":
                if (!gibserverutils::isgibbed(self, 32)) {
                    gibserverutils::gibrightarm(self);
                }
                break;
            case "right_arm_lower":
            case "right_arm_upper":
            case "right_hand":
                if (!gibserverutils::isgibbed(self, 32)) {
                    gibserverutils::gibrightarm(self);
                }
                break;
            case "left_arm_lower":
            case "left_arm_upper":
            case "left_hand":
                if (!gibserverutils::isgibbed(self, 16)) {
                    gibserverutils::gibleftarm(self);
                }
                break;
            case "right_foot":
            case "right_leg_lower":
            case "right_leg_upper":
                if (self.health <= 0) {
                    gibserverutils::gibrightleg(self);
                    if (randomint(100) > 75) {
                        gibserverutils::gibleftleg(self);
                    }
                    self.missinglegs = 1;
                }
                break;
            case "left_foot":
            case "left_leg_lower":
            case "left_leg_upper":
                if (self.health <= 0) {
                    gibserverutils::gibleftleg(self);
                    if (randomint(100) > 75) {
                        gibserverutils::gibrightleg(self);
                    }
                    self.missinglegs = 1;
                }
                break;
            default:
                if (self.damagelocation == "none") {
                    if (type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH") {
                        self derive_damage_refs(point);
                        break;
                    }
                }
                break;
            }
            if (isdefined(level.custom_derive_damage_refs)) {
            }
            if (isdefined(self.missinglegs) && self.missinglegs && self.health > 0) {
                self allowedstances("crouch");
                self setphysparams(15, 0, 24);
                self allowpitchangle(1);
                self setpitchorient();
                health = self.health;
                health *= 0.1;
                if (isdefined(self.crawl_anim_override)) {
                    self [[ self.crawl_anim_override ]]();
                }
            }
            if (self.health > 0) {
                if (isdefined(level.gib_on_damage)) {
                    self thread [[ level.gib_on_damage ]]();
                }
            }
        }
    }
}

// Namespace zombie_utility
// Params 3, eflags: 0x1 linked
// Checksum 0x886a0fcd, Offset: 0x6308
// Size: 0x72
function add_zombie_gib_weapon_callback(weapon_name, gib_callback, gib_head_callback) {
    if (!isdefined(level.zombie_gib_weapons)) {
        level.zombie_gib_weapons = [];
    }
    if (!isdefined(level.zombie_gib_head_weapons)) {
        level.zombie_gib_head_weapons = [];
    }
    level.zombie_gib_weapons[weapon_name] = gib_callback;
    level.zombie_gib_head_weapons[weapon_name] = gib_head_callback;
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xc5f38764, Offset: 0x6388
// Size: 0x82
function have_zombie_weapon_gib_callback(weapon) {
    if (!isdefined(level.zombie_gib_weapons)) {
        level.zombie_gib_weapons = [];
    }
    if (!isdefined(level.zombie_gib_head_weapons)) {
        level.zombie_gib_head_weapons = [];
    }
    if (isweapon(weapon)) {
        weapon = weapon.name;
    }
    if (isdefined(level.zombie_gib_weapons[weapon])) {
        return true;
    }
    return false;
}

// Namespace zombie_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x21d6478f, Offset: 0x6418
// Size: 0xa0
function get_zombie_weapon_gib_callback(weapon, damage_percent) {
    if (!isdefined(level.zombie_gib_weapons)) {
        level.zombie_gib_weapons = [];
    }
    if (!isdefined(level.zombie_gib_head_weapons)) {
        level.zombie_gib_head_weapons = [];
    }
    if (isweapon(weapon)) {
        weapon = weapon.name;
    }
    if (isdefined(level.zombie_gib_weapons[weapon])) {
        return self [[ level.zombie_gib_weapons[weapon] ]](damage_percent);
    }
    return 0;
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xf3c78b59, Offset: 0x64c0
// Size: 0x82
function have_zombie_weapon_gib_head_callback(weapon) {
    if (!isdefined(level.zombie_gib_weapons)) {
        level.zombie_gib_weapons = [];
    }
    if (!isdefined(level.zombie_gib_head_weapons)) {
        level.zombie_gib_head_weapons = [];
    }
    if (isweapon(weapon)) {
        weapon = weapon.name;
    }
    if (isdefined(level.zombie_gib_head_weapons[weapon])) {
        return true;
    }
    return false;
}

// Namespace zombie_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x28c8e02f, Offset: 0x6550
// Size: 0xa0
function get_zombie_weapon_gib_head_callback(weapon, damage_location) {
    if (!isdefined(level.zombie_gib_weapons)) {
        level.zombie_gib_weapons = [];
    }
    if (!isdefined(level.zombie_gib_head_weapons)) {
        level.zombie_gib_head_weapons = [];
    }
    if (isweapon(weapon)) {
        weapon = weapon.name;
    }
    if (isdefined(level.zombie_gib_head_weapons[weapon])) {
        return self [[ level.zombie_gib_head_weapons[weapon] ]](damage_location);
    }
    return 0;
}

// Namespace zombie_utility
// Params 3, eflags: 0x1 linked
// Checksum 0x209c6aa4, Offset: 0x65f8
// Size: 0x28c
function zombie_should_gib(amount, attacker, type) {
    if (!isdefined(type)) {
        return false;
    }
    if (isdefined(self.is_on_fire) && self.is_on_fire) {
        return false;
    }
    if (isdefined(self.no_gib) && self.no_gib == 1) {
        return false;
    }
    prev_health = amount + self.health;
    if (prev_health <= 0) {
        prev_health = 1;
    }
    damage_percent = amount / prev_health * 100;
    weapon = undefined;
    if (isdefined(attacker)) {
        if (isdefined(attacker.can_gib_zombies) && (isplayer(attacker) || attacker.can_gib_zombies)) {
            if (isplayer(attacker)) {
                weapon = attacker getcurrentweapon();
            } else {
                weapon = attacker.weapon;
            }
            if (have_zombie_weapon_gib_callback(weapon)) {
                if (self get_zombie_weapon_gib_callback(weapon, damage_percent)) {
                    return true;
                }
                return false;
            }
        }
    }
    switch (type) {
    case "MOD_BURNED":
    case "MOD_FALLING":
    case "MOD_SUICIDE":
    case "MOD_TELEFRAG":
    case "MOD_TRIGGER_HURT":
    case "MOD_UNKNOWN":
        return false;
    case "MOD_MELEE":
        return false;
    }
    if (type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET") {
        if (!isdefined(attacker) || !isplayer(attacker)) {
            return false;
        }
        if (isdefined(level.start_weapon) && (weapon == level.weaponnone || weapon == level.start_weapon) || weapon.isgasweapon) {
            return false;
        }
    }
    if (damage_percent < 10) {
        return false;
    }
    return true;
}

// Namespace zombie_utility
// Params 3, eflags: 0x1 linked
// Checksum 0x96052f9d, Offset: 0x6890
// Size: 0x35a
function head_should_gib(attacker, type, point) {
    if (isdefined(self.head_gibbed) && self.head_gibbed) {
        return false;
    }
    if (!isdefined(attacker)) {
        return false;
    }
    if (!isplayer(attacker)) {
        if (!(isdefined(attacker.can_gib_zombies) && attacker.can_gib_zombies)) {
            return false;
        }
    }
    if (isplayer(attacker)) {
        weapon = attacker getcurrentweapon();
    } else {
        weapon = attacker.weapon;
    }
    if (have_zombie_weapon_gib_head_callback(weapon)) {
        if (self get_zombie_weapon_gib_head_callback(weapon, self.damagelocation)) {
            return true;
        }
        return false;
    }
    if (type != "MOD_RIFLE_BULLET" && type != "MOD_PISTOL_BULLET") {
        if (type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH") {
            if (distance(point, self gettagorigin("j_head")) > 55) {
                return false;
            } else {
                return true;
            }
        } else if (type == "MOD_PROJECTILE") {
            if (distance(point, self gettagorigin("j_head")) > 10) {
                return false;
            } else {
                return true;
            }
        } else if (weapon.weapclass != "spread") {
            return false;
        }
    }
    if (!self damagelocationisany("head", "helmet", "neck")) {
        return false;
    }
    if (isdefined(level.start_weapon) && (type == "MOD_PISTOL_BULLET" && weapon.weapclass != "smg" && weapon.weapclass != "spread" || weapon == level.weaponnone || weapon == level.start_weapon) || weapon.isgasweapon) {
        return false;
    }
    if (type == "MOD_PISTOL_BULLET" && sessionmodeiscampaigngame() && weapon.weapclass != "smg") {
        return false;
    }
    low_health_percent = self.health / self.maxhealth * 100;
    if (low_health_percent > 10) {
        return false;
    }
    return true;
}

// Namespace zombie_utility
// Params 2, eflags: 0x0
// Checksum 0xb688b1b, Offset: 0x6bf8
// Size: 0xf8
function zombie_hat_gib(attacker, means_of_death) {
    self endon(#"death");
    if (isdefined(self.hat_gibbed) && self.hat_gibbed) {
        return;
    }
    if (!isdefined(self.gibspawn5) || !isdefined(self.gibspawntag5)) {
        return;
    }
    self.hat_gibbed = 1;
    if (isdefined(self.hatmodel)) {
        self detach(self.hatmodel, "");
    }
    temp_array = [];
    temp_array[0] = level._zombie_gib_piece_index_hat;
    self gib("normal", temp_array);
    if (isdefined(level.track_gibs)) {
        level [[ level.track_gibs ]](self, temp_array);
    }
}

// Namespace zombie_utility
// Params 4, eflags: 0x1 linked
// Checksum 0x40bf1520, Offset: 0x6cf8
// Size: 0x178
function function_62277a3f(dmg, delay, attacker, means_of_death) {
    self endon(#"death");
    self endon(#"exploding");
    if (!isalive(self)) {
        return;
    }
    if (!isplayer(attacker)) {
        attacker = self;
    }
    if (!isdefined(means_of_death)) {
        means_of_death = "MOD_UNKNOWN";
    }
    var_4194e098 = self.damagelocation;
    var_29d8f4bd = self.damageweapon;
    while (true) {
        if (isdefined(delay)) {
            wait delay;
        }
        if (isdefined(self)) {
            if (isdefined(self.no_gib) && self.no_gib) {
                return;
            }
            if (isdefined(attacker)) {
                self dodamage(dmg, self gettagorigin("j_neck"), attacker, self, var_4194e098, means_of_death, 0, var_29d8f4bd);
                continue;
            }
            self dodamage(dmg, self gettagorigin("j_neck"));
        }
    }
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xa0dfb7a2, Offset: 0x6e78
// Size: 0x360
function derive_damage_refs(point) {
    if (!isdefined(level.gib_tags)) {
        init_gib_tags();
    }
    closesttag = undefined;
    for (i = 0; i < level.gib_tags.size; i++) {
        if (!isdefined(closesttag)) {
            closesttag = level.gib_tags[i];
            continue;
        }
        if (distancesquared(point, self gettagorigin(level.gib_tags[i])) < distancesquared(point, self gettagorigin(closesttag))) {
            closesttag = level.gib_tags[i];
        }
    }
    if (closesttag == "J_SpineLower" || closesttag == "J_SpineUpper" || closesttag == "J_Spine4") {
        gibserverutils::gibrightarm(self);
        return;
    }
    if (closesttag == "J_Shoulder_LE" || closesttag == "J_Elbow_LE" || closesttag == "J_Wrist_LE") {
        if (!gibserverutils::isgibbed(self, 16)) {
            gibserverutils::gibleftarm(self);
        }
        return;
    }
    if (closesttag == "J_Shoulder_RI" || closesttag == "J_Elbow_RI" || closesttag == "J_Wrist_RI") {
        if (!gibserverutils::isgibbed(self, 32)) {
            gibserverutils::gibrightarm(self);
        }
        return;
    }
    if (closesttag == "J_Hip_LE" || closesttag == "J_Knee_LE" || closesttag == "J_Ankle_LE") {
        if (isdefined(self.nocrawler) && self.nocrawler) {
            return;
        }
        gibserverutils::gibleftleg(self);
        if (randomint(100) > 75) {
            gibserverutils::gibrightleg(self);
        }
        self.missinglegs = 1;
        return;
    }
    if (closesttag == "J_Hip_RI" || closesttag == "J_Knee_RI" || closesttag == "J_Ankle_RI") {
        if (isdefined(self.nocrawler) && self.nocrawler) {
            return;
        }
        gibserverutils::gibrightleg(self);
        if (randomint(100) > 75) {
            gibserverutils::gibleftleg(self);
        }
        self.missinglegs = 1;
    }
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x46a361c, Offset: 0x71e0
// Size: 0x14c
function init_gib_tags() {
    tags = [];
    tags[tags.size] = "J_SpineLower";
    tags[tags.size] = "J_SpineUpper";
    tags[tags.size] = "J_Spine4";
    tags[tags.size] = "J_Shoulder_LE";
    tags[tags.size] = "J_Elbow_LE";
    tags[tags.size] = "J_Wrist_LE";
    tags[tags.size] = "J_Shoulder_RI";
    tags[tags.size] = "J_Elbow_RI";
    tags[tags.size] = "J_Wrist_RI";
    tags[tags.size] = "J_Hip_LE";
    tags[tags.size] = "J_Knee_LE";
    tags[tags.size] = "J_Ankle_LE";
    tags[tags.size] = "J_Hip_RI";
    tags[tags.size] = "J_Knee_RI";
    tags[tags.size] = "J_Ankle_RI";
    level.gib_tags = tags;
}

// Namespace zombie_utility
// Params 1, eflags: 0x0
// Checksum 0xca700833, Offset: 0x7338
// Size: 0x92
function getanimdirection(damageyaw) {
    if (damageyaw > -121 || damageyaw <= -135) {
        return "front";
    } else if (damageyaw > 45 && damageyaw <= -121) {
        return "right";
    } else if (damageyaw > -45 && damageyaw <= 45) {
        return "back";
    } else {
        return "left";
    }
    return "front";
}

// Namespace zombie_utility
// Params 2, eflags: 0x1 linked
// Checksum 0xa954f8db, Offset: 0x73d8
// Size: 0x42
function function_65ee983f(dvar, def) {
    return int(function_98db2871(dvar, def));
}

// Namespace zombie_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x49f6246f, Offset: 0x7428
// Size: 0x72
function function_98db2871(dvar, def) {
    if (getdvarstring(dvar) != "") {
        return getdvarfloat(dvar);
    }
    setdvar(dvar, def);
    return def;
}

// Namespace zombie_utility
// Params 1, eflags: 0x1 linked
// Checksum 0xbf46bb28, Offset: 0x74a8
// Size: 0x16a
function makezombiecrawler(b_both_legs) {
    if (isdefined(b_both_legs) && b_both_legs) {
        val = 100;
    } else {
        val = randomint(100);
    }
    if (val > 75) {
        gibserverutils::gibrightleg(self);
        gibserverutils::gibleftleg(self);
    } else if (val > 37) {
        gibserverutils::gibrightleg(self);
    } else {
        gibserverutils::gibleftleg(self);
    }
    self.missinglegs = 1;
    self allowedstances("crouch");
    self setphysparams(15, 0, 24);
    self allowpitchangle(1);
    self setpitchorient();
    health = self.health;
    health *= 0.1;
}

// Namespace zombie_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x4700581b, Offset: 0x7620
// Size: 0xdc
function zombie_head_gib(attacker, means_of_death) {
    self endon(#"death");
    if (isdefined(self.head_gibbed) && self.head_gibbed) {
        return;
    }
    if (isdefined(self.no_gib) && self.no_gib) {
        return;
    }
    self.head_gibbed = 1;
    self zombie_eye_glow_stop();
    if (!(isdefined(self.disable_head_gib) && self.disable_head_gib)) {
        gibserverutils::gibhead(self);
    }
    self thread function_62277a3f(ceil(self.health * 0.2), 1, attacker, means_of_death);
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0xbe13ec82, Offset: 0x7708
// Size: 0x194
function gib_random_parts() {
    if (isdefined(self.no_gib) && self.no_gib) {
        return;
    }
    val = randomint(100);
    if (val > 50) {
        self zombie_head_gib();
    }
    val = randomint(100);
    if (val > 50) {
        gibserverutils::gibrightleg(self);
    }
    val = randomint(100);
    if (val > 50) {
        gibserverutils::gibleftleg(self);
    }
    val = randomint(100);
    if (val > 50) {
        if (!gibserverutils::isgibbed(self, 32)) {
            gibserverutils::gibrightarm(self);
        }
    }
    val = randomint(100);
    if (val > 50) {
        if (!gibserverutils::isgibbed(self, 16)) {
            gibserverutils::gibleftarm(self);
        }
    }
}

// Namespace zombie_utility
// Params 0, eflags: 0x2
// Checksum 0x415512d4, Offset: 0x78a8
// Size: 0x10
function autoexec init_ignore_player_handler() {
    level._ignore_player_handler = [];
}

// Namespace zombie_utility
// Params 2, eflags: 0x1 linked
// Checksum 0x8b94aae4, Offset: 0x78c0
// Size: 0x8e
function register_ignore_player_handler(archetype, ignore_player_func) {
    assert(isdefined(archetype), "<dev string:x2bf>");
    assert(!isdefined(level._ignore_player_handler[archetype]), "<dev string:x2e8>" + archetype + "<dev string:x301>");
    level._ignore_player_handler[archetype] = ignore_player_func;
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x9053eb8e, Offset: 0x7958
// Size: 0x36
function run_ignore_player_handler() {
    if (isdefined(level._ignore_player_handler[self.archetype])) {
        self [[ level._ignore_player_handler[self.archetype] ]]();
    }
}

// Namespace zombie_utility
// Params 0, eflags: 0x1 linked
// Checksum 0x2cbf5b55, Offset: 0x7998
// Size: 0x88
function show_hit_marker() {
    if (isdefined(self) && isdefined(self.hud_damagefeedback)) {
        self.hud_damagefeedback setshader("damage_feedback", 24, 48);
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
    }
}

