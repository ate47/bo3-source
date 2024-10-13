#using scripts/zm/zm_temple_ai_monkey;
#using scripts/zm/_zm_score;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_temple_triggers;

// Namespace zm_temple_triggers
// Params 0, eflags: 0x1 linked
// Checksum 0xc35ec214, Offset: 0x368
// Size: 0x64
function main() {
    level thread function_22cb9b37();
    level thread function_9138ebab();
    level thread function_9fe2a5f8();
    level thread function_b562d08a();
}

// Namespace zm_temple_triggers
// Params 0, eflags: 0x1 linked
// Checksum 0xfedc25ad, Offset: 0x3d8
// Size: 0x54
function function_22cb9b37() {
    triggers = getentarray("code_trigger", "targetname");
    array::thread_all(triggers, &function_dbc801a5);
}

// Namespace zm_temple_triggers
// Params 0, eflags: 0x1 linked
// Checksum 0xdcf14283, Offset: 0x438
// Size: 0xb8
function function_dbc801a5() {
    code = self.script_noteworthy;
    if (!isdefined(code)) {
        code = "DPAD_UP DPAD_UP DPAD_DOWN DPAD_DOWN DPAD_LEFT DPAD_RIGHT DPAD_LEFT DPAD_RIGHT BUTTON_B BUTTON_A";
    }
    if (!isdefined(self.script_string)) {
        self.script_string = "cash";
    }
    self.players = [];
    while (true) {
        who = self waittill(#"trigger");
        if (is_in_array(self.players, who)) {
            continue;
        }
        who thread function_3a555f23(code, self);
    }
}

// Namespace zm_temple_triggers
// Params 2, eflags: 0x1 linked
// Checksum 0xd8a614a1, Offset: 0x4f8
// Size: 0x188
function function_3a555f23(code, trigger) {
    if (!isdefined(trigger.players)) {
        trigger.players = [];
    } else if (!isarray(trigger.players)) {
        trigger.players = array(trigger.players);
    }
    trigger.players[trigger.players.size] = self;
    self thread function_3c690d1e(code);
    self thread function_3fd4b023(trigger);
    var_a238d86c = self util::waittill_any_return("code_correct", "stopped_touching_trigger", "death");
    self notify(#"hash_815b6c39");
    if (var_a238d86c == "code_correct") {
        trigger function_9969ac9b(self);
        return;
    }
    trigger.players = arrayremovevalue(trigger.players, self);
}

// Namespace zm_temple_triggers
// Params 2, eflags: 0x1 linked
// Checksum 0x37c9ef78, Offset: 0x688
// Size: 0x98
function is_in_array(array, item) {
    foreach (index in array) {
        if (index == item) {
            return true;
        }
    }
    return false;
}

// Namespace zm_temple_triggers
// Params 2, eflags: 0x1 linked
// Checksum 0xb4550f95, Offset: 0x728
// Size: 0x11c
function array_remove(array, object) {
    if (!isdefined(array) && !isdefined(object)) {
        return;
    }
    new_array = [];
    foreach (item in array) {
        if (item != object) {
            if (!isdefined(new_array)) {
                new_array = [];
            } else if (!isarray(new_array)) {
                new_array = array(new_array);
            }
            new_array[new_array.size] = item;
        }
    }
    return new_array;
}

// Namespace zm_temple_triggers
// Params 1, eflags: 0x1 linked
// Checksum 0xaec05afe, Offset: 0x850
// Size: 0xfc
function array_removeundefined(array) {
    if (!isdefined(array)) {
        return;
    }
    new_array = [];
    foreach (item in array) {
        if (isdefined(item)) {
            if (!isdefined(new_array)) {
                new_array = [];
            } else if (!isarray(new_array)) {
                new_array = array(new_array);
            }
            new_array[new_array.size] = item;
        }
    }
    return new_array;
}

// Namespace zm_temple_triggers
// Params 1, eflags: 0x1 linked
// Checksum 0x150fbab4, Offset: 0x958
// Size: 0x4e
function function_9969ac9b(who) {
    switch (self.script_string) {
    case "cash":
        who zm_score::add_to_player_score(100);
        break;
    default:
        break;
    }
}

// Namespace zm_temple_triggers
// Params 1, eflags: 0x1 linked
// Checksum 0xc0a65be9, Offset: 0x9b0
// Size: 0x4a
function function_3fd4b023(trigger) {
    self endon(#"hash_815b6c39");
    while (self istouching(trigger)) {
        wait 0.1;
    }
    self notify(#"stopped_touching_trigger");
}

// Namespace zm_temple_triggers
// Params 1, eflags: 0x1 linked
// Checksum 0x251c9106, Offset: 0xa08
// Size: 0x110
function function_3c690d1e(code) {
    self endon(#"hash_815b6c39");
    var_25db6dd5 = strtok(code, " ");
    while (true) {
        for (i = 0; i < var_25db6dd5.size; i++) {
            button = var_25db6dd5[i];
            if (!self function_4cc474c2(button, 0.3)) {
                break;
            }
            if (!self function_c13da310(button, 0.3)) {
                break;
            }
            if (i == var_25db6dd5.size - 1) {
                self notify(#"code_correct");
                return;
            }
        }
        wait 0.1;
    }
}

// Namespace zm_temple_triggers
// Params 2, eflags: 0x1 linked
// Checksum 0x78db1668, Offset: 0xb20
// Size: 0x6a
function function_c13da310(button, time) {
    endtime = gettime() + time * 1000;
    while (gettime() < endtime) {
        if (!self buttonpressed(button)) {
            return true;
        }
        wait 0.01;
    }
    return false;
}

// Namespace zm_temple_triggers
// Params 2, eflags: 0x1 linked
// Checksum 0x358b248c, Offset: 0xb98
// Size: 0x6a
function function_4cc474c2(button, time) {
    endtime = gettime() + time * 1000;
    while (gettime() < endtime) {
        if (self buttonpressed(button)) {
            return true;
        }
        wait 0.01;
    }
    return false;
}

// Namespace zm_temple_triggers
// Params 0, eflags: 0x1 linked
// Checksum 0x6fe7a23b, Offset: 0xc10
// Size: 0x10e
function function_9fe2a5f8() {
    level flag::wait_till("initial_players_connected");
    var_9e00c8d5 = getentarray("slow_trigger", "targetname");
    for (t = 0; t < var_9e00c8d5.size; t++) {
        trig = var_9e00c8d5[t];
        if (!isdefined(trig.script_float)) {
            trig.script_float = 0.5;
        }
        trig.var_dd0d8675 = 1;
        trig.var_1d2ae274 = trig.script_float / trig.var_dd0d8675;
        trig thread function_15f1ebea();
    }
}

// Namespace zm_temple_triggers
// Params 0, eflags: 0x1 linked
// Checksum 0xef97744e, Offset: 0xd28
// Size: 0x78
function function_15f1ebea() {
    while (true) {
        player = self waittill(#"trigger");
        player notify(#"hash_5a1b6c4d");
        self trigger::function_thread(player, &function_9da3a2a3, &function_405ff7e2);
        wait 0.1;
    }
}

// Namespace zm_temple_triggers
// Params 2, eflags: 0x1 linked
// Checksum 0x51297ce8, Offset: 0xda8
// Size: 0x14c
function function_9da3a2a3(player, endon_condition) {
    player endon(endon_condition);
    if (isdefined(player)) {
        prevtime = gettime();
        while (player.movespeedscale > self.script_float) {
            wait 0.05;
            delta = gettime() - prevtime;
            player.movespeedscale -= delta / 1000 * self.var_1d2ae274;
            prevtime = gettime();
            player setmovespeedscale(player.movespeedscale);
        }
        player.movespeedscale = self.script_float;
        player allowjump(0);
        player allowsprint(0);
        player setmovespeedscale(self.script_float);
        player setvelocity((0, 0, 0));
    }
}

// Namespace zm_temple_triggers
// Params 1, eflags: 0x1 linked
// Checksum 0xe45b921f, Offset: 0xf00
// Size: 0x12c
function function_405ff7e2(player) {
    player endon(#"hash_5a1b6c4d");
    if (isdefined(player)) {
        prevtime = gettime();
        while (player.movespeedscale < 1) {
            wait 0.05;
            delta = gettime() - prevtime;
            player.movespeedscale += delta / 1000 * self.var_1d2ae274;
            prevtime = gettime();
            player setmovespeedscale(player.movespeedscale);
        }
        player.movespeedscale = 1;
        player allowjump(1);
        player allowsprint(1);
        player setmovespeedscale(1);
    }
}

// Namespace zm_temple_triggers
// Params 0, eflags: 0x0
// Checksum 0xac98d42e, Offset: 0x1038
// Size: 0x13c
function function_56dd6042() {
    if (!isdefined(self.script_string)) {
        self.script_string = "";
    }
    while (true) {
        /#
            box(self.origin, self.mins, self.maxs, 0, (1, 0, 0));
        #/
        corpses = getcorpsearray();
        for (i = 0; i < corpses.size; i++) {
            corpse = corpses[i];
            /#
                box(corpse.orign, corpse.mins, corpse.maxs, 0, (1, 1, 0));
            #/
            if (corpse istouching(self)) {
                self function_2850e0c2();
                return;
            }
        }
        wait 0.3;
    }
}

// Namespace zm_temple_triggers
// Params 0, eflags: 0x1 linked
// Checksum 0x9164d34f, Offset: 0x1180
// Size: 0x1c
function function_2850e0c2() {
    iprintlnbold("Corpse Trigger Activated");
}

// Namespace zm_temple_triggers
// Params 0, eflags: 0x1 linked
// Checksum 0x6ceeec50, Offset: 0x11a8
// Size: 0x136
function function_9138ebab() {
    triggers = getentarray("water_drop_trigger", "script_noteworthy");
    for (i = 0; i < triggers.size; i++) {
        trig = triggers[i];
        trig.var_839ef4da = 0.5;
        trig.var_98a50550 = 1;
        trig.var_da118935 = 1;
        if (isdefined(trig.script_string)) {
            if (trig.script_string == "sheetingonly") {
                trig.var_98a50550 = 0;
            } else if (trig.script_string == "dropsonly") {
                trig.var_da118935 = 0;
            }
        }
        trig thread function_a78234c2();
    }
}

// Namespace zm_temple_triggers
// Params 0, eflags: 0x1 linked
// Checksum 0x205ffa5e, Offset: 0x12e8
// Size: 0x10c
function function_a78234c2() {
    level flag::wait_till("initial_players_connected");
    wait 1;
    if (isdefined(self.script_flag)) {
        level flag::wait_till(self.script_flag);
    }
    if (isdefined(self.script_float)) {
        wait self.script_float;
    }
    while (true) {
        who = self waittill(#"trigger");
        if (isplayer(who)) {
            self trigger::function_thread(who, &function_ccbda65b, &function_7b9c0362);
            continue;
        }
        if (isdefined(who.var_92ce1c50)) {
            who thread [[ who.var_92ce1c50 ]](self);
        }
    }
}

// Namespace zm_temple_triggers
// Params 2, eflags: 0x1 linked
// Checksum 0x9beb4579, Offset: 0x1400
// Size: 0x1b4
function function_ccbda65b(player, endon_string) {
    if (isdefined(endon_string)) {
        player endon(endon_string);
    }
    player notify(#"hash_e3adbb48");
    player endon(#"death");
    player endon(#"disconnect");
    player endon(#"spawned_spectator");
    if (player.sessionstate == "spectator") {
        return;
    }
    if (!isdefined(player.var_46d6d7f7)) {
        player.var_46d6d7f7 = [];
    }
    if (isdefined(self.script_sound)) {
        player playsound(self.script_sound);
    }
    if (self.var_98a50550) {
        if (!isdefined(player.var_46d6d7f7)) {
            player.var_46d6d7f7 = [];
        } else if (!isarray(player.var_46d6d7f7)) {
            player.var_46d6d7f7 = array(player.var_46d6d7f7);
        }
        player.var_46d6d7f7[player.var_46d6d7f7.size] = self;
        if (!self.var_da118935) {
            player setwaterdrops(player function_16899c85());
        }
    }
    if (self.var_da118935) {
        self thread function_4dedd2e(player);
    }
}

// Namespace zm_temple_triggers
// Params 1, eflags: 0x1 linked
// Checksum 0x693304e9, Offset: 0x15c0
// Size: 0xac
function function_4dedd2e(player) {
    player notify(#"hash_e3adbb48");
    player endon(#"death");
    player endon(#"disconnect");
    player endon(#"spawned_spectator");
    player endon(#"hash_1a92fdd4");
    player clientfield::set_to_player("floorrumble", 1);
    player thread function_63ef47db();
    visionset_mgr::activate("overlay", "zm_waterfall_postfx", player);
}

// Namespace zm_temple_triggers
// Params 1, eflags: 0x1 linked
// Checksum 0x5629087a, Offset: 0x1678
// Size: 0x154
function function_7b9c0362(player) {
    if (!isdefined(player.var_46d6d7f7)) {
        player.var_46d6d7f7 = [];
    }
    if (self.var_98a50550) {
        if (self.var_da118935) {
            player notify(#"hash_1a92fdd4");
            player clientfield::set_to_player("floorrumble", 0);
            player setwaterdrops(player function_16899c85());
            visionset_mgr::deactivate("overlay", "zm_waterfall_postfx", player);
        }
        player.var_46d6d7f7 = array_remove(player.var_46d6d7f7, self);
        if (player.var_46d6d7f7.size == 0) {
            player function_a24fd169(0);
            return;
        }
        player setwaterdrops(player function_16899c85());
    }
}

// Namespace zm_temple_triggers
// Params 1, eflags: 0x1 linked
// Checksum 0x178e7640, Offset: 0x17d8
// Size: 0x4c
function function_a24fd169(delay) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_e3adbb48");
    wait delay;
    self setwaterdrops(0);
}

// Namespace zm_temple_triggers
// Params 0, eflags: 0x1 linked
// Checksum 0x6695c88b, Offset: 0x1830
// Size: 0x22
function function_16899c85() {
    if (self.var_46d6d7f7.size > 0) {
        return 50;
    }
    return 0;
}

// Namespace zm_temple_triggers
// Params 0, eflags: 0x1 linked
// Checksum 0x6bbb5551, Offset: 0x1860
// Size: 0x54
function function_b562d08a() {
    structs = struct::get_array("code_struct", "targetname");
    array::thread_all(structs, &function_9d948077);
}

// Namespace zm_temple_triggers
// Params 0, eflags: 0x1 linked
// Checksum 0x350529f6, Offset: 0x18c0
// Size: 0x244
function function_9d948077() {
    code = self.script_noteworthy;
    if (!isdefined(code)) {
        code = "DPAD_UP DPAD_DOWN DPAD_LEFT DPAD_RIGHT BUTTON_B BUTTON_A";
    }
    self.var_25db6dd5 = strtok(code, " ");
    if (!isdefined(self.script_string)) {
        self.script_string = "cash";
    }
    self.reward = self.script_string;
    if (!isdefined(self.radius)) {
        self.radius = 32;
    }
    self.radiussq = self.radius * self.radius;
    var_78785ad6 = [];
    while (true) {
        players = getplayers();
        for (i = var_78785ad6.size - 1; i >= 0; i--) {
            player = var_78785ad6[i];
            if (!self function_a7da30c(player)) {
                if (isdefined(player)) {
                    var_78785ad6 = array_remove(var_78785ad6, player);
                    self notify(#"hash_63b551c8");
                } else {
                    var_78785ad6 = array_removeundefined(var_78785ad6);
                }
            }
            players = array_remove(players, player);
        }
        for (i = 0; i < players.size; i++) {
            player = players[i];
            if (self function_a7da30c(player)) {
                self thread function_cf76be77(player);
                var_78785ad6[var_78785ad6.size] = player;
            }
        }
        wait 0.5;
    }
}

// Namespace zm_temple_triggers
// Params 1, eflags: 0x1 linked
// Checksum 0xa05e8fb0, Offset: 0x1b10
// Size: 0x10c
function function_cf76be77(player) {
    self endon(#"hash_63b551c8");
    player endon(#"death");
    player endon(#"disconnect");
    while (true) {
        for (i = 0; i < self.var_25db6dd5.size; i++) {
            button = self.var_25db6dd5[i];
            if (!player function_4cc474c2(button, 0.3)) {
                break;
            }
            if (!player function_c13da310(button, 0.3)) {
                break;
            }
            if (i == self.var_25db6dd5.size - 1) {
                self function_a6f0c56c(player);
                return;
            }
        }
        wait 0.1;
    }
}

// Namespace zm_temple_triggers
// Params 1, eflags: 0x1 linked
// Checksum 0x704e938a, Offset: 0x1c28
// Size: 0x6e
function function_a6f0c56c(player) {
    switch (self.reward) {
    case "cash":
        player zm_score::add_to_player_score(100);
        break;
    case "mb":
        zm_temple_ai_monkey::function_fb89ef58();
        break;
    default:
        break;
    }
}

// Namespace zm_temple_triggers
// Params 1, eflags: 0x1 linked
// Checksum 0xd80c5986, Offset: 0x1ca0
// Size: 0xa0
function function_a7da30c(player) {
    if (!zombie_utility::is_player_valid(player)) {
        return false;
    }
    if (abs(self.origin[2] - player.origin[2]) > 30) {
        return false;
    }
    if (distance2dsquared(self.origin, player.origin) > self.radiussq) {
        return false;
    }
    return true;
}

// Namespace zm_temple_triggers
// Params 0, eflags: 0x1 linked
// Checksum 0xf57af174, Offset: 0x1d48
// Size: 0x3c
function function_63ef47db() {
    self endon(#"hash_1a92fdd4");
    level waittill(#"intermission");
    self clientfield::set_to_player("floorrumble", 0);
}

