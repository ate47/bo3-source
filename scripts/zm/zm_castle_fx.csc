#using scripts/codescripts/struct;
#using scripts/shared/exploder_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;

#namespace zm_castle_fx;

// Namespace zm_castle_fx
// Params 0
// Checksum 0x99ec1590, Offset: 0x1f0
// Size: 0x4
function precache_util_fx()
{
    
}

// Namespace zm_castle_fx
// Params 0
// Checksum 0x24fec0e7, Offset: 0x200
// Size: 0x34
function main()
{
    precache_util_fx();
    precache_createfx_fx();
    precache_scripted_fx();
}

// Namespace zm_castle_fx
// Params 0
// Checksum 0xf9cde396, Offset: 0x240
// Size: 0x8e
function precache_scripted_fx()
{
    level._effect[ "zapper" ] = "dlc1/castle/fx_elec_trap_castle";
    level._effect[ "rocket_warning_smoke" ] = "smoke/fx_smk_ambient_cieling_newworld";
    level._effect[ "rocket_warning_fire" ] = "explosions/fx_exp_vtol_crash_trail_prologue";
    level._effect[ "rocket_side_blast" ] = "fire/fx_fire_side_lrg";
    level._effect[ "death_ray_shock_eyes" ] = "zombie/fx_tesla_shock_eyes_zmb";
}

// Namespace zm_castle_fx
// Params 0
// Checksum 0x99ec1590, Offset: 0x2d8
// Size: 0x4
function precache_createfx_fx()
{
    
}

