#using scripts/zm/gametypes/_globallogic_score;
#using scripts/zm/_zm_utility;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb_achievement;

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0x2832ffef, Offset: 0x4a8
// Size: 0x84
function init() {
    level thread function_c0e30c1f();
    level thread function_9463c8dc();
    level thread function_494fa6de();
    level.achievement_sound_func = &achievement_sound_func;
    callback::on_connect(&onplayerconnect);
}

// Namespace zm_tomb_achievement
// Params 1, eflags: 0x1 linked
// Checksum 0xc70cac1, Offset: 0x538
// Size: 0xac
function achievement_sound_func(var_43e4662) {
    self endon(#"disconnect");
    if (!sessionmodeisonlinegame()) {
        return;
    }
    for (i = 0; i < self getentitynumber() + 1; i++) {
        util::wait_network_frame();
    }
    self thread zm_utility::do_player_general_vox("general", "achievement");
}

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0x194e32cb, Offset: 0x5f0
// Size: 0x15c
function function_477a1c55() {
    if (!zm_utility::is_gametype_active("zclassic")) {
        return;
    }
    self globallogic_score::initpersstat("zm_dlc4_tomb_sidequest", 0);
    self globallogic_score::initpersstat("zm_dlc4_not_a_gold_digger", 0);
    self globallogic_score::initpersstat("zm_dlc4_all_your_base", 0);
    self globallogic_score::initpersstat("zm_dlc4_kung_fu_grip", 0);
    self globallogic_score::initpersstat("zm_dlc4_playing_with_power", 0);
    self globallogic_score::initpersstat("zm_dlc4_im_on_a_tank", 0);
    self globallogic_score::initpersstat("zm_dlc4_saving_the_day_all_day", 0);
    self globallogic_score::initpersstat("zm_dlc4_master_of_disguise", 0);
    self globallogic_score::initpersstat("zm_dlc4_overachiever", 0);
    self globallogic_score::initpersstat("zm_dlc4_master_wizard", 0);
}

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0xa54df963, Offset: 0x758
// Size: 0xac
function onplayerconnect() {
    self thread function_f624535a();
    self thread function_e337bcb3();
    self thread function_814989cc();
    self thread function_6373ace7();
    self thread function_8d8c3a31();
    self thread function_c883541b();
    self thread function_b69ab1e6();
}

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0x696681c6, Offset: 0x810
// Size: 0x44
function function_c0e30c1f() {
    level endon(#"end_game");
    level waittill(#"hash_1fd5ee2f");
    /#
    #/
    level zm_utility::giveachievement_wrapper("ZM_DLC4_TOMB_SIDEQUEST", 1);
}

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0x3bd4dd9, Offset: 0x860
// Size: 0x44
function function_9463c8dc() {
    level endon(#"end_game");
    level waittill(#"hash_aab28721");
    /#
    #/
    level zm_utility::giveachievement_wrapper("ZM_DLC4_ALL_YOUR_BASE", 1);
}

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0x27539a04, Offset: 0x8b0
// Size: 0x30
function function_494fa6de() {
    level endon(#"end_game");
    level flag::wait_till("ee_all_staffs_crafted");
    /#
    #/
}

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0x55a22d2f, Offset: 0x8e8
// Size: 0x4c
function function_b69ab1e6() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"all_challenges_complete");
    /#
    #/
    self zm_utility::giveachievement_wrapper("ZM_DLC4_OVERACHIEVER");
}

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0x823957c6, Offset: 0x940
// Size: 0x2c
function function_f624535a() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"hash_f8352f34");
    /#
    #/
}

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0x3ab4ac5e, Offset: 0x978
// Size: 0x40
function function_e337bcb3() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self util::waittill_multiple("mechz_grab_released_self", "mechz_grab_released_friendly");
    /#
    #/
}

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0xae460701, Offset: 0x9c0
// Size: 0x2c
function function_814989cc() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self waittill(#"hash_e0809b23");
    /#
    #/
}

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0x91647976, Offset: 0x9f8
// Size: 0x50
function function_6373ace7() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self util::waittill_multiple("revived_player", "quick_revived_player", "revived_player_with_quadrotor", "revived_player_with_upgraded_staff");
    /#
    #/
}

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0x1eca61fb, Offset: 0xa50
// Size: 0x136
function function_180fecea() {
    self endon(#"zombie_blood_over");
    var_844b6d72 = 0;
    if (!isdefined(self.var_ab66a9a1)) {
        self.var_ab66a9a1 = 0;
    }
    if (!isdefined(self.var_283076a9)) {
        self.var_283076a9 = 0;
    }
    var_c21ce200 = 0;
    n_revives = 0;
    while (true) {
        str_action = util::waittill_any_return("completed_zone_capture", "do_revive_ended_normally", "revived_player_with_quadrotor", "revived_player_with_upgraded_staff", "zombie_blood_over");
        if (issubstr(str_action, "revive")) {
            self.var_ab66a9a1++;
        } else if (str_action == "completed_zone_capture") {
            self.var_283076a9++;
        }
        if (self.var_283076a9 > 0 && self.var_ab66a9a1 >= 3) {
            return 1;
        }
    }
}

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0xfe5ea9ea, Offset: 0xb90
// Size: 0x6e
function function_8d8c3a31() {
    level endon(#"end_game");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"zombie_blood");
        var_844b6d72 = self function_180fecea();
        if (isdefined(var_844b6d72) && var_844b6d72) {
            break;
        }
    }
    /#
    #/
}

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0x8538899, Offset: 0xc08
// Size: 0xfe
function function_ac3cfb4b() {
    self endon(#"disconnect");
    self endon(#"hash_f96b5911");
    while (true) {
        w_weapon = self waittill(#"weapon_change");
        if (self.sessionstate != "playing") {
            continue;
        }
        str_weapon = w_weapon.name;
        if (str_weapon == "staff_water") {
            self notify(#"upgraded_water_staff_equipped");
            continue;
        }
        if (str_weapon == "staff_lightning") {
            self notify(#"upgraded_lightning_staff_equipped");
            continue;
        }
        if (str_weapon == "staff_fire") {
            self notify(#"upgraded_fire_staff_equipped");
            continue;
        }
        if (str_weapon == "staff_air") {
            self notify(#"upgraded_air_staff_equipped");
        }
    }
}

// Namespace zm_tomb_achievement
// Params 0, eflags: 0x1 linked
// Checksum 0xdc2d3c8a, Offset: 0xd10
// Size: 0x76
function function_c883541b() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self thread function_ac3cfb4b();
    self util::waittill_multiple("upgraded_air_staff_equipped", "upgraded_lightning_staff_equipped", "upgraded_water_staff_equipped", "upgraded_fire_staff_equipped");
    self notify(#"hash_f96b5911");
    /#
    #/
}

