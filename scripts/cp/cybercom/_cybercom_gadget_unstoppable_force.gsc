#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/_achievements;
#using scripts/shared/statemachine_shared;
#using scripts/shared/array_shared;
#using scripts/shared/system_shared;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_354e20c0;

// Namespace namespace_354e20c0
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x490
// Size: 0x4
function init() {
    
}

// Namespace namespace_354e20c0
// Params 0, eflags: 0x1 linked
// Checksum 0xd56624ed, Offset: 0x4a0
// Size: 0x1b4
function main() {
    namespace_d00ec32::function_36b56038(1, 32, 1);
    level.cybercom.unstoppable_force = spawnstruct();
    level.cybercom.unstoppable_force.var_875da84b = &function_875da84b;
    level.cybercom.unstoppable_force.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.unstoppable_force.var_bdb47551 = &function_bdb47551;
    level.cybercom.unstoppable_force.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.unstoppable_force.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.unstoppable_force._on = &_on;
    level.cybercom.unstoppable_force._off = &_off;
    level.cybercom.unstoppable_force.var_4135a1c4 = &function_4135a1c4;
    level.cybercom.unstoppable_force.weapon = getweapon("gadget_unstoppable_force");
}

// Namespace namespace_354e20c0
// Params 1, eflags: 0x1 linked
// Checksum 0xb8a858d, Offset: 0x660
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_354e20c0
// Params 2, eflags: 0x1 linked
// Checksum 0x2d847b4d, Offset: 0x678
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_354e20c0
// Params 2, eflags: 0x1 linked
// Checksum 0x7cc6630e, Offset: 0x698
// Size: 0x4c
function function_bdb47551(slot, weapon) {
    self.cybercom.var_9d8e0758 = undefined;
    self.cybercom.var_c40accd3 = undefined;
    self thread cybercom::function_b5f4e597(weapon);
}

// Namespace namespace_354e20c0
// Params 2, eflags: 0x1 linked
// Checksum 0xf459e1fc, Offset: 0x6f0
// Size: 0x22
function function_39ea6a1b(slot, weapon) {
    self.cybercom.var_301030f7 = undefined;
}

// Namespace namespace_354e20c0
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x720
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_354e20c0
// Params 2, eflags: 0x1 linked
// Checksum 0xbb463f3, Offset: 0x730
// Size: 0x144
function _on(slot, weapon) {
    self disableoffhandweapons();
    self disableweaponcycling();
    achievements::function_386309ce(self);
    self.cybercom.var_301030f7 = undefined;
    self notify(weapon.name + "_fired");
    level notify(weapon.name + "_fired");
    self thread function_875f1595(slot, weapon);
    if (isplayer(self)) {
        itemindex = getitemindexfromref("cybercom_unstoppableforce");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_354e20c0
// Params 2, eflags: 0x1 linked
// Checksum 0xe2461242, Offset: 0x880
// Size: 0xb4
function _off(slot, weapon) {
    self clientfield::set_to_player("unstoppableforce_state", 0);
    self notify(#"hash_13da8804");
    self notify(#"hash_1f17ce9a");
    self playsound("gdt_unstoppable_stop");
    self gadgetpowerset(slot, 0);
    self enableoffhandweapons();
    self enableweaponcycling();
}

// Namespace namespace_354e20c0
// Params 2, eflags: 0x5 linked
// Checksum 0x2b856617, Offset: 0x940
// Size: 0x44
function function_1852a14f(slot, weapon) {
    self endon(#"weapon_melee_juke");
    wait(0.5);
    self gadgetpowerchange(slot, -100);
}

// Namespace namespace_354e20c0
// Params 2, eflags: 0x5 linked
// Checksum 0x1292c7b8, Offset: 0x990
// Size: 0x54
function function_6c3ee126(slot, weapon) {
    self endon(#"disconnect");
    self endon(#"hash_1f17ce9a");
    self waittill(#"weapon_melee_juke_end");
    self gadgetpowerset(slot, 0);
}

// Namespace namespace_354e20c0
// Params 2, eflags: 0x5 linked
// Checksum 0xf2827496, Offset: 0x9f0
// Size: 0xbc
function function_98296a6a(slot, weapon) {
    self endon(#"death");
    self endon(#"disconnect");
    endreason = self waittill(#"weapon_juke_end_requested");
    if (endreason == 2) {
        earthquake(1, 0.75, self.origin, 100);
        self playrumbleonentity("riotshield_impact");
        self playsound("gdt_unstoppable_hit_wall");
    }
}

// Namespace namespace_354e20c0
// Params 2, eflags: 0x1 linked
// Checksum 0x6eafd620, Offset: 0xab8
// Size: 0x14
function function_4135a1c4(slot, weapon) {
    
}

// Namespace namespace_354e20c0
// Params 2, eflags: 0x5 linked
// Checksum 0x40fa9ea2, Offset: 0xad8
// Size: 0x114
function function_875f1595(slot, weapon) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_1f17ce9a");
    self clientfield::set_to_player("unstoppableforce_state", 1);
    wait(0.05);
    if (self isswitchingweapons()) {
        self waittill(#"weapon_change_complete");
    }
    self thread function_941861e(weapon);
    self thread function_6c3ee126(slot, weapon);
    self thread function_98296a6a(slot, weapon);
    self thread function_1852a14f(slot, weapon);
    self queuemeleeactionstate();
}

// Namespace namespace_354e20c0
// Params 1, eflags: 0x5 linked
// Checksum 0x6e8607a5, Offset: 0xbf8
// Size: 0x1b0
function function_2c971ed8(target) {
    if (!isdefined(target)) {
        return false;
    }
    if (!isalive(target)) {
        return false;
    }
    if (target cybercom::function_8fd8f5b1("cybercom_unstoppableforce")) {
        return false;
    }
    if (!(isdefined(target.takedamage) && target.takedamage)) {
        return false;
    }
    if (isactor(target)) {
        if (target isinscriptedstate() && !(isdefined(target.is_disabled) && target.is_disabled)) {
            if (!target cybercom::function_421746e0()) {
                return false;
            }
        }
    }
    if (!(isdefined(target.allowdeath) && target.allowdeath)) {
        return false;
    }
    if (isdefined(target.blockingpain) && target.blockingpain) {
        return false;
    }
    if (isactor(target) && target cybercom::getentitypose() != "stand" && target cybercom::getentitypose() != "crouch") {
        return false;
    }
    return true;
}

// Namespace namespace_354e20c0
// Params 0, eflags: 0x5 linked
// Checksum 0xc43471f1, Offset: 0xdb0
// Size: 0x106
function function_8aac802c() {
    enemies = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
    valid = [];
    foreach (var_8ae1cd80 in enemies) {
        if (!function_2c971ed8(var_8ae1cd80)) {
            continue;
        }
        valid[valid.size] = var_8ae1cd80;
    }
    return valid;
}

// Namespace namespace_354e20c0
// Params 0, eflags: 0x5 linked
// Checksum 0xf18a0b83, Offset: 0xec0
// Size: 0x2a
function function_40b93b78() {
    self stopjukemove();
    self notify(#"hash_13da8804");
}

// Namespace namespace_354e20c0
// Params 2, eflags: 0x5 linked
// Checksum 0xcfcb6134, Offset: 0xef8
// Size: 0x304
function hit_vehicle(enemy, weapon) {
    if (enemy cybercom::islinked()) {
        enemy unlink();
    }
    enemy notify(#"hash_f8c5dd60", weapon, self);
    if (enemy.scriptvehicletype == "quadtank" || enemy.scriptvehicletype == "siegebot") {
        enemy dodamage(getdvarint("scr_unstoppable_heavy_vehicle_damage", 300), self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1);
        self function_40b93b78();
        return;
    }
    if (enemy.scriptvehicletype == "raps" || enemy.scriptvehicletype == "wasp") {
        enemy dodamage(enemy.health, self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1);
        return;
    }
    if (enemy.scriptvehicletype == "amws") {
        enemy dodamage(enemy.health, self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1);
        self function_40b93b78();
        return;
    }
    if (enemy.scriptvehicletype == "") {
        if (enemy.archetype == "turret") {
            enemy dodamage(enemy.health, self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1);
            self function_40b93b78();
        }
    }
}

// Namespace namespace_354e20c0
// Params 2, eflags: 0x1 linked
// Checksum 0x61394378, Offset: 0x1208
// Size: 0x264
function hit_enemy(guy, weapon) {
    if (guy cybercom::islinked()) {
        guy unlink();
    }
    guy notify(#"hash_f8c5dd60", weapon, self);
    if (guy.archetype == "warlord") {
        if (isdefined(guy.is_disabled) && guy.is_disabled) {
            guy dodamage(guy.health, self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.var_bf0de5fb, -1, 1);
        } else {
            guy dodamage(getdvarint("scr_unstoppable_warlord_damage", 40), self.origin, self, self, "none", "MOD_IMPACT", 512, level.cybercom.unstoppable_force.weapon, -1, 1);
        }
    } else if (guy.archetype == "human_riotshield") {
        guy dodamage(guy.health, self.origin, self, self, "none", "MOD_IMPACT", 0, weapon, -1, 1);
        guy notify(#"bhtn_action_notify", "reactBodyBlow");
    } else {
        guy function_b4852552(self);
    }
    if (guy.archetype == "robot") {
        self playsound("gdt_unstoppable_hit_bot");
        return;
    }
    self playsound("gdt_unstoppable_hit_human");
}

// Namespace namespace_354e20c0
// Params 1, eflags: 0x1 linked
// Checksum 0xbb304b91, Offset: 0x1478
// Size: 0x1c0
function function_941861e(weapon) {
    self notify(#"hash_13da8804");
    self endon(#"hash_13da8804");
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        enemies = function_518996b3();
        hit = 0;
        foreach (guy in enemies) {
            hit++;
            if (isvehicle(guy)) {
                self playsound("gdt_unstoppable_hit_veh");
                self hit_vehicle(guy, weapon);
                continue;
            }
            self hit_enemy(guy, weapon);
        }
        if (hit) {
            earthquake(1, 0.75, self.origin, 100);
            self playrumbleonentity("damage_heavy");
        }
        wait(0.05);
    }
}

// Namespace namespace_354e20c0
// Params 0, eflags: 0x1 linked
// Checksum 0x1a0511bb, Offset: 0x1640
// Size: 0x336
function function_518996b3() {
    enemies = function_8aac802c();
    view_pos = self.origin;
    validtargets = array::get_all_closest(view_pos, enemies, undefined, undefined, 120);
    if (!isdefined(validtargets)) {
        return;
    }
    forward = anglestoforward(self getplayerangles());
    up = anglestoup(self getplayerangles());
    var_e09fef25 = view_pos + 36 * forward;
    var_faa0b366 = var_e09fef25 + (120 - 36) * forward;
    fling_force = getdvarint("scr_unstoppable_fling_force", -81);
    var_7ae8c5ad = fling_force * 0.5;
    var_b2aa696f = fling_force * 0.6;
    enemies = [];
    for (i = 0; i < validtargets.size; i++) {
        if (!isdefined(validtargets[i]) || !isalive(validtargets[i])) {
            continue;
        }
        test_origin = validtargets[i] getcentroid();
        radial_origin = pointonsegmentnearesttopoint(var_e09fef25, var_faa0b366, test_origin);
        var_6c1219a = test_origin - radial_origin;
        if (abs(var_6c1219a[2]) > 72) {
            continue;
        }
        var_6c1219a = (var_6c1219a[0], var_6c1219a[1], 0);
        len = length(var_6c1219a);
        if (len > 36) {
            continue;
        }
        var_6c1219a = (var_6c1219a[0], var_6c1219a[1], 0);
        validtargets[i].fling_vec = fling_force * forward + randomfloatrange(var_7ae8c5ad, var_b2aa696f) * up;
        enemies[enemies.size] = validtargets[i];
    }
    return enemies;
}

// Namespace namespace_354e20c0
// Params 1, eflags: 0x1 linked
// Checksum 0xda4231cc, Offset: 0x1980
// Size: 0xbc
function function_b4852552(player) {
    if (!isdefined(self) || !isalive(self)) {
        return;
    }
    self dodamage(self.health, player.origin, player, player, "", "MOD_IMPACT");
    if (isdefined(self.fling_vec)) {
        self startragdoll(1);
        self launchragdoll(self.fling_vec);
    }
}

