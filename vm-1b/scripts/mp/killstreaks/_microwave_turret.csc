#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#using_animtree("mp_microwaveturret");

#namespace microwave_turret;

// Namespace microwave_turret
// Params 0, eflags: 0x2
// Checksum 0xbbfa3db2, Offset: 0x330
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("microwave_turret", &__init__, undefined, undefined);
}

// Namespace microwave_turret
// Params 0, eflags: 0x0
// Checksum 0xc9f6019e, Offset: 0x368
// Size: 0xaa
function __init__() {
    clientfield::register("vehicle", "turret_microwave_open", 1, 1, "int", &microwave_open, 0, 0);
    clientfield::register("scriptmover", "turret_microwave_init", 1, 1, "int", &microwave_init_anim, 0, 0);
    clientfield::register("scriptmover", "turret_microwave_close", 1, 1, "int", &microwave_close_anim, 0, 0);
}

// Namespace microwave_turret
// Params 7, eflags: 0x0
// Checksum 0x55531a4a, Offset: 0x420
// Size: 0x67
function function_7d53d57c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self thread turret_microwave_sound_start(localclientnum);
        return;
    }
    if (newval == 0) {
        self notify(#"sound_stop");
    }
}

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0x83d07e3, Offset: 0x490
// Size: 0x172
function turret_microwave_sound_start(localclientnum) {
    self endon(#"entityshutdown");
    self endon(#"sound_stop");
    if (isdefined(self.sound_loop_enabled) && self.sound_loop_enabled) {
        return;
    }
    self playsound(0, "wpn_micro_turret_start");
    wait 0.7;
    origin = self gettagorigin("tag_flash");
    angles = self gettagangles("tag_flash");
    forward = anglestoforward(angles);
    forward = vectorscale(forward, 750);
    trace = bullettrace(origin, origin + forward, 0, self);
    start = origin;
    end = trace["position"];
    self.microwave_audio_start = start;
    self.microwave_audio_end = end;
    self thread turret_microwave_sound_updater();
    if (!(isdefined(self.sound_loop_enabled) && self.sound_loop_enabled)) {
        self.sound_loop_enabled = 1;
        soundlineemitter("wpn_micro_turret_loop", self.microwave_audio_start, self.microwave_audio_end);
        self thread turret_microwave_sound_off_waiter(localclientnum);
    }
}

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0xdc290938, Offset: 0x610
// Size: 0x96
function turret_microwave_sound_off_waiter(localclientnum) {
    msg = self util::waittill_any("sound_stop", "entityshutdown");
    if (msg === "sound_stop") {
        playsound(0, "wpn_micro_turret_stop", self.microwave_audio_start);
    }
    soundstoplineemitter("wpn_micro_turret_loop", self.microwave_audio_start, self.microwave_audio_end);
    if (isdefined(self)) {
        self.sound_loop_enabled = 0;
    }
}

// Namespace microwave_turret
// Params 0, eflags: 0x0
// Checksum 0x123a7cd3, Offset: 0x6b0
// Size: 0x14d
function turret_microwave_sound_updater() {
    self endon(#"beam_stop");
    self endon(#"entityshutdown");
    while (true) {
        origin = self gettagorigin("tag_flash");
        if (origin[0] != self.microwave_audio_start[0] || origin[1] != self.microwave_audio_start[1] || origin[2] != self.microwave_audio_start[2]) {
            previousstart = self.microwave_audio_start;
            previousend = self.microwave_audio_end;
            angles = self gettagangles("tag_flash");
            forward = anglestoforward(angles);
            forward = vectorscale(forward, 750);
            trace = bullettrace(origin, origin + forward, 0, self);
            self.microwave_audio_start = origin;
            self.microwave_audio_end = trace["position"];
            soundupdatelineemitter("wpn_micro_turret_loop", previousstart, previousend, self.microwave_audio_start, self.microwave_audio_end);
        }
        wait 0.1;
    }
}

// Namespace microwave_turret
// Params 7, eflags: 0x0
// Checksum 0xff34d2e8, Offset: 0x808
// Size: 0xba
function microwave_init_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self useanimtree(#mp_microwaveturret);
    self setanimrestart(mp_microwaveturret%o_turret_guardian_close, 1, 0, 1);
    self setanimtime(mp_microwaveturret%o_turret_guardian_close, 1);
}

// Namespace microwave_turret
// Params 7, eflags: 0x0
// Checksum 0x2d0f5473, Offset: 0x8d0
// Size: 0x14a
function microwave_open(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        self useanimtree(#mp_microwaveturret);
        self setanim(mp_microwaveturret%o_turret_guardian_open, 0);
        self setanimrestart(mp_microwaveturret%o_turret_guardian_close, 1, 0, 1);
        self notify(#"beam_stop");
        self notify(#"sound_stop");
        return;
    }
    self useanimtree(#mp_microwaveturret);
    self setanim(mp_microwaveturret%o_turret_guardian_close, 0);
    self setanimrestart(mp_microwaveturret%o_turret_guardian_open, 1, 0, 1);
    self thread startmicrowavefx(localclientnum);
}

// Namespace microwave_turret
// Params 7, eflags: 0x0
// Checksum 0x77d68378, Offset: 0xa28
// Size: 0x92
function microwave_close_anim(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self useanimtree(#mp_microwaveturret);
    self setanimrestart(mp_microwaveturret%o_turret_guardian_close, 1, 0, 1);
}

/#

    // Namespace microwave_turret
    // Params 2, eflags: 0x0
    // Checksum 0xcb5cb217, Offset: 0xac8
    // Size: 0xba
    function debug_trace(origin, trace) {
        if (trace["<dev string:x28>"] < 1) {
            color = (0.95, 0.05, 0.05);
        } else {
            color = (0.05, 0.95, 0.05);
        }
        sphere(trace["<dev string:x31>"], 5, color, 0.75, 1, 10, 100);
        util::debug_line(origin, trace["<dev string:x31>"], color, 100);
    }

#/

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0x529d4fe9, Offset: 0xb90
// Size: 0x3e9
function startmicrowavefx(localclientnum) {
    turret = self;
    turret endon(#"entityshutdown");
    turret endon(#"beam_stop");
    turret.should_update_fx = 1;
    self thread turret_microwave_sound_start(localclientnum);
    origin = turret gettagorigin("tag_flash");
    angles = turret gettagangles("tag_flash");
    microwavefxent = spawn(localclientnum, origin, "script_model");
    microwavefxent setmodel("tag_microwavefx");
    microwavefxent.angles = angles;
    microwavefxent linkto(turret, "tag_flash");
    microwavefxent.fxhandles = [];
    microwavefxent.fxnames = [];
    microwavefxent.fxhashs = [];
    self thread updatemicrowaveaim(microwavefxent);
    self thread cleanupfx(localclientnum, microwavefxent);
    wait 0.3;
    for (;;) {
        for (;;) {
            if (true) {
                
            }
            /#
                if (getdvarint("<dev string:x3a>")) {
                    turret.should_update_fx = 1;
                    microwavefxent.fxhashs["<dev string:x58>"] = 0;
                }
            #/
            if (turret.should_update_fx == 0) {
                break;
            }
            wait 1;
        }
        if (isdefined(level.last_microwave_turret_fx_trace) && level.last_microwave_turret_fx_trace == gettime()) {
            break;
        }
        wait 0.05;
    }
    angles = turret gettagangles("tag_flash");
    origin = turret gettagorigin("tag_flash");
    forward = anglestoforward(angles);
    forward = vectorscale(forward, 750 + 40);
    var_af36cb32 = anglestoforward(angles - (0, 55 / 3, 0));
    var_af36cb32 = vectorscale(var_af36cb32, 750 + 40);
    var_3d4b46f7 = anglestoforward(angles + (0, 55 / 3, 0));
    var_3d4b46f7 = vectorscale(var_3d4b46f7, 750 + 40);
    trace = bullettrace(origin, origin + forward, 0, turret);
    traceright = bullettrace(origin, origin + var_af36cb32, 0, turret);
    traceleft = bullettrace(origin, origin + var_3d4b46f7, 0, turret);
    /#
        if (getdvarint("<dev string:x3a>")) {
            debug_trace(origin, trace);
            debug_trace(origin, traceright);
            debug_trace(origin, traceleft);
        }
    #/
    need_to_rebuild = microwavefxent microwavefxhash(trace, origin, "center");
    InvalidOpCode(0xb9, microwavefxent microwavefxhash(traceright, origin, "right"), need_to_rebuild);
    // Unknown operator (0xb9, t7_1b, PC)
}

// Namespace microwave_turret
// Params 1, eflags: 0x0
// Checksum 0x7c0544ae, Offset: 0xf88
// Size: 0x99
function updatemicrowaveaim(microwavefxent) {
    turret = self;
    turret endon(#"entityshutdown");
    turret endon(#"beam_stop");
    last_angles = turret gettagangles("tag_flash");
    while (true) {
        angles = turret gettagangles("tag_flash");
        if (last_angles != angles) {
            turret.should_update_fx = 1;
            last_angles = angles;
        }
        wait 0.1;
    }
}

// Namespace microwave_turret
// Params 3, eflags: 0x0
// Checksum 0x53c3dc03, Offset: 0x1030
// Size: 0x124
function microwavefxhash(trace, origin, name) {
    hash = 0;
    counter = 2;
    for (i = 0; i < 5; i++) {
        endofhalffxsq = (i * -106 + 125) * (i * -106 + 125);
        endoffullfxsq = (i * -106 + -56) * (i * -106 + -56);
        tracedistsq = distancesquared(origin, trace["position"]);
        if (tracedistsq >= endofhalffxsq || i == 0) {
            if (tracedistsq < endoffullfxsq) {
                hash += 1;
            } else {
                hash += counter;
            }
        }
        counter *= 2;
    }
    if (!isdefined(self.fxhashs[name])) {
        self.fxhashs[name] = 0;
    }
    last_hash = self.fxhashs[name];
    self.fxhashs[name] = hash;
    return last_hash != hash;
}

// Namespace microwave_turret
// Params 2, eflags: 0x0
// Checksum 0x8f50c34f, Offset: 0x1160
// Size: 0xb2
function cleanupfx(localclientnum, microwavefxent) {
    self util::waittill_any("entityshutdown", "beam_stop");
    foreach (handle in microwavefxent.fxhandles) {
        if (isdefined(handle)) {
            stopfx(localclientnum, handle);
        }
    }
    microwavefxent delete();
}

// Namespace microwave_turret
// Params 3, eflags: 0x0
// Checksum 0x3afc259a, Offset: 0x1220
// Size: 0x73
function play_fx_on_tag(localclientnum, fxname, tag) {
    if (!isdefined(self.fxhandles[tag]) || fxname != self.fxnames[tag]) {
        stop_fx_on_tag(localclientnum, fxname, tag);
        self.fxnames[tag] = fxname;
        self.fxhandles[tag] = playfxontag(localclientnum, fxname, self, tag);
    }
}

// Namespace microwave_turret
// Params 3, eflags: 0x0
// Checksum 0x8969caa6, Offset: 0x12a0
// Size: 0x52
function stop_fx_on_tag(localclientnum, fxname, tag) {
    if (isdefined(self.fxhandles[tag])) {
        stopfx(localclientnum, self.fxhandles[tag]);
        self.fxhandles[tag] = undefined;
        self.fxnames[tag] = undefined;
    }
}

/#

    // Namespace microwave_turret
    // Params 3, eflags: 0x0
    // Checksum 0xd6c091f8, Offset: 0x1300
    // Size: 0x72
    function render_debug_sphere(tag, color, fxname) {
        if (getdvarint("<dev string:x3a>")) {
            origin = self gettagorigin(tag);
            sphere(origin, 2, color, 0.75, 1, 10, 100);
        }
    }

#/

// Namespace microwave_turret
// Params 4, eflags: 0x0
// Checksum 0x45946065, Offset: 0x1380
// Size: 0xaa
function stop_or_start_fx(localclientnum, fxname, tag, start) {
    if (start) {
        self play_fx_on_tag(localclientnum, fxname, tag);
        /#
            if (fxname == "<dev string:x5f>") {
                render_debug_sphere(tag, (0.5, 0.5, 0), fxname);
            } else {
                render_debug_sphere(tag, (0, 1, 0), fxname);
            }
        #/
        return;
    }
    stop_fx_on_tag(localclientnum, fxname, tag);
    /#
        render_debug_sphere(tag, (1, 0, 0), fxname);
    #/
}

// Namespace microwave_turret
// Params 5, eflags: 0x0
// Checksum 0x20766b8, Offset: 0x1438
// Size: 0x403
function playmicrowavefx(localclientnum, trace, traceright, traceleft, origin) {
    rows = 5;
    for (i = 0; i < rows; i++) {
        endofhalffxsq = (i * -106 + 125) * (i * -106 + 125);
        endoffullfxsq = (i * -106 + -56) * (i * -106 + -56);
        tracedistsq = distancesquared(origin, trace["position"]);
        startfx = tracedistsq >= endofhalffxsq || i == 0;
        fxname = tracedistsq < endoffullfxsq ? "killstreaks/fx_sg_distortion_cone_ash_sm" : "killstreaks/fx_sg_distortion_cone_ash";
        switch (i) {
        case 0:
            self play_fx_on_tag(localclientnum, fxname, "tag_fx11");
            break;
        case 1:
            break;
        case 2:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx32", startfx);
            break;
        case 3:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx42", startfx);
            self stop_or_start_fx(localclientnum, fxname, "tag_fx43", startfx);
            break;
        case 4:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx53", startfx);
            break;
        }
        tracedistsq = distancesquared(origin, traceleft["position"]);
        startfx = tracedistsq >= endofhalffxsq;
        fxname = tracedistsq < endoffullfxsq ? "killstreaks/fx_sg_distortion_cone_ash_sm" : "killstreaks/fx_sg_distortion_cone_ash";
        switch (i) {
        case 0:
            break;
        case 1:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx22", startfx);
            break;
        case 2:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx33", startfx);
            break;
        case 3:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx44", startfx);
            break;
        case 4:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx54", startfx);
            self stop_or_start_fx(localclientnum, fxname, "tag_fx55", startfx);
            break;
        }
        tracedistsq = distancesquared(origin, traceright["position"]);
        startfx = tracedistsq >= endofhalffxsq;
        fxname = tracedistsq < endoffullfxsq ? "killstreaks/fx_sg_distortion_cone_ash_sm" : "killstreaks/fx_sg_distortion_cone_ash";
        switch (i) {
        case 0:
            break;
        case 1:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx21", startfx);
            break;
        case 2:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx31", startfx);
            break;
        case 3:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx41", startfx);
            break;
        case 4:
            self stop_or_start_fx(localclientnum, fxname, "tag_fx51", startfx);
            self stop_or_start_fx(localclientnum, fxname, "tag_fx52", startfx);
            break;
        }
    }
}

