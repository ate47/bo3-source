#using scripts/codescripts/struct;
#using scripts/shared/fx_shared;

#namespace cp_mi_cairo_lotus_fx;

// Namespace cp_mi_cairo_lotus_fx
// Params 0
// Checksum 0xde554ca3, Offset: 0x148
// Size: 0x14
function main()
{
    precache_scripted_fx();
}

// Namespace cp_mi_cairo_lotus_fx
// Params 0
// Checksum 0x2414f55a, Offset: 0x168
// Size: 0x56
function precache_scripted_fx()
{
    level._effect[ "player_dust" ] = "dirt/fx_dust_motes_player_loop";
    level._effect[ "player_breath" ] = "player/fx_plyr_breath_steam_1p_lotus";
    level._effect[ "breath_third_person" ] = "player/fx_plyr_breath_steam_3p_lotus";
}

