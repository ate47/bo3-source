#namespace animationselectortable;

// Namespace animationselectortable
// Params 2, eflags: 0x1 linked
// namespace_226c2e96<file_0>::function_3188449c
// Checksum 0x9c7915c, Offset: 0x88
// Size: 0xa6
function registeranimationselectortableevaluator(functionname, functionptr) {
    if (!isdefined(level._astevaluatorscriptfunctions)) {
        level._astevaluatorscriptfunctions = [];
    }
    functionname = tolower(functionname);
    assert(isdefined(functionname) && isdefined(functionptr));
    assert(!isdefined(level._astevaluatorscriptfunctions[functionname]));
    level._astevaluatorscriptfunctions[functionname] = functionptr;
}

