#namespace behaviorstatemachine;

// Namespace behaviorstatemachine
// Params 2, eflags: 0x1 linked
// namespace_d12b5599<file_0>::function_6b3dd6d8
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

