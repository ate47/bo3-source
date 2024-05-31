#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_14c8b75c;

// Namespace namespace_14c8b75c
// Params 0, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_c35e6aab
// Checksum 0x15d9ee4a, Offset: 0x2c0
// Size: 0x34
function init() {
    clientfield::register("world", "play_dogfight_scenes", 9000, 3, "int");
}

// Namespace namespace_14c8b75c
// Params 0, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_d290ebfa
// Checksum 0x4bd68594, Offset: 0x300
// Size: 0xd4
function main() {
    if (getdvarint("splitscreen_playerCount") >= 3) {
        return;
    }
    level waittill(#"hash_5574fd9b");
    level thread function_5daf587e();
    level thread function_2737bcd8();
    level thread function_99236d51();
    level thread function_b9d547c();
    level clientfield::set("play_dogfight_scenes", 0);
    level clientfield::set("play_dogfight_scenes", 5);
}

// Namespace namespace_14c8b75c
// Params 0, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_5daf587e
// Checksum 0x17c068f4, Offset: 0x3e0
// Size: 0x2c
function function_5daf587e() {
    wait(4);
    level clientfield::set("play_dogfight_scenes", 1);
}

// Namespace namespace_14c8b75c
// Params 0, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_2737bcd8
// Checksum 0xfa83d40e, Offset: 0x418
// Size: 0x54
function function_2737bcd8() {
    level flag::wait_till_any(array("connect_swamp_to_swamp_lab", "connect_swamp_lab_to_bunker_exterior"));
    level clientfield::set("play_dogfight_scenes", 2);
}

// Namespace namespace_14c8b75c
// Params 0, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_99236d51
// Checksum 0x6e32f7a9, Offset: 0x478
// Size: 0x5c
function function_99236d51() {
    level flag::wait_till_any(array("connect_jungle_to_jungle_lab", "connect_jungle_lab_to_bunker_exterior"));
    wait(2);
    level clientfield::set("play_dogfight_scenes", 3);
}

// Namespace namespace_14c8b75c
// Params 0, eflags: 0x1 linked
// namespace_14c8b75c<file_0>::function_b9d547c
// Checksum 0x54ec9ce8, Offset: 0x4e0
// Size: 0x4c
function function_b9d547c() {
    level flag::wait_till("connect_bunker_interior_to_bunker_upper");
    wait(2);
    level clientfield::set("play_dogfight_scenes", 4);
}

