#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_rome_fx;
#using scripts/mp/mp_rome_sound;
#using scripts/shared/_oob;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_rome;

// Namespace mp_rome
// Params 0
// Checksum 0x29a8bb2a, Offset: 0x210
// Size: 0xadc
function main()
{
    precache();
    mp_rome_fx::main();
    mp_rome_sound::main();
    trigger = spawn( "trigger_radius_out_of_bounds", ( -1062.5, -257.5, 348 ), 0, 21, 128 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 264.5, -2177.5, 205 ), 0, 400, 128 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 611.5, -2501, 217 ), 0, 400, 128 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( -138.5, -2159, 208 ), 0, 400, 128 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 1745, -2474.5, 208 ), 0, 400, 110 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 2033.5, -2247.5, 208 ), 0, 400, 110 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 2197, -2001, 208 ), 0, 400, 110 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 2208, -1869.5, 245 ), 0, 300, 150 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 2682.5, -1695, 187 ), 0, 400, 200 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 2720, -1140.5, 143 ), 0, 250, 300 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 2943.5, -1190, 143 ), 0, 300, 300 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 3167, -1152.5, 143 ), 0, 300, 300 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 1497.5, 1922, 48.5 ), 0, 400, 128 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 912, 1862, 80 ), 0, 256, 128 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 420, 1914, 80 ), 0, 256, 128 );
    trigger thread oob::run_oob_trigger();
    trigger = spawn( "trigger_radius_out_of_bounds", ( 201.5, 1914, 80 ), 0, 256, 128 );
    trigger thread oob::run_oob_trigger();
    level.levelkothdisable = [];
    level.levelkothdisable[ level.levelkothdisable.size ] = spawn( "trigger_radius", ( -141, 515, 223.5 ), 0, 100, 128 );
    load::main();
    compass::setupminimap( "compass_map_mp_rome" );
    setdvar( "compassmaxrange", "2100" );
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( -101.5, -362.5, 488.5 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_wall_64x64x10", "collider", ( -210, -651, 558 ), ( 7, 334, 1 ) );
    spawncollision( "collision_clip_wall_512x512x10", "collider", ( -552.5, -1466.5, 596 ), ( 0, 314, 0 ) );
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( 1720.5, -854, 458 ), ( 0, 270, 0 ) );
    spawncollision( "collision_clip_wall_32x32x10", "collider", ( 455.5, -1139, 353 ), ( 297, 17, -15 ) );
    spawncollision( "collision_clip_wall_32x32x10", "collider", ( 482.5, -1139, 339.5 ), ( 297, 17, -15 ) );
    spawncollision( "collision_clip_wall_32x32x10", "collider", ( 487.5, -1139, 338 ), ( 291, 360, -2 ) );
    spawncollision( "collision_clip_wall_64x64x10", "collider", ( -200.5, 733.5, 522.5 ), ( 12, 315, 0 ) );
    spawncollision( "collision_clip_wall_32x32x10", "collider", ( -288.5, 855.5, 307 ), ( 36, 271, 5 ) );
    spawncollision( "collision_clip_wall_32x32x10", "collider", ( -302, 839, 307.5 ), ( 32, 336, 0 ) );
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( -248.5, 604, 450 ), ( 358, 270, 0 ) );
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( -100.5, 604, 450 ), ( 358, 270, 0 ) );
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( -123.5, 604, 450 ), ( 358, 270, 0 ) );
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( 3021, -703, 383.5 ), ( 0, 0, 0 ) );
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( 2063.39, -1674.07, 392.987 ), ( 345, 273, 0 ) );
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( 2185.37, -1643.5, 392.987 ), ( 345, 290, 0 ) );
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( 2303.36, -1593.57, 392.987 ), ( 345, 302, 0 ) );
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( 2402.35, -1515.57, 392.987 ), ( 345, 314, 0 ) );
    spawncollision( "collision_clip_wall_128x128x10", "collider", ( 1829, -607.5, 498 ), ( 0, 270, 0 ) );
    level.cleandepositpoints = array( ( 1178.15, -2020.82, 294.125 ), ( 2647.03, -119.764, 216.125 ), ( 249.819, 944.336, 180.125 ), ( -378.629, -1073.84, 352.125 ) );
}

// Namespace mp_rome
// Params 0
// Checksum 0x99ec1590, Offset: 0xcf8
// Size: 0x4
function precache()
{
    
}

