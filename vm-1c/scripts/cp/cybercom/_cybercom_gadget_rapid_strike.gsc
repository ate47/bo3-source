#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/_util;
#using scripts/shared/lui_shared;
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
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_328b6406;

// Namespace namespace_328b6406
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x340
// Size: 0x4
function init() {
    
}

// Namespace namespace_328b6406
// Params 0, eflags: 0x1 linked
// Checksum 0xe0dcc19c, Offset: 0x350
// Size: 0x174
function main() {
    namespace_d00ec32::function_36b56038(1, 64);
    callback::on_spawned(&on_player_spawned);
    level.cybercom.rapid_strike = spawnstruct();
    level.cybercom.rapid_strike.var_875da84b = &function_875da84b;
    level.cybercom.rapid_strike.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.rapid_strike.var_bdb47551 = &function_bdb47551;
    level.cybercom.rapid_strike.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.rapid_strike.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.rapid_strike._on = &_on;
    level.cybercom.rapid_strike._off = &_off;
}

// Namespace namespace_328b6406
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x4d0
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace namespace_328b6406
// Params 1, eflags: 0x1 linked
// Checksum 0x847bb4e8, Offset: 0x4e0
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_328b6406
// Params 2, eflags: 0x1 linked
// Checksum 0x3a188ef5, Offset: 0x4f8
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_328b6406
// Params 2, eflags: 0x1 linked
// Checksum 0xf5ffacc3, Offset: 0x518
// Size: 0x2c
function function_bdb47551(slot, weapon) {
    self thread function_677ed44f(weapon);
}

// Namespace namespace_328b6406
// Params 2, eflags: 0x1 linked
// Checksum 0x46483f67, Offset: 0x550
// Size: 0x22
function function_39ea6a1b(slot, weapon) {
    self notify(#"hash_343d4580");
}

// Namespace namespace_328b6406
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x580
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_328b6406
// Params 2, eflags: 0x1 linked
// Checksum 0x833df0b, Offset: 0x590
// Size: 0x14
function _on(slot, weapon) {
    
}

// Namespace namespace_328b6406
// Params 2, eflags: 0x1 linked
// Checksum 0x7e5e915c, Offset: 0x5b0
// Size: 0x14
function _off(slot, weapon) {
    
}

// Namespace namespace_328b6406
// Params 1, eflags: 0x1 linked
// Checksum 0x5e0d018a, Offset: 0x5d0
// Size: 0x190
function function_677ed44f(weapon) {
    self notify(#"hash_677ed44f");
    self endon(#"hash_677ed44f");
    self endon(#"hash_343d4580");
    self endon(#"disconnect");
    while (true) {
        target, attacker, damage, weapon, var_f3edfe76 = level waittill(#"rapid_strike");
        self notify(weapon.name + "_fired");
        level notify(weapon.name + "_fired");
        wait(0.05);
        if (isdefined(target)) {
        }
        if (isplayer(self)) {
            itemindex = getitemindexfromref("cybercom_rapidstrike");
            if (isdefined(itemindex)) {
                self adddstat("ItemStats", itemindex, "stats", "kills", "statValue", 1);
                self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
            }
        }
    }
}

