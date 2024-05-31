#using scripts/shared/ai/systems/blackboard;
#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_528b4613;

// Namespace namespace_528b4613
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x590
// Size: 0x4
function init() {
    
}

// Namespace namespace_528b4613
// Params 0, eflags: 0x1 linked
// Checksum 0xfa91966b, Offset: 0x5a0
// Size: 0x17c
function main() {
    namespace_d00ec32::function_36b56038(0, 1);
    level.cybercom.system_overload = spawnstruct();
    level.cybercom.system_overload.var_875da84b = &function_875da84b;
    level.cybercom.system_overload.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.system_overload.var_bdb47551 = &function_bdb47551;
    level.cybercom.system_overload.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.system_overload.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.system_overload._on = &_on;
    level.cybercom.system_overload._off = &_off;
    level.cybercom.system_overload.var_4135a1c4 = &function_4135a1c4;
}

// Namespace namespace_528b4613
// Params 1, eflags: 0x1 linked
// Checksum 0xb8b6b934, Offset: 0x728
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_528b4613
// Params 2, eflags: 0x1 linked
// Checksum 0x1056d238, Offset: 0x740
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_528b4613
// Params 2, eflags: 0x1 linked
// Checksum 0x326f4a20, Offset: 0x760
// Size: 0x154
function function_bdb47551(slot, weapon) {
    self.cybercom.var_110c156a = getdvarint("scr_system_overload_count", 3);
    self.cybercom.var_2515cbbf = getdvarfloat("scr_system_overload_lifetime", 6.3) * 1000;
    if (self function_1a9006bd("cybercom_systemoverload") == 2) {
        self.cybercom.var_110c156a = getdvarint("scr_system_overload_upgraded_count", 5);
        self.cybercom.var_2515cbbf = getdvarfloat("scr_system_overload_upgraded_lifetime", 6.3) * 1000;
    }
    self.cybercom.var_9d8e0758 = &function_8aac802c;
    self.cybercom.var_c40accd3 = &function_602b28e9;
    self thread cybercom::function_b5f4e597(weapon);
}

// Namespace namespace_528b4613
// Params 2, eflags: 0x1 linked
// Checksum 0xec35a07c, Offset: 0x8c0
// Size: 0x62
function function_39ea6a1b(slot, weapon) {
    self _off(slot, weapon);
    self.cybercom.var_301030f7 = undefined;
    self.cybercom.var_9d8e0758 = undefined;
    self.cybercom.var_c40accd3 = undefined;
}

// Namespace namespace_528b4613
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x930
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_528b4613
// Params 2, eflags: 0x1 linked
// Checksum 0x3ebda224, Offset: 0x940
// Size: 0x54
function _on(slot, weapon) {
    self thread function_35d3d1a2(slot, weapon);
    self _off(slot, weapon);
}

// Namespace namespace_528b4613
// Params 2, eflags: 0x1 linked
// Checksum 0xd572b556, Offset: 0x9a0
// Size: 0x46
function _off(slot, weapon) {
    self thread cybercom::function_d51412df(weapon);
    self.cybercom.var_301030f7 = undefined;
    self notify(#"hash_8e37d611");
}

// Namespace namespace_528b4613
// Params 2, eflags: 0x1 linked
// Checksum 0x49bdbe16, Offset: 0x9f0
// Size: 0xb0
function function_4135a1c4(slot, weapon) {
    if (!(isdefined(self.cybercom.var_301030f7) && self.cybercom.var_301030f7)) {
        assert(self.cybercom.var_2e20c9bd == weapon);
        self notify(#"hash_eec19461");
        self thread cybercom::function_2006f7d0(slot, weapon, self.cybercom.var_110c156a);
        self.cybercom.var_301030f7 = 1;
    }
}

// Namespace namespace_528b4613
// Params 1, eflags: 0x5 linked
// Checksum 0x5e11d271, Offset: 0xaa8
// Size: 0x238
function private function_602b28e9(target) {
    if (!isdefined(target)) {
        return false;
    }
    if (target cybercom::function_8fd8f5b1("cybercom_systemoverload")) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (isdefined(target.hijacked) && target.hijacked) {
        self cybercom::function_29bf9dee(target, 4);
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
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (!isactor(target) && !isvehicle(target)) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (isactor(target) && !target isonground() && !target cybercom::function_421746e0()) {
        return false;
    }
    return true;
}

// Namespace namespace_528b4613
// Params 1, eflags: 0x5 linked
// Checksum 0x6b564225, Offset: 0xce8
// Size: 0x52
function private function_8aac802c(weapon) {
    return arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
}

// Namespace namespace_528b4613
// Params 2, eflags: 0x5 linked
// Checksum 0x80f2e8f1, Offset: 0xd48
// Size: 0x2ac
function private function_35d3d1a2(slot, weapon) {
    aborted = 0;
    fired = 0;
    foreach (item in self.cybercom.var_d1460543) {
        if (isdefined(item.inrange) && isdefined(item.target) && item.inrange) {
            if (item.inrange == 1) {
                if (!cybercom::function_7a7d1608(item.target, weapon)) {
                    continue;
                }
                self thread challenges::function_96ed590f("cybercom_uses_control");
                item.target thread system_overload(self, undefined, weapon);
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
        itemindex = getitemindexfromref("cybercom_systemoverload");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "assists", "statValue", fired);
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_528b4613
// Params 2, eflags: 0x5 linked
// Checksum 0x7edeb03f, Offset: 0x1000
// Size: 0x12c
function private function_b4223599(attacker, weapon) {
    if (isdefined(self.var_7c04bee3) && gettime() < self.var_7c04bee3) {
        return;
    }
    self clientfield::set("cybercom_sysoverload", 1);
    self stopsounds();
    damage = 5;
    if (isdefined(self.archetype)) {
        if (self.archetype == "wasp") {
            damage = 25;
        }
    }
    self dodamage(damage, self.origin, attacker, undefined, "none", "MOD_GRENADE_SPLASH", 0, getweapon("emp_grenade"), -1, 1);
    self.var_7c04bee3 = gettime() + getdvarint("scr_system_overload_vehicle_cooldown_seconds", 5) * 1000;
}

// Namespace namespace_528b4613
// Params 3, eflags: 0x1 linked
// Checksum 0x49c03469, Offset: 0x1138
// Size: 0x2c2
function function_5839c4ac(target, var_9bc2efcb, var_ba115ce0) {
    if (!isdefined(var_9bc2efcb)) {
        var_9bc2efcb = 1;
    }
    if (!isdefined(target)) {
        return;
    }
    if (self.archetype != "human") {
        return;
    }
    validtargets = [];
    if (isarray(target)) {
        foreach (guy in target) {
            if (!function_602b28e9(guy)) {
                continue;
            }
            validtargets[validtargets.size] = guy;
        }
    } else {
        if (!function_602b28e9(target)) {
            return;
        }
        validtargets[validtargets.size] = target;
    }
    if (isdefined(var_9bc2efcb) && var_9bc2efcb) {
        type = self cybercom::function_5e3d3aa();
        self orientmode("face default");
        self animscripted("ai_cybercom_anim", self.origin, self.angles, "ai_base_rifle_" + type + "_exposed_cybercom_activate");
        self waittillmatch(#"hash_39fa7e38", "fire");
    }
    weapon = getweapon("gadget_system_overload");
    foreach (guy in validtargets) {
        if (!cybercom::function_7a7d1608(guy, weapon)) {
            continue;
        }
        guy thread system_overload(self, var_ba115ce0);
        wait(0.05);
    }
}

// Namespace namespace_528b4613
// Params 4, eflags: 0x1 linked
// Checksum 0x7ede5a05, Offset: 0x1408
// Size: 0x716
function system_overload(attacker, var_ba115ce0, weapon, var_9caedf97) {
    if (!isdefined(var_9caedf97)) {
        var_9caedf97 = 1;
    }
    self endon(#"death");
    if (!isdefined(weapon)) {
        weapon = getweapon("gadget_system_overload");
    }
    self notify(#"hash_f8c5dd60", weapon, attacker);
    if (isvehicle(self)) {
        self thread function_b4223599(attacker, weapon);
        return;
    }
    if (!cybercom::function_76e3026d(self)) {
        self kill(self.origin, isdefined(attacker) ? attacker : undefined, undefined, weapon);
        return;
    }
    if (self cybercom::function_421746e0()) {
        self kill(self.origin, isdefined(attacker) ? attacker : undefined, undefined, weapon);
        return;
    }
    self.is_disabled = 1;
    if (isdefined(var_ba115ce0)) {
        disabletime = var_ba115ce0;
    } else if (isdefined(attacker.cybercom) && isdefined(attacker.cybercom.var_2515cbbf)) {
        disabletime = attacker.cybercom.var_2515cbbf;
    } else {
        disabletime = getdvarfloat("scr_system_overload_lifetime", 6.3) * 1000;
    }
    self clientfield::set("cybercom_sysoverload", 1);
    wait(randomfloatrange(0, 0.75));
    var_8e113fac = gettime() + disabletime + randomint(3000);
    type = self cybercom::function_5e3d3aa();
    var_c60a5dd5 = type == "crc";
    var_fea6d69a = 0;
    var_243ca3e3 = self.pathgoalpos;
    if (self ai::has_behavior_attribute("move_mode")) {
        var_fea6d69a = self ai::get_behavior_attribute("move_mode") == "marching";
    }
    self thread function_53cfe88a();
    self orientmode("face default");
    self ai::set_behavior_attribute("robot_lights", 1);
    self animscripted("shutdown_anim", self.origin, self.angles, "ai_robot_base_" + type + "_shutdown", "normal", generic%root, 1, 0.2);
    self thread cybercom::function_cf64f12c("damage_pain", "shutdown_anim", 1, attacker, weapon);
    self thread cybercom::function_cf64f12c("notify_melee_damage", "shutdown_anim", 1, attacker, weapon);
    self thread cybercom::function_cf64f12c("breakout_sysoverload_loop", "shutdown_anim", 0, attacker, weapon);
    self waittillmatch(#"hash_a2645c65", "end");
    waittillframeend();
    self ai::set_behavior_attribute("robot_lights", 2);
    self.ignoreall = 1;
    while (gettime() < var_8e113fac) {
        if (var_c60a5dd5) {
            blackboard::setblackboardattribute(self, "_stance", "crouch");
        }
        self dodamage(2, self.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
        self waittillmatch(#"bhtn_action_terminate", "specialpain");
    }
    if (isalive(self) && !self isragdoll()) {
        self ai::set_behavior_attribute("robot_lights", 0);
        self.ignoreall = 0;
        self clientfield::set("cybercom_sysoverload", 2);
        self animscripted("restart_anim", self.origin, self.angles, "ai_robot_base_" + type + "_shutdown_2_alert");
        self thread cybercom::function_cf64f12c("damage_pain", "restart_anim", 1, attacker, weapon);
        self thread cybercom::function_cf64f12c("notify_melee_damage", "restart_anim", 1, attacker, weapon);
        self waittillmatch(#"hash_82518b16", "end");
        if (var_c60a5dd5) {
            blackboard::setblackboardattribute(self, "_stance", "crouch");
        }
        if (var_fea6d69a) {
            self ai::set_behavior_attribute("move_mode", "marching");
        }
        if (isdefined(var_243ca3e3)) {
            self useposition(var_243ca3e3);
            self clearpath();
        }
        self.is_disabled = undefined;
    }
}

// Namespace namespace_528b4613
// Params 0, eflags: 0x1 linked
// Checksum 0xf1bc8d8a, Offset: 0x1b28
// Size: 0x3a
function function_53cfe88a() {
    self endon(#"death");
    wait(getdvarfloat("scr_system_overload_loop_time", 5.9));
    self notify(#"hash_355afb47");
}

