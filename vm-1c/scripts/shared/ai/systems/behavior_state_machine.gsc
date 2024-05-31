#namespace behaviorstatemachine;

// Namespace behaviorstatemachine
// Params 2, eflags: 0x1 linked
// Checksum 0x2b8aa8f7, Offset: 0x88
// Size: 0xb6
function registerbsmscriptapiinternal(functionname, scriptfunction) {
    if (!isdefined(level._bsmscriptfunctions)) {
        level._bsmscriptfunctions = [];
    }
    functionname = tolower(functionname);
    assert(isdefined(scriptfunction) && isdefined(scriptfunction), "<unknown string>");
    assert(!isdefined(level._bsmscriptfunctions[functionname]), "<unknown string>");
    level._bsmscriptfunctions[functionname] = scriptfunction;
}

