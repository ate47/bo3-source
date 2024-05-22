#using scripts/zm/_zm_perks;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_b3116a5e;

// Namespace namespace_b3116a5e
// Params 0, eflags: 0x2
// Checksum 0xb74cebb5, Offset: 0x1b0
// Size: 0x34
function function_2dc19561() {
    system::register("zm_perk_sleight_of_hand", &__init__, undefined, undefined);
}

// Namespace namespace_b3116a5e
// Params 0, eflags: 0x0
// Checksum 0x8d25b68e, Offset: 0x1f0
// Size: 0x14
function __init__() {
    function_ec609c41();
}

// Namespace namespace_b3116a5e
// Params 0, eflags: 0x0
// Checksum 0x7b04285c, Offset: 0x210
// Size: 0x84
function function_ec609c41() {
    zm_perks::register_perk_clientfields("specialty_fastreload", &function_1e280ddd, &function_945cdfb8);
    zm_perks::register_perk_effects("specialty_fastreload", "sleight_light");
    zm_perks::register_perk_init_thread("specialty_fastreload", &function_45dc0310);
}

// Namespace namespace_b3116a5e
// Params 0, eflags: 0x0
// Checksum 0x5dba2cea, Offset: 0x2a0
// Size: 0x36
function function_45dc0310() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["sleight_light"] = "zombie/fx_perk_sleight_of_hand_zmb";
    }
}

// Namespace namespace_b3116a5e
// Params 0, eflags: 0x0
// Checksum 0xd569581c, Offset: 0x2e0
// Size: 0x3c
function function_1e280ddd() {
    clientfield::register("clientuimodel", "hudItems.perks.sleight_of_hand", 1, 2, "int", undefined, 0, 1);
}

// Namespace namespace_b3116a5e
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x328
// Size: 0x4
function function_945cdfb8() {
    
}

