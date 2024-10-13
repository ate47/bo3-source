#using scripts/mp/_shoutcaster;
#using scripts/shared/util_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace ball;

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x9e2e2566, Offset: 0x350
// Size: 0x236
function main() {
    clientfield::register("allplayers", "ballcarrier", 1, 1, "int", &function_5354f213, 0, 1);
    clientfield::register("allplayers", "passoption", 1, 1, "int", &function_8dc589c8, 0, 0);
    clientfield::register("world", "ball_away", 1, 1, "int", &function_c27acbbf, 0, 1);
    clientfield::register("world", "ball_score_allies", 1, 1, "int", &function_fe891abf, 0, 1);
    clientfield::register("world", "ball_score_axis", 1, 1, "int", &function_7d1a6e7e, 0, 1);
    callback::on_localclient_connect(&on_localclient_connect);
    callback::on_spawned(&on_player_spawned);
    if (!getdvarint("tu11_programaticallyColoredGameFX")) {
        level.effect_scriptbundles = [];
        level.effect_scriptbundles["goal"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_uplink_goal");
        level.effect_scriptbundles["goal_score"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_uplink_goal_score");
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x7eab9c46, Offset: 0x590
// Size: 0x17c
function on_localclient_connect(localclientnum) {
    var_1d2359d9 = [];
    while (!isdefined(var_1d2359d9["allies"])) {
        var_1d2359d9["allies"] = serverobjective_getobjective(localclientnum, "ball_goal_allies");
        var_1d2359d9["axis"] = serverobjective_getobjective(localclientnum, "ball_goal_axis");
        wait 0.05;
    }
    foreach (key, objective in var_1d2359d9) {
        level.goals[key] = spawnstruct();
        level.goals[key].objectiveid = objective;
        function_b22de10a(localclientnum, level.goals[key]);
    }
    function_45876c81(localclientnum);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x7f52c131, Offset: 0x718
// Size: 0xe2
function on_player_spawned(localclientnum) {
    players = getplayers(localclientnum);
    foreach (player in players) {
        if (player util::isenemyplayer(self)) {
            player duplicate_render::update_dr_flag(localclientnum, "ballcarrier", 0);
        }
    }
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0xf259a730, Offset: 0x808
// Size: 0xc0
function function_b22de10a(localclientnum, goal) {
    goal.origin = serverobjective_getobjectiveorigin(localclientnum, goal.objectiveid);
    var_ecb500c6 = serverobjective_getobjectiveentity(localclientnum, goal.objectiveid);
    if (isdefined(var_ecb500c6)) {
        goal.origin = var_ecb500c6.origin;
    }
    goal.team = serverobjective_getobjectiveteam(localclientnum, goal.objectiveid);
}

// Namespace ball
// Params 3, eflags: 0x0
// Checksum 0x4a42c58c, Offset: 0x8d0
// Size: 0xc4
function function_2182aedf(localclientnum, goal, effects) {
    if (isdefined(goal.base_fx)) {
        stopfx(localclientnum, goal.base_fx);
    }
    goal.base_fx = playfx(localclientnum, effects[goal.team], goal.origin);
    setfxteam(localclientnum, goal.base_fx, goal.team);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x4d825120, Offset: 0x9a0
// Size: 0x1ac
function function_45876c81(localclientnum) {
    effects = [];
    if (shoutcaster::is_shoutcaster_using_team_identity(localclientnum)) {
        if (getdvarint("tu11_programaticallyColoredGameFX")) {
            effects["allies"] = "ui/fx_uplink_goal_marker_white";
            effects["axis"] = "ui/fx_uplink_goal_marker_white";
        } else {
            effects = shoutcaster::get_color_fx(localclientnum, level.effect_scriptbundles["goal"]);
        }
    } else {
        effects["allies"] = "ui/fx_uplink_goal_marker";
        effects["axis"] = "ui/fx_uplink_goal_marker";
    }
    foreach (goal in level.goals) {
        thread function_2182aedf(localclientnum, goal, effects);
        thread resetondemojump(localclientnum, goal, effects);
    }
    thread watch_for_team_change(localclientnum);
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x873549ef, Offset: 0xb58
// Size: 0x154
function function_ea2fff95(localclientnum, goal) {
    effects = [];
    if (shoutcaster::is_shoutcaster_using_team_identity(localclientnum)) {
        if (getdvarint("tu11_programaticallyColoredGameFX")) {
            effects["allies"] = "ui/fx_uplink_goal_marker_white_flash";
            effects["axis"] = "ui/fx_uplink_goal_marker_white_flash";
        } else {
            effects = shoutcaster::get_color_fx(localclientnum, level.effect_scriptbundles["goal_score"]);
        }
    } else {
        effects["allies"] = "ui/fx_uplink_goal_marker_flash";
        effects["axis"] = "ui/fx_uplink_goal_marker_flash";
    }
    fx_handle = playfx(localclientnum, effects[goal.team], goal.origin);
    setfxteam(localclientnum, fx_handle, goal.team);
}

// Namespace ball
// Params 6, eflags: 0x0
// Checksum 0xbab27aa3, Offset: 0xcb8
// Size: 0x7c
function function_85e74fc9(localclientnum, team, oldval, newval, binitialsnap, bwastimejump) {
    if (newval != oldval && !binitialsnap && !bwastimejump) {
        function_ea2fff95(localclientnum, level.goals[team]);
    }
}

// Namespace ball
// Params 7, eflags: 0x0
// Checksum 0x1da7138, Offset: 0xd40
// Size: 0x6c
function function_fe891abf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_85e74fc9(localclientnum, "allies", oldval, newval, binitialsnap, bwastimejump);
}

// Namespace ball
// Params 7, eflags: 0x0
// Checksum 0x86481149, Offset: 0xdb8
// Size: 0x6c
function function_7d1a6e7e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_85e74fc9(localclientnum, "axis", oldval, newval, binitialsnap, bwastimejump);
}

// Namespace ball
// Params 7, eflags: 0x0
// Checksum 0x93994f2, Offset: 0xe30
// Size: 0x18c
function function_5354f213(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    localplayer = getlocalplayer(localclientnum);
    if (localplayer == self) {
        if (newval) {
            self.var_25281d17 = 1;
        } else {
            self.var_25281d17 = 0;
            setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.passOption"), 0);
        }
    }
    if (localplayer != self && self isfriendly(localclientnum)) {
        self function_235fe967(localclientnum, newval);
    } else {
        self function_235fe967(localclientnum, 0);
    }
    if (isdefined(level.var_300a2507) && level.var_300a2507 != self) {
        return;
    }
    level notify(#"watch_for_death");
    if (newval == 1) {
        self thread watch_for_death(localclientnum);
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x2189f755, Offset: 0xfc8
// Size: 0x23c
function function_b95d5759(localclientnum) {
    level.var_300a2507 = self;
    if (shoutcaster::is_shoutcaster(localclientnum)) {
        friendly = self shoutcaster::is_friendly(localclientnum);
    } else {
        friendly = self isfriendly(localclientnum);
    }
    if (isdefined(self.name)) {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), self.name);
    } else {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), "");
    }
    if (isdefined(friendly)) {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), friendly);
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), !friendly);
        return;
    }
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), 0);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x37a7e272, Offset: 0x1210
// Size: 0xec
function clear_hud(localclientnum) {
    level.var_300a2507 = undefined;
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), %MPUI_BALL_AWAY);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x3fffbd4f, Offset: 0x1308
// Size: 0x24
function watch_for_death(localclientnum) {
    level endon(#"watch_for_death");
    self waittill(#"entityshutdown");
}

// Namespace ball
// Params 7, eflags: 0x0
// Checksum 0xb9de5619, Offset: 0x1338
// Size: 0xf4
function function_8dc589c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    localplayer = getlocalplayer(localclientnum);
    if (localplayer != self && self isfriendly(localclientnum)) {
        if (isdefined(localplayer.var_25281d17) && localplayer.var_25281d17) {
            setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.passOption"), newval);
        }
    }
}

// Namespace ball
// Params 7, eflags: 0x0
// Checksum 0x6ebfb289, Offset: 0x1438
// Size: 0x84
function function_c27acbbf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballAway"), newval);
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x749c276, Offset: 0x14c8
// Size: 0x3c
function function_235fe967(localclientnum, on_off) {
    self duplicate_render::update_dr_flag(localclientnum, "ballcarrier", on_off);
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x691c35c7, Offset: 0x1510
// Size: 0x3c
function function_115bb67e(localclientnum, on_off) {
    self duplicate_render::update_dr_flag(localclientnum, "passoption", on_off);
}

// Namespace ball
// Params 3, eflags: 0x0
// Checksum 0x4d6aeaa5, Offset: 0x1558
// Size: 0x50
function resetondemojump(localclientnum, goal, effects) {
    for (;;) {
        level waittill("demo_jump" + localclientnum);
        function_2182aedf(localclientnum, goal, effects);
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xc0b7e05a, Offset: 0x15b0
// Size: 0x4c
function watch_for_team_change(localclientnum) {
    level notify(#"end_team_change_watch");
    level endon(#"end_team_change_watch");
    level waittill(#"team_changed");
    thread function_45876c81(localclientnum);
}

