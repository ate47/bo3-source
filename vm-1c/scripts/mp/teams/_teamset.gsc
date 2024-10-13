#using scripts/codescripts/struct;

#namespace _teamset;

// Namespace _teamset
// Params 0, eflags: 0x1 linked
// Checksum 0x2dc6ed52, Offset: 0x120
// Size: 0x82
function init() {
    if (!isdefined(game["flagmodels"])) {
        game["flagmodels"] = [];
    }
    if (!isdefined(game["carry_flagmodels"])) {
        game["carry_flagmodels"] = [];
    }
    if (!isdefined(game["carry_icon"])) {
        game["carry_icon"] = [];
    }
    game["flagmodels"]["neutral"] = "p7_mp_flag_neutral";
}

// Namespace _teamset
// Params 0, eflags: 0x1 linked
// Checksum 0x6aa0c88e, Offset: 0x1b0
// Size: 0xb4
function customteam_init() {
    if (getdvarstring("g_customTeamName_Allies") != "") {
        setdvar("g_TeamName_Allies", getdvarstring("g_customTeamName_Allies"));
    }
    if (getdvarstring("g_customTeamName_Axis") != "") {
        setdvar("g_TeamName_Axis", getdvarstring("g_customTeamName_Axis"));
    }
}

