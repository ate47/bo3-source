#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;

#using_animtree("generic");

#namespace vehicle_ai;

// Namespace vehicle_ai
// Params 0, eflags: 0x2
// Checksum 0x22a80dd0, Offset: 0x488
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("vehicle_ai", &__init__, undefined, undefined);
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x4c8
// Size: 0x4
function __init__() {
    
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xc63df162, Offset: 0x4d8
// Size: 0x3c
function function_ca333919(archetype) {
    ai::registermatchedinterface(archetype, "force_high_speed", 0, array(1, 0));
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x2bc4137e, Offset: 0x520
// Size: 0x122
function function_a767f9b4() {
    aiarray = getaiarray();
    foreach (ai in aiarray) {
        if (ai === self) {
            continue;
        }
        if (self.var_375cf54a === 1 && ai.firefly === 1) {
            self setpersonalignore(ai);
        }
        if (self.var_3a087745 === 1 && ai.var_e42818a3 === 1) {
            self setpersonalignore(ai);
        }
    }
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0xf05386d0, Offset: 0x650
// Size: 0xbc
function entityisarchetype(entity, archetype) {
    if (!isdefined(entity)) {
        return false;
    }
    if (isplayer(entity) && entity.usingvehicle && isdefined(entity.viewlockedentity) && entity.viewlockedentity.archetype === archetype) {
        return true;
    }
    if (isvehicle(entity) && entity.archetype === archetype) {
        return true;
    }
    return false;
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0xbc86bbe7, Offset: 0x718
// Size: 0x52
function getenemytarget() {
    if (isdefined(self.enemy) && self function_4246bc05(self.enemy)) {
        return self.enemy;
    } else if (isdefined(self.enemylastseenpos)) {
        return self.enemylastseenpos;
    }
    return undefined;
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0x84cd94cd, Offset: 0x778
// Size: 0x114
function gettargetpos(target, geteye) {
    pos = undefined;
    if (isdefined(target)) {
        if (isvec(target)) {
            pos = target;
        } else if (isdefined(geteye) && geteye && issentient(target)) {
            pos = target geteye();
        } else if (isentity(target)) {
            pos = target.origin;
        } else if (isdefined(target.origin) && isvec(target.origin)) {
            pos = target.origin;
        }
    }
    return pos;
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xb111546e, Offset: 0x898
// Size: 0x6a
function gettargeteyeoffset(target) {
    offset = (0, 0, 0);
    if (isdefined(target) && issentient(target)) {
        offset = target geteye() - target.origin;
    }
    return offset;
}

// Namespace vehicle_ai
// Params 4, eflags: 0x0
// Checksum 0x2f425e0e, Offset: 0x910
// Size: 0x174
function fire_for_time(totalfiretime, turretidx, target, intervalscale) {
    if (!isdefined(intervalscale)) {
        intervalscale = 1;
    }
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"fire_stop");
    self endon(#"fire_stop");
    if (!isdefined(turretidx)) {
        turretidx = 0;
    }
    weapon = self seatgetweapon(turretidx);
    assert(isdefined(weapon) && weapon.name != "<dev string:x28>" && weapon.firetime > 0);
    firetime = weapon.firetime * intervalscale;
    firecount = int(floor(totalfiretime / firetime)) + 1;
    __fire_for_rounds_internal(firecount, firetime, turretidx, target);
}

// Namespace vehicle_ai
// Params 3, eflags: 0x0
// Checksum 0xa4fccb6e, Offset: 0xa90
// Size: 0xec
function fire_for_rounds(firecount, turretidx, target) {
    self endon(#"death");
    self endon(#"fire_stop");
    self endon(#"change_state");
    if (!isdefined(turretidx)) {
        turretidx = 0;
    }
    weapon = self seatgetweapon(turretidx);
    assert(isdefined(weapon) && weapon.name != "<dev string:x28>" && weapon.firetime > 0);
    __fire_for_rounds_internal(firecount, weapon.firetime, turretidx, target);
}

// Namespace vehicle_ai
// Params 4, eflags: 0x0
// Checksum 0x62dd2d6c, Offset: 0xb88
// Size: 0x21c
function __fire_for_rounds_internal(firecount, fireinterval, turretidx, target) {
    self endon(#"death");
    self endon(#"fire_stop");
    self endon(#"change_state");
    if (isdefined(target) && issentient(target)) {
        target endon(#"death");
    }
    assert(isdefined(turretidx));
    var_d10e198b = 1;
    if (isdefined(target) && !isplayer(target) && isai(target) || isdefined(self.var_b027b297)) {
        var_d10e198b = 2;
    }
    counter = 0;
    while (counter < firecount) {
        if (self.avoid_shooting_owner === 1 && self owner_in_line_of_fire()) {
            wait fireinterval;
            continue;
        }
        if (isdefined(target) && !isvec(target) && isdefined(target.attackeraccuracy) && target.attackeraccuracy == 0) {
            self fireturret(turretidx, 1);
        } else if (var_d10e198b > 1) {
            self fireturret(turretidx, counter % var_d10e198b);
        } else {
            self fireturret(turretidx);
        }
        counter++;
        wait fireinterval;
    }
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x41604a55, Offset: 0xdb0
// Size: 0x12a
function owner_in_line_of_fire() {
    if (!isdefined(self.owner)) {
        return false;
    }
    dist_squared_to_owner = distancesquared(self.owner.origin, self.origin);
    line_of_fire_dot = dist_squared_to_owner < 9216 ? 0.866 : 0.9848;
    gun_angles = self gettagangles(isdefined(self.avoid_shooting_owner_ref_tag) ? self.avoid_shooting_owner_ref_tag : "tag_flash");
    gun_forward = anglestoforward(gun_angles);
    dot = vectordot(gun_forward, vectornormalize(self.owner.origin - self.origin));
    return dot > line_of_fire_dot;
}

// Namespace vehicle_ai
// Params 3, eflags: 0x0
// Checksum 0xdb976140, Offset: 0xee8
// Size: 0x14c
function setturrettarget(target, turretidx, offset) {
    if (!isdefined(turretidx)) {
        turretidx = 0;
    }
    if (!isdefined(offset)) {
        offset = (0, 0, 0);
    }
    if (isentity(target)) {
        if (turretidx == 0) {
            self setturrettargetent(target, offset);
        } else {
            self function_9af49228(target, offset, turretidx - 1);
        }
        return;
    }
    if (isvec(target)) {
        origin = target + offset;
        if (turretidx == 0) {
            self setturrettargetvec(target);
        } else {
            self function_6521eb5d(target, turretidx - 1);
        }
        return;
    }
    assertmsg("<dev string:x2d>");
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0x27deb27d, Offset: 0x1040
// Size: 0x34
function fireturret(turretidx, var_2b904ac6) {
    self fireweapon(turretidx, undefined, undefined, self);
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x695829d9, Offset: 0x1080
// Size: 0xe4
function javelin_losetargetatrighttime(target) {
    self endon(#"death");
    self waittill(#"weapon_fired", proj);
    if (!isdefined(proj)) {
        return;
    }
    proj endon(#"death");
    wait 2;
    while (isdefined(target)) {
        if (proj getvelocity()[2] < -150 && distancesquared(proj.origin, target.origin) < 1200 * 1200) {
            proj missile_settarget(undefined);
            break;
        }
        wait 0.1;
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xd130444c, Offset: 0x1170
// Size: 0x74
function waittill_pathing_done(maxtime) {
    if (!isdefined(maxtime)) {
        maxtime = 15;
    }
    self endon(#"change_state");
    self util::function_183e3618(maxtime, "near_goal", "force_goal", "reached_end_node", "goal", "pathfind_failed", "change_state");
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x2f53de23, Offset: 0x11f0
// Size: 0x86
function waittill_pathresult(maxtime) {
    if (!isdefined(maxtime)) {
        maxtime = 0.5;
    }
    self endon(#"change_state");
    result = self util::waittill_any_timeout(maxtime, "pathfind_failed", "pathfind_succeeded", "change_state");
    succeeded = result === "pathfind_succeeded";
    return succeeded;
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x99e99fb8, Offset: 0x1280
// Size: 0x4a
function waittill_asm_terminated() {
    self endon(#"death");
    self notify(#"end_asm_terminated_thread");
    self endon(#"end_asm_terminated_thread");
    self waittill(#"asm_terminated");
    self notify(#"asm_complete", "__terminated__");
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x8e8cb833, Offset: 0x12d8
// Size: 0x4a
function waittill_asm_timeout(timeout) {
    self endon(#"death");
    self notify(#"end_asm_timeout_thread");
    self endon(#"end_asm_timeout_thread");
    wait timeout;
    self notify(#"asm_complete", "__timeout__");
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0x5301d55d, Offset: 0x1330
// Size: 0xd6
function waittill_asm_complete(substate_to_wait, timeout) {
    if (!isdefined(timeout)) {
        timeout = 10;
    }
    self endon(#"death");
    self thread waittill_asm_terminated();
    self thread waittill_asm_timeout(timeout);
    substate = undefined;
    while (substate != substate_to_wait && substate != "__terminated__" && (!isdefined(substate) || substate != "__timeout__")) {
        self waittill(#"asm_complete", substate);
    }
    self notify(#"end_asm_terminated_thread");
    self notify(#"end_asm_timeout_thread");
}

// Namespace vehicle_ai
// Params 4, eflags: 0x0
// Checksum 0xa47b5bcb, Offset: 0x1410
// Size: 0x1e4
function throw_off_balance(damagetype, hitpoint, hitdirection, hitlocationinfo) {
    if (damagetype == "MOD_EXPLOSIVE" || damagetype == "MOD_GRENADE_SPLASH" || damagetype == "MOD_PROJECTILE_SPLASH") {
        self setvehvelocity(self.velocity + vectornormalize(hitdirection) * 300);
        ang_vel = self getangularvelocity();
        ang_vel += (randomfloatrange(-300, 300), randomfloatrange(-300, 300), randomfloatrange(-300, 300));
        self setangularvelocity(ang_vel);
        return;
    }
    ang_vel = self getangularvelocity();
    yaw_vel = randomfloatrange(-320, 320);
    yaw_vel += math::sign(yaw_vel) * -106;
    ang_vel += (randomfloatrange(-150, -106), yaw_vel, randomfloatrange(-150, -106));
    self setangularvelocity(ang_vel);
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0xe005a867, Offset: 0x1600
// Size: 0x7a
function predicted_collision() {
    self endon(#"crash_done");
    self endon(#"death");
    while (true) {
        self waittill(#"veh_predictedcollision", velocity, normal);
        if (normal[2] >= 0.6) {
            self notify(#"veh_collision", velocity, normal);
        }
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xed4a3458, Offset: 0x1688
// Size: 0x7c
function collision_fx(normal) {
    tilted = normal[2] < 0.6;
    fx_origin = self.origin - normal * (tilted ? 28 : 10);
    self playsound("veh_wasp_wall_imp");
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x65f8c6eb, Offset: 0x1710
// Size: 0x3ce
function nudge_collision() {
    self endon(#"crash_done");
    self endon(#"power_off_done");
    self endon(#"death");
    self notify(#"end_nudge_collision");
    self endon(#"end_nudge_collision");
    if (self.notsolid === 1) {
        return;
    }
    while (true) {
        self waittill(#"veh_collision", velocity, normal);
        ang_vel = self getangularvelocity() * 0.5;
        self setangularvelocity(ang_vel);
        empedoroff = self get_current_state() === "emped" || self get_current_state() === "off";
        if (normal[2] < 0.6 || isalive(self) && !empedoroff) {
            self setvehvelocity(self.velocity + normal * 90);
            self collision_fx(normal);
            continue;
        }
        if (empedoroff) {
            if (isdefined(self.bounced)) {
                self playsound("veh_wasp_wall_imp");
                self setvehvelocity((0, 0, 0));
                self setangularvelocity((0, 0, 0));
                pitch = self.angles[0];
                pitch = math::sign(pitch) * math::clamp(abs(pitch), 10, 15);
                self.angles = (pitch, self.angles[1], self.angles[2]);
                self.bounced = undefined;
                self notify(#"landed");
                return;
            } else {
                self.bounced = 1;
                self setvehvelocity(self.velocity + normal * 30);
                self collision_fx(normal);
            }
            continue;
        }
        impact_vel = abs(vectordot(velocity, normal));
        if (normal[2] < 0.6 && impact_vel < 100) {
            self setvehvelocity(self.velocity + normal * 90);
            self collision_fx(normal);
            continue;
        }
        self playsound("veh_wasp_ground_death");
        self thread vehicle_death::death_fire_loop_audio();
        self notify(#"crash_done");
    }
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0xc717cf64, Offset: 0x1ae8
// Size: 0x100
function level_out_for_landing() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"landed");
    while (true) {
        velocity = self.velocity;
        self.angles = (self.angles[0] * 0.85, self.angles[1], self.angles[2] * 0.85);
        ang_vel = self getangularvelocity() * 0.85;
        self setangularvelocity(ang_vel);
        self setvehvelocity(velocity + (0, 0, -60));
        wait 0.05;
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x2714a9f2, Offset: 0x1bf0
// Size: 0x34
function immolate(attacker) {
    self endon(#"death");
    self thread burning_thread(attacker, attacker);
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0x5d375f20, Offset: 0x1c30
// Size: 0x2a4
function burning_thread(attacker, inflictor) {
    self endon(#"death");
    self notify(#"end_immolating_thread");
    self endon(#"end_immolating_thread");
    damagepersecond = self.settings.burn_damagepersecond;
    if (!isdefined(damagepersecond) || damagepersecond <= 0) {
        return;
    }
    secondsperonedamage = 1 / float(damagepersecond);
    if (!isdefined(self.abnormal_status)) {
        self.abnormal_status = spawnstruct();
    }
    if (self.abnormal_status.burning !== 1) {
        self vehicle::toggle_burn_fx(1);
    }
    self.abnormal_status.burning = 1;
    self.abnormal_status.attacker = attacker;
    self.abnormal_status.inflictor = inflictor;
    lastingtime = self.settings.burn_lastingtime;
    if (!isdefined(lastingtime)) {
        lastingtime = 999999;
    }
    starttime = gettime();
    interval = max(secondsperonedamage, 0.5);
    for (damage = 0; timesince(starttime) < lastingtime; damage -= damageint) {
        previoustime = gettime();
        wait interval;
        damage += timesince(previoustime) * damagepersecond;
        damageint = int(damage);
        self dodamage(damageint, self.origin, attacker, self, "none", "MOD_BURNED");
    }
    self.abnormal_status.burning = 0;
    self vehicle::toggle_burn_fx(0);
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0xa0435258, Offset: 0x1ee0
// Size: 0x2e
function iff_notifymeinnsec(time, note) {
    self endon(#"death");
    wait time;
    self notify(note);
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0x4ef27cd4, Offset: 0x1f18
// Size: 0x1e4
function iff_override(owner, time) {
    if (!isdefined(time)) {
        time = 60;
    }
    self endon(#"death");
    self._iffoverride_oldteam = self.team;
    self iff_override_team_switch_behavior(owner.team);
    if (isdefined(self.iff_override_cb)) {
        self [[ self.iff_override_cb ]](1);
    }
    if (isdefined(self.settings) && !(isdefined(self.settings.iffshouldrevertteam) && self.settings.iffshouldrevertteam)) {
        return;
    }
    timeout = isdefined(self.settings) ? self.settings.ifftimetillrevert : time;
    assert(timeout > 10);
    self thread iff_notifymeinnsec(timeout - 10, "iff_override_revert_warn");
    msg = self util::waittill_any_timeout(timeout, "iff_override_reverted", "death");
    if (msg == "timeout") {
        self notify(#"iff_override_reverted");
    }
    self playsound("gdt_iff_deactivate");
    self iff_override_team_switch_behavior(self._iffoverride_oldteam);
    if (isdefined(self.iff_override_cb)) {
        self [[ self.iff_override_cb ]](0);
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xa9b1a471, Offset: 0x2108
// Size: 0xd0
function iff_override_team_switch_behavior(team) {
    self endon(#"death");
    var_6a7b0a9f = self.ignoreme;
    self.ignoreme = 1;
    self start_scripted();
    self vehicle::lights_off();
    wait 0.1;
    wait 1;
    self setteam(team);
    self blink_lights_for_time(1);
    self stop_scripted();
    wait 1;
    self.ignoreme = var_6a7b0a9f;
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x73d09bb3, Offset: 0x21e0
// Size: 0xb4
function blink_lights_for_time(time) {
    self endon(#"death");
    starttime = gettime();
    self vehicle::lights_off();
    wait 0.1;
    while (gettime() < starttime + time * 1000) {
        self vehicle::lights_off();
        wait 0.2;
        self vehicle::lights_on();
        wait 0.2;
    }
    self vehicle::lights_on();
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x97db72e5, Offset: 0x22a0
// Size: 0x12
function turnoff() {
    self notify(#"shut_off");
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x65cffd1c, Offset: 0x22c0
// Size: 0x12
function turnon() {
    self notify(#"start_up");
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0xb60ee7ce, Offset: 0x22e0
// Size: 0xc4
function turnoffalllightsandlaser() {
    self laseroff();
    self vehicle::lights_off();
    self vehicle::toggle_lights_group(1, 0);
    self vehicle::toggle_lights_group(2, 0);
    self vehicle::toggle_lights_group(3, 0);
    self vehicle::toggle_lights_group(4, 0);
    self vehicle::toggle_burn_fx(0);
    self vehicle::toggle_emp_fx(0);
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x19d9d6c, Offset: 0x23b0
// Size: 0x4c
function turnoffallambientanims() {
    self vehicle::toggle_ambient_anim_group(1, 0);
    self vehicle::toggle_ambient_anim_group(2, 0);
    self vehicle::toggle_ambient_anim_group(3, 0);
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x57b7debe, Offset: 0x2408
// Size: 0x94
function clearalllookingandtargeting() {
    self cleartargetentity();
    self function_bb5f9faa(0);
    self function_bb5f9faa(1);
    self function_bb5f9faa(2);
    self function_bb5f9faa(3);
    self clearlookatent();
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xd8363931, Offset: 0x24a8
// Size: 0xf4
function clearallmovement(zerooutspeed) {
    if (!isdefined(zerooutspeed)) {
        zerooutspeed = 0;
    }
    if (!isairborne(self)) {
        self cancelaimove();
    }
    self clearvehgoalpos();
    self pathvariableoffsetclear();
    self pathfixedoffsetclear();
    if (zerooutspeed === 1) {
        self notify(#"landed");
        self setvehvelocity((0, 0, 0));
        self setphysacceleration((0, 0, 0));
        self setangularvelocity((0, 0, 0));
    }
}

// Namespace vehicle_ai
// Params 15, eflags: 0x0
// Checksum 0xf298ea25, Offset: 0x25a8
// Size: 0x240
function shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (should_emp(self, weapon, smeansofdeath, einflictor, eattacker)) {
        minempdowntime = 0.8 * self.settings.empdowntime;
        maxempdowntime = 1.2 * self.settings.empdowntime;
        self notify(#"emped", randomfloatrange(minempdowntime, maxempdowntime), eattacker, einflictor);
    }
    if (should_burn(self, weapon, smeansofdeath, einflictor, eattacker)) {
        self thread burning_thread(eattacker, einflictor);
    }
    if (!isdefined(self.damagelevel)) {
        self.damagelevel = 0;
        self.newdamagelevel = self.damagelevel;
    }
    newdamagelevel = vehicle::should_update_damage_fx_level(self.health, idamage, self.healthdefault);
    if (newdamagelevel > self.damagelevel) {
        self.newdamagelevel = newdamagelevel;
    }
    if (self.newdamagelevel > self.damagelevel) {
        self.damagelevel = self.newdamagelevel;
        if (self.var_cac92641 === 1) {
            self notify(#"pain");
        }
        vehicle::set_damage_fx_level(self.damagelevel);
    }
    return idamage;
}

// Namespace vehicle_ai
// Params 5, eflags: 0x0
// Checksum 0x8d3f4559, Offset: 0x27f0
// Size: 0x15a
function should_emp(vehicle, weapon, meansofdeath, einflictor, eattacker) {
    if (!isdefined(vehicle) || meansofdeath === "MOD_IMPACT" || vehicle.disableelectrodamage === 1) {
        return 0;
    }
    if (!(isdefined(weapon) && weapon.isemp || meansofdeath === "MOD_ELECTROCUTED")) {
        return 0;
    }
    causer = isdefined(eattacker) ? eattacker : einflictor;
    if (!isdefined(causer)) {
        return 1;
    }
    if (isai(causer) && isvehicle(causer)) {
        return 0;
    }
    if (level.teambased) {
        return (vehicle.team != causer.team);
    }
    if (isdefined(vehicle.owner)) {
        return (vehicle.owner != causer);
    }
    return vehicle != causer;
}

// Namespace vehicle_ai
// Params 5, eflags: 0x0
// Checksum 0x39e2d8aa, Offset: 0x2958
// Size: 0x15a
function should_burn(vehicle, weapon, meansofdeath, einflictor, eattacker) {
    if (level.disablevehicleburndamage === 1 || vehicle.disableburndamage === 1) {
        return 0;
    }
    if (!isdefined(vehicle)) {
        return 0;
    }
    if (meansofdeath !== "MOD_BURNED") {
        return 0;
    }
    if (vehicle === einflictor) {
        return 0;
    }
    causer = isdefined(eattacker) ? eattacker : einflictor;
    if (!isdefined(causer)) {
        return 1;
    }
    if (isai(causer) && isvehicle(causer)) {
        return 0;
    }
    if (level.teambased) {
        return (vehicle.team != causer.team);
    }
    if (isdefined(vehicle.owner)) {
        return (vehicle.owner != causer);
    }
    return vehicle != causer;
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xc9cb0b6, Offset: 0x2ac0
// Size: 0xa4
function startinitialstate(defaultstate) {
    if (!isdefined(defaultstate)) {
        defaultstate = "combat";
    }
    params = spawnstruct();
    params.isinitialstate = 1;
    if (isdefined(self.script_startstate)) {
        self set_state(self.script_startstate, params);
        return;
    }
    self set_state(defaultstate, params);
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0xf60e461d, Offset: 0x2b70
// Size: 0x70
function start_scripted(disable_death_state, no_clear_movement) {
    params = spawnstruct();
    params.no_clear_movement = no_clear_movement;
    self set_state("scripted", params);
    self._no_death_state = disable_death_state;
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x804a0aa4, Offset: 0x2be8
// Size: 0x84
function stop_scripted(statename) {
    if (isalive(self) && is_instate("scripted")) {
        if (isdefined(statename)) {
            self set_state(statename);
            return;
        }
        self set_state("combat");
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x482669b3, Offset: 0x2c78
// Size: 0x18
function set_role(rolename) {
    self.current_role = rolename;
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0x103ef3b8, Offset: 0x2c98
// Size: 0x44
function set_state(name, params) {
    self.state_machines[self.current_role] thread statemachine::set_state(name, params);
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0xa4df6ed6, Offset: 0x2ce8
// Size: 0x44
function evaluate_connections(eval_func, params) {
    self.state_machines[self.current_role] statemachine::evaluate_connections(eval_func, params);
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x94835341, Offset: 0x2d38
// Size: 0x6c
function get_state_callbacks(statename) {
    rolename = "default";
    if (isdefined(self.current_role)) {
        rolename = self.current_role;
    }
    if (isdefined(self.state_machines[rolename])) {
        return self.state_machines[rolename].states[statename];
    }
    return undefined;
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0xabbd9bad, Offset: 0x2db0
// Size: 0x60
function get_state_callbacks_for_role(rolename, statename) {
    if (!isdefined(rolename)) {
        rolename = "default";
    }
    if (isdefined(self.state_machines[rolename])) {
        return self.state_machines[rolename].states[statename];
    }
    return undefined;
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0xc002aee0, Offset: 0x2e18
// Size: 0x56
function get_current_state() {
    if (isdefined(self.current_role) && isdefined(self.state_machines[self.current_role].current_state)) {
        return self.state_machines[self.current_role].current_state.name;
    }
    return undefined;
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x8fdb09e1, Offset: 0x2e78
// Size: 0x56
function get_previous_state() {
    if (isdefined(self.current_role) && isdefined(self.state_machines[self.current_role].previous_state)) {
        return self.state_machines[self.current_role].previous_state.name;
    }
    return undefined;
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0xe9cff409, Offset: 0x2ed8
// Size: 0x56
function get_next_state() {
    if (isdefined(self.current_role) && isdefined(self.state_machines[self.current_role].next_state)) {
        return self.state_machines[self.current_role].next_state.name;
    }
    return undefined;
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x3a1aa4bf, Offset: 0x2f38
// Size: 0x64
function is_instate(statename) {
    if (isdefined(self.current_role) && isdefined(self.state_machines[self.current_role].current_state)) {
        return (self.state_machines[self.current_role].current_state.name === statename);
    }
    return false;
}

// Namespace vehicle_ai
// Params 4, eflags: 0x0
// Checksum 0xd793377d, Offset: 0x2fa8
// Size: 0x90
function add_state(name, enter_func, update_func, exit_func) {
    if (isdefined(self.current_role)) {
        statemachine = self.state_machines[self.current_role];
        if (isdefined(statemachine)) {
            state = statemachine statemachine::add_state(name, enter_func, update_func, exit_func);
            return state;
        }
    }
    return undefined;
}

// Namespace vehicle_ai
// Params 4, eflags: 0x0
// Checksum 0x15382124, Offset: 0x3040
// Size: 0x5c
function add_interrupt_connection(from_state_name, to_state_name, on_notify, checkfunc) {
    self.state_machines[self.current_role] statemachine::add_interrupt_connection(from_state_name, to_state_name, on_notify, checkfunc);
}

// Namespace vehicle_ai
// Params 4, eflags: 0x0
// Checksum 0x9acd29f8, Offset: 0x30a8
// Size: 0x5c
function add_utility_connection(from_state_name, to_state_name, checkfunc, defaultscore) {
    self.state_machines[self.current_role] statemachine::add_utility_connection(from_state_name, to_state_name, checkfunc, defaultscore);
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xac220f89, Offset: 0x3110
// Size: 0x708
function init_state_machine_for_role(rolename) {
    if (!isdefined(rolename)) {
        rolename = "default";
    }
    statemachine = statemachine::create(rolename, self);
    statemachine.isrole = 1;
    if (!isdefined(self.current_role)) {
        set_role(rolename);
    }
    statemachine statemachine::add_state("suspend", undefined, undefined, undefined);
    statemachine statemachine::add_state("death", &defaultstate_death_enter, &defaultstate_death_update, undefined);
    statemachine statemachine::add_state("scripted", &defaultstate_scripted_enter, undefined, &defaultstate_scripted_exit);
    statemachine statemachine::add_state("combat", &defaultstate_combat_enter, undefined, &defaultstate_combat_exit);
    statemachine statemachine::add_state("emped", &defaultstate_emped_enter, &defaultstate_emped_update, &defaultstate_emped_exit, &defaultstate_emped_reenter);
    statemachine statemachine::add_state("surge", &function_27cb64b3, &function_2995bfc0, &function_3e758cb3);
    statemachine statemachine::add_state("off", &defaultstate_off_enter, undefined, &defaultstate_off_exit);
    statemachine statemachine::add_state("driving", &defaultstate_driving_enter, undefined, &defaultstate_driving_exit);
    statemachine statemachine::add_state("pain", &defaultstate_pain_enter, undefined, &defaultstate_pain_exit);
    statemachine statemachine::add_interrupt_connection("off", "combat", "start_up");
    statemachine statemachine::add_interrupt_connection("driving", "combat", "exit_vehicle");
    statemachine statemachine::add_utility_connection("emped", "combat");
    statemachine statemachine::add_utility_connection("pain", "combat");
    statemachine statemachine::add_interrupt_connection("combat", "emped", "emped");
    statemachine statemachine::add_interrupt_connection("pain", "emped", "emped");
    statemachine statemachine::add_interrupt_connection("emped", "emped", "emped");
    statemachine statemachine::add_interrupt_connection("combat", "surge", "surge");
    statemachine statemachine::add_interrupt_connection("off", "surge", "surge");
    statemachine statemachine::add_interrupt_connection("pain", "surge", "surge");
    statemachine statemachine::add_interrupt_connection("emped", "surge", "surge");
    statemachine statemachine::add_interrupt_connection("combat", "off", "shut_off");
    statemachine statemachine::add_interrupt_connection("emped", "off", "shut_off");
    statemachine statemachine::add_interrupt_connection("pain", "off", "shut_off");
    statemachine statemachine::add_interrupt_connection("combat", "driving", "enter_vehicle");
    statemachine statemachine::add_interrupt_connection("emped", "driving", "enter_vehicle");
    statemachine statemachine::add_interrupt_connection("off", "driving", "enter_vehicle");
    statemachine statemachine::add_interrupt_connection("pain", "driving", "enter_vehicle");
    statemachine statemachine::add_interrupt_connection("combat", "pain", "pain");
    statemachine statemachine::add_interrupt_connection("emped", "pain", "pain");
    statemachine statemachine::add_interrupt_connection("off", "pain", "pain");
    statemachine statemachine::add_interrupt_connection("driving", "pain", "pain");
    self.overridevehiclekilled = &callback_vehiclekilled;
    self.overridevehicledeathpostgame = &callback_vehiclekilled;
    statemachine thread statemachine::set_state("suspend");
    self thread on_death_cleanup();
    return statemachine;
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x8257be41, Offset: 0x3820
// Size: 0x3a
function register_custom_add_state_callback(func) {
    if (!isdefined(level.level_specific_add_state_callbacks)) {
        level.level_specific_add_state_callbacks = [];
    }
    level.level_specific_add_state_callbacks[level.level_specific_add_state_callbacks.size] = func;
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x43a38276, Offset: 0x3868
// Size: 0x54
function call_custom_add_state_callbacks() {
    if (isdefined(level.level_specific_add_state_callbacks)) {
        for (i = 0; i < level.level_specific_add_state_callbacks.size; i++) {
            self [[ level.level_specific_add_state_callbacks[i] ]]();
        }
    }
}

// Namespace vehicle_ai
// Params 8, eflags: 0x0
// Checksum 0x8bb9cde8, Offset: 0x38c8
// Size: 0x13c
function callback_vehiclekilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    if (isdefined(self._no_death_state) && self._no_death_state) {
        return;
    }
    death_info = spawnstruct();
    death_info.inflictor = einflictor;
    death_info.attacker = eattacker;
    death_info.damage = idamage;
    death_info.meansofdeath = smeansofdeath;
    death_info.weapon = weapon;
    death_info.dir = vdir;
    death_info.hitloc = shitloc;
    death_info.timeoffset = psoffsettime;
    self set_state("death", death_info);
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0xcaca5a10, Offset: 0x3a10
// Size: 0xaa
function on_death_cleanup() {
    state_machines = self.state_machines;
    self waittill(#"free_vehicle");
    foreach (statemachine in state_machines) {
        statemachine statemachine::clear();
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xe02ec71c, Offset: 0x3ac8
// Size: 0xe4
function defaultstate_death_enter(params) {
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    self vehicle::toggle_sounds(0);
    self disableaimassist();
    turnoffalllightsandlaser();
    turnoffallambientanims();
    clearalllookingandtargeting();
    clearallmovement();
    self cancelaimove();
    self.takedamage = 0;
    self vehicle_death::death_cleanup_level_variables();
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x44040a95, Offset: 0x3bb8
// Size: 0x94
function burning_death_fx() {
    if (isdefined(self.settings.burn_death_fx_1) && isdefined(self.settings.burn_death_tag_1)) {
        playfxontag(self.settings.burn_death_fx_1, self, self.settings.burn_death_tag_1);
    }
    if (isdefined(self.settings.burn_death_sound_1)) {
        self playsound(self.settings.burn_death_sound_1);
    }
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x9c7d97ed, Offset: 0x3c58
// Size: 0x94
function emp_death_fx() {
    if (isdefined(self.settings.emp_death_fx_1) && isdefined(self.settings.emp_death_tag_1)) {
        playfxontag(self.settings.emp_death_fx_1, self, self.settings.emp_death_tag_1);
    }
    if (isdefined(self.settings.emp_death_sound_1)) {
        self playsound(self.settings.emp_death_sound_1);
    }
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0xc721e0b8, Offset: 0x3cf8
// Size: 0xfc
function death_radius_damage_special(radiusscale, meansofdamage) {
    self endon(#"death");
    if (!isdefined(self) || self.abandoned === 1 || self.damage_on_death === 0 || self.radiusdamageradius <= 0) {
        return;
    }
    position = self.origin + (0, 0, 15);
    radius = self.radiusdamageradius * radiusscale;
    damagemax = self.radiusdamagemax;
    damagemin = self.radiusdamagemin;
    wait 0.05;
    if (isdefined(self)) {
        self radiusdamage(position, radius, damagemax, damagemin, undefined, meansofdamage);
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xac931e75, Offset: 0x3e00
// Size: 0xb4
function burning_death(params) {
    self endon(#"death");
    self burning_death_fx();
    self.skipfriendlyfirecheck = 1;
    self thread death_radius_damage_special(2, "MOD_BURNED");
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::do_death_dynents(3);
    self vehicle_death::deletewhensafe(10);
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x29d146a6, Offset: 0x3ec0
// Size: 0xb4
function emped_death(params) {
    self endon(#"death");
    self emp_death_fx();
    self.skipfriendlyfirecheck = 1;
    self thread death_radius_damage_special(2, "MOD_ELECTROCUTED");
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::do_death_dynents(2);
    self vehicle_death::deletewhensafe();
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xc997f7b6, Offset: 0x3f80
// Size: 0x9c
function gibbed_death(params) {
    self endon(#"death");
    self vehicle_death::death_fx();
    self thread vehicle_death::death_radius_damage();
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::do_death_dynents();
    self vehicle_death::deletewhensafe();
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x198e5e5e, Offset: 0x4028
// Size: 0x134
function default_death(params) {
    self endon(#"death");
    self vehicle_death::death_fx();
    self thread vehicle_death::death_radius_damage();
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    if (isdefined(level.disable_thermal)) {
        [[ level.disable_thermal ]]();
    }
    waittime = isdefined(self.waittime_before_delete) ? self.waittime_before_delete : 0;
    owner = self getvehicleowner();
    if (isdefined(owner) && self isremotecontrol()) {
        waittime = max(waittime, 4);
    }
    util::waitfortime(waittime);
    vehicle_death::freewhensafe();
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x714f3e04, Offset: 0x4168
// Size: 0x108
function get_death_type(params) {
    if (self.delete_on_death === 1) {
        death_type = "default";
    } else {
        death_type = self.death_type;
    }
    if (!isdefined(death_type)) {
        death_type = params.death_type;
    }
    if (!isdefined(death_type) && isdefined(self.abnormal_status) && self.abnormal_status.burning === 1) {
        death_type = "burning";
    }
    if (isdefined(params.weapon) && (isdefined(self.abnormal_status) && !isdefined(death_type) && self.abnormal_status.emped === 1 || params.weapon.isemp)) {
        death_type = "emped";
    }
    return death_type;
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x8f11ceea, Offset: 0x4278
// Size: 0x14e
function defaultstate_death_update(params) {
    self endon(#"death");
    if (isdefined(level.vehicle_destructer_cb)) {
        [[ level.vehicle_destructer_cb ]](self);
    }
    if (self.delete_on_death === 1) {
        default_death(params);
        vehicle_death::deletewhensafe(0.25);
        return;
    }
    death_type = isdefined(get_death_type(params)) ? get_death_type(params) : "default";
    switch (death_type) {
    case "burning":
        burning_death(params);
        break;
    case "emped":
        emped_death(params);
        break;
    case "gibbed":
        gibbed_death(params);
        break;
    default:
        default_death(params);
        break;
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x803457c, Offset: 0x43d0
// Size: 0x94
function defaultstate_scripted_enter(params) {
    if (params.no_clear_movement !== 1) {
        clearalllookingandtargeting();
        clearallmovement();
        if (hasasm(self)) {
            self asmrequestsubstate("locomotion@movement");
        }
        self resumespeed();
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xb063c4a5, Offset: 0x4470
// Size: 0x44
function defaultstate_scripted_exit(params) {
    if (params.no_clear_movement !== 1) {
        clearalllookingandtargeting();
        clearallmovement();
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x23c8a6e3, Offset: 0x44c0
// Size: 0xc
function defaultstate_combat_enter(params) {
    
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x5145a6b6, Offset: 0x44d8
// Size: 0xc
function defaultstate_combat_exit(params) {
    
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x860ad2b, Offset: 0x44f0
// Size: 0x194
function defaultstate_emped_enter(params) {
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    self vehicle::toggle_sounds(0);
    params.laseron = islaseron(self);
    self laseroff();
    self vehicle::lights_off();
    clearalllookingandtargeting();
    clearallmovement();
    if (isairborne(self)) {
        self setrotorspeed(0);
    }
    if (!isdefined(self.abnormal_status)) {
        self.abnormal_status = spawnstruct();
    }
    self.abnormal_status.emped = 1;
    self.abnormal_status.attacker = params.var_6e0794d4[1];
    self.abnormal_status.inflictor = params.var_6e0794d4[2];
    self vehicle::toggle_emp_fx(1);
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x4ab811eb, Offset: 0x4690
// Size: 0x5c
function emp_startup_fx() {
    if (isdefined(self.settings.emp_startup_fx_1) && isdefined(self.settings.emp_startup_tag_1)) {
        playfxontag(self.settings.emp_startup_fx_1, self, self.settings.emp_startup_tag_1);
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x96a1a4d2, Offset: 0x46f8
// Size: 0x134
function defaultstate_emped_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    time = params.var_6e0794d4[0];
    assert(isdefined(time));
    cooldown("emped_timer", time);
    while (!iscooldownready("emped_timer")) {
        timeleft = max(getcooldownleft("emped_timer"), 0.5);
        wait timeleft;
    }
    self.abnormal_status.emped = 0;
    self vehicle::toggle_emp_fx(0);
    self emp_startup_fx();
    wait 1;
    self evaluate_connections();
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xbd2fcdc0, Offset: 0x4838
// Size: 0xfc
function defaultstate_emped_exit(params) {
    self vehicle::toggle_tread_fx(1);
    self vehicle::toggle_exhaust_fx(1);
    self vehicle::toggle_sounds(1);
    if (params.laseron === 1) {
        self laseron();
    }
    self vehicle::lights_on();
    if (isairborne(self)) {
        self setphysacceleration((0, 0, 0));
        self thread nudge_collision();
        self setrotorspeed(1);
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x2ff93dc7, Offset: 0x4940
// Size: 0x10
function defaultstate_emped_reenter(params) {
    return true;
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x52e18e5c, Offset: 0x4958
// Size: 0xc
function function_27cb64b3(params) {
    
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x53c40913, Offset: 0x4970
// Size: 0xc
function function_3e758cb3(params) {
    
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x91fb6384, Offset: 0x4988
// Size: 0x404
function function_2995bfc0(params) {
    self endon(#"change_state");
    self endon(#"death");
    if (!isdefined(self.abnormal_status)) {
        self.abnormal_status = spawnstruct();
    }
    self.abnormal_status.emped = 1;
    pathfailcount = 0;
    self thread function_bd32466();
    targets = getaiteamarray("axis", "team3");
    arrayremovevalue(targets, self);
    closest = arraygetclosest(self.origin, targets);
    self setspeed(self.settings.var_c46e96db * self.settings.defaultmovespeed);
    starttime = gettime();
    self thread function_cae5a3fd(params.var_6e0794d4[0]);
    while (gettime() - starttime < self.settings.var_f6a8f077 * 1000) {
        if (!isdefined(closest)) {
            self detonate(params.var_6e0794d4[0]);
            continue;
        }
        foundpath = 0;
        targetpos = closest.origin + (0, 0, 32);
        if (isdefined(targetpos)) {
            queryresult = positionquery_source_navigation(targetpos, 0, 64, 35, 5, self);
            foreach (point in queryresult.data) {
                self.current_pathto_pos = point.origin;
                foundpath = self setvehgoalpos(self.current_pathto_pos, 0, 1);
                if (foundpath) {
                    self thread path_update_interrupt(closest, params.var_6e0794d4[0]);
                    pathfailcount = 0;
                    self waittill_pathing_done(self.settings.var_f6a8f077);
                    try_detonate(closest, params.var_6e0794d4[0]);
                    break;
                }
                waittillframeend();
            }
        }
        if (!foundpath) {
            pathfailcount++;
            if (pathfailcount > 10) {
                self detonate(params.var_6e0794d4[0]);
            }
        }
        wait 0.2;
    }
    if (isalive(self)) {
        self detonate(params.var_6e0794d4[0]);
    }
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0x6bf2af6a, Offset: 0x4d98
// Size: 0xd8
function path_update_interrupt(closest, attacker) {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"near_goal");
    self endon(#"reached_end_node");
    wait 0.1;
    while (!self try_detonate(closest, attacker)) {
        if (isdefined(self.current_pathto_pos)) {
            if (distance2dsquared(self.current_pathto_pos, self.goalpos) > self.goalradius * self.goalradius) {
                wait 0.5;
                self notify(#"near_goal");
            }
        }
        wait 0.1;
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x8a4a4be3, Offset: 0x4e78
// Size: 0x64
function function_cae5a3fd(attacker) {
    self endon(#"death");
    self endon(#"change_state");
    wait 0.25 * self.settings.var_f6a8f077;
    self setteam(attacker.team);
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0x567efd0c, Offset: 0x4ee8
// Size: 0x8c
function try_detonate(closest, attacker) {
    if (isdefined(closest) && isalive(closest)) {
        if (distancesquared(closest.origin, self.origin) < 80 * 80) {
            self detonate(attacker);
            return true;
        }
    }
    return false;
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xdb4acf74, Offset: 0x4f80
// Size: 0xac
function detonate(attacker) {
    self setteam(attacker.team);
    self radiusdamage(self.origin + (0, 0, 5), self.settings.var_1b64a6a8, 1500, 1000, attacker, "MOD_EXPLOSIVE");
    if (isalive(self)) {
        self kill();
    }
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0xb397e217, Offset: 0x5038
// Size: 0xb0
function function_bd32466() {
    self endon(#"death");
    self endon(#"change_state");
    while (true) {
        self vehicle::lights_off();
        wait 0.1;
        self vehicle::lights_on("allies");
        wait 0.1;
        self vehicle::lights_off();
        wait 0.1;
        self vehicle::lights_on("axis");
        wait 0.1;
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x2d8116f4, Offset: 0x50f0
// Size: 0x184
function defaultstate_off_enter(params) {
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_exhaust_fx(0);
    self vehicle::toggle_sounds(0);
    self disableaimassist();
    params.laseron = islaseron(self);
    turnoffalllightsandlaser();
    turnoffallambientanims();
    clearalllookingandtargeting();
    clearallmovement();
    if (isdefined(level.disable_thermal)) {
        [[ level.disable_thermal ]]();
    }
    if (isairborne(self)) {
        if (params.isinitialstate !== 1 && params.no_falling !== 1) {
            self setphysacceleration((0, 0, -300));
            self thread level_out_for_landing();
        }
        self setrotorspeed(0);
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xa3d80445, Offset: 0x5280
// Size: 0x14c
function defaultstate_off_exit(params) {
    self vehicle::toggle_tread_fx(1);
    self vehicle::toggle_exhaust_fx(1);
    self vehicle::toggle_sounds(1);
    self enableaimassist();
    if (isairborne(self)) {
        self setphysacceleration((0, 0, 0));
        self thread nudge_collision();
        self setrotorspeed(1);
    }
    if (params.laseron === 1) {
        self laseron();
    }
    if (isdefined(level.enable_thermal)) {
        if (self get_next_state() !== "death") {
            [[ level.enable_thermal ]]();
        }
    }
    self vehicle::lights_on();
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x20d8648f, Offset: 0x53d8
// Size: 0x1ac
function defaultstate_driving_enter(params) {
    params.driver = self getseatoccupant(0);
    assert(isdefined(params.driver));
    self disableaimassist();
    if (level.var_ff266e7) {
        params.driver enableinvulnerability();
        params.driver.ignoreme = 1;
    }
    self.turretrotscale = 1;
    self.team = params.driver.team;
    if (hasasm(self)) {
        self asmrequestsubstate("locomotion@movement");
    }
    self setheliheightcap(1);
    clearalllookingandtargeting();
    clearallmovement();
    self cancelaimove();
    if (isdefined(params.driver) && !isdefined(self.customdamagemonitor)) {
        self thread vehicle::monitor_damage_as_occupant(params.driver);
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x3ac5d332, Offset: 0x5590
// Size: 0xdc
function defaultstate_driving_exit(params) {
    self enableaimassist();
    if (isdefined(params.driver)) {
        params.driver disableinvulnerability();
        params.driver.ignoreme = 0;
    }
    self.turretrotscale = 1;
    self setheliheightcap(0);
    clearalllookingandtargeting();
    clearallmovement();
    if (isdefined(params.driver)) {
        params.driver vehicle::stop_monitor_damage_as_occupant();
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x32bdd794, Offset: 0x5678
// Size: 0x2c
function defaultstate_pain_enter(params) {
    clearalllookingandtargeting();
    clearallmovement();
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xdc743933, Offset: 0x56b0
// Size: 0x2c
function defaultstate_pain_exit(params) {
    clearalllookingandtargeting();
    clearallmovement();
}

// Namespace vehicle_ai
// Params 3, eflags: 0x0
// Checksum 0xfdf6c837, Offset: 0x56e8
// Size: 0x72
function canseeenemyfromposition(position, enemy, sight_check_height) {
    sightcheckorigin = position + (0, 0, sight_check_height);
    return sighttracepassed(sightcheckorigin, enemy.origin + (0, 0, 30), 0, self);
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x43ae0a34, Offset: 0x5768
// Size: 0x7fe
function function_4796e657(sight_check_height) {
    if (self.goalforced) {
        goalpos = getclosestpointonnavmesh(self.goalpos, self.radius * 2, self.radius);
        return goalpos;
    }
    var_cae297db = 90;
    pixbeginevent("vehicle_ai_shared::FindNewPosition");
    queryresult = positionquery_source_navigation(self.origin, 0, 2000, 300, var_cae297db, self, var_cae297db * 2);
    pixendevent();
    positionquery_filter_random(queryresult, 0, 50);
    positionquery_filter_distancetogoal(queryresult, self);
    positionquery_filter_outofgoalanchor(queryresult, 50);
    origin = self.goalpos;
    best_point = undefined;
    best_score = -999999;
    if (isdefined(self.enemy)) {
        positionquery_filter_sight(queryresult, self.enemy.origin, self geteye() - self.origin, self, 0, self.enemy);
        self positionquery_filter_engagementdist(queryresult, self.enemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
        if (turret::has_turret(1)) {
            var_7d8fdc18 = turret::get_target(1);
            if (isdefined(var_7d8fdc18) && var_7d8fdc18 != self.enemy) {
                positionquery_filter_sight(queryresult, var_7d8fdc18.origin, (0, 0, sight_check_height), self, 20, self, "sight2");
            }
        }
        if (turret::has_turret(2)) {
            var_7d8fdc18 = turret::get_target(2);
            if (isdefined(var_7d8fdc18) && var_7d8fdc18 != self.enemy) {
                positionquery_filter_sight(queryresult, var_7d8fdc18.origin, (0, 0, sight_check_height), self, 20, self, "sight3");
            }
        }
        foreach (point in queryresult.data) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x5a>"] = point.distawayfromengagementarea * -1;
            #/
            point.score += point.distawayfromengagementarea * -1;
            if (distance2dsquared(self.origin, point.origin) < 28900) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x69>"] = -170;
                #/
                point.score += -170;
            }
            if (isdefined(point.sight) && point.sight) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x78>"] = -6;
                #/
                point.score += -6;
            }
            if (isdefined(point.sight2) && point.sight2) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x7e>"] = -106;
                #/
                point.score += -106;
            }
            if (isdefined(point.sight3) && point.sight3) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x85>"] = -106;
                #/
                point.score += -106;
            }
            if (point.score > best_score) {
                best_score = point.score;
                best_point = point;
            }
        }
    } else {
        foreach (point in queryresult.data) {
            if (distance2dsquared(self.origin, point.origin) < 28900) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x69>"] = -100;
                #/
                point.score += -100;
            }
            if (point.score > best_score) {
                best_score = point.score;
                best_point = point;
            }
        }
    }
    self positionquery_debugscores(queryresult);
    if (isdefined(best_point)) {
        /#
        #/
        origin = best_point.origin;
    }
    return origin + (0, 0, 10);
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xc25f5ca9, Offset: 0x5f70
// Size: 0x1c
function timesince(starttimeinmilliseconds) {
    return (gettime() - starttimeinmilliseconds) * 0.001;
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x5318df93, Offset: 0x5f98
// Size: 0x1c
function cooldowninit() {
    if (!isdefined(self._cooldown)) {
        self._cooldown = [];
    }
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0x3d3eff66, Offset: 0x5fc0
// Size: 0x42
function cooldown(name, time_seconds) {
    cooldowninit();
    self._cooldown[name] = gettime() + time_seconds * 1000;
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0xb7c6190c, Offset: 0x6010
// Size: 0x54
function getcooldowntimeraw(name) {
    cooldowninit();
    if (!isdefined(self._cooldown[name])) {
        self._cooldown[name] = gettime() - 1;
    }
    return self._cooldown[name];
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x31a30c44, Offset: 0x6070
// Size: 0x40
function getcooldownleft(name) {
    cooldowninit();
    return (getcooldowntimeraw(name) - gettime()) * 0.001;
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0x275e9d6a, Offset: 0x60b8
// Size: 0x72
function iscooldownready(name, timeforward_seconds) {
    cooldowninit();
    if (!isdefined(timeforward_seconds)) {
        timeforward_seconds = 0;
    }
    cooldownreadytime = self._cooldown[name];
    return !isdefined(cooldownreadytime) || gettime() + timeforward_seconds * 1000 > cooldownreadytime;
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x2a236979, Offset: 0x6138
// Size: 0x32
function clearcooldown(name) {
    cooldowninit();
    self._cooldown[name] = gettime() - 1;
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0x99ddd88a, Offset: 0x6178
// Size: 0x56
function addcooldowntime(name, time_seconds) {
    cooldowninit();
    self._cooldown[name] = getcooldowntimeraw(name) + time_seconds * 1000;
}

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0xbaab30f4, Offset: 0x61d8
// Size: 0x98
function clearallcooldowns() {
    if (isdefined(self._cooldown)) {
        foreach (str_name, cooldown in self._cooldown) {
            self._cooldown[str_name] = gettime() - 1;
        }
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x299fceff, Offset: 0x6278
// Size: 0xda
function positionquery_debugscores(queryresult) {
    if (!(isdefined(getdvarint("hkai_debugPositionQuery")) && getdvarint("hkai_debugPositionQuery"))) {
        return;
    }
    foreach (point in queryresult.data) {
        point debugscore(self);
    }
}

// Namespace vehicle_ai
// Params 1, eflags: 0x0
// Checksum 0x7f59c836, Offset: 0x6360
// Size: 0x1c2
function debugscore(entity) {
    /#
        if (!isdefined(self._scoredebug)) {
            return;
        }
        if (!(isdefined(getdvarint("<dev string:x8c>")) && getdvarint("<dev string:x8c>"))) {
            return;
        }
        step = 10;
        count = 1;
        color = (1, 0, 0);
        if (self.score >= 0) {
            color = (0, 1, 0);
        }
        recordstar(self.origin, color);
        record3dtext("<dev string:xa4>" + self.score + "<dev string:xa5>", self.origin - (0, 0, step * count), color);
        foreach (name, score in self._scoredebug) {
            count++;
            record3dtext(name + "<dev string:xa7>" + score, self.origin - (0, 0, step * count), color);
        }
    #/
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0xb4aeae62, Offset: 0x6530
// Size: 0x40
function _less_than_val(left, right) {
    if (!isdefined(left)) {
        return false;
    } else if (!isdefined(right)) {
        return true;
    }
    return left < right;
}

// Namespace vehicle_ai
// Params 3, eflags: 0x0
// Checksum 0x3a65bd8a, Offset: 0x6578
// Size: 0x5c
function _cmp_val(left, right, descending) {
    if (descending) {
        return _less_than_val(right, left);
    }
    return _less_than_val(left, right);
}

// Namespace vehicle_ai
// Params 3, eflags: 0x0
// Checksum 0xc47abc03, Offset: 0x65e0
// Size: 0x4a
function _sort_by_score(left, right, descending) {
    return _cmp_val(left.score, right.score, descending);
}

// Namespace vehicle_ai
// Params 3, eflags: 0x0
// Checksum 0x8edec30e, Offset: 0x6638
// Size: 0x122
function positionquery_filter_random(queryresult, min, max) {
    foreach (point in queryresult.data) {
        score = randomfloatrange(min, max);
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:xa9>"] = score;
        #/
        point.score += score;
    }
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0xb241d1a0, Offset: 0x6768
// Size: 0x74
function positionquery_postprocess_sortscore(queryresult, descending) {
    if (!isdefined(descending)) {
        descending = 1;
    }
    sorted = array::merge_sort(queryresult.data, &_sort_by_score, descending);
    queryresult.data = sorted;
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0x74e4cba1, Offset: 0x67e8
// Size: 0x142
function positionquery_filter_outofgoalanchor(queryresult, tolerance) {
    if (!isdefined(tolerance)) {
        tolerance = 1;
    }
    foreach (point in queryresult.data) {
        if (point.disttogoal > tolerance) {
            score = -10000 - point.disttogoal * 10;
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:xb0>"] = score;
            #/
            point.score += score;
        }
    }
}

// Namespace vehicle_ai
// Params 4, eflags: 0x0
// Checksum 0x4aa76431, Offset: 0x6938
// Size: 0x33e
function positionquery_filter_engagementdist(queryresult, enemy, engagementdistancemin, engagementdistancemax) {
    if (!isdefined(enemy)) {
        return;
    }
    engagementdistance = (engagementdistancemin + engagementdistancemax) * 0.5;
    half_engagement_width = abs(engagementdistancemax - engagementdistance);
    enemy_origin = (enemy.origin[0], enemy.origin[1], 0);
    vec_enemy_to_self = vectornormalize((self.origin[0], self.origin[1], 0) - enemy_origin);
    foreach (point in queryresult.data) {
        point.distawayfromengagementarea = 0;
        vec_enemy_to_point = (point.origin[0], point.origin[1], 0) - enemy_origin;
        dist_in_front_of_enemy = vectordot(vec_enemy_to_point, vec_enemy_to_self);
        if (abs(dist_in_front_of_enemy) < engagementdistancemin) {
            dist_in_front_of_enemy = engagementdistancemin * -1;
        }
        dist_away_from_sweet_line = abs(dist_in_front_of_enemy - engagementdistance);
        if (dist_away_from_sweet_line > half_engagement_width) {
            point.distawayfromengagementarea = dist_away_from_sweet_line - half_engagement_width;
        }
        too_far_dist = engagementdistancemax * 1.1;
        too_far_dist_sq = too_far_dist * too_far_dist;
        dist_from_enemy_sq = distance2dsquared(point.origin, enemy_origin);
        if (dist_from_enemy_sq > too_far_dist_sq) {
            ratiosq = dist_from_enemy_sq / too_far_dist_sq;
            dist = ratiosq * too_far_dist;
            dist_outside = dist - too_far_dist;
            if (dist_outside > point.distawayfromengagementarea) {
                point.distawayfromengagementarea = dist_outside;
            }
        }
    }
}

// Namespace vehicle_ai
// Params 4, eflags: 0x0
// Checksum 0x53b3a1b3, Offset: 0x6c80
// Size: 0x29e
function positionquery_filter_distawayfromtarget(queryresult, targetarray, distance, tooclosepenalty) {
    if (!isdefined(targetarray) || !isarray(targetarray)) {
        return;
    }
    foreach (point in queryresult.data) {
        tooclose = 0;
        foreach (target in targetarray) {
            origin = undefined;
            if (isvec(target)) {
                origin = target;
            } else if (issentient(target) && isalive(target)) {
                origin = target.origin;
            } else if (isentity(target)) {
                origin = target.origin;
            }
            if (isdefined(origin) && distance2dsquared(point.origin, origin) < distance * distance) {
                tooclose = 1;
                break;
            }
        }
        if (tooclose) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:xc0>"] = tooclosepenalty;
            #/
            point.score += tooclosepenalty;
        }
    }
}

// Namespace vehicle_ai
// Params 4, eflags: 0x0
// Checksum 0x1815be84, Offset: 0x6f28
// Size: 0x122
function distancepointtoengagementheight(origin, enemy, engagementheightmin, engagementheightmax) {
    if (!isdefined(enemy)) {
        return undefined;
    }
    result = 0;
    engagementheight = 0.5 * (self.settings.engagementheightmin + self.settings.engagementheightmax);
    half_height = abs(engagementheightmax - engagementheight);
    targetheight = enemy.origin[2] + engagementheight;
    distfromengagementheight = abs(origin[2] - targetheight);
    if (distfromengagementheight > half_height) {
        result = distfromengagementheight - half_height;
    }
    return result;
}

// Namespace vehicle_ai
// Params 4, eflags: 0x0
// Checksum 0xbea00de8, Offset: 0x7058
// Size: 0x186
function positionquery_filter_engagementheight(queryresult, enemy, engagementheightmin, engagementheightmax) {
    if (!isdefined(enemy)) {
        return;
    }
    engagementheight = 0.5 * (engagementheightmin + engagementheightmax);
    half_height = abs(engagementheightmax - engagementheight);
    foreach (point in queryresult.data) {
        point.distengagementheight = 0;
        targetheight = enemy.origin[2] + engagementheight;
        distfromengagementheight = abs(point.origin[2] - targetheight);
        if (distfromengagementheight > half_height) {
            point.distengagementheight = distfromengagementheight - half_height;
        }
    }
}

// Namespace vehicle_ai
// Params 2, eflags: 0x0
// Checksum 0x681ef66d, Offset: 0x71e8
// Size: 0xbc
function positionquery_postprocess_removeoutofgoalradius(queryresult, tolerance) {
    if (!isdefined(tolerance)) {
        tolerance = 1;
    }
    for (i = 0; i < queryresult.data.size; i++) {
        point = queryresult.data[i];
        if (point.disttogoal > tolerance) {
            arrayremoveindex(queryresult.data, i);
            i--;
        }
    }
}

// Namespace vehicle_ai
// Params 4, eflags: 0x0
// Checksum 0xe4ba196b, Offset: 0x72b0
// Size: 0x4c
function function_54289651(var_9f84050f, var_1e08b2fd, var_9c5ca2c, var_cee3c9e9) {
    function_c8b0c8c2(self.locked_on, var_9f84050f, var_1e08b2fd, var_9c5ca2c, var_cee3c9e9);
}

// Namespace vehicle_ai
// Params 4, eflags: 0x0
// Checksum 0xfb1493ea, Offset: 0x7308
// Size: 0x4c
function function_b4b8a386(var_9f84050f, var_1e08b2fd, var_9c5ca2c, var_cee3c9e9) {
    function_c8b0c8c2(self.locking_on, var_9f84050f, var_1e08b2fd, var_9c5ca2c, var_cee3c9e9);
}

// Namespace vehicle_ai
// Params 5, eflags: 0x0
// Checksum 0xbfce0f29, Offset: 0x7360
// Size: 0x188
function function_c8b0c8c2(client_flags, var_9f84050f, var_1e08b2fd, var_9c5ca2c, var_cee3c9e9) {
    if (!isdefined(var_9c5ca2c)) {
        var_9c5ca2c = 1;
    }
    if (!isdefined(var_cee3c9e9)) {
        var_cee3c9e9 = 1;
    }
    assert(isdefined(client_flags));
    remaining_flags_to_process = client_flags;
    for (i = 0; remaining_flags_to_process && i < level.players.size; i++) {
        attacker = level.players[i];
        if (isdefined(attacker)) {
            client_flag = 1 << attacker getentitynumber();
            if (client_flag & remaining_flags_to_process) {
                self setpersonalthreatbias(attacker, int(var_9f84050f), var_1e08b2fd);
                if (var_9c5ca2c) {
                    self getperfectinfo(attacker, var_cee3c9e9);
                }
                remaining_flags_to_process &= ~client_flag;
            }
        }
    }
}

/#

    // Namespace vehicle_ai
    // Params 2, eflags: 0x0
    // Checksum 0x7e52ae37, Offset: 0x74f0
    // Size: 0xda
    function function_67bd73ee(var_9f84050f, var_1e08b2fd) {
        foreach (player in level.players) {
            if (player util::is_bot()) {
                self setpersonalthreatbias(player, int(var_9f84050f), var_1e08b2fd);
            }
        }
    }

#/

// Namespace vehicle_ai
// Params 0, eflags: 0x0
// Checksum 0x53c5153d, Offset: 0x75d8
// Size: 0x90
function target_hijackers() {
    self endon(#"death");
    while (true) {
        self waittill(#"ccom_lock_being_targeted", hijackingplayer);
        self getperfectinfo(hijackingplayer, 1);
        if (isplayer(hijackingplayer)) {
            self setpersonalthreatbias(hijackingplayer, 1500, 4);
        }
    }
}

