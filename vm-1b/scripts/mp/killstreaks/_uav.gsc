#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreak_detect;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/teams/_teams;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_heatseekingmissile;
#using scripts/shared/weapons/_weaponobjects;

#namespace uav;

// Namespace uav
// Params 0, eflags: 0x0
// Checksum 0xbb80e916, Offset: 0x688
// Size: 0x222
function init() {
    if (level.teambased) {
        foreach (team in level.teams) {
            level.activeuavs[team] = 0;
        }
    } else {
        level.activeuavs = [];
    }
    level.activeplayeruavs = [];
    level.spawneduavs = [];
    if (tweakables::gettweakablevalue("killstreak", "allowradar")) {
        killstreaks::register("uav", "uav", "killstreak_uav", "uav_used", &activateuav);
        killstreaks::function_f79fd1e9("uav", %KILLSTREAK_EARNED_RADAR, %KILLSTREAK_RADAR_NOT_AVAILABLE, %KILLSTREAK_RADAR_INBOUND, undefined, %KILLSTREAK_RADAR_HACKED);
        killstreaks::register_dialog("uav", "mpl_killstreak_radar", "uavDialogBundle", "uavPilotDialogBundle", "friendlyUav", "enemyUav", "enemyUavMultiple", "friendlyUavHacked", "enemyUavHacked", "requestUav", "threatUav");
    }
    level thread uavtracker();
    callback::on_connect(&onplayerconnect);
    callback::on_spawned(&onplayerspawned);
    callback::on_joined_team(&onplayerjoinedteam);
    setmatchflag("radar_allies", 0);
    setmatchflag("radar_axis", 0);
}

// Namespace uav
// Params 1, eflags: 0x0
// Checksum 0xdc3a3b02, Offset: 0x8b8
// Size: 0x2a
function hackedprefunction(hacker) {
    uav = self;
    uav resetactiveuav();
}

// Namespace uav
// Params 2, eflags: 0x0
// Checksum 0x3f962142, Offset: 0x8f0
// Size: 0xa2
function configureteampost(owner, ishacked) {
    uav = self;
    uav thread teams::waituntilteamchangesingleton(owner, "UAV_watch_team_change", &onteamchange, owner.entnum, "delete", "death", "leaving");
    if (ishacked == 0) {
        uav teams::hidetosameteam();
    } else {
        uav setvisibletoall();
    }
    owner addactiveuav();
}

// Namespace uav
// Params 0, eflags: 0x0
// Checksum 0xdc45fd33, Offset: 0x9a0
// Size: 0x51c
function activateuav() {
    assert(isdefined(level.players));
    if (self killstreakrules::iskillstreakallowed("uav", self.team) == 0) {
        return false;
    }
    killstreak_id = self killstreakrules::killstreakstart("uav", self.team);
    if (killstreak_id == -1) {
        return false;
    }
    rotator = level.airsupport_rotator;
    attach_angle = -90;
    uav = spawn("script_model", rotator gettagorigin("tag_origin"));
    if (!isdefined(level.spawneduavs)) {
        level.spawneduavs = [];
    } else if (!isarray(level.spawneduavs)) {
        level.spawneduavs = array(level.spawneduavs);
    }
    level.spawneduavs[level.spawneduavs.size] = uav;
    uav setmodel("veh_t7_drone_uav_enemy_vista");
    uav.targetname = "uav";
    uav killstreaks::configure_team("uav", killstreak_id, self, undefined, undefined, &configureteampost);
    uav killstreak_hacking::enable_hacking("uav", &hackedprefunction, undefined);
    uav clientfield::set("enemyvehicle", 1);
    killstreak_detect::killstreaktargetset(uav);
    uav setdrawinfrared(1);
    uav.killstreak_id = killstreak_id;
    uav.leaving = 0;
    uav.health = 99999;
    uav.maxhealth = 700;
    uav.lowhealth = 700 * 0.5;
    uav setcandamage(1);
    uav thread killstreaks::monitordamage("uav", uav.maxhealth, &destroyuav, uav.lowhealth, &onlowhealth, 0, undefined, 1);
    uav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing");
    uav.rocketdamage = uav.maxhealth + 1;
    minflyheight = int(airsupport::getminimumflyheight());
    zoffset = minflyheight + (isdefined(level.uav_z_offset) ? level.uav_z_offset : 2500);
    angle = randomint(360);
    radiusoffset = (isdefined(level.uav_rotation_radius) ? level.uav_rotation_radius : 4000) + randomint(isdefined(level.uav_rotation_random_offset) ? level.uav_rotation_random_offset : 1000);
    xoffset = cos(angle) * radiusoffset;
    yoffset = sin(angle) * radiusoffset;
    anglevector = vectornormalize((xoffset, yoffset, zoffset));
    anglevector *= zoffset;
    uav linkto(rotator, "tag_origin", anglevector, (0, angle + attach_angle, 0));
    self addweaponstat(getweapon("uav"), "used", 1);
    uav thread killstreaks::waitfortimeout("uav", 25000, &ontimeout, "delete", "death", "crashing");
    uav thread killstreaks::waitfortimecheck(25000 / 2, &ontimecheck, "delete", "death", "crashing");
    uav thread startuavfx();
    self killstreaks::play_killstreak_start_dialog("uav", self.team, killstreak_id);
    uav killstreaks::play_pilot_dialog_on_owner("arrive", "uav", killstreak_id);
    uav thread killstreaks::player_killstreak_threat_tracking("uav");
    return true;
}

// Namespace uav
// Params 2, eflags: 0x0
// Checksum 0x8f3c4ded, Offset: 0xec8
// Size: 0x62
function onlowhealth(attacker, weapon) {
    self.is_damaged = 1;
    params = level.killstreakbundle["uav"];
    if (isdefined(params.fxlowhealth)) {
        playfxontag(params.fxlowhealth, self, "tag_origin");
    }
}

// Namespace uav
// Params 2, eflags: 0x0
// Checksum 0x711d1107, Offset: 0xf38
// Size: 0x22
function onteamchange(entnum, event) {
    destroyuav(undefined, undefined);
}

// Namespace uav
// Params 2, eflags: 0x0
// Checksum 0x63e3b95e, Offset: 0xf68
// Size: 0x1d2
function destroyuav(attacker, weapon) {
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (!isdefined(self.owner) || isdefined(attacker) && self.owner util::isenemyplayer(attacker)) {
        scoreevents::processscoreevent("destroyed_uav", attacker, self.owner, weapon);
        luinotifyevent(%player_callout, 2, %KILLSTREAK_DESTROYED_UAV, attacker.entnum);
        attacker challenges::addflyswatterstat(weapon, self);
    }
    if (!self.leaving) {
        self removeactiveuav();
        self killstreaks::play_destroyed_dialog_on_owner("uav", self.killstreak_id);
    }
    self notify(#"crashing");
    self playsound("evt_helicopter_midair_exp");
    params = level.killstreakbundle["uav"];
    if (isdefined(params.ksexplosionfx)) {
        playfxontag(params.ksexplosionfx, self, "tag_origin");
    }
    self stoploopsound();
    self setmodel("tag_origin");
    target_remove(self);
    self unlink();
    wait 0.5;
    arrayremovevalue(level.spawneduavs, self);
    self notify(#"delete");
    self delete();
}

// Namespace uav
// Params 0, eflags: 0x0
// Checksum 0x2f8fcdef, Offset: 0x1148
// Size: 0x47
function onplayerconnect() {
    self.entnum = self getentitynumber();
    if (!level.teambased) {
        level.activeuavs[self.entnum] = 0;
    }
    level.activeplayeruavs[self.entnum] = 0;
}

// Namespace uav
// Params 0, eflags: 0x0
// Checksum 0xa16d291, Offset: 0x1198
// Size: 0x2b
function onplayerspawned() {
    self endon(#"disconnect");
    if (level.teambased == 0 || level.multiteam == 1) {
        level notify(#"uav_update");
    }
}

// Namespace uav
// Params 0, eflags: 0x0
// Checksum 0x42ae7b3a, Offset: 0x11d0
// Size: 0x12
function onplayerjoinedteam() {
    hidealluavstosameteam();
}

// Namespace uav
// Params 0, eflags: 0x0
// Checksum 0x262bfe3, Offset: 0x11f0
// Size: 0xca
function ontimeout() {
    playafterburnerfx();
    if (isdefined(self.is_damaged) && self.is_damaged) {
        playfxontag("killstreaks/fx_uav_damage_trail", self, "tag_body");
    }
    self killstreaks::play_pilot_dialog_on_owner("timeout", "uav");
    self.leaving = 1;
    self removeactiveuav();
    airsupport::leave(10);
    wait 10;
    target_remove(self);
    arrayremovevalue(level.spawneduavs, self);
    self delete();
}

// Namespace uav
// Params 0, eflags: 0x0
// Checksum 0x659f9e26, Offset: 0x12c8
// Size: 0x2a
function ontimecheck() {
    self killstreaks::play_pilot_dialog_on_owner("timecheck", "uav", self.killstreak_id);
}

// Namespace uav
// Params 0, eflags: 0x0
// Checksum 0x5da998a6, Offset: 0x1300
// Size: 0x6a
function startuavfx() {
    self endon(#"death");
    wait 0.1;
    if (isdefined(self)) {
        playfxontag("killstreaks/fx_uav_lights", self, "tag_origin");
        playfxontag("killstreaks/fx_uav_bunner", self, "tag_origin");
        self playloopsound("veh_uav_engine_loop", 1);
    }
}

// Namespace uav
// Params 0, eflags: 0x0
// Checksum 0x5e4e61c1, Offset: 0x1378
// Size: 0x7a
function playafterburnerfx() {
    self endon(#"death");
    wait 0.1;
    if (isdefined(self)) {
        playfxontag("killstreaks/fx_uav_bunner", self, "tag_origin");
        self stoploopsound();
        team = util::getotherteam(self.team);
        self playsoundtoteam("veh_kls_uav_afterburner", team);
    }
}

// Namespace uav
// Params 1, eflags: 0x0
// Checksum 0x6a5383c6, Offset: 0x1400
// Size: 0x14
function hasuav(team_or_entnum) {
    return level.activeuavs[team_or_entnum] > 0;
}

// Namespace uav
// Params 0, eflags: 0x0
// Checksum 0x100fcfc3, Offset: 0x1420
// Size: 0xa3
function addactiveuav() {
    if (level.teambased) {
        assert(isdefined(self.team));
        level.activeuavs[self.team]++;
    } else {
        assert(isdefined(self.entnum));
        if (!isdefined(self.entnum)) {
            self.entnum = self getentitynumber();
        }
        level.activeuavs[self.entnum]++;
    }
    level.activeplayeruavs[self.entnum]++;
    level notify(#"uav_update");
}

// Namespace uav
// Params 0, eflags: 0x0
// Checksum 0x28f45fb1, Offset: 0x14d0
// Size: 0x4a
function removeactiveuav() {
    uav = self;
    uav resetactiveuav();
    uav killstreakrules::killstreakstop("uav", self.originalteam, self.killstreak_id);
}

// Namespace uav
// Params 0, eflags: 0x0
// Checksum 0x43077e6d, Offset: 0x1528
// Size: 0x1ab
function resetactiveuav() {
    if (level.teambased) {
        level.activeuavs[self.team]--;
        assert(level.activeuavs[self.team] >= 0);
        if (level.activeuavs[self.team] < 0) {
            level.activeuavs[self.team] = 0;
        }
    } else if (isdefined(self.owner)) {
        assert(isdefined(self.owner.entnum));
        if (!isdefined(self.owner.entnum)) {
            self.owner.entnum = self.owner getentitynumber();
        }
        level.activeuavs[self.owner.entnum]--;
        assert(level.activeuavs[self.owner.entnum] >= 0);
        if (level.activeuavs[self.owner.entnum] < 0) {
            level.activeuavs[self.owner.entnum] = 0;
        }
    }
    if (isdefined(self.owner)) {
        level.activeplayeruavs[self.owner.entnum]--;
        assert(level.activeplayeruavs[self.owner.entnum] >= 0);
    }
    level notify(#"uav_update");
}

// Namespace uav
// Params 2, eflags: 0x0
// Checksum 0xa3dabd10, Offset: 0x16e0
// Size: 0x6a
function function_e65f2b28(team, value) {
    setteamspyplane(team, value);
    if (team == "allies") {
        setmatchflag("radar_allies", value);
        return;
    }
    if (team == "axis") {
        setmatchflag("radar_axis", value);
    }
}

// Namespace uav
// Params 0, eflags: 0x0
// Checksum 0x6bb9fbee, Offset: 0x1758
// Size: 0x1e1
function uavtracker() {
    level endon(#"game_ended");
    while (true) {
        level waittill(#"uav_update");
        if (level.teambased) {
            foreach (team in level.teams) {
                activeuavs = level.activeuavs[team];
                if (!activeuavs) {
                    function_e65f2b28(team, 0);
                    continue;
                }
                var_d67eba24 = 1;
                if (activeuavs > 1) {
                    var_d67eba24 = 2;
                }
                function_e65f2b28(team, var_d67eba24);
            }
            continue;
        }
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            assert(isdefined(player.entnum));
            if (!isdefined(player.entnum)) {
                player.entnum = player getentitynumber();
            }
            activeuavs = level.activeuavs[player.entnum];
            if (activeuavs == 0) {
                player setclientuivisibilityflag("radar_client", 0);
                player.hasspyplane = 0;
                continue;
            }
            if (activeuavs > 1) {
                var_d67eba24 = 2;
            } else {
                var_d67eba24 = 1;
            }
            player setclientuivisibilityflag("radar_client", 1);
            player.hasspyplane = var_d67eba24;
        }
    }
}

// Namespace uav
// Params 0, eflags: 0x0
// Checksum 0x3809c53c, Offset: 0x1948
// Size: 0x6b
function hidealluavstosameteam() {
    foreach (uav in level.spawneduavs) {
        if (isdefined(uav)) {
            uav teams::hidetosameteam();
        }
    }
}

