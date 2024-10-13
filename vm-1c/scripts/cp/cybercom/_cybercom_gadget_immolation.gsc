#using scripts/shared/ai/systems/blackboard;
#using scripts/cp/_challenges;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/ai_shared;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/cybercom/_cybercom;
#using scripts/shared/lui_shared;
#using scripts/shared/ai/systems/gib;
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
#using scripts/shared/math_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_a56eec64;

// Namespace namespace_a56eec64
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x7b0
// Size: 0x4
function init() {
    
}

// Namespace namespace_a56eec64
// Params 0, eflags: 0x1 linked
// Checksum 0xccebbc3a, Offset: 0x7c0
// Size: 0x22c
function main() {
    namespace_d00ec32::function_36b56038(2, 4);
    level.cybercom.immolation = spawnstruct();
    level.cybercom.immolation.var_875da84b = &function_875da84b;
    level.cybercom.immolation.var_8d01efb6 = &function_8d01efb6;
    level.cybercom.immolation.var_bdb47551 = &function_bdb47551;
    level.cybercom.immolation.var_39ea6a1b = &function_39ea6a1b;
    level.cybercom.immolation.var_5d2fec30 = &function_5d2fec30;
    level.cybercom.immolation._on = &_on;
    level.cybercom.immolation._off = &_off;
    level.cybercom.immolation.var_4135a1c4 = &function_4135a1c4;
    level.cybercom.immolation.var_d4d82e00 = array("j_shoulder_le_rot", "j_elbow_le_rot", "j_shoulder_ri_rot", "j_elbow_ri_rot", "j_hip_le", "j_knee_le", "j_hip_ri", "j_knee_ri", "j_head", "j_mainroot");
    level.cybercom.immolation.var_81f1fce4 = array("frag_grenade_notrail", "emp_grenade");
}

// Namespace namespace_a56eec64
// Params 1, eflags: 0x1 linked
// Checksum 0xf7cb068e, Offset: 0x9f8
// Size: 0xc
function function_875da84b(slot) {
    
}

// Namespace namespace_a56eec64
// Params 2, eflags: 0x1 linked
// Checksum 0x6260790c, Offset: 0xa10
// Size: 0x14
function function_8d01efb6(slot, weapon) {
    
}

// Namespace namespace_a56eec64
// Params 2, eflags: 0x1 linked
// Checksum 0x20aff044, Offset: 0xa30
// Size: 0xf4
function function_bdb47551(slot, weapon) {
    self.cybercom.var_110c156a = getdvarint("scr_immolation_count", 1);
    if (self function_1a9006bd("cybercom_immolation") == 2) {
        self.cybercom.var_110c156a = getdvarint("scr_immolation_upgraded_count", 1);
    }
    self.cybercom.var_9d8e0758 = &function_8aac802c;
    self.cybercom.var_c40accd3 = &function_602b28e9;
    self thread cybercom::function_b5f4e597(weapon);
}

// Namespace namespace_a56eec64
// Params 2, eflags: 0x1 linked
// Checksum 0x48268750, Offset: 0xb30
// Size: 0x52
function function_39ea6a1b(slot, weapon) {
    self _off(slot, weapon);
    self.cybercom.var_9d8e0758 = undefined;
    self.cybercom.var_c40accd3 = undefined;
}

// Namespace namespace_a56eec64
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xb90
// Size: 0x4
function function_5d2fec30() {
    
}

// Namespace namespace_a56eec64
// Params 2, eflags: 0x1 linked
// Checksum 0xaad1d4e3, Offset: 0xba0
// Size: 0x54
function _on(slot, weapon) {
    self thread function_24d3045f(slot, weapon);
    self _off(slot, weapon);
}

// Namespace namespace_a56eec64
// Params 2, eflags: 0x1 linked
// Checksum 0x72cef02f, Offset: 0xc00
// Size: 0x46
function _off(slot, weapon) {
    self thread cybercom::function_d51412df(weapon);
    self.cybercom.var_301030f7 = undefined;
    self notify(#"hash_c74ed649");
}

// Namespace namespace_a56eec64
// Params 2, eflags: 0x1 linked
// Checksum 0x501b5d5c, Offset: 0xc50
// Size: 0xb0
function function_4135a1c4(slot, weapon) {
    if (!(isdefined(self.cybercom.var_301030f7) && self.cybercom.var_301030f7)) {
        assert(self.cybercom.var_2e20c9bd == weapon);
        self notify(#"hash_9cefb9d9");
        self thread cybercom::function_2006f7d0(slot, weapon, self.cybercom.var_110c156a);
        self.cybercom.var_301030f7 = 1;
    }
}

// Namespace namespace_a56eec64
// Params 1, eflags: 0x5 linked
// Checksum 0x550be, Offset: 0xd08
// Size: 0x308
function private function_602b28e9(target) {
    if (target cybercom::function_8fd8f5b1("cybercom_immolation")) {
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
    if (!isdefined(target.archetype)) {
        return false;
    }
    if (isvehicle(target) && !target function_a2f96b90()) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (!isactor(target) && !isvehicle(target)) {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if (target.archetype != "robot" && target.archetype != "human" && isactor(target) && target.archetype != "human_riotshield") {
        self cybercom::function_29bf9dee(target, 2);
        return false;
    }
    if ((target.archetype == "human" || target.archetype == "human_riotshield") && isplayer(self)) {
        if (!(self function_1a9006bd("cybercom_immolation") == 2)) {
            self cybercom::function_29bf9dee(target, 2);
            return false;
        }
    }
    if (isactor(target) && !target isonground() && !target cybercom::function_421746e0()) {
        return false;
    }
    return true;
}

// Namespace namespace_a56eec64
// Params 1, eflags: 0x5 linked
// Checksum 0x28541bbd, Offset: 0x1018
// Size: 0x52
function private function_8aac802c(weapon) {
    return arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
}

// Namespace namespace_a56eec64
// Params 2, eflags: 0x5 linked
// Checksum 0x28055ef7, Offset: 0x1078
// Size: 0x314
function private function_24d3045f(slot, weapon) {
    upgraded = self function_1a9006bd("cybercom_immolation") == 2;
    aborted = 0;
    fired = 0;
    foreach (item in self.cybercom.var_d1460543) {
        if (isdefined(item.inrange) && isdefined(item.target) && item.inrange) {
            if (item.inrange == 1) {
                if (!cybercom::function_7a7d1608(item.target, weapon)) {
                    continue;
                }
                self thread challenges::function_96ed590f("cybercom_uses_chaos");
                item.target.var_23ebae6c = item.target.origin;
                item.target thread function_9e65a7de(self, upgraded, 0, weapon);
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
        itemindex = getitemindexfromref("cybercom_immolation");
        if (isdefined(itemindex)) {
            self adddstat("ItemStats", itemindex, "stats", "kills", "statValue", fired);
            self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
        }
    }
}

// Namespace namespace_a56eec64
// Params 0, eflags: 0x5 linked
// Checksum 0xd6daf44a, Offset: 0x1398
// Size: 0x8e
function private function_a2f96b90() {
    if (!isdefined(self.vehicletype)) {
        return false;
    }
    if (issubstr(self.vehicletype, "amws")) {
        return true;
    }
    if (issubstr(self.vehicletype, "wasp")) {
        return true;
    }
    if (issubstr(self.vehicletype, "raps")) {
        return true;
    }
    return false;
}

// Namespace namespace_a56eec64
// Params 3, eflags: 0x5 linked
// Checksum 0xc4afa14f, Offset: 0x1430
// Size: 0xc4
function private function_972e7bf2(attacker, upgraded, immediate) {
    if (!isdefined(immediate)) {
        immediate = 0;
    }
    assert(self function_a2f96b90());
    self clientfield::set("cybercom_immolate", 1);
    self.is_disabled = 1;
    if (!immediate) {
        wait randomfloatrange(0, 0.75);
    }
    self thread vehicle_ai::immolate(attacker);
}

// Namespace namespace_a56eec64
// Params 4, eflags: 0x5 linked
// Checksum 0x3dbf409b, Offset: 0x1500
// Size: 0x17c
function private function_9e65a7de(attacker, upgraded, immediate, weapon) {
    if (!isdefined(immediate)) {
        immediate = 0;
    }
    self notify(#"cybercom_action", weapon, attacker);
    if (self cybercom::function_421746e0()) {
        if (isvehicle(self)) {
            self kill(self.origin, isdefined(attacker) ? attacker : undefined, undefined, weapon);
            return;
        } else {
            immediate = 1;
        }
    }
    if (isvehicle(self)) {
        self thread function_972e7bf2(attacker, upgraded);
        return;
    }
    if (self.archetype == "robot") {
        self thread function_c7fa793a(attacker, upgraded, immediate);
        return;
    }
    if (self.archetype == "human" || self.archetype == "human_riotshield") {
        self thread function_ce51c2a1(attacker, upgraded, immediate);
    }
}

// Namespace namespace_a56eec64
// Params 4, eflags: 0x1 linked
// Checksum 0xcf210e22, Offset: 0x1688
// Size: 0x12c
function function_1ed56488(tag, count, attacker, weapon) {
    msg = self util::waittill_any_timeout(3, "death", "explode", "damage");
    if (isdefined(self.var_c4da69e3)) {
        self.var_c4da69e3 delete();
    }
    self stopsound("gdt_immolation_human_countdown");
    attacker thread function_843196fe(self, 100, count);
    if (isalive(self)) {
        self stopanimscripted();
        self kill(self.origin, isdefined(attacker) ? attacker : undefined, undefined, weapon);
    }
}

// Namespace namespace_a56eec64
// Params 3, eflags: 0x1 linked
// Checksum 0xebeb8db3, Offset: 0x17c0
// Size: 0x4ac
function function_ce51c2a1(attacker, upgraded, immediate) {
    if (!isdefined(immediate)) {
        immediate = 0;
    }
    self endon(#"death");
    weapon = getweapon("gadget_immolation");
    self clientfield::set("cybercom_immolate", 1);
    if (immediate) {
        self.ignoreall = 1;
        self clientfield::set("arch_actor_fire_fx", 1);
        self thread function_369d3494();
        util::wait_network_frame();
        self thread function_1ed56488("tag_weapon_chest", undefined, attacker, weapon);
        self kill(self.origin, isdefined(attacker) ? attacker : undefined, undefined, weapon);
        return;
    }
    wait randomfloatrange(0.1, 0.75);
    if (!attacker cybercom::function_7a7d1608(self, weapon, 0)) {
        return;
    }
    self.is_disabled = 1;
    self.ignoreall = 1;
    tag = undefined;
    var_17ca86c6 = undefined;
    if (self.archetype != "human_riotshield" && self cybercom::getentitypose() == "stand" && randomint(100) < getdvarint("scr_immolation_specialanimchance", 15)) {
        self notify(#"bhtn_action_notify", "reactImmolationLong");
        self thread function_1ed56488("tag_inhand", 1, attacker, weapon);
        self animscripted("immo_anim", self.origin, self.angles, "ai_base_rifle_stn_exposed_immolate_explode_midthrow");
        self thread cybercom::function_cf64f12c("damage_pain", "immo_anim", 1, attacker, weapon);
        self waittillmatch(#"immo_anim", "grenade_right");
        self.var_c4da69e3 = spawn("script_model", self gettagorigin("tag_inhand"));
        self.var_c4da69e3 setmodel("wpn_t7_grenade_frag_world");
        self.var_c4da69e3 enablelinkto();
        self.var_c4da69e3 linkto(self, "tag_inhand");
        playfxontag("light/fx_ability_light_chest_immolation", self.var_c4da69e3, "tag_origin");
        self waittillmatch(#"immo_anim", "explode");
        self stopsound("gdt_immolation_human_countdown");
        self notify(#"explode");
        return;
    }
    self notify(#"bhtn_action_notify", "reactImmolation");
    self dodamage(5, self.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
    playfxontag("light/fx_ability_light_chest_immolation", self, "tag_weapon_chest");
    self thread function_f8956516();
    self thread function_1ed56488("tag_weapon_chest", undefined, attacker, weapon);
}

// Namespace namespace_a56eec64
// Params 0, eflags: 0x1 linked
// Checksum 0x412b751c, Offset: 0x1c78
// Size: 0x52
function function_f8956516() {
    self endon(#"death");
    self waittillmatch(#"bhtn_action_terminate", "specialpain");
    self stopsound("gdt_immolation_human_countdown");
    self notify(#"explode");
}

// Namespace namespace_a56eec64
// Params 3, eflags: 0x1 linked
// Checksum 0x76293f08, Offset: 0x1cd8
// Size: 0x524
function function_c7fa793a(attacker, upgraded, immediate) {
    if (!isdefined(immediate)) {
        immediate = 0;
    }
    self endon(#"death");
    if (!immediate) {
        wait randomfloatrange(0.1, 0.75);
    }
    weapon = getweapon("gadget_immolation");
    if (!attacker cybercom::function_7a7d1608(self, weapon, 0)) {
        return;
    }
    self.is_disabled = 1;
    if (isdefined(self.iscrawler) && self.iscrawler || !cybercom::function_76e3026d(self)) {
        self playsound("wpn_incendiary_explode");
        physicsexplosionsphere(self.origin, -56, 32, 2);
        self function_5a760e8b(attacker, upgraded);
        origin = self.origin;
        self dodamage(self.health, self.origin, isdefined(attacker) ? attacker : undefined, isdefined(attacker) ? attacker : undefined, "none", "MOD_BURNED", 0, weapon, -1, 1);
        wait 0.1;
        radiusdamage(origin, getdvarint("scr_immolation_outer_radius", -21), 500, 30, isdefined(attacker) ? attacker : undefined, "MOD_EXPLOSIVE", weapon);
        return;
    }
    self clientfield::set("arch_actor_fire_fx", 1);
    self clientfield::set("cybercom_immolate", 1);
    self thread function_369d3494();
    self.ignoreall = 1;
    type = self cybercom::function_5e3d3aa();
    self.ignoreall = 1;
    variant = "_" + randomint(3);
    if (variant == "_0") {
        variant = "";
    }
    var_a30bdd5a = getdvarfloat("scr_immolation_death_delay", 0.87) + randomfloatrange(0, 0.2);
    var_ebfa18e1 = gettime() + var_a30bdd5a * 1000;
    self dodamage(5, self.origin, isdefined(attacker) ? attacker : undefined, undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
    while (gettime() < var_ebfa18e1) {
        wait 0.1;
    }
    self clientfield::set("cybercom_immolate", 2);
    self function_5a760e8b(attacker, upgraded);
    if (upgraded) {
    }
    level notify(#"hash_f90d73d4");
    attacker notify(#"hash_f90d73d4");
    util::wait_network_frame();
    origin = self.origin;
    self dodamage(self.health, self.origin, isdefined(attacker) ? attacker : undefined, isdefined(attacker) ? attacker : undefined, "none", "MOD_BURNED", 0, weapon, -1, 1);
    radiusdamage(origin, getdvarint("scr_immolation_outer_radius", -21), 500, 30, isdefined(attacker) ? attacker : undefined, "MOD_EXPLOSIVE", weapon);
}

// Namespace namespace_a56eec64
// Params 0, eflags: 0x5 linked
// Checksum 0x9db6324e, Offset: 0x2208
// Size: 0x54
function private function_369d3494() {
    archetype = self.archetype;
    corpse = self waittill(#"actor_corpse");
    corpse clientfield::set("arch_actor_fire_fx", 2);
}

// Namespace namespace_a56eec64
// Params 3, eflags: 0x5 linked
// Checksum 0x9b9c19b0, Offset: 0x2268
// Size: 0x2c8
function private function_843196fe(guy, chance, var_d9346487) {
    if (!isdefined(chance)) {
        chance = getdvarint("scr_immolation_gchance", 100);
    }
    self endon(#"disconnect");
    loc = guy function_ed100874();
    if (!isdefined(loc)) {
        loc = guy.origin + (0, 0, 50);
    }
    grenade = self magicgrenadetype(getweapon("frag_grenade_notrail"), loc, (0, 0, 0), 0);
    if (!isdefined(var_d9346487)) {
        var_d9346487 = randomint(getdvarint("scr_immolation_gcount", 3)) + 1;
    }
    while (var_d9346487 && isdefined(self) && isdefined(guy)) {
        wait randomfloatrange(getdvarfloat("scr_immolation_grenade_wait_timeMIN", 0.3), getdvarfloat("scr_immolation_grenade_wait_timeMAX", 0.9));
        var_d9346487--;
        if (randomint(100) > chance) {
            continue;
        }
        var_f51eccb0 = level.cybercom.immolation.var_81f1fce4[randomint(level.cybercom.immolation.var_81f1fce4.size)];
        /#
        #/
        if (isdefined(guy)) {
            loc = guy function_ed100874();
            if (!isdefined(loc)) {
                loc = guy.origin + (0, 0, 50);
            }
        }
        if (isdefined(loc)) {
            grenade = self magicgrenadetype(getweapon(var_f51eccb0), loc, (0, 0, 0), 0.05);
            grenade thread function_2905cb0a();
        }
    }
}

// Namespace namespace_a56eec64
// Params 0, eflags: 0x1 linked
// Checksum 0xf6dd4892, Offset: 0x2538
// Size: 0x4c
function function_2905cb0a() {
    self util::waittill_any_timeout(3, "death", "detonated");
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace namespace_a56eec64
// Params 2, eflags: 0x4
// Checksum 0x5530daba, Offset: 0x2590
// Size: 0x1b2
function private function_e531a31b(player, rangemax) {
    weapon = getweapon("gadget_immolation");
    enemies = arraycombine(getaispeciesarray("axis", "robot"), getaispeciesarray("team3", "robot"), 0, 0);
    var_d9574143 = arraysortclosest(enemies, self.origin, enemies.size, 0, rangemax);
    foreach (guy in var_d9574143) {
        if (player cybercom::function_7a7d1608(guy, weapon)) {
            if (isdefined(guy.var_2557be09) && guy.var_2557be09) {
                continue;
            }
            guy.var_2557be09 = 1;
            player thread function_843196fe(guy);
        }
    }
}

// Namespace namespace_a56eec64
// Params 2, eflags: 0x1 linked
// Checksum 0x7a5f22c4, Offset: 0x2750
// Size: 0x1fa
function function_5a760e8b(attacker, upgraded) {
    weapon = getweapon("gadget_immolation");
    targets = function_8aac802c();
    var_5b8b9202 = 0;
    var_d9574143 = arraysortclosest(targets, self.origin, 666, 0, getdvarint("scr_immolation_radius", -106));
    foreach (guy in var_d9574143) {
        if (guy == self) {
            continue;
        }
        if (isdefined(attacker.var_a691a602)) {
            if (attacker.var_a691a602 >= 2) {
                break;
            }
        }
        if (attacker cybercom::function_7a7d1608(guy, weapon)) {
            if (!isdefined(attacker.var_a691a602)) {
                attacker thread function_4f174738();
            } else {
                attacker.var_a691a602++;
            }
            if (isvehicle(guy)) {
                continue;
            }
            guy thread function_9e65a7de(attacker, upgraded, 1, weapon);
        }
    }
}

// Namespace namespace_a56eec64
// Params 0, eflags: 0x5 linked
// Checksum 0x24dd27fd, Offset: 0x2958
// Size: 0xb2
function private function_ed100874() {
    if (isdefined(self.archetype) && self.archetype == "human") {
        return self gettagorigin("tag_weapon_chest");
    }
    tag = level.cybercom.immolation.var_d4d82e00[randomint(level.cybercom.immolation.var_d4d82e00.size)];
    return self gettagorigin(tag);
}

// Namespace namespace_a56eec64
// Params 3, eflags: 0x1 linked
// Checksum 0x41e07c47, Offset: 0x2a18
// Size: 0x2da
function function_9eebfb7(target, var_9bc2efcb, upgraded) {
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
        self waittillmatch(#"ai_cybercom_anim", "fire");
    }
    weapon = getweapon("gadget_immolation");
    foreach (guy in validtargets) {
        if (!self cybercom::function_7a7d1608(guy, weapon)) {
            continue;
        }
        guy thread function_9e65a7de(self, upgraded, 0, getweapon("gadget_immolation"));
        wait 0.05;
    }
}

// Namespace namespace_a56eec64
// Params 0, eflags: 0x1 linked
// Checksum 0xa42170d5, Offset: 0x2d00
// Size: 0x26
function function_4f174738() {
    self endon(#"death");
    self.var_a691a602 = 0;
    wait 2;
    self.var_a691a602 = undefined;
}

