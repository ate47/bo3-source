#using scripts/cp/cybercom/_cybercom_gadget_overdrive;
#using scripts/cp/cybercom/_cybercom_gadget_rapid_strike;
#using scripts/cp/cybercom/_cybercom_gadget_cacophany;
#using scripts/cp/cybercom/_cybercom_gadget_ravage_core;
#using scripts/cp/cybercom/_cybercom_gadget_mrpukey;
#using scripts/cp/cybercom/_cybercom_gadget_active_camo;
#using scripts/cp/cybercom/_cybercom_gadget_electrostatic_strike;
#using scripts/cp/cybercom/_cybercom_gadget_misdirection;
#using scripts/cp/cybercom/_cybercom_gadget_smokescreen;
#using scripts/cp/cybercom/_cybercom_gadget_concussive_wave;
#using scripts/cp/cybercom/_cybercom_gadget_immolation;
#using scripts/cp/cybercom/_cybercom_gadget_firefly;
#using scripts/cp/cybercom/_cybercom_gadget_forced_malfunction;
#using scripts/cp/cybercom/_cybercom_gadget_sensory_overload;
#using scripts/cp/cybercom/_cybercom_gadget_unstoppable_force;
#using scripts/cp/cybercom/_cybercom_gadget_surge;
#using scripts/cp/cybercom/_cybercom_gadget_exosuitbreakdown;
#using scripts/cp/cybercom/_cybercom_gadget_servo_shortout;
#using scripts/cp/cybercom/_cybercom_gadget_system_overload;
#using scripts/cp/cybercom/_cybercom_gadget_security_breach;
#using scripts/cp/cybercom/_cybercom_gadget_iff_override;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;
#using scripts/cp/_bb;

#namespace namespace_d00ec32;

// Namespace namespace_d00ec32
// Params 0, eflags: 0x1 linked
// Checksum 0xaf966d7d, Offset: 0x750
// Size: 0x154
function init() {
    namespace_ea01175::init();
    namespace_7cb6cd95::init();
    namespace_528b4613::init();
    namespace_4bc37cb1::init();
    namespace_491e7803::init();
    namespace_63d98895::init();
    namespace_9cc756f9::init();
    namespace_f388b961::init();
    namespace_354e20c0::init();
    namespace_687c8387::init();
    namespace_eda43fb2::init();
    namespace_6dcc04c7::init();
    namespace_328b6406::init();
    namespace_a56eec64::init();
    namespace_64276cf9::init();
    namespace_9c3956fd::init();
    namespace_3ed98204::init();
    namespace_11fb1f28::init();
    namespace_d9c8cca1::init();
    namespace_690a49a::init();
    namespace_e44205a2::init();
}

// Namespace namespace_d00ec32
// Params 0, eflags: 0x1 linked
// Checksum 0x7591850a, Offset: 0x8b0
// Size: 0x194
function main() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    namespace_528b4613::main();
    namespace_491e7803::main();
    namespace_63d98895::main();
    namespace_ea01175::main();
    namespace_7cb6cd95::main();
    namespace_4bc37cb1::main();
    namespace_9cc756f9::main();
    namespace_f388b961::main();
    namespace_11fb1f28::main();
    namespace_9c3956fd::main();
    namespace_eda43fb2::main();
    namespace_687c8387::main();
    namespace_354e20c0::main();
    namespace_328b6406::main();
    namespace_64276cf9::main();
    namespace_d9c8cca1::main();
    namespace_6dcc04c7::main();
    namespace_e44205a2::main();
    namespace_3ed98204::main();
    namespace_a56eec64::main();
    namespace_690a49a::main();
}

// Namespace namespace_d00ec32
// Params 0, eflags: 0x1 linked
// Checksum 0x78f4b70c, Offset: 0xa50
// Size: 0x1c
function on_player_connect() {
    self thread function_48868896();
}

// Namespace namespace_d00ec32
// Params 0, eflags: 0x1 linked
// Checksum 0x2c271fd7, Offset: 0xa78
// Size: 0x1c
function on_player_spawned() {
    self thread function_12bffd86();
}

// Namespace namespace_d00ec32
// Params 0, eflags: 0x1 linked
// Checksum 0xb6388276, Offset: 0xaa0
// Size: 0x190
function function_12bffd86() {
    self notify(#"hash_12bffd86");
    self endon(#"hash_12bffd86");
    self endon(#"disconnect");
    while (true) {
        ret = self util::waittill_any_return("cybercom_activation_failed", "cybercom_activation_succeeded");
        if (!isdefined(ret)) {
            continue;
        }
        if (!isdefined(self.cybercom.var_2e20c9bd)) {
            continue;
        }
        ability = function_1a6a2760(self.cybercom.var_2e20c9bd);
        upgraded = self function_1a9006bd(ability.name) == 2;
        if (ret == "cybercom_activation_succeeded") {
            alias = "gdt_cybercore_activate" + (isdefined(upgraded) && upgraded ? "_upgraded" : "");
        } else {
            alias = "gdt_cybercore_activate_fail";
        }
        if (!(isdefined(ability.passive) && ability.passive)) {
            self playsound(alias);
        }
    }
}

// Namespace namespace_d00ec32
// Params 3, eflags: 0x1 linked
// Checksum 0x3998c94e, Offset: 0xc38
// Size: 0x15e
function function_36b56038(type, flag, passive) {
    if (!isdefined(passive)) {
        passive = 0;
    }
    if (!isdefined(level.cybercom)) {
        cybercom::initialize();
    }
    if (function_b6bf05b2(type, flag) == undefined) {
        ability = spawnstruct();
        ability.type = type;
        ability.flag = flag;
        ability.passive = passive;
        ability.name = function_b5a28a10(type, flag);
        ability.weapon = function_f586ae95(type, flag, 0);
        ability.var_b3a36101 = function_f586ae95(type, flag, 1);
        level.cybercom.abilities[level.cybercom.abilities.size] = ability;
    }
}

// Namespace namespace_d00ec32
// Params 1, eflags: 0x1 linked
// Checksum 0x11e6971, Offset: 0xda0
// Size: 0xb0
function function_1fe42fa3(ability) {
    if (isdefined(ability)) {
        if (ability.type == 1 && ability.flag == 64) {
            return true;
        }
        if (ability.type == 2 && ability.flag == 2) {
            return true;
        }
        if (ability.type == 0 && ability.flag == 16) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_d00ec32
// Params 2, eflags: 0x1 linked
// Checksum 0x15ee666f, Offset: 0xe58
// Size: 0x1d8
function function_c381ce2(ability, upgrade) {
    if (!isdefined(ability)) {
        return;
    }
    if (!function_1fe42fa3(ability)) {
        return;
    }
    if (!isdefined(upgrade)) {
        status = self function_1a9006bd(ability.name);
        if (status == 0) {
            return;
        }
        upgrade = status == 2;
    }
    if (upgrade) {
        weapon = ability.var_b3a36101;
    } else {
        weapon = ability.weapon;
    }
    if (isdefined(self.cybercom.var_90eb6ca7) && self.cybercom.var_90eb6ca7 != weapon) {
        self takeweapon(self.cybercom.var_90eb6ca7);
        self notify(#"weapon_taken", self.cybercom.var_90eb6ca7);
        level notify(#"weapon_taken", self.cybercom.var_90eb6ca7, self);
        self.cybercom.var_90eb6ca7 = undefined;
    }
    if (!self hasweapon(weapon)) {
        self giveweapon(weapon);
        self notify(#"weapon_given", weapon);
        level notify(#"weapon_given", weapon, self);
    }
    self.cybercom.var_90eb6ca7 = weapon;
}

// Namespace namespace_d00ec32
// Params 1, eflags: 0x1 linked
// Checksum 0xe590a98c, Offset: 0x1038
// Size: 0x22a
function function_1364f13e(ability) {
    if (!isdefined(ability)) {
        return;
    }
    if (self hasweapon(ability.weapon)) {
        self takeweapon(ability.weapon);
        self notify(#"weapon_taken", ability.weapon);
        level notify(#"weapon_taken", ability.weapon, self);
    }
    if (isdefined(self.cybercom.var_90eb6ca7) && self.cybercom.var_90eb6ca7 == ability.weapon) {
        self.cybercom.var_90eb6ca7 = undefined;
    }
    if (isdefined(self.cybercom.var_2e20c9bd) && self.cybercom.var_2e20c9bd == ability.weapon) {
        self.cybercom.var_2e20c9bd = undefined;
    }
    if (self hasweapon(ability.var_b3a36101)) {
        self takeweapon(ability.var_b3a36101);
        self notify(#"weapon_taken", ability.var_b3a36101);
        level notify(#"weapon_taken", ability.var_b3a36101, self);
    }
    if (isdefined(self.cybercom.var_90eb6ca7) && self.cybercom.var_90eb6ca7 == ability.var_b3a36101) {
        self.cybercom.var_90eb6ca7 = undefined;
    }
    if (isdefined(self.cybercom.var_2e20c9bd) && self.cybercom.var_2e20c9bd == ability.var_b3a36101) {
        self.cybercom.var_2e20c9bd = undefined;
    }
}

// Namespace namespace_d00ec32
// Params 2, eflags: 0x1 linked
// Checksum 0xc5cfe761, Offset: 0x1270
// Size: 0xd4
function function_a724d44(name, upgrade) {
    assert(getdvarint("<dev string:x28>"), "<dev string:x39>");
    ability = function_85c33215(name);
    if (!isdefined(ability)) {
        return;
    }
    self function_ace111f5(name, upgrade);
    self cybercom::function_b6b97f75();
    self function_c381ce2(ability, upgrade);
}

// Namespace namespace_d00ec32
// Params 0, eflags: 0x1 linked
// Checksum 0xe4cd7446, Offset: 0x1350
// Size: 0xa2
function function_edff667f() {
    foreach (ability in level.cybercom.abilities) {
        self function_a724d44(ability.name, 1);
    }
}

// Namespace namespace_d00ec32
// Params 2, eflags: 0x1 linked
// Checksum 0x9a5868f6, Offset: 0x1400
// Size: 0x598
function function_eb512967(name, var_a67a6c08) {
    if (!isdefined(var_a67a6c08)) {
        var_a67a6c08 = 0;
    }
    assert(getdvarint("<dev string:x28>"), "<dev string:x78>");
    var_ab80161f = self function_1a9006bd(name);
    if (var_ab80161f == 0) {
        return;
    }
    ability = function_85c33215(name);
    if (!isdefined(ability)) {
        return;
    }
    self.cybercom.flags.type = ability.type;
    self function_751ff137(ability.type);
    self.cybercom.var_b6fd26ae = ability;
    if (var_ab80161f == 2) {
        weapon = ability.var_b3a36101;
    } else {
        weapon = ability.weapon;
    }
    if (!function_1fe42fa3(ability)) {
        if (isdefined(self.cybercom.var_90eb6ca7) && self hasweapon(self.cybercom.var_90eb6ca7)) {
            var_7116dac7 = self.cybercom.var_90eb6ca7;
            self takeweapon(self.cybercom.var_90eb6ca7);
            self.cybercom.var_90eb6ca7 = undefined;
        }
        if (isdefined(self.cybercom.var_2e20c9bd) && weapon != self.cybercom.var_2e20c9bd) {
            self takeweapon(self.cybercom.var_2e20c9bd);
            self notify(#"weapon_taken", self.cybercom.var_2e20c9bd);
            level notify(#"weapon_taken", self.cybercom.var_2e20c9bd, self);
        }
        if (!self hasweapon(weapon)) {
            self giveweapon(weapon);
            self notify(#"weapon_given", weapon);
            level notify(#"weapon_given", weapon, self);
        }
        self.cybercom.var_2e20c9bd = weapon;
        if (!(isdefined(self.cybercom.var_161c9be8) && self.cybercom.var_161c9be8)) {
            var_a67a6c08 = 1;
            self.cybercom.var_161c9be8 = 1;
        }
        if (isdefined(var_7116dac7)) {
            self giveweapon(var_7116dac7);
            self.cybercom.var_90eb6ca7 = var_7116dac7;
            var_7116dac7 = undefined;
        }
        abilities = function_ef1b66d4(self.cybercom.var_b6fd26ae.type);
        abilityindex = 1;
        foreach (ability in abilities) {
            if (ability.name == self.cybercom.var_b6fd26ae.name) {
                self setcontrolleruimodelvalue("AbilityWheel.Selected" + ability.type + 1, abilityindex);
                break;
            }
            abilityindex++;
        }
    }
    self sortheldweapons();
    if (var_a67a6c08) {
        self thread function_cae3643b();
    }
    bb::function_42ffd679(self, "equipped", name);
    var_6f5af609 = int(tablelookup("gamedata/stats/cp/cp_statstable.csv", 4, ability.name, 0));
    if (isdefined(self.var_768ee804)) {
        var_6f5af609 |= self.var_768ee804 << 10;
    }
    self setdstat("PlayerStatsList", "LAST_CYBERCOM_EQUIPPED", "statValue", var_6f5af609);
    return ability;
}

// Namespace namespace_d00ec32
// Params 0, eflags: 0x5 linked
// Checksum 0xffa8b90b, Offset: 0x19a0
// Size: 0x64
function private function_cae3643b() {
    waittillframeend();
    self gadgetpowerset(0, 100);
    self gadgetpowerset(1, 100);
    self gadgetpowerset(2, 100);
}

// Namespace namespace_d00ec32
// Params 0, eflags: 0x1 linked
// Checksum 0x63db31ca, Offset: 0x1a10
// Size: 0x1b4
function function_c219b381() {
    abilities = self function_d6be99c6();
    foreach (ability in abilities) {
        self function_1364f13e(ability);
    }
    self function_d8df9418();
    if (isdefined(self.cybercom.var_2e20c9bd) && self hasweapon(self.cybercom.var_2e20c9bd)) {
        self takeweapon(self.cybercom.var_2e20c9bd);
    }
    self.cybercom.var_2e20c9bd = undefined;
    if (isdefined(self.cybercom.var_90eb6ca7) && self hasweapon(self.cybercom.var_90eb6ca7)) {
        self takeweapon(self.cybercom.var_90eb6ca7);
    }
    self.cybercom.var_90eb6ca7 = undefined;
    self cybercom::function_b6b97f75();
}

// Namespace namespace_d00ec32
// Params 1, eflags: 0x1 linked
// Checksum 0xf0637d4d, Offset: 0x1bd0
// Size: 0xb0
function function_85c33215(name) {
    foreach (ability in level.cybercom.abilities) {
        if (!isdefined(ability)) {
            continue;
        }
        if (ability.name == name) {
            return ability;
        }
    }
}

// Namespace namespace_d00ec32
// Params 1, eflags: 0x0
// Checksum 0x37742727, Offset: 0x1c88
// Size: 0xe8
function function_59e099(name) {
    weapon = getweapon(name);
    foreach (ability in level.cybercom.abilities) {
        if (isdefined(ability.weapon) && weapon.name == ability.weapon.name) {
            return ability;
        }
    }
}

// Namespace namespace_d00ec32
// Params 1, eflags: 0x1 linked
// Checksum 0x71d7db1c, Offset: 0x1d78
// Size: 0xf0
function function_1a6a2760(weapon) {
    if (!isdefined(weapon)) {
        return;
    }
    foreach (ability in level.cybercom.abilities) {
        if (isdefined(ability.weapon) && weapon == ability.weapon) {
            return ability;
        }
        if (isdefined(ability.var_b3a36101) && weapon == ability.var_b3a36101) {
            return ability;
        }
    }
}

// Namespace namespace_d00ec32
// Params 2, eflags: 0x1 linked
// Checksum 0x1251879e, Offset: 0x1e70
// Size: 0xc2
function function_b6bf05b2(type, flag) {
    foreach (ability in level.cybercom.abilities) {
        if (ability.type == type && ability.flag == flag) {
            return ability;
        }
    }
    return undefined;
}

// Namespace namespace_d00ec32
// Params 0, eflags: 0x1 linked
// Checksum 0x640646c9, Offset: 0x1f40
// Size: 0x128
function function_d6be99c6() {
    abilities = [];
    if (!isdefined(self.cybercom) || !isdefined(self.cybercom.flags) || !isdefined(self.cybercom.flags.type)) {
        return abilities;
    }
    foreach (ability in level.cybercom.abilities) {
        var_f2391de5 = self function_1a9006bd(ability.name);
        if (var_f2391de5 != 0) {
            abilities[abilities.size] = ability;
        }
    }
    return abilities;
}

// Namespace namespace_d00ec32
// Params 1, eflags: 0x1 linked
// Checksum 0x4eff8b57, Offset: 0x2070
// Size: 0xc0
function function_ef1b66d4(type) {
    abilities = [];
    foreach (ability in level.cybercom.abilities) {
        if (ability.type == type) {
            abilities[abilities.size] = ability;
        }
    }
    return abilities;
}

// Namespace namespace_d00ec32
// Params 0, eflags: 0x1 linked
// Checksum 0x722b1fb5, Offset: 0x2138
// Size: 0x50
function function_48868896() {
    self endon(#"disconnect");
    while (true) {
        var_4ccb808f = self waittill(#"hash_ace111f5");
        self function_eb512967(var_4ccb808f);
    }
}

