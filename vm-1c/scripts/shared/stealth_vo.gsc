#using scripts/cp/_dialog;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_vengeance_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/array_shared;
#using scripts/shared/stealth;
#using scripts/shared/stealth_aware;
#using scripts/shared/stealth_player;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace stealth_vo;

// Namespace stealth_vo
// Params 0, eflags: 0x0
// Checksum 0x55d860aa, Offset: 0x2c8
// Size: 0xa2
function init() {
    assert(isdefined(self.stealth));
    self set_stealth_mode(1);
    if (isplayer(self)) {
        self thread ambient_player_thread();
        return;
    }
    if (self == level) {
        self function_6f9a7a6d();
        level.allowbattlechatter["stealth"] = 1;
    }
}

// Namespace stealth_vo
// Params 0, eflags: 0x0
// Checksum 0x648111b7, Offset: 0x378
// Size: 0x44
function stop() {
    assert(isdefined(self));
    if (isdefined(self.allowbattlechatter["stealth"])) {
        self.allowbattlechatter["stealth"] = undefined;
    }
}

// Namespace stealth_vo
// Params 0, eflags: 0x0
// Checksum 0x30f7980b, Offset: 0x3c8
// Size: 0x2e
function enabled() {
    return isdefined(self.stealth) && isdefined(self.allowbattlechatter) && isdefined(self.allowbattlechatter["stealth"]);
}

// Namespace stealth_vo
// Params 1, eflags: 0x0
// Checksum 0x488b9d1d, Offset: 0x400
// Size: 0x4c
function function_bb96fd5b(var_1d811e47) {
    return isdefined(self.stealth) && isdefined(self.allowbattlechatter) && isdefined(self.allowbattlechatter["stealth"]) && self.allowbattlechatter["stealth"];
}

// Namespace stealth_vo
// Params 1, eflags: 0x0
// Checksum 0xb265dad5, Offset: 0x458
// Size: 0x24
function set_stealth_mode(var_1d811e47) {
    self thread function_c2c75efc(var_1d811e47);
}

// Namespace stealth_vo
// Params 1, eflags: 0x0
// Checksum 0x570cc646, Offset: 0x488
// Size: 0x11a
function function_c2c75efc(var_1d811e47) {
    if (isdefined(self.allowbattlechatter) && isdefined(self.allowbattlechatter["stealth"]) && self.allowbattlechatter["stealth"] == var_1d811e47) {
        return;
    }
    self notify(#"hash_c2c75efc");
    self endon(#"hash_c2c75efc");
    if (!isplayer(self)) {
        self endon(#"death");
    }
    wait 0.05;
    if (isdefined(self)) {
        while (isdefined(self.isspeaking) && (isdefined(self) && isdefined(self.stealth) && isdefined(self.stealth.var_222af664) || self.isspeaking)) {
            wait 0.05;
        }
        self.allowbattlechatter["bc"] = !var_1d811e47;
        self.allowbattlechatter["stealth"] = var_1d811e47;
    }
}

// Namespace stealth_vo
// Params 1, eflags: 0x0
// Checksum 0x4e67994f, Offset: 0x5b0
// Size: 0x27e
function function_2756e5d4(var_904f1fb9) {
    self endon(#"death");
    self endon(#"stop_stealth");
    if (!isactor(self) || !isalive(self)) {
        return;
    }
    str_event = var_904f1fb9.parms[0];
    if (!isdefined(str_event)) {
        return;
    }
    var_94aa7e70 = self function_243da9f0(str_event);
    if (isdefined(var_94aa7e70)) {
        var_6425cb0f = self function_243da9f0(str_event + "_" + var_94aa7e70 + "_response");
        priority = level.stealth.var_222af664[str_event];
        if (!isdefined(priority)) {
            priority = 0;
        }
        if (!isdefined(self.stealth.var_222af664) || self.stealth.var_222af664 <= priority) {
            self.stealth.var_222af664 = priority;
        } else {
            return;
        }
        wait randomfloatrange(0.25, 0.75);
        if (isdefined(self.silenced) && self.silenced) {
            return;
        }
        if (!isdefined(self.stealth.var_222af664) || self.stealth.var_222af664 <= priority) {
            self.stealth.var_222af664 = priority;
            self battlechatter::function_f3de557b(self, var_94aa7e70, var_6425cb0f, "stealth", 1);
            while (isdefined(self.isspeaking) && self.isspeaking) {
                wait 0.05;
            }
            if (isdefined(self.stealth) && isdefined(self.stealth.var_222af664) && self.stealth.var_222af664 == priority) {
                self.stealth.var_222af664 = undefined;
            }
        }
    }
}

// Namespace stealth_vo
// Params 2, eflags: 0x0
// Checksum 0xe2bdc37, Offset: 0x838
// Size: 0x356
function function_243da9f0(str_event, var_d3a25cc) {
    now = gettime();
    if (!self enabled()) {
        return undefined;
    }
    if (!isdefined(level.stealth)) {
        return undefined;
    }
    if (!isdefined(var_d3a25cc)) {
        var_d3a25cc = level.stealth.vo_alias;
    }
    if (!isdefined(var_d3a25cc.alias) || !isdefined(var_d3a25cc.alias[str_event])) {
        return undefined;
    }
    if (!isdefined(level.stealth.var_e031c3f5)) {
        level.stealth.var_e031c3f5 = [];
    }
    line = undefined;
    count = 0;
    var_8be39d6 = [];
    var_8be39d6[0] = "noncombat";
    if (self stealth_aware::enabled()) {
        var_8be39d6[var_8be39d6.size] = self stealth_aware::function_739525d();
    }
    for (var_ded856b0 = 0; var_ded856b0 < 2; var_ded856b0++) {
        foreach (awareness in var_8be39d6) {
            if (isdefined(var_d3a25cc.alias[str_event][awareness])) {
                foreach (alias in var_d3a25cc.alias[str_event][awareness]) {
                    if (var_ded856b0 == 0) {
                        if (isdefined(level.stealth.var_e031c3f5[alias]) && now - level.stealth.var_e031c3f5[alias] < 2000) {
                            continue;
                        }
                    }
                    count += 1;
                    if (randomfloat(1) <= 1 / count) {
                        line = alias;
                    }
                }
            }
        }
        if (isdefined(line)) {
            break;
        }
    }
    if (isdefined(line)) {
        level.stealth.var_e031c3f5[line] = now;
    }
    return line;
}

// Namespace stealth_vo
// Params 0, eflags: 0x0
// Checksum 0x5e57ed16, Offset: 0xb98
// Size: 0x2cc
function function_6f9a7a6d() {
    if (!isdefined(level.stealth)) {
        level.stealth = spawnstruct();
    }
    if (!isdefined(level.stealth.var_222af664)) {
        level.stealth.var_222af664 = [];
    }
    level.stealth.var_222af664["ambient"] = 0;
    level.stealth.var_222af664["resume"] = 0.25;
    level.stealth.var_222af664["alert"] = 0.5;
    level.stealth.var_222af664["explosion"] = 0.8;
    level.stealth.var_222af664["corpse"] = 0.9;
    level.stealth.var_222af664["enemy"] = 1;
    function_2cfe7001("alert", "patrol_alerted", "response_backup");
    function_2cfe7001("ambient", "patrol_brief", "response_affirm");
    function_2cfe7001("ambient", "patrol_calm", undefined, "unaware");
    function_2cfe7001("ambient", "patrol_clear", undefined, "unaware");
    function_2cfe7001("ambient", "patrol_cough", undefined, "unaware");
    function_2cfe7001("ambient", "patrol_throat", undefined, "unaware");
    function_2cfe7001("resume", "patrol_resume", "response_affirm");
    function_2cfe7001("resume", "patrol_resume", "response_secure");
    function_2cfe7001("corpse", "spotted_corpse");
    function_2cfe7001("enemy", "spotted_enemy");
    function_2cfe7001("explosion", "spotted_explosion");
}

// Namespace stealth_vo
// Params 0, eflags: 0x0
// Checksum 0x3e4695bd, Offset: 0xe70
// Size: 0x324
function ambient_player_thread() {
    assert(isplayer(self));
    self notify(#"ambient_player_thread");
    self endon(#"ambient_player_thread");
    self endon(#"disconnect");
    self endon(#"stop_stealth");
    wait 0.05;
    maxdist = 1000;
    maxdistsq = maxdist * maxdist;
    while (true) {
        wait randomfloatrange(10, 15);
        if (!isdefined(level.stealth) || !isdefined(level.stealth.enemies) || !isdefined(self.team) || !isdefined(level.stealth.enemies[self.team])) {
            continue;
        }
        candidates = [];
        foreach (enemy in level.stealth.enemies[self.team]) {
            if (!isalive(enemy)) {
                continue;
            }
            if (!enemy function_bb96fd5b()) {
                continue;
            }
            if (enemy.ignoreall) {
                continue;
            }
            distsq = distancesquared(enemy.origin, self.origin);
            if (distsq > maxdistsq) {
                continue;
            }
            if (isdefined(enemy.stealth.vo_next_ambient) && gettime() < enemy.stealth.vo_next_ambient) {
                continue;
            }
            candidates[candidates.size] = enemy;
        }
        candidates = arraysortclosest(candidates, self.origin, 1, 0, maxdist);
        if (isdefined(candidates) && candidates.size > 0) {
            candidates[0] notify(#"stealth_vo", "ambient");
            candidates[0].stealth.vo_next_ambient = gettime() + randomintrange(8000, 12000);
        }
    }
}

// Namespace stealth_vo
// Params 0, eflags: 0x0
// Checksum 0x86b1d5d7, Offset: 0x11a0
// Size: 0x1e
function function_772af5b1() {
    if (isdefined(level.stealth)) {
        level.stealth.vo_alias = undefined;
    }
}

// Namespace stealth_vo
// Params 4, eflags: 0x0
// Checksum 0xd5691c90, Offset: 0x11c8
// Size: 0x164
function function_2cfe7001(str_event, str_alias, var_9e916b13, var_12131b3c) {
    assert(isstring(str_event));
    assert(isstring(str_alias));
    if (!isdefined(level.stealth)) {
        level.stealth = spawnstruct();
    }
    if (!isdefined(level.stealth.vo_alias)) {
        level.stealth.vo_alias = spawnstruct();
    }
    function_6ae431dd(level.stealth.vo_alias, str_event, str_alias, var_12131b3c);
    if (isdefined(var_9e916b13)) {
        function_6ae431dd(level.stealth.vo_alias, str_event + "_" + str_alias + "_response", str_alias, var_12131b3c);
    }
}

// Namespace stealth_vo
// Params 4, eflags: 0x0
// Checksum 0xa853cf7b, Offset: 0x1338
// Size: 0x196
function function_6ae431dd(struct, str_event, str_alias, var_12131b3c) {
    assert(isdefined(struct));
    assert(isstring(str_event));
    assert(isstring(str_alias));
    if (!isdefined(var_12131b3c)) {
        var_12131b3c = "noncombat";
    }
    if (!isdefined(struct.alias)) {
        struct.alias = [];
    }
    if (!isdefined(struct.alias[str_event])) {
        struct.alias[str_event] = [];
    }
    if (!isdefined(struct.alias[str_event][var_12131b3c])) {
        struct.alias[str_event][var_12131b3c] = [];
    }
    if (!isdefined(struct.alias[str_event][var_12131b3c][str_alias])) {
        struct.alias[str_event][var_12131b3c][str_alias] = str_alias;
    }
}

// Namespace stealth_vo
// Params 3, eflags: 0x0
// Checksum 0xe27f6a68, Offset: 0x14d8
// Size: 0x170
function function_5714528b(var_be26784d, str_vo_line, var_f12bb4cd) {
    assert(isdefined(level.stealth));
    if (!isdefined(level.stealth.vo_callout)) {
        level.stealth.vo_callout = [];
    }
    if (!isdefined(level.stealth.vo_callout[var_be26784d])) {
        level.stealth.vo_callout[var_be26784d] = [];
    }
    level.stealth.vo_callout[var_be26784d][level.stealth.vo_callout[var_be26784d].size] = str_vo_line;
    if (isdefined(var_f12bb4cd) && var_f12bb4cd) {
        if (!isdefined(level.stealth.var_787c93a0)) {
            level.stealth.var_787c93a0 = [];
        }
        if (!isdefined(level.stealth.var_787c93a0[var_be26784d])) {
            level.stealth.var_787c93a0[var_be26784d] = [];
        }
        level.stealth.var_787c93a0[var_be26784d][level.stealth.var_787c93a0[var_be26784d].size] = str_vo_line;
    }
}

// Namespace stealth_vo
// Params 2, eflags: 0x0
// Checksum 0x6149989b, Offset: 0x1650
// Size: 0x394
function function_866c6270(var_be26784d, priority) {
    if (!(isdefined(level.stealth.vo_callouts) && level.stealth.vo_callouts)) {
        return;
    }
    assert(isplayer(self));
    assert(isdefined(level.stealth));
    assert(isdefined(level.stealth.vo_callout));
    assert(isdefined(level.stealth.vo_callout[var_be26784d]));
    if (!isdefined(priority)) {
        priority = 0;
    }
    str_vo_line = undefined;
    if (level.stealth.vo_callout[var_be26784d].size <= 2) {
        str_vo_line = array::random(level.stealth.vo_callout[var_be26784d]);
    } else {
        if (!isdefined(self.stealth.vo_deck)) {
            self.stealth.vo_deck = [];
        }
        if (!isdefined(self.stealth.vo_deck[var_be26784d])) {
            self.stealth.vo_deck[var_be26784d] = level.stealth.vo_callout[var_be26784d];
        }
        if (!isdefined(self.stealth.var_b9ae563d)) {
            self.stealth.var_b9ae563d = [];
        }
        if (!isdefined(self.stealth.var_b9ae563d[var_be26784d])) {
            self.stealth.var_b9ae563d[var_be26784d] = self.stealth.vo_deck[var_be26784d].size;
        }
        if (self.stealth.var_b9ae563d[var_be26784d] > self.stealth.vo_deck[var_be26784d].size - 1) {
            self.stealth.vo_deck = array::randomize(level.stealth.vo_callout[var_be26784d]);
            self.stealth.var_b9ae563d[var_be26784d] = 0;
        }
        str_vo_line = self.stealth.vo_deck[self.stealth.var_b9ae563d[var_be26784d]];
        self.stealth.var_b9ae563d[var_be26784d] = self.stealth.var_b9ae563d[var_be26784d] + 1;
    }
    if (isdefined(str_vo_line)) {
        if (isdefined(level.stealth.var_787c93a0) && isdefined(level.stealth.var_787c93a0[var_be26784d])) {
            self thread function_500f3ab6(str_vo_line);
            return;
        }
        self thread namespace_63b4601c::function_ee75acde(str_vo_line, 0, priority, self);
    }
}

// Namespace stealth_vo
// Params 3, eflags: 0x0
// Checksum 0xc96d7d4f, Offset: 0x19f0
// Size: 0xac
function function_e3ae87b3(var_be26784d, var_4818f349, priority) {
    assert(isplayer(self));
    if (!isdefined(level.stealth)) {
        return;
    }
    if (!isdefined(level.stealth.vo_callout)) {
        return;
    }
    if (!isdefined(level.stealth.vo_callout[var_be26784d])) {
        return;
    }
    self thread function_584c6d3a(var_be26784d, var_4818f349, priority);
}

// Namespace stealth_vo
// Params 3, eflags: 0x0
// Checksum 0x137cd994, Offset: 0x1aa8
// Size: 0x194
function function_584c6d3a(var_be26784d, var_4818f349, priority) {
    self notify(#"hash_e3ae87b3");
    self endon(#"hash_e3ae87b3");
    self endon(#"disconnect");
    self endon(#"stop_stealth");
    assert(isplayer(self));
    if (isentity(var_4818f349)) {
        var_4818f349 endon(#"death");
    }
    now = gettime();
    if (!isdefined(self.stealth.var_23eafafa)) {
        self.stealth.var_23eafafa = [];
    }
    wait randomfloatrange(1, 2);
    if (!self stealth_player::enabled()) {
        return;
    }
    if (isdefined(self.stealth.var_23eafafa[var_be26784d]) && now - self.stealth.var_23eafafa[var_be26784d] < 20000) {
        return;
    }
    self.stealth.var_23eafafa[var_be26784d] = now;
    self function_866c6270(var_be26784d, priority);
}

// Namespace stealth_vo
// Params 1, eflags: 0x0
// Checksum 0x5340e155, Offset: 0x1c48
// Size: 0xde
function function_500f3ab6(str_text) {
    self notify(#"hash_500f3ab6");
    self endon(#"hash_500f3ab6");
    self endon(#"disconnect");
    self endon(#"stop_stealth");
    if (isdefined(self.stealth.var_500f3ab6)) {
        self util::function_79f9f98d();
    }
    self thread util::function_67cfce72("[ " + str_text + " ]", undefined, undefined, 125, 0);
    wait 3;
    self util::function_79f9f98d();
    if (isdefined(self.stealth.var_500f3ab6)) {
        self.stealth.var_500f3ab6 = undefined;
    }
}

// Namespace stealth_vo
// Params 1, eflags: 0x0
// Checksum 0x5082ce79, Offset: 0x1d30
// Size: 0x74
function function_4970c8b8(callout) {
    if (isdefined(callout)) {
        if (!isdefined(level.stealth.var_581c13ae)) {
            level.stealth.var_581c13ae = [];
        }
        level.stealth.var_581c13ae[level.stealth.var_581c13ae.size] = self;
        self.stealth_callout = callout;
    }
}

