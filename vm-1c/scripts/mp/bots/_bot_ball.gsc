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

#namespace namespace_898f98f0;

// Namespace namespace_898f98f0
// Params 0, eflags: 0x1 linked
// Checksum 0xd96c8b0b, Offset: 0x208
// Size: 0x4c
function init() {
    level.var_ce074aba = &function_eeb4665;
    level.var_66a90634 = &function_5cd60c9f;
    level.var_110e31eb = &function_9fd498fd;
}

// Namespace namespace_898f98f0
// Params 0, eflags: 0x1 linked
// Checksum 0xda2bf4d, Offset: 0x260
// Size: 0x7c
function function_f14e371a() {
    self endon(#"death");
    level endon(#"game_ended");
    while (self isonground()) {
        wait(0.05);
    }
    while (!self isonground()) {
        wait(0.05);
    }
    self botreleasemanualcontrol();
}

// Namespace namespace_898f98f0
// Params 0, eflags: 0x1 linked
// Checksum 0x1ca59796, Offset: 0x2e8
// Size: 0x18c
function function_9fd498fd() {
    if (isdefined(self.carryobject)) {
        if (self isonground() && self function_2b2bd09f()) {
            goal = level.ball_goals[util::getotherteam(self.team)];
            radius = 300;
            radiussq = radius * radius;
            if (distance2dsquared(self.origin, goal.trigger.origin) <= radiussq) {
                if (self botsighttrace(goal.trigger)) {
                    self bottakemanualcontrol();
                    self thread bot::jump_to(goal.trigger.origin);
                    self thread function_f14e371a();
                    return;
                }
            }
        }
        if (!self ismeleeing()) {
            self bot::use_killstreak();
        }
        return;
    }
    self namespace_5cd60c9f::function_aff9cbcb();
}

// Namespace namespace_898f98f0
// Params 0, eflags: 0x1 linked
// Checksum 0xe169ed02, Offset: 0x480
// Size: 0x15c
function function_5cd60c9f() {
    if (isdefined(self.carryobject)) {
        if (self namespace_5cd60c9f::function_231137e6()) {
            self namespace_5cd60c9f::function_dc473bdb();
        }
        var_fc1e100f = namespace_5cd60c9f::function_9c78ebae(level.var_93fffa7b.meleerange);
        if (isdefined(var_fc1e100f)) {
            angles = self getplayerangles();
            fwd = anglestoforward(angles);
            var_a0e8586a = var_fc1e100f.origin - self.origin;
            var_a0e8586a = vectornormalize(var_a0e8586a);
            dot = vectordot(fwd, var_a0e8586a);
            if (dot > level.var_93fffa7b.var_d7047444) {
                self bot::function_6e37f7f0();
            }
        }
        return;
    }
    self namespace_5cd60c9f::function_a859fd70();
}

// Namespace namespace_898f98f0
// Params 0, eflags: 0x1 linked
// Checksum 0x1a9ac30f, Offset: 0x5e8
// Size: 0x29c
function function_eeb4665() {
    if (isdefined(self.carryobject)) {
        if (!self function_2b2bd09f()) {
            goal = level.ball_goals[util::getotherteam(self.team)];
            goalpoint = goal.origin - (0, 0, 125);
            self bot::function_8c37e5e2(goalpoint);
            self bot::sprint_to_goal();
        }
        return;
    }
    triggers = [];
    balls = array::randomize(level.balls);
    foreach (ball in balls) {
        if (!isdefined(ball.carrier) && !ball.in_goal) {
            triggers[triggers.size] = ball.trigger;
            continue;
        }
        if (isdefined(ball.carrier) && ball.carrier.team != self.team) {
            self bot::function_8c37e5e2(ball.carrier.origin, -6, 1000, -128);
            self bot::sprint_to_goal();
            return;
        }
    }
    if (triggers.size > 0) {
        triggers = arraysort(triggers, self.origin);
        self function_b4a0b3c5(triggers[0].origin);
        self bot::sprint_to_goal();
        return;
    }
    self bot::function_eeb4665();
}

