#using scripts/mp/bots/_bot;
#using scripts/mp/bots/_bot_combat;
#using scripts/mp/gametypes/dom;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace namespace_5f1d8415;

// Namespace namespace_5f1d8415
// Params 0, eflags: 0x0
// Checksum 0x64e34d8a, Offset: 0x188
// Size: 0x62
function init() {
    level.var_201ee8f = &function_7ec247b0;
    level.var_110e31eb = &function_9fd498fd;
    level.var_1a99051e = &function_5a6e5507;
    level.var_ce074aba = &function_eeb4665;
}

// Namespace namespace_5f1d8415
// Params 0, eflags: 0x0
// Checksum 0xc97ab8fa, Offset: 0x1f8
// Size: 0xda
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
// Params 0, eflags: 0x0
// Checksum 0x143fc77a, Offset: 0x2e0
// Size: 0x7a
function function_9fd498fd() {
    if (!self namespace_5cd60c9f::function_231137e6() && isdefined(self.bot.goalflag) && self.bot.goalflag gameobjects::get_owner_team() == self.team) {
        self function_b4a0b3c5(self.origin);
    }
    self namespace_5cd60c9f::function_9fd498fd();
}

// Namespace namespace_5f1d8415
// Params 0, eflags: 0x0
// Checksum 0x6c7b6dc1, Offset: 0x368
// Size: 0x9a
function function_eeb4665() {
    if (isdefined(self.bot.var_ec78246)) {
        if (randomint(100) < 10) {
            self bot::function_1f0a2676(self.bot.var_ec78246.trigger);
        }
        return;
    }
    bestflag = function_4b02b46d();
    if (isdefined(bestflag)) {
        self bot::function_1b1a0f98(bestflag.trigger);
        return;
    }
    self bot::function_eeb4665();
}

// Namespace namespace_5f1d8415
// Params 0, eflags: 0x0
// Checksum 0xa9a60263, Offset: 0x410
// Size: 0x5a
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
// Params 0, eflags: 0x0
// Checksum 0x815534e9, Offset: 0x478
// Size: 0x92
function function_63001052() {
    foreach (flag in level.domflags) {
        if (self.team != flag gameobjects::get_owner_team() && self istouching(flag.trigger)) {
            return flag;
        }
    }
    return undefined;
}

// Namespace namespace_5f1d8415
// Params 0, eflags: 0x0
// Checksum 0x86f92b8b, Offset: 0x518
// Size: 0xff
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

