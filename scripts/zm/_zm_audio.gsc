#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_laststand;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/music_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_audio;

// Namespace zm_audio
// Params 0, eflags: 0x2
// Checksum 0x42d46e52, Offset: 0x758
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_audio", &__init__, undefined, undefined);
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x830ba0f9, Offset: 0x798
// Size: 0xec
function __init__() {
    clientfield::register("allplayers", "charindex", 1, 3, "int");
    clientfield::register("toplayer", "isspeaking", 1, 1, "int");
    /#
        println("vox_zmba_");
    #/
    level.var_cdd49d24 = &function_72475c49;
    level zmbvox();
    callback::on_connect(&init_audio_functions);
    level thread sndannouncer_init();
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x59d1b587, Offset: 0x890
// Size: 0x3c
function setexertvoice(exert_id) {
    self.player_exert_id = exert_id;
    self clientfield::set("charindex", self.player_exert_id);
}

// Namespace zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x1e24a43e, Offset: 0x8d8
// Size: 0x1e4
function playerexert(exert, notifywait) {
    if (!isdefined(notifywait)) {
        notifywait = 0;
    }
    if (isdefined(self.isexerting) && (isdefined(self.isspeaking) && self.isspeaking || self.isexerting)) {
        return;
    }
    if (isdefined(self.beastmode) && self.beastmode) {
        return;
    }
    id = level.exert_sounds[0][exert];
    if (isdefined(self.player_exert_id)) {
        if (!isdefined(level.exert_sounds) || !isdefined(level.exert_sounds[self.player_exert_id]) || !isdefined(level.exert_sounds[self.player_exert_id][exert])) {
            return;
        }
        if (isarray(level.exert_sounds[self.player_exert_id][exert])) {
            id = array::random(level.exert_sounds[self.player_exert_id][exert]);
        } else {
            id = level.exert_sounds[self.player_exert_id][exert];
        }
    }
    if (isdefined(id)) {
        self.isexerting = 1;
        if (notifywait) {
            self playsoundwithnotify(id, "done_exerting");
            self waittill(#"done_exerting");
            self.isexerting = 0;
            return;
        }
        self thread exert_timer();
        self playsound(id);
    }
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x6010c3fa, Offset: 0xac8
// Size: 0x38
function exert_timer() {
    self endon(#"disconnect");
    wait(randomfloatrange(1.5, 3));
    self.isexerting = 0;
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xb6e8ca47, Offset: 0xb08
// Size: 0x12c
function zmbvox() {
    level.votimer = [];
    level.vox = zmbvoxcreate();
    if (isdefined(level._zmbvoxlevelspecific)) {
        level thread [[ level._zmbvoxlevelspecific ]]();
    }
    if (isdefined(level._zmbvoxgametypespecific)) {
        level thread [[ level._zmbvoxgametypespecific ]]();
    }
    announcer_ent = spawn("script_origin", (0, 0, 0));
    level.vox zmbvoxinitspeaker("announcer", "vox_zmba_", announcer_ent);
    level.exert_sounds[0]["burp"] = "evt_belch";
    level.exert_sounds[0]["hitmed"] = "null";
    level.exert_sounds[0]["hitlrg"] = "null";
    if (isdefined(level.setupcustomcharacterexerts)) {
        [[ level.setupcustomcharacterexerts ]]();
    }
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xebfb6660, Offset: 0xc40
// Size: 0x6c
function init_audio_functions() {
    self thread zombie_behind_vox();
    self thread player_killstreak_timer();
    if (isdefined(level._custom_zombie_oh_shit_vox_func)) {
        self thread [[ level._custom_zombie_oh_shit_vox_func ]]();
        return;
    }
    self thread oh_shit_vox();
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x27dff9b7, Offset: 0xcb8
// Size: 0x2f8
function zombie_behind_vox() {
    level endon(#"unloaded");
    self endon(#"hash_3f7b661c");
    if (!isdefined(level._zbv_vox_last_update_time)) {
        level._zbv_vox_last_update_time = 0;
        level._audio_zbv_shared_ent_list = zombie_utility::get_zombie_array();
    }
    while (true) {
        wait(1);
        t = gettime();
        if (t > level._zbv_vox_last_update_time + 1000) {
            level._zbv_vox_last_update_time = t;
            level._audio_zbv_shared_ent_list = zombie_utility::get_zombie_array();
        }
        zombs = level._audio_zbv_shared_ent_list;
        played_sound = 0;
        for (i = 0; i < zombs.size; i++) {
            if (!isdefined(zombs[i])) {
                continue;
            }
            if (zombs[i].isdog) {
                continue;
            }
            dist = -106;
            z_dist = 50;
            alias = level.vox_behind_zombie;
            if (isdefined(zombs[i].zombie_move_speed)) {
                switch (zombs[i].zombie_move_speed) {
                case 17:
                    dist = -106;
                    break;
                case 15:
                    dist = -81;
                    break;
                case 16:
                    dist = -56;
                    break;
                }
            }
            if (distancesquared(zombs[i].origin, self.origin) < dist * dist) {
                yaw = self zm_utility::getyawtospot(zombs[i].origin);
                z_diff = self.origin[2] - zombs[i].origin[2];
                if ((yaw < -95 || yaw > 95) && abs(z_diff) < 50) {
                    zombs[i] notify(#"bhtn_action_notify", "behind");
                    played_sound = 1;
                    break;
                }
            }
        }
        if (played_sound) {
            wait(3.5);
        }
    }
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x96b82e50, Offset: 0xfb8
// Size: 0x16e
function oh_shit_vox() {
    self endon(#"hash_3f7b661c");
    while (true) {
        wait(1);
        players = getplayers();
        zombs = zombie_utility::get_round_enemy_array();
        if (players.size >= 1) {
            var_6c755991 = 0;
            for (i = 0; i < zombs.size; i++) {
                if (isdefined(zombs[i].favoriteenemy) && zombs[i].favoriteenemy == self || !isdefined(zombs[i].favoriteenemy)) {
                    if (distancesquared(zombs[i].origin, self.origin) < 62500) {
                        var_6c755991++;
                    }
                }
            }
            if (var_6c755991 > 4) {
                self create_and_play_dialog("general", "oh_shit");
                wait(4);
            }
        }
    }
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x3b238d26, Offset: 0x1130
// Size: 0x1e0
function player_killstreak_timer() {
    self endon(#"disconnect");
    self endon(#"death");
    if (getdvarstring("zombie_kills") == "") {
        setdvar("zombie_kills", "7");
    }
    if (getdvarstring("zombie_kill_timer") == "") {
        setdvar("zombie_kill_timer", "5");
    }
    kills = getdvarint("zombie_kills");
    time = getdvarint("zombie_kill_timer");
    if (!isdefined(self.timerisrunning)) {
        self.timerisrunning = 0;
        self.killcounter = 0;
    }
    while (true) {
        zomb = self waittill(#"zom_kill");
        if (isdefined(zomb._black_hole_bomb_collapse_death) && zomb._black_hole_bomb_collapse_death == 1) {
            continue;
        }
        if (isdefined(zomb.microwavegun_death) && zomb.microwavegun_death) {
            continue;
        }
        self.killcounter++;
        if (self.timerisrunning != 1) {
            self.timerisrunning = 1;
            self thread timer_actual(kills, time);
        }
    }
}

// Namespace zm_audio
// Params 4, eflags: 0x1 linked
// Checksum 0xb068737e, Offset: 0x1318
// Size: 0x1b4
function player_zombie_kill_vox(hit_location, player, mod, zombie) {
    weapon = player getcurrentweapon();
    dist = distancesquared(player.origin, zombie.origin);
    if (!isdefined(level.zombie_vars[player.team]["zombie_insta_kill"])) {
        level.zombie_vars[player.team]["zombie_insta_kill"] = 0;
    }
    instakill = level.zombie_vars[player.team]["zombie_insta_kill"];
    death = [[ level.var_cdd49d24 ]](hit_location, mod, weapon, zombie, instakill, dist, player);
    if (!isdefined(death)) {
        return undefined;
    }
    if (!(isdefined(player.var_cc7fd45a) && player.var_cc7fd45a)) {
        player.var_cc7fd45a = 1;
        player create_and_play_dialog("kill", death);
        wait(2);
        if (isdefined(player)) {
            player.var_cc7fd45a = 0;
        }
    }
}

// Namespace zm_audio
// Params 1, eflags: 0x0
// Checksum 0x2def7c6, Offset: 0x14d8
// Size: 0x30
function function_680098e2(event) {
    if (!isdefined(level.var_e49426f6[event])) {
        return 0;
    }
    return level.var_e49426f6[event];
}

// Namespace zm_audio
// Params 7, eflags: 0x1 linked
// Checksum 0x6a6bcb82, Offset: 0x1510
// Size: 0x36a
function function_72475c49(impact, mod, weapon, zombie, instakill, dist, player) {
    close_dist = 4096;
    med_dist = 15376;
    far_dist = 160000;
    if (weapon.name == "hero_annihilator") {
        return "annihilator";
    }
    if (zm_utility::is_placeable_mine(weapon)) {
        if (!instakill) {
            return "betty";
        } else {
            return "weapon_instakill";
        }
    }
    if (zombie.damageweapon.name == "cymbal_monkey") {
        if (instakill) {
            return "weapon_instakill";
        } else {
            return "monkey";
        }
    }
    if (weapon.name == "ray_gun" && dist > far_dist) {
        if (!instakill) {
            return "raygun";
        } else {
            return "weapon_instakill";
        }
    }
    if (zm_utility::is_headshot(weapon, impact, mod) && dist >= far_dist) {
        return "headshot";
    }
    if ((mod == "MOD_MELEE" || mod == "MOD_UNKNOWN") && dist < close_dist) {
        if (!instakill) {
            return "melee";
        } else {
            return "melee_instakill";
        }
    }
    if (zm_utility::is_explosive_damage(mod) && weapon.name != "ray_gun" && !(isdefined(zombie.is_on_fire) && zombie.is_on_fire)) {
        if (!instakill) {
            return "explosive";
        } else {
            return "weapon_instakill";
        }
    }
    if (mod == "MOD_BURNED" || mod == "MOD_GRENADE" || weapon.doesfiredamage && mod == "MOD_GRENADE_SPLASH") {
        if (!instakill) {
            return "flame";
        } else {
            return "weapon_instakill";
        }
    }
    if (!isdefined(impact)) {
        impact = "";
    }
    if (mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET") {
        if (!instakill) {
            return "bullet";
        } else {
            return "weapon_instakill";
        }
    }
    if (instakill) {
        return "default";
    }
    if (mod != "MOD_MELEE" && zombie.missinglegs) {
        return "crawler";
    }
    if (mod != "MOD_BURNED" && dist < close_dist) {
        return "close";
    }
    return "default";
}

// Namespace zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0xdf07c9c, Offset: 0x1888
// Size: 0xd0
function timer_actual(kills, time) {
    self endon(#"disconnect");
    self endon(#"death");
    timer = gettime() + time * 1000;
    while (gettime() < timer) {
        if (self.killcounter > kills) {
            self create_and_play_dialog("kill", "streak");
            wait(1);
            self.killcounter = 0;
            timer = -1;
        }
        wait(0.1);
    }
    wait(10);
    self.killcounter = 0;
    self.timerisrunning = 0;
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xa2589b20, Offset: 0x1960
// Size: 0x34
function zmbvoxcreate() {
    vox = spawnstruct();
    vox.speaker = [];
    return vox;
}

// Namespace zm_audio
// Params 3, eflags: 0x1 linked
// Checksum 0xffcc5613, Offset: 0x19a0
// Size: 0xb4
function zmbvoxinitspeaker(speaker, prefix, ent) {
    ent.zmbvoxid = speaker;
    if (!isdefined(self.speaker[speaker])) {
        self.speaker[speaker] = spawnstruct();
        self.speaker[speaker].alias = [];
    }
    self.speaker[speaker].prefix = prefix;
    self.speaker[speaker].ent = ent;
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0xe97141b5, Offset: 0x1a60
// Size: 0x4e
function custom_kill_damaged_vo(player) {
    self notify(#"sound_damage_player_updated");
    self endon(#"death");
    self endon(#"sound_damage_player_updated");
    self.sound_damage_player = player;
    wait(2);
    self.sound_damage_player = undefined;
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x420ac1dc, Offset: 0x1ab8
// Size: 0x23c
function loadplayervoicecategories(table) {
    level.votimer = [];
    level.sndplayervox = [];
    index = 0;
    for (row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index)) {
        category = checkstringvalid(row[0]);
        subcategory = checkstringvalid(row[1]);
        suffix = checkstringvalid(row[2]);
        percentage = int(row[3]);
        if (percentage <= 0) {
            percentage = 100;
        }
        response = checkstringtrue(row[4]);
        if (isdefined(response) && response) {
            for (i = 0; i < 4; i++) {
                zmbvoxadd(category, subcategory + "_resp_" + i, suffix + "_resp_" + i, 50, 0);
            }
        }
        var_92f83987 = checkintvalid(row[5]);
        zmbvoxadd(category, subcategory, suffix, percentage, response, var_92f83987);
        index++;
    }
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x229354a2, Offset: 0x1d00
// Size: 0x24
function checkstringvalid(str) {
    if (str != "") {
        return str;
    }
    return undefined;
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0xf88a98b7, Offset: 0x1d30
// Size: 0x58
function checkstringtrue(str) {
    if (!isdefined(str)) {
        return false;
    }
    if (str != "") {
        if (tolower(str) == "true") {
            return true;
        }
    }
    return false;
}

// Namespace zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x7817d175, Offset: 0x1d90
// Size: 0x62
function checkintvalid(value, defaultvalue) {
    if (!isdefined(defaultvalue)) {
        defaultvalue = 0;
    }
    if (!isdefined(value)) {
        return defaultvalue;
    }
    if (value == "") {
        return defaultvalue;
    }
    return int(value);
}

// Namespace zm_audio
// Params 6, eflags: 0x1 linked
// Checksum 0x9b960c06, Offset: 0x1e00
// Size: 0x1f4
function zmbvoxadd(category, subcategory, suffix, percentage, response, var_92f83987) {
    if (!isdefined(var_92f83987)) {
        var_92f83987 = 0;
    }
    /#
        assert(isdefined(category));
    #/
    /#
        assert(isdefined(subcategory));
    #/
    /#
        assert(isdefined(suffix));
    #/
    /#
        assert(isdefined(percentage));
    #/
    /#
        assert(isdefined(response));
    #/
    /#
        assert(isdefined(var_92f83987));
    #/
    vox = level.sndplayervox;
    if (!isdefined(vox[category])) {
        vox[category] = [];
    }
    vox[category][subcategory] = spawnstruct();
    vox[category][subcategory].suffix = suffix;
    vox[category][subcategory].percentage = percentage;
    vox[category][subcategory].response = response;
    vox[category][subcategory].var_92f83987 = var_92f83987;
    zm_utility::function_a9e0d67d(subcategory);
}

// Namespace zm_audio
// Params 3, eflags: 0x1 linked
// Checksum 0xf6a81c8f, Offset: 0x2000
// Size: 0x224
function create_and_play_dialog(category, subcategory, force_variant) {
    if (!isdefined(level.sndplayervox)) {
        return;
    }
    if (!isdefined(level.sndplayervox[category])) {
        return;
    }
    if (!isdefined(level.sndplayervox[category][subcategory])) {
        /#
            if (getdvarint("vox_zmba_") > 0) {
                println("vox_zmba_" + category + "vox_zmba_" + subcategory + "vox_zmba_");
            }
        #/
        return;
    }
    if (isdefined(self.isspeaking) && self.isspeaking && (isdefined(level.sndvoxoverride) && level.sndvoxoverride || !(isdefined(self.b_wait_if_busy) && self.b_wait_if_busy))) {
        return;
    }
    suffix = level.sndplayervox[category][subcategory].suffix;
    percentage = level.sndplayervox[category][subcategory].percentage;
    prefix = shouldplayerspeak(self, category, subcategory, percentage);
    if (!isdefined(prefix)) {
        return;
    }
    sound_to_play = self zmbvoxgetlinevariant(prefix, suffix, force_variant);
    if (isdefined(sound_to_play)) {
        self thread do_player_or_npc_playvox(sound_to_play, category, subcategory);
        return;
    }
    /#
        if (getdvarint("vox_zmba_") > 0) {
            iprintln("vox_zmba_");
        }
    #/
}

// Namespace zm_audio
// Params 3, eflags: 0x1 linked
// Checksum 0x958e9326, Offset: 0x2230
// Size: 0x32c
function do_player_or_npc_playvox(sound_to_play, category, subcategory) {
    self endon(#"hash_3f7b661c");
    if (self flag::exists("in_beastmode") && self flag::get("in_beastmode")) {
        return;
    }
    if (!isdefined(self.isspeaking)) {
        self.isspeaking = 0;
    }
    if (self.isspeaking) {
        return;
    }
    waittime = 1;
    if (isdefined(self.var_b814918f) && (!self function_bbc477e0() || self.var_b814918f)) {
        self.var_6d3681c9 = sound_to_play;
        self.isspeaking = 1;
        if (isplayer(self)) {
            self clientfield::set_to_player("isspeaking", 1);
        }
        playbacktime = soundgetplaybacktime(sound_to_play);
        if (!isdefined(playbacktime)) {
            return;
        }
        if (playbacktime >= 0) {
            playbacktime *= 0.001;
        } else {
            playbacktime = 1;
        }
        if (isdefined(level.var_c71571c2)) {
            self thread [[ level.var_c71571c2 ]](sound_to_play, playbacktime);
            wait(playbacktime);
        } else if (!self istestclient()) {
            self playsoundontag(sound_to_play, "J_Head");
            wait(playbacktime);
        }
        if (isplayer(self) && isdefined(self.last_vo_played_time)) {
            if (gettime() < self.last_vo_played_time + 5000) {
                self.last_vo_played_time = gettime();
                waittime = 7;
            }
        }
        wait(waittime);
        self.isspeaking = 0;
        if (isplayer(self)) {
            self clientfield::set_to_player("isspeaking", 0);
        }
        if (isdefined(level.sndplayervox[category][subcategory].response) && !level flag::get("solo_game") && level.sndplayervox[category][subcategory].response) {
            if (isdefined(level.var_28d3a005) && level.var_28d3a005) {
                level thread function_30e81bf6(self, category, subcategory);
                return;
            }
            level thread function_1de60453(self, category, subcategory);
        }
    }
}

// Namespace zm_audio
// Params 3, eflags: 0x1 linked
// Checksum 0xf039dd3c, Offset: 0x2568
// Size: 0x12e
function function_30e81bf6(player, category, subcategory) {
    if (isdefined(level.var_952917ef)) {
        self thread [[ level.var_952917ef ]](player, category, subcategory);
        return;
    }
    switch (player.characterindex) {
    case 0:
        level function_c7269cc6(player, 1, 2, category, subcategory);
        break;
    case 1:
        level function_c7269cc6(player, 2, 3, category, subcategory);
        break;
    case 3:
        level function_c7269cc6(player, 0, 1, category, subcategory);
        break;
    case 2:
        level function_c7269cc6(player, 3, 0, category, subcategory);
        break;
    }
}

// Namespace zm_audio
// Params 5, eflags: 0x1 linked
// Checksum 0x1fb0577e, Offset: 0x26a0
// Size: 0x2dc
function function_c7269cc6(player, hero, var_ae6ba8db, category, type) {
    players = getplayers();
    var_619b5ef3 = undefined;
    var_8b94ed31 = undefined;
    foreach (ent in players) {
        if (ent.characterindex == hero) {
            var_619b5ef3 = ent;
            continue;
        }
        if (ent.characterindex == var_ae6ba8db) {
            var_8b94ed31 = ent;
        }
    }
    if (isdefined(var_619b5ef3) && isdefined(var_8b94ed31)) {
        if (randomint(100) > 50) {
            var_619b5ef3 = undefined;
        } else {
            var_8b94ed31 = undefined;
        }
    }
    if (isdefined(var_619b5ef3) && distancesquared(player.origin, var_619b5ef3.origin) < 250000) {
        if (isdefined(player.var_9bbd16b8) && player.var_9bbd16b8) {
            var_619b5ef3 create_and_play_dialog(category, type + "_s");
        } else {
            var_619b5ef3 create_and_play_dialog(category, type + "_hr");
        }
        return;
    }
    if (isdefined(var_8b94ed31) && distancesquared(player.origin, var_8b94ed31.origin) < 250000) {
        if (isdefined(player.var_9bbd16b8) && player.var_9bbd16b8) {
            var_8b94ed31 create_and_play_dialog(category, type + "_s");
            return;
        }
        var_8b94ed31 create_and_play_dialog(category, type + "_riv");
    }
}

// Namespace zm_audio
// Params 3, eflags: 0x1 linked
// Checksum 0xf3e7aece, Offset: 0x2988
// Size: 0x114
function function_1de60453(player, category, subcategory) {
    players = array::get_all_closest(player.origin, level.activeplayers);
    var_444b6d7a = array::exclude(players, player);
    if (var_444b6d7a.size == 0) {
        return;
    }
    var_718695a0 = var_444b6d7a[0];
    if (distancesquared(player.origin, var_718695a0.origin) < 250000) {
        var_718695a0 create_and_play_dialog(category, subcategory + "_resp_" + player.characterindex);
    }
}

// Namespace zm_audio
// Params 4, eflags: 0x1 linked
// Checksum 0xe6b8352c, Offset: 0x2aa8
// Size: 0x1cc
function shouldplayerspeak(player, category, subcategory, percentage) {
    if (!isdefined(player)) {
        return undefined;
    }
    if (!player zm_utility::is_player()) {
        return undefined;
    }
    if (player zm_utility::is_player()) {
        if (player.sessionstate != "playing") {
            return undefined;
        }
        if (subcategory != "revive_down" || player laststand::player_is_in_laststand() && subcategory != "revive_up") {
            return undefined;
        }
        if (player isplayerunderwater()) {
            return undefined;
        }
    }
    if (isdefined(player.dontspeak) && player.dontspeak) {
        return undefined;
    }
    if (percentage < randomintrange(1, 101)) {
        return undefined;
    }
    if (isvoxoncooldown(player, category, subcategory)) {
        return undefined;
    }
    index = zm_utility::get_player_index(player);
    if (isdefined(player.var_9bbd16b8) && player.var_9bbd16b8) {
        index = 4;
    }
    return "vox_plr_" + index + "_";
}

// Namespace zm_audio
// Params 3, eflags: 0x1 linked
// Checksum 0x4389c05a, Offset: 0x2c80
// Size: 0x124
function isvoxoncooldown(player, category, subcategory) {
    if (level.sndplayervox[category][subcategory].var_92f83987 <= 0) {
        return false;
    }
    fullname = category + subcategory;
    if (!isdefined(player.voxtimer)) {
        player.voxtimer = [];
    }
    if (!isdefined(player.voxtimer[fullname])) {
        player.voxtimer[fullname] = gettime();
        return false;
    }
    time = gettime();
    if (time - player.voxtimer[fullname] <= level.sndplayervox[category][subcategory].var_92f83987 * 1000) {
        return true;
    }
    player.voxtimer[fullname] = time;
    return false;
}

// Namespace zm_audio
// Params 3, eflags: 0x1 linked
// Checksum 0x1b9e86eb, Offset: 0x2db0
// Size: 0x20a
function zmbvoxgetlinevariant(prefix, suffix, force_variant) {
    if (!isdefined(self.sound_dialog)) {
        self.sound_dialog = [];
        self.sound_dialog_available = [];
    }
    if (!isdefined(self.sound_dialog[suffix])) {
        num_variants = zm_spawner::get_number_variants(prefix + suffix);
        if (num_variants <= 0) {
            /#
                if (getdvarint("vox_zmba_") > 0) {
                    println("vox_zmba_" + prefix + suffix);
                }
            #/
            return undefined;
        }
        for (i = 0; i < num_variants; i++) {
            self.sound_dialog[suffix][i] = i;
        }
        self.sound_dialog_available[suffix] = [];
    }
    if (self.sound_dialog_available[suffix].size <= 0) {
        for (i = 0; i < self.sound_dialog[suffix].size; i++) {
            self.sound_dialog_available[suffix][i] = self.sound_dialog[suffix][i];
        }
    }
    variation = array::random(self.sound_dialog_available[suffix]);
    arrayremovevalue(self.sound_dialog_available[suffix], variation);
    if (isdefined(force_variant)) {
        variation = force_variant;
    }
    return prefix + suffix + "_" + variation;
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0xd5b923ad, Offset: 0x2fc8
// Size: 0x1ae
function function_bbc477e0(radius) {
    if (!isdefined(radius)) {
        radius = 1000;
    }
    var_b0cd6f41 = 0;
    speakers = getplayers();
    foreach (person in speakers) {
        if (self == person) {
            continue;
        }
        if (person zm_utility::is_player()) {
            if (person.sessionstate != "playing") {
                continue;
            }
            if (person laststand::player_is_in_laststand()) {
                continue;
            }
        }
        if (isdefined(person.isspeaking) && person.isspeaking && !(isdefined(person.var_b814918f) && person.var_b814918f)) {
            if (distancesquared(self.origin, person.origin) < radius * radius) {
                var_b0cd6f41 = 1;
            }
        }
    }
    return var_b0cd6f41;
}

// Namespace zm_audio
// Params 8, eflags: 0x1 linked
// Checksum 0xd95fdc5f, Offset: 0x3180
// Size: 0x2c4
function musicstate_create(statename, playtype, musname1, musname2, musname3, musname4, musname5, musname6) {
    if (!isdefined(playtype)) {
        playtype = 1;
    }
    if (!isdefined(level.musicsystem)) {
        level.musicsystem = spawnstruct();
        level.musicsystem.queue = 0;
        level.musicsystem.currentplaytype = 0;
        level.musicsystem.currentset = undefined;
        level.musicsystem.states = [];
    }
    level.musicsystem.states[statename] = spawnstruct();
    level.musicsystem.states[statename].playtype = playtype;
    level.musicsystem.states[statename].musarray = array();
    if (isdefined(musname1)) {
        array::add(level.musicsystem.states[statename].musarray, musname1);
    }
    if (isdefined(musname2)) {
        array::add(level.musicsystem.states[statename].musarray, musname2);
    }
    if (isdefined(musname3)) {
        array::add(level.musicsystem.states[statename].musarray, musname3);
    }
    if (isdefined(musname4)) {
        array::add(level.musicsystem.states[statename].musarray, musname4);
    }
    if (isdefined(musname5)) {
        array::add(level.musicsystem.states[statename].musarray, musname5);
    }
    if (isdefined(musname6)) {
        array::add(level.musicsystem.states[statename].musarray, musname6);
    }
}

// Namespace zm_audio
// Params 4, eflags: 0x0
// Checksum 0x7e4f223c, Offset: 0x3450
// Size: 0x1d4
function function_4a63e15e(state, statename, playtype, delay) {
    if (!isdefined(playtype)) {
        playtype = 1;
    }
    if (!isdefined(delay)) {
        delay = 0;
    }
    if (!isdefined(level.musicsystem)) {
        level.musicsystem = spawnstruct();
        level.musicsystem.ent = spawn("script_origin", (0, 0, 0));
        level.musicsystem.queue = 0;
        level.musicsystem.currentplaytype = 0;
        level.musicsystem.currentstate = undefined;
        level.musicsystem.states = [];
    }
    m = level.musicsystem;
    if (!isdefined(m.states[state])) {
        m.states[state] = spawnstruct();
        m.states[state] = array();
    }
    m.states[state][m.states[state].size].statename = statename;
    m.states[state][m.states[state].size].playtype = playtype;
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x17260107, Offset: 0x3630
// Size: 0x1b4
function sndmusicsystem_playstate(state) {
    if (!isdefined(level.musicsystem)) {
        return;
    }
    m = level.musicsystem;
    if (!isdefined(m.states[state])) {
        return;
    }
    s = level.musicsystem.states[state];
    playtype = s.playtype;
    if (m.currentplaytype > 0) {
        if (playtype == 1) {
            return;
        } else if (playtype == 2) {
            level thread sndmusicsystem_queuestate(state);
        } else if (playtype == 3 && (playtype > m.currentplaytype || m.currentplaytype == 3)) {
            if (isdefined(level.musicsystemoverride) && level.musicsystemoverride && playtype != 5) {
                return;
            } else {
                level sndmusicsystem_stopandflush();
                level thread playstate(state);
            }
        }
        return;
    }
    if (!(isdefined(level.musicsystemoverride) && level.musicsystemoverride) || playtype == 5) {
        level thread playstate(state);
    }
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0xd6a025bf, Offset: 0x37f0
// Size: 0x1f6
function playstate(state) {
    level endon(#"sndstatestop");
    m = level.musicsystem;
    musarray = level.musicsystem.states[state].musarray;
    if (musarray.size <= 0) {
        return;
    }
    mustoplay = musarray[randomintrange(0, musarray.size)];
    m.currentplaytype = m.states[state].playtype;
    m.currentstate = state;
    wait(0.1);
    if (isdefined(level.sndplaystateoverride)) {
        perplayer = level [[ level.sndplaystateoverride ]](state);
        if (!(isdefined(perplayer) && perplayer)) {
            music::setmusicstate(mustoplay);
        }
    } else {
        music::setmusicstate(mustoplay);
    }
    aliasname = "mus_" + mustoplay + "_intro";
    playbacktime = soundgetplaybacktime(aliasname);
    if (!isdefined(playbacktime) || playbacktime <= 0) {
        waittime = 1;
    } else {
        waittime = playbacktime * 0.001;
    }
    wait(waittime);
    m.currentplaytype = 0;
    m.currentstate = undefined;
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x10fe1281, Offset: 0x39f0
// Size: 0xec
function sndmusicsystem_queuestate(state) {
    level endon(#"sndqueueflush");
    m = level.musicsystem;
    count = 0;
    if (isdefined(m.queue) && m.queue) {
        return;
    }
    m.queue = 1;
    while (m.currentplaytype > 0) {
        wait(0.5);
        count++;
        if (count >= 25) {
            m.queue = 0;
            return;
        }
    }
    level thread playstate(state);
    m.queue = 0;
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x7b074426, Offset: 0x3ae8
// Size: 0x52
function sndmusicsystem_stopandflush() {
    level notify(#"sndqueueflush");
    level.musicsystem.queue = 0;
    level notify(#"sndstatestop");
    level.musicsystem.currentplaytype = 0;
    level.musicsystem.currentstate = undefined;
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x1d7cd718, Offset: 0x3b48
// Size: 0x4c
function sndmusicsystem_isabletoplay() {
    if (!isdefined(level.musicsystem)) {
        return false;
    }
    if (!isdefined(level.musicsystem.currentplaytype)) {
        return false;
    }
    if (level.musicsystem.currentplaytype >= 4) {
        return false;
    }
    return true;
}

// Namespace zm_audio
// Params 1, eflags: 0x0
// Checksum 0xaf6e6a86, Offset: 0x3ba0
// Size: 0x54
function function_3b328a67(var_ab59bedf) {
    if (!isdefined(var_ab59bedf) || var_ab59bedf.size <= 0) {
        return;
    }
    level.musicsystem.var_ab59bedf = var_ab59bedf;
    level thread function_f8cbdf9(var_ab59bedf);
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x8a26eb8f, Offset: 0x3c00
// Size: 0xfc
function function_f8cbdf9(var_ab59bedf) {
    var_32d2281 = 0;
    level.var_74382d64 = undefined;
    m = level.musicsystem;
    while (true) {
        activezone = level waittill(#"newzoneactive");
        wait(0.1);
        if (!function_3459a7ac(var_ab59bedf, activezone)) {
            continue;
        }
        level thread sndmusicsystem_playstate(activezone);
        var_ab59bedf = function_755b5e07(var_ab59bedf, activezone, var_32d2281, 3);
        level.var_74382d64 = activezone;
        if (var_32d2281 >= 3) {
            var_32d2281 = 0;
        } else {
            var_32d2281++;
        }
        level waittill(#"between_round_over");
    }
}

// Namespace zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0xbf707041, Offset: 0x3d08
// Size: 0x128
function function_3459a7ac(array, activezone) {
    var_97e27c72 = 0;
    if (level.musicsystem.currentplaytype >= 3) {
        level thread function_b55a93f8(activezone);
        return var_97e27c72;
    }
    foreach (place in array) {
        if (place == activezone) {
            var_97e27c72 = 1;
        }
    }
    if (var_97e27c72 == 0) {
        return var_97e27c72;
    }
    if (zm_zonemgr::any_player_in_zone(activezone)) {
        var_97e27c72 = 1;
    } else {
        var_97e27c72 = 0;
    }
    return var_97e27c72;
}

// Namespace zm_audio
// Params 4, eflags: 0x1 linked
// Checksum 0x1e12a154, Offset: 0x3e38
// Size: 0xea
function function_755b5e07(var_6437472a, activezone, var_32d2281, num) {
    if (var_32d2281 >= num) {
        var_6437472a = level.musicsystem.var_ab59bedf;
    }
    foreach (place in var_6437472a) {
        if (place == activezone) {
            arrayremovevalue(var_6437472a, place);
            break;
        }
    }
    return var_6437472a;
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x1171b9e8, Offset: 0x3f30
// Size: 0x4e
function function_b55a93f8(zone) {
    level endon(#"newzoneactive");
    while (level.musicsystem.currentplaytype >= 3) {
        wait(0.5);
    }
    level notify(#"newzoneactive", zone);
}

// Namespace zm_audio
// Params 6, eflags: 0x1 linked
// Checksum 0x28aec4e4, Offset: 0x3f88
// Size: 0x30a
function sndmusicsystem_eesetup(state, origin1, origin2, origin3, origin4, origin5) {
    sndeearray = array();
    if (isdefined(origin1)) {
        if (!isdefined(sndeearray)) {
            sndeearray = [];
        } else if (!isarray(sndeearray)) {
            sndeearray = array(sndeearray);
        }
    }
    sndeearray[sndeearray.size] = origin1;
    if (isdefined(origin2)) {
        if (!isdefined(sndeearray)) {
            sndeearray = [];
        } else if (!isarray(sndeearray)) {
            sndeearray = array(sndeearray);
        }
    }
    sndeearray[sndeearray.size] = origin2;
    if (isdefined(origin3)) {
        if (!isdefined(sndeearray)) {
            sndeearray = [];
        } else if (!isarray(sndeearray)) {
            sndeearray = array(sndeearray);
        }
    }
    sndeearray[sndeearray.size] = origin3;
    if (isdefined(origin4)) {
        if (!isdefined(sndeearray)) {
            sndeearray = [];
        } else if (!isarray(sndeearray)) {
            sndeearray = array(sndeearray);
        }
    }
    sndeearray[sndeearray.size] = origin4;
    if (isdefined(origin5)) {
        if (!isdefined(sndeearray)) {
            sndeearray = [];
        } else if (!isarray(sndeearray)) {
            sndeearray = array(sndeearray);
        }
    }
    sndeearray[sndeearray.size] = origin5;
    if (sndeearray.size > 0) {
        level.sndeemax = sndeearray.size;
        level.sndeecount = 0;
        foreach (origin in sndeearray) {
            level thread sndmusicsystem_eewait(origin, state);
        }
    }
}

// Namespace zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x19f65af0, Offset: 0x42a0
// Size: 0x144
function sndmusicsystem_eewait(origin, state) {
    temp_ent = spawn("script_origin", origin);
    temp_ent playloopsound("zmb_meteor_loop");
    temp_ent thread secretuse("main_music_egg_hit", (0, 255, 0), &sndmusicsystem_eeoverride);
    player = temp_ent waittill(#"main_music_egg_hit");
    temp_ent stoploopsound(1);
    player playsound("zmb_meteor_activate");
    level.sndeecount++;
    if (level.sndeecount >= level.sndeemax) {
        level notify(#"hash_a1b1dadb");
        level thread sndmusicsystem_playstate(state);
    }
    temp_ent delete();
}

// Namespace zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x498e176d, Offset: 0x43f0
// Size: 0x48
function sndmusicsystem_eeoverride(arg1, arg2) {
    if (isdefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4) {
        return false;
    }
    return true;
}

// Namespace zm_audio
// Params 5, eflags: 0x1 linked
// Checksum 0x81adc26d, Offset: 0x4440
// Size: 0x1a8
function secretuse(notify_string, color, qualifier_func, arg1, arg2) {
    waittillframeend();
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        /#
            print3d(self.origin, "vox_zmba_", color, 1);
        #/
        players = level.players;
        foreach (player in players) {
            qualifier_passed = 1;
            if (isdefined(qualifier_func)) {
                qualifier_passed = player [[ qualifier_func ]](arg1, arg2);
            }
            if (qualifier_passed && distancesquared(self.origin, player.origin) < 4096) {
                if (player laststand::is_facing(self)) {
                    if (player usebuttonpressed()) {
                        self notify(notify_string, player);
                        return;
                    }
                }
            }
        }
        wait(0.1);
    }
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x5e163e76, Offset: 0x45f0
// Size: 0x154
function sndannouncer_init() {
    if (!isdefined(level.zmannouncerprefix)) {
        level.zmannouncerprefix = "vox_" + "zmba" + "_";
    }
    sndannouncervoxadd("carpenter", "powerup_carpenter_0");
    sndannouncervoxadd("insta_kill", "powerup_instakill_0");
    sndannouncervoxadd("double_points", "powerup_doublepoints_0");
    sndannouncervoxadd("nuke", "powerup_nuke_0");
    sndannouncervoxadd("full_ammo", "powerup_maxammo_0");
    sndannouncervoxadd("fire_sale", "powerup_firesale_0");
    sndannouncervoxadd("minigun", "powerup_death_machine_0");
    sndannouncervoxadd("boxmove", "event_magicbox_0");
    sndannouncervoxadd("dogstart", "event_dogstart_0");
}

// Namespace zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0xab47a598, Offset: 0x4750
// Size: 0x4e
function sndannouncervoxadd(type, suffix) {
    if (!isdefined(level.zmannouncervox)) {
        level.zmannouncervox = array();
    }
    level.zmannouncervox[type] = suffix;
}

// Namespace zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x7c6ad48b, Offset: 0x47a8
// Size: 0x154
function sndannouncerplayvox(type, player) {
    if (!isdefined(level.zmannouncervox[type])) {
        return;
    }
    prefix = level.zmannouncerprefix;
    suffix = level.zmannouncervox[type];
    if (!(isdefined(level.zmannouncertalking) && level.zmannouncertalking)) {
        if (!isdefined(player)) {
            level.zmannouncertalking = 1;
            temp_ent = spawn("script_origin", (0, 0, 0));
            temp_ent playsoundwithnotify(prefix + suffix, prefix + suffix + "wait");
            temp_ent waittill(prefix + suffix + "wait");
            wait(0.05);
            temp_ent delete();
            level.zmannouncertalking = 0;
            return;
        }
        player playsoundtoplayer(prefix + suffix, player);
    }
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x45b62a5e, Offset: 0x4908
// Size: 0x2ea
function zmbaivox_notifyconvert() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"game_ended");
    self thread zmbaivox_playdeath();
    self thread zmbaivox_playelectrocution();
    while (true) {
        notify_string = self waittill(#"bhtn_action_notify");
        switch (notify_string) {
        case 100:
            level thread zmbaivox_playvox(self, notify_string, 1, 9);
            break;
        case 98:
            if (isdefined(self.bgb_tone_death) && self.bgb_tone_death) {
                level thread zmbaivox_playvox(self, "death_whimsy", 1, 10);
            } else {
                level thread zmbaivox_playvox(self, notify_string, 1, 10);
            }
            break;
        case 18:
            level thread zmbaivox_playvox(self, notify_string, 1, 9);
            break;
        case 95:
            if (self.animname != "zombie" && (!isdefined(self.animname) || self.animname != "quad_zombie")) {
                level thread zmbaivox_playvox(self, notify_string, 1, 8, 1);
            }
            break;
        case 97:
            level thread zmbaivox_playvox(self, "attack_melee", 1, 8, 1);
            break;
        case 99:
            level thread zmbaivox_playvox(self, notify_string, 1, 7);
            break;
        case 51:
            level thread zmbaivox_playvox(self, notify_string, 1, 6);
            break;
        case 96:
        case 50:
        case 16:
        case 101:
        case 102:
            level thread zmbaivox_playvox(self, notify_string, 0);
            break;
        default:
            if (isdefined(level.var_6bda12f0)) {
                if (isdefined(level.var_6bda12f0[notify_string])) {
                    level thread zmbaivox_playvox(self, notify_string, 0);
                }
            }
            break;
        }
    }
}

// Namespace zm_audio
// Params 5, eflags: 0x1 linked
// Checksum 0x3a8838c8, Offset: 0x4c00
// Size: 0x370
function zmbaivox_playvox(zombie, type, override, priority, delayambientvox) {
    if (!isdefined(delayambientvox)) {
        delayambientvox = 0;
    }
    zombie endon(#"death");
    if (!isdefined(zombie)) {
        return;
    }
    if (!isdefined(zombie.voiceprefix)) {
        return;
    }
    if (!isdefined(priority)) {
        priority = 1;
    }
    if (!isdefined(zombie.currentvoxpriority)) {
        zombie.currentvoxpriority = 1;
    }
    if (!isdefined(self.delayambientvox)) {
        self.delayambientvox = 0;
    }
    if (isdefined(self.delayambientvox) && (type == "ambient" || type == "sprint" || type == "crawler") && self.delayambientvox) {
        return;
    }
    if (delayambientvox) {
        self.delayambientvox = 1;
        self thread zmbaivox_ambientdelay();
    }
    alias = "zmb_vocals_" + zombie.voiceprefix + "_" + type;
    if (sndisnetworksafe()) {
        if (isdefined(override) && override) {
            if (isdefined(zombie.currentvox) && priority > zombie.currentvoxpriority) {
                zombie stopsound(zombie.currentvox);
            }
            if (type == "death" || type == "death_whimsy") {
                zombie playsound(alias);
                return;
            }
        }
        if (zombie.talking === 1 && priority < zombie.currentvoxpriority) {
            return;
        }
        zombie.talking = 1;
        if (zombie is_last_zombie() && type == "ambient") {
            alias += "_loud";
        }
        zombie.currentvox = alias;
        zombie.currentvoxpriority = priority;
        zombie playsoundontag(alias, "j_head");
        playbacktime = soundgetplaybacktime(alias);
        if (!isdefined(playbacktime)) {
            playbacktime = 1;
        }
        if (playbacktime >= 0) {
            playbacktime *= 0.001;
        } else {
            playbacktime = 1;
        }
        wait(playbacktime);
        zombie.talking = 0;
        zombie.currentvox = undefined;
        zombie.currentvoxpriority = 1;
    }
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x5ed9db76, Offset: 0x4f78
// Size: 0x9c
function zmbaivox_playdeath() {
    self endon(#"disconnect");
    attacker, meansofdeath = self waittill(#"death");
    if (isdefined(self)) {
        if (isdefined(self.bgb_tone_death) && self.bgb_tone_death) {
            level thread zmbaivox_playvox(self, "death_whimsy", 1);
            return;
        }
        level thread zmbaivox_playvox(self, "death", 1);
    }
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x1884f579, Offset: 0x5020
// Size: 0x10a
function zmbaivox_playelectrocution() {
    self endon(#"disconnect");
    self endon(#"death");
    while (true) {
        amount, attacker, direction_vec, point, type, tagname, modelname, partname, weapon = self waittill(#"damage");
        if (weapon.name == "zombie_beast_lightning_dwl" || weapon.name == "zombie_beast_lightning_dwl2" || weapon.name == "zombie_beast_lightning_dwl3") {
            self notify(#"bhtn_action_notify", "electrocute");
        }
    }
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xb69d0b99, Offset: 0x5138
// Size: 0x48
function zmbaivox_ambientdelay() {
    self notify(#"sndambientdelay");
    self endon(#"sndambientdelay");
    self endon(#"death");
    self endon(#"disconnect");
    wait(2);
    self.delayambientvox = 0;
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x366aa0dc, Offset: 0x5188
// Size: 0x30
function networksafereset() {
    while (true) {
        level._numzmbaivox = 0;
        util::wait_network_frame();
    }
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xb8cc1b77, Offset: 0x51c0
// Size: 0x44
function sndisnetworksafe() {
    if (!isdefined(level._numzmbaivox)) {
        level thread networksafereset();
    }
    if (level._numzmbaivox >= 2) {
        return false;
    }
    level._numzmbaivox++;
    return true;
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x504d9bce, Offset: 0x5210
// Size: 0x24
function is_last_zombie() {
    if (zombie_utility::get_current_zombie_count() <= 1) {
        return true;
    }
    return false;
}

// Namespace zm_audio
// Params 7, eflags: 0x1 linked
// Checksum 0x33228ca2, Offset: 0x5240
// Size: 0x466
function function_ff22a5f2(var_6ac79f92, var_154f146d, origin1, origin2, origin3, origin4, origin5) {
    if (!isdefined(var_154f146d)) {
        var_154f146d = 0;
    }
    radio = spawnstruct();
    radio.counter = 1;
    radio.var_6ac79f92 = var_6ac79f92;
    radio.isplaying = 0;
    radio.array = array();
    if (isdefined(origin1)) {
        if (!isdefined(radio.array)) {
            radio.array = [];
        } else if (!isarray(radio.array)) {
            radio.array = array(radio.array);
        }
    }
    radio.array[radio.array.size] = origin1;
    if (isdefined(origin2)) {
        if (!isdefined(radio.array)) {
            radio.array = [];
        } else if (!isarray(radio.array)) {
            radio.array = array(radio.array);
        }
    }
    radio.array[radio.array.size] = origin2;
    if (isdefined(origin3)) {
        if (!isdefined(radio.array)) {
            radio.array = [];
        } else if (!isarray(radio.array)) {
            radio.array = array(radio.array);
        }
    }
    radio.array[radio.array.size] = origin3;
    if (isdefined(origin4)) {
        if (!isdefined(radio.array)) {
            radio.array = [];
        } else if (!isarray(radio.array)) {
            radio.array = array(radio.array);
        }
    }
    radio.array[radio.array.size] = origin4;
    if (isdefined(origin5)) {
        if (!isdefined(radio.array)) {
            radio.array = [];
        } else if (!isarray(radio.array)) {
            radio.array = array(radio.array);
        }
    }
    radio.array[radio.array.size] = origin5;
    if (radio.array.size > 0) {
        for (i = 0; i < radio.array.size; i++) {
            level thread function_713e84b0(radio.array[i], radio, var_154f146d, i + 1);
        }
    }
}

// Namespace zm_audio
// Params 4, eflags: 0x1 linked
// Checksum 0x840aa86b, Offset: 0x56b0
// Size: 0x244
function function_713e84b0(origin, radio, var_154f146d, num) {
    temp_ent = spawn("script_origin", origin);
    temp_ent thread secretuse("sndRadioHit", (0, 0, 255), &function_9db08cfa, radio);
    player = temp_ent waittill(#"hash_678c47ee");
    if (!(isdefined(var_154f146d) && var_154f146d)) {
        var_48a5e056 = num;
    } else {
        var_48a5e056 = radio.counter;
    }
    var_aae31f82 = radio.var_6ac79f92 + var_48a5e056;
    var_c3d43d75 = zm_spawner::get_number_variants(var_aae31f82);
    if (var_c3d43d75 > 0) {
        radio.isplaying = 1;
        for (i = 0; i < var_c3d43d75; i++) {
            temp_ent playsound(var_aae31f82 + "_" + i);
            playbacktime = soundgetplaybacktime(var_aae31f82 + "_" + i);
            if (!isdefined(playbacktime)) {
                playbacktime = 1;
            }
            if (playbacktime >= 0) {
                playbacktime *= 0.001;
            } else {
                playbacktime = 1;
            }
            wait(playbacktime);
        }
    }
    radio.counter++;
    radio.isplaying = 0;
    temp_ent delete();
}

// Namespace zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0xff325d57, Offset: 0x5900
// Size: 0x3c
function function_9db08cfa(arg1, arg2) {
    if (isdefined(arg1) && arg1.isplaying == 1) {
        return false;
    }
    return true;
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xc1938ee9, Offset: 0x5948
// Size: 0xa0
function sndperksjingles_timer() {
    self endon(#"death");
    if (isdefined(self.sndjinglecooldown)) {
        self.sndjinglecooldown = 0;
    }
    while (true) {
        wait(randomfloatrange(30, 60));
        if (randomintrange(0, 100) <= 10 && !(isdefined(self.sndjinglecooldown) && self.sndjinglecooldown)) {
            self thread sndperksjingles_player(0);
        }
    }
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x5ff07620, Offset: 0x59f0
// Size: 0x180
function sndperksjingles_player(type) {
    self endon(#"death");
    if (!isdefined(self.sndjingleactive)) {
        self.sndjingleactive = 0;
    }
    alias = self.script_sound;
    if (type == 1) {
        alias = self.script_label;
    }
    if (isdefined(level.musicsystem) && level.musicsystem.currentplaytype >= 4) {
        return;
    }
    self.str_jingle_alias = alias;
    if (!(isdefined(self.sndjingleactive) && self.sndjingleactive)) {
        self.sndjingleactive = 1;
        self playsoundwithnotify(alias, "sndDone");
        playbacktime = soundgetplaybacktime(alias);
        if (!isdefined(playbacktime) || playbacktime <= 0) {
            waittime = 1;
        } else {
            waittime = playbacktime * 0.001;
        }
        wait(waittime);
        if (type == 0) {
            self.sndjinglecooldown = 1;
            self thread sndperksjingles_cooldown();
        }
        self.sndjingleactive = 0;
    }
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x23dbbb7d, Offset: 0x5b78
// Size: 0x4c
function sndperksjingles_cooldown() {
    self endon(#"death");
    if (isdefined(self.var_1afc1154)) {
        while (isdefined(self.var_1afc1154) && self.var_1afc1154) {
            wait(1);
        }
    }
    wait(45);
    self.sndjinglecooldown = 0;
}

// Namespace zm_audio
// Params 2, eflags: 0x1 linked
// Checksum 0x56ef71d6, Offset: 0x5bd0
// Size: 0x88
function function_7ab00f0c(name, var_2009b1c2) {
    if (!isdefined(var_2009b1c2)) {
        var_2009b1c2 = undefined;
    }
    if (!isdefined(level.var_dc73ca36)) {
        level.var_dc73ca36 = array();
    }
    level.var_dc73ca36[name] = spawnstruct();
    level.var_dc73ca36[name].var_2009b1c2 = var_2009b1c2;
}

// Namespace zm_audio
// Params 4, eflags: 0x1 linked
// Checksum 0xbb08d499, Offset: 0x5c60
// Size: 0x2a6
function function_80db0d1d(name, line, var_838e0a98, ignoreplayer) {
    if (!isdefined(ignoreplayer)) {
        ignoreplayer = 5;
    }
    var_4b58e3de = level.var_dc73ca36[name];
    if (!isdefined(var_4b58e3de.line)) {
        var_4b58e3de.line = array();
    }
    if (!isdefined(var_4b58e3de.player)) {
        var_4b58e3de.player = array();
    }
    if (!isdefined(var_4b58e3de.ignoreplayer)) {
        var_4b58e3de.ignoreplayer = array();
    }
    if (!isdefined(var_4b58e3de.line)) {
        var_4b58e3de.line = [];
    } else if (!isarray(var_4b58e3de.line)) {
        var_4b58e3de.line = array(var_4b58e3de.line);
    }
    var_4b58e3de.line[var_4b58e3de.line.size] = line;
    if (!isdefined(var_4b58e3de.player)) {
        var_4b58e3de.player = [];
    } else if (!isarray(var_4b58e3de.player)) {
        var_4b58e3de.player = array(var_4b58e3de.player);
    }
    var_4b58e3de.player[var_4b58e3de.player.size] = var_838e0a98;
    if (!isdefined(var_4b58e3de.ignoreplayer)) {
        var_4b58e3de.ignoreplayer = [];
    } else if (!isarray(var_4b58e3de.ignoreplayer)) {
        var_4b58e3de.ignoreplayer = array(var_4b58e3de.ignoreplayer);
    }
    var_4b58e3de.ignoreplayer[var_4b58e3de.ignoreplayer.size] = ignoreplayer;
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0xe1cbfcff, Offset: 0x5f10
// Size: 0x28e
function function_20b36810(name) {
    var_4b58e3de = level.var_dc73ca36[name];
    level endon(#"hash_27e4fddc");
    if (isdefined(var_4b58e3de.var_2009b1c2)) {
        level endon(var_4b58e3de.var_2009b1c2);
    }
    while (function_cb7b7167()) {
        wait(0.5);
    }
    while (isdefined(level.sndvoxoverride) && level.sndvoxoverride) {
        wait(0.5);
    }
    level.sndvoxoverride = 1;
    for (i = 0; i < var_4b58e3de.line.size; i++) {
        if (var_4b58e3de.player[i] == 4) {
            speaker = function_bddc5293(var_4b58e3de.ignoreplayer[i]);
        } else {
            speaker = function_f9ba8078(var_4b58e3de.player[i]);
        }
        if (!isdefined(speaker)) {
            continue;
        }
        if (function_cf2f58ce(speaker)) {
            level.var_cccba1de = speaker;
            if (isdefined(level.var_25ed710c)) {
                level.var_ae33e9c3 = var_4b58e3de.line[i];
            } else {
                level.var_ae33e9c3 = "vox_plr_" + speaker.characterindex + "_" + var_4b58e3de.line[i];
                speaker thread function_27e4fddc();
            }
            speaker playsoundontag(level.var_ae33e9c3, "J_Head");
            waitplaybacktime(level.var_ae33e9c3);
            level notify(#"hash_66031f2d");
        }
    }
    level.sndvoxoverride = 0;
    level notify(#"hash_15bea6b3");
    level.var_ae33e9c3 = undefined;
    level.var_cccba1de = undefined;
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x66a509e0, Offset: 0x61a8
// Size: 0x76
function function_f6e37de7() {
    level notify(#"hash_27e4fddc");
    level notify(#"hash_15bea6b3");
    level.sndvoxoverride = 0;
    if (isdefined(level.var_cccba1de) && isdefined(level.var_ae33e9c3)) {
        level.var_cccba1de stopsound(level.var_ae33e9c3);
        level.var_ae33e9c3 = undefined;
        level.var_cccba1de = undefined;
    }
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0xb70cdcb5, Offset: 0x6228
// Size: 0x76
function waitplaybacktime(alias) {
    playbacktime = soundgetplaybacktime(alias);
    if (!isdefined(playbacktime)) {
        playbacktime = 1;
    }
    if (playbacktime >= 0) {
        playbacktime *= 0.001;
    } else {
        playbacktime = 1;
    }
    wait(playbacktime);
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0xe56ef69f, Offset: 0x62a8
// Size: 0x66
function function_cf2f58ce(player) {
    if (!isdefined(player)) {
        return false;
    }
    if (player.sessionstate != "playing") {
        return false;
    }
    if (isdefined(player.laststand) && player.laststand) {
        return false;
    }
    return true;
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0xc6c50b99, Offset: 0x6318
// Size: 0xc6
function function_bddc5293(ignore) {
    array = level.players;
    array::randomize(array);
    foreach (guy in array) {
        if (guy.characterindex == ignore) {
            continue;
        }
        return guy;
    }
    return undefined;
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x906df99b, Offset: 0x63e8
// Size: 0x9a
function function_f9ba8078(charindex) {
    foreach (guy in level.players) {
        if (guy.characterindex == charindex) {
            return guy;
        }
    }
    return undefined;
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x91cf5572, Offset: 0x6490
// Size: 0xa0
function function_cb7b7167() {
    foreach (player in level.players) {
        if (isdefined(player.isspeaking) && player.isspeaking) {
            return true;
        }
    }
    return false;
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0xd181a787, Offset: 0x6538
// Size: 0x14c
function function_27e4fddc() {
    level endon(#"hash_66031f2d");
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        var_2ce017e2 = 0;
        var_11295a10 = self.origin;
        count = 0;
        foreach (player in level.players) {
            if (self == player) {
                continue;
            }
            if (distance2dsquared(player.origin, self.origin) >= 810000) {
                count++;
            }
        }
        if (count == level.players.size - 1) {
            break;
        }
        wait(0.25);
    }
    level thread function_f6e37de7();
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x7ba90ecd, Offset: 0x6690
// Size: 0x16c
function water_vox() {
    self endon(#"death");
    self endon(#"disconnect");
    level endon(#"end_game");
    self.voxunderwatertime = 0;
    self.voxemergebreath = 0;
    self.voxdrowning = 0;
    while (true) {
        if (self isplayerunderwater()) {
            if (!self.voxunderwatertime && !self.voxemergebreath) {
                self vo_clear_underwater();
                self.voxunderwatertime = gettime();
            } else if (self.voxunderwatertime) {
                if (gettime() > self.voxunderwatertime + 3000) {
                    self.voxunderwatertime = 0;
                    self.voxemergebreath = 1;
                }
            }
        } else {
            if (self.voxdrowning) {
                self playerexert("underwater_gasp");
                self.voxdrowning = 0;
                self.voxemergebreath = 0;
            }
            if (self.voxemergebreath) {
                self playerexert("underwater_emerge");
                self.voxemergebreath = 0;
            } else {
                self.voxunderwatertime = 0;
            }
        }
        wait(0.05);
    }
}

// Namespace zm_audio
// Params 0, eflags: 0x1 linked
// Checksum 0x3977f264, Offset: 0x6808
// Size: 0x1a4
function vo_clear_underwater() {
    if (level flag::exists("abcd_speaking")) {
        if (level flag::get("abcd_speaking")) {
            return;
        }
    }
    if (level flag::exists("shadowman_speaking")) {
        if (level flag::get("shadowman_speaking")) {
            return;
        }
    }
    self stopsounds();
    self notify(#"hash_14c495c1");
    self.str_vo_being_spoken = "";
    self.n_vo_priority = 0;
    self.isspeaking = 0;
    level.sndvoxoverride = 0;
    var_22677cee = 0;
    foreach (var_a3ddaa95 in level.var_5db32b5b) {
        if (var_a3ddaa95 == self) {
            var_22677cee = 1;
            break;
        }
    }
    if (isdefined(var_22677cee) && var_22677cee) {
        arrayremovevalue(level.var_5db32b5b, self);
    }
}

// Namespace zm_audio
// Params 4, eflags: 0x1 linked
// Checksum 0xee82d5d8, Offset: 0x69b8
// Size: 0xcc
function sndplayerhitalert(e_victim, str_meansofdeath, e_inflictor, weapon) {
    if (!(isdefined(level.var_9b27bea6) && level.var_9b27bea6)) {
        return;
    }
    if (!isplayer(self)) {
        return;
    }
    if (!checkforvalidmod(str_meansofdeath)) {
        return;
    }
    if (!checkforvalidweapon(weapon)) {
        return;
    }
    if (!checkforvalidaitype(e_victim)) {
        return;
    }
    str_alias = "zmb_hit_alert";
    self thread sndplayerhitalert_playsound(str_alias);
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x52736e3, Offset: 0x6a90
// Size: 0x58
function sndplayerhitalert_playsound(str_alias) {
    self endon(#"disconnect");
    if (self.hitsoundtracker) {
        self.hitsoundtracker = 0;
        self playsoundtoplayer(str_alias, self);
        wait(0.05);
        self.hitsoundtracker = 1;
    }
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0xe1a1b2d1, Offset: 0x6af0
// Size: 0x66
function checkforvalidmod(str_meansofdeath) {
    if (!isdefined(str_meansofdeath)) {
        return false;
    }
    switch (str_meansofdeath) {
    case 116:
    case 44:
    case 117:
    case 37:
    case 118:
    case 119:
        return false;
    }
    return true;
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x472cce52, Offset: 0x6b60
// Size: 0x10
function checkforvalidweapon(weapon) {
    return true;
}

// Namespace zm_audio
// Params 1, eflags: 0x1 linked
// Checksum 0x9e8fbc95, Offset: 0x6b78
// Size: 0x10
function checkforvalidaitype(e_victim) {
    return true;
}

