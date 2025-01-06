#using scripts/mp/_util;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_tacticalinsertion;

#namespace spawning;

// Namespace spawning
// Params 0, eflags: 0x2
// Checksum 0x60399b8c, Offset: 0x2e0
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("perks", &__init__, undefined, undefined);
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xc8240446, Offset: 0x318
// Size: 0x6a
function __init__() {
    clientfield::register("allplayers", "flying", 1, 1, "int");
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0x40f64af2, Offset: 0x390
// Size: 0xa
function on_player_connect(local_client_num) {
    
}

// Namespace spawning
// Params 1, eflags: 0x0
// Checksum 0xe8189559, Offset: 0x3a8
// Size: 0x3a
function on_player_spawned(local_client_num) {
    self thread monitorgpsjammer();
    self thread monitorsengrenjammer();
    self thread monitorflight();
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xbef7af07, Offset: 0x3f0
// Size: 0x75
function monitorflight() {
    self endon(#"death");
    self endon(#"disconnect");
    self.flying = 0;
    while (isdefined(self)) {
        flying = !self isonground();
        if (self.flying != flying) {
            self clientfield::set("flying", flying);
            self.flying = flying;
        }
        wait 0.05;
    }
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0xa765f4e7, Offset: 0x470
// Size: 0x419
function monitorgpsjammer() {
    self endon(#"death");
    self endon(#"disconnect");
    require_perk = 1;
    /#
        require_perk = 0;
    #/
    if (require_perk && self hasperk("specialty_gpsjammer") == 0) {
        return;
    }
    self clientfield::set("gps_jammer_active", self hasperk("specialty_gpsjammer") ? 1 : 0);
    graceperiods = getdvarint("perk_gpsjammer_graceperiods", 4);
    minspeed = getdvarint("perk_gpsjammer_min_speed", 100);
    mindistance = getdvarint("perk_gpsjammer_min_distance", 10);
    timeperiod = getdvarint("perk_gpsjammer_time_period", -56);
    timeperiodsec = timeperiod / 1000;
    minspeedsq = minspeed * minspeed;
    mindistancesq = mindistance * mindistance;
    if (minspeedsq == 0) {
        return;
    }
    assert(timeperiodsec >= 0.05);
    if (timeperiodsec < 0.05) {
        return;
    }
    hasperk = 1;
    statechange = 0;
    faileddistancecheck = 0;
    currentfailcount = 0;
    timepassed = 0;
    timesincedistancecheck = 0;
    previousorigin = self.origin;
    gpsjammerprotection = 0;
    while (true) {
        /#
            graceperiods = getdvarint("<dev string:x28>", graceperiods);
            minspeed = getdvarint("<dev string:x44>", minspeed);
            mindistance = getdvarint("<dev string:x5d>", mindistance);
            timeperiod = getdvarint("<dev string:x79>", timeperiod);
            timeperiodsec = timeperiod / 1000;
            minspeedsq = minspeed * minspeed;
            mindistancesq = mindistance * mindistance;
        #/
        gpsjammerprotection = 0;
        if (isdefined(self.isdefusing) && (isdefined(self.isplanting) && (util::isusingremote() || self.isplanting) || self.isdefusing)) {
            gpsjammerprotection = 1;
        } else {
            if (timesincedistancecheck > 1) {
                timesincedistancecheck = 0;
                if (distancesquared(previousorigin, self.origin) < mindistancesq) {
                    faileddistancecheck = 1;
                } else {
                    faileddistancecheck = 0;
                }
                previousorigin = self.origin;
            }
            velocity = self getvelocity();
            speedsq = lengthsquared(velocity);
            if (speedsq > minspeedsq && faileddistancecheck == 0) {
                gpsjammerprotection = 1;
            }
        }
        if (gpsjammerprotection == 1 && self hasperk("specialty_gpsjammer")) {
            /#
                if (getdvarint("<dev string:x94>") != 0) {
                    sphere(self.origin + (0, 0, 70), 12, (0, 0, 1), 1, 1, 16, 3);
                }
            #/
            currentfailcount = 0;
            if (hasperk == 0) {
                statechange = 0;
                hasperk = 1;
                self clientfield::set("gps_jammer_active", 1);
            }
        } else {
            currentfailcount++;
            if (hasperk == 1 && currentfailcount >= graceperiods) {
                statechange = 1;
                hasperk = 0;
                self clientfield::set("gps_jammer_active", 0);
            }
        }
        if (statechange == 1) {
            level notify(#"radar_status_change");
        }
        timesincedistancecheck += timeperiodsec;
        wait timeperiodsec;
    }
}

// Namespace spawning
// Params 0, eflags: 0x0
// Checksum 0x3ab9a7b9, Offset: 0x898
// Size: 0x419
function monitorsengrenjammer() {
    self endon(#"death");
    self endon(#"disconnect");
    require_perk = 1;
    /#
        require_perk = 0;
    #/
    if (require_perk && self hasperk("specialty_sengrenjammer") == 0) {
        return;
    }
    self clientfield::set("sg_jammer_active", self hasperk("specialty_sengrenjammer") ? 1 : 0);
    graceperiods = getdvarint("perk_sgjammer_graceperiods", 4);
    minspeed = getdvarint("perk_sgjammer_min_speed", 100);
    mindistance = getdvarint("perk_sgjammer_min_distance", 10);
    timeperiod = getdvarint("perk_sgjammer_time_period", -56);
    timeperiodsec = timeperiod / 1000;
    minspeedsq = minspeed * minspeed;
    mindistancesq = mindistance * mindistance;
    if (minspeedsq == 0) {
        return;
    }
    assert(timeperiodsec >= 0.05);
    if (timeperiodsec < 0.05) {
        return;
    }
    hasperk = 1;
    statechange = 0;
    faileddistancecheck = 0;
    currentfailcount = 0;
    timepassed = 0;
    timesincedistancecheck = 0;
    previousorigin = self.origin;
    sgjammerprotection = 0;
    while (true) {
        /#
            graceperiods = getdvarint("<dev string:xad>", graceperiods);
            minspeed = getdvarint("<dev string:xc8>", minspeed);
            mindistance = getdvarint("<dev string:xe0>", mindistance);
            timeperiod = getdvarint("<dev string:xfb>", timeperiod);
            timeperiodsec = timeperiod / 1000;
            minspeedsq = minspeed * minspeed;
            mindistancesq = mindistance * mindistance;
        #/
        sgjammerprotection = 0;
        if (isdefined(self.isdefusing) && (isdefined(self.isplanting) && (util::isusingremote() || self.isplanting) || self.isdefusing)) {
            sgjammerprotection = 1;
        } else {
            if (timesincedistancecheck > 1) {
                timesincedistancecheck = 0;
                if (distancesquared(previousorigin, self.origin) < mindistancesq) {
                    faileddistancecheck = 1;
                } else {
                    faileddistancecheck = 0;
                }
                previousorigin = self.origin;
            }
            velocity = self getvelocity();
            speedsq = lengthsquared(velocity);
            if (speedsq > minspeedsq && faileddistancecheck == 0) {
                sgjammerprotection = 1;
            }
        }
        if (sgjammerprotection == 1 && self hasperk("specialty_sengrenjammer")) {
            /#
                if (getdvarint("<dev string:x115>") != 0) {
                    sphere(self.origin + (0, 0, 65), 12, (0, 1, 0), 1, 1, 16, 3);
                }
            #/
            currentfailcount = 0;
            if (hasperk == 0) {
                statechange = 0;
                hasperk = 1;
                self clientfield::set("sg_jammer_active", 1);
            }
        } else {
            currentfailcount++;
            if (hasperk == 1 && currentfailcount >= graceperiods) {
                statechange = 1;
                hasperk = 0;
                self clientfield::set("sg_jammer_active", 0);
            }
        }
        if (statechange == 1) {
            level notify(#"radar_status_change");
        }
        timesincedistancecheck += timeperiodsec;
        wait timeperiodsec;
    }
}

