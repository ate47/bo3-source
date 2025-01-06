#namespace namespace_f55a5e73;

// Namespace namespace_f55a5e73
// Params 2, eflags: 0x0
// Checksum 0x8007c77e, Offset: 0xc0
// Size: 0xb6
function function_2b3cf3b0(functionname, functionptr) {
    if (!isdefined(level._behaviortreescriptfunctions)) {
        level._behaviortreescriptfunctions = [];
    }
    functionname = tolower(functionname);
    assert(isdefined(functionname) && isdefined(functionptr), "<dev string:x28>");
    assert(!isdefined(level._behaviortreescriptfunctions[functionname]), "<dev string:x97>");
    level._behaviortreescriptfunctions[functionname] = functionptr;
}

// Namespace namespace_f55a5e73
// Params 4, eflags: 0x0
// Checksum 0x23618e0f, Offset: 0x180
// Size: 0x1f8
function function_d3aec141(actionname, startfuncptr, updatefuncptr, terminatefuncptr) {
    if (!isdefined(level._behaviortreeactions)) {
        level._behaviortreeactions = [];
    }
    actionname = tolower(actionname);
    assert(isstring(actionname), "<dev string:xf4>");
    assert(!isdefined(level._behaviortreeactions[actionname]), "<dev string:x13c>" + actionname + "<dev string:x172>");
    level._behaviortreeactions[actionname] = array();
    if (isdefined(startfuncptr)) {
        assert(isfunctionptr(startfuncptr), "<dev string:x18a>");
        level._behaviortreeactions[actionname]["bhtn_action_start"] = startfuncptr;
    }
    if (isdefined(updatefuncptr)) {
        assert(isfunctionptr(updatefuncptr), "<dev string:x1cc>");
        level._behaviortreeactions[actionname]["bhtn_action_update"] = updatefuncptr;
    }
    if (isdefined(terminatefuncptr)) {
        assert(isfunctionptr(terminatefuncptr), "<dev string:x20f>");
        level._behaviortreeactions[actionname]["bhtn_action_terminate"] = terminatefuncptr;
    }
}

#namespace behaviortreenetworkutility;

// Namespace behaviortreenetworkutility
// Params 2, eflags: 0x0
// Checksum 0xd6399a01, Offset: 0x380
// Size: 0x2c
function registerbehaviortreescriptapi(functionname, functionptr) {
    namespace_f55a5e73::function_2b3cf3b0(functionname, functionptr);
}

// Namespace behaviortreenetworkutility
// Params 4, eflags: 0x0
// Checksum 0x1b4911c3, Offset: 0x3b8
// Size: 0x44
function registerbehaviortreeaction(actionname, startfuncptr, updatefuncptr, terminatefuncptr) {
    namespace_f55a5e73::function_d3aec141(actionname, startfuncptr, updatefuncptr, terminatefuncptr);
}

