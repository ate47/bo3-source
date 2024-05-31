#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace satchel_charge;

// Namespace satchel_charge
// Params 0, eflags: 0x1 linked
// Checksum 0x6f420386, Offset: 0x2a0
// Size: 0x5c
function init_shared() {
    level._effect["satchel_charge_enemy_light"] = "weapon/fx_c4_light_orng";
    level._effect["satchel_charge_friendly_light"] = "weapon/fx_c4_light_blue";
    callback::function_367a33a8(&function_d7ed4157);
}

// Namespace satchel_charge
// Params 0, eflags: 0x1 linked
// Checksum 0x1165c958, Offset: 0x308
// Size: 0x1c4
function function_d7ed4157() {
    watcher = self weaponobjects::createuseweaponobjectwatcher("satchel_charge", self.team);
    watcher.altdetonate = 1;
    watcher.watchforfire = 1;
    watcher.hackable = 1;
    watcher.hackertoolradius = level.equipmenthackertoolradius;
    watcher.hackertooltimems = level.equipmenthackertooltimems;
    watcher.headicon = 0;
    watcher.ondetonatecallback = &function_3543ddb5;
    watcher.onspawn = &function_a3a42df2;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 1;
    watcher.altweapon = getweapon("satchel_charge_detonator");
    watcher.ownergetsassist = 1;
    watcher.detonatestationary = 1;
    watcher.detonationdelay = getdvarfloat("scr_satchel_detonation_delay", 0);
    watcher.detonationsound = "wpn_claymore_alert";
    watcher.var_1ef0506d = "uin_c4_enemy_detection_alert";
    watcher.immunespecialty = "specialty_immunetriggerc4";
}

// Namespace satchel_charge
// Params 3, eflags: 0x1 linked
// Checksum 0xbfca25a, Offset: 0x4d8
// Size: 0xbc
function function_3543ddb5(attacker, weapon, target) {
    if (isdefined(weapon) && weapon.isvalid) {
        if (isdefined(attacker)) {
            if (self.owner util::isenemyplayer(attacker)) {
                attacker challenges::destroyedexplosive(weapon);
                scoreevents::processscoreevent("destroyed_c4", attacker, self.owner, weapon);
            }
        }
    }
    weaponobjects::weapondetonate(attacker, weapon);
}

// Namespace satchel_charge
// Params 2, eflags: 0x1 linked
// Checksum 0xc228611f, Offset: 0x5a0
// Size: 0x114
function function_a3a42df2(watcher, owner) {
    self endon(#"death");
    self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
    if (!(isdefined(self.previouslyhacked) && self.previouslyhacked)) {
        if (isdefined(owner)) {
            owner addweaponstat(self.weapon, "used", 1);
        }
        self playloopsound("uin_c4_air_alarm_loop");
        self util::waittill_notify_or_timeout("stationary", 10);
        delaytimesec = self.weapon.proximityalarmactivationdelay / 1000;
        if (delaytimesec > 0) {
            wait(delaytimesec);
        }
        self stoploopsound(0.1);
    }
}

