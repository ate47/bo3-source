#using scripts/shared/killstreaks_shared;
#using scripts/shared/bots/bot_traversals;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/_bot;
#using scripts/mp/bots/_bot;
#using scripts/mp/_util;
#using scripts/shared/weapons/_weapons;
#using scripts/shared/weapons/_weapon_utils;
#using scripts/shared/weapons_shared;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/array_shared;

#namespace namespace_5cd60c9f;

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// namespace_5cd60c9f<file_0>::function_975133a0
// Checksum 0x7462de04, Offset: 0x258
// Size: 0x48
function function_975133a0(entity) {
    if (function_252e5e7f(entity) && !self bot::has_launcher()) {
        return true;
    }
    return false;
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// namespace_5cd60c9f<file_0>::function_aff9cbcb
// Checksum 0x1ea39ef, Offset: 0x2a8
// Size: 0x13c
function function_aff9cbcb() {
    self function_9fd498fd();
    if (self isreloading() || self isswitchingweapons() || self isthrowinggrenade() || self ismeleeing() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked()) {
        return;
    }
    if (self function_231137e6()) {
        self function_e891ab0f();
        return;
    }
    if (self switch_weapon()) {
        return;
    }
    if (self reload_weapon()) {
        return;
    }
    self bot::use_killstreak();
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// namespace_5cd60c9f<file_0>::function_76d00bea
// Checksum 0xfb8dc5, Offset: 0x3f0
// Size: 0x1e4
function function_76d00bea() {
    if (!isdefined(level.dogtags)) {
        return;
    }
    if (isdefined(self.bot.var_a0f31e50)) {
        if (!self.bot.var_a0f31e50 gameobjects::can_interact_with(self)) {
            self.bot.var_a0f31e50 = undefined;
            if (!self function_231137e6() && self function_2b2bd09f()) {
                self function_b4a0b3c5(self.origin);
            }
        } else if (!self.bot.var_9e331c3e && !self function_231137e6() && self isonground() && distance2dsquared(self.origin, self.bot.var_a0f31e50.origin) < 16384 && self botsighttrace(self.bot.var_a0f31e50)) {
            self thread bot::jump_to(self.bot.var_a0f31e50.origin);
        }
        return;
    }
    if (!self function_2b2bd09f()) {
        closesttag = self get_closest_tag();
        if (isdefined(closesttag)) {
            self function_e48903b6(closesttag);
        }
    }
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// namespace_5cd60c9f<file_0>::function_252e5e7f
// Checksum 0x35148488, Offset: 0x5e0
// Size: 0x100
function function_252e5e7f(enemy) {
    if (!isdefined(enemy) || isplayer(enemy)) {
        return false;
    }
    killstreaktype = undefined;
    if (isdefined(enemy.killstreaktype)) {
        killstreaktype = enemy.killstreaktype;
    } else if (isdefined(enemy.parentstruct) && isdefined(enemy.parentstruct.killstreaktype)) {
        killstreaktype = enemy.parentstruct.killstreaktype;
    }
    if (!isdefined(killstreaktype)) {
        return false;
    }
    switch (killstreaktype) {
    case 0:
    case 1:
    case 2:
    case 3:
        return true;
    }
    return false;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// namespace_5cd60c9f<file_0>::function_3898a2e
// Checksum 0x998272b4, Offset: 0x6e8
// Size: 0xc
function function_3898a2e(origin) {
    
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// namespace_5cd60c9f<file_0>::function_5b3d70aa
// Checksum 0x986bdb02, Offset: 0x700
// Size: 0xc
function function_5b3d70aa(origin) {
    
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// namespace_5cd60c9f<file_0>::function_bcc19909
// Checksum 0xdc59b920, Offset: 0x718
// Size: 0xc
function function_bcc19909(origin) {
    
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// namespace_5cd60c9f<file_0>::function_2bbe6c14
// Checksum 0x3baad24e, Offset: 0x730
// Size: 0xc
function function_2bbe6c14(origin) {
    
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// namespace_5cd60c9f<file_0>::function_47da49a4
// Checksum 0xdaf54bc3, Offset: 0x748
// Size: 0xc
function function_47da49a4(origin) {
    
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// namespace_5cd60c9f<file_0>::function_4e67699e
// Checksum 0xaee3877d, Offset: 0x760
// Size: 0xc
function function_4e67699e(origin) {
    
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// namespace_5cd60c9f<file_0>::function_f7a55431
// Checksum 0x1725caee, Offset: 0x778
// Size: 0xe
function function_f7a55431(origin) {
    return false;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// namespace_5cd60c9f<file_0>::function_ad0c6168
// Checksum 0x861e3db8, Offset: 0x790
// Size: 0xe
function nearest_node(origin) {
    return undefined;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x0
// namespace_5cd60c9f<file_0>::function_fbd9ba9a
// Checksum 0x17d8c4f5, Offset: 0x7a8
// Size: 0x22
function function_fbd9ba9a(origin) {
    return bot::fwd_dot(origin);
}

// Namespace namespace_5cd60c9f
// Params 0, eflags: 0x1 linked
// namespace_5cd60c9f<file_0>::function_436740be
// Checksum 0xc103bceb, Offset: 0x7d8
// Size: 0x118
function get_closest_tag() {
    closesttag = undefined;
    var_2ca98c16 = undefined;
    foreach (tag in level.dogtags) {
        if (!tag gameobjects::can_interact_with(self)) {
            continue;
        }
        distsq = distancesquared(self.origin, tag.origin);
        if (!isdefined(closesttag) || distsq < var_2ca98c16) {
            closesttag = tag;
            var_2ca98c16 = distsq;
        }
    }
    return closesttag;
}

// Namespace namespace_5cd60c9f
// Params 1, eflags: 0x1 linked
// namespace_5cd60c9f<file_0>::function_e48903b6
// Checksum 0xbeb4ce61, Offset: 0x8f8
// Size: 0xec
function function_e48903b6(tag) {
    self.bot.var_a0f31e50 = tag;
    tracestart = tag.origin;
    traceend = tag.origin + (0, 0, -64);
    trace = bullettrace(tracestart, traceend, 0, undefined);
    self.bot.var_9e331c3e = trace["fraction"] < 1;
    self bot::function_a5d97b55(tag.trigger);
    self bot::sprint_to_goal();
}

