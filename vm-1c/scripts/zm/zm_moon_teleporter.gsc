#using scripts/zm/zm_moon_wasteland;
#using scripts/zm/zm_moon_utility;
#using scripts/zm/zm_moon_gravity;
#using scripts/zm/zm_moon;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_ai_dogs;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_591ce3c5;

// Namespace namespace_591ce3c5
// Params 1, eflags: 0x1 linked
// Checksum 0x71416f55, Offset: 0x668
// Size: 0x5d4
function function_a19db598(name) {
    teleporter = getent(name, "targetname");
    var_850a7fc = 0;
    str = name + "_bottom_name";
    var_e92ab7c3 = struct::get(str, "targetname");
    str = name + "_top_name";
    var_4eefdeff = struct::get(str, "targetname");
    var_152d4ef2 = "Waiting for Players";
    while (true) {
        players = getplayers();
        /#
            for (i = 0; i < players.size; i++) {
                if (isgodmode(players[i])) {
                    level.devcheater = 1;
                }
                if (players[i] isnotarget()) {
                    level.devcheater = 1;
                }
            }
        #/
        num_players = function_5a9a4cac();
        switch (var_152d4ef2) {
        case 15:
            break;
        case 3:
            var_15a6c4a3 = namespace_e593e2::function_fcb42941(teleporter);
            if (var_15a6c4a3 == 0) {
            } else if (var_15a6c4a3 < num_players) {
            } else {
                var_850a7fc = gettime();
                var_850a7fc += 2500;
                var_152d4ef2 = "Teleport Countdown";
                clientfield::increment("teleporter_audio_sfx");
                teleporter thread function_2f6b6897();
            }
            break;
        case 4:
            var_15a6c4a3 = namespace_e593e2::function_fcb42941(teleporter);
            if (var_15a6c4a3 < num_players) {
                function_cf379b01(teleporter, 1);
                var_152d4ef2 = "Waiting for Players";
                util::clientnotify("cafx");
                teleporter notify(#"stop_exploder");
            } else {
                current_time = gettime();
                if (var_850a7fc <= current_time) {
                    util::wait_network_frame();
                    if (namespace_e593e2::function_fcb42941(teleporter) != function_5a9a4cac()) {
                        continue;
                    }
                    var_27b2670f = function_cad30bb(teleporter, name);
                    function_b9f2a774(teleporter);
                    for (i = 0; i < players.size; i++) {
                        function_7c968094(players[i], var_27b2670f);
                        players[i] clientfield::increment("beam_fx_audio");
                    }
                    var_152d4ef2 = "Recharging";
                    var_850a7fc = gettime() + 5000;
                    teleporter notify(#"stop_exploder");
                    if (name == "generator_teleporter") {
                        if (isdefined(level.var_abc92c08) && level.var_abc92c08) {
                            exploder::exploder("fxexp_600");
                            exploder::exploder("fxexp_601");
                        }
                        wait(0.5);
                        exploder::exploder("fxexp_502");
                        level util::delay(2, undefined, &function_78f5cb79);
                        level flag::set("teleported_to_nml");
                    }
                    if (name == "nml_teleporter") {
                        level notify(#"hash_5b75f7cb");
                        level flag::clear("teleported_to_nml");
                        if (isdefined(level.var_abc92c08) && level.var_abc92c08) {
                            exploder::kill_exploder("fxexp_600");
                            exploder::kill_exploder("fxexp_601");
                        }
                    }
                    level thread namespace_e593e2::function_eaa8b4ed();
                    function_cf379b01(teleporter, 0);
                }
            }
            break;
        case 8:
            current_time = gettime();
            if (var_850a7fc <= current_time) {
                var_152d4ef2 = "Waiting for Players";
            }
            break;
        }
        wait(0.5);
    }
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0x5a62766b, Offset: 0xc48
// Size: 0x1c2
function function_78f5cb79() {
    var_509912e9 = getent("nml_teleporter", "targetname");
    var_5021a61d = function_cad30bb(var_509912e9, "nml_teleporter");
    a_e_players = getplayers();
    foreach (e_player in a_e_players) {
        e_player zm_utility::create_streamer_hint(var_5021a61d[0].origin, var_5021a61d[0].angles, 1);
    }
    level waittill(#"hash_5b75f7cb");
    a_e_players = getplayers();
    foreach (e_player in a_e_players) {
        e_player zm_utility::clear_streamer_hint();
    }
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0xc0fbc440, Offset: 0xe18
// Size: 0xa8
function function_6454df1b() {
    var_c35f7190 = getent("t_stream_hint_nml_player", "targetname");
    while (true) {
        e_player = var_c35f7190 waittill(#"trigger");
        if (!(isdefined(e_player.var_a31e4590) && e_player.var_a31e4590)) {
            e_player.var_a31e4590 = 1;
            e_player thread function_7305cc9b(var_c35f7190);
        }
    }
}

// Namespace namespace_591ce3c5
// Params 1, eflags: 0x1 linked
// Checksum 0x89f3749, Offset: 0xec8
// Size: 0x114
function function_7305cc9b(var_34ef544f) {
    self endon(#"disconnect");
    var_f657052b = getent("generator_teleporter", "targetname");
    var_5021a61d = function_cad30bb(var_f657052b, "generator_teleporter");
    self zm_utility::create_streamer_hint(var_5021a61d[0].origin, var_5021a61d[0].angles, 1);
    while (self istouching(var_34ef544f)) {
        wait(0.05);
    }
    wait(0.05);
    self.var_a31e4590 = 0;
    if (!level flag::get("teleported_to_nml")) {
        self zm_utility::clear_streamer_hint();
    }
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0x542fc195, Offset: 0xfe8
// Size: 0x8c
function function_5a9a4cac() {
    players = getplayers();
    valid_players = 0;
    for (i = 0; i < players.size; i++) {
        if (function_f46a2050(players[i])) {
            valid_players += 1;
        }
    }
    return valid_players;
}

// Namespace namespace_591ce3c5
// Params 1, eflags: 0x1 linked
// Checksum 0x23ee375d, Offset: 0x1080
// Size: 0xb6
function function_f46a2050(player) {
    if (!isdefined(player)) {
        return false;
    }
    if (!isalive(player)) {
        return false;
    }
    if (!isplayer(player)) {
        return false;
    }
    if (player.sessionstate == "spectator") {
        return false;
    }
    if (player.sessionstate == "intermission") {
        return false;
    }
    if (player isnotarget()) {
        return false;
    }
    return true;
}

// Namespace namespace_591ce3c5
// Params 2, eflags: 0x1 linked
// Checksum 0xf010ab88, Offset: 0x1140
// Size: 0x166
function function_cad30bb(var_51fda60f, name) {
    var_27b2670f = [];
    if (isdefined(var_51fda60f.script_noteworthy) && var_51fda60f.script_noteworthy == "enter_no_mans_land") {
        var_2d05ef52 = struct::get_array("packp_respawn_point", "script_label");
        for (i = 0; i < var_2d05ef52.size; i++) {
            var_27b2670f[i] = var_2d05ef52[i];
        }
    } else {
        var_31edeaf5 = "nml_to_bridge_teleporter";
        for (i = 0; i < 4; i++) {
            str = var_31edeaf5 + "_player" + i + 1 + "_position";
            ent = struct::get(str, "targetname");
            var_27b2670f[i] = ent;
        }
    }
    return var_27b2670f;
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x0
// Checksum 0x3eede801, Offset: 0x12b0
// Size: 0x36
function function_26330297() {
    index = level.var_facbcbcd;
    str = level.var_7ab869d9[index];
    return str;
}

// Namespace namespace_591ce3c5
// Params 2, eflags: 0x1 linked
// Checksum 0xdc724815, Offset: 0x12f0
// Size: 0x1d4
function function_7c968094(player, var_27b2670f) {
    player_index = player.characterindex;
    target_ent = undefined;
    for (i = 0; i < var_27b2670f.size; i++) {
        if (isdefined(var_27b2670f[i].script_int) && var_27b2670f[i].script_int == player_index + 1) {
            target_ent = var_27b2670f[i];
        }
    }
    if (!isdefined(target_ent)) {
        target_ent = var_27b2670f[player_index];
    }
    if (player getstance() == "prone") {
        player setstance("crouch");
    }
    player setorigin(target_ent.origin + (randomfloat(24), randomfloat(24), 0));
    if (isdefined(target_ent.angles)) {
        player setplayerangles(target_ent.angles);
    }
    if (!level.var_1921c0fb) {
        level.var_1921c0fb = 1;
        level.var_c502e691 = 1;
        level thread function_1684fdd();
    }
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0x9781be34, Offset: 0x14d0
// Size: 0x30
function function_1684fdd() {
    level notify(#"hash_ef1a694d");
    level endon(#"hash_ef1a694d");
    wait(15);
    level.var_c502e691 = 0;
}

// Namespace namespace_591ce3c5
// Params 1, eflags: 0x1 linked
// Checksum 0x982b4321, Offset: 0x1508
// Size: 0xc4
function function_b9f2a774(var_51fda60f) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (zombie_utility::is_player_valid(player)) {
            player enableinvulnerability();
        }
    }
    if (isdefined(var_51fda60f.script_noteworthy)) {
        if (var_51fda60f.script_noteworthy == "enter_no_mans_land") {
        }
    }
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0x5d724c4e, Offset: 0x15d8
// Size: 0x188
function function_b190610() {
    if (!isdefined(level.var_e55cd01d)) {
        level.var_e55cd01d = 0;
    }
    level util::waittill_any("end_game", "track_nml_time");
    level.var_78821af9 = gettime() - level.var_e55cd01d;
    players = getplayers();
    level.var_4dcf5944 = players[0].kills;
    level.var_bf0089e1 = players[0].score_total;
    level.var_b4a328ec = 0;
    level.var_4e4d43d6 = 0;
    level.var_73d54f14 = 0;
    if (isdefined(players[0].pap_used) && players[0].pap_used) {
        level.var_b4a328ec = 22;
    }
    if (isdefined(players[0].var_4f584712) && players[0].var_4f584712) {
        level.var_4e4d43d6 = 33;
    }
    if (isdefined(players[0].var_26d18c3c) && players[0].var_26d18c3c) {
        level.var_73d54f14 = 44;
    }
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0x41da3b23, Offset: 0x1768
// Size: 0x8c
function function_2f6b6897() {
    switch (self.targetname) {
    case 14:
        var_a58a7b24 = "fxexp_500";
        break;
    case 9:
        var_a58a7b24 = "fxexp_501";
        break;
    }
    exploder::exploder(var_a58a7b24);
    self waittill(#"stop_exploder");
    exploder::stop_exploder(var_a58a7b24);
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0xb2ba7cd1, Offset: 0x1800
// Size: 0x444
function function_a0d5bb7c() {
    players = getplayers();
    level.var_78821af9 = gettime() - level.var_e55cd01d;
    level.var_4dcf5944 = players[0].kills;
    level.var_bf0089e1 = players[0].score_total;
    level.var_63a990b5 = 1;
    level.var_b4a328ec = 0;
    level.var_4e4d43d6 = 0;
    level.var_73d54f14 = 0;
    level.var_3d4fdded = 1;
    survived = [];
    for (i = 0; i < players.size; i++) {
        if (isdefined(players[i].pap_used) && players[i].pap_used) {
            level.var_b4a328ec = 22;
        }
        if (isdefined(players[i].var_4f584712) && players[i].var_4f584712) {
            level.var_4e4d43d6 = 33;
        }
        if (isdefined(players[i].var_26d18c3c) && players[i].var_26d18c3c) {
            level.var_73d54f14 = 44;
        }
        survived[i] = newclienthudelem(players[i]);
        survived[i].alignx = "center";
        survived[i].aligny = "middle";
        survived[i].horzalign = "center";
        survived[i].vertalign = "middle";
        survived[i].y = survived[i].y - 100;
        survived[i].foreground = 1;
        survived[i].fontscale = 2;
        survived[i].alpha = 0;
        survived[i].color = (1, 1, 1);
        if (players[i] issplitscreen()) {
            survived[i].y = survived[i].y + 40;
        }
        var_ea3f1473 = level.var_78821af9;
        var_a97d7ae5 = int(var_ea3f1473 / 1000);
        var_73d0606f = zm::to_mins(var_a97d7ae5);
        survived[i] settext(%ZOMBIE_SURVIVED_NOMANS, var_73d0606f);
        survived[i] fadeovertime(1);
        survived[i].alpha = 1;
    }
    wait(3);
    for (i = 0; i < players.size; i++) {
        survived[i] fadeovertime(1);
        survived[i].alpha = 0;
    }
    level.var_3d4fdded = 2;
}

// Namespace namespace_591ce3c5
// Params 2, eflags: 0x1 linked
// Checksum 0xb9565ea9, Offset: 0x1c50
// Size: 0x4bc
function function_cf379b01(var_51fda60f, var_e7383480) {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (zombie_utility::is_player_valid(player)) {
            if (!isgodmode(player) && getdvarint("zombie_cheat") < 1) {
                player disableinvulnerability();
            }
        }
    }
    if (!var_e7383480) {
        level flag::set("teleporter_used");
        if (isdefined(var_51fda60f.script_noteworthy)) {
            if (var_51fda60f.script_noteworthy == "enter_no_mans_land") {
                level flag::set("enter_nml");
                level.var_5f225972 = 0;
                level thread namespace_3dc929b6::function_1829268e();
                level thread namespace_e593e2::function_5bde87b7();
                level thread namespace_2f7147af::function_a4d74581();
                zombie_utility::set_zombie_var("zombie_intermission_time", 2);
                zombie_utility::set_zombie_var("zombie_between_round_time", 2);
                zombies = getaiarray();
                level.var_f128ba27 = zombies.size + level.zombie_total;
                level flag::clear("zombie_drop_powerups");
                level thread namespace_e593e2::function_36db1e4f();
                namespace_e593e2::function_1b79fc40();
                return;
            }
            if (var_51fda60f.script_noteworthy == "exit_no_mans_land") {
                level flag::clear("enter_nml");
                level notify(#"hash_ada028f0");
                level flag::clear("start_supersprint");
                level.var_5f225972 = 1;
                level.var_ae0a0c99 = 1;
                if (!(isdefined(level.intermission) && level.intermission) && isdefined(level.var_a4d659b6) && !level.var_a4d659b6) {
                    level notify(#"hash_5bf5ef06");
                    level thread function_a0d5bb7c();
                    level.var_a4d659b6 = 1;
                }
                level thread namespace_2f7147af::function_a4d74581();
                zm::set_round_number(level.var_267b8fc0);
                level.round_number = zm::get_round_number();
                namespace_e593e2::function_d694caf4(level.round_number);
                level thread namespace_3dc929b6::function_28fc6cb();
                level.round_spawn_func = &zm::round_spawning;
                level thread function_2b222584();
                zombie_utility::set_zombie_var("zombie_intermission_time", 15);
                zombie_utility::set_zombie_var("zombie_between_round_time", 10);
                level flag::set("zombie_drop_powerups");
                level.var_ae0a0c99 = 0;
                if (!(isdefined(level.first_round) && level.first_round)) {
                    players = getplayers();
                    players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("general", "teleporter");
                }
            }
        }
    }
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0xd69c16d7, Offset: 0x2118
// Size: 0x1bc
function function_986fd39c() {
    level.var_ad39505b = -116;
    level.var_8b3df875 = getent("teleporter_gate", "targetname");
    level.var_8243881a = getent(level.var_8b3df875.target, "targetname");
    level.var_8243881a linkto(level.var_8b3df875);
    level.var_590ba9a6 = 0;
    level.var_ae26b507 = 120;
    level.var_e22bae0d = getent("teleporter_gate_top", "targetname");
    level.var_f8958643 = 256;
    level.var_b30a4f34 = getent("bunker_gate", "targetname");
    level.var_aeb5e380 = -213;
    level.var_b1194559 = 1;
    level.var_30996086 = 75;
    level.var_a58363ce = getent("bunker_gate_2", "targetname");
    level.var_7edb6806 = -106;
    level.var_74cb765 = 3;
    function_da3cd0f6();
    function_d4d1fff();
    level thread function_10b88629();
    level thread function_1b34e6b5();
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0xe7689065, Offset: 0x22e0
// Size: 0x1c
function function_1b34e6b5() {
    function_af9ff3f5(1);
}

// Namespace namespace_591ce3c5
// Params 1, eflags: 0x1 linked
// Checksum 0xe38cc944, Offset: 0x2308
// Size: 0x29c
function function_af9ff3f5(var_24a83bb) {
    if (!level.var_590ba9a6 && (level.var_590ba9a6 && var_24a83bb || !var_24a83bb)) {
        return;
    }
    level.var_590ba9a6 = var_24a83bb;
    var_309d2ff6 = level.var_ad39505b;
    var_32249404 = level.var_f8958643;
    if (!var_24a83bb) {
        var_309d2ff6 *= -1;
    }
    time = level.var_74cb765;
    accel = time / 6;
    ent = level.var_8b3df875;
    var_c36da20d = level.var_8243881a;
    ent2 = level.var_e22bae0d;
    ent playsound("amb_teleporter_gate_start");
    ent playloopsound("amb_teleporter_gate_loop", 0.5);
    pos = (ent.origin[0], ent.origin[1], ent.origin[2] - var_309d2ff6);
    ent moveto(pos, time, accel, accel);
    ent thread function_7481262b();
    pos2 = (ent2.origin[0], ent2.origin[1], ent2.origin[2] + var_309d2ff6);
    ent2 moveto(pos2, time, accel, accel);
    if (var_24a83bb) {
        ent connectpaths();
    } else {
        ent disconnectpaths();
    }
    if (var_24a83bb) {
        function_c500da1b();
        return;
    }
    function_d4d1fff();
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0xc71e5ab7, Offset: 0x25b0
// Size: 0x7e
function function_da3cd0f6() {
    level.var_2b53d7f = [];
    level.var_2b53d7f[level.var_2b53d7f.size] = "zapper_teleport_opening_1";
    level.var_2b53d7f[level.var_2b53d7f.size] = "zapper_teleport_opening_2";
    level.var_2b53d7f[level.var_2b53d7f.size] = "zapper_teleport_opening_3";
    level.var_2b53d7f[level.var_2b53d7f.size] = "zapper_teleport_opening_4";
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0x5a70b08d, Offset: 0x2638
// Size: 0x56
function function_d4d1fff() {
    for (i = 0; i < level.var_2b53d7f.size; i++) {
        namespace_2f7147af::zapper_light_red(level.var_2b53d7f[i], "targetname");
    }
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0xdd8e2256, Offset: 0x2698
// Size: 0x56
function function_c500da1b() {
    for (i = 0; i < level.var_2b53d7f.size; i++) {
        namespace_2f7147af::zapper_light_green(level.var_2b53d7f[i], "targetname");
    }
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0xdc73bf0f, Offset: 0x26f8
// Size: 0x30c
function function_2b222584() {
    function_af9ff3f5(0);
    if (isdefined(level.var_bcb149c0) && level flag::get("teleporter_used") && level.var_bcb149c0) {
        level waittill(#"between_round_over");
        util::wait_network_frame();
    }
    if (!isdefined(level.var_bcb149c0)) {
        level thread zm_audio::sndmusicsystem_playstate("round_start_first");
        level.var_bcb149c0 = 1;
    }
    level waittill(#"between_round_over");
    time = gettime();
    var_c3b353a0 = time + level.var_ae26b507 * 1000;
    var_ec354f84 = 0;
    dt = var_c3b353a0 - time;
    time0 = time + dt / 4;
    time1 = time + dt / 2;
    time2 = time + 3 * dt / 4;
    var_ad9805b5 = var_c3b353a0 - 0.75;
    while (time < var_c3b353a0) {
        time = gettime();
        switch (var_ec354f84) {
        case 0:
            if (time >= time0) {
                namespace_2f7147af::zapper_light_green(level.var_2b53d7f[0], "targetname");
                var_ec354f84++;
            }
            break;
        case 1:
            if (time >= time1) {
                namespace_2f7147af::zapper_light_green(level.var_2b53d7f[1], "targetname");
                var_ec354f84++;
            }
            break;
        case 2:
            if (time >= time2) {
                namespace_2f7147af::zapper_light_green(level.var_2b53d7f[2], "targetname");
                var_ec354f84++;
            }
            break;
        case 3:
            if (time >= var_ad9805b5) {
                namespace_2f7147af::zapper_light_green(level.var_2b53d7f[3], "targetname");
                var_ec354f84++;
                function_af9ff3f5(1);
            }
            break;
        default:
            wait(0.1);
            break;
        }
        wait(1);
    }
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0xe07e2da7, Offset: 0x2a10
// Size: 0xc8
function function_10b88629() {
    wait(3);
    level thread function_8b4490c2(0);
    while (true) {
        level flag::wait_till("enter_nml");
        if (level.var_5f225972 == 0) {
            wait(20);
        } else {
            wait(level.var_30996086);
        }
        level thread function_8b4490c2(1);
        while (level flag::get("enter_nml")) {
            wait(1);
        }
        level thread function_8b4490c2(0);
    }
}

// Namespace namespace_591ce3c5
// Params 1, eflags: 0x1 linked
// Checksum 0xc01daaf1, Offset: 0x2ae0
// Size: 0x274
function function_8b4490c2(var_24a83bb) {
    if (!level.var_b1194559 && (level.var_b1194559 && var_24a83bb || !var_24a83bb)) {
        return;
    }
    level.var_b1194559 = var_24a83bb;
    var_309d2ff6 = level.var_aeb5e380;
    var_32249404 = level.var_7edb6806;
    if (!var_24a83bb) {
        var_309d2ff6 *= -1;
        var_32249404 *= -1;
    }
    time = level.var_74cb765;
    accel = time / 6;
    ent = level.var_b30a4f34;
    ent playsound("amb_teleporter_gate_start");
    ent playloopsound("amb_teleporter_gate_loop", 0.5);
    ent2 = level.var_a58363ce;
    pos2 = (ent2.origin[0], ent2.origin[1], ent2.origin[2] - var_32249404);
    ent2 moveto(pos2, time, accel, accel);
    pos = (ent.origin[0], ent.origin[1], ent.origin[2] - var_309d2ff6);
    ent moveto(pos, time, accel, accel);
    ent thread function_7481262b();
    if (var_24a83bb) {
        ent connectpaths();
        return;
    }
    wait(level.var_74cb765);
    ent disconnectpaths();
}

// Namespace namespace_591ce3c5
// Params 0, eflags: 0x1 linked
// Checksum 0xc46abd6f, Offset: 0x2d60
// Size: 0x4c
function function_7481262b() {
    self waittill(#"movedone");
    self stoploopsound(0.5);
    self playsound("amb_teleporter_gate_stop");
}

