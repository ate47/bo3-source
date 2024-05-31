#using scripts/zm/_zm_perks;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_f95f1bc4;

// Namespace namespace_f95f1bc4
// Params 0, eflags: 0x2
// namespace_f95f1bc4<file_0>::function_2dc19561
// Checksum 0xcddc133c, Offset: 0x1a0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_perk_doubletap2", &__init__, undefined, undefined);
}

// Namespace namespace_f95f1bc4
// Params 0, eflags: 0x1 linked
// namespace_f95f1bc4<file_0>::function_8c87d8eb
// Checksum 0x431ac83f, Offset: 0x1e0
// Size: 0x14
function __init__() {
    function_67e7f8cd();
}

// Namespace namespace_f95f1bc4
// Params 0, eflags: 0x1 linked
// namespace_f95f1bc4<file_0>::function_67e7f8cd
// Checksum 0xc6ed04e1, Offset: 0x200
// Size: 0x84
function function_67e7f8cd() {
    zm_perks::register_perk_clientfields("specialty_doubletap2", &function_4cff622d, &function_cc3fec48);
    zm_perks::register_perk_effects("specialty_doubletap2", "doubletap2_light");
    zm_perks::register_perk_init_thread("specialty_doubletap2", &function_a6e30992);
}

// Namespace namespace_f95f1bc4
// Params 0, eflags: 0x1 linked
// namespace_f95f1bc4<file_0>::function_a6e30992
// Checksum 0x6aff0331, Offset: 0x290
// Size: 0x36
function function_a6e30992() {
    if (isdefined(level.enable_magic) && level.enable_magic) {
        level._effect["doubletap2_light"] = "zombie/fx_perk_doubletap2_zmb";
    }
}

// Namespace namespace_f95f1bc4
// Params 0, eflags: 0x1 linked
// namespace_f95f1bc4<file_0>::function_4cff622d
// Checksum 0x5f8fc1e9, Offset: 0x2d0
// Size: 0x3c
function function_4cff622d() {
    clientfield::register("clientuimodel", "hudItems.perks.doubletap2", 1, 2, "int", undefined, 0, 1);
}

// Namespace namespace_f95f1bc4
// Params 0, eflags: 0x1 linked
// namespace_f95f1bc4<file_0>::function_cc3fec48
// Checksum 0x99ec1590, Offset: 0x318
// Size: 0x4
function function_cc3fec48() {
    
}

