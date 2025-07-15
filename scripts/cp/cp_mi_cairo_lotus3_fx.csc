#using scripts/codescripts/struct;
#using scripts/shared/fx_shared;

#namespace cp_mi_cairo_lotus3_fx;

// Namespace cp_mi_cairo_lotus3_fx
// Params 0
// Checksum 0x720338dc, Offset: 0x140
// Size: 0x14
function main()
{
    precache_scripted_fx();
}

// Namespace cp_mi_cairo_lotus3_fx
// Params 0
// Checksum 0xda42390e, Offset: 0x160
// Size: 0x56
function precache_scripted_fx()
{
    level._effect[ "player_sand" ] = "weather/fx_sand_player_os";
    level._effect[ "gunship_fan_damage" ] = "impacts/fx_bul_impact_gun_ship_engines";
    level._effect[ "player_breath" ] = "player/fx_plyr_breath_steam_1p";
}

