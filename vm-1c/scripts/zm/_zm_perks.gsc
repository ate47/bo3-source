#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_bb;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;

#namespace zm_perks;

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0x6bd042e2, Offset: 0x700
// Size: 0x32c
function init() {
    level.perk_purchase_limit = 4;
    perks_register_clientfield();
    if (!level.enable_magic) {
        return;
    }
    function_aa9d5b3f();
    perk_machine_spawn_init();
    vending_weapon_upgrade_trigger = [];
    var_3be8a3b8 = getentarray("zombie_vending", "targetname");
    if (var_3be8a3b8.size < 1) {
        return;
    }
    level.machine_assets = [];
    if (!isdefined(level.custom_vending_precaching)) {
        level.custom_vending_precaching = &default_vending_precaching;
    }
    [[ level.custom_vending_precaching ]]();
    zombie_utility::set_zombie_var("zombie_perk_cost", 2000);
    array::thread_all(var_3be8a3b8, &vending_trigger_think);
    array::thread_all(var_3be8a3b8, &electric_perks_dialog);
    if (level._custom_perks.size > 0) {
        a_keys = getarraykeys(level._custom_perks);
        for (i = 0; i < a_keys.size; i++) {
            if (isdefined(level._custom_perks[a_keys[i]].perk_machine_thread)) {
                level thread [[ level._custom_perks[a_keys[i]].perk_machine_thread ]]();
            }
            if (isdefined(level._custom_perks[a_keys[i]].perk_machine_power_override_thread)) {
                level thread [[ level._custom_perks[a_keys[i]].perk_machine_power_override_thread ]]();
                continue;
            }
            if (isdefined(level._custom_perks[a_keys[i]].alias) && isdefined(level._custom_perks[a_keys[i]].radiant_machine_name) && isdefined(level._custom_perks[a_keys[i]].machine_light_effect)) {
                level thread perk_machine_think(a_keys[i], level._custom_perks[a_keys[i]]);
            }
        }
    }
    if (isdefined(level.quantum_bomb_register_result_func)) {
        [[ level.quantum_bomb_register_result_func ]]("give_nearest_perk", &quantum_bomb_give_nearest_perk_result, 10, &quantum_bomb_give_nearest_perk_validation);
    }
    level thread perk_hostmigration();
}

// Namespace zm_perks
// Params 2, eflags: 0x0
// Checksum 0xfb96891, Offset: 0xa38
// Size: 0x3c0
function perk_machine_think(str_key, s_custom_perk) {
    str_endon = str_key + "_power_thread_end";
    level endon(str_endon);
    str_on = s_custom_perk.alias + "_on";
    str_off = s_custom_perk.alias + "_off";
    str_notify = str_key + "_power_on";
    while (true) {
        machine = getentarray(s_custom_perk.radiant_machine_name, "targetname");
        machine_triggers = getentarray(s_custom_perk.radiant_machine_name, "target");
        for (i = 0; i < machine.size; i++) {
            machine[i] setmodel(level.machine_assets[str_key].off_model);
            machine[i] solid();
        }
        level thread do_initial_power_off_callback(machine, str_key);
        array::thread_all(machine_triggers, &set_power_on, 0);
        level waittill(str_on);
        for (i = 0; i < machine.size; i++) {
            machine[i] setmodel(level.machine_assets[str_key].on_model);
            machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
            machine[i] playsound("zmb_perks_power_on");
            machine[i] thread perk_fx(s_custom_perk.machine_light_effect);
            machine[i] thread play_loop_on_machine();
        }
        level notify(str_notify);
        array::thread_all(machine_triggers, &set_power_on, 1);
        if (isdefined(level.machine_assets[str_key].power_on_callback)) {
            array::thread_all(machine, level.machine_assets[str_key].power_on_callback);
        }
        level waittill(str_off);
        if (isdefined(level.machine_assets[str_key].power_off_callback)) {
            array::thread_all(machine, level.machine_assets[str_key].power_off_callback);
        }
        array::thread_all(machine, &turn_perk_off);
    }
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0x8ee7ab53, Offset: 0xe00
// Size: 0xae
function default_vending_precaching() {
    if (level._custom_perks.size > 0) {
        a_keys = getarraykeys(level._custom_perks);
        for (i = 0; i < a_keys.size; i++) {
            if (isdefined(level._custom_perks[a_keys[i]].precache_func)) {
                level [[ level._custom_perks[a_keys[i]].precache_func ]]();
            }
        }
    }
}

// Namespace zm_perks
// Params 2, eflags: 0x0
// Checksum 0xe9d40f1c, Offset: 0xeb8
// Size: 0x9c
function do_initial_power_off_callback(machine_array, perkname) {
    if (!isdefined(level.machine_assets[perkname])) {
        println("<dev string:x28>");
        return;
    }
    if (!isdefined(level.machine_assets[perkname].power_off_callback)) {
        return;
    }
    wait 0.05;
    array::thread_all(machine_array, level.machine_assets[perkname].power_off_callback);
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0xa672aef8, Offset: 0xf60
// Size: 0x90
function function_23ee6fc() {
    if (isdefined(level.var_8e77ad87)) {
        return [[ level.var_8e77ad87 ]]();
    }
    players = getplayers();
    var_2d92a626 = 0;
    if (isdefined(level.var_1bc2b35c) && (players.size == 1 || level.var_1bc2b35c)) {
        var_2d92a626 = 1;
    }
    level.var_809c5639 = var_2d92a626;
    return var_2d92a626;
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0x6c27850f, Offset: 0xff8
// Size: 0x18
function set_power_on(state) {
    self.power_on = state;
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0xf969ad45, Offset: 0x1018
// Size: 0x114
function turn_perk_off(ishidden) {
    self notify(#"stop_loopsound");
    if (!(isdefined(self.b_keep_when_turned_off) && self.b_keep_when_turned_off)) {
        newmachine = spawn("script_model", self.origin);
        newmachine.angles = self.angles;
        newmachine.targetname = self.targetname;
        if (isdefined(ishidden) && ishidden) {
            newmachine.ishidden = 1;
            newmachine ghost();
            newmachine notsolid();
        }
        self delete();
        return;
    }
    perk_fx(undefined, 1);
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0x512b5493, Offset: 0x1138
// Size: 0xac
function play_loop_on_machine() {
    if (isdefined(level.var_6a008207)) {
        return;
    }
    sound_ent = spawn("script_origin", self.origin);
    sound_ent playloopsound("zmb_perks_machine_loop");
    sound_ent linkto(self);
    self waittill(#"stop_loopsound");
    sound_ent unlink();
    sound_ent delete();
}

// Namespace zm_perks
// Params 2, eflags: 0x0
// Checksum 0xed7826d3, Offset: 0x11f0
// Size: 0x168
function perk_fx(fx, turnofffx) {
    if (isdefined(turnofffx)) {
        self.perk_fx = 0;
        if (isdefined(self.b_keep_when_turned_off) && self.b_keep_when_turned_off && isdefined(self.s_fxloc)) {
            self.s_fxloc delete();
        }
        return;
    }
    wait 3;
    if (!isdefined(self)) {
        return;
    }
    if (!(isdefined(self.b_keep_when_turned_off) && self.b_keep_when_turned_off)) {
        if (isdefined(self) && !(isdefined(self.perk_fx) && self.perk_fx)) {
            playfxontag(level._effect[fx], self, "tag_origin");
            self.perk_fx = 1;
        }
        return;
    }
    if (isdefined(self) && !isdefined(self.s_fxloc)) {
        self.s_fxloc = util::spawn_model("tag_origin", self.origin);
        playfxontag(level._effect[fx], self.s_fxloc, "tag_origin");
        self.perk_fx = 1;
    }
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0xc97aba4d, Offset: 0x1360
// Size: 0x1fa
function electric_perks_dialog() {
    self endon(#"death");
    wait 0.01;
    level flag::wait_till("start_zombie_round_logic");
    players = getplayers();
    if (players.size == 1) {
        return;
    }
    self endon(#"warning_dialog");
    level endon(#"switch_flipped");
    timer = 0;
    while (true) {
        wait 0.5;
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (!isdefined(players[i])) {
                continue;
            }
            dist = distancesquared(players[i].origin, self.origin);
            if (dist > 4900) {
                timer = 0;
                continue;
            }
            if (dist < 4900 && timer < 3) {
                wait 0.5;
                timer++;
            }
            if (dist < 4900 && timer == 3) {
                if (!isdefined(players[i])) {
                    continue;
                }
                players[i] thread zm_utility::do_player_vo("vox_start", 5);
                wait 3;
                self notify(#"warning_dialog");
                /#
                    iprintlnbold("<dev string:x87>");
                #/
            }
        }
    }
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0xb4d379b8, Offset: 0x1568
// Size: 0x13c
function reset_vending_hint_string() {
    perk = self.script_noteworthy;
    SOLO = function_23ee6fc();
    if (isdefined(level._custom_perks)) {
        if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost) && isdefined(level._custom_perks[perk].hint_string)) {
            if (isfunctionptr(level._custom_perks[perk].cost)) {
                n_cost = [[ level._custom_perks[perk].cost ]]();
            } else {
                n_cost = level._custom_perks[perk].cost;
            }
            self sethintstring(level._custom_perks[perk].hint_string, n_cost);
        }
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0xf3bcd714, Offset: 0x16b0
// Size: 0xe6
function vending_trigger_can_player_use(player) {
    if (isdefined(player.intermission) && (player laststand::player_is_in_laststand() || player.intermission)) {
        return false;
    }
    if (player zm_utility::in_revive_trigger()) {
        return false;
    }
    if (!player zm_magicbox::can_buy_weapon()) {
        return false;
    }
    if (player isthrowinggrenade()) {
        return false;
    }
    if (player isswitchingweapons()) {
        return false;
    }
    if (player.is_drinking > 0) {
        return false;
    }
    return true;
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0x16185baa, Offset: 0x17a0
// Size: 0x800
function vending_trigger_think() {
    self endon(#"death");
    wait 0.01;
    perk = self.script_noteworthy;
    SOLO = 0;
    start_on = 0;
    level.revive_machine_is_solo = 0;
    if (isdefined(perk) && perk == "specialty_quickrevive") {
        level flag::wait_till("start_zombie_round_logic");
        SOLO = function_23ee6fc();
        self endon(#"stop_quickrevive_logic");
        level.quick_revive_trigger = self;
        if (SOLO) {
            if (!(isdefined(level.revive_machine_is_solo) && level.revive_machine_is_solo)) {
                if (!(isdefined(level.var_44ebf6d) && level.var_44ebf6d)) {
                    start_on = 1;
                }
                players = getplayers();
                foreach (player in players) {
                    if (!isdefined(player.lives)) {
                        player.lives = 0;
                    }
                }
                level zm::function_dd15fb4e(1);
            }
            level.revive_machine_is_solo = 1;
        }
    }
    self sethintstring(%ZOMBIE_NEED_POWER);
    self setcursorhint("HINT_NOICON");
    self usetriggerrequirelookat();
    cost = level.zombie_vars["zombie_perk_cost"];
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].cost)) {
        if (isint(level._custom_perks[perk].cost)) {
            cost = level._custom_perks[perk].cost;
        } else {
            cost = [[ level._custom_perks[perk].cost ]]();
        }
    }
    self.cost = cost;
    if (!start_on) {
        notify_name = perk + "_power_on";
        level waittill(notify_name);
    }
    start_on = 0;
    if (!isdefined(level._perkmachinenetworkchoke)) {
        level._perkmachinenetworkchoke = 0;
    } else {
        level._perkmachinenetworkchoke++;
    }
    for (i = 0; i < level._perkmachinenetworkchoke; i++) {
        util::wait_network_frame();
    }
    self thread zm_audio::sndperksjingles_timer();
    self thread check_player_has_perk(perk);
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].hint_string)) {
        self sethintstring(level._custom_perks[perk].hint_string, cost);
    }
    for (;;) {
        self waittill(#"trigger", player);
        index = zm_utility::get_player_index(player);
        if (!vending_trigger_can_player_use(player)) {
            wait 0.1;
            continue;
        }
        if (player hasperk(perk) || player has_perk_paused(perk)) {
            cheat = 0;
            /#
                if (getdvarint("<dev string:x95>") >= 5) {
                    cheat = 1;
                }
            #/
            if (cheat != 1) {
                self playsound("evt_perk_deny");
                player zm_audio::create_and_play_dialog("general", "sigh");
                continue;
            }
        }
        if (isdefined(level.custom_perk_validation)) {
            valid = self [[ level.custom_perk_validation ]](player);
            if (!valid) {
                continue;
            }
        }
        current_cost = self.cost;
        if (player zm_pers_upgrades_functions::function_dc08b4af()) {
            current_cost = player zm_pers_upgrades_functions::function_4ef410da(current_cost);
        }
        if (!player zm_score::can_player_purchase(current_cost)) {
            self playsound("evt_perk_deny");
            player zm_audio::create_and_play_dialog("general", "outofmoney");
            continue;
        }
        if (!player zm_utility::can_player_purchase_perk()) {
            self playsound("evt_perk_deny");
            player zm_audio::create_and_play_dialog("general", "sigh");
            continue;
        }
        sound = "evt_bottle_dispense";
        playsoundatposition(sound, self.origin);
        player zm_score::minus_to_player_score(current_cost);
        bb::logpurchaseevent(player, self, current_cost, perk, 0, "_perk", "_purchased");
        perkhash = -1;
        if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].hash_id)) {
            perkhash = level._custom_perks[perk].hash_id;
        }
        player recordmapevent(29, gettime(), self.origin, level.round_number, perkhash);
        player.perk_purchased = perk;
        player notify(#"perk_purchased", perk);
        self thread zm_audio::sndperksjingles_player(1);
        self thread vending_trigger_post_think(player, perk);
    }
}

// Namespace zm_perks
// Params 2, eflags: 0x0
// Checksum 0xf077f3ea, Offset: 0x1fa8
// Size: 0x214
function vending_trigger_post_think(player, perk) {
    player endon(#"disconnect");
    player endon(#"end_game");
    player endon(#"perk_abort_drinking");
    gun = player perk_give_bottle_begin(perk);
    evt = player util::waittill_any_return("fake_death", "death", "player_downed", "weapon_change_complete", "perk_abort_drinking", "disconnect");
    if (evt == "weapon_change_complete") {
        player thread wait_give_perk(perk, 1);
    }
    player function_938ed54c(gun, perk);
    if (isdefined(player.intermission) && (player laststand::player_is_in_laststand() || player.intermission)) {
        return;
    }
    player notify(#"burp");
    if (isdefined(level.var_bac53324) && level.var_bac53324) {
        player zm_pers_upgrades_functions::function_c7dbceb7();
    }
    if (isdefined(level.var_52f5a971) && level.var_52f5a971) {
        player thread zm_pers_upgrades_functions::function_1425fc15();
    }
    if (isdefined(level.var_7b162f9e)) {
        player [[ level.var_7b162f9e ]](perk);
    }
    player.perk_purchased = undefined;
    if (!(isdefined(self.power_on) && self.power_on)) {
        wait 1;
        perk_pause(self.script_noteworthy);
    }
}

// Namespace zm_perks
// Params 2, eflags: 0x0
// Checksum 0xaa3bc49c, Offset: 0x21c8
// Size: 0xa4
function wait_give_perk(perk, bought) {
    self endon(#"player_downed");
    self endon(#"disconnect");
    self endon(#"end_game");
    self endon(#"perk_abort_drinking");
    self util::waittill_any_timeout(0.5, "burp", "player_downed", "disconnect", "end_game", "perk_abort_drinking");
    self give_perk(perk, bought);
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0x9bd0e26d, Offset: 0x2278
// Size: 0xe2
function function_36b1754c() {
    if (isdefined(self.var_bfa19c73)) {
        keys = getarraykeys(self.var_bfa19c73);
        foreach (perk in keys) {
            if (isdefined(self.var_bfa19c73[perk]) && self.var_bfa19c73[perk]) {
                self give_perk(perk, 0);
            }
        }
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0xea4822dd, Offset: 0x2368
// Size: 0x10c
function give_perk_presentation(perk) {
    self endon(#"player_downed");
    self endon(#"disconnect");
    self endon(#"end_game");
    self endon(#"perk_abort_drinking");
    self zm_audio::playerexert("burp");
    if (isdefined(level.var_f084310a) && level.var_f084310a) {
        self zm_audio::create_and_play_dialog("perk", perk);
    } else {
        self util::delay(1.5, undefined, &zm_audio::create_and_play_dialog, "perk", perk);
    }
    self setblur(9, 0.1);
    wait 0.1;
    self setblur(0, 0.1);
}

// Namespace zm_perks
// Params 2, eflags: 0x0
// Checksum 0xd8309a64, Offset: 0x2480
// Size: 0x27c
function give_perk(perk, bought) {
    self setperk(perk);
    self.num_perks++;
    if (isdefined(bought) && bought) {
        self thread give_perk_presentation(perk);
        self notify(#"perk_bought", perk);
        self zm_stats::increment_challenge_stat("SURVIVALIST_BUY_PERK");
    }
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_give)) {
        self thread [[ level._custom_perks[perk].player_thread_give ]]();
    }
    self set_perk_clientfield(perk, 1);
    demo::bookmark("zm_player_perk", gettime(), self);
    self zm_stats::increment_client_stat("perks_drank");
    self zm_stats::increment_client_stat(perk + "_drank");
    self zm_stats::increment_player_stat(perk + "_drank");
    self zm_stats::increment_player_stat("perks_drank");
    if (!isdefined(self.perk_history)) {
        self.perk_history = [];
    }
    array::add(self.perk_history, perk, 0);
    if (!isdefined(self.perks_active)) {
        self.perks_active = [];
    }
    if (!isdefined(self.perks_active)) {
        self.perks_active = [];
    } else if (!isarray(self.perks_active)) {
        self.perks_active = array(self.perks_active);
    }
    self.perks_active[self.perks_active.size] = perk;
    self notify(#"perk_acquired");
    self thread perk_think(perk);
}

// Namespace zm_perks
// Params 3, eflags: 0x0
// Checksum 0xd502595e, Offset: 0x2708
// Size: 0x218
function function_78f42790(str_perk, var_f8fab6db, var_b64a6b1b) {
    var_74f58142 = undefined;
    switch (str_perk) {
    case "specialty_armorvest":
        if (var_f8fab6db) {
            self.var_7012456c = self.maxhealth;
        }
        var_74f58142 = self.maxhealth + level.zombie_vars["zombie_perk_juggernaut_health"];
        break;
    case "jugg_upgrade":
        if (var_f8fab6db) {
            self.var_7012456c = self.maxhealth;
        }
        if (self hasperk("specialty_armorvest")) {
            var_74f58142 += level.zombie_vars["zombie_perk_juggernaut_health"];
        } else {
            var_74f58142 = level.zombie_vars["player_base_health"];
        }
        break;
    case "health_reboot":
        var_74f58142 = level.zombie_vars["player_base_health"];
        if (isdefined(self.var_5feb5a44)) {
            var_74f58142 += self.var_5feb5a44;
        }
        if (self hasperk("specialty_armorvest")) {
            var_74f58142 += level.zombie_vars["zombie_perk_juggernaut_health"];
        }
        break;
    }
    if (isdefined(var_74f58142)) {
        if (self zm_pers_upgrades_functions::function_dadedde6()) {
            var_74f58142 += level.var_eb469fd1;
        }
        self.maxhealth = var_74f58142;
        self setmaxhealth(var_74f58142);
        if (isdefined(var_b64a6b1b) && var_b64a6b1b == 1) {
            if (self.health > self.maxhealth) {
                self.health = self.maxhealth;
            }
        }
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0xb0904e5b, Offset: 0x2928
// Size: 0x204
function check_player_has_perk(perk) {
    self endon(#"death");
    /#
        if (getdvarint("<dev string:x95>") >= 5) {
            return;
        }
    #/
    dist = 16384;
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (distancesquared(players[i].origin, self.origin) < dist) {
                if (!players[i] hasperk(perk) && self vending_trigger_can_player_use(players[i]) && !players[i] has_perk_paused(perk) && !players[i] zm_utility::in_revive_trigger() && !zm_equipment::is_equipment_that_blocks_purchase(players[i] getcurrentweapon()) && !players[i] zm_equipment::hacker_active()) {
                    self setinvisibletoplayer(players[i], 0);
                    continue;
                }
                self setinvisibletoplayer(players[i], 1);
            }
        }
        wait 0.1;
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0x2c91ff24, Offset: 0x2b38
// Size: 0x2a
function vending_set_hintstring(perk) {
    switch (perk) {
    case "specialty_armorvest":
        break;
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0x46125510, Offset: 0x2b70
// Size: 0x2b2
function perk_think(perk) {
    self endon(#"disconnect");
    /#
        if (getdvarint("<dev string:x95>") >= 5) {
            if (isdefined(self.var_df099d9b[perk])) {
                return;
            }
        }
    #/
    perk_str = perk + "_stop";
    for (result = self util::waittill_any_return("fake_death", "death", "player_downed", perk_str); self bgb::lost_perk_override(perk); result = self util::waittill_any_return("fake_death", "death", "player_downed", perk_str)) {
    }
    var_6948807a = 1;
    if (function_23ee6fc() && perk == "specialty_quickrevive") {
        var_6948807a = 0;
    }
    if (var_6948807a) {
        if (isdefined(self.var_7fceabe1) && self.var_7fceabe1) {
            return;
        } else if (isdefined(self.var_bfa19c73[perk]) && isdefined(self.var_bfa19c73) && self.var_bfa19c73[perk]) {
            return;
        }
    }
    self unsetperk(perk);
    self.num_perks--;
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_take)) {
        self thread [[ level._custom_perks[perk].player_thread_take ]](0, perk_str, result);
    }
    self set_perk_clientfield(perk, 0);
    self.perk_purchased = undefined;
    if (isdefined(level.var_a72d0823)) {
        self [[ level.var_a72d0823 ]](perk);
    }
    if (isdefined(self.perks_active) && isinarray(self.perks_active, perk)) {
        arrayremovevalue(self.perks_active, perk, 0);
    }
    self notify(#"perk_lost");
}

// Namespace zm_perks
// Params 2, eflags: 0x0
// Checksum 0x18a9d516, Offset: 0x2e30
// Size: 0x68
function set_perk_clientfield(perk, state) {
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].clientfield_set)) {
        self [[ level._custom_perks[perk].clientfield_set ]](state);
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0x5ff4467a, Offset: 0x2ea0
// Size: 0x38
function function_36084434(perk) {
    self.var_df099d9b[perk] zm_utility::function_ef76706b();
    self.var_df099d9b[perk] = undefined;
}

// Namespace zm_perks
// Params 2, eflags: 0x0
// Checksum 0x76cacb76, Offset: 0x2ee0
// Size: 0x60
function function_99589d97(perk, var_23d1e7f6) {
    if (var_23d1e7f6) {
        self.var_df099d9b[perk].alpha = 0.3;
        return;
    }
    self.var_df099d9b[perk].alpha = 1;
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0xa648d1f8, Offset: 0x2f48
// Size: 0xf8
function perk_give_bottle_begin(perk) {
    self zm_utility::increment_is_drinking();
    self zm_utility::disable_player_move_states(1);
    original_weapon = self getcurrentweapon();
    weapon = "";
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].perk_bottle_weapon)) {
        weapon = level._custom_perks[perk].perk_bottle_weapon;
    }
    self giveweapon(weapon);
    self switchtoweapon(weapon);
    return original_weapon;
}

// Namespace zm_perks
// Params 2, eflags: 0x0
// Checksum 0x429504d4, Offset: 0x3048
// Size: 0x274
function function_938ed54c(original_weapon, perk) {
    self endon(#"perk_abort_drinking");
    assert(!original_weapon.isperkbottle);
    assert(original_weapon != level.weaponrevivetool);
    self zm_utility::enable_player_move_states();
    weapon = "";
    if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].perk_bottle_weapon)) {
        weapon = level._custom_perks[perk].perk_bottle_weapon;
    }
    if (isdefined(self.intermission) && (self laststand::player_is_in_laststand() || self.intermission)) {
        self takeweapon(weapon);
        return;
    }
    self takeweapon(weapon);
    if (self zm_utility::is_multiple_drinking()) {
        self zm_utility::decrement_is_drinking();
        return;
    } else if (original_weapon != level.weaponnone && !zm_utility::is_placeable_mine(original_weapon) && !zm_equipment::is_equipment_that_blocks_purchase(original_weapon)) {
        self zm_weapons::switch_back_primary_weapon(original_weapon);
        if (zm_utility::is_melee_weapon(original_weapon)) {
            self zm_utility::decrement_is_drinking();
            return;
        }
    } else {
        self zm_weapons::switch_back_primary_weapon();
    }
    self waittill(#"weapon_change_complete");
    if (!self laststand::player_is_in_laststand() && !(isdefined(self.intermission) && self.intermission)) {
        self zm_utility::decrement_is_drinking();
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0xf8aa95c1, Offset: 0x32c8
// Size: 0x5c
function perk_abort_drinking(post_delay) {
    if (self.is_drinking) {
        self notify(#"perk_abort_drinking");
        self zm_utility::decrement_is_drinking();
        self zm_utility::enable_player_move_states();
        if (isdefined(post_delay)) {
            wait post_delay;
        }
    }
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0x997b241e, Offset: 0x3330
// Size: 0x170
function function_57435073() {
    random_perk = undefined;
    a_str_perks = getarraykeys(level._custom_perks);
    perks = [];
    for (i = 0; i < a_str_perks.size; i++) {
        perk = a_str_perks[i];
        if (isdefined(self.perk_purchased) && self.perk_purchased == perk) {
            continue;
        }
        if (!self hasperk(perk) && !self has_perk_paused(perk)) {
            perks[perks.size] = perk;
        }
    }
    if (perks.size > 0) {
        perks = array::randomize(perks);
        random_perk = perks[0];
        self give_perk(random_perk);
    } else {
        self playsoundtoplayer(level.zmb_laugh_alias, self);
    }
    return random_perk;
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0x98787054, Offset: 0x34a8
// Size: 0x168
function lose_random_perk() {
    a_str_perks = getarraykeys(level._custom_perks);
    perks = [];
    for (i = 0; i < a_str_perks.size; i++) {
        perk = a_str_perks[i];
        if (isdefined(self.perk_purchased) && self.perk_purchased == perk) {
            continue;
        }
        if (self hasperk(perk) || self has_perk_paused(perk)) {
            perks[perks.size] = perk;
        }
    }
    if (perks.size > 0) {
        perks = array::randomize(perks);
        perk = perks[0];
        perk_str = perk + "_stop";
        self notify(perk_str);
        if (function_23ee6fc() && perk == "specialty_quickrevive") {
            self.lives--;
        }
    }
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0x95380bc6, Offset: 0x3618
// Size: 0x8e
function function_3da729b7() {
    if (isdefined(self.var_df099d9b)) {
        keys = getarraykeys(self.var_df099d9b);
        for (i = 0; i < self.var_df099d9b.size; i++) {
            self.var_df099d9b[keys[i]].x = i * 30;
        }
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0xc8b4db0c, Offset: 0x36b0
// Size: 0xae
function quantum_bomb_give_nearest_perk_validation(position) {
    var_3be8a3b8 = getentarray("zombie_vending", "targetname");
    range_squared = 32400;
    for (i = 0; i < var_3be8a3b8.size; i++) {
        if (distancesquared(var_3be8a3b8[i].origin, position) < range_squared) {
            return true;
        }
    }
    return false;
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0xd9a0c586, Offset: 0x3768
// Size: 0x25a
function quantum_bomb_give_nearest_perk_result(position) {
    [[ level.var_c5e1e17b ]](position);
    var_3be8a3b8 = getentarray("zombie_vending", "targetname");
    nearest = 0;
    for (i = 1; i < var_3be8a3b8.size; i++) {
        if (distancesquared(var_3be8a3b8[i].origin, position) < distancesquared(var_3be8a3b8[nearest].origin, position)) {
            nearest = i;
        }
    }
    players = getplayers();
    perk = var_3be8a3b8[nearest].script_noteworthy;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (player.sessionstate == "spectator" || player laststand::player_is_in_laststand()) {
            continue;
        }
        if ((!isdefined(player.perk_purchased) || !player hasperk(perk) && player.perk_purchased != perk) && randomint(5)) {
            if (player == self) {
                self thread zm_audio::create_and_play_dialog("kill", "quant_good");
            }
            player give_perk(perk);
            player [[ level.var_e09b9d69 ]]();
        }
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0x3748456f, Offset: 0x39d0
// Size: 0x1ee
function perk_pause(perk) {
    if (isdefined(level.dont_unset_perk_when_machine_paused) && level.dont_unset_perk_when_machine_paused) {
        return;
    }
    for (j = 0; j < getplayers().size; j++) {
        player = getplayers()[j];
        if (!isdefined(player.var_46793f8f)) {
            player.var_46793f8f = [];
        }
        player.var_46793f8f[perk] = isdefined(player.var_46793f8f[perk]) && player.var_46793f8f[perk] || player hasperk(perk);
        if (player.var_46793f8f[perk]) {
            player unsetperk(perk);
            player set_perk_clientfield(perk, 2);
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_take)) {
                player thread [[ level._custom_perks[perk].player_thread_take ]](1);
            }
            println("<dev string:xa2>" + player.name + "<dev string:xad>" + perk + "<dev string:xbb>");
        }
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0x8a42eecd, Offset: 0x3bc8
// Size: 0x1da
function perk_unpause(perk) {
    if (isdefined(level.dont_unset_perk_when_machine_paused) && level.dont_unset_perk_when_machine_paused) {
        return;
    }
    if (!isdefined(perk)) {
        return;
    }
    for (j = 0; j < getplayers().size; j++) {
        player = getplayers()[j];
        if (isdefined(player.var_46793f8f[perk]) && isdefined(player.var_46793f8f) && player.var_46793f8f[perk]) {
            player.var_46793f8f[perk] = 0;
            player set_perk_clientfield(perk, 1);
            player setperk(perk);
            println("<dev string:xa2>" + player.name + "<dev string:xbd>" + perk + "<dev string:xbb>");
            player function_78f42790(perk, 0, 0);
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].player_thread_give)) {
                player thread [[ level._custom_perks[perk].player_thread_give ]]();
            }
        }
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0x90a7c8c2, Offset: 0x3db0
// Size: 0x122
function perk_pause_all_perks(power_zone) {
    var_3be8a3b8 = getentarray("zombie_vending", "targetname");
    foreach (trigger in var_3be8a3b8) {
        if (!isdefined(power_zone)) {
            perk_pause(trigger.script_noteworthy);
            continue;
        }
        if (isdefined(trigger.script_int) && trigger.script_int == power_zone) {
            perk_pause(trigger.script_noteworthy);
        }
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0x630b2e27, Offset: 0x3ee0
// Size: 0x122
function perk_unpause_all_perks(power_zone) {
    var_3be8a3b8 = getentarray("zombie_vending", "targetname");
    foreach (trigger in var_3be8a3b8) {
        if (!isdefined(power_zone)) {
            perk_unpause(trigger.script_noteworthy);
            continue;
        }
        if (isdefined(trigger.script_int) && trigger.script_int == power_zone) {
            perk_unpause(trigger.script_noteworthy);
        }
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0x50c1337e, Offset: 0x4010
// Size: 0x44
function has_perk_paused(perk) {
    if (isdefined(self.var_46793f8f) && isdefined(self.var_46793f8f[perk]) && self.var_46793f8f[perk]) {
        return true;
    }
    return false;
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0xddb2db67, Offset: 0x4060
// Size: 0x84
function getvendingmachinenotify() {
    if (!isdefined(self)) {
        return "";
    }
    str_perk = undefined;
    if (isdefined(level._custom_perks[self.script_noteworthy]) && isdefined(isdefined(level._custom_perks[self.script_noteworthy].alias))) {
        str_perk = level._custom_perks[self.script_noteworthy].alias;
    }
    return str_perk;
}

// Namespace zm_perks
// Params 2, eflags: 0x0
// Checksum 0xbd07b4d5, Offset: 0x40f0
// Size: 0x294
function perk_machine_removal(machine, replacement_model) {
    if (!isdefined(machine)) {
        return;
    }
    trig = getent(machine, "script_noteworthy");
    machine_model = undefined;
    if (isdefined(trig)) {
        trig notify(#"warning_dialog");
        if (isdefined(trig.target)) {
            parts = getentarray(trig.target, "targetname");
            for (i = 0; i < parts.size; i++) {
                if (isdefined(parts[i].classname) && parts[i].classname == "script_model") {
                    machine_model = parts[i];
                    continue;
                }
                if (isdefined(parts[i].script_noteworthy && parts[i].script_noteworthy == "clip")) {
                    model_clip = parts[i];
                    continue;
                }
                parts[i] delete();
            }
        }
        if (isdefined(replacement_model) && isdefined(machine_model)) {
            machine_model setmodel(replacement_model);
        } else if (!isdefined(replacement_model) && isdefined(machine_model)) {
            machine_model delete();
            if (isdefined(model_clip)) {
                model_clip delete();
            }
            if (isdefined(trig.clip)) {
                trig.clip delete();
            }
        }
        if (isdefined(trig.bump)) {
            trig.bump delete();
        }
        trig delete();
    }
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0xba8c7c82, Offset: 0x4390
// Size: 0x99e
function perk_machine_spawn_init() {
    match_string = "";
    location = level.scr_zm_map_start_location;
    if ((location == "default" || location == "") && isdefined(level.default_start_location)) {
        location = level.default_start_location;
    }
    match_string = level.scr_zm_ui_gametype + "_perks_" + location;
    a_s_spawn_pos = [];
    if (isdefined(level.override_perk_targetname)) {
        structs = struct::get_array(level.override_perk_targetname, "targetname");
    } else {
        structs = struct::get_array("zm_perk_machine", "targetname");
    }
    foreach (struct in structs) {
        if (isdefined(struct.script_string)) {
            tokens = strtok(struct.script_string, " ");
            foreach (token in tokens) {
                if (token == match_string) {
                    a_s_spawn_pos[a_s_spawn_pos.size] = struct;
                }
            }
            continue;
        }
        a_s_spawn_pos[a_s_spawn_pos.size] = struct;
    }
    if (a_s_spawn_pos.size == 0) {
        return;
    }
    if (isdefined(level.randomize_perk_machine_location) && level.randomize_perk_machine_location) {
        a_s_random_perk_locs = struct::get_array("perk_random_machine_location", "targetname");
        if (a_s_random_perk_locs.size > 0) {
            a_s_random_perk_locs = array::randomize(a_s_random_perk_locs);
        }
        n_random_perks_assigned = 0;
    }
    foreach (s_spawn_pos in a_s_spawn_pos) {
        perk = s_spawn_pos.script_noteworthy;
        if (isdefined(perk) && isdefined(s_spawn_pos.model)) {
            if (isdefined(level.randomize_perk_machine_location) && level.randomize_perk_machine_location && a_s_random_perk_locs.size > 0 && isdefined(s_spawn_pos.script_notify)) {
                s_new_loc = a_s_random_perk_locs[n_random_perks_assigned];
                s_spawn_pos.origin = s_new_loc.origin;
                s_spawn_pos.angles = s_new_loc.angles;
                if (isdefined(s_new_loc.script_int)) {
                    s_spawn_pos.script_int = s_new_loc.script_int;
                }
                if (isdefined(s_new_loc.target)) {
                    s_tell_location = struct::get(s_new_loc.target);
                    if (isdefined(s_tell_location)) {
                        util::spawn_model("p7_zm_perk_bottle_broken_" + perk, s_tell_location.origin, s_tell_location.angles);
                    }
                }
                n_random_perks_assigned++;
            }
            t_use = spawn("trigger_radius_use", s_spawn_pos.origin + (0, 0, 60), 0, 40, 80);
            t_use.targetname = "zombie_vending";
            t_use.script_noteworthy = perk;
            if (isdefined(s_spawn_pos.script_int)) {
                t_use.script_int = s_spawn_pos.script_int;
            }
            t_use triggerignoreteam();
            perk_machine = spawn("script_model", s_spawn_pos.origin);
            if (!isdefined(s_spawn_pos.angles)) {
                s_spawn_pos.angles = (0, 0, 0);
            }
            perk_machine.angles = s_spawn_pos.angles;
            perk_machine setmodel(s_spawn_pos.model);
            if (isdefined(level._no_vending_machine_bump_trigs) && level._no_vending_machine_bump_trigs) {
                bump_trigger = undefined;
            } else {
                bump_trigger = spawn("trigger_radius", s_spawn_pos.origin + (0, 0, 20), 0, 40, 80);
                bump_trigger.script_activated = 1;
                bump_trigger.script_sound = "zmb_perks_bump_bottle";
                bump_trigger.targetname = "audio_bump_trigger";
            }
            if (isdefined(level._no_vending_machine_auto_collision) && level._no_vending_machine_auto_collision) {
                collision = undefined;
            } else {
                collision = spawn("script_model", s_spawn_pos.origin, 1);
                collision.angles = s_spawn_pos.angles;
                collision setmodel("zm_collision_perks1");
                collision.script_noteworthy = "clip";
                collision disconnectpaths();
            }
            t_use.clip = collision;
            t_use.machine = perk_machine;
            t_use.bump = bump_trigger;
            if (isdefined(s_spawn_pos.script_notify)) {
                perk_machine.script_notify = s_spawn_pos.script_notify;
            }
            if (isdefined(s_spawn_pos.target)) {
                perk_machine.target = s_spawn_pos.target;
            }
            if (isdefined(s_spawn_pos.blocker_model)) {
                t_use.blocker_model = s_spawn_pos.blocker_model;
            }
            if (isdefined(s_spawn_pos.script_int)) {
                perk_machine.script_int = s_spawn_pos.script_int;
            }
            if (isdefined(s_spawn_pos.turn_on_notify)) {
                perk_machine.turn_on_notify = s_spawn_pos.turn_on_notify;
            }
            t_use.script_sound = "mus_perks_speed_jingle";
            t_use.script_string = "speedcola_perk";
            t_use.script_label = "mus_perks_speed_sting";
            t_use.target = "vending_sleight";
            perk_machine.script_string = "speedcola_perk";
            perk_machine.targetname = "vending_sleight";
            if (isdefined(bump_trigger)) {
                bump_trigger.script_string = "speedcola_perk";
            }
            if (isdefined(level._custom_perks[perk]) && isdefined(level._custom_perks[perk].perk_machine_set_kvps)) {
                [[ level._custom_perks[perk].perk_machine_set_kvps ]](t_use, perk_machine, bump_trigger, collision);
            }
        }
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0x2066c483, Offset: 0x4d38
// Size: 0x66
function get_perk_machine_start_state(perk) {
    if (isdefined(level.vending_machines_powered_on_at_start) && level.vending_machines_powered_on_at_start) {
        return 1;
    }
    if (perk == "specialty_quickrevive") {
        assert(isdefined(level.revive_machine_is_solo));
        return level.revive_machine_is_solo;
    }
    return 0;
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0xcdf9575, Offset: 0x4da8
// Size: 0xf6
function perks_register_clientfield() {
    if (isdefined(level.zombiemode_using_perk_intro_fx) && level.zombiemode_using_perk_intro_fx) {
        clientfield::register("scriptmover", "clientfield_perk_intro_fx", 1, 1, "int");
    }
    if (isdefined(level._custom_perks)) {
        a_keys = getarraykeys(level._custom_perks);
        for (i = 0; i < a_keys.size; i++) {
            if (isdefined(level._custom_perks[a_keys[i]].clientfield_register)) {
                level [[ level._custom_perks[a_keys[i]].clientfield_register ]]();
            }
        }
    }
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0x82a06e57, Offset: 0x4ea8
// Size: 0x80
function thread_bump_trigger() {
    for (;;) {
        self waittill(#"trigger", trigplayer);
        trigplayer playsound(self.script_sound);
        while (zm_utility::is_player_valid(trigplayer) && trigplayer istouching(self)) {
            wait 0.5;
        }
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0xa75ea30e, Offset: 0x4f30
// Size: 0x162
function players_are_in_perk_area(perk_machine) {
    perk_area_origin = level.quick_revive_default_origin;
    if (isdefined(perk_machine._linked_ent)) {
        perk_area_origin = perk_machine._linked_ent.origin;
        if (isdefined(perk_machine._linked_ent_offset)) {
            perk_area_origin += perk_machine._linked_ent_offset;
        }
    }
    in_area = 0;
    players = getplayers();
    dist_check = 9216;
    foreach (player in players) {
        if (distancesquared(player.origin, perk_area_origin) < dist_check) {
            return true;
        }
    }
    return false;
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0x87b82ee5, Offset: 0x50a0
// Size: 0x14e
function perk_hostmigration() {
    level endon(#"end_game");
    level notify(#"perk_hostmigration");
    level endon(#"perk_hostmigration");
    while (true) {
        level waittill(#"host_migration_end");
        if (isdefined(level._custom_perks) && level._custom_perks.size > 0) {
            a_keys = getarraykeys(level._custom_perks);
            foreach (key in a_keys) {
                if (isdefined(level._custom_perks[key].radiant_machine_name) && isdefined(level._custom_perks[key].machine_light_effect)) {
                    level thread host_migration_func(level._custom_perks[key], key);
                }
            }
        }
    }
}

// Namespace zm_perks
// Params 2, eflags: 0x0
// Checksum 0x3c7d354e, Offset: 0x51f8
// Size: 0x132
function host_migration_func(s_custom_perk, keyname) {
    a_machines = getentarray(s_custom_perk.radiant_machine_name, "targetname");
    foreach (perk in a_machines) {
        if (isdefined(perk.model) && perk.model == level.machine_assets[keyname].on_model) {
            perk perk_fx(undefined, 1);
            perk thread perk_fx(s_custom_perk.machine_light_effect);
        }
    }
}

// Namespace zm_perks
// Params 2, eflags: 0x0
// Checksum 0x869ca063, Offset: 0x5338
// Size: 0x10a
function spare_change(str_trigger, str_sound) {
    if (!isdefined(str_trigger)) {
        str_trigger = "audio_bump_trigger";
    }
    if (!isdefined(str_sound)) {
        str_sound = "zmb_perks_bump_bottle";
    }
    a_t_audio = getentarray(str_trigger, "targetname");
    foreach (t_audio_bump in a_t_audio) {
        if (t_audio_bump.script_sound === str_sound) {
            t_audio_bump thread check_for_change();
        }
    }
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0x30eb634e, Offset: 0x5450
// Size: 0xa4
function check_for_change() {
    self endon(#"death");
    while (true) {
        self waittill(#"trigger", player);
        if (player getstance() == "prone") {
            player zm_score::add_to_player_score(100);
            zm_utility::play_sound_at_pos("purchase", player.origin);
            break;
        }
        wait 0.1;
    }
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0xd119d379, Offset: 0x5500
// Size: 0xac
function get_perk_array() {
    perk_array = [];
    if (level._custom_perks.size > 0) {
        a_keys = getarraykeys(level._custom_perks);
        for (i = 0; i < a_keys.size; i++) {
            if (self hasperk(a_keys[i])) {
                perk_array[perk_array.size] = a_keys[i];
            }
        }
    }
    return perk_array;
}

// Namespace zm_perks
// Params 0, eflags: 0x0
// Checksum 0x537dde75, Offset: 0x55b8
// Size: 0x1c
function function_aa9d5b3f() {
    if (!isdefined(level._custom_perks)) {
        level._custom_perks = [];
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0x2186d1b3, Offset: 0x55e0
// Size: 0x3a
function register_revive_success_perk_func(revive_func) {
    if (!isdefined(level.a_revive_success_perk_func)) {
        level.a_revive_success_perk_func = [];
    }
    level.a_revive_success_perk_func[level.a_revive_success_perk_func.size] = revive_func;
}

// Namespace zm_perks
// Params 5, eflags: 0x0
// Checksum 0xd1bbc6ea, Offset: 0x5628
// Size: 0x1a8
function register_perk_basic_info(str_perk, str_alias, n_perk_cost, str_hint_string, w_perk_bottle_weapon) {
    assert(isdefined(str_perk), "<dev string:xcd>");
    assert(isdefined(str_alias), "<dev string:x10b>");
    assert(isdefined(n_perk_cost), "<dev string:x14a>");
    assert(isdefined(str_hint_string), "<dev string:x18b>");
    assert(isdefined(w_perk_bottle_weapon), "<dev string:x1d0>");
    _register_undefined_perk(str_perk);
    level._custom_perks[str_perk].alias = str_alias;
    level._custom_perks[str_perk].hash_id = hashstring(str_alias);
    level._custom_perks[str_perk].cost = n_perk_cost;
    level._custom_perks[str_perk].hint_string = str_hint_string;
    level._custom_perks[str_perk].perk_bottle_weapon = w_perk_bottle_weapon;
}

// Namespace zm_perks
// Params 3, eflags: 0x0
// Checksum 0x6fdda2e5, Offset: 0x57d8
// Size: 0x100
function register_perk_machine(str_perk, func_perk_machine_setup, func_perk_machine_thread) {
    assert(isdefined(str_perk), "<dev string:x21a>");
    assert(isdefined(func_perk_machine_setup), "<dev string:x255>");
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].perk_machine_set_kvps)) {
        level._custom_perks[str_perk].perk_machine_set_kvps = func_perk_machine_setup;
    }
    if (!isdefined(level._custom_perks[str_perk].perk_machine_thread) && isdefined(func_perk_machine_thread)) {
        level._custom_perks[str_perk].perk_machine_thread = func_perk_machine_thread;
    }
}

// Namespace zm_perks
// Params 2, eflags: 0x0
// Checksum 0x4c26a367, Offset: 0x58e0
// Size: 0xc0
function register_perk_machine_power_override(str_perk, func_perk_machine_power_override) {
    assert(isdefined(str_perk), "<dev string:x29f>");
    assert(isdefined(func_perk_machine_power_override), "<dev string:x2e9>");
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].perk_machine_power_override_thread) && isdefined(func_perk_machine_power_override)) {
        level._custom_perks[str_perk].perk_machine_power_override_thread = func_perk_machine_power_override;
    }
}

// Namespace zm_perks
// Params 2, eflags: 0x0
// Checksum 0x9f7294c5, Offset: 0x59a8
// Size: 0xb4
function register_perk_precache_func(str_perk, func_precache) {
    assert(isdefined(str_perk), "<dev string:x34b>");
    assert(isdefined(func_precache), "<dev string:x38c>");
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].precache_func)) {
        level._custom_perks[str_perk].precache_func = func_precache;
    }
}

// Namespace zm_perks
// Params 3, eflags: 0x0
// Checksum 0x81ba92ce, Offset: 0x5a68
// Size: 0x100
function register_perk_threads(str_perk, func_give_player_perk, func_take_player_perk) {
    assert(isdefined(str_perk), "<dev string:x3d2>");
    assert(isdefined(func_give_player_perk), "<dev string:x40d>");
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].player_thread_give)) {
        level._custom_perks[str_perk].player_thread_give = func_give_player_perk;
    }
    if (isdefined(func_take_player_perk)) {
        if (!isdefined(level._custom_perks[str_perk].player_thread_take)) {
            level._custom_perks[str_perk].player_thread_take = func_take_player_perk;
        }
    }
}

// Namespace zm_perks
// Params 3, eflags: 0x0
// Checksum 0xa4e28c8b, Offset: 0x5b70
// Size: 0x11c
function register_perk_clientfields(str_perk, func_clientfield_register, func_clientfield_set) {
    assert(isdefined(str_perk), "<dev string:x455>");
    assert(isdefined(func_clientfield_register), "<dev string:x495>");
    assert(isdefined(func_clientfield_set), "<dev string:x4e6>");
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].clientfield_register)) {
        level._custom_perks[str_perk].clientfield_register = func_clientfield_register;
    }
    if (!isdefined(level._custom_perks[str_perk].clientfield_set)) {
        level._custom_perks[str_perk].clientfield_set = func_clientfield_set;
    }
}

// Namespace zm_perks
// Params 3, eflags: 0x0
// Checksum 0xfe9d97ac, Offset: 0x5c98
// Size: 0x11c
function register_perk_host_migration_params(str_perk, str_radiant_name, str_effect_name) {
    assert(isdefined(str_perk), "<dev string:x532>");
    assert(isdefined(str_radiant_name), "<dev string:x57b>");
    assert(isdefined(str_effect_name), "<dev string:x5cc>");
    _register_undefined_perk(str_perk);
    if (!isdefined(level._custom_perks[str_perk].var_cc657044)) {
        level._custom_perks[str_perk].radiant_machine_name = str_radiant_name;
    }
    if (!isdefined(level._custom_perks[str_perk].var_39737b3d)) {
        level._custom_perks[str_perk].machine_light_effect = str_effect_name;
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0x97aaae8, Offset: 0x5dc0
// Size: 0x5a
function _register_undefined_perk(str_perk) {
    if (!isdefined(level._custom_perks)) {
        level._custom_perks = [];
    }
    if (!isdefined(level._custom_perks[str_perk])) {
        level._custom_perks[str_perk] = spawnstruct();
    }
}

// Namespace zm_perks
// Params 1, eflags: 0x0
// Checksum 0x3d65efe7, Offset: 0x5e28
// Size: 0x6c
function register_perk_damage_override_func(func_damage_override) {
    assert(isdefined(func_damage_override), "<dev string:x61c>");
    if (!isdefined(level.perk_damage_override)) {
        level.perk_damage_override = [];
    }
    array::add(level.perk_damage_override, func_damage_override, 0);
}

