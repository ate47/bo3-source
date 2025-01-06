#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_redwood_fx;
#using scripts/mp/mp_redwood_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_redwood;

// Namespace mp_redwood
// Params 0, eflags: 0x0
// Checksum 0x72bfc8f3, Offset: 0x158
// Size: 0xc2
function main() {
    precache();
    level.uav_z_offset = 500;
    level.uav_rotation_radius = 1000;
    level.uav_rotation_random_offset = 1000;
    level.counter_uav_position_z_offset = 0;
    level.cuav_map_x_percentage = 0.25;
    level.heli_visual_range_override = 10000;
    mp_redwood_fx::main();
    mp_redwood_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_redwood");
    setdvar("compassmaxrange", "2100");
}

// Namespace mp_redwood
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x228
// Size: 0x2
function precache() {
    
}

