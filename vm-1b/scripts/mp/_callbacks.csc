#using scripts/mp/_callbacks;
#using scripts/mp/_util;
#using scripts/mp/_vehicle;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_actor;
#using scripts/mp/killstreaks/_ai_tank;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_helicopter;
#using scripts/mp/killstreaks/_qrdrone;
#using scripts/mp/killstreaks/_rcbomb;
#using scripts/shared/_burnplayer;
#using scripts/shared/abilities/gadgets/_gadget_vision_pulse;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/footsteps_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_driving_fx;
#using scripts/shared/weapons/_sticky_grenade;

#namespace callback;

// Namespace callback
// Params 0, eflags: 0x2
// Checksum 0x3c52c29b, Offset: 0x448
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("callback", &__init__, undefined, undefined);
}

// Namespace callback
// Params 0, eflags: 0x0
// Checksum 0x11021133, Offset: 0x480
// Size: 0x12
function __init__() {
    level thread set_default_callbacks();
}

// Namespace callback
// Params 0, eflags: 0x0
// Checksum 0x1c6fcfac, Offset: 0x4a0
// Size: 0xda
function set_default_callbacks() {
    level.callbackplayerspawned = &playerspawned;
    level.callbacklocalclientconnect = &localclientconnect;
    level.callbackcreatingcorpse = &creating_corpse;
    level.callbackentityspawned = &entityspawned;
    level.callbackairsupport = &airsupport;
    level.callbackplayaifootstep = &footsteps::playaifootstep;
    level.var_7bf94c43 = &exploder::playlightloopexploder;
    level._custom_weapon_cb_func = &spawned_weapon_type;
    level.gadgetvisionpulse_reveal_func = &gadget_vision_pulse::gadget_visionpulse_reveal;
}

// Namespace callback
// Params 1, eflags: 0x0
// Checksum 0x217b97da, Offset: 0x588
// Size: 0x5a
function localclientconnect(localclientnum) {
    println("<dev string:x28>" + localclientnum);
    if (isdefined(level.charactercustomizationsetup)) {
        [[ level.charactercustomizationsetup ]](localclientnum);
    }
    callback(#"hash_da8d7d74", localclientnum);
}

// Namespace callback
// Params 1, eflags: 0x0
// Checksum 0xa71d79dc, Offset: 0x5f0
// Size: 0xd2
function playerspawned(localclientnum) {
    self endon(#"entityshutdown");
    self notify(#"playerspawned_callback");
    self endon(#"playerspawned_callback");
    player = getlocalplayer(localclientnum);
    if (isdefined(level.infraredvisionset)) {
        player setinfraredvisionset(level.infraredvisionset);
    }
    if (isdefined(level._playerspawned_override)) {
        self thread [[ level._playerspawned_override ]](localclientnum);
        return;
    }
    println("<dev string:x55>");
    if (self islocalplayer()) {
        callback(#"hash_842e788a", localclientnum);
    }
    callback(#"hash_bc12b61f", localclientnum);
}

// Namespace callback
// Params 1, eflags: 0x0
// Checksum 0xe574ccd9, Offset: 0x6d0
// Size: 0x1f0
function entityspawned(localclientnum) {
    self endon(#"entityshutdown");
    if (self isplayer()) {
        if (isdefined(level._clientfaceanimonplayerspawned)) {
            self thread [[ level._clientfaceanimonplayerspawned ]](localclientnum);
        }
    }
    if (isdefined(level._entityspawned_override)) {
        self thread [[ level._entityspawned_override ]](localclientnum);
        return;
    }
    if (!isdefined(self.type)) {
        println("<dev string:x64>");
        return;
    }
    if (self.type == "missile") {
        if (isdefined(level._custom_weapon_cb_func)) {
            self thread [[ level._custom_weapon_cb_func ]](localclientnum);
        }
    } else if (self.type == "vehicle" || self.type == "helicopter" || self.type == "plane") {
        if (isdefined(level._customvehiclecbfunc)) {
            self thread [[ level._customvehiclecbfunc ]](localclientnum);
        }
        self thread vehicle::field_toggle_exhaustfx_handler(localclientnum, undefined, 0, 1);
        self thread vehicle::field_toggle_lights_handler(localclientnum, undefined, 0, 1);
        if (self.type == "plane" || self.type == "helicopter") {
            self thread vehicle::aircraft_dustkick();
        } else {
            self thread driving_fx::function_789b5418(localclientnum);
            self thread vehicle::vehicle_rumble(localclientnum);
        }
        if (self.type == "helicopter") {
            self thread helicopter::startfx_loop(localclientnum);
        }
    }
    if (self.type == "actor") {
        if (isdefined(level._customactorcbfunc)) {
            self thread [[ level._customactorcbfunc ]](localclientnum);
        }
    }
}

// Namespace callback
// Params 12, eflags: 0x0
// Checksum 0xf97fbdf4, Offset: 0x8c8
// Size: 0x48b
function airsupport(localclientnum, x, y, z, type, yaw, team, teamfaction, owner, exittype, time, height) {
    pos = (x, y, z);
    switch (teamfaction) {
    case "v":
        teamfaction = "vietcong";
        break;
    case "n":
    case "nva":
        teamfaction = "nva";
        break;
    case "j":
        teamfaction = "japanese";
        break;
    case "m":
        teamfaction = "marines";
        break;
    case "s":
        teamfaction = "specops";
        break;
    case "r":
        teamfaction = "russian";
        break;
    default:
        println("<dev string:x7b>");
        println("<dev string:xb5>" + teamfaction + "<dev string:xcc>");
        teamfaction = "marines";
        break;
    }
    switch (team) {
    case "x":
        team = "axis";
        break;
    case "l":
        team = "allies";
        break;
    case "r":
        team = "free";
        break;
    default:
        println("<dev string:xce>" + team + "<dev string:xcc>");
        team = "allies";
        break;
    }
    data = spawnstruct();
    data.team = team;
    data.owner = owner;
    data.bombsite = pos;
    data.yaw = yaw;
    direction = (0, yaw, 0);
    data.direction = direction;
    data.flyheight = height;
    if (type == "a") {
        planehalfdistance = 12000;
        data.planehalfdistance = planehalfdistance;
        data.startpoint = pos + vectorscale(anglestoforward(direction), -1 * planehalfdistance);
        data.endpoint = pos + vectorscale(anglestoforward(direction), planehalfdistance);
        data.planemodel = "t5_veh_air_b52";
        data.flybysound = "null";
        data.washsound = "veh_b52_flyby_wash";
        data.apextime = 6145;
        data.exittype = -1;
        data.flyspeed = 2000;
        data.flytime = planehalfdistance * 2 / data.flyspeed;
        planetype = "airstrike";
        return;
    }
    if (type == "n") {
        planehalfdistance = 24000;
        data.planehalfdistance = planehalfdistance;
        data.startpoint = pos + vectorscale(anglestoforward(direction), -1 * planehalfdistance);
        data.endpoint = pos + vectorscale(anglestoforward(direction), planehalfdistance);
        data.planemodel = airsupport::getplanemodel(teamfaction);
        data.flybysound = "null";
        data.washsound = "evt_us_napalm_wash";
        data.apextime = 2362;
        data.exittype = exittype;
        data.flyspeed = 7000;
        data.flytime = planehalfdistance * 2 / data.flyspeed;
        planetype = "napalm";
        return;
    }
    /#
        println("<dev string:x101>");
        println("<dev string:x102>");
        println(type);
        println("<dev string:x101>");
    #/
    return;
}

// Namespace callback
// Params 2, eflags: 0x0
// Checksum 0xce594b81, Offset: 0xd60
// Size: 0x12
function creating_corpse(localclientnum, player) {
    
}

// Namespace callback
// Params 7, eflags: 0x0
// Checksum 0xf743b33f, Offset: 0xd80
// Size: 0x73
function callback_stunned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.stunned = newval;
    println("<dev string:x149>");
    if (newval) {
        self notify(#"stunned");
        return;
    }
    self notify(#"not_stunned");
}

// Namespace callback
// Params 7, eflags: 0x0
// Checksum 0x3d9bc909, Offset: 0xe00
// Size: 0x73
function callback_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.emp = newval;
    println("<dev string:x15a>");
    if (newval) {
        self notify(#"emp");
        return;
    }
    self notify(#"not_emp");
}

// Namespace callback
// Params 7, eflags: 0x0
// Checksum 0xf797f0a4, Offset: 0xe80
// Size: 0x42
function callback_proximity(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.enemyinproximity = newval;
}

