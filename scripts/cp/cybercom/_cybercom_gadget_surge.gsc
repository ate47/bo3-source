#using scripts/cp/cybercom/_cybercom_gadget_system_overload;
#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/lui_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/math_shared;
#using scripts/codescripts/struct;

// Can't decompile export namespace_63d98895::function_e4f42bf7

// Can't decompile export namespace_63d98895::function_9eb4d79d

#namespace namespace_63d98895;

// Namespace namespace_63d98895
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x648
// Size: 0x4
function init() {
    
}

// Namespace namespace_63d98895
// Params 0, eflags: 0x1 linked
// Checksum 0x9d5c16c2, Offset: 0x658
// Size: 0x17c
function main() {
    namespace_d00ec32::function_36b56038(0, 8);
    level.cybercom.surge = spawnstruct();
    level.cybercom.surge.var_875da84b = &function_875da84b;
    level.cybercom.surge.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.surge.var_bdb47551 = &function_bdb47551;
    level.cybercom.surge.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.surge.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.surge._on = &_on;
    level.cybercom.surge._off = &_off;
    level.cybercom.surge.var_4135a1c4 = &function_4135a1c4;
}

// Namespace namespace_63d98895
// Params 1, eflags: 0x1 linked
// Checksum 0x887aa569, Offset: 0x7e0
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_63d98895
// Params 2, eflags: 0x1 linked
// Checksum 0x64de275, Offset: 0x7f8
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_63d98895
// Params 2, eflags: 0x1 linked
// Checksum 0xa3a07063, Offset: 0x818
// Size: 0x9c
function function_bdb47551(slot, weapon) {
    self.cybercom.var_110c156a = getdvarint("scr_surge_target_count", 1);
    self.cybercom.var_9d8e0758 = &function_8aac802c;
    self.cybercom.var_c40accd3 = &function_602b28e9;
    self thread cybercom::function_b5f4e597(weapon);
}

// Namespace namespace_63d98895
// Params 2, eflags: 0x1 linked
// Checksum 0x4f3ff651, Offset: 0x8c0
// Size: 0x52
function function_39ea6a1b(slot, weapon) {
    self _off(slot, weapon);
    self.cybercom.var_9d8e0758 = undefined;
    self.cybercom.var_c40accd3 = undefined;
}

// Namespace namespace_63d98895
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x920
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_63d98895
// Params 2, eflags: 0x1 linked
// Checksum 0xecb813a1, Offset: 0x930
// Size: 0x54
function _on(slot, weapon) {
    self thread function_d015f498(slot, weapon);
    self _off(slot, weapon);
}

// Namespace namespace_63d98895
// Params 2, eflags: 0x1 linked
// Checksum 0xd031c94b, Offset: 0x990
// Size: 0x3a
function _off(slot, weapon) {
    self thread cybercom::function_d51412df(weapon);
    self.cybercom.var_301030f7 = undefined;
}

// Namespace namespace_63d98895
// Params 2, eflags: 0x1 linked
// Checksum 0xc795f42a, Offset: 0x9d8
// Size: 0xb0
function function_4135a1c4(slot, weapon) {
    if (!(isdefined(self.cybercom.var_301030f7) && self.cybercom.var_301030f7)) {
        /#
            assert(self.cybercom.var_2e20c9bd == weapon);
        #/
        self thread cybercom::function_2006f7d0(slot, weapon, getdvarint("scr_surge_target_count", 1));
        self.cybercom.var_301030f7 = 1;
    }
}

// Namespace namespace_63d98895
// Params 2, eflags: 0x5 linked
// Checksum 0x515dc37c, Offset: 0xa90
// Size: 0x2e8
function function_602b28e9(target, secondary) {
    if (!isdefined(secondary)) {
        secondary = 0;
    }
    if (target cybercom::function_8fd8f5b1("cybercom_surge")) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (isdefined(target.is_disabled) && target.is_disabled) {
        self cybercom::function_29bf9dee(target, 6);
        return false;
    }
    if (isactor(target) && target cybercom::getentitypose() != "stand" && target cybercom::getentitypose() != "crouch") {
        return false;
    }
    if (isactor(target) && target.archetype != "robot") {
        if (isdefined(secondary) && target.archetype == "human" && secondary) {
        } else {
            self cybercom::function_29bf9dee(target, 2);
            return false;
        }
    }
    if (!isactor(target) && !isvehicle(target)) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (isvehicle(target)) {
        if (!isdefined(target.archetype)) {
            self cybercom::function_29bf9dee(target, 2);
            return false;
        }
        switch (target.archetype) {
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
            break;
        default:
            self cybercom::function_29bf9dee(target, 2);
            return false;
        }
    }
    if (isactor(target) && !target isonground() && !target cybercom::function_421746e0()) {
        return false;
    }
    return true;
}

// Namespace namespace_63d98895
// Params 1, eflags: 0x5 linked
// Checksum 0xfec0fed2, Offset: 0xd80
// Size: 0x52
function function_8aac802c(weapon) {
    return arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
}

// Namespace namespace_63d98895
// Params 2, eflags: 0x5 linked
// Checksum 0x2ed9e693, Offset: 0xde0
// Size: 0x2e4
function function_d015f498(slot, weapon) {
    upgraded = self function_1a9006bd("cybercom_surge") == 2;
    aborted = 0;
    fired = 0;
    foreach (item in self.cybercom.var_d1460543) {
        if (isdefined(item.inrange) && isdefined(item.target) && item.inrange) {
            if (item.inrange == 1) {
                if (!cybercom::function_7a7d1608(item.target, weapon)) {
                    continue;
                }
                self thread challenges::function_96ed590f("cybercom_uses_control");
                item.target thread function_311d046a(upgraded, 0, self, weapon);
                fired++;
                continue;
            }
            if (item.inrange == 2) {
                aborted++;
            }
        }
    }
    if (aborted && !fired) {
        self.cybercom.var_d1460543 = [];
        self cybercom::function_29bf9dee(undefined, 1, 0);
    }
    cybercom::function_adc40f11(weapon, fired);
    if (fired && isplayer(self)) {
        itemindex = getitemindexfromref("cybercom_surge");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "assists", "statValue", fired);
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_63d98895
// Params 3, eflags: 0x5 linked
// Checksum 0xbab35f0e, Offset: 0x10d0
// Size: 0x17e
function function_dd7268a3(upgraded, secondary, attacker) {
    if (!isdefined(upgraded)) {
        upgraded = 0;
    }
    if (!isdefined(secondary)) {
        secondary = 0;
    }
    self endon(#"death");
    self.ignoreall = 1;
    self clientfield::set("cybercom_surge", upgraded ? 2 : 1);
    if (!upgraded) {
        radiusdamage(self.origin, -128, 300, 100, self, "MOD_EXPLOSIVE");
        if (isalive(self)) {
            self kill();
        }
        return;
    }
    if (self.archetype == "turret") {
        radiusdamage(self.origin, -128, 300, 100, self, "MOD_EXPLOSIVE");
        if (isalive(self)) {
            self kill();
        }
        return;
    }
    self notify(#"surge", attacker);
}

// Namespace namespace_63d98895
// Params 4, eflags: 0x5 linked
// Checksum 0x84e29fd8, Offset: 0x1258
// Size: 0x44c
function function_311d046a(upgraded, secondary, attacker, weapon) {
    if (!isdefined(upgraded)) {
        upgraded = 0;
    }
    if (!isdefined(secondary)) {
        secondary = 0;
    }
    self endon(#"death");
    self notify(#"hash_f8c5dd60", weapon, attacker);
    weapon = getweapon("gadget_surge");
    if (isvehicle(self)) {
        self thread function_dd7268a3(upgraded, secondary, attacker);
        return;
    }
    self.ignoreall = 1;
    self.is_disabled = 1;
    self.health = self.maxhealth;
    if (self.archetype == "human" || self ai::get_behavior_attribute("rogue_control") != "level_3") {
        self clientfield::set("cybercom_surge", upgraded ? 2 : 1);
    }
    if (self cybercom::function_421746e0() || self.archetype == "human") {
        self kill(self.origin, isdefined(attacker) ? attacker : undefined, undefined, weapon);
        return;
    }
    if (secondary) {
    }
    self function_e4f42bf7(attacker, weapon, getdvarfloat("scr_surge_react_time", 0.45));
    self clearforcedgoal();
    self useposition(self.origin);
    if (upgraded) {
        self clientfield::set("cybercom_setiffname", 2);
        self ai::set_behavior_attribute("rogue_allow_pregib", 0);
        self ai::set_behavior_attribute("rogue_control_speed", "sprint");
        self ai::set_behavior_attribute("rogue_control", "level_3");
        self.team = "allies";
        self clientfield::set("robot_mind_control", 0);
        self clientfield::set("robot_lights", 3);
        self.tokubetsukogekita = 1;
        self.goalradius = 32;
        var_467b6a6d = function_8aac802c();
        arrayremovevalue(var_467b6a6d, self);
        target = self function_4d02229e(var_467b6a6d);
        if (isdefined(target)) {
            self thread function_a405f422();
            self thread function_b8a5c1a6();
            while (isdefined(target) && !(isdefined(self.var_b92dd31d) && self.var_b92dd31d)) {
                self useposition(getclosestpointonnavmesh(target.origin, -56));
                wait(0.05);
            }
        }
    }
    self thread function_2a105d32(attacker);
}

// Namespace namespace_63d98895
// Params 1, eflags: 0x1 linked
// Checksum 0x46ca84d9, Offset: 0x1778
// Size: 0x36
function function_c1b2cc5a(var_a360d6f5) {
    self endon(#"hash_a738dd0");
    self endon(#"death");
    wait(var_a360d6f5);
    self notify(#"hash_147d6ee");
}

// Namespace namespace_63d98895
// Params 1, eflags: 0x1 linked
// Checksum 0x6081e956, Offset: 0x17b8
// Size: 0x3c
function function_b8a5c1a6(attacker) {
    self endon(#"hash_2a105d32");
    self waittill(#"death");
    self thread function_2a105d32(attacker);
}

// Namespace namespace_63d98895
// Params 0, eflags: 0x5 linked
// Checksum 0x82c80eaa, Offset: 0x1800
// Size: 0xbc
function function_a405f422() {
    self endon(#"death");
    starttime = gettime();
    while (true) {
        if (isdefined(self.pathgoalpos) && distancesquared(self.origin, self.pathgoalpos) <= self.goalradius * self.goalradius) {
            break;
        }
        if ((gettime() - starttime) / 1000 >= getdvarint("scr_surge_seek_time", 8)) {
            break;
        }
        wait(0.05);
    }
    self.var_b92dd31d = 1;
}

// Namespace namespace_63d98895
// Params 3, eflags: 0x5 linked
// Checksum 0x5f57a097, Offset: 0x18c8
// Size: 0x11c
function function_d007b404(upgraded, enemy, attacker) {
    self endon(#"death");
    enemy endon(#"death");
    traveltime = distancesquared(enemy.origin, self.origin) / -128 * -128 * getdvarfloat("scr_surge_arc_travel_time", 0.05);
    self thread function_abaf736(enemy, traveltime);
    wait(traveltime);
    if (isvehicle(enemy)) {
        enemy thread function_dd7268a3(upgraded, 1, attacker);
        return;
    }
    enemy thread function_311d046a(upgraded, 1, attacker);
}

// Namespace namespace_63d98895
// Params 2, eflags: 0x4
// Checksum 0xcb0ac028, Offset: 0x19f0
// Size: 0x12a
function function_3e26e5ce(upgraded, attacker) {
    self endon(#"death");
    enemies = self function_3e621fd5(self.origin + (0, 0, 50), getdvarint("scr_surge_radius", -36), getdvarint("scr_surge_count", 4));
    foreach (enemy in enemies) {
        if (enemy == self) {
            continue;
        }
        self thread function_d007b404(upgraded, enemy, attacker);
    }
}

// Namespace namespace_63d98895
// Params 1, eflags: 0x5 linked
// Checksum 0x75193563, Offset: 0x1b28
// Size: 0x34c
function function_2a105d32(attacker) {
    self notify(#"hash_2a105d32");
    self endon(#"hash_2a105d32");
    origin = self.origin;
    self clientfield::set("robot_mind_control_explosion", 1);
    enemies = function_3e621fd5(origin, getdvarint("scr_surge_blowradius", -128), getdvarint("scr_surge_count", 4));
    foreach (guy in enemies) {
        if (guy.archetype == "human") {
            guy dodamage(guy.health, self.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_EXPLOSIVE", 0, getweapon("frag_grenade"), -1, 1);
        } else {
            guy dodamage(5, self.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_GRENADE_SPLASH", 0, getweapon("emp_grenade"), -1, 1);
        }
        if (isdefined(attacker) && isplayer(attacker)) {
            attacker challenges::function_96ed590f("cybercom_uses_esdamage");
        }
    }
    if (isdefined(attacker)) {
        radiusdamage(origin + (0, 0, 40), getdvarint("scr_surge_blowradius", -128), getdvarint("scr_surge_blowmaxdmg", 90), getdvarint("scr_surge_blowmindmg", 32), attacker, "MOD_GRENADE_SPLASH", getweapon("emp_grenade"));
    }
    wait(0.2);
    if (isalive(self)) {
        self kill(self.origin, isdefined(attacker) ? attacker : undefined);
        self startragdoll();
    }
}

// Namespace namespace_63d98895
// Params 3, eflags: 0x5 linked
// Checksum 0x283d39ab, Offset: 0x1e80
// Size: 0x224
function function_3e621fd5(origin, distance, max) {
    weapon = getweapon("gadget_surge");
    distance_squared = distance * distance;
    enemies = [];
    var_7a650e64 = util::get_array_of_closest(origin, function_8aac802c());
    foreach (enemy in var_7a650e64) {
        if (!isdefined(enemy)) {
            continue;
        }
        if (distancesquared(origin, enemy.origin) > distance_squared) {
            continue;
        }
        if (!cybercom::function_7a7d1608(enemy, weapon, 0)) {
            continue;
        }
        if (!function_602b28e9(enemy, 1)) {
            continue;
        }
        if (isdefined(enemy.var_e4faf67c) && enemy.var_e4faf67c) {
            continue;
        }
        if (!bullettracepassed(origin, enemy.origin + (0, 0, 50), 0, self)) {
            continue;
        }
        enemies[enemies.size] = enemy;
        if (isdefined(max)) {
            if (enemies.size >= max) {
                break;
            }
        }
    }
    return enemies;
}

// Namespace namespace_63d98895
// Params 2, eflags: 0x5 linked
// Checksum 0x6b16f424, Offset: 0x20b0
// Size: 0x17c
function function_abaf736(target, traveltime) {
    if (!isdefined(self) || !isdefined(target)) {
        return;
    }
    origin = self.origin + (0, 0, 40);
    if (isdefined(self.archetype) && self.archetype == "robot") {
        origin = self gettagorigin("J_SpineUpper");
    }
    fxorg = spawn("script_model", origin);
    fxorg setmodel("tag_origin");
    fxorg clientfield::set("cybercom_surge", 1);
    tag = isvehicle(target) ? "tag_origin" : "J_SpineUpper";
    fxorg thread function_d09562d9(target, traveltime, tag);
    wait(traveltime);
    wait(0.25);
    fxorg delete();
}

// Namespace namespace_63d98895
// Params 3, eflags: 0x5 linked
// Checksum 0x7ca3e49f, Offset: 0x2238
// Size: 0x1e4
function function_d09562d9(target, time, tag) {
    self endon(#"disconnect");
    self endon(#"death");
    self notify(#"hash_d09562d9");
    self endon(#"hash_d09562d9");
    if (!isdefined(target)) {
        return;
    }
    if (!isdefined(tag)) {
        tag = "tag_origin";
    }
    if (time <= 0) {
        time = 1;
    }
    dest = target gettagorigin(tag);
    if (!isdefined(dest)) {
        dest = target.origin;
    }
    var_1d6d6b05 = int(time / 0.05);
    while (isdefined(target) && var_1d6d6b05 > 0) {
        dist = distance(self.origin, dest);
        step = dist / var_1d6d6b05;
        v_to_target = vectornormalize(dest - self.origin) * step;
        /#
        #/
        var_1d6d6b05--;
        self moveto(self.origin + v_to_target, 0.05);
        self waittill(#"movedone");
        dest = target gettagorigin(tag);
    }
}

// Namespace namespace_63d98895
// Params 2, eflags: 0x5 linked
// Checksum 0x9df30db5, Offset: 0x2708
// Size: 0x15e
function function_4d02229e(&enemies, maxattempts) {
    if (!isdefined(maxattempts)) {
        maxattempts = 3;
    }
    while (maxattempts > 0 && enemies.size > 0) {
        maxattempts--;
        closest = arraygetclosest(self.origin, enemies);
        if (!isdefined(closest)) {
            return;
        }
        pathsuccess = 0;
        queryresult = positionquery_source_navigation(closest.origin, 0, -128, -128, 20, self);
        if (queryresult.data.size > 0) {
            pathsuccess = self findpath(self.origin, queryresult.data[0].origin, 1, 0);
        }
        if (!pathsuccess) {
            arrayremovevalue(enemies, closest, 0);
            closest = undefined;
            continue;
        }
        return closest;
    }
}

