#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/killstreaks/_emp;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/popups_shared;
#using scripts/shared/util_shared;

#namespace killstreakrules;

// Namespace killstreakrules
// Params 0, eflags: 0x0
// Checksum 0x17c77379, Offset: 0x558
// Size: 0xd2a
function init() {
    level.killstreakrules = [];
    level.killstreaktype = [];
    level.killstreaks_triggered = [];
    if (!isdefined(level.globalkillstreakscalled)) {
        level.globalkillstreakscalled = 0;
    }
    createrule("ai_tank", 4, 2);
    createrule("airsupport", 1, 1);
    createrule("combatrobot", 4, 2);
    createrule("chopper", 2, 1);
    createrule("chopperInTheAir", 2, 1);
    createrule("counteruav", 6, 3);
    createrule("dart", 4, 2);
    createrule("dogs", 1, 1);
    createrule("drone_strike", 1, 1);
    createrule("emp", 2, 1);
    createrule("firesupport", 1, 1);
    createrule("missiledrone", 3, 3);
    createrule("missileswarm", 1, 1);
    createrule("planemortar", 1, 1);
    createrule("playercontrolledchopper", 1, 1);
    createrule("qrdrone", 3, 2);
    createrule("uav", 10, 5);
    createrule("raps", 2, 1);
    createrule("rcxd", 4, 2);
    createrule("remote_missile", 2, 1);
    createrule("remotemortar", 1, 1);
    createrule("satellite", 2, 1);
    createrule("sentinel", 4, 2);
    createrule("straferun", 1, 1);
    createrule("supplydrop", 4, 4);
    createrule("targetableent", 32, 32);
    createrule("turret", 8, 4);
    createrule("vehicle", 7, 7);
    createrule("weapon", 12, 6);
    addkillstreaktorule("ai_tank_drop", "ai_tank", 1, 1);
    addkillstreaktorule("airstrike", "airsupport", 1, 1);
    addkillstreaktorule("airstrike", "vehicle", 1, 1);
    addkillstreaktorule("artillery", "firesupport", 1, 1);
    addkillstreaktorule("auto_tow", "turret", 1, 1);
    addkillstreaktorule("autoturret", "turret", 1, 1);
    addkillstreaktorule("combat_robot", "combatrobot", 1, 1);
    addkillstreaktorule("counteruav", "counteruav", 1, 1);
    addkillstreaktorule("counteruav", "targetableent", 1, 1);
    addkillstreaktorule("dart", "dart", 1, 1);
    addkillstreaktorule("dogs", "dogs", 1, 1);
    addkillstreaktorule("dogs_lvl2", "dogs", 1, 1);
    addkillstreaktorule("dogs_lvl3", "dogs", 1, 1);
    addkillstreaktorule("drone_strike", "drone_strike", 1, 1);
    addkillstreaktorule("emp", "emp", 1, 1);
    addkillstreaktorule("helicopter", "chopper", 1, 1);
    addkillstreaktorule("helicopter", "chopperInTheAir", 1, 0);
    addkillstreaktorule("helicopter", "playercontrolledchopper", 0, 1);
    addkillstreaktorule("helicopter", "targetableent", 1, 1);
    addkillstreaktorule("helicopter", "vehicle", 1, 1);
    addkillstreaktorule("helicopter_comlink", "chopper", 1, 1);
    addkillstreaktorule("helicopter_comlink", "chopperInTheAir", 1, 0);
    addkillstreaktorule("helicopter_comlink", "targetableent", 1, 1);
    addkillstreaktorule("helicopter_comlink", "vehicle", 1, 1);
    addkillstreaktorule("helicopter_guard", "airsupport", 1, 1);
    addkillstreaktorule("helicopter_gunner", "chopperInTheAir", 1, 0);
    addkillstreaktorule("helicopter_gunner", "playercontrolledchopper", 1, 1);
    addkillstreaktorule("helicopter_gunner", "targetableent", 1, 1);
    addkillstreaktorule("helicopter_gunner", "vehicle", 1, 1);
    addkillstreaktorule("helicopter_player_firstperson", "vehicle", 1, 1);
    addkillstreaktorule("helicopter_player_firstperson", "chopperInTheAir", 1, 1);
    addkillstreaktorule("helicopter_player_firstperson", "playercontrolledchopper", 1, 1);
    addkillstreaktorule("helicopter_player_firstperson", "targetableent", 1, 1);
    addkillstreaktorule("helicopter_player_gunner", "chopperInTheAir", 1, 1);
    addkillstreaktorule("helicopter_player_gunner", "playercontrolledchopper", 1, 1);
    addkillstreaktorule("helicopter_player_gunner", "targetableent", 1, 1);
    addkillstreaktorule("helicopter_player_gunner", "vehicle", 1, 1);
    addkillstreaktorule("helicopter_x2", "chopper", 1, 1);
    addkillstreaktorule("helicopter_x2", "chopperInTheAir", 1, 0);
    addkillstreaktorule("helicopter_x2", "playercontrolledchopper", 0, 1);
    addkillstreaktorule("helicopter_x2", "targetableent", 1, 1);
    addkillstreaktorule("helicopter_x2", "vehicle", 1, 1);
    addkillstreaktorule("m202_flash", "weapon", 1, 1);
    addkillstreaktorule("m220_tow", "weapon", 1, 1);
    addkillstreaktorule("m220_tow_drop", "supplydrop", 1, 1);
    addkillstreaktorule("m220_tow_drop", "vehicle", 1, 1);
    addkillstreaktorule("m220_tow_killstreak", "weapon", 1, 1);
    addkillstreaktorule("m32", "weapon", 1, 1);
    addkillstreaktorule("m32_drop", "weapon", 1, 1);
    addkillstreaktorule("microwave_turret", "turret", 1, 1);
    addkillstreaktorule("minigun", "weapon", 1, 1);
    addkillstreaktorule("minigun_drop", "weapon", 1, 1);
    addkillstreaktorule("missile_drone", "missiledrone", 1, 1);
    addkillstreaktorule("missile_swarm", "missileswarm", 1, 1);
    addkillstreaktorule("mortar", "firesupport", 1, 1);
    addkillstreaktorule("mp40_drop", "weapon", 1, 1);
    addkillstreaktorule("napalm", "airsupport", 1, 1);
    addkillstreaktorule("napalm", "vehicle", 1, 1);
    addkillstreaktorule("planemortar", "planemortar", 1, 1);
    addkillstreaktorule("qrdrone", "qrdrone", 1, 1);
    addkillstreaktorule("qrdrone", "vehicle", 1, 1);
    addkillstreaktorule("uav", "uav", 1, 1);
    addkillstreaktorule("uav", "targetableent", 1, 1);
    addkillstreaktorule("satellite", "satellite", 1, 1);
    addkillstreaktorule("raps", "raps", 1, 1);
    addkillstreaktorule("rcbomb", "rcxd", 1, 1);
    addkillstreaktorule("remote_missile", "targetableent", 1, 1);
    addkillstreaktorule("remote_missile", "remote_missile", 1, 1);
    addkillstreaktorule("remote_mortar", "remotemortar", 1, 1);
    addkillstreaktorule("remote_mortar", "targetableent", 1, 1);
    addkillstreaktorule("sentinel", "sentinel", 1, 1);
    addkillstreaktorule("straferun", "straferun", 1, 1);
    addkillstreaktorule("supply_drop", "supplydrop", 1, 1);
    addkillstreaktorule("supply_drop", "targetableent", 1, 1);
    addkillstreaktorule("supply_drop", "vehicle", 1, 1);
    addkillstreaktorule("supply_station", "supplydrop", 1, 1);
    addkillstreaktorule("supply_station", "targetableent", 1, 1);
    addkillstreaktorule("supply_station", "vehicle", 1, 1);
    addkillstreaktorule("tow_turret_drop", "supplydrop", 1, 1);
    addkillstreaktorule("tow_turret_drop", "vehicle", 1, 1);
    addkillstreaktorule("turret_drop", "supplydrop", 1, 1);
    addkillstreaktorule("turret_drop", "vehicle", 1, 1);
}

// Namespace killstreakrules
// Params 3, eflags: 0x0
// Checksum 0x6c5fcb3d, Offset: 0x1290
// Size: 0x82
function createrule(rule, maxallowable, maxallowableperteam) {
    level.killstreakrules[rule] = spawnstruct();
    level.killstreakrules[rule].cur = 0;
    level.killstreakrules[rule].curteam = [];
    level.killstreakrules[rule].max = maxallowable;
    level.killstreakrules[rule].maxperteam = maxallowableperteam;
}

// Namespace killstreakrules
// Params 5, eflags: 0x0
// Checksum 0xcc55b8d1, Offset: 0x1320
// Size: 0x10a
function addkillstreaktorule(killstreak, rule, counttowards, checkagainst, inventoryvariant) {
    if (!isdefined(level.killstreaktype[killstreak])) {
        level.killstreaktype[killstreak] = [];
    }
    keys = getarraykeys(level.killstreaktype[killstreak]);
    assert(isdefined(level.killstreakrules[rule]));
    if (!isdefined(level.killstreaktype[killstreak][rule])) {
        level.killstreaktype[killstreak][rule] = spawnstruct();
    }
    level.killstreaktype[killstreak][rule].counts = counttowards;
    level.killstreaktype[killstreak][rule].checks = checkagainst;
    if (!(isdefined(inventoryvariant) && inventoryvariant)) {
        addkillstreaktorule("inventory_" + killstreak, rule, counttowards, checkagainst, 1);
    }
}

// Namespace killstreakrules
// Params 4, eflags: 0x0
// Checksum 0xef674dd7, Offset: 0x1438
// Size: 0x29c
function killstreakstart(hardpointtype, team, hacked, displayteammessage) {
    assert(isdefined(team), "<dev string:x28>");
    if (self iskillstreakallowed(hardpointtype, team) == 0) {
        return -1;
    }
    assert(isdefined(hardpointtype));
    if (!isdefined(hacked)) {
        hacked = 0;
    }
    if (!isdefined(displayteammessage)) {
        displayteammessage = 1;
    }
    if (getdvarint("teamOpsEnabled") == 1) {
        displayteammessage = 0;
    }
    if (displayteammessage == 1) {
        if (!hacked) {
            self displaykillstreakstartteammessagetoall(hardpointtype);
        }
    }
    keys = getarraykeys(level.killstreaktype[hardpointtype]);
    foreach (key in keys) {
        if (!level.killstreaktype[hardpointtype][key].counts) {
            continue;
        }
        assert(isdefined(level.killstreakrules[key]));
        level.killstreakrules[key].cur++;
        if (level.teambased) {
            if (!isdefined(level.killstreakrules[key].curteam[team])) {
                level.killstreakrules[key].curteam[team] = 0;
            }
            level.killstreakrules[key].curteam[team]++;
        }
    }
    level notify(#"killstreak_started", hardpointtype, team, self);
    killstreak_id = level.globalkillstreakscalled;
    level.globalkillstreakscalled++;
    killstreak_data = [];
    killstreak_data["caller"] = self getxuid();
    killstreak_data["spawnid"] = getplayerspawnid(self);
    killstreak_data["starttime"] = gettime();
    killstreak_data["type"] = hardpointtype;
    killstreak_data["endtime"] = 0;
    level.killstreaks_triggered[killstreak_id] = killstreak_data;
    /#
        killstreak_debug_text("<dev string:x41>" + hardpointtype + "<dev string:x56>" + team + "<dev string:x62>" + killstreak_id);
    #/
    return killstreak_id;
}

// Namespace killstreakrules
// Params 1, eflags: 0x0
// Checksum 0x67eab0d6, Offset: 0x16e0
// Size: 0x62
function displaykillstreakstartteammessagetoall(hardpointtype) {
    if (getdvarint("teamOpsEnabled") == 1) {
        return;
    }
    if (isdefined(level.killstreaks[hardpointtype]) && isdefined(level.killstreaks[hardpointtype].inboundtext)) {
        level thread popups::displaykillstreakteammessagetoall(hardpointtype, self);
    }
}

// Namespace killstreakrules
// Params 3, eflags: 0x0
// Checksum 0x6651a791, Offset: 0x1750
// Size: 0x362
function killstreakstop(hardpointtype, team, id) {
    assert(isdefined(team), "<dev string:x28>");
    assert(isdefined(hardpointtype));
    /#
        idstr = "<dev string:x68>";
        if (isdefined(id)) {
            idstr = id;
        }
        killstreak_debug_text("<dev string:x72>" + hardpointtype + "<dev string:x56>" + team + "<dev string:x62>" + idstr);
    #/
    keys = getarraykeys(level.killstreaktype[hardpointtype]);
    foreach (key in keys) {
        if (!level.killstreaktype[hardpointtype][key].counts) {
            continue;
        }
        assert(isdefined(level.killstreakrules[key]));
        level.killstreakrules[key].cur--;
        assert(level.killstreakrules[key].cur >= 0);
        if (level.teambased) {
            assert(isdefined(team));
            assert(isdefined(level.killstreakrules[key].curteam[team]));
            level.killstreakrules[key].curteam[team]--;
            assert(level.killstreakrules[key].curteam[team] >= 0);
        }
    }
    if (!isdefined(id) || id == -1) {
        killstreak_debug_text("WARNING! Invalid killstreak id detected for " + hardpointtype);
        bbprint("mpkillstreakuses", "starttime %d endtime %d name %s team %s", 0, gettime(), hardpointtype, team);
        return;
    }
    level.killstreaks_triggered[id]["endtime"] = gettime();
    bbprint("mpkillstreakuses", "starttime %d endtime %d spawnid %d name %s team %s", level.killstreaks_triggered[id]["starttime"], level.killstreaks_triggered[id]["endtime"], level.killstreaks_triggered[id]["spawnid"], hardpointtype, team);
    level.killstreaks_triggered[id] = undefined;
    if (isdefined(level.killstreaks[hardpointtype].menuname)) {
        recordstreakindex = level.killstreakindices[level.killstreaks[hardpointtype].menuname];
        if (!isdefined(self.activatingkillstreak) || isdefined(self) && isdefined(recordstreakindex) && !self.activatingkillstreak) {
            if (isdefined(self.owner)) {
                self.owner recordkillstreakendevent(recordstreakindex);
                return;
            }
            if (isplayer(self)) {
                self recordkillstreakendevent(recordstreakindex);
            }
        }
    }
}

// Namespace killstreakrules
// Params 2, eflags: 0x0
// Checksum 0xa8b72931, Offset: 0x1ac0
// Size: 0x35c
function iskillstreakallowed(hardpointtype, team) {
    assert(isdefined(team), "<dev string:x28>");
    assert(isdefined(hardpointtype));
    isallowed = 1;
    keys = getarraykeys(level.killstreaktype[hardpointtype]);
    foreach (key in keys) {
        if (!level.killstreaktype[hardpointtype][key].checks) {
            continue;
        }
        if (level.killstreakrules[key].max != 0) {
            if (level.killstreakrules[key].cur >= level.killstreakrules[key].max) {
                /#
                    killstreak_debug_text("<dev string:x87>" + key + "<dev string:x91>");
                #/
                isallowed = 0;
                break;
            }
        }
        if (level.teambased && level.killstreakrules[key].maxperteam != 0) {
            if (!isdefined(level.killstreakrules[key].curteam[team])) {
                level.killstreakrules[key].curteam[team] = 0;
            }
            if (level.killstreakrules[key].curteam[team] >= level.killstreakrules[key].maxperteam) {
                isallowed = 0;
                /#
                    killstreak_debug_text("<dev string:x87>" + key + "<dev string:x9a>");
                #/
                break;
            }
        }
    }
    if (isdefined(self.laststand) && self.laststand) {
        /#
            killstreak_debug_text("<dev string:xa0>");
        #/
        isallowed = 0;
    }
    isemped = 0;
    if (self isempjammed()) {
        /#
            killstreak_debug_text("<dev string:xad>");
        #/
        isallowed = 0;
        isemped = 1;
        if (self emp::enemyempactive()) {
            if (isdefined(level.empendtime)) {
                secondsleft = int((level.empendtime - gettime()) / 1000);
                if (secondsleft > 0) {
                    self iprintlnbold(%KILLSTREAK_NOT_AVAILABLE_EMP_ACTIVE, secondsleft);
                    return 0;
                }
            }
        }
    }
    if (isallowed == 0) {
        if (isdefined(level.killstreaks[hardpointtype]) && isdefined(level.killstreaks[hardpointtype].notavailabletext)) {
            self iprintlnbold(level.killstreaks[hardpointtype].notavailabletext);
            if (!isdefined(self.currentkillstreakdialog) && level.killstreaks[hardpointtype].utilizesairspace && isemped == 0) {
                self globallogic_audio::play_taacom_dialog("airspaceFull");
            }
        }
    }
    return isallowed;
}

// Namespace killstreakrules
// Params 1, eflags: 0x0
// Checksum 0x2e8e1eb7, Offset: 0x1e28
// Size: 0x9a
function killstreak_debug_text(text) {
    /#
        level.killstreak_rule_debug = getdvarint("<dev string:xb8>", 0);
        if (isdefined(level.killstreak_rule_debug)) {
            if (level.killstreak_rule_debug == 1) {
                iprintln("<dev string:xd2>" + text + "<dev string:xd8>");
                return;
            }
            if (level.killstreak_rule_debug == 2) {
                iprintlnbold("<dev string:xd2>" + text);
            }
        }
    #/
}

