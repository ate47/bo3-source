#using scripts/shared/ai_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_weap_elemental_bow;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_util;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/codescripts/struct;

#namespace namespace_efd1ef23;

// Namespace namespace_efd1ef23
// Params 0, eflags: 0x2
// Checksum 0x4f5f348b, Offset: 0x5a0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("_zm_weap_elemental_bow_demongate", &__init__, &__main__, undefined);
}

// Namespace namespace_efd1ef23
// Params 0, eflags: 0x0
// Checksum 0x4c9c1d0a, Offset: 0x5e8
// Size: 0x21c
function __init__() {
    level.var_edf1e590 = getweapon("elemental_bow_demongate");
    level.var_e106fba5 = getweapon("elemental_bow_demongate4");
    level.var_ecd0c077 = [];
    clientfield::register("toplayer", "elemental_bow_demongate" + "_ambient_bow_fx", 5000, 1, "int");
    clientfield::register("missile", "elemental_bow_demongate" + "_arrow_impact_fx", 5000, 1, "int");
    clientfield::register("missile", "elemental_bow_demongate4" + "_arrow_impact_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "demongate_portal_fx", 5000, 1, "int");
    clientfield::register("toplayer", "demongate_portal_rumble", 1, 1, "int");
    clientfield::register("scriptmover", "demongate_wander_locomotion_anim", 5000, 1, "int");
    clientfield::register("scriptmover", "demongate_attack_locomotion_anim", 5000, 1, "int");
    clientfield::register("scriptmover", "demongate_chomper_fx", 5000, 1, "int");
    clientfield::register("scriptmover", "demongate_chomper_bite_fx", 5000, 1, "counter");
}

// Namespace namespace_efd1ef23
// Params 0, eflags: 0x0
// Checksum 0xc5337f97, Offset: 0x810
// Size: 0x24
function __main__() {
    callback::on_connect(&function_71c07c9d);
}

// Namespace namespace_efd1ef23
// Params 0, eflags: 0x0
// Checksum 0x215a5e0c, Offset: 0x840
// Size: 0x7c
function function_71c07c9d() {
    self thread namespace_790026d5::function_982419bb("elemental_bow_demongate");
    self thread namespace_790026d5::function_ececa597("elemental_bow_demongate", "elemental_bow_demongate4");
    self thread namespace_790026d5::function_7bc6b9d("elemental_bow_demongate", "elemental_bow_demongate4", &function_7e0efd7);
}

// Namespace namespace_efd1ef23
// Params 5, eflags: 0x0
// Checksum 0x265b0d8, Offset: 0x8c8
// Size: 0xbc
function function_7e0efd7(weapon, position, radius, attacker, normal) {
    if (weapon.name == "elemental_bow_demongate4") {
        self thread function_19575106(weapon, position, attacker, normal);
        return;
    }
    attacker clientfield::set("elemental_bow_demongate" + "_arrow_impact_fx", 1);
    self thread function_ee626351(position, attacker);
}

// Namespace namespace_efd1ef23
// Params 2, eflags: 0x0
// Checksum 0x1328b127, Offset: 0x990
// Size: 0x16c
function function_95ad1040(var_be00572f, var_c211b5bb) {
    if (abs(var_c211b5bb[2]) < 0.2) {
        var_be00572f += var_c211b5bb * 16;
        a_trace = bullettrace(var_be00572f, var_be00572f + (0, 0, 64), 0, undefined);
        if (a_trace["fraction"] < 1) {
            var_be00572f = a_trace["position"] - (0, 0, 64);
        }
        a_trace = bullettrace(var_be00572f, var_be00572f - (0, 0, 64), 0, undefined);
        if (a_trace["fraction"] < 1) {
            var_be00572f = a_trace["position"] + (0, 0, 64);
        }
    } else {
        var_85a9344d = var_c211b5bb[2] * 64;
        var_be00572f += (0, 0, var_85a9344d);
    }
    return var_be00572f;
}

// Namespace namespace_efd1ef23
// Params 4, eflags: 0x0
// Checksum 0x75a0aa85, Offset: 0xb08
// Size: 0x3c4
function function_19575106(weapon, position, attacker, normal) {
    position = function_95ad1040(position, normal);
    var_884470ed = vectortoangles(normal);
    var_884470ed += (0, 90, 0);
    var_884470ed *= (0, 1, 0);
    var_e1784c2b = util::spawn_model("tag_origin", position, var_884470ed);
    var_e1784c2b clientfield::set("demongate_portal_fx", 1);
    var_e1784c2b.var_a5e3922a = 1;
    radiusdamage(position, 96, level.zombie_health, level.zombie_health, self, "MOD_UNKNOWN", level.var_e106fba5);
    wait(0.25);
    var_e1784c2b thread function_292e5297();
    if (getdvarint("splitscreen_playerCount") > 2) {
        var_76d7100b = 4 * level.zombie_health;
    } else {
        var_76d7100b = 2 * level.zombie_health;
    }
    if (level.var_ecd0c077.size > 12) {
        var_33efb6fa = 2;
    } else {
        var_33efb6fa = int((zombie_utility::get_current_zombie_count() + level.zombie_total) * level.zombie_health / var_76d7100b);
        if (getdvarint("splitscreen_playerCount") > 2) {
            var_33efb6fa = math::clamp(var_33efb6fa, 4, 4);
        } else {
            var_33efb6fa = math::clamp(var_33efb6fa, 4, 6);
        }
    }
    var_c93049d7 = 0;
    for (i = 0; i < var_33efb6fa; i++) {
        var_963441bd[i] = function_a9eddc64(position, var_884470ed - (0, 90, 0), i);
        var_963441bd[i] thread function_a3e439a5(self, position);
        n_wait_time = 0.1;
        var_c93049d7 += n_wait_time;
        wait(n_wait_time);
    }
    if (var_c93049d7 < 2) {
        wait(2 - var_c93049d7);
    }
    wait(2.5);
    var_e1784c2b clientfield::set("demongate_portal_fx", 0);
    wait(2);
    var_e1784c2b notify(#"hash_d6e52217");
    var_e1784c2b.var_a5e3922a = 0;
    wait(1.6);
    var_e1784c2b delete();
}

// Namespace namespace_efd1ef23
// Params 0, eflags: 0x0
// Checksum 0x1eadfa4c, Offset: 0xed8
// Size: 0x110
function function_292e5297() {
    self endon(#"hash_d6e52217");
    while (true) {
        foreach (e_player in level.activeplayers) {
            if (isdefined(e_player) && !(isdefined(e_player.var_fbdab725) && e_player.var_fbdab725)) {
                if (distancesquared(e_player.origin, self.origin) < 9216) {
                    e_player thread function_3f55c7ab(self);
                }
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_efd1ef23
// Params 1, eflags: 0x0
// Checksum 0xb6e29c02, Offset: 0xff0
// Size: 0xe4
function function_3f55c7ab(var_e1784c2b) {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self.var_fbdab725 = 1;
    self clientfield::set_to_player("demongate_portal_rumble", 1);
    while (isdefined(var_e1784c2b.var_a5e3922a) && distancesquared(self.origin, var_e1784c2b.origin) < 9216 && var_e1784c2b.var_a5e3922a) {
        wait(0.05);
    }
    self.var_fbdab725 = 0;
    self clientfield::set_to_player("demongate_portal_rumble", 0);
}

// Namespace namespace_efd1ef23
// Params 2, eflags: 0x0
// Checksum 0x1f897bff, Offset: 0x10e0
// Size: 0x94
function function_ee626351(position, attacker) {
    v_angles = anglestoforward(attacker.angles) * -1;
    var_7119a95d = function_a9eddc64(position, v_angles);
    wait(0.1);
    var_7119a95d thread function_ab77890b(self);
}

// Namespace namespace_efd1ef23
// Params 3, eflags: 0x0
// Checksum 0xbeda3c73, Offset: 0x1180
// Size: 0x2e6
function function_a9eddc64(position, v_angles, n_count) {
    if (!isdefined(n_count)) {
        n_count = 1;
    }
    var_7119a95d = util::spawn_model("c_zom_chomper", position, v_angles);
    var_7119a95d clientfield::set("demongate_chomper_fx", 1);
    var_7119a95d flag::init("chomper_attacking");
    var_7119a95d flag::init("demongate_chomper_despawning");
    if (getdvarint("splitscreen_playerCount") > 2) {
        var_76d7100b = 4 * level.zombie_health;
    } else {
        var_76d7100b = 2 * level.zombie_health;
    }
    var_7119a95d.var_fcd07456 = var_76d7100b;
    var_7119a95d.var_603f1f19 = 1;
    var_7119a95d thread function_1d3c583d();
    var_b194ff34 = 0;
    var_5f2cce52 = level.var_ecd0c077.size - 12;
    if (var_5f2cce52 > 0) {
        foreach (var_c7cc4fbd in level.var_ecd0c077) {
            if (!var_c7cc4fbd flag::get("chomper_attacking") && !(isdefined(var_c7cc4fbd.var_e3146903) && var_c7cc4fbd.var_e3146903)) {
                var_c7cc4fbd.n_timer = 3;
                var_b194ff34++;
                if (var_b194ff34 > var_5f2cce52) {
                    break;
                }
            }
        }
    }
    if (!isdefined(level.var_ecd0c077)) {
        level.var_ecd0c077 = [];
    } else if (!isarray(level.var_ecd0c077)) {
        level.var_ecd0c077 = array(level.var_ecd0c077);
    }
    level.var_ecd0c077[level.var_ecd0c077.size] = var_7119a95d;
    return var_7119a95d;
}

// Namespace namespace_efd1ef23
// Params 0, eflags: 0x0
// Checksum 0x76ed9161, Offset: 0x1470
// Size: 0x194
function function_308e6c6f() {
    self flag::set("demongate_chomper_despawning");
    if (!(isdefined(self.var_dd49270d) && self.var_dd49270d)) {
        self.var_dd49270d = 1;
        if (!isdefined(level.var_a9ac7b97)) {
            level.var_a9ac7b97 = gettime();
        } else if (level.var_a9ac7b97 == gettime()) {
            wait(randomfloatrange(0.1, 0.2));
        }
        level.var_a9ac7b97 = gettime();
        self moveto(self.origin + (0, 0, 96), 1.4);
        self rotatepitch(-90, 0.4);
        wait(1.4);
        self moveto(self.origin, 0.1);
        self clientfield::set("demongate_chomper_fx", 0);
        wait(3);
        self notify(#"hash_16664ab4");
        level.var_ecd0c077 = array::exclude(level.var_ecd0c077, self);
        self delete();
    }
}

// Namespace namespace_efd1ef23
// Params 0, eflags: 0x0
// Checksum 0x2752d0b1, Offset: 0x1610
// Size: 0xd4
function function_1d3c583d() {
    self endon(#"hash_72391651");
    self.n_timer = 0;
    while (self.n_timer < 3) {
        if (!self flag::get("chomper_attacking") && !(isdefined(self.var_e3146903) && self.var_e3146903)) {
            self.n_timer += 0.05;
        }
        wait(0.05);
    }
    while (self flag::get("chomper_attacking")) {
        wait(0.1);
    }
    self thread function_308e6c6f();
}

// Namespace namespace_efd1ef23
// Params 2, eflags: 0x0
// Checksum 0x6cdc63a6, Offset: 0x16f0
// Size: 0x17c
function function_a3e439a5(e_player, var_67eb721b) {
    self.var_e3146903 = 1;
    self.origin += (0, 0, randomintrange(int(-51.2), int(51.2)));
    self.angles = (self.angles[0] + randomintrange(-30, 30), self.angles[1] + randomintrange(-45, 45), self.angles[2]);
    var_69a783ad = self.origin + anglestoforward(self.angles) * 96;
    self.angles = (0, self.angles[1], 0);
    self moveto(var_69a783ad, 0.4);
    wait(0.4);
    self.var_e3146903 = 0;
    self function_ab77890b(e_player);
}

// Namespace namespace_efd1ef23
// Params 1, eflags: 0x0
// Checksum 0xe7335538, Offset: 0x1878
// Size: 0x6c
function function_ab77890b(e_player) {
    self function_99d2c8aa(e_player);
    if (isdefined(self.target_enemy)) {
        self function_b6e7ec91(e_player);
        return;
    }
    self thread function_9fcea3e8(e_player);
}

// Namespace namespace_efd1ef23
// Params 1, eflags: 0x0
// Checksum 0xf57a9e45, Offset: 0x18f0
// Size: 0x4d4
function function_9fcea3e8(e_player) {
    self endon(#"hash_72391651");
    self endon(#"death");
    if (!isdefined(self)) {
        return;
    }
    if (self flag::get("demongate_chomper_despawning")) {
        return;
    }
    self flag::clear("chomper_attacking");
    self clientfield::set("demongate_wander_locomotion_anim", 1);
    var_13fe538c = randomfloatrange(5, 15);
    var_3a00cdf5 = randomfloatrange(15, 45);
    var_6003485e = randomfloatrange(15, 45);
    var_13fe538c = randomint(100) < 50 ? var_13fe538c : var_13fe538c * -1;
    var_3a00cdf5 = randomint(100) < 50 ? var_3a00cdf5 : var_3a00cdf5 * -1;
    var_6003485e = randomint(100) < 50 ? var_6003485e : var_6003485e * -1;
    if (zm_utility::is_player_valid(e_player)) {
        var_6073ac1c = e_player.angles;
        var_150aaea = e_player geteye();
    } else {
        var_6073ac1c = self.angles;
        var_150aaea = self.origin;
    }
    var_9ef67615 = (var_6073ac1c[0] + var_13fe538c, var_6073ac1c[1] + var_3a00cdf5, var_6073ac1c[2] + var_6003485e);
    var_962558f1 = vectornormalize(anglestoforward(var_9ef67615));
    a_trace = physicstraceex(var_150aaea, var_150aaea + var_962558f1 * 512, (-16, -16, -16), (16, 16, 16));
    var_69a783ad = a_trace["position"] + var_962558f1 * -32;
    n_dist = distance(self.origin, var_69a783ad);
    n_time = n_dist / 48;
    v_rotate = var_69a783ad - self.origin;
    v_rotate = (0, v_rotate[1], 0);
    if (!isdefined(level.var_a9ac7b97)) {
        level.var_a9ac7b97 = gettime();
    } else if (level.var_a9ac7b97 == gettime()) {
        wait(randomfloatrange(0.1, 0.2));
    }
    level.var_a9ac7b97 = gettime();
    self moveto(var_69a783ad, n_time);
    self rotateto(vectortoangles(v_rotate), n_time * 0.5);
    self thread function_f9dd2ee2(e_player);
    self util::waittill_any_timeout(n_time * 2, "movedone", "demongate_chomper_found_target", "demongate_chomper_despawning", "death");
    if (isdefined(self.target_enemy)) {
        self clientfield::set("demongate_wander_locomotion_anim", 0);
        self function_b6e7ec91(e_player);
        return;
    }
    self thread function_9fcea3e8(e_player);
}

// Namespace namespace_efd1ef23
// Params 1, eflags: 0x0
// Checksum 0x26065a57, Offset: 0x1dd0
// Size: 0x70
function function_f9dd2ee2(e_player) {
    self endon(#"hash_72391651");
    self endon(#"hash_7b23407");
    self endon(#"movedone");
    self endon(#"death");
    while (!isdefined(self.target_enemy)) {
        wait(0.2);
        self thread function_99d2c8aa(e_player);
    }
}

// Namespace namespace_efd1ef23
// Params 1, eflags: 0x0
// Checksum 0xe3e2a7af, Offset: 0x1e48
// Size: 0x2cc
function function_b6e7ec91(e_player) {
    var_c32fcb8f = self.target_enemy.health;
    self function_5dee133f();
    if (namespace_790026d5::function_5aec3adc(self.target_enemy)) {
        var_aad66aa4 = randomintrange(1, 7);
        var_7364b0dd = self.target_enemy.missinglegs;
        self.target_enemy.var_98056717 = 1;
        self.var_603f1f19 = 0;
        self.var_fcd07456 -= var_c32fcb8f;
        self thread function_3c03253d(var_aad66aa4, var_7364b0dd);
        self thread function_3a5a56c7();
        self thread function_67903a83(e_player);
        if (isdefined(self.target_enemy.isdog) && self.target_enemy.isdog || isvehicle(self.target_enemy)) {
            n_wait_time = 0.8;
        } else if (self.target_enemy.archetype === "mechz") {
            n_wait_time = 2.6;
            self.var_fcd07456 = 0;
        } else {
            n_wait_time = randomfloatrange(2, 3);
            self.target_enemy setplayercollision(0);
        }
        self.target_enemy util::waittill_notify_or_timeout("death", n_wait_time);
        self notify(#"hash_368634cd");
        self function_43415734(var_aad66aa4, var_7364b0dd);
        if (self.var_fcd07456 < 1) {
            self thread function_308e6c6f();
            return;
        }
    } else if (isdefined(self.target_enemy)) {
        self.target_enemy.var_bc9b5fbd = 0;
    }
    self flag::clear("chomper_attacking");
    self thread function_ab77890b(e_player);
}

// Namespace namespace_efd1ef23
// Params 0, eflags: 0x0
// Checksum 0x796cfb4a, Offset: 0x2120
// Size: 0xb0
function function_3a5a56c7() {
    self endon(#"death");
    self endon(#"hash_368634cd");
    if (self.target_enemy.archetype === "mechz") {
        while (true) {
            self clientfield::increment("demongate_chomper_bite_fx", 1);
            wait(1);
        }
        return;
    }
    while (true) {
        self waittill(#"hash_48e4a902");
        self clientfield::increment("demongate_chomper_bite_fx", 1);
    }
}

// Namespace namespace_efd1ef23
// Params 2, eflags: 0x0
// Checksum 0x1c1d96a4, Offset: 0x21d8
// Size: 0x1a4
function function_3c03253d(var_aad66aa4, var_7364b0dd) {
    self.target_enemy endon(#"death");
    if (isdefined(self.target_enemy.isdog) && self.target_enemy.isdog) {
        self.target_enemy ai::set_ignoreall(1);
        return;
    }
    if (self.target_enemy.archetype === "mechz") {
        self thread function_c5e710f7();
        return;
    }
    if (isvehicle(self.target_enemy)) {
        self.target_enemy.ignoreall = 1;
        return;
    }
    if (isdefined(var_7364b0dd) && var_7364b0dd) {
        self.target_enemy scene::play("ai_zm_dlc1_zombie_demongate_chomper_attack_crawler", array(self.target_enemy, self));
        return;
    }
    self.target_enemy scene::init("ai_zm_dlc1_zombie_demongate_chomper_attack_0" + var_aad66aa4, array(self.target_enemy, self));
    self.target_enemy scene::play("ai_zm_dlc1_zombie_demongate_chomper_attack_0" + var_aad66aa4, array(self.target_enemy, self));
}

// Namespace namespace_efd1ef23
// Params 0, eflags: 0x0
// Checksum 0x53a05bd1, Offset: 0x2388
// Size: 0x110
function function_c5e710f7() {
    var_f1d8a1fc = self.target_enemy;
    self endon(#"death");
    self endon(#"hash_368634cd");
    var_f1d8a1fc endon(#"death");
    while (true) {
        var_e388672 = isdefined(var_f1d8a1fc.var_aba6456b) && var_f1d8a1fc.var_aba6456b ? 6 : 1;
        var_85b50675 = anglestoforward(self.target_enemy.angles) * var_e388672;
        self.origin = self.target_enemy gettagorigin("j_faceplate") + var_85b50675;
        self.angles = vectortoangles(var_85b50675 * -1);
        wait(0.05);
    }
}

// Namespace namespace_efd1ef23
// Params 2, eflags: 0x0
// Checksum 0x4a8273ed, Offset: 0x24a0
// Size: 0x13c
function function_43415734(var_aad66aa4, var_7364b0dd) {
    if (isdefined(self.target_enemy) && self.target_enemy.archetype === "mechz") {
        self.target_enemy thread function_aa5b14d0();
        return;
    }
    if (isdefined(self.target_enemy) && !(isdefined(self.target_enemy.isdog) && self.target_enemy.isdog)) {
        if (isdefined(var_7364b0dd) && var_7364b0dd) {
            self.target_enemy thread scene::stop("ai_zm_dlc1_zombie_demongate_chomper_attack_crawler");
        } else {
            self.target_enemy thread scene::stop("ai_zm_dlc1_zombie_demongate_chomper_attack_0" + var_aad66aa4);
        }
    }
    if (isdefined(var_7364b0dd) && var_7364b0dd) {
        self thread scene::stop("ai_zm_dlc1_zombie_demongate_chomper_attack_crawler");
        return;
    }
    self thread scene::stop("ai_zm_dlc1_zombie_demongate_chomper_attack_0" + var_aad66aa4);
}

// Namespace namespace_efd1ef23
// Params 0, eflags: 0x0
// Checksum 0xece8c5d3, Offset: 0x25e8
// Size: 0x2c
function function_aa5b14d0() {
    self endon(#"death");
    self.var_d3c478a0 = 1;
    wait(16);
    self.var_d3c478a0 = 0;
}

// Namespace namespace_efd1ef23
// Params 0, eflags: 0x0
// Checksum 0x48c081cd, Offset: 0x2620
// Size: 0x394
function function_5dee133f() {
    self flag::set("chomper_attacking");
    var_b710c4e5 = self.target_enemy geteye();
    n_dist = distance(self.origin, var_b710c4e5);
    var_e5e24312 = 1;
    var_4e26e12a = math::cointoss() ? 1 : -1;
    self clientfield::set("demongate_attack_locomotion_anim", 1);
    while (n_dist > 32 && isdefined(self.target_enemy) && isalive(self.target_enemy)) {
        var_b710c4e5 = self.target_enemy geteye();
        n_time = n_dist / 640;
        var_5d76b65c = 1 / var_e5e24312;
        var_ef096040 = (0, 0, 160) * var_5d76b65c;
        var_c5a0d28e = anglestoright(vectortoangles(var_b710c4e5 - self.origin)) * 256;
        var_c5a0d28e *= var_5d76b65c;
        var_c5a0d28e *= var_4e26e12a;
        var_74490e48 = var_b710c4e5 + var_c5a0d28e + var_ef096040;
        v_rotate = var_74490e48 - self.origin;
        v_rotate = (0, v_rotate[1], 0);
        if (!isdefined(level.var_a9ac7b97)) {
            level.var_a9ac7b97 = gettime();
        } else if (level.var_a9ac7b97 == gettime()) {
            wait(randomfloatrange(0.1, 0.2));
        }
        level.var_a9ac7b97 = gettime();
        self moveto(var_74490e48, n_time);
        self rotateto(vectortoangles(v_rotate), n_time * 0.5);
        n_time *= 0.3;
        n_time = n_time < 0.1 ? 0.1 : n_time;
        wait(n_time);
        var_e5e24312++;
        n_dist = distance(self.origin, var_b710c4e5);
    }
    self clientfield::set("demongate_attack_locomotion_anim", 0);
    if (isdefined(self.target_enemy) && isalive(self.target_enemy)) {
        self.origin = var_b710c4e5;
    }
}

// Namespace namespace_efd1ef23
// Params 1, eflags: 0x0
// Checksum 0x5eca0a60, Offset: 0x29c0
// Size: 0x154
function function_67903a83(e_player) {
    e_target = self.target_enemy;
    e_target endon(#"death");
    if (e_target.archetype === "mechz") {
        self thread function_3f57ba41(e_player);
        return;
    }
    n_damage = e_target.health;
    self waittill(#"hash_368634cd");
    e_target setplayercollision(1);
    e_target.var_bc9b5fbd = 0;
    e_target.var_98056717 = 0;
    if (zm_utility::is_player_valid(e_player)) {
        var_38fe557 = e_player;
    } else {
        var_38fe557 = undefined;
    }
    e_target dodamage(n_damage, e_target.origin, var_38fe557, var_38fe557, undefined, "MOD_UNKNOWN", 0, level.var_edf1e590);
    gibserverutils::gibhead(e_target);
}

// Namespace namespace_efd1ef23
// Params 1, eflags: 0x0
// Checksum 0x8318453, Offset: 0x2b20
// Size: 0x138
function function_3f57ba41(e_player) {
    e_target = self.target_enemy;
    e_target endon(#"death");
    var_3bb42832 = level.var_53cc405d;
    if (isdefined(level.var_f4dc2834)) {
        var_3bb42832 = math::clamp(var_3bb42832, 0, level.var_f4dc2834);
    }
    n_damage = var_3bb42832 * 0.2 / 0.2;
    if (zm_utility::is_player_valid(e_player)) {
        var_38fe557 = e_player;
    } else {
        var_38fe557 = undefined;
    }
    e_target dodamage(n_damage, e_target.origin, var_38fe557, var_38fe557, undefined, "MOD_PROJECTILE_SPLASH", 0, level.var_edf1e590);
    self waittill(#"hash_368634cd");
    e_target.var_bc9b5fbd = 0;
    e_target.var_98056717 = 0;
}

// Namespace namespace_efd1ef23
// Params 1, eflags: 0x0
// Checksum 0xdf7b7992, Offset: 0x2c60
// Size: 0x1b6
function function_99d2c8aa(e_player) {
    if (self flag::get("demongate_chomper_despawning")) {
        return;
    }
    self.target_enemy = undefined;
    var_51b6a540 = self.origin;
    var_6f3820ea = 1024;
    if (isdefined(self.var_603f1f19) && self.var_603f1f19) {
        if (zm_utility::is_player_valid(e_player)) {
            var_51b6a540 = e_player.origin;
        }
        var_6f3820ea = 1024;
    }
    a_ai_enemies = getaiteamarray(level.zombie_team);
    var_237d778f = arraysortclosest(a_ai_enemies, var_51b6a540, a_ai_enemies.size, 0, var_6f3820ea);
    var_237d778f = array::filter(var_237d778f, 0, &namespace_790026d5::function_5aec3adc);
    var_237d778f = array::filter(var_237d778f, 0, &function_c994aef0, self);
    if (var_237d778f.size) {
        var_9183256c = var_237d778f[0];
        var_9183256c.var_bc9b5fbd = 1;
        self.target_enemy = var_9183256c;
        self notify(#"hash_7b23407");
    }
}

// Namespace namespace_efd1ef23
// Params 2, eflags: 0x0
// Checksum 0x74397d99, Offset: 0x2e20
// Size: 0x10a
function function_c994aef0(var_9183256c, var_7119a95d) {
    return (isdefined(var_9183256c.completed_emerging_into_playable_area) && var_9183256c.archetype === "zombie" && var_9183256c.completed_emerging_into_playable_area || (isdefined(var_9183256c.completed_emerging_into_playable_area) && var_9183256c.completed_emerging_into_playable_area || !(isdefined(var_9183256c.var_bc9b5fbd) && var_9183256c.var_bc9b5fbd) && !isdefined(var_9183256c.completed_emerging_into_playable_area)) && var_9183256c.archetype !== "zombie") && bullettracepassed(var_9183256c geteye(), var_7119a95d.origin, 0, var_7119a95d);
}

