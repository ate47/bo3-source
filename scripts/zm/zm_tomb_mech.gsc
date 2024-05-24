#using scripts/zm/zm_tomb_tank;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_weap_staff_water;
#using scripts/zm/_zm_weap_staff_fire;
#using scripts/zm/_zm_weap_staff_lightning;
#using scripts/zm/_zm_weap_staff_air;
#using scripts/zm/_zm_ai_mechz;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/shared/ai/mechz;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_baebcb1;

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0x9a7ccb46, Offset: 0x9c0
// Size: 0x474
function init() {
    function_e597e389();
    level.var_20d6379d = struct::get_array("mechz_location", "script_noteworthy");
    if (level.var_6c15f1bc.size == 0) {
        return;
    }
    for (i = 0; i < level.var_6c15f1bc.size; i++) {
        level.var_6c15f1bc[i].is_enabled = 1;
        level.var_6c15f1bc[i].script_forcespawn = 1;
    }
    level thread function_6f839d44();
    level.var_f1419b9d = 5000;
    level.var_53cc405d = level.var_f1419b9d;
    level.var_a1748a68 = 1000;
    level.var_65863f29 = 0;
    level.var_a47eaca6 = 0.1;
    level.var_d7a57e91 = 500;
    level.var_ddf31707 = level.var_d7a57e91;
    level.var_c26aff0a = -6;
    level.var_f849d7d9 = 0.25;
    level.var_2c998eb8 = 0.1;
    level.var_f8eb93c7 = 300;
    level.var_8d42c5f5 = level.var_5ffbf55;
    level.var_2c529c00 = 100;
    level.var_a74f8ce1 = 500;
    level.var_d10cd77 = level.var_a74f8ce1;
    level.var_b97389fa = -106;
    level.var_21dd9210 = 0.05;
    level.var_2a704d19 = 0.025;
    level.var_27d34cc9 = 0.1;
    level.var_be18040 = 3;
    level.var_7fdeefc2 = 4;
    level.var_ccff5b86 = 4;
    level.var_4534e4c4 = 6;
    level.var_c15a3daa = 65536;
    level.var_3fe5da38 = 1048576;
    level.var_37b4fe8d = 16384;
    level.var_2e26f510 = 1;
    level.var_b0b2114c = 0;
    level.var_dc73a7de = 120;
    level.var_9eaf8820 = 1.5;
    level.var_53823c42 = 3;
    level.var_b8cf93de = 4410000;
    level.var_2750d45b = 3;
    level.var_9588ba05 = 10;
    level.var_136e80d5 = cos(45);
    level.var_e03a516b = 10;
    level.var_1514648e = 60;
    level.var_6b18119d = 45;
    level.var_b89ed656 = 48;
    level.var_feac9945 = level.var_b89ed656 * level.var_b89ed656;
    level.var_68f2c2ce = 5;
    level.var_ba970bfc = 10;
    level.var_1107d5e = 129600;
    level.var_818fa51 = 57600;
    level.var_be0eac62 = 7000;
    level.var_94dcdc41 = 5000;
    level.var_8f59e902 = 8;
    level.var_c79e9c30 = 11;
    level.var_77faa810 = -6;
    level.var_49fe662e = 500;
    level.var_27e4dd92 = 100;
    level.var_f680427b = 100;
    level.var_c80ee9e2 = 3;
    level.var_a921cd80 = 4;
    if (isdefined(level.var_1694f167)) {
        level thread [[ level.var_1694f167 ]]();
    } else {
        level thread function_fd272a6b();
    }
    level.var_9c0601a3 = &function_8166f050;
    level.var_749152c4 = &function_eeec66f5;
    level.var_c8cf79a8 = &function_c8cf79a8;
    spawner::add_archetype_spawn_function("mechz", &function_8d3603b3);
    level.var_e1e49cc1 = &function_dbf487d9;
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x5 linked
// Checksum 0xc13e70f6, Offset: 0xe40
// Size: 0x7c
function private function_8d3603b3() {
    self.non_attacker_func = &function_4d1bc672;
    self.non_attack_func_takes_attacker = 1;
    self.instakill_func = &function_81bef5d7;
    self.completed_emerging_into_playable_area = 1;
    self function_a3dfb444();
    self.no_damage_points = 1;
    self thread zm_spawner::function_1612a0b8();
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x5 linked
// Checksum 0xe4661ca3, Offset: 0xec8
// Size: 0x17c
function private function_a3dfb444() {
    self.var_ba00c27 = [];
    foreach (var_d67b360d in level.var_de2f92cb) {
        var_74e66334 = spawnstruct();
        var_74e66334.index = self.var_ba00c27.size;
        var_74e66334.tag = var_d67b360d.tag;
        var_74e66334.clientfield = var_d67b360d.clientfield;
        if (!isdefined(self.var_ba00c27)) {
            self.var_ba00c27 = [];
        } else if (!isarray(self.var_ba00c27)) {
            self.var_ba00c27 = array(self.var_ba00c27);
        }
        self.var_ba00c27[self.var_ba00c27.size] = var_74e66334;
    }
    self.var_ba00c27 = array::randomize(self.var_ba00c27);
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x5 linked
// Checksum 0xe6ec0f7, Offset: 0x1050
// Size: 0x7c
function private function_dbf487d9() {
    self.actor_damage_func = &function_a8588ff;
    self.var_b087942f = level.var_53cc405d * level.var_2c998eb8;
    self.var_46b8e412 = level.var_53cc405d * level.var_27d34cc9;
    self.var_a59d71f5 = level.var_53cc405d * level.var_21dd9210;
    self.var_88b6008d = level.var_53cc405d * level.var_2a704d19;
}

// Namespace namespace_baebcb1
// Params 3, eflags: 0x5 linked
// Checksum 0x336c700b, Offset: 0x10d8
// Size: 0x20
function private function_81bef5d7(player, mod, hit_location) {
    return true;
}

// Namespace namespace_baebcb1
// Params 3, eflags: 0x1 linked
// Checksum 0x1ed8a495, Offset: 0x1100
// Size: 0x4e
function function_4d1bc672(damage, weapon, attacker) {
    if (!isdefined(attacker)) {
        attacker = undefined;
    }
    if (attacker === level.var_f793f80e) {
        self.var_32854687 = 1;
    }
    return false;
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0xf98b9e2f, Offset: 0x1158
// Size: 0x204
function function_6f839d44() {
    level.var_de2f92cb = [];
    level.var_de2f92cb[0] = spawnstruct();
    level.var_de2f92cb[0].model = "c_zom_mech_armor_knee_left";
    level.var_de2f92cb[0].tag = "j_knee_attach_le";
    level.var_de2f92cb[0].clientfield = "mechz_lknee_armor_detached";
    level.var_de2f92cb[1] = spawnstruct();
    level.var_de2f92cb[1].model = "c_zom_mech_armor_knee_right";
    level.var_de2f92cb[1].tag = "j_knee_attach_ri";
    level.var_de2f92cb[1].clientfield = "mechz_rknee_armor_detached";
    level.var_de2f92cb[2] = spawnstruct();
    level.var_de2f92cb[2].model = "c_zom_mech_armor_shoulder_left";
    level.var_de2f92cb[2].tag = "j_shoulderarmor_le";
    level.var_de2f92cb[2].clientfield = "mechz_lshoulder_armor_detached";
    level.var_de2f92cb[3] = spawnstruct();
    level.var_de2f92cb[3].model = "c_zom_mech_armor_shoulder_right";
    level.var_de2f92cb[3].tag = "j_shoulderarmor_ri";
    level.var_de2f92cb[3].clientfield = "mechz_rshoulder_armor_detached";
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x5 linked
// Checksum 0xbbca24b0, Offset: 0x1368
// Size: 0x3b4
function private function_e597e389() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzGetTankTagService", &function_b6ebb97d);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzGetJumpPosService", &function_4f9821c3);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzShouldJump", &function_c9cd5bdd);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzShouldShootFlameAtTank", &function_9ea85604);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzWasKnockedDownByTank", &function_b47192a9);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzWasRobotStomped", &function_4bbd0723);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzShouldShowPain", &mechzshouldshowpain);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzJumpUpActionStart", &function_6f434f2b);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzJumpUpActionTerminate", &function_e3577caa);
    behaviortreenetworkutility::registerbehaviortreeaction("tombMechzJumpHoverAction", undefined, &function_7efad7ec, undefined);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzJumpDownActionStart", &function_58e29f36);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzJumpDownActionTerminate", &function_647ea967);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzRobotStompActionStart", &function_13bab4e7);
    behaviortreenetworkutility::registerbehaviortreeaction("tombMechzRobotStompActionLoop", undefined, &function_a833c7b2, undefined);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzRobotStompActionEnd", &function_e260a84c);
    behaviortreenetworkutility::registerbehaviortreeaction("tombMechzShootFlameAtTankAction", &function_84bcf2d9, &namespace_648c84b6::function_993e2b, &function_f10762);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzTankKnockdownActionStart", &function_f7a84bd6);
    behaviortreenetworkutility::registerbehaviortreeaction("tombMechzTankKnockdownActionLoop", undefined, &function_9dc92f99, undefined);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tombMechzTankKnockdownActionEnd", &function_5276dd35);
    animationstatenetwork::registeranimationmocomp("mocomp_face_tank@mechz", &function_744a18d6, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_jump_tank@mechz", &function_6024ae49, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_tomb_mechz_traversal@mechz", &function_3b00a84, undefined, &function_5e254e4f);
}

// Namespace namespace_baebcb1
// Params 1, eflags: 0x5 linked
// Checksum 0xad48f0a4, Offset: 0x1728
// Size: 0x138
function private function_b6ebb97d(entity) {
    if (level.var_f793f80e flag::get("tank_moving")) {
        entity.var_afe67307 = undefined;
        return;
    }
    var_aa1b6986 = namespace_e6d36abe::function_6e2be6b3();
    if (isdefined(entity.var_afe67307) && var_aa1b6986.size > 0) {
        return;
    }
    if (!isdefined(entity.favoriteenemy)) {
        entity.var_afe67307 = undefined;
        return;
    }
    if (!entity.favoriteenemy namespace_e6d36abe::function_45560bd3()) {
        entity.var_afe67307 = undefined;
        return;
    }
    str_tag = level.var_f793f80e namespace_e6d36abe::function_c4c3061f(entity, entity.favoriteenemy.origin);
    if (isdefined(str_tag)) {
        entity.var_afe67307 = level.var_f793f80e namespace_e6d36abe::function_21d81b2c(str_tag);
    }
}

// Namespace namespace_baebcb1
// Params 1, eflags: 0x5 linked
// Checksum 0x2bd5cdd5, Offset: 0x1868
// Size: 0xc8
function private function_4f9821c3(entity) {
    if (!level.var_f793f80e flag::get("tank_moving")) {
        entity.var_6b20a6a2 = undefined;
        return;
    }
    if (!isdefined(entity.favoriteenemy)) {
        entity.var_6b20a6a2 = undefined;
        return;
    }
    if (!entity.favoriteenemy namespace_e6d36abe::function_45560bd3()) {
        entity.var_6b20a6a2 = undefined;
        return;
    }
    if (!isdefined(entity.var_6b20a6a2)) {
        entity.var_6b20a6a2 = function_88eb732(entity.origin);
    }
}

// Namespace namespace_baebcb1
// Params 1, eflags: 0x5 linked
// Checksum 0xb07d526c, Offset: 0x1938
// Size: 0x7c
function private function_c9cd5bdd(entity) {
    if (isdefined(entity.var_3e1fb3d1)) {
        return true;
    }
    if (!isdefined(entity.var_6b20a6a2)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.var_6b20a6a2.origin) > 100) {
        return false;
    }
    return true;
}

// Namespace namespace_baebcb1
// Params 1, eflags: 0x5 linked
// Checksum 0x5b4708a9, Offset: 0x19c0
// Size: 0xf6
function private function_9ea85604(entity) {
    /#
        if (isdefined(entity.var_8d96ebb6) && entity.var_8d96ebb6) {
            return true;
        }
    #/
    if (entity.berserk === 1) {
        return false;
    }
    if (!isdefined(entity.var_afe67307)) {
        return false;
    }
    distance2d = distance2dsquared(entity.origin, entity.var_afe67307);
    distance = distancesquared(entity.origin, entity.var_afe67307);
    if (distance2d > 100) {
        return false;
    }
    return true;
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0x4173e10d, Offset: 0x1ac0
// Size: 0x26
function private function_b47192a9(entity, asmstatename) {
    return isdefined(self.var_32854687) && self.var_32854687;
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0xf710c0a8, Offset: 0x1af0
// Size: 0x26
function private function_4bbd0723(entity, asmstatename) {
    return isdefined(self.var_287205b2) && self.var_287205b2;
}

// Namespace namespace_baebcb1
// Params 1, eflags: 0x5 linked
// Checksum 0x3bb3795a, Offset: 0x1b20
// Size: 0x46
function private mechzshouldshowpain(entity) {
    if (entity.var_1c545167 === 1) {
        return 1;
    }
    if (entity.var_77116375 === 1) {
        return 1;
    }
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0x61fbd904, Offset: 0x1b70
// Size: 0x64
function private function_6f434f2b(entity, asmstatename) {
    entity setfreecameralockonallowed(0);
    entity thread function_ce2e05a7();
    entity pathmode("dont move");
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0xe17c84a7, Offset: 0x1be0
// Size: 0xe0
function private function_e3577caa(entity, asmstatename) {
    entity ghost();
    entity.var_1e9eb9fb = 1;
    if (isdefined(entity.var_19cbb780)) {
        entity.var_19cbb780 ghost();
    }
    if (isdefined(entity.var_34297332)) {
        entity.var_7dddbb94 = entity.var_34297332;
    }
    entity thread zombie_utility::zombie_eye_glow_stop();
    entity.var_1ea3b675 = level.time + level.var_2750d45b * 1000;
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0x57d6a2f, Offset: 0x1cc8
// Size: 0x60
function private function_7efad7ec(entity, asmstatename) {
    if (entity.var_1ea3b675 > level.time) {
        return 5;
    }
    if (level.var_f793f80e flag::get("tank_moving")) {
        return 5;
    }
    return 4;
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0xd616d41d, Offset: 0x1d30
// Size: 0x134
function private function_58e29f36(entity, asmstatename) {
    entity.var_1ea3b675 = undefined;
    var_be0ab0a1 = function_30a64ced(1);
    if (!isdefined(var_be0ab0a1.angles)) {
        var_be0ab0a1.angles = (0, 0, 0);
    }
    entity forceteleport(var_be0ab0a1.origin, var_be0ab0a1.angles);
    entity.var_1e9eb9fb = 0;
    entity show();
    if (isdefined(entity.var_19cbb780)) {
        entity.var_19cbb780 show();
    }
    entity.var_34297332 = entity.var_7dddbb94;
    entity.var_7dddbb94 = undefined;
    entity thread zombie_utility::zombie_eye_glow();
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0x74edc72a, Offset: 0x1e70
// Size: 0x6c
function private function_647ea967(entity, asmstatename) {
    entity solid();
    entity setfreecameralockonallowed(1);
    entity.var_3e1fb3d1 = undefined;
    entity pathmode("move allowed");
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0xcfc9a933, Offset: 0x1ee8
// Size: 0x50
function private function_13bab4e7(entity, asmstatename) {
    entity function_97cf5f();
    entity.var_5819fc = level.time + level.var_ba970bfc * 1000;
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0x93233663, Offset: 0x1f40
// Size: 0x3a
function private function_a833c7b2(entity, asmstatename) {
    if (entity.var_5819fc > level.time) {
        return 5;
    }
    return 4;
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0x450309ca, Offset: 0x1f88
// Size: 0x2e
function private function_e260a84c(entity, asmstatename) {
    entity.var_5819fc = undefined;
    entity.var_287205b2 = undefined;
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0x7181b0, Offset: 0x1fc0
// Size: 0x42
function private function_84bcf2d9(entity, asmstatename) {
    entity.var_52298928 = 1;
    return namespace_648c84b6::function_82a18c9c(entity, asmstatename);
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0xb36115f5, Offset: 0x2010
// Size: 0x3a
function private function_f10762(entity, asmstatename) {
    entity.var_52298928 = undefined;
    return namespace_648c84b6::function_bee98bb7(entity, asmstatename);
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0x65500571, Offset: 0x2058
// Size: 0x88
function private function_f7a84bd6(entity, asmstatename) {
    entity function_97cf5f();
    entity show();
    entity pathmode("move allowed");
    entity.var_918f1b56 = level.time + level.var_68f2c2ce * 1000;
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0x57fececa, Offset: 0x20e8
// Size: 0x3a
function private function_9dc92f99(entity, asmstatename) {
    if (entity.var_918f1b56 > level.time) {
        return 5;
    }
    return 4;
}

// Namespace namespace_baebcb1
// Params 2, eflags: 0x5 linked
// Checksum 0xcbff2c0b, Offset: 0x2130
// Size: 0xe2
function private function_5276dd35(entity, asmstatename) {
    if (!level.var_f793f80e flag::get("tank_moving") && entity istouching(level.var_f793f80e)) {
        entity notsolid();
        entity ghost();
        if (isdefined(entity.var_b1d5a124)) {
            entity.var_19cbb780 ghost();
        }
        entity.var_3e1fb3d1 = 1;
    }
    entity.var_918f1b56 = undefined;
    entity.var_32854687 = undefined;
}

// Namespace namespace_baebcb1
// Params 5, eflags: 0x5 linked
// Checksum 0x2d6896fc, Offset: 0x2220
// Size: 0x74
function private function_744a18d6(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face direction", vectornormalize(level.var_f793f80e.origin - entity.origin));
}

// Namespace namespace_baebcb1
// Params 5, eflags: 0x5 linked
// Checksum 0x9533a3df, Offset: 0x22a0
// Size: 0x4c
function private function_6024ae49(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("noclip", 0);
}

// Namespace namespace_baebcb1
// Params 5, eflags: 0x5 linked
// Checksum 0x2254c0be, Offset: 0x22f8
// Size: 0xec
function private function_3b00a84(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity animmode("noclip", 0);
    if (isdefined(entity.traversestartnode)) {
        entity orientmode("face angle", entity.traversestartnode.angles[1]);
    }
    entity setrepairpaths(0);
    entity forceteleport(entity.traversestartnode.origin, entity.traversestartnode.angles, 0);
}

// Namespace namespace_baebcb1
// Params 5, eflags: 0x5 linked
// Checksum 0x9c6ffdea, Offset: 0x23f0
// Size: 0x144
function private function_5e254e4f(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity setrepairpaths(1);
    if (isdefined(entity.traverseendnode)) {
        entity forceteleport(entity.traverseendnode.origin, entity.traverseendnode.angles, 0);
    } else {
        queryresult = positionquery_source_navigation(entity.origin, 0, 64, 20, 4);
        if (queryresult.data.size) {
            entity forceteleport(queryresult.data[0].origin, entity.angles, 0);
        }
    }
    entity finishtraversal();
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x5 linked
// Checksum 0xc447cb99, Offset: 0x2540
// Size: 0xbc
function private function_97cf5f() {
    v_trace_start = self.origin + (0, 0, 100);
    v_trace_end = self.origin - (0, 0, 500);
    v_trace = physicstrace(self.origin, v_trace_end, (-15, -15, -5), (15, 15, 5), self);
    self forceteleport(v_trace["position"], self.angles);
}

// Namespace namespace_baebcb1
// Params 1, eflags: 0x1 linked
// Checksum 0xd3991d19, Offset: 0x2608
// Size: 0x138
function function_88eb732(org) {
    best_dist = -1;
    best_pos = undefined;
    for (i = 0; i < level.var_20d6379d.size; i++) {
        dist = distancesquared(org, level.var_20d6379d[i].origin);
        if (dist < best_dist || best_dist < 0) {
            best_dist = dist;
            best_pos = level.var_20d6379d[i];
        }
    }
    /#
        if (!isdefined(best_pos)) {
            println("mechz_rknee_armor_detached" + self.origin[0] + "mechz_rknee_armor_detached" + self.origin[1] + "mechz_rknee_armor_detached" + self.origin[2] + "mechz_rknee_armor_detached");
        }
    #/
    return best_pos;
}

// Namespace namespace_baebcb1
// Params 1, eflags: 0x1 linked
// Checksum 0xfc55bf05, Offset: 0x2748
// Size: 0x162
function function_eeec66f5(mechz) {
    var_ec9023a6 = mechz.var_ec9023a6;
    var_476e5882 = isdefined(self.var_52298928) && self.var_52298928 && !level.var_f793f80e flag::get("tank_moving");
    a_zombies = namespace_57695b4d::function_d41418b8();
    foreach (zombie in a_zombies) {
        if ((var_476e5882 && zombie namespace_e6d36abe::function_45560bd3() || zombie istouching(var_ec9023a6)) && zombie.var_e05d0be2 !== 1) {
            zombie namespace_57695b4d::function_f4defbc2();
        }
    }
}

// Namespace namespace_baebcb1
// Params 1, eflags: 0x1 linked
// Checksum 0x36d05bd4, Offset: 0x28b8
// Size: 0x192
function function_8166f050(entity) {
    var_476e5882 = isdefined(self.var_52298928) && self.var_52298928 && !level.var_f793f80e flag::get("tank_moving");
    players = getplayers();
    foreach (player in players) {
        if (!(isdefined(player.is_burning) && player.is_burning)) {
            if (var_476e5882 && player namespace_e6d36abe::function_45560bd3() || player istouching(entity.var_ec9023a6)) {
                if (isdefined(entity.var_9e0f068e)) {
                    player thread [[ entity.var_9e0f068e ]]();
                    continue;
                }
                player thread namespace_648c84b6::function_58121b44(entity);
            }
        }
    }
}

// Namespace namespace_baebcb1
// Params c, eflags: 0x1 linked
// Checksum 0x563f9fb, Offset: 0x2a58
// Size: 0x116
function function_c8cf79a8(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (self namespace_ecdcc148::function_81557bff(weapon) && mod != "MOD_MELEE") {
        if (mod != "MOD_BURNED" && mod != "MOD_GRENADE_SPLASH") {
            return namespace_ecdcc148::function_4b513520(weapon);
        }
    }
    if (self namespace_589e3c80::function_3837465d(weapon) || self namespace_42f5ba79::function_61c85f8e(weapon) || self namespace_dc4ed61a::function_e958695f(weapon)) {
        return damage;
    }
    return 0;
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0xe64054c7, Offset: 0x2b78
// Size: 0x74
function function_24025db6() {
    /#
        if (getdvarint("mechz_rknee_armor_detached") >= 2) {
            return;
        }
    #/
    level.var_21bd82ba = 1;
    level flag::init("mechz_round");
    level thread function_5639dba0();
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0x2cdce31f, Offset: 0x2bf8
// Size: 0x3c0
function function_5639dba0() {
    level.var_771263fa = 0;
    old_spawn_func = level.round_spawn_func;
    old_wait_func = level.round_wait_func;
    level flag::wait_till("activate_zone_nml");
    var_192b8ad3 = 8;
    if (isdefined(level.is_forever_solo_game) && level.is_forever_solo_game) {
        var_192b8ad3 = 8;
    }
    while (level.round_number < var_192b8ad3) {
        level waittill(#"between_round_over");
    }
    level.var_7f46321d = level.round_number;
    level thread function_b80da699();
    while (true) {
        if (level.var_771263fa > 0) {
            level.var_d9d8f8b3 = 1;
        }
        if (level.var_7f46321d <= level.round_number) {
            a_zombies = getaispeciesarray(level.zombie_team, "all");
            foreach (zombie in a_zombies) {
                if (isdefined(zombie.is_mechz) && zombie.is_mechz && isalive(zombie)) {
                    level.var_7f46321d++;
                    break;
                }
            }
        }
        if (level.var_b0b2114c == 0 && level.var_7f46321d <= level.round_number) {
            function_6367c303();
            if (level.players.size == 1) {
                level.var_2e26f510 = 1;
            } else if (level.var_65863f29 < 2) {
                level.var_2e26f510 = 1;
            } else if (level.var_65863f29 < 5) {
                level.var_2e26f510 = 2;
            } else {
                level.var_2e26f510 = 3;
            }
            level.var_b0b2114c = level.var_2e26f510;
            var_fc89ccd0 = level.var_b0b2114c;
            wait(randomfloatrange(10, 15));
            level notify(#"hash_53c37648");
            if (isdefined(level.is_forever_solo_game) && level.is_forever_solo_game) {
                var_ba7c9d31 = randomintrange(level.var_ccff5b86, level.var_4534e4c4);
            } else {
                var_ba7c9d31 = randomintrange(level.var_be18040, level.var_7fdeefc2);
            }
            level.var_7f46321d = level.round_number + var_ba7c9d31;
            level.var_65863f29++;
            level thread function_b80da699();
            level.var_771263fa += var_fc89ccd0;
        }
        level waittill(#"between_round_over");
    }
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0x52a291d6, Offset: 0x2fc0
// Size: 0x4c
function function_b80da699() {
    level flag::wait_till("start_zombie_round_logic");
    /#
        iprintln("mechz_rknee_armor_detached" + level.var_7f46321d);
    #/
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0xd61c0576, Offset: 0x3018
// Size: 0x14c
function function_fd272a6b() {
    level thread function_24025db6();
    while (true) {
        level waittill(#"hash_53c37648");
        while (level.var_b0b2114c) {
            s_loc = function_27b9fdd3();
            if (!isdefined(s_loc)) {
                continue;
            }
            ai = namespace_ef567265::function_53c37648(s_loc, 1);
            waittillframeend();
            ai clientfield::set("tomb_mech_eye", 1);
            ai thread function_9ff7f577();
            ai.var_65eda69a = 1;
            level.var_b0b2114c--;
            if (level.var_b0b2114c == 0) {
                level thread function_dcf8adf0();
            }
            ai thread function_362cfff6();
            wait(randomfloatrange(3, 6));
        }
    }
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0xd404cfdf, Offset: 0x3170
// Size: 0xf4
function function_9ff7f577() {
    self waittill(#"hash_46c1e51d");
    self clientfield::set("tomb_mech_eye", 0);
    level notify(#"hash_f3f6ac90", self.origin);
    if (level flag::get("zombie_drop_powerups") && !(isdefined(self.no_powerups) && self.no_powerups)) {
        var_d54b1ec = array("double_points", "insta_kill", "full_ammo", "nuke");
        str_type = array::random(var_d54b1ec);
        zm_powerups::specific_powerup_drop(str_type, self.origin);
    }
}

// Namespace namespace_baebcb1
// Params 1, eflags: 0x1 linked
// Checksum 0xf32ba25d, Offset: 0x3270
// Size: 0x362
function function_30a64ced(var_37841ec8) {
    if (!isdefined(var_37841ec8)) {
        var_37841ec8 = 0;
    }
    best_dist = -1;
    best_pos = undefined;
    for (i = 0; i < level.var_20d6379d.size; i++) {
        str_zone = zm_zonemgr::get_zone_from_position(level.var_20d6379d[i].origin, 0);
        if (!isdefined(str_zone)) {
            continue;
        }
        if (isdefined(level.var_20d6379d[i].var_2984b154) && !var_37841ec8 && level.var_20d6379d[i].var_2984b154) {
            continue;
        }
        if (isdefined(level.var_20d6379d[i].var_c923bdfa) && var_37841ec8 == 1 && level.var_20d6379d[i].var_c923bdfa) {
            continue;
        }
        for (j = 0; j < level.players.size; j++) {
            if (zombie_utility::is_player_valid(level.players[j], 1, 1)) {
                dist = distancesquared(level.var_20d6379d[i].origin, level.players[j].origin);
                if (dist < best_dist || best_dist < 0) {
                    best_dist = dist;
                    best_pos = level.var_20d6379d[i];
                }
            }
        }
    }
    if (var_37841ec8 && isdefined(best_pos)) {
        best_pos thread function_a755b8ae();
    }
    if (isdefined(best_pos)) {
        best_pos.var_2984b154 = 1;
    } else if (level.var_20d6379d.size > 0) {
        var_634f9cbb = array::randomize(level.var_20d6379d);
        foreach (location in var_634f9cbb) {
            str_zone = zm_zonemgr::get_zone_from_position(location.origin, 0);
            if (isdefined(str_zone)) {
                return location;
            }
        }
        return level.var_20d6379d[randomint(level.var_20d6379d.size)];
    }
    return best_pos;
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x0
// Checksum 0x8a4efbd4, Offset: 0x35e0
// Size: 0x4a
function function_20775399() {
    for (i = 0; i < level.var_20d6379d.size; i++) {
        level.var_20d6379d[i].var_2984b154 = 0;
    }
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0x49b119f5, Offset: 0x3638
// Size: 0x24
function function_a755b8ae() {
    self.var_c923bdfa = 1;
    wait(5);
    self.var_c923bdfa = 0;
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0xfb57b628, Offset: 0x3668
// Size: 0x104
function function_6367c303() {
    if (!isdefined(level.var_44bca3d6) || level.round_number > level.var_44bca3d6) {
        a_players = getplayers();
        n_player_modifier = 1;
        if (a_players.size > 1) {
            n_player_modifier = a_players.size * 0.75;
        }
        level.var_53cc405d = int(n_player_modifier * (level.var_f1419b9d + level.var_a1748a68 * level.var_65863f29));
        if (level.var_53cc405d >= 22500 * n_player_modifier) {
            level.var_53cc405d = int(22500 * n_player_modifier);
        }
        level.var_44bca3d6 = level.round_number;
    }
}

// Namespace namespace_baebcb1
// Params 11, eflags: 0x1 linked
// Checksum 0x57a9a14b, Offset: 0x3778
// Size: 0x700
function function_a8588ff(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, poffsettime, boneindex) {
    if (isdefined(self.var_a1c73f09) && !(isdefined(self.var_a1c73f09) && self.var_a1c73f09)) {
        return 0;
    }
    var_71263625 = level.var_de2f92cb.size + 1;
    var_ea7330f4 = int(var_71263625 * self.health / level.var_53cc405d);
    bonename = getpartname("c_zom_mech_body", boneindex);
    if (isdefined(attacker.personal_instakill) && (level.zombie_vars[attacker.team]["zombie_insta_kill"] || isdefined(attacker) && isalive(attacker) && isplayer(attacker) && attacker.personal_instakill)) {
        var_ec7c92e3 = 1;
        var_c2d37ef4 = 2;
    } else {
        var_ec7c92e3 = level.var_a47eaca6;
        var_c2d37ef4 = 1;
    }
    if (isdefined(weapon) && weapon.weapclass == "spread") {
        var_ec7c92e3 *= level.var_9eaf8820;
        var_c2d37ef4 *= level.var_9eaf8820;
    }
    if (damage <= 10) {
        var_ec7c92e3 = 1;
    }
    if (zm_utility::is_explosive_damage(meansofdeath) || issubstr(weapon.name, "staff")) {
        if (var_ec7c92e3 < 0.5) {
            var_ec7c92e3 = 0.5;
        }
        if (!(isdefined(self.var_aba6456b) && self.var_aba6456b) && issubstr(weapon.name, "staff") && var_ec7c92e3 < 1) {
            var_ec7c92e3 = 1;
        }
        final_damage = damage * var_ec7c92e3;
        if (!isdefined(self.var_5ad1fcf3)) {
            self.var_5ad1fcf3 = 0;
        }
        self.var_5ad1fcf3 += final_damage;
        self namespace_e907cf54::function_b024a4c(final_damage);
        if (isdefined(level.var_78fafa94)) {
            [[ level.var_78fafa94 ]]();
        }
        attacker namespace_e907cf54::show_hit_marker();
    } else {
        final_damage = damage * var_ec7c92e3;
        if (shitloc === "torso_upper") {
            if (isdefined(self.var_aba6456b) && self.var_aba6456b) {
                var_2700f09 = self gettagorigin("j_faceplate");
                dist_sq = distancesquared(var_2700f09, vpoint);
                if (dist_sq <= -112) {
                    self namespace_e907cf54::function_b024a4c(final_damage);
                }
                var_178d0187 = distancesquared(vpoint, self gettagorigin("tag_headlamp_FX"));
                if (var_178d0187 <= 9) {
                    self namespace_e907cf54::function_378d99af(1);
                }
            }
            if (bonename == "tag_powersupply" || bonename == "tag_powersupply_hit") {
                if (isdefined(self.var_41505d43) && self.var_41505d43) {
                    self namespace_e907cf54::function_ff3f6e(final_damage);
                } else if (isdefined(self.var_6d2e297f) && self.var_6d2e297f) {
                    self namespace_e907cf54::function_81c30baa(final_damage);
                }
            }
        } else if (shitloc === "left_hand" || shitloc === "left_arm_lower" || isdefined(self.conehalfheight) && shitloc === "left_arm_upper") {
            if (isdefined(self.conehalfheight)) {
                self.var_77116375 = 1;
            }
            if (isdefined(level.var_ca204e3d)) {
                self [[ level.var_ca204e3d ]]();
            }
        } else if (shitloc == "head") {
            final_damage = damage * var_c2d37ef4;
        }
        attacker namespace_e907cf54::show_hit_marker();
    }
    if (!isdefined(weapon) || weapon.name == "none") {
        if (!isplayer(attacker)) {
            final_damage = 0;
        }
    }
    var_50fbee1 = int(var_71263625 * (self.health - final_damage) / level.var_53cc405d);
    if (var_ea7330f4 > var_50fbee1) {
        while (var_ea7330f4 > var_50fbee1) {
            /#
                iprintlnbold("mechz_rknee_armor_detached" + var_ea7330f4 + "mechz_rknee_armor_detached" + var_50fbee1 + "mechz_rknee_armor_detached");
            #/
            if (var_ea7330f4 < var_71263625) {
                self function_7a47d165();
            }
            var_ea7330f4--;
        }
    }
    /#
        iprintlnbold("mechz_rknee_armor_detached" + final_damage + "mechz_rknee_armor_detached" + self.health);
    #/
    return final_damage;
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x5 linked
// Checksum 0xd87a998b, Offset: 0x3e80
// Size: 0xb4
function private function_7a47d165() {
    if (!isdefined(self.var_2cb75e0d)) {
        self.var_2cb75e0d = 0;
    }
    if (!isdefined(self.var_ba00c27) || self.var_2cb75e0d >= self.var_ba00c27.size) {
        return;
    }
    self namespace_e907cf54::hide_part(self.var_ba00c27[self.var_2cb75e0d].tag);
    self clientfield::set(self.var_ba00c27[self.var_2cb75e0d].clientfield, 1);
    self.var_2cb75e0d++;
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x0
// Checksum 0xbaf849c8, Offset: 0x3f40
// Size: 0x2a
function function_f73b1530() {
    self notify(#"hash_e2ed6545");
    self notify(#"hash_f9a4b3d6");
    self notify(#"hash_517ec5c4");
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0x91a0603d, Offset: 0x3f78
// Size: 0x34
function function_3f19350b() {
    self endon(#"death");
    if (isdefined(self.var_287205b2) && self.var_287205b2) {
        return;
    }
    self.var_287205b2 = 1;
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0x5ca905e1, Offset: 0x3fb8
// Size: 0x1fe
function function_dcf8adf0() {
    wait(3);
    a_players = getplayers();
    if (a_players.size == 0) {
        return;
    }
    a_players = array::randomize(a_players);
    foreach (player in a_players) {
        if (zombie_utility::is_player_valid(player)) {
            if (!(isdefined(player.dontspeak) && player.dontspeak)) {
                if (!isdefined(level.var_6e21a978)) {
                    player zm_audio::create_and_play_dialog("general", "siren_1st_time");
                    level.var_6e21a978 = 1;
                    while (isdefined(player.isspeaking) && isdefined(player) && player.isspeaking) {
                        wait(0.1);
                    }
                    level thread function_a14fcf98();
                    break;
                }
                if (level.var_2e26f510 == 1) {
                    player zm_audio::create_and_play_dialog("general", "siren_generic");
                    break;
                }
                player zm_audio::create_and_play_dialog("general", "multiple_mechs");
                break;
            }
        }
    }
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0x5af9fe4b, Offset: 0x41c0
// Size: 0x1b2
function function_a14fcf98() {
    wait(1);
    a_zombies = getaispeciesarray(level.zombie_team, "all");
    foreach (zombie in a_zombies) {
        if (isdefined(zombie.is_mechz) && zombie.is_mechz) {
            var_99c3dd59 = zombie;
        }
    }
    a_players = getplayers();
    if (a_players.size == 0) {
        return;
    }
    if (isalive(var_99c3dd59)) {
        foreach (player in a_players) {
            player thread function_7a4a59bb(var_99c3dd59);
        }
    }
}

// Namespace namespace_baebcb1
// Params 1, eflags: 0x1 linked
// Checksum 0xb02ad253, Offset: 0x4380
// Size: 0x104
function function_7a4a59bb(var_99c3dd59) {
    self endon(#"disconnect");
    var_99c3dd59 endon(#"death");
    level endon(#"hash_12bed9ce");
    while (true) {
        if (distancesquared(self.origin, var_99c3dd59.origin) < 1000000) {
            if (self zm_utility::is_player_looking_at(var_99c3dd59.origin + (0, 0, 60), 0.75)) {
                if (!(isdefined(self.dontspeak) && self.dontspeak)) {
                    self zm_audio::create_and_play_dialog("general", "discover_mech");
                    level notify(#"hash_12bed9ce");
                    break;
                }
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_baebcb1
// Params 1, eflags: 0x0
// Checksum 0x16d0f05, Offset: 0x4490
// Size: 0xac
function function_6647f386(var_99c3dd59) {
    self endon(#"disconnect");
    self zm_audio::create_and_play_dialog("general", "mech_grab");
    while (isdefined(self.isspeaking) && isdefined(self) && self.isspeaking) {
        wait(0.1);
    }
    wait(1);
    if (isalive(var_99c3dd59) && isdefined(var_99c3dd59.conehalfheight)) {
        var_99c3dd59 thread function_368dc30e();
    }
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0xf15fb859, Offset: 0x4548
// Size: 0x188
function function_368dc30e() {
    self endon(#"death");
    while (true) {
        if (!isdefined(self.conehalfheight)) {
            return;
        }
        a_players = getplayers();
        foreach (player in a_players) {
            if (player == self.conehalfheight) {
                continue;
            }
            if (distancesquared(self.origin, player.origin) < 1000000) {
                if (player zm_utility::is_player_looking_at(self.origin + (0, 0, 60), 0.75)) {
                    if (!(isdefined(player.dontspeak) && player.dontspeak)) {
                        player zm_audio::create_and_play_dialog("general", "shoot_mech_arm");
                        return;
                    }
                }
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0x178beb31, Offset: 0x46d8
// Size: 0xe
function function_362cfff6() {
    self endon(#"death");
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x0
// Checksum 0x729326fe, Offset: 0x46f0
// Size: 0x16c
function function_77edd6e1() {
    self endon(#"death");
    a_players = getplayers();
    foreach (player in a_players) {
        if (isdefined(self.conehalfheight) && self.conehalfheight == player) {
            continue;
        }
        if (distancesquared(self.origin, player.origin) < 1000000) {
            if (player zm_utility::is_player_looking_at(self.origin + (0, 0, 60), 0.75)) {
                if (!(isdefined(player.dontspeak) && player.dontspeak)) {
                    player zm_audio::create_and_play_dialog("general", "shoot_mech_head");
                    return;
                }
            }
        }
    }
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0x3cc61f3e, Offset: 0x4868
// Size: 0x154
function function_ce2e05a7() {
    a_players = getplayers();
    foreach (player in a_players) {
        if (distancesquared(self.origin, player.origin) < 1000000) {
            if (player zm_utility::is_player_looking_at(self.origin + (0, 0, 60), 0.5)) {
                if (!(isdefined(player.dontspeak) && player.dontspeak)) {
                    player util::delay(3, undefined, &zm_audio::create_and_play_dialog, "general", "rspnd_mech_jump");
                    return;
                }
            }
        }
    }
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x0
// Checksum 0xfde34dc5, Offset: 0x49c8
// Size: 0x154
function function_acd73632() {
    self endon(#"death");
    wait(5);
    a_players = getplayers();
    foreach (player in a_players) {
        if (distancesquared(self.origin, player.origin) < 1000000) {
            if (player zm_utility::is_player_looking_at(self.origin + (0, 0, 60), 0.75)) {
                if (!(isdefined(player.dontspeak) && player.dontspeak)) {
                    player thread zm_audio::create_and_play_dialog("general", "robot_crush_mech");
                    return;
                }
            }
        }
    }
}

// Namespace namespace_baebcb1
// Params 0, eflags: 0x1 linked
// Checksum 0xf1b73085, Offset: 0x4b28
// Size: 0x23e
function function_27b9fdd3() {
    var_fffe05f0 = array::randomize(level.var_20d6379d);
    a_spawn_locs = [];
    for (i = 0; i < var_fffe05f0.size; i++) {
        s_loc = var_fffe05f0[i];
        str_zone = zm_zonemgr::get_zone_from_position(s_loc.origin, 1);
        if (isdefined(str_zone) && level.zones[str_zone].is_occupied) {
            a_spawn_locs[a_spawn_locs.size] = s_loc;
        }
    }
    if (a_spawn_locs.size == 0) {
        for (i = 0; i < var_fffe05f0.size; i++) {
            s_loc = var_fffe05f0[i];
            str_zone = zm_zonemgr::get_zone_from_position(s_loc.origin, 1);
            if (isdefined(str_zone) && level.zones[str_zone].is_active) {
                a_spawn_locs[a_spawn_locs.size] = s_loc;
            }
        }
    }
    if (a_spawn_locs.size > 0) {
        return a_spawn_locs[0];
    }
    foreach (s_loc in var_fffe05f0) {
        str_zone = zm_zonemgr::get_zone_from_position(s_loc.origin, 0);
        if (isdefined(str_zone)) {
            return s_loc;
        }
    }
    return var_fffe05f0[0];
}

