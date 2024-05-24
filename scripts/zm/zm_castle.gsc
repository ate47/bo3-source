#using scripts/zm/_electroball_grenade;
#using scripts/zm/zm_castle_achievements;
#using scripts/zm/zm_castle_vo;
#using scripts/zm/zm_castle_pap_quest;
#using scripts/zm/zm_castle_zones;
#using scripts/zm/zm_castle_zombie;
#using scripts/zm/zm_castle_weap_quest_upgrade;
#using scripts/zm/zm_castle_weap_quest;
#using scripts/zm/zm_castle_util;
#using scripts/zm/zm_castle_tram;
#using scripts/zm/zm_castle_teleporter;
#using scripts/zm/zm_castle_masher_trap;
#using scripts/zm/zm_castle_rocket_trap;
#using scripts/zm/zm_castle_perks;
#using scripts/zm/zm_castle_mechz;
#using scripts/zm/zm_castle_low_grav;
#using scripts/zm/zm_castle_gamemodes;
#using scripts/zm/zm_castle_fx;
#using scripts/zm/zm_castle_flingers;
#using scripts/zm/zm_castle_ffotd;
#using scripts/zm/zm_castle_ee_side;
#using scripts/zm/zm_castle_ee_bossfight;
#using scripts/zm/zm_castle_ee;
#using scripts/zm/zm_castle_dogs;
#using scripts/zm/zm_castle_death_ray_trap;
#using scripts/zm/zm_castle_craftables;
#using scripts/zm/zm_castle_cleanup_mgr;
#using scripts/zm/zm_castle_characters;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_powerup_castle_tram_token;
#using scripts/zm/_zm_powerup_castle_demonic_rune;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_bonus_points_team;
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
#using scripts/zm/_zm_elemental_zombies;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/behavior_zombie_dog;
#using scripts/zm/craftables/_zm_craft_shield;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_weap_plunger;
#using scripts/zm/_zm_weap_castle_rocketshield;
#using scripts/zm/_zm_weap_gravityspikes;
#using scripts/zm/_zm_weap_elemental_bow_wolf_howl;
#using scripts/zm/_zm_weap_elemental_bow_storm;
#using scripts/zm/_zm_weap_elemental_bow_rune_prison;
#using scripts/zm/_zm_weap_elemental_bow_demongate;
#using scripts/zm/_zm_weap_elemental_bow;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_claymore;
#using scripts/zm/_zm_weap_bowie;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_trap_electric;
#using scripts/zm/_zm_timer;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_ai_mechz;
#using scripts/zm/_zm_ai_dogs;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_castle;

// Namespace zm_castle
// Params 0, eflags: 0x2
// Checksum 0x28fda671, Offset: 0x21f8
// Size: 0x4c
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    level.random_pandora_box_start = 1;
    level._no_vending_machine_auto_collision = 1;
    level.pack_a_punch_camo_index = 75;
    level.pack_a_punch_camo_index_number_variants = 5;
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0xaac5ada3, Offset: 0x2250
// Size: 0xabc
function main() {
    namespace_6b519a03::main_start();
    setclearanceceiling(28);
    clientfield::register("clientuimodel", "player_lives", 5000, 2, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_shield_parts", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_fuses", 1, 1, "int");
    clientfield::register("clientuimodel", "zmInventory.player_crafted_shield", 1, 1, "int");
    clientfield::register("toplayer", "player_snow_fx", 5000, 1, "counter");
    clientfield::register("world", "snd_low_gravity_state", 5000, 2, "int");
    clientfield::register("world", "castle_fog_bank_switch", 1, 1, "int");
    spawner::add_archetype_spawn_function("zombie", &function_59909697);
    level._uses_sticky_grenades = 1;
    level._uses_taser_knuckles = 1;
    level.var_1ae26ca5 = 5;
    level.var_bd64e31e = 5;
    level.fn_custom_zombie_spawner_selection = &function_4353b980;
    level.var_3ce1c79c = &function_555e8704;
    level.str_elec_damage_shellshock_override = "castle_electrocution_zm";
    adddebugcommand("devgui_cmd \"ZM/Perks/Drink Dead Shot Daiquir (Castle)i:7\" \"zombie_devgui specialty_deadshot_castle\"\n");
    adddebugcommand("devgui_cmd \"ZM/Perks/Drink Widow's Wine (Castle):9\" \"zombie_devgui specialty_widowswine_castle\"\n");
    adddebugcommand("devgui_cmd \"ZM/Perks/Drink Electric Cherry (Castle):10\" \"zombie_devgui specialty_electriccherry_castle\"\n");
    adddebugcommand("devgui_cmd \"ZM/Perks/Remove All Perks (Castle):0\" \"zombie_devgui remove_perks_castle\"\n");
    adddebugcommand("devgui_cmd \"ZM/AI/Toggle_Skeletons (Castle):0\" \"zombie_devgui toggle_skeletons_castle\"\n");
    level.custom_devgui = &function_fcfd712e;
    level flag::init("rocket_firing");
    zm::init_fx();
    namespace_35f5e9b2::main();
    level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
    level._effect["animscript_gib_fx"] = "weapon/bullet/fx_flesh_gib_fatal_01";
    level._effect["bloodspurt"] = "misc/fx_zombie_bloodspurt";
    level._effect["headshot"] = "impacts/fx_flesh_hit";
    level._effect["headshot_nochunks"] = "misc/fx_zombie_bloodsplat";
    level._effect["raven_death_fx"] = "dlc1/castle/fx_raven_death";
    level._effect["raven_feather_fx"] = "dlc1/castle/fx_raven_death_feathers";
    level._effect["switch_sparks"] = "electric/fx_elec_sparks_directional_orange";
    level.default_start_location = "start_room";
    level.default_game_mode = "zclassic";
    callback::on_spawned(&on_player_spawned);
    callback::on_connect(&on_player_connect);
    level.var_fe571972 = 0;
    level.precachecustomcharacters = &namespace_72c864a4::precachecustomcharacters;
    level.givecustomcharacters = &namespace_72c864a4::givecustomcharacters;
    level thread setup_personality_character_exerts();
    namespace_72c864a4::initcharacterstartindex();
    level.var_f55453ea = &offhand_weapon_overrride;
    level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
    level.sndweaponpickupoverride = array("elemental_bow", "elemental_bow_demongate", "elemental_bow_rune_prison", "elemental_bow_storm", "elemental_bow_wolf_howl");
    level.var_fc2bdb4a = &namespace_97ddfc0d::function_43b44df3;
    level.var_237b30e2 = &function_7837e42a;
    level thread custom_add_vox();
    level._allow_melee_weapon_switching = 1;
    level.enemy_location_override_func = &function_ec0a572;
    level.no_target_override = &no_target_override;
    level.minigun_damage_adjust_override = &function_ec8a9331;
    level.var_2d0e5eb6 = &function_8921895f;
    level.zm_bgb_anywhere_but_here_validation_override = &function_869d6f66;
    level.var_2d4e3645 = &function_d9e1ec4d;
    level.var_9cef605e = &function_98a0818e;
    level.gravityspike_position_check = &function_6190ec3f;
    level.player_score_override = &function_77b8a0f7;
    level.var_b1bb57f0 = &function_5a64329b;
    level.var_4e84030d = &function_f9a3207d;
    level.var_8142aca1 = &function_862e966e;
    level._zombie_custom_spawn_logic = &function_639f3b62;
    level.zm_custom_spawn_location_selection = &function_c624f0b2;
    level.player_out_of_playable_area_monitor_callback = &player_out_of_playable_area_monitor_callback;
    level.debug_keyline_zombies = 0;
    namespace_4fd1ba2a::function_976c9217();
    function_a823cd4e();
    namespace_f2d05c13::main();
    namespace_ee5f5b26::main();
    level thread namespace_2eabe570::main();
    level thread function_69573a4c();
    level thread function_e0836624();
    level thread namespace_c93e4c32::main();
    level thread namespace_b1bc995c::init();
    level thread namespace_61c0be00::main();
    namespace_912a86f7::init();
    namespace_f37770c8::init();
    namespace_dddf9a25::function_cdc13aec();
    namespace_dddf9a25::function_3ebec56b();
    namespace_dddf9a25::function_95743e9f();
    load::main();
    level.var_352c26bc = &function_9b56d76;
    level thread function_13fc99fa();
    level.dog_round_track_override = &namespace_2545f7c9::dog_round_tracker;
    level.custom_dog_target_validity_check = &namespace_2545f7c9::function_1aaa22b5;
    level.fn_custom_round_ai_spawn = &namespace_2545f7c9::function_33aa4940;
    level.dog_spawn_func = &namespace_2545f7c9::function_92e4eaff;
    level.var_3565ea48 = &namespace_2545f7c9::function_8cf500c9;
    level.var_b085eada = getgametypesetting("allowdogs");
    if (level.var_b085eada) {
        namespace_cc5bac97::enable_dog_rounds();
    }
    namespace_48131a3f::function_24025db6();
    zombie_utility::set_zombie_var("below_world_check", -2500);
    level thread function_6058f34d();
    level thread function_a691b3f6();
    level thread function_96405fb1();
    level thread function_632e15ea();
    level thread function_a6477691();
    level thread function_9be4ecd1();
    namespace_570c8452::init();
    level._round_start_func = &zm::round_start;
    level.powerup_fx_func = &function_c7d8dba7;
    init_sounds();
    level.zones = [];
    level.zone_manager_init_func = &namespace_63d46525::init;
    level thread zm_zonemgr::manage_zones(array("zone_start"));
    level thread intro_screen();
    level thread setupmusic();
    level.var_4af51a33 = &function_1ba33179;
    setdvar("hkai_pathfindIterationLimit", 1000);
    /#
        level thread function_287ae5ec();
    #/
    namespace_6b519a03::main_end();
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x3c0a900a, Offset: 0x2d18
// Size: 0x64
function function_59909697() {
    if (issubstr(self.model, "skeleton")) {
        self hidepart("tag_weapon_left");
        self hidepart("tag_weapon_right");
    }
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0xa3ebf435, Offset: 0x2d88
// Size: 0x1ec
function function_4353b980() {
    if (!isdefined(level.var_2c78e44c)) {
        level.var_a70b4aef = [];
        level.var_2c78e44c = [];
        foreach (e_spawner in level.zombie_spawners) {
            if (e_spawner.targetname === "skeleton_spawner") {
                if (!isdefined(level.var_2c78e44c)) {
                    level.var_2c78e44c = [];
                } else if (!isarray(level.var_2c78e44c)) {
                    level.var_2c78e44c = array(level.var_2c78e44c);
                }
                level.var_2c78e44c[level.var_2c78e44c.size] = e_spawner;
                continue;
            }
            if (!isdefined(level.var_a70b4aef)) {
                level.var_a70b4aef = [];
            } else if (!isarray(level.var_a70b4aef)) {
                level.var_a70b4aef = array(level.var_a70b4aef);
            }
            level.var_a70b4aef[level.var_a70b4aef.size] = e_spawner;
        }
    }
    if (level.var_9bf9e084 === 1) {
        sp_zombie = array::random(level.var_2c78e44c);
    } else {
        sp_zombie = array::random(level.var_a70b4aef);
    }
    return sp_zombie;
}

// Namespace zm_castle
// Params 1, eflags: 0x0
// Checksum 0xcc617185, Offset: 0x2f80
// Size: 0x184
function function_1ba33179(zone_name) {
    if (!zm_zonemgr::zone_is_enabled(zone_name)) {
        return false;
    }
    var_46ac7dc1 = 0;
    if (zone_name == "zone_v10_pad" || zone_name == "zone_v10_pad_exterior") {
        var_46ac7dc1 = 1;
    }
    zone = level.zones[zone_name];
    for (i = 0; i < zone.volumes.size; i++) {
        players = getplayers();
        for (j = 0; j < players.size; j++) {
            if (players[j] istouching(zone.volumes[i]) && !(players[j].sessionstate == "spectator")) {
                if (!var_46ac7dc1 || !players[j] laststand::player_is_in_laststand()) {
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0xcf971dca, Offset: 0x3110
// Size: 0xa0
function function_e0836624() {
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

// Namespace zm_castle
// Params 1, eflags: 0x0
// Checksum 0x3c52d705, Offset: 0x31b8
// Size: 0x356
function function_fcfd712e(cmd) {
    var_98be8724 = strtok(cmd, " ");
    var_8ceb4930 = getent("specialty_doubletap2", "script_noteworthy");
    switch (var_98be8724[0]) {
    case 65:
        foreach (player in level.players) {
            var_8ceb4930 zm_perks::vending_trigger_post_think(player, "specialty_deadshot");
        }
        break;
    case 67:
        foreach (player in level.players) {
            var_8ceb4930 zm_perks::vending_trigger_post_think(player, "specialty_widowswine");
        }
        break;
    case 66:
        foreach (player in level.players) {
            var_8ceb4930 zm_perks::vending_trigger_post_think(player, "specialty_electriccherry");
        }
        break;
    case 64:
        zm_devgui::zombie_devgui_take_perks();
        foreach (player in level.players) {
            player notify("specialty_deadshot" + "_stop");
            player notify("specialty_widowswine" + "_stop");
            player notify("specialty_electriccherry" + "_stop");
        }
        break;
    case 68:
        if (level.var_9bf9e084 !== 1) {
            level.var_9bf9e084 = 1;
        } else {
            level.var_9bf9e084 = 0;
        }
        break;
    }
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x4e4a29d5, Offset: 0x3518
// Size: 0x34
function player_out_of_playable_area_monitor_callback() {
    if (isdefined(self.is_flung) && self.is_flung) {
        return false;
    }
    if (isdefined(self.teleport_origin)) {
        return false;
    }
    return true;
}

// Namespace zm_castle
// Params 1, eflags: 0x0
// Checksum 0xc673219a, Offset: 0x3558
// Size: 0x5c
function function_9b56d76(player) {
    if (self.powerup_name == "castle_tram_token" && player clientfield::get_to_player("has_castle_tram_token")) {
        player thread function_f42077ff();
        return false;
    }
    return true;
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x5206158, Offset: 0x35c0
// Size: 0x62
function function_f42077ff() {
    if (!(isdefined(self.var_378aff9e) && self.var_378aff9e)) {
        self.var_378aff9e = 1;
        self thread zm_equipment::show_hint_text(%ZM_CASTLE_TRAM_TOKEN_DENIED, 3);
        wait(6);
        self.var_378aff9e = undefined;
    }
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x516a46c3, Offset: 0x3630
// Size: 0x84
function init_sounds() {
    zm_utility::add_sound("break_stone", "evt_break_stone");
    zm_utility::add_sound("gate_door", "zmb_gate_slide_open");
    zm_utility::add_sound("heavy_door", "zmb_heavy_door_open");
    zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0xd48d3001, Offset: 0x36c0
// Size: 0xbe
function offhand_weapon_overrride() {
    zm_utility::register_lethal_grenade_for_level("frag_grenade");
    level.zombie_lethal_grenade_player_init = getweapon("frag_grenade");
    zm_utility::register_tactical_grenade_for_level("cymbal_monkey");
    zm_utility::register_melee_weapon_for_level(level.weaponbasemelee.name);
    zm_utility::register_melee_weapon_for_level("bowie_knife");
    zm_utility::register_melee_weapon_for_level("knife_plunger");
    level.zombie_melee_weapon_player_init = level.weaponbasemelee;
    level.zombie_equipment_player_init = undefined;
}

// Namespace zm_castle
// Params 1, eflags: 0x0
// Checksum 0x6fa2ff21, Offset: 0x3788
// Size: 0xbe
function offhand_weapon_give_override(str_weapon) {
    self endon(#"death");
    if (zm_utility::is_tactical_grenade(str_weapon) && isdefined(self zm_utility::get_player_tactical_grenade()) && !self zm_utility::is_player_tactical_grenade(str_weapon)) {
        self setweaponammoclip(self zm_utility::get_player_tactical_grenade(), 0);
        self takeweapon(self zm_utility::get_player_tactical_grenade());
    }
    return false;
}

// Namespace zm_castle
// Params 1, eflags: 0x0
// Checksum 0x139a2232, Offset: 0x3850
// Size: 0x138
function function_f9a3207d(ai_enemy) {
    return isdefined(ai_enemy.var_a1c73f09) && ai_enemy.archetype == "mechz" && (ai_enemy.archetype !== "mechz" || isdefined(ai_enemy) && !issubstr(ai_enemy.classname, "keeper") && ai_enemy.var_a1c73f09) && !(isdefined(ai_enemy.var_1ea49cd7) && ai_enemy.var_1ea49cd7) && !(isdefined(ai_enemy.var_bce6e774) && ai_enemy.var_bce6e774) && !(isdefined(ai_enemy.in_gravity_trap) && ai_enemy.in_gravity_trap) && !(isdefined(ai_enemy.b_melee_kill) && ai_enemy.b_melee_kill);
}

// Namespace zm_castle
// Params 1, eflags: 0x0
// Checksum 0x55ff21be, Offset: 0x3990
// Size: 0x30
function function_862e966e(ai_enemy) {
    return !(isdefined(ai_enemy.var_98056717) && ai_enemy.var_98056717);
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x211a01ea, Offset: 0x39c8
// Size: 0x244
function intro_screen() {
    if (1 == getdvarint("movie_intro")) {
        return;
    }
    level flag::wait_till("start_zombie_round_logic");
    wait(2);
    level.var_944e0877 = newhudelem();
    level.var_944e0877.x = 0;
    level.var_944e0877.y = 0;
    level.var_944e0877.alignx = "left";
    level.var_944e0877.aligny = "bottom";
    level.var_944e0877.horzalign = "left";
    level.var_944e0877.vertalign = "bottom";
    level.var_944e0877.foreground = 1;
    if (level.splitscreen && !level.var_1b3d5c61) {
        level.var_944e0877.fontscale = 2.75;
    } else {
        level.var_944e0877.fontscale = 1.75;
    }
    level.var_944e0877.alpha = 0;
    level.var_944e0877.color = (1, 1, 1);
    level.var_944e0877.inuse = 0;
    level.var_944e0877.y = -110;
    level.var_944e0877 fadeovertime(3.5);
    level.var_944e0877.alpha = 1;
    level notify(#"hash_59e5a3dd");
    wait(6);
    level.var_944e0877 fadeovertime(3.5);
    level.var_944e0877.alpha = 0;
    wait(4.5);
    level.var_944e0877 destroy();
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x7ae90265, Offset: 0x3c18
// Size: 0x34
function function_7837e42a() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_castle_weapons.csv", 1);
    zm_weapons::function_9e8dccbe();
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x15223b0f, Offset: 0x3c58
// Size: 0x1c
function custom_add_vox() {
    zm_audio::loadplayervoicecategories("gamedata/audio/zm/zm_castle_vox.csv");
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x618acb38, Offset: 0x3c80
// Size: 0x1f4
function setupmusic() {
    zm_audio::musicstate_create("round_start", 3, "castle_roundstart_1");
    zm_audio::musicstate_create("round_start_short", 3, "castle_roundstart_1");
    zm_audio::musicstate_create("round_start_first", 3, "castle_roundstart_1");
    zm_audio::musicstate_create("round_end", 3, "castle_roundend_1", "castle_roundend_2", "castle_roundend_3");
    zm_audio::musicstate_create("game_over", 5, "castle_gameover");
    zm_audio::musicstate_create("location_lab", 4, "castle_location_lab");
    zm_audio::musicstate_create("requiem", 4, "requiem");
    zm_audio::musicstate_create("dead_again", 4, "dead_again");
    zm_audio::musicstate_create("moon_rockets", 4, "moon_rockets");
    zm_audio::musicstate_create("none", 4, "none");
    array = getentarray("sndMusicLocationTrig", "targetname");
    array::thread_all(array, &function_44dc3fb4);
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0xc5c236c2, Offset: 0x3e80
// Size: 0x90
function function_44dc3fb4() {
    while (true) {
        trigplayer = self waittill(#"trigger");
        if (isplayer(trigplayer)) {
            if (self.script_sound == "richtofen") {
                return;
            }
            zm_audio::sndmusicsystem_playstate("location_" + self.script_sound);
            return;
        }
        wait(0.016);
    }
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0xcf98b747, Offset: 0x3f18
// Size: 0xd4
function on_player_spawned() {
    self allowwallrun(0);
    self allowdoublejump(0);
    self.var_7dd18a0 = 0;
    self.tesla_network_death_choke = 0;
    self.var_b94b5f2f = 1;
    if (!level flag::get("pap_reformed")) {
        self thread namespace_155a700c::function_b9cca08f();
    }
    level flag::wait_till("start_zombie_round_logic");
    wait(0.05);
    self clientfield::increment_to_player("player_snow_fx");
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x53edf0e4, Offset: 0x3ff8
// Size: 0x34
function on_player_connect() {
    self thread namespace_8e89abe3::function_c3f6aa22();
    self thread function_30cebef9();
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x48b5cc2b, Offset: 0x4038
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
    level.custom_random_perk_weights = &function_798c5d1a;
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x5b599423, Offset: 0x4138
// Size: 0x1a4
function function_798c5d1a() {
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

// Namespace zm_castle
// Params 2, eflags: 0x0
// Checksum 0x820a6223, Offset: 0x42e8
// Size: 0x10e
function function_ec0a572(ai_zombie, ai_enemy) {
    aiprofile_beginentry("castle-enemy_location_override");
    if (ai_enemy iswallrunning() || isplayer(ai_enemy) && ai_enemy zm_zonemgr::entity_in_zone("zone_undercroft") && !ai_enemy isonground()) {
        if (!isdefined(ai_enemy.v_ground_pos)) {
            ai_enemy thread function_d578bf1a();
        }
        if (isdefined(ai_enemy.v_ground_pos)) {
            aiprofile_endentry();
            return ai_enemy.v_ground_pos;
        }
    }
    aiprofile_endentry();
    return undefined;
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x27eb61e7, Offset: 0x4400
// Size: 0xe2
function function_d578bf1a() {
    self endon(#"death");
    while (self iswallrunning() || self zm_zonemgr::entity_in_zone("zone_undercroft") && !self isonground()) {
        var_24ab58cb = groundtrace(self.origin, self.origin + (0, 0, -10000), 0, undefined)["position"];
        self.v_ground_pos = getclosestpointonnavmesh(var_24ab58cb, 256);
        wait(0.5);
    }
    self.v_ground_pos = undefined;
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x153eecde, Offset: 0x44f0
// Size: 0x13c
function function_c7d8dba7() {
    if (self.powerup_name === "castle_tram_token") {
        self clientfield::set("powerup_fuse_fx", 1);
        return;
    }
    if (issubstr(self.powerup_name, "demonic_rune")) {
        self clientfield::set("demonic_rune_fx", 1);
        return;
    }
    if (self.only_affects_grabber) {
        self clientfield::set("powerup_fx", 2);
        return;
    }
    if (self.any_team) {
        self clientfield::set("powerup_fx", 4);
        return;
    }
    if (self.zombie_grabbable) {
        self clientfield::set("powerup_fx", 3);
        return;
    }
    self clientfield::set("powerup_fx", 1);
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x83fcbbf4, Offset: 0x4638
// Size: 0xdc
function function_632e15ea() {
    level thread function_814261d();
    level thread function_4da48892();
    level thread function_9c99c6db();
    level thread function_5dd2bbf1();
    var_b549e63 = getent("great_hall_outer_door", "script_noteworthy");
    var_8907f940 = getent("great_hall_inner_door", "script_noteworthy");
    var_8907f940 linkto(var_b549e63);
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x780bdcf6, Offset: 0x4720
// Size: 0xd4
function function_814261d() {
    level thread scene::init("p7_fxanim_zm_castle_barricade_great_hall_left_bundle");
    level thread scene::init("p7_fxanim_zm_castle_barricade_great_hall_right_bundle");
    exploder::exploder("fxexp_112");
    level flag::wait_till("connect_courtyard_to_greathall_upper");
    level thread scene::play("p7_fxanim_zm_castle_barricade_great_hall_left_bundle");
    level thread scene::play("p7_fxanim_zm_castle_barricade_great_hall_right_bundle");
    exploder::exploder_stop("fxexp_112");
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x1b8574a5, Offset: 0x4800
// Size: 0x94
function function_4da48892() {
    level thread scene::init("p7_fxanim_zm_castle_barricade_living_quart_bundle");
    exploder::exploder("fxexp_110");
    level flag::wait_till("connect_lowercourtyard_to_livingquarters");
    level thread scene::play("p7_fxanim_zm_castle_barricade_living_quart_bundle");
    exploder::exploder_stop("fxexp_110");
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x8cb1df24, Offset: 0x48a0
// Size: 0x94
function function_9c99c6db() {
    level thread scene::init("p7_fxanim_zm_castle_barricade_trophy_room_bundle");
    exploder::exploder("fxexp_111");
    level flag::wait_till("connect_subclocktower_to_courtyard");
    level thread scene::play("p7_fxanim_zm_castle_barricade_trophy_room_bundle");
    exploder::exploder_stop("fxexp_111");
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0xaa40e61b, Offset: 0x4940
// Size: 0x10c
function function_5dd2bbf1() {
    level flag::wait_till("power_on");
    e_door_clip = getent("dungeon_door_clip", "targetname");
    e_door_clip delete();
    var_8c7e827f = getent("dungeon_door_left", "targetname");
    var_5548791a = getent("dungeon_door_right", "targetname");
    var_8c7e827f movex(-40, 2, 0, 1);
    var_5548791a movex(40, 2, 0, 1);
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x26df79a3, Offset: 0x4a58
// Size: 0x1b0
function function_8921895f() {
    var_cdb0f86b = getarraykeys(level.zombie_powerups);
    var_b4442b55 = array("bonus_points_team", "shield_charge", "ww_grenade", "demonic_rune_lor", "demonic_rune_mar", "demonic_rune_oth", "demonic_rune_uja", "demonic_rune_ulla", "demonic_rune_zor");
    var_d7a75a6e = [];
    for (i = 0; i < var_cdb0f86b.size; i++) {
        var_77917a61 = 0;
        foreach (var_68de493a in var_b4442b55) {
            if (var_cdb0f86b[i] == var_68de493a) {
                var_77917a61 = 1;
            }
        }
        if (var_77917a61) {
            continue;
        }
        var_d7a75a6e[var_d7a75a6e.size] = var_cdb0f86b[i];
    }
    var_d7a75a6e = array::randomize(var_d7a75a6e);
    return var_d7a75a6e[0];
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0xe78157fe, Offset: 0x4c10
// Size: 0x6e
function function_98a0818e() {
    if (isdefined(self.var_c7a6615d) && (isdefined(self.var_9a017681) && (isdefined(self.is_flung) && self.is_flung || self.var_9a017681) || self.var_c7a6615d)) {
        return false;
    }
    if (isdefined(self.b_teleporting) && self.b_teleporting) {
        return false;
    }
    return true;
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x83b36aff, Offset: 0x4c88
// Size: 0x70
function function_869d6f66() {
    if (!isdefined(self zm_bgb_anywhere_but_here::function_728dfe3())) {
        return false;
    }
    if (level flag::get("boss_fight_begin") && !level flag::get("boss_fight_completed")) {
        return false;
    }
    return true;
}

// Namespace zm_castle
// Params 1, eflags: 0x0
// Checksum 0x5d82e55d, Offset: 0x4d00
// Size: 0x78
function function_d9e1ec4d(a_s_valid_respawn_points) {
    if (level flag::get("rocket_firing")) {
        var_ea555b15 = struct::get("zone_v10_pad_exterior", "script_noteworthy");
        arrayremovevalue(a_s_valid_respawn_points, var_ea555b15);
    }
    return a_s_valid_respawn_points;
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x6767e5c3, Offset: 0x4d80
// Size: 0xdc
function function_6190ec3f() {
    var_3592813c = getent("player_tram_car_interior", "targetname");
    var_a799f077 = getent("docked_tram_car_interior", "targetname");
    if (!ispointonnavmesh(self.origin, self) || self istouching(var_3592813c) || self istouching(var_a799f077)) {
        self thread zm_equipment::show_hint_text(%ZM_CASTLE_GRAVITYSPIKE_BAD_LOCATION, 3);
        return false;
    }
    return true;
}

// Namespace zm_castle
// Params 2, eflags: 0x0
// Checksum 0x65fbff6c, Offset: 0x4e68
// Size: 0x5c
function function_77b8a0f7(var_2f7fd5db, n_points) {
    if (!isdefined(n_points)) {
        return 0;
    }
    if (var_2f7fd5db === getweapon("hero_gravityspikes_melee") && n_points > 20) {
        n_points = 20;
    }
    return n_points;
}

// Namespace zm_castle
// Params 2, eflags: 0x0
// Checksum 0x9da01ff, Offset: 0x4ed0
// Size: 0x44
function function_5a64329b(var_2f7fd5db, n_points) {
    if (var_2f7fd5db === getweapon("hero_gravityspikes_melee")) {
        n_points = 0;
    }
    return n_points;
}

// Namespace zm_castle
// Params 1, eflags: 0x0
// Checksum 0x56e64a74, Offset: 0x4f20
// Size: 0x64
function no_target_override(ai_zombie) {
    if (isdefined(self.var_c74f5ce8) && self.var_c74f5ce8) {
        return;
    }
    var_b52b26b9 = ai_zombie get_escape_position();
    ai_zombie thread function_dc683d01(var_b52b26b9);
}

// Namespace zm_castle
// Params 0, eflags: 0x4
// Checksum 0x1d9c2041, Offset: 0x4f90
// Size: 0x146
function private get_escape_position() {
    str_zone = zm_zonemgr::get_zone_from_position(self.origin + (0, 0, 32), 1);
    if (!isdefined(str_zone)) {
        str_zone = self.zone_name;
    }
    if (isdefined(str_zone)) {
        a_zones = namespace_f59aa2e8::get_adjacencies_to_zone(str_zone);
        a_wait_locations = get_wait_locations_in_zones(a_zones);
        arraysortclosest(a_wait_locations, self.origin);
        a_wait_locations = array::reverse(a_wait_locations);
        for (i = 0; i < a_wait_locations.size; i++) {
            if (a_wait_locations[i] function_eadbcbdb()) {
                return a_wait_locations[i].origin;
            }
        }
    }
    return self.origin;
}

// Namespace zm_castle
// Params 1, eflags: 0x4
// Checksum 0xdde154da, Offset: 0x50e0
// Size: 0xd2
function private get_wait_locations_in_zones(a_zones) {
    a_wait_locations = [];
    foreach (zone in a_zones) {
        a_wait_locations = arraycombine(a_wait_locations, level.zones[zone].a_loc_types["wait_location"], 0, 0);
    }
    return a_wait_locations;
}

// Namespace zm_castle
// Params 0, eflags: 0x4
// Checksum 0x7d5caa67, Offset: 0x51c0
// Size: 0x5e
function private function_eadbcbdb() {
    if (!isdefined(self)) {
        return 0;
    }
    if (!ispointonnavmesh(self.origin) || !zm_utility::check_point_in_playable_area(self.origin)) {
        return 0;
    }
    return 1;
}

// Namespace zm_castle
// Params 1, eflags: 0x4
// Checksum 0x65126481, Offset: 0x5228
// Size: 0xca
function private function_dc683d01(var_b52b26b9) {
    self endon(#"death");
    self notify(#"stop_find_flesh");
    self notify(#"zombie_acquire_enemy");
    self.ignoreall = 1;
    self.var_c74f5ce8 = 1;
    self thread function_30b905e5();
    self setgoal(var_b52b26b9);
    self util::waittill_any_timeout(30, "goal", "reaquire_player", "death");
    self.ai_state = "find_flesh";
    self.ignoreall = 0;
    self.var_c74f5ce8 = undefined;
}

// Namespace zm_castle
// Params 0, eflags: 0x4
// Checksum 0xe2bf1d0c, Offset: 0x5300
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

// Namespace zm_castle
// Params 0, eflags: 0x4
// Checksum 0xa9a4174b, Offset: 0x5380
// Size: 0x80
function private function_9de8a8db() {
    for (i = 0; i < level.activeplayers.size; i++) {
        if (zombie_utility::is_player_valid(level.activeplayers[i])) {
            if (self namespace_e9d5a0ce::function_7b63bf24(level.activeplayers[i])) {
                return true;
            }
        }
        wait(0.1);
    }
    return false;
}

// Namespace zm_castle
// Params 1, eflags: 0x0
// Checksum 0x94db125e, Offset: 0x5408
// Size: 0x16c
function function_c624f0b2(a_spots) {
    if (math::cointoss()) {
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

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x48cfdb36, Offset: 0x5580
// Size: 0x34
function function_69573a4c() {
    scene::add_scene_func("p7_fxanim_gp_raven_idle_eating_bundle", &function_f7046db2, "play");
}

// Namespace zm_castle
// Params 1, eflags: 0x0
// Checksum 0x344ea73a, Offset: 0x55c0
// Size: 0x164
function function_f7046db2(a_ents) {
    e_raven = a_ents["raven_idle"];
    if (isdefined(e_raven)) {
        e_raven setcandamage(1);
        e_raven.health = 100000;
        e_raven thread function_a8aef7fe();
        n_amount, e_attacker, v_direction, v_point, str_type = e_raven waittill(#"damage");
        e_raven playsound("amb_castle_raven_death");
        playfxontag(level._effect["raven_death_fx"], e_raven, "j_pelvis");
        playfxontag(level._effect["raven_feather_fx"], e_raven, "j_pelvis");
        util::wait_network_frame();
        e_raven delete();
    }
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x7a570d8a, Offset: 0x5730
// Size: 0x78
function function_a8aef7fe() {
    self endon(#"damage");
    self endon(#"death");
    wait(randomintrange(3, 9));
    while (true) {
        self playsound("amb_castle_raven_caw");
        wait(randomintrange(11, 21));
    }
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x9ae15467, Offset: 0x57b0
// Size: 0x13c
function function_6058f34d() {
    exploder::exploder("power_door_lgts");
    level flag::wait_till("power_on");
    exploder::exploder("exp_lgt_power_on");
    exploder::exploder("lgt_vending_doubletap2_castle");
    exploder::exploder("lgt_vending_juggernaut_castle");
    exploder::exploder("lgt_vending_mule_kick_castle");
    exploder::exploder("lgt_vending_quick_revive_castle");
    exploder::exploder("lgt_vending_sleight_of_hand_castle");
    exploder::exploder("lgt_vending_stamina_up_castle");
    playsoundatposition("zmb_castle_poweron", (0, 0, 0));
    exploder::exploder_stop("power_door_lgts");
    level thread scene::play("p7_fxanim_zm_castle_door_sliding_bundle");
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x6720595f, Offset: 0x58f8
// Size: 0x1e2
function function_a691b3f6() {
    level scene::init("p7_fxanim_zm_castle_rocket_01_bundle");
    level scene::add_scene_func("p7_fxanim_zm_castle_rocket_01_bundle", &function_7aae0fb2, "play");
    level waittill(#"hash_59e5a3dd");
    level thread scene::play("p7_fxanim_zm_castle_rocket_01_bundle");
    level waittill(#"start_of_round");
    var_d16e2136 = struct::get_array("initial_spawn_points");
    foreach (player in level.players) {
        player zm_utility::create_streamer_hint(var_d16e2136[0].origin, var_d16e2136[0].angles, 1);
    }
    wait(9);
    foreach (player in level.players) {
        player zm_utility::clear_streamer_hint();
    }
}

// Namespace zm_castle
// Params 1, eflags: 0x0
// Checksum 0xbfed8c71, Offset: 0x5ae8
// Size: 0x3c
function function_7aae0fb2(a_ents) {
    array::run_all(level.players, &playrumbleonentity, "zm_castle_opening_rocket_launch");
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x79765153, Offset: 0x5b30
// Size: 0x204
function function_96405fb1() {
    level scene::init("p7_fxanim_zm_power_switch_bundle");
    trig = getent("use_power_switch", "targetname");
    trig sethintstring(%ZOMBIE_ELECTRIC_SWITCH);
    trig setcursorhint("HINT_NOICON");
    cheat = 0;
    user = undefined;
    if (cheat != 1) {
        user = trig waittill(#"trigger");
        if (isdefined(user)) {
            user zm_audio::create_and_play_dialog("general", "power_on");
        }
    }
    level thread scene::play("power_switch", "targetname");
    level flag::set("power_on");
    util::clientnotify("ZPO");
    util::wait_network_frame();
    wait(1);
    exploder::exploder("fxexp_400");
    forward = anglestoforward(trig.origin);
    playfx(level._effect["switch_sparks"], trig.origin, forward);
    trig delete();
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0xf2da1be7, Offset: 0x5d40
// Size: 0x1c
function function_639f3b62() {
    self thread namespace_8e89abe3::function_3ccd9604();
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0xc4a7c3fa, Offset: 0x5d68
// Size: 0x2c4
function function_30cebef9() {
    if (level flag::get("power_on")) {
        exploder::exploder("exp_lgt_power_on");
        exploder::exploder("lgt_vending_doubletap2_castle");
        exploder::exploder("lgt_vending_juggernaut_castle");
        exploder::exploder("lgt_vending_mule_kick_castle");
        exploder::exploder("lgt_vending_quick_revive_castle");
        exploder::exploder("lgt_vending_sleight_of_hand_castle");
        exploder::exploder("lgt_vending_stamina_up_castle");
        exploder::exploder("fxexp_400");
        exploder::exploder("fxexp_710");
        exploder::exploder("fxexp_720");
        if (!level flag::get("tesla_coil_on")) {
            exploder::exploder("lgt_deathray_green");
        }
        exploder::exploder("fxexp_100");
        if (level flag::get("castle_teleporter_used") && !level flag::get("rocket_firing")) {
            exploder::exploder("lgt_rocket_green");
        }
    } else {
        exploder::exploder("power_door_lgts");
    }
    if (level flag::get("upper_courtyard_pad_flag")) {
        exploder::exploder("lgt_upper_courtyard_nolink");
    }
    if (level flag::get("lower_courtyard_pad_flag")) {
        exploder::exploder("lgt_lower_courtyard_nolink");
    }
    if (level flag::get("rooftop_pad_flag")) {
        exploder::exploder("lgt_roof_nolink");
    }
    if (level flag::get("v10_rocket_pad_flag")) {
        exploder::exploder("lgt_v10_nolink");
    }
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x99d6d678, Offset: 0x6038
// Size: 0x278
function function_a6477691() {
    level waittill(#"start_zombie_round_logic");
    sndent = spawn("script_origin", (611, 3496, 699));
    sndent playloopsound("zmb_projector_hum", 0.25);
    while (true) {
        exploder::exploder("lgt_castle_slide_one");
        sndent playsound("zmb_projector_slide");
        wait(randomfloatrange(4, 5));
        exploder::stop_exploder("lgt_castle_slide_one");
        exploder::exploder("lgt_castle_slide_two");
        sndent playsound("zmb_projector_slide");
        wait(randomfloatrange(4, 5));
        exploder::stop_exploder("lgt_castle_slide_two");
        exploder::exploder("lgt_castle_slide_three");
        sndent playsound("zmb_projector_slide");
        wait(randomfloatrange(4, 5));
        exploder::stop_exploder("lgt_castle_slide_three");
        exploder::exploder("lgt_castle_slide_four");
        sndent playsound("zmb_projector_slide");
        wait(randomfloatrange(4, 5));
        exploder::stop_exploder("lgt_castle_slide_four");
        exploder::exploder("lgt_castle_slide_five");
        sndent playsound("zmb_projector_slide");
        wait(randomfloatrange(4, 5));
        exploder::stop_exploder("lgt_castle_slide_five");
    }
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0xe212d569, Offset: 0x62b8
// Size: 0xf4
function function_555e8704() {
    switch (self.unitrigger_stub.in_zone) {
    case 218:
        str_exploder = "fxexp_900";
        break;
    case 214:
        str_exploder = "fxexp_901";
        break;
    case 217:
        str_exploder = "fxexp_902";
        break;
    case 216:
        str_exploder = "fxexp_903";
        break;
    case 215:
        str_exploder = "fxexp_904";
        break;
    }
    exploder::exploder(str_exploder);
    while (self.state == "idle") {
        wait(0.05);
    }
    exploder::exploder_stop(str_exploder);
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x5c45c447, Offset: 0x63b8
// Size: 0x212
function function_9be4ecd1() {
    n_start_time = undefined;
    while (true) {
        if (level.zombie_total <= 0) {
            a_zombies = getaiteamarray(level.zombie_team);
            var_565450eb = zombie_utility::get_current_zombie_count();
            if (var_565450eb <= 3 && level.round_number > 3) {
                a_zombies = getaiteamarray(level.zombie_team);
                foreach (e_zombie in a_zombies) {
                    if (e_zombie.zombie_move_speed == "walk") {
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
                    a_zombies[0] zombie_utility::set_zombie_run_cycle("sprint");
                    util::waittill_any_ents(self, "death", level, "start_of_round");
                }
            } else {
                n_start_time = undefined;
            }
        }
        wait(1);
    }
}

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0x378c0534, Offset: 0x65d8
// Size: 0x622
function setup_personality_character_exerts() {
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

// Namespace zm_castle
// Params 0, eflags: 0x0
// Checksum 0xfe088d48, Offset: 0x6c08
// Size: 0x84
function function_13fc99fa() {
    zombie_utility::set_zombie_var("zombie_powerup_drop_max_per_round", 3);
    level flag::wait_till("start_zombie_round_logic");
    while (level.round_number < 10) {
        level waittill(#"between_round_over");
    }
    zombie_utility::set_zombie_var("zombie_powerup_drop_max_per_round", 4);
}

// Namespace zm_castle
// Params 12, eflags: 0x0
// Checksum 0xcd4bd18a, Offset: 0x6c98
// Size: 0x7c
function function_ec8a9331(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
    if (self.archetype == "mechz") {
        return 0;
    }
}

/#

    // Namespace zm_castle
    // Params 0, eflags: 0x0
    // Checksum 0xfdeda4c4, Offset: 0x6d20
    // Size: 0x38
    function function_2449723c() {
        if (isdefined(self.var_8665ab89)) {
            if (self.var_8665ab89 == gettime()) {
                return 1;
            }
        }
        self.var_8665ab89 = gettime();
        return 0;
    }

    // Namespace zm_castle
    // Params 0, eflags: 0x0
    // Checksum 0xc27ba03, Offset: 0x6d60
    // Size: 0x64
    function function_287ae5ec() {
        level flagsys::wait_till("elemental_bow_rune_prison");
        wait(1);
        zm_devgui::add_custom_devgui_callback(&function_f04119b5);
        adddebugcommand("specialty_deadshot_castle");
    }

    // Namespace zm_castle
    // Params 1, eflags: 0x0
    // Checksum 0x65acb937, Offset: 0x6dd0
    // Size: 0x66
    function function_f04119b5(cmd) {
        switch (cmd) {
        default:
            if (level function_2449723c()) {
                return 1;
            }
            level thread function_7f27602f();
            return 1;
        }
        return 0;
    }

    // Namespace zm_castle
    // Params 0, eflags: 0x0
    // Checksum 0xf773cc0b, Offset: 0x6e40
    // Size: 0x144
    function function_7f27602f() {
        zm_devgui::zombie_devgui_open_sesame();
        level flag::set("demonic_rune_uja");
        var_15ed352b = getentarray("amb_castle_raven_caw", "HINT_NOICON");
        foreach (var_3b9a12e0 in var_15ed352b) {
            var_3b9a12e0 delete();
        }
        level notify(#"hash_854ff4f5");
        var_a6e47643 = struct::get_array("lgt_rocket_green", "HINT_NOICON");
        array::thread_all(var_a6e47643, &function_e9162f72);
    }

    // Namespace zm_castle
    // Params 0, eflags: 0x0
    // Checksum 0x83d1c7db, Offset: 0x6f90
    // Size: 0x84
    function function_e9162f72() {
        var_1143aa58 = getent(self.target, "HINT_NOICON");
        var_9ca35935 = self.script_noteworthy;
        level flag::set(var_9ca35935);
        var_1143aa58 setmodel("zone_living_quarters");
    }

#/
