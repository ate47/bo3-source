#using scripts/cp/_challenges;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

// Can't decompile export namespace_687c8387::function_73688d2e

#namespace namespace_687c8387;

// Namespace namespace_687c8387
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x548
// Size: 0x4
function init() {
    
}

// Namespace namespace_687c8387
// Params 0, eflags: 0x1 linked
// Checksum 0x9b7e42c4, Offset: 0x558
// Size: 0x184
function main() {
    namespace_d00ec32::function_36b56038(1, 4, 1);
    level.cybercom.concussive_wave = spawnstruct();
    level.cybercom.concussive_wave.var_875da84b = &function_875da84b;
    level.cybercom.concussive_wave.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.concussive_wave.var_bdb47551 = &function_bdb47551;
    level.cybercom.concussive_wave.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.concussive_wave.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.concussive_wave._on = &_on;
    level.cybercom.concussive_wave._off = &_off;
    level.cybercom.concussive_wave.var_4135a1c4 = &function_4135a1c4;
}

// Namespace namespace_687c8387
// Params 1, eflags: 0x1 linked
// Checksum 0x5bf952c9, Offset: 0x6e8
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_687c8387
// Params 2, eflags: 0x1 linked
// Checksum 0xf3ceffc0, Offset: 0x700
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_687c8387
// Params 2, eflags: 0x1 linked
// Checksum 0x48cc573f, Offset: 0x720
// Size: 0x1a4
function function_bdb47551(slot, weapon) {
    self.cybercom.var_e6fa6e38 = getdvarint("scr_concussive_wave_radius", 310);
    self.cybercom.var_47063871 = getweapon("hero_gravityspikes_cybercom");
    self.cybercom.var_46ad3e37 = getdvarint("scr_concussive_wave_kill_radius", -61);
    if (self function_1a9006bd("cybercom_concussive") == 2) {
        self.cybercom.var_e6fa6e38 = getdvarint("scr_concussive_wave_upg_radius", 310);
        self.cybercom.var_47063871 = getweapon("hero_gravityspikes_cybercom_upgraded");
    }
    self.cybercom.var_4e92078e = 5 * getdvarfloat("scr_concussive_wave_scale", 1);
    self.cybercom.var_9d8e0758 = &function_8aac802c;
    self.cybercom.var_c40accd3 = &function_602b28e9;
    self thread cybercom::function_b5f4e597(weapon);
}

// Namespace namespace_687c8387
// Params 2, eflags: 0x1 linked
// Checksum 0x8bd4b8d7, Offset: 0x8d0
// Size: 0x14
function function_39ea6a1b(slot, weapon) {
    
}

// Namespace namespace_687c8387
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x8f0
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_687c8387
// Params 2, eflags: 0x1 linked
// Checksum 0x1aaeee4c, Offset: 0x900
// Size: 0x1a4
function _on(slot, weapon) {
    if (self getstance() == "prone") {
        self gadgetdeactivate(slot, weapon, 2);
        return;
    }
    if (self isswitchingweapons()) {
        self gadgetdeactivate(slot, weapon, 2);
        return;
    }
    if (self isonladder()) {
        self gadgetdeactivate(slot, weapon, 2);
        return;
    }
    cybercom::function_adc40f11(weapon, 1);
    self thread function_9ba0286c(self.cybercom.var_cb0b065, slot, weapon);
    level.var_b1ae49b1 = gettime();
    if (isplayer(self)) {
        itemindex = getitemindexfromref("cybercom_concussive");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_687c8387
// Params 2, eflags: 0x1 linked
// Checksum 0x16603a71, Offset: 0xab0
// Size: 0x20
function _off(slot, weapon) {
    level.var_61196c7 = gettime();
}

// Namespace namespace_687c8387
// Params 2, eflags: 0x1 linked
// Checksum 0x61077bd7, Offset: 0xad8
// Size: 0x14
function function_4135a1c4(slot, weapon) {
    
}

// Namespace namespace_687c8387
// Params 1, eflags: 0x5 linked
// Checksum 0x50b7817f, Offset: 0xbe8
// Size: 0x162
function function_8aac802c(weapon) {
    humans = arraycombine(getaispeciesarray("axis", "human"), getaispeciesarray("team3", "human"), 0, 0);
    robots = arraycombine(getaispeciesarray("axis", "robot"), getaispeciesarray("team3", "robot"), 0, 0);
    zombies = arraycombine(getaispeciesarray("axis", "zombie"), getaispeciesarray("team3", "zombie"), 0, 0);
    return arraycombine(zombies, arraycombine(humans, robots, 0, 0), 0, 0);
}

// Namespace namespace_687c8387
// Params 1, eflags: 0x5 linked
// Checksum 0x4a108f88, Offset: 0xd58
// Size: 0x5e
function function_602b28e9(target) {
    if (target cybercom::function_8fd8f5b1("cybercom_concussive")) {
        return false;
    }
    if (isdefined(target.usingvehicle) && target.usingvehicle) {
        return false;
    }
    return true;
}

// Namespace namespace_687c8387
// Params 0, eflags: 0x1 linked
// Checksum 0x9d5316a2, Offset: 0xdc0
// Size: 0x30
function is_jumping() {
    ground_ent = self getgroundent();
    return !isdefined(ground_ent);
}

// Namespace namespace_687c8387
// Params 2, eflags: 0x1 linked
// Checksum 0x1f696b0c, Offset: 0xdf8
// Size: 0x77a
function function_ffd5ab29(damage, attacker) {
    if (!isplayer(attacker)) {
        playfx("weapon/fx_ability_concussive_wave_impact", attacker.origin);
    }
    /#
        assert(isdefined(attacker));
    #/
    enemies = function_8aac802c();
    if (enemies.size == 0) {
        return;
    }
    radius = isdefined(attacker.cybercom) ? attacker.cybercom.var_e6fa6e38 : getdvarint("scr_concussive_wave_radius", 310);
    var_7c2e0a1a = isdefined(attacker.cybercom) ? attacker.cybercom.var_46ad3e37 : getdvarint("scr_concussive_wave_kill_radius", -61);
    var_f52a5901 = isdefined(attacker.cybercom) ? attacker.cybercom.var_4e92078e : 5;
    var_d9574143 = arraysortclosest(enemies, attacker.origin, enemies.size, 0, radius);
    weapon = getweapon("gadget_concussive_wave");
    physicsexplosionsphere(attacker.origin, 512, 512, 1);
    if (isdefined(var_d9574143) && var_d9574143.size) {
        foreach (enemy in var_d9574143) {
            if (!isdefined(enemy) || !isdefined(enemy.origin)) {
                continue;
            }
            if (!cybercom::function_7a7d1608(enemy, weapon)) {
                continue;
            }
            enemy notify(#"hash_f8c5dd60", weapon, attacker);
            attacker notify(#"hash_f045e164");
            if (enemy cybercom::function_421746e0()) {
                enemy kill(enemy.origin, attacker);
                continue;
            }
            if (enemy.archetype == "human" || enemy.archetype == "warlord" || enemy.archetype == "human_riotshield") {
                enemy dodamage(var_f52a5901, attacker.origin, attacker, attacker, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
                enemy notify(#"bhtn_action_notify", "reactBodyBlow");
                enemy thread function_78e146a3();
                attacker thread challenges::function_96ed590f("cybercom_uses_martial");
                attacker thread challenges::function_96ed590f("cybercom_uses_concussive");
                continue;
            }
            if (enemy.archetype == "robot") {
                if (length(attacker.origin - enemy.origin) < var_7c2e0a1a) {
                    enemy thread function_74fb2002(randomfloatrange(1, 2.5), attacker, weapon);
                } else if (function_f98dd1a9(enemy, attacker) < 0.83) {
                    enemy thread function_74fb2002(randomfloatrange(0.5, 1.5), attacker, weapon);
                }
                enemy clientfield::set("cybercom_shortout", 0);
                enemy ai::set_behavior_attribute("force_crawler", "gib_legs");
                attacker thread challenges::function_96ed590f("cybercom_uses_martial");
                attacker thread challenges::function_96ed590f("cybercom_uses_concussive");
                continue;
            }
            if (enemy.archetype == "zombie") {
                enemy dodamage(enemy.health + 1, enemy.origin, attacker, attacker, randomint(100) > 50 ? "right_leg_lower" : "left_leg_lower", "MOD_UNKNOWN", 0, getweapon("frag_grenade"), -1, 1);
                attacker thread challenges::function_96ed590f("cybercom_uses_martial");
                attacker thread challenges::function_96ed590f("cybercom_uses_concussive");
                if (!isalive(enemy)) {
                    enemy startragdoll();
                    launchdir = vectornormalize(enemy.origin - attacker.origin);
                    enemy launchragdoll((launchdir[0] * 70, launchdir[1] * 70, 120));
                }
            }
        }
    }
}

// Namespace namespace_687c8387
// Params 3, eflags: 0x1 linked
// Checksum 0xa886e96d, Offset: 0x1580
// Size: 0x74
function function_74fb2002(n_time, attacker, weapon) {
    self endon(#"death");
    wait(n_time);
    self dodamage(self.health + 1, self.origin, attacker, attacker, "none", "MOD_UNKNOWN", 0, weapon);
}

// Namespace namespace_687c8387
// Params 2, eflags: 0x1 linked
// Checksum 0xb8d005f9, Offset: 0x1600
// Size: 0x92
function function_f98dd1a9(enemy, attacker) {
    v_to_enemy = enemy.origin - attacker.origin;
    var_2e3e72d7 = anglestoforward(attacker.angles);
    return vectordot(var_2e3e72d7, vectornormalize(v_to_enemy));
}

// Namespace namespace_687c8387
// Params 0, eflags: 0x1 linked
// Checksum 0x4438c821, Offset: 0x16a0
// Size: 0x3a
function function_78e146a3() {
    self endon(#"death");
    self endon(#"hash_c76d622a");
    wait(1.75);
    self notify(#"bhtn_action_notify", "concussiveReact");
}

// Namespace namespace_687c8387
// Params 3, eflags: 0x1 linked
// Checksum 0x5821e62d, Offset: 0x16e8
// Size: 0x39c
function function_9ba0286c(damage, slot, weapon) {
    if (!isplayer(self)) {
        level thread function_ffd5ab29(damage, self);
        return;
    }
    self endon(#"disconnect");
    self.cybercom.var_dd2f3b84 = 1;
    self clientfield::set_to_player("cybercom_disabled", 1);
    self.var_bdd60914 = self allowsprint(0);
    if (isdefined(self.cybercom) && isdefined(self.cybercom.var_47063871)) {
        var_47063871 = self.cybercom.var_47063871;
    } else {
        var_47063871 = getweapon("hero_gravityspikes_cybercom");
    }
    /#
        assert(isdefined(var_47063871));
    #/
    self.cybercom.var_ebeecfd5 = 1;
    self giveweapon(var_47063871);
    self setweaponammoclip(var_47063871, 2);
    if (self function_1a9006bd("cybercom_concussive") == 2) {
        failsafe = gettime() + 800;
        while (self is_jumping() == 0 && self hasweapon(var_47063871) && gettime() < failsafe) {
            wait(0.05);
        }
        while (self is_jumping() == 1 && self hasweapon(var_47063871) && gettime() < failsafe) {
            wait(0.05);
        }
    } else {
        wait(0.6);
    }
    self playrumbleonentity("grenade_rumble");
    earthquake(0.6, 0.5, self.origin, 256);
    if (isdefined(var_47063871) && self hasweapon(var_47063871)) {
        self takeweapon(var_47063871);
    }
    self.cybercom.var_ebeecfd5 = undefined;
    level thread function_ffd5ab29(damage, self);
    wait(getdvarint("scr_concussive_wave_no_sprint", 1));
    self allowsprint(self.var_bdd60914);
    self.var_bdd60914 = undefined;
    self.cybercom.var_dd2f3b84 = undefined;
    self clientfield::set_to_player("cybercom_disabled", 0);
    wait(0.1);
}

