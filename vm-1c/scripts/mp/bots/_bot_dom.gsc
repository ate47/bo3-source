#using scripts/mp/bots/_bot_combat;
#using scripts/mp/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/_bot;
#using scripts/mp/gametypes/dom;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/array_shared;

#namespace namespace_5f1d8415;

// Namespace namespace_5f1d8415
// Params 0, eflags: 0x1 linked
// namespace_5f1d8415<file_0>::function_c35e6aab
// Checksum 0xfcd9eb92, Offset: 0x188
// Size: 0x64
function init() {
    level.var_201ee8f = &function_7ec247b0;
    level.var_110e31eb = &function_9fd498fd;
    level.var_1a99051e = &function_5a6e5507;
    level.var_ce074aba = &function_eeb4665;
}

// Namespace namespace_5f1d8415
// Params 0, eflags: 0x1 linked
// namespace_5f1d8415<file_0>::function_7ec247b0
// Checksum 0x72bfab5b, Offset: 0x1f8
// Size: 0x114
function function_7ec247b0() {
    self.bot.var_ec78246 = self function_63001052();
    self.bot.goalflag = undefined;
    if (!self function_4fe3ba2d()) {
        foreach (flag in level.domflags) {
            if (self bot::function_d52328ef(flag.trigger)) {
                self.bot.goalflag = flag;
                break;
            }
        }
    }
    self bot::function_7ec247b0();
}

// Namespace namespace_5f1d8415
// Params 0, eflags: 0x1 linked
// namespace_5f1d8415<file_0>::function_9fd498fd
// Checksum 0x18c9a380, Offset: 0x318
// Size: 0x94
function function_9fd498fd() {
    if (!self namespace_5cd60c9f::function_231137e6() && isdefined(self.bot.goalflag) && self.bot.goalflag gameobjects::get_owner_team() == self.team) {
        self function_b4a0b3c5(self.origin);
    }
    self namespace_5cd60c9f::function_aff9cbcb();
}

// Namespace namespace_5f1d8415
// Params 0, eflags: 0x1 linked
// namespace_5f1d8415<file_0>::function_eeb4665
// Checksum 0xba0aca38, Offset: 0x3b8
// Size: 0xc4
function function_eeb4665() {
    if (isdefined(self.bot.var_ec78246)) {
        self bot::function_1f0a2676(self.bot.var_ec78246.trigger);
        return;
    }
    bestflag = function_4b02b46d();
    if (isdefined(bestflag)) {
        self bot::function_1b1a0f98(bestflag.trigger);
        self bot::sprint_to_goal();
        return;
    }
    self bot::function_eeb4665();
}

// Namespace namespace_5f1d8415
// Params 0, eflags: 0x1 linked
// namespace_5f1d8415<file_0>::function_5a6e5507
// Checksum 0x8234aba5, Offset: 0x488
// Size: 0x74
function function_5a6e5507() {
    if (isdefined(self.bot.var_ec78246)) {
        if (self function_4fe3ba2d()) {
            self bot::function_1f0a2676(self.bot.var_ec78246.trigger);
        }
        return;
    }
    self namespace_5cd60c9f::function_22585c05();
}

// Namespace namespace_5f1d8415
// Params 0, eflags: 0x1 linked
// namespace_5f1d8415<file_0>::function_63001052
// Checksum 0xdce622e0, Offset: 0x508
// Size: 0xc4
function function_63001052() {
    foreach (flag in level.domflags) {
        if (self.team != flag gameobjects::get_owner_team() && self istouching(flag.trigger)) {
            return flag;
        }
    }
    return undefined;
}

// Namespace namespace_5f1d8415
// Params 0, eflags: 0x1 linked
// namespace_5f1d8415<file_0>::function_4b02b46d
// Checksum 0x190a3d78, Offset: 0x5d8
// Size: 0x15e
function function_4b02b46d() {
    bestflag = undefined;
    var_6b3ccca1 = undefined;
    foreach (flag in level.domflags) {
        ownerteam = flag gameobjects::get_owner_team();
        contested = flag gameobjects::get_num_touching_except_team(ownerteam);
        distsq = distance2dsquared(self.origin, flag.origin);
        if (ownerteam == self.team && !contested) {
            continue;
        }
        if (!isdefined(bestflag) || distsq < var_6b3ccca1) {
            bestflag = flag;
            var_6b3ccca1 = distsq;
        }
    }
    return bestflag;
}

