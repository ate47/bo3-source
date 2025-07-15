#using scripts/shared/flagsys_shared;

#namespace zm_cosmodrome_fx;

// Namespace zm_cosmodrome_fx
// Params 0
// Checksum 0x51208832, Offset: 0x5b8
// Size: 0x2c
function main()
{
    precache_scripted_fx();
    level thread fx_overrides();
}

// Namespace zm_cosmodrome_fx
// Params 0
// Checksum 0x6f20814, Offset: 0x5f0
// Size: 0x24e
function precache_scripted_fx()
{
    level._effect[ "monkey_eye_glow" ] = "dlc5/zmhd/fx_zmb_monkey_eyes";
    level._effect[ "lunar_lander_dust" ] = "dlc5/cosmo/fx_zombie_lunar_lander_dust";
    level._effect[ "rocket_exp_1" ] = "dlc5/cosmo/fx_zmb_csm_rocket_exp";
    level._effect[ "rocket_exp_2" ] = "dlc5/cosmo/fx_zmb_csm_rocket_top_exp";
    level._effect[ "mig_trail" ] = "dlc5/zmhd/fx_geotrail_jet_contrail";
    level._effect[ "poltergeist" ] = "zombie/fx_barrier_buy_zmb";
    level._effect[ "switch_sparks" ] = "dlc5/zmhd/fx_elec_wire_spark_burst";
    level._effect[ "generator_ee_sparks" ] = "dlc5/cosmo/fx_elec_spark_ee_quad";
    level._effect[ "gersh_spark" ] = "dlc5/zmhd/fx_mp_light_corona_bulb_ceiling";
    level._effect[ "zapper_light_ready" ] = "dlc5/zmhd/fx_zombie_zapper_light_green";
    level._effect[ "zapper_light_notready" ] = "dlc5/zmhd/fx_zombie_zapper_light_red";
    level._effect[ "dangling_wire" ] = "dlc5/zmhd/fx_zmb_elec_burst_heavy_os_int";
    level._effect[ "elec_md" ] = "dlc5/zmhd/fx_elec_player_md";
    level._effect[ "elec_sm" ] = "dlc5/zmhd/fx_elec_player_sm";
    level._effect[ "elec_torso" ] = "dlc5/zmhd/fx_elec_player_torso";
    level._effect[ "lght_marker" ] = "dlc5/tomb/fx_tomb_marker";
    level._effect[ "lght_marker_flare" ] = "dlc5/tomb/fx_tomb_marker_fl";
    level._effect[ "rocket_spotlight" ] = "dlc5/zmhd/fx_mp_ray_spotlight_xlg";
    level._effect[ "auto_turret_light" ] = "dlc5/zmhd/fx_zombie_auto_turret_light";
    level._effect[ "zomb_gib" ] = "zombie/fx_dog_explosion_zmb";
    level._effect[ "fx_light_ee_progress" ] = "dlc5/cosmo/fx_light_ee_progress";
}

// Namespace zm_cosmodrome_fx
// Params 0
// Checksum 0x4c494f54, Offset: 0x848
// Size: 0xca
function fx_overrides()
{
    level flagsys::wait_till( "load_main_complete" );
    level._effect[ "additionalprimaryweapon_light" ] = "dlc5/zmhd/fx_perk_mule_kick";
    level._effect[ "jugger_light" ] = "dlc5/zmhd/fx_perk_juggernaut";
    level._effect[ "sleight_light" ] = "dlc5/zmhd/fx_perk_sleight_of_hand";
    level._effect[ "marathon_light" ] = "dlc5/zmhd/fx_perk_stamin_up";
    level._effect[ "revive_light" ] = "dlc5/zmhd/fx_perk_quick_revive";
    level._effect[ "widow_light" ] = "dlc5/zmhd/fx_perk_widows_wine";
}

