#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/weapons/_hacker_tool;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace threat_detector;

// Namespace threat_detector
// Params 0, eflags: 0x2
// Checksum 0x2a0046f6, Offset: 0x260
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("threat_detector", &__init__, undefined, undefined);
}

// Namespace threat_detector
// Params 0, eflags: 0x1 linked
// Checksum 0xc727a561, Offset: 0x2a0
// Size: 0x54
function __init__() {
    clientfield::register("missile", "threat_detector", 1, 1, "int");
    callback::function_367a33a8(&function_22766af5);
}

// Namespace threat_detector
// Params 0, eflags: 0x1 linked
// Checksum 0x26dbcc5f, Offset: 0x300
// Size: 0xcc
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
// Params 2, eflags: 0x1 linked
// Checksum 0xe7b5e964, Offset: 0x3d8
// Size: 0x104
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
// Params 1, eflags: 0x1 linked
// Checksum 0x7d336d0d, Offset: 0x4e8
// Size: 0x74
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
// Checksum 0x92dcaf36, Offset: 0x568
// Size: 0x7c
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
// Params 3, eflags: 0x1 linked
// Checksum 0x9fff7f31, Offset: 0x5f0
// Size: 0x104
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
// Params 1, eflags: 0x1 linked
// Checksum 0xabd7ef3c, Offset: 0x700
// Size: 0x34a
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
        damage, attacker, direction, point, type, tagname, modelname, partname, weapon, idflags = self waittill(#"damage");
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
            self.damagetaken += damage;
        }
        if (self.damagetaken >= damagemax) {
            watcher thread weaponobjects::waitanddetonate(self, 0, attacker, weapon);
            return;
        }
    }
}

