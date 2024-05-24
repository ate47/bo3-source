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

#namespace namespace_6dcc04c7;

// Namespace namespace_6dcc04c7
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x350
// Size: 0x4
function init() {
    
}

// Namespace namespace_6dcc04c7
// Params 0, eflags: 0x1 linked
// Checksum 0x92f8397b, Offset: 0x360
// Size: 0x17c
function main() {
    namespace_d00ec32::function_36b56038(2, 16);
    level.cybercom.cacophany = spawnstruct();
    level.cybercom.cacophany.var_875da84b = &function_875da84b;
    level.cybercom.cacophany.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.cacophany.var_bdb47551 = &function_bdb47551;
    level.cybercom.cacophany.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.cacophany.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.cacophany._on = &_on;
    level.cybercom.cacophany._off = &_off;
    level.cybercom.cacophany.var_4135a1c4 = &function_4135a1c4;
}

// Namespace namespace_6dcc04c7
// Params 1, eflags: 0x1 linked
// Checksum 0x245bfe36, Offset: 0x4e8
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_6dcc04c7
// Params 2, eflags: 0x1 linked
// Checksum 0x57427223, Offset: 0x500
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_6dcc04c7
// Params 2, eflags: 0x1 linked
// Checksum 0x220d8889, Offset: 0x520
// Size: 0x1b4
function function_bdb47551(slot, weapon) {
    self.cybercom.var_110c156a = getdvarint("scr_cacophany_count", 4);
    self.cybercom.var_f72b478f = getdvarfloat("scr_cacophany_fov", 0.95);
    self.cybercom.var_23d4a73a = getdvarfloat("scr_cacophany_lock_radius", 330);
    if (self function_1a9006bd("cybercom_cacophany") == 2) {
        self.cybercom.var_110c156a = getdvarint("scr_cacophany_upgraded_count", 5);
        self.cybercom.var_f72b478f = getdvarfloat("scr_cacophany_upgraded_fov", 0.5);
        self.cybercom.var_23d4a73a = getdvarfloat("scr_cacophany_lock_radius", 330);
    }
    self.cybercom.var_9d8e0758 = &function_8aac802c;
    self.cybercom.var_c40accd3 = &function_602b28e9;
    self thread cybercom::function_b5f4e597(weapon);
}

// Namespace namespace_6dcc04c7
// Params 2, eflags: 0x1 linked
// Checksum 0x806e6aa3, Offset: 0x6e0
// Size: 0x72
function function_39ea6a1b(slot, weapon) {
    self _off(slot, weapon);
    self.cybercom.var_9d8e0758 = undefined;
    self.cybercom.var_c40accd3 = undefined;
    self.cybercom.var_f72b478f = undefined;
    self.cybercom.var_23d4a73a = undefined;
}

// Namespace namespace_6dcc04c7
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x760
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_6dcc04c7
// Params 2, eflags: 0x1 linked
// Checksum 0xa276f931, Offset: 0x770
// Size: 0x54
function _on(slot, weapon) {
    self thread function_7f3f3bde(slot, weapon);
    self _off(slot, weapon);
}

// Namespace namespace_6dcc04c7
// Params 2, eflags: 0x1 linked
// Checksum 0xe8d05293, Offset: 0x7d0
// Size: 0x3a
function _off(slot, weapon) {
    self thread cybercom::function_d51412df(weapon);
    self.cybercom.var_301030f7 = undefined;
}

// Namespace namespace_6dcc04c7
// Params 2, eflags: 0x1 linked
// Checksum 0x264e9fc6, Offset: 0x818
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

// Namespace namespace_6dcc04c7
// Params 1, eflags: 0x5 linked
// Checksum 0x6c8227d3, Offset: 0x8c8
// Size: 0xdc
function private function_602b28e9(target) {
    if (target cybercom::function_8fd8f5b1("cybercom_cacophany")) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (isdefined(target.destroyingweapon)) {
        return false;
    }
    if (isdefined(target.var_37915be0) && target.var_37915be0) {
        return false;
    }
    if (isdefined(target.is_disabled) && target.is_disabled) {
        self cybercom::function_29bf9dee(target, 6);
        return false;
    }
    return true;
}

// Namespace namespace_6dcc04c7
// Params 1, eflags: 0x5 linked
// Checksum 0x56cad3c9, Offset: 0x9b0
// Size: 0x2a
function private function_8aac802c(weapon) {
    return getentarray("destructible", "targetname");
}

// Namespace namespace_6dcc04c7
// Params 2, eflags: 0x5 linked
// Checksum 0xc25ac954, Offset: 0x9e8
// Size: 0x28c
function private function_7f3f3bde(slot, weapon) {
    aborted = 0;
    fired = 0;
    foreach (item in self.cybercom.var_d1460543) {
        if (isdefined(item.inrange) && isdefined(item.target) && item.inrange) {
            if (item.inrange == 1) {
                if (!cybercom::function_7a7d1608(item.target, weapon)) {
                    continue;
                }
                item.target thread function_41e98fcc(self, fired);
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
        itemindex = getitemindexfromref("cybercom_cacophany");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "assists", "statValue", fired);
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_6dcc04c7
// Params 2, eflags: 0x1 linked
// Checksum 0x3e1fabf9, Offset: 0xc80
// Size: 0xa8
function function_41e98fcc(attacker, offset) {
    if (offset == 0) {
        wait(0.1);
    } else {
        var_f5aa368a = 0.15 + randomfloatrange(0.1, 0.25) * offset;
        wait(var_f5aa368a);
    }
    self dodamage(self.health + 100, self.origin, attacker, attacker);
    self.var_37915be0 = 1;
}

