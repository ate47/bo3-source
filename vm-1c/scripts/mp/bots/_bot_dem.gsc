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
// Checksum 0x29839e8e, Offset: 0x190
// Size: 0x4c
function init() {
    level.var_ce074aba = &function_eeb4665;
    level.var_66a90634 = &function_a859fd70;
    level.var_1a85a65e = &function_211bcdc;
}

// Namespace namespace_c34670eb
// Params 0, eflags: 0x0
// Checksum 0xdbd5f61f, Offset: 0x1e8
// Size: 0x46c
function function_eeb4665() {
    var_2612beb3 = 562500;
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
        if (distancesquared(self.origin, zone.trigger.origin) < var_2612beb3) {
            if (self function_48256f6b(zone) || self function_68c2701e(zone)) {
                self bot::function_a5d97b55(zone.trigger);
                self bot::sprint_to_goal();
                return;
            }
        }
    }
    zones = array::randomize(level.bombzones);
    foreach (zone in zones) {
        if (isdefined(zone.bombexploded) && zone.bombexploded) {
            continue;
        }
        if (self function_68c2701e(zone) && randomint(100) < 70) {
            self bot::function_1b1a0f98(zone.trigger, 750);
            self bot::sprint_to_goal();
            return;
        }
    }
    foreach (zone in zones) {
        if (isdefined(zone.bombexploded) && zone.bombexploded) {
            continue;
        }
        if (distancesquared(self.origin, zone.trigger.origin) < var_2612beb3 && randomint(100) < 70) {
            triggerradius = self bot::function_cf3a14ef(zone.trigger);
            self bot::function_8c37e5e2(zone.trigger.origin, triggerradius, 750);
            self bot::sprint_to_goal();
            return;
        }
    }
    self bot::function_eeb4665();
}

// Namespace namespace_c34670eb
// Params 1, eflags: 0x0
// Checksum 0x3e95b6fb, Offset: 0x660
// Size: 0x54
function function_48256f6b(zone) {
    return !(isdefined(zone.bombplanted) && zone.bombplanted) && self.team != zone gameobjects::get_owner_team();
}

// Namespace namespace_c34670eb
// Params 1, eflags: 0x0
// Checksum 0x8cb6cdca, Offset: 0x6c0
// Size: 0x54
function function_68c2701e(zone) {
    return isdefined(zone.bombplanted) && zone.bombplanted && self.team == zone gameobjects::get_owner_team();
}

// Namespace namespace_c34670eb
// Params 0, eflags: 0x0
// Checksum 0x18c6cae4, Offset: 0x720
// Size: 0x4c
function function_a859fd70() {
    if (isdefined(self.isdefusing) && (isdefined(self.isplanting) && self.isplanting || self.isdefusing)) {
        return;
    }
    self namespace_5cd60c9f::function_a859fd70();
}

// Namespace namespace_c34670eb
// Params 0, eflags: 0x0
// Checksum 0x309587f4, Offset: 0x778
// Size: 0x134
function function_211bcdc() {
    var_2612beb3 = 562500;
    foreach (zone in level.bombzones) {
        if (isdefined(zone.bombexploded) && zone.bombexploded) {
            continue;
        }
        if (distancesquared(self.origin, zone.trigger.origin) < var_2612beb3) {
            if (self function_48256f6b(zone) || self function_68c2701e(zone)) {
                return;
            }
        }
    }
    self namespace_5cd60c9f::function_2322b744();
}

