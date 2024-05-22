#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom_gadget_system_overload;
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
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/hud_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_9cc756f9;

// Namespace namespace_9cc756f9
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x418
// Size: 0x4
function init() {
    
}

// Namespace namespace_9cc756f9
// Params 0, eflags: 0x1 linked
// Checksum 0x4eab8102, Offset: 0x428
// Size: 0x1a4
function main() {
    namespace_d00ec32::function_36b56038(0, 16);
    level.cybercom.ravage_core = spawnstruct();
    level.cybercom.ravage_core.var_875da84b = &function_875da84b;
    level.cybercom.ravage_core.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.ravage_core.var_bdb47551 = &function_bdb47551;
    level.cybercom.ravage_core.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.ravage_core.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.ravage_core._on = &_on;
    level.cybercom.ravage_core._off = &_off;
    level.cybercom.ravage_core.weapon = getweapon("gadget_ravage_core");
    callback::on_spawned(&on_player_spawned);
}

// Namespace namespace_9cc756f9
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x5d8
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace namespace_9cc756f9
// Params 1, eflags: 0x1 linked
// Checksum 0x7251ef06, Offset: 0x5e8
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_9cc756f9
// Params 2, eflags: 0x1 linked
// Checksum 0x3dd06780, Offset: 0x600
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_9cc756f9
// Params 2, eflags: 0x1 linked
// Checksum 0x2a23b567, Offset: 0x620
// Size: 0x2c
function function_bdb47551(slot, weapon) {
    self thread function_677ed44f(weapon);
}

// Namespace namespace_9cc756f9
// Params 2, eflags: 0x1 linked
// Checksum 0x8df9590c, Offset: 0x658
// Size: 0x22
function function_39ea6a1b(slot, weapon) {
    self notify(#"hash_343d4580");
}

// Namespace namespace_9cc756f9
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x688
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_9cc756f9
// Params 2, eflags: 0x1 linked
// Checksum 0x72f03944, Offset: 0x698
// Size: 0x14
function _on(slot, weapon) {
    
}

// Namespace namespace_9cc756f9
// Params 2, eflags: 0x1 linked
// Checksum 0xb6821936, Offset: 0x6b8
// Size: 0x14
function _off(slot, weapon) {
    
}

// Namespace namespace_9cc756f9
// Params 1, eflags: 0x1 linked
// Checksum 0xd6e69f2b, Offset: 0x6d8
// Size: 0x24a
function function_677ed44f(weapon) {
    self notify(#"hash_677ed44f");
    self endon(#"hash_677ed44f");
    self endon(#"hash_343d4580");
    self endon(#"disconnect");
    while (true) {
        target, attacker, damage, weapon, var_f3edfe76 = level waittill(#"ravage_core");
        self notify(#"ravage_core", target, damage, weapon);
        destructserverutils::destructhitlocpieces(target, "torso_upper");
        self notify(weapon.name + "_fired");
        level notify(weapon.name + "_fired");
        target hidepart("j_chest_door");
        target thread function_369d3494();
        target ai::set_behavior_attribute("robot_lights", 1);
        attacker thread challenges::function_96ed590f("cybercom_uses_control");
        if (isplayer(self)) {
            itemindex = getitemindexfromref("cybercom_ravagecore");
            if (isdefined(itemindex)) {
                self adddstat("ItemStats", itemindex, "stats", "kills", "statValue", 1);
                self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
            }
        }
        self waittill(#"grenade_fire");
        self notify(#"hash_65afc94f");
    }
}

// Namespace namespace_9cc756f9
// Params 0, eflags: 0x5 linked
// Checksum 0xb50b5c32, Offset: 0x930
// Size: 0x44
function function_369d3494() {
    corpse = self waittill(#"actor_corpse");
    if (isdefined(corpse)) {
        corpse hidepart("j_chest_door");
    }
}

