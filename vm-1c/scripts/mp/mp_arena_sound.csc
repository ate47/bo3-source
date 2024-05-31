#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_1b1d095e;

// Namespace namespace_1b1d095e
// Params 0, eflags: 0x1 linked
// namespace_1b1d095e<file_0>::function_d290ebfa
// Checksum 0xdac53549, Offset: 0x2f8
// Size: 0x312
function main() {
    clientfield::register("world", "arena_announcer_line", 12000, 4, "int", &function_8cf0b2, 0, 0);
    clientfield::register("world", "arena_fighter", 12000, 2, "int", &function_a7d453ed, 0, 0);
    clientfield::register("world", "arena_fighter_line", 12000, 3, "int", &function_234a7ab8, 0, 0);
    clientfield::register("world", "arena_event", 12000, 3, "int", &function_2ed4e576, 0, 0);
    level.var_4655dffd = 0;
    level.var_7bb6ffcd = 0;
    level.var_74b8c7 = 0;
    level.var_4150d7c2 = [];
    level.var_4150d7c2[0] = "vox_ancr_introduce_yellow";
    level.var_4150d7c2[1] = "vox_ancr_introduce_blue";
    level.var_4150d7c2[2] = "vox_ancr_introduce_red";
    level.var_7f62efbf = [];
    level.var_7f62efbf[0] = "vox_ancr_loser_yellow";
    level.var_7f62efbf[1] = "vox_ancr_loser_blue";
    level.var_7f62efbf[2] = "vox_ancr_loser_red";
    level.var_59bdd7e1 = [];
    level.var_59bdd7e1[0] = "vox_ancr_winner_yellow";
    level.var_59bdd7e1[1] = "vox_ancr_winner_blue";
    level.var_59bdd7e1[2] = "vox_ancr_winner_red";
    level.var_2d1171d1 = [];
    level.var_2d1171d1[0] = "vox_ymec_introduce_yellow_resp";
    level.var_2d1171d1[1] = "vox_bmec_introduce_blue_resp";
    level.var_2d1171d1[2] = "vox_rmec_introduce_red_resp";
    level.var_8b72e790 = [];
    level.var_8b72e790[0] = "vox_ymec_loser_yellow_resp";
    level.var_8b72e790[1] = "vox_bmec_loser_blue_resp";
    level.var_8b72e790[2] = "vox_rmec_loser_red_resp";
    level.var_5e22bf08 = [];
    level.var_5e22bf08[0] = "vox_ymec_winner_yellow_resp";
    level.var_5e22bf08[1] = "vox_bmec_winner_blue_resp";
    level.var_5e22bf08[2] = "vox_rmec_winner_red_resp";
}

// Namespace namespace_1b1d095e
// Params 7, eflags: 0x1 linked
// namespace_1b1d095e<file_0>::function_8cf0b2
// Checksum 0x1e8bee69, Offset: 0x618
// Size: 0x48
function function_8cf0b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_4655dffd = newval;
}

// Namespace namespace_1b1d095e
// Params 7, eflags: 0x1 linked
// namespace_1b1d095e<file_0>::function_a7d453ed
// Checksum 0x52f97342, Offset: 0x668
// Size: 0x48
function function_a7d453ed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_7bb6ffcd = newval;
}

// Namespace namespace_1b1d095e
// Params 7, eflags: 0x1 linked
// namespace_1b1d095e<file_0>::function_234a7ab8
// Checksum 0x27efeccd, Offset: 0x6b8
// Size: 0x48
function function_234a7ab8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_74b8c7 = newval;
}

// Namespace namespace_1b1d095e
// Params 7, eflags: 0x1 linked
// namespace_1b1d095e<file_0>::function_2ed4e576
// Checksum 0x3e26bd49, Offset: 0x708
// Size: 0x1fe
function function_2ed4e576(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval <= oldval) {
        return;
    }
    wait(0.016);
    switch (newval) {
    case 1:
        function_aea157a4(localclientnum, "vox_ancr_welcome_welcome", level.var_4655dffd);
        break;
    case 2:
        function_aea157a4(localclientnum, level.var_4150d7c2[level.var_7bb6ffcd], level.var_4655dffd);
        wait(0.8);
        function_aea157a4(localclientnum, level.var_2d1171d1[level.var_7bb6ffcd], level.var_74b8c7);
        break;
    case 3:
        function_aea157a4(localclientnum, level.var_7f62efbf[level.var_7bb6ffcd], level.var_4655dffd);
        wait(0.8);
        function_aea157a4(localclientnum, level.var_8b72e790[level.var_7bb6ffcd], level.var_74b8c7);
        break;
    case 4:
        function_aea157a4(localclientnum, level.var_59bdd7e1[level.var_7bb6ffcd], level.var_4655dffd);
        wait(0.8);
        function_aea157a4(localclientnum, level.var_5e22bf08[level.var_7bb6ffcd], level.var_74b8c7);
        break;
    }
}

// Namespace namespace_1b1d095e
// Params 3, eflags: 0x1 linked
// namespace_1b1d095e<file_0>::function_aea157a4
// Checksum 0x4152ca9b, Offset: 0x910
// Size: 0x178
function function_aea157a4(localclientnum, alias, line) {
    var_cfdadf12 = alias + "_" + line;
    playbackid = playsound(localclientnum, var_cfdadf12, (1128, 0, 934));
    thread function_22fabb0b(var_cfdadf12, localclientnum);
    if (!isdefined(playbackid) || playbackid == 0) {
        return;
    }
    for (length = getknownlength(playbackid); soundplaying(playbackid) && !length; length = getknownlength(playbackid)) {
        wait(0.05);
    }
    var_5bbf1727 = max(0, length - 3000);
    while (soundplaying(playbackid) && getplaybacktime(playbackid) < var_5bbf1727) {
        wait(0.05);
    }
}

// Namespace namespace_1b1d095e
// Params 2, eflags: 0x1 linked
// namespace_1b1d095e<file_0>::function_22fabb0b
// Checksum 0x98e4b52a, Offset: 0xa90
// Size: 0x24c
function function_22fabb0b(var_cfdadf12, localclientnum) {
    var_42b2155b[0] = spawn(localclientnum, (3100, 1000, 934));
    var_42b2155b[1] = spawn(localclientnum, (3100, -1000, 934));
    var_42b2155b[2] = spawn(localclientnum, (-780, -2163, 1300));
    var_42b2155b[3] = spawn(localclientnum, (-477, 1760, 1300));
    player = getlocalplayer(localclientnum);
    var_55ff0d0d = array::get_all_closest(player.origin, var_42b2155b);
    wait(0.3);
    playsound(localclientnum, var_cfdadf12, var_55ff0d0d[0].origin);
    playsound(localclientnum, var_cfdadf12, var_55ff0d0d[2].origin);
    wait(0.3);
    playsound(localclientnum, var_cfdadf12, var_55ff0d0d[1].origin);
    var_f64fdbeb = playsound(localclientnum, var_cfdadf12, var_55ff0d0d[3].origin);
    while (soundplaying(var_f64fdbeb)) {
        wait(0.05);
    }
    array::thread_all(var_42b2155b, &struct::delete);
}

