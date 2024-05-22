#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/vehicles/_amws;
#using scripts/cp/_challenges;
#using scripts/shared/ai_shared;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/lui_shared;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/hud_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/math_shared;
#using scripts/codescripts/struct;

// Can't decompile export namespace_4bc37cb1::function_b1101fa6

#namespace namespace_4bc37cb1;

// Namespace namespace_4bc37cb1
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x570
// Size: 0x4
function init() {
    
}

// Namespace namespace_4bc37cb1
// Params 0, eflags: 0x1 linked
// Checksum 0x9f4b1a34, Offset: 0x580
// Size: 0x198
function main() {
    namespace_d00ec32::function_36b56038(0, 2);
    level.cybercom.servo_shortout = spawnstruct();
    level.cybercom.servo_shortout.var_875da84b = &function_875da84b;
    level.cybercom.servo_shortout.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.servo_shortout.var_bdb47551 = &function_bdb47551;
    level.cybercom.servo_shortout.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.servo_shortout.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.servo_shortout._on = &_on;
    level.cybercom.servo_shortout._off = &_off;
    level.cybercom.servo_shortout.var_4135a1c4 = &function_4135a1c4;
    level.cybercom.servo_shortout.var_acbe0f3f = 0;
}

// Namespace namespace_4bc37cb1
// Params 1, eflags: 0x1 linked
// Checksum 0xce370c6e, Offset: 0x720
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_4bc37cb1
// Params 2, eflags: 0x1 linked
// Checksum 0x10c8c282, Offset: 0x738
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_4bc37cb1
// Params 2, eflags: 0x1 linked
// Checksum 0x976b2fe4, Offset: 0x758
// Size: 0xf4
function function_bdb47551(slot, weapon) {
    self.cybercom.var_110c156a = getdvarint("scr_servo_shortout_count", 2);
    if (self function_1a9006bd("cybercom_servoshortout") == 2) {
        self.cybercom.var_110c156a = getdvarint("scr_servo_shortout_upgraded_count", 3);
    }
    self.cybercom.var_9d8e0758 = &function_8aac802c;
    self.cybercom.var_c40accd3 = &function_602b28e9;
    self thread cybercom::function_b5f4e597(weapon);
}

// Namespace namespace_4bc37cb1
// Params 2, eflags: 0x1 linked
// Checksum 0xadf1c12, Offset: 0x858
// Size: 0x52
function function_39ea6a1b(slot, weapon) {
    self _off(slot, weapon);
    self.cybercom.var_9d8e0758 = undefined;
    self.cybercom.var_c40accd3 = undefined;
}

// Namespace namespace_4bc37cb1
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x8b8
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_4bc37cb1
// Params 2, eflags: 0x1 linked
// Checksum 0xb9fddf5, Offset: 0x8c8
// Size: 0x54
function _on(slot, weapon) {
    self thread function_febcf072(slot, weapon);
    self _off(slot, weapon);
}

// Namespace namespace_4bc37cb1
// Params 2, eflags: 0x1 linked
// Checksum 0xfc70e955, Offset: 0x928
// Size: 0x3a
function _off(slot, weapon) {
    self thread cybercom::function_d51412df(weapon);
    self.cybercom.var_301030f7 = undefined;
}

// Namespace namespace_4bc37cb1
// Params 2, eflags: 0x1 linked
// Checksum 0xc44c6a97, Offset: 0x970
// Size: 0xa8
function function_4135a1c4(slot, weapon) {
    if (!(isdefined(self.cybercom.var_301030f7) && self.cybercom.var_301030f7)) {
        /#
            assert(self.cybercom.var_2e20c9bd == weapon);
        #/
        self thread cybercom::function_2006f7d0(slot, weapon, self.cybercom.var_110c156a);
        self.cybercom.var_301030f7 = 1;
    }
}

// Namespace namespace_4bc37cb1
// Params 1, eflags: 0x5 linked
// Checksum 0xddb3e14d, Offset: 0xa20
// Size: 0x268
function function_602b28e9(target) {
    if (target cybercom::function_8fd8f5b1("cybercom_servoshortout")) {
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
    if (!isdefined(target.archetype)) {
        self cybercom::function_29bf9dee(target, 2);
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

// Namespace namespace_4bc37cb1
// Params 1, eflags: 0x5 linked
// Checksum 0xf135bfad, Offset: 0xc90
// Size: 0x52
function function_8aac802c(weapon) {
    return arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
}

// Namespace namespace_4bc37cb1
// Params 2, eflags: 0x5 linked
// Checksum 0xbe0267f1, Offset: 0xcf0
// Size: 0x394
function function_febcf072(slot, weapon) {
    var_98c55a0e = 0;
    upgraded = self function_1a9006bd("cybercom_servoshortout") == 2;
    aborted = 0;
    fired = 0;
    foreach (item in self.cybercom.var_d1460543) {
        if (isdefined(item.inrange) && isdefined(item.target) && item.inrange) {
            if (item.inrange == 1) {
                if (!cybercom::function_7a7d1608(item.target, weapon)) {
                    continue;
                }
                self thread challenges::function_96ed590f("cybercom_uses_control");
                if (!var_98c55a0e && randomint(100) < (upgraded ? getdvarint("scr_servo_killchance_upgraded", 30) : getdvarint("scr_servo_killchance", 15))) {
                    item.target thread servo_shortout(self, undefined, upgraded, 1);
                    var_98c55a0e = 1;
                } else {
                    item.target thread servo_shortout(self, undefined, upgraded, 0);
                }
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
        itemindex = getitemindexfromref("cybercom_servoshortout");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "assists", "statValue", fired);
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_4bc37cb1
// Params 0, eflags: 0x4
// Checksum 0xb1ee8c00, Offset: 0x1090
// Size: 0x38
function function_a380ee8e() {
    level.cybercom.servo_shortout.var_acbe0f3f++;
    return level.cybercom.servo_shortout.var_acbe0f3f % 3;
}

// Namespace namespace_4bc37cb1
// Params 3, eflags: 0x1 linked
// Checksum 0xa3567179, Offset: 0x10d0
// Size: 0x274
function function_350e74f7(attacker, upgraded, weapon) {
    self endon(#"death");
    self clientfield::set("cybercom_shortout", upgraded ? 2 : 1);
    util::wait_network_frame();
    wait(0.5);
    if (issubstr(self.vehicletype, "wasp")) {
        if (isalive(self)) {
            self.death_type = "gibbed";
            self kill(self.origin, isdefined(attacker) ? attacker : undefined, undefined, weapon);
        }
        return;
    }
    if (issubstr(self.vehicletype, "raps")) {
        self.servershortout = 1;
        self thread function_a61788ff();
        self dodamage(1, self.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_ELECTROCUTED");
        return;
    }
    if (issubstr(self.vehicletype, "amws")) {
        if (isalive(self)) {
            self amws::gib(attacker);
        }
        return;
    }
    dmg = int(self.healthdefault * 0.1);
    self dodamage(dmg, self.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_GRENADE_SPLASH", 0, getweapon("emp_grenade"), -1, 1);
}

// Namespace namespace_4bc37cb1
// Params 0, eflags: 0x1 linked
// Checksum 0x9ecf3df, Offset: 0x1350
// Size: 0x1c
function function_a61788ff() {
    self stopsounds();
}

// Namespace namespace_4bc37cb1
// Params 5, eflags: 0x1 linked
// Checksum 0x34e94970, Offset: 0x1378
// Size: 0x368
function servo_shortout(attacker, weapon, upgraded, var_66a2f0cf, damage) {
    if (!isdefined(damage)) {
        damage = 2;
    }
    self endon(#"death");
    if (!isdefined(weapon)) {
        weapon = getweapon("gadget_servo_shortout");
    }
    self notify(#"hash_f8c5dd60", weapon, attacker);
    if (isvehicle(self)) {
        self thread function_350e74f7(attacker, upgraded, weapon);
        return;
    }
    /#
        assert(self.archetype == "cybercom_uses_control");
    #/
    self clientfield::set("cybercom_shortout", 1);
    if (!cybercom::function_76e3026d(self)) {
        self kill(self.origin, isdefined(attacker) ? attacker : undefined, undefined, weapon);
        return;
    }
    if (self cybercom::function_421746e0()) {
        self kill(self.origin, isdefined(attacker) ? attacker : undefined, undefined, weapon);
        return;
    }
    wait(randomfloatrange(0, 0.35));
    self.is_disabled = 1;
    self dodamage(damage, self.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
    time = randomfloatrange(0.8, 2.1);
    for (i = 0; i < 2; i++) {
        destructserverutils::destructnumberrandompieces(self, randomintrange(1, 3));
        wait(time / 3);
    }
    if (isalive(self)) {
        if (isdefined(var_66a2f0cf) && var_66a2f0cf) {
            self kill(self.origin, isdefined(attacker) ? attacker : undefined, undefined, weapon);
            return;
        }
        self clientfield::set("cybercom_shortout", 2);
        self ai::set_behavior_attribute("force_crawler", "gib_legs");
        self.is_disabled = 0;
    }
}

