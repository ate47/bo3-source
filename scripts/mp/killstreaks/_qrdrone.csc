#using scripts/mp/_vehicle;
#using scripts/mp/_util;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace qrdrone;

// Namespace qrdrone
// Params 0, eflags: 0x2
// Checksum 0x51e371a1, Offset: 0x390
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("qrdrone", &__init__, undefined, undefined);
}

// Namespace qrdrone
// Params 0, eflags: 0x1 linked
// Checksum 0x7a198956, Offset: 0x3d0
// Size: 0x284
function __init__() {
    type = "qrdrone_mp";
    clientfield::register("helicopter", "qrdrone_state", 1, 3, "int", &statechange, 0, 0);
    clientfield::register("vehicle", "qrdrone_state", 1, 3, "int", &statechange, 0, 0);
    level._effect["qrdrone_enemy_light"] = "killstreaks/fx_drgnfire_light_red_3p";
    level._effect["qrdrone_friendly_light"] = "killstreaks/fx_drgnfire_light_green_3p";
    level._effect["qrdrone_viewmodel_light"] = "killstreaks/fx_drgnfire_light_green_1p";
    clientfield::register("helicopter", "qrdrone_countdown", 1, 1, "int", &start_blink, 0, 0);
    clientfield::register("helicopter", "qrdrone_timeout", 1, 1, "int", &final_blink, 0, 0);
    clientfield::register("vehicle", "qrdrone_countdown", 1, 1, "int", &start_blink, 0, 0);
    clientfield::register("vehicle", "qrdrone_timeout", 1, 1, "int", &final_blink, 0, 0);
    clientfield::register("vehicle", "qrdrone_out_of_range", 1, 1, "int", &out_of_range_update, 0, 0);
    vehicle::add_vehicletype_callback("qrdrone_mp", &spawned);
}

// Namespace qrdrone
// Params 1, eflags: 0x1 linked
// Checksum 0xfb2023b2, Offset: 0x660
// Size: 0x84
function spawned(localclientnum) {
    self util::waittill_dobj(localclientnum);
    self thread restartfx(localclientnum, 0);
    self thread collisionhandler(localclientnum);
    self thread enginestutterhandler(localclientnum);
    self thread qrdrone_watch_distance();
}

// Namespace qrdrone
// Params 7, eflags: 0x1 linked
// Checksum 0xc64af6f3, Offset: 0x6f0
// Size: 0x7c
function statechange(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self endon(#"entityshutdown");
    self util::waittill_dobj(localclientnum);
    self restartfx(localclientnum, newval);
}

// Namespace qrdrone
// Params 2, eflags: 0x1 linked
// Checksum 0xc5f2ab6c, Offset: 0x778
// Size: 0x124
function restartfx(localclientnum, blinkstage) {
    self notify(#"restart_fx");
    /#
        println("killstreaks/fx_drgnfire_light_green_3p" + blinkstage);
    #/
    switch (blinkstage) {
    case 0:
        self spawn_solid_fx(localclientnum);
        break;
    case 1:
        self.fx_interval = 1;
        self spawn_blinking_fx(localclientnum);
        break;
    case 2:
        self.fx_interval = 0.133;
        self spawn_blinking_fx(localclientnum);
        break;
    case 3:
        self notify(#"stopfx");
        self notify(#"fx_death");
        return;
    }
    self thread watchrestartfx(localclientnum);
}

// Namespace qrdrone
// Params 1, eflags: 0x1 linked
// Checksum 0x26e2652, Offset: 0x8a8
// Size: 0x7c
function watchrestartfx(localclientnum) {
    self endon(#"entityshutdown");
    level util::waittill_any("demo_jump", "player_switch", "killcam_begin", "killcam_end");
    self restartfx(localclientnum, clientfield::get("qrdrone_state"));
}

// Namespace qrdrone
// Params 1, eflags: 0x1 linked
// Checksum 0x25424073, Offset: 0x930
// Size: 0x104
function spawn_solid_fx(localclientnum) {
    if (self islocalclientdriver(localclientnum)) {
        fx_handle = playfxontag(localclientnum, level._effect["qrdrone_viewmodel_light"], self, "tag_body");
    } else if (self util::function_f36b8920(localclientnum)) {
        fx_handle = playfxontag(localclientnum, level._effect["qrdrone_friendly_light"], self, "tag_body");
    } else {
        fx_handle = playfxontag(localclientnum, level._effect["qrdrone_enemy_light"], self, "tag_body");
    }
    self thread cleanupfx(localclientnum, fx_handle);
}

// Namespace qrdrone
// Params 1, eflags: 0x1 linked
// Checksum 0xc2b54e8f, Offset: 0xa40
// Size: 0x2c
function spawn_blinking_fx(localclientnum) {
    self thread blink_fx_and_sound(localclientnum, "wpn_qr_alert");
}

// Namespace qrdrone
// Params 2, eflags: 0x1 linked
// Checksum 0x7e25afa6, Offset: 0xa78
// Size: 0x12c
function blink_fx_and_sound(localclientnum, soundalias) {
    self endon(#"entityshutdown");
    self endon(#"restart_fx");
    self endon(#"fx_death");
    if (!isdefined(self.interval)) {
        self.interval = 1;
    }
    while (true) {
        self playsound(localclientnum, soundalias);
        self spawn_solid_fx(localclientnum);
        util::server_wait(localclientnum, self.interval / 2);
        self notify(#"stopfx");
        util::server_wait(localclientnum, self.interval / 2);
        self.interval /= 1.17;
        if (self.interval < 0.1) {
            self.interval = 0.1;
        }
    }
}

// Namespace qrdrone
// Params 2, eflags: 0x1 linked
// Checksum 0x101c5e13, Offset: 0xbb0
// Size: 0x64
function cleanupfx(localclientnum, handle) {
    self util::waittill_any("entityshutdown", "blink", "stopfx", "restart_fx");
    stopfx(localclientnum, handle);
}

// Namespace qrdrone
// Params 7, eflags: 0x1 linked
// Checksum 0x85c5bc61, Offset: 0xc20
// Size: 0x52
function start_blink(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self notify(#"blink");
}

// Namespace qrdrone
// Params 7, eflags: 0x1 linked
// Checksum 0x7ad3dbf6, Offset: 0xc80
// Size: 0x58
function final_blink(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (!newval) {
        return;
    }
    self.interval = 0.133;
}

// Namespace qrdrone
// Params 7, eflags: 0x1 linked
// Checksum 0xb067c9c9, Offset: 0xce0
// Size: 0x9c
function out_of_range_update(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    model = getuimodel(getuimodelforcontroller(localclientnum), "vehicle.outOfRange");
    if (isdefined(model)) {
        setuimodelvalue(model, newval);
    }
}

// Namespace qrdrone
// Params 4, eflags: 0x1 linked
// Checksum 0xe7160056, Offset: 0xd88
// Size: 0x144
function loop_local_sound(localclientnum, alias, interval, fx) {
    self endon(#"entityshutdown");
    self endon(#"stopfx");
    level endon(#"demo_jump");
    level endon(#"player_switch");
    if (!isdefined(self.interval)) {
        self.interval = interval;
    }
    while (true) {
        self playsound(localclientnum, alias);
        self spawn_solid_fx(localclientnum);
        util::server_wait(localclientnum, self.interval / 2);
        self notify(#"stopfx");
        util::server_wait(localclientnum, self.interval / 2);
        self.interval /= 1.17;
        if (self.interval < 0.1) {
            self.interval = 0.1;
        }
    }
}

// Namespace qrdrone
// Params 1, eflags: 0x1 linked
// Checksum 0xa3b6eeb2, Offset: 0xed8
// Size: 0xec
function check_for_player_switch_or_time_jump(localclientnum) {
    self endon(#"entityshutdown");
    level util::waittill_any("demo_jump", "player_switch", "killcam_begin");
    self notify(#"stopfx");
    waittillframeend();
    self thread blink_light(localclientnum);
    if (isdefined(self.blinkstarttime) && self.blinkstarttime <= level.servertime) {
        self.interval = 1;
        self thread start_blink(localclientnum, 1);
    } else {
        self spawn_solid_fx(localclientnum);
    }
    self thread check_for_player_switch_or_time_jump(localclientnum);
}

// Namespace qrdrone
// Params 1, eflags: 0x1 linked
// Checksum 0xe6e462c8, Offset: 0xfd0
// Size: 0x144
function blink_light(localclientnum) {
    self endon(#"entityshutdown");
    level endon(#"demo_jump");
    level endon(#"player_switch");
    level endon(#"killcam_begin");
    self waittill(#"blink");
    if (!isdefined(self.blinkstarttime)) {
        self.blinkstarttime = level.servertime;
    }
    if (self islocalclientdriver(localclientnum)) {
        self thread loop_local_sound(localclientnum, "wpn_qr_alert", 1, level._effect["qrdrone_viewmodel_light"]);
        return;
    }
    if (self util::function_f36b8920(localclientnum)) {
        self thread loop_local_sound(localclientnum, "wpn_qr_alert", 1, level._effect["qrdrone_friendly_light"]);
        return;
    }
    self thread loop_local_sound(localclientnum, "wpn_qr_alert", 1, level._effect["qrdrone_enemy_light"]);
}

// Namespace qrdrone
// Params 1, eflags: 0x1 linked
// Checksum 0xf0feac6e, Offset: 0x1120
// Size: 0x108
function collisionhandler(localclientnum) {
    self endon(#"entityshutdown");
    while (true) {
        hip, hitn, hit_intensity = self waittill(#"veh_collision");
        driver_local_client = self getlocalclientdriver();
        if (isdefined(driver_local_client)) {
            player = getlocalplayer(driver_local_client);
            if (isdefined(player)) {
                if (hit_intensity > 15) {
                    player playrumbleonentity(driver_local_client, "damage_heavy");
                    continue;
                }
                player playrumbleonentity(driver_local_client, "damage_light");
            }
        }
    }
}

// Namespace qrdrone
// Params 1, eflags: 0x1 linked
// Checksum 0x4ad9bfe8, Offset: 0x1230
// Size: 0x98
function enginestutterhandler(localclientnum) {
    self endon(#"entityshutdown");
    while (true) {
        self waittill(#"veh_engine_stutter");
        if (self islocalclientdriver(localclientnum)) {
            player = getlocalplayer(localclientnum);
            if (isdefined(player)) {
                player playrumbleonentity(localclientnum, "rcbomb_engine_stutter");
            }
        }
    }
}

// Namespace qrdrone
// Params 0, eflags: 0x1 linked
// Checksum 0x6b7a9d62, Offset: 0x12d0
// Size: 0x126
function getminimumflyheight() {
    if (!isdefined(level.airsupportheightscale)) {
        level.airsupportheightscale = 1;
    }
    airsupport_height = struct::get("air_support_height", "targetname");
    if (isdefined(airsupport_height)) {
        planeflyheight = airsupport_height.origin[2];
    } else {
        /#
            println("killstreaks/fx_drgnfire_light_green_3p");
        #/
        planeflyheight = 850;
        if (isdefined(level.airsupportheightscale)) {
            level.airsupportheightscale = getdvarint("scr_airsupportHeightScale", level.airsupportheightscale);
            planeflyheight *= getdvarint("scr_airsupportHeightScale", level.airsupportheightscale);
        }
        if (isdefined(level.forceairsupportmapheight)) {
            planeflyheight += level.forceairsupportmapheight;
        }
    }
    return planeflyheight;
}

// Namespace qrdrone
// Params 0, eflags: 0x1 linked
// Checksum 0x6e6ce98, Offset: 0x1400
// Size: 0x2d4
function qrdrone_watch_distance() {
    self endon(#"entityshutdown");
    qrdrone_height = struct::get("qrdrone_height", "targetname");
    if (isdefined(qrdrone_height)) {
        self.maxheight = qrdrone_height.origin[2];
    } else {
        self.maxheight = int(getminimumflyheight());
    }
    self.maxdistance = 12800;
    level.mapcenter = getmapcenter();
    self.minheight = level.mapcenter[2] - 800;
    inrangepos = self.origin;
    soundent = spawn(0, self.origin, "script_origin");
    soundent linkto(self);
    self thread qrdrone_staticstopondeath(soundent);
    while (true) {
        if (!self qrdrone_in_range()) {
            staticalpha = 0;
            while (!self qrdrone_in_range()) {
                if (isdefined(self.heliinproximity)) {
                    dist = distance(self.origin, self.heliinproximity.origin);
                    staticalpha = 1 - (dist - -106) / -106;
                } else {
                    dist = distance(self.origin, inrangepos);
                    staticalpha = min(1, dist / -56);
                }
                sid = soundent playloopsound("veh_qrdrone_static_lp", 0.2);
                self vehicle::set_static_amount(staticalpha * 2);
                wait(0.05);
            }
            self thread qrdrone_staticfade(staticalpha, soundent, sid);
        }
        inrangepos = self.origin;
        wait(0.05);
    }
}

// Namespace qrdrone
// Params 0, eflags: 0x1 linked
// Checksum 0x5856028a, Offset: 0x16e0
// Size: 0x56
function qrdrone_in_range() {
    if (self.origin[2] < self.maxheight && self.origin[2] > self.minheight) {
        if (self isinsideheightlock()) {
            return true;
        }
    }
    return false;
}

// Namespace qrdrone
// Params 3, eflags: 0x1 linked
// Checksum 0xb2debde, Offset: 0x1740
// Size: 0xf8
function qrdrone_staticfade(staticalpha, sndent, sid) {
    self endon(#"entityshutdown");
    while (self qrdrone_in_range()) {
        staticalpha -= 0.05;
        if (staticalpha <= 0) {
            sndent stopallloopsounds(0.5);
            self vehicle::set_static_amount(0);
            break;
        }
        setsoundvolumerate(sid, 0.6);
        setsoundvolume(sid, staticalpha);
        self vehicle::set_static_amount(staticalpha * 2);
        wait(0.05);
    }
}

// Namespace qrdrone
// Params 1, eflags: 0x1 linked
// Checksum 0x37caa1c4, Offset: 0x1840
// Size: 0x4c
function qrdrone_staticstopondeath(sndent) {
    self waittill(#"entityshutdown");
    sndent stopallloopsounds(0.1);
    sndent delete();
}

