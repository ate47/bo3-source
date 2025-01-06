#using scripts/shared/math_shared;

#namespace behaviortracker;

// Namespace behaviortracker
// Params 0, eflags: 0x0
// Checksum 0xe7bd40c2, Offset: 0x1e0
// Size: 0x141
function function_c7516f2f() {
    if (isdefined(self.behaviortracker.traits)) {
        return;
    }
    self.behaviortracker.traits = [];
    self.behaviortracker.traits["effectiveCombat"] = 0.5;
    self.behaviortracker.traits["effectiveWallRunCombat"] = 0.5;
    self.behaviortracker.traits["effectiveDoubleJumpCombat"] = 0.5;
    self.behaviortracker.traits["effectiveSlideCombat"] = 0.5;
    if (self.behaviortracker.version != 0) {
        traits = getarraykeys(self.behaviortracker.traits);
        for (i = 0; i < traits.size; i++) {
            trait = traits[i];
            self.behaviortracker.traits[trait] = float(self function_16ff7316(trait));
        }
    }
}

// Namespace behaviortracker
// Params 0, eflags: 0x0
// Checksum 0x444b0871, Offset: 0x330
// Size: 0xca
function initialize() {
    if (isdefined(self.pers["isBot"])) {
        return;
    }
    if (isdefined(self.behaviortracker)) {
        return;
    }
    self.behaviortracker = spawnstruct();
    self.behaviortracker.version = int(self function_16ff7316("version"));
    self.behaviortracker.numRecords = int(self function_16ff7316("numRecords")) + 1;
    self function_c7516f2f();
    self.behaviortracker.valid = 1;
}

// Namespace behaviortracker
// Params 0, eflags: 0x0
// Checksum 0xde923237, Offset: 0x408
// Size: 0x3a
function finalize() {
    if (!self isallowed()) {
        return;
    }
    self function_83084a92();
    self function_cca0db2d();
}

// Namespace behaviortracker
// Params 0, eflags: 0x0
// Checksum 0x21f7c359, Offset: 0x450
// Size: 0x2d
function isallowed() {
    if (!isdefined(self)) {
        return false;
    }
    if (!isdefined(self.behaviortracker)) {
        return false;
    }
    if (!self.behaviortracker.valid) {
        return false;
    }
    return true;
}

// Namespace behaviortracker
// Params 0, eflags: 0x0
// Checksum 0x4cd396f7, Offset: 0x488
// Size: 0xaa
function function_cca0db2d() {
    bbprint("mpbehaviortracker", "username %s version %d numRecords %d effectiveSlideCombat %f effectiveDoubleJumpCombat %f effectiveWallRunCombat %f effectiveCombat %f", self.name, self.behaviortracker.version, self.behaviortracker.numRecords, self.behaviortracker.traits["effectiveSlideCombat"], self.behaviortracker.traits["effectiveDoubleJumpCombat"], self.behaviortracker.traits["effectiveWallRunCombat"], self.behaviortracker.traits["effectiveCombat"]);
}

// Namespace behaviortracker
// Params 1, eflags: 0x0
// Checksum 0x648a9dd3, Offset: 0x540
// Size: 0x1a
function function_254224(trait) {
    return self.behaviortracker.traits[trait];
}

// Namespace behaviortracker
// Params 2, eflags: 0x0
// Checksum 0xb16c0b9e, Offset: 0x568
// Size: 0x27
function function_80251728(trait, value) {
    self.behaviortracker.traits[trait] = value;
}

// Namespace behaviortracker
// Params 2, eflags: 0x0
// Checksum 0x6457eaa5, Offset: 0x598
// Size: 0x10a
function function_b1f374e6(trait, percent) {
    if (!self isallowed()) {
        return;
    }
    math::clamp(percent, -1, 1);
    currentvalue = self function_254224(trait);
    if (percent >= 0) {
        delta = (1 - currentvalue) * percent;
    } else {
        delta = (currentvalue - 0) * percent;
    }
    var_4b6c2694 = 0.1 * delta;
    newvalue = currentvalue + var_4b6c2694;
    newvalue = math::clamp(newvalue, 0, 1);
    self function_80251728(trait, newvalue);
    bbprint("mpbehaviortraitupdate", "username %s trait %s percent %f", self.name, trait, percent);
}

// Namespace behaviortracker
// Params 3, eflags: 0x0
// Checksum 0xe314c20d, Offset: 0x6b0
// Size: 0x222
function function_dbc71f52(attacker, victim, damage) {
    if (isdefined(victim) && victim isallowed()) {
        damageratio = float(damage) / float(victim.maxhealth);
        math::clamp(damageratio, 0, 1);
        damageratio *= -1;
        victim function_b1f374e6("effectiveCombat", damageratio);
        if (victim iswallrunning()) {
            victim function_b1f374e6("effectiveWallRunCombat", damageratio);
        }
        if (victim issliding()) {
            victim function_b1f374e6("effectiveSlideCombat", damageratio);
        }
        if (victim isdoublejumping()) {
            victim function_b1f374e6("effectiveDoubleJumpCombat", damageratio);
        }
    }
    if (isdefined(attacker) && attacker isallowed() && attacker != victim) {
        damageratio = float(damage) / float(attacker.maxhealth);
        math::clamp(damageratio, 0, 1);
        attacker function_b1f374e6("effectiveCombat", damageratio);
        if (attacker iswallrunning()) {
            attacker function_b1f374e6("effectiveWallRunCombat", damageratio);
        }
        if (attacker issliding()) {
            attacker function_b1f374e6("effectiveSlideCombat", damageratio);
        }
        if (attacker isdoublejumping()) {
            attacker function_b1f374e6("effectiveDoubleJumpCombat", damageratio);
        }
    }
}

// Namespace behaviortracker
// Params 2, eflags: 0x0
// Checksum 0xc3d5a52e, Offset: 0x8e0
// Size: 0x1aa
function function_702c6ee2(attacker, victim) {
    if (isdefined(victim) && victim isallowed()) {
        victim function_b1f374e6("effectiveCombat", -1);
        if (victim iswallrunning()) {
            victim function_b1f374e6("effectiveWallRunCombat", -1);
        }
        if (victim issliding()) {
            victim function_b1f374e6("effectiveSlideCombat", -1);
        }
        if (victim isdoublejumping()) {
            victim function_b1f374e6("effectiveDoubleJumpCombat", -1);
        }
    }
    if (isdefined(attacker) && attacker isallowed() && attacker != victim) {
        attacker function_b1f374e6("effectiveCombat", 1);
        if (attacker iswallrunning()) {
            attacker function_b1f374e6("effectiveWallRunCombat", 1);
        }
        if (attacker issliding()) {
            attacker function_b1f374e6("effectiveSlideCombat", 1);
        }
        if (attacker isdoublejumping()) {
            attacker function_b1f374e6("effectiveDoubleJumpCombat", 1);
        }
    }
}

// Namespace behaviortracker
// Params 0, eflags: 0x0
// Checksum 0xcd02f0d0, Offset: 0xa98
// Size: 0xe1
function function_83084a92() {
    if (self.behaviortracker.version == 0) {
        return;
    }
    self.behaviortracker.numRecords += 1;
    self function_91ad671a("numRecords", self.behaviortracker.numRecords);
    traits = getarraykeys(self.behaviortracker.traits);
    for (i = 0; i < traits.size; i++) {
        trait = traits[i];
        value = self.behaviortracker.traits[trait];
        self function_91ad671a(trait, value);
    }
}

// Namespace behaviortracker
// Params 1, eflags: 0x0
// Checksum 0xdc24d343, Offset: 0xb88
// Size: 0x21
function function_16ff7316(trait) {
    return self getdstat("behaviorTracker", trait);
}

// Namespace behaviortracker
// Params 2, eflags: 0x0
// Checksum 0x9259102b, Offset: 0xbb8
// Size: 0x2a
function function_91ad671a(trait, value) {
    self setdstat("behaviorTracker", trait, value);
}

