#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_immolation_liquidation;

// Namespace zm_bgb_immolation_liquidation
// Params 0, eflags: 0x2
// namespace_cbb0522a<file_0>::function_2dc19561
// Checksum 0x691467cc, Offset: 0x188
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_immolation_liquidation", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_immolation_liquidation
// Params 0, eflags: 0x1 linked
// namespace_cbb0522a<file_0>::function_8c87d8eb
// Checksum 0x4c05325f, Offset: 0x1c8
// Size: 0x64
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_immolation_liquidation", "activated", 3, undefined, undefined, &function_3d1f600e, &activation);
}

// Namespace zm_bgb_immolation_liquidation
// Params 0, eflags: 0x1 linked
// namespace_cbb0522a<file_0>::function_7afbf7cd
// Checksum 0x33c4332e, Offset: 0x238
// Size: 0x24
function activation() {
    self thread bgb::function_dea74fb0("fire_sale");
}

// Namespace zm_bgb_immolation_liquidation
// Params 0, eflags: 0x1 linked
// namespace_cbb0522a<file_0>::function_3d1f600e
// Checksum 0xd54d9f7b, Offset: 0x268
// Size: 0x3e
function function_3d1f600e() {
    if (isdefined(level.disable_firesale_drop) && (level.zombie_vars["zombie_powerup_fire_sale_on"] === 1 || level.disable_firesale_drop)) {
        return false;
    }
    return true;
}

