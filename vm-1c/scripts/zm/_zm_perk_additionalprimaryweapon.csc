#using scripts/zm/_zm_perks;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_perk_additionalprimaryweapon;

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x2
// Checksum 0xaef8fcba, Offset: 0x1e0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_perk_additionalprimaryweapon", &__init__, undefined, undefined);
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x1 linked
// Checksum 0xc88eeab7, Offset: 0x220
// Size: 0x14
function __init__() {
    enable_additional_primary_weapon_perk_for_level();
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x1 linked
// Checksum 0xcd616e89, Offset: 0x240
// Size: 0x84
function enable_additional_primary_weapon_perk_for_level() {
    zm_perks::register_perk_clientfields("specialty_additionalprimaryweapon", &additional_primary_weapon_client_field_func, &additional_primary_weapon_code_callback_func);
    zm_perks::register_perk_effects("specialty_additionalprimaryweapon", "additionalprimaryweapon_light");
    zm_perks::register_perk_init_thread("specialty_additionalprimaryweapon", &init_additional_primary_weapon);
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x1 linked
// Checksum 0x4c31119d, Offset: 0x2d0
// Size: 0x36
function init_additional_primary_weapon() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["additionalprimaryweapon_light"] = "zombie/fx_perk_mule_kick_zmb";
    }
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x1 linked
// Checksum 0x2b630b33, Offset: 0x310
// Size: 0x3c
function additional_primary_weapon_client_field_func() {
    clientfield::register("clientuimodel", "hudItems.perks.additional_primary_weapon", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x358
// Size: 0x4
function additional_primary_weapon_code_callback_func() {
    
}

