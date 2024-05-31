#using scripts/cp/_load;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/cp/_util;
#using scripts/shared/fx_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/vehicles/_hunter;
#using scripts/shared/vehicle_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/array_shared;

#namespace namespace_1254c007;

// Namespace namespace_1254c007
// Params 0, eflags: 0x2
// Checksum 0xed99fcea, Offset: 0x418
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("aquifer_ambience", &__init__, undefined, undefined);
}

// Namespace namespace_1254c007
// Params 0, eflags: 0x0
// Checksum 0x791ebe30, Offset: 0x450
// Size: 0xf2
function __init__() {
    clientfield::register("world", "hide_sand_storm", 1, 1, "int");
    clientfield::register("toplayer", "show_sand_storm", 1, 1, "int");
    clientfield::register("world", "play_trucks", 1, 1, "int");
    clientfield::register("world", "start_ambience", 1, 1, "int");
    clientfield::register("world", "stop_ambience", 1, 1, "int");
    clientfield::register("world", "kill_ambience", 1, 1, "int");
}

// Namespace namespace_1254c007
// Params 0, eflags: 0x0
// Checksum 0x23c3b645, Offset: 0x550
// Size: 0x82
function main() {
    thread function_4b099a44();
    thread function_8f28e703("lotus_hunter1", "exterior_hack_trig_left_1_started", 10);
    thread function_8f28e703("lotus_hunter2", "exterior_hack_trig_right_1_started", 10);
    thread function_febb5e1e();
    thread function_9f32fed2();
    thread function_bf52f93f();
}

// Namespace namespace_1254c007
// Params 0, eflags: 0x0
// Checksum 0xfabec992, Offset: 0x5e0
// Size: 0x172
function function_9f32fed2() {
    level flag::wait_till("player_active_in_level");
    num = 1;
    if (!level flag::get("water_room_completed") && !level flag::get("inside_water_room")) {
        clientfield::set("start_ambience", num);
        num = 0;
        level flag::wait_till("inside_water_room");
        clientfield::set("stop_ambience", 1);
    }
    if (level flag::get("water_room_exit") || level flag::get("water_room")) {
        level flag::wait_till("flag_khalil_water_exit");
    }
    if (level flag::get("inside_water_room")) {
        level flag::clear("inside_water_room");
    }
    if (!level flag::get("inside_aquifer")) {
        clientfield::set("start_ambience", num);
        level flag::wait_till("inside_aquifer");
        clientfield::set("kill_ambience", 1);
    }
}

// Namespace namespace_1254c007
// Params 0, eflags: 0x0
// Checksum 0xbdd5edfb, Offset: 0x760
// Size: 0x82
function function_4b099a44() {
    var_9ca5f644 = getentarray("aqu_intro_vista_cards_01", "targetname");
    if (level flag::exists("level_long_fly_in_completed") && !level flag::get("level_long_fly_in_completed")) {
        level waittill(#"hash_1486d0dc");
    }
    if (isdefined(var_9ca5f644)) {
        array::delete_all(var_9ca5f644);
    }
}

// Namespace namespace_1254c007
// Params 0, eflags: 0x0
// Checksum 0x30e3e1f8, Offset: 0x7f0
// Size: 0x141
function function_febb5e1e() {
    level endon(#"hash_935c5b8e");
    var_f92ecad5 = [];
    var_8f76637c = 0;
    level flag::wait_till("player_active_in_level");
    if (level flag::get("level_long_fly_in")) {
        clientfield::set("hide_sand_storm", 1);
        while (true) {
            t = trigger::wait_till("Sand_Storm_Trigger");
            foreach (num in var_f92ecad5) {
                if (t.who.player_num == num) {
                    var_8f76637c = 1;
                }
            }
            if (var_8f76637c == 0) {
                t.who clientfield::set_to_player("show_sand_storm", 1);
                array::add(var_f92ecad5, t.who.player_num);
            }
            var_8f76637c = 0;
        }
    }
}

// Namespace namespace_1254c007
// Params 3, eflags: 0x0
// Checksum 0xfa936cdc, Offset: 0x940
// Size: 0x187
function function_8f28e703(tname, start_flag, interval) {
    var_f2ceeb93 = struct::get_array(tname, "targetname");
    while (!flag::exists(start_flag)) {
        wait(0.5);
    }
    level flag::wait_till(start_flag);
    foreach (hunter in var_f2ceeb93) {
        wait(interval);
        seen = 1;
        while (seen == 1) {
            wait(0.5);
            seen = 0;
            foreach (player in level.players) {
                if (0 == player playersighttrace(hunter.origin, 50000, 0)) {
                    seen = 1;
                }
            }
        }
        hunter scene::play(hunter.scriptbundlename);
        hunter scene::stop(1);
        hunter.scene_played = 0;
    }
}

// Namespace namespace_1254c007
// Params 0, eflags: 0x0
// Checksum 0x1d9a4514, Offset: 0xad0
// Size: 0x6a
function function_bf52f93f() {
    level flag::wait_till("player_active_in_level");
    if (level flag::get("level_long_fly_in_completed")) {
        return;
    }
    wait(1);
    level.players[0].var_8fedf36c waittill(#"hash_2bc810f9");
    clientfield::set("play_trucks", 1);
}

