#using scripts/cp/_oed;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/util_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_acd01c5c;

// Namespace namespace_acd01c5c
// Params 0, eflags: 0x1 linked
// Checksum 0x63fc07cc, Offset: 0x420
// Size: 0x40
function init() {
    init_clientfields();
    callback::on_spawned(&on_player_spawned);
    level.var_19eb3de5 = [];
}

// Namespace namespace_acd01c5c
// Params 0, eflags: 0x1 linked
// Checksum 0xb660d2ba, Offset: 0x468
// Size: 0x24c
function init_clientfields() {
    clientfield::register("toplayer", "hijack_vehicle_transition", 1, 2, "int", &function_214501b2, 0, 0);
    clientfield::register("toplayer", "hijack_static_effect", 1, 7, "float", &function_25525279, 0, 0);
    clientfield::register("toplayer", "sndInDrivableVehicle", 1, 1, "int", &sndInDrivableVehicle, 0, 0);
    clientfield::register("vehicle", "vehicle_hijacked", 1, 1, "int", &function_9eb354f0, 0, 0);
    clientfield::register("toplayer", "vehicle_hijacked", 1, 1, "int", &player_hijacked_vehicle, 0, 0);
    clientfield::register("toplayer", "hijack_spectate", 1, 1, "int", &function_5684f6e8, 0, 0);
    clientfield::register("toplayer", "hijack_static_ramp_up", 1, 1, "int", &function_8e1516cf, 0, 0);
    visionset_mgr::register_visionset_info("hijack_vehicle", 1, 7, undefined, "vehicle_transition");
    visionset_mgr::register_visionset_info("hijack_vehicle_blur", 1, 7, undefined, "vehicle_hijack_blur");
}

// Namespace namespace_acd01c5c
// Params 1, eflags: 0x1 linked
// Checksum 0x8632c858, Offset: 0x6c0
// Size: 0x6c
function on_player_spawned(localclientnum) {
    player = getlocalplayer(localclientnum);
    if (player getentitynumber() == self getentitynumber()) {
        filter::init_filter_vehicle_hijack_oor(self);
    }
}

// Namespace namespace_acd01c5c
// Params 2, eflags: 0x1 linked
// Checksum 0x5d916ab1, Offset: 0x738
// Size: 0x18c
function spectate(localclientnum, delta_time) {
    player = getlocalplayer(localclientnum);
    if (!isdefined(player)) {
        return;
    }
    if (!player isplayer()) {
        return;
    }
    if (!isalive(player)) {
        return;
    }
    if (isdefined(player.sessionstate)) {
        if (player.sessionstate == "spectator") {
            return;
        }
        if (player.sessionstate == "intermission") {
            return;
        }
    }
    if (isdefined(player.var_fbad6cb4)) {
        player camerasetposition(player.var_fbad6cb4);
    }
    ang = player getcamangles();
    if (isdefined(player.var_f28a7256)) {
        ang = player.var_f28a7256;
    }
    if (isdefined(ang)) {
        ang = (ang[0], ang[1], 0);
        player camerasetlookat(ang);
    }
}

// Namespace namespace_acd01c5c
// Params 7, eflags: 0x1 linked
// Checksum 0xb623bafe, Offset: 0x8d0
// Size: 0x19e
function function_8e1516cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        var_9667361 = isdefined(self.var_c86abfbb) ? self.var_c86abfbb : 0;
        if (!(isdefined(self.var_8bb3e1f5) && self.var_8bb3e1f5)) {
            filter::enable_filter_vehicle_hijack_oor(self, 0);
            self.var_8bb3e1f5 = 1;
        }
        timestart = gettime();
        timeend = timestart + 3000;
        var_e48333a4 = timestart;
        playsound(localclientnum, "gdt_securitybreach_static_oneshot", (0, 0, 0));
        while (var_e48333a4 < timeend) {
            var_e48333a4 = gettime();
            var_303b5d2b = math::linear_map(var_e48333a4, timestart, timeend, var_9667361, 1);
            filter::set_filter_vehicle_hijack_oor_amount(self, 0, var_303b5d2b);
            wait 0.01;
        }
        return;
    }
    filter::disable_filter_vehicle_hijack_oor(self, 0);
    self.var_8bb3e1f5 = undefined;
}

// Namespace namespace_acd01c5c
// Params 7, eflags: 0x1 linked
// Checksum 0x11321535, Offset: 0xa78
// Size: 0x9e
function function_5684f6e8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"hash_ccf4fc20");
    if (newval) {
        self camerasetupdatecallback(&spectate);
        return;
    }
    self camerasetupdatecallback();
    self.var_fbad6cb4 = undefined;
    self.var_f28a7256 = undefined;
}

// Namespace namespace_acd01c5c
// Params 1, eflags: 0x1 linked
// Checksum 0xd54c9e55, Offset: 0xb20
// Size: 0xa8
function function_49ec9e85(vehicle) {
    self endon(#"hash_ccf4fc20");
    self endon(#"disconnect");
    self endon(#"spawn");
    self endon(#"entityshutdown");
    vehicle endon(#"entityshutdown");
    while (isalive(vehicle)) {
        self.var_fbad6cb4 = self getcampos();
        self.var_f28a7256 = self getcamangles();
        wait 0.01;
    }
}

// Namespace namespace_acd01c5c
// Params 7, eflags: 0x1 linked
// Checksum 0x4b3b418e, Offset: 0xbd0
// Size: 0xbc
function player_hijacked_vehicle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self tmodeenable(0);
        self oed::function_3b4d6db0(localclientnum);
        return;
    }
    if (isdefined(self.var_8b70667f) && self.var_8b70667f) {
        self tmodeenable(1);
        self oed::function_165838aa(localclientnum);
    }
}

// Namespace namespace_acd01c5c
// Params 7, eflags: 0x1 linked
// Checksum 0x2d1abcd6, Offset: 0xc98
// Size: 0x94
function function_9eb354f0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self islocalclientdriver(localclientnum)) {
        player = getlocalplayer(localclientnum);
        player thread function_49ec9e85(self);
    }
}

// Namespace namespace_acd01c5c
// Params 7, eflags: 0x1 linked
// Checksum 0x1ec02487, Offset: 0xd38
// Size: 0x104
function function_25525279(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != 0) {
        self.var_c86abfbb = newval;
        if (!(isdefined(self.var_8bb3e1f5) && self.var_8bb3e1f5)) {
            filter::enable_filter_vehicle_hijack_oor(self, 0);
            self.var_8bb3e1f5 = 1;
        }
        filter::set_filter_vehicle_hijack_oor_amount(self, 0, newval);
    }
    if (isdefined(self.var_8bb3e1f5) && self.var_8bb3e1f5 && newval == 0) {
        filter::disable_filter_vehicle_hijack_oor(self, 0);
        self.var_8bb3e1f5 = undefined;
    }
    self thread function_748fddf7(newval);
}

// Namespace namespace_acd01c5c
// Params 1, eflags: 0x1 linked
// Checksum 0x810cc1d, Offset: 0xe48
// Size: 0xfc
function function_748fddf7(val) {
    if (!isdefined(level.var_924ad306)) {
        level.var_924ad306 = spawn(0, self.origin, "script_origin");
        level.var_924ad306 linkto(self);
    }
    if (val == 0) {
        level.var_924ad306 delete();
        level.var_924ad306 = undefined;
        return;
    }
    sid = level.var_924ad306 playloopsound("gdt_securitybreach_static_interference", 1);
    if (isdefined(sid)) {
        setsoundvolume(sid, val);
        setsoundvolumerate(sid, 1);
    }
}

// Namespace namespace_acd01c5c
// Params 7, eflags: 0x1 linked
// Checksum 0x9f8e75b9, Offset: 0xf50
// Size: 0xe6
function sndInDrivableVehicle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        if (!isdefined(level.var_9ddb7247)) {
            level.var_9ddb7247 = spawn(0, self.origin, "script_origin");
            level.var_9ddb7247 linkto(self);
            level.var_9ddb7247 playloopsound("gdt_securitybreach_silence");
        }
        return;
    }
    level.var_9ddb7247 delete();
    level.var_9ddb7247 = undefined;
}

// Namespace namespace_acd01c5c
// Params 7, eflags: 0x1 linked
// Checksum 0x76a1676d, Offset: 0x1040
// Size: 0x126
function function_214501b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 2:
        self thread postfx::playpostfxbundle("pstfx_vehicle_takeover_fade_in");
        playsound(0, "gdt_securitybreach_transition_in", (0, 0, 0));
        break;
    case 3:
        self thread postfx::playpostfxbundle("pstfx_vehicle_takeover_fade_out");
        playsound(0, "gdt_securitybreach_transition_out", (0, 0, 0));
        break;
    case 1:
        self thread postfx::stoppostfxbundle();
        break;
    case 4:
        self thread postfx::playpostfxbundle("pstfx_vehicle_takeover_white");
        break;
    }
}

