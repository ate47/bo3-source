#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/ctf;
#using scripts/mp/killstreaks/_rcbomb;
#using scripts/mp/killstreaks/_supplydrop;
#using scripts/shared/array_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_tacticalinsertion;
#using scripts/shared/weapons/_weaponobjects;

#namespace mp_stronghold_doors;

// Namespace mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0x9cebdea9, Offset: 0x3b8
// Size: 0x17a
function init() {
    doors = getentarray("mp_stronghold_security_door_lower", "targetname");
    if (!isdefined(doors) || doors.size == 0) {
        return;
    }
    var_6001ee4a = getentarray("mp_stronghold_security_door_upper", "targetname");
    killtriggers = getentarray("mp_stronghold_killbrush", "targetname");
    assert(var_6001ee4a.size == doors.size);
    assert(killtriggers.size == killtriggers.size);
    foreach (door in doors) {
        upper = function_b02c2d9b(door.origin, var_6001ee4a);
        var_318c56b3 = function_b02c2d9b(door.origin, killtriggers);
        level thread function_a9870442(door, upper, var_318c56b3);
    }
    level thread door_use_trigger();
}

// Namespace mp_stronghold_doors
// Params 3, eflags: 0x0
// Checksum 0x992845a9, Offset: 0x540
// Size: 0x12a
function function_a9870442(door, upper, trigger) {
    door.upper = upper;
    door.kill_trigger = trigger;
    assert(isdefined(door.kill_trigger));
    door.kill_trigger enablelinkto();
    door.kill_trigger linkto(door);
    door.opened = 1;
    door.var_ac9a7989 = door.origin;
    door.var_e5d0c7af = 0;
    door.var_c99bab0a = (door.origin[0], door.origin[1], door.origin[2] - 90);
    door.var_6839fc52 = (door.origin[0], door.origin[1], door.origin[2] - -76);
    door thread door_think();
}

// Namespace mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0x76eb94ef, Offset: 0x678
// Size: 0x9b
function door_use_trigger() {
    use_triggers = getentarray("mp_stronghold_usetrigger", "targetname");
    foreach (use_trigger in use_triggers) {
        use_trigger thread function_dc8340b();
        use_trigger thread function_4b4db561();
    }
}

// Namespace mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0xc17e2cc9, Offset: 0x720
// Size: 0x23
function function_dc8340b() {
    for (;;) {
        self waittill(#"trigger", e_player);
        level notify(#"hash_40d64b76");
    }
}

// Namespace mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0xcbd2a8e8, Offset: 0x750
// Size: 0xa5
function function_4b4db561() {
    hintstring = "";
    for (;;) {
        returnvar = level util::waittill_any_return("mp_stronghold_trigger_enable", "mp_stronghold_trigger_disable", "mp_stronghold_trigger_cooldown");
        switch (returnvar) {
        case "mp_stronghold_trigger_enable":
            hintstring = "ENABLE";
            break;
        case "mp_stronghold_trigger_disable":
            hintstring = "DISABLE";
            break;
        case "mp_stronghold_trigger_cooldown":
            hintstring = "COOLDOWN";
            break;
        }
        self sethintstring(hintstring);
    }
}

// Namespace mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0x298eb58a, Offset: 0x800
// Size: 0xf5
function door_think() {
    for (;;) {
        exploder::exploder("fx_switch_red");
        exploder::kill_exploder("fx_switch_green");
        wait 20;
        exploder::exploder("fx_switch_green");
        exploder::kill_exploder("fx_switch_red");
        if (self function_1213d8bc()) {
            level notify(#"mp_stronghold_trigger_disable");
        } else {
            level notify(#"mp_stronghold_trigger_enable");
        }
        level waittill(#"hash_40d64b76");
        level notify(#"mp_stronghold_trigger_cooldown");
        if (self function_1213d8bc()) {
            self thread door_open();
            self function_8149b63b(0);
            continue;
        }
        self thread door_close();
        self function_8149b63b(1);
    }
}

// Namespace mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0xd6f54031, Offset: 0x900
// Size: 0xa
function function_1213d8bc() {
    return !self.opened;
}

// Namespace mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0x328f6814, Offset: 0x918
// Size: 0xb2
function door_open() {
    if (self.opened) {
        return;
    }
    dist = distance(self.var_6839fc52, self.origin);
    frac = dist / -76;
    halftime = 4.5;
    self moveto(self.var_c99bab0a, halftime);
    self.upper moveto(self.var_ac9a7989, halftime);
    self waittill(#"movedone");
    self moveto(self.var_ac9a7989, halftime);
    self.opened = 1;
}

// Namespace mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0xad719264, Offset: 0x9d8
// Size: 0xb2
function door_close() {
    if (!self.opened) {
        return;
    }
    dist = distance(self.var_6839fc52, self.origin);
    frac = dist / -76;
    halftime = 4.5;
    self moveto(self.var_c99bab0a, halftime);
    self waittill(#"movedone");
    self moveto(self.var_6839fc52, halftime);
    self.upper moveto(self.var_c99bab0a, halftime);
    self.opened = 0;
}

// Namespace mp_stronghold_doors
// Params 1, eflags: 0x0
// Checksum 0x35dd67a3, Offset: 0xa98
// Size: 0x4ad
function function_8149b63b(var_6b9180f5) {
    self endon(#"movedone");
    self.disablefinalkillcam = 1;
    door = self;
    var_cd78fc15 = 0;
    for (;;) {
        wait 0.2;
        entities = getdamageableentarray(self.origin, -56);
        foreach (entity in entities) {
            if (!entity istouching(self.kill_trigger)) {
                continue;
            }
            if (!isalive(entity)) {
                continue;
            }
            if (isdefined(entity.targetname)) {
                if (entity.targetname == "talon") {
                    entity notify(#"death");
                    continue;
                } else if (entity.targetname == "riotshield_mp") {
                    entity dodamage(1, self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
                    continue;
                }
            }
            if (isdefined(entity.helitype) && entity.helitype == "qrdrone") {
                watcher = entity.owner weaponobjects::getweaponobjectwatcher("qrdrone");
                watcher thread weaponobjects::waitanddetonate(entity, 0, undefined);
                continue;
            }
            if (entity.classname == "grenade") {
                if (!isdefined(entity.name)) {
                    continue;
                }
                if (!isdefined(entity.owner)) {
                    continue;
                }
                if (entity.name == "proximity_grenade_mp") {
                    watcher = entity.owner weaponobjects::getwatcherforweapon(entity.name);
                    watcher thread weaponobjects::waitanddetonate(entity, 0, undefined, "script_mover_mp");
                    continue;
                }
                if (!entity.isequipment) {
                    continue;
                }
                watcher = entity.owner weaponobjects::getwatcherforweapon(entity.name);
                if (!isdefined(watcher)) {
                    continue;
                }
                watcher thread weaponobjects::waitanddetonate(entity, 0, undefined, "script_mover_mp");
                continue;
            }
            if (entity.classname == "auto_turret") {
                if (!isdefined(entity.damagedtodeath) || !entity.damagedtodeath) {
                    entity util::domaxdamage(self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
                }
                continue;
            }
            if (var_6b9180f5 == 0 && isplayer(entity)) {
                continue;
            }
            entity dodamage(entity.health * 2, self.origin + (0, 0, 1), self, self, 0, "MOD_CRUSH");
            if (isplayer(entity)) {
                var_cd78fc15 = gettime() + 1000;
            }
        }
        self function_efb0f9a4();
        if (gettime() > var_cd78fc15) {
            self function_dde749cf();
        }
        if (level.gametype == "ctf") {
            foreach (flag in level.flags) {
                if (flag.visuals[0] istouching(self.kill_trigger)) {
                    flag ctf::returnflag();
                }
            }
            continue;
        }
        if (level.gametype == "sd" && !level.multibomb) {
            if (level.sdbomb.visuals[0] istouching(self.kill_trigger)) {
                level.sdbomb gameobjects::return_home();
            }
        }
    }
}

// Namespace mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0x4282c2ab, Offset: 0xf50
// Size: 0x113
function function_efb0f9a4() {
    crates = getentarray("care_package", "script_noteworthy");
    foreach (crate in crates) {
        if (distancesquared(crate.origin, self.origin) < 40000) {
            if (crate istouching(self)) {
                playfx(level._supply_drop_explosion_fx, crate.origin);
                playsoundatposition("wpn_grenade_explode", crate.origin);
                wait 0.1;
                crate supplydrop::cratedelete();
            }
        }
    }
}

// Namespace mp_stronghold_doors
// Params 0, eflags: 0x0
// Checksum 0xe51a735, Offset: 0x1070
// Size: 0x79
function function_dde749cf() {
    corpses = getcorpsearray();
    for (i = 0; i < corpses.size; i++) {
        if (distancesquared(corpses[i].origin, self.origin) < 40000) {
            corpses[i] delete();
        }
    }
}

// Namespace mp_stronghold_doors
// Params 2, eflags: 0x0
// Checksum 0x144b59d5, Offset: 0x10f8
// Size: 0xa6
function function_b02c2d9b(org, array) {
    dist = 9999999;
    distsq = dist * dist;
    if (array.size < 1) {
        return;
    }
    index = undefined;
    for (i = 0; i < array.size; i++) {
        newdistsq = distancesquared(array[i].origin, org);
        if (newdistsq >= distsq) {
            continue;
        }
        distsq = newdistsq;
        index = i;
    }
    return array[index];
}

