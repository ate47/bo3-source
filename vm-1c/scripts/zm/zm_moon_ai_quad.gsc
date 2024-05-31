#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_quad;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_c7d03b9b;

// Namespace namespace_c7d03b9b
// Params 0, eflags: 0x2
// namespace_c7d03b9b<file_0>::function_c35e6aab
// Checksum 0xa925bffa, Offset: 0x620
// Size: 0x3c
function autoexec init() {
    function_e9b3dfb0();
    spawner::add_archetype_spawn_function("zombie_quad", &function_5076473f);
}

// Namespace namespace_c7d03b9b
// Params 0, eflags: 0x5 linked
// namespace_c7d03b9b<file_0>::function_e9b3dfb0
// Checksum 0xa4112eb7, Offset: 0x668
// Size: 0x174
function private function_e9b3dfb0() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("quadPhasingService", &function_22590b59);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldPhase", &function_3293af29);
    behaviortreenetworkutility::registerbehaviortreescriptapi("phaseActionStart", &function_a4506abc);
    behaviortreenetworkutility::registerbehaviortreescriptapi("phaseActionTerminate", &function_ef291bc5);
    behaviortreenetworkutility::registerbehaviortreescriptapi("moonQuadKilledByMicrowaveGunDw", &function_3679b8f9);
    behaviortreenetworkutility::registerbehaviortreescriptapi("moonQuadKilledByMicrowaveGun", &function_8defac52);
    animationstatenetwork::registernotetrackhandlerfunction("phase_start", &function_51ab54f7);
    animationstatenetwork::registernotetrackhandlerfunction("phase_end", &function_428f351c);
    animationstatenetwork::registeranimationmocomp("quad_phase", &function_4e0a671e, undefined, undefined);
}

// Namespace namespace_c7d03b9b
// Params 1, eflags: 0x5 linked
// namespace_c7d03b9b<file_0>::function_22590b59
// Checksum 0x500b30f7, Offset: 0x7e8
// Size: 0x39c
function private function_22590b59(entity) {
    if (isdefined(entity.is_phasing) && entity.is_phasing) {
        return false;
    }
    entity.can_phase = 0;
    if (entity.var_20535e44 == 0) {
        if (math::cointoss()) {
            entity.var_3b07930a = "quad_phase_right";
        } else {
            entity.var_3b07930a = "quad_phase_left";
        }
    } else if (entity.var_20535e44 == -1) {
        entity.var_3b07930a = "quad_phase_right";
    } else {
        entity.var_3b07930a = "quad_phase_left";
    }
    if (entity.var_3b07930a == "quad_phase_left") {
        if (isplayer(entity.enemy) && entity.enemy islookingat(entity)) {
            if (entity maymovefrompointtopoint(entity.origin, zombie_utility::getanimendpos(level.var_9fcbbc83["phase_left_long"]))) {
                entity.can_phase = 1;
            }
        }
    } else if (isplayer(entity.enemy) && entity.enemy islookingat(entity)) {
        if (entity maymovefrompointtopoint(entity.origin, zombie_utility::getanimendpos(level.var_9fcbbc83["phase_right_long"]))) {
            entity.can_phase = 1;
        }
    }
    if (!(isdefined(entity.can_phase) && entity.can_phase)) {
        if (entity maymovefrompointtopoint(entity.origin, zombie_utility::getanimendpos(level.var_9fcbbc83["phase_forward"]))) {
            entity.can_phase = 1;
            entity.var_3b07930a = "quad_phase_forward";
        }
    }
    if (isdefined(entity.can_phase) && entity.can_phase) {
        blackboard::setblackboardattribute(entity, "_quad_phase_direction", entity.var_3b07930a);
        if (math::cointoss()) {
            blackboard::setblackboardattribute(entity, "_quad_phase_distance", "quad_phase_short");
        } else {
            blackboard::setblackboardattribute(entity, "_quad_phase_distance", "quad_phase_long");
        }
        return true;
    }
    return false;
}

// Namespace namespace_c7d03b9b
// Params 1, eflags: 0x5 linked
// namespace_c7d03b9b<file_0>::function_3293af29
// Checksum 0xb53c5092, Offset: 0xb90
// Size: 0x22c
function private function_3293af29(entity) {
    if (!(isdefined(entity.can_phase) && entity.can_phase)) {
        return false;
    }
    if (isdefined(entity.is_phasing) && entity.is_phasing) {
        return false;
    }
    if (gettime() - entity.var_b7d765b3 < 2000) {
        return false;
    }
    if (!isdefined(entity.enemy)) {
        return false;
    }
    dist_sq = distancesquared(entity.origin, entity.enemy.origin);
    var_88f40f11 = 4096;
    max_dist_sq = 1000000;
    if (entity.var_3b07930a == "quad_phase_forward") {
        var_88f40f11 = 14400;
        max_dist_sq = 5760000;
    }
    if (dist_sq < var_88f40f11) {
        return false;
    }
    if (dist_sq > max_dist_sq) {
        return false;
    }
    if (!isdefined(entity.pathgoalpos) || distancesquared(entity.origin, entity.pathgoalpos) < var_88f40f11) {
        return false;
    }
    if (abs(entity getmotionangle()) > 15) {
        return false;
    }
    yaw = zombie_utility::getyawtoorigin(entity.enemy.origin);
    if (abs(yaw) > 45) {
        return false;
    }
    return true;
}

// Namespace namespace_c7d03b9b
// Params 1, eflags: 0x5 linked
// namespace_c7d03b9b<file_0>::function_a4506abc
// Checksum 0x7bc2833c, Offset: 0xdc8
// Size: 0x7c
function private function_a4506abc(entity) {
    entity.is_phasing = 1;
    if (entity.var_3b07930a == "quad_phase_left") {
        entity.var_20535e44--;
        return;
    }
    if (entity.var_3b07930a == "quad_phase_right") {
        entity.var_20535e44++;
    }
}

// Namespace namespace_c7d03b9b
// Params 1, eflags: 0x5 linked
// namespace_c7d03b9b<file_0>::function_ef291bc5
// Checksum 0x682f8065, Offset: 0xe50
// Size: 0x2c
function private function_ef291bc5(entity) {
    entity.var_b7d765b3 = gettime();
    entity.is_phasing = 0;
}

// Namespace namespace_c7d03b9b
// Params 1, eflags: 0x5 linked
// namespace_c7d03b9b<file_0>::function_3679b8f9
// Checksum 0xb4d12f1d, Offset: 0xe88
// Size: 0x2e
function private function_3679b8f9(entity) {
    return isdefined(entity.var_bac7b83d) && entity.var_bac7b83d;
}

// Namespace namespace_c7d03b9b
// Params 1, eflags: 0x5 linked
// namespace_c7d03b9b<file_0>::function_8defac52
// Checksum 0x4f24dc7b, Offset: 0xec0
// Size: 0x2e
function private function_8defac52(entity) {
    return isdefined(entity.microwavegun_death) && entity.microwavegun_death;
}

// Namespace namespace_c7d03b9b
// Params 1, eflags: 0x5 linked
// namespace_c7d03b9b<file_0>::function_51ab54f7
// Checksum 0x53349f2e, Offset: 0xef8
// Size: 0x44
function private function_51ab54f7(entity) {
    entity thread function_4474334d("quad_phasing_out");
    entity ghost();
}

// Namespace namespace_c7d03b9b
// Params 1, eflags: 0x5 linked
// namespace_c7d03b9b<file_0>::function_428f351c
// Checksum 0xa29b838f, Offset: 0xf48
// Size: 0x44
function private function_428f351c(entity) {
    entity thread function_4474334d("quad_phasing_in");
    entity show();
}

// Namespace namespace_c7d03b9b
// Params 5, eflags: 0x5 linked
// namespace_c7d03b9b<file_0>::function_4e0a671e
// Checksum 0xe29d6ad6, Offset: 0xf98
// Size: 0x4c
function private function_4e0a671e(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("gravity", 0);
}

// Namespace namespace_c7d03b9b
// Params 0, eflags: 0x1 linked
// namespace_c7d03b9b<file_0>::function_5076473f
// Checksum 0x3c6524ed, Offset: 0xff0
// Size: 0x17e
function function_5076473f() {
    self.can_phase = 0;
    self.var_b7d765b3 = gettime();
    self.var_20535e44 = 0;
    if (!isdefined(level.var_9fcbbc83)) {
        level.var_9fcbbc83 = [];
        level.var_9fcbbc83["phase_forward"] = self animmappingsearch(istring("anim_zombie_phase_f_long_b"));
        level.var_9fcbbc83["phase_left_long"] = self animmappingsearch(istring("anim_zombie_phase_l_long_b"));
        level.var_9fcbbc83["phase_left_short"] = self animmappingsearch(istring("anim_zombie_phase_l_short_b"));
        level.var_9fcbbc83["phase_right_long"] = self animmappingsearch(istring("anim_zombie_phase_r_long_b"));
        level.var_9fcbbc83["phase_right_short"] = self animmappingsearch(istring("anim_zombie_phase_r_short_a"));
    }
}

// Namespace namespace_c7d03b9b
// Params 0, eflags: 0x0
// namespace_c7d03b9b<file_0>::function_e23e8d13
// Checksum 0x82f11bf4, Offset: 0x1178
// Size: 0x54
function function_e23e8d13() {
    self.no_gib = 1;
    self.var_ce31c8e8 = 1;
    self.var_8d2e0264 = 1;
    self.var_5bd78a70 = &function_11b04bf0;
    self.var_1562ef49 = &function_1fe01b05;
}

// Namespace namespace_c7d03b9b
// Params 2, eflags: 0x1 linked
// namespace_c7d03b9b<file_0>::function_11b04bf0
// Checksum 0x498f4ad1, Offset: 0x11d8
// Size: 0x164
function function_11b04bf0(animname, var_1f230408) {
    self endon(#"death");
    self endon(#"hash_8e875043");
    self thread function_734565f2(var_1f230408);
    self thread function_73d82859(var_1f230408);
    while (true) {
        note = self waittill(animname);
        if (note == "phase_start") {
            self thread function_4474334d("quad_phasing_out");
            self playsound("zmb_quad_phase_out");
            self ghost();
            continue;
        }
        if (note == "phase_end") {
            self notify(#"hash_acf98edd");
            self thread function_4474334d("quad_phasing_in");
            self show();
            self playsound("zmb_quad_phase_in");
            break;
        }
    }
}

// Namespace namespace_c7d03b9b
// Params 0, eflags: 0x1 linked
// namespace_c7d03b9b<file_0>::function_1fe01b05
// Checksum 0x256543ad, Offset: 0x1348
// Size: 0x2a
function function_1fe01b05() {
    if (isdefined(self.var_98905394) && self.var_98905394) {
        return "low_g_super_sprint";
    }
    return "super_sprint";
}

// Namespace namespace_c7d03b9b
// Params 1, eflags: 0x1 linked
// namespace_c7d03b9b<file_0>::function_734565f2
// Checksum 0x45746c11, Offset: 0x1380
// Size: 0x92
function function_734565f2(var_1f230408) {
    self endon(#"death");
    self endon(#"hash_acf98edd");
    anim_length = getanimlength(var_1f230408);
    wait(anim_length);
    self thread function_4474334d("quad_phasing_in");
    self show();
    self notify(#"hash_8e875043");
}

// Namespace namespace_c7d03b9b
// Params 1, eflags: 0x1 linked
// namespace_c7d03b9b<file_0>::function_73d82859
// Checksum 0x4a91a0b, Offset: 0x1420
// Size: 0x6a
function function_73d82859(var_1f230408) {
    self endon(#"death");
    anim_length = getanimlength(var_1f230408);
    wait(anim_length);
    if (!(isdefined(self.exit_align) && self.exit_align)) {
        self notify(#"hash_1f230408", "exit_align");
    }
}

// Namespace namespace_c7d03b9b
// Params 1, eflags: 0x1 linked
// namespace_c7d03b9b<file_0>::function_4474334d
// Checksum 0x8bb9db1, Offset: 0x1498
// Size: 0x54
function function_4474334d(var_99a8589b) {
    self endon(#"death");
    if (isdefined(level._effect[var_99a8589b])) {
        playfxontag(level._effect[var_99a8589b], self, "j_spine4");
    }
}

// Namespace namespace_c7d03b9b
// Params 0, eflags: 0x0
// namespace_c7d03b9b<file_0>::function_fbba43b2
// Checksum 0xa44a2e4a, Offset: 0x14f8
// Size: 0x1a
function function_fbba43b2() {
    self endon(#"disconnect");
    self endon(#"death");
}

