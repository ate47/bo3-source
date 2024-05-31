#using scripts/mp/gametypes/_globallogic_actor;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/_vehicle;
#using scripts/mp/_util;
#using scripts/mp/_callbacks;
#using scripts/shared/_burnplayer;
#using scripts/mp/killstreaks/_rcbomb;
#using scripts/mp/killstreaks/_qrdrone;
#using scripts/mp/killstreaks/_helicopter;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_ai_tank;
#using scripts/shared/weapons/_sticky_grenade;
#using scripts/shared/abilities/gadgets/_gadget_vision_pulse;
#using scripts/shared/vehicles/_driving_fx;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/footsteps_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;

#namespace callback;

// Namespace callback
// Params 0, eflags: 0x2
// namespace_dabbe128<file_0>::function_2dc19561
// Checksum 0x1ecb121, Offset: 0x448
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("callback", &__init__, undefined, undefined);
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// namespace_dabbe128<file_0>::function_8c87d8eb
// Checksum 0xe1aa8e55, Offset: 0x488
// Size: 0x1c
function __init__() {
    level thread set_default_callbacks();
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// namespace_dabbe128<file_0>::function_1234506c
// Checksum 0x6823806a, Offset: 0x4b0
// Size: 0xdc
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
// Params 1, eflags: 0x1 linked
// namespace_dabbe128<file_0>::function_80bc4653
// Checksum 0x810d3b7, Offset: 0x598
// Size: 0x74
function localclientconnect(localclientnum) {
    println("japanese" + localclientnum);
    if (isdefined(level.charactercustomizationsetup)) {
        [[ level.charactercustomizationsetup ]](localclientnum);
    }
    callback(#"hash_da8d7d74", localclientnum);
}

// Namespace callback
// Params 1, eflags: 0x1 linked
// namespace_dabbe128<file_0>::function_5e92b6fc
// Checksum 0xc5e991d4, Offset: 0x618
// Size: 0x114
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
    println("japanese");
    if (self islocalplayer()) {
        callback(#"hash_842e788a", localclientnum);
    }
    callback(#"hash_bc12b61f", localclientnum);
}

// Namespace callback
// Params 1, eflags: 0x1 linked
// namespace_dabbe128<file_0>::function_fd677ed2
// Checksum 0xc1dedb53, Offset: 0x738
// Size: 0x250
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
        println("japanese");
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
// Params 12, eflags: 0x1 linked
// namespace_dabbe128<file_0>::function_56e5590c
// Checksum 0x447de7d3, Offset: 0x990
// Size: 0x5ee
function airsupport(localclientnum, x, y, z, type, yaw, team, teamfaction, owner, exittype, time, height) {
    pos = (x, y, z);
    switch (teamfaction) {
    case 17:
        teamfaction = "vietcong";
        break;
    case 14:
    case 7:
        teamfaction = "nva";
        break;
    case 12:
        teamfaction = "japanese";
        break;
    case 13:
        teamfaction = "marines";
        break;
    case 16:
        teamfaction = "specops";
        break;
    case 15:
        teamfaction = "russian";
        break;
    default:
        println("japanese");
        println("japanese" + teamfaction + "japanese");
        teamfaction = "marines";
        break;
    }
    switch (team) {
    case 22:
        team = "axis";
        break;
    case 21:
        team = "allies";
        break;
    case 15:
        team = "free";
        break;
    default:
        println("japanese" + team + "japanese");
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
        println("japanese");
        println("japanese");
        println(type);
        println("japanese");
    #/
    return;
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// namespace_dabbe128<file_0>::function_4444b99f
// Checksum 0xa1ac763c, Offset: 0xf88
// Size: 0x14
function creating_corpse(localclientnum, player) {
    
}

// Namespace callback
// Params 7, eflags: 0x1 linked
// namespace_dabbe128<file_0>::function_8ae1d4cc
// Checksum 0x77d93aae, Offset: 0xfa8
// Size: 0x8a
function callback_stunned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.stunned = newval;
    println("japanese");
    if (newval) {
        self notify(#"stunned");
        return;
    }
    self notify(#"not_stunned");
}

// Namespace callback
// Params 7, eflags: 0x1 linked
// namespace_dabbe128<file_0>::function_978d5cff
// Checksum 0x10ebf4e6, Offset: 0x1040
// Size: 0x8a
function callback_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.emp = newval;
    println("japanese");
    if (newval) {
        self notify(#"emp");
        return;
    }
    self notify(#"not_emp");
}

// Namespace callback
// Params 7, eflags: 0x1 linked
// namespace_dabbe128<file_0>::function_1a338a6
// Checksum 0x64cec4c8, Offset: 0x10d8
// Size: 0x48
function callback_proximity(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.enemyinproximity = newval;
}

