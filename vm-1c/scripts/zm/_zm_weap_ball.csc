#using scripts/codescripts/struct;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_weapons;

#namespace ball;

// Namespace ball
// Params 0, eflags: 0x2
// Checksum 0x4dc8603d, Offset: 0x3c8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("ball", &__init__, undefined, undefined);
}

// Namespace ball
// Params 0, eflags: 0x0
// Checksum 0x10de5810, Offset: 0x408
// Size: 0x2ba
function __init__() {
    clientfield::register("allplayers", "ballcarrier", 15000, 1, "int", &function_5354f213, 0, 1);
    clientfield::register("allplayers", "passoption", 15000, 1, "int", &function_8dc589c8, 0, 0);
    clientfield::register("world", "ball_away", 15000, 1, "int", &function_c27acbbf, 0, 1);
    clientfield::register("world", "ball_score_allies", 15000, 1, "int", &function_fe891abf, 0, 1);
    clientfield::register("world", "ball_score_axis", 15000, 1, "int", &function_7d1a6e7e, 0, 1);
    clientfield::register("scriptmover", "ball_on_ground_fx", 15000, 1, "int", &ball_on_ground_fx, 0, 0);
    callback::on_localclient_connect(&on_localclient_connect);
    callback::on_spawned(&on_player_spawned);
    level.effect_scriptbundles = [];
    level.effect_scriptbundles["goal"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_uplink_goal");
    level.effect_scriptbundles["goal_score"] = struct::get_script_bundle("teamcolorfx", "teamcolorfx_uplink_goal_score");
    level._effect["ball_on_ground"] = "dlc1/skyjacked/fx_light_blue_flashing_md_02";
    level._effect["balllight_fx"] = "dlc4/genesis/fx_summoningkey_light_loop";
    level._effect["lght_marker"] = "zombie/fx_weapon_box_marker_zmb";
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0xff2f5b2f, Offset: 0x6d0
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
// Checksum 0x86417dcc, Offset: 0x858
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
// Checksum 0x3da0fb73, Offset: 0x948
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
// Checksum 0xca107740, Offset: 0xa10
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
// Checksum 0x95b9d2e1, Offset: 0xae0
// Size: 0xd4
function function_45876c81(localclientnum) {
    effects = [];
    effects["allies"] = "ui/fx_uplink_goal_marker";
    effects["axis"] = "ui/fx_uplink_goal_marker";
    foreach (goal in level.goals) {
    }
    thread watch_for_team_change(localclientnum);
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x509a5365, Offset: 0xbc0
// Size: 0xbc
function function_ea2fff95(localclientnum, goal) {
    effects = [];
    effects["allies"] = "ui/fx_uplink_goal_marker_flash";
    effects["axis"] = "ui/fx_uplink_goal_marker_flash";
    fx_handle = playfx(localclientnum, effects[goal.team], goal.origin);
    setfxteam(localclientnum, fx_handle, goal.team);
}

// Namespace ball
// Params 6, eflags: 0x0
// Checksum 0x18c62b62, Offset: 0xc88
// Size: 0x7c
function function_85e74fc9(localclientnum, team, oldval, newval, binitialsnap, bwastimejump) {
    if (newval != oldval && !binitialsnap && !bwastimejump) {
        function_ea2fff95(localclientnum, level.goals[team]);
    }
}

// Namespace ball
// Params 7, eflags: 0x0
// Checksum 0xfc6e145f, Offset: 0xd10
// Size: 0x6c
function function_fe891abf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_85e74fc9(localclientnum, "allies", oldval, newval, binitialsnap, bwastimejump);
}

// Namespace ball
// Params 7, eflags: 0x0
// Checksum 0x30743b6d, Offset: 0xd88
// Size: 0x6c
function function_7d1a6e7e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    function_85e74fc9(localclientnum, "axis", oldval, newval, binitialsnap, bwastimejump);
}

// Namespace ball
// Params 7, eflags: 0x0
// Checksum 0x2a21c751, Offset: 0xe00
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
// Checksum 0xa9f2adeb, Offset: 0xf98
// Size: 0x20c
function function_b95d5759(localclientnum) {
    level.var_300a2507 = self;
    friendly = self isfriendly(localclientnum);
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
// Checksum 0x1a097270, Offset: 0x11b0
// Size: 0xec
function clear_hud(localclientnum) {
    level.var_300a2507 = undefined;
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByEnemy"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballHeldByFriendly"), 0);
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballStatusText"), %MPUI_BALL_AWAY);
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x67116bd0, Offset: 0x12a8
// Size: 0x24
function watch_for_death(localclientnum) {
    level endon(#"watch_for_death");
    self waittill(#"entityshutdown");
}

// Namespace ball
// Params 7, eflags: 0x0
// Checksum 0x41442339, Offset: 0x12d8
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
// Checksum 0xfe63ea6f, Offset: 0x13d8
// Size: 0x84
function function_c27acbbf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "ballGametype.ballAway"), newval);
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x5e082203, Offset: 0x1468
// Size: 0x3c
function function_235fe967(localclientnum, on_off) {
    self duplicate_render::update_dr_flag(localclientnum, "ballcarrier", on_off);
}

// Namespace ball
// Params 2, eflags: 0x0
// Checksum 0x24fa823c, Offset: 0x14b0
// Size: 0x3c
function function_115bb67e(localclientnum, on_off) {
    self duplicate_render::update_dr_flag(localclientnum, "passoption", on_off);
}

// Namespace ball
// Params 3, eflags: 0x0
// Checksum 0x2a5801, Offset: 0x14f8
// Size: 0x50
function resetondemojump(localclientnum, goal, effects) {
    for (;;) {
        level waittill("demo_jump" + localclientnum);
        function_2182aedf(localclientnum, goal, effects);
    }
}

// Namespace ball
// Params 1, eflags: 0x0
// Checksum 0x4e6236c7, Offset: 0x1550
// Size: 0x4c
function watch_for_team_change(localclientnum) {
    level notify(#"end_team_change_watch");
    level endon(#"end_team_change_watch");
    level waittill(#"team_changed");
    thread function_45876c81(localclientnum);
}

// Namespace ball
// Params 7, eflags: 0x0
// Checksum 0xd1e2cb69, Offset: 0x15a8
// Size: 0x20e
function ball_on_ground_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (!isdefined(self.var_ff242ed4)) {
            self.var_ff242ed4 = playfx(localclientnum, level._effect["ball_on_ground"], self.origin + (0, 0, 72), (0, 0, 1), (1, 0, 0));
        }
        if (!isdefined(self.var_cd030ed9)) {
            self.var_cd030ed9 = playfx(localclientnum, level._effect["balllight_fx"], self.origin + (0, 0, 72), (0, 0, 1), (1, 0, 0));
        }
        if (!isdefined(self.var_2e7f5bfb)) {
            self.var_2e7f5bfb = playfx(localclientnum, level._effect["lght_marker"], self.origin + (0, 0, 72), (0, 0, 1), (1, 0, 0));
        }
        return;
    }
    if (isdefined(self.var_ff242ed4)) {
        stopfx(localclientnum, self.var_ff242ed4);
        self.var_ff242ed4 = undefined;
    }
    if (isdefined(self.var_cd030ed9)) {
        stopfx(localclientnum, self.var_cd030ed9);
        self.var_cd030ed9 = undefined;
    }
    if (isdefined(self.var_2e7f5bfb)) {
        stopfx(localclientnum, self.var_2e7f5bfb);
        self.var_2e7f5bfb = undefined;
    }
}

