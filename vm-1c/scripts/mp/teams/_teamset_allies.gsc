#using scripts/mp/teams/_teamset;
#using scripts/codescripts/struct;

#namespace _teamset_allies;

// Namespace _teamset_allies
// Params 0, eflags: 0x1 linked
// Checksum 0x5dc4ff5c, Offset: 0x2f8
// Size: 0xdc
function main() {
    init("free");
    foreach (team in level.teams) {
        if (team == "axis") {
            continue;
        }
        init(team);
    }
    _teamset::customteam_init();
    precache();
}

// Namespace _teamset_allies
// Params 1, eflags: 0x1 linked
// Checksum 0x9b5c461f, Offset: 0x3e0
// Size: 0x30a
function init(team) {
    _teamset::init();
    game[team] = "allies";
    game["attackers"] = team;
    game["entity_headicon_" + team] = "faction_allies";
    game["headicon_" + team] = "faction_allies";
    level.teamprefix[team] = "vox_st";
    level.teampostfix[team] = "st6";
    setdvar("g_TeamName_" + team, %MPUI_ALLIES_SHORT);
    setdvar("g_FactionName_" + team, "allies");
    game["strings"][team + "_win"] = %MP_BLACK_OPS_WIN_MATCH;
    game["strings"][team + "_win_round"] = %MP_BLACK_OPS_WIN_ROUND;
    game["strings"][team + "_mission_accomplished"] = %MP_BLACK_OPS_MISSION_ACCOMPLISHED;
    game["strings"][team + "_eliminated"] = %MP_BLACK_OPS_ELIMINATED;
    game["strings"][team + "_forfeited"] = %MP_BLACK_OPS_FORFEITED;
    game["strings"][team + "_name"] = %MP_BLACK_OPS_NAME;
    game["music"]["spawn_" + team] = "SPAWN_ST6";
    game["music"]["spawn_short" + team] = "SPAWN_SHORT_ST6";
    game["music"]["victory_" + team] = "VICTORY_ST6";
    game["icons"][team] = "faction_allies";
    game["voice"][team] = "vox_st6_";
    setdvar("scr_" + team, "marines");
    level.var_7fb68eed[team]["hit"] = "vox_ops_2_kls_attackheli_hit";
    game["flagmodels"][team] = "p7_mp_flag_allies";
    game["carry_flagmodels"][team] = "p7_mp_flag_allies_carry";
    game["flagmodels"]["neutral"] = "p7_mp_flag_neutral";
}

// Namespace _teamset_allies
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x6f8
// Size: 0x4
function precache() {
    
}

