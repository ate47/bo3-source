#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/math_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/util_shared;

#namespace bwars;

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x93faa7e1, Offset: 0x8a8
// Size: 0x199
function main() {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 1000);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registerroundswitch(0, 9);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.scoreroundwinbased = getgametypesetting("cumulativeRoundScores") == 0;
    level.teambased = 0;
    level.overrideteamscore = 1;
    level.overrideplayerscore = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerkilled = &onplayerkilled;
    level.onroundswitch = &onroundswitch;
    level.onprecachegametype = &onprecachegametype;
    level.onendgame = &onendgame;
    level.onroundendgame = &onroundendgame;
    gameobjects::register_allowed_gameobject("dom");
    InvalidOpCode(0xc8, "dialog", "gametype", "dom_start");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xae8
// Size: 0x2
function onprecachegametype() {
    
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x6347453d, Offset: 0xaf8
// Size: 0x69
function onstartgametype() {
    util::setobjectivetext("allies", %OBJECTIVES_DOM);
    util::setobjectivetext("axis", %OBJECTIVES_DOM);
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace bwars
// Params 1, eflags: 0x0
// Checksum 0x262ede7b, Offset: 0xec0
// Size: 0xa
function onendgame(winningteam) {
    
}

// Namespace bwars
// Params 1, eflags: 0x0
// Checksum 0x38b9593f, Offset: 0xed8
// Size: 0xd2
function onroundendgame(roundwinner) {
    if (level.scoreroundwinbased) {
        InvalidOpCode(0x54, "roundswon", "allies");
        // Unknown operator (0x54, t7_1b, PC)
    }
    axisscore = [[ level._getteamscore ]]("axis");
    alliedscore = [[ level._getteamscore ]]("allies");
    if (axisscore == alliedscore) {
        winner = "tie";
    } else if (axisscore > alliedscore) {
        winner = "axis";
    } else {
        winner = "allies";
    }
    return winner;
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x9d439c86, Offset: 0xfb8
// Size: 0x13a
function updategametypedvars() {
    level.flagcapturetime = getgametypesetting("captureTime");
    level.flagcapturelpm = math::clamp(getdvarfloat("maxFlagCapturePerMinute", 3), 0, 10);
    level.playercapturelpm = math::clamp(getdvarfloat("maxPlayerCapturePerMinute", 2), 0, 10);
    level.var_4eebac3e = math::clamp(getdvarfloat("maxPlayerCapture", 1000), 0, 1000);
    level.playeroffensivemax = math::clamp(getdvarfloat("maxPlayerOffensive", 16), 0, 1000);
    level.playerdefensivemax = math::clamp(getdvarfloat("maxPlayerDefensive", 16), 0, 1000);
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x1bcce1f2, Offset: 0x1100
// Size: 0x223
function function_939abef1() {
    level.laststatus["allies"] = 0;
    level.laststatus["axis"] = 0;
    triggers = getentarray("flag_primary", "targetname");
    if (!triggers.size) {
        println("^1Not enough domination flags found in level!");
        callback::abort_level();
        return;
    }
    level.var_3370843c = [];
    foreach (trigger in triggers) {
        visuals = trigger function_87913bae();
        flag = gameobjects::create_use_object("neutral", trigger, visuals, (0, 0, 100));
        objective_delete(flag.var_16caaa11);
        gameobjects::release_obj_id(flag.var_16caaa11);
        flag gameobjects::allow_use("any");
        flag gameobjects::set_use_time(level.flagcapturetime);
        flag gameobjects::set_use_text(%MP_CAPTURING_FLAG);
        flag gameobjects::set_visible_team("any");
        flag function_19f9690f();
        flag.onuse = &onuse;
        flag.onbeginuse = &onbeginuse;
        flag.onuseupdate = &onuseupdate;
        flag.onenduse = &onenduse;
        level.var_3370843c[level.var_3370843c.size] = flag;
    }
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0xd02256bb, Offset: 0x1330
// Size: 0x1f2
function function_304a31e9() {
    if (isdefined(self.var_5b67e08a)) {
        return;
    }
    self.var_5b67e08a = [];
    x = -40;
    y = 300;
    for (i = 0; i < 4; i++) {
        hud = newclienthudelem(self);
        hud.alignx = "left";
        hud.aligny = "middle";
        hud.foreground = 1;
        hud.fontscale = 1.5;
        hud.alpha = 0.8;
        hud.x = x;
        hud.y = y;
        hud.hidewhendead = 1;
        hud.hidewheninkillcam = 1;
        hud.score = newclienthudelem(self);
        hud.score.alignx = "left";
        hud.score.aligny = "middle";
        hud.score.foreground = 1;
        hud.score.fontscale = 1.5;
        hud.score.alpha = 0.8;
        hud.score.x = x + 125;
        hud.score.y = y;
        hud.score.hidewhendead = 1;
        hud.score.hidewheninkillcam = 1;
        self.var_5b67e08a[self.var_5b67e08a.size] = hud;
        y += 15;
    }
    level function_9e73b90f();
}

// Namespace bwars
// Params 2, eflags: 0x0
// Checksum 0x3ee7ca46, Offset: 0x1530
// Size: 0x13d
function function_9e006c7c(names, scores) {
    if (!isdefined(self.var_5b67e08a)) {
        return;
    }
    for (i = 0; i < 4; i++) {
        self.var_5b67e08a[i] settext(names[i]);
        if (names[i] == "") {
            self.var_5b67e08a[i].score settext("");
        } else {
            self.var_5b67e08a[i].score setvalue(scores[i]);
        }
        if (names[i] == self.name) {
            self.var_5b67e08a[i].color = (1, 0.84, 0);
            self.var_5b67e08a[i].score.color = (1, 0.84, 0);
            continue;
        }
        self.var_5b67e08a[i].color = (1, 1, 1);
        self.var_5b67e08a[i].score.color = (1, 1, 1);
    }
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x756f58c, Offset: 0x1678
// Size: 0xa5
function function_737e5200() {
    players = getplayers();
    while (true) {
        swapped = 0;
        for (i = 1; i < players.size; i++) {
            if (players[i - 1].score < players[i].score) {
                t = players[i - 1];
                players[i - 1] = players[i];
                players[i] = t;
                swapped = 1;
            }
        }
        if (!swapped) {
            break;
        }
    }
    return players;
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x1c82f0af, Offset: 0x1728
// Size: 0xfb
function function_9e73b90f() {
    names = [];
    scores = [];
    players = function_737e5200();
    for (i = 0; i < 4; i++) {
        if (players.size > i) {
            names[i] = players[i].name;
            scores[i] = players[i].score;
            continue;
        }
        names[i] = "";
        scores[i] = -1;
    }
    foreach (player in players) {
        player function_9e006c7c(names, scores);
    }
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x9df6b2ba, Offset: 0x1830
// Size: 0xd4
function function_87913bae() {
    visuals = [];
    visuals[0] = spawn("script_model", self.origin);
    visuals[0].angles = self.angles;
    visuals[0] setmodel("p7_mp_flag_neutral");
    visuals[0] setinvisibletoall();
    visuals[1] = spawn("script_model", self.origin);
    visuals[1].angles = self.angles;
    visuals[1] setmodel("p7_mp_flag_neutral");
    visuals[1] setvisibletoall();
    return visuals;
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x14025c44, Offset: 0x1910
// Size: 0xba
function function_883cf02b() {
    owner = self gameobjects::get_owner_team();
    self.visuals[0] setmodel("p7_mp_flag_allies");
    self.visuals[0] setinvisibletoall();
    self.visuals[0] setvisibletoplayer(owner);
    self.visuals[1] setmodel("p7_mp_flag_axis");
    self.visuals[1] setvisibletoall();
    self.visuals[1] setinvisibletoplayer(owner);
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0xb95d04f6, Offset: 0x19d8
// Size: 0x112
function function_19f9690f() {
    self.var_1dfbc270 = [];
    self.var_1dfbc270[0] = gameobjects::get_next_obj_id();
    self.var_1dfbc270[1] = gameobjects::get_next_obj_id();
    label = self gameobjects::get_label();
    objective_add(self.var_1dfbc270[0], "active", self.curorigin);
    objective_icon(self.var_1dfbc270[0], "compass_waypoint_defend" + label);
    objective_setinvisibletoall(self.var_1dfbc270[0]);
    objective_add(self.var_1dfbc270[1], "active", self.curorigin);
    objective_icon(self.var_1dfbc270[1], "compass_waypoint_captureneutral" + label);
    objective_setvisibletoall(self.var_1dfbc270[1]);
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0xc48e12fc, Offset: 0x1af8
// Size: 0x11a
function function_a2f26c3e() {
    label = self gameobjects::get_label();
    owner = self gameobjects::get_owner_team();
    objective_icon(self.var_1dfbc270[0], "compass_waypoint_defend" + label);
    objective_state(self.var_1dfbc270[0], "active");
    objective_setinvisibletoall(self.var_1dfbc270[0]);
    objective_setvisibletoplayer(self.var_1dfbc270[0], owner);
    objective_icon(self.var_1dfbc270[1], "compass_waypoint_capture" + label);
    objective_state(self.var_1dfbc270[1], "active");
    objective_setvisibletoall(self.var_1dfbc270[1]);
    objective_setinvisibletoplayer(self.var_1dfbc270[1], owner);
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0xf7ee3b41, Offset: 0x1c20
// Size: 0x11a
function function_511eecf6() {
    if (isdefined(self.var_c019f8d3)) {
        return;
    }
    self.var_c019f8d3 = [];
    foreach (flag in level.var_3370843c) {
        icon = newclienthudelem(self);
        icon.flag = flag;
        icon.x = flag.curorigin[0];
        icon.y = flag.curorigin[1];
        icon.z = flag.curorigin[2] + 100;
        icon.fadewhentargeted = 1;
        icon.archived = 0;
        icon.alpha = 1;
        self.var_c019f8d3[self.var_c019f8d3.size] = icon;
    }
    self function_305f9c23();
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x602ea077, Offset: 0x1d48
// Size: 0x133
function function_305f9c23() {
    assert(isdefined(self.var_c019f8d3));
    foreach (icon in self.var_c019f8d3) {
        label = icon.flag gameobjects::get_label();
        owner = icon.flag gameobjects::get_owner_team();
        if (isstring(owner) && owner == "neutral") {
            icon setwaypoint(1, "waypoint_captureneutral" + label);
            continue;
        }
        if (owner == self) {
            icon setwaypoint(1, "waypoint_defend" + label);
            continue;
        }
        icon setwaypoint(1, "waypoint_capture" + label);
    }
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x958eeb06, Offset: 0x1e88
// Size: 0x7b
function function_f8f29c0f() {
    players = getplayers();
    foreach (player in players) {
        player function_305f9c23();
    }
}

// Namespace bwars
// Params 2, eflags: 0x0
// Checksum 0xecf57057, Offset: 0x1f10
// Size: 0xd5
function getunownedflagneareststart(team, excludeflag) {
    best = undefined;
    bestdistsq = undefined;
    for (i = 0; i < level.flags.size; i++) {
        flag = level.flags[i];
        if (flag getflagteam() != "neutral") {
            continue;
        }
        distsq = distancesquared(flag.origin, level.startpos[team]);
        if (!isdefined(best) || (!isdefined(excludeflag) || flag != excludeflag) && distsq < bestdistsq) {
            bestdistsq = distsq;
            best = flag;
        }
    }
    return best;
}

// Namespace bwars
// Params 1, eflags: 0x0
// Checksum 0x1ff592f, Offset: 0x1ff0
// Size: 0xa
function onbeginuse(player) {
    
}

// Namespace bwars
// Params 3, eflags: 0x0
// Checksum 0x4dbd8de1, Offset: 0x2008
// Size: 0x1a
function onuseupdate(team, progress, change) {
    
}

// Namespace bwars
// Params 2, eflags: 0x0
// Checksum 0x49983ac0, Offset: 0x2030
// Size: 0x57
function statusdialog(dialog, team) {
    time = gettime();
    if (gettime() < level.laststatus[team] + 6000) {
        return;
    }
    thread delayedleaderdialog(dialog, team);
    level.laststatus[team] = gettime();
}

// Namespace bwars
// Params 2, eflags: 0x0
// Checksum 0xc961c079, Offset: 0x2090
// Size: 0x83
function function_8d587529(dialog, friend_team) {
    foreach (team in level.teams) {
        if (team == friend_team) {
            continue;
        }
        statusdialog(dialog, team);
    }
}

// Namespace bwars
// Params 3, eflags: 0x0
// Checksum 0x1a7e9e3e, Offset: 0x2120
// Size: 0x1a
function onenduse(team, player, success) {
    
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x2148
// Size: 0x2
function function_b7ddf8ec() {
    
}

// Namespace bwars
// Params 1, eflags: 0x0
// Checksum 0x6a182e9, Offset: 0x2158
// Size: 0x72
function onuse(player) {
    self gameobjects::set_owner_team(player);
    self gameobjects::allow_use("enemy");
    self function_a2f26c3e();
    self function_883cf02b();
    level function_f8f29c0f();
    level function_4b7c2b41();
}

// Namespace bwars
// Params 2, eflags: 0x0
// Checksum 0x705519db, Offset: 0x21d8
// Size: 0x139
function give_capture_credit(touchlist, string) {
    wait 0.05;
    util::waittillslowprocessallowed();
    self updatecapsperminute();
    players = getarraykeys(touchlist);
    for (i = 0; i < players.size; i++) {
        player_from_touchlist = touchlist[players[i]].player;
        player_from_touchlist updatecapsperminute();
        if (!isscoreboosting(player_from_touchlist, self)) {
            if (isdefined(player_from_touchlist.pers["captures"])) {
                player_from_touchlist.pers["captures"]++;
                player_from_touchlist.captures = player_from_touchlist.pers["captures"];
            }
            demo::bookmark("event", gettime(), player_from_touchlist);
            player_from_touchlist addplayerstatwithgametype("CAPTURES", 1);
        }
        level thread popups::displayteammessagetoall(string, player_from_touchlist);
    }
}

// Namespace bwars
// Params 2, eflags: 0x0
// Checksum 0x93b9a7f7, Offset: 0x2320
// Size: 0x3a
function delayedleaderdialog(sound, team) {
    wait 0.1;
    util::waittillslowprocessallowed();
    globallogic_audio::leader_dialog(sound, team);
}

// Namespace bwars
// Params 4, eflags: 0x0
// Checksum 0x4818e780, Offset: 0x2368
// Size: 0x3a
function function_62d9d3db(var_d8fca5f, team1, var_9b885b24, team2) {
    wait 0.1;
    util::waittillslowprocessallowed();
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x474fe07b, Offset: 0x23b0
// Size: 0x145
function function_f6f610c2() {
    while (!level.gameended) {
        foreach (flag in level.var_3370843c) {
            owner = flag gameobjects::get_owner_team();
            if (isplayer(owner)) {
                owner.score += 1;
            }
        }
        level function_9e73b90f();
        players = getplayers();
        foreach (player in players) {
            player globallogic::checkscorelimit();
        }
        wait 5;
        hostmigration::waittillhostmigrationdone();
    }
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x8f599b38, Offset: 0x2500
// Size: 0x9
function onroundswitch() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace bwars
// Params 9, eflags: 0x0
// Checksum 0xd64ccb0b, Offset: 0x2580
// Size: 0x4a
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    
}

// Namespace bwars
// Params 1, eflags: 0x0
// Checksum 0x70c75a6e, Offset: 0x25d8
// Size: 0x5b
function getteamflagcount(team) {
    score = 0;
    for (i = 0; i < level.flags.size; i++) {
        if (level.domflags[i] gameobjects::get_owner_team() == team) {
            score++;
        }
    }
    return score;
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x4f32807e, Offset: 0x2640
// Size: 0x19
function getflagteam() {
    return self.useobj gameobjects::get_owner_team();
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x675f57b4, Offset: 0x2668
// Size: 0xb7
function getboundaryflags() {
    bflags = [];
    for (i = 0; i < level.flags.size; i++) {
        for (j = 0; j < level.flags[i].adjflags.size; j++) {
            if (level.flags[i].useobj gameobjects::get_owner_team() != level.flags[i].adjflags[j].useobj gameobjects::get_owner_team()) {
                bflags[bflags.size] = level.flags[i];
                break;
            }
        }
    }
    return bflags;
}

// Namespace bwars
// Params 1, eflags: 0x0
// Checksum 0x3b39b248, Offset: 0x2728
// Size: 0xa7
function getboundaryflagspawns(team) {
    spawns = [];
    bflags = getboundaryflags();
    for (i = 0; i < bflags.size; i++) {
        if (isdefined(team) && bflags[i] getflagteam() != team) {
            continue;
        }
        for (j = 0; j < bflags[i].nearbyspawns.size; j++) {
            spawns[spawns.size] = bflags[i].nearbyspawns[j];
        }
    }
    return spawns;
}

// Namespace bwars
// Params 1, eflags: 0x0
// Checksum 0xaa5272e4, Offset: 0x27d8
// Size: 0xdb
function getspawnsboundingflag(avoidflag) {
    spawns = [];
    for (i = 0; i < level.flags.size; i++) {
        flag = level.flags[i];
        if (flag == avoidflag) {
            continue;
        }
        isbounding = 0;
        for (j = 0; j < flag.adjflags.size; j++) {
            if (flag.adjflags[j] == avoidflag) {
                isbounding = 1;
                break;
            }
        }
        if (!isbounding) {
            continue;
        }
        for (j = 0; j < flag.nearbyspawns.size; j++) {
            spawns[spawns.size] = flag.nearbyspawns[j];
        }
    }
    return spawns;
}

// Namespace bwars
// Params 1, eflags: 0x0
// Checksum 0x4573bfb5, Offset: 0x28c0
// Size: 0x12d
function getownedandboundingflagspawns(team) {
    spawns = [];
    for (i = 0; i < level.flags.size; i++) {
        if (level.flags[i] getflagteam() == team) {
            for (s = 0; s < level.flags[i].nearbyspawns.size; s++) {
                spawns[spawns.size] = level.flags[i].nearbyspawns[s];
            }
            continue;
        }
        for (j = 0; j < level.flags[i].adjflags.size; j++) {
            if (level.flags[i].adjflags[j] getflagteam() == team) {
                for (s = 0; s < level.flags[i].nearbyspawns.size; s++) {
                    spawns[spawns.size] = level.flags[i].nearbyspawns[s];
                }
                break;
            }
        }
    }
    return spawns;
}

// Namespace bwars
// Params 1, eflags: 0x0
// Checksum 0xd20ffcda, Offset: 0x29f8
// Size: 0x9b
function getownedflagspawns(team) {
    spawns = [];
    for (i = 0; i < level.flags.size; i++) {
        if (level.flags[i] getflagteam() == team) {
            for (s = 0; s < level.flags[i].nearbyspawns.size; s++) {
                spawns[spawns.size] = level.flags[i].nearbyspawns[s];
            }
        }
    }
    return spawns;
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x8c7a410, Offset: 0x2aa0
// Size: 0x4ab
function flagsetup() {
    maperrors = [];
    descriptorsbylinkname = [];
    descriptors = getentarray("flag_descriptor", "targetname");
    flags = level.flags;
    for (i = 0; i < level.domflags.size; i++) {
        closestdist = undefined;
        closestdesc = undefined;
        for (j = 0; j < descriptors.size; j++) {
            dist = distance(flags[i].origin, descriptors[j].origin);
            if (!isdefined(closestdist) || dist < closestdist) {
                closestdist = dist;
                closestdesc = descriptors[j];
            }
        }
        if (!isdefined(closestdesc)) {
            maperrors[maperrors.size] = "there is no flag_descriptor in the map! see explanation in dom.gsc";
            break;
        }
        if (isdefined(closestdesc.flag)) {
            maperrors[maperrors.size] = "flag_descriptor with script_linkname \"" + closestdesc.script_linkname + "\" is nearby more than one flag; is there a unique descriptor near each flag?";
            continue;
        }
        flags[i].descriptor = closestdesc;
        closestdesc.flag = flags[i];
        descriptorsbylinkname[closestdesc.script_linkname] = closestdesc;
    }
    if (maperrors.size == 0) {
        for (i = 0; i < flags.size; i++) {
            if (isdefined(flags[i].descriptor.script_linkto)) {
                adjdescs = strtok(flags[i].descriptor.script_linkto, " ");
            } else {
                adjdescs = [];
            }
            for (j = 0; j < adjdescs.size; j++) {
                otherdesc = descriptorsbylinkname[adjdescs[j]];
                if (!isdefined(otherdesc) || otherdesc.targetname != "flag_descriptor") {
                    maperrors[maperrors.size] = "flag_descriptor with script_linkname \"" + flags[i].descriptor.script_linkname + "\" linked to \"" + adjdescs[j] + "\" which does not exist as a script_linkname of any other entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)";
                    continue;
                }
                adjflag = otherdesc.flag;
                if (adjflag == flags[i]) {
                    maperrors[maperrors.size] = "flag_descriptor with script_linkname \"" + flags[i].descriptor.script_linkname + "\" linked to itself";
                    continue;
                }
                flags[i].adjflags[flags[i].adjflags.size] = adjflag;
            }
        }
    }
    spawnpoints = spawnlogic::get_spawnpoint_array("mp_dom_spawn");
    for (i = 0; i < spawnpoints.size; i++) {
        if (isdefined(spawnpoints[i].script_linkto)) {
            desc = descriptorsbylinkname[spawnpoints[i].script_linkto];
            if (!isdefined(desc) || desc.targetname != "flag_descriptor") {
                maperrors[maperrors.size] = "Spawnpoint at " + spawnpoints[i].origin + "\" linked to \"" + spawnpoints[i].script_linkto + "\" which does not exist as a script_linkname of any entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)";
                continue;
            }
            nearestflag = desc.flag;
        } else {
            nearestflag = undefined;
            nearestdist = undefined;
            for (j = 0; j < flags.size; j++) {
                dist = distancesquared(flags[j].origin, spawnpoints[i].origin);
                if (!isdefined(nearestflag) || dist < nearestdist) {
                    nearestflag = flags[j];
                    nearestdist = dist;
                }
            }
        }
        nearestflag.nearbyspawns[nearestflag.nearbyspawns.size] = spawnpoints[i];
    }
    if (maperrors.size > 0) {
        /#
            println("<dev string:x28>");
            for (i = 0; i < maperrors.size; i++) {
                println(maperrors[i]);
            }
            println("<dev string:x4f>");
            util::error("<dev string:x76>");
        #/
        callback::abort_level();
        return;
    }
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x2d1ddde5, Offset: 0x2f58
// Size: 0xf2
function createflagspawninfluencers() {
    ss = level.spawnsystem;
    for (flag_index = 0; flag_index < level.flags.size; flag_index++) {
        if (level.domflags[flag_index] == self) {
            break;
        }
    }
    self.owned_flag_influencer = self spawning::create_influencer("dom_friendly", self.trigger.origin, 0);
    self.neutral_flag_influencer = self spawning::create_influencer("dom_neutral", self.trigger.origin, 0);
    self.enemy_flag_influencer = self spawning::create_influencer("dom_enemy", self.trigger.origin, 0);
    self update_spawn_influencers("neutral");
}

// Namespace bwars
// Params 1, eflags: 0x0
// Checksum 0xc7cd9964, Offset: 0x3058
// Size: 0x13a
function update_spawn_influencers(team) {
    assert(isdefined(self.neutral_flag_influencer));
    assert(isdefined(self.owned_flag_influencer));
    assert(isdefined(self.enemy_flag_influencer));
    if (team == "neutral") {
        enableinfluencer(self.neutral_flag_influencer, 1);
        enableinfluencer(self.owned_flag_influencer, 0);
        enableinfluencer(self.enemy_flag_influencer, 0);
        return;
    }
    enableinfluencer(self.neutral_flag_influencer, 0);
    enableinfluencer(self.owned_flag_influencer, 1);
    enableinfluencer(self.enemy_flag_influencer, 1);
    setinfluencerteammask(self.owned_flag_influencer, util::getteammask(team));
    setinfluencerteammask(self.enemy_flag_influencer, util::getotherteamsmask(team));
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x9d54e474, Offset: 0x31a0
// Size: 0x62
function function_4b7c2b41() {
    spawnlogic::clear_spawn_points();
    spawnlogic::add_spawn_points("axis", "mp_dom_spawn");
    spawnlogic::add_spawn_points("allies", "mp_dom_spawn");
    spawning::updateallspawnpoints();
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x61722218, Offset: 0x3210
// Size: 0xa7
function dominated_challenge_check() {
    num_flags = level.flags.size;
    allied_flags = 0;
    axis_flags = 0;
    for (i = 0; i < num_flags; i++) {
        flag_team = level.flags[i] getflagteam();
        if (flag_team == "allies") {
            allied_flags++;
        } else if (flag_team == "axis") {
            axis_flags++;
        } else {
            return false;
        }
        if (allied_flags > 0 && axis_flags > 0) {
            return false;
        }
    }
    return true;
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0x2e1b2c4b, Offset: 0x32c0
// Size: 0xa1
function dominated_check() {
    num_flags = level.flags.size;
    allied_flags = 0;
    axis_flags = 0;
    for (i = 0; i < num_flags; i++) {
        flag_team = level.flags[i] getflagteam();
        if (flag_team == "allies") {
            allied_flags++;
        } else if (flag_team == "axis") {
            axis_flags++;
        }
        if (allied_flags > 0 && axis_flags > 0) {
            return false;
        }
    }
    return true;
}

// Namespace bwars
// Params 0, eflags: 0x0
// Checksum 0xd7308e4f, Offset: 0x3370
// Size: 0xb2
function updatecapsperminute() {
    if (!isdefined(self.capsperminute)) {
        self.numcaps = 0;
        self.capsperminute = 0;
    }
    self.numcaps++;
    minutespassed = globallogic_utils::gettimepassed() / 60000;
    if (isplayer(self) && isdefined(self.timeplayed["total"])) {
        minutespassed = self.timeplayed["total"] / 60;
    }
    self.capsperminute = self.numcaps / minutespassed;
    if (self.capsperminute > self.numcaps) {
        self.capsperminute = self.numcaps;
    }
}

// Namespace bwars
// Params 2, eflags: 0x0
// Checksum 0x65fc8533, Offset: 0x3430
// Size: 0x69
function isscoreboosting(player, flag) {
    if (!level.rankedmatch) {
        return false;
    }
    if (player.capsperminute > level.playercapturelpm) {
        return true;
    }
    if (flag.capsperminute > level.flagcapturelpm) {
        return true;
    }
    if (player.numcaps > level.var_4eebac3e) {
        return true;
    }
    return false;
}

