#using scripts/mp/_util;
#using scripts/mp/bots/_bot;
#using scripts/mp/bots/_bot_combat;
#using scripts/mp/gametypes/ctf;
#using scripts/shared/array_shared;
#using scripts/shared/bots/_bot;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace namespace_6f2d2560;

// Namespace namespace_6f2d2560
// Params 0, eflags: 0x0
// Checksum 0x4cd32ec, Offset: 0x1a0
// Size: 0x32
function init() {
    level.onbotconnect = &on_bot_connect;
    level.var_ce074aba = &function_eeb4665;
}

// Namespace namespace_6f2d2560
// Params 0, eflags: 0x0
// Checksum 0x99650cba, Offset: 0x1e0
// Size: 0xa2
function on_bot_connect() {
    foreach (flag in level.flags) {
        if (flag gameobjects::get_owner_team() == self.team) {
            self.bot.flag = flag;
            continue;
        }
        self.bot.enemyflag = flag;
    }
    self bot::on_bot_connect();
}

// Namespace namespace_6f2d2560
// Params 0, eflags: 0x0
// Checksum 0x13ff1f25, Offset: 0x290
// Size: 0x18a
function function_eeb4665() {
    carrier = self.bot.enemyflag gameobjects::get_carrier();
    if (isdefined(carrier) && carrier == self) {
        self bot::function_1b1a0f98(self.bot.flag.flagbase.trigger);
        self bot::sprint_to_goal();
        return;
    } else if (self.bot.flag gameobjects::is_object_away_from_home()) {
        var_97f0918d = self.bot.flag gameobjects::get_carrier();
        if (isdefined(var_97f0918d)) {
            self bot::function_8c37e5e2(var_97f0918d.origin, -6, 1000, -128);
            self bot::sprint_to_goal();
            return;
        } else {
            self function_b4a0b3c5(self.bot.flag.trigger.origin);
            self bot::sprint_to_goal();
            return;
        }
    } else if (!isdefined(carrier)) {
        self bot::function_1b1a0f98(self.bot.enemyflag.trigger);
        self bot::sprint_to_goal();
        return;
    }
    self bot::function_eeb4665();
}

