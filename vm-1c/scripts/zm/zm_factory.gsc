#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
#using scripts/zm/zm_factory_zombie;
#using scripts/zm/zm_factory_vo;
#using scripts/zm/zm_factory_ffotd;
#using scripts/zm/zm_factory_fx;
#using scripts/zm/zm_factory_gamemodes;
#using scripts/zm/zm_factory_teleporter;
#using scripts/zm/zm_factory_cleanup_mgr;
#using scripts/zm/_zm_trap_electric;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/behavior_zombie_dog;
#using scripts/shared/ai/zombie;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_weap_tesla;
#using scripts/zm/_zm_weap_bowie;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weap_annihilator;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_timer;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_ai_dogs;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/abilities/_ability_player;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/compass;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace zm_factory;

// Namespace zm_factory
// Params 0, eflags: 0x2
// namespace_1437a8b5<file_0>::function_8e134dbe
// Checksum 0xe0864ca4, Offset: 0x1e50
// Size: 0x28
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    level.randomize_perk_machine_location = 1;
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_d290ebfa
// Checksum 0x625215dc, Offset: 0x1e80
// Size: 0xa0c
function main() {
    namespace_689d3383::main_start();
    setclearanceceiling(17);
    namespace_e59f4632::main();
    init_clientfields();
    scene::add_scene_func("p7_fxanim_zm_factory_bridge_lft_bundle", &function_18768e9b, "init");
    scene::add_scene_func("p7_fxanim_zm_factory_bridge_lft_bundle", &function_266e1445, "done");
    scene::add_scene_func("p7_fxanim_zm_factory_bridge_rt_bundle", &function_18768e9b, "init");
    scene::add_scene_func("p7_fxanim_zm_factory_bridge_rt_bundle", &function_266e1445, "done");
    level._uses_sticky_grenades = 1;
    level._uses_taser_knuckles = 1;
    zm::init_fx();
    level util::set_lighting_state(1);
    callback::on_connect(&function_7cb67075);
    callback::on_spawned(&on_player_spawned);
    level._effect["eye_glow"] = "zombie/fx_glow_eye_orange";
    level._effect["headshot"] = "zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect["headshot_nochunks"] = "zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect["bloodspurt"] = "zombie/fx_bul_flesh_neck_spurt_zmb";
    level._effect["animscript_gib_fx"] = "zombie/fx_blood_torso_explo_zmb";
    level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
    level._effect["switch_sparks"] = "electric/fx_elec_sparks_directional_orange";
    level.var_9cef605e = &function_81abed86;
    level.default_start_location = "start_room";
    level.default_game_mode = "zclassic";
    zm::spawn_life_brush((700, -986, 280), -128, -128);
    level.random_pandora_box_start = 1;
    if (1 == getdvarint("movie_intro")) {
        setdvar("art_review", "1");
        level.random_pandora_box_start = 0;
        level.start_chest_name = "chest_4";
        var_8ad3e4ad = getent("clock_snow", "targetname");
        var_8ad3e4ad ghost();
        scene::add_scene_func("cin_der_01_intro_3rd_sh050", &function_663e2494, "play");
        level thread cinematic();
    } else {
        clock = getent("factory_clock", "targetname");
        clock thread scene::play("p7_fxanim_zm_factory_clock_bundle");
    }
    level.var_fe571972 = 0;
    level.var_9408c924 = &function_9408c924;
    level.precachecustomcharacters = &precachecustomcharacters;
    level.givecustomcharacters = &givecustomcharacters;
    level thread setup_personality_character_exerts();
    initcharacterstartindex();
    level.var_f55453ea = &offhand_weapon_overrride;
    level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
    level.var_237b30e2 = &function_7837e42a;
    level thread custom_add_vox();
    level._allow_melee_weapon_switching = 1;
    level.enemy_location_override_func = &function_ec0a572;
    level.no_target_override = &no_target_override;
    zm_pap_util::function_def6ee85();
    level thread function_e0f73644();
    include_weapons();
    function_5dacef79();
    function_50a4ff91();
    level.zm_custom_spawn_location_selection = &function_235cb67a;
    load::main();
    function_f205a5f1();
    compass::setupminimap("compass_map_zm_factory");
    namespace_570c8452::init();
    namespace_40b4687d::init();
    level.var_22a82a99 = 0;
    level.var_5da290dc = 0;
    level.var_f3d80c6a = 0;
    level.debug_keyline_zombies = 0;
    level.burning_zombies = [];
    level.var_815f3ea6 = 400;
    level.door_dialog_function = &zm::play_door_dialog;
    function_f4761408();
    level.var_ce91af88 = &function_f2cc1fb6;
    level.var_b085eada = getgametypesetting("allowdogs");
    if (level.var_b085eada) {
        namespace_cc5bac97::enable_dog_rounds();
    }
    level.fn_custom_round_ai_spawn = &function_33aa4940;
    level._round_start_func = &zm::round_start;
    init_sounds();
    function_c2c3841b();
    level thread function_96405fb1();
    level thread function_2a476331();
    level.zones = [];
    level.zone_manager_init_func = &function_ce41565b;
    init_zones[0] = "receiver_zone";
    level thread zm_zonemgr::manage_zones(init_zones);
    level function_a1d5988d();
    level.zombie_ai_limit = 24;
    level thread function_8b08668c();
    level function_273a85e1();
    level thread function_cae23517();
    level.grenade_planted = &function_6ea54e62;
    level thread sndfunctions();
    level.sndtrapfunc = &function_1e7472d2;
    level.var_7dff0629 = getent("monk_scream_trig", "targetname");
    zombie_utility::set_zombie_var("zombie_powerup_drop_max_per_round", 4);
    a_t_audio = getentarray("audio_bump_trigger", "targetname");
    foreach (t_audio_bump in a_t_audio) {
        if (t_audio_bump.script_sound === "zmb_perks_bump_bottle") {
            t_audio_bump thread check_for_change();
        }
    }
    trigs = getentarray("trig_ee", "targetname");
    array::thread_all(trigs, &function_ee83e9e7);
    level.use_powerup_volumes = 1;
    level.zm_bgb_anywhere_but_here_validation_override = &function_869d6f66;
    level thread function_6d012317();
    level thread function_22dc1a0d();
    level thread function_5d386c43();
    /#
        level thread function_afea638c();
    #/
    namespace_689d3383::main_end();
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_2ea898a8
// Checksum 0xff977775, Offset: 0x2898
// Size: 0xf4
function init_clientfields() {
    clientfield::register("world", "console_blue", 1, 1, "int");
    clientfield::register("world", "console_green", 1, 1, "int");
    clientfield::register("world", "console_red", 1, 1, "int");
    clientfield::register("world", "console_start", 1, 1, "int");
    clientfield::register("toplayer", "lightning_strike", 1, 1, "counter");
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_a1d5988d
// Checksum 0x9af05b50, Offset: 0x2998
// Size: 0x108
function function_a1d5988d() {
    var_e4821d40 = level.zones["wnuen_bridge_zone"].a_loc_types["dog_location"];
    if (isdefined(var_e4821d40)) {
        foreach (spawn in var_e4821d40) {
            if (spawn.origin == (1196, -1459.8, 135.4)) {
                spawn.origin = getclosestpointonnavmesh((1244, -1444, -120), 15);
                return;
            }
        }
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_b684bae0
// Checksum 0xbf22cda5, Offset: 0x2aa8
// Size: 0x1fc
function cinematic() {
    level flag::wait_till("all_players_connected");
    setdvar("cg_draw2D", 0);
    setdvar("cg_drawFPS", 0);
    setdvar("cg_drawPerformanceWarnings", 0);
    while (!aretexturesloaded()) {
        wait(0.05);
    }
    visionsetnaked("cp_igc_chinatown_intro", 0.05);
    foreach (e_player in level.players) {
        e_player freezecontrols(1);
        e_player allowsprint(0);
        e_player allowjump(0);
    }
    level.players[0] setclientuivisibilityflag("hud_visible", 0);
    setdvar("debug_show_viewpos", "0");
    wait(3);
    var_a720d14f = struct::get("tag_align_switch_box");
    var_a720d14f scene::play("cin_der_01_intro_3rd_sh010");
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_663e2494
// Checksum 0xe3e26732, Offset: 0x2cb0
// Size: 0x54
function function_663e2494(a_ents) {
    clock = getent("factory_clock", "targetname");
    clock thread scene::play("p7_fxanim_zm_factory_clock_igc_bundle");
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_aebcf025
// Checksum 0xd9218a30, Offset: 0x2d10
// Size: 0x1c
function on_player_spawned() {
    self thread function_a2e68875();
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_a2e68875
// Checksum 0x58731def, Offset: 0x2d38
// Size: 0xa6
function function_a2e68875() {
    self endon(#"disconnect");
    util::wait_network_frame();
    while (true) {
        n_random_wait = randomintrange(12, 18);
        if (isdefined(self) && isplayer(self)) {
            self notify(#"lightning_strike");
            self clientfield::increment_to_player("lightning_strike", 1);
        }
        wait(n_random_wait);
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_3faace81
// Checksum 0xefd0e0b3, Offset: 0x2de8
// Size: 0xd6
function offhand_weapon_overrride() {
    zm_utility::register_lethal_grenade_for_level("frag_grenade");
    level.zombie_lethal_grenade_player_init = getweapon("frag_grenade");
    zm_utility::register_tactical_grenade_for_level("cymbal_monkey");
    zm_utility::register_tactical_grenade_for_level("emp_grenade");
    zm_utility::register_melee_weapon_for_level(level.weaponbasemelee.name);
    zm_utility::register_melee_weapon_for_level("bowie_knife");
    zm_utility::register_melee_weapon_for_level("tazer_knuckles");
    level.zombie_melee_weapon_player_init = level.weaponbasemelee;
    level.zombie_equipment_player_init = undefined;
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_a0a06075
// Checksum 0x69b0f77a, Offset: 0x2ec8
// Size: 0xbe
function offhand_weapon_give_override(weapon) {
    self endon(#"death");
    if (zm_utility::is_tactical_grenade(weapon) && isdefined(self zm_utility::get_player_tactical_grenade()) && !self zm_utility::is_player_tactical_grenade(weapon)) {
        self setweaponammoclip(self zm_utility::get_player_tactical_grenade(), 0);
        self takeweapon(self zm_utility::get_player_tactical_grenade());
    }
    return false;
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_5dacef79
// Checksum 0x5eb26eb2, Offset: 0x2f90
// Size: 0x1c
function function_5dacef79() {
    zm_powerups::add_zombie_special_drop("nothing");
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_50a4ff91
// Checksum 0x99ec1590, Offset: 0x2fb8
// Size: 0x4
function function_50a4ff91() {
    
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_6e1af22d
// Checksum 0x99ec1590, Offset: 0x2fc8
// Size: 0x4
function include_weapons() {
    
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_c2eb9077
// Checksum 0x99ec1590, Offset: 0x2fd8
// Size: 0x4
function precachecustomcharacters() {
    
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_64b491e4
// Checksum 0x19145859, Offset: 0x2fe8
// Size: 0x24
function initcharacterstartindex() {
    level.characterstartindex = randomint(4);
}

// Namespace zm_factory
// Params 0, eflags: 0x0
// namespace_1437a8b5<file_0>::function_31420e52
// Checksum 0x7f313978, Offset: 0x3018
// Size: 0x3e
function selectcharacterindextouse() {
    if (level.characterstartindex >= 4) {
        level.characterstartindex = 0;
    }
    self.characterindex = level.characterstartindex;
    level.characterstartindex++;
    return self.characterindex;
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_2b7aef11
// Checksum 0x750d7f35, Offset: 0x3060
// Size: 0x214
function assign_lowest_unused_character_index() {
    charindexarray = [];
    charindexarray[0] = 0;
    charindexarray[1] = 1;
    charindexarray[2] = 2;
    charindexarray[3] = 3;
    players = getplayers();
    if (players.size == 1) {
        charindexarray = array::randomize(charindexarray);
        if (charindexarray[0] == 2) {
            level.var_fe571972 = 1;
        }
        return charindexarray[0];
    } else {
        var_266da916 = 0;
        foreach (player in players) {
            if (isdefined(player.characterindex)) {
                arrayremovevalue(charindexarray, player.characterindex, 0);
                var_266da916++;
            }
        }
        if (charindexarray.size > 0) {
            if (var_266da916 == players.size - 1) {
                if (!(isdefined(level.var_fe571972) && level.var_fe571972)) {
                    level.var_fe571972 = 1;
                    return 2;
                }
            }
            charindexarray = array::randomize(charindexarray);
            if (charindexarray[0] == 2) {
                level.var_fe571972 = 1;
            }
            return charindexarray[0];
        }
    }
    return 0;
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_a0c0aeb
// Checksum 0xabe7a763, Offset: 0x3280
// Size: 0x2cc
function givecustomcharacters() {
    if (isdefined(level.var_dbfdd66c) && [[ level.var_dbfdd66c ]]("c_zom_farmgirl_viewhands")) {
        return;
    }
    self detachall();
    if (!isdefined(self.characterindex)) {
        self.characterindex = assign_lowest_unused_character_index();
    }
    self.favorite_wall_weapons_list = [];
    self.talks_in_danger = 0;
    /#
        if (getdvarstring("zombie/fx_bul_flesh_head_nochunks_zmb") != "zombie/fx_bul_flesh_head_nochunks_zmb") {
            self.characterindex = getdvarint("zombie/fx_bul_flesh_head_nochunks_zmb");
        }
    #/
    self setcharacterbodytype(self.characterindex);
    self setcharacterbodystyle(0);
    self setcharacterhelmetstyle(0);
    switch (self.characterindex) {
    case 1:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("870mcs");
        break;
    case 0:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("frag_grenade");
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("bouncingbetty");
        break;
    case 3:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("hk416");
        break;
    case 2:
        self.talks_in_danger = 1;
        level.rich_sq_player = self;
        level.var_b879b3b4 = self;
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("pistol_standard");
        break;
    }
    self setmovespeedscale(1);
    self function_ba25e637(4);
    self function_e67885f8(0);
    self thread set_exert_id();
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_f7f01a5c
// Checksum 0xd7209e10, Offset: 0x3558
// Size: 0x54
function set_exert_id() {
    self endon(#"disconnect");
    util::wait_network_frame();
    util::wait_network_frame();
    self zm_audio::setexertvoice(self.characterindex + 1);
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_80f102b1
// Checksum 0x93ae0305, Offset: 0x35b8
// Size: 0x7f2
function setup_personality_character_exerts() {
    level.exert_sounds[1]["burp"][0] = "evt_belch";
    level.exert_sounds[1]["burp"][1] = "evt_belch";
    level.exert_sounds[1]["burp"][2] = "evt_belch";
    level.exert_sounds[2]["burp"][0] = "evt_belch";
    level.exert_sounds[2]["burp"][1] = "evt_belch";
    level.exert_sounds[2]["burp"][2] = "evt_belch";
    level.exert_sounds[3]["burp"][0] = "evt_belch";
    level.exert_sounds[3]["burp"][1] = "evt_belch";
    level.exert_sounds[3]["burp"][2] = "evt_belch";
    level.exert_sounds[4]["burp"][0] = "evt_belch";
    level.exert_sounds[4]["burp"][1] = "evt_belch";
    level.exert_sounds[4]["burp"][2] = "evt_belch";
    level.exert_sounds[1]["hitmed"][0] = "vox_plr_0_exert_pain_0";
    level.exert_sounds[1]["hitmed"][1] = "vox_plr_0_exert_pain_1";
    level.exert_sounds[1]["hitmed"][2] = "vox_plr_0_exert_pain_2";
    level.exert_sounds[1]["hitmed"][3] = "vox_plr_0_exert_pain_3";
    level.exert_sounds[1]["hitmed"][4] = "vox_plr_0_exert_pain_4";
    level.exert_sounds[2]["hitmed"][0] = "vox_plr_1_exert_pain_0";
    level.exert_sounds[2]["hitmed"][1] = "vox_plr_1_exert_pain_1";
    level.exert_sounds[2]["hitmed"][2] = "vox_plr_1_exert_pain_2";
    level.exert_sounds[2]["hitmed"][3] = "vox_plr_1_exert_pain_3";
    level.exert_sounds[2]["hitmed"][4] = "vox_plr_1_exert_pain_4";
    level.exert_sounds[3]["hitmed"][0] = "vox_plr_2_exert_pain_0";
    level.exert_sounds[3]["hitmed"][1] = "vox_plr_2_exert_pain_1";
    level.exert_sounds[3]["hitmed"][2] = "vox_plr_2_exert_pain_2";
    level.exert_sounds[3]["hitmed"][3] = "vox_plr_2_exert_pain_3";
    level.exert_sounds[3]["hitmed"][4] = "vox_plr_2_exert_pain_4";
    level.exert_sounds[4]["hitmed"][0] = "vox_plr_3_exert_pain_0";
    level.exert_sounds[4]["hitmed"][1] = "vox_plr_3_exert_pain_1";
    level.exert_sounds[4]["hitmed"][2] = "vox_plr_3_exert_pain_2";
    level.exert_sounds[4]["hitmed"][3] = "vox_plr_3_exert_pain_3";
    level.exert_sounds[4]["hitmed"][4] = "vox_plr_3_exert_pain_4";
    level.exert_sounds[1]["hitlrg"][0] = "vox_plr_0_exert_pain_0";
    level.exert_sounds[1]["hitlrg"][1] = "vox_plr_0_exert_pain_1";
    level.exert_sounds[1]["hitlrg"][2] = "vox_plr_0_exert_pain_2";
    level.exert_sounds[1]["hitlrg"][3] = "vox_plr_0_exert_pain_3";
    level.exert_sounds[1]["hitlrg"][4] = "vox_plr_0_exert_pain_4";
    level.exert_sounds[2]["hitlrg"][0] = "vox_plr_1_exert_pain_0";
    level.exert_sounds[2]["hitlrg"][1] = "vox_plr_1_exert_pain_1";
    level.exert_sounds[2]["hitlrg"][2] = "vox_plr_1_exert_pain_2";
    level.exert_sounds[2]["hitlrg"][3] = "vox_plr_1_exert_pain_3";
    level.exert_sounds[2]["hitlrg"][4] = "vox_plr_1_exert_pain_4";
    level.exert_sounds[3]["hitlrg"][0] = "vox_plr_2_exert_pain_0";
    level.exert_sounds[3]["hitlrg"][1] = "vox_plr_2_exert_pain_1";
    level.exert_sounds[3]["hitlrg"][2] = "vox_plr_2_exert_pain_2";
    level.exert_sounds[3]["hitlrg"][3] = "vox_plr_2_exert_pain_3";
    level.exert_sounds[3]["hitlrg"][4] = "vox_plr_2_exert_pain_4";
    level.exert_sounds[4]["hitlrg"][0] = "vox_plr_3_exert_pain_0";
    level.exert_sounds[4]["hitlrg"][1] = "vox_plr_3_exert_pain_1";
    level.exert_sounds[4]["hitlrg"][2] = "vox_plr_3_exert_pain_2";
    level.exert_sounds[4]["hitlrg"][3] = "vox_plr_3_exert_pain_3";
    level.exert_sounds[4]["hitlrg"][4] = "vox_plr_3_exert_pain_4";
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_7837e42a
// Checksum 0xee1ead4, Offset: 0x3db8
// Size: 0x24
function function_7837e42a() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_factory_weapons.csv", 1);
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_af7b8b82
// Checksum 0x174127a6, Offset: 0x3de8
// Size: 0x1c
function custom_add_vox() {
    zm_audio::loadplayervoicecategories("gamedata/audio/zm/zm_factory_vox.csv");
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_c2c3841b
// Checksum 0x99ec1590, Offset: 0x3e10
// Size: 0x4
function function_c2c3841b() {
    
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_ce41565b
// Checksum 0xf28cd1de, Offset: 0x3e20
// Size: 0x1e4
function function_ce41565b() {
    zm_zonemgr::add_adjacent_zone("receiver_zone", "outside_east_zone", "enter_outside_east");
    zm_zonemgr::add_adjacent_zone("receiver_zone", "outside_west_zone", "enter_outside_west");
    zm_zonemgr::add_adjacent_zone("wnuen_zone", "outside_east_zone", "enter_wnuen_building");
    zm_zonemgr::add_adjacent_zone("wnuen_zone", "wnuen_bridge_zone", "enter_wnuen_loading_dock");
    zm_zonemgr::add_adjacent_zone("warehouse_bottom_zone", "outside_west_zone", "enter_warehouse_building");
    zm_zonemgr::add_adjacent_zone("warehouse_bottom_zone", "warehouse_top_zone", "enter_warehouse_second_floor");
    zm_zonemgr::add_adjacent_zone("warehouse_top_zone", "bridge_zone", "enter_warehouse_second_floor");
    zm_zonemgr::add_adjacent_zone("tp_east_zone", "wnuen_zone", "enter_tp_east");
    zm_zonemgr::add_adjacent_zone("tp_east_zone", "outside_east_zone", "enter_tp_east", 1);
    zm_zonemgr::add_zone_flags("enter_tp_east", "enter_wnuen_building");
    zm_zonemgr::add_adjacent_zone("tp_south_zone", "outside_south_zone", "enter_tp_south");
    zm_zonemgr::add_adjacent_zone("tp_west_zone", "warehouse_top_zone", "enter_tp_west");
}

// Namespace zm_factory
// Params 0, eflags: 0x0
// namespace_1437a8b5<file_0>::function_fe17c18
// Checksum 0x2f86e5e1, Offset: 0x4010
// Size: 0x416
function intro_screen() {
    if (1 == getdvarint("movie_intro")) {
        return;
    }
    level flag::wait_till("start_zombie_round_logic");
    wait(2);
    level.var_944e0877 = [];
    for (i = 0; i < 3; i++) {
        level.var_944e0877[i] = newhudelem();
        level.var_944e0877[i].x = 0;
        level.var_944e0877[i].y = 0;
        level.var_944e0877[i].alignx = "left";
        level.var_944e0877[i].aligny = "bottom";
        level.var_944e0877[i].horzalign = "left";
        level.var_944e0877[i].vertalign = "bottom";
        level.var_944e0877[i].foreground = 1;
        if (level.splitscreen && !level.var_1b3d5c61) {
            level.var_944e0877[i].fontscale = 2.75;
        } else {
            level.var_944e0877[i].fontscale = 1.75;
        }
        level.var_944e0877[i].alpha = 0;
        level.var_944e0877[i].color = (1, 1, 1);
        level.var_944e0877[i].inuse = 0;
    }
    level.var_944e0877[0].y = -110;
    level.var_944e0877[1].y = -90;
    level.var_944e0877[2].y = -70;
    level.var_944e0877[0] settext(%ZOMBIE_INTRO_FACTORY_LEVEL_PLACE);
    level.var_944e0877[1] settext("");
    level.var_944e0877[2] settext("");
    for (i = 0; i < 3; i++) {
        level.var_944e0877[i] fadeovertime(3.5);
        level.var_944e0877[i].alpha = 1;
        wait(1.5);
    }
    wait(1.5);
    for (i = 0; i < 3; i++) {
        level.var_944e0877[i] fadeovertime(3.5);
        level.var_944e0877[i].alpha = 0;
        wait(1.5);
    }
    for (i = 0; i < 3; i++) {
        level.var_944e0877[i] destroy();
    }
}

// Namespace zm_factory
// Params 2, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_ec0a572
// Checksum 0xf611ee64, Offset: 0x4430
// Size: 0x86
function function_ec0a572(zombie, enemy) {
    aiprofile_beginentry("factory-enemy_location_override");
    if (isdefined(zombie.var_f17acdbc) && zombie.var_f17acdbc) {
        aiprofile_endentry();
        return zombie.origin;
    }
    aiprofile_endentry();
    return undefined;
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_97d7cae0
// Checksum 0xe05d486d, Offset: 0x44c0
// Size: 0x80
function function_97d7cae0(position) {
    if (isdefined(position)) {
        var_7aa7336b = getclosestpointonnavmesh(position.origin, 100);
        if (isdefined(var_7aa7336b)) {
            self setgoal(var_7aa7336b);
            self.has_exit_point = 1;
            return true;
        }
    }
    return false;
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_27553de3
// Checksum 0x72ae20ad, Offset: 0x4548
// Size: 0x33c
function no_target_override(zombie) {
    if (isdefined(zombie.has_exit_point)) {
        return;
    }
    players = level.players;
    dist_zombie = 0;
    dist_player = 0;
    dest = 0;
    if (isdefined(level.zm_loc_types["dog_location"])) {
        locs = array::randomize(level.zm_loc_types["dog_location"]);
        for (i = 0; i < locs.size; i++) {
            var_a69886b4 = 0;
            foreach (player in players) {
                if (player laststand::player_is_in_laststand()) {
                    continue;
                }
                away = vectornormalize(self.origin - player.origin);
                endpos = self.origin + vectorscale(away, 600);
                dist_zombie = distancesquared(locs[i].origin, endpos);
                dist_player = distancesquared(locs[i].origin, player.origin);
                if (dist_zombie < dist_player) {
                    dest = i;
                    var_a69886b4 = 1;
                    continue;
                }
                var_a69886b4 = 0;
            }
            if (var_a69886b4) {
                if (zombie function_97d7cae0(locs[i])) {
                    return;
                }
            }
        }
    }
    var_49d79cb6 = zombie namespace_45003ce0::get_escape_position_in_current_zone();
    if (zombie function_97d7cae0(var_49d79cb6)) {
        return;
    }
    var_49d79cb6 = zombie namespace_45003ce0::get_escape_position();
    if (zombie function_97d7cae0(var_49d79cb6)) {
        return;
    }
    zombie.has_exit_point = 1;
    zombie setgoal(zombie.origin);
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_f4761408
// Checksum 0x99ec1590, Offset: 0x4890
// Size: 0x4
function function_f4761408() {
    
}

// Namespace zm_factory
// Params 1, eflags: 0x0
// namespace_1437a8b5<file_0>::function_c6a16cbd
// Checksum 0xea46cc04, Offset: 0x48a0
// Size: 0xc
function function_c6a16cbd(animname) {
    
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_f2cc1fb6
// Checksum 0x99ec1590, Offset: 0x48b8
// Size: 0x4
function function_f2cc1fb6() {
    
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_273a85e1
// Checksum 0xf1bff87a, Offset: 0x48c8
// Size: 0x72
function function_273a85e1() {
    spawn_points = struct::get_array("player_respawn_point", "targetname");
    for (i = 0; i < spawn_points.size; i++) {
        spawn_points[i].locked = 1;
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_cae23517
// Checksum 0x9252ea55, Offset: 0x4948
// Size: 0x23c
function function_cae23517() {
    level flag::init("bridge_down");
    var_1ea5f04d = struct::get("bridge_audio", "targetname");
    level flag::wait_till("power_on");
    level util::clientnotify("pl1");
    level thread scene::play("p7_fxanim_zm_factory_bridge_lft_bundle");
    level scene::play("p7_fxanim_zm_factory_bridge_rt_bundle");
    level flag::set("bridge_down");
    var_69efc24f = getent("wnuen_bridge_clip", "targetname");
    var_69efc24f connectpaths();
    var_69efc24f delete();
    var_ce2b913f = getent("warehouse_bridge_clip", "targetname");
    var_ce2b913f connectpaths();
    var_ce2b913f delete();
    var_2cf4d1da = getent("wnuen_bridge", "targetname");
    var_2cf4d1da connectpaths();
    zm_zonemgr::function_e54a2e19("wnuen_bridge_zone", "bridge_zone");
    zm_zonemgr::function_e54a2e19("warehouse_top_zone", "bridge_zone");
    wait(14);
    level thread function_5369a434("vox_maxis_teleporter_lost_0");
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_18768e9b
// Checksum 0xe5883cee, Offset: 0x4b90
// Size: 0x92
function function_18768e9b(a_parts) {
    foreach (part in a_parts) {
        part disconnectpaths();
    }
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_266e1445
// Checksum 0xd3e83a4f, Offset: 0x4c30
// Size: 0x92
function function_266e1445(a_parts) {
    foreach (part in a_parts) {
        part connectpaths();
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_8b08668c
// Checksum 0xcb5f100f, Offset: 0x4cd0
// Size: 0x8c
function function_8b08668c() {
    trig = getent("trig_outside_south_zone", "targetname");
    trig waittill(#"trigger");
    zm_zonemgr::function_e54a2e19("outside_south_zone", "bridge_zone", 1);
    zm_zonemgr::function_e54a2e19("outside_south_zone", "wnuen_bridge_zone", 1);
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_8eca036a
// Checksum 0x9fd8e3c2, Offset: 0x4d68
// Size: 0x84
function init_sounds() {
    zm_utility::add_sound("break_stone", "evt_break_stone");
    zm_utility::add_sound("gate_door", "zmb_gate_slide_open");
    zm_utility::add_sound("heavy_door", "zmb_heavy_door_open");
    zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
}

// Namespace zm_factory
// Params 0, eflags: 0x0
// namespace_1437a8b5<file_0>::function_408e8617
// Checksum 0x8781d5, Offset: 0x4df8
// Size: 0xc8
function function_408e8617() {
    if (level.chest_moves > 0) {
        var_eaa88d05 = 1;
        if (isdefined(level.var_22a82a99)) {
            if (level.var_22a82a99 > 11) {
                var_eaa88d05 += int(level.zombie_include_weapons.size * 0.1);
            } else if (level.var_22a82a99 > 7) {
                var_eaa88d05 += int(0.05 * level.zombie_include_weapons.size);
            }
        }
        return var_eaa88d05;
    }
    return 0;
}

// Namespace zm_factory
// Params 0, eflags: 0x0
// namespace_1437a8b5<file_0>::function_a591100
// Checksum 0x1a62080d, Offset: 0x4ec8
// Size: 0xbc
function function_a591100() {
    players = getplayers();
    count = 0;
    for (i = 0; i < players.size; i++) {
        if (players[i] zm_weapons::has_weapon_or_upgrade("cymbal_monkey_zm")) {
            count++;
        }
    }
    if (count > 0) {
        return 1;
    }
    if (level.round_number < 10) {
        return 3;
    }
    return 5;
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_2a476331
// Checksum 0x8b5f3197, Offset: 0x4f90
// Size: 0x9a
function function_2a476331() {
    level.open_chest_location = [];
    level.open_chest_location[0] = "chest1";
    level.open_chest_location[1] = "chest2";
    level.open_chest_location[2] = "chest3";
    level.open_chest_location[3] = "chest4";
    level.open_chest_location[4] = "chest5";
    level.open_chest_location[5] = "start_chest";
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_f82121a3
// Checksum 0x5e92ef42, Offset: 0x5038
// Size: 0x4c
function function_f82121a3(trig) {
    /#
        trig endon(#"trigger");
        level flag::wait_till("zombie/fx_bul_flesh_head_nochunks_zmb");
        trig notify(#"trigger");
    #/
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_96405fb1
// Checksum 0xd270df3, Offset: 0x5090
// Size: 0x3dc
function function_96405fb1() {
    trig = getent("use_power_switch", "targetname");
    trig sethintstring(%ZOMBIE_ELECTRIC_SWITCH);
    trig setcursorhint("HINT_NOICON");
    cheat = 0;
    /#
        if (getdvarint("zombie/fx_bul_flesh_head_nochunks_zmb") >= 3) {
            wait(5);
            cheat = 1;
        }
    #/
    user = undefined;
    if (cheat != 1) {
        level thread function_f82121a3(trig);
        user = trig waittill(#"trigger");
        if (isdefined(user)) {
        }
    }
    level thread scene::play("power_switch", "targetname");
    level flag::set("power_on");
    util::wait_network_frame();
    level notify(#"hash_2680d19f");
    util::wait_network_frame();
    level notify(#"hash_a7912f12");
    util::wait_network_frame();
    level notify(#"hash_bd00857f");
    util::wait_network_frame();
    level notify(#"hash_ce46a7cd");
    util::wait_network_frame();
    level notify(#"pack_a_punch_on");
    util::wait_network_frame();
    level notify(#"hash_d829c0f5");
    util::wait_network_frame();
    level notify(#"hash_b72c3f4b");
    util::wait_network_frame();
    level notify(#"specialty_quickrevive_power_on");
    util::wait_network_frame();
    level notify(#"hash_90b23cf7");
    util::wait_network_frame();
    level util::set_lighting_state(0);
    util::clientnotify("ZPO");
    util::wait_network_frame();
    trig delete();
    wait(1);
    s_switch = struct::get("power_switch_fx", "targetname");
    forward = anglestoforward(s_switch.origin);
    playfx(level._effect["switch_sparks"], s_switch.origin, forward);
    zm_zonemgr::function_e54a2e19("outside_east_zone", "outside_south_zone");
    zm_zonemgr::function_e54a2e19("outside_west_zone", "outside_south_zone", 1);
    level util::delay(19, undefined, &zm_audio::sndmusicsystem_playstate, "power_on");
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_8ac7562
// Checksum 0x2379271, Offset: 0x5478
// Size: 0x9c
function check_for_change() {
    while (true) {
        player = self waittill(#"trigger");
        if (player getstance() == "prone") {
            player zm_score::add_to_player_score(100);
            zm_utility::play_sound_at_pos("purchase", player.origin);
            break;
        }
        wait(0.1);
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_ee83e9e7
// Checksum 0xd11e9e55, Offset: 0x5520
// Size: 0xa4
function function_ee83e9e7() {
    self usetriggerrequirelookat();
    self setcursorhint("HINT_NOICON");
    self waittill(#"trigger");
    targ = getent(self.target, "targetname");
    if (isdefined(targ)) {
        targ movez(-10, 5);
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_22dc1a0d
// Checksum 0x6dfe874d, Offset: 0x55d0
// Size: 0x2b4
function function_22dc1a0d() {
    level flag::init("hide_and_seek");
    level flag::init("flytrap");
    level.var_a7a3cd0c = 0;
    level thread function_43b257b6("ee_exp_monkey");
    util::wait_network_frame();
    level thread function_43b257b6("ee_bowie_bear");
    util::wait_network_frame();
    level thread function_43b257b6("ee_perk_bear");
    util::wait_network_frame();
    var_159034c6 = getent("trig_ee_flytrap", "targetname");
    for (var_5e27ad95 = 0; !var_5e27ad95; var_5e27ad95 = 1) {
        amount, inflictor, direction, point, type, tagname, modelname, partname, weapon = var_159034c6 waittill(#"damage");
        if (zm_weapons::is_weapon_upgraded(weapon)) {
        }
    }
    level flag::set("flytrap");
    thread zm_utility::play_sound_2d("vox_maxis_flytrap_1_0");
    scene::play("p7_fxanim_zm_factory_fly_trap_bundle");
    wait(9);
    level flag::set("hide_and_seek");
    level flag::wait_till("ee_exp_monkey");
    level flag::wait_till("ee_bowie_bear");
    level flag::wait_till("ee_perk_bear");
    level thread function_d8362620();
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_43b257b6
// Checksum 0xf3392270, Offset: 0x5890
// Size: 0x21c
function function_43b257b6(target_name) {
    level flag::init(target_name);
    var_538ba7e = getentarray(target_name, "targetname");
    for (i = 0; i < var_538ba7e.size; i++) {
        var_538ba7e[i] hide();
    }
    trig = getent("trig_" + target_name, "targetname");
    trig triggerenable(0);
    level flag::wait_till("hide_and_seek");
    for (i = 0; i < var_538ba7e.size; i++) {
        var_538ba7e[i] show();
    }
    trig triggerenable(1);
    trig waittill(#"trigger");
    level.var_a7a3cd0c += 1;
    thread function_12eca29b();
    trig playsound("zmb_flytrap_target_" + level.var_a7a3cd0c);
    for (i = 0; i < var_538ba7e.size; i++) {
        var_538ba7e[i] hide();
    }
    level flag::set(target_name);
}

// Namespace zm_factory
// Params 2, eflags: 0x0
// namespace_1437a8b5<file_0>::function_d2a44824
// Checksum 0xde21565f, Offset: 0x5ab8
// Size: 0x156
function function_d2a44824(trigger_name, origin_name) {
    if (!isdefined(level.var_349ff49c)) {
        level.var_349ff49c = 0;
    }
    players = getplayers();
    var_57f3649e = getent(trigger_name, "targetname");
    var_d051cd96 = getent(origin_name, "targetname");
    if (!isdefined(var_57f3649e) || !isdefined(var_d051cd96)) {
        return;
    }
    var_57f3649e usetriggerrequirelookat();
    var_57f3649e setcursorhint("HINT_NOICON");
    for (i = 0; i < players.size; i++) {
        players = var_57f3649e waittill(#"trigger");
        level.var_349ff49c += 1;
        var_d051cd96 function_2209a7e2();
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_2209a7e2
// Checksum 0xd3b7b2e1, Offset: 0x5c18
// Size: 0xac
function function_2209a7e2() {
    if (!isdefined(level.var_349ff49c)) {
        level.var_349ff49c = 0;
    }
    if (level.var_349ff49c == 1) {
        self playsound("evt_phono_one");
    }
    if (level.var_349ff49c == 2) {
        self playsound("evt_phono_two");
    }
    if (level.var_349ff49c == 3) {
        self playsound("evt_phono_three");
    }
}

// Namespace zm_factory
// Params 2, eflags: 0x0
// namespace_1437a8b5<file_0>::function_43c36aed
// Checksum 0x2e2f47d4, Offset: 0x5cd0
// Size: 0x166
function function_43c36aed(trigger_name, origin_name) {
    players = getplayers();
    var_e451512f = getent(trigger_name, "targetname");
    var_5d772163 = getent(origin_name, "targetname");
    if (!isdefined(var_e451512f) || !isdefined(var_5d772163)) {
        return;
    }
    var_e451512f usetriggerrequirelookat();
    var_e451512f setcursorhint("HINT_NOICON");
    var_5d772163 playloopsound("amb_radio_static");
    for (i = 0; i < players.size; i++) {
        players = var_e451512f waittill(#"trigger");
        var_5d772163 stoploopsound(0.1);
        var_5d772163 playsound(trigger_name);
    }
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_b2305b86
// Checksum 0xbfb245ca, Offset: 0x5e40
// Size: 0x5c
function function_b2305b86(player) {
    level.var_5738e0e5 = 1;
    wait(4);
    if (isdefined(player)) {
        player zm_audio::create_and_play_dialog("eggs", "music_activate");
    }
    wait(-20);
    level.var_5738e0e5 = 0;
}

// Namespace zm_factory
// Params 1, eflags: 0x0
// namespace_1437a8b5<file_0>::function_743920ab
// Checksum 0x20e0fa62, Offset: 0x5ea8
// Size: 0x124
function function_743920ab(trigger_name) {
    var_fb33b1a2 = getent(trigger_name, "targetname");
    var_fb33b1a2 usetriggerrequirelookat();
    var_fb33b1a2 setcursorhint("HINT_NOICON");
    var_fb33b1a2 playloopsound("zmb_meteor_loop");
    player = var_fb33b1a2 waittill(#"trigger");
    var_fb33b1a2 stoploopsound(1);
    player playsound("zmb_meteor_activate");
    level.meteor_counter += 1;
    if (level.meteor_counter == 3) {
        level thread function_b2305b86(player);
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_12eca29b
// Checksum 0x3de47be4, Offset: 0x5fd8
// Size: 0xc0
function function_12eca29b() {
    if (!isdefined(level.var_a7a3cd0c)) {
        level.var_a7a3cd0c = 0;
    }
    if (level.var_a7a3cd0c == 1) {
        thread zm_utility::play_sound_2d("vox_maxis_flytrap_2_0");
    }
    if (level.var_a7a3cd0c == 2) {
        thread zm_utility::play_sound_2d("vox_maxis_flytrap_3_0");
    }
    if (level.var_a7a3cd0c == 3) {
        thread zm_utility::play_sound_2d("vox_maxis_flytrap_4_0");
        wait(9);
        thread zm_utility::play_sound_2d("vox_maxis_flytrap_4_1");
        return;
    }
    wait(0.05);
}

// Namespace zm_factory
// Params 0, eflags: 0x0
// namespace_1437a8b5<file_0>::function_dadb60c3
// Checksum 0x98241ccf, Offset: 0x60a0
// Size: 0x6e
function function_dadb60c3() {
    zombies = getaiarray(level.zombie_team);
    for (i = 0; i < zombies.size; i++) {
        zombies[i] thread function_bc11bb8b();
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_bc11bb8b
// Checksum 0x9a6d80ea, Offset: 0x6118
// Size: 0x218
function function_bc11bb8b() {
    self endon(#"death");
    player = getplayers()[0];
    dist_zombie = 0;
    dist_player = 0;
    dest = 0;
    away = vectornormalize(self.origin - player.origin);
    endpos = self.origin + vectorscale(away, 600);
    locs = array::randomize(level.zm_loc_types["dog_location"]);
    for (i = 0; i < locs.size; i++) {
        dist_zombie = distancesquared(locs[i].origin, endpos);
        dist_player = distancesquared(locs[i].origin, player.origin);
        if (dist_zombie < dist_player) {
            dest = i;
            break;
        }
    }
    self notify(#"stop_find_flesh");
    self notify(#"zombie_acquire_enemy");
    self setgoal(locs[dest].origin);
    while (true) {
        if (!level flag::get("wait_and_revive")) {
            break;
        }
        util::wait_network_frame();
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_9408c924
// Checksum 0x4a7c9765, Offset: 0x6338
// Size: 0x31a
function function_9408c924() {
    if (level.round_number <= 10) {
        powerup = zm_powerups::get_valid_powerup();
    } else {
        powerup = level.zombie_special_drop_array[randomint(level.zombie_special_drop_array.size)];
        if (level.round_number > 15 && randomint(100) < (level.round_number - 15) * 5) {
            powerup = "nothing";
        }
    }
    switch (powerup) {
    case 184:
        if (level.round_number > 10 && randomint(100) < (level.round_number - 10) * 5) {
            powerup = level.zombie_powerup_array[randomint(level.zombie_powerup_array.size)];
        }
        break;
    case 182:
        if (level.round_number >= 15) {
            dog_spawners = getentarray("special_dog_spawner", "targetname");
            thread zm_utility::play_sound_2d("vox_sam_nospawn");
            powerup = undefined;
        } else {
            powerup = zm_powerups::get_valid_powerup();
        }
        break;
    case 183:
    case 65:
        if (isdefined(level.var_3fdd7e2f)) {
            var_f9fe1878 = [[ level.var_3fdd7e2f ]](powerup);
        } else {
            playfx(level._effect["lightning_dog_spawn"], self.origin);
            playsoundatposition("zmb_hellhound_prespawn", self.origin);
            wait(1.5);
            playsoundatposition("zmb_hellhound_bolt", self.origin);
            earthquake(0.5, 0.75, self.origin, 1000);
            playsoundatposition("zmb_hellhound_spawn", self.origin);
            wait(1);
            thread zm_utility::play_sound_2d("vox_sam_nospawn");
            self delete();
        }
        powerup = undefined;
        break;
    }
    return powerup;
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_81abed86
// Checksum 0xa48f6b57, Offset: 0x6660
// Size: 0x22
function function_81abed86() {
    if (isdefined(self.b_teleporting) && self.b_teleporting) {
        return false;
    }
    return true;
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_12446ae9
// Checksum 0x5dbba146, Offset: 0x6690
// Size: 0x9c
function sndfunctions() {
    level thread setupmusic();
    level thread function_f8719fcc();
    level thread function_8f9ee626();
    level thread function_ff22a5f2();
    level thread function_dc73ca36();
    level.sndweaponpickupoverride = array("hero_annihilator");
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_dc73ca36
// Checksum 0xb0e50cab, Offset: 0x6738
// Size: 0x384
function function_dc73ca36() {
    level flag::wait_till("initial_blackscreen_passed");
    level zm_audio::function_7ab00f0c("round1start");
    level zm_audio::function_80db0d1d("round1start", "round1_start_0", 4, 2);
    level zm_audio::function_80db0d1d("round1start", "round1_start_0", 2);
    level zm_audio::function_80db0d1d("round1start", "round1_start_1", 4, 2);
    level zm_audio::function_80db0d1d("round1start", "round1_start_1", 2);
    level zm_audio::function_7ab00f0c("round1during", "end_of_round");
    level zm_audio::function_80db0d1d("round1during", "round1_during_0", 1);
    level zm_audio::function_80db0d1d("round1during", "round1_during_0", 3);
    level zm_audio::function_80db0d1d("round1during", "round1_during_0", 0);
    level zm_audio::function_80db0d1d("round1during", "round1_during_0", 2);
    level zm_audio::function_7ab00f0c("round1end");
    level zm_audio::function_80db0d1d("round1end", "round1_end_0", 4, 2);
    level zm_audio::function_80db0d1d("round1end", "round1_end_0", 2);
    level zm_audio::function_7ab00f0c("round2during", "end_of_round");
    level zm_audio::function_80db0d1d("round2during", "round2_during_0", 0);
    level zm_audio::function_80db0d1d("round2during", "round2_during_0", 3);
    level zm_audio::function_80db0d1d("round2during", "round2_during_0", 1);
    level zm_audio::function_80db0d1d("round2during", "round2_during_0", 2);
    if (level.players.size >= 2) {
        level thread function_e4df0b58();
        level thread function_56e67a93();
        level thread function_30e4002a();
        level thread function_a2eb6f65();
        return;
    }
    level thread function_266b4809();
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_e4df0b58
// Checksum 0x8b869caf, Offset: 0x6ac8
// Size: 0x3c
function function_e4df0b58() {
    wait(randomintrange(2, 5));
    level zm_audio::function_20b36810("round1start");
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_56e67a93
// Checksum 0xa2774706, Offset: 0x6b10
// Size: 0x4c
function function_56e67a93() {
    level waittill(#"hash_15bea6b3");
    wait(randomintrange(20, 30));
    level zm_audio::function_20b36810("round1during");
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_30e4002a
// Checksum 0x3db77537, Offset: 0x6b68
// Size: 0x4c
function function_30e4002a() {
    level waittill(#"end_of_round");
    wait(randomintrange(4, 7));
    level zm_audio::function_20b36810("round1end");
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_a2eb6f65
// Checksum 0x23e8bfa4, Offset: 0x6bc0
// Size: 0x74
function function_a2eb6f65() {
    while (true) {
        level waittill(#"start_of_round");
        if (!(isdefined(level.first_round) && level.first_round)) {
            break;
        }
    }
    wait(randomintrange(45, 60));
    level zm_audio::function_20b36810("round2during");
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_266b4809
// Checksum 0xe7af021e, Offset: 0x6c40
// Size: 0xf4
function function_266b4809() {
    wait(randomintrange(7, 10));
    while (isdefined(level.players[0].isspeaking) && level.players[0].isspeaking) {
        wait(0.5);
    }
    level.sndvoxoverride = 1;
    doline(level.players[0], "fieldreport_start_0");
    if (isdefined(function_f9ba8078(2))) {
        doline(level.players[0], "fieldreport_start_1");
    }
    level.sndvoxoverride = 0;
    level thread function_4c6dc272();
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_4c6dc272
// Checksum 0x6edba3f0, Offset: 0x6d40
// Size: 0xc4
function function_4c6dc272() {
    level waittill(#"end_of_round");
    wait(randomintrange(1, 3));
    while (isdefined(level.players[0].isspeaking) && level.players[0].isspeaking) {
        wait(0.5);
    }
    level.sndvoxoverride = 1;
    doline(level.players[0], "fieldreport_round1_0");
    level.sndvoxoverride = 0;
    level thread function_72703cdb();
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_72703cdb
// Checksum 0xfd163a15, Offset: 0x6e10
// Size: 0xf0
function function_72703cdb() {
    level waittill(#"end_of_round");
    wait(randomintrange(1, 3));
    while (isdefined(level.players[0].isspeaking) && level.players[0].isspeaking) {
        wait(0.5);
    }
    level.sndvoxoverride = 1;
    doline(level.players[0], "fieldreport_round2_0");
    if (isdefined(function_f9ba8078(2))) {
        doline(level.players[0], "fieldreport_round2_1");
    }
    level.sndvoxoverride = 0;
}

// Namespace zm_factory
// Params 2, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_3ccb73e8
// Checksum 0x8104d230, Offset: 0x6f08
// Size: 0xd4
function doline(guy, alias) {
    if (isdefined(guy)) {
        guy clientfield::set_to_player("isspeaking", 1);
        guy playsoundontag("vox_plr_" + guy.characterindex + "_" + alias, "J_Head");
        waitplaybacktime("vox_plr_" + guy.characterindex + "_" + alias);
        guy clientfield::set_to_player("isspeaking", 0);
    }
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_7cb95be
// Checksum 0x61921ba2, Offset: 0x6fe8
// Size: 0x76
function waitplaybacktime(alias) {
    playbacktime = soundgetplaybacktime(alias);
    if (!isdefined(playbacktime)) {
        playbacktime = 1;
    }
    if (playbacktime >= 0) {
        playbacktime *= 0.001;
    } else {
        playbacktime = 1;
    }
    wait(playbacktime);
}

// Namespace zm_factory
// Params 0, eflags: 0x0
// namespace_1437a8b5<file_0>::function_50989e7
// Checksum 0xb4746e8e, Offset: 0x7068
// Size: 0xba
function function_50989e7() {
    array = level.players;
    array::randomize(array);
    foreach (guy in array) {
        if (guy.characterindex != 2) {
            return guy;
        }
    }
    return undefined;
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_f9ba8078
// Checksum 0xa6c71e98, Offset: 0x7130
// Size: 0x9a
function function_f9ba8078(charindex) {
    foreach (guy in level.players) {
        if (guy.characterindex == charindex) {
            return guy;
        }
    }
    return undefined;
}

// Namespace zm_factory
// Params 0, eflags: 0x0
// namespace_1437a8b5<file_0>::function_cb7b7167
// Checksum 0xd3455f7b, Offset: 0x71d8
// Size: 0xa0
function function_cb7b7167() {
    foreach (player in level.players) {
        if (isdefined(player.isspeaking) && player.isspeaking) {
            return true;
        }
    }
    return false;
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_ff22a5f2
// Checksum 0xd4aefa2e, Offset: 0x7280
// Size: 0xb4
function function_ff22a5f2() {
    level thread zm_audio::function_ff22a5f2("vox_maxis_maxis_radio", undefined, (582, -2167, 286), (629, -1257, 259), (-594, -1359, 108), (-159, 437, 18), (1219, -120, 90));
    level thread function_de1db1bb("vox_maxis_player_radio", (966, 805, 124), (-1197, -1466, -41), (-94, -2324, -81));
}

// Namespace zm_factory
// Params 4, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_de1db1bb
// Checksum 0xc621af7b, Offset: 0x7340
// Size: 0x2de
function function_de1db1bb(var_6ac79f92, origin1, origin2, origin3) {
    radio = spawnstruct();
    radio.counter = 1;
    radio.var_6ac79f92 = var_6ac79f92;
    radio.isplaying = 0;
    radio.array = array();
    if (!isdefined(radio.array)) {
        radio.array = [];
    } else if (!isarray(radio.array)) {
        radio.array = array(radio.array);
    }
    radio.array[radio.array.size] = origin1;
    if (!isdefined(radio.array)) {
        radio.array = [];
    } else if (!isarray(radio.array)) {
        radio.array = array(radio.array);
    }
    radio.array[radio.array.size] = origin2;
    if (!isdefined(radio.array)) {
        radio.array = [];
    } else if (!isarray(radio.array)) {
        radio.array = array(radio.array);
    }
    radio.array[radio.array.size] = origin3;
    if (radio.array.size > 0) {
        for (i = 0; i < radio.array.size; i++) {
            level thread function_713e84b0(radio.array[i], radio, i + 1);
        }
    }
}

// Namespace zm_factory
// Params 3, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_713e84b0
// Checksum 0x7ed25d98, Offset: 0x7628
// Size: 0x2d4
function function_713e84b0(origin, radio, num) {
    temp_ent = spawn("script_origin", origin);
    temp_ent thread zm_audio::secretuse("sndRadioHit", (255, 0, 0), &zm_audio::function_9db08cfa, radio);
    player = temp_ent waittill(#"hash_678c47ee");
    if (isdefined(level.var_b879b3b4) && level.var_b879b3b4 == player) {
        if (num == 1) {
            alias = "vox_maxis_player_radio1a";
        }
        if (num == 2) {
            alias = "vox_maxis_player_radio2a";
        }
        if (num == 3) {
            alias = "vox_maxis_player_radio3a";
        }
    } else {
        if (num == 1) {
            alias = "vox_demp_player_radio1b";
        }
        if (num == 2) {
            alias = "vox_niko_player_radio2b";
        }
        if (num == 3) {
            alias = "vox_take_player_radio3b";
        }
    }
    var_48a5e056 = num;
    var_aae31f82 = alias;
    var_c3d43d75 = zm_spawner::get_number_variants(var_aae31f82);
    if (var_c3d43d75 > 0) {
        radio.isplaying = 1;
        for (i = 0; i < var_c3d43d75; i++) {
            temp_ent playsound(var_aae31f82 + "_" + i);
            playbacktime = soundgetplaybacktime(var_aae31f82 + "_" + i);
            if (!isdefined(playbacktime)) {
                playbacktime = 1;
            }
            if (playbacktime >= 0) {
                playbacktime *= 0.001;
            } else {
                playbacktime = 1;
            }
            wait(playbacktime);
        }
    }
    radio.counter++;
    radio.isplaying = 0;
    temp_ent delete();
}

// Namespace zm_factory
// Params 2, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_6ea54e62
// Checksum 0x4cfb2ffa, Offset: 0x7908
// Size: 0x29c
function function_6ea54e62(grenade, model) {
    grenade endon(#"death");
    grenade endon(#"explode");
    if (grenade.weapon.name === "cymbal_monkey") {
        if (grenade istouching(level.var_7dff0629)) {
            grenade.monk_scream_vox = 1;
            grenade playsound("zmb_vox_cymmonkey_scream");
            return;
        } else {
            var_6cfabdcd = getentarray("sndTransportTrig", "targetname");
            foreach (trig in var_6cfabdcd) {
                if (grenade istouching(trig)) {
                    grenade.monk_scream_vox = 1;
                    if (isdefined(level.cymbal_monkey_dual_view) && level.cymbal_monkey_dual_view) {
                        grenade playsoundtoteam("zmb_monkey_song_reverse", "allies");
                    } else {
                        grenade playsound("zmb_cymmonkey_song_reverse");
                    }
                    wait(6.5);
                    grenade playsound("zmb_vox_cymmonkey_explode_reverse");
                    return;
                }
            }
        }
        if (!(isdefined(grenade.monk_scream_vox) && grenade.monk_scream_vox)) {
            if (isdefined(level.cymbal_monkey_dual_view) && level.cymbal_monkey_dual_view) {
                grenade playsoundtoteam("zmb_monkey_song", "allies");
            } else {
                grenade playsound("zmb_cymmonkey_song");
            }
            wait(6.5);
            grenade playsound("zmb_vox_cymmonkey_explode");
        }
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_15f74249
// Checksum 0x7f420a13, Offset: 0x7bb0
// Size: 0x21c
function setupmusic() {
    zm_audio::musicstate_create("round_start", 3, "roundstart1", "roundstart2", "roundstart3", "roundstart4");
    zm_audio::musicstate_create("round_start_short", 3, "roundstart_short1", "roundstart_short2", "roundstart_short3", "roundstart_short4");
    zm_audio::musicstate_create("round_start_first", 3, "roundstart_first");
    zm_audio::musicstate_create("round_end", 3, "roundend1");
    zm_audio::musicstate_create("game_over", 5, "gameover");
    zm_audio::musicstate_create("dog_start", 3, "dogstart1");
    zm_audio::musicstate_create("dog_end", 3, "dogend1");
    zm_audio::musicstate_create("timer", 3, "timer");
    zm_audio::musicstate_create("power_on", 2, "poweron");
    zm_audio::musicstate_create("musicEasterEgg", 4, "egg");
    zm_audio::sndmusicsystem_eesetup("musicEasterEgg", (900, -586, -105), (987, -873, 122), (-1340, -483, -1));
    level thread function_f8db7034();
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_f8db7034
// Checksum 0x1086b83c, Offset: 0x7dd8
// Size: 0x2c
function function_f8db7034() {
    level waittill(#"hash_a1b1dadb");
    level thread audio::unlockfrontendmusic("mus_beauty_the_giant_mix_intro");
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_f8719fcc
// Checksum 0x6d834ad3, Offset: 0x7e10
// Size: 0x2c
function function_f8719fcc() {
    level waittill(#"snddooropening");
    level thread zm_audio::sndmusicsystem_playstate("first_door");
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_8f9ee626
// Checksum 0x49ebe818, Offset: 0x7e48
// Size: 0x160
function function_8f9ee626() {
    level.var_650dd03a = 0;
    level.var_7f8f129b = array();
    array = struct::get_array("pa_system", "targetname");
    foreach (pa in array) {
        ent = spawn("script_origin", pa.origin);
        if (!isdefined(level.var_7f8f129b)) {
            level.var_7f8f129b = [];
        } else if (!isarray(level.var_7f8f129b)) {
            level.var_7f8f129b = array(level.var_7f8f129b);
        }
        level.var_7f8f129b[level.var_7f8f129b.size] = ent;
    }
}

// Namespace zm_factory
// Params 3, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_5369a434
// Checksum 0x68977d45, Offset: 0x7fb0
// Size: 0x104
function function_5369a434(alias, delay, var_22ae299f) {
    if (!isdefined(var_22ae299f)) {
        var_22ae299f = 0;
    }
    if (isdefined(delay)) {
        wait(delay);
    }
    if (!(isdefined(level.var_650dd03a) && level.var_650dd03a)) {
        level.var_650dd03a = 1;
        level thread function_b49a3f6b(alias);
        playbacktime = soundgetplaybacktime(alias);
        if (!isdefined(playbacktime) || playbacktime <= 2) {
            waittime = 1;
        } else {
            waittime = playbacktime * 0.001;
        }
        if (!var_22ae299f) {
            wait(waittime - 0.9);
        }
        level.var_650dd03a = 0;
    }
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_b49a3f6b
// Checksum 0x3524c7f7, Offset: 0x80c0
// Size: 0xba
function function_b49a3f6b(alias) {
    array::randomize(level.var_7f8f129b);
    foreach (pa in level.var_7f8f129b) {
        pa playsound(alias);
        wait(0.05);
    }
}

// Namespace zm_factory
// Params 2, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_1e7472d2
// Checksum 0x2e350ccf, Offset: 0x8188
// Size: 0x17e
function function_1e7472d2(trap, stage) {
    if (isdefined(trap)) {
        if (stage == 1) {
            switch (trap.target) {
            case 256:
                level thread function_5369a434("vox_maxis_trap_warehouse_inuse_0", 2);
                break;
            case 255:
                level thread function_5369a434("vox_maxis_trap_lab_inuse_0", 2);
                break;
            case 257:
                level thread function_5369a434("vox_maxis_trap_bridge_inuse_0", 2);
                break;
            }
            return;
        }
        switch (trap.target) {
        case 256:
            level thread function_5369a434("vox_maxis_trap_warehouse_active_0", 4);
            break;
        case 255:
            level thread function_5369a434("vox_maxis_trap_lab_active_0", 4);
            break;
        case 257:
            level thread function_5369a434("vox_maxis_trap_bridge_active_0", 4);
            break;
        }
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_33aa4940
// Checksum 0xbb6a84bb, Offset: 0x8310
// Size: 0x158
function function_33aa4940() {
    var_88369d66 = 0;
    if (level.round_number > 30) {
        if (randomfloat(100) < 4) {
            var_88369d66 = 1;
        }
    } else if (level.round_number > 25) {
        if (randomfloat(100) < 3) {
            var_88369d66 = 1;
        }
    } else if (level.round_number > 20) {
        if (randomfloat(100) < 2) {
            var_88369d66 = 1;
        }
    } else if (level.round_number > 15) {
        if (randomfloat(100) < 1) {
            var_88369d66 = 1;
        }
    }
    if (var_88369d66) {
        namespace_cc5bac97::function_6fafe689(1);
        level.zombie_total--;
    }
    return var_88369d66;
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_235cb67a
// Checksum 0x9fe9768, Offset: 0x8470
// Size: 0x21c
function function_235cb67a(a_spots) {
    if (level.zombie_respawns > 0) {
        if (!isdefined(level.var_7843eb15)) {
            level.var_7843eb15 = 0;
        }
        a_players = getplayers();
        level.var_7843eb15++;
        if (level.var_7843eb15 >= a_players.size) {
            level.var_7843eb15 = 0;
        }
        e_player = a_players[level.var_7843eb15];
        arraysortclosest(a_spots, e_player.origin);
        a_candidates = [];
        v_player_dir = anglestoforward(e_player.angles);
        for (i = 0; i < a_spots.size; i++) {
            v_dir = a_spots[i].origin - e_player.origin;
            dp = vectordot(v_player_dir, v_dir);
            if (dp >= 0) {
                a_candidates[a_candidates.size] = a_spots[i];
                if (a_candidates.size > 10) {
                    break;
                }
            }
        }
        if (a_candidates.size) {
            s_spot = array::random(a_candidates);
        } else {
            s_spot = array::random(a_spots);
        }
    } else {
        s_spot = array::random(a_spots);
    }
    return s_spot;
}

// Namespace zm_factory
// Params 2, eflags: 0x4
// namespace_1437a8b5<file_0>::function_1daba8b7
// Checksum 0x5d4c96ca, Offset: 0x8698
// Size: 0x120
function private function_1daba8b7(origin, players) {
    closest = players[0];
    closest_dist = self zm_utility::approximate_path_dist(closest);
    if (!isdefined(closest_dist)) {
        closest = undefined;
    }
    for (index = 1; index < players.size; index++) {
        dist = self zm_utility::approximate_path_dist(players[index]);
        if (isdefined(dist) && dist < closest_dist) {
            closest = players[index];
            closest_dist = dist;
        }
    }
    if (players.size > 1 && isdefined(closest)) {
        self zm_utility::approximate_path_dist(closest);
    }
    return closest;
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_f205a5f1
// Checksum 0x4b72cf39, Offset: 0x87c0
// Size: 0xc6
function function_f205a5f1() {
    level._effect["jugger_light"] = "zombie/fx_perk_juggernaut_factory_zmb";
    level._effect["revive_light"] = "zombie/fx_perk_quick_revive_factory_zmb";
    level._effect["sleight_light"] = "zombie/fx_perk_sleight_of_hand_factory_zmb";
    level._effect["doubletap2_light"] = "zombie/fx_perk_doubletap2_factory_zmb";
    level._effect["deadshot_light"] = "zombie/fx_perk_daiquiri_factory_zmb";
    level._effect["marathon_light"] = "zombie/fx_perk_stamin_up_factory_zmb";
    level._effect["additionalprimaryweapon_light"] = "zombie/fx_perk_mule_kick_factory_zmb";
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_6d012317
// Checksum 0x1df7305a, Offset: 0x8890
// Size: 0x44
function function_6d012317() {
    var_3d01fc2c = getent("cipher_brick_main", "script_noteworthy");
    var_3d01fc2c thread function_b730f44e();
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_b730f44e
// Checksum 0x88a3fa55, Offset: 0x88e0
// Size: 0x18a
function function_b730f44e() {
    self create_unitrigger();
    self waittill(#"trigger_activated");
    var_74772b0f = getentarray("cipher_bricks", "targetname");
    foreach (var_3d01fc2c in var_74772b0f) {
        var_3d01fc2c movez(375, 2);
    }
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
    wait(2);
    foreach (var_3d01fc2c in var_74772b0f) {
        var_3d01fc2c delete();
    }
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_a1b986ba
// Checksum 0xc72f6f31, Offset: 0x8a78
// Size: 0xdc
function create_unitrigger(str_hint) {
    s_unitrigger = spawnstruct();
    s_unitrigger.origin = self.origin;
    s_unitrigger.angles = self.angles;
    s_unitrigger.script_unitrigger_type = "unitrigger_radius_use";
    s_unitrigger.cursor_hint = "HINT_NOICON";
    s_unitrigger.str_hint = str_hint;
    s_unitrigger.related_parent = self;
    s_unitrigger.radius = 64;
    self.s_unitrigger = s_unitrigger;
    zm_unitrigger::register_static_unitrigger(s_unitrigger, &function_77c4e424);
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_77c4e424
// Checksum 0x8b7d888b, Offset: 0x8b60
// Size: 0xa4
function function_77c4e424() {
    self endon(#"death");
    while (true) {
        player = self waittill(#"trigger");
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        self.stub.related_parent notify(#"trigger_activated", player);
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_5d386c43
// Checksum 0xd7124bcf, Offset: 0x8c10
// Size: 0x27c
function function_5d386c43() {
    level flag::init("snow_ee_completed");
    level flag::init("console_one_completed");
    level flag::init("console_two_completed");
    level flag::init("console_three_completed");
    level flag::wait_till("power_on");
    level clientfield::set("console_start", 1);
    level flag::wait_till_all(array("console_one_completed", "console_two_completed", "console_three_completed"));
    exploder::exploder("teleporter_controller_main_light");
    var_d3486562 = struct::get("snowpile_console");
    var_d3486562 create_unitrigger();
    var_d3486562 waittill(#"trigger_activated");
    playsoundatposition("zmb_snowmelt_button_press", var_d3486562.origin);
    zm_unitrigger::unregister_unitrigger(var_d3486562.s_unitrigger);
    level util::clientnotify("sndSB");
    level thread function_428d50ed();
    exploder::exploder("fx_expl_robothead_laser");
    wait(0.5);
    scene::play("p7_fxanim_zm_factory_snowbank_bundle");
    wait(0.5);
    exploder::stop_exploder("fx_expl_robothead_laser");
    mdl_clip = getent("snowbank_clip", "targetname");
    mdl_clip delete();
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_428d50ed
// Checksum 0x497aad85, Offset: 0x8e98
// Size: 0x9c
function function_428d50ed() {
    level flag::set("snow_ee_completed");
    exploder::stop_exploder("teleporter_controller_main_light");
    level clientfield::set("console_blue", 0);
    level clientfield::set("console_green", 0);
    level clientfield::set("console_red", 0);
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_7cb67075
// Checksum 0x3a86a80e, Offset: 0x8f40
// Size: 0x1a6
function function_7cb67075() {
    self endon(#"disconnect");
    level endon(#"hash_497e0707");
    if (level flag::exists("snow_ee_completed") && level flag::get("snow_ee_completed")) {
        return;
    }
    var_f1f15003 = getweapon("cymbal_monkey");
    var_230694a = getentarray("teleporter_radius_trigger", "targetname");
    while (true) {
        e_grenade, w_weapon = self waittill(#"grenade_fire");
        if (w_weapon == var_f1f15003) {
            e_grenade waittill(#"stationary");
            foreach (trigger in var_230694a) {
                if (e_grenade istouching(trigger)) {
                    e_grenade thread function_ffa4d8ca(trigger);
                }
            }
        }
    }
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_ffa4d8ca
// Checksum 0x120f86db, Offset: 0x90f0
// Size: 0xf8
function function_ffa4d8ca(var_7d7ca0ea) {
    if (!isdefined(var_7d7ca0ea.var_634166a2)) {
        var_7d7ca0ea.var_634166a2 = [];
    }
    if (!isdefined(var_7d7ca0ea.var_634166a2)) {
        var_7d7ca0ea.var_634166a2 = [];
    } else if (!isarray(var_7d7ca0ea.var_634166a2)) {
        var_7d7ca0ea.var_634166a2 = array(var_7d7ca0ea.var_634166a2);
    }
    var_7d7ca0ea.var_634166a2[var_7d7ca0ea.var_634166a2.size] = self;
    self waittill(#"death");
    var_7d7ca0ea.var_634166a2 = array::remove_dead(var_7d7ca0ea.var_634166a2);
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_c7b37638
// Checksum 0x6b20a6bc, Offset: 0x91f0
// Size: 0xd6
function function_c7b37638() {
    var_3c2393cb = getent(self.targetname, "script_noteworthy");
    if (isdefined(var_3c2393cb.var_634166a2) && var_3c2393cb.var_634166a2.size) {
        switch (var_3c2393cb.script_noteworthy) {
        case 291:
            level thread function_fdf0e661();
            break;
        case 292:
            level thread function_8fe22c4f();
            break;
        case 293:
            level thread function_4bc4a18d();
            break;
        }
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_fdf0e661
// Checksum 0xafed8b8d, Offset: 0x92d0
// Size: 0x84
function function_fdf0e661() {
    if (!level flag::get("console_one_completed") && !level flag::get("snow_ee_completed")) {
        level flag::set("console_one_completed");
        level clientfield::set("console_blue", 1);
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_8fe22c4f
// Checksum 0x720d3eaa, Offset: 0x9360
// Size: 0x84
function function_8fe22c4f() {
    if (!level flag::get("console_two_completed") && !level flag::get("snow_ee_completed")) {
        level flag::set("console_two_completed");
        level clientfield::set("console_green", 1);
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_4bc4a18d
// Checksum 0x9c3aadfd, Offset: 0x93f0
// Size: 0x84
function function_4bc4a18d() {
    if (!level flag::get("console_three_completed") && !level flag::get("snow_ee_completed")) {
        level flag::set("console_three_completed");
        level clientfield::set("console_red", 1);
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_e0f73644
// Checksum 0x441794c0, Offset: 0x9480
// Size: 0xc0
function function_e0f73644() {
    if (math::cointoss()) {
        level._custom_perks["specialty_staminup"].perk_machine_power_override_thread = &function_384be1c4;
        level._custom_perks["specialty_deadshot"].perk_machine_power_override_thread = &function_49e223a9;
        return;
    }
    level._custom_perks["specialty_deadshot"].perk_machine_power_override_thread = &function_16d38a15;
    level._custom_perks["specialty_staminup"].perk_machine_power_override_thread = &function_6000324c;
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_384be1c4
// Checksum 0x83c2615c, Offset: 0x9548
// Size: 0x4c
function function_384be1c4() {
    zm_perks::perk_machine_removal("specialty_staminup");
    level._custom_perks = array::remove_index(level._custom_perks, "specialty_staminup", 1);
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_16d38a15
// Checksum 0x690c6e42, Offset: 0x95a0
// Size: 0x4c
function function_16d38a15() {
    zm_perks::perk_machine_removal("specialty_deadshot");
    level._custom_perks = array::remove_index(level._custom_perks, "specialty_deadshot", 1);
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_49e223a9
// Checksum 0x56428f27, Offset: 0x95f8
// Size: 0x7c
function function_49e223a9() {
    level waittill(#"start_zombie_round_logic");
    level thread function_8fbb6760("specialty_deadshot");
    level flag::wait_till("snow_ee_completed");
    level thread function_f8f36ff3("specialty_deadshot", level._custom_perks["specialty_deadshot"]);
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_6000324c
// Checksum 0x5c93a368, Offset: 0x9680
// Size: 0x7c
function function_6000324c() {
    level waittill(#"start_zombie_round_logic");
    level thread function_8fbb6760("specialty_staminup");
    level flag::wait_till("snow_ee_completed");
    level thread function_f8f36ff3("specialty_staminup", level._custom_perks["specialty_staminup"]);
}

// Namespace zm_factory
// Params 2, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_f8f36ff3
// Checksum 0x90d13789, Offset: 0x9708
// Size: 0x204
function function_f8f36ff3(str_key, s_custom_perk) {
    machine = getentarray(s_custom_perk.radiant_machine_name, "targetname");
    machine_triggers = getentarray(s_custom_perk.radiant_machine_name, "target");
    for (i = 0; i < machine.size; i++) {
        machine[i] setmodel(level.machine_assets[str_key].on_model);
        machine[i] vibrate((0, -100, 0), 0.3, 0.4, 3);
        machine[i] playsound("zmb_perks_power_on");
        machine[i] thread zm_perks::perk_fx(s_custom_perk.machine_light_effect);
        machine[i] thread zm_perks::play_loop_on_machine();
    }
    level notify(str_key + "_power_on");
    array::thread_all(machine_triggers, &zm_perks::set_power_on, 1);
    if (isdefined(level.machine_assets[str_key].power_on_callback)) {
        array::thread_all(machine, level.machine_assets[str_key].power_on_callback);
    }
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_8fbb6760
// Checksum 0x6d033321, Offset: 0x9918
// Size: 0x54
function function_8fbb6760(str_perk) {
    var_e6579eb2 = getent(str_perk, "script_noteworthy");
    var_e6579eb2 sethintstring(%);
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_d8362620
// Checksum 0x39450f1c, Offset: 0x9978
// Size: 0xc4
function function_d8362620() {
    var_3c100ea1 = struct::get("flytrap_prize", "targetname");
    var_6e1b8eeb = util::spawn_model("wpn_t7_hero_annihilator_world", var_3c100ea1.origin, var_3c100ea1.angles);
    var_6e1b8eeb thread function_45814329(var_3c100ea1);
    level thread function_86e1c543();
    level flag::clear("flytrap");
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_45814329
// Checksum 0x57ddcc88, Offset: 0x9a48
// Size: 0x58
function function_45814329(var_3c100ea1) {
    self endon(#"death");
    while (true) {
        self rotateto(self.angles + (0, 180, 0), 2);
        wait(1.9);
    }
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_86e1c543
// Checksum 0xeea3bb2, Offset: 0x9aa8
// Size: 0x1a0
function function_86e1c543() {
    var_957c9ba0 = getweapon("hero_annihilator");
    while (true) {
        var_65af5e9c = trigger::wait_till("flytrap_prize");
        if (!(isdefined(level.var_1cbe7756) && level.var_1cbe7756)) {
            foreach (player in level.players) {
                level scoreevents::processscoreevent("main_EE_quest_factory", player);
                player zm_stats::increment_global_stat("DARKOPS_FACTORY_EE");
                player zm_stats::increment_global_stat("DARKOPS_FACTORY_SUPER_EE");
            }
            level.var_1cbe7756 = 1;
        }
        player = var_65af5e9c.who;
        if (!player hasweapon(var_957c9ba0)) {
            player function_5d3bb3fe(var_957c9ba0);
        }
    }
}

// Namespace zm_factory
// Params 1, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_5d3bb3fe
// Checksum 0xe1cf96dc, Offset: 0x9c50
// Size: 0x114
function function_5d3bb3fe(var_957c9ba0) {
    w_previous = self getcurrentweapon();
    self zm_weapons::weapon_give(var_957c9ba0);
    self gadgetpowerset(0, 99);
    self switchtoweapon(var_957c9ba0);
    self waittill(#"weapon_change_complete");
    self setlowready(1);
    self switchtoweapon(w_previous);
    self util::waittill_any_timeout(1, "weapon_change_complete");
    self setlowready(0);
    self gadgetpowerset(0, 100);
}

// Namespace zm_factory
// Params 0, eflags: 0x1 linked
// namespace_1437a8b5<file_0>::function_869d6f66
// Checksum 0x452f720a, Offset: 0x9d70
// Size: 0x28
function function_869d6f66() {
    if (!isdefined(self zm_bgb_anywhere_but_here::function_728dfe3())) {
        return false;
    }
    return true;
}

/#

    // Namespace zm_factory
    // Params 0, eflags: 0x1 linked
    // namespace_1437a8b5<file_0>::function_dabc4be1
    // Checksum 0xeea3feb3, Offset: 0x9da0
    // Size: 0x9c
    function function_dabc4be1() {
        var_159034c6 = getent("zombie/fx_bul_flesh_head_nochunks_zmb", "zombie/fx_bul_flesh_head_nochunks_zmb");
        var_5dc8ad42 = getweapon("zombie/fx_bul_flesh_head_nochunks_zmb");
        var_159034c6 dodamage(100, var_159034c6.origin, undefined, undefined, undefined, "zombie/fx_bul_flesh_head_nochunks_zmb", 0, var_5dc8ad42);
    }

    // Namespace zm_factory
    // Params 1, eflags: 0x1 linked
    // namespace_1437a8b5<file_0>::function_35372e3f
    // Checksum 0x7ea28faa, Offset: 0x9e48
    // Size: 0x158
    function function_35372e3f(n_value) {
        if (!level flag::exists("zombie/fx_bul_flesh_head_nochunks_zmb") || !level flag::exists("zombie/fx_bul_flesh_head_nochunks_zmb") || !level flag::exists("zombie/fx_bul_flesh_head_nochunks_zmb") || !level flag::exists("zombie/fx_bul_flesh_head_nochunks_zmb")) {
            return;
        }
        var_ef99f97c = getentarray("zombie/fx_bul_flesh_head_nochunks_zmb", "zombie/fx_bul_flesh_head_nochunks_zmb");
        foreach (trigger in var_ef99f97c) {
            trigger dodamage(100, trigger.origin);
            wait(5);
        }
    }

    // Namespace zm_factory
    // Params 1, eflags: 0x1 linked
    // namespace_1437a8b5<file_0>::function_7c3a679c
    // Checksum 0xccb86760, Offset: 0x9fa8
    // Size: 0xc2
    function function_7c3a679c(n_value) {
        var_957c9ba0 = getweapon("zombie/fx_bul_flesh_head_nochunks_zmb");
        foreach (player in level.activeplayers) {
            player function_5d3bb3fe(var_957c9ba0);
        }
    }

    // Namespace zm_factory
    // Params 1, eflags: 0x1 linked
    // namespace_1437a8b5<file_0>::function_1196e483
    // Checksum 0xb6a5fac3, Offset: 0xa078
    // Size: 0x9a
    function function_1196e483(n_value) {
        foreach (player in level.players) {
            player ability_player::abilities_devgui_power_fill();
        }
    }

    // Namespace zm_factory
    // Params 1, eflags: 0x1 linked
    // namespace_1437a8b5<file_0>::function_75baeb50
    // Checksum 0xb7fb4be2, Offset: 0xa120
    // Size: 0x4c
    function function_75baeb50(n_value) {
        level flag::set("zombie/fx_bul_flesh_head_nochunks_zmb");
        level clientfield::set("zombie/fx_bul_flesh_head_nochunks_zmb", 1);
    }

    // Namespace zm_factory
    // Params 1, eflags: 0x1 linked
    // namespace_1437a8b5<file_0>::function_5e65cea5
    // Checksum 0xc1454745, Offset: 0xa178
    // Size: 0x4c
    function function_5e65cea5(n_value) {
        level flag::set("zombie/fx_bul_flesh_head_nochunks_zmb");
        level clientfield::set("zombie/fx_bul_flesh_head_nochunks_zmb", 1);
    }

    // Namespace zm_factory
    // Params 1, eflags: 0x1 linked
    // namespace_1437a8b5<file_0>::function_71fe81
    // Checksum 0x47006314, Offset: 0xa1d0
    // Size: 0x4c
    function function_71fe81(n_value) {
        level flag::set("zombie/fx_bul_flesh_head_nochunks_zmb");
        level clientfield::set("zombie/fx_bul_flesh_head_nochunks_zmb", 1);
    }

    // Namespace zm_factory
    // Params 0, eflags: 0x1 linked
    // namespace_1437a8b5<file_0>::function_dafe334
    // Checksum 0x8e38f8ac, Offset: 0xa228
    // Size: 0xa0
    function function_dafe334() {
        level flag::set("zombie/fx_bul_flesh_head_nochunks_zmb");
        level flag::set("zombie/fx_bul_flesh_head_nochunks_zmb");
        level flag::set("zombie/fx_bul_flesh_head_nochunks_zmb");
        wait(0.2);
        var_d3486562 = struct::get("zombie/fx_bul_flesh_head_nochunks_zmb");
        var_d3486562 notify(#"trigger_activated");
    }

    // Namespace zm_factory
    // Params 0, eflags: 0x1 linked
    // namespace_1437a8b5<file_0>::function_afea638c
    // Checksum 0x488ffe69, Offset: 0xa2d0
    // Size: 0x1cc
    function function_afea638c() {
        level thread function_72260d3a("zombie/fx_bul_flesh_head_nochunks_zmb", "zombie/fx_bul_flesh_head_nochunks_zmb", 1, &function_75baeb50);
        level thread function_72260d3a("zombie/fx_bul_flesh_head_nochunks_zmb", "zombie/fx_bul_flesh_head_nochunks_zmb", 1, &function_5e65cea5);
        level thread function_72260d3a("zombie/fx_bul_flesh_head_nochunks_zmb", "zombie/fx_bul_flesh_head_nochunks_zmb", 1, &function_71fe81);
        level thread function_72260d3a("zombie/fx_bul_flesh_head_nochunks_zmb", "zombie/fx_bul_flesh_head_nochunks_zmb", 1, &function_dafe334);
        level thread function_72260d3a("zombie/fx_bul_flesh_head_nochunks_zmb", "zombie/fx_bul_flesh_head_nochunks_zmb", 1, &function_dabc4be1);
        level thread function_72260d3a("zombie/fx_bul_flesh_head_nochunks_zmb", "zombie/fx_bul_flesh_head_nochunks_zmb", 1, &function_35372e3f);
        level thread function_72260d3a("zombie/fx_bul_flesh_head_nochunks_zmb", "zombie/fx_bul_flesh_head_nochunks_zmb", 1, &function_7c3a679c);
        level thread function_72260d3a("zombie/fx_bul_flesh_head_nochunks_zmb", "zombie/fx_bul_flesh_head_nochunks_zmb", 1, &function_1196e483);
    }

    // Namespace zm_factory
    // Params 5, eflags: 0x1 linked
    // namespace_1437a8b5<file_0>::function_72260d3a
    // Checksum 0xece2dd4b, Offset: 0xa4a8
    // Size: 0x120
    function function_72260d3a(var_2fa24527, str_dvar, n_value, func, var_f0ee45c9) {
        if (!isdefined(var_f0ee45c9)) {
            var_f0ee45c9 = -1;
        }
        setdvar(str_dvar, var_f0ee45c9);
        adddebugcommand("zombie/fx_bul_flesh_head_nochunks_zmb" + var_2fa24527 + "zombie/fx_bul_flesh_head_nochunks_zmb" + str_dvar + "zombie/fx_bul_flesh_head_nochunks_zmb" + n_value + "zombie/fx_bul_flesh_head_nochunks_zmb");
        while (true) {
            var_608d58e3 = getdvarint(str_dvar);
            if (var_608d58e3 > var_f0ee45c9) {
                [[ func ]](var_608d58e3);
                setdvar(str_dvar, var_f0ee45c9);
            }
            util::wait_network_frame();
        }
    }

#/
