#using scripts/codescripts/struct;
#using scripts/mp/teams/_teamset;

#namespace _teamset_axis;

// Namespace _teamset_axis
// Params 0, eflags: 0x0
// Checksum 0x14dd027b, Offset: 0x2b8
// Size: 0x3a
function main() {
    init("axis");
    _teamset::customteam_init();
    precache();
}

// Namespace _teamset_axis
// Params 1, eflags: 0x0
// Checksum 0x50a8eb73, Offset: 0x300
// Size: 0x23
function init(team) {
    _teamset::init();
    InvalidOpCode(0xc8, team, "axis");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace _teamset_axis
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x568
// Size: 0x2
function precache() {
    
}

