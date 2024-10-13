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
#using scripts/shared/hud_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_690a49a;

// Namespace namespace_690a49a
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x6e0
// Size: 0x4
function init() {
    
}

// Namespace namespace_690a49a
// Params 0, eflags: 0x1 linked
// Checksum 0x2a49e, Offset: 0x6f0
// Size: 0x35c
function main() {
    namespace_d00ec32::function_36b56038(2, 2);
    level._effect["es_effect_human"] = "electric/fx_ability_elec_strike_short_human";
    level._effect["es_effect_warlord"] = "electric/fx_ability_elec_strike_short_warlord";
    level._effect["es_effect_robot"] = "electric/fx_ability_elec_strike_short_robot";
    level._effect["es_effect_wasp"] = "electric/fx_ability_elec_strike_short_wasp";
    level._effect["es_effect_generic"] = "electric/fx_ability_elec_strike_generic";
    level._effect["es_contact"] = "electric/fx_ability_elec_strike_impact";
    level._effect["es_arc"] = "electric/fx_ability_elec_strike_trail";
    level.cybercom.var_e3b77070 = spawnstruct();
    level.cybercom.var_e3b77070.var_875da84b = &function_875da84b;
    level.cybercom.var_e3b77070.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.var_e3b77070.var_bdb47551 = &function_bdb47551;
    level.cybercom.var_e3b77070.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.var_e3b77070.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.var_e3b77070._on = &_on;
    level.cybercom.var_e3b77070._off = &_off;
    level.cybercom.var_e3b77070.var_fdd3ea57 = getweapon("gadget_es_strike");
    level.cybercom.var_e3b77070.var_bf0de5fb = getweapon("gadget_es_strike");
    level.cybercom.var_e3b77070.var_97285cfa = getweapon("gadget_es_strike");
    level.cybercom.var_e3b77070.var_f492f9d5 = getweapon("emp_grenade");
    level.cybercom.var_e3b77070.vehicle_weapon = getweapon("emp_grenade");
    level.cybercom.var_e3b77070.other_weapon = getweapon("emp_grenade");
    callback::on_spawned(&on_player_spawned);
}

// Namespace namespace_690a49a
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xa58
// Size: 0x4
function on_player_spawned() {
    
}

// Namespace namespace_690a49a
// Params 1, eflags: 0x1 linked
// Checksum 0xe301fc70, Offset: 0xa68
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_690a49a
// Params 2, eflags: 0x1 linked
// Checksum 0xef6ee24d, Offset: 0xa80
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_690a49a
// Params 2, eflags: 0x1 linked
// Checksum 0x85dcded, Offset: 0xaa0
// Size: 0x2c
function function_bdb47551(slot, weapon) {
    self thread function_677ed44f(weapon);
}

// Namespace namespace_690a49a
// Params 2, eflags: 0x1 linked
// Checksum 0x2ce4a3b1, Offset: 0xad8
// Size: 0x22
function function_39ea6a1b(slot, weapon) {
    self notify(#"hash_343d4580");
}

// Namespace namespace_690a49a
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xb08
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_690a49a
// Params 2, eflags: 0x1 linked
// Checksum 0xd2a48ee4, Offset: 0xb18
// Size: 0x14
function _on(slot, weapon) {
    
}

// Namespace namespace_690a49a
// Params 2, eflags: 0x1 linked
// Checksum 0x5329df05, Offset: 0xb38
// Size: 0x14
function _off(slot, weapon) {
    
}

// Namespace namespace_690a49a
// Params 1, eflags: 0x1 linked
// Checksum 0xdaff114a, Offset: 0xb58
// Size: 0x2c0
function function_677ed44f(weapon) {
    self notify(#"hash_677ed44f");
    self endon(#"hash_677ed44f");
    self endon(#"hash_343d4580");
    self endon(#"disconnect");
    while (true) {
        target, attacker, damage, weapon, var_f3edfe76 = level waittill(#"es_strike");
        wait 0.05;
        if (isdefined(target)) {
            if (target cybercom::function_8fd8f5b1("cybercom_es_strike")) {
                continue;
            }
            if (!isalive(target)) {
                continue;
            }
            self notify(weapon.name + "_fired");
            level notify(weapon.name + "_fired");
            self thread challenges::function_96ed590f("cybercom_uses_control");
            status = self function_1a9006bd("cybercom_es_strike", 1);
            upgraded = status == 2;
            target notify(#"cybercom_action", weapon, attacker);
            target thread function_b4ff98a3(attacker, attacker, upgraded, var_f3edfe76);
            target thread function_dd1b6b0b(attacker, upgraded);
            if (isdefined(target.archetype) && target.archetype == "human") {
                target clientfield::set("arch_actor_char", 1);
                target thread function_71a4f1d5();
            }
            if (isplayer(self)) {
                itemindex = getitemindexfromref("cybercom_es_strike");
                if (isdefined(itemindex)) {
                    self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
                }
            }
        }
    }
}

// Namespace namespace_690a49a
// Params 0, eflags: 0x1 linked
// Checksum 0x643ec996, Offset: 0xe20
// Size: 0x3c
function function_71a4f1d5() {
    corpse = self waittill(#"actor_corpse");
    corpse clientfield::set("arch_actor_fire_fx", 3);
}

// Namespace namespace_690a49a
// Params 1, eflags: 0x1 linked
// Checksum 0x6c7724cb, Offset: 0xe68
// Size: 0x44
function function_aae59b93(upgraded) {
    if (!isdefined(upgraded)) {
        upgraded = 0;
    }
    self thread function_c48e06e3(upgraded ? 2 : 1);
}

// Namespace namespace_690a49a
// Params 1, eflags: 0x1 linked
// Checksum 0x771bf0ab, Offset: 0xeb8
// Size: 0x138
function function_c48e06e3(var_16502c0b) {
    if (isplayer(self)) {
        self endon(#"disconnect");
    } else {
        self endon(#"death");
    }
    self notify(#"hash_bc032f12");
    self endon(#"hash_bc032f12");
    while (true) {
        target, attacker, damage, weapon, var_f3edfe76 = level waittill(#"es_strike");
        wait 0.05;
        if (isdefined(target)) {
            target notify(#"cybercom_action", weapon, attacker);
            upgraded = var_16502c0b == 2;
            target thread function_b4ff98a3(attacker, attacker, upgraded, var_f3edfe76);
            target thread function_dd1b6b0b(attacker, upgraded);
        }
    }
}

// Namespace namespace_690a49a
// Params 1, eflags: 0x1 linked
// Checksum 0x7b5a26a4, Offset: 0xff8
// Size: 0xc0
function function_4830484e(attacker) {
    if (!isdefined(self)) {
        return false;
    }
    if (self cybercom::function_8fd8f5b1("cybercom_es_strike")) {
        return false;
    }
    if (!isalive(self)) {
        return false;
    }
    if (isdefined(self._ai_melee_opponent)) {
        return false;
    }
    if (!isdefined(self.archetype)) {
        return false;
    }
    if (isdefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
        return false;
    }
    if (isdefined(self._ai_melee_opponent)) {
        return false;
    }
    if (self.team == attacker.team) {
        return false;
    }
    return true;
}

// Namespace namespace_690a49a
// Params 5, eflags: 0x1 linked
// Checksum 0x22a6a6ea, Offset: 0x10c0
// Size: 0x794
function function_b4ff98a3(attacker, source, upgraded, contactpoint, secondary) {
    if (!isdefined(upgraded)) {
        upgraded = 0;
    }
    if (!isdefined(secondary)) {
        secondary = 0;
    }
    if (!self function_4830484e(attacker)) {
        return;
    }
    if (!isdefined(source)) {
        source = attacker;
    }
    if (!isdefined(attacker)) {
        return;
    }
    if (isdefined(contactpoint)) {
        playfx(level._effect["es_contact"], contactpoint);
    }
    if (isdefined(self.archetype)) {
        switch (self.archetype) {
        case "human":
            self clientfield::set("arch_actor_char", 1);
            self thread function_71a4f1d5();
        case "human_riotshield":
        case "zombie":
            fx = level._effect["es_effect_human"];
            tag = "j_spine4";
            break;
        case "robot":
            fx = level._effect["es_effect_robot"];
            tag = "j_spine4";
            break;
        case "wasp":
            fx = level._effect["es_effect_wasp"];
            tag = "tag_body";
            break;
        case "warlord":
            fx = level._effect["es_effect_warlord"];
            tag = "j_spine4";
            break;
        default:
            fx = level._effect["es_effect_generic"];
            tag = "tag_body";
            break;
        }
    } else {
        fx = level._effect["es_effect_generic"];
        tag = "tag_body";
    }
    if (!isdefined(self gettagorigin(tag))) {
        tag = "tag_origin";
    }
    playfxontag(fx, self, tag);
    if (self cybercom::function_421746e0()) {
        self kill(self.origin, attacker);
        return;
    }
    if (self.archetype == "human" || self.archetype == "zombie" || self.archetype == "human_riotshield" || self.archetype == "direwolf") {
        if (isdefined(self.voiceprefix) && isdefined(self.var_273d3e89)) {
            self thread battlechatter::function_81d8fcf2(self.voiceprefix + self.var_273d3e89 + "_exert_electrocution", 1);
        }
        self dodamage(self.health, source.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 512, level.cybercom.var_e3b77070.var_fdd3ea57, -1, 1);
        return;
    }
    if (self.archetype == "warlord") {
        self dodamage(getdvarint("scr_es_upgraded_damage", 80), self.origin, isdefined(attacker) ? attacker : undefined, undefined, undefined, "MOD_UNKNOWN", 0, level.cybercom.var_e3b77070.var_bf0de5fb, -1, 1);
        return;
    }
    if (self.archetype == "robot") {
        self ai::set_behavior_attribute("can_gib", 0);
        if (isdefined(secondary) && secondary) {
            self dodamage(getdvarint("scr_es_damage", 5), source.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_MELEE", 512, level.cybercom.var_e3b77070.var_f492f9d5, -1, 1);
        } else {
            self dodamage(self.health, source.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 512, level.cybercom.var_e3b77070.var_97285cfa, -1, 1);
        }
        self ai::set_behavior_attribute("robot_lights", 1);
        if (!(isdefined(self.is_disabled) && self.is_disabled) && isalive(self)) {
            self thread namespace_528b4613::system_overload(attacker, undefined, undefined, 0);
        }
        wait 2.5;
        if (isdefined(self)) {
            self ai::set_behavior_attribute("robot_lights", 2);
        }
        return;
    }
    if (isvehicle(self)) {
        self dodamage(getdvarint("scr_es_damage", 5), source.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_GRENADE", 0, level.cybercom.var_e3b77070.vehicle_weapon);
        self playsound("gdt_cybercore_amws_shutdown");
        return;
    }
    self dodamage(getdvarint("scr_es_damage", 5), source.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 512, level.cybercom.var_e3b77070.other_weapon);
}

// Namespace namespace_690a49a
// Params 2, eflags: 0x1 linked
// Checksum 0x118fffa7, Offset: 0x1860
// Size: 0x3b2
function function_dd1b6b0b(player, upgraded) {
    self endon(#"death");
    if (!upgraded) {
        return;
    }
    wait 0.05;
    var_5c31f5fb = getdvarint("scr_es_arc_range", 72);
    if (upgraded) {
        var_5c31f5fb = getdvarint("scr_es_upgraded_arc_range", -128);
    }
    distsq = var_5c31f5fb * var_5c31f5fb;
    enemies = [];
    var_594dffdc = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
    var_7a650e64 = util::get_array_of_closest(self.origin, var_594dffdc);
    foreach (enemy in var_7a650e64) {
        if (!isdefined(enemy)) {
            continue;
        }
        if (enemy == self) {
            continue;
        }
        if (isdefined(enemy.is_disabled) && enemy.is_disabled) {
            continue;
        }
        if (isdefined(enemy.iscrawler) && (isdefined(enemy.missinglegs) && enemy.missinglegs || enemy.iscrawler)) {
            continue;
        }
        if (!enemy function_4830484e(player)) {
            continue;
        }
        if (distancesquared(self.origin, enemy.origin) > distsq) {
            continue;
        }
        if (!bullettracepassed(self.origin, enemy.origin + (0, 0, 50), 0, undefined)) {
            continue;
        }
        enemies[enemies.size] = enemy;
    }
    i = 0;
    foreach (guy in enemies) {
        player thread challenges::function_96ed590f("cybercom_uses_esdamage");
        self thread function_12d22808(guy, player, upgraded);
        i++;
        if (i >= getdvarint("scr_es_max_arcs", 4)) {
            break;
        }
    }
}

// Namespace namespace_690a49a
// Params 3, eflags: 0x5 linked
// Checksum 0x4c4b954b, Offset: 0x1c20
// Size: 0x1a4
function private function_12d22808(target, player, upgraded) {
    if (!isdefined(self) || !isdefined(target)) {
        return;
    }
    origin = self.origin + (0, 0, 40);
    target_origin = target.origin + (0, 0, 40);
    fxorg = spawn("script_model", origin);
    fxorg setmodel("tag_origin");
    fx = playfxontag(level._effect["es_arc"], fxorg, "tag_origin");
    fxorg playsound("gdt_electro_bounce");
    fxorg moveto(target_origin, 0.25);
    fxorg util::waittill_any_timeout(1, "movedone");
    fxorg delete();
    target thread function_b4ff98a3(player, self, upgraded, undefined, 1);
}

