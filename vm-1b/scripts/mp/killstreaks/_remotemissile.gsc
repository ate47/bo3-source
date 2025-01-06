#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreak_detect;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/clientfield_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace remotemissile;

// Namespace remotemissile
// Params 0, eflags: 0x0
// Checksum 0xea92abef, Offset: 0x8b0
// Size: 0x21a
function init() {
    level.rockets = [];
    killstreaks::register("remote_missile", "remote_missile", "killstreak_remote_missile", "remote_missle_used", &tryusepredatormissile, 1);
    killstreaks::register_alt_weapon("remote_missile", "remote_missile_missile");
    killstreaks::register_alt_weapon("remote_missile", "remote_missile_bomblet");
    killstreaks::function_f79fd1e9("remote_missile", %KILLSTREAK_EARNED_REMOTE_MISSILE, %KILLSTREAK_REMOTE_MISSILE_NOT_AVAILABLE, %KILLSTREAK_REMOTE_MISSILE_INBOUND, undefined, %KILLSTREAK_REMOTE_MISSILE_HACKED);
    killstreaks::register_dialog("remote_missile", "mpl_killstreak_cruisemissile", "remoteMissileDialogBundle", "remoteMissilePilotDialogBundle", "friendlyRemoteMissile", "enemyRemoteMissile", "enemyRemoteMissileMultiple", "friendlyRemoteMissileHacked", "enemyRemoteMissileHacked", "requestRemoteMissile");
    killstreaks::set_team_kill_penalty_scale("remote_missile", level.teamkillreducedpenalty);
    killstreaks::override_entity_camera_in_demo("remote_missile", 1);
    clientfield::register("missile", "remote_missile_bomblet_fired", 1, 1, "int");
    clientfield::register("missile", "remote_missile_fired", 1, 2, "int");
    level.missilesforsighttraces = [];
    level.missileremotedeployfx = "killstreaks/fx_predator_trigger";
    level.missileremotelaunchvert = 18000;
    level.missileremotelaunchhorz = 7000;
    level.missileremotelaunchtargetdist = 1500;
    visionset_mgr::register_info("visionset", "remote_missile_visionset", 1, 110, 16, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
}

// Namespace remotemissile
// Params 3, eflags: 0x0
// Checksum 0x5e1523ae, Offset: 0xad8
// Size: 0x53
function remote_missile_game_end_think(rocket, team, killstreak_id) {
    self endon(#"remotemissle_killstreak_done");
    level waittill(#"game_ended");
    self thread function_6cc54cf1(rocket, 1, 1, team, killstreak_id);
    self notify(#"remotemissle_killstreak_done");
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0x93d42362, Offset: 0xb38
// Size: 0xe6
function tryusepredatormissile(lifeid) {
    waterdepth = self depthofplayerinwater();
    if (!self isonground() || self util::isusingremote() || waterdepth > 2) {
        self iprintlnbold(%KILLSTREAK_REMOTE_MISSILE_NOT_USABLE);
        return 0;
    }
    team = self.team;
    killstreak_id = self killstreakrules::killstreakstart("remote_missile", team, 0, 1);
    if (killstreak_id == -1) {
        return 0;
    }
    self.remotemissilepilotindex = killstreaks::get_random_pilot_index("remote_missile");
    returnvar = _fire(lifeid, self, team, killstreak_id);
    return returnvar;
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0x8931d9f9, Offset: 0xc28
// Size: 0x32d
function getbestspawnpoint(remotemissilespawnpoints) {
    validenemies = [];
    foreach (spawnpoint in remotemissilespawnpoints) {
        spawnpoint.validplayers = [];
        spawnpoint.spawnscore = 0;
    }
    foreach (player in level.players) {
        if (!isalive(player)) {
            continue;
        }
        if (player.team == self.team) {
            continue;
        }
        if (player.team == "spectator") {
            continue;
        }
        bestdistance = 999999999;
        bestspawnpoint = undefined;
        foreach (spawnpoint in remotemissilespawnpoints) {
            spawnpoint.validplayers[spawnpoint.validplayers.size] = player;
            potentialbestdistance = distance2dsquared(spawnpoint.targetent.origin, player.origin);
            if (potentialbestdistance <= bestdistance) {
                bestdistance = potentialbestdistance;
                bestspawnpoint = spawnpoint;
            }
        }
        bestspawnpoint.spawnscore += 2;
    }
    bestspawn = remotemissilespawnpoints[0];
    foreach (spawnpoint in remotemissilespawnpoints) {
        foreach (player in spawnpoint.validplayers) {
            spawnpoint.spawnscore += 1;
            if (bullettracepassed(player.origin + (0, 0, 32), spawnpoint.origin, 0, player)) {
                spawnpoint.spawnscore += 3;
            }
            if (spawnpoint.spawnscore > bestspawn.spawnscore) {
                bestspawn = spawnpoint;
                continue;
            }
            if (spawnpoint.spawnscore == bestspawn.spawnscore) {
                if (math::cointoss()) {
                    bestspawn = spawnpoint;
                }
            }
        }
    }
    return bestspawn;
}

/#

    // Namespace remotemissile
    // Params 4, eflags: 0x0
    // Checksum 0x325ed475, Offset: 0xf60
    // Size: 0x81
    function drawline(start, end, timeslice, color) {
        drawtime = int(timeslice * 20);
        for (time = 0; time < drawtime; time++) {
            line(start, end, color, 0, 1);
            wait 0.05;
        }
    }

#/

// Namespace remotemissile
// Params 4, eflags: 0x0
// Checksum 0xcc9007ec, Offset: 0xff0
// Size: 0x5c7
function _fire(lifeid, player, team, killstreak_id) {
    remotemissilespawnarray = getentarray("remoteMissileSpawn", "targetname");
    foreach (spawn in remotemissilespawnarray) {
        if (isdefined(spawn.target)) {
            spawn.targetent = getent(spawn.target, "targetname");
        }
    }
    if (remotemissilespawnarray.size > 0) {
        remotemissilespawn = player getbestspawnpoint(remotemissilespawnarray);
    } else {
        remotemissilespawn = undefined;
    }
    if (isdefined(remotemissilespawn)) {
        startpos = remotemissilespawn.origin;
        targetpos = remotemissilespawn.targetent.origin;
        vector = vectornormalize(startpos - targetpos);
        startpos = vector * level.missileremotelaunchvert + targetpos;
    } else {
        upvector = (0, 0, level.missileremotelaunchvert);
        backdist = level.missileremotelaunchhorz;
        targetdist = level.missileremotelaunchtargetdist;
        forward = anglestoforward(player.angles);
        startpos = player.origin + upvector + forward * backdist * -1;
        targetpos = player.origin + forward * targetdist;
    }
    self util::setusingremote("remote_missile");
    self util::freeze_player_controls(1);
    player disableweaponcycling();
    result = self killstreaks::init_ride_killstreak("qrdrone");
    if (result != "success") {
        if (result != "disconnect") {
            player util::freeze_player_controls(0);
            player killstreaks::clear_using_remote();
            player enableweaponcycling();
            killstreakrules::killstreakstop("remote_missile", team, killstreak_id);
        }
        return false;
    }
    rocket = magicbullet(getweapon("remote_missile_missile"), startpos, targetpos, player);
    rocket.forceonemissile = 1;
    forceanglevector = vectornormalize(targetpos - startpos);
    rocket.angles = vectortoangles(forceanglevector);
    rocket.targetname = "remote_missile";
    rocket killstreaks::configure_team("remote_missile", killstreak_id, self, undefined, undefined, undefined);
    rocket killstreak_hacking::enable_hacking("remote_missile", undefined, &hackedpostfunction);
    killstreak_detect::killstreaktargetset(rocket);
    rocket.hackedhealthupdatecallback = &hackedhealthupdate;
    rocket thread handledamage();
    player linktomissile(rocket, 1, 1);
    rocket.owner = player;
    rocket.killcament = player;
    player thread cleanupwaiter(rocket, player.team, killstreak_id);
    visionset_mgr::activate("visionset", "remote_missile_visionset", player, 0, 90000, 0);
    player setmodellodbias(isdefined(level.remotemissile_lod_bias) ? level.remotemissile_lod_bias : 12);
    self clientfield::set_to_player("fog_bank_2", 1);
    self clientfield::set("operating_predator", 1);
    self killstreaks::play_killstreak_start_dialog("remote_missile", self.pers["team"], killstreak_id);
    self addweaponstat(getweapon("remote_missile"), "used", 1);
    rocket thread function_45c10a49();
    rocket missile_sound_play(player);
    rocket thread missile_brake_timeout_watch();
    rocket thread missile_sound_impact(player, 3750);
    player thread missile_sound_boost(rocket);
    player thread missile_deploy_watch(rocket);
    player thread remote_missile_game_end_think(rocket, player.team, killstreak_id);
    player thread watch_missile_death(rocket, player.team, killstreak_id);
    player thread sndwatchexplo();
    rocket spawning::create_entity_enemy_influencer("small_vehicle", rocket.team);
    player util::freeze_player_controls(0);
    player waittill(#"remotemissle_killstreak_done");
    return true;
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0x37513985, Offset: 0x15c0
// Size: 0xa
function hackedhealthupdate(hacker) {
    
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0x4f49853d, Offset: 0x15d8
// Size: 0x2a
function hackedpostfunction(hacker) {
    rocket = self;
    hacker missile_deploy(rocket, 1);
}

// Namespace remotemissile
// Params 0, eflags: 0x0
// Checksum 0x4e5c5654, Offset: 0x1610
// Size: 0x22
function function_45c10a49() {
    wait 0.1;
    self clientfield::set("remote_missile_fired", 1);
}

// Namespace remotemissile
// Params 3, eflags: 0x0
// Checksum 0x52cc8c20, Offset: 0x1640
// Size: 0x63
function watch_missile_death(rocket, team, killstreak_id) {
    self endon(#"remotemissle_killstreak_done");
    rocket waittill(#"death");
    self thread function_6cc54cf1(rocket, 1, 1, team, killstreak_id);
    self thread remotemissile_bda_dialog();
    self notify(#"remotemissle_killstreak_done");
}

// Namespace remotemissile
// Params 5, eflags: 0x0
// Checksum 0xbe1ffaaa, Offset: 0x16b0
// Size: 0x1ca
function function_6cc54cf1(rocket, performplayerkillstreakend, unlink, team, killstreak_id) {
    self notify(#"player_missile_end_singleton");
    self endon(#"player_missile_end_singleton");
    if (isalive(rocket)) {
        rocket spawning::remove_influencers();
        rocket clientfield::set("remote_missile_fired", 0);
        rocket delete();
    }
    self notify(#"snd1stpersonexplo");
    if (isdefined(self)) {
        self thread destroy_missile_hud();
        if (isdefined(performplayerkillstreakend) && performplayerkillstreakend) {
            self playrumbleonentity("grenade_rumble");
            if (level.gameended == 0) {
                self sendkillstreakdamageevent(600);
            }
            if (isdefined(rocket)) {
                rocket hide();
            }
        }
        self clientfield::set("operating_predator", 0);
        self clientfield::set_to_player("fog_bank_2", 0);
        visionset_mgr::deactivate("visionset", "remote_missile_visionset", self);
        self setmodellodbias(0);
        if (unlink) {
            self unlinkfrommissile();
        }
        self notify(#"remotemissile_done");
        self util::freeze_player_controls(0);
        self killstreaks::clear_using_remote();
        self enableweaponcycling();
        killstreakrules::killstreakstop("remote_missile", team, killstreak_id);
    }
}

// Namespace remotemissile
// Params 0, eflags: 0x0
// Checksum 0xcf21dc1c, Offset: 0x1888
// Size: 0x82
function missile_brake_timeout_watch() {
    rocket = self;
    player = rocket.owner;
    self endon(#"death");
    self waittill(#"missile_brake");
    rocket playsound("wpn_remote_missile_brake_npc");
    player playlocalsound("wpn_remote_missile_brake_plr");
    wait 1.5;
    if (isdefined(self)) {
        self setmissilebrake(0);
    }
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0x8b636bac, Offset: 0x1918
// Size: 0x2a
function stopondeath(snd) {
    self waittill(#"death");
    if (isdefined(snd)) {
        snd delete();
    }
}

// Namespace remotemissile
// Params 3, eflags: 0x0
// Checksum 0x9ec76f8a, Offset: 0x1950
// Size: 0x6b
function cleanupwaiter(rocket, team, killstreak_id) {
    self endon(#"remotemissle_killstreak_done");
    self util::waittill_any("joined_team", "joined_spectators", "disconnect");
    self thread function_6cc54cf1(rocket, 0, 0, team, killstreak_id);
    self notify(#"remotemissle_killstreak_done");
}

// Namespace remotemissile
// Params 0, eflags: 0x0
// Checksum 0x482d49ce, Offset: 0x19c8
// Size: 0x155
function handledamage() {
    self endon(#"death");
    self endon(#"deleted");
    self setcandamage(1);
    self.health = 99999;
    for (;;) {
        self waittill(#"damage", damage, attacker, direction_vec, point, meansofdeath, tagname, modelname, partname, weapon);
        if (isdefined(attacker) && isdefined(self.owner)) {
            if (self.owner util::isenemyplayer(attacker)) {
                scoreevents::processscoreevent("destroyed_remote_missile", attacker, self.owner, weapon);
                attacker addweaponstat(weapon, "destroyed_controlled_killstreak", 1);
            }
            self.owner sendkillstreakdamageevent(int(damage));
        }
        self spawning::remove_influencers();
        self detonate();
    }
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0x63910bbb, Offset: 0x1b28
// Size: 0x142
function function_5e8614bc(duration) {
    self endon(#"disconnect");
    var_d4e19fd2 = newclienthudelem(self);
    var_d4e19fd2.horzalign = "fullscreen";
    var_d4e19fd2.vertalign = "fullscreen";
    var_d4e19fd2 setshader("white", 640, 480);
    var_d4e19fd2.archive = 1;
    var_d4e19fd2.sort = 10;
    var_d4e19fd2.immunetodemogamehudsettings = 1;
    static = newclienthudelem(self);
    static.horzalign = "fullscreen";
    static.vertalign = "fullscreen";
    static.archive = 1;
    static.sort = 20;
    static.immunetodemogamehudsettings = 1;
    self clientfield::set("remote_killstreak_static", 1);
    wait duration;
    self clientfield::set("remote_killstreak_static", 0);
    static destroy();
    var_d4e19fd2 destroy();
}

// Namespace remotemissile
// Params 0, eflags: 0x0
// Checksum 0x924303eb, Offset: 0x1c78
// Size: 0x3a
function rocket_cleanupondeath() {
    entitynumber = self getentitynumber();
    level.rockets[entitynumber] = self;
    self waittill(#"death");
    level.rockets[entitynumber] = undefined;
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0x9dc21318, Offset: 0x1cc0
// Size: 0x1aa
function missile_sound_play(player) {
    self.snd_first = spawn("script_model", self.origin);
    self.snd_first setmodel("tag_origin");
    self.snd_first linkto(self);
    self.snd_first setinvisibletoall();
    self.snd_first setvisibletoplayer(player);
    self.snd_first playloopsound("wpn_remote_missile_loop_plr", 0.5);
    self thread stopondeath(self.snd_first);
    self.snd_third = spawn("script_model", self.origin);
    self.snd_third setmodel("tag_origin");
    self.snd_third linkto(self);
    self.snd_third setvisibletoall();
    self.snd_third setinvisibletoplayer(player);
    self.snd_third playloopsound("wpn_remote_missile_loop_npc", 0.2);
    self thread stopondeath(self.snd_third);
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0x33c3e353, Offset: 0x1e78
// Size: 0xfa
function missile_sound_boost(rocket) {
    self endon(#"remotemissile_done");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    self endon(#"disconnect");
    self waittill(#"missile_boost");
    rocket playsound("wpn_remote_missile_fire_boost_npc");
    rocket.snd_third playloopsound("wpn_remote_missile_boost_npc");
    self playlocalsound("wpn_remote_missile_fire_boost_plr");
    rocket.snd_first playloopsound("wpn_remote_missile_boost_plr");
    self playrumbleonentity("sniper_fire");
    if (rocket.origin[2] - self.origin[2] > 4000) {
        rocket notify(#"stop_impact_sound");
        rocket thread missile_sound_impact(self, 6250);
    }
}

// Namespace remotemissile
// Params 2, eflags: 0x0
// Checksum 0xabd41143, Offset: 0x1f80
// Size: 0x85
function missile_sound_impact(player, distance) {
    self endon(#"death");
    self endon(#"stop_impact_sound");
    player endon(#"disconnect");
    player endon(#"remotemissile_done");
    player endon(#"joined_team");
    player endon(#"joined_spectators");
    for (;;) {
        if (self.origin[2] - player.origin[2] < distance) {
            self playsound("wpn_remote_missile_inc");
            return;
        }
        wait 0.05;
    }
}

// Namespace remotemissile
// Params 0, eflags: 0x0
// Checksum 0xcdc05404, Offset: 0x2010
// Size: 0x52
function sndwatchexplo() {
    self endon(#"remotemissle_killstreak_done");
    self endon(#"remotemissile_done");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    self endon(#"disconnect");
    self endon(#"bomblets_deployed");
    self waittill(#"snd1stpersonexplo");
    self playlocalsound("wpn_remote_missile_explode_plr");
}

// Namespace remotemissile
// Params 0, eflags: 0x0
// Checksum 0x37ce3b46, Offset: 0x2070
// Size: 0x2a
function missile_sound_deploy_bomblets() {
    self.snd_first playloopsound("wpn_remote_missile_loop_plr", 0.5);
}

// Namespace remotemissile
// Params 3, eflags: 0x0
// Checksum 0xd39e1ed2, Offset: 0x20a8
// Size: 0x56c
function getvalidtargets(rocket, trace, max_targets) {
    pixbeginevent("remotemissile_getVTs_header");
    targets = [];
    forward = anglestoforward(rocket.angles);
    rocketz = rocket.origin[2];
    mapcenterz = level.mapcenter[2];
    diff = mapcenterz - rocketz;
    ratio = diff / forward[2];
    aimtarget = rocket.origin + forward * ratio;
    rocket.aimtarget = aimtarget;
    pixendevent();
    pixbeginevent("remotemissile_getVTs_enemies");
    enemies = self getenemies();
    foreach (player in enemies) {
        if (!isplayer(player)) {
            continue;
        }
        if (distance2dsquared(player.origin, aimtarget) < 360000 && !player hasperk("specialty_nokillstreakreticle")) {
            if (trace) {
                if (bullettracepassed(player.origin + (0, 0, 60), player.origin + (0, 0, 180), 0, player)) {
                    targets[targets.size] = player;
                }
            } else {
                targets[targets.size] = player;
            }
            if (targets.size >= max_targets) {
                return targets;
            }
        }
    }
    dogs = getentarray("attack_dog", "targetname");
    foreach (dog in dogs) {
        if (dog.team != self.team && distance2dsquared(dog.origin, aimtarget) < 360000) {
            if (trace) {
                if (bullettracepassed(dog.origin + (0, 0, 60), dog.origin + (0, 0, 180), 0, dog)) {
                    targets[targets.size] = dog;
                }
            } else {
                targets[targets.size] = dog;
            }
            if (targets.size >= max_targets) {
                return targets;
            }
        }
    }
    tanks = getentarray("talon", "targetname");
    foreach (tank in tanks) {
        if (tank.team != self.team && distance2dsquared(tank.origin, aimtarget) < 360000) {
            if (trace) {
                if (bullettracepassed(tank.origin + (0, 0, 60), tank.origin + (0, 0, 180), 0, tank)) {
                    targets[targets.size] = tank;
                }
            } else {
                targets[targets.size] = tank;
            }
            if (targets.size >= max_targets) {
                return targets;
            }
        }
    }
    turrets = getentarray("auto_turret", "classname");
    foreach (turret in turrets) {
        if (turret.team != self.team && distance2dsquared(turret.origin, aimtarget) < 360000) {
            if (trace) {
                if (bullettracepassed(turret.origin + (0, 0, 60), turret.origin + (0, 0, 180), 0, turret)) {
                    targets[targets.size] = turret;
                }
            } else {
                targets[targets.size] = turret;
            }
            if (targets.size >= max_targets) {
                return targets;
            }
        }
    }
    pixendevent();
    return targets;
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0xa164d658, Offset: 0x2620
// Size: 0x2a2
function create_missile_hud(rocket) {
    self.var_6e79a70e = [];
    foreach (player in level.players) {
        if (player == self) {
            continue;
        }
        if (level.teambased && player.team == self.team) {
            continue;
        }
        index = player.clientid;
        self.var_6e79a70e[index] = newclienthudelem(self);
        self.var_6e79a70e[index].x = 0;
        self.var_6e79a70e[index].y = 0;
        self.var_6e79a70e[index].z = 0;
        self.var_6e79a70e[index].alpha = 0;
        self.var_6e79a70e[index].archived = 1;
        self.var_6e79a70e[index] setshader("hud_remote_missile_target", -81, -81);
        self.var_6e79a70e[index] setwaypoint(0);
        self.var_6e79a70e[index].hidewheninmenu = 1;
        self.var_6e79a70e[index].immunetodemogamehudsettings = 1;
    }
    for (i = 0; i < 3; i++) {
        self.var_9f313f0a[i] = newclienthudelem(self);
        self.var_9f313f0a[i].x = 0;
        self.var_9f313f0a[i].y = 0;
        self.var_9f313f0a[i].z = 0;
        self.var_9f313f0a[i].alpha = 0;
        self.var_9f313f0a[i].archived = 1;
        self.var_9f313f0a[i] setshader("hud_remote_missile_target", -81, -81);
        self.var_9f313f0a[i] setwaypoint(0);
        self.var_9f313f0a[i].hidewheninmenu = 1;
        self.var_9f313f0a[i].immunetodemogamehudsettings = 1;
    }
    rocket.iconindexother = 0;
    self thread targeting_hud_think(rocket);
}

// Namespace remotemissile
// Params 0, eflags: 0x0
// Checksum 0x6f1ac64d, Offset: 0x28d0
// Size: 0xf1
function destroy_missile_hud() {
    if (isdefined(self.var_6e79a70e)) {
        foreach (player in level.players) {
            if (player == self) {
                continue;
            }
            index = player.clientid;
            if (isdefined(self.var_6e79a70e[index])) {
                self.var_6e79a70e[index] destroy();
            }
        }
    }
    if (isdefined(self.var_9f313f0a)) {
        for (i = 0; i < 3; i++) {
            if (isdefined(self.var_9f313f0a[i])) {
                self.var_9f313f0a[i] destroy();
            }
        }
    }
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0xa95a5404, Offset: 0x29d0
// Size: 0x2b9
function targeting_hud_think(rocket) {
    self endon(#"disconnect");
    self endon(#"remotemissile_done");
    rocket endon(#"death");
    level endon(#"game_ended");
    targets = self getvalidtargets(rocket, 1, 6);
    framessincetargetscan = 0;
    while (true) {
        foreach (icon in self.var_6e79a70e) {
            icon.alpha = 0;
        }
        framessincetargetscan++;
        if (framessincetargetscan > 5) {
            targets = self getvalidtargets(rocket, 1, 6);
            framessincetargetscan = 0;
        }
        if (targets.size > 0) {
            foreach (target in targets) {
                if (isdefined(target) == 0) {
                    continue;
                }
                if (isplayer(target)) {
                    if (isalive(target)) {
                        index = target.clientid;
                        assert(isdefined(index));
                        self.var_6e79a70e[index].x = target.origin[0];
                        self.var_6e79a70e[index].y = target.origin[1];
                        self.var_6e79a70e[index].z = target.origin[2] + 47;
                        self.var_6e79a70e[index].alpha = 1;
                    }
                    continue;
                }
                if (!isdefined(target.missileiconindex)) {
                    target.missileiconindex = rocket.iconindexother;
                    rocket.iconindexother = (rocket.iconindexother + 1) % 3;
                }
                index = target.missileiconindex;
                self.var_9f313f0a[index].x = target.origin[0];
                self.var_9f313f0a[index].y = target.origin[1];
                self.var_9f313f0a[index].z = target.origin[2];
                self.var_9f313f0a[index].alpha = 1;
            }
        }
        wait 0.1;
    }
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0x4eee55fd, Offset: 0x2c98
// Size: 0x89
function missile_deploy_watch(rocket) {
    self endon(#"disconnect");
    self endon(#"remotemissile_done");
    rocket endon(#"remotemissile_bomblets_launched");
    rocket endon(#"death");
    level endon(#"game_ended");
    wait 0.25;
    self thread create_missile_hud(rocket);
    while (true) {
        if (self attackbuttonpressed()) {
            self thread missile_deploy(rocket, 0);
            continue;
        }
        wait 0.05;
    }
}

// Namespace remotemissile
// Params 2, eflags: 0x0
// Checksum 0xd3e660f0, Offset: 0x2d30
// Size: 0x28c
function missile_deploy(rocket, hacked) {
    rocket notify(#"remotemissile_bomblets_launched");
    waitframes = 2;
    explosionradius = 0;
    targets = self getvalidtargets(rocket, 0, 6);
    if (targets.size > 0) {
        foreach (target in targets) {
            self thread fire_bomblet(rocket, explosionradius, target, waitframes);
            waitframes++;
        }
    }
    if (rocket.origin[2] - self.origin[2] > 4000) {
        rocket notify(#"stop_impact_sound");
    }
    if (hacked == 1) {
        rocket.originalowner thread hud::fade_to_black_for_x_sec(0, 0.15, 0, 0, "white");
        self notify(#"remotemissile_done");
    }
    rocket clientfield::set("remote_missile_fired", 2);
    for (i = targets.size; i < 6; i++) {
        self thread fire_random_bomblet(rocket, explosionradius, i % 6, waitframes);
        waitframes++;
    }
    playfx(level.missileremotedeployfx, rocket.origin, anglestoforward(rocket.angles));
    self playlocalsound("mpl_rc_exp");
    self playrumbleonentity("sniper_fire");
    earthquake(0.2, 0.2, rocket.origin, -56);
    rocket hide();
    rocket setmissilecoasting(1);
    if (hacked == 0) {
        self thread hud::fade_to_black_for_x_sec(0, 0.15, 0, 0, "white");
    }
    rocket missile_sound_deploy_bomblets();
    self thread bomblet_camera_waiter(rocket);
    self notify(#"bomblets_deployed");
    if (hacked == 1) {
        rocket notify(#"death");
    }
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0x117ffe0f, Offset: 0x2fc8
// Size: 0x73
function bomblet_camera_waiter(rocket) {
    self endon(#"disconnect");
    self endon(#"remotemissile_done");
    rocket endon(#"death");
    level endon(#"game_ended");
    delay = getdvarfloat("scr_rmbomblet_camera_delaytime", 1);
    self waittill(#"bomblet_exploded");
    wait delay;
    rocket notify(#"death");
    self notify(#"remotemissile_done");
}

// Namespace remotemissile
// Params 0, eflags: 0x0
// Checksum 0xcffd96b2, Offset: 0x3048
// Size: 0x22
function setup_bomblet_map_icon() {
    wait 0.1;
    self clientfield::set("remote_missile_bomblet_fired", 1);
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0xad22db1a, Offset: 0x3078
// Size: 0x62
function setup_bomblet(bomb) {
    bomb.team = self.team;
    bomb setteam(self.team);
    bomb thread setup_bomblet_map_icon();
    bomb.killcament = self;
    bomb thread function_6390ee7d(self);
}

// Namespace remotemissile
// Params 4, eflags: 0x0
// Checksum 0x87d74036, Offset: 0x30e8
// Size: 0xc2
function fire_bomblet(rocket, explosionradius, target, waitframes) {
    origin = rocket.origin;
    targetorigin = target.origin + (0, 0, 50);
    wait waitframes * 0.05;
    if (isdefined(rocket)) {
        origin = rocket.origin;
    }
    bomb = magicbullet(getweapon("remote_missile_bomblet"), origin, targetorigin, self, target, (0, 0, 30));
    setup_bomblet(bomb);
}

// Namespace remotemissile
// Params 4, eflags: 0x0
// Checksum 0x6921542b, Offset: 0x31b8
// Size: 0x17a
function fire_random_bomblet(rocket, explosionradius, quadrant, waitframes) {
    origin = rocket.origin;
    angles = rocket.angles;
    owner = rocket.owner;
    aimtarget = rocket.aimtarget;
    wait waitframes * 0.05;
    angle = randomintrange(10 + 60 * quadrant, 50 + 60 * quadrant);
    radius = randomintrange(-56, 700);
    x = min(radius, 550) * cos(angle);
    y = min(radius, 550) * sin(angle);
    bomb = magicbullet(getweapon("remote_missile_bomblet"), origin, aimtarget + (x, y, 0), self);
    setup_bomblet(bomb);
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0xba8f8f55, Offset: 0x3340
// Size: 0x7a
function cleanup_bombs(bomb) {
    player = self;
    bomb endon(#"death");
    player util::waittill_any("joined_team", "joined_spectators", "disconnect");
    if (isdefined(bomb)) {
        bomb clientfield::set("remote_missile_bomblet_fired", 0);
        bomb delete();
    }
}

// Namespace remotemissile
// Params 1, eflags: 0x0
// Checksum 0x84765b20, Offset: 0x33c8
// Size: 0x50
function function_6390ee7d(player) {
    player thread cleanup_bombs(self);
    player endon(#"disconnect");
    player endon(#"remotemissile_done");
    player endon(#"death");
    level endon(#"game_ended");
    self waittill(#"death");
    player notify(#"bomblet_exploded");
}

// Namespace remotemissile
// Params 0, eflags: 0x0
// Checksum 0xd66b20e5, Offset: 0x3420
// Size: 0x101
function remotemissile_bda_dialog() {
    if (isdefined(self.remotemissilebda)) {
        if (self.remotemissilebda === 1) {
            bdadialog = "kill1";
        } else if (self.remotemissilebda === 2) {
            bdadialog = "kill2";
        } else if (self.remotemissilebda === 3) {
            bdadialog = "kill3";
        } else if (isdefined(self.remotemissilebda) && self.remotemissilebda > 3) {
            bdadialog = "killMultiple";
        }
        self killstreaks::play_pilot_dialog(bdadialog, "remote_missile", undefined, self.remotemissilepilotindex);
        self globallogic_audio::play_taacom_dialog("confirmHit");
    } else {
        killstreaks::play_pilot_dialog("killNone", "remote_missile", undefined, self.remotemissilepilotindex);
        globallogic_audio::play_taacom_dialog("confirmMiss");
    }
    self.remotemissilebda = undefined;
}

