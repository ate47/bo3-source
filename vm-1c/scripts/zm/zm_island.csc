#using scripts/zm/zm_island_zones;
#using scripts/zm/zm_island_spider_ee_quest;
#using scripts/zm/zm_island_side_ee_golden_bucket;
#using scripts/zm/zm_island_side_ee_spore_hallucinations;
#using scripts/zm/zm_island_side_ee_secret_maxammo;
#using scripts/zm/zm_island_side_ee_good_thrasher;
#using scripts/zm/zm_island_side_ee_doppleganger;
#using scripts/zm/zm_island_side_ee_distant_monster;
#using scripts/zm/zm_island_takeo_fight;
#using scripts/zm/zm_island_skullweapon_quest;
#using scripts/zm/zm_island_ww_quest;
#using scripts/zm/zm_island_main_ee_quest;
#using scripts/zm/_zm_weap_keeper_skull;
#using scripts/zm/_zm_weap_mirg2000;
#using scripts/zm/zm_island_ffotd;
#using scripts/zm/zm_island_challenges;
#using scripts/zm/zm_island_inventory;
#using scripts/zm/zm_island_fx;
#using scripts/zm/zm_island_spider_quest;
#using scripts/zm/zm_island_pap_quest;
#using scripts/zm/zm_island_portals;
#using scripts/zm/zm_island_spores;
#using scripts/zm/zm_island_transport;
#using scripts/zm/zm_island_power;
#using scripts/zm/zm_island_planting;
#using scripts/zm/zm_island_traps;
#using scripts/zm/zm_island_dogfights;
#using scripts/zm/zm_island_craftables;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_empty_perk;
#using scripts/zm/_zm_powerup_bonus_points_team;
#using scripts/zm/_zm_powerup_bonus_points_player;
#using scripts/zm/_zm_powerup_island_seed;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/zm_island_perks;
#using scripts/zm/_zm_ai_thrasher;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/filter_shared;
#using scripts/shared/callbacks_shared;
#using scripts/zm/craftables/_zm_craft_shield;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_weap_island_shield;
#using scripts/zm/zm_island_amb;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_weap_controllable_spider;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_ai_spiders;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/postfx_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_island;

// Namespace zm_island
// Params 0, eflags: 0x2
// Checksum 0xe58084f2, Offset: 0x1b08
// Size: 0x1c
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
}

// Namespace zm_island
// Params 0, eflags: 0x1 linked
// Checksum 0x1f89a3f9, Offset: 0x1b30
// Size: 0x29c
function main() {
    namespace_711c2fc8::main_start();
    namespace_1a868593::main();
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    level.setupcustomcharacterexerts = &setup_personality_character_exerts;
    level._uses_sticky_grenades = 1;
    level._uses_taser_knuckles = 1;
    register_clientfields();
    include_weapons();
    level thread function_be61cf5a();
    namespace_e73c08bc::function_3ebec56b();
    namespace_e73c08bc::function_95743e9f();
    namespace_14c8b75c::init();
    namespace_eaae7728::init_quest();
    namespace_7550a904::init();
    namespace_f3e3de78::init();
    namespace_14b4d4ab::init();
    namespace_34c58dc::init();
    namespace_7a07aa2f::init();
    namespace_c8222934::init();
    namespace_5f2c95ae::init();
    namespace_78528370::init_quest();
    namespace_9d2fabb6::init();
    namespace_f7d4f63b::init();
    namespace_48e6dffb::init();
    namespace_13425205::init();
    namespace_bbfc4da3::init();
    namespace_6c640490::init();
    namespace_28a54cd6::init();
    namespace_f777c489::init();
    namespace_fdccf5c4::init();
    namespace_79fcd4bc::init();
    namespace_5a453011::init();
    load::main();
    level thread namespace_f67badb7::main();
    level thread namespace_9d2fabb6::main();
    util::waitforclient(0);
    level thread function_3a429aee();
    namespace_711c2fc8::main_end();
}

// Namespace zm_island
// Params 0, eflags: 0x1 linked
// Checksum 0xaada0dc2, Offset: 0x1dd8
// Size: 0x364
function register_clientfields() {
    var_ddba80d7 = getminbitcountfornum(3);
    clientfield::register("clientuimodel", "zmInventory.widget_shield_parts", 9000, 1, "int", undefined, 0, 0);
    clientfield::register("clientuimodel", "zmInventory.player_crafted_shield", 9000, 1, "int", undefined, 0, 0);
    clientfield::register("toplayer", "postfx_futz_mild", 9000, 1, "counter", &function_bf8650ca, 0, 0);
    clientfield::register("toplayer", "water_motes", 9000, 1, "int", &function_5cefaf77, 0, 0);
    clientfield::register("toplayer", "play_bubbles", 9000, 1, "int", &function_58e931d1, 0, 0);
    clientfield::register("toplayer", "set_world_fog", 9000, var_ddba80d7, "int", &function_346468e3, 0, 0);
    clientfield::register("toplayer", "speed_burst", 9000, 1, "int", &function_d6b43cb, 0, 1);
    clientfield::register("toplayer", "tp_water_sheeting", 9000, 1, "int", &function_6be6da89, 0, 0);
    clientfield::register("toplayer", "wind_blur", 9000, 1, "int", &function_4a01cc4e, 0, 0);
    clientfield::register("scriptmover", "set_heavy_web_fade_material", 9000, 1, "int", &function_e0aec577, 0, 0);
    clientfield::register("world", "force_stream_spiders", 9001, 1, "int", &function_e0410522, 0, 0);
    clientfield::register("world", "force_stream_takeo_arms", 11001, 1, "int", &function_e4587332, 0, 0);
}

// Namespace zm_island
// Params 0, eflags: 0x1 linked
// Checksum 0x95533335, Offset: 0x2148
// Size: 0x34
function include_weapons() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_island_weapons.csv", 1);
    zm_weapons::function_9e8dccbe();
}

// Namespace zm_island
// Params 0, eflags: 0x1 linked
// Checksum 0xfc5d7cdd, Offset: 0x2188
// Size: 0x1112
function setup_personality_character_exerts() {
    level.exert_sounds[1]["playerbreathinsound"][0] = "vox_plr_0_exert_inhale_0";
    level.exert_sounds[2]["playerbreathinsound"][0] = "vox_plr_1_exert_inhale_0";
    level.exert_sounds[3]["playerbreathinsound"][0] = "vox_plr_2_exert_inhale_0";
    level.exert_sounds[4]["playerbreathinsound"][0] = "vox_plr_3_exert_inhale_0";
    level.exert_sounds[1]["playerbreathoutsound"][0] = "vox_plr_0_exert_exhale_0";
    level.exert_sounds[2]["playerbreathoutsound"][0] = "vox_plr_1_exert_exhale_0";
    level.exert_sounds[3]["playerbreathoutsound"][0] = "vox_plr_2_exert_exhale_0";
    level.exert_sounds[4]["playerbreathoutsound"][0] = "vox_plr_3_exert_exhale_0";
    level.exert_sounds[1]["playerbreathgaspsound"][0] = "vox_plr_0_exert_exhale_0";
    level.exert_sounds[2]["playerbreathgaspsound"][0] = "vox_plr_1_exert_exhale_0";
    level.exert_sounds[3]["playerbreathgaspsound"][0] = "vox_plr_2_exert_exhale_0";
    level.exert_sounds[4]["playerbreathgaspsound"][0] = "vox_plr_3_exert_exhale_0";
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
    level.exert_sounds[2]["mantlesoundplayer"][6] = "vox_plr_1_exert_grunt_6";
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
    level.exert_sounds[4]["mantlesoundplayer"][3] = "vox_plr_3_exert_grunt_3";
    level.exert_sounds[4]["mantlesoundplayer"][4] = "vox_plr_3_exert_grunt_4";
    level.exert_sounds[4]["mantlesoundplayer"][5] = "vox_plr_3_exert_grunt_5";
    level.exert_sounds[4]["mantlesoundplayer"][6] = "vox_plr_3_exert_grunt_6";
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

// Namespace zm_island
// Params 7, eflags: 0x1 linked
// Checksum 0x1d1ed365, Offset: 0x32a8
// Size: 0x7c
function function_bf8650ca(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    player = getlocalplayer(localclientnum);
    player postfx::playpostfxbundle("pstfx_dni_interrupt_mild");
}

// Namespace zm_island
// Params 7, eflags: 0x1 linked
// Checksum 0x55b5f4ef, Offset: 0x3330
// Size: 0xde
function function_5cefaf77(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    wait(0.1);
    if (newval) {
        if (isdefined(self) && !isdefined(self.var_8e8c7340)) {
            self.var_8e8c7340 = playviewmodelfx(localclientnum, level._effect["water_motes"], "tag_camera");
        }
        return;
    }
    if (isdefined(self) && isdefined(self.var_8e8c7340)) {
        deletefx(localclientnum, self.var_8e8c7340, 1);
        self.var_8e8c7340 = undefined;
    }
}

// Namespace zm_island
// Params 7, eflags: 0x1 linked
// Checksum 0x52d7e579, Offset: 0x3418
// Size: 0x7c
function function_58e931d1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        self thread function_6e954d4(localclientnum);
        return;
    }
    self thread function_6fb5501(localclientnum);
}

// Namespace zm_island
// Params 1, eflags: 0x1 linked
// Checksum 0x759d7927, Offset: 0x34a0
// Size: 0x7c
function function_6e954d4(localclientnum) {
    self endon(#"death");
    if (!isdefined(self.var_b5e2500e)) {
        self.var_b5e2500e = playfxoncamera(localclientnum, level._effect["bubbles"], (0, 0, 0), (1, 0, 0), (0, 0, 1));
        self thread function_738868d4(localclientnum);
    }
}

// Namespace zm_island
// Params 1, eflags: 0x1 linked
// Checksum 0xf59468bc, Offset: 0x3528
// Size: 0x52
function function_6fb5501(localclientnum) {
    if (isdefined(self.var_b5e2500e)) {
        deletefx(localclientnum, self.var_b5e2500e, 1);
        self.var_b5e2500e = undefined;
    }
    self notify(#"hash_a48959b9");
}

// Namespace zm_island
// Params 1, eflags: 0x1 linked
// Checksum 0x7fab9966, Offset: 0x3588
// Size: 0x3c
function function_738868d4(localclientnum) {
    self endon(#"hash_a48959b9");
    self waittill(#"death");
    self function_6fb5501(localclientnum);
}

// Namespace zm_island
// Params 7, eflags: 0x1 linked
// Checksum 0x767f9287, Offset: 0x35d0
// Size: 0xf4
function function_346468e3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        setlitfogbank(localclientnum, -1, 1, -1);
        setworldfogactivebank(localclientnum, 2);
        return;
    }
    if (newval == 2) {
        setworldfogactivebank(localclientnum, 3);
        return;
    }
    setlitfogbank(localclientnum, -1, 0, -1);
    setworldfogactivebank(localclientnum, 1);
}

// Namespace zm_island
// Params 1, eflags: 0x1 linked
// Checksum 0x5f01fd23, Offset: 0x36d0
// Size: 0x54
function on_localplayer_spawned(localclientnum) {
    if (self != getlocalplayer(localclientnum)) {
        return;
    }
    filter::init_filter_speed_burst(self);
    filter::disable_filter_speed_burst(self, 3);
}

// Namespace zm_island
// Params 7, eflags: 0x1 linked
// Checksum 0x29ac8f53, Offset: 0x3730
// Size: 0xbc
function function_d6b43cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        if (self == getlocalplayer(localclientnum)) {
            filter::enable_filter_speed_burst(self, 3);
        }
        return;
    }
    if (self == getlocalplayer(localclientnum)) {
        filter::disable_filter_speed_burst(self, 3);
    }
}

// Namespace zm_island
// Params 1, eflags: 0x0
// Checksum 0x78e4714e, Offset: 0x37f8
// Size: 0x30
function mapped_material_id(materialname) {
    if (!isdefined(level.filter_matid)) {
        level.filter_matid = [];
    }
    return level.filter_matid[materialname];
}

// Namespace zm_island
// Params 7, eflags: 0x1 linked
// Checksum 0xab0f059d, Offset: 0x3830
// Size: 0xec
function function_6be6da89(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        startwatersheetingfx(localclientnum, 1);
        playsound(localclientnum, "evt_sewer_transport_start");
        self.var_14108ea4 = self playloopsound("evt_sewer_transport_loop", 0.3);
        return;
    }
    stopwatersheetingfx(localclientnum, 0);
    self stoploopsound(self.var_14108ea4);
}

// Namespace zm_island
// Params 7, eflags: 0x1 linked
// Checksum 0xd9b3ed15, Offset: 0x3928
// Size: 0x94
function function_4a01cc4e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        enablespeedblur(localclientnum, 0.07, 0.55, 0.9, 0, 100, 100);
        return;
    }
    disablespeedblur(localclientnum);
}

// Namespace zm_island
// Params 7, eflags: 0x1 linked
// Checksum 0xe9ee77a, Offset: 0x39c8
// Size: 0x16c
function function_e0aec577(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval == 1) {
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 1, 1, 0);
        return;
    }
    var_b05b3457 = 0.01;
    var_bbfa5d7d = newval;
    self playsound(0, "zmb_spider_web_hero_destroy");
    for (i = 1; i > var_bbfa5d7d; i -= var_b05b3457) {
        if (isdefined(self)) {
            self mapshaderconstant(localclientnum, 0, "scriptVector2", i, i, i, 0);
            wait(var_b05b3457);
            continue;
        }
        break;
    }
    if (isdefined(self)) {
        self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
    }
}

// Namespace zm_island
// Params 0, eflags: 0x1 linked
// Checksum 0xa75dfb9b, Offset: 0x3b40
// Size: 0xaa
function function_be61cf5a() {
    var_f47aa4cf = getdynentarray();
    foreach (var_d77b79ec in var_f47aa4cf) {
        setdynentenabled(var_d77b79ec, 0);
    }
}

// Namespace zm_island
// Params 0, eflags: 0x1 linked
// Checksum 0xb6e996fe, Offset: 0x3bf8
// Size: 0x304
function function_3a429aee() {
    forcestreamxmodel("p7_zm_isl_bucket_115");
    forcestreamxmodel("p7_fxanim_zm_island_vine_gate_mod");
    forcestreamxmodel("p7_zm_vending_jugg");
    forcestreamxmodel("p7_zm_vending_doubletap2");
    forcestreamxmodel("p7_zm_vending_revive");
    forcestreamxmodel("p7_zm_vending_sleight");
    forcestreamxmodel("p7_zm_vending_three_gun");
    forcestreamxmodel("p7_zm_vending_marathon");
    forcestreamxmodel("p7_zm_isl_web_vending_jugg");
    forcestreamxmodel("p7_zm_isl_web_vending_doubletap2");
    forcestreamxmodel("p7_zm_isl_web_vending_revive");
    forcestreamxmodel("p7_zm_isl_web_vending_sleight");
    forcestreamxmodel("p7_zm_isl_web_vending_three_gun");
    forcestreamxmodel("p7_zm_isl_web_vending_marathon");
    forcestreamxmodel("p7_zm_isl_web_buy_door");
    forcestreamxmodel("p7_zm_isl_web_buy_door_110");
    forcestreamxmodel("p7_zm_isl_web_buy_door_112");
    forcestreamxmodel("p7_zm_isl_web_buy_door_114");
    forcestreamxmodel("p7_zm_isl_web_buy_door_132");
    forcestreamxmodel("p7_zm_isl_web_buy_door_146");
    forcestreamxmodel("p7_zm_isl_web_penstock");
    forcestreamxmodel("p7_zm_isl_web_bubblegum_machine");
    forcestreamxmodel("p7_zm_power_up_max_ammo");
    forcestreamxmodel("p7_zm_power_up_carpenter");
    forcestreamxmodel("p7_zm_power_up_double_points");
    forcestreamxmodel("p7_zm_power_up_firesale");
    forcestreamxmodel("p7_zm_power_up_insta_kill");
    forcestreamxmodel("p7_zm_power_up_nuke");
    forcestreamxmodel("zombie_pickup_minigun");
    forcestreamxmodel("zombie_pickup_perk_bottle");
    forcestreamxmodel("zombie_z_money_icon");
    forcestreamxmodel("p7_zm_isl_plant_seed_pod_01");
}

// Namespace zm_island
// Params 7, eflags: 0x1 linked
// Checksum 0xd960d244, Offset: 0x3f08
// Size: 0x7c
function function_e0410522(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        forcestreamxmodel("c_zom_dlc2_spider");
        return;
    }
    stopforcestreamingxmodel("c_zom_dlc2_spider");
}

// Namespace zm_island
// Params 7, eflags: 0x1 linked
// Checksum 0xa5b5d80d, Offset: 0x3f90
// Size: 0x10c
function function_e4587332(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (newval) {
        forcestreamxmodel("p7_fxanim_zm_island_takeo_arm1_mod");
        forcestreamxmodel("p7_fxanim_zm_island_takeo_arm2_mod");
        forcestreamxmodel("p7_fxanim_zm_island_takeo_arm3_mod");
        forcestreamxmodel("p7_fxanim_zm_island_takeo_arm4_mod");
        return;
    }
    stopforcestreamingxmodel("p7_fxanim_zm_island_takeo_arm1_mod");
    stopforcestreamingxmodel("p7_fxanim_zm_island_takeo_arm2_mod");
    stopforcestreamingxmodel("p7_fxanim_zm_island_takeo_arm3_mod");
    stopforcestreamingxmodel("p7_fxanim_zm_island_takeo_arm4_mod");
}

