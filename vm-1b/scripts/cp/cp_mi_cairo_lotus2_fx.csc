#using scripts/codescripts/struct;
#using scripts/shared/fx_shared;

#namespace cp_mi_cairo_lotus2_fx;

// Namespace cp_mi_cairo_lotus2_fx
// Params 0, eflags: 0x0
// Checksum 0xf4792cc7, Offset: 0x1b0
// Size: 0x12
function main() {
    function_f45953c();
}

// Namespace cp_mi_cairo_lotus2_fx
// Params 0, eflags: 0x0
// Checksum 0x48bc99b9, Offset: 0x1d0
// Size: 0x7b
function function_f45953c() {
    level._effect["player_sand_skybridge"] = "weather/fx_sand_player_os_skybridge_lotus";
    level._effect["player_sand"] = "weather/fx_sand_player_os";
    level._effect["player_dust"] = "dirt/fx_dust_motes_player_loop";
    level._effect["player_breath"] = "player/fx_plyr_breath_steam_1p_lotus";
    level._effect["breath_third_person"] = "player/fx_plyr_breath_steam_3p_lotus";
}

