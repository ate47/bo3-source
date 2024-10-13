#using scripts/zm/_zm_perks;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_perk_juggernaut;

// Namespace zm_perk_juggernaut
// Params 0, eflags: 0x2
// Checksum 0x8e42b9ef, Offset: 0x198
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_perk_juggernaut", &__init__, undefined, undefined);
}

// Namespace zm_perk_juggernaut
// Params 0, eflags: 0x1 linked
// Checksum 0xc167c737, Offset: 0x1d8
// Size: 0x84
function __init__() {
    zm_perks::register_perk_clientfields("specialty_armorvest", &function_ddf4f425, &function_d46101a0);
    zm_perks::register_perk_effects("specialty_armorvest", "jugger_light");
    zm_perks::register_perk_init_thread("specialty_armorvest", &init_juggernaut);
}

// Namespace zm_perk_juggernaut
// Params 0, eflags: 0x1 linked
// Checksum 0xe64da626, Offset: 0x268
// Size: 0x36
function init_juggernaut() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["jugger_light"] = "zombie/fx_perk_juggernaut_zmb";
    }
}

// Namespace zm_perk_juggernaut
// Params 0, eflags: 0x1 linked
// Checksum 0x3decc15d, Offset: 0x2a8
// Size: 0x3c
function function_ddf4f425() {
    clientfield::register("clientuimodel", "hudItems.perks.juggernaut", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_juggernaut
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x2f0
// Size: 0x4
function function_d46101a0() {
    
}

