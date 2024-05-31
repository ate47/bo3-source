#using scripts/zm/zm_challenges_tomb;
#using scripts/zm/zm_tomb_teleporter;
#using scripts/zm/zm_tomb_tank;
#using scripts/zm/zm_tomb_quest_fire;
#using scripts/zm/zm_tomb_mech;
#using scripts/zm/zm_tomb_magicbox;
#using scripts/zm/zm_tomb_giant_robot;
#using scripts/zm/zm_tomb_fx;
#using scripts/zm/zm_tomb_ffotd;
#using scripts/zm/zm_tomb_ee;
#using scripts/zm/zm_tomb_dig;
#using scripts/zm/zm_tomb_craftables;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/zm_tomb_capture_zones;
#using scripts/zm/zm_tomb_ambient_scripts;
#using scripts/zm/zm_tomb_amb;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_powerup_zombie_blood;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_electric_cherry;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/shared/ai/mechz;
#using scripts/zm/_zm_ai_mechz_claw;
#using scripts/zm/_zm_ai_mechz;
#using scripts/zm/_zm_weap_staff_water;
#using scripts/zm/_zm_weap_staff_lightning;
#using scripts/zm/_zm_weap_staff_fire;
#using scripts/zm/_zm_weap_staff_air;
#using scripts/zm/craftables/_zm_craft_shield;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_weap_one_inch_punch;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weap_beacon;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/zm/_callbacks;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb;

// Namespace zm_tomb
// Params 0, eflags: 0x2
// Checksum 0x170eb750, Offset: 0x1e90
// Size: 0x1c
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
}

// Namespace zm_tomb
// Params 0, eflags: 0x1 linked
// Checksum 0xb99a7c37, Offset: 0x1eb8
// Size: 0xb34
function main() {
    level thread namespace_239f5449::main_start();
    clientfield::register("scriptmover", "glow_biplane_trail_fx", 21000, 1, "int", &function_ea1ce3fa, 0, 0);
    clientfield::register("scriptmover", "element_glow_fx", 21000, 4, "int", &crystal_fx, 0, 0);
    clientfield::register("scriptmover", "bryce_cake", 21000, 2, "int", &function_f6e2b5fc, 0, 0);
    clientfield::register("scriptmover", "switch_spark", 21000, 1, "int", &function_81f3b018, 0, 0);
    clientfield::register("scriptmover", "plane_fx", 21000, 1, "int", &function_ae268bd3, 0, 0);
    clientfield::register("world", "cooldown_steam", 21000, 2, "int", &function_61fd4b0c, 0, 0);
    clientfield::register("scriptmover", "teleporter_fx", 21000, 1, "int", &namespace_97bec092::function_a8255fab, 0, 0);
    n_bits = getminbitcountfornum(6);
    clientfield::register("toplayer", "player_rumble_and_shake", 21000, n_bits, "int", &function_f118a0e7, 0, 0);
    clientfield::register("scriptmover", "stone_frozen", 21000, 1, "int", &function_eb515bc3, 0, 0);
    n_bits = getminbitcountfornum(5);
    clientfield::register("world", "rain_level", 21000, n_bits, "int", &function_c62fcc7d, 0, 0);
    clientfield::register("world", "snow_level", 21000, n_bits, "int", &function_fbc162aa, 0, 0);
    clientfield::register("toplayer", "player_weather_visionset", 21000, 2, "int", &function_2feb8fa1, 0, 0);
    clientfield::register("scriptmover", "sky_pillar", 21000, 1, "int", &function_90b75360, 0, 0);
    clientfield::register("scriptmover", "staff_charger", 21000, 3, "int", &function_cef99197, 0, 0);
    clientfield::register("toplayer", "player_staff_charge", 21000, 2, "int", &function_35da9753, 0, 0);
    clientfield::register("toplayer", "player_tablet_state", 21000, 2, "int", &zm_utility::setinventoryuimodels, 0, 1);
    n_bits = getminbitcountfornum(4);
    clientfield::register("actor", "zombie_soul", 21000, n_bits, "int", &function_1ee903c, 0, 0);
    clientfield::register("zbarrier", "magicbox_runes", 21000, 1, "int", &function_1c88eb29, 0, 0);
    clientfield::register("actor", "foot_print_box_fx", 21000, 1, "int", &function_d89b75a4, 0, 0);
    clientfield::register("scriptmover", "foot_print_box_glow", 21000, 1, "int", &function_d4976b7d, 0, 0);
    clientfield::register("world", "crypt_open_exploder", 21000, 1, "int", &function_d20e4b5a, 0, 0);
    clientfield::register("world", "lantern_fx", 21000, 1, "int", &function_24a5862d, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.widget_shield_parts", 21000, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.player_crafted_shield", 21000, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "sndMudSlow", 21000, 1, "int", &namespace_54a425fe::function_8189f66f, 0, 0);
    clientfield::register("world", "mus_zmb_egg_snapshot_loop", 21000, 1, "int", &namespace_54a425fe::function_ec990408, 1, 0);
    clientfield::register("toplayer", "sndMaelstrom", 21000, 1, "int", &namespace_54a425fe::function_e33eeb14, 0, 0);
    clientfield::register("actor", "crusader_emissive_fx", 21000, 1, "int", &function_6b9d2513, 0, 0);
    clientfield::register("actor", "zombie_instant_explode", 21000, 1, "int", &function_b3ff5e6d, 0, 1);
    level.default_start_location = "tomb";
    level.default_game_mode = "zclassic";
    level._no_water_risers = 1;
    level.var_7d2be23b = 3;
    level.var_3ae99156 = &function_e20b060c;
    level._uses_sticky_grenades = 1;
    level.var_2dabbd7 = 1;
    level._uses_taser_knuckles = 0;
    level._wallbuy_override_num_bits = 1;
    level.setupcustomcharacterexerts = &setup_personality_character_exerts;
    level._no_equipment_activated_clientfield = 1;
    level.var_f8683afc = 1;
    level.var_aa00c190 = 0;
    level.var_c95eeed7 = 0;
    level.var_16d8620e = 0;
    namespace_c70bea9a::init();
    namespace_90429ef7::main();
    namespace_e6d36abe::init();
    namespace_d1b0a244::init();
    function_b211e563();
    namespace_99ea9186::init();
    namespace_baebcb1::init();
    namespace_e0f9e0c4::main();
    namespace_711a44f0::init();
    namespace_97bec092::init();
    level thread namespace_a2c37c4f::main();
    level._entityspawned_override = &function_b1ef089b;
    namespace_f7a613cf::function_3ebec56b();
    namespace_f7a613cf::function_95743e9f();
    namespace_cdc4d06c::init_structs();
    level thread namespace_54a425fe::main();
    load::main();
    level.var_a01dd863 = getdvarfloat("r_lightTweakSunLight");
    util::waitforclient(0);
    level thread namespace_e0f9e0c4::function_75cc0fd3();
    level thread function_6ac83719();
    level thread namespace_cdc4d06c::function_902e1a6d();
    level.sndnomeleeonclient = 1;
    setdvar("bg_chargeShotExponentialAmmoPerChargeLevel", 1);
    level thread namespace_239f5449::main_end();
}

// Namespace zm_tomb
// Params 0, eflags: 0x1 linked
// Checksum 0xf9074194, Offset: 0x29f8
// Size: 0x8c
function function_b211e563() {
    level.var_d1f24ab6 = 1;
    include_weapons();
    function_7e593d71();
    namespace_ba8619ac::init();
    namespace_570c8452::init();
    namespace_97bec092::main();
    visionset_mgr::register_overlay_info_style_burn("zm_transit_burn", 21000, 15, 2);
}

// Namespace zm_tomb
// Params 0, eflags: 0x1 linked
// Checksum 0xab5988ae, Offset: 0x2a90
// Size: 0x34
function function_7e593d71() {
    zm_equipment::include("equip_dieseldrone");
    zm_equipment::include("tomb_shield");
}

// Namespace zm_tomb
// Params 0, eflags: 0x1 linked
// Checksum 0x810b159d, Offset: 0x2ad0
// Size: 0x1482
function setup_personality_character_exerts() {
    level.exert_sounds[1]["playerbreathinsound"][0] = "vox_plr_0_exert_inhale_0";
    level.exert_sounds[1]["playerbreathinsound"][1] = "vox_plr_0_exert_inhale_1";
    level.exert_sounds[1]["playerbreathinsound"][2] = "vox_plr_0_exert_inhale_2";
    level.exert_sounds[2]["playerbreathinsound"][0] = "vox_plr_1_exert_inhale_0";
    level.exert_sounds[2]["playerbreathinsound"][1] = "vox_plr_1_exert_inhale_1";
    level.exert_sounds[2]["playerbreathinsound"][2] = "vox_plr_1_exert_inhale_2";
    level.exert_sounds[3]["playerbreathinsound"][0] = "vox_plr_2_exert_inhale_0";
    level.exert_sounds[3]["playerbreathinsound"][1] = "vox_plr_2_exert_inhale_1";
    level.exert_sounds[3]["playerbreathinsound"][2] = "vox_plr_2_exert_inhale_2";
    level.exert_sounds[4]["playerbreathinsound"][0] = "vox_plr_3_exert_inhale_0";
    level.exert_sounds[4]["playerbreathinsound"][1] = "vox_plr_3_exert_inhale_1";
    level.exert_sounds[4]["playerbreathinsound"][2] = "vox_plr_3_exert_inhale_2";
    level.exert_sounds[1]["playerbreathoutsound"][0] = "vox_plr_0_exert_exhale_0";
    level.exert_sounds[1]["playerbreathoutsound"][1] = "vox_plr_0_exert_exhale_1";
    level.exert_sounds[1]["playerbreathoutsound"][2] = "vox_plr_0_exert_exhale_2";
    level.exert_sounds[2]["playerbreathoutsound"][0] = "vox_plr_1_exert_exhale_0";
    level.exert_sounds[2]["playerbreathoutsound"][1] = "vox_plr_1_exert_exhale_1";
    level.exert_sounds[2]["playerbreathoutsound"][2] = "vox_plr_1_exert_exhale_2";
    level.exert_sounds[3]["playerbreathoutsound"][0] = "vox_plr_2_exert_exhale_0";
    level.exert_sounds[3]["playerbreathoutsound"][1] = "vox_plr_2_exert_exhale_1";
    level.exert_sounds[3]["playerbreathoutsound"][2] = "vox_plr_2_exert_exhale_2";
    level.exert_sounds[4]["playerbreathoutsound"][0] = "vox_plr_3_exert_exhale_0";
    level.exert_sounds[4]["playerbreathoutsound"][1] = "vox_plr_3_exert_exhale_1";
    level.exert_sounds[4]["playerbreathoutsound"][2] = "vox_plr_3_exert_exhale_2";
    level.exert_sounds[1]["playerbreathgaspsound"][0] = "vox_plr_0_exert_exhale_0";
    level.exert_sounds[1]["playerbreathgaspsound"][1] = "vox_plr_0_exert_exhale_1";
    level.exert_sounds[1]["playerbreathgaspsound"][2] = "vox_plr_0_exert_exhale_2";
    level.exert_sounds[2]["playerbreathgaspsound"][0] = "vox_plr_1_exert_exhale_0";
    level.exert_sounds[2]["playerbreathgaspsound"][1] = "vox_plr_1_exert_exhale_1";
    level.exert_sounds[2]["playerbreathgaspsound"][2] = "vox_plr_1_exert_exhale_2";
    level.exert_sounds[3]["playerbreathgaspsound"][0] = "vox_plr_2_exert_exhale_0";
    level.exert_sounds[3]["playerbreathgaspsound"][1] = "vox_plr_2_exert_exhale_1";
    level.exert_sounds[3]["playerbreathgaspsound"][2] = "vox_plr_2_exert_exhale_2";
    level.exert_sounds[4]["playerbreathgaspsound"][0] = "vox_plr_3_exert_exhale_0";
    level.exert_sounds[4]["playerbreathgaspsound"][1] = "vox_plr_3_exert_exhale_1";
    level.exert_sounds[4]["playerbreathgaspsound"][2] = "vox_plr_3_exert_exhale_2";
    level.exert_sounds[1]["falldamage"][0] = "vox_plr_0_exert_pain_low_0";
    level.exert_sounds[1]["falldamage"][1] = "vox_plr_0_exert_pain_low_1";
    level.exert_sounds[1]["falldamage"][2] = "vox_plr_0_exert_pain_low_2";
    level.exert_sounds[1]["falldamage"][3] = "vox_plr_0_exert_pain_low_3";
    level.exert_sounds[1]["falldamage"][4] = "vox_plr_0_exert_pain_low_4";
    level.exert_sounds[1]["falldamage"][5] = "vox_plr_0_exert_pain_low_5";
    level.exert_sounds[1]["falldamage"][6] = "vox_plr_0_exert_pain_low_6";
    level.exert_sounds[1]["falldamage"][7] = "vox_plr_0_exert_pain_low_7";
    level.exert_sounds[2]["falldamage"][0] = "vox_plr_1_exert_pain_low_0";
    level.exert_sounds[2]["falldamage"][1] = "vox_plr_1_exert_pain_low_1";
    level.exert_sounds[2]["falldamage"][2] = "vox_plr_1_exert_pain_low_2";
    level.exert_sounds[2]["falldamage"][3] = "vox_plr_1_exert_pain_low_3";
    level.exert_sounds[2]["falldamage"][4] = "vox_plr_1_exert_pain_low_4";
    level.exert_sounds[2]["falldamage"][5] = "vox_plr_1_exert_pain_low_5";
    level.exert_sounds[2]["falldamage"][6] = "vox_plr_1_exert_pain_low_6";
    level.exert_sounds[2]["falldamage"][7] = "vox_plr_1_exert_pain_low_7";
    level.exert_sounds[3]["falldamage"][0] = "vox_plr_2_exert_pain_low_0";
    level.exert_sounds[3]["falldamage"][1] = "vox_plr_2_exert_pain_low_1";
    level.exert_sounds[3]["falldamage"][2] = "vox_plr_2_exert_pain_low_2";
    level.exert_sounds[3]["falldamage"][3] = "vox_plr_2_exert_pain_low_3";
    level.exert_sounds[3]["falldamage"][4] = "vox_plr_2_exert_pain_low_4";
    level.exert_sounds[3]["falldamage"][5] = "vox_plr_2_exert_pain_low_5";
    level.exert_sounds[3]["falldamage"][6] = "vox_plr_2_exert_pain_low_6";
    level.exert_sounds[3]["falldamage"][7] = "vox_plr_2_exert_pain_low_7";
    level.exert_sounds[4]["falldamage"][0] = "vox_plr_3_exert_pain_low_0";
    level.exert_sounds[4]["falldamage"][1] = "vox_plr_3_exert_pain_low_1";
    level.exert_sounds[4]["falldamage"][2] = "vox_plr_3_exert_pain_low_2";
    level.exert_sounds[4]["falldamage"][3] = "vox_plr_3_exert_pain_low_3";
    level.exert_sounds[4]["falldamage"][4] = "vox_plr_3_exert_pain_low_4";
    level.exert_sounds[4]["falldamage"][5] = "vox_plr_3_exert_pain_low_5";
    level.exert_sounds[4]["falldamage"][6] = "vox_plr_3_exert_pain_low_6";
    level.exert_sounds[4]["falldamage"][7] = "vox_plr_3_exert_pain_low_7";
    level.exert_sounds[1]["mantlesoundplayer"][0] = "vox_plr_0_exert_grunt_0";
    level.exert_sounds[1]["mantlesoundplayer"][1] = "vox_plr_0_exert_grunt_1";
    level.exert_sounds[1]["mantlesoundplayer"][2] = "vox_plr_0_exert_grunt_2";
    level.exert_sounds[1]["mantlesoundplayer"][3] = "vox_plr_0_exert_grunt_3";
    level.exert_sounds[1]["mantlesoundplayer"][4] = "vox_plr_0_exert_grunt_4";
    level.exert_sounds[1]["mantlesoundplayer"][5] = "vox_plr_0_exert_grunt_5";
    level.exert_sounds[1]["mantlesoundplayer"][6] = "vox_plr_0_exert_grunt_6";
    level.exert_sounds[2]["mantlesoundplayer"][0] = "vox_plr_1_exert_grunt_0";
    level.exert_sounds[2]["mantlesoundplayer"][1] = "vox_plr_1_exert_grunt_1";
    level.exert_sounds[2]["mantlesoundplayer"][2] = "vox_plr_1_exert_grunt_2";
    level.exert_sounds[2]["mantlesoundplayer"][3] = "vox_plr_1_exert_grunt_3";
    level.exert_sounds[2]["mantlesoundplayer"][4] = "vox_plr_1_exert_grunt_4";
    level.exert_sounds[2]["mantlesoundplayer"][5] = "vox_plr_1_exert_grunt_5";
    level.exert_sounds[3]["mantlesoundplayer"][0] = "vox_plr_2_exert_grunt_0";
    level.exert_sounds[3]["mantlesoundplayer"][1] = "vox_plr_2_exert_grunt_1";
    level.exert_sounds[3]["mantlesoundplayer"][2] = "vox_plr_2_exert_grunt_2";
    level.exert_sounds[3]["mantlesoundplayer"][3] = "vox_plr_2_exert_grunt_3";
    level.exert_sounds[3]["mantlesoundplayer"][4] = "vox_plr_2_exert_grunt_4";
    level.exert_sounds[3]["mantlesoundplayer"][5] = "vox_plr_2_exert_grunt_5";
    level.exert_sounds[3]["mantlesoundplayer"][6] = "vox_plr_2_exert_grunt_6";
    level.exert_sounds[4]["mantlesoundplayer"][0] = "vox_plr_3_exert_grunt_0";
    level.exert_sounds[4]["mantlesoundplayer"][1] = "vox_plr_3_exert_grunt_1";
    level.exert_sounds[4]["mantlesoundplayer"][2] = "vox_plr_3_exert_grunt_2";
    level.exert_sounds[4]["mantlesoundplayer"][3] = "vox_plr_3_exert_grunt_4";
    level.exert_sounds[4]["mantlesoundplayer"][4] = "vox_plr_3_exert_grunt_5";
    level.exert_sounds[4]["mantlesoundplayer"][5] = "vox_plr_3_exert_grunt_6";
    level.exert_sounds[1]["meleeswipesoundplayer"][0] = "vox_plr_0_exert_knife_swipe_0";
    level.exert_sounds[1]["meleeswipesoundplayer"][1] = "vox_plr_0_exert_knife_swipe_1";
    level.exert_sounds[1]["meleeswipesoundplayer"][2] = "vox_plr_0_exert_knife_swipe_2";
    level.exert_sounds[1]["meleeswipesoundplayer"][3] = "vox_plr_0_exert_knife_swipe_3";
    level.exert_sounds[1]["meleeswipesoundplayer"][4] = "vox_plr_0_exert_knife_swipe_4";
    level.exert_sounds[1]["meleeswipesoundplayer"][5] = "vox_plr_0_exert_knife_swipe_5";
    level.exert_sounds[2]["meleeswipesoundplayer"][0] = "vox_plr_1_exert_knife_swipe_0";
    level.exert_sounds[2]["meleeswipesoundplayer"][1] = "vox_plr_1_exert_knife_swipe_1";
    level.exert_sounds[2]["meleeswipesoundplayer"][2] = "vox_plr_1_exert_knife_swipe_2";
    level.exert_sounds[2]["meleeswipesoundplayer"][3] = "vox_plr_1_exert_knife_swipe_3";
    level.exert_sounds[2]["meleeswipesoundplayer"][4] = "vox_plr_1_exert_knife_swipe_4";
    level.exert_sounds[2]["meleeswipesoundplayer"][5] = "vox_plr_1_exert_knife_swipe_5";
    level.exert_sounds[3]["meleeswipesoundplayer"][0] = "vox_plr_2_exert_knife_swipe_0";
    level.exert_sounds[3]["meleeswipesoundplayer"][1] = "vox_plr_2_exert_knife_swipe_1";
    level.exert_sounds[3]["meleeswipesoundplayer"][2] = "vox_plr_2_exert_knife_swipe_2";
    level.exert_sounds[3]["meleeswipesoundplayer"][3] = "vox_plr_2_exert_knife_swipe_3";
    level.exert_sounds[3]["meleeswipesoundplayer"][4] = "vox_plr_2_exert_knife_swipe_4";
    level.exert_sounds[3]["meleeswipesoundplayer"][5] = "vox_plr_2_exert_knife_swipe_5";
    level.exert_sounds[4]["meleeswipesoundplayer"][0] = "vox_plr_3_exert_knife_swipe_0";
    level.exert_sounds[4]["meleeswipesoundplayer"][1] = "vox_plr_3_exert_knife_swipe_1";
    level.exert_sounds[4]["meleeswipesoundplayer"][2] = "vox_plr_3_exert_knife_swipe_2";
    level.exert_sounds[4]["meleeswipesoundplayer"][3] = "vox_plr_3_exert_knife_swipe_3";
    level.exert_sounds[4]["meleeswipesoundplayer"][4] = "vox_plr_3_exert_knife_swipe_4";
    level.exert_sounds[4]["meleeswipesoundplayer"][5] = "vox_plr_3_exert_knife_swipe_5";
    level.exert_sounds[1]["dtplandsoundplayer"][0] = "vox_plr_0_exert_pain_medium_0";
    level.exert_sounds[1]["dtplandsoundplayer"][1] = "vox_plr_0_exert_pain_medium_1";
    level.exert_sounds[1]["dtplandsoundplayer"][2] = "vox_plr_0_exert_pain_medium_2";
    level.exert_sounds[1]["dtplandsoundplayer"][3] = "vox_plr_0_exert_pain_medium_3";
    level.exert_sounds[2]["dtplandsoundplayer"][0] = "vox_plr_1_exert_pain_medium_0";
    level.exert_sounds[2]["dtplandsoundplayer"][1] = "vox_plr_1_exert_pain_medium_1";
    level.exert_sounds[2]["dtplandsoundplayer"][2] = "vox_plr_1_exert_pain_medium_2";
    level.exert_sounds[2]["dtplandsoundplayer"][3] = "vox_plr_1_exert_pain_medium_3";
    level.exert_sounds[3]["dtplandsoundplayer"][0] = "vox_plr_2_exert_pain_medium_0";
    level.exert_sounds[3]["dtplandsoundplayer"][1] = "vox_plr_2_exert_pain_medium_1";
    level.exert_sounds[3]["dtplandsoundplayer"][2] = "vox_plr_2_exert_pain_medium_2";
    level.exert_sounds[3]["dtplandsoundplayer"][3] = "vox_plr_2_exert_pain_medium_3";
    level.exert_sounds[4]["dtplandsoundplayer"][0] = "vox_plr_3_exert_pain_medium_0";
    level.exert_sounds[4]["dtplandsoundplayer"][1] = "vox_plr_3_exert_pain_medium_1";
    level.exert_sounds[4]["dtplandsoundplayer"][2] = "vox_plr_3_exert_pain_medium_2";
    level.exert_sounds[4]["dtplandsoundplayer"][3] = "vox_plr_3_exert_pain_medium_3";
}

// Namespace zm_tomb
// Params 0, eflags: 0x1 linked
// Checksum 0x954c4ffd, Offset: 0x3f60
// Size: 0x74
function function_6ac83719() {
    visionset_mgr::function_980ca37e("zm_tomb", 1);
    visionset_mgr::function_a95252c1("");
    visionset_mgr::function_3aea3c1a(0, "zm_tomb");
    level thread visionset_mgr::function_f5fdcb4d();
}

// Namespace zm_tomb
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x3fe0
// Size: 0x4
function function_4c20cb5f() {
    
}

// Namespace zm_tomb
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x3ff0
// Size: 0x4
function function_69f2d0a3() {
    
}

// Namespace zm_tomb
// Params 0, eflags: 0x1 linked
// Checksum 0x8091fa0f, Offset: 0x4000
// Size: 0x34
function include_weapons() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_tomb_weapons.csv", 1);
    zm_weapons::function_9e8dccbe();
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0x61c7cba4, Offset: 0x4040
// Size: 0xf4
function function_b1ef089b(localclientnum) {
    if (!isdefined(self.type)) {
        println("world");
        return;
    }
    if (self.type == "player") {
        self thread callback::playerspawned(localclientnum);
        return;
    }
    if (self.type == "vehicle") {
        if (self.vehicletype === "heli_quadrotor_zm" || self.vehicletype === "heli_quadrotor_upgraded_zm") {
            self thread function_b14689f(localclientnum);
        }
        return;
    }
    if (self.type == "actor") {
        if (isdefined(level._customactorcbfunc)) {
            self thread [[ level._customactorcbfunc ]](localclientnum);
        }
    }
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0x687db595, Offset: 0x4140
// Size: 0x54
function function_b14689f(localclientnum) {
    self util::waittill_dobj(localclientnum);
    level thread namespace_54a425fe::init();
    self thread namespace_54a425fe::start_helicopter_sounds();
}

// Namespace zm_tomb
// Params 2, eflags: 0x1 linked
// Checksum 0x92355b63, Offset: 0x41a0
// Size: 0x88
function function_5efb4f48(localclientnum, str_rumble) {
    self endon(#"hash_9c289640");
    self endon(#"disconnect");
    delta_time = 0.1;
    n_max_time = 10;
    while (isdefined(self)) {
        self playrumbleonentity(localclientnum, str_rumble);
        wait(0.1);
    }
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x4cf35da1, Offset: 0x4230
// Size: 0xec
function function_35da9753(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self notify(#"hash_9c289640");
    str_rumble = undefined;
    switch (newval) {
    case 1:
        str_rumble = "reload_small";
        break;
    case 2:
        str_rumble = "damage_light";
        break;
    case 3:
        str_rumble = "damage_heavy";
        break;
    default:
        break;
    }
    if (isdefined(str_rumble)) {
        self thread function_5efb4f48(localclientnum, str_rumble);
    }
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x33332cc3, Offset: 0x4328
// Size: 0x15e
function function_cef99197(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (!isdefined(level.var_d1435401)) {
        level.var_d1435401 = [];
    }
    if (newval != 0) {
        level.var_d1435401[newval] = self.origin;
        return;
    }
    keys = getarraykeys(level.var_d1435401);
    foreach (i in keys) {
        if (!isdefined(level.var_d1435401[i])) {
            continue;
        }
        if (distancesquared(level.var_d1435401[i], self.origin) < 100) {
            level.var_d1435401[i] = undefined;
        }
    }
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x654faf55, Offset: 0x4490
// Size: 0x28c
function function_1ee903c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    v_origin = self gettagorigin("J_SpineUpper");
    v_dest = undefined;
    if (!isdefined(level.var_d1435401)) {
        level.var_d1435401 = [];
    }
    if (isdefined(level.var_d1435401[newval])) {
        v_dest = level.var_d1435401[newval];
    }
    if (!isdefined(v_dest) || !isdefined(v_origin)) {
        return;
    }
    if (isdefined(self)) {
        v_origin = self gettagorigin("J_SpineUpper");
    }
    e_fx = spawn(localclientnum, v_origin, "script_model");
    e_fx setmodel("tag_origin");
    e_fx playsound(localclientnum, "zmb_squest_charge_soul_leave");
    e_fx playloopsound("zmb_squest_charge_soul_lp");
    playfxontag(localclientnum, level._effect["staff_soul"], e_fx, "tag_origin");
    e_fx moveto(v_dest + (0, 0, 5), 0.5);
    e_fx waittill(#"movedone");
    e_fx playsound(localclientnum, "zmb_squest_charge_soul_impact");
    playfxontag(localclientnum, level._effect["staff_charge"], e_fx, "tag_origin");
    util::server_wait(localclientnum, 0.3);
    e_fx delete();
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0xe266af9d, Offset: 0x4728
// Size: 0x1c6
function function_1c88eb29(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    n_pieces = self getnumzbarrierpieces();
    if (!isdefined(self.mapped_const)) {
        for (i = 0; i < n_pieces; i++) {
            e_piece = self zbarriergetpiece(i);
            e_piece mapshaderconstant(localclientnum, 1, "ScriptVector0");
        }
        self.mapped_const = 1;
    }
    if (newval) {
        for (i = 0; i < n_pieces; i++) {
            e_piece = self zbarriergetpiece(i);
            e_piece setshaderconstant(localclientnum, 1, 0, 1, 0, 0);
        }
        return;
    }
    for (i = 0; i < n_pieces; i++) {
        e_piece = self zbarriergetpiece(i);
        e_piece setshaderconstant(localclientnum, 1, 0, 0, 0, 0);
    }
}

// Namespace zm_tomb
// Params 2, eflags: 0x1 linked
// Checksum 0x386a5018, Offset: 0x48f8
// Size: 0x76
function angle_dif(oldangle, newangle) {
    outvalue = (oldangle - newangle) % 360;
    if (outvalue < 0) {
        outvalue += 360;
    }
    if (outvalue > -76) {
        outvalue = (outvalue - 360) * -1;
    }
    return outvalue;
}

// Namespace zm_tomb
// Params 0, eflags: 0x1 linked
// Checksum 0x3484e440, Offset: 0x4978
// Size: 0xf0
function function_d56fa005() {
    for (i = 0; i < 5; i++) {
        if (!isdefined(level.var_3e984f03[i])) {
            continue;
        }
        n_rotation = int(level.var_3e984f03[i]);
        n_target = int(self.angles[1]);
        diff = abs(angle_dif(n_target, n_rotation));
        if (diff <= 45) {
            return i;
        }
    }
    return 0;
}

// Namespace zm_tomb
// Params 2, eflags: 0x1 linked
// Checksum 0xa3a07c8, Offset: 0x4a70
// Size: 0x2d8
function function_657fb719(localclientnum, var_17d831e1) {
    if (!isdefined(level.var_3e984f03)) {
        level.var_3e984f03 = [];
        level.var_3e984f03[2] = 270;
        level.var_3e984f03[1] = 180;
        level.var_3e984f03[3] = 90;
        level.var_3e984f03[4] = 0;
    }
    if (!isdefined(level.var_1aa82a7e)) {
        level.var_1aa82a7e = [];
        level.var_1aa82a7e[0] = -1;
        level.var_1aa82a7e[2] = 2;
        level.var_1aa82a7e[1] = 3;
        level.var_1aa82a7e[3] = 0;
        level.var_1aa82a7e[4] = 1;
        level.var_1aa82a7e[5] = 4;
    }
    var_477f7b08 = self function_d56fa005();
    v_color = level.var_1aa82a7e[var_477f7b08];
    var_70f85c31 = 0.1;
    if (isdefined(level.var_fdb98849) && var_17d831e1) {
        var_904d8a16 = level clientfield::get("light_show");
        switch (var_904d8a16) {
        case 1:
            var_477f7b08 = 0;
            break;
        case 2:
            var_477f7b08 = 1;
            break;
        case 3:
            var_477f7b08 = 5;
            break;
        default:
            var_477f7b08 = 0;
            break;
        }
        var_70f85c31 *= 10;
    } else if (isdefined(level.var_656c2f5) && !var_17d831e1) {
        var_477f7b08 = 0;
        var_70f85c31 = 0;
    } else if (var_17d831e1) {
        var_70f85c31 *= 10;
    }
    playsound(0, "zmb_crypt_disc_light", self.origin);
    var_f9e79b00 = self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, var_70f85c31, level.var_1aa82a7e[var_477f7b08], 0);
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0xfcd857d8, Offset: 0x4d50
// Size: 0x84
function function_f6e2b5fc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 2) {
        self thread function_657fb719(localclientnum, 1);
        return;
    }
    self thread function_657fb719(localclientnum, 0);
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x266ed6fe, Offset: 0x4de0
// Size: 0xac
function function_81f3b018(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (isdefined(self.var_ccfb843d)) {
        stopfx(localclientnum, self.var_ccfb843d);
        self.var_ccfb843d = undefined;
    }
    if (newval) {
        self.var_ccfb843d = playfxontag(localclientnum, level._effect["fx_tomb_sparks"], self, "lever_jnt");
    }
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0xd33ec512, Offset: 0x4e98
// Size: 0xac
function function_ae268bd3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        self.var_c304583e = playfxontag(localclientnum, level._effect["biplane_glow"], self, "tag_origin");
        return;
    }
    if (isdefined(self.var_c304583e)) {
        stopfx(localclientnum, self.var_c304583e);
    }
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0xbb2912bc, Offset: 0x4f50
// Size: 0x11c
function function_61fd4b0c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level notify(#"hash_14a17a44");
    if (newval == 1) {
        var_4c2b197a = struct::get("cooldown_steam_1", "targetname");
    } else if (newval == 2) {
        var_4c2b197a = struct::get("cooldown_steam_2", "targetname");
    } else if (newval == 3) {
        var_4c2b197a = struct::get("cooldown_steam_3", "targetname");
    }
    if (isdefined(var_4c2b197a)) {
        var_4c2b197a thread function_bebc67a2(localclientnum);
    }
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0xca755f68, Offset: 0x5078
// Size: 0x58
function function_bebc67a2(localclientnum) {
    level endon(#"hash_14a17a44");
    while (true) {
        playfx(localclientnum, level._effect["cooldown_steam"], self.origin);
        wait(0.1);
    }
}

// Namespace zm_tomb
// Params 2, eflags: 0x1 linked
// Checksum 0x1da026fd, Offset: 0x50d8
// Size: 0xf4
function function_1a4fa7a(localclientnum, enum) {
    str_fx = "teleport_air";
    switch (enum) {
    case 1:
        str_fx = "teleport_fire";
        break;
    case 4:
        str_fx = "teleport_ice";
        break;
    case 3:
        str_fx = "teleport_elec";
        break;
    case 2:
    default:
        str_fx = "teleport_air";
        break;
    }
    self.var_c304583e = playfxontag(localclientnum, level._effect[str_fx], self, "tag_origin");
    setfxignorepause(localclientnum, self.var_c304583e, 1);
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x829b6c6b, Offset: 0x51d8
// Size: 0x74
function function_ea1ce3fa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        playfxontag(localclientnum, level._effect["glow_biplane_trail_fx"], self, "tag_origin");
    }
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x8c3e277, Offset: 0x5258
// Size: 0x24c
function crystal_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval >= 5) {
        var_1f503d41 = newval - 4;
        function_1a4fa7a(localclientnum, var_1f503d41);
        return;
    }
    if (newval == 1) {
        self.var_c304583e = playfxontag(localclientnum, level._effect["fire_glow"], self, "tag_origin");
        setfxignorepause(localclientnum, self.var_c304583e, 1);
        return;
    }
    if (newval == 2) {
        self.var_c304583e = playfxontag(localclientnum, level._effect["air_glow"], self, "tag_origin");
        setfxignorepause(localclientnum, self.var_c304583e, 1);
        return;
    }
    if (newval == 3) {
        self.var_c304583e = playfxontag(localclientnum, level._effect["elec_glow"], self, "tag_origin");
        setfxignorepause(localclientnum, self.var_c304583e, 1);
        return;
    }
    if (newval == 4) {
        self.var_c304583e = playfxontag(localclientnum, level._effect["ice_glow"], self, "tag_origin");
        setfxignorepause(localclientnum, self.var_c304583e, 1);
        return;
    }
    if (newval == 0) {
        stopfx(localclientnum, self.var_c304583e);
    }
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x963cadc4, Offset: 0x54b0
// Size: 0xf2
function function_eb515bc3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"entityshutdown");
    if (newval) {
        self mapshaderconstant(localclientnum, 0, "ScriptVector3");
        for (f = 0; f <= 1; f += 0.01) {
            self setshaderconstant(localclientnum, 0, f, f, f, f);
            util::server_wait(localclientnum, 0.0166);
        }
    }
}

// Namespace zm_tomb
// Params 3, eflags: 0x1 linked
// Checksum 0x8ea6c2e, Offset: 0x55b0
// Size: 0x1ce
function function_5abafae8(localclientnum, fade_in, fade_time) {
    self notify(#"hash_35d6955f");
    self endon(#"hash_35d6955f");
    self endon(#"entityshutdown");
    var_4a52f6bf = 0;
    var_dcbc7038 = 1;
    if (fade_in) {
        var_4a52f6bf = 1;
        var_dcbc7038 = 0;
    }
    var_e7e3bd98 = 0.0166;
    var_853ae2af = int(fade_time / var_e7e3bd98);
    step_size = 1 / var_853ae2af;
    for (i = 0; i < var_853ae2af; i++) {
        pct = step_size * i;
        if (pct < 0) {
            pct = 0;
        } else if (pct > 1) {
            pct = 1;
        }
        value = lerpfloat(var_4a52f6bf, var_dcbc7038, pct);
        self setshaderconstant(localclientnum, 0, value, value, value, value);
        util::server_wait(localclientnum, var_e7e3bd98);
    }
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x7d6fd5ae, Offset: 0x5788
// Size: 0x1ec
function function_90b75360(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval == 1) {
        self mapshaderconstant(localclientnum, 0, "ScriptVector0");
        self thread function_5abafae8(localclientnum, 1, 1);
        playsound(0, "zmb_squest_crystal_sky_pillar_start", (3, 0, -38));
        audio::playloopat("zmb_squest_crystal_sky_pillar_loop", (0, -2, 435));
        audio::playloopat("zmb_squest_crystal_sky_pillar_loop_fx", (0, 0, 150));
        println("world");
        return;
    }
    self thread function_5abafae8(localclientnum, 0, 4);
    playsound(0, "zmb_squest_crystal_sky_pillar_stop", (3, 0, -38));
    audio::stoploopat("zmb_squest_crystal_sky_pillar_loop", (0, -2, 435));
    audio::stoploopat("zmb_squest_crystal_sky_pillar_loop_fx", (0, 0, 150));
    println("world");
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x7230f1b6, Offset: 0x5980
// Size: 0x206
function function_f118a0e7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self endon(#"disconnect");
    if (newval == 4) {
        self thread function_878b1e6c(localclientnum, 1);
        return;
    }
    if (newval == 5) {
        self thread function_878b1e6c(localclientnum, 2);
        return;
    }
    if (newval == 3) {
        self earthquake(0.6, 1.5, self.origin, 100);
        self playrumbleonentity(localclientnum, "artillery_rumble");
        return;
    }
    if (newval == 2) {
        self earthquake(0.3, 1.5, self.origin, 100);
        self playrumbleonentity(localclientnum, "shotgun_fire");
        return;
    }
    if (newval == 1) {
        self earthquake(0.1, 1, self.origin, 100);
        self playrumbleonentity(localclientnum, "damage_heavy");
        return;
    }
    if (newval == 6) {
        self thread function_878b1e6c(localclientnum, 1, 0);
        return;
    }
    self notify(#"hash_f9095a82");
}

// Namespace zm_tomb
// Params 3, eflags: 0x1 linked
// Checksum 0xe7266fb, Offset: 0x5b90
// Size: 0x160
function function_878b1e6c(localclientnum, var_4be1e559, var_d2e77e71) {
    if (!isdefined(var_d2e77e71)) {
        var_d2e77e71 = 1;
    }
    self notify(#"hash_f9095a82");
    self endon(#"disconnect");
    self endon(#"hash_f9095a82");
    while (true) {
        if (isdefined(self) && self islocalplayer() && isdefined(self)) {
            if (var_4be1e559 == 1) {
                if (var_d2e77e71) {
                    self earthquake(0.2, 1, self.origin, 100);
                }
                self playrumbleonentity(localclientnum, "reload_small");
                wait(0.05);
            } else {
                if (var_d2e77e71) {
                    self earthquake(0.3, 1, self.origin, 100);
                }
                self playrumbleonentity(localclientnum, "damage_light");
            }
        }
        wait(0.1);
    }
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x113b4f07, Offset: 0x5cf8
// Size: 0x54
function function_d20e4b5a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    exploder::exploder(-34);
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x8c2f72b8, Offset: 0x5d58
// Size: 0x2ba
function function_24a5862d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_aa8e992 = array("phys_lantern01", "phys_lantern02", "phys_lantern03", "phys_lantern04", "phys_lantern05", "phys_lantern06", "phys_lantern07", "phys_lantern08", "phys_lantern09", "phys_lantern10", "phys_lantern11", "phys_lantern12", "phys_lantern13", "phys_lantern14", "phys_lantern15", "phys_lantern16", "phys_lantern17", "phys_lantern18", "phys_lantern19");
    var_e531bd52 = [];
    foreach (str_name in var_aa8e992) {
        var_e531bd52 = arraycombine(var_e531bd52, getdynentarray(str_name), 0, 0);
    }
    if (newval) {
        foreach (lantern in var_e531bd52) {
            lantern function_ea74b5ce(localclientnum);
        }
        return;
    }
    foreach (lantern in var_e531bd52) {
        lantern function_b44167d(localclientnum);
    }
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0x22d00797, Offset: 0x6020
// Size: 0x5a
function function_ea74b5ce(var_1fb41218) {
    self function_b44167d(var_1fb41218);
    self.var_62bb476b[var_1fb41218] = playfxondynent(level._effect["fx_tomb_light_expensive"], self);
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0x5eeb385e, Offset: 0x6088
// Size: 0x5c
function function_b44167d(var_1fb41218) {
    if (!isdefined(self.var_62bb476b)) {
        self.var_62bb476b = [];
    }
    if (isdefined(self.var_62bb476b[var_1fb41218])) {
        deletefx(var_1fb41218, self.var_62bb476b[var_1fb41218], 1);
    }
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x98e8f10, Offset: 0x60f0
// Size: 0x48
function function_c62fcc7d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level.var_aa00c190 = newval;
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0xfe6c8a97, Offset: 0x6140
// Size: 0x48
function function_fbc162aa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    level.var_c95eeed7 = newval;
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0x89a6b808, Offset: 0x6190
// Size: 0xac
function function_5f9e6e69(localclientnum) {
    if (!isdefined(level.var_1c69bb12)) {
        level thread namespace_54a425fe::function_33be1969();
    }
    if (level.var_c95eeed7 == 0) {
        level notify("_snow_thread" + localclientnum);
        level.var_1c69bb12.var_308c43c8 = 0;
    } else {
        self thread function_50664fc(level.var_c95eeed7, localclientnum);
        level.var_1c69bb12.var_308c43c8 = 1;
    }
    level thread function_f099c69d(self);
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0x453e4b00, Offset: 0x6248
// Size: 0x104
function function_4a9e7e2(localclientnum) {
    if (!isdefined(level.var_1c69bb12)) {
        level thread namespace_54a425fe::function_33be1969();
    }
    if (!isdefined(self.var_c6d5e93e)) {
        self.var_c6d5e93e = 0;
    }
    if (level.var_aa00c190 == 0) {
        level notify("_rain_thread" + localclientnum);
        self.var_c6d5e93e = 0;
        level.var_1c69bb12.var_b13d6dfb = 0;
    } else {
        if (isdefined(self.var_c6d5e93e) && !self.var_c6d5e93e) {
            self thread function_2a8d9095(localclientnum);
        }
        self thread function_4236221(level.var_aa00c190, localclientnum);
        level.var_1c69bb12.var_b13d6dfb = 1;
    }
    level thread function_f099c69d(self);
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0xc7080d4c, Offset: 0x6358
// Size: 0x2ac
function function_2feb8fa1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    var_750d7c17 = 10;
    if (bnewent || binitialsnap || bwasdemojump) {
        var_750d7c17 = 0;
    }
    if (isdefined(self)) {
        self function_4a9e7e2(localclientnum);
        self function_5f9e6e69(localclientnum);
    }
    if (newval == 0 || newval == 3) {
        function_b5ac96ec("clear", localclientnum);
        setlitfogbank(localclientnum, -1, 0, -1);
        if (getdvarint("splitscreen_playerCount") > 2) {
            setworldfogactivebank(localclientnum, 9);
        } else {
            setworldfogactivebank(localclientnum, 1);
        }
        return;
    }
    if (newval == 1) {
        function_b5ac96ec("rain", localclientnum);
        setlitfogbank(localclientnum, -1, 2, -1);
        if (getdvarint("splitscreen_playerCount") > 2) {
            setworldfogactivebank(localclientnum, 12);
        } else {
            setworldfogactivebank(localclientnum, 4);
        }
        return;
    }
    if (newval == 2) {
        function_b5ac96ec("snow", localclientnum);
        setlitfogbank(localclientnum, -1, 1, -1);
        if (getdvarint("splitscreen_playerCount") > 2) {
            setworldfogactivebank(localclientnum, 10);
            return;
        }
        setworldfogactivebank(localclientnum, 2);
    }
}

// Namespace zm_tomb
// Params 2, eflags: 0x1 linked
// Checksum 0x44223c9a, Offset: 0x6610
// Size: 0x10a
function function_b5ac96ec(var_d8a51337, localclientnum) {
    exploder::stop_exploder("fxexp_111", localclientnum);
    exploder::stop_exploder("fxexp_112", localclientnum);
    exploder::stop_exploder("fxexp_113", localclientnum);
    switch (var_d8a51337) {
    case 238:
        exploder::exploder("fxexp_111", localclientnum);
        break;
    case 240:
        exploder::exploder("fxexp_112", localclientnum);
        break;
    case 241:
        exploder::exploder("fxexp_113", localclientnum);
        break;
    default:
        break;
    }
}

// Namespace zm_tomb
// Params 4, eflags: 0x0
// Checksum 0xda1aaee5, Offset: 0x6728
// Size: 0x24
function function_ee40d15e(localclientnum, var_24ba9457, var_c5799b7a, n_lerp_time) {
    
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0x10230e36, Offset: 0x6758
// Size: 0x54
function function_f099c69d(player) {
    level notify(#"hash_72666748");
    level endon(#"hash_72666748");
    wait(0.5);
    level notify(#"hash_f099c69d");
    player thread function_7820d164();
}

// Namespace zm_tomb
// Params 0, eflags: 0x1 linked
// Checksum 0x1979b466, Offset: 0x67b8
// Size: 0x4e
function function_7820d164() {
    wait(0.1);
    name = level.var_4196824f;
    if (isdefined(level.var_8475bbee) && isinarray(level.var_8475bbee, name)) {
    }
}

// Namespace zm_tomb
// Params 2, eflags: 0x1 linked
// Checksum 0x95b258b4, Offset: 0x6810
// Size: 0x126
function function_4236221(n_level, localclientnum) {
    level notify("_rain_thread" + localclientnum);
    level notify("_rain_begin" + localclientnum);
    level endon("_snow_begin" + localclientnum);
    level endon("_rain_thread" + localclientnum);
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    n_wait = 0.35 / n_level;
    if (n_wait < 0.15) {
        n_wait = 0.15;
    }
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        var_f0b23899 = function_508af4e9(localclientnum);
        playfx(localclientnum, level._effect["player_rain"], var_f0b23899[0], var_f0b23899[1]);
        wait(n_wait);
    }
}

// Namespace zm_tomb
// Params 2, eflags: 0x1 linked
// Checksum 0xf757b3b4, Offset: 0x6940
// Size: 0x126
function function_50664fc(n_level, localclientnum) {
    level notify("_snow_thread" + localclientnum);
    level notify("_snow_begin" + localclientnum);
    level endon("_rain_begin" + localclientnum);
    level endon("_snow_thread" + localclientnum);
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    n_wait = 0.5 / n_level;
    self.var_c6d5e93e = 0;
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        if (!isdefined(level.localplayers[localclientnum])) {
            return;
        }
        var_f0b23899 = function_508af4e9(localclientnum);
        playfx(localclientnum, level._effect["player_snow"], var_f0b23899[0], var_f0b23899[1]);
        wait(n_wait);
    }
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0x4c387ad, Offset: 0x6a70
// Size: 0x2f0
function function_2a8d9095(localclientnum) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    self.var_c6d5e93e = 1;
    if (localclientnum != 0) {
        return;
    }
    level notify("_lightning_thread" + localclientnum);
    level endon("_lightning_thread" + localclientnum);
    if (isdefined(localclientnum)) {
        self util::waittill_dobj(localclientnum);
        while (isdefined(self.var_c6d5e93e) && self.var_c6d5e93e) {
            var_a1ea2307 = self.angles;
            v_forward = anglestoforward(self.angles) * 25000;
            v_end_pos = self.origin + (v_forward[0], v_forward[1], 0);
            v_offset = (randomintrange(-5000, 5000), randomintrange(-5000, 5000), randomint(3000));
            v_end_pos += v_offset;
            exploder::exploder("fxexp_400");
            playsound(0, "amb_thunder_clap_zm", v_end_pos);
            util::server_wait(localclientnum, randomfloatrange(0.2, 0.3));
            self thread function_d4089806(localclientnum);
            var_41229005 = randomintrange(3, 5);
            for (i = 0; i < var_41229005; i++) {
                util::server_wait(localclientnum, 0.1);
                var_88b82cd3 = randomfloatrange(0.1, 0.35);
                playsound(0, "amb_thunder_flash_zm", v_end_pos);
            }
            self notify(#"hash_48ec464");
            util::server_wait(localclientnum, randomfloatrange(5, 10));
        }
    }
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0x8ce465df, Offset: 0x6d68
// Size: 0x120
function function_508af4e9(localclientnum) {
    var_bbb1872c = getlocalclienteyepos(localclientnum);
    var_4bde0ff5 = getlocalclientangles(localclientnum);
    var_4bde0ff5 = anglestoforward(var_4bde0ff5);
    var_4bde0ff5 = (var_4bde0ff5[0], var_4bde0ff5[1], 0);
    if (var_4bde0ff5[0] == 0 && var_4bde0ff5[1] == 0) {
        if (randomint(1) == 0) {
            var_4bde0ff5 = (0.01, 0.01, 0);
        } else {
            var_4bde0ff5 = (-0.01, -0.01, 0);
        }
    }
    var_f0b23899 = [];
    var_f0b23899[0] = var_bbb1872c;
    var_f0b23899[1] = var_4bde0ff5;
    return var_f0b23899;
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0x58c0165b, Offset: 0x6e90
// Size: 0x2a
function function_d4089806(localclientnum) {
    self endon(#"hash_48ec464");
    self waittill("_lightning_thread" + localclientnum);
}

// Namespace zm_tomb
// Params 5, eflags: 0x0
// Checksum 0xc0c90fd0, Offset: 0x6ec8
// Size: 0x164
function lerp_dvar(str_dvar, n_val, n_lerp_time, b_saved_dvar, localclientnum) {
    n_start_val = getdvarfloat(str_dvar);
    n_time_delta = 0;
    do {
        util::server_wait(localclientnum, 0.05);
        n_time_delta += 0.05;
        n_curr_val = lerpfloat(n_start_val, n_val, n_time_delta / n_lerp_time);
        if (isdefined(b_saved_dvar) && b_saved_dvar) {
            setsaveddvar(str_dvar, n_curr_val);
            continue;
        }
        setdvar(str_dvar, n_curr_val);
    } while (n_time_delta < n_lerp_time);
    if (isdefined(b_saved_dvar) && b_saved_dvar) {
        setsaveddvar(str_dvar, n_val);
        return;
    }
    setdvar(str_dvar, n_val);
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x3569f3e8, Offset: 0x7038
// Size: 0x21c
function function_d89b75a4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    a_structs = struct::get_array("foot_box_pos", "targetname");
    s_box = arraygetclosest(self.origin, a_structs);
    e_fx = spawn(localclientnum, self gettagorigin("J_SpineUpper"), "script_model");
    e_fx setmodel("tag_origin");
    e_fx playsound(localclientnum, "zmb_squest_charge_soul_leave");
    e_fx playloopsound("zmb_squest_charge_soul_lp");
    playfxontag(localclientnum, level._effect["staff_soul"], e_fx, "tag_origin");
    e_fx moveto(s_box.origin, 1);
    e_fx waittill(#"movedone");
    playsound(localclientnum, "zmb_squest_charge_soul_impact", e_fx.origin);
    playfxontag(localclientnum, level._effect["staff_charge"], e_fx, "tag_origin");
    wait(0.3);
    e_fx delete();
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0xe3443a39, Offset: 0x7260
// Size: 0x1be
function function_d4976b7d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    self util::waittill_dobj(localclientnum);
    if (newval == 1) {
        if (!isdefined(self.fx_glow)) {
            self.fx_glow = playfxontag(localclientnum, level._effect["foot_box_glow"], self, "tag_origin");
            self thread function_91953add(localclientnum);
        }
        if (!isdefined(self.sndent)) {
            self.sndent = spawn(0, self.origin, "script_origin");
            self.sndent playloopsound("zmb_footprintbox_glow_lp", 1);
            self.sndent thread function_3a4d4e97();
        }
        return;
    }
    if (isdefined(self.fx_glow)) {
        stopfx(localclientnum, self.fx_glow);
        self.fx_glow = undefined;
        self thread function_526683dc(localclientnum);
    }
    if (isdefined(self.sndent)) {
        self.sndent delete();
        self.sndent = undefined;
    }
}

// Namespace zm_tomb
// Params 0, eflags: 0x1 linked
// Checksum 0x4c5c73f1, Offset: 0x7428
// Size: 0x34
function function_3a4d4e97() {
    self endon(#"entityshutdown");
    level waittill(#"demo_jump");
    self delete();
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0x3dce0b30, Offset: 0x7468
// Size: 0x10a
function function_91953add(localclientnum) {
    self endon(#"entityshutdown");
    self mapshaderconstant(localclientnum, 0, "ScriptVector1");
    s_timer = new_timer(localclientnum);
    var_dbee3979 = 1;
    do {
        util::server_wait(localclientnum, 0.11);
        n_current_time = s_timer get_time_in_seconds();
        var_af412d0a = lerpfloat(1, 0, n_current_time / var_dbee3979);
        self setshaderconstant(localclientnum, 0, var_af412d0a, 0, 0, 0);
    } while (n_current_time < var_dbee3979);
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0x952b828a, Offset: 0x7580
// Size: 0x10a
function function_526683dc(localclientnum) {
    self endon(#"entityshutdown");
    self mapshaderconstant(localclientnum, 0, "ScriptVector1");
    s_timer = new_timer(localclientnum);
    var_dbee3979 = 1;
    do {
        util::server_wait(localclientnum, 0.11);
        n_current_time = s_timer get_time_in_seconds();
        var_af412d0a = lerpfloat(0, 1, n_current_time / var_dbee3979);
        self setshaderconstant(localclientnum, 0, var_af412d0a, 0, 0, 0);
    } while (n_current_time < var_dbee3979);
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0x1add694a, Offset: 0x7698
// Size: 0x50
function function_ec23b7a7(localclientnum) {
    while (isdefined(self)) {
        util::server_wait(localclientnum, 0.016);
        self.n_time_current += 0.016;
    }
}

// Namespace zm_tomb
// Params 1, eflags: 0x1 linked
// Checksum 0x394a2f, Offset: 0x76f0
// Size: 0x58
function new_timer(localclientnum) {
    s_timer = spawnstruct();
    s_timer.n_time_current = 0;
    s_timer thread function_ec23b7a7(localclientnum);
    return s_timer;
}

// Namespace zm_tomb
// Params 0, eflags: 0x0
// Checksum 0x26f72387, Offset: 0x7750
// Size: 0x10
function get_time() {
    return self.n_time_current * 1000;
}

// Namespace zm_tomb
// Params 0, eflags: 0x1 linked
// Checksum 0x93ff51ec, Offset: 0x7768
// Size: 0xa
function get_time_in_seconds() {
    return self.n_time_current;
}

// Namespace zm_tomb
// Params 0, eflags: 0x0
// Checksum 0xe3db4217, Offset: 0x7780
// Size: 0x10
function function_799c46b8() {
    self.n_time_current = 0;
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x2dbd555d, Offset: 0x7798
// Size: 0xa4
function function_6b9d2513(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 1, 1, 0);
        return;
    }
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x20d5f734, Offset: 0x7848
// Size: 0xe4
function function_b3ff5e6d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        where = self gettagorigin("J_SpineLower");
        if (!isdefined(where)) {
            where = self.origin;
        }
        if (isdefined(level._effect["zombie_guts_explosion"]) && util::is_mature()) {
            playfx(localclientnum, level._effect["zombie_guts_explosion"], where);
        }
    }
}

// Namespace zm_tomb
// Params 7, eflags: 0x1 linked
// Checksum 0x5a927049, Offset: 0x7938
// Size: 0xdc
function function_e20b060c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
    if (newval) {
        if (isdefined(self) && isdefined(self._aitype) && self._aitype == "zm_tomb_basic_crusader") {
            self._eyeglow_fx_override = level._effect["eye_glow_blue"];
            self zm::deletezombieeyes(localclientnum);
            self zm::createzombieeyes(localclientnum);
            self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, level.var_7d2be23b, 0);
        }
    }
}

