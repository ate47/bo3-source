#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_mgturret;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_auto_turret;

// Namespace zm_auto_turret
// Params 0, eflags: 0x2
// Checksum 0xf5b558f6, Offset: 0x368
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_auto_turret", &__init__, &__main__, undefined);
}

// Namespace zm_auto_turret
// Params 0, eflags: 0x0
// Checksum 0xa60780de, Offset: 0x3b0
// Size: 0x3c
function __init__() {
    level._effect["auto_turret_light"] = "dlc4/genesis/fx_light_turret_auto";
    zm_spawner::register_zombie_death_event_callback(&death_check_for_challenge_updates);
}

// Namespace zm_auto_turret
// Params 0, eflags: 0x0
// Checksum 0x86485f0, Offset: 0x3f8
// Size: 0x17e
function __main__() {
    level.var_c261c043 = getentarray("auto_turret_trigger", "script_noteworthy");
    if (!isdefined(level.var_c261c043)) {
        return;
    }
    level.var_7fe8f906 = 0;
    if (!isdefined(level.var_1002d56a)) {
        level.var_1002d56a = 2;
    }
    if (!isdefined(level.var_64c3a5b3)) {
        level.var_64c3a5b3 = 1500;
    }
    if (!isdefined(level.var_b3e61155)) {
        level.var_b3e61155 = 30;
    }
    for (i = 0; i < level.var_c261c043.size; i++) {
        level.var_c261c043[i] setcursorhint("HINT_NOICON");
        level.var_c261c043[i] sethintstring(%ZOMBIE_NEED_POWER);
        level.var_c261c043[i] usetriggerrequirelookat();
        level.var_c261c043[i].curr_time = -1;
        level.var_c261c043[i].turret_active = 0;
        level.var_c261c043[i] thread function_88738224();
    }
}

// Namespace zm_auto_turret
// Params 0, eflags: 0x0
// Checksum 0x68846215, Offset: 0x580
// Size: 0x3f8
function function_88738224() {
    if (!isdefined(self.target)) {
        return;
    }
    var_486b0ee9 = getentarray(self.target, "targetname");
    if (isdefined(self.target)) {
        for (i = 0; i < var_486b0ee9.size; i++) {
            if (var_486b0ee9[i].model == "zombie_zapper_handle") {
                self.handle = var_486b0ee9[i];
                continue;
            }
            if (var_486b0ee9[i].classname == "script_vehicle") {
                self.turret = var_486b0ee9[i];
                self.turret vehicle_ai::turnoff();
                self.turret._trap_type = "auto_turret";
            }
        }
    }
    if (!isdefined(self.turret)) {
        return;
    }
    self.turret.takedamage = 0;
    self.var_f2b1cc72 = self.origin;
    if (isdefined(level.var_774896e3)) {
        level flag::wait_till(level.var_774896e3);
    } else {
        level flag::wait_till("power_on");
    }
    for (;;) {
        cost = level.var_64c3a5b3;
        self sethintstring(%ZOMBIE_AUTO_TURRET, cost);
        self waittill(#"trigger", player);
        index = zm_utility::get_player_index(player);
        if (player laststand::player_is_in_laststand()) {
            continue;
        }
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (!player zm_score::can_player_purchase(cost)) {
            self playsound("zmb_turret_deny");
            player thread function_f422b6a2();
            continue;
        }
        player zm_score::minus_to_player_score(cost);
        self.turret.activated_by_player = player;
        self thread function_7b9aea27();
        var_736ddf4 = spawn("script_origin", self.origin);
        playsoundatposition("zmb_cha_ching", self.origin);
        playsoundatposition("zmb_turret_startup", self.origin);
        var_736ddf4 playloopsound("zmb_turret_loop");
        self triggerenable(0);
        self waittill(#"hash_d7f84474");
        var_736ddf4 stoploopsound();
        playsoundatposition("zmb_turret_down", self.var_f2b1cc72);
        var_736ddf4 delete();
        self triggerenable(1);
    }
}

// Namespace zm_auto_turret
// Params 0, eflags: 0x0
// Checksum 0xef9400c4, Offset: 0x980
// Size: 0xa4
function function_87d3b877() {
    if (isdefined(self.handle)) {
        self.handle rotatepitch(-96, 0.5);
        self.handle playsound("amb_sparks_l_b");
        self.handle waittill(#"rotatedone");
        self notify(#"switch_activated");
        self waittill(#"hash_d7f84474");
        self.handle rotatepitch(-160, 0.5);
    }
}

// Namespace zm_auto_turret
// Params 0, eflags: 0x0
// Checksum 0x84560205, Offset: 0xa30
// Size: 0x2c
function function_f422b6a2() {
    self zm_audio::create_and_play_dialog("general", "outofmoney");
}

// Namespace zm_auto_turret
// Params 0, eflags: 0x0
// Checksum 0x859a9434, Offset: 0xa68
// Size: 0x29c
function function_7b9aea27() {
    self endon(#"hash_d7f84474");
    if (level.var_1002d56a <= 0) {
        return;
    }
    while (level.var_7fe8f906 >= level.var_1002d56a) {
        var_9fd32ad3 = undefined;
        var_e9da7021 = -1;
        for (i = 0; i < level.var_c261c043.size; i++) {
            if (level.var_c261c043[i] == self) {
                continue;
            }
            if (!level.var_c261c043[i].turret_active) {
                continue;
            }
            if (var_e9da7021 < 0 || level.var_c261c043[i].curr_time < var_e9da7021) {
                var_9fd32ad3 = level.var_c261c043[i];
                var_e9da7021 = level.var_c261c043[i].curr_time;
            }
        }
        if (isdefined(var_9fd32ad3)) {
            var_9fd32ad3 function_ea0dbe46();
            continue;
        }
        assert(0, "<dev string:x28>");
    }
    self.turret vehicle_ai::turnon();
    self.turret_active = 1;
    self.var_e4e74a64 = util::spawn_model("tag_origin", self.turret.origin, self.turret.angles);
    playfxontag(level._effect["auto_turret_light"], self.var_e4e74a64, "tag_origin");
    if (isdefined(self.turret.activated_by_player)) {
        self.turret.activated_by_player thread zm_audio::create_and_play_dialog("auto_turret", "activated");
    }
    self.curr_time = level.var_b3e61155;
    self thread function_2eb14263();
    wait level.var_b3e61155;
    self function_ea0dbe46();
}

// Namespace zm_auto_turret
// Params 0, eflags: 0x0
// Checksum 0x743dca14, Offset: 0xd10
// Size: 0x72
function function_ea0dbe46() {
    self.turret_active = 0;
    self.curr_time = -1;
    self.turret vehicle_ai::turnoff();
    self.turret notify(#"stop_burst_fire_unmanned");
    self.var_e4e74a64 delete();
    self notify(#"hash_d7f84474");
}

// Namespace zm_auto_turret
// Params 0, eflags: 0x0
// Checksum 0x56462e8a, Offset: 0xd90
// Size: 0x30
function function_2eb14263() {
    self endon(#"hash_d7f84474");
    while (self.curr_time > 0) {
        wait 1;
        self.curr_time--;
    }
}

// Namespace zm_auto_turret
// Params 1, eflags: 0x0
// Checksum 0x84a913ea, Offset: 0xdc8
// Size: 0x6c
function death_check_for_challenge_updates(e_attacker) {
    if (!isdefined(e_attacker)) {
        return;
    }
    if (e_attacker._trap_type === "auto_turret") {
        if (isdefined(e_attacker.activated_by_player)) {
            e_attacker.activated_by_player zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_TRAP");
        }
    }
}

