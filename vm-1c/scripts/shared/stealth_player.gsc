#using scripts/shared/stealth_status;
#using scripts/shared/stealth_vo;
#using scripts/shared/stealth_tagging;
#using scripts/shared/stealth_level;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_debug;
#using scripts/shared/stealth;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;

#namespace namespace_10443be6;

// Namespace namespace_10443be6
// Params 0, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_c35e6aab
// Checksum 0xb2e4bbba, Offset: 0x3d8
// Size: 0x15c
function init() {
    assert(isplayer(self));
    assert(!isdefined(self.stealth));
    if (!isdefined(self.stealth)) {
        self.stealth = spawnstruct();
    }
    self.stealth.var_a8bce73f = 0;
    self.stealth.var_5ffb6518 = 0;
    self thread function_1026b3f5();
    self thread function_c438db7f();
    self namespace_f917b91a::init();
    self namespace_234a4910::init();
    /#
        self namespace_e449108e::init_debug();
    #/
    self thread function_7300ae66();
    self thread function_bb9ffa41();
    self thread function_ff057a95();
}

// Namespace namespace_10443be6
// Params 0, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_fcf56ab5
// Checksum 0x99ec1590, Offset: 0x540
// Size: 0x4
function stop() {
    
}

// Namespace namespace_10443be6
// Params 0, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_11424fa
// Checksum 0x1c8f92b5, Offset: 0x550
// Size: 0x44
function reset() {
    self.stealth.var_31bf1854 = undefined;
    self.stealth.var_b9ae563d = undefined;
    self.stealth.var_23eafafa = undefined;
    self.stealth.var_9f4ce919 = [];
}

// Namespace namespace_10443be6
// Params 0, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_b55533bc
// Checksum 0x65332852, Offset: 0x5a0
// Size: 0x20
function enabled() {
    return isdefined(self.stealth) && isdefined(self.stealth.var_a8bce73f);
}

// Namespace namespace_10443be6
// Params 2, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_f5f81ff0
// Checksum 0xa5d6612f, Offset: 0x5c8
// Size: 0x24
function function_f5f81ff0(detector, var_2eef6100) {
    self.stealth.var_5ffb6518++;
}

// Namespace namespace_10443be6
// Params 2, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_cd81f5b8
// Checksum 0xab85d7c5, Offset: 0x5f8
// Size: 0x232
function function_cd81f5b8(detector, var_2eef6100) {
    if (!isdefined(self.stealth.var_e1466b44)) {
        self.stealth.var_e1466b44 = [];
    }
    var_974b6e2c = 0;
    replace = -1;
    for (i = 0; i < self.stealth.var_e1466b44.size; i++) {
        value = self function_31218960(self.stealth.var_e1466b44[i]);
        if (value == 127 || !isdefined(self.stealth.var_e1466b44[i]) || self.stealth.var_e1466b44[i] == detector) {
            self.stealth.var_e1466b44[i] = detector;
            return;
        }
        distsq = distancesquared(self.stealth.var_e1466b44[i].origin, self.origin);
        if (distsq > var_974b6e2c) {
            var_974b6e2c = distsq;
            replace = i;
        }
    }
    if (self.stealth.var_e1466b44.size < 4) {
        self.stealth.var_e1466b44[self.stealth.var_e1466b44.size] = detector;
        return;
    }
    distsq = distancesquared(detector.origin, self.origin);
    if (distsq < var_974b6e2c) {
        self.stealth.var_e1466b44[replace] = detector;
    }
}

// Namespace namespace_10443be6
// Params 0, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_ff057a95
// Checksum 0x8f960a37, Offset: 0x838
// Size: 0x498
function function_ff057a95() {
    self notify(#"hash_ff057a95");
    self endon(#"hash_ff057a95");
    self endon(#"disconnect");
    self endon(#"hash_94ff6d85");
    assert(isdefined(self.stealth));
    if (!isdefined(self.stealth.var_9f4ce919)) {
        self.stealth.var_9f4ce919 = [];
    }
    while (true) {
        if (!(isdefined(level.stealth.vo_callouts) && level.stealth.vo_callouts)) {
            wait(1);
            continue;
        }
        if (self playerads() > 0.3) {
            var_bd8fb968 = self function_1a9006bd("cybercom_hijack");
            eye = self geteye();
            var_fd26df34 = anglestoforward(self getplayerangles());
            targets = getaiteamarray("axis");
            if (isdefined(level.stealth.var_581c13ae)) {
                var_2680d17d = [];
                foreach (var_daf22616 in level.stealth.var_581c13ae) {
                    if (!isdefined(var_daf22616)) {
                        continue;
                    }
                    targets[targets.size] = var_daf22616;
                    var_2680d17d[var_2680d17d.size] = var_daf22616;
                }
                if (var_2680d17d.size != level.stealth.var_581c13ae.size) {
                    level.stealth.var_581c13ae = var_2680d17d;
                }
            }
            foreach (var_daf22616 in targets) {
                var_80a7f288 = "careful";
                var_bbf94a49 = var_daf22616.origin;
                if (issentient(var_daf22616)) {
                    var_bbf94a49 = var_daf22616 geteye();
                }
                if (isdefined(var_daf22616.var_3bee9acf)) {
                    var_80a7f288 = var_daf22616.var_3bee9acf;
                } else if (isvehicle(var_daf22616)) {
                    if (var_bd8fb968 && var_daf22616 isremotecontrol()) {
                        var_80a7f288 = "careful_hack";
                    } else {
                        var_80a7f288 = "careful_" + var_daf22616.archetype;
                    }
                }
                if (isdefined(self.stealth.var_9f4ce919[var_80a7f288])) {
                    continue;
                }
                dir = vectornormalize(var_bbf94a49 - eye);
                if (vectordot(var_fd26df34, dir) > 0.99) {
                    if (sighttracepassed(var_bbf94a49, eye, 0, undefined)) {
                        self namespace_234a4910::function_e3ae87b3(var_80a7f288);
                        self.stealth.var_9f4ce919[var_80a7f288] = 1;
                    }
                }
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_10443be6
// Params 1, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_31218960
// Checksum 0x513419cb, Offset: 0xcd8
// Size: 0x1f0
function function_31218960(other) {
    if (!isdefined(other)) {
        return 127;
    }
    if (getdvarint("stealth_display", 1) == 1 && isalive(other) && !other.ignoreall) {
        value = other getstealthsightvalue(self) * 49;
        bcansee = other stealth::can_see(self);
        var_a836f7ed = isdefined(other.stealth.var_d1b49f30) && isdefined(other.stealth.var_d1b49f30[self getentitynumber()]);
        var_9b2f0c51 = isdefined(other.stealth.var_c49c37ed) && isdefined(other.stealth.var_c49c37ed[self getentitynumber()]);
        if (value > 0 || var_9b2f0c51 || var_a836f7ed) {
            if (var_a836f7ed) {
                value = 50;
            } else if (var_9b2f0c51) {
                value = 49;
            }
            if (bcansee || var_a836f7ed) {
                value += 50;
            }
            return int(value);
        }
    }
    return 127;
}

// Namespace namespace_10443be6
// Params 1, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_b9393d6c
// Checksum 0x8ed6a0bc, Offset: 0xed0
// Size: 0x15c
function function_b9393d6c(awareness) {
    vals = level namespace_ad45a419::function_b3269823(awareness);
    assert(isdefined(vals));
    maxvisibledist = vals.maxsightdist;
    if (awareness != "combat") {
        stance = self getstance();
        if (isdefined(self.stealth.in_shadow) && self.stealth.in_shadow) {
            maxvisibledist *= 0.5;
        }
        if (stance == "prone") {
            maxvisibledist *= 0.25;
        } else if (stance == "crouch") {
            maxvisibledist *= 0.5;
        }
    }
    self.maxvisibledist = maxvisibledist;
    self.maxseenfovcosine = vals.fovcosine;
    self.maxseenfovcosinez = vals.fovcosinez;
}

// Namespace namespace_10443be6
// Params 1, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_96e60fd0
// Checksum 0x8eaec4d7, Offset: 0x1038
// Size: 0x20
function function_96e60fd0(detected) {
    self.stealth.var_a8bce73f = detected;
}

// Namespace namespace_10443be6
// Params 0, eflags: 0x0
// namespace_10443be6<file_0>::function_f1c48da4
// Checksum 0x300a0c81, Offset: 0x1060
// Size: 0x32
function function_f1c48da4() {
    if (!self enabled()) {
        return 0;
    }
    return self.stealth.var_a8bce73f;
}

// Namespace namespace_10443be6
// Params 0, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_1026b3f5
// Checksum 0x95217a14, Offset: 0x10a0
// Size: 0xec
function function_1026b3f5() {
    self endon(#"disconnect");
    while (true) {
        stance = self getstance();
        maxvisibledist = 1600;
        switch (stance) {
        case 8:
            maxvisibledist = 800;
            break;
        case 7:
            maxvisibledist = 400;
            break;
        }
        if (isdefined(self.stealth.in_shadow) && isdefined(self.stealth) && self.stealth.in_shadow) {
            maxvisibledist *= 0.5;
        }
        self.maxvisibledist = maxvisibledist;
        wait(0.25);
    }
}

// Namespace namespace_10443be6
// Params 0, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_c438db7f
// Checksum 0x33a3ab99, Offset: 0x1198
// Size: 0x70
function function_c438db7f() {
    self endon(#"disconnect");
    self endon(#"hash_94ff6d85");
    while (true) {
        self.stealth.var_5ffb6518 = 0;
        wait(1);
        if (self.stealth.var_5ffb6518 <= 0) {
            self function_96e60fd0(0);
        }
    }
}

// Namespace namespace_10443be6
// Params 0, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_7300ae66
// Checksum 0x384464c5, Offset: 0x1210
// Size: 0xa8
function function_7300ae66() {
    self endon(#"disconnect");
    self endon(#"hash_94ff6d85");
    wait(0.05);
    self function_24319235(1);
    while (true) {
        self util::waittill_any("spawned");
        self function_b9393d6c("high_alert");
        wait(0.05);
        self function_24319235(1);
    }
}

// Namespace namespace_10443be6
// Params 0, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_bb9ffa41
// Checksum 0xec73224e, Offset: 0x12c0
// Size: 0x210
function function_bb9ffa41() {
    self endon(#"disconnect");
    self endon(#"hash_94ff6d85");
    var_52ff854e = 0;
    while (true) {
        kills = self globallogic_score::getpersstat("kills");
        if (!isdefined(kills)) {
            kills = 0;
        }
        var_b69afa72 = kills;
        lastkilltime = gettime();
        victim, smeansofdeath, weapon = self waittill(#"hash_c56ba9f7");
        waittillframeend();
        if (isdefined(victim) && isdefined(victim.team) && victim.team != "axis") {
            self thread namespace_234a4910::function_e3ae87b3("fail_kill");
            continue;
        }
        kills = self globallogic_score::getpersstat("kills");
        if (!isdefined(kills)) {
            kills = 1;
        }
        var_c839bf74 = kills - var_b69afa72;
        if (gettime() - lastkilltime > 1000) {
            var_52ff854e = 0;
        }
        if (var_c839bf74 >= 2 && isdefined(smeansofdeath) && util::isbulletimpactmod(smeansofdeath)) {
            self notify(#"hash_97df59d5");
        }
        var_52ff854e += var_c839bf74;
        if (!isdefined(self.stealth)) {
            return;
        }
        if (!isdefined(level.stealth)) {
            return;
        }
        self thread function_e507ced8(victim, smeansofdeath, weapon, var_52ff854e);
    }
}

// Namespace namespace_10443be6
// Params 4, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_e507ced8
// Checksum 0x213afb6f, Offset: 0x14d8
// Size: 0x160
function function_e507ced8(victim, smeansofdeath, weapon, killcount) {
    self notify(#"hash_e507ced8");
    self endon(#"hash_e507ced8");
    self endon(#"disconnect");
    self endon(#"hash_94ff6d85");
    self endon(#"death");
    if (!level flag::get("stealth_alert") && !level flag::get("stealth_combat") && !level flag::get("stealth_discovered")) {
        if (isdefined(victim) && isdefined(victim.var_99baf927)) {
            self namespace_234a4910::function_e3ae87b3(victim.var_99baf927);
            return;
        }
        if (!(isdefined(level.stealth.var_30d9fcc6) && level.stealth.var_30d9fcc6)) {
            if (killcount > 1) {
                return;
            }
            if (isdefined(weapon) && weapon.type == "bullet") {
            }
        }
    }
}

// Namespace namespace_10443be6
// Params 1, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_24319235
// Checksum 0x24cdfe1c, Offset: 0x1640
// Size: 0x11a
function function_24319235(ignore) {
    if (!isdefined(level.stealth)) {
        return;
    }
    if (!isdefined(level.stealth.enemies)) {
        return;
    }
    if (!isdefined(level.stealth.enemies[self.team])) {
        return;
    }
    foreach (enemy in level.stealth.enemies[self.team]) {
        if (!isdefined(enemy)) {
            continue;
        }
        if (enemy namespace_80045451::enabled()) {
            enemy namespace_80045451::function_c62ada65(self, ignore);
        }
    }
}

// Namespace namespace_10443be6
// Params 3, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_3cd0dcd
// Checksum 0x7ba4a30b, Offset: 0x1768
// Size: 0xfc
function function_3cd0dcd(e_other, bcansee, awareness) {
    if (getdvarint("stealth_audio", 1) == 0) {
        return;
    }
    var_a836f7ed = awareness == "combat";
    if (!self enabled()) {
        return;
    }
    if (!(isdefined(self.stealth.var_a8bce73f) && self.stealth.var_a8bce73f)) {
        if (!var_a836f7ed) {
            if (bcansee) {
                self thread function_6163610f(awareness);
            }
        }
        if (var_a836f7ed) {
            self.stealth.var_a8bce73f = 1;
            self thread function_e6e6afd7(e_other);
        }
    }
}

// Namespace namespace_10443be6
// Params 1, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_e6e6afd7
// Checksum 0xbc9dc6ed, Offset: 0x1870
// Size: 0x6c
function function_e6e6afd7(e_other) {
    self endon(#"disconnect");
    result = e_other util::waittill_any_timeout(0.25, "death");
    if (result == "timeout") {
        self thread function_21fabca();
    }
}

// Namespace namespace_10443be6
// Params 1, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_6163610f
// Checksum 0xef9e8bb4, Offset: 0x18e8
// Size: 0xbc
function function_6163610f(awareness) {
    self notify(#"hash_6163610f");
    self endon(#"hash_6163610f");
    self endon(#"disconnect");
    self endon(#"hash_94ff6d85");
    self endon(#"death");
    var_3c0e4301 = 1;
    if (awareness == "high_alert") {
        var_3c0e4301 = 2;
    }
    self clientfield::set_to_player("stealth_sighting", var_3c0e4301);
    wait(0.15);
    self clientfield::set_to_player("stealth_sighting", 0);
}

// Namespace namespace_10443be6
// Params 0, eflags: 0x0
// namespace_10443be6<file_0>::function_a321c8e5
// Checksum 0x923f4064, Offset: 0x19b0
// Size: 0x8c
function function_a321c8e5() {
    self notify(#"hash_a321c8e5");
    self endon(#"hash_a321c8e5");
    self endon(#"disconnect");
    self endon(#"hash_94ff6d85");
    self endon(#"death");
    self clientfield::set_to_player("stealth_alerted", 1);
    wait(0.15);
    self clientfield::set_to_player("stealth_alerted", 0);
}

// Namespace namespace_10443be6
// Params 0, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_21fabca
// Checksum 0x4c2f4b61, Offset: 0x1a48
// Size: 0x1c
function function_21fabca() {
    stealth::function_e0319e51("combat");
}

// Namespace namespace_10443be6
// Params 1, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_ca6a0809
// Checksum 0xcd0e4c14, Offset: 0x1a70
// Size: 0x7c
function function_ca6a0809(enemy) {
    if (enemy namespace_80045451::enabled() && enemy namespace_80045451::function_739525d() == "combat") {
        return;
    }
    self thread function_509ca7a6(enemy);
    self thread function_3f6bd04c(enemy);
}

// Namespace namespace_10443be6
// Params 1, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_509ca7a6
// Checksum 0x4745c0a9, Offset: 0x1af8
// Size: 0x6b4
function function_509ca7a6(enemy) {
    now = gettime();
    starttimems = now;
    entnum = self getentitynumber();
    assert(isdefined(enemy));
    assert(isdefined(enemy.stealth));
    if (isdefined(self.stealth.incombat) && self.stealth.incombat) {
        return;
    }
    if (isdefined(enemy.stealth.var_d1c69a51) && isdefined(enemy.stealth.var_d1c69a51[entnum]) && now - enemy.stealth.var_d1c69a51[entnum] < 20000) {
        return;
    }
    if (getdvarint("stealth_indicator", 0)) {
        enemy notify("sight_indicator_" + entnum);
        enemy endon("sight_indicator_" + entnum);
        enemy endon(#"death");
        if (!isdefined(enemy.stealth.var_d1c69a51)) {
            enemy.stealth.var_d1c69a51 = [];
        }
        enemy.stealth.var_d1c69a51[entnum] = now;
        basealpha = 0.67;
        var_f69107b4 = 1000;
        index = entnum + var_f69107b4;
        enemy namespace_8312dbf::function_cf9dd532(self, var_f69107b4);
        var_5cbd0572 = "white_stealth_spotting";
        color = (1, 1, 1);
        if (isdefined(enemy.stealth.status.var_2eb71ab0) && isdefined(enemy.stealth.status.icons[index])) {
            enemy.stealth.status.icons[index] settargetent(enemy.stealth.status.var_2eb71ab0);
            enemy.stealth.status.icons[index] setshader(var_5cbd0572, 5, 5);
            enemy.stealth.status.icons[index] setwaypoint(0, var_5cbd0572, 0, 0);
            enemy.stealth.status.icons[index].color = color;
            enemy.stealth.status.icons[index].alpha = basealpha;
            enemy.stealth.status.icons[index].var_c3d91e16 = gettime();
        }
        var_8c974758 = 1 * 1000;
        var_61fba14c = min(1000, var_8c974758);
        for (currenttimems = 0; currenttimems < var_8c974758; currenttimems += 50) {
            if (enemy namespace_80045451::function_739525d() == "combat") {
                currenttimems = max(var_8c974758 - var_61fba14c, currenttimems);
            }
            var_ddb74378 = basealpha + sin(float(gettime())) * (1 - basealpha);
            if (var_8c974758 - currenttimems <= var_61fba14c && isdefined(enemy.stealth.status.var_2eb71ab0) && isdefined(enemy.stealth.status.icons[index])) {
                alpha = var_ddb74378 * float(var_8c974758 - currenttimems) / float(var_61fba14c);
                enemy.stealth.status.icons[index].alpha = min(max(alpha, 0), 1);
            } else {
                enemy.stealth.status.icons[index].alpha = min(max(var_ddb74378, 0), 1);
            }
            wait(0.05);
        }
        enemy namespace_8312dbf::function_180adb28(index, var_f69107b4);
    }
}

// Namespace namespace_10443be6
// Params 1, eflags: 0x1 linked
// namespace_10443be6<file_0>::function_3f6bd04c
// Checksum 0xe3891b8d, Offset: 0x21b8
// Size: 0x294
function function_3f6bd04c(enemy) {
    assert(isdefined(self.stealth));
    now = gettime();
    if (isdefined(self.stealth.incombat) && self.stealth.incombat) {
        return;
    }
    if (isdefined(self.stealth.var_45848ab) && now - self.stealth.var_45848ab < 20000) {
        return;
    }
    self notify(#"hash_3f6bd04c");
    self endon(#"hash_3f6bd04c");
    self endon(#"disconnect");
    self endon(#"hash_94ff6d85");
    self.stealth.var_45848ab = now;
    localyaw = self.angles[1] - vectortoangles(enemy.origin - self.origin)[1];
    var_a113a204 = vectortoangles(enemy.origin - self.origin)[0];
    var_a113a204 = angleclamp180(var_a113a204);
    if (localyaw < 0) {
        localyaw += 360;
    }
    var_be26784d = "enemy_behind";
    if (var_a113a204 > 45) {
        var_be26784d = "enemy_below";
    } else if (var_a113a204 < -45) {
        var_be26784d = "enemy_above";
    } else if (localyaw >= 315 || localyaw <= 45) {
        var_be26784d = "enemy_ahead";
    } else if (localyaw >= 45 && localyaw <= -121) {
        var_be26784d = "enemy_right";
    } else if (localyaw >= -31 && localyaw <= 315) {
        var_be26784d = "enemy_left";
    }
    self namespace_234a4910::function_866c6270(var_be26784d, 1);
}

