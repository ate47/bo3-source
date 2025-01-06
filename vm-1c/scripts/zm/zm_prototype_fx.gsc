#using scripts/shared/flagsys_shared;

#namespace zm_prototype_fx;

// Namespace zm_prototype_fx
// Params 0, eflags: 0x0
// Checksum 0x98208ae6, Offset: 0x1f8
// Size: 0x2c
function main() {
    function_2cef3bdd();
    level thread function_f205a5f1();
}

// Namespace zm_prototype_fx
// Params 0, eflags: 0x0
// Checksum 0xd148b8b5, Offset: 0x230
// Size: 0xaa
function function_2cef3bdd() {
    level._effect["large_ceiling_dust"] = "dlc5/zmhd/fx_dust_ceiling_impact_lg_mdbrown";
    level._effect["poltergeist"] = "dlc5/zmhd/fx_zombie_couch_effect";
    level._effect["nuke_dust"] = "maps/zombie/fx_zombie_body_nuke_dust";
    level._effect["lght_marker"] = "dlc5/tomb/fx_tomb_marker";
    level._effect["lght_marker_flare"] = "dlc5/tomb/fx_tomb_marker_fl";
    level._effect["zombie_grain"] = "misc/fx_zombie_grain_cloud";
}

// Namespace zm_prototype_fx
// Params 0, eflags: 0x0
// Checksum 0x3884262c, Offset: 0x2e8
// Size: 0x3e
function function_f205a5f1() {
    level flagsys::wait_till("load_main_complete");
    level._effect["additionalprimaryweapon_light"] = "dlc5/zmhd/fx_perk_mule_kick";
}

