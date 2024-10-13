#using scripts/shared/bots/bot_traversals;
#using scripts/shared/bots/bot_buttons;
#using scripts/shared/bots/_bot_combat;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace bot;

// Namespace bot
// Params 0, eflags: 0x2
// Checksum 0xd24e8fb0, Offset: 0x3d8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("bot", &__init__, undefined, undefined);
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xcdd1d3b8, Offset: 0x418
// Size: 0x2dc
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    callback::on_player_killed(&on_player_killed);
    if (!isdefined(level.var_199a9d5d)) {
        level.var_199a9d5d = &function_7a9265d;
    }
    if (!isdefined(level.onbotremove)) {
        level.onbotremove = &function_3bf716d9;
    }
    if (!isdefined(level.onbotconnect)) {
        level.onbotconnect = &function_3bf716d9;
    }
    if (!isdefined(level.onbotspawned)) {
        level.onbotspawned = &function_3bf716d9;
    }
    if (!isdefined(level.onbotkilled)) {
        level.onbotkilled = &function_3bf716d9;
    }
    if (!isdefined(level.var_694f5886)) {
        level.var_694f5886 = &function_3bf716d9;
    }
    if (!isdefined(level.var_201ee8f)) {
        level.var_201ee8f = &function_7ec247b0;
    }
    if (!isdefined(level.var_110e31eb)) {
        level.var_110e31eb = &function_3bf716d9;
    }
    if (!isdefined(level.var_66a90634)) {
        level.var_66a90634 = &namespace_5cd60c9f::function_a859fd70;
    }
    if (!isdefined(level.var_47854466)) {
        level.var_47854466 = &function_3bf716d9;
    }
    if (!isdefined(level.var_ce074aba)) {
        level.var_ce074aba = &function_3bf716d9;
    }
    if (!isdefined(level.var_a4c843d6)) {
        level.var_a4c843d6 = &namespace_5cd60c9f::function_dc473bdb;
    }
    if (!isdefined(level.var_e3cf16d9)) {
        level.var_e3cf16d9 = &namespace_5cd60c9f::function_47e9a4b7;
    }
    if (!isdefined(level.var_1a99051e)) {
        level.var_1a99051e = &namespace_5cd60c9f::function_22585c05;
    }
    if (!isdefined(level.var_1a85a65e)) {
        level.var_1a85a65e = &namespace_5cd60c9f::function_dc473bdb;
    }
    if (!isdefined(level.var_423acd9b)) {
        level.var_423acd9b = &namespace_5cd60c9f::function_459e3f9f;
    }
    if (!isdefined(level.var_b27b0b06)) {
        level.var_b27b0b06 = &namespace_5cd60c9f::function_c507b448;
    }
    setdvar("bot_maxMantleHeight", -56);
    /#
        level thread function_58ff286c();
    #/
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x40462943, Offset: 0x700
// Size: 0x14
function init() {
    function_90b0af3();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xe404801d, Offset: 0x720
// Size: 0x6
function is_bot_ranked_match() {
    return false;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x730
// Size: 0x4
function function_3bf716d9() {
    
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0x4aa714a7, Offset: 0x740
// Size: 0x6
function function_c2cbcba4() {
    return false;
}

// Namespace bot
// Params 2, eflags: 0x1 linked
// Checksum 0xd1c99d13, Offset: 0x750
// Size: 0x56
function add_bots(count, team) {
    for (i = 0; i < count; i++) {
        add_bot(team);
    }
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0xc535196a, Offset: 0x7b0
// Size: 0xd2
function add_bot(team) {
    var_daa4261b = addtestclient();
    if (!isdefined(var_daa4261b)) {
        return undefined;
    }
    var_daa4261b botsetrandomcharactercustomization();
    if (isdefined(level.disableclassselection) && level.disableclassselection) {
        var_daa4261b.pers["class"] = level.defaultclass;
        var_daa4261b.curclass = level.defaultclass;
    }
    if (level.teambased && team !== "autoassign") {
        var_daa4261b.pers["team"] = team;
    }
    return var_daa4261b;
}

// Namespace bot
// Params 2, eflags: 0x1 linked
// Checksum 0xcd6df001, Offset: 0x890
// Size: 0x112
function remove_bots(count, team) {
    players = getplayers();
    foreach (player in players) {
        if (!player istestclient()) {
            continue;
        }
        if (isdefined(team) && player.team != team) {
            continue;
        }
        remove_bot(player);
        if (isdefined(count)) {
            count--;
            if (count <= 0) {
                break;
            }
        }
    }
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0x89fe72dd, Offset: 0x9b0
// Size: 0x54
function remove_bot(bot) {
    if (!bot istestclient()) {
        return;
    }
    bot [[ level.onbotremove ]]();
    bot botdropclient();
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0x66b013fc, Offset: 0xa10
// Size: 0xba
function filter_bots(players) {
    bots = [];
    foreach (player in players) {
        if (player util::is_bot()) {
            bots[bots.size] = player;
        }
    }
    return bots;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xca8f5dac, Offset: 0xad8
// Size: 0x104
function on_player_connect() {
    if (!self istestclient()) {
        return;
    }
    self endon(#"disconnect");
    self.bot = spawnstruct();
    self.bot.threat = spawnstruct();
    self.bot.damage = spawnstruct();
    self.pers["isBot"] = 1;
    if (level.teambased) {
        self notify(#"menuresponse", game["menu_team"], self.team);
        wait 0.5;
    }
    self notify(#"joined_team");
    callback::callback(#"hash_95a6c4c0");
    self thread [[ level.onbotconnect ]]();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xba949b8d, Offset: 0xbe8
// Size: 0xdc
function on_player_spawned() {
    if (!self util::is_bot()) {
        return;
    }
    self function_36569909();
    self namespace_5cd60c9f::function_dc473bdb();
    self.bot.prevweapon = undefined;
    self function_66d6ef34();
    self thread [[ level.onbotspawned ]]();
    self thread namespace_5cd60c9f::function_75cfa67f();
    self thread function_187eccb();
    self thread function_5b1cfb86();
    self thread function_6eed3d1a();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x8f8a5e9, Offset: 0xcd0
// Size: 0x44
function on_player_killed() {
    if (!self util::is_bot()) {
        return;
    }
    self thread [[ level.onbotkilled ]]();
    self botreleasemanualcontrol();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x8d6be3a8, Offset: 0xd20
// Size: 0x48
function function_6eed3d1a() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        self bot_think();
        wait level.botsettings.var_d74d136c;
    }
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x5b437328, Offset: 0xd70
// Size: 0x110
function bot_think() {
    self botreleasebuttons();
    if (level.inprematchperiod || level.gameended || !isalive(self)) {
        return;
    }
    self function_4826a5ea();
    self function_d991b9dc();
    self update_swim();
    self thread [[ level.var_201ee8f ]]();
    self thread [[ level.var_110e31eb ]]();
    self thread [[ level.var_66a90634 ]]();
    self thread [[ level.var_47854466 ]]();
    if (!self namespace_5cd60c9f::function_231137e6() && !self function_2b2bd09f()) {
        self thread [[ level.var_ce074aba ]]();
    }
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xe88
// Size: 0x4
function function_7ec247b0() {
    
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xdd977f64, Offset: 0xe98
// Size: 0x2bc
function update_swim() {
    if (!self isplayerswimming()) {
        self.bot.resurfacetime = undefined;
        return;
    }
    if (self isplayerunderwater()) {
        if (!isdefined(self.bot.resurfacetime)) {
            self.bot.resurfacetime = gettime() + level.botsettings.swimtime;
        }
    } else {
        self.bot.resurfacetime = undefined;
    }
    if (self botundermanualcontrol()) {
        return;
    }
    goalposition = self function_5bd0f250();
    if (distance2dsquared(goalposition, self.origin) <= 16384 && getwaterheight(goalposition) > 0) {
        self function_9dabea00();
        return;
    }
    if (isdefined(self.bot.resurfacetime) && self.bot.resurfacetime <= gettime()) {
        function_5e7eba3b();
        return;
    }
    bottomtrace = groundtrace(self.origin, self.origin + (0, 0, -1000), 0, self, 1);
    swimheight = self.origin[2] - bottomtrace["position"][2];
    if (swimheight < 25) {
        self function_5e7eba3b();
        vertdist = 25 - swimheight;
    } else if (swimheight > 45) {
        self function_9dabea00();
        vertdist = swimheight - 45;
    }
    if (isdefined(vertdist)) {
        var_9907e16 = level.botsettings.var_b907551c * level.botsettings.var_d74d136c;
        if (var_9907e16 > vertdist) {
            self function_62a758ad(level.botsettings.var_d74d136c * vertdist / var_9907e16);
        }
    }
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0x3d46eb, Offset: 0x1160
// Size: 0x54
function function_62a758ad(waittime) {
    self endon(#"death");
    level endon(#"game_ended");
    wait waittime;
    self function_67a9a01d();
    self function_6174e2fe();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xb6cc53ab, Offset: 0x11c0
// Size: 0x688
function function_90b0af3() {
    level.botsettings = [[ level.var_199a9d5d ]]();
    setdvar("bot_AllowMelee", isdefined(level.botsettings.allowmelee) ? level.botsettings.allowmelee : 0);
    setdvar("bot_AllowGrenades", isdefined(level.botsettings.var_556a176d) ? level.botsettings.var_556a176d : 0);
    setdvar("bot_AllowKillstreaks", isdefined(level.botsettings.allowkillstreaks) ? level.botsettings.allowkillstreaks : 0);
    setdvar("bot_AllowHeroGadgets", isdefined(level.botsettings.var_65b4bd7) ? level.botsettings.var_65b4bd7 : 0);
    setdvar("bot_Fov", isdefined(level.botsettings.fov) ? level.botsettings.fov : 0);
    setdvar("bot_FovAds", isdefined(level.botsettings.var_bcd59d68) ? level.botsettings.var_bcd59d68 : 0);
    setdvar("bot_PitchSensitivity", level.botsettings.pitchsensitivity);
    setdvar("bot_YawSensitivity", level.botsettings.yawsensitivity);
    setdvar("bot_PitchSpeed", isdefined(level.botsettings.var_1ade69f2) ? level.botsettings.var_1ade69f2 : 0);
    setdvar("bot_PitchSpeedAds", isdefined(level.botsettings.var_de2a5ea0) ? level.botsettings.var_de2a5ea0 : 0);
    setdvar("bot_YawSpeed", isdefined(level.botsettings.var_7b873bb7) ? level.botsettings.var_7b873bb7 : 0);
    setdvar("bot_YawSpeedAds", isdefined(level.botsettings.var_1ae54a4b) ? level.botsettings.var_1ae54a4b : 0);
    setdvar("pitchAccelerationTime", isdefined(level.botsettings.pitchAccelerationTime) ? level.botsettings.pitchAccelerationTime : 0);
    setdvar("yawAccelerationTime", isdefined(level.botsettings.yawAccelerationTime) ? level.botsettings.yawAccelerationTime : 0);
    setdvar("pitchDecelerationThreshold", isdefined(level.botsettings.pitchDecelerationThreshold) ? level.botsettings.pitchDecelerationThreshold : 0);
    setdvar("yawDecelerationThreshold", isdefined(level.botsettings.yawDecelerationThreshold) ? level.botsettings.yawDecelerationThreshold : 0);
    meleerange = getdvarint("player_meleeRangeDefault") * (isdefined(level.botsettings.var_e5ef01c3) ? level.botsettings.var_e5ef01c3 : 0);
    level.botsettings.meleerange = int(meleerange);
    level.botsettings.meleerangesq = meleerange * meleerange;
    level.botsettings.var_982d2abd = level.botsettings.var_a4232b8d * level.botsettings.var_a4232b8d;
    level.botsettings.var_253386f = level.botsettings.var_e18736a3 * level.botsettings.var_e18736a3;
    var_57945af2 = isdefined(level.botsettings.var_57945af2) ? level.botsettings.var_57945af2 : 0;
    level.botsettings.var_8190d80e = var_57945af2 * var_57945af2;
    var_da7f9cfc = isdefined(level.botsettings.var_da7f9cfc) ? level.botsettings.var_da7f9cfc : 1024;
    level.botsettings.var_706015f4 = var_da7f9cfc * var_da7f9cfc;
    var_cd4eae6d = isdefined(level.botsettings.var_cd4eae6d) ? level.botsettings.var_cd4eae6d : 0;
    level.botsettings.var_42d92b9d = var_cd4eae6d * var_cd4eae6d;
    var_8385083 = isdefined(level.botsettings.var_8385083) ? level.botsettings.var_8385083 : 1024;
    level.botsettings.var_833a914f = var_8385083 * var_8385083;
    level.botsettings.var_b907551c = getdvarfloat("player_swimVerticalSpeedMax");
    level.botsettings.swimtime = getdvarfloat("player_swimTime", 5) * 1000;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xf73a4a26, Offset: 0x1850
// Size: 0x22
function function_7a9265d() {
    return struct::get_script_bundle("botsettings", "bot_default");
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x11c741fd, Offset: 0x1880
// Size: 0x18
function sprint_to_goal() {
    self.bot.var_f176bd33 = 1;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x8838991, Offset: 0x18a0
// Size: 0x18
function function_e20cd351() {
    self.bot.var_f176bd33 = 0;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xfdf326d5, Offset: 0x18c0
// Size: 0x6e
function function_d991b9dc() {
    if (isdefined(self.bot.var_f176bd33) && self.bot.var_f176bd33) {
        if (self function_4fe3ba2d()) {
            self function_e20cd351();
            return;
        }
        self function_e497ac2c();
        return;
    }
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0x16d86964, Offset: 0x1938
// Size: 0x66
function function_d52328ef(trigger) {
    radius = self function_cf3a14ef(trigger);
    return distancesquared(trigger.origin, self function_5bd0f250()) <= radius * radius;
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0x8f819dd0, Offset: 0x19a8
// Size: 0x70
function function_b0d6fca1(point) {
    deltasq = distance2dsquared(self function_5bd0f250(), point);
    goalradius = self function_8154ba3();
    return deltasq <= goalradius * goalradius;
}

// Namespace bot
// Params 2, eflags: 0x1 linked
// Checksum 0xea05bb9, Offset: 0x1a20
// Size: 0x14c
function function_a5d97b55(trigger, radius) {
    if (trigger.classname == "trigger_use" || trigger.classname == "trigger_use_touch") {
        if (!isdefined(radius)) {
            radius = function_cf3a14ef(trigger);
        }
        randomangle = (0, randomint(360), 0);
        var_bc3b836 = anglestoforward(randomangle);
        point = trigger.origin + var_bc3b836 * radius;
        self function_b4a0b3c5(point);
    }
    if (!isdefined(radius)) {
        radius = 0;
    }
    self function_b4a0b3c5(trigger.origin, int(radius));
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0x21d2c2aa, Offset: 0x1b78
// Size: 0x33c
function function_1f0a2676(trigger) {
    mins = trigger getmins();
    maxs = trigger getmaxs();
    radius = min(maxs[0], maxs[1]);
    height = maxs[2] - mins[2];
    minorigin = trigger.origin + (0, 0, mins[2]);
    var_520cbd16 = height / 4;
    queryorigin = minorigin + (0, 0, var_520cbd16);
    /#
        if (getdvarint("<dev string:x28>", 0)) {
            var_d00d6cae = 10;
            circle(queryorigin, radius, (0, 1, 0), 0, 1, 20 * var_d00d6cae);
            circle(queryorigin + (0, 0, var_520cbd16), radius, (0, 1, 0), 0, 1, 20 * var_d00d6cae);
            circle(queryorigin - (0, 0, var_520cbd16), radius, (0, 1, 0), 0, 1, 20 * var_d00d6cae);
        }
    #/
    queryresult = positionquery_source_navigation(queryorigin, 0, radius, var_520cbd16, 17, self);
    best_point = undefined;
    foreach (point in queryresult.data) {
        point.score = randomfloatrange(0, 100);
        if (!isdefined(best_point) || point.score > best_point.score) {
            best_point = point;
        }
    }
    if (isdefined(best_point)) {
        self function_b4a0b3c5(best_point.origin, 24);
        return;
    }
    self function_a5d97b55(trigger, radius);
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0x7b6c1ce3, Offset: 0x1ec0
// Size: 0x7a
function function_cf3a14ef(trigger) {
    maxs = trigger getmaxs();
    if (trigger.classname == "trigger_radius") {
        return maxs[0];
    }
    return min(maxs[0], maxs[1]);
}

// Namespace bot
// Params 1, eflags: 0x0
// Checksum 0xe5dfa0b, Offset: 0x1f48
// Size: 0x68
function function_22715ac8(trigger) {
    maxs = trigger getmaxs();
    if (trigger.classname == "trigger_radius") {
        return maxs[2];
    }
    return maxs[2] * 2;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x54016300, Offset: 0x1fb8
// Size: 0x284
function function_4826a5ea() {
    /#
        if (!getdvarint("<dev string:x3d>")) {
            return;
        }
    #/
    if (self namespace_5cd60c9f::function_231137e6() && (self botundermanualcontrol() || self function_4fe3ba2d() || self util::isstunned() || self ismeleeing() || self meleebuttonpressed() || self.bot.threat.var_7ee7b150 < 16384)) {
        return;
    }
    velocity = self getvelocity();
    if (velocity[2] == 0 || velocity[0] == 0 && velocity[1] == 0 && self isplayerswimming()) {
        if (!isdefined(self.bot.var_39a761da)) {
            self.bot.var_39a761da = 0;
        }
        self.bot.var_39a761da++;
        if (self.bot.var_39a761da >= 3) {
            /#
                if (getdvarint("<dev string:x4f>", 0)) {
                    sphere(self.origin, 16, (1, 0, 0), 0.25, 0, 16, 1200);
                    iprintln("<dev string:x5e>" + self.name + "<dev string:x63>" + self.origin);
                }
            #/
            self thread function_36492c9c();
        }
    } else {
        self.bot.var_39a761da = 0;
    }
    if (!self namespace_5cd60c9f::threat_visible()) {
        self function_d2360390();
    }
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x341d4adc, Offset: 0x2248
// Size: 0x2ac
function function_d2360390() {
    if (gettime() < self.bot.var_5859452d) {
        return;
    }
    self.bot.var_5859452d = gettime() + 500;
    self.bot.var_53515354[self.bot.var_d6abf528] = self.origin;
    self.bot.var_d6abf528 = (self.bot.var_d6abf528 + 1) % 5;
    if (self.bot.var_53515354.size < 5) {
        return;
    }
    maxdistsq = undefined;
    for (i = 0; i < self.bot.var_53515354.size; i++) {
        /#
            if (getdvarint("<dev string:x4f>", 0)) {
                line(self.bot.var_53515354[i], self.bot.var_53515354[i] + (0, 0, 72), (0, 1, 0), 1, 0, 10);
            }
        #/
        for (j = i + 1; j < self.bot.var_53515354.size; j++) {
            distsq = distancesquared(self.bot.var_53515354[i], self.bot.var_53515354[j]);
            if (distsq > 16384) {
                return;
            }
        }
    }
    /#
        if (getdvarint("<dev string:x4f>", 0)) {
            sphere(self.origin, -128, (1, 0, 0), 0.25, 0, 16, 1200);
            iprintln("<dev string:x5e>" + self.name + "<dev string:x74>" + self.origin);
        }
    #/
    self thread function_36492c9c();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xeba93359, Offset: 0x2500
// Size: 0x104
function function_36492c9c() {
    self endon(#"death");
    level endon(#"game_ended");
    self function_36569909();
    self bottakemanualcontrol();
    var_7e144ff9 = self getangles()[1] + -76 + randomintrange(-60, 60);
    var_8939cf85 = anglestoforward((0, var_7e144ff9, 0));
    self function_c14cc56c(var_8939cf85);
    self botsetmovemagnitude(1);
    wait 1.5;
    self botreleasemanualcontrol();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xdc719305, Offset: 0x2610
// Size: 0x54
function function_36569909() {
    self.bot.var_39a761da = 0;
    self.bot.var_53515354 = [];
    self.bot.var_d6abf528 = 0;
    self.bot.var_5859452d = 0;
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0xc993c7f5, Offset: 0x2670
// Size: 0x3c
function camp() {
    self function_b4a0b3c5(self.origin);
    self function_d4df1076();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x7dc91e22, Offset: 0x26b8
// Size: 0x190
function function_187eccb() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        reason = self waittill(#"bot_path_failed");
        /#
            if (getdvarint("<dev string:x4f>", 0)) {
                goalposition = self function_5bd0f250();
                box(self.origin, (-15, -15, 0), (15, 15, 72), 0, (0, 1, 0), 0.25, 0, 1200);
                box(goalposition, (-15, -15, 0), (15, 15, 72), 0, (1, 0, 0), 0.25, 0, 1200);
                line(self.origin, goalposition, (1, 1, 1), 1, 0, 1200);
                iprintln("<dev string:x5e>" + self.name + "<dev string:x86>" + self.origin + "<dev string:x9a>" + goalposition);
            }
        #/
        self thread function_36492c9c();
    }
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x1d52e868, Offset: 0x2850
// Size: 0x58
function function_5b1cfb86() {
    self endon(#"death");
    level endon(#"game_ended");
    while (true) {
        reason = self waittill(#"bot_goal_reached");
        self function_36569909();
    }
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0xc9b3cc76, Offset: 0x28b0
// Size: 0xa4
function function_10fe558c() {
    currentweapon = self getcurrentweapon();
    if (self getweaponammoclip(currentweapon) || !currentweapon.isheroweapon) {
        return;
    }
    if (isdefined(self.lastdroppableweapon) && self hasweapon(self.lastdroppableweapon)) {
        self switchtoweapon(self.lastdroppableweapon);
    }
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x8b3c430e, Offset: 0x2960
// Size: 0x116
function function_506b3702() {
    weapons = self getweaponslist();
    foreach (weapon in weapons) {
        slot = self gadgetgetslot(weapon);
        if (slot < 0 || !self gadgetisready(slot) || self gadgetisactive(slot)) {
            continue;
        }
        return weapon;
    }
    return level.weaponnone;
}

// Namespace bot
// Params 0, eflags: 0x0
// Checksum 0xb0875f01, Offset: 0x2a80
// Size: 0x12e
function function_9adce54f() {
    weapons = self getweaponslist();
    foreach (weapon in weapons) {
        if (!function_fa650da1(weapon)) {
            continue;
        }
        slot = self gadgetgetslot(weapon);
        if (slot < 0 || !self gadgetisready(slot) || self gadgetisactive(slot)) {
            continue;
        }
        return weapon;
    }
    return level.weaponnone;
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0x3d28d0e7, Offset: 0x2bb8
// Size: 0x7e
function function_fa650da1(weapon) {
    if (!isdefined(weapon) || weapon == level.weaponnone || !weapon.isheroweapon) {
        return false;
    }
    return weapon.isbulletweapon || weapon.isprojectileweapon || weapon.islauncher || weapon.isgasweapon;
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0x64966e8b, Offset: 0x2c40
// Size: 0xb4
function function_cf8f9518(weapon) {
    if (!isdefined(weapon) || weapon == level.weaponnone || !weapon.isgadget) {
        return;
    }
    if (function_fa650da1(weapon)) {
        self switchtoweapon(weapon);
        return;
    }
    if (weapon.isheroweapon) {
        self function_f2781980();
        return;
    }
    self botpressbuttonforgadget(weapon);
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x7908e56c, Offset: 0x2d00
// Size: 0x140
function function_fd797() {
    self namespace_5cd60c9f::function_9fd498fd();
    if (self namespace_5cd60c9f::function_231137e6()) {
        return;
    }
    if (self isreloading() || self isswitchingweapons() || self isthrowinggrenade() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self ismeleeing() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked()) {
        return;
    }
    if (self namespace_5cd60c9f::switch_weapon()) {
        return;
    }
    if (self namespace_5cd60c9f::reload_weapon()) {
        return;
    }
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x8d061f74, Offset: 0x2e48
// Size: 0x84
function function_ea8d70a6() {
    if (self function_cc69c131()) {
        if (self namespace_5cd60c9f::function_231137e6()) {
            self namespace_5cd60c9f::function_dc473bdb();
            self function_b4a0b3c5(self.origin);
        }
        return;
    }
    self namespace_5cd60c9f::function_b5eda34();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x2be90678, Offset: 0x2ed8
// Size: 0x1bc
function function_1b93c521() {
    host = function_acc126dc();
    if (!isalive(host)) {
        players = arraysort(level.players, self.origin);
        foreach (player in players) {
            if (!player util::is_bot() && player.team == self.team && isalive(player)) {
                break;
            }
        }
    } else {
        player = host;
    }
    if (isdefined(player)) {
        fwd = anglestoforward(player.angles);
        botdir = self.origin - player.origin;
        if (vectordot(botdir, fwd) < 0) {
            self thread lead_player(player, -106);
        }
    }
}

// Namespace bot
// Params 2, eflags: 0x1 linked
// Checksum 0x83e1ac9f, Offset: 0x30a0
// Size: 0x12c
function lead_player(player, followmin) {
    radiusmin = followmin - 32;
    radiusmax = followmin;
    var_3c5efc7a = 0.85;
    var_f528834 = 0.92;
    queryresult = positionquery_source_navigation(player.origin, radiusmin, radiusmax, -106, 32, self);
    fwd = anglestoforward(player.angles);
    point = player.origin + fwd * 72;
    self function_b4a0b3c5(point, 42);
    self sprint_to_goal();
}

// Namespace bot
// Params 3, eflags: 0x0
// Checksum 0xcd932c6, Offset: 0x31d8
// Size: 0xd4
function follow_entity(entity, radiusmin, radiusmax) {
    if (!isdefined(radiusmin)) {
        radiusmin = 24;
    }
    if (!isdefined(radiusmax)) {
        radiusmax = radiusmin + 1;
    }
    if (!function_b0d6fca1(entity.origin)) {
        radius = randomintrange(radiusmin, radiusmax);
        self function_b4a0b3c5(entity.origin, radius);
        self sprint_to_goal();
    }
}

// Namespace bot
// Params 5, eflags: 0x1 linked
// Checksum 0xa7ee6018, Offset: 0x32b8
// Size: 0x544
function function_2e1b3e51(fwd, radiusmin, radiusmax, spacing, var_fad66805) {
    if (!isdefined(radiusmin)) {
        radiusmin = isdefined(level.botsettings.var_d39050ca) ? level.botsettings.var_d39050ca : 0;
    }
    if (!isdefined(radiusmax)) {
        radiusmax = isdefined(level.botsettings.var_e8aef864) ? level.botsettings.var_e8aef864 : 0;
    }
    if (!isdefined(spacing)) {
        spacing = isdefined(level.botsettings.var_fe2843a5) ? level.botsettings.var_fe2843a5 : 0;
    }
    if (!isdefined(var_fad66805)) {
        var_fad66805 = isdefined(level.botsettings.var_ba8787e6) ? level.botsettings.var_ba8787e6 : 0;
    }
    if (!isdefined(fwd)) {
        fwd = anglestoforward(self.angles);
    }
    fwd = vectornormalize((fwd[0], fwd[1], 0));
    /#
    #/
    queryresult = positionquery_source_navigation(self.origin, radiusmin, radiusmax, -106, spacing, self);
    best_point = undefined;
    origin = (self.origin[0], self.origin[1], 0);
    foreach (point in queryresult.data) {
        movepoint = (point.origin[0], point.origin[1], 0);
        movedir = vectornormalize(movepoint - origin);
        dot = vectordot(movedir, fwd);
        point.score = mapfloat(radiusmin, radiusmax, 0, 50, point.disttoorigin2d);
        if (dot > var_fad66805) {
            point.score += randomfloatrange(30, 50);
        } else if (dot > 0) {
            point.score += randomfloatrange(10, 35);
        } else {
            point.score += randomfloatrange(0, 15);
        }
        /#
        #/
        if (!isdefined(best_point) || point.score > best_point.score) {
            best_point = point;
        }
    }
    if (isdefined(best_point)) {
        /#
        #/
        self function_b4a0b3c5(best_point.origin, radiusmin);
        return;
    }
    /#
        if (getdvarint("<dev string:x4f>", 0)) {
            circle(self.origin, radiusmin, (1, 0, 0), 0, 1, 1200);
            circle(self.origin, radiusmax, (1, 0, 0), 0, 1, 1200);
            sphere(self.origin, 16, (0, 1, 0), 0.25, 0, 16, 1200);
            iprintln("<dev string:x5e>" + self.name + "<dev string:xa0>" + self.origin);
        }
    #/
    self thread function_36492c9c();
}

// Namespace bot
// Params 3, eflags: 0x1 linked
// Checksum 0x520b72d7, Offset: 0x3808
// Size: 0xf4
function function_1b1a0f98(trigger, radiusmax, spacing) {
    if (!isdefined(radiusmax)) {
        radiusmax = 1500;
    }
    if (!isdefined(spacing)) {
        spacing = -128;
    }
    distsq = distancesquared(self.origin, trigger.origin);
    if (distsq < radiusmax * radiusmax) {
        self function_1f0a2676(trigger);
        return;
    }
    radiusmin = self function_cf3a14ef(trigger);
    self function_8c37e5e2(trigger.origin, radiusmin, radiusmax, spacing);
}

// Namespace bot
// Params 4, eflags: 0x1 linked
// Checksum 0x7a8e2522, Offset: 0x3908
// Size: 0x37c
function function_8c37e5e2(point, radiusmin, radiusmax, spacing) {
    if (!isdefined(radiusmin)) {
        radiusmin = 0;
    }
    if (!isdefined(radiusmax)) {
        radiusmax = 1500;
    }
    if (!isdefined(spacing)) {
        spacing = -128;
    }
    distsq = distancesquared(self.origin, point);
    if (distsq < radiusmax * radiusmax) {
        self function_b4a0b3c5(point, 24);
        return;
    }
    queryresult = positionquery_source_navigation(point, radiusmin, radiusmax, -106, spacing, self);
    fwd = anglestoforward(self.angles);
    fwd = (fwd[0], fwd[1], 0);
    origin = (self.origin[0], self.origin[1], 0);
    best_point = undefined;
    foreach (point in queryresult.data) {
        movepoint = (point.origin[0], point.origin[1], 0);
        movedir = vectornormalize(movepoint - origin);
        dot = vectordot(movedir, fwd);
        point.score = randomfloatrange(0, 50);
        if (dot < 0.5) {
            point.score += randomfloatrange(30, 50);
        } else {
            point.score += randomfloatrange(0, 15);
        }
        if (!isdefined(best_point) || point.score > best_point.score) {
            best_point = point;
        }
    }
    if (isdefined(best_point)) {
        self function_b4a0b3c5(best_point.origin, 24);
    }
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0xeaa81190, Offset: 0x3c90
// Size: 0x5c
function function_cc69c131() {
    players = self function_7872332d();
    if (players.size > 0) {
        revive_player(players[0]);
        return true;
    }
    return false;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x28b517dc, Offset: 0x3cf8
// Size: 0xfc
function function_7872332d() {
    players = [];
    foreach (player in level.players) {
        if (player != self && player laststand::player_is_in_laststand() && player.team == self.team) {
            players[players.size] = player;
        }
    }
    players = arraysort(players, self.origin);
    return players;
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0xd42b2ba8, Offset: 0x3e00
// Size: 0xc4
function revive_player(player) {
    if (!function_b0d6fca1(player.origin)) {
        self function_b4a0b3c5(player.origin, 64);
        self sprint_to_goal();
        return;
    }
    if (self function_4fe3ba2d()) {
        self function_546ecee9(player getcentroid());
        self function_ec17d837();
    }
}

// Namespace bot
// Params 2, eflags: 0x0
// Checksum 0x63b22886, Offset: 0x3ed0
// Size: 0x170
function function_7ff6d5f0(var_5c0a8960, cornerdist) {
    self endon(#"death");
    self endon(#"hash_3f789ced");
    level endon(#"game_ended");
    if (!isdefined(var_5c0a8960)) {
        var_5c0a8960 = 64;
    }
    if (!isdefined(cornerdist)) {
        cornerdist = -128;
    }
    var_9af44998 = cornerdist * cornerdist;
    var_686adc0a = cornerdist * cornerdist;
    while (true) {
        centerpoint, var_299d2679, leavepoint, angle, var_2670a60a = self waittill(#"bot_corner");
        if (self namespace_5cd60c9f::function_231137e6()) {
            continue;
        }
        if (distance2dsquared(self.origin, var_299d2679) < var_9af44998 || distance2dsquared(leavepoint, var_2670a60a) < var_686adc0a) {
            continue;
        }
        self thread function_73658497(var_9af44998, centerpoint, var_299d2679, leavepoint, angle, var_2670a60a);
    }
}

// Namespace bot
// Params 6, eflags: 0x1 linked
// Checksum 0xfe82edd, Offset: 0x4048
// Size: 0x10c
function function_73658497(var_9af44998, centerpoint, var_299d2679, leavepoint, angle, var_2670a60a) {
    self endon(#"death");
    self endon(#"bot_corner");
    self endon(#"bot_goal_reached");
    self endon(#"hash_3f789ced");
    level endon(#"game_ended");
    while (distance2dsquared(self.origin, var_299d2679) > var_9af44998) {
        if (self namespace_5cd60c9f::function_231137e6()) {
            return;
        }
        wait 0.05;
    }
    self botlookatpoint((var_2670a60a[0], var_2670a60a[1], var_2670a60a[1] + 60));
    self thread function_ddce1c40();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x3e052610, Offset: 0x4160
// Size: 0x64
function function_ddce1c40() {
    self endon(#"death");
    self endon(#"hash_1408013");
    level endon(#"game_ended");
    self util::waittill_any("bot_corner", "bot_goal_reached");
    self function_66d6ef34();
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x33006195, Offset: 0x41d0
// Size: 0xac
function function_acc126dc() {
    players = getplayers();
    foreach (player in players) {
        if (player ishost()) {
            return player;
        }
    }
    return undefined;
}

// Namespace bot
// Params 1, eflags: 0x1 linked
// Checksum 0x88446226, Offset: 0x4288
// Size: 0xc4
function fwd_dot(point) {
    angles = self getplayerangles();
    fwd = anglestoforward(angles);
    delta = point - self geteye();
    delta = vectornormalize(delta);
    dot = vectordot(fwd, delta);
    return dot;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x6807058c, Offset: 0x4358
// Size: 0xb0
function has_launcher() {
    weapons = self getweaponslist();
    foreach (weapon in weapons) {
        if (weapon.isrocketlauncher) {
            return true;
        }
    }
    return false;
}

// Namespace bot
// Params 0, eflags: 0x1 linked
// Checksum 0x5a9a61f7, Offset: 0x4410
// Size: 0x2c
function function_8e07117() {
    self dodamage(self.health, self.origin);
}

/#

    // Namespace bot
    // Params 0, eflags: 0x1 linked
    // Checksum 0x5405430a, Offset: 0x4448
    // Size: 0xaa
    function kill_bots() {
        foreach (player in level.players) {
            if (player util::is_bot()) {
                player function_8e07117();
            }
        }
    }

    // Namespace bot
    // Params 1, eflags: 0x1 linked
    // Checksum 0xf51cea5b, Offset: 0x4500
    // Size: 0x15a
    function function_9fda6f90(team) {
        host = util::gethostplayer();
        trace = host eye_trace();
        direction_vec = host.origin - trace["<dev string:xbe>"];
        direction = vectortoangles(direction_vec);
        yaw = direction[1];
        bot = add_bot(team);
        if (isdefined(bot)) {
            bot waittill(#"spawned_player");
            bot setorigin(trace["<dev string:xbe>"]);
            bot setplayerangles((bot.angles[0], yaw, bot.angles[2]));
        }
        return bot;
    }

    // Namespace bot
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa97d49df, Offset: 0x4668
    // Size: 0xd4
    function eye_trace() {
        direction = self getplayerangles();
        direction_vec = anglestoforward(direction);
        eye = self geteye();
        scale = 8000;
        direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
        return bullettrace(eye, eye + direction_vec, 0, undefined);
    }

    // Namespace bot
    // Params 0, eflags: 0x1 linked
    // Checksum 0xba222abc, Offset: 0x4748
    // Size: 0x152
    function function_d20cb955() {
        iprintln("<dev string:xc7>");
        points = self function_f486e6e9();
        if (!isdefined(points) || points.size == 0) {
            iprintln("<dev string:xd5>");
            return;
        }
        iprintln("<dev string:xeb>");
        players = getplayers();
        foreach (player in players) {
            if (!player util::is_bot()) {
                continue;
            }
            player thread function_9d163ef3(points);
        }
    }

    // Namespace bot
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa866648f, Offset: 0x48a8
    // Size: 0x22a
    function function_f486e6e9() {
        iprintln("<dev string:x109>");
        iprintln("<dev string:x120>");
        iprintln("<dev string:x131>");
        points = [];
        while (true) {
            wait 0.05;
            point = self eye_trace()["<dev string:xbe>"];
            if (isdefined(point)) {
                point = getclosestpointonnavmesh(point, -128);
                if (isdefined(point)) {
                    sphere(point, 16, (0, 0, 1), 0.25, 0, 16, 1);
                }
            }
            if (self buttonpressed("<dev string:x145>")) {
                if (points.size == 0 || isdefined(point) && distance2d(point, points[points.size - 1]) > 16) {
                    points[points.size] = point;
                }
            } else if (self buttonpressed("<dev string:x14e>")) {
                return points;
            } else if (self buttonpressed("<dev string:x157>")) {
                return undefined;
            }
            for (i = 0; i < points.size; i++) {
                sphere(points[i], 16, (0, 1, 0), 0.25, 0, 16, 1);
            }
        }
    }

    // Namespace bot
    // Params 1, eflags: 0x1 linked
    // Checksum 0xbb172ebe, Offset: 0x4ae0
    // Size: 0xb4
    function function_9d163ef3(points) {
        self notify(#"hash_9d163ef3");
        self endon(#"death");
        self endon(#"hash_9d163ef3");
        for (i = 0; true; i = (i + 1) % points.size) {
            self function_b4a0b3c5(points[i], 24);
            self sprint_to_goal();
            self waittill(#"bot_goal_reached");
        }
    }

    // Namespace bot
    // Params 0, eflags: 0x1 linked
    // Checksum 0x11e3e8fd, Offset: 0x4ba0
    // Size: 0x128
    function function_58ff286c() {
        while (true) {
            wait 0.25;
            cmd = getdvarstring("<dev string:x160>", "<dev string:x16b>");
            if (!isdefined(level.var_f61e96da) || ![[ level.var_f61e96da ]](cmd)) {
                host = util::gethostplayer();
                switch (cmd) {
                case "<dev string:x16c>":
                    remove_bots();
                    break;
                case "<dev string:x177>":
                    kill_bots();
                    break;
                case "<dev string:x181>":
                    host function_d20cb955();
                    break;
                default:
                    break;
                }
            }
            setdvar("<dev string:x160>", "<dev string:x16b>");
        }
    }

    // Namespace bot
    // Params 1, eflags: 0x1 linked
    // Checksum 0xcbafbddd, Offset: 0x4cd0
    // Size: 0xf2
    function function_ca7aa540(cmd) {
        host = function_acc126dc();
        switch (cmd) {
        case "<dev string:x188>":
            add_bot(host.team);
            return 1;
        case "<dev string:x18c>":
            add_bots(3, host.team);
            return 1;
        case "<dev string:x192>":
            function_9fda6f90();
            return 1;
        case "<dev string:x1a0>":
            remove_bots(1);
            return 1;
        }
        return 0;
    }

    // Namespace bot
    // Params 3, eflags: 0x0
    // Checksum 0x6dbfb4d4, Offset: 0x4dd0
    // Size: 0x8c
    function debug_star(origin, seconds, color) {
        if (!isdefined(seconds)) {
            seconds = 1;
        }
        if (!isdefined(color)) {
            color = (1, 0, 0);
        }
        frames = int(20 * seconds);
        debugstar(origin, frames, color);
    }

#/
