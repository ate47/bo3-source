#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace scoreboard;

// Namespace scoreboard
// Params 0, eflags: 0x2
// Checksum 0x3e9d66a0, Offset: 0x210
// Size: 0x34
function function_2dc19561() {
    system::register("scoreboard", &__init__, undefined, undefined);
}

// Namespace scoreboard
// Params 0, eflags: 0x1 linked
// Checksum 0xd9487392, Offset: 0x250
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&main);
}

// Namespace scoreboard
// Params 0, eflags: 0x1 linked
// Checksum 0x47a2e9cc, Offset: 0x280
// Size: 0x194
function main() {
    setdvar("g_ScoresColor_Spectator", ".25 .25 .25");
    setdvar("g_ScoresColor_Free", ".76 .78 .10");
    setdvar("g_teamColor_MyTeam", ".4 .7 .4");
    setdvar("g_teamColor_EnemyTeam", "1 .315 0.35");
    setdvar("g_teamColor_MyTeamAlt", ".35 1 1");
    setdvar("g_teamColor_EnemyTeamAlt", "1 .5 0");
    setdvar("g_teamColor_Squad", ".315 0.35 1");
    if (sessionmodeiszombiesgame()) {
        setdvar("g_TeamIcon_Axis", "faction_cia");
        setdvar("g_TeamIcon_Allies", "faction_cdc");
        return;
    }
    setdvar("g_TeamIcon_Axis", game["icons"]["axis"]);
    setdvar("g_TeamIcon_Allies", game["icons"]["allies"]);
}

