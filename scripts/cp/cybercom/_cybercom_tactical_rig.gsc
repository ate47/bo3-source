#using scripts/cp/cybercom/_cybercom_tactical_rig_multicore;
#using scripts/cp/cybercom/_cybercom_tactical_rig_copycat;
#using scripts/cp/cybercom/_cybercom_tactical_rig_playermovement;
#using scripts/cp/cybercom/_cybercom_tactical_rig_sensorybuffer;
#using scripts/cp/cybercom/_cybercom_tactical_rig_repulsorarmor;
#using scripts/cp/cybercom/_cybercom_tactical_rig_emergencyreserve;
#using scripts/cp/cybercom/_cybercom_tactical_rig_proximitydeterrent;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/cybercom/_cybercom_dev;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;
#using scripts/shared/math_shared;

#namespace cybercom_tacrig;

// Namespace cybercom_tacrig
// Params 0, eflags: 0x1 linked
// Checksum 0xc26c7ec8, Offset: 0x3b8
// Size: 0x74
function init() {
    namespace_fc601b38::init();
    namespace_e3074452::init();
    namespace_d1c4e441::init();
    namespace_a7b77773::init();
    namespace_941cddd7::init();
    namespace_b854c5d0::init();
    namespace_52c052b7::init();
}

// Namespace cybercom_tacrig
// Params 0, eflags: 0x1 linked
// Checksum 0xf4c1d185, Offset: 0x438
// Size: 0xb4
function main() {
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    namespace_fc601b38::main();
    namespace_e3074452::main();
    namespace_d1c4e441::main();
    namespace_a7b77773::main();
    namespace_941cddd7::main();
    namespace_b854c5d0::main();
    namespace_52c052b7::main();
}

// Namespace cybercom_tacrig
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x4f8
// Size: 0x4
function on_player_connect() {
    
}

// Namespace cybercom_tacrig
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x508
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace cybercom_tacrig
// Params 2, eflags: 0x1 linked
// Checksum 0xe35b2a5c, Offset: 0x518
// Size: 0x9c
function function_8cb15f87(name, type) {
    if (!isdefined(level.var_ab0cd3b2)) {
        level.var_ab0cd3b2 = [];
    }
    if (!isdefined(level.var_ab0cd3b2[name])) {
        level.var_ab0cd3b2[name] = spawnstruct();
        level.var_ab0cd3b2[name].name = name;
        level.var_ab0cd3b2[name].type = type;
    }
}

// Namespace cybercom_tacrig
// Params 3, eflags: 0x1 linked
// Checksum 0x442ede7, Offset: 0x5c0
// Size: 0x282
function function_8b4ef058(name, on_give, on_take) {
    /#
        assert(isdefined(level.var_ab0cd3b2[name]));
    #/
    if (!isdefined(level.var_ab0cd3b2[name].on_give)) {
        level.var_ab0cd3b2[name].on_give = [];
    }
    if (!isdefined(level.var_ab0cd3b2[name].on_take)) {
        level.var_ab0cd3b2[name].on_take = [];
    }
    if (isdefined(on_give)) {
        if (!isdefined(level.var_ab0cd3b2[name].on_give)) {
            level.var_ab0cd3b2[name].on_give = [];
        } else if (!isarray(level.var_ab0cd3b2[name].on_give)) {
            level.var_ab0cd3b2[name].on_give = array(level.var_ab0cd3b2[name].on_give);
        }
        level.var_ab0cd3b2[name].on_give[level.var_ab0cd3b2[name].on_give.size] = on_give;
    }
    if (isdefined(on_take)) {
        if (!isdefined(level.var_ab0cd3b2[name].on_take)) {
            level.var_ab0cd3b2[name].on_take = [];
        } else if (!isarray(level.var_ab0cd3b2[name].on_take)) {
            level.var_ab0cd3b2[name].on_take = array(level.var_ab0cd3b2[name].on_take);
        }
        level.var_ab0cd3b2[name].on_take[level.var_ab0cd3b2[name].on_take.size] = on_take;
    }
}

// Namespace cybercom_tacrig
// Params 3, eflags: 0x1 linked
// Checksum 0xfd823f8c, Offset: 0x850
// Size: 0x282
function function_37a33686(name, turn_on, turn_off) {
    /#
        assert(isdefined(level.var_ab0cd3b2[name]));
    #/
    if (!isdefined(level.var_ab0cd3b2[name].turn_on)) {
        level.var_ab0cd3b2[name].turn_on = [];
    }
    if (!isdefined(level.var_ab0cd3b2[name].turn_off)) {
        level.var_ab0cd3b2[name].turn_off = [];
    }
    if (isdefined(turn_on)) {
        if (!isdefined(level.var_ab0cd3b2[name].turn_on)) {
            level.var_ab0cd3b2[name].turn_on = [];
        } else if (!isarray(level.var_ab0cd3b2[name].turn_on)) {
            level.var_ab0cd3b2[name].turn_on = array(level.var_ab0cd3b2[name].turn_on);
        }
        level.var_ab0cd3b2[name].turn_on[level.var_ab0cd3b2[name].turn_on.size] = turn_on;
    }
    if (isdefined(turn_off)) {
        if (!isdefined(level.var_ab0cd3b2[name].turn_off)) {
            level.var_ab0cd3b2[name].turn_off = [];
        } else if (!isarray(level.var_ab0cd3b2[name].turn_off)) {
            level.var_ab0cd3b2[name].turn_off = array(level.var_ab0cd3b2[name].turn_off);
        }
        level.var_ab0cd3b2[name].turn_off[level.var_ab0cd3b2[name].turn_off.size] = turn_off;
    }
}

// Namespace cybercom_tacrig
// Params 2, eflags: 0x1 linked
// Checksum 0x75067220, Offset: 0xae0
// Size: 0xd6
function function_fea5c2ac(type, upgraded) {
    if (!isdefined(level.var_ab0cd3b2[type])) {
        return;
    }
    if (isdefined(level.var_ab0cd3b2[type].on_give)) {
        foreach (on_give in level.var_ab0cd3b2[type].on_give) {
            self [[ on_give ]](type);
        }
    }
}

// Namespace cybercom_tacrig
// Params 4, eflags: 0x1 linked
// Checksum 0x642f9668, Offset: 0xbc0
// Size: 0xf0
function function_8ffa26e2(type, upgraded, slot, var_9ab0ec54) {
    if (!isdefined(upgraded)) {
        upgraded = 0;
    }
    if (!isdefined(var_9ab0ec54)) {
        var_9ab0ec54 = 1;
    }
    if (!isdefined(level.var_ab0cd3b2[type])) {
        return false;
    }
    if (!isdefined(slot)) {
        self function_be9e2d9(type, upgraded);
    } else {
        self function_be9e2d9(type, upgraded, slot);
    }
    if (var_9ab0ec54) {
        self cybercom::function_b6b97f75();
    }
    self function_fea5c2ac(type);
    return true;
}

// Namespace cybercom_tacrig
// Params 1, eflags: 0x1 linked
// Checksum 0x2be67616, Offset: 0xcb8
// Size: 0x40
function function_ccca7010(type) {
    if (!isdefined(level.var_ab0cd3b2[type])) {
        return false;
    }
    self function_45ce30b1(type);
    return true;
}

// Namespace cybercom_tacrig
// Params 1, eflags: 0x5 linked
// Checksum 0xd9625089, Offset: 0xd00
// Size: 0x130
function private function_45ce30b1(type) {
    if (!isdefined(level.var_ab0cd3b2[type])) {
        return false;
    }
    if (isdefined(level.var_ab0cd3b2[type]) && isdefined(level.var_ab0cd3b2[type].on_take)) {
        foreach (on_take in level.var_ab0cd3b2[type].on_take) {
            self [[ on_take ]](type);
        }
    }
    self notify("take_ability_" + type);
    self function_9f1f0e5c(type);
    self cybercom::function_b6b97f75();
    return true;
}

// Namespace cybercom_tacrig
// Params 0, eflags: 0x1 linked
// Checksum 0x9fb48b37, Offset: 0xe38
// Size: 0xd4
function function_78908229() {
    foreach (ability in level.var_ab0cd3b2) {
        if (self function_76f34311(ability.name) != 0) {
            function_45ce30b1(ability.name);
        }
    }
    self cybercom::function_b6b97f75();
}

// Namespace cybercom_tacrig
// Params 0, eflags: 0x0
// Checksum 0x70f2cf9a, Offset: 0xf18
// Size: 0xf4
function function_a07bf2cb() {
    foreach (ability in level.var_ab0cd3b2) {
        status = self function_76f34311(ability.name);
        if (status != 0) {
            self function_8ffa26e2(ability.name, status == 2);
        }
    }
    self cybercom::function_b6b97f75();
}

// Namespace cybercom_tacrig
// Params 1, eflags: 0x1 linked
// Checksum 0xdf2d2562, Offset: 0x1018
// Size: 0x102
function function_de82b8b4(type) {
    var_2f4d1887 = self function_76f34311(type);
    if (var_2f4d1887 == 0) {
        return;
    }
    if (isdefined(level.var_ab0cd3b2[type]) && isdefined(level.var_ab0cd3b2[type].turn_on)) {
        foreach (turn_on in level.var_ab0cd3b2[type].turn_on) {
            self [[ turn_on ]](type);
        }
    }
}

// Namespace cybercom_tacrig
// Params 1, eflags: 0x1 linked
// Checksum 0x80a4c4ff, Offset: 0x1128
// Size: 0x102
function function_e7e75042(type) {
    var_2f4d1887 = self function_76f34311(type);
    if (var_2f4d1887 == 0) {
        return;
    }
    if (isdefined(level.var_ab0cd3b2[type]) && isdefined(level.var_ab0cd3b2[type].turn_off)) {
        foreach (turn_off in level.var_ab0cd3b2[type].turn_off) {
            self [[ turn_off ]](type);
        }
    }
}

