#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_spectating;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/objpoints_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace dogtags;

// Namespace dogtags
// Params 0, eflags: 0x0
// Checksum 0x9991d1da, Offset: 0x3d0
// Size: 0x2a
function init() {
    level.antiboostdistance = getgametypesetting("antiBoostDistance");
    level.dogtags = [];
}

// Namespace dogtags
// Params 4, eflags: 0x0
// Checksum 0xd0446e44, Offset: 0x408
// Size: 0x7c3
function spawn_dog_tag(victim, attacker, on_use_function, objectives_for_attacker_and_victim_only) {
    if (isdefined(level.dogtags[victim.entnum])) {
        playfx("ui/fx_kill_confirmed_vanish", level.dogtags[victim.entnum].curorigin);
        level.dogtags[victim.entnum] notify(#"reset");
    } else {
        visuals[0] = spawn("script_model", (0, 0, 0));
        visuals[0] setmodel(victim getenemydogtagmodel());
        visuals[1] = spawn("script_model", (0, 0, 0));
        visuals[1] setmodel(victim getfriendlydogtagmodel());
        trigger = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
        level.dogtags[victim.entnum] = gameobjects::create_use_object("any", trigger, visuals, (0, 0, 16));
        level.dogtags[victim.entnum] gameobjects::set_use_time(0);
        level.dogtags[victim.entnum].onuse = &onuse;
        level.dogtags[victim.entnum].custom_onuse = on_use_function;
        level.dogtags[victim.entnum].victim = victim;
        level.dogtags[victim.entnum].victimteam = victim.team;
        level thread clear_on_victim_disconnect(victim);
        victim thread team_updater(level.dogtags[victim.entnum]);
        foreach (team in level.teams) {
            objective_add(level.dogtags[victim.entnum].objid[team], "invisible", (0, 0, 0));
            objective_icon(level.dogtags[victim.entnum].objid[team], "waypoint_dogtags");
            objective_team(level.dogtags[victim.entnum].objid[team], team);
            if (team == attacker.team) {
                objective_setcolor(level.dogtags[victim.entnum].objid[team], %EnemyOrange);
                continue;
            }
            objective_setcolor(level.dogtags[victim.entnum].objid[team], %FriendlyBlue);
        }
    }
    pos = victim.origin + (0, 0, 14);
    level.dogtags[victim.entnum].curorigin = pos;
    level.dogtags[victim.entnum].trigger.origin = pos;
    level.dogtags[victim.entnum].visuals[0].origin = pos;
    level.dogtags[victim.entnum].visuals[1].origin = pos;
    level.dogtags[victim.entnum].visuals[0] dontinterpolate();
    level.dogtags[victim.entnum].visuals[1] dontinterpolate();
    level.dogtags[victim.entnum] gameobjects::allow_use("any");
    level.dogtags[victim.entnum].visuals[0] thread show_to_team(level.dogtags[victim.entnum], attacker.team);
    level.dogtags[victim.entnum].visuals[1] thread show_to_enemy_teams(level.dogtags[victim.entnum], attacker.team);
    level.dogtags[victim.entnum].attacker = attacker;
    level.dogtags[victim.entnum].attackerteam = attacker.team;
    level.dogtags[victim.entnum].unreachable = undefined;
    level.dogtags[victim.entnum].tacinsert = 0;
    foreach (team in level.teams) {
        if (isdefined(level.dogtags[victim.entnum].objid[team])) {
            objective_position(level.dogtags[victim.entnum].objid[team], pos);
            objective_state(level.dogtags[victim.entnum].objid[team], "active");
        }
    }
    if (objectives_for_attacker_and_victim_only) {
        objective_setinvisibletoall(level.dogtags[victim.entnum].objid[attacker.team]);
        if (isplayer(attacker)) {
            objective_setvisibletoplayer(level.dogtags[victim.entnum].objid[attacker.team], attacker);
        }
        objective_setinvisibletoall(level.dogtags[victim.entnum].objid[victim.team]);
        if (isplayer(victim)) {
            objective_setvisibletoplayer(level.dogtags[victim.entnum].objid[victim.team], victim);
        }
    }
    level.dogtags[victim.entnum] thread bounce();
    level notify(#"dogtag_spawned");
}

// Namespace dogtags
// Params 2, eflags: 0x0
// Checksum 0xecb04a37, Offset: 0xbd8
// Size: 0x92
function show_to_team(gameobject, show_team) {
    self show();
    foreach (team in level.teams) {
        self hidefromteam(team);
    }
    self showtoteam(show_team);
}

// Namespace dogtags
// Params 2, eflags: 0x0
// Checksum 0xbf35b1b1, Offset: 0xc78
// Size: 0x92
function show_to_enemy_teams(gameobject, friend_team) {
    self show();
    foreach (team in level.teams) {
        self showtoteam(team);
    }
    self hidefromteam(friend_team);
}

// Namespace dogtags
// Params 1, eflags: 0x0
// Checksum 0x47818589, Offset: 0xd18
// Size: 0x1a2
function onuse(player) {
    self.visuals[0] playsound("mpl_killconfirm_tags_pickup");
    tacinsertboost = 0;
    if (player.team != self.attackerteam) {
        player addplayerstat("KILLSDENIED", 1);
        player recordgameevent("return");
        if (self.victim == player) {
            if (self.tacinsert == 0) {
                event = "retrieve_own_tags";
            } else {
                tacinsertboost = 1;
            }
        } else {
            event = "kill_denied";
        }
        if (!tacinsertboost) {
            player.pers["killsdenied"]++;
            player.killsdenied = player.pers["killsdenied"];
        }
    } else {
        event = "kill_confirmed";
        player addplayerstat("KILLSCONFIRMED", 1);
        player recordgameevent("capture");
        if (isdefined(self.attacker) && self.attacker != player) {
            self.attacker onpickup("teammate_kill_confirmed");
        }
    }
    if (!tacinsertboost && isdefined(player)) {
        player onpickup(event);
    }
    [[ self.custom_onuse ]](player);
    self reset_tags();
}

// Namespace dogtags
// Params 0, eflags: 0x0
// Checksum 0x4e824c51, Offset: 0xec8
// Size: 0x13b
function reset_tags() {
    self.attacker = undefined;
    self.unreachable = undefined;
    self notify(#"reset");
    self.visuals[0] hide();
    self.visuals[1] hide();
    self.curorigin = (0, 0, 1000);
    self.trigger.origin = (0, 0, 1000);
    self.visuals[0].origin = (0, 0, 1000);
    self.visuals[1].origin = (0, 0, 1000);
    self.tacinsert = 0;
    self gameobjects::allow_use("none");
    foreach (team in level.teams) {
        objective_state(self.objid[team], "invisible");
    }
}

// Namespace dogtags
// Params 1, eflags: 0x0
// Checksum 0xde231834, Offset: 0x1010
// Size: 0x1a
function onpickup(event) {
    scoreevents::processscoreevent(event, self);
}

// Namespace dogtags
// Params 1, eflags: 0x0
// Checksum 0xe66677b4, Offset: 0x1038
// Size: 0x1a6
function clear_on_victim_disconnect(victim) {
    level endon(#"game_ended");
    guid = victim.entnum;
    victim waittill(#"disconnect");
    if (isdefined(level.dogtags[guid])) {
        level.dogtags[guid] gameobjects::allow_use("none");
        playfx("ui/fx_kill_confirmed_vanish", level.dogtags[guid].curorigin);
        level.dogtags[guid] notify(#"reset");
        wait 0.05;
        if (isdefined(level.dogtags[guid])) {
            foreach (team in level.teams) {
                objective_delete(level.dogtags[guid].objid[team]);
            }
            level.dogtags[guid].trigger delete();
            for (i = 0; i < level.dogtags[guid].visuals.size; i++) {
                level.dogtags[guid].visuals[i] delete();
            }
            level.dogtags[guid] notify(#"deleted");
            level.dogtags[guid] = undefined;
        }
    }
}

// Namespace dogtags
// Params 0, eflags: 0x0
// Checksum 0x641a029e, Offset: 0x11e8
// Size: 0xb6
function on_spawn_player() {
    if (level.rankedmatch || level.leaguematch) {
        if (isdefined(self.tacticalinsertiontime) && self.tacticalinsertiontime + 100 > gettime()) {
            mindist = level.antiboostdistance;
            mindistsqr = mindist * mindist;
            distsqr = distancesquared(self.origin, level.dogtags[self.entnum].curorigin);
            if (distsqr < mindistsqr) {
                level.dogtags[self.entnum].tacinsert = 1;
            }
        }
    }
}

// Namespace dogtags
// Params 1, eflags: 0x0
// Checksum 0xdd2b2145, Offset: 0x12a8
// Size: 0x4d
function team_updater(tags) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"joined_team");
        tags.victimteam = self.team;
        tags reset_tags();
    }
}

// Namespace dogtags
// Params 1, eflags: 0x0
// Checksum 0xb15852c5, Offset: 0x1300
// Size: 0xf2
function time_out(victim) {
    level endon(#"game_ended");
    victim endon(#"disconnect");
    self notify(#"timeout");
    self endon(#"timeout");
    level hostmigration::waitlongdurationwithhostmigrationpause(30);
    self.visuals[0] hide();
    self.visuals[1] hide();
    self.curorigin = (0, 0, 1000);
    self.trigger.origin = (0, 0, 1000);
    self.visuals[0].origin = (0, 0, 1000);
    self.visuals[1].origin = (0, 0, 1000);
    self.tacinsert = 0;
    self gameobjects::allow_use("none");
}

// Namespace dogtags
// Params 0, eflags: 0x0
// Checksum 0xe4ed3d6, Offset: 0x1400
// Size: 0x195
function bounce() {
    level endon(#"game_ended");
    self endon(#"reset");
    bottompos = self.curorigin;
    toppos = self.curorigin + (0, 0, 12);
    while (true) {
        self.visuals[0] moveto(toppos, 0.5, 0.15, 0.15);
        self.visuals[0] rotateyaw(-76, 0.5);
        self.visuals[1] moveto(toppos, 0.5, 0.15, 0.15);
        self.visuals[1] rotateyaw(-76, 0.5);
        wait 0.5;
        self.visuals[0] moveto(bottompos, 0.5, 0.15, 0.15);
        self.visuals[0] rotateyaw(-76, 0.5);
        self.visuals[1] moveto(bottompos, 0.5, 0.15, 0.15);
        self.visuals[1] rotateyaw(-76, 0.5);
        wait 0.5;
    }
}

// Namespace dogtags
// Params 0, eflags: 0x0
// Checksum 0x6ff04c28, Offset: 0x15a0
// Size: 0x22
function checkallowspectating() {
    self endon(#"disconnect");
    wait 0.05;
    spectating::update_settings();
}

// Namespace dogtags
// Params 9, eflags: 0x0
// Checksum 0xaae76dda, Offset: 0x15d0
// Size: 0x105
function should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
    if (isalive(self)) {
        return false;
    }
    if (isdefined(self.switching_teams)) {
        return false;
    }
    if (isdefined(attacker) && attacker == self) {
        return false;
    }
    if (level.teambased && isdefined(attacker) && isdefined(attacker.team) && attacker.team == self.team) {
        return false;
    }
    if (attacker.classname == "trigger_hurt" || (!isdefined(attacker.team) || isdefined(attacker) && attacker.team == "free") && attacker.classname == "worldspawn") {
        return false;
    }
    return true;
}

// Namespace dogtags
// Params 1, eflags: 0x0
// Checksum 0xe3025742, Offset: 0x16e0
// Size: 0x82
function onusedogtag(player) {
    if (player.pers["team"] == self.victimteam) {
        player.pers["rescues"]++;
        player.rescues = player.pers["rescues"];
        if (isdefined(self.victim)) {
            if (!level.gameended) {
                self.victim thread dt_respawn();
            }
        }
    }
}

// Namespace dogtags
// Params 0, eflags: 0x0
// Checksum 0xe06026ae, Offset: 0x1770
// Size: 0x12
function dt_respawn() {
    self thread waittillcanspawnclient();
}

// Namespace dogtags
// Params 0, eflags: 0x0
// Checksum 0x8b8af55d, Offset: 0x1790
// Size: 0x5b
function waittillcanspawnclient() {
    for (;;) {
        wait 0.05;
        if (self.sessionstate == "spectator" || isdefined(self) && !isalive(self)) {
            self.pers["lives"] = 1;
            self thread [[ level.spawnclient ]]();
            continue;
        }
        return;
    }
}

