#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;

#namespace system;

// Namespace system
// Params 4, eflags: 0x1 linked
// Checksum 0x893f9999, Offset: 0xc8
// Size: 0x174
function register(var_f6d58016, func_preinit, func_postinit, reqs) {
    if (!isdefined(reqs)) {
        reqs = [];
    }
    if (isdefined(level.system_funcs) && isdefined(level.system_funcs[var_f6d58016])) {
        /#
            assertmsg("<unknown string>" + var_f6d58016 + "<unknown string>");
        #/
        return;
    }
    if (!isdefined(level.system_funcs)) {
        level.system_funcs = [];
    }
    level.system_funcs[var_f6d58016] = spawnstruct();
    level.system_funcs[var_f6d58016].prefunc = func_preinit;
    level.system_funcs[var_f6d58016].postfunc = func_postinit;
    level.system_funcs[var_f6d58016].reqs = reqs;
    level.system_funcs[var_f6d58016].predone = !isdefined(func_preinit);
    level.system_funcs[var_f6d58016].postdone = !isdefined(func_postinit);
    level.system_funcs[var_f6d58016].ignore = 0;
}

// Namespace system
// Params 1, eflags: 0x1 linked
// Checksum 0xbb29292a, Offset: 0x248
// Size: 0xbc
function exec_post_system(req) {
    /#
        if (!isdefined(level.system_funcs[req])) {
            /#
                assertmsg("<unknown string>" + req + "<unknown string>");
            #/
        }
    #/
    if (level.system_funcs[req].ignore) {
        return;
    }
    if (!level.system_funcs[req].postdone) {
        [[ level.system_funcs[req].postfunc ]]();
        level.system_funcs[req].postdone = 1;
    }
}

// Namespace system
// Params 0, eflags: 0x1 linked
// Checksum 0x9e903355, Offset: 0x310
// Size: 0x1ec
function run_post_systems() {
    foreach (key, func in level.system_funcs) {
        /#
            assert(func.predone || func.ignore, "<unknown string>");
        #/
        if (isarray(func.reqs)) {
            foreach (req in func.reqs) {
                thread exec_post_system(req);
            }
        } else {
            thread exec_post_system(func.reqs);
        }
        thread exec_post_system(key);
    }
    if (!level flag::exists("system_init_complete")) {
        level flag::init("system_init_complete", 0);
    }
    level flag::set("system_init_complete");
}

// Namespace system
// Params 1, eflags: 0x1 linked
// Checksum 0x22d22152, Offset: 0x508
// Size: 0xbc
function exec_pre_system(req) {
    /#
        if (!isdefined(level.system_funcs[req])) {
            /#
                assertmsg("<unknown string>" + req + "<unknown string>");
            #/
        }
    #/
    if (level.system_funcs[req].ignore) {
        return;
    }
    if (!level.system_funcs[req].predone) {
        [[ level.system_funcs[req].prefunc ]]();
        level.system_funcs[req].predone = 1;
    }
}

// Namespace system
// Params 0, eflags: 0x1 linked
// Checksum 0x46324f8d, Offset: 0x5d0
// Size: 0x15a
function run_pre_systems() {
    foreach (key, func in level.system_funcs) {
        if (isarray(func.reqs)) {
            foreach (req in func.reqs) {
                thread exec_pre_system(req);
            }
        } else {
            thread exec_pre_system(func.reqs);
        }
        thread exec_pre_system(key);
    }
}

// Namespace system
// Params 1, eflags: 0x1 linked
// Checksum 0x6dc19045, Offset: 0x738
// Size: 0x6c
function wait_till(required_systems) {
    if (!level flag::exists("system_init_complete")) {
        level flag::init("system_init_complete", 0);
    }
    level flag::wait_till("system_init_complete");
}

// Namespace system
// Params 1, eflags: 0x1 linked
// Checksum 0xb7ed0a78, Offset: 0x7b0
// Size: 0x90
function ignore(var_f6d58016) {
    /#
        assert(!isdefined(level.gametype), "<unknown string>");
    #/
    if (!isdefined(level.system_funcs) || !isdefined(level.system_funcs[var_f6d58016])) {
        register(var_f6d58016, undefined, undefined, undefined);
    }
    level.system_funcs[var_f6d58016].ignore = 1;
}

// Namespace system
// Params 1, eflags: 0x1 linked
// Checksum 0xe7eee5a6, Offset: 0x848
// Size: 0x4a
function function_85aec44f(var_f6d58016) {
    if (!isdefined(level.system_funcs) || !isdefined(level.system_funcs[var_f6d58016])) {
        return 0;
    }
    return level.system_funcs[var_f6d58016].postdone;
}

