#using scripts/zm/bgbs/_zm_bgb_anywhere_but_here;
#using scripts/zm/zm_asylum_fx;
#using scripts/zm/zm_asylum_ffotd;
#using scripts/zm/zm_asylum_achievements;
#using scripts/zm/_zm_trap_electric;
#using scripts/zm/_zm_weap_annihilator;
#using scripts/zm/_zm_weap_tesla;
#using scripts/zm/_zm_weap_bowie;
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
#using scripts/zm/_zm_perk_deadshot;
#using scripts/zm/_zm_perk_staminup;
#using scripts/zm/_zm_perk_sleight_of_hand;
#using scripts/zm/_zm_perk_quick_revive;
#using scripts/zm/_zm_perk_juggernaut;
#using scripts/zm/_zm_perk_doubletap2;
#using scripts/zm/_zm_perk_additionalprimaryweapon;
#using scripts/zm/_zm_perk_random;
#using scripts/zm/_zm_perk_widows_wine;
#using scripts/zm/zm_asylum_zombie;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/behavior_zombie_dog;
#using scripts/shared/ai/zombie;
#using scripts/zm/zm_zmhd_cleanup_mgr;
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
#using scripts/zm/_zm_audio_zhd;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_load;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_asylum;

// Namespace zm_asylum
// Params 0, eflags: 0x2
// Checksum 0xbbfd8a28, Offset: 0x11f8
// Size: 0x4c
function autoexec function_d9af860b() {
    level.aat_in_use = 1;
    level.bgb_in_use = 1;
    level.zbarrier_override = &function_aeabaa98;
    level.var_e2595ab2 = &function_ee422b5c;
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0xbce1e742, Offset: 0x1250
// Size: 0x49c
function main() {
    zm_asylum_ffotd::main_start();
    setclearanceceiling(17);
    level.var_9b27bea6 = 1;
    level.default_game_mode = "zclassic";
    level.default_start_location = "default";
    zm_asylum_fx::main();
    init_clientfields();
    visionset_mgr::register_info("visionset", "zm_showerhead", 21000, 100, 31, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
    visionset_mgr::register_info("overlay", "zm_showerhead_postfx", 21000, 500, 32, 1);
    visionset_mgr::register_info("overlay", "zm_waterfall_postfx", 21000, 501, 32, 1);
    level._uses_sticky_grenades = 1;
    zm::init_fx();
    level.var_9b04009a = 1;
    level.var_f55453ea = &offhand_weapon_overrride;
    level._zmbvoxlevelspecific = &function_30a8bcac;
    level.customspawnlogic = &function_91b06047;
    level._round_start_func = &zm::round_start;
    level.givecustomcharacters = &givecustomcharacters;
    initcharacterstartindex();
    level.var_237b30e2 = &function_7837e42a;
    level.customrandomweaponweights = &function_659c2324;
    level.var_12d3a848 = 0;
    level.var_9f508948 = &function_9f508948;
    function_a823cd4e();
    level flag::init("intro_finished");
    load::main();
    level.default_laststandpistol = getweapon("pistol_m1911");
    level.default_solo_laststandpistol = getweapon("pistol_m1911_upgraded");
    level.laststandpistol = level.default_laststandpistol;
    level.start_weapon = level.default_laststandpistol;
    level thread zm::function_e7cfa7b8();
    _zm_weap_cymbal_monkey::init();
    _zm_weap_tesla::init();
    level thread function_54bf648f();
    level.zone_manager_init_func = &function_fb9c1c5a;
    init_zones[0] = "west_downstairs_zone";
    init_zones[1] = "west2_downstairs_zone";
    level thread zm_zonemgr::manage_zones(init_zones);
    level.zombie_ai_limit = 24;
    level.burning_zombies = [];
    function_aa84c16a();
    init_sounds();
    level thread setupmusic();
    level thread intro_screen();
    level thread function_9d5484cd();
    level thread function_a67a7819();
    level flag::wait_till("start_zombie_round_logic");
    level thread function_bb75f24a();
    level thread function_2a1ba20e();
    function_a552cd4a();
    level.zm_bgb_anywhere_but_here_validation_override = &function_869d6f66;
    level thread zm_perks::spare_change();
    zm_asylum_ffotd::main_end();
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0xc797ff15, Offset: 0x16f8
// Size: 0xc4
function init_clientfields() {
    clientfield::register("world", "asylum_trap_fx_north", 21000, 1, "int");
    clientfield::register("world", "asylum_trap_fx_south", 21000, 1, "int");
    clientfield::register("world", "asylum_generator_state", 21000, 1, "int");
    clientfield::register("clientuimodel", "player_lives", 21000, 2, "int");
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x4ba1968c, Offset: 0x17c8
// Size: 0x4c
function function_9f508948() {
    self endon(#"disconnect");
    self endon(#"death");
    level flag::wait_till("intro_finished");
    self zm::function_4af767f3();
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x7a94062f, Offset: 0x1820
// Size: 0x28
function function_869d6f66() {
    if (!isdefined(self zm_bgb_anywhere_but_here::function_728dfe3())) {
        return false;
    }
    return true;
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0xfc335ee3, Offset: 0x1850
// Size: 0x9c
function init_sounds() {
    zm_utility::add_sound("break_stone", "break_stone");
    zm_utility::add_sound("zmb_couch_slam", "couch_slam");
    zm_utility::add_sound("door_slide_open", "door_slide_open");
    zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
    level thread custom_add_vox();
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x3961b4b3, Offset: 0x18f8
// Size: 0x144
function setupmusic() {
    zm_audio::musicstate_create("round_start", 3, "round_start_asylum_1");
    zm_audio::musicstate_create("round_start_short", 3, "round_start_asylum_1");
    zm_audio::musicstate_create("round_start_first", 3, "round_start_asylum_1");
    zm_audio::musicstate_create("round_end", 3, "round_end_asylum_1");
    zm_audio::musicstate_create("lullaby_for_a_dead_man", 4, "lullaby_for_a_dead_man");
    zm_audio::musicstate_create("game_over", 5, "game_over_zhd_asylum");
    zm_audio::musicstate_create("none", 4, "none");
    zm_audio::musicstate_create("sam", 4, "sam");
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x5ad987da, Offset: 0x1a48
// Size: 0x24
function initcharacterstartindex() {
    level.characterstartindex = randomint(4);
}

// Namespace zm_asylum
// Params 0, eflags: 0x0
// Checksum 0x7cf18148, Offset: 0x1a78
// Size: 0x3e
function selectcharacterindextouse() {
    if (level.characterstartindex >= 4) {
        level.characterstartindex = 0;
    }
    self.characterindex = level.characterstartindex;
    level.characterstartindex++;
    return self.characterindex;
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x74d702eb, Offset: 0x1ac0
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
        if (getdvarstring("<dev string:x28>") != "<dev string:x33>") {
            self.characterindex = getdvarint("<dev string:x28>");
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

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x71b70fc3, Offset: 0x1da8
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

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x7046bbc1, Offset: 0x1f08
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

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x1f2ab23f, Offset: 0x1fb8
// Size: 0x16c
function function_fb9c1c5a() {
    zm_zonemgr::add_adjacent_zone("west_downstairs_zone", "west2_downstairs_zone", "power_on");
    zm_zonemgr::add_adjacent_zone("west2_downstairs_zone", "north_downstairs_zone", "north_door1");
    zm_zonemgr::add_adjacent_zone("north_downstairs_zone", "north_upstairs_zone", "north_upstairs_blocker");
    zm_zonemgr::add_adjacent_zone("north_upstairs_zone", "north2_upstairs_zone", "upstairs_north_door1");
    zm_zonemgr::add_adjacent_zone("north2_upstairs_zone", "kitchen_upstairs_zone", "upstairs_north_door2");
    zm_zonemgr::add_adjacent_zone("kitchen_upstairs_zone", "power_upstairs_zone", "magic_box_north");
    zm_zonemgr::add_adjacent_zone("west_downstairs_zone", "south_upstairs_zone", "south_upstairs_blocker");
    zm_zonemgr::add_adjacent_zone("south_upstairs_zone", "south2_upstairs_zone", "south_access_1");
    zm_zonemgr::add_adjacent_zone("south2_upstairs_zone", "power_upstairs_zone", "magic_box_south");
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x7a914011, Offset: 0x2130
// Size: 0x34
function function_54bf648f() {
    level.use_multiple_spawns = 1;
    level.spawner_int = 1;
    level.fn_custom_zombie_spawner_selection = &function_54da140a;
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0xcff5d468, Offset: 0x2170
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
    assert(isdefined(sp_zombie), "<dev string:x34>" + var_343b1937);
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x146aa2a4, Offset: 0x2380
// Size: 0x24
function function_7837e42a() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_asylum_weapons.csv", 1);
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x9c0ec3ff, Offset: 0x23b0
// Size: 0x1c
function custom_add_vox() {
    zm_audio::loadplayervoicecategories("gamedata/audio/zm/zm_theater_vox.csv");
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x2b818fc9, Offset: 0x23d8
// Size: 0x42c
function intro_screen() {
    level flag::wait_till("start_zombie_round_logic");
    wait 2;
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
    level.var_944e0877[0] settext(%ZM_ASYLUM_INTRO_ASYLUM_LEVEL_BERLIN);
    level.var_944e0877[1] settext(%ZM_ASYLUM_INTRO_ASYLUM_LEVEL_HIMMLER);
    level.var_944e0877[2] settext(%ZM_ASYLUM_INTRO_ASYLUM_LEVEL_SEPTEMBER);
    for (i = 0; i < 3; i++) {
        level.var_944e0877[i] fadeovertime(1.5);
        level.var_944e0877[i].alpha = 1;
        wait 1.5;
    }
    wait 1.5;
    for (i = 0; i < 3; i++) {
        level.var_944e0877[i] fadeovertime(1.5);
        level.var_944e0877[i].alpha = 0;
        wait 1.5;
    }
    for (i = 0; i < 3; i++) {
        level.var_944e0877[i] destroy();
    }
    level flag::set("intro_finished");
    level thread function_96995b13();
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0xf6505950, Offset: 0x2810
// Size: 0xac
function function_aa84c16a() {
    level flag::init("electric_switch_used");
    level flag::set("spawn_point_override");
    level thread init_lights();
    var_b3ac70ca = getentarray("waterfall", "targetname");
    array::thread_all(var_b3ac70ca, &function_12d958d0);
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x7d26dabf, Offset: 0x28c8
// Size: 0xde
function function_9d5484cd() {
    wait 2;
    var_6dc01919 = getent("dentist_chair", "targetname");
    if (isdefined(var_6dc01919)) {
        var_6dc01919 setcursorhint("HINT_NOICON");
        var_6dc01919 usetriggerrequirelookat();
        players = getplayers();
        while (true) {
            players = var_6dc01919 waittill(#"trigger");
            playsoundatposition("evt_chair", var_6dc01919.origin);
            wait 3;
        }
    }
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x7ac9fe6b, Offset: 0x29b0
// Size: 0x17c
function function_a67a7819() {
    var_769dd606 = struct::get("snd_flusher", "targetname");
    if (!isdefined(var_769dd606)) {
        return;
    }
    var_769dd606 zm_unitrigger::create_unitrigger(undefined, undefined, &function_f8772aa4);
    var_7d2efc67 = 0;
    while (var_7d2efc67 < 3) {
        var_769dd606 waittill(#"trigger_activated");
        if (isdefined(level.musicsystemoverride) && (isdefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4 || level.musicsystemoverride)) {
            continue;
        }
        var_7d2efc67++;
        playsoundatposition("evt_toilet_flush", var_769dd606.origin);
        wait 3.8;
    }
    zm_unitrigger::unregister_unitrigger(var_769dd606.s_unitrigger);
    playsoundatposition("zmb_cha_ching", var_769dd606.origin);
    level thread zm_audio::sndmusicsystem_playstate("lullaby_for_a_dead_man");
}

// Namespace zm_asylum
// Params 1, eflags: 0x1 linked
// Checksum 0x5d5dc03f, Offset: 0x2b38
// Size: 0x38
function function_f8772aa4(player) {
    if (!isdefined(level.var_a3dcfd4f)) {
        return true;
    }
    if (level.var_a3dcfd4f >= 2) {
        return false;
    }
    return true;
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x2b3c29f5, Offset: 0x2b78
// Size: 0x29e
function init_lights() {
    var_9966188 = [];
    arms = [];
    ents = getentarray("elect_light_model", "targetname");
    for (i = 0; i < ents.size; i++) {
        if (issubstr(ents[i].model, "tinhat")) {
            var_9966188[var_9966188.size] = ents[i];
        }
        if (issubstr(ents[i].model, "indlight")) {
            arms[arms.size] = ents[i];
        }
    }
    for (i = 0; i < var_9966188.size; i++) {
        util::wait_network_frame();
        var_9966188[i] setmodel("lights_tinhatlamp_off");
    }
    for (i = 0; i < arms.size; i++) {
        util::wait_network_frame();
        arms[i] setmodel("lights_indlight");
    }
    level flag::wait_till("electric_switch_used");
    for (i = 0; i < var_9966188.size; i++) {
        util::wait_network_frame();
        var_9966188[i] setmodel("lights_tinhatlamp_on");
    }
    for (i = 0; i < arms.size; i++) {
        util::wait_network_frame();
        arms[i] setmodel("lights_indlight_on");
    }
}

// Namespace zm_asylum
// Params 1, eflags: 0x1 linked
// Checksum 0x957076a6, Offset: 0x2e20
// Size: 0xb8
function function_91b06047(predictedspawn) {
    if (!isdefined(level.var_df35cb81)) {
        level.var_df35cb81 = function_da4025bc();
    }
    assert(isdefined(level.var_df35cb81), "<dev string:x5e>");
    spawnpoint = function_290134d5(level.var_df35cb81, self);
    self spawn(spawnpoint.origin, spawnpoint.angles, "zsurvival");
    return spawnpoint;
}

// Namespace zm_asylum
// Params 2, eflags: 0x1 linked
// Checksum 0x8261bc38, Offset: 0x2ee0
// Size: 0x12a
function function_290134d5(spawnpoints, player) {
    if (!isdefined(self.playernum)) {
        if (self.team == "allies") {
            self.playernum = zm_utility::function_ecf6d352("_team1_num");
            zm_utility::function_669b4ee("_team1_num", self.playernum + 1);
        } else {
            self.playernum = zm_utility::function_ecf6d352("_team2_num");
            zm_utility::function_669b4ee("_team2_num", self.playernum + 1);
        }
    }
    for (j = 0; j < spawnpoints.size; j++) {
        if (spawnpoints[j].en_num == self.playernum) {
            return spawnpoints[j];
        }
    }
    return spawnpoints[0];
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0xa845a7a5, Offset: 0x3018
// Size: 0x24e
function function_da4025bc() {
    var_7eacef00 = [];
    var_95bba386 = [];
    var_769a9621 = struct::get_array("north_spawn", "script_noteworthy");
    var_e1217443 = struct::get_array("south_spawn", "script_noteworthy");
    for (i = 0; i < 2; i++) {
        if (!isdefined(var_7eacef00)) {
            var_7eacef00 = [];
        } else if (!isarray(var_7eacef00)) {
            var_7eacef00 = array(var_7eacef00);
        }
        var_7eacef00[var_7eacef00.size] = var_769a9621[i];
    }
    for (j = 0; j < 2; j++) {
        if (!isdefined(var_95bba386)) {
            var_95bba386 = [];
        } else if (!isarray(var_95bba386)) {
            var_95bba386 = array(var_95bba386);
        }
        var_95bba386[var_95bba386.size] = var_e1217443[j];
    }
    var_5781ea4d = var_7eacef00;
    var_7d8464b6 = var_95bba386;
    if (randomint(100) > 50) {
        var_5781ea4d = var_95bba386;
        var_7d8464b6 = var_7eacef00;
    }
    spawnpoints = arraycombine(var_5781ea4d, var_7d8464b6, 0, 0);
    for (i = 0; i < spawnpoints.size; i++) {
        spawnpoints[i].en_num = i;
    }
    return spawnpoints;
}

// Namespace zm_asylum
// Params 1, eflags: 0x1 linked
// Checksum 0xdb21ed77, Offset: 0x3270
// Size: 0xba
function function_448abce3(triggername) {
    triggers = getentarray("audio_bump_trigger", "targetname");
    if (isdefined(triggers)) {
        for (i = 0; i < triggers.size; i++) {
            if (isdefined(triggers[i].script_label) && triggers[i].script_label == triggername) {
                triggers[i].script_activated = 0;
            }
        }
    }
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x39712ec, Offset: 0x3338
// Size: 0x4c4
function function_2a1ba20e() {
    trig = getent("use_master_switch", "targetname");
    var_cf413835 = struct::get("power_switch", "targetname");
    trig sethintstring(%ZOMBIE_ELECTRIC_SWITCH);
    trig setcursorhint("HINT_NOICON");
    fx_org = spawn("script_model", (-674.922, -300.473, 284.125));
    fx_org setmodel("tag_origin");
    fx_org.angles = (0, 90, 0);
    cheat = 0;
    /#
        if (getdvarint("<dev string:x83>") >= 3) {
            wait 5;
            cheat = 1;
        }
    #/
    level clientfield::set("asylum_generator_state", 1);
    if (cheat != 1) {
        user = trig waittill(#"trigger");
    }
    playsoundatposition("zmb_switch_flip", var_cf413835.origin);
    zm_power::turn_power_on_and_open_doors();
    level notify(#"switch_flipped");
    function_448abce3("switch_door_trig");
    level thread function_463cb1c6();
    util::setclientsysstate("levelNotify", "start_lights");
    level flag::set("electric_switch_used");
    trig delete();
    traps = getentarray("gas_access", "targetname");
    for (i = 0; i < traps.size; i++) {
        traps[i] sethintstring(%ZOMBIE_ELECTRIC_SWITCH);
        traps[i] setcursorhint("HINT_NOICON");
        traps[i].is_available = 1;
    }
    var_cf413835 scene::play("p7_fxanim_zmhd_power_switch_bundle");
    playfx(level._effect["switch_sparks"], struct::get("switch_fx", "targetname").origin);
    level notify(#"hash_e60e72d2");
    fx_org delete();
    fx_org = spawn("script_model", (-675.021, -300.906, 283.724));
    fx_org setmodel("tag_origin");
    fx_org.angles = (0, 90, 0);
    wait 6;
    fx_org stoploopsound();
    level notify(#"hash_2680d19f");
    util::wait_network_frame();
    level notify(#"revive_on");
    util::wait_network_frame();
    level notify(#"doubletap_on");
    util::wait_network_frame();
    level notify(#"hash_ce46a7cd");
    exploder::exploder("lgt_exploder_power_on");
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x5398772, Offset: 0x3808
// Size: 0x1ec
function function_463cb1c6() {
    power_on = getent("audio_swtch_left", "targetname");
    var_5c141942 = struct::get("evt_circuit_1", "targetname");
    var_36119ed9 = struct::get("evt_circuit_2", "targetname");
    var_100f2470 = struct::get("evt_circuit_3", "targetname");
    wait 0.75;
    if (isdefined(var_5c141942)) {
        playsoundatposition("evt_circuit_1", var_5c141942.origin);
    }
    wait 1.5;
    if (isdefined(var_36119ed9)) {
        playsoundatposition("evt_circuit_2", var_36119ed9.origin);
    }
    wait 1.5;
    if (isdefined(var_100f2470)) {
        playsoundatposition("evt_circuit_3", var_100f2470.origin);
    }
    wait 0.25;
    power_on playsound("evt_power_on");
    wait 5.5;
    power_on playloopsound("evt_power_loop");
    level thread function_9f38170();
    wait 1;
    level thread function_db428301();
}

// Namespace zm_asylum
// Params 1, eflags: 0x0
// Checksum 0x40523bc9, Offset: 0x3a00
// Size: 0x238
function function_2aa1a67b(side) {
    self endon(#"hash_79ccb5cd");
    while (true) {
        sparks = struct::get("trap_wire_sparks_" + side, "targetname");
        self.fx_org = util::spawn_model("tag_origin", sparks.origin, sparks.angles);
        playfxontag(level._effect["electric_current"], self.fx_org, "tag_origin");
        for (targ = struct::get(sparks.target, "targetname"); isdefined(targ); targ = undefined) {
            self.fx_org moveto(targ.origin, 0.15);
            self.fx_org playloopsound("zmb_elec_current_loop", 0.1);
            self.fx_org waittill(#"movedone");
            self.fx_org stoploopsound(0.1);
            if (isdefined(targ.target)) {
                targ = struct::get(targ.target, "targetname");
                continue;
            }
        }
        playfxontag(level._effect["electric_short_oneshot"], self.fx_org, "tag_origin");
        wait randomintrange(3, 9);
        self.fx_org delete();
    }
}

// Namespace zm_asylum
// Params 0, eflags: 0x0
// Checksum 0x57cb27b1, Offset: 0x3c40
// Size: 0x294
function function_bd8215be() {
    sparks = struct::get("electric_middle_door", "targetname");
    fx_org = util::spawn_model("script_model", sparks.origin, sparks.angles);
    playfxontag(level._effect["electric_current"], fx_org, "tag_origin");
    for (targ = struct::get(sparks.target, "targetname"); isdefined(targ); targ = undefined) {
        fx_org moveto(targ.origin, 0.075);
        if (targ.script_noteworthy == "junction_boxs" || isdefined(targ.script_noteworthy) && targ.script_noteworthy == "electric_end") {
            playfxontag(level._effect["electric_short_oneshot"], fx_org, "tag_origin");
        }
        fx_org playloopsound("zmb_elec_current_loop", 0.1);
        fx_org waittill(#"movedone");
        fx_org stoploopsound(0.1);
        if (isdefined(targ.target)) {
            targ = struct::get(targ.target, "targetname");
            continue;
        }
    }
    level notify(#"hash_8729910f");
    playfxontag(level._effect["electric_short_oneshot"], fx_org, "tag_origin");
    wait randomintrange(3, 9);
    fx_org delete();
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x4e206efa, Offset: 0x3ee0
// Size: 0x80
function function_9f38170() {
    level thread function_9a0695b3();
    while (true) {
        wait randomintrange(15, 20);
        playsoundatposition("evt_the_numbers", (-758, -310, 125));
        wait randomintrange(15, 20);
    }
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x9fb08932, Offset: 0x3f68
// Size: 0x50
function function_9a0695b3() {
    while (true) {
        wait randomintrange(3, 8);
        playsoundatposition("zmb_elec_room_sweets", (-758, -310, 125));
    }
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0xb1344714, Offset: 0x3fc0
// Size: 0xfc
function function_96995b13() {
    level.open_chest_location = [];
    level.open_chest_location[0] = undefined;
    level.open_chest_location[1] = undefined;
    level.open_chest_location[2] = undefined;
    level.open_chest_location[3] = "opened_chest";
    level.open_chest_location[4] = "start_chest";
    level thread function_690bec51("magic_box_south");
    level thread function_690bec51("south_access_1");
    level thread function_690bec51("north_door1");
    level thread function_690bec51("north_upstairs_blocker");
    level thread function_690bec51("south_upstairs_blocker");
}

// Namespace zm_asylum
// Params 1, eflags: 0x1 linked
// Checksum 0xc2aaea90, Offset: 0x40c8
// Size: 0x176
function function_690bec51(which) {
    wait 3;
    switch (which) {
    case "magic_box_south":
        level flag::wait_till("magic_box_south");
        level.open_chest_location[0] = "magic_box_south";
        break;
    case "south_access_1":
        level flag::wait_till("south_access_1");
        level.open_chest_location[0] = "magic_box_south";
        level.open_chest_location[1] = "magic_box_bathroom";
        break;
    case "north_door1":
        level flag::wait_till("north_door1");
        level.open_chest_location[2] = "magic_box_hallway";
        break;
    case "north_upstairs_blocker":
        level flag::wait_till("north_upstairs_blocker");
        level.open_chest_location[2] = "magic_box_hallway";
        break;
    case "south_upstairs_blocker":
        level flag::wait_till("south_upstairs_blocker");
        level.open_chest_location[1] = "magic_box_bathroom";
        break;
    default:
        return;
    }
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x64271cf7, Offset: 0x4248
// Size: 0x106
function function_12d958d0() {
    while (true) {
        who = self waittill(#"trigger");
        if (isdefined(who) && isplayer(who) && isalive(who) && who.sessionstate != "spectator") {
            if (!who laststand::player_is_in_laststand()) {
                if (isdefined(who.var_1e4200d5)) {
                    if (!who.var_1e4200d5) {
                        who thread function_4c24944a(self);
                    }
                } else {
                    who.var_1e4200d5 = 1;
                    who thread function_4c24944a(self);
                }
            }
        }
        wait 1;
    }
}

// Namespace zm_asylum
// Params 1, eflags: 0x1 linked
// Checksum 0xf3303c02, Offset: 0x4358
// Size: 0x1d0
function function_4c24944a(var_c80d3f8f) {
    self.var_1e4200d5 = 1;
    if (isdefined(var_c80d3f8f.script_int) && var_c80d3f8f.script_int) {
        visionset_mgr::activate("visionset", "zm_showerhead", self, 0.5, 2, 0.5);
        visionset_mgr::activate("overlay", "zm_showerhead_postfx", self, 0.5, 2, 0.5);
    } else {
        visionset_mgr::activate("overlay", "zm_waterfall_postfx", self, 0.5, 2, 0.5);
    }
    wait 1;
    if (self istouching(var_c80d3f8f)) {
        self thread function_4c24944a(var_c80d3f8f);
        return;
    }
    if (isdefined(var_c80d3f8f.script_int) && var_c80d3f8f.script_int) {
        visionset_mgr::deactivate("visionset", "zm_showerhead", self);
        visionset_mgr::deactivate("overlay", "zm_showerhead_postfx", self);
    } else {
        visionset_mgr::deactivate("overlay", "zm_waterfall_postfx", self);
    }
    self.var_1e4200d5 = 0;
}

// Namespace zm_asylum
// Params 0, eflags: 0x0
// Checksum 0x3fc7bb0f, Offset: 0x4530
// Size: 0x28
function function_17319630() {
    level.var_a89f567b["level"]["power"] = "power";
}

// Namespace zm_asylum
// Params 0, eflags: 0x0
// Checksum 0x3e29d03a, Offset: 0x4560
// Size: 0x12a
function exit_level_func() {
    zombies = getaiarray();
    foreach (zombie in zombies) {
        if (isdefined(zombie.ignore_solo_last_stand) && zombie.ignore_solo_last_stand) {
            continue;
        }
        if (isdefined(zombie.find_exit_point)) {
            zombie thread [[ zombie.find_exit_point ]]();
            continue;
        }
        if (zombie.ignoreme) {
            zombie thread zm::default_delayed_exit();
            continue;
        }
        zombie thread zm::default_find_exit_point();
    }
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0xfef23131, Offset: 0x4698
// Size: 0xbc
function function_db428301() {
    level clientfield::set("asylum_generator_state", 0);
    var_e74af5ed = struct::get("loudspeaker", "targetname");
    playsoundatposition("amb_alarm", var_e74af5ed.origin);
    level thread function_fe9cfc9e();
    wait 8;
    playsoundatposition("amb_pa_system", var_e74af5ed.origin);
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x498869ca, Offset: 0x4760
// Size: 0x6c
function function_fe9cfc9e() {
    computer = getent("comp", "targetname");
    computer playsound("amb_comp_start");
    wait 6;
    computer playloopsound("amb_comp_loop");
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0xfda7a9b8, Offset: 0x47d8
// Size: 0xe4
function function_30a8bcac() {
    level.vox zm_audio::zmbvoxadd("player", "general", "intro", "level_start", undefined);
    level.vox zm_audio::zmbvoxadd("player", "general", "door_deny", "nomoney", undefined);
    level.vox zm_audio::zmbvoxadd("player", "general", "perk_deny", "nomoney", undefined);
    level.vox zm_audio::zmbvoxadd("player", "general", "no_money_weapon", "nomoney", undefined);
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x547c0750, Offset: 0x48c8
// Size: 0xea
function function_a552cd4a() {
    perk_machines = getentarray("zombie_vending", "targetname");
    foreach (perk_machine in perk_machines) {
        if (isdefined(perk_machine.clip) && perk_machine.script_noteworthy == "specialty_additionalprimaryweapon") {
            perk_machine.clip delete();
        }
    }
}

// Namespace zm_asylum
// Params 1, eflags: 0x1 linked
// Checksum 0x69891438, Offset: 0x49c0
// Size: 0x1ee
function function_aeabaa98(zbarrier) {
    self.zbarrier = zbarrier;
    var_cfdb3b07 = isdefined(self.zbarrier.script_string) ? self.zbarrier.script_string : "p6_anim_zm_barricade_board_collision";
    if (var_cfdb3b07 == "p6_anim_zm_barricade_board_collision") {
        self.zbarrier setzbarriercolmodel(var_cfdb3b07);
    }
    self.zbarrier.chunk_health = [];
    for (i = 0; i < self.zbarrier getnumzbarrierpieces(); i++) {
        self.zbarrier.chunk_health[i] = 0;
    }
    if (isdefined(self.zbarrier.target)) {
        self.zbarrier.dynents = getentarray(self.zbarrier.target, "targetname");
        for (i = 0; i < self.zbarrier.dynents.size; i++) {
            self.zbarrier hidezbarrierpiece(self.zbarrier.dynents[i].script_int);
            self.zbarrier.dynents[i] thread function_ee8a2035(self.zbarrier.dynents[i].script_int, self.zbarrier);
        }
    }
}

// Namespace zm_asylum
// Params 2, eflags: 0x1 linked
// Checksum 0xfe0f4d9c, Offset: 0x4bb8
// Size: 0x144
function function_ee8a2035(piece_index, zbarrier) {
    self endon(#"damage");
    for (var_31410ef7 = "closed"; var_31410ef7 != "open" && var_31410ef7 != "opening"; var_31410ef7 = zbarrier getzbarrierpiecestate(piece_index)) {
        wait 0.05;
    }
    self notify(#"hash_e5c33d19");
    e_piece = zbarrier.dynents[piece_index];
    if (isdefined(e_piece)) {
        self ghost();
        zm_utility::play_sound_at_pos("break_barrier_piece", self.origin);
        wait randomfloatrange(0.3, 0.6);
        zm_utility::play_sound_at_pos("break_barrier_piece", self.origin);
    }
    self delete();
}

// Namespace zm_asylum
// Params 1, eflags: 0x1 linked
// Checksum 0x3973cbb7, Offset: 0x4d08
// Size: 0x12c
function function_ee422b5c(chunk) {
    if (isdefined(self.first_node.zbarrier.dynents) && isdefined(self.first_node.zbarrier.dynents[chunk])) {
        if (isdefined(self.first_node.zbarrier.dynents[chunk].script_noteworthy)) {
            var_6a0dedc2 = self.first_node.zbarrier.dynents[chunk].script_noteworthy;
            self.first_node.zbarrier.var_48c7593a = 1;
        } else {
            assertmsg("<dev string:x90>" + chunk + "<dev string:xa7>");
        }
    } else {
        var_6a0dedc2 = self.first_node.zbarrier getzbarrierpieceanimstate(chunk);
    }
    return var_6a0dedc2;
}

// Namespace zm_asylum
// Params 1, eflags: 0x1 linked
// Checksum 0x88056698, Offset: 0x4e40
// Size: 0x16c
function function_659c2324(a_keys) {
    if (a_keys[0] === level.var_168d703f) {
        level.var_12d3a848 = 0;
        return a_keys;
    }
    n_chance = 0;
    if (zm_weapons::limited_weapon_below_quota(level.var_168d703f)) {
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
    if (randomint(100) <= n_chance && zm_magicbox::function_9821da97(self, level.var_168d703f) && !self hasweapon(level.var_d22a87eb)) {
        arrayinsert(a_keys, level.var_168d703f, 0);
        level.var_12d3a848 = 0;
    }
    return a_keys;
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x8414e85c, Offset: 0x4fb8
// Size: 0x13a
function function_bb75f24a() {
    level.var_a3dcfd4f = 0;
    var_f0a0f84f = struct::get_array("s_toilet_zhd", "targetname");
    array::thread_all(var_f0a0f84f, &function_db379af2);
    level thread function_fa408417();
    level waittill(#"hash_137fb152");
    level.var_a3dcfd4f = undefined;
    level flag::set("snd_zhdegg_activate");
    foreach (struct in var_f0a0f84f) {
        zm_unitrigger::unregister_unitrigger(struct.s_unitrigger);
    }
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x4ded5f24, Offset: 0x5100
// Size: 0x19a
function function_db379af2() {
    level endon(#"hash_137fb152");
    self.var_46907f23 = 0;
    self.activated = 0;
    if (isdefined(self.script_noteworthy) && self.script_noteworthy == "toilet3") {
        self zm_unitrigger::create_unitrigger(undefined, undefined, &function_dffe609d);
    } else {
        self zm_unitrigger::create_unitrigger();
    }
    while (true) {
        self waittill(#"trigger_activated");
        self.var_46907f23++;
        if (self.var_46907f23 > 9) {
            playsoundatposition("zmb_zhd_toilet_flusheroo", self.origin);
            self.var_46907f23 = 0;
        } else {
            playsoundatposition("zmb_zhd_toilet_hit", self.origin);
        }
        if (self.var_46907f23 == self.script_int) {
            self.activated = 1;
            level.var_a3dcfd4f++;
            level notify(#"hash_b280e2e");
        } else if (isdefined(self.activated) && self.activated) {
            self.activated = 0;
            level.var_a3dcfd4f--;
            level notify(#"hash_b280e2e");
        }
        if (level.var_a3dcfd4f >= 3) {
            level notify(#"hash_137fb152");
        }
    }
}

// Namespace zm_asylum
// Params 1, eflags: 0x1 linked
// Checksum 0xb98c4ce4, Offset: 0x52a8
// Size: 0x38
function function_dffe609d(player) {
    if (!isdefined(level.var_a3dcfd4f)) {
        return true;
    }
    if (level.var_a3dcfd4f < 2) {
        return false;
    }
    return true;
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x9994fc83, Offset: 0x52e8
// Size: 0x19e
function function_fa408417() {
    level endon(#"hash_137fb152");
    var_f0a0f84f = struct::get_array("s_toilet_zhd", "targetname");
    while (true) {
        level waittill(#"hash_b280e2e");
        foreach (struct in var_f0a0f84f) {
            if (isdefined(struct.script_noteworthy) && struct.script_noteworthy == "toilet3") {
                if (struct.var_46907f23 > 0 && level.var_a3dcfd4f <= 1) {
                    struct.var_46907f23 = 0;
                    playsoundatposition("zmb_zhd_toilet_flusheroo", struct.origin);
                }
                if (isdefined(struct.activated) && struct.activated && level.var_a3dcfd4f <= 2) {
                    struct.activated = 0;
                    level.var_a3dcfd4f--;
                }
            }
        }
    }
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0xd92760de, Offset: 0x5490
// Size: 0x64
function function_a823cd4e() {
    zm_perk_random::include_perk_in_random_rotation("specialty_staminup");
    zm_perk_random::include_perk_in_random_rotation("specialty_deadshot");
    zm_perk_random::include_perk_in_random_rotation("specialty_widowswine");
    level.custom_random_perk_weights = &function_c027d01d;
}

// Namespace zm_asylum
// Params 0, eflags: 0x1 linked
// Checksum 0x5c318ae1, Offset: 0x5500
// Size: 0xa4
function function_c027d01d() {
    temp_array = [];
    temp_array = array::randomize(temp_array);
    level._random_perk_machine_perk_list = array::randomize(level._random_perk_machine_perk_list);
    level._random_perk_machine_perk_list = arraycombine(level._random_perk_machine_perk_list, temp_array, 1, 0);
    keys = getarraykeys(level._random_perk_machine_perk_list);
    return keys;
}

