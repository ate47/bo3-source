#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;

#namespace zm_zod_fx;

// Namespace zm_zod_fx
// Params 0
// Checksum 0x688a3529, Offset: 0x2c0
// Size: 0x24
function main()
{
    precache_scripted_fx();
    precache_createfx_fx();
}

// Namespace zm_zod_fx
// Params 0
// Checksum 0xd3fc4666, Offset: 0x2f0
// Size: 0xe2
function precache_scripted_fx()
{
    level._effect[ "idgun_cocoon_off" ] = "zombie/fx_idgun_cocoon_explo_zod_zmb";
    level._effect[ "pap_basin_glow" ] = "zombie/fx_ritual_pap_basin_fire_zod_zmb";
    level._effect[ "pap_basin_glow_lg" ] = "zombie/fx_ritual_pap_basin_fire_lg_zod_zmb";
    level._effect[ "cultist_crate_personal_item" ] = "zombie/fx_cultist_crate_smk_zod_zmb";
    level._effect[ "robot_landing" ] = "zombie/fx_robot_helper_jump_landing_zod_zmb";
    level._effect[ "robot_sky_trail" ] = "zombie/fx_robot_helper_trail_sky_zod_zmb";
    level._effect[ "robot_ground_spawn" ] = "zombie/fx_robot_helper_ground_tell_zod_zmb";
    level._effect[ "portal_shortcut_closed" ] = "zombie/fx_quest_portal_tear_zod_zmb";
}

// Namespace zm_zod_fx
// Params 0
// Checksum 0x99ec1590, Offset: 0x3e0
// Size: 0x4
function precache_createfx_fx()
{
    
}

