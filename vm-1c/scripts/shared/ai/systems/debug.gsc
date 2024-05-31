#using scripts/shared/ai/archetype_utility;
#using scripts/shared/system_shared;

#namespace as_debug;

/#

    // Namespace as_debug
    // Params 0, eflags: 0x2
    // Checksum 0x59872824, Offset: 0xc0
    // Size: 0x34
    function autoexec function_2dc19561() {
        system::register("<unknown string>", &__init__, undefined, undefined);
    }

    // Namespace as_debug
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc334b472, Offset: 0x100
    // Size: 0x1c
    function __init__() {
        level thread debugdvars();
    }

    // Namespace as_debug
    // Params 0, eflags: 0x1 linked
    // Checksum 0x8ed8704a, Offset: 0x128
    // Size: 0x50
    function debugdvars() {
        while (true) {
            if (getdvarint("<unknown string>", 0)) {
                delete_all_ai_corpses();
            }
            wait(0.05);
        }
    }

    // Namespace as_debug
    // Params 0, eflags: 0x1 linked
    // Checksum 0x24117f0f, Offset: 0x180
    // Size: 0x4c
    function isdebugon() {
        return isdefined(anim.debugent) && (getdvarint("<unknown string>") == 1 || anim.debugent == self);
    }

    // Namespace as_debug
    // Params 4, eflags: 0x1 linked
    // Checksum 0xdccef656, Offset: 0x1d8
    // Size: 0x76
    function drawdebuglineinternal(frompoint, topoint, color, durationframes) {
                for (i = 0; i < durationframes; i++) {
            line(frompoint, topoint, color);
            wait(0.05);
        }
    }

    // Namespace as_debug
    // Params 4, eflags: 0x0
    // Checksum 0x1d597f48, Offset: 0x258
    // Size: 0x64
    function drawdebugline(frompoint, topoint, color, durationframes) {
        if (isdebugon()) {
            thread drawdebuglineinternal(frompoint, topoint, color, durationframes);
        }
    }

    // Namespace as_debug
    // Params 4, eflags: 0x1 linked
    // Checksum 0x5d0ba0d, Offset: 0x2c8
    // Size: 0x7e
    function debugline(frompoint, topoint, color, durationframes) {
                for (i = 0; i < durationframes * 20; i++) {
            line(frompoint, topoint, color);
            wait(0.05);
        }
    }

    // Namespace as_debug
    // Params 4, eflags: 0x0
    // Checksum 0x37cf8633, Offset: 0x350
    // Size: 0x154
    function drawdebugcross(atpoint, radius, color, durationframes) {
        atpoint_high = atpoint + (0, 0, radius);
        atpoint_low = atpoint + (0, 0, -1 * radius);
        atpoint_left = atpoint + (0, radius, 0);
        atpoint_right = atpoint + (0, -1 * radius, 0);
        atpoint_forward = atpoint + (radius, 0, 0);
        atpoint_back = atpoint + (-1 * radius, 0, 0);
        thread debugline(atpoint_high, atpoint_low, color, durationframes);
        thread debugline(atpoint_left, atpoint_right, color, durationframes);
        thread debugline(atpoint_forward, atpoint_back, color, durationframes);
    }

    // Namespace as_debug
    // Params 0, eflags: 0x0
    // Checksum 0x3c9f817f, Offset: 0x4b0
    // Size: 0x98
    function updatedebuginfo() {
        self endon(#"death");
        self.debuginfo = spawnstruct();
        self.debuginfo.enabled = getdvarint("<unknown string>") > 0;
        debugclearstate();
        while (true) {
            wait(0.05);
            updatedebuginfointernal();
            wait(0.05);
        }
    }

    // Namespace as_debug
    // Params 0, eflags: 0x1 linked
    // Checksum 0x32300c78, Offset: 0x550
    // Size: 0x104
    function updatedebuginfointernal() {
        if (isdefined(anim.debugent) && anim.debugent == self) {
            doinfo = 1;
            return;
        }
        doinfo = getdvarint("<unknown string>") > 0;
        if (doinfo) {
            ai_entnum = getdvarint("<unknown string>");
            if (ai_entnum > -1 && ai_entnum != self getentitynumber()) {
                doinfo = 0;
            }
        }
        if (!self.debuginfo.enabled && doinfo) {
            self.debuginfo.shouldclearonanimscriptchange = 1;
        }
        self.debuginfo.enabled = doinfo;
    }

    // Namespace as_debug
    // Params 4, eflags: 0x0
    // Checksum 0x5be148d, Offset: 0x660
    // Size: 0x144
    function drawdebugenttext(text, ent, color, channel) {
        assert(isdefined(ent));
        if (!getdvarint("<unknown string>")) {
            if (!isdefined(ent.debuganimscripttime) || gettime() > ent.debuganimscripttime) {
                ent.debuganimscriptlevel = 0;
                ent.debuganimscripttime = gettime();
            }
            indentlevel = vectorscale((0, 0, -10), ent.debuganimscriptlevel);
            print3d(self.origin + (0, 0, 70) + indentlevel, text, color);
            ent.debuganimscriptlevel++;
            return;
        }
        recordenttext(text, ent, color, channel);
    }

    // Namespace as_debug
    // Params 2, eflags: 0x0
    // Checksum 0x16828103, Offset: 0x7b0
    // Size: 0x1a2
    function debugpushstate(statename, extrainfo) {
        if (!getdvarint("<unknown string>")) {
            return;
        }
        ai_entnum = getdvarint("<unknown string>");
        if (ai_entnum > -1 && ai_entnum != self getentitynumber()) {
            return;
        }
        assert(isdefined(self.debuginfo.states));
        assert(isdefined(statename));
        state = spawnstruct();
        state.statename = statename;
        state.statelevel = self.debuginfo.statelevel;
        state.statetime = gettime();
        state.statevalid = 1;
        self.debuginfo.statelevel++;
        if (isdefined(extrainfo)) {
            state.extrainfo = extrainfo + "<unknown string>";
        }
        self.debuginfo.states[self.debuginfo.states.size] = state;
    }

    // Namespace as_debug
    // Params 2, eflags: 0x0
    // Checksum 0xa3cbf9ff, Offset: 0x960
    // Size: 0x2f8
    function debugaddstateinfo(statename, extrainfo) {
        if (!getdvarint("<unknown string>")) {
            return;
        }
        ai_entnum = getdvarint("<unknown string>");
        if (ai_entnum > -1 && ai_entnum != self getentitynumber()) {
            return;
        }
        assert(isdefined(self.debuginfo.states));
        if (isdefined(statename)) {
            for (i = self.debuginfo.states.size - 1; i >= 0; i--) {
                assert(isdefined(self.debuginfo.states[i]));
                if (self.debuginfo.states[i].statename == statename) {
                    if (!isdefined(self.debuginfo.states[i].extrainfo)) {
                        self.debuginfo.states[i].extrainfo = "<unknown string>";
                    }
                    self.debuginfo.states[i].extrainfo = self.debuginfo.states[i].extrainfo + extrainfo + "<unknown string>";
                    break;
                }
            }
            return;
        }
        if (self.debuginfo.states.size > 0) {
            lastindex = self.debuginfo.states.size - 1;
            assert(isdefined(self.debuginfo.states[lastindex]));
            if (!isdefined(self.debuginfo.states[lastindex].extrainfo)) {
                self.debuginfo.states[lastindex].extrainfo = "<unknown string>";
            }
            self.debuginfo.states[lastindex].extrainfo = self.debuginfo.states[lastindex].extrainfo + extrainfo + "<unknown string>";
        }
    }

    // Namespace as_debug
    // Params 2, eflags: 0x0
    // Checksum 0x88caa3aa, Offset: 0xc60
    // Size: 0x352
    function debugpopstate(statename, exitreason) {
        if (!getdvarint("<unknown string>") || self.debuginfo.states.size <= 0) {
            return;
        }
        ai_entnum = getdvarint("<unknown string>");
        if (!isdefined(self) || !isalive(self)) {
            return;
        }
        if (ai_entnum > -1 && ai_entnum != self getentitynumber()) {
            return;
        }
        assert(isdefined(self.debuginfo.states));
        if (isdefined(statename)) {
            for (i = 0; i < self.debuginfo.states.size; i++) {
                if (self.debuginfo.states[i].statename == statename && self.debuginfo.states[i].statevalid) {
                    self.debuginfo.states[i].statevalid = 0;
                    self.debuginfo.states[i].exitreason = exitreason;
                    self.debuginfo.statelevel = self.debuginfo.states[i].statelevel;
                    for (j = i + 1; j < self.debuginfo.states.size && self.debuginfo.states[j].statelevel > self.debuginfo.states[i].statelevel; j++) {
                        self.debuginfo.states[j].statevalid = 0;
                    }
                    break;
                }
            }
            return;
        }
        for (i = self.debuginfo.states.size - 1; i >= 0; i--) {
            if (self.debuginfo.states[i].statevalid) {
                self.debuginfo.states[i].statevalid = 0;
                self.debuginfo.states[i].exitreason = exitreason;
                self.debuginfo.statelevel--;
                break;
            }
        }
    }

    // Namespace as_debug
    // Params 0, eflags: 0x1 linked
    // Checksum 0xc670a3b3, Offset: 0xfc0
    // Size: 0x44
    function debugclearstate() {
        self.debuginfo.states = [];
        self.debuginfo.statelevel = 0;
        self.debuginfo.shouldclearonanimscriptchange = 0;
    }

    // Namespace as_debug
    // Params 0, eflags: 0x0
    // Checksum 0x7d00fea8, Offset: 0x1010
    // Size: 0x44
    function debugshouldclearstate() {
        if (isdefined(self.debuginfo) && isdefined(self.debuginfo.shouldclearonanimscriptchange) && self.debuginfo.shouldclearonanimscriptchange) {
            return 1;
        }
        return 0;
    }

    // Namespace as_debug
    // Params 0, eflags: 0x0
    // Checksum 0x2e69dca5, Offset: 0x1060
    // Size: 0xa8
    function debugcleanstatestack() {
        newarray = [];
        for (i = 0; i < self.debuginfo.states.size; i++) {
            if (self.debuginfo.states[i].statevalid) {
                newarray[newarray.size] = self.debuginfo.states[i];
            }
        }
        self.debuginfo.states = newarray;
    }

    // Namespace as_debug
    // Params 1, eflags: 0x0
    // Checksum 0xcffebbbd, Offset: 0x1110
    // Size: 0x66
    function indent(depth) {
        indent = "<unknown string>";
        for (i = 0; i < depth; i++) {
            indent += "<unknown string>";
        }
        return indent;
    }

    // Namespace as_debug
    // Params 3, eflags: 0x0
    // Checksum 0xb7386487, Offset: 0x1180
    // Size: 0x106
    function debugdrawweightedpoints(entity, points, weights) {
        lowestvalue = 0;
        highestvalue = 0;
        for (index = 0; index < points.size; index++) {
            if (weights[index] < lowestvalue) {
                lowestvalue = weights[index];
            }
            if (weights[index] > highestvalue) {
                highestvalue = weights[index];
            }
        }
        for (index = 0; index < points.size; index++) {
            debugdrawweightedpoint(entity, points[index], weights[index], lowestvalue, highestvalue);
        }
    }

    // Namespace as_debug
    // Params 5, eflags: 0x1 linked
    // Checksum 0xca208ae4, Offset: 0x1290
    // Size: 0x174
    function debugdrawweightedpoint(entity, point, weight, lowestvalue, highestvalue) {
        deltavalue = highestvalue - lowestvalue;
        halfdeltavalue = deltavalue / 2;
        midvalue = lowestvalue + deltavalue / 2;
        if (halfdeltavalue == 0) {
            halfdeltavalue = 1;
        }
        if (weight <= midvalue) {
            redcolor = 1 - abs((weight - lowestvalue) / halfdeltavalue);
            recordcircle(point, 2, (redcolor, 0, 0), "<unknown string>", entity);
            return;
        }
        greencolor = 1 - abs((highestvalue - weight) / halfdeltavalue);
        recordcircle(point, 2, (0, greencolor, 0), "<unknown string>", entity);
    }

    // Namespace as_debug
    // Params 0, eflags: 0x1 linked
    // Checksum 0x99621017, Offset: 0x1410
    // Size: 0xda
    function delete_all_ai_corpses() {
        setdvar("<unknown string>", 0);
        corpses = getcorpsearray();
        foreach (corpse in corpses) {
            if (isactorcorpse(corpse)) {
                corpse delete();
            }
        }
    }

#/
