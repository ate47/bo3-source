#using scripts/cp/_util;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_814e90c0;

// Namespace namespace_814e90c0
// Params 0, eflags: 0x1 linked
// namespace_814e90c0<file_0>::function_7403e82b
// Checksum 0x5886deaa, Offset: 0x310
// Size: 0xa1c
function function_7403e82b() {
    var_f4bf0a10 = spawn("script_model", (-5538, 9256, -93));
    var_f4bf0a10 setmodel("p7_shelf_modern_02_e");
    var_f4bf0a10.angles = (0, 180, 0);
    var_f4bf0a10 = spawn("script_model", (-5693, 9256, 320));
    var_f4bf0a10 setmodel("p7_shelf_modern_02_e");
    var_f4bf0a10.angles = (0, 180, 0);
    var_f4bf0a10 = spawn("script_model", (-5760, 9256, 320));
    var_f4bf0a10 setmodel("p7_shelf_modern_02_e");
    var_f4bf0a10.angles = (0, 180, 0);
    spawncollision("collision_clip_wall_256x256x10", "collider", (-1757, 10725, 288), (0, 350, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (-1776, 10621, 288), (0, 350, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (-1757, 10725, 544), (0, 350, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (-1776, 10621, 544), (0, 350, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (5717, 2562, 852), (0, 0, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (5717, 2446, 852), (0, 0, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (8607, 6518, 520), (0, 135, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (8607, 6518, 264), (0, 135, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (8523, 6434, 520), (0, 135, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (8523, 6434, 264), (0, 135, 0));
    spawncollision("collision_player_wall_256x256x10", "collider", (7192, 3771, 264), (0, 270, 0));
    spawncollision("collision_player_wall_256x256x10", "collider", (7258, 3771, 264), (0, 270, 0));
    spawncollision("collision_clip_128x128x128", "collider", (8710, 4706, -26), (0, 0, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-3026, 11244, 258), (0, 0, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-3026, 11244, 770), (0, 0, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-2796.61, 11464.8, 258), (0, 263.4, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-2796.61, 11464.8, 770), (0, 263.4, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-2288, 11406, 258), (0, 263.4, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-2288, 11406, 770), (0, 263.4, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-1779.39, 11347.2, 258), (0, 263.4, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-1779.39, 11347.2, 770), (0, 263.4, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-1552, 11074, 258), (0, 0, 0));
    spawncollision("collision_clip_wall_512x512x10", "collider", (-1552, 11074, 770), (0, 0, 0));
    spawncollision("collision_player_256x256x256", "collider", (-4146, 9465, -136), (0, 0, 0));
    spawncollision("collision_player_256x256x256", "collider", (-4070, 9465, -136), (0, 0, 0));
    var_7c6ce185 = spawn("script_model", (-1664.21, 2488.96, -415.985));
    var_7c6ce185 setmodel("p7_sin_ship_container_384_blue");
    var_7c6ce185.angles = (275.738, 51.9803, -143.901);
    spawncollision("collision_player_256x256x256", "collider", (-1739.08, 2506.11, -370.376), (273.8, 358.4, 1.30979e-05));
    spawncollision("collision_player_256x256x256", "collider", (-1588.17, 2501.89, -380.374), (273.8, 358.4, 1.30979e-05));
    spawncollision("collision_player_wall_512x512x10", "collider", (-1872, 2480, -248), (0, 270, 0));
    spawncollision("collision_player_wall_512x512x10", "collider", (-1872, 2500, -248), (0, 270, 0));
    model2 = spawn("script_model", (-4339.17, 10311.4, -93));
    model2 setmodel("p7_shelf_modern_02_e");
    model2.angles = (0, 2.59983, 0);
    var_c871d657 = spawn("script_model", (-4413.11, 10310, -93));
    var_c871d657 setmodel("p7_shelf_modern_02_e");
    var_c871d657.angles = (0, 356, 0);
    var_5b36c229 = spawncollision("collision_clip_128x128x128", "collider", (-4348, 10350, -108), (0, 180, 0));
    var_5b36c229 disconnectpaths();
    var_81393c92 = spawncollision("collision_clip_128x128x128", "collider", (-4392, 10350, -108), (0, 180, 0));
    var_81393c92 disconnectpaths();
}

