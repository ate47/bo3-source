#using scripts/shared/music_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace audio;

// Namespace audio
// Params 0, eflags: 0x2
// Checksum 0x54eb2526, Offset: 0x8c0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("audio", &__init__, undefined, undefined);
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x6c48b937, Offset: 0x900
// Size: 0xdc
function __init__() {
    snd_snapshot_init();
    callback::on_localclient_connect(&player_init);
    callback::on_localplayer_spawned(&local_player_spawn);
    level thread register_clientfields();
    level thread sndkillcam();
    level thread function_b8573880();
    setsoundcontext("foley", "normal");
    setsoundcontext("plr_impact", "");
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x68ae4611, Offset: 0x9e8
// Size: 0x31c
function register_clientfields() {
    clientfield::register("world", "sndMatchSnapshot", 1, 2, "int", &sndmatchsnapshot, 1, 0);
    clientfield::register("world", "sndFoleyContext", 1, 1, "int", &sndfoleycontext, 0, 0);
    clientfield::register("scriptmover", "sndRattle", 1, 1, "int", &sndrattle_server, 1, 0);
    clientfield::register("toplayer", "sndMelee", 1, 1, "int", &weapon_butt_sounds, 1, 1);
    clientfield::register("vehicle", "sndSwitchVehicleContext", 1, 3, "int", &sndswitchvehiclecontext, 0, 0);
    clientfield::register("toplayer", "sndCCHacking", 1, 2, "int", &sndcchacking, 1, 1);
    clientfield::register("toplayer", "sndTacRig", 1, 1, "int", &sndtacrig, 0, 1);
    clientfield::register("toplayer", "sndLevelStartSnapOff", 1, 1, "int", &sndlevelstartsnapoff, 0, 1);
    clientfield::register("world", "sndIGCsnapshot", 1, 4, "int", &sndigcsnapshot, 1, 0);
    clientfield::register("world", "sndChyronLoop", 1, 1, "int", &sndchyronloop, 0, 0);
    clientfield::register("world", "sndZMBFadeIn", 1, 1, "int", &sndzmbfadein, 1, 0);
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x11efe10d, Offset: 0xd10
// Size: 0xe4
function local_player_spawn(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    setsoundcontext("foley", "normal");
    if (!sessionmodeismultiplayergame()) {
        if (isdefined(level._lastmusicstate)) {
            soundsetmusicstate(level._lastmusicstate);
        }
        self thread sndmusicdeathwatcher();
    }
    self thread isplayerinfected();
    self thread snd_underwater(localclientnum);
    self thread clientvoicesetup(localclientnum);
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x4c35c6d5, Offset: 0xe00
// Size: 0xb4
function player_init(localclientnum) {
    if (issplitscreenhost(localclientnum)) {
        level thread bump_trigger_start(localclientnum);
        level thread init_audio_triggers(localclientnum);
        level thread sndrattle_grenade_client();
        startsoundrandoms(localclientnum);
        startsoundloops();
        startlineemitters();
        startrattles();
    }
}

// Namespace audio
// Params 0, eflags: 0x0
// Checksum 0xc76a7cd3, Offset: 0xec0
// Size: 0xf0
function snddoublejump_watcher() {
    self endon(#"entityshutdown");
    while (true) {
        self waittill(#"doublejump_start");
        trace = tracepoint(self.origin, self.origin - (0, 0, 100000));
        trace_surface_type = trace["surfacetype"];
        trace_origin = trace["position"];
        if (!isdefined(trace) || !isdefined(trace_origin)) {
            continue;
        }
        if (!isdefined(trace_surface_type)) {
            trace_surface_type = "default";
        }
        playsound(0, "veh_jetpack_surface_" + trace_surface_type, trace_origin);
    }
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x608f7998, Offset: 0xfb8
// Size: 0xc4
function clientvoicesetup(localclientnum) {
    self endon(#"entityshutdown");
    if (isdefined(level.clientvoicesetup)) {
        [[ level.clientvoicesetup ]](localclientnum);
        return;
    }
    self.teamclientprefix = "vox_gen";
    self thread sndvonotify("playerbreathinsound", "sinper_hold");
    self thread sndvonotify("playerbreathoutsound", "sinper_exhale");
    self thread sndvonotify("playerbreathgaspsound", "sinper_gasp");
}

// Namespace audio
// Params 2, eflags: 0x1 linked
// Checksum 0xc65c6f96, Offset: 0x1088
// Size: 0x68
function sndvonotify(notifystring, dialog) {
    self endon(#"entityshutdown");
    for (;;) {
        self waittill(notifystring);
        soundalias = self.teamclientprefix + "_" + dialog;
        self playsound(0, soundalias);
    }
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0xb9451265, Offset: 0x10f8
// Size: 0x194
function snd_snapshot_init() {
    level._sndactivesnapshot = "default";
    level._sndnextsnapshot = "default";
    mapname = getdvarstring("mapname");
    if (mapname !== "core_frontend") {
        if (sessionmodeiscampaigngame()) {
            level._sndactivesnapshot = "cmn_level_start";
            level._sndnextsnapshot = "cmn_level_start";
        }
        if (sessionmodeiszombiesgame()) {
            if (mapname !== "zm_cosmodrome" && mapname !== "zm_prototype" && mapname !== "zm_moon" && mapname !== "zm_sumpf" && mapname !== "zm_asylum" && mapname !== "zm_temple" && mapname !== "zm_theater" && mapname !== "zm_tomb") {
                level._sndactivesnapshot = "zmb_game_start_nofade";
                level._sndnextsnapshot = "zmb_game_start_nofade";
            } else {
                level._sndactivesnapshot = "zmb_hd_game_start_nofade";
                level._sndnextsnapshot = "zmb_hd_game_start_nofade";
            }
        }
    }
    setgroupsnapshot(level._sndactivesnapshot);
    thread snd_snapshot_think();
}

// Namespace audio
// Params 0, eflags: 0x0
// Checksum 0xf6e0d08a, Offset: 0x1298
// Size: 0x34
function function_23cf79ea() {
    level endon(#"hash_76eb38a5");
    level util::waittill_any_timeout(20, "sndOn", "sndOnOverride");
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0xc112aa88, Offset: 0x12d8
// Size: 0x52
function snd_set_snapshot(state) {
    level._sndnextsnapshot = state;
    println("sndFoleyContext" + state + "sndFoleyContext");
    level notify(#"new_bus");
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x2776e79, Offset: 0x1338
// Size: 0xa8
function snd_snapshot_think() {
    for (;;) {
        if (level._sndactivesnapshot == level._sndnextsnapshot) {
            level waittill(#"new_bus");
        }
        if (level._sndactivesnapshot == level._sndnextsnapshot) {
            continue;
        }
        assert(isdefined(level._sndnextsnapshot));
        assert(isdefined(level._sndactivesnapshot));
        setgroupsnapshot(level._sndnextsnapshot);
        level._sndactivesnapshot = level._sndnextsnapshot;
    }
}

// Namespace audio
// Params 2, eflags: 0x1 linked
// Checksum 0xe652ed17, Offset: 0x13e8
// Size: 0x230
function soundrandom_thread(localclientnum, randsound) {
    if (!isdefined(randsound.script_wait_min)) {
        randsound.script_wait_min = 1;
    }
    if (!isdefined(randsound.script_wait_max)) {
        randsound.script_wait_max = 3;
    }
    notify_name = undefined;
    if (isdefined(randsound.script_string)) {
        notify_name = randsound.script_string;
    }
    if (!isdefined(notify_name) && isdefined(randsound.script_sound)) {
        createsoundrandom(randsound.origin, randsound.script_sound, randsound.script_wait_min, randsound.script_wait_max);
        return;
    }
    randsound.playing = 1;
    level thread soundrandom_notifywait(notify_name, randsound);
    while (true) {
        wait(randomfloatrange(randsound.script_wait_min, randsound.script_wait_max));
        if (isdefined(randsound.playing) && isdefined(randsound.script_sound) && randsound.playing) {
            playsound(localclientnum, randsound.script_sound, randsound.origin);
        }
        /#
            if (getdvarint("sndFoleyContext") > 0) {
                print3d(randsound.origin, randsound.script_sound, (0, 0.8, 0), 1, 3, 45);
            }
        #/
    }
}

// Namespace audio
// Params 2, eflags: 0x1 linked
// Checksum 0x20cbadec, Offset: 0x1620
// Size: 0x78
function soundrandom_notifywait(notify_name, randsound) {
    while (true) {
        level waittill(notify_name);
        if (isdefined(randsound.playing) && randsound.playing) {
            randsound.playing = 0;
            continue;
        }
        randsound.playing = 1;
    }
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x68cc2d7a, Offset: 0x16a0
// Size: 0x106
function startsoundrandoms(localclientnum) {
    randoms = struct::get_array("random", "script_label");
    if (isdefined(randoms) && randoms.size > 0) {
        nscriptthreadedrandoms = 0;
        for (i = 0; i < randoms.size; i++) {
            if (isdefined(randoms[i].script_scripted)) {
                nscriptthreadedrandoms++;
            }
        }
        allocatesoundrandoms(randoms.size - nscriptthreadedrandoms);
        for (i = 0; i < randoms.size; i++) {
            thread soundrandom_thread(localclientnum, randoms[i]);
        }
    }
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x2e62bc1f, Offset: 0x17b0
// Size: 0x174
function soundloopthink() {
    if (!isdefined(self.script_sound)) {
        return;
    }
    if (!isdefined(self.origin)) {
        return;
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
                self thread soundloopcheckpointrestore();
            } else {
                soundloopemitter(self.script_sound, self.origin);
            }
            started = !started;
        }
    }
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0xf608ba75, Offset: 0x1930
// Size: 0x34
function soundloopcheckpointrestore() {
    level waittill(#"save_restore");
    soundloopemitter(self.script_sound, self.origin);
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x4be6950b, Offset: 0x1970
// Size: 0x184
function soundlinethink() {
    if (!isdefined(self.target)) {
        return;
    }
    target = struct::get(self.target, "targetname");
    if (!isdefined(target)) {
        return;
    }
    notifyname = "";
    if (isdefined(self.script_string)) {
        notifyname = self.script_string;
    }
    started = 1;
    if (isdefined(self.script_int)) {
        started = self.script_int != 0;
    }
    if (started) {
        soundlineemitter(self.script_sound, self.origin, target.origin);
    }
    if (notifyname != "") {
        for (;;) {
            level waittill(notifyname);
            if (started) {
                soundstoplineemitter(self.script_sound, self.origin, target.origin);
                self thread soundlinecheckpointrestore(target);
            } else {
                soundlineemitter(self.script_sound, self.origin, target.origin);
            }
            started = !started;
        }
    }
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0xacac1318, Offset: 0x1b00
// Size: 0x44
function soundlinecheckpointrestore(target) {
    level waittill(#"save_restore");
    soundlineemitter(self.script_sound, self.origin, target.origin);
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x89db718, Offset: 0x1b50
// Size: 0x15c
function startsoundloops() {
    loopers = struct::get_array("looper", "script_label");
    if (isdefined(loopers) && loopers.size > 0) {
        delay = 0;
        /#
            if (getdvarint("sndFoleyContext") > 0) {
                println("sndFoleyContext" + loopers.size + "sndFoleyContext");
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
        if (getdvarint("sndFoleyContext") > 0) {
            println("sndFoleyContext");
        }
    #/
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0xd40546b8, Offset: 0x1cb8
// Size: 0x15c
function startlineemitters() {
    lineemitters = struct::get_array("line_emitter", "script_label");
    if (isdefined(lineemitters) && lineemitters.size > 0) {
        delay = 0;
        /#
            if (getdvarint("sndFoleyContext") > 0) {
                println("sndFoleyContext" + lineemitters.size + "sndFoleyContext");
            }
        #/
        for (i = 0; i < lineemitters.size; i++) {
            lineemitters[i] thread soundlinethink();
            delay += 1;
            if (delay % 20 == 0) {
                wait(0.016);
            }
        }
        return;
    }
    /#
        if (getdvarint("sndFoleyContext") > 0) {
            println("sndFoleyContext");
        }
    #/
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x252c16d3, Offset: 0x1e20
// Size: 0x10a
function startrattles() {
    rattles = struct::get_array("sound_rattle", "script_label");
    if (isdefined(rattles)) {
        println("sndFoleyContext" + rattles.size + "sndFoleyContext");
        delay = 0;
        for (i = 0; i < rattles.size; i++) {
            soundrattlesetup(rattles[i].script_sound, rattles[i].origin);
            delay += 1;
            if (delay % 20 == 0) {
                wait(0.016);
            }
        }
    }
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x7a647695, Offset: 0x1f38
// Size: 0x154
function init_audio_triggers(localclientnum) {
    util::waitforclient(localclientnum);
    steptrigs = getentarray(localclientnum, "audio_step_trigger", "targetname");
    materialtrigs = getentarray(localclientnum, "audio_material_trigger", "targetname");
    /#
        if (getdvarint("sndFoleyContext") > 0) {
            println("sndFoleyContext" + steptrigs.size + "sndFoleyContext");
            println("sndFoleyContext" + materialtrigs.size + "sndFoleyContext");
        }
    #/
    array::thread_all(steptrigs, &audio_step_trigger, localclientnum);
    array::thread_all(materialtrigs, &audio_material_trigger, localclientnum);
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x59471705, Offset: 0x2098
// Size: 0x70
function audio_step_trigger(localclientnum) {
    self._localclientnum = localclientnum;
    for (;;) {
        trigplayer = self waittill(#"trigger");
        self thread trigger::function_thread(trigplayer, &trig_enter_audio_step_trigger, &trig_leave_audio_step_trigger);
    }
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x82801e2c, Offset: 0x2110
// Size: 0x60
function audio_material_trigger(trig) {
    for (;;) {
        trigplayer = self waittill(#"trigger");
        self thread trigger::function_thread(trigplayer, &trig_enter_audio_material_trigger, &trig_leave_audio_material_trigger);
    }
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0xa3c81852, Offset: 0x2178
// Size: 0x7c
function trig_enter_audio_material_trigger(player) {
    if (!isdefined(player.inmaterialoverridetrigger)) {
        player.inmaterialoverridetrigger = 0;
    }
    if (isdefined(self.script_label)) {
        player.inmaterialoverridetrigger++;
        player.audiomaterialoverride = self.script_label;
        player setmaterialoverride(self.script_label);
    }
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x3b91a333, Offset: 0x2200
// Size: 0x9c
function trig_leave_audio_material_trigger(player) {
    if (isdefined(self.script_label)) {
        player.inmaterialoverridetrigger--;
        assert(player.inmaterialoverridetrigger >= 0);
        if (player.inmaterialoverridetrigger <= 0) {
            player.audiomaterialoverride = undefined;
            player.inmaterialoverridetrigger = 0;
            player clearmaterialoverride();
        }
    }
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x2dc37895, Offset: 0x22a8
// Size: 0x164
function trig_enter_audio_step_trigger(trigplayer) {
    localclientnum = self._localclientnum;
    if (!isdefined(trigplayer.insteptrigger)) {
        trigplayer.insteptrigger = 0;
    }
    suffix = "_npc";
    if (trigplayer islocalplayer()) {
        suffix = "_plr";
    }
    if (isdefined(self.script_label)) {
        trigplayer.step_sound = self.script_label;
        trigplayer.insteptrigger += 1;
        trigplayer setsteptriggersound(self.script_label + suffix);
    }
    if (isdefined(self.script_sound) && trigplayer getmovementtype() == "sprint") {
        volume = get_vol_from_speed(trigplayer);
        trigplayer playsound(localclientnum, self.script_sound + suffix, self.origin, volume);
    }
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x9185709d, Offset: 0x2418
// Size: 0x18c
function trig_leave_audio_step_trigger(trigplayer) {
    localclientnum = self._localclientnum;
    suffix = "_npc";
    if (trigplayer islocalplayer()) {
        suffix = "_plr";
    }
    if (isdefined(self.script_noteworthy) && trigplayer getmovementtype() == "sprint") {
        volume = get_vol_from_speed(trigplayer);
        trigplayer playsound(localclientnum, self.script_noteworthy + suffix, self.origin, volume);
    }
    if (isdefined(self.script_label)) {
        trigplayer.insteptrigger -= 1;
    }
    if (trigplayer.insteptrigger < 0) {
        println("sndFoleyContext");
        trigplayer.insteptrigger = 0;
    }
    if (trigplayer.insteptrigger == 0) {
        trigplayer.step_sound = "none";
        trigplayer clearsteptriggersound();
    }
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0xcf03e099, Offset: 0x25b0
// Size: 0x8e
function bump_trigger_start(localclientnum) {
    bump_trigs = getentarray(localclientnum, "audio_bump_trigger", "targetname");
    for (i = 0; i < bump_trigs.size; i++) {
        bump_trigs[i] thread thread_bump_trigger(localclientnum);
    }
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x255f20e3, Offset: 0x2648
// Size: 0xa0
function thread_bump_trigger(localclientnum) {
    self thread bump_trigger_listener();
    if (!isdefined(self.script_activated)) {
        self.script_activated = 1;
    }
    self._localclientnum = localclientnum;
    for (;;) {
        trigplayer = self waittill(#"trigger");
        self thread trigger::function_thread(trigplayer, &trig_enter_bump, &trig_leave_bump);
    }
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x92f611cb, Offset: 0x26f0
// Size: 0x1e4
function trig_enter_bump(ent) {
    if (!isdefined(ent)) {
        return;
    }
    localclientnum = self._localclientnum;
    volume = get_vol_from_speed(ent);
    if (!sessionmodeiszombiesgame()) {
        if (ent isplayer() && ent hasperk(localclientnum, "specialty_quieter")) {
            volume /= 2;
        }
    }
    if (isdefined(self.script_sound) && self.script_activated) {
        if (isdefined(self.script_noteworthy) && self.script_wait > volume) {
            test_id = ent playsound(localclientnum, self.script_noteworthy, self.origin, volume);
        }
        if (isdefined(self.script_parameters)) {
            test_id = ent playsound(localclientnum, self.script_parameters, self.origin, volume);
        }
        if (!isdefined(self.script_wait) || self.script_wait <= volume) {
            test_id = ent playsound(localclientnum, self.script_sound, self.origin, volume);
        }
    }
    if (isdefined(self.script_location) && self.script_activated) {
        ent thread mantle_wait(self.script_location, localclientnum);
    }
}

// Namespace audio
// Params 2, eflags: 0x1 linked
// Checksum 0x30fedee1, Offset: 0x28e0
// Size: 0x64
function mantle_wait(alias, localclientnum) {
    self endon(#"death");
    self endon(#"left_mantle");
    self waittill(#"traversesound");
    self playsound(localclientnum, alias, self.origin, 1);
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x3b71de64, Offset: 0x2950
// Size: 0x20
function trig_leave_bump(ent) {
    wait(1);
    ent notify(#"left_mantle");
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x5dd2aaa6, Offset: 0x2978
// Size: 0x28
function bump_trigger_listener() {
    if (isdefined(self.script_label)) {
        level waittill(self.script_label);
        self.script_activated = 0;
    }
}

// Namespace audio
// Params 5, eflags: 0x1 linked
// Checksum 0x3e3dd149, Offset: 0x29a8
// Size: 0xcc
function scale_speed(x1, x2, y1, y2, z) {
    if (z < x1) {
        z = x1;
    }
    if (z > x2) {
        z = x2;
    }
    dx = x2 - x1;
    n = (z - x1) / dx;
    dy = y2 - y1;
    w = n * dy + y1;
    return w;
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x74d0a80d, Offset: 0x2a80
// Size: 0xe4
function get_vol_from_speed(player) {
    min_speed = 21;
    max_speed = 285;
    max_vol = 1;
    min_vol = 0.1;
    speed = player getspeed();
    abs_speed = absolute_value(int(speed));
    volume = scale_speed(min_speed, max_speed, min_vol, max_vol, abs_speed);
    return volume;
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x9de1aa44, Offset: 0x2b70
// Size: 0x2e
function absolute_value(fowd) {
    if (fowd < 0) {
        return (fowd * -1);
    }
    return fowd;
}

// Namespace audio
// Params 3, eflags: 0x1 linked
// Checksum 0xe9cc5eb, Offset: 0x2ba8
// Size: 0x1e0
function closest_point_on_line_to_point(point, linestart, lineend) {
    self endon(#"hash_18e2bbbb");
    linemagsqrd = lengthsquared(lineend - linestart);
    t = ((point[0] - linestart[0]) * (lineend[0] - linestart[0]) + (point[1] - linestart[1]) * (lineend[1] - linestart[1]) + (point[2] - linestart[2]) * (lineend[2] - linestart[2])) / linemagsqrd;
    if (t < 0) {
        self.origin = linestart;
        return;
    }
    if (t > 1) {
        self.origin = lineend;
        return;
    }
    start_x = linestart[0] + t * (lineend[0] - linestart[0]);
    start_y = linestart[1] + t * (lineend[1] - linestart[1]);
    start_z = linestart[2] + t * (lineend[2] - linestart[2]);
    self.origin = (start_x, start_y, start_z);
}

// Namespace audio
// Params 9, eflags: 0x1 linked
// Checksum 0x877405e1, Offset: 0x2d90
// Size: 0x84
function snd_play_auto_fx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override) {
    soundplayautofx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override);
}

/#

    // Namespace audio
    // Params 3, eflags: 0x0
    // Checksum 0x4d2d743b, Offset: 0x2e20
    // Size: 0x6c
    function snd_print_fx_id(fxid, type, ent) {
        if (getdvarint("sndFoleyContext") > 0) {
            println("sndFoleyContext" + fxid + "sndFoleyContext" + type);
        }
    }

#/

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0xd6bd2bf, Offset: 0x2e98
// Size: 0x108
function debug_line_emitter() {
    while (true) {
        /#
            if (getdvarint("sndFoleyContext") > 0) {
                line(self.start, self.end, (0, 1, 0));
                print3d(self.start, "sndFoleyContext", (0, 0.8, 0), 1, 3, 1);
                print3d(self.end, "sndFoleyContext", (0, 0.8, 0), 1, 3, 1);
                print3d(self.origin, self.script_sound, (0, 0.8, 0), 1, 3, 1);
            }
            wait(0.016);
        #/
    }
}

// Namespace audio
// Params 0, eflags: 0x0
// Checksum 0xd24e6c50, Offset: 0x2fa8
// Size: 0x104
function move_sound_along_line() {
    closest_dist = undefined;
    /#
        self thread debug_line_emitter();
    #/
    while (true) {
        self closest_point_on_line_to_point(getlocalclientpos(0), self.start, self.end);
        if (isdefined(self.fake_ent)) {
            self.fake_ent.origin = self.origin;
        }
        closest_dist = distancesquared(getlocalclientpos(0), self.origin);
        if (closest_dist > 1048576) {
            wait(2);
            continue;
        }
        if (closest_dist > 262144) {
            wait(0.2);
            continue;
        }
        wait(0.05);
    }
}

// Namespace audio
// Params 2, eflags: 0x1 linked
// Checksum 0xb5f6b6fb, Offset: 0x30b8
// Size: 0x2c
function playloopat(aliasname, origin) {
    soundloopemitter(aliasname, origin);
}

// Namespace audio
// Params 2, eflags: 0x1 linked
// Checksum 0xa502f2a1, Offset: 0x30f0
// Size: 0x2c
function stoploopat(aliasname, origin) {
    soundstoploopemitter(aliasname, origin);
}

// Namespace audio
// Params 1, eflags: 0x0
// Checksum 0x9995f98a, Offset: 0x3128
// Size: 0x34
function soundwait(id) {
    while (soundplaying(id)) {
        wait(0.1);
    }
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0xff65be16, Offset: 0x3168
// Size: 0x300
function snd_underwater(localclientnum) {
    level endon(#"demo_jump");
    self endon(#"entityshutdown");
    level endon("killcam_begin" + localclientnum);
    level endon("killcam_end" + localclientnum);
    self endon(#"sndenduwwatcher");
    if (!isdefined(level.audiosharedswimming)) {
        level.audiosharedswimming = 0;
    }
    if (!isdefined(level.audiosharedunderwater)) {
        level.audiosharedunderwater = 0;
    }
    if (level.audiosharedswimming != isswimming(localclientnum)) {
        level.audiosharedswimming = isswimming(localclientnum);
        if (level.audiosharedswimming) {
            swimbegin();
        } else {
            swimcancel(localclientnum);
        }
    }
    if (level.audiosharedunderwater != isunderwater(localclientnum)) {
        level.audiosharedunderwater = isunderwater(localclientnum);
        if (level.audiosharedunderwater) {
            self underwaterbegin();
        } else {
            self underwaterend();
        }
    }
    while (true) {
        underwaternotify = self util::function_183e3618("underwater_begin", "underwater_end", "swimming_begin", "swimming_end", "death", "entityshutdown", "sndEndUWWatcher", level, "demo_jump", "killcam_begin" + localclientnum, "killcam_end" + localclientnum);
        if (underwaternotify == "death") {
            self underwaterend();
            self swimend(localclientnum);
        }
        if (underwaternotify == "underwater_begin") {
            self underwaterbegin();
            continue;
        }
        if (underwaternotify == "underwater_end") {
            self underwaterend();
            continue;
        }
        if (underwaternotify == "swimming_begin") {
            self swimbegin();
            continue;
        }
        if (underwaternotify == "swimming_end" && self isplayer() && isalive(self)) {
            self swimend(localclientnum);
        }
    }
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x906d07c7, Offset: 0x3470
// Size: 0x10
function underwaterbegin() {
    level.audiosharedunderwater = 1;
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x51736077, Offset: 0x3488
// Size: 0x10
function underwaterend() {
    level.audiosharedunderwater = 0;
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x26847f8b, Offset: 0x34a0
// Size: 0x68
function function_b8573880() {
    level waittill(#"hash_fc4e1da9");
    setsoundcontext("igc", "on");
    level waittill(#"hash_da4558d5");
    setsoundcontext("igc", "");
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x5fd64260, Offset: 0x3510
// Size: 0x10
function swimbegin() {
    self.audiosharedswimming = 1;
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x930bd3d2, Offset: 0x3528
// Size: 0x18
function swimend(localclientnum) {
    self.audiosharedswimming = 0;
}

// Namespace audio
// Params 1, eflags: 0x1 linked
// Checksum 0x63377ca4, Offset: 0x3548
// Size: 0x18
function swimcancel(localclientnum) {
    self.audiosharedswimming = 0;
}

// Namespace audio
// Params 2, eflags: 0x1 linked
// Checksum 0xe3987c19, Offset: 0x3568
// Size: 0xbe
function soundplayuidecodeloop(decodestring, playtimems) {
    if (!isdefined(level.playinguidecodeloop) || !level.playinguidecodeloop) {
        level.playinguidecodeloop = 1;
        fake_ent = spawn(0, (0, 0, 0), "script_origin");
        if (isdefined(fake_ent)) {
            fake_ent playloopsound("uin_notify_data_loop");
            wait(playtimems / 1000);
            fake_ent stopallloopsounds(0);
        }
        level.playinguidecodeloop = undefined;
    }
}

// Namespace audio
// Params 5, eflags: 0x1 linked
// Checksum 0xbbfb71e9, Offset: 0x3630
// Size: 0x54
function setcurrentambientstate(ambientroom, ambientpackage, roomcollidercent, packagecollidercent, defaultroom) {
    if (isdefined(level.var_54fb3edb)) {
        level thread [[ level.var_54fb3edb ]](ambientroom, ambientpackage, roomcollidercent);
    }
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x322a951e, Offset: 0x3690
// Size: 0x2c6
function isplayerinfected() {
    self endon(#"entityshutdown");
    mapname = getdvarstring("mapname");
    if (!isdefined(mapname)) {
        mapname = "cp_mi_eth_prologue";
    }
    if (isdefined(self)) {
        switch (mapname) {
        case 76:
            self.isinfected = 0;
            setsoundcontext("healthstate", "human");
            break;
        case 82:
            self.isinfected = 1;
            setsoundcontext("healthstate", "infected");
            break;
        case 83:
            self.isinfected = 1;
            setsoundcontext("healthstate", "infected");
            break;
        case 81:
            self.isinfected = 1;
            setsoundcontext("healthstate", "infected");
            break;
        case 84:
            self.isinfected = 1;
            setsoundcontext("healthstate", "infected");
            break;
        case 85:
            self.isinfected = 1;
            setsoundcontext("healthstate", "infected");
            break;
        case 86:
            self.isinfected = 1;
            setsoundcontext("healthstate", "infected");
            break;
        case 87:
            self.isinfected = 1;
            setsoundcontext("healthstate", "infected");
            break;
        case 89:
            self.isinfected = 0;
            setsoundcontext("healthstate", "human");
            break;
        case 88:
            self.isinfected = 0;
            setsoundcontext("healthstate", "human");
            break;
        default:
            self.isinfected = 0;
            setsoundcontext("healthstate", "cyber");
            break;
        }
    }
}

// Namespace audio
// Params 7, eflags: 0x1 linked
// Checksum 0x2bc52004, Offset: 0x3960
// Size: 0x33e
function function_e1ab476f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_9953d541 = "chr_health_lowhealth_enter";
    var_9446a781 = "chr_health_lowhealth_exit";
    var_177599f1 = "chr_health_laststand_exit";
    var_dc3140c4 = "chr_health_dni_repair";
    if (newval) {
        switch (newval) {
        case 1:
            self.lowhealth = 1;
            playsound(localclientnum, var_9953d541, (0, 0, 0));
            forceambientroom("sndHealth_LowHealth");
            self thread function_451c4dae(localclientnum, var_dc3140c4, 0.4, 0.8);
            break;
        case 2:
            playsound(localclientnum, var_9446a781, (0, 0, 0));
            forceambientroom("sndHealth_LastStand");
            self notify(#"hash_2b4649a6");
            setsoundcontext("laststand", "active");
            break;
        }
        return;
    }
    self.lowhealth = 0;
    setsoundcontext("laststand", "");
    if (isdefined(level.audiosharedunderwater) && sessionmodeiscampaigngame() && level.audiosharedunderwater) {
        mapname = getdvarstring("mapname");
        if (mapname == "cp_mi_sing_sgen") {
            forceambientroom("");
        } else {
            forceambientroom("");
        }
    } else {
        forceambientroom("");
    }
    if (oldval == 1) {
        playsound(localclientnum, var_9446a781, (0, 0, 0));
        self notify(#"hash_2b4649a6");
    } else {
        if (isalive(self)) {
            playsound(localclientnum, var_177599f1, (0, 0, 0));
            if (isdefined(self.sndtacrigemergencyreserve) && self.sndtacrigemergencyreserve) {
                playsound(localclientnum, "gdt_cybercore_regen_complete", (0, 0, 0));
            }
        }
        self notify(#"hash_2b4649a6");
    }
}

// Namespace audio
// Params 4, eflags: 0x1 linked
// Checksum 0xf588a7ea, Offset: 0x3ca8
// Size: 0xb8
function function_451c4dae(localclientnum, var_7f2a8cb, min, max) {
    self endon(#"hash_2b4649a6");
    wait(0.5);
    if (isdefined(self) && isdefined(self.isinfected)) {
        if (self.isinfected) {
            playsound(localclientnum, "vox_dying_infected_after", (0, 0, 0));
        }
        while (isdefined(self)) {
            playsound(localclientnum, var_7f2a8cb, (0, 0, 0));
            wait(randomfloatrange(min, max));
        }
    }
}

// Namespace audio
// Params 7, eflags: 0x1 linked
// Checksum 0x967dc574, Offset: 0x3d68
// Size: 0x60
function sndtacrig(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.sndtacrigemergencyreserve = 1;
        return;
    }
    self.sndtacrigemergencyreserve = 0;
}

// Namespace audio
// Params 3, eflags: 0x1 linked
// Checksum 0x8c26f403, Offset: 0x3dd0
// Size: 0x6c
function dorattle(origin, min, max) {
    if (isdefined(min) && min > 0) {
        if (isdefined(max) && max <= 0) {
            max = undefined;
        }
        soundrattle(origin, min, max);
    }
}

// Namespace audio
// Params 7, eflags: 0x1 linked
// Checksum 0xfbc8f75, Offset: 0x3e48
// Size: 0xdc
function sndrattle_server(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (self.model == "wpn_t7_bouncing_betty_world") {
            betty = getweapon("bouncingbetty");
            level thread dorattle(self.origin, betty.soundrattlerangemin, betty.soundrattlerangemax);
            return;
        }
        level thread dorattle(self.origin, 25, 600);
    }
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0xe193693, Offset: 0x3f30
// Size: 0x88
function sndrattle_grenade_client() {
    while (true) {
        localclientnum, position, mod, weapon, owner_cent = level waittill(#"explode");
        level thread dorattle(position, weapon.soundrattlerangemin, weapon.soundrattlerangemax);
    }
}

// Namespace audio
// Params 7, eflags: 0x1 linked
// Checksum 0xae004963, Offset: 0x3fc0
// Size: 0xe4
function weapon_butt_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self.meleed = 1;
        level.mysnd = playsound(localclientnum, "chr_melee_tinitus", (0, 0, 0));
        forceambientroom("sndHealth_Melee");
        return;
    }
    self.meleed = 0;
    forceambientroom("");
    if (isdefined(level.mysnd)) {
        stopsound(level.mysnd);
    }
}

// Namespace audio
// Params 0, eflags: 0x0
// Checksum 0x4ec4661c, Offset: 0x40b0
// Size: 0x2c
function set_sound_context_defaults() {
    wait(2);
    setsoundcontext("foley", "normal");
}

// Namespace audio
// Params 7, eflags: 0x1 linked
// Checksum 0x86915f80, Offset: 0x40e8
// Size: 0xe4
function sndmatchsnapshot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        switch (newval) {
        case 1:
            snd_set_snapshot("mpl_prematch");
            break;
        case 2:
            snd_set_snapshot("mpl_postmatch");
            break;
        case 3:
            snd_set_snapshot("mpl_endmatch");
            break;
        }
        return;
    }
    snd_set_snapshot("default");
}

// Namespace audio
// Params 7, eflags: 0x1 linked
// Checksum 0xb8467fd6, Offset: 0x41d8
// Size: 0x5c
function sndfoleycontext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setsoundcontext("foley", "normal");
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x9f8eaa81, Offset: 0x4240
// Size: 0x34
function sndkillcam() {
    level thread sndfinalkillcam_slowdown();
    level thread sndfinalkillcam_deactivate();
}

// Namespace audio
// Params 0, eflags: 0x0
// Checksum 0xf32b5731, Offset: 0x4280
// Size: 0x38
function snddeath_activate() {
    while (true) {
        level waittill(#"sndded");
        snd_set_snapshot("mpl_death");
    }
}

// Namespace audio
// Params 0, eflags: 0x0
// Checksum 0x911be21, Offset: 0x42c0
// Size: 0x38
function snddeath_deactivate() {
    while (true) {
        level waittill(#"snddede");
        snd_set_snapshot("default");
    }
}

// Namespace audio
// Params 0, eflags: 0x0
// Checksum 0x4f3e54a, Offset: 0x4300
// Size: 0x58
function sndfinalkillcam_activate() {
    while (true) {
        level waittill(#"sndfks");
        playsound(0, "mpl_final_killcam_enter", (0, 0, 0));
        snd_set_snapshot("mpl_final_killcam");
    }
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x7b44cea0, Offset: 0x4360
// Size: 0x78
function sndfinalkillcam_slowdown() {
    while (true) {
        level waittill(#"sndfksl");
        playsound(0, "mpl_final_killcam_enter", (0, 0, 0));
        playsound(0, "mpl_final_killcam_slowdown", (0, 0, 0));
        snd_set_snapshot("mpl_final_killcam_slowdown");
    }
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x15e09478, Offset: 0x43e0
// Size: 0x38
function sndfinalkillcam_deactivate() {
    while (true) {
        level waittill(#"sndfke");
        snd_set_snapshot("default");
    }
}

// Namespace audio
// Params 7, eflags: 0x1 linked
// Checksum 0x8e4ee317, Offset: 0x4420
// Size: 0x9c
function sndswitchvehiclecontext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self islocalclientdriver(localclientnum)) {
        setsoundcontext("plr_impact", "veh");
        return;
    }
    setsoundcontext("plr_impact", "");
}

// Namespace audio
// Params 0, eflags: 0x1 linked
// Checksum 0x44883a53, Offset: 0x44c8
// Size: 0x2c
function sndmusicdeathwatcher() {
    self waittill(#"death");
    soundsetmusicstate("death");
}

// Namespace audio
// Params 7, eflags: 0x1 linked
// Checksum 0xa9f834b, Offset: 0x4500
// Size: 0x1a4
function sndcchacking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        switch (newval) {
        case 1:
            playsound(0, "gdt_cybercore_hack_start_plr", (0, 0, 0));
            self.hsnd = self playloopsound("gdt_cybercore_hack_lp_plr", 0.5);
            break;
        case 2:
            playsound(0, "gdt_cybercore_prime_upg_plr", (0, 0, 0));
            self.hsnd = self playloopsound("gdt_cybercore_prime_loop_plr", 0.5);
            break;
        }
        return;
    }
    if (isdefined(self.hsnd)) {
        self stoploopsound(self.hsnd, 0.5);
    }
    if (oldval == 1) {
        playsound(0, "gdt_cybercore_hack_success_plr", (0, 0, 0));
        return;
    }
    if (oldval == 2) {
        playsound(0, "gdt_cybercore_activate_fail_plr", (0, 0, 0));
    }
}

// Namespace audio
// Params 7, eflags: 0x1 linked
// Checksum 0x629ac3f6, Offset: 0x46b0
// Size: 0x16c
function sndigcsnapshot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        switch (newval) {
        case 1:
            snd_set_snapshot("cmn_igc_bg_lower");
            level.sndigcsnapshotoverride = 0;
            break;
        case 2:
            snd_set_snapshot("cmn_igc_amb_silent");
            level.sndigcsnapshotoverride = 1;
            break;
        case 3:
            snd_set_snapshot("cmn_igc_foley_lower");
            level.sndigcsnapshotoverride = 0;
            break;
        case 4:
            snd_set_snapshot("cmn_level_fadeout");
            level.sndigcsnapshotoverride = 0;
            break;
        case 5:
            snd_set_snapshot("cmn_level_fade_immediate");
            level.sndigcsnapshotoverride = 0;
            break;
        }
        return;
    }
    level.sndigcsnapshotoverride = 0;
    snd_set_snapshot("default");
}

// Namespace audio
// Params 7, eflags: 0x1 linked
// Checksum 0x2d38d683, Offset: 0x4828
// Size: 0x74
function sndlevelstartsnapoff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!(isdefined(level.sndigcsnapshotoverride) && level.sndigcsnapshotoverride)) {
            snd_set_snapshot("default");
        }
    }
}

// Namespace audio
// Params 7, eflags: 0x1 linked
// Checksum 0x2df9160d, Offset: 0x48a8
// Size: 0x5c
function sndzmbfadein(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        snd_set_snapshot("default");
    }
}

// Namespace audio
// Params 7, eflags: 0x1 linked
// Checksum 0xcd94760e, Offset: 0x4910
// Size: 0xc4
function sndchyronloop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!isdefined(level.chyronloop)) {
            level.chyronloop = spawn(0, (0, 0, 0), "script_origin");
            level.chyronloop playloopsound("uin_chyron_loop");
        }
        return;
    }
    if (isdefined(level.chyronloop)) {
        level.chyronloop delete();
    }
}

