#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/ai/zombie_vortex;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/util_shared;

#using_animtree("zombie_cymbal_monkey");

#namespace namespace_4f1562f7;

// Namespace namespace_4f1562f7
// Params 2, eflags: 0x0
// Checksum 0xbaf4cd50, Offset: 0x328
// Size: 0x2a2
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
    wait 1;
    if (isdefined(clock)) {
        clock delete();
    }
    if (isdefined(trigger)) {
        trigger delete();
    }
}

// Namespace namespace_4f1562f7
// Params 0, eflags: 0x4
// Checksum 0xc2a0f85, Offset: 0x5d8
// Size: 0x165
function private function_78d20ce0() {
    self endon(#"death");
    while (true) {
        self waittill(#"trigger", guy);
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
// Params 1, eflags: 0x4
// Checksum 0x29a7bc3c, Offset: 0x748
// Size: 0xd1
function private function_59a20c67(trigger) {
    self endon(#"death");
    self notify(#"hash_59a20c67");
    self endon(#"hash_59a20c67");
    self.var_dd70dacd = 1;
    self thread namespace_eaa992c::function_285a2999("timeshift_contact");
    self asmsetanimationrate(0.5);
    while (isalive(self) && isdefined(trigger) && self istouching(trigger)) {
        /#
        #/
        wait 0.5;
    }
    self thread namespace_eaa992c::turnofffx("timeshift_contact");
    wait 0.75;
    self asmsetanimationrate(1);
    self.var_dd70dacd = undefined;
}

// Namespace namespace_4f1562f7
// Params 2, eflags: 0x0
// Checksum 0x23f667ab, Offset: 0x828
// Size: 0x2a
function function_d171e15a(player, origin) {
    level thread zombie_vortex::start_timed_vortex(2, origin, -128, undefined, player);
}

// Namespace namespace_4f1562f7
// Params 2, eflags: 0x0
// Checksum 0xd83d9fa9, Offset: 0x860
// Size: 0x1fc
function monkeyUpdate(player, origin) {
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
    wait player namespace_49107f3a::function_1ded48e6(level.doa.rules.var_b8f1a3ce);
    monkey notify(#"hash_2271edf2");
}

// Namespace namespace_4f1562f7
// Params 1, eflags: 0x0
// Checksum 0x978fa306, Offset: 0xa68
// Size: 0x12a
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
// Params 1, eflags: 0x0
// Checksum 0x7662f4e7, Offset: 0xba0
// Size: 0x30
function function_254f3480(monkey) {
    monkey endon(#"death");
    level waittill(#"exit_taken", var_43605624);
    monkey notify(#"hash_2271edf2");
}

