#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_biodome_fx;
#using scripts/mp/mp_biodome_sound;
#using scripts/shared/_oob;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_biodome;

// Namespace mp_biodome
// Params 0, eflags: 0x1 linked
// Checksum 0xba58c87e, Offset: 0x390
// Size: 0x6fc
function main() {
    precache();
    setdvar("phys_buoyancy", 1);
    mp_biodome_fx::main();
    mp_biodome_sound::main();
    level.remotemissile_kill_z = -130 + 50;
    load::main();
    compass::setupminimap("compass_map_mp_biodome");
    setdvar("compassmaxrange", "2100");
    spawncollision("collision_clip_512x512x512", "collider", (744, 1696, 920), (0, 0, 0));
    spawncollision("collision_clip_512x512x512", "collider", (744, 2208, 920), (0, 0, 0));
    spawncollision("collision_clip_512x512x512", "collider", (1256, 1696, 920), (0, 0, 0));
    spawncollision("collision_clip_512x512x512", "collider", (1256, 2208, 920), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (3454.82, 1094.87, 499.607), (0, 270, -90));
    spawncollision("collision_clip_256x256x256", "collider", (3454.82, 706.47, 499.607), (0, 270, -90));
    spawncollision("collision_clip_wall_64x64x10", "collider", (1640, -178.5, 150.5), (0, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (1580.5, -180.5, -115), (0, 270, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (1640, -180.5, -115), (0, 270, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (588, -11, 263), (1, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (588, 358.5, 263), (1, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-249, 817, 175.5), (0, 0, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-219.5, 844, 175.5), (0, 270, 0));
    spawncollision("collision_clip_cylinder_32x256", "collider", (1549, -350, -62), (0, 0, 0));
    spawncollision("collision_clip_cylinder_32x256", "collider", (1549, -350, 435.5), (0, 0, 0));
    spawncollision("collision_clip_cylinder_32x256", "collider", (1549, -350, 649.5), (0, 0, 0));
    if (util::isprophuntgametype()) {
        spawncollision("collision_clip_wall_64x64x10", "collider", (-1745, 1550, -8), (0, 0, 0));
    }
    game["strings"]["war_callsign_a"] = %MPUI_CALLSIGN_MAPNAME_A;
    game["strings"]["war_callsign_b"] = %MPUI_CALLSIGN_MAPNAME_B;
    game["strings"]["war_callsign_c"] = %MPUI_CALLSIGN_MAPNAME_C;
    game["strings"]["war_callsign_d"] = %MPUI_CALLSIGN_MAPNAME_D;
    game["strings"]["war_callsign_e"] = %MPUI_CALLSIGN_MAPNAME_E;
    game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_MAPNAME_A";
    game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_MAPNAME_B";
    game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_MAPNAME_C";
    game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_MAPNAME_D";
    game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_MAPNAME_E";
    level spawnkilltrigger();
    trigger = spawn("trigger_radius", (3516, 620, 111), 0, 256, 50);
    trigger thread oob::run_oob_trigger();
    trigger = spawn("trigger_radius", (2182, 2176.5, -32.5), 0, 100, 256);
    trigger thread oob::run_oob_trigger();
    level.cleandepositpoints = array((-52.4927, 1252.1, 104.125), (330.408, 2402.64, 232.204), (-139.434, -303.555, 138.836), (-362.325, 325.108, 104.125));
}

// Namespace mp_biodome
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0xa98
// Size: 0x4
function precache() {
    
}

// Namespace mp_biodome
// Params 0, eflags: 0x1 linked
// Checksum 0x9e942f27, Offset: 0xaa8
// Size: 0x13c
function spawnkilltrigger() {
    trigger = spawn("trigger_radius", (4147.22, 1095.25, -33.0108), 0, 500, 500);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (4147.22, 590.28, -33.0108), 0, 500, 500);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (-202, 797, 135.5), 0, 50, -56);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (-162, 2442, -47), 0, 25, 60);
    trigger thread watchkilltrigger();
}

// Namespace mp_biodome
// Params 0, eflags: 0x1 linked
// Checksum 0x8c913160, Offset: 0xbf0
// Size: 0x90
function watchkilltrigger() {
    level endon(#"game_ended");
    trigger = self;
    while (true) {
        trigger waittill(#"trigger", player);
        player dodamage(1000, trigger.origin + (0, 0, 0), trigger, trigger, "none", "MOD_SUICIDE", 0);
    }
}

