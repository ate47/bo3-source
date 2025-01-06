#using scripts/mp/_util;
#using scripts/mp/gametypes/_dogtags;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/util_shared;

#namespace conf;

// Namespace conf
// Params 0, eflags: 0x0
// Checksum 0xd036bede, Offset: 0x3c8
// Size: 0x292
function main() {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 50000);
    util::registerroundlimit(0, 10);
    util::registerroundswitch(0, 9);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.scoreroundwinbased = 1;
    level.teambased = 1;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onroundendgame = &onroundendgame;
    level.onplayerkilled = &onplayerkilled;
    level.onroundswitch = &onroundswitch;
    level.overrideteamscore = 1;
    level.teamscoreperkill = getgametypesetting("teamScorePerKill");
    level.teamscoreperkillconfirmed = getgametypesetting("teamScorePerKillConfirmed");
    level.teamscoreperkilldenied = getgametypesetting("teamScorePerKillDenied");
    gameobjects::register_allowed_gameobject(level.gametype);
    globallogic_audio::set_leader_gametype_dialog("startKillConfirmed", "hcCtartKillConfirmed", "gameBoost", "gameBoost");
    if (!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen()) {
        globallogic::setvisiblescoreboardcolumns("score", "kills", "killsconfirmed", "killsdenied", "deaths");
        return;
    }
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "killsconfirmed", "killsdenied");
}

// Namespace conf
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x668
// Size: 0x2
function onprecachegametype() {
    
}

// Namespace conf
// Params 0, eflags: 0x0
// Checksum 0xaf336d91, Offset: 0x678
// Size: 0x71
function onstartgametype() {
    setclientnamemode("auto_change");
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace conf
// Params 9, eflags: 0x0
// Checksum 0xd0bf156a, Offset: 0x948
// Size: 0xda
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (!isplayer(attacker) || attacker.team == self.team) {
        return;
    }
    level thread dogtags::spawn_dog_tag(self, attacker, &onuse, 1);
    if (isdefined(level.killstreaksgivegamescore) && (!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || level.killstreaksgivegamescore)) {
        attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
    }
}

// Namespace conf
// Params 1, eflags: 0x0
// Checksum 0xf63bd4e1, Offset: 0xa30
// Size: 0x1c2
function onuse(player) {
    tacinsertboost = 0;
    if (player.team != self.attackerteam) {
        tacinsertboost = self.tacinsert;
        if (isdefined(self.attacker) && self.attacker.team == self.attackerteam) {
            self.attacker luinotifyevent(%player_callout, 2, %MP_KILL_DENIED, player.entnum);
        }
        if (!tacinsertboost) {
            player globallogic_score::giveteamscoreforobjective(player.team, level.teamscoreperkilldenied);
        }
    } else {
        /#
            assert(isdefined(player.lastkillconfirmedtime));
            assert(isdefined(player.lastkillconfirmedcount));
        #/
        player.pers["killsconfirmed"]++;
        player.killsconfirmed = player.pers["killsconfirmed"];
        player globallogic_score::giveteamscoreforobjective(player.team, level.teamscoreperkillconfirmed);
    }
    if (!tacinsertboost) {
        currenttime = gettime();
        if (player.lastkillconfirmedtime + 1000 > currenttime) {
            player.lastkillconfirmedcount++;
            if (player.lastkillconfirmedcount >= 3) {
                scoreevents::processscoreevent("kill_confirmed_multi", player);
                player.lastkillconfirmedcount = 0;
            }
        } else {
            player.lastkillconfirmedcount = 1;
        }
        player.lastkillconfirmedtime = currenttime;
    }
}

// Namespace conf
// Params 1, eflags: 0x0
// Checksum 0x3ba0464e, Offset: 0xc00
// Size: 0x62
function onspawnplayer(predictedspawn) {
    self.usingobj = undefined;
    if (level.usestartspawns && !level.ingraceperiod) {
        level.usestartspawns = 0;
    }
    self.lastkillconfirmedtime = 0;
    self.lastkillconfirmedcount = 0;
    spawning::onspawnplayer(predictedspawn);
    dogtags::on_spawn_player();
}

// Namespace conf
// Params 0, eflags: 0x0
// Checksum 0x6dc5035, Offset: 0xc70
// Size: 0x9
function onroundswitch() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace conf
// Params 1, eflags: 0x0
// Checksum 0x56838ede, Offset: 0xc90
// Size: 0x21
function onroundendgame(roundwinner) {
    return globallogic::determineteamwinnerbygamestat("roundswon");
}

