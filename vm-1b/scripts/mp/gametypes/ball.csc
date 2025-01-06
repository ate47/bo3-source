#using scripts/codescripts/struct;
#using scripts/mp/_shoutcaster;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/util_shared;

#namespace ball;

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x8abd8ef5, Offset: 0x2d8
// Size: 0x1cb
function main() {
    clientfield::register("allplayers", "ballcarrier", 1, 1, "int", &function_5354f213, 0, 1);
    clientfield::register("allplayers", "passoption", 1, 1, "int", &function_8dc589c8, 0, 0);
    clientfield::register("world", "ball_home", 1, 1, "int", &function_6911c16c, 0, 1);
    clientfield::register("world", "ball_score_allies", 1, 1, "int", &function_fe891abf, 0, 1);
    clientfield::register("world", "ball_score_axis", 1, 1, "int", &function_7d1a6e7e, 0, 1);
    callback::on_localclient_connect(&on_localclient_connect);
    level.var_2eef050f = [];
    level.var_2eef050f["allies"] = 0;
    level.var_2eef050f["axis"] = 0;
    level.effect_scriptbundles = [];
    level.effect_scriptbundles["goal"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_uplink_goal");
    level.effect_scriptbundles["goal_score"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_uplink_goal_score");
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xbac1509e, Offset: 0x4b0
// Size: 0x112
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
// Params 2, eflags: 0x0
// Checksum 0x7cf0254b, Offset: 0x5d0
// Size: 0x92
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
// Checksum 0x2d326cf, Offset: 0x670
// Size: 0x92
function function_2182aedf(localclientnum, goal, effects) {
    if (isdefined(goal.base_fx)) {
        stopfx(localclientnum, goal.base_fx);
    }
    goal.base_fx = playfx(localclientnum, effects[goal.team], goal.origin);
    setfxteam(localclientnum, goal.base_fx, goal.team);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x65771d20, Offset: 0x710
// Size: 0xe3
function function_45876c81(localclientnum) {
    effects = [];
    if (shoutcaster::is_shoutcaster(localclientnum)) {
        effects = shoutcaster::get_color_fx(localclientnum, level.effect_scriptbundles["goal"]);
    } else {
        effects["allies"] = "ui/fx_uplink_goal_marker";
        effects["axis"] = "ui/fx_uplink_goal_marker";
    }
    foreach (goal in level.goals) {
        thread function_2182aedf(localclientnum, goal, effects);
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xabab91ef, Offset: 0x800
// Size: 0x32
function watch_for_team_change(localclientnum) {
    level notify(#"end_team_change_watch");
    level endon(#"end_team_change_watch");
    level waittill(#"team_changed");
    function_45876c81(localclientnum);
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x9ec9ce00, Offset: 0x840
// Size: 0xd2
function function_ea2fff95(localclientnum, goal) {
    effects = [];
    if (shoutcaster::is_shoutcaster(localclientnum)) {
        effects = shoutcaster::get_color_fx(localclientnum, level.effect_scriptbundles["goal_score"]);
    } else {
        effects["allies"] = "ui/fx_uplink_goal_marker_flash";
        effects["axis"] = "ui/fx_uplink_goal_marker_flash";
    }
    fx_handle = playfx(localclientnum, effects[goal.team], goal.origin);
    setfxteam(localclientnum, fx_handle, goal.team);
}

// Namespace ball
// Params 7, eflags: 0x0
// Checksum 0x4905d59f, Offset: 0x920
// Size: 0x8a
function function_fe891abf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != level.var_2eef050f["allies"] && !binitialsnap) {
        level.var_2eef050f["allies"] = newval;
        function_ea2fff95(localclientnum, level.goals["allies"]);
    }
}

// Namespace ball
// Params 7, eflags: 0x0
// Checksum 0xcaed3435, Offset: 0x9b8
// Size: 0x8a
function function_7d1a6e7e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval != level.var_2eef050f["axis"] && !binitialsnap) {
        level.var_2eef050f["axis"] = newval;
        function_ea2fff95(localclientnum, level.goals["axis"]);
    }
}

// Namespace ball
// Params 7, eflags: 0x0
// Checksum 0xf8b9e370, Offset: 0xa50
// Size: 0x16a
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
    if (newval == 1) {
        self function_b95d5759(localclientnum);
    } else {
        self clear_hud(localclientnum);
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
// Checksum 0x4d24dba5, Offset: 0xbc8
// Size: 0x122
function function_b95d5759(localclientnum) {
    level.var_300a2507 = self;
    if (shoutcaster::is_shoutcaster(localclientnum)) {
        friendly = self shoutcaster::is_friendly(localclientnum);
    } else {
        friendly = self isfriendly(localclientnum);
    }
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), self.name);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), friendly);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), !friendly);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x63a9805a, Offset: 0xcf8
// Size: 0xca
function clear_hud(localclientnum) {
    level.var_300a2507 = undefined;
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), %MPUI_BALL_AWAY);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xb408648a, Offset: 0xdd0
// Size: 0x32
function watch_for_death(localclientnum) {
    level endon(#"watch_for_death");
    self waittill(#"entityshutdown");
    self clear_hud(localclientnum);
}

// Namespace ball
// Params 7, eflags: 0x0
// Checksum 0x6ca1488f, Offset: 0xe10
// Size: 0xc2
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
// Checksum 0x33bce60b, Offset: 0xee0
// Size: 0x102
function function_6911c16c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1 || binitialsnap) {
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), 0);
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), 0);
        setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), %MPUI_BALL_HOME);
    }
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x5ef3e8b8, Offset: 0xff0
// Size: 0x32
function function_235fe967(localclientnum, on_off) {
    self duplicate_render::update_dr_flag(localclientnum, "ballcarrier", on_off);
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0xea7472df, Offset: 0x1030
// Size: 0x32
function function_115bb67e(localclientnum, on_off) {
    self duplicate_render::update_dr_flag(localclientnum, "passoption", on_off);
}

