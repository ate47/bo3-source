#using scripts/zm/zm_temple_sq_skits;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_audio;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_temple_amb;

// Namespace zm_temple_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x85c85b1, Offset: 0x2b0
// Size: 0xf4
function main() {
    level._audio_custom_weapon_check = &function_621add9;
    level._custom_intro_vox = &function_517d4259;
    level.var_75d6586e = &function_5d71efd7;
    level thread function_702b17be();
    level thread function_6d5ecc2a("location_maze");
    level thread function_6d5ecc2a("location_waterfall");
    level thread function_6d5ecc2a("mine_see");
    level thread function_8e7c8fe0();
    level thread function_45b4acf2();
}

// Namespace zm_temple_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x23e3b70b, Offset: 0x3b0
// Size: 0x42
function function_5d71efd7() {
    level.var_a89f567b["kill"]["explosive"] = "kill_explosive";
    level.var_a89f567b["kill"]["explosive_response"] = undefined;
}

// Namespace zm_temple_amb
// Params 0, eflags: 0x0
// Checksum 0xe2033c6b, Offset: 0x400
// Size: 0xa
function function_d4b7774a() {
    wait 10;
}

// Namespace zm_temple_amb
// Params 0, eflags: 0x1 linked
// Checksum 0xf513140a, Offset: 0x418
// Size: 0x154
function function_8e7c8fe0() {
    level waittill(#"end_game");
    wait 2;
    winner = undefined;
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].var_54680ca) && players[i].var_54680ca == 1) {
            winner = players[i];
            break;
        }
    }
    if (isdefined(winner)) {
        num = winner.characterindex;
        if (isdefined(winner.var_62030aa3)) {
            num = winner.var_62030aa3;
        }
        if (num == 3) {
            playsoundatposition("vox_plr_3_gameover_1", (0, 0, 0));
            return;
        }
        playsoundatposition("vox_plr_3_gameover_0", (0, 0, 0));
    }
}

// Namespace zm_temple_amb
// Params 2, eflags: 0x1 linked
// Checksum 0xfda8abdf, Offset: 0x578
// Size: 0x80
function function_621add9(weapon, magic_box) {
    if (issubstr(weapon.name, "upgraded")) {
        return "upgrade";
    }
    w_root = weapon.rootweapon;
    return level.zombie_weapons[w_root].vox;
}

// Namespace zm_temple_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x713ea969, Offset: 0x600
// Size: 0x5c
function function_702b17be() {
    level thread namespace_52adc03e::function_e753d4f();
    level flag::wait_till("snd_song_completed");
    level thread zm_audio::sndmusicsystem_playstate("pareidolia");
}

// Namespace zm_temple_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x5bc3831b, Offset: 0x668
// Size: 0x17c
function function_517d4259() {
    playsoundatposition("evt_warp_in", (0, 0, 0));
    wait 3;
    players = getplayers();
    if (players.size == 4 && randomintrange(0, 101) <= 10) {
        if (randomintrange(0, 101) <= 10) {
            players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("eggs", "rod");
        } else {
            num = randomintrange(0, 2);
            level thread zm_temple_sq_skits::function_acc79afb("start" + num, players);
        }
        return;
    }
    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("general", "start");
}

// Namespace zm_temple_amb
// Params 1, eflags: 0x1 linked
// Checksum 0x268a0bed, Offset: 0x7f0
// Size: 0x134
function function_6d5ecc2a(place) {
    wait 3;
    struct = struct::get("vox_" + place, "targetname");
    if (!isdefined(struct)) {
        return;
    }
    var_5cb1355d = spawn("trigger_radius", struct.origin - (0, 0, 100), 0, -6, -56);
    while (true) {
        who = var_5cb1355d waittill(#"trigger");
        if (isplayer(who)) {
            who thread zm_audio::create_and_play_dialog("general", place);
            if (place == "location_maze") {
                wait 90;
                continue;
            }
            break;
        }
    }
    var_5cb1355d delete();
}

// Namespace zm_temple_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x8a3b85b4, Offset: 0x930
// Size: 0x11c
function function_45b4acf2() {
    var_18d6690a = getentarray("zhdsnd_pans", "targetname");
    array::thread_all(var_18d6690a, &function_19277046);
    n_count = 0;
    var_6932cc13 = array(1, 1, 5);
    if (var_18d6690a.size <= 0) {
        return;
    }
    while (true) {
        num = level waittill(#"hash_ab740a84");
        if (num == var_6932cc13[n_count]) {
            n_count++;
            if (n_count >= 3) {
                break;
            }
            continue;
        }
        n_count = 0;
    }
    level flag::set("snd_zhdegg_activate");
}

// Namespace zm_temple_amb
// Params 0, eflags: 0x1 linked
// Checksum 0x3644b6c2, Offset: 0xa58
// Size: 0x148
function function_19277046() {
    level endon(#"snd_zhdegg_activate");
    while (true) {
        damage, attacker, dir, loc, str_type, model, tag, part, weapon, flags = self waittill(#"damage");
        if (!level flag::get("gongs_resonating")) {
            continue;
        }
        if (!isplayer(attacker)) {
            continue;
        }
        if (weapon != level.start_weapon) {
            continue;
        }
        if (str_type != "MOD_PISTOL_BULLET") {
            continue;
        }
        level notify(#"hash_ab740a84", self.script_int);
        playsoundatposition("zmb_zhd_plate_hit", self.origin);
    }
}

