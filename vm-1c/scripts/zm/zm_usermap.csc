#using scripts/codescripts/struct;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm_ai_dogs;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_trap_electric;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_gravityspikes;
#using scripts/zm/_zm_weap_octobomb;
#using scripts/zm/_zm_weap_raygun_mark3;
#using scripts/zm/_zm_weap_rocketshield;
#using scripts/zm/_zm_weap_tesla;
#using scripts/zm/_zm_weap_thundergun;
#using scripts/zm/_zm_weapons;

#namespace zm_usermap;

// Namespace zm_usermap
// Params 0, eflags: 0x2
// Checksum 0x32e72154, Offset: 0xbd0
// Size: 0x34
function autoexec opt_in() {
    if (!isdefined(level.aat_in_use)) {
        level.aat_in_use = 1;
    }
    if (!isdefined(level.bgb_in_use)) {
        level.bgb_in_use = 1;
    }
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0xb470257f, Offset: 0xc10
// Size: 0x11c
function main() {
    level.setupcustomcharacterexerts = &setup_personality_character_exerts;
    level._effect["eye_glow"] = "zombie/fx_glow_eye_orange";
    level._effect["headshot"] = "zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect["headshot_nochunks"] = "zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect["bloodspurt"] = "zombie/fx_bul_flesh_neck_spurt_zmb";
    level._effect["animscript_gib_fx"] = "zombie/fx_blood_torso_explo_zmb";
    level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
    level.debug_keyline_zombies = 0;
    include_weapons();
    function_50a4ff91();
    load::main();
    _zm_weap_cymbal_monkey::init();
    _zm_weap_tesla::init();
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0x3d7bd04d, Offset: 0xd38
// Size: 0x24
function include_weapons() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0x5739b546, Offset: 0xd68
// Size: 0xc6
function function_50a4ff91() {
    level._effect["jugger_light"] = "zombie/fx_perk_juggernaut_factory_zmb";
    level._effect["revive_light"] = "zombie/fx_perk_quick_revive_factory_zmb";
    level._effect["sleight_light"] = "zombie/fx_perk_sleight_of_hand_factory_zmb";
    level._effect["doubletap2_light"] = "zombie/fx_perk_doubletap2_factory_zmb";
    level._effect["deadshot_light"] = "zombie/fx_perk_daiquiri_factory_zmb";
    level._effect["marathon_light"] = "zombie/fx_perk_stamin_up_factory_zmb";
    level._effect["additionalprimaryweapon_light"] = "zombie/fx_perk_mule_kick_factory_zmb";
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0x3417782f, Offset: 0xe38
// Size: 0x622
function setup_personality_character_exerts() {
    level.exert_sounds[1]["falldamage"][0] = "vox_plr_0_exert_pain_0";
    level.exert_sounds[1]["falldamage"][1] = "vox_plr_0_exert_pain_1";
    level.exert_sounds[1]["falldamage"][2] = "vox_plr_0_exert_pain_2";
    level.exert_sounds[1]["falldamage"][3] = "vox_plr_0_exert_pain_3";
    level.exert_sounds[1]["falldamage"][4] = "vox_plr_0_exert_pain_4";
    level.exert_sounds[2]["falldamage"][0] = "vox_plr_1_exert_pain_0";
    level.exert_sounds[2]["falldamage"][1] = "vox_plr_1_exert_pain_1";
    level.exert_sounds[2]["falldamage"][2] = "vox_plr_1_exert_pain_2";
    level.exert_sounds[2]["falldamage"][3] = "vox_plr_1_exert_pain_3";
    level.exert_sounds[2]["falldamage"][4] = "vox_plr_1_exert_pain_4";
    level.exert_sounds[3]["falldamage"][0] = "vox_plr_2_exert_pain_0";
    level.exert_sounds[3]["falldamage"][1] = "vox_plr_2_exert_pain_1";
    level.exert_sounds[3]["falldamage"][2] = "vox_plr_2_exert_pain_2";
    level.exert_sounds[3]["falldamage"][3] = "vox_plr_2_exert_pain_3";
    level.exert_sounds[3]["falldamage"][4] = "vox_plr_2_exert_pain_4";
    level.exert_sounds[4]["falldamage"][0] = "vox_plr_3_exert_pain_0";
    level.exert_sounds[4]["falldamage"][1] = "vox_plr_3_exert_pain_1";
    level.exert_sounds[4]["falldamage"][2] = "vox_plr_3_exert_pain_2";
    level.exert_sounds[4]["falldamage"][3] = "vox_plr_3_exert_pain_3";
    level.exert_sounds[4]["falldamage"][4] = "vox_plr_3_exert_pain_4";
    level.exert_sounds[1]["meleeswipesoundplayer"][0] = "vox_plr_0_exert_melee_0";
    level.exert_sounds[1]["meleeswipesoundplayer"][1] = "vox_plr_0_exert_melee_1";
    level.exert_sounds[1]["meleeswipesoundplayer"][2] = "vox_plr_0_exert_melee_2";
    level.exert_sounds[1]["meleeswipesoundplayer"][3] = "vox_plr_0_exert_melee_3";
    level.exert_sounds[1]["meleeswipesoundplayer"][4] = "vox_plr_0_exert_melee_4";
    level.exert_sounds[2]["meleeswipesoundplayer"][0] = "vox_plr_1_exert_melee_0";
    level.exert_sounds[2]["meleeswipesoundplayer"][1] = "vox_plr_1_exert_melee_1";
    level.exert_sounds[2]["meleeswipesoundplayer"][2] = "vox_plr_1_exert_melee_2";
    level.exert_sounds[2]["meleeswipesoundplayer"][3] = "vox_plr_1_exert_melee_3";
    level.exert_sounds[2]["meleeswipesoundplayer"][4] = "vox_plr_1_exert_melee_4";
    level.exert_sounds[3]["meleeswipesoundplayer"][0] = "vox_plr_2_exert_melee_0";
    level.exert_sounds[3]["meleeswipesoundplayer"][1] = "vox_plr_2_exert_melee_1";
    level.exert_sounds[3]["meleeswipesoundplayer"][2] = "vox_plr_2_exert_melee_2";
    level.exert_sounds[3]["meleeswipesoundplayer"][3] = "vox_plr_2_exert_melee_3";
    level.exert_sounds[3]["meleeswipesoundplayer"][4] = "vox_plr_2_exert_melee_4";
    level.exert_sounds[4]["meleeswipesoundplayer"][0] = "vox_plr_3_exert_melee_0";
    level.exert_sounds[4]["meleeswipesoundplayer"][1] = "vox_plr_3_exert_melee_1";
    level.exert_sounds[4]["meleeswipesoundplayer"][2] = "vox_plr_3_exert_melee_2";
    level.exert_sounds[4]["meleeswipesoundplayer"][3] = "vox_plr_3_exert_melee_3";
    level.exert_sounds[4]["meleeswipesoundplayer"][4] = "vox_plr_3_exert_melee_4";
}

