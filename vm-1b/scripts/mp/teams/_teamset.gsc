#using scripts/codescripts/struct;

#namespace _teamset;

// Namespace _teamset
// Params 0, eflags: 0x0
// Checksum 0xc5dc5ea8, Offset: 0x120
// Size: 0x9
function init() {
    InvalidOpCode(0x54, "flagmodels");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace _teamset
// Params 0, eflags: 0x0
// Checksum 0x8ab16c3b, Offset: 0x188
// Size: 0xa2
function customteam_init() {
    if (getdvarstring("g_customTeamName_Allies") != "") {
        setdvar("g_TeamName_Allies", getdvarstring("g_customTeamName_Allies"));
    }
    if (getdvarstring("g_customTeamName_Axis") != "") {
        setdvar("g_TeamName_Axis", getdvarstring("g_customTeamName_Axis"));
    }
}

