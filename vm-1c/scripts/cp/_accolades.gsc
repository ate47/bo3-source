#using scripts/codescripts/struct;
#using scripts/cp/_challenges;
#using scripts/cp/_collectibles;
#using scripts/cp/_decorations;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_save;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/table_shared;
#using scripts/shared/util_shared;

#namespace accolades;

// Namespace accolades
// Params 0, eflags: 0x2
// Checksum 0xd63ec753, Offset: 0x388
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("accolades", &__init__, &__main__, undefined);
}

// Namespace accolades
// Params 0, eflags: 0x0
// Checksum 0x1a356f14, Offset: 0x3d0
// Size: 0x344
function __init__() {
    if (function_214e644a()) {
        return;
    }
    var_c02de660 = [];
    var_c02de660[var_c02de660.size] = "AQUIFER";
    var_c02de660[var_c02de660.size] = "BIODOMES";
    var_c02de660[var_c02de660.size] = "BLACKSTATION";
    var_c02de660[var_c02de660.size] = "INFECTION";
    var_c02de660[var_c02de660.size] = "LOTUS";
    var_c02de660[var_c02de660.size] = "NEWWORLD";
    var_c02de660[var_c02de660.size] = "PROLOGUE";
    var_c02de660[var_c02de660.size] = "RAMSES";
    var_c02de660[var_c02de660.size] = "SGEN";
    var_c02de660[var_c02de660.size] = "VENGEANCE";
    var_c02de660[var_c02de660.size] = "ZURICH";
    level.accolades = [];
    level.var_deb20b04 = getrootmapname();
    level.mission_name = getmissionname();
    if (isdefined(level.mission_name) && missionhasaccolades(level.var_deb20b04)) {
        for (i = 0; i < var_c02de660.size; i++) {
            if (var_c02de660[i] == toupper(level.mission_name)) {
                level.mission_index = i + 1;
                break;
            }
        }
        callback::on_connect(&on_player_connect);
        callback::on_spawned(&on_player_spawned);
        callback::on_disconnect(&on_player_disconnect);
        level.var_f8718de3 = "MISSION_" + toupper(level.mission_name) + "_";
        level.var_d8f32e57 = int(tablelookup("gamedata/stats/cp/statsmilestones1.csv", 4, level.var_f8718de3 + "UNTOUCHED", 0));
        register(level.var_f8718de3 + "UNTOUCHED", undefined, 1);
        register(level.var_f8718de3 + "SCORE");
        register(level.var_f8718de3 + "COLLECTIBLE");
        level thread function_4c436dfe();
    }
}

// Namespace accolades
// Params 0, eflags: 0x0
// Checksum 0xc4e7e1da, Offset: 0x720
// Size: 0x18
function __main__() {
    if (function_214e644a()) {
        return;
    }
}

// Namespace accolades
// Params 1, eflags: 0x0
// Checksum 0x57bcf5dc, Offset: 0x740
// Size: 0x4e
function function_4f9d8dec(var_5ba0c4e7) {
    accolades = self savegame::function_36adbb9c("accolades");
    if (isdefined(accolades)) {
        return accolades[var_5ba0c4e7];
    }
}

// Namespace accolades
// Params 2, eflags: 0x0
// Checksum 0xdbf64031, Offset: 0x798
// Size: 0x74
function function_50f58bd0(var_5ba0c4e7, var_a3dc571a) {
    var_83736781 = self savegame::function_36adbb9c("accolades");
    var_83736781[var_5ba0c4e7] = var_a3dc571a;
    self savegame::set_player_data("accolades", var_83736781);
}

// Namespace accolades
// Params 2, eflags: 0x0
// Checksum 0x29efd725, Offset: 0x818
// Size: 0x9c
function function_464d3607(var_36b04a4a, is_state) {
    if (isdefined(is_state) && is_state) {
        return self getdstat("PlayerStatsByMap", level.var_deb20b04, "accolades", var_36b04a4a, "state");
    }
    return self getdstat("PlayerStatsByMap", level.var_deb20b04, "accolades", var_36b04a4a, "value");
}

// Namespace accolades
// Params 4, eflags: 0x0
// Checksum 0x682169a2, Offset: 0x8c0
// Size: 0x114
function function_ce95384b(var_36b04a4a, is_state, value, var_b3982c20) {
    if (isdefined(is_state) && is_state) {
        self function_e2d5f2db(var_36b04a4a, value);
        self setdstat("PlayerStatsByMap", level.var_deb20b04, "accolades", var_36b04a4a, "state", value);
    } else {
        if (isdefined(var_b3982c20) && var_b3982c20) {
            self function_86373aa7(var_36b04a4a, value);
        }
        self setdstat("PlayerStatsByMap", level.var_deb20b04, "accolades", var_36b04a4a, "value", value);
    }
    /#
        self.var_eb7d74bb = 1;
    #/
}

// Namespace accolades
// Params 1, eflags: 0x0
// Checksum 0x5924bdda, Offset: 0x9e0
// Size: 0x22
function function_520227e6(var_36b04a4a) {
    return self function_464d3607(var_36b04a4a, 0);
}

// Namespace accolades
// Params 3, eflags: 0x0
// Checksum 0xeed5e7b7, Offset: 0xa10
// Size: 0x3c
function function_de8b9e62(var_36b04a4a, value, var_b3982c20) {
    self function_ce95384b(var_36b04a4a, 0, value, var_b3982c20);
}

// Namespace accolades
// Params 3, eflags: 0x0
// Checksum 0x8d5c91c9, Offset: 0xa58
// Size: 0x6e
function function_3bbb909b(var_36b04a4a, value, var_b3982c20) {
    statvalue = self function_520227e6(var_36b04a4a);
    self function_de8b9e62(var_36b04a4a, statvalue + value, var_b3982c20);
    return statvalue + value;
}

// Namespace accolades
// Params 1, eflags: 0x0
// Checksum 0x264464e4, Offset: 0xad0
// Size: 0x2a
function function_3a7fd23a(var_36b04a4a) {
    return self function_464d3607(var_36b04a4a, 1);
}

// Namespace accolades
// Params 2, eflags: 0x0
// Checksum 0xe13e5e42, Offset: 0xb08
// Size: 0x34
function function_8992915e(var_36b04a4a, state) {
    self function_ce95384b(var_36b04a4a, 1, state);
}

// Namespace accolades
// Params 2, eflags: 0x0
// Checksum 0x29dd6e99, Offset: 0xb48
// Size: 0x44
function function_86373aa7(var_36b04a4a, value) {
    self setnoncheckpointdata("accolades" + var_36b04a4a + "value", value);
}

// Namespace accolades
// Params 2, eflags: 0x0
// Checksum 0xb04fc44, Offset: 0xb98
// Size: 0x44
function function_e2d5f2db(var_36b04a4a, state) {
    self setnoncheckpointdata("accolades" + var_36b04a4a + "state", state);
}

// Namespace accolades
// Params 1, eflags: 0x0
// Checksum 0xf5774b7a, Offset: 0xbe8
// Size: 0x32
function function_4f34644b(var_36b04a4a) {
    return self getnoncheckpointdata("accolades" + var_36b04a4a + "value");
}

// Namespace accolades
// Params 1, eflags: 0x0
// Checksum 0x31c73142, Offset: 0xc28
// Size: 0x32
function function_31381fa7(var_36b04a4a) {
    return self getnoncheckpointdata("accolades" + var_36b04a4a + "state");
}

// Namespace accolades
// Params 1, eflags: 0x0
// Checksum 0x78bb8f3c, Offset: 0xc68
// Size: 0x5c
function function_cc6b3591(var_36b04a4a) {
    self clearnoncheckpointdata("accolades" + var_36b04a4a + "state");
    self clearnoncheckpointdata("accolades" + var_36b04a4a + "value");
}

// Namespace accolades
// Params 0, eflags: 0x0
// Checksum 0x4068a011, Offset: 0xcd0
// Size: 0x1c2
function function_77b3b4d1() {
    if (self == level) {
        foreach (player in level.players) {
            player function_77b3b4d1();
        }
        return;
    }
    accolades = self savegame::function_36adbb9c("accolades");
    if (!isdefined(accolades)) {
        return;
    }
    foreach (var_5ba0c4e7, var_8c03895d in level.accolades) {
        accolade = accolades[var_5ba0c4e7];
        if (accolade.current_value > self function_520227e6(accolade.index)) {
            self function_de8b9e62(accolade.index, accolade.current_value, 1);
        }
    }
}

// Namespace accolades
// Params 2, eflags: 0x4
// Checksum 0xb55daa3, Offset: 0xea0
// Size: 0x88
function private function_9ba543a3(var_5ba0c4e7, var_eb856299) {
    var_51ccabeb = tablelookuprownum("gamedata/stats/cp/statsmilestones1.csv", 4, var_5ba0c4e7);
    var_35cb50ff = tablelookupcolumnforrow("gamedata/stats/cp/statsmilestones1.csv", var_51ccabeb, 2);
    return int(var_35cb50ff) <= var_eb856299;
}

// Namespace accolades
// Params 0, eflags: 0x4
// Checksum 0x440f2787, Offset: 0xf30
// Size: 0x2a
function private function_214e644a() {
    return isdefined(level.var_837b3a61) && level.var_837b3a61 || sessionmodeiscampaignzombiesgame();
}

// Namespace accolades
// Params 0, eflags: 0x0
// Checksum 0x10c75537, Offset: 0xf68
// Size: 0x64
function function_3c63ee8() {
    return getdvarstring("skipto") == "" || !ismapsublevel() && getdvarstring("skipto") == "level_start";
}

// Namespace accolades
// Params 1, eflags: 0x0
// Checksum 0x3c691062, Offset: 0xfd8
// Size: 0x5c
function function_994b29af(var_5ba0c4e7) {
    var_ea75dd36 = tablelookup("gamedata/stats/cp/statsmilestones1.csv", 4, toupper(var_5ba0c4e7), 7);
    return var_ea75dd36 != "";
}

// Namespace accolades
// Params 1, eflags: 0x0
// Checksum 0x9c46b75e, Offset: 0x1040
// Size: 0x76
function function_7efd1da3(var_5ba0c4e7) {
    var_a33c5066 = tablelookup("gamedata/stats/cp/statsmilestones1.csv", 4, toupper(var_5ba0c4e7), 6);
    if (var_a33c5066 != "") {
        return int(var_a33c5066);
    }
    return 0;
}

// Namespace accolades
// Params 1, eflags: 0x0
// Checksum 0x569d9fb, Offset: 0x10c0
// Size: 0x7c
function function_77abfac7(var_9b8b52b0) {
    if (!isdefined(var_9b8b52b0)) {
        var_9b8b52b0 = 1;
    }
    var_6dff2ed7 = self getdstat("unlocks", 0);
    var_6dff2ed7 += var_9b8b52b0;
    self setdstat("unlocks", 0, var_6dff2ed7);
}

// Namespace accolades
// Params 2, eflags: 0x0
// Checksum 0x76caacd1, Offset: 0x1148
// Size: 0xb4
function function_92050191(var_36b04a4a, var_eb856299) {
    var_9d479b7 = self getdstat("PlayerStatsByMap", getrootmapname(), "accolades", var_36b04a4a, "highestValue");
    if (var_eb856299 > var_9d479b7) {
        self setdstat("PlayerStatsByMap", getrootmapname(), "accolades", var_36b04a4a, "highestValue", var_eb856299);
    }
}

// Namespace accolades
// Params 1, eflags: 0x0
// Checksum 0x68d87354, Offset: 0x1208
// Size: 0x7a
function function_feabf577(var_5ba0c4e7) {
    var_8dab6968 = tablelookup("gamedata/stats/cp/statsmilestones1.csv", 4, toupper(var_5ba0c4e7), 2);
    if (var_8dab6968 == "") {
        return 0;
    }
    return int(var_8dab6968);
}

// Namespace accolades
// Params 1, eflags: 0x0
// Checksum 0xf584bbbe, Offset: 0x1290
// Size: 0x124
function function_42acdca5(var_5ba0c4e7) {
    accolade = self function_4f9d8dec(var_5ba0c4e7);
    if (function_9ba543a3(var_5ba0c4e7, accolade.current_value)) {
        return;
    }
    self function_cc6b3591(accolade.index);
    self function_8992915e(accolade.index, 0);
    if (isdefined(accolade.var_ab795acb) && accolade.var_ab795acb) {
        accolade.current_value = 1;
    } else {
        accolade.current_value = 0;
    }
    self function_de8b9e62(accolade.index, accolade.current_value, 0);
}

// Namespace accolades
// Params 3, eflags: 0x0
// Checksum 0x6a3b1fcf, Offset: 0x13c0
// Size: 0x10c
function register(var_5ba0c4e7, var_fe4f6a44, var_ab795acb) {
    if (function_214e644a()) {
        return;
    }
    if (!isdefined(level.accolades[var_5ba0c4e7])) {
        var_d8f32e57 = int(tablelookup("gamedata/stats/cp/statsmilestones1.csv", 4, var_5ba0c4e7, 0));
        level.accolades[var_5ba0c4e7] = spawnstruct();
        level.accolades[var_5ba0c4e7].var_1b47f988 = var_fe4f6a44;
        level.accolades[var_5ba0c4e7].index = var_d8f32e57 - level.var_d8f32e57;
        level.accolades[var_5ba0c4e7].var_ab795acb = isdefined(var_ab795acb) && var_ab795acb;
    }
}

// Namespace accolades
// Params 3, eflags: 0x0
// Checksum 0x759a9010, Offset: 0x14d8
// Size: 0x4d4
function increment(var_5ba0c4e7, n_val, var_50f65478) {
    if (!isdefined(n_val)) {
        n_val = 1;
    }
    if (function_214e644a()) {
        return;
    }
    if (self == level) {
        foreach (player in level.players) {
            player increment(var_5ba0c4e7);
        }
        return;
    }
    accolade = self function_4f9d8dec(var_5ba0c4e7);
    if (!isdefined(accolade)) {
        return;
    }
    if (function_3a7fd23a(accolade.index) != 0) {
        if (var_5ba0c4e7 == level.var_f8718de3 + "SCORE") {
            accolade.current_value += n_val;
            self function_92050191(accolade.index, accolade.current_value);
        }
        return;
    }
    if (!(isdefined(accolade.var_ab795acb) && accolade.var_ab795acb)) {
        accolade.current_value += n_val;
    } else {
        accolade.current_value = 0;
    }
    /#
        if (!(isdefined(var_50f65478) && var_50f65478)) {
            var_cacb0169 = tablelookupistring("<dev string:x28>", 4, var_5ba0c4e7, 5);
            iprintln(var_cacb0169);
        }
        self.var_eb7d74bb = 1;
    #/
    self function_de8b9e62(accolade.index, accolade.current_value, 0);
    self function_92050191(accolade.index, accolade.current_value);
    if (!function_9ba543a3(var_5ba0c4e7, accolade.current_value) || accolade.index == 1) {
        return;
    }
    self function_de8b9e62(accolade.index, accolade.current_value, 1);
    self function_8992915e(accolade.index, 1);
    var_fdcc76d1 = tablelookupistring("gamedata/stats/cp/statsmilestones1.csv", 4, var_5ba0c4e7, 8);
    if (isdefined(var_fdcc76d1)) {
        util::function_964b7eb7(self, var_fdcc76d1);
        self playlocalsound("uin_accolade");
    }
    self thread challenges::function_96ed590f("career_accolades");
    accolade.is_completed = 1;
    self decorations::function_e72fc18();
    if (isdefined(accolade.var_9ebe4012) && accolade.var_9ebe4012) {
        self thread challenges::function_96ed590f("career_tokens");
        self giveunlocktoken(1);
    }
    self addrankxpvalue("award_accolade", accolade.award_xp);
    self decorations::function_59f1fa79();
    uploadstats(self);
}

// Namespace accolades
// Params 2, eflags: 0x4
// Checksum 0xfc9ceb9d, Offset: 0x19b8
// Size: 0xc0
function private function_35e3d94b(var_5ba0c4e7, str_notify) {
    self endon(#"hash_115de864");
    self endon(#"disconnect");
    if (!isdefined(self.var_4fbad7c0)) {
        self.var_4fbad7c0 = [];
    }
    if (isdefined(self.var_4fbad7c0[str_notify]) && self.var_4fbad7c0[str_notify]) {
        return;
    }
    self.var_4fbad7c0[str_notify] = 1;
    while (true) {
        self waittill(str_notify, n_val);
        self increment(var_5ba0c4e7, n_val);
    }
}

// Namespace accolades
// Params 0, eflags: 0x4
// Checksum 0xcdac2e41, Offset: 0x1a80
// Size: 0x454
function private function_115de864() {
    self notify(#"hash_115de864");
    accolades = [];
    self savegame::set_player_data("accolades", accolades);
    foreach (var_5ba0c4e7, var_8c03895d in level.accolades) {
        var_aa6073 = spawnstruct();
        var_aa6073.index = var_8c03895d.index;
        var_aa6073.var_ab795acb = var_8c03895d.var_ab795acb;
        var_cba20a96 = self function_3a7fd23a(var_8c03895d.index);
        self function_e2d5f2db(var_8c03895d.index, var_cba20a96);
        if (var_cba20a96 != 0) {
            var_aa6073.current_value = function_520227e6(var_8c03895d.index);
            var_aa6073.is_completed = 1;
            self function_50f58bd0(var_5ba0c4e7, var_aa6073);
            self function_86373aa7(var_8c03895d.index, var_aa6073.current_value);
            if (var_5ba0c4e7 == level.var_f8718de3 + "SCORE") {
            }
            continue;
        }
        if (isdefined(var_8c03895d.var_1b47f988) && !(isdefined(strendswith(var_5ba0c4e7, "COLLECTIBLE")) && strendswith(var_5ba0c4e7, "COLLECTIBLE"))) {
            self thread function_35e3d94b(var_5ba0c4e7, var_8c03895d.var_1b47f988);
        }
        if (var_8c03895d.var_ab795acb) {
            var_aa6073.current_value = 1;
        } else {
            var_aa6073.current_value = 0;
        }
        if (isdefined(strendswith(var_5ba0c4e7, "COLLECTIBLE")) && strendswith(var_5ba0c4e7, "COLLECTIBLE")) {
            var_aa6073.current_value = self getdstat("PlayerStatsByMap", getrootmapname(), "accolades", var_8c03895d.index, "highestValue");
        }
        self function_de8b9e62(var_8c03895d.index, var_aa6073.current_value, 1);
        if (function_994b29af(var_5ba0c4e7)) {
            var_aa6073.var_9ebe4012 = 1;
        }
        var_aa6073.award_xp = function_7efd1da3(var_5ba0c4e7);
        self function_50f58bd0(var_5ba0c4e7, var_aa6073);
    }
    /#
        self.var_eb7d74bb = 1;
    #/
    self decorations::function_e72fc18();
    self savegame::set_player_data("last_mission", getmissionname());
}

// Namespace accolades
// Params 0, eflags: 0x0
// Checksum 0x45c94b93, Offset: 0x1ee0
// Size: 0xe0
function function_673a5138() {
    self endon(#"disconnect");
    self endon(#"death");
    var_88d3591a = self function_4f9d8dec(level.var_f8718de3 + "COLLECTIBLE");
    while (true) {
        self waittill(#"picked_up_collectible");
        if (self function_3a7fd23a(var_88d3591a.index) != 0) {
            continue;
        }
        self function_3bbb909b(var_88d3591a.index, 1, 1);
        self increment(level.var_f8718de3 + "COLLECTIBLE");
    }
}

// Namespace accolades
// Params 0, eflags: 0x0
// Checksum 0xb0aa4c2, Offset: 0x1fc8
// Size: 0xd4
function function_d2380b2() {
    self endon(#"disconnect");
    accolade = self function_4f9d8dec(level.var_f8718de3 + "UNTOUCHED");
    if (accolade.current_value == 0) {
        return;
    }
    self util::waittill_any("death", "increment_untouched");
    self increment(level.var_f8718de3 + "UNTOUCHED");
    self function_de8b9e62(accolade.index, accolade.current_value, 1);
}

// Namespace accolades
// Params 0, eflags: 0x0
// Checksum 0x7876c739, Offset: 0x20a8
// Size: 0x160
function function_39f05ec1() {
    self endon(#"disconnect");
    self endon(#"death");
    var_17911606 = self getdstat("PlayerStatsByMap", getrootmapname(), "currentStats", "SCORE");
    var_7b12b16 = self function_4f9d8dec(level.var_f8718de3 + "SCORE");
    var_6962bddd = self function_3a7fd23a(var_7b12b16.index);
    if (isdefined(var_6962bddd) && var_6962bddd) {
        return;
    }
    while (true) {
        self waittill(#"score_event");
        var_17911606 = var_7b12b16.current_value;
        new_score = self.pers["score"];
        scorediff = new_score - var_17911606;
        self increment(level.var_f8718de3 + "SCORE", scorediff, 1);
    }
}

// Namespace accolades
// Params 0, eflags: 0x0
// Checksum 0x1850fce4, Offset: 0x2210
// Size: 0xb4
function on_player_connect() {
    if (function_214e644a()) {
        return;
    }
    self function_cf1b719a();
    if (!ismapsublevel() && level.var_31aefea8 == level.var_574eb415) {
        self function_115de864();
    }
    /#
        if (isdefined(level.accolades)) {
            self.var_eb7d74bb = 1;
            self devgui_init();
            self thread function_8082e9f0();
        }
    #/
}

// Namespace accolades
// Params 0, eflags: 0x0
// Checksum 0xda95208f, Offset: 0x22d0
// Size: 0x15c
function on_player_spawned() {
    if (self savegame::function_36adbb9c("last_mission") === getmissionname()) {
        foreach (var_5ba0c4e7, var_8c03895d in level.accolades) {
            if (isdefined(var_8c03895d.var_1b47f988)) {
                self thread function_35e3d94b(var_5ba0c4e7, var_8c03895d.var_1b47f988);
            }
        }
    } else {
        self function_115de864();
    }
    self thread function_3b92459f();
    self thread function_d2380b2();
    self thread function_673a5138();
    self thread function_39f05ec1();
}

// Namespace accolades
// Params 0, eflags: 0x0
// Checksum 0xfe05e667, Offset: 0x2438
// Size: 0xaa
function function_cf1b719a() {
    if (!isdefined(level.accolades)) {
        return;
    }
    foreach (var_8c03895d in level.accolades) {
        self function_cc6b3591(var_8c03895d.index);
    }
}

// Namespace accolades
// Params 0, eflags: 0x0
// Checksum 0xd095e079, Offset: 0x24f0
// Size: 0x114
function on_player_disconnect() {
    foreach (var_8c03895d in level.accolades) {
        if (self function_3a7fd23a(var_8c03895d.index) == 1) {
            self function_8992915e(var_8c03895d.index, 2);
        }
    }
    self savegame::set_player_data("accolades", undefined);
    self savegame::set_player_data("last_mission", "");
}

/#

    // Namespace accolades
    // Params 0, eflags: 0x0
    // Checksum 0xbe206a2d, Offset: 0x2610
    // Size: 0x134
    function function_8082e9f0() {
        self endon(#"disconnect");
        while (true) {
            cmd = getdvarstring("<dev string:x4f>");
            if (isdefined(cmd) && cmd != "<dev string:x66>") {
                self function_a4b8b7d1(int(cmd));
            }
            if (cmd != "<dev string:x66>") {
                setdvar("<dev string:x4f>", "<dev string:x66>");
            }
            if (self.var_eb7d74bb == 1 && isdefined(self.var_ab872594)) {
                function_7aaf1e5d();
            }
            if (getdvarint("<dev string:x67>") > 0) {
                self function_1ea616fe();
            } else {
                self notify(#"hash_30b79005");
            }
            wait 1;
        }
    }

    // Namespace accolades
    // Params 0, eflags: 0x0
    // Checksum 0xc1669079, Offset: 0x2750
    // Size: 0x34
    function function_7b64a1e0() {
        self endon(#"disconnect");
        self waittill(#"hash_30b79005");
        function_7aaf1e5d();
    }

    // Namespace accolades
    // Params 0, eflags: 0x0
    // Checksum 0x8c549448, Offset: 0x2790
    // Size: 0x1c2
    function function_7aaf1e5d() {
        if (isdefined(self.var_ab872594)) {
            foreach (var_ab872594 in self.var_ab872594) {
                var_ab872594 destroy();
            }
            foreach (var_5922e3b8 in self.var_5922e3b8) {
                var_5922e3b8 destroy();
            }
            foreach (var_eda8fa83 in self.var_87b86b14) {
                var_eda8fa83 destroy();
            }
            self.var_ab872594 = undefined;
            self.var_5922e3b8 = undefined;
            self.var_87b86b14 = undefined;
        }
    }

    // Namespace accolades
    // Params 0, eflags: 0x0
    // Checksum 0xa3aabf7d, Offset: 0x2960
    // Size: 0x8d0
    function function_1ea616fe() {
        x = 0;
        y = 100;
        var_c06a516a = "<dev string:x66>";
        var_1c70e53e = "<dev string:x66>";
        var_16bed2ea = "<dev string:x66>";
        if (!isdefined(level.accolades) || isdefined(self.var_ab872594) || !isdefined(self savegame::function_36adbb9c("<dev string:x7a>"))) {
            return;
        }
        self.var_ab872594 = [];
        self.var_5922e3b8 = [];
        self.var_87b86b14 = [];
        var_c74eaab3 = 0;
        var_ab872594 = newclienthudelem(self);
        var_5922e3b8 = newclienthudelem(self);
        var_87b86b14 = newclienthudelem(self);
        foreach (var_5ba0c4e7, var_8c03895d in level.accolades) {
            if (var_c74eaab3 % 7 == 6) {
                var_ab872594.x = x + 2;
                var_ab872594.y = y + 2;
                var_ab872594.alignx = "<dev string:x84>";
                var_ab872594.aligny = "<dev string:x89>";
                var_ab872594 settext(var_c06a516a);
                var_ab872594.hidewheninmenu = 1;
                var_ab872594.font = "<dev string:x8d>";
                var_ab872594.foreground = 1;
                var_5922e3b8.x = x + 120;
                var_5922e3b8.y = y + 2;
                var_5922e3b8.alignx = "<dev string:x84>";
                var_5922e3b8.aligny = "<dev string:x89>";
                var_5922e3b8 settext(var_1c70e53e);
                var_5922e3b8.hidewheninmenu = 1;
                var_5922e3b8.font = "<dev string:x8d>";
                var_5922e3b8.foreground = 1;
                var_87b86b14.x = x + -76;
                var_87b86b14.y = y + 2;
                var_87b86b14.alignx = "<dev string:x84>";
                var_87b86b14.aligny = "<dev string:x89>";
                var_87b86b14 settext(var_16bed2ea);
                var_87b86b14.hidewheninmenu = 1;
                var_87b86b14.font = "<dev string:x8d>";
                var_87b86b14.foreground = 1;
                self.var_ab872594[self.var_ab872594.size] = var_ab872594;
                self.var_5922e3b8[self.var_5922e3b8.size] = var_5922e3b8;
                self.var_87b86b14[self.var_87b86b14.size] = var_87b86b14;
                var_ab872594 = newclienthudelem(self);
                var_5922e3b8 = newclienthudelem(self);
                var_87b86b14 = newclienthudelem(self);
                y += 73;
                var_c74eaab3 = 1;
                var_c06a516a = var_5ba0c4e7 + "<dev string:x95>";
                var_1c70e53e = self function_4f9d8dec(var_5ba0c4e7).current_value;
                if (isdefined(self function_4f9d8dec(var_5ba0c4e7).is_completed) && self function_4f9d8dec(var_5ba0c4e7).is_completed) {
                    var_1c70e53e += "<dev string:x97>";
                }
                var_1c70e53e += "<dev string:x95>";
                var_16bed2ea = self function_520227e6(var_8c03895d.index) + "<dev string:x95>";
                continue;
            }
            var_c06a516a += var_5ba0c4e7 + "<dev string:x95>";
            var_1c70e53e += self function_4f9d8dec(var_5ba0c4e7).current_value;
            if (isdefined(self function_4f9d8dec(var_5ba0c4e7).is_completed) && self function_4f9d8dec(var_5ba0c4e7).is_completed) {
                var_1c70e53e += "<dev string:x97>";
            }
            var_1c70e53e += "<dev string:x95>";
            var_16bed2ea += self function_520227e6(var_8c03895d.index) + "<dev string:x95>";
            var_c74eaab3++;
        }
        var_ab872594.x = x + 2;
        var_ab872594.y = y + 2;
        var_ab872594.alignx = "<dev string:x84>";
        var_ab872594.aligny = "<dev string:x89>";
        var_ab872594 settext(var_c06a516a);
        var_ab872594.hidewheninmenu = 1;
        var_ab872594.font = "<dev string:x8d>";
        var_ab872594.foreground = 1;
        var_5922e3b8.x = x + 120;
        var_5922e3b8.y = y + 2;
        var_5922e3b8.alignx = "<dev string:x84>";
        var_5922e3b8.aligny = "<dev string:x89>";
        var_5922e3b8 settext(var_1c70e53e);
        var_5922e3b8.hidewheninmenu = 1;
        var_5922e3b8.font = "<dev string:x8d>";
        var_5922e3b8.foreground = 1;
        var_87b86b14.x = x + -76;
        var_87b86b14.y = y + 2;
        var_87b86b14.alignx = "<dev string:x84>";
        var_87b86b14.aligny = "<dev string:x89>";
        var_87b86b14 settext(var_16bed2ea);
        var_87b86b14.hidewheninmenu = 1;
        var_87b86b14.font = "<dev string:x8d>";
        var_87b86b14.foreground = 1;
        self.var_ab872594[self.var_ab872594.size] = var_ab872594;
        self.var_5922e3b8[self.var_5922e3b8.size] = var_5922e3b8;
        self.var_87b86b14[self.var_87b86b14.size] = var_87b86b14;
        self thread function_7b64a1e0();
        self.var_eb7d74bb = 0;
    }

    // Namespace accolades
    // Params 1, eflags: 0x0
    // Checksum 0xb70a2cfe, Offset: 0x3238
    // Size: 0xc4
    function function_a4b8b7d1(var_36b04a4a) {
        current_index = 0;
        foreach (var_5ba0c4e7, var_8c03895d in level.accolades) {
            if (current_index == var_36b04a4a) {
                self increment(var_5ba0c4e7);
                break;
            }
            current_index++;
        }
    }

    // Namespace accolades
    // Params 0, eflags: 0x0
    // Checksum 0x76270097, Offset: 0x3308
    // Size: 0xd6
    function devgui_init() {
        setdvar("<dev string:x4f>", "<dev string:x66>");
        setdvar("<dev string:x67>", "<dev string:xa4>");
        adddebugcommand("<dev string:xa6>");
        for (i = 0; i < level.accolades.size; i++) {
            adddebugcommand("<dev string:xf6>" + i + "<dev string:x129>" + i + "<dev string:x12b>" + i + "<dev string:x14b>");
        }
    }

#/

// Namespace accolades
// Params 0, eflags: 0x0
// Checksum 0xbe13e843, Offset: 0x33e8
// Size: 0x1a
function function_3b92459f() {
    self endon(#"disconnect");
    self endon(#"death");
}

// Namespace accolades
// Params 0, eflags: 0x0
// Checksum 0xf109d403, Offset: 0x3440
// Size: 0x3f0
function function_4c436dfe() {
    self endon(#"disconnect");
    while (true) {
        level waittill(#"save_restore");
        if (function_3c63ee8()) {
            continue;
        }
        foreach (e_player in level.players) {
            foreach (var_5ba0c4e7, var_8c03895d in level.accolades) {
                accolade = e_player function_4f9d8dec(var_5ba0c4e7);
                var_13c6f0bc = e_player function_3a7fd23a(var_8c03895d.index);
                var_89eb65c1 = e_player function_31381fa7(var_8c03895d.index);
                var_dd586ee5 = e_player function_4f34644b(var_8c03895d.index);
                if (isdefined(var_89eb65c1) && var_89eb65c1 && var_13c6f0bc == 0) {
                    if (isdefined(accolade.var_9ebe4012) && accolade.var_9ebe4012) {
                        e_player giveunlocktoken(1);
                    }
                    e_player addrankxpvalue("award_accolade", accolade.award_xp);
                    e_player addplayerstat("career_accolades", 1);
                }
                if (isdefined(var_89eb65c1) && (var_8c03895d.index == 2 || var_89eb65c1) && isdefined(var_dd586ee5)) {
                    e_player function_8992915e(var_8c03895d.index, var_89eb65c1);
                    accolade.is_completed = isdefined(var_89eb65c1) && var_89eb65c1;
                    e_player function_de8b9e62(var_8c03895d.index, var_dd586ee5);
                    e_player function_92050191(var_8c03895d.index, var_dd586ee5);
                    accolade.current_value = var_dd586ee5;
                    continue;
                }
                if (var_8c03895d.index == 0 && isdefined(var_dd586ee5)) {
                    e_player function_de8b9e62(var_8c03895d.index, var_dd586ee5, 1);
                    accolade.current_value = var_dd586ee5;
                }
            }
            e_player decorations::function_59f1fa79();
            /#
                e_player.var_eb7d74bb = 1;
            #/
        }
        uploadstats();
    }
}

// Namespace accolades
// Params 1, eflags: 0x0
// Checksum 0x3eaac124, Offset: 0x3838
// Size: 0x11c
function function_83f30558(accolade) {
    var_c3291c61 = self getdstat("PlayerStatsByMap", getrootmapname(), "accolades", accolade.index, "highestValue");
    currentvalue = accolade.current_value;
    if (!(isdefined(accolade.var_ab795acb) && accolade.var_ab795acb)) {
        var_fd9588d9 = currentvalue > var_c3291c61;
    }
    if (isdefined(var_fd9588d9) && var_fd9588d9) {
        self setdstat("PlayerStatsByMap", getrootmapname(), "accolades", accolade.index, "highestValue", currentvalue);
    }
}

// Namespace accolades
// Params 1, eflags: 0x0
// Checksum 0x52989734, Offset: 0x3960
// Size: 0x3b4
function commit(map_name) {
    if (!isdefined(map_name)) {
        map_name = level.script;
    }
    if (function_214e644a()) {
        return;
    }
    if (self == level) {
        foreach (player in level.players) {
            player commit(map_name);
            player function_cf1b719a();
        }
        return;
    }
    if (isarray(self savegame::function_36adbb9c("accolades"))) {
        foreach (var_5ba0c4e7, var_8c03895d in level.accolades) {
            accolade = self function_4f9d8dec(var_5ba0c4e7);
            if (!isdefined(accolade) || self function_3a7fd23a(accolade.index) != 0) {
                continue;
            }
            if (accolade.index == 2) {
                var_40a77a3a = self collectibles::function_ccb1e08d(getrootmapname());
                while (accolade.current_value < var_40a77a3a) {
                    self increment(var_5ba0c4e7);
                }
            }
            if (function_9ba543a3(var_5ba0c4e7, accolade.current_value)) {
                if ((accolade.index == 0 || accolade.index == 1) && !skipto::function_cb7247d8(map_name)) {
                    continue;
                }
                accolade.is_completed = 1;
                self function_8992915e(accolade.index, 1);
                self function_de8b9e62(accolade.index, accolade.current_value, 1);
                if (isdefined(accolade.var_9ebe4012) && accolade.var_9ebe4012) {
                    self giveunlocktoken(1);
                }
                self addplayerstat("career_accolades", 1);
            }
        }
        self decorations::function_59f1fa79();
    }
}

