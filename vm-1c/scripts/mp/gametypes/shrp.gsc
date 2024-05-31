#using scripts/mp/_util;
#using scripts/mp/gametypes/_wager;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic;
#using scripts/shared/weapons/_weapon_utils;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/persistence_shared;
#using scripts/shared/math_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/array_shared;

#namespace shrp;

// Namespace shrp
// Params 0, eflags: 0x0
// Checksum 0x4af9d642, Offset: 0x7d8
// Size: 0x364
function main() {
    globallogic::init();
    level.pointsperweaponkill = getgametypesetting("pointsPerWeaponKill");
    level.pointspermeleekill = getgametypesetting("pointsPerMeleeKill");
    level.var_e2ba8e45 = getgametypesetting("weaponTimer");
    level.var_9e0e70b9 = getgametypesetting("weaponCount");
    util::registertimelimit(level.var_9e0e70b9 * level.var_e2ba8e45 / 60, level.var_9e0e70b9 * level.var_e2ba8e45 / 60);
    util::registerscorelimit(0, 50000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    level.var_8619115e = &function_8619115e;
    gameobjects::register_allowed_gameobject(level.gametype);
    level.givecustomloadout = &givecustomloadout;
    game["dialog"]["gametype"] = "ss_start";
    game["dialog"]["wm_weapons_cycled"] = "ssharp_cycle_01";
    game["dialog"]["wm_final_weapon"] = "ssharp_fweapon";
    game["dialog"]["wm_bonus_rnd"] = "ssharp_2multi_00";
    game["dialog"]["wm_shrp_rnd"] = "ssharp_sround";
    game["dialog"]["wm_bonus0"] = "boost_gen_05";
    game["dialog"]["wm_bonus1"] = "boost_gen_05";
    game["dialog"]["wm_bonus2"] = "boost_gen_05";
    game["dialog"]["wm_bonus3"] = "boost_gen_05";
    game["dialog"]["wm_bonus4"] = "boost_gen_05";
    game["dialog"]["wm_bonus5"] = "boost_gen_05";
    globallogic::setvisiblescoreboardcolumns("pointstowin", "kills", "deaths", "stabs", "x2score");
}

// Namespace shrp
// Params 0, eflags: 0x0
// Checksum 0xd3dce8c4, Offset: 0xb48
// Size: 0x544
function onstartgametype() {
    setdvar("scr_disable_weapondrop", 1);
    setdvar("scr_xpscalemp", 0);
    setdvar("ui_guncycle", 0);
    setclientnamemode("auto_change");
    util::setobjectivetext("allies", %OBJECTIVES_SHRP);
    util::setobjectivetext("axis", %OBJECTIVES_SHRP);
    function_e7dafa3c();
    if (level.splitscreen) {
        util::setobjectivescoretext("allies", %OBJECTIVES_SHRP);
        util::setobjectivescoretext("axis", %OBJECTIVES_SHRP);
    } else {
        util::setobjectivescoretext("allies", %OBJECTIVES_SHRP_SCORE);
        util::setobjectivescoretext("axis", %OBJECTIVES_SHRP_SCORE);
    }
    util::setobjectivehinttext("allies", %OBJECTIVES_SHRP_HINT);
    util::setobjectivehinttext("axis", %OBJECTIVES_SHRP_HINT);
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
    namespace_93432369::function_3a002997("specialty_bulletflinch", "perk", %PERKS_TOUGHNESS, "perk_warrior");
    namespace_93432369::function_3a002997("specialty_movefaster", "perk", %PERKS_LIGHTWEIGHT, "perk_lightweight");
    namespace_93432369::function_3a002997("specialty_fallheight", "perk", %PERKS_LIGHTWEIGHT, "perk_lightweight");
    namespace_93432369::function_3a002997("specialty_longersprint", "perk", %PERKS_EXTREME_CONDITIONING, "perk_marathon");
    namespace_93432369::function_3a002997(2, "score_multiplier", %PERKS_SCORE_MULTIPLIER, "perk_times_two");
    level.var_1755e798 = hud::createservertimer("extrasmall", 1.2);
    level.var_1755e798.horzalign = "user_left";
    level.var_1755e798.vertalign = "user_top";
    level.var_1755e798.x = 10;
    level.var_1755e798.y = 123;
    level.var_1755e798.alignx = "left";
    level.var_1755e798.aligny = "top";
    level.var_1755e798.label = %MP_SHRP_COUNTDOWN;
    level.var_1755e798.alpha = 0;
    level.var_1755e798.hidewheninkillcam = 1;
    level.displayroundendtext = 0;
    level.quickmessagetoall = 1;
    level thread function_2651a506();
    level thread function_6cbc2f85();
}

// Namespace shrp
// Params 0, eflags: 0x0
// Checksum 0xf1a8a97, Offset: 0x1098
// Size: 0x11c
function function_e7dafa3c() {
    level.var_e786da73 = [];
    function_4ade964d();
    for (i = 0; i < 33; i++) {
        var_c04d8f24 = tablelookuprownum(level.var_1c7259a9, 9, i);
        if (var_c04d8f24 > -1) {
            name = tablelookupcolumnforrow(level.var_1c7259a9, var_c04d8f24, 4);
            level.var_e786da73[name] = [];
            var_652fb103 = tablelookupcolumnforrow(level.var_1c7259a9, var_c04d8f24, 11);
            level.var_e786da73[name] = strtok(var_652fb103, " ");
        }
    }
}

// Namespace shrp
// Params 0, eflags: 0x0
// Checksum 0x760ce2d3, Offset: 0x11c0
// Size: 0x20
function function_4ade964d() {
    if (!isdefined(level.var_1c7259a9)) {
        level.var_1c7259a9 = "gamedata/weapons/common/attachmentTable.csv";
    }
}

// Namespace shrp
// Params 0, eflags: 0x0
// Checksum 0xa8f29246, Offset: 0x11e8
// Size: 0x4d0
function function_47c621e8() {
    var_ed21a84a = getarraykeys(level.tbl_weaponids);
    var_1572ab08 = var_ed21a84a.size;
    var_c8af4f01 = 0;
    if (isdefined(level.gunprogression)) {
        size = level.gunprogression.size;
    }
    /#
        var_1b8d68e9 = getdvarstring("PERKS_TOUGHNESS");
    #/
    var_5e774679 = 1;
    players = getplayers();
    foreach (player in players) {
        if (player getstance() == "prone") {
            var_5e774679 = 0;
            break;
        }
    }
    while (true) {
        randomindex = randomint(var_1572ab08 + var_c8af4f01);
        baseweaponname = "";
        weaponname = "";
        if (randomindex < var_1572ab08) {
            id = array::random(level.tbl_weaponids);
            if (id["group"] != "weapon_launcher" && id["group"] != "weapon_sniper" && id["group"] != "weapon_lmg" && id["group"] != "weapon_assault" && id["group"] != "weapon_smg" && id["group"] != "weapon_pistol" && id["group"] != "weapon_cqb" && id["group"] != "weapon_special") {
                continue;
            }
            if (id["reference"] == "weapon_null") {
                continue;
            }
            baseweaponname = id["reference"];
            attachmentlist = id["attachment"];
            if (baseweaponname == "m32") {
                baseweaponname = "m32_wager";
            }
            if (baseweaponname == "minigun") {
                baseweaponname = "minigun_wager";
            }
            if (baseweaponname == "riotshield") {
                continue;
            }
            weaponname = function_a0add75a(baseweaponname, attachmentlist);
            weapon = getweapon(weaponname);
            if (!var_5e774679 && weapon.blocksprone) {
                continue;
            }
        } else {
            baseweaponname = level.gunprogression[randomindex - var_1572ab08].names[0];
            weaponname = level.gunprogression[randomindex - var_1572ab08].names[0];
        }
        if (!isdefined(level.var_3a8aba68)) {
            level.var_3a8aba68 = [];
            level.var_3a8aba68[0] = "fhj18";
        }
        var_faaf5768 = 0;
        for (i = 0; i < level.var_3a8aba68.size; i++) {
            if (level.var_3a8aba68[i] == baseweaponname) {
                var_faaf5768 = 1;
                break;
            }
        }
        if (var_faaf5768) {
            continue;
        }
        level.var_3a8aba68[level.var_3a8aba68.size] = baseweaponname;
        /#
            if (var_1b8d68e9 != "") {
                weaponname = var_1b8d68e9;
            }
        #/
        return weaponname;
    }
}

// Namespace shrp
// Params 2, eflags: 0x0
// Checksum 0x7110333c, Offset: 0x16c0
// Size: 0x236
function function_a0add75a(baseweaponname, attachmentlist) {
    if (!isdefined(attachmentlist)) {
        return baseweaponname;
    }
    attachments = strtok(attachmentlist, " ");
    arrayremovevalue(attachments, "dw");
    if (attachments.size <= 0) {
        return baseweaponname;
    }
    attachments[attachments.size] = "";
    attachment = array::random(attachments);
    if (attachment == "") {
        return baseweaponname;
    }
    if (issubstr(attachment, "_")) {
        attachment = strtok(attachment, "_")[0];
    }
    if (isdefined(level.var_e786da73[attachment]) && level.var_e786da73[attachment].size > 0) {
        attachment2 = level.var_e786da73[attachment][randomint(level.var_e786da73[attachment].size)];
        contains = 0;
        for (i = 0; i < attachments.size; i++) {
            if (isdefined(attachment2) && attachments[i] == attachment2) {
                contains = 1;
                break;
            }
        }
        if (contains) {
            if (attachment < attachment2) {
                return (baseweaponname + attachment + "+" + attachment2);
            }
            return (baseweaponname + attachment2 + "+" + attachment);
        }
    }
    return baseweaponname + attachment;
}

// Namespace shrp
// Params 2, eflags: 0x0
// Checksum 0x80682fcf, Offset: 0x1900
// Size: 0x178
function waitlongdurationwithhostmigrationpause(var_38c2b1f9, duration) {
    endtime = gettime() + duration * 1000;
    totaltimepassed = 0;
    while (gettime() < endtime) {
        hostmigration::waittillhostmigrationstarts((endtime - gettime()) / 1000);
        if (isdefined(level.hostmigrationtimer)) {
            setdvar("ui_guncycle", 0);
            timepassed = hostmigration::waittillhostmigrationdone();
            totaltimepassed += timepassed;
            endtime += timepassed;
            /#
                println("group" + timepassed);
                println("uin_timer_wager_beep" + totaltimepassed);
                println("<unknown string>" + level.discardtime);
            #/
            setdvar("ui_guncycle", var_38c2b1f9 + totaltimepassed);
        }
    }
    hostmigration::waittillhostmigrationdone();
    return totaltimepassed;
}

// Namespace shrp
// Params 2, eflags: 0x0
// Checksum 0x75b5bb3e, Offset: 0x1a80
// Size: 0x282
function function_93c42307(var_38c2b1f9, waittime) {
    var_fa793d99 = 1;
    setdvar("ui_guncycle", var_38c2b1f9);
    level.var_1755e798 settimer(waittime);
    level.var_1755e798.alpha = 1;
    timepassed = waitlongdurationwithhostmigrationpause(var_38c2b1f9, (var_38c2b1f9 - gettime()) / 1000 - 6);
    var_38c2b1f9 += timepassed;
    for (i = 6; i > 1; i--) {
        for (j = 0; j < level.players.size; j++) {
            level.players[j] playlocalsound("uin_timer_wager_beep");
        }
        timepassed = waitlongdurationwithhostmigrationpause(var_38c2b1f9, (var_38c2b1f9 - gettime()) / 1000 / i);
        var_38c2b1f9 += timepassed;
    }
    for (i = 0; i < level.players.size; i++) {
        level.players[i] playlocalsound("uin_timer_wager_last_beep");
    }
    if (var_38c2b1f9 - gettime() > 0) {
        wait((var_38c2b1f9 - gettime()) / 1000);
    }
    level.var_10f06d47 = getweapon(function_47c621e8());
    for (i = 0; i < level.players.size; i++) {
        level.players[i] notify(#"remove_planted_weapons");
        level.players[i] givecustomloadout(0, 1);
    }
    return var_fa793d99;
}

// Namespace shrp
// Params 0, eflags: 0x0
// Checksum 0x7930d3f9, Offset: 0x1d10
// Size: 0x39e
function function_2651a506() {
    level endon(#"game_ended");
    level thread function_9ae59632();
    waittime = level.var_e2ba8e45;
    var_d627f2d9 = 15;
    level.var_10f06d47 = getweapon(function_47c621e8());
    if (level.inprematchperiod) {
        level waittill(#"prematch_over");
    }
    var_41032cc9 = 1;
    var_5453392a = int(level.timelimit * 60 / waittime + 0.5);
    while (true) {
        var_38c2b1f9 = gettime() + waittime * 1000;
        var_d629deb1 = 0;
        var_ccd9ab33 = var_41032cc9 == var_5453392a - 1;
        for (i = 0; i < level.players.size; i++) {
            level.players[i].var_3b8fd4f1 = 0;
        }
        level.var_80557a4f = 0;
        function_93c42307(var_38c2b1f9, waittime);
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (var_41032cc9 + 1 == var_5453392a) {
                player namespace_93432369::announcer("wm_final_weapon");
            } else {
                player namespace_93432369::announcer("wm_weapons_cycled");
            }
            player function_2e17d934();
        }
        if (var_d629deb1) {
            level.var_a7f2a2a4 = 2;
            for (i = 0; i < level.players.size; i++) {
                level.players[i] thread namespace_93432369::function_972d1b69(%MP_SHRP_PENULTIMATE_RND, 0, %MP_SHRP_PENULTIMATE_MULTIPLIER, "wm_bonus_rnd");
            }
        } else if (var_ccd9ab33) {
            var_6d3adedc = level.var_a7f2a2a4;
            if (!isdefined(var_6d3adedc)) {
                var_6d3adedc = 1;
            }
            level.var_a7f2a2a4 = 2;
            setdvar("ui_guncycle", 0);
            level.var_1755e798.alpha = 0;
            for (i = 0; i < level.players.size; i++) {
                level.players[i] thread namespace_93432369::function_972d1b69(%MP_SHRP_RND, 0, %MP_SHRP_FINAL_MULTIPLIER, "wm_shrp_rnd");
            }
            break;
        } else {
            level.var_a7f2a2a4 = 1;
        }
        var_41032cc9++;
    }
}

// Namespace shrp
// Params 0, eflags: 0x0
// Checksum 0xf6c8d979, Offset: 0x20b8
// Size: 0x4c
function function_2e17d934() {
    if (isdefined(self.var_3b8fd4f1) && self.var_3b8fd4f1 > 0) {
        if (self.var_3b8fd4f1 == level.var_80557a4f) {
            scoreevents::processscoreevent("most_points_shrp", self);
        }
    }
}

// Namespace shrp
// Params 0, eflags: 0x0
// Checksum 0x95555e9, Offset: 0x2110
// Size: 0x5e
function function_9ae59632() {
    level waittill(#"game_end");
    for (i = 0; i < level.players.size; i++) {
        level.players[i] function_2e17d934();
    }
}

// Namespace shrp
// Params 2, eflags: 0x0
// Checksum 0x481540e9, Offset: 0x2178
// Size: 0x15a
function givecustomloadout(takeallweapons, alreadyspawned) {
    var_a9b5caef = 0;
    if (!isdefined(alreadyspawned) || !alreadyspawned) {
        var_a9b5caef = 1;
    }
    self namespace_93432369::function_937040bd(takeallweapons, var_a9b5caef, level.var_10f06d47);
    self disableweaponcycling();
    self giveweapon(level.var_10f06d47);
    self switchtoweapon(level.var_10f06d47);
    self giveweapon(level.weaponbasemelee);
    if (!isdefined(alreadyspawned) || !alreadyspawned) {
        self setspawnweapon(level.var_10f06d47);
    }
    if (isdefined(takeallweapons) && !takeallweapons) {
        self thread function_f4e09ebe();
    } else {
        self enableweaponcycling();
    }
    return level.var_10f06d47;
}

// Namespace shrp
// Params 0, eflags: 0x0
// Checksum 0x3115f02a, Offset: 0x22e0
// Size: 0xfc
function function_f4e09ebe() {
    self endon(#"disconnect");
    self endon(#"death");
    for (;;) {
        newweapon = self waittill(#"weapon_change");
        if (newweapon != level.weaponnone) {
            break;
        }
    }
    weaponslist = self getweaponslist();
    for (i = 0; i < weaponslist.size; i++) {
        if (weaponslist[i] != level.var_10f06d47 && weaponslist[i] != level.weaponbasemelee) {
            self takeweapon(weaponslist[i]);
        }
    }
    self enableweaponcycling();
}

// Namespace shrp
// Params 9, eflags: 0x0
// Checksum 0xe0e8ef74, Offset: 0x23e8
// Size: 0x664
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(attacker) && isplayer(attacker) && attacker != self) {
        if (isdefined(level.var_a7f2a2a4) && level.var_a7f2a2a4 == 2) {
            if (!isdefined(attacker.pers["x2kills"])) {
                attacker.pers["x2kills"] = 1;
            } else {
                attacker.pers["x2kills"]++;
            }
            attacker.var_7718d67a = attacker.pers["x2kills"];
        } else if (isdefined(level.var_a7f2a2a4) && level.var_a7f2a2a4 == 3) {
            if (!isdefined(attacker.pers["x3kills"])) {
                attacker.pers["x3kills"] = 1;
            } else {
                attacker.pers["x3kills"]++;
            }
            attacker.var_7718d67a = attacker.pers["x3kills"];
        }
        if (isdefined(self.scoremultiplier) && self.scoremultiplier >= 2) {
            scoreevents::processscoreevent("kill_x2_score_shrp", attacker, self, weapon);
        }
        var_6cca6195 = attacker.var_6cca6195;
        if (!isdefined(var_6cca6195)) {
            var_6cca6195 = 0;
        }
        if (var_6cca6195 < level.poweruplist.size) {
            attacker namespace_93432369::give_powerup(level.poweruplist[var_6cca6195]);
            attacker thread namespace_93432369::announcer("wm_bonus" + var_6cca6195);
            if (level.poweruplist[var_6cca6195].type == "score_multiplier" && attacker.scoremultiplier == 2) {
                scoreevents::processscoreevent("x2_score_shrp", attacker, self, weapon);
            }
            var_6cca6195++;
            attacker.var_6cca6195 = var_6cca6195;
        }
        if (var_6cca6195 >= level.poweruplist.size) {
            if (isdefined(attacker.powerups) && isdefined(attacker.powerups.size) && attacker.powerups.size > 0) {
                attacker thread namespace_93432369::function_b5a047c7(attacker.powerups.size - 1);
            }
        }
        scoremultiplier = 1;
        if (isdefined(attacker.scoremultiplier)) {
            scoremultiplier = attacker.scoremultiplier;
        }
        if (isdefined(level.var_a7f2a2a4)) {
            scoremultiplier *= level.var_a7f2a2a4;
        }
        var_67d60a31 = attacker.pointstowin;
        for (i = 1; i <= scoremultiplier; i++) {
            if (weapon_utils::ismeleemod(smeansofdeath) && level.var_10f06d47 != level.weaponbasemelee && level.var_10f06d47.isriotshield) {
                attacker globallogic_score::givepointstowin(level.pointspermeleekill);
                if (i != 1) {
                    scoreevents::processscoreevent("kill", attacker, self, weapon);
                    scoreevents::processscoreevent("wager_melee_kill", attacker, self, weapon);
                }
                continue;
            }
            attacker globallogic_score::givepointstowin(level.pointsperweaponkill);
            if (!isdefined(attacker.var_3b8fd4f1)) {
                attacker.var_3b8fd4f1 = 0;
            }
            attacker.var_3b8fd4f1 += level.pointsperweaponkill;
            if (level.var_80557a4f < attacker.var_3b8fd4f1) {
                level.var_80557a4f = attacker.var_3b8fd4f1;
            }
            if (i != 1) {
                scoreevents::processscoreevent("kill", attacker, self, weapon);
            }
        }
        var_67d60a31 = attacker.pointstowin - var_67d60a31;
        if (isdefined(level.var_a7f2a2a4) && (scoremultiplier > 1 || level.var_a7f2a2a4 > 1)) {
            attacker playlocalsound("uin_alert_cash_register");
            attacker.pers["x2score"] = attacker.pers["x2score"] + var_67d60a31;
            attacker.x2score = attacker.pers["x2score"];
        }
    }
    self.var_6cca6195 = 0;
    self.scoremultiplier = 1;
    self namespace_93432369::function_903348b0();
}

// Namespace shrp
// Params 1, eflags: 0x0
// Checksum 0xa091f3c7, Offset: 0x2a58
// Size: 0x3c
function onspawnplayer(predictedspawn) {
    spawning::onspawnplayer(predictedspawn);
    self thread infiniteammo();
}

// Namespace shrp
// Params 0, eflags: 0x0
// Checksum 0xdd0a90e9, Offset: 0x2aa0
// Size: 0x68
function infiniteammo() {
    self endon(#"death");
    self endon(#"disconnect");
    for (;;) {
        wait(0.1);
        weapon = self getcurrentweapon();
        self givemaxammo(weapon);
    }
}

// Namespace shrp
// Params 0, eflags: 0x0
// Checksum 0x3300c120, Offset: 0x2b10
// Size: 0x124
function function_8619115e() {
    var_7718d67a = self globallogic_score::getpersstat("x2kills");
    if (!isdefined(var_7718d67a)) {
        var_7718d67a = 0;
    }
    self persistence::function_2eb5e93("wagerAwards", var_7718d67a, 0);
    headshots = self globallogic_score::getpersstat("headshots");
    if (!isdefined(headshots)) {
        headshots = 0;
    }
    self persistence::function_2eb5e93("wagerAwards", headshots, 1);
    bestkillstreak = self globallogic_score::getpersstat("best_kill_streak");
    if (!isdefined(bestkillstreak)) {
        bestkillstreak = 0;
    }
    self persistence::function_2eb5e93("wagerAwards", bestkillstreak, 2);
}

// Namespace shrp
// Params 0, eflags: 0x0
// Checksum 0x50307e0a, Offset: 0x2c40
// Size: 0x6e
function function_6cbc2f85() {
    level waittill(#"game_ended");
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        player namespace_93432369::function_903348b0();
    }
}

