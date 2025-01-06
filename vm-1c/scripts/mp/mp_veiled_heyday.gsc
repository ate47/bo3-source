#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/mp_veiled_heyday_fx;
#using scripts/mp/mp_veiled_heyday_sound;
#using scripts/shared/_oob;
#using scripts/shared/compass;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace mp_veiled_heyday;

// Namespace mp_veiled_heyday
// Params 0, eflags: 0x0
// Checksum 0x275e14d8, Offset: 0x290
// Size: 0x2f4
function main() {
    precache();
    mp_veiled_heyday_fx::main();
    mp_veiled_heyday_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_veiled_heyday");
    setdvar("compassmaxrange", "2100");
    spawncollision("collision_clip_wall_32x32x10", "collider", (-2091.09, 803.526, 140.663), (27, 82, -2));
    spawncollision("collision_clip_wall_32x32x10", "collider", (-1905.67, 876.398, 140.663), (27, 97, 2));
    spawncollision("collision_clip_wall_128x128x10", "collider", (881, -352, 116), (0, 0, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (885, -352, 116), (0, 0, 0));
    level.cleandepositpoints = array((-63.6408, -499.434, -19.875), (-1363.59, 509.905, -20.1416), (1362.85, -166.119, 1.5134), (-237.83, 1105.17, 10));
    trigger = spawn("trigger_radius", (783.5, 1879.5, 28.5), 0, -106, 50);
    trigger thread oob::run_oob_trigger();
    trigger = spawn("trigger_radius", (2483.5, 329, -66.5), 0, 300, 100);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (2492, -144.5, -66.5), 0, 300, 100);
    trigger thread watchkilltrigger();
    level thread function_706ce0e3();
}

// Namespace mp_veiled_heyday
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x590
// Size: 0x4
function precache() {
    
}

// Namespace mp_veiled_heyday
// Params 0, eflags: 0x0
// Checksum 0xc4090aca, Offset: 0x5a0
// Size: 0xbc
function function_706ce0e3() {
    wait 0.5;
    level thread scene::play("vld_hd_anim_crane_01", "targetname");
    wait 2.33;
    level thread scene::play("vld_hd_anim_crane_02", "targetname");
    wait 3;
    level thread scene::play("vld_hd_anim_crane_03", "targetname");
    wait 5.75;
    level thread scene::play("vld_hd_anim_crane_04", "targetname");
}

// Namespace mp_veiled_heyday
// Params 0, eflags: 0x0
// Checksum 0xc9f399ee, Offset: 0x668
// Size: 0x90
function watchkilltrigger() {
    level endon(#"game_ended");
    trigger = self;
    while (true) {
        trigger waittill(#"trigger", player);
        player dodamage(1000, trigger.origin + (0, 0, 0), trigger, trigger, "none", "MOD_SUICIDE", 0);
    }
}

