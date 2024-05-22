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

// Can't decompile export namespace_491e7803::function_2e537afb

// Can't decompile export namespace_491e7803::function_69246d49

// Can't decompile export namespace_491e7803::function_585970ba

// Can't decompile export namespace_491e7803::function_e01b8059

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
function function_602b28e9(target) {
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
function function_8aac802c(weapon) {
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
// Params 0, eflags: 0x1 linked
// Checksum 0x923bb189, Offset: 0x1b70
// Size: 0x3a
function function_53cfe88a() {
    self endon(#"death");
    wait(getdvarfloat("scr_exo_breakdown_loop_time", 4.2));
    self notify(#"hash_614ee876");
}

