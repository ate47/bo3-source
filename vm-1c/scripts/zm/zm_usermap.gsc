#using scripts/codescripts/struct;
#using scripts/shared/ai/behavior_zombie_dog;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_load;
#using scripts/zm/_zm;
#using scripts/zm/_zm_ai_dogs;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_pack_a_punch_util;
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
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_trap_electric;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_annihilator;
#using scripts/zm/_zm_weap_bouncingbetty;
#using scripts/zm/_zm_weap_bowie;
#using scripts/zm/_zm_weap_cymbal_monkey;
#using scripts/zm/_zm_weap_gravityspikes;
#using scripts/zm/_zm_weap_octobomb;
#using scripts/zm/_zm_weap_raygun_mark3;
#using scripts/zm/_zm_weap_rocketshield;
#using scripts/zm/_zm_weap_tesla;
#using scripts/zm/_zm_weap_thundergun;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_usermap_ai;

#namespace zm_usermap;

// Namespace zm_usermap
// Params 0, eflags: 0x2
// Checksum 0x11cd404c, Offset: 0xdc0
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
// Params 0, eflags: 0x2
// Checksum 0xf1ed1157, Offset: 0xe00
// Size: 0x34
function autoexec init_fx() {
    clientfield::register("clientuimodel", "player_lives", 1, 2, "int");
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0x477e0d42, Offset: 0xe40
// Size: 0x29c
function main() {
    level._uses_default_wallbuy_fx = 1;
    zm::init_fx();
    level util::set_lighting_state(1);
    level._effect["eye_glow"] = "zombie/fx_glow_eye_orange";
    level._effect["headshot"] = "zombie/fx_bul_flesh_head_fatal_zmb";
    level._effect["headshot_nochunks"] = "zombie/fx_bul_flesh_head_nochunks_zmb";
    level._effect["bloodspurt"] = "zombie/fx_bul_flesh_neck_spurt_zmb";
    level._effect["animscript_gib_fx"] = "zombie/fx_blood_torso_explo_zmb";
    level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
    level._effect["switch_sparks"] = "electric/fx_elec_sparks_directional_orange";
    level.default_start_location = "start_room";
    level.default_game_mode = "zclassic";
    level.givecustomloadout = &givecustomloadout;
    level.precachecustomcharacters = &precachecustomcharacters;
    level.givecustomcharacters = &givecustomcharacters;
    level thread setup_personality_character_exerts();
    initcharacterstartindex();
    level.var_f55453ea = &offhand_weapon_overrride;
    level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;
    if (!isdefined(level.var_237b30e2)) {
        level.var_237b30e2 = &function_7837e42a;
    }
    level._allow_melee_weapon_switching = 1;
    level.zombiemode_reusing_pack_a_punch = 1;
    include_weapons();
    load::main();
    if (!isdefined(level.var_b085eada)) {
        level.var_b085eada = 1;
    }
    if (level.var_b085eada) {
        zm_ai_dogs::enable_dog_rounds();
    }
    _zm_weap_cymbal_monkey::init();
    _zm_weap_tesla::init();
    level._round_start_func = &zm::round_start;
    level thread sndfunctions();
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0x64654e7a, Offset: 0x10e8
// Size: 0x44
function function_8d920e88() {
    level flag::init("always_on");
    level flag::set("always_on");
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0xf53f9194, Offset: 0x1138
// Size: 0x8e
function offhand_weapon_overrride() {
    zm_utility::register_lethal_grenade_for_level("frag_grenade");
    level.zombie_lethal_grenade_player_init = getweapon("frag_grenade");
    zm_utility::register_melee_weapon_for_level(level.weaponbasemelee.name);
    level.zombie_melee_weapon_player_init = level.weaponbasemelee;
    zm_utility::register_tactical_grenade_for_level("cymbal_monkey");
    level.zombie_equipment_player_init = undefined;
}

// Namespace zm_usermap
// Params 1, eflags: 0x0
// Checksum 0xa74eef9, Offset: 0x11d0
// Size: 0xbe
function offhand_weapon_give_override(weapon) {
    self endon(#"death");
    if (zm_utility::is_tactical_grenade(weapon) && isdefined(self zm_utility::get_player_tactical_grenade()) && !self zm_utility::is_player_tactical_grenade(weapon)) {
        self setweaponammoclip(self zm_utility::get_player_tactical_grenade(), 0);
        self takeweapon(self zm_utility::get_player_tactical_grenade());
    }
    return false;
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1298
// Size: 0x4
function include_weapons() {
    
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x12a8
// Size: 0x4
function precachecustomcharacters() {
    
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0xe0becb00, Offset: 0x12b8
// Size: 0x24
function initcharacterstartindex() {
    level.characterstartindex = randomint(4);
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0x2fd0c0ac, Offset: 0x12e8
// Size: 0x3e
function selectcharacterindextouse() {
    if (level.characterstartindex >= 4) {
        level.characterstartindex = 0;
    }
    self.characterindex = level.characterstartindex;
    level.characterstartindex++;
    return self.characterindex;
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0x3a4590a9, Offset: 0x1330
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

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0xa882ee77, Offset: 0x1550
// Size: 0x27c
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

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0x49413fbf, Offset: 0x17d8
// Size: 0x54
function set_exert_id() {
    self endon(#"disconnect");
    util::wait_network_frame();
    util::wait_network_frame();
    self zm_audio::setexertvoice(self.characterindex + 1);
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0xf3e98cba, Offset: 0x1838
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

// Namespace zm_usermap
// Params 2, eflags: 0x0
// Checksum 0x9c1c1d7, Offset: 0x2038
// Size: 0x4c
function givecustomloadout(takeallweapons, alreadyspawned) {
    self giveweapon(level.weaponbasemelee);
    self zm_utility::give_start_weapon(1);
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0x69aac353, Offset: 0x2090
// Size: 0x24
function function_7837e42a() {
    zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_levelcommon_weapons.csv", 1);
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0x4f016c31, Offset: 0x20c0
// Size: 0xc6
function perk_init() {
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
// Checksum 0xc01600d8, Offset: 0x2190
// Size: 0x1c
function sndfunctions() {
    level thread setupmusic();
}

// Namespace zm_usermap
// Params 0, eflags: 0x0
// Checksum 0x4548d55b, Offset: 0x21b8
// Size: 0x19c
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
}

