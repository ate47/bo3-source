#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/vehicle_shared;
#using scripts/zm/gametypes/_damagefeedback;
#using scripts/zm/gametypes/_globallogic_player;
#using scripts/zm/gametypes/_weapons;

#namespace globallogic_vehicle;

// Namespace globallogic_vehicle
// Params 1, eflags: 0x0
// Checksum 0xc7e5a907, Offset: 0x288
// Size: 0xbc
function callback_vehiclespawned(spawner) {
    if (isdefined(level.vehicle_main_callback)) {
        if (isdefined(level.vehicle_main_callback[self.vehicletype])) {
            self thread [[ level.vehicle_main_callback[self.vehicletype] ]]();
        } else if (isdefined(self.scriptvehicletype) && isdefined(level.vehicle_main_callback[self.scriptvehicletype])) {
            self thread [[ level.vehicle_main_callback[self.scriptvehicletype] ]]();
        }
    }
    if (issentient(self)) {
        self spawner::spawn_think(spawner);
    }
}

// Namespace globallogic_vehicle
// Params 15, eflags: 0x0
// Checksum 0x986e2bdd, Offset: 0x350
// Size: 0xd4c
function callback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    self.idflags = idflags;
    self.idflagstime = gettime();
    if (game["state"] == "postgame") {
        return;
    }
    if (isdefined(eattacker) && isplayer(eattacker) && isdefined(eattacker.candocombat) && !eattacker.candocombat) {
        return;
    }
    if (!isdefined(vdir)) {
        idflags |= level.idflags_no_knockback;
    }
    friendly = 0;
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
    if (!(idflags & level.idflags_no_protection)) {
        if (self isvehicleimmunetodamage(idflags, smeansofdeath, weapon)) {
            if (isdefined(self.overridevehicledamage)) {
                idamage = self [[ self.overridevehicledamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
                return;
            }
            if (isdefined(level.overridevehicledamage)) {
                idamage = self [[ level.overridevehicledamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
            }
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
        idamage *= self getvehdamagemultiplier(smeansofdeath);
        idamage = int(idamage);
        if (isplayer(eattacker)) {
            eattacker.pers["participation"]++;
        }
        if (!isdefined(self.maxhealth)) {
            self.maxhealth = self.healthdefault;
        }
        if (isdefined(self.overridevehicledamage)) {
            idamage = self [[ self.overridevehicledamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
        } else if (isdefined(level.overridevehicledamage)) {
            idamage = self [[ level.overridevehicledamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
        }
        prevhealthratio = self.health / self.maxhealth;
        if (isdefined(self.owner) && isplayer(self.owner)) {
            team = self.owner.pers["team"];
        } else {
            team = self vehicle::vehicle_get_occupant_team();
        }
        if (level.teambased && isplayer(eattacker) && team == eattacker.pers["team"]) {
            if (level.friendlyfire == 0) {
                if (!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
                    return;
                }
                if (idamage < 1) {
                    idamage = 1;
                }
                self.lastdamagewasfromenemy = 0;
                self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 1);
            } else if (level.friendlyfire == 1) {
                if (idamage < 1) {
                    idamage = 1;
                }
                self.lastdamagewasfromenemy = 0;
                self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
            } else if (level.friendlyfire == 2) {
                if (!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
                    return;
                }
                if (idamage < 1) {
                    idamage = 1;
                }
                self.lastdamagewasfromenemy = 0;
                self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 1);
            } else if (level.friendlyfire == 3) {
                idamage = int(idamage * 0.5);
                if (idamage < 1) {
                    idamage = 1;
                }
                self.lastdamagewasfromenemy = 0;
                self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
            }
            friendly = 1;
        } else {
            if (!level.teambased && isdefined(self.targetname) && self.targetname == "rcbomb") {
            } else if (isdefined(self.owner) && isdefined(eattacker) && self.owner == eattacker) {
                return;
            }
            if (idamage < 1 && !(isdefined(level.bzm_worldpaused) && level.bzm_worldpaused)) {
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
            self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
            if (level.gametype == "hack" && !weapon.isemp) {
                idamage = 0;
            }
        }
        if (isdefined(eattacker) && eattacker != self) {
            if (damagefeedback::dodamagefeedback(weapon, einflictor)) {
                if (idamage > 0) {
                    eattacker thread damagefeedback::update(smeansofdeath, einflictor);
                }
            }
        }
    }
    /#
        if (getdvarint("<dev string:x28>")) {
            println("<dev string:x36>" + self getentitynumber() + "<dev string:x3d>" + self.health + "<dev string:x46>" + eattacker.clientid + "<dev string:x51>" + isplayer(einflictor) + "<dev string:x67>" + idamage + "<dev string:x70>" + shitloc);
        }
    #/
    if (true) {
        lpselfnum = self getentitynumber();
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
        logprint("VD;" + lpselfnum + ";" + lpselfteam + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + weapon.name + ";" + idamage + ";" + smeansofdeath + ";" + shitloc + "\n");
    }
}

// Namespace globallogic_vehicle
// Params 13, eflags: 0x0
// Checksum 0xf7c4aebc, Offset: 0x10a8
// Size: 0x5dc
function callback_vehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime) {
    self.idflags = idflags;
    self.idflagstime = gettime();
    if (game["state"] == "postgame") {
        return;
    }
    if (isdefined(eattacker) && isplayer(eattacker) && isdefined(eattacker.candocombat) && !eattacker.candocombat) {
        return;
    }
    friendly = 0;
    if (!(idflags & level.idflags_no_protection)) {
        if (self isvehicleimmunetodamage(idflags, smeansofdeath, weapon)) {
            return;
        }
        if (isdefined(self.var_adbbf126)) {
            idamage = self [[ self.var_adbbf126 ]](einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
        } else if (isdefined(level.var_adbbf126)) {
            idamage = self [[ level.var_adbbf126 ]](einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
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
            if (level.friendlyfire == 0) {
                if (!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
                    return;
                }
                if (idamage < 1) {
                    idamage = 1;
                }
                self.lastdamagewasfromenemy = 0;
                self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
            } else if (level.friendlyfire == 1) {
                if (idamage < 1) {
                    idamage = 1;
                }
                self.lastdamagewasfromenemy = 0;
                self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
            } else if (level.friendlyfire == 2) {
                if (!allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)) {
                    return;
                }
                if (idamage < 1) {
                    idamage = 1;
                }
                self.lastdamagewasfromenemy = 0;
                self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
            } else if (level.friendlyfire == 3) {
                idamage = int(idamage * 0.5);
                if (idamage < 1) {
                    idamage = 1;
                }
                self.lastdamagewasfromenemy = 0;
                self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
            }
            friendly = 1;
            return;
        }
        if (idamage < 1) {
            idamage = 1;
        }
        self finishvehicleradiusdamage(einflictor, eattacker, idamage, finnerdamage, fouterdamage, idflags, smeansofdeath, weapon, vpoint, fradius, fconeanglecos, vconedir, psoffsettime);
    }
}

// Namespace globallogic_vehicle
// Params 8, eflags: 0x0
// Checksum 0x971e7c9f, Offset: 0x1690
// Size: 0x248
function callback_vehiclekilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    params = spawnstruct();
    params.einflictor = einflictor;
    params.eattacker = eattacker;
    params.idamage = idamage;
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    params.vdir = vdir;
    params.shitloc = shitloc;
    params.psoffsettime = psoffsettime;
    self.str_damagemod = smeansofdeath;
    self.w_damage = weapon;
    if (game["state"] == "postgame") {
        return;
    }
    if (isai(eattacker) && isdefined(eattacker.script_owner)) {
        if (eattacker.script_owner.team != self.team) {
            eattacker = eattacker.script_owner;
        }
    }
    if (isdefined(eattacker) && isdefined(eattacker.onkill)) {
        eattacker [[ eattacker.onkill ]](self);
    }
    if (isdefined(einflictor)) {
        self.damageinflictor = einflictor;
    }
    self callback::callback(#"hash_acb66515", params);
    if (isdefined(self.overridevehiclekilled)) {
        self [[ self.overridevehiclekilled ]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
}

// Namespace globallogic_vehicle
// Params 0, eflags: 0x0
// Checksum 0x4804548d, Offset: 0x18e0
// Size: 0x8c
function vehiclecrush() {
    self endon(#"disconnect");
    if (isdefined(level._effect) && isdefined(level._effect["tanksquish"])) {
        playfx(level._effect["tanksquish"], self.origin + (0, 0, 30));
    }
    self playsound("chr_crunch");
}

// Namespace globallogic_vehicle
// Params 1, eflags: 0x0
// Checksum 0xc22f7914, Offset: 0x1978
// Size: 0x64
function getvehicleunderneathsplashscalar(weapon) {
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
// Checksum 0x65db527e, Offset: 0x19e8
// Size: 0x52
function allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
    if (isdefined(self.allowfriendlyfiredamageoverride)) {
        return [[ self.allowfriendlyfiredamageoverride ]](einflictor, eattacker, smeansofdeath, weapon);
    }
    return 0;
}

