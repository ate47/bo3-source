#using scripts/codescripts/struct;
#using scripts/mp/teams/_teamset;

#namespace _teamset_allies;

// Namespace _teamset_allies
// Params 0, eflags: 0x0
// Checksum 0xd060d6fe, Offset: 0x2f8
// Size: 0xaa
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
// Params 1, eflags: 0x0
// Checksum 0xc5bdcd79, Offset: 0x3b0
// Size: 0x23
function init(team) {
    _teamset::init();
    InvalidOpCode(0xc8, team, "allies");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace _teamset_allies
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x618
// Size: 0x2
function precache() {
    
}

