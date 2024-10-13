#using scripts/shared/ai/systems/blackboard;

#namespace animationstatenetwork;

// Namespace animationstatenetwork
// Params 0, eflags: 0x2
// Checksum 0xf8f80d1f, Offset: 0xc0
// Size: 0x10
function autoexec initnotetrackhandler() {
    level._notetrack_handler = [];
}

// Namespace animationstatenetwork
// Params 2, eflags: 0x5 linked
// Checksum 0x3dcf0a81, Offset: 0xd8
// Size: 0x8e
function private runnotetrackhandler(entity, notetracks) {
    assert(isarray(notetracks));
    for (index = 0; index < notetracks.size; index++) {
        handlenotetrack(entity, notetracks[index]);
    }
}

// Namespace animationstatenetwork
// Params 2, eflags: 0x5 linked
// Checksum 0x93449524, Offset: 0x170
// Size: 0x9c
function private handlenotetrack(entity, notetrack) {
    notetrackhandler = level._notetrack_handler[notetrack];
    if (!isdefined(notetrackhandler)) {
        return;
    }
    if (isfunctionptr(notetrackhandler)) {
        [[ notetrackhandler ]](entity);
        return;
    }
    blackboard::setblackboardattribute(entity, notetrackhandler.blackboardattributename, notetrackhandler.blackboardvalue);
}

// Namespace animationstatenetwork
// Params 2, eflags: 0x1 linked
// Checksum 0x2ffe03ed, Offset: 0x218
// Size: 0xd6
function registernotetrackhandlerfunction(notetrackname, notetrackfuncptr) {
    assert(isstring(notetrackname), "<dev string:x28>");
    assert(isfunctionptr(notetrackfuncptr), "<dev string:x61>");
    assert(!isdefined(level._notetrack_handler[notetrackname]), "<dev string:xa9>" + notetrackname + "<dev string:xcc>");
    level._notetrack_handler[notetrackname] = notetrackfuncptr;
}

// Namespace animationstatenetwork
// Params 3, eflags: 0x1 linked
// Checksum 0x7075b8b9, Offset: 0x2f8
// Size: 0x72
function registerblackboardnotetrackhandler(notetrackname, blackboardattributename, blackboardvalue) {
    notetrackhandler = spawnstruct();
    notetrackhandler.blackboardattributename = blackboardattributename;
    notetrackhandler.blackboardvalue = blackboardvalue;
    level._notetrack_handler[notetrackname] = notetrackhandler;
}

