#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace scoreboard;

// Namespace scoreboard
// Params 0, eflags: 0x2
// Checksum 0xf1b52ed3, Offset: 0x130
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("scoreboard", &__init__, undefined, undefined);
}

// Namespace scoreboard
// Params 0, eflags: 0x0
// Checksum 0xfec1ecb7, Offset: 0x170
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace scoreboard
// Params 0, eflags: 0x0
// Checksum 0xac2e88ac, Offset: 0x1a0
// Size: 0xb4
function init() {
    if (sessionmodeiszombiesgame()) {
        setdvar("g_TeamIcon_Axis", "faction_cia");
        setdvar("g_TeamIcon_Allies", "faction_cdc");
        return;
    }
    setdvar("g_TeamIcon_Axis", game["icons"]["axis"]);
    setdvar("g_TeamIcon_Allies", game["icons"]["allies"]);
}

