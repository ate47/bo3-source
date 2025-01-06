#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_filter;

#namespace zm_island_challenges;

// Namespace zm_island_challenges
// Params 0, eflags: 0x0
// Checksum 0x6ff34a8a, Offset: 0x3c8
// Size: 0x3cc
function init() {
    var_850da4c5 = getminbitcountfornum(4);
    clientfield::register("world", "pillar_challenge_0_1", 9000, var_850da4c5, "int", &pillar_challenge_0_1, 0, 0);
    clientfield::register("world", "pillar_challenge_0_2", 9000, var_850da4c5, "int", &pillar_challenge_0_2, 0, 0);
    clientfield::register("world", "pillar_challenge_0_3", 9000, var_850da4c5, "int", &pillar_challenge_0_3, 0, 0);
    clientfield::register("world", "pillar_challenge_1_1", 9000, var_850da4c5, "int", &pillar_challenge_1_1, 0, 0);
    clientfield::register("world", "pillar_challenge_1_2", 9000, var_850da4c5, "int", &pillar_challenge_1_2, 0, 0);
    clientfield::register("world", "pillar_challenge_1_3", 9000, var_850da4c5, "int", &pillar_challenge_1_3, 0, 0);
    clientfield::register("world", "pillar_challenge_2_1", 9000, var_850da4c5, "int", &pillar_challenge_2_1, 0, 0);
    clientfield::register("world", "pillar_challenge_2_2", 9000, var_850da4c5, "int", &pillar_challenge_2_2, 0, 0);
    clientfield::register("world", "pillar_challenge_2_3", 9000, var_850da4c5, "int", &pillar_challenge_2_3, 0, 0);
    clientfield::register("world", "pillar_challenge_3_1", 9000, var_850da4c5, "int", &pillar_challenge_3_1, 0, 0);
    clientfield::register("world", "pillar_challenge_3_2", 9000, var_850da4c5, "int", &pillar_challenge_3_2, 0, 0);
    clientfield::register("world", "pillar_challenge_3_3", 9000, var_850da4c5, "int", &pillar_challenge_3_3, 0, 0);
    clientfield::register("scriptmover", "challenge_glow_fx", 9000, 2, "int", &challenge_glow_fx, 0, 0);
}

// Namespace zm_island_challenges
// Params 7, eflags: 0x0
// Checksum 0x4e5f7fdc, Offset: 0x7a0
// Size: 0xfc
function pillar_challenge_0_1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4c6172ff = getent(localclientnum, "challenge_pillar_0", "targetname");
    var_2ca030e2 = 0;
    player = getlocalplayer(localclientnum);
    if (player getentitynumber() == 0) {
        var_2ca030e2 = 1;
    }
    var_4c6172ff thread function_4aadb052(localclientnum, newval, 1, var_2ca030e2);
}

// Namespace zm_island_challenges
// Params 7, eflags: 0x0
// Checksum 0xc016f565, Offset: 0x8a8
// Size: 0xfc
function pillar_challenge_0_2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4c6172ff = getent(localclientnum, "challenge_pillar_0", "targetname");
    var_2ca030e2 = 0;
    player = getlocalplayer(localclientnum);
    if (player getentitynumber() == 0) {
        var_2ca030e2 = 1;
    }
    var_4c6172ff thread function_4aadb052(localclientnum, newval, 2, var_2ca030e2);
}

// Namespace zm_island_challenges
// Params 7, eflags: 0x0
// Checksum 0xf1448737, Offset: 0x9b0
// Size: 0xfc
function pillar_challenge_0_3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4c6172ff = getent(localclientnum, "challenge_pillar_0", "targetname");
    var_2ca030e2 = 0;
    player = getlocalplayer(localclientnum);
    if (player getentitynumber() == 0) {
        var_2ca030e2 = 1;
    }
    var_4c6172ff thread function_4aadb052(localclientnum, newval, 3, var_2ca030e2);
}

// Namespace zm_island_challenges
// Params 7, eflags: 0x0
// Checksum 0x8d043e1b, Offset: 0xab8
// Size: 0xfc
function pillar_challenge_1_1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4c6172ff = getent(localclientnum, "challenge_pillar_1", "targetname");
    var_2ca030e2 = 0;
    player = getlocalplayer(localclientnum);
    if (player getentitynumber() == 1) {
        var_2ca030e2 = 1;
    }
    var_4c6172ff thread function_4aadb052(localclientnum, newval, 1, var_2ca030e2);
}

// Namespace zm_island_challenges
// Params 7, eflags: 0x0
// Checksum 0x67b770ff, Offset: 0xbc0
// Size: 0xfc
function pillar_challenge_1_2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4c6172ff = getent(localclientnum, "challenge_pillar_1", "targetname");
    var_2ca030e2 = 0;
    player = getlocalplayer(localclientnum);
    if (player getentitynumber() == 1) {
        var_2ca030e2 = 1;
    }
    var_4c6172ff thread function_4aadb052(localclientnum, newval, 2, var_2ca030e2);
}

// Namespace zm_island_challenges
// Params 7, eflags: 0x0
// Checksum 0xe617369c, Offset: 0xcc8
// Size: 0xfc
function pillar_challenge_1_3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4c6172ff = getent(localclientnum, "challenge_pillar_1", "targetname");
    var_2ca030e2 = 0;
    player = getlocalplayer(localclientnum);
    if (player getentitynumber() == 1) {
        var_2ca030e2 = 1;
    }
    var_4c6172ff thread function_4aadb052(localclientnum, newval, 3, var_2ca030e2);
}

// Namespace zm_island_challenges
// Params 7, eflags: 0x0
// Checksum 0x75ab2c3b, Offset: 0xdd0
// Size: 0xfc
function pillar_challenge_2_1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4c6172ff = getent(localclientnum, "challenge_pillar_2", "targetname");
    var_2ca030e2 = 0;
    player = getlocalplayer(localclientnum);
    if (player getentitynumber() == 2) {
        var_2ca030e2 = 1;
    }
    var_4c6172ff thread function_4aadb052(localclientnum, newval, 1, var_2ca030e2);
}

// Namespace zm_island_challenges
// Params 7, eflags: 0x0
// Checksum 0x6c85c18b, Offset: 0xed8
// Size: 0xfc
function pillar_challenge_2_2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4c6172ff = getent(localclientnum, "challenge_pillar_2", "targetname");
    var_2ca030e2 = 0;
    player = getlocalplayer(localclientnum);
    if (player getentitynumber() == 2) {
        var_2ca030e2 = 1;
    }
    var_4c6172ff thread function_4aadb052(localclientnum, newval, 2, var_2ca030e2);
}

// Namespace zm_island_challenges
// Params 7, eflags: 0x0
// Checksum 0xc4c01cc8, Offset: 0xfe0
// Size: 0xfc
function pillar_challenge_2_3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4c6172ff = getent(localclientnum, "challenge_pillar_2", "targetname");
    var_2ca030e2 = 0;
    player = getlocalplayer(localclientnum);
    if (player getentitynumber() == 2) {
        var_2ca030e2 = 1;
    }
    var_4c6172ff thread function_4aadb052(localclientnum, newval, 3, var_2ca030e2);
}

// Namespace zm_island_challenges
// Params 7, eflags: 0x0
// Checksum 0x7277989b, Offset: 0x10e8
// Size: 0xfc
function pillar_challenge_3_1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4c6172ff = getent(localclientnum, "challenge_pillar_3", "targetname");
    var_2ca030e2 = 0;
    player = getlocalplayer(localclientnum);
    if (player getentitynumber() == 3) {
        var_2ca030e2 = 1;
    }
    var_4c6172ff thread function_4aadb052(localclientnum, newval, 1, var_2ca030e2);
}

// Namespace zm_island_challenges
// Params 7, eflags: 0x0
// Checksum 0x513ed6bc, Offset: 0x11f0
// Size: 0xfc
function pillar_challenge_3_2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4c6172ff = getent(localclientnum, "challenge_pillar_3", "targetname");
    var_2ca030e2 = 0;
    player = getlocalplayer(localclientnum);
    if (player getentitynumber() == 3) {
        var_2ca030e2 = 1;
    }
    var_4c6172ff thread function_4aadb052(localclientnum, newval, 2, var_2ca030e2);
}

// Namespace zm_island_challenges
// Params 7, eflags: 0x0
// Checksum 0x5622176d, Offset: 0x12f8
// Size: 0xfc
function pillar_challenge_3_3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_4c6172ff = getent(localclientnum, "challenge_pillar_3", "targetname");
    var_2ca030e2 = 0;
    player = getlocalplayer(localclientnum);
    if (player getentitynumber() == 3) {
        var_2ca030e2 = 1;
    }
    var_4c6172ff thread function_4aadb052(localclientnum, newval, 3, var_2ca030e2);
}

// Namespace zm_island_challenges
// Params 4, eflags: 0x0
// Checksum 0x9da02333, Offset: 0x1400
// Size: 0xee
function function_4aadb052(localclientnum, newval, n_challenge, var_2ca030e2) {
    switch (newval) {
    case 1:
        self thread function_4516da29(localclientnum, n_challenge);
        break;
    case 2:
        self thread function_2fba808e(localclientnum, n_challenge, var_2ca030e2);
        break;
    case 3:
        self thread function_21cf53eb(localclientnum, n_challenge, var_2ca030e2);
        break;
    case 4:
        self thread function_72573d3d(localclientnum, n_challenge, var_2ca030e2);
        break;
    }
}

// Namespace zm_island_challenges
// Params 2, eflags: 0x0
// Checksum 0x6098f423, Offset: 0x14f8
// Size: 0x14c
function function_4516da29(localclientnum, n_challenge) {
    self util::waittill_dobj(localclientnum);
    self hidepart(localclientnum, "j_player_started_0" + n_challenge, "p7_zm_isl_ritual_pillar_symbol");
    self hidepart(localclientnum, "j_player_completed_0" + n_challenge, "p7_zm_isl_ritual_pillar_symbol");
    self hidepart(localclientnum, "j_player_claimed_0" + n_challenge, "p7_zm_isl_ritual_pillar_symbol");
    self hidepart(localclientnum, "j_ally_started_0" + n_challenge, "p7_zm_isl_ritual_pillar_symbol");
    self hidepart(localclientnum, "j_ally_completed_0" + n_challenge, "p7_zm_isl_ritual_pillar_symbol");
    self hidepart(localclientnum, "j_ally_claimed_0" + n_challenge, "p7_zm_isl_ritual_pillar_symbol");
}

// Namespace zm_island_challenges
// Params 3, eflags: 0x0
// Checksum 0xbfaaf255, Offset: 0x1650
// Size: 0xbc
function function_2fba808e(localclientnum, n_challenge, var_2ca030e2) {
    self util::waittill_dobj(localclientnum);
    self function_4516da29(localclientnum, n_challenge);
    if (var_2ca030e2) {
        self showpart(localclientnum, "j_player_started_0" + n_challenge, "p7_zm_isl_ritual_pillar_symbol");
        return;
    }
    self showpart(localclientnum, "j_ally_started_0" + n_challenge, "p7_zm_isl_ritual_pillar_symbol");
}

// Namespace zm_island_challenges
// Params 3, eflags: 0x0
// Checksum 0xfe92d449, Offset: 0x1718
// Size: 0xbc
function function_21cf53eb(localclientnum, n_challenge, var_2ca030e2) {
    self util::waittill_dobj(localclientnum);
    self function_4516da29(localclientnum, n_challenge);
    if (var_2ca030e2) {
        self showpart(localclientnum, "j_player_completed_0" + n_challenge, "p7_zm_isl_ritual_pillar_symbol");
        return;
    }
    self showpart(localclientnum, "j_ally_completed_0" + n_challenge, "p7_zm_isl_ritual_pillar_symbol");
}

// Namespace zm_island_challenges
// Params 3, eflags: 0x0
// Checksum 0xf5a33374, Offset: 0x17e0
// Size: 0xbc
function function_72573d3d(localclientnum, n_challenge, var_2ca030e2) {
    self util::waittill_dobj(localclientnum);
    self function_4516da29(localclientnum, n_challenge);
    if (var_2ca030e2) {
        self showpart(localclientnum, "j_player_claimed_0" + n_challenge, "p7_zm_isl_ritual_pillar_symbol");
        return;
    }
    self showpart(localclientnum, "j_ally_claimed_0" + n_challenge, "p7_zm_isl_ritual_pillar_symbol");
}

// Namespace zm_island_challenges
// Params 7, eflags: 0x0
// Checksum 0x2fd8abca, Offset: 0x18a8
// Size: 0xbc
function challenge_glow_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        playfxontag(localclientnum, level._effect["powerup_on"], self, "tag_origin");
    }
    if (newval == 2) {
        playfxontag(localclientnum, level._effect["powerup_on_solo"], self, "tag_origin");
    }
}

