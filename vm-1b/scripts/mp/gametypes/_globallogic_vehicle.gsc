#using scripts/codescripts/struct;
#using scripts/mp/_vehicle;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/mp/gametypes/_loadout;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons/_weapons;

#namespace globallogic_vehicle;

// Namespace globallogic_vehicle
// Params 1, eflags: 0x0
// Checksum 0x3fbc1313, Offset: 0x280
// Size: 0xc5
function callback_vehiclespawned(spawner) {
    self.health = self.healthdefault;
    if (issentient(self)) {
        self spawner::spawn_think(spawner);
    } else {
        vehicle::init(self);
    }
    if (isdefined(level.vehicle_main_callback)) {
        if (isdefined(level.vehicle_main_callback[self.vehicletype])) {
            self thread [[ level.vehicle_main_callback[self.vehicletype] ]]();
            return;
        }
        if (isdefined(self.scriptvehicletype) && isdefined(level.vehicle_main_callback[self.scriptvehicletype])) {
            self thread [[ level.vehicle_main_callback[self.scriptvehicletype] ]]();
        }
    }
}

// Namespace globallogic_vehicle
// Params 15, eflags: 0x0
// Checksum 0xdf134b99, Offset: 0x350
// Size: 0x185
function callback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    selfentnum = self getentitynumber();
    var_b7ebc2dc = isdefined(eattacker) && eattacker != self;
    var_ad14f907 = isdefined(eattacker) && isdefined(self.owner) && eattacker != self.owner;
    var_694d622 = !isdefined(self.nodamagefeedback) || !self.nodamagefeedback;
    if (!!idflags) {
        idamage = loadout::cac_modified_vehicle_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor);
    }
    self.idflags = idflags;
    self.idflagstime = gettime();
    InvalidOpCode(0x54, "state", 1);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_vehicle
// Params 13, eflags: 0x0
// Checksum 0xce4bc370, Offset: 0xdc0
// Size: 0xf5
function callback_vehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime) {
    idamage = loadout::cac_modified_vehicle_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor);
    finnerdamage = loadout::cac_modified_vehicle_damage(self, eattacker, finnerdamage, smeansofdeath, weapon, einflictor);
    fouterdamage = loadout::cac_modified_vehicle_damage(self, eattacker, fouterdamage, smeansofdeath, weapon, einflictor);
    self.idflags = idflags;
    self.idflagstime = gettime();
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_vehicle
// Params 8, eflags: 0x0
// Checksum 0x5be58785, Offset: 0x11f0
// Size: 0x49
function callback_vehiclekilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    InvalidOpCode(0x54, "state");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_vehicle
// Params 0, eflags: 0x0
// Checksum 0xc04357ee, Offset: 0x12b0
// Size: 0x72
function vehiclecrush() {
    self endon(#"disconnect");
    if (isdefined(level._effect) && isdefined(level._effect["tanksquish"])) {
        playfx(level._effect["tanksquish"], self.origin + (0, 0, 30));
    }
    self playsound("chr_crunch");
}

// Namespace globallogic_vehicle
// Params 1, eflags: 0x0
// Checksum 0xd4abe8f8, Offset: 0x1330
// Size: 0x6a
function getvehicleunderneathsplashscalar(weapon) {
    if (isdefined(self) && isdefined(self.ignore_vehicle_underneath_splash_scalar)) {
        return 1;
    }
    if (weapon.name == "satchel_charge") {
        scale = 10;
        scale *= 3;
    } else {
        scale = 1;
    }
    return scale;
}

// Namespace globallogic_vehicle
// Params 4, eflags: 0x0
// Checksum 0x9fc8aa30, Offset: 0x13a8
// Size: 0x41
function allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
    if (isdefined(self.allowfriendlyfiredamageoverride)) {
        return [[ self.allowfriendlyfiredamageoverride ]](einflictor, eattacker, smeansofdeath, weapon);
    }
    return 0;
}

