#using scripts/shared/ai/archetype_mannequin;
#using scripts/shared/ai_shared;
#using scripts/shared/music_shared;
#using scripts/shared/util_shared;

#namespace namespace_723e3352;

// Namespace namespace_723e3352
// Params 5, eflags: 0x0
// Checksum 0xba242961, Offset: 0x188
// Size: 0x364
function function_f3d9376a(origin, angles, gender, speed, var_5f10cc59) {
    if (!isdefined(gender)) {
        gender = "male";
    }
    if (!isdefined(speed)) {
        speed = undefined;
    }
    if (!isdefined(level.var_4c7f577c)) {
        level.var_4c7f577c = 1;
        music::setmusicstate("mann");
    }
    if (gender == "male") {
        mannequin = spawnactor("spawner_bo3_mannequin_male", origin, angles, "", 1, 1);
    } else {
        mannequin = spawnactor("spawner_bo3_mannequin_female", origin, angles, "", 1, 1);
    }
    rand = randomint(100);
    if (rand <= 35) {
        mannequin.zombie_move_speed = "walk";
    } else if (rand <= 70) {
        mannequin.zombie_move_speed = "run";
    } else {
        mannequin.zombie_move_speed = "sprint";
    }
    if (isdefined(speed)) {
        mannequin.zombie_move_speed = speed;
    }
    if (isdefined(level.zm_variant_type_max)) {
        mannequin.variant_type = randomintrange(1, level.zm_variant_type_max[mannequin.zombie_move_speed][mannequin.zombie_arms_position]);
    }
    mannequin ai::set_behavior_attribute("can_juke", 1);
    mannequin asmsetanimationrate(randomfloatrange(0.98, 1.02));
    mannequin.holdfire = 1;
    mannequin.canstumble = 1;
    mannequin.should_turn = 1;
    mannequin thread watch_game_ended();
    mannequin.team = "free";
    mannequin.overrideactordamage = &mannequindamage;
    mannequins = getaiarchetypearray("mannequin");
    foreach (othermannequin in mannequins) {
        if (othermannequin.archetype == "mannequin") {
            othermannequin setignoreent(mannequin, 1);
            mannequin setignoreent(othermannequin, 1);
        }
    }
    if (var_5f10cc59) {
        mannequin thread function_7b6d6b0b();
        mannequin.var_3358646a = 1;
        mannequin.var_cb4432cb = 0;
        mannequin function_8ad7149e(mannequin.var_3358646a);
    }
    playfx("dlc0/nuketown/fx_de_rez_man_spawn", mannequin.origin, anglestoforward(mannequin.angles));
    return mannequin;
}

// Namespace namespace_723e3352
// Params 12, eflags: 0x0
// Checksum 0xf2e5ce54, Offset: 0x4f8
// Size: 0x95
function mannequindamage(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (isdefined(inflictor) && isactor(inflictor) && inflictor.archetype == "mannequin") {
        return 0;
    }
    return damage;
}

// Namespace namespace_723e3352
// Params 0, eflags: 0x4
// Checksum 0x81d2f9c0, Offset: 0x598
// Size: 0x42
function private watch_game_ended() {
    self endon(#"death");
    level waittill(#"game_ended");
    self setentitypaused(1);
    level waittill(#"hash_6c5f97fe");
    self hide();
}

// Namespace namespace_723e3352
// Params 0, eflags: 0x4
// Checksum 0x57d509f4, Offset: 0x5e8
// Size: 0x42
function private function_7b6d6b0b() {
    self waittill(#"death");
    if (isdefined(self)) {
        self setentitypaused(0);
        if (!self isragdoll()) {
            self startragdoll();
        }
    }
}

// Namespace namespace_723e3352
// Params 1, eflags: 0x4
// Checksum 0xb715153a, Offset: 0x638
// Size: 0x7a
function private function_8ad7149e(frozen) {
    self.var_3358646a = frozen;
    if (self.var_3358646a && !self.var_cb4432cb) {
        self setentitypaused(1);
    } else if (!self.var_3358646a && self.var_cb4432cb) {
        self setentitypaused(0);
    }
    self.var_cb4432cb = self.var_3358646a;
}

// Namespace namespace_723e3352
// Params 0, eflags: 0x0
// Checksum 0x598b0466, Offset: 0x6c0
// Size: 0x1dd
function function_deaff58c() {
    level endon(#"game_ended");
    level endon(#"hash_4608fd9a");
    while (true) {
        mannequins = getaiarchetypearray("mannequin");
        foreach (mannequin in mannequins) {
            mannequin.var_dc83068c = 1;
        }
        players = getplayers();
        var_82e120be = mannequins;
        foreach (player in players) {
            var_82e120be = player cantseeentities(var_82e120be, 0.67, 0);
        }
        foreach (mannequin in var_82e120be) {
            mannequin.var_dc83068c = 0;
        }
        foreach (mannequin in mannequins) {
            mannequin function_8ad7149e(mannequin.var_dc83068c);
        }
        wait 0.05;
    }
}

