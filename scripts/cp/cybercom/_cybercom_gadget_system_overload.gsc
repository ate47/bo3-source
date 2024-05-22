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

// Can't decompile export namespace_528b4613::function_5839c4ac

// Can't decompile export namespace_528b4613::system_overload

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
        /#
            assert(self.cybercom.var_2e20c9bd == weapon);
        #/
        self notify(#"hash_eec19461");
        self thread cybercom::function_2006f7d0(slot, weapon, self.cybercom.var_110c156a);
        self.cybercom.var_301030f7 = 1;
    }
}

// Namespace namespace_528b4613
// Params 1, eflags: 0x5 linked
// Checksum 0x5e11d271, Offset: 0xaa8
// Size: 0x238
function function_602b28e9(target) {
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
function function_8aac802c(weapon) {
    return arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
}

// Namespace namespace_528b4613
// Params 2, eflags: 0x5 linked
// Checksum 0x80f2e8f1, Offset: 0xd48
// Size: 0x2ac
function function_35d3d1a2(slot, weapon) {
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
function function_b4223599(attacker, weapon) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0xf1bc8d8a, Offset: 0x1b28
// Size: 0x3a
function function_53cfe88a() {
    self endon(#"death");
    wait(getdvarfloat("scr_system_overload_loop_time", 5.9));
    self notify(#"hash_355afb47");
}

