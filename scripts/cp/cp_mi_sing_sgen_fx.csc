#using scripts/codescripts/struct;
#using scripts/shared/fx_shared;

#namespace cp_mi_sing_sgen_fx;

// Namespace cp_mi_sing_sgen_fx
// Params 0
// Checksum 0xe55811a1, Offset: 0x200
// Size: 0xc6
function main()
{
    level._effect[ "yellow_light" ] = "light/fx_light_depth_charge_warning";
    level._effect[ "red_light" ] = "light/fx_light_depth_charge";
    level._effect[ "eye_glow" ] = "light/fx_glow_robot_control_gen_2_head";
    level._effect[ "dust_motes" ] = "dirt/fx_dust_motes_player_loop";
    level._effect[ "water_motes" ] = "water/fx_underwater_debris_player_loop";
    level._effect[ "water_teleport" ] = "water/fx_water_rush_teleport_cover";
    level._effect[ "water_robot_bubbles" ] = "player/fx_plyr_swim_bubbles_body";
}

