#using scripts/mp/teams/_teamset;
#using scripts/codescripts/struct;

#namespace namespace_d58dbe33;

// Namespace namespace_d58dbe33
// Params 0, eflags: 0x1 linked
// namespace_d58dbe33<file_0>::function_d290ebfa
// Checksum 0xd26a60ae, Offset: 0x2b8
// Size: 0x3c
function main() {
    init("axis");
    namespace_5fc59ced::customteam_init();
    precache();
}

// Namespace namespace_d58dbe33
// Params 1, eflags: 0x1 linked
// namespace_d58dbe33<file_0>::function_c35e6aab
// Checksum 0xb0e82f6a, Offset: 0x300
// Size: 0x30a
function init(team) {
    namespace_5fc59ced::init();
    game[team] = "axis";
    game["defenders"] = team;
    game["entity_headicon_" + team] = "faction_axis";
    game["headicon_" + team] = "faction_axis";
    level.teamprefix[team] = "vox_pm";
    level.teampostfix[team] = "axis";
    setdvar("g_TeamName_" + team, %MPUI_AXIS_SHORT);
    setdvar("g_FactionName_" + team, "axis");
    game["strings"][team + "_win"] = %MP_CDP_WIN_MATCH;
    game["strings"][team + "_win_round"] = %MP_CDP_WIN_ROUND;
    game["strings"][team + "_mission_accomplished"] = %MP_CDP_MISSION_ACCOMPLISHED;
    game["strings"][team + "_eliminated"] = %MP_CDP_ELIMINATED;
    game["strings"][team + "_forfeited"] = %MP_CDP_FORFEITED;
    game["strings"][team + "_name"] = %MP_CDP_NAME;
    game["music"]["spawn_" + team] = "SPAWN_PMC";
    game["music"]["spawn_short" + team] = "SPAWN_SHORT_PMC";
    game["music"]["victory_" + team] = "VICTORY_PMC";
    game["icons"][team] = "faction_axis";
    game["voice"][team] = "vox_pmc_";
    setdvar("scr_" + team, "ussr");
    level.var_7fb68eed[team]["hit"] = "vox_rus_0_kls_attackheli_hit";
    game["flagmodels"][team] = "p7_mp_flag_axis";
    game["carry_flagmodels"][team] = "p7_mp_flag_axis_carry";
    game["flagmodels"]["neutral"] = "p7_mp_flag_neutral";
}

// Namespace namespace_d58dbe33
// Params 0, eflags: 0x1 linked
// namespace_d58dbe33<file_0>::function_f7046c76
// Checksum 0x99ec1590, Offset: 0x618
// Size: 0x4
function precache() {
    
}

