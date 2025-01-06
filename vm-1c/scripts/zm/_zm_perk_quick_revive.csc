#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_perks;

#namespace zm_perk_quick_revive;

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x2
// Checksum 0x7e4b87c2, Offset: 0x1a8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_perk_quick_revive", &__init__, undefined, undefined);
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x0
// Checksum 0xf2ee13cc, Offset: 0x1e8
// Size: 0x14
function __init__() {
    enable_quick_revive_perk_for_level();
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x0
// Checksum 0xb2243848, Offset: 0x208
// Size: 0x84
function enable_quick_revive_perk_for_level() {
    zm_perks::register_perk_clientfields("specialty_quickrevive", &quick_revive_client_field_func, &quick_revive_callback_func);
    zm_perks::register_perk_effects("specialty_quickrevive", "revive_light");
    zm_perks::register_perk_init_thread("specialty_quickrevive", &init_quick_revive);
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x0
// Checksum 0x969d0a4a, Offset: 0x298
// Size: 0x36
function init_quick_revive() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["revive_light"] = "zombie/fx_perk_quick_revive_zmb";
    }
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x0
// Checksum 0x791372f4, Offset: 0x2d8
// Size: 0x3c
function quick_revive_client_field_func() {
    clientfield::register("clientuimodel", "hudItems.perks.quick_revive", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_quick_revive
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x320
// Size: 0x4
function quick_revive_callback_func() {
    
}

