#using scripts/shared/ai/zombie_vortex;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_4f1562f7;

// Namespace namespace_4f1562f7
// Params 1, eflags: 0x1 linked
// Checksum 0xe35ce39c, Offset: 0x3b0
// Size: 0x6e
function function_be253d27(var_53e67bd3) {
    if (!isdefined(var_53e67bd3)) {
        var_53e67bd3 = 0.6;
    }
    self endon(#"death");
    while (isdefined(self)) {
        self rotateto(self.angles + (0, 180, 0), var_53e67bd3);
        wait(var_53e67bd3);
    }
}

// Namespace namespace_4f1562f7
// Params 3, eflags: 0x1 linked
// Checksum 0x66b4cd3c, Offset: 0x428
// Size: 0xe0
function function_c4e6a6fb(startscale, endscale, timems) {
    if (!isdefined(endscale)) {
        endscale = 1;
    }
    if (!isdefined(timems)) {
        timems = 3000;
    }
    self endon(#"death");
    var_1a6998e1 = startscale;
    var_aa32d9f9 = (endscale - startscale) / timems / 50;
    endtime = gettime() + timems;
    while (isdefined(self) && gettime() < endtime) {
        var_1a6998e1 += var_aa32d9f9;
        self setscale(var_1a6998e1);
        wait(0.05);
    }
}

// Namespace namespace_4f1562f7
// Params 2, eflags: 0x1 linked
// Checksum 0x10a8d466, Offset: 0x510
// Size: 0x39c
function function_ca06d008(player, origin) {
    var_a2dfe760 = playerphysicstrace(origin + (0, 0, 72), origin + (0, 0, -500));
    origin = (origin[0], origin[1], var_a2dfe760[2]);
    org = spawn("script_model", origin + (0, 0, 36));
    org setmodel("tag_origin");
    coat = spawn("script_model", origin + (0, 0, 36));
    if (isdefined(coat)) {
        coat setscale(3);
        coat thread function_c4e6a6fb(3, 0.1);
        coat.angles = (0, 270, 75);
        coat thread function_be253d27();
        coat.targetname = "coat_of_arms";
        coat setmodel(level.doa.var_46e741fa);
        coat thread namespace_1a381543::function_90118d8c("zmb_coat_of_arms");
    }
    trigger = spawn("trigger_radius", coat.origin, 9, level.doa.rules.var_942b8706, 60);
    trigger.targetname = "teamShifterUpdate";
    trigger enablelinkto();
    trigger.opentime = 2300;
    trigger.var_96ff2cda = gettime() + trigger.opentime;
    trigger.radiussq = level.doa.rules.var_942b8706 * level.doa.rules.var_942b8706;
    playfx("zombie/fx_exp_rpg_red_doa", coat.origin);
    org thread namespace_eaa992c::function_285a2999("teamShift");
    trigger thread function_963e13a0();
    wait(2);
    if (isdefined(org)) {
        org delete();
    }
    wait(1);
    if (isdefined(trigger)) {
        trigger delete();
    }
    if (isdefined(coat)) {
        coat delete();
    }
}

// Namespace namespace_4f1562f7
// Params 0, eflags: 0x5 linked
// Checksum 0x188acb5d, Offset: 0x8b8
// Size: 0x220
function function_963e13a0() {
    self endon(#"death");
    while (true) {
        guy = self waittill(#"trigger");
        if (isdefined(guy.var_bfd5bf9d) && guy.var_bfd5bf9d) {
            continue;
        }
        if (isdefined(guy.boss) && guy.boss) {
            continue;
        }
        if (isvehicle(guy)) {
            continue;
        }
        if (guy isragdoll()) {
            continue;
        }
        if (!(isdefined(guy.var_96437a17) && guy.var_96437a17)) {
            continue;
        }
        if (!isalive(guy) || guy.health <= 0) {
            continue;
        }
        if (isdefined(self.var_96ff2cda)) {
            time = gettime();
            if (time < self.var_96ff2cda) {
                distsq = distancesquared(guy.origin, self.origin);
                frac = distsq / self.radiussq;
                diff = time - self.birthtime;
                var_d4857947 = diff / self.opentime;
                if (frac > var_d4857947) {
                    continue;
                }
            }
        }
        guy thread function_770e1327(self);
        guy thread namespace_49107f3a::function_24245456(level, "exit_taken");
    }
}

// Namespace namespace_4f1562f7
// Params 1, eflags: 0x5 linked
// Checksum 0x1ad49281, Offset: 0xae0
// Size: 0x146
function function_770e1327(trigger) {
    self endon(#"death");
    self notify(#"hash_770e1327");
    self endon(#"hash_770e1327");
    self.var_bfd5bf9d = 1;
    self thread namespace_eaa992c::function_285a2999("teamShift_contact");
    self thread namespace_eaa992c::function_285a2999("zombie_angry");
    team = self.team;
    self.team = "allies";
    self.favoriteenemy = undefined;
    self clearenemy();
    wait(level.doa.rules.var_a29b8bda);
    self.team = team;
    self thread namespace_eaa992c::turnofffx("teamShift_contact");
    self thread namespace_eaa992c::turnofffx("zombie_angry");
    self.var_bfd5bf9d = undefined;
    self clearenemy();
    self.favoriteenemy = undefined;
}

// Namespace namespace_4f1562f7
// Params 2, eflags: 0x1 linked
// Checksum 0xe4870e36, Offset: 0xc30
// Size: 0x374
function timeshifterupdate(player, origin) {
    var_a2dfe760 = playerphysicstrace(origin + (0, 0, 72), origin + (0, 0, -500));
    origin = (origin[0], origin[1], var_a2dfe760[2]);
    mark = origin + (0, 0, 28);
    clock = spawn("script_model", origin);
    clock.targetname = "clock";
    clock setmodel(level.doa.var_27f4032b);
    clock thread namespace_1a381543::function_90118d8c("zmb_pwup_clock_start");
    clock playloopsound("zmb_pwup_clock_loop", 2);
    trigger = spawn("trigger_radius", clock.origin, 9, level.doa.rules.var_942b8706, 60);
    trigger.targetname = "timeShifterUpdate";
    trigger enablelinkto();
    trigger linkto(clock);
    trigger.opentime = 3000;
    trigger.var_96ff2cda = gettime() + trigger.opentime;
    trigger.radiussq = level.doa.rules.var_942b8706 * level.doa.rules.var_942b8706;
    timetowait = player namespace_49107f3a::function_1ded48e6(level.doa.rules.var_ecfc4359);
    /#
    #/
    clock thread namespace_eaa992c::function_285a2999("timeshift");
    trigger thread function_78d20ce0();
    level util::waittill_any_timeout(player namespace_49107f3a::function_1ded48e6(level.doa.rules.var_ecfc4359), "exit_taken");
    clock thread namespace_1a381543::function_90118d8c("zmb_pwup_clock_end");
    wait(1);
    if (isdefined(clock)) {
        clock delete();
    }
    if (isdefined(trigger)) {
        trigger delete();
    }
}

// Namespace namespace_4f1562f7
// Params 0, eflags: 0x5 linked
// Checksum 0x74cbfda, Offset: 0xfb0
// Size: 0x1d8
function function_78d20ce0() {
    self endon(#"death");
    while (true) {
        guy = self waittill(#"trigger");
        if (isdefined(guy.var_dd70dacd) && guy.var_dd70dacd) {
            continue;
        }
        if (isdefined(guy.boss) && guy.boss) {
            continue;
        }
        if (isvehicle(guy)) {
            continue;
        }
        if (guy isragdoll()) {
            continue;
        }
        if (!isalive(guy) || guy.health <= 0) {
            continue;
        }
        if (isdefined(self.var_96ff2cda)) {
            time = gettime();
            if (time < self.var_96ff2cda) {
                distsq = distancesquared(guy.origin, self.origin);
                frac = distsq / self.radiussq;
                diff = time - self.birthtime;
                var_d4857947 = diff / self.opentime;
                if (frac > var_d4857947) {
                    continue;
                }
            }
        }
        guy thread function_59a20c67(self);
    }
}

// Namespace namespace_4f1562f7
// Params 1, eflags: 0x5 linked
// Checksum 0xa4d7167a, Offset: 0x1190
// Size: 0x146
function function_59a20c67(trigger) {
    self endon(#"death");
    self notify(#"hash_59a20c67");
    self endon(#"hash_59a20c67");
    self.var_dd70dacd = 1;
    self thread namespace_eaa992c::function_285a2999("timeshift_contact");
    self asmsetanimationrate(0.5);
    while (isalive(self) && isdefined(trigger) && self istouching(trigger)) {
        /#
        #/
        wait(0.5);
    }
    self thread namespace_eaa992c::turnofffx("timeshift_contact");
    wait(0.75);
    self asmsetanimationrate(isdefined(self.doa.anim_rate) ? self.doa.anim_rate : 1);
    self.var_dd70dacd = undefined;
}

// Namespace namespace_4f1562f7
// Params 2, eflags: 0x1 linked
// Checksum 0x202ed582, Offset: 0x12e0
// Size: 0x4c
function function_d171e15a(player, origin) {
    level thread zombie_vortex::start_timed_vortex(origin, -128, 9, 10, undefined, player, undefined, undefined, undefined, undefined, 2);
}

// Namespace namespace_4f1562f7
// Params 2, eflags: 0x1 linked
// Checksum 0xc93f1ff3, Offset: 0x1338
// Size: 0x29c
function function_159bb1dd(player, origin) {
    var_a2dfe760 = playerphysicstrace(origin + (0, 0, 72), origin + (0, 0, -500));
    origin = (origin[0], origin[1], var_a2dfe760[2]);
    mark = origin + (0, 0, 12);
    monkey = spawn("script_model", origin);
    monkey.targetname = "monkeyUpdate";
    monkey setmodel(level.doa.var_d6256e83);
    monkey thread namespace_eaa992c::function_285a2999(namespace_831a4a7c::function_e7e0aa7f(player.entnum));
    def = namespace_a7e6beb5::function_bac08508(11);
    monkey useanimtree(#zombie_cymbal_monkey);
    monkey animscripted("anim", monkey.origin, monkey.angles, zombie_cymbal_monkey%o_monkey_bomb);
    monkey.angles = (0, randomint(360), 0);
    monkey makesentient();
    monkey.threatbias = 0;
    namespace_49107f3a::addpoi(monkey);
    monkey endon(#"death");
    level thread function_254f3480(monkey);
    monkey thread function_2271edf2(player);
    wait(player namespace_49107f3a::function_1ded48e6(level.doa.rules.var_b8f1a3ce));
    monkey notify(#"hash_2271edf2");
}

// Namespace namespace_4f1562f7
// Params 1, eflags: 0x1 linked
// Checksum 0x152c013a, Offset: 0x15e0
// Size: 0x174
function function_2271edf2(player) {
    self endon(#"death");
    self waittill(#"hash_2271edf2");
    namespace_49107f3a::function_3d81b494(self);
    self thread namespace_1a381543::function_90118d8c("zmb_monkey_explo");
    self thread namespace_eaa992c::function_285a2999("monkey_explode");
    if (isdefined(player)) {
        radiusdamage(self.origin, -56, 15000, 15000, player, "MOD_EXPLOSIVE");
    } else {
        radiusdamage(self.origin, -56, 15000, 15000);
    }
    physicsexplosionsphere(self.origin, -56, -128, 2);
    earthquake(0.3, 1, self.origin, 100);
    playrumbleonposition("artillery_rumble", self.origin);
    self waittill(#"hash_6a404ade");
    self delete();
}

// Namespace namespace_4f1562f7
// Params 1, eflags: 0x1 linked
// Checksum 0xec38ed65, Offset: 0x1760
// Size: 0x40
function function_254f3480(monkey) {
    monkey endon(#"death");
    var_43605624 = level waittill(#"exit_taken");
    monkey notify(#"hash_2271edf2");
}

