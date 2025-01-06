#using scripts/mp/bots/_bot;
#using scripts/mp/bots/_bot_combat;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/bot_buttons;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace namespace_c34670eb;

// Namespace namespace_c34670eb
// Params 0, eflags: 0x0
// Checksum 0x61ac6878, Offset: 0x190
// Size: 0x1a
function init() {
    level.var_ce074aba = &function_eeb4665;
}

// Namespace namespace_c34670eb
// Params 0, eflags: 0x0
// Checksum 0xb9175ffd, Offset: 0x1b8
// Size: 0x23a
function function_eeb4665() {
    foreach (zone in level.bombzones) {
        if (isdefined(zone.bombexploded) && zone.bombexploded) {
            continue;
        }
        if (self istouching(zone.trigger)) {
            if (self function_48256f6b(zone) || self function_68c2701e(zone)) {
                self bot::function_8fa389fd();
                return;
            }
        }
    }
    zones = array::randomize(level.bombzones);
    foreach (zone in zones) {
        if (isdefined(zone.bombexploded) && zone.bombexploded) {
            continue;
        }
        if (self function_48256f6b(zone) || self function_68c2701e(zone)) {
            self bot::function_a5d97b55(zone.trigger);
            self bot::sprint_to_goal();
            return;
        }
    }
    foreach (zone in zones) {
        if (isdefined(zone.bombexploded) && zone.bombexploded) {
            continue;
        }
        self bot::function_1b1a0f98(zone.trigger);
        self bot::sprint_to_goal();
        return;
    }
    self bot::function_eeb4665();
}

// Namespace namespace_c34670eb
// Params 1, eflags: 0x0
// Checksum 0xc53ae473, Offset: 0x400
// Size: 0x42
function function_48256f6b(zone) {
    return !(isdefined(zone.bombplanted) && zone.bombplanted) && self.team != zone gameobjects::get_owner_team();
}

// Namespace namespace_c34670eb
// Params 1, eflags: 0x0
// Checksum 0xe667d65e, Offset: 0x450
// Size: 0x42
function function_68c2701e(zone) {
    return isdefined(zone.bombplanted) && zone.bombplanted && self.team == zone gameobjects::get_owner_team();
}

