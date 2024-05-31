#using scripts/mp/_util;
#using scripts/codescripts/struct;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/music_shared;
#using scripts/shared/callbacks_shared;

#namespace globallogic_audio;

// Namespace globallogic_audio
// Params 0, eflags: 0x2
// namespace_51c2821<file_0>::function_2dc19561
// Checksum 0xa58ecddf, Offset: 0xe48
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("globallogic_audio", &__init__, undefined, undefined);
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_8c87d8eb
// Checksum 0xc546eb34, Offset: 0xe88
// Size: 0x6c
function __init__() {
    callback::on_start_gametype(&init);
    level.playleaderdialogonplayer = &leader_dialog_on_player;
    level.playequipmentdestroyedonplayer = &play_equipment_destroyed_on_player;
    level.playequipmenthackedonplayer = &play_equipment_hacked_on_player;
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_c35e6aab
// Checksum 0x1fdb921e, Offset: 0xf00
// Size: 0x626
function init() {
    game["music"]["defeat"] = "mus_defeat";
    game["music"]["victory_spectator"] = "mus_defeat";
    game["music"]["winning"] = "mus_time_running_out_winning";
    game["music"]["losing"] = "mus_time_running_out_losing";
    game["music"]["match_end"] = "mus_match_end";
    game["music"]["victory_tie"] = "mus_defeat";
    game["music"]["spawn_short"] = "SPAWN_SHORT";
    game["music"]["suspense"] = [];
    game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_01";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_02";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_03";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_04";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_05";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_06";
    level thread function_de3b188d();
    level.multipledialogkeys = [];
    level.multipledialogkeys["enemyAiTank"] = "enemyAiTankMultiple";
    level.multipledialogkeys["enemySupplyDrop"] = "enemySupplyDropMultiple";
    level.multipledialogkeys["enemyCombatRobot"] = "enemyCombatRobotMultiple";
    level.multipledialogkeys["enemyCounterUav"] = "enemyCounterUavMultiple";
    level.multipledialogkeys["enemyDart"] = "enemyDartMultiple";
    level.multipledialogkeys["enemyEmp"] = "enemyEmpMultiple";
    level.multipledialogkeys["enemySentinel"] = "enemySentinelMultiple";
    level.multipledialogkeys["enemyMicrowaveTurret"] = "enemyMicrowaveTurretMultiple";
    level.multipledialogkeys["enemyRcBomb"] = "enemyRcBombMultiple";
    level.multipledialogkeys["enemyPlaneMortar"] = "enemyPlaneMortarMultiple";
    level.multipledialogkeys["enemyHelicopterGunner"] = "enemyHelicopterGunnerMultiple";
    level.multipledialogkeys["enemyRaps"] = "enemyRapsMultiple";
    level.multipledialogkeys["enemyDroneStrike"] = "enemyDroneStrikeMultiple";
    level.multipledialogkeys["enemyTurret"] = "enemyTurretMultiple";
    level.multipledialogkeys["enemyHelicopter"] = "enemyHelicopterMultiple";
    level.multipledialogkeys["enemyUav"] = "enemyUavMultiple";
    level.multipledialogkeys["enemySatellite"] = "enemySatelliteMultiple";
    level.multipledialogkeys["friendlyAiTank"] = "";
    level.multipledialogkeys["friendlySupplyDrop"] = "";
    level.multipledialogkeys["friendlyCombatRobot"] = "";
    level.multipledialogkeys["friendlyCounterUav"] = "";
    level.multipledialogkeys["friendlyDart"] = "";
    level.multipledialogkeys["friendlyEmp"] = "";
    level.multipledialogkeys["friendlySentinel"] = "";
    level.multipledialogkeys["friendlyMicrowaveTurret"] = "";
    level.multipledialogkeys["friendlyRcBomb"] = "";
    level.multipledialogkeys["friendlyPlaneMortar"] = "";
    level.multipledialogkeys["friendlyHelicopterGunner"] = "";
    level.multipledialogkeys["friendlyRaps"] = "";
    level.multipledialogkeys["friendlyDroneStrike"] = "";
    level.multipledialogkeys["friendlyTurret"] = "";
    level.multipledialogkeys["friendlyHelicopter"] = "";
    level.multipledialogkeys["friendlyUav"] = "";
    level.multipledialogkeys["friendlySatellite"] = "";
}

// Namespace globallogic_audio
// Params 4, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_d69e004d
// Checksum 0x7421e2e7, Offset: 0x1530
// Size: 0x8c
function set_leader_gametype_dialog(startgamedialogkey, starthcgamedialogkey, offenseorderdialogkey, defenseorderdialogkey) {
    level.leaderdialog = spawnstruct();
    level.leaderdialog.startgamedialog = startgamedialogkey;
    level.leaderdialog.starthcgamedialog = starthcgamedialogkey;
    level.leaderdialog.offenseorderdialog = offenseorderdialogkey;
    level.leaderdialog.defenseorderdialog = defenseorderdialogkey;
}

// Namespace globallogic_audio
// Params 2, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_f17bbc69
// Checksum 0xc8af3cbe, Offset: 0x15c8
// Size: 0x15c
function announce_round_winner(winner, delay) {
    if (delay > 0) {
        wait(delay);
    }
    if (!isdefined(winner) || isplayer(winner)) {
        return;
    }
    if (isdefined(level.teams[winner])) {
        leader_dialog("roundEncourageWon", winner);
        leader_dialog_for_other_teams("roundEncourageLost", winner);
        return;
    }
    foreach (team in level.teams) {
        thread sound::play_on_players("mus_round_draw" + "_" + level.teampostfix[team]);
    }
    leader_dialog("roundDraw");
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_c42ec33d
// Checksum 0xc81b234a, Offset: 0x1730
// Size: 0xe4
function announce_game_winner(winner) {
    if (level.gametype == "fr") {
        return;
    }
    wait(battlechatter::mpdialog_value("announceWinnerDelay", 0));
    if (level.teambased) {
        if (isdefined(level.teams[winner])) {
            leader_dialog("gameWon", winner);
            leader_dialog_for_other_teams("gameLost", winner);
        } else {
            leader_dialog("gameDraw");
        }
        wait(battlechatter::mpdialog_value("commanderDialogBuffer", 0));
    }
    battlechatter::game_end_vox(winner);
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_499d49cc
// Checksum 0xd76acfb, Offset: 0x1820
// Size: 0x8a
function flush_dialog() {
    foreach (player in level.players) {
        player flush_dialog_on_player();
    }
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_3307917c
// Checksum 0xbcba1446, Offset: 0x18b8
// Size: 0x3e
function flush_dialog_on_player() {
    self.leaderdialogqueue = [];
    self.currentleaderdialog = undefined;
    self.killstreakdialogqueue = [];
    self.scorestreakdialogplaying = 0;
    self notify(#"flush_dialog");
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_40698ab9
// Checksum 0x1a72bfe4, Offset: 0x1900
// Size: 0x86
function flush_killstreak_dialog_on_player(killstreakid) {
    if (!isdefined(killstreakid)) {
        return;
    }
    for (i = self.killstreakdialogqueue.size - 1; i >= 0; i--) {
        if (killstreakid === self.killstreakdialogqueue[i].killstreakid) {
            arrayremoveindex(self.killstreakdialogqueue, i);
        }
    }
}

// Namespace globallogic_audio
// Params 3, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_f278076a
// Checksum 0xf3844771, Offset: 0x1990
// Size: 0x12a
function killstreak_dialog_queued(dialogkey, killstreaktype, killstreakid) {
    if (!isdefined(dialogkey) || !isdefined(killstreaktype)) {
        return;
    }
    if (isdefined(self.currentkillstreakdialog)) {
        if (dialogkey === self.currentkillstreakdialog.dialogkey && killstreaktype === self.currentkillstreakdialog.killstreaktype && killstreakid === self.currentkillstreakdialog.killstreakid) {
            return 1;
        }
    }
    for (i = 0; i < self.killstreakdialogqueue.size; i++) {
        if (dialogkey === self.killstreakdialogqueue[i].dialogkey && killstreaktype === self.killstreakdialogqueue[i].killstreaktype && killstreaktype === self.killstreakdialogqueue[i].killstreaktype) {
            return 1;
        }
    }
    return 0;
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_78c468d8
// Checksum 0x76e2accc, Offset: 0x1ac8
// Size: 0x9a
function flush_objective_dialog(objectivekey) {
    foreach (player in level.players) {
        player flush_objective_dialog_on_player(objectivekey);
    }
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_b8957db8
// Checksum 0xeaf61304, Offset: 0x1b70
// Size: 0x8a
function flush_objective_dialog_on_player(objectivekey) {
    if (!isdefined(objectivekey)) {
        return;
    }
    for (i = self.leaderdialogqueue.size - 1; i >= 0; i--) {
        if (objectivekey === self.leaderdialogqueue[i].objectivekey) {
            arrayremoveindex(self.leaderdialogqueue, i);
            break;
        }
    }
}

// Namespace globallogic_audio
// Params 1, eflags: 0x0
// namespace_51c2821<file_0>::function_3b9c1d1e
// Checksum 0xa6b7227d, Offset: 0x1c08
// Size: 0x9a
function flush_leader_dialog_key(dialogkey) {
    foreach (player in level.players) {
        player flush_leader_dialog_key_on_player(dialogkey);
    }
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_9ed3224a
// Checksum 0x8be31f6a, Offset: 0x1cb0
// Size: 0x86
function flush_leader_dialog_key_on_player(dialogkey) {
    if (!isdefined(dialogkey)) {
        return;
    }
    for (i = self.leaderdialogqueue.size - 1; i >= 0; i--) {
        if (dialogkey === self.leaderdialogqueue[i].dialogkey) {
            arrayremoveindex(self.leaderdialogqueue, i);
        }
    }
}

// Namespace globallogic_audio
// Params 3, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_5f3253ee
// Checksum 0x5e8b6b53, Offset: 0x1d40
// Size: 0x3c
function play_taacom_dialog(dialogkey, killstreaktype, killstreakid) {
    self killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid);
}

// Namespace globallogic_audio
// Params 4, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_5c2c87a2
// Checksum 0xf753a175, Offset: 0x1d88
// Size: 0x144
function killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, pilotindex) {
    if (!isdefined(dialogkey)) {
        return;
    }
    if (!level.allowannouncer) {
        return;
    }
    if (level.gameended) {
        return;
    }
    newdialog = spawnstruct();
    newdialog.dialogkey = dialogkey;
    newdialog.killstreaktype = killstreaktype;
    newdialog.pilotindex = pilotindex;
    newdialog.killstreakid = killstreakid;
    self.killstreakdialogqueue[self.killstreakdialogqueue.size] = newdialog;
    if (self.killstreakdialogqueue.size > 1 || isdefined(self.currentkillstreakdialog)) {
        return;
    }
    if (self.playingdialog === 1 && dialogkey == "arrive") {
        self thread wait_for_player_dialog();
        return;
    }
    self thread play_next_killstreak_dialog();
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_f1f65569
// Checksum 0x92fb6809, Offset: 0x1ed8
// Size: 0x54
function wait_for_player_dialog() {
    self endon(#"disconnect");
    self endon(#"flush_dialog");
    level endon(#"game_ended");
    while (self.playingdialog) {
        wait(0.5);
    }
    self thread play_next_killstreak_dialog();
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_1b35866d
// Checksum 0x7cd278d5, Offset: 0x1f38
// Size: 0x304
function play_next_killstreak_dialog() {
    self endon(#"disconnect");
    self endon(#"flush_dialog");
    level endon(#"game_ended");
    if (self.killstreakdialogqueue.size == 0) {
        self.currentkillstreakdialog = undefined;
        return;
    }
    nextdialog = self.killstreakdialogqueue[0];
    arrayremoveindex(self.killstreakdialogqueue, 0);
    if (isdefined(self.pers["mptaacom"])) {
        taacombundle = struct::get_script_bundle("mpdialog_taacom", self.pers["mptaacom"]);
    }
    if (isdefined(taacombundle)) {
        if (isdefined(nextdialog.killstreaktype)) {
            if (isdefined(nextdialog.pilotindex)) {
                pilotarray = taacombundle.pilotbundles[nextdialog.killstreaktype];
                if (isdefined(pilotarray) && nextdialog.pilotindex < pilotarray.size) {
                    killstreakbundle = struct::get_script_bundle("mpdialog_scorestreak", pilotarray[nextdialog.pilotindex]);
                    if (isdefined(killstreakbundle)) {
                        dialogalias = get_dialog_bundle_alias(killstreakbundle, nextdialog.dialogkey);
                    }
                }
            } else if (isdefined(level.killstreaks[nextdialog.killstreaktype])) {
                bundlename = function_e8ef6cb0(taacombundle, level.killstreaks[nextdialog.killstreaktype].taacomdialogbundlekey);
                if (isdefined(bundlename)) {
                    killstreakbundle = struct::get_script_bundle("mpdialog_scorestreak", bundlename);
                    if (isdefined(killstreakbundle)) {
                        dialogalias = self get_dialog_bundle_alias(killstreakbundle, nextdialog.dialogkey);
                    }
                }
            }
        } else {
            dialogalias = self get_dialog_bundle_alias(taacombundle, nextdialog.dialogkey);
        }
    }
    if (!isdefined(dialogalias)) {
        self play_next_killstreak_dialog();
        return;
    }
    self playlocalsound(dialogalias);
    self.currentkillstreakdialog = nextdialog;
    self thread wait_next_killstreak_dialog();
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_8acabe7e
// Checksum 0xcffad76f, Offset: 0x2248
// Size: 0x5c
function wait_next_killstreak_dialog() {
    self endon(#"disconnect");
    self endon(#"flush_dialog");
    level endon(#"game_ended");
    wait(battlechatter::mpdialog_value("killstreakDialogBuffer", 0));
    self thread play_next_killstreak_dialog();
}

// Namespace globallogic_audio
// Params 5, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_4dec8459
// Checksum 0xc77d166f, Offset: 0x22b0
// Size: 0xf2
function leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey) {
    assert(isdefined(skipteam));
    foreach (team in level.teams) {
        if (team != skipteam) {
            leader_dialog(dialogkey, team, undefined, objectivekey, killstreakid, dialogbufferkey);
        }
    }
}

// Namespace globallogic_audio
// Params 6, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_b997c521
// Checksum 0x33766107, Offset: 0x23b0
// Size: 0x162
function leader_dialog(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey) {
    assert(isdefined(level.players));
    foreach (player in level.players) {
        if (!isdefined(player.pers["team"])) {
            continue;
        }
        if (isdefined(team) && team != player.pers["team"]) {
            continue;
        }
        if (isdefined(excludelist) && globallogic_utils::isexcluded(player, excludelist)) {
            continue;
        }
        player leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey);
    }
}

// Namespace globallogic_audio
// Params 5, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_5a6c4285
// Checksum 0xdaf251b3, Offset: 0x2520
// Size: 0x3e4
function leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey, introdialog) {
    if (!isdefined(dialogkey)) {
        return;
    }
    if (!level.allowannouncer) {
        return;
    }
    if (!(isdefined(self.playleaderdialog) && self.playleaderdialog) && !(isdefined(introdialog) && introdialog)) {
        return;
    }
    self flush_objective_dialog_on_player(objectivekey);
    if (self.leaderdialogqueue.size == 0 && isdefined(self.currentleaderdialog) && isdefined(objectivekey) && self.currentleaderdialog.objectivekey === objectivekey && self.currentleaderdialog.dialogkey == dialogkey) {
        return;
    }
    if (isdefined(killstreakid)) {
        foreach (item in self.leaderdialogqueue) {
            if (item.dialogkey == dialogkey) {
                item.killstreakids[item.killstreakids.size] = killstreakid;
                return;
            }
        }
        if (self.leaderdialogqueue.size == 0 && isdefined(self.currentleaderdialog) && self.currentleaderdialog.dialogkey == dialogkey) {
            if (self.currentleaderdialog.playmultiple === 1) {
                return;
            }
            playmultiple = 1;
        }
    }
    newitem = spawnstruct();
    newitem.priority = dialogkey_priority(dialogkey);
    newitem.dialogkey = dialogkey;
    newitem.multipledialogkey = level.multipledialogkeys[dialogkey];
    newitem.playmultiple = playmultiple;
    newitem.objectivekey = objectivekey;
    if (isdefined(killstreakid)) {
        newitem.killstreakids = [];
        newitem.killstreakids[0] = killstreakid;
    }
    newitem.dialogbufferkey = dialogbufferkey;
    iteminserted = 0;
    if (isdefined(newitem.priority)) {
        for (i = 0; i < self.leaderdialogqueue.size; i++) {
            if (isdefined(self.leaderdialogqueue[i].priority) && self.leaderdialogqueue[i].priority <= newitem.priority) {
                continue;
            }
            arrayinsert(self.leaderdialogqueue, newitem, i);
            iteminserted = 1;
            break;
        }
    }
    if (!iteminserted) {
        self.leaderdialogqueue[self.leaderdialogqueue.size] = newitem;
    }
    if (isdefined(self.currentleaderdialog)) {
        return;
    }
    self thread play_next_leader_dialog();
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_13bc2102
// Checksum 0x525fa7db, Offset: 0x2910
// Size: 0x28c
function play_next_leader_dialog() {
    self endon(#"disconnect");
    self endon(#"flush_dialog");
    level endon(#"game_ended");
    if (self.leaderdialogqueue.size == 0) {
        self.currentleaderdialog = undefined;
        return;
    }
    nextdialog = self.leaderdialogqueue[0];
    arrayremoveindex(self.leaderdialogqueue, 0);
    dialogkey = nextdialog.dialogkey;
    if (isdefined(nextdialog.killstreakids)) {
        triggeredcount = 0;
        foreach (killstreakid in nextdialog.killstreakids) {
            if (isdefined(level.killstreaks_triggered[killstreakid])) {
                triggeredcount++;
            }
        }
        if (triggeredcount == 0) {
            self thread play_next_leader_dialog();
            return;
        } else if (triggeredcount > 1 || nextdialog.playmultiple === 1) {
            if (isdefined(level.multipledialogkeys[dialogkey])) {
                dialogkey = level.multipledialogkeys[dialogkey];
            }
        }
    }
    dialogalias = self get_commander_dialog_alias(dialogkey);
    if (!isdefined(dialogalias)) {
        self thread play_next_leader_dialog();
        return;
    }
    self playlocalsound(dialogalias);
    nextdialog.playtime = gettime();
    self.currentleaderdialog = nextdialog;
    dialogbuffer = battlechatter::mpdialog_value(nextdialog.dialogbufferkey, battlechatter::mpdialog_value("commanderDialogBuffer", 0));
    self thread wait_next_leader_dialog(dialogbuffer);
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_f8a52749
// Checksum 0x57a715dc, Offset: 0x2ba8
// Size: 0x4c
function wait_next_leader_dialog(dialogbuffer) {
    self endon(#"disconnect");
    self endon(#"flush_dialog");
    level endon(#"game_ended");
    wait(dialogbuffer);
    self thread play_next_leader_dialog();
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_f234a17d
// Checksum 0xd9737698, Offset: 0x2c00
// Size: 0x378
function dialogkey_priority(dialogkey) {
    switch (dialogkey) {
    case 43:
    case 38:
    case 37:
    case 120:
    case 121:
    case 22:
    case 21:
    case 26:
    case 25:
    case 30:
    case 29:
    case 46:
    case 45:
    case 34:
    case 50:
    case 42:
    case 41:
    case 49:
    case 36:
    case 35:
    case 40:
    case 39:
    case 119:
    case 44:
    case 33:
    case 48:
    case 47:
        return 1;
    case 122:
    case 123:
    case 124:
    case 125:
    case 138:
    case 139:
    case 140:
    case 141:
        return 1;
    case 101:
    case 102:
    case 104:
    case 105:
    case 106:
    case 107:
    case 108:
    case 109:
    case 110:
    case 111:
    case 112:
    case 113:
    case 114:
    case 115:
    case 116:
    case 117:
    case 118:
    case 103:
    case 90:
    case 91:
    case 92:
    case 93:
    case 94:
    case 95:
    case 96:
    case 126:
    case 127:
    case 128:
    case 129:
    case 130:
    case 131:
    case 132:
    case 133:
    case 134:
    case 135:
    case 136:
    case 137:
    case 97:
    case 98:
    case 99:
    case 100:
    case 142:
    case 143:
    case 144:
    case 145:
    case 146:
    case 147:
    case 148:
    case 149:
    case 150:
    case 151:
    case 152:
    case 153:
    case 154:
    case 155:
    case 156:
    case 157:
    case 158:
    case 159:
    case 160:
    case 161:
    case 162:
    case 163:
    case 164:
    case 165:
    case 166:
    case 167:
    case 168:
    case 169:
    case 170:
        return 1;
    }
    return undefined;
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_d0c1f3ea
// Checksum 0x37f2749, Offset: 0x2f80
// Size: 0x24
function play_equipment_destroyed_on_player() {
    self play_taacom_dialog("equipmentDestroyed");
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_4bd6be09
// Checksum 0x44094fd0, Offset: 0x2fb0
// Size: 0x24
function play_equipment_hacked_on_player() {
    self play_taacom_dialog("equipmentHacked");
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_c3e705b2
// Checksum 0x3282de6a, Offset: 0x2fe0
// Size: 0x72
function get_commander_dialog_alias(dialogkey) {
    if (!isdefined(self.pers["mpcommander"])) {
        return undefined;
    }
    commanderbundle = struct::get_script_bundle("mpdialog_commander", self.pers["mpcommander"]);
    return get_dialog_bundle_alias(commanderbundle, dialogkey);
}

// Namespace globallogic_audio
// Params 2, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_f08025d4
// Checksum 0xcbe5f1e5, Offset: 0x3060
// Size: 0xae
function get_dialog_bundle_alias(dialogbundle, dialogkey) {
    if (!isdefined(dialogbundle) || !isdefined(dialogkey)) {
        return undefined;
    }
    dialogalias = function_e8ef6cb0(dialogbundle, dialogkey);
    if (!isdefined(dialogalias)) {
        return;
    }
    voiceprefix = function_e8ef6cb0(dialogbundle, "voiceprefix");
    if (isdefined(voiceprefix)) {
        dialogalias = voiceprefix + dialogalias;
    }
    return dialogalias;
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_5d25078a
// Checksum 0xb6e7fc6d, Offset: 0x3118
// Size: 0xcc
function is_team_winning(checkteam) {
    score = game["teamScores"][checkteam];
    foreach (team in level.teams) {
        if (team != checkteam) {
            if (game["teamScores"][team] >= score) {
                return false;
            }
        }
    }
    return true;
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_d2725de6
// Checksum 0x1ff6987d, Offset: 0x31f0
// Size: 0xd2
function announce_team_is_winning() {
    foreach (team in level.teams) {
        if (is_team_winning(team)) {
            leader_dialog("gameWinning", team);
            leader_dialog_for_other_teams("gameLosing", team);
            return true;
        }
    }
    return false;
}

// Namespace globallogic_audio
// Params 2, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_ea1beeac
// Checksum 0x704c33fc, Offset: 0x32d0
// Size: 0xd6
function play_2d_on_team(alias, team) {
    assert(isdefined(level.players));
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (isdefined(player.pers["team"]) && player.pers["team"] == team) {
            player playlocalsound(alias);
        }
    }
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_3325e398
// Checksum 0xe005dd49, Offset: 0x33b0
// Size: 0x2e
function get_round_switch_dialog(switchtype) {
    switch (switchtype) {
    case 180:
        return "roundHalftime";
    case 181:
        return "roundOvertime";
    default:
        return "roundSwitchSides";
    }
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_de3b188d
// Checksum 0xc546cbe2, Offset: 0x3408
// Size: 0x54
function function_de3b188d() {
    level waittill(#"game_ended");
    level util::clientnotify("pm");
    level waittill(#"sfade");
    level util::clientnotify("pmf");
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_511e50ba
// Checksum 0x761a06b, Offset: 0x3468
// Size: 0x144
function announcercontroller() {
    level endon(#"game_ended");
    level waittill(#"match_ending_soon");
    if (util::islastround() || util::isoneround()) {
        if (level.teambased) {
            if (!announce_team_is_winning()) {
                leader_dialog("min_draw");
            }
        }
        level waittill(#"match_ending_very_soon");
        foreach (team in level.teams) {
            leader_dialog("roundTimeWarning", team, undefined, undefined);
        }
        return;
    }
    level waittill(#"match_ending_vox");
    leader_dialog("roundTimeWarning");
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_c6f212a
// Checksum 0x945d7420, Offset: 0x35b8
// Size: 0x64
function sndmusicfunctions() {
    level thread sndmusictimesout();
    level thread sndmusichalfway();
    level thread sndmusictimelimitwatcher();
    level thread sndmusicunlock();
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_a8967e04
// Checksum 0x60d153c0, Offset: 0x3628
// Size: 0xc0
function sndmusicsetrandomizer() {
    if (game["roundsplayed"] == 0) {
        game["musicSet"] = randomintrange(1, 8);
        if (game["musicSet"] <= 9) {
            game["musicSet"] = "0" + game["musicSet"];
        }
        game["musicSet"] = "_" + game["musicSet"];
        if (isdefined(level.freerun) && level.freerun) {
            game["musicSet"] = "";
        }
    }
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_25145caf
// Checksum 0x103c6085, Offset: 0x36f0
// Size: 0xd4
function sndmusicunlock() {
    level waittill(#"game_ended");
    unlockname = undefined;
    switch (game["musicSet"]) {
    case 194:
        unlockname = "mus_dystopia_intro";
        break;
    case 195:
        unlockname = "mus_filter_intro";
        break;
    case 196:
        unlockname = "mus_immersion_intro";
        break;
    case 197:
        unlockname = "mus_ruin_intro";
        break;
    case 198:
        unlockname = "mus_cod_bites_intro";
        break;
    }
    if (isdefined(unlockname)) {
        level thread audio::unlockfrontendmusic(unlockname);
    }
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_bbaa609d
// Checksum 0xdda97620, Offset: 0x37d0
// Size: 0x9c
function sndmusictimesout() {
    level endon(#"game_ended");
    level endon(#"musicendingoverride");
    level waittill(#"match_ending_very_soon");
    if (level.gametype == "sd" || isdefined(level.gametype) && level.gametype == "prop") {
        level thread set_music_on_team("timeOutQuiet");
        return;
    }
    level thread set_music_on_team("timeOut");
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_b3b69de9
// Checksum 0xd4b3dec, Offset: 0x3878
// Size: 0x54
function sndmusichalfway() {
    level endon(#"game_ended");
    level endon(#"match_ending_soon");
    level endon(#"match_ending_very_soon");
    level waittill(#"sndmusichalfway");
    level thread set_music_on_team("underscore");
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_5e99e3fb
// Checksum 0x6f256b8c, Offset: 0x38d8
// Size: 0xce
function sndmusictimelimitwatcher() {
    level endon(#"game_ended");
    level endon(#"match_ending_soon");
    level endon(#"match_ending_very_soon");
    level endon(#"sndmusichalfway");
    if (!isdefined(level.timelimit) || level.timelimit == 0) {
        return;
    }
    halfway = level.timelimit * 60 * 0.5;
    while (true) {
        timeleft = globallogic_utils::gettimeremaining() / 1000;
        if (timeleft <= halfway) {
            level notify(#"sndmusichalfway");
            return;
        }
        wait(2);
    }
}

// Namespace globallogic_audio
// Params 5, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_e3595143
// Checksum 0x6af087d1, Offset: 0x39b0
// Size: 0x1aa
function set_music_on_team(state, team, wait_time, save_state, return_state) {
    if (!isdefined(team)) {
        team = "both";
    }
    if (!isdefined(wait_time)) {
        wait_time = 0;
    }
    if (!isdefined(save_state)) {
        save_state = 0;
    }
    if (!isdefined(return_state)) {
        return_state = 0;
    }
    assert(isdefined(level.players));
    foreach (player in level.players) {
        if (team == "both") {
            player thread set_music_on_player(state, wait_time, save_state, return_state);
            continue;
        }
        if (isdefined(player.pers["team"]) && player.pers["team"] == team) {
            player thread set_music_on_player(state, wait_time, save_state, return_state);
        }
    }
}

// Namespace globallogic_audio
// Params 4, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_f35c5627
// Checksum 0x274d86dd, Offset: 0x3b68
// Size: 0xdc
function set_music_on_player(state, wait_time, save_state, return_state) {
    if (!isdefined(wait_time)) {
        wait_time = 0;
    }
    if (!isdefined(save_state)) {
        save_state = 0;
    }
    if (!isdefined(return_state)) {
        return_state = 0;
    }
    self endon(#"disconnect");
    assert(isplayer(self));
    if (!isdefined(state)) {
        return;
    }
    if (!isdefined(game["musicSet"])) {
        return;
    }
    music::setmusicstate(state + game["musicSet"], self);
}

// Namespace globallogic_audio
// Params 4, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_81e167b
// Checksum 0xfba48cb, Offset: 0x3c50
// Size: 0x9c
function set_music_global(state, wait_time, save_state, return_state) {
    if (!isdefined(wait_time)) {
        wait_time = 0;
    }
    if (!isdefined(save_state)) {
        save_state = 0;
    }
    if (!isdefined(return_state)) {
        return_state = 0;
    }
    if (!isdefined(state)) {
        return;
    }
    if (!isdefined(game["musicSet"])) {
        return;
    }
    music::setmusicstate(state + game["musicSet"]);
}

