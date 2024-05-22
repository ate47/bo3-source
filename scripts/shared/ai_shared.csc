#namespace ai_shared;

// Namespace ai_shared
// Params 0, eflags: 0x2
// Checksum 0x92d15211, Offset: 0x78
// Size: 0x1c
function main() {
    level._customactorcbfunc = &ai::spawned_callback;
}

#namespace ai;

// Namespace ai
// Params 1, eflags: 0x1 linked
// Checksum 0x1ab047e0, Offset: 0xa0
// Size: 0x5e
function add_ai_spawn_function(spawn_func) {
    if (!isdefined(level.var_ba02f75c)) {
        level.var_ba02f75c = [];
    }
    func = [];
    func["function"] = spawn_func;
    level.var_ba02f75c[level.var_ba02f75c.size] = func;
}

// Namespace ai
// Params 2, eflags: 0x1 linked
// Checksum 0x5c316da5, Offset: 0x108
// Size: 0x110
function add_archetype_spawn_function(archetype, spawn_func) {
    if (!isdefined(level.spawn_funcs)) {
        level.spawn_funcs = [];
    }
    if (!isdefined(level.spawn_funcs[archetype])) {
        level.spawn_funcs[archetype] = [];
    }
    func = [];
    func["function"] = spawn_func;
    if (!isdefined(level.spawn_funcs[archetype])) {
        level.spawn_funcs[archetype] = [];
    } else if (!isarray(level.spawn_funcs[archetype])) {
        level.spawn_funcs[archetype] = array(level.spawn_funcs[archetype]);
    }
    level.spawn_funcs[archetype][level.spawn_funcs[archetype].size] = func;
}

// Namespace ai
// Params 1, eflags: 0x1 linked
// Checksum 0xea9c8723, Offset: 0x220
// Size: 0x104
function spawned_callback(localclientnum) {
    if (isdefined(level.var_ba02f75c)) {
        for (index = 0; index < level.var_ba02f75c.size; index++) {
            func = level.var_ba02f75c[index];
            self thread [[ func["function"] ]](localclientnum);
        }
    }
    if (isdefined(level.spawn_funcs) && isdefined(level.spawn_funcs[self.archetype])) {
        for (index = 0; index < level.spawn_funcs[self.archetype].size; index++) {
            func = level.spawn_funcs[self.archetype][index];
            self thread [[ func["function"] ]](localclientnum);
        }
    }
}

// Namespace ai
// Params 1, eflags: 0x1 linked
// Checksum 0xa940b9ed, Offset: 0x330
// Size: 0x48
function shouldregisterclientfieldforarchetype(archetype) {
    if (isdefined(level.clientfieldaicheck) && level.clientfieldaicheck && !isarchetypeloaded(archetype)) {
        return false;
    }
    return true;
}

