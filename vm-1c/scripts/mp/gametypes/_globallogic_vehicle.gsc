#using scripts/mp/_vehicle;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/gametypes/_globallogic_player;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/vehicle_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/codescripts/struct;

#namespace globallogic_vehicle;

// Namespace globallogic_vehicle
// Params 1, eflags: 0x1 linked
// namespace_deaef99f<file_0>::function_ae5e80c1
// Checksum 0xd15116a4, Offset: 0x2d0
// Size: 0xe6
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
// Params 15, eflags: 0x1 linked
// namespace_deaef99f<file_0>::function_66eed27a
// Checksum 0xd70c5827, Offset: 0x3c0
// Size: 0xce4
function callback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    selfentnum = self getentitynumber();
    var_b7ebc2dc = isdefined(eattacker) && eattacker != self;
    var_ad14f907 = isdefined(eattacker) && isdefined(self.owner) && eattacker != self.owner;
    var_694d622 = !isdefined(self.nodamagefeedback) || !self.nodamagefeedback;
    if (!(1 & idflags)) {
        idamage = loadout::cac_modified_vehicle_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor);
    }
    self.idflags = idflags;
    self.idflagstime = gettime();
    if (game["state"] == "postgame") {
        self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
        return;
    }
    if (isdefined(eattacker) && isplayer(eattacker) && isdefined(eattacker.candocombat) && !eattacker.candocombat) {
        return;
    }
    if (self weapons::function_f9895d7a(weapon, einflictor)) {
        return;
    }
    if (isdefined(self.overridevehicledamage)) {
        idamage = self [[ self.overridevehicledamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    } else if (isdefined(level.overridevehicledamage)) {
        idamage = self [[ level.overridevehicledamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    }
    assert(isdefined(idamage), "participation");
    if (idamage == 0) {
        return;
    }
    if (!isdefined(vdir)) {
        idflags |= 4;
    }
    if (isdefined(self.maxhealth) && self.health == self.maxhealth || !isdefined(self.attackers)) {
        self.attackers = [];
        self.attackerdata = [];
        self.attackerdamage = [];
    }
    if (weapon == level.weaponnone && isdefined(einflictor)) {
        if (isdefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
            weapon = getweapon("explodable_barrel");
        } else if (isdefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
            weapon = getweapon("destructible_car");
        }
    }
    if (!(idflags & 2048)) {
        if (self isvehicleimmunetodamage(idflags, smeansofdeath, weapon)) {
            return;
        }
        if (smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_GRENADE") {
            idamage *= weapon.vehicleprojectiledamagescalar;
            idamage = int(idamage);
            if (idamage == 0) {
                return;
            }
        } else if (smeansofdeath == "MOD_GRENADE_SPLASH") {
            idamage *= getvehicleunderneathsplashscalar(weapon);
            idamage = int(idamage);
            if (idamage == 0) {
                return;
            }
        }
        idamage *= level.vehicledamagescalar;
        idamage = int(idamage);
        if (isplayer(eattacker)) {
            eattacker.pers["participation"]++;
        }
        if (!isdefined(self.maxhealth)) {
            self.maxhealth = self.healthdefault;
        }
        prevhealthratio = self.health / self.maxhealth;
        if (isdefined(self.owner) && isplayer(self.owner)) {
            team = self.owner.pers["team"];
        } else {
            team = self vehicle::vehicle_get_occupant_team();
        }
        if (level.teambased && isplayer(eattacker) && team == eattacker.pers["team"]) {
            if (!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
                return;
            }
            self.lastdamagewasfromenemy = 0;
            self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
        } else if (!level.hardcoremode && isdefined(self.owner) && isdefined(eattacker) && isdefined(eattacker.owner) && self.owner == eattacker.owner && self != eattacker) {
            return;
        } else {
            if (!level.teambased && isdefined(self.archetype) && self.archetype == "raps") {
            } else if (!level.teambased && isdefined(self.targetname) && self.targetname == "rcbomb") {
            } else if (isdefined(self.owner) && isdefined(eattacker) && self.owner == eattacker) {
                return;
            }
            if (idamage < 1) {
                idamage = 1;
            }
            if (issubstr(smeansofdeath, "MOD_GRENADE") && isdefined(einflictor) && isdefined(einflictor.iscooked)) {
                self.wascooked = gettime();
            } else {
                self.wascooked = undefined;
            }
            var_669a2894 = undefined;
            if (isdefined(eattacker)) {
                var_669a2894 = self getoccupantseat(eattacker);
            }
            self.lastdamagewasfromenemy = isdefined(eattacker) && !isdefined(var_669a2894);
            self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon);
            self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
            if (level.gametype == "hack" && !weapon.isemp) {
                idamage = 0;
            }
        }
        if (isdefined(self.selfdestruct) && (var_ad14f907 || !self.selfdestruct) || var_b7ebc2dc && self.forcedamagefeedback === 1) {
            if (var_694d622) {
                var_2a569af3 = 1;
                if (isdefined(self.damagetaken) && isdefined(self.maxhealth) && self.damagetaken > self.maxhealth) {
                    var_2a569af3 = 0;
                }
                if (isdefined(self.shuttingdown) && self.shuttingdown) {
                    var_2a569af3 = 0;
                }
                if (var_2a569af3 && damagefeedback::dodamagefeedback(weapon, einflictor)) {
                    if (idamage > 0) {
                        eattacker thread damagefeedback::update(smeansofdeath, einflictor);
                    }
                }
            }
        }
    }
    /#
        if (getdvarint("participation")) {
            println("participation" + self getentitynumber() + "participation" + self.health + "participation" + eattacker.clientid + "participation" + isplayer(einflictor) + "participation" + idamage + "participation" + shitloc);
        }
    #/
    if (true) {
        lpselfnum = selfentnum;
        lpselfteam = "";
        lpattackerteam = "";
        if (isplayer(eattacker)) {
            lpattacknum = eattacker getentitynumber();
            lpattackguid = eattacker getguid();
            lpattackname = eattacker.name;
            lpattackerteam = eattacker.pers["team"];
        } else {
            lpattacknum = -1;
            lpattackguid = "";
            lpattackname = "";
            lpattackerteam = "world";
        }
        /#
            logprint("participation" + lpselfnum + "participation" + lpselfteam + "participation" + lpattackguid + "participation" + lpattacknum + "participation" + lpattackerteam + "participation" + lpattackname + "participation" + weapon.name + "participation" + idamage + "participation" + smeansofdeath + "participation" + shitloc + "participation");
        #/
    }
}

// Namespace globallogic_vehicle
// Params 13, eflags: 0x1 linked
// namespace_deaef99f<file_0>::function_d28f6408
// Checksum 0x2cb48363, Offset: 0x10b0
// Size: 0x49c
function callback_vehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime) {
    idamage = loadout::cac_modified_vehicle_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor);
    finnerdamage = loadout::cac_modified_vehicle_damage(self, eattacker, finnerdamage, smeansofdeath, weapon, einflictor);
    fouterdamage = loadout::cac_modified_vehicle_damage(self, eattacker, fouterdamage, smeansofdeath, weapon, einflictor);
    self.idflags = idflags;
    self.idflagstime = gettime();
    if (game["state"] == "postgame") {
        return;
    }
    if (isdefined(eattacker) && isplayer(eattacker) && isdefined(eattacker.candocombat) && !eattacker.candocombat) {
        return;
    }
    if (isdefined(self.killstreaktype)) {
        maxhealth = isdefined(self.maxhealth) ? self.maxhealth : self.health;
        if (!isdefined(maxhealth)) {
            maxhealth = -56;
        }
        idamage = self killstreaks::ondamageperweapon(self.killstreaktype, eattacker, idamage, idflags, smeansofdeath, weapon, maxhealth, undefined, maxhealth * 0.4, undefined, 0, undefined, 1, 1);
    }
    if (!(idflags & 2048)) {
        if (self isvehicleimmunetodamage(idflags, smeansofdeath, weapon)) {
            return;
        }
        if (smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE") {
            scalar = weapon.vehicleprojectilesplashdamagescalar;
            idamage = int(idamage * scalar);
            finnerdamage *= scalar;
            fouterdamage *= scalar;
            if (finnerdamage == 0) {
                return;
            }
            if (idamage < 1) {
                idamage = 1;
            }
        }
        occupant_team = self vehicle::vehicle_get_occupant_team();
        if (level.teambased && isplayer(eattacker) && occupant_team == eattacker.pers["team"]) {
            if (!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
                return;
            }
            self.lastdamagewasfromenemy = 0;
            self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
            return;
        }
        if (!level.hardcoremode && isdefined(self.owner) && isdefined(eattacker.owner) && self.owner == eattacker.owner) {
            return;
        }
        if (idamage < 1) {
            idamage = 1;
        }
        self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
    }
}

// Namespace globallogic_vehicle
// Params 8, eflags: 0x1 linked
// namespace_deaef99f<file_0>::function_ba80775a
// Checksum 0x868ba28d, Offset: 0x1558
// Size: 0x130
function callback_vehiclekilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    if (!isdefined(self.selfdestruct) || game["state"] == "postgame" && !self.selfdestruct) {
        if (isdefined(self.overridevehicledeathpostgame)) {
            self [[ self.overridevehicledeathpostgame ]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
        }
        return;
    }
    if (isdefined(self.overridevehiclekilled)) {
        self [[ self.overridevehiclekilled ]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
    if (isdefined(self.var_60bdc617)) {
        self [[ self.var_60bdc617 ]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
}

// Namespace globallogic_vehicle
// Params 0, eflags: 0x1 linked
// namespace_deaef99f<file_0>::function_4d18350c
// Checksum 0x594e8b52, Offset: 0x1690
// Size: 0x8c
function vehiclecrush() {
    self endon(#"disconnect");
    if (isdefined(level._effect) && isdefined(level._effect["tanksquish"])) {
        playfx(level._effect["tanksquish"], self.origin + (0, 0, 30));
    }
    self playsound("chr_crunch");
}

// Namespace globallogic_vehicle
// Params 1, eflags: 0x1 linked
// namespace_deaef99f<file_0>::function_d389b572
// Checksum 0x9723bdf7, Offset: 0x1728
// Size: 0x80
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
// Params 4, eflags: 0x1 linked
// namespace_deaef99f<file_0>::function_f28c5916
// Checksum 0x7b420c5d, Offset: 0x17b0
// Size: 0x52
function allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
    if (isdefined(self.allowfriendlyfiredamageoverride)) {
        return [[ self.allowfriendlyfiredamageoverride ]](einflictor, eattacker, smeansofdeath, weapon);
    }
    return 0;
}

