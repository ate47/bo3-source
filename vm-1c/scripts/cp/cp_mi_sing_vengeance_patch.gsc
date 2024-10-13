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

#namespace cp_mi_sing_vengeance_patch;

// Namespace cp_mi_sing_vengeance_patch
// Params 0, eflags: 0x1 linked
// Checksum 0x38b17a3, Offset: 0x270
// Size: 0x784
function function_7403e82b() {
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20048, -19180, -68), (89.9998, 336.857, -68.1424));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20492, -19624, -68), (89.9998, 336.857, -68.1424));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20448, -19580, -68), (89.9998, 336.857, -68.1424));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20404, -19536, -68), (89.9998, 336.857, -68.1424));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20358, -19490, -68), (89.9998, 336.857, -68.1424));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20314, -19446, -68), (89.9998, 336.857, -68.1424));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20270, -19402, -68), (89.9998, 336.857, -68.1424));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20226, -19358, -68), (89.9998, 336.857, -68.1424));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20182, -19314, -68), (89.9998, 336.857, -68.1424));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20138, -19270, -68), (89.9998, 336.857, -68.1424));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20092, -19224, -68), (89.9998, 336.857, -68.1424));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20048, -19180, -68), (89.9998, 336.857, -68.1424));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20010, -19130, -68), (89.9997, 1.07557, -63.9237));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-19998, -19080, -68), (89.9997, 21.9553, -63.0439));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20004, -19038, -68), (89.9997, 43.2052, -66.7939));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20025.9, -18996, -68), (89.9997, 66.3654, -68.6337));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20069.9, -18966, -68), (89.9997, 68.8355, -81.1634));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20115.9, -18950, -68), (89.9997, 86.1582, -83.8407));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20154, -18944, -68), (89.9997, 25.3462, -64.6531));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20218, -18944, -68), (89.9997, 25.3462, -64.6531));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20278, -18944, -68), (89.9997, 25.3462, -64.6531));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20342, -18944, -68), (89.9997, 25.3462, -64.6531));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20402, -18944, -68), (89.9997, 25.3462, -64.6531));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-20462, -18944, -68), (89.9997, 25.3462, -64.6531));
    spawncollision("collision_player_256x256x256", "collider", (-19640, -18272, 424), (0, 0, 0));
    spawncollision("collision_player_512x512x512", "collider", (-19384, -18040, 552), (0, 0, 0));
    spawncollision("collision_player_512x512x512", "collider", (-18872, -18040, 552), (0, 0, 0));
    spawncollision("collision_player_512x512x512", "collider", (-18360, -18040, 552), (0, 0, 0));
}

