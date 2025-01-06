#using scripts/codescripts/struct;
#using scripts/mp/_load;
#using scripts/mp/_util;
#using scripts/mp/mp_kung_fu_fx;
#using scripts/mp/mp_kung_fu_sound;
#using scripts/shared/compass;
#using scripts/shared/util_shared;

#namespace mp_kung_fu;

// Namespace mp_kung_fu
// Params 0, eflags: 0x0
// Checksum 0x79adc3a3, Offset: 0x170
// Size: 0xa4
function main() {
    precache();
    mp_kung_fu_fx::main();
    mp_kung_fu_sound::main();
    load::main();
    compass::setupminimap("compass_map_mp_kung_fu");
    setdvar("compassmaxrange", "2100");
    function_8bf0b925("under_bridge", "targetname", 1);
}

// Namespace mp_kung_fu
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x220
// Size: 0x4
function precache() {
    
}

// Namespace mp_kung_fu
// Params 3, eflags: 0x0
// Checksum 0x4168d3bc, Offset: 0x230
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

