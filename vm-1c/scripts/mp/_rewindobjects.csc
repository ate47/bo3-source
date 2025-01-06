#using scripts/codescripts/struct;
#using scripts/shared/system_shared;

#namespace rewindobjects;

// Namespace rewindobjects
// Params 0, eflags: 0x2
// Checksum 0x9dbd53af, Offset: 0xd8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("rewindobjects", &__init__, undefined, undefined);
}

// Namespace rewindobjects
// Params 0, eflags: 0x0
// Checksum 0xf8bb02a0, Offset: 0x118
// Size: 0x10
function __init__() {
    level.rewindwatcherarray = [];
}

// Namespace rewindobjects
// Params 1, eflags: 0x0
// Checksum 0x6e06d35b, Offset: 0x130
// Size: 0x64
function initrewindobjectwatchers(localclientnum) {
    level.rewindwatcherarray[localclientnum] = [];
    createnapalmrewindwatcher(localclientnum);
    createairstrikerewindwatcher(localclientnum);
    level thread watchrewindableevents(localclientnum);
}

// Namespace rewindobjects
// Params 1, eflags: 0x0
// Checksum 0xcd03537, Offset: 0x1a0
// Size: 0x194
function watchrewindableevents(localclientnum) {
    for (;;) {
        if (isdefined(level.rewindwatcherarray[localclientnum])) {
            rewindwatcherkeys = getarraykeys(level.rewindwatcherarray[localclientnum]);
            for (i = 0; i < rewindwatcherkeys.size; i++) {
                rewindwatcher = level.rewindwatcherarray[localclientnum][rewindwatcherkeys[i]];
                if (!isdefined(rewindwatcher)) {
                    continue;
                }
                if (!isdefined(rewindwatcher.event)) {
                    continue;
                }
                timekeys = getarraykeys(rewindwatcher.event);
                for (j = 0; j < timekeys.size; j++) {
                    timekey = timekeys[j];
                    if (rewindwatcher.event[timekey].inprogress == 1) {
                        continue;
                    }
                    if (level.servertime >= timekey) {
                        rewindwatcher thread startrewindableevent(localclientnum, timekey);
                    }
                }
            }
        }
        wait 0.1;
    }
}

// Namespace rewindobjects
// Params 2, eflags: 0x0
// Checksum 0x4336da3a, Offset: 0x340
// Size: 0x214
function startrewindableevent(localclientnum, timekey) {
    player = getlocalplayer(localclientnum);
    level endon("demo_jump" + localclientnum);
    self.event[timekey].inprogress = 1;
    allfunctionsstarted = 0;
    while (allfunctionsstarted == 0) {
        allfunctionsstarted = 1;
        assert(isdefined(self.timedfunctions));
        timedfunctionkeys = getarraykeys(self.timedfunctions);
        for (i = 0; i < timedfunctionkeys.size; i++) {
            timedfunction = self.timedfunctions[timedfunctionkeys[i]];
            timedfunctionkey = timedfunctionkeys[i];
            if (self.event[timekey].timedfunction[timedfunctionkey] == 1) {
                continue;
            }
            starttime = timekey + timedfunction.starttimesec * 1000;
            if (starttime > level.servertime) {
                allfunctionsstarted = 0;
                continue;
            }
            self.event[timekey].timedfunction[timedfunctionkey] = 1;
            level thread [[ timedfunction.func ]](localclientnum, starttime, timedfunction.starttimesec, self.event[timekey].data);
        }
        wait 0.1;
    }
}

// Namespace rewindobjects
// Params 1, eflags: 0x0
// Checksum 0xa346de96, Offset: 0x560
// Size: 0x48
function createnapalmrewindwatcher(localclientnum) {
    napalmrewindwatcher = createrewindwatcher(localclientnum, "napalm");
    timeincreasebetweenplanes = 0;
}

// Namespace rewindobjects
// Params 1, eflags: 0x0
// Checksum 0xe9e30a63, Offset: 0x5b0
// Size: 0x38
function createairstrikerewindwatcher(localclientnum) {
    airstrikerewindwatcher = createrewindwatcher(localclientnum, "airstrike");
}

// Namespace rewindobjects
// Params 2, eflags: 0x0
// Checksum 0x9f90fc4b, Offset: 0x5f0
// Size: 0x108
function createrewindwatcher(localclientnum, name) {
    player = getlocalplayer(localclientnum);
    if (!isdefined(level.rewindwatcherarray[localclientnum])) {
        level.rewindwatcherarray[localclientnum] = [];
    }
    rewindwatcher = getrewindwatcher(localclientnum, name);
    if (!isdefined(rewindwatcher)) {
        rewindwatcher = spawnstruct();
        level.rewindwatcherarray[localclientnum][level.rewindwatcherarray[localclientnum].size] = rewindwatcher;
    }
    rewindwatcher.name = name;
    rewindwatcher.event = [];
    rewindwatcher thread resetondemojump(localclientnum);
    return rewindwatcher;
}

// Namespace rewindobjects
// Params 1, eflags: 0x0
// Checksum 0x4bfee75f, Offset: 0x700
// Size: 0x18e
function resetondemojump(localclientnum) {
    for (;;) {
        level waittill("demo_jump" + localclientnum);
        self.inprogress = 0;
        timedfunctionkeys = getarraykeys(self.timedfunctions);
        for (i = 0; i < timedfunctionkeys.size; i++) {
            self.timedfunctions[timedfunctionkeys[i]].inprogress = 0;
        }
        eventkeys = getarraykeys(self.event);
        for (i = 0; i < eventkeys.size; i++) {
            self.event[eventkeys[i]].inprogress = 0;
            timedfunctionkeys = getarraykeys(self.event[eventkeys[i]].timedfunction);
            for (index = 0; index < timedfunctionkeys.size; index++) {
                self.event[eventkeys[i]].timedfunction[timedfunctionkeys[index]] = 0;
            }
        }
    }
}

// Namespace rewindobjects
// Params 3, eflags: 0x0
// Checksum 0x51522401, Offset: 0x898
// Size: 0xcc
function addtimedfunction(name, func, relativestarttimeinsecs) {
    if (!isdefined(self.timedfunctions)) {
        self.timedfunctions = [];
    }
    assert(!isdefined(self.timedfunctions[name]));
    self.timedfunctions[name] = spawnstruct();
    self.timedfunctions[name].inprogress = 0;
    self.timedfunctions[name].func = func;
    self.timedfunctions[name].starttimesec = relativestarttimeinsecs;
}

// Namespace rewindobjects
// Params 2, eflags: 0x0
// Checksum 0x4ac388ed, Offset: 0x970
// Size: 0x98
function getrewindwatcher(localclientnum, name) {
    if (!isdefined(level.rewindwatcherarray[localclientnum])) {
        return undefined;
    }
    for (watcher = 0; watcher < level.rewindwatcherarray[localclientnum].size; watcher++) {
        if (level.rewindwatcherarray[localclientnum][watcher].name == name) {
            return level.rewindwatcherarray[localclientnum][watcher];
        }
    }
    return undefined;
}

// Namespace rewindobjects
// Params 2, eflags: 0x0
// Checksum 0xc735396b, Offset: 0xa10
// Size: 0x138
function addrewindableeventtowatcher(starttime, data) {
    if (isdefined(self.event[starttime])) {
        return;
    }
    self.event[starttime] = spawnstruct();
    self.event[starttime].data = data;
    self.event[starttime].inprogress = 0;
    if (isdefined(self.timedfunctions)) {
        timedfunctionkeys = getarraykeys(self.timedfunctions);
        self.event[starttime].timedfunction = [];
        for (i = 0; i < timedfunctionkeys.size; i++) {
            timedfunctionkey = timedfunctionkeys[i];
            self.event[starttime].timedfunction[timedfunctionkey] = 0;
        }
    }
}

// Namespace rewindobjects
// Params 5, eflags: 0x0
// Checksum 0x97035843, Offset: 0xb50
// Size: 0x150
function servertimedmoveto(localclientnum, startpoint, endpoint, starttime, duration) {
    level endon("demo_jump" + localclientnum);
    timeelapsed = (level.servertime - starttime) * 0.001;
    assert(duration > 0);
    dojump = 1;
    if (timeelapsed < 0.02) {
        dojump = 0;
    }
    if (timeelapsed < duration) {
        movetime = duration - timeelapsed;
        if (dojump) {
            jumppoint = getpointonline(startpoint, endpoint, timeelapsed / duration);
            self.origin = jumppoint;
        }
        self moveto(endpoint, movetime, 0, 0);
        return 1;
    }
    self.origin = endpoint;
    return 0;
}

// Namespace rewindobjects
// Params 6, eflags: 0x0
// Checksum 0xcad3a78b, Offset: 0xca8
// Size: 0x110
function servertimedrotateto(localclientnum, angles, starttime, duration, timein, timeout) {
    level endon("demo_jump" + localclientnum);
    timeelapsed = (level.servertime - starttime) * 0.001;
    if (!isdefined(timein)) {
        timein = 0;
    }
    if (!isdefined(timeout)) {
        timeout = 0;
    }
    assert(duration > 0);
    if (timeelapsed < duration) {
        rotatetime = duration - timeelapsed;
        self rotateto(angles, rotatetime, timein, timeout);
        return 1;
    }
    self.angles = angles;
    return 0;
}

// Namespace rewindobjects
// Params 2, eflags: 0x0
// Checksum 0x191134, Offset: 0xdc0
// Size: 0x30
function waitforservertime(localclientnum, timefromstart) {
    while (timefromstart > level.servertime) {
        wait 0.016;
    }
}

// Namespace rewindobjects
// Params 2, eflags: 0x0
// Checksum 0x5bb8220b, Offset: 0xdf8
// Size: 0x74
function removecliententonjump(clientent, localclientnum) {
    clientent endon(#"complete");
    player = getlocalplayer(localclientnum);
    level waittill("demo_jump" + localclientnum);
    clientent notify(#"delete");
    clientent forcedelete();
}

// Namespace rewindobjects
// Params 3, eflags: 0x0
// Checksum 0x50a70514, Offset: 0xe78
// Size: 0xa2
function getpointonline(startpoint, endpoint, ratio) {
    nextpoint = (startpoint[0] + (endpoint[0] - startpoint[0]) * ratio, startpoint[1] + (endpoint[1] - startpoint[1]) * ratio, startpoint[2] + (endpoint[2] - startpoint[2]) * ratio);
    return nextpoint;
}

