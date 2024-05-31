#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/weapons/_hacker_tool;
#using scripts/shared/weapons/_decoy;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace sensor_grenade;

// Namespace sensor_grenade
// Params 0, eflags: 0x1 linked
// namespace_d357f370<file_0>::function_1463e4e5
// Checksum 0x2411ef02, Offset: 0x2d8
// Size: 0x3c
function init_shared() {
    level.var_a747f90a = &function_e9649fd8;
    callback::function_367a33a8(&function_cb111d01);
}

// Namespace sensor_grenade
// Params 0, eflags: 0x1 linked
// namespace_d357f370<file_0>::function_cb111d01
// Checksum 0x18f9a9e5, Offset: 0x320
// Size: 0xcc
function function_cb111d01() {
    watcher = self weaponobjects::createuseweaponobjectwatcher("sensor_grenade", self.team);
    watcher.headicon = 0;
    watcher.onspawn = &function_bdecb8fd;
    watcher.ondetonatecallback = &function_7750ac68;
    watcher.onstun = &weaponobjects::weaponstun;
    watcher.stuntime = 0;
    watcher.ondamage = &function_288c9631;
    watcher.enemydestroy = 1;
}

// Namespace sensor_grenade
// Params 2, eflags: 0x1 linked
// namespace_d357f370<file_0>::function_bdecb8fd
// Checksum 0x2e9313f0, Offset: 0x3f8
// Size: 0x134
function function_bdecb8fd(watcher, player) {
    self endon(#"death");
    self thread weaponobjects::onspawnuseweaponobject(watcher, player);
    self setowner(player);
    self setteam(player.team);
    self.owner = player;
    self playloopsound("wpn_sensor_nade_lp");
    self hacker_tool::registerwithhackertool(level.equipmenthackertoolradius, level.equipmenthackertooltimems);
    player addweaponstat(self.weapon, "used", 1);
    self thread function_5aadfa85(player);
    self thread function_ab966fda(player);
    self thread function_f4ccbeb2(player);
}

// Namespace sensor_grenade
// Params 1, eflags: 0x1 linked
// namespace_d357f370<file_0>::function_5aadfa85
// Checksum 0x8d1c2086, Offset: 0x538
// Size: 0x6c
function function_5aadfa85(owner) {
    self endon(#"death");
    self endon(#"hacked");
    self endon(#"explode");
    owner endon(#"death");
    owner endon(#"disconnect");
    self waittill(#"stationary");
    function_32b1b0c7(self.origin);
}

// Namespace sensor_grenade
// Params 1, eflags: 0x1 linked
// namespace_d357f370<file_0>::function_ab966fda
// Checksum 0x2ea8088d, Offset: 0x5b0
// Size: 0x74
function function_ab966fda(owner) {
    self endon(#"hacked");
    self endon(#"delete");
    owner endon(#"death");
    owner endon(#"disconnect");
    origin = self waittill(#"explode");
    function_32b1b0c7(origin + (0, 0, 1));
}

// Namespace sensor_grenade
// Params 1, eflags: 0x1 linked
// namespace_d357f370<file_0>::function_32b1b0c7
// Checksum 0x5b0e9354, Offset: 0x630
// Size: 0x1d2
function function_32b1b0c7(origin) {
    if (isdefined(self.owner) == 0) {
        return;
    }
    players = level.players;
    foreach (player in level.players) {
        if (player util::isenemyplayer(self.owner)) {
            if (!player hasperk("specialty_nomotionsensor") && !(player hasperk("specialty_sengrenjammer") && player clientfield::get("sg_jammer_active"))) {
                if (distancesquared(player.origin, origin) < 562500) {
                    trace = bullettrace(origin, player.origin + (0, 0, 12), 0, player);
                    if (trace["fraction"] == 1) {
                        self.owner function_eaae596a(player);
                    }
                }
            }
        }
    }
}

// Namespace sensor_grenade
// Params 1, eflags: 0x1 linked
// namespace_d357f370<file_0>::function_eaae596a
// Checksum 0x8c6709b6, Offset: 0x810
// Size: 0x5e
function function_eaae596a(victim) {
    if (!isdefined(self.sensorgrenadedata)) {
        self.sensorgrenadedata = [];
    }
    if (!isdefined(self.sensorgrenadedata[victim.clientid])) {
        self.sensorgrenadedata[victim.clientid] = gettime();
    }
}

// Namespace sensor_grenade
// Params 2, eflags: 0x1 linked
// namespace_d357f370<file_0>::function_e9649fd8
// Checksum 0x398e9f90, Offset: 0x878
// Size: 0x82
function function_e9649fd8(player, time) {
    var_569f288c = 0;
    if (isdefined(self.sensorgrenadedata) && isdefined(self.sensorgrenadedata[player.clientid])) {
        if (self.sensorgrenadedata[player.clientid] + 10000 > time) {
            var_569f288c = 1;
        }
    }
    return var_569f288c;
}

// Namespace sensor_grenade
// Params 3, eflags: 0x1 linked
// namespace_d357f370<file_0>::function_7750ac68
// Checksum 0x28ff607b, Offset: 0x908
// Size: 0x104
function function_7750ac68(attacker, weapon, target) {
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

// Namespace sensor_grenade
// Params 1, eflags: 0x1 linked
// namespace_d357f370<file_0>::function_288c9631
// Checksum 0xd2d17739, Offset: 0xa18
// Size: 0x35a
function function_288c9631(watcher) {
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
        if (type == "MOD_MELEE" || weapon.isemp || weapon.destroysequipment) {
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

// Namespace sensor_grenade
// Params 1, eflags: 0x1 linked
// namespace_d357f370<file_0>::function_f4ccbeb2
// Checksum 0x1d7938fd, Offset: 0xd80
// Size: 0x142
function function_f4ccbeb2(owner) {
    self waittill(#"stationary");
    players = level.players;
    foreach (player in level.players) {
        if (player util::isenemyplayer(self.owner)) {
            if (isalive(player) && player hasperk("specialty_decoy")) {
                if (distancesquared(player.origin, self.origin) < 57600) {
                    player thread function_d7943f6b(self);
                }
            }
        }
    }
}

// Namespace sensor_grenade
// Params 0, eflags: 0x1 linked
// namespace_d357f370<file_0>::function_23685d89
// Checksum 0x3a67bfa, Offset: 0xed0
// Size: 0x26
function function_23685d89() {
    return self.origin - -16 * anglestoforward(self.angles);
}

// Namespace sensor_grenade
// Params 1, eflags: 0x1 linked
// namespace_d357f370<file_0>::function_d7943f6b
// Checksum 0x2b8da758, Offset: 0xf00
// Size: 0xf4
function function_d7943f6b(sensor_grenade) {
    origin = self function_23685d89();
    decoy_grenade = sys::spawn("script_model", origin);
    decoy_grenade.angles = -1 * self.angles;
    wait(0.05);
    decoy_grenade.var_8d009e7f = -1 * self getvelocity();
    decoy_grenade thread decoy::function_a63701dd(self);
    wait(15);
    decoy_grenade notify(#"done");
    decoy_grenade notify(#"hash_deb9ad6f");
    decoy_grenade delete();
}

