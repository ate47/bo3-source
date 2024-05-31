#using scripts/codescripts/struct;

#namespace zm_mgturret;

// Namespace zm_mgturret
// Params 0, eflags: 0x0
// namespace_629dbab<file_0>::function_d290ebfa
// Checksum 0x35bcd110, Offset: 0x168
// Size: 0xce
function main() {
    if (getdvarstring("mg42") == "") {
        setdvar("mgTurret", "off");
    }
    level.magic_distance = 24;
    turretinfos = getentarray("turretInfo", "targetname");
    for (index = 0; index < turretinfos.size; index++) {
        turretinfos[index] delete();
    }
}

// Namespace zm_mgturret
// Params 1, eflags: 0x0
// namespace_629dbab<file_0>::function_2cbbd6c9
// Checksum 0xbf49ffea, Offset: 0x240
// Size: 0x136
function set_difficulty(difficulty) {
    init_turret_difficulty_settings();
    turrets = getentarray("misc_turret", "classname");
    for (index = 0; index < turrets.size; index++) {
        if (isdefined(turrets[index].script_skilloverride)) {
            switch (turrets[index].script_skilloverride) {
            case 8:
                difficulty = "easy";
                break;
            case 9:
                difficulty = "medium";
                break;
            case 10:
                difficulty = "hard";
                break;
            case 11:
                difficulty = "fu";
                break;
            default:
                continue;
            }
        }
        turret_set_difficulty(turrets[index], difficulty);
    }
}

// Namespace zm_mgturret
// Params 0, eflags: 0x1 linked
// namespace_629dbab<file_0>::function_f2710fd4
// Checksum 0x60546273, Offset: 0x380
// Size: 0x2c4
function init_turret_difficulty_settings() {
    level.mgturretsettings["easy"]["convergenceTime"] = 2.5;
    level.mgturretsettings["easy"]["suppressionTime"] = 3;
    level.mgturretsettings["easy"]["accuracy"] = 0.38;
    level.mgturretsettings["easy"]["aiSpread"] = 2;
    level.mgturretsettings["easy"]["playerSpread"] = 0.5;
    level.mgturretsettings["medium"]["convergenceTime"] = 1.5;
    level.mgturretsettings["medium"]["suppressionTime"] = 3;
    level.mgturretsettings["medium"]["accuracy"] = 0.38;
    level.mgturretsettings["medium"]["aiSpread"] = 2;
    level.mgturretsettings["medium"]["playerSpread"] = 0.5;
    level.mgturretsettings["hard"]["convergenceTime"] = 0.8;
    level.mgturretsettings["hard"]["suppressionTime"] = 3;
    level.mgturretsettings["hard"]["accuracy"] = 0.38;
    level.mgturretsettings["hard"]["aiSpread"] = 2;
    level.mgturretsettings["hard"]["playerSpread"] = 0.5;
    level.mgturretsettings["fu"]["convergenceTime"] = 0.4;
    level.mgturretsettings["fu"]["suppressionTime"] = 3;
    level.mgturretsettings["fu"]["accuracy"] = 0.38;
    level.mgturretsettings["fu"]["aiSpread"] = 2;
    level.mgturretsettings["fu"]["playerSpread"] = 0.5;
}

// Namespace zm_mgturret
// Params 2, eflags: 0x1 linked
// namespace_629dbab<file_0>::function_34de2b92
// Checksum 0x71a3412, Offset: 0x650
// Size: 0xc8
function turret_set_difficulty(turret, difficulty) {
    turret.convergencetime = level.mgturretsettings[difficulty]["convergenceTime"];
    turret.suppressiontime = level.mgturretsettings[difficulty]["suppressionTime"];
    turret.accuracy = level.mgturretsettings[difficulty]["accuracy"];
    turret.aispread = level.mgturretsettings[difficulty]["aiSpread"];
    turret.playerspread = level.mgturretsettings[difficulty]["playerSpread"];
}

// Namespace zm_mgturret
// Params 1, eflags: 0x0
// namespace_629dbab<file_0>::function_4584a25e
// Checksum 0x83d70fd1, Offset: 0x720
// Size: 0xc4
function turret_suppression_fire(targets) {
    self endon(#"death");
    self endon(#"stop_suppression_fire");
    if (!isdefined(self.suppresionfire)) {
        self.suppresionfire = 1;
    }
    for (;;) {
        while (self.suppresionfire) {
            self settargetentity(targets[randomint(targets.size)]);
            wait(2 + randomfloat(2));
        }
        self cleartargetentity();
        while (!self.suppresionfire) {
            wait(1);
        }
    }
}

// Namespace zm_mgturret
// Params 1, eflags: 0x1 linked
// namespace_629dbab<file_0>::function_a6ee2100
// Checksum 0xaab9269d, Offset: 0x7f0
// Size: 0x76
function burst_fire_settings(setting) {
    if (setting == "delay") {
        return 0.2;
    }
    if (setting == "delay_range") {
        return 0.5;
    }
    if (setting == "burst") {
        return 0.5;
    }
    if (setting == "burst_range") {
        return 4;
    }
}

// Namespace zm_mgturret
// Params 2, eflags: 0x0
// namespace_629dbab<file_0>::function_2b08cd30
// Checksum 0x50606535, Offset: 0x870
// Size: 0x24a
function burst_fire(turret, manual_target) {
    turret endon(#"death");
    turret endon(#"stopfiring");
    self endon(#"stop_using_built_in_burst_fire");
    if (isdefined(turret.script_delay_min)) {
        turret_delay = turret.script_delay_min;
    } else {
        turret_delay = burst_fire_settings("delay");
    }
    if (isdefined(turret.script_delay_max)) {
        turret_delay_range = turret.script_delay_max - turret_delay;
    } else {
        turret_delay_range = burst_fire_settings("delay_range");
    }
    if (isdefined(turret.script_burst_min)) {
        turret_burst = turret.script_burst_min;
    } else {
        turret_burst = burst_fire_settings("burst");
    }
    if (isdefined(turret.script_burst_max)) {
        turret_burst_range = turret.script_burst_max - turret_burst;
    } else {
        turret_burst_range = burst_fire_settings("burst_range");
    }
    while (true) {
        turret startfiring();
        if (isdefined(manual_target)) {
            turret thread random_spread(manual_target);
        }
        turret do_shoot();
        wait(turret_burst + randomfloat(turret_burst_range));
        turret function_beb0f764();
        turret stopfiring();
        wait(turret_delay + randomfloat(turret_delay_range));
    }
}

// Namespace zm_mgturret
// Params 0, eflags: 0x0
// namespace_629dbab<file_0>::function_d8f74413
// Checksum 0xce8b1be, Offset: 0xac8
// Size: 0x37c
function burst_fire_unmanned() {
    self notify(#"stop_burst_fire_unmanned");
    self endon(#"stop_burst_fire_unmanned");
    self endon(#"death");
    self endon(#"remote_start");
    level endon(#"game_ended");
    if (isdefined(self.controlled) && self.controlled) {
        return;
    }
    if (isdefined(self.script_delay_min)) {
        turret_delay = self.script_delay_min;
    } else {
        turret_delay = burst_fire_settings("delay");
    }
    if (isdefined(self.script_delay_max)) {
        turret_delay_range = self.script_delay_max - turret_delay;
    } else {
        turret_delay_range = burst_fire_settings("delay_range");
    }
    if (isdefined(self.script_burst_min)) {
        turret_burst = self.script_burst_min;
    } else {
        turret_burst = burst_fire_settings("burst");
    }
    if (isdefined(self.script_burst_max)) {
        turret_burst_range = self.script_burst_max - turret_burst;
    } else {
        turret_burst_range = burst_fire_settings("burst_range");
    }
    pauseuntiltime = gettime();
    turretstate = "start";
    self.script_shooting = 0;
    for (;;) {
        if (isdefined(self.manual_targets)) {
            self cleartargetentity();
            self settargetentity(self.manual_targets[randomint(self.manual_targets.size)]);
        }
        duration = (pauseuntiltime - gettime()) * 0.001;
        if (self isfiringturret() && duration <= 0) {
            if (turretstate != "fire") {
                turretstate = "fire";
                self playsound("mpl_turret_alert");
                self thread do_shoot();
                self.script_shooting = 1;
            }
            duration = turret_burst + randomfloat(turret_burst_range);
            self thread turret_timer(duration);
            self waittill(#"turretstatechange");
            self.script_shooting = 0;
            duration = turret_delay + randomfloat(turret_delay_range);
            pauseuntiltime = gettime() + int(duration * 1000);
            continue;
        }
        if (turretstate != "aim") {
            turretstate = "aim";
        }
        self thread turret_timer(duration);
        self waittill(#"turretstatechange");
    }
}

// Namespace zm_mgturret
// Params 1, eflags: 0x1 linked
// namespace_629dbab<file_0>::function_f66d420d
// Checksum 0x33ae99ac, Offset: 0xe50
// Size: 0x3c
function avoid_synchronization(time) {
    if (!isdefined(level._zm_mgturret_firing)) {
        level._zm_mgturret_firing = 0;
    }
    level._zm_mgturret_firing++;
    wait(time);
    level._zm_mgturret_firing--;
}

// Namespace zm_mgturret
// Params 0, eflags: 0x1 linked
// namespace_629dbab<file_0>::function_3d40493e
// Checksum 0x9e8260b2, Offset: 0xe98
// Size: 0x80
function do_shoot() {
    self endon(#"death");
    self endon(#"turretstatechange");
    for (;;) {
        while (isdefined(level._zm_mgturret_firing) && level._zm_mgturret_firing) {
            wait(0.1);
        }
        thread avoid_synchronization(0.1);
        self shootturret();
        wait(0.112);
    }
}

// Namespace zm_mgturret
// Params 1, eflags: 0x1 linked
// namespace_629dbab<file_0>::function_b353569
// Checksum 0xfacae9f2, Offset: 0xf20
// Size: 0x42
function turret_timer(duration) {
    if (duration <= 0) {
        return;
    }
    self endon(#"turretstatechange");
    wait(duration);
    if (isdefined(self)) {
        self notify(#"turretstatechange");
    }
}

// Namespace zm_mgturret
// Params 1, eflags: 0x1 linked
// namespace_629dbab<file_0>::function_c47b9502
// Checksum 0xd18a1c08, Offset: 0xf70
// Size: 0x13c
function random_spread(ent) {
    self endon(#"death");
    self notify(#"hash_d175a918");
    self endon(#"hash_d175a918");
    self endon(#"stopfiring");
    self settargetentity(ent);
    self.manual_target = ent;
    while (true) {
        if (isplayer(ent)) {
            ent.origin = self.manual_target getorigin();
        } else {
            ent.origin = self.manual_target.origin;
        }
        ent.origin += (20 - randomfloat(40), 20 - randomfloat(40), 20 - randomfloat(60));
        wait(0.2);
    }
}

