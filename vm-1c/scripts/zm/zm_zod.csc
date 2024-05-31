#using scripts/zm/_zm_ai_wasp;
#using scripts/zm/_zm_ai_raps;
#using scripts/zm/craftables/_zm_craft_shield;
#using scripts/zm/_zm_altbody_beast;
#using scripts/zm/zm_zod_traps;
#using scripts/zm/zm_zod_transformer;
#using scripts/zm/zm_zod_train;
#using scripts/zm/zm_zod_sword_quest;
#using scripts/zm/zm_zod_robot;
#using scripts/zm/zm_zod_quest;
#using scripts/zm/zm_zod_portals;
#using scripts/zm/zm_zod_pods;
#using scripts/zm/zm_zod_fx;
#using scripts/zm/zm_zod_ffotd;
#using scripts/zm/zm_zod_ee_side;
#using scripts/zm/zm_zod_ee;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_bonus_points_team;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/zm_zod_perks;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/aats/_zm_aat_blast_furnace;
#using scripts/zm/aats/_zm_aat_turned;
#using scripts/zm/archetype_zod_companion;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_weap_rocketshield;
#using scripts/zm/_zm_weap_idgun;
#using scripts/zm/_zm_weap_glaive;
#using scripts/zm/_zm_weap_tesla;
#using scripts/zm/_zm_weap_octobomb;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_magicbox_zod;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/vehicles/_glaive;
#using scripts/zm/zm_zod_util;
#using scripts/zm/zm_zod_idgun_quest;
#using scripts/zm/zm_zod_craftables;
#using scripts/zm/zm_zod_amb;
#using scripts/shared/ai/margwa;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/duplicaterender_mgr;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace zm_zod;

// Namespace zm_zod
// Params 0, eflags: 0x2
// namespace_bcfa45b0<file_0>::function_8e134dbe
// Checksum 0xfd3f7874, Offset: 0x17c0
// Size: 0x1c
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
}

// Namespace zm_zod
// Params 0, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_d290ebfa
// Checksum 0x4850d5db, Offset: 0x17e8
// Size: 0x364
function main() {
    namespace_b65ec48a::main_start();
    forcestreamxmodel("p7_zm_vending_widows_wine");
    forcestreamxmodel("p7_zm_vending_jugg");
    forcestreamxmodel("p7_zm_vending_sleight");
    forcestreamxmodel("p7_zm_vending_three_gun");
    level.var_6f8e5f09 = [];
    array::add(level.var_6f8e5f09, "boxer");
    array::add(level.var_6f8e5f09, "detective");
    array::add(level.var_6f8e5f09, "femme");
    array::add(level.var_6f8e5f09, "magician");
    register_clientfields();
    level.setupcustomcharacterexerts = &setup_personality_character_exerts;
    level.debug_keyline_zombies = 0;
    namespace_47b9c241::main();
    level._effect["eye_glow"] = "zombie/fx_glow_eye_orange_zod";
    level._effect["headshot"] = "zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect["headshot_nochunks"] = "zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect["bloodspurt"] = "zombie/fx_bul_flesh_neck_spurt_zmb";
    level._effect["animscript_gib_fx"] = "zombie/fx_blood_torso_explo_zmb";
    level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
    level._effect["rain_light"] = "weather/fx_rain_system_lite_runner";
    level._effect["rain_medium"] = "weather/fx_rain_system_med_runner";
    level._effect["rain_heavy"] = "weather/fx_rain_system_hvy_runner";
    level._effect["rain_acid"] = "weather/fx_rain_system_hvy_acid_zod";
    level._uses_sticky_grenades = 1;
    level._uses_taser_knuckles = 1;
    include_weapons();
    namespace_cfbe948b::init();
    namespace_4624f91a::function_3ebec56b();
    namespace_4624f91a::function_95743e9f();
    namespace_bb738c6::init();
    load::main();
    thread namespace_c3257ae1::main();
    callback::on_spawned(&on_player_spawned);
    duplicate_render::set_dr_filter_framebuffer("zod_ghost", 90, "zod_ghost", undefined, 0, "mc/hud_zod_ghost", 0);
    namespace_b65ec48a::main_end();
    util::waitforclient(0);
}

// Namespace zm_zod
// Params 0, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_4ece4a2f
// Checksum 0x81e3c41d, Offset: 0x1b58
// Size: 0x5cc
function register_clientfields() {
    clientfield::register("toplayer", "fullscreen_rain_fx", 1, 1, "int", &function_40c5bbcf, 0, 1);
    clientfield::register("world", "rain_state", 1, 1, "int", undefined, 0, 0);
    clientfield::register("world", "junction_crane_state", 1, 1, "int", &function_b339a5f5, 0, 1);
    clientfield::register("toplayer", "devgui_lightning_test", 1, 1, "counter", &function_2cf3dd37, 0, 0);
    n_bits = getminbitcountfornum(8);
    clientfield::register("toplayer", "player_rumble_and_shake", 1, n_bits, "int", &namespace_8e578893::function_f118a0e7, 0, 0);
    clientfield::register("actor", "ghost_actor", 1, 1, "int", &function_b48f294, 0, 0);
    n_bits = getminbitcountfornum(4);
    clientfield::register("clientuimodel", "zmInventory.player_character_identity", 1, n_bits, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.player_using_sprayer", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.player_crafted_fusebox", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.player_crafted_shield", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.player_crafted_idgun", 1, 1, "int", undefined, 0, 0);
    n_bits = getminbitcountfornum(7);
    clientfield::register("clientuimodel", "zmInventory.player_sword_quest_egg_state", 1, n_bits, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.player_sword_quest_completed_level_1", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.widget_quest_items", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.widget_idgun_parts", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.widget_shield_parts", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.widget_fuses", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.widget_egg", 1, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.widget_sprayer", 1, 1, "int", undefined, 0, 0);
    clientfield::register("world", "hide_perf_static_models", 1, 1, "int", &function_f8cdd387, 0, 1);
    clientfield::register("world", "breakable_show", 1, 3, "int", &function_66fdd0a3, 0, 1);
    clientfield::register("world", "breakable_hide", 1, 3, "int", &function_5a6fb328, 0, 1);
    visionset_mgr::register_visionset_info("zombie_noire", 1, 1, undefined, "zombie_noire");
}

// Namespace zm_zod
// Params 1, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_aebcf025
// Checksum 0x888e40ec, Offset: 0x2130
// Size: 0xb4
function on_player_spawned(localclientnum) {
    if (self == getlocalplayer(localclientnum)) {
        self thread function_48d14da2(localclientnum);
        if (!isdemoplaying() || getdemoversion() >= 8) {
            util::spawn_model(localclientnum, "p7_zm_zod_cipher_06", (2600.75, -3538, -364.75), (110, -76, 0));
        }
    }
}

// Namespace zm_zod
// Params 7, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_40c5bbcf
// Checksum 0x408fd6c8, Offset: 0x21f0
// Size: 0x84
function function_40c5bbcf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        println("actor");
        return;
    }
    println("fxanim_crate_junction_static");
}

// Namespace zm_zod
// Params 1, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_48d14da2
// Checksum 0xf5a5366e, Offset: 0x2280
// Size: 0x158
function function_48d14da2(localclientnum) {
    self endon(#"disconnect");
    self endon(#"entityshutdown");
    if (!self islocalplayer() || !isdefined(self getlocalclientnumber()) || localclientnum != self getlocalclientnumber()) {
        return;
    }
    while (true) {
        if (!isdefined(self)) {
            return;
        }
        var_53729670 = level clientfield::get("rain_state");
        if (var_53729670 === 1) {
            fxid = playfx(localclientnum, level._effect["rain_acid"], self.origin);
        } else {
            fxid = playfx(localclientnum, level._effect["rain_heavy"], self.origin);
        }
        setfxoutdoor(localclientnum, fxid);
        wait(0.25);
    }
}

// Namespace zm_zod
// Params 7, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_b339a5f5
// Checksum 0x87889480, Offset: 0x23e0
// Size: 0x29c
function function_b339a5f5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    wait(0.016);
    var_4cec7cba = getent(localclientnum, "junction_crane_crate_phrase", "targetname");
    var_1da6fd34 = getent(localclientnum, "quest_personal_item_junction_crane", "targetname");
    e_crate = getent(localclientnum, "junction_crane_crate", "targetname");
    var_385d73c3 = findstaticmodelindexarray("fxanim_crate_junction_break_static");
    hidestaticmodel(var_385d73c3[0]);
    var_3153c901 = findstaticmodelindexarray("fxanim_junction_crane_static");
    if (newval == 1) {
        hidestaticmodel(var_3153c901[0]);
        var_49dac624 = findstaticmodelindexarray("fxanim_crate_junction_static");
        hidestaticmodel(var_49dac624[0]);
        level thread function_8db965a5(var_385d73c3[0]);
        scene::play("p7_fxanim_zm_zod_crate_breakable_03_junction_bundle");
        unhidestaticmodel(var_3153c901[0]);
        return;
    }
    unhidestaticmodel(var_3153c901[0]);
    if (isdefined(var_1da6fd34)) {
        playfxontag(localclientnum, level._effect["crane_light"], var_1da6fd34, "j_light");
    }
    if (isdefined(var_4cec7cba)) {
        playfxontag(localclientnum, level._effect["cultist_crate_personal_item"], var_4cec7cba, "tag_origin");
    }
}

// Namespace zm_zod
// Params 1, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_8db965a5
// Checksum 0x58d8fa7, Offset: 0x2688
// Size: 0x2c
function function_8db965a5(var_df899b02) {
    wait(9.5);
    unhidestaticmodel(var_df899b02);
}

// Namespace zm_zod
// Params 0, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_6e1af22d
// Checksum 0x3e06a848, Offset: 0x26c0
// Size: 0x34
function include_weapons() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_zod_weapons.csv", 1);
    zm_weapons::function_9e8dccbe();
}

// Namespace zm_zod
// Params 0, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_80f102b1
// Checksum 0x5080ca6a, Offset: 0x2700
// Size: 0x107a
function setup_personality_character_exerts() {
    level.exert_sounds[1]["playerbreathinsound"][2] = "vox_plr_0_exert_inhale";
    level.exert_sounds[2]["playerbreathinsound"][2] = "vox_plr_1_exert_inhale";
    level.exert_sounds[3]["playerbreathinsound"][2] = "vox_plr_2_exert_inhale";
    level.exert_sounds[4]["playerbreathinsound"][2] = "vox_plr_3_exert_inhale";
    level.exert_sounds[1]["playerbreathoutsound"][2] = "vox_plr_0_exert_exhale";
    level.exert_sounds[2]["playerbreathoutsound"][2] = "vox_plr_1_exert_exhale";
    level.exert_sounds[3]["playerbreathoutsound"][2] = "vox_plr_2_exert_exhale";
    level.exert_sounds[4]["playerbreathoutsound"][2] = "vox_plr_3_exert_exhale";
    level.exert_sounds[1]["playerbreathgaspsound"][0] = "vox_plr_0_exert_gasp";
    level.exert_sounds[2]["playerbreathgaspsound"][0] = "vox_plr_1_exert_gasp";
    level.exert_sounds[3]["playerbreathgaspsound"][0] = "vox_plr_2_exert_gasp";
    level.exert_sounds[4]["playerbreathgaspsound"][0] = "vox_plr_3_exert_gasp";
    level.exert_sounds[1]["falldamage"][0] = "vox_plr_0_exert_bit_0";
    level.exert_sounds[1]["falldamage"][1] = "vox_plr_0_exert_bit_1";
    level.exert_sounds[1]["falldamage"][2] = "vox_plr_0_exert_bit_2";
    level.exert_sounds[1]["falldamage"][3] = "vox_plr_0_exert_bit_3";
    level.exert_sounds[1]["falldamage"][4] = "vox_plr_0_exert_pain_0";
    level.exert_sounds[1]["falldamage"][5] = "vox_plr_0_exert_pain_1";
    level.exert_sounds[1]["falldamage"][6] = "vox_plr_0_exert_pain_2";
    level.exert_sounds[1]["falldamage"][7] = "vox_plr_0_exert_pain_3";
    level.exert_sounds[1]["falldamage"][8] = "vox_plr_0_exert_pain_4";
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
    level.exert_sounds[4]["falldamage"][5] = "vox_plr_3_exert_bit_0";
    level.exert_sounds[4]["falldamage"][6] = "vox_plr_3_exert_bit_1";
    level.exert_sounds[4]["falldamage"][7] = "vox_plr_3_exert_bit_2";
    level.exert_sounds[4]["falldamage"][8] = "vox_plr_3_exert_bit_3";
    level.exert_sounds[4]["falldamage"][9] = "vox_plr_3_exert_bit_4";
    level.exert_sounds[4]["falldamage"][10] = "vox_plr_3_exert_bit_6";
    level.exert_sounds[4]["falldamage"][11] = "vox_plr_3_exert_bit_7";
    level.exert_sounds[4]["falldamage"][12] = "vox_plr_3_exert_bit_8";
    level.exert_sounds[4]["falldamage"][13] = "vox_plr_3_exert_bit_9";
    level.exert_sounds[4]["falldamage"][14] = "vox_plr_3_exert_bit_10";
    level.exert_sounds[1]["meleeswipesoundplayer"][0] = "vox_plr_0_exert_charge_0";
    level.exert_sounds[1]["meleeswipesoundplayer"][1] = "vox_plr_0_exert_charge_1";
    level.exert_sounds[1]["meleeswipesoundplayer"][2] = "vox_plr_0_exert_charge_2";
    level.exert_sounds[1]["meleeswipesoundplayer"][3] = "vox_plr_0_exert_charge_3";
    level.exert_sounds[1]["meleeswipesoundplayer"][4] = "vox_plr_0_exert_melee_0";
    level.exert_sounds[1]["meleeswipesoundplayer"][5] = "vox_plr_0_exert_melee_1";
    level.exert_sounds[1]["meleeswipesoundplayer"][6] = "vox_plr_0_exert_melee_2";
    level.exert_sounds[1]["meleeswipesoundplayer"][7] = "vox_plr_0_exert_melee_3";
    level.exert_sounds[1]["meleeswipesoundplayer"][8] = "vox_plr_0_exert_melee_4";
    level.exert_sounds[2]["meleeswipesoundplayer"][0] = "vox_plr_1_exert_charge_2";
    level.exert_sounds[2]["meleeswipesoundplayer"][1] = "vox_plr_1_exert_charge_3";
    level.exert_sounds[2]["meleeswipesoundplayer"][2] = "vox_plr_1_exert_melee_0";
    level.exert_sounds[2]["meleeswipesoundplayer"][3] = "vox_plr_1_exert_melee_1";
    level.exert_sounds[2]["meleeswipesoundplayer"][4] = "vox_plr_1_exert_melee_2";
    level.exert_sounds[2]["meleeswipesoundplayer"][5] = "vox_plr_1_exert_melee_3";
    level.exert_sounds[2]["meleeswipesoundplayer"][6] = "vox_plr_1_exert_melee_4";
    level.exert_sounds[3]["meleeswipesoundplayer"][0] = "vox_plr_2_exert_charge_0";
    level.exert_sounds[3]["meleeswipesoundplayer"][1] = "vox_plr_2_exert_charge_1";
    level.exert_sounds[3]["meleeswipesoundplayer"][2] = "vox_plr_2_exert_melee_0";
    level.exert_sounds[3]["meleeswipesoundplayer"][3] = "vox_plr_2_exert_melee_1";
    level.exert_sounds[3]["meleeswipesoundplayer"][4] = "vox_plr_2_exert_melee_2";
    level.exert_sounds[3]["meleeswipesoundplayer"][5] = "vox_plr_2_exert_melee_3";
    level.exert_sounds[3]["meleeswipesoundplayer"][6] = "vox_plr_2_exert_melee_4";
    level.exert_sounds[4]["meleeswipesoundplayer"][0] = "vox_plr_3_exert_melee_0";
    level.exert_sounds[4]["meleeswipesoundplayer"][1] = "vox_plr_3_exert_melee_1";
    level.exert_sounds[4]["meleeswipesoundplayer"][2] = "vox_plr_3_exert_melee_2";
    level.exert_sounds[4]["meleeswipesoundplayer"][3] = "vox_plr_3_exert_melee_4";
    level.exert_sounds[1]["dtplandsoundplayer"][0] = "vox_plr_0_exert_bit_0";
    level.exert_sounds[1]["dtplandsoundplayer"][1] = "vox_plr_0_exert_bit_1";
    level.exert_sounds[1]["dtplandsoundplayer"][2] = "vox_plr_0_exert_bit_2";
    level.exert_sounds[1]["dtplandsoundplayer"][3] = "vox_plr_0_exert_bit_3";
    level.exert_sounds[1]["dtplandsoundplayer"][4] = "vox_plr_0_exert_pain_0";
    level.exert_sounds[1]["dtplandsoundplayer"][5] = "vox_plr_0_exert_pain_1";
    level.exert_sounds[1]["dtplandsoundplayer"][6] = "vox_plr_0_exert_pain_2";
    level.exert_sounds[1]["dtplandsoundplayer"][7] = "vox_plr_0_exert_pain_3";
    level.exert_sounds[1]["dtplandsoundplayer"][8] = "vox_plr_0_exert_pain_4";
    level.exert_sounds[2]["dtplandsoundplayer"][0] = "vox_plr_1_exert_pain_0";
    level.exert_sounds[2]["dtplandsoundplayer"][1] = "vox_plr_1_exert_pain_1";
    level.exert_sounds[2]["dtplandsoundplayer"][2] = "vox_plr_1_exert_pain_2";
    level.exert_sounds[2]["dtplandsoundplayer"][3] = "vox_plr_1_exert_pain_3";
    level.exert_sounds[2]["dtplandsoundplayer"][4] = "vox_plr_1_exert_pain_4";
    level.exert_sounds[3]["dtplandsoundplayer"][0] = "vox_plr_2_exert_pain_0";
    level.exert_sounds[3]["dtplandsoundplayer"][1] = "vox_plr_2_exert_pain_1";
    level.exert_sounds[3]["dtplandsoundplayer"][2] = "vox_plr_2_exert_pain_2";
    level.exert_sounds[3]["dtplandsoundplayer"][3] = "vox_plr_2_exert_pain_3";
    level.exert_sounds[3]["dtplandsoundplayer"][4] = "vox_plr_2_exert_pain_4";
    level.exert_sounds[4]["dtplandsoundplayer"][0] = "vox_plr_3_exert_pain_0";
    level.exert_sounds[4]["dtplandsoundplayer"][1] = "vox_plr_3_exert_pain_1";
    level.exert_sounds[4]["dtplandsoundplayer"][2] = "vox_plr_3_exert_pain_2";
    level.exert_sounds[4]["dtplandsoundplayer"][3] = "vox_plr_3_exert_pain_3";
    level.exert_sounds[4]["dtplandsoundplayer"][4] = "vox_plr_3_exert_pain_4";
    level.exert_sounds[4]["dtplandsoundplayer"][5] = "vox_plr_3_exert_bit_0";
    level.exert_sounds[4]["dtplandsoundplayer"][6] = "vox_plr_3_exert_bit_1";
    level.exert_sounds[4]["dtplandsoundplayer"][7] = "vox_plr_3_exert_bit_2";
    level.exert_sounds[4]["dtplandsoundplayer"][8] = "vox_plr_3_exert_bit_3";
    level.exert_sounds[4]["dtplandsoundplayer"][9] = "vox_plr_3_exert_bit_4";
    level.exert_sounds[4]["dtplandsoundplayer"][10] = "vox_plr_3_exert_bit_6";
    level.exert_sounds[4]["dtplandsoundplayer"][11] = "vox_plr_3_exert_bit_7";
    level.exert_sounds[4]["dtplandsoundplayer"][12] = "vox_plr_3_exert_bit_8";
    level.exert_sounds[4]["dtplandsoundplayer"][13] = "vox_plr_3_exert_bit_9";
    level.exert_sounds[4]["dtplandsoundplayer"][14] = "vox_plr_3_exert_bit_10";
}

// Namespace zm_zod
// Params 7, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_7d846745
// Checksum 0xa2299820, Offset: 0x3788
// Size: 0x1ae
function function_7d846745(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_3082faeb = findstaticmodelindexarray("pap_weed");
    if (newval == 1) {
        foreach (i, model in var_3082faeb) {
            unhidestaticmodel(model);
            if (i % 25 == 0) {
                wait(0.016);
            }
        }
        return;
    }
    foreach (i, model in var_3082faeb) {
        hidestaticmodel(model);
        if (i % 10 == 0) {
            wait(0.016);
        }
    }
}

// Namespace zm_zod
// Params 7, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_2cf3dd37
// Checksum 0xc24e7569, Offset: 0x3940
// Size: 0x184
function function_2cf3dd37(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setukkoscriptindex(localclientnum, 2, 1);
    exploder::exploder("fx_exploder_lightning_dock");
    playsound(0, "amb_lightning_dist_low", (0, 0, 0));
    wait(0.15);
    setukkoscriptindex(localclientnum, 3, 1);
    wait(0.2);
    setukkoscriptindex(localclientnum, 2, 1);
    wait(0.1);
    setukkoscriptindex(localclientnum, 3, 1);
    wait(0.25);
    setukkoscriptindex(localclientnum, 4, 1);
    wait(0.05);
    setukkoscriptindex(localclientnum, 5, 1);
    wait(0.05);
    setukkoscriptindex(localclientnum, 1, 1);
}

// Namespace zm_zod
// Params 7, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_f650f42a
// Checksum 0xdd510285, Offset: 0x3ad0
// Size: 0xfc
function function_f650f42a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (self isplayer() && self islocalplayer() && !isdemoplaying()) {
        if (!isdefined(self getlocalclientnumber()) || localclientnum == self getlocalclientnumber()) {
            return;
        }
    }
    self duplicate_render::set_dr_flag("zod_ghost", newval);
    self duplicate_render::update_dr_filters(localclientnum);
}

// Namespace zm_zod
// Params 7, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_b48f294
// Checksum 0x8ede04d, Offset: 0x3bd8
// Size: 0x74
function function_b48f294(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    self duplicate_render::set_dr_flag("zod_ghost", newval);
    self duplicate_render::update_dr_filters(localclientnum);
}

// Namespace zm_zod
// Params 7, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_f8cdd387
// Checksum 0x43fda5a5, Offset: 0x3c58
// Size: 0x264
function function_f8cdd387(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    var_bc94ac00 = findstaticmodelindexarray("fxanim_crate_waterfront_break_static");
    var_90dba62a = findstaticmodelindexarray("fxanim_crate_canal_static");
    for (i = 0; i < var_bc94ac00.size; i++) {
        hidestaticmodel(var_bc94ac00[i]);
    }
    for (i = 0; i < var_90dba62a.size; i++) {
        hidestaticmodel(var_90dba62a[i]);
    }
    var_48d31804 = findstaticmodelindexarray("fxanim_pap_bridge_01_static");
    hidestaticmodel(var_48d31804[0]);
    var_48d31804 = findstaticmodelindexarray("fxanim_pap_bridge_02_static");
    hidestaticmodel(var_48d31804[0]);
    var_48d31804 = findstaticmodelindexarray("fxanim_crate_footlight_static");
    hidestaticmodel(var_48d31804[0]);
    var_48d31804 = findstaticmodelindexarray("fxanim_crate_footlight_break_static");
    hidestaticmodel(var_48d31804[0]);
    var_48d31804 = findstaticmodelindexarray("fxanim_crate_start_static");
    hidestaticmodel(var_48d31804[0]);
    var_48d31804 = findstaticmodelindexarray("fxanim_crate_start_break_static");
    hidestaticmodel(var_48d31804[0]);
}

// Namespace zm_zod
// Params 7, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_66fdd0a3
// Checksum 0x23b06917, Offset: 0x3ec8
// Size: 0xde
function function_66fdd0a3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        var_48d31804 = findstaticmodelindexarray("fxanim_crate_start_static");
        unhidestaticmodel(var_48d31804[0]);
        break;
    case 2:
        var_48d31804 = findstaticmodelindexarray("fxanim_crate_start_break_static");
        unhidestaticmodel(var_48d31804[0]);
        break;
    }
}

// Namespace zm_zod
// Params 7, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_5a6fb328
// Checksum 0xe526335, Offset: 0x3fb0
// Size: 0xde
function function_5a6fb328(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    switch (newval) {
    case 1:
        var_48d31804 = findstaticmodelindexarray("fxanim_crate_start_static");
        hidestaticmodel(var_48d31804[0]);
        break;
    case 2:
        var_48d31804 = findstaticmodelindexarray("fxanim_crate_start_break_static");
        hidestaticmodel(var_48d31804[0]);
        break;
    }
}

