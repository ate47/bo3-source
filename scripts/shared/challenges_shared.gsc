#using scripts/shared/abilities/_ability_util;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/drown;
#using scripts/shared/callbacks_shared;
#using scripts/shared/abilities/_ability_player;
#using scripts/codescripts/struct;

#namespace challenges;

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1140
// Size: 0x4
function init_shared() {
    
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xdb13f45, Offset: 0x1150
// Size: 0xc
function pickedupballisticknife() {
    self.retreivedblades++;
}

// Namespace challenges
// Params 3, eflags: 0x1 linked
// Checksum 0x1339cead, Offset: 0x1168
// Size: 0x8a
function trackassists(attacker, damage, isflare) {
    if (!isdefined(self.flareattackerdamage)) {
        self.flareattackerdamage = [];
    }
    if (isdefined(isflare) && isflare == 1) {
        self.flareattackerdamage[attacker.clientid] = 1;
        return;
    }
    self.flareattackerdamage[attacker.clientid] = 0;
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x2669ac5b, Offset: 0x1200
// Size: 0x18c
function destroyedequipment(weapon) {
    if (isdefined(weapon) && weapon.isemp) {
        if (self util::is_item_purchased("emp_grenade")) {
            self addplayerstat("destroy_equipment_with_emp_grenade", 1);
        }
        self addweaponstat(weapon, "combatRecordStat", 1);
        if (self util::has_hacker_perk_purchased_and_equipped()) {
            self addplayerstat("destroy_equipment_with_emp_engineer", 1);
            self addplayerstat("destroy_equipment_engineer", 1);
        }
    } else if (self util::has_hacker_perk_purchased_and_equipped()) {
        self addplayerstat("destroy_equipment_engineer", 1);
    }
    self addplayerstat("destroy_equipment", 1);
    if (isdefined(weapon) && weapon.isbulletweapon) {
        self addplayerstat("destroy_equipment_with_bullet", 1);
    }
    self hackedordestroyedequipment();
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x68e3b065, Offset: 0x1398
// Size: 0x94
function destroyedtacticalinsert() {
    if (!isdefined(self.pers["tacticalInsertsDestroyed"])) {
        self.pers["tacticalInsertsDestroyed"] = 0;
    }
    self.pers["tacticalInsertsDestroyed"]++;
    if (self.pers["tacticalInsertsDestroyed"] >= 5) {
        self.pers["tacticalInsertsDestroyed"] = 0;
        self addplayerstat("destroy_5_tactical_inserts", 1);
    }
}

// Namespace challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x9160f807, Offset: 0x1438
// Size: 0x196
function addflyswatterstat(weapon, aircraft) {
    if (!isdefined(self.pers["flyswattercount"])) {
        self.pers["flyswattercount"] = 0;
    }
    self addweaponstat(weapon, "destroyed_aircraft", 1);
    self.pers["flyswattercount"]++;
    if (self.pers["flyswattercount"] == 5) {
        self addweaponstat(weapon, "destroyed_5_aircraft", 1);
    }
    if (isdefined(aircraft) && isdefined(aircraft.birthtime)) {
        if (gettime() - aircraft.birthtime < 20000) {
            self addweaponstat(weapon, "destroyed_aircraft_under20s", 1);
        }
    }
    if (!isdefined(self.destroyedaircrafttime)) {
        self.destroyedaircrafttime = [];
    }
    if (isdefined(self.destroyedaircrafttime[weapon]) && gettime() - self.destroyedaircrafttime[weapon] < 10000) {
        self addweaponstat(weapon, "destroyed_2aircraft_quickly", 1);
        self.destroyedaircrafttime[weapon] = undefined;
        return;
    }
    self.destroyedaircrafttime[weapon] = gettime();
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x130dab7b, Offset: 0x15d8
// Size: 0x34
function function_90c432bd(weapon) {
    self addweaponstat(weapon, "destroyed_aircraft", 1);
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x78388b3c, Offset: 0x1618
// Size: 0x6e
function canprocesschallenges() {
    /#
        if (getdvarint("destroy_5_tactical_inserts", 0)) {
            return true;
        }
    #/
    if (level.rankedmatch || level.arenamatch || level.wagermatch || sessionmodeiscampaigngame()) {
        return true;
    }
    return false;
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xfb58ffb9, Offset: 0x1690
// Size: 0xd4
function initteamchallenges(team) {
    if (!isdefined(game["challenge"])) {
        game["challenge"] = [];
    }
    if (!isdefined(game["challenge"][team])) {
        game["challenge"][team] = [];
        game["challenge"][team]["plantedBomb"] = 0;
        game["challenge"][team]["destroyedBombSite"] = 0;
        game["challenge"][team]["capturedFlag"] = 0;
    }
    game["challenge"][team]["allAlive"] = 1;
}

// Namespace challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x83c7a33, Offset: 0x1770
// Size: 0x5c
function registerchallengescallback(callback, func) {
    if (!isdefined(level.challengescallbacks[callback])) {
        level.challengescallbacks[callback] = [];
    }
    level.challengescallbacks[callback][level.challengescallbacks[callback].size] = func;
}

// Namespace challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xbbf11b7c, Offset: 0x17d8
// Size: 0xe2
function dochallengecallback(callback, data) {
    if (!isdefined(level.challengescallbacks)) {
        return;
    }
    if (!isdefined(level.challengescallbacks[callback])) {
        return;
    }
    if (isdefined(data)) {
        for (i = 0; i < level.challengescallbacks[callback].size; i++) {
            thread [[ level.challengescallbacks[callback][i] ]](data);
        }
        return;
    }
    for (i = 0; i < level.challengescallbacks[callback].size; i++) {
        thread [[ level.challengescallbacks[callback][i] ]]();
    }
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x25fc86cc, Offset: 0x18c8
// Size: 0x4c
function on_player_connect() {
    self thread initchallengedata();
    self thread spawnwatcher();
    self thread monitorreloads();
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x85b59098, Offset: 0x1920
// Size: 0xd8
function monitorreloads() {
    self endon(#"disconnect");
    self endon(#"killmonitorreloads");
    while (true) {
        self waittill(#"reload");
        currentweapon = self getcurrentweapon();
        if (currentweapon == level.weaponnone) {
            continue;
        }
        time = gettime();
        self.lastreloadtime = time;
        if (weaponhasattachment(currentweapon, "supply") || weaponhasattachment(currentweapon, "dualclip")) {
            self thread function_81f67537(currentweapon);
        }
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x1c42f89f, Offset: 0x1a00
// Size: 0xb0
function function_81f67537(reloadweapon) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_1dc38794");
    self notify(#"hash_33251375");
    self endon(#"hash_33251375");
    self thread function_ed2b9c30(5);
    for (;;) {
        time, weapon = self waittill(#"killed_enemy_player");
        if (reloadweapon == weapon) {
            self addplayerstat("reload_then_kill_dualclip", 1);
        }
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x5b7e30e9, Offset: 0x1ab8
// Size: 0x42
function function_ed2b9c30(time) {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"hash_33251375");
    wait(time);
    self notify(#"hash_1dc38794");
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xf7854efa, Offset: 0x1b08
// Size: 0x60
function initchallengedata() {
    self.pers["bulletStreak"] = 0;
    self.pers["lastBulletKillTime"] = 0;
    self.pers["stickExplosiveKill"] = 0;
    self.pers["carepackagesCalled"] = 0;
    self.explosiveinfo = [];
}

// Namespace challenges
// Params 3, eflags: 0x1 linked
// Checksum 0xde353ec9, Offset: 0x1b70
// Size: 0xe2
function isdamagefromplayercontrolledaitank(eattacker, einflictor, weapon) {
    if (weapon.name == "ai_tank_drone_gun") {
        if (isdefined(eattacker) && isdefined(eattacker.remoteweapon) && isdefined(einflictor)) {
            if (isdefined(einflictor.controlled) && einflictor.controlled) {
                if (eattacker.remoteweapon == einflictor) {
                    return true;
                }
            }
        }
    } else if (weapon.name == "ai_tank_drone_rocket") {
        if (isdefined(einflictor) && !isdefined(einflictor.from_ai)) {
            return true;
        }
    }
    return false;
}

// Namespace challenges
// Params 3, eflags: 0x1 linked
// Checksum 0x6f8d3828, Offset: 0x1c60
// Size: 0xa2
function isdamagefromplayercontrolledsentry(eattacker, einflictor, weapon) {
    if (weapon.name == "auto_gun_turret") {
        if (isdefined(eattacker) && isdefined(eattacker.remoteweapon) && isdefined(einflictor)) {
            if (eattacker.remoteweapon == einflictor) {
                if (isdefined(einflictor.controlled) && einflictor.controlled) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace challenges
// Params 3, eflags: 0x1 linked
// Checksum 0xad6dfd0b, Offset: 0x1d10
// Size: 0x6e4
function perkkills(victim, isstunned, time) {
    player = self;
    if (player hasperk("specialty_movefaster")) {
        player addplayerstat("perk_movefaster_kills", 1);
    }
    if (player hasperk("specialty_noname")) {
        player addplayerstat("perk_noname_kills", 1);
    }
    if (player hasperk("specialty_quieter")) {
        player addplayerstat("perk_quieter_kills", 1);
    }
    if (player hasperk("specialty_longersprint")) {
        if (isdefined(player.lastsprinttime) && gettime() - player.lastsprinttime < 2500) {
            player addplayerstat("perk_longersprint", 1);
        }
    }
    if (player hasperk("specialty_fastmantle")) {
        if (isdefined(player.lastsprinttime) && gettime() - player.lastsprinttime < 2500 && player playerads() >= 1) {
            player addplayerstat("perk_fastmantle_kills", 1);
        }
    }
    if (player hasperk("specialty_loudenemies")) {
        player addplayerstat("perk_loudenemies_kills", 1);
    }
    if (isstunned == 1 && player hasperk("specialty_stunprotection")) {
        player addplayerstat("perk_protection_stun_kills", 1);
    }
    activeenemyemp = 0;
    activecuav = 0;
    if (level.teambased) {
        foreach (team in level.teams) {
            /#
                assert(isdefined(level.activecounteruavs[team]));
            #/
            /#
                assert(isdefined(level.activeemps[team]));
            #/
            if (team == player.team) {
                continue;
            }
            if (level.activecounteruavs[team] > 0) {
                activecuav = 1;
            }
            if (level.activeemps[team] > 0) {
                activeenemyemp = 1;
            }
        }
    } else {
        /#
            assert(isdefined(level.activecounteruavs[victim.entnum]));
        #/
        /#
            assert(isdefined(level.activeemps[victim.entnum]));
        #/
        players = level.players;
        for (i = 0; i < players.size; i++) {
            if (players[i] != player) {
                if (isdefined(level.activecounteruavs[players[i].entnum]) && level.activecounteruavs[players[i].entnum] > 0) {
                    activecuav = 1;
                }
                if (isdefined(level.activeemps[players[i].entnum]) && level.activeemps[players[i].entnum] > 0) {
                    activeenemyemp = 1;
                }
            }
        }
    }
    if (activecuav == 1 || activeenemyemp == 1) {
        if (player hasperk("specialty_immunecounteruav")) {
            player addplayerstat("perk_immune_cuav_kills", 1);
        }
    }
    activeuavvictim = 0;
    if (level.teambased) {
        if (level.activeuavs[victim.team] > 0) {
            activeuavvictim = 1;
        }
    } else {
        activeuavvictim = isdefined(level.activeuavs[victim.entnum]) && level.activeuavs[victim.entnum] > 0;
    }
    if (activeuavvictim == 1) {
        if (player hasperk("specialty_gpsjammer")) {
            player addplayerstat("perk_gpsjammer_immune_kills", 1);
        }
    }
    if (player.lastweaponchange + 5000 > time) {
        if (player hasperk("specialty_fastweaponswitch")) {
            player addplayerstat("perk_fastweaponswitch_kill_after_swap", 1);
        }
    }
    if (player.scavenged == 1) {
        if (player hasperk("specialty_scavenger")) {
            player addplayerstat("perk_scavenger_kills_after_resupply", 1);
        }
    }
}

// Namespace challenges
// Params 2, eflags: 0x0
// Checksum 0xeefcaae0, Offset: 0x2400
// Size: 0x84
function flakjacketprotected(weapon, attacker) {
    if (weapon.name == "claymore") {
        self.flakjacketclaymore[attacker.clientid] = 1;
    }
    self addplayerstat("survive_with_flak", 1);
    self.challenge_lastsurvivewithflakfrom = attacker;
    self.challenge_lastsurvivewithflaktime = gettime();
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x1df7a9ea, Offset: 0x2490
// Size: 0xa0
function earnedkillstreak() {
    if (self util::has_purchased_perk_equipped("specialty_anteup")) {
        self addplayerstat("earn_scorestreak_anteup", 1);
        if (!isdefined(self.var_fcd72b66)) {
            self.var_fcd72b66 = 0;
        }
        self.var_fcd72b66++;
        if (self.var_fcd72b66 >= 5) {
            self addplayerstat("earn_5_scorestreaks_anteup", 1);
            self.var_fcd72b66 = 0;
        }
    }
}

// Namespace challenges
// Params 3, eflags: 0x1 linked
// Checksum 0x893395d7, Offset: 0x2538
// Size: 0x164
function genericbulletkill(data, victim, weapon) {
    player = self;
    time = data.time;
    if (player.pers["lastBulletKillTime"] == time) {
        player.pers["bulletStreak"]++;
    } else {
        player.pers["bulletStreak"] = 1;
    }
    player.pers["lastBulletKillTime"] = time;
    if (data.victim.idflagstime == time) {
        if (data.victim.idflags & 8) {
            player addplayerstat("kill_enemy_through_wall", 1);
            if (isdefined(weapon) && weaponhasattachment(weapon, "fmj")) {
                player addplayerstat("kill_enemy_through_wall_with_fmj", 1);
            }
        }
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xa22021d3, Offset: 0x26a8
// Size: 0x18a
function ishighestscoringplayer(player) {
    if (!isdefined(player.score) || player.score < 1) {
        return false;
    }
    players = level.players;
    if (level.teambased) {
        team = player.pers["team"];
    } else {
        team = "all";
    }
    highscore = player.score;
    for (i = 0; i < players.size; i++) {
        if (!isdefined(players[i].score)) {
            continue;
        }
        if (players[i] == player) {
            continue;
        }
        if (players[i].score < 1) {
            continue;
        }
        if (team != "all" && players[i].pers["team"] != team) {
            continue;
        }
        if (players[i].score >= highscore) {
            return false;
        }
    }
    return true;
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x14f7d655, Offset: 0x2840
// Size: 0x128
function spawnwatcher() {
    self endon(#"disconnect");
    self endon(#"killspawnmonitor");
    self.pers["stickExplosiveKill"] = 0;
    self.pers["pistolHeadshot"] = 0;
    self.pers["assaultRifleHeadshot"] = 0;
    self.pers["killNemesis"] = 0;
    while (true) {
        self waittill(#"spawned_player");
        self.pers["longshotsPerLife"] = 0;
        self.flakjacketclaymore = [];
        self.weaponkills = [];
        self.attachmentkills = [];
        self.retreivedblades = 0;
        self.lastreloadtime = 0;
        self.crossbowclipkillcount = 0;
        self thread watchfordtp();
        self thread watchformantle();
        self thread monitor_player_sprint();
    }
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x3067e610, Offset: 0x2970
// Size: 0x58
function watchfordtp() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killdtpmonitor");
    self.dtptime = 0;
    while (true) {
        self waittill(#"dtp_end");
        self.dtptime = gettime() + 4000;
    }
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x15cfaf55, Offset: 0x29d0
// Size: 0x60
function watchformantle() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killmantlemonitor");
    self.mantletime = 0;
    while (true) {
        var_cf33e710 = self waittill(#"mantle_start");
        self.mantletime = var_cf33e710;
    }
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xeb574863, Offset: 0x2a38
// Size: 0x24
function disarmedhackedcarepackage() {
    self addplayerstat("disarm_hacked_carepackage", 1);
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xdcb700ea, Offset: 0x2a68
// Size: 0x4c
function destroyed_car() {
    if (!isdefined(self) || !isplayer(self)) {
        return;
    }
    self addplayerstat("destroy_car", 1);
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x18f1e175, Offset: 0x2ac0
// Size: 0x64
function killednemesis() {
    self.pers["killNemesis"]++;
    if (self.pers["killNemesis"] >= 5) {
        self.pers["killNemesis"] = 0;
        self addplayerstat("kill_nemesis", 1);
    }
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x45e5068d, Offset: 0x2b30
// Size: 0x24
function killwhiledamagingwithhpm() {
    self addplayerstat("kill_while_damaging_with_microwave_turret", 1);
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x129d8501, Offset: 0x2b60
// Size: 0x24
function longdistancehatchetkill() {
    self addplayerstat("long_distance_hatchet_kill", 1);
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x749a5640, Offset: 0x2b90
// Size: 0x24
function blockedsatellite() {
    self addplayerstat("activate_cuav_while_enemy_satelite_active", 1);
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x6b89390d, Offset: 0x2bc0
// Size: 0x64
function longdistancekill() {
    self.pers["longshotsPerLife"]++;
    if (self.pers["longshotsPerLife"] >= 3) {
        self.pers["longshotsPerLife"] = 0;
        self addplayerstat("longshot_3_onelife", 1);
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x7725f298, Offset: 0x2c30
// Size: 0x16a
function challengeroundend(data) {
    player = data.player;
    winner = data.winner;
    if (endedearly(winner)) {
        return;
    }
    if (level.teambased) {
        winnerscore = game["teamScores"][winner];
        loserscore = getlosersteamscores(winner);
    }
    switch (level.gametype) {
    case 75:
        if (player.team == winner) {
            if (game["challenge"][winner]["allAlive"]) {
                player addgametypestat("round_win_no_deaths", 1);
            }
            if (isdefined(player.lastmansddefeat3enemies)) {
                player addgametypestat("last_man_defeat_3_enemies", 1);
            }
        }
        break;
    default:
        break;
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xcc098fab, Offset: 0x2da8
// Size: 0x136
function roundend(winner) {
    wait(0.05);
    data = spawnstruct();
    data.time = gettime();
    if (level.teambased) {
        if (isdefined(winner) && isdefined(level.teams[winner])) {
            data.winner = winner;
        }
    } else if (isdefined(winner)) {
        data.winner = winner;
    }
    for (index = 0; index < level.placement["all"].size; index++) {
        data.player = level.placement["all"][index];
        if (isdefined(data.player)) {
            data.place = index;
            dochallengecallback("roundEnd", data);
        }
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xbd746bfe, Offset: 0x2ee8
// Size: 0x1f6
function gameend(winner) {
    wait(0.05);
    data = spawnstruct();
    data.time = gettime();
    if (level.teambased) {
        if (isdefined(winner) && isdefined(level.teams[winner])) {
            data.winner = winner;
        }
    } else if (isdefined(winner) && isplayer(winner)) {
        data.winner = winner;
    }
    for (index = 0; index < level.placement["all"].size; index++) {
        data.player = level.placement["all"][index];
        data.place = index;
        if (isdefined(data.player)) {
            dochallengecallback("gameEnd", data);
        }
        data.player.var_fc4b5b4e = 1;
    }
    for (index = 0; index < level.players.size; index++) {
        if (!isdefined(level.players[index].var_fc4b5b4e) || level.players[index].var_fc4b5b4e != 1) {
            scoreevents::processscoreevent("completed_match", level.players[index]);
        }
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xe528fa30, Offset: 0x30e8
// Size: 0x44
function getfinalkill(player) {
    if (isplayer(player)) {
        player addplayerstat("get_final_kill", 1);
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xe9858751, Offset: 0x3138
// Size: 0x94
function function_ef81fd44(weapon) {
    if (!isplayer(self)) {
        return;
    }
    self destroyscorestreak(weapon, 1, 1);
    if (weapon.rootweapon.name == "hatchet") {
        self addplayerstat("destroy_hcxd_with_hatchet", 1);
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xe15718c6, Offset: 0x31d8
// Size: 0xbc
function capturedcrate(owner) {
    if (isdefined(self.lastrescuedby) && isdefined(self.lastrescuedtime)) {
        if (self.lastrescuedtime + 5000 > gettime()) {
            self.lastrescuedby addplayerstat("defend_teammate_who_captured_package", 1);
        }
    }
    if (level.teambased && owner.team != self.team || owner != self && !level.teambased) {
        self addplayerstat("capture_enemy_carepackage", 1);
    }
}

// Namespace challenges
// Params 4, eflags: 0x1 linked
// Checksum 0x7b3ee90d, Offset: 0x32a0
// Size: 0x3cc
function destroyscorestreak(weapon, playercontrolled, groundbased, countaskillstreakvehicle) {
    if (!isdefined(countaskillstreakvehicle)) {
        countaskillstreakvehicle = 1;
    }
    if (!isplayer(self)) {
        return;
    }
    if (isdefined(level.killstreakweapons[weapon])) {
        if (level.killstreakweapons[weapon] == "dart") {
            self addplayerstat("destroy_scorestreak_with_dart", 1);
        }
    } else if (isdefined(weapon.isheroweapon) && weapon.isheroweapon == 1) {
        self addplayerstat("destroy_scorestreak_with_specialist", 1);
    } else if (weaponhasattachment(weapon, "fmj", "rf")) {
        self addplayerstat("destroy_scorestreak_rapidfire_fmj", 1);
    }
    if (!isdefined(playercontrolled) || playercontrolled == 0) {
        if (self util::has_cold_blooded_perk_purchased_and_equipped()) {
            if (groundbased) {
                self addplayerstat("destroy_ai_scorestreak_coldblooded", 1);
            }
            if (self util::has_blind_eye_perk_purchased_and_equipped()) {
                if (groundbased) {
                    self.pers["challenge_destroyed_ground"]++;
                } else {
                    self.pers["challenge_destroyed_air"]++;
                }
                if (self.pers["challenge_destroyed_ground"] > 0 && self.pers["challenge_destroyed_air"] > 0) {
                    self addplayerstat("destroy_air_and_ground_blindeye_coldblooded", 1);
                    self.pers["challenge_destroyed_air"] = 0;
                    self.pers["challenge_destroyed_ground"] = 0;
                }
            }
        }
    }
    if (!isdefined(self.pers["challenge_destroyed_killstreak"])) {
        self.pers["challenge_destroyed_killstreak"] = 0;
    }
    self.pers["challenge_destroyed_killstreak"]++;
    if (self.pers["challenge_destroyed_killstreak"] >= 5) {
        self.pers["challenge_destroyed_killstreak"] = 0;
        self addweaponstat(weapon, "destroy_5_killstreak", 1);
        self addweaponstat(weapon, "destroy_5_killstreak_vehicle", 1);
    }
    self addweaponstat(weapon, "destroy_killstreak", 1);
    weaponpickedup = 0;
    if (isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[weapon])) {
        weaponpickedup = 1;
    }
    self addweaponstat(weapon, "destroyed", 1, self.class_num, weaponpickedup, undefined, self.primaryloadoutgunsmithvariantindex, self.secondaryloadoutgunsmithvariantindex);
    self thread watchforrapiddestroy(weapon);
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x4f19127b, Offset: 0x3678
// Size: 0xb4
function watchforrapiddestroy(weapon) {
    self endon(#"disconnect");
    if (!isdefined(self.challenge_previousdestroyweapon) || self.challenge_previousdestroyweapon != weapon) {
        self.challenge_previousdestroyweapon = weapon;
        self.challenge_previousdestroycount = 0;
    } else {
        self.challenge_previousdestroycount++;
    }
    self waittilltimeoutordeath(4);
    if (self.challenge_previousdestroycount > 1) {
        self addweaponstat(weapon, "destroy_2_killstreaks_rapidly", 1);
    }
}

// Namespace challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xeb6f723b, Offset: 0x3738
// Size: 0x242
function capturedobjective(capturetime, objective) {
    if (isdefined(self.smokegrenadetime) && isdefined(self.smokegrenadeposition)) {
        if (self.smokegrenadetime + 14000 > capturetime) {
            distsq = distancesquared(self.smokegrenadeposition, self.origin);
            if (distsq < 57600) {
                if (self util::is_item_purchased("willy_pete")) {
                    self addplayerstat("capture_objective_in_smoke", 1);
                }
                self addweaponstat(getweapon("willy_pete"), "CombatRecordStat", 1);
                return;
            }
        }
    }
    if (isdefined(level.capturedobjectivefunction)) {
        self [[ level.capturedobjectivefunction ]]();
    }
    heroabilitywasactiverecently = isdefined(self.heroabilitydectivatetime) && (isdefined(self.heroabilityactive) || self.heroabilitydectivatetime > gettime() - 3000);
    if (heroabilitywasactiverecently && isdefined(self.heroability) && self.heroability.name == "gadget_camo") {
        scoreevents::processscoreevent("optic_camo_capture_objective", self);
    }
    if (isdefined(objective)) {
        if (self.challenge_objectivedefensive === objective) {
            if ((isdefined(self.recentkillcount) ? self.recentkillcount : 0) > 2 || (isdefined(self.challenge_objectivedefensivekillcount) ? self.challenge_objectivedefensivekillcount : 0) > 0 && self.challenge_objectivedefensivetriplekillmedalorbetterearned === 1) {
                self addplayerstat("triple_kill_defenders_and_capture", 1);
            }
            self.challenge_objectivedefensivekillcount = 0;
            self.challenge_objectivedefensive = undefined;
            self.challenge_objectivedefensivetriplekillmedalorbetterearned = undefined;
        }
    }
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xffca2299, Offset: 0x3988
// Size: 0x3c
function hackedordestroyedequipment() {
    if (self util::has_hacker_perk_purchased_and_equipped()) {
        self addplayerstat("perk_hacker_destroy", 1);
    }
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x9b76e15, Offset: 0x39d0
// Size: 0x94
function bladekill() {
    if (!isdefined(self.pers["bladeKills"])) {
        self.pers["bladeKills"] = 0;
    }
    self.pers["bladeKills"]++;
    if (self.pers["bladeKills"] >= 15) {
        self.pers["bladeKills"] = 0;
        self addplayerstat("kill_15_with_blade", 1);
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xb040179e, Offset: 0x3a70
// Size: 0x44
function destroyedexplosive(weapon) {
    self destroyedequipment(weapon);
    self addplayerstat("destroy_explosive", 1);
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x9bc27188, Offset: 0x3ac0
// Size: 0x24
function assisted() {
    self addplayerstat("assist", 1);
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x306ab679, Offset: 0x3af0
// Size: 0xbc
function earnedmicrowaveassistscore(score) {
    self addplayerstat("assist_score_microwave_turret", score);
    self addplayerstat("assist_score_killstreak", score);
    self addweaponstat(getweapon("microwave_turret_deploy"), "assists", 1);
    self addweaponstat(getweapon("microwave_turret_deploy"), "assist_score", score);
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x4d6e7675, Offset: 0x3bb8
// Size: 0xbc
function earnedcuavassistscore(score) {
    self addplayerstat("assist_score_cuav", score);
    self addplayerstat("assist_score_killstreak", score);
    self addweaponstat(getweapon("counteruav"), "assists", 1);
    self addweaponstat(getweapon("counteruav"), "assist_score", score);
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x9a66c963, Offset: 0x3c80
// Size: 0xbc
function earneduavassistscore(score) {
    self addplayerstat("assist_score_uav", score);
    self addplayerstat("assist_score_killstreak", score);
    self addweaponstat(getweapon("uav"), "assists", 1);
    self addweaponstat(getweapon("uav"), "assist_score", score);
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x43b4d283, Offset: 0x3d48
// Size: 0xbc
function earnedsatelliteassistscore(score) {
    self addplayerstat("assist_score_satellite", score);
    self addplayerstat("assist_score_killstreak", score);
    self addweaponstat(getweapon("satellite"), "assists", 1);
    self addweaponstat(getweapon("satellite"), "assist_score", score);
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x93e62307, Offset: 0x3e10
// Size: 0xbc
function earnedempassistscore(score) {
    self addplayerstat("assist_score_emp", score);
    self addplayerstat("assist_score_killstreak", score);
    self addweaponstat(getweapon("emp_turret"), "assists", 1);
    self addweaponstat(getweapon("emp_turret"), "assist_score", score);
}

// Namespace challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x45b7357e, Offset: 0x3ed8
// Size: 0xb6
function teamcompletedchallenge(team, challenge) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].team) && players[i].team == team) {
            players[i] addgametypestat(challenge, 1);
        }
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x28edfa1, Offset: 0x3f98
// Size: 0x50
function endedearly(winner) {
    if (level.hostforcedend) {
        return true;
    }
    if (!isdefined(winner)) {
        return true;
    }
    if (level.teambased) {
        if (winner == "tie") {
            return true;
        }
    }
    return false;
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x40627411, Offset: 0x3ff0
// Size: 0xbe
function getlosersteamscores(winner) {
    teamscores = 0;
    foreach (team in level.teams) {
        if (team == winner) {
            continue;
        }
        teamscores += game["teamScores"][team];
    }
    return teamscores;
}

// Namespace challenges
// Params 2, eflags: 0x0
// Checksum 0xe9a0e39f, Offset: 0x40b8
// Size: 0xb8
function didloserfailchallenge(winner, challenge) {
    foreach (team in level.teams) {
        if (team == winner) {
            continue;
        }
        if (game["challenge"][team][challenge]) {
            return false;
        }
    }
    return true;
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x6aacaafd, Offset: 0x4178
// Size: 0x56e
function challengegameend(data) {
    player = data.player;
    winner = data.winner;
    if (endedearly(winner)) {
        return;
    }
    if (level.teambased) {
        winnerscore = game["teamScores"][winner];
        loserscore = getlosersteamscores(winner);
    }
    switch (level.gametype) {
    case 135:
        if (player.team == winner) {
            if (winnerscore >= loserscore + 20) {
                player addgametypestat("CRUSH", 1);
            }
        }
        var_d2d122ff = 1;
        for (index = 0; index < level.placement["all"].size; index++) {
            if (level.placement["all"][index].deaths < player.deaths) {
                var_d2d122ff = 0;
            }
            if (level.placement["all"][index].kills > player.kills) {
                var_d2d122ff = 0;
            }
        }
        if (var_d2d122ff && player.kills > 0 && level.placement["all"].size > 3) {
            player addgametypestat("most_kills_least_deaths", 1);
        }
        break;
    case 131:
        if (player == winner) {
            if (level.placement["all"].size >= 2) {
                secondplace = level.placement["all"][1];
                if (player.kills >= secondplace.kills + 7) {
                    player addgametypestat("CRUSH", 1);
                }
            }
        }
        break;
    case 129:
        if (player.team == winner) {
            if (loserscore == 0) {
                player addgametypestat("SHUT_OUT", 1);
            }
        }
        break;
    case 132:
        if (player.team == winner) {
            if (winnerscore >= loserscore + 70) {
                player addgametypestat("CRUSH", 1);
            }
        }
        break;
    case 133:
        if (player.team == winner && winnerscore > 0) {
            if (winnerscore >= loserscore + 70) {
                player addgametypestat("CRUSH", 1);
            }
        }
        break;
    case 134:
        if (player.team == winner && winnerscore > 0) {
            if (winnerscore >= loserscore + 70) {
                player addgametypestat("CRUSH", 1);
            }
        }
        if (player.team == winner && winnerscore > 0) {
            if (winnerscore >= loserscore + 110) {
                player addgametypestat("ANNIHILATION", 1);
            }
        }
        break;
    case 130:
        if (player.team == game["defenders"] && player.team == winner) {
            if (loserscore == 0) {
                player addgametypestat("SHUT_OUT", 1);
            }
        }
        break;
    case 75:
        if (player.team == winner) {
            if (loserscore <= 1) {
                player addgametypestat("CRUSH", 1);
            }
        }
    default:
        break;
    }
}

// Namespace challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x8201b330, Offset: 0x46f0
// Size: 0x1a4
function multikill(killcount, weapon) {
    if (killcount >= 3 && isdefined(self.lastkillwheninjured)) {
        if (self.lastkillwheninjured + 5000 > gettime()) {
            self addplayerstat("multikill_3_near_death", 1);
        }
    }
    self addweaponstat(weapon, "doublekill", int(killcount / 2));
    self addweaponstat(weapon, "triplekill", int(killcount / 3));
    if (weapon.isheroweapon) {
        doublekill = int(killcount / 2);
        if (doublekill) {
            self addplayerstat("MULTIKILL_2_WITH_HEROWEAPON", doublekill);
        }
        triplekill = int(killcount / 3);
        if (triplekill) {
            self addplayerstat("MULTIKILL_3_WITH_HEROWEAPON", triplekill);
        }
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x914a2a52, Offset: 0x48a0
// Size: 0x2c
function domattackermultikill(killcount) {
    self addgametypestat("kill_2_enemies_capturing_your_objective", 1);
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xf7ac4006, Offset: 0x48d8
// Size: 0x2c
function totaldomination(team) {
    teamcompletedchallenge(team, "control_3_points_3_minutes");
}

// Namespace challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x9bf000a4, Offset: 0x4910
// Size: 0x9c
function holdflagentirematch(team, label) {
    switch (label) {
    case 146:
        event = "hold_a_entire_match";
        break;
    case 147:
        event = "hold_b_entire_match";
        break;
    case 148:
        event = "hold_c_entire_match";
        break;
    default:
        return;
    }
    teamcompletedchallenge(team, event);
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x6a9a9936, Offset: 0x49b8
// Size: 0x24
function capturedbfirstminute() {
    self addgametypestat("capture_b_first_minute", 1);
}

// Namespace challenges
// Params 1, eflags: 0x0
// Checksum 0x213cef8e, Offset: 0x49e8
// Size: 0x2c
function controlzoneentirely(team) {
    teamcompletedchallenge(team, "control_zone_entirely");
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xb6ec8ff8, Offset: 0x4a20
// Size: 0x24
function multi_lmg_smg_kill() {
    self addplayerstat("multikill_3_lmg_or_smg_hip_fire", 1);
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x80bb8cf7, Offset: 0x4a50
// Size: 0x74
function killedzoneattacker(weapon) {
    if (weapon.name == "planemortar" || weapon.name == "remote_missile_missile" || weapon.name == "remote_missile_bomblet") {
        self thread updatezonemultikills();
    }
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xa209cb4, Offset: 0x4ad0
// Size: 0x136
function killeddog() {
    origin = self.origin;
    if (level.teambased) {
        teammates = util::function_c664826a(self.team);
        foreach (player in teammates.a) {
            if (player == self) {
                continue;
            }
            distsq = distancesquared(origin, player.origin);
            if (distsq < 57600) {
                self addplayerstat("killed_dog_close_to_teammate", 1);
                break;
            }
        }
    }
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x858d3c0b, Offset: 0x4c10
// Size: 0x98
function updatezonemultikills() {
    self endon(#"disconnect");
    level endon(#"game_ended");
    self notify(#"updaterecentzonekills");
    self endon(#"updaterecentzonekills");
    if (!isdefined(self.recentzonekillcount)) {
        self.recentzonekillcount = 0;
    }
    self.recentzonekillcount++;
    wait(4);
    if (self.recentzonekillcount > 1) {
        self addplayerstat("multikill_2_zone_attackers", 1);
    }
    self.recentzonekillcount = 0;
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xc993c293, Offset: 0x4cb0
// Size: 0x24
function multi_rcbomb_kill() {
    self addplayerstat("multikill_2_with_rcbomb", 1);
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x3fb64dc7, Offset: 0x4ce0
// Size: 0x24
function multi_remotemissile_kill() {
    self addplayerstat("multikill_3_remote_missile", 1);
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xd2ff9db5, Offset: 0x4d10
// Size: 0x24
function multi_mgl_kill() {
    self addplayerstat("multikill_3_with_mgl", 1);
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0xe97e088, Offset: 0x4d40
// Size: 0x24
function immediatecapture() {
    self addgametypestat("immediate_capture", 1);
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x60fb589f, Offset: 0x4d70
// Size: 0x24
function killedlastcontester() {
    self addgametypestat("contest_then_capture", 1);
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0x1ed52c38, Offset: 0x4da0
// Size: 0x24
function bothbombsdetonatewithintime() {
    self addgametypestat("both_bombs_detonate_10_seconds", 1);
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xbc456e3c, Offset: 0x4dd0
// Size: 0x6a
function calledincarepackage() {
    self.pers["carepackagesCalled"]++;
    if (self.pers["carepackagesCalled"] >= 3) {
        self addplayerstat("call_in_3_care_packages", 1);
        self.pers["carepackagesCalled"] = 0;
    }
}

// Namespace challenges
// Params 4, eflags: 0x1 linked
// Checksum 0x5b662697, Offset: 0x4e48
// Size: 0xa4
function destroyedhelicopter(attacker, weapon, damagetype, playercontrolled) {
    if (!isplayer(attacker)) {
        return;
    }
    attacker destroyscorestreak(weapon, playercontrolled, 0);
    if (damagetype == "MOD_RIFLE_BULLET" || damagetype == "MOD_PISTOL_BULLET") {
        attacker addplayerstat("destroyed_helicopter_with_bullet", 1);
    }
}

// Namespace challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xd0eb46df, Offset: 0x4ef8
// Size: 0xac
function destroyedqrdrone(damagetype, weapon) {
    self destroyscorestreak(weapon, 1, 0);
    self addplayerstat("destroy_qrdrone", 1);
    if (damagetype == "MOD_RIFLE_BULLET" || damagetype == "MOD_PISTOL_BULLET") {
        self addplayerstat("destroyed_qrdrone_with_bullet", 1);
    }
    self destroyedplayercontrolledaircraft();
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xbc74e46c, Offset: 0x4fb0
// Size: 0x44
function destroyedplayercontrolledaircraft() {
    if (self hasperk("specialty_noname")) {
        self addplayerstat("destroy_helicopter", 1);
    }
}

// Namespace challenges
// Params 3, eflags: 0x1 linked
// Checksum 0x79f2051f, Offset: 0x5000
// Size: 0x1fc
function destroyedaircraft(attacker, weapon, playercontrolled) {
    if (!isplayer(attacker)) {
        return;
    }
    attacker destroyscorestreak(weapon, playercontrolled, 0);
    if (isdefined(weapon)) {
        if (weapon.name == "emp" && attacker util::is_item_purchased("killstreak_emp")) {
            attacker addplayerstat("destroy_aircraft_with_emp", 1);
        } else if (weapon.name == "missile_drone_projectile" || weapon.name == "missile_drone") {
            attacker addplayerstat("destroy_aircraft_with_missile_drone", 1);
        } else if (weapon.isbulletweapon) {
            attacker addplayerstat("shoot_aircraft", 1);
        }
    }
    if (attacker util::has_blind_eye_perk_purchased_and_equipped()) {
        attacker addplayerstat("perk_nottargetedbyairsupport_destroy_aircraft", 1);
    }
    attacker addplayerstat("destroy_aircraft", 1);
    if (isdefined(playercontrolled) && playercontrolled == 0) {
        if (attacker util::has_blind_eye_perk_purchased_and_equipped()) {
            attacker addplayerstat("destroy_ai_aircraft_using_blindeye", 1);
        }
    }
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0xa1f284db, Offset: 0x5208
// Size: 0x1ac
function killstreakten() {
    if (!isdefined(self.class_num)) {
        return;
    }
    primary = self getloadoutitem(self.class_num, "primary");
    if (primary != 0) {
        return;
    }
    secondary = self getloadoutitem(self.class_num, "secondary");
    if (secondary != 0) {
        return;
    }
    primarygrenade = self getloadoutitem(self.class_num, "primarygrenade");
    if (primarygrenade != 0) {
        return;
    }
    specialgrenade = self getloadoutitem(self.class_num, "specialgrenade");
    if (specialgrenade != 0) {
        return;
    }
    for (numspecialties = 0; numspecialties < level.maxspecialties; numspecialties++) {
        perk = self getloadoutitem(self.class_num, "specialty" + numspecialties + 1);
        if (perk != 0) {
            return;
        }
    }
    self addplayerstat("killstreak_10_no_weapons_perks", 1);
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x43f4fbe6, Offset: 0x53c0
// Size: 0x70
function scavengedgrenade() {
    self endon(#"disconnect");
    self endon(#"death");
    self notify(#"scavengedgrenade");
    self endon(#"scavengedgrenade");
    self notify(#"scavenged_primary_grenade");
    for (;;) {
        self waittill(#"lethalgrenadekill");
        self addplayerstat("kill_with_resupplied_lethal_grenade", 1);
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x9ccc5630, Offset: 0x5438
// Size: 0x2c
function stunnedtankwithempgrenade(attacker) {
    attacker addplayerstat("stun_aitank_wIth_emp_grenade", 1);
}

// Namespace challenges
// Params 8, eflags: 0x1 linked
// Checksum 0x9ea5ff6b, Offset: 0x5470
// Size: 0x16a4
function playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, shitloc, attackerstance, bledout) {
    /#
        print(level.gametype);
    #/
    self.anglesondeath = self getplayerangles();
    if (isdefined(attacker)) {
        attacker.anglesonkill = attacker getplayerangles();
    }
    if (!isdefined(weapon)) {
        weapon = level.weaponnone;
    }
    self endon(#"disconnect");
    data = spawnstruct();
    data.victim = self;
    data.victimorigin = self.origin;
    data.victimstance = self getstance();
    data.einflictor = einflictor;
    data.attacker = attacker;
    data.attackerstance = attackerstance;
    data.idamage = idamage;
    data.smeansofdeath = smeansofdeath;
    data.weapon = weapon;
    data.shitloc = shitloc;
    data.time = gettime();
    data.bledout = 0;
    if (isdefined(bledout)) {
        data.bledout = bledout;
    }
    if (isdefined(einflictor) && isdefined(einflictor.lastweaponbeforetoss)) {
        data.lastweaponbeforetoss = einflictor.lastweaponbeforetoss;
    }
    if (isdefined(einflictor) && isdefined(einflictor.ownerweaponatlaunch)) {
        data.ownerweaponatlaunch = einflictor.ownerweaponatlaunch;
    }
    waslockingon = 0;
    washacked = 0;
    if (isdefined(einflictor)) {
        if (isdefined(einflictor.locking_on)) {
            waslockingon |= einflictor.locking_on;
        }
        if (isdefined(einflictor.locked_on)) {
            waslockingon |= einflictor.locked_on;
        }
        washacked = einflictor util::ishacked();
    }
    waslockingon &= 1 << data.victim.entnum;
    if (waslockingon != 0) {
        data.waslockingon = 1;
    } else {
        data.waslockingon = 0;
    }
    data.washacked = washacked;
    data.wasplanting = data.victim.isplanting;
    data.wasunderwater = data.victim isplayerunderwater();
    if (!isdefined(data.wasplanting)) {
        data.wasplanting = 0;
    }
    data.wasdefusing = data.victim.isdefusing;
    if (!isdefined(data.wasdefusing)) {
        data.wasdefusing = 0;
    }
    data.victimweapon = data.victim.currentweapon;
    data.victimonground = data.victim isonground();
    data.var_f67ec791 = data.victim iswallrunning();
    data.victimlaststunnedby = data.victim.laststunnedby;
    data.var_b9995fb9 = data.victim isdoublejumping();
    data.victimcombatefficiencylastontime = data.victim.combatefficiencylastontime;
    data.victimspeedburstlastontime = data.victim.speedburstlastontime;
    data.victimcombatefficieny = data.victim ability_util::gadget_is_active(15);
    data.var_8eff9c3 = data.victim.var_ba21be83;
    data.victimheroabilityactive = ability_player::gadget_checkheroabilitykill(data.victim);
    data.victimelectrifiedby = data.victim.electrifiedby;
    data.victimheroability = data.victim.heroability;
    data.victimwasinslamstate = data.victim isslamming();
    data.victimwaslungingwitharmblades = data.victim isgadgetmeleecharging();
    data.victimwasheatwavestunned = data.victim isheatwavestunned();
    data.victimpowerarmorlasttookdamagetime = data.victim.power_armor_last_took_damage_time;
    data.var_8d6b69ec = data.victim.var_39c0d0ac;
    data.victimgadgetpower = data.victim gadgetpowerget(0);
    data.victimgadgetwasactivelastdamage = data.victim.gadget_was_active_last_damage;
    data.victimisthieforroulette = data.victim.isthief === 1 || data.victim.isroulette === 1;
    data.victimheroabilityname = data.victim.heroabilityname;
    if (!isdefined(data.var_8eff9c3)) {
        data.var_8eff9c3 = 0;
    }
    if (!isdefined(data.victimcombatefficiencylastontime)) {
        data.victimcombatefficiencylastontime = 0;
    }
    if (!isdefined(data.victimspeedburstlastontime)) {
        data.victimspeedburstlastontime = 0;
    }
    data.victimvisionpulseactivatetime = data.victim.visionpulseactivatetime;
    if (!isdefined(data.victimvisionpulseactivatetime)) {
        data.victimvisionpulseactivatetime = 0;
    }
    data.victimvisionpulsearray = util::array_copy_if_array(data.victim.visionpulsearray);
    data.victimvisionpulseorigin = data.victim.visionpulseorigin;
    data.victimvisionpulseoriginarray = util::array_copy_if_array(data.victim.visionpulseoriginarray);
    data.victimattackersthisspawn = util::array_copy_if_array(data.victim.attackersthisspawn);
    data.var_5bd9ee89 = data.victim.var_150f7cf6;
    data.var_82701a51 = data.victim.var_fdd0883a;
    data.victim_jump_begin = data.victim.challenge_jump_begin;
    data.victim_jump_end = data.victim.challenge_jump_end;
    data.victim_swimming_begin = data.victim.challenge_swimming_begin;
    data.victim_swimming_end = data.victim.challenge_swimming_end;
    data.victim_slide_begin = data.victim.challenge_slide_begin;
    data.victim_slide_end = data.victim.challenge_slide_end;
    data.var_5d1971dd = data.victim.var_da3759c8;
    data.var_d4842f85 = data.victim.var_77c2a8fc;
    data.var_6a9f8d24 = data.victim drown::is_player_drowning();
    if (isdefined(data.victim.activeproximitygrenades)) {
        data.victimactiveproximitygrenades = [];
        arrayremovevalue(data.victim.activeproximitygrenades, undefined);
        foreach (proximitygrenade in data.victim.activeproximitygrenades) {
            proximitygrenadeinfo = spawnstruct();
            proximitygrenadeinfo.origin = proximitygrenade.origin;
            data.victimactiveproximitygrenades[data.victimactiveproximitygrenades.size] = proximitygrenadeinfo;
        }
    }
    if (isdefined(data.victim.activebouncingbetties)) {
        data.victimactivebouncingbetties = [];
        arrayremovevalue(data.victim.activebouncingbetties, undefined);
        foreach (bouncingbetty in data.victim.activebouncingbetties) {
            bouncingbettyinfo = spawnstruct();
            bouncingbettyinfo.origin = bouncingbetty.origin;
            data.victimactivebouncingbetties[data.victimactivebouncingbetties.size] = bouncingbettyinfo;
        }
    }
    if (isplayer(attacker)) {
        data.attackerorigin = data.attacker.origin;
        data.attackeronground = data.attacker isonground();
        data.var_e4763e35 = data.attacker iswallrunning();
        data.var_3828b415 = data.attacker isdoublejumping();
        data.attackertraversing = data.attacker istraversing();
        data.attackersliding = data.attacker issliding();
        data.attackerspeedburst = data.attacker ability_util::gadget_is_active(13);
        data.var_dc7e5b14 = data.attacker.var_ba21be83;
        data.attackerheroabilityactive = ability_player::gadget_checkheroabilitykill(data.attacker);
        data.attackerheroability = data.attacker.heroability;
        if (!isdefined(data.var_dc7e5b14)) {
            data.var_dc7e5b14 = 0;
        }
        data.attackervisionpulseactivatetime = attacker.visionpulseactivatetime;
        if (!isdefined(data.attackervisionpulseactivatetime)) {
            data.attackervisionpulseactivatetime = 0;
        }
        data.attackervisionpulsearray = util::array_copy_if_array(attacker.visionpulsearray);
        data.attackervisionpulseorigin = attacker.visionpulseorigin;
        if (!isdefined(data.attackerstance)) {
            data.attackerstance = data.attacker getstance();
        }
        data.attackervisionpulseoriginarray = util::array_copy_if_array(attacker.visionpulseoriginarray);
        data.attackerwasflashed = data.attacker isflashbanged();
        data.attackerlastflashedby = data.attacker.lastflashedby;
        data.attackerlaststunnedby = data.attacker.laststunnedby;
        data.attackerlaststunnedtime = data.attacker.laststunnedtime;
        data.attackerwasconcussed = isdefined(data.attacker.concussionendtime) && data.attacker.concussionendtime > gettime();
        data.attackerwasheatwavestunned = data.attacker isheatwavestunned();
        data.attackerwasunderwater = data.attacker isplayerunderwater();
        data.attackerlastfastreloadtime = data.attacker.lastfastreloadtime;
        data.attackerwassliding = data.attacker issliding();
        data.attackerwassprinting = data.attacker issprinting();
        data.attackeristhief = attacker.isthief === 1;
        data.attackerisroulette = attacker.isroulette === 1;
        data.var_f4b4b342 = data.attacker.var_150f7cf6;
        data.var_3e129f16 = data.attacker.var_fdd0883a;
        data.attacker_jump_begin = data.attacker.challenge_jump_begin;
        data.attacker_jump_end = data.attacker.challenge_jump_end;
        data.attacker_swimming_begin = data.attacker.challenge_swimming_begin;
        data.attacker_swimming_end = data.attacker.challenge_swimming_end;
        data.attacker_slide_begin = data.attacker.challenge_slide_begin;
        data.attacker_slide_end = data.attacker.challenge_slide_end;
        data.var_519c883c = data.attacker.var_da3759c8;
        data.var_80924500 = data.attacker.var_77c2a8fc;
        data.var_f7f92f13 = data.attacker drown::is_player_drowning();
        data.attacker_sprint_begin = data.attacker.challenge_sprint_begin;
        data.attacker_sprint_end = data.attacker.challenge_sprint_end;
        data.var_b041219e = data.attacker.var_37509fac;
        if (level.var_a5427f76 === 1 && attacker isinvehicle()) {
            vehicle = attacker getvehicleoccupied();
            if (isdefined(vehicle)) {
                data.var_7cb22418 = vehicle.archetype;
            }
        }
    } else {
        data.attackeronground = 0;
        data.var_e4763e35 = 0;
        data.var_3828b415 = 0;
        data.attackertraversing = 0;
        data.attackersliding = 0;
        data.attackerspeedburst = 0;
        data.var_dc7e5b14 = 0;
        data.attackervisionpulseactivatetime = 0;
        data.attackerwasflashed = 0;
        data.attackerwasconcussed = 0;
        data.attackerheroabilityactive = 0;
        data.attackerwasheatwavestunned = 0;
        data.attackerstance = "stand";
        data.attackerwasunderwater = 0;
        data.attackerwassprinting = 0;
        data.attackeristhief = 0;
        data.attackerisroulette = 0;
    }
    if (isdefined(einflictor)) {
        if (isdefined(einflictor.iscooked)) {
            data.inflictoriscooked = einflictor.iscooked;
        } else {
            data.inflictoriscooked = 0;
        }
        if (isdefined(einflictor.challenge_hatchettosscount)) {
            data.inflictorchallenge_hatchettosscount = einflictor.challenge_hatchettosscount;
        } else {
            data.inflictorchallenge_hatchettosscount = 0;
        }
        if (isdefined(einflictor.ownerwassprinting)) {
            data.inflictorownerwassprinting = einflictor.ownerwassprinting;
        } else {
            data.inflictorownerwassprinting = 0;
        }
        if (isdefined(einflictor.playerhasengineerperk)) {
            data.inflictorplayerhasengineerperk = einflictor.playerhasengineerperk;
        } else {
            data.inflictorplayerhasengineerperk = 0;
        }
    } else {
        data.inflictoriscooked = 0;
        data.inflictorchallenge_hatchettosscount = 0;
        data.inflictorownerwassprinting = 0;
        data.inflictorplayerhasengineerperk = 0;
    }
    waitandprocessplayerkilledcallback(data);
    data.attacker notify(#"playerkilledchallengesprocessed");
}

// Namespace challenges
// Params 2, eflags: 0x1 linked
// Checksum 0x5175ab86, Offset: 0x6b20
// Size: 0xe2
function doscoreeventcallback(callback, data) {
    if (!isdefined(level.scoreeventcallbacks)) {
        return;
    }
    if (!isdefined(level.scoreeventcallbacks[callback])) {
        return;
    }
    if (isdefined(data)) {
        for (i = 0; i < level.scoreeventcallbacks[callback].size; i++) {
            thread [[ level.scoreeventcallbacks[callback][i] ]](data);
        }
        return;
    }
    for (i = 0; i < level.scoreeventcallbacks[callback].size; i++) {
        thread [[ level.scoreeventcallbacks[callback][i] ]]();
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x756ad309, Offset: 0x6c10
// Size: 0x8c
function waitandprocessplayerkilledcallback(data) {
    if (isdefined(data.attacker)) {
        data.attacker endon(#"disconnect");
    }
    wait(0.05);
    util::waittillslowprocessallowed();
    level thread dochallengecallback("playerKilled", data);
    level thread doscoreeventcallback("playerKilled", data);
}

// Namespace challenges
// Params 1, eflags: 0x0
// Checksum 0x89d306, Offset: 0x6ca8
// Size: 0x44
function weaponisknife(weapon) {
    if (weapon == level.weaponbasemelee || weapon == level.weaponbasemeleeheld || weapon == level.weaponballisticknife) {
        return true;
    }
    return false;
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0x6a03774e, Offset: 0x6cf8
// Size: 0x462
function eventreceived(eventname) {
    self endon(#"disconnect");
    util::waittillslowprocessallowed();
    switch (level.gametype) {
    case 135:
        if (eventname == "killstreak_10") {
            self addgametypestat("killstreak_10", 1);
        } else if (eventname == "killstreak_15") {
            self addgametypestat("killstreak_15", 1);
        } else if (eventname == "killstreak_20") {
            self addgametypestat("killstreak_20", 1);
        } else if (eventname == "multikill_3") {
            self addgametypestat("multikill_3", 1);
        } else if (eventname == "kill_enemy_who_killed_teammate") {
            self addgametypestat("kill_enemy_who_killed_teammate", 1);
        } else if (eventname == "kill_enemy_injuring_teammate") {
            self addgametypestat("kill_enemy_injuring_teammate", 1);
        }
        break;
    case 131:
        if (eventname == "killstreak_10") {
            self addgametypestat("killstreak_10", 1);
        } else if (eventname == "killstreak_15") {
            self addgametypestat("killstreak_15", 1);
        } else if (eventname == "killstreak_20") {
            self addgametypestat("killstreak_20", 1);
        } else if (eventname == "killstreak_30") {
            self addgametypestat("killstreak_30", 1);
        }
        break;
    case 75:
        if (eventname == "defused_bomb_last_man_alive") {
            self addgametypestat("defused_bomb_last_man_alive", 1);
        } else if (eventname == "elimination_and_last_player_alive") {
            self addgametypestat("elimination_and_last_player_alive", 1);
        } else if (eventname == "killed_bomb_planter") {
            self addgametypestat("killed_bomb_planter", 1);
        } else if (eventname == "killed_bomb_defuser") {
            self addgametypestat("killed_bomb_defuser", 1);
        }
        break;
    case 129:
        if (eventname == "kill_flag_carrier") {
            self addgametypestat("kill_flag_carrier", 1);
        } else if (eventname == "defend_flag_carrier") {
            self addgametypestat("defend_flag_carrier", 1);
        }
        break;
    case 130:
        if (eventname == "killed_bomb_planter") {
            self addgametypestat("killed_bomb_planter", 1);
        } else if (eventname == "killed_bomb_defuser") {
            self addgametypestat("killed_bomb_defuser", 1);
        }
        break;
    default:
        break;
    }
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x434c3ad4, Offset: 0x7168
// Size: 0x60
function monitor_player_sprint() {
    self endon(#"disconnect");
    self endon(#"killplayersprintmonitor");
    self endon(#"death");
    self.lastsprinttime = undefined;
    while (true) {
        self waittill(#"sprint_begin");
        self waittill(#"sprint_end");
        self.lastsprinttime = gettime();
    }
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x22c30967, Offset: 0x71d0
// Size: 0x1c
function isflashbanged() {
    return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

// Namespace challenges
// Params 0, eflags: 0x1 linked
// Checksum 0x9484e149, Offset: 0x71f8
// Size: 0x1c
function isheatwavestunned() {
    return isdefined(self._heat_wave_stuned_end) && gettime() < self._heat_wave_stuned_end;
}

// Namespace challenges
// Params 2, eflags: 0x1 linked
// Checksum 0xaed9091f, Offset: 0x7220
// Size: 0xfe
function trophy_defense(origin, radius) {
    if (isdefined(level.challenge_scorestreaksenabled) && level.challenge_scorestreaksenabled == 1) {
        entities = getdamageableentarray(origin, radius);
        foreach (entity in entities) {
            if (isdefined(entity.challenge_isscorestreak)) {
                self addplayerstat("protect_streak_with_trophy", 1);
                break;
            }
        }
    }
}

// Namespace challenges
// Params 1, eflags: 0x1 linked
// Checksum 0xc223f5d4, Offset: 0x7328
// Size: 0x1c
function waittilltimeoutordeath(timeout) {
    self endon(#"death");
    wait(timeout);
}

