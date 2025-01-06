#using scripts/codescripts/struct;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;

#namespace turret_aa_lotus;

// Namespace turret_aa_lotus
// Params 0, eflags: 0x2
// Checksum 0xa8db9ae0, Offset: 0x250
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("turret_aa_lotus", &__init__, undefined, undefined);
}

// Namespace turret_aa_lotus
// Params 0, eflags: 0x0
// Checksum 0x4b8f5f56, Offset: 0x288
// Size: 0x2a
function __init__() {
    vehicle::add_main_callback("turret_aa_lotus", &function_bd5a9ba5);
}

// Namespace turret_aa_lotus
// Params 0, eflags: 0x0
// Checksum 0x721bc6e9, Offset: 0x2c0
// Size: 0x1a
function function_bd5a9ba5() {
    self.var_e7379303 = -15;
    self thread main();
}

// Namespace turret_aa_lotus
// Params 1, eflags: 0x0
// Checksum 0x8a4bf811, Offset: 0x2e8
// Size: 0x22
function isads(player) {
    return player playerads() > 0.7;
}

// Namespace turret_aa_lotus
// Params 0, eflags: 0x0
// Checksum 0x421c2801, Offset: 0x318
// Size: 0x85
function main() {
    self endon(#"death");
    while (isalive(self)) {
        driver = self getseatoccupant(0);
        if (!isdefined(driver) || !isalive(driver)) {
            self waittill(#"enter_vehicle");
        }
        self thread function_f811fbe6();
        self waittill(#"exit_vehicle");
        wait 0.05;
    }
}

// Namespace turret_aa_lotus
// Params 0, eflags: 0x0
// Checksum 0xfb23d5bd, Offset: 0x3a8
// Size: 0x407
function function_f811fbe6() {
    self endon(#"enter_vehicle");
    self endon(#"exit_vehicle");
    for (driver = self getseatoccupant(0); isdefined(driver); driver = self getseatoccupant(0)) {
        if (isplayer(driver)) {
            if (isads(driver)) {
                var_38a4277e = getent("gunship_vh", "targetname");
                enemyarray = [];
                if (!isdefined(enemyarray)) {
                    enemyarray = [];
                } else if (!isarray(enemyarray)) {
                    enemyarray = array(enemyarray);
                }
                enemyarray[enemyarray.size] = var_38a4277e;
                var_30f2ef3 = anglestoforward(self gettagangles("tag_aim"));
                aimorigin = self gettagorigin("tag_aim");
                bestenemy = undefined;
                bestdot = cos(30);
                foreach (enemy in enemyarray) {
                    dirtoenemy = vectornormalize(enemy.origin - aimorigin);
                    dot = vectordot(var_30f2ef3, dirtoenemy);
                    if (dot > bestdot) {
                        bestdot = dot;
                        bestenemy = enemy;
                    }
                }
                if (isdefined(driver) && isdefined(bestenemy)) {
                    driver weaponlockstart(bestenemy);
                    var_41c7ab8c = 1;
                    var_67faddb3 = 3;
                    starttime = gettime();
                    var_59a77597 = cos(25);
                    while (gettime() < starttime + var_67faddb3 * 1000) {
                        var_30f2ef3 = anglestoforward(self gettagangles("tag_aim"));
                        dirtoenemy = vectornormalize(bestenemy.origin - aimorigin);
                        dot = vectordot(var_30f2ef3, dirtoenemy);
                        percent = mapfloat(var_59a77597, 1, 0, 1, dot);
                        util::debug_line(driver.origin, bestenemy.origin, (1 - percent, percent, 0), 0.8, 0, 1);
                        if (dot < var_59a77597) {
                            var_41c7ab8c = 0;
                            iprintln("Turret: lock failed");
                            break;
                        }
                        wait 0.05;
                    }
                    if (var_41c7ab8c) {
                        iprintln("Turret: lock succeed");
                        var_67faddb3 = 1;
                        starttime = gettime();
                        while (isdefined(driver) && isdefined(bestenemy) && gettime() < starttime + var_67faddb3 * 1000) {
                            util::debug_line(driver.origin, bestenemy.origin, (0, 0, 1), 0.8, 0, 1);
                            driver weaponlockfinalize(bestenemy);
                            wait 0.05;
                        }
                    }
                } else {
                    iprintln("Turret: no target");
                }
            }
        }
        wait 0.05;
    }
}

// Namespace turret_aa_lotus
// Params 1, eflags: 0x0
// Checksum 0x58402b15, Offset: 0x7b8
// Size: 0xda
function function_137a24fd(angles) {
    self vehicle::lights_off();
    self laseroff();
    self vehicle::toggle_sounds(0);
    self vehicle::toggle_exhaust_fx(0);
    if (!isdefined(angles)) {
        angles = self gettagangles("tag_flash");
    }
    target_vec = self.origin + anglestoforward((0, angles[1], 0)) * 1000;
    target_vec += (0, 0, -1700);
    self function_63f13a8e(target_vec);
    self.off = 1;
    if (!isdefined(self.emped)) {
        self disableaimassist();
    }
}

// Namespace turret_aa_lotus
// Params 0, eflags: 0x0
// Checksum 0x6488f036, Offset: 0x8a0
// Size: 0x72
function function_f606d231() {
    self playsound("veh_pallas_turret_boot");
    self vehicle::lights_on();
    self enableaimassist();
    self vehicle::toggle_sounds(1);
    self vehicle::toggle_exhaust_fx(1);
    self.off = undefined;
    self laseron();
}

