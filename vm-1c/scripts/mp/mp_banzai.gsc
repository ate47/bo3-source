#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_banzai_fx;
#using scripts/mp/mp_banzai_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_banzai;

// Namespace mp_banzai
// Params 0, eflags: 0x0
// Checksum 0x56b27992, Offset: 0x158
// Size: 0x94
function main() {
    precache();
    level.var_c9aa825e = &function_c9aa825e;
    mp_banzai_fx::main();
    mp_banzai_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_banzai");
    setdvar("compassmaxrange", "2100");
}

// Namespace mp_banzai
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1f8
// Size: 0x4
function precache() {
    
}

// Namespace mp_banzai
// Params 1, eflags: 0x0
// Checksum 0x55a28f2d, Offset: 0x208
// Size: 0xdc
function function_c9aa825e(&var_6480c733) {
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (829, -1115, -517);
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (687, -1457, -459);
}

