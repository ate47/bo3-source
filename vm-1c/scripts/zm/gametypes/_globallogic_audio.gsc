#using scripts/zm/_util;
#using scripts/zm/gametypes/_globallogic_utils;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/music_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace globallogic_audio;

// Namespace globallogic_audio
// Params 0, eflags: 0x2
// namespace_51c2821<file_0>::function_2dc19561
// Checksum 0x57b19b2f, Offset: 0xc48
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("globallogic_audio", &__init__, undefined, undefined);
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_8c87d8eb
// Checksum 0xa157e38e, Offset: 0xc88
// Size: 0x24
function __init__() {
    callback::on_start_gametype(&init);
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_c35e6aab
// Checksum 0x27620dbc, Offset: 0xcb8
// Size: 0x10c4
function init() {
    game["music"]["defeat"] = "mus_defeat";
    game["music"]["victory_spectator"] = "mus_defeat";
    game["music"]["winning"] = "mus_time_running_out_winning";
    game["music"]["losing"] = "mus_time_running_out_losing";
    game["music"]["match_end"] = "mus_match_end";
    game["music"]["victory_tie"] = "mus_defeat";
    game["music"]["suspense"] = [];
    game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_01";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_02";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_03";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_04";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_05";
    game["music"]["suspense"][game["music"]["suspense"].size] = "mus_suspense_06";
    game["dialog"]["mission_success"] = "mission_success";
    game["dialog"]["mission_failure"] = "mission_fail";
    game["dialog"]["mission_draw"] = "draw";
    game["dialog"]["round_success"] = "encourage_win";
    game["dialog"]["round_failure"] = "encourage_lost";
    game["dialog"]["round_draw"] = "draw";
    game["dialog"]["timesup"] = "timesup";
    game["dialog"]["winning"] = "winning";
    game["dialog"]["losing"] = "losing";
    game["dialog"]["min_draw"] = "min_draw";
    game["dialog"]["lead_lost"] = "lead_lost";
    game["dialog"]["lead_tied"] = "tied";
    game["dialog"]["lead_taken"] = "lead_taken";
    game["dialog"]["last_alive"] = "lastalive";
    game["dialog"]["boost"] = "generic_boost";
    if (!isdefined(game["dialog"]["offense_obj"])) {
        game["dialog"]["offense_obj"] = "generic_boost";
    }
    if (!isdefined(game["dialog"]["defense_obj"])) {
        game["dialog"]["defense_obj"] = "generic_boost";
    }
    game["dialog"]["hardcore"] = "hardcore";
    game["dialog"]["oldschool"] = "oldschool";
    game["dialog"]["highspeed"] = "highspeed";
    game["dialog"]["tactical"] = "tactical";
    game["dialog"]["challenge"] = "challengecomplete";
    game["dialog"]["promotion"] = "promotion";
    game["dialog"]["bomb_acquired"] = "sd_bomb_taken";
    game["dialog"]["bomb_taken"] = "sd_bomb_taken_taken";
    game["dialog"]["bomb_lost"] = "sd_bomb_drop";
    game["dialog"]["bomb_defused"] = "sd_bomb_defused";
    game["dialog"]["bomb_planted"] = "sd_bomb_planted";
    game["dialog"]["obj_taken"] = "securedobj";
    game["dialog"]["obj_lost"] = "lostobj";
    game["dialog"]["obj_defend"] = "defend_start";
    game["dialog"]["obj_destroy"] = "destroy_start";
    game["dialog"]["obj_capture"] = "capture_obj";
    game["dialog"]["objs_capture"] = "capture_objs";
    game["dialog"]["hq_located"] = "hq_located";
    game["dialog"]["hq_enemy_captured"] = "hq_capture";
    game["dialog"]["hq_enemy_destroyed"] = "hq_defend";
    game["dialog"]["hq_secured"] = "hq_secured";
    game["dialog"]["hq_offline"] = "hq_offline";
    game["dialog"]["hq_online"] = "hq_online";
    game["dialog"]["koth_located"] = "koth_located";
    game["dialog"]["koth_captured"] = "koth_captured";
    game["dialog"]["koth_lost"] = "koth_lost";
    game["dialog"]["koth_secured"] = "koth_secured";
    game["dialog"]["koth_contested"] = "koth_contest";
    game["dialog"]["koth_offline"] = "koth_offline";
    game["dialog"]["koth_online"] = "koth_online";
    game["dialog"]["move_to_new"] = "new_positions";
    game["dialog"]["attack"] = "attack";
    game["dialog"]["defend"] = "defend";
    game["dialog"]["offense"] = "offense";
    game["dialog"]["defense"] = "defense";
    game["dialog"]["halftime"] = "halftime";
    game["dialog"]["overtime"] = "overtime";
    game["dialog"]["side_switch"] = "switchingsides";
    game["dialog"]["flag_taken"] = "ourflag";
    game["dialog"]["flag_dropped"] = "ourflag_drop";
    game["dialog"]["flag_returned"] = "ourflag_return";
    game["dialog"]["flag_captured"] = "ourflag_capt";
    game["dialog"]["enemy_flag_taken"] = "enemyflag";
    game["dialog"]["enemy_flag_dropped"] = "enemyflag_drop";
    game["dialog"]["enemy_flag_returned"] = "enemyflag_return";
    game["dialog"]["enemy_flag_captured"] = "enemyflag_capt";
    game["dialog"]["securing_a"] = "dom_securing_a";
    game["dialog"]["securing_b"] = "dom_securing_b";
    game["dialog"]["securing_c"] = "dom_securing_c";
    game["dialog"]["securing_d"] = "dom_securing_d";
    game["dialog"]["securing_e"] = "dom_securing_e";
    game["dialog"]["securing_f"] = "dom_securing_f";
    game["dialog"]["secured_a"] = "dom_secured_a";
    game["dialog"]["secured_b"] = "dom_secured_b";
    game["dialog"]["secured_c"] = "dom_secured_c";
    game["dialog"]["secured_d"] = "dom_secured_d";
    game["dialog"]["secured_e"] = "dom_secured_e";
    game["dialog"]["secured_f"] = "dom_secured_f";
    game["dialog"]["losing_a"] = "dom_losing_a";
    game["dialog"]["losing_b"] = "dom_losing_b";
    game["dialog"]["losing_c"] = "dom_losing_c";
    game["dialog"]["losing_d"] = "dom_losing_d";
    game["dialog"]["losing_e"] = "dom_losing_e";
    game["dialog"]["losing_f"] = "dom_losing_f";
    game["dialog"]["lost_a"] = "dom_lost_a";
    game["dialog"]["lost_b"] = "dom_lost_b";
    game["dialog"]["lost_c"] = "dom_lost_c";
    game["dialog"]["lost_d"] = "dom_lost_d";
    game["dialog"]["lost_e"] = "dom_lost_e";
    game["dialog"]["lost_f"] = "dom_lost_f";
    game["dialog"]["secure_flag"] = "secure_flag";
    game["dialog"]["securing_flag"] = "securing_flag";
    game["dialog"]["losing_flag"] = "losing_flag";
    game["dialog"]["lost_flag"] = "lost_flag";
    game["dialog"]["oneflag_enemy"] = "oneflag_enemy";
    game["dialog"]["oneflag_friendly"] = "oneflag_friendly";
    game["dialog"]["lost_all"] = "dom_lock_theytake";
    game["dialog"]["secure_all"] = "dom_lock_wetake";
    game["dialog"]["squad_move"] = "squad_move";
    game["dialog"]["squad_30sec"] = "squad_30sec";
    game["dialog"]["squad_winning"] = "squad_onemin_vic";
    game["dialog"]["squad_losing"] = "squad_onemin_loss";
    game["dialog"]["squad_down"] = "squad_down";
    game["dialog"]["squad_bomb"] = "squad_bomb";
    game["dialog"]["squad_plant"] = "squad_plant";
    game["dialog"]["squad_take"] = "squad_takeobj";
    game["dialog"]["kicked"] = "player_kicked";
    game["dialog"]["sentry_destroyed"] = "dest_sentry";
    game["dialog"]["sentry_hacked"] = "kls_turret_hacked";
    game["dialog"]["microwave_destroyed"] = "dest_microwave";
    game["dialog"]["microwave_hacked"] = "kls_microwave_hacked";
    game["dialog"]["sam_destroyed"] = "dest_sam";
    game["dialog"]["tact_destroyed"] = "dest_tact";
    game["dialog"]["equipment_destroyed"] = "dest_equip";
    game["dialog"]["hacked_equip"] = "hacked_equip";
    game["dialog"]["uav_destroyed"] = "kls_u2_destroyed";
    game["dialog"]["cuav_destroyed"] = "kls_cu2_destroyed";
    level.var_e5e11629 = [];
    level thread function_de3b188d();
}

// Namespace globallogic_audio
// Params 2, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_9c3f9daf
// Checksum 0xab839279, Offset: 0x1d88
// Size: 0xe8
function function_9c3f9daf(group, var_5237b452) {
    if (!isdefined(level.var_e5e11629)) {
        level.var_e5e11629 = [];
    } else if (isdefined(level.dialoggroup[group])) {
        util::error("registerDialogGroup:  Dialog group " + group + " already registered.");
        return;
    }
    level.dialoggroup[group] = spawnstruct();
    level.dialoggroup[group].group = group;
    level.dialoggroup[group].var_5237b452 = var_5237b452;
    level.dialoggroup[group].currentcount = 0;
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_2a897a84
// Checksum 0x51859829, Offset: 0x1e78
// Size: 0xac
function function_2a897a84() {
    self endon(#"disconnect");
    if (game["state"] == "postgame") {
        return;
    }
    if (!isdefined(level.nextmusicstate)) {
        /#
            if (getdvarint("losing") > 0) {
                println("losing");
            }
        #/
        self.pers["music"].currentstate = "UNDERSCORE";
        self thread suspensemusic();
    }
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_8395d834
// Checksum 0x31b64c40, Offset: 0x1f30
// Size: 0xa4
function function_8395d834() {
    self endon(#"disconnect");
    self thread set_music_on_player("UNDERSCORE", 0);
    /#
        if (getdvarint("losing") > 0) {
            println("losing" + self.pers["losing"].returnstate + "losing" + self getentitynumber());
        }
    #/
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_79a5ffc6
// Checksum 0x7e5392bb, Offset: 0x1fe0
// Size: 0x288
function suspensemusic(random) {
    level endon(#"game_ended");
    level endon(#"match_ending_soon");
    self endon(#"disconnect");
    /#
        if (getdvarint("losing") > 0) {
            println("losing");
        }
    #/
    while (true) {
        wait(randomintrange(25, 60));
        /#
            if (getdvarint("losing") > 0) {
                println("losing");
            }
        #/
        if (!isdefined(self.pers["music"].inque)) {
            self.pers["music"].inque = 0;
        }
        if (self.pers["music"].inque) {
            /#
                if (getdvarint("losing") > 0) {
                    println("losing");
                }
            #/
            continue;
        }
        if (!isdefined(self.pers["music"].currentstate)) {
            self.pers["music"].currentstate = "SILENT";
        }
        if (randomint(100) < self.underscorechance && self.pers["music"].currentstate != "ACTION" && self.pers["music"].currentstate != "TIME_OUT") {
            self thread function_8395d834();
            self.underscorechance -= 20;
            /#
                if (getdvarint("losing") > 0) {
                    println("losing");
                }
            #/
        }
    }
}

// Namespace globallogic_audio
// Params 3, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_89d56d3
// Checksum 0xce9a39a1, Offset: 0x2270
// Size: 0xba
function function_89d56d3(dialog, skip_team, var_f2c55274) {
    foreach (team in level.teams) {
        if (team != skip_team) {
            leaderdialog(dialog, team, undefined, undefined, var_f2c55274);
        }
    }
}

// Namespace globallogic_audio
// Params 2, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_a6efdbf5
// Checksum 0xaf97cd59, Offset: 0x2338
// Size: 0x15c
function function_a6efdbf5(winner, delay) {
    if (delay > 0) {
        wait(delay);
    }
    if (!isdefined(winner) || isplayer(winner)) {
        return;
    }
    if (isdefined(level.teams[winner])) {
        leaderdialog("round_success", winner);
        function_89d56d3("round_failure", winner);
        return;
    }
    foreach (team in level.teams) {
        thread util::playsoundonplayers("mus_round_draw" + "_" + level.teampostfix[team]);
    }
    leaderdialog("round_draw");
}

// Namespace globallogic_audio
// Params 2, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_19c083
// Checksum 0xe131f084, Offset: 0x24a0
// Size: 0xbc
function function_19c083(winner, delay) {
    if (delay > 0) {
        wait(delay);
    }
    if (!isdefined(winner) || isplayer(winner)) {
        return;
    }
    if (isdefined(level.teams[winner])) {
        leaderdialog("mission_success", winner);
        function_89d56d3("mission_failure", winner);
        return;
    }
    leaderdialog("mission_draw");
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// namespace_51c2821<file_0>::function_521fca0b
// Checksum 0x52569c2c, Offset: 0x2568
// Size: 0x98
function function_521fca0b() {
    self endon(#"disconnect");
    waittillframeend();
    if (!isdefined(self.var_ef23adb9)) {
        self.var_ef23adb9 = 0;
    }
    currenttime = gettime();
    if (self.var_ef23adb9 + level.fire_audio_repeat_duration + randomint(level.fire_audio_random_max_duration) < currenttime) {
        self playlocalsound("vox_pain_small");
        self.var_ef23adb9 = currenttime;
    }
}

// Namespace globallogic_audio
// Params 5, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_8cd2e72e
// Checksum 0x4236b373, Offset: 0x2608
// Size: 0x2b6
function leaderdialog(dialog, team, group, excludelist, var_4972cdc5) {
    assert(isdefined(level.players));
    if (level.splitscreen) {
        return;
    }
    if (level.wagermatch) {
        return;
    }
    if (!isdefined(team)) {
        var_93e4c148 = [];
        foreach (team in level.teams) {
            var_93e4c148[team] = dialog;
        }
        function_cbd911cb(var_93e4c148, group, excludelist);
        return;
    }
    if (level.splitscreen) {
        if (level.players.size) {
            level.players[0] leaderdialogonplayer(dialog, group);
        }
        return;
    }
    if (isdefined(excludelist)) {
        for (i = 0; i < level.players.size; i++) {
            player = level.players[i];
            if (isdefined(player.pers["team"]) && player.pers["team"] == team && !globallogic_utils::isexcluded(player, excludelist)) {
                player leaderdialogonplayer(dialog, group);
            }
        }
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (isdefined(player.pers["team"]) && player.pers["team"] == team) {
            player leaderdialogonplayer(dialog, group);
        }
    }
}

// Namespace globallogic_audio
// Params 3, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_cbd911cb
// Checksum 0xa770b8fe, Offset: 0x28c8
// Size: 0x17e
function function_cbd911cb(var_93e4c148, group, excludelist) {
    assert(isdefined(level.players));
    if (level.splitscreen) {
        return;
    }
    if (level.splitscreen) {
        if (level.players.size) {
            level.players[0] leaderdialogonplayer(var_93e4c148[level.players[0].team], group);
        }
        return;
    }
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        team = player.pers["team"];
        if (!isdefined(team)) {
            continue;
        }
        if (!isdefined(var_93e4c148[team])) {
            continue;
        }
        if (isdefined(excludelist) && globallogic_utils::isexcluded(player, excludelist)) {
            continue;
        }
        player leaderdialogonplayer(var_93e4c148[team], group);
    }
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_d99d939d
// Checksum 0x49b0557c, Offset: 0x2a50
// Size: 0x8a
function function_d99d939d() {
    foreach (player in level.players) {
        player function_63c739b9();
    }
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_63c739b9
// Checksum 0x8766fccc, Offset: 0x2ae8
// Size: 0x38
function function_63c739b9() {
    self.leaderdialoggroups = [];
    self.leaderdialogqueue = [];
    self.leaderdialogactive = 0;
    self.currentleaderdialoggroup = "";
}

// Namespace globallogic_audio
// Params 1, eflags: 0x0
// namespace_51c2821<file_0>::function_11f65e
// Checksum 0x2c8c089d, Offset: 0x2b28
// Size: 0x9a
function function_11f65e(group) {
    foreach (player in level.players) {
        player function_aa8700b6(group);
    }
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_aa8700b6
// Checksum 0xfccf40a5, Offset: 0x2bd0
// Size: 0xa2
function function_aa8700b6(group) {
    self.leaderdialoggroups[group] = undefined;
    foreach (key, dialog in self.leaderdialogqueue) {
        if (dialog == group) {
            self.leaderdialogqueue[key] = undefined;
        }
    }
}

// Namespace globallogic_audio
// Params 2, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_270e670f
// Checksum 0x2537c82b, Offset: 0x2c80
// Size: 0x1ea
function function_270e670f(dialog, group) {
    if (!isdefined(level.dialoggroup[group])) {
        util::error("leaderDialogOnPlayer:  Dialog group " + group + " is not registered");
        return 0;
    }
    var_a5f2db52 = 0;
    if (!isdefined(self.leaderdialoggroups[group])) {
        var_a5f2db52 = 1;
    }
    if (!level.dialoggroup[group].var_5237b452) {
        if (self.currentleaderdialog == dialog && self.currentleaderdialogtime + 2000 > gettime()) {
            self.leaderdialoggroups[group] = undefined;
            foreach (key, leader_dialog in self.leaderdialogqueue) {
                if (leader_dialog == group) {
                    for (i = key + 1; i < self.leaderdialogqueue.size; i++) {
                        self.leaderdialogqueue[i - 1] = self.leaderdialogqueue[i];
                    }
                    self.leaderdialogqueue[i - 1] = undefined;
                    break;
                }
            }
            return 0;
        }
    } else if (self.currentleaderdialoggroup == group) {
        return 0;
    }
    self.leaderdialoggroups[group] = dialog;
    return var_a5f2db52;
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_fc4617ba
// Checksum 0x7eb2b86e, Offset: 0x2e78
// Size: 0xc2
function function_fc4617ba(group) {
    /#
        count = 0;
        foreach (temp in self.leaderdialogqueue) {
            if (temp == group) {
                count++;
            }
        }
        if (count > 1) {
            shit = 0;
        }
    #/
}

// Namespace globallogic_audio
// Params 2, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_5b8d0e6
// Checksum 0xd8651eeb, Offset: 0x2f48
// Size: 0xe6
function leaderdialogonplayer(dialog, group) {
    team = self.pers["team"];
    if (level.splitscreen) {
        return;
    }
    if (!isdefined(team)) {
        return;
    }
    if (!isdefined(level.teams[team])) {
        return;
    }
    if (isdefined(group)) {
        if (!function_270e670f(dialog, group)) {
            self function_fc4617ba(group);
            return;
        }
        dialog = group;
    }
    if (!self.leaderdialogactive) {
        self thread playleaderdialogonplayer(dialog);
        return;
    }
    self.leaderdialogqueue[self.leaderdialogqueue.size] = dialog;
}

// Namespace globallogic_audio
// Params 2, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_17c50624
// Checksum 0xeedf1044, Offset: 0x3038
// Size: 0x84
function function_17c50624(sound, extratime) {
    if (!isdefined(extratime)) {
        extratime = 0.1;
    }
    time = soundgetplaybacktime(sound);
    if (time < 0) {
        wait(3 + extratime);
        return;
    }
    wait(time * 0.001 + extratime);
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_e529fd90
// Checksum 0xd23669e6, Offset: 0x30c8
// Size: 0x294
function playleaderdialogonplayer(dialog) {
    if (isdefined(level.allowannouncer) && !level.allowannouncer) {
        return;
    }
    team = self.pers["team"];
    self endon(#"disconnect");
    self.leaderdialogactive = 1;
    if (isdefined(self.leaderdialoggroups[dialog])) {
        group = dialog;
        dialog = self.leaderdialoggroups[group];
        self.leaderdialoggroups[group] = undefined;
        self.currentleaderdialoggroup = group;
        self function_fc4617ba(group);
    }
    if (level.wagermatch || !isdefined(game["voice"])) {
        faction = "vox_wm_";
    } else {
        faction = game["voice"][team];
    }
    sound_name = faction + game["dialog"][dialog];
    if (level.allowannouncer) {
        self playlocalsound(sound_name);
        self.currentleaderdialog = dialog;
        self.currentleaderdialogtime = gettime();
    }
    function_17c50624(sound_name);
    self.leaderdialogactive = 0;
    self.currentleaderdialoggroup = "";
    self.currentleaderdialog = "";
    if (self.leaderdialogqueue.size > 0) {
        nextdialog = self.leaderdialogqueue[0];
        for (i = 1; i < self.leaderdialogqueue.size; i++) {
            self.leaderdialogqueue[i - 1] = self.leaderdialogqueue[i];
        }
        self.leaderdialogqueue[i - 1] = undefined;
        if (isdefined(self.leaderdialoggroups[dialog])) {
            self function_fc4617ba(dialog);
        }
        self thread playleaderdialogonplayer(nextdialog);
    }
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_42bdf8e
// Checksum 0x5e34189f, Offset: 0x3368
// Size: 0xcc
function function_42bdf8e(checkteam) {
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
// namespace_51c2821<file_0>::function_a069d2b5
// Checksum 0xcf1fa321, Offset: 0x3440
// Size: 0xe2
function function_a069d2b5() {
    foreach (team in level.teams) {
        if (function_42bdf8e(team)) {
            leaderdialog("winning", team, undefined, undefined, "squad_winning");
            function_89d56d3("losing", team, "squad_losing");
            return true;
        }
    }
    return false;
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_eed68ebe
// Checksum 0xd17f15df, Offset: 0x3530
// Size: 0x174
function musiccontroller() {
    level endon(#"game_ended");
    level thread function_b510a5ac();
    level waittill(#"match_ending_soon");
    if (util::islastround() || util::isoneround()) {
        if (!level.splitscreen) {
            if (level.teambased) {
                if (!function_a069d2b5()) {
                    leaderdialog("min_draw");
                }
            }
            level waittill(#"match_ending_very_soon");
            foreach (team in level.teams) {
                leaderdialog("timesup", team, undefined, undefined, "squad_30sec");
            }
        }
        return;
    }
    level waittill(#"match_ending_vox");
    leaderdialog("timesup");
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_b510a5ac
// Checksum 0xeef964e9, Offset: 0x36b0
// Size: 0x44
function function_b510a5ac() {
    level endon(#"game_ended");
    level waittill(#"match_ending_very_soon");
    thread set_music_on_team("TIME_OUT", "both", 1, 0);
}

// Namespace globallogic_audio
// Params 0, eflags: 0x0
// namespace_51c2821<file_0>::function_89994704
// Checksum 0xf48b64e4, Offset: 0x3700
// Size: 0x2c
function function_89994704() {
    level endon(#"game_ended");
    level.playingactionmusic = 1;
    wait(45);
    level.playingactionmusic = 0;
}

// Namespace globallogic_audio
// Params 2, eflags: 0x0
// namespace_51c2821<file_0>::function_ea1beeac
// Checksum 0xf0f66b03, Offset: 0x3738
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
// Params 5, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_e3595143
// Checksum 0x9e3d3cfd, Offset: 0x3818
// Size: 0x2fe
function set_music_on_team(state, team, save_state, return_state, wait_time) {
    if (sessionmodeiszombiesgame()) {
        return;
    }
    assert(isdefined(level.players));
    if (!isdefined(team)) {
        team = "both";
        /#
            if (getdvarint("losing") > 0) {
                println("losing");
            }
        #/
    }
    if (!isdefined(save_state)) {
        var_ae07e254 = 0;
        /#
            if (getdvarint("losing") > 0) {
                println("losing");
            }
        #/
    }
    if (!isdefined(return_state)) {
        return_state = 0;
        /#
            if (getdvarint("losing") > 0) {
                println("losing");
            }
        #/
    }
    if (!isdefined(wait_time)) {
        wait_time = 0;
        /#
            if (getdvarint("losing") > 0) {
                println("losing");
            }
        #/
    }
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (team == "both") {
            player thread set_music_on_player(state, save_state, return_state, wait_time);
            continue;
        }
        if (isdefined(player.pers["team"]) && player.pers["team"] == team) {
            player thread set_music_on_player(state, save_state, return_state, wait_time);
            /#
                if (getdvarint("losing") > 0) {
                    println("losing" + state + "losing" + player getentitynumber());
                }
            #/
        }
    }
}

// Namespace globallogic_audio
// Params 4, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_f35c5627
// Checksum 0x51f55112, Offset: 0x3b20
// Size: 0x424
function set_music_on_player(state, save_state, return_state, wait_time) {
    self endon(#"disconnect");
    if (sessionmodeiszombiesgame()) {
        return;
    }
    assert(isplayer(self));
    if (!isdefined(save_state)) {
        save_state = 0;
        /#
            if (getdvarint("losing") > 0) {
                println("losing");
            }
        #/
    }
    if (!isdefined(return_state)) {
        return_state = 0;
        /#
            if (getdvarint("losing") > 0) {
                println("losing");
            }
        #/
    }
    if (!isdefined(wait_time)) {
        wait_time = 0;
        /#
            if (getdvarint("losing") > 0) {
                println("losing");
            }
        #/
    }
    if (!isdefined(state)) {
        state = "UNDERSCORE";
        /#
            if (getdvarint("losing") > 0) {
                println("losing");
            }
        #/
    }
    music::setmusicstate(state, self);
    if (isdefined(self.pers["music"].currentstate) && save_state) {
        self.pers["music"].returnstate = state;
        /#
            if (getdvarint("losing") > 0) {
                println("losing" + self.pers["losing"].returnstate + "losing" + self getentitynumber());
            }
        #/
    }
    self.pers["music"].previousstate = self.pers["music"].currentstate;
    self.pers["music"].currentstate = state;
    /#
        if (getdvarint("losing") > 0) {
            println("losing" + state + "losing" + self getentitynumber());
        }
    #/
    if (isdefined(self.pers["music"].returnstate) && return_state) {
        /#
            if (getdvarint("losing") > 0) {
                println("losing" + self.pers["losing"].returnstate + "losing" + self getentitynumber());
            }
        #/
        self function_419e790f(self.pers["music"].returnstate, wait_time);
    }
}

// Namespace globallogic_audio
// Params 1, eflags: 0x0
// namespace_51c2821<file_0>::function_4f633c43
// Checksum 0x8ced2f82, Offset: 0x3f50
// Size: 0x94
function function_4f633c43(wait_time) {
    if (!isdefined(wait_time)) {
        wait_time = 0;
        /#
            if (getdvarint("losing") > 0) {
                println("losing");
            }
        #/
    }
    self function_419e790f(self.pers["music"].returnstate, wait_time);
}

// Namespace globallogic_audio
// Params 2, eflags: 0x0
// namespace_51c2821<file_0>::function_5f207017
// Checksum 0xaa3e54f5, Offset: 0x3ff0
// Size: 0x1de
function function_5f207017(team, wait_time) {
    if (!isdefined(wait_time)) {
        wait_time = 0;
        /#
            if (getdvarint("losing") > 0) {
                println("losing");
            }
        #/
    }
    for (i = 0; i < level.players.size; i++) {
        player = level.players[i];
        if (team == "both") {
            player thread function_419e790f(self.pers["music"].returnstate, wait_time);
            continue;
        }
        if (isdefined(player.pers["team"]) && player.pers["team"] == team) {
            player thread function_419e790f(self.pers["music"].returnstate, wait_time);
            /#
                if (getdvarint("losing") > 0) {
                    println("losing" + self.pers["losing"].returnstate + "losing" + player getentitynumber());
                }
            #/
        }
    }
}

// Namespace globallogic_audio
// Params 2, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_419e790f
// Checksum 0xec443cf2, Offset: 0x41d8
// Size: 0x1bc
function function_419e790f(nextstate, wait_time) {
    self endon(#"disconnect");
    self.pers["music"].nextstate = nextstate;
    /#
        if (getdvarint("losing") > 0) {
            println("losing" + self.pers["losing"].nextstate + "losing" + self getentitynumber());
        }
    #/
    if (!isdefined(self.pers["music"].inque)) {
        self.pers["music"].inque = 0;
    }
    if (self.pers["music"].inque) {
        return;
    }
    self.pers["music"].inque = 1;
    if (wait_time) {
        wait(wait_time);
    }
    self set_music_on_player(self.pers["music"].nextstate, 0);
    self.pers["music"].inque = 0;
}

// Namespace globallogic_audio
// Params 1, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_e008b8f9
// Checksum 0xc7c47aaf, Offset: 0x43a0
// Size: 0x2e
function function_e008b8f9(switchtype) {
    switch (switchtype) {
    case 93:
        return "halftime";
    case 94:
        return "overtime";
    default:
        return "side_switch";
    }
}

// Namespace globallogic_audio
// Params 0, eflags: 0x1 linked
// namespace_51c2821<file_0>::function_de3b188d
// Checksum 0x4beef10f, Offset: 0x43f8
// Size: 0x54
function function_de3b188d() {
    level waittill(#"game_ended");
    level util::clientnotify("pm");
    level waittill(#"sfade");
    level util::clientnotify("pmf");
}

