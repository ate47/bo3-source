#using scripts/cp/teams/_teams;
#using scripts/cp/_util;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/cp/gametypes/_globallogic;
#using scripts/cp/gametypes/_loadout;
#using scripts/shared/system_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_93432369;

// Namespace namespace_93432369
// Params 0, eflags: 0x2
// Checksum 0xe3837110, Offset: 0x440
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("wager", &__init__, undefined, undefined);
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0xbca3a589, Offset: 0x480
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0xc7b1f1a8, Offset: 0x4b0
// Size: 0x138
function init() {
    if (gamemodeismode(3)) {
        level.wagermatch = 1;
        if (!isdefined(game["wager_pot"])) {
            game["wager_pot"] = 0;
            game["wager_initial_pot"] = 0;
        }
        game["dialog"]["wm_u2_online"] = "boost_gen_02";
        game["dialog"]["wm_in_the_money"] = "boost_gen_06";
        game["dialog"]["wm_oot_money"] = "boost_gen_07";
        level.poweruplist = [];
        callback::on_disconnect(&on_disconnect);
        callback::on_spawned(&init_player);
        level thread function_7bda789b();
    } else {
        level.wagermatch = 0;
    }
    level.takelivesondeath = 1;
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0xce2a1205, Offset: 0x5f0
// Size: 0xf4
function init_player() {
    self endon(#"disconnect");
    if (!isdefined(self.pers["wager"])) {
        self.pers["wager"] = 1;
        self.pers["wager_sideBetWinnings"] = 0;
        self.pers["wager_sideBetLosses"] = 0;
    }
    if (isdefined(level.var_1a4f6147) && (isdefined(level.var_1775f8bc) && level.var_1775f8bc || level.var_1a4f6147)) {
        self.pers["hasRadar"] = 1;
        self.hasspyplane = 1;
    } else {
        self.pers["hasRadar"] = 0;
        self.hasspyplane = 0;
    }
    self thread function_b5aaa823();
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0x98c517f9, Offset: 0x6f0
// Size: 0x26
function on_disconnect() {
    level endon(#"game_ended");
    self endon(#"player_eliminated");
    level notify(#"player_eliminated");
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0xa51ddbb3, Offset: 0x720
// Size: 0x1a4
function function_b5aaa823() {
    if (isdefined(self.pers["hasPaidWagerAnte"])) {
        return;
    }
    waittillframeend();
    codpoints = self rank::function_266f74f4();
    var_e2282c76 = getdvarint("scr_wagerBet");
    if (var_e2282c76 > codpoints) {
        var_e2282c76 = codpoints;
    }
    codpoints -= var_e2282c76;
    self rank::function_81238668(codpoints);
    if (!self islocaltohost()) {
        self function_c539ac66(var_e2282c76);
    }
    game["wager_pot"] = game["wager_pot"] + var_e2282c76;
    game["wager_initial_pot"] = game["wager_initial_pot"] + var_e2282c76;
    self.pers["hasPaidWagerAnte"] = 1;
    self addplayerstat("LIFETIME_BUYIN", var_e2282c76);
    self function_3128e1ef(0 - var_e2282c76);
    if (isdefined(level.var_92ff1caf)) {
        [[ level.var_92ff1caf ]](self, var_e2282c76);
    }
    self thread persistence::upload_stats_soon();
}

// Namespace namespace_93432369
// Params 1, eflags: 0x1 linked
// Checksum 0xc791af43, Offset: 0x8d0
// Size: 0xe6
function function_c539ac66(amount) {
    if (!isdefined(self) || !isplayer(self)) {
        return;
    }
    if (!isdefined(game["escrows"])) {
        game["escrows"] = [];
    }
    playerxuid = self getxuid();
    if (!isdefined(playerxuid)) {
        return;
    }
    var_5160a183 = spawnstruct();
    var_5160a183.xuid = playerxuid;
    var_5160a183.amount = amount;
    game["escrows"][game["escrows"].size] = var_5160a183;
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0xbace5110, Offset: 0x9c0
// Size: 0x94
function function_786d0921() {
    if (!isdefined(game["escrows"])) {
        return;
    }
    var_c8090ae3 = game["escrows"];
    var_dbed6161 = var_c8090ae3.size;
    for (i = 0; i < var_dbed6161; i++) {
        var_5160a183 = var_c8090ae3[i];
    }
    game["escrows"] = [];
}

// Namespace namespace_93432369
// Params 1, eflags: 0x1 linked
// Checksum 0xa1dc4869, Offset: 0xa60
// Size: 0x64
function function_3128e1ef(recentearnings) {
    var_37213530 = self persistence::get_recent_stat(1, 0, "score");
    self persistence::set_recent_stat(1, 0, "score", var_37213530 + recentearnings);
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0xc3abd9ed, Offset: 0xad0
// Size: 0x10
function prematch_period() {
    if (!level.wagermatch) {
        return;
    }
}

// Namespace namespace_93432369
// Params 0, eflags: 0x0
// Checksum 0x2e3e21f7, Offset: 0xae8
// Size: 0x40
function function_42c84bba() {
    if (level.wagermatch == 0) {
        return;
    }
    function_a33ac034();
    if (isdefined(level.var_e4f4bbb2)) {
        [[ level.var_e4f4bbb2 ]]();
    }
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0xad872a06, Offset: 0xb30
// Size: 0x6c
function function_a33ac034() {
    var_cb9e7f23 = !isdefined(level.var_7fb97d34) || !level.var_7fb97d34;
    if (!var_cb9e7f23) {
        return;
    }
    if (!level.teambased) {
        function_ca9d738();
        return;
    }
    function_d92072c1();
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0x8c8b83cc, Offset: 0xba8
// Size: 0x324
function function_ca9d738() {
    var_8e2656eb = level.placement["all"];
    var_21b0bdfa = array(0.5, 0.3, 0.2);
    if (var_8e2656eb.size == 2) {
        var_21b0bdfa = array(0.7, 0.3);
    } else if (var_8e2656eb.size == 1) {
        var_21b0bdfa = array(1);
    }
    function_4ed59a0(level.players, 0);
    if (isdefined(level.hostforcedend) && level.hostforcedend) {
        var_e2282c76 = getdvarint("scr_wagerBet");
        for (i = 0; i < var_8e2656eb.size; i++) {
            if (!var_8e2656eb[i] islocaltohost()) {
                var_8e2656eb[i].var_2db92ec2 = var_e2282c76;
            }
        }
        return;
    }
    if (level.players.size == 1) {
        game["escrows"] = undefined;
        return;
    }
    var_347f1b86 = 0;
    var_542d8772 = var_21b0bdfa[0];
    playergroup = [];
    playergroup[playergroup.size] = var_8e2656eb[0];
    for (i = 1; i < var_8e2656eb.size; i++) {
        if (var_8e2656eb[i].pers["score"] < playergroup[0].pers["score"]) {
            function_4ed59a0(playergroup, int(game["wager_pot"] * var_542d8772 / playergroup.size));
            playergroup = [];
            var_542d8772 = 0;
        }
        playergroup[playergroup.size] = var_8e2656eb[i];
        var_347f1b86++;
        if (isdefined(var_21b0bdfa[var_347f1b86])) {
            var_542d8772 += var_21b0bdfa[var_347f1b86];
        }
    }
    function_4ed59a0(playergroup, int(game["wager_pot"] * var_542d8772 / playergroup.size));
}

// Namespace namespace_93432369
// Params 0, eflags: 0x0
// Checksum 0xfdf2eb0a, Offset: 0xed8
// Size: 0x16a
function function_2f8dd175() {
    level.var_6dca7c12 = array([], [], []);
    var_8e2656eb = level.placement["all"];
    var_be087437 = array(var_8e2656eb[0].pers["score"], -1, -1);
    var_f3664349 = 0;
    for (index = 0; index < var_8e2656eb.size && var_f3664349 < var_be087437.size; index++) {
        player = var_8e2656eb[index];
        if (player.pers["score"] < var_be087437[var_f3664349]) {
            var_f3664349++;
            if (var_f3664349 >= level.var_6dca7c12.size) {
                break;
            }
            var_be087437[var_f3664349] = player.pers["score"];
        }
        level.var_6dca7c12[var_f3664349][level.var_6dca7c12[var_f3664349].size] = player;
    }
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0x15f44d12, Offset: 0x1050
// Size: 0x17c
function function_d92072c1() {
    winner = globallogic::determineteamwinnerbygamestat("teamScores");
    if (winner == "tie") {
        function_ca9d738();
        return;
    }
    var_559540e9 = [];
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        player.var_2db92ec2 = 0;
        if (player.pers["team"] == winner) {
            var_559540e9[var_559540e9.size] = player;
        }
    }
    if (var_559540e9.size == 0) {
        function_4ed59a0(level.players, getdvarint("scr_wagerBet"));
        return;
    }
    var_c6ca6bde = int(game["wager_pot"] / var_559540e9.size);
    function_4ed59a0(var_559540e9, var_c6ca6bde);
}

// Namespace namespace_93432369
// Params 2, eflags: 0x1 linked
// Checksum 0x10f37170, Offset: 0x11d8
// Size: 0x56
function function_4ed59a0(players, amount) {
    for (index = 0; index < players.size; index++) {
        players[index].var_2db92ec2 = amount;
    }
}

// Namespace namespace_93432369
// Params 0, eflags: 0x0
// Checksum 0x61e0f743, Offset: 0x1238
// Size: 0x17c
function function_c3fe1dc4() {
    level.var_b4140db7 = 1;
    if (level.wagermatch == 0) {
        return;
    }
    function_a33ac034();
    function_725ab30f();
    players = level.players;
    wait(0.5);
    var_8e2656eb = level.var_5a76e350;
    for (index = 0; index < players.size; index++) {
        player = players[index];
        if (isdefined(player.pers["wager_sideBetWinnings"])) {
            function_c8c7f67c(player, player.var_2db92ec2 + player.pers["wager_sideBetWinnings"]);
        } else {
            function_c8c7f67c(player, player.var_2db92ec2);
        }
        if (player.var_2db92ec2 > 0) {
            globallogic_score::updatewinstats(player);
        }
    }
    function_786d0921();
}

// Namespace namespace_93432369
// Params 2, eflags: 0x1 linked
// Checksum 0x3af68ad4, Offset: 0x13c0
// Size: 0xa4
function function_c8c7f67c(player, var_2194cace) {
    if (var_2194cace == 0) {
        return;
    }
    codpoints = player rank::function_266f74f4();
    player rank::function_81238668(codpoints + var_2194cace);
    player addplayerstat("LIFETIME_EARNINGS", var_2194cace);
    player function_3128e1ef(var_2194cace);
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0xb081c1c4, Offset: 0x1470
// Size: 0x210
function function_725ab30f() {
    var_20220e85 = array(-1, -1, -1);
    level.var_5a76e350 = [];
    for (index = 0; index < level.players.size; index++) {
        player = level.players[index];
        if (!isdefined(player.var_2db92ec2)) {
            player.var_2db92ec2 = 0;
        }
        if (player.var_2db92ec2 > var_20220e85[0]) {
            var_20220e85[2] = var_20220e85[1];
            var_20220e85[1] = var_20220e85[0];
            var_20220e85[0] = player.var_2db92ec2;
            level.var_5a76e350[2] = level.var_5a76e350[1];
            level.var_5a76e350[1] = level.var_5a76e350[0];
            level.var_5a76e350[0] = player;
            continue;
        }
        if (player.var_2db92ec2 > var_20220e85[1]) {
            var_20220e85[2] = var_20220e85[1];
            var_20220e85[1] = player.var_2db92ec2;
            level.var_5a76e350[2] = level.var_5a76e350[1];
            level.var_5a76e350[1] = player;
            continue;
        }
        if (player.var_2db92ec2 > var_20220e85[2]) {
            var_20220e85[2] = player.var_2db92ec2;
            level.var_5a76e350[2] = player;
        }
    }
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0xe1ce7833, Offset: 0x1688
// Size: 0x34
function function_fdf4c650() {
    if (isdefined(level.var_77929119) && level.var_77929119) {
        level notify(#"hash_6ae77d92");
        level waittill(#"hash_634b76a6");
    }
}

// Namespace namespace_93432369
// Params 0, eflags: 0x0
// Checksum 0x414e9065, Offset: 0x16c8
// Size: 0x5a
function function_8488655e() {
    level endon(#"hash_634b76a6");
    var_1306b7e0 = (level.var_3531290b - gettime()) / 1000;
    if (var_1306b7e0 < 0) {
        var_1306b7e0 = 0;
    }
    wait(var_1306b7e0);
    level notify(#"hash_634b76a6");
}

// Namespace namespace_93432369
// Params 0, eflags: 0x0
// Checksum 0x85aedcd7, Offset: 0x1730
// Size: 0x5e
function function_8545a8b9() {
    secondsleft = (level.var_3531290b - gettime()) / 1000;
    if (secondsleft <= 3) {
        return;
    }
    level.var_3531290b = gettime() + 3000;
    wait(3);
    level notify(#"hash_634b76a6");
}

// Namespace namespace_93432369
// Params 3, eflags: 0x0
// Checksum 0x38de2f16, Offset: 0x1798
// Size: 0x1d4
function function_937040bd(takeweapons, var_a9b5caef, weapon) {
    if (!isdefined(var_a9b5caef) || var_a9b5caef) {
        if (!isdefined(self.pers["wagerBodyAssigned"])) {
            self function_726c447b();
            self.pers["wagerBodyAssigned"] = 1;
        }
        self teams::function_37fd0a0f(self.team, weapon);
    }
    self clearperks();
    self.killstreak = [];
    self.pers["killstreaks"] = [];
    self.pers["killstreak_has_been_used"] = [];
    self.pers["killstreak_unique_id"] = [];
    if (!isdefined(takeweapons) || takeweapons) {
        self takeallweapons();
    }
    if (isdefined(self.pers["hasRadar"]) && self.pers["hasRadar"]) {
        self.hasspyplane = 1;
    }
    if (isdefined(self.powerups) && isdefined(self.powerups.size)) {
        for (i = 0; i < self.powerups.size; i++) {
            self function_61248dfa(self.powerups[i]);
        }
    }
    self function_962f5e7d();
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x1978
// Size: 0x4
function function_726c447b() {
    
}

// Namespace namespace_93432369
// Params 4, eflags: 0x1 linked
// Checksum 0xd39e8f5c, Offset: 0x1988
// Size: 0xea
function function_972d1b69(message, points, var_bdc1adde, announcement) {
    self endon(#"disconnect");
    size = self.var_2611c2db.size;
    self.var_2611c2db[size] = spawnstruct();
    self.var_2611c2db[size].message = message;
    self.var_2611c2db[size].points = points;
    self.var_2611c2db[size].var_bdc1adde = var_bdc1adde;
    self.var_2611c2db[size].announcement = announcement;
    self notify(#"hash_2528173");
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0x6374f4cd, Offset: 0x1a80
// Size: 0x1ac
function function_7bda789b() {
    level endon(#"game_ended");
    for (;;) {
        level waittill(#"player_eliminated");
        if (!isdefined(level.numlives) || !level.numlives) {
            continue;
        }
        wait(0.05);
        players = level.players;
        playersleft = 0;
        for (i = 0; i < players.size; i++) {
            if (isdefined(players[i].pers["lives"]) && players[i].pers["lives"] > 0) {
                playersleft++;
            }
        }
        if (playersleft == 2) {
            for (i = 0; i < players.size; i++) {
                players[i] function_972d1b69(%MP_HEADS_UP, 0, %MP_U2_ONLINE, "wm_u2_online");
                players[i].pers["hasRadar"] = 1;
                players[i].hasspyplane = 1;
                level.activeuavs[players[i] getentitynumber()]++;
            }
        }
    }
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0xc38202c6, Offset: 0x1c38
// Size: 0x124
function function_962f5e7d() {
    prevscoreplace = self.prevscoreplace;
    if (!isdefined(prevscoreplace)) {
        prevscoreplace = 1;
    }
    if (isdefined(level.var_1775f8bc) && level.var_1775f8bc) {
        if (prevscoreplace <= 3 && isdefined(self.score) && self.score > 0) {
            self unsetperk("specialty_gpsjammer");
        } else {
            self setperk("specialty_gpsjammer");
        }
        return;
    }
    if (isdefined(level.var_1a4f6147) && level.var_1a4f6147) {
        if (prevscoreplace == 1 && isdefined(self.score) && self.score > 0) {
            self unsetperk("specialty_gpsjammer");
            return;
        }
        self setperk("specialty_gpsjammer");
    }
}

// Namespace namespace_93432369
// Params 0, eflags: 0x1 linked
// Checksum 0xf51811b5, Offset: 0x1d68
// Size: 0x24e
function function_40cb89b3() {
    self notify(#"hash_a8628cdc");
    self endon(#"hash_a8628cdc");
    wait(0.05);
    globallogic::updateplacement();
    for (i = 0; i < level.placement["all"].size; i++) {
        prevscoreplace = level.placement["all"][i].prevscoreplace;
        if (!isdefined(prevscoreplace)) {
            prevscoreplace = 1;
        }
        currentscoreplace = i + 1;
        for (j = i - 1; j >= 0; j--) {
            if (level.placement["all"][i].score == level.placement["all"][j].score) {
                currentscoreplace--;
            }
        }
        wasinthemoney = prevscoreplace <= 3;
        isinthemoney = currentscoreplace <= 3;
        if (!wasinthemoney && isinthemoney) {
            level.placement["all"][i] announcer("wm_in_the_money");
        } else if (wasinthemoney && !isinthemoney) {
            level.placement["all"][i] announcer("wm_oot_money");
        }
        level.placement["all"][i].prevscoreplace = currentscoreplace;
        level.placement["all"][i] function_962f5e7d();
    }
}

// Namespace namespace_93432369
// Params 2, eflags: 0x1 linked
// Checksum 0xf3704e18, Offset: 0x1fc0
// Size: 0x14
function announcer(dialog, group) {
    
}

// Namespace namespace_93432369
// Params 4, eflags: 0x1 linked
// Checksum 0xf75f187, Offset: 0x1fe0
// Size: 0xa4
function function_90b8683c(name, type, displayname, var_f7cb8199) {
    powerup = spawnstruct();
    powerup.name = [];
    powerup.name[0] = name;
    powerup.type = type;
    powerup.displayname = displayname;
    powerup.var_f7cb8199 = var_f7cb8199;
    return powerup;
}

// Namespace namespace_93432369
// Params 4, eflags: 0x0
// Checksum 0x80e2ffd4, Offset: 0x2090
// Size: 0x106
function function_3a002997(name, type, displayname, var_f7cb8199) {
    if (!isdefined(level.poweruplist)) {
        level.poweruplist = [];
    }
    for (i = 0; i < level.poweruplist.size; i++) {
        if (level.poweruplist[i].displayname == displayname) {
            level.poweruplist[i].name[level.poweruplist[i].name.size] = name;
            return;
        }
    }
    powerup = function_90b8683c(name, type, displayname, var_f7cb8199);
    level.poweruplist[level.poweruplist.size] = powerup;
}

// Namespace namespace_93432369
// Params 1, eflags: 0x1 linked
// Checksum 0xc163a2f2, Offset: 0x21a0
// Size: 0x52
function function_fe739d8b(powerup) {
    return function_90b8683c(powerup.name[0], powerup.type, powerup.displayname, powerup.var_f7cb8199);
}

// Namespace namespace_93432369
// Params 1, eflags: 0x1 linked
// Checksum 0xdff08766, Offset: 0x2200
// Size: 0x2ce
function function_61248dfa(powerup) {
    weapon = level.weaponnone;
    switch (powerup.type) {
    case 31:
    case 32:
    case 33:
    case 34:
    case 35:
        weapon = getweapon(powerup.name[0]);
        break;
    }
    switch (powerup.type) {
    case 32:
        self giveweapon(weapon);
        self switchtoweapon(weapon);
        break;
    case 34:
        self giveweapon(weapon);
        break;
    case 31:
        self giveweapon(weapon);
        self loadout::function_8de272c8(weapon, 1);
        self setactionslot(1, "weapon", weapon);
        break;
    case 33:
        self setoffhandprimaryclass(weapon);
        self giveweapon(weapon);
        self setweaponammoclip(weapon, 2);
        break;
    case 35:
        self setoffhandsecondaryclass(weapon);
        self giveweapon(weapon);
        self setweaponammoclip(weapon, 2);
        break;
    case 37:
        for (i = 0; i < powerup.name.size; i++) {
            self setperk(powerup.name[i]);
        }
        break;
    case 38:
        self.scoremultiplier = powerup.name[0];
        break;
    }
}

// Namespace namespace_93432369
// Params 2, eflags: 0x0
// Checksum 0xbf76e81a, Offset: 0x24d8
// Size: 0x124
function give_powerup(powerup, var_f5291508) {
    if (!isdefined(self.powerups)) {
        self.powerups = [];
    }
    powerupindex = self.powerups.size;
    self.powerups[powerupindex] = function_fe739d8b(powerup);
    for (i = 0; i < powerup.name.size; i++) {
        self.powerups[powerupindex].name[self.powerups[powerupindex].name.size] = powerup.name[i];
    }
    self function_61248dfa(self.powerups[powerupindex]);
    self thread function_41ce9a77(powerupindex, var_f5291508);
}

// Namespace namespace_93432369
// Params 1, eflags: 0x0
// Checksum 0xab27f0c1, Offset: 0x2608
// Size: 0x2d4
function function_b5a047c7(powerupindex) {
    if (!isdefined(self) || !isdefined(self.powerups) || !isdefined(self.powerups[powerupindex]) || !isdefined(self.powerups[powerupindex].var_3015426)) {
        return;
    }
    self endon(#"disconnect");
    self endon(#"delete");
    self endon(#"hash_923798b8");
    var_245caf8b = 1.5;
    pulsetime = 0.5;
    hud_elem = self.powerups[powerupindex].var_3015426;
    if (isdefined(hud_elem.animating) && hud_elem.animating) {
        return;
    }
    origx = hud_elem.x;
    origy = hud_elem.y;
    var_3b9a144e = hud_elem.width;
    var_75c15b8f = hud_elem.height;
    var_8abb9cab = var_3b9a144e * var_245caf8b;
    var_1c9d9168 = var_75c15b8f * var_245caf8b;
    xoffset = (var_8abb9cab - var_3b9a144e) / 2;
    yoffset = (var_1c9d9168 - var_75c15b8f) / 2;
    hud_elem scaleovertime(0.05, int(var_8abb9cab), int(var_1c9d9168));
    hud_elem moveovertime(0.05);
    hud_elem.x = origx - xoffset;
    hud_elem.y = origy - yoffset;
    wait(0.05);
    hud_elem scaleovertime(pulsetime, var_3b9a144e, var_75c15b8f);
    hud_elem moveovertime(pulsetime);
    hud_elem.x = origx;
    hud_elem.y = origy;
}

// Namespace namespace_93432369
// Params 2, eflags: 0x1 linked
// Checksum 0xbae66d01, Offset: 0x28e8
// Size: 0xa20
function function_41ce9a77(powerupindex, var_f5291508) {
    self endon(#"disconnect");
    self endon(#"delete");
    self endon(#"hash_923798b8");
    if (!isdefined(var_f5291508)) {
        var_f5291508 = 1;
    }
    var_93ad7553 = level.inprematchperiod;
    var_69d965de = 320;
    var_9c923982 = 40;
    if (self issplitscreen()) {
        var_69d965de = 120;
        var_9c923982 = 35;
    }
    if (isdefined(self.powerups[powerupindex].hud_elem)) {
        self.powerups[powerupindex].hud_elem destroy();
    }
    self.powerups[powerupindex].hud_elem = newclienthudelem(self);
    self.powerups[powerupindex].hud_elem.fontscale = 1.5;
    self.powerups[powerupindex].hud_elem.x = -125;
    self.powerups[powerupindex].hud_elem.y = var_69d965de - var_9c923982 * powerupindex;
    self.powerups[powerupindex].hud_elem.alignx = "left";
    self.powerups[powerupindex].hud_elem.aligny = "middle";
    self.powerups[powerupindex].hud_elem.horzalign = "user_right";
    self.powerups[powerupindex].hud_elem.vertalign = "user_top";
    self.powerups[powerupindex].hud_elem.color = (1, 1, 1);
    self.powerups[powerupindex].hud_elem.foreground = 1;
    self.powerups[powerupindex].hud_elem.hidewhendead = 0;
    self.powerups[powerupindex].hud_elem.hidewheninmenu = 1;
    self.powerups[powerupindex].hud_elem.archived = 0;
    self.powerups[powerupindex].hud_elem.alpha = 0;
    self.powerups[powerupindex].hud_elem settext(self.powerups[powerupindex].displayname);
    var_8325b365 = 40;
    iconsize = 32;
    if (isdefined(self.powerups[powerupindex].var_3015426)) {
        self.powerups[powerupindex].var_3015426 destroy();
    }
    if (var_f5291508) {
        self.powerups[powerupindex].var_3015426 = self hud::createicon(self.powerups[powerupindex].var_f7cb8199, var_8325b365, var_8325b365);
        self.powerups[powerupindex].var_3015426.animating = 1;
    } else {
        self.powerups[powerupindex].var_3015426 = self hud::createicon(self.powerups[powerupindex].var_f7cb8199, iconsize, iconsize);
    }
    self.powerups[powerupindex].var_3015426.x = self.powerups[powerupindex].hud_elem.x - 5 - iconsize / 2 - var_8325b365 / 2;
    self.powerups[powerupindex].var_3015426.y = var_69d965de - var_9c923982 * powerupindex - var_8325b365 / 2;
    self.powerups[powerupindex].var_3015426.horzalign = "user_right";
    self.powerups[powerupindex].var_3015426.vertalign = "user_top";
    self.powerups[powerupindex].var_3015426.color = (1, 1, 1);
    self.powerups[powerupindex].var_3015426.foreground = 1;
    self.powerups[powerupindex].var_3015426.hidewhendead = 0;
    self.powerups[powerupindex].var_3015426.hidewheninmenu = 1;
    self.powerups[powerupindex].var_3015426.archived = 0;
    self.powerups[powerupindex].var_3015426.alpha = 1;
    if (!var_93ad7553 && var_f5291508) {
        self thread function_972d1b69(self.powerups[powerupindex].displayname, 0, %MP_BONUS_ACQUIRED);
    }
    pulsetime = 0.5;
    if (var_f5291508) {
        self.powerups[powerupindex].hud_elem fadeovertime(pulsetime);
        self.powerups[powerupindex].var_3015426 scaleovertime(pulsetime, iconsize, iconsize);
        self.powerups[powerupindex].var_3015426.width = iconsize;
        self.powerups[powerupindex].var_3015426.height = iconsize;
        self.powerups[powerupindex].var_3015426 moveovertime(pulsetime);
    }
    self.powerups[powerupindex].hud_elem.alpha = 1;
    self.powerups[powerupindex].var_3015426.x = self.powerups[powerupindex].hud_elem.x - 5 - iconsize;
    self.powerups[powerupindex].var_3015426.y = var_69d965de - var_9c923982 * powerupindex - iconsize / 2;
    if (var_f5291508) {
        wait(pulsetime);
    }
    if (level.inprematchperiod) {
        level waittill(#"prematch_over");
    } else if (var_f5291508) {
        wait(pulsetime);
    }
    if (var_93ad7553 && var_f5291508) {
        self thread function_972d1b69(self.powerups[powerupindex].displayname, 0, %MP_BONUS_ACQUIRED);
    }
    wait(1.5);
    for (i = 0; i <= powerupindex; i++) {
        self.powerups[i].hud_elem fadeovertime(0.25);
        self.powerups[i].hud_elem.alpha = 0;
    }
    wait(0.25);
    for (i = 0; i <= powerupindex; i++) {
        self.powerups[i].var_3015426 moveovertime(0.25);
        self.powerups[i].var_3015426.x = 0 - iconsize;
        self.powerups[i].var_3015426.horzalign = "user_right";
    }
    self.powerups[powerupindex].var_3015426.animating = 0;
}

// Namespace namespace_93432369
// Params 0, eflags: 0x0
// Checksum 0xfba8b50c, Offset: 0x3310
// Size: 0xf8
function function_903348b0() {
    self notify(#"hash_923798b8");
    if (isdefined(self.powerups) && isdefined(self.powerups.size)) {
        for (i = 0; i < self.powerups.size; i++) {
            if (isdefined(self.powerups[i].hud_elem)) {
                self.powerups[i].hud_elem destroy();
            }
            if (isdefined(self.powerups[i].var_3015426)) {
                self.powerups[i].var_3015426 destroy();
            }
        }
    }
    self.powerups = [];
}

// Namespace namespace_93432369
// Params 3, eflags: 0x0
// Checksum 0xd728dc6f, Offset: 0x3410
// Size: 0xb4
function function_a58fccc1(name, incvalue, statname) {
    if (!isdefined(self.var_9c5ebb26)) {
        self.var_9c5ebb26 = [];
    }
    if (!isdefined(self.var_9c5ebb26[name])) {
        self.var_9c5ebb26[name] = [];
    }
    if (!isdefined(self.var_9c5ebb26[name][statname])) {
        self.var_9c5ebb26[name][statname] = 0;
    }
    self.var_9c5ebb26[name][statname] = self.var_9c5ebb26[name][statname] + incvalue;
}

// Namespace namespace_93432369
// Params 1, eflags: 0x1 linked
// Checksum 0xe5416fc3, Offset: 0x34d0
// Size: 0x12e
function function_5bd30bb5(statname) {
    if (!isdefined(self.var_9c5ebb26)) {
        return undefined;
    }
    bestweapon = undefined;
    highestvalue = 0;
    var_13f4a24f = getarraykeys(self.var_9c5ebb26);
    for (i = 0; i < var_13f4a24f.size; i++) {
        weaponstats = self.var_9c5ebb26[var_13f4a24f[i]];
        if (!isdefined(weaponstats[statname]) || !getbaseweaponitemindex(var_13f4a24f[i])) {
            continue;
        }
        if (!isdefined(bestweapon) || weaponstats[statname] > highestvalue) {
            bestweapon = var_13f4a24f[i];
            highestvalue = weaponstats[statname];
        }
    }
    return bestweapon;
}

// Namespace namespace_93432369
// Params 0, eflags: 0x0
// Checksum 0x85a53a2b, Offset: 0x3608
// Size: 0x166
function function_f29de9c2() {
    var_975e497a = self function_5bd30bb5("kills");
    var_786532a9 = 0;
    if (isdefined(var_975e497a)) {
        var_786532a9 = self.var_9c5ebb26[var_975e497a]["kills"];
    } else {
        var_975e497a = self function_5bd30bb5("timeUsed");
    }
    if (!isdefined(var_975e497a)) {
        var_975e497a = "";
    }
    self persistence::function_2eb5e93("topWeaponItemIndex", getbaseweaponitemindex(var_975e497a));
    self persistence::function_2eb5e93("topWeaponKills", var_786532a9);
    if (isdefined(level.var_8619115e)) {
        self [[ level.var_8619115e ]]();
        return;
    }
    for (i = 0; i < 3; i++) {
        self persistence::function_2eb5e93("wagerAwards", 0, i);
    }
}

