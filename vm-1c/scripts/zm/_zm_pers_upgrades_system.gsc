#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace namespace_d93d7691;

// Namespace namespace_d93d7691
// Params 5, eflags: 0x0
// Checksum 0x542972d4, Offset: 0x1b0
// Size: 0x178
function function_8562a0f6(name, upgrade_active_func, stat_name, stat_desired_value, game_end_reset_if_not_achieved) {
    if (!isdefined(level.var_d830ee5f)) {
        level.var_d830ee5f = [];
        level.var_2cd32f16 = [];
    }
    if (isdefined(level.var_d830ee5f[name])) {
        assert(0, "<dev string:x28>" + name);
    }
    level.var_2cd32f16[level.var_2cd32f16.size] = name;
    level.var_d830ee5f[name] = spawnstruct();
    level.var_d830ee5f[name].var_e45eb34e = [];
    level.var_d830ee5f[name].var_3f39db75 = [];
    level.var_d830ee5f[name].upgrade_active_func = upgrade_active_func;
    level.var_d830ee5f[name].game_end_reset_if_not_achieved = game_end_reset_if_not_achieved;
    function_f17b9229(name, stat_name, stat_desired_value);
    /#
        if (isdefined(level.devgui_add_ability)) {
            [[ level.devgui_add_ability ]](name, upgrade_active_func, stat_name, stat_desired_value, game_end_reset_if_not_achieved);
        }
    #/
}

// Namespace namespace_d93d7691
// Params 3, eflags: 0x0
// Checksum 0x52ab6794, Offset: 0x330
// Size: 0xc2
function function_f17b9229(name, stat_name, stat_desired_value) {
    if (!isdefined(level.var_d830ee5f[name])) {
        assert(0, name + "<dev string:x5e>");
    }
    var_6ab5b83a = level.var_d830ee5f[name].var_e45eb34e.size;
    level.var_d830ee5f[name].var_e45eb34e[var_6ab5b83a] = stat_name;
    level.var_d830ee5f[name].var_3f39db75[var_6ab5b83a] = stat_desired_value;
}

// Namespace namespace_d93d7691
// Params 0, eflags: 0x0
// Checksum 0xf0b91d4d, Offset: 0x400
// Size: 0x5a8
function function_4f17af50() {
    if (!isdefined(level.var_d830ee5f)) {
        return;
    }
    if (!zm_utility::is_classic()) {
        return;
    }
    level thread function_3f54bb5();
    while (true) {
        waittillframeend();
        players = getplayers();
        for (player_index = 0; player_index < players.size; player_index++) {
            player = players[player_index];
            if (zm_utility::is_player_valid(player) && isdefined(player.stats_this_frame)) {
                if (!player.stats_this_frame.size && !(isdefined(player.var_8d6e7587) && player.var_8d6e7587)) {
                    continue;
                }
                for (var_76226b65 = 0; var_76226b65 < level.var_2cd32f16.size; var_76226b65++) {
                    var_3ed63b1c = level.var_d830ee5f[level.var_2cd32f16[var_76226b65]];
                    var_2acc042e = player function_f6f9fb05(var_3ed63b1c);
                    if (var_2acc042e) {
                        should_award = player function_554bf15b(var_3ed63b1c);
                        if (should_award) {
                            if (isdefined(player.var_698f7e[level.var_2cd32f16[var_76226b65]]) && player.var_698f7e[level.var_2cd32f16[var_76226b65]]) {
                                continue;
                            }
                            player.var_698f7e[level.var_2cd32f16[var_76226b65]] = 1;
                            if (level flag::get("initial_blackscreen_passed") && !(isdefined(player.is_hotjoining) && player.is_hotjoining)) {
                                type = "upgrade";
                                if (isdefined(level.var_b9ce2cdb)) {
                                    type = level.var_b9ce2cdb;
                                }
                                player playsoundtoplayer("evt_player_upgrade", player);
                                if (isdefined(level.var_61eebb3) && level.var_61eebb3) {
                                    player util::delay(1, undefined, &zm_audio::create_and_play_dialog, "general", type, level.var_ed51a6);
                                }
                                if (isdefined(player.var_8cc9518d)) {
                                    fx_org = player.var_8cc9518d;
                                    player.var_8cc9518d = undefined;
                                } else {
                                    fx_org = player.origin;
                                    v_dir = anglestoforward(player getplayerangles());
                                    v_up = anglestoup(player getplayerangles());
                                    fx_org = fx_org + v_dir * 30 + v_up * 12;
                                }
                                playfx(level._effect["upgrade_aquired"], fx_org);
                                level thread zm::disable_end_game_intermission(1.5);
                            }
                            /#
                                player iprintlnbold("<dev string:x8b>");
                            #/
                            if (isdefined(var_3ed63b1c.upgrade_active_func)) {
                                player thread [[ var_3ed63b1c.upgrade_active_func ]]();
                            }
                            continue;
                        }
                        if (isdefined(player.var_698f7e[level.var_2cd32f16[var_76226b65]]) && player.var_698f7e[level.var_2cd32f16[var_76226b65]]) {
                            if (level flag::get("initial_blackscreen_passed") && !(isdefined(player.is_hotjoining) && player.is_hotjoining)) {
                                player playsoundtoplayer("evt_player_downgrade", player);
                            }
                            /#
                                player iprintlnbold("<dev string:x95>");
                            #/
                        }
                        player.var_698f7e[level.var_2cd32f16[var_76226b65]] = 0;
                    }
                }
                player.var_8d6e7587 = 0;
                player.stats_this_frame = [];
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_d93d7691
// Params 0, eflags: 0x0
// Checksum 0xca2c6830, Offset: 0x9b0
// Size: 0x1aa
function function_3f54bb5() {
    if (!zm_utility::is_classic()) {
        return;
    }
    level waittill(#"end_game");
    players = getplayers();
    for (player_index = 0; player_index < players.size; player_index++) {
        player = players[player_index];
        for (index = 0; index < level.var_2cd32f16.size; index++) {
            str_name = level.var_2cd32f16[index];
            game_end_reset_if_not_achieved = level.var_d830ee5f[str_name].game_end_reset_if_not_achieved;
            if (isdefined(game_end_reset_if_not_achieved) && game_end_reset_if_not_achieved == 1) {
                if (!(isdefined(player.var_698f7e[str_name]) && player.var_698f7e[str_name])) {
                    for (stat_index = 0; stat_index < level.var_d830ee5f[str_name].var_e45eb34e.size; stat_index++) {
                        player zm_stats::zero_client_stat(level.var_d830ee5f[str_name].var_e45eb34e[stat_index], 0);
                    }
                }
            }
        }
    }
}

// Namespace namespace_d93d7691
// Params 1, eflags: 0x0
// Checksum 0x70f111a7, Offset: 0xb68
// Size: 0xb2
function function_554bf15b(var_3ed63b1c) {
    should_award = 1;
    for (i = 0; i < var_3ed63b1c.var_e45eb34e.size; i++) {
        stat_name = var_3ed63b1c.var_e45eb34e[i];
        should_award = self function_46d989f8(stat_name, var_3ed63b1c.var_3f39db75[i]);
        if (!should_award) {
            break;
        }
    }
    return should_award;
}

// Namespace namespace_d93d7691
// Params 1, eflags: 0x0
// Checksum 0xdf4f5287, Offset: 0xc28
// Size: 0xb2
function function_f6f9fb05(var_3ed63b1c) {
    if (isdefined(self.var_8d6e7587) && self.var_8d6e7587) {
        return 1;
    }
    result = 0;
    for (i = 0; i < var_3ed63b1c.var_e45eb34e.size; i++) {
        stat_name = var_3ed63b1c.var_e45eb34e[i];
        if (isdefined(self.stats_this_frame[stat_name])) {
            result = 1;
            break;
        }
    }
    return result;
}

// Namespace namespace_d93d7691
// Params 2, eflags: 0x0
// Checksum 0xbe020bfb, Offset: 0xce8
// Size: 0x62
function function_46d989f8(stat_name, stat_desired_value) {
    should_award = 1;
    var_cd5e73a3 = self zm_stats::get_global_stat(stat_name);
    if (var_cd5e73a3 < stat_desired_value) {
        should_award = 0;
    }
    return should_award;
}

// Namespace namespace_d93d7691
// Params 0, eflags: 0x0
// Checksum 0x2176d09e, Offset: 0xd58
// Size: 0x84
function round_end() {
    if (!zm_utility::is_classic()) {
        return;
    }
    self notify(#"hash_90dc1354");
    if (isdefined(self.pers["pers_max_round_reached"])) {
        if (level.round_number > self.pers["pers_max_round_reached"]) {
            self zm_stats::set_client_stat("pers_max_round_reached", level.round_number, 0);
        }
    }
}

