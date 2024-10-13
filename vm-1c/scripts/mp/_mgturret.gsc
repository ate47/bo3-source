#using scripts/codescripts/struct;

#namespace mgturret;

// Namespace mgturret
// Params 0, eflags: 0x0
// Checksum 0xf9016ea1, Offset: 0x160
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

// Namespace mgturret
// Params 1, eflags: 0x0
// Checksum 0x56048da8, Offset: 0x238
// Size: 0x136
function set_difficulty(difficulty) {
    init_turret_difficulty_settings();
    turrets = getentarray("misc_turret", "classname");
    for (index = 0; index < turrets.size; index++) {
        if (isdefined(turrets[index].script_skilloverride)) {
            switch (turrets[index].script_skilloverride) {
            case "easy":
                difficulty = "easy";
                break;
            case "medium":
                difficulty = "medium";
                break;
            case "hard":
                difficulty = "hard";
                break;
            case "fu":
                difficulty = "fu";
                break;
            default:
                continue;
            }
        }
        turret_set_difficulty(turrets[index], difficulty);
    }
}

// Namespace mgturret
// Params 0, eflags: 0x0
// Checksum 0xf0e40869, Offset: 0x378
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

// Namespace mgturret
// Params 2, eflags: 0x0
// Checksum 0x5ab4a294, Offset: 0x648
// Size: 0xc8
function turret_set_difficulty(turret, difficulty) {
    turret.convergencetime = level.mgturretsettings[difficulty]["convergenceTime"];
    turret.suppressiontime = level.mgturretsettings[difficulty]["suppressionTime"];
    turret.accuracy = level.mgturretsettings[difficulty]["accuracy"];
    turret.aispread = level.mgturretsettings[difficulty]["aiSpread"];
    turret.playerspread = level.mgturretsettings[difficulty]["playerSpread"];
}

// Namespace mgturret
// Params 1, eflags: 0x0
// Checksum 0xd8047c6a, Offset: 0x718
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
            wait 2 + randomfloat(2);
        }
        self cleartargetentity();
        while (!self.suppresionfire) {
            wait 1;
        }
    }
}

// Namespace mgturret
// Params 1, eflags: 0x0
// Checksum 0xfb106269, Offset: 0x7e8
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

// Namespace mgturret
// Params 2, eflags: 0x0
// Checksum 0x3e0d20f1, Offset: 0x868
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
        wait turret_burst + randomfloat(turret_burst_range);
        turret function_beb0f764();
        turret stopfiring();
        wait turret_delay + randomfloat(turret_delay_range);
    }
}

// Namespace mgturret
// Params 0, eflags: 0x0
// Checksum 0x2fe92454, Offset: 0xac0
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

// Namespace mgturret
// Params 0, eflags: 0x0
// Checksum 0x78291603, Offset: 0xe48
// Size: 0x38
function do_shoot() {
    self endon(#"death");
    self endon(#"turretstatechange");
    for (;;) {
        self shootturret();
        wait 0.112;
    }
}

// Namespace mgturret
// Params 1, eflags: 0x0
// Checksum 0xb7f54540, Offset: 0xe88
// Size: 0x42
function turret_timer(duration) {
    if (duration <= 0) {
        return;
    }
    self endon(#"turretstatechange");
    wait duration;
    if (isdefined(self)) {
        self notify(#"turretstatechange");
    }
}

// Namespace mgturret
// Params 1, eflags: 0x0
// Checksum 0x5b1682bf, Offset: 0xed8
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
        wait 0.2;
    }
}

