#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_battlechatter;
#using scripts/mp/gametypes/_globallogic_audio;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/music_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace globallogic_audio;

// Namespace globallogic_audio
// Params 0, eflags: 0x2
// Checksum 0xe30ef1f5, Offset: 0xe50
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("globallogic_audio", &__init__, undefined, undefined);
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x15020d30, Offset: 0xe88
// Size: 0x6a
function __init__() {
    callback::on_start_gametype(&init);
    level.playleaderdialogonplayer = &leader_dialog_on_player;
    level.playequipmentdestroyedonplayer = &play_equipment_destroyed_on_player;
    level.playequipmenthackedonplayer = &play_equipment_hacked_on_player;
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x2026521c, Offset: 0xf00
// Size: 0x19
function init() {
    InvalidOpCode(0xc8, "music", "defeat", "mus_defeat");
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace globallogic_audio
// Params 4, eflags: 0x0
// Checksum 0x77a6e449, Offset: 0x1450
// Size: 0x7a
function set_leader_gametype_dialog(startgamedialogkey, starthcgamedialogkey, offenseorderdialogkey, defenseorderdialogkey) {
    level.leaderdialog = spawnstruct();
    level.leaderdialog.startgamedialog = startgamedialogkey;
    level.leaderdialog.starthcgamedialog = starthcgamedialogkey;
    level.leaderdialog.offenseorderdialog = offenseorderdialogkey;
    level.leaderdialog.defenseorderdialog = defenseorderdialogkey;
}

// Namespace globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0x9086dc10, Offset: 0x14d8
// Size: 0x102
function announce_round_winner(winner, delay) {
    if (delay > 0) {
        wait delay;
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
// Params 1, eflags: 0x0
// Checksum 0x94ec4707, Offset: 0x15e8
// Size: 0xba
function announce_game_winner(winner) {
    if (!isdefined(winner) || isplayer(winner)) {
        return;
    }
    wait battlechatter::mpdialog_value("announceWinnerDelay", 0);
    if (isdefined(level.teams[winner])) {
        leader_dialog("gameWon", winner);
        leader_dialog_for_other_teams("gameLost", winner);
    } else {
        leader_dialog("gameDraw");
    }
    wait battlechatter::mpdialog_value("commanderDialogBuffer", 0);
    battlechatter::game_end_vox(winner);
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xba240e80, Offset: 0x16b0
// Size: 0x63
function flush_dialog() {
    foreach (player in level.players) {
        player flush_dialog_on_player();
    }
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x233550a0, Offset: 0x1720
// Size: 0x2b
function flush_dialog_on_player() {
    self.leaderdialogqueue = [];
    self.currentleaderdialog = undefined;
    self.killstreakdialogqueue = [];
    self.scorestreakdialogplaying = 0;
    self notify(#"flush_dialog");
}

// Namespace globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x8c738cd3, Offset: 0x1758
// Size: 0x61
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
// Params 3, eflags: 0x0
// Checksum 0x8725d864, Offset: 0x17c8
// Size: 0xe0
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
// Params 1, eflags: 0x0
// Checksum 0x115f4b0d, Offset: 0x18b0
// Size: 0x6b
function flush_objective_dialog(objectivekey) {
    foreach (player in level.players) {
        player flush_objective_dialog_on_player(objectivekey);
    }
}

// Namespace globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x4c63513c, Offset: 0x1928
// Size: 0x63
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
// Checksum 0xa68842ac, Offset: 0x1998
// Size: 0x6b
function flush_leader_dialog_key(dialogkey) {
    foreach (player in level.players) {
        player flush_leader_dialog_key_on_player(dialogkey);
    }
}

// Namespace globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x49622707, Offset: 0x1a10
// Size: 0x61
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
// Params 3, eflags: 0x0
// Checksum 0xaf9bcf48, Offset: 0x1a80
// Size: 0x32
function play_taacom_dialog(dialogkey, killstreaktype, killstreakid) {
    self killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid);
}

// Namespace globallogic_audio
// Params 4, eflags: 0x0
// Checksum 0x64a61b4e, Offset: 0x1ac0
// Size: 0xf2
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
// Params 0, eflags: 0x0
// Checksum 0xd01390fa, Offset: 0x1bc0
// Size: 0x42
function wait_for_player_dialog() {
    self endon(#"disconnect");
    self endon(#"flush_dialog");
    level endon(#"game_ended");
    while (self.playingdialog) {
        wait 0.5;
    }
    self thread play_next_killstreak_dialog();
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x81bcf3d8, Offset: 0x1c10
// Size: 0x23a
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
// Params 0, eflags: 0x0
// Checksum 0x7b2a329b, Offset: 0x1e58
// Size: 0x42
function wait_next_killstreak_dialog() {
    self endon(#"disconnect");
    self endon(#"flush_dialog");
    level endon(#"game_ended");
    wait battlechatter::mpdialog_value("killstreakDialogBuffer", 0);
    self thread play_next_killstreak_dialog();
}

// Namespace globallogic_audio
// Params 5, eflags: 0x0
// Checksum 0xf03d887d, Offset: 0x1ea8
// Size: 0xb3
function leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey) {
    assert(isdefined(skipteam));
    foreach (team in level.teams) {
        if (team != skipteam) {
            leader_dialog(dialogkey, team, undefined, objectivekey, killstreakid, dialogbufferkey);
        }
    }
}

// Namespace globallogic_audio
// Params 6, eflags: 0x0
// Checksum 0x7ddd6b06, Offset: 0x1f68
// Size: 0x10b
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
// Params 4, eflags: 0x0
// Checksum 0x442a460e, Offset: 0x2080
// Size: 0x2ca
function leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey) {
    if (!isdefined(dialogkey)) {
        return;
    }
    if (!level.allowannouncer) {
        return;
    }
    if (self.sessionstate == "spectating") {
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
// Params 0, eflags: 0x0
// Checksum 0x6c118c66, Offset: 0x2358
// Size: 0x1ea
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
// Params 1, eflags: 0x0
// Checksum 0xec33c6f5, Offset: 0x2550
// Size: 0x3a
function wait_next_leader_dialog(dialogbuffer) {
    self endon(#"disconnect");
    self endon(#"flush_dialog");
    level endon(#"game_ended");
    wait dialogbuffer;
    self thread play_next_leader_dialog();
}

// Namespace globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x9285cf6c, Offset: 0x2598
// Size: 0x36a
function dialogkey_priority(dialogkey) {
    switch (dialogkey) {
    case "enemyRapsMultiple":
    case "enemyRcBomb":
    case "enemyRcBombMultiple":
    case "enemyRemoteMissile":
    case "enemyRemoteMissileMultiple":
    case "enemyAiTank":
    case "enemyAiTankMultiple":
    case "enemyCombatRobot":
    case "enemyCombatRobotMultiple":
    case "enemyDart":
    case "enemyDartMultiple":
    case "enemyDroneStrike":
    case "enemyDroneStrikeMultiple":
    case "enemySentinel":
    case "enemyHelicopter":
    case "enemyHelicopterGunner":
    case "enemyHelicopterGunnerMultiple":
    case "enemyHelicopterMultiple":
    case "enemyMicrowaveTurret":
    case "enemyMicrowaveTurretMultiple":
    case "enemyPlaneMortar":
    case "enemyPlaneMortarMultiple":
    case "enemyPlaneMortarUsed":
    case "enemyRaps":
    case "enemySentinelMultiple":
    case "enemyTurret":
    case "enemyTurretMultiple":
        return 1;
    case "gameLeadLost":
    case "gameLeadTaken":
    case "gameLosing":
    case "gameWinning":
    case "nearDrawing":
    case "nearLosing":
    case "nearWinning":
    case "roundEncourageLastPlayer":
        return 1;
    case "ctfFriendlyFlagReturned":
    case "ctfFriendlyFlagTaken":
    case "domEnemyHasB":
    case "domEnemyHasC":
    case "domEnemySecuredA":
    case "domEnemySecuredB":
    case "domEnemySecuredC":
    case "domEnemySecuringA":
    case "domEnemySecuringB":
    case "domEnemySecuringC":
    case "domFriendlySecuredA":
    case "domFriendlySecuredAll":
    case "domFriendlySecuredB":
    case "domFriendlySecuredC":
    case "domFriendlySecuringA":
    case "domFriendlySecuringB":
    case "domFriendlySecuringC":
    case "domEnemyHasA":
    case "bombDefused":
    case "bombEnemyTaken":
    case "bombFriendlyDropped":
    case "bombFriendlyTaken":
    case "bombPlanted":
    case "ctfEnemyFlagCaptured":
    case "ctfEnemyFlagDropped":
    case "hubMoved":
    case "hubOffline":
    case "hubOnline":
    case "hubsMoved":
    case "hubsOffline":
    case "hubsOnline":
    case "kothCaptured":
    case "kothContested":
    case "kothLocated":
    case "kothLost":
    case "kothOnline":
    case "kothSecured":
    case "ctfEnemyFlagReturned":
    case "ctfEnemyFlagTaken":
    case "ctfFriendlyFlagCaptured":
    case "ctfFriendlyFlagDropped":
    case "sfgRobotCloseAttacker":
    case "sfgRobotCloseDefender":
    case "sfgRobotDisabledAttacker":
    case "sfgRobotDisabledDefender":
    case "sfgRobotNeedReboot":
    case "sfgRobotRebootedAttacker":
    case "sfgRobotRebootedDefender":
    case "sfgRobotRebootedTowAttacker":
    case "sfgRobotRebootedTowDefender":
    case "sfgRobotUnderFire":
    case "sfgRobotUnderFireNeutral":
    case "sfgStartAttack":
    case "sfgStartDefend":
    case "sfgStartHrAttack":
    case "sfgStartHrDefend":
    case "sfgStartTow":
    case "sfgTheyReturn":
    case "sfgWeReturn":
    case "uplOrders":
    case "uplReset":
    case "uplTheyDrop":
    case "uplTheyTake":
    case "uplTheyUplink":
    case "uplTheyUplinkRemote":
    case "uplTransferred":
    case "uplWeDrop":
    case "uplWeTake":
    case "uplWeUplink":
    case "uplWeUplinkRemote":
        return 1;
    }
    return undefined;
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xea495c38, Offset: 0x2910
// Size: 0x1a
function play_equipment_destroyed_on_player() {
    self play_taacom_dialog("equipmentDestroyed");
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x3ff6d06b, Offset: 0x2938
// Size: 0x1a
function play_equipment_hacked_on_player() {
    self play_taacom_dialog("equipmentHacked");
}

// Namespace globallogic_audio
// Params 1, eflags: 0x0
// Checksum 0x23762c19, Offset: 0x2960
// Size: 0x69
function get_commander_dialog_alias(dialogkey) {
    if (!isdefined(self.pers["mpcommander"])) {
        return undefined;
    }
    commanderbundle = struct::get_script_bundle("mpdialog_commander", self.pers["mpcommander"]);
    return get_dialog_bundle_alias(commanderbundle, dialogkey);
}

// Namespace globallogic_audio
// Params 2, eflags: 0x0
// Checksum 0xb4aaecbe, Offset: 0x29d8
// Size: 0x7d
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
// Params 1, eflags: 0x0
// Checksum 0x11cbb7d1, Offset: 0x2a60
// Size: 0x39
function is_team_winning(checkteam) {
    InvalidOpCode(0x54, "teamScores", checkteam);
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x81ede85e, Offset: 0x2af8
// Size: 0x96
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
// Params 2, eflags: 0x0
// Checksum 0x8262cf20, Offset: 0x2b98
// Size: 0xa1
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
// Params 1, eflags: 0x0
// Checksum 0x88aa42, Offset: 0x2c48
// Size: 0x29
function get_round_switch_dialog(switchtype) {
    switch (switchtype) {
    case "halftime":
        return "roundHalftime";
    case "overtime":
        return "roundOvertime";
    default:
        return "roundSwitchSides";
    }
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x224ddae9, Offset: 0x2ca0
// Size: 0x42
function function_de3b188d() {
    level waittill(#"game_ended");
    level util::clientnotify("pm");
    level waittill(#"sfade");
    level util::clientnotify("pmf");
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0xcebf003e, Offset: 0x2cf0
// Size: 0x102
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
// Params 0, eflags: 0x0
// Checksum 0x92a84e87, Offset: 0x2e00
// Size: 0x42
function sndmusicfunctions() {
    level thread sndmusictimesout();
    level thread sndmusichalfway();
    level thread sndmusictimelimitwatcher();
    level thread sndmusicunlock();
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x3c9f0be6, Offset: 0x2e50
// Size: 0x9
function sndmusicsetrandomizer() {
    InvalidOpCode(0x54, "roundsplayed");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x89b5d40c, Offset: 0x2ef0
// Size: 0x1d
function sndmusicunlock() {
    level waittill(#"game_ended");
    unlockname = undefined;
    InvalidOpCode(0x54, "musicSet");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x33a4c65f, Offset: 0x2fa8
// Size: 0x6a
function sndmusictimesout() {
    level endon(#"game_ended");
    level endon(#"musicendingoverride");
    level waittill(#"match_ending_very_soon");
    if (isdefined(level.gametype) && level.gametype == "sd") {
        level thread set_music_on_team("timeOutQuiet");
        return;
    }
    level thread set_music_on_team("timeOut");
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x915ac6f7, Offset: 0x3020
// Size: 0x3a
function sndmusichalfway() {
    level endon(#"game_ended");
    level endon(#"match_ending_soon");
    level endon(#"match_ending_very_soon");
    level waittill(#"sndmusichalfway");
    level thread set_music_on_team("underscore");
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// Checksum 0x57581bcc, Offset: 0x3068
// Size: 0x93
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
        wait 2;
    }
}

// Namespace globallogic_audio
// Params 5, eflags: 0x0
// Checksum 0x37d8465c, Offset: 0x3108
// Size: 0x133
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
// Params 4, eflags: 0x0
// Checksum 0xf16edd14, Offset: 0x3248
// Size: 0x81
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
    InvalidOpCode(0x54, "musicSet");
    // Unknown operator (0x54, t7_1b, PC)
}

// Namespace globallogic_audio
// Params 4, eflags: 0x0
// Checksum 0x4b263900, Offset: 0x32f8
// Size: 0x4d
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
    InvalidOpCode(0x54, "musicSet");
    // Unknown operator (0x54, t7_1b, PC)
}

