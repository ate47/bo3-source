#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_util;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_hunter;

#namespace aquifer_ambience;

// Namespace aquifer_ambience
// Params 0, eflags: 0x2
// Checksum 0x7ff6e376, Offset: 0x418
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("aquifer_ambience", &__init__, undefined, undefined);
}

// Namespace aquifer_ambience
// Params 0, eflags: 0x0
// Checksum 0xe8605dda, Offset: 0x458
// Size: 0x124
function __init__() {
    clientfield::register("world", "hide_sand_storm", 1, 1, "int");
    clientfield::register("toplayer", "show_sand_storm", 1, 1, "int");
    clientfield::register("world", "play_trucks", 1, 1, "int");
    clientfield::register("world", "start_ambience", 1, 1, "int");
    clientfield::register("world", "stop_ambience", 1, 1, "int");
    clientfield::register("world", "kill_ambience", 1, 1, "int");
}

// Namespace aquifer_ambience
// Params 0, eflags: 0x0
// Checksum 0x7f6ac514, Offset: 0x588
// Size: 0x94
function main() {
    thread function_4b099a44();
    thread function_8f28e703("lotus_hunter1", "exterior_hack_trig_left_1_started", 10);
    thread function_8f28e703("lotus_hunter2", "exterior_hack_trig_right_1_started", 10);
    thread function_febb5e1e();
    thread function_9f32fed2();
    thread function_bf52f93f();
}

// Namespace aquifer_ambience
// Params 0, eflags: 0x0
// Checksum 0x9b94703f, Offset: 0x628
// Size: 0x1fc
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

// Namespace aquifer_ambience
// Params 0, eflags: 0x0
// Checksum 0xf5f2ce85, Offset: 0x830
// Size: 0x9c
function function_4b099a44() {
    var_9ca5f644 = getentarray("aqu_intro_vista_cards_01", "targetname");
    if (level flag::exists("level_long_fly_in_completed") && !level flag::get("level_long_fly_in_completed")) {
        level waittill(#"level_long_fly_in_completed");
    }
    if (isdefined(var_9ca5f644)) {
        array::delete_all(var_9ca5f644);
    }
}

// Namespace aquifer_ambience
// Params 0, eflags: 0x0
// Checksum 0x18028a, Offset: 0x8d8
// Size: 0x1b8
function function_febb5e1e() {
    level endon(#"intro_finished");
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

// Namespace aquifer_ambience
// Params 3, eflags: 0x0
// Checksum 0x9182eeed, Offset: 0xa98
// Size: 0x222
function function_8f28e703(tname, start_flag, interval) {
    var_f2ceeb93 = struct::get_array(tname, "targetname");
    while (!flag::exists(start_flag)) {
        wait 0.5;
    }
    level flag::wait_till(start_flag);
    foreach (hunter in var_f2ceeb93) {
        wait interval;
        seen = 1;
        while (seen == 1) {
            wait 0.5;
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

// Namespace aquifer_ambience
// Params 0, eflags: 0x0
// Checksum 0x7123127a, Offset: 0xcc8
// Size: 0x8c
function function_bf52f93f() {
    level flag::wait_till("player_active_in_level");
    if (level flag::get("level_long_fly_in_completed")) {
        return;
    }
    wait 1;
    level.players[0].var_8fedf36c waittill(#"hash_2bc810f9");
    clientfield::set("play_trucks", 1);
}

