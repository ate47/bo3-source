#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace dm;

// Namespace dm
// Params 0, eflags: 0x0
// Checksum 0xd74e2d10, Offset: 0x2d8
// Size: 0x1e2
function main() {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 50000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 0, 0, 1440);
    level.scoreroundwinbased = getgametypesetting("cumulativeRoundScores") == 0;
    level.teamscoreperkill = getgametypesetting("teamScorePerKill");
    level.teamscoreperdeath = getgametypesetting("teamScorePerDeath");
    level.teamscoreperheadshot = getgametypesetting("teamScorePerHeadshot");
    level.killstreaksgivegamescore = getgametypesetting("killstreaksGiveGameScore");
    level.onstartgametype = &onstartgametype;
    level.onplayerkilled = &onplayerkilled;
    gameobjects::register_allowed_gameobject(level.gametype);
    globallogic_audio::set_leader_gametype_dialog("startFreeForAll", "hcStartFreeForAll", "gameBoost", "gameBoost");
    globallogic::setvisiblescoreboardcolumns("pointstowin", "kills", "deaths", "headshots", "score");
}

// Namespace dm
// Params 1, eflags: 0x0
// Checksum 0x3b854ac6, Offset: 0x4c8
// Size: 0xc2
function setupteam(team) {
    util::setobjectivetext(team, %OBJECTIVES_DM);
    if (level.splitscreen) {
        util::setobjectivescoretext(team, %OBJECTIVES_DM);
    } else {
        util::setobjectivescoretext(team, %OBJECTIVES_DM_SCORE);
    }
    util::setobjectivehinttext(team, %OBJECTIVES_DM_HINT);
    spawnlogic::add_spawn_points(team, "mp_dm_spawn");
    spawnlogic::place_spawn_points("mp_dm_spawn_start");
    level.spawn_start = spawnlogic::get_spawnpoint_array("mp_dm_spawn_start");
}

// Namespace dm
// Params 0, eflags: 0x0
// Checksum 0xfe099dc2, Offset: 0x598
// Size: 0x156
function onstartgametype() {
    setclientnamemode("auto_change");
    spawning::create_map_placed_influencers();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    foreach (team in level.teams) {
        setupteam(team);
    }
    spawning::updateallspawnpoints();
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level.displayroundendtext = 0;
    level thread onscoreclosemusic();
    if (!util::isoneround()) {
        level.displayroundendtext = 1;
    }
}

// Namespace dm
// Params 1, eflags: 0x0
// Checksum 0x127f119d, Offset: 0x6f8
// Size: 0x40
function onendgame(winningplayer) {
    if (isdefined(winningplayer) && isplayer(winningplayer)) {
        [[ level._setplayerscore ]](winningplayer, winningplayer [[ level._getplayerscore ]]() + 1);
    }
}

// Namespace dm
// Params 0, eflags: 0x0
// Checksum 0xf866eff0, Offset: 0x740
// Size: 0x89
function onscoreclosemusic() {
    while (!level.gameended) {
        scorelimit = level.scorelimit;
        scorethreshold = scorelimit * 0.9;
        for (i = 0; i < level.players.size; i++) {
            scorecheck = [[ level._getplayerscore ]](level.players[i]);
            if (scorecheck >= scorethreshold) {
                return;
            }
        }
        wait 0.5;
    }
}

// Namespace dm
// Params 9, eflags: 0x0
// Checksum 0x177e6910, Offset: 0x7d8
// Size: 0xb2
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (!isplayer(attacker) || self == attacker) {
        return;
    }
    attacker globallogic_score::givepointstowin(level.teamscoreperkill);
    self globallogic_score::givepointstowin(level.teamscoreperdeath * -1);
    if (smeansofdeath == "MOD_HEAD_SHOT") {
        attacker globallogic_score::givepointstowin(level.teamscoreperheadshot);
    }
}

