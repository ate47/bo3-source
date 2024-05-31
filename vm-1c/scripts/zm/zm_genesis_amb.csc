#using scripts/shared/music_shared;
#using scripts/codescripts/struct;

#namespace namespace_a7ac3fc4;

// Namespace namespace_a7ac3fc4
// Params 0, eflags: 0x1 linked
// Checksum 0x33d448ff, Offset: 0xd8
// Size: 0x14
function main() {
    thread startzmbspawnersoundloops();
}

// Namespace namespace_a7ac3fc4
// Params 0, eflags: 0x1 linked
// Checksum 0xba4561fa, Offset: 0xf8
// Size: 0x15c
function startzmbspawnersoundloops() {
    loopers = struct::get_array("exterior_goal", "targetname");
    if (isdefined(loopers) && loopers.size > 0) {
        delay = 0;
        /#
            if (getdvarint("<unknown string>") > 0) {
                println("<unknown string>" + loopers.size + "<unknown string>");
            }
        #/
        for (i = 0; i < loopers.size; i++) {
            loopers[i] thread soundloopthink();
            delay += 1;
            if (delay % 20 == 0) {
                wait(0.016);
            }
        }
        return;
    }
    /#
        if (getdvarint("<unknown string>") > 0) {
            println("<unknown string>");
        }
    #/
}

// Namespace namespace_a7ac3fc4
// Params 0, eflags: 0x1 linked
// Checksum 0x72bff574, Offset: 0x260
// Size: 0x16c
function soundloopthink() {
    if (!isdefined(self.origin)) {
        return;
    }
    if (!isdefined(self.script_sound)) {
        self.script_sound = "zmb_spawn_walla";
    }
    notifyname = "";
    assert(isdefined(notifyname));
    if (isdefined(self.script_string)) {
        notifyname = self.script_string;
    }
    assert(isdefined(notifyname));
    started = 1;
    if (isdefined(self.script_int)) {
        started = self.script_int != 0;
    }
    if (started) {
        soundloopemitter(self.script_sound, self.origin);
    }
    if (notifyname != "") {
        for (;;) {
            level waittill(notifyname);
            if (started) {
                soundstoploopemitter(self.script_sound, self.origin);
            } else {
                soundloopemitter(self.script_sound, self.origin);
            }
            started = !started;
        }
    }
}

