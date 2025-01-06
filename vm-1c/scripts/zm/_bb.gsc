#using scripts/codescripts/struct;
#using scripts/shared/bb_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/system_shared;

#namespace bb;

// Namespace bb
// Params 0, eflags: 0x2
// Checksum 0xbee79c6c, Offset: 0x698
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("bb", &__init__, undefined, undefined);
}

// Namespace bb
// Params 0, eflags: 0x0
// Checksum 0x6e8779f7, Offset: 0x6d8
// Size: 0x14
function __init__() {
    init_shared();
}

// Namespace bb
// Params 8, eflags: 0x0
// Checksum 0x9ff373f7, Offset: 0x6f8
// Size: 0x534
function logdamage(attacker, victim, weapon, damage, damagetype, hitlocation, victimkilled, victimdowned) {
    victimid = -1;
    victimtype = "";
    victimorigin = (0, 0, 0);
    var_4c26f55 = 0;
    var_99e7469c = 0;
    var_f4bca593 = 0;
    var_cb683866 = 0;
    var_38d64c0f = "";
    victimname = "";
    var_8daf73c8 = 0;
    attackerid = -1;
    attackertype = "";
    attackerorigin = (0, 0, 0);
    var_6ecba8dc = 0;
    var_33f13d47 = 0;
    var_b8bd32a2 = 0;
    var_ad96a70b = 0;
    var_cd3a2efe = "";
    attackername = "";
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
    }
    bbprint("zmattacks", "gametime %d roundnumber %d attackerid %d attackername %s attackertype %s attackerweapon %s attackerx %d attackery %d attackerz %d aiattckercombatmode %s attackerignoreme %d attackerignoreall %d attackerfovcos %d attackermaxsightdistsqrd %d attackeranimname %s victimid %d victimname %s victimtype %s victimx %d victimy %d victimz %d aivictimcombatmode %s victimignoreme %d victimignoreall %d victimfovcos %d victimmaxsightdistsqrd %d victimanimname %s damage %d damagetype %s damagelocation %s death %d downed %d downs %d", gettime(), level.round_number, attackerid, attackername, attackertype, weapon.name, attackerorigin, var_2b383b77, var_6ecba8dc, var_33f13d47, var_b8bd32a2, var_ad96a70b, var_cd3a2efe, victimid, victimname, victimtype, victimorigin, var_b1989306, var_4c26f55, var_99e7469c, var_f4bca593, var_cb683866, var_38d64c0f, damage, damagetype, hitlocation, victimkilled, victimdowned, var_8daf73c8);
}

// Namespace bb
// Params 2, eflags: 0x0
// Checksum 0xffa916fc, Offset: 0xc38
// Size: 0xbc
function logaispawn(aient, spawner) {
    bbprint("zmaispawn", "gametime %d actorid %d aitype %s archetype %s airank %s accuracy %d originx %d originy %d originz %d weapon %s melee_weapon %s health %d roundNum %d", gettime(), aient.actor_id, aient.aitype, aient.archetype, aient.airank, aient.accuracy, aient.origin, aient.primaryweapon.name, aient.meleeweapon.name, aient.health, level.round_number);
}

// Namespace bb
// Params 2, eflags: 0x0
// Checksum 0xb437d062, Offset: 0xd00
// Size: 0x144
function logplayerevent(player, eventname) {
    currentweapon = "";
    beastmodeactive = 0;
    if (isdefined(player.currentweapon)) {
        currentweapon = player.currentweapon.name;
    }
    if (isdefined(player.beastmode)) {
        beastmodeactive = player.beastmode;
    }
    bbprint("zmplayerevents", "gametime %d roundnumber %d eventname %s spawnid %d username %s originx %d originy %d originz %d health %d beastlives %d currentweapon %s kills %d zone_name %s sessionstate %s currentscore %d totalscore %d beastmodeon %d", gettime(), level.round_number, eventname, getplayerspawnid(player), player.name, player.origin, player.health, player.beastlives, currentweapon, player.kills, player.zone_name, player.sessionstate, player.score, player.score_total, beastmodeactive);
}

// Namespace bb
// Params 1, eflags: 0x0
// Checksum 0x5493d249, Offset: 0xe50
// Size: 0xca
function logroundevent(eventname) {
    bbprint("zmroundevents", "gametime %d roundnumber %d eventname %s", gettime(), level.round_number, eventname);
    foreach (player in level.players) {
        logplayerevent(player, eventname);
    }
}

// Namespace bb
// Params 7, eflags: 0x0
// Checksum 0x7cef30f4, Offset: 0xf28
// Size: 0xec
function logpurchaseevent(player, sellerent, cost, itemname, itemupgraded, itemtype, eventname) {
    bbprint("zmpurchases", "gametime %d roundnumber %d playerspawnid %d username %s itemname %s isupgraded %d itemtype %s purchasecost %d playeroriginx %d playeroriginy %d playeroriginz %d selleroriginx %d selleroriginy %d selleroriginz %d playerkills %d playerhealth %d playercurrentscore %d playertotalscore %d zone_name %s", gettime(), level.round_number, getplayerspawnid(player), player.name, itemname, itemupgraded, itemtype, cost, player.origin, sellerent.origin, player.kills, player.health, player.score, player.score_total, player.zone_name);
}

// Namespace bb
// Params 3, eflags: 0x0
// Checksum 0x5792fc11, Offset: 0x1020
// Size: 0x18a
function logpowerupevent(powerup, optplayer, eventname) {
    playerspawnid = -1;
    playername = "";
    if (isdefined(optplayer) && isplayer(optplayer)) {
        playerspawnid = getplayerspawnid(optplayer);
        playername = optplayer.name;
    }
    bbprint("zmpowerups", "gametime %d roundnumber %d powerupname %s powerupx %d powerupy %d powerupz %d, eventname %s playerspawnid %d playername %s", gettime(), level.round_number, powerup.powerup_name, powerup.origin, eventname, playerspawnid, playername);
    foreach (player in level.players) {
        logplayerevent(player, "powerup_" + powerup.powerup_name + "_" + eventname);
    }
}

