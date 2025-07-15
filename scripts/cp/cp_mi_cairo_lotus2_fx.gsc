#using scripts/codescripts/struct;

#namespace cp_mi_cairo_lotus2_fx;

// Namespace cp_mi_cairo_lotus2_fx
// Params 0
// Checksum 0x9f007657, Offset: 0x178
// Size: 0x14
function main()
{
    precache_scripted_fx();
}

// Namespace cp_mi_cairo_lotus2_fx
// Params 0
// Checksum 0x4a1cf0bd, Offset: 0x198
// Size: 0x72
function precache_scripted_fx()
{
    level._effect[ "mobile_shop_fall_explosion" ] = "explosions/fx_exp_lt_moving_shop_fall";
    level._effect[ "fx_snow_lotus" ] = "weather/fx_snow_player_os_lotus";
    level._effect[ "fx_rogue_robot_explosion" ] = "explosions/fx_exp_robot_stage3_evb";
    level._effect[ "raven_explosion" ] = "explosions/fx_exp_dni_raven_reveal";
}

