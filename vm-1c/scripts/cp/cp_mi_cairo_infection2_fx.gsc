#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace infection2_fx;

// Namespace infection2_fx
// Params 0, eflags: 0x2
// Checksum 0xc017b43d, Offset: 0x1a0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("infection2_fx", &__init__, undefined, undefined);
}

// Namespace infection2_fx
// Params 0, eflags: 0x0
// Checksum 0xa4ad8bc0, Offset: 0x1e0
// Size: 0x24
function __init__() {
    init_fx();
    init_clientfields();
}

// Namespace infection2_fx
// Params 0, eflags: 0x0
// Checksum 0xc039ebfd, Offset: 0x210
// Size: 0x56
function init_fx() {
    level._effect["snow_body_impact"] = "weather/fx_snow_impact_body_reverse_infection";
    level._effect["reverse_mortar"] = "explosions/fx_exp_mortar_snow_reverse";
    level._effect["bullet_impact"] = "impacts/fx_bul_impact_blood_body_fatal_reverse";
}

// Namespace infection2_fx
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x270
// Size: 0x4
function init_clientfields() {
    
}

