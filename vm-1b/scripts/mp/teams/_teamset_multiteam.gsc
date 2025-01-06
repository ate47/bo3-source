#using scripts/codescripts/struct;
#using scripts/mp/teams/_teamset;
#using scripts/mp/teams/_teamset_allies;
#using scripts/mp/teams/_teamset_axis;

#namespace _teamset_multiteam;

// Namespace _teamset_multiteam
// Params 0, eflags: 0x0
// Checksum 0xa9421a69, Offset: 0x460
// Size: 0xb2
function main() {
    _teamset::init();
    toggle = 0;
    foreach (team in level.teams) {
        if (toggle % 2) {
            init_axis(team);
        } else {
            init_allies(team);
        }
        toggle++;
    }
    precache();
}

// Namespace _teamset_multiteam
// Params 0, eflags: 0x0
// Checksum 0x2751408c, Offset: 0x520
// Size: 0x22
function precache() {
    _teamset_allies::precache();
    _teamset_axis::precache();
}

// Namespace _teamset_multiteam
// Params 1, eflags: 0x0
// Checksum 0x70fe1724, Offset: 0x550
// Size: 0x13
function init_allies(team) {
    InvalidOpCode(0xc8, team, "allies");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace _teamset_multiteam
// Params 1, eflags: 0x0
// Checksum 0xfce8b17e, Offset: 0x7d0
// Size: 0x13
function init_axis(team) {
    InvalidOpCode(0xc8, team, "axis");
    // Unknown operator (0xc8, t7_1b, PC)
}

