#using scripts/cp/_challenges;
#using scripts/shared/ai_shared;
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
#using scripts/codescripts/struct;

// Can't decompile export namespace_9c3956fd::function_586fec95

// Can't decompile export namespace_9c3956fd::function_609fcb0a

// Can't decompile export namespace_9c3956fd::function_91adcf0e

// Can't decompile export namespace_9c3956fd::function_638ad739

#namespace namespace_9c3956fd;

// Namespace namespace_9c3956fd
// Params 0, eflags: 0x1 linked
// Checksum 0xb36b509f, Offset: 0x528
// Size: 0x34
function init() {
    clientfield::register("actor", "forced_malfunction", 1, 1, "int");
}

// Namespace namespace_9c3956fd
// Params 0, eflags: 0x1 linked
// Checksum 0xd0ec5e2b, Offset: 0x568
// Size: 0x17c
function main() {
    namespace_d00ec32::function_36b56038(1, 2);
    level.cybercom.forced_malfunction = spawnstruct();
    level.cybercom.forced_malfunction.var_875da84b = &function_875da84b;
    level.cybercom.forced_malfunction.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.forced_malfunction.var_bdb47551 = &function_bdb47551;
    level.cybercom.forced_malfunction.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.forced_malfunction.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.forced_malfunction._on = &_on;
    level.cybercom.forced_malfunction._off = &_off;
    level.cybercom.forced_malfunction.var_4135a1c4 = &function_4135a1c4;
}

// Namespace namespace_9c3956fd
// Params 1, eflags: 0x1 linked
// Checksum 0x15fd0bc9, Offset: 0x6f0
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_9c3956fd
// Params 2, eflags: 0x1 linked
// Checksum 0xa557bc78, Offset: 0x708
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_9c3956fd
// Params 2, eflags: 0x1 linked
// Checksum 0x4053b4c, Offset: 0x728
// Size: 0x154
function function_bdb47551(slot, weapon) {
    self.cybercom.var_110c156a = getdvarint("scr_forced_malfunction_count", 2);
    if (self function_1a9006bd("cybercom_forcedmalfunction") == 2) {
        self.cybercom.var_110c156a = getdvarint("scr_forced_malfunction_upgraded_count", 4);
    }
    self.cybercom.var_9d8e0758 = &function_8aac802c;
    self.cybercom.var_c40accd3 = &function_602b28e9;
    self thread cybercom::function_b5f4e597(weapon);
    self cybercom::function_8257bcb3("base_rifle", 5);
    self cybercom::function_8257bcb3("fem_rifle", 3);
    self cybercom::function_8257bcb3("riotshield", 2);
}

// Namespace namespace_9c3956fd
// Params 2, eflags: 0x1 linked
// Checksum 0x56ebe727, Offset: 0x888
// Size: 0x52
function function_39ea6a1b(slot, weapon) {
    self _off(slot, weapon);
    self.cybercom.var_9d8e0758 = undefined;
    self.cybercom.var_c40accd3 = undefined;
}

// Namespace namespace_9c3956fd
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x8e8
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_9c3956fd
// Params 2, eflags: 0x1 linked
// Checksum 0xc5b2ae50, Offset: 0x8f8
// Size: 0x54
function _on(slot, weapon) {
    self thread function_da7fe5ea(slot, weapon);
    self _off(slot, weapon);
}

// Namespace namespace_9c3956fd
// Params 2, eflags: 0x1 linked
// Checksum 0x26fa9531, Offset: 0x958
// Size: 0x3a
function _off(slot, weapon) {
    self thread cybercom::function_d51412df(weapon);
    self.cybercom.var_301030f7 = undefined;
}

// Namespace namespace_9c3956fd
// Params 2, eflags: 0x1 linked
// Checksum 0xc0a06d7e, Offset: 0x9a0
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

// Namespace namespace_9c3956fd
// Params 1, eflags: 0x5 linked
// Checksum 0xeba66962, Offset: 0xa50
// Size: 0x2bc
function function_602b28e9(target) {
    if (target cybercom::function_8fd8f5b1("cybercom_forcedmalfunction")) {
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
    if (isvehicle(target)) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (target.archetype == "zombie" || isactor(target) && isdefined(target.archetype) && target.archetype == "direwolf") {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (isactor(target) && target cybercom::getentitypose() != "stand" && target cybercom::getentitypose() != "crouch") {
        return false;
    }
    if (isactor(target) && !target isonground() && !target cybercom::function_421746e0()) {
        return false;
    }
    if (isactor(target) && isdefined(target.weapon) && target.weapon.name == "none") {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    return true;
}

// Namespace namespace_9c3956fd
// Params 1, eflags: 0x5 linked
// Checksum 0x4ec68eaa, Offset: 0xd18
// Size: 0x52
function function_8aac802c(weapon) {
    return arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
}

// Namespace namespace_9c3956fd
// Params 2, eflags: 0x5 linked
// Checksum 0xb9a64992, Offset: 0xd78
// Size: 0x2a4
function function_da7fe5ea(slot, weapon) {
    aborted = 0;
    fired = 0;
    foreach (item in self.cybercom.var_d1460543) {
        if (isdefined(item.inrange) && isdefined(item.target) && item.inrange) {
            if (item.inrange == 1) {
                if (!cybercom::function_7a7d1608(item.target, weapon)) {
                    continue;
                }
                self thread challenges::function_96ed590f("cybercom_uses_martial");
                item.target thread function_91adcf0e(self, undefined);
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
    if (fired && isplayer(self)) {
        itemindex = getitemindexfromref("cybercom_forcedmalfunction");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "assists", "statValue", fired);
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
    cybercom::function_adc40f11(weapon, fired);
}

