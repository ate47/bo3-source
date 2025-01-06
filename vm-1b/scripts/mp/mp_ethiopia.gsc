#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_ethiopia_fx;
#using scripts/mp/mp_ethiopia_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_ethiopia;

// Namespace mp_ethiopia
// Params 0, eflags: 0x0
// Checksum 0x8d015921, Offset: 0x160
// Size: 0x92
function main() {
    precache();
    mp_ethiopia_fx::main();
    mp_ethiopia_sound::main();
    level.var_7bb6ebae = &function_7bb6ebae;
    load::main();
    compass::setupminimap("compass_map_mp_ethiopia");
    setdvar("compassmaxrange", "2100");
}

// Namespace mp_ethiopia
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x200
// Size: 0x2
function precache() {
    
}

// Namespace mp_ethiopia
// Params 1, eflags: 0x0
// Checksum 0xcb1913b2, Offset: 0x210
// Size: 0x12d
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

