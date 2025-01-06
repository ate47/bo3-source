#using scripts/mp/bots/_bot;
#using scripts/mp/bots/_bot_combat;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/bots/bot_buttons;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace namespace_8d1d9f92;

// Namespace namespace_8d1d9f92
// Params 0, eflags: 0x0
// Checksum 0xfe20f631, Offset: 0x1c8
// Size: 0x1c
function init() {
    level.var_ce074aba = &function_eeb4665;
}

// Namespace namespace_8d1d9f92
// Params 0, eflags: 0x0
// Checksum 0x4c5c965d, Offset: 0x1f0
// Size: 0x544
function function_eeb4665() {
    if (!level.bombplanted && !level.multibomb && self.team == game["attackers"]) {
        carrier = level.sdbomb gameobjects::get_carrier();
        if (!isdefined(carrier)) {
            self function_b4a0b3c5(level.sdbomb.trigger.origin);
            self bot::sprint_to_goal();
            return;
        }
    }
    var_2612beb3 = 562500;
    foreach (zone in level.bombzones) {
        if (isdefined(level.bombplanted) && level.bombplanted && !(isdefined(zone.isplanted) && zone.isplanted)) {
            continue;
        }
        zonetrigger = self function_11d53bed(zone);
        if (self istouching(zonetrigger)) {
            if (self function_48256f6b(zone) || self function_68c2701e(zone)) {
                self bot::function_8fa389fd();
                return;
            }
        }
        if (distancesquared(self.origin, zone.trigger.origin) < var_2612beb3) {
            if (self function_48256f6b(zone) || self function_68c2701e(zone)) {
                self bot::function_a5d97b55(zonetrigger);
                self bot::sprint_to_goal();
                return;
            }
        }
    }
    zones = array::randomize(level.bombzones);
    foreach (zone in zones) {
        if (isdefined(level.bombplanted) && level.bombplanted && !(isdefined(zone.isplanted) && zone.isplanted)) {
            continue;
        }
        if (self function_68c2701e(zone)) {
            self bot::function_1b1a0f98(zonetrigger, 750);
            self bot::sprint_to_goal();
            return;
        }
    }
    foreach (zone in zones) {
        if (isdefined(level.bombplanted) && level.bombplanted && !(isdefined(zone.isplanted) && zone.isplanted)) {
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

// Namespace namespace_8d1d9f92
// Params 1, eflags: 0x0
// Checksum 0xa5c6b1d4, Offset: 0x740
// Size: 0x4e
function function_11d53bed(zone) {
    if (self.team == zone gameobjects::get_owner_team()) {
        return zone.bombdefusetrig;
    }
    return zone.trigger;
}

// Namespace namespace_8d1d9f92
// Params 1, eflags: 0x0
// Checksum 0x9b949b38, Offset: 0x798
// Size: 0x92
function function_48256f6b(zone) {
    if (level.multibomb) {
        return (!(isdefined(zone.isplanted) && zone.isplanted) && self.team != zone gameobjects::get_owner_team());
    }
    carrier = level.sdbomb gameobjects::get_carrier();
    return isdefined(carrier) && self == carrier;
}

// Namespace namespace_8d1d9f92
// Params 1, eflags: 0x0
// Checksum 0x5d98de95, Offset: 0x838
// Size: 0x54
function function_68c2701e(zone) {
    return isdefined(zone.isplanted) && zone.isplanted && self.team == zone gameobjects::get_owner_team();
}

