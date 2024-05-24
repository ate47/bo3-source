#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/math_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_491e7803;

// Namespace namespace_491e7803
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x5a0
// Size: 0x4
function init() {
    
}

// Namespace namespace_491e7803
// Params 0, eflags: 0x1 linked
// Checksum 0xe15ce59d, Offset: 0x5b0
// Size: 0x17c
function main() {
    namespace_d00ec32::function_36b56038(0, 4);
    level.cybercom.exo_breakdown = spawnstruct();
    level.cybercom.exo_breakdown.var_875da84b = &function_875da84b;
    level.cybercom.exo_breakdown.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.exo_breakdown.var_bdb47551 = &function_bdb47551;
    level.cybercom.exo_breakdown.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.exo_breakdown.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.exo_breakdown._on = &_on;
    level.cybercom.exo_breakdown._off = &_off;
    level.cybercom.exo_breakdown.var_4135a1c4 = &function_4135a1c4;
}

// Namespace namespace_491e7803
// Params 1, eflags: 0x1 linked
// Checksum 0x6246284f, Offset: 0x738
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_491e7803
// Params 2, eflags: 0x1 linked
// Checksum 0x5107c92d, Offset: 0x750
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_491e7803
// Params 2, eflags: 0x1 linked
// Checksum 0xc478e786, Offset: 0x770
// Size: 0x1c4
function function_bdb47551(slot, weapon) {
    self.cybercom.var_110c156a = getdvarint("scr_exo_breakdown_count", 1);
    self.cybercom.var_1360b9f1 = getdvarint("scr_exo_breakdown_loops", 2);
    if (self function_1a9006bd("cybercom_exosuitbreakdown") == 2) {
        self.cybercom.var_110c156a = getdvarint("scr_exo_breakdown_upgraded_count", 2);
    }
    self.cybercom.var_9d8e0758 = &function_8aac802c;
    self.cybercom.var_c40accd3 = &function_602b28e9;
    self thread cybercom::function_b5f4e597(weapon);
    self cybercom::function_8257bcb3("base_rifle_stn", 8);
    self cybercom::function_8257bcb3("base_rifle_crc", 2);
    self cybercom::function_8257bcb3("fem_rifle_stn", 8);
    self cybercom::function_8257bcb3("fem_rifle_crc", 2);
    self cybercom::function_8257bcb3("riotshield", 2);
}

// Namespace namespace_491e7803
// Params 2, eflags: 0x1 linked
// Checksum 0xd78b664e, Offset: 0x940
// Size: 0x52
function function_39ea6a1b(slot, weapon) {
    self _off(slot, weapon);
    self.cybercom.var_9d8e0758 = undefined;
    self.cybercom.var_c40accd3 = undefined;
}

// Namespace namespace_491e7803
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x9a0
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_491e7803
// Params 2, eflags: 0x1 linked
// Checksum 0xfb7c9833, Offset: 0x9b0
// Size: 0x54
function _on(slot, weapon) {
    self thread function_dab563f4(slot, weapon);
    self _off(slot, weapon);
}

// Namespace namespace_491e7803
// Params 2, eflags: 0x1 linked
// Checksum 0x7eef657c, Offset: 0xa10
// Size: 0x3a
function _off(slot, weapon) {
    self thread cybercom::function_d51412df(weapon);
    self.cybercom.var_301030f7 = undefined;
}

// Namespace namespace_491e7803
// Params 2, eflags: 0x1 linked
// Checksum 0x45175bfb, Offset: 0xa58
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

// Namespace namespace_491e7803
// Params 1, eflags: 0x5 linked
// Checksum 0x7b4492c0, Offset: 0xb08
// Size: 0x208
function private function_602b28e9(target) {
    if (target cybercom::function_8fd8f5b1("cybercom_exosuitbreakdown")) {
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
    if (isvehicle(target)) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (target.archetype != "human" && target.archetype != "human_riotshield" && (!isdefined(target.archetype) || target.archetype != "warlord")) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (isactor(target) && !target isonground() && !target cybercom::function_421746e0()) {
        return false;
    }
    return true;
}

// Namespace namespace_491e7803
// Params 1, eflags: 0x5 linked
// Checksum 0xe7d8b03d, Offset: 0xd18
// Size: 0x52
function private function_8aac802c(weapon) {
    return arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
}

// Namespace namespace_491e7803
// Params 2, eflags: 0x1 linked
// Checksum 0x6b61b0f0, Offset: 0xd78
// Size: 0x2a4
function function_dab563f4(slot, weapon) {
    aborted = 0;
    fired = 0;
    foreach (item in self.cybercom.var_d1460543) {
        if (isdefined(item.inrange) && isdefined(item.target) && item.inrange) {
            if (item.inrange == 1) {
                if (!cybercom::function_7a7d1608(item.target, weapon)) {
                    continue;
                }
                self thread challenges::function_96ed590f("cybercom_uses_control");
                item.target thread function_585970ba(self);
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
        itemindex = getitemindexfromref("cybercom_exosuitbreakdown");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "assists", "statValue", fired);
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_491e7803
// Params 2, eflags: 0x1 linked
// Checksum 0xf2c3c05e, Offset: 0x1028
// Size: 0x2ba
function function_2e537afb(target, var_9bc2efcb) {
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
    weapon = getweapon("gadget_exo_breakdown");
    foreach (guy in validtargets) {
        if (!cybercom::function_7a7d1608(guy, weapon)) {
            continue;
        }
        guy thread function_585970ba(self);
        wait(0.05);
    }
}

// Namespace namespace_491e7803
// Params 3, eflags: 0x5 linked
// Checksum 0xb9cd7e04, Offset: 0x12f0
// Size: 0x10a
function private function_69246d49(attacker, loops, weapon) {
    self endon(#"death");
    self.is_disabled = 1;
    self.ignoreall = 1;
    self.special_weapon = weapon;
    while (loops) {
        self.allowpain = 1;
        self dodamage(5, self.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
        self.allowpain = 0;
        wait(0.05);
        self waittillmatch(#"bhtn_action_terminate");
        loops--;
    }
    self.allowpain = 1;
    self.ignoreall = 0;
    self.is_disabled = undefined;
    self.special_weapon = undefined;
}

// Namespace namespace_491e7803
// Params 1, eflags: 0x5 linked
// Checksum 0xe3c24fb4, Offset: 0x1408
// Size: 0x58e
function private function_585970ba(attacker) {
    self endon(#"death");
    weapon = getweapon("gadget_exo_breakdown");
    self notify(#"hash_f8c5dd60", weapon, attacker);
    if (isdefined(attacker.cybercom) && isdefined(attacker.cybercom.var_b8a4f6a5)) {
        loops = self.cybercom.var_1360b9f1;
    } else {
        loops = 1;
    }
    wait(randomfloatrange(0, 0.75));
    if (!attacker cybercom::function_7a7d1608(self, weapon)) {
        return;
    }
    if (self cybercom::function_421746e0()) {
        self kill(self.origin, isdefined(attacker) ? attacker : undefined);
        return;
    }
    self notify(#"bhtn_action_notify", "reactExosuit");
    if (self.archetype == "warlord") {
        self thread function_69246d49(attacker, 1, weapon);
        return;
    }
    self.is_disabled = 1;
    self.ignoreall = 1;
    if (isplayer(attacker) && attacker function_1a9006bd("cybercom_exosuitbreakdown") == 2) {
        if (isdefined(self.voiceprefix) && isdefined(self.var_273d3e89)) {
            self thread battlechatter::function_81d8fcf2(self.voiceprefix + self.var_273d3e89 + "_exert_breakdown_pain", 1);
        }
        self dodamage(self.health + 666, self.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
        return;
    }
    base = "base_rifle";
    if (isdefined(self.voiceprefix) && getsubstr(self.voiceprefix, 7) == "f") {
        base = "fem_rifle";
    }
    if (self.archetype == "human_riotshield") {
        base = "riotshield";
    }
    type = self cybercom::function_5e3d3aa();
    variant = attacker cybercom::function_e06423b6(base + "_" + type);
    self orientmode("face default");
    self animscripted("exo_intro_anim", self.origin, self.angles, "ai_" + base + "_" + type + "_exposed_suit_overload_react_intro" + variant, "normal", generic%body, 1, 0.2);
    self thread cybercom::function_cf64f12c("damage_pain", "exo_intro_anim", 1, attacker, weapon);
    self thread cybercom::function_cf64f12c("notify_melee_damage", "exo_intro_anim", 1, attacker, weapon);
    self waittillmatch(#"hash_aae05ca2", "end");
    function_58831b5a(loops, attacker, weapon, variant, base, type);
    self animscripted("exo_outro_anim", self.origin, self.angles, "ai_" + base + "_" + type + "_exposed_suit_overload_react_outro" + variant, "normal", generic%body, 1, 0.2);
    self thread cybercom::function_cf64f12c("damage_pain", "exo_outro_anim", 1, attacker, weapon);
    self thread cybercom::function_cf64f12c("notify_melee_damage", "exo_outro_anim", 1, attacker, weapon);
    self waittillmatch(#"hash_7a5cc1cf", "end");
    self.ignoreall = 0;
    self.is_disabled = undefined;
}

// Namespace namespace_491e7803
// Params 6, eflags: 0x1 linked
// Checksum 0xc85b3bfb, Offset: 0x19a0
// Size: 0x8e
function function_58831b5a(loops, attacker, weapon, variant, base, type) {
    self endon(#"hash_614ee876");
    self thread function_53cfe88a();
    while (loops) {
        self function_e01b8059(attacker, weapon, variant, base, type);
        loops--;
    }
}

// Namespace namespace_491e7803
// Params 5, eflags: 0x1 linked
// Checksum 0xa5a0a8ff, Offset: 0x1a38
// Size: 0x12a
function function_e01b8059(attacker, weapon, variant, base, type) {
    self endon(#"death");
    self animscripted("exo_loop_anim", self.origin, self.angles, "ai_" + base + "_" + type + "_exposed_suit_overload_react_loop" + variant, "normal", generic%body, 1, 0.2);
    self thread cybercom::function_cf64f12c("damage_pain", "exo_loop_anim", 1, attacker, weapon);
    self thread cybercom::function_cf64f12c("breakout_exo_loop", "exo_loop_anim", 0, attacker, weapon);
    self waittillmatch(#"hash_346e71c6", "end");
}

// Namespace namespace_491e7803
// Params 0, eflags: 0x1 linked
// Checksum 0x923bb189, Offset: 0x1b70
// Size: 0x3a
function function_53cfe88a() {
    self endon(#"death");
    wait(getdvarfloat("scr_exo_breakdown_loop_time", 4.2));
    self notify(#"hash_614ee876");
}

