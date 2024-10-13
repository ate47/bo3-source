#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_melee_weapon;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_blockers;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/zm/_bb;
#using scripts/zm/_util;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_powerups;

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xe95276c1, Offset: 0xb38
// Size: 0x34c
function init() {
    zombie_utility::set_zombie_var("zombie_insta_kill", 0, undefined, undefined, 1);
    zombie_utility::set_zombie_var("zombie_point_scalar", 1, undefined, undefined, 1);
    zombie_utility::set_zombie_var("zombie_drop_item", 0);
    zombie_utility::set_zombie_var("zombie_timer_offset", 350);
    zombie_utility::set_zombie_var("zombie_timer_offset_interval", 30);
    zombie_utility::set_zombie_var("zombie_powerup_fire_sale_on", 0);
    zombie_utility::set_zombie_var("zombie_powerup_fire_sale_time", 30);
    zombie_utility::set_zombie_var("zombie_powerup_bonfire_sale_on", 0);
    zombie_utility::set_zombie_var("zombie_powerup_bonfire_sale_time", 30);
    zombie_utility::set_zombie_var("zombie_powerup_insta_kill_on", 0, undefined, undefined, 1);
    zombie_utility::set_zombie_var("zombie_powerup_insta_kill_time", 30, undefined, undefined, 1);
    zombie_utility::set_zombie_var("zombie_powerup_double_points_on", 0, undefined, undefined, 1);
    zombie_utility::set_zombie_var("zombie_powerup_double_points_time", 30, undefined, undefined, 1);
    zombie_utility::set_zombie_var("zombie_powerup_drop_increment", 2000);
    zombie_utility::set_zombie_var("zombie_powerup_drop_max_per_round", 4);
    callback::on_connect(&init_player_zombie_vars);
    level._effect["powerup_on"] = "zombie/fx_powerup_on_green_zmb";
    level._effect["powerup_off"] = "zombie/fx_powerup_off_green_zmb";
    level._effect["powerup_grabbed"] = "zombie/fx_powerup_grab_green_zmb";
    if (isdefined(level.using_zombie_powerups) && level.using_zombie_powerups) {
        level._effect["powerup_on_red"] = "zombie/fx_powerup_on_red_zmb";
        level._effect["powerup_grabbed_red"] = "zombie/fx_powerup_grab_red_zmb";
    }
    level._effect["powerup_on_solo"] = "zombie/fx_powerup_on_solo_zmb";
    level._effect["powerup_grabbed_solo"] = "zombie/fx_powerup_grab_solo_zmb";
    level._effect["powerup_on_caution"] = "zombie/fx_powerup_on_caution_zmb";
    level._effect["powerup_grabbed_caution"] = "zombie/fx_powerup_grab_caution_zmb";
    init_powerups();
    if (!level.enable_magic) {
        return;
    }
    thread watch_for_drop();
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0x27f3f38b, Offset: 0xe90
// Size: 0x17c
function init_powerups() {
    level flag::init("zombie_drop_powerups");
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level flag::set("zombie_drop_powerups");
    }
    if (!isdefined(level.active_powerups)) {
        level.active_powerups = [];
    }
    add_zombie_powerup("insta_kill_ug", "zombie_skull", %ZOMBIE_POWERUP_INSTA_KILL, &func_should_never_drop, 1, 0, 0, undefined, "powerup_instant_kill_ug", "zombie_powerup_insta_kill_ug_time", "zombie_powerup_insta_kill_ug_on", 1);
    if (isdefined(level.var_e34d2c13)) {
        [[ level.var_e34d2c13 ]]();
    }
    randomize_powerups();
    level.zombie_powerup_index = 0;
    randomize_powerups();
    level.rare_powerups_active = 0;
    level.firesale_vox_firstime = 0;
    level thread powerup_hud_monitor();
    clientfield::register("scriptmover", "powerup_fx", 1, 3, "int");
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0x466058e4, Offset: 0x1018
// Size: 0x32
function init_player_zombie_vars() {
    self.zombie_vars["zombie_powerup_insta_kill_ug_on"] = 0;
    self.zombie_vars["zombie_powerup_insta_kill_ug_time"] = 18;
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0x3f149cda, Offset: 0x1058
// Size: 0x36
function set_weapon_ignore_max_ammo(weapon) {
    if (!isdefined(level.zombie_weapons_no_max_ammo)) {
        level.zombie_weapons_no_max_ammo = [];
    }
    level.zombie_weapons_no_max_ammo[weapon] = 1;
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xe6601c3e, Offset: 0x1098
// Size: 0x614
function powerup_hud_monitor() {
    level flag::wait_till("start_zombie_round_logic");
    if (isdefined(level.current_game_module) && level.current_game_module == 2) {
        return;
    }
    flashing_timers = [];
    flashing_values = [];
    flashing_timer = 10;
    flashing_delta_time = 0;
    flashing_is_on = 0;
    flashing_value = 3;
    flashing_min_timer = 0.15;
    while (flashing_timer >= flashing_min_timer) {
        if (flashing_timer < 5) {
            flashing_delta_time = 0.1;
        } else {
            flashing_delta_time = 0.2;
        }
        if (flashing_is_on) {
            flashing_timer = flashing_timer - flashing_delta_time - 0.05;
            flashing_value = 2;
        } else {
            flashing_timer -= flashing_delta_time;
            flashing_value = 3;
        }
        flashing_timers[flashing_timers.size] = flashing_timer;
        flashing_values[flashing_values.size] = flashing_value;
        flashing_is_on = !flashing_is_on;
    }
    client_fields = [];
    powerup_keys = getarraykeys(level.zombie_powerups);
    for (powerup_key_index = 0; powerup_key_index < powerup_keys.size; powerup_key_index++) {
        if (isdefined(level.zombie_powerups[powerup_keys[powerup_key_index]].client_field_name)) {
            powerup_name = powerup_keys[powerup_key_index];
            client_fields[powerup_name] = spawnstruct();
            client_fields[powerup_name].client_field_name = level.zombie_powerups[powerup_name].client_field_name;
            client_fields[powerup_name].only_affects_grabber = level.zombie_powerups[powerup_name].only_affects_grabber;
            client_fields[powerup_name].time_name = level.zombie_powerups[powerup_name].time_name;
            client_fields[powerup_name].on_name = level.zombie_powerups[powerup_name].on_name;
        }
    }
    client_field_keys = getarraykeys(client_fields);
    while (true) {
        wait 0.05;
        waittillframeend();
        players = level.players;
        for (playerindex = 0; playerindex < players.size; playerindex++) {
            for (client_field_key_index = 0; client_field_key_index < client_field_keys.size; client_field_key_index++) {
                player = players[playerindex];
                /#
                    if (isdefined(player.pers["<dev string:x28>"]) && player.pers["<dev string:x28>"]) {
                        continue;
                    }
                #/
                if (isdefined(level.var_bef244e6)) {
                    if (![[ level.var_bef244e6 ]](player)) {
                        continue;
                    }
                }
                client_field_name = client_fields[client_field_keys[client_field_key_index]].client_field_name;
                time_name = client_fields[client_field_keys[client_field_key_index]].time_name;
                on_name = client_fields[client_field_keys[client_field_key_index]].on_name;
                powerup_timer = undefined;
                powerup_on = undefined;
                if (client_fields[client_field_keys[client_field_key_index]].only_affects_grabber) {
                    if (isdefined(player._show_solo_hud) && player._show_solo_hud == 1) {
                        powerup_timer = player.zombie_vars[time_name];
                        powerup_on = player.zombie_vars[on_name];
                    }
                } else if (isdefined(level.zombie_vars[player.team][time_name])) {
                    powerup_timer = level.zombie_vars[player.team][time_name];
                    powerup_on = level.zombie_vars[player.team][on_name];
                } else if (isdefined(level.zombie_vars[time_name])) {
                    powerup_timer = level.zombie_vars[time_name];
                    powerup_on = level.zombie_vars[on_name];
                }
                if (isdefined(powerup_timer) && isdefined(powerup_on)) {
                    player set_clientfield_powerups(client_field_name, powerup_timer, powerup_on, flashing_timers, flashing_values);
                    continue;
                }
                player clientfield::set_to_player(client_field_name, 0);
            }
        }
    }
}

// Namespace zm_powerups
// Params 5, eflags: 0x1 linked
// Checksum 0x262dd9c2, Offset: 0x16b8
// Size: 0x10c
function set_clientfield_powerups(clientfield_name, powerup_timer, powerup_on, flashing_timers, flashing_values) {
    if (powerup_on) {
        if (powerup_timer < 10) {
            flashing_value = 3;
            for (i = flashing_timers.size - 1; i > 0; i--) {
                if (powerup_timer < flashing_timers[i]) {
                    flashing_value = flashing_values[i];
                    break;
                }
            }
            self clientfield::set_to_player(clientfield_name, flashing_value);
        } else {
            self clientfield::set_to_player(clientfield_name, 1);
        }
        return;
    }
    self clientfield::set_to_player(clientfield_name, 0);
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xcb031c17, Offset: 0x17d0
// Size: 0x44
function randomize_powerups() {
    if (!isdefined(level.zombie_powerup_array)) {
        level.zombie_powerup_array = [];
        return;
    }
    level.zombie_powerup_array = array::randomize(level.zombie_powerup_array);
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0x2738967f, Offset: 0x1820
// Size: 0x60
function get_next_powerup() {
    powerup = level.zombie_powerup_array[level.zombie_powerup_index];
    level.zombie_powerup_index++;
    if (level.zombie_powerup_index >= level.zombie_powerup_array.size) {
        level.zombie_powerup_index = 0;
        randomize_powerups();
    }
    return powerup;
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xbf627853, Offset: 0x1888
// Size: 0x116
function get_valid_powerup() {
    /#
        if (isdefined(level.zombie_devgui_power) && level.zombie_devgui_power == 1) {
            level.zombie_devgui_power = 0;
            return level.zombie_powerup_array[level.zombie_powerup_index];
        }
    #/
    if (isdefined(level.zombie_powerup_boss)) {
        i = level.zombie_powerup_boss;
        level.zombie_powerup_boss = undefined;
        return level.zombie_powerup_array[i];
    }
    if (isdefined(level.zombie_powerup_ape)) {
        powerup = level.zombie_powerup_ape;
        level.zombie_powerup_ape = undefined;
        return powerup;
    }
    powerup = get_next_powerup();
    while (true) {
        if (![[ level.zombie_powerups[powerup].func_should_drop_with_regular_powerups ]]()) {
            powerup = get_next_powerup();
            continue;
        }
        return powerup;
    }
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xab726123, Offset: 0x19a8
// Size: 0xe8
function minigun_no_drop() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i].zombie_vars["zombie_powerup_minigun_on"] == 1) {
            return true;
        }
    }
    if (!level flag::get("power_on")) {
        if (level flag::get("solo_game")) {
            if (!isdefined(level.solo_lives_given) || level.solo_lives_given == 0) {
                return true;
            }
        } else {
            return true;
        }
    }
    return false;
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xedf60270, Offset: 0x1a98
// Size: 0x1e4
function watch_for_drop() {
    level endon(#"unloaded");
    level flag::wait_till("start_zombie_round_logic");
    level flag::wait_till("begin_spawning");
    wait 0.05;
    players = getplayers();
    var_76d5c01 = players.size * level.zombie_vars["zombie_score_start_" + players.size + "p"] + level.zombie_vars["zombie_powerup_drop_increment"];
    while (true) {
        level flag::wait_till("zombie_drop_powerups");
        players = getplayers();
        var_47ca12e5 = 0;
        for (i = 0; i < players.size; i++) {
            if (isdefined(players[i].score_total)) {
                var_47ca12e5 += players[i].score_total;
            }
        }
        if (var_47ca12e5 > var_76d5c01) {
            level.zombie_vars["zombie_powerup_drop_increment"] = level.zombie_vars["zombie_powerup_drop_increment"] * 1.14;
            var_76d5c01 = var_47ca12e5 + level.zombie_vars["zombie_powerup_drop_increment"];
            level.zombie_vars["zombie_drop_item"] = 1;
        }
        wait 0.5;
    }
}

// Namespace zm_powerups
// Params 0, eflags: 0x0
// Checksum 0xbe408545, Offset: 0x1c88
// Size: 0x48
function get_random_powerup_name() {
    powerup_keys = getarraykeys(level.zombie_powerups);
    powerup_keys = array::randomize(powerup_keys);
    return powerup_keys[0];
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xac0e4479, Offset: 0x1cd8
// Size: 0xa4
function get_regular_random_powerup_name() {
    powerup_keys = getarraykeys(level.zombie_powerups);
    powerup_keys = array::randomize(powerup_keys);
    for (i = 0; i < powerup_keys.size; i++) {
        if ([[ level.zombie_powerups[powerup_keys[i]].func_should_drop_with_regular_powerups ]]()) {
            return powerup_keys[i];
        }
    }
    return powerup_keys[0];
}

// Namespace zm_powerups
// Params 13, eflags: 0x1 linked
// Checksum 0xcd84ff98, Offset: 0x1d88
// Size: 0x2d0
function add_zombie_powerup(powerup_name, model_name, hint, func_should_drop_with_regular_powerups, only_affects_grabber, any_team, zombie_grabbable, fx, client_field_name, time_name, on_name, clientfield_version, player_specific) {
    if (!isdefined(clientfield_version)) {
        clientfield_version = 1;
    }
    if (!isdefined(player_specific)) {
        player_specific = 0;
    }
    if (isdefined(level.zombie_include_powerups) && !(isdefined(level.zombie_include_powerups[powerup_name]) && level.zombie_include_powerups[powerup_name])) {
        return;
    }
    if (!isdefined(level.zombie_powerup_array)) {
        level.zombie_powerup_array = [];
    }
    struct = spawnstruct();
    if (!isdefined(level.zombie_powerups)) {
        level.zombie_powerups = [];
    }
    struct.powerup_name = powerup_name;
    struct.model_name = model_name;
    struct.weapon_classname = "script_model";
    struct.hint = hint;
    struct.func_should_drop_with_regular_powerups = func_should_drop_with_regular_powerups;
    struct.only_affects_grabber = only_affects_grabber;
    struct.any_team = any_team;
    struct.zombie_grabbable = zombie_grabbable;
    struct.hash_id = hashstring(powerup_name);
    struct.player_specific = player_specific;
    struct.can_pick_up_in_last_stand = 1;
    if (isdefined(fx)) {
        struct.fx = fx;
    }
    level.zombie_powerups[powerup_name] = struct;
    level.zombie_powerup_array[level.zombie_powerup_array.size] = powerup_name;
    add_zombie_special_drop(powerup_name);
    if (isdefined(client_field_name)) {
        clientfield::register("toplayer", client_field_name, clientfield_version, 2, "int");
        struct.client_field_name = client_field_name;
        struct.time_name = time_name;
        struct.on_name = on_name;
    }
}

// Namespace zm_powerups
// Params 2, eflags: 0x1 linked
// Checksum 0x8dde0c35, Offset: 0x2060
// Size: 0x30
function powerup_set_can_pick_up_in_last_stand(powerup_name, b_can_pick_up) {
    level.zombie_powerups[powerup_name].can_pick_up_in_last_stand = b_can_pick_up;
}

// Namespace zm_powerups
// Params 2, eflags: 0x1 linked
// Checksum 0xf76ddef7, Offset: 0x2098
// Size: 0x30
function powerup_set_prevent_pick_up_if_drinking(powerup_name, b_prevent_pick_up) {
    level._custom_powerups[powerup_name].prevent_pick_up_if_drinking = b_prevent_pick_up;
}

// Namespace zm_powerups
// Params 2, eflags: 0x1 linked
// Checksum 0x57e3b873, Offset: 0x20d0
// Size: 0x44
function powerup_set_player_specific(powerup_name, b_player_specific) {
    if (!isdefined(b_player_specific)) {
        b_player_specific = 1;
    }
    level.zombie_powerups[powerup_name].player_specific = b_player_specific;
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0x70c994cd, Offset: 0x2120
// Size: 0x36
function powerup_set_statless_powerup(powerup_name) {
    if (!isdefined(level.zombie_statless_powerups)) {
        level.zombie_statless_powerups = [];
    }
    level.zombie_statless_powerups[powerup_name] = 1;
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0xe91527ec, Offset: 0x2160
// Size: 0x3a
function add_zombie_special_drop(powerup_name) {
    if (!isdefined(level.zombie_special_drop_array)) {
        level.zombie_special_drop_array = [];
    }
    level.zombie_special_drop_array[level.zombie_special_drop_array.size] = powerup_name;
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0xf6d1d1d2, Offset: 0x21a8
// Size: 0x36
function include_zombie_powerup(powerup_name) {
    if (!isdefined(level.zombie_include_powerups)) {
        level.zombie_include_powerups = [];
    }
    level.zombie_include_powerups[powerup_name] = 1;
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0x5e2b4916, Offset: 0x21e8
// Size: 0x7c
function powerup_remove_from_regular_drops(powerup_name) {
    assert(isdefined(level.zombie_powerups));
    assert(isdefined(level.zombie_powerups[powerup_name]));
    level.zombie_powerups[powerup_name].func_should_drop_with_regular_powerups = &func_should_never_drop;
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xf123e19a, Offset: 0x2270
// Size: 0x10
function powerup_round_start() {
    level.powerup_drop_count = 0;
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0x1d2470ba, Offset: 0x2288
// Size: 0x3e2
function powerup_drop(drop_point) {
    if (isdefined(level.var_805d0ecc)) {
        b_outcome = [[ level.var_805d0ecc ]](drop_point);
        if (isdefined(b_outcome) && b_outcome) {
            return;
        }
    }
    if (level.powerup_drop_count >= level.zombie_vars["zombie_powerup_drop_max_per_round"]) {
        println("<dev string:x2e>");
        return;
    }
    if (!isdefined(level.zombie_include_powerups) || level.zombie_include_powerups.size == 0) {
        return;
    }
    var_5da59d5c = randomint(100);
    if (bgb::is_team_enabled("zm_bgb_power_vacuum") && var_5da59d5c < 20) {
        debug = "zm_bgb_power_vacuum";
    } else if (var_5da59d5c > 2) {
        if (!level.zombie_vars["zombie_drop_item"]) {
            return;
        }
        debug = "score";
    } else {
        debug = "random";
    }
    playable_area = getentarray("player_volume", "script_noteworthy");
    level.powerup_drop_count++;
    powerup = zm_net::network_safe_spawn("powerup", 1, "script_model", drop_point + (0, 0, 40));
    valid_drop = 0;
    for (i = 0; i < playable_area.size; i++) {
        if (powerup istouching(playable_area[i])) {
            valid_drop = 1;
            break;
        }
    }
    if (valid_drop && level.rare_powerups_active) {
        pos = (drop_point[0], drop_point[1], drop_point[2] + 42);
        if (check_for_rare_drop_override(pos)) {
            level.zombie_vars["zombie_drop_item"] = 0;
            valid_drop = 0;
        }
    }
    if (!valid_drop) {
        level.powerup_drop_count--;
        powerup delete();
        return;
    }
    powerup powerup_setup();
    print_powerup_drop(powerup.powerup_name, debug);
    bb::logpowerupevent(powerup, undefined, "_dropped");
    powerup thread powerup_timeout();
    powerup thread powerup_wobble();
    powerup thread powerup_grab();
    powerup thread function_6627e739();
    powerup thread powerup_emp();
    level.zombie_vars["zombie_drop_item"] = 0;
    level notify(#"powerup_dropped", powerup);
}

// Namespace zm_powerups
// Params 7, eflags: 0x1 linked
// Checksum 0x3374877a, Offset: 0x2678
// Size: 0x1a2
function specific_powerup_drop(powerup_name, var_43d485f9, powerup_team, powerup_location, pickup_delay, powerup_player, b_stay_forever) {
    powerup = zm_net::network_safe_spawn("powerup", 1, "script_model", var_43d485f9 + (0, 0, 40));
    level notify(#"powerup_dropped", powerup);
    if (isdefined(powerup)) {
        powerup powerup_setup(powerup_name, powerup_team, powerup_location, powerup_player);
        if (!(isdefined(b_stay_forever) && b_stay_forever)) {
            powerup thread powerup_timeout();
        }
        powerup thread powerup_wobble();
        if (isdefined(pickup_delay) && pickup_delay > 0) {
            powerup util::delay(pickup_delay, "powerup_timedout", &powerup_grab, powerup_team);
        } else {
            powerup thread powerup_grab(powerup_team);
        }
        powerup thread function_6627e739();
        powerup thread powerup_emp();
        return powerup;
    }
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0x7d4f50b9, Offset: 0x2828
// Size: 0x13c
function function_b347edb5(drop_point) {
    if (!isdefined(level.zombie_include_powerups) || level.zombie_include_powerups.size == 0) {
        return;
    }
    powerup = spawn("script_model", drop_point + (0, 0, 40));
    playable_area = getentarray("player_volume", "script_noteworthy");
    valid_drop = 0;
    for (i = 0; i < playable_area.size; i++) {
        if (powerup istouching(playable_area[i])) {
            valid_drop = 1;
            break;
        }
    }
    if (!valid_drop) {
        powerup delete();
        return;
    }
    powerup function_e65b5a70();
}

// Namespace zm_powerups
// Params 5, eflags: 0x1 linked
// Checksum 0x2419e844, Offset: 0x2970
// Size: 0x352
function powerup_setup(powerup_override, powerup_team, powerup_location, powerup_player, shouldplaysound) {
    if (!isdefined(shouldplaysound)) {
        shouldplaysound = 1;
    }
    powerup = undefined;
    if (!isdefined(powerup_override)) {
        powerup = get_valid_powerup();
    } else {
        powerup = powerup_override;
        if ("tesla" == powerup && tesla_powerup_active()) {
            powerup = "minigun";
        }
    }
    struct = level.zombie_powerups[powerup];
    if (isdefined(level._custom_powerups) && isdefined(level._custom_powerups[powerup]) && isdefined(level._custom_powerups[powerup].setup_powerup)) {
        self [[ level._custom_powerups[powerup].setup_powerup ]]();
    } else {
        self setmodel(struct.model_name);
    }
    demo::bookmark("zm_powerup_dropped", gettime(), undefined, undefined, 1);
    if (isdefined(shouldplaysound) && shouldplaysound) {
        playsoundatposition("zmb_spawn_powerup", self.origin);
    }
    if (isdefined(powerup_team)) {
        self.powerup_team = powerup_team;
    }
    if (isdefined(powerup_location)) {
        self.powerup_location = powerup_location;
    }
    if (isdefined(powerup_player)) {
        self.powerup_player = powerup_player;
    } else {
        assert(!(isdefined(struct.player_specific) && struct.player_specific), "<dev string:x59>");
    }
    self.powerup_name = struct.powerup_name;
    self.hint = struct.hint;
    self.only_affects_grabber = struct.only_affects_grabber;
    self.any_team = struct.any_team;
    self.zombie_grabbable = struct.zombie_grabbable;
    self.func_should_drop_with_regular_powerups = struct.func_should_drop_with_regular_powerups;
    if (isdefined(struct.fx)) {
        self.fx = struct.fx;
    }
    if (isdefined(struct.can_pick_up_in_last_stand)) {
        self.can_pick_up_in_last_stand = struct.can_pick_up_in_last_stand;
    }
    self playloopsound("zmb_spawn_powerup_loop");
    level.active_powerups[level.active_powerups.size] = self;
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xfcc05d26, Offset: 0x2cd0
// Size: 0x1ac
function function_e65b5a70() {
    powerup = undefined;
    if (isdefined(level.var_9408c924)) {
        powerup = [[ level.var_9408c924 ]]();
    } else {
        powerup = get_valid_powerup();
    }
    if (isdefined(powerup)) {
        playfx(level._effect["lightning_dog_spawn"], self.origin);
        playsoundatposition("zmb_hellhound_prespawn", self.origin);
        wait 1.5;
        playsoundatposition("zmb_hellhound_bolt", self.origin);
        earthquake(0.5, 0.75, self.origin, 1000);
        playsoundatposition("zmb_hellhound_spawn", self.origin);
        self powerup_setup(powerup);
        self thread powerup_timeout();
        self thread powerup_wobble();
        self thread powerup_grab();
        self thread function_6627e739();
        self thread powerup_emp();
    }
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0x52a07459, Offset: 0x2e88
// Size: 0x54
function powerup_zombie_grab_trigger_cleanup(trigger) {
    self util::waittill_any("powerup_timedout", "powerup_grabbed", "hacked");
    trigger delete();
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0x312253db, Offset: 0x2ee8
// Size: 0x35e
function powerup_zombie_grab(powerup_team) {
    self endon(#"powerup_timedout");
    self endon(#"powerup_grabbed");
    self endon(#"hacked");
    zombie_grab_trigger = spawn("trigger_radius", self.origin - (0, 0, 40), 9, 32, 72);
    zombie_grab_trigger enablelinkto();
    zombie_grab_trigger linkto(self);
    zombie_grab_trigger setteamfortrigger(level.zombie_team);
    self thread powerup_zombie_grab_trigger_cleanup(zombie_grab_trigger);
    poi_dist = 300;
    if (isdefined(level._zombie_grabbable_poi_distance_override)) {
        poi_dist = level._zombie_grabbable_poi_distance_override;
    }
    zombie_grab_trigger zm_utility::create_zombie_point_of_interest(poi_dist, 2, 0, 1, undefined, undefined, powerup_team);
    while (isdefined(self)) {
        who = zombie_grab_trigger waittill(#"trigger");
        if (isdefined(level.var_352c26bc)) {
            if (!self [[ level.var_352c26bc ]](who)) {
                continue;
            }
        } else if (!isdefined(who) || !isai(who)) {
            continue;
        }
        playfx(level._effect["powerup_grabbed_red"], self.origin);
        if (isdefined(level._custom_powerups) && isdefined(level._custom_powerups[self.powerup_name]) && isdefined(level._custom_powerups[self.powerup_name].grab_powerup)) {
            b_continue = self [[ level._custom_powerups[self.powerup_name].grab_powerup ]]();
            if (isdefined(b_continue) && b_continue) {
                continue;
            }
        } else {
            if (isdefined(level._zombiemode_powerup_zombie_grab)) {
                level thread [[ level._zombiemode_powerup_zombie_grab ]](self);
            }
            if (isdefined(level._game_mode_powerup_zombie_grab)) {
                level thread [[ level._game_mode_powerup_zombie_grab ]](self, who);
            } else {
                println("<dev string:x92>");
            }
        }
        level thread zm_audio::sndannouncerplayvox(self.powerup_name);
        wait 0.1;
        playsoundatposition("zmb_powerup_grabbed", self.origin);
        self stoploopsound();
        self thread powerup_delete_delayed();
        self notify(#"powerup_grabbed");
    }
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0x8dc7ff86, Offset: 0x3250
// Size: 0x8e8
function powerup_grab(powerup_team) {
    if (isdefined(self) && self.zombie_grabbable) {
        self thread powerup_zombie_grab(powerup_team);
        return;
    }
    self endon(#"powerup_timedout");
    self endon(#"powerup_grabbed");
    range_squared = 4096;
    while (isdefined(self)) {
        if (isdefined(self.powerup_player)) {
            grabbers = [];
            grabbers[0] = self.powerup_player;
        } else if (isdefined(level.var_661e1459)) {
            grabbers = [[ level.var_661e1459 ]]();
        } else {
            grabbers = getplayers();
        }
        for (i = 0; i < grabbers.size; i++) {
            grabber = grabbers[i];
            if (isalive(grabber.owner) && isplayer(grabber.owner)) {
                player = grabber.owner;
            } else if (isplayer(grabber)) {
                player = grabber;
            }
            if (self.only_affects_grabber && !isdefined(player)) {
                continue;
            }
            if (isdefined(level._custom_powerups[self.powerup_name].prevent_pick_up_if_drinking) && isdefined(player.is_drinking) && player.is_drinking > 0 && isdefined(level._custom_powerups) && isdefined(level._custom_powerups[self.powerup_name]) && level._custom_powerups[self.powerup_name].prevent_pick_up_if_drinking) {
                continue;
            }
            if (player usebuttonpressed() && (!isplayer(grabber) || player laststand::player_is_in_laststand() || player zm_utility::in_revive_trigger()) || (self.powerup_name == "minigun" || self.powerup_name == "tesla" || self.powerup_name == "random_weapon" || self.powerup_name == "meat_stink") && player bgb::is_enabled("zm_bgb_disorderly_combat")) {
                continue;
            }
            if (!(isdefined(self.can_pick_up_in_last_stand) && self.can_pick_up_in_last_stand) && player laststand::player_is_in_laststand()) {
                continue;
            }
            ignore_range = 0;
            if (grabber.ignore_range_powerup === self) {
                grabber.ignore_range_powerup = undefined;
                ignore_range = 1;
            }
            if (distancesquared(grabber.origin, self.origin) < range_squared || ignore_range) {
                if (isdefined(level.var_352c26bc)) {
                    if (!self [[ level.var_352c26bc ]](player)) {
                        continue;
                    }
                }
                if (isdefined(level._custom_powerups) && isdefined(level._custom_powerups[self.powerup_name]) && isdefined(level._custom_powerups[self.powerup_name].grab_powerup)) {
                    b_continue = self [[ level._custom_powerups[self.powerup_name].grab_powerup ]](player);
                    if (isdefined(b_continue) && b_continue) {
                        continue;
                    }
                } else {
                    switch (self.powerup_name) {
                    case "teller_withdrawl":
                        level thread teller_withdrawl(self, player);
                        break;
                    default:
                        if (isdefined(level._zombiemode_powerup_grab)) {
                            level thread [[ level._zombiemode_powerup_grab ]](self, player);
                        } else {
                            println("<dev string:x92>");
                        }
                        break;
                    }
                }
                demo::bookmark("zm_player_powerup_grabbed", gettime(), player);
                bb::logpowerupevent(self, player, "_grabbed");
                if (isdefined(self.hash_id)) {
                    player recordmapevent(23, gettime(), grabber.origin, level.round_number, self.hash_id);
                }
                if (should_award_stat(self.powerup_name) && isplayer(player)) {
                    player zm_stats::increment_client_stat("drops");
                    player zm_stats::increment_player_stat("drops");
                    player zm_stats::increment_client_stat(self.powerup_name + "_pickedup");
                    player zm_stats::increment_player_stat(self.powerup_name + "_pickedup");
                    player zm_stats::increment_challenge_stat("SURVIVALIST_POWERUP");
                }
                if (self.only_affects_grabber) {
                    playfx(level._effect["powerup_grabbed_solo"], self.origin);
                } else if (self.any_team) {
                    playfx(level._effect["powerup_grabbed_caution"], self.origin);
                } else {
                    playfx(level._effect["powerup_grabbed"], self.origin);
                }
                if (isdefined(self.stolen) && self.stolen) {
                    level notify(#"monkey_see_monkey_dont_achieved");
                }
                if (isdefined(self.grabbed_level_notify)) {
                    level notify(self.grabbed_level_notify);
                }
                self.claimed = 1;
                self.power_up_grab_player = player;
                wait 0.1;
                playsoundatposition("zmb_powerup_grabbed", self.origin);
                self stoploopsound();
                self hide();
                if (self.powerup_name != "fire_sale") {
                    if (isdefined(self.power_up_grab_player)) {
                        if (isdefined(level.powerup_intro_vox)) {
                            level thread [[ level.powerup_intro_vox ]](self);
                            return;
                        } else if (isdefined(level.powerup_vo_available)) {
                            can_say_vo = [[ level.powerup_vo_available ]]();
                            if (!can_say_vo) {
                                self thread powerup_delete_delayed();
                                self notify(#"powerup_grabbed");
                                return;
                            }
                        }
                    }
                }
                if (isdefined(self.only_affects_grabber) && self.only_affects_grabber) {
                    level thread zm_audio::sndannouncerplayvox(self.powerup_name, player);
                } else {
                    level thread zm_audio::sndannouncerplayvox(self.powerup_name);
                }
                self thread powerup_delete_delayed();
                self notify(#"powerup_grabbed");
            }
        }
        wait 0.1;
    }
}

// Namespace zm_powerups
// Params 2, eflags: 0x0
// Checksum 0xe1182dcb, Offset: 0x3b40
// Size: 0x13e
function get_closest_window_repair(windows, origin) {
    current_window = undefined;
    shortest_distance = undefined;
    for (i = 0; i < windows.size; i++) {
        if (zm_utility::all_chunks_intact(windows, windows[i].barrier_chunks)) {
            continue;
        }
        if (!isdefined(current_window)) {
            current_window = windows[i];
            shortest_distance = distancesquared(current_window.origin, origin);
            continue;
        }
        if (distancesquared(windows[i].origin, origin) < shortest_distance) {
            current_window = windows[i];
            shortest_distance = distancesquared(windows[i].origin, origin);
        }
    }
    return current_window;
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0x9d79aa47, Offset: 0x3c88
// Size: 0xf0
function powerup_vo(type) {
    self endon(#"death");
    self endon(#"disconnect");
    if (!isplayer(self)) {
        return;
    }
    if (isdefined(level.powerup_vo_available)) {
        if (![[ level.powerup_vo_available ]]()) {
            return;
        }
    }
    wait randomfloatrange(2, 2.5);
    if (type == "tesla") {
        self zm_audio::create_and_play_dialog("weapon_pickup", type);
    } else {
        self zm_audio::create_and_play_dialog("powerup", type);
    }
    if (isdefined(level.custom_powerup_vo_response)) {
        level [[ level.custom_powerup_vo_response ]](self, type);
    }
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0x7a049d1b, Offset: 0x3d80
// Size: 0xec
function powerup_wobble_fx() {
    self endon(#"death");
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(level.powerup_fx_func)) {
        self thread [[ level.powerup_fx_func ]]();
        return;
    }
    if (self.only_affects_grabber) {
        self clientfield::set("powerup_fx", 2);
        return;
    }
    if (self.any_team) {
        self clientfield::set("powerup_fx", 4);
        return;
    }
    if (self.zombie_grabbable) {
        self clientfield::set("powerup_fx", 3);
        return;
    }
    self clientfield::set("powerup_fx", 1);
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xaf5e929f, Offset: 0x3e78
// Size: 0x1b8
function powerup_wobble() {
    self endon(#"powerup_grabbed");
    self endon(#"powerup_timedout");
    self thread powerup_wobble_fx();
    while (isdefined(self)) {
        waittime = randomfloatrange(2.5, 5);
        yaw = randomint(360);
        if (yaw > 300) {
            yaw = 300;
        } else if (yaw < 60) {
            yaw = 60;
        }
        yaw = self.angles[1] + yaw;
        new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
        self rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
        if (isdefined(self.worldgundw)) {
            self.worldgundw rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
        }
        wait randomfloat(waittime - 0.1);
    }
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0x889fd64a, Offset: 0x4038
// Size: 0x11c
function powerup_show(visible) {
    if (!visible) {
        self ghost();
        if (isdefined(self.worldgundw)) {
            self.worldgundw ghost();
        }
        return;
    }
    self show();
    if (isdefined(self.worldgundw)) {
        self.worldgundw show();
    }
    if (isdefined(self.powerup_player)) {
        self setinvisibletoall();
        self setvisibletoplayer(self.powerup_player);
        if (isdefined(self.worldgundw)) {
            self.worldgundw setinvisibletoall();
            self.worldgundw setvisibletoplayer(self.powerup_player);
        }
    }
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0x1e6dd338, Offset: 0x4160
// Size: 0x1dc
function powerup_timeout() {
    if (isdefined(level._powerup_timeout_override) && !isdefined(self.powerup_team)) {
        self thread [[ level._powerup_timeout_override ]]();
        return;
    }
    self endon(#"powerup_grabbed");
    self endon(#"death");
    self endon(#"powerup_reset");
    self powerup_show(1);
    wait_time = 15;
    if (isdefined(level.var_f1e9e5aa)) {
        time = [[ level.var_f1e9e5aa ]](self);
        if (time == 0) {
            return;
        }
        wait_time = time;
    }
    if (bgb::is_team_enabled("zm_bgb_temporal_gift")) {
        wait_time += 30;
    }
    wait wait_time;
    for (i = 0; i < 40; i++) {
        if (i % 2) {
            self powerup_show(0);
        } else {
            self powerup_show(1);
        }
        if (i < 15) {
            wait 0.5;
            continue;
        }
        if (i < 25) {
            wait 0.25;
            continue;
        }
        wait 0.1;
    }
    self notify(#"powerup_timedout");
    bb::logpowerupevent(self, undefined, "_timedout");
    self powerup_delete();
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xcee46366, Offset: 0x4348
// Size: 0x64
function powerup_delete() {
    arrayremovevalue(level.active_powerups, self, 0);
    if (isdefined(self.worldgundw)) {
        self.worldgundw delete();
    }
    self delete();
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0x1f7dff30, Offset: 0x43b8
// Size: 0x3c
function powerup_delete_delayed(time) {
    if (isdefined(time)) {
        wait time;
    } else {
        wait 0.01;
    }
    self powerup_delete();
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0x2e0dc7ee, Offset: 0x4400
// Size: 0x1e
function is_insta_kill_active() {
    return level.zombie_vars[self.team]["zombie_insta_kill"];
}

// Namespace zm_powerups
// Params 3, eflags: 0x1 linked
// Checksum 0x88e21f7b, Offset: 0x4428
// Size: 0x314
function function_3308d17f(player, mod, hit_location) {
    if (isdefined(player) && isalive(player) && isdefined(level.check_for_instakill_override)) {
        if (!self [[ level.check_for_instakill_override ]](player)) {
            return;
        }
        if (player.var_1f20fd1c == "MOD_MELEE") {
            player.var_60722328 = "MOD_MELEE";
        } else {
            player.var_60722328 = "MOD_UNKNOWN";
        }
        modname = zm_utility::function_ae17e96c(mod);
        if (!(isdefined(self.no_gib) && self.no_gib)) {
            self zombie_utility::zombie_head_gib();
        }
        self.health = 1;
        self dodamage(self.health + 666, self.origin, player, self, hit_location, modname);
        player notify(#"zombie_killed");
    }
    if (isdefined(player.personal_instakill) && (level.zombie_vars[player.team]["zombie_insta_kill"] || isdefined(player) && isalive(player) && player.personal_instakill)) {
        if (zm_utility::is_magic_bullet_shield_enabled(self)) {
            return;
        }
        if (isdefined(self.instakill_func)) {
            b_result = self thread [[ self.instakill_func ]](player, mod, hit_location);
            if (isdefined(b_result) && b_result) {
                return;
            }
        }
        if (player.var_1f20fd1c == "MOD_MELEE") {
            player.var_60722328 = "MOD_MELEE";
        } else {
            player.var_60722328 = "MOD_UNKNOWN";
        }
        modname = zm_utility::function_ae17e96c(mod);
        if (!level flag::get("special_round") && !(isdefined(self.no_gib) && self.no_gib)) {
            self zombie_utility::zombie_head_gib();
        }
        self.health = 1;
        self dodamage(self.health + 666, self.origin, player, self, hit_location, modname);
        player notify(#"zombie_killed");
    }
}

// Namespace zm_powerups
// Params 2, eflags: 0x0
// Checksum 0xfe8a6aab, Offset: 0x4748
// Size: 0x94
function point_doubler_on_hud(drop_item, player_team) {
    self endon(#"disconnect");
    if (level.zombie_vars[player_team]["zombie_powerup_double_points_on"]) {
        level.zombie_vars[player_team]["zombie_powerup_double_points_time"] = 30;
        return;
    }
    level.zombie_vars[player_team]["zombie_powerup_double_points_on"] = 1;
    level thread time_remaining_on_point_doubler_powerup(player_team);
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0xb7d9c438, Offset: 0x47e8
// Size: 0x194
function time_remaining_on_point_doubler_powerup(player_team) {
    temp_ent = spawn("script_origin", (0, 0, 0));
    temp_ent playloopsound("zmb_double_point_loop");
    while (level.zombie_vars[player_team]["zombie_powerup_double_points_time"] >= 0) {
        wait 0.05;
        level.zombie_vars[player_team]["zombie_powerup_double_points_time"] = level.zombie_vars[player_team]["zombie_powerup_double_points_time"] - 0.05;
    }
    level.zombie_vars[player_team]["zombie_powerup_double_points_on"] = 0;
    players = getplayers(player_team);
    for (i = 0; i < players.size; i++) {
        players[i] playsound("zmb_points_loop_off");
    }
    temp_ent stoploopsound(2);
    level.zombie_vars[player_team]["zombie_powerup_double_points_time"] = 30;
    temp_ent delete();
}

// Namespace zm_powerups
// Params 0, eflags: 0x0
// Checksum 0xf4ba4d9c, Offset: 0x4988
// Size: 0xc
function devil_dialog_delay() {
    wait 1;
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0xb24d15f, Offset: 0x49a0
// Size: 0x34
function check_for_rare_drop_override(pos) {
    if (level flagsys::get("ape_round")) {
        return false;
    }
    return false;
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0x7d67e808, Offset: 0x49e0
// Size: 0x72
function tesla_powerup_active() {
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        if (players[i].zombie_vars["zombie_powerup_tesla_on"]) {
            return true;
        }
    }
    return false;
}

// Namespace zm_powerups
// Params 2, eflags: 0x1 linked
// Checksum 0xddaa27c9, Offset: 0x4a60
// Size: 0x194
function print_powerup_drop(powerup, type) {
    /#
        if (!isdefined(level.powerup_drop_time)) {
            level.powerup_drop_time = 0;
            level.powerup_random_count = 0;
            level.var_63897f08 = 0;
        }
        time = (gettime() - level.powerup_drop_time) * 0.001;
        level.powerup_drop_time = gettime();
        if (type == "<dev string:xa7>") {
            level.powerup_random_count++;
        } else {
            level.var_63897f08++;
        }
        println("<dev string:xae>");
        println("<dev string:xd5>" + powerup);
        println("<dev string:xdf>" + type);
        println("<dev string:xf0>");
        println("<dev string:x105>" + time);
        println("<dev string:x111>" + level.powerup_random_count);
        println("<dev string:x111>" + level.var_63897f08);
        println("<dev string:x128>");
    #/
}

// Namespace zm_powerups
// Params 2, eflags: 0x0
// Checksum 0x28906c0e, Offset: 0x4c00
// Size: 0x56
function register_carpenter_node(node, callback) {
    if (!isdefined(level._additional_carpenter_nodes)) {
        level._additional_carpenter_nodes = [];
    }
    node._post_carpenter_callback = callback;
    level._additional_carpenter_nodes[level._additional_carpenter_nodes.size] = node;
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xf66d6d14, Offset: 0x4c60
// Size: 0x28
function function_108ccd4b() {
    if (isdefined(level.var_2d4f1f79) && level.var_2d4f1f79 == 1) {
        return true;
    }
    return false;
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0x15f81d72, Offset: 0x4c90
// Size: 0x6
function func_should_never_drop() {
    return false;
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0xc0452ad2, Offset: 0x4ca0
// Size: 0x8
function func_should_always_drop() {
    return true;
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0x2b2d02f3, Offset: 0x4cb0
// Size: 0xfc
function function_6627e739() {
    self endon(#"powerup_timedout");
    self endon(#"powerup_grabbed");
    var_8751c69b = 75;
    while (true) {
        moveto, distance = self waittill(#"hash_d51e26c3");
        var_d09882f7 = moveto - self.origin;
        range_squared = lengthsquared(var_d09882f7);
        if (range_squared > distance * distance) {
            var_d09882f7 = vectornormalize(var_d09882f7);
            var_d09882f7 = distance * var_d09882f7;
            moveto = self.origin + var_d09882f7;
        }
        self.origin = moveto;
    }
}

// Namespace zm_powerups
// Params 0, eflags: 0x1 linked
// Checksum 0x49b78d73, Offset: 0x4db8
// Size: 0xde
function powerup_emp() {
    self endon(#"powerup_timedout");
    self endon(#"powerup_grabbed");
    if (!zm_utility::should_watch_for_emp()) {
        return;
    }
    while (true) {
        origin, radius = level waittill(#"emp_detonate");
        if (distancesquared(origin, self.origin) < radius * radius) {
            playfx(level._effect["powerup_off"], self.origin);
            self thread powerup_delete_delayed();
            self notify(#"powerup_timedout");
        }
    }
}

// Namespace zm_powerups
// Params 2, eflags: 0x1 linked
// Checksum 0xc359d26b, Offset: 0x4ea0
// Size: 0xf6
function get_powerups(origin, radius) {
    if (isdefined(origin) && isdefined(radius)) {
        powerups = [];
        foreach (powerup in level.active_powerups) {
            if (distancesquared(origin, powerup.origin) < radius * radius) {
                powerups[powerups.size] = powerup;
            }
        }
        return powerups;
    }
    return level.active_powerups;
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0x1f8a0fc2, Offset: 0x4fa0
// Size: 0x88
function should_award_stat(powerup_name) {
    if (powerup_name == "teller_withdrawl" || powerup_name == "blue_monkey" || powerup_name == "free_perk" || powerup_name == "bonus_points_player") {
        return false;
    }
    if (isdefined(level.zombie_statless_powerups) && isdefined(level.zombie_statless_powerups[powerup_name]) && level.zombie_statless_powerups[powerup_name]) {
        return false;
    }
    return true;
}

// Namespace zm_powerups
// Params 2, eflags: 0x1 linked
// Checksum 0x8252d25b, Offset: 0x5030
// Size: 0x34
function teller_withdrawl(powerup, player) {
    player zm_score::add_to_player_score(powerup.value);
}

// Namespace zm_powerups
// Params 2, eflags: 0x1 linked
// Checksum 0x38fd37c9, Offset: 0x5070
// Size: 0x11c
function show_on_hud(player_team, str_powerup) {
    self endon(#"disconnect");
    str_index_on = "zombie_powerup_" + str_powerup + "_on";
    str_index_time = "zombie_powerup_" + str_powerup + "_time";
    if (level.zombie_vars[player_team][str_index_on]) {
        level.zombie_vars[player_team][str_index_time] = 30;
        if (bgb::is_team_enabled("zm_bgb_temporal_gift")) {
            level.zombie_vars[player_team][str_index_time] = level.zombie_vars[player_team][str_index_time] + 30;
        }
        return;
    }
    level.zombie_vars[player_team][str_index_on] = 1;
    level thread time_remaining_on_powerup(player_team, str_powerup);
}

// Namespace zm_powerups
// Params 2, eflags: 0x1 linked
// Checksum 0x2d7c744a, Offset: 0x5198
// Size: 0x214
function time_remaining_on_powerup(player_team, str_powerup) {
    str_index_on = "zombie_powerup_" + str_powerup + "_on";
    str_index_time = "zombie_powerup_" + str_powerup + "_time";
    str_sound_loop = "zmb_" + str_powerup + "_loop";
    str_sound_off = "zmb_" + str_powerup + "_loop_off";
    temp_ent = spawn("script_origin", (0, 0, 0));
    temp_ent playloopsound(str_sound_loop);
    if (bgb::is_team_enabled("zm_bgb_temporal_gift")) {
        level.zombie_vars[player_team][str_index_time] = level.zombie_vars[player_team][str_index_time] + 30;
    }
    while (level.zombie_vars[player_team][str_index_time] >= 0) {
        wait 0.05;
        level.zombie_vars[player_team][str_index_time] = level.zombie_vars[player_team][str_index_time] - 0.05;
    }
    level.zombie_vars[player_team][str_index_on] = 0;
    getplayers()[0] playsoundtoteam(str_sound_off, player_team);
    temp_ent stoploopsound(2);
    level.zombie_vars[player_team][str_index_time] = 30;
    temp_ent delete();
}

// Namespace zm_powerups
// Params 4, eflags: 0x1 linked
// Checksum 0x9da563eb, Offset: 0x53b8
// Size: 0x1f4
function weapon_powerup(ent_player, time, str_weapon, allow_cycling) {
    if (!isdefined(allow_cycling)) {
        allow_cycling = 0;
    }
    str_weapon_on = "zombie_powerup_" + str_weapon + "_on";
    str_weapon_time_over = str_weapon + "_time_over";
    ent_player notify(#"replace_weapon_powerup");
    ent_player._show_solo_hud = 1;
    ent_player.has_specific_powerup_weapon[str_weapon] = 1;
    ent_player.has_powerup_weapon = 1;
    ent_player zm_utility::increment_is_drinking();
    if (allow_cycling) {
        ent_player enableweaponcycling();
    }
    ent_player._zombie_weapon_before_powerup[str_weapon] = ent_player getcurrentweapon();
    ent_player giveweapon(level.zombie_powerup_weapon[str_weapon]);
    ent_player switchtoweapon(level.zombie_powerup_weapon[str_weapon]);
    ent_player.zombie_vars[str_weapon_on] = 1;
    level thread weapon_powerup_countdown(ent_player, str_weapon_time_over, time, str_weapon);
    level thread weapon_powerup_replace(ent_player, str_weapon_time_over, str_weapon);
    level thread weapon_powerup_change(ent_player, str_weapon_time_over, str_weapon);
}

// Namespace zm_powerups
// Params 3, eflags: 0x1 linked
// Checksum 0x813c5681, Offset: 0x55b8
// Size: 0xdc
function weapon_powerup_change(ent_player, str_gun_return_notify, str_weapon) {
    ent_player endon(#"death");
    ent_player endon(#"disconnect");
    ent_player endon(#"player_downed");
    ent_player endon(str_gun_return_notify);
    ent_player endon(#"replace_weapon_powerup");
    while (true) {
        newweapon, oldweapon = ent_player waittill(#"weapon_change");
        if (newweapon != level.weaponnone && newweapon != level.zombie_powerup_weapon[str_weapon]) {
            break;
        }
    }
    level thread weapon_powerup_remove(ent_player, str_gun_return_notify, str_weapon, 0);
}

// Namespace zm_powerups
// Params 4, eflags: 0x1 linked
// Checksum 0xff19999e, Offset: 0x56a0
// Size: 0x12c
function weapon_powerup_countdown(ent_player, str_gun_return_notify, time, str_weapon) {
    ent_player endon(#"death");
    ent_player endon(#"disconnect");
    ent_player endon(#"player_downed");
    ent_player endon(str_gun_return_notify);
    ent_player endon(#"replace_weapon_powerup");
    str_weapon_time = "zombie_powerup_" + str_weapon + "_time";
    ent_player.zombie_vars[str_weapon_time] = time;
    if (bgb::is_team_enabled("zm_bgb_temporal_gift")) {
        ent_player.zombie_vars[str_weapon_time] = ent_player.zombie_vars[str_weapon_time] + 30;
    }
    [[ level._custom_powerups[str_weapon].weapon_countdown ]](ent_player, str_weapon_time);
    level thread weapon_powerup_remove(ent_player, str_gun_return_notify, str_weapon, 1);
}

// Namespace zm_powerups
// Params 3, eflags: 0x1 linked
// Checksum 0xe29192fc, Offset: 0x57d8
// Size: 0xfc
function weapon_powerup_replace(ent_player, str_gun_return_notify, str_weapon) {
    ent_player endon(#"death");
    ent_player endon(#"disconnect");
    ent_player endon(#"player_downed");
    ent_player endon(str_gun_return_notify);
    str_weapon_on = "zombie_powerup_" + str_weapon + "_on";
    ent_player waittill(#"replace_weapon_powerup");
    ent_player takeweapon(level.zombie_powerup_weapon[str_weapon]);
    ent_player.zombie_vars[str_weapon_on] = 0;
    ent_player.has_specific_powerup_weapon[str_weapon] = 0;
    ent_player.has_powerup_weapon = 0;
    ent_player zm_utility::decrement_is_drinking();
}

// Namespace zm_powerups
// Params 4, eflags: 0x1 linked
// Checksum 0xb0d08de0, Offset: 0x58e0
// Size: 0x134
function weapon_powerup_remove(ent_player, str_gun_return_notify, str_weapon, b_switch_back_weapon) {
    if (!isdefined(b_switch_back_weapon)) {
        b_switch_back_weapon = 1;
    }
    ent_player endon(#"death");
    ent_player endon(#"player_downed");
    str_weapon_on = "zombie_powerup_" + str_weapon + "_on";
    ent_player takeweapon(level.zombie_powerup_weapon[str_weapon]);
    ent_player.zombie_vars[str_weapon_on] = 0;
    ent_player._show_solo_hud = 0;
    ent_player.has_specific_powerup_weapon[str_weapon] = 0;
    ent_player.has_powerup_weapon = 0;
    ent_player notify(str_gun_return_notify);
    ent_player zm_utility::decrement_is_drinking();
    if (b_switch_back_weapon) {
        ent_player zm_weapons::switch_back_primary_weapon(ent_player._zombie_weapon_before_powerup[str_weapon]);
    }
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0xba5b8d43, Offset: 0x5a20
// Size: 0x158
function weapon_watch_gunner_downed(str_weapon) {
    str_notify = str_weapon + "_time_over";
    str_weapon_on = "zombie_powerup_" + str_weapon + "_on";
    if (!isdefined(self.has_specific_powerup_weapon) || !(isdefined(self.has_specific_powerup_weapon[str_weapon]) && self.has_specific_powerup_weapon[str_weapon])) {
        return;
    }
    primaryweapons = self getweaponslistprimaries();
    for (i = 0; i < primaryweapons.size; i++) {
        if (primaryweapons[i] == level.zombie_powerup_weapon[str_weapon]) {
            self takeweapon(level.zombie_powerup_weapon[str_weapon]);
        }
    }
    self notify(str_notify);
    self.zombie_vars[str_weapon_on] = 0;
    self._show_solo_hud = 0;
    wait 0.05;
    self.has_specific_powerup_weapon[str_weapon] = 0;
    self.has_powerup_weapon = 0;
}

// Namespace zm_powerups
// Params 3, eflags: 0x1 linked
// Checksum 0x1dab04fd, Offset: 0x5b80
// Size: 0xe4
function register_powerup(str_powerup, func_grab_powerup, func_setup) {
    assert(isdefined(str_powerup), "<dev string:x14f>");
    _register_undefined_powerup(str_powerup);
    if (isdefined(func_grab_powerup)) {
        if (!isdefined(level._custom_powerups[str_powerup].grab_powerup)) {
            level._custom_powerups[str_powerup].grab_powerup = func_grab_powerup;
        }
    }
    if (isdefined(func_setup)) {
        if (!isdefined(level._custom_powerups[str_powerup].setup_powerup)) {
            level._custom_powerups[str_powerup].setup_powerup = func_setup;
        }
    }
}

// Namespace zm_powerups
// Params 1, eflags: 0x1 linked
// Checksum 0x82b72d1b, Offset: 0x5c70
// Size: 0x74
function _register_undefined_powerup(str_powerup) {
    if (!isdefined(level._custom_powerups)) {
        level._custom_powerups = [];
    }
    if (!isdefined(level._custom_powerups[str_powerup])) {
        level._custom_powerups[str_powerup] = spawnstruct();
        include_zombie_powerup(str_powerup);
    }
}

// Namespace zm_powerups
// Params 2, eflags: 0x1 linked
// Checksum 0x8f8e6611, Offset: 0x5cf0
// Size: 0x98
function register_powerup_weapon(str_powerup, func_countdown) {
    assert(isdefined(str_powerup), "<dev string:x14f>");
    _register_undefined_powerup(str_powerup);
    if (isdefined(func_countdown)) {
        if (!isdefined(level._custom_powerups[str_powerup].weapon_countdown)) {
            level._custom_powerups[str_powerup].weapon_countdown = func_countdown;
        }
    }
}

