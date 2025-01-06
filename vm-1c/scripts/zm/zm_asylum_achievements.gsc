#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;

#namespace zm_asylum_achievements;

// Namespace zm_asylum_achievements
// Params 0, eflags: 0x2
// Checksum 0xc1cfa716, Offset: 0x248
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_theater_achievements", &__init__, undefined, undefined);
}

// Namespace zm_asylum_achievements
// Params 0, eflags: 0x0
// Checksum 0xd9694411, Offset: 0x288
// Size: 0x74
function __init__() {
    level.achievement_sound_func = &achievement_sound_func;
    level thread function_fa4b9452();
    zm_spawner::register_zombie_death_event_callback(&function_1abfde35);
    callback::on_connect(&onplayerconnect);
}

// Namespace zm_asylum_achievements
// Params 1, eflags: 0x0
// Checksum 0x81ab4fb3, Offset: 0x308
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

// Namespace zm_asylum_achievements
// Params 0, eflags: 0x0
// Checksum 0x6537573d, Offset: 0x3c0
// Size: 0x34
function onplayerconnect() {
    self thread function_a90f7ab8();
    self thread function_9c59bc3();
}

// Namespace zm_asylum_achievements
// Params 0, eflags: 0x0
// Checksum 0x14f87900, Offset: 0x400
// Size: 0x8a
function function_fa4b9452() {
    level endon(#"end_game");
    level waittill(#"start_of_round");
    while (level.round_number < 5 && !level flag::get("power_on")) {
        level function_64c5daf7();
    }
    if (level flag::get("power_on")) {
        /#
        #/
    }
}

// Namespace zm_asylum_achievements
// Params 0, eflags: 0x0
// Checksum 0x301f0a68, Offset: 0x498
// Size: 0x28
function function_64c5daf7() {
    level endon(#"end_game");
    level endon(#"power_on");
    level waittill(#"end_of_round");
}

// Namespace zm_asylum_achievements
// Params 0, eflags: 0x0
// Checksum 0x424269c7, Offset: 0x4c8
// Size: 0x5c
function function_a90f7ab8() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self.var_2418ad9a = 20;
    self waittill(#"hash_fadd25a2");
    /#
    #/
    self zm_utility::giveachievement_wrapper("ZM_ASYLUM_ACTED_ALONE", 0);
}

// Namespace zm_asylum_achievements
// Params 0, eflags: 0x0
// Checksum 0x81abb22a, Offset: 0x530
// Size: 0x4c
function function_9c59bc3() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self.var_83a6b1fd = 0;
    self thread function_a366eb3e();
    self waittill(#"hash_c0226895");
    /#
    #/
}

// Namespace zm_asylum_achievements
// Params 0, eflags: 0x0
// Checksum 0xad0fc81b, Offset: 0x588
// Size: 0x56
function function_a366eb3e() {
    level endon(#"end_game");
    self endon(#"disconnect");
    self endon(#"hash_c0226895");
    while (self.var_83a6b1fd < 50) {
        self waittill(#"zombie_zapped");
    }
    self notify(#"hash_c0226895");
}

// Namespace zm_asylum_achievements
// Params 1, eflags: 0x0
// Checksum 0x38ff8fe9, Offset: 0x5e8
// Size: 0x24c
function function_1abfde35(e_attacker) {
    if (isdefined(e_attacker) && isdefined(e_attacker.var_83a6b1fd) && e_attacker.var_83a6b1fd < 50 && isdefined(self.damageweapon)) {
        if (self.damageweapon == level.var_168d703f || self.damageweapon == level.var_168d703f) {
            e_attacker.var_83a6b1fd++;
        }
        if (e_attacker.var_83a6b1fd >= 50) {
            e_attacker notify(#"hash_c0226895");
        }
    }
    if (isdefined(e_attacker) && isdefined(e_attacker.var_2418ad9a) && e_attacker.var_2418ad9a > 0) {
        if (!isdefined(self.damagelocation)) {
            return;
        }
        if (!(isdefined(zm_utility::is_headshot(self.damageweapon, self.damagelocation, self.damagemod)) && zm_utility::is_headshot(self.damageweapon, self.damagelocation, self.damagemod))) {
            return;
        }
        var_52df56de = getent("area_courtyard", "targetname");
        if (!(isdefined(self istouching(var_52df56de)) && self istouching(var_52df56de))) {
            return;
        }
        str_zone = e_attacker zm_zonemgr::get_player_zone();
        var_1486ce13 = strtok(str_zone, "_");
        if (var_1486ce13[1] != "upstairs") {
            return;
        }
        e_attacker.var_2418ad9a--;
        if (e_attacker.var_2418ad9a <= 0) {
            e_attacker notify(#"hash_fadd25a2");
        }
    }
}

