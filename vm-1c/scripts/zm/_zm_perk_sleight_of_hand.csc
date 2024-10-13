#using scripts/zm/_zm_perks;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_perk_sleight_of_hand;

// Namespace zm_perk_sleight_of_hand
// Params 0, eflags: 0x2
// Checksum 0xc56d1f8e, Offset: 0x1b0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_perk_sleight_of_hand", &__init__, undefined, undefined);
}

// Namespace zm_perk_sleight_of_hand
// Params 0, eflags: 0x1 linked
// Checksum 0xe2f65a4c, Offset: 0x1f0
// Size: 0x14
function __init__() {
    function_ec609c41();
}

// Namespace zm_perk_sleight_of_hand
// Params 0, eflags: 0x1 linked
// Checksum 0xf427234c, Offset: 0x210
// Size: 0x84
function function_ec609c41() {
    zm_perks::register_perk_clientfields("specialty_fastreload", &function_1e280ddd, &function_945cdfb8);
    zm_perks::register_perk_effects("specialty_fastreload", "sleight_light");
    zm_perks::register_perk_init_thread("specialty_fastreload", &function_45dc0310);
}

// Namespace zm_perk_sleight_of_hand
// Params 0, eflags: 0x1 linked
// Checksum 0xb352172, Offset: 0x2a0
// Size: 0x36
function function_45dc0310() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["sleight_light"] = "zombie/fx_perk_sleight_of_hand_zmb";
    }
}

// Namespace zm_perk_sleight_of_hand
// Params 0, eflags: 0x1 linked
// Checksum 0x2562d5b1, Offset: 0x2e0
// Size: 0x3c
function function_1e280ddd() {
    clientfield::register("clientuimodel", "hudItems.perks.sleight_of_hand", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_sleight_of_hand
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x328
// Size: 0x4
function function_945cdfb8() {
    
}

