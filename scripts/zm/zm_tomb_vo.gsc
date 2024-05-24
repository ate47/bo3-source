#using scripts/zm/gametypes/_globallogic_score;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_ad52727b;

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xc9c53379, Offset: 0x2be0
// Size: 0x1c4
function init_flags() {
    level flag::init("story_vo_playing");
    level flag::init("round_one_narrative_vo_complete");
    level flag::init("maxis_audiolog_gr0_playing");
    level flag::init("maxis_audiolog_gr1_playing");
    level flag::init("maxis_audiolog_gr2_playing");
    level flag::init("maxis_audio_log_1");
    level flag::init("maxis_audio_log_2");
    level flag::init("maxis_audio_log_3");
    level flag::init("maxis_audio_log_4");
    level flag::init("maxis_audio_log_5");
    level flag::init("maxis_audio_log_6");
    level flag::init("generator_find_vo_playing");
    level flag::init("samantha_intro_done");
    level flag::init("maxis_crafted_intro_done");
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x1255e567, Offset: 0x2db0
// Size: 0x1f0c
function function_30a8bcac() {
    level.var_f5232adf = 0;
    level.var_f084310a = 1;
    setdvar("zombie_kills", "5");
    setdvar("zombie_kill_timer", "6");
    if (zm_utility::is_classic()) {
        level.var_952917ef = &function_e22c53bd;
        level.var_cdd49d24 = &function_6f253956;
        level.custom_kill_damaged_vo = &zm_audio::custom_kill_damaged_vo;
        level._custom_zombie_oh_shit_vox_func = &function_412f65cd;
        level.gib_on_damage = &function_1ffaef19;
        level._audio_custom_weapon_check = &function_de88384;
        level.var_ee31d7a5 = &function_658b5c43;
        level thread function_9e7d0342();
        level thread function_a17dbe3b();
        level thread function_8f3fa6c2();
        level.var_80c12a61 = &function_abd59be1;
        level thread function_84407d1();
        level thread function_7480ce48();
        level thread function_ee50b901();
    }
    level thread zm_audio::sndannouncervoxadd("zombie_blood", "powerup_zombie_blood_0");
    level thread zm_audio::sndannouncervoxadd("bonus_points_player", "powerup_blood_money_0");
    level.var_28d3a005 = 1;
    function_acd5af2a("player", "general", "oh_shit", "oh_shit", 1, 100);
    function_acd5af2a("player", "general", "no_money_weapon", "nomoney_generic", undefined);
    function_acd5af2a("player", "general", "no_money_box", "nomoney_generic", undefined);
    function_acd5af2a("player", "general", "perk_deny", "nomoney_generic", undefined);
    function_acd5af2a("player", "general", "no_money_capture", "nomoney_generic", undefined);
    function_acd5af2a("player", "perk", "specialty_armorvest", "perk_jugga", undefined);
    function_acd5af2a("player", "perk", "specialty_quickrevive", "perk_revive", undefined);
    function_acd5af2a("player", "perk", "specialty_fastreload", "perk_speed", undefined);
    function_acd5af2a("player", "perk", "specialty_longersprint", "perk_stamine", undefined);
    function_acd5af2a("player", "perk", "specialty_additionalprimaryweapon", "perk_mule", undefined);
    function_acd5af2a("player", "kill", "closekill", "kill_close", undefined, 15);
    function_acd5af2a("player", "kill", "damage", "kill_damaged", undefined, 50);
    function_acd5af2a("player", "kill", "headshot", "kill_headshot", 1, 25);
    function_acd5af2a("player", "kill", "one_inch_punch", "kill_one_inch", undefined, 15);
    function_acd5af2a("player", "kill", "ice_staff", "kill_ice", undefined, 15);
    function_acd5af2a("player", "kill", "ice_staff_upgrade", "kill_ice_upgrade", undefined, 15);
    function_acd5af2a("player", "kill", "fire_staff", "kill_fire", undefined, 15);
    function_acd5af2a("player", "kill", "fire_staff_upgrade", "kill_fire_upgrade", undefined, 15);
    function_acd5af2a("player", "kill", "light_staff", "kill_light", undefined, 15);
    function_acd5af2a("player", "kill", "light_staff_upgrade", "kill_light_upgrade", undefined, 15);
    function_acd5af2a("player", "kill", "wind_staff", "kill_wind", undefined, 15);
    function_acd5af2a("player", "kill", "wind_staff_upgrade", "kill_wind_upgrade", undefined, 15);
    function_acd5af2a("player", "kill", "headshot_respond_to_plr_0_neg", "head_rspnd_to_plr_0_neg", undefined, 100);
    function_acd5af2a("player", "kill", "headshot_respond_to_plr_0_pos", "head_rspnd_to_plr_0_pos", undefined, 100);
    function_acd5af2a("player", "kill", "headshot_respond_to_plr_1_neg", "head_rspnd_to_plr_1_neg", undefined, 100);
    function_acd5af2a("player", "kill", "headshot_respond_to_plr_1_pos", "head_rspnd_to_plr_1_pos", undefined, 100);
    function_acd5af2a("player", "kill", "headshot_respond_to_plr_2_neg", "head_rspnd_to_plr_2_neg", undefined, 100);
    function_acd5af2a("player", "kill", "headshot_respond_to_plr_2_pos", "head_rspnd_to_plr_2_pos", undefined, 100);
    function_acd5af2a("player", "kill", "headshot_respond_to_plr_3_neg", "head_rspnd_to_plr_3_neg", undefined, 100);
    function_acd5af2a("player", "kill", "headshot_respond_to_plr_3_pos", "head_rspnd_to_plr_3_pos", undefined, 100);
    function_acd5af2a("player", "powerup", "zombie_blood", "powerup_zombie_blood", undefined, 100);
    function_acd5af2a("player", "general", "revive_up", "revive_player", 1, 100);
    function_acd5af2a("player", "general", "heal_revived_pos", "heal_revived_pos", undefined, 100);
    function_acd5af2a("player", "general", "heal_revived_neg", "heal_revived_neg", undefined, 100);
    function_acd5af2a("player", "general", "exert_sigh", "exert_sigh", undefined, 100);
    function_acd5af2a("player", "general", "exert_laugh", "exert_laugh", undefined, 100);
    function_acd5af2a("player", "general", "pain_high", "pain_high", undefined, 100);
    function_acd5af2a("player", "general", "build_dd_pickup", "build_dd_pickup", undefined, 100);
    function_acd5af2a("player", "general", "build_dd_brain_pickup", "pickup_brain", undefined, 100);
    function_acd5af2a("player", "general", "build_dd_final", "build_dd_final", undefined, 100);
    function_acd5af2a("player", "general", "build_dd_plc", "build_dd_take", undefined, 100);
    function_acd5af2a("player", "general", "build_zs_pickup", "build_zs_pickup", undefined, 100);
    function_acd5af2a("player", "general", "build_zs_final", "build_zs_final", undefined, 100);
    function_acd5af2a("player", "general", "build_zs_plc", "build_zs_take", undefined, 100);
    function_acd5af2a("player", "general", "record_pickup", "pickup_record", undefined, 100);
    function_acd5af2a("player", "general", "gramophone_pickup", "pickup_gramophone", undefined, 100);
    function_acd5af2a("player", "general", "place_gramophone", "place_gramophone", undefined, 100);
    function_acd5af2a("player", "general", "staff_part_pickup", "pickup_staff_part", undefined, 100);
    function_acd5af2a("player", "general", "crystal_pickup", "pickup_crystal", undefined, 100);
    function_acd5af2a("player", "general", "pickup_fire", "pickup_fire", undefined, 100);
    function_acd5af2a("player", "general", "pickup_ice", "pickup_ice", undefined, 100);
    function_acd5af2a("player", "general", "pickup_light", "pickup_light", undefined, 100);
    function_acd5af2a("player", "general", "pickup_wind", "pickup_wind", undefined, 100);
    function_acd5af2a("player", "puzzle", "try_puzzle", "activate_generic", undefined);
    function_acd5af2a("player", "puzzle", "puzzle_confused", "confusion_generic", undefined);
    function_acd5af2a("player", "puzzle", "puzzle_good", "outcome_yes_generic", undefined);
    function_acd5af2a("player", "puzzle", "puzzle_bad", "outcome_no_generic", undefined);
    function_acd5af2a("player", "puzzle", "berate_respond", "generic_chastise", undefined);
    function_acd5af2a("player", "puzzle", "encourage_respond", "generic_encourage", undefined);
    function_acd5af2a("player", "staff", "first_piece", "1st_staff_found", undefined);
    function_acd5af2a("player", "general", "build_pickup", "pickup_generic", undefined, 100);
    function_acd5af2a("player", "general", "reboard", "rebuild_boards", undefined, 100);
    function_acd5af2a("player", "weapon_pickup", "explo", "wpck_explo", undefined, 100);
    function_acd5af2a("player", "weapon_pickup", "raygun_mark2", "wpck_raymk2", undefined, 100);
    function_acd5af2a("player", "general", "use_box_intro", "use_box_intro", undefined, 100);
    function_acd5af2a("player", "general", "use_box_2nd_time", "use_box_2nd_time", undefined, 100);
    function_acd5af2a("player", "general", "take_weapon_intro", "take_weapon_intro", undefined, 100);
    function_acd5af2a("player", "general", "take_weapon_2nd_time", "take_weapon_2nd_time", undefined, 100);
    function_acd5af2a("player", "general", "discover_wall_buy", "discover_wall_buy", undefined, 100);
    function_acd5af2a("player", "general", "generic_wall_buy", "generic_wall_buy", undefined, 100);
    function_acd5af2a("player", "general", "pap_arm", "pap_arm", undefined, 100);
    function_acd5af2a("player", "general", "pap_discovered", "capture_zones", undefined, 100);
    function_acd5af2a("player", "tank", "discover_tank", "discover_tank", undefined);
    function_acd5af2a("player", "tank", "tank_flame_zombie", "kill_tank", undefined, 25);
    function_acd5af2a("player", "tank", "tank_buy", "buy_tank", undefined);
    function_acd5af2a("player", "tank", "tank_leave", "exit_tank", undefined);
    function_acd5af2a("player", "tank", "tank_cooling", "cool_tank", undefined);
    function_acd5af2a("player", "tank", "tank_left_behind", "miss_tank", undefined);
    function_acd5af2a("player", "general", "siren_1st_time", "siren_1st_time", undefined, 100);
    function_acd5af2a("player", "general", "siren_generic", "siren_generic", undefined, 100);
    function_acd5af2a("player", "general", "multiple_mechs", "multiple_mechs", undefined, 100);
    function_acd5af2a("player", "general", "discover_mech", "discover_mech", undefined, 100);
    function_acd5af2a("player", "general", "mech_defeated", "mech_defeated", undefined, 100);
    function_acd5af2a("player", "general", "mech_grab", "rspnd_mech_grab", undefined, 100);
    function_acd5af2a("player", "general", "shoot_mech_arm", "shoot_mech_arm", undefined, 100);
    function_acd5af2a("player", "general", "shoot_mech_head", "shoot_mech_head", undefined, 100);
    function_acd5af2a("player", "general", "shoot_mech_power", "shoot_mech_power", undefined, 100);
    function_acd5af2a("player", "general", "rspnd_mech_jump", "rspnd_mech_jump", undefined, 100);
    function_acd5af2a("player", "general", "enter_robot", "enter_robot", undefined, 100);
    function_acd5af2a("player", "general", "purge_robot", "purge_robot", undefined, 100);
    function_acd5af2a("player", "general", "exit_robot", "exit_robot", undefined, 100);
    function_acd5af2a("player", "general", "air_chute_landing", "air_chute_landing", undefined, 100);
    function_acd5af2a("player", "general", "robot_crush_golden", "robot_crush_golden", undefined, 100);
    function_acd5af2a("player", "general", "robot_crush_player", "robot_crush_player", undefined, 100);
    function_acd5af2a("player", "general", "discover_robot", "discover_robot", undefined, 100);
    function_acd5af2a("player", "general", "see_robots", "see_robots", undefined, 100);
    function_acd5af2a("player", "general", "robot_crush_zombie", "robot_crush_zombie", undefined, 100);
    function_acd5af2a("player", "general", "robot_crush_mech", "robot_crush_mech", undefined, 100);
    function_acd5af2a("player", "general", "shoot_robot", "shoot_robot", undefined, 100);
    function_acd5af2a("player", "general", "warn_robot_foot", "warn_robot_foot", undefined, 100);
    function_acd5af2a("player", "general", "warn_robot", "warn_robot", undefined, 100);
    function_acd5af2a("player", "general", "use_beacon", "use_beacon", undefined, 100);
    function_acd5af2a("player", "general", "srnd_rspnd_to_plr_0_neg", "srnd_rspnd_to_plr_0_neg", undefined, 100);
    function_acd5af2a("player", "general", "srnd_rspnd_to_plr_1_neg", "srnd_rspnd_to_plr_1_neg", undefined, 100);
    function_acd5af2a("player", "general", "srnd_rspnd_to_plr_2_neg", "srnd_rspnd_to_plr_2_neg", undefined, 100);
    function_acd5af2a("player", "general", "srnd_rspnd_to_plr_3_neg", "srnd_rspnd_to_plr_3_neg", undefined, 100);
    function_acd5af2a("player", "general", "srnd_rspnd_to_plr_0_pos", "srnd_rspnd_to_plr_0_pos", undefined, 100);
    function_acd5af2a("player", "general", "srnd_rspnd_to_plr_1_pos", "srnd_rspnd_to_plr_1_pos", undefined, 100);
    function_acd5af2a("player", "general", "srnd_rspnd_to_plr_2_pos", "srnd_rspnd_to_plr_2_pos", undefined, 100);
    function_acd5af2a("player", "general", "srnd_rspnd_to_plr_3_pos", "srnd_rspnd_to_plr_3_pos", undefined, 100);
    function_acd5af2a("player", "general", "achievement", "earn_acheivement", undefined, 100);
    function_acd5af2a("player", "quest", "find_secret", "find_secret", undefined, 100);
    function_acd5af2a("player", "perk", "one_inch", "perk_one_inch", undefined, 100);
    function_acd5af2a("player", "digging", "pickup_shovel", "pickup_shovel", undefined, 100);
    function_acd5af2a("player", "digging", "dig_gun", "dig_gun", undefined, 100);
    function_acd5af2a("player", "digging", "dig_grenade", "dig_grenade", undefined, 100);
    function_acd5af2a("player", "digging", "dig_zombie", "dig_zombie", undefined, 100);
    function_acd5af2a("player", "digging", "dig_staff_part", "dig_staff_part", undefined, 100);
    function_acd5af2a("player", "digging", "dig_powerup", "dig_powerup", undefined, 100);
    function_acd5af2a("player", "digging", "dig_cash", "dig_cash", undefined, 100);
    function_acd5af2a("player", "soul_box", "zm_box_encourage", "zm_box_encourage", undefined, 100);
    function_acd5af2a("player", "zone_capture", "capture_started", "capture_zombies", undefined, 100);
    function_acd5af2a("player", "zone_capture", "recapture_started", "roaming_zombies", undefined, 100);
    function_acd5af2a("player", "zone_capture", "recapture_generator_attacked", "recapture_initiated", undefined, 100);
    function_acd5af2a("player", "zone_capture", "recapture_prevented", "recapture_prevented", undefined, 100);
    function_acd5af2a("player", "zone_capture", "all_generators_captured", "zones_held", undefined, 100);
    function_acd5af2a("player", "lockdown", "power_off", "lockdown_generic", undefined, 100);
    function_acd5af2a("player", "general", "struggle_mud", "struggle_mud", undefined, 100);
    function_acd5af2a("player", "general", "discover_dig_site", "discover_dig_site", undefined, 100);
    function_acd5af2a("player", "quadrotor", "kill_drone", "kill_drone", undefined, 20);
    function_acd5af2a("player", "quadrotor", "rspnd_drone_revive", "rspnd_drone_revive", undefined, 100);
    function_acd5af2a("player", "wunderfizz", "perk_wonder", "perk_wonder", undefined, 100);
    function_acd5af2a("player", "samantha", "hear_samantha_1", "hear_samantha_1", undefined, 100);
    function_acd5af2a("player", "samantha", "heroes_confer", "heroes_confer", undefined, 100);
    function_acd5af2a("player", "samantha", "hear_samantha_3", "hear_samantha_3", undefined, 100);
    function_7b9117f8();
}

// Namespace namespace_ad52727b
// Params 6, eflags: 0x1 linked
// Checksum 0x2e0cb10, Offset: 0x4cc8
// Size: 0xac
function function_acd5af2a(speaker, category, type, alias, response, chance) {
    if (!isdefined(response)) {
        response = 0;
    }
    if (!isdefined(chance)) {
        chance = 100;
    }
    level.vox zm_audio::zmbvoxadd(category, type, alias, chance, response);
    if (isdefined(chance)) {
        zm_utility::function_93789785(type, chance);
    }
}

// Namespace namespace_ad52727b
// Params 7, eflags: 0x1 linked
// Checksum 0x424ce2dd, Offset: 0x4d80
// Size: 0x78e
function function_6f253956(impact, mod, weapon, zombie, instakill, dist, player) {
    var_adac242b = 4096;
    var_2c1bd1bd = 15376;
    var_af03c4a6 = 160000;
    var_78b01d9b = [];
    if (isdefined(zombie.staff_dmg)) {
        weapon = zombie.staff_dmg;
    } else if (isdefined(zombie) && isdefined(zombie.damageweapon)) {
        weapon = zombie.damageweapon;
    }
    if (zombie.damageweapon.name == "sticky_grenade_widows_wine") {
        return "default";
    }
    str_weapon = weapon.name;
    switch (str_weapon) {
    case 251:
    case 252:
        return "ice_staff";
    case 253:
    case 254:
        return "ice_staff_upgrade";
    case 243:
    case 244:
        return "fire_staff";
    case 245:
    case 246:
        return "fire_staff_upgrade";
    case 247:
    case 248:
        return "lightning_staff";
    case 249:
    case 250:
        return "lightning_staff_upgrade";
    case 239:
    case 240:
        return "air_staff";
    case 241:
    case 242:
        return "air_staff_upgrade";
    }
    if (zombie.damageweapon.name == "dragonshield" || zombie.damageweapon.name == "dragonshield_upgraded") {
        return "rocketshield";
    }
    if (zombie.damageweapon.name == "hero_gravityspikes_melee") {
        if (zombie.damageweapon.firetype == "Melee" && !(isdefined(player isslamming()) && player isslamming())) {
            return "default";
        } else {
            return "dg4";
        }
    }
    if (zombie.damageweapon.name == "octobomb") {
        return "octobomb";
    }
    if (zombie.damageweapon.name == "idgun_genesis_0") {
        return "servant";
    }
    if (zombie.damageweapon.name == "thundergun") {
        return "thundergun";
    }
    if (zombie.damageweapon.name == "shotgun_energy+holo+quickdraw" || zombie.damageweapon.name == "pistol_energy+fastreload+reddot+steadyaim" || zombie.damageweapon.name == "shotgun_energy_upgraded+extclip+holo+quickdraw" || zombie.damageweapon.name == "pistol_energy_upgraded+extclip+fastreload+reddot+steadyaim") {
        return "default";
    }
    if (zm_utility::is_placeable_mine(weapon)) {
        if (!instakill) {
            return "betty";
        } else {
            return "weapon_instakill";
        }
    }
    if (zombie.damageweapon.name == "cymbal_monkey") {
        if (instakill) {
            return "weapon_instakill";
        } else {
            return "monkey";
        }
    }
    if ((zombie.damageweapon.name == "ray_gun" || zombie.damageweapon.name == "ray_gun_upgraded") && dist > var_af03c4a6) {
        if (!instakill) {
            return "raygun";
        } else {
            return "weapon_instakill";
        }
    }
    if (zombie.damageweapon.name == "raygun_mark2" || zombie.damageweapon.name == "raygun_mark2_upgraded") {
        if (!instakill) {
            return "raygunmk2";
        } else {
            return "weapon_instakill";
        }
    }
    if (zm_utility::is_headshot(weapon, impact, mod) && dist >= var_af03c4a6) {
        return "headshot";
    }
    if ((mod == "MOD_MELEE" || mod == "MOD_UNKNOWN") && dist < var_adac242b) {
        if (!instakill) {
            return "melee";
        } else {
            return "melee_instakill";
        }
    }
    if (zm_utility::is_explosive_damage(mod) && weapon.name != "ray_gun" && weapon.name != "ray_gun_upgraded" && !(isdefined(zombie.is_on_fire) && zombie.is_on_fire)) {
        if (!instakill) {
            return "explosive";
        } else {
            return "weapon_instakill";
        }
    }
    if (mod == "MOD_BURNED" || mod == "MOD_GRENADE" || weapon.doesfiredamage && mod == "MOD_GRENADE_SPLASH") {
        if (!instakill) {
            return "flame";
        } else {
            return "weapon_instakill";
        }
    }
    if (!isdefined(impact)) {
        impact = "";
    }
    if (mod != "MOD_MELEE" && zombie.missinglegs) {
        return "crawler";
    }
    if (mod != "MOD_BURNED" && dist < var_adac242b) {
        return "close";
    }
    if (mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET") {
        if (!instakill) {
            return "bullet";
        } else {
            return "weapon_instakill";
        }
    }
    if (instakill) {
        return "default";
    }
    return "default";
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x6ff5fef4, Offset: 0x5518
// Size: 0x256
function function_412f65cd() {
    self endon(#"hash_3f7b661c");
    while (true) {
        wait(1);
        if (isdefined(self.var_f5232adf) && self.var_f5232adf) {
            continue;
        }
        players = getplayers();
        zombs = zombie_utility::get_round_enemy_array();
        if (players.size <= 1) {
            n_distance = -6;
            n_zombies = 5;
            n_chance = 30;
            n_cooldown_time = 20;
        } else {
            n_distance = -6;
            n_zombies = 5;
            n_chance = 30;
            n_cooldown_time = 15;
        }
        var_6c755991 = 0;
        for (i = 0; i < zombs.size; i++) {
            if (isdefined(zombs[i].favoriteenemy) && zombs[i].favoriteenemy == self || !isdefined(zombs[i].favoriteenemy)) {
                if (distancesquared(zombs[i].origin, self.origin) < n_distance * n_distance) {
                    var_6c755991++;
                }
            }
        }
        if (var_6c755991 >= n_zombies) {
            if (randomint(100) < n_chance && !(isdefined(self.var_66476b55) && self.var_66476b55) && !isdefined(self.var_caac9938)) {
                self zm_audio::create_and_play_dialog("general", "oh_shit");
                self thread function_5148c4e3(n_cooldown_time);
                wait(n_cooldown_time);
            }
        }
    }
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x1 linked
// Checksum 0xcbaf82c9, Offset: 0x5778
// Size: 0x34
function function_5148c4e3(n_cooldown_time) {
    self endon(#"disconnect");
    self.var_f5232adf = 1;
    wait(n_cooldown_time);
    self.var_f5232adf = 0;
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x6d9f00c9, Offset: 0x57b8
// Size: 0x15c
function function_1ffaef19() {
    self endon(#"death");
    if (isdefined(self.a.gib_ref) && isalive(self)) {
        if (self.a.gib_ref == "no_legs" || self.a.gib_ref == "right_leg" || self.a.gib_ref == "left_leg") {
            if (isdefined(self.attacker) && isplayer(self.attacker)) {
                if (isdefined(self.attacker.var_e43d169c) && self.attacker.var_e43d169c) {
                    return;
                }
                rand = randomintrange(0, 100);
                if (rand < 15) {
                    self.attacker zm_audio::create_and_play_dialog("general", "crawl_spawn");
                    self.attacker thread function_e43d169c();
                }
            }
        }
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xaaf09214, Offset: 0x5920
// Size: 0x2c
function function_e43d169c() {
    self endon(#"disconnect");
    self.var_e43d169c = 1;
    wait(30);
    self.var_e43d169c = 0;
}

// Namespace namespace_ad52727b
// Params 2, eflags: 0x1 linked
// Checksum 0xcfd67c2c, Offset: 0x5958
// Size: 0x3b2
function function_de88384(weapon, magic_box) {
    self endon(#"death");
    self endon(#"disconnect");
    if (weapon.name == "hero_annihilator" || weapon.name == "equip_dieseldrone") {
        return "crappy";
    }
    str_weapon = weapon.name;
    if (isdefined(magic_box) && magic_box) {
        if (isdefined(self.var_50dd3717) && self.var_50dd3717 == 1) {
            self thread zm_audio::create_and_play_dialog("general", "take_weapon_intro");
        } else if (isdefined(self.var_50dd3717) && self.var_50dd3717 == 2) {
            self thread zm_audio::create_and_play_dialog("general", "take_weapon_2nd_time");
        } else {
            type = self zm_weapons::weapon_type_check(weapon);
            return type;
        }
    } else if (issubstr(str_weapon, "staff")) {
        if (str_weapon == "staff_fire") {
            self zm_audio::create_and_play_dialog("general", "pickup_fire");
            level notify(#"hash_70d555ad", self, 1);
        } else if (str_weapon == "staff_water") {
            self zm_audio::create_and_play_dialog("general", "pickup_ice");
            level notify(#"hash_70d555ad", self, 4);
        } else if (str_weapon == "staff_air") {
            self zm_audio::create_and_play_dialog("general", "pickup_wind");
            level notify(#"hash_70d555ad", self, 2);
        } else if (str_weapon == "staff_lightning") {
            self zm_audio::create_and_play_dialog("general", "pickup_light");
            level notify(#"hash_70d555ad", self, 3);
        }
    } else if (zm_weapons::is_weapon_upgraded(weapon)) {
        self thread zm_audio::create_and_play_dialog("general", "pap_arm");
    } else if (!isdefined(self.var_c7df9ee0)) {
        self thread zm_audio::create_and_play_dialog("general", "discover_wall_buy");
        self.var_c7df9ee0 = 1;
    } else if (str_weapon == "sticky_grenade" || str_weapon == "claymore") {
        self zm_audio::create_and_play_dialog("weapon_pickup", "explo");
    } else {
        self thread zm_audio::create_and_play_dialog("general", "generic_wall_buy");
    }
    return "crappy";
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x30727c30, Offset: 0x5d18
// Size: 0x94
function function_658b5c43() {
    if (!isdefined(self.var_50dd3717)) {
        self.var_50dd3717 = 1;
    } else {
        self.var_50dd3717++;
    }
    if (self.var_50dd3717 == 1) {
        self thread zm_audio::create_and_play_dialog("general", "use_box_intro");
        return;
    }
    if (self.var_50dd3717 == 2) {
        self thread zm_audio::create_and_play_dialog("general", "use_box_2nd_time");
    }
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x0
// Checksum 0x1d477937, Offset: 0x5db8
// Size: 0x150
function function_3d5c74d3(player) {
    wait(3.5);
    if (isalive(player)) {
        player thread zm_audio::create_and_play_dialog("quest", "find_secret");
        return;
    }
    while (true) {
        a_players = getplayers();
        foreach (player in a_players) {
            if (isalive(player)) {
                if (!(isdefined(player.dontspeak) && player.dontspeak)) {
                    player thread zm_audio::create_and_play_dialog("quest", "find_secret");
                }
            }
        }
    }
    wait(0.1);
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xdf9b48c8, Offset: 0x5f10
// Size: 0x60
function function_62377910() {
    if (!(isdefined(self.dontspeak) && self.dontspeak)) {
        if (!(isdefined(self.var_2af351c9) && self.var_2af351c9)) {
            self zm_audio::create_and_play_dialog("general", "place_gramophone");
            self.var_2af351c9 = 1;
        }
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xa8d8f997, Offset: 0x5f78
// Size: 0x8ba
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
    level.exert_sounds[1]["hitmed"][0] = "vox_plr_0_exert_pain_medium_0";
    level.exert_sounds[1]["hitmed"][1] = "vox_plr_0_exert_pain_medium_1";
    level.exert_sounds[1]["hitmed"][2] = "vox_plr_0_exert_pain_medium_2";
    level.exert_sounds[1]["hitmed"][3] = "vox_plr_0_exert_pain_medium_3";
    level.exert_sounds[2]["hitmed"][0] = "vox_plr_1_exert_pain_medium_0";
    level.exert_sounds[2]["hitmed"][1] = "vox_plr_1_exert_pain_medium_1";
    level.exert_sounds[2]["hitmed"][2] = "vox_plr_1_exert_pain_medium_2";
    level.exert_sounds[2]["hitmed"][3] = "vox_plr_1_exert_pain_medium_3";
    level.exert_sounds[3]["hitmed"][0] = "vox_plr_2_exert_pain_medium_0";
    level.exert_sounds[3]["hitmed"][1] = "vox_plr_2_exert_pain_medium_1";
    level.exert_sounds[3]["hitmed"][2] = "vox_plr_2_exert_pain_medium_2";
    level.exert_sounds[3]["hitmed"][3] = "vox_plr_2_exert_pain_medium_3";
    level.exert_sounds[4]["hitmed"][0] = "vox_plr_3_exert_pain_medium_0";
    level.exert_sounds[4]["hitmed"][1] = "vox_plr_3_exert_pain_medium_1";
    level.exert_sounds[4]["hitmed"][2] = "vox_plr_3_exert_pain_medium_2";
    level.exert_sounds[4]["hitmed"][3] = "vox_plr_3_exert_pain_medium_3";
    level.exert_sounds[1]["hitlrg"][0] = "vox_plr_0_exert_pain_high_0";
    level.exert_sounds[1]["hitlrg"][1] = "vox_plr_0_exert_pain_high_1";
    level.exert_sounds[1]["hitlrg"][2] = "vox_plr_0_exert_pain_high_2";
    level.exert_sounds[1]["hitlrg"][3] = "vox_plr_0_exert_pain_high_3";
    level.exert_sounds[2]["hitlrg"][0] = "vox_plr_1_exert_pain_high_0";
    level.exert_sounds[2]["hitlrg"][1] = "vox_plr_1_exert_pain_high_1";
    level.exert_sounds[2]["hitlrg"][2] = "vox_plr_1_exert_pain_high_2";
    level.exert_sounds[2]["hitlrg"][3] = "vox_plr_1_exert_pain_high_3";
    level.exert_sounds[3]["hitlrg"][0] = "vox_plr_2_exert_pain_high_0";
    level.exert_sounds[3]["hitlrg"][1] = "vox_plr_2_exert_pain_high_1";
    level.exert_sounds[3]["hitlrg"][2] = "vox_plr_2_exert_pain_high_2";
    level.exert_sounds[3]["hitlrg"][3] = "vox_plr_2_exert_pain_high_3";
    level.exert_sounds[4]["hitlrg"][0] = "vox_plr_3_exert_pain_high_0";
    level.exert_sounds[4]["hitlrg"][1] = "vox_plr_3_exert_pain_high_1";
    level.exert_sounds[4]["hitlrg"][2] = "vox_plr_3_exert_pain_high_2";
    level.exert_sounds[4]["hitlrg"][3] = "vox_plr_3_exert_pain_high_3";
}

// Namespace namespace_ad52727b
// Params 3, eflags: 0x1 linked
// Checksum 0xd889e157, Offset: 0x6840
// Size: 0x114
function function_e22c53bd(player, category, type) {
    if (type == "revive_up") {
        player thread function_622e4f1f("general", "heal_revived", "kills");
        return;
    }
    if (type == "headshot") {
        player thread function_622e4f1f("kill", "headshot_respond_to_plr_" + player.characterindex, "kills");
        return;
    }
    if (type == "oh_shit") {
        player thread function_622e4f1f("general", "srnd_rspnd_to_plr_" + player.characterindex, "kills");
        player thread function_5148c4e3(15);
    }
}

// Namespace namespace_ad52727b
// Params 2, eflags: 0x0
// Checksum 0xa1526da6, Offset: 0x6960
// Size: 0x104
function function_deb7d236(category, type) {
    a_players = getplayers();
    if (a_players.size <= 1) {
        return;
    }
    arrayremovevalue(a_players, self);
    a_closest = arraysort(a_players, self.origin, 1);
    if (distancesquared(self.origin, a_closest[0].origin) <= 250000) {
        if (isalive(a_closest[0])) {
            a_closest[0] zm_audio::create_and_play_dialog(category, type);
        }
    }
}

// Namespace namespace_ad52727b
// Params 3, eflags: 0x1 linked
// Checksum 0x3965a268, Offset: 0x6a70
// Size: 0x1ae
function function_622e4f1f(category, type, var_d7f161b3) {
    a_players = getplayers();
    if (a_players.size <= 1) {
        return;
    }
    arrayremovevalue(a_players, self);
    a_closest = arraysort(a_players, self.origin, 1);
    foreach (player in a_closest) {
        if (distancesquared(self.origin, player.origin) <= 250000) {
            if (isalive(player)) {
                str_suffix = function_751b21b(self, player, var_d7f161b3);
                if (isdefined(str_suffix)) {
                    type += str_suffix;
                }
                player zm_audio::create_and_play_dialog(category, type);
                break;
            }
        }
    }
}

// Namespace namespace_ad52727b
// Params 3, eflags: 0x1 linked
// Checksum 0x6c7456d9, Offset: 0x6c28
// Size: 0xbc
function function_751b21b(var_4cd6b5cb, var_dacf4690, var_d7f161b3) {
    var_60dca8b5 = var_4cd6b5cb globallogic_score::getpersstat(var_d7f161b3);
    var_840c4740 = var_dacf4690 globallogic_score::getpersstat(var_d7f161b3);
    if (!isdefined(var_60dca8b5) || !isdefined(var_840c4740)) {
        return undefined;
    }
    if (var_60dca8b5 >= var_840c4740) {
        str_result = "_pos";
    } else {
        str_result = "_neg";
    }
    return str_result;
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x40bfa4e6, Offset: 0x6cf0
// Size: 0x64
function function_7c44fdd7() {
    self endon(#"disconnect");
    self.var_7892737f = 1;
    self zm_audio::create_and_play_dialog("general", "struggle_mud");
    self waittill(#"hash_af080872");
    self thread function_1c23caad();
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x90af32be, Offset: 0x6d60
// Size: 0x20
function function_1c23caad() {
    self endon(#"disconnect");
    wait(600);
    self.var_7892737f = 0;
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x3d1e2f8c, Offset: 0x6d88
// Size: 0x14c
function function_84407d1() {
    level flag::wait_till("activate_zone_nml");
    s_origin = struct::get("discover_dig_site_vo_trigger", "targetname");
    s_origin.unitrigger_stub = spawnstruct();
    s_origin.unitrigger_stub.origin = s_origin.origin;
    s_origin.unitrigger_stub.script_width = 320;
    s_origin.unitrigger_stub.script_length = 88;
    s_origin.unitrigger_stub.script_height = 256;
    s_origin.unitrigger_stub.script_unitrigger_type = "unitrigger_box";
    s_origin.unitrigger_stub.angles = (0, 0, 0);
    zm_unitrigger::register_static_unitrigger(s_origin.unitrigger_stub, &function_73ed57e8);
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x6372e0cf, Offset: 0x6ee0
// Size: 0xa4
function function_73ed57e8() {
    while (true) {
        player = self waittill(#"trigger");
        if (isplayer(player)) {
            if (!(isdefined(player.dontspeak) && player.dontspeak)) {
                player thread zm_audio::create_and_play_dialog("general", "discover_dig_site");
                zm_unitrigger::unregister_unitrigger(self.stub);
                break;
            }
        }
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xbfe69a94, Offset: 0x6f90
// Size: 0x1da
function function_7480ce48() {
    var_1ee7893 = struct::get_array("maxis_audio_log", "targetname");
    foreach (s_origin in var_1ee7893) {
        s_origin.unitrigger_stub = spawnstruct();
        s_origin.unitrigger_stub.origin = s_origin.origin;
        s_origin.unitrigger_stub.radius = 36;
        s_origin.unitrigger_stub.height = 256;
        s_origin.unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
        s_origin.unitrigger_stub.hint_string = %ZM_TOMB_MAXIS_AUDIOLOG;
        s_origin.unitrigger_stub.cursor_hint = "HINT_NOICON";
        s_origin.unitrigger_stub.require_look_at = 1;
        s_origin.unitrigger_stub.script_int = s_origin.script_int;
        zm_unitrigger::register_static_unitrigger(s_origin.unitrigger_stub, &function_7ea8a854);
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x10c2fc52, Offset: 0x7178
// Size: 0x252
function function_ee50b901() {
    var_7278d49e = getent("pack_a_punch_intro_trigger", "targetname");
    if (!isdefined(var_7278d49e)) {
        return;
    }
    s_lookat = struct::get(var_7278d49e.target, "targetname");
    while (true) {
        e_player = var_7278d49e waittill(#"trigger");
        if (!isdefined(e_player.var_e5719eaa)) {
            e_player.var_e5719eaa = 0;
        }
        if (!e_player.var_e5719eaa) {
            if (vectordot(anglestoforward(e_player getplayerangles()), vectornormalize(s_lookat.origin - e_player.origin)) > 0.8 && e_player function_28d3d4()) {
                e_player.var_e5719eaa = 1;
                e_player zm_audio::create_and_play_dialog("general", "pap_discovered");
                foreach (player in getplayers()) {
                    if (distance(player.origin, e_player.origin) < 800) {
                        player.var_e5719eaa = 1;
                    }
                }
            }
        }
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x659594b2, Offset: 0x73d8
// Size: 0x56
function function_28d3d4() {
    return isplayer(self) && !(isdefined(self.dontspeak) && self.dontspeak) && self clientfield::get_to_player("isspeaking") == 0;
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xbb4f01b8, Offset: 0x7438
// Size: 0x84
function function_7ea8a854() {
    player = self waittill(#"trigger");
    if (!isplayer(player) || !zombie_utility::is_player_valid(player)) {
        return;
    }
    level thread function_2b96eb30(self.stub.origin, self.stub.script_int);
}

// Namespace namespace_ad52727b
// Params 2, eflags: 0x1 linked
// Checksum 0xa7b90476, Offset: 0x74c8
// Size: 0x344
function function_2b96eb30(var_ad2a6d45, var_d9bfb82c) {
    var_98eed881 = function_f66a4ae0();
    var_ff96fe00 = var_98eed881[var_d9bfb82c];
    if (var_d9bfb82c == 4) {
        level flag::set("maxis_audiolog_gr0_playing");
    } else if (var_d9bfb82c == 5) {
        level flag::set("maxis_audiolog_gr1_playing");
    } else if (var_d9bfb82c == 6) {
        level flag::set("maxis_audiolog_gr2_playing");
    }
    var_fe164365 = spawn("script_origin", var_ad2a6d45);
    level flag::set("maxis_audio_log_" + var_d9bfb82c);
    var_aba4ba44 = struct::get_array("maxis_audio_log", "targetname");
    foreach (s_trigger in var_aba4ba44) {
        if (s_trigger.script_int == var_d9bfb82c) {
            break;
        }
    }
    level thread zm_unitrigger::unregister_unitrigger(s_trigger.unitrigger_stub);
    for (i = 0; i < var_ff96fe00.size; i++) {
        var_fe164365 playsoundwithnotify(var_ff96fe00[i], var_ff96fe00[i] + "_done");
        var_fe164365 waittill(var_ff96fe00[i] + "_done");
    }
    var_fe164365 delete();
    if (var_d9bfb82c == 4) {
        level flag::clear("maxis_audiolog_gr0_playing");
    } else if (var_d9bfb82c == 5) {
        level flag::clear("maxis_audiolog_gr1_playing");
    } else if (var_d9bfb82c == 6) {
        level flag::clear("maxis_audiolog_gr2_playing");
    }
    level thread zm_unitrigger::register_static_unitrigger(s_trigger.unitrigger_stub, &function_7ea8a854);
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x1 linked
// Checksum 0x7181d169, Offset: 0x7818
// Size: 0x172
function function_271ff115(var_9a1bfdd4) {
    if (var_9a1bfdd4 == 0) {
        n_script_int = 4;
    } else if (var_9a1bfdd4 == 1) {
        n_script_int = 5;
    } else if (var_9a1bfdd4 == 2) {
        n_script_int = 6;
    }
    if (level flag::get("maxis_audio_log_" + n_script_int)) {
        return;
    }
    var_1ee7893 = struct::get_array("maxis_audio_log", "targetname");
    foreach (s_origin in var_1ee7893) {
        if (s_origin.script_int == n_script_int) {
            if (isdefined(s_origin.unitrigger_stub)) {
                zm_unitrigger::unregister_unitrigger(s_origin.unitrigger_stub);
            }
        }
    }
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x1 linked
// Checksum 0x22bfec35, Offset: 0x7998
// Size: 0x152
function function_844ce15d(var_9a1bfdd4) {
    if (var_9a1bfdd4 == 0) {
        n_script_int = 4;
    } else if (var_9a1bfdd4 == 1) {
        n_script_int = 5;
    } else if (var_9a1bfdd4 == 2) {
        n_script_int = 6;
    }
    var_1ee7893 = struct::get_array("maxis_audio_log", "targetname");
    foreach (s_origin in var_1ee7893) {
        if (s_origin.script_int == n_script_int) {
            if (isdefined(s_origin.unitrigger_stub)) {
                zm_unitrigger::register_static_unitrigger(s_origin.unitrigger_stub, &function_7ea8a854);
            }
        }
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xf4ee8e78, Offset: 0x7af8
// Size: 0x1f8
function function_f66a4ae0() {
    var_afbda4a8 = [];
    var_afbda4a8[1] = [];
    var_afbda4a8[1][0] = "vox_maxi_audio_log_1_1_0";
    var_afbda4a8[1][1] = "vox_maxi_audio_log_1_2_0";
    var_afbda4a8[1][2] = "vox_maxi_audio_log_1_3_0";
    var_afbda4a8[2] = [];
    var_afbda4a8[2][0] = "vox_maxi_audio_log_2_1_0";
    var_afbda4a8[2][1] = "vox_maxi_audio_log_2_2_0";
    var_afbda4a8[3] = [];
    var_afbda4a8[3][0] = "vox_maxi_audio_log_3_1_0";
    var_afbda4a8[3][1] = "vox_maxi_audio_log_3_2_0";
    var_afbda4a8[3][2] = "vox_maxi_audio_log_3_3_0";
    var_afbda4a8[4] = [];
    var_afbda4a8[4][0] = "vox_maxi_audio_log_4_1_0";
    var_afbda4a8[4][1] = "vox_maxi_audio_log_4_2_0";
    var_afbda4a8[4][2] = "vox_maxi_audio_log_4_3_0";
    var_afbda4a8[5] = [];
    var_afbda4a8[5][0] = "vox_maxi_audio_log_5_1_0";
    var_afbda4a8[5][1] = "vox_maxi_audio_log_5_2_0";
    var_afbda4a8[5][2] = "vox_maxi_audio_log_5_3_0";
    var_afbda4a8[6] = [];
    var_afbda4a8[6][0] = "vox_maxi_audio_log_6_1_0";
    var_afbda4a8[6][1] = "vox_maxi_audio_log_6_2_0";
    return var_afbda4a8;
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xb3ee6ef0, Offset: 0x7cf8
// Size: 0x104
function function_9e7d0342() {
    level flag::wait_till("start_zombie_round_logic");
    function_eee384d4(1);
    wait(10);
    if (is_game_solo()) {
        function_c4f60b6a();
    } else {
        function_f9131c50();
    }
    level waittill(#"end_of_round");
    level thread function_b59a9545();
    if (is_game_solo()) {
        function_66b9c74c();
    } else {
        function_96b6d19e();
    }
    level flag::set("round_one_narrative_vo_complete");
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x1cac129b, Offset: 0x7e08
// Size: 0xb4
function function_8f3fa6c2() {
    while (true) {
        level waittill(#"start_of_round");
        if (level.round_number == 5) {
            function_f2840cf7();
            continue;
        }
        if (level.round_number == 6) {
            function_807c9dbc();
            continue;
        }
        if (level.round_number == 7) {
            function_a67f1825();
            level flag::set("samantha_intro_done");
            break;
        }
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xede3abe6, Offset: 0x7ec8
// Size: 0x1f4
function function_f2840cf7() {
    /#
        iprintln("maxis_audio_log_4");
    #/
    players = getplayers();
    if (!isdefined(players[0])) {
        return;
    }
    level flag::wait_till_clear("story_vo_playing");
    level flag::set("story_vo_playing");
    function_eee384d4(1);
    function_10d15bb5("vox_sam_sam_help_5_0", players[0], 1, 1);
    players = getplayers();
    foreach (player in players) {
        if (player.var_f7af1630 != "Richtofen") {
            player function_2fdcbf84("hear_samantha_1", player.var_f7af1630);
            wait(1);
            function_e365e60a("vox_plr_2_hear_samantha_1_0", "Richtofen");
            break;
        }
    }
    function_eee384d4(0);
    level flag::clear("story_vo_playing");
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x4e2919d6, Offset: 0x80c8
// Size: 0x16c
function function_807c9dbc() {
    /#
        iprintln("maxis_audio_log_4");
    #/
    var_66cc5287 = function_ab06af15("Richtofen");
    if (!isdefined(var_66cc5287)) {
        return;
    }
    level flag::wait_till_clear("story_vo_playing");
    level flag::set("story_vo_playing");
    function_eee384d4(1);
    if (isdefined(var_66cc5287)) {
        var_9176f47c = function_9f01dd1a(var_66cc5287);
        if (isdefined(var_9176f47c)) {
            var_9176f47c function_2fdcbf84("heroes_confer", var_9176f47c.var_f7af1630);
            wait(1);
            function_e365e60a("vox_plr_2_heroes_confer_0", "Richtofen");
        }
    }
    function_eee384d4(0);
    level flag::clear("story_vo_playing");
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xd7834b0f, Offset: 0x8240
// Size: 0x17c
function function_a67f1825() {
    /#
        iprintln("maxis_audio_log_4");
    #/
    players = getplayers();
    if (!isdefined(players[0])) {
        return;
    }
    level flag::wait_till_clear("story_vo_playing");
    level flag::set("story_vo_playing");
    function_eee384d4(1);
    function_10d15bb5("vox_sam_hear_samantha_3_0", players[0], 1, 1);
    players = getplayers();
    player = players[randomintrange(0, players.size)];
    if (isdefined(player)) {
        player function_2fdcbf84("hear_samantha_3", player.var_f7af1630);
    }
    function_eee384d4(0);
    level flag::clear("story_vo_playing");
}

// Namespace namespace_ad52727b
// Params 2, eflags: 0x1 linked
// Checksum 0xcd6afb23, Offset: 0x83c8
// Size: 0xd4
function function_2fdcbf84(category, var_f7af1630) {
    var_86ac4640 = undefined;
    switch (var_f7af1630) {
    case 407:
        var_86ac4640 = "vox_plr_0_";
        break;
    case 408:
        var_86ac4640 = "vox_plr_1_";
        break;
    case 399:
        var_86ac4640 = "vox_plr_2_";
        break;
    case 409:
        var_86ac4640 = "vox_plr_3_";
        break;
    }
    var_d072a269 = var_86ac4640 + category + "_0";
    function_e365e60a(var_d072a269, var_f7af1630);
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x1 linked
// Checksum 0xe4d079da, Offset: 0x84a8
// Size: 0x13e
function function_9f01dd1a(other_player) {
    var_4ab1c04b = 800;
    var_9176f47c = undefined;
    players = getplayers();
    foreach (player in players) {
        var_64fbd7b6 = distance(player.origin, other_player.origin);
        if (player != other_player && var_64fbd7b6 < var_4ab1c04b) {
            var_9176f47c = player;
            var_4ab1c04b = var_64fbd7b6;
        }
    }
    if (isdefined(var_9176f47c)) {
        return var_9176f47c;
    }
    return undefined;
}

// Namespace namespace_ad52727b
// Params 2, eflags: 0x1 linked
// Checksum 0x3adfe94b, Offset: 0x85f0
// Size: 0xbe
function function_e365e60a(var_d072a269, var_f7af1630) {
    var_2f672d06 = function_ab06af15(var_f7af1630);
    if (isdefined(var_2f672d06)) {
        /#
            iprintln("maxis_audio_log_4" + var_f7af1630 + "maxis_audio_log_4" + var_d072a269);
        #/
        var_2f672d06 playsoundwithnotify(var_d072a269, "sound_done" + var_d072a269);
        var_2f672d06 waittill("sound_done" + var_d072a269);
        return 1;
    }
    return 0;
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x1 linked
// Checksum 0x2dd2cc34, Offset: 0x86b8
// Size: 0xb6
function function_ab06af15(var_f7af1630) {
    players = getplayers();
    foreach (player in players) {
        if (player.var_f7af1630 == var_f7af1630) {
            return player;
        }
    }
    return undefined;
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xfe193631, Offset: 0x8778
// Size: 0x9c
function function_b59a9545() {
    level waittill(#"end_of_round");
    level flag::wait_till("round_one_narrative_vo_complete");
    if (level flag::get("generator_find_vo_playing")) {
        level flag::wait_till_clear("generator_find_vo_playing");
        wait(3);
    }
    if (is_game_solo()) {
        function_997f9042();
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x640ff320, Offset: 0x8820
// Size: 0x21c
function function_c4f60b6a() {
    if (level flag::get("story_vo_playing")) {
        return;
    }
    players = getplayers();
    e_speaker = players[0];
    if (!isdefined(e_speaker)) {
        return;
    }
    var_88bbc03e = function_8dfad40d();
    level flag::set("story_vo_playing");
    function_eee384d4(1);
    lines = var_88bbc03e[e_speaker.var_f7af1630];
    if (isarray(lines)) {
        for (i = 0; i < lines.size; i++) {
            e_speaker playsoundwithnotify(lines[i], "sound_done" + lines[i]);
            e_speaker waittill("sound_done" + lines[i]);
            wait(1);
        }
    } else {
        e_speaker playsoundwithnotify(var_88bbc03e[e_speaker.var_f7af1630], "sound_done" + var_88bbc03e[e_speaker.var_f7af1630]);
        e_speaker waittill("sound_done" + var_88bbc03e[e_speaker.var_f7af1630]);
    }
    function_eee384d4(0);
    level flag::clear("story_vo_playing");
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xf2a82fb, Offset: 0x8a48
// Size: 0xa2
function function_8dfad40d() {
    var_807d33e4 = [];
    var_807d33e4["Dempsey"] = "vox_plr_0_game_start_0";
    var_807d33e4["Nikolai"] = "vox_plr_1_game_start_0";
    var_807d33e4["Richtofen"] = [];
    var_807d33e4["Richtofen"][0] = "vox_plr_2_game_start_0";
    var_807d33e4["Richtofen"][1] = "vox_plr_2_game_start_1";
    var_807d33e4["Takeo"] = "vox_plr_3_game_start_0";
    return var_807d33e4;
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x85bc9278, Offset: 0x8af8
// Size: 0x454
function function_f9131c50() {
    players = getplayers();
    if (players.size <= 1) {
        return;
    }
    if (level flag::get("story_vo_playing")) {
        return;
    }
    var_98bd7322 = function_32ef90c5();
    level flag::set("story_vo_playing");
    var_2d13d22c = undefined;
    e_nikolai = undefined;
    e_richtofen = undefined;
    var_b3599de7 = undefined;
    foreach (player in players) {
        if (isdefined(player)) {
            switch (player.var_f7af1630) {
            case 407:
                var_2d13d22c = player;
                break;
            case 408:
                e_nikolai = player;
                break;
            case 399:
                e_richtofen = player;
                break;
            case 409:
                var_b3599de7 = player;
                break;
            }
        }
    }
    function_eee384d4(1);
    for (i = 0; i < var_98bd7322.size; i++) {
        players = getplayers();
        if (players.size <= 1) {
            function_eee384d4(0);
            level flag::clear("story_vo_playing");
            return;
        }
        if (!isdefined(e_richtofen)) {
            continue;
        }
        var_3923a439 = i + 1;
        if (var_3923a439 == 2) {
            var_8cfce75b = var_98bd7322["line_" + var_3923a439];
            for (j = 0; j < var_8cfce75b.size; j++) {
                e_richtofen playsoundwithnotify(var_8cfce75b[j], "sound_done" + var_8cfce75b[j]);
                e_richtofen waittill("sound_done" + var_8cfce75b[j]);
            }
            continue;
        }
        arrayremovevalue(players, e_richtofen);
        players = util::get_array_of_closest(e_richtofen.origin, players);
        e_speaker = players[0];
        if (!isdefined(e_speaker)) {
            continue;
        }
        e_speaker playsoundwithnotify(var_98bd7322["line_" + var_3923a439][e_speaker.var_f7af1630], "sound_done" + var_98bd7322["line_" + var_3923a439][e_speaker.var_f7af1630]);
        e_speaker waittill("sound_done" + var_98bd7322["line_" + var_3923a439][e_speaker.var_f7af1630]);
    }
    function_eee384d4(0);
    level flag::clear("story_vo_playing");
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x2addd75c, Offset: 0x8f58
// Size: 0x148
function function_32ef90c5() {
    var_98bd7322 = [];
    var_98bd7322["line_1"] = [];
    var_98bd7322["line_1"]["Dempsey"] = "vox_plr_0_game_start_meet_2_0";
    var_98bd7322["line_1"]["Nikolai"] = "vox_plr_1_game_start_meet_1_0";
    var_98bd7322["line_1"]["Takeo"] = "vox_plr_3_game_start_meet_3_0";
    var_98bd7322["line_2"] = [];
    var_98bd7322["line_2"][0] = "vox_plr_2_game_start_meet_4_0";
    var_98bd7322["line_2"][1] = "vox_plr_2_generator_find_0";
    var_98bd7322["line_3"] = [];
    var_98bd7322["line_3"]["Dempsey"] = "vox_plr_0_generator_find_0";
    var_98bd7322["line_3"]["Nikolai"] = "vox_plr_1_generator_find_0";
    var_98bd7322["line_3"]["Takeo"] = "vox_plr_3_generator_find_0";
    return var_98bd7322;
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x1 linked
// Checksum 0xc726a922, Offset: 0x90a8
// Size: 0x11c
function function_d755277f(var_a8a7ac5f) {
    wait(1);
    while (isdefined(self.isspeaking) && self.isspeaking) {
        util::wait_network_frame();
    }
    if (level.var_c01c54cd == 4) {
        function_7cba94d6();
        return;
    }
    if (isdefined(var_a8a7ac5f)) {
        level flag::wait_till_clear("story_vo_playing");
        level flag::set("story_vo_playing");
        function_eee384d4(1);
        function_10d15bb5(var_a8a7ac5f, self, 1);
        function_eee384d4(0);
        level flag::clear("story_vo_playing");
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x0
// Checksum 0x589509cc, Offset: 0x91d0
// Size: 0xe8
function function_3ca028a8() {
    var_71cd2515 = [];
    lines = array("vox_sam_1st_staff_crafted_0", "vox_sam_2nd_staff_crafted_0", "vox_sam_3rd_staff_crafted_0");
    while (var_71cd2515.size < 4) {
        var_90993e64, var_b5f6f4e4 = level waittill(#"hash_70d555ad");
        if (!(isdefined(var_71cd2515[var_b5f6f4e4]) && var_71cd2515[var_b5f6f4e4])) {
            var_71cd2515[var_b5f6f4e4] = 1;
            line = lines[level.var_c01c54cd - 1];
            var_90993e64 thread function_d755277f(line);
        }
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x9fe70590, Offset: 0x92c0
// Size: 0x1bc
function function_7cba94d6() {
    while (level flag::get("story_vo_playing")) {
        util::wait_network_frame();
    }
    var_88bbc03e = function_2590ceb();
    level flag::set("story_vo_playing");
    function_eee384d4(1);
    for (i = 0; i < var_88bbc03e.size; i++) {
        var_3923a439 = i + 1;
        index = "line_" + var_3923a439;
        if (isdefined(var_88bbc03e[index]["Sam"])) {
            function_10d15bb5(var_88bbc03e[index]["Sam"], self);
            continue;
        }
        line = var_88bbc03e[index][self.var_f7af1630];
        self playsoundwithnotify(line, "sound_done" + line);
        self waittill("sound_done" + line);
    }
    function_eee384d4(0);
    level flag::clear("story_vo_playing");
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x9b658b5, Offset: 0x9488
// Size: 0x1dc
function function_2590ceb() {
    var_e88c9ead = [];
    var_e88c9ead["line_1"] = [];
    var_e88c9ead["line_1"]["Sam"] = "vox_sam_4th_staff_crafted_0";
    var_e88c9ead["line_2"] = [];
    var_e88c9ead["line_2"]["Dempsey"] = "vox_plr_0_4th_staff_crafted_0";
    var_e88c9ead["line_2"]["Nikolai"] = "vox_plr_1_4th_staff_crafted_0";
    var_e88c9ead["line_2"]["Richtofen"] = "vox_plr_2_4th_staff_crafted_0";
    var_e88c9ead["line_2"]["Takeo"] = "vox_plr_3_4th_staff_crafted_0";
    var_e88c9ead["line_3"] = [];
    var_e88c9ead["line_3"]["Sam"] = "vox_sam_4th_staff_crafted_1";
    var_e88c9ead["line_4"] = [];
    var_e88c9ead["line_4"]["Dempsey"] = "vox_plr_0_4th_staff_crafted_1";
    var_e88c9ead["line_4"]["Nikolai"] = "vox_plr_1_4th_staff_crafted_1";
    var_e88c9ead["line_4"]["Richtofen"] = "vox_plr_2_4th_staff_crafted_1";
    var_e88c9ead["line_4"]["Takeo"] = "vox_plr_3_4th_staff_crafted_1";
    var_e88c9ead["line_5"] = [];
    var_e88c9ead["line_5"]["Sam"] = "vox_sam_generic_encourage_6";
    return var_e88c9ead;
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x79baba5c, Offset: 0x9670
// Size: 0xa4
function function_f2d71159() {
    var_e807cbbc = 0;
    if (self.var_f7af1630 == "Nikolai") {
        var_e807cbbc = 1;
    } else if (self.var_f7af1630 == "Richtofen") {
        var_e807cbbc = 2;
    } else if (self.var_f7af1630 == "Takeo") {
        var_e807cbbc = 3;
    }
    return "vox_plr_" + var_e807cbbc + "_miss_tank_" + randomint(3);
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x1 linked
// Checksum 0x7395ad6b, Offset: 0x9720
// Size: 0x2ca
function function_bee48356(e_victim) {
    if (self.var_f7af1630 == "Dempsey") {
        if (math::cointoss()) {
            return "vox_plr_0_tank_rspnd_generic_0";
        } else if (e_victim.var_f7af1630 == "Nikolai") {
            return "vox_plr_0_tank_rspnd_to_plr_1_0";
        } else if (e_victim.var_f7af1630 == "Richtofen") {
            return "vox_plr_0_tank_rspnd_to_plr_2_0";
        } else if (e_victim.var_f7af1630 == "Takeo") {
            return "vox_plr_0_tank_rspnd_to_plr_3_0";
        }
    } else if (self.var_f7af1630 == "Nikolai") {
        if (math::cointoss()) {
            return "vox_plr_1_tank_rspnd_generic_0";
        } else if (e_victim.var_f7af1630 == "Dempsey") {
            return "vox_plr_1_tank_rspnd_to_plr_0_0";
        } else if (e_victim.var_f7af1630 == "Richtofen") {
            return "vox_plr_1_tank_rspnd_to_plr_2_0";
        } else if (e_victim.var_f7af1630 == "Takeo") {
            return "vox_plr_1_tank_rspnd_to_plr_3_0";
        }
    } else if (self.var_f7af1630 == "Richtofen") {
        if (math::cointoss()) {
            return "vox_plr_2_tank_rspnd_generic_0";
        } else if (e_victim.var_f7af1630 == "Dempsey") {
            return "vox_plr_2_tank_rspnd_to_plr_0_0";
        } else if (e_victim.var_f7af1630 == "Nikolai") {
            return "vox_plr_2_tank_rspnd_to_plr_1_0";
        } else if (e_victim.var_f7af1630 == "Takeo") {
            return "vox_plr_2_tank_rspnd_to_plr_3_0";
        }
    } else if (self.var_f7af1630 == "Takeo") {
        if (math::cointoss()) {
            return "vox_plr_3_tank_rspnd_generic_0";
        } else if (e_victim.var_f7af1630 == "Dempsey") {
            return "vox_plr_3_tank_rspnd_to_plr_0_0";
        } else if (e_victim.var_f7af1630 == "Nikolai") {
            return "vox_plr_3_tank_rspnd_to_plr_1_0";
        } else if (e_victim.var_f7af1630 == "Richtofen") {
            return "vox_plr_3_tank_rspnd_to_plr_2_0";
        }
    }
    return undefined;
}

// Namespace namespace_ad52727b
// Params 2, eflags: 0x1 linked
// Checksum 0xb33f8d01, Offset: 0x99f8
// Size: 0x1cc
function function_51722ebc(e_victim, var_eb2993cb) {
    if (!isdefined(e_victim) || !isdefined(var_eb2993cb)) {
        return;
    }
    if (level flag::get("story_vo_playing")) {
        return;
    }
    level flag::set("story_vo_playing");
    function_eee384d4(1);
    e_victim.isspeaking = 1;
    var_eb2993cb.isspeaking = 1;
    var_287e6b5c = e_victim function_f2d71159();
    e_victim playsoundwithnotify(var_287e6b5c, "sound_done" + var_287e6b5c);
    e_victim waittill("sound_done" + var_287e6b5c);
    var_535824a8 = var_eb2993cb function_bee48356(e_victim);
    e_victim playsoundwithnotify(var_535824a8, "sound_done" + var_535824a8);
    e_victim waittill("sound_done" + var_535824a8);
    e_victim.isspeaking = 0;
    var_eb2993cb.isspeaking = 0;
    function_eee384d4(0);
    level flag::clear("story_vo_playing");
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xb7870f3d, Offset: 0x9bd0
// Size: 0x21c
function function_66b9c74c() {
    if (level flag::get("story_vo_playing")) {
        return;
    }
    players = getplayers();
    e_speaker = players[0];
    if (!isdefined(e_speaker)) {
        return;
    }
    var_88bbc03e = function_27890b31();
    level flag::set("story_vo_playing");
    function_eee384d4(1);
    lines = var_88bbc03e[e_speaker.var_f7af1630];
    if (isarray(lines)) {
        for (i = 0; i < lines.size; i++) {
            e_speaker playsoundwithnotify(lines[i], "sound_done" + lines[i]);
            e_speaker waittill("sound_done" + lines[i]);
            wait(1);
        }
    } else {
        e_speaker playsoundwithnotify(var_88bbc03e[e_speaker.var_f7af1630], "sound_done" + var_88bbc03e[e_speaker.var_f7af1630]);
        e_speaker waittill("sound_done" + var_88bbc03e[e_speaker.var_f7af1630]);
    }
    function_eee384d4(0);
    level flag::clear("story_vo_playing");
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xe55666df, Offset: 0x9df8
// Size: 0xa6
function function_27890b31() {
    var_88752dc6 = [];
    var_88752dc6["Dempsey"] = [];
    var_88752dc6["Dempsey"][0] = "vox_plr_0_end_round_1_5_0";
    var_88752dc6["Dempsey"][1] = "vox_plr_0_end_round_1_6_1";
    var_88752dc6["Nikolai"] = "vox_plr_1_end_round_1_9_0";
    var_88752dc6["Richtofen"] = "vox_plr_2_end_round_1_7_0";
    var_88752dc6["Takeo"] = "vox_plr_3_end_round_1_8_0";
    return var_88752dc6;
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x5cbbf9e7, Offset: 0x9ea8
// Size: 0x454
function function_96b6d19e() {
    players = getplayers();
    if (players.size <= 1) {
        return;
    }
    if (level flag::get("story_vo_playing")) {
        return;
    }
    var_88bbc03e = function_5359641();
    level flag::set("story_vo_playing");
    var_2d13d22c = undefined;
    e_nikolai = undefined;
    e_richtofen = undefined;
    var_b3599de7 = undefined;
    foreach (player in players) {
        if (isdefined(player)) {
            switch (player.var_f7af1630) {
            case 407:
                var_2d13d22c = player;
                break;
            case 408:
                e_nikolai = player;
                break;
            case 399:
                e_richtofen = player;
                break;
            case 409:
                var_b3599de7 = player;
                break;
            }
        }
    }
    function_eee384d4(1);
    for (i = 0; i < var_88bbc03e.size; i++) {
        players = getplayers();
        if (players.size <= 1) {
            function_eee384d4(0);
            level flag::clear("story_vo_playing");
            return;
        }
        if (!isdefined(e_richtofen)) {
            continue;
        }
        var_3923a439 = i + 1;
        if (var_3923a439 == 2) {
            var_8cfce75b = var_88bbc03e["line_" + var_3923a439];
            for (j = 0; j < var_8cfce75b.size; j++) {
                e_richtofen playsoundwithnotify(var_8cfce75b[j], "sound_done" + var_8cfce75b[j]);
                e_richtofen waittill("sound_done" + var_8cfce75b[j]);
            }
            continue;
        }
        arrayremovevalue(players, e_richtofen);
        players = util::get_array_of_closest(e_richtofen.origin, players);
        e_speaker = players[0];
        if (!isdefined(e_speaker)) {
            continue;
        }
        e_speaker playsoundwithnotify(var_88bbc03e["line_" + var_3923a439][e_speaker.var_f7af1630], "sound_done" + var_88bbc03e["line_" + var_3923a439][e_speaker.var_f7af1630]);
        e_speaker waittill("sound_done" + var_88bbc03e["line_" + var_3923a439][e_speaker.var_f7af1630]);
    }
    function_eee384d4(0);
    level flag::clear("story_vo_playing");
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xa89167f3, Offset: 0xa308
// Size: 0x12c
function function_5359641() {
    var_5059cde0 = [];
    var_5059cde0["line_1"] = [];
    var_5059cde0["line_1"]["Dempsey"] = "vox_plr_0_end_round_1_1_0";
    var_5059cde0["line_1"]["Nikolai"] = "vox_plr_1_end_round_1_3_0";
    var_5059cde0["line_1"]["Takeo"] = "vox_plr_3_end_round_1_2_0";
    var_5059cde0["line_2"] = [];
    var_5059cde0["line_2"][0] = "vox_plr_2_story_exposition_4_0";
    var_5059cde0["line_3"] = [];
    var_5059cde0["line_3"]["Dempsey"] = "vox_plr_0_during_round_1_0";
    var_5059cde0["line_3"]["Nikolai"] = "vox_plr_1_during_round_2_0";
    var_5059cde0["line_3"]["Takeo"] = "vox_plr_3_during_round_2_0";
    return var_5059cde0;
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x9e1771d0, Offset: 0xa440
// Size: 0x21c
function function_997f9042() {
    if (level flag::get("story_vo_playing")) {
        return;
    }
    players = getplayers();
    e_speaker = players[0];
    if (!isdefined(e_speaker)) {
        return;
    }
    var_88bbc03e = function_7b775f1b();
    level flag::set("story_vo_playing");
    function_eee384d4(1);
    lines = var_88bbc03e[e_speaker.var_f7af1630];
    if (isarray(lines)) {
        for (i = 0; i < lines.size; i++) {
            e_speaker playsoundwithnotify(lines[i], "sound_done" + lines[i]);
            e_speaker waittill("sound_done" + lines[i]);
            wait(1);
        }
    } else {
        e_speaker playsoundwithnotify(var_88bbc03e[e_speaker.var_f7af1630], "sound_done" + var_88bbc03e[e_speaker.var_f7af1630]);
        e_speaker waittill("sound_done" + var_88bbc03e[e_speaker.var_f7af1630]);
    }
    function_eee384d4(0);
    level flag::clear("story_vo_playing");
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x4884771c, Offset: 0xa668
// Size: 0xa2
function function_7b775f1b() {
    var_26ba444c = [];
    var_26ba444c["Dempsey"] = "vox_plr_0_end_round_2_1_0";
    var_26ba444c["Nikolai"] = "vox_plr_1_end_round_2_5_0";
    var_26ba444c["Richtofen"] = [];
    var_26ba444c["Richtofen"][0] = "vox_plr_2_end_round_2_2_0";
    var_26ba444c["Richtofen"][1] = "vox_plr_2_end_round_2_3_1";
    var_26ba444c["Takeo"] = "vox_plr_3_end_round_2_4_0";
    return var_26ba444c;
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x1af80bd0, Offset: 0xa718
// Size: 0xf2
function function_a17dbe3b() {
    level flag::wait_till("start_zombie_round_logic");
    magicbox = level.chests[level.chest_index];
    a_players = getplayers();
    foreach (player in a_players) {
        player thread function_2934e128(magicbox.unitrigger_stub);
    }
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x1 linked
// Checksum 0x11a15772, Offset: 0xa818
// Size: 0x5ec
function function_2934e128(struct) {
    self endon(#"disconnect");
    level endon(#"hash_1249dd2c");
    while (true) {
        if (distancesquared(self.origin, struct.origin) < 40000) {
            if (self zm_utility::is_player_looking_at(struct.origin, 0.75)) {
                if (!(isdefined(self.dontspeak) && self.dontspeak)) {
                    if (level flag::get("story_vo_playing")) {
                        wait(0.1);
                        continue;
                    }
                    players = getplayers();
                    a_speakers = [];
                    foreach (player in players) {
                        if (isdefined(player) && distance2dsquared(player.origin, self.origin) <= 1000000) {
                            switch (player.var_f7af1630) {
                            case 407:
                                var_2d13d22c = player;
                                a_speakers[a_speakers.size] = var_2d13d22c;
                                break;
                            case 408:
                                e_nikolai = player;
                                a_speakers[a_speakers.size] = e_nikolai;
                                break;
                            case 399:
                                e_richtofen = player;
                                a_speakers[a_speakers.size] = e_richtofen;
                                break;
                            case 409:
                                var_b3599de7 = player;
                                a_speakers[a_speakers.size] = var_b3599de7;
                                break;
                            }
                        }
                    }
                    if (!isdefined(e_richtofen)) {
                        wait(0.1);
                        continue;
                    }
                    if (a_speakers.size < 2) {
                        wait(0.1);
                        continue;
                    }
                    level flag::set("story_vo_playing");
                    function_eee384d4(1);
                    var_88bbc03e = function_2f073b42();
                    if (isdefined(e_richtofen)) {
                        e_richtofen playsoundwithnotify(var_88bbc03e[0][e_richtofen.var_f7af1630], "sound_done" + var_88bbc03e[0][e_richtofen.var_f7af1630]);
                        e_richtofen waittill("sound_done" + var_88bbc03e[0][e_richtofen.var_f7af1630]);
                    }
                    if (isdefined(struct.trigger_target) && isdefined(struct.trigger_target.is_locked)) {
                        arrayremovevalue(a_speakers, e_richtofen);
                        a_speakers = util::get_array_of_closest(e_richtofen.origin, a_speakers);
                        e_speaker = a_speakers[0];
                        if (distancesquared(e_speaker.origin, e_richtofen.origin) < 2250000) {
                            if (isdefined(e_speaker)) {
                                e_speaker playsoundwithnotify(var_88bbc03e[1][e_speaker.var_f7af1630], "sound_done" + var_88bbc03e[1][e_speaker.var_f7af1630]);
                                e_speaker waittill("sound_done" + var_88bbc03e[1][e_speaker.var_f7af1630]);
                            }
                        }
                    }
                    if (isdefined(struct.trigger_target) && isdefined(struct.trigger_target.is_locked)) {
                        if (struct.trigger_target.is_locked == 1) {
                            if (isdefined(e_richtofen)) {
                                e_richtofen playsoundwithnotify(var_88bbc03e[2][e_richtofen.var_f7af1630], "sound_done" + var_88bbc03e[2][e_richtofen.var_f7af1630]);
                                e_richtofen waittill("sound_done" + var_88bbc03e[2][e_richtofen.var_f7af1630]);
                            }
                        }
                    }
                    function_eee384d4(0);
                    level flag::clear("story_vo_playing");
                    level notify(#"hash_1249dd2c");
                    break;
                }
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x53667bc1, Offset: 0xae10
// Size: 0xcc
function function_2f073b42() {
    var_6887daf = [];
    var_6887daf[0] = [];
    var_6887daf[0]["Richtofen"] = "vox_plr_2_respond_maxis_1_0";
    var_6887daf[1] = [];
    var_6887daf[1]["Dempsey"] = "vox_plr_0_respond_maxis_2_0";
    var_6887daf[1]["Takeo"] = "vox_plr_3_respond_maxis_3_0";
    var_6887daf[1]["Nikolai"] = "vox_plr_1_respond_maxis_4_0";
    var_6887daf[2] = [];
    var_6887daf[2]["Richtofen"] = "vox_plr_2_respond_maxis_5_0";
    return var_6887daf;
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x1 linked
// Checksum 0xcd5d3cfe, Offset: 0xaee8
// Size: 0x2dc
function function_abd59be1(var_3111271f) {
    if (var_3111271f.weaponname.name != "equip_dieseldrone") {
        return;
    }
    level flag::wait_till_clear("story_vo_playing");
    level flag::set("story_vo_playing");
    function_eee384d4(1);
    wait(1);
    var_fe164365 = function_b5a3a27a(self, var_3111271f);
    var_d072a269 = "vox_maxi_maxis_drone_1_0";
    var_fe164365 playsoundwithnotify(var_d072a269, "sound_done" + var_d072a269);
    /#
        iprintln("maxis_audio_log_4" + var_d072a269);
    #/
    var_fe164365 waittill("sound_done" + var_d072a269);
    var_fe164365 delete();
    wait(1);
    var_fe164365 = function_b5a3a27a(self, var_3111271f);
    var_d072a269 = "vox_maxi_maxis_drone_4_0";
    var_fe164365 playsoundwithnotify(var_d072a269, "sound_done" + var_d072a269);
    /#
        iprintln("maxis_audio_log_4" + var_d072a269);
    #/
    var_fe164365 waittill("sound_done" + var_d072a269);
    var_fe164365 delete();
    wait(1);
    if (isdefined(self) && self.var_f7af1630 == "Richtofen") {
        var_d072a269 = "vox_plr_2_maxis_drone_5_0";
        /#
            iprintln("maxis_audio_log_4" + self.var_f7af1630 + "maxis_audio_log_4" + var_d072a269);
        #/
        self playsoundwithnotify(var_d072a269, "sound_done" + var_d072a269);
        self waittill("sound_done" + var_d072a269);
    }
    function_eee384d4(0);
    level flag::clear("story_vo_playing");
    level flag::set("maxis_crafted_intro_done");
}

// Namespace namespace_ad52727b
// Params 2, eflags: 0x1 linked
// Checksum 0x580b6392, Offset: 0xb1d0
// Size: 0x11c
function function_b5a3a27a(player, var_3111271f) {
    var_fe164365 = undefined;
    if (isdefined(level.var_461e417)) {
        var_fe164365 = spawn("script_origin", level.var_461e417.origin);
        var_fe164365 linkto(level.var_461e417);
    } else {
        player = function_b6f6557a();
        if (isdefined(player)) {
            var_fe164365 = spawn("script_origin", player.origin);
            var_fe164365 linkto(player);
        } else {
            var_fe164365 = spawn("script_origin", var_3111271f.origin);
        }
    }
    return var_fe164365;
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xc8740fe5, Offset: 0xb2f8
// Size: 0xdc
function function_b6f6557a() {
    a_players = getplayers();
    var_703e6a13 = getweapon("equip_dieseldrone");
    foreach (player in a_players) {
        if (player hasweapon(var_703e6a13)) {
            return player;
        }
    }
    return undefined;
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x1 linked
// Checksum 0xc08c2b44, Offset: 0xb3e0
// Size: 0x222
function function_eee384d4(bool) {
    players = getplayers();
    if (bool) {
        foreach (player in players) {
            if (isdefined(player)) {
                player.dontspeak = 1;
                player clientfield::set_to_player("isspeaking", 1);
            }
        }
        foreach (player in players) {
            while (isdefined(player.isspeaking) && isdefined(player) && player.isspeaking) {
                wait(0.1);
            }
        }
        return;
    }
    foreach (player in players) {
        if (isdefined(player)) {
            player.dontspeak = 0;
            player clientfield::set_to_player("isspeaking", 0);
        }
    }
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x1 linked
// Checksum 0xea6b7d74, Offset: 0xb610
// Size: 0x9c
function function_c502e741(bool) {
    if (bool) {
        self.dontspeak = 1;
        self clientfield::set_to_player("isspeaking", 1);
        while (isdefined(self.isspeaking) && isdefined(self) && self.isspeaking) {
            wait(0.1);
        }
        return;
    }
    self.dontspeak = 0;
    self clientfield::set_to_player("isspeaking", 0);
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x5e328d43, Offset: 0xb6b8
// Size: 0x3e
function is_game_solo() {
    players = getplayers();
    if (players.size == 1) {
        return 1;
    }
    return 0;
}

// Namespace namespace_ad52727b
// Params 2, eflags: 0x1 linked
// Checksum 0x2a7ec1f6, Offset: 0xb700
// Size: 0x108
function function_446b06b3(var_5d35229c, str_line) {
    if (!isdefined(level.var_e70c2202)) {
        level.var_e70c2202 = [];
        level.var_9717334e = [];
    }
    if (!isdefined(level.var_e70c2202[var_5d35229c])) {
        level.var_e70c2202[var_5d35229c] = [];
        level.var_9717334e[var_5d35229c] = 0;
    }
    if (!isdefined(level.var_e70c2202[var_5d35229c])) {
        level.var_e70c2202[var_5d35229c] = [];
    } else if (!isarray(level.var_e70c2202[var_5d35229c])) {
        level.var_e70c2202[var_5d35229c] = array(level.var_e70c2202[var_5d35229c]);
    }
    level.var_e70c2202[var_5d35229c][level.var_e70c2202[var_5d35229c].size] = str_line;
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x1 linked
// Checksum 0x69c0a4a3, Offset: 0xb810
// Size: 0xec
function function_2af394fb(var_5d35229c) {
    level notify(#"hash_9b82fb76");
    wait(4);
    if (level.var_9717334e[var_5d35229c] >= level.var_e70c2202[var_5d35229c].size) {
        /#
            iprintlnbold("maxis_audio_log_4" + var_5d35229c);
        #/
        return;
    }
    str_line = level.var_e70c2202[var_5d35229c][level.var_9717334e[var_5d35229c]];
    level.var_9717334e[var_5d35229c]++;
    function_eee384d4(1);
    level function_10d15bb5(str_line, self);
    function_eee384d4(0);
}

// Namespace namespace_ad52727b
// Params 5, eflags: 0x1 linked
// Checksum 0x3355b15e, Offset: 0xb908
// Size: 0xc4
function function_f45a2e2c(str_category, str_line, str_notify, var_5d22719a, var_a8dda6bf) {
    if (!isdefined(var_5d22719a)) {
        var_5d22719a = 30;
    }
    if (!isdefined(var_a8dda6bf)) {
        var_a8dda6bf = 100;
    }
    for (i = 0; i < var_a8dda6bf; i++) {
        e_player = level waittill(str_notify);
        if (isdefined(e_player)) {
            e_player zm_audio::create_and_play_dialog(str_category, str_line);
            wait(var_5d22719a);
        }
    }
}

// Namespace namespace_ad52727b
// Params 3, eflags: 0x1 linked
// Checksum 0x8f561de2, Offset: 0xb9d8
// Size: 0x6a
function function_d22bb7(str_category, str_line, str_notify) {
    while (true) {
        e_player = level waittill(str_notify);
        if (isdefined(e_player)) {
            e_player zm_audio::create_and_play_dialog(str_category, str_line);
            return;
        }
    }
}

// Namespace namespace_ad52727b
// Params 2, eflags: 0x1 linked
// Checksum 0x2248fb5f, Offset: 0xba50
// Size: 0xa0
function function_68eb779(str_line, str_notify) {
    while (true) {
        var_afe8a821 = level waittill(str_notify);
        if (isdefined(var_afe8a821)) {
            function_eee384d4(1);
            if (function_10d15bb5(str_line, var_afe8a821)) {
                function_eee384d4(0);
                return;
            }
            function_eee384d4(0);
        }
    }
}

// Namespace namespace_ad52727b
// Params 3, eflags: 0x1 linked
// Checksum 0x5c311956, Offset: 0xbaf8
// Size: 0x372
function function_69744aec(str_line, str_notify, str_endon) {
    if (isdefined(str_endon)) {
        level endon(str_endon);
    }
    if (!isdefined(level.var_34c21a9c)) {
        level.var_34c21a9c = gettime();
    }
    while (true) {
        e_player = level waittill(str_notify);
        wait(10);
        if (isdefined(e_player.var_98401a1a) && isdefined(e_player) && e_player.var_98401a1a) {
            continue;
        }
        while (isdefined(level.var_8c80bd85) && level.var_8c80bd85) {
            util::wait_network_frame();
        }
        if (level.var_34c21a9c > gettime()) {
            continue;
        }
        if (!isplayer(e_player)) {
            a_players = getplayers();
            foreach (player in a_players) {
                if (player.zombie_vars["zombie_powerup_zombie_blood_on"]) {
                    e_player = player;
                    break;
                }
            }
        }
        if (isdefined(e_player) && isplayer(e_player) && e_player.zombie_vars["zombie_powerup_zombie_blood_on"] && level flag::get("samantha_intro_done")) {
            level flag::wait_till_clear("story_vo_playing");
            level flag::set("story_vo_playing");
            while (isdefined(e_player.isspeaking) && e_player.isspeaking) {
                util::wait_network_frame();
            }
            if (!zombie_utility::is_player_valid(e_player)) {
                continue;
            }
            function_eee384d4(1);
            level.var_8c80bd85 = 1;
            e_player playsoundtoplayer(str_line, e_player);
            n_duration = soundgetplaybacktime(str_line);
            wait(n_duration / 1000);
            level.var_8c80bd85 = 0;
            level.var_34c21a9c = gettime() + 300000;
            level flag::clear("story_vo_playing");
            function_eee384d4(0);
            return;
        }
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xce1bc6f7, Offset: 0xbe78
// Size: 0x5c
function function_d37a5bff() {
    n_min_time = 60000 * 5;
    n_max_time = 60000 * 10;
    level.var_b12165e0 = gettime() + randomintrange(n_min_time, n_max_time);
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xdd7058fa, Offset: 0xbee0
// Size: 0x46
function function_23b8bb3a() {
    while (true) {
        e_player = level waittill(#"hash_94845a1");
        wait(1);
        level notify(#"hash_9b82fb76", e_player, 1);
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x0
// Checksum 0xa6c1c564, Offset: 0xbf30
// Size: 0x2e8
function function_19cedda7() {
    var_613f0017 = array("vox_sam_generic_encourage_0", "vox_sam_generic_encourage_1", "vox_sam_generic_encourage_2", "vox_sam_generic_encourage_3", "vox_sam_generic_encourage_4", "vox_sam_generic_encourage_5");
    var_2b846541 = [];
    n_min_time = 60000 * 5;
    n_max_time = 60000 * 10;
    var_f32a5a44 = 0;
    level thread function_23b8bb3a();
    while (true) {
        if (var_2b846541.size == 0) {
            var_2b846541 = arraycopy(var_613f0017);
        }
        e_player = undefined;
        var_968ac53b = 0;
        e_player, var_968ac53b = level waittill(#"hash_9b82fb76");
        function_d37a5bff();
        if (gettime() < var_f32a5a44) {
            continue;
        }
        if (!(isdefined(var_968ac53b) && var_968ac53b)) {
            continue;
        }
        if (!isdefined(e_player)) {
            continue;
        }
        if (!zombie_utility::is_player_valid(e_player)) {
            continue;
        }
        if (isdefined(level.var_8c80bd85) && level.var_8c80bd85) {
            continue;
        }
        while (isdefined(e_player.isspeaking) && (level flag::get("story_vo_playing") || e_player.isspeaking)) {
            util::wait_network_frame();
        }
        line = array::random(var_2b846541);
        arrayremovevalue(var_2b846541, line);
        function_eee384d4(1);
        if (function_10d15bb5(line, e_player, 1)) {
            function_eee384d4(0);
            e_player zm_audio::create_and_play_dialog("puzzle", "encourage_respond");
            var_f32a5a44 = gettime() + randomintrange(n_min_time, n_max_time);
        }
        function_eee384d4(0);
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x0
// Checksum 0xc4c12ab5, Offset: 0xc220
// Size: 0x200
function function_189b086a() {
    level endon(#"hash_6a941ace");
    var_613f0017 = array("vox_sam_generic_chastise_0", "vox_sam_generic_chastise_1", "vox_sam_generic_chastise_2", "vox_sam_generic_chastise_3", "vox_sam_generic_chastise_4", "vox_sam_generic_chastise_5", "vox_sam_generic_chastise_6");
    var_2b846541 = [];
    level flag::wait_till("samantha_intro_done");
    while (true) {
        if (var_2b846541.size == 0) {
            var_2b846541 = arraycopy(var_613f0017);
        }
        function_d37a5bff();
        while (gettime() < level.var_b12165e0) {
            wait(1);
        }
        line = array::random(var_2b846541);
        arrayremovevalue(var_2b846541, line);
        a_players = getplayers();
        while (a_players.size > 0) {
            e_player = array::random(a_players);
            arrayremovevalue(a_players, e_player);
            if (zombie_utility::is_player_valid(e_player)) {
                function_10d15bb5(line, e_player, 1);
                e_player zm_audio::create_and_play_dialog("puzzle", "berate_respond");
                break;
            }
        }
    }
}

// Namespace namespace_ad52727b
// Params 4, eflags: 0x1 linked
// Checksum 0x44be4fd6, Offset: 0xc428
// Size: 0x224
function function_10d15bb5(var_d072a269, e_source, var_e933c020, var_7c3bd5ea) {
    if (!isdefined(var_e933c020)) {
        var_e933c020 = 0;
    }
    if (!isdefined(var_7c3bd5ea)) {
        var_7c3bd5ea = 0;
    }
    level endon(#"end_game");
    if (!var_7c3bd5ea && !level flag::get("samantha_intro_done")) {
        return false;
    } else if (var_7c3bd5ea && level flag::get("samantha_intro_done")) {
        return false;
    }
    while (isdefined(level.var_8c80bd85) && level.var_8c80bd85) {
        util::wait_network_frame();
    }
    level.var_8c80bd85 = 1;
    if (var_e933c020) {
        nearbyplayers = util::get_array_of_closest(e_source.origin, getplayers(), undefined, undefined, 256);
        if (isdefined(nearbyplayers) && nearbyplayers.size > 0) {
            foreach (player in nearbyplayers) {
                while (isdefined(player.isspeaking) && isdefined(player) && player.isspeaking) {
                    wait(0.05);
                }
            }
        }
    }
    level thread function_53cbfb1a(e_source, var_d072a269);
    level waittill(#"hash_b1ac884a");
    return true;
}

// Namespace namespace_ad52727b
// Params 2, eflags: 0x1 linked
// Checksum 0x77ff12e9, Offset: 0xc658
// Size: 0x6a
function function_53cbfb1a(e_source, var_d072a269) {
    e_source playsoundwithnotify(var_d072a269, "sound_done" + var_d072a269);
    e_source waittill("sound_done" + var_d072a269);
    level.var_8c80bd85 = 0;
    level notify(#"hash_b1ac884a");
}

// Namespace namespace_ad52727b
// Params 3, eflags: 0x1 linked
// Checksum 0x2fb50b41, Offset: 0xc6d0
// Size: 0x218
function function_7dc74a72(var_d072a269, var_4d5e8bc4, var_e933c020) {
    level endon(#"end_game");
    level endon(#"intermission");
    if (isdefined(level.intermission) && level.intermission) {
        return;
    }
    if (!level flag::get("maxis_crafted_intro_done")) {
        return;
    }
    while (isdefined(level.var_5b70b522) && level.var_5b70b522) {
        wait(0.05);
    }
    level.var_5b70b522 = 1;
    /#
        iprintlnbold("maxis_audio_log_4" + var_d072a269);
    #/
    if (isdefined(var_4d5e8bc4)) {
        var_bf3d1c37 = var_4d5e8bc4;
    }
    if (isdefined(var_e933c020) && var_e933c020) {
        nearbyplayers = util::get_array_of_closest(var_bf3d1c37.origin, getplayers(), undefined, undefined, 256);
        if (isdefined(nearbyplayers) && nearbyplayers.size > 0) {
            foreach (player in nearbyplayers) {
                while (isdefined(player.isspeaking) && isdefined(player) && player.isspeaking) {
                    wait(0.05);
                }
            }
        }
    }
    level thread function_3beab91(var_bf3d1c37, var_d072a269);
    level waittill(#"hash_be243129");
}

// Namespace namespace_ad52727b
// Params 2, eflags: 0x1 linked
// Checksum 0xbd8ec137, Offset: 0xc8f0
// Size: 0x86
function function_3beab91(var_bf3d1c37, var_d072a269) {
    var_bf3d1c37 playsoundwithnotify(var_d072a269, "sound_done" + var_d072a269);
    var_bf3d1c37 util::waittill_either("sound_done" + var_d072a269, "death");
    level.var_5b70b522 = 0;
    level notify(#"hash_be243129");
}

// Namespace namespace_ad52727b
// Params 3, eflags: 0x1 linked
// Checksum 0xceeee21b, Offset: 0xc980
// Size: 0x724
function function_92121c7d(var_c0a8cd1f, var_a436d6b, str_flag) {
    if (!isdefined(var_a436d6b)) {
        var_a436d6b = 0;
    }
    if (level flag::get("story_vo_playing")) {
        return;
    }
    level flag::set("story_vo_playing");
    function_eee384d4(1);
    if (var_a436d6b) {
        if (self.var_f7af1630 == "Richtofen") {
            var_931cae4d = "vox_plr_" + self.characterindex + "_" + var_c0a8cd1f + "_0";
            self playsoundwithnotify(var_931cae4d, "rich_done");
            self waittill(#"hash_5281316e");
            wait(0.5);
            foreach (player in getplayers()) {
                if (player.var_f7af1630 != "Richtofen" && distance2d(player.origin, self.origin) < 800) {
                    var_931cae4d = "vox_plr_" + player.characterindex + "_" + var_c0a8cd1f + "_0";
                    player playsoundwithnotify(var_931cae4d, "rich_done");
                    player waittill(#"hash_5281316e");
                }
            }
        } else {
            foreach (player in getplayers()) {
                if (player.var_f7af1630 == "Richtofen" && distance2d(player.origin, self.origin) < 800) {
                    var_931cae4d = "vox_plr_" + player.characterindex + "_" + var_c0a8cd1f + "_0";
                    player playsoundwithnotify(var_931cae4d, "rich_done");
                    player waittill(#"hash_5281316e");
                    wait(0.5);
                }
            }
            if (isdefined(self)) {
                var_931cae4d = "vox_plr_" + self.characterindex + "_" + var_c0a8cd1f + "_0";
                self playsoundwithnotify(var_931cae4d, "rich_response");
                self waittill(#"hash_43ab663f");
            }
        }
    } else if (self.characterindex == 2) {
        foreach (player in getplayers()) {
            if (player.var_f7af1630 != "Richtofen" && distance2d(player.origin, self.origin) < 800) {
                var_931cae4d = "vox_plr_" + player.characterindex + "_" + var_c0a8cd1f + "_0";
                player playsoundwithnotify(var_931cae4d, "rich_done");
                player waittill(#"hash_5281316e");
                wait(0.5);
            }
        }
        if (isdefined(self)) {
            var_931cae4d = "vox_plr_" + self.characterindex + "_" + var_c0a8cd1f + "_0";
            self playsoundwithnotify(var_931cae4d, "rich_done");
            self waittill(#"hash_5281316e");
        }
    } else {
        var_931cae4d = "vox_plr_" + self.characterindex + "_" + var_c0a8cd1f + "_0";
        self playsoundwithnotify(var_931cae4d, "rich_response");
        self waittill(#"hash_43ab663f");
        wait(0.5);
        foreach (player in getplayers()) {
            if (player.var_f7af1630 == "Richtofen" && distance2d(player.origin, self.origin) < 800) {
                var_931cae4d = "vox_plr_" + player.characterindex + "_" + var_c0a8cd1f + "_0";
                player playsoundwithnotify(var_931cae4d, "rich_done");
                player waittill(#"hash_5281316e");
            }
        }
    }
    if (isdefined(str_flag)) {
        level flag::set(str_flag);
    }
    function_eee384d4(0);
    level flag::clear("story_vo_playing");
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x607c8a7f, Offset: 0xd0b0
// Size: 0x14c
function function_673d2153() {
    self endon(#"death");
    self endon(#"disconnect");
    if (isdefined(self.var_724f237a) && self.var_724f237a) {
        return;
    }
    if (isdefined(self.var_f7af1630) && self.var_f7af1630 != "Richtofen") {
        return;
    }
    if (level flag::get("story_vo_playing")) {
        return;
    }
    if (isdefined(self.dontspeak) && self.dontspeak) {
        return;
    }
    function_eee384d4(1);
    self.var_724f237a = 1;
    for (i = 1; i < 4; i++) {
        var_d072a269 = "vox_plr_2_discover_wonder_" + i + "_0";
        self playsoundwithnotify(var_d072a269, "sound_done" + var_d072a269);
        self waittill("sound_done" + var_d072a269);
        wait(0.1);
    }
    function_eee384d4(0);
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x66ec1bae, Offset: 0xd208
// Size: 0x3ec
function function_7b9117f8() {
    level.var_c8323f6d["Richtofen_1"][0] = "vox_sam_hear_samantha_2_plr_2_0";
    level.var_c8323f6d["Richtofen_1"][1] = "vox_plr_2_hear_samantha_2_0";
    level.var_c8323f6d["Richtofen_2"][0] = "vox_sam_sam_richtofen_1_0";
    level.var_c8323f6d["Richtofen_2"][1] = "vox_sam_sam_richtofen_2_0";
    level.var_c8323f6d["Richtofen_2"][2] = "vox_plr_2_sam_richtofen_3_0";
    level.var_c8323f6d["Richtofen_3"][0] = "vox_sam_sam_richtofen_4_0";
    level.var_c8323f6d["Richtofen_3"][1] = "vox_plr_2_sam_richtofen_5_0";
    level.var_c8323f6d["Richtofen_3"][2] = "vox_plr_2_sam_richtofen_6_0";
    level.var_c8323f6d["Dempsey_1"][0] = "vox_sam_hear_samantha_2_plr_0_0";
    level.var_c8323f6d["Dempsey_1"][1] = "vox_plr_0_hear_samantha_2_0";
    level.var_c8323f6d["Dempsey_2"][0] = "vox_sam_sam_dempsey_1_0";
    level.var_c8323f6d["Dempsey_2"][1] = "vox_sam_sam_dempsey_1_1";
    level.var_c8323f6d["Dempsey_2"][2] = "vox_plr_0_sam_dempsey_1_0";
    level.var_c8323f6d["Dempsey_3"][0] = "vox_sam_sam_dempsey_2_0";
    level.var_c8323f6d["Dempsey_3"][1] = "vox_sam_sam_dempsey_2_1";
    level.var_c8323f6d["Dempsey_3"][2] = "vox_plr_0_sam_dempsey_2_0";
    level.var_c8323f6d["Nikolai_1"][0] = "vox_sam_hear_samantha_2_plr_1_0";
    level.var_c8323f6d["Nikolai_1"][1] = "vox_plr_1_hear_samantha_2_0";
    level.var_c8323f6d["Nikolai_2"][0] = "vox_sam_sam_nikolai_1_0";
    level.var_c8323f6d["Nikolai_2"][1] = "vox_sam_sam_nikolai_1_1";
    level.var_c8323f6d["Nikolai_2"][2] = "vox_plr_1_sam_nikolai_1_0";
    level.var_c8323f6d["Nikolai_3"][0] = "vox_sam_sam_nikolai_2_0";
    level.var_c8323f6d["Nikolai_3"][1] = "vox_sam_sam_nikolai_2_1";
    level.var_c8323f6d["Nikolai_3"][2] = "vox_plr_1_sam_nikolai_2_0";
    level.var_c8323f6d["Takeo_1"][0] = "vox_sam_hear_samantha_2_plr_3_0";
    level.var_c8323f6d["Takeo_1"][1] = "vox_plr_3_hear_samantha_2_0";
    level.var_c8323f6d["Takeo_2"][0] = "vox_sam_sam_takeo_1_0";
    level.var_c8323f6d["Takeo_2"][1] = "vox_sam_sam_takeo_1_1";
    level.var_c8323f6d["Takeo_2"][2] = "vox_plr_3_sam_takeo_1_0";
    level.var_c8323f6d["Takeo_3"][0] = "vox_sam_sam_takeo_2_0";
    level.var_c8323f6d["Takeo_3"][1] = "vox_sam_sam_takeo_2_1";
    level.var_c8323f6d["Takeo_3"][2] = "vox_plr_3_sam_takeo_2_0";
    level thread function_8fcd12f3();
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x1f36bf92, Offset: 0xd600
// Size: 0x98
function function_8fcd12f3() {
    level flag::wait_till("samantha_intro_done");
    while (true) {
        e_player = level waittill(#"player_zombie_blood");
        a_players = getplayers();
        if (randomint(100) < 20) {
            e_player thread function_29b1ff3b();
        }
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xa66ea7c3, Offset: 0xd6a0
// Size: 0x17e
function function_29b1ff3b() {
    self endon(#"disconnect");
    self.var_98401a1a = 1;
    wait(3);
    if (!isdefined(self.var_c3ecc4d6)) {
        self.var_c3ecc4d6 = 1;
    }
    if (isdefined(self.var_aa07f091) && (self.var_c3ecc4d6 > 3 || self.var_aa07f091) || level flag::get("story_vo_playing")) {
        self.var_98401a1a = undefined;
        return;
    }
    var_478beed7 = level.var_c8323f6d[self.var_f7af1630 + "_" + self.var_c3ecc4d6];
    self.var_c3ecc4d6++;
    self thread function_6e96b671();
    level.var_8c80bd85 = 1;
    self function_c502e741(1);
    level flag::set("story_vo_playing");
    self function_203a8f5e(var_478beed7);
    level.var_8c80bd85 = 0;
    self function_c502e741(0);
    level flag::clear("story_vo_playing");
    self.var_98401a1a = undefined;
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x1 linked
// Checksum 0x8aeddf88, Offset: 0xd828
// Size: 0x15a
function function_203a8f5e(var_478beed7) {
    for (i = 0; i < var_478beed7.size; i++) {
        self endon(#"zombie_blood_over");
        self endon(#"disconnect");
        if (issubstr(var_478beed7[i], "sam_sam") || issubstr(var_478beed7[i], "samantha")) {
            self thread function_ed60a84e(var_478beed7[i]);
            self playsoundtoplayer(var_478beed7[i], self);
            n_duration = soundgetplaybacktime(var_478beed7[i]);
            wait(n_duration / 1000);
            self notify(#"hash_c856f4b1");
        } else {
            self playsoundwithnotify(var_478beed7[i], "player_done");
            self waittill(#"hash_3169a65d");
        }
        wait(0.3);
    }
}

// Namespace namespace_ad52727b
// Params 1, eflags: 0x1 linked
// Checksum 0x74e22504, Offset: 0xd990
// Size: 0x64
function function_ed60a84e(str_alias) {
    self notify(#"hash_c856f4b1");
    self endon(#"hash_c856f4b1");
    while (self.zombie_vars["zombie_powerup_zombie_blood_on"]) {
        wait(0.05);
    }
    self stoplocalsound(str_alias);
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x88327bb4, Offset: 0xda00
// Size: 0x32
function function_6e96b671() {
    self endon(#"disconnect");
    self.var_aa07f091 = 1;
    level waittill(#"end_of_round");
    self.var_aa07f091 = undefined;
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0xa6728923, Offset: 0xda40
// Size: 0xec
function function_860b0710() {
    self endon(#"death");
    if (randomintrange(0, 100) < 20) {
        var_931cae4d = "vox_maxi_drone_killed_" + randomintrange(0, 3);
        self function_7dc74a72(var_931cae4d, self);
        var_f813a897 = util::get_array_of_closest(self.origin, getplayers(), undefined, undefined, 256);
        if (isdefined(var_f813a897[0])) {
            var_f813a897[0] zm_audio::create_and_play_dialog("quadrotor", "kill_drone");
        }
    }
}

// Namespace namespace_ad52727b
// Params 0, eflags: 0x1 linked
// Checksum 0x9c205edc, Offset: 0xdb38
// Size: 0x118
function function_a808bc8e() {
    self endon(#"death");
    if (!isdefined(level.var_450ee971)) {
        level.var_450ee971 = [];
        for (i = 0; i < 9; i++) {
            level.var_450ee971[i] = i;
        }
        level.var_450ee971 = array::randomize(level.var_450ee971);
    }
    while (true) {
        if (!isdefined(level.var_450ee971[0])) {
            return;
        }
        wait(randomintrange(20, 40));
        var_931cae4d = "vox_maxi_drone_ambient_" + level.var_450ee971[0];
        self function_7dc74a72(var_931cae4d, self);
        level.var_450ee971 = array::remove_index(level.var_450ee971, 0);
    }
}

