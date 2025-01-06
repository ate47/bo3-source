#using scripts/mp/_util;
#using scripts/mp/bots/_bot;
#using scripts/mp/teams/_teams;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/bot_buttons;
#using scripts/shared/bots/bot_traversals;
#using scripts/shared/callbacks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace namespace_898f98f0;

// Namespace namespace_898f98f0
// Params 0, eflags: 0x0
// Checksum 0x91a05a89, Offset: 0x1e8
// Size: 0x32
function init() {
    level.var_ce074aba = &function_eeb4665;
    level.var_110e31eb = &function_9fd498fd;
}

// Namespace namespace_898f98f0
// Params 0, eflags: 0x0
// Checksum 0x2eabdfe, Offset: 0x228
// Size: 0x115
function function_9fd498fd() {
    if (isdefined(self.carryobject)) {
        goal = level.ball_goals[util::getotherteam(self.team)];
        if (!self function_2b2bd09f()) {
            self function_b4a0b3c5(goal.trigger.origin);
            self bot::sprint_to_goal();
            return;
        }
        if (!self isonground()) {
            return;
        }
        radius = 300;
        radiussq = radius * radius;
        if (distance2dsquared(self.origin, goal.trigger.origin) <= radiussq) {
            if (self function_26f6bab1() >= 1) {
                self thread bot::jump_to(goal.trigger.origin);
            }
        }
    }
}

// Namespace namespace_898f98f0
// Params 0, eflags: 0x0
// Checksum 0xaf4a1dfe, Offset: 0x348
// Size: 0xea
function function_eeb4665() {
    triggers = [];
    foreach (ball in level.balls) {
        if (!isdefined(ball.carrier) && !ball.in_goal) {
            triggers[triggers.size] = ball.trigger;
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

