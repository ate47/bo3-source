#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreak_detect;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_helicopter;
#using scripts/mp/teams/_teams;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/shared/weapons/_smokegrenade;
#using scripts/shared/vehicles/_raps;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;

#namespace raps_mp;

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0x479c4c6a, Offset: 0x890
// Size: 0x2aa
function init() {
    level.var_d90be9a7 = level.scriptbundles["vehiclecustomsettings"]["rapssettings_mp"];
    assert(isdefined(level.var_d90be9a7));
    level.raps = [];
    level.var_5b16765a = [];
    level.var_a5ae5b79 = &function_778dcc4e;
    killstreaks::register("raps", "raps", "killstreak_raps", "raps_used", &function_5460b070, 1);
    killstreaks::function_f79fd1e9("raps", %KILLSTREAK_EARNED_RAPS, %KILLSTREAK_RAPS_NOT_AVAILABLE, %KILLSTREAK_RAPS_INBOUND, undefined, %KILLSTREAK_RAPS_HACKED);
    killstreaks::register_dialog("raps", "mpl_killstreak_raps", "rapsHelicopterDialogBundle", "rapsHelicopterPilotDialogBundle", "friendlyRaps", "enemyRaps", "enemyRapsMultiple", "friendlyRapsHacked", "enemyRapsHacked", "requestRaps", "threatRaps");
    killstreaks::allow_assists("raps", 1);
    killstreaks::register_dev_debug_dvar("raps");
    killstreak_bundles::register_killstreak_bundle("raps_drone");
    function_be423bbc();
    callback::on_connect(&onplayerconnect);
    clientfield::register("vehicle", "monitor_raps_drop_landing", 1, 1, "int");
    clientfield::register("vehicle", "raps_heli_low_health", 1, 1, "int");
    clientfield::register("vehicle", "raps_heli_extra_low_health", 1, 1, "int");
    level.var_443ea6dd = [];
    level.var_443ea6dd[0] = "tag_raps_drop_left";
    level.var_443ea6dd[1] = "tag_raps_drop_right";
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0xe0b34048, Offset: 0xb48
// Size: 0xa2
function onplayerconnect() {
    self.entnum = self getentitynumber();
    level.raps[self.entnum] = spawnstruct();
    level.raps[self.entnum].killstreak_id = -1;
    level.raps[self.entnum].raps = [];
    level.raps[self.entnum].helicopter = undefined;
}

// Namespace raps_mp
// Params 0, eflags: 0x0
// Checksum 0xbc213822, Offset: 0xbf8
// Size: 0x6c
function function_545e4541() {
    level endon(#"game_ended");
    var_209020f = 0;
    while (true) {
        function_680281ce(var_209020f);
        var_209020f++;
        if (var_209020f >= level.var_5b16765a.size) {
            var_209020f = 0;
        }
        wait 0.05;
    }
}

// Namespace raps_mp
// Params 1, eflags: 0x1 linked
// Checksum 0x656151f7, Offset: 0xc70
// Size: 0xa8c
function function_680281ce(var_209020f) {
    var_db38a403 = (0, 0, 0);
    var_8191a1cf = (0, 0, 0);
    arrayremovevalue(level.var_5b16765a, undefined);
    if (var_209020f >= level.var_5b16765a.size) {
        var_209020f = 0;
    }
    if (level.var_5b16765a.size >= 2) {
        helicopter = level.var_5b16765a[var_209020f];
        /#
            helicopter.var_f424f1ba = 0;
        #/
        for (i = 0; i < level.var_5b16765a.size; i++) {
            if (i == var_209020f) {
                continue;
            }
            if (helicopter.var_56adcf6e) {
                continue;
            }
            if (!isdefined(helicopter.var_c20d34eb)) {
                helicopter.var_c20d34eb = gettime();
            }
            var_d5d4949 = anglestoforward(helicopter getangles());
            var_db38a403 = helicopter.origin + var_d5d4949 * 500;
            var_2300e6d = anglestoforward(level.var_5b16765a[i] getangles());
            var_8191a1cf = level.var_5b16765a[i].origin + var_2300e6d * 100;
            var_cd32afa0 = var_8191a1cf - var_db38a403;
            var_42db037d = vectordot(var_d5d4949, vectornormalize(var_cd32afa0)) > 0.707;
            distancesqr = distance2dsquared(var_db38a403, var_8191a1cf);
            if ((distancesqr < (-56 + 1200) * (-56 + 1200) || helicopter getspeed() == 0) && gettime() - helicopter.var_c20d34eb > 5000) {
                /#
                    helicopter.var_c8acdf63 = 20;
                #/
                /#
                    helicopter.var_f424f1ba = 1;
                #/
                helicopter function_951920c2();
                if (helicopter.isleaving) {
                    self.var_1fef8d2b = function_f3f428f0(0, self.origin);
                    helicopter setvehgoalpos(self.var_1fef8d2b, 0);
                } else {
                    self.var_e126350 = function_67f820d0(self.var_93a4ef87);
                    helicopter setvehgoalpos(self.var_e126350, 1);
                }
                helicopter.var_c20d34eb = gettime();
                continue;
            }
            if (distancesqr < 1200 * 1200 && var_42db037d && gettime() - helicopter.var_1c4cd292 > 500) {
                /#
                    helicopter.var_c8acdf63 = 10;
                #/
                /#
                    helicopter.var_f424f1ba = 1;
                #/
                helicopter function_43b54fe2();
                continue;
            }
            if (helicopter getspeed() == 0 && var_42db037d && distancesqr < 1200 * 1200) {
                /#
                    helicopter.var_c8acdf63 = 50;
                #/
                /#
                    helicopter.var_f424f1ba = 1;
                #/
                delta = var_8191a1cf - var_db38a403;
                var_8e2d0689 = helicopter.origin - (var_cd32afa0[0] * randomfloatrange(0.7, 2.5), var_cd32afa0[1] * randomfloatrange(0.7, 2.5), 0);
                helicopter function_951920c2();
                helicopter setvehgoalpos(var_8e2d0689, 0);
                if (1 || gettime() - helicopter.var_c20d34eb > 5000) {
                    /#
                        helicopter.var_c8acdf63 = 51;
                    #/
                    helicopter.var_e126350 = function_8e67ae2b(var_8e2d0689, 8);
                    helicopter.var_c20d34eb = gettime();
                }
                continue;
            }
            if (distancesqr < (1000 + -56 + 1200) * (1000 + -56 + 1200) && helicopter.var_c6ede233 == 1) {
                /#
                    helicopter.var_c8acdf63 = var_42db037d ? 31 : 30;
                #/
                /#
                    helicopter.var_f424f1ba = 1;
                #/
                helicopter function_951920c2(var_42db037d ? 2 : 1);
                continue;
            }
            if (distancesqr >= (1000 + -56 + 1200) * (1000 + -56 + 1200) && helicopter.var_c6ede233 < 1) {
                /#
                    helicopter.var_c8acdf63 = 40;
                #/
                /#
                    helicopter.var_f424f1ba = 1;
                #/
                helicopter function_951920c2(0);
                continue;
            }
            if (helicopter getspeed() == 0 && gettime() - helicopter.var_1c4cd292 > 500) {
                helicopter function_951920c2();
            }
        }
        /#
            if (getdvarint("<dev string:x28>")) {
                if (isdefined(helicopter)) {
                    var_30632b02 = int(0.05 * 2 / 0.05);
                    sphere(var_db38a403, 10, (0, 0, 1), 1, 0, 10, var_30632b02);
                    sphere(var_8191a1cf, 10, (1, 0, 0), 1, 0, 10, var_30632b02);
                    circle(var_db38a403, 1000 + -56 + 1200, (1, 1, 0), 1, 1, var_30632b02);
                    circle(var_db38a403, -56 + 1200, (0, 0, 0), 1, 1, var_30632b02);
                    circle(var_db38a403, 1200, (1, 0, 0), 1, 1, var_30632b02);
                    print3d(helicopter.origin, "<dev string:x3d>" + int(helicopter getspeedmph()), (1, 1, 1), 1, 2.5, var_30632b02);
                    var_cb111a4f = (0.8, 0.8, 0.8);
                    var_ab924519 = "<dev string:x45>";
                    if (helicopter.var_f424f1ba) {
                        var_cb111a4f = (0, 1, 0);
                    }
                    switch (helicopter.var_c8acdf63) {
                    case 0:
                        break;
                    case 10:
                        var_ab924519 = "<dev string:x46>";
                        break;
                    case 20:
                        var_ab924519 = "<dev string:x4b>";
                        break;
                    case 30:
                        var_ab924519 = "<dev string:x54>";
                        break;
                    case 31:
                        var_ab924519 = "<dev string:x5d>";
                        break;
                    case 40:
                        var_ab924519 = "<dev string:x6b>";
                        break;
                    case 50:
                        var_ab924519 = "<dev string:x75>";
                        break;
                    case 51:
                        var_ab924519 = "<dev string:x7e>";
                        break;
                    default:
                        var_ab924519 = "<dev string:x92>";
                        break;
                    }
                    print3d(helicopter.origin + (0, 0, -50), var_ab924519, var_cb111a4f, 1, 2.5, var_30632b02);
                }
            }
        #/
    }
}

// Namespace raps_mp
// Params 1, eflags: 0x1 linked
// Checksum 0x9d2428b5, Offset: 0x1708
// Size: 0x388
function function_5460b070(hardpointtype) {
    player = self;
    if (!player killstreakrules::iskillstreakallowed("raps", player.team)) {
        return false;
    }
    if (game["raps_helicopter_positions"].size <= 0) {
        /#
            iprintlnbold("<dev string:xa1>");
        #/
        self iprintlnbold(%KILLSTREAK_RAPS_NOT_AVAILABLE);
        return false;
    }
    killstreakid = player killstreakrules::killstreakstart("raps", player.team);
    if (killstreakid == -1) {
        player iprintlnbold(%KILLSTREAK_RAPS_NOT_AVAILABLE);
        return false;
    }
    player thread teams::waituntilteamchange(player, &onteamchanged, player.entnum, "raps_complete");
    level thread function_186452c3(killstreakid, player.entnum, player.team);
    helicopter = player function_c46ec6d9(killstreakid);
    helicopter.killstreakid = killstreakid;
    player killstreaks::play_killstreak_start_dialog("raps", player.team, killstreakid);
    player addweaponstat(getweapon("raps"), "used", 1);
    helicopter killstreaks::play_pilot_dialog_on_owner("arrive", "raps", killstreakid);
    level.raps[player.entnum].helicopter = helicopter;
    if (!isdefined(level.var_5b16765a)) {
        level.var_5b16765a = [];
    } else if (!isarray(level.var_5b16765a)) {
        level.var_5b16765a = array(level.var_5b16765a);
    }
    level.var_5b16765a[level.var_5b16765a.size] = level.raps[player.entnum].helicopter;
    level thread function_77b5c802(level.raps[player.entnum].helicopter, player.entnum);
    /#
        if (getdvarint("<dev string:xd0>")) {
            level thread function_c059f8aa(player.entnum, player, hardpointtype);
        }
    #/
    return true;
}

/#

    // Namespace raps_mp
    // Params 3, eflags: 0x1 linked
    // Checksum 0x6166109, Offset: 0x1a98
    // Size: 0x9a
    function function_c059f8aa(ownerentnum, player, hardpointtype) {
        while (true) {
            level waittill("<dev string:xef>" + ownerentnum);
            if (isdefined(level.raps[ownerentnum].helicopter)) {
                continue;
            }
            wait randomfloatrange(2, 5);
            player thread function_5460b070(hardpointtype);
            return;
        }
    }

#/

// Namespace raps_mp
// Params 3, eflags: 0x1 linked
// Checksum 0x210a7c97, Offset: 0x1b40
// Size: 0x82
function function_186452c3(killstreakid, ownerentnum, team) {
    while (true) {
        level waittill("raps_updated_" + ownerentnum);
        if (isdefined(level.raps[ownerentnum].helicopter)) {
            continue;
        }
        killstreakrules::killstreakstop("raps", team, killstreakid);
        return;
    }
}

// Namespace raps_mp
// Params 2, eflags: 0x1 linked
// Checksum 0xaaf12b68, Offset: 0x1bd0
// Size: 0x34
function function_77b5c802(helicopter, var_aea70e9a) {
    helicopter waittill(#"death");
    level notify("raps_updated_" + var_aea70e9a);
}

// Namespace raps_mp
// Params 2, eflags: 0x1 linked
// Checksum 0x949d64ef, Offset: 0x1c10
// Size: 0x44
function onteamchanged(entnum, event) {
    abandoned = 1;
    function_b6ac9c42(entnum, abandoned);
}

// Namespace raps_mp
// Params 2, eflags: 0x0
// Checksum 0x5f3613f2, Offset: 0x1c60
// Size: 0x2c
function onemp(attacker, ownerentnum) {
    function_b6ac9c42(ownerentnum);
}

// Namespace raps_mp
// Params 2, eflags: 0x1 linked
// Checksum 0xd966cb85, Offset: 0x1c98
// Size: 0x44
function function_9792beeb(mapcenter, radius) {
    level endon(#"game_ended");
    wait 3;
    marknovehiclenavmeshfaces(mapcenter, radius, 21);
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0xff5fd701, Offset: 0x1ce8
// Size: 0x1042
function function_be423bbc() {
    var_df147c7f = airsupport::getmapcenter();
    mapcenter = getclosestpointonnavmesh(var_df147c7f, 1024);
    if (!isdefined(mapcenter)) {
        var_df147c7f = (var_df147c7f[0], var_df147c7f[1], 0);
    }
    for (var_f303338c = 10; !isdefined(mapcenter) && var_f303338c > 0; var_f303338c -= 1) {
        var_df147c7f += (100, 100, 0);
        mapcenter = getclosestpointonnavmesh(var_df147c7f, 1024);
    }
    if (!isdefined(mapcenter)) {
        mapcenter = airsupport::getmapcenter();
    }
    radius = airsupport::getmaxmapwidth();
    if (radius < 1) {
        radius = 1;
    }
    if (isdefined(game["raps_helicopter_positions"])) {
        return;
    }
    var_3865b85f = 1024;
    var_86dbc849 = util::positionquery_pointarray(mapcenter, 0, radius * 3, var_3865b85f, -124);
    if (var_86dbc849.size == 0) {
        mapcenter = (0, 0, 39);
        var_86dbc849 = util::positionquery_pointarray(mapcenter, 0, radius, 70, -124);
    }
    /#
        var_c68ebeef = var_86dbc849.size;
    #/
    if (isdefined(level.var_7bb6ebae)) {
        [[ level.var_7bb6ebae ]](var_86dbc849);
    }
    /#
        if (getdvarint("<dev string:xfd>")) {
            var_96bd7e9 = -36 * 0.25;
            for (i = var_c68ebeef; i < var_86dbc849.size; i++) {
                box(var_86dbc849[i], (var_96bd7e9 * -1, var_96bd7e9 * -1, 0), (var_96bd7e9, var_96bd7e9, 8.88), 0, (1, 0.53, 0), 0.9, 0, 9999999);
            }
        }
    #/
    var_6480c733 = [];
    if (isdefined(level.var_c9aa825e)) {
        [[ level.var_c9aa825e ]](var_6480c733);
    }
    /#
        if (getdvarint("<dev string:xfd>")) {
            var_a5ca80a3 = -36 * 0.5;
            foreach (var_df63c58 in var_6480c733) {
                circle(var_df63c58, var_a5ca80a3, (0.05, 0.05, 0.05), 0, 1, 9999999);
                circle(var_df63c58 + (0, 0, 4), var_a5ca80a3, (0.05, 0.05, 0.05), 0, 1, 9999999);
                circle(var_df63c58 + (0, 0, 8), var_a5ca80a3, (0.05, 0.05, 0.05), 0, 1, 9999999);
            }
        }
    #/
    game["raps_helicopter_positions"] = [];
    minflyheight = int(airsupport::getminimumflyheight() + 1000);
    var_b36131cf = 12;
    var_d8f1a0cb = -36 * 0.5;
    var_cfe49d99 = var_d8f1a0cb * 0.7071;
    var_74a97cb7 = -36 * 0.5;
    foreach (point in var_86dbc849) {
        var_8250393d = point + (0, 0, 6);
        var_78704a23 = point + (0, 0, 8);
        trace = physicstrace(var_8250393d, var_78704a23, (-2, -2, -2), (2, 2, 2), undefined, 4);
        if (trace["fraction"] < 1) {
            /#
                if (getdvarint("<dev string:xfd>")) {
                    var_53e61bf7 = -36 * 0.5;
                    var_53098c6c = 10;
                    box(var_8250393d, (var_53e61bf7 * -1, var_53e61bf7 * -1, 0), (var_53e61bf7, var_53e61bf7, var_53098c6c), 0, (0, 0, 1), 0.9, 0, 9999999);
                    box(var_8250393d, (-2, -2, -2), (2, 2, 2), 0, (0, 0, 1), 0.9, 0, 9999999);
                }
            #/
            continue;
        }
        var_49985128 = 0;
        foreach (var_df63c58 in var_6480c733) {
            if (distancesquared(var_df63c58, point) < var_74a97cb7 * var_74a97cb7) {
                var_49985128 = 1;
                /#
                    if (getdvarint("<dev string:xfd>")) {
                        var_53e61bf7 = -36 * 0.5;
                        var_53098c6c = 10;
                        box(point, (var_53e61bf7 * -1, var_53e61bf7 * -1, 0), (var_53e61bf7, var_53e61bf7, var_53098c6c), 0, (0.05, 0.05, 0.05), 1, 0, 9999999);
                    }
                #/
                break;
            }
        }
        if (var_49985128) {
            continue;
        }
        var_111b13d1 = util::positionquery_pointarray(point, 0, -128, var_3865b85f, var_b36131cf);
        var_155add32 = 12;
        var_47431ce = 0;
        for (i = 0; !var_47431ce && i < var_155add32 && i < var_111b13d1.size; i++) {
            test_point = var_111b13d1[i];
            var_cbdf83df = ispointonnavmesh(test_point + (0, var_d8f1a0cb, 0), 0) && ispointonnavmesh(test_point + (0, var_d8f1a0cb * -1, 0), 0) && ispointonnavmesh(test_point + (var_d8f1a0cb, 0, 0), 0) && ispointonnavmesh(test_point + (var_d8f1a0cb * -1, 0, 0), 0) && ispointonnavmesh(test_point + (var_cfe49d99, var_cfe49d99, 0), 0) && ispointonnavmesh(test_point + (var_cfe49d99, var_cfe49d99 * -1, 0), 0) && ispointonnavmesh(test_point + (var_cfe49d99 * -1, var_cfe49d99, 0), 0) && ispointonnavmesh(test_point + (var_cfe49d99 * -1, var_cfe49d99 * -1, 0), 0);
            if (var_cbdf83df) {
                var_47431ce = function_d22632d8(test_point, minflyheight);
            }
        }
    }
    if (game["raps_helicopter_positions"].size == 0) {
        /#
            iprintlnbold("<dev string:x11c>");
        #/
        game["raps_helicopter_positions"] = var_86dbc849;
    }
    var_c9dc5783 = undefined;
    var_8be88225 = 9999999;
    foreach (point in game["raps_helicopter_positions"]) {
        if (!isdefined(point)) {
            continue;
        }
        distance_squared = distancesquared(point, mapcenter);
        if (distance_squared < var_8be88225) {
            var_8be88225 = distance_squared;
            var_c9dc5783 = point;
        }
    }
    if (!isdefined(var_c9dc5783)) {
        var_c9dc5783 = mapcenter;
    }
    level thread function_9792beeb(var_c9dc5783, radius * 2);
    var_11996713 = 0;
    /#
        if (killstreaks::should_draw_debug("<dev string:x16f>") || var_11996713) {
            time = 9999999;
            sphere(mapcenter, 20, (1, 1, 0), 1, 0, 10, time);
            circle(mapcenter, airsupport::getmaxmapwidth(), (0, 1, 0), 1, 1, time);
            box(mapcenter, (-4, -4, 0), (4, 4, 5000), 0, (1, 1, 0), 0.6, 0, time);
            sphere(var_c9dc5783, 20, (0, 1, 1), 1, 0, 10, time);
            box(var_c9dc5783, (-4, -4, 0), (4, 4, 4200), 0, (0, 1, 1), 0.6, 0, time);
            foreach (point in var_86dbc849) {
                sphere(point + (0, 0, 950), 10, (0, 0, 1), 1, 0, 10, time);
                circle(point, -128, (1, 0, 0), 1, 1, time);
            }
            foreach (point in game["<dev string:x174>"]) {
                sphere(point + (0, 0, 1000), 10, (0, 1, 0), 1, 0, 10, time);
                circle(point + (0, 0, 2), -128, (0, 1, 0), 1, 1, time);
                airsupport::debug_cylinder(point, 8, 1000, (0, 0.8, 0), 16, time);
                box(point, (-4, -4, 0), (4, 4, 1000), 0, (0, 0.7, 0), 0.6, 0, time);
                var_7e47193 = -36 * 0.5;
                box(point, (var_7e47193 * -1, var_7e47193 * -1, 2), (var_7e47193, var_7e47193, 300), 0, (0, 0, 0.6), 0.6, 0, time);
            }
        }
    #/
}

// Namespace raps_mp
// Params 2, eflags: 0x1 linked
// Checksum 0xb7ed0d3c, Offset: 0x2d38
// Size: 0xfe
function function_d22632d8(var_860eff5e, minflyheight) {
    traceheight = minflyheight + 500;
    var_4eae6920 = -36 * 0.5;
    if (function_d1a2bb6a(var_860eff5e, traceheight, var_4eae6920)) {
        if (!isdefined(game["raps_helicopter_positions"])) {
            game["raps_helicopter_positions"] = [];
        } else if (!isarray(game["raps_helicopter_positions"])) {
            game["raps_helicopter_positions"] = array(game["raps_helicopter_positions"]);
        }
        game["raps_helicopter_positions"][game["raps_helicopter_positions"].size] = var_860eff5e;
        return true;
    }
    return false;
}

// Namespace raps_mp
// Params 3, eflags: 0x1 linked
// Checksum 0x27f4c236, Offset: 0x2e40
// Size: 0x208
function function_d1a2bb6a(var_860eff5e, traceheight, var_4eae6920) {
    start = (var_860eff5e[0], var_860eff5e[1], traceheight);
    end = (var_860eff5e[0], var_860eff5e[1], var_860eff5e[2] + 36);
    trace = physicstrace(start, end, (var_4eae6920 * -1, var_4eae6920 * -1, 0), (var_4eae6920, var_4eae6920, var_4eae6920 * 2), undefined, 1);
    /#
        if (getdvarint("<dev string:xfd>")) {
            if (trace["<dev string:x18e>"] < 1) {
                box(end, (var_4eae6920 * -1, var_4eae6920 * -1, 0), (var_4eae6920, var_4eae6920, (start[2] - end[2]) * (1 - trace["<dev string:x18e>"])), 0, (1, 0, 0), 0.6, 0, 9999999);
            } else {
                box(end, (var_4eae6920 * -1, var_4eae6920 * -1, 0), (var_4eae6920, var_4eae6920, 8.88), 0, (0, 1, 0), 0.6, 0, 9999999);
            }
        }
    #/
    return trace["fraction"] == 1 && trace["surfacetype"] == "none";
}

// Namespace raps_mp
// Params 2, eflags: 0x1 linked
// Checksum 0xf4e38a78, Offset: 0x3050
// Size: 0x52
function getrandomhelicopterstartorigin(fly_height, var_b07e8923) {
    best_node = helicopter::getvalidrandomstartnode(var_b07e8923);
    return best_node.origin + (0, 0, fly_height);
}

// Namespace raps_mp
// Params 2, eflags: 0x1 linked
// Checksum 0xb7cfe505, Offset: 0x30b0
// Size: 0x52
function function_f3f428f0(fly_height, var_abcf3c0e) {
    best_node = helicopter::getvalidrandomleavenode(var_abcf3c0e);
    return best_node.origin + (0, 0, fly_height);
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0x1b8c3df, Offset: 0x3110
// Size: 0x114
function function_734db218() {
    arrayremovevalue(level.var_5b16765a, undefined);
    var_67bf3635 = airsupport::getminimumflyheight();
    if (level.var_5b16765a.size > 0) {
        var_996f5220 = level.var_5b16765a[0].var_2cea7feb;
        if (var_996f5220 == var_67bf3635 + int(airsupport::getminimumflyheight() + 1000)) {
            return (var_67bf3635 + int(airsupport::getminimumflyheight() + 1000) + 400);
        }
    }
    return var_67bf3635 + int(airsupport::getminimumflyheight() + 1000);
}

// Namespace raps_mp
// Params 2, eflags: 0x1 linked
// Checksum 0x34c0e48a, Offset: 0x3230
// Size: 0x54
function configurechopperteampost(owner, ishacked) {
    helicopter = self;
    helicopter thread watchownerdisconnect(owner);
    helicopter thread function_92d02a83();
}

// Namespace raps_mp
// Params 1, eflags: 0x1 linked
// Checksum 0x378bdef3, Offset: 0x3290
// Size: 0x4e8
function function_c46ec6d9(killstreakid) {
    player = self;
    var_2cea7feb = function_734db218();
    var_d1046bd2 = function_7ab1ac37(undefined, 0, player.origin, var_2cea7feb);
    spawnorigin = getrandomhelicopterstartorigin(0, var_d1046bd2);
    helicopter = spawnhelicopter(player, spawnorigin, (0, 0, 0), "heli_raps_mp", "veh_t7_mil_vtol_dropship_raps");
    helicopter.var_d1046bd2 = var_d1046bd2;
    helicopter.var_2cea7feb = var_2cea7feb;
    helicopter killstreaks::configure_team("raps", killstreakid, player, undefined, undefined, &configurechopperteampost);
    helicopter killstreak_hacking::enable_hacking("raps");
    helicopter.var_56adcf6e = 0;
    helicopter.isleaving = 0;
    helicopter.var_12e45979 = 0;
    helicopter.var_c6ede233 = 3;
    helicopter.var_72eff24a = 20 * 5;
    helicopter.var_5ee7ff51 = 20 * 5;
    helicopter.var_1c4cd292 = 0;
    helicopter.var_e126350 = (-1e+07, -1e+07, -1e+07);
    helicopter.var_93a4ef87 = (-1e+07, -1e+07, -1e+07);
    helicopter.var_3e19b7ed = (player.origin[0], player.origin[1], int(airsupport::getminimumflyheight() + 1000));
    /#
        helicopter.var_c8acdf63 = 0;
    #/
    helicopter clientfield::set("enemyvehicle", 1);
    helicopter.health = 99999999;
    helicopter.maxhealth = killstreak_bundles::get_max_health("raps");
    helicopter.lowhealth = killstreak_bundles::get_low_health("raps");
    helicopter.extra_low_health = helicopter.lowhealth * 0.5;
    helicopter.extra_low_health_callback = &function_c161d20;
    helicopter setcandamage(1);
    helicopter thread killstreaks::monitordamage("raps", helicopter.maxhealth, &ondeath, helicopter.lowhealth, &onlowhealth, 0, undefined, 1);
    helicopter.rocketdamage = helicopter.maxhealth / 4 + 1;
    helicopter.remotemissiledamage = helicopter.maxhealth / 1 + 1;
    helicopter.hackertooldamage = helicopter.maxhealth / 2 + 1;
    helicopter.detonateviaemp = &raps::detonate_damage_monitored;
    target_set(helicopter, (0, 0, 100));
    helicopter setdrawinfrared(1);
    helicopter thread function_831a7b56();
    helicopter thread function_62f76066();
    helicopter thread watchgameended();
    /#
        helicopter thread function_dc3d73e5();
    #/
    return helicopter;
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0x37654ffd, Offset: 0x3780
// Size: 0x284
function function_831a7b56() {
    helicopter = self;
    killed = helicopter waittill(#"hash_5e3f646c");
    level notify("raps_updated_" + helicopter.ownerentnum);
    if (target_istarget(helicopter)) {
        target_remove(helicopter);
    }
    if (killed) {
        wait randomfloatrange(0.1, 0.2);
        helicopter function_16a2de15();
        helicopter function_c353e232();
        helicopter thread spin();
        goalx = randomfloatrange(650, 700);
        goaly = randomfloatrange(650, 700);
        if (randomintrange(0, 2) > 0) {
            goalx *= -1;
        }
        if (randomintrange(0, 2) > 0) {
            goaly *= -1;
        }
        helicopter setvehgoalpos(helicopter.origin + (goalx, goaly, randomfloatrange(285, 300) * -1), 0);
        wait randomfloatrange(3, 4);
        helicopter function_bd95f91a();
        wait 0.1;
        helicopter ghost();
        self notify(#"hash_94a71b49");
        wait 0.5;
    } else {
        helicopter function_fee720b7();
    }
    helicopter delete();
}

// Namespace raps_mp
// Params 1, eflags: 0x1 linked
// Checksum 0xde6ff177, Offset: 0x3a10
// Size: 0x84
function watchownerdisconnect(owner) {
    self notify(#"hash_93cf0eb3");
    self endon(#"hash_93cf0eb3");
    helicopter = self;
    helicopter endon(#"hash_5e3f646c");
    owner util::waittill_any("joined_team", "disconnect", "joined_spectators");
    helicopter notify(#"hash_5e3f646c", 0);
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0x93a1615d, Offset: 0x3aa0
// Size: 0x48
function watchgameended() {
    helicopter = self;
    helicopter endon(#"hash_5e3f646c");
    helicopter endon(#"death");
    level waittill(#"game_ended");
    helicopter notify(#"hash_5e3f646c", 0);
}

// Namespace raps_mp
// Params 2, eflags: 0x1 linked
// Checksum 0xdfba2745, Offset: 0x3af0
// Size: 0x1c4
function ondeath(attacker, weapon) {
    helicopter = self;
    if (!isdefined(helicopter.owner) || isdefined(attacker) && helicopter.owner util::isenemyplayer(attacker)) {
        challenges::destroyedaircraft(attacker, weapon, 0);
        attacker challenges::addflyswatterstat(weapon, self);
        scoreevents::processscoreevent("destroyed_raps_deployship", attacker, helicopter.owner, weapon);
        if (isdefined(helicopter.var_12e45979) && helicopter.var_12e45979 == 0) {
            attacker addplayerstat("destroy_raps_before_drop", 1);
        }
        luinotifyevent(%player_callout, 2, %KILLSTREAK_DESTROYED_RAPS_DEPLOY_SHIP, attacker.entnum);
        helicopter notify(#"hash_5e3f646c", 1);
    }
    if (helicopter.isleaving !== 1) {
        helicopter killstreaks::play_pilot_dialog_on_owner("destroyed", "raps");
        helicopter killstreaks::play_destroyed_dialog_on_owner("raps", self.killstreakid);
    }
}

// Namespace raps_mp
// Params 2, eflags: 0x1 linked
// Checksum 0x64729dcb, Offset: 0x3cc0
// Size: 0x6c
function onlowhealth(attacker, weapon) {
    helicopter = self;
    helicopter killstreaks::play_pilot_dialog_on_owner("damaged", "raps", helicopter.killstreakid);
    helicopter function_b1578875();
}

// Namespace raps_mp
// Params 2, eflags: 0x1 linked
// Checksum 0x629c7941, Offset: 0x3d38
// Size: 0x3c
function function_c161d20(attacker, weapon) {
    helicopter = self;
    helicopter function_d6379181();
}

// Namespace raps_mp
// Params 3, eflags: 0x1 linked
// Checksum 0x85642215, Offset: 0x3d80
// Size: 0x388
function function_67f820d0(var_15e1bebe, var_771cbdb2, var_c64f8eec) {
    if (!isdefined(var_15e1bebe)) {
        var_15e1bebe = (-1e+07, -1e+07, -1e+07);
    }
    if (!isdefined(var_771cbdb2)) {
        var_771cbdb2 = (-1e+07, -1e+07, -1e+07);
    }
    if (!isdefined(var_c64f8eec)) {
        var_c64f8eec = 1800 * 1800;
    }
    flyheight = int(airsupport::getminimumflyheight() + 1000);
    found = 0;
    tries = 0;
    for (i = 0; i <= 3; i++) {
        if (i == 3) {
            var_c64f8eec = -1;
        }
        /#
            if (getdvarint("<dev string:x197>") > 0) {
                var_30632b02 = int(60);
                circle(var_15e1bebe, 1800, (1, 0, 0), 1, 1, var_30632b02);
                circle(var_15e1bebe, 1800 - 1, (1, 0, 0), 1, 1, var_30632b02);
                circle(var_15e1bebe, 1800 - 2, (1, 0, 0), 1, 1, var_30632b02);
                circle(var_771cbdb2, 1800, (1, 0, 0), 1, 1, var_30632b02);
                circle(var_771cbdb2, 1800 - 1, (1, 0, 0), 1, 1, var_30632b02);
                circle(var_771cbdb2, 1800 - 2, (1, 0, 0), 1, 1, var_30632b02);
            }
        #/
        while (!found && tries < game["raps_helicopter_positions"].size) {
            index = randomintrange(0, game["raps_helicopter_positions"].size);
            randompoint = (game["raps_helicopter_positions"][index][0], game["raps_helicopter_positions"][index][1], flyheight);
            found = distance2dsquared(randompoint, var_15e1bebe) > var_c64f8eec && distance2dsquared(randompoint, var_771cbdb2) > var_c64f8eec;
            tries++;
        }
        if (!found) {
            var_c64f8eec *= 0.25;
            tries = 0;
        }
    }
    assert(found, "<dev string:x1ad>");
    return randompoint;
}

// Namespace raps_mp
// Params 4, eflags: 0x1 linked
// Checksum 0x665f76dc, Offset: 0x4110
// Size: 0x150
function function_8e67ae2b(var_115585c2, var_d88d274b, var_15e1bebe, var_771cbdb2) {
    if (!isdefined(var_15e1bebe)) {
        var_15e1bebe = (-1e+07, -1e+07, -1e+07);
    }
    if (!isdefined(var_771cbdb2)) {
        var_771cbdb2 = (-1e+07, -1e+07, -1e+07);
    }
    var_d5cf6c02 = function_67f820d0(var_15e1bebe, var_771cbdb2);
    var_cce4dad0 = distance2dsquared(var_d5cf6c02, var_115585c2);
    for (i = 1; i < var_d88d274b; i++) {
        var_28a3ffb9 = function_67f820d0(var_15e1bebe, var_771cbdb2);
        var_a90caf01 = distance2dsquared(var_28a3ffb9, var_115585c2);
        if (var_a90caf01 < var_cce4dad0) {
            var_d5cf6c02 = var_28a3ffb9;
            var_cce4dad0 = var_a90caf01;
        }
    }
    return var_d5cf6c02;
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0xa5b4445, Offset: 0x4268
// Size: 0x42
function function_9e1a5fa2() {
    var_4a57aebc = gettime() - self.var_1c4cd292;
    if (var_4a57aebc < 2000) {
        wait (2000 - var_4a57aebc) * 0.001;
    }
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0xbc9a69c9, Offset: 0x42b8
// Size: 0xc2
function function_a1bdec54() {
    var_ed911797 = undefined;
    arrayremovevalue(level.var_5b16765a, undefined);
    foreach (heli in level.var_5b16765a) {
        if (heli != self) {
            var_ed911797 = heli.var_e126350;
            break;
        }
    }
    return var_ed911797;
}

// Namespace raps_mp
// Params 5, eflags: 0x1 linked
// Checksum 0xdda23ef8, Offset: 0x4388
// Size: 0x13a
function function_7ab1ac37(heli, var_30749c13, var_3e19b7ed, var_2cea7feb, var_93a4ef87) {
    var_ed911797 = self function_a1bdec54();
    if (isdefined(heli) && isdefined(heli.var_d1046bd2)) {
        var_e126350 = heli.var_d1046bd2;
        heli.var_d1046bd2 = undefined;
        return var_e126350;
    }
    var_e126350 = var_30749c13 == 0 ? function_8e67ae2b(var_3e19b7ed, int(game["raps_helicopter_positions"].size * 66.6 / 100 + 1), var_ed911797) : function_67f820d0(var_93a4ef87, var_ed911797);
    var_e126350 = (var_e126350[0], var_e126350[1], var_2cea7feb);
    return var_e126350;
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0xea04a85, Offset: 0x44d0
// Size: 0x2ee
function function_62f76066() {
    /#
        if (getdvarint("<dev string:x1d1>")) {
            return;
        }
    #/
    self endon(#"hash_5e3f646c");
    for (i = 0; i < 3; i++) {
        self.var_e126350 = function_7ab1ac37(self, i, self.var_3e19b7ed, self.var_2cea7feb, self.var_93a4ef87);
        while (distance2dsquared(self.origin, self.var_e126350) > 25) {
            self function_9e1a5fa2();
            self function_951920c2();
            self setvehgoalpos(self.var_e126350, 1);
            self waittill(#"goal");
        }
        if (isdefined(self.owner)) {
            if (i + 1 < 3) {
                self killstreaks::play_pilot_dialog_on_owner("waveStart", "raps", self.killstreakid);
            } else {
                self killstreaks::play_pilot_dialog_on_owner("waveStartFinal", "raps", self.killstreakid);
            }
        }
        enemy = self.owner battlechatter::get_closest_player_enemy(self.origin, 1);
        enemyradius = battlechatter::mpdialog_value("rapsDropRadius", 0);
        if (isdefined(enemy) && distance2dsquared(self.origin, enemy.origin) < enemyradius * enemyradius) {
            enemy battlechatter::play_killstreak_threat("raps");
        }
        self function_4045406();
        wait i + 1 >= 3 ? 2 + randomfloatrange(1 * -1, 1) : 2 + randomfloatrange(2 * -1, 2);
    }
    self notify(#"hash_5e3f646c", 0);
}

/#

    // Namespace raps_mp
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3bd65471, Offset: 0x47c8
    // Size: 0x26e
    function function_dc3d73e5() {
        self endon(#"death");
        if (getdvarint("<dev string:x1d1>") == 0) {
            return;
        }
        for (i = 0; i < 100; i++) {
            for (j = 0; j < game["<dev string:x174>"].size; j++) {
                self.var_e126350 = (game["<dev string:x174>"][j][0], game["<dev string:x174>"][j][1], self.var_2cea7feb);
                while (distance2dsquared(self.origin, self.var_e126350) > 25) {
                    self function_9e1a5fa2();
                    self function_951920c2();
                    self setvehgoalpos(self.var_e126350, 1);
                    self waittill(#"goal");
                }
                self function_4045406();
                wait 1;
                if (getdvarint("<dev string:x1ea>") > 0) {
                    if ((j + 1) % 3 == 0) {
                        self.var_e126350 = getrandomhelicopterstartorigin(self.var_2cea7feb, self.origin);
                        while (distance2dsquared(self.origin, self.var_e126350) > 25) {
                            self function_9e1a5fa2();
                            self function_951920c2();
                            self setvehgoalpos(self.var_e126350, 1);
                            self waittill(#"goal");
                        }
                    }
                }
            }
        }
        self notify(#"hash_5e3f646c", 0);
    }

#/

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0x283a8b20, Offset: 0x4a40
// Size: 0x238
function function_4045406() {
    level endon(#"game_ended");
    self endon(#"death");
    self.var_56adcf6e = 1;
    self.var_93a4ef87 = self.origin;
    var_507e12a6 = 0.5 * (self gettagorigin(level.var_443ea6dd[0]) + self gettagorigin(level.var_443ea6dd[1]));
    var_c0f49510 = self.var_e126350 + self.var_e126350 - var_507e12a6;
    var_c0f49510 = (var_c0f49510[0], var_c0f49510[1], self.var_e126350[2]);
    self setvehgoalpos(var_c0f49510, 1);
    self waittill(#"goal");
    self.var_12e45979 = 1;
    for (i = 0; i < level.var_d90be9a7.spawn_count; i++) {
        spawn_tag = level.var_443ea6dd[i % level.var_443ea6dd.size];
        origin = self gettagorigin(spawn_tag);
        angles = self gettagangles(spawn_tag);
        if (!isdefined(origin) || !isdefined(angles)) {
            origin = self.origin;
            angles = self.angles;
        }
        self.owner thread function_26d9e1a2(origin, angles);
        self playsound("veh_raps_launch");
        wait 1;
    }
    self.var_56adcf6e = 0;
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0xa3cb64ce, Offset: 0x4c80
// Size: 0xd6
function spin() {
    self endon(#"hash_94a71b49");
    speed = randomintrange(-76, -36);
    self setyawspeed(speed, speed * 0.25, speed);
    if (randomintrange(0, 2) > 0) {
        speed *= -1;
    }
    while (isdefined(self)) {
        self settargetyaw(self.angles[1] + speed * 0.4);
        wait 1;
    }
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0xad53c445, Offset: 0x4d60
// Size: 0x4c
function function_16a2de15() {
    playfxontag("killstreaks/fx_heli_raps_exp_sm", self, "tag_fx_engine_exhaust_back");
    self playsound(level.heli_sound["crash"]);
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0xcae3b582, Offset: 0x4db8
// Size: 0x24
function function_b1578875() {
    self clientfield::set("raps_heli_low_health", 1);
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0x2f679691, Offset: 0x4de8
// Size: 0x24
function function_d6379181() {
    self clientfield::set("raps_heli_extra_low_health", 1);
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0xb41fc3b6, Offset: 0x4e18
// Size: 0x24
function function_c353e232() {
    playfxontag("killstreaks/fx_heli_raps_exp_trail", self, "tag_fx_engine_exhaust_back");
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0xd3870968, Offset: 0x4e48
// Size: 0x4c
function function_bd95f91a() {
    playfxontag("killstreaks/fx_heli_raps_exp_lg", self, "tag_fx_death");
    self playsound(level.heli_sound["crash"]);
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0x7cbcde96, Offset: 0x4ea0
// Size: 0xf4
function function_fee720b7() {
    self.isleaving = 1;
    self killstreaks::play_pilot_dialog_on_owner("timeout", "raps");
    self killstreaks::play_taacom_dialog_response_on_owner("timeoutConfirmed", "raps");
    self.var_1fef8d2b = function_f3f428f0(0, self.origin);
    while (distance2dsquared(self.origin, self.var_1fef8d2b) > 360000) {
        self function_951920c2();
        self setvehgoalpos(self.var_1fef8d2b, 0);
        self waittill(#"goal");
    }
}

// Namespace raps_mp
// Params 1, eflags: 0x1 linked
// Checksum 0x5852caeb, Offset: 0x4fa0
// Size: 0x164
function function_951920c2(var_d0df8686) {
    if (isdefined(var_d0df8686)) {
        switch (var_d0df8686) {
        case 0:
            self.var_c6ede233 = 1;
            self.var_72eff24a = 20;
            self.var_5ee7ff51 = 20;
            break;
        case 1:
        case 2:
            self.var_c6ede233 = var_d0df8686 == 2 ? 0.2 : 0.5;
            self.var_72eff24a = 12;
            self.var_5ee7ff51 = 100;
            break;
        }
    }
    desiredspeed = self getmaxspeed() / 17.6 * self.var_c6ede233;
    if (desiredspeed < self getspeedmph()) {
        self setspeed(desiredspeed, self.var_5ee7ff51, self.var_5ee7ff51);
        return;
    }
    self setspeed(desiredspeed, self.var_72eff24a, self.var_5ee7ff51);
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0xea51925f, Offset: 0x5110
// Size: 0x30
function function_43b54fe2() {
    self setspeed(0, 500, 500);
    self.var_1c4cd292 = gettime();
}

// Namespace raps_mp
// Params 2, eflags: 0x1 linked
// Checksum 0x6f2f6fb0, Offset: 0x5148
// Size: 0x354
function function_26d9e1a2(origin, angles) {
    originalowner = self;
    originalownerentnum = originalowner.entnum;
    raps = spawnvehicle("spawner_bo3_raps_mp", origin, angles, "dynamic_spawn_ai");
    if (!isdefined(raps)) {
        return;
    }
    raps.forceonemissile = 1;
    raps.drop_deploying = 1;
    raps.hurt_trigger_immune_end_time = gettime() + (isdefined(level.var_6b8375c8) ? level.var_6b8375c8 : 5000);
    if (!isdefined(level.raps[originalownerentnum].raps)) {
        level.raps[originalownerentnum].raps = [];
    } else if (!isarray(level.raps[originalownerentnum].raps)) {
        level.raps[originalownerentnum].raps = array(level.raps[originalownerentnum].raps);
    }
    level.raps[originalownerentnum].raps[level.raps[originalownerentnum].raps.size] = raps;
    raps killstreaks::configure_team("raps", "raps", originalowner, undefined, undefined, &configureteampost);
    raps killstreak_hacking::enable_hacking("raps");
    raps clientfield::set("enemyvehicle", 1);
    raps.soundmod = "raps";
    raps.ignore_vehicle_underneath_splash_scalar = 1;
    raps.detonate_sides_disabled = 1;
    raps.treat_owner_damage_as_friendly_fire = 1;
    raps.ignore_team_kills = 1;
    raps setinvisibletoall();
    raps thread autosetvisibletoall();
    raps vehicle::toggle_sounds(0);
    raps thread function_6b2dd5fd(originalowner);
    raps thread function_5c000140(originalowner);
    raps thread killstreaks::waitfortimeout("raps", raps.settings.max_duration * 1000, &function_1732e573, "death");
}

// Namespace raps_mp
// Params 2, eflags: 0x1 linked
// Checksum 0x9da73730, Offset: 0x54a8
// Size: 0x6c
function configureteampost(owner, ishacked) {
    raps = self;
    raps thread function_267e6bb4();
    raps thread function_e16e7519(owner);
    raps thread function_3a23837e(owner);
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0x8836d64e, Offset: 0x5520
// Size: 0x34
function autosetvisibletoall() {
    self endon(#"death");
    wait 0.05;
    wait 0.05;
    self setvisibletoall();
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0x877df6ff, Offset: 0x5560
// Size: 0x24
function function_1732e573() {
    self selfdestruct(self.owner);
}

// Namespace raps_mp
// Params 1, eflags: 0x1 linked
// Checksum 0x91dfbcb9, Offset: 0x5590
// Size: 0x34
function selfdestruct(attacker) {
    self.selfdestruct = 1;
    self raps::detonate(attacker);
}

// Namespace raps_mp
// Params 1, eflags: 0x1 linked
// Checksum 0x1a7da20e, Offset: 0x55d0
// Size: 0xe0
function function_6b2dd5fd(originalowner) {
    originalowner endon(#"raps_complete");
    self endon(#"death");
    if (self.settings.max_kill_count == 0) {
        return;
    }
    while (true) {
        victim = self waittill(#"killed");
        if (isdefined(victim) && isplayer(victim)) {
            if (!isdefined(self.killcount)) {
                self.killcount = 0;
            }
            self.killcount++;
            if (self.killcount >= self.settings.max_kill_count) {
                self raps::detonate(self.owner);
            }
        }
    }
}

// Namespace raps_mp
// Params 1, eflags: 0x1 linked
// Checksum 0x74349800, Offset: 0x56b8
// Size: 0x78
function function_3a23837e(owner) {
    owner endon(#"disconnect");
    self endon(#"death");
    while (true) {
        wait 3.5;
        if (abs(self.angles[2]) > 75) {
            self raps::detonate(owner);
        }
    }
}

// Namespace raps_mp
// Params 1, eflags: 0x1 linked
// Checksum 0x241a2301, Offset: 0x5738
// Size: 0x22c
function function_5c000140(originalowner) {
    originalownerentnum = originalowner.entnum;
    attacker, damagefromunderneath, weapon = self waittill(#"death");
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (isdefined(attacker) && isplayer(attacker)) {
        if (isdefined(self.owner) && self.owner != attacker && self.owner.team != attacker.team) {
            scoreevents::processscoreevent("killed_raps", attacker);
            attacker challenges::destroyscorestreak(weapon, 1);
            attacker challenges::function_90c432bd(weapon);
            if (isdefined(self.attackers)) {
                foreach (player in self.attackers) {
                    if (isplayer(player) && player != attacker && player != self.owner) {
                        scoreevents::processscoreevent("killed_raps_assist", player);
                    }
                }
            }
        }
    }
    arrayremovevalue(level.raps[originalownerentnum].raps, self);
}

// Namespace raps_mp
// Params 1, eflags: 0x1 linked
// Checksum 0xdb392aa5, Offset: 0x5970
// Size: 0x274
function function_e16e7519(owner) {
    owner endon(#"disconnect");
    self endon(#"death");
    self endon(#"hacked");
    self vehicle_ai::set_state("off");
    util::wait_network_frame();
    util::wait_network_frame();
    self setvehiclefordropdeploy();
    self clientfield::set("monitor_raps_drop_landing", 1);
    wait 3;
    if (self function_c15c43e3()) {
        self resetvehiclefromdropdeploy();
        self setgoal(self.origin);
        self vehicle_ai::set_state("combat");
        self vehicle::toggle_sounds(1);
        self.drop_deploying = undefined;
        self.hurt_trigger_immune_end_time = undefined;
        target_set(self);
        for (i = 0; i < level.raps[owner.entnum].raps.size; i++) {
            raps = level.raps[owner.entnum].raps[i];
            if (isdefined(raps) && isdefined(raps.enemy) && isdefined(self) && isdefined(self.enemy) && raps != self && raps.enemy == self.enemy) {
                self setpersonalthreatbias(self.enemy, -2000, 5);
            }
        }
        return;
    }
    self selfdestruct(self.owner);
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0x8c6aeb3e, Offset: 0x5bf0
// Size: 0x136
function function_c15c43e3() {
    for (waittime = 0; abs(self.velocity[2]) > 0.1 && waittime < 5; waittime += 0.2) {
        wait 0.2;
    }
    while ((!ispointonnavmesh(self.origin, 36) || abs(self.velocity[2]) > 0.1) && waittime < 5 + 5) {
        wait 0.2;
        waittime += 0.2;
    }
    /#
        if (false) {
            waittime += 5 + 5;
        }
    #/
    return waittime < 5 + 5;
}

// Namespace raps_mp
// Params 2, eflags: 0x1 linked
// Checksum 0xca01f090, Offset: 0x5d30
// Size: 0xfa
function function_b6ac9c42(entnum, abandoned) {
    if (!isdefined(abandoned)) {
        abandoned = 0;
    }
    foreach (raps in level.raps[entnum].raps) {
        if (isalive(raps)) {
            raps.owner = undefined;
            raps.abandoned = abandoned;
            raps raps::detonate(raps);
        }
    }
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0x618812d8, Offset: 0x5e38
// Size: 0xfc
function function_778dcc4e() {
    foreach (player in level.players) {
        if (isdefined(self.owner) && self.owner util::isenemyplayer(player) && !player smokegrenade::function_c7ecc8f3() && !player hasperk("specialty_nottargetedbyraps")) {
            self getperfectinfo(player);
            return;
        }
    }
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0xc57333ff, Offset: 0x5f40
// Size: 0x19c
function function_92d02a83() {
    level endon(#"game_ended");
    helicopter = self;
    if (isdefined(helicopter.var_bfeebe5b)) {
        helicopter.var_bfeebe5b delete();
    }
    var_bfeebe5b = spawn("script_model", helicopter.origin - (0, 0, self.var_2cea7feb));
    helicopter.var_bfeebe5b = var_bfeebe5b;
    helicopter.var_bfeebe5b.angles = (0, 0, 0);
    helicopter.var_bfeebe5b linkto(helicopter);
    preset = getinfluencerpreset("helicopter");
    if (!isdefined(preset)) {
        return;
    }
    enemy_team_mask = helicopter spawning::get_enemy_team_mask(helicopter.team);
    helicopter.var_bfeebe5b spawning::create_entity_influencer("helicopter", enemy_team_mask);
    helicopter waittill(#"death");
    if (isdefined(var_bfeebe5b)) {
        var_bfeebe5b delete();
    }
}

// Namespace raps_mp
// Params 0, eflags: 0x1 linked
// Checksum 0xb8e45f7d, Offset: 0x60e8
// Size: 0x94
function function_267e6bb4() {
    raps = self;
    preset = getinfluencerpreset("raps");
    if (!isdefined(preset)) {
        return;
    }
    enemy_team_mask = raps spawning::get_enemy_team_mask(raps.team);
    raps spawning::create_entity_influencer("raps", enemy_team_mask);
}

