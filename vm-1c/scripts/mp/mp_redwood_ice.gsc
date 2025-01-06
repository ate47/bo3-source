#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_ball_utils;
#using scripts/mp/mp_redwood_ice_fx;
#using scripts/mp/mp_redwood_ice_sound;
#using scripts/shared/_oob;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_redwood_ice;

// Namespace mp_redwood_ice
// Params 0, eflags: 0x0
// Checksum 0xc9c34250, Offset: 0x1a8
// Size: 0x194
function main() {
    precache();
    level.uav_z_offset = 500;
    level.uav_rotation_radius = 1000;
    level.uav_rotation_random_offset = 1000;
    level.counter_uav_position_z_offset = 0;
    level.cuav_map_x_percentage = 0.25;
    level.heli_visual_range_override = 10000;
    level.var_6b8375c8 = 10000;
    level.escort_drop_speed = 7000;
    level.escort_drop_accel = 5000;
    level.escort_drop_height = 3000;
    mp_redwood_ice_fx::main();
    mp_redwood_ice_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_redwood_ice");
    setdvar("compassmaxrange", "2100");
    level.cleandepositpoints = array((-448.776, -210.531, 50.5891), (1928.72, 191.469, 270.089), (570.724, -732.031, 165.589), (-1356.28, 58.969, 63.0891), (-955.276, -1142.53, 156.089));
}

// Namespace mp_redwood_ice
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x348
// Size: 0x4
function precache() {
    
}

