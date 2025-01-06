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

#namespace namespace_ebd80b8b;

// Namespace namespace_ebd80b8b
// Params 0, eflags: 0x0
// Checksum 0xb3ccf6b4, Offset: 0x1f8
// Size: 0x1a
function init() {
    level.var_ce074aba = &function_eeb4665;
}

// Namespace namespace_ebd80b8b
// Params 0, eflags: 0x0
// Checksum 0x3b12acb7, Offset: 0x220
// Size: 0x11
function function_eeb4665() {
    InvalidOpCode(0x54, "attackers", self.team);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace namespace_ebd80b8b
// Params 0, eflags: 0x0
// Checksum 0x6dad9c8b, Offset: 0x268
// Size: 0x62
function function_69879c50() {
    if (isdefined(level.moveobject) && level.robot.active) {
        self bot::function_1f0a2676(level.moveobject.trigger);
        self bot::sprint_to_goal();
        return;
    }
    self bot::function_eeb4665();
}

// Namespace namespace_ebd80b8b
// Params 0, eflags: 0x0
// Checksum 0xb5567d73, Offset: 0x2d8
// Size: 0x62
function function_16ce4b24() {
    if (isdefined(level.moveobject) && level.robot.active) {
        self bot::function_1f0a2676(level.moveobject.trigger);
        self bot::sprint_to_goal();
        return;
    }
    self bot::function_eeb4665();
}

