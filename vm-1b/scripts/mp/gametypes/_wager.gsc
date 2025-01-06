#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_loadout;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/teams/_teams;
#using scripts/shared/callbacks_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/system_shared;

#namespace wager;

// Namespace wager
// Params 0, eflags: 0x2
// Checksum 0xd30322cf, Offset: 0x4a0
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("wager", &__init__, undefined, undefined);
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x8816f4c0, Offset: 0x4d8
// Size: 0x22
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0xbfad212e, Offset: 0x508
// Size: 0xfe
function init() {
    if (gamemodeismode(3)) {
        level.wagermatch = 1;
        InvalidOpCode(0x54, "wager_pot");
        // Unknown operator (0x54, t7_1b, PC)
    }
    level.wagermatch = 0;
    level.takelivesondeath = 1;
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x1263e2ea, Offset: 0x610
// Size: 0xca
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

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0xdc3692c7, Offset: 0x6e8
// Size: 0x1b
function on_disconnect() {
    level endon(#"game_ended");
    self endon(#"player_eliminated");
    level notify(#"player_eliminated");
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x1707011e, Offset: 0x710
// Size: 0xa9
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
    InvalidOpCode(0x54, "wager_pot");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace wager
// Params 1, eflags: 0x0
// Checksum 0xac23ee05, Offset: 0x858
// Size: 0x3d
function function_c539ac66(amount) {
    if (!isdefined(self) || !isplayer(self)) {
        return;
    }
    InvalidOpCode(0x54, "escrows");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0xc39e15f, Offset: 0x908
// Size: 0x29
function function_786d0921() {
    InvalidOpCode(0x54, "escrows");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace wager
// Params 1, eflags: 0x0
// Checksum 0x9fd12e13, Offset: 0x978
// Size: 0x4a
function function_3128e1ef(recentearnings) {
    var_37213530 = self persistence::get_recent_stat(1, 0, "score");
    self persistence::set_recent_stat(1, 0, "score", var_37213530 + recentearnings);
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x9b5fcecd, Offset: 0x9d0
// Size: 0xe
function prematch_period() {
    if (!level.wagermatch) {
        return;
    }
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x8683df5a, Offset: 0x9e8
// Size: 0x38
function function_42c84bba() {
    if (level.wagermatch == 0) {
        return;
    }
    function_a33ac034();
    if (isdefined(level.var_e4f4bbb2)) {
        [[ level.var_e4f4bbb2 ]]();
    }
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x229a9dee, Offset: 0xa28
// Size: 0x52
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

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0xd4a99392, Offset: 0xa88
// Size: 0x24a
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
        InvalidOpCode(0xc8, "escrows");
        // Unknown operator (0xc8, t7_1b, PC)
    }
    var_347f1b86 = 0;
    var_542d8772 = var_21b0bdfa[0];
    playergroup = [];
    playergroup[playergroup.size] = var_8e2656eb[0];
    for (i = 1; i < var_8e2656eb.size; i++) {
        if (var_8e2656eb[i].pers["score"] < playergroup[0].pers["score"]) {
            InvalidOpCode(0x54, "wager_pot");
            // Unknown operator (0x54, t7_1b, PC)
        }
        playergroup[playergroup.size] = var_8e2656eb[i];
        var_347f1b86++;
        if (isdefined(var_21b0bdfa[var_347f1b86])) {
            var_542d8772 += var_21b0bdfa[var_347f1b86];
        }
    }
    InvalidOpCode(0x54, "wager_pot");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0xaa38b017, Offset: 0xce0
// Size: 0xff
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

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x17c1467a, Offset: 0xde8
// Size: 0xf9
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
    InvalidOpCode(0x54, "wager_pot");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace wager
// Params 2, eflags: 0x0
// Checksum 0x7be2b551, Offset: 0xf18
// Size: 0x3d
function function_4ed59a0(players, amount) {
    for (index = 0; index < players.size; index++) {
        players[index].var_2db92ec2 = amount;
    }
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x33df0f83, Offset: 0xf60
// Size: 0x122
function function_c3fe1dc4() {
    level.var_b4140db7 = 1;
    if (level.wagermatch == 0) {
        return;
    }
    function_a33ac034();
    function_725ab30f();
    players = level.players;
    wait 0.5;
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

// Namespace wager
// Params 2, eflags: 0x0
// Checksum 0xffbc9de1, Offset: 0x1090
// Size: 0x72
function function_c8c7f67c(player, var_2194cace) {
    if (var_2194cace == 0) {
        return;
    }
    codpoints = player rank::function_266f74f4();
    player rank::function_81238668(codpoints + var_2194cace);
    player addplayerstat("LIFETIME_EARNINGS", var_2194cace);
    player function_3128e1ef(var_2194cace);
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x5ac86765, Offset: 0x1110
// Size: 0x169
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

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x8930baa9, Offset: 0x1288
// Size: 0x2c
function function_fdf4c650() {
    if (isdefined(level.sidebet) && level.sidebet) {
        level notify(#"hash_6ae77d92");
        level waittill(#"hash_634b76a6");
    }
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x90c5cb44, Offset: 0x12c0
// Size: 0x3f
function function_8488655e() {
    level endon(#"hash_634b76a6");
    var_1306b7e0 = (level.var_3531290b - gettime()) / 1000;
    if (var_1306b7e0 < 0) {
        var_1306b7e0 = 0;
    }
    wait var_1306b7e0;
    level notify(#"hash_634b76a6");
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x4f7e2889, Offset: 0x1308
// Size: 0x43
function function_8545a8b9() {
    secondsleft = (level.var_3531290b - gettime()) / 1000;
    if (secondsleft <= 3) {
        return;
    }
    level.var_3531290b = gettime() + 3000;
    wait 3;
    level notify(#"hash_634b76a6");
}

// Namespace wager
// Params 3, eflags: 0x0
// Checksum 0x8b6fd226, Offset: 0x1358
// Size: 0x172
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
            self apply_powerup(self.powerups[i]);
        }
    }
    self function_962f5e7d();
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x14d8
// Size: 0x2
function function_726c447b() {
    
}

// Namespace wager
// Params 4, eflags: 0x0
// Checksum 0x22a6c919, Offset: 0x14e8
// Size: 0xab
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

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x8f57e93, Offset: 0x15a0
// Size: 0x195
function function_7bda789b() {
    level endon(#"game_ended");
    for (;;) {
        level waittill(#"player_eliminated");
        if (!isdefined(level.numlives) || !level.numlives) {
            continue;
        }
        wait 0.05;
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
                if (level.teambased) {
                    assert(isdefined(players[i].team));
                    level.activeplayeruavs[players[i].team]++;
                } else {
                    level.activeplayeruavs[players[i] getentitynumber()]++;
                }
                level.activeplayeruavs[players[i] getentitynumber()]++;
            }
        }
    }
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x49c586c3, Offset: 0x1740
// Size: 0xea
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

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0xf0f820cc, Offset: 0x1838
// Size: 0x1b1
function function_40cb89b3() {
    self notify(#"hash_a8628cdc");
    self endon(#"hash_a8628cdc");
    wait 0.05;
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

// Namespace wager
// Params 2, eflags: 0x0
// Checksum 0xc06f2e7f, Offset: 0x19f8
// Size: 0x2a
function announcer(dialog, group) {
    self globallogic_audio::leader_dialog_on_player(dialog, group);
}

// Namespace wager
// Params 4, eflags: 0x0
// Checksum 0x87e57622, Offset: 0x1a30
// Size: 0x78
function function_90b8683c(name, type, displayname, var_f7cb8199) {
    powerup = spawnstruct();
    powerup.name = [];
    powerup.name[0] = name;
    powerup.type = type;
    powerup.displayname = displayname;
    powerup.var_f7cb8199 = var_f7cb8199;
    return powerup;
}

// Namespace wager
// Params 4, eflags: 0x0
// Checksum 0x76af52b3, Offset: 0x1ab0
// Size: 0xc7
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

// Namespace wager
// Params 1, eflags: 0x0
// Checksum 0x895f176b, Offset: 0x1b80
// Size: 0x41
function function_fe739d8b(powerup) {
    return function_90b8683c(powerup.name[0], powerup.type, powerup.displayname, powerup.var_f7cb8199);
}

// Namespace wager
// Params 1, eflags: 0x0
// Checksum 0xa273709b, Offset: 0x1bd0
// Size: 0x265
function apply_powerup(powerup) {
    weapon = level.weaponnone;
    switch (powerup.type) {
    case "equipment":
    case "primary":
    case "primary_grenade":
    case "secondary":
    case "secondary_grenade":
        weapon = getweapon(powerup.name[0]);
        break;
    }
    switch (powerup.type) {
    case "primary":
        self giveweapon(weapon);
        self switchtoweapon(weapon);
        break;
    case "secondary":
        self giveweapon(weapon);
        break;
    case "equipment":
        self giveweapon(weapon);
        self loadout::function_8de272c8(weapon, 1);
        self setactionslot(1, "weapon", weapon);
        break;
    case "primary_grenade":
        self setoffhandprimaryclass(weapon);
        self giveweapon(weapon);
        self setweaponammoclip(weapon, 2);
        break;
    case "secondary_grenade":
        self setoffhandsecondaryclass(weapon);
        self giveweapon(weapon);
        self setweaponammoclip(weapon, 2);
        break;
    case "perk":
        for (i = 0; i < powerup.name.size; i++) {
            self setperk(powerup.name[i]);
        }
        break;
    case "killstreak":
        self killstreaks::give(powerup.name[0]);
        break;
    case "score_multiplier":
        self.scoremultiplier = powerup.name[0];
        break;
    }
}

// Namespace wager
// Params 2, eflags: 0x0
// Checksum 0xebaae4c0, Offset: 0x1e40
// Size: 0xd2
function give_powerup(powerup, var_f5291508) {
    if (!isdefined(self.powerups)) {
        self.powerups = [];
    }
    powerupindex = self.powerups.size;
    self.powerups[powerupindex] = function_fe739d8b(powerup);
    for (i = 0; i < powerup.name.size; i++) {
        self.powerups[powerupindex].name[self.powerups[powerupindex].name.size] = powerup.name[i];
    }
    self apply_powerup(self.powerups[powerupindex]);
    self thread function_41ce9a77(powerupindex, var_f5291508);
}

// Namespace wager
// Params 1, eflags: 0x0
// Checksum 0x16a30d2c, Offset: 0x1f20
// Size: 0x20a
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
    wait 0.05;
    hud_elem scaleovertime(pulsetime, var_3b9a144e, var_75c15b8f);
    hud_elem moveovertime(pulsetime);
    hud_elem.x = origx;
    hud_elem.y = origy;
}

// Namespace wager
// Params 2, eflags: 0x0
// Checksum 0xd3ec0260, Offset: 0x2138
// Size: 0x7ae
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
    self.powerups[powerupindex].hud_elem.hidewheninkillcam = 1;
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
    self.powerups[powerupindex].var_3015426.hidewheninkillcam = 1;
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
        wait pulsetime;
    }
    if (level.inprematchperiod) {
        level waittill(#"prematch_over");
    } else if (var_f5291508) {
        wait pulsetime;
    }
    if (var_93ad7553 && var_f5291508) {
        self thread function_972d1b69(self.powerups[powerupindex].displayname, 0, %MP_BONUS_ACQUIRED);
    }
    wait 1.5;
    for (i = 0; i <= powerupindex; i++) {
        self.powerups[i].hud_elem fadeovertime(0.25);
        self.powerups[i].hud_elem.alpha = 0;
    }
    wait 0.25;
    for (i = 0; i <= powerupindex; i++) {
        self.powerups[i].var_3015426 moveovertime(0.25);
        self.powerups[i].var_3015426.x = 0 - iconsize;
        self.powerups[i].var_3015426.horzalign = "user_right";
    }
    self.powerups[powerupindex].var_3015426.animating = 0;
}

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0x63753f0f, Offset: 0x28f0
// Size: 0xb2
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

// Namespace wager
// Params 3, eflags: 0x0
// Checksum 0xb24a1e7, Offset: 0x29b0
// Size: 0x80
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

// Namespace wager
// Params 1, eflags: 0x0
// Checksum 0x3a6a7bc, Offset: 0x2a38
// Size: 0xd1
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

// Namespace wager
// Params 0, eflags: 0x0
// Checksum 0xe221f7ac, Offset: 0x2b18
// Size: 0x109
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

