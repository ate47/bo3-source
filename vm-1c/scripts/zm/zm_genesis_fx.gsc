#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_genesis_fx;

// Namespace zm_genesis_fx
// Params 0, eflags: 0x1 linked
// Checksum 0xc0d1f88, Offset: 0x4f8
// Size: 0x24
function main() {
    function_f45953c();
    function_e6258024();
}

// Namespace zm_genesis_fx
// Params 0, eflags: 0x1 linked
// Checksum 0xd28a30e, Offset: 0x528
// Size: 0x16e
function function_f45953c() {
    level._effect["portal_3p"] = "zombie/fx_quest_portal_trail_zod_zmb";
    level._effect["beast_return_aoe_kill"] = "zombie/fx_bmode_attack_grapple_zod_zmb";
    level._effect["fx_margwa_explo_head_aoe_zod_zmb"] = "zombie/fx_margwa_explo_head_aoe_zod_zmb";
    level._effect["raps_meteor_fire"] = "zombie/fx_meatball_trail_sky_zod_zmb";
    level._effect["headshot"] = "impacts/fx_flesh_hit";
    level._effect["headshot_nochunks"] = "misc/fx_zombie_bloodsplat";
    level._effect["bloodspurt"] = "misc/fx_zombie_bloodspurt";
    level._effect["animscript_gib_fx"] = "weapon/bullet/fx_flesh_gib_fatal_01";
    level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
    level._effect["switch_sparks"] = "env/electrical/fx_elec_wire_spark_burst";
    level._effect["keeper_spawn"] = "zombie/fx_portal_keeper_spawn_zod_zmb";
    level._effect["pap_cord_impact"] = "impacts/fx_bul_impact_blood_body_fatal_zmb";
    level._effect["fury_ground_tell_fx"] = "zombie/fx_meatball_impact_ground_tell_zod_zmb";
}

// Namespace zm_genesis_fx
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x6a0
// Size: 0x4
function function_e6258024() {
    
}

// Namespace zm_genesis_fx
// Params 0, eflags: 0x1 linked
// Checksum 0xcd6f94ee, Offset: 0x6b0
// Size: 0x34
function function_2c301fae() {
    level thread function_12901f9a();
    level thread function_7eea24df();
}

// Namespace zm_genesis_fx
// Params 0, eflags: 0x1 linked
// Checksum 0x1ef8872a, Offset: 0x6f0
// Size: 0xaa
function function_12901f9a() {
    level._effect["jugger_light"] = "dlc4/genesis/fx_perk_juggernaut";
    level._effect["revive_light"] = "dlc4/genesis/fx_perk_quick_revive";
    level._effect["sleight_light"] = "dlc4/genesis/fx_perk_sleight_of_hand";
    level._effect["doubletap2_light"] = "dlc4/genesis/fx_perk_doubletap";
    level._effect["marathon_light"] = "dlc4/genesis/fx_perk_stamin_up";
    level._effect["additionalprimaryweapon_light"] = "dlc4/genesis/fx_perk_mule_kick";
}

// Namespace zm_genesis_fx
// Params 0, eflags: 0x1 linked
// Checksum 0x46c5fb05, Offset: 0x7a8
// Size: 0x1e
function function_7eea24df() {
    level._effect["lght_marker"] = "dlc4/genesis/fx_weapon_box_marker_genesis";
}

