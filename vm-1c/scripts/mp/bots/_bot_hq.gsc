#using scripts/mp/bots/_bot;
#using scripts/mp/bots/_bot_combat;
#using scripts/shared/array_shared;
#using scripts/shared/util_shared;

#namespace namespace_c518e9ba;

// Namespace namespace_c518e9ba
// Params 0, eflags: 0x0
// Checksum 0xb2405ae5, Offset: 0x140
// Size: 0x1e4
function function_6338d695() {
    time = gettime();
    if (time < self.bot.update_objective) {
        return;
    }
    self.bot.update_objective = time + randomintrange(500, 1500);
    if (function_afb101b9()) {
        self function_8ea2b2db();
    } else if (!function_558eae7f()) {
        self function_9e76f68();
    }
    if (self function_8c51f0af()) {
        self function_68d2b4b9();
    }
    function_f9902ae2();
    function_911d1da3();
    if (!function_8c51f0af() && !self function_342a0c8f("hq_patrol")) {
        mine = getnearestnode(self.origin);
        point = function_96f25ae0();
        if (isdefined(mine) && bot::function_632d277c(mine.origin, point)) {
            self lookat(level.radio.baseorigin + (0, 0, 30));
        }
    }
}

// Namespace namespace_c518e9ba
// Params 0, eflags: 0x0
// Checksum 0x1f7b0318, Offset: 0x330
// Size: 0xe2
function function_558eae7f() {
    origin = self function_c5fa66a6("hq_radio");
    if (isdefined(origin)) {
        foreach (point in level.radio.points) {
            if (distancesquared(origin, point) < 4096) {
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_c518e9ba
// Params 0, eflags: 0x0
// Checksum 0x1f469e7e, Offset: 0x420
// Size: 0x22
function function_8c51f0af() {
    return self function_342a0c8f("hq_radio");
}

// Namespace namespace_c518e9ba
// Params 0, eflags: 0x0
// Checksum 0x36f66449, Offset: 0x450
// Size: 0x6e
function function_afb101b9() {
    if (level.radio.gameobject.ownerteam == "neutral") {
        return false;
    }
    if (level.radio.gameobject.ownerteam != self.team) {
        return false;
    }
    if (function_631de6e5()) {
        return false;
    }
    return true;
}

// Namespace namespace_c518e9ba
// Params 0, eflags: 0x0
// Checksum 0x738a72e7, Offset: 0x4c8
// Size: 0x638
function function_8ea2b2db() {
    self function_358b5b46("hq_radio");
    if (self function_342a0c8f("hq_patrol")) {
        node = getnearestnode(self.origin);
        if (isdefined(node) && node.type == "Path") {
            self setstance("crouch");
        } else {
            self setstance("stand");
        }
        if (gettime() > self.bot.var_5b09a4ff) {
            origin = self function_2a88093d();
            z = 20;
            if (distancesquared(origin, self.origin) > 262144) {
                z = randomintrange(16, 60);
            }
            self lookat(origin + (0, 0, z));
            if (distancesquared(origin, self.origin) > 65536) {
                dir = vectornormalize(self.origin - origin);
                dir = vectorscale(dir, 256);
                origin += dir;
            }
            self namespace_5cd60c9f::function_3898a2e(origin);
            self.bot.var_5b09a4ff = gettime() + randomintrange(1500, 3000);
        }
        goal = self function_c5fa66a6("hq_patrol");
        nearest = function_96f25ae0();
        mine = getnearestnode(goal);
        if (isdefined(mine) && !bot::function_632d277c(mine.origin, nearest)) {
            self function_63b5f862();
            self function_358b5b46("hq_patrol");
        }
        if (gettime() > self.bot.var_d652f333) {
            self function_63b5f862();
            self function_358b5b46("hq_patrol");
        }
        return;
    }
    nearest = function_96f25ae0();
    if (self hasgoal("hq_patrol")) {
        goal = self function_c5fa66a6("hq_patrol");
        if (distancesquared(self.origin, goal) < 65536) {
            origin = self function_2a88093d();
            self lookat(origin);
        }
        if (distancesquared(self.origin, goal) < 16384) {
            self.bot.var_d652f333 = gettime() + randomintrange(3000, 6000);
        }
        mine = getnearestnode(goal);
        if (isdefined(mine) && !bot::function_632d277c(mine.origin, nearest)) {
            self function_63b5f862();
            self function_358b5b46("hq_patrol");
        }
        return;
    }
    points = util::positionquery_pointarray(nearest, 0, 512, 70, 64);
    points = navpointsightfilter(points, nearest);
    assert(points.size);
    for (i = randomint(points.size); i < points.size; i++) {
        if (self bot::function_aa6ecc02("hq_radio", points[i], -128) == 0) {
            if (self bot::function_aa6ecc02("hq_patrol", points[i], 256) == 0) {
                self function_cef3c19f(points[i], 24, 3, "hq_patrol");
                return;
            }
        }
    }
}

// Namespace namespace_c518e9ba
// Params 0, eflags: 0x0
// Checksum 0x47c2e6cb, Offset: 0xb08
// Size: 0x214
function function_9e76f68() {
    self function_63b5f862();
    self function_358b5b46("hq_radio");
    self function_358b5b46("hq_patrol");
    if (self getstance() == "prone") {
        self setstance("crouch");
        wait 0.25;
    }
    if (self getstance() == "crouch") {
        self setstance("stand");
        wait 0.25;
    }
    points = array::randomize(level.radio.points);
    foreach (point in points) {
        if (self bot::function_aa6ecc02("hq_radio", point, 64) == 0) {
            self function_cef3c19f(point, 24, 3, "hq_radio");
            return;
        }
    }
    self function_cef3c19f(array::random(points), 24, 3, "hq_radio");
}

// Namespace namespace_c518e9ba
// Params 0, eflags: 0x0
// Checksum 0x33777d41, Offset: 0xd28
// Size: 0x232
function function_2a88093d() {
    enemy = self bot::function_838c3a3a(self.origin, 1);
    if (isdefined(enemy)) {
        node = getvisiblenode(self.origin, enemy.origin);
        if (isdefined(node) && distancesquared(self.origin, node.origin) > 16384) {
            return node.origin;
        }
    }
    enemies = self bot::function_22f478a2(0);
    if (enemies.size) {
        enemy = array::random(enemies);
    }
    if (isdefined(enemy)) {
        node = getvisiblenode(self.origin, enemy.origin);
        if (isdefined(node) && distancesquared(self.origin, node.origin) > 16384) {
            return node.origin;
        }
    }
    spawn = array::random(level.spawnpoints);
    node = getvisiblenode(self.origin, spawn.origin);
    if (isdefined(node) && distancesquared(self.origin, node.origin) > 16384) {
        return node.origin;
    }
    return level.radio.baseorigin;
}

// Namespace namespace_c518e9ba
// Params 0, eflags: 0x0
// Checksum 0xc77fad24, Offset: 0xf68
// Size: 0x1d4
function function_68d2b4b9() {
    self function_cef3c19f(self.origin, 24, 3, "hq_radio");
    self setstance("crouch");
    if (gettime() > self.bot.var_5b09a4ff) {
        origin = self function_2a88093d();
        z = 20;
        if (distancesquared(origin, self.origin) > 262144) {
            z = randomintrange(16, 60);
        }
        self lookat(origin + (0, 0, z));
        if (distancesquared(origin, self.origin) > 65536) {
            dir = vectornormalize(self.origin - origin);
            dir = vectorscale(dir, 256);
            origin += dir;
        }
        self namespace_5cd60c9f::function_3898a2e(origin);
        self.bot.var_5b09a4ff = gettime() + randomintrange(1500, 3000);
    }
}

// Namespace namespace_c518e9ba
// Params 1, eflags: 0x0
// Checksum 0xe0e45d34, Offset: 0x1148
// Size: 0xb6
function function_b2cff0ba(skip_team) {
    foreach (team in level.teams) {
        if (team == skip_team) {
            continue;
        }
        if (level.radio.gameobject.numtouching[team]) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_c518e9ba
// Params 1, eflags: 0x0
// Checksum 0x1546a980, Offset: 0x1208
// Size: 0xa8
function function_72f09e03(skip_team) {
    if (function_b2cff0ba(skip_team)) {
        return true;
    }
    enemy = self bot::function_838c3a3a(level.radio.baseorigin, 1);
    if (isdefined(enemy) && distancesquared(enemy.origin, level.radio.baseorigin) < 262144) {
        return true;
    }
    return false;
}

// Namespace namespace_c518e9ba
// Params 0, eflags: 0x0
// Checksum 0x7389c65c, Offset: 0x12b8
// Size: 0x214
function function_911d1da3() {
    enemies = bot::function_22f478a2();
    if (!enemies.size) {
        return;
    }
    if (self function_342a0c8f("hq_patrol") || self function_342a0c8f("hq_radio")) {
        if (self getweaponammostock(getweapon("proximity_grenade")) > 0) {
            origin = function_2a88093d();
            if (self namespace_5cd60c9f::function_3898a2e(origin)) {
                return;
            }
        }
    }
    if (!function_72f09e03(self.team)) {
        self namespace_5cd60c9f::function_5b3d70aa(level.radio.baseorigin);
        return;
    }
    enemy = self bot::function_838c3a3a(level.radio.baseorigin, 0);
    if (isdefined(enemy)) {
        origin = enemy.origin;
    } else {
        origin = level.radio.baseorigin;
    }
    dir = vectornormalize(self.origin - origin);
    dir = (0, dir[1], 0);
    origin += vectorscale(dir, -128);
    if (!self namespace_5cd60c9f::function_bcc19909(origin)) {
        self namespace_5cd60c9f::function_2bbe6c14(origin);
    }
}

// Namespace namespace_c518e9ba
// Params 0, eflags: 0x0
// Checksum 0x686161e, Offset: 0x14d8
// Size: 0x184
function function_f9902ae2() {
    if (!self hasweapon(getweapon("tactical_insertion"))) {
        return;
    }
    dist = self function_4705a395();
    dir = self getlookaheaddir();
    if (!isdefined(dist) || !isdefined(dir)) {
        return;
    }
    point = function_96f25ae0();
    mine = getnearestnode(self.origin);
    if (isdefined(mine) && !bot::function_632d277c(mine.origin, point)) {
        origin = self.origin + vectorscale(dir, dist);
        next = getnearestnode(origin);
        if (isdefined(next) && bot::function_632d277c(next.origin, point)) {
            namespace_5cd60c9f::function_f7a55431(self.origin);
        }
    }
}

// Namespace namespace_c518e9ba
// Params 0, eflags: 0x0
// Checksum 0xe24f241, Offset: 0x1668
// Size: 0x22
function function_96f25ae0() {
    return array::random(level.radio.points);
}

// Namespace namespace_c518e9ba
// Params 0, eflags: 0x0
// Checksum 0xa3c46d17, Offset: 0x1698
// Size: 0x8e
function function_631de6e5() {
    enemy = self bot::function_838c3a3a(level.radio.baseorigin, 0);
    return isdefined(enemy) && distancesquared(enemy.origin, level.radio.baseorigin) < level.radio.node_radius * level.radio.node_radius;
}

