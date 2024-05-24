#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_audio;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_6d4f3e39;

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x2
// Checksum 0xdc89d6e2, Offset: 0x410
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_theater_amb", &__init__, undefined, undefined);
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x6ef5503e, Offset: 0x450
// Size: 0x34
function __init__() {
    clientfield::register("toplayer", "player_dust_mote", 21000, 1, "int");
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0xe4e4feb8, Offset: 0x490
// Size: 0x258
function main() {
    level thread function_e1025e4a();
    level thread function_b2e85f85();
    level thread function_c5b92ef5();
    level thread function_7bd873cc();
    level thread function_cedd5c11();
    level thread function_e11d1d5c();
    array::thread_all(getentarray("portrait_egg", "targetname"), &function_d83efca0);
    array::thread_all(getentarray("location_egg", "targetname"), &function_40e25a20);
    level thread function_8d1c7be1();
    level thread function_d43815df();
    var_3a067a8d = struct::get_array("trap_electric", "targetname");
    foreach (s_trap in var_3a067a8d) {
        e_trap = getent(s_trap.script_noteworthy, "target");
        e_trap thread function_57a1070b();
    }
    level thread function_71554606();
    level.sndtrapfunc = &function_448d83df;
    level.var_671111f8 = 1;
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0xf333cd60, Offset: 0x6f0
// Size: 0xd4
function function_d43815df() {
    level endon(#"hash_993b920d");
    wait(50);
    var_64ab0444 = getent("amb_0_zombie", "targetname");
    var_64ab0444 playloopsound(var_64ab0444.script_label);
    wait(35);
    while (true) {
        int = randomintrange(0, 40);
        if (int == 10) {
            var_64ab0444 thread function_ae3642b4();
            level notify(#"hash_993b920d");
        }
        wait(10);
    }
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0xe769ab6b, Offset: 0x7d0
// Size: 0x44
function function_ae3642b4() {
    self stoploopsound(0.5);
    playsoundatposition(self.script_sound, self.origin);
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x3ddd697a, Offset: 0x820
// Size: 0xb6
function function_e1025e4a() {
    wait(5);
    var_92ea6e8 = struct::get_array("amb_power", "targetname");
    level flag::wait_till("power_on");
    level thread function_25e49f31();
    for (i = 0; i < var_92ea6e8.size; i++) {
        var_92ea6e8[i] thread function_f51445ac();
    }
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x69d26a6e, Offset: 0x8e0
// Size: 0x8c
function function_f51445ac() {
    wait(randomintrange(1, 3));
    playsoundatposition("amb_circuit", self.origin);
    wait(1);
    soundloop = spawn("script_origin", self.origin);
    soundloop playloopsound(self.script_sound);
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0xfdc03e5f, Offset: 0x978
// Size: 0xbe
function function_25e49f31() {
    playsoundatposition("zmb_switch_flip", (-482, 1261, 44));
    playsoundatposition("evt_flip_sparks_left", (-544, 1320, 32));
    playsoundatposition("evt_flip_sparks_right", (-400, 1320, 32));
    wait(2);
    playsoundatposition("evt_crazy_power_left", (-304, 1120, 344));
    wait(13);
    level notify(#"hash_9ccd585f");
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0xcb2f27ef, Offset: 0xa40
// Size: 0x64
function function_c5b92ef5() {
    level waittill(#"hash_9ccd585f");
    wait(20);
    speaker = spawn("script_origin", (32, 1216, 592));
    speaker playloopsound("amb_projecter_soundtrack");
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x68173613, Offset: 0xab0
// Size: 0x5c
function function_b2e85f85() {
    level waittill(#"hash_9ccd585f");
    var_23188b81 = spawn("script_origin", (-72, -144, 384));
    var_23188b81 playloopsound("amb_projecter");
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x4c3c5636, Offset: 0xb18
// Size: 0xdc
function function_7bd873cc() {
    level thread function_1da885f0();
    level thread namespace_52adc03e::function_e753d4f();
    level flag::wait_till("snd_song_completed");
    level thread zm_audio::sndmusicsystem_playstate("115");
    wait(4);
    a_e_players = getplayers();
    a_e_players = array::randomize(a_e_players);
    a_e_players[0] thread zm_audio::create_and_play_dialog("eggs", "music_activate");
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x54c58b68, Offset: 0xc00
// Size: 0x88
function function_1da885f0() {
    while (true) {
        e_player = level waittill(#"hash_9b53c751");
        n_variant = level.var_2a0600f - 1;
        if (n_variant < 0) {
            n_variant = 0;
        }
        if (isdefined(e_player)) {
            e_player thread zm_audio::create_and_play_dialog("eggs", "meteors", n_variant);
        }
    }
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x70d6a89b, Offset: 0xc90
// Size: 0x7e
function function_71554606() {
    level flag::wait_till("start_zombie_round_logic");
    for (i = 0; i < level.players.size; i++) {
        level.players[i] clientfield::set_to_player("player_dust_mote", 1);
    }
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0xbf8e5189, Offset: 0xd18
// Size: 0xd4
function function_d83efca0() {
    if (!isdefined(self)) {
        return;
    }
    self usetriggerrequirelookat();
    self setcursorhint("HINT_NOICON");
    while (true) {
        player = self waittill(#"trigger");
        if (!(isdefined(player.isspeaking) && player.isspeaking)) {
            break;
        }
    }
    type = "portrait_" + self.script_noteworthy;
    player zm_audio::create_and_play_dialog("eggs", type);
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x2753c3fb, Offset: 0xdf8
// Size: 0x7c
function function_40e25a20() {
    player = self waittill(#"trigger");
    if (randomintrange(0, 101) >= 90) {
        type = "room_" + self.script_noteworthy;
        player zm_audio::create_and_play_dialog("eggs", type);
    }
}

// Namespace namespace_6d4f3e39
// Params 1, eflags: 0x1 linked
// Checksum 0x40401f46, Offset: 0xe80
// Size: 0xbc
function function_4e682575(delay) {
    if (isdefined(delay)) {
        wait(delay);
    }
    if (isdefined(self.target)) {
        s_target = struct::get(self.target, "targetname");
        playsoundatposition("vox_kino_radio_" + level.var_2fd32a1d, s_target.origin);
    } else {
        self playsound("vox_kino_radio_" + level.var_2fd32a1d);
    }
    level.var_2fd32a1d++;
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x39e41c12, Offset: 0xf48
// Size: 0x54
function function_cedd5c11() {
    wait(1);
    level.var_2fd32a1d = 0;
    array::thread_all(getentarray("audio_egg_radio", "targetname"), &function_3e7031a5);
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x39c51dc6, Offset: 0xfa8
// Size: 0x3c
function function_3e7031a5() {
    if (!isdefined(self)) {
        return;
    }
    who = self waittill(#"trigger");
    self thread function_4e682575(undefined);
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0xf77bdd89, Offset: 0xff0
// Size: 0x74
function function_8d1c7be1() {
    var_1e717ab1 = getent("alley_door2", "target");
    exploder::stop_exploder("lgt_exploder_crematorium_door");
    var_1e717ab1 waittill(#"door_opened");
    exploder::exploder("lgt_exploder_crematorium_door");
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x42bc0775, Offset: 0x1070
// Size: 0x70
function function_57a1070b() {
    level flag::wait_till("power_on");
    var_a58a7b24 = self.target + "_flashes";
    while (true) {
        self waittill(#"trap_done");
        exploder::exploder(var_a58a7b24);
    }
}

// Namespace namespace_6d4f3e39
// Params 2, eflags: 0x1 linked
// Checksum 0x56ede9f4, Offset: 0x10e8
// Size: 0x9c
function function_448d83df(trap, b_start) {
    if (!(isdefined(b_start) && b_start)) {
        return;
    }
    player = trap.activated_by_player;
    if (isdefined(trap._trap_type) && trap._trap_type == "fire") {
        return;
    }
    player zm_audio::create_and_play_dialog("trap", "start");
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0xe8ab8ae4, Offset: 0x1190
// Size: 0x12c
function function_e11d1d5c() {
    var_8e7ce497 = getent("sndzhd_knocker", "targetname");
    if (!isdefined(var_8e7ce497)) {
        return;
    }
    while (true) {
        wait(randomintrange(60, -76));
        var_adc6a71a = level function_57f2b10e(var_8e7ce497);
        if (!(isdefined(var_adc6a71a) && var_adc6a71a)) {
            continue;
        }
        wait(1);
        var_adc6a71a = level function_57f2b10e(var_8e7ce497);
        if (!(isdefined(var_adc6a71a) && var_adc6a71a)) {
            continue;
        }
        wait(1);
        var_adc6a71a = level function_57f2b10e(var_8e7ce497);
        if (!(isdefined(var_adc6a71a) && var_adc6a71a)) {
            continue;
        }
        break;
    }
    level flag::set("snd_zhdegg_activate");
}

// Namespace namespace_6d4f3e39
// Params 1, eflags: 0x1 linked
// Checksum 0x8e3e45f8, Offset: 0x12c8
// Size: 0x7c
function function_57f2b10e(var_8e7ce497) {
    var_6140b6dd = level function_314be731();
    level function_5c13c705(var_6140b6dd, var_8e7ce497);
    success = level function_7f30e34a(var_6140b6dd, var_8e7ce497);
    return success;
}

// Namespace namespace_6d4f3e39
// Params 2, eflags: 0x1 linked
// Checksum 0xb0bfbaaa, Offset: 0x1350
// Size: 0x98
function function_5c13c705(var_6140b6dd, var_8e7ce497) {
    for (var_918879b9 = 0; var_918879b9 < 3; var_918879b9++) {
        wait(1.5);
        for (n_count = 0; n_count < var_6140b6dd[var_918879b9]; n_count++) {
            var_8e7ce497 playsound("zmb_zhd_knocker_door");
            wait(0.75);
        }
    }
}

// Namespace namespace_6d4f3e39
// Params 2, eflags: 0x1 linked
// Checksum 0xc90a63d7, Offset: 0x13f0
// Size: 0x8c
function function_7f30e34a(var_6140b6dd, var_8e7ce497) {
    level thread function_47cc6622(var_6140b6dd, var_8e7ce497);
    str_notify = util::waittill_any_return("zhd_knocker_success", "zhd_knocker_timeout");
    if (str_notify == "zhd_knocker_timeout") {
        var_8e7ce497 thread function_702e84d0();
        return false;
    }
    return true;
}

// Namespace namespace_6d4f3e39
// Params 2, eflags: 0x1 linked
// Checksum 0xeaf9e097, Offset: 0x1488
// Size: 0x1de
function function_47cc6622(var_6140b6dd, var_8e7ce497) {
    level endon(#"hash_a0b8e4d9");
    for (var_918879b9 = 0; var_918879b9 < 3; var_918879b9++) {
        level thread function_e497b291(3000);
        n_count = 0;
        while (n_count < var_6140b6dd[var_918879b9]) {
            damage, attacker, dir, loc, str_type, model, tag, part, weapon, flags = var_8e7ce497 waittill(#"damage");
            if (!isdefined(attacker) || !isplayer(attacker)) {
                continue;
            }
            if (isdefined(str_type) && str_type != "MOD_MELEE") {
                continue;
            }
            var_8e7ce497 playsound("zmb_zhd_knocker_plr");
            level notify(#"hash_a5e68e5c");
            n_count++;
            level thread function_e497b291(1000);
        }
        level thread function_4f9527ef(1000);
    }
    wait(0.05);
    level notify(#"hash_1e121de9");
}

// Namespace namespace_6d4f3e39
// Params 1, eflags: 0x1 linked
// Checksum 0x41ad9ee1, Offset: 0x1670
// Size: 0x92
function function_e497b291(n_max) {
    level notify(#"hash_165b5152");
    level endon(#"hash_165b5152");
    level endon(#"hash_a5e68e5c");
    level endon(#"hash_a0b8e4d9");
    level endon(#"hash_1e121de9");
    var_c9cd8e88 = gettime();
    n_max += var_c9cd8e88;
    while (gettime() < n_max) {
        wait(0.05);
    }
    level notify(#"hash_a0b8e4d9");
}

// Namespace namespace_6d4f3e39
// Params 1, eflags: 0x1 linked
// Checksum 0x27d30769, Offset: 0x1710
// Size: 0x86
function function_4f9527ef(n_min) {
    level notify(#"hash_b0b21488");
    level endon(#"hash_b0b21488");
    level endon(#"hash_a0b8e4d9");
    level endon(#"hash_1e121de9");
    var_c9cd8e88 = gettime();
    n_min += var_c9cd8e88;
    level waittill(#"hash_a5e68e5c");
    if (gettime() < n_min) {
        level notify(#"hash_a0b8e4d9");
    }
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x69cc72fb, Offset: 0x17a0
// Size: 0xd0
function function_314be731() {
    var_6140b6dd = array((1, 1, 5), (9, 3, 5), (6, 6, 6), (2, 4, 1), (1, 2, 1), (5, 3, 4), (3, 2, 1), (5, 1, 2), (1, 4, 3), (6, 2, 4));
    var_6140b6dd = array::randomize(var_6140b6dd);
    return var_6140b6dd[0];
}

// Namespace namespace_6d4f3e39
// Params 0, eflags: 0x1 linked
// Checksum 0x30f79f79, Offset: 0x1878
// Size: 0x4e
function function_702e84d0() {
    for (n_count = 0; n_count < 6; n_count++) {
        self playsound("zmb_zhd_knocker_door");
        wait(0.25);
    }
}

