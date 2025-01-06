#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_sector_fx;
#using scripts/mp/mp_sector_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_sector;

// Namespace mp_sector
// Params 0, eflags: 0x0
// Checksum 0x4449e201, Offset: 0x170
// Size: 0xca
function main() {
    precache();
    mp_sector_fx::main();
    mp_sector_sound::main();
    level.var_c9aa825e = &function_c9aa825e;
    level.var_7bb6ebae = &function_7bb6ebae;
    load::main();
    setdvar("compassmaxrange", "2100");
    compass::setupminimap("compass_map_mp_sector");
    function_8bf0b925("under_bridge", "targetname", 1);
}

// Namespace mp_sector
// Params 3, eflags: 0x0
// Checksum 0x6113d552, Offset: 0x248
// Size: 0xab
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
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x300
// Size: 0x2
function precache() {
    
}

// Namespace mp_sector
// Params 1, eflags: 0x0
// Checksum 0xe9c13bd5, Offset: 0x310
// Size: 0x9d
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
// Params 1, eflags: 0x0
// Checksum 0x3deb4718, Offset: 0x3b8
// Size: 0x9a
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

