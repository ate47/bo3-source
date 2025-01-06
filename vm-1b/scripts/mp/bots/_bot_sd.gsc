#using scripts/mp/bots/_bot;
#using scripts/mp/bots/_bot_combat;
#using scripts/mp/bots/_bot_dem;
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
// Checksum 0x656749f2, Offset: 0x1e8
// Size: 0x1a
function init() {
    level.var_ce074aba = &function_eeb4665;
}

// Namespace namespace_8d1d9f92
// Params 0, eflags: 0x0
// Checksum 0x72f4ffcc, Offset: 0x210
// Size: 0x31
function function_eeb4665() {
    if (level.multibomb) {
        self namespace_c34670eb::function_eeb4665();
        return;
    }
    InvalidOpCode(0x54, "attackers", self.team);
    // Unknown operator (0x54, t7_1b, PC)
}

