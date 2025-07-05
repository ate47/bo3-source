#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/teams/_teams;
#using scripts/shared/_oob;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace clean;

// Namespace clean
// Params 0, eflags: 0x2
// Checksum 0x6815df11, Offset: 0x908
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("clean", &__init__, undefined, undefined);
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0xb173d1cc, Offset: 0x948
// Size: 0xc4
function __init__() {
    clientfield::register("clientuimodel", "hudItems.cleanCarryCount", 12000, 4, "int");
    clientfield::register("clientuimodel", "hudItems.cleanCarryFull", 12000, 1, "int");
    clientfield::register("scriptmover", "taco_flag", 12000, 2, "int");
    clientfield::register("allplayers", "taco_carry", 12000, 1, "int");
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0x265cf13b, Offset: 0xa18
// Size: 0x33c
function main() {
    globallogic::init();
    util::registertimelimit(0, 1440);
    util::registerscorelimit(0, 50000);
    util::registerroundlimit(0, 10);
    util::registerroundswitch(0, 9);
    util::registerroundwinlimit(0, 10);
    util::registernumlives(0, 100);
    globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
    level.tacos = [];
    level.teamscoreperkill = getgametypesetting("teamScorePerKill");
    level.teamscorepercleandeposit = getgametypesetting("teamScorePerCleanDeposit");
    level.var_c8a5fbc4 = 0;
    level.cleandepositonlinetime = getgametypesetting("cleanDepositOnlineTime");
    level.cleandepositrotation = getgametypesetting("cleanDepositRotation");
    level.scoreroundwinbased = 1;
    level.teambased = 1;
    level.overrideteamscore = 1;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    level.onroundswitch = &onroundswitch;
    level.onroundendgame = &onroundendgame;
    level.cleandropweapon = getweapon("clean_drop");
    if (!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen()) {
        globallogic::setvisiblescoreboardcolumns("score", "kills", "cleandeposits", "cleandenies", "deaths");
    } else {
        globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "cleandeposits", "cleandenies");
    }
    globallogic_audio::set_leader_gametype_dialog("startStockpile", "hcStartStockpile", "stockpileOrders", "stockpileOrders");
    gameobjects::register_allowed_gameobject(level.gametype);
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0xd60
// Size: 0x4
function onprecachegametype() {
    
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0x4533682c, Offset: 0xd70
// Size: 0x3a4
function onstartgametype() {
    if (!isdefined(game["switchedsides"])) {
        game["switchedsides"] = 0;
    }
    globallogic_score::resetteamscores();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    foreach (team in level.teams) {
        util::setobjectivetext(team, %OBJECTIVES_CLEAN);
        util::setobjectivehinttext(team, %OBJECTIVES_CLEAN_HINT);
        if (level.splitscreen) {
            util::setobjectivescoretext(team, %OBJECTIVES_CLEAN);
        } else {
            util::setobjectivescoretext(team, %OBJECTIVES_CLEAN_SCORE);
        }
        spawnlogic::add_spawn_points(team, "mp_tdm_spawn");
        spawnlogic::place_spawn_points(spawning::gettdmstartspawnname(team));
    }
    spawning::updateallspawnpoints();
    level.spawn_start = [];
    foreach (team in level.teams) {
        level.spawn_start[team] = spawnlogic::get_spawnpoint_array(spawning::gettdmstartspawnname(team));
    }
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    for (i = 0; i < 60; i++) {
        level.tacos[i] = function_18b49ff3();
    }
    level function_f4229f9e();
    level thread function_5b1f87d2();
    level thread function_7ae0a91b();
    /#
        level.activedrops = 0;
        level.var_48919db8 = 0;
        level.var_b24377b2 = 0;
        level.var_6a17c1e8 = 0;
        level.var_dcae370c = 0;
    #/
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0x34c45576, Offset: 0x1120
// Size: 0x20a
function function_7ae0a91b() {
    level waittill(#"game_ended");
    foreach (taco in level.tacos) {
        if (taco clientfield::get("taco_flag") > 0) {
            taco clientfield::set("taco_flag", 0);
        }
    }
    foreach (deposithub in level.cleandeposithubs) {
        deposithub stoploopsound();
        if (isdefined(deposithub.baseeffect)) {
            deposithub.baseeffect delete();
        }
    }
    foreach (player in level.players) {
        player clientfield::set("taco_carry", 0);
    }
}

/#

    // Namespace clean
    // Params 0, eflags: 0x0
    // Checksum 0x5ea07bf, Offset: 0x1338
    // Size: 0xde
    function debug_print() {
        while (true) {
            iprintln("<dev string:x28>" + level.activedrops);
            iprintln("<dev string:x31>" + level.var_48919db8);
            iprintln("<dev string:x3f>" + level.var_b24377b2);
            iprintln("<dev string:x4b>" + level.var_6a17c1e8);
            iprintln("<dev string:x57>" + level.var_dcae370c);
            wait 5;
        }
    }

#/

// Namespace clean
// Params 1, eflags: 0x0
// Checksum 0x9f7a2a59, Offset: 0x1420
// Size: 0x100
function onspawnplayer(predictedspawn) {
    if (level.usestartspawns && !level.ingraceperiod) {
        level.usestartspawns = 0;
    }
    self.var_2deb2526 = 0;
    self.var_6963bf0f = 0;
    self.var_f2408e26 = 0;
    self.carriedtacos = 0;
    self clientfield::set_player_uimodel("hudItems.cleanCarryCount", 0);
    spawning::onspawnplayer(predictedspawn);
    self thread function_d740a523();
    self thread function_2b8b2197();
    self thread function_3063d818();
    self thread function_f1188a86();
    self.var_3d64ac00 = 0;
}

// Namespace clean
// Params 9, eflags: 0x0
// Checksum 0x67ea9d54, Offset: 0x1528
// Size: 0x20c
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
    player = self;
    if (isplayer(attacker) && attacker.team != self.team) {
        if (isdefined(level.killstreaksgivegamescore) && (!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || level.killstreaksgivegamescore)) {
            attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
        }
    }
    if (isdefined(attacker) && isplayer(attacker) && attacker.team != self.team) {
        if (isdefined(player) && isdefined(player.carriedtacos)) {
            if (player.carriedtacos >= 5) {
                scoreevents::processscoreevent("clean_kill_enemy_carrying_tacos", attacker);
            }
        }
        taco = function_54bb534d();
        if (isdefined(taco)) {
            yawangle = randomint(360);
            taco function_992fbc7a(self, attacker, undefined, yawangle);
        }
        self thread function_5d5411e2(attacker, yawangle);
    }
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0xbeb56ec3, Offset: 0x1740
// Size: 0x80
function function_d740a523() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        self flagsys::wait_till("camo_suit_on");
        self clientfield::set("taco_carry", 0);
        self flagsys::wait_till_clear("camo_suit_on");
    }
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0x5bbdc1da, Offset: 0x17c8
// Size: 0x78
function function_2b8b2197() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        self flagsys::wait_till("camo_suit_on");
        self flagsys::wait_till_clear("camo_suit_on");
        self function_65ae6452();
    }
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0xc0f2ecb3, Offset: 0x1848
// Size: 0x80
function function_3063d818() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        self flagsys::wait_till("clone_activated");
        self clientfield::set("taco_carry", 0);
        self flagsys::wait_till_clear("clone_activated");
    }
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0x5cc52ea5, Offset: 0x18d0
// Size: 0x78
function function_f1188a86() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        self flagsys::wait_till("clone_activated");
        self flagsys::wait_till_clear("clone_activated");
        self function_65ae6452();
    }
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0xe1cc0715, Offset: 0x1950
// Size: 0x60
function function_7858ab06() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        self util::waittill_any("enter_vehicle", "exit_vehicle");
        self function_65ae6452();
    }
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0x9624b8ab, Offset: 0x19b8
// Size: 0xac
function function_65ae6452() {
    if (self.carriedtacos > 0 && !self isinvehicle() && !self flagsys::get("camo_suit_on") && !self flagsys::get("clone_activated")) {
        self clientfield::set("taco_carry", 1);
        return;
    }
    self clientfield::set("taco_carry", 0);
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0x97f8f7ae, Offset: 0x1a70
// Size: 0x14a
function function_54bb534d() {
    var_1ea2e34b = undefined;
    foreach (taco in level.tacos) {
        if (taco.interactteam == "none") {
            return taco;
        }
        if (isdefined(taco.var_88b94427)) {
            continue;
        }
        if (!isdefined(var_1ea2e34b) || taco.droptime < var_1ea2e34b.droptime) {
            var_1ea2e34b = taco;
        }
    }
    if (isdefined(var_1ea2e34b) && var_1ea2e34b.droptime != gettime()) {
        /#
            level.var_6a17c1e8++;
        #/
        var_1ea2e34b function_8e1efaa2();
        return var_1ea2e34b;
    }
    /#
        level.var_dcae370c++;
    #/
    return undefined;
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0xcf641b95, Offset: 0x1bc8
// Size: 0x138
function function_18b49ff3() {
    visuals = [];
    trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    taco = gameobjects::create_use_object("any", trigger, visuals, undefined, %);
    taco notsolid();
    taco ghost();
    taco gameobjects::set_use_time(0);
    taco.onuse = &function_9629206a;
    objective_add(taco.objectiveid, "invisible", (0, 0, 0));
    objective_icon(taco.objectiveid, "t7_hud_waypoints_stockpile_dropped");
    return taco;
}

// Namespace clean
// Params 4, eflags: 0x0
// Checksum 0x2d617274, Offset: 0x1d08
// Size: 0x3ac
function function_992fbc7a(victim, attacker, pos, yawangle) {
    /#
        level.activedrops++;
        level.var_48919db8 = max(level.var_48919db8, level.activedrops);
    #/
    if (!isdefined(yawangle)) {
        yawangle = randomint(360);
    }
    if (!isdefined(pos)) {
        pos = victim.origin + (0, 0, 40);
    }
    self.droptime = gettime();
    self.team = victim.team;
    self.victim = victim;
    self.victimteam = victim.team;
    self.attacker = attacker;
    self.attackerteam = attacker.team;
    self.trigger.origin = pos;
    self show();
    self clientfield::set("taco_flag", 1);
    self playloopsound("mpl_fracture_core_loop");
    self dontinterpolate();
    objective_setinvisibletoall(self.objectiveid);
    objective_team(self.objectiveid, attacker.team);
    objective_state(self.objectiveid, "active");
    objective_setcolor(self.objectiveid, %EnemyOrange);
    objective_setvisibletoplayer(self.objectiveid, attacker);
    self gameobjects::allow_use("any");
    if (isdefined(self.var_88b94427)) {
        self.var_88b94427 delete();
    }
    dropangles = (-70, yawangle, 0);
    force = anglestoforward(dropangles) * randomfloatrange(getdvarfloat("dropMin", -36), getdvarfloat("dropMax", 300));
    self.var_88b94427 = victim magicmissile(level.cleandropweapon, pos, force);
    self.var_88b94427 hide();
    self.var_88b94427 notsolid();
    self thread function_31778038();
    self thread function_3073cc55();
    self thread timeout_wait();
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0x740a4295, Offset: 0x20c0
// Size: 0x130
function function_31778038() {
    level endon(#"game_ended");
    self endon(#"reset");
    self.var_88b94427 endon(#"stationary");
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        if (!isdefined(self.var_88b94427)) {
            return;
        }
        if (self.var_88b94427 oob::istouchinganyoobtrigger() || self.var_88b94427 gameobjects::is_touching_any_trigger_key_value("trigger_hurt", "classname", self.trigger.origin[2], self.trigger.origin[2] + 32)) {
            self thread function_8e1efaa2();
            return;
        }
        self.trigger.origin = self.var_88b94427.origin;
        objective_position(self.objectiveid, self.trigger.origin);
        wait 0.05;
    }
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0xc9ce0242, Offset: 0x21f8
// Size: 0xfe
function function_3073cc55() {
    level endon(#"game_ended");
    self endon(#"reset");
    self endon(#"death");
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.var_88b94427)) {
        return;
    }
    self.var_88b94427 waittill(#"stationary");
    self.trigger.origin = self.var_88b94427.origin;
    objective_position(self.objectiveid, self.trigger.origin);
    self playsound("mpl_fracture_core_drop");
    self clientfield::set("taco_flag", 2);
    self.var_88b94427 delete();
    self.var_88b94427 = undefined;
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0x43984cfe, Offset: 0x2300
// Size: 0x44
function timeout_wait() {
    level endon(#"game_ended");
    self endon(#"reset");
    wait 60;
    /#
        level.var_b24377b2++;
    #/
    self thread function_8e1efaa2();
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0x79dbd20d, Offset: 0x2350
// Size: 0xf4
function function_8e1efaa2() {
    /#
        level.activedrops--;
    #/
    self notify(#"reset");
    self clientfield::set("taco_flag", 0);
    self stoploopsound();
    self.trigger.origin = (0, 0, 1000);
    self gameobjects::allow_use("none");
    if (isdefined(self.var_88b94427)) {
        self.var_88b94427 delete();
        self.var_88b94427 = undefined;
    }
    objective_state(self.objectiveid, "invisible");
    self ghost();
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0xd0a4534d, Offset: 0x2450
// Size: 0x1c
function onroundswitch() {
    game["switchedsides"] = !game["switchedsides"];
}

// Namespace clean
// Params 1, eflags: 0x0
// Checksum 0xdfb66094, Offset: 0x2478
// Size: 0x22
function onroundendgame(roundwinner) {
    return globallogic::determineteamwinnerbygamestat("roundswon");
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0xc9495ba0, Offset: 0x24a8
// Size: 0x14c
function function_f4229f9e() {
    globallogic::waitforplayers();
    function_cb0def85("clean_objective_base_trig");
    function_cb0def85("clean_objective_center_trig");
    function_cb0def85("clean_objective_scatter_trig");
    function_afb9f455();
    if (!isdefined(level.cleandepositpoints)) {
        /#
            util::error("<dev string:x60>");
        #/
        return;
    }
    level.cleandeposithubs = [];
    foreach (point in level.cleandepositpoints) {
        deposithub = function_4c41767e(point);
        level.cleandeposithubs[level.cleandeposithubs.size] = deposithub;
    }
}

// Namespace clean
// Params 1, eflags: 0x0
// Checksum 0xf46ea6da, Offset: 0x2600
// Size: 0xba
function function_cb0def85(targetname) {
    ents = getentarray(targetname, "targetname");
    foreach (ent in ents) {
        ent delete();
    }
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0x26c9d42, Offset: 0x26c8
// Size: 0xd2
function function_afb9f455() {
    scriptmodels = getentarray("script_model", "className");
    foreach (scriptmodel in scriptmodels) {
        if (scriptmodel.model === "p7_mp_flag_base") {
            scriptmodel delete();
        }
    }
}

// Namespace clean
// Params 1, eflags: 0x0
// Checksum 0xa6302e9b, Offset: 0x27a8
// Size: 0x1a8
function function_4c41767e(origin) {
    trigger = spawn("trigger_radius", origin, 0, 80, 108);
    visuals[0] = spawn("script_model", trigger.origin);
    deposithub = gameobjects::create_use_object("neutral", trigger, visuals, undefined, %clean_deposit);
    deposithub gameobjects::set_use_time(0);
    deposithub gameobjects::allow_use("none");
    deposithub gameobjects::set_visible_team("none");
    deposithub.onuse = &function_f6b1cbad;
    deposithub.canuseobject = &function_52f9b039;
    deposithub.effectorigin = trigger.origin + (0, 0, 0);
    deposithub spawning::create_influencer("clean_deposit_hub", deposithub.origin, 0);
    deposithub spawning::enable_influencers(0);
    return deposithub;
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0x4e8609e3, Offset: 0x2958
// Size: 0x25c
function function_9bc55b1b() {
    level endon(#"game_ended");
    self.var_6de41998 = spawn("script_model", self.effectorigin);
    self.var_6de41998 setmodel("tag_origin");
    self.var_6de41998.angles = (-90, 0, 0);
    self.baseeffect = spawnfx("ui/fx_stockpile_deposit_point", self.effectorigin);
    self.baseeffect.team = "none";
    triggerfx(self.baseeffect, 0.001);
    time_left = 5;
    wait_time = level.cleandepositonlinetime - time_left;
    if (wait_time < 0) {
        wait_time = level.cleandepositonlinetime * 0.05;
    }
    wait wait_time;
    if (!isdefined(self.baseeffect)) {
        return;
    }
    self playsound("mpl_fracture_deposit_leave");
    self.baseeffect delete();
    self.baseeffect = playfxontag("ui/fx_stockpile_deposit_point_end", self.var_6de41998, "tag_origin");
    self.baseeffect.team = "none";
    time_left += 0.25;
    var_3112d2e7 = 3;
    angles = (self.var_6de41998.angles[0], self.var_6de41998.angles[1] - var_3112d2e7 * 360, self.var_6de41998.angles[2]);
    self.var_6de41998 rotateto(angles, time_left, time_left, 0, 0);
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0xf00d1b4e, Offset: 0x2bc0
// Size: 0x466
function function_5b1f87d2() {
    level endon(#"game_ended");
    while (level.inprematchperiod) {
        wait 0.05;
    }
    setbombtimer("A", 0);
    setmatchflag("bomb_timer_a", 0);
    var_1bc0e62e = -1;
    while (true) {
        if (level.var_c8a5fbc4 > 0) {
            foreach (team in level.teams) {
                setmatchflag("bomb_timer_a", 1);
                setbombtimer("A", int(gettime() + 1000 + level.var_c8a5fbc4 * 1000));
                if (var_1bc0e62e >= 0) {
                    globallogic_audio::leader_dialog("hubOffline", team);
                    globallogic_audio::play_2d_on_team("mpl_fracture_sting_powerdown", team);
                }
            }
            wait level.var_c8a5fbc4;
        }
        var_ad07d7b1 = function_a293cd04(var_1bc0e62e);
        deposithub = level.cleandeposithubs[var_ad07d7b1];
        deposithub gameobjects::allow_use("any");
        deposithub gameobjects::set_visible_team("any");
        deposithub thread function_9bc55b1b();
        deposithub spawning::enable_influencers(1);
        deposithub playloopsound("mpl_fracture_location_lp");
        foreach (team in level.teams) {
            setmatchflag("bomb_timer_a", 1);
            setbombtimer("A", int(gettime() + 1000 + level.cleandepositonlinetime * 1000));
            if (level.var_c8a5fbc4 > 0) {
                globallogic_audio::leader_dialog("hubOnline", team);
            } else if (var_1bc0e62e >= 0) {
                globallogic_audio::leader_dialog("hubMoved", team);
            }
            if (var_1bc0e62e >= 0) {
                globallogic_audio::play_2d_on_team("mpl_fracture_sting_moved", team);
            }
        }
        var_1bc0e62e = var_ad07d7b1;
        wait level.cleandepositonlinetime;
        deposithub gameobjects::allow_use("none");
        deposithub gameobjects::set_visible_team("none");
        deposithub spawning::enable_influencers(0);
        deposithub stoploopsound();
        deposithub.baseeffect delete();
        level notify(#"hash_9c7ac0c3");
    }
}

// Namespace clean
// Params 1, eflags: 0x0
// Checksum 0x179b3a1a, Offset: 0x3030
// Size: 0x92
function function_a293cd04(var_1bc0e62e) {
    if (!isdefined(var_1bc0e62e)) {
        var_1bc0e62e = -1;
    }
    switch (level.cleandepositrotation) {
    case 0:
        return ((var_1bc0e62e + 1) % level.cleandeposithubs.size);
    case 1:
        return function_d844a988(var_1bc0e62e, &function_e458e18d);
    }
    return function_e458e18d(var_1bc0e62e);
}

// Namespace clean
// Params 2, eflags: 0x0
// Checksum 0x79800717, Offset: 0x30d0
// Size: 0x32
function function_d844a988(var_1bc0e62e, var_649e0f82) {
    if (var_1bc0e62e < 0) {
        return 0;
    }
    return [[ var_649e0f82 ]](var_1bc0e62e);
}

// Namespace clean
// Params 1, eflags: 0x0
// Checksum 0x2115b9ed, Offset: 0x3110
// Size: 0xe8
function function_e458e18d(var_1bc0e62e) {
    if (!isdefined(level.var_642e02f4)) {
        level.var_642e02f4 = [];
    }
    if (level.var_642e02f4.size == 0) {
        for (i = 0; i < level.cleandeposithubs.size; i++) {
            if (i != var_1bc0e62e) {
                level.var_642e02f4[level.var_642e02f4.size] = i;
            }
        }
    }
    var_558db871 = randomint(level.var_642e02f4.size);
    nextindex = level.var_642e02f4[var_558db871];
    arrayremoveindex(level.var_642e02f4, var_558db871);
    return nextindex;
}

// Namespace clean
// Params 1, eflags: 0x0
// Checksum 0x3d714cf4, Offset: 0x3200
// Size: 0x78
function function_d8d5d6ee(var_1bc0e62e) {
    if (var_1bc0e62e < 0) {
        return randomint(level.cleandeposithubs.size);
    }
    nextindex = randomint(level.cleandeposithubs.size - 1);
    if (nextindex >= var_1bc0e62e) {
        nextindex++;
    }
    return nextindex;
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0x1e174390, Offset: 0x3280
// Size: 0x2c
function hidetimerdisplayongameend() {
    level waittill(#"game_ended");
    setmatchflag("bomb_timer_a", 0);
}

// Namespace clean
// Params 1, eflags: 0x0
// Checksum 0x225cd940, Offset: 0x32b8
// Size: 0x35c
function function_f6b1cbad(player) {
    time = gettime();
    if (time - player.var_2deb2526 > 0.3 * 1000) {
        player.var_6963bf0f = 0;
    }
    player.var_2deb2526 = time;
    if (isdefined(player.pers["cleandeposits"])) {
        player.pers["cleandeposits"] = player.pers["cleandeposits"] + 1;
        player.cleandeposits = player.pers["cleandeposits"];
        function_c8e1c6b3(player, self);
    }
    player addplayerstatwithgametype("CLEANDEPOSITS", 1);
    if (level.teamscorepercleandeposit > 0) {
        var_68c00958 = level.teamscorepercleandeposit;
        player globallogic_score::giveteamscoreforobjective(player.team, var_68c00958);
    }
    enemyteam = util::getotherteam(player.team);
    level thread popups::displayteammessagetoteam(%MP_CLEAN_DEPOSIT, player, player.team);
    level thread popups::displayteammessagetoteam(%MP_CLEAN_DEPOSIT, player, enemyteam);
    globallogic_audio::play_2d_on_team("mpl_flagcapture_sting_friendly", player.team);
    switch (player.var_6963bf0f) {
    case 0:
        player playlocalsound("mpl_fracture_deposit_1");
        break;
    case 1:
        player playlocalsound("mpl_fracture_deposit_2");
        break;
    case 2:
        player playlocalsound("mpl_fracture_deposit_3");
        break;
    case 3:
        player playlocalsound("mpl_fracture_deposit_4");
        break;
    default:
        player playlocalsound("mpl_fracture_deposit_5");
        break;
    }
    player.var_6963bf0f++;
    scoreevents::processscoreevent("clean_enemy_deposit", player);
    player.carriedtacos--;
    player clientfield::set_player_uimodel("hudItems.cleanCarryCount", player.carriedtacos);
    player function_65ae6452();
}

// Namespace clean
// Params 2, eflags: 0x0
// Checksum 0x196dd0e8, Offset: 0x3620
// Size: 0xf4
function function_c8e1c6b3(player, var_b9fd331) {
    if (!isdefined(player)) {
        return;
    }
    time = gettime();
    player.var_3d64ac00++;
    if (player.var_3d64ac00 == 1) {
        player thread function_aaca5c8e(var_b9fd331);
        return;
    }
    if (player.var_3d64ac00 == 5) {
        scoreevents::processscoreevent("clean_multi_deposit_normal", player);
        return;
    }
    if (player.var_3d64ac00 == 10) {
        scoreevents::processscoreevent("clean_multi_deposit_big", player);
        player.var_3d64ac00 = 0;
    }
}

// Namespace clean
// Params 1, eflags: 0x0
// Checksum 0xcb4720f7, Offset: 0x3720
// Size: 0xa8
function function_aaca5c8e(var_b9fd331) {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"hash_9c7ac0c3");
    self thread function_cde390a2();
    wait 0.1;
    while (true) {
        if (distance2dsquared(self.origin, var_b9fd331.origin) > 90 * 90) {
            break;
        }
        wait 0.1;
    }
    self.var_3d64ac00 = 0;
}

// Namespace clean
// Params 0, eflags: 0x0
// Checksum 0xe86ee9a, Offset: 0x37d0
// Size: 0x34
function function_cde390a2() {
    self endon(#"death");
    self endon(#"disconnect");
    level waittill(#"hash_9c7ac0c3");
    self.var_3d64ac00 = 0;
}

// Namespace clean
// Params 2, eflags: 0x0
// Checksum 0x6d3ed16f, Offset: 0x3810
// Size: 0x1be
function function_2f8f0719(player, victim) {
    if (!isdefined(player)) {
        return;
    }
    if (victim === player) {
        scoreevents::processscoreevent("clean_own_collect", player);
    } else {
        scoreevents::processscoreevent("clean_friendly_collect", player);
    }
    time = gettime();
    if (!isdefined(player.var_77a1267e)) {
        player.var_77a1267e = [];
    }
    var_bb446529 = time - 3250;
    function_3b21342e(player.var_77a1267e, var_bb446529);
    if (player.var_77a1267e.size >= 4) {
        scoreevents::processscoreevent("clean_multi_deny_tacos", player);
        player.var_77a1267e = undefined;
        return;
    }
    if (!isdefined(player.var_77a1267e)) {
        player.var_77a1267e = [];
    } else if (!isarray(player.var_77a1267e)) {
        player.var_77a1267e = array(player.var_77a1267e);
    }
    player.var_77a1267e[player.var_77a1267e.size] = time;
}

// Namespace clean
// Params 2, eflags: 0x0
// Checksum 0xbbfaf127, Offset: 0x39d8
// Size: 0x7c
function function_3b21342e(&times, time_threshold) {
    for (i = 0; i < times.size; i++) {
        if (times[i] < time_threshold) {
            times[i] = 0;
        }
    }
    arrayremovevalue(times, 0);
}

// Namespace clean
// Params 1, eflags: 0x0
// Checksum 0x8b4e766, Offset: 0x3a60
// Size: 0x74
function function_52f9b039(player) {
    if (player.carriedtacos <= 0) {
        objective_clearplayerusing(self.objectiveid, player);
        return false;
    }
    if (!player.var_2deb2526) {
        return true;
    }
    return player.var_2deb2526 + 250 < gettime();
}

// Namespace clean
// Params 1, eflags: 0x0
// Checksum 0xfff69ca7, Offset: 0x3ae0
// Size: 0x37c
function function_9629206a(player) {
    if (self.victimteam == player.team) {
        playsoundatposition("mpl_fracture_enemy_pickup_m", self.origin);
        if (isdefined(player.pers["cleandenies"])) {
            player.pers["cleandenies"] = player.pers["cleandenies"] + 1;
            player.cleandenies = player.pers["cleandenies"];
        }
        player addplayerstatwithgametype("CLEANDENIES", 1);
        function_2f8f0719(player, self.victim);
    } else if (player.carriedtacos >= 10) {
        time = gettime();
        if (time - player.var_f2408e26 > 500) {
            player playlocalsound("mpl_fracture_enemy_pickup_nope");
            if (!isdefined(player.var_741e5451)) {
                player.var_741e5451 = 0;
            }
            player clientfield::set_player_uimodel("hudItems.cleanCarryFull", player.var_741e5451);
            player.var_741e5451 = player.var_741e5451 ? 0 : 1;
        }
        player.var_f2408e26 = time;
        return;
    } else {
        player.carriedtacos++;
        player clientfield::set_player_uimodel("hudItems.cleanCarryCount", player.carriedtacos);
        player function_65ae6452();
        if (player.carriedtacos < 4) {
            playsoundatposition("mpl_fracture_enemy_pickup_s", self.origin);
        } else if (player.carriedtacos < 7) {
            playsoundatposition("mpl_fracture_enemy_pickup_m", self.origin);
        } else {
            playsoundatposition("mpl_fracture_enemy_pickup_l", self.origin);
        }
        scoreevents::processscoreevent("clean_enemy_collect", player);
        if (self.attackerteam == player.team && isdefined(self.attacker) && self.attacker != player) {
            scoreevents::processscoreevent("clean_assist_collect", self.attacker);
        }
    }
    self function_8e1efaa2();
}

// Namespace clean
// Params 2, eflags: 0x0
// Checksum 0x9fee0579, Offset: 0x3e68
// Size: 0x186
function function_5d5411e2(attacker, yawangle) {
    dropcount = self.carriedtacos;
    self.carriedtacos = 0;
    self clientfield::set_player_uimodel("hudItems.cleanCarryCount", self.carriedtacos);
    self function_65ae6452();
    /#
        dropcount += getdvarint("<dev string:x9d>", 0);
    #/
    var_cdaa100d = 360 / (dropcount + 1);
    for (i = 0; i < dropcount; i++) {
        taco = function_54bb534d();
        if (!isdefined(taco)) {
            return;
        }
        yawangle += var_cdaa100d;
        randomyaw = 0.8 * var_cdaa100d;
        randomyaw = randomfloatrange(randomyaw * -1, randomyaw);
        taco function_992fbc7a(self, attacker, undefined, yawangle + randomyaw);
    }
}

