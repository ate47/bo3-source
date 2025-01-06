#using scripts/codescripts/struct;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/teams/_teams;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/hostmigration_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_heatseekingmissile;
#using scripts/shared/weapons/_weaponobjects;

#namespace satellite;

// Namespace satellite
// Params 0, eflags: 0x0
// Checksum 0x634c7731, Offset: 0x630
// Size: 0x1a2
function init() {
    if (level.teambased) {
        foreach (team in level.teams) {
            level.activesatellites[team] = 0;
        }
    } else {
        level.activesatellites = [];
    }
    level.activeplayersatellites = [];
    if (tweakables::gettweakablevalue("killstreak", "allowradardirection")) {
        killstreaks::register("satellite", "satellite", "killstreak_satellite", "uav_used", &function_861da8b9);
        killstreaks::function_f79fd1e9("satellite", %KILLSTREAK_EARNED_SATELLITE, %KILLSTREAK_SATELLITE_NOT_AVAILABLE, %KILLSTREAK_SATELLITE_INBOUND, undefined, %KILLSTREAK_SATELLITE_HACKED);
        killstreaks::register_dialog("satellite", "mpl_killstreak_satellite", "satelliteDialogBundle", undefined, "friendlySatellite", "enemySatellite", "enemySatelliteMultiple", "friendlySatelliteHacked", "enemySatelliteHacked", "requestSatellite", "threatSatellite");
    }
    callback::on_connect(&onplayerconnect);
    level thread function_d3974478();
}

// Namespace satellite
// Params 0, eflags: 0x0
// Checksum 0x811869d5, Offset: 0x7e0
// Size: 0x47
function onplayerconnect() {
    self.entnum = self getentitynumber();
    if (!level.teambased) {
        level.activesatellites[self.entnum] = 0;
    }
    level.activeplayersatellites[self.entnum] = 0;
}

// Namespace satellite
// Params 0, eflags: 0x0
// Checksum 0xaf6a41d3, Offset: 0x830
// Size: 0x414
function function_861da8b9() {
    if (self killstreakrules::iskillstreakallowed("satellite", self.team) == 0) {
        return false;
    }
    killstreak_id = self killstreakrules::killstreakstart("satellite", self.team);
    if (killstreak_id == -1) {
        return false;
    }
    minflyheight = int(airsupport::getminimumflyheight());
    zoffset = minflyheight + 5500;
    var_ad3d606 = randomfloatrange(90, 180);
    var_4946b43 = airsupport::getmaxmapwidth() * 1.5;
    xoffset = sin(var_ad3d606) * var_4946b43;
    yoffset = cos(var_ad3d606) * var_4946b43;
    satellite = spawn("script_model", airsupport::getmapcenter() + (xoffset, yoffset, zoffset));
    satellite setmodel("veh_t7_drone_srv_blimp");
    satellite setscale(1);
    satellite.killstreak_id = killstreak_id;
    satellite.owner = self;
    satellite.ownerentnum = self getentitynumber();
    satellite.team = self.team;
    satellite setteam(self.team);
    satellite setowner(self);
    satellite killstreaks::configure_team("satellite", killstreak_id, self, undefined, undefined, &configureteampost);
    satellite killstreak_hacking::enable_hacking("satellite", &hackedprefunction, undefined);
    satellite.targetname = "satellite";
    satellite.maxhealth = 700;
    satellite.lowhealth = 700 * 0.5;
    satellite.health = 99999;
    satellite.leaving = 0;
    satellite setcandamage(1);
    satellite thread killstreaks::monitordamage("satellite", satellite.maxhealth, &function_7ea6b1cc, satellite.lowhealth, &onlowhealth, 0, undefined, 0);
    satellite.rocketdamage = satellite.maxhealth / 3 + 1;
    /#
    #/
    satellite moveto(airsupport::getmapcenter() + (xoffset * -1, yoffset * -1, zoffset), 40000 * 0.001);
    target_set(satellite);
    satellite clientfield::set("enemyvehicle", 1);
    satellite thread killstreaks::waitfortimeout("satellite", 40000, &ontimeout, "death", "crashing");
    satellite thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("death");
    satellite thread rotate(10);
    self killstreaks::play_killstreak_start_dialog("satellite", self.team, killstreak_id);
    satellite thread killstreaks::player_killstreak_threat_tracking("satellite");
    return true;
}

// Namespace satellite
// Params 1, eflags: 0x0
// Checksum 0x25b34fa0, Offset: 0xc50
// Size: 0x2a
function hackedprefunction(hacker) {
    satellite = self;
    satellite function_5ae5cc6b();
}

// Namespace satellite
// Params 2, eflags: 0x0
// Checksum 0x52eeb9cd, Offset: 0xc88
// Size: 0xa2
function configureteampost(owner, ishacked) {
    satellite = self;
    satellite thread teams::waituntilteamchangesingleton(owner, "Satellite_watch_team_change", &onteamchange, self.entnum, "delete", "death", "leaving");
    if (ishacked == 0) {
        satellite teams::hidetosameteam();
    } else {
        satellite setvisibletoall();
    }
    satellite function_e4c6d41f();
}

// Namespace satellite
// Params 1, eflags: 0x0
// Checksum 0xa72d54b6, Offset: 0xd38
// Size: 0x39
function rotate(duration) {
    self endon(#"death");
    while (true) {
        self rotateyaw(-360, duration);
        wait duration;
    }
}

// Namespace satellite
// Params 2, eflags: 0x0
// Checksum 0x8a2580c6, Offset: 0xd80
// Size: 0x12
function onlowhealth(attacker, weapon) {
    
}

// Namespace satellite
// Params 2, eflags: 0x0
// Checksum 0x314f2e2c, Offset: 0xda0
// Size: 0x22
function onteamchange(entnum, event) {
    function_7ea6b1cc(undefined, undefined);
}

// Namespace satellite
// Params 0, eflags: 0x0
// Checksum 0x7f4952bc, Offset: 0xdd0
// Size: 0x7a
function ontimeout() {
    self killstreaks::play_pilot_dialog_on_owner("timeout", "satellite");
    self.leaving = 1;
    self function_2a11ce46();
    airsupport::leave(10);
    wait 10;
    if (target_istarget(self)) {
        target_remove(self);
    }
    self delete();
}

// Namespace satellite
// Params 2, eflags: 0x0
// Checksum 0x92468d4e, Offset: 0xe58
// Size: 0x162
function function_7ea6b1cc(attacker, weapon) {
    if (!isdefined(attacker)) {
        attacker = undefined;
    }
    if (!isdefined(weapon)) {
        weapon = undefined;
    }
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (isdefined(attacker)) {
        scoreevents::processscoreevent("destroyed_satellite", attacker, self.owner, weapon);
        luinotifyevent(%player_callout, 2, %KILLSTREAK_DESTROYED_SATELLITE, attacker.entnum);
        if (!self.leaving) {
            self killstreaks::play_destroyed_dialog_on_owner("satellite", self.killstreak_id);
        }
    }
    self notify(#"crashing");
    params = level.killstreakbundle["satellite"];
    if (isdefined(params.ksexplosionfx)) {
        playfxontag(params.ksexplosionfx, self, "tag_origin");
    }
    self setmodel("tag_origin");
    if (target_istarget(self)) {
        target_remove(self);
    }
    wait 0.5;
    if (!self.leaving) {
        self function_2a11ce46();
    }
    self delete();
}

// Namespace satellite
// Params 1, eflags: 0x0
// Checksum 0x2586f05f, Offset: 0xfc8
// Size: 0x14
function hassatellite(team_or_entnum) {
    return level.activesatellites[team_or_entnum] > 0;
}

// Namespace satellite
// Params 0, eflags: 0x0
// Checksum 0x49966014, Offset: 0xfe8
// Size: 0x4b
function function_e4c6d41f() {
    if (level.teambased) {
        level.activesatellites[self.team]++;
    } else {
        level.activesatellites[self.ownerentnum]++;
    }
    level.activeplayersatellites[self.ownerentnum]++;
    level notify(#"hash_812d92f0");
}

// Namespace satellite
// Params 0, eflags: 0x0
// Checksum 0x1b44a88, Offset: 0x1040
// Size: 0x3a
function function_2a11ce46() {
    self function_5ae5cc6b();
    killstreakrules::killstreakstop("satellite", self.originalteam, self.killstreak_id);
}

// Namespace satellite
// Params 0, eflags: 0x0
// Checksum 0x44aee9b8, Offset: 0x1088
// Size: 0x12b
function function_5ae5cc6b() {
    if (level.teambased) {
        level.activesatellites[self.team]--;
        assert(level.activesatellites[self.team] >= 0);
        if (level.activesatellites[self.team] < 0) {
            level.activesatellites[self.team] = 0;
        }
    } else if (isdefined(self.ownerentnum)) {
        level.activesatellites[self.ownerentnum]--;
        assert(level.activesatellites[self.ownerentnum] >= 0);
        if (level.activesatellites[self.ownerentnum] < 0) {
            level.activesatellites[self.ownerentnum] = 0;
        }
    }
    assert(isdefined(self.ownerentnum));
    level.activeplayersatellites[self.ownerentnum]--;
    assert(level.activeplayersatellites[self.ownerentnum] >= 0);
    level notify(#"hash_812d92f0");
}

// Namespace satellite
// Params 0, eflags: 0x0
// Checksum 0x1c73c56c, Offset: 0x11c0
// Size: 0x1b1
function function_d3974478() {
    level endon(#"game_ended");
    while (true) {
        level waittill(#"hash_812d92f0");
        if (level.teambased) {
            foreach (team in level.teams) {
                activesatellites = level.activesatellites[team];
                if (!activesatellites) {
                    function_ef3b64ee(team, 0);
                    continue;
                }
                function_ef3b64ee(team, 1);
            }
            continue;
        }
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            assert(isdefined(player.entnum));
            if (!isdefined(player.entnum)) {
                player.entnum = player getentitynumber();
            }
            activesatellites = level.activesatellites[player.entnum];
            if (activesatellites == 0) {
                player setclientuivisibilityflag("radar_client", 0);
                player.hassatellite = 0;
                continue;
            }
            player setclientuivisibilityflag("radar_client", 1);
            player.hassatellite = 1;
        }
    }
}

// Namespace satellite
// Params 2, eflags: 0x0
// Checksum 0x9fd455f3, Offset: 0x1380
// Size: 0x6a
function function_ef3b64ee(team, value) {
    setteamsatellite(team, value);
    if (team == "allies") {
        setmatchflag("radar_allies", value);
        return;
    }
    if (team == "axis") {
        setmatchflag("radar_axis", value);
    }
}

