#using scripts/mp/_util;
#using scripts/shared/sound_shared;
#using scripts/shared/util_shared;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;
#using scripts/codescripts/struct;

#namespace namespace_e21b687a;

// Namespace namespace_e21b687a
// Params 0, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_ebba863f
// Checksum 0x8d9382d6, Offset: 0x290
// Size: 0x80
function function_ebba863f() {
    var_f180d141 = 0;
    var_39154cad = tablelookupfindcoreasset("gamedata/tables/mp/teamops.csv");
    if (isdefined(var_39154cad)) {
        var_f180d141 = 1;
    }
    assert(var_f180d141, "allies" + "allies");
    return var_39154cad;
}

// Namespace namespace_e21b687a
// Params 0, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_c35e6aab
// Checksum 0x3a383364, Offset: 0x318
// Size: 0x47c
function init() {
    game["teamops"] = spawnstruct();
    game["teamops"].data = [];
    game["teamops"].teamprogress = [];
    game["teamops"].var_a295ba07 = undefined;
    foreach (team in level.teams) {
        game["teamops"].teamprogress[team] = 0;
    }
    level.var_2dfc4869 = &function_4c970571;
    tableid = function_ebba863f();
    assert(isdefined(tableid));
    if (!isdefined(tableid)) {
        game["teamops"].var_1687cf61 = 0;
        return;
    }
    for (row = 1; row < 256; row++) {
        name = tablelookupcolumnforrow(tableid, row, 0);
        if (name != "") {
            game["teamops"].data[name] = spawnstruct();
            game["teamops"].data[name].description = tablelookupcolumnforrow(tableid, row, 1);
            game["teamops"].data[name].var_95a7033b = tablelookupcolumnforrow(tableid, row, 2);
            game["teamops"].data[name].var_3795699a = tablelookupcolumnforrow(tableid, row, 3);
            game["teamops"].data[name].var_3e8aa3fe = tablelookupcolumnforrow(tableid, row, 4);
            game["teamops"].data[name].count = int(tablelookupcolumnforrow(tableid, row, 5));
            game["teamops"].data[name].time = int(tablelookupcolumnforrow(tableid, row, 6));
            game["teamops"].data[name].modes = strtok(tablelookupcolumnforrow(tableid, row, 7), ",");
            game["teamops"].data[name].rewards = strtok(tablelookupcolumnforrow(tableid, row, 8), ",");
        }
    }
    game["teamops"].var_3e7804b0 = 1;
}

// Namespace namespace_e21b687a
// Params 1, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_5c484ae4
// Checksum 0x3ea0880f, Offset: 0x7a0
// Size: 0x90
function getid(name) {
    tableid = function_ebba863f();
    for (row = 1; row < 256; row++) {
        _name = tablelookupcolumnforrow(tableid, row, 0);
        if (name == _name) {
            return row;
        }
    }
    return 0;
}

// Namespace namespace_e21b687a
// Params 1, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_f8b6e626
// Checksum 0xfeeff9d9, Offset: 0x838
// Size: 0xa6
function function_f8b6e626(name) {
    var_e21b687a = game["teamops"].data[name];
    if (var_e21b687a.modes.size == 0) {
        return true;
    }
    for (var_c506f9a7 = 0; var_c506f9a7 < var_e21b687a.modes.size; var_c506f9a7++) {
        if (var_e21b687a.modes[var_c506f9a7] == level.gametype) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_e21b687a
// Params 1, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_a2630ab8
// Checksum 0xe7e88403, Offset: 0x8e8
// Size: 0x3bc
function function_a2630ab8(name) {
    level notify(#"hash_6521c6ed");
    level.var_29b97631 = undefined;
    if (!function_f8b6e626(name)) {
        return;
    }
    function_48a94128(0);
    var_8765445a = getdvarint("teamOpsPreanounceTime", 5);
    foreach (team in level.teams) {
        globallogic_audio::leader_dialog("teamops_preannounce", team);
    }
    wait(var_8765445a);
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (isdefined(player)) {
            player playlocalsound("uin_objective_updated");
        }
    }
    var_e21b687a = game["teamops"].data[name];
    game["teamops"].var_a295ba07 = name;
    game["teamops"].var_cdbaab59 = getid(name);
    game["teamops"].var_b7b1a955 = randomintrange(0, var_e21b687a.rewards.size);
    game["teamops"].var_f5dde2d3 = var_e21b687a.rewards[game["teamops"].var_b7b1a955];
    game["teamops"].var_dfb9b8a5 = gettime();
    foreach (team in level.teams) {
        game["teamops"].teamprogress[team] = 0;
    }
    wait(0.1);
    function_cf51fcaa(game["teamops"].var_cdbaab59, game["teamops"].var_b7b1a955, game["teamops"].var_dfb9b8a5, var_e21b687a.time);
    wait(0.1);
    function_48a94128(1);
    function_24caac88("axis", 0);
    function_24caac88("allies", 0);
    level thread function_a6c201ca();
}

// Namespace namespace_e21b687a
// Params 0, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_a6c201ca
// Checksum 0x7076c147, Offset: 0xcb0
// Size: 0x158
function function_a6c201ca() {
    while (isdefined(game["teamops"].var_a295ba07)) {
        time = game["teamops"].data[game["teamops"].var_a295ba07].time;
        if (isdefined(time) && time > 0) {
            elapsed = gettime() - game["teamops"].var_dfb9b8a5;
            if (elapsed > time * 1000) {
                function_2f0859a2();
                foreach (team in level.teams) {
                    globallogic_audio::leader_dialog("teamops_timeout", team);
                }
            }
        }
        wait(0.5);
    }
}

// Namespace namespace_e21b687a
// Params 0, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_2f0859a2
// Checksum 0x5a380dc, Offset: 0xe10
// Size: 0xe4
function function_2f0859a2() {
    function_48a94128(0);
    game["teamops"].var_a295ba07 = undefined;
    game["teamops"].var_f5dde2d3 = undefined;
    game["teamops"].var_dfb9b8a5 = undefined;
    foreach (team in level.teams) {
        game["teamops"].teamprogress[team] = 0;
    }
}

// Namespace namespace_e21b687a
// Params 2, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_4c970571
// Checksum 0x4e480130, Offset: 0xf00
// Size: 0x84
function function_4c970571(event, player) {
    var_a295ba07 = game["teamops"].var_a295ba07;
    if (isplayer(player) && isdefined(var_a295ba07)) {
        level function_f0900ae5(event, player, player.team);
    }
}

// Namespace namespace_e21b687a
// Params 3, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_f0900ae5
// Checksum 0x42bb0005, Offset: 0xf90
// Size: 0x214
function function_f0900ae5(event, player, team) {
    var_a295ba07 = game["teamops"].var_a295ba07;
    var_e21b687a = game["teamops"].data[var_a295ba07];
    if (isdefined(var_e21b687a.var_95a7033b) && event == var_e21b687a.var_95a7033b) {
        game["teamops"].teamprogress[team] = game["teamops"].teamprogress[team] + 1;
        level function_3d345413(event, player, team);
    }
    if (isdefined(var_e21b687a.var_3795699a) && event == var_e21b687a.var_3795699a) {
        game["teamops"].teamprogress[team] = game["teamops"].teamprogress[team] - 1;
        if (game["teamops"].teamprogress[team] < 0) {
            game["teamops"].teamprogress[team] = 0;
        }
        level function_3d345413(event, player, team);
    }
    if (isdefined(var_e21b687a.var_3e8aa3fe) && event == var_e21b687a.var_3e8aa3fe) {
        game["teamops"].teamprogress[team] = 0;
        level function_3d345413(event, player, team);
    }
}

// Namespace namespace_e21b687a
// Params 3, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_3d345413
// Checksum 0x48cd8f19, Offset: 0x11b0
// Size: 0x12c
function function_3d345413(event, player, team) {
    var_a295ba07 = game["teamops"].var_a295ba07;
    var_e21b687a = game["teamops"].data[var_a295ba07];
    var_32c9792a = var_e21b687a.count;
    progress = int(100 * game["teamops"].teamprogress[team] / var_32c9792a);
    function_24caac88(team, progress);
    if (game["teamops"].teamprogress[team] >= var_e21b687a.count) {
        if (isdefined(player)) {
            level thread function_cfe86919(player, team);
        }
    }
}

// Namespace namespace_e21b687a
// Params 2, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_cfe86919
// Checksum 0x387fc9f5, Offset: 0x12e8
// Size: 0xe4
function function_cfe86919(player, team) {
    game["teamops"].var_a295ba07 = undefined;
    wait(0.5);
    function_48a94128(0);
    wait(2);
    globallogic_audio::leader_dialog("teamops_win", team);
    globallogic_audio::leader_dialog_for_other_teams("teamops_lose", team);
    player killstreaks::give(game["teamops"].var_f5dde2d3, 1);
    wait(2);
    player killstreaks::usekillstreak(game["teamops"].var_f5dde2d3, 1);
}

// Namespace namespace_e21b687a
// Params 0, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_d290ebfa
// Checksum 0x70b72ade, Offset: 0x13d8
// Size: 0x6c
function main() {
    thread function_4dd504b0();
    level.var_17abecec = getdvarint("teamOpsKillsCountTrigger_" + level.gametype, 37);
    if (level.var_17abecec > 0) {
        level.var_29b97631 = &onplayerkilled;
    }
}

// Namespace namespace_e21b687a
// Params 0, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_3640f8f4
// Checksum 0x8ebd6507, Offset: 0x1450
// Size: 0x108
function function_3640f8f4() {
    operations = strtok(getdvarstring("teamOpsName"), ",");
    for (i = 0; i < 20; i++) {
        operation = operations[randomintrange(0, operations.size)];
        if (function_f8b6e626(operation)) {
            return operation;
        }
    }
    for (i = 0; i < operations.size; i++) {
        operation = operations[i];
        if (function_f8b6e626(operation)) {
            return operation;
        }
    }
    return undefined;
}

// Namespace namespace_e21b687a
// Params 0, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_4dd504b0
// Checksum 0x577855d9, Offset: 0x1560
// Size: 0x162
function function_4dd504b0() {
    level endon(#"hash_6521c6ed");
    if (isdefined(level.inprematchperiod) && level.inprematchperiod) {
        level waittill(#"prematch_over");
    }
    var_b7663294 = function_3640f8f4();
    if (!isdefined(var_b7663294)) {
        return;
    }
    startdelay = getdvarint("teamOpsStartDelay_" + level.gametype, 300);
    while (true) {
        if (isdefined(game["teamops"].var_a295ba07)) {
            if (getdvarint("scr_stop_teamops") == 1) {
                function_2f0859a2();
                setdvar("scr_stop_teamops", 0);
            }
        }
        timepassed = globallogic_utils::gettimepassed() / 1000;
        var_a2630ab8 = 0;
        if (timepassed > startdelay) {
            level thread function_a2630ab8(var_b7663294);
            break;
        }
        wait(1);
    }
}

// Namespace namespace_e21b687a
// Params 9, eflags: 0x1 linked
// namespace_e21b687a<file_0>::function_c2658b46
// Checksum 0xb32abd91, Offset: 0x16d0
// Size: 0x15c
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    level endon(#"hash_6521c6ed");
    if (isplayer(attacker) == 0 || attacker.team == self.team) {
        return;
    }
    if (!isdefined(level.var_2b46855e)) {
        level.var_2b46855e = [];
    }
    if (!isdefined(level.var_2b46855e[attacker.team])) {
        level.var_2b46855e[attacker.team] = 0;
    }
    level.var_2b46855e[attacker.team]++;
    if (level.var_2b46855e[attacker.team] >= level.var_17abecec) {
        var_b7663294 = function_3640f8f4();
        if (!isdefined(var_b7663294)) {
            return;
        }
        level thread function_a2630ab8(var_b7663294);
    }
}

