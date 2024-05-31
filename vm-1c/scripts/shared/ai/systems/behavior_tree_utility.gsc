#namespace namespace_f55a5e73;

// Namespace namespace_f55a5e73
// Params 2, eflags: 0x1 linked
// namespace_f55a5e73<file_0>::function_2b3cf3b0
// Checksum 0x8007c77e, Offset: 0xc0
// Size: 0xb6
function function_2b3cf3b0(functionname, functionptr) {
    if (!isdefined(level._behaviortreescriptfunctions)) {
        level._behaviortreescriptfunctions = [];
    }
    functionname = tolower(functionname);
    assert(isdefined(functionname) && isdefined(functionptr), "<unknown string>");
    assert(!isdefined(level._behaviortreescriptfunctions[functionname]), "<unknown string>");
    level._behaviortreescriptfunctions[functionname] = functionptr;
}

// Namespace namespace_f55a5e73
// Params 4, eflags: 0x1 linked
// namespace_f55a5e73<file_0>::function_d3aec141
// Checksum 0x23618e0f, Offset: 0x180
// Size: 0x1f8
function function_d3aec141(actionname, startfuncptr, updatefuncptr, terminatefuncptr) {
    if (!isdefined(level._behaviortreeactions)) {
        level._behaviortreeactions = [];
    }
    actionname = tolower(actionname);
    assert(isstring(actionname), "<unknown string>");
    assert(!isdefined(level._behaviortreeactions[actionname]), "<unknown string>" + actionname + "<unknown string>");
    level._behaviortreeactions[actionname] = array();
    if (isdefined(startfuncptr)) {
        assert(isfunctionptr(startfuncptr), "<unknown string>");
        level._behaviortreeactions[actionname]["bhtn_action_start"] = startfuncptr;
    }
    if (isdefined(updatefuncptr)) {
        assert(isfunctionptr(updatefuncptr), "<unknown string>");
        level._behaviortreeactions[actionname]["bhtn_action_update"] = updatefuncptr;
    }
    if (isdefined(terminatefuncptr)) {
        assert(isfunctionptr(terminatefuncptr), "<unknown string>");
        level._behaviortreeactions[actionname]["bhtn_action_terminate"] = terminatefuncptr;
    }
}

#namespace behaviortreenetworkutility;

// Namespace behaviortreenetworkutility
// Params 2, eflags: 0x1 linked
// namespace_3aaf60e9<file_0>::function_19bd8d4f
// Checksum 0xd6399a01, Offset: 0x380
// Size: 0x2c
function registerbehaviortreescriptapi(functionname, functionptr) {
    namespace_f55a5e73::function_2b3cf3b0(functionname, functionptr);
}

// Namespace behaviortreenetworkutility
// Params 4, eflags: 0x1 linked
// namespace_3aaf60e9<file_0>::function_5bdc5952
// Checksum 0x1b4911c3, Offset: 0x3b8
// Size: 0x44
function registerbehaviortreeaction(actionname, startfuncptr, updatefuncptr, terminatefuncptr) {
    namespace_f55a5e73::function_d3aec141(actionname, startfuncptr, updatefuncptr, terminatefuncptr);
}

