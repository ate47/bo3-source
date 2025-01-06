#using scripts/mp/_armor;
#using scripts/mp/_challenges;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_defaults;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_hud_message;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/teams/_teams;
#using scripts/shared/_oob;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace ball;

// Namespace ball
// Params 0, eflags: 0x2
// Checksum 0xc1c1d955, Offset: 0xce0
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("ball", &__init__, undefined, undefined);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xb8eb950c, Offset: 0xd18
// Size: 0xca
function __init__() {
    clientfield::register("allplayers", "ballcarrier", 1, 1, "int");
    clientfield::register("allplayers", "passoption", 1, 1, "int");
    clientfield::register("world", "ball_home", 1, 1, "int");
    clientfield::register("world", "ball_score_allies", 1, 1, "int");
    clientfield::register("world", "ball_score_axis", 1, 1, "int");
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xe86a0412, Offset: 0xdf0
// Size: 0x402
function main() {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerroundlimit(0, 10);
    util::registerroundwinlimit(0, 10);
    util::registerroundswitch(0, 9);
    util::registernumlives(0, 100);
    util::registerroundscorelimit(0, 5000);
    util::registerscorelimit(0, 5000);
    level.scoreroundwinbased = getgametypesetting("cumulativeRoundScores") == 0;
    level.teamkillpenaltymultiplier = getgametypesetting("teamKillPenalty");
    level.teamkillscoremultiplier = getgametypesetting("teamKillScore");
    level.var_aa5bcaa3 = getgametypesetting("objectivePingTime");
    level.carryscore = getgametypesetting("carryScore");
    level.throwscore = getgametypesetting("throwScore");
    level.var_ef3abf3b = getgametypesetting("carrierArmor");
    level.ballcount = getgametypesetting("ballCount");
    level.enemycarriervisible = getgametypesetting("enemyCarrierVisible");
    level.idleflagreturntime = getgametypesetting("idleFlagResetTime");
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.clampscorelimit = 0;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    level.onroundswitch = &onroundswitch;
    level.onendgame = &onendgame;
    level.onroundendgame = &onroundendgame;
    level.getteamkillpenalty = &function_54dd76af;
    level.getteamkillscore = &function_eb6c9496;
    level.var_d6911678 = &function_d6911678;
    level.shouldplayovertimeround = &shouldplayovertimeround;
    gameobjects::register_allowed_gameobject(level.gametype);
    globallogic_audio::set_leader_gametype_dialog("startUplink", "hcStartUplink", "uplOrders", "uplOrders");
    if (!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen()) {
        globallogic::setvisiblescoreboardcolumns("score", "kills", "carries", "throws", "deaths");
        return;
    }
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "carries", "throws");
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x1c9c90cd, Offset: 0x1200
// Size: 0x19
function onprecachegametype() {
    InvalidOpCode(0xc8, "strings", "score_limit_reached", %MP_CAP_LIMIT_REACHED);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xd8a6977a, Offset: 0x1228
// Size: 0x79
function onstartgametype() {
    level.usestartspawns = 1;
    level.var_d566bdba = getweapon("ball_world");
    level.var_aff3334d = getweapon("ball_world_pass");
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x1aa00d95, Offset: 0x1840
// Size: 0x111
function function_972a6af9() {
    winner = undefined;
    if (level.teambased) {
        var_87bb3477 = level.teams;
        var_f6095d41 = firstarray(var_87bb3477);
        if (isdefined(var_f6095d41)) {
            team = var_87bb3477[var_f6095d41];
            var_4728d7aa = nextarray(var_87bb3477, var_f6095d41);
            InvalidOpCode(0x54, "teamSuddenDeath", team);
            // Unknown operator (0x54, t7_1b, PC)
        }
        if (!isdefined(winner)) {
            winner = globallogic::determineteamwinnerbygamestat("teamScores");
        }
        globallogic_utils::logteamwinstring("time limit", winner);
    } else {
        winner = globallogic_score::gethighestscoringplayer();
        /#
            if (isdefined(winner)) {
                print("<dev string:x28>" + winner.name);
            } else {
                print("<dev string:x3a>");
            }
        #/
    }
    InvalidOpCode(0x54, "strings", "time_limit_reached");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x96de4520, Offset: 0x1998
// Size: 0x52
function onspawnplayer(predictedspawn) {
    self.var_1821be2 = 0;
    self.var_bbc60d50 = undefined;
    self clientfield::set("ctf_flag_carrier", 0);
    self thread function_67cb1206();
    spawning::onspawnplayer(predictedspawn);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x1f0e4a59, Offset: 0x19f8
// Size: 0xd5
function function_67cb1206() {
    self endon(#"death");
    self endon(#"delete");
    player = self;
    ball = getweapon("ball");
    while (true) {
        if (isdefined(ball) && player hasweapon(ball)) {
            curweapon = player getcurrentweapon();
            if (isdefined(curweapon) && curweapon != ball && !curweapon.isheroweapon) {
                player switchtoweaponimmediate(ball);
                player disableweaponcycling();
                player disableoffhandweapons();
            }
        }
        wait 0.05;
    }
}

// Namespace ball
// Params 9, eflags: 0x0
// Checksum 0x56ab9c20, Offset: 0x1ad8
// Size: 0x1ba
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isdefined(self.carryobject)) {
        otherteam = util::getotherteam(self.team);
        self recordgameevent("return");
        if (isdefined(attacker) && isplayer(attacker) && attacker != self) {
            attacker recordgameevent("kill_carrier");
            scoreevents::processscoreevent("kill_ball_carrier", attacker, undefined, weapon);
            globallogic_audio::leader_dialog("uplWeDrop", self.team, undefined, "uplink_ball");
            globallogic_audio::leader_dialog("uplTheyDrop", otherteam, undefined, "uplink_ball");
            globallogic_audio::play_2d_on_team("mpl_balldrop_sting_friend", self.team);
            globallogic_audio::play_2d_on_team("mpl_balldrop_sting_enemy", otherteam);
            level thread popups::displayteammessagetoteam(%MP_BALL_DROPPED, self, self.team);
            level thread popups::displayteammessagetoteam(%MP_BALL_DROPPED, self, otherteam);
        }
        return;
    }
    if (isdefined(attacker.carryobject)) {
        scoreevents::processscoreevent("kill_enemy_while_carrying_ball", attacker, undefined, weapon);
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x15616740, Offset: 0x1ca0
// Size: 0x9
function onroundswitch() {
    InvalidOpCode(0x54, "switchedsides");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xb289acf4, Offset: 0x1ce0
// Size: 0x11
function onendgame(winningteam) {
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xc3ca9678, Offset: 0x1da0
// Size: 0x75
function updateteamscorebyroundswon() {
    if (level.scoreroundwinbased) {
        var_b9daa98a = level.teams;
        var_8fa548d0 = firstarray(var_b9daa98a);
        if (isdefined(var_8fa548d0)) {
            team = var_b9daa98a[var_8fa548d0];
            var_ed00ea37 = nextarray(var_b9daa98a, var_8fa548d0);
            InvalidOpCode(0x54, "roundswon", team);
            // Unknown operator (0x54, t7_1b, PC)
        }
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x8ba28c73, Offset: 0x1e20
// Size: 0x69
function onroundendgame(winningteam) {
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x2e40db48, Offset: 0x2090
// Size: 0x1a
function function_d6911678() {
    self settext(%);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xf44ea82b, Offset: 0x20b8
// Size: 0x19
function shouldplayovertimeround() {
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ball
// Params 4, eflags: 0x0
// Checksum 0x14a43c9d, Offset: 0x21f0
// Size: 0x67
function function_54dd76af(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_penalty = globallogic_defaults::default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon);
    if (isdefined(self.var_1821be2) && self.var_1821be2) {
        teamkill_penalty *= level.teamkillpenaltymultiplier;
    }
    return teamkill_penalty;
}

// Namespace ball
// Params 4, eflags: 0x0
// Checksum 0xc2ff238a, Offset: 0x2260
// Size: 0x79
function function_eb6c9496(einflictor, attacker, smeansofdeath, weapon) {
    teamkill_score = rank::getscoreinfovalue("kill");
    if (isdefined(self.var_1821be2) && self.var_1821be2) {
        teamkill_score *= level.teamkillscoremultiplier;
    }
    return int(teamkill_score);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x5cbbc430, Offset: 0x22e8
// Size: 0x193
function setup_objectives() {
    level.ball_goals = [];
    level.ball_starts = [];
    level.balls = [];
    level.ball_starts = getentarray("ball_start", "targetname");
    foreach (ball_start in level.ball_starts) {
        level.balls[level.balls.size] = function_dbf94d16(ball_start);
    }
    var_172eabf9 = level.teams;
    var_b60a8d4f = firstarray(var_172eabf9);
    if (isdefined(var_b60a8d4f)) {
        team = var_172eabf9[var_b60a8d4f];
        var_ec0283e4 = nextarray(var_172eabf9, var_b60a8d4f);
        InvalidOpCode(0x54, "switchedsides");
        // Unknown operator (0x54, t7_1b, PC)
    }
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0xfcfffb44, Offset: 0x2488
// Size: 0x14c
function function_b22de10a(trigger, team) {
    useobj = gameobjects::create_use_object(team, trigger, [], (0, 0, trigger.height * 0.5), istring("ball_goal_" + team));
    useobj gameobjects::set_visible_team("any");
    useobj gameobjects::set_model_visibility(1);
    useobj gameobjects::allow_use("enemy");
    useobj gameobjects::set_use_time(0);
    useobj gameobjects::set_key_object(level.balls[0]);
    useobj.var_cd77875d = &function_ce3bd9c9;
    useobj.onuse = &function_3d1ee3cc;
    useobj.ball_in_goal = 0;
    useobj.radiussq = trigger.radius * trigger.radius;
    useobj.center = trigger.origin + (0, 0, trigger.height * 0.5);
    return useobj;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xc0b84021, Offset: 0x25e0
// Size: 0x12
function function_ce3bd9c9(player) {
    return !self.ball_in_goal;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x64b637df, Offset: 0x2600
// Size: 0x2ba
function function_3d1ee3cc(player) {
    if (!isdefined(player) || !isdefined(player.carryobject)) {
        return;
    }
    if (isdefined(player.carryobject.scorefrozenuntil) && player.carryobject.scorefrozenuntil > gettime()) {
        return;
    }
    self function_85e74fc9();
    player.carryobject.scorefrozenuntil = gettime() + 10000;
    ball_check_assist(player, 1);
    team = self.team;
    otherteam = util::getotherteam(team);
    globallogic_audio::flush_objective_dialog("uplink_ball");
    globallogic_audio::leader_dialog("uplWeUplink", otherteam);
    globallogic_audio::leader_dialog("uplTheyUplink", team);
    globallogic_audio::play_2d_on_team("mpl_ballcapture_sting_friend", otherteam);
    globallogic_audio::play_2d_on_team("mpl_ballcapture_sting_enemy", team);
    level thread popups::displayteammessagetoteam(%MP_BALL_CAPTURE, player, team);
    level thread popups::displayteammessagetoteam(%MP_BALL_CAPTURE, player, otherteam);
    if (should_record_final_score_cam(otherteam, level.carryscore)) {
    }
    if (isdefined(player.var_6221f6f)) {
        player.var_6221f6f.inuse = 0;
    }
    ball = player.carryobject;
    ball.lastcarrierscored = 1;
    player gameobjects::take_carry_weapon(ball.carryweapon);
    ball ball_set_dropped(1);
    ball thread function_db6a152e(self);
    if (isdefined(player.pers["carries"])) {
        player.pers["carries"]++;
        player.carries = player.pers["carries"];
    }
    bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ball_capture", team, player.origin);
    player recordgameevent("capture");
    player addplayerstatwithgametype("CARRIES", 1);
    scoreevents::processscoreevent("ball_capture_carry", player);
    ball_give_score(otherteam, level.carryscore);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x6816bee7, Offset: 0x28c8
// Size: 0x2ac
function function_dbf94d16(trigger) {
    visuals = [];
    visuals[0] = spawn("script_model", trigger.origin);
    visuals[0] setmodel("wpn_t7_uplink_ball_world");
    visuals[0] notsolid();
    trigger enablelinkto();
    trigger linkto(visuals[0]);
    trigger.no_moving_platfrom_unlink = 1;
    var_afffeadd = gameobjects::create_carry_object("neutral", trigger, visuals, (0, 0, 0), istring("ball_ball"), "mpl_hit_alert_ballholder");
    var_afffeadd gameobjects::allow_carry("any");
    var_afffeadd gameobjects::set_visible_team("any");
    var_afffeadd gameobjects::set_drop_offset(8);
    var_afffeadd.objectiveonvisuals = 1;
    var_afffeadd.allowweapons = 0;
    var_afffeadd.carryweapon = getweapon("ball");
    var_afffeadd.keepcarryweapon = 1;
    var_afffeadd.waterbadtrigger = 0;
    var_afffeadd.disallowremotecontrol = 1;
    var_afffeadd gameobjects::update_objective();
    var_afffeadd.canuseobject = &function_b861e1df;
    var_afffeadd.onpickup = &function_6ce143ff;
    var_afffeadd.setdropped = &ball_set_dropped;
    var_afffeadd.onreset = &function_df2611a2;
    var_afffeadd.pickuptimeoutoverride = &ball_physics_timeout;
    var_afffeadd.carryweaponthink = &function_804453f1;
    var_afffeadd.in_goal = 0;
    var_afffeadd.lastcarrierscored = 0;
    var_afffeadd.lastcarrierteam = "neutral";
    if (level.enemycarriervisible == 2) {
        var_afffeadd.objidpingfriendly = 1;
    }
    if (level.idleflagreturntime > 0) {
        var_afffeadd.autoresettime = level.idleflagreturntime;
    } else {
        var_afffeadd.autoresettime = undefined;
    }
    playfxontag("ui/fx_uplink_ball_trail", var_afffeadd.visuals[0], "tag_origin");
    return var_afffeadd;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xdce4e50b, Offset: 0x2b80
// Size: 0x231
function function_b861e1df(player) {
    if (!isdefined(player)) {
        return false;
    }
    if (isdefined(self.droptime) && self.droptime >= gettime()) {
        return false;
    }
    if (isdefined(player.resurrect_weapon) && player getcurrentweapon() == player.resurrect_weapon) {
        return false;
    }
    if (player iscarryingturret()) {
        return false;
    }
    currentweapon = player getcurrentweapon();
    if (isdefined(currentweapon)) {
        if (!valid_ball_pickup_weapon(currentweapon)) {
            return false;
        }
    }
    nextweapon = player.changingweapon;
    if (isdefined(nextweapon) && player isswitchingweapons()) {
        if (!valid_ball_pickup_weapon(nextweapon)) {
            return false;
        }
    }
    if (player player_no_pickup_time()) {
        return false;
    }
    ball = self.visuals[0];
    thresh = 15;
    dist2 = distance2dsquared(ball.origin, player.origin);
    if (dist2 < thresh * thresh) {
        return true;
    }
    ball = self.visuals[0];
    start = player geteye();
    end = (self.curorigin[0], self.curorigin[1], self.curorigin[2] + 5);
    if (isdefined(self.carrier) && isplayer(self.carrier)) {
        end = self.carrier geteye();
    }
    if (!sighttracepassed(end, start, 0, ball) && !sighttracepassed(end, player.origin, 0, ball)) {
        return false;
    }
    return true;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x97c34d8e, Offset: 0x2dc0
// Size: 0x352
function function_6ce143ff(player) {
    self gameobjects::set_flags(0);
    level.usestartspawns = 0;
    level clientfield::set("ball_home", 0);
    linkedparent = self.visuals[0] getlinkedent();
    if (isdefined(linkedparent)) {
        self.visuals[0] unlink();
    }
    player resetflashback();
    pass = 0;
    if (isdefined(self.projectile)) {
        pass = 1;
        self.projectile delete();
    }
    if (pass) {
        if (self.lastcarrierteam == player.team) {
            if (self.lastcarrier != player) {
                player.passtime = gettime();
                player.passplayer = self.lastcarrier;
                globallogic_audio::leader_dialog("uplTransferred", player.team, undefined, "uplink_ball");
            }
        }
    }
    otherteam = util::getotherteam(player.team);
    if (self.lastcarrierteam != player.team) {
        globallogic_audio::leader_dialog("uplWeTake", player.team, undefined, "uplink_ball");
        globallogic_audio::leader_dialog("uplTheyTake", otherteam, undefined, "uplink_ball");
    }
    globallogic_audio::play_2d_on_team("mpl_ballget_sting_friend", player.team);
    globallogic_audio::play_2d_on_team("mpl_ballget_sting_enemy", otherteam);
    level thread popups::displayteammessagetoteam(%MP_BALL_PICKED_UP, player, player.team);
    level thread popups::displayteammessagetoteam(%MP_BALL_PICKED_UP, player, otherteam);
    self.lastcarrierscored = 0;
    self.lastcarrier = player;
    self.lastcarrierteam = player.team;
    self gameobjects::set_owner_team(player.team);
    player.balldropdelay = getdvarint("scr_ball_water_drop_delay", 10);
    player.objective = 1;
    player.hasperksprintfire = player hasperk("specialty_sprintfire");
    player setperk("specialty_sprintfire");
    player disableusability();
    player disableoffhandweapons();
    player clientfield::set("ballcarrier", 1);
    if (level.var_ef3abf3b > 0) {
        player thread armor::setlightarmor(level.var_ef3abf3b);
    } else {
        player thread armor::unsetlightarmor();
    }
    player thread player_update_pass_target(self);
    player recordgameevent("pickup");
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x80788866, Offset: 0x3120
// Size: 0x12a
function ball_carrier_cleanup() {
    self gameobjects::set_owner_team("neutral");
    if (isdefined(self.carrier)) {
        self.carrier clientfield::set("ballcarrier", 0);
        self.carrier.balldropdelay = undefined;
        self.carrier.nopickuptime = gettime() + 500;
        self.carrier player_clear_pass_target();
        self.carrier notify(#"hash_bf5529ed");
        self.carrier thread armor::unsetlightarmor();
        if (!self.carrier.hasperksprintfire) {
            self.carrier unsetperk("specialty_sprintfire");
        }
        self.carrier enableusability();
        self.carrier enableoffhandweapons();
        self.carrier setballpassallowed(0);
        self.carrier.objective = 0;
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x90a02c90, Offset: 0x3258
// Size: 0x174
function ball_set_dropped(skip_physics) {
    if (!isdefined(skip_physics)) {
        skip_physics = 0;
    }
    self.isresetting = 1;
    self.droptime = gettime();
    self notify(#"dropped");
    dropangles = (0, 0, 0);
    carrier = self.carrier;
    if (isdefined(carrier) && carrier.team != "spectator") {
        droporigin = carrier.origin;
        dropangles = carrier.angles;
    } else {
        droporigin = self.origin;
    }
    droporigin += (0, 0, 40);
    self ball_carrier_cleanup();
    self gameobjects::clear_carrier();
    self gameobjects::set_position(droporigin, dropangles);
    self gameobjects::function_983a9443();
    self thread gameobjects::pickup_timeout(droporigin[2], droporigin[2] - 40);
    self.isresetting = 0;
    if (!skip_physics) {
        angles = (0, dropangles[1], 0);
        forward = anglestoforward(angles);
        velocity = forward * -56 + (0, 0, 80);
        ball_physics_launch(velocity);
    }
    return true;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x8250f95, Offset: 0x33d8
// Size: 0xca
function function_df2611a2(prev_origin) {
    visual = self.visuals[0];
    linkedparent = visual getlinkedent();
    if (isdefined(linkedparent)) {
        visual unlink();
    }
    if (isdefined(self.projectile)) {
        self.projectile delete();
    }
    if (!self gameobjects::get_flags(1)) {
        playfx("ui/fx_uplink_ball_vanish", prev_origin);
        self function_6dc166ee();
    }
    self.lastcarrierteam = "none";
    self thread function_7cd85c83();
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x16f2bff4, Offset: 0x34b0
// Size: 0x12
function function_98827162() {
    self thread gameobjects::return_home();
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xb72c7e84, Offset: 0x34d0
// Size: 0x15a
function function_db6a152e(goal) {
    self notify(#"score_event");
    self.in_goal = 1;
    goal.ball_in_goal = 1;
    if (isdefined(self.projectile)) {
        self.projectile delete();
    }
    self gameobjects::allow_carry("none");
    var_c3f5985e = 0.4;
    var_55f7566e = 1.2;
    rotate_time = 1;
    var_85678934 = var_c3f5985e + rotate_time;
    total_time = var_85678934 + var_55f7566e;
    self gameobjects::set_flags(1);
    visual = self.visuals[0];
    visual moveto(goal.center, var_c3f5985e, 0, var_c3f5985e);
    visual rotatevelocity((1080, 1080, 0), total_time, total_time, 0);
    wait var_85678934;
    goal.ball_in_goal = 0;
    visual movez(4000, var_55f7566e, var_55f7566e * 0.1, 0);
    wait var_55f7566e;
    self thread gameobjects::return_home();
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xc7079297, Offset: 0x3638
// Size: 0x142
function function_7cd85c83() {
    self endon(#"pickup_object");
    self gameobjects::allow_carry("any");
    self gameobjects::set_owner_team("neutral");
    self gameobjects::set_flags(2);
    self.in_goal = 0;
    visual = self.visuals[0];
    visual.origin = visual.baseorigin + (0, 0, 4000);
    visual dontinterpolate();
    fall_time = 3;
    visual moveto(visual.baseorigin, fall_time, 0, fall_time);
    visual rotatevelocity((0, 720, 0), fall_time, 0, fall_time);
    wait fall_time;
    self gameobjects::set_flags(0);
    level clientfield::set("ball_home", 1);
    playfxontag("ui/fx_uplink_ball_trail", visual, "tag_origin");
    self thread ball_download_fx(visual, fall_time);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x55442ea1, Offset: 0x3788
// Size: 0x3a
function function_804453f1() {
    self endon(#"disconnect");
    self thread ball_pass_watch();
    self thread ball_shoot_watch();
    self thread ball_weapon_change_watch();
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x284eb87e, Offset: 0x37d0
// Size: 0x1b2
function ball_pass_watch() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"drop_object");
    while (true) {
        self waittill(#"ball_pass", weapon);
        if (!isdefined(self.pass_target)) {
            playerangles = self getplayerangles();
            playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
            dir = anglestoforward(playerangles);
            force = 90;
            self.carryobject thread ball_physics_launch_drop(dir * force, self);
            return;
        }
        break;
    }
    if (isdefined(self.carryobject)) {
        self thread ball_pass_or_throw_active();
        pass_target = self.pass_target;
        var_bd2ced7c = self.pass_target.origin;
        wait 0.15;
        if (isdefined(self.pass_target)) {
            pass_target = self.pass_target;
            self.carryobject thread ball_pass_projectile(self, pass_target, var_bd2ced7c);
            return;
        }
        playerangles = self getplayerangles();
        playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
        dir = anglestoforward(playerangles);
        force = 90;
        self.carryobject thread ball_physics_launch_drop(dir * force, self);
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xf1c62260, Offset: 0x3990
// Size: 0x182
function ball_shoot_watch() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"drop_object");
    extra_pitch = getdvarfloat("scr_ball_shoot_extra_pitch", 0);
    force = getdvarfloat("scr_ball_shoot_force", 900);
    while (true) {
        self waittill(#"weapon_fired", weapon);
        if (weapon != getweapon("ball")) {
            continue;
        }
        break;
    }
    if (isdefined(self.carryobject)) {
        playerangles = self getplayerangles();
        playerangles += (extra_pitch, 0, 0);
        playerangles = (math::clamp(playerangles[0], -85, 85), playerangles[1], playerangles[2]);
        dir = anglestoforward(playerangles);
        self thread ball_pass_or_throw_active();
        self thread ball_check_pass_kill_pickup(self.carryobject);
        self.carryobject ball_create_killcam_ent();
        self.carryobject thread ball_physics_launch_drop(dir * force, self, 1);
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x876b61c9, Offset: 0x3b20
// Size: 0x142
function ball_weapon_change_watch() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"drop_object");
    ballweapon = getweapon("ball");
    while (true) {
        if (ballweapon == self getcurrentweapon()) {
            break;
        }
        self waittill(#"weapon_change");
    }
    while (true) {
        self waittill(#"weapon_change", weapon);
        if (isdefined(weapon) && weapon.gadget_type == 14) {
            break;
        }
    }
    playerangles = self getplayerangles();
    playerangles = (math::clamp(playerangles[0], -85, 85), absangleclamp360(playerangles[1] + 20), playerangles[2]);
    dir = anglestoforward(playerangles);
    force = 90;
    self.carryobject thread ball_physics_launch_drop(dir * force, self);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x23905ca9, Offset: 0x3c70
// Size: 0x51
function valid_ball_pickup_weapon(weapon) {
    if (weapon == level.weaponnone) {
        return false;
    }
    if (weapon == getweapon("ball")) {
        return false;
    }
    if (killstreaks::is_killstreak_weapon(weapon)) {
        return false;
    }
    return true;
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xfb8ca0f4, Offset: 0x3cd0
// Size: 0x17
function player_no_pickup_time() {
    return isdefined(self.nopickuptime) && self.nopickuptime > gettime();
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x3c31764, Offset: 0x3cf0
// Size: 0xc5
function function_40dff2cd(trigger) {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        if (self isplayerunderwater()) {
            foreach (ball in level.balls) {
                if (isdefined(ball.carrier) && ball.carrier == self) {
                    ball gameobjects::set_dropped();
                    return;
                }
            }
        }
        self.balldropdelay = undefined;
        wait 0.05;
    }
}

// Namespace ball
// Params 3, eflags: 0x0
// Checksum 0x83d80b26, Offset: 0x3dc0
// Size: 0x5a
function ball_physics_launch_drop(force, droppingplayer, switchweapon) {
    ball_set_dropped(1);
    ball_physics_launch(force, droppingplayer);
    if (isdefined(switchweapon) && switchweapon) {
        droppingplayer killstreaks::switch_to_last_non_killstreak_weapon(undefined, 1);
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xffbc909c, Offset: 0x3e28
// Size: 0x13a
function ball_check_pass_kill_pickup(carryobj) {
    self endon(#"death");
    self endon(#"disconnect");
    carryobj endon(#"reset");
    timer = spawnstruct();
    timer endon(#"hash_88be9d37");
    timer thread timer_run(1.5);
    carryobj waittill(#"pickup_object");
    timer timer_cancel();
    if (!isdefined(carryobj.carrier) || carryobj.carrier.team == self.team) {
        return;
    }
    carryobj.carrier endon(#"disconnect");
    timer thread timer_run(5);
    carryobj.carrier waittill(#"death", attacker);
    timer timer_cancel();
    if (!isdefined(attacker) || attacker != self) {
        return;
    }
    timer thread timer_run(2);
    carryobj waittill(#"pickup_object");
    timer timer_cancel();
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xf2168264, Offset: 0x3f70
// Size: 0x1f
function timer_run(time) {
    self endon(#"hash_a5c97639");
    wait time;
    self notify(#"hash_88be9d37");
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x89f97bad, Offset: 0x3f98
// Size: 0xb
function timer_cancel() {
    self notify(#"hash_a5c97639");
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x304909aa, Offset: 0x3fb0
// Size: 0xb9
function adjust_for_stance(ball) {
    target = self;
    target endon(#"hash_4ae8aa2c");
    var_5fe7ebc7 = 0;
    while (isdefined(target) && isdefined(ball)) {
        var_e13766c7 = 50;
        switch (target getstance()) {
        case "crouch":
            var_e13766c7 = 30;
            break;
        case "prone":
            var_e13766c7 = 15;
            break;
        }
        if (var_e13766c7 != var_5fe7ebc7) {
            ball ballsettarget(target, (0, 0, var_e13766c7));
            var_e13766c7 = var_5fe7ebc7;
        }
        wait 0.05;
    }
}

// Namespace ball
// Params 3, eflags: 0x0
// Checksum 0x1bb94dac, Offset: 0x4078
// Size: 0x32a
function ball_pass_projectile(var_c7e075bf, target, var_bd2ced7c) {
    ball_set_dropped(1);
    if (isdefined(target)) {
        var_bd2ced7c = target.origin;
    }
    offset = (0, 0, 60);
    if (target getstance() == "prone") {
        offset = (0, 0, 15);
    } else if (target getstance() == "crouch") {
        offset = (0, 0, 30);
    }
    playerangles = var_c7e075bf getplayerangles();
    playerangles = (0, playerangles[1], 0);
    dir = anglestoforward(playerangles);
    delta = dir * 50;
    origin = self.visuals[0].origin + delta;
    size = 5;
    trace = physicstrace(self.visuals[0].origin, origin, (size * -1, size * -1, size * -1), (size, size, size), var_c7e075bf, 1);
    if (trace["fraction"] < 1) {
        t = 0.7 * trace["fraction"];
        self gameobjects::set_position(self.visuals[0].origin + delta * t, self.visuals[0].angles);
    } else {
        self gameobjects::set_position(trace["position"], self.visuals[0].angles);
    }
    var_c23fae42 = vectornormalize(var_bd2ced7c + offset - self.visuals[0].origin);
    var_59ae0bde = var_c23fae42 * 850;
    self.projectile = var_c7e075bf magicmissile(level.var_aff3334d, self.visuals[0].origin, var_59ae0bde);
    target thread adjust_for_stance(self.projectile);
    self.visuals[0] linkto(self.projectile);
    self gameobjects::ghost_visuals();
    self ball_create_killcam_ent();
    self ball_clear_contents();
    self thread ball_on_projectile_hit_client(var_c7e075bf);
    self thread ball_on_projectile_death();
    self thread function_859e9fab();
    var_c7e075bf killstreaks::switch_to_last_non_killstreak_weapon(undefined, 1);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xb80d18d1, Offset: 0x43b0
// Size: 0x94
function ball_on_projectile_death() {
    self.projectile waittill(#"death");
    ball = self.visuals[0];
    if (!isdefined(self.carrier) && !self.in_goal) {
        if (ball.origin != ball.baseorigin + (0, 0, 4000)) {
            self ball_physics_launch((0, 0, 10));
        }
    }
    self ball_restore_contents();
    ball notify(#"hash_4ae8aa2c");
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x362bcde7, Offset: 0x4450
// Size: 0x49
function ball_restore_contents() {
    if (isdefined(self.visuals[0].var_f8f65741)) {
        self.visuals[0] setcontents(self.visuals[0].var_f8f65741);
        self.visuals[0].var_f8f65741 = undefined;
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xfe9ac32, Offset: 0x44a8
// Size: 0x5a
function ball_on_projectile_hit_client(var_c7e075bf) {
    self endon(#"hash_4ae8aa2c");
    self.projectile waittill(#"projectile_impact_player", player);
    self.trigger notify(#"trigger", player);
    if (isdefined(var_c7e075bf)) {
        var_c7e075bf recordgameevent("pass");
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xb606bd81, Offset: 0x4510
// Size: 0x2a
function ball_clear_contents() {
    self.visuals[0].var_f8f65741 = self.visuals[0] setcontents(0);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x5fbba038, Offset: 0x4548
// Size: 0x8a
function ball_create_killcam_ent() {
    if (isdefined(self.killcament)) {
        self.killcament delete();
    }
    self.killcament = spawn("script_model", self.visuals[0].origin);
    self.killcament linkto(self.visuals[0]);
    self.killcament setcontents(0);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x65f0ff19, Offset: 0x45e0
// Size: 0x82
function ball_pass_or_throw_active() {
    self endon(#"death");
    self endon(#"disconnect");
    self.pass_or_throw_active = 1;
    self allowmelee(0);
    while (getweapon("ball") == self getcurrentweapon()) {
        wait 0.05;
    }
    self allowmelee(1);
    self.pass_or_throw_active = 0;
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0xd2bcb2dd, Offset: 0x4670
// Size: 0x1a
function ball_download_fx(var_7ee2b1c, waittime) {
    self.scorefrozenuntil = 0;
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x17682ace, Offset: 0x4698
// Size: 0xa2
function function_2635f289() {
    var_8f2a0684 = undefined;
    var_c9003254 = array::randomize(level.ball_starts);
    foreach (start in var_c9003254) {
        if (start.in_use) {
            continue;
        }
        var_8f2a0684 = start;
        break;
    }
    if (!isdefined(var_8f2a0684)) {
        return;
    }
    ball_assign_start(var_8f2a0684);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x9786354, Offset: 0x4748
// Size: 0x9a
function ball_assign_start(start) {
    foreach (vis in self.visuals) {
        vis.baseorigin = start.origin;
    }
    self.trigger.baseorigin = start.origin;
    self.current_start = start;
    start.in_use = 1;
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x2fd34d37, Offset: 0x47f0
// Size: 0x22a
function ball_physics_launch(force, droppingplayer) {
    visuals = self.visuals[0];
    visuals.origin_prev = undefined;
    origin = visuals.origin;
    owner = visuals;
    if (isdefined(droppingplayer)) {
        owner = droppingplayer;
        origin = droppingplayer getweaponmuzzlepoint();
        right = anglestoright(force);
        origin += (right[0], right[1], 0) * 7;
        startpos = origin;
        delta = vectornormalize(force) * 80;
        size = 5;
        trace = physicstrace(startpos, startpos + delta, (size * -1, size * -1, size * -1), (size, size, size), droppingplayer, 1);
        if (trace["fraction"] < 1) {
            t = 0.7 * trace["fraction"];
            self gameobjects::set_position(startpos + delta * t, visuals.angles);
        } else {
            self gameobjects::set_position(trace["position"], visuals.angles);
        }
    }
    grenade = owner magicmissile(level.var_d566bdba, visuals.origin, force);
    visuals linkto(grenade);
    self gameobjects::ghost_visuals();
    self.projectile = grenade;
    visuals dontinterpolate();
    self thread ball_physics_out_of_level();
    self thread function_859e9fab();
    self thread ball_physics_touch_cant_pickup_player(droppingplayer);
    self thread function_96acd1aa();
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xbbacbb5c, Offset: 0x4a28
// Size: 0x85
function function_96acd1aa() {
    self endon(#"reset");
    self endon(#"pickup_object");
    visual = self.visuals[0];
    while (true) {
        if (visual oob::istouchinganyoobtrigger() || self gameobjects::should_be_reset(visual.origin[2], visual.origin[2] + 10, 1)) {
            self function_98827162();
            return;
        }
        wait 0.05;
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xae389f91, Offset: 0x4ab8
// Size: 0xe1
function ball_physics_touch_cant_pickup_player(droppingplayer) {
    self endon(#"reset");
    self endon(#"pickup_object");
    ball = self.visuals[0];
    trigger = self.trigger;
    while (true) {
        trigger waittill(#"trigger", player);
        if (isdefined(droppingplayer) && droppingplayer == player && player player_no_pickup_time()) {
            continue;
        }
        if (self.droptime >= gettime()) {
            continue;
        }
        if (ball.origin == ball.baseorigin + (0, 0, 4000)) {
            continue;
        }
        if (!function_b861e1df(player) && self.droptime + -56 < gettime()) {
        }
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x533aa1fd, Offset: 0x4ba8
// Size: 0x6d
function ball_physics_fake_bounce() {
    ball = self.visuals[0];
    vel = ball getvelocity();
    bounceforce = length(vel) / 10;
    var_553a55d2 = -1 * vectornormalize(vel);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x7f0cd358, Offset: 0x4c20
// Size: 0x13d
function function_859e9fab() {
    self endon(#"reset");
    self endon(#"pickup_object");
    var_a75918ba = level.ball_goals[util::getotherteam(self.lastcarrierteam)];
    while (true) {
        if (!var_a75918ba function_ce3bd9c9()) {
            wait 0.05;
            continue;
        }
        var_c64dfe9a = self.visuals[0];
        distsq = distancesquared(var_c64dfe9a.origin, var_a75918ba.center);
        if (distsq <= var_a75918ba.radiussq) {
            self thread ball_touched_goal(var_a75918ba);
            return;
        }
        if (isdefined(var_c64dfe9a.origin_prev)) {
            result = function_12bbc0ef(var_c64dfe9a.origin_prev, var_c64dfe9a.origin, var_a75918ba.center, var_a75918ba.trigger.radius);
            if (result) {
                self thread ball_touched_goal(var_a75918ba);
                return;
            }
        }
        wait 0.05;
    }
}

// Namespace ball
// Params 4, eflags: 0x0
// Checksum 0xf0abc5a2, Offset: 0x4d68
// Size: 0x9e
function function_12bbc0ef(line_start, line_end, var_494a9d56, sphere_radius) {
    dir = vectornormalize(line_end - line_start);
    a = vectordot(dir, line_start - var_494a9d56);
    a *= a;
    b = line_start - var_494a9d56;
    b *= b;
    c = sphere_radius * sphere_radius;
    return a - b + c >= 0;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x61afdda0, Offset: 0x4e10
// Size: 0x2aa
function ball_touched_goal(goal) {
    if (isdefined(self.scorefrozenuntil) && self.scorefrozenuntil > gettime()) {
        return;
    }
    goal function_85e74fc9();
    self.scorefrozenuntil = gettime() + 10000;
    team = goal.team;
    otherteam = util::getotherteam(team);
    globallogic_audio::flush_objective_dialog("uplink_ball");
    globallogic_audio::leader_dialog("uplWeUplinkRemote", otherteam);
    globallogic_audio::leader_dialog("uplTheyUplinkRemote", team);
    globallogic_audio::play_2d_on_team("mpl_ballcapture_sting_friend", otherteam);
    globallogic_audio::play_2d_on_team("mpl_ballcapture_sting_enemy", team);
    if (isdefined(self.lastcarrier)) {
        level thread popups::displayteammessagetoteam(%MP_BALL_CAPTURE, self.lastcarrier, team);
        level thread popups::displayteammessagetoteam(%MP_BALL_CAPTURE, self.lastcarrier, otherteam);
        if (isdefined(self.lastcarrier.pers["throws"])) {
            self.lastcarrier.pers["throws"]++;
            self.lastcarrier.throws = self.lastcarrier.pers["throws"];
        }
        bbprint("mpobjective", "gametime %d objtype %s team %s playerx %d playery %d playerz %d", gettime(), "ball_throw", team, self.lastcarrier.origin);
        self.lastcarrier recordgameevent("throw");
        self.lastcarrier addplayerstatwithgametype("THROWS", 1);
        scoreevents::processscoreevent("ball_capture_throw", self.lastcarrier);
        self.lastcarrierscored = 1;
        ball_check_assist(self.lastcarrier, 0);
        if (isdefined(self.killcament) && should_record_final_score_cam(otherteam, level.throwscore)) {
        }
    }
    if (isdefined(self.killcament)) {
        self.killcament unlink();
    }
    self thread function_db6a152e(goal);
    ball_give_score(otherteam, level.throwscore);
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x56f21216, Offset: 0x50c8
// Size: 0x41
function ball_give_score(team, score) {
    level globallogic_score::giveteamscoreforobjective(team, score);
    InvalidOpCode(0x54, "overtime_round");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0xfa5247f2, Offset: 0x5180
// Size: 0x56
function should_record_final_score_cam(team, var_6db4572f) {
    team_score = [[ level._getteamscore ]](team);
    var_c97a682c = [[ level._getteamscore ]](util::getotherteam(team));
    return team_score + var_6db4572f >= var_c97a682c;
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0xdf47b429, Offset: 0x51e0
// Size: 0x6a
function ball_check_assist(player, var_84a3cadc) {
    if (!isdefined(player.passtime) || !isdefined(player.passplayer)) {
        return;
    }
    if (player.passtime + 3000 < gettime()) {
        return;
    }
    scoreevents::processscoreevent("ball_capture_assist", player.passplayer);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xc77ffa13, Offset: 0x5258
// Size: 0xba
function ball_physics_timeout() {
    self endon(#"reset");
    self endon(#"pickup_object");
    self endon(#"score_event");
    if (isdefined(self.autoresettime) && self.autoresettime > 15) {
        var_394347f7 = self.autoresettime;
    } else {
        var_394347f7 = 15;
    }
    if (isdefined(self.projectile)) {
        var_2615ab42 = self.projectile util::waittill_any_timeout(var_394347f7, "stationary");
        if (!isdefined(var_2615ab42)) {
            return;
        }
        if (var_2615ab42 == "stationary") {
            if (isdefined(self.autoresettime)) {
                wait self.autoresettime;
            }
        }
    }
    self function_98827162();
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x6da6dd6f, Offset: 0x5320
// Size: 0x42
function ball_physics_out_of_level() {
    self endon(#"reset");
    self endon(#"pickup_object");
    ball = self.visuals[0];
    self waittill(#"hash_369e04c9");
    self function_98827162();
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xa065d668, Offset: 0x5370
// Size: 0x2a5
function player_update_pass_target(var_afffeadd) {
    self notify(#"hash_227c656a");
    self endon(#"hash_227c656a");
    self endon(#"disconnect");
    self endon(#"hash_bf5529ed");
    test_dot = 0.8;
    while (true) {
        new_target = undefined;
        if (!self isonladder()) {
            playerdir = anglestoforward(self getplayerangles());
            playereye = self geteye();
            var_9ee2cc0f = [];
            foreach (target in level.players) {
                if (target.team != self.team) {
                    continue;
                }
                if (!isalive(target)) {
                    continue;
                }
                if (!var_afffeadd function_b861e1df(target)) {
                    continue;
                }
                targeteye = target geteye();
                distsq = distancesquared(targeteye, playereye);
                if (distsq > 1000000) {
                    continue;
                }
                dirtotarget = vectornormalize(targeteye - playereye);
                dot = vectordot(playerdir, dirtotarget);
                if (dot > test_dot) {
                    target.pass_dot = dot;
                    target.var_4e7a846b = targeteye;
                    var_9ee2cc0f[var_9ee2cc0f.size] = target;
                }
            }
            var_9ee2cc0f = array::quicksort(var_9ee2cc0f, &compare_player_pass_dot);
            foreach (target in var_9ee2cc0f) {
                if (sighttracepassed(playereye, target.var_4e7a846b, 0, target)) {
                    new_target = target;
                    break;
                }
            }
        }
        self player_set_pass_target(new_target);
        wait 0.05;
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x7ba56345, Offset: 0x5620
// Size: 0x8b
function function_6dc166ee() {
    foreach (team in level.teams) {
        globallogic_audio::play_2d_on_team("mpl_ballreturn_sting", team);
        globallogic_audio::leader_dialog("uplReset", team, undefined, "uplink_ball");
    }
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x81a290e6, Offset: 0x56b8
// Size: 0x26
function compare_player_pass_dot(left, right) {
    return left.pass_dot >= right.pass_dot;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x2632016d, Offset: 0x56e8
// Size: 0x122
function player_set_pass_target(new_target) {
    if (isdefined(self.pass_target) && isdefined(new_target) && self.pass_target == new_target) {
        return;
    }
    if (!isdefined(self.pass_target) && !isdefined(new_target)) {
        return;
    }
    self player_clear_pass_target();
    if (isdefined(new_target)) {
        offset = (0, 0, 80);
        new_target clientfield::set("passoption", 1);
        self.pass_target = new_target;
        team_players = [];
        foreach (player in level.players) {
            if (player.team == self.team && player != self && player != new_target) {
                team_players[team_players.size] = player;
            }
        }
        self setballpassallowed(1);
    }
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x9eac840a, Offset: 0x5818
// Size: 0xe2
function player_clear_pass_target() {
    if (isdefined(self.pass_icon)) {
        self.pass_icon destroy();
    }
    team_players = [];
    foreach (player in level.players) {
        if (player.team == self.team && player != self) {
            team_players[team_players.size] = player;
        }
    }
    if (isdefined(self.pass_target)) {
        self.pass_target clientfield::set("passoption", 0);
    }
    self.pass_target = undefined;
    self setballpassallowed(0);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xed6e3184, Offset: 0x5908
// Size: 0x1a1
function function_5fa54274(var_c713c3d7) {
    ball_starts = getentarray("ball_start", "targetname");
    ball_starts = array::randomize(ball_starts);
    foreach (var_8f2a0684 in ball_starts) {
        function_d6b63e51(var_8f2a0684.origin);
    }
    var_4e6825b2 = 30;
    if (ball_starts.size == 0) {
        origin = level.default_ball_origin;
        if (!isdefined(origin)) {
            origin = (0, 0, 0);
        }
        function_d6b63e51(origin);
    }
    var_7adceb37 = var_c713c3d7 - level.ball_starts.size;
    if (var_7adceb37 <= 0) {
        return;
    }
    default_start = level.ball_starts[0].origin;
    var_69e0d43d = getnodesinradius(default_start, -56, 20, 50);
    var_69e0d43d = array::randomize(var_69e0d43d);
    for (i = 0; i < var_7adceb37 && i < var_69e0d43d.size; i++) {
        function_d6b63e51(var_69e0d43d[i].origin);
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xbc38d26b, Offset: 0x5ab8
// Size: 0x8b
function function_d6b63e51(origin) {
    var_46cb7098 = 30;
    var_8f2a0684 = spawnstruct();
    var_8f2a0684.origin = origin;
    var_8f2a0684 function_22c4dbca();
    var_8f2a0684.origin = var_8f2a0684.ground_origin + (0, 0, var_46cb7098);
    var_8f2a0684.in_use = 0;
    level.ball_starts[level.ball_starts.size] = var_8f2a0684;
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xdf80e31, Offset: 0x5b50
// Size: 0x8f
function function_22c4dbca(z_offset) {
    tracestart = self.origin + (0, 0, 32);
    traceend = self.origin + (0, 0, -1000);
    trace = bullettrace(tracestart, traceend, 0, undefined);
    self.ground_origin = trace["position"];
    return trace["fraction"] != 0 && trace["fraction"] != 1;
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0xb65f09c8, Offset: 0x5be8
// Size: 0x42
function function_85e74fc9() {
    key = "ball_score_" + self.team;
    level clientfield::set(key, !level clientfield::get(key));
}

