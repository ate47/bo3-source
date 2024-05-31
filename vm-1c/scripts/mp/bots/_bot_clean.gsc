#using scripts/mp/_util;
#using scripts/mp/teams/_teams;
#using scripts/shared/bots/bot_buttons;
#using scripts/shared/bots/bot_traversals;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/_bot;
#using scripts/mp/bots/_bot_combat;
#using scripts/mp/bots/_bot;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;

#namespace namespace_934c83ce;

// Namespace namespace_934c83ce
// Params 0, eflags: 0x1 linked
// namespace_934c83ce<file_0>::function_c35e6aab
// Checksum 0x30943025, Offset: 0x218
// Size: 0x4c
function init() {
    level.var_47854466 = &function_b5eda34;
    level.var_ce074aba = &function_eeb4665;
    level.var_1a99051e = &function_22585c05;
}

// Namespace namespace_934c83ce
// Params 0, eflags: 0x1 linked
// namespace_934c83ce<file_0>::function_b5eda34
// Checksum 0x1376dff3, Offset: 0x270
// Size: 0x114
function function_b5eda34() {
    if (isdefined(self.var_4c9a35db)) {
        if (self.carriedtacos == 0 || self.var_4c9a35db.interactteam == "none") {
            self.var_4c9a35db = undefined;
            self function_b4a0b3c5(self.origin);
        }
    }
    if (isdefined(self.var_76563879)) {
        if (self.var_76563879.interactteam == "none" || self.var_76563879.droptime != self.var_2ae10761) {
            self.var_76563879 = undefined;
            self function_b4a0b3c5(self.origin);
        }
    }
    if (!self namespace_5cd60c9f::function_231137e6()) {
        function_cff375b4(1024);
    }
    self namespace_5cd60c9f::function_76d00bea();
}

// Namespace namespace_934c83ce
// Params 0, eflags: 0x1 linked
// namespace_934c83ce<file_0>::function_eeb4665
// Checksum 0x3d79df07, Offset: 0x390
// Size: 0x17c
function function_eeb4665() {
    if (isdefined(self.var_4c9a35db)) {
        self bot::function_1f0a2676(self.var_4c9a35db.trigger);
        self bot::sprint_to_goal();
        return;
    }
    if (randomint(10) < self.carriedtacos) {
        foreach (var_264552c2 in level.cleandeposithubs) {
            if (var_264552c2.interactteam == "any") {
                self.var_4c9a35db = var_264552c2;
                self.var_76563879 = undefined;
                self bot::function_1f0a2676(self.var_4c9a35db.trigger);
                self bot::sprint_to_goal();
                return;
            }
        }
    }
    if (function_cff375b4(1024)) {
        return;
    }
    self bot::function_eeb4665();
}

// Namespace namespace_934c83ce
// Params 1, eflags: 0x1 linked
// namespace_934c83ce<file_0>::function_cff375b4
// Checksum 0x89262acd, Offset: 0x518
// Size: 0xa0
function function_cff375b4(radius) {
    var_6acca854 = function_21bcbfc8(radius);
    if (!isdefined(var_6acca854)) {
        return false;
    }
    self.var_76563879 = var_6acca854;
    self.var_2ae10761 = var_6acca854.droptime;
    self bot::function_1f0a2676(var_6acca854.trigger);
    self bot::sprint_to_goal();
    return true;
}

// Namespace namespace_934c83ce
// Params 1, eflags: 0x1 linked
// namespace_934c83ce<file_0>::function_21bcbfc8
// Checksum 0xe8fc16f9, Offset: 0x5c0
// Size: 0x188
function function_21bcbfc8(radius) {
    radiussq = radius * radius;
    var_6acca854 = undefined;
    var_45d4544c = undefined;
    foreach (taco in level.tacos) {
        if (taco.interactteam == "none" || !ispointonnavmesh(taco.origin, self)) {
            continue;
        }
        var_426bd3ee = distance2dsquared(self.origin, taco.origin);
        if (taco.attacker != self && var_426bd3ee > radiussq) {
            continue;
        }
        if (!isdefined(var_6acca854) || var_426bd3ee < var_45d4544c) {
            var_6acca854 = taco;
            var_45d4544c = var_426bd3ee;
        }
    }
    return var_6acca854;
}

// Namespace namespace_934c83ce
// Params 0, eflags: 0x1 linked
// namespace_934c83ce<file_0>::function_22585c05
// Checksum 0x733b7f91, Offset: 0x750
// Size: 0x114
function function_22585c05() {
    if (isdefined(self.var_4c9a35db)) {
        if (!self function_2b2bd09f()) {
            self bot::function_1f0a2676(self.var_4c9a35db.trigger);
            self bot::sprint_to_goal();
        }
        return;
    }
    radiussq = 65536;
    if (isdefined(self.var_76563879)) {
        var_426bd3ee = distance2dsquared(self.origin, self.var_76563879.origin);
        if (var_426bd3ee > radiussq) {
            self.var_76563879 = undefined;
        }
    }
    if (isdefined(self.var_76563879) || self function_cff375b4(1024)) {
        return;
    }
    self namespace_5cd60c9f::function_22585c05();
}

