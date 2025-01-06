#using scripts/mp/_teamops;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_dogtags;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_spawn;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace tdm;

// Namespace tdm
// Params 0, eflags: 0x0
// Checksum 0x3cced1b8, Offset: 0x388
// Size: 0x24a
function main() {
    globallogic::init();
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 50000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.scoreroundwinbased = getgametypesetting("cumulativeRoundScores") == 0;
    level.teamscoreperkill = getgametypesetting("teamScorePerKill");
    level.teamscoreperdeath = getgametypesetting("teamScorePerDeath");
    level.teamscoreperheadshot = getgametypesetting("teamScorePerHeadshot");
    level.killstreaksgivegamescore = getgametypesetting("killstreaksGiveGameScore");
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onroundendgame = &onroundendgame;
    level.onroundswitch = &onroundswitch;
    level.onplayerkilled = &onplayerkilled;
    gameobjects::register_allowed_gameobject(level.gametype);
    globallogic_audio::set_leader_gametype_dialog("startTeamDeathmatch", "hcStartTeamDeathmatch", "gameBoost", "gameBoost");
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "kdratio", "assists");
}

// Namespace tdm
// Params 0, eflags: 0x0
// Checksum 0x5a508440, Offset: 0x5e0
// Size: 0x71
function onstartgametype() {
    setclientnamemode("auto_change");
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace tdm
// Params 1, eflags: 0x0
// Checksum 0x191407af, Offset: 0x8e8
// Size: 0x52
function onspawnplayer(predictedspawn) {
    self.usingobj = undefined;
    if (level.usestartspawns && !level.ingraceperiod && !level.playerqueuedrespawn) {
        level.usestartspawns = 0;
    }
    spawning::onspawnplayer(predictedspawn);
}

// Namespace tdm
// Params 1, eflags: 0x0
// Checksum 0x3777b7f, Offset: 0x948
// Size: 0x32
function onendgame(winningteam) {
    if (isdefined(winningteam) && isdefined(level.teams[winningteam])) {
        globallogic_score::giveteamscoreforobjective(winningteam, 1);
    }
}

// Namespace tdm
// Params 0, eflags: 0x0
// Checksum 0x674743cf, Offset: 0x988
// Size: 0x29
function onroundswitch() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace tdm
// Params 1, eflags: 0x0
// Checksum 0x1a9a2a02, Offset: 0xa18
// Size: 0xb6
function onroundendgame(roundwinner) {
    if (level.scoreroundwinbased) {
        var_947bc256 = level.teams;
        var_71be5dcc = firstarray(var_947bc256);
        if (isdefined(var_71be5dcc)) {
            team = var_947bc256[var_71be5dcc];
            var_aa87880b = nextarray(var_947bc256, var_71be5dcc);
            InvalidOpCode(0x54, "roundswon", team);
            // Unknown operator (0x54, t7_1b, PC)
        }
        winner = globallogic::determineteamwinnerbygamestat("roundswon");
    } else {
        winner = globallogic::determineteamwinnerbyteamscore();
    }
    return winner;
}

// Namespace tdm
// Params 0, eflags: 0x0
// Checksum 0x1fed37fe, Offset: 0xad8
// Size: 0x13b
function onscoreclosemusic() {
    teamscores = [];
    while (!level.gameended) {
        scorelimit = level.scorelimit;
        scorethreshold = scorelimit * 0.1;
        scorethresholdstart = abs(scorelimit - scorethreshold);
        scorelimitcheck = scorelimit - 10;
        topscore = 0;
        runnerupscore = 0;
        foreach (team in level.teams) {
            score = [[ level._getteamscore ]](team);
            if (score > topscore) {
                runnerupscore = topscore;
                topscore = score;
                continue;
            }
            if (score > runnerupscore) {
                runnerupscore = score;
            }
        }
        scoredif = topscore - runnerupscore;
        if (topscore >= scorelimit * 0.5) {
            level notify(#"sndmusichalfway");
            return;
        }
        wait 1;
    }
}

// Namespace tdm
// Params 9, eflags: 0x0
// Checksum 0xffdec19, Offset: 0xc20
// Size: 0x19a
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    thread dogtags::checkallowspectating();
    if (isdefined(level.droppedtagrespawn) && level.droppedtagrespawn) {
        should_spawn_tags = self dogtags::should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
        should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();
        if (should_spawn_tags) {
            level thread dogtags::spawn_dog_tag(self, attacker, &dogtags::onusedogtag, 0);
        }
    }
    if (isplayer(attacker) == 0 || attacker.team == self.team) {
        return;
    }
    if (isdefined(level.killstreaksgivegamescore) && (!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || level.killstreaksgivegamescore)) {
        attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
        self globallogic_score::giveteamscoreforobjective(self.team, level.teamscoreperdeath * -1);
        if (smeansofdeath == "MOD_HEAD_SHOT") {
            attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperheadshot);
        }
    }
}

