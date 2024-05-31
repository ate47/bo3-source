#using scripts/zm/zm_stalingrad_zones;
#using scripts/zm/zm_stalingrad_zombie;
#using scripts/zm/zm_stalingrad_wearables;
#using scripts/zm/zm_stalingrad_vo;
#using scripts/zm/zm_stalingrad_util;
#using scripts/zm/zm_stalingrad_timer;
#using scripts/zm/zm_stalingrad_powered_bridge;
#using scripts/zm/zm_stalingrad_pavlov_trap;
#using scripts/zm/zm_stalingrad_pap_quest;
#using scripts/zm/zm_stalingrad_nikolai;
#using scripts/zm/zm_stalingrad_mounted_mg;
#using scripts/zm/zm_stalingrad_gauntlet;
#using scripts/zm/zm_stalingrad_fx;
#using scripts/zm/zm_stalingrad_finger_trap;
#using scripts/zm/zm_stalingrad_ffotd;
#using scripts/zm/zm_stalingrad_eye_beam_trap;
#using scripts/zm/zm_stalingrad_ee_main;
#using scripts/zm/zm_stalingrad_devgui;
#using scripts/zm/zm_stalingrad_dragon_strike;
#using scripts/zm/zm_stalingrad_dragon;
#using scripts/zm/zm_stalingrad_cleanup_mgr;
#using scripts/zm/zm_stalingrad_craftables;
#using scripts/zm/zm_stalingrad_challenges;
#using scripts/zm/zm_stalingrad_audio;
#using scripts/zm/zm_stalingrad_ambient;
#using scripts/zm/zm_stalingrad_achievements;
#using scripts/zm/zm_siegebot_nikolai;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
#using scripts/zm/_zm_ai_sentinel_drone;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_weap_raygun_mark3;
#using scripts/zm/_zm_weap_dragon_strike;
#using scripts/zm/_zm_weap_dragon_scale_shield;
#using scripts/zm/_zm_weap_dragon_gauntlet;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_bowie;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_placeable_mine;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_electric_cherry;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_trap_electric;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_ai_raz;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/vehicles/_sentinel_drone;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/raz;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_320a344e;

// Namespace namespace_320a344e
// Params 0, eflags: 0x2
// namespace_320a344e<file_0>::function_8e134dbe
// Checksum 0x84b8ccb1, Offset: 0x27e0
// Size: 0x34
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    level.pack_a_punch_camo_index = 84;
    level.pack_a_punch_camo_index_number_variants = 5;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x0
// namespace_320a344e<file_0>::function_831dc0fa
// Checksum 0x99ec1590, Offset: 0x2820
// Size: 0x4
function function_831dc0fa() {
    
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x0
// namespace_320a344e<file_0>::function_243693d4
// Checksum 0x6495ff3b, Offset: 0x2830
// Size: 0x84
function function_243693d4() {
    zm_utility::add_gametype("zclassic", &dummy, "zclassic", &dummy);
    zm_utility::add_gameloc("default", &dummy, "default", &dummy);
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_bf268fdb
// Checksum 0x99ec1590, Offset: 0x28c0
// Size: 0x4
function dummy() {
    
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_d290ebfa
// Checksum 0xc3511ada, Offset: 0x28d0
// Size: 0x1054
function main() {
    namespace_15d4d4c0::main_start();
    level._uses_sticky_grenades = 1;
    level._uses_taser_knuckles = 1;
    level.var_bd64e31e = 20;
    level.debug_keyline_zombies = 0;
    setdvar("dlc3_veh_UpdateYawEvenWhileStationary", 1);
    zm::init_fx();
    namespace_c49c3ddb::init();
    namespace_e81d2518::init_clientfields();
    namespace_23c72813::function_ad78a144();
    clientfield::register("clientuimodel", "player_lives", 12000, 2, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_shield_parts", 12000, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_dragon_strike", 12000, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.player_crafted_shield", 12000, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_cylinder", 12000, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.piece_cylinder", 12000, 2, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_egg", 12000, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.piece_egg", 12000, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.progress_egg", 12000, 4, "float");
    clientfield::register("actor", "drop_pod_score_beam_fx", 12000, 1, "counter");
    clientfield::register("scriptmover", "drop_pod_active", 12000, 1, "int");
    clientfield::register("scriptmover", "drop_pod_hp_light", 12000, 2, "int");
    clientfield::register("world", "drop_pod_streaming", 12000, 1, "int");
    clientfield::register("clientuimodel", "trialWidget.visible", 9000, 1, "int");
    clientfield::register("clientuimodel", "trialWidget.progress", 9000, 7, "float");
    clientfield::register("clientuimodel", "trialWidget.icon", 12000, 2, "int");
    clientfield::register("clientuimodel", "trialWidget.challenge1state", 12000, 2, "int");
    clientfield::register("clientuimodel", "trialWidget.challenge2state", 12000, 2, "int");
    clientfield::register("clientuimodel", "trialWidget.challenge3state", 12000, 2, "int");
    clientfield::register("toplayer", "tp_water_sheeting", 12000, 1, "int");
    clientfield::register("toplayer", "sewer_landing_rumble", 12000, 1, "counter");
    clientfield::register("scriptmover", "dragon_egg_heat_fx", 12000, 1, "int");
    clientfield::register("scriptmover", "dragon_egg_placed", 12000, 1, "counter");
    clientfield::register("actor", "dragon_egg_score_beam_fx", 12000, 1, "counter");
    clientfield::register("world", "force_stream_dragon_egg", 12000, 1, "int");
    clientfield::register("scriptmover", "ethereal_audio_log_fx", 12000, 1, "int");
    clientfield::register("world", "deactivate_ai_vox", 12000, 1, "int");
    clientfield::register("world", "sophia_intro_outro", 12000, 1, "int");
    clientfield::register("allplayers", "sophia_follow", 12000, 3, "int");
    clientfield::register("scriptmover", "sophia_eye_shader", 12000, 1, "int");
    clientfield::register("world", "sophia_main_waveform", 12000, 1, "int");
    clientfield::register("toplayer", "interact_rumble", 12000, 1, "counter");
    level._effect["eye_glow"] = "dlc3/stalingrad/fx_glow_eye_red_stal";
    level._effect["headshot"] = "impacts/fx_flesh_hit";
    level._effect["headshot_nochunks"] = "misc/fx_zombie_bloodsplat";
    level._effect["bloodspurt"] = "misc/fx_zombie_bloodspurt";
    level._effect["animscript_gib_fx"] = "weapon/bullet/fx_flesh_gib_fatal_01";
    level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
    level._effect["switch_sparks"] = "env/electrical/fx_elec_wire_spark_burst";
    level flag::init("is_coop_door_price");
    level.default_start_location = "start_room";
    level.default_game_mode = "zclassic";
    level.b_crossbow_bolt_destroy_on_impact = 1;
    level.b_create_upgraded_crossbow_watchers = 1;
    callback::on_connect(&on_player_connect);
    level.precachecustomcharacters = &precachecustomcharacters;
    level.givecustomcharacters = &givecustomcharacters;
    initcharacterstartindex();
    level.var_d3bc0206 = &function_f7b7d070;
    level.var_f55453ea = &function_c2cd1f49;
    level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
    level.var_237b30e2 = &function_7837e42a;
    level._allow_melee_weapon_switching = 1;
    level.zombiemode_reusing_pack_a_punch = 1;
    level._no_vending_machine_auto_collision = 1;
    level.var_36b5dab = 1;
    level.b_show_single_intermission = 1;
    level.var_20ae5b37 = 1.5;
    level.check_player_is_ready_for_ammo = &check_player_is_ready_for_ammo;
    level.no_target_override = &no_target_override;
    namespace_f37770c8::init();
    namespace_f058d6e4::function_3ebec56b();
    namespace_f058d6e4::function_95743e9f();
    level.var_9cef605e = &namespace_e81d2518::function_aaf7e575;
    level thread namespace_e81d2518::function_90d81e44();
    include_weapons();
    function_42795aca();
    function_a823cd4e();
    level thread function_965d1d83("p7_fxanim_zm_stal_door_buy_factory_floor_bundle", "factory_open");
    level thread function_965d1d83("p7_fxanim_zm_stal_door_buy_barracks_bridge_bundle", "department_floor3_to_red_brick_open");
    level thread function_965d1d83("p7_fxanim_zm_stal_door_buy_armory_bundle", "dept_to_yellow");
    level thread function_965d1d83("p7_fxanim_zm_stal_door_buy_barracks_to_judicial_bundle", "red_brick_to_judicial_street_open", "yellow_to_judicial_street_open");
    level thread function_965d1d83("p7_fxanim_zm_stal_door_buy_dept_store_2f_bundle", "department_store_2f_to_3f");
    level thread function_965d1d83("p7_fxanim_zm_stal_door_buy_armory_judicial_bundle", "yellow_to_judicial_street_open", "red_brick_to_judicial_street_open");
    level thread function_965d1d83("p7_fxanim_zm_stal_door_buy_library_bundle", "library_open");
    level thread function_9c2d9678();
    level thread namespace_9d455fc7::function_622ad391();
    level thread namespace_b57650e4::function_2792df1d();
    level thread function_de23a4cc();
    var_58b5275a = getentarray("sewer_exploder_trigger", "targetname");
    foreach (trigger in var_58b5275a) {
        trigger thread namespace_48c05c81::function_eda4b163();
    }
    /#
        level thread namespace_bde177cb::function_91912a79();
    #/
    level.do_randomized_zigzag_path = 1;
    zombie_utility::set_zombie_var("zombie_powerup_drop_max_per_round", 4);
    namespace_48c05c81::function_4da6e8(1);
    umbragate_set("umbragate1", 1);
    level.round_wait_func = &function_df57d237;
    load::main();
    level thread namespace_c49c3ddb::function_f205a5f1();
    level thread function_80eaf8a();
    level.var_2c12d9a6 = &function_277575cc;
    level.var_2d0e5eb6 = &function_2d0e5eb6;
    level.var_b6d13a4e = &function_13df0656;
    level.var_464197de = &function_90cae0a9;
    level thread namespace_23c72813::function_eed58360();
    level thread namespace_b73d41a1::main();
    level thread namespace_19e79ea1::function_56059128();
    level thread namespace_5132b4d6::function_19458e73();
    namespace_570c8452::init();
    level._round_start_func = &zm::round_start;
    level.fn_custom_round_ai_spawn = &function_33aa4940;
    level.var_c7da0559 = &function_58a468e4;
    level.var_171fdd35 = &function_b9d3803a;
    level thread namespace_8bc21961::function_2f7416e5();
    level.player_intersection_tracker_override = &namespace_e81d2518::player_intersection_tracker_override;
    level.var_661e1459 = &function_661e1459;
    level.zones = [];
    level.zone_manager_init_func = &namespace_521a050e::init;
    init_zones[0] = "start_A_zone";
    thread namespace_486b5371::main();
    level thread zm_zonemgr::manage_zones(init_zones);
    level thread namespace_e81d2518::function_98324cb1();
    level thread namespace_e81d2518::function_b4d22afe();
    level thread namespace_e81d2518::function_285a7d29();
    /#
        level.disable_kill_thread = 1;
    #/
    level.player_out_of_playable_area_monitor_callback = &function_f9248bb;
    level thread sndfunctions();
    level thread namespace_b57650e4::function_2fcaffe2();
    level thread namespace_48c05c81::main();
    level thread function_cd541d08();
    level thread function_d1b24ba4(0);
    level thread namespace_3ae2a359::main();
    level thread namespace_b205ff9c::main();
    level thread namespace_ba7a89c6::main();
    level thread function_897d1ccc();
    level.zm_custom_spawn_location_selection = &function_ff18dfdd;
    level thread function_12a6d70c();
    level thread function_9273a671();
    /#
        level thread namespace_b57650e4::function_5efc91a4();
    #/
    level thread function_ba96daeb();
    setdvar("hkai_pathfindIterationLimit", 1200);
    namespace_15d4d4c0::main_end();
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_3409f322
// Checksum 0xc53cf4c9, Offset: 0x3930
// Size: 0x1de
function function_3409f322() {
    self endon(#"death");
    self endon(#"disconnect");
    level waittill(#"hash_9a634383");
    primary_weapons = self getweaponslist(1);
    self notify(#"zmb_max_ammo");
    self notify(#"hash_987c489b");
    self zm_placeable_mine::disable_all_prompts_for_player();
    for (x = 0; x < primary_weapons.size; x++) {
        if (level.headshots_only && zm_utility::is_lethal_grenade(primary_weapons[x])) {
            continue;
        }
        if (isdefined(level.zombie_include_equipment) && isdefined(level.zombie_include_equipment[primary_weapons[x]]) && !(isdefined(level.zombie_equipment[primary_weapons[x]].refill_max_ammo) && level.zombie_equipment[primary_weapons[x]].refill_max_ammo)) {
            continue;
        }
        if (isdefined(level.zombie_weapons_no_max_ammo) && isdefined(level.zombie_weapons_no_max_ammo[primary_weapons[x].name])) {
            continue;
        }
        if (zm_utility::is_hero_weapon(primary_weapons[x])) {
            continue;
        }
        if (self hasweapon(primary_weapons[x])) {
            self givemaxammo(primary_weapons[x]);
        }
    }
}

// Namespace namespace_320a344e
// Params 1, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_f0f7efad
// Checksum 0xb0f0fa5b, Offset: 0x3b18
// Size: 0x54
function check_player_is_ready_for_ammo(player) {
    if (isdefined(level.var_163a43e4) && array::contains(level.var_163a43e4, player)) {
        player thread function_3409f322();
        return false;
    }
    return true;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_ba96daeb
// Checksum 0x4eb65bc4, Offset: 0x3b78
// Size: 0x54
function function_ba96daeb() {
    level flag::wait_till("start_zombie_round_logic");
    level function_52211d40(0);
    level thread zm_perks::spare_change();
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_c2cd1f49
// Checksum 0x70a2172a, Offset: 0x3bd8
// Size: 0xbe
function function_c2cd1f49() {
    zm_utility::register_lethal_grenade_for_level("frag_grenade");
    level.zombie_lethal_grenade_player_init = getweapon("frag_grenade");
    zm_utility::register_tactical_grenade_for_level("cymbal_monkey");
    zm_utility::register_tactical_grenade_for_level("cymbal_monkey_upgraded");
    zm_utility::register_melee_weapon_for_level(level.weaponbasemelee.name);
    zm_utility::register_melee_weapon_for_level("bowie_knife");
    level.zombie_melee_weapon_player_init = level.weaponbasemelee;
    level.zombie_equipment_player_init = undefined;
}

// Namespace namespace_320a344e
// Params 1, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_a0a06075
// Checksum 0xc79c4df1, Offset: 0x3ca0
// Size: 0xbe
function offhand_weapon_give_override(str_weapon) {
    self endon(#"death");
    if (zm_utility::is_tactical_grenade(str_weapon) && isdefined(self zm_utility::get_player_tactical_grenade()) && !self zm_utility::is_player_tactical_grenade(str_weapon)) {
        self setweaponammoclip(self zm_utility::get_player_tactical_grenade(), 0);
        self takeweapon(self zm_utility::get_player_tactical_grenade());
    }
    return false;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x0
// namespace_320a344e<file_0>::function_438bb72b
// Checksum 0xc0bb2c9e, Offset: 0x3d68
// Size: 0x44
function function_438bb72b() {
    level flag::init("always_on");
    level flag::set("always_on");
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_6e1af22d
// Checksum 0x99ec1590, Offset: 0x3db8
// Size: 0x4
function include_weapons() {
    
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_9273a671
// Checksum 0x29bca935, Offset: 0x3dc8
// Size: 0x4c
function function_9273a671() {
    var_ac878678 = getent("use_elec_switch", "targetname");
    var_ac878678 setcursorhint("HINT_NOICON");
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_c2eb9077
// Checksum 0x99ec1590, Offset: 0x3e20
// Size: 0x4
function precachecustomcharacters() {
    
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_64b491e4
// Checksum 0x8ca3d304, Offset: 0x3e30
// Size: 0x24
function initcharacterstartindex() {
    level.characterstartindex = randomint(4);
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x0
// namespace_320a344e<file_0>::function_31420e52
// Checksum 0x8756a187, Offset: 0x3e60
// Size: 0x3e
function selectcharacterindextouse() {
    if (level.characterstartindex >= 4) {
        level.characterstartindex = 0;
    }
    self.characterindex = level.characterstartindex;
    level.characterstartindex++;
    return self.characterindex;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_be9932bc
// Checksum 0x87924a92, Offset: 0x3ea8
// Size: 0x214
function function_be9932bc() {
    var_9b100591 = [];
    var_9b100591[0] = 0;
    var_9b100591[1] = 1;
    var_9b100591[2] = 2;
    var_9b100591[3] = 3;
    a_e_players = getplayers();
    if (a_e_players.size == 1) {
        var_9b100591 = array::randomize(var_9b100591);
        if (var_9b100591[0] == 2) {
            level.var_fe571972 = 1;
        }
        return var_9b100591[0];
    } else {
        var_266da916 = 0;
        foreach (e_player in a_e_players) {
            if (isdefined(e_player.characterindex)) {
                arrayremovevalue(var_9b100591, e_player.characterindex, 0);
                var_266da916++;
            }
        }
        if (var_9b100591.size > 0) {
            if (var_266da916 == a_e_players.size - 1) {
                if (!(isdefined(level.var_fe571972) && level.var_fe571972)) {
                    level.var_fe571972 = 1;
                    return 2;
                }
            }
            var_9b100591 = array::randomize(var_9b100591);
            if (var_9b100591[0] == 2) {
                level.var_fe571972 = 1;
            }
            return var_9b100591[0];
        }
    }
    return 0;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_a0c0aeb
// Checksum 0xf4ab025b, Offset: 0x40c8
// Size: 0x2cc
function givecustomcharacters() {
    if (isdefined(level.var_dbfdd66c) && [[ level.var_dbfdd66c ]]("c_zom_farmgirl_viewhands")) {
        return;
    }
    self detachall();
    if (!isdefined(self.characterindex)) {
        self.characterindex = function_be9932bc();
    }
    self.favorite_wall_weapons_list = [];
    self.talks_in_danger = 0;
    /#
        if (getdvarstring("zmInventory.player_crafted_shield") != "zmInventory.player_crafted_shield") {
            self.characterindex = getdvarint("zmInventory.player_crafted_shield");
        }
    #/
    self setcharacterbodytype(self.characterindex);
    if (self.characterindex != 2) {
        self setcharacterbodystyle(1);
    }
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
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_f7f01a5c
// Checksum 0x9c24690f, Offset: 0x43a0
// Size: 0x54
function set_exert_id() {
    self endon(#"disconnect");
    util::wait_network_frame();
    util::wait_network_frame();
    self zm_audio::setexertvoice(self.characterindex + 1);
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_80f102b1
// Checksum 0xe7839df3, Offset: 0x4400
// Size: 0x113a
function setup_personality_character_exerts() {
    level.exert_sounds[1]["burp"][0] = "vox_plr_0_exert_burp_0";
    level.exert_sounds[1]["burp"][1] = "vox_plr_0_exert_burp_1";
    level.exert_sounds[1]["burp"][2] = "vox_plr_0_exert_burp_2";
    level.exert_sounds[1]["burp"][3] = "vox_plr_0_exert_burp_3";
    level.exert_sounds[1]["burp"][4] = "vox_plr_0_exert_burp_4";
    level.exert_sounds[1]["burp"][5] = "vox_plr_0_exert_burp_5";
    level.exert_sounds[1]["burp"][6] = "vox_plr_0_exert_burp_6";
    level.exert_sounds[2]["burp"][0] = "vox_plr_1_exert_burp_0";
    level.exert_sounds[2]["burp"][1] = "vox_plr_1_exert_burp_1";
    level.exert_sounds[2]["burp"][2] = "vox_plr_1_exert_burp_2";
    level.exert_sounds[2]["burp"][3] = "vox_plr_1_exert_burp_3";
    level.exert_sounds[3]["burp"][0] = "vox_plr_2_exert_burp_0";
    level.exert_sounds[3]["burp"][1] = "vox_plr_2_exert_burp_1";
    level.exert_sounds[3]["burp"][2] = "vox_plr_2_exert_burp_2";
    level.exert_sounds[3]["burp"][3] = "vox_plr_2_exert_burp_3";
    level.exert_sounds[3]["burp"][4] = "vox_plr_2_exert_burp_4";
    level.exert_sounds[3]["burp"][5] = "vox_plr_2_exert_burp_5";
    level.exert_sounds[3]["burp"][6] = "vox_plr_2_exert_burp_6";
    level.exert_sounds[4]["burp"][0] = "vox_plr_3_exert_burp_0";
    level.exert_sounds[4]["burp"][1] = "vox_plr_3_exert_burp_1";
    level.exert_sounds[4]["burp"][2] = "vox_plr_3_exert_burp_2";
    level.exert_sounds[4]["burp"][3] = "vox_plr_3_exert_burp_3";
    level.exert_sounds[4]["burp"][4] = "vox_plr_3_exert_burp_4";
    level.exert_sounds[4]["burp"][5] = "vox_plr_3_exert_burp_5";
    level.exert_sounds[4]["burp"][6] = "vox_plr_3_exert_burp_6";
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
    level.exert_sounds[4]["hitmed"][3] = "vox_plr_3_exert_pain_4";
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
    level.exert_sounds[1]["drowning"][0] = "vox_plr_0_exert_underwater_air_low_0";
    level.exert_sounds[1]["drowning"][1] = "vox_plr_0_exert_underwater_air_low_1";
    level.exert_sounds[1]["drowning"][2] = "vox_plr_0_exert_underwater_air_low_2";
    level.exert_sounds[1]["drowning"][3] = "vox_plr_0_exert_underwater_air_low_3";
    level.exert_sounds[2]["drowning"][0] = "vox_plr_1_exert_underwater_air_low_0";
    level.exert_sounds[2]["drowning"][1] = "vox_plr_1_exert_underwater_air_low_1";
    level.exert_sounds[2]["drowning"][2] = "vox_plr_1_exert_underwater_air_low_2";
    level.exert_sounds[2]["drowning"][3] = "vox_plr_1_exert_underwater_air_low_3";
    level.exert_sounds[3]["drowning"][0] = "vox_plr_2_exert_underwater_air_low_0";
    level.exert_sounds[3]["drowning"][1] = "vox_plr_2_exert_underwater_air_low_1";
    level.exert_sounds[3]["drowning"][2] = "vox_plr_2_exert_underwater_air_low_2";
    level.exert_sounds[3]["drowning"][3] = "vox_plr_2_exert_underwater_air_low_3";
    level.exert_sounds[4]["drowning"][0] = "vox_plr_3_exert_underwater_air_low_0";
    level.exert_sounds[4]["drowning"][1] = "vox_plr_3_exert_underwater_air_low_1";
    level.exert_sounds[4]["drowning"][2] = "vox_plr_3_exert_underwater_air_low_2";
    level.exert_sounds[4]["drowning"][3] = "vox_plr_3_exert_underwater_air_low_3";
    level.exert_sounds[1]["cough"][0] = "vox_plr_0_exert_cough_0";
    level.exert_sounds[1]["cough"][1] = "vox_plr_0_exert_cough_1";
    level.exert_sounds[1]["cough"][2] = "vox_plr_0_exert_cough_2";
    level.exert_sounds[1]["cough"][3] = "vox_plr_0_exert_cough_3";
    level.exert_sounds[2]["cough"][0] = "vox_plr_1_exert_cough_0";
    level.exert_sounds[2]["cough"][1] = "vox_plr_1_exert_cough_1";
    level.exert_sounds[2]["cough"][2] = "vox_plr_1_exert_cough_2";
    level.exert_sounds[2]["cough"][3] = "vox_plr_1_exert_cough_3";
    level.exert_sounds[3]["cough"][0] = "vox_plr_2_exert_cough_0";
    level.exert_sounds[3]["cough"][1] = "vox_plr_2_exert_cough_1";
    level.exert_sounds[3]["cough"][2] = "vox_plr_2_exert_cough_2";
    level.exert_sounds[3]["cough"][3] = "vox_plr_2_exert_cough_3";
    level.exert_sounds[4]["cough"][0] = "vox_plr_3_exert_cough_0";
    level.exert_sounds[4]["cough"][1] = "vox_plr_3_exert_cough_1";
    level.exert_sounds[4]["cough"][2] = "vox_plr_3_exert_cough_2";
    level.exert_sounds[4]["cough"][3] = "vox_plr_3_exert_cough_3";
    level.exert_sounds[1]["underwater_emerge"][0] = "vox_plr_0_exert_underwater_emerge_0";
    level.exert_sounds[1]["underwater_emerge"][1] = "vox_plr_0_exert_underwater_emerge_1";
    level.exert_sounds[2]["underwater_emerge"][0] = "vox_plr_1_exert_underwater_emerge_0";
    level.exert_sounds[2]["underwater_emerge"][1] = "vox_plr_1_exert_underwater_emerge_1";
    level.exert_sounds[3]["underwater_emerge"][0] = "vox_plr_2_exert_underwater_emerge_0";
    level.exert_sounds[3]["underwater_emerge"][1] = "vox_plr_2_exert_underwater_emerge_1";
    level.exert_sounds[4]["underwater_emerge"][0] = "vox_plr_3_exert_underwater_emerge_0";
    level.exert_sounds[4]["underwater_emerge"][1] = "vox_plr_3_exert_underwater_emerge_1";
    level.exert_sounds[1]["underwater_gasp"][0] = "vox_plr_0_exert_underwater_gasp_0";
    level.exert_sounds[1]["underwater_gasp"][1] = "vox_plr_0_exert_underwater_gasp_1";
    level.exert_sounds[2]["underwater_gasp"][0] = "vox_plr_1_exert_underwater_gasp_0";
    level.exert_sounds[2]["underwater_gasp"][1] = "vox_plr_1_exert_underwater_gasp_1";
    level.exert_sounds[3]["underwater_gasp"][0] = "vox_plr_2_exert_underwater_gasp_0";
    level.exert_sounds[3]["underwater_gasp"][1] = "vox_plr_2_exert_underwater_gasp_1";
    level.exert_sounds[4]["underwater_gasp"][0] = "vox_plr_3_exert_underwater_gasp_0";
    level.exert_sounds[4]["underwater_gasp"][1] = "vox_plr_3_exert_underwater_gasp_1";
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_7837e42a
// Checksum 0x64d3ae1c, Offset: 0x5548
// Size: 0x34
function function_7837e42a() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_stalingrad_weapons.csv", 1);
    zm_weapons::function_9e8dccbe();
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_af7b8b82
// Checksum 0xa001a03b, Offset: 0x5588
// Size: 0x1c
function custom_add_vox() {
    zm_audio::loadplayervoicecategories("gamedata/audio/zm/zm_stalingrad_vox.csv");
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_12446ae9
// Checksum 0x91782a05, Offset: 0x55b0
// Size: 0x64
function sndfunctions() {
    level thread setupmusic();
    level thread init_sounds();
    level thread custom_add_vox();
    level thread setup_personality_character_exerts();
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_8eca036a
// Checksum 0x22ce1001, Offset: 0x5620
// Size: 0x84
function init_sounds() {
    zm_utility::add_sound("break_stone", "evt_break_stone");
    zm_utility::add_sound("gate_door", "zmb_gate_slide_open");
    zm_utility::add_sound("heavy_door", "zmb_heavy_door_open");
    zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_15f74249
// Checksum 0x1560de04, Offset: 0x56b0
// Size: 0x1f4
function setupmusic() {
    zm_audio::musicstate_create("round_start", 3, "stalingrad_roundstart_1", "stalingrad_roundstart_2", "stalingrad_roundstart_3");
    zm_audio::musicstate_create("round_start_short", 3, "stalingrad_roundstart_1", "stalingrad_roundstart_2", "stalingrad_roundstart_3");
    zm_audio::musicstate_create("round_start_first", 3, "stalingrad_roundstart_first");
    zm_audio::musicstate_create("round_end", 3, "stalingrad_roundend_1", "stalingrad_roundend_2", "stalingrad_roundend_3", "stalingrad_roundend_4");
    zm_audio::musicstate_create("sentinel_roundstart", 3, "stalingrad_sentinel_roundstart_1");
    zm_audio::musicstate_create("sentinel_roundend", 3, "stalingrad_sentinel_roundend_1");
    zm_audio::musicstate_create("game_over", 5, "stalingrad_gameover");
    zm_audio::musicstate_create("dead_ended", 4, "dead_ended");
    zm_audio::musicstate_create("ace_of_spades", 4, "ace_of_spades");
    zm_audio::musicstate_create("sam", 4, "sam");
    zm_audio::musicstate_create("none", 4, "none");
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_fb4f96b5
// Checksum 0xf28a3dc1, Offset: 0x58b0
// Size: 0x4c
function on_player_connect() {
    if (level.players.size > 1 && !level flag::get("is_coop_door_price")) {
        function_898d7758();
    }
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_898d7758
// Checksum 0xb6031a, Offset: 0x5908
// Size: 0x282
function function_898d7758() {
    level flag::set("is_coop_door_price");
    var_667e2b8a = getentarray("zombie_door", "targetname");
    foreach (var_12248b8b in var_667e2b8a) {
        if (isdefined(var_12248b8b.zombie_cost)) {
            var_12248b8b.zombie_cost += -6;
            if (isdefined(var_12248b8b.script_label) && var_12248b8b.script_label == "debris_using_door_trigger") {
                var_12248b8b zm_utility::set_hint_string(var_12248b8b, "default_buy_debris", var_12248b8b.zombie_cost);
                continue;
            }
            var_12248b8b zm_utility::set_hint_string(var_12248b8b, "default_buy_door", var_12248b8b.zombie_cost);
        }
    }
    var_bd25e1ce = getentarray("zombie_debris", "targetname");
    foreach (var_53d72eae in var_bd25e1ce) {
        if (isdefined(var_53d72eae.zombie_cost)) {
            var_53d72eae.zombie_cost += -6;
            var_53d72eae zm_utility::set_hint_string(var_53d72eae, "default_buy_debris", var_53d72eae.zombie_cost);
        }
    }
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_42795aca
// Checksum 0xdb2e4658, Offset: 0x5b98
// Size: 0xee
function function_42795aca() {
    level.random_pandora_box_start = 1;
    level.start_chest_name = "dept_store_upper_chest";
    level.magicbox_should_upgrade_weapon_override = &function_87a3ff60;
    level.customrandomweaponweights = &function_659c2324;
    level.var_12d3a848 = 0;
    level.open_chest_location = [];
    level.open_chest_location[0] = "dept_store_upper_chest";
    level.open_chest_location[1] = "red_brick_chest";
    level.open_chest_location[2] = "basement_chest";
    level.open_chest_location[3] = "museum_chest";
    level.open_chest_location[4] = "factory_chest";
    level.open_chest_location[5] = "judicial_chest";
}

// Namespace namespace_320a344e
// Params 2, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_87a3ff60
// Checksum 0x17314a6d, Offset: 0x5c90
// Size: 0x96
function function_87a3ff60(e_player, w_weapon) {
    if (e_player bgb::is_enabled("zm_bgb_crate_power")) {
        return true;
    } else if (isdefined(e_player flag::get("flag_player_collected_reward_5")) && w_weapon == level.weaponzmcymbalmonkey && e_player flag::get("flag_player_collected_reward_5")) {
        return true;
    }
    return false;
}

// Namespace namespace_320a344e
// Params 1, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_659c2324
// Checksum 0xd903b3db, Offset: 0x5d30
// Size: 0x184
function function_659c2324(a_keys) {
    var_b45fbf8c = zm_pap_util::function_f925b7b9();
    if (a_keys[0] === level.var_b0d33e26) {
        level.var_12d3a848 = 0;
        return a_keys;
    }
    n_chance = 0;
    if (zm_weapons::limited_weapon_below_quota(level.var_b0d33e26)) {
        level.var_12d3a848++;
        if (level.var_12d3a848 <= 12) {
            n_chance = 5;
        } else if (level.var_12d3a848 > 12 && level.var_12d3a848 <= 17) {
            n_chance = 8;
        } else if (level.var_12d3a848 > 17) {
            n_chance = 12;
        }
    } else {
        level.var_12d3a848 = 0;
    }
    if (randomint(100) <= n_chance && zm_magicbox::function_9821da97(self, level.var_b0d33e26, var_b45fbf8c) && !self hasweapon(level.var_f0cf2cc9)) {
        arrayinsert(a_keys, level.var_b0d33e26, 0);
        level.var_12d3a848 = 0;
    }
    return a_keys;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_80eaf8a
// Checksum 0xa58856e, Offset: 0x5ec0
// Size: 0x82
function function_80eaf8a() {
    level.var_44ebf6d = 1;
    wait(1);
    level flag::wait_till("start_zombie_round_logic");
    wait(1);
    if (!level flag::get("solo_game")) {
        level flag::wait_till("power_on");
    }
    level notify(#"hash_a7912f12");
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_a823cd4e
// Checksum 0x1308c140, Offset: 0x5f50
// Size: 0xf4
function function_a823cd4e() {
    zm_perk_random::include_perk_in_random_rotation("specialty_armorvest");
    zm_perk_random::include_perk_in_random_rotation("specialty_quickrevive");
    zm_perk_random::include_perk_in_random_rotation("specialty_fastreload");
    zm_perk_random::include_perk_in_random_rotation("specialty_doubletap2");
    zm_perk_random::include_perk_in_random_rotation("specialty_staminup");
    zm_perk_random::include_perk_in_random_rotation("specialty_additionalprimaryweapon");
    zm_perk_random::include_perk_in_random_rotation("specialty_deadshot");
    zm_perk_random::include_perk_in_random_rotation("specialty_electriccherry");
    zm_perk_random::include_perk_in_random_rotation("specialty_widowswine");
    level.custom_random_perk_weights = &function_dded17b1;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_dded17b1
// Checksum 0x3581df57, Offset: 0x6050
// Size: 0x1a4
function function_dded17b1() {
    temp_array = [];
    if (randomint(4) == 0) {
        arrayinsert(temp_array, "specialty_doubletap2", 0);
    }
    if (randomint(4) == 0) {
        arrayinsert(temp_array, "specialty_deadshot", 0);
    }
    if (randomint(4) == 0) {
        arrayinsert(temp_array, "specialty_additionalprimaryweapon", 0);
    }
    if (randomint(4) == 0) {
        arrayinsert(temp_array, "specialty_electriccherry", 0);
    }
    temp_array = array::randomize(temp_array);
    level._random_perk_machine_perk_list = array::randomize(level._random_perk_machine_perk_list);
    level._random_perk_machine_perk_list = arraycombine(level._random_perk_machine_perk_list, temp_array, 1, 0);
    keys = getarraykeys(level._random_perk_machine_perk_list);
    return keys;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_277575cc
// Checksum 0x6989eba6, Offset: 0x6200
// Size: 0x2dc
function function_277575cc() {
    if (level flag::get("lockdown_active")) {
        var_a6abcc5d = zm_zonemgr::get_zone_from_position(self.origin + (0, 0, 32), 0);
        if (var_a6abcc5d == "pavlovs_A_zone") {
            n_index = self getentitynumber();
            var_40d229f9 = struct::get_array("gauntlet_bgb_teleport_" + n_index, "targetname");
            s_player_respawn = arraygetfarthest(self.origin, var_40d229f9);
        } else if (var_a6abcc5d == "pavlovs_B_zone" || var_a6abcc5d == "pavlovs_C_zone") {
            s_player_respawn = undefined;
            var_18fcbdf4 = struct::get("pavlovs_master_respawn", "script_label");
            var_46b9bbf8 = struct::get_array(var_18fcbdf4.target, "targetname");
            n_script_int = self getentitynumber() + 1;
            foreach (var_dbd59eb2 in var_46b9bbf8) {
                if (var_dbd59eb2.script_int === n_script_int) {
                    s_player_respawn = var_dbd59eb2;
                }
            }
        }
    } else if (level flag::get("players_in_arena")) {
        n_index = self getentitynumber();
        var_5381866c = struct::get_array("player_respawn_point_arena", "targetname");
        s_player_respawn = arraygetfarthest(self.origin, var_5381866c);
    } else {
        s_player_respawn = self zm_bgb_anywhere_but_here::function_728dfe3();
    }
    return s_player_respawn;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_2d0e5eb6
// Checksum 0x751a3895, Offset: 0x64e8
// Size: 0x1ec
function function_2d0e5eb6() {
    var_cdb0f86b = getarraykeys(level.zombie_powerups);
    var_b4442b55 = array("shield_charge", "ww_grenade", "bonus_points_team", "code_cylinder_red", "code_cylinder_yellow", "code_cylinder_blue");
    var_62e2eaf2 = [];
    for (i = 0; i < var_cdb0f86b.size; i++) {
        var_77917a61 = 0;
        foreach (var_68de493a in var_b4442b55) {
            if (var_cdb0f86b[i] == var_68de493a) {
                var_77917a61 = 1;
                break;
            }
        }
        if (var_77917a61) {
            continue;
        }
        if (!isdefined(var_62e2eaf2)) {
            var_62e2eaf2 = [];
        } else if (!isarray(var_62e2eaf2)) {
            var_62e2eaf2 = array(var_62e2eaf2);
        }
        var_62e2eaf2[var_62e2eaf2.size] = var_cdb0f86b[i];
    }
    str_powerup = array::random(var_62e2eaf2);
    return str_powerup;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_13df0656
// Checksum 0xb383837d, Offset: 0x66e0
// Size: 0x3c
function function_13df0656() {
    if (isdefined(level.var_163a43e4) && array::contains(level.var_163a43e4, self)) {
        self waittill(#"hash_2e47bc4a");
    }
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_90cae0a9
// Checksum 0x710171fc, Offset: 0x6728
// Size: 0x36
function function_90cae0a9() {
    if (isdefined(level.var_163a43e4) && array::contains(level.var_163a43e4, self)) {
        return true;
    }
    return false;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_33aa4940
// Checksum 0x83eae6f7, Offset: 0x6768
// Size: 0x32c
function function_33aa4940() {
    if (level.players.size == 1) {
        if (level.round_number < 9) {
            return false;
        }
    } else if (level.round_number < 6) {
        return false;
    }
    if (isdefined(level.var_5a487977["raz"]) && level.var_5a487977["raz"].size > 0) {
        if (namespace_1c31c03d::function_7ed6c714(1) == 1) {
            level.zombie_total--;
            return true;
        }
    } else if (isdefined(level.var_5a487977["sentinel_drone"]) && level.var_5a487977["sentinel_drone"].size > 0) {
        if (namespace_8bc21961::function_19d0b055(1) == 1) {
            level.zombie_total--;
            return true;
        }
    }
    if (level.zombie_total <= 10) {
        return false;
    }
    var_c0692329 = 0;
    n_random = randomfloat(100);
    if (level.round_number > 25) {
        if (n_random < 5) {
            var_c0692329 = 1;
        }
    } else if (level.round_number > 20) {
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
        n_roll = randomint(100);
        if (level.round_number < 11 || n_roll < 50) {
            if (namespace_1c31c03d::function_ea911683() && level.var_88fe7b16 < level.var_d60a655e && namespace_1c31c03d::function_7ed6c714(1) == 1) {
                level.var_88fe7b16++;
                level.zombie_total--;
                return true;
            } else {
                return false;
            }
        } else if (namespace_8bc21961::function_74ab7484() && level.var_bd1e3d02 < level.var_b23e9e3a && namespace_8bc21961::function_19d0b055(1) == 1) {
            level.var_bd1e3d02++;
            level.zombie_total--;
            return true;
        } else {
            return false;
        }
    }
    return false;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_58a468e4
// Checksum 0xf4237c87, Offset: 0x6aa0
// Size: 0xec
function function_58a468e4() {
    if (self.b_ignore_cleanup === 1) {
        return;
    }
    foreach (player in level.activeplayers) {
        n_dist_sq = distancesquared(self.origin, player.origin);
        if (n_dist_sq < 6250000) {
            return;
        }
    }
    self thread namespace_f09ec4f7::cleanup_zombie(0);
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_b9d3803a
// Checksum 0xb4e6f3de, Offset: 0x6b98
// Size: 0xec
function function_b9d3803a() {
    if (self.b_ignore_cleanup === 1) {
        return;
    }
    foreach (player in level.activeplayers) {
        n_dist_sq = distancesquared(self.origin, player.origin);
        if (n_dist_sq < 49000000) {
            return;
        }
    }
    self thread namespace_f09ec4f7::cleanup_zombie(0);
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_cd541d08
// Checksum 0x386d7e1a, Offset: 0x6c90
// Size: 0xd2
function function_cd541d08() {
    a_t_traps = getentarray("zombie_trap", "targetname");
    foreach (t_trap in a_t_traps) {
        if (t_trap.script_noteworthy === "electric") {
            t_trap thread function_78c017aa();
        }
    }
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_78c017aa
// Checksum 0xd810fe6e, Offset: 0x6d70
// Size: 0x90
function function_78c017aa() {
    while (true) {
        self waittill(#"trap_activate");
        if (isdefined(self.activated_by_player)) {
            self.activated_by_player clientfield::increment_to_player("interact_rumble");
        }
        self namespace_48c05c81::function_903f6b36(1, self.target);
        self waittill(#"trap_done");
        self namespace_48c05c81::function_903f6b36(0, self.target);
    }
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_897d1ccc
// Checksum 0x2e9b748d, Offset: 0x6e08
// Size: 0x2b2
function function_897d1ccc() {
    n_start_time = undefined;
    while (level.round_number < 4) {
        level waittill(#"start_of_round");
    }
    while (level.round_number < 20) {
        if (level.zombie_total <= 0) {
            a_zombies = getaiteamarray(level.zombie_team);
            var_565450eb = zombie_utility::get_current_zombie_count();
            if (var_565450eb <= 3) {
                a_zombies = getaiteamarray(level.zombie_team);
                foreach (e_zombie in a_zombies) {
                    if (isdefined(e_zombie.zombie_move_speed) && e_zombie.zombie_move_speed == "walk") {
                        e_zombie zombie_utility::set_zombie_run_cycle("run");
                    }
                }
            }
            if (var_565450eb == 1) {
                if (!isdefined(n_start_time)) {
                    n_start_time = gettime();
                }
                n_time = gettime();
                var_be13851f = (n_time - n_start_time) / 1000;
                if (var_be13851f >= 25) {
                    if (isdefined(a_zombies[0].var_827ce236) && a_zombies[0].archetype === "raz" && a_zombies[0].var_827ce236) {
                        blackboard::setblackboardattribute(a_zombies[0], "_locomotion_speed", "locomotion_speed_sprint");
                    } else {
                        a_zombies[0] zombie_utility::set_zombie_run_cycle("sprint");
                    }
                    util::waittill_any_ents(self, "death", level, "start_of_round");
                }
            } else {
                n_start_time = undefined;
            }
        }
        wait(1);
    }
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_661e1459
// Checksum 0x86085193, Offset: 0x70c8
// Size: 0xca
function function_661e1459() {
    players = getplayers();
    foreach (player in players) {
        if (isalive(player.var_4bd1ce6b)) {
            players[players.size] = player.var_4bd1ce6b;
        }
    }
    return players;
}

// Namespace namespace_320a344e
// Params 1, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_ff18dfdd
// Checksum 0x43151632, Offset: 0x71a0
// Size: 0x184
function function_ff18dfdd(a_spots) {
    if (math::cointoss() && level.players.size > 1) {
        if (!isdefined(level.var_7843eb15)) {
            level.var_7843eb15 = 0;
        }
        e_player = level.players[level.var_7843eb15];
        level.var_7843eb15++;
        if (level.var_7843eb15 > level.players.size - 1) {
            level.var_7843eb15 = 0;
        }
        if (!zm_utility::is_player_valid(e_player)) {
            s_spot = array::random(a_spots);
            return s_spot;
        }
        var_e8c67fc0 = array::get_all_closest(e_player.origin, a_spots, undefined, 5);
        if (var_e8c67fc0.size) {
            s_spot = array::random(var_e8c67fc0);
        } else {
            s_spot = array::random(a_spots);
        }
    } else {
        s_spot = array::random(a_spots);
    }
    return s_spot;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_df57d237
// Checksum 0x1bb9db16, Offset: 0x7330
// Size: 0x330
function function_df57d237() {
    level endon(#"restart_round");
    /#
        level endon(#"kill_round");
    #/
    /#
        if (getdvarint("zmInventory.player_crafted_shield")) {
            level waittill(#"forever");
        }
    #/
    if (zm::cheat_enabled(2)) {
        level waittill(#"forever");
    }
    level.var_88fe7b16 = 0;
    level.var_bd1e3d02 = 0;
    if (level.players.size == 1) {
        level.var_d60a655e = level.round_number + 1 - 9;
        level.var_b23e9e3a = level.round_number + 1 - 14;
    } else {
        level.var_d60a655e = level.round_number + 1 - 6;
        level.var_b23e9e3a = level.round_number + 1 - 11;
    }
    /#
        if (getdvarint("zmInventory.player_crafted_shield") == 0) {
            level waittill(#"forever");
        }
    #/
    wait(1);
    /#
        level thread zm::print_zombie_counts();
        level thread zm::sndmusiconkillround();
    #/
    while (true) {
        if (level flag::get("ee_round")) {
            var_377730f = level.zombie_total > 0 || level.intermission;
            if (!var_377730f && level.var_a78effc7 == level.round_number + 1) {
                level.var_a78effc7++;
            }
        } else if (level flag::get("drop_pod_active")) {
            var_377730f = level.zombie_total > 0 || level.intermission || !level flag::get("advance_drop_pod_round");
            if (!var_377730f && level.var_a78effc7 == level.round_number + 1) {
                level.var_a78effc7++;
            }
        } else {
            var_377730f = zombie_utility::get_current_zombie_count() > 0 || level.zombie_total > 0 || level.intermission;
        }
        if (!var_377730f) {
            level thread zm_audio::sndmusicsystem_playstate("round_end");
            return;
        }
        if (level flag::get("end_round_wait")) {
            level thread zm_audio::sndmusicsystem_playstate("round_end");
            return;
        }
        wait(1);
    }
}

// Namespace namespace_320a344e
// Params 3, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_965d1d83
// Checksum 0xa611e18e, Offset: 0x7668
// Size: 0xb4
function function_965d1d83(str_scene, str_flag, var_38cd507c) {
    if (!isdefined(var_38cd507c)) {
        var_38cd507c = undefined;
    }
    level scene::init(str_scene);
    if (isdefined(var_38cd507c)) {
        level flag::wait_till_any(array(str_flag, var_38cd507c));
    } else {
        level flag::wait_till(str_flag);
    }
    level scene::play(str_scene);
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_9c2d9678
// Checksum 0xe163fdb0, Offset: 0x7728
// Size: 0xca
function function_9c2d9678() {
    var_97e8ec5c = getentarray("debris_using_door_trigger", "script_label");
    foreach (var_81072907 in var_97e8ec5c) {
        var_81072907 zm_utility::set_hint_string(var_81072907, "default_buy_debris", var_81072907.zombie_cost);
    }
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_a4a19f50
// Checksum 0x42a423ed, Offset: 0x7800
// Size: 0x4c
function function_a4a19f50() {
    level thread scene::play("p7_fxanim_zm_stal_robot_arm_aperture_door_front_bundle");
    wait(0.66);
    level thread scene::play("p7_fxanim_zm_stal_robot_arm_aperture_door_bundle");
}

// Namespace namespace_320a344e
// Params 3, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_f7b7d070
// Checksum 0x55c84b73, Offset: 0x7858
// Size: 0x2a8
function function_f7b7d070(player, var_65df0562, var_daaea4ad) {
    var_65df0562.alignx = "center";
    var_65df0562.aligny = "middle";
    var_65df0562.horzalign = "center";
    var_65df0562.vertalign = "middle";
    var_65df0562.y -= -76;
    var_65df0562.foreground = 1;
    var_65df0562.fontscale = 3;
    var_65df0562.alpha = 0;
    var_65df0562.color = (1, 1, 1);
    var_65df0562.hidewheninmenu = 1;
    var_65df0562 settext(%ZOMBIE_GAME_OVER);
    var_65df0562 fadeovertime(1);
    var_65df0562.alpha = 1;
    if (player issplitscreen()) {
        var_65df0562.fontscale = 2;
        var_65df0562.y += 40;
    }
    var_daaea4ad.alignx = "center";
    var_daaea4ad.aligny = "middle";
    var_daaea4ad.horzalign = "center";
    var_daaea4ad.vertalign = "middle";
    var_daaea4ad.y -= -106;
    var_daaea4ad.foreground = 1;
    var_daaea4ad.fontscale = 2;
    var_daaea4ad.alpha = 0;
    var_daaea4ad.color = (1, 1, 1);
    var_daaea4ad.hidewheninmenu = 1;
    if (player issplitscreen()) {
        var_daaea4ad.fontscale = 1.5;
        var_daaea4ad.y += 40;
    }
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_12a6d70c
// Checksum 0xdaa4b7ac, Offset: 0x7b08
// Size: 0x4c
function function_12a6d70c() {
    level waittill(#"start_zombie_round_logic");
    if (getdvarint("splitscreen_playerCount") >= 2) {
        return;
    }
    exploder::exploder("fxexp_945");
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_de23a4cc
// Checksum 0xcc903c93, Offset: 0x7b60
// Size: 0x17c
function function_de23a4cc() {
    level waittill(#"power_on");
    playsoundatposition("zmb_stalingrad_main_power_on", (0, 0, 0));
    exploder::exploder("power_on");
    exploder::exploder("eye_beam_factory_green");
    exploder::exploder("eye_beam_library_green");
    exploder::exploder("street_flinger_green");
    exploder::exploder("pavlov_flinger_right_green");
    exploder::exploder("pavlov_flinger_left_green");
    exploder::exploder("trap_finger_green");
    exploder::exploder("trap_bunker_green");
    exploder::exploder("trap_store_green");
    exploder::exploder("bridge_trap_green");
    level function_d1b24ba4(1);
    level function_52211d40(1);
    level function_a4a19f50();
    level thread function_cde49635();
}

// Namespace namespace_320a344e
// Params 1, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_52211d40
// Checksum 0x340ef9a9, Offset: 0x7ce8
// Size: 0x1b2
function function_52211d40(var_7afe5e99) {
    var_358abd8e = getentarray("sophia_vo_eye", "script_noteworthy");
    foreach (var_1c7b6837 in var_358abd8e) {
        switch (var_1c7b6837.model) {
        case 300:
        case 301:
        case 302:
            var_cc8e7aaf = "tag_screen_eye_bg";
            var_f329b7ad = "tag_screen_eye_flatline";
            break;
        case 299:
            var_cc8e7aaf = "tag_eye_bg_animate";
            var_f329b7ad = "tag_eye_flatline_animate";
            break;
        default:
            return;
        }
        if (var_7afe5e99) {
            var_1c7b6837 clientfield::set("sophia_eye_shader", 1);
            var_1c7b6837 showpart(var_f329b7ad);
            continue;
        }
        var_1c7b6837 hidepart(var_cc8e7aaf);
        var_1c7b6837 hidepart(var_f329b7ad);
    }
}

// Namespace namespace_320a344e
// Params 1, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_d1b24ba4
// Checksum 0xfd7ea14e, Offset: 0x7ea8
// Size: 0x192
function function_d1b24ba4(var_7afe5e99) {
    var_eba08983 = getentarray("trap_switch", "script_string");
    if (var_7afe5e99) {
        foreach (var_cfa7c517 in var_eba08983) {
            var_cfa7c517 hidepart("tag_red_light");
            var_cfa7c517 showpart("tag_green_light");
        }
        return;
    }
    foreach (var_cfa7c517 in var_eba08983) {
        var_cfa7c517 showpart("tag_red_light");
        var_cfa7c517 hidepart("tag_green_light");
    }
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_cde49635
// Checksum 0x42b3df9d, Offset: 0x8048
// Size: 0xf6
function function_cde49635() {
    level endon(#"hash_deeb3634");
    wait(3);
    level clientfield::set("sophia_intro_outro", 1);
    wait(1);
    level namespace_dcf9c464::function_8141c730();
    level notify(#"hash_423907c1");
    wait(0.75);
    callback::on_spawned(&function_c2ad8318);
    level thread function_a1369011();
    while (true) {
        e_player = arraygetclosest(level.var_a090a655.origin, level.activeplayers);
        e_player function_a9536aec();
        wait(4);
    }
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_a9536aec
// Checksum 0xe916c8b9, Offset: 0x8148
// Size: 0xee
function function_a9536aec() {
    self endon(#"death");
    b_first_loop = 1;
    while (zm_utility::is_player_valid(self) && namespace_48c05c81::function_86b1188c(750, level.var_a090a655, self)) {
        if (b_first_loop) {
            b_first_loop = 0;
            level.var_f4f5346d = self;
            n_clientfield_val = self getentitynumber() + 1;
            self clientfield::set("sophia_follow", n_clientfield_val);
        }
        wait(1);
    }
    self clientfield::set("sophia_follow", 0);
    level.var_f4f5346d = undefined;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_c2ad8318
// Checksum 0x8270f64a, Offset: 0x8240
// Size: 0x1c
function function_c2ad8318() {
    level thread function_fa9b2a93();
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_fa9b2a93
// Checksum 0x37af2158, Offset: 0x8268
// Size: 0x64
function function_fa9b2a93() {
    if (isdefined(level.var_f4f5346d)) {
        n_clientfield_val = level.var_f4f5346d getentitynumber() + 1;
        level.var_f4f5346d clientfield::set("sophia_follow", n_clientfield_val);
    }
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_a1369011
// Checksum 0xfa7d47db, Offset: 0x82d8
// Size: 0x34
function function_a1369011() {
    level waittill(#"hash_deeb3634");
    callback::remove_on_spawned(&function_c2ad8318);
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_f9248bb
// Checksum 0x8d823a6d, Offset: 0x8318
// Size: 0x22
function function_f9248bb() {
    if (isdefined(self.var_fa6d2a24) && self.var_fa6d2a24) {
        return false;
    }
    return true;
}

// Namespace namespace_320a344e
// Params 1, eflags: 0x1 linked
// namespace_320a344e<file_0>::function_27553de3
// Checksum 0x50bebf07, Offset: 0x8348
// Size: 0xb4
function no_target_override(ai_zombie) {
    if (isdefined(self.var_c74f5ce8) && self.var_c74f5ce8) {
        return;
    }
    if (isdefined(self.var_a779ca57) && self.var_a779ca57) {
        return;
    }
    var_6c8e700c = ai_zombie namespace_f09ec4f7::get_escape_position_in_current_zone();
    if (isalive(ai_zombie) && isdefined(var_6c8e700c) && isdefined(var_6c8e700c.origin)) {
        ai_zombie thread function_dc683d01(var_6c8e700c.origin);
    }
}

// Namespace namespace_320a344e
// Params 1, eflags: 0x5 linked
// namespace_320a344e<file_0>::function_dc683d01
// Checksum 0xab5ad6f3, Offset: 0x8408
// Size: 0xd6
function private function_dc683d01(var_b52b26b9) {
    self endon(#"death");
    self notify(#"stop_find_flesh");
    self notify(#"zombie_acquire_enemy");
    self ai::set_ignoreall(1);
    self.var_c74f5ce8 = 1;
    self thread function_30b905e5();
    self setgoal(var_b52b26b9);
    self util::waittill_any("goal", "reaquire_player");
    self.ai_state = "find_flesh";
    self ai::set_ignoreall(0);
    self.var_c74f5ce8 = undefined;
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x5 linked
// namespace_320a344e<file_0>::function_30b905e5
// Checksum 0xf8fa9a0d, Offset: 0x84e8
// Size: 0x78
function private function_30b905e5() {
    self endon(#"death");
    while (isdefined(self.var_c74f5ce8) && self.var_c74f5ce8) {
        wait(randomfloatrange(0.2, 0.5));
        if (self function_9de8a8db()) {
            self.var_c74f5ce8 = undefined;
            self notify(#"hash_c68d373");
            return;
        }
    }
}

// Namespace namespace_320a344e
// Params 0, eflags: 0x5 linked
// namespace_320a344e<file_0>::function_9de8a8db
// Checksum 0xdb7ec6fc, Offset: 0x8568
// Size: 0x98
function private function_9de8a8db() {
    for (i = 0; i < level.activeplayers.size; i++) {
        if (zombie_utility::is_player_valid(level.activeplayers[i]) && self findpath(self.origin, level.activeplayers[i].origin, 1, 0)) {
            return true;
        }
    }
    return false;
}

