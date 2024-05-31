#using scripts/codescripts/struct;

#namespace namespace_5fc59ced;

// Namespace namespace_5fc59ced
// Params 0, eflags: 0x1 linked
// namespace_5fc59ced<file_0>::function_c35e6aab
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

// Namespace namespace_5fc59ced
// Params 0, eflags: 0x1 linked
// namespace_5fc59ced<file_0>::function_c66f3f44
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

