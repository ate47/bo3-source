#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_perks;

#namespace zm_perk_additionalprimaryweapon;

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x2
// Checksum 0x3bc1b6f2, Offset: 0x1e0
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("zm_perk_additionalprimaryweapon", &__init__, undefined, undefined);
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x22ad8034, Offset: 0x218
// Size: 0x12
function __init__() {
    enable_additional_primary_weapon_perk_for_level();
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x9727b1b7, Offset: 0x238
// Size: 0x82
function enable_additional_primary_weapon_perk_for_level() {
    zm_perks::register_perk_clientfields("specialty_additionalprimaryweapon", &additional_primary_weapon_client_field_func, &additional_primary_weapon_code_callback_func);
    zm_perks::register_perk_effects("specialty_additionalprimaryweapon", "additionalprimaryweapon_light");
    zm_perks::register_perk_init_thread("specialty_additionalprimaryweapon", &init_additional_primary_weapon);
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0x46e9b12e, Offset: 0x2c8
// Size: 0x33
function init_additional_primary_weapon() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["additionalprimaryweapon_light"] = "zombie/fx_perk_mule_kick_zmb";
    }
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0xc1639fbd, Offset: 0x308
// Size: 0x32
function additional_primary_weapon_client_field_func() {
    clientfield::register("clientuimodel", "hudItems.perks.additional_primary_weapon", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_additionalprimaryweapon
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x348
// Size: 0x2
function additional_primary_weapon_code_callback_func() {
    
}

