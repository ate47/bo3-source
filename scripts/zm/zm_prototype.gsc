#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
#using scripts/zm/zm_prototype_zombie;
#using scripts/zm/zm_prototype_ffotd;
#using scripts/zm/zm_prototype_fx;
#using scripts/zm/zm_prototype_barrels;
#using scripts/zm/zm_prototype_amb;
#using scripts/zm/zm_prototype_achievements;
#using scripts/zm/_zm_weap_annihilator;
#using scripts/zm/_zm_weap_thundergun;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_bowie;
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
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/zm_zmhd_cleanup_mgr;
#using scripts/zm/zm_remaster_zombie;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/behavior_zombie_dog;
#using scripts/shared/ai/zombie;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_radio;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_fbe983bd;

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x2
// Checksum 0xc504b49d, Offset: 0xcb0
// Size: 0x4c
function autoexec function_d9af860b() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    clientfield::register("clientuimodel", "player_lives", 1, 2, "int");
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0xfecba81b, Offset: 0xd08
// Size: 0x394
function main() {
    namespace_5150364b::main_start();
    level.default_game_mode = "zclassic";
    level.default_start_location = "default";
    namespace_5b48d6ca::main();
    zm::init_fx();
    level.var_9b27bea6 = 1;
    level._uses_sticky_grenades = 1;
    level.var_f55453ea = &offhand_weapon_overrride;
    level._zmbvoxlevelspecific = &function_30a8bcac;
    namespace_f651e9a8::main();
    level._round_start_func = &zm::round_start;
    level.precachecustomcharacters = &precachecustomcharacters;
    level.givecustomcharacters = &givecustomcharacters;
    initcharacterstartindex();
    level.var_237b30e2 = &function_7837e42a;
    function_a823cd4e();
    spawner::add_archetype_spawn_function("zombie", &function_c86e49f5);
    load::main();
    level.default_laststandpistol = getweapon("pistol_m1911");
    level.default_solo_laststandpistol = getweapon("pistol_m1911_upgraded");
    level.laststandpistol = level.default_laststandpistol;
    level.start_weapon = level.default_laststandpistol;
    level thread zm::function_e7cfa7b8();
    level thread function_e326292f();
    function_f205a5f1();
    namespace_570c8452::init();
    namespace_f492499a::init();
    setdvar("magic_chest_movable", "0");
    level thread function_44c28e00();
    level thread function_54bf648f();
    level.zones = [];
    level.zone_manager_init_func = &function_1e834933;
    init_zones[0] = "start_zone";
    level thread zm_zonemgr::manage_zones(init_zones);
    level.zombie_ai_limit = 24;
    level thread init_sounds();
    level thread setupmusic();
    level thread function_9b3e5ee2();
    level flag::wait_till("start_zombie_round_logic");
    level notify(#"hash_d51af150");
    zm_power::turn_power_on_and_open_doors();
    level.zm_bgb_anywhere_but_here_validation_override = &function_869d6f66;
    level thread zm_perks::spare_change();
    namespace_5150364b::main_end();
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0x81526767, Offset: 0x10a8
// Size: 0x56
function function_f205a5f1() {
    level._effect["perk_machine_light_yellow"] = "dlc5/zmhd/fx_wonder_fizz_light_yellow";
    level._effect["perk_machine_light_red"] = "dlc5/zmhd/fx_wonder_fizz_light_red";
    level._effect["perk_machine_light_green"] = "dlc5/zmhd/fx_wonder_fizz_light_green";
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0xd48d5ad, Offset: 0x1108
// Size: 0x28
function function_869d6f66() {
    if (!isdefined(self zm_bgb_anywhere_but_here::function_728dfe3())) {
        return false;
    }
    return true;
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0x19d32dc7, Offset: 0x1138
// Size: 0xf0
function function_44c28e00() {
    var_c7d6c8d8 = 0;
    while (!var_c7d6c8d8) {
        var_c7d6c8d8 = 1;
        if (isdefined(level.chests)) {
            for (i = 0; i < level.chests.size; i++) {
                var_1f4c3936 = level.chests[i];
                if (isdefined(var_1f4c3936.zbarrier)) {
                    var_5a1d4162 = var_1f4c3936.zbarrier;
                    var_5a1d4162 clientfield::set("magicbox_closed_glow", 0);
                    continue;
                }
                var_c7d6c8d8 = 0;
                break;
            }
        } else {
            var_c7d6c8d8 = 0;
        }
        wait(2);
    }
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x1230
// Size: 0x4
function precachecustomcharacters() {
    
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0x92b11844, Offset: 0x1240
// Size: 0x24
function initcharacterstartindex() {
    level.characterstartindex = randomint(4);
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x0
// Checksum 0x74835fa3, Offset: 0x1270
// Size: 0x3e
function selectcharacterindextouse() {
    if (level.characterstartindex >= 4) {
        level.characterstartindex = 0;
    }
    self.characterindex = level.characterstartindex;
    level.characterstartindex++;
    return self.characterindex;
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0x42ebbfef, Offset: 0x12b8
// Size: 0x2dc
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
        if (getdvarstring("0") != "0") {
            self.characterindex = getdvarint("0");
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
    self setmovespeedscale(1);
    self function_ba25e637(4);
    self function_e67885f8(0);
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0x18453ae0, Offset: 0x15a0
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

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0xfec241e7, Offset: 0x1700
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

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0x11c87a02, Offset: 0x17b0
// Size: 0x24
function init_sounds() {
    zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0x4680ad57, Offset: 0x17e0
// Size: 0x144
function setupmusic() {
    zm_audio::musicstate_create("round_start", 3, "round_start_prototype_1");
    zm_audio::musicstate_create("round_start_short", 3, "round_start_prototype_1");
    zm_audio::musicstate_create("round_start_first", 3, "round_start_prototype_1");
    zm_audio::musicstate_create("round_end", 3, "round_end_prototype_1");
    zm_audio::musicstate_create("undone", 4, "undone");
    zm_audio::musicstate_create("game_over", 5, "game_over_zhd_prototype");
    zm_audio::musicstate_create("none", 4, "none");
    zm_audio::musicstate_create("sam", 4, "sam");
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0x262ab8f2, Offset: 0x1930
// Size: 0xbc
function function_1e834933() {
    level flag::init("always_on");
    level flag::set("always_on");
    zm_zonemgr::add_adjacent_zone("start_zone", "box_zone", "start_2_box");
    zm_zonemgr::add_adjacent_zone("start_zone", "upstairs_zone", "start_2_upstairs");
    zm_zonemgr::add_adjacent_zone("box_zone", "upstairs_zone", "box_2_upstairs");
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0x7cdb6f5, Offset: 0x19f8
// Size: 0x34
function function_54bf648f() {
    level.use_multiple_spawns = 1;
    level.spawner_int = 1;
    level.fn_custom_zombie_spawner_selection = &function_54da140a;
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0x87f61916, Offset: 0x1a38
// Size: 0x204
function function_54da140a() {
    var_6af221a2 = [];
    a_s_spots = array::randomize(level.zm_loc_types["zombie_location"]);
    for (i = 0; i < a_s_spots.size; i++) {
        if (!isdefined(a_s_spots[i].script_int)) {
            var_343b1937 = 1;
        } else {
            var_343b1937 = a_s_spots[i].script_int;
        }
        a_sp_zombies = [];
        foreach (sp_zombie in level.zombie_spawners) {
            if (sp_zombie.script_int == var_343b1937) {
                if (!isdefined(a_sp_zombies)) {
                    a_sp_zombies = [];
                } else if (!isarray(a_sp_zombies)) {
                    a_sp_zombies = array(a_sp_zombies);
                }
                a_sp_zombies[a_sp_zombies.size] = sp_zombie;
            }
        }
        if (a_sp_zombies.size) {
            sp_zombie = array::random(a_sp_zombies);
            return sp_zombie;
        }
    }
    /#
        assert(isdefined(sp_zombie), "0" + var_343b1937);
    #/
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0x30ad6755, Offset: 0x1c48
// Size: 0x24
function function_7837e42a() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_prototype_weapons.csv", 1);
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0x6217aa7d, Offset: 0x1c78
// Size: 0x11c
function function_30a8bcac() {
    level.vox zm_audio::zmbvoxadd("player", "general", "intro", "level_start", undefined);
    level.vox zm_audio::zmbvoxadd("player", "general", "door_deny", "nomoney", undefined);
    level.vox zm_audio::zmbvoxadd("player", "general", "perk_deny", "nomoney", undefined);
    level.vox zm_audio::zmbvoxadd("player", "general", "no_money_weapon", "nomoney", undefined);
    level.vox zm_audio::zmbvoxadd("player", "eggs", "music_activate", "secret", undefined);
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0xe5284620, Offset: 0x1da0
// Size: 0x26a
function function_e326292f() {
    level flag::wait_till("start_zombie_round_logic");
    var_68c121fd = undefined;
    for (i = 0; i < level._spawned_wallbuys.size; i++) {
        str_weapon_name = level._spawned_wallbuys[i].weapon.name;
        if (str_weapon_name == "sniper_fastbolt") {
            var_68c121fd = level._spawned_wallbuys[i];
            break;
        }
    }
    if (isdefined(var_68c121fd)) {
        var_68c121fd.trigger_stub.script_height = 56;
        var_68c121fd.trigger_stub.script_width = 38;
        for (var_4e1a2d78 = 0; !var_4e1a2d78; var_4e1a2d78 = 1) {
            level waittill(#"weapon_bought");
            if (isdefined(var_68c121fd.trigger_stub.first_time_triggered)) {
                if (isdefined(var_68c121fd.trigger_stub.first_time_triggered) && var_68c121fd.trigger_stub.first_time_triggered) {
                }
            }
        }
    }
    var_e453319 = struct::get(var_68c121fd.target, "targetname");
    var_e41aa7b8 = getentarray(var_e453319.target, "targetname");
    foreach (mdl_door in var_e41aa7b8) {
        mdl_door thread function_9cda039e(mdl_door.script_noteworthy);
    }
}

// Namespace namespace_fbe983bd
// Params 1, eflags: 0x1 linked
// Checksum 0xbd8ed772, Offset: 0x2018
// Size: 0x94
function function_9cda039e(var_4ed1d865) {
    if (var_4ed1d865 == "left") {
        self rotateyaw(120, 0.3, 0.2, 0.1);
        return;
    }
    if (var_4ed1d865 == "right") {
        self rotateyaw(-120, 0.3, 0.2, 0.1);
    }
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0x9895cb9, Offset: 0x20b8
// Size: 0xc4
function function_a823cd4e() {
    zm_perk_random::include_perk_in_random_rotation("specialty_armorvest");
    zm_perk_random::include_perk_in_random_rotation("specialty_quickrevive");
    zm_perk_random::include_perk_in_random_rotation("specialty_fastreload");
    zm_perk_random::include_perk_in_random_rotation("specialty_doubletap2");
    zm_perk_random::include_perk_in_random_rotation("specialty_staminup");
    zm_perk_random::include_perk_in_random_rotation("specialty_deadshot");
    zm_perk_random::include_perk_in_random_rotation("specialty_widowswine");
    level.custom_random_perk_weights = &function_c027d01d;
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0xada43bbf, Offset: 0x2188
// Size: 0xa4
function function_c027d01d() {
    temp_array = [];
    temp_array = array::randomize(temp_array);
    level._random_perk_machine_perk_list = array::randomize(level._random_perk_machine_perk_list);
    level._random_perk_machine_perk_list = arraycombine(level._random_perk_machine_perk_list, temp_array, 1, 0);
    keys = getarraykeys(level._random_perk_machine_perk_list);
    return keys;
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0xef810bb6, Offset: 0x2238
// Size: 0xb4
function function_9b3e5ee2() {
    var_9f0c2e1d = 0;
    var_822cff7b = struct::get_array("zhdaudio_button", "targetname");
    array::thread_all(var_822cff7b, &function_ab3e14a3);
    while (true) {
        level waittill(#"hash_672c1b1a");
        var_9f0c2e1d++;
        if (var_9f0c2e1d == var_822cff7b.size) {
            break;
        }
    }
    level flag::set("snd_zhdegg_activate");
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x1 linked
// Checksum 0xf9dd62d5, Offset: 0x22f8
// Size: 0x74
function function_ab3e14a3() {
    self zm_unitrigger::create_unitrigger();
    self waittill(#"trigger_activated");
    playsoundatposition("zmb_sam_egg_button", self.origin);
    level notify(#"hash_672c1b1a");
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x5 linked
// Checksum 0x82c15099, Offset: 0x2378
// Size: 0x1c
function private function_c86e49f5() {
    self.cant_move_cb = &function_e6b1e0be;
}

// Namespace namespace_fbe983bd
// Params 0, eflags: 0x5 linked
// Checksum 0x4bb86ada, Offset: 0x23a0
// Size: 0x2c
function private function_e6b1e0be() {
    self function_1762804b(0);
    self.enablepushtime = gettime() + 1000;
}

