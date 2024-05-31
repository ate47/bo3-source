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

#namespace auto_turret;

// Namespace auto_turret
// Params 0, eflags: 0x2
// Checksum 0xb99d1daf, Offset: 0x380
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("auto_turret", &__init__, undefined, undefined);
}

// Namespace auto_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x52836a5, Offset: 0x3c0
// Size: 0x2c
function __init__() {
    vehicle::add_main_callback("auto_turret", &function_a5dc0bd1);
}

// Namespace auto_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x2e56ba89, Offset: 0x3f8
// Size: 0x25c
function function_a5dc0bd1() {
    self.health = self.healthdefault;
    if (isdefined(self.scriptbundlesettings)) {
        self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    } else {
        self.settings = struct::get_script_bundle("vehiclecustomsettings", "artillerysettings");
    }
    sightfov = self.settings.sightfov;
    if (!isdefined(sightfov)) {
        sightfov = 0;
    }
    self.fovcosine = cos(sightfov - 0.1);
    self.fovcosinebusy = cos(sightfov - 0.1);
    if (self.settings.disconnectpaths === 1) {
        self disconnectpaths();
    }
    if (self.settings.ignoreme === 1) {
        self.ignoreme = 1;
    }
    if (self.settings.laseron === 1) {
        self laseron();
    }
    if (self.settings.disablefiring !== 1) {
        self enableaimassist();
    } else {
        self.nocybercom = 1;
    }
    self thread turret::track_lens_flare();
    self.overridevehicledamage = &turretcallback_vehicledamage;
    self.allowfriendlyfiredamageoverride = &turretallowfriendlyfiredamage;
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    self.var_375cf54a = 1;
    self.var_3a087745 = 1;
    self vehicle_ai::function_a767f9b4();
    defaultrole();
}

// Namespace auto_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x86ca40f3, Offset: 0x660
// Size: 0x30c
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
    self vehicle_ai::get_state_callbacks("off").enter_func = &state_off_enter;
    self vehicle_ai::get_state_callbacks("off").exit_func = &state_off_exit;
    self vehicle_ai::get_state_callbacks("emped").enter_func = &state_emped_enter;
    self vehicle_ai::get_state_callbacks("emped").update_func = &state_emped_update;
    self vehicle_ai::get_state_callbacks("emped").exit_func = &state_emped_exit;
    self vehicle_ai::add_state("unaware", undefined, &state_unaware_update, undefined);
    vehicle_ai::add_interrupt_connection("unaware", "scripted", "enter_scripted");
    vehicle_ai::add_interrupt_connection("unaware", "emped", "emped");
    vehicle_ai::add_interrupt_connection("unaware", "off", "shut_off");
    vehicle_ai::add_interrupt_connection("unaware", "driving", "enter_vehicle");
    vehicle_ai::add_interrupt_connection("unaware", "pain", "pain");
    vehicle_ai::add_utility_connection("unaware", "combat", &should_switch_to_combat);
    vehicle_ai::add_utility_connection("combat", "unaware", &should_switch_to_unaware);
    vehicle_ai::startinitialstate("unaware");
}

// Namespace auto_turret
// Params 1, eflags: 0x1 linked
// Checksum 0xb45631d2, Offset: 0x978
// Size: 0x10c
function state_death_update(params) {
    self endon(#"death");
    owner = self getvehicleowner();
    if (isdefined(owner)) {
        self waittill(#"exit_vehicle");
    }
    self setturretspinning(0);
    self turret::toggle_lensflare(0);
    params.death_type = "default";
    self thread turret_idle_sound_stop();
    self playsound("veh_sentry_turret_dmg_hit");
    self.turretrotscale = 2;
    self rest_turret(params.resting_pitch);
    self vehicle_ai::defaultstate_death_update(params);
}

// Namespace auto_turret
// Params 3, eflags: 0x1 linked
// Checksum 0x6731b2cf, Offset: 0xa90
// Size: 0x58
function should_switch_to_unaware(current_state, to_state, connection) {
    if (!isdefined(self.enemy) || !self function_6d424c6f(self.enemy, 1.5)) {
        return 100;
    }
    return 0;
}

// Namespace auto_turret
// Params 1, eflags: 0x1 linked
// Checksum 0xcf7c0e7a, Offset: 0xaf0
// Size: 0x280
function state_unaware_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    turret_left = 1;
    relativeangle = 0;
    self thread turret_idle_sound();
    self playsound("mpl_turret_startup");
    self cleartargetentity();
    while (true) {
        rotscale = self.settings.scanning_speedscale;
        if (!isdefined(rotscale)) {
            rotscale = 0.01;
        }
        self.turretrotscale = rotscale;
        scanning_arc = self.settings.scanning_arc;
        if (!isdefined(scanning_arc)) {
            scanning_arc = 0;
        }
        limits = self getturretlimitsyaw();
        scanning_arc = min(scanning_arc, limits[0] - 0.1);
        scanning_arc = min(scanning_arc, limits[1] - 0.1);
        if (scanning_arc > -77) {
            if (self.turretontarget) {
                relativeangle += 90;
                if (relativeangle > -76) {
                    relativeangle -= 360;
                }
            }
            scanning_arc = relativeangle;
        } else {
            if (self.turretontarget) {
                turret_left = !turret_left;
            }
            if (!turret_left) {
                scanning_arc *= -1;
            }
        }
        scanning_pitch = self.settings.scanning_pitch;
        if (!isdefined(scanning_pitch)) {
            scanning_pitch = 0;
        }
        self function_d013f7fa((scanning_pitch, scanning_arc, 0));
        self vehicle_ai::evaluate_connections();
        wait(0.5);
    }
}

// Namespace auto_turret
// Params 3, eflags: 0x1 linked
// Checksum 0x525f8355, Offset: 0xd78
// Size: 0x6e
function should_switch_to_combat(current_state, to_state, connection) {
    if (isdefined(self.enemy) && isalive(self.enemy) && self function_4246bc05(self.enemy)) {
        return 100;
    }
    return 0;
}

// Namespace auto_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x74dd4153, Offset: 0xdf0
// Size: 0x358
function state_combat_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    if (isdefined(self.enemy)) {
        sentry_turret_alert_sound();
        wait(0.5);
    }
    while (true) {
        if (isdefined(self.enemy) && self function_4246bc05(self.enemy)) {
            self.turretrotscale = 1;
            if (isdefined(self.enemy) && self haspart("tag_minigun_spin")) {
                self setturrettargetent(self.enemy);
                self setturretspinning(1);
                wait(0.5);
            }
            for (i = 0; i < 3; i++) {
                if (isdefined(self.enemy) && isalive(self.enemy) && self function_4246bc05(self.enemy)) {
                    self setturrettargetent(self.enemy);
                    wait(0.1);
                    waittime = randomfloatrange(0.4, 1.5);
                    if (self.settings.disablefiring !== 1) {
                        self sentry_turret_fire_for_time(waittime, self.enemy);
                    } else {
                        wait(waittime);
                    }
                }
                if (isdefined(self.enemy) && isplayer(self.enemy)) {
                    wait(randomfloatrange(0.3, 0.6));
                    continue;
                }
                wait(randomfloatrange(0.3, 0.6) * 2);
            }
            self setturretspinning(0);
            if (isdefined(self.enemy) && isalive(self.enemy) && self function_4246bc05(self.enemy)) {
                if (isplayer(self.enemy)) {
                    wait(randomfloatrange(0.5, 1.3));
                } else {
                    wait(randomfloatrange(0.5, 1.3) * 2);
                }
            }
        }
        self vehicle_ai::evaluate_connections();
        wait(0.5);
    }
}

// Namespace auto_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x327f244, Offset: 0x1150
// Size: 0x24
function state_combat_exit(params) {
    self setturretspinning(0);
}

// Namespace auto_turret
// Params 2, eflags: 0x1 linked
// Checksum 0xb8a1785b, Offset: 0x1180
// Size: 0x15c
function sentry_turret_fire_for_time(totalfiretime, enemy) {
    self endon(#"death");
    self endon(#"change_state");
    sentry_turret_alert_sound();
    wait(0.1);
    weapon = self seatgetweapon(0);
    firetime = weapon.firetime;
    time = 0;
    is_minigun = 0;
    if (issubstr(weapon.name, "minigun")) {
        is_minigun = 1;
        self setturretspinning(1);
        wait(0.5);
    }
    while (time < totalfiretime) {
        self fireweapon(0, enemy);
        wait(firetime);
        time += firetime;
    }
    if (is_minigun) {
        self setturretspinning(0);
    }
}

// Namespace auto_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x20072808, Offset: 0x12e8
// Size: 0x54
function state_off_enter(params) {
    self vehicle_ai::defaultstate_off_enter(params);
    self.turretrotscale = 0.5;
    self rest_turret(params.resting_pitch);
}

// Namespace auto_turret
// Params 1, eflags: 0x1 linked
// Checksum 0xf7de4d69, Offset: 0x1348
// Size: 0x54
function state_off_exit(params) {
    self vehicle_ai::defaultstate_off_exit(params);
    self.turretrotscale = 1;
    self playsound("mpl_turret_startup");
}

// Namespace auto_turret
// Params 1, eflags: 0x1 linked
// Checksum 0xf80e3876, Offset: 0x13a8
// Size: 0x9c
function rest_turret(resting_pitch) {
    if (!isdefined(resting_pitch)) {
        resting_pitch = self.settings.resting_pitch;
    }
    if (!isdefined(resting_pitch)) {
        resting_pitch = 0;
    }
    angles = self gettagangles("tag_turret") - self.angles;
    self function_d013f7fa((resting_pitch, angles[1], 0));
}

// Namespace auto_turret
// Params 1, eflags: 0x1 linked
// Checksum 0xf16681bc, Offset: 0x1450
// Size: 0x164
function state_emped_enter(params) {
    self vehicle_ai::defaultstate_emped_enter(params);
    playsoundatposition("veh_sentry_turret_emp_down", self.origin);
    self.turretrotscale = 0.5;
    self rest_turret(params.resting_pitch);
    params.laseron = islaseron(self);
    self laseroff();
    self vehicle::lights_off();
    if (!isdefined(self.abnormal_status)) {
        self.abnormal_status = spawnstruct();
    }
    self.abnormal_status.emped = 1;
    self.abnormal_status.attacker = params.var_6e0794d4[1];
    self.abnormal_status.inflictor = params.var_6e0794d4[2];
    self vehicle::toggle_emp_fx(1);
}

// Namespace auto_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x6fb30bbb, Offset: 0x15c0
// Size: 0x14c
function state_emped_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    time = params.var_6e0794d4[0];
    assert(isdefined(time));
    vehicle_ai::cooldown("emped_timer", time);
    while (!vehicle_ai::iscooldownready("emped_timer")) {
        timeleft = max(vehicle_ai::getcooldownleft("emped_timer"), 0.5);
        wait(timeleft);
    }
    self.abnormal_status.emped = 0;
    self vehicle::toggle_emp_fx(0);
    self vehicle_ai::emp_startup_fx();
    self rest_turret(0);
    wait(1);
    self vehicle_ai::evaluate_connections();
}

// Namespace auto_turret
// Params 1, eflags: 0x1 linked
// Checksum 0x37681f44, Offset: 0x1718
// Size: 0x54
function state_emped_exit(params) {
    self vehicle_ai::defaultstate_emped_exit(params);
    self.turretrotscale = 1;
    self playsound("mpl_turret_startup");
}

// Namespace auto_turret
// Params 1, eflags: 0x0
// Checksum 0x675d70fd, Offset: 0x1778
// Size: 0x18
function state_scripted_update(params) {
    self.turretrotscale = 1;
}

// Namespace auto_turret
// Params 4, eflags: 0x1 linked
// Checksum 0x50cd8a70, Offset: 0x1798
// Size: 0x50
function turretallowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
    if (isdefined(eattacker) && isdefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE") {
        return true;
    }
    return false;
}

// Namespace auto_turret
// Params 15, eflags: 0x1 linked
// Checksum 0xcf0b9240, Offset: 0x17f0
// Size: 0xd4
function turretcallback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    return idamage;
}

// Namespace auto_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x783ab026, Offset: 0x18d0
// Size: 0x24
function sentry_turret_alert_sound() {
    self playsound("veh_turret_alert");
}

// Namespace auto_turret
// Params 0, eflags: 0x1 linked
// Checksum 0x447553a, Offset: 0x1900
// Size: 0x74
function turret_idle_sound() {
    if (!isdefined(self.sndloop_ent)) {
        self.sndloop_ent = spawn("script_origin", self.origin);
        self.sndloop_ent linkto(self);
        self.sndloop_ent playloopsound("veh_turret_idle");
    }
}

// Namespace auto_turret
// Params 0, eflags: 0x1 linked
// Checksum 0xd66f029d, Offset: 0x1980
// Size: 0x5c
function turret_idle_sound_stop() {
    self endon(#"death");
    if (isdefined(self.sndloop_ent)) {
        self.sndloop_ent stoploopsound(0.5);
        wait(2);
        self.sndloop_ent delete();
    }
}

