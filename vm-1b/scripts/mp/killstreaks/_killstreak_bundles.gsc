#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/clientfield_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace killstreak_bundles;

// Namespace killstreak_bundles
// Params 1, eflags: 0x0
// Checksum 0xf900c09a, Offset: 0x370
// Size: 0x7a
function register_killstreak_bundle(killstreaktype) {
    level.killstreakbundle[killstreaktype] = struct::get_script_bundle("killstreak", "killstreak_" + killstreaktype);
    level.killstreakbundle["inventory_" + killstreaktype] = level.killstreakbundle[killstreaktype];
    level.killstreakmaxhealthfunction = &get_max_health;
    assert(isdefined(level.killstreakbundle[killstreaktype]));
}

// Namespace killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xdbdc7b49, Offset: 0x3f8
// Size: 0x35
function get_hack_timeout() {
    killstreak = self;
    bundle = level.killstreakbundle[killstreak.killstreaktype];
    return bundle.kshacktimeout;
}

// Namespace killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x27b852bf, Offset: 0x438
// Size: 0x52
function get_hack_protection() {
    killstreak = self;
    var_dab0490c = 0;
    bundle = level.killstreakbundle[killstreak.killstreaktype];
    if (isdefined(bundle.kshackprotection)) {
        var_dab0490c = bundle.kshackprotection;
    }
    return var_dab0490c;
}

// Namespace killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x13ba9de5, Offset: 0x498
// Size: 0x52
function get_hack_tool_inner_time() {
    killstreak = self;
    var_efb67d7 = 10000;
    bundle = level.killstreakbundle[killstreak.killstreaktype];
    if (isdefined(bundle.kshacktoolinnertime)) {
        var_efb67d7 = bundle.kshacktoolinnertime;
    }
    return var_efb67d7;
}

// Namespace killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xb9c6765f, Offset: 0x4f8
// Size: 0x52
function get_hack_tool_outer_time() {
    killstreak = self;
    var_b20e47c2 = 10000;
    bundle = level.killstreakbundle[killstreak.killstreaktype];
    if (isdefined(bundle.kshacktooloutertime)) {
        var_b20e47c2 = bundle.kshacktooloutertime;
    }
    return var_b20e47c2;
}

// Namespace killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xe446b94d, Offset: 0x558
// Size: 0x52
function get_hack_tool_inner_radius() {
    killstreak = self;
    var_6806d767 = 10000;
    bundle = level.killstreakbundle[killstreak.killstreaktype];
    if (isdefined(bundle.kshacktoolinnerradius)) {
        var_6806d767 = bundle.kshacktoolinnerradius;
    }
    return var_6806d767;
}

// Namespace killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xbbfbab73, Offset: 0x5b8
// Size: 0x52
function get_hack_tool_outer_radius() {
    killstreak = self;
    var_1f2ed796 = 10000;
    bundle = level.killstreakbundle[killstreak.killstreaktype];
    if (isdefined(bundle.kshacktoolouterradius)) {
        var_1f2ed796 = bundle.kshacktoolouterradius;
    }
    return var_1f2ed796;
}

// Namespace killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xd112f996, Offset: 0x618
// Size: 0x52
function get_lost_line_of_sight_limit_msec() {
    killstreak = self;
    var_4c5b76f0 = 1000;
    bundle = level.killstreakbundle[killstreak.killstreaktype];
    if (isdefined(bundle.kshacktoollostlineofsightlimitms)) {
        var_4c5b76f0 = bundle.kshacktoollostlineofsightlimitms;
    }
    return var_4c5b76f0;
}

// Namespace killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x1c344922, Offset: 0x678
// Size: 0x52
function get_hack_tool_no_line_of_sight_time() {
    killstreak = self;
    var_b980bbec = 1000;
    bundle = level.killstreakbundle[killstreak.killstreaktype];
    if (isdefined(bundle.kshacktoolnolineofsighttime)) {
        var_b980bbec = bundle.kshacktoolnolineofsighttime;
    }
    return var_b980bbec;
}

// Namespace killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xe419a473, Offset: 0x6d8
// Size: 0x52
function get_hack_scoreevent() {
    killstreak = self;
    var_fc4a6b77 = undefined;
    bundle = level.killstreakbundle[killstreak.killstreaktype];
    if (isdefined(bundle.kshackscoreevent)) {
        var_fc4a6b77 = bundle.kshackscoreevent;
    }
    return var_fc4a6b77;
}

// Namespace killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0x70575509, Offset: 0x738
// Size: 0x56
function get_hack_fx() {
    killstreak = self;
    var_9aff8f34 = "";
    bundle = level.killstreakbundle[killstreak.killstreaktype];
    if (isdefined(bundle.kshackfx)) {
        var_9aff8f34 = bundle.kshackfx;
    }
    return var_9aff8f34;
}

// Namespace killstreak_bundles
// Params 0, eflags: 0x0
// Checksum 0xd7a8419d, Offset: 0x798
// Size: 0x56
function get_hack_loop_fx() {
    killstreak = self;
    var_369f739a = "";
    bundle = level.killstreakbundle[killstreak.killstreaktype];
    if (isdefined(bundle.kshackloopfx)) {
        var_369f739a = bundle.kshackloopfx;
    }
    return var_369f739a;
}

// Namespace killstreak_bundles
// Params 1, eflags: 0x0
// Checksum 0x2da1f69b, Offset: 0x7f8
// Size: 0x25
function get_max_health(killstreaktype) {
    bundle = level.killstreakbundle[killstreaktype];
    return bundle.kshealth;
}

// Namespace killstreak_bundles
// Params 1, eflags: 0x0
// Checksum 0xbb6a4f64, Offset: 0x828
// Size: 0x25
function get_low_health(killstreaktype) {
    bundle = level.killstreakbundle[killstreaktype];
    return bundle.kslowhealth;
}

// Namespace killstreak_bundles
// Params 1, eflags: 0x0
// Checksum 0x50a70a4b, Offset: 0x858
// Size: 0x25
function get_hacked_health(killstreaktype) {
    bundle = level.killstreakbundle[killstreaktype];
    return bundle.kshackedhealth;
}

// Namespace killstreak_bundles
// Params 3, eflags: 0x0
// Checksum 0x9cd4737d, Offset: 0x888
// Size: 0x1ae
function get_shots_to_kill(weapon, meansofdeath, bundle) {
    shotstokill = undefined;
    switch (weapon.rootweapon.name) {
    case "remote_missile_missile":
        shotstokill = bundle.ksremote_missile_missile;
        break;
    case "hero_annihilator":
        shotstokill = bundle.kshero_annihilator;
        break;
    case "hero_armblade":
        shotstokill = bundle.kshero_armblade;
        break;
    case "hero_bowlauncher":
    case "hero_bowlauncher2":
    case "hero_bowlauncher3":
    case "hero_bowlauncher4":
        if (meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_PROJECTILE") {
            shotstokill = bundle.kshero_bowlauncher;
        } else {
            shotstokill = -1;
        }
        break;
    case "hero_gravityspikes":
        shotstokill = bundle.kshero_gravityspikes;
        break;
    case "hero_lightninggun":
        shotstokill = bundle.kshero_lightninggun;
        break;
    case "hero_minigun":
        shotstokill = bundle.kshero_minigun;
        break;
    case "hero_pineapplegun":
        shotstokill = bundle.kshero_pineapplegun;
        break;
    case "hero_firefly_swarm":
        shotstokill = (isdefined(bundle.kshero_firefly_swarm) ? bundle.kshero_firefly_swarm : 0) * 4;
        break;
    case "dart_blade":
    case "dart_turret":
        shotstokill = bundle.ksdartstokill;
        break;
    case "gadget_heat_wave":
        shotstokill = bundle.kshero_heatwave;
        break;
    }
    return isdefined(shotstokill) ? shotstokill : 0;
}

// Namespace killstreak_bundles
// Params 2, eflags: 0x0
// Checksum 0x4c5a3a0d, Offset: 0xa40
// Size: 0x8d
function get_emp_grenade_damage(killstreaktype, maxhealth) {
    emp_weapon_damage = undefined;
    if (isdefined(level.killstreakbundle[killstreaktype])) {
        bundle = level.killstreakbundle[killstreaktype];
        empgrenadestokill = isdefined(bundle.ksempgrenadestokill) ? bundle.ksempgrenadestokill : 0;
        if (empgrenadestokill == 0) {
        } else if (empgrenadestokill > 0) {
            emp_weapon_damage = maxhealth / empgrenadestokill + 1;
        } else {
            emp_weapon_damage = 0;
        }
    }
    return emp_weapon_damage;
}

// Namespace killstreak_bundles
// Params 8, eflags: 0x0
// Checksum 0x413a70d5, Offset: 0xad8
// Size: 0x397
function get_weapon_damage(killstreaktype, maxhealth, attacker, weapon, type, damage, flags, chargeshotlevel) {
    weapon_damage = undefined;
    if (isdefined(level.killstreakbundle[killstreaktype])) {
        bundle = level.killstreakbundle[killstreaktype];
        if (isdefined(weapon)) {
            shotstokill = get_shots_to_kill(weapon, type, bundle);
            if (shotstokill == 0) {
            } else if (shotstokill > 0) {
                if (isdefined(chargeshotlevel) && chargeshotlevel > 0) {
                    shotstokill /= chargeshotlevel;
                }
                weapon_damage = maxhealth / shotstokill + 1;
            } else {
                weapon_damage = 0;
            }
        }
        if (!isdefined(weapon_damage)) {
            if (type == "MOD_RIFLE_BULLET" || type == "MOD_PISTOL_BULLET" || type == "MOD_HEAD_SHOT") {
                hasfmj = isdefined(attacker) && isplayer(attacker) && attacker hasperk("specialty_armorpiercing");
                if (hasfmj) {
                    clipstokill = isdefined(bundle.var_c3fc890e) ? bundle.var_c3fc890e : 0;
                } else {
                    clipstokill = isdefined(bundle.ksclipstokill) ? bundle.ksclipstokill : 0;
                }
                if (clipstokill == 0) {
                } else if (clipstokill > 0) {
                    clipsize = 10;
                    if (isdefined(weapon)) {
                        clipsize = weapon.rootweapon.clipsize;
                    }
                    weapon_damage = maxhealth / clipsize / clipstokill + 1;
                } else {
                    weapon_damage = 0;
                }
                if (weapon.weapclass == "spread") {
                    ksshotgunmultiplier = isdefined(bundle.ksshotgunmultiplier) ? bundle.ksshotgunmultiplier : 1;
                    if (ksshotgunmultiplier == 0) {
                    } else if (ksshotgunmultiplier > 0) {
                        weapon_damage = damage * ksshotgunmultiplier;
                    }
                }
            } else if (!isdefined(weapon.isempkillstreak) || (type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_EXPLOSIVE") && !weapon.isempkillstreak) {
                rocketstokill = isdefined(bundle.ksrocketstokill) ? bundle.ksrocketstokill : 0;
                if (rocketstokill == 0) {
                } else if (rocketstokill > 0) {
                    weapon_damage = maxhealth / rocketstokill + 1;
                } else {
                    weapon_damage = 0;
                }
            } else if (!isdefined(weapon.isempkillstreak) || (type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH") && !weapon.isempkillstreak) {
                grenadedamagemultiplier = isdefined(bundle.ksgrenadedamagemultiplier) ? bundle.ksgrenadedamagemultiplier : 0;
                if (grenadedamagemultiplier == 0) {
                } else if (grenadedamagemultiplier > 0) {
                    weapon_damage = damage * grenadedamagemultiplier;
                } else {
                    weapon_damage = 0;
                }
            } else if (type == "MOD_MELEE_WEAPON_BUTT" || type == "MOD_MELEE") {
                ksmeleedamagemultiplier = isdefined(bundle.ksmeleedamagemultiplier) ? bundle.ksmeleedamagemultiplier : 0;
                if (ksmeleedamagemultiplier == 0) {
                } else if (ksmeleedamagemultiplier > 0) {
                    weapon_damage = damage * ksmeleedamagemultiplier;
                } else {
                    weapon_damage = 0;
                }
            }
        }
    }
    return weapon_damage;
}

