#using scripts/codescripts/struct;
#using scripts/mp/bots/_bot;
#using scripts/mp/bots/_bot_combat;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/bot_traversals;
#using scripts/shared/gameobjects_shared;

#namespace namespace_3a008251;

// Namespace namespace_3a008251
// Params 0, eflags: 0x0
// Checksum 0xe965b4ea, Offset: 0x160
// Size: 0x4a
function init() {
    level.onbotspawned = &on_bot_spawned;
    level.var_47854466 = &function_b5eda34;
    level.var_ce074aba = &function_eeb4665;
}

// Namespace namespace_3a008251
// Params 0, eflags: 0x0
// Checksum 0xab7a87a6, Offset: 0x1b8
// Size: 0x22
function on_bot_spawned() {
    self.bot.var_a0f31e50 = undefined;
    self bot::on_bot_spawned();
}

// Namespace namespace_3a008251
// Params 0, eflags: 0x0
// Checksum 0xdb9a4b19, Offset: 0x1e8
// Size: 0x12a
function function_b5eda34() {
    if (!self namespace_5cd60c9f::function_231137e6() && isdefined(self.bot.var_a0f31e50)) {
        if (!self.bot.var_a0f31e50 gameobjects::can_interact_with(self)) {
            self.bot.var_a0f31e50 = undefined;
            if (!self namespace_5cd60c9f::function_231137e6() && self function_2b2bd09f()) {
                self function_b4a0b3c5(self.origin);
            }
        } else if (self.bot.var_9e331c3e && self isonground() && distance2dsquared(self.origin, self.bot.var_a0f31e50.origin) < 16384) {
            self thread bot::jump_to(self.bot.var_a0f31e50.origin);
        }
    }
    self namespace_5cd60c9f::function_b5eda34();
}

// Namespace namespace_3a008251
// Params 0, eflags: 0x0
// Checksum 0x19ad0b58, Offset: 0x320
// Size: 0x42
function function_eeb4665() {
    closesttag = self get_closest_tag();
    if (isdefined(closesttag)) {
        self function_e48903b6(closesttag);
        return;
    }
    self bot::function_eeb4665();
}

// Namespace namespace_3a008251
// Params 0, eflags: 0x0
// Checksum 0xb1cc851e, Offset: 0x370
// Size: 0xc7
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

// Namespace namespace_3a008251
// Params 0, eflags: 0x0
// Checksum 0x887465, Offset: 0x440
// Size: 0xad
function function_646a87c2() {
    goalposition = self function_5bd0f250();
    foreach (tag in level.dogtags) {
        if (!tag gameobjects::can_interact_with(self)) {
            continue;
        }
        distsq = distancesquared(self.origin, tag.origin);
    }
}

// Namespace namespace_3a008251
// Params 1, eflags: 0x0
// Checksum 0xc323e164, Offset: 0x4f8
// Size: 0xb2
function function_e48903b6(tag) {
    self.bot.var_a0f31e50 = tag;
    tracestart = tag.origin;
    traceend = tag.origin + (0, 0, -64);
    trace = bullettrace(tracestart, traceend, 0, undefined);
    self.bot.var_9e331c3e = trace["fraction"] < 1;
    self function_b4a0b3c5(tag.origin, 32);
    self bot::sprint_to_goal();
}

