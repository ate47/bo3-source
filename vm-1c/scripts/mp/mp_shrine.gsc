#using scripts/mp/mp_shrine_sound;
#using scripts/mp/mp_shrine_fx;
#using scripts/mp/_util;
#using scripts/mp/_load;
#using scripts/shared/scene_shared;
#using scripts/shared/compass;
#using scripts/shared/util_shared;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/shared/_oob;
#using scripts/codescripts/struct;

#namespace mp_shrine;

// Namespace mp_shrine
// Params 0, eflags: 0x1 linked
// Checksum 0x532a352b, Offset: 0x2b8
// Size: 0xc0c
function main() {
    precache();
    spawnlogic::move_spawn_point("mp_dm_spawn_start", (-2052.36, -1532.15, 9.88573), (-1560.58, -1510.2, 41.625), (0, 5, 0));
    spawnlogic::move_spawn_point("mp_dm_spawn_start", (1505.87, -451.962, 125.625), (641.951, -48.0704, 68.4194), (0, 180, 0));
    spawnlogic::move_spawn_point("mp_dm_spawn_start", (2304.03, 113.973, 125.625), (336.038, 738.986, -117.375), (0, 201, 0));
    trigger = spawn("trigger_radius_out_of_bounds", (1983.5, 893, -39.5), 0, 75, -128);
    trigger thread oob::run_oob_trigger();
    trigger = spawn("trigger_radius_out_of_bounds", (-2550.5, 267.5, -3), 0, 100, -128);
    trigger thread oob::run_oob_trigger();
    trigger = spawn("trigger_radius_out_of_bounds", (1673, 1001, -97), 0, 80, -128);
    trigger thread oob::run_oob_trigger();
    trigger = spawn("trigger_radius_out_of_bounds", (114.5, -1160, -320), 0, 256, -106);
    trigger thread oob::run_oob_trigger();
    trigger = spawn("trigger_radius_out_of_bounds", (-2846, -65, -333), 0, 400, 380);
    trigger thread oob::run_oob_trigger();
    trigger = spawn("trigger_radius_out_of_bounds", (2663.5, 31, -126.5), 0, 300, -56);
    trigger thread oob::run_oob_trigger();
    level.levelkothdisable = [];
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (-460, -206.5, 102.5), 0, 50, -128);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (-513, -206.5, 102.5), 0, 50, -128);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (-566.5, -206.5, 102.5), 0, 50, -128);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (451.5, 413, 11.5), 0, -76, -56);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (521, 518, 11.5), 0, 125, -56);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (909, 267.5, 10.5), 0, 50, -56);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (761.5, -1425.5, 69.5), 0, 50, -56);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (927.5, -1425.5, 84.5), 0, 50, -56);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (1016, -1425.5, 84.5), 0, 50, -56);
    level.levelkothdisable[level.levelkothdisable.size] = spawn("trigger_radius", (1104.5, -1425.5, 84.5), 0, 50, -56);
    mp_shrine_fx::main();
    mp_shrine_sound::main();
    compass::setupminimap("compass_map_mp_shrine");
    load::main();
    setdvar("compassmaxrange", "2100");
    spawncollision("collision_clip_wall_64x64x10", "collider", (-1750, -300.5, -42.5), (36, 270, 3));
    var_d9167367 = spawn("script_model", (1639.44, -939.959, 313.5));
    var_d9167367.angles = (270, 359, -94);
    var_d9167367 setmodel("p7_shr_rock_cave_lrg_02_grime");
    var_88668348 = spawn("script_model", (-605.5, -1132.5, 88));
    var_88668348.angles = (0, 270, 0);
    var_88668348 setmodel("p7_zm_isl_wooden_foundation_post");
    var_88668348 setscale(2);
    spawncollision("collision_clip_wall_128x128x10", "collider", (2016.5, 756.5, 282.5), (0, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (2016.5, 756.5, 409.5), (0, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (2016.5, 756.5, 535.5), (0, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-1939.5, -833, -40), (29, -43, -1));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-1979, -810, -35), (8, 260, -2));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-1997, -807, -35), (8, 260, -2));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-2027.5, -802, -35), (8, 260, -2));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-937.5, -1229, 265.5), (0, 7, 0));
    spawncollision("collision_bullet_wall_128x128x10", "collider", (1206.5, 96.5, 166.5), (0, 0, 0));
    spawncollision("collision_bullet_wall_128x128x10", "collider", (1206.5, 28, 166.5), (0, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (2386, 410.5, 258), (350, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (2386, 537, 258), (350, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (2386, 566, 258), (350, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-1300, -1112, -87), (24, 277, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (564.5, -1203.5, 266.5), (6, 357.2, 0));
    level.cleandepositpoints = array((-34.8423, 496.19, -160.136), (-436.008, -1438.99, 99), (-1446.79, 331.569, -21.875), (1268.65, -1219.36, 82.2472));
    function_19a0648();
    /#
        level thread updatedvars();
    #/
    level thread function_83e6bfad();
}

// Namespace mp_shrine
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xed0
// Size: 0x4
function precache() {
    
}

// Namespace mp_shrine
// Params 0, eflags: 0x1 linked
// Checksum 0x7cbdf281, Offset: 0xee0
// Size: 0x84
function function_19a0648() {
    level.var_c86c4a33 = [];
    level.var_5664daf8 = [];
    for (i = 1; i <= 7; i++) {
        level.var_c86c4a33[level.var_c86c4a33.size] = "dragon_a_" + i;
        level.var_5664daf8[level.var_5664daf8.size] = "dragon_b_" + i;
    }
}

/#

    // Namespace mp_shrine
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf65f1805, Offset: 0xf70
    // Size: 0x98
    function updatedvars() {
        level.var_9d27b884 = 0;
        level.var_bab0430d = 0;
        while (true) {
            level.var_bab0430d = getdvarint("<dev string:x28>", level.var_bab0430d);
            if (level.var_bab0430d && !level.var_9d27b884) {
                function_aa8f2924();
            }
            wait 1;
            level.var_9d27b884 = level.var_bab0430d;
        }
    }

#/

// Namespace mp_shrine
// Params 0, eflags: 0x1 linked
// Checksum 0x16be0791, Offset: 0x1010
// Size: 0x12a
function function_aa8f2924() {
    if (isdefined(level.var_c86c4a33)) {
        foreach (var_e81d2518 in level.var_c86c4a33) {
            thread scene::play(var_e81d2518);
        }
    }
    if (isdefined(level.var_5664daf8)) {
        foreach (var_e81d2518 in level.var_5664daf8) {
            thread scene::play(var_e81d2518);
        }
    }
}

// Namespace mp_shrine
// Params 0, eflags: 0x1 linked
// Checksum 0x5f86ed70, Offset: 0x1148
// Size: 0x10c
function function_83e6bfad() {
    var_54a18c50 = randomfloat(1);
    if (0.4 > var_54a18c50) {
        if (isdefined(level.var_c86c4a33) && level.var_c86c4a33.size > 0) {
            var_5a3eff2d = randomint(level.var_c86c4a33.size);
            thread scene::play(level.var_c86c4a33[var_5a3eff2d]);
        }
        if (isdefined(level.var_5664daf8) && level.var_5664daf8.size > 0) {
            var_80417996 = randomint(level.var_5664daf8.size);
            thread scene::play(level.var_5664daf8[var_80417996]);
        }
    }
}

