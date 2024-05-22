#using scripts/shared/bb_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace bb;

// Namespace bb
// Params 0, eflags: 0x2
// Checksum 0xfb919ca, Offset: 0x918
// Size: 0x34
function function_2dc19561() {
    system::register("bb", &__init__, undefined, undefined);
}

// Namespace bb
// Params 0, eflags: 0x1 linked
// Checksum 0x67d59eaa, Offset: 0x958
// Size: 0x14
function __init__() {
    init_shared();
}

// Namespace bb
// Params 1, eflags: 0x5 linked
// Checksum 0x574ef48b, Offset: 0x978
// Size: 0xd8
function function_edae084d(player) {
    var_24a24c3f = "";
    if (isdefined(player.var_b3dc8451)) {
        for (index = 0; index < player.var_b3dc8451.size; index++) {
            if (isdefined(player.var_b3dc8451[index]) && player.var_b3dc8451[index]) {
                if (isdefined(var_24a24c3f) && var_24a24c3f != "") {
                    var_24a24c3f += ";";
                }
                var_24a24c3f += index;
            }
        }
    }
    return var_24a24c3f;
}

// Namespace bb
// Params 1, eflags: 0x5 linked
// Checksum 0x8691e15f, Offset: 0xa58
// Size: 0xe0
function function_b918cb9(player) {
    var_6a98da9a = "";
    foreach (var_3ca39bd6, var_ee404e07 in player.var_1c0132c) {
        if (var_6a98da9a != "") {
            var_6a98da9a += ";";
        }
        var_6a98da9a += var_3ca39bd6 + ":" + var_ee404e07;
    }
    return var_6a98da9a;
}

// Namespace bb
// Params 1, eflags: 0x1 linked
// Checksum 0x2784a880, Offset: 0xb40
// Size: 0x91c
function function_e7f3440(player) {
    if (!isplayer(player)) {
        return;
    }
    var_4b34a5fc = 1;
    if (isdefined(player.deaths) && player.deaths > 0) {
        var_4b34a5fc = player.deaths;
    }
    kdratio = player.kills / var_4b34a5fc;
    playertime = 0;
    if (isdefined(player.var_5df1dd49)) {
        playertime = gettime() - player.var_5df1dd49;
    }
    totalshots = 0;
    shotshit = 0;
    if (isdefined(player._bbdata)) {
        totalshots = isdefined(player._bbdata["shots"]) ? player._bbdata["shots"] : 0;
        shotshit = isdefined(player._bbdata["hits"]) ? player._bbdata["hits"] : 0;
    }
    accuracy = 0;
    if (totalshots > 0) {
        accuracy = shotshit / totalshots;
    }
    var_6a98da9a = function_b918cb9(player);
    var_24a24c3f = function_edae084d(player);
    corners = getentarray("minimap_corner", "targetname");
    var_c5fc654e = 0;
    var_ebfedfb7 = 0;
    if (isdefined(corners) && corners.size >= 2) {
        var_c5fc654e = corners[1].origin[0] - corners[0].origin[0];
        var_ebfedfb7 = corners[1].origin[1] - corners[0].origin[1];
    }
    rankxp = 0;
    rank = 0;
    if (isdefined(player.pers)) {
        if (isdefined(player.pers["rank"])) {
            rank = player.pers["rank"];
        }
        if (isdefined(player.pers["rankxp"])) {
            rankxp = player.pers["rankxp"];
        }
    }
    var_82ff3ed3 = 0;
    var_93b6bd63 = 0;
    var_839dfb41 = 0;
    var_142b9d5 = 0;
    var_32d177c9 = 0;
    var_c7adc857 = 0;
    var_62519794 = 0;
    var_38b26966 = 0;
    var_512e490e = 0;
    if (isdefined(player.movementtracking)) {
        if (isdefined(player.movementtracking.doublejump)) {
            var_82ff3ed3 = player.movementtracking.doublejump.distance;
            var_93b6bd63 = player.movementtracking.doublejump.count;
            var_839dfb41 = player.movementtracking.doublejump.time;
        }
        if (isdefined(player.movementtracking.wallrunning)) {
            var_142b9d5 = player.movementtracking.wallrunning.distance;
            var_32d177c9 = player.movementtracking.wallrunning.count;
            var_c7adc857 = player.movementtracking.wallrunning.time;
        }
        if (isdefined(player.movementtracking.sprinting)) {
            var_62519794 = player.movementtracking.sprinting.distance;
            var_38b26966 = player.movementtracking.sprinting.count;
            var_512e490e = player.movementtracking.sprinting.time;
        }
    }
    playerid = getplayerspawnid(player);
    bestkillstreak = isdefined(player.pers["best_kill_streak"]) ? player.pers["best_kill_streak"] : 0;
    var_247e0696 = isdefined(player.var_247e0696) ? player.var_247e0696 : 0;
    headshots = isdefined(player.headshots) ? player.headshots : 0;
    var_7b9eb83b = isdefined(player.primaryloadoutweapon) ? player.primaryloadoutweapon.name : "undefined";
    currentweapon = isdefined(player.currentweapon) ? player.currentweapon.name : "undefined";
    grenadesused = isdefined(player.grenadesused) ? player.grenadesused : 0;
    playername = isdefined(player.name) ? player.name : "undefined";
    kills = isdefined(player.kills) ? player.kills : 0;
    deaths = isdefined(player.deaths) ? player.deaths : 0;
    incaps = isdefined(player.pers["incaps"]) ? player.pers["incaps"] : 0;
    assists = isdefined(player.assists) ? player.assists : 0;
    score = isdefined(player.score) ? player.score : 0;
    bbprint("cpplayermatchsummary", "gametime %d spawnid %d username %s kills %d deaths %d incaps %d kd %f shotshit %d totalshots %d accuracy %f assists %d score %d playertime %d meleekills %d headshots %d primaryloadoutweapon %s currentweapon %s grenadesused %d bestkillstreak %d dj_dist %d dj_count %d dj_time %d wallrun_dist %d wallrun_count %d wallrun_time %d sprint_dist %d sprint_count %d sprint_time %d cybercomsused %s dim0 %d dim1 %d rank %d rankxp %d collectibles %s", gettime(), playerid, playername, kills, deaths, incaps, kdratio, shotshit, totalshots, accuracy, assists, score, playertime, var_247e0696, headshots, var_7b9eb83b, currentweapon, grenadesused, bestkillstreak, var_82ff3ed3, var_93b6bd63, var_839dfb41, var_142b9d5, var_32d177c9, var_c7adc857, var_62519794, var_38b26966, var_512e490e, var_6a98da9a, var_c5fc654e, var_ebfedfb7, rank, rankxp, var_24a24c3f);
}

// Namespace bb
// Params 3, eflags: 0x1 linked
// Checksum 0xda90d10c, Offset: 0x1468
// Size: 0x134
function function_bea1c67c(objectivename, player, status) {
    playerid = -1;
    if (isplayer(player)) {
        playerid = getplayerspawnid(player);
    } else {
        return;
    }
    bbprint("cpcheckpoints", "gametime %d spawnid %d username %s checkpointname %s eventtype %s playerx %d playery %d playerz %d kills %d revives %d deathcount %d deaths %d headshots %d hits %d score %d shotshit %d shotsmissed %d suicides %d downs %d difficulty %s", gettime(), playerid, player.name, objectivename, status, player.origin, player.kills, player.revives, player.deathcount, player.deaths, player.headshots, player.hits, player.score, player.shotshit, player.shotsmissed, player.suicides, player.downs, level.currentdifficulty);
}

// Namespace bb
// Params 8, eflags: 0x1 linked
// Checksum 0xfa4d0b8e, Offset: 0x15a8
// Size: 0x5a4
function logdamage(attacker, victim, weapon, damage, damagetype, hitlocation, victimkilled, victimdowned) {
    victimid = -1;
    victimname = "";
    victimtype = "";
    victimorigin = (0, 0, 0);
    var_4c26f55 = 0;
    var_99e7469c = 0;
    var_f4bca593 = 0;
    var_cb683866 = 0;
    var_38d64c0f = "";
    victimlaststand = 0;
    var_8daf73c8 = 0;
    attackerid = -1;
    attackername = "";
    attackertype = "";
    attackerorigin = (0, 0, 0);
    var_6ecba8dc = 0;
    var_33f13d47 = 0;
    var_b8bd32a2 = 0;
    var_ad96a70b = 0;
    var_cd3a2efe = "";
    var_b434c004 = 0;
    var_e5f9350b = "";
    var_b8b49851 = "";
    var_b1989306 = "";
    var_c46938ee = "";
    var_5833b024 = "";
    var_2b383b77 = "";
    if (isdefined(attacker)) {
        if (isplayer(attacker)) {
            attackerid = getplayerspawnid(attacker);
            attackertype = "_player";
            attackername = attacker.name;
        } else if (isai(attacker)) {
            attackertype = "_ai";
            var_2b383b77 = attacker.combatmode;
            attackerid = attacker.actor_id;
        } else {
            attackertype = "_other";
        }
        attackerorigin = attacker.origin;
        var_6ecba8dc = attacker.ignoreme;
        var_b8bd32a2 = attacker.fovcosine;
        var_ad96a70b = attacker.maxsightdistsqrd;
        if (isdefined(attacker.animname)) {
            var_cd3a2efe = attacker.animname;
        }
        if (isdefined(attacker.laststand)) {
            var_b434c004 = attacker.laststand;
        }
    }
    if (isdefined(victim)) {
        if (isplayer(victim)) {
            victimid = getplayerspawnid(victim);
            victimtype = "_player";
            victimname = victim.name;
            var_8daf73c8 = victim.downs;
        } else if (isai(victim)) {
            victimtype = "_ai";
            var_b1989306 = victim.combatmode;
            victimid = victim.actor_id;
        } else {
            victimtype = "_other";
        }
        victimorigin = victim.origin;
        var_4c26f55 = victim.ignoreme;
        var_f4bca593 = victim.fovcosine;
        var_cb683866 = victim.maxsightdistsqrd;
        if (isdefined(victim.animname)) {
            var_38d64c0f = victim.animname;
        }
        if (isdefined(victim.laststand)) {
            victimlaststand = victim.laststand;
        }
    }
    bbprint("cpattacks", "gametime %d attackerid %d attackertype %s attackername %s attackerweapon %s attackerx %d attackery %d attackerz %d aiattckercombatmode %s attackerignoreme %d attackerignoreall %d attackerfovcos %d attackermaxsightdistsqrd %d attackeranimname %s attackerlaststand %d victimid %d victimtype %s victimname %s victimx %d victimy %d victimz %d aivictimcombatmode %s victimignoreme %d victimignoreall %d victimfovcos %d victimmaxsightdistsqrd %d victimanimname %s victimlaststand %d damage %d damagetype %s damagelocation %s death %d victimdowned %d downs %d", gettime(), attackerid, attackertype, attackername, weapon.name, attackerorigin, var_2b383b77, var_6ecba8dc, var_33f13d47, var_b8bd32a2, var_ad96a70b, var_cd3a2efe, var_b434c004, victimid, victimtype, victimname, victimorigin, var_b1989306, var_4c26f55, var_99e7469c, var_f4bca593, var_cb683866, var_38d64c0f, victimlaststand, damage, damagetype, hitlocation, victimkilled, victimdowned, var_8daf73c8);
}

// Namespace bb
// Params 2, eflags: 0x1 linked
// Checksum 0x9f3ad9b, Offset: 0x1b58
// Size: 0xfc
function logaispawn(aient, spawner) {
    bbprint("cpaispawn", "gametime %d actorid %d aitype %s archetype %s airank %s accuracy %d originx %d originy %d originz %d weapon %s team %s alertlevel %s grenadeawareness %d canflank %d engagemaxdist %d engagemaxfalloffdist %d engagemindist %d engageminfalloffdist %d health %d", gettime(), aient.actor_id, aient.aitype, aient.archetype, aient.airank, aient.accuracy, aient.origin, aient.primaryweapon.name, aient.team, aient.alertlevel, aient.grenadeawareness, aient.canflank, aient.engagemaxdist, aient.var_48ae01f2, aient.engagemindist, aient.engageminfalloffdist, aient.health);
}

// Namespace bb
// Params 2, eflags: 0x1 linked
// Checksum 0xf63741aa, Offset: 0x1c60
// Size: 0x154
function function_945c54c5(notificationtype, player) {
    playerid = -1;
    playertype = "";
    playerposition = (0, 0, 0);
    playername = "";
    if (isai(player)) {
        playerid = player.actor_id;
        playertype = "_ai";
        playerposition = player.origin;
    } else if (isplayer(player)) {
        playerid = getplayerspawnid(player);
        playertype = "_player";
        playerposition = player.origin;
        playername = player.name;
    }
    bbprint("cpnotifications", "gametime %d notificationtype %s spawnid %d username %s spawnidtype %s locationx %d locationy %d locationz %d", gettime(), notificationtype, playerid, playername, playertype, playerposition);
}

// Namespace bb
// Params 3, eflags: 0x1 linked
// Checksum 0x798e1e14, Offset: 0x1dc0
// Size: 0x15c
function function_42ffd679(player, event, gadget) {
    userid = -1;
    usertype = "";
    var_db66094d = (0, 0, 0);
    username = "";
    if (isai(player)) {
        userid = player.actor_id;
        usertype = "_ai";
        var_db66094d = player.origin;
    } else if (isplayer(player)) {
        userid = getplayerspawnid(player);
        usertype = "_player";
        var_db66094d = player.origin;
        username = player.name;
    }
    bbprint("cpcybercomevents", "gametime %d userid %d username %s usertype %s eventtype %s gadget %s locationx %d locationy %d locationz %d", gettime(), userid, username, usertype, event, gadget, var_db66094d);
}

// Namespace bb
// Params 4, eflags: 0x1 linked
// Checksum 0xab716e51, Offset: 0x1f28
// Size: 0x17c
function function_1a69bad6(var_932b0331, attacker, var_1a69bad6, radius) {
    attackerid = -1;
    attackertype = "";
    attackerposition = (0, 0, 0);
    attackerusername = "";
    if (isai(attacker)) {
        attackerid = attacker.actor_id;
        attackertype = "_ai";
        attackerposition = attacker.origin;
    } else if (isplayer(attacker)) {
        attackerid = getplayerspawnid(attacker);
        attackertype = "_player";
        attackerposition = attacker.origin;
        attackerusername = attacker.name;
    }
    bbprint("cpexplosionevents", "gametime %d explosiontype %s objectname %s attackerid %d attackerusername %s attackertype %s locationx %d locationy %d locationz %d radius %d attackerx %d attackery %d attackerz %d", gettime(), var_1a69bad6, var_932b0331.classname, attackerid, attackerusername, attackertype, var_932b0331.origin, radius, attackerposition);
}

