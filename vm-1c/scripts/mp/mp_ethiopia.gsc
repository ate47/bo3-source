#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_ethiopia_fx;
#using scripts/mp/mp_ethiopia_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_ethiopia;

// Namespace mp_ethiopia
// Params 0, eflags: 0x1 linked
// Checksum 0xcc4b4d07, Offset: 0x1f8
// Size: 0x40c
function main() {
    precache();
    mp_ethiopia_fx::main();
    mp_ethiopia_sound::main();
    level.var_7bb6ebae = &function_7bb6ebae;
    load::main();
    compass::setupminimap("compass_map_mp_ethiopia");
    setdvar("compassmaxrange", "2100");
    spawncollision("collision_clip_256x256x256", "collider", (-129.888, -1884.61, 661.629), (0, -7, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-129.888, -1875.59, 827.62), (0, -7, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-63, -1635, 611.5), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-63, -1635, 733.5), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-63, -1635, 857), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (-63, -1635, 979), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (132.5, -1635, 611.5), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (132.5, -1635, 733.5), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (132.5, -1635, 857), (0, 0, 0));
    spawncollision("collision_clip_256x256x256", "collider", (132.5, -1635, 979), (0, 0, 0));
    spawncollision("collision_nosight_wall_512x512x10", "collider", (1953.84, -762.342, 16), (0, 12, 0));
    spawncollision("collision_clip_wall_64x64x10", "collider", (-1040, -1338.5, 73.5), (4, 10, 0));
    setdvar("bot_maxmantleheight", -121);
    level.cleandepositpoints = array((301.869, 278.255, -218.677), (241.91, -1226.31, 37.6831), (1353.01, -116.183, -66.9346), (-294.319, -2288.04, 10.5979));
    level spawnkilltrigger();
}

// Namespace mp_ethiopia
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x610
// Size: 0x4
function precache() {
    
}

// Namespace mp_ethiopia
// Params 1, eflags: 0x1 linked
// Checksum 0x85ed3478, Offset: 0x620
// Size: 0x1ac
function function_7bb6ebae(&var_ef2e1e06) {
    if (!isdefined(var_ef2e1e06)) {
        var_ef2e1e06 = [];
    } else if (!isarray(var_ef2e1e06)) {
        var_ef2e1e06 = array(var_ef2e1e06);
    }
    var_ef2e1e06[var_ef2e1e06.size] = (350, 650, -222);
    if (!isdefined(var_ef2e1e06)) {
        var_ef2e1e06 = [];
    } else if (!isarray(var_ef2e1e06)) {
        var_ef2e1e06 = array(var_ef2e1e06);
    }
    var_ef2e1e06[var_ef2e1e06.size] = (-100, 420, -223);
    if (!isdefined(var_ef2e1e06)) {
        var_ef2e1e06 = [];
    } else if (!isarray(var_ef2e1e06)) {
        var_ef2e1e06 = array(var_ef2e1e06);
    }
    var_ef2e1e06[var_ef2e1e06.size] = (2900, -140, -23);
    if (!isdefined(var_ef2e1e06)) {
        var_ef2e1e06 = [];
    } else if (!isarray(var_ef2e1e06)) {
        var_ef2e1e06 = array(var_ef2e1e06);
    }
    var_ef2e1e06[var_ef2e1e06.size] = (-690, -850, 26);
}

// Namespace mp_ethiopia
// Params 0, eflags: 0x1 linked
// Checksum 0x7f85f6b1, Offset: 0x7d8
// Size: 0xfc
function spawnkilltrigger() {
    trigger = spawn("trigger_radius", (-993.5, -1327.5, 0.5), 0, 50, 300);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (1824, -250, -236), 0, 32, 496);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (1742, -346, -236), 0, -128, 496);
    trigger thread watchkilltrigger();
}

// Namespace mp_ethiopia
// Params 0, eflags: 0x1 linked
// Checksum 0x9919dd65, Offset: 0x8e0
// Size: 0x90
function watchkilltrigger() {
    level endon(#"game_ended");
    trigger = self;
    while (true) {
        trigger waittill(#"trigger", player);
        player dodamage(1000, trigger.origin + (0, 0, 0), trigger, trigger, "none", "MOD_SUICIDE", 0);
    }
}

