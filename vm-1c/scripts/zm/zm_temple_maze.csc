#namespace zm_temple_maze;

// Namespace zm_temple_maze
// Params 2, eflags: 0x0
// Checksum 0x3d467a86, Offset: 0xd0
// Size: 0x8c
function function_469b0955(localclientnum, active) {
    if (!isdefined(self.wall)) {
        self function_ddb0591e(localclientnum);
    }
    wall = self.wall;
    if (isdefined(wall)) {
        wall thread function_a6fa0aec(localclientnum);
        wall thread function_58fef8b(active);
    }
}

// Namespace zm_temple_maze
// Params 1, eflags: 0x0
// Checksum 0xa8884e9f, Offset: 0x168
// Size: 0xd4
function function_a6fa0aec(localclientnum) {
    if (!isdefined(self.init) || !self.init) {
        self function_f4833e89(-128, 0.25, 1, 1, "evt_maze_wall_down", "evt_maze_wall_up");
        self.script_fxid = level._effect["maze_wall_impact"];
        self.var_f88b106c = level._effect["maze_wall_raise"];
        self.var_1cb182da = (0, 0, -60);
        self.var_2f5c5654 = (0, 0, 75);
        self.init = 1;
        self.client_num = localclientnum;
    }
}

// Namespace zm_temple_maze
// Params 6, eflags: 0x0
// Checksum 0xb9663d49, Offset: 0x248
// Size: 0xd8
function function_f4833e89(movedist, var_974df0d6, var_5d5a0d45, var_6f2700a9, var_28fb82fe, var_cdede517) {
    self.isactive = 0;
    self.activecount = 0;
    self.ismoving = 0;
    self.movedist = movedist;
    self.var_83e367a2 = self.origin[2] + movedist;
    self.var_974df0d6 = var_974df0d6;
    self.var_5d5a0d45 = var_5d5a0d45;
    self.pathblocker = 0;
    self.var_f5212328 = 0;
    self.var_28fb82fe = var_28fb82fe;
    self.var_cdede517 = var_cdede517;
    self.startangles = self.angles;
}

// Namespace zm_temple_maze
// Params 1, eflags: 0x0
// Checksum 0xe8b5da90, Offset: 0x328
// Size: 0x194
function function_58fef8b(active) {
    if (active && isdefined(self.var_28fb82fe)) {
    }
    if (!active && isdefined(self.var_cdede517)) {
    }
    goalpos = (self.origin[0], self.origin[1], self.var_83e367a2);
    if (!active) {
        goalpos = (goalpos[0], goalpos[1], goalpos[2] - self.movedist);
    }
    movetime = self.var_974df0d6;
    if (!active) {
        movetime = self.var_5d5a0d45;
    }
    if (self.ismoving) {
        currentz = self.origin[2];
        goalz = goalpos[2];
        ratio = abs(goalz - currentz) / abs(self.movedist);
        movetime *= ratio;
    }
    self notify(#"hash_1a01fee7");
    self.isactive = active;
    self thread function_9443921(goalpos, movetime);
}

// Namespace zm_temple_maze
// Params 1, eflags: 0x0
// Checksum 0xa11b60e2, Offset: 0x4c8
// Size: 0x144
function function_ddb0591e(localclientnum) {
    walls = getentarray(localclientnum, "maze_trap_wall", "targetname");
    bestwall = undefined;
    bestdist = undefined;
    for (i = 0; i < walls.size; i++) {
        wall = walls[i];
        if (isdefined(wall.assigned)) {
            continue;
        }
        dist = distancesquared(self.origin, wall.origin);
        if (!isdefined(bestdist) || dist < bestdist) {
            bestdist = dist;
            bestwall = wall;
        }
    }
    self.wall = bestwall;
    if (isdefined(self.wall)) {
        self.wall.assigned = 1;
    }
}

// Namespace zm_temple_maze
// Params 2, eflags: 0x0
// Checksum 0x785543ec, Offset: 0x618
// Size: 0xdc
function function_9443921(goal, time) {
    self endon(#"hash_1a01fee7");
    self.ismoving = 1;
    if (time == 0) {
        time = 0.01;
    }
    if (self.isactive === 0) {
        function_53f9ed11(self.var_f88b106c, self.var_2f5c5654);
    }
    self moveto(goal, time);
    self waittill(#"movedone");
    self.ismoving = 0;
    if (self.isactive === 1) {
        function_53f9ed11(self.script_fxid, self.var_1cb182da);
    }
}

// Namespace zm_temple_maze
// Params 2, eflags: 0x0
// Checksum 0xa5a6b046, Offset: 0x700
// Size: 0x94
function function_53f9ed11(fx_name, offset) {
    if (isdefined(fx_name)) {
        var_5b62b694 = anglestoforward(self.angles);
        org = self.origin;
        if (isdefined(offset)) {
            org += offset;
        }
        playfx(self.client_num, fx_name, org, var_5b62b694, (0, 0, 1));
    }
}

