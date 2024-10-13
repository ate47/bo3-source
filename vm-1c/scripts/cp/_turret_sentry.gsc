#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/util_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/system_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/math_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace sentry_turret;

// Namespace sentry_turret
// Params 0, eflags: 0x2
// Checksum 0x15c2c658, Offset: 0x4c0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("sentry_turret", &__init__, undefined, undefined);
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xbae3f097, Offset: 0x500
// Size: 0x18e
function __init__() {
    vehicle::add_main_callback("veh_turret_sentry_machinegun", &function_b2e9d990);
    vehicle::add_main_callback("veh_turret_sentry_sniper", &function_8f042083);
    vehicle::add_main_callback("veh_turret_sentry_grenade", &function_8f042083);
    vehicle::add_main_callback("veh_turret_sentry_guardian", &function_8f042083);
    vehicle::add_main_callback("veh_turret_sentry_emp", &function_c2d2b587);
    level._effect["sentry_turret_damage01"] = "destruct/fx_dest_turret_1";
    level._effect["sentry_turret_damage02"] = "destruct/fx_dest_turret_2";
    level._effect["sentry_turret_damage01"] = "destruct/fx_dest_turret_1";
    level._effect["sentry_turret_damage02"] = "destruct/fx_dest_turret_2";
    level._effect["sentry_turret_death"] = "_t6/destructibles/fx_sentry_turret_death";
    level._effect["sentry_turret_stun"] = "_t6/electrical/fx_elec_sp_emp_stun_sentry_turret";
    level._effect["sentry_turret_stun"] = "_t6/electrical/fx_elec_sp_emp_stun_sentry_turret";
}

/#

    // Namespace sentry_turret
    // Params 3, eflags: 0x1 linked
    // Checksum 0xb647502c, Offset: 0x698
    // Size: 0x6c
    function function_6a14e39c(start, end, color) {
        if (getdvarint("<dev string:x28>") != 0) {
            line(start, end, color, 1, 0, 50);
        }
    }

#/

// Namespace sentry_turret
// Params 2, eflags: 0x1 linked
// Checksum 0xaaa59e92, Offset: 0x710
// Size: 0xd8
function function_ba2c6c94(origin, sector) {
    forward = anglestoforward((0, sector, 0));
    end = origin + forward * 50;
    passed = bullettracepassed(origin, end, 0, self);
    /#
        if (passed) {
            function_6a14e39c(origin, end, (0, 1, 0));
        } else {
            function_6a14e39c(origin, end, (1, 0, 0));
        }
    #/
    return passed;
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xdfcf41da, Offset: 0x7f0
// Size: 0x284
function function_e606dad7() {
    angles = self.angles;
    origin = self.origin;
    eye = self gettagorigin("tag_barrel");
    /#
        if (function_ba2c6c94(eye, angles[1])) {
            iprintln("<dev string:x39>");
        }
    #/
    yaw = angleclamp180(angles[1]);
    max_angle = yaw;
    for (sector = 0; sector * 10 <= 360; sector++) {
        if (function_ba2c6c94(eye, yaw + sector * 10)) {
            max_angle = yaw + sector * 10;
            continue;
        }
        break;
    }
    min_angle = yaw;
    for (sector = 0; sector * 10 <= 360; sector++) {
        if (function_ba2c6c94(eye, yaw - sector * 10)) {
            min_angle = yaw - sector * 10;
            continue;
        }
        break;
    }
    if (max_angle - min_angle >= 360) {
        var_2421690d = yaw;
        self.scanning_arc = -76;
    } else {
        var_2421690d = angleclamp180((max_angle + min_angle) * 0.5);
        self.scanning_arc = max_angle - (max_angle + min_angle) * 0.5;
    }
    self.angles = (angles[0], var_2421690d, angles[2]);
}

// Namespace sentry_turret
// Params 2, eflags: 0x1 linked
// Checksum 0x1012d25, Offset: 0xa80
// Size: 0x5c
function function_5f695de4(point, yaw) {
    targetpoint = spawnstruct();
    targetpoint.yaw = yaw;
    targetpoint.origin = point;
    return targetpoint;
}

// Namespace sentry_turret
// Params 3, eflags: 0x1 linked
// Checksum 0x667e4aa, Offset: 0xae8
// Size: 0x72
function get_target_point(origin, angles, yaw_offset) {
    point = origin + anglestoforward(angles + (self.var_e7379303, yaw_offset, 0)) * 1000;
    return function_5f695de4(point, yaw_offset);
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x24853369, Offset: 0xb68
// Size: 0x258
function function_1b820c4d() {
    self.targetpoints = [];
    self.var_23b6e300 = 0;
    self.var_b431c4af = 1;
    self.var_5e51c171 = 0;
    self.eyeorigin = self gettagorigin("tag_barrel");
    if (self.scanning_arc < -76) {
        self.targetpoints[self.targetpoints.size] = get_target_point(self.eyeorigin, self.angles, self.scanning_arc);
        self.var_23b6e300 = self.targetpoints.size;
        self.targetpoints[self.targetpoints.size] = get_target_point(self.eyeorigin, self.angles, 0);
        self.targetpoints[self.targetpoints.size] = get_target_point(self.eyeorigin, self.angles, self.scanning_arc * -1);
        return;
    }
    self.var_23b6e300 = self.targetpoints.size;
    self.targetpoints[self.targetpoints.size] = get_target_point(self.eyeorigin, self.angles, 0);
    self.targetpoints[self.targetpoints.size] = get_target_point(self.eyeorigin, self.angles, 90);
    self.targetpoints[self.targetpoints.size] = get_target_point(self.eyeorigin, self.angles, -76);
    self.targetpoints[self.targetpoints.size] = get_target_point(self.eyeorigin, self.angles, 270);
    self.var_b431c4af = math::cointoss() ? 1 : -1;
    self.var_5e51c171 = 1;
}

// Namespace sentry_turret
// Params 3, eflags: 0x1 linked
// Checksum 0x3cde5e77, Offset: 0xdc8
// Size: 0x62
function function_4ac3c3a1(e1, e2, b_lowest_first) {
    if (b_lowest_first) {
        return (e1.yaw < e2.yaw);
    }
    return e1.yaw > e2.yaw;
}

// Namespace sentry_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x9f769ea5, Offset: 0xe38
// Size: 0x1cc
function function_c8f2c95d(point) {
    direction = point - self.eyeorigin;
    angles = vectortoangles(direction);
    yaw_delta = angleclamp180(angles[1] - self.angles[1]);
    foreach (targetpoint in self.targetpoints) {
        if (yaw_delta < targetpoint.yaw) {
            if (targetpoint.yaw - yaw_delta < 5) {
                return;
            }
            continue;
        }
        if (yaw_delta - targetpoint.yaw < 5) {
            return;
        }
    }
    if (self.var_5e51c171) {
        yaw_delta = absangleclamp360(yaw_delta);
    }
    self.targetpoints[self.targetpoints.size] = function_5f695de4(point, yaw_delta);
    array::merge_sort(self.targetpoints, &function_4ac3c3a1, 1);
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xdfd32b02, Offset: 0x1010
// Size: 0x1c
function function_b2e9d990() {
    self thread function_8f042083();
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xcd6da779, Offset: 0x1038
// Size: 0x1c
function function_c2d2b587() {
    self thread function_8f042083();
}

// Namespace sentry_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x34c14e5c, Offset: 0x1060
// Size: 0x6e
function function_e7857e05(e_enemy) {
    var_b9baf316 = 1;
    if (isdefined(e_enemy.archetype) && isdefined(self.var_c35cf4ed)) {
        var_b9baf316 = !isinarray(self.var_c35cf4ed, e_enemy.archetype);
    }
    return var_b9baf316;
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xaa593b6d, Offset: 0x10d8
// Size: 0x2ac
function function_8f042083() {
    if (!isdefined(self.var_c35cf4ed)) {
        self.var_c35cf4ed = [];
    }
    self thread turret_idle_sound();
    self enableaimassist();
    self.onkill = &function_aa320a88;
    self.scanning_arc = 90;
    self.var_e7379303 = 0;
    function_e606dad7();
    function_1b820c4d();
    self.state_machine = statemachine::create("brain", self);
    self.state_machine statemachine::add_state("main", undefined, &function_e59668cf, undefined);
    self.state_machine statemachine::add_state("scripted", undefined, &function_4642c69e, undefined);
    self.state_machine statemachine::add_interrupt_connection("main", "scripted", "enter_vehicle");
    self.state_machine statemachine::add_interrupt_connection("scripted", "main", "exit_vehicle");
    self disconnectpaths();
    self thread sentry_turret_death();
    self thread function_8109253b();
    self thread turret::track_lens_flare();
    self.overridevehicledamage = &function_df1adf01;
    if (isdefined(self.script_startstate)) {
        if (self.script_startstate == "off") {
            self function_e6f10cc7(self.angles);
        } else {
            self.state_machine statemachine::set_state(self.script_startstate);
        }
    } else {
        function_62182551();
    }
    self laseron();
    self playsound("mpl_turret_startup");
}

// Namespace sentry_turret
// Params 0, eflags: 0x0
// Checksum 0xf5f67161, Offset: 0x1390
// Size: 0x24
function function_d19a819d() {
    self.state_machine statemachine::set_state("scripted");
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x48f2204a, Offset: 0x13c0
// Size: 0x24
function function_62182551() {
    self.state_machine statemachine::set_state("main");
}

// Namespace sentry_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x55ec47eb, Offset: 0x13f0
// Size: 0x54
function function_e59668cf(params) {
    if (isalive(self)) {
        self enableaimassist();
        self thread function_2e229297();
    }
}

// Namespace sentry_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x81ec0d48, Offset: 0x1450
// Size: 0x15c
function function_e6f10cc7(angles) {
    self.state_machine statemachine::set_state("scripted");
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

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x676f9d9, Offset: 0x15b8
// Size: 0xcc
function function_21af94b3() {
    self playsound("mpl_turret_startup");
    self vehicle::lights_on();
    self enableaimassist();
    self vehicle::toggle_sounds(1);
    self function_4ebb4502();
    self vehicle::toggle_exhaust_fx(1);
    self.off = undefined;
    self laseron();
    function_62182551();
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x58805034, Offset: 0x1690
// Size: 0x118
function function_4ebb4502() {
    for (i = 0; i < 6; i++) {
        wait 0.1;
        vehicle::lights_off();
        wait 0.1;
        vehicle::lights_on();
    }
    if (!isdefined(self.player)) {
        angles = self gettagangles("tag_flash");
        target_vec = self.origin + anglestoforward((self.var_e7379303, angles[1], 0)) * 1000;
        self.turretrotscale = 0.3;
        self function_63f13a8e(target_vec);
        wait 1;
        self.turretrotscale = 1;
    }
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xf0a88490, Offset: 0x17b0
// Size: 0x518
function function_2e229297() {
    self endon(#"death");
    self endon(#"change_state");
    var_65801466 = 0;
    wait 0.2;
    origin = self gettagorigin("tag_barrel");
    while (true) {
        if (isdefined(self.enemy) && self function_4246bc05(self.enemy) && self function_e7857e05(self.enemy)) {
            self.turretrotscale = 1;
            if (var_65801466 > 0 && isplayer(self.enemy)) {
                sentry_turret_alert_sound();
                wait 0.5;
            }
            var_65801466 = 0;
            for (i = 0; i < 3; i++) {
                if (isdefined(self.enemy) && isalive(self.enemy) && self function_4246bc05(self.enemy)) {
                    self setturrettargetent(self.enemy);
                    wait 0.1;
                    self sentry_turret_fire_for_time(randomfloatrange(0.4, 1.5), self.enemy);
                } else {
                    self cleartargetentity();
                }
                if (isdefined(self.enemy) && isplayer(self.enemy)) {
                    wait randomfloatrange(0.3, 0.6);
                    continue;
                }
                wait randomfloatrange(0.3, 0.6) * 2;
            }
            if (isdefined(self.enemy) && isalive(self.enemy) && self function_4246bc05(self.enemy)) {
                if (isplayer(self.enemy)) {
                    wait randomfloatrange(0.5, 1.3);
                } else {
                    wait randomfloatrange(0.5, 1.3) * 2;
                }
            }
        } else {
            self.turretrotscale = 0.5;
            var_65801466++;
            wait 1;
            if (var_65801466 > 1) {
                while (!isdefined(self.enemy) || !self function_4246bc05(self.enemy)) {
                    if (self.turretontarget) {
                        self.var_23b6e300 += self.var_b431c4af;
                        if (self.targetpoints.size <= 1) {
                            self.var_23b6e300 = 0;
                        } else if (self.var_23b6e300 >= self.targetpoints.size || self.var_23b6e300 < 0) {
                            if (!self.var_5e51c171) {
                                self.var_23b6e300 -= self.var_b431c4af;
                                self.var_b431c4af *= -1;
                                self.var_23b6e300 += self.var_b431c4af;
                            } else if (self.var_23b6e300 >= self.targetpoints.size) {
                                self.var_23b6e300 = 0;
                            } else {
                                self.var_23b6e300 = self.targetpoints.size - 1;
                            }
                        }
                    }
                    /#
                        function_6a14e39c(origin, self.targetpoints[self.var_23b6e300].origin, (0, 1, 0));
                    #/
                    self setturrettargetvec(self.targetpoints[self.var_23b6e300].origin);
                    wait 0.5;
                }
            } else {
                self cleartargetentity();
            }
        }
        wait 0.5;
    }
}

// Namespace sentry_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x6d65d8d0, Offset: 0x1cd0
// Size: 0xc4
function function_4642c69e(params) {
    driver = self getseatoccupant(0);
    if (isdefined(driver)) {
        self.turretrotscale = 1;
        self disableaimassist();
        if (driver == level.players[0]) {
            self thread vehicle_death::vehicle_damage_filter("firestorm_turret");
            level.players[0] thread function_2790de05(self);
        }
    }
    self cleartargetentity();
}

// Namespace sentry_turret
// Params 1, eflags: 0x1 linked
// Checksum 0xd2fcc119, Offset: 0x1da0
// Size: 0xaa
function function_e823c700(health_pct) {
    if (issubstr(self.vehicletype, "turret_sentry")) {
        if (health_pct < 0.6) {
            return level._effect["sentry_turret_damage02"];
        } else {
            return level._effect["sentry_turret_damage01"];
        }
        return;
    }
    if (health_pct < 0.6) {
        return level._effect["sentry_turret_damage02"];
    }
    return level._effect["sentry_turret_damage01"];
}

// Namespace sentry_turret
// Params 2, eflags: 0x1 linked
// Checksum 0x982ca49e, Offset: 0x1e58
// Size: 0x190
function function_b212223b(effect, tag) {
    if (isdefined(self.damage_fx_ent)) {
        if (self.damage_fx_ent.effect == effect) {
            return;
        }
        self.damage_fx_ent delete();
    }
    if (!isdefined(self gettagangles(tag))) {
        return;
    }
    ent = spawn("script_model", (0, 0, 0));
    ent setmodel("tag_origin");
    ent.origin = self gettagorigin(tag);
    ent.angles = self gettagangles(tag);
    ent notsolid();
    ent hide();
    ent linkto(self, tag);
    ent.effect = effect;
    playfxontag(effect, ent, "tag_origin");
    self.damage_fx_ent = ent;
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xd30ea938, Offset: 0x1ff0
// Size: 0x98
function function_8109253b() {
    self endon(#"crash_done");
    while (isdefined(self)) {
        self waittill(#"damage");
        if (self.health > 0) {
            effect = self function_e823c700(self.health / self.healthdefault);
            tag = "tag_fx";
            function_b212223b(effect, tag);
        }
        wait 0.3;
    }
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xe1c5282b, Offset: 0x2090
// Size: 0x254
function sentry_turret_death() {
    wait 0.1;
    if (!isdefined(self)) {
        return;
    }
    self notify(#"nodeath_thread");
    attacker, damagefromunderneath, weapon, point, dir = self waittill(#"death");
    if (!isdefined(self)) {
        return;
    }
    if (isdefined(self.delete_on_death)) {
        if (isdefined(self.damage_fx_ent)) {
            self.damage_fx_ent delete();
        }
        self delete();
        return;
    }
    self vehicle_death::death_cleanup_level_variables();
    self disableaimassist();
    self cleartargetentity();
    self vehicle::lights_off();
    self laseroff();
    self setturretspinning(0);
    self turret::toggle_lensflare(0);
    self death_fx();
    self thread vehicle_death::death_radius_damage();
    self thread vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::toggle_sounds(0);
    self thread function_e99c1c2(attacker, dir);
    if (isdefined(self.damage_fx_ent)) {
        self.damage_fx_ent delete();
    }
    self.ignoreme = 1;
    self waittill(#"crash_done");
    self freevehicle();
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xfe9315dd, Offset: 0x22f0
// Size: 0x1c
function death_fx() {
    self vehicle::do_death_fx();
}

// Namespace sentry_turret
// Params 2, eflags: 0x1 linked
// Checksum 0x625ca4e1, Offset: 0x2318
// Size: 0x106
function function_e99c1c2(attacker, hitdir) {
    self endon(#"crash_done");
    self endon(#"death");
    self playsound("veh_sentry_turret_dmg_hit");
    wait 0.1;
    self.turretrotscale = 0.5;
    tag_angles = self gettagangles("tag_flash");
    target_pos = self.origin + anglestoforward((0, tag_angles[1], 0)) * 1000 + (0, 0, -1800);
    self setturrettargetvec(target_pos);
    wait 4;
    self notify(#"crash_done");
}

// Namespace sentry_turret
// Params 2, eflags: 0x1 linked
// Checksum 0x5d10919, Offset: 0x2428
// Size: 0x184
function sentry_turret_fire_for_time(totalfiretime, enemy) {
    self endon(#"crash_done");
    self endon(#"death");
    sentry_turret_alert_sound();
    wait 0.1;
    weapon = self seatgetweapon(0);
    firetime = weapon.firetime;
    time = 0;
    is_minigun = 0;
    if (issubstr(weapon.name, "minigun")) {
        is_minigun = 1;
        self setturretspinning(1);
        wait 0.5;
    }
    while (time < totalfiretime) {
        if (isdefined(level.var_a753e7a8)) {
            self [[ level.var_a753e7a8 ]](0, enemy);
        } else {
            self fireweapon(0, enemy);
        }
        wait firetime;
        time += firetime;
    }
    if (is_minigun) {
        self setturretspinning(0);
    }
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x2d134142, Offset: 0x25b8
// Size: 0x24
function sentry_turret_alert_sound() {
    self playsound("veh_turret_alert");
}

// Namespace sentry_turret
// Params 1, eflags: 0x1 linked
// Checksum 0xe1a81016, Offset: 0x25e8
// Size: 0x34
function function_ebdfd4e4(team) {
    self.team = team;
    if (!isdefined(self.off)) {
        function_f08ad3e6();
    }
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xe6a5421a, Offset: 0x2628
// Size: 0x44
function function_f08ad3e6() {
    self endon(#"death");
    self vehicle::lights_off();
    wait 0.1;
    self vehicle::lights_on();
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x1e57299e, Offset: 0x2678
// Size: 0x1dc
function function_791c1a61() {
    self endon(#"death");
    self notify(#"emped");
    self endon(#"emped");
    self.emped = 1;
    playsoundatposition("veh_sentry_turret_emp_down", self.origin);
    self.turretrotscale = 0.2;
    self function_e6f10cc7();
    if (!isdefined(self.stun_fx)) {
        self.stun_fx = spawn("script_model", self.origin);
        self.stun_fx setmodel("tag_origin");
        self.stun_fx linkto(self, "tag_fx", (0, 0, 0), (0, 0, 0));
        if (issubstr(self.vehicletype, "turret_sentry")) {
            playfxontag(level._effect["sentry_turret_stun"], self.stun_fx, "tag_origin");
        } else {
            playfxontag(level._effect["sentry_turret_stun"], self.stun_fx, "tag_origin");
        }
    }
    wait randomfloatrange(6, 10);
    self.stun_fx delete();
    self.emped = undefined;
    self function_21af94b3();
}

// Namespace sentry_turret
// Params 15, eflags: 0x1 linked
// Checksum 0x3ea5ef4d, Offset: 0x2860
// Size: 0xe0
function function_df1adf01(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (weapon.isemp && smeansofdeath != "MOD_IMPACT") {
        driver = self getseatoccupant(0);
        if (!isdefined(driver)) {
            self thread function_791c1a61();
        }
    }
    return idamage;
}

// Namespace sentry_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x907b0581, Offset: 0x2948
// Size: 0x128
function function_2790de05(turret) {
    self endon(#"exit_vehicle");
    turret endon(#"hash_973e6741");
    level endon(#"hash_161a3f68");
    heat = 0;
    overheat = 0;
    while (true) {
        if (isdefined(self.viewlockedentity)) {
            var_aee11f71 = heat;
            heat = self.viewlockedentity getturretheatvalue(0);
            var_26c60357 = overheat;
            overheat = self.viewlockedentity isvehicleturretoverheating(0);
            if (var_aee11f71 != heat || var_26c60357 != overheat) {
                luinotifyevent(%hud_cic_weapon_heat, 2, int(heat), overheat);
            }
        }
        wait 0.05;
    }
}

// Namespace sentry_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x85356397, Offset: 0x2a78
// Size: 0x2c
function function_aa320a88(victim) {
    function_c8f2c95d(victim.origin);
}

// Namespace sentry_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x18c56841, Offset: 0x2ab0
// Size: 0x84
function turret_idle_sound() {
    sndloop_ent = spawn("script_origin", self.origin);
    sndloop_ent linkto(self);
    sndloop_ent playloopsound("veh_turret_idle");
    self thread turret_idle_sound_stop(sndloop_ent);
}

// Namespace sentry_turret
// Params 1, eflags: 0x1 linked
// Checksum 0xc9afb3ac, Offset: 0x2b40
// Size: 0x54
function turret_idle_sound_stop(sndloop_ent) {
    self waittill(#"death");
    sndloop_ent stoploopsound(0.5);
    wait 2;
    sndloop_ent delete();
}

