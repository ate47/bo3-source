#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
#using scripts/zm/zm_sumpf_ffotd;
#using scripts/zm/zm_sumpf_magic_box;
#using scripts/zm/zm_sumpf_fx;
#using scripts/zm/zm_sumpf_achievements;
#using scripts/zm/_zm_trap_electric;
#using scripts/zm/_zm_weap_annihilator;
#using scripts/zm/_zm_weap_tesla;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_powerup_weapon_minigun;
#using scripts/zm/_zm_powerup_nuke;
#using scripts/zm/_zm_powerup_insta_kill;
#using scripts/zm/_zm_powerup_full_ammo;
#using scripts/zm/_zm_powerup_free_perk;
#using scripts/zm/_zm_powerup_fire_sale;
#using scripts/zm/_zm_powerup_carpenter;
#using scripts/zm/_zm_powerup_double_points;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/zm_zmhd_cleanup_mgr;
#using scripts/zm/zm_sumpf_zombie;
#using scripts/zm/_zm_ai_dogs;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/behavior_zombie_dog;
#using scripts/shared/ai/zombie;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/scene_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_e722cafc;

// Namespace namespace_e722cafc
// Params 0, eflags: 0x2
// Checksum 0x6c36654, Offset: 0x11a0
// Size: 0x1c
function autoexec opt_in() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xc368b186, Offset: 0x11c8
// Size: 0x68c
function main() {
    level thread namespace_50c3fea6::main_start();
    level.default_game_mode = "zclassic";
    level.default_start_location = "default";
    level.use_water_risers = 1;
    level.var_9b27bea6 = 1;
    level.var_237b30e2 = &function_7837e42a;
    namespace_ca9187f5::main();
    zm::init_fx();
    level._zmbvoxlevelspecific = &function_30a8bcac;
    level.randomize_perks = 0;
    level.var_22a82a99 = 0;
    level.var_5da290dc = 0;
    level.var_f3d80c6a = 0;
    level.door_dialog_function = &zm::play_door_dialog;
    level.var_61c54e76 = 1;
    level.var_2e01b89b = [];
    level.burning_zombies = [];
    level.var_70f99d16 = 1;
    level.var_b5bbdd6f = "sumpf_kzmb";
    level.custom_ai_type = [];
    if (!isdefined(level.custom_ai_type)) {
        level.custom_ai_type = [];
    } else if (!isarray(level.custom_ai_type)) {
        level.custom_ai_type = array(level.custom_ai_type);
    }
    level.custom_ai_type[level.custom_ai_type.size] = &namespace_cc5bac97::init;
    level.var_f55453ea = &offhand_weapon_overrride;
    level.var_70f99d16 = 1;
    level.givecustomcharacters = &givecustomcharacters;
    initcharacterstartindex();
    level._round_start_func = &zm::round_start;
    level._effect["zombie_grain"] = "misc/fx_zombie_grain_cloud";
    function_9b6974d6();
    clientfield::register("world", "SUMPF_VISIONSET_DOGS", 21000, 1, "int");
    clientfield::register("actor", "zombie_flogger_trap", 21000, 1, "int");
    clientfield::register("allplayers", "player_legs_hide", 21000, 1, "int");
    clientfield::register("clientuimodel", "player_lives", 1, 2, "int");
    function_a823cd4e();
    load::main();
    level.default_laststandpistol = getweapon("pistol_m1911");
    level.default_solo_laststandpistol = getweapon("pistol_m1911_upgraded");
    level.laststandpistol = level.default_laststandpistol;
    level.start_weapon = level.default_laststandpistol;
    level thread zm::function_e7cfa7b8();
    function_12859198();
    level thread zm_perks::spare_change();
    namespace_570c8452::init();
    namespace_40b4687d::init();
    namespace_cc5bac97::enable_dog_rounds();
    level.zones = [];
    level.zone_manager_init_func = &function_e929e63e;
    init_zones[0] = "center_building_upstairs";
    level thread zm_zonemgr::manage_zones(init_zones);
    level.zombie_ai_limit = 24;
    level.validate_poi_attractors = 1;
    level thread function_94947ac7();
    /#
        level.custom_devgui = &function_920754d;
    #/
    init_sounds();
    level thread setupmusic();
    level notify(#"hash_6e71514f");
    level.var_88fc178c = 0;
    setculldist(2400);
    /#
        function_27cb39f1();
    #/
    setdvar("sv_maxPhysExplosionSpheres", 15);
    setdvar("r_lightGridEnableTweaks", 1);
    setdvar("r_lightGridIntensity", 1.25);
    setdvar("r_lightGridContrast", 0.1);
    level thread function_c283498();
    function_39a5be7e();
    level thread function_5b94e922();
    setdvar("player_shallowWaterWadeScale", 0.55);
    setdvar("player_waistWaterWadeScale", 0.55);
    scene::add_scene_func("p7_fxanim_zm_sumpf_zipline_down_bundle", &function_b87f949f, "init");
    level scene::init("p7_fxanim_zm_sumpf_zipline_down_bundle");
    level.zm_bgb_anywhere_but_here_validation_override = &function_869d6f66;
    level.var_9cef605e = &function_3e7eb37b;
    level thread namespace_50c3fea6::main_end();
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x38af74b4, Offset: 0x1860
// Size: 0x8e
function function_12859198() {
    level._effect["doubletap2_light"] = "dlc5/zmhd/fx_perk_doubletap";
    level._effect["jugger_light"] = "dlc5/zmhd/fx_perk_juggernaut";
    level._effect["revive_light"] = "dlc5/zmhd/fx_perk_quick_revive";
    level._effect["sleight_light"] = "dlc5/zmhd/fx_perk_sleight_of_hand";
    level._effect["additionalprimaryweapon_light"] = "dlc5/zmhd/fx_perk_mule_kick";
}

// Namespace namespace_e722cafc
// Params 1, eflags: 0x1 linked
// Checksum 0x4563a656, Offset: 0x18f8
// Size: 0x92
function function_b87f949f(a_ents) {
    foreach (ent in a_ents) {
        ent setignorepauseworld(1);
    }
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xf876005e, Offset: 0x1998
// Size: 0x110
function function_5b94e922() {
    level endon(#"end_game");
    var_6c4e714 = struct::get_array("hanging_dead_guy_force", "targetname");
    n_index = 0;
    while (true) {
        while (!(isdefined(zm_zonemgr::any_player_in_zone("center_building_upstairs")) && zm_zonemgr::any_player_in_zone("center_building_upstairs"))) {
            wait(0.1);
        }
        physicsexplosionsphere(var_6c4e714[n_index].origin + (0, 5, 0), 20, 10, 0.09);
        n_index++;
        if (n_index >= var_6c4e714.size) {
            n_index = 0;
        }
        wait(1);
    }
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xe2514886, Offset: 0x1ab0
// Size: 0x42
function function_869d6f66() {
    if (!isdefined(self zm_bgb_anywhere_but_here::function_728dfe3())) {
        return false;
    }
    if (isdefined(self.on_zipline) && self.on_zipline) {
        return false;
    }
    return true;
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xb3091b18, Offset: 0x1b00
// Size: 0x22
function function_3e7eb37b() {
    if (isdefined(self.on_zipline) && self.on_zipline) {
        return false;
    }
    return true;
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x91cfac1e, Offset: 0x1b30
// Size: 0x34
function function_39a5be7e() {
    level flag::wait_till("start_zombie_round_logic");
    zm_power::turn_power_on_and_open_doors();
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x5d6f3231, Offset: 0x1b70
// Size: 0x78
function function_c283498() {
    while (true) {
        level flag::wait_till("dog_round");
        level clientfield::set("SUMPF_VISIONSET_DOGS", 1);
        level waittill(#"hash_d7c2375a");
        level clientfield::set("SUMPF_VISIONSET_DOGS", 0);
    }
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x5d443cfc, Offset: 0x1bf0
// Size: 0x2f4
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
        if (getdvarstring("zombie_flogger_trap") != "zombie_flogger_trap") {
            self.characterindex = getdvarint("zombie_flogger_trap");
        }
    #/
    self setcharacterbodytype(self.characterindex);
    self setcharacterbodystyle(0);
    self setcharacterhelmetstyle(0);
    switch (self.characterindex) {
    case 0:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("frag_grenade");
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("bouncingbetty");
        break;
    case 1:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("870mcs");
        break;
    case 2:
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("hk416");
        break;
    case 3:
        self.talks_in_danger = 1;
        level.rich_sq_player = self;
        level.var_b879b3b4 = self;
        self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("pistol_standard");
        break;
    }
    level.vox zm_audio::zmbvoxinitspeaker("player", "vox_plr_", self);
    self thread namespace_52adc03e::set_exert_id();
    self setmovespeedscale(1);
    self function_ba25e637(4);
    self function_e67885f8(0);
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x8aa33263, Offset: 0x1ef0
// Size: 0x154
function assign_lowest_unused_character_index() {
    charindexarray = [];
    charindexarray[0] = 0;
    charindexarray[1] = 1;
    charindexarray[2] = 2;
    charindexarray[3] = 3;
    if (level.players.size == 1) {
        charindexarray = array::randomize(charindexarray);
        return charindexarray[0];
    } else {
        foreach (player in level.players) {
            if (isdefined(player.characterindex)) {
                arrayremovevalue(charindexarray, player.characterindex, 0);
            }
        }
        if (charindexarray.size > 0) {
            return charindexarray[0];
        }
    }
    return 0;
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x2d2005f8, Offset: 0x2050
// Size: 0x24
function initcharacterstartindex() {
    level.characterstartindex = randomint(4);
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x0
// Checksum 0xdeba4c3, Offset: 0x2080
// Size: 0x3e
function selectcharacterindextouse() {
    if (level.characterstartindex >= 4) {
        level.characterstartindex = 0;
    }
    self.characterindex = level.characterstartindex;
    level.characterstartindex++;
    return self.characterindex;
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x2b8358a, Offset: 0x20c8
// Size: 0x224
function function_e929e63e() {
    level flag::init("always_on");
    level flag::set("always_on");
    zm_zonemgr::add_adjacent_zone("center_building_upstairs", "center_building_upstairs_buy", "unlock_hospital_upstairs");
    zm_zonemgr::add_adjacent_zone("center_building_upstairs", "center_building_combined", "unlock_hospital_downstairs");
    zm_zonemgr::add_adjacent_zone("center_building_upstairs_buy", "center_building_combined", "unlock_hospital_upstairs");
    zm_zonemgr::add_adjacent_zone("center_building_upstairs_buy", "center_building_combined", "unlock_hospital_downstairs");
    zm_zonemgr::add_adjacent_zone("center_building_combined", "northeast_outside", "ne_magic_box");
    zm_zonemgr::add_adjacent_zone("center_building_combined", "northwest_outside", "nw_magic_box");
    zm_zonemgr::add_adjacent_zone("center_building_combined", "southeast_outside", "se_magic_box");
    zm_zonemgr::add_adjacent_zone("center_building_combined", "southwest_outside", "sw_magic_box");
    zm_zonemgr::add_adjacent_zone("northeast_outside", "northeast_building", "northeast_building_unlocked");
    zm_zonemgr::add_adjacent_zone("northwest_outside", "northwest_building", "northwest_building_unlocked");
    zm_zonemgr::add_adjacent_zone("southeast_outside", "southeast_building", "southeast_building_unlocked");
    zm_zonemgr::add_adjacent_zone("southwest_outside", "southwest_building", "southwest_building_unlocked");
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xfbf69bc8, Offset: 0x22f8
// Size: 0x15c
function init_sounds() {
    zm_utility::add_sound("zmb_wooden_door", "zmb_door_wood_open");
    zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
    level thread custom_add_vox();
    level.var_28d3a005 = 1;
    /#
        iprintlnbold("zombie_flogger_trap");
    #/
    level thread function_c06f4240();
    level thread function_5a36831b();
    level thread function_34a348fc();
    level thread function_8aa785e();
    level thread function_b962c94f();
    level thread function_49b61680();
    level thread function_f3641ebb();
    level thread function_44147464();
    level thread function_d166ac07();
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xf14133fb, Offset: 0x2460
// Size: 0x1f4
function setupmusic() {
    zm_audio::musicstate_create("round_start", 3, "sumpf_roundstart_1", "sumpf_roundstart_2", "sumpf_roundstart_3", "sumpf_roundstart_4");
    zm_audio::musicstate_create("round_start_short", 3, "sumpf_roundstart_1", "sumpf_roundstart_2", "sumpf_roundstart_3", "sumpf_roundstart_4");
    zm_audio::musicstate_create("round_start_first", 3, "sumpf_roundstart_1", "sumpf_roundstart_2", "sumpf_roundstart_3", "sumpf_roundstart_4");
    zm_audio::musicstate_create("round_end", 3, "sumpf_roundend_1", "sumpf_roundend_2", "sumpf_roundend_3", "sumpf_roundend_4");
    zm_audio::musicstate_create("dog_start", 3, "dog_start_1");
    zm_audio::musicstate_create("dog_end", 3, "dog_end_1");
    zm_audio::musicstate_create("the_one", 4, "the_one");
    zm_audio::musicstate_create("game_over", 5, "game_over_zhd_sumpf");
    zm_audio::musicstate_create("none", 4, "none");
    zm_audio::musicstate_create("sam", 4, "sam");
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x9de34e95, Offset: 0x2660
// Size: 0xa6
function offhand_weapon_overrride() {
    zm_utility::register_lethal_grenade_for_level("frag_grenade");
    level.zombie_lethal_grenade_player_init = getweapon("frag_grenade");
    zm_utility::register_tactical_grenade_for_level("cymbal_monkey");
    zm_utility::register_tactical_grenade_for_level("cymbal_monkey_upgraded");
    zm_utility::register_melee_weapon_for_level(level.weaponbasemelee.name);
    level.zombie_melee_weapon_player_init = level.weaponbasemelee;
    level.zombie_equipment_player_init = undefined;
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xf164470d, Offset: 0x2710
// Size: 0x24
function function_7837e42a() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_sumpf_weapons.csv", 1);
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xc7a0e312, Offset: 0x2740
// Size: 0x1c
function custom_add_vox() {
    zm_audio::loadplayervoicecategories("gamedata/audio/zm/zm_prototype_vox.csv");
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xdda96718, Offset: 0x2768
// Size: 0x7c
function function_9b6974d6() {
    thread namespace_cc27c57e::function_2a476331();
    var_27f3715d = getent("zipline_deactivated_hint_trigger", "targetname");
    var_27f3715d sethintstring(%ZOMBIE_ZIPLINE_DEACTIVATED);
    var_27f3715d setcursorhint("HINT_NOICON");
}

// Namespace namespace_e722cafc
// Params 1, eflags: 0x1 linked
// Checksum 0xe1d77230, Offset: 0x27f0
// Size: 0x74
function function_e1aaca19(name) {
    str_light_red = name + "_red";
    str_light_green = name + "_green";
    exploder::stop_exploder(str_light_red);
    exploder::exploder(str_light_green);
}

// Namespace namespace_e722cafc
// Params 1, eflags: 0x1 linked
// Checksum 0xf2f6a652, Offset: 0x2870
// Size: 0x74
function function_5ba3c6e5(name) {
    str_light_red = name + "_red";
    str_light_green = name + "_green";
    exploder::stop_exploder(str_light_green);
    exploder::exploder(str_light_red);
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xc0a14d84, Offset: 0x28f0
// Size: 0x17c
function function_f3641ebb() {
    var_f782ba13 = 0;
    var_1aa6067f = getent("book_trig", "targetname");
    var_1aa6067f setcursorhint("HINT_NOICON");
    var_1aa6067f usetriggerrequirelookat();
    /#
        level thread function_620401c0((11308, 3635, -582), "zombie_flogger_trap", var_1aa6067f, "zombie_flogger_trap");
    #/
    if (isdefined(var_1aa6067f)) {
        var_52b62bf1 = getent("maniac_l", "targetname");
        var_66d8ddaf = getent("maniac_r", "targetname");
        player = var_1aa6067f waittill(#"trigger");
        if (isdefined(var_52b62bf1)) {
            var_52b62bf1 playsound("evt_maniac_l");
        }
        if (isdefined(var_66d8ddaf)) {
            var_66d8ddaf playsound("evt_maniac_r");
        }
    }
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xc4f8591f, Offset: 0x2a78
// Size: 0x2dc
function function_c06f4240() {
    var_98bdea4b = struct::get("s_phone_egg", "targetname");
    if (!isdefined(var_98bdea4b)) {
        return;
    }
    var_98bdea4b zm_unitrigger::create_unitrigger(undefined, 256);
    var_e5549a81 = spawn("script_origin", var_98bdea4b.origin);
    for (var_fd0167be = 0; var_fd0167be < 4; var_fd0167be++) {
        var_98bdea4b waittill(#"trigger_activated");
        if (isdefined(level.musicsystemoverride) && (isdefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4 || level.musicsystemoverride)) {
            continue;
        }
        switch (var_fd0167be) {
        case 0:
            var_e5549a81 playloopsound("evt_phone_dialtone");
            wait(1);
            break;
        case 1:
            var_e5549a81 stoploopsound(0.5);
            var_e5549a81 playsound("evt_dial_9");
            wait(0.25);
            break;
        case 2:
            var_e5549a81 playsound("evt_dial_1");
            wait(0.25);
            break;
        case 3:
            var_e5549a81 playsound("evt_dial_1");
            wait(0.5);
            var_e5549a81 playsound("evt_riiing");
            wait(2.5);
            var_e5549a81 playsound("evt_riiing");
            wait(2);
            var_e5549a81 playsound("evt_phone_answer");
            wait(3.7);
            break;
        }
    }
    playsoundatposition("zmb_cha_ching", var_98bdea4b.origin);
    zm_unitrigger::unregister_unitrigger(var_98bdea4b.s_unitrigger);
    level thread zm_audio::sndmusicsystem_playstate("the_one");
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xf83522d0, Offset: 0x2d60
// Size: 0x8a
function function_e87b4b46() {
    /#
        iprintlnbold("zombie_flogger_trap");
    #/
    var_24e459e0 = getent("speaker_in_attic", "targetname");
    wait(0.05);
    var_24e459e0 playsoundwithnotify("evt_secret_message", "message_complete");
    var_24e459e0 waittill(#"hash_a5b4eb80");
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x5309a920, Offset: 0x2df8
// Size: 0x6c
function function_b962c94f() {
    if (!isdefined(level.var_af368383)) {
        level.var_af368383 = 0;
    }
    while (level.var_af368383 < 3) {
        wait(1);
    }
    level thread function_e87b4b46();
    /#
        iprintlnbold("zombie_flogger_trap");
    #/
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x33f5ce11, Offset: 0x2e70
// Size: 0x86
function function_34a348fc() {
    level.var_34a348fc = getentarray("super_egg_radio", "targetname");
    if (isdefined(level.var_34a348fc)) {
        for (i = 0; i < level.var_34a348fc.size; i++) {
            level.var_34a348fc[i] thread function_53e56ac8();
        }
    }
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x696f0a17, Offset: 0x2f00
// Size: 0x94
function function_53e56ac8() {
    if (!isdefined(level.var_d3b77e58)) {
        level.var_d3b77e58 = 0;
    }
    self zm_unitrigger::create_unitrigger(undefined, -128);
    /#
    #/
    self waittill(#"trigger_activated");
    self zm_unitrigger::unregister_unitrigger(self.unitrigger);
    level.var_d3b77e58 += 1;
    self playloopsound(self.script_sound);
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xb7978a4f, Offset: 0x2fa0
// Size: 0x6a
function function_f379331c() {
    var_24e459e0 = getent("speaker_in_attic", "targetname");
    wait(0.05);
    var_24e459e0 playsoundwithnotify("vox_superegg_secret_message", "message_complete");
    var_24e459e0 waittill(#"hash_a5b4eb80");
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x79a48340, Offset: 0x3018
// Size: 0x4c
function function_44147464() {
    if (!isdefined(level.var_d3b77e58)) {
        level.var_d3b77e58 = 0;
    }
    while (level.var_d3b77e58 < 3) {
        wait(2);
    }
    level thread function_f379331c();
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xad290428, Offset: 0x3070
// Size: 0x86
function function_8aa785e() {
    level.var_34a348fc = getentarray("sur_radio", "targetname");
    if (isdefined(level.var_34a348fc)) {
        for (i = 0; i < level.var_34a348fc.size; i++) {
            level.var_34a348fc[i] thread function_4deca569();
        }
    }
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x80e30b38, Offset: 0x3100
// Size: 0x6c
function function_4deca569() {
    if (!isdefined(level.var_d3b77e58)) {
        level.var_d3b77e58 = 0;
    }
    self thread namespace_6e97c459::function_dd92f786("sur_radio_activated");
    /#
    #/
    self waittill(#"hash_37c1298d");
    self playsound(self.script_sound);
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x5747f54e, Offset: 0x3178
// Size: 0x86
function function_5a36831b() {
    level.var_5a36831b = getentarray("radio_hut", "targetname");
    if (isdefined(level.var_5a36831b)) {
        for (i = 0; i < level.var_5a36831b.size; i++) {
            level.var_5a36831b[i] thread function_2fa9f915();
        }
    }
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xf4b403b9, Offset: 0x3208
// Size: 0x94
function function_2fa9f915() {
    if (!isdefined(level.var_af368383)) {
        level.var_af368383 = 0;
    }
    self zm_unitrigger::create_unitrigger(undefined, -128);
    /#
    #/
    self waittill(#"trigger_activated");
    self zm_unitrigger::unregister_unitrigger(self.unitrigger);
    level.var_af368383 += 1;
    self playloopsound(self.script_sound);
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x3c850cbc, Offset: 0x32a8
// Size: 0x134
function function_49b61680() {
    player = getplayers();
    level endon(#"hash_27752613");
    dmgtrig = getent("meteor", "targetname");
    /#
        level thread function_620401c0((11260.5, -2091, -634), "zombie_flogger_trap", dmgtrig, "zombie_flogger_trap", 3);
    #/
    while (true) {
        player = dmgtrig waittill(#"trigger");
        if (distancesquared(player.origin, dmgtrig.origin) < 100000000) {
            player thread zm_audio::create_and_play_dialog("level", "meteor");
            level notify(#"hash_27752613");
            continue;
        }
        wait(0.1);
    }
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x33e8
// Size: 0x4
function function_17319630() {
    
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x0
// Checksum 0x3c590ff5, Offset: 0x33f8
// Size: 0x116
function function_38be3a68() {
    structs = struct::get_array("initial_spawn_points", "targetname");
    level flag::wait_till("start_zombie_round_logic");
    players = getplayers();
    for (i = 0; i < players.size; i++) {
        players[i] setorigin(structs[i].origin);
        players[i] setplayerangles(structs[i].angles);
        players[i].spectator_respawn = structs[i];
    }
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x7f38733d, Offset: 0x3518
// Size: 0x46
function function_94947ac7() {
    level waittill(#"between_round_over");
    level._effect["rise_burst_water"] = "maps/zombie/fx_zombie_body_wtr_burst_smpf";
    level._effect["rise_billow_water"] = "maps/zombie/fx_zombie_body_wtr_billow_smpf";
}

/#

    // Namespace namespace_e722cafc
    // Params 1, eflags: 0x1 linked
    // Checksum 0x11c803e8, Offset: 0x3568
    // Size: 0x9a
    function function_920754d(cmd) {
        var_98be8724 = strtok(cmd, "zombie_flogger_trap");
        switch (var_98be8724[0]) {
        case 8:
            function_22476936();
            break;
        case 8:
            function_c54ccb33();
            break;
        default:
            break;
        }
    }

    // Namespace namespace_e722cafc
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4c98a1d5, Offset: 0x3610
    // Size: 0xd4
    function function_22476936() {
        if (level.round_number <= 1) {
            level flag::wait_till("zombie_flogger_trap");
            iprintln("zombie_flogger_trap");
            wait(12);
        }
        n_next_round = level.round_number + 1;
        level.next_dog_round = n_next_round;
        iprintln("zombie_flogger_trap" + n_next_round);
        zm_devgui::zombie_devgui_goto_round(n_next_round);
        iprintln("zombie_flogger_trap" + n_next_round);
    }

    // Namespace namespace_e722cafc
    // Params 0, eflags: 0x1 linked
    // Checksum 0x55ac1ba2, Offset: 0x36f0
    // Size: 0x78
    function function_c54ccb33() {
        var_4d028102 = getent("zombie_flogger_trap", "zombie_flogger_trap");
        if (isdefined(var_4d028102)) {
            zm_devgui::zombie_devgui_open_sesame();
            var_4d028102 notify(#"trigger", getplayers()[0]);
        }
    }

    // Namespace namespace_e722cafc
    // Params 0, eflags: 0x1 linked
    // Checksum 0xb39a1a5, Offset: 0x3770
    // Size: 0xbe
    function function_27cb39f1() {
        if (!getdvarint("zombie_flogger_trap")) {
            return;
        }
        all_nodes = getallnodes();
        for (i = 0; i < all_nodes.size; i++) {
            node = all_nodes[i];
            if (node.type == "zombie_flogger_trap") {
                node thread debug_display();
            }
        }
    }

    // Namespace namespace_e722cafc
    // Params 0, eflags: 0x1 linked
    // Checksum 0x860e7d40, Offset: 0x3838
    // Size: 0x50
    function debug_display() {
        while (true) {
            print3d(self.origin, self.animscript, (1, 0, 0), 1, 0.2, 1);
            wait(0.05);
        }
    }

    // Namespace namespace_e722cafc
    // Params 5, eflags: 0x1 linked
    // Checksum 0x5fb76797, Offset: 0x3890
    // Size: 0xd8
    function function_620401c0(v_org, str_msg, var_5d64a595, str_ender, n_scale) {
        if (!isdefined(n_scale)) {
            n_scale = 1;
        }
        var_5d64a595 endon(str_ender);
        level thread function_9a889da5(str_msg, var_5d64a595, str_ender);
        var_ded2b0d1 = v_org - (0, 0, 16);
        while (true) {
            print3d(var_ded2b0d1, "zombie_flogger_trap", (0, 255, 0), 1, n_scale, 1);
            wait(0.1);
        }
    }

    // Namespace namespace_e722cafc
    // Params 3, eflags: 0x1 linked
    // Checksum 0x4710426f, Offset: 0x3970
    // Size: 0x44
    function function_9a889da5(str_msg, var_5d64a595, str_ender) {
        var_5d64a595 waittill(str_ender);
        iprintlnbold(str_msg);
    }

#/

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x39c0
// Size: 0x4
function function_30a8bcac() {
    
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xda8c3352, Offset: 0x39d0
// Size: 0x64
function function_d166ac07() {
    level.var_8ec97b54 = 0;
    var_5e490b83 = getentarray("sndzhd_plates", "targetname");
    array::thread_all(var_5e490b83, &function_4bb6626e);
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x40d12982, Offset: 0x3a40
// Size: 0x134
function function_4bb6626e() {
    while (true) {
        damage, attacker, dir, loc, str_type, model, tag, part, weapon, flags = self waittill(#"damage");
        if (!isplayer(attacker)) {
            continue;
        }
        if (weapon != level.start_weapon) {
            continue;
        }
        if (str_type != "MOD_PISTOL_BULLET") {
            continue;
        }
        level.var_8ec97b54++;
        playsoundatposition("zmb_zhd_plate_hit", self.origin);
        break;
    }
    if (level.var_8ec97b54 >= 4) {
        level flag::set("snd_zhdegg_activate");
    }
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0xed9a0a56, Offset: 0x3b80
// Size: 0x64
function function_a823cd4e() {
    zm_perk_random::include_perk_in_random_rotation("specialty_staminup");
    zm_perk_random::include_perk_in_random_rotation("specialty_deadshot");
    zm_perk_random::include_perk_in_random_rotation("specialty_widowswine");
    level.custom_random_perk_weights = &function_c027d01d;
}

// Namespace namespace_e722cafc
// Params 0, eflags: 0x1 linked
// Checksum 0x5393da01, Offset: 0x3bf0
// Size: 0xa4
function function_c027d01d() {
    temp_array = [];
    temp_array = array::randomize(temp_array);
    level._random_perk_machine_perk_list = array::randomize(level._random_perk_machine_perk_list);
    level._random_perk_machine_perk_list = arraycombine(level._random_perk_machine_perk_list, temp_array, 1, 0);
    keys = getarraykeys(level._random_perk_machine_perk_list);
    return keys;
}

