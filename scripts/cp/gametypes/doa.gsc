#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_callbacks;
#using scripts/cp/gametypes/_spawnlogic;
#using scripts/cp/gametypes/_spawning;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/cp/gametypes/_globallogic;
#using scripts/shared/ai/margwa;
#using scripts/shared/throttle_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/flag_shared;

#namespace doa;

// Namespace doa
// Params 0, eflags: 0x2
// Checksum 0x906f51fc, Offset: 0x350
// Size: 0x17c
function ignore_systems() {
    level.var_be177839 = "";
    system::ignore("cybercom");
    system::ignore("healthoverlay");
    system::ignore("challenges");
    system::ignore("rank");
    system::ignore("hacker_tool");
    system::ignore("grapple");
    system::ignore("replay_gun");
    system::ignore("riotshield");
    system::ignore("oed");
    system::ignore("explosive_bolt");
    system::ignore("empgrenade");
    system::ignore("spawning");
    system::ignore("save");
    system::ignore("hud_message");
    system::ignore("friendlyfire");
}

// Namespace doa
// Params 0, eflags: 0x1 linked
// Checksum 0x5fcc44bf, Offset: 0x4d8
// Size: 0x2d0
function main() {
    level.isdoa = 1;
    globallogic::init();
    level.gametype = tolower(getdvarstring("g_gametype"));
    util::registerroundswitch(0, 9);
    util::registertimelimit(0, 0);
    util::registerscorelimit(0, 0);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 0);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.scoreroundwinbased = 0;
    level.teamscoreperkill = 0;
    level.teamscoreperdeath = 0;
    level.teamscoreperheadshot = 0;
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    level.playermayspawn = &function_16220a9c;
    level.var_2b829c4e = &wait_to_spawn;
    level.var_8cc5e3c = 1;
    level.var_29d9f951 = 1;
    level.endgameonscorelimit = 0;
    level.endgameontimelimit = 0;
    level.ontimelimit = &globallogic::blank;
    level.onscorelimit = &globallogic::blank;
    level.onendgame = &onendgame;
    gameobjects::register_allowed_gameobject("coop");
    setscoreboardcolumns("kills", "gems", "skulls", "chickens", "deaths");
    if (!isdefined(level.gib_throttle)) {
        level.gib_throttle = new throttle();
    }
    [[ level.gib_throttle ]]->initialize(5, 0.2);
}

// Namespace doa
// Params 0, eflags: 0x1 linked
// Checksum 0x4677315d, Offset: 0x7b0
// Size: 0x208
function onstartgametype() {
    level.displayroundendtext = 0;
    setclientnamemode("auto_change");
    game["switchedsides"] = 0;
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    foreach (team in level.playerteams) {
        util::setobjectivetext(team, %OBJECTIVES_COOP);
        util::setobjectivehinttext(team, %OBJECTIVES_COOP_HINT);
        util::setobjectivescoretext(team, %OBJECTIVES_COOP);
        spawnlogic::add_spawn_points(team, "cp_coop_spawn");
        spawnlogic::add_spawn_points(team, "cp_coop_respawn");
    }
    spawning::updateallspawnpoints();
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level.zombie_use_zigzag_path = 1;
}

// Namespace doa
// Params 2, eflags: 0x1 linked
// Checksum 0xf9e97f2d, Offset: 0x9c0
// Size: 0x3c
function onspawnplayer(predictedspawn, question) {
    pixbeginevent("COOP:onSpawnPlayer");
    pixendevent();
}

// Namespace doa
// Params 1, eflags: 0x1 linked
// Checksum 0x497b97d5, Offset: 0xa08
// Size: 0x24
function onendgame(winningteam) {
    exitlevel(0);
}

// Namespace doa
// Params 9, eflags: 0x1 linked
// Checksum 0xa0ec98e8, Offset: 0xa38
// Size: 0x4c
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    
}

// Namespace doa
// Params 0, eflags: 0x1 linked
// Checksum 0x8dd79b36, Offset: 0xa90
// Size: 0x8
function wait_to_spawn() {
    return true;
}

// Namespace doa
// Params 0, eflags: 0x1 linked
// Checksum 0xb4b721c, Offset: 0xaa0
// Size: 0x8
function function_16220a9c() {
    return true;
}

