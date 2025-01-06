#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/killstreaks/_emp;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weapon_utils;

#namespace challenges;

// Namespace challenges
// Params 0, eflags: 0x2
// Checksum 0xfa677ee6, Offset: 0x9a0
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("challenges", &__init__, undefined, undefined);
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0xa556100b, Offset: 0x9d8
// Size: 0x32
function __init__() {
    init_shared();
    callback::on_start_gametype(&start_gametype);
}

// Namespace challenges
// Params 0, eflags: 0x0
// Checksum 0xb72d5853, Offset: 0xa18
// Size: 0x14b
function start_gametype() {
    if (!isdefined(level.challengescallbacks)) {
        level.challengescallbacks = [];
    }
    waittillframeend();
    if (isdefined(level.scoreeventgameendcallback)) {
        registerchallengescallback("gameEnd", level.scoreeventgameendcallback);
    }
    if (canprocesschallenges()) {
        registerchallengescallback("playerKilled", &challengekills);
        registerchallengescallback("gameEnd", &challengegameend);
        registerchallengescallback("roundEnd", &challengeroundend);
    }
    callback::on_connect(&on_player_connect);
    foreach (team in level.teams) {
        initteamchallenges(team);
    }
}

// Namespace challenges
// Params 2, eflags: 0x0
// Checksum 0x4e71ef65, Offset: 0xb70
// Size: 0x18d
function challengekills(data, time) {
    victim = data.victim;
    player = data.attacker;
    attacker = data.attacker;
    time = data.time;
    victim = data.victim;
    weapon = data.weapon;
    time = data.time;
    inflictor = data.einflictor;
    meansofdeath = data.smeansofdeath;
    wasplanting = data.wasplanting;
    wasdefusing = data.wasdefusing;
    lastweaponbeforetoss = data.lastweaponbeforetoss;
    ownerweaponatlaunch = data.ownerweaponatlaunch;
    if (!isdefined(data.weapon)) {
        return;
    }
    if (!isdefined(player) || !isplayer(player) || weapon == level.weaponnone) {
        return;
    }
    weaponclass = util::getweaponclass(weapon);
    InvalidOpCode(0xc8, "challenge", victim.team, "allAlive", 0);
    // Unknown operator (0xc8, t7_1b, PC)
}

