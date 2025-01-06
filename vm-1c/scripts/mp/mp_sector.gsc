#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_sector_fx;
#using scripts/mp/mp_sector_sound;
#using scripts/shared/_oob;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_sector;

// Namespace mp_sector
// Params 0, eflags: 0x1 linked
// Checksum 0x6affe11, Offset: 0x1e8
// Size: 0x21c
function main() {
    precache();
    trigger = spawn("trigger_radius_out_of_bounds", (687.5, 2679, -356.5), 0, 300, 400);
    trigger thread oob::run_oob_trigger();
    mp_sector_fx::main();
    mp_sector_sound::main();
    level.var_c9aa825e = &function_c9aa825e;
    level.var_7bb6ebae = &function_7bb6ebae;
    level.remotemissile_kill_z = -680;
    load::main();
    setdvar("compassmaxrange", "2100");
    compass::setupminimap("compass_map_mp_sector");
    function_8bf0b925("under_bridge", "targetname", 1);
    spawncollision("collision_clip_wall_128x128x10", "collider", (597.185, -523.817, 584.206), (-5, 90, 0));
    level spawnkilltrigger();
    level.cleandepositpoints = array((-1.72432, 176.047, 172.125), (715.139, 1279.47, 158.417), (-825.34, 171.066, 106.517), (-108.124, -751.785, 154.839));
}

// Namespace mp_sector
// Params 3, eflags: 0x1 linked
// Checksum 0x26f5886e, Offset: 0x410
// Size: 0xe2
function function_8bf0b925(str_value, str_key, b_enable) {
    a_nodes = getnodearray(str_value, str_key);
    foreach (node in a_nodes) {
        if (b_enable) {
            linktraversal(node);
            continue;
        }
        unlinktraversal(node);
    }
}

// Namespace mp_sector
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x500
// Size: 0x4
function precache() {
    
}

// Namespace mp_sector
// Params 1, eflags: 0x1 linked
// Checksum 0x5b5ca6da, Offset: 0x510
// Size: 0xdc
function function_c9aa825e(&var_6480c733) {
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (32, 710, -67);
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (-960, 1020, -88);
}

// Namespace mp_sector
// Params 1, eflags: 0x1 linked
// Checksum 0x41b7faa0, Offset: 0x5f8
// Size: 0xda
function function_7bb6ebae(&var_ef2e1e06) {
    if (!isdefined(var_ef2e1e06)) {
        var_ef2e1e06 = [];
    } else if (!isarray(var_ef2e1e06)) {
        var_ef2e1e06 = array(var_ef2e1e06);
    }
    var_ef2e1e06[var_ef2e1e06.size] = (-1100, 860, -111);
    if (!isdefined(var_ef2e1e06)) {
        var_ef2e1e06 = [];
    } else if (!isarray(var_ef2e1e06)) {
        var_ef2e1e06 = array(var_ef2e1e06);
    }
    var_ef2e1e06[var_ef2e1e06.size] = (0, 520, -93);
}

// Namespace mp_sector
// Params 0, eflags: 0x1 linked
// Checksum 0xb213ab6, Offset: 0x6e0
// Size: 0xac
function spawnkilltrigger() {
    trigger = spawn("trigger_radius", (-480.116, 3217.5, 119.108), 0, -106, -56);
    trigger thread watchkilltrigger();
    trigger = spawn("trigger_radius", (-480.115, 3309.66, 119.108), 0, -106, -56);
    trigger thread watchkilltrigger();
}

// Namespace mp_sector
// Params 0, eflags: 0x1 linked
// Checksum 0x86747354, Offset: 0x798
// Size: 0x90
function watchkilltrigger() {
    level endon(#"game_ended");
    trigger = self;
    while (true) {
        trigger waittill(#"trigger", player);
        player dodamage(1000, trigger.origin + (0, 0, 0), trigger, trigger, "none", "MOD_SUICIDE", 0);
    }
}

