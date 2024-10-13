#namespace namespace_ad26c9c;

// Namespace namespace_ad26c9c
// Params 1, eflags: 0x0
// Checksum 0x5ccfd285, Offset: 0xa8
// Size: 0x14c
function function_105453ff(tank) {
    nodes = getnodesinradiussorted(tank.origin, 256, 0, 64, "Path");
    foreach (node in nodes) {
        dir = vectornormalize(node.origin - tank.origin);
        dir = vectorscale(dir, 32);
        goal = tank.origin + dir;
        if (self findpath(self.origin, goal, 0)) {
            return goal;
        }
    }
    return undefined;
}

// Namespace namespace_ad26c9c
// Params 1, eflags: 0x0
// Checksum 0x809c8489, Offset: 0x200
// Size: 0x74
function function_4a520873(tank) {
    goal = self function_c5fa66a6("hack");
    if (isdefined(goal)) {
        if (distancesquared(goal, tank.origin) < 16384) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_ad26c9c
// Params 0, eflags: 0x0
// Checksum 0xa8f4a3b2, Offset: 0x280
// Size: 0x18c
function function_4ace4348() {
    if (self function_342a0c8f("hack")) {
        return true;
    }
    goal = self function_c5fa66a6("hack");
    if (isdefined(goal)) {
        tanks = getentarray("talon", "targetname");
        tanks = arraysort(tanks, self.origin);
        foreach (tank in tanks) {
            if (distancesquared(goal, tank.origin) < 16384) {
                if (isdefined(tank.trigger) && self istouching(tank.trigger)) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace namespace_ad26c9c
// Params 1, eflags: 0x0
// Checksum 0x415abcf7, Offset: 0x418
// Size: 0x134
function function_e34eb514(tanks) {
    foreach (tank in tanks) {
        if (isdefined(tank.owner)) {
            continue;
        }
        if (isdefined(tank.team) && tank.team == self.team) {
            continue;
        }
        goal = self function_105453ff(tank);
        if (isdefined(goal)) {
            if (self function_cef3c19f(goal, 24, 2, "hack")) {
                self.var_e1ea3d0d = tank;
                return;
            }
        }
    }
}

// Namespace namespace_ad26c9c
// Params 0, eflags: 0x0
// Checksum 0x2c18baf5, Offset: 0x558
// Size: 0x45c
function function_a550d9c3() {
    if (function_4ace4348()) {
        self setstance("crouch");
        wait 0.25;
        self function_cef3c19f(self.origin, 24, 4, "hack");
        self function_5b8cb97f(level.var_2e7f813d + 1);
        wait level.var_2e7f813d + 1;
        self setstance("stand");
        self function_358b5b46("hack");
    }
    tanks = getentarray("talon", "targetname");
    tanks = arraysort(tanks, self.origin);
    if (!(isdefined(level.var_5ab6b053) && level.var_5ab6b053)) {
        self function_e34eb514(tanks);
        return;
    }
    foreach (tank in tanks) {
        if (isdefined(tank.owner) && tank.owner == self) {
            continue;
        }
        if (!isdefined(tank.owner)) {
            if (self function_4a520873(tank)) {
                return;
            }
            goal = self function_105453ff(tank);
            if (isdefined(goal)) {
                self function_cef3c19f(goal, 24, 2, "hack");
                return;
            }
        }
        if (tank.isstunned && distancesquared(self.origin, tank.origin) < 262144) {
            goal = self function_105453ff(tank);
            if (isdefined(goal)) {
                self function_cef3c19f(goal, 24, 3, "hack");
                return;
            }
        }
    }
    foreach (tank in tanks) {
        if (isdefined(tank.owner) && tank.owner == self) {
            continue;
        }
        if (tank.isstunned) {
            continue;
        }
        if (self throwgrenade(getweapon("emp_grenade"), tank.origin)) {
            self waittill(#"grenade_fire");
            goal = self function_105453ff(tank);
            if (isdefined(goal)) {
                self function_cef3c19f(goal, 24, 3, "hack");
                wait 0.5;
                return;
            }
        }
    }
}

