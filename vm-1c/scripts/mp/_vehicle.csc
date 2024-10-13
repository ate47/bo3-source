#using scripts/mp/killstreaks/_rcbomb;
#using scripts/mp/killstreaks/_qrdrone;
#using scripts/mp/killstreaks/_ai_tank;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/clientfield_shared;

#namespace vehicle;

// Namespace vehicle
// Params 0, eflags: 0x2
// Checksum 0xe710735f, Offset: 0x198
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("vehicle", &__init__, undefined, undefined);
}

// Namespace vehicle
// Params 0, eflags: 0x1 linked
// Checksum 0xe76df173, Offset: 0x1d8
// Size: 0x6c
function __init__() {
    if (!isdefined(level._effect)) {
        level._effect = [];
    }
    level.vehicles_inited = 1;
    clientfield::register("vehicle", "timeout_beep", 1, 2, "int", &timeout_beep, 0, 0);
}

// Namespace vehicle
// Params 1, eflags: 0x1 linked
// Checksum 0x2dd0f302, Offset: 0x250
// Size: 0x3a0
function vehicle_rumble(localclientnum) {
    self endon(#"entityshutdown");
    if (!isdefined(level.vehicle_rumble)) {
        return;
    }
    type = self.vehicletype;
    if (!isdefined(level.vehicle_rumble[type])) {
        return;
    }
    rumblestruct = level.vehicle_rumble[type];
    height = rumblestruct.radius * 2;
    zoffset = -1 * rumblestruct.radius;
    if (!isdefined(self.rumbleon)) {
        self.rumbleon = 1;
    }
    if (isdefined(rumblestruct.scale)) {
        self.rumble_scale = rumblestruct.scale;
    } else {
        self.rumble_scale = 0.15;
    }
    if (isdefined(rumblestruct.duration)) {
        self.rumble_duration = rumblestruct.duration;
    } else {
        self.rumble_duration = 4.5;
    }
    if (isdefined(rumblestruct.radius)) {
        self.rumble_radius = rumblestruct.radius;
    } else {
        self.rumble_radius = 600;
    }
    if (isdefined(rumblestruct.basetime)) {
        self.rumble_basetime = rumblestruct.basetime;
    } else {
        self.rumble_basetime = 1;
    }
    if (isdefined(rumblestruct.randomaditionaltime)) {
        self.rumble_randomaditionaltime = rumblestruct.randomaditionaltime;
    } else {
        self.rumble_randomaditionaltime = 1;
    }
    self.player_touching = 0;
    radius_squared = rumblestruct.radius * rumblestruct.radius;
    while (true) {
        if (distancesquared(self.origin, level.localplayers[localclientnum].origin) > radius_squared || self getspeed() < 35) {
            wait 0.2;
            continue;
        }
        if (isdefined(self.rumbleon) && !self.rumbleon) {
            wait 0.2;
            continue;
        }
        self playrumblelooponentity(localclientnum, level.vehicle_rumble[type].rumble);
        while (distancesquared(self.origin, level.localplayers[localclientnum].origin) < radius_squared && self getspeed() > 5) {
            wait self.rumble_basetime + randomfloat(self.rumble_randomaditionaltime);
        }
        self stoprumble(localclientnum, level.vehicle_rumble[type].rumble);
    }
}

// Namespace vehicle
// Params 1, eflags: 0x1 linked
// Checksum 0x2d473c90, Offset: 0x5f8
// Size: 0x94
function set_static_amount(staticamount) {
    driverlocalclient = self getlocalclientdriver();
    if (isdefined(driverlocalclient)) {
        driver = getlocalplayer(driverlocalclient);
        if (isdefined(driver)) {
            setfilterpassconstant(driver.localclientnum, 4, 0, 1, staticamount);
        }
    }
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x69678ae2, Offset: 0x698
// Size: 0xc
function vehicle_variants(localclientnum) {
    
}

// Namespace vehicle
// Params 7, eflags: 0x1 linked
// Checksum 0x9c8d31e5, Offset: 0x6b0
// Size: 0x19c
function timeout_beep(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self notify(#"timeout_beep");
    if (!newval) {
        return;
    }
    if (isdefined(self.killstreakbundle)) {
        beepalias = self.killstreakbundle.kstimeoutbeepalias;
    }
    self endon(#"entityshutdown");
    self endon(#"timeout_beep");
    interval = 1;
    if (newval == 2) {
    }
    for (interval = 0.133; true; interval = math::clamp(interval / 1.17, 0.1, 1)) {
        if (isdefined(beepalias)) {
            self playsound(localclientnum, beepalias);
        }
        if (self.timeoutlightsoff === 1) {
            self lights_on(localclientnum);
            self.timeoutlightsoff = 0;
        } else {
            self lights_off(localclientnum);
            self.timeoutlightsoff = 1;
        }
        util::server_wait(localclientnum, interval);
    }
}

