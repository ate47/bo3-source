#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_globallogic;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/gametypes/_spawnlogic;
#using scripts/mp/mp_apartments_amb;
#using scripts/mp/mp_apartments_fx;
#using scripts/shared/compass;

#namespace mp_apartments;

// Namespace mp_apartments
// Params 0, eflags: 0x0
// Checksum 0xede670cd, Offset: 0x1d8
// Size: 0xb2
function main() {
    mp_apartments_fx::main();
    level.var_7bb6ebae = &function_7bb6ebae;
    load::main();
    compass::setupminimap("compass_map_mp_apartments");
    mp_apartments_amb::main();
    setdvar("compassmaxrange", "2100");
    setdvar("phys_buoyancy", 1);
    setdvar("phys_ragdoll_buoyancy", 1);
}

// Namespace mp_apartments
// Params 1, eflags: 0x0
// Checksum 0x92ebf020, Offset: 0x298
// Size: 0x57
function function_7bb6ebae(&var_ef2e1e06) {
    if (!isdefined(var_ef2e1e06)) {
        var_ef2e1e06 = [];
    } else if (!isarray(var_ef2e1e06)) {
        var_ef2e1e06 = array(var_ef2e1e06);
    }
    var_ef2e1e06[var_ef2e1e06.size] = (-560, -2020, 1355);
}

