#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_helicopter;
#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreak_detect;
#using scripts/mp/killstreaks/_killstreak_hacking;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_satellite;
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

#namespace counteruav;

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0x24ab1bd3, Offset: 0x700
// Size: 0x2a2
function init() {
    level.activecounteruavs = [];
    level.counter_uav_positions = generaterandompoints(20);
    level.counter_uav_position_index = [];
    level.counter_uav_offsets = buildoffsetlist((0, 0, 0), 3, 450, 450);
    if (level.teambased) {
        foreach (team in level.teams) {
            level.activecounteruavs[team] = 0;
            level.counter_uav_position_index[team] = 0;
            level thread movementmanagerthink(team);
        }
    } else {
        level.activecounteruavs = [];
    }
    level.activeplayercounteruavs = [];
    level.counter_uav_entities = [];
    if (tweakables::gettweakablevalue("killstreak", "allowcounteruav")) {
        killstreaks::register("counteruav", "counteruav", "killstreak_counteruav", "counteruav_used", &activatecounteruav);
        killstreaks::function_f79fd1e9("counteruav", %KILLSTREAK_EARNED_COUNTERUAV, %KILLSTREAK_COUNTERUAV_NOT_AVAILABLE, %KILLSTREAK_COUNTERUAV_INBOUND, undefined, %KILLSTREAK_COUNTERUAV_HACKED);
        killstreaks::register_dialog("counteruav", "mpl_killstreak_radar", "counterUavDialogBundle", "counterUavPilotDialogBundle", "friendlyCounterUav", "enemyCounterUav", "enemyCounterUavMultiple", "friendlyCounterUavHacked", "enemyCounterUavHacked", "requestCounterUav", "threatCounterUav");
    }
    clientfield::register("toplayer", "counteruav", 1, 1, "int");
    level thread watchcounteruavs();
    callback::on_connect(&onplayerconnect);
    callback::on_spawned(&onplayerspawned);
    callback::on_joined_team(&onplayerjoinedteam);
    /#
        if (getdvarint("<dev string:x28>")) {
            level thread waitanddebugdrawoffsetlist();
        }
    #/
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0xc5de9c7b, Offset: 0x9b0
// Size: 0x6b
function onplayerconnect() {
    self.entnum = self getentitynumber();
    if (!level.teambased) {
        level.activecounteruavs[self.entnum] = 0;
        level.counter_uav_position_index[self.entnum] = 0;
        self thread movementmanagerthink(self.entnum);
    }
    level.activeplayercounteruavs[self.entnum] = 0;
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0x39c64fe, Offset: 0xa28
// Size: 0x42
function onplayerspawned() {
    if (self enemycounteruavactive()) {
        self clientfield::set_to_player("counteruav", 1);
        return;
    }
    self clientfield::set_to_player("counteruav", 0);
}

// Namespace counteruav
// Params 1, eflags: 0x0
// Checksum 0xa867793b, Offset: 0xa78
// Size: 0x101
function generaterandompoints(count) {
    points = [];
    for (i = 0; i < count; i++) {
        point = airsupport::getrandommappoint(isdefined(level.cuav_map_x_offset) ? level.cuav_map_x_offset : 0, isdefined(level.cuav_map_y_offset) ? level.cuav_map_y_offset : 0, isdefined(level.cuav_map_x_percentage) ? level.cuav_map_x_percentage : 0.5, isdefined(level.cuav_map_y_percentage) ? level.cuav_map_y_percentage : 0.5);
        minflyheight = airsupport::getminimumflyheight();
        point += (0, 0, minflyheight + (isdefined(level.counter_uav_position_z_offset) ? level.counter_uav_position_z_offset : 1000));
        points[i] = point;
    }
    return points;
}

// Namespace counteruav
// Params 1, eflags: 0x0
// Checksum 0x12222202, Offset: 0xb88
// Size: 0xd3
function movementmanagerthink(teamorentnum) {
    while (true) {
        level waittill(#"counter_uav_updated");
        activecount = 0;
        while (level.activecounteruavs[teamorentnum] > 0) {
            if (activecount == 0) {
                activecount = level.activecounteruavs[teamorentnum];
            }
            currentindex = level.counter_uav_position_index[teamorentnum];
            for (newindex = currentindex; newindex == currentindex; newindex = randomintrange(0, 20)) {
            }
            destination = level.counter_uav_positions[newindex];
            level.counter_uav_position_index[teamorentnum] = newindex;
            level notify("counter_uav_move_" + teamorentnum);
            wait 5 + randomintrange(5, 10);
        }
    }
}

// Namespace counteruav
// Params 1, eflags: 0x0
// Checksum 0xa6c0c768, Offset: 0xc68
// Size: 0x46
function getcurrentposition(teamorentnum) {
    baseposition = level.counter_uav_positions[level.counter_uav_position_index[teamorentnum]];
    offset = level.counter_uav_offsets[self.cuav_offset_index];
    return baseposition + offset;
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0xb12f984d, Offset: 0xcb8
// Size: 0x2a
function assignfirstavailableoffsetindex() {
    self.cuav_offset_index = getfirstavailableoffsetindex();
    maintaincouteruaventities();
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0x6ad5cfb8, Offset: 0xcf0
// Size: 0xd3
function getfirstavailableoffsetindex() {
    available_offsets = [];
    for (i = 0; i < level.counter_uav_offsets.size; i++) {
        available_offsets[i] = 1;
    }
    foreach (cuav in level.counter_uav_entities) {
        if (isdefined(cuav)) {
            available_offsets[cuav.cuav_offset_index] = 0;
        }
    }
    for (i = 0; i < available_offsets.size; i++) {
        if (available_offsets[i]) {
            return i;
        }
    }
    /#
        util::warning("<dev string:x3e>");
    #/
    return 0;
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0xe8bd6f4b, Offset: 0xdd0
// Size: 0x49
function maintaincouteruaventities() {
    for (i = level.counter_uav_entities.size; i >= 0; i--) {
        if (!isdefined(level.counter_uav_entities[i])) {
            arrayremoveindex(level.counter_uav_entities, i);
        }
    }
}

/#

    // Namespace counteruav
    // Params 0, eflags: 0x0
    // Checksum 0x6e2527ef, Offset: 0xe28
    // Size: 0x22
    function waitanddebugdrawoffsetlist() {
        level endon(#"game_ended");
        wait 10;
        debugdrawoffsetlist();
    }

    // Namespace counteruav
    // Params 0, eflags: 0x0
    // Checksum 0xde09d59f, Offset: 0xe58
    // Size: 0xab
    function debugdrawoffsetlist() {
        baseposition = level.counter_uav_positions[0];
        foreach (offset in level.counter_uav_offsets) {
            util::debug_sphere(baseposition + offset, 24, (0.95, 0.05, 0.05), 0.75, 9999999);
        }
    }

#/

// Namespace counteruav
// Params 4, eflags: 0x0
// Checksum 0xedef8c70, Offset: 0xf10
// Size: 0xf1
function buildoffsetlist(startoffset, depth, offset_x, offset_y) {
    offsets = [];
    for (col = 0; col < depth; col++) {
        itemcount = math::pow(2, col);
        startingindex = itemcount - 1;
        for (i = 0; i < itemcount; i++) {
            x = offset_x * col;
            y = 0;
            if (itemcount > 1) {
                y = i * offset_y;
                total_y = offset_y * startingindex;
                y -= total_y / 2;
            }
            offsets[startingindex + i] = startoffset + (x, y, 0);
        }
    }
    return offsets;
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0x5cdc1fd9, Offset: 0x1010
// Size: 0x264
function activatecounteruav() {
    if (self killstreakrules::iskillstreakallowed("counteruav", self.team) == 0) {
        return false;
    }
    killstreak_id = self killstreakrules::killstreakstart("counteruav", self.team);
    if (killstreak_id == -1) {
        return false;
    }
    counteruav = spawncounteruav(self, killstreak_id);
    if (!isdefined(counteruav)) {
        return false;
    }
    counteruav setscale(1);
    counteruav clientfield::set("enemyvehicle", 1);
    counteruav.killstreak_id = killstreak_id;
    counteruav thread killstreaks::waittillemp(&destroycounteruav);
    counteruav thread killstreaks::waitfortimeout("counteruav", 30000, &ontimeout, "delete", "death", "crashing");
    counteruav thread killstreaks::waitfortimecheck(30000 / 2, &ontimecheck, "delete", "death", "crashing");
    counteruav thread util::waittillendonthreaded("death", &destroycounteruav, "delete", "leaving");
    counteruav setcandamage(1);
    counteruav thread killstreaks::monitordamage("counteruav", 700, &destroycounteruav, 700 * 0.5, &onlowhealth, 0, undefined, 1);
    counteruav playloopsound("veh_uav_engine_loop", 1);
    counteruav thread listenformove();
    self killstreaks::play_killstreak_start_dialog("counteruav", self.team, killstreak_id);
    counteruav killstreaks::play_pilot_dialog_on_owner("arrive", "counteruav", killstreak_id);
    counteruav thread killstreaks::player_killstreak_threat_tracking("counteruav");
    return true;
}

// Namespace counteruav
// Params 1, eflags: 0x0
// Checksum 0x49c688b3, Offset: 0x1280
// Size: 0x2a
function hackedprefunction(hacker) {
    cuav = self;
    cuav resetactivecounteruav();
}

// Namespace counteruav
// Params 2, eflags: 0x0
// Checksum 0x1701f7cf, Offset: 0x12b8
// Size: 0x1c5
function spawncounteruav(owner, killstreak_id) {
    minflyheight = airsupport::getminimumflyheight();
    cuav = spawnvehicle("veh_counteruav_mp", airsupport::getmapcenter() + (0, 0, minflyheight + (isdefined(level.counter_uav_position_z_offset) ? level.counter_uav_position_z_offset : 1000)), (0, 0, 0), "counteruav");
    cuav assignfirstavailableoffsetindex();
    cuav killstreaks::configure_team("counteruav", killstreak_id, owner, undefined, undefined, &configureteampost);
    cuav killstreak_hacking::enable_hacking("counteruav", &hackedprefunction, undefined);
    cuav.targetname = "counteruav";
    killstreak_detect::killstreaktargetset(cuav);
    cuav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing");
    cuav.maxhealth = 700;
    cuav.health = 99999;
    cuav.rocketdamage = 700 + 1;
    cuav setdrawinfrared(1);
    if (!isdefined(level.counter_uav_entities)) {
        level.counter_uav_entities = [];
    } else if (!isarray(level.counter_uav_entities)) {
        level.counter_uav_entities = array(level.counter_uav_entities);
    }
    level.counter_uav_entities[level.counter_uav_entities.size] = cuav;
    return cuav;
}

// Namespace counteruav
// Params 2, eflags: 0x0
// Checksum 0xc0cc81be, Offset: 0x1488
// Size: 0xaa
function configureteampost(owner, ishacked) {
    cuav = self;
    if (ishacked == 0) {
        cuav teams::hidetosameteam();
    } else {
        cuav setvisibletoall();
    }
    cuav thread teams::waituntilteamchangesingleton(owner, "CUAV_watch_team_change", &onteamchange, self.entnum, "death", "leaving", "crashing");
    cuav addactivecounteruav();
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0xcbdbeb2a, Offset: 0x1540
// Size: 0x5d
function listenformove() {
    self endon(#"death");
    self endon(#"leaving");
    while (true) {
        self thread counteruavmove();
        level util::waittill_any("counter_uav_move_" + self.team, "counter_uav_move_" + self.ownerentnum);
    }
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0xbc7141ed, Offset: 0x15a8
// Size: 0x102
function counteruavmove() {
    self endon(#"death");
    self endon(#"leaving");
    level endon("counter_uav_move_" + self.team);
    destination = (0, 0, 0);
    if (level.teambased) {
        destination = self getcurrentposition(self.team);
    } else {
        destination = self getcurrentposition(self.ownerentnum);
    }
    lookangles = vectortoangles(destination - self.origin);
    rotationaccelerationduration = 0.5 * 0.2;
    rotationdecelerationduration = 0.5 * 0.2;
    travelaccelerationduration = 5 * 0.2;
    traveldecelerationduration = 5 * 0.2;
    self setvehgoalpos(destination, 1, 0);
}

// Namespace counteruav
// Params 1, eflags: 0x0
// Checksum 0x292cd334, Offset: 0x16b8
// Size: 0x3a
function playfx(name) {
    self endon(#"death");
    wait 0.1;
    if (isdefined(self)) {
        playfxontag(name, self, "tag_origin");
    }
}

// Namespace counteruav
// Params 2, eflags: 0x0
// Checksum 0x8477fe32, Offset: 0x1700
// Size: 0x62
function onlowhealth(attacker, weapon) {
    self.is_damaged = 1;
    params = level.killstreakbundle["counteruav"];
    if (isdefined(params.fxlowhealth)) {
        playfxontag(params.fxlowhealth, self, "tag_origin");
    }
}

// Namespace counteruav
// Params 2, eflags: 0x0
// Checksum 0x2f21a700, Offset: 0x1770
// Size: 0x22
function onteamchange(entnum, event) {
    destroycounteruav(undefined, undefined);
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0xdc5865a7, Offset: 0x17a0
// Size: 0x12
function onplayerjoinedteam() {
    hideallcounteruavstosameteam();
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0xb7bb5855, Offset: 0x17c0
// Size: 0x6a
function ontimeout() {
    self.leaving = 1;
    self killstreaks::play_pilot_dialog_on_owner("timeout", "counteruav");
    self airsupport::leave(5);
    wait 5;
    self removeactivecounteruav();
    target_remove(self);
    self delete();
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0xb32debda, Offset: 0x1838
// Size: 0x2a
function ontimecheck() {
    self killstreaks::play_pilot_dialog_on_owner("timecheck", "counteruav", self.killstreak_id);
}

// Namespace counteruav
// Params 2, eflags: 0x0
// Checksum 0xbef69cfe, Offset: 0x1870
// Size: 0x10a
function destroycounteruav(attacker, weapon) {
    if (self.leaving !== 1) {
        self killstreaks::play_destroyed_dialog_on_owner("counteruav", self.killstreak_id);
    }
    attacker = self [[ level.figure_out_attacker ]](attacker);
    if (!isdefined(self.owner) || isdefined(attacker) && self.owner util::isenemyplayer(attacker)) {
        scoreevents::processscoreevent("destroyed_counter_uav", attacker, self.owner, weapon);
        luinotifyevent(%player_callout, 2, %KILLSTREAK_DESTROYED_COUNTERUAV, attacker.entnum);
    }
    self playsound("evt_helicopter_midair_exp");
    self removeactivecounteruav();
    target_remove(self);
    self thread deletecounteruav();
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0x14e09913, Offset: 0x1988
// Size: 0x8a
function deletecounteruav() {
    self notify(#"crashing");
    params = level.killstreakbundle["counteruav"];
    if (isdefined(params.ksexplosionfx)) {
        self thread playfx(params.ksexplosionfx);
    }
    wait 0.1;
    self setmodel("tag_origin");
    wait 0.2;
    self notify(#"delete");
    self delete();
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0x4dddef0a, Offset: 0x1a20
// Size: 0x10a
function enemycounteruavactive() {
    if (level.teambased) {
        foreach (team in level.teams) {
            if (team == self.team) {
                continue;
            }
            if (teamhasactivecounteruav(team)) {
                return true;
            }
        }
    } else {
        enemies = self teams::getenemyplayers();
        foreach (player in enemies) {
            if (player hasactivecounteruav()) {
                return true;
            }
        }
    }
    return false;
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0x6eb21b3, Offset: 0x1b38
// Size: 0x14
function hasactivecounteruav() {
    return level.activecounteruavs[self.entnum] > 0;
}

// Namespace counteruav
// Params 1, eflags: 0x0
// Checksum 0xdb3c4fa2, Offset: 0x1b58
// Size: 0x14
function teamhasactivecounteruav(team) {
    return level.activecounteruavs[team] > 0;
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0xe7b4cc1e, Offset: 0x1b78
// Size: 0x153
function addactivecounteruav() {
    if (level.teambased) {
        level.activecounteruavs[self.team]++;
        foreach (team in level.teams) {
            if (team == self.team) {
                continue;
            }
            if (satellite::hassatellite(team)) {
                self.owner challenges::blockedsatellite();
            }
        }
    } else {
        level.activecounteruavs[self.ownerentnum]++;
        keys = getarraykeys(level.activecounteruavs);
        for (i = 0; i < keys.size; i++) {
            if (keys[i] == self.ownerentnum) {
                continue;
            }
            if (satellite::hassatellite(keys[i])) {
                self.owner challenges::blockedsatellite();
                break;
            }
        }
    }
    level.activeplayercounteruavs[self.ownerentnum]++;
    level notify(#"counter_uav_updated");
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0xdb541438, Offset: 0x1cd8
// Size: 0x4a
function removeactivecounteruav() {
    cuav = self;
    cuav resetactivecounteruav();
    cuav killstreakrules::killstreakstop("counteruav", self.originalteam, self.killstreak_id);
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0xcb54a843, Offset: 0x1d30
// Size: 0x12f
function resetactivecounteruav() {
    if (level.teambased) {
        level.activecounteruavs[self.team]--;
        assert(level.activecounteruavs[self.team] >= 0);
        if (level.activecounteruavs[self.team] < 0) {
            level.activecounteruavs[self.team] = 0;
        }
    } else if (isdefined(self.owner)) {
        assert(isdefined(self.ownerentnum));
        if (!isdefined(self.ownerentnum)) {
            self.ownerentnum = self.owner getentitynumber();
        }
        level.activecounteruavs[self.ownerentnum]--;
        assert(level.activecounteruavs[self.ownerentnum] >= 0);
        if (level.activecounteruavs[self.ownerentnum] < 0) {
            level.activecounteruavs[self.ownerentnum] = 0;
        }
    }
    level.activeplayercounteruavs[self.ownerentnum]--;
    level notify(#"counter_uav_updated");
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0x8f68e6e8, Offset: 0x1e68
// Size: 0xa7
function watchcounteruavs() {
    while (true) {
        level waittill(#"counter_uav_updated");
        foreach (player in level.players) {
            if (player enemycounteruavactive()) {
                player clientfield::set_to_player("counteruav", 1);
                continue;
            }
            player clientfield::set_to_player("counteruav", 0);
        }
    }
}

// Namespace counteruav
// Params 0, eflags: 0x0
// Checksum 0xc121925a, Offset: 0x1f18
// Size: 0x6b
function hideallcounteruavstosameteam() {
    foreach (counteruav in level.counter_uav_entities) {
        if (isdefined(counteruav)) {
            counteruav teams::hidetosameteam();
        }
    }
}

