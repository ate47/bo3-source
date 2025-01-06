#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_wager;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/weapons/_weapon_utils;

#namespace oic;

// Namespace oic
// Params 0, eflags: 0x0
// Checksum 0x181b39d3, Offset: 0x4a0
// Size: 0x191
function main() {
    globallogic::init();
    level.pointsperweaponkill = getgametypesetting("pointsPerWeaponKill");
    level.pointspermeleekill = getgametypesetting("pointsPerMeleeKill");
    level.pointsforsurvivalbonus = getgametypesetting("pointsForSurvivalBonus");
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 50000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(1, 100);
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.givecustomloadout = &givecustomloadout;
    level.onplayerkilled = &onplayerkilled;
    level.onplayerdamage = &onplayerdamage;
    level.var_8619115e = &function_8619115e;
    gameobjects::register_allowed_gameobject(level.gametype);
    InvalidOpCode(0xc8, "dialog", "gametype", "oic_start");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace oic
// Params 10, eflags: 0x0
// Checksum 0x87e7d222, Offset: 0x6b0
// Size: 0x85
function onplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
    if (smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_HEAD_SHOT") {
        idamage = self.maxhealth + 1;
    }
    return idamage;
}

// Namespace oic
// Params 0, eflags: 0x0
// Checksum 0x6f4faed, Offset: 0x740
// Size: 0x164
function givecustomloadout() {
    weapon = getweapon("pistol_standard");
    self wager::function_937040bd(1, 1, weapon);
    self giveweapon(weapon);
    self giveweapon(level.weaponbasemelee);
    self switchtoweapon(weapon);
    clipammo = 1;
    if (isdefined(self.pers["clip_ammo"])) {
        clipammo = self.pers["clip_ammo"];
        self.pers["clip_ammo"] = undefined;
    }
    self setweaponammoclip(weapon, clipammo);
    stockammo = 0;
    if (isdefined(self.pers["stock_ammo"])) {
        stockammo = self.pers["stock_ammo"];
        self.pers["stock_ammo"] = undefined;
    }
    self setweaponammostock(weapon, stockammo);
    self setspawnweapon(weapon);
    self setperk("specialty_unlimitedsprint");
    self setperk("specialty_movefaster");
    return weapon;
}

// Namespace oic
// Params 0, eflags: 0x0
// Checksum 0x305c02ac, Offset: 0x8b0
// Size: 0x2da
function onstartgametype() {
    setclientnamemode("auto_change");
    util::setobjectivetext("allies", %OBJECTIVES_DM);
    util::setobjectivetext("axis", %OBJECTIVES_DM);
    if (level.splitscreen) {
        util::setobjectivescoretext("allies", %OBJECTIVES_DM);
        util::setobjectivescoretext("axis", %OBJECTIVES_DM);
    } else {
        util::setobjectivescoretext("allies", %OBJECTIVES_DM_SCORE);
        util::setobjectivescoretext("axis", %OBJECTIVES_DM_SCORE);
    }
    spawning::create_map_placed_influencers();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    newspawns = getentarray("mp_wager_spawn", "classname");
    if (newspawns.size > 0) {
        spawnlogic::add_spawn_points("allies", "mp_wager_spawn");
        spawnlogic::add_spawn_points("axis", "mp_wager_spawn");
    } else {
        spawnlogic::add_spawn_points("allies", "mp_dm_spawn");
        spawnlogic::add_spawn_points("axis", "mp_dm_spawn");
    }
    spawning::updateallspawnpoints();
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level.usestartspawns = 0;
    level.displayroundendtext = 0;
    if (level.roundlimit != 1 && level.numlives) {
        level.overrideplayerscore = 1;
        level.displayroundendtext = 1;
        level.onendgame = &onendgame;
    }
    level thread watchelimination();
    util::setobjectivehinttext("allies", %OBJECTIVES_OIC_HINT);
    util::setobjectivehinttext("axis", %OBJECTIVES_OIC_HINT);
}

// Namespace oic
// Params 1, eflags: 0x0
// Checksum 0x56fe4070, Offset: 0xb98
// Size: 0x72
function onspawnplayer(predictedspawn) {
    spawning::onspawnplayer(predictedspawn);
    livesleft = self.pers["lives"];
    if (livesleft == 2) {
        self wager::announcer("wm_2_lives");
        return;
    }
    if (livesleft == 1) {
        self wager::announcer("wm_final_life");
    }
}

// Namespace oic
// Params 1, eflags: 0x0
// Checksum 0xd1f0738e, Offset: 0xc18
// Size: 0x40
function onendgame(winningplayer) {
    if (isdefined(winningplayer) && isplayer(winningplayer)) {
        [[ level._setplayerscore ]](winningplayer, [[ level._getplayerscore ]](winningplayer) + 1);
    }
}

// Namespace oic
// Params 0, eflags: 0x0
// Checksum 0xcc410131, Offset: 0xc60
// Size: 0x12
function function_7fcd8975() {
    thread saveoffallplayersammo();
}

// Namespace oic
// Params 0, eflags: 0x0
// Checksum 0xf4e1aa7f, Offset: 0xc80
// Size: 0xc9
function saveoffallplayersammo() {
    wait 1;
    for (playerindex = 0; playerindex < level.players.size; playerindex++) {
        player = level.players[playerindex];
        if (!isdefined(player)) {
            continue;
        }
        if (player.pers["lives"] == 0) {
            continue;
        }
        currentweapon = player getcurrentweapon();
        player.pers["clip_ammo"] = player getweaponammoclip(currentweapon);
        player.pers["stock_ammo"] = player getweaponammostock(currentweapon);
    }
}

// Namespace oic
// Params 1, eflags: 0x0
// Checksum 0x3b2df84c, Offset: 0xd58
// Size: 0x2e
function isplayereliminated(player) {
    return isdefined(player.pers["eliminated"]) && player.pers["eliminated"];
}

// Namespace oic
// Params 0, eflags: 0x0
// Checksum 0x73fc39fc, Offset: 0xd90
// Size: 0x6f
function getplayersleft() {
    playersremaining = [];
    for (playerindex = 0; playerindex < level.players.size; playerindex++) {
        player = level.players[playerindex];
        if (!isdefined(player)) {
            continue;
        }
        if (!isplayereliminated(player)) {
            playersremaining[playersremaining.size] = player;
        }
    }
    return playersremaining;
}

// Namespace oic
// Params 0, eflags: 0x0
// Checksum 0xe1cba749, Offset: 0xe08
// Size: 0x14d
function function_e4f4bbb2() {
    playersleft = getplayersleft();
    var_ddc6ab3b = playersleft[0];
    var_fef98303 = 0;
    var_3231f927 = [];
    players = level.players;
    for (playerindex = 0; playerindex < players.size; playerindex++) {
        if (isdefined(players[playerindex].pers["sideBetMade"])) {
            var_fef98303 += getdvarint("scr_wagerSideBet");
            if (players[playerindex].pers["sideBetMade"] == var_ddc6ab3b.name) {
                var_3231f927[var_3231f927.size] = players[playerindex];
            }
        }
    }
    if (var_3231f927.size == 0) {
        return;
    }
    var_55e15a9f = int(var_fef98303 / var_3231f927.size);
    for (index = 0; index < var_3231f927.size; index++) {
        player = var_3231f927[index];
        player.pers["wager_sideBetWinnings"] = player.pers["wager_sideBetWinnings"] + var_55e15a9f;
    }
}

// Namespace oic
// Params 9, eflags: 0x0
// Checksum 0xcb496625, Offset: 0xf60
// Size: 0x1da
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(attacker) && isplayer(attacker) && self != attacker) {
        attackerammo = attacker getammocount("pistol_standard");
        victimammo = self getammocount("pistol_standard");
        attacker giveammo(1);
        attacker thread wager::function_972d1b69(%MPUI_PLAYER_KILLED, 0, %MP_PLUS_ONE_BULLET);
        attacker playlocalsound("mpl_oic_bullet_pickup");
        if (weapon_utils::ismeleemod(smeansofdeath)) {
            attacker globallogic_score::givepointstowin(level.pointspermeleekill);
            if (attackerammo > 0) {
                scoreevents::processscoreevent("knife_with_ammo_oic", attacker, self, weapon);
            }
            if (victimammo > attackerammo) {
                scoreevents::processscoreevent("kill_enemy_with_more_ammo_oic", attacker, self, weapon);
            }
        } else {
            attacker globallogic_score::givepointstowin(level.pointsperweaponkill);
            if (victimammo > attackerammo + 1) {
                scoreevents::processscoreevent("kill_enemy_with_more_ammo_oic", attacker, self, weapon);
            }
        }
        if (self.pers["lives"] == 0) {
            scoreevents::processscoreevent("eliminate_oic", attacker, self, weapon);
        }
    }
}

// Namespace oic
// Params 1, eflags: 0x0
// Checksum 0x9297dba9, Offset: 0x1148
// Size: 0x5a
function giveammo(amount) {
    currentweapon = self getcurrentweapon();
    clipammo = self getweaponammoclip(currentweapon);
    self setweaponammoclip(currentweapon, clipammo + amount);
}

// Namespace oic
// Params 0, eflags: 0x0
// Checksum 0x909e8c26, Offset: 0x11b0
// Size: 0x3b
function shouldreceivesurvivorbonus() {
    if (isalive(self)) {
        return true;
    }
    if (self.hasspawned && self.pers["lives"] > 0) {
        return true;
    }
    return false;
}

// Namespace oic
// Params 0, eflags: 0x0
// Checksum 0xa490973, Offset: 0x11f8
// Size: 0x115
function watchelimination() {
    level endon(#"game_ended");
    for (;;) {
        level waittill(#"player_eliminated");
        players = level.players;
        for (i = 0; i < players.size; i++) {
            if (isdefined(players[i]) && players[i] shouldreceivesurvivorbonus()) {
                players[i].pers["survived"]++;
                players[i].survived = players[i].pers["survived"];
                players[i] thread wager::function_972d1b69(%MP_OIC_SURVIVOR_BONUS, 10);
                score = globallogic_score::_getplayerscore(players[i]);
                scoreevents::processscoreevent("survivor", players[i]);
                players[i] globallogic_score::givepointstowin(level.pointsforsurvivalbonus);
            }
        }
    }
}

// Namespace oic
// Params 0, eflags: 0x0
// Checksum 0x1c9c8a35, Offset: 0x1318
// Size: 0xda
function function_8619115e() {
    stabs = self globallogic_score::getpersstat("stabs");
    if (!isdefined(stabs)) {
        stabs = 0;
    }
    self persistence::function_2eb5e93("wagerAwards", stabs, 0);
    longshots = self globallogic_score::getpersstat("longshots");
    if (!isdefined(longshots)) {
        longshots = 0;
    }
    self persistence::function_2eb5e93("wagerAwards", longshots, 1);
    bestkillstreak = self globallogic_score::getpersstat("best_kill_streak");
    if (!isdefined(bestkillstreak)) {
        bestkillstreak = 0;
    }
    self persistence::function_2eb5e93("wagerAwards", bestkillstreak, 2);
}

