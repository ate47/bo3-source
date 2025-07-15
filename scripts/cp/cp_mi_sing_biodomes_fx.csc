#using scripts/codescripts/struct;
#using scripts/shared/fx_shared;

#namespace cp_mi_sing_biodomes_fx;

// Namespace cp_mi_sing_biodomes_fx
// Params 0
// Checksum 0x8c2a3548, Offset: 0xe0
// Size: 0x14
function main()
{
    precache_scripted_fx();
}

// Namespace cp_mi_sing_biodomes_fx
// Params 0
// Checksum 0x2c793f01, Offset: 0x100
// Size: 0x1e
function precache_scripted_fx()
{
    level._effect[ "player_dust" ] = "dirt/fx_dust_motes_player_loop";
}

