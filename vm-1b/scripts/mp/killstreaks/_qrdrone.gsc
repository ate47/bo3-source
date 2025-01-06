#using scripts/codescripts/struct;
#using scripts/mp/_challenges;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_hostmigration;
#using scripts/mp/gametypes/_shellshock;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/killstreaks/_ai_tank;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_remote_weapons;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/popups_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_heatseekingmissile;
#using scripts/shared/weapons/_weaponobjects;

#namespace qrdrone;

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0xbd05814, Offset: 0xb68
// Size: 0x46a
function init() {
    level.qrdrone_vehicle = "qrdrone_mp";
    level.ai_tank_stun_fx = "killstreaks/fx_agr_emp_stun";
    level.qrdrone_minigun_flash = "weapon/fx_muz_md_rifle_3p";
    level.qrdrone_fx["explode"] = "killstreaks/fx_drgnfire_explosion";
    level._effect["quadrotor_nudge"] = "killstreaks/fx_drgnfire_impact_sparks";
    level._effect["quadrotor_damage"] = "killstreaks/fx_drgnfire_damage_state";
    level.qrdrone_dialog["launch"][0] = "ac130_plt_yeahcleared";
    level.qrdrone_dialog["launch"][1] = "ac130_plt_rollinin";
    level.qrdrone_dialog["launch"][2] = "ac130_plt_scanrange";
    level.qrdrone_dialog["out_of_range"][0] = "ac130_plt_cleanup";
    level.qrdrone_dialog["out_of_range"][1] = "ac130_plt_targetreset";
    level.qrdrone_dialog["track"][0] = "ac130_fco_moreenemy";
    level.qrdrone_dialog["track"][1] = "ac130_fco_getthatguy";
    level.qrdrone_dialog["track"][2] = "ac130_fco_guymovin";
    level.qrdrone_dialog["track"][3] = "ac130_fco_getperson";
    level.qrdrone_dialog["track"][4] = "ac130_fco_guyrunnin";
    level.qrdrone_dialog["track"][5] = "ac130_fco_gotarunner";
    level.qrdrone_dialog["track"][6] = "ac130_fco_backonthose";
    level.qrdrone_dialog["track"][7] = "ac130_fco_gonnagethim";
    level.qrdrone_dialog["track"][8] = "ac130_fco_personnelthere";
    level.qrdrone_dialog["track"][9] = "ac130_fco_rightthere";
    level.qrdrone_dialog["track"][10] = "ac130_fco_tracking";
    level.qrdrone_dialog["tag"][0] = "ac130_fco_nice";
    level.qrdrone_dialog["tag"][1] = "ac130_fco_yougothim";
    level.qrdrone_dialog["tag"][2] = "ac130_fco_yougothim2";
    level.qrdrone_dialog["tag"][3] = "ac130_fco_okyougothim";
    level.qrdrone_dialog["assist"][0] = "ac130_fco_goodkill";
    level.qrdrone_dialog["assist"][1] = "ac130_fco_thatsahit";
    level.qrdrone_dialog["assist"][2] = "ac130_fco_directhit";
    level.qrdrone_dialog["assist"][3] = "ac130_fco_rightontarget";
    level.qrdrone_lastdialogtime = 0;
    level.qrdrone_nodeployzones = getentarray("no_vehicles", "targetname");
    level._effect["qrdrone_prop"] = "_t6/weapon/qr_drone/fx_qr_wash_3p";
    /#
        util::set_dvar_if_unset("<dev string:x28>", 60);
    #/
    clientfield::register("helicopter", "qrdrone_state", 1, 3, "int");
    clientfield::register("helicopter", "qrdrone_timeout", 1, 1, "int");
    clientfield::register("helicopter", "qrdrone_countdown", 1, 1, "int");
    clientfield::register("vehicle", "qrdrone_state", 1, 3, "int");
    clientfield::register("vehicle", "qrdrone_timeout", 1, 1, "int");
    clientfield::register("vehicle", "qrdrone_countdown", 1, 1, "int");
    clientfield::register("vehicle", "qrdrone_out_of_range", 1, 1, "int");
    level.qrdroneonblowup = &qrdrone_blowup;
    level.qrdroneondamage = &qrdrone_damagewatcher;
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x2d13520b, Offset: 0xfe0
// Size: 0x90
function tryuseqrdrone(lifeid) {
    if (self util::isusingremote() || isdefined(level.nukeincoming)) {
        return 0;
    }
    if (!self isonground()) {
        self iprintlnbold(%KILLSTREAK_QRDRONE_NOT_PLACEABLE);
        return 0;
    }
    streakname = "TODO";
    result = self givecarryqrdrone(lifeid, streakname);
    self.iscarrying = 0;
    return result;
}

// Namespace qrdrone
// Params 2, eflags: 0x0
// Checksum 0x7c4b0ae9, Offset: 0x1078
// Size: 0xd5
function givecarryqrdrone(lifeid, streakname) {
    carryqrdrone = createcarryqrdrone(streakname, self);
    self setcarryingqrdrone(carryqrdrone);
    if (isalive(self) && isdefined(carryqrdrone)) {
        origin = carryqrdrone.origin;
        angles = self.angles;
        carryqrdrone.soundent delete();
        carryqrdrone delete();
        result = self startqrdrone(lifeid, streakname, origin, angles);
    } else {
        result = 0;
    }
    return result;
}

// Namespace qrdrone
// Params 2, eflags: 0x0
// Checksum 0x9fe062, Offset: 0x1158
// Size: 0x27c
function createcarryqrdrone(streakname, owner) {
    pos = owner.origin + anglestoforward(owner.angles) * 4 + anglestoup(owner.angles) * 50;
    carryqrdrone = spawnturret("misc_turret", pos, getweapon("auto_gun_turret"));
    carryqrdrone.turrettype = "sentry";
    carryqrdrone function_b1f8f94d(carryqrdrone.turrettype);
    carryqrdrone.origin = pos;
    carryqrdrone.angles = owner.angles;
    carryqrdrone.canbeplaced = 1;
    carryqrdrone makeunusable();
    carryqrdrone.owner = owner;
    carryqrdrone setowner(carryqrdrone.owner);
    carryqrdrone.scale = 3;
    carryqrdrone.inheliproximity = 0;
    carryqrdrone thread carryqrdrone_handleexistence();
    carryqrdrone.rangetrigger = getent("qrdrone_range", "targetname");
    if (!isdefined(carryqrdrone.rangetrigger)) {
        carryqrdrone.maxheight = int(airsupport::getminimumflyheight());
        carryqrdrone.maxdistance = 3600;
    }
    carryqrdrone.minheight = level.mapcenter[2] - 800;
    carryqrdrone.soundent = spawn("script_origin", carryqrdrone.origin);
    carryqrdrone.soundent.angles = carryqrdrone.angles;
    carryqrdrone.soundent.origin = carryqrdrone.origin;
    carryqrdrone.soundent linkto(carryqrdrone);
    carryqrdrone.soundent playloopsound("recondrone_idle_high");
    return carryqrdrone;
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x153555dc, Offset: 0x13e0
// Size: 0x4b
function watchforattack() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"place_carryqrdrone");
    self endon(#"cancel_carryqrdrone");
    for (;;) {
        wait 0.05;
        if (self attackbuttonpressed()) {
            self notify(#"place_carryqrdrone");
        }
    }
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0xfeaa3c30, Offset: 0x1438
// Size: 0xcc
function setcarryingqrdrone(carryqrdrone) {
    self endon(#"death");
    self endon(#"disconnect");
    carryqrdrone thread carryqrdrone_setcarried(self);
    if (!carryqrdrone.canbeplaced) {
        if (self.team != "spectator") {
            self iprintlnbold(%KILLSTREAK_QRDRONE_NOT_PLACEABLE);
        }
        if (isdefined(carryqrdrone.soundent)) {
            carryqrdrone.soundent delete();
        }
        carryqrdrone delete();
        return;
    }
    self.iscarrying = 0;
    carryqrdrone.carriedby = undefined;
    carryqrdrone playsound("sentry_gun_plant");
    carryqrdrone notify(#"placed");
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x5e06f611, Offset: 0x1510
// Size: 0x5b
function carryqrdrone_setcarried(carrier) {
    self setcandamage(0);
    self setcontents(0);
    self.carriedby = carrier;
    carrier.iscarrying = 1;
    carrier thread updatecarryqrdroneplacement(self);
    self notify(#"carried");
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x3fc4cec8, Offset: 0x1578
// Size: 0x82
function isinremotenodeploy() {
    if (isdefined(level.qrdrone_nodeployzones) && level.qrdrone_nodeployzones.size) {
        foreach (zone in level.qrdrone_nodeployzones) {
            if (self istouching(zone)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x3f991ac7, Offset: 0x1608
// Size: 0x1b1
function updatecarryqrdroneplacement(carryqrdrone) {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    carryqrdrone endon(#"placed");
    carryqrdrone endon(#"death");
    carryqrdrone.canbeplaced = 1;
    lastcanplacecarryqrdrone = -1;
    for (;;) {
        heightoffset = 18;
        switch (self getstance()) {
        case "stand":
            heightoffset = 40;
            break;
        case "crouch":
            heightoffset = 25;
            break;
        case "prone":
            heightoffset = 10;
            break;
        }
        placement = self canplayerplacevehicle(22, 22, 50, heightoffset, 0, 0);
        carryqrdrone.origin = placement["origin"] + anglestoup(self.angles) * 27;
        carryqrdrone.angles = placement["angles"];
        carryqrdrone.canbeplaced = self isonground() && placement["result"] && carryqrdrone qrdrone_in_range() && !carryqrdrone isinremotenodeploy();
        if (carryqrdrone.canbeplaced != lastcanplacecarryqrdrone) {
            if (carryqrdrone.canbeplaced) {
                if (self attackbuttonpressed()) {
                    self notify(#"place_carryqrdrone");
                }
            }
        }
        lastcanplacecarryqrdrone = carryqrdrone.canbeplaced;
        wait 0.05;
    }
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x9d31995f, Offset: 0x17c8
// Size: 0x82
function carryqrdrone_handleexistence() {
    level endon(#"game_ended");
    self endon(#"death");
    self.owner endon(#"place_carryqrdrone");
    self.owner endon(#"cancel_carryqrdrone");
    self.owner util::waittill_any("death", "disconnect", "joined_team", "joined_spectators");
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x62eff62a, Offset: 0x1858
// Size: 0x1a
function removeremoteweapon() {
    level endon(#"game_ended");
    self endon(#"disconnect");
    wait 0.7;
}

// Namespace qrdrone
// Params 4, eflags: 0x0
// Checksum 0xfedb5bee, Offset: 0x1880
// Size: 0x224
function startqrdrone(lifeid, streakname, origin, angles) {
    self lockplayerforqrdronelaunch();
    self util::setusingremote(streakname);
    self util::freeze_player_controls(1);
    result = self killstreaks::init_ride_killstreak("qrdrone");
    if (result != "success" || level.gameended) {
        if (result != "disconnect") {
            self util::freeze_player_controls(0);
            self killstreakrules::iskillstreakallowed("qrdrone", self.team);
            self notify(#"qrdrone_unlock");
            self killstreaks::clear_using_remote();
        }
        return 0;
    }
    team = self.team;
    killstreak_id = self killstreakrules::killstreakstart("qrdrone", team, 0, 1);
    if (killstreak_id == -1) {
        self notify(#"qrdrone_unlock");
        self util::freeze_player_controls(0);
        self killstreaks::clear_using_remote();
        return 0;
    }
    self notify(#"qrdrone_unlock");
    qrdrone = createqrdrone(lifeid, self, streakname, origin, angles, killstreak_id);
    self util::freeze_player_controls(0);
    if (isdefined(qrdrone)) {
        self thread qrdrone_ride(lifeid, qrdrone, streakname);
        qrdrone waittill(#"end_remote");
        killstreakrules::killstreakstop("qrdrone", team, killstreak_id);
        return 1;
    }
    self iprintlnbold(%MP_TOO_MANY_VEHICLES);
    self killstreaks::clear_using_remote();
    killstreakrules::killstreakstop("qrdrone", team, killstreak_id);
    return 0;
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x13d02a4d, Offset: 0x1ab0
// Size: 0x5a
function lockplayerforqrdronelaunch() {
    lockspot = spawn("script_origin", self.origin);
    lockspot hide();
    self playerlinkto(lockspot);
    self thread clearplayerlockfromqrdronelaunch(lockspot);
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x7b5c2eaf, Offset: 0x1b18
// Size: 0x52
function clearplayerlockfromqrdronelaunch(lockspot) {
    level endon(#"game_ended");
    msg = self util::waittill_any_return("disconnect", "death", "qrdrone_unlock");
    lockspot delete();
}

// Namespace qrdrone
// Params 6, eflags: 0x0
// Checksum 0xf196c7c6, Offset: 0x1b78
// Size: 0x35c
function createqrdrone(lifeid, owner, streakname, origin, angles, killstreak_id) {
    qrdrone = spawnhelicopter(owner, origin, angles, level.qrdrone_vehicle, "veh_t6_drone_quad_rotor_mp");
    if (!isdefined(qrdrone)) {
        return undefined;
    }
    qrdrone.lifeid = lifeid;
    qrdrone.team = owner.team;
    qrdrone.pers["team"] = owner.team;
    qrdrone.owner = owner;
    qrdrone clientfield::set("enemyvehicle", 1);
    qrdrone.health = 999999;
    qrdrone.maxhealth = -6;
    qrdrone.damagetaken = 0;
    qrdrone.destroyed = 0;
    qrdrone setcandamage(1);
    qrdrone enableaimassist();
    qrdrone.smoking = 0;
    qrdrone.inheliproximity = 0;
    qrdrone.helitype = "qrdrone";
    qrdrone.markedplayers = [];
    qrdrone.isstunned = 0;
    qrdrone setenemymodel("veh_t6_drone_quad_rotor_mp_alt");
    qrdrone setdrawinfrared(1);
    qrdrone.killcament = qrdrone.owner;
    owner weaponobjects::addweaponobjecttowatcher("qrdrone", qrdrone);
    qrdrone thread qrdrone_explode_on_notify(killstreak_id);
    qrdrone thread qrdrone_explode_on_game_end();
    qrdrone thread qrdrone_leave_on_timeout(streakname);
    qrdrone thread qrdrone_watch_distance();
    qrdrone thread qrdrone_watch_for_exit();
    qrdrone thread deleteonkillbrush(owner);
    target_set(qrdrone, (0, 0, 0));
    function_38a2c2c2(qrdrone, 0);
    qrdrone.numflares = 0;
    qrdrone.flareoffset = (0, 0, -100);
    qrdrone thread heatseekingmissile::missiletarget_lockonmonitor(self, "end_remote");
    qrdrone thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing");
    qrdrone.emp_fx = spawn("script_model", self.origin);
    qrdrone.emp_fx setmodel("tag_origin");
    qrdrone.emp_fx linkto(self, "tag_origin", (0, 0, -20) + anglestoforward(self.angles) * 6);
    qrdrone spawning::create_entity_enemy_influencer("small_vehicle", qrdrone.team);
    qrdrone spawning::create_entity_enemy_influencer("qrdrone_cylinder", qrdrone.team);
    return qrdrone;
}

// Namespace qrdrone
// Params 3, eflags: 0x0
// Checksum 0x1f358c13, Offset: 0x1ee0
// Size: 0x112
function qrdrone_ride(lifeid, qrdrone, streakname) {
    qrdrone.playerlinked = 1;
    self.restoreangles = self.angles;
    qrdrone usevehicle(self, 0);
    self util::clientnotify("qrfutz");
    self killstreaks::play_killstreak_start_dialog("qrdrone", self.pers["team"]);
    self addweaponstat(getweapon("killstreak_qrdrone"), "used", 1);
    self.qrdrone_ridelifeid = lifeid;
    self.qrdrone = qrdrone;
    self thread qrdrone_delaylaunchdialog(qrdrone);
    self thread qrdrone_fireguns(qrdrone);
    qrdrone thread play_lockon_sounds(self);
    if (isdefined(level.qrdrone_vision)) {
        self setvisionsetwaiter();
    }
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x8de058bc, Offset: 0x2000
// Size: 0x4a
function qrdrone_delaylaunchdialog(qrdrone) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    qrdrone endon(#"death");
    qrdrone endon(#"end_remote");
    qrdrone endon(#"end_launch_dialog");
    wait 3;
    self qrdrone_dialog("launch");
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x56fbaff0, Offset: 0x2058
// Size: 0x72
function qrdrone_unlink(qrdrone) {
    if (isdefined(qrdrone)) {
        qrdrone.playerlinked = 0;
        self destroyhud();
        if (isdefined(self.viewlockedentity)) {
            self unlink();
            if (isdefined(level.gameended) && level.gameended) {
                self util::freeze_player_controls(1);
            }
        }
    }
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0xc299c6b2, Offset: 0x20d8
// Size: 0x79
function qrdrone_endride(qrdrone) {
    if (isdefined(qrdrone)) {
        qrdrone notify(#"end_remote");
        self killstreaks::clear_using_remote();
        self setplayerangles(self.restoreangles);
        if (isalive(self)) {
            self killstreaks::switch_to_last_non_killstreak_weapon();
        }
        self thread qrdrone_freezebuffer();
    }
    self.qrdrone = undefined;
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x91e7cfd0, Offset: 0x2160
// Size: 0x14d
function play_lockon_sounds(player) {
    player endon(#"disconnect");
    self endon(#"death");
    self endon(#"blowup");
    self endon(#"crashing");
    level endon(#"game_ended");
    self endon(#"end_remote");
    self.locksounds = spawn("script_model", self.origin);
    wait 0.1;
    self.locksounds linkto(self, "tag_player");
    while (true) {
        self waittill(#"locking on");
        while (true) {
            if (enemy_locking()) {
                self.locksounds playsoundtoplayer("uin_alert_lockon", player);
                wait 0.125;
            }
            if (enemy_locked()) {
                self.locksounds playsoundtoplayer("uin_alert_lockon", player);
                wait 0.125;
            }
            if (!enemy_locking() && !enemy_locked()) {
                self.locksounds stopsounds();
                break;
            }
        }
    }
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0xfdb08546, Offset: 0x22b8
// Size: 0x1d
function enemy_locking() {
    if (isdefined(self.locking_on) && self.locking_on) {
        return true;
    }
    return false;
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x9a4751e0, Offset: 0x22e0
// Size: 0x1d
function enemy_locked() {
    if (isdefined(self.locked_on) && self.locked_on) {
        return true;
    }
    return false;
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x8379b62b, Offset: 0x2308
// Size: 0x42
function qrdrone_freezebuffer() {
    self endon(#"disconnect");
    self endon(#"death");
    level endon(#"game_ended");
    self util::freeze_player_controls(1);
    wait 0.5;
    self util::freeze_player_controls(0);
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x7b570c1e, Offset: 0x2358
// Size: 0x99
function qrdrone_playerexit(qrdrone) {
    level endon(#"game_ended");
    self endon(#"disconnect");
    qrdrone endon(#"death");
    qrdrone endon(#"end_remote");
    wait 2;
    while (true) {
        timeused = 0;
        while (self usebuttonpressed()) {
            timeused += 0.05;
            if (timeused > 0.75) {
                qrdrone thread qrdrone_leave();
                return;
            }
            wait 0.05;
        }
        wait 0.05;
    }
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x96c2dbba, Offset: 0x2400
// Size: 0x6a
function touchedkillbrush() {
    if (isdefined(self)) {
        self clientfield::set("qrdrone_state", 3);
        watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
        watcher thread weaponobjects::waitanddetonate(self, 0);
    }
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x5c512b88, Offset: 0x2478
// Size: 0x2b5
function deleteonkillbrush(player) {
    player endon(#"disconnect");
    self endon(#"death");
    killbrushes = [];
    hurt = getentarray("trigger_hurt", "classname");
    foreach (trig in hurt) {
        if (!isdefined(trig.script_parameters) || trig.origin[2] <= player.origin[2] && trig.script_parameters != "qrdrone_safe") {
            killbrushes[killbrushes.size] = trig;
        }
    }
    crate_triggers = getentarray("crate_kill_trigger", "targetname");
    while (true) {
        for (i = 0; i < killbrushes.size; i++) {
            if (self istouching(killbrushes[i])) {
                self touchedkillbrush();
                return;
            }
        }
        foreach (trigger in crate_triggers) {
            if (trigger.active && self istouching(trigger)) {
                self touchedkillbrush();
                return;
            }
        }
        if (isdefined(level.levelkillbrushes)) {
            foreach (trigger in level.levelkillbrushes) {
                if (self istouching(trigger)) {
                    self touchedkillbrush();
                    return;
                }
            }
        }
        if (level.script == "mp_castaway") {
            origin = self.origin - (0, 0, 12);
            water = getwaterheight(origin);
            if (water - origin[2] > 0) {
                self touchedkillbrush();
                return;
            }
        }
        wait 0.1;
    }
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x52faf6d5, Offset: 0x2738
// Size: 0x62
function qrdrone_force_destroy() {
    self clientfield::set("qrdrone_state", 3);
    watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
    watcher thread weaponobjects::waitanddetonate(self, 0);
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x98826f, Offset: 0x27a8
// Size: 0x28
function qrdrone_get_damage_effect(health_pct) {
    if (health_pct > 0.5) {
        return level._effect["quadrotor_damage"];
    }
    return undefined;
}

// Namespace qrdrone
// Params 2, eflags: 0x0
// Checksum 0x77a6cc43, Offset: 0x27d8
// Size: 0x62
function qrdrone_play_single_fx_on_tag(effect, tag) {
    if (isdefined(self.damage_fx_ent)) {
        if (self.damage_fx_ent.effect == effect) {
            return;
        }
        self.damage_fx_ent delete();
    }
    playfxontag(effect, self, "tag_origin");
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x7bcad748, Offset: 0x2848
// Size: 0x6a
function qrdrone_update_damage_fx(health_percent) {
    effect = qrdrone_get_damage_effect(health_percent);
    if (isdefined(effect)) {
        qrdrone_play_single_fx_on_tag(effect, "tag_origin");
        return;
    }
    if (isdefined(self.damage_fx_ent)) {
        self.damage_fx_ent delete();
    }
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x59fe2f3e, Offset: 0x28c0
// Size: 0x2ad
function qrdrone_damagewatcher() {
    self endon(#"death");
    self.maxhealth = 999999;
    self.health = self.maxhealth;
    self.maxhealth = -31;
    low_health = 0;
    damage_taken = 0;
    for (;;) {
        self waittill(#"damage", damage, attacker, dir, point, mod, model, tag, part, weapon, flags);
        if (!isdefined(attacker) || !isplayer(attacker)) {
            continue;
        }
        self.owner playrumbleonentity("damage_heavy");
        /#
            self.damage_debug = damage + "<dev string:x3b>" + weapon.name + "<dev string:x3e>";
        #/
        if (mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET") {
            if (isplayer(attacker)) {
                if (attacker hasperk("specialty_armorpiercing")) {
                    damage += int(damage * level.cac_armorpiercing_data);
                }
            }
            if (weapon.weapclass == "spread") {
                damage *= 2;
            }
        }
        if (weapon.isemp && mod == "MOD_GRENADE_SPLASH") {
            damage_taken += -31;
            damage = 0;
        }
        if (!self.isstunned) {
            if (mod == "MOD_GRENADE_SPLASH" || weapon.isstun && mod == "MOD_GAS") {
                self.isstunned = 1;
                self qrdrone_stun(2);
            }
        }
        self.attacker = attacker;
        self.owner sendkillstreakdamageevent(int(damage));
        damage_taken += damage;
        if (damage_taken >= -31) {
            self.owner sendkillstreakdamageevent(-56);
            self qrdrone_death(attacker, weapon, dir, mod);
            return;
        }
        qrdrone_update_damage_fx(float(damage_taken) / -31);
    }
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x8a7bf4a6, Offset: 0x2b78
// Size: 0x7a
function qrdrone_stun(duration) {
    self endon(#"death");
    self notify(#"stunned");
    self.owner util::freeze_player_controls(1);
    if (isdefined(self.owner.var_f04f433)) {
        self.owner thread remote_weapons::stunstaticfx(duration);
    }
    wait duration;
    self.owner util::freeze_player_controls(0);
    self.isstunned = 0;
}

// Namespace qrdrone
// Params 4, eflags: 0x0
// Checksum 0x66682758, Offset: 0x2c00
// Size: 0x1e2
function qrdrone_death(attacker, weapon, dir, damagetype) {
    if (isdefined(self.damage_fx_ent)) {
        self.damage_fx_ent delete();
    }
    if (isdefined(attacker) && isplayer(attacker) && attacker != self.owner) {
        level thread popups::displayteammessagetoall(%SCORE_DESTROYED_QRDRONE, attacker);
        if (self.owner util::isenemyplayer(attacker)) {
            attacker challenges::destroyedqrdrone(damagetype, weapon);
            attacker addweaponstat(weapon, "destroyed_qrdrone", 1);
            attacker challenges::addflyswatterstat(weapon, self);
            attacker addweaponstat(weapon, "destroyed_controlled_killstreak", 1);
        }
    }
    self thread qrdrone_crash_movement(attacker, dir);
    if (weapon.isemp) {
        playfxontag(level.ai_tank_stun_fx, self.emp_fx, "tag_origin");
    }
    self waittill(#"crash_done");
    if (isdefined(self.emp_fx)) {
        self.emp_fx delete();
    }
    self clientfield::set("qrdrone_state", 3);
    watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
    watcher thread weaponobjects::waitanddetonate(self, 0, attacker, weapon);
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0xce7f1d8b, Offset: 0x2df0
// Size: 0x3a
function death_fx() {
    playfxontag(self.deathfx, self, self.deathfxtag);
    self playsound("veh_qrdrone_sparks");
}

// Namespace qrdrone
// Params 2, eflags: 0x0
// Checksum 0x8b099794, Offset: 0x2e38
// Size: 0x297
function qrdrone_crash_movement(attacker, hitdir) {
    self endon(#"crash_done");
    self endon(#"death");
    self notify(#"crashing");
    self takeplayercontrol();
    self setmaxpitchroll(90, -76);
    self setphysacceleration((0, 0, -800));
    side_dir = weaponobjects::vectorcross(hitdir, (0, 0, 1));
    side_dir_mag = randomfloatrange(-100, 100);
    side_dir_mag += math::sign(side_dir_mag) * 80;
    side_dir *= side_dir_mag;
    velocity = self getvelocity();
    self setvehvelocity(velocity + (0, 0, 100) + vectornormalize(side_dir));
    ang_vel = self getangularvelocity();
    ang_vel = (ang_vel[0] * 0.3, ang_vel[1], ang_vel[2] * 0.3);
    yaw_vel = randomfloatrange(0, -46) * math::sign(ang_vel[1]);
    yaw_vel += math::sign(yaw_vel) * -76;
    ang_vel += (randomfloatrange(-100, 100), yaw_vel, randomfloatrange(-200, -56));
    self setangularvelocity(ang_vel);
    self.crash_accel = randomfloatrange(75, 110);
    self thread qrdrone_crash_accel();
    self thread qrdrone_collision();
    self playsound("veh_qrdrone_dmg_hit");
    self thread qrdrone_dmg_snd();
    wait 0.1;
    if (randomint(100) < 40) {
        self thread qrdrone_fire_for_time(randomfloatrange(0.7, 2));
    }
    wait 2;
    self notify(#"crash_done");
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0xde6e9809, Offset: 0x30d8
// Size: 0xaa
function qrdrone_dmg_snd() {
    dmg_ent = spawn("script_origin", self.origin);
    dmg_ent linkto(self);
    dmg_ent playloopsound("veh_qrdrone_dmg_loop");
    self util::waittill_any("crash_done", "death");
    dmg_ent stoploopsound(0.2);
    wait 2;
    dmg_ent delete();
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0xce5d5cd1, Offset: 0x3190
// Size: 0x93
function qrdrone_fire_for_time(totalfiretime) {
    self endon(#"crash_done");
    self endon(#"change_state");
    self endon(#"death");
    weapon = self seatgetweapon(0);
    firetime = weapon.firetime;
    time = 0;
    firecount = 1;
    while (time < totalfiretime) {
        self fireweapon();
        firecount++;
        wait firetime;
        time += firetime;
    }
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x8c7e72b5, Offset: 0x3230
// Size: 0x16d
function qrdrone_crash_accel() {
    self endon(#"crash_done");
    self endon(#"death");
    count = 0;
    while (true) {
        velocity = self getvelocity();
        self setvehvelocity(velocity + anglestoup(self.angles) * self.crash_accel);
        self.crash_accel = self.crash_accel * 0.98;
        wait 0.1;
        count++;
        if (count % 8 == 0) {
            if (randomint(100) > 40) {
                if (velocity[2] > 150) {
                    self.crash_accel = self.crash_accel * 0.75;
                    continue;
                }
                if (velocity[2] < 40 && count < 60) {
                    if (abs(self.angles[0]) > 30 || abs(self.angles[2]) > 30) {
                        self.crash_accel = randomfloatrange(-96, -56);
                        continue;
                    }
                    self.crash_accel = randomfloatrange(85, 120);
                }
            }
        }
    }
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0xb6c4cbb4, Offset: 0x33a8
// Size: 0x10f
function qrdrone_collision() {
    self endon(#"crash_done");
    self endon(#"death");
    while (true) {
        self waittill(#"veh_collision", velocity, normal);
        ang_vel = self getangularvelocity() * 0.5;
        self setangularvelocity(ang_vel);
        velocity = self getvelocity();
        if (normal[2] < 0.7) {
            self setvehvelocity(velocity + normal * 70);
            self playsound("veh_qrdrone_wall");
            playfx(level._effect["quadrotor_nudge"], self.origin);
            continue;
        }
        self playsound("veh_qrdrone_explo");
        self notify(#"crash_done");
    }
}

// Namespace qrdrone
// Params 2, eflags: 0x0
// Checksum 0xe6d692a8, Offset: 0x34c0
// Size: 0x29d
function qrdrone_watch_distance(zoffset, minheightoverride) {
    self endon(#"death");
    self.owner inithud();
    self clientfield::set("qrdrone_out_of_range", 1);
    wait 0.05;
    self clientfield::set("qrdrone_out_of_range", 0);
    qrdrone_height = struct::get("qrdrone_height", "targetname");
    if (isdefined(qrdrone_height)) {
        self.maxheight = qrdrone_height.origin[2];
    } else {
        self.maxheight = int(airsupport::getminimumflyheight());
    }
    if (isdefined(zoffset)) {
        self.maxheight = self.maxheight + zoffset;
    }
    self.maxdistance = 12800;
    self.minheight = level.mapcenter[2] - 800;
    if (isdefined(minheightoverride)) {
        self.minheight = minheightoverride;
    }
    self.centerref = spawn("script_model", level.mapcenter);
    inrangepos = self.origin;
    self.rangecountdownactive = 0;
    while (true) {
        if (!self qrdrone_in_range()) {
            staticalpha = 0;
            while (!self qrdrone_in_range()) {
                if (!self.rangecountdownactive) {
                    self.rangecountdownactive = 1;
                    self thread qrdrone_rangecountdown();
                }
                if (isdefined(self.heliinproximity)) {
                    dist = distance(self.origin, self.heliinproximity.origin);
                    staticalpha = 1 - (dist - -106) / -106;
                } else {
                    dist = distance(self.origin, inrangepos);
                    staticalpha = min(0.7, dist / -56);
                }
                self.owner set_static_alpha(staticalpha, self);
                wait 0.05;
            }
            self notify(#"in_range");
            self.rangecountdownactive = 0;
            self thread qrdrone_staticfade(staticalpha);
        }
        inrangepos = self.origin;
        wait 0.05;
    }
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x4f444f9e, Offset: 0x3768
// Size: 0x49
function qrdrone_in_range() {
    if (self.origin[2] < self.maxheight && self.origin[2] > self.minheight && !self.inheliproximity) {
        if (self ismissileinsideheightlock()) {
            return true;
        }
    }
    return false;
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x13e25f70, Offset: 0x37c0
// Size: 0x7d
function qrdrone_staticfade(staticalpha) {
    self endon(#"death");
    while (self qrdrone_in_range()) {
        staticalpha -= 0.05;
        if (staticalpha < 0) {
            self.owner set_static_alpha(staticalpha, self);
            break;
        }
        self.owner set_static_alpha(staticalpha, self);
        wait 0.05;
    }
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x83a4cf5, Offset: 0x3848
// Size: 0xca
function qrdrone_rangecountdown() {
    self endon(#"death");
    self endon(#"in_range");
    if (isdefined(self.heliinproximity)) {
        countdown = 6.1;
    } else {
        countdown = 6.1;
    }
    hostmigration::waitlongdurationwithhostmigrationpause(countdown);
    self.owner notify(#"stop_signal_failure");
    if (isdefined(self.distance_shutdown_override)) {
        return [[ self.distance_shutdown_override ]]();
    }
    self clientfield::set("qrdrone_state", 3);
    watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
    watcher thread weaponobjects::waitanddetonate(self, 0);
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0xe4d64102, Offset: 0x3920
// Size: 0x112
function qrdrone_explode_on_notify(killstreak_id) {
    self endon(#"death");
    self endon(#"end_ride");
    self.owner util::waittill_any("disconnect", "joined_team", "joined_spectators");
    if (isdefined(self.owner)) {
        self.owner killstreaks::clear_using_remote();
        self.owner destroyhud();
        self.owner qrdrone_endride(self);
    } else {
        killstreakrules::killstreakstop("qrdrone", self.team, killstreak_id);
    }
    self clientfield::set("qrdrone_state", 3);
    watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
    watcher thread weaponobjects::waitanddetonate(self, 0);
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x795582e9, Offset: 0x3a40
// Size: 0x82
function qrdrone_explode_on_game_end() {
    self endon(#"death");
    level waittill(#"game_ended");
    self clientfield::set("qrdrone_state", 3);
    watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
    watcher weaponobjects::waitanddetonate(self, 0);
    self.owner qrdrone_endride(self);
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x1d32543b, Offset: 0x3ad0
// Size: 0x132
function qrdrone_leave_on_timeout(killstreakname) {
    qrdrone = self;
    qrdrone endon(#"death");
    if (!level.vehiclestimed) {
        return;
    }
    qrdrone.flytime = 60;
    waittime = self.flytime - 10;
    /#
        util::set_dvar_int_if_unset("<dev string:x28>", qrdrone.flytime);
        qrdrone.flytime = getdvarint("<dev string:x28>");
        waittime = self.flytime - 10;
        if (waittime < 0) {
            wait qrdrone.flytime;
            self clientfield::set("<dev string:x40>", 3);
            watcher = qrdrone.owner weaponobjects::getweaponobjectwatcher("<dev string:x4e>");
            watcher thread weaponobjects::waitanddetonate(qrdrone, 0);
            return;
        }
    #/
    qrdrone thread killstreaks::waitfortimeout(killstreakname, waittime, &qrdrone_leave_on_timeout_callback, "death");
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x659ea9aa, Offset: 0x3c10
// Size: 0xea
function qrdrone_leave_on_timeout_callback() {
    qrdrone = self;
    qrdrone clientfield::set("qrdrone_state", 1);
    qrdrone clientfield::set("qrdrone_countdown", 1);
    hostmigration::waitlongdurationwithhostmigrationpause(6);
    qrdrone clientfield::set("qrdrone_state", 2);
    qrdrone clientfield::set("qrdrone_timeout", 1);
    hostmigration::waitlongdurationwithhostmigrationpause(4);
    qrdrone clientfield::set("qrdrone_state", 3);
    watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
    watcher thread weaponobjects::waitanddetonate(self, 0);
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0xb37d7d43, Offset: 0x3d08
// Size: 0x53
function qrdrone_leave() {
    level endon(#"game_ended");
    self endon(#"death");
    self notify(#"leaving");
    self.owner qrdrone_unlink(self);
    self.owner qrdrone_endride(self);
    self notify(#"death");
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x2bec42af, Offset: 0x3d68
// Size: 0x11
function qrdrone_exit_button_pressed() {
    return self usebuttonpressed();
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0xf0e7fa22, Offset: 0x3d88
// Size: 0xe1
function qrdrone_watch_for_exit() {
    level endon(#"game_ended");
    self endon(#"death");
    self.owner endon(#"disconnect");
    wait 1;
    while (true) {
        timeused = 0;
        while (self.owner qrdrone_exit_button_pressed()) {
            timeused += 0.05;
            if (timeused > 0.25) {
                self clientfield::set("qrdrone_state", 3);
                watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
                watcher thread weaponobjects::waitanddetonate(self, 0, self.owner);
                return;
            }
            wait 0.05;
        }
        wait 0.05;
    }
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x756923e8, Offset: 0x3e78
// Size: 0x102
function qrdrone_cleanup() {
    if (level.gameended) {
        return;
    }
    if (isdefined(self.owner)) {
        if (self.playerlinked == 1) {
            self.owner qrdrone_unlink(self);
        }
        self.owner qrdrone_endride(self);
    }
    if (isdefined(self.scrambler)) {
        self.scrambler delete();
    }
    if (isdefined(self) && isdefined(self.centerref)) {
        self.centerref delete();
    }
    function_38a2c2c2(self, 0);
    if (isdefined(self.damage_fx_ent)) {
        self.damage_fx_ent delete();
    }
    if (isdefined(self.emp_fx)) {
        self.emp_fx delete();
    }
    self delete();
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0xb432e704, Offset: 0x3f88
// Size: 0x6a
function qrdrone_light_fx() {
    playfxontag(level.chopper_fx["light"]["belly"], self, "tag_light_nose");
    wait 0.05;
    playfxontag(level.chopper_fx["light"]["tail"], self, "tag_light_tail1");
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x5be3774d, Offset: 0x4000
// Size: 0x92
function qrdrone_dialog(dialoggroup) {
    if (dialoggroup == "tag") {
        waittime = 1000;
    } else {
        waittime = 5000;
    }
    if (gettime() - level.qrdrone_lastdialogtime < waittime) {
        return;
    }
    level.qrdrone_lastdialogtime = gettime();
    randomindex = randomint(level.qrdrone_dialog[dialoggroup].size);
    soundalias = level.qrdrone_dialog[dialoggroup][randomindex];
    self playlocalsound(soundalias);
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x274bf03b, Offset: 0x40a0
// Size: 0x79
function qrdrone_watchheliproximity() {
    level endon(#"game_ended");
    self endon(#"death");
    self endon(#"end_remote");
    while (true) {
        inheliproximity = 0;
        if (!self.inheliproximity && inheliproximity) {
            self.inheliproximity = 1;
        } else if (self.inheliproximity && !inheliproximity) {
            self.inheliproximity = 0;
            self.heliinproximity = undefined;
        }
        wait 0.05;
    }
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x26724f06, Offset: 0x4128
// Size: 0x132
function qrdrone_detonatewaiter() {
    self.owner endon(#"disconnect");
    self endon(#"death");
    while (self.owner attackbuttonpressed()) {
        wait 0.05;
    }
    watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
    while (!self.owner attackbuttonpressed()) {
        wait 0.05;
    }
    self clientfield::set("qrdrone_state", 3);
    watcher thread weaponobjects::waitanddetonate(self, 0);
    self.owner thread hud::fade_to_black_for_x_sec(getdvarfloat("scr_rcbomb_fadeOut_delay"), getdvarfloat("scr_rcbomb_fadeOut_timeIn"), getdvarfloat("scr_rcbomb_fadeOut_timeBlack"), getdvarfloat("scr_rcbomb_fadeOut_timeOut"));
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x72159668, Offset: 0x4268
// Size: 0xb1
function qrdrone_fireguns(qrdrone) {
    self endon(#"disconnect");
    qrdrone endon(#"death");
    qrdrone endon(#"blowup");
    qrdrone endon(#"crashing");
    level endon(#"game_ended");
    qrdrone endon(#"end_remote");
    wait 1;
    while (true) {
        if (self attackbuttonpressed()) {
            qrdrone fireweapon();
            weapon = getweapon("qrdrone_turret");
            firetime = weapon.firetime;
            wait firetime;
            continue;
        }
        wait 0.05;
    }
}

// Namespace qrdrone
// Params 2, eflags: 0x0
// Checksum 0x6344f30c, Offset: 0x4328
// Size: 0x292
function qrdrone_blowup(attacker, weapon) {
    self.owner endon(#"disconnect");
    self endon(#"death");
    self notify(#"blowup");
    explosionorigin = self.origin;
    explosionangles = self.angles;
    if (!isdefined(attacker)) {
        attacker = self.owner;
    }
    origin = self.origin + (0, 0, 10);
    radius = 256;
    min_damage = 10;
    max_damage = 35;
    if (isdefined(attacker)) {
        self radiusdamage(origin, radius, max_damage, min_damage, attacker, "MOD_EXPLOSIVE", self.weapon);
    }
    physicsexplosionsphere(origin, radius, radius, 1, max_damage, min_damage);
    shellshock::rcbomb_earthquake(origin);
    playsoundatposition("veh_qrdrone_explo", self.origin);
    playfx(level.qrdrone_fx["explode"], explosionorigin, (0, 0, 1));
    self hide();
    if (isdefined(self.owner)) {
        self.owner util::clientnotify("qrdrone_blowup");
        if (attacker != self.owner) {
            level.globalkillstreaksdestroyed++;
            attacker addweaponstat(self.weapon, "destroyed", 1);
        }
        self.owner remote_weapons::destroyremotehud();
        self.owner util::freeze_player_controls(1);
        self.owner sendkillstreakdamageevent(600);
        wait 0.75;
        self.owner thread hud::fade_to_black_for_x_sec(0, 0.25, 0.1, 0.25);
        wait 0.25;
        self.owner qrdrone_unlink(self);
        self.owner util::freeze_player_controls(0);
        if (isdefined(self.neverdelete) && self.neverdelete) {
            return;
        }
    }
    qrdrone_cleanup();
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x902a003, Offset: 0x45c8
// Size: 0x52
function setvisionsetwaiter() {
    self endon(#"disconnect");
    self useservervisionset(1);
    self setvisionsetforplayer(level.qrdrone_vision, 1);
    self.qrdrone waittill(#"end_remote");
    self useservervisionset(0);
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x4628
// Size: 0x2
function inithud() {
    
}

// Namespace qrdrone
// Params 0, eflags: 0x0
// Checksum 0x39046c37, Offset: 0x4638
// Size: 0x72
function destroyhud() {
    if (isdefined(self)) {
        self notify(#"stop_signal_failure");
        self.flashingsignalfailure = 0;
        self clientfield::set_to_player("static_postfx", 0);
        if (isdefined(self.var_f04f433)) {
            self.var_f04f433 destroy();
        }
        self remote_weapons::destroyremotehud();
        self util::clientnotify("nofutz");
    }
}

// Namespace qrdrone
// Params 2, eflags: 0x0
// Checksum 0xd061f837, Offset: 0x46b8
// Size: 0xda
function set_static_alpha(alpha, drone) {
    if (isdefined(self.var_f04f433)) {
        self.var_f04f433.alpha = alpha;
    }
    if (alpha > 0) {
        if (!isdefined(self.flashingsignalfailure) || !self.flashingsignalfailure) {
            self thread flash_signal_failure(drone);
            self.flashingsignalfailure = 1;
            if (self isremotecontrolling()) {
                self clientfield::set_to_player("static_postfx", 1);
            }
        }
        return;
    }
    self notify(#"stop_signal_failure");
    drone clientfield::set("qrdrone_out_of_range", 0);
    self.flashingsignalfailure = 0;
    self clientfield::set_to_player("static_postfx", 0);
}

// Namespace qrdrone
// Params 1, eflags: 0x0
// Checksum 0x97196670, Offset: 0x47a0
// Size: 0x89
function flash_signal_failure(drone) {
    self endon(#"stop_signal_failure");
    drone endon(#"death");
    drone clientfield::set("qrdrone_out_of_range", 1);
    for (i = 0; ; i++) {
        drone playsoundtoplayer("uin_alert_lockon", self);
        if (i < 5) {
            wait 0.6;
            continue;
        }
        if (i < 6) {
            wait 0.5;
            continue;
        }
        wait 0.3;
    }
}

