#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/system_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_perks;

#namespace zm_perk_staminup;

// Namespace zm_perk_staminup
// Params 0, eflags: 0x2
// Checksum 0x35d06f65, Offset: 0x198
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("zm_perk_staminup", &__init__, undefined, undefined);
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x33a5cb64, Offset: 0x1d0
// Size: 0x12
function __init__() {
    enable_staminup_perk_for_level();
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0x1aadda63, Offset: 0x1f0
// Size: 0x82
function enable_staminup_perk_for_level() {
    zm_perks::register_perk_clientfields("specialty_staminup", &staminup_client_field_func, &staminup_callback_func);
    zm_perks::register_perk_effects("specialty_staminup", "marathon_light");
    zm_perks::register_perk_init_thread("specialty_staminup", &init_staminup);
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0xf62915e1, Offset: 0x280
// Size: 0x33
function init_staminup() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["marathon_light"] = "zombie/fx_perk_stamin_up_zmb";
    }
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0xc44c110d, Offset: 0x2c0
// Size: 0x32
function staminup_client_field_func() {
    clientfield::register("clientuimodel", "hudItems.perks.marathon", 1, 2, "int", undefined, 0, 1);
}

// Namespace zm_perk_staminup
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x300
// Size: 0x2
function staminup_callback_func() {
    
}

