#using scripts/shared/callbacks_shared;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_equip_gasmask;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_fd83f37;

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0xe2b6c551, Offset: 0x998
// Size: 0x27c
function main() {
    level._audio_custom_weapon_check = &function_621add9;
    level._custom_intro_vox = &function_c25da5bd;
    level.var_c71571c2 = &function_be75904;
    level.player_4_vox_override = 0;
    level.var_1921c0fb = 0;
    level.var_61f315ab = &function_3630300b;
    level.var_778c3308 = [];
    level.var_778c3308["1"] = 0;
    level.var_778c3308["2a"] = 0;
    level.var_778c3308["2b"] = 0;
    level.var_778c3308["3a"] = 0;
    level.var_778c3308["3b"] = 0;
    level.var_778c3308["4a"] = 0;
    level.var_778c3308["4b"] = 0;
    level.var_778c3308["5"] = 0;
    level thread function_702b17be();
    level thread function_22ed617f();
    level thread function_d647dad9();
    level thread function_b61cf03e();
    level thread function_517d4259();
    level thread function_c7ee4bca();
    level thread function_9b02d8a0();
    level thread function_45b4acf2();
    level thread function_c844cebe();
    callback::on_spawned(&function_10ffc7d7);
    clientfield::register("allplayers", "beam_fx_audio", 21000, 1, "counter");
    clientfield::register("world", "teleporter_audio_sfx", 21000, 1, "counter");
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0xb85ea26a, Offset: 0xc20
// Size: 0x3c
function function_10ffc7d7() {
    if (!isdefined(self.var_626b83bf)) {
        self.var_626b83bf = 1;
        level thread zm_audio::sndmusicsystem_playstate("none");
    }
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0xf1f1129, Offset: 0xc68
// Size: 0x54
function function_9b02d8a0() {
    lootusedignore = struct::get_array("egg_radios", "targetname");
    array::thread_all(lootusedignore, &function_3e6de5f2);
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0x425bdb55, Offset: 0xcc8
// Size: 0x10c
function function_3e6de5f2() {
    self zm_unitrigger::create_unitrigger();
    /#
        self thread zm_utility::print3d_ent("counter", (0, 1, 0), 3, (0, 0, 24));
    #/
    while (true) {
        self waittill(#"trigger_activated");
        if (isdefined(self.script_noteworthy)) {
            breakout = self function_f5fb6ee7();
            if (breakout) {
                break;
            }
            continue;
        }
        break;
    }
    /#
        self notify(#"end_print3d");
    #/
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
    playsoundatposition("vox_story_1_log_" + self.script_int, self.origin);
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0xf112b1e4, Offset: 0xde0
// Size: 0x108
function function_f5fb6ee7() {
    if (!isdefined(level.glass)) {
        return true;
    }
    for (i = 0; i < level.glass.size; i++) {
        if (level.glass[i].damage_state == 1) {
            for (j = 0; j < level.glass[i].var_8304729d.size; j++) {
                var_56ecef90 = level.glass[i].var_8304729d[j].origin;
                if (distancesquared(var_56ecef90, self.origin) < 2500) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0xf8d7f869, Offset: 0xef0
// Size: 0x54
function function_c7ee4bca() {
    structs = struct::get_array("8bitsongs", "targetname");
    array::thread_all(structs, &function_a52e0938);
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0x7b6f35cf, Offset: 0xf50
// Size: 0x12c
function function_a52e0938() {
    level flag::wait_till("power_on");
    self zm_unitrigger::create_unitrigger();
    /#
        self thread zm_utility::print3d_ent("counter", (1, 0, 1), 3, (0, 0, 24));
    #/
    n_count = 0;
    while (true) {
        self waittill(#"trigger_activated");
        if (!namespace_52adc03e::function_8090042c()) {
            continue;
        }
        playsoundatposition("zmb_8bit_button_" + n_count, self.origin);
        n_count++;
        if (n_count >= 3) {
            break;
        }
        wait(1);
    }
    /#
        self notify(#"end_print3d");
    #/
    level thread zm_audio::sndmusicsystem_playstate(self.script_string);
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x1088
// Size: 0x4
function function_c25da5bd() {
    
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0xdbb42047, Offset: 0x1098
// Size: 0xac
function function_517d4259() {
    wait(1);
    level flag::wait_till("start_zombie_round_logic");
    playsoundatposition("evt_warp_in", (0, 0, 0));
    wait(3);
    players = getplayers();
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("general", "start");
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0xd390eff7, Offset: 0x1150
// Size: 0x44
function function_d647dad9() {
    wait(3);
    level flag::wait_till("power_on");
    wait(20);
    level thread function_5e318772("vox_mcomp_power");
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x0
// Checksum 0x68fe41c, Offset: 0x11a0
// Size: 0x696
function function_5d71efd7() {
    level.var_a89f567b["kill"]["explosive"] = "kill_explosive";
    level.var_a89f567b["kill"]["explosive_response"] = undefined;
    level.var_a89f567b["weapon_pickup"]["microwave"] = "wpck_microwave";
    level.var_a89f567b["weapon_pickup"]["microwave_response"] = undefined;
    level.var_a89f567b["weapon_pickup"]["quantum"] = "wpck_quantum";
    level.var_a89f567b["weapon_pickup"]["quantum_response"] = undefined;
    level.var_a89f567b["weapon_pickup"]["gasmask"] = "wpck_gasmask";
    level.var_a89f567b["weapon_pickup"]["gasmask_response"] = undefined;
    level.var_a89f567b["weapon_pickup"]["hacker"] = "wpck_hacker";
    level.var_a89f567b["weapon_pickup"]["hacker_response"] = undefined;
    level.var_a89f567b["kill"]["micro_dual"] = "kill_micro_dual";
    level.var_a89f567b["kill"]["micro_dual_response"] = undefined;
    level.var_a89f567b["kill"]["micro_single"] = "kill_micro_single";
    level.var_a89f567b["kill"]["micro_single_response"] = undefined;
    level.var_a89f567b["kill"]["quant_good"] = "kill_quant_good";
    level.var_a89f567b["kill"]["quant_good_response"] = undefined;
    level.var_a89f567b["kill"]["quant_bad"] = "kill_quant_bad";
    level.var_a89f567b["kill"]["quant_bad_response"] = undefined;
    level.var_a89f567b["digger"] = [];
    level.var_a89f567b["digger"]["incoming"] = "digger_incoming";
    level.var_a89f567b["digger"]["incoming_response"] = undefined;
    level.var_a89f567b["digger"]["breach"] = "digger_breach";
    level.var_a89f567b["digger"]["breach_response"] = undefined;
    level.var_a89f567b["digger"]["hacked"] = "digger_hacked";
    level.var_a89f567b["digger"]["hacked_response"] = undefined;
    level.var_a89f567b["general"]["astro_spawn"] = "spawn_astro";
    level.var_a89f567b["general"]["astro_spawn_response"] = undefined;
    level.var_a89f567b["kill"]["astro"] = "kill_astro";
    level.var_a89f567b["kill"]["astro_response"] = undefined;
    level.var_a89f567b["general"]["biodome"] = "location_biodome";
    level.var_a89f567b["general"]["biodome_response"] = undefined;
    level.var_a89f567b["general"]["jumppad"] = "jumppad";
    level.var_a89f567b["general"]["jumppad_response"] = undefined;
    level.var_a89f567b["general"]["teleporter"] = "teleporter";
    level.var_a89f567b["general"]["teleporter_response"] = undefined;
    level.var_a89f567b["perk"]["specialty_additionalprimaryweapon"] = "perk_arsenal";
    level.var_a89f567b["perk"]["specialty_additionalprimaryweapon_response"] = undefined;
    level.var_a89f567b["powerup"]["bonus_points_solo"] = "powerup_pts_solo";
    level.var_a89f567b["powerup"]["bonus_points_solo_response"] = undefined;
    level.var_a89f567b["powerup"]["bonus_points_team"] = "powerup_pts_team";
    level.var_a89f567b["powerup"]["bonus_points_team_response"] = undefined;
    level.var_a89f567b["powerup"]["lose_points"] = "powerup_antipts_zmb";
    level.var_a89f567b["powerup"]["lose_points_response"] = undefined;
    level.var_a89f567b["general"]["hack_plr"] = "hack_plr";
    level.var_a89f567b["general"]["hack_plr_response"] = undefined;
    level.var_a89f567b["general"]["hack_vox"] = "hack_vox";
    level.var_a89f567b["general"]["hack_vox_response"] = undefined;
    level.var_a89f567b["general"]["airless"] = "location_airless";
    level.var_a89f567b["general"]["airless_response"] = undefined;
    level.var_a89f567b["general"]["moonjump"] = "moonjump";
    level.var_a89f567b["general"]["moonjump_response"] = undefined;
    level.var_a89f567b["weapon_pickup"]["grenade"] = "wpck_launcher";
    level.var_a89f567b["weapon_pickup"]["grenade_response"] = undefined;
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x0
// Checksum 0x8d26c952, Offset: 0x1840
// Size: 0x1c
function function_96145f41() {
    wait(60);
    level thread function_6acb7f9a();
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0xab8be9fb, Offset: 0x1868
// Size: 0xce
function function_6acb7f9a() {
    level.player_4_vox_override = 1;
    level.zmannouncerprefix = "vox_zmbar_";
    foreach (player in level.players) {
        if (isdefined(player.characterindex) && player.characterindex == 2) {
            player.var_9bbd16b8 = 1;
        }
    }
}

// Namespace namespace_fd83f37
// Params 5, eflags: 0x1 linked
// Checksum 0x606965ec, Offset: 0x1940
// Size: 0x100
function function_be75904(sound_to_play, waittime, category, type, override) {
    players = getplayers();
    if (!isdefined(level.player_is_speaking)) {
        level.player_is_speaking = 0;
    }
    if (isdefined(level.var_c502e691) && level.var_c502e691 && !(isdefined(override) && override)) {
        return;
    }
    if (isdefined(self.var_98905394) && self.var_98905394 && !self namespace_11fcf241::function_7dd87435()) {
        return;
    }
    if (level.player_is_speaking != 1) {
        level.player_is_speaking = 1;
        self function_61c0e984(sound_to_play);
        level.player_is_speaking = 0;
    }
}

// Namespace namespace_fd83f37
// Params 1, eflags: 0x1 linked
// Checksum 0x6b871264, Offset: 0x1a48
// Size: 0x112
function function_61c0e984(sound_to_play) {
    players = getplayers();
    if (self.sessionstate == "spectator") {
        return;
    }
    for (i = 0; i < players.size; i++) {
        if (self zm_equipment::is_active(level.var_f486078e)) {
            if (self == players[i]) {
                self playsoundwithnotify(sound_to_play + "_f", "sound_done" + sound_to_play);
            }
            continue;
        }
        if (self == players[i]) {
            self playsoundwithnotify(sound_to_play, "sound_done" + sound_to_play);
        }
    }
    self waittill("sound_done" + sound_to_play);
}

// Namespace namespace_fd83f37
// Params 2, eflags: 0x1 linked
// Checksum 0xde432cf0, Offset: 0x1b68
// Size: 0x2b0
function function_621add9(weapon, magic_box) {
    if (!isdefined(self.entity_num)) {
        return "crappy";
    }
    switch (self.entity_num) {
    case 0:
        if (weapon == getweapon("m16")) {
            return "favorite";
        } else if (weapon == getweapon("m16_gl_upgraded")) {
            return "favorite_upgrade";
        }
        break;
    case 1:
        if (weapon == getweapon("fnfal")) {
            return "favorite";
        } else if (weapon == getweapon("hk21_upgraded")) {
            return "favorite_upgrade";
        }
        break;
    case 2:
        if (weapon == getweapon("ak74u")) {
            return "favorite";
        } else if (weapon == getweapon("m14_upgraded")) {
            return "favorite_upgrade";
        }
        break;
    case 3:
        if (!(isdefined(level.player_4_vox_override) && level.player_4_vox_override)) {
            if (weapon == getweapon("spectre")) {
                return "favorite";
            } else if (weapon == getweapon("g11_lps_upgraded")) {
                return "favorite_upgrade";
            }
        } else if (weapon == getweapon("spas")) {
            return "favorite";
        } else if (weapon == getweapon("mp40_upgraded")) {
            return "favorite_upgrade";
        }
        break;
    }
    if (issubstr(weapon.name, "upgraded")) {
        return "upgrade";
    }
    w_root = weapon.rootweapon;
    return level.zombie_weapons[w_root].vox;
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0x97332fda, Offset: 0x1e20
// Size: 0x5c
function function_702b17be() {
    level thread namespace_52adc03e::function_e753d4f();
    level flag::wait_till("snd_song_completed");
    level thread zm_audio::sndmusicsystem_playstate("cominghome");
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x0
// Checksum 0x12ddc9dc, Offset: 0x1e88
// Size: 0x22
function function_4f5d74c2() {
    if (isdefined(level.var_5738e0e5) && level.var_5738e0e5) {
        return false;
    }
    return true;
}

// Namespace namespace_fd83f37
// Params 2, eflags: 0x1 linked
// Checksum 0x7801a022, Offset: 0x1eb8
// Size: 0x108
function function_5e318772(alias, var_19127c3b) {
    if (!isdefined(alias)) {
        return;
    }
    if (!level.var_5f225972) {
        return;
    }
    num = 0;
    if (isdefined(var_19127c3b)) {
        switch (var_19127c3b) {
        case 124:
            num = 1;
            break;
        case 75:
            num = 0;
            break;
        case 71:
            num = 2;
            break;
        }
    } else {
        num = "";
    }
    if (!isdefined(level.var_457ca4b3)) {
        level.var_457ca4b3 = 0;
    }
    if (level.var_457ca4b3 == 0) {
        level.var_457ca4b3 = 1;
        level function_5f3d37e5(alias + num);
        level.var_457ca4b3 = 0;
    }
}

// Namespace namespace_fd83f37
// Params 1, eflags: 0x1 linked
// Checksum 0xf4ad5dd9, Offset: 0x1fc8
// Size: 0x15a
function function_5f3d37e5(alias) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i] zm_equipment::is_active(level.var_f486078e)) {
            players[i] playsoundtoplayer(alias + "_f", players[i]);
        }
    }
    if (!isdefined(level.var_2ff0efb3)) {
        return;
    }
    foreach (speaker in level.var_2ff0efb3) {
        playsoundatposition(alias, speaker.origin);
        wait(0.05);
    }
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0xe7910b5b, Offset: 0x2130
// Size: 0x3a
function function_c844cebe() {
    level.var_2ff0efb3 = struct::get_array("sndMoonPa", "targetname");
    if (!isdefined(level.var_2ff0efb3)) {
        return;
    }
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0xa8df5067, Offset: 0x2178
// Size: 0x148
function function_22ed617f() {
    level waittill(#"hash_39331fa7");
    while (true) {
        zone = level.zones["forest_zone"];
        players = getplayers();
        for (i = 0; i < zone.volumes.size; i++) {
            for (j = 0; j < players.size; j++) {
                if (players[j] istouching(zone.volumes[i]) && !(players[j].sessionstate == "spectator")) {
                    players[j] thread zm_audio::create_and_play_dialog("general", "biodome");
                    return;
                }
            }
        }
        wait(0.5);
    }
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0x1878a234, Offset: 0x22c8
// Size: 0x9c
function function_b61cf03e() {
    wait(5);
    level flag::wait_till("start_zombie_round_logic");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] thread function_8a07c80b();
    }
    level thread function_e757be94();
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0x856ee953, Offset: 0x2370
// Size: 0xba
function function_8a07c80b() {
    self endon(#"death");
    self endon(#"disconnect");
    self waittill(#"hash_237e9e73");
    self waittill(#"weapon_change_complete");
    self playsoundtoplayer("vox_mcomp_suit_on", self);
    wait(1.5);
    self playsoundtoplayer("vox_mcomp_start", self);
    wait(7);
    self thread function_7070df7();
    self thread function_fbc53914();
    level notify(#"hash_f7683da1", self);
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0x6b268d8b, Offset: 0x2438
// Size: 0x44
function function_e757be94() {
    who = level waittill(#"hash_f7683da1");
    who thread zm_audio::create_and_play_dialog("general", "moonbase");
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0xadee84e2, Offset: 0x2488
// Size: 0x80
function function_7070df7() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"hash_237e9e73");
        self waittill(#"weapon_change_complete");
        self stopsounds();
        wait(0.05);
        self playsoundtoplayer("vox_mcomp_suit_on", self);
    }
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0x5269f62, Offset: 0x2510
// Size: 0x142
function function_fbc53914() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        while (!self.var_98905394) {
            wait(0.1);
        }
        if (isdefined(self.var_98905394 && self hasweapon(level.var_f486078e) && !self namespace_11fcf241::function_7dd87435()) && self.var_98905394 && self hasweapon(level.var_f486078e) && !self namespace_11fcf241::function_7dd87435()) {
            self stopsounds();
            wait(0.05);
            self playsoundtoplayer("vox_mcomp_suit_reminder", self);
            while (self.var_98905394) {
                if (self namespace_11fcf241::function_7dd87435()) {
                    break;
                }
                wait(0.1);
            }
        }
        wait(8);
    }
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0x4fce8307, Offset: 0x2660
// Size: 0x144
function function_45b4acf2() {
    var_757351da = struct::get_array("zhdbuttons", "targetname");
    array::thread_all(var_757351da, &function_1d6f553d);
    level thread function_e091daa4();
    var_22ee0088 = array(1, 2, 2, 3, 3, 2, 3, 4, 3, 4, 3, 2, 2, 4, 1);
    for (var_c957db9f = 0; var_c957db9f < var_22ee0088.size; var_c957db9f = 0) {
        var_333c1c87 = level waittill(#"hash_351576b1");
        if (var_333c1c87 == var_22ee0088[var_c957db9f]) {
            var_c957db9f++;
            continue;
        }
    }
    level flag::set("snd_zhdegg_activate");
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0x7ed629e2, Offset: 0x27b0
// Size: 0x88
function function_1d6f553d() {
    level endon(#"hash_f9e823ac");
    self zm_unitrigger::create_unitrigger();
    while (true) {
        self waittill(#"trigger_activated");
        playsoundatposition("zmb_zhdmoon_button_" + self.script_int, self.origin);
        level notify(#"hash_351576b1", self.script_int);
        wait(0.5);
    }
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0xe9231e7d, Offset: 0x2840
// Size: 0x9e
function function_e091daa4() {
    level endon(#"hash_f9e823ac");
    var_924a65e5 = spawn("script_origin", (919, -303, -171));
    while (true) {
        wait(randomfloatrange(60, 120));
        var_924a65e5 playsoundwithnotify("zmb_zhdmoon_voices", "sounddone");
        var_924a65e5 waittill(#"sounddone");
    }
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0xb144cb80, Offset: 0x28e8
// Size: 0x11a
function function_3630300b() {
    var_d1f154fd = struct::get_array("s_ballerina_timed", "targetname");
    var_d1f154fd = array::sort_by_script_int(var_d1f154fd, 1);
    level.var_aa39de8 = 0;
    wait(1);
    foreach (var_6d450235 in var_d1f154fd) {
        var_6d450235 thread function_b8227f87();
        wait(1);
    }
    while (level.var_aa39de8 < var_d1f154fd.size) {
        wait(0.1);
    }
    wait(1);
    return true;
}

// Namespace namespace_fd83f37
// Params 0, eflags: 0x1 linked
// Checksum 0xc5c5e242, Offset: 0x2a10
// Size: 0x124
function function_b8227f87() {
    self.var_ac086ffb = util::spawn_model(self.model, self.origin, self.angles);
    self.var_ac086ffb clientfield::set("snd_zhdegg", 1);
    self.var_ac086ffb playloopsound("mus_musicbox_lp", 2);
    self thread namespace_52adc03e::function_9d55fd08();
    self thread namespace_52adc03e::function_2fdaabf3();
    self util::waittill_any("ballerina_destroyed");
    level.var_aa39de8++;
    self.var_ac086ffb clientfield::set("snd_zhdegg", 0);
    util::wait_network_frame();
    self.var_ac086ffb delete();
}

