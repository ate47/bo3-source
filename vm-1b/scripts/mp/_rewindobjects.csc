#using scripts/codescripts/struct;
#using scripts/shared/system_shared;

#namespace rewindobjects;

// Namespace rewindobjects
// Params 0, eflags: 0x2
// Checksum 0xd8435434, Offset: 0xd8
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("rewindobjects", &__init__, undefined, undefined);
}

// Namespace rewindobjects
// Params 0, eflags: 0x0
// Checksum 0xeb74a63c, Offset: 0x110
// Size: 0xa
function __init__() {
    level.rewindwatcherarray = [];
}

// Namespace rewindobjects
// Params 1, eflags: 0x0
// Checksum 0xe0c63b17, Offset: 0x128
// Size: 0x4a
function initrewindobjectwatchers(localclientnum) {
    level.rewindwatcherarray[localclientnum] = [];
    createnapalmrewindwatcher(localclientnum);
    createairstrikerewindwatcher(localclientnum);
    level thread watchrewindableevents(localclientnum);
}

// Namespace rewindobjects
// Params 1, eflags: 0x0
// Checksum 0x3d113740, Offset: 0x180
// Size: 0x129
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
// Checksum 0x66ae930e, Offset: 0x2b8
// Size: 0x17d
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
// Checksum 0x28c74bbb, Offset: 0x440
// Size: 0x38
function createnapalmrewindwatcher(localclientnum) {
    napalmrewindwatcher = createrewindwatcher(localclientnum, "napalm");
    timeincreasebetweenplanes = 0;
}

// Namespace rewindobjects
// Params 1, eflags: 0x0
// Checksum 0x2fc935c0, Offset: 0x480
// Size: 0x2c
function createairstrikerewindwatcher(localclientnum) {
    airstrikerewindwatcher = createrewindwatcher(localclientnum, "airstrike");
}

// Namespace rewindobjects
// Params 2, eflags: 0x0
// Checksum 0x5ef1f1bd, Offset: 0x4b8
// Size: 0xc4
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
// Checksum 0x9eb91c86, Offset: 0x588
// Size: 0x113
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
// Checksum 0x9da60fe1, Offset: 0x6a8
// Size: 0x9e
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
// Checksum 0x2d37286e, Offset: 0x750
// Size: 0x6c
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
// Checksum 0xc85d045f, Offset: 0x7c8
// Size: 0xdd
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
// Checksum 0xa06c0409, Offset: 0x8b0
// Size: 0xfc
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
// Checksum 0x21faf261, Offset: 0x9b8
// Size: 0xc4
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
// Checksum 0x8ad84be9, Offset: 0xa88
// Size: 0x29
function waitforservertime(localclientnum, timefromstart) {
    while (timefromstart > level.servertime) {
        wait 0.016;
    }
}

// Namespace rewindobjects
// Params 2, eflags: 0x0
// Checksum 0x116b62ff, Offset: 0xac0
// Size: 0x5a
function removecliententonjump(clientent, localclientnum) {
    clientent endon(#"complete");
    player = getlocalplayer(localclientnum);
    level waittill("demo_jump" + localclientnum);
    clientent notify(#"delete");
    clientent forcedelete();
}

// Namespace rewindobjects
// Params 3, eflags: 0x0
// Checksum 0xf35f0d79, Offset: 0xb28
// Size: 0x61
function getpointonline(startpoint, endpoint, ratio) {
    nextpoint = (startpoint[0] + (endpoint[0] - startpoint[0]) * ratio, startpoint[1] + (endpoint[1] - startpoint[1]) * ratio, startpoint[2] + (endpoint[2] - startpoint[2]) * ratio);
    return nextpoint;
}

