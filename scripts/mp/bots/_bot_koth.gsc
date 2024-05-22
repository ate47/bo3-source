#using scripts/mp/bots/_bot_combat;
#using scripts/mp/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/_bot;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/array_shared;

#namespace namespace_366cf615;

// Namespace namespace_366cf615
// Params 0, eflags: 0x1 linked
// Checksum 0x3fa050e8, Offset: 0x148
// Size: 0x4c
function init() {
    level.onbotspawned = &on_bot_spawned;
    level.var_1a99051e = &function_5a6e5507;
    level.var_ce074aba = &function_eeb4665;
}

// Namespace namespace_366cf615
// Params 0, eflags: 0x1 linked
// Checksum 0x7f53e294, Offset: 0x1a0
// Size: 0x34
function on_bot_spawned() {
    self thread function_66c53beb();
    self bot::on_bot_spawned();
}

// Namespace namespace_366cf615
// Params 0, eflags: 0x1 linked
// Checksum 0x23fee3f3, Offset: 0x1e0
// Size: 0x80
function function_66c53beb() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        level waittill(#"zone_moved");
        if (!self namespace_5cd60c9f::function_231137e6() && self function_2b2bd09f()) {
            self function_b4a0b3c5(self.origin);
        }
    }
}

// Namespace namespace_366cf615
// Params 0, eflags: 0x1 linked
// Checksum 0x8c2b8aae, Offset: 0x268
// Size: 0x9c
function function_5a6e5507() {
    if (isdefined(level.zone) && self istouching(level.zone.gameobject.trigger)) {
        if (self function_4fe3ba2d()) {
            self bot::function_1f0a2676(level.zone.gameobject.trigger);
        }
        return;
    }
    self namespace_5cd60c9f::function_22585c05();
}

// Namespace namespace_366cf615
// Params 0, eflags: 0x1 linked
// Checksum 0x4a08fd45, Offset: 0x310
// Size: 0xcc
function function_eeb4665() {
    if (isdefined(level.zone)) {
        if (self istouching(level.zone.gameobject.trigger)) {
            self bot::function_1f0a2676(level.zone.gameobject.trigger);
            return;
        }
        self bot::function_1b1a0f98(level.zone.gameobject.trigger);
        self bot::sprint_to_goal();
        return;
    }
    self bot::function_eeb4665();
}

