#using scripts/shared/ai/zombie_utility;
#using scripts/zm/_zm_altbody_beast;
#using scripts/zm/_zm_altbody;
#using scripts/zm/zm_zod_zombie;
#using scripts/zm/zm_zod_vo;
#using scripts/zm/zm_zod_util;
#using scripts/zm/zm_zod_traps;
#using scripts/zm/zm_zod_transformer;
#using scripts/zm/zm_zod_train;
#using scripts/zm/zm_zod_sword_quest;
#using scripts/zm/zm_zod_stairs;
#using scripts/zm/zm_zod_smashables;
#using scripts/zm/zm_zod_shadowman;
#using scripts/zm/zm_zod_robot;
#using scripts/zm/zm_zod_poweronswitch;
#using scripts/zm/zm_zod_portals;
#using scripts/zm/zm_zod_pods;
#using scripts/zm/zm_zod_perks;
#using scripts/zm/zm_zod_margwa;
#using scripts/zm/zm_zod_maps;
#using scripts/zm/zm_zod_idgun_quest;
#using scripts/zm/zm_zod_gamemodes;
#using scripts/zm/zm_zod_fx;
#using scripts/zm/zm_zod_ffotd;
#using scripts/zm/zm_zod_ee_side;
#using scripts/zm/zm_zod_ee;
#using scripts/zm/zm_zod_craftables;
#using scripts/zm/zm_zod_cleanup_mgr;
#using scripts/zm/zm_zod_beastcode;
#using scripts/zm/zm_zod_archetype;
#using scripts/zm/zm_zod_achievements;
#using scripts/zm/archetype_zod_companion;
#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
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
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/zm_zod_quest;
#using scripts/zm/zm_zod_defend_areas;
#using scripts/zm/craftables/_zm_craft_shield;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_weap_tesla;
#using scripts/zm/_zm_weap_rocketshield;
#using scripts/zm/_zm_weap_octobomb;
#using scripts/zm/_zm_weap_idgun;
#using scripts/zm/_zm_weap_glaive;
#using scripts/zm/_zm_weap_bowie;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_timer;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_magicbox_zod;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_ai_wasp;
#using scripts/zm/_zm_ai_raps;
#using scripts/zm/_zm_ai_margwa;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/ai/margwa;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/name_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
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
// Checksum 0x2d9e51eb, Offset: 0x25d8
// Size: 0x34
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    level.randomize_perk_machine_location = 1;
    level.pack_a_punch_camo_index = 26;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_d290ebfa
// Checksum 0x9208bca7, Offset: 0x2618
// Size: 0xbec
function main() {
    namespace_b65ec48a::main_start();
    setclearanceceiling(34);
    setdvar("zm_wasp_open_spawning", 1);
    level.var_2bb2277c = 1;
    level.var_6f8e5f09 = [];
    array::add(level.var_6f8e5f09, "boxer");
    array::add(level.var_6f8e5f09, "detective");
    array::add(level.var_6f8e5f09, "femme");
    array::add(level.var_6f8e5f09, "magician");
    level flag::init("train_rode_to_canal");
    level flag::init("train_rode_to_slums");
    level flag::init("train_rode_to_theater");
    level flag::init("idgun_up_for_grabs");
    level flag::init("pod_miasma");
    register_clientfields();
    callback::on_spawned(&on_player_spawned);
    callback::on_spawned(&function_f7d81bd5);
    level._uses_sticky_grenades = 1;
    level._uses_taser_knuckles = 1;
    level._no_vending_machine_auto_collision = 1;
    level.debug_keyline_zombies = 0;
    zm::init_fx();
    namespace_47b9c241::main();
    namespace_5ace0f0e::init();
    namespace_b1ca30af::init();
    level._effect["eye_glow"] = "misc/fx_zombie_eye_single";
    level._effect["eye_glow"] = "zombie/fx_glow_eye_orange_zod";
    level._effect["headshot"] = "zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect["headshot_nochunks"] = "zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect["bloodspurt"] = "zombie/fx_bul_flesh_neck_spurt_zmb";
    level._effect["animscript_gib_fx"] = "zombie/fx_blood_torso_explo_zmb";
    level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
    level._effect["switch_sparks"] = "electric/fx_elec_sparks_directional_orange";
    level.default_start_location = "start_room";
    level.default_game_mode = "zclassic";
    level.precachecustomcharacters = &precachecustomcharacters;
    level.givecustomcharacters = &givecustomcharacters;
    level thread setup_personality_character_exerts();
    initcharacterstartindex();
    level.var_f55453ea = &offhand_weapon_overrride;
    level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
    level.var_237b30e2 = &function_7837e42a;
    level thread custom_add_vox();
    level._allow_melee_weapon_switching = 1;
    level.zombiemode_reusing_pack_a_punch = 1;
    level.do_randomized_zigzag_path = 1;
    level.enemy_location_override_func = &function_ec0a572;
    level.no_target_override = &no_target_override;
    level.player_out_of_playable_area_override = &player_out_of_playable_area_override;
    level.zm_custom_spawn_location_selection = &function_2c092767;
    level.var_ad6409de = &function_612012aa;
    level.var_507242bb = &function_612012aa;
    level.var_300c5ed6 = &function_f88e4c70;
    level.var_9cef605e = &function_89b7689f;
    level.var_2300a8ad = &function_42cc727b;
    level.var_2d0e5eb6 = &function_2d0e5eb6;
    level.var_2c12d9a6 = &function_533186ee;
    level.var_4cf8bbbd = &function_4cf8bbbd;
    level.var_d74f517d = &function_63f29efd;
    level.var_661e1459 = &function_661e1459;
    level.var_716fc13e = &function_716fc13e;
    level.var_ae6ced2b = &function_80ba9218;
    include_weapons();
    function_2a476331();
    level.var_809c5639 = function_86c4a7ba();
    level._custom_perks["specialty_quickrevive"].cost = &function_72474405;
    namespace_bb738c6::init();
    namespace_f37770c8::init();
    namespace_4624f91a::function_cdc13aec();
    namespace_4624f91a::function_3ebec56b();
    namespace_4624f91a::function_95743e9f();
    load::main();
    setdvar("doublejump_enabled", 1);
    setdvar("playerEnergy_enabled", 1);
    setdvar("wallrun_enabled", 1);
    level thread function_4df9f4ad();
    setdvar("ai_threatUpdateInterval", 50);
    namespace_40b4687d::init();
    level.customrandomweaponweights = &function_e4795b73;
    level.special_weapon_magicbox_check = &function_69030873;
    level._round_start_func = &zm::round_start;
    level.fn_custom_round_ai_spawn = &function_33aa4940;
    level thread function_631e737d();
    level.fn_custom_zombie_spawner_selection = &function_b05d27ad;
    level thread function_48fda59a();
    level.var_e863f304 = undefined;
    level.func_get_zombie_spawn_delay = &function_59804866;
    level.func_get_delay_between_rounds = &function_5ee4c46c;
    level._zombiemode_post_respawn_callback = &function_afdf4111;
    init_sounds();
    namespace_5ace0f0e::function_9eddef7d();
    namespace_b1ca30af::function_9160f2b2();
    namespace_d17e1da0::function_5e93cd08();
    level.var_45145796 = &namespace_54bf13f5::function_14e2eca6;
    level.var_9b5d7667 = &namespace_ba13c715::function_37dc5568;
    level.var_7cef68dc = &namespace_54bf13f5::function_c3ffc175;
    level.player_intersection_tracker_override = &function_d034d8ff;
    level.zones = [];
    level.zone_manager_init_func = &function_aec34876;
    init_zones[0] = "zone_start";
    level thread zm_zonemgr::manage_zones(init_zones);
    level.zombie_ai_limit = 24;
    level.default_laststandpistol = getweapon("pistol_revolver38");
    level.default_solo_laststandpistol = getweapon("pistol_revolver38_upgraded");
    level.laststandpistol = level.default_laststandpistol;
    level.start_weapon = level.default_laststandpistol;
    level thread zm::function_e7cfa7b8();
    level thread namespace_ba13c715::function_189ed812();
    level thread namespace_54c8dc69::main();
    level thread namespace_d8d03071::init_traps();
    level thread namespace_1f61c67f::function_f6527c1e();
    level thread namespace_9d6f65aa::init();
    level thread setupmusic();
    level.var_352c26bc = &function_ad6c63c9;
    zm_powerups::powerup_remove_from_regular_drops("bonus_points_team");
    level thread beast_mode();
    zombie_utility::set_zombie_var("zombie_powerup_drop_max_per_round", 2);
    level thread function_b39e79fa();
    level thread function_ad7e91d7();
    function_6364bd7d();
    level thread namespace_2cce1885::init();
    level thread namespace_b361ecc3::init();
    level thread function_f480dd11();
    level thread function_c257bc23();
    level thread util::set_lighting_state(0);
    level thread function_22eef972();
    level thread function_aab1d0bd();
    level thread function_a988e9bb();
    level thread function_bef9943a();
    level thread function_47f0c5f1();
    /#
        function_c9e2531c();
        function_c876231d();
        setup_devgui();
    #/
    namespace_b65ec48a::main_end();
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_47f0c5f1
// Checksum 0xfc377d52, Offset: 0x3210
// Size: 0xfa
function function_47f0c5f1() {
    zombie_doors = getentarray("zombie_door", "targetname");
    foreach (door in zombie_doors) {
        if (door.script_flag == "connect_start_to_junction") {
            door.zombie_cost = 500;
            door zm_utility::set_hint_string(door, "default_buy_door", door.zombie_cost);
        }
    }
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_d034d8ff
// Checksum 0x5bcc75c5, Offset: 0x3318
// Size: 0x56
function function_d034d8ff(other_player) {
    if (isdefined(self.var_65f06b5) && self.var_65f06b5) {
        return true;
    }
    if (isdefined(other_player.var_65f06b5) && other_player.var_65f06b5) {
        return true;
    }
    return false;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_4cf8bbbd
// Checksum 0x174feda9, Offset: 0x3378
// Size: 0x18
function function_4cf8bbbd() {
    if (isdefined(level.var_f6c5842)) {
        return true;
    }
    return false;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_63f29efd
// Checksum 0xedfc21e4, Offset: 0x3398
// Size: 0x28
function function_63f29efd() {
    if (isdefined(level.var_46040f3e) && level.var_46040f3e == 1) {
        return false;
    }
    return true;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_661e1459
// Checksum 0xc322ded, Offset: 0x33c8
// Size: 0x44
function function_661e1459() {
    players = getplayers();
    if (isdefined(level.var_f6c5842)) {
        players[players.size] = level.var_f6c5842;
    }
    return players;
}

// Namespace zm_zod
// Params 2, eflags: 0x4
// namespace_bcfa45b0<file_0>::function_2ddb8d5d
// Checksum 0x8871dc7c, Offset: 0x3418
// Size: 0x132
function private function_2ddb8d5d(origin, entities) {
    closest = spawnstruct();
    if (entities.size > 0) {
        closest.distancesquared = distancesquared(origin, entities[0].origin);
        closest.entity = entities[0];
        for (index = 1; index < entities.size; index++) {
            distancesquared = distancesquared(origin, entities[index].origin);
            if (distancesquared < closest.distancesquared) {
                closest.distancesquared = distancesquared;
                closest.entity = entities[index];
            }
        }
    }
    return closest;
}

// Namespace zm_zod
// Params 2, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_8277f5c9
// Checksum 0xc61bd3ad, Offset: 0x3558
// Size: 0x1a0
function closest_player_override(origin, players) {
    aiprofile_beginentry("zod-closest_player_override");
    player = arraygetclosest(origin, players);
    ai = getactorteamarray("allies");
    foreach (value in ai) {
        if (value.allow_zombie_to_target_ai === 1) {
            var_e2841a72 = distancesquared(origin, player.origin);
            var_ef51fe37 = distancesquared(origin, value.origin);
            if (var_ef51fe37 < var_e2841a72) {
                aiprofile_endentry();
                return value;
            }
        }
    }
    aiprofile_endentry();
    return player;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_2d0e5eb6
// Checksum 0x7434076a, Offset: 0x3700
// Size: 0x180
function function_2d0e5eb6() {
    var_5cf494cb = getarraykeys(level.zombie_powerups);
    var_b4442b55 = array("bonus_points_team", "shield_charge", "ww_grenade");
    powerup_keys = [];
    for (i = 0; i < var_5cf494cb.size; i++) {
        var_77917a61 = 0;
        foreach (var_68de493a in var_b4442b55) {
            if (var_5cf494cb[i] == var_68de493a) {
                var_77917a61 = 1;
            }
        }
        if (var_77917a61) {
            continue;
        }
        powerup_keys[powerup_keys.size] = var_5cf494cb[i];
    }
    powerup_keys = array::randomize(powerup_keys);
    return powerup_keys[0];
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_533186ee
// Checksum 0xbaf62256, Offset: 0x3888
// Size: 0x102
function function_533186ee() {
    var_5f66b0c7 = level clientfield::get("ee_quest_state");
    if (var_5f66b0c7 == 1) {
        var_18bac0f0 = array((2544, -3432, -368), (2708, -3432, -368), (2544, -3624, -368), (2708, -3624, -368));
        v_spawn = array::random(var_18bac0f0);
        s_spawnpoint = spawnstruct();
        s_spawnpoint.origin = v_spawn;
        return s_spawnpoint;
    }
    return self zm_bgb_anywhere_but_here::function_728dfe3();
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_ad7e91d7
// Checksum 0x800e2e45, Offset: 0x3998
// Size: 0x64
function function_ad7e91d7() {
    level waittill(#"specialty_quickrevive_power_on");
    if (!level flag::exists("solo_revive")) {
        level flag::init("solo_revive");
    }
    level.var_8e77ad87 = &function_86c4a7ba;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_86c4a7ba
// Checksum 0x82508c00, Offset: 0x3a08
// Size: 0x70
function function_86c4a7ba() {
    players = getplayers();
    var_2d92a626 = 0;
    if (isdefined(level.var_1bc2b35c) && (players.size == 1 || level.var_1bc2b35c)) {
        var_2d92a626 = 1;
    }
    level.var_809c5639 = var_2d92a626;
    return var_2d92a626;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_72474405
// Checksum 0xc467ec44, Offset: 0x3a80
// Size: 0x38
function function_72474405() {
    var_b93a49d8 = function_29a73d02();
    if (var_b93a49d8) {
        return 500;
    }
    return 1500;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_29a73d02
// Checksum 0x5074cb84, Offset: 0x3ac0
// Size: 0x70
function function_29a73d02() {
    players = getplayers();
    var_2d92a626 = 0;
    if (isdefined(level.var_1bc2b35c) && (players.size == 1 || level.var_1bc2b35c)) {
        var_2d92a626 = 1;
    }
    level.var_f46aa53 = var_2d92a626;
    return var_2d92a626;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_aebcf025
// Checksum 0x2883a74f, Offset: 0x3b38
// Size: 0x64
function on_player_spawned() {
    self thread function_73dee914();
    self thread function_8535c602();
    self allowwallrun(0);
    self allowdoublejump(0);
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_4ece4a2f
// Checksum 0xe60c9184, Offset: 0x3ba8
// Size: 0x46c
function register_clientfields() {
    clientfield::register("toplayer", "fullscreen_rain_fx", 1, 1, "int");
    clientfield::register("world", "rain_state", 1, 1, "int");
    n_bits = getminbitcountfornum(8);
    clientfield::register("toplayer", "player_rumble_and_shake", 1, n_bits, "int");
    clientfield::register("toplayer", "devgui_lightning_test", 1, 1, "counter");
    clientfield::register("actor", "ghost_actor", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.player_character_identity", 1, getminbitcountfornum(4), "int");
    clientfield::register("clientuimodel", "zmInventory.player_using_sprayer", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.player_crafted_fusebox", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.player_crafted_shield", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.player_crafted_idgun", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.player_sword_quest_egg_state", 1, getminbitcountfornum(7), "int");
    clientfield::register("clientuimodel", "zmInventory.player_sword_quest_completed_level_1", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_quest_items", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_idgun_parts", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_shield_parts", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_fuses", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_egg", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_sprayer", 1, 1, "int");
    clientfield::register("world", "hide_perf_static_models", 1, 1, "int");
    clientfield::register("world", "breakable_show", 1, 3, "int");
    clientfield::register("world", "breakable_hide", 1, 3, "int");
    visionset_mgr::register_info("visionset", "zombie_noire", 1, 2, 1, 1);
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_73dee914
// Checksum 0xf085377d, Offset: 0x4020
// Size: 0x64
function function_73dee914() {
    self endon(#"death");
    util::wait_network_frame();
    util::wait_network_frame();
    self.var_1b3b1022 = 1;
    self clientfield::set_to_player("fullscreen_rain_fx", 1);
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_6364bd7d
// Checksum 0x4597743e, Offset: 0x4090
// Size: 0xb2
function function_6364bd7d() {
    var_917cd731 = getentarray("trig_rain_indoor", "targetname");
    foreach (e_trig in var_917cd731) {
        e_trig thread function_3187983c();
    }
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_3187983c
// Checksum 0x8dbf4444, Offset: 0x4150
// Size: 0x68
function function_3187983c() {
    while (true) {
        e_player = self waittill(#"trigger");
        if (isdefined(e_player.var_1b3b1022) && e_player.var_1b3b1022) {
            e_player thread function_c0861aa3(self);
        }
    }
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_c0861aa3
// Checksum 0x2e63e656, Offset: 0x41c0
// Size: 0x84
function function_c0861aa3(e_trig) {
    self endon(#"disconnect");
    self.var_1b3b1022 = 0;
    self clientfield::set_to_player("fullscreen_rain_fx", 0);
    util::wait_till_not_touching(e_trig, self);
    self.var_1b3b1022 = 1;
    self clientfield::set_to_player("fullscreen_rain_fx", 1);
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_ad6c63c9
// Checksum 0xb75b6b6e, Offset: 0x4250
// Size: 0x10
function function_ad6c63c9(player) {
    return true;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_51dea2b0
// Checksum 0xadc56f8e, Offset: 0x4268
// Size: 0x2c
function beast_mode() {
    function_44f3945c();
    level.player_out_of_playable_area_monitor_callback = &player_out_of_playable_area_monitor_callback;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_a44c4a35
// Checksum 0x268a399e, Offset: 0x42a0
// Size: 0x38
function player_out_of_playable_area_monitor_callback() {
    if (isdefined(self.beastmode) && self.beastmode && !self zm::in_kill_brush()) {
        return false;
    }
    return true;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_44f3945c
// Checksum 0x46da82bf, Offset: 0x42e0
// Size: 0xe2
function function_44f3945c() {
    var_a06945ee = getentarray("grapple_target", "targetname");
    foreach (thing in var_a06945ee) {
        thing clientfield::set("bminteract", 3);
        thing notsolid();
        wait(0.05);
    }
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_b39e79fa
// Checksum 0x2664088, Offset: 0x43d0
// Size: 0x162
function function_b39e79fa() {
    zm_powerups::powerup_round_start();
    var_d54b1ec = [];
    array::add(var_d54b1ec, "double_points");
    array::add(var_d54b1ec, "insta_kill");
    array::add(var_d54b1ec, "full_ammo");
    var_16137be6 = struct::get_array("placed_powerup", "targetname");
    foreach (var_f06a36e0 in var_16137be6) {
        str_type = array::random(var_d54b1ec);
        spawn_infinite_powerup_drop(var_f06a36e0.origin, str_type);
    }
}

// Namespace zm_zod
// Params 2, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_bcb35c8c
// Checksum 0xf35920f3, Offset: 0x4540
// Size: 0x8a
function spawn_infinite_powerup_drop(v_origin, str_type) {
    level._powerup_timeout_override = &function_255b493a;
    if (isdefined(str_type)) {
        var_d4f0bf10 = zm_powerups::specific_powerup_drop(str_type, v_origin);
    } else {
        var_d4f0bf10 = zm_powerups::powerup_drop(v_origin);
    }
    level._powerup_timeout_override = undefined;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_255b493a
// Checksum 0x99ec1590, Offset: 0x45d8
// Size: 0x4
function function_255b493a() {
    
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_8eca036a
// Checksum 0xa1e5719a, Offset: 0x45e8
// Size: 0x84
function init_sounds() {
    zm_utility::add_sound("break_stone", "evt_break_stone");
    zm_utility::add_sound("gate_door", "zmb_gate_slide_open");
    zm_utility::add_sound("heavy_door", "zmb_heavy_door_open");
    zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_2a476331
// Checksum 0x87119ec9, Offset: 0x4678
// Size: 0x24
function function_2a476331() {
    level.random_pandora_box_start = 1;
    namespace_cfbe948b::init();
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_3faace81
// Checksum 0x2c55df5f, Offset: 0x46a8
// Size: 0xbe
function offhand_weapon_overrride() {
    zm_utility::register_lethal_grenade_for_level("frag_grenade");
    level.zombie_lethal_grenade_player_init = getweapon("frag_grenade");
    zm_utility::register_tactical_grenade_for_level("octobomb");
    zm_utility::register_tactical_grenade_for_level("octobomb_upgraded");
    zm_utility::register_melee_weapon_for_level(level.weaponbasemelee.name);
    level.zombie_melee_weapon_player_init = level.weaponbasemelee;
    zm_utility::register_melee_weapon_for_level("bowie_knife");
    level.zombie_equipment_player_init = undefined;
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_a0a06075
// Checksum 0x8eda0ed5, Offset: 0x4770
// Size: 0xbe
function offhand_weapon_give_override(str_weapon) {
    self endon(#"death");
    if (zm_utility::is_tactical_grenade(str_weapon) && isdefined(self zm_utility::get_player_tactical_grenade()) && !self zm_utility::is_player_tactical_grenade(str_weapon)) {
        self setweaponammoclip(self zm_utility::get_player_tactical_grenade(), 0);
        self takeweapon(self zm_utility::get_player_tactical_grenade());
    }
    return false;
}

// Namespace zm_zod
// Params 2, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_7ee99749
// Checksum 0xb93972ca, Offset: 0x4838
// Size: 0x64
function function_7ee99749(triggername, var_caee4409) {
    var_d489585b = getentarray(triggername, "targetname");
    array::thread_all(var_d489585b, &function_19d7ddf3, var_caee4409);
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_19d7ddf3
// Checksum 0xe443903b, Offset: 0x48a8
// Size: 0x10e
function function_19d7ddf3(var_caee4409) {
    var_c99c73fc = getentarray(var_caee4409, "targetname");
    for (i = 0; i < var_c99c73fc.size; i++) {
        var_c99c73fc[i] hide();
    }
    self waittill(#"trigger");
    for (i = 0; i < var_c99c73fc.size; i++) {
        var_c99c73fc[i] show();
        var_c99c73fc[i] connectpaths();
        var_c99c73fc[i] setmovingplatformenabled(1);
    }
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_aec34876
// Checksum 0x4f45c52c, Offset: 0x49c0
// Size: 0x24dc
function function_aec34876() {
    zm_zonemgr::zone_init("zone_teleport", 0);
    zm_zonemgr::zone_init("zone_train_rail", 0);
    zm_zonemgr::enable_zone("zone_teleport");
    zm_zonemgr::enable_zone("zone_train_rail");
    zm_zonemgr::add_adjacent_zone("zone_start", "zone_junction_start", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_start", "zone_start_high", "connect_start_to_magician", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_start_high", "zone_start", "connect_start_to_magician", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_start_high", "zone_start_magician", "connect_start_to_magician", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_start_magician", "zone_start_high", "connect_start_to_magician", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_start_magician", "zone_start_magician_high", "connect_start_to_magician", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_start_magician_high", "zone_start_magician", "connect_start_to_magician", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_start_magician_high", "zone_start_fire_escape", "connect_start_to_magician", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_start_fire_escape", "zone_start", "connect_start_to_magician", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_start_fire_escape", "zone_junction_start", "connect_start_to_magician", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_start_fire_escape", "zone_junction_canal", "connect_start_to_magician", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_start_fire_escape", "zone_start_magician_high", "connect_start_to_magician", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_start", "zone_junction_canal", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_start", "zone_junction_slums", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_start", "zone_junction_theater", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_start", "zone_start", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_start", "zone_start_fire_escape", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_slums", "zone_junction_start", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_slums", "zone_junction_canal", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_slums", "zone_junction_theater", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_slums", "zone_slums_junction", "connect_slums_to_junction", 1, 0, 1);
    zm_zonemgr::add_adjacent_zone("zone_junction_canal", "zone_junction_start", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_canal", "zone_junction_slums", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_canal", "zone_junction_theater", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_canal", "zone_canal_junction", "connect_canal_to_junction", 1, 0, 1);
    zm_zonemgr::add_adjacent_zone("zone_junction_theater", "zone_junction_canal", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_theater", "zone_junction_start", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_theater", "zone_junction_slums", "connect_start_to_junction", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_junction_theater", "zone_theater_junction", "connect_theater_to_junction", 1, 0, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_junction", "zone_junction_canal", "connect_canal_to_junction", 1, 1, 0);
    zm_zonemgr::add_adjacent_zone("zone_canal_junction", "zone_canal_A", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_junction", "zone_canal_B", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_junction", "zone_canal_high_A", "connect_canal_high_to_low", 1, 1, 3);
    zm_zonemgr::add_adjacent_zone("zone_canal_A", "zone_canal_junction", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_A", "zone_canal_B", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_A", "zone_canal_C", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_A", "zone_canal_water_A", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_B", "zone_canal_junction", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_B", "zone_canal_A", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_B", "zone_canal_water_A", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_C", "zone_canal_junction", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_C", "zone_canal_B", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_C", "zone_canal_D", "connect_canal_to_train", 1, 1, 2);
    zm_zonemgr::add_adjacent_zone("zone_canal_C", "zone_canal_E", "connect_canal_to_train", 1, 1, 2);
    zm_zonemgr::add_adjacent_zone("zone_canal_C", "zone_canal_water_B", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_C", "zone_canal_water_C", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_D", "zone_canal_C", "connect_canal_to_train", 1, 2, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_D", "zone_canal_E", "activate_brothel_street", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_canal_D", "zone_canal_train", "activate_brothel_street", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_canal_D", "zone_canal_high_C", "connect_canal_high_to_train", 1, 2, 3);
    zm_zonemgr::add_adjacent_zone("zone_canal_D", "zone_canal_brothel", "connect_canal_to_brothel", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_canal_E", "zone_canal_C", "connect_canal_to_train", 1, 2, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_E", "zone_canal_D", "activate_brothel_street", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_canal_E", "zone_canal_train", "activate_brothel_street", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_canal_E", "zone_canal_high_C", "connect_canal_high_to_train", 1, 2, 3);
    zm_zonemgr::add_adjacent_zone("zone_canal_E", "zone_canal_brothel", "connect_canal_to_brothel", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_canal_train", "zone_canal_C", "connect_canal_to_brothel", 1, 2, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_train", "zone_canal_D", "activate_brothel_street", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_canal_train", "zone_canal_E", "activate_brothel_street", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_canal_train", "zone_canal_high_C", "connect_canal_high_to_train", 1, 2, 3);
    zm_zonemgr::add_adjacent_zone("zone_canal_water_A", "zone_canal_water_B", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_water_A", "zone_canal_water_C", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_water_B", "zone_canal_water_A", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_water_B", "zone_canal_water_C", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_water_C", "zone_canal_water_A", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_water_C", "zone_canal_water_B", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_water_C", "zone_canal_C", "activate_canal", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_water_C", "zone_canal_D", "connect_canal_to_train", 1, 1, 2);
    zm_zonemgr::add_adjacent_zone("zone_canal_water_C", "zone_canal_E", "connect_canal_to_train", 1, 1, 2);
    zm_zonemgr::add_adjacent_zone("zone_canal_high_A", "zone_canal_high_B", "activate_canal_high", 1, 3, 3);
    zm_zonemgr::add_adjacent_zone("zone_canal_high_A", "zone_canal_junction", "connect_canal_high_to_low", 1, 3, 1);
    zm_zonemgr::add_adjacent_zone("zone_canal_high_B", "zone_canal_high_A", "activate_canal_high", 1, 3, 3);
    zm_zonemgr::add_adjacent_zone("zone_canal_high_B", "zone_canal_high_C", "connect_canal_high_to_train", 1, 3, 3);
    zm_zonemgr::add_adjacent_zone("zone_canal_high_C", "zone_canal_high_B", "connect_canal_high_to_train", 1, 3, 3);
    zm_zonemgr::add_adjacent_zone("zone_canal_high_C", "zone_canal_train", "connect_canal_high_to_train", 1, 3, 2);
    zm_zonemgr::add_adjacent_zone("zone_canal_brothel", "zone_canal_D", "connect_canal_to_brothel", 1, 2, 2);
    zm_zonemgr::add_zone_flags("connect_canal_to_junction", "activate_canal");
    zm_zonemgr::add_zone_flags("connect_canal_high_to_low", "activate_canal");
    zm_zonemgr::add_zone_flags("connect_canal_high_to_low", "activate_canal_high");
    zm_zonemgr::add_zone_flags("connect_canal_to_train", "activate_brothel_street");
    zm_zonemgr::add_zone_flags("connect_canal_to_train", "activate_canal");
    zm_zonemgr::add_zone_flags("connect_canal_high_to_train", "activate_brothel_street");
    zm_zonemgr::add_zone_flags("connect_canal_high_to_train", "activate_canal_high");
    zm_zonemgr::add_adjacent_zone("zone_slums_junction", "zone_junction_slums", "connect_slums_to_junction", 1, 1, 0);
    zm_zonemgr::add_adjacent_zone("zone_slums_junction", "zone_slums_A", "activate_slums_junction_alley", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_slums_junction", "zone_slums_high_A", "connect_slums_high_to_low", 1, 1, 3);
    zm_zonemgr::add_adjacent_zone("zone_slums_A", "zone_slums_junction", "activate_slums_junction_alley", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_slums_A", "zone_slums_B", "activate_slums_junction_alley", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_slums_B", "zone_slums_A", "activate_slums_junction_alley", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_slums_B", "zone_slums_C", "connect_slums_waterfront_to_alley", 1, 1, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_C", "zone_slums_B", "connect_slums_waterfront_to_alley", 1, 2, 1);
    zm_zonemgr::add_adjacent_zone("zone_slums_C", "zone_slums_D", "activate_slums_waterfront", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_C", "zone_slums_train", "activate_slums_waterfront", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_D", "zone_slums_C", "activate_slums_waterfront", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_D", "zone_slums_E", "activate_slums_waterfront", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_D", "zone_slums_train", "activate_slums_waterfront", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_E", "zone_slums_D", "activate_slums_waterfront", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_E", "zone_slums_gym", "connect_slums_waterfront_to_gym", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_train", "zone_slums_C", "activate_slums_waterfront", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_train", "zone_slums_D", "activate_slums_waterfront", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_train", "zone_slums_high_E", "connect_slums_high_to_train", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_train", "zone_slums_high_F", "connect_slums_high_to_train", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_gym", "zone_slums_E", "connect_slums_waterfront_to_gym", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_gym", "zone_slums_gym_lockers", "connect_slums_waterfront_to_gym", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_gym_lockers", "zone_slums_E", "connect_slums_waterfront_to_gym", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_gym_lockers", "zone_slums_gym", "connect_slums_waterfront_to_gym", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_high_A", "zone_slums_junction", "connect_slums_high_to_low", 1, 3, 1);
    zm_zonemgr::add_adjacent_zone("zone_slums_high_A", "zone_slums_high_B", "activate_slums_high", 1, 3, 3);
    zm_zonemgr::add_adjacent_zone("zone_slums_high_B", "zone_slums_high_A", "activate_slums_high", 1, 3, 3);
    zm_zonemgr::add_adjacent_zone("zone_slums_high_B", "zone_slums_high_C", "connect_slums_high_to_train", 1, 3, 3);
    zm_zonemgr::add_adjacent_zone("zone_slums_high_C", "zone_slums_high_B", "connect_slums_high_to_train", 1, 3, 3);
    zm_zonemgr::add_adjacent_zone("zone_slums_high_C", "zone_slums_high_D", "connect_slums_high_to_train", 1, 3, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_high_D", "zone_slums_high_C", "connect_slums_high_to_train", 1, 2, 3);
    zm_zonemgr::add_adjacent_zone("zone_slums_high_D", "zone_slums_high_E", "connect_slums_high_to_train", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_high_E", "zone_slums_high_D", "connect_slums_high_to_train", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_high_E", "zone_slums_high_F", "connect_slums_high_to_train", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_high_F", "zone_slums_high_E", "connect_slums_high_to_train", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_slums_high_F", "zone_slums_train", "connect_slums_high_to_train", 1, 2, 2);
    zm_zonemgr::add_zone_flags("connect_slums_to_junction", "activate_slums_junction_alley");
    zm_zonemgr::add_zone_flags("connect_slums_waterfront_to_alley", "activate_slums_junction_alley");
    zm_zonemgr::add_zone_flags("connect_slums_waterfront_to_alley", "activate_slums_waterfront");
    zm_zonemgr::add_zone_flags("connect_slums_high_to_low", "activate_slums_junction_alley");
    zm_zonemgr::add_zone_flags("connect_slums_high_to_low", "activate_slums_high");
    zm_zonemgr::add_zone_flags("connect_slums_high_to_train", "activate_slums_waterfront");
    zm_zonemgr::add_zone_flags("connect_slums_high_to_train", "activate_slums_high");
    zm_zonemgr::add_adjacent_zone("zone_theater_junction", "zone_junction_theater", "connect_theater_to_junction", 1, 1, 0);
    zm_zonemgr::add_adjacent_zone("zone_theater_junction", "zone_theater_A", "activate_theater_alley", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_theater_A", "zone_theater_junction", "activate_theater_alley", 1, 1, 1);
    zm_zonemgr::add_adjacent_zone("zone_theater_A", "zone_theater_B", "connect_theater_alley_to_square", 1, 1, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_A", "zone_theater_high_A", "connect_theater_high_to_low", 1, 1, 3);
    zm_zonemgr::add_adjacent_zone("zone_theater_B", "zone_theater_A", "connect_theater_alley_to_square", 1, 2, 1);
    zm_zonemgr::add_adjacent_zone("zone_theater_B", "zone_theater_C", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_B", "zone_theater_D", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_B", "zone_theater_E", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_C", "zone_theater_B", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_C", "zone_theater_E", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_C", "zone_theater_train", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_C", "zone_theater_high_D", "connect_theater_high_to_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_D", "zone_theater_B", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_D", "zone_theater_E", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_D", "zone_theater_F", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_E", "zone_theater_B", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_E", "zone_theater_C", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_E", "zone_theater_D", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_E", "zone_theater_F", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_F", "zone_theater_D", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_F", "zone_theater_E", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_F", "zone_theater_burlesque_entrance", "connect_theater_to_burlesque", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_high_A", "zone_theater_junction", "connect_theater_high_to_low", 1, 3, 1);
    zm_zonemgr::add_adjacent_zone("zone_theater_high_A", "zone_theater_A", "connect_theater_high_to_low", 1, 3, 1);
    zm_zonemgr::add_adjacent_zone("zone_theater_high_A", "zone_theater_high_B", "activate_theater_high", 1, 3, 3);
    zm_zonemgr::add_adjacent_zone("zone_theater_high_B", "zone_theater_high_A", "activate_theater_high", 1, 3, 3);
    zm_zonemgr::add_adjacent_zone("zone_theater_high_B", "zone_theater_high_C", "connect_theater_high_to_square", 1, 3, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_high_C", "zone_theater_high_B", "connect_theater_high_to_square", 1, 2, 3);
    zm_zonemgr::add_adjacent_zone("zone_theater_high_C", "zone_theater_high_D", "connect_theater_high_to_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_high_D", "zone_theater_high_C", "connect_theater_high_to_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_high_D", "zone_theater_train", "connect_theater_high_to_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_high_D", "zone_theater_C", "connect_theater_high_to_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_train", "zone_theater_high_D", "connect_theater_high_to_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_train", "zone_theater_C", "activate_theater_square", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_burlesque_entrance", "zone_theater_F", "connect_theater_to_burlesque", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_burlesque_entrance", "zone_theater_burlesque", "connect_theater_to_burlesque", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_burlesque", "zone_theater_burlesque_entrance", "connect_theater_to_burlesque", 1, 2, 2);
    zm_zonemgr::add_adjacent_zone("zone_theater_burlesque", "zone_theater_F", "connect_theater_to_burlesque", 1, 2, 2);
    zm_zonemgr::add_zone_flags("connect_theater_to_junction", "activate_theater_alley");
    zm_zonemgr::add_zone_flags("connect_theater_alley_to_square", "activate_theater_alley");
    zm_zonemgr::add_zone_flags("connect_theater_alley_to_square", "activate_theater_square");
    zm_zonemgr::add_zone_flags("connect_theater_high_to_square", "activate_theater_square");
    zm_zonemgr::add_zone_flags("connect_theater_high_to_square", "activate_theater_high");
    zm_zonemgr::add_zone_flags("connect_theater_high_to_square", "activate_theater_alley");
    zm_zonemgr::add_zone_flags("connect_theater_high_to_low", "activate_theater_alley");
    zm_zonemgr::add_zone_flags("connect_theater_high_to_low", "activate_theater_high");
    zm_zonemgr::add_adjacent_zone("zone_subway_pap_ritual", "zone_subway_pap", "pap_door_open", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_subway_pap_ritual", "zone_subway_north", "pap_door_open", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_subway_pap", "zone_subway_pap_ritual", "pap_door_open", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_subway_north", "zone_subway_pap", "pap_door_open", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_subway_north", "zone_subway_central", "activate_underground", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_subway_central", "zone_subway_north", "activate_underground", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_subway_central", "zone_subway_junction", "activate_underground", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_subway_junction", "zone_subway_central", "activate_underground", 1, 0, 0);
    zm_zonemgr::add_adjacent_zone("zone_subway_junction", "zone_junction_theater", "connect_subway_to_junction", 1, 0, 0);
    zm_zonemgr::add_zone_flags("connect_subway_to_junction", "activate_underground");
    level thread function_8462bb2e();
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_8462bb2e
// Checksum 0xd382354d, Offset: 0x6ea8
// Size: 0x1dc
function function_8462bb2e() {
    level flag::wait_till("zones_initialized");
    level.var_37e8a32e = [];
    var_ddd4dbb4 = getentarray("district_area", "targetname");
    foreach (var_17d18e45 in var_ddd4dbb4) {
        if (!isdefined(level.var_37e8a32e[var_17d18e45.script_noteworthy])) {
            level.var_37e8a32e[var_17d18e45.script_noteworthy] = var_17d18e45;
        }
    }
    level.var_37e8a32e["slums"] thread function_4edf07a("connect_slums_to_junction", "connect_slums_waterfront_to_alley", "connect_slums_high_to_low", "connect_slums_high_to_train");
    level.var_37e8a32e["canal"] thread function_4edf07a("connect_canal_to_junction", "connect_canal_to_train", "connect_canal_high_to_low", "connect_canal_high_to_train");
    level.var_37e8a32e["theater"] thread function_4edf07a("connect_theater_to_junction", "connect_theater_alley_to_square", "connect_theater_high_to_low", "connect_theater_high_to_square");
}

// Namespace zm_zod
// Params 4, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_4edf07a
// Checksum 0x80127b87, Offset: 0x7090
// Size: 0x60
function function_4edf07a(var_a3958f28, var_f8f2bd2c, var_2d938fe3, var_e4bb21a8) {
    self.var_f380b01d = 0;
    function_34cf312d(var_a3958f28, var_f8f2bd2c, var_2d938fe3, var_e4bb21a8);
    self.var_f380b01d = 1;
}

// Namespace zm_zod
// Params 4, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_34cf312d
// Checksum 0xcb421aa8, Offset: 0x70f8
// Size: 0x8c
function function_34cf312d(var_a3958f28, var_f8f2bd2c, var_2d938fe3, var_e4bb21a8) {
    level flag::wait_till(var_a3958f28);
    if (!level flag::get(var_f8f2bd2c)) {
        level endon(var_f8f2bd2c);
        level flag::wait_till_all(array(var_2d938fe3, var_e4bb21a8));
    }
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_6e1af22d
// Checksum 0x386e8375, Offset: 0x7190
// Size: 0x24
function include_weapons() {
    zm_utility::include_weapon("idgun", 1);
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_c2eb9077
// Checksum 0x99ec1590, Offset: 0x71c0
// Size: 0x4
function precachecustomcharacters() {
    
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_64b491e4
// Checksum 0x4b519e27, Offset: 0x71d0
// Size: 0x24
function initcharacterstartindex() {
    level.characterstartindex = randomint(4);
}

// Namespace zm_zod
// Params 0, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_31420e52
// Checksum 0xac9a360b, Offset: 0x7200
// Size: 0x3e
function selectcharacterindextouse() {
    if (level.characterstartindex >= 4) {
        level.characterstartindex = 0;
    }
    self.characterindex = level.characterstartindex;
    level.characterstartindex++;
    return self.characterindex;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_2b7aef11
// Checksum 0x52a7de97, Offset: 0x7248
// Size: 0x17c
function assign_lowest_unused_character_index() {
    charindexarray = [];
    charindexarray[0] = 0;
    charindexarray[1] = 1;
    charindexarray[2] = 2;
    charindexarray[3] = 3;
    players = getplayers();
    if (players.size == 1) {
        charindexarray = array::randomize(charindexarray);
        return charindexarray[0];
    } else {
        foreach (player in players) {
            if (isdefined(player.characterindex)) {
                arrayremovevalue(charindexarray, player.characterindex, 0);
            }
        }
        if (charindexarray.size > 0) {
            charindexarray = array::randomize(charindexarray);
            return charindexarray[0];
        }
    }
    return 0;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_a0c0aeb
// Checksum 0xd5d2c329, Offset: 0x73d0
// Size: 0x2e4
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
        if (getdvarstring("idgun_up_for_grabs") != "idgun_up_for_grabs") {
            self.characterindex = getdvarint("idgun_up_for_grabs");
        }
    #/
    self setcharacterbodytype(self.characterindex + 5);
    self setcharacterbodystyle(0);
    self setcharacterhelmetstyle(0);
    switch (self.characterindex) {
    case 0:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("frag_grenade");
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("bouncingbetty");
        break;
    case 1:
        self.talks_in_danger = 1;
        level.rich_sq_player = self;
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("pistol_standard");
        break;
    case 2:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("870mcs");
        break;
    case 3:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("hk416");
        break;
    }
    self setmovespeedscale(1);
    self function_ba25e637(4);
    self function_e67885f8(0);
    self thread set_exert_id();
    self clientfield::set_player_uimodel("zmInventory.player_character_identity", self.characterindex);
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_f7f01a5c
// Checksum 0x4651d0a6, Offset: 0x76c0
// Size: 0x54
function set_exert_id() {
    self endon(#"disconnect");
    util::wait_network_frame();
    util::wait_network_frame();
    self zm_audio::setexertvoice(self.characterindex + 1);
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_80f102b1
// Checksum 0xc975215f, Offset: 0x7720
// Size: 0xefa
function setup_personality_character_exerts() {
    level.exert_sounds[1]["burp"][0] = "vox_plr_0_exert_bad_taste_0";
    level.exert_sounds[1]["burp"][1] = "vox_plr_0_exert_bad_taste_1";
    level.exert_sounds[1]["burp"][2] = "vox_plr_0_exert_bad_taste_2";
    level.exert_sounds[1]["burp"][3] = "vox_plr_0_exert_drinking_0";
    level.exert_sounds[1]["burp"][4] = "vox_plr_0_exert_drinking_1";
    level.exert_sounds[1]["burp"][5] = "vox_plr_0_exert_drinking_2";
    level.exert_sounds[2]["burp"][0] = "vox_plr_1_exert_bad_taste_0";
    level.exert_sounds[2]["burp"][1] = "vox_plr_1_exert_bad_taste_1";
    level.exert_sounds[2]["burp"][2] = "vox_plr_1_exert_bad_taste_2";
    level.exert_sounds[2]["burp"][3] = "vox_plr_1_exert_drinking_3";
    level.exert_sounds[3]["burp"][0] = "vox_plr_2_exert_bad_taste_0";
    level.exert_sounds[3]["burp"][1] = "vox_plr_2_exert_bad_taste_1";
    level.exert_sounds[3]["burp"][2] = "vox_plr_2_exert_bad_taste_2";
    level.exert_sounds[3]["burp"][3] = "vox_plr_2_exert_drinking_1";
    level.exert_sounds[3]["burp"][4] = "vox_plr_2_exert_drinking_3";
    level.exert_sounds[4]["burp"][0] = "vox_plr_3_exert_bad_taste_0";
    level.exert_sounds[4]["burp"][1] = "vox_plr_3_exert_bad_taste_1";
    level.exert_sounds[4]["burp"][2] = "vox_plr_3_exert_bad_taste_2";
    level.exert_sounds[4]["burp"][3] = "vox_plr_3_exert_bad_taste_3";
    level.exert_sounds[4]["burp"][4] = "vox_plr_3_exert_bad_taste_4";
    level.exert_sounds[4]["burp"][5] = "vox_plr_3_exert_bad_taste_5";
    level.exert_sounds[4]["burp"][6] = "vox_plr_3_exert_bad_taste_6";
    level.exert_sounds[4]["burp"][7] = "vox_plr_3_exert_bad_taste_7";
    level.exert_sounds[4]["burp"][8] = "vox_plr_3_exert_drinking_0";
    level.exert_sounds[4]["burp"][9] = "vox_plr_3_exert_drinking_1";
    level.exert_sounds[4]["burp"][10] = "vox_plr_3_exert_drinking_2";
    level.exert_sounds[4]["burp"][11] = "vox_plr_3_exert_drinking_3";
    level.exert_sounds[4]["burp"][12] = "vox_plr_3_exert_drinking_4";
    level.exert_sounds[4]["burp"][13] = "vox_plr_3_exert_drinking_5";
    level.exert_sounds[1]["hitmed"][0] = "vox_plr_0_exert_bit_0";
    level.exert_sounds[1]["hitmed"][1] = "vox_plr_0_exert_bit_1";
    level.exert_sounds[1]["hitmed"][2] = "vox_plr_0_exert_bit_2";
    level.exert_sounds[1]["hitmed"][3] = "vox_plr_0_exert_bit_3";
    level.exert_sounds[1]["hitmed"][4] = "vox_plr_0_exert_pain_0";
    level.exert_sounds[1]["hitmed"][5] = "vox_plr_0_exert_pain_1";
    level.exert_sounds[1]["hitmed"][6] = "vox_plr_0_exert_pain_2";
    level.exert_sounds[1]["hitmed"][7] = "vox_plr_0_exert_pain_3";
    level.exert_sounds[1]["hitmed"][8] = "vox_plr_0_exert_pain_4";
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
    level.exert_sounds[4]["hitmed"][5] = "vox_plr_3_exert_bit_0";
    level.exert_sounds[4]["hitmed"][6] = "vox_plr_3_exert_bit_1";
    level.exert_sounds[4]["hitmed"][7] = "vox_plr_3_exert_bit_2";
    level.exert_sounds[4]["hitmed"][8] = "vox_plr_3_exert_bit_3";
    level.exert_sounds[4]["hitmed"][9] = "vox_plr_3_exert_bit_4";
    level.exert_sounds[4]["hitmed"][10] = "vox_plr_3_exert_bit_6";
    level.exert_sounds[4]["hitmed"][11] = "vox_plr_3_exert_bit_7";
    level.exert_sounds[4]["hitmed"][12] = "vox_plr_3_exert_bit_8";
    level.exert_sounds[4]["hitmed"][13] = "vox_plr_3_exert_bit_9";
    level.exert_sounds[4]["hitmed"][14] = "vox_plr_3_exert_bit_10";
    level.exert_sounds[1]["hitlrg"][0] = "vox_plr_0_exert_bit_0";
    level.exert_sounds[1]["hitlrg"][1] = "vox_plr_0_exert_bit_1";
    level.exert_sounds[1]["hitlrg"][2] = "vox_plr_0_exert_bit_2";
    level.exert_sounds[1]["hitlrg"][3] = "vox_plr_0_exert_bit_3";
    level.exert_sounds[1]["hitlrg"][4] = "vox_plr_0_exert_pain_0";
    level.exert_sounds[1]["hitlrg"][5] = "vox_plr_0_exert_pain_1";
    level.exert_sounds[1]["hitlrg"][6] = "vox_plr_0_exert_pain_2";
    level.exert_sounds[1]["hitlrg"][7] = "vox_plr_0_exert_pain_3";
    level.exert_sounds[1]["hitlrg"][8] = "vox_plr_0_exert_pain_4";
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
    level.exert_sounds[4]["hitlrg"][5] = "vox_plr_3_exert_bit_0";
    level.exert_sounds[4]["hitlrg"][6] = "vox_plr_3_exert_bit_1";
    level.exert_sounds[4]["hitlrg"][7] = "vox_plr_3_exert_bit_2";
    level.exert_sounds[4]["hitlrg"][8] = "vox_plr_3_exert_bit_3";
    level.exert_sounds[4]["hitlrg"][9] = "vox_plr_3_exert_bit_4";
    level.exert_sounds[4]["hitlrg"][10] = "vox_plr_3_exert_bit_6";
    level.exert_sounds[4]["hitlrg"][11] = "vox_plr_3_exert_bit_7";
    level.exert_sounds[4]["hitlrg"][12] = "vox_plr_3_exert_bit_8";
    level.exert_sounds[4]["hitlrg"][13] = "vox_plr_3_exert_bit_9";
    level.exert_sounds[4]["hitlrg"][14] = "vox_plr_3_exert_bit_10";
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_7837e42a
// Checksum 0xd7d36589, Offset: 0x8628
// Size: 0x34
function function_7837e42a() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_zod_weapons.csv", 1);
    zm_weapons::function_9e8dccbe();
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_af7b8b82
// Checksum 0x11917e53, Offset: 0x8668
// Size: 0x1c
function custom_add_vox() {
    zm_audio::loadplayervoicecategories("gamedata/audio/zm/zm_zod_vox.csv");
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_c257bc23
// Checksum 0x450ed9f4, Offset: 0x8690
// Size: 0x46
function function_c257bc23() {
    for (i = 1; i <= 4; i++) {
        namespace_ba13c715::function_93ea4183(i, 0);
    }
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_f480dd11
// Checksum 0x2f53db39, Offset: 0x86e0
// Size: 0x2bc
function function_f480dd11() {
    var_bd7c800e = getent("mdl_god_near", "targetname");
    var_e0e332eb = getent("mdl_god_far", "targetname");
    var_e0e332eb clientfield::set("far_apothigod_active", 1);
    var_bd7c800e clientfield::set("near_apothigod_active", 1);
    var_e0e332eb clientfield::set("far_apothigod_active", 0);
    var_bd7c800e clientfield::set("near_apothigod_active", 0);
    var_bd7c800e hide();
    var_e0e332eb hide();
    level flag::wait_till("ritual_pap_complete");
    players = getplayers();
    foreach (player in players) {
        scoreevents::processscoreevent("main_quest", player);
    }
    function_3d302906(1);
    level flag::wait_till("ee_complete");
    players = getplayers();
    foreach (player in players) {
        scoreevents::processscoreevent("main_EE_quest", player);
    }
    function_3d302906(0);
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_3d302906
// Checksum 0x88571eb0, Offset: 0x89a8
// Size: 0x14c
function function_3d302906(var_9392be35) {
    var_e0e332eb = getent("mdl_god_far", "targetname");
    var_bd7c800e = getent("mdl_god_near", "targetname");
    if (var_9392be35) {
        level thread lui::screen_flash(0.2, 0.5, 1, 1, "white");
        level thread util::set_lighting_state(3);
        var_e0e332eb show();
        var_e0e332eb clientfield::set("far_apothigod_active", 1);
        return;
    }
    level thread util::set_lighting_state(0);
    var_bd7c800e hide();
    var_bd7c800e clientfield::set("near_apothigod_active", 0);
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_15f74249
// Checksum 0x3d93d441, Offset: 0x8b00
// Size: 0x2e4
function setupmusic() {
    zm_audio::musicstate_create("round_start", 3, "zod_roundstart_1", "zod_roundstart_2", "zod_roundstart_3", "zod_roundstart_4", "zod_roundstart_5");
    zm_audio::musicstate_create("round_start_short", 3, "zod_roundstart_short_1", "zod_roundstart_short_2", "zod_roundstart_short_3");
    zm_audio::musicstate_create("round_start_first", 3, "zod_roundstart_1", "zod_roundstart_2", "zod_roundstart_3", "zod_roundstart_4", "zod_roundstart_5");
    zm_audio::musicstate_create("round_end", 3, "zod_roundend_1", "zod_roundend_2", "zod_roundend_3");
    zm_audio::musicstate_create("game_over", 5, "zod_gameover");
    zm_audio::musicstate_create("parasite_start", 3, "zod_parasite_start");
    zm_audio::musicstate_create("parasite_over", 3, "zod_parasite_end");
    zm_audio::musicstate_create("meatball_start", 3, "zod_meatball_start");
    zm_audio::musicstate_create("meatball_over", 3, "zod_meatball_end");
    zm_audio::musicstate_create("coldhardcash", 4, "zod_egg_coldhardcash");
    zm_audio::musicstate_create("snakeskinboots", 4, "zod_egg_snakeskin");
    zm_audio::musicstate_create("snakeskinboots_instr", 4, "zod_egg_snakeskin_instr");
    zm_audio::musicstate_create("zod_endigc_lullaby", 4, "zod_endigc_lullaby");
    zm_audio::musicstate_create("shadfight", 4, "zod_ee_shadfight");
    zm_audio::musicstate_create("apothifight", 4, "zod_ee_apothifight");
    zm_audio::musicstate_create("none", 4, "none");
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_e4795b73
// Checksum 0xf691ab4c, Offset: 0x8df0
// Size: 0x10
function function_e4795b73(keys) {
    return keys;
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_69030873
// Checksum 0x90a63b0d, Offset: 0x8e08
// Size: 0x10
function function_69030873(weapon) {
    return true;
}

// Namespace zm_zod
// Params 2, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_ec0a572
// Checksum 0x80c047c6, Offset: 0x8e20
// Size: 0x1d6
function function_ec0a572(zombie, enemy) {
    aiprofile_beginentry("zod-enemy_location_override");
    if (isdefined(enemy.var_65f06b5) && enemy.var_65f06b5) {
        var_d3443466 = 0;
        if (isdefined(level.var_292a0ac9)) {
            var_d3443466 = [[ level.var_292a0ac9 ]]->function_3e62f527();
        }
        if (!(isdefined(self.var_e0d198e4) && self.var_e0d198e4) && !(isdefined(var_d3443466) && var_d3443466)) {
            touching = 0;
            if (isdefined(level.var_292a0ac9)) {
                touching = [[ level.var_292a0ac9 ]]->function_406e4ba9(zombie);
            }
            if (!touching) {
                var_49d79cb6 = zombie namespace_2e83114d::get_escape_position_in_current_zone();
                if (isdefined(var_49d79cb6)) {
                    aiprofile_endentry();
                    return var_49d79cb6.origin;
                }
                aiprofile_endentry();
                return zombie getorigin();
            }
        }
    }
    /#
        if (isdefined(level.zombie_pathing_validation)) {
            var_9667df3a = (1536, -9296, 544);
            var_9667df3a = getclosestpointonnavmesh(var_9667df3a, 100, 30);
            return var_9667df3a;
        }
    #/
    aiprofile_endentry();
    return undefined;
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_97d7cae0
// Checksum 0xd5b36409, Offset: 0x9000
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

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_27553de3
// Checksum 0xfd5e9971, Offset: 0x9088
// Size: 0x33c
function no_target_override(zombie) {
    if (isdefined(zombie.has_exit_point)) {
        return;
    }
    players = level.players;
    dist_zombie = 0;
    dist_player = 0;
    dest = 0;
    if (isdefined(level.zm_loc_types["wait_location"])) {
        locs = array::randomize(level.zm_loc_types["wait_location"]);
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
    var_49d79cb6 = zombie namespace_2e83114d::get_escape_position_in_current_zone();
    if (zombie function_97d7cae0(var_49d79cb6)) {
        return;
    }
    var_49d79cb6 = zombie namespace_2e83114d::get_escape_position();
    if (zombie function_97d7cae0(var_49d79cb6)) {
        return;
    }
    zombie.has_exit_point = 1;
    zombie setgoal(zombie.origin);
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_61b96f56
// Checksum 0xa4a940c6, Offset: 0x93d0
// Size: 0x2e4
function function_61b96f56(player) {
    var_cfd1da70 = self.zone_name;
    player_zone = player.zone_name;
    if (var_cfd1da70 === player_zone) {
        return 1;
    }
    if (!isdefined(var_cfd1da70) || !isdefined(player_zone)) {
        return 0;
    }
    var_9165799c = level.zones[self.zone_name].district;
    var_e8c4df7b = level.zones[player.zone_name].district;
    var_bb534481 = level.zones[self.zone_name].area;
    var_147beb1e = level.zones[player.zone_name].area;
    if (var_bb534481 == 0 && var_147beb1e == 0) {
        return 1;
    }
    if (var_9165799c === var_e8c4df7b && var_bb534481 === var_147beb1e) {
        return 1;
    }
    if (var_9165799c === var_e8c4df7b) {
        if (var_bb534481 > var_147beb1e) {
            temp = var_bb534481;
            var_bb534481 = var_147beb1e;
            var_147beb1e = temp;
        }
        var_54f2276d = function_17c00a4f(var_9165799c, var_bb534481, var_e8c4df7b, var_147beb1e);
        return var_54f2276d;
    }
    if (var_bb534481 == 0 && var_147beb1e != 0) {
        var_54f2276d = function_17c00a4f("junction", 0, var_e8c4df7b, var_147beb1e);
        return var_54f2276d;
    }
    if (var_147beb1e == 0 && var_bb534481 != 0) {
        var_54f2276d = function_17c00a4f("junction", 0, var_9165799c, var_bb534481);
        return var_54f2276d;
    }
    var_92280803 = 1;
    var_58b7daa8 = 1;
    var_92280803 = function_17c00a4f("junction", 0, var_9165799c, var_bb534481);
    var_58b7daa8 = function_17c00a4f("junction", 0, var_e8c4df7b, var_147beb1e);
    return var_58b7daa8 && var_92280803;
}

// Namespace zm_zod
// Params 4, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_17c00a4f
// Checksum 0x36245435, Offset: 0x96c0
// Size: 0x1a6
function function_17c00a4f(var_9165799c, var_25cf04a1, var_e8c4df7b, var_202b5b6a) {
    var_15a343e3 = function_6b75e74c(var_e8c4df7b);
    var_2473d928 = var_15a343e3["01"];
    var_7fd9f894 = var_15a343e3["12"];
    var_a5dc72fd = var_15a343e3["13"];
    var_da02e380 = var_15a343e3["23"];
    if (var_2473d928 && var_7fd9f894 && var_a5dc72fd && var_da02e380) {
        return true;
    }
    if (var_25cf04a1 == 0) {
        if (!var_2473d928) {
            return false;
        }
        if (var_202b5b6a == 1) {
            return true;
        }
        var_25cf04a1++;
    }
    if (var_25cf04a1 == 1 && var_202b5b6a == 2) {
        return (var_a5dc72fd && var_da02e380 || var_7fd9f894);
    }
    if (var_25cf04a1 == 2 && var_202b5b6a == 3) {
        return (var_a5dc72fd && var_7fd9f894 || var_da02e380);
    }
    if (var_25cf04a1 == 1 && var_202b5b6a == 3) {
        return (var_7fd9f894 && var_da02e380 || var_a5dc72fd);
    }
    return false;
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_6b75e74c
// Checksum 0x16d32fb2, Offset: 0x9870
// Size: 0x24c
function function_6b75e74c(district) {
    flags = [];
    if (district === "theater") {
        flags["01"] = level flag::get("connect_theater_to_junction");
        flags["12"] = level flag::get("connect_theater_alley_to_square");
        flags["13"] = level flag::get("connect_theater_high_to_low");
        flags["23"] = level flag::get("connect_theater_high_to_square");
        return flags;
    }
    if (district === "slums") {
        flags["01"] = level flag::get("connect_slums_to_junction");
        flags["12"] = level flag::get("connect_slums_waterfront_to_alley");
        flags["13"] = level flag::get("connect_slums_high_to_low");
        flags["23"] = level flag::get("connect_slums_high_to_train");
        return flags;
    }
    if (district === "canal") {
        flags["01"] = level flag::get("connect_canal_to_junction");
        flags["12"] = level flag::get("connect_canal_to_train");
        flags["13"] = level flag::get("connect_canal_high_to_low");
        flags["23"] = level flag::get("connect_canal_high_to_train");
        return flags;
    }
    return flags;
}

// Namespace zm_zod
// Params 1, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_59b7b808
// Checksum 0xd7333cde, Offset: 0x9ac8
// Size: 0x60
function function_59b7b808(player) {
    aiprofile_beginentry("zod-zombie_is_target_reachable");
    res = function_61b96f56(player);
    aiprofile_endentry();
    return res;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_5c478789
// Checksum 0x698b4fd6, Offset: 0x9b30
// Size: 0x1f8
function player_out_of_playable_area_override() {
    if (isdefined(level.var_292a0ac9)) {
        var_4843dc70 = [[ level.var_292a0ac9 ]]->function_8cf8e3a5();
        if (isdefined(var_4843dc70)) {
            if (!isdefined(level.var_72c68d94)) {
                level.var_72c68d94 = [];
                trigger = spawn("trigger_box", (5764, -3400, 560), 45, 186.5, 693, -96);
                trigger.angles = (0, 45, 0);
                if (!isdefined(level.var_72c68d94)) {
                    level.var_72c68d94 = [];
                } else if (!isarray(level.var_72c68d94)) {
                    level.var_72c68d94 = array(level.var_72c68d94);
                }
                level.var_72c68d94[level.var_72c68d94.size] = trigger;
            }
            foreach (trigger in level.var_72c68d94) {
                var_b28a4a84 = self istouching(trigger);
                var_d2b747d1 = var_4843dc70 istouching(trigger);
                if (var_b28a4a84 && !var_d2b747d1) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_8535c602
// Checksum 0x29ae35ba, Offset: 0x9d30
// Size: 0x1c
function function_8535c602() {
    self thread function_e33614b9();
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_e33614b9
// Checksum 0xf46bf3a8, Offset: 0x9d58
// Size: 0x86
function function_e33614b9() {
    self endon(#"disconnect");
    util::wait_network_frame();
    while (true) {
        if (isdefined(self) && isplayer(self)) {
            self notify(#"lightning_strike");
            self clientfield::increment_to_player("devgui_lightning_test", 1);
        }
        wait(12);
    }
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_c9e2531c
// Checksum 0xf60247a6, Offset: 0x9de8
// Size: 0x3c
function function_c9e2531c() {
    level thread namespace_8e578893::function_72260d3a("ZM/Zod/Lighting/Slums Lightning Test", "zod_lightning_test", 1, &function_5abd3b41);
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_5abd3b41
// Checksum 0x31dbc1d7, Offset: 0x9e30
// Size: 0x7e
function function_5abd3b41(n_index) {
    level notify(#"hash_2cf3dd37");
    level endon(#"hash_2cf3dd37");
    player = getplayers()[0];
    while (true) {
        player clientfield::increment_to_player("devgui_lightning_test", n_index);
        wait(12);
    }
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_c876231d
// Checksum 0x1a799ba1, Offset: 0x9eb8
// Size: 0x3c
function function_c876231d() {
    level thread namespace_8e578893::function_72260d3a("ZM/Zod/Ghost test", "zod_ghost_test", 1, &function_10de758b);
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_10de758b
// Checksum 0xa7dc0f7c, Offset: 0x9f00
// Size: 0x11c
function function_10de758b(n_index) {
    level notify(#"hash_10de758b");
    level endon(#"hash_10de758b");
    player = getplayers()[0];
    var_8cfd368 = 1;
    while (true) {
        foreach (zombie in getaiteamarray(level.zombie_team)) {
            zombie clientfield::set("ghost_actor", var_8cfd368);
        }
        var_8cfd368 = 1 - var_8cfd368;
        wait(12);
    }
}

/#

    // Namespace zm_zod
    // Params 0, eflags: 0x1 linked
    // namespace_bcfa45b0<file_0>::function_9b36a3d5
    // Checksum 0x6f14b81, Offset: 0xa028
    // Size: 0xac
    function setup_devgui() {
        setdvar("idgun_up_for_grabs", "idgun_up_for_grabs");
        setdvar("idgun_up_for_grabs", "idgun_up_for_grabs");
        setdvar("idgun_up_for_grabs", 0);
        setdvar("idgun_up_for_grabs", 0);
        execdevgui("idgun_up_for_grabs");
        level.custom_devgui = &function_4173fe95;
    }

    // Namespace zm_zod
    // Params 1, eflags: 0x1 linked
    // namespace_bcfa45b0<file_0>::function_4173fe95
    // Checksum 0x1701b168, Offset: 0xa0e0
    // Size: 0x15a
    function function_4173fe95(cmd) {
        var_98be8724 = strtok(cmd, "idgun_up_for_grabs");
        switch (var_98be8724[0]) {
        case 8:
            function_e2f669ab(getdvarint("idgun_up_for_grabs"));
            break;
        case 8:
            function_50d75aeb(getdvarint("idgun_up_for_grabs"));
            break;
        case 8:
            function_3bb3e47a(getdvarint("idgun_up_for_grabs"));
            break;
        case 8:
            function_408ad958(getdvarint("idgun_up_for_grabs"));
            break;
        case 8:
            function_30018788();
            break;
        default:
            break;
        }
    }

    // Namespace zm_zod
    // Params 1, eflags: 0x1 linked
    // namespace_bcfa45b0<file_0>::function_e2f669ab
    // Checksum 0xa8c97c85, Offset: 0xa248
    // Size: 0xa0
    function function_e2f669ab(var_8a4e41c7) {
        if (!isdefined(level.var_3ea86e6a) || !level.var_3ea86e6a) {
            return;
        }
        if (!isdefined(level.var_c5e6b80a) || !level.var_c5e6b80a) {
            return;
        }
        if (!isdefined(level.var_c03323ec) || level.var_c03323ec.size < 1) {
            return;
        }
        function_4d732a77(var_8a4e41c7);
        level.var_ef0c0bfd = level.round_number + 1;
    }

    // Namespace zm_zod
    // Params 1, eflags: 0x1 linked
    // namespace_bcfa45b0<file_0>::function_3bb3e47a
    // Checksum 0xb4d2451c, Offset: 0xa2f0
    // Size: 0xa0
    function function_3bb3e47a(var_46c3c206) {
        if (!isdefined(level.var_a6025843) || !level.var_a6025843) {
            return;
        }
        if (!isdefined(level.var_e55eed95) || !level.var_e55eed95) {
            return;
        }
        if (!isdefined(level.var_b15f9e1f) || level.var_b15f9e1f.size < 1) {
            return;
        }
        function_205a2511(var_46c3c206);
        level.var_fe8c915f = level.round_number + 1;
    }

    // Namespace zm_zod
    // Params 1, eflags: 0x1 linked
    // namespace_bcfa45b0<file_0>::function_50d75aeb
    // Checksum 0xad831954, Offset: 0xa398
    // Size: 0x4c
    function function_50d75aeb(var_8a4e41c7) {
        if (isdefined(level.var_ef0c0bfd)) {
            function_4d732a77(var_8a4e41c7);
            zm_devgui::zombie_devgui_goto_round(level.var_ef0c0bfd);
        }
    }

    // Namespace zm_zod
    // Params 1, eflags: 0x1 linked
    // namespace_bcfa45b0<file_0>::function_408ad958
    // Checksum 0x6bf6130d, Offset: 0xa3f0
    // Size: 0x4c
    function function_408ad958(var_46c3c206) {
        if (isdefined(level.var_fe8c915f)) {
            function_205a2511(var_46c3c206);
            zm_devgui::zombie_devgui_goto_round(level.var_fe8c915f);
        }
    }

    // Namespace zm_zod
    // Params 1, eflags: 0x1 linked
    // namespace_bcfa45b0<file_0>::function_4d732a77
    // Checksum 0x11c1b123, Offset: 0xa448
    // Size: 0x6c
    function function_4d732a77(var_8a4e41c7) {
        if (isdefined(var_8a4e41c7) && var_8a4e41c7 > 0) {
            setdvar("idgun_up_for_grabs", var_8a4e41c7);
            return;
        }
        setdvar("idgun_up_for_grabs", "idgun_up_for_grabs");
    }

    // Namespace zm_zod
    // Params 1, eflags: 0x1 linked
    // namespace_bcfa45b0<file_0>::function_205a2511
    // Checksum 0xdbe19114, Offset: 0xa4c0
    // Size: 0x6c
    function function_205a2511(var_46c3c206) {
        if (isdefined(var_46c3c206) && var_46c3c206 > 0) {
            setdvar("idgun_up_for_grabs", var_46c3c206);
            return;
        }
        setdvar("idgun_up_for_grabs", "idgun_up_for_grabs");
    }

    // Namespace zm_zod
    // Params 0, eflags: 0x1 linked
    // namespace_bcfa45b0<file_0>::function_30018788
    // Checksum 0xdf1f09d5, Offset: 0xa538
    // Size: 0x54
    function function_30018788() {
        if (isdefined(level.var_fe8c915f)) {
            if (level.var_fe8c915f <= 15) {
                level.var_fe8c915f = 15;
            }
            level notify(#"hash_4e5d77b2");
            zm_devgui::zombie_devgui_goto_round(level.var_fe8c915f);
        }
    }

#/

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_33aa4940
// Checksum 0xf6f417ee, Offset: 0xa598
// Size: 0x240
function function_33aa4940() {
    if (level.round_number <= 11) {
        return 0;
    }
    if (isdefined(level.var_5a487977["parasite"]) && level.var_5a487977["parasite"].size > 0) {
        namespace_b1ca30af::function_8aeb3564(1);
        level.zombie_total--;
        return 1;
    } else if (isdefined(level.var_5a487977["raps"]) && level.var_5a487977["raps"].size > 0) {
        namespace_5ace0f0e::function_ad853d21(1);
        level.zombie_total--;
        return 1;
    }
    var_c0692329 = 0;
    n_random = randomfloat(100);
    if (level.round_number > 30) {
        if (n_random < 5) {
            var_c0692329 = 1;
        }
    } else if (level.round_number > 25) {
        if (n_random < 4) {
            var_c0692329 = 1;
        }
    } else if (level.round_number > 15) {
        if (n_random < 3) {
            var_c0692329 = 1;
        }
    } else if (n_random < 2) {
        var_c0692329 = 1;
    }
    if (var_c0692329) {
        if (!flag::get("ritual_pap_complete")) {
            namespace_b1ca30af::function_8aeb3564(1);
        } else if (math::cointoss()) {
            namespace_5ace0f0e::function_ad853d21(1);
        } else {
            namespace_b1ca30af::function_8aeb3564(1);
        }
        level.zombie_total--;
    }
    return var_c0692329;
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_80ba9218
// Checksum 0x1b75da8, Offset: 0xa7e0
// Size: 0x40
function function_80ba9218(revivee) {
    if (isdefined(revivee.being_revived_by_robot) && revivee.being_revived_by_robot == 1) {
        return false;
    }
    return true;
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_59804866
// Checksum 0xab03cd2b, Offset: 0xa828
// Size: 0x146
function function_59804866(n_round) {
    if (n_round < 2) {
        return 3;
    }
    if (n_round < 5) {
        return 2;
    }
    if (n_round > 60) {
        n_round = 60;
    }
    n_multiplier = 0.95;
    switch (level.players.size) {
    case 1:
        n_delay = 2;
        break;
    case 2:
        n_delay = 1.5;
        break;
    case 3:
        n_delay = 0.89;
        break;
    case 4:
        n_delay = 0.67;
        break;
    }
    for (i = 1; i < n_round; i++) {
        n_delay *= n_multiplier;
        if (n_delay <= 0.1) {
            n_delay = 0.1;
            break;
        }
    }
    return n_delay;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_5ee4c46c
// Checksum 0x474aaabf, Offset: 0xa978
// Size: 0x30
function function_5ee4c46c() {
    if (level.round_number < 4) {
        level.zombie_move_speed = 1;
    }
    return level.zombie_vars["zombie_between_round_time"];
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_b05d27ad
// Checksum 0xff54f15a, Offset: 0xa9b0
// Size: 0x304
function function_b05d27ad() {
    if (!isdefined(level.var_5b9dbdff)) {
        level.var_5b9dbdff = [];
        level.var_a7c80058 = [];
        foreach (e_spawner in level.zombie_spawners) {
            if (isdefined(e_spawner.script_string) && e_spawner.script_string == "male") {
                if (!isdefined(level.var_5b9dbdff)) {
                    level.var_5b9dbdff = [];
                } else if (!isarray(level.var_5b9dbdff)) {
                    level.var_5b9dbdff = array(level.var_5b9dbdff);
                }
                level.var_5b9dbdff[level.var_5b9dbdff.size] = e_spawner;
                continue;
            }
            if (isdefined(e_spawner.script_string) && e_spawner.script_string == "female") {
                if (!isdefined(level.var_a7c80058)) {
                    level.var_a7c80058 = [];
                } else if (!isarray(level.var_a7c80058)) {
                    level.var_a7c80058 = array(level.var_a7c80058);
                }
                level.var_a7c80058[level.var_a7c80058.size] = e_spawner;
            }
        }
        level.var_6b31b4b8 = 0;
        level.var_831a7edf = 0;
    }
    if (level.var_6b31b4b8 >= 1) {
        sp_zombie = array::random(level.var_a7c80058);
        level.var_6b31b4b8 = 0;
        level.var_831a7edf = 1;
    } else if (level.var_831a7edf >= 1) {
        sp_zombie = array::random(level.var_5b9dbdff);
        level.var_6b31b4b8 = 1;
        level.var_831a7edf = 0;
    } else {
        var_7970b66c = randomint(1000);
        if (var_7970b66c <= 600) {
            sp_zombie = array::random(level.var_5b9dbdff);
            level.var_6b31b4b8++;
        } else {
            sp_zombie = array::random(level.var_a7c80058);
            level.var_831a7edf++;
        }
    }
    return sp_zombie;
}

// Namespace zm_zod
// Params 0, eflags: 0x0
// namespace_bcfa45b0<file_0>::function_eda7de97
// Checksum 0xde4b8816, Offset: 0xacc0
// Size: 0x7c
function function_eda7de97() {
    a_players = getplayers();
    if (!isdefined(level.var_c4acfdc0)) {
        level.var_c4acfdc0 = randomint(a_players.size);
    }
    level.var_c4acfdc0++;
    if (level.var_c4acfdc0 >= a_players.size) {
        level.var_c4acfdc0 = 0;
    }
    return a_players[level.var_c4acfdc0];
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_631e737d
// Checksum 0x909b0a0, Offset: 0xad48
// Size: 0x3c
function function_631e737d() {
    level waittill(#"hash_4e5d77b2");
    level.var_535a2969 = &function_243d0df6;
    level.var_30b36b7b = &function_68990a1c;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_243d0df6
// Checksum 0xa4d0de39, Offset: 0xad90
// Size: 0xa4
function function_243d0df6() {
    namespace_b1ca30af::function_b820d8();
    util::wait_network_frame();
    wait(2);
    if (level.zombie_total > 0) {
        namespace_5ace0f0e::function_cce2311d();
        util::wait_network_frame();
        wait(2);
    }
    if (level.zombie_total > 0) {
        if (randomint(100) >= 50) {
            namespace_b1ca30af::function_b820d8();
        }
    }
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_68990a1c
// Checksum 0x8e97107a, Offset: 0xae40
// Size: 0x46
function function_68990a1c() {
    if (level.zombie_total) {
        return false;
    }
    if (namespace_5ace0f0e::function_30f083dc()) {
        return false;
    }
    if (namespace_b1ca30af::function_acc1c531()) {
        return false;
    }
    return true;
}

// Namespace zm_zod
// Params 2, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_716fc13e
// Checksum 0x70423997, Offset: 0xae90
// Size: 0x144
function function_716fc13e(e_enemy, v_pos) {
    if (isdefined(e_enemy) && isdefined(e_enemy.archetype) && e_enemy.archetype == "parasite") {
        e_ent = e_enemy.favoriteenemy;
        if (!isdefined(e_ent)) {
            e_ent = array::random(level.players);
        }
        e_ent namespace_b1ca30af::function_7297d7dc(v_pos);
        return;
    }
    var_f1aa36cd = v_pos;
    trace = groundtrace(var_f1aa36cd + (0, 0, 100), var_f1aa36cd + (0, 0, -1000), 0, undefined);
    var_f1aa36cd = trace["position"];
    if (isdefined(var_f1aa36cd)) {
        level thread zm_powerups::specific_powerup_drop("full_ammo", var_f1aa36cd);
    }
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_afdf4111
// Checksum 0x9898cf6, Offset: 0xafe0
// Size: 0x5c
function function_afdf4111() {
    if (isdefined(self.var_abe77dc0) && self.var_abe77dc0) {
        self clientfield::set_to_player("pod_sprayer_held", 1);
        return;
    }
    self clientfield::set_to_player("pod_sprayer_held", 0);
}

// Namespace zm_zod
// Params 1, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_2c092767
// Checksum 0xfc566c3a, Offset: 0xb048
// Size: 0x21c
function function_2c092767(a_spots) {
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

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_612012aa
// Checksum 0x575f5f00, Offset: 0xb270
// Size: 0x8a
function function_612012aa() {
    if (!isdefined(level.var_1300aaeb)) {
        level.var_1300aaeb = level.var_ef0c0bfd;
        if (level.var_fe8c915f > level.var_1300aaeb) {
            level.var_1300aaeb = level.var_fe8c915f;
        }
        level.var_1300aaeb += 5;
    } else {
        level.var_1300aaeb += randomintrange(5, 10);
    }
    return level.var_1300aaeb;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_48fda59a
// Checksum 0x694b7be2, Offset: 0xb308
// Size: 0x158
function function_48fda59a() {
    var_6a6d5f3e = 0;
    n_start_time = undefined;
    while (true) {
        if (!var_6a6d5f3e && level.zombie_total <= 0) {
            var_565450eb = zombie_utility::get_current_zombie_count();
            if (var_565450eb == 1) {
                if (!isdefined(n_start_time)) {
                    n_start_time = gettime();
                }
                n_time = gettime();
                var_be13851f = (n_time - n_start_time) / 1000;
                if (var_be13851f >= 80) {
                    a_zombies = getaiteamarray(level.zombie_team);
                    if (a_zombies.size == 1) {
                        a_zombies[0] zombie_utility::set_zombie_run_cycle("sprint");
                        level waittill(#"between_round_over");
                        level waittill(#"start_of_round");
                        wait(10);
                    }
                }
            } else {
                var_6a6d5f3e = 0;
                n_start_time = undefined;
            }
        }
        wait(1);
    }
}

/#

    // Namespace zm_zod
    // Params 0, eflags: 0x1 linked
    // namespace_bcfa45b0<file_0>::function_af2b349c
    // Checksum 0xc1548961, Offset: 0xb468
    // Size: 0x52
    function function_af2b349c() {
        var_1b913866 = self allowstand(1);
        self allowstand(var_1b913866);
        return var_1b913866;
    }

#/

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_f7d81bd5
// Checksum 0xbaa4a533, Offset: 0xb4c8
// Size: 0x1a4
function function_f7d81bd5() {
    self notify(#"hash_f7d81bd5");
    self endon(#"hash_f7d81bd5");
    self endon(#"disconnect");
    level endon(#"stop_suicide_trigger");
    e_volume = getent("into_disable_prone", "targetname");
    var_d8d76cd3 = 0;
    while (!(isdefined(level.intermission) && level.intermission)) {
        if (self laststand::player_is_in_laststand()) {
            self allowprone(1);
            var_d8d76cd3 = 0;
        } else if (!(isdefined(self.beastmode) && self.beastmode)) {
            if (self istouching(e_volume)) {
                if (!var_d8d76cd3) {
                    /#
                        if (!self function_af2b349c()) {
                            assertmsg("idgun_up_for_grabs");
                        }
                    #/
                    self allowprone(0);
                    var_d8d76cd3 = 1;
                }
            } else if (var_d8d76cd3) {
                self allowprone(1);
                var_d8d76cd3 = 0;
            }
        }
        wait(0.25);
    }
    self allowprone(1);
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_22eef972
// Checksum 0x902adc29, Offset: 0xb678
// Size: 0x44
function function_22eef972() {
    level flag::wait_till("all_players_connected");
    clientfield::set("hide_perf_static_models", 1);
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_aab1d0bd
// Checksum 0xbb921a3a, Offset: 0xb6c8
// Size: 0x78
function function_aab1d0bd() {
    while (true) {
        level waittill(#"start_of_round");
        if (level.round_number < 12) {
            setdvar("r_maxSpotShadowUpdates", "12");
            continue;
        }
        setdvar("r_maxSpotShadowUpdates", "8");
    }
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_a988e9bb
// Checksum 0x39f06226, Offset: 0xb748
// Size: 0x54
function function_a988e9bb() {
    level flag::wait_till("all_players_connected");
    array::thread_all(getplayers(), &function_aeb6b3db);
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_aeb6b3db
// Checksum 0x3c930b2, Offset: 0xb7a8
// Size: 0x1d4
function function_aeb6b3db() {
    self endon(#"disconnect");
    self endon(#"death");
    s_start = struct::get("s_noire_ee_start", "targetname");
    s_end = struct::get("s_noire_ee_end", "targetname");
    var_3acf33ec = 0;
    while (!var_3acf33ec) {
        if (self getstance() == "crouch") {
            if (self reloadbuttonpressed()) {
                n_dist = distance(self.origin, s_start.origin);
                if (n_dist < 85) {
                    v_forward = self getweaponforwarddir();
                    v_dir = vectornormalize(s_end.origin - self.origin);
                    dp = vectordot(v_forward, v_dir);
                    if (dp > 0.975) {
                        visionset_mgr::activate("visionset", "zombie_noire", self);
                        var_3acf33ec = 1;
                    }
                }
            }
        }
        wait(0.05);
    }
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_89b7689f
// Checksum 0x7bcef856, Offset: 0xb988
// Size: 0x22
function function_89b7689f() {
    if (isdefined(self.altbody) && self.altbody) {
        return false;
    }
    return true;
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_42cc727b
// Checksum 0xc8d425e8, Offset: 0xb9b8
// Size: 0x8c
function function_42cc727b() {
    if (isdefined(self.var_e51032ec)) {
        self.var_e51032ec = undefined;
    }
    var_4126c532 = self namespace_1f61c67f::function_b62ad2c();
    if (isdefined(var_4126c532)) {
        array::add(var_4126c532.var_9e054a5d, self, 0);
        self.var_84f1bc44 = 1;
        return;
    }
    self namespace_1f61c67f::function_15f1b929();
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_bef9943a
// Checksum 0x8560e37f, Offset: 0xba50
// Size: 0x164
function function_bef9943a() {
    level flag::wait_till("all_players_connected");
    exploder::exploder("fx_exploder_lightning_junction");
    wait(20);
    exploder::stop_exploder("fx_exploder_lightning_junction");
    while (level.round_number < 5) {
        n_round_number = level.round_number;
        while (zombie_utility::get_current_zombie_count() == 0) {
            wait(0.1);
        }
        while (true) {
            if (level.zombie_total == 0 && zombie_utility::get_current_zombie_count() <= 2) {
                break;
            }
            wait(0.1);
        }
        exploder::exploder("fx_exploder_lightning_junction");
        while (zombie_utility::get_current_zombie_count() > 0) {
            wait(0.1);
        }
        exploder::stop_exploder("fx_exploder_lightning_junction");
        while (level.round_number == n_round_number) {
            wait(0.1);
        }
    }
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_f88e4c70
// Checksum 0xc31b106a, Offset: 0xbbc0
// Size: 0x1c
function function_f88e4c70() {
    self thread function_35c958af();
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_35c958af
// Checksum 0xe0b4306b, Offset: 0xbbe8
// Size: 0x19a
function function_35c958af() {
    self endon(#"death");
    var_f1af2991 = 0;
    while (true) {
        n_delay = randomfloatrange(0.9, 1.4);
        wait(n_delay);
        if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
            continue;
        }
        v_trace_end = (self.origin[0], self.origin[1], self.origin[2] - 500);
        trace = groundtrace(self.origin, v_trace_end, 0, 0, 0, 0);
        var_ccacea03 = trace["position"] + (0, 0, 20);
        b_in_active_zone = zm_utility::check_point_in_enabled_zone(var_ccacea03, 1, level.active_zones);
        if (b_in_active_zone) {
            var_f1af2991 = 0;
            continue;
        }
        var_f1af2991++;
        if (var_f1af2991 >= 5) {
            namespace_b1ca30af::function_c93c5341(self.enemy);
            self kill();
            return;
        }
    }
}

// Namespace zm_zod
// Params 0, eflags: 0x1 linked
// namespace_bcfa45b0<file_0>::function_4df9f4ad
// Checksum 0x7a1a751c, Offset: 0xbd90
// Size: 0xa0
function function_4df9f4ad() {
    level endon(#"end_game");
    level notify(#"hash_a3369c1f");
    level endon(#"hash_a3369c1f");
    while (true) {
        level waittill(#"host_migration_end");
        setdvar("doublejump_enabled", 1);
        setdvar("playerEnergy_enabled", 1);
        setdvar("wallrun_enabled", 1);
    }
}

