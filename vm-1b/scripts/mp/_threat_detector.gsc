#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_hacker_tool;
#using scripts/shared/weapons/_weaponobjects;

#namespace threat_detector;

// Namespace threat_detector
// Params 0, eflags: 0x2
// Checksum 0xca9173ae, Offset: 0x260
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("threat_detector", &__init__, undefined, undefined);
}

// Namespace threat_detector
// Params 0, eflags: 0x0
// Checksum 0x9c2fe565, Offset: 0x298
// Size: 0x4a
function __init__() {
    clientfield::register("missile", "threat_detector", 1, 1, "int");
    callback::function_367a33a8(&function_22766af5);
}

// Namespace threat_detector
// Params 0, eflags: 0x0
// Checksum 0x22a69b02, Offset: 0x2f0
// Size: 0xa6
function function_22766af5() {
    watcher = self weaponobjects::createuseweaponobjectwatcher("threat_detector", self.team);
    watcher.headicon = 0;
    watcher.onspawn = &function_8a24ecfd;
    watcher.ondetonatecallback = &function_eee03df4;
    watcher.stun = &weaponobjects::weaponstun;
    watcher.stuntime = 0;
    watcher.ondamage = &function_7b7421df;
    watcher.enemydestroy = 1;
}

// Namespace threat_detector
// Params 2, eflags: 0x0
// Checksum 0x5b336849, Offset: 0x3a0
// Size: 0xca
function function_8a24ecfd(watcher, player) {
    self endon(#"death");
    self thread weaponobjects::onspawnuseweaponobject(watcher, player);
    self setowner(player);
    self setteam(player.team);
    self.owner = player;
    self playloopsound("wpn_sensor_nade_lp");
    self hacker_tool::registerwithhackertool(level.equipmenthackertoolradius, level.equipmenthackertooltimems);
    player addweaponstat(self.weapon, "used", 1);
    self thread function_5aadfa85(player);
}

// Namespace threat_detector
// Params 1, eflags: 0x0
// Checksum 0x42f2cfc6, Offset: 0x478
// Size: 0x52
function function_5aadfa85(owner) {
    self endon(#"death");
    self endon(#"hacked");
    self endon(#"explode");
    owner endon(#"death");
    owner endon(#"disconnect");
    self waittill(#"stationary");
    self clientfield::set("threat_detector", 1);
}

// Namespace threat_detector
// Params 1, eflags: 0x0
// Checksum 0x9ebe1d29, Offset: 0x4d8
// Size: 0x62
function function_eaae596a(victim) {
    if (!isdefined(self.sensorgrenadedata)) {
        self.sensorgrenadedata = [];
    }
    if (!isdefined(self.sensorgrenadedata[victim.clientid])) {
        self.sensorgrenadedata[victim.clientid] = gettime();
    }
    self clientfield::set_to_player("threat_detected", 1);
}

// Namespace threat_detector
// Params 3, eflags: 0x0
// Checksum 0xebc1ff10, Offset: 0x548
// Size: 0xd2
function function_eee03df4(attacker, weapon, target) {
    if (!isdefined(weapon) || !weapon.isemp) {
        playfx(level._equipment_explode_fx, self.origin);
    }
    if (isdefined(attacker)) {
        if (self.owner util::isenemyplayer(attacker)) {
            attacker challenges::destroyedequipment(weapon);
            scoreevents::processscoreevent("destroyed_motion_sensor", attacker, self.owner, weapon);
        }
    }
    playsoundatposition("wpn_sensor_nade_explo", self.origin);
    self delete();
}

// Namespace threat_detector
// Params 1, eflags: 0x0
// Checksum 0xdda32349, Offset: 0x628
// Size: 0x2b7
function function_7b7421df(watcher) {
    self endon(#"death");
    self endon(#"hacked");
    self setcandamage(1);
    damagemax = 1;
    if (!self util::ishacked()) {
        self.damagetaken = 0;
    }
    while (true) {
        self.maxhealth = 100000;
        self.health = self.maxhealth;
        self waittill(#"damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon, idflags);
        if (!isdefined(attacker) || !isplayer(attacker)) {
            continue;
        }
        if (level.teambased && isplayer(attacker)) {
            if (!level.hardcoremode && self.owner.team == attacker.pers["team"] && self.owner != attacker) {
                continue;
            }
        }
        if (watcher.stuntime > 0 && weapon.dostun) {
            self thread weaponobjects::stunstart(watcher, watcher.stuntime);
        }
        if (weapon.dodamagefeedback) {
            if (level.teambased && self.owner.team != attacker.team) {
                if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                    attacker damagefeedback::update();
                }
            } else if (!level.teambased && self.owner != attacker) {
                if (damagefeedback::dodamagefeedback(weapon, attacker)) {
                    attacker damagefeedback::update();
                }
            }
        }
        if (type == "MOD_MELEE" || weapon.isemp) {
            self.damagetaken = damagemax;
        } else {
            self.damagetaken = self.damagetaken + damage;
        }
        if (self.damagetaken >= damagemax) {
            watcher thread weaponobjects::waitanddetonate(self, 0, attacker, weapon);
            return;
        }
    }
}

