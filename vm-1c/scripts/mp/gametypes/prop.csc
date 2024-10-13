#using scripts/mp/_callbacks;
#using scripts/shared/util_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace prop;

// Namespace prop
// Params 0, eflags: 0x0
// Checksum 0xa282f846, Offset: 0x218
// Size: 0xf4
function main() {
    clientfield::register("allplayers", "hideTeamPlayer", 27000, 2, "int", &function_8e3b5ce2, 0, 0);
    clientfield::register("allplayers", "pingHighlight", 27000, 1, "int", &highlightplayer, 0, 0);
    callback::on_localplayer_spawned(&onlocalplayerspawned);
    level.var_f12ccf06 = &hideprop;
    level.var_c301d021 = &highlightprop;
    thread function_576e8126();
}

// Namespace prop
// Params 1, eflags: 0x0
// Checksum 0x1b09760e, Offset: 0x318
// Size: 0x6c
function onlocalplayerspawned(localclientnum) {
    level notify("localPlayerSpectatingEnd" + localclientnum);
    if (isspectating(localclientnum, 0)) {
        level thread localplayerspectating(localclientnum);
    }
    level thread setuppropplayernames(localclientnum);
}

// Namespace prop
// Params 1, eflags: 0x0
// Checksum 0x84f49575, Offset: 0x390
// Size: 0xa4
function localplayerspectating(localclientnum) {
    level notify("localPlayerSpectating" + localclientnum);
    level endon("localPlayerSpectatingEnd" + localclientnum);
    var_cfcb9b39 = playerbeingspectated(localclientnum);
    while (true) {
        player = playerbeingspectated(localclientnum);
        if (player != var_cfcb9b39) {
            level notify("localPlayerSpectating" + localclientnum);
        }
        wait 0.1;
    }
}

// Namespace prop
// Params 0, eflags: 0x0
// Checksum 0x237bbd34, Offset: 0x440
// Size: 0x3c
function function_576e8126() {
    while (true) {
        localclientnum = level waittill(#"team_changed");
        level notify("team_changed" + localclientnum);
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// Checksum 0x7c234e2c, Offset: 0x488
// Size: 0x76
function function_c5c7c3ef(player) {
    for (parent = self getlinkedent(); isdefined(parent); parent = parent getlinkedent()) {
        if (parent == player) {
            return true;
        }
    }
    return false;
}

// Namespace prop
// Params 2, eflags: 0x0
// Checksum 0xd5799a55, Offset: 0x508
// Size: 0x12a
function function_8ef128e8(localclientnum, player) {
    if (isdefined(player.prop)) {
        return player.prop;
    }
    ents = getentarray(localclientnum);
    foreach (ent in ents) {
        if (!ent isplayer() && isdefined(ent.owner) && ent.owner == player && ent function_c5c7c3ef(player)) {
            return ent;
        }
    }
}

// Namespace prop
// Params 1, eflags: 0x0
// Checksum 0x821ae7ae, Offset: 0x640
// Size: 0x2b4
function setuppropplayernames(localclientnum) {
    level notify("setupPropPlayerNames" + localclientnum);
    level endon("setupPropPlayerNames" + localclientnum);
    while (true) {
        localplayer = getlocalplayer(localclientnum);
        spectating = isspectating(localclientnum, 0);
        players = getplayers(localclientnum);
        foreach (player in players) {
            if ((player != localplayer || spectating) && player ishidden() && isdefined(player.team) && player.team == localplayer.team) {
                player.prop = function_8ef128e8(localclientnum, player);
                if (isdefined(player.prop)) {
                    if (!(isdefined(player.var_3a6ca2d4) && player.var_3a6ca2d4)) {
                        player.prop setdrawownername(1, spectating);
                        player.var_3a6ca2d4 = 1;
                    }
                }
                continue;
            }
            if (isdefined(player.var_3a6ca2d4) && player.var_3a6ca2d4) {
                player.prop = function_8ef128e8(localclientnum, player);
                if (isdefined(player.prop)) {
                    player.prop setdrawownername(0, spectating);
                }
                player.var_3a6ca2d4 = 0;
            }
        }
        wait 1;
    }
}

// Namespace prop
// Params 7, eflags: 0x0
// Checksum 0xc2822249, Offset: 0x900
// Size: 0xbc
function highlightprop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        self notify(#"hash_e622a96b");
        self duplicate_render::update_dr_flag(localclientnum, "prop_ally", 0);
        self duplicate_render::update_dr_flag(localclientnum, "prop_clone", 0);
        return;
    }
    self thread function_e622a96b(localclientnum, newval);
}

// Namespace prop
// Params 2, eflags: 0x0
// Checksum 0x3d0579b0, Offset: 0x9c8
// Size: 0x208
function function_e622a96b(localclientnum, var_2300871f) {
    self endon(#"entityshutdown");
    level endon(#"disconnect");
    self notify(#"hash_e622a96b");
    self endon(#"hash_e622a96b");
    while (true) {
        localplayer = getlocalplayer(localclientnum);
        spectating = isspectating(localclientnum, 0) && !getinkillcam(localclientnum);
        var_9d961790 = (!isdefined(self.owner) || self.owner != localplayer || spectating) && isdefined(self.team) && isdefined(localplayer.team) && self.team == localplayer.team;
        if (var_2300871f == 1) {
            self duplicate_render::update_dr_flag(localclientnum, "prop_ally", var_9d961790);
            self duplicate_render::update_dr_flag(localclientnum, "prop_clone", 0);
        } else {
            self duplicate_render::update_dr_flag(localclientnum, "prop_clone", var_9d961790);
            self duplicate_render::update_dr_flag(localclientnum, "prop_ally", 0);
        }
        self duplicate_render::update_dr_filters(localclientnum);
        level util::waittill_any("team_changed" + localclientnum, "localPlayerSpectating" + localclientnum);
    }
}

// Namespace prop
// Params 7, eflags: 0x0
// Checksum 0x7a6d3b20, Offset: 0xbd8
// Size: 0x9c
function highlightplayer(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        self notify(#"hash_e622a96b");
        self duplicate_render::update_dr_flag(localclientnum, "prop_clone", 0);
        return;
    }
    self thread function_b001ad83(localclientnum, newval);
}

// Namespace prop
// Params 2, eflags: 0x0
// Checksum 0x158cf71d, Offset: 0xc80
// Size: 0x108
function function_b001ad83(localclientnum, var_2300871f) {
    self endon(#"entityshutdown");
    self notify(#"hash_b001ad83");
    self endon(#"hash_b001ad83");
    while (true) {
        localplayer = getlocalplayer(localclientnum);
        var_9d961790 = self != localplayer && isdefined(self.team) && isdefined(localplayer.team) && self.team == localplayer.team;
        self duplicate_render::update_dr_flag(localclientnum, "prop_clone", var_9d961790);
        level util::waittill_any("team_changed" + localclientnum, "localPlayerSpectating" + localclientnum);
    }
}

// Namespace prop
// Params 7, eflags: 0x0
// Checksum 0xbdd08b97, Offset: 0xd90
// Size: 0x1d4
function hideprop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    localplayer = getlocalplayer(localclientnum);
    var_9d961790 = newval && isdefined(self.owner) && self.owner == localplayer;
    if (var_9d961790) {
        self duplicate_render::update_dr_flag(localclientnum, "prop_look_through", 1);
        self duplicate_render::set_dr_flag("hide_model", 1);
        self duplicate_render::set_dr_flag("active_camo_reveal", 0);
        self duplicate_render::set_dr_flag("active_camo_on", 1);
        self duplicate_render::update_dr_filters(localclientnum);
        return;
    }
    self duplicate_render::update_dr_flag(localclientnum, "prop_look_through", 0);
    self duplicate_render::set_dr_flag("hide_model", 0);
    self duplicate_render::set_dr_flag("active_camo_reveal", 0);
    self duplicate_render::set_dr_flag("active_camo_on", 0);
    self duplicate_render::update_dr_filters(localclientnum);
}

// Namespace prop
// Params 7, eflags: 0x0
// Checksum 0x4f180108, Offset: 0xf70
// Size: 0xa4
function function_8e3b5ce2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 0) {
        self notify(#"hash_8819b68d");
        if (!self function_4ff87091(localclientnum)) {
            self show();
        }
        return;
    }
    self function_4bf4d3e1(localclientnum, newval);
}

// Namespace prop
// Params 1, eflags: 0x0
// Checksum 0x5555c2c0, Offset: 0x1020
// Size: 0x60
function function_4ff87091(localclientnum) {
    if (isdefined(self.prop)) {
        return true;
    }
    if (self isplayer()) {
        self.prop = function_8ef128e8(localclientnum, self);
        return isdefined(self.prop);
    }
    return false;
}

// Namespace prop
// Params 2, eflags: 0x0
// Checksum 0x3a1d49d9, Offset: 0x1088
// Size: 0x17a
function function_4bf4d3e1(localclientnum, teamint) {
    self endon(#"entityshutdown");
    self notify(#"hash_8819b68d");
    self endon(#"hash_8819b68d");
    assert(teamint == 1 || teamint == 2);
    team = "allies";
    if (teamint == 2) {
        team = "axis";
    }
    while (true) {
        localplayer = getlocalplayer(localclientnum);
        ishidden = isdefined(localplayer.team) && team == localplayer.team && !isspectating(localclientnum);
        if (ishidden) {
            self hide();
        } else if (!self function_4ff87091(localclientnum)) {
            self show();
        }
        level waittill("team_changed" + localclientnum);
    }
}

