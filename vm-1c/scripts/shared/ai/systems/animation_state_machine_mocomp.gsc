#namespace animationstatenetwork;

// Namespace animationstatenetwork
// Params 0, eflags: 0x2
// Checksum 0x7dc7c359, Offset: 0xc8
// Size: 0x10
function autoexec initanimationmocomps() {
    level._animationmocomps = [];
}

// Namespace animationstatenetwork
// Params 6, eflags: 0x1 linked
// Checksum 0xb8f8acde, Offset: 0xe0
// Size: 0x13c
function runanimationmocomp(mocompname, var_cc9d849e, var_5a40c933, mocompanim, mocompanimblendouttime, mocompduration) {
    assert(var_cc9d849e >= 0 && var_cc9d849e <= 2, "<dev string:x28>" + var_cc9d849e + "<dev string:x48>");
    assert(isdefined(level._animationmocomps[mocompname]), "<dev string:x61>" + mocompname + "<dev string:x85>");
    if (var_cc9d849e == 0) {
        var_cc9d849e = "asm_mocomp_start";
    } else if (var_cc9d849e == 1) {
        var_cc9d849e = "asm_mocomp_update";
    } else {
        var_cc9d849e = "asm_mocomp_terminate";
    }
    animationmocompresult = var_5a40c933 [[ level._animationmocomps[mocompname][var_cc9d849e] ]](var_5a40c933, mocompanim, mocompanimblendouttime, "", mocompduration);
    return animationmocompresult;
}

// Namespace animationstatenetwork
// Params 4, eflags: 0x1 linked
// Checksum 0x789731e0, Offset: 0x228
// Size: 0x234
function registeranimationmocomp(mocompname, startfuncptr, updatefuncptr, terminatefuncptr) {
    mocompname = tolower(mocompname);
    assert(isstring(mocompname), "<dev string:x97>");
    assert(!isdefined(level._animationmocomps[mocompname]), "<dev string:xd6>" + mocompname + "<dev string:xe8>");
    level._animationmocomps[mocompname] = array();
    assert(isdefined(startfuncptr) && isfunctionptr(startfuncptr), "<dev string:x100>");
    level._animationmocomps[mocompname]["asm_mocomp_start"] = startfuncptr;
    if (isdefined(updatefuncptr)) {
        assert(isfunctionptr(updatefuncptr), "<dev string:x15d>");
        level._animationmocomps[mocompname]["asm_mocomp_update"] = updatefuncptr;
    } else {
        level._animationmocomps[mocompname]["asm_mocomp_update"] = &animationmocompemptyfunc;
    }
    if (isdefined(terminatefuncptr)) {
        assert(isfunctionptr(terminatefuncptr), "<dev string:x1b7>");
        level._animationmocomps[mocompname]["asm_mocomp_terminate"] = terminatefuncptr;
        return;
    }
    level._animationmocomps[mocompname]["asm_mocomp_terminate"] = &animationmocompemptyfunc;
}

// Namespace animationstatenetwork
// Params 5, eflags: 0x1 linked
// Checksum 0x2cf62241, Offset: 0x468
// Size: 0x2c
function animationmocompemptyfunc(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    
}

