#namespace blackboard;

// Namespace blackboard
// Params 0, eflags: 0x2
// Checksum 0xcad340b0, Offset: 0x80
// Size: 0x14
function autoexec main() {
    _initializeblackboard();
}

// Namespace blackboard
// Params 0, eflags: 0x5 linked
// Checksum 0xa675a2dd, Offset: 0xa0
// Size: 0x24
function private _initializeblackboard() {
    level.__ai_blackboard = [];
    level thread _updateevents();
}

// Namespace blackboard
// Params 0, eflags: 0x5 linked
// Checksum 0x710c6ddf, Offset: 0xd0
// Size: 0x18e
function private _updateevents() {
    waittime = 0.05;
    updatemillis = waittime * 1000;
    while (true) {
        foreach (eventname, events in level.__ai_blackboard) {
            liveevents = [];
            foreach (event in events) {
                event.ttl -= updatemillis;
                if (event.ttl > 0) {
                    liveevents[liveevents.size] = event;
                }
            }
            level.__ai_blackboard[eventname] = liveevents;
        }
        wait(waittime);
    }
}

// Namespace blackboard
// Params 3, eflags: 0x1 linked
// Checksum 0x48c9b02c, Offset: 0x268
// Size: 0x1a8
function addblackboardevent(eventname, data, timetoliveinmillis) {
    /#
        /#
            assert(isstring(eventname), "<unknown string>");
        #/
        /#
            assert(isdefined(data), "<unknown string>");
        #/
        /#
            assert(isint(timetoliveinmillis) && timetoliveinmillis > 0, "<unknown string>");
        #/
    #/
    event = spawnstruct();
    event.data = data;
    event.timestamp = gettime();
    event.ttl = timetoliveinmillis;
    if (!isdefined(level.__ai_blackboard[eventname])) {
        level.__ai_blackboard[eventname] = [];
    } else if (!isarray(level.__ai_blackboard[eventname])) {
        level.__ai_blackboard[eventname] = array(level.__ai_blackboard[eventname]);
    }
    level.__ai_blackboard[eventname][level.__ai_blackboard[eventname].size] = event;
}

// Namespace blackboard
// Params 1, eflags: 0x1 linked
// Checksum 0x17147a3f, Offset: 0x418
// Size: 0x30
function getblackboardevents(eventname) {
    if (isdefined(level.__ai_blackboard[eventname])) {
        return level.__ai_blackboard[eventname];
    }
    return [];
}

// Namespace blackboard
// Params 1, eflags: 0x0
// Checksum 0x52a2a4f5, Offset: 0x450
// Size: 0x2c
function removeblackboardevents(eventname) {
    if (isdefined(level.__ai_blackboard[eventname])) {
        level.__ai_blackboard[eventname] = undefined;
    }
}

