#using scripts/mp/gametypes/_globallogic_player;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace healthoverlay;

// Namespace healthoverlay
// Params 0, eflags: 0x2
// namespace_18001e6d<file_0>::function_2dc19561
// Checksum 0x7fda6de4, Offset: 0x180
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("healthoverlay", &__init__, undefined, undefined);
}

// Namespace healthoverlay
// Params 0, eflags: 0x1 linked
// namespace_18001e6d<file_0>::function_8c87d8eb
// Checksum 0xa5bcc2ee, Offset: 0x1c0
// Size: 0xdc
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_joined_team(&end_health_regen);
    callback::on_joined_spectate(&end_health_regen);
    callback::on_spawned(&player_health_regen);
    callback::on_disconnect(&end_health_regen);
    callback::on_player_killed(&end_health_regen);
    level.start_player_health_regen = &player_health_regen;
}

// Namespace healthoverlay
// Params 0, eflags: 0x1 linked
// namespace_18001e6d<file_0>::function_c35e6aab
// Checksum 0x753d1a33, Offset: 0x2a8
// Size: 0x50
function init() {
    level.healthoverlaycutoff = 0.55;
    regentime = level.playerhealthregentime;
    level.playerhealth_regularregendelay = regentime * 1000;
    level.healthregendisabled = level.playerhealth_regularregendelay <= 0;
}

// Namespace healthoverlay
// Params 0, eflags: 0x1 linked
// namespace_18001e6d<file_0>::function_f9283c47
// Checksum 0x23849c3, Offset: 0x300
// Size: 0x12
function end_health_regen() {
    self notify(#"end_healthregen");
}

// Namespace healthoverlay
// Params 0, eflags: 0x1 linked
// namespace_18001e6d<file_0>::function_28c29e3d
// Checksum 0xe47586d5, Offset: 0x320
// Size: 0x554
function player_health_regen() {
    self endon(#"end_healthregen");
    if (self.health <= 0) {
        assert(!isalive(self));
        return;
    }
    maxhealth = self.health;
    oldhealth = maxhealth;
    player = self;
    var_4d2b26fb = 0;
    regenrate = 0.1;
    usetrueregen = 0;
    veryhurt = 0;
    player.breathingstoptime = -10000;
    thread player_breathing_sound(maxhealth * 0.35);
    thread player_heartbeat_sound(maxhealth * 0.35);
    lastsoundtime_recover = 0;
    hurttime = 0;
    newhealth = 0;
    for (;;) {
        wait(0.05);
        if (isdefined(self.healthregendisabled) && self.healthregendisabled) {
            continue;
        }
        if (isdefined(player.regenrate)) {
            regenrate = player.regenrate;
            usetrueregen = 1;
        }
        if (player.health == maxhealth) {
            veryhurt = 0;
            if (isdefined(self.atbrinkofdeath) && self.atbrinkofdeath == 1) {
                self notify(#"challenge_survived_from_death");
            }
            self.atbrinkofdeath = 0;
            continue;
        }
        if (player.health <= 0) {
            return;
        }
        if (isdefined(player.laststand) && player.laststand) {
            continue;
        }
        wasveryhurt = veryhurt;
        ratio = player.health / maxhealth;
        if (ratio <= level.healthoverlaycutoff) {
            veryhurt = 1;
            self.atbrinkofdeath = 1;
            self.isneardeath = 1;
            if (!wasveryhurt) {
                hurttime = gettime();
            }
        } else {
            self.isneardeath = 0;
        }
        if (player.health >= oldhealth) {
            regentime = level.playerhealth_regularregendelay;
            if (player hasperk("specialty_healthregen")) {
                regentime = int(regentime / getdvarfloat("perk_healthRegenMultiplier"));
            }
            if (gettime() - hurttime < regentime) {
                continue;
            }
            if (level.healthregendisabled) {
                continue;
            }
            if (gettime() - lastsoundtime_recover > regentime) {
                lastsoundtime_recover = gettime();
                self notify(#"snd_breathing_better");
            }
            if (veryhurt) {
                newhealth = ratio;
                veryhurttime = 3000;
                if (player hasperk("specialty_healthregen")) {
                    veryhurttime = int(veryhurttime / getdvarfloat("perk_healthRegenMultiplier"));
                }
                if (gettime() > hurttime + veryhurttime) {
                    newhealth += regenrate;
                }
            } else if (usetrueregen) {
                newhealth = ratio + regenrate;
            } else {
                newhealth = 1;
            }
            if (newhealth >= 1) {
                self globallogic_player::resetattackerlist();
                newhealth = 1;
            }
            if (newhealth <= 0) {
                return;
            }
            player setnormalhealth(newhealth);
            change = player.health - oldhealth;
            if (change > 0) {
                player decay_player_damages(change);
            }
            oldhealth = player.health;
            continue;
        }
        oldhealth = player.health;
        var_4d2b26fb = 0;
        hurttime = gettime();
        player.breathingstoptime = hurttime + 6000;
    }
}

// Namespace healthoverlay
// Params 1, eflags: 0x1 linked
// namespace_18001e6d<file_0>::function_675b27b0
// Checksum 0xcca4f381, Offset: 0x880
// Size: 0xee
function decay_player_damages(decay) {
    if (!isdefined(self.attackerdamage)) {
        return;
    }
    for (i = 0; i < self.attackerdamage.size; i++) {
        if (!isdefined(self.attackerdamage[i]) || !isdefined(self.attackerdamage[i].damage)) {
            continue;
        }
        self.attackerdamage[i].damage = self.attackerdamage[i].damage - decay;
        if (self.attackerdamage[i].damage < 0) {
            self.attackerdamage[i].damage = 0;
        }
    }
}

// Namespace healthoverlay
// Params 1, eflags: 0x1 linked
// namespace_18001e6d<file_0>::function_92ef43e1
// Checksum 0xf1256a44, Offset: 0x978
// Size: 0xe2
function player_breathing_sound(healthcap) {
    self endon(#"end_healthregen");
    wait(2);
    player = self;
    for (;;) {
        wait(0.2);
        if (player.health <= 0) {
            return;
        }
        if (player util::isusingremote()) {
            continue;
        }
        if (player.health >= healthcap) {
            continue;
        }
        if (level.healthregendisabled && gettime() > player.breathingstoptime) {
            continue;
        }
        player notify(#"snd_breathing_hurt");
        wait(0.784);
        wait(0.1 + randomfloat(0.8));
    }
}

// Namespace healthoverlay
// Params 1, eflags: 0x1 linked
// namespace_18001e6d<file_0>::function_4f4f83e3
// Checksum 0x51dacd77, Offset: 0xa68
// Size: 0x12c
function player_heartbeat_sound(healthcap) {
    self endon(#"end_healthregen");
    self.hearbeatwait = 0.2;
    wait(2);
    player = self;
    for (;;) {
        wait(0.2);
        if (player.health <= 0) {
            return;
        }
        if (player util::isusingremote()) {
            continue;
        }
        if (player.health >= healthcap) {
            self.hearbeatwait = 0.3;
            continue;
        }
        if (level.healthregendisabled && gettime() > player.breathingstoptime) {
            self.hearbeatwait = 0.3;
            continue;
        }
        player playlocalsound("mpl_player_heartbeat");
        wait(self.hearbeatwait);
        if (self.hearbeatwait <= 0.6) {
            self.hearbeatwait += 0.1;
        }
    }
}

