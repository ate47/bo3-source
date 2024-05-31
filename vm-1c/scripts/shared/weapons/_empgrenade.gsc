#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace empgrenade;

// Namespace empgrenade
// Params 0, eflags: 0x2
// namespace_ffdc4251<file_0>::function_2dc19561
// Checksum 0x25ce774f, Offset: 0x1e8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("empgrenade", &__init__, undefined, undefined);
}

// Namespace empgrenade
// Params 0, eflags: 0x1 linked
// namespace_ffdc4251<file_0>::function_8c87d8eb
// Checksum 0xfed6fe21, Offset: 0x228
// Size: 0x84
function __init__() {
    clientfield::register("toplayer", "empd", 1, 1, "int");
    clientfield::register("toplayer", "empd_monitor_distance", 1, 1, "int");
    callback::on_spawned(&on_player_spawned);
}

// Namespace empgrenade
// Params 0, eflags: 0x1 linked
// namespace_ffdc4251<file_0>::function_aebcf025
// Checksum 0x81639193, Offset: 0x2b8
// Size: 0x3c
function on_player_spawned() {
    self endon(#"disconnect");
    self thread monitorempgrenade();
    self thread begin_other_grenade_tracking();
}

// Namespace empgrenade
// Params 0, eflags: 0x1 linked
// namespace_ffdc4251<file_0>::function_5639dbc1
// Checksum 0xadc8ca9d, Offset: 0x300
// Size: 0x228
function monitorempgrenade() {
    self endon(#"disconnect");
    self endon(#"death");
    self endon(#"killempmonitor");
    self.empendtime = 0;
    while (true) {
        attacker, explosionpoint = self waittill(#"emp_grenaded");
        if (!isalive(self) || self hasperk("specialty_immuneemp")) {
            continue;
        }
        hurtvictim = 1;
        hurtattacker = 0;
        assert(isdefined(self.team));
        if (level.teambased && isdefined(attacker) && isdefined(attacker.team) && attacker.team == self.team && attacker != self) {
            friendlyfire = [[ level.figure_out_friendly_fire ]](self);
            if (friendlyfire == 0) {
                continue;
            } else if (friendlyfire == 1) {
                hurtattacker = 0;
                hurtvictim = 1;
            } else if (friendlyfire == 2) {
                hurtvictim = 0;
                hurtattacker = 1;
            } else if (friendlyfire == 3) {
                hurtattacker = 1;
                hurtvictim = 1;
            }
        }
        if (hurtvictim && isdefined(self)) {
            self thread applyemp(attacker, explosionpoint);
        }
        if (hurtattacker && isdefined(attacker)) {
            attacker thread applyemp(attacker, explosionpoint);
        }
    }
}

// Namespace empgrenade
// Params 2, eflags: 0x1 linked
// namespace_ffdc4251<file_0>::function_459a24bb
// Checksum 0x4d8b6d58, Offset: 0x530
// Size: 0x334
function applyemp(attacker, explosionpoint) {
    self notify(#"applyemp");
    self endon(#"applyemp");
    self endon(#"disconnect");
    self endon(#"death");
    wait(0.05);
    if (!(isdefined(self) && isalive(self))) {
        return;
    }
    if (self == attacker) {
        currentempduration = 1;
    } else {
        distancetoexplosion = distance(self.origin, explosionpoint);
        ratio = 1 - distancetoexplosion / 425;
        currentempduration = 3 + 3 * ratio;
    }
    if (isdefined(self.empendtime)) {
        emp_time_left_ms = self.empendtime - gettime();
        if (emp_time_left_ms > currentempduration * 1000) {
            self.empduration = emp_time_left_ms / 1000;
        } else {
            self.empduration = currentempduration;
        }
    } else {
        self.empduration = currentempduration;
    }
    self.empgrenaded = 1;
    self shellshock("emp_shock", 1);
    self clientfield::set_to_player("empd", 1);
    self.empstarttime = gettime();
    self.empendtime = self.empstarttime + self.empduration * 1000;
    self.empedby = attacker;
    shutdownemprebootindicatormenu();
    emprebootmenu = self openluimenu("EmpRebootIndicator");
    self setluimenudata(emprebootmenu, "endTime", int(self.empendtime));
    self setluimenudata(emprebootmenu, "startTime", int(self.empstarttime));
    self thread emprumbleloop(0.75);
    self setempjammed(1);
    self thread empgrenadedeathwaiter();
    self thread function_2be0d392();
    if (self.empduration > 0) {
        wait(self.empduration);
    }
    if (isdefined(self)) {
        self notify(#"empgrenadetimedout");
        self checktoturnoffemp();
    }
}

// Namespace empgrenade
// Params 0, eflags: 0x1 linked
// namespace_ffdc4251<file_0>::function_4235ef83
// Checksum 0x2543d7c5, Offset: 0x870
// Size: 0x54
function empgrenadedeathwaiter() {
    self notify(#"empgrenadedeathwaiter");
    self endon(#"empgrenadedeathwaiter");
    self endon(#"empgrenadetimedout");
    self waittill(#"death");
    if (isdefined(self)) {
        self checktoturnoffemp();
    }
}

// Namespace empgrenade
// Params 0, eflags: 0x1 linked
// namespace_ffdc4251<file_0>::function_2be0d392
// Checksum 0x5157ef, Offset: 0x8d0
// Size: 0x54
function function_2be0d392() {
    self notify(#"hash_2be0d392");
    self endon(#"hash_2be0d392");
    self endon(#"empgrenadetimedout");
    self waittill(#"hash_c6be0179");
    if (isdefined(self)) {
        self checktoturnoffemp();
    }
}

// Namespace empgrenade
// Params 0, eflags: 0x1 linked
// namespace_ffdc4251<file_0>::function_5357a1e2
// Checksum 0x2b0a4b1b, Offset: 0x930
// Size: 0x7c
function checktoturnoffemp() {
    if (isdefined(self)) {
        self.empgrenaded = 0;
        shutdownemprebootindicatormenu();
        if (self killstreaks::emp_isempd()) {
            return;
        }
        self setempjammed(0);
        self clientfield::set_to_player("empd", 0);
    }
}

// Namespace empgrenade
// Params 0, eflags: 0x1 linked
// namespace_ffdc4251<file_0>::function_2498a3ca
// Checksum 0x191fb63, Offset: 0x9b8
// Size: 0x54
function shutdownemprebootindicatormenu() {
    emprebootmenu = self getluimenu("EmpRebootIndicator");
    if (isdefined(emprebootmenu)) {
        self closeluimenu(emprebootmenu);
    }
}

// Namespace empgrenade
// Params 1, eflags: 0x1 linked
// namespace_ffdc4251<file_0>::function_7dadf7b8
// Checksum 0x76d92163, Offset: 0xa18
// Size: 0x70
function emprumbleloop(duration) {
    self endon(#"emp_rumble_loop");
    self notify(#"emp_rumble_loop");
    goaltime = gettime() + duration * 1000;
    while (gettime() < goaltime) {
        self playrumbleonentity("damage_heavy");
        wait(0.05);
    }
}

// Namespace empgrenade
// Params 2, eflags: 0x1 linked
// namespace_ffdc4251<file_0>::function_dd2e8431
// Checksum 0x17d960f1, Offset: 0xa90
// Size: 0xac
function watchempexplosion(owner, weapon) {
    owner endon(#"disconnect");
    owner endon(#"team_changed");
    self endon(#"trophy_destroyed");
    owner addweaponstat(weapon, "used", 1);
    origin, surface = self waittill(#"explode");
    level empexplosiondamageents(owner, weapon, origin, 425, 1);
}

// Namespace empgrenade
// Params 5, eflags: 0x1 linked
// namespace_ffdc4251<file_0>::function_cd50b2c7
// Checksum 0x7fbabb98, Offset: 0xb48
// Size: 0x132
function empexplosiondamageents(owner, weapon, origin, radius, damageplayers) {
    ents = getdamageableentarray(origin, radius);
    if (!isdefined(damageplayers)) {
        damageplayers = 1;
    }
    foreach (ent in ents) {
        if (!damageplayers && isplayer(ent)) {
            continue;
        }
        ent dodamage(1, origin, owner, owner, "none", "MOD_GRENADE_SPLASH", 0, weapon);
    }
}

// Namespace empgrenade
// Params 0, eflags: 0x1 linked
// namespace_ffdc4251<file_0>::function_a7922cf8
// Checksum 0x37e9f679, Offset: 0xc88
// Size: 0xb0
function begin_other_grenade_tracking() {
    self endon(#"death");
    self endon(#"disconnect");
    self notify(#"hash_916b3972");
    self endon(#"hash_916b3972");
    for (;;) {
        grenade, weapon, cooktime = self waittill(#"grenade_fire");
        if (grenade util::ishacked()) {
            continue;
        }
        if (weapon.isemp) {
            grenade thread watchempexplosion(self, weapon);
        }
    }
}

