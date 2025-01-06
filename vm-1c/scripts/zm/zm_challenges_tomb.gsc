#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;

#namespace zm_challenges_tomb;

// Namespace zm_challenges_tomb
// Params 0, eflags: 0x2
// Checksum 0xb40e745c, Offset: 0x458
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_challenges_tomb", &__init__, &__main__, undefined);
}

// Namespace zm_challenges_tomb
// Params 0, eflags: 0x0
// Checksum 0xc8210c8d, Offset: 0x4a0
// Size: 0x174
function __init__() {
    level._challenges = spawnstruct();
    level.var_cecfad4c = [];
    level.var_b578830d = [];
    callback::on_connect(&onplayerconnect);
    callback::on_spawned(&onplayerspawned);
    n_bits = getminbitcountfornum(14);
    clientfield::register("toplayer", "challenges.challenge_complete_1", 21000, 2, "int");
    clientfield::register("toplayer", "challenges.challenge_complete_2", 21000, 2, "int");
    clientfield::register("toplayer", "challenges.challenge_complete_3", 21000, 2, "int");
    clientfield::register("toplayer", "challenges.challenge_complete_4", 21000, 2, "int");
    /#
        level thread function_c4b30f14();
    #/
}

// Namespace zm_challenges_tomb
// Params 0, eflags: 0x0
// Checksum 0x39a5a152, Offset: 0x620
// Size: 0x64
function __main__() {
    stats_init();
    var_ea241462 = getentarray("challenge_box", "targetname");
    array::thread_all(var_ea241462, &function_a4d8ba61);
}

// Namespace zm_challenges_tomb
// Params 0, eflags: 0x0
// Checksum 0x56d4e630, Offset: 0x690
// Size: 0x170
function onplayerconnect() {
    player_stats_init(self.characterindex);
    foreach (var_4d6f50a9 in level._challenges.a_players[self.characterindex].var_263ffde6) {
        var_4d6f50a9.var_cf2af0ab = 1;
        foreach (var_5d4e3783 in level.var_cecfad4c) {
            var_5d4e3783 showpart(var_4d6f50a9.var_5fff9ae3);
            var_5d4e3783 hidepart(var_4d6f50a9.str_glow_tag);
        }
    }
}

// Namespace zm_challenges_tomb
// Params 0, eflags: 0x0
// Checksum 0xa1f8c61e, Offset: 0x808
// Size: 0x200
function onplayerspawned() {
    self endon(#"disconnect");
    for (;;) {
        foreach (var_4d6f50a9 in level._challenges.a_players[self.characterindex].var_263ffde6) {
            if (!var_4d6f50a9.var_7d8cc9fc) {
                continue;
            }
            var_c4dd09e9 = 1;
            if (var_4d6f50a9.var_c404f0e7) {
                var_c4dd09e9 = 2;
            }
            self clientfield::set_to_player(var_4d6f50a9.s_parent.var_fc2a68d8, var_c4dd09e9);
        }
        foreach (var_4d6f50a9 in level._challenges.s_team.var_263ffde6) {
            if (!var_4d6f50a9.var_7d8cc9fc) {
                continue;
            }
            var_c4dd09e9 = 1;
            if (var_4d6f50a9.var_a6058410[self.characterindex]) {
                var_c4dd09e9 = 2;
            }
            self clientfield::set_to_player(var_4d6f50a9.s_parent.var_fc2a68d8, var_c4dd09e9);
        }
        wait 0.05;
    }
}

// Namespace zm_challenges_tomb
// Params 0, eflags: 0x0
// Checksum 0xcdfaf695, Offset: 0xa10
// Size: 0x13c
function stats_init() {
    level._challenges.var_263ffde6 = [];
    if (isdefined(level.var_355dffb3)) {
        [[ level.var_355dffb3 ]]();
    }
    foreach (stat in level._challenges.var_263ffde6) {
        if (isdefined(stat.var_83182b7d)) {
            level thread [[ stat.var_83182b7d ]]();
        }
    }
    level._challenges.a_players = [];
    for (i = 0; i < 4; i++) {
        player_stats_init(i);
    }
    function_84b21c77();
}

// Namespace zm_challenges_tomb
// Params 7, eflags: 0x0
// Checksum 0xe1e3a92, Offset: 0xb58
// Size: 0x190
function function_159cc09f(str_name, var_2fa4bcd3, str_hint, n_goal, var_73b23f8a, var_25295d79, var_83182b7d) {
    if (!isdefined(var_2fa4bcd3)) {
        var_2fa4bcd3 = 0;
    }
    if (!isdefined(str_hint)) {
        str_hint = %;
    }
    if (!isdefined(n_goal)) {
        n_goal = 1;
    }
    stat = spawnstruct();
    stat.str_name = str_name;
    stat.var_2fa4bcd3 = var_2fa4bcd3;
    stat.str_hint = str_hint;
    stat.n_goal = n_goal;
    stat.var_73b23f8a = var_73b23f8a;
    stat.var_25295d79 = var_25295d79;
    stat.n_index = level._challenges.var_263ffde6.size;
    if (isdefined(var_83182b7d)) {
        stat.var_83182b7d = var_83182b7d;
    }
    level._challenges.var_263ffde6[str_name] = stat;
    stat.var_fc2a68d8 = "challenges.challenge_complete_" + level._challenges.var_263ffde6.size;
}

// Namespace zm_challenges_tomb
// Params 1, eflags: 0x0
// Checksum 0x6b2b6294, Offset: 0xcf0
// Size: 0x2d8
function player_stats_init(n_index) {
    var_56d6268d = array("d", "n", "r", "t");
    str_character = var_56d6268d[n_index];
    if (!isdefined(level._challenges.a_players[n_index])) {
        level._challenges.a_players[n_index] = spawnstruct();
        level._challenges.a_players[n_index].var_263ffde6 = [];
    }
    var_361752fd = level._challenges.a_players[n_index];
    n_challenge_index = 1;
    foreach (s_challenge in level._challenges.var_263ffde6) {
        if (!s_challenge.var_2fa4bcd3) {
            if (!isdefined(var_361752fd.var_263ffde6[s_challenge.str_name])) {
                var_361752fd.var_263ffde6[s_challenge.str_name] = spawnstruct();
            }
            var_4d6f50a9 = var_361752fd.var_263ffde6[s_challenge.str_name];
            var_4d6f50a9.s_parent = s_challenge;
            var_4d6f50a9.n_value = 0;
            var_4d6f50a9.var_7d8cc9fc = 0;
            var_4d6f50a9.var_c404f0e7 = 0;
            n_index = level._challenges.var_263ffde6.size + 1;
            var_4d6f50a9.var_5fff9ae3 = "j_" + str_character + "_medal_0" + n_challenge_index;
            var_4d6f50a9.str_glow_tag = "j_" + str_character + "_glow_0" + n_challenge_index;
            var_4d6f50a9.var_cf2af0ab = 0;
            n_challenge_index++;
        }
    }
    var_361752fd.var_48707d47 = 0;
    var_361752fd.var_549197ae = 0;
}

// Namespace zm_challenges_tomb
// Params 1, eflags: 0x0
// Checksum 0xa2ca1301, Offset: 0xfd0
// Size: 0x244
function function_84b21c77(n_index) {
    if (!isdefined(level._challenges.s_team)) {
        level._challenges.s_team = spawnstruct();
        level._challenges.s_team.var_263ffde6 = [];
    }
    var_a1a51311 = level._challenges.s_team;
    foreach (s_challenge in level._challenges.var_263ffde6) {
        if (s_challenge.var_2fa4bcd3) {
            if (!isdefined(var_a1a51311.var_263ffde6[s_challenge.str_name])) {
                var_a1a51311.var_263ffde6[s_challenge.str_name] = spawnstruct();
            }
            var_4d6f50a9 = var_a1a51311.var_263ffde6[s_challenge.str_name];
            var_4d6f50a9.s_parent = s_challenge;
            var_4d6f50a9.n_value = 0;
            var_4d6f50a9.var_7d8cc9fc = 0;
            var_4d6f50a9.var_c404f0e7 = 0;
            var_4d6f50a9.var_a6058410 = array(0, 0, 0, 0);
            var_4d6f50a9.var_5fff9ae3 = "j_g_medal";
            var_4d6f50a9.str_glow_tag = "j_g_glow";
            var_4d6f50a9.var_cf2af0ab = 1;
        }
    }
    var_a1a51311.var_48707d47 = 0;
    var_a1a51311.var_549197ae = 0;
}

// Namespace zm_challenges_tomb
// Params 1, eflags: 0x0
// Checksum 0xd251b990, Offset: 0x1220
// Size: 0x34
function function_db40117f(str_name) {
    if (isdefined(level._challenges.var_263ffde6[str_name])) {
        return 1;
    }
    return 0;
}

// Namespace zm_challenges_tomb
// Params 2, eflags: 0x0
// Checksum 0xc869cbaa, Offset: 0x1260
// Size: 0x126
function get_stat(var_d7f161b3, player) {
    var_b6b42d20 = level._challenges.var_263ffde6[var_d7f161b3];
    assert(isdefined(var_b6b42d20), "<dev string:x28>" + var_d7f161b3 + "<dev string:x39>");
    assert(var_b6b42d20.var_2fa4bcd3 || isdefined(player), "<dev string:x28>" + var_d7f161b3 + "<dev string:x49>");
    if (var_b6b42d20.var_2fa4bcd3) {
        var_4d6f50a9 = level._challenges.s_team.var_263ffde6[var_d7f161b3];
    } else {
        var_4d6f50a9 = level._challenges.a_players[player.characterindex].var_263ffde6[var_d7f161b3];
    }
    return var_4d6f50a9;
}

// Namespace zm_challenges_tomb
// Params 2, eflags: 0x0
// Checksum 0xc1da97c, Offset: 0x1390
// Size: 0x9c
function function_6b433789(var_d7f161b3, n_increment) {
    if (!isdefined(n_increment)) {
        n_increment = 1;
    }
    var_4d6f50a9 = get_stat(var_d7f161b3, self);
    if (!var_4d6f50a9.var_7d8cc9fc) {
        var_4d6f50a9.n_value += n_increment;
        function_9b9cb71e(var_4d6f50a9);
    }
}

// Namespace zm_challenges_tomb
// Params 2, eflags: 0x0
// Checksum 0xf2625a96, Offset: 0x1438
// Size: 0x74
function set_stat(var_d7f161b3, n_set) {
    var_4d6f50a9 = get_stat(var_d7f161b3, self);
    if (!var_4d6f50a9.var_7d8cc9fc) {
        var_4d6f50a9.n_value = n_set;
        function_9b9cb71e(var_4d6f50a9);
    }
}

// Namespace zm_challenges_tomb
// Params 2, eflags: 0x0
// Checksum 0x8ca23e83, Offset: 0x14b8
// Size: 0x44
function function_fbbc8608(str_hint, var_7ca2c2ae) {
    self luinotifyevent(%trial_complete, 3, %ZM_TOMB_CHALLENGE_COMPLETED, str_hint, var_7ca2c2ae);
}

// Namespace zm_challenges_tomb
// Params 1, eflags: 0x0
// Checksum 0x4eef580e, Offset: 0x1508
// Size: 0x4cc
function function_9b9cb71e(var_4d6f50a9) {
    if (var_4d6f50a9.var_7d8cc9fc) {
        return 1;
    }
    if (var_4d6f50a9.n_value >= var_4d6f50a9.s_parent.n_goal) {
        var_4d6f50a9.var_7d8cc9fc = 1;
        if (var_4d6f50a9.s_parent.var_2fa4bcd3) {
            var_aad70fc = level._challenges.s_team;
            var_aad70fc.var_48707d47++;
            var_aad70fc.var_549197ae++;
            a_players = getplayers();
            foreach (player in a_players) {
                player clientfield::set_to_player(var_4d6f50a9.s_parent.var_fc2a68d8, 1);
                player function_fbbc8608(var_4d6f50a9.s_parent.str_hint, var_4d6f50a9.s_parent.n_index);
                player playsound("evt_medal_acquired");
                util::wait_network_frame();
            }
        } else {
            var_47da0bc8 = level._challenges.a_players[self.characterindex];
            var_47da0bc8.var_48707d47++;
            var_47da0bc8.var_549197ae++;
            self playsound("evt_medal_acquired");
            self clientfield::set_to_player(var_4d6f50a9.s_parent.var_fc2a68d8, 1);
            self function_fbbc8608(var_4d6f50a9.s_parent.str_hint, var_4d6f50a9.s_parent.n_index);
        }
        foreach (var_5d4e3783 in level.var_cecfad4c) {
            var_5d4e3783 showpart(var_4d6f50a9.str_glow_tag);
        }
        if (isplayer(self)) {
            if (level._challenges.a_players[self.characterindex].var_48707d47 + level._challenges.s_team.var_48707d47 == level._challenges.var_263ffde6.size) {
                self notify(#"all_challenges_complete");
            }
        } else {
            foreach (player in getplayers()) {
                if (isdefined(player.characterindex)) {
                    if (level._challenges.a_players[player.characterindex].var_48707d47 + level._challenges.s_team.var_48707d47 == level._challenges.var_263ffde6.size) {
                        player notify(#"all_challenges_complete");
                    }
                }
            }
        }
        util::wait_network_frame();
    }
}

// Namespace zm_challenges_tomb
// Params 2, eflags: 0x0
// Checksum 0x979c8c8f, Offset: 0x19e0
// Size: 0xcc
function function_6f71437b(stat, player) {
    if (isstring(stat)) {
        var_4d6f50a9 = get_stat(stat, player);
    } else {
        var_4d6f50a9 = stat;
    }
    if (!var_4d6f50a9.var_7d8cc9fc) {
        return false;
    }
    if (var_4d6f50a9.var_c404f0e7) {
        return false;
    }
    if (var_4d6f50a9.s_parent.var_2fa4bcd3 && var_4d6f50a9.var_a6058410[player.characterindex]) {
        return false;
    }
    return true;
}

// Namespace zm_challenges_tomb
// Params 0, eflags: 0x0
// Checksum 0x3c2fef19, Offset: 0x1ab8
// Size: 0xb8
function function_aa1a2ed4() {
    foreach (var_4d6f50a9 in level._challenges.s_team.var_263ffde6) {
        if (var_4d6f50a9.var_7d8cc9fc && !var_4d6f50a9.var_a6058410[self.characterindex]) {
            return true;
        }
    }
    return false;
}

// Namespace zm_challenges_tomb
// Params 1, eflags: 0x0
// Checksum 0xffa1d1f9, Offset: 0x1b78
// Size: 0x5aa
function function_79ebf8a4(var_5d4e3783) {
    self.var_5d4e3783 = var_5d4e3783;
    a_challenges = getarraykeys(level._challenges.var_263ffde6);
    var_56d6268d = array("d", "n", "r", "t");
    var_5d4e3783.var_c22fcf18 = [];
    var_18290dde = 0;
    foreach (n_char_index, var_6ec888f5 in level._challenges.a_players) {
        str_character = var_56d6268d[n_char_index];
        n_challenge_index = 1;
        foreach (var_4d6f50a9 in var_6ec888f5.var_263ffde6) {
            var_5fff9ae3 = "j_" + str_character + "_medal_0" + n_challenge_index;
            str_glow_tag = "j_" + str_character + "_glow_0" + n_challenge_index;
            var_dcf46be5 = spawnstruct();
            var_dcf46be5.v_origin = var_5d4e3783 gettagorigin(var_5fff9ae3);
            var_dcf46be5.var_4d6f50a9 = var_4d6f50a9;
            var_dcf46be5.n_character_index = n_char_index;
            var_dcf46be5.var_5fff9ae3 = var_5fff9ae3;
            if (!isdefined(var_5d4e3783.var_c22fcf18)) {
                var_5d4e3783.var_c22fcf18 = [];
            } else if (!isarray(var_5d4e3783.var_c22fcf18)) {
                var_5d4e3783.var_c22fcf18 = array(var_5d4e3783.var_c22fcf18);
            }
            var_5d4e3783.var_c22fcf18[var_5d4e3783.var_c22fcf18.size] = var_dcf46be5;
            var_5d4e3783 hidepart(var_5fff9ae3);
            var_5d4e3783 hidepart(str_glow_tag);
            n_challenge_index++;
        }
    }
    foreach (var_4d6f50a9 in level._challenges.s_team.var_263ffde6) {
        var_5fff9ae3 = "j_g_medal";
        str_glow_tag = "j_g_glow";
        var_dcf46be5 = spawnstruct();
        var_dcf46be5.v_origin = var_5d4e3783 gettagorigin(var_5fff9ae3);
        var_dcf46be5.var_4d6f50a9 = var_4d6f50a9;
        var_dcf46be5.n_character_index = 4;
        var_dcf46be5.var_5fff9ae3 = var_5fff9ae3;
        if (!isdefined(var_5d4e3783.var_c22fcf18)) {
            var_5d4e3783.var_c22fcf18 = [];
        } else if (!isarray(var_5d4e3783.var_c22fcf18)) {
            var_5d4e3783.var_c22fcf18 = array(var_5d4e3783.var_c22fcf18);
        }
        var_5d4e3783.var_c22fcf18[var_5d4e3783.var_c22fcf18.size] = var_dcf46be5;
        var_5d4e3783 hidepart(str_glow_tag);
        var_18290dde = 1;
    }
    if (!isdefined(level.var_cecfad4c)) {
        level.var_cecfad4c = [];
    } else if (!isarray(level.var_cecfad4c)) {
        level.var_cecfad4c = array(level.var_cecfad4c);
    }
    level.var_cecfad4c[level.var_cecfad4c.size] = var_5d4e3783;
}

// Namespace zm_challenges_tomb
// Params 0, eflags: 0x0
// Checksum 0x31cefc0e, Offset: 0x2130
// Size: 0x2a4
function function_a4d8ba61() {
    s_unitrigger_stub = spawnstruct();
    s_unitrigger_stub.origin = self.origin + (0, 0, 0);
    s_unitrigger_stub.angles = self.angles;
    s_unitrigger_stub.radius = 64;
    s_unitrigger_stub.script_length = 64;
    s_unitrigger_stub.script_width = 64;
    s_unitrigger_stub.script_height = 64;
    s_unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_unitrigger_stub.hint_string = %;
    s_unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_unitrigger_stub.prompt_and_visibility_func = &function_ce473431;
    s_unitrigger_stub flag::init("waiting_for_grab");
    s_unitrigger_stub flag::init("reward_timeout");
    s_unitrigger_stub.var_b3a978e7 = 0;
    s_unitrigger_stub.var_e32cd584 = self;
    s_unitrigger_stub.var_908f25c5 = 0;
    if (isdefined(self.script_string)) {
        s_unitrigger_stub.str_location = self.script_string;
    }
    if (isdefined(s_unitrigger_stub.var_e32cd584.target)) {
        s_unitrigger_stub.var_5d4e3783 = getent(s_unitrigger_stub.var_e32cd584.target, "targetname");
        s_unitrigger_stub function_79ebf8a4(s_unitrigger_stub.var_5d4e3783);
    }
    zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger_stub, 1);
    if (!isdefined(level.var_b578830d)) {
        level.var_b578830d = [];
    } else if (!isarray(level.var_b578830d)) {
        level.var_b578830d = array(level.var_b578830d);
    }
    level.var_b578830d[level.var_b578830d.size] = s_unitrigger_stub;
    zm_unitrigger::register_static_unitrigger(s_unitrigger_stub, &function_2ade4ad9);
}

// Namespace zm_challenges_tomb
// Params 1, eflags: 0x0
// Checksum 0x7163c67b, Offset: 0x23e0
// Size: 0x40
function function_ce473431(player) {
    if (self.stub.var_908f25c5) {
        return false;
    }
    self function_11e941ed(player);
    return true;
}

// Namespace zm_challenges_tomb
// Params 1, eflags: 0x0
// Checksum 0x30fb243d, Offset: 0x2428
// Size: 0x544
function function_11e941ed(player) {
    str_hint = %;
    var_b7b6d234 = %;
    var_5d4e3783 = self.stub.var_5d4e3783;
    self sethintstring(str_hint);
    var_c2ae7725 = undefined;
    var_570ed0c6 = 0;
    self.var_1b22c709 = 0;
    if (self.stub.var_b3a978e7) {
        if (!isdefined(self.stub.player_using) || self.stub flag::get("waiting_for_grab") && self.stub.player_using == player) {
            str_hint = %ZM_TOMB_CH_G;
        } else {
            str_hint = %;
        }
    } else {
        str_hint = %;
        player.var_dd891766 = undefined;
        var_184ab935 = 0.996;
        var_b9f3ddcc = player getplayercamerapos();
        var_bff77cb5 = anglestoforward(player getplayerangles());
        foreach (var_dcf46be5 in var_5d4e3783.var_c22fcf18) {
            if (!var_dcf46be5.var_4d6f50a9.var_cf2af0ab) {
                continue;
            }
            v_tag_origin = var_dcf46be5.v_origin;
            var_455cd818 = vectornormalize(v_tag_origin - var_b9f3ddcc);
            n_dot = vectordot(var_455cd818, var_bff77cb5);
            if (n_dot > var_184ab935) {
                var_184ab935 = n_dot;
                str_hint = var_dcf46be5.var_4d6f50a9.s_parent.str_hint;
                var_c2ae7725 = var_dcf46be5;
                var_570ed0c6 = 1;
                self.var_1b22c709 = 0;
                if (var_dcf46be5.n_character_index == player.characterindex || var_dcf46be5.n_character_index == 4) {
                    player.var_dd891766 = var_dcf46be5.var_4d6f50a9;
                    if (function_6f71437b(var_dcf46be5.var_4d6f50a9, player)) {
                        str_hint = %ZM_TOMB_CH_S;
                        var_570ed0c6 = 0;
                        self.var_1b22c709 = 1;
                    }
                }
            }
        }
        if (str_hint == %) {
            var_eaab1ad4 = level._challenges.a_players[player.characterindex];
            s_team = level._challenges.s_team;
            if (var_eaab1ad4.var_549197ae > 0 || player function_aa1a2ed4()) {
                str_hint = %ZM_TOMB_CH_O;
                self.var_1b22c709 = 1;
            } else {
                str_hint = %ZM_TOMB_CH_V;
            }
        }
    }
    if (var_b7b6d234 != str_hint) {
        var_b7b6d234 = str_hint;
        self.stub.hint_string = str_hint;
        if (isdefined(var_c2ae7725)) {
            str_name = var_c2ae7725.var_4d6f50a9.s_parent.str_name;
            n_character_index = var_c2ae7725.n_character_index;
            if (n_character_index != 4) {
                var_7506f721 = level._challenges.a_players[n_character_index].var_263ffde6[str_name];
            }
        }
        self sethintstring(self.stub.hint_string);
    }
}

// Namespace zm_challenges_tomb
// Params 0, eflags: 0x0
// Checksum 0x30fc7c97, Offset: 0x2978
// Size: 0x290
function function_2ade4ad9() {
    self endon(#"kill_trigger");
    s_team = level._challenges.s_team;
    while (true) {
        self waittill(#"trigger", player);
        if (!zombie_utility::is_player_valid(player)) {
            continue;
        }
        if (self.stub.var_b3a978e7) {
            current_weapon = player getcurrentweapon();
            if (isdefined(player.intermission) && player.intermission || zm_utility::is_placeable_mine(current_weapon) || zm_equipment::is_equipment_that_blocks_purchase(current_weapon) || current_weapon == level.weaponnone || player laststand::player_is_in_laststand() || player isthrowinggrenade() || player zm_utility::in_revive_trigger() || player isswitchingweapons() || player.is_drinking > 0) {
                wait 0.1;
                continue;
            }
            if (self.stub flag::get("waiting_for_grab")) {
                if (!isdefined(self.stub.player_using)) {
                    self.stub.player_using = player;
                }
                if (player == self.stub.player_using) {
                    self.stub flag::clear("waiting_for_grab");
                }
            }
            wait 0.05;
            continue;
        }
        if (self.var_1b22c709) {
            self.stub.hint_string = %;
            self sethintstring(self.stub.hint_string);
            level thread function_139222f7(player, self.stub);
        }
    }
}

// Namespace zm_challenges_tomb
// Params 2, eflags: 0x0
// Checksum 0x9b6fbd47, Offset: 0x2c10
// Size: 0xbc
function function_b57f4ca(player, var_5425da88) {
    if (isdefined(var_5425da88) && var_5425da88.s_parent.var_2fa4bcd3 || level._challenges.s_team.var_549197ae > 0) {
        return level._challenges.s_team;
    }
    if (level._challenges.a_players[player.characterindex].var_549197ae > 0) {
        return level._challenges.a_players[player.characterindex];
    }
    return undefined;
}

// Namespace zm_challenges_tomb
// Params 1, eflags: 0x0
// Checksum 0x4c4f0ef1, Offset: 0x2cd8
// Size: 0xe6
function function_696ee824(var_26ef0df7) {
    foreach (var_4d6f50a9 in var_26ef0df7.var_263ffde6) {
        if (var_4d6f50a9.var_7d8cc9fc && !var_4d6f50a9.var_c404f0e7) {
            if (var_4d6f50a9.s_parent.var_2fa4bcd3 && var_4d6f50a9.var_a6058410[self.characterindex]) {
                continue;
            }
            return var_4d6f50a9;
        }
    }
    return undefined;
}

// Namespace zm_challenges_tomb
// Params 4, eflags: 0x0
// Checksum 0x46ef9a36, Offset: 0x2dc8
// Size: 0x1e2
function function_139222f7(player, var_b34e04c1, var_98916baa, param1) {
    var_e32cd584 = var_b34e04c1.var_e32cd584;
    while (var_b34e04c1.var_b3a978e7) {
        wait 1;
    }
    var_b34e04c1.var_b3a978e7 = 1;
    var_b34e04c1.player_using = player;
    if (isdefined(player) && isdefined(player.var_dd891766)) {
        var_5425da88 = player.var_dd891766;
    }
    var_e32cd584 thread scene::play("p7_fxanim_zm_ori_challenge_box_open_bundle", var_e32cd584);
    var_e32cd584 util::delay(0.75, undefined, &clientfield::set, "foot_print_box_glow", 1);
    wait 0.5;
    if (isdefined(var_98916baa)) {
        var_b34e04c1 [[ var_98916baa ]](player, param1);
    } else {
        var_b34e04c1 spawn_reward(player, var_5425da88);
    }
    wait 1;
    var_e32cd584 thread scene::play("p7_fxanim_zm_ori_challenge_box_close_bundle", var_e32cd584);
    var_e32cd584 util::delay(0.75, undefined, &clientfield::set, "foot_print_box_glow", 0);
    wait 2;
    var_b34e04c1.var_b3a978e7 = 0;
    var_b34e04c1.player_using = undefined;
}

// Namespace zm_challenges_tomb
// Params 2, eflags: 0x0
// Checksum 0x31e82253, Offset: 0x2fb8
// Size: 0x254
function spawn_reward(player, var_5425da88) {
    if (isdefined(player)) {
        player endon(#"death_or_disconnect");
        if (isdefined(var_5425da88)) {
            var_26ef0df7 = function_b57f4ca(player, var_5425da88);
            if (function_6f71437b(var_5425da88, player)) {
                var_4d6f50a9 = var_5425da88;
            }
        }
        if (!isdefined(var_4d6f50a9)) {
            var_26ef0df7 = function_b57f4ca(player);
            var_4d6f50a9 = player function_696ee824(var_26ef0df7);
        }
        if (self [[ var_4d6f50a9.s_parent.var_25295d79 ]](player, var_4d6f50a9)) {
            if (isdefined(var_4d6f50a9.s_parent.var_fc2a68d8)) {
                player clientfield::set_to_player(var_4d6f50a9.s_parent.var_fc2a68d8, 2);
            }
            if (var_4d6f50a9.s_parent.var_2fa4bcd3) {
                var_4d6f50a9.var_a6058410[player.characterindex] = 1;
                a_players = getplayers();
                foreach (player in a_players) {
                    if (!var_4d6f50a9.var_a6058410[player.characterindex]) {
                        return;
                    }
                }
            }
            var_4d6f50a9.var_c404f0e7 = 1;
            var_26ef0df7.var_549197ae--;
        }
    }
}

// Namespace zm_challenges_tomb
// Params 1, eflags: 0x0
// Checksum 0x99b65df1, Offset: 0x3218
// Size: 0xd4
function function_135bd5c3(n_timeout) {
    if (!isdefined(n_timeout)) {
        n_timeout = 10;
    }
    self flag::clear("reward_timeout");
    self flag::set("waiting_for_grab");
    self endon(#"waiting_for_grab");
    if (n_timeout > 0) {
        wait n_timeout;
        self flag::set("reward_timeout");
        self flag::clear("waiting_for_grab");
        return;
    }
    self flag::wait_till_clear("waiting_for_grab");
}

// Namespace zm_challenges_tomb
// Params 3, eflags: 0x0
// Checksum 0x9465fb9b, Offset: 0x32f8
// Size: 0x54
function function_bfb87de6(n_delay, n_z, n_time) {
    if (isdefined(n_delay)) {
        wait n_delay;
        if (isdefined(self)) {
            self movez(n_z * -1, n_time);
        }
    }
}

// Namespace zm_challenges_tomb
// Params 5, eflags: 0x0
// Checksum 0xde7e3a53, Offset: 0x3358
// Size: 0xc6
function function_aeb6a22b(var_a003a924, n_z, var_b1c5fa89, n_delay, n_timeout) {
    var_a003a924 movez(n_z, var_b1c5fa89);
    wait var_b1c5fa89;
    if (n_timeout > 0) {
        var_a003a924 thread function_bfb87de6(n_delay, n_z, n_timeout + 1);
    }
    self function_135bd5c3(n_timeout);
    if (self flag::get("reward_timeout")) {
        return false;
    }
    return true;
}

// Namespace zm_challenges_tomb
// Params 2, eflags: 0x0
// Checksum 0x8f6cbcb8, Offset: 0x3428
// Size: 0x2c
function function_e3be24c2(player, var_4d6f50a9) {
    player zm_score::add_to_player_score(2500);
}

/#

    // Namespace zm_challenges_tomb
    // Params 0, eflags: 0x0
    // Checksum 0xe58f6653, Offset: 0x3460
    // Size: 0x9c
    function function_c4b30f14() {
        setdvar("<dev string:x74>", "<dev string:x84>");
        adddebugcommand("<dev string:x86>");
        adddebugcommand("<dev string:xc9>");
        adddebugcommand("<dev string:x10c>");
        adddebugcommand("<dev string:x14f>");
        thread function_eed01f76();
    }

    // Namespace zm_challenges_tomb
    // Params 0, eflags: 0x0
    // Checksum 0x67226673, Offset: 0x3508
    // Size: 0x80
    function function_eed01f76() {
        while (true) {
            var_cff2b09d = getdvarint("<dev string:x74>");
            if (var_cff2b09d != 0) {
                function_10834033(var_cff2b09d);
                setdvar("<dev string:x74>", 0);
            }
            wait 0.5;
        }
    }

    // Namespace zm_challenges_tomb
    // Params 1, eflags: 0x0
    // Checksum 0xa884a870, Offset: 0x3590
    // Size: 0x4e0
    function function_10834033(n_index) {
        if (n_index == 4) {
            var_aad70fc = level._challenges.s_team;
            var_aad70fc.var_48707d47 = 1;
            var_aad70fc.var_549197ae = 1;
            a_keys = getarraykeys(level._challenges.s_team.var_263ffde6);
            var_4d6f50a9 = level._challenges.s_team.var_263ffde6[a_keys[0]];
            var_4d6f50a9.var_7d8cc9fc = 1;
            var_4d6f50a9.var_c404f0e7 = 0;
            a_players = getplayers();
            foreach (player in a_players) {
                var_4d6f50a9.var_a6058410[player.characterindex] = 0;
                player clientfield::set_to_player(var_4d6f50a9.s_parent.var_fc2a68d8, 1);
                player function_fbbc8608(var_4d6f50a9.s_parent.str_hint, var_4d6f50a9.s_parent.n_index);
            }
            foreach (var_5d4e3783 in level.var_cecfad4c) {
                var_5d4e3783 showpart(var_4d6f50a9.str_glow_tag);
            }
            return;
        }
        a_keys = getarraykeys(level._challenges.a_players[0].var_263ffde6);
        a_players = getplayers();
        foreach (player in a_players) {
            var_ddb2274b = level._challenges.a_players[player.characterindex];
            var_ddb2274b.var_48707d47++;
            var_ddb2274b.var_549197ae++;
            var_4d6f50a9 = var_ddb2274b.var_263ffde6[a_keys[n_index - 1]];
            var_4d6f50a9.var_7d8cc9fc = 1;
            var_4d6f50a9.var_c404f0e7 = 0;
            player clientfield::set_to_player(var_4d6f50a9.s_parent.var_fc2a68d8, 1);
            player function_fbbc8608(var_4d6f50a9.s_parent.str_hint, var_4d6f50a9.s_parent.n_index);
            foreach (var_5d4e3783 in level.var_cecfad4c) {
                var_5d4e3783 showpart(var_4d6f50a9.str_glow_tag);
            }
        }
    }

#/
