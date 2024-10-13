#using scripts/cp/doa/_doa_utility;
#using scripts/cp/doa/_doa_gibs;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/codescripts/struct;

#namespace namespace_eaa992c;

// Namespace namespace_eaa992c
// Params 0, eflags: 0x1 linked
// Checksum 0xd3e9e999, Offset: 0x9c0
// Size: 0xfe4
function init() {
    level._effect["def_explode"] = "explosions/fx_exp_grenade_default";
    level._effect["impact_raygun"] = "zombie/fx_raygun_impact_zmb";
    level._effect["impact_raygun1"] = "zombie/fx_raygun_impact_zmb";
    level._effect["impact_raygun2"] = "zombie/fx_blood_torso_explo_lg_os_zmb";
    level._effect["impact_rpg"] = "zombie/fx_blood_torso_explo_lg_os_zmb";
    level._effect["ground_pound"] = "zombie/fx_turret_impact_doa";
    level._effect["truck_splash"] = "water/fx_water_splash_doa_truck";
    function_6dcb1bbc("boots", 1);
    function_6dcb1bbc("magnet_on", 2);
    function_6dcb1bbc("magnet_fade", 2);
    function_6dcb1bbc("stunbear", 4);
    function_6dcb1bbc("stunbear_fade", 5);
    function_6dcb1bbc("glow_red", 6);
    function_6dcb1bbc("glow_green", 7);
    function_6dcb1bbc("glow_blue", 8);
    function_6dcb1bbc("glow_yellow", 9);
    function_6dcb1bbc("glow_white", 10);
    function_6dcb1bbc("glow_item", 11);
    function_6dcb1bbc("timeshift", 12);
    function_6dcb1bbc("timeshift_fade", 12);
    function_6dcb1bbc("tesla_launch", 14);
    function_6dcb1bbc("tesla_trail", 15);
    function_6dcb1bbc("tesla_shock", 16);
    function_6dcb1bbc("tesla_shock_eyes", 17);
    function_6dcb1bbc("hazard_electric", 18);
    function_6dcb1bbc("player_respawn_green", 19);
    function_6dcb1bbc("player_respawn_blue", 70);
    function_6dcb1bbc("player_respawn_red", 71);
    function_6dcb1bbc("player_respawn_yellow", 72);
    function_6dcb1bbc("hazard_water", 20);
    function_6dcb1bbc("stoneboss_shield_death", 27);
    function_6dcb1bbc("stoneboss_shield_explode", 28);
    function_6dcb1bbc("stoneboss_death", 21);
    function_6dcb1bbc("stoneboss_dmg1", 22);
    function_6dcb1bbc("stoneboss_dmg2", 23);
    function_6dcb1bbc("stoneboss_dmg3", 24);
    function_6dcb1bbc("stoneboss_dmg4", 25);
    function_6dcb1bbc("stoneboss_dmg5", 26);
    function_6dcb1bbc("fate_impact", 29);
    function_6dcb1bbc("fate_trigger", 30);
    function_6dcb1bbc("fate_explode", 31);
    function_6dcb1bbc("fate_launch", 32);
    function_6dcb1bbc("fate2_awarded", 33);
    function_6dcb1bbc("def_explode", 34);
    function_6dcb1bbc("fire_trail", 35);
    function_6dcb1bbc("veh_takeoff", 36);
    function_6dcb1bbc("egg_hatch", 37);
    function_6dcb1bbc("egg_explode", 38);
    function_6dcb1bbc("monkey_explode", 39);
    function_6dcb1bbc("boss_takeoff", 40);
    function_6dcb1bbc("sprinkler_land", 41);
    function_6dcb1bbc("sprinkler_takeoff", 42);
    function_6dcb1bbc("sprinkler_active", 43);
    function_6dcb1bbc("red_shield", 44);
    function_6dcb1bbc("timeshift_contact", 45);
    function_6dcb1bbc("stunbear_contact", 46);
    function_6dcb1bbc("tesla_ball", 47);
    function_6dcb1bbc("chicken_explode", 48);
    function_6dcb1bbc("gem_trail_red", 49);
    function_6dcb1bbc("gem_trail_white", 50);
    function_6dcb1bbc("gem_trail_blue", 51);
    function_6dcb1bbc("gem_trail_green", 52);
    function_6dcb1bbc("gem_trail_yellow", 53);
    function_6dcb1bbc("trail_fast", 54);
    function_6dcb1bbc("margwa_intro", 55);
    function_6dcb1bbc("margwa_head_explode", 56);
    function_6dcb1bbc("slow_feet", 57);
    function_6dcb1bbc("player_trail_green", 58);
    function_6dcb1bbc("player_trail_blue", 59);
    function_6dcb1bbc("player_trail_red", 60);
    function_6dcb1bbc("player_trail_yellow", 61);
    function_6dcb1bbc("fast_feet", 64);
    function_6dcb1bbc("fury_patch", 63);
    function_6dcb1bbc("fury_boost", 62);
    function_6dcb1bbc("turret_impact", 65);
    function_6dcb1bbc("crater_dust", 66);
    function_6dcb1bbc("blow_hole", 67);
    function_6dcb1bbc("teleporter", 68);
    function_6dcb1bbc("egg_hatchXL", 69);
    function_6dcb1bbc("boxing_pow", 73);
    function_6dcb1bbc("boxing_stars", 74);
    function_6dcb1bbc("player_flashlight", 75);
    function_6dcb1bbc("meatball_trail", 76);
    function_6dcb1bbc("stunbear_affected", 77);
    function_6dcb1bbc("cow_explode", 78);
    function_6dcb1bbc("cow_sacred", 79);
    function_6dcb1bbc("ammo_infinite", 80);
    function_6dcb1bbc("player_shield_short", 81);
    function_6dcb1bbc("player_shield_long", 82);
    function_6dcb1bbc("incoming_impact", 83);
    function_6dcb1bbc("sparkle_silver", 84);
    function_6dcb1bbc("sparkle_gold", 85);
    function_6dcb1bbc("player_trail_green_night", 86);
    function_6dcb1bbc("player_trail_blue_night", 87);
    function_6dcb1bbc("player_trail_red_night", 88);
    function_6dcb1bbc("player_trail_yellow_night", 89);
    function_6dcb1bbc("headshot", 90);
    function_6dcb1bbc("headshot_nochunks", 91);
    function_6dcb1bbc("bloodspurt", 92);
    function_6dcb1bbc("silverback_intro", 93);
    function_6dcb1bbc("silverback_intro_explo", 94);
    function_6dcb1bbc("silverback_intro_trail1", 95);
    function_6dcb1bbc("silverback_intro_trail2", 96);
    function_6dcb1bbc("silverback_banana_explo", 97);
    function_6dcb1bbc("explo_warning_light_banana", 98);
    function_6dcb1bbc("explo_warning_light", 99);
    function_6dcb1bbc("shadow_fade", 100);
    function_6dcb1bbc("shadow_move", 101);
    function_6dcb1bbc("shadow_appear", 102);
    function_6dcb1bbc("shadow_die", 103);
    function_6dcb1bbc("shadow_glow", 104);
    function_6dcb1bbc("meatball_impact", 105);
    function_6dcb1bbc("bomb", 106);
    function_6dcb1bbc("cyber_eye", 107);
    function_6dcb1bbc("spawnZombie", 108);
    function_6dcb1bbc("reviveAdvertise", 109);
    function_6dcb1bbc("reviveActive", 110);
    function_6dcb1bbc("reviveCredit", 111);
    function_6dcb1bbc("down_marker_green", 112);
    function_6dcb1bbc("down_marker_blue", 113);
    function_6dcb1bbc("down_marker_red", 114);
    function_6dcb1bbc("down_marker_yellow", 115);
    function_6dcb1bbc("electrical_surge", 116);
    function_6dcb1bbc("blue_eyes", 117);
    function_6dcb1bbc("zombie_angry", 118);
    function_6dcb1bbc("teamShift", 120);
    function_6dcb1bbc("teamShift_contact", 119);
    function_6dcb1bbc("web_contact", 121);
}

// Namespace namespace_eaa992c
// Params 2, eflags: 0x1 linked
// Checksum 0x6bd2e76c, Offset: 0x19b0
// Size: 0x7e
function function_6dcb1bbc(name, type) {
    assert(type < -128, "<dev string:x28>");
    if (!isdefined(level.doa.var_1142e0a2)) {
        level.doa.var_1142e0a2 = [];
    }
    level.doa.var_1142e0a2[name] = type;
}

// Namespace namespace_eaa992c
// Params 1, eflags: 0x1 linked
// Checksum 0xa81030e4, Offset: 0x1a38
// Size: 0x60
function function_39dbe45b(name) {
    if (!isdefined(name)) {
        return;
    }
    assert(isdefined(level.doa.var_1142e0a2[name]), "<dev string:x3b>");
    return level.doa.var_1142e0a2[name];
}

// Namespace namespace_eaa992c
// Params 0, eflags: 0x1 linked
// Checksum 0x25708dae, Offset: 0x1aa0
// Size: 0x48
function function_81e169ac() {
    self endon(#"death");
    while (isdefined(self) && gettime() < self.var_b2ce38d9) {
        wait 0.05;
    }
    if (isdefined(self)) {
        self.var_b2ce38d9 = gettime() + -56;
    }
}

// Namespace namespace_eaa992c
// Params 0, eflags: 0x1 linked
// Checksum 0x1661d03d, Offset: 0x1af0
// Size: 0x48
function function_1f8cb1fa() {
    self endon(#"death");
    while (isdefined(self) && gettime() < self.var_78c14ec2) {
        wait 0.05;
    }
    if (isdefined(self)) {
        self.var_78c14ec2 = gettime() + -56;
    }
}

// Namespace namespace_eaa992c
// Params 4, eflags: 0x1 linked
// Checksum 0x19b2a583, Offset: 0x1b40
// Size: 0x224
function function_64bc2503(&queue, flag, waitfunc, var_a6cc22d4) {
    if (!isdefined(var_a6cc22d4)) {
        var_a6cc22d4 = 0;
    }
    self endon(#"death");
    if (!var_a6cc22d4) {
        self notify("fxProcessQueue_" + flag);
        self endon("fxProcessQueue_" + flag);
    }
    if (queue.size >= 16) {
        /#
            foreach (item in queue) {
                namespace_49107f3a::debugmsg("<dev string:x60>" + item);
            }
        #/
        assert(0, "<dev string:x6a>" + queue[15]);
    }
    self [[ waitfunc ]]();
    if (queue.size == 0 && isdefined(self)) {
        self clientfield::set(flag, 0);
        self notify(#"hash_6a404ade");
        return;
    }
    var_1b0298c0 = function_39dbe45b(queue[0]);
    arrayremoveindex(queue, 0, 0);
    if (isdefined(self) && isdefined(var_1b0298c0)) {
        self clientfield::set(flag, var_1b0298c0);
        self function_64bc2503(queue, flag, waitfunc, 1);
    }
}

// Namespace namespace_eaa992c
// Params 1, eflags: 0x1 linked
// Checksum 0x6b28502e, Offset: 0x1d70
// Size: 0x182
function turnofffx(name) {
    if (!isdefined(name) || !isdefined(self)) {
        return;
    }
    self notify(#"turnofffx");
    self endon(#"turnofffx");
    self endon(#"death");
    assert(!(isplayer(self) && name == "<dev string:x9c>"));
    assert(!(isplayer(self) && name == "<dev string:xaf>"));
    if (!isdefined(self.var_350c7e91)) {
        self.var_350c7e91 = [];
        self.var_78c14ec2 = 0;
    }
    if (isdefined(self.var_3930cdff)) {
        arrayremovevalue(self.var_3930cdff, name);
    }
    if (!isinarray(self.var_350c7e91, name)) {
        self.var_350c7e91[self.var_350c7e91.size] = name;
    }
    self function_64bc2503(self.var_350c7e91, "off_fx", &function_1f8cb1fa);
    level notify(#"off_fx_queue_processed");
}

// Namespace namespace_eaa992c
// Params 1, eflags: 0x1 linked
// Checksum 0x392b681b, Offset: 0x1f00
// Size: 0x174
function function_285a2999(name) {
    if (!isdefined(name) || !isdefined(self)) {
        return;
    }
    self notify(#"hash_285a2999");
    self endon(#"hash_285a2999");
    self endon(#"death");
    assert(!(isplayer(self) && name == "<dev string:x9c>"));
    assert(!(isplayer(self) && name == "<dev string:xaf>"));
    if (!isdefined(self.var_3930cdff)) {
        self.var_3930cdff = [];
        self.var_b2ce38d9 = 0;
    }
    if (isinarray(self.var_3930cdff, name)) {
        return;
    }
    if (isdefined(self.var_350c7e91)) {
        arrayremovevalue(self.var_350c7e91, name);
    }
    self.var_3930cdff[self.var_3930cdff.size] = name;
    self function_64bc2503(self.var_3930cdff, "play_fx", &function_81e169ac);
}

// Namespace namespace_eaa992c
// Params 6, eflags: 0x1 linked
// Checksum 0xfc64485a, Offset: 0x2080
// Size: 0x14c
function function_2fc7e62f(victim, damage, attacker, dir, smeansofdeath, weapon) {
    if (weapon == level.doa.var_f5fcdb51) {
        playfx(level._effect["impact_raygun1"], victim.origin + (0, 0, 40));
        return;
    }
    if (weapon == level.doa.var_e30c10ec) {
        playfx(level._effect["impact_raygun2"], victim.origin + (0, 0, 40));
        if (isdefined(attacker)) {
            attacker notify(#"hash_21f7a743", victim);
        }
        return;
    }
    playfx(level._effect["impact_raygun"], victim.origin + (0, 0, 40));
}

// Namespace namespace_eaa992c
// Params 6, eflags: 0x1 linked
// Checksum 0x6fdbc64a, Offset: 0x21d8
// Size: 0x74
function function_2c0f7946(victim, damage, attacker, dir, smeansofdeath, weapon) {
    playfx(level._effect["impact_rpg"], victim.origin + (0, 0, 40));
}

// Namespace namespace_eaa992c
// Params 6, eflags: 0x1 linked
// Checksum 0xdaf20933, Offset: 0x2258
// Size: 0x114
function function_f51d2b7e(victim, damage, attacker, dir, smeansofdeath, weapon) {
    if (!isdefined(level.doa.var_f6ac2080)) {
        level.doa.var_f6ac2080 = 6;
    }
    if (!isdefined(level.doa.var_b86d53a5)) {
        level.doa.var_b86d53a5 = 3;
    }
    dir = vectornormalize(dir + (0, 0, level.doa.var_b86d53a5));
    dir *= level.doa.var_f6ac2080;
    if (!(isdefined(victim.boss) && victim.boss)) {
        victim namespace_fba031c8::function_ddf685e8(dir, attacker);
    }
}

// Namespace namespace_eaa992c
// Params 6, eflags: 0x1 linked
// Checksum 0x84cc112a, Offset: 0x2378
// Size: 0x5c
function function_4f66d2fb(victim, damage, attacker, dir, smeansofdeath, weapon) {
    function_2aa1c0b3(victim, damage, attacker, dir, smeansofdeath, weapon);
}

// Namespace namespace_eaa992c
// Params 6, eflags: 0x1 linked
// Checksum 0x857bd290, Offset: 0x23e0
// Size: 0x274
function function_2aa1c0b3(victim, damage, attacker, dir, smeansofdeath, weapon) {
    if (isdefined(victim.boss) && victim.boss) {
        return;
    }
    if (isdefined(victim.burning) && victim.burning) {
        return;
    }
    if (isdefined(victim.var_52b0b328) && victim.var_52b0b328) {
        return;
    }
    if (issubstr(weapon.name, "_1")) {
        victim clientfield::set("burnType", 2);
        victim.burnType = 2;
    } else if (issubstr(weapon.name, "_2")) {
        victim clientfield::set("burnType", 3);
        victim.burnType = 3;
    } else {
        victim clientfield::set("burnType", 1);
        victim.burnType = 1;
    }
    victim.burning = 1;
    wait 0.05;
    if (isdefined(victim) && isactor(victim)) {
        victim thread function_32bcda58(victim.burnType, attacker);
        victim clientfield::increment("burnZombie");
        victim thread function_9fc6e261(victim.burnType);
        if (!isdefined(victim.var_dd70dacd)) {
            victim asmsetanimationrate(0.75);
        }
    }
}

// Namespace namespace_eaa992c
// Params 2, eflags: 0x1 linked
// Checksum 0x993d9b9c, Offset: 0x2660
// Size: 0x150
function function_32bcda58(burnType, attacker) {
    self notify(#"hash_e32770a3");
    self endon(#"hash_e32770a3");
    self endon(#"death");
    dmg = getdvarint("scr_doa_dot_burn_dmg", 120) * burnType;
    if (!isdefined(self.var_a27665f9)) {
        self.var_a27665f9 = 0;
    }
    var_1b22f058 = getdvarint("scr_doa_dot_max_inc", 3);
    while (isalive(self)) {
        self dodamage(dmg, self.origin, attacker);
        wait 0.3;
        if (var_1b22f058 > 0 && self.var_a27665f9 % getdvarint("scr_doa_dot_burn_fx_rate", 30) == 0) {
            var_1b22f058--;
            self clientfield::increment("burnZombie");
        }
        self.var_a27665f9++;
    }
}

// Namespace namespace_eaa992c
// Params 1, eflags: 0x5 linked
// Checksum 0xeb847d5d, Offset: 0x27b8
// Size: 0xc4
function private function_9fc6e261(type) {
    corpse = self waittill(#"actor_corpse");
    wait 0.05;
    if (isdefined(corpse)) {
        corpse clientfield::set("burnType", type);
        wait 0.05;
        if (isdefined(corpse)) {
            corpse clientfield::increment("burnCorpse");
            if (randomint(100) < 50) {
                corpse clientfield::set("enemy_ragdoll_explode", 1);
            }
        }
    }
}

