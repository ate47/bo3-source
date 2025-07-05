#using scripts/codescripts/struct;
#using scripts/cp/_turret_sentry;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;

#namespace doa_turret;

// Namespace doa_turret
// Params 0, eflags: 0x0
// Checksum 0x19e75adb, Offset: 0x520
// Size: 0x2c1
function init() {
    level.doa.mini_turrets = getentarray("doa_turret", "targetname");
    for (i = 0; i < level.doa.mini_turrets.size; i++) {
        turret = level.doa.mini_turrets[i];
        turret.var_d211e48d = 0;
        turret.is_attacking = 0;
        turret.var_d2f6fb2e = level.doa.mini_turrets[i].origin;
        turret.deployed = 0;
        turret.script_delay_min = 0.25;
        turret.script_delay_max = 0.5;
        turret.script_burst_min = 0.5;
        turret.script_burst_max = 1.5;
        turret.ignoreme = 1;
        turret.takedamage = 0;
        turret.minigun = 1;
        turret thread sentry_turret::function_b2e9d990();
        turret thread sentry_turret::function_e6f10cc7();
        turret thread sentry_turret::function_ebdfd4e4("allies");
        turret thread turretthink();
    }
    level.doa.var_4ede341 = getentarray("doa_grenade_turret", "targetname");
    for (i = 0; i < level.doa.var_4ede341.size; i++) {
        turret = level.doa.var_4ede341[i];
        turret.var_d211e48d = 0;
        turret.is_attacking = 0;
        turret.var_d2f6fb2e = level.doa.var_4ede341[i].origin;
        turret.deployed = 0;
        turret.grenade = 1;
        turret.script_delay_min = 0.25;
        turret.script_delay_max = 0.5;
        turret.script_burst_min = 0.5;
        turret.script_burst_max = 1.5;
        turret.ignoreme = 1;
        turret.takedamage = 0;
        turret thread sentry_turret::function_b2e9d990();
        turret thread sentry_turret::function_e6f10cc7();
        turret thread sentry_turret::function_ebdfd4e4("allies");
        turret thread turretthink();
    }
}

// Namespace doa_turret
// Params 1, eflags: 0x0
// Checksum 0x72a99f5f, Offset: 0x7f0
// Size: 0x2d2
function missile_logic(fake) {
    self waittill(#"missile_fire", missile, weap);
    missile endon(#"death");
    fake thread namespace_49107f3a::function_981c685d(missile);
    missile missile_settarget(fake);
    uptime = gettime() + getdvarfloat("scr_doa_missile_upwardMax", 2) * 1000;
    while (gettime() < uptime && isdefined(fake) && isdefined(missile)) {
        if (getdvarfloat("scr_doa_missile_debug", 0)) {
            level thread namespace_2f63e553::function_a0e51d80(missile.origin, 4, 24, (1, 0, 0));
        }
        distsq = distancesquared(missile.origin, fake.origin);
        if (distsq < getdvarint("scr_doa_missile_travel_reached_dist", 96) * getdvarint("scr_doa_missile_travel_reached_dist", 96)) {
            break;
        }
        if (isdefined(fake.var_5525f623)) {
            distsq = distancesquared(missile.origin, fake.var_5525f623.origin);
            if (distsq < getdvarint("scr_doa_missile_detonate_range", 96) * getdvarint("scr_doa_missile_detonate_range", 96)) {
                if (isdefined(missile)) {
                    missile detonate();
                }
                break;
            }
        }
        wait 0.05;
    }
    if (isdefined(fake.var_5525f623)) {
        enemy = fake.var_5525f623;
        missile missile_settarget(enemy);
    }
    fake delete();
    while (isdefined(enemy) && isdefined(missile)) {
        if (getdvarfloat("scr_doa_missile_debug", 0)) {
            level thread namespace_2f63e553::function_a0e51d80(missile.origin, 4, 24, (0, 1, 0));
        }
        distsq = distancesquared(missile.origin, enemy.origin);
        if (distsq < getdvarint("scr_doa_missile_detonate_range", 96) * getdvarint("scr_doa_missile_detonate_range", 96)) {
            break;
        }
        wait 0.05;
    }
    if (isdefined(missile)) {
        missile detonate();
    }
}

// Namespace doa_turret
// Params 2, eflags: 0x0
// Checksum 0x67df84f1, Offset: 0xad0
// Size: 0xe2
function turret_FakeUpTarget(index, enemy) {
    if (!isdefined(enemy)) {
        return;
    }
    pos = self.origin + (enemy.origin - self.origin) * 0.5 + (0, 0, getdvarint("scr_doa_missile_travel_height", 650));
    fake = spawn("script_model", pos);
    fake.targetname = "turret_FakeUpTarget";
    fake setmodel("tag_origin");
    fake.var_5525f623 = enemy;
    self thread missile_logic(fake);
    self fireweapon(index, fake, undefined, self.owner);
}

// Namespace doa_turret
// Params 2, eflags: 0x0
// Checksum 0x8e89b935, Offset: 0xbc0
// Size: 0x132
function weapon_FakeUpTarget(weapon, enemy) {
    if (!isdefined(enemy)) {
        return;
    }
    v_spawn = self gettagorigin("tag_flash");
    v_dir = self gettagangles("tag_flash");
    if (!isdefined(v_spawn)) {
        return;
    }
    pos = self.origin + (enemy.origin - self.origin) * 0.5 + (0, 0, getdvarint("scr_doa_missile_travel_height", 650));
    fake = spawn("script_model", pos);
    fake.targetname = "weapon_FakeUpTarget";
    fake setmodel("tag_origin");
    fake.var_5525f623 = enemy;
    self thread missile_logic(fake);
    magicbullet(weapon, v_spawn, v_spawn + 50 * v_dir, self);
}

// Namespace doa_turret
// Params 2, eflags: 0x0
// Checksum 0xa07c23dc, Offset: 0xd00
// Size: 0x5a
function turret_fire(index, enemy) {
    if (isdefined(self.grenade) && self.grenade) {
        self thread turret_FakeUpTarget(index, enemy);
        return;
    }
    self fireweapon(index, enemy, undefined, self.owner);
}

// Namespace doa_turret
// Params 0, eflags: 0x0
// Checksum 0xe754946d, Offset: 0xd68
// Size: 0x65
function turretthink() {
    while (true) {
        self waittill(#"hash_f843176e");
        self sentry_turret::function_21af94b3();
        self thread turret_target();
        self thread function_2c414dda();
        self notify(#"hash_b2b1fa21");
        self waittill(#"turret_expired");
        self sentry_turret::function_e6f10cc7();
    }
}

// Namespace doa_turret
// Params 0, eflags: 0x0
// Checksum 0xf7bb6a3, Offset: 0xdd8
// Size: 0x10d
function turret_target() {
    self endon(#"death");
    self endon(#"turret_expired");
    self waittill(#"hash_b2b1fa21");
    while (true) {
        if (!isdefined(self.e_target)) {
            a_enemy = self namespace_49107f3a::function_1bfb2259(getaiteamarray("axis"));
            if (isdefined(a_enemy.boss) && (!isdefined(a_enemy) || a_enemy.boss)) {
                wait 1;
                continue;
            }
            self.e_target = a_enemy;
        }
        self setturrettargetent(self.e_target);
        self.var_d211e48d = 0;
        if (!self.is_attacking) {
            self thread function_2c414dda();
        }
        self notify(#"hash_dc8a04ab");
        while (isalive(self.e_target)) {
            wait 0.5;
        }
        self notify(#"hash_ea50907d");
        self.is_attacking = 0;
        wait 0.5;
    }
}

// Namespace doa_turret
// Params 2, eflags: 0x0
// Checksum 0x998448da, Offset: 0xef0
// Size: 0xea
function function_4deaa5de(totalfiretime, enemy) {
    self endon(#"death");
    weapon = self seatgetweapon(0);
    firetime = weapon.firetime;
    time = 0;
    is_minigun = 0;
    if (isdefined(self.minigun) && self.minigun) {
        self setturretspinning(1);
        wait 0.5;
    }
    while (time < totalfiretime) {
        self thread turret_fire(0, enemy);
        wait firetime;
        time += firetime;
    }
    if (isdefined(self.minigun) && self.minigun) {
        self setturretspinning(0);
    }
}

// Namespace doa_turret
// Params 0, eflags: 0x0
// Checksum 0xc6b2a089, Offset: 0xfe8
// Size: 0xdd
function function_2c414dda() {
    self notify(#"hash_2c414dda");
    self endon(#"hash_2c414dda");
    self endon(#"death");
    self endon(#"hash_ea50907d");
    self endon(#"turret_expired");
    self waittill(#"hash_dc8a04ab");
    self.turretrotscale = 6;
    self sentry_turret::sentry_turret_alert_sound();
    self.is_attacking = 1;
    offset = (0, 0, 0);
    if (isdefined(self.grenade)) {
        offset = (0, 0, -56);
    }
    while (isdefined(self.e_target) && isalive(self.e_target)) {
        self setturrettargetent(self.e_target, offset);
        self function_4deaa5de(2, self.e_target);
        wait 0.2;
    }
}

// Namespace doa_turret
// Params 1, eflags: 0x0
// Checksum 0x5444b898, Offset: 0x10d0
// Size: 0xa4
function canspawnturret(var_a6f28f3b) {
    if (!isdefined(var_a6f28f3b)) {
        var_a6f28f3b = 0;
    }
    if (isdefined(level.doa.var_de844da8) && level.doa.var_de844da8) {
        return false;
    }
    turretarray = level.doa.mini_turrets;
    if (var_a6f28f3b == 1) {
        turretarray = level.doa.var_4ede341;
    }
    for (i = 0; i < turretarray.size; i++) {
        if (!turretarray[i].deployed) {
            return true;
        }
    }
    return false;
}

// Namespace doa_turret
// Params 2, eflags: 0x0
// Checksum 0xf72dfa85, Offset: 0x1180
// Size: 0x409
function function_eabe8c0(player, var_a6f28f3b) {
    if (!isdefined(var_a6f28f3b)) {
        var_a6f28f3b = 0;
    }
    mini_turret = undefined;
    turretarray = level.doa.mini_turrets;
    if (var_a6f28f3b == 1) {
        turretarray = level.doa.var_4ede341;
    }
    for (i = 0; i < turretarray.size; i++) {
        if (!turretarray[i].deployed) {
            mini_turret = turretarray[i];
            break;
        }
    }
    if (!isdefined(mini_turret)) {
        return;
    }
    mini_turret.deployed = 1;
    var_92aed0e5 = player.origin + (0, 0, 2200);
    mini_turret.origin = var_92aed0e5;
    mini_turret thread namespace_1a381543::function_90118d8c("evt_turret_incoming");
    target = player.origin;
    if (isdefined(player.doa.vehicle)) {
        var_a2dfe760 = playerphysicstrace(player.origin + (0, 0, 72), player.origin + (0, 0, -500));
        target = (player.origin[0], player.origin[1], var_a2dfe760[2]);
    }
    mini_turret thread namespace_49107f3a::function_a98c85b2(target, 0.5);
    mini_turret util::waittill_any_timeout(1, "movedone");
    mini_turret.owner = player;
    mini_turret cleartargetentity();
    mini_turret thread namespace_eaa992c::function_285a2999("turret_impact");
    mini_turret thread namespace_1a381543::function_90118d8c("evt_turret_land");
    physicsexplosionsphere(mini_turret.origin, -56, -128, 2);
    mini_turret radiusdamage(mini_turret.origin, 72, 10000, 10000);
    playrumbleonposition("explosion_generic", mini_turret.origin);
    mini_turret notify(#"hash_f843176e");
    mini_turret laseroff();
    if (isdefined(player)) {
        time_left = gettime() + player namespace_49107f3a::function_1ded48e6(level.doa.rules.var_7daebb69 * 1000);
        fx = doa_player_utility::function_ee495f41(player.entnum);
        mini_turret thread namespace_eaa992c::function_285a2999("player_trail_" + fx);
    } else {
        time_left = gettime() + level.doa.rules.var_7daebb69 * 1000;
    }
    mini_turret thread function_dfe832b7(time_left, "turret_expired");
    mini_turret waittill(#"turret_expired");
    mini_turret thread namespace_1a381543::function_90118d8c("evt_turret_takeoff");
    mini_turret thread namespace_eaa992c::function_285a2999("veh_takeoff");
    mini_turret thread namespace_eaa992c::function_285a2999("crater_dust");
    mini_turret thread namespace_49107f3a::function_a98c85b2(var_92aed0e5, 1);
    if (isdefined(fx)) {
        mini_turret thread namespace_eaa992c::turnofffx("player_trail_" + fx);
    }
    wait 1;
    mini_turret thread namespace_49107f3a::function_a98c85b2(mini_turret.var_d2f6fb2e, 1);
    mini_turret.deployed = 0;
    mini_turret.owner = undefined;
}

// Namespace doa_turret
// Params 1, eflags: 0x0
// Checksum 0x11554bcd, Offset: 0x1598
// Size: 0xed
function function_a0d09d25(player) {
    self endon(#"death");
    self endon(#"hash_7a0ce382");
    weapon = getweapon("zombietron_sprinkler_launcher");
    top = self.origin + (0, 0, 32);
    while (true) {
        self rotateto(self.angles + (0, 8, 0), 0.1);
        wait 0.1;
        forward = anglestoforward(self.angles + (0, 0, randomfloatrange(100, 500)));
        magicbullet(weapon, top, top + forward * 1000, isdefined(player) ? player : self);
    }
}

// Namespace doa_turret
// Params 2, eflags: 0x0
// Checksum 0x646945a1, Offset: 0x1690
// Size: 0x39a
function function_3ce8bf1c(player, origin) {
    var_7ad30272 = origin + (0, 0, 800);
    sprinkler = spawn("script_model", var_7ad30272);
    sprinkler.targetname = "sprinkler";
    sprinkler setmodel(level.doa.var_304b4b41);
    def = namespace_a7e6beb5::function_bac08508(20);
    sprinkler setscale(def.scale);
    sprinkler notsolid();
    target = player.origin;
    if (isdefined(player.doa.vehicle)) {
        var_a2dfe760 = playerphysicstrace(player.origin + (0, 0, 72), player.origin + (0, 0, -500));
        target = (player.origin[0], player.origin[1], var_a2dfe760[2]);
    }
    mark = target + (0, 0, 12);
    sprinkler thread namespace_1a381543::function_90118d8c("evt_sprinkler_incoming");
    sprinkler thread namespace_49107f3a::function_a98c85b2(mark, 0.5);
    sprinkler util::waittill_any_timeout(1, "movedone");
    sprinkler thread namespace_1a381543::function_90118d8c("evt_sprinkler_land");
    sprinkler thread namespace_eaa992c::function_285a2999("sprinkler_land");
    if (isdefined(player)) {
        fx = doa_player_utility::function_ee495f41(player.entnum);
        sprinkler thread namespace_eaa992c::function_285a2999("player_trail_" + fx);
    }
    physicsexplosionsphere(mark, -56, -128, 3);
    sprinkler radiusdamage(mark, 72, 10000, 10000);
    playrumbleonposition("explosion_generic", mark);
    wait 1;
    sprinkler playloopsound("evt_sprinkler_loop", 0.5);
    sprinkler thread namespace_eaa992c::function_285a2999("sprinkler_active");
    sprinkler thread function_a0d09d25(player);
    wait player namespace_49107f3a::function_1ded48e6(level.doa.rules.var_213b65db);
    sprinkler thread namespace_eaa992c::turnofffx("sprinkler_active");
    wait 2;
    sprinkler thread namespace_1a381543::function_90118d8c("evt_sprinkler_takeoff");
    sprinkler thread namespace_eaa992c::function_285a2999("sprinkler_takeoff");
    sprinkler stoploopsound(2);
    if (isdefined(fx)) {
        sprinkler thread namespace_eaa992c::turnofffx("player_trail_" + fx);
    }
    sprinkler thread namespace_49107f3a::function_a98c85b2(var_7ad30272, 0.5);
    sprinkler util::waittill_any_timeout(1, "movedone");
    sprinkler delete();
}

// Namespace doa_turret
// Params 2, eflags: 0x4
// Checksum 0x2ee66c05, Offset: 0x1a38
// Size: 0x7c
function private function_dfe832b7(timeleft, note) {
    while (gettime() < timeleft) {
        if (level flag::get("doa_round_active")) {
            wait 1;
            continue;
        }
        if (namespace_49107f3a::function_b99d78c7() == 0) {
            wait randomfloatrange(0, 1.4);
            self notify(note);
            break;
        }
        wait 1;
    }
    if (isdefined(self)) {
        self notify(note);
    }
}

// Namespace doa_turret
// Params 2, eflags: 0x0
// Checksum 0x6c0d886e, Offset: 0x1ac0
// Size: 0x4f2
function amwsPickupUpdate(player, origin) {
    team = player.team;
    time_left = gettime() + player namespace_49107f3a::function_1ded48e6(level.doa.rules.var_3c441789 * 1000);
    angles = player.angles;
    var_7ad30272 = origin + (0, 0, 800);
    spawner = getent("doa_amws", "targetname");
    if (!isdefined(spawner)) {
        return;
    }
    target = player.origin;
    if (isdefined(player.doa.vehicle)) {
        var_a2dfe760 = playerphysicstrace(player.origin + (0, 0, 72), player.origin + (0, 0, -500));
        target = (player.origin[0], player.origin[1], var_a2dfe760[2]);
    }
    mark = target + (0, 0, 16);
    fake = spawn("script_model", var_7ad30272);
    fake.targetname = "amwsPickupUpdate";
    fake setmodel(level.doa.var_4aa90d77);
    fake.angles = angles;
    fake thread namespace_eaa992c::function_285a2999("fire_trail");
    fake thread namespace_1a381543::function_90118d8c("evt_turret_incoming");
    fake moveto(mark, 0.5);
    fake util::waittill_any_timeout(1, "movedone");
    physicsexplosionsphere(mark, -56, -128, 3);
    fake radiusdamage(mark, 72, 10000, 10000);
    playrumbleonposition("explosion_generic", mark);
    fake delete();
    amws = spawner spawner::spawn(1);
    note = namespace_49107f3a::function_2ccf4b82("amws_done");
    if (isdefined(amws)) {
        amws.origin = mark;
        amws.angles = angles;
        amws.health = 10000;
        amws.team = team;
        amws.owner = player;
        amws.autonomous = 1;
        amws thread function_43d18fa4(player, note);
        amws thread namespace_eaa992c::function_285a2999("turret_impact");
        amws thread namespace_1a381543::function_90118d8c("evt_turret_land");
        amws.overridevehicledamage = &function_f3ee1c57;
    }
    if (isdefined(player)) {
        fx = doa_player_utility::function_ee495f41(player.entnum);
        amws thread namespace_eaa992c::function_285a2999("player_trail_" + fx);
    }
    level thread function_dfe832b7(time_left, note);
    level waittill(note);
    if (isdefined(fx)) {
        amws thread namespace_eaa992c::turnofffx("player_trail_" + fx);
    }
    if (isdefined(amws)) {
        fake = spawn("script_model", amws.origin);
        fake.targetname = "amwsPickupUpdate2";
        fake setmodel(level.doa.var_4aa90d77);
        fake.angles = amws.angles;
        fake thread namespace_1a381543::function_90118d8c("evt_turret_takeoff");
        amws delete();
        fake thread namespace_eaa992c::function_285a2999("veh_takeoff");
        fake thread namespace_eaa992c::function_285a2999("crater_dust");
        fake moveto(var_7ad30272, 0.5);
        fake util::waittill_any_timeout(1, "movedone");
        fake delete();
    }
}

// Namespace doa_turret
// Params 15, eflags: 0x0
// Checksum 0x7b00729e, Offset: 0x1fc0
// Size: 0x91
function function_f3ee1c57(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(smeansofdeath) && smeansofdeath == "MOD_MELEE") {
        return idamage;
    }
    return 0;
}

// Namespace doa_turret
// Params 2, eflags: 0x4
// Checksum 0x5749b040, Offset: 0x2060
// Size: 0x49
function private function_43d18fa4(player, note) {
    self endon(#"death");
    level endon(note);
    while (isdefined(player)) {
        self setgoalpos(player.origin, 0, 300);
        wait 1;
    }
}

