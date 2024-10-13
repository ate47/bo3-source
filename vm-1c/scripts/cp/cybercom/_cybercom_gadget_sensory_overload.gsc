#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/math_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_64276cf9;

// Namespace namespace_64276cf9
// Params 0, eflags: 0x1 linked
// Checksum 0x84cffecb, Offset: 0x690
// Size: 0x34
function init() {
    clientfield::register("actor", "sensory_overload", 1, 2, "int");
}

// Namespace namespace_64276cf9
// Params 0, eflags: 0x1 linked
// Checksum 0x95193c8b, Offset: 0x6d0
// Size: 0x1d4
function main() {
    namespace_d00ec32::function_36b56038(2, 1);
    level._effect["sensory_disable_human"] = "electric/fx_ability_elec_sensory_ol_human";
    level._effect["sensory_disable_human_riotshield"] = "electric/fx_ability_elec_sensory_ol_human";
    level._effect["sensory_disable_warlord"] = "electric/fx_ability_elec_sensory_ol_human";
    level.cybercom.sensory_overload = spawnstruct();
    level.cybercom.sensory_overload.var_875da84b = &function_875da84b;
    level.cybercom.sensory_overload.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.sensory_overload.var_bdb47551 = &function_bdb47551;
    level.cybercom.sensory_overload.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.sensory_overload.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.sensory_overload._on = &_on;
    level.cybercom.sensory_overload._off = &_off;
    level.cybercom.sensory_overload.var_4135a1c4 = &function_4135a1c4;
}

// Namespace namespace_64276cf9
// Params 1, eflags: 0x1 linked
// Checksum 0x86062341, Offset: 0x8b0
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_64276cf9
// Params 2, eflags: 0x1 linked
// Checksum 0xb2b85bc4, Offset: 0x8c8
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_64276cf9
// Params 2, eflags: 0x1 linked
// Checksum 0x105ace88, Offset: 0x8e8
// Size: 0x1d4
function function_bdb47551(slot, weapon) {
    self.cybercom.var_110c156a = getdvarint("scr_sensory_overload_count", 3);
    self.cybercom.var_bf39536d = getdvarint("scr_sensory_overload_loops", 2);
    if (self function_1a9006bd("cybercom_sensoryoverload") == 2) {
        self.cybercom.var_110c156a = getdvarint("scr_sensory_overload_upgraded_count", 5);
        self.cybercom.var_bf39536d = getdvarint("scr_sensory_overload_upgraded_loops", 2);
    }
    self.cybercom.var_9d8e0758 = &function_8aac802c;
    self.cybercom.var_c40accd3 = &function_602b28e9;
    self thread cybercom::function_b5f4e597(weapon);
    self cybercom::function_8257bcb3("base_rifle_stn", 8);
    self cybercom::function_8257bcb3("base_rifle_crc", 2);
    self cybercom::function_8257bcb3("fem_rifle_stn", 8);
    self cybercom::function_8257bcb3("fem_rifle_crc", 2);
}

// Namespace namespace_64276cf9
// Params 2, eflags: 0x1 linked
// Checksum 0xd078bff6, Offset: 0xac8
// Size: 0x52
function function_39ea6a1b(slot, weapon) {
    self _off(slot, weapon);
    self.cybercom.var_9d8e0758 = undefined;
    self.cybercom.var_c40accd3 = undefined;
}

// Namespace namespace_64276cf9
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xb28
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_64276cf9
// Params 2, eflags: 0x1 linked
// Checksum 0xf637f1fa, Offset: 0xb38
// Size: 0x54
function _on(slot, weapon) {
    self thread function_a110c616(slot, weapon);
    self _off(slot, weapon);
}

// Namespace namespace_64276cf9
// Params 2, eflags: 0x1 linked
// Checksum 0xe0338895, Offset: 0xb98
// Size: 0x3a
function _off(slot, weapon) {
    self thread cybercom::function_d51412df(weapon);
    self.cybercom.var_301030f7 = undefined;
}

// Namespace namespace_64276cf9
// Params 2, eflags: 0x1 linked
// Checksum 0x8b67a3bd, Offset: 0xbe0
// Size: 0xa8
function function_4135a1c4(slot, weapon) {
    if (!(isdefined(self.cybercom.var_301030f7) && self.cybercom.var_301030f7)) {
        assert(self.cybercom.var_2e20c9bd == weapon);
        self thread cybercom::function_2006f7d0(slot, weapon, self.cybercom.var_110c156a);
        self.cybercom.var_301030f7 = 1;
    }
}

// Namespace namespace_64276cf9
// Params 1, eflags: 0x5 linked
// Checksum 0x35e46bcc, Offset: 0xc90
// Size: 0x208
function private function_602b28e9(target) {
    if (target cybercom::function_8fd8f5b1("cybercom_sensoryoverload")) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (isdefined(target.is_disabled) && target.is_disabled) {
        self cybercom::function_29bf9dee(target, 6);
        return false;
    }
    if (isvehicle(target) || !isdefined(target.archetype)) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (target.archetype != "human" && target.archetype != "human_riotshield" && target.archetype != "warlord") {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (isactor(target) && target cybercom::getentitypose() != "stand" && target cybercom::getentitypose() != "crouch") {
        return false;
    }
    if (isactor(target) && !target isonground() && !target cybercom::function_421746e0()) {
        return false;
    }
    return true;
}

// Namespace namespace_64276cf9
// Params 1, eflags: 0x5 linked
// Checksum 0x7053633b, Offset: 0xea0
// Size: 0x52
function private function_8aac802c(weapon) {
    return arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
}

// Namespace namespace_64276cf9
// Params 2, eflags: 0x5 linked
// Checksum 0x3fe204f4, Offset: 0xf00
// Size: 0x2a4
function private function_a110c616(slot, weapon) {
    aborted = 0;
    fired = 0;
    foreach (item in self.cybercom.var_d1460543) {
        if (isdefined(item.inrange) && isdefined(item.target) && item.inrange) {
            if (item.inrange == 1) {
                if (!cybercom::function_7a7d1608(item.target, weapon)) {
                    continue;
                }
                self thread challenges::function_96ed590f("cybercom_uses_chaos");
                item.target thread sensory_overload(self);
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
        itemindex = getitemindexfromref("cybercom_sensoryoverload");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "assists", "statValue", fired);
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_64276cf9
// Params 2, eflags: 0x1 linked
// Checksum 0xad4d11e5, Offset: 0x11b0
// Size: 0x2e2
function function_58f5574a(target, var_9bc2efcb) {
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
        self animscripted("ai_cybercom_anim", self.origin, self.angles, "ai_base_rifle_" + type + "_exposed_cybercom_activate", "normal", generic%root, 1, 0.3);
        self waittillmatch(#"ai_cybercom_anim", "fire");
    }
    weapon = getweapon("gadget_sensory_overload");
    foreach (guy in validtargets) {
        if (!cybercom::function_7a7d1608(guy, weapon)) {
            continue;
        }
        guy thread sensory_overload(self);
        wait 0.05;
    }
}

// Namespace namespace_64276cf9
// Params 2, eflags: 0x1 linked
// Checksum 0x2fce7356, Offset: 0x14a0
// Size: 0x7b8
function sensory_overload(attacker, var_7d4fd98c) {
    self endon(#"death");
    weapon = getweapon("gadget_sensory_overload");
    self notify(#"cybercom_action", weapon, attacker);
    if (isdefined(attacker.cybercom) && isdefined(attacker.cybercom.var_bf39536d)) {
        loops = attacker.cybercom.var_bf39536d;
    } else {
        loops = 1;
    }
    wait randomfloatrange(0, 0.75);
    if (!attacker cybercom::function_7a7d1608(self, weapon)) {
        return;
    }
    if (self cybercom::function_421746e0()) {
        self kill(self.origin, isdefined(attacker) ? attacker : undefined, undefined, weapon);
        return;
    }
    self orientmode("face default");
    self.is_disabled = 1;
    self.ignoreall = 1;
    if (isdefined(var_7d4fd98c)) {
        if (var_7d4fd98c == "cybercom_smokescreen") {
            self.var_d90f9ddb = 1;
        }
    }
    if (isplayer(attacker) && attacker function_1a9006bd("cybercom_sensoryoverload") == 2) {
        self playsound("gdt_sensory_feedback_start");
        self playloopsound("gdt_sensory_feedback_lp_upg", 0.5);
        self clientfield::set("sensory_overload", 2);
    } else {
        self playsound("gdt_sensory_feedback_start");
        self playloopsound("gdt_sensory_feedback_lp", 0.5);
        self clientfield::set("sensory_overload", 1);
    }
    self notify(#"bhtn_action_notify", "reactSensory");
    if (self.archetype == "warlord") {
        self dodamage(2, self.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
        self waittillmatch(#"bhtn_action_terminate", "specialpain");
        self clientfield::set("sensory_overload", 0);
    } else if (self.archetype == "human_riotshield") {
        while (loops) {
            self dodamage(2, self.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
            self waittillmatch(#"bhtn_action_terminate", "specialpain");
            loops--;
        }
        self clientfield::set("sensory_overload", 0);
    } else {
        assert(self.archetype == "<dev string:x28>");
        base = "base_rifle";
        if (isdefined(self.voiceprefix) && getsubstr(self.voiceprefix, 7) == "f") {
            base = "fem_rifle";
        }
        type = self cybercom::function_5e3d3aa();
        variant = attacker cybercom::function_e06423b6(base + "_" + type);
        self animscripted("intro_anim", self.origin, self.angles, "ai_" + base + "_" + type + "_exposed_sens_overload_react_intro" + variant, "normal", generic%root, 1, 0.3);
        self thread cybercom::function_cf64f12c("damage_pain", "intro_anim", 1, attacker, weapon);
        self thread cybercom::function_cf64f12c("notify_melee_damage", "intro_anim", 1, attacker, weapon);
        self waittillmatch(#"intro_anim", "end");
        function_58831b5a(loops, attacker, weapon, variant, base, type);
        if (isalive(self) && !self isragdoll()) {
            self clientfield::set("sensory_overload", 0);
            self animscripted("restart_anim", self.origin, self.angles, "ai_" + base + "_" + type + "_exposed_sens_overload_react_outro" + variant, "normal", generic%root, 1, 0.3);
            self thread cybercom::function_cf64f12c("damage_pain", "restart_anim", 1, attacker, weapon);
            self thread cybercom::function_cf64f12c("notify_melee_damage", "restart_anim", 1, attacker, weapon);
            self waittillmatch(#"restart_anim", "end");
        }
    }
    self stoploopsound(0.75);
    self.is_disabled = undefined;
    self.ignoreall = 0;
    if (isdefined(var_7d4fd98c)) {
        if (var_7d4fd98c == "cybercom_smokescreen") {
            self.var_d90f9ddb = 0;
        }
    }
}

// Namespace namespace_64276cf9
// Params 6, eflags: 0x1 linked
// Checksum 0xbe413c76, Offset: 0x1c60
// Size: 0x8e
function function_58831b5a(loops, attacker, weapon, variant, base, type) {
    self endon(#"breakout_overload_loop");
    self thread function_53cfe88a();
    while (loops) {
        self function_e01b8059(attacker, weapon, variant, base, type);
        loops--;
    }
}

// Namespace namespace_64276cf9
// Params 5, eflags: 0x1 linked
// Checksum 0xf79030d3, Offset: 0x1cf8
// Size: 0x15a
function function_e01b8059(attacker, weapon, variant, base, type) {
    self endon(#"death");
    self animscripted("sens_loop_anim", self.origin, self.angles, "ai_" + base + "_" + type + "_exposed_sens_overload_react_loop" + variant, "normal", generic%body, 1, 0.2);
    self thread cybercom::function_cf64f12c("damage_pain", "sens_loop_anim", 1, attacker, weapon);
    self thread cybercom::function_cf64f12c("breakout_overload_loop", "sens_loop_anim", 0, attacker, weapon);
    self thread cybercom::function_cf64f12c("notify_melee_damage", "sens_loop_anim", 1, attacker, weapon);
    self waittillmatch(#"sens_loop_anim", "end");
}

// Namespace namespace_64276cf9
// Params 0, eflags: 0x1 linked
// Checksum 0x6f8de54, Offset: 0x1e60
// Size: 0x3a
function function_53cfe88a() {
    self endon(#"death");
    wait getdvarfloat("scr_sensory_overload_loop_time", 4.7);
    self notify(#"breakout_overload_loop");
}

