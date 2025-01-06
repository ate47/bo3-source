#using scripts/mp/_pickup_items;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace fr;

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x36a629cf, Offset: 0xa50
// Size: 0x5a2
function main() {
    globallogic::init();
    clientfield::register("world", "freerun_state", 1, 3, "int");
    clientfield::register("world", "freerun_retries", 1, 16, "int");
    clientfield::register("world", "freerun_faults", 1, 16, "int");
    clientfield::register("world", "freerun_startTime", 1, 31, "int");
    clientfield::register("world", "freerun_finishTime", 1, 31, "int");
    clientfield::register("world", "freerun_bestTime", 1, 31, "int");
    clientfield::register("world", "freerun_timeAdjustment", 1, 31, "int");
    clientfield::register("world", "freerun_timeAdjustmentNegative", 1, 1, "int");
    clientfield::register("world", "freerun_bulletPenalty", 1, 16, "int");
    clientfield::register("world", "freerun_pausedTime", 1, 31, "int");
    clientfield::register("world", "freerun_checkpointIndex", 1, 7, "int");
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
    level.onstartgametype = &onstartgametype;
    level.onspawnplayer = &onspawnplayer;
    level.givecustomloadout = &givecustomloadout;
    level.postroundtime = 0.5;
    level.doendgamescoreboard = 0;
    callback::on_connect(&on_player_connect);
    gameobjects::register_allowed_gameobject("dm");
    gameobjects::register_allowed_gameobject(level.gametype);
    if (!isdefined(level.var_eabce8a5)) {
        level.var_eabce8a5 = "ui/fx_fr_target_impact";
    }
    if (!isdefined(level.var_f8e7e827)) {
        level.var_f8e7e827 = "ui/fx_fr_target_demat";
    }
    if (!isdefined(level.var_8e44204e)) {
        level.var_8e44204e = "wpn_grenade_explode_default";
    }
    level.var_25665cdb = spawnstruct();
    level.var_25665cdb.var_337010cc = 0;
    level.var_25665cdb.tracks = [];
    for (i = 0; i < 1; i++) {
        level.var_25665cdb.tracks[i] = spawnstruct();
        level.var_25665cdb.tracks[i].var_25839439 = getent("fr_start_0" + i, "targetname");
        assert(isdefined(level.var_25665cdb.tracks[i].var_25839439));
        level.var_25665cdb.tracks[i].goaltrigger = getent("fr_end_0" + i, "targetname");
        assert(isdefined(level.var_25665cdb.tracks[i].goaltrigger));
        level.var_25665cdb.tracks[i].highscores = [];
    }
    level.var_25665cdb.var_fe1de148 = getentarray("fr_checkpoint", "targetname");
    assert(level.var_25665cdb.var_fe1de148.size);
    globallogic::setvisiblescoreboardcolumns("pointstowin", "kills", "deaths", "headshots", "score");
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0xbd8f884f, Offset: 0x1000
// Size: 0x8a
function setupteam(team) {
    util::setobjectivetext(team, %OBJECTIVES_FR);
    if (level.splitscreen) {
        util::setobjectivescoretext(team, %OBJECTIVES_FR);
    } else {
        util::setobjectivescoretext(team, %OBJECTIVES_FR_SCORE);
    }
    util::setobjectivehinttext(team, %OBJECTIVES_FR_SCORE);
    spawnlogic::add_spawn_points(team, "mp_dm_spawn");
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xbb8534ff, Offset: 0x1098
// Size: 0x6a2
function onstartgametype() {
    setclientnamemode("auto_change");
    level.usexcamsforendgame = 0;
    spawning::create_map_placed_influencers();
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    foreach (team in level.teams) {
        setupteam(team);
    }
    spawns = spawnlogic::get_spawnpoint_array("mp_dm_spawn");
    spawning::updateallspawnpoints();
    foreach (index, trigger in level.var_25665cdb.var_fe1de148) {
        level.var_25665cdb.checkPointTimes[index] = 0;
        trigger.var_6ae4cd19 = index;
        trigger thread function_fcf737dc();
        closest = 99999999;
        foreach (spawn in spawns) {
            dist = distancesquared(spawn.origin, trigger.origin);
            if (dist < closest) {
                closest = dist;
                trigger.spawnpoint = spawn;
            }
        }
        assert(isdefined(trigger.spawnpoint));
    }
    var_2d05ef52 = spawnlogic::function_12d810b4("info_player_start");
    assert(var_2d05ef52.size);
    foreach (track in level.var_25665cdb.tracks) {
        closest = 99999999;
        foreach (start in var_2d05ef52) {
            dist = distancesquared(start.origin, track.var_25839439.origin);
            if (dist < closest) {
                closest = dist;
                track.var_cf6f6eda = start;
            }
        }
        assert(isdefined(track.var_cf6f6eda));
    }
    level.var_25665cdb.var_8f39bd5e = getentarray("fr_die", "targetname");
    assert(level.var_25665cdb.var_8f39bd5e.size);
    foreach (trigger in level.var_25665cdb.var_8f39bd5e) {
        trigger thread function_543f1f48();
    }
    function_45fad1d5();
    if (!isdefined(level.freerun)) {
        level.freerun = 1;
    }
    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
    spawnpoint = spawnlogic::get_random_intermission_point();
    setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
    level.usestartspawns = 0;
    level.displayroundendtext = 0;
    if (!util::isoneround()) {
        level.displayroundendtext = 1;
    }
    foreach (item in level.pickup_items) {
        closest = 99999999;
        foreach (trigger in level.var_25665cdb.var_fe1de148) {
            dist = distancesquared(item.origin, trigger.origin);
            if (dist < closest) {
                closest = dist;
                item.checkpoint = trigger;
            }
        }
        assert(isdefined(item.checkpoint));
        item.checkpoint.weapon = item.visuals[0].items[0].weapon;
        item.checkpoint.weaponobject = item;
        item.checkpoint function_c7cec620();
    }
    thread function_d9194505();
    level.var_25665cdb.trackindex = getfreeruntrackindex();
    level.var_25665cdb.mapUniqueId = getmissionuniqueid();
    level.var_25665cdb.mapversion = getmissionversion();
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xde24d522, Offset: 0x1748
// Size: 0x5a
function function_d9194505() {
    level waittill(#"game_ended");
    if (!function_5e3571bb()) {
        level clientfield::set("freerun_finishTime", 0);
    }
    self function_e7717344();
    level clientfield::set("freerun_state", 4);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xe414ea20, Offset: 0x17b0
// Size: 0x12
function on_player_connect() {
    self thread on_menu_response();
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x1c73bc48, Offset: 0x17d0
// Size: 0x6d
function on_menu_response() {
    self endon(#"disconnect");
    for (;;) {
        self waittill(#"menuresponse", menu, response);
        if (response == "fr_restart") {
            self playsoundtoplayer("uin_freerun_reset", self);
            function_53fb4d3b(level.var_25665cdb.var_337010cc);
        }
    }
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x4aacb498, Offset: 0x1848
// Size: 0xf2
function onspawnplayer(predictedspawn) {
    spawning::onspawnplayer(predictedspawn);
    if (predictedspawn) {
        return;
    }
    if (isdefined(self.var_98201a24)) {
        self.body hide();
        function_8f0e1bf3();
        return;
    }
    self.var_98201a24 = 1;
    self thread function_3568abeb();
    self thread function_53fb4d3b(level.var_25665cdb.var_337010cc);
    self thread function_a17ae473();
    self thread function_f32cd29e();
    self thread function_b7a29f53();
    self thread function_2e46bb();
    level.var_25665cdb.var_6656a4f2 = 0;
    self disableweaponcycling();
}

// Namespace fr
// Params 11, eflags: 0x0
// Checksum 0x39696ba3, Offset: 0x1948
// Size: 0x86
function on_player_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, modelindex, psoffsettime) {
    if (idamage >= self.health) {
        self.health = self.maxhealth + 1;
        function_8f0e1bf3();
        return 0;
    }
    return idamage;
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x6c74d79b, Offset: 0x19d8
// Size: 0x3f
function function_2e46bb() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        self.prev_origin = self.origin;
        self.prev_time = gettime();
        wait 0.05;
        waittillframeend();
    }
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xdaae5019, Offset: 0x1a20
// Size: 0x22
function function_f0870580() {
    function_70f1fe07();
    function_64134457();
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x26565de3, Offset: 0x1a50
// Size: 0xaa
function function_64134457() {
    self freerunsethighscores(level.var_25665cdb.var_b05f45d8.highscores[0].time, level.var_25665cdb.var_b05f45d8.highscores[1].time, level.var_25665cdb.var_b05f45d8.highscores[2].time);
    level clientfield::set("freerun_bestTime", level.var_25665cdb.var_b05f45d8.highscores[0].time);
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x17883df8, Offset: 0x1b08
// Size: 0x3c2
function function_53fb4d3b(trackindex) {
    level notify(#"activate_track");
    /#
        if (level.var_25665cdb.tracks.size > 1) {
            iprintln("<dev string:x28>" + trackindex);
        }
    #/
    if (!isdefined(level.var_25665cdb.var_4b04d8ea) || !level.var_25665cdb.var_4b04d8ea) {
        self playlocalsound("vox_tuto_tutorial_sequence_27");
    }
    level.var_25665cdb.var_945241ef = -1;
    level.var_25665cdb.var_337010cc = trackindex;
    level.var_25665cdb.var_b05f45d8 = level.var_25665cdb.tracks[trackindex];
    level.var_25665cdb.var_a73ed5e6 = level.var_25665cdb.var_b05f45d8.var_cf6f6eda;
    level.var_25665cdb.var_8c06ec31 = level.var_25665cdb.var_b05f45d8.var_cf6f6eda.origin;
    level.var_25665cdb.var_bda200c4 = level.var_25665cdb.var_b05f45d8.var_cf6f6eda.angles;
    level.var_25665cdb.var_b05f45d8.goaltrigger thread function_1d665b6d();
    level.var_25665cdb.var_a73ed5e6.var_6ae4cd19 = 0;
    level.var_25665cdb.faults = 0;
    level.var_25665cdb.var_31833820 = 0;
    level.var_25665cdb.checkPointTimes = [];
    foreach (index, trigger in level.var_25665cdb.var_fe1de148) {
        level.var_25665cdb.checkPointTimes[index] = 0;
    }
    level clientfield::set("freerun_faults", 0);
    level clientfield::set("freerun_retries", 0);
    level clientfield::set("freerun_state", 0);
    level clientfield::set("freerun_bulletPenalty", 0);
    level clientfield::set("freerun_pausedTime", 0);
    self function_f0870580();
    self givecustomloadout();
    self setorigin(level.var_25665cdb.var_b05f45d8.var_cf6f6eda.origin);
    self setplayerangles(level.var_25665cdb.var_b05f45d8.var_cf6f6eda.angles);
    self setvelocity((0, 0, 0));
    resetglass();
    function_913ea0f5();
    pickup_items::respawn_all_pickups();
    self unfreeze();
    self.respawn_position = undefined;
    function_d79de9c3();
    function_6a8c051b();
    level.var_25665cdb.var_b05f45d8.var_25839439 thread function_4161e0ad(self);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xbaf7239d, Offset: 0x1ed8
// Size: 0xda
function function_a802497e() {
    level.var_25665cdb.var_d6bf230 = 0;
    level.var_25665cdb.var_8aca8717 = 0;
    level.var_25665cdb.bulletPenalty = 0;
    level.var_25665cdb.var_e918cacf = 0;
    level.var_25665cdb.var_de1118a5 = 0;
    level.var_25665cdb.var_de1118a5 = function_22b5bb47(self);
    level clientfield::set("freerun_startTime", level.var_25665cdb.var_de1118a5);
    level clientfield::set("freerun_state", 1);
    self playsoundtoplayer("uin_freerun_start", self);
    self thread function_5a8897c9();
}

// Namespace fr
// Params 2, eflags: 0x0
// Checksum 0xd865921a, Offset: 0x1fc0
// Size: 0xca
function function_44f42c50(player, endonstring) {
    self endon(endonstring);
    level.var_25665cdb.var_8c06ec31 = function_41e3cbf7(player.origin);
    level.var_25665cdb.var_bda200c4 = player.angles;
    if (level.var_25665cdb.var_a73ed5e6 != self) {
        level.var_25665cdb.var_a73ed5e6 = self;
        player function_5d8cefb2(0);
        if (isdefined(self.weaponobject)) {
            self.weaponobject function_8215cc4d();
            self.weaponobject pickup_items::respawn_pickup();
        }
    }
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x41c9d35c, Offset: 0x2098
// Size: 0x1a
function function_4d6542e0(player) {
    self thread function_fcf737dc();
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0xf1b0f2c3, Offset: 0x20c0
// Size: 0xc9
function function_22b5bb47(player) {
    curtime = gettime();
    dt = curtime - player.prev_time;
    frac = getfirsttouchfraction(player, self, player.prev_origin, player.origin);
    current_time = curtime - level.var_25665cdb.var_de1118a5 + level.var_25665cdb.bulletPenalty * 1000 + level.var_25665cdb.var_31833820 * 5000 - level.var_25665cdb.var_d6bf230;
    return int(current_time - dt * (1 - frac));
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x51c22376, Offset: 0x2198
// Size: 0x212
function function_fcf737dc() {
    self waittill(#"trigger", player);
    if (isplayer(player)) {
        if (level.var_25665cdb.var_a73ed5e6 != self) {
            checkpoint_index = self.var_6ae4cd19;
            current_time = function_22b5bb47(player);
            first_time = 0;
            if (!isdefined(level.var_25665cdb.checkPointTimes[checkpoint_index]) || level.var_25665cdb.checkPointTimes[checkpoint_index] == 0) {
                level.var_25665cdb.checkPointTimes[checkpoint_index] = current_time;
                first_time = 1;
            }
            if (first_time) {
                if (isdefined(level.var_25665cdb.var_b05f45d8.var_7edcb0d0)) {
                    if (isdefined(level.var_25665cdb.var_b05f45d8.var_7edcb0d0[checkpoint_index]) && level.var_25665cdb.var_b05f45d8.var_7edcb0d0[checkpoint_index]) {
                        delta_time = current_time - level.var_25665cdb.var_b05f45d8.var_7edcb0d0[checkpoint_index];
                        if (delta_time < 0) {
                            delta_time *= -1;
                            sign = 1;
                        } else {
                            sign = 0;
                        }
                        level clientfield::set("freerun_timeAdjustment", delta_time);
                        level clientfield::set("freerun_timeAdjustmentNegative", sign);
                        level clientfield::set("freerun_checkpointIndex", checkpoint_index);
                    }
                }
                iprintln(%FREERUN_CHECKPOINT);
                player playsoundtoplayer("uin_freerun_checkpoint", player);
            }
        }
        self thread util::trigger_thread(player, &function_44f42c50, &function_4d6542e0);
    }
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x90a6f59a, Offset: 0x23b8
// Size: 0x45
function function_543f1f48() {
    while (true) {
        self waittill(#"trigger", player);
        if (isplayer(player)) {
            player function_8f0e1bf3();
        }
    }
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x9bf9b286, Offset: 0x2408
// Size: 0x1c4
function function_60fab53d(player) {
    var_d140ccdb = level.var_25665cdb.var_b05f45d8;
    var_28e7910f = function_df23f635(function_22b5bb47(player), level.var_25665cdb.faults, level.var_25665cdb.var_31833820, level.var_25665cdb.bulletPenalty);
    var_c1d18792 = 1;
    var_8561c8cf = 0;
    if (var_d140ccdb.highscores.size > 0) {
        for (i = 0; i < var_d140ccdb.highscores.size; i++) {
            if (var_28e7910f.time < var_d140ccdb.highscores[i].time || var_d140ccdb.highscores[i].time == 0) {
                var_c1d18792 = 0;
                arrayinsert(var_d140ccdb.highscores, var_28e7910f, i);
                if (i == 0) {
                    var_8561c8cf = 1;
                }
                if (i < 3) {
                    player function_bc412e49(i);
                }
                break;
            }
        }
    } else {
        var_8561c8cf = 1;
    }
    if (var_c1d18792) {
        arrayinsert(var_d140ccdb.highscores, var_28e7910f, var_d140ccdb.highscores.size);
        player function_bc412e49(var_d140ccdb.highscores.size - 1);
    }
    if (var_8561c8cf) {
        player function_43fcd204();
    }
    return var_8561c8cf;
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x507889a4, Offset: 0x25d8
// Size: 0x24a
function function_1d665b6d() {
    level notify(#"hash_32735085");
    level endon(#"hash_32735085");
    self waittill(#"trigger", player);
    if (isplayer(player)) {
        player playsoundtoplayer("uin_freerun_finish", player);
        player function_5d8cefb2(1);
        var_8561c8cf = function_60fab53d(player);
        var_abe01f70 = player getdstat("freerunTracksCompleted");
        if (var_abe01f70 < level.var_25665cdb.trackindex) {
            player setdstat("freerunTracksCompleted", level.var_25665cdb.trackindex);
        }
        player.respawn_position = self.origin;
        player thread freeze();
        player thread function_b7a29f53(0);
        player function_64134457();
        level clientfield::set("freerun_finishTime", function_22b5bb47(player));
        level clientfield::set("freerun_state", 2);
        level notify(#"hash_eb4adcc3");
        if (player ishost()) {
            level notify(#"hash_79aa8b11");
            function_6a8c051b();
            level.var_25665cdb.var_4b04d8ea = 0;
            setlocalprofilevar("com_firsttime_freerun", 1);
            var_a6f3447 = getlocalprofileint("freerunHighestTrack");
            if (var_a6f3447 < level.var_25665cdb.trackindex) {
                setlocalprofilevar("freerunHighestTrack", level.var_25665cdb.trackindex);
            }
        }
        /#
            function_afa06c32();
        #/
        wait 1.5;
        level clientfield::set("freerun_state", 5);
    }
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xc68de04a, Offset: 0x2830
// Size: 0x12
function freeze() {
    self util::freeze_player_controls(1);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xda085989, Offset: 0x2850
// Size: 0x12
function unfreeze() {
    self util::freeze_player_controls(0);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xefe2e52b, Offset: 0x2870
// Size: 0x313
function function_c7cec620() {
    target_name = self.weaponobject.visuals[0].target;
    if (!isdefined(target_name)) {
        return;
    }
    self.weaponobject.var_c2417581 = 0;
    self.weaponobject.targets = [];
    self.weaponobject.var_f1970748 = [];
    targets = getentarray(target_name, "targetname");
    foreach (target in targets) {
        if (target.script_noteworthy == "fr_target") {
            self.weaponobject.targets[self.weaponobject.targets.size] = target;
        }
        if (target.script_noteworthy == "fr_target_visual") {
            self.weaponobject.var_f1970748[self.weaponobject.var_f1970748.size] = target;
        }
    }
    foreach (target in self.weaponobject.targets) {
        foreach (visual in self.weaponobject.var_f1970748) {
            if (target.origin == visual.origin) {
                target.visual = visual;
            }
        }
    }
    foreach (target in self.weaponobject.targets) {
        target.blocker = getent(target.target, "targetname");
        if (isdefined(target.blocker)) {
            if (!isdefined(target.blocker.targetcount)) {
                target.blocker.targetcount = 0;
                target.blocker.var_5fb39fa1 = 0;
            }
            target.blocker.targetcount++;
            target.blocker.var_5fb39fa1++;
            target.checkpoint = self;
            target.disabled = 0;
            target thread function_1d349946(self.weaponobject);
        }
    }
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x55318437, Offset: 0x2b90
// Size: 0x101
function function_1d349946(weaponobject) {
    self endon(#"death");
    while (true) {
        self waittill(#"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, weapon, idflags);
        if (level.var_25665cdb.var_a73ed5e6 != self.checkpoint) {
            continue;
        }
        if (weapon == level.weaponbasemeleeheld) {
            continue;
        }
        if (self.disabled) {
            continue;
        }
        self function_e4cf3652(weapon);
        playfx(level.var_eabce8a5, point, direction_vec);
        weaponobject.var_c2417581 = gettime();
    }
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0xcf89f3e, Offset: 0x2ca0
// Size: 0x9a
function function_e4cf3652(weapon) {
    self.disabled = 1;
    self.visual ghost();
    self.visual notsolid();
    self.blocker function_5ddde12c();
    playfx(level.var_f8e7e827, self.origin);
    playsoundatposition(level.var_8e44204e, self.origin);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x3f40aa02, Offset: 0x2d48
// Size: 0x3a
function function_67743d5() {
    self.var_5fb39fa1 = self.targetcount;
    self.disabled = 0;
    self show();
    self solid();
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x86e9379e, Offset: 0x2d90
// Size: 0x42
function function_5ddde12c() {
    self.var_5fb39fa1--;
    if (self.var_5fb39fa1 == 0) {
        self.disabled = 1;
        self ghost();
        self notsolid();
    }
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x2995b738, Offset: 0x2de0
// Size: 0xa7
function function_8215cc4d() {
    foreach (target in self.targets) {
        target.blocker function_67743d5();
        target.visual show();
        target.visual solid();
        target.disabled = 0;
    }
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x3c1e361, Offset: 0x2e90
// Size: 0x83
function function_913ea0f5() {
    foreach (trigger in level.var_25665cdb.var_fe1de148) {
        if (isdefined(trigger.weaponobject)) {
            trigger.weaponobject function_8215cc4d();
        }
    }
}

/#

    // Namespace fr
    // Params 0, eflags: 0x0
    // Checksum 0xd5739e3a, Offset: 0x2f20
    // Size: 0xdf
    function function_afa06c32() {
        for (i = 0; i < level.var_25665cdb.var_b05f45d8.highscores.size; i++) {
            println(i + 1 + "<dev string:x2f>" + level.var_25665cdb.var_b05f45d8.highscores[i].time);
            if (i == 0) {
                for (j = 0; j < level.var_25665cdb.var_b05f45d8.var_7edcb0d0.size; j++) {
                    println("<dev string:x32>" + j + "<dev string:x2f>" + level.var_25665cdb.var_b05f45d8.var_7edcb0d0[j]);
                }
            }
        }
    }

#/

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x590b7141, Offset: 0x3008
// Size: 0xba
function function_f0b248d4() {
    current_time = gettime();
    var_b921f105 = 20000;
    if (current_time - level.var_25665cdb.var_6656a4f2 < var_b921f105) {
        return;
    }
    if (isdefined(self.var_245080db)) {
        return;
    }
    if (level.var_25665cdb.var_945241ef == level.var_25665cdb.var_a73ed5e6.var_6ae4cd19) {
        return;
    }
    level.var_25665cdb.var_945241ef = level.var_25665cdb.var_a73ed5e6.var_6ae4cd19;
    level.var_25665cdb.var_6656a4f2 = current_time;
    self playlocalsound("vox_tuto_tutorial_fail");
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x5c685f2d, Offset: 0x30d0
// Size: 0x72
function function_8f0e1bf3() {
    self function_f0b248d4();
    level.var_25665cdb.faults++;
    level clientfield::set("freerun_faults", level.var_25665cdb.faults);
    self playsoundtoplayer("uin_freerun_reset", self);
    self function_3c68059c();
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xedcd145b, Offset: 0x3150
// Size: 0x11
function function_3922fe1() {
    return self actionslotonebuttonpressed();
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x13fb12fa, Offset: 0x3170
// Size: 0x11
function function_a817770a() {
    return self actionslottwobuttonpressed();
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xa6b7d231, Offset: 0x3190
// Size: 0x11
function function_3c844102() {
    return self actionslotfourbuttonpressed();
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xf4ee0475, Offset: 0x31b0
// Size: 0x11
function function_81b15d4d() {
    return self actionslotthreebuttonpressed();
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xd1621031, Offset: 0x31d0
// Size: 0x41
function function_5e3571bb() {
    state = level clientfield::get("freerun_state");
    if (state == 2 || state == 4 || state == 5) {
        return true;
    }
    return false;
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x73a6ca58, Offset: 0x3220
// Size: 0x191
function function_a17ae473() {
    var_3c1396d6 = level.var_25665cdb.tracks.size;
    while (true) {
        wait 0.05;
        var_378f58b5 = 0;
        if (function_5e3571bb()) {
            continue;
        }
        /#
            if (self function_3c844102() && var_3c1396d6 > 1) {
                var_378f58b5 = 1;
                var_efab0e88 = level.var_25665cdb.var_337010cc;
                var_efab0e88++;
            } else if (self function_81b15d4d() && var_3c1396d6 > 1) {
                var_378f58b5 = 1;
                var_efab0e88 = level.var_25665cdb.var_337010cc;
                var_efab0e88--;
            }
        #/
        if (!var_378f58b5 && self function_3922fe1()) {
            var_378f58b5 = 1;
            var_efab0e88 = level.var_25665cdb.var_337010cc;
            self thread function_b7a29f53();
        }
        if (var_378f58b5) {
            if (var_efab0e88 == 1) {
                var_efab0e88 = 0;
            } else if (var_efab0e88 < 0) {
                var_efab0e88 = 0;
            }
            self playsoundtoplayer("uin_freerun_reset", self);
            function_53fb4d3b(var_efab0e88);
            while (true) {
                wait 0.05;
                if (!(self function_3c844102() || self function_81b15d4d() || self function_3922fe1())) {
                    break;
                }
            }
        }
    }
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x37c1a533, Offset: 0x33c0
// Size: 0x129
function function_5a8897c9() {
    level endon(#"activate_track");
    level endon(#"hash_eb4adcc3");
    /#
        var_10a5a3be = 0;
    #/
    while (true) {
        wait 0.05;
        if (function_5e3571bb()) {
            continue;
        }
        /#
            if (self isinmovemode("<dev string:x35>")) {
                var_10a5a3be = 1;
                continue;
            }
            if (var_10a5a3be && self function_a817770a()) {
                continue;
            }
            var_10a5a3be = 0;
        #/
        if (self function_a817770a()) {
            level.var_25665cdb.var_31833820++;
            level clientfield::set("freerun_retries", level.var_25665cdb.var_31833820);
            self playsoundtoplayer("uin_freerun_reset", self);
            self function_3c68059c();
            while (true) {
                wait 0.05;
                if (!self function_a817770a()) {
                    break;
                }
            }
        }
    }
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x384939a8, Offset: 0x34f8
// Size: 0xf1
function function_8f77a706(weapon) {
    if (!isdefined(level.var_25665cdb.var_a73ed5e6)) {
        return false;
    }
    if (!isdefined(level.var_25665cdb.var_a73ed5e6.weaponobject)) {
        return false;
    }
    grace_period = weapon.firetime * 5;
    if (level.var_25665cdb.var_a73ed5e6.weaponobject.var_c2417581 + grace_period >= gettime()) {
        return true;
    }
    foreach (target in level.var_25665cdb.var_a73ed5e6.weaponobject.targets) {
        if (!target.disabled) {
            return false;
        }
    }
    return true;
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xfb580a7, Offset: 0x35f8
// Size: 0x95
function function_f32cd29e() {
    self endon(#"disconnect");
    self endon(#"death");
    while (true) {
        self waittill(#"weapon_fired", weapon);
        if (weapon == level.weaponbasemeleeheld) {
            continue;
        }
        if (function_8f77a706(weapon)) {
            continue;
        }
        level.var_25665cdb.bulletPenalty++;
        level clientfield::set("freerun_bulletPenalty", level.var_25665cdb.bulletPenalty);
    }
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x97cc1628, Offset: 0x3698
// Size: 0x44
function function_41e3cbf7(position) {
    trace = bullettrace(position + (0, 0, 10), position - (0, 0, 1000), 0, undefined);
    return trace["position"];
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x69af1a57, Offset: 0x36e8
// Size: 0x42
function function_4161e0ad(player) {
    level endon(#"activate_track");
    self waittill(#"trigger", trigger_ent);
    if (trigger_ent == player) {
        player function_a802497e();
    }
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x99a21ac8, Offset: 0x3738
// Size: 0x1b2
function function_3c68059c() {
    resetglass();
    function_913ea0f5();
    pickup_items::respawn_all_pickups();
    function_6a8c051b();
    self playsoundtoplayer("evt_freerun_respawn", self);
    if (isdefined(self.respawn_position)) {
        self setorigin(self.respawn_position);
        self setvelocity((0, 0, 0));
    } else if (isdefined(level.var_25665cdb.var_a73ed5e6.spawnpoint)) {
        self setorigin(level.var_25665cdb.var_a73ed5e6.spawnpoint.origin);
        self setplayerangles(level.var_25665cdb.var_a73ed5e6.spawnpoint.angles);
        self setvelocity((0, 0, 0));
    } else {
        spawn_origin = level.var_25665cdb.var_8c06ec31;
        spawn_origin += (0, 0, 5);
        self setorigin(spawn_origin);
        self setplayerangles(level.var_25665cdb.var_bda200c4);
        self setvelocity((0, 0, 0));
    }
    self setdoublejumpenergy(1);
    self function_5d8cefb2(1);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x2fa572bf, Offset: 0x38f8
// Size: 0x71
function givecustomloadout() {
    self takeallweapons();
    self clearperks();
    self setperk("specialty_fallheight");
    self giveweapon(level.weaponbasemeleeheld);
    self setspawnweapon(level.weaponbasemeleeheld);
    return level.weaponbasemeleeheld;
}

// Namespace fr
// Params 4, eflags: 0x0
// Checksum 0x7c01ba6b, Offset: 0x3978
// Size: 0x52
function function_3e05d0a6(trackindex, slot, stat, value) {
    self setdstat("freerunTrackTimes", "track", trackindex, "topTimes", slot, stat, value);
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x4c459c22, Offset: 0x39d8
// Size: 0x1b1
function function_bc412e49(start_index) {
    var_d140ccdb = level.var_25665cdb.var_b05f45d8;
    self setdstat("freerunTrackTimes", "track", level.var_25665cdb.trackindex, "mapUniqueId", level.var_25665cdb.mapUniqueId);
    self setdstat("freerunTrackTimes", "track", level.var_25665cdb.trackindex, "mapVersion", level.var_25665cdb.mapversion);
    for (slot = start_index; slot < 3; slot++) {
        function_3e05d0a6(level.var_25665cdb.trackindex, slot, "time", var_d140ccdb.highscores[slot].time);
        function_3e05d0a6(level.var_25665cdb.trackindex, slot, "faults", var_d140ccdb.highscores[slot].faults);
        function_3e05d0a6(level.var_25665cdb.trackindex, slot, "retries", var_d140ccdb.highscores[slot].retries);
        function_3e05d0a6(level.var_25665cdb.trackindex, slot, "bulletPenalty", var_d140ccdb.highscores[slot].bulletPenalty);
    }
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x654e07ea, Offset: 0x3b98
// Size: 0xa1
function function_43fcd204() {
    level.var_25665cdb.var_b05f45d8.var_7edcb0d0 = level.var_25665cdb.checkPointTimes;
    for (i = 0; i < level.var_25665cdb.var_fe1de148.size; i++) {
        self setdstat("freerunTrackTimes", "track", level.var_25665cdb.trackindex, "checkPointTimes", "time", i, level.var_25665cdb.checkPointTimes[i]);
    }
}

// Namespace fr
// Params 3, eflags: 0x0
// Checksum 0xdbf18d0c, Offset: 0x3c48
// Size: 0x41
function function_bd426152(trackindex, slot, stat) {
    return self getdstat("freerunTrackTimes", "track", trackindex, "topTimes", slot, stat);
}

// Namespace fr
// Params 4, eflags: 0x0
// Checksum 0x9321c45, Offset: 0x3c98
// Size: 0x70
function function_df23f635(time, faults, retries, bulletPenalty) {
    var_d2980694 = spawnstruct();
    var_d2980694.time = time;
    var_d2980694.faults = faults;
    var_d2980694.retries = retries;
    var_d2980694.bulletPenalty = bulletPenalty;
    return var_d2980694;
}

// Namespace fr
// Params 2, eflags: 0x0
// Checksum 0x8498bd46, Offset: 0x3d10
// Size: 0xc1
function function_f4a85cb3(trackindex, slot) {
    time = self function_bd426152(trackindex, slot, "time");
    faults = self function_bd426152(trackindex, slot, "faults");
    retries = self function_bd426152(trackindex, slot, "retries");
    bulletPenalty = self function_bd426152(trackindex, slot, "bulletPenalty");
    return function_df23f635(time, faults, retries, bulletPenalty);
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x5758a7a8, Offset: 0x3de0
// Size: 0x79
function function_a32e3363(trackindex) {
    for (i = 0; i < level.var_25665cdb.var_fe1de148.size; i++) {
        level.var_25665cdb.var_b05f45d8.var_7edcb0d0[i] = self getdstat("freerunTrackTimes", "track", trackindex, "checkPointTimes", "time", i);
    }
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xc942eb54, Offset: 0x3e68
// Size: 0x1ca
function function_70f1fe07() {
    if (isdefined(level.var_25665cdb.var_b05f45d8.var_c41383e)) {
        return;
    }
    mapid = self getdstat("freerunTrackTimes", "track", level.var_25665cdb.trackindex, "mapUniqueId");
    mapversion = self getdstat("freerunTrackTimes", "track", level.var_25665cdb.trackindex, "mapVersion");
    if (level.var_25665cdb.mapUniqueId != mapid || level.var_25665cdb.mapversion != mapversion) {
        for (i = 0; i < 3; i++) {
            level.var_25665cdb.var_b05f45d8.highscores[i] = function_df23f635(0, 0, 0, 0);
        }
        for (i = 0; i < level.var_25665cdb.var_fe1de148.size; i++) {
            level.var_25665cdb.var_b05f45d8.var_7edcb0d0[i] = 0;
        }
    } else {
        for (i = 0; i < 3; i++) {
            level.var_25665cdb.var_b05f45d8.highscores[i] = function_f4a85cb3(level.var_25665cdb.trackindex, i);
        }
        function_a32e3363(level.var_25665cdb.trackindex);
    }
    level.var_25665cdb.var_b05f45d8.var_c41383e = 1;
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0xa888358, Offset: 0x4040
// Size: 0x17b
function function_5d8cefb2(var_18c6a955) {
    self endon(#"disconnect");
    self endon(#"death");
    var_a52112e9 = level.weaponnone;
    if (isdefined(level.var_25665cdb.var_a73ed5e6.weapon) && !var_18c6a955) {
        var_a52112e9 = level.var_25665cdb.var_a73ed5e6.weapon;
    }
    while (self isswitchingweapons()) {
        wait 0.05;
    }
    current_weapon = self getcurrentweapon();
    if (current_weapon != level.weaponbasemeleeheld && var_a52112e9 != current_weapon) {
        self switchtoweapon(level.weaponbasemeleeheld);
        while (self getcurrentweapon() != level.weaponbasemeleeheld) {
            wait 0.05;
        }
    }
    weaponslist = self getweaponslist();
    foreach (weapon in weaponslist) {
        if (weapon != level.weaponbasemeleeheld && var_a52112e9 != weapon) {
            self takeweapon(weapon);
        }
    }
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x12c7fd6e, Offset: 0x41c8
// Size: 0xae
function function_b7a29f53(start) {
    if (!isdefined(start)) {
        start = 1;
    }
    player = self;
    if (start && !(isdefined(player.var_ec90ebbe) && player.var_ec90ebbe)) {
        mapname = getdvarstring("mapname");
        player globallogic_audio::set_music_on_player(mapname);
        player.var_ec90ebbe = 1;
        return;
    }
    if (!start) {
        player globallogic_audio::set_music_on_player("mp_freerun_finish");
        player.var_ec90ebbe = 0;
    }
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x91c953ef, Offset: 0x4280
// Size: 0xa
function function_6853b180(var_1d08f968) {
    
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xf79ea516, Offset: 0x4298
// Size: 0x93
function function_6a8c051b() {
    if (level.var_25665cdb.var_4b04d8ea) {
        if (level clientfield::get("freerun_state") == 3) {
        }
        foreach (player in level.players) {
            player function_6853b180(0);
        }
    }
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x54aac415, Offset: 0x4338
// Size: 0x93
function function_5f56393a() {
    if (level.var_25665cdb.var_4b04d8ea) {
        if (level clientfield::get("freerun_state") == 1) {
        }
        foreach (player in level.players) {
            player function_6853b180(1);
        }
    }
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x30dae8cb, Offset: 0x43d8
// Size: 0x83
function function_d79de9c3() {
    if (level.var_25665cdb.var_4b04d8ea) {
        foreach (trigger in level.var_25665cdb.var_d98df83c) {
            trigger triggerenable(1);
        }
    }
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x6432f6b6, Offset: 0x4468
// Size: 0xc3
function function_3568abeb() {
    if ((!self ishost() || getlocalprofileint("com_firsttime_freerun")) && !getdvarint("freerun_tutorial")) {
        return;
    }
    level.var_25665cdb.var_4b04d8ea = 1;
    wait 1;
    foreach (trigger in level.var_25665cdb.var_d98df83c) {
        trigger thread function_b2a3d954();
    }
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x8be657e4, Offset: 0x4538
// Size: 0x62
function function_45fad1d5() {
    level.var_25665cdb.var_4b04d8ea = 0;
    level.var_25665cdb.var_d98df83c = getentarray("fr_tutorial", "targetname");
    level.var_25665cdb.var_9be3d60e = [];
    function_cb9f70f2();
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x65896f1c, Offset: 0x45a8
// Size: 0x65
function function_b2a3d954() {
    level endon(#"hash_79aa8b11");
    while (true) {
        self waittill(#"trigger", player);
        if (isplayer(player)) {
            player thread function_ef3ed1a8(self.script_noteworthy);
            self triggerenable(0);
        }
    }
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x3b42259c, Offset: 0x4618
// Size: 0x5a
function function_5b4d1b3() {
    self notify(#"hash_5b4d1b3");
    self waittill(#"hash_5b4d1b3");
    level waittill(#"activate_track");
    function_6a8c051b();
    self util::hide_hint_text(0);
    self function_e7717344();
    self stopsounds();
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x801b9033, Offset: 0x4680
// Size: 0xaa
function function_ef3ed1a8(tutorial) {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    level endon(#"activate_track");
    if (!isdefined(level.var_25665cdb.var_9be3d60e[tutorial])) {
        return;
    }
    level notify(#"hash_582e32ca");
    level endon(#"hash_582e32ca");
    self thread function_5b4d1b3();
    function_5f56393a();
    wait 0.5;
    [[ level.var_25665cdb.var_9be3d60e[tutorial] ]]();
    function_6a8c051b();
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xeb2419f0, Offset: 0x4738
// Size: 0x29
function function_e7717344() {
    if (isdefined(self.var_245080db)) {
        self stopsound(self.var_245080db);
        self.var_245080db = undefined;
    }
}

// Namespace fr
// Params 1, eflags: 0x0
// Checksum 0x772e6e3, Offset: 0x4770
// Size: 0x4a
function function_6edc6e5e(aliasstring) {
    self function_e7717344();
    self.var_245080db = aliasstring;
    self playsoundwithnotify(aliasstring, "sounddone");
    self waittill(#"sounddone");
    wait 1;
}

// Namespace fr
// Params 2, eflags: 0x0
// Checksum 0x3913afb8, Offset: 0x47c8
// Size: 0x62
function function_81ca9cf3(aliasstring, text) {
    self function_e7717344();
    self thread function_80337ef(text);
    self.var_245080db = aliasstring;
    self playsoundwithnotify(aliasstring, "sounddone");
    self waittill(#"sounddone");
    wait 1;
}

// Namespace fr
// Params 3, eflags: 0x0
// Checksum 0xf4204e10, Offset: 0x4838
// Size: 0x3a
function function_80337ef(text, time, var_f1cb7647) {
    wait 0.5;
    function_20d4b0e5(text, time, var_f1cb7647);
}

// Namespace fr
// Params 3, eflags: 0x0
// Checksum 0xff0f60e4, Offset: 0x4880
// Size: 0x72
function function_20d4b0e5(text, time, var_f1cb7647) {
    if (isdefined(var_f1cb7647)) {
        function_6a8c051b();
    }
    if (!isdefined(time)) {
        time = 4;
    }
    self util::show_hint_text(text, 0, "activate_track", 4);
    wait 4.5;
}

// Namespace fr
// Params 2, eflags: 0x0
// Checksum 0x6f3fa09a, Offset: 0x4900
// Size: 0x2a
function function_b3bea47c(text, time) {
    function_20d4b0e5(text, time, 1);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xb936db21, Offset: 0x4938
// Size: 0x2fb
function function_cb9f70f2() {
    level.var_25665cdb.var_9be3d60e["tutorial_01"] = &tutorial_01;
    level.var_25665cdb.var_9be3d60e["tutorial_02"] = &tutorial_02;
    level.var_25665cdb.var_9be3d60e["tutorial_03"] = &tutorial_03;
    level.var_25665cdb.var_9be3d60e["tutorial_06"] = &tutorial_06;
    level.var_25665cdb.var_9be3d60e["tutorial_08"] = &tutorial_08;
    level.var_25665cdb.var_9be3d60e["tutorial_09"] = &tutorial_09;
    level.var_25665cdb.var_9be3d60e["tutorial_10"] = &tutorial_10;
    level.var_25665cdb.var_9be3d60e["tutorial_10a"] = &tutorial_10a;
    level.var_25665cdb.var_9be3d60e["tutorial_12"] = &tutorial_12;
    level.var_25665cdb.var_9be3d60e["tutorial_12a"] = &tutorial_12a;
    level.var_25665cdb.var_9be3d60e["tutorial_13"] = &tutorial_13;
    level.var_25665cdb.var_9be3d60e["tutorial_14"] = &tutorial_14;
    level.var_25665cdb.var_9be3d60e["tutorial_15"] = &tutorial_15;
    level.var_25665cdb.var_9be3d60e["tutorial_16"] = &tutorial_16;
    level.var_25665cdb.var_9be3d60e["tutorial_17"] = &tutorial_17;
    level.var_25665cdb.var_9be3d60e["tutorial_17a"] = &tutorial_17a;
    level.var_25665cdb.var_9be3d60e["tutorial_18"] = &tutorial_18;
    level.var_25665cdb.var_9be3d60e["tutorial_19"] = &tutorial_19;
    level.var_25665cdb.var_9be3d60e["tutorial_20"] = &tutorial_20;
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x2628ac8e, Offset: 0x4c40
// Size: 0x4a
function tutorial_01() {
    self function_6edc6e5e("vox_tuto_tutorial_sequence_1");
    self function_6edc6e5e("vox_tuto_tutorial_sequence_2");
    self function_6edc6e5e("vox_tuto_tutorial_sequence_6");
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xc918f9be, Offset: 0x4c98
// Size: 0x1a
function tutorial_02() {
    self function_b3bea47c(%FREERUN_TUTORIAL_02);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x5631798c, Offset: 0x4cc0
// Size: 0x1a
function tutorial_03() {
    self function_b3bea47c(%FREERUN_TUTORIAL_03);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x37b3bc9, Offset: 0x4ce8
// Size: 0x32
function tutorial_06() {
    self thread function_6edc6e5e("vox_tuto_tutorial_sequence_11");
    self function_b3bea47c(%FREERUN_TUTORIAL_09);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x7376af05, Offset: 0x4d28
// Size: 0x1a
function tutorial_08() {
    self function_b3bea47c(%FREERUN_TUTORIAL_11);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x335e595a, Offset: 0x4d50
// Size: 0x22
function tutorial_09() {
    self function_81ca9cf3("vox_tuto_tutorial_sequence_28", %FREERUN_TUTORIAL_12);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xf05116a2, Offset: 0x4d80
// Size: 0x1a
function tutorial_10() {
    self function_6edc6e5e("vox_tuto_tutorial_sequence_10");
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x109bca26, Offset: 0x4da8
// Size: 0x1a
function tutorial_10a() {
    self function_b3bea47c(%FREERUN_TUTORIAL_13);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x611effed, Offset: 0x4dd0
// Size: 0x1a
function tutorial_12() {
    self function_6edc6e5e("vox_tuto_tutorial_sequence_16");
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x8608bf7e, Offset: 0x4df8
// Size: 0x1a
function tutorial_12a() {
    self function_b3bea47c(%FREERUN_TUTORIAL_14);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x329869ab, Offset: 0x4e20
// Size: 0x52
function tutorial_13() {
    self function_81ca9cf3("vox_tuto_tutorial_sequence_17", %FREERUN_TUTORIAL_14a);
    self function_6edc6e5e("vox_tuto_tutorial_sequence_18");
    self function_b3bea47c(%FREERUN_TUTORIAL_16);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x74146b2b, Offset: 0x4e80
// Size: 0x32
function tutorial_14() {
    self function_6edc6e5e("vox_tuto_tutorial_sequence_19");
    self function_b3bea47c(%FREERUN_TUTORIAL_18);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x4eabd86e, Offset: 0x4ec0
// Size: 0x1a
function tutorial_15() {
    self function_6edc6e5e("vox_tuto_tutorial_sequence_20");
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0xf7c20a47, Offset: 0x4ee8
// Size: 0x1a
function tutorial_16() {
    self function_6edc6e5e("vox_tuto_tutorial_sequence_29");
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x4e654047, Offset: 0x4f10
// Size: 0x1a
function tutorial_17() {
    self function_6edc6e5e("vox_tuto_tutorial_sequence_21");
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x138818c5, Offset: 0x4f38
// Size: 0x1a
function tutorial_17a() {
    self function_b3bea47c(%FREERUN_TUTORIAL_22);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x7cae5f4d, Offset: 0x4f60
// Size: 0x3a
function tutorial_18() {
    self function_81ca9cf3("vox_tuto_tutorial_sequence_23", %FREERUN_TUTORIAL_23);
    self function_b3bea47c(%FREERUN_TUTORIAL_22a);
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x4763e3cd, Offset: 0x4fa8
// Size: 0x1a
function tutorial_19() {
    self function_6edc6e5e("vox_tuto_tutorial_sequence_25");
}

// Namespace fr
// Params 0, eflags: 0x0
// Checksum 0x14bc2818, Offset: 0x4fd0
// Size: 0x1a
function tutorial_20() {
    self function_6edc6e5e("vox_tuto_tutorial_sequence_26");
}

