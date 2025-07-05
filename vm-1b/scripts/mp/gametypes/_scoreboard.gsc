#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace scoreboard;

// Namespace scoreboard
// Params 0, eflags: 0x2
// Checksum 0x14e7ab3, Offset: 0x130
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("scoreboard", &__init__, undefined, undefined);
}

// Namespace scoreboard
// Params 0, eflags: 0x0
// Checksum 0xd38c9dc2, Offset: 0x168
// Size: 0x22
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace scoreboard
// Params 0, eflags: 0x0
// Checksum 0x32b160e7, Offset: 0x198
// Size: 0xa2
function init() {
    if (sessionmodeiszombiesgame()) {
        setdvar("g_TeamIcon_Axis", "faction_cia");
        setdvar("g_TeamIcon_Allies", "faction_cdc");
        return;
    }
    InvalidOpCode(0x54, "icons", "axis");
    // Unknown operator (0x54, t7_1b, PC)
}

