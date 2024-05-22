#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace objpoints;

// Namespace objpoints
// Params 0, eflags: 0x2
// Checksum 0xd15e79da, Offset: 0xf8
// Size: 0x34
function function_2dc19561() {
    system::register("objpoints", &__init__, undefined, undefined);
}

// Namespace objpoints
// Params 0, eflags: 0x1 linked
// Checksum 0x7831ea7c, Offset: 0x138
// Size: 0x70
function __init__() {
    level.objpointnames = [];
    level.objpoints = [];
    if (isdefined(level.splitscreen) && level.splitscreen) {
        level.objpointsize = 15;
    } else {
        level.objpointsize = 8;
    }
    level.objpoint_alpha_default = 1;
    level.objpointscale = 1;
}

// Namespace objpoints
// Params 6, eflags: 0x1 linked
// Checksum 0x2fe5353d, Offset: 0x1b0
// Size: 0x2ba
function create(name, origin, team, shader, alpha, scale) {
    /#
        assert(isdefined(level.teams[team]) || team == "<unknown string>");
    #/
    objpoint = function_c120f6a5(name);
    if (isdefined(objpoint)) {
        delete(objpoint);
    }
    if (!isdefined(shader)) {
        shader = "objpoint_default";
    }
    if (!isdefined(scale)) {
        scale = 1;
    }
    if (team != "all") {
        objpoint = newteamhudelem(team);
    } else {
        objpoint = newhudelem();
    }
    objpoint.name = name;
    objpoint.x = origin[0];
    objpoint.y = origin[1];
    objpoint.z = origin[2];
    objpoint.team = team;
    objpoint.isflashing = 0;
    objpoint.isshown = 1;
    objpoint.fadewhentargeted = 1;
    objpoint.archived = 0;
    objpoint setshader(shader, level.objpointsize, level.objpointsize);
    objpoint setwaypoint(1);
    if (isdefined(alpha)) {
        objpoint.alpha = alpha;
    } else {
        objpoint.alpha = level.objpoint_alpha_default;
    }
    objpoint.basealpha = objpoint.alpha;
    objpoint.index = level.objpointnames.size;
    level.objpoints[name] = objpoint;
    level.objpointnames[level.objpointnames.size] = name;
    return objpoint;
}

// Namespace objpoints
// Params 1, eflags: 0x1 linked
// Checksum 0xb116f0ad, Offset: 0x478
// Size: 0x1a4
function delete(var_68ec4683) {
    /#
        assert(level.objpoints.size == level.objpointnames.size);
    #/
    if (level.objpoints.size == 1) {
        /#
            assert(level.objpointnames[0] == var_68ec4683.name);
        #/
        /#
            assert(isdefined(level.objpoints[var_68ec4683.name]));
        #/
        level.objpoints = [];
        level.objpointnames = [];
        var_68ec4683 destroy();
        return;
    }
    newindex = var_68ec4683.index;
    oldindex = level.objpointnames.size - 1;
    objpoint = function_3ec05698(oldindex);
    level.objpointnames[newindex] = objpoint.name;
    objpoint.index = newindex;
    level.objpointnames[oldindex] = undefined;
    level.objpoints[var_68ec4683.name] = undefined;
    var_68ec4683 destroy();
}

// Namespace objpoints
// Params 1, eflags: 0x1 linked
// Checksum 0x6ee1ae52, Offset: 0x628
// Size: 0x80
function function_88e59487(origin) {
    if (self.x != origin[0]) {
        self.x = origin[0];
    }
    if (self.y != origin[1]) {
        self.y = origin[1];
    }
    if (self.z != origin[2]) {
        self.z = origin[2];
    }
}

// Namespace objpoints
// Params 2, eflags: 0x0
// Checksum 0x44dd6a72, Offset: 0x6b0
// Size: 0x54
function function_a93964e(name, origin) {
    objpoint = function_c120f6a5(name);
    objpoint function_88e59487(origin);
}

// Namespace objpoints
// Params 1, eflags: 0x1 linked
// Checksum 0x67d97810, Offset: 0x710
// Size: 0x36
function function_c120f6a5(name) {
    if (isdefined(level.objpoints[name])) {
        return level.objpoints[name];
    }
    return undefined;
}

// Namespace objpoints
// Params 1, eflags: 0x1 linked
// Checksum 0xf9c082c5, Offset: 0x750
// Size: 0x3e
function function_3ec05698(index) {
    if (isdefined(level.objpointnames[index])) {
        return level.objpoints[level.objpointnames[index]];
    }
    return undefined;
}

// Namespace objpoints
// Params 0, eflags: 0x0
// Checksum 0x8a0fe3d7, Offset: 0x798
// Size: 0xb8
function function_3ae8114() {
    self endon(#"hash_dfc1d0c1");
    if (self.isflashing) {
        return;
    }
    self.isflashing = 1;
    while (self.isflashing) {
        self fadeovertime(0.75);
        self.alpha = 0.35 * self.basealpha;
        wait(0.75);
        self fadeovertime(0.75);
        self.alpha = self.basealpha;
        wait(0.75);
    }
    self.alpha = self.basealpha;
}

// Namespace objpoints
// Params 0, eflags: 0x1 linked
// Checksum 0xff3d7255, Offset: 0x858
// Size: 0x1c
function function_a51dc9ba() {
    if (!self.isflashing) {
        return;
    }
    self.isflashing = 0;
}

