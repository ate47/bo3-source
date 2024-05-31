#using scripts/zm/_zm_utility;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_711c2fc8;

// Namespace namespace_711c2fc8
// Params 0, eflags: 0x1 linked
// namespace_711c2fc8<file_0>::function_8a5375f3
// Checksum 0x99ec1590, Offset: 0x2b0
// Size: 0x4
function main_start() {
    
}

// Namespace namespace_711c2fc8
// Params 0, eflags: 0x1 linked
// namespace_711c2fc8<file_0>::function_ead4e420
// Checksum 0x310333f1, Offset: 0x2c0
// Size: 0x60a
function main_end() {
    zm::spawn_life_brush((2870, -179, -480), -56, 360);
    zm::spawn_life_brush((-1964, 1146, 304), -128, -106);
    zm::spawn_life_brush((3070, -2257, -733), 96, -56);
    zm::spawn_life_brush((-10, 3506, -424), -100, -128);
    zm::spawn_life_brush((-4573, 1301, -409), 256, 300);
    zm::spawn_life_brush((2190, 800, -213), 32, -128);
    zm::spawn_life_brush((1900, -24, -694), -60, 64);
    spawn("trigger_box", (-1100, 7740, -750), 0, 350, -56, 300) disconnectpaths();
    spawncollision("collision_monster_32x32x32", "collider", (272, 5120, -626), (0, 0, 0)) disconnectpaths();
    spawncollision("collision_monster_32x32x32", "collider", (-31, 5120, -626), (0, 0, 0)) disconnectpaths();
    spawncollision("collision_player_256x256x256", "collider", (1759, 1186, -604), (0, 0, 0));
    spawncollision("collision_player_256x256x256", "collider", (1724, 1007, -599), (0, 0, 0));
    spawncollision("collision_player_64x64x64", "collider", (2202, 805, -250), (12, 45, 0));
    spawncollision("collision_player_64x64x64", "collider", (-432, 7041, -598.5), (0, 0, 0));
    spawncollision("collision_player_64x64x64", "collider", (486, 2522, -216), (0, 0, 0));
    spawncollision("collision_player_wall_128x128x10", "collider", (-6, 5924, -482), (0, 270, 0));
    spawncollision("collision_player_32x32x32", "collider", (1614.5, 4558, -429), (0, 10.2996, 0));
    spawncollision("collision_player_wall_128x128x10", "collider", (-83.5, 3392.5, -335.5), (0, 0, 0));
    zm::spawn_kill_brush((-929.5, 2593, -500), 512, 64);
    zm::spawn_kill_brush((2763, -426, -608), 64, 96);
    zm::spawn_kill_brush((2877, -282, -702), 256, 32);
    spawncollision("collision_player_wall_128x128x10", "collider", (2950, 572, -640), (0, 314.2, 0));
    var_dbcadb22 = spawn("trigger_box", (2392, 596, -210), 0, 32, 512, 64);
    var_dbcadb22.angles = (0, 45, 0);
    var_dbcadb22.script_noteworthy = "kill_brush";
    if (level flag::get("solo_game")) {
        a_t_doors = getentarray("zombie_door", "targetname");
        foreach (t_door in a_t_doors) {
            if (t_door.zombie_cost >= 1000) {
                t_door.zombie_cost -= -6;
                t_door zm_utility::set_hint_string(t_door, "default_buy_door", t_door.zombie_cost);
            }
        }
    }
}

