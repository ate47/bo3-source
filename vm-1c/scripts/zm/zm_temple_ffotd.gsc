#using scripts/zm/_zm;
#using scripts/codescripts/struct;

#namespace zm_temple_ffotd;

// Namespace zm_temple_ffotd
// Params 0, eflags: 0x1 linked
// Checksum 0xff76f463, Offset: 0x248
// Size: 0x13e
function main_start() {
    a_wallbuys = struct::get_array("weapon_upgrade", "targetname");
    foreach (s_wallbuy in a_wallbuys) {
        if (s_wallbuy.zombie_weapon_upgrade == "smg_standard") {
            s_wallbuy.origin += (0, 5, 0);
        }
    }
    spawncollision("collision_bullet_wall_128x128x10", "collider", (1555, -1493, -293), (0, 347.199, 0));
    level._effect["powerup_on_red"] = "zombie/fx_powerup_on_red_zmb";
}

// Namespace zm_temple_ffotd
// Params 0, eflags: 0x1 linked
// Checksum 0x4134d4a9, Offset: 0x390
// Size: 0x46c
function main_end() {
    spawncollision("collision_clip_ramp_256x24", "collider", (-51.9, -1049.64, -253.5), (90, 10.25, 75.85));
    spawncollision("collision_clip_ramp_256x24", "collider", (-51.9, -1049.64, 2.5), (90, 10.25, 75.85));
    spawncollision("collision_clip_ramp_256x24", "collider", (-51.9, -1049.64, 258.5), (90, 10.25, 75.85));
    spawncollision("collision_clip_wedge_32x256", "collider", (44, -1020, -240), (0, 180, 0));
    spawncollision("collision_clip_wedge_32x256", "collider", (44, -1020, 16), (0, 180, 0));
    spawncollision("collision_clip_wedge_32x256", "collider", (44, -1020, 272), (0, 180, 0));
    spawncollision("collision_player_slick_32x32x128", "collider", (51.9385, -1035.86, -16.28), (316.299, 351.698, -90));
    spawncollision("collision_monster_128x128x128", "collider", (93.3531, -1041.94, 46), (0, 351.397, 0));
    spawncollision("collision_player_wall_512x512x10", "collider", (-1000, -1392, 122), (270, 0, 0));
    spawncollision("collision_player_wall_512x512x10", "collider", (-1112, -1560, 122), (270, 0, 0));
    spawncollision("collision_player_wall_512x512x10", "collider", (-1125.08, -859.956, -328), (270, 0.2, 21.5992));
    spawncollision("collision_player_wall_256x256x10", "collider", (-1048.47, -1100.99, -205.044), (6.5924e-06, 291.799, 90));
    spawncollision("collision_player_slick_wall_256x256x10", "collider", (1009.23, -1052.8, 1.965), (4.49303, 183.106, 0.243273));
    spawncollision("collision_player_slick_wedge_32x128", "collider", (-1655.5, -428, 8), (270, 270, 0));
    spawncollision("collision_player_slick_wall_128x128x10", "collider", (546.5, -499.5, -347), (0, 3.79971, 0));
    spawncollision("collision_player_slick_wall_128x128x10", "collider", (541, -439.5, -347), (0, 6.299, 0));
}

