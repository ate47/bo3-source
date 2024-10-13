#using scripts/cp/_explosive_bolt;
#using scripts/cp/_claymore;
#using scripts/cp/_callbacks;
#using scripts/cp/_burnplayer;
#using scripts/shared/weapons/_sticky_grenade;
#using scripts/shared/vehicles/_driving_fx;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/footsteps_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/ai_shared;

#namespace callback;

// Namespace callback
// Params 0, eflags: 0x2
// Checksum 0xa6d82acf, Offset: 0x2a0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("callback", &__init__, undefined, undefined);
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0x9bedc0d2, Offset: 0x2e0
// Size: 0x1c
function __init__() {
    level thread set_default_callbacks();
}

// Namespace callback
// Params 0, eflags: 0x1 linked
// Checksum 0x730783fa, Offset: 0x308
// Size: 0xac
function set_default_callbacks() {
    level.callbackplayerspawned = &playerspawned;
    level.callbacklocalclientconnect = &localclientconnect;
    level.callbackcreatingcorpse = &creating_corpse;
    level.callbackentityspawned = &entityspawned;
    level.callbackplayaifootstep = &footsteps::playaifootstep;
    level.var_7bf94c43 = &exploder::playlightloopexploder;
    level._custom_weapon_cb_func = &spawned_weapon_type;
}

// Namespace callback
// Params 1, eflags: 0x1 linked
// Checksum 0x88dc56c9, Offset: 0x3c0
// Size: 0x94
function localclientconnect(localclientnum) {
    println("<dev string:x28>" + localclientnum);
    if (isdefined(level.charactercustomizationsetup)) {
        [[ level.charactercustomizationsetup ]](localclientnum);
    }
    if (isdefined(level.weaponcustomizationiconsetup)) {
        [[ level.weaponcustomizationiconsetup ]](localclientnum);
    }
    callback(#"hash_da8d7d74", localclientnum);
}

// Namespace callback
// Params 1, eflags: 0x1 linked
// Checksum 0xa79090fd, Offset: 0x460
// Size: 0xd4
function playerspawned(localclientnum) {
    self endon(#"entityshutdown");
    player = getlocalplayer(localclientnum);
    assert(isdefined(player));
    if (isdefined(level.infraredvisionset)) {
        player setinfraredvisionset(level.infraredvisionset);
    }
    if (self islocalplayer()) {
        callback(#"hash_842e788a", localclientnum);
    }
    callback(#"hash_bc12b61f", localclientnum);
}

// Namespace callback
// Params 1, eflags: 0x1 linked
// Checksum 0xae349612, Offset: 0x540
// Size: 0x28c
function entityspawned(localclientnum) {
    self endon(#"entityshutdown");
    if (!isdefined(self.type)) {
        println("<dev string:x55>");
        return;
    }
    if (self isplayer()) {
        if (isdefined(level._clientfaceanimonplayerspawned)) {
            self thread [[ level._clientfaceanimonplayerspawned ]](localclientnum);
        }
    }
    if (self.type == "missile") {
        if (isdefined(level._custom_weapon_cb_func)) {
            self thread [[ level._custom_weapon_cb_func ]](localclientnum);
        }
        switch (self.weapon.name) {
        case "explosive_bolt":
            self thread _explosive_bolt::spawned(localclientnum);
            break;
        case "claymore":
            self thread _claymore::spawned(localclientnum);
            break;
        }
        return;
    }
    if (self.type == "vehicle" || self.type == "helicopter" || self.type == "plane") {
        if (isdefined(level._customvehiclecbfunc)) {
            self thread [[ level._customvehiclecbfunc ]](localclientnum);
        }
        self thread vehicle::field_toggle_exhaustfx_handler(localclientnum, undefined, 0, 1);
        self thread vehicle::field_toggle_lights_handler(localclientnum, undefined, 0, 1);
        if (self.vehicleclass == "plane" || self.vehicleclass == "helicopter") {
            self thread vehicle::aircraft_dustkick();
        } else {
            self thread driving_fx::function_789b5418(localclientnum);
            self thread vehicle::rumble(localclientnum);
        }
        return;
    }
    if (self.type == "actor") {
        self enableonradar();
        if (isdefined(level._customactorcbfunc)) {
            self thread [[ level._customactorcbfunc ]](localclientnum);
        }
    }
}

// Namespace callback
// Params 2, eflags: 0x1 linked
// Checksum 0x27c5d29e, Offset: 0x7d8
// Size: 0x14
function creating_corpse(localclientnum, player) {
    
}

// Namespace callback
// Params 7, eflags: 0x0
// Checksum 0x9692397e, Offset: 0x7f8
// Size: 0x8a
function callback_stunned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.stunned = newval;
    println("<dev string:x6c>");
    if (newval) {
        self notify(#"stunned");
        return;
    }
    self notify(#"not_stunned");
}

// Namespace callback
// Params 7, eflags: 0x0
// Checksum 0x6d02779b, Offset: 0x890
// Size: 0x8a
function callback_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.emp = newval;
    println("<dev string:x7d>");
    if (newval) {
        self notify(#"emp");
        return;
    }
    self notify(#"not_emp");
}

// Namespace callback
// Params 7, eflags: 0x0
// Checksum 0x6e137c89, Offset: 0x928
// Size: 0x48
function callback_proximity(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self.enemyinproximity = newval;
}

