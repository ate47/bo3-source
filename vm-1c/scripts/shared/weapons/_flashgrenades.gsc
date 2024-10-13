#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace flashgrenades;

// Namespace flashgrenades
// Params 0, eflags: 0x1 linked
// Checksum 0xd8fafa1f, Offset: 0x180
// Size: 0x54
function init_shared() {
    level.var_ffec0318 = "";
    level.var_330113ce = "";
    level.var_159d2484 = "";
    callback::on_connect(&monitorflash);
}

// Namespace flashgrenades
// Params 1, eflags: 0x1 linked
// Checksum 0xff5c74e, Offset: 0x1e0
// Size: 0x80
function flashrumbleloop(duration) {
    self endon(#"hash_8d28e1a5");
    self endon(#"hash_563b2ebc");
    self notify(#"hash_563b2ebc");
    goaltime = gettime() + duration * 1000;
    while (gettime() < goaltime) {
        self playrumbleonentity("damage_heavy");
        wait 0.05;
    }
}

// Namespace flashgrenades
// Params 4, eflags: 0x1 linked
// Checksum 0xefab220d, Offset: 0x268
// Size: 0x3e4
function function_8e149bc3(amount_distance, var_b5b15795, attacker, var_b4b1c76e) {
    hurtattacker = 0;
    hurtvictim = 1;
    duration = amount_distance * 3.5;
    min_duration = 2.5;
    var_528f6a39 = 2.5;
    if (duration < min_duration) {
        duration = min_duration;
    }
    if (isdefined(attacker) && attacker == self) {
        duration /= 3;
    }
    if (duration < 0.25) {
        return;
    }
    rumbleduration = undefined;
    if (duration > 2) {
        rumbleduration = 0.75;
    } else {
        rumbleduration = 0.25;
    }
    assert(isdefined(self.team));
    if (level.teambased && isdefined(attacker) && isdefined(attacker.team) && attacker.team == self.team && attacker != self) {
        friendlyfire = [[ level.figure_out_friendly_fire ]](self);
        if (friendlyfire == 0) {
            return;
        } else if (friendlyfire == 1) {
        } else if (friendlyfire == 2) {
            duration *= 0.5;
            rumbleduration *= 0.5;
            hurtvictim = 0;
            hurtattacker = 1;
        } else if (friendlyfire == 3) {
            duration *= 0.5;
            rumbleduration *= 0.5;
            hurtattacker = 1;
        }
    }
    if (self hasperk("specialty_flashprotection")) {
        duration *= 0.1;
        rumbleduration *= 0.1;
    }
    if (hurtvictim) {
        if (!var_b4b1c76e && (self util::mayapplyscreeneffect() || self isremotecontrolling())) {
            if (isdefined(attacker) && self != attacker && isplayer(attacker)) {
                attacker addweaponstat(getweapon("flash_grenade"), "hits", 1);
                attacker addweaponstat(getweapon("flash_grenade"), "used", 1);
            }
            self thread applyflash(duration, rumbleduration, attacker);
        }
    }
    if (hurtattacker) {
        if (attacker util::mayapplyscreeneffect()) {
            attacker thread applyflash(duration, rumbleduration, attacker);
        }
    }
}

// Namespace flashgrenades
// Params 0, eflags: 0x1 linked
// Checksum 0x2f99d114, Offset: 0x658
// Size: 0xa0
function monitorflash() {
    self endon(#"disconnect");
    self endon(#"hash_15683a6d");
    self.flashendtime = 0;
    while (true) {
        amount_distance, var_b5b15795, attacker = self waittill(#"flashbang");
        if (!isalive(self)) {
            continue;
        }
        self function_8e149bc3(amount_distance, var_b5b15795, attacker, 1);
    }
}

// Namespace flashgrenades
// Params 0, eflags: 0x0
// Checksum 0xf4fe401a, Offset: 0x700
// Size: 0xc8
function function_de4f854a() {
    self endon(#"death");
    self.flashendtime = 0;
    while (true) {
        amount_distance, var_b5b15795, attacker = self waittill(#"flashbang");
        driver = self getseatoccupant(0);
        if (!isdefined(driver) || !isalive(driver)) {
            continue;
        }
        driver function_8e149bc3(amount_distance, var_b5b15795, attacker, 0);
    }
}

// Namespace flashgrenades
// Params 3, eflags: 0x1 linked
// Checksum 0x5e910e82, Offset: 0x7d0
// Size: 0x14e
function applyflash(duration, rumbleduration, attacker) {
    if (!isdefined(self.var_53c623c1) || duration > self.var_53c623c1) {
        self.var_53c623c1 = duration;
    }
    if (!isdefined(self.var_b3800d86) || rumbleduration > self.var_b3800d86) {
        self.var_b3800d86 = rumbleduration;
    }
    self thread function_125a6838(duration);
    wait 0.05;
    if (isdefined(self.var_53c623c1)) {
        if (self hasperk("specialty_flashprotection") == 0) {
            self shellshock("flashbang", self.var_53c623c1, 0);
        }
        self.flashendtime = gettime() + self.var_53c623c1 * 1000;
        self.lastflashedby = attacker;
    }
    if (isdefined(self.var_b3800d86)) {
        self thread flashrumbleloop(self.var_b3800d86);
    }
    self.var_53c623c1 = undefined;
    self.var_b3800d86 = undefined;
}

// Namespace flashgrenades
// Params 1, eflags: 0x1 linked
// Checksum 0xb469a9ee, Offset: 0x928
// Size: 0x154
function function_125a6838(duration) {
    self endon(#"death");
    self endon(#"disconnect");
    var_d514ab92 = spawn("script_origin", (0, 0, 1));
    var_d514ab92.origin = self.origin;
    var_d514ab92 linkto(self);
    var_d514ab92 thread deleteentonownerdeath(self);
    var_d514ab92 playsound(level.var_ffec0318);
    var_d514ab92 playloopsound(level.var_330113ce);
    if (duration > 0.5) {
        wait duration - 0.5;
    }
    var_d514ab92 playsound(level.var_ffec0318);
    var_d514ab92 stoploopsound(0.5);
    wait 0.5;
    var_d514ab92 notify(#"delete");
    var_d514ab92 delete();
}

// Namespace flashgrenades
// Params 1, eflags: 0x1 linked
// Checksum 0x4d8194b, Offset: 0xa88
// Size: 0x3c
function deleteentonownerdeath(owner) {
    self endon(#"delete");
    owner waittill(#"death");
    self delete();
}

