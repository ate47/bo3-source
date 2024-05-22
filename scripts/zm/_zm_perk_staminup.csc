#using scripts/zm/_zm_perks;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_perk_staminup;

// Namespace zm_perk_staminup
// Params 0, eflags: 0x2
// Checksum 0xd5c601cd, Offset: 0x198
// Size: 0x34
function function_2dc19561() {
    system::register("zm_perk_staminup", &__init__, undefined, undefined);
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x7367784b, Offset: 0x1d8
// Size: 0x14
function __init__() {
    enable_staminup_perk_for_level();
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0xaafa0897, Offset: 0x1f8
// Size: 0x84
function enable_staminup_perk_for_level() {
    zm_perks::register_perk_clientfields("specialty_staminup", &staminup_client_field_func, &staminup_callback_func);
    zm_perks::register_perk_effects("specialty_staminup", "marathon_light");
    zm_perks::register_perk_init_thread("specialty_staminup", &init_staminup);
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x36f5d229, Offset: 0x288
// Size: 0x36
function init_staminup() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["marathon_light"] = "zombie/fx_perk_stamin_up_zmb";
    }
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x3632ae71, Offset: 0x2c8
// Size: 0x3c
function staminup_client_field_func() {
    clientfield::register("clientuimodel", "hudItems.perks.marathon", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x310
// Size: 0x4
function staminup_callback_func() {
    
}
