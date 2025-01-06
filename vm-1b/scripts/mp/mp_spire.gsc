#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/mp_spire_amb;
#using scripts/mp/mp_spire_fx;
#using scripts/shared/clientfield_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;

#namespace mp_spire;

// Namespace mp_spire
// Params 0, eflags: 0x0
// Checksum 0xbdd8277f, Offset: 0x300
// Size: 0xc1
function main() {
    clientfield::register("world", "mpSpireExteriorBillboard", 1, 2, "int");
    mp_spire_fx::main();
    level.var_c9aa825e = &function_c9aa825e;
    load::main();
    compass::setupminimap("compass_map_mp_spire");
    mp_spire_amb::main();
    setdvar("compassmaxrange", "2100");
    InvalidOpCode(0xc8, "strings", "war_callsign_a", %MPUI_CALLSIGN_MAPNAME_A);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace mp_spire
// Params 0, eflags: 0x0
// Checksum 0x149b843a, Offset: 0x4e0
// Size: 0x51
function function_6abc7e64() {
    for (var_70fb23df = randomint(4); true; var_70fb23df = 0) {
        level clientfield::set("mpSpireExteriorBillboard", var_70fb23df);
        wait 6;
        var_70fb23df++;
        if (var_70fb23df >= 4) {
        }
    }
}

// Namespace mp_spire
// Params 1, eflags: 0x0
// Checksum 0x519d64b9, Offset: 0x540
// Size: 0x175
function function_c9aa825e(&var_6480c733) {
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (2480, 1269, 67);
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (2609, 1440, 67);
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (3089, 1437, 69);
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (3223, 1224, 69);
    if (!isdefined(var_6480c733)) {
        var_6480c733 = [];
    } else if (!isarray(var_6480c733)) {
        var_6480c733 = array(var_6480c733);
    }
    var_6480c733[var_6480c733.size] = (2434, 1093, 67);
}

