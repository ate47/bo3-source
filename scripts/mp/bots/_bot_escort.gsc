#using scripts/mp/_util;
#using scripts/mp/teams/_teams;
#using scripts/shared/bots/bot_buttons;
#using scripts/shared/bots/bot_traversals;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/_bot;
#using scripts/mp/bots/_bot;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;

#namespace namespace_ebd80b8b;

// Namespace namespace_ebd80b8b
// Params 0, eflags: 0x1 linked
// Checksum 0x11dcaeac, Offset: 0x1f8
// Size: 0x1c
function init() {
    level.var_ce074aba = &function_eeb4665;
}

// Namespace namespace_ebd80b8b
// Params 0, eflags: 0x1 linked
// Checksum 0xe007fe44, Offset: 0x220
// Size: 0x4c
function function_eeb4665() {
    if (self.team == game["attackers"]) {
        self function_69879c50();
        return;
    }
    self function_16ce4b24();
}

// Namespace namespace_ebd80b8b
// Params 0, eflags: 0x1 linked
// Checksum 0x8b74385b, Offset: 0x278
// Size: 0xec
function function_69879c50() {
    if (level.robot.active || isdefined(level.moveobject) && level.rebootplayers > 0) {
        if (!level.robot.moving || math::cointoss()) {
            self bot::function_1f0a2676(level.moveobject.trigger);
        } else {
            self bot::function_8c37e5e2(level.moveobject.trigger.origin, -96, 400);
        }
        self bot::sprint_to_goal();
        return;
    }
    self bot::function_eeb4665();
}

// Namespace namespace_ebd80b8b
// Params 0, eflags: 0x1 linked
// Checksum 0x203a2cfe, Offset: 0x370
// Size: 0x84
function function_16ce4b24() {
    if (isdefined(level.moveobject) && level.robot.active) {
        self bot::function_8c37e5e2(level.moveobject.trigger.origin, -96, 400);
        self bot::sprint_to_goal();
        return;
    }
    self bot::function_eeb4665();
}

