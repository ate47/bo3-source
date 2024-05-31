#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/shared/weapons/_hacker_tool;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_planemortar;
#using scripts/mp/killstreaks/_satellite;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/_util;
#using scripts/mp/_challenges;
#using scripts/shared/util_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/challenges_shared;
#using scripts/codescripts/struct;

#namespace drone_strike;

// Namespace drone_strike
// Params 0, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_c35e6aab
// Checksum 0xcacd8e6d, Offset: 0x6b0
// Size: 0x10c
function init() {
    killstreaks::register("drone_strike", "drone_strike", "killstreak_drone_strike", "drone_strike_used", &function_a8bde492, 1);
    killstreaks::function_f79fd1e9("drone_strike", %KILLSTREAK_DRONE_STRIKE_EARNED, %KILLSTREAK_DRONE_STRIKE_NOT_AVAILABLE, %KILLSTREAK_DRONE_STRIKE_INBOUND, %KILLSTREAK_DRONE_STRIKE_INBOUND_NEAR_PLAYER, %KILLSTREAK_DRONE_STRIKE_HACKED);
    killstreaks::register_dialog("drone_strike", "mpl_killstreak_drone_strike", "droneStrikeDialogBundle", undefined, "friendlyDroneStrike", "enemyDroneStrike", "enemyDroneStrikeMultiple", "friendlyDroneStrikeHacked", "enemyDroneStrikeHacked", "requestDroneStrike", "threatDroneStrike");
    killstreaks::set_team_kill_penalty_scale("drone_strike", level.teamkillreducedpenalty);
}

// Namespace drone_strike
// Params 0, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_a8bde492
// Checksum 0xa3e9ac8d, Offset: 0x7c8
// Size: 0x76
function function_a8bde492() {
    if (self killstreakrules::iskillstreakallowed("drone_strike", self.team) == 0) {
        return false;
    }
    result = self function_11a55cc6();
    if (!isdefined(result) || !result) {
        return false;
    }
    return true;
}

// Namespace drone_strike
// Params 0, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_11a55cc6
// Checksum 0x2c1bed70, Offset: 0x848
// Size: 0x18a
function function_11a55cc6() {
    self beginlocationnapalmselection("map_directional_selector");
    self.selectinglocation = 1;
    self thread airsupport::endselectionthink();
    locations = [];
    if (!isdefined(self.pers["drone_strike_radar_used"]) || !self.pers["drone_strike_radar_used"]) {
        self thread planemortar::singleradarsweep();
    }
    location = self waitforlocationselection();
    if (!isdefined(self)) {
        return 0;
    }
    if (!isdefined(location.origin)) {
        self.pers["drone_strike_radar_used"] = 1;
        self notify(#"cancel_selection");
        return 0;
    }
    if (self killstreakrules::iskillstreakallowed("drone_strike", self.team) == 0) {
        self.pers["drone_strike_radar_used"] = 1;
        self notify(#"cancel_selection");
        return 0;
    }
    self.pers["drone_strike_radar_used"] = 0;
    return self airsupport::function_b49a99ff(location, &function_516499e1);
}

// Namespace drone_strike
// Params 0, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_16fae838
// Checksum 0xf2abe4f9, Offset: 0x9e0
// Size: 0x8c
function waitforlocationselection() {
    self endon(#"emp_jammed");
    self endon(#"emp_grenaded");
    location, yaw = self waittill(#"confirm_location");
    locationinfo = spawnstruct();
    locationinfo.origin = location;
    locationinfo.yaw = yaw;
    return locationinfo;
}

// Namespace drone_strike
// Params 1, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_516499e1
// Checksum 0x8139dd51, Offset: 0xa78
// Size: 0x158
function function_516499e1(location) {
    team = self.team;
    killstreak_id = self killstreakrules::killstreakstart("drone_strike", team, 0, 1);
    if (killstreak_id == -1) {
        return false;
    }
    self killstreaks::play_killstreak_start_dialog("drone_strike", team, killstreak_id);
    self addweaponstat(getweapon("drone_strike"), "used", 1);
    spawn_influencer = level spawning::create_enemy_influencer("artillery", location.origin, team);
    self thread watchforkillstreakend(team, spawn_influencer, killstreak_id);
    self thread function_25291ec1(location.origin, location.yaw, team, killstreak_id);
    return true;
}

// Namespace drone_strike
// Params 3, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_c6a9df54
// Checksum 0x87d3f965, Offset: 0xbd8
// Size: 0x7c
function watchforkillstreakend(team, influencer, killstreak_id) {
    self util::waittill_any("disconnect", "joined_team", "joined_spectators", "drone_strike_complete", "emp_jammed");
    killstreakrules::killstreakstop("drone_strike", team, killstreak_id);
}

// Namespace drone_strike
// Params 4, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_25291ec1
// Checksum 0x29047183, Offset: 0xc60
// Size: 0x3aa
function function_25291ec1(position, yaw, team, killstreak_id) {
    self endon(#"emp_jammed");
    self endon(#"joined_team");
    self endon(#"joined_spectators");
    self endon(#"disconnect");
    angles = (0, yaw, 0);
    direction = anglestoforward(angles);
    height = airsupport::getminimumflyheight() + 3000;
    var_6b3d591b = (position[0], position[1], height);
    startpoint = var_6b3d591b + vectorscale(direction, -14000);
    endpoint = var_6b3d591b + vectorscale(direction, -6000);
    tracestartpos = (position[0], position[1], height);
    traceendpos = (position[0], position[1], height * -1);
    trace = bullettrace(tracestartpos, traceendpos, 0, undefined);
    targetpoint = trace["fraction"] < 1 ? trace["position"] : (position[0], position[1], 0);
    initialoffset = vectorscale(direction, (12 * 0.5 - 1) * 500) * -1;
    for (i = 0; i < 12; i++) {
        right = anglestoright(angles);
        rightoffset = vectorscale(right, 300);
        leftoffset = vectorscale(right, 900);
        forwardoffset = endpoint + initialoffset + vectorscale(direction, i * 500);
        self thread spawndrone(startpoint + rightoffset, forwardoffset + rightoffset, targetpoint, angles, self.team, killstreak_id);
        self thread spawndrone(startpoint - rightoffset, forwardoffset - rightoffset, targetpoint, angles, self.team, killstreak_id);
        self thread spawndrone(startpoint + leftoffset, forwardoffset + leftoffset, targetpoint, angles, self.team, killstreak_id);
        wait(1);
        self playsound("mpl_thunder_flyover_wash");
    }
    wait(3);
    self notify(#"hash_6c0f0160");
}

// Namespace drone_strike
// Params 6, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_9c823234
// Checksum 0x3824999, Offset: 0x1018
// Size: 0x524
function spawndrone(startpoint, endpoint, targetpoint, angles, team, killstreak_id) {
    drone = spawnplane(self, "script_model", startpoint);
    drone.team = team;
    drone.targetname = "drone_strike";
    drone setowner(self);
    drone.owner = self;
    drone.owner thread watchownerevents(drone);
    drone killstreaks::configure_team("drone_strike", killstreak_id, self);
    drone killstreak_hacking::enable_hacking("drone_strike");
    target_set(drone);
    drone endon(#"delete");
    drone endon(#"death");
    drone.angles = angles;
    drone setmodel("veh_t7_drone_rolling_thunder");
    drone setenemymodel("veh_t7_drone_rolling_thunder");
    drone notsolid();
    playfxontag("killstreaks/fx_rolling_thunder_thruster_trails", drone, "tag_fx");
    drone clientfield::set("enemyvehicle", 1);
    drone function_d3f5bb28();
    drone thread watchforemp(self);
    drone moveto(endpoint, 1.8, 0, 0);
    wait(1.8);
    weapon = getweapon("drone_strike");
    velocity = drone getvelocity();
    halfgravity = 386;
    dxy = abs(-6000);
    dz = endpoint[2] - targetpoint[2];
    dvxy = dxy * sqrt(halfgravity / dz);
    nvel = vectornormalize(velocity);
    launchvel = nvel * dvxy;
    bomb = self function_5e5cdbc0(weapon, drone.origin, launchvel);
    target_set(bomb);
    bomb killstreaks::configure_team("drone_strike", killstreak_id, self);
    bomb killstreak_hacking::enable_hacking("drone_strike");
    drone notify(#"hackertool_update_ent", bomb);
    bomb clientfield::set("enemyvehicle", 1);
    bomb.targetname = "drone_strike";
    bomb setowner(self);
    bomb.owner = self;
    bomb.team = team;
    bomb playsound("mpl_thunder_incoming_start");
    bomb function_d3f5bb28();
    bomb thread watchforemp(self);
    bomb.owner thread watchownerevents(bomb);
    wait(0.05);
    drone hide();
    wait(0.05);
    drone delete();
}

// Namespace drone_strike
// Params 0, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_d3f5bb28
// Checksum 0xb9ec8118, Offset: 0x1548
// Size: 0xf4
function function_d3f5bb28() {
    drone = self;
    drone setcandamage(1);
    drone.maxhealth = killstreak_bundles::get_max_health("drone_strike");
    drone.lowhealth = killstreak_bundles::get_low_health("drone_strike");
    drone.health = drone.maxhealth;
    drone thread killstreaks::monitordamage("drone_strike", drone.maxhealth, &function_d04637c1, drone.lowhealth, undefined, 0, &function_cf848804, 1);
}

// Namespace drone_strike
// Params 2, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_d04637c1
// Checksum 0xf2466db1, Offset: 0x1648
// Size: 0x19c
function function_d04637c1(attacker, weapon) {
    self endon(#"death");
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (!isdefined(self.owner) || isdefined(attacker) && self.owner util::isenemyplayer(attacker)) {
        challenges::destroyedaircraft(attacker, weapon, 0);
        attacker challenges::addflyswatterstat(weapon, self);
        scoreevents::processscoreevent("destroyed_rolling_thunder_drone", attacker, self.owner, weapon);
        luinotifyevent(%player_callout, 2, %KILLSTREAK_DESTROYED_ROLLING_THUNDER_DRONE, attacker.entnum);
    }
    params = level.killstreakbundle["drone_strike"];
    if (isdefined(params.ksexplosionfx)) {
        playfxontag(params.ksexplosionfx, self, "tag_origin");
    }
    self setmodel("tag_origin");
    wait(0.5);
    self delete();
}

// Namespace drone_strike
// Params 1, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_27a3a860
// Checksum 0x3e155982, Offset: 0x17f0
// Size: 0x84
function watchownerevents(bomb) {
    player = self;
    bomb endon(#"death");
    player util::waittill_any("disconnect", "joined_team", "joined_spectators");
    if (isdefined(isalive(bomb))) {
        bomb delete();
    }
}

// Namespace drone_strike
// Params 1, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_b5c537e7
// Checksum 0x304e9434, Offset: 0x1880
// Size: 0x6c
function watchforemp(owner) {
    self endon(#"delete");
    self endon(#"death");
    attacker = self waittill(#"emp_deployed");
    thread function_b45679d2(attacker, self);
    self function_ed58337a();
}

// Namespace drone_strike
// Params 1, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_cf848804
// Checksum 0xe67477e1, Offset: 0x18f8
// Size: 0x3c
function function_cf848804(attacker) {
    thread function_b45679d2(attacker, self);
    self function_ed58337a();
}

// Namespace drone_strike
// Params 2, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_b45679d2
// Checksum 0xa0e22a3c, Offset: 0x1940
// Size: 0x15c
function function_b45679d2(attacker, victim) {
    owner = self.owner;
    attacker endon(#"disconnect");
    attacker notify(#"hash_ae1b534e");
    attacker endon(#"hash_ae1b534e");
    waittillframeend();
    attacker = self [[ level.figure_out_attacker ]](attacker);
    scoreevents::processscoreevent("destroyed_rolling_thunder_all_drones", attacker, victim, getweapon("emp"));
    challenges::destroyedaircraft(attacker, getweapon("emp"), 0);
    attacker challenges::addflyswatterstat(getweapon("emp"), self);
    luinotifyevent(%player_callout, 2, %KILLSTREAK_DESTROYED_ROLLING_THUNDER_ALL_DRONES, attacker.entnum);
    owner globallogic_audio::play_taacom_dialog("destroyed", "drone_strike");
}

// Namespace drone_strike
// Params 0, eflags: 0x1 linked
// namespace_b244b82a<file_0>::function_ed58337a
// Checksum 0xa730fe5e, Offset: 0x1aa8
// Size: 0x7c
function function_ed58337a() {
    params = level.killstreakbundle["drone_strike"];
    if (isdefined(self) && isdefined(params.ksexplosionfx)) {
        playfx(params.ksexplosionfx, self.origin);
    }
    self delete();
}

