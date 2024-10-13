#namespace zm_prototype_fx;

// Namespace zm_prototype_fx
// Params 0, eflags: 0x1 linked
// Checksum 0x6922e1cb, Offset: 0x398
// Size: 0x54
function main() {
    var_c65a3ce5 = getdvarint("disable_fx");
    if (!isdefined(var_c65a3ce5) || var_c65a3ce5 <= 0) {
        function_f45953c();
    }
}

// Namespace zm_prototype_fx
// Params 0, eflags: 0x1 linked
// Checksum 0x2de1dd6, Offset: 0x3f8
// Size: 0x17e
function function_f45953c() {
    level._effect["eye_glow"] = "zombie/fx_glow_eye_orange";
    level._effect["zombie_grain"] = "misc/fx_zombie_grain_cloud";
    level._effect["headshot"] = "impacts/fx_flesh_hit";
    level._effect["headshot_nochunks"] = "misc/fx_zombie_bloodsplat";
    level._effect["bloodspurt"] = "misc/fx_zombie_bloodspurt";
    level._effect["animscript_gib_fx"] = "weapon/bullet/fx_flesh_gib_fatal_01";
    level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
    level.var_c655ff3a["barrel"]["explode"] = "explosions/fx_exp_dest_barrel_sm";
    level.var_c655ff3a["barrel"]["burn_start"] = "dlc5/prototype/fx_barrel_ignite";
    level._effect["perk_machine_light_yellow"] = "dlc5/zmhd/fx_wonder_fizz_light_yellow";
    level._effect["perk_machine_light_red"] = "dlc5/zmhd/fx_wonder_fizz_light_red";
    level._effect["perk_machine_light_green"] = "dlc5/zmhd/fx_wonder_fizz_light_green";
    level._effect["perk_machine_location"] = "dlc5/prototype/fx_wonder_fizz_lightning_all_interior";
}

// Namespace zm_prototype_fx
// Params 0, eflags: 0x0
// Checksum 0xd52b60d1, Offset: 0x580
// Size: 0x56
function function_2cef3bdd() {
    level._effect["large_ceiling_dust"] = "dlc5/zmhd/fx_dust_ceiling_impact_lg_mdbrown";
    level._effect["poltergeist"] = "dlc5/zmhd/fx_zombie_couch_effect";
    level._effect["nuke_dust"] = "maps/zombie/fx_zombie_body_nuke_dust";
}

