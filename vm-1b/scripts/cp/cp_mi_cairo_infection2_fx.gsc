#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;

#namespace infection2_fx;

// Namespace infection2_fx
// Params 0, eflags: 0x2
// Checksum 0x1e265782, Offset: 0x1a0
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("infection2_fx", &__init__, undefined, undefined);
}

// Namespace infection2_fx
// Params 0, eflags: 0x0
// Checksum 0x539d4a70, Offset: 0x1d8
// Size: 0x22
function __init__() {
    init_fx();
    init_clientfields();
}

// Namespace infection2_fx
// Params 0, eflags: 0x0
// Checksum 0xafa2864d, Offset: 0x208
// Size: 0x4b
function init_fx() {
    level._effect["snow_body_impact"] = "weather/fx_snow_impact_body_reverse_infection";
    level._effect["reverse_mortar"] = "explosions/fx_exp_mortar_snow_reverse";
    level._effect["bullet_impact"] = "impacts/fx_bul_impact_blood_body_fatal_reverse";
}

// Namespace infection2_fx
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x260
// Size: 0x2
function init_clientfields() {
    
}

