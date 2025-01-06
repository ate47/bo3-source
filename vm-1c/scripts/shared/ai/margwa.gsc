#using scripts/codescripts/struct;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/margwa;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;

#namespace namespace_6c6fd2b0;

// Namespace namespace_6c6fd2b0
// Params 0, eflags: 0x2
// Checksum 0xa965e697, Offset: 0xba8
// Size: 0x374
function autoexec init() {
    function_618e8c7d();
    spawner::add_archetype_spawn_function("margwa", &function_6c01c950);
    spawner::add_archetype_spawn_function("margwa", &namespace_c96301ee::function_eac87e92);
    clientfield::register("actor", "margwa_head_left", 1, 2, "int");
    clientfield::register("actor", "margwa_head_mid", 1, 2, "int");
    clientfield::register("actor", "margwa_head_right", 1, 2, "int");
    clientfield::register("actor", "margwa_fx_in", 1, 1, "counter");
    clientfield::register("actor", "margwa_fx_out", 1, 1, "counter");
    clientfield::register("actor", "margwa_fx_spawn", 1, 1, "counter");
    clientfield::register("actor", "margwa_smash", 1, 1, "counter");
    clientfield::register("actor", "margwa_head_left_hit", 1, 1, "counter");
    clientfield::register("actor", "margwa_head_mid_hit", 1, 1, "counter");
    clientfield::register("actor", "margwa_head_right_hit", 1, 1, "counter");
    clientfield::register("actor", "margwa_head_killed", 1, 2, "int");
    clientfield::register("actor", "margwa_jaw", 1, 6, "int");
    clientfield::register("toplayer", "margwa_head_explosion", 1, 1, "counter");
    clientfield::register("scriptmover", "margwa_fx_travel", 1, 1, "int");
    clientfield::register("scriptmover", "margwa_fx_travel_tell", 1, 1, "int");
    clientfield::register("actor", "supermargwa", 1, 1, "int");
    function_ce6a5d8a();
}

// Namespace namespace_6c6fd2b0
// Params 0, eflags: 0x4
// Checksum 0xc4888c0d, Offset: 0xf28
// Size: 0xde
function private function_ce6a5d8a() {
    if (!isdefined(level.var_dbb10dd8)) {
        level.var_dbb10dd8 = [];
    }
    level.var_dbb10dd8[level.var_dbb10dd8.size] = "ray_gun";
    level.var_dbb10dd8[level.var_dbb10dd8.size] = "ray_gun_upgraded";
    level.var_dbb10dd8[level.var_dbb10dd8.size] = "pistol_standard_upgraded";
    level.var_dbb10dd8[level.var_dbb10dd8.size] = "pistol_revolver38_upgraded";
    level.var_dbb10dd8[level.var_dbb10dd8.size] = "pistol_revolver38lh_upgraded";
    level.var_dbb10dd8[level.var_dbb10dd8.size] = "launcher_standard";
    level.var_dbb10dd8[level.var_dbb10dd8.size] = "launcher_standard_upgraded";
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x0
// Checksum 0x8767be64, Offset: 0x1010
// Size: 0xa2
function function_5f9266e0(weaponname) {
    foreach (weapon in level.var_dbb10dd8) {
        if (weapon == weaponname) {
            return;
        }
    }
    level.var_dbb10dd8[level.var_dbb10dd8.size] = weaponname;
}

// Namespace namespace_6c6fd2b0
// Params 0, eflags: 0x4
// Checksum 0xa7b6071c, Offset: 0x10c0
// Size: 0x654
function private function_618e8c7d() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTargetService", &margwatargetservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldSmashAttack", &margwashouldsmashattack);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldSwipeAttack", &margwashouldswipeattack);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldShowPain", &margwashouldshowpain);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldReactStun", &margwashouldreactstun);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldReactIDGun", &margwaShouldReactIDGun);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldReactSword", &margwaShouldReactSword);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldSpawn", &margwashouldspawn);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldFreeze", &margwaShouldFreeze);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldTeleportIn", &margwaShouldTeleportIn);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldTeleportOut", &margwaShouldTeleportOut);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldWait", &margwaShouldWait);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaShouldReset", &margwashouldreset);
    behaviortreenetworkutility::registerbehaviortreeaction("margwaReactStunAction", &margwareactstunaction, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreeaction("margwaSwipeAttackAction", &margwaswipeattackaction, &function_43d6f899, undefined);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaIdleStart", &margwaidlestart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaMoveStart", &margwamovestart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTraverseActionStart", &margwatraverseactionstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTeleportInStart", &margwaTeleportInStart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTeleportInTerminate", &margwaTeleportInTerminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTeleportOutStart", &margwaTeleportOutStart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaTeleportOutTerminate", &margwaTeleportOutTerminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaPainStart", &margwapainstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaPainTerminate", &margwapainterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactStunStart", &margwareactstunstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactStunTerminate", &margwareactstunterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactIDGunStart", &margwaReactIDGunStart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactIDGunTerminate", &margwaReactIDGunTerminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactSwordStart", &margwaReactSwordStart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaReactSwordTerminate", &margwaReactSwordTerminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSpawnStart", &margwaspawnstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSmashAttackStart", &margwasmashattackstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSmashAttackTerminate", &margwasmashattackterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSwipeAttackStart", &margwaswipeattackstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("margwaSwipeAttackTerminate", &margwaswipeattackterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@margwa", &function_405168ca, &function_95847de7, &function_8bdd20c9);
    animationstatenetwork::registernotetrackhandlerfunction("margwa_smash_attack", &function_f28be431);
    animationstatenetwork::registernotetrackhandlerfunction("margwa_bodyfall large", &function_c2a638dc);
    animationstatenetwork::registernotetrackhandlerfunction("margwa_melee_fire", &function_13e0502d);
}

// Namespace namespace_6c6fd2b0
// Params 0, eflags: 0x4
// Checksum 0xfa165bd7, Offset: 0x1720
// Size: 0x1e4
function private function_6c01c950() {
    blackboard::createblackboardforentity(self);
    self aiutility::function_89e1fc16();
    blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_walk", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("<dev string:x28>");
        #/
    }
    blackboard::registerblackboardattribute(self, "_board_attack_spot", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("<dev string:x3a>");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_should_turn", "should_not_turn", &bb_getshouldturn);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("<dev string:x4d>");
        #/
    }
    blackboard::registerblackboardattribute(self, "_zombie_damageweapon_type", "regular", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("<dev string:x65>");
        #/
    }
    self.___archetypeonanimscriptedcallback = &function_4bc01a36;
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x8cf5c123, Offset: 0x1910
// Size: 0x34
function private function_4bc01a36(entity) {
    entity.__blackboard = undefined;
    entity function_6c01c950();
}

// Namespace namespace_6c6fd2b0
// Params 0, eflags: 0x4
// Checksum 0x4ceb83c0, Offset: 0x1950
// Size: 0x2a
function private bb_getshouldturn() {
    if (isdefined(self.should_turn) && self.should_turn) {
        return "should_turn";
    }
    return "should_not_turn";
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0xa780ba6f, Offset: 0x1988
// Size: 0x330
function private function_f28be431(entity) {
    players = getplayers();
    foreach (player in players) {
        var_c06eca13 = entity.origin + vectorscale(anglestoforward(self.angles), 60);
        distsq = distancesquared(var_c06eca13, player.origin);
        if (distsq < 20736) {
            if (!isgodmode(player)) {
                if (isdefined(player.hasriotshield) && player.hasriotshield) {
                    damageshield = 0;
                    attackdir = player.origin - self.origin;
                    if (isdefined(player.hasriotshieldequipped) && player.hasriotshieldequipped) {
                        if (player namespace_c96301ee::function_2edfc800(attackdir, 0.2)) {
                            damageshield = 1;
                        }
                    } else if (player namespace_c96301ee::function_2edfc800(attackdir, 0.2, 0)) {
                        damageshield = 1;
                    }
                    if (damageshield) {
                        self clientfield::increment("margwa_smash");
                        shield_damage = level.weaponriotshield.weaponstarthitpoints;
                        if (isdefined(player.weaponriotshield)) {
                            shield_damage = player.weaponriotshield.weaponstarthitpoints;
                        }
                        player [[ player.player_shield_apply_damage ]](shield_damage, 0);
                        continue;
                    }
                }
                if (isdefined(level.var_d8750101) && isfunctionptr(level.var_d8750101)) {
                    if (player [[ level.var_d8750101 ]](self)) {
                        continue;
                    }
                }
                self clientfield::increment("margwa_smash");
                player dodamage(-90, self.origin, self);
            }
        }
    }
    if (isdefined(self.var_d3a99070)) {
        self [[ self.var_d3a99070 ]]();
    }
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0xcc2ff858, Offset: 0x1cc0
// Size: 0x50
function private function_c2a638dc(entity) {
    if (self.archetype == "margwa") {
        entity ghost();
        if (isdefined(self.var_b4036965)) {
            self [[ self.var_b4036965 ]]();
        }
    }
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x3d30e629, Offset: 0x1d18
// Size: 0x24
function private function_13e0502d(entity) {
    entity melee();
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0xd35cfd3f, Offset: 0x1d48
// Size: 0x158
function private margwatargetservice(entity) {
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    player = zombie_utility::get_closest_valid_player(self.origin, self.ignore_player);
    if (!isdefined(player)) {
        if (isdefined(self.ignore_player)) {
            if (isdefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]()) {
                return;
            }
            self.ignore_player = [];
        }
        self setgoal(self.origin);
        return 0;
    }
    targetpos = getclosestpointonnavmesh(player.origin, 64, 30);
    if (isdefined(targetpos)) {
        entity setgoal(targetpos);
        return 1;
    }
    entity setgoal(entity.origin);
    return 0;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x0
// Checksum 0x55fea848, Offset: 0x1ea8
// Size: 0x8e
function margwashouldsmashattack(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (!entity namespace_c96301ee::function_4e77203(entity.enemy)) {
        return false;
    }
    yaw = abs(zombie_utility::getyawtoenemy());
    if (yaw > 45) {
        return false;
    }
    return true;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x0
// Checksum 0xaa61328b, Offset: 0x1f40
// Size: 0xa6
function margwashouldswipeattack(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.enemy.origin) > 16384) {
        return false;
    }
    yaw = abs(zombie_utility::getyawtoenemy());
    if (yaw > 45) {
        return false;
    }
    return true;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x55b8c89e, Offset: 0x1ff0
// Size: 0xfe
function private margwashouldshowpain(entity) {
    if (isdefined(entity.headdestroyed)) {
        headinfo = entity.head[entity.headdestroyed];
        switch (headinfo.cf) {
        case "margwa_head_left":
            blackboard::setblackboardattribute(self, "_margwa_head", "left");
            break;
        case "margwa_head_mid":
            blackboard::setblackboardattribute(self, "_margwa_head", "middle");
            break;
        case "margwa_head_right":
            blackboard::setblackboardattribute(self, "_margwa_head", "right");
            break;
        }
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x6f008555, Offset: 0x20f8
// Size: 0x3a
function private margwashouldreactstun(entity) {
    if (isdefined(entity.var_9e59b56e) && entity.var_9e59b56e) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x99e54d21, Offset: 0x2140
// Size: 0x3a
function private margwaShouldReactIDGun(entity) {
    if (isdefined(entity.var_843f1731) && entity.var_843f1731) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x5502adc7, Offset: 0x2188
// Size: 0x3a
function private margwaShouldReactSword(entity) {
    if (isdefined(entity.var_70e85a9d) && entity.var_70e85a9d) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x16151ad8, Offset: 0x21d0
// Size: 0x3a
function private margwashouldspawn(entity) {
    if (isdefined(entity.var_c7ae07c2) && entity.var_c7ae07c2) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0xc130f05, Offset: 0x2218
// Size: 0x3a
function private margwaShouldFreeze(entity) {
    if (isdefined(entity.isfrozen) && entity.isfrozen) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x3bcaedeb, Offset: 0x2260
// Size: 0x3a
function private margwaShouldTeleportIn(entity) {
    if (isdefined(entity.var_b830cb9) && entity.var_b830cb9) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x244ff5fb, Offset: 0x22a8
// Size: 0x3a
function private margwaShouldTeleportOut(entity) {
    if (isdefined(entity.var_3993b370) && entity.var_3993b370) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x87da610, Offset: 0x22f0
// Size: 0x3a
function private margwaShouldWait(entity) {
    if (isdefined(entity.waiting) && entity.waiting) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0xbe201424, Offset: 0x2338
// Size: 0xaa
function private margwashouldreset(entity) {
    if (isdefined(entity.headdestroyed)) {
        return true;
    }
    if (isdefined(entity.var_843f1731) && entity.var_843f1731) {
        return true;
    }
    if (isdefined(entity.var_70e85a9d) && entity.var_70e85a9d) {
        return true;
    }
    if (isdefined(entity.var_9e59b56e) && entity.var_9e59b56e) {
        return true;
    }
    return false;
}

// Namespace namespace_6c6fd2b0
// Params 2, eflags: 0x4
// Checksum 0xb4b5902e, Offset: 0x23f0
// Size: 0xf0
function private margwareactstunaction(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    var_a0d3cbe5 = entity astsearch(istring(asmstatename));
    var_aee9e36b = animationstatenetworkutility::searchanimationmap(entity, var_a0d3cbe5["animation"]);
    closetime = getanimlength(var_aee9e36b) * 1000;
    entity namespace_c96301ee::function_b09c53b4(closetime);
    margwareactstunstart(entity);
    return 5;
}

// Namespace namespace_6c6fd2b0
// Params 2, eflags: 0x4
// Checksum 0xd06e7fc6, Offset: 0x24e8
// Size: 0xe8
function private margwaswipeattackaction(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    if (!isdefined(entity.var_5ed154c5)) {
        var_6efece41 = entity astsearch(istring(asmstatename));
        var_a6752387 = animationstatenetworkutility::searchanimationmap(entity, var_6efece41["animation"]);
        var_9535398c = getanimlength(var_a6752387) * 1000;
        entity.var_5ed154c5 = gettime() + var_9535398c;
    }
    return 5;
}

// Namespace namespace_6c6fd2b0
// Params 2, eflags: 0x4
// Checksum 0xc27867e9, Offset: 0x25d8
// Size: 0x46
function private function_43d6f899(entity, asmstatename) {
    if (isdefined(entity.var_5ed154c5) && gettime() > entity.var_5ed154c5) {
        return 4;
    }
    return 5;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x40d5dca6, Offset: 0x2628
// Size: 0x44
function private margwaidlestart(entity) {
    if (entity namespace_c96301ee::function_33361523()) {
        entity clientfield::set("margwa_jaw", 1);
    }
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x5deebad0, Offset: 0x2678
// Size: 0x8c
function private margwamovestart(entity) {
    if (entity namespace_c96301ee::function_33361523()) {
        if (entity.zombie_move_speed == "run") {
            entity clientfield::set("margwa_jaw", 13);
            return;
        }
        entity clientfield::set("margwa_jaw", 7);
    }
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x57cead69, Offset: 0x2710
// Size: 0xc
function private function_d663d52(entity) {
    
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0xdd88bf83, Offset: 0x2728
// Size: 0x14e
function private margwatraverseactionstart(entity) {
    blackboard::setblackboardattribute(entity, "_traversal_type", entity.traversestartnode.animscript);
    if (isdefined(entity.traversestartnode.animscript)) {
        if (entity namespace_c96301ee::function_33361523()) {
            switch (entity.traversestartnode.animscript) {
            case "jump_down_36":
                entity clientfield::set("margwa_jaw", 21);
                break;
            case "jump_down_96":
                entity clientfield::set("margwa_jaw", 22);
                break;
            case "jump_up_36":
                entity clientfield::set("margwa_jaw", 24);
                break;
            case "jump_up_96":
                entity clientfield::set("margwa_jaw", 25);
                break;
            }
        }
    }
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x84b64ec8, Offset: 0x2880
// Size: 0x154
function private margwaTeleportInStart(entity) {
    entity unlink();
    if (isdefined(entity.var_16410986)) {
        entity forceteleport(entity.var_16410986);
    }
    entity show();
    entity pathmode("move allowed");
    entity.var_b830cb9 = 0;
    blackboard::setblackboardattribute(self, "_margwa_teleport", "in");
    if (isdefined(self.var_58ce2260)) {
        self.var_58ce2260 clientfield::set("margwa_fx_travel", 0);
    }
    self clientfield::increment("margwa_fx_in", 1);
    if (entity namespace_c96301ee::function_33361523()) {
        entity clientfield::set("margwa_jaw", 17);
    }
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x0
// Checksum 0xb1cfcfc2, Offset: 0x29e0
// Size: 0x4c
function margwaTeleportInTerminate(entity) {
    if (isdefined(self.var_58ce2260)) {
        self.var_58ce2260 clientfield::set("margwa_fx_travel", 0);
    }
    entity.isteleporting = 0;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x646d917e, Offset: 0x2a38
// Size: 0xcc
function private margwaTeleportOutStart(entity) {
    entity.var_3993b370 = 0;
    entity.isteleporting = 1;
    entity.var_e9eccbbc = entity.origin;
    blackboard::setblackboardattribute(self, "_margwa_teleport", "out");
    self clientfield::increment("margwa_fx_out", 1);
    if (entity namespace_c96301ee::function_33361523()) {
        entity clientfield::set("margwa_jaw", 18);
    }
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x70776916, Offset: 0x2b10
// Size: 0x134
function private margwaTeleportOutTerminate(entity) {
    if (isdefined(entity.var_58ce2260)) {
        entity.var_58ce2260.origin = entity gettagorigin("j_spine_1");
        entity.var_58ce2260 clientfield::set("margwa_fx_travel", 1);
    }
    entity ghost();
    entity pathmode("dont move");
    if (isdefined(entity.var_58ce2260)) {
        entity linkto(entity.var_58ce2260);
    }
    if (isdefined(entity.var_11ba7521)) {
        entity thread [[ entity.var_11ba7521 ]]();
        return;
    }
    entity thread namespace_c96301ee::function_11ba7521();
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x1dd691be, Offset: 0x2c50
// Size: 0x12c
function private margwapainstart(entity) {
    entity notify(#"hash_a78415a");
    if (entity namespace_c96301ee::function_33361523()) {
        head = blackboard::getblackboardattribute(self, "_margwa_head");
        switch (head) {
        case "left":
            entity clientfield::set("margwa_jaw", 3);
            break;
        case "middle":
            entity clientfield::set("margwa_jaw", 4);
            break;
        case "right":
            entity clientfield::set("margwa_jaw", 5);
            break;
        }
    }
    entity.headdestroyed = undefined;
    entity.var_894f701d = 0;
    entity.candamage = 0;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x13fc1942, Offset: 0x2d88
// Size: 0xa0
function private margwapainterminate(entity) {
    entity.headdestroyed = undefined;
    entity.var_894f701d = 1;
    entity.candamage = 1;
    entity namespace_c96301ee::function_b09c53b4(5000);
    entity clearpath();
    if (isdefined(entity.var_d53ee8d8)) {
        entity [[ entity.var_d53ee8d8 ]]();
    }
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0xe29ed658, Offset: 0x2e30
// Size: 0x64
function private margwareactstunstart(entity) {
    entity.var_9e59b56e = undefined;
    entity.var_894f701d = 0;
    if (entity namespace_c96301ee::function_33361523()) {
        entity clientfield::set("margwa_jaw", 6);
    }
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x0
// Checksum 0x567ed9e2, Offset: 0x2ea0
// Size: 0x20
function margwareactstunterminate(entity) {
    entity.var_894f701d = 1;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x6ea2d157, Offset: 0x2ec8
// Size: 0x13c
function private margwaReactIDGunStart(entity) {
    entity.var_843f1731 = undefined;
    entity.var_894f701d = 0;
    var_15006cdd = 0;
    if (blackboard::getblackboardattribute(entity, "_zombie_damageweapon_type") == "regular") {
        if (entity namespace_c96301ee::function_33361523()) {
            entity clientfield::set("margwa_jaw", 8);
        }
        entity namespace_c96301ee::function_b09c53b4(5000);
    } else {
        if (entity namespace_c96301ee::function_33361523()) {
            entity clientfield::set("margwa_jaw", 9);
        }
        entity namespace_c96301ee::function_b09c53b4(10000);
        var_15006cdd = 1;
    }
    if (isdefined(entity.var_afb57718)) {
        entity [[ entity.var_afb57718 ]](var_15006cdd);
    }
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x0
// Checksum 0x417f8cef, Offset: 0x3010
// Size: 0x44
function margwaReactIDGunTerminate(entity) {
    entity.var_894f701d = 1;
    blackboard::setblackboardattribute(entity, "_zombie_damageweapon_type", "regular");
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0xb22073ae, Offset: 0x3060
// Size: 0x58
function private margwaReactSwordStart(entity) {
    entity.var_70e85a9d = undefined;
    entity.var_894f701d = 0;
    if (isdefined(entity.var_337c5d83)) {
        entity.var_337c5d83 notify(#"hash_3f13116c");
    }
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0xff73c378, Offset: 0x30c0
// Size: 0x20
function private margwaReactSwordTerminate(entity) {
    entity.var_894f701d = 1;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0x38ad1a57, Offset: 0x30e8
// Size: 0x1c
function private margwaspawnstart(entity) {
    entity.var_c7ae07c2 = 0;
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0xf8f02af9, Offset: 0x3110
// Size: 0x5c
function private margwasmashattackstart(entity) {
    entity namespace_c96301ee::function_41d4a9e4();
    if (entity namespace_c96301ee::function_33361523()) {
        entity clientfield::set("margwa_jaw", 14);
    }
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x0
// Checksum 0xd562ea55, Offset: 0x3178
// Size: 0x24
function margwasmashattackterminate(entity) {
    entity namespace_c96301ee::function_b09c53b4();
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x0
// Checksum 0x37de952b, Offset: 0x31a8
// Size: 0x44
function margwaswipeattackstart(entity) {
    if (entity namespace_c96301ee::function_33361523()) {
        entity clientfield::set("margwa_jaw", 16);
    }
}

// Namespace namespace_6c6fd2b0
// Params 1, eflags: 0x4
// Checksum 0xfa0a0930, Offset: 0x31f8
// Size: 0x24
function private margwaswipeattackterminate(entity) {
    entity namespace_c96301ee::function_b09c53b4();
}

// Namespace namespace_6c6fd2b0
// Params 5, eflags: 0x4
// Checksum 0x1c7a55f3, Offset: 0x3228
// Size: 0x144
function private function_405168ca(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("normal");
    if (isdefined(entity.traverseendnode)) {
        entity.var_e9eccbbc = entity.origin;
        entity.var_16410986 = entity.traverseendnode.origin;
        self clientfield::increment("margwa_fx_out", 1);
        if (isdefined(entity.traversestartnode)) {
            if (isdefined(entity.traversestartnode.speed)) {
                self.var_ea7c154 = entity.traversestartnode.speed;
            }
        }
    }
}

// Namespace namespace_6c6fd2b0
// Params 5, eflags: 0x4
// Checksum 0x44041490, Offset: 0x3378
// Size: 0x2c
function private function_95847de7(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    
}

// Namespace namespace_6c6fd2b0
// Params 5, eflags: 0x4
// Checksum 0x897d052c, Offset: 0x33b0
// Size: 0x44
function private function_8bdd20c9(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    margwaTeleportOutTerminate(entity);
}

#namespace namespace_c96301ee;

// Namespace namespace_c96301ee
// Params 0, eflags: 0x4
// Checksum 0x99d9deb3, Offset: 0x3400
// Size: 0x224
function private function_eac87e92() {
    self disableaimassist();
    self.disableammodrop = 1;
    self.no_gib = 1;
    self.ignore_nuke = 1;
    self.ignore_enemy_count = 1;
    self.var_833cfbae = 1;
    self.zombie_move_speed = "walk";
    self.overrideactordamage = &function_b59ae4e9;
    self.candamage = 1;
    self.var_a0c7c5f = 3;
    self.var_4e09343b = 0;
    self function_ba853eca("c_zom_margwa_chunks_le", "j_chunk_head_bone_le");
    self function_ba853eca("c_zom_margwa_chunks_mid", "j_chunk_head_bone");
    self function_ba853eca("c_zom_margwa_chunks_ri", "j_chunk_head_bone_ri");
    self.var_b77c9d35 = 600;
    self function_69913a5a();
    self.var_58ce2260 = spawn("script_model", self.origin);
    self.var_58ce2260 setmodel("tag_origin");
    self.var_58ce2260 notsolid();
    self.var_6a46ac61 = spawn("script_model", self.origin);
    self.var_6a46ac61 setmodel("tag_origin");
    self.var_6a46ac61 notsolid();
    self thread function_cbfbf8ac();
    self.updatesight = 0;
    self.ignorerunandgundist = 1;
}

// Namespace namespace_c96301ee
// Params 0, eflags: 0x4
// Checksum 0x10d7870e, Offset: 0x3630
// Size: 0x7c
function private function_cbfbf8ac() {
    self waittill(#"death");
    if (isdefined(self.var_9e9a84fb)) {
        self.var_9e9a84fb notify(#"margwa_kill");
    }
    if (isdefined(self.var_58ce2260)) {
        self.var_58ce2260 delete();
    }
    if (isdefined(self.var_6a46ac61)) {
        self.var_6a46ac61 delete();
    }
}

// Namespace namespace_c96301ee
// Params 0, eflags: 0x0
// Checksum 0x7bfcd1cf, Offset: 0x36b8
// Size: 0x10
function function_21573f43() {
    self.var_894f701d = 1;
}

// Namespace namespace_c96301ee
// Params 0, eflags: 0x4
// Checksum 0xe1852a59, Offset: 0x36d0
// Size: 0x10
function private function_69913a5a() {
    self.var_894f701d = 0;
}

// Namespace namespace_c96301ee
// Params 2, eflags: 0x4
// Checksum 0x4f6311e4, Offset: 0x36e8
// Size: 0x454
function private function_ba853eca(headmodel, var_edc01299) {
    model = headmodel;
    var_23a2fd22 = undefined;
    switch (headmodel) {
    case "c_zom_margwa_chunks_le":
        if (isdefined(level.var_2c028bba)) {
            model = level.var_2c028bba;
            var_23a2fd22 = level.var_4182a531;
        }
        break;
    case "c_zom_margwa_chunks_mid":
        if (isdefined(level.var_72374095)) {
            model = level.var_72374095;
            var_23a2fd22 = level.var_7ff16e00;
        }
        break;
    case "c_zom_margwa_chunks_ri":
        if (isdefined(level.var_c9a18bd)) {
            model = level.var_c9a18bd;
            var_23a2fd22 = level.var_b9c5d5f0;
        }
        break;
    }
    self attach(model);
    if (!isdefined(self.head)) {
        self.head = [];
    }
    self.head[model] = spawnstruct();
    self.head[model].model = model;
    self.head[model].tag = var_edc01299;
    self.head[model].health = 600;
    self.head[model].candamage = 0;
    self.head[model].open = 1;
    self.head[model].closed = 2;
    self.head[model].smash = 3;
    switch (headmodel) {
    case "c_zom_margwa_chunks_le":
        self.head[model].cf = "margwa_head_left";
        self.head[model].var_92dc0464 = "margwa_head_left_hit";
        self.head[model].gore = "c_zom_margwa_gore_le";
        if (isdefined(var_23a2fd22)) {
            self.head[model].gore = var_23a2fd22;
        }
        self.head[model].var_ac197c3f = 1;
        self.var_5e150e0b = model;
        break;
    case "c_zom_margwa_chunks_mid":
        self.head[model].cf = "margwa_head_mid";
        self.head[model].var_92dc0464 = "margwa_head_mid_hit";
        self.head[model].gore = "c_zom_margwa_gore_mid";
        if (isdefined(var_23a2fd22)) {
            self.head[model].gore = var_23a2fd22;
        }
        self.head[model].var_ac197c3f = 2;
        self.var_170dfeda = model;
        break;
    case "c_zom_margwa_chunks_ri":
        self.head[model].cf = "margwa_head_right";
        self.head[model].var_92dc0464 = "margwa_head_right_hit";
        self.head[model].gore = "c_zom_margwa_gore_ri";
        if (isdefined(var_23a2fd22)) {
            self.head[model].gore = var_23a2fd22;
        }
        self.head[model].var_ac197c3f = 3;
        self.var_b406e5f2 = model;
        break;
    }
    self thread function_6d2d2ad3(self.head[model]);
}

// Namespace namespace_c96301ee
// Params 1, eflags: 0x0
// Checksum 0x91582e3a, Offset: 0x3b48
// Size: 0x9a
function function_53ce09a(health) {
    self.var_b77c9d35 = health;
    foreach (head in self.head) {
        head.health = health;
    }
}

// Namespace namespace_c96301ee
// Params 2, eflags: 0x4
// Checksum 0xee2c76d4, Offset: 0x3bf0
// Size: 0x46
function private function_cd7a8132(min, max) {
    time = gettime() + randomintrange(min, max);
    return time;
}

// Namespace namespace_c96301ee
// Params 0, eflags: 0x4
// Checksum 0xa2c54f6b, Offset: 0x3c40
// Size: 0x40
function private function_a509fa6e() {
    if (self.var_a0c7c5f > 1) {
        if (self.var_4e09343b < self.var_a0c7c5f - 1) {
            return true;
        }
    } else {
        return true;
    }
    return false;
}

// Namespace namespace_c96301ee
// Params 1, eflags: 0x4
// Checksum 0x81d78407, Offset: 0x3c88
// Size: 0x298
function private function_6d2d2ad3(headinfo) {
    self endon(#"death");
    self endon(#"hash_a78415a");
    headinfo notify(#"hash_a78415a");
    headinfo endon(#"hash_a78415a");
    while (true) {
        if (self ispaused()) {
            util::wait_network_frame();
            continue;
        }
        if (!isdefined(headinfo.closetime)) {
            if (self.var_a0c7c5f == 1) {
                headinfo.closetime = function_cd7a8132(500, 1000);
            } else {
                headinfo.closetime = function_cd7a8132(1500, 3500);
            }
        }
        if (gettime() > headinfo.closetime && self function_a509fa6e()) {
            self.var_4e09343b++;
            headinfo.closetime = undefined;
        } else {
            util::wait_network_frame();
            continue;
        }
        self function_78a5758c(headinfo, 1);
        self clientfield::set(headinfo.cf, headinfo.open);
        self playsoundontag("zmb_vocals_margwa_ambient", headinfo.tag);
        while (true) {
            if (!isdefined(headinfo.opentime)) {
                headinfo.opentime = function_cd7a8132(3000, 5000);
            }
            if (gettime() > headinfo.opentime) {
                self.var_4e09343b--;
                headinfo.opentime = undefined;
                break;
            }
            util::wait_network_frame();
            continue;
        }
        self function_78a5758c(headinfo, 0);
        self clientfield::set(headinfo.cf, headinfo.closed);
    }
}

// Namespace namespace_c96301ee
// Params 2, eflags: 0x4
// Checksum 0xcb063ec9, Offset: 0x3f28
// Size: 0x3c
function private function_78a5758c(headinfo, candamage) {
    self endon(#"death");
    wait 0.1;
    headinfo.candamage = candamage;
}

// Namespace namespace_c96301ee
// Params 0, eflags: 0x4
// Checksum 0x94918c5c, Offset: 0x3f70
// Size: 0x1c2
function private function_41d4a9e4() {
    self notify(#"hash_a78415a");
    var_b5497362 = [];
    foreach (head in self.head) {
        if (head.health > 0) {
            var_b5497362[var_b5497362.size] = head;
        }
    }
    var_b5497362 = array::randomize(var_b5497362);
    open = 0;
    foreach (head in var_b5497362) {
        if (!open) {
            head.candamage = 1;
            self clientfield::set(head.cf, head.smash);
            open = 1;
            continue;
        }
        self function_5adc4b54(head);
    }
}

// Namespace namespace_c96301ee
// Params 1, eflags: 0x4
// Checksum 0xeba348fd, Offset: 0x4140
// Size: 0x4c
function private function_5adc4b54(headinfo) {
    headinfo.candamage = 0;
    self clientfield::set(headinfo.cf, headinfo.closed);
}

// Namespace namespace_c96301ee
// Params 1, eflags: 0x4
// Checksum 0x51f32313, Offset: 0x4198
// Size: 0x122
function private function_b09c53b4(closetime) {
    if (self ispaused()) {
        return;
    }
    foreach (head in self.head) {
        if (head.health > 0) {
            head.closetime = undefined;
            head.opentime = undefined;
            if (isdefined(closetime)) {
                head.closetime = gettime() + closetime;
            }
            self.var_4e09343b = 0;
            self function_5adc4b54(head);
            self thread function_6d2d2ad3(head);
        }
    }
}

// Namespace namespace_c96301ee
// Params 2, eflags: 0x0
// Checksum 0xb02e33be, Offset: 0x42c8
// Size: 0x17a
function function_a614f89c(var_9c967ca3, attacker) {
    headinfo = self.head[var_9c967ca3];
    headinfo.health = 0;
    headinfo notify(#"hash_a78415a");
    if (isdefined(headinfo.candamage) && headinfo.candamage) {
        self function_5adc4b54(headinfo);
        self.var_4e09343b--;
    }
    self function_3133a8cb();
    if (isdefined(self.var_bad584d0)) {
        self thread [[ self.var_bad584d0 ]](var_9c967ca3, attacker);
    }
    self clientfield::set("margwa_head_killed", headinfo.var_ac197c3f);
    self detach(headinfo.model);
    self attach(headinfo.gore);
    self.var_a0c7c5f--;
    if (self.var_a0c7c5f <= 0) {
        self.var_9e9a84fb = attacker;
        return true;
    } else {
        self.headdestroyed = var_9c967ca3;
    }
    return false;
}

// Namespace namespace_c96301ee
// Params 0, eflags: 0x0
// Checksum 0x43563241, Offset: 0x4450
// Size: 0xc0
function function_6fb4c3f9() {
    foreach (head in self.head) {
        if (isdefined(head.candamage) && isdefined(head) && head.health > 0 && head.candamage) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_c96301ee
// Params 0, eflags: 0x0
// Checksum 0x2167a7ed, Offset: 0x4518
// Size: 0x3a
function function_d7d05b41() {
    if (isdefined(self.candamage) && isdefined(self) && self.health > 0 && self.candamage) {
        return true;
    }
    return false;
}

// Namespace namespace_c96301ee
// Params 0, eflags: 0x0
// Checksum 0x7d7d2633, Offset: 0x4560
// Size: 0x88
function show_hit_marker() {
    if (isdefined(self) && isdefined(self.hud_damagefeedback)) {
        self.hud_damagefeedback setshader("damage_feedback", 24, 48);
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
    }
}

// Namespace namespace_c96301ee
// Params 1, eflags: 0x4
// Checksum 0x9e36f596, Offset: 0x45f0
// Size: 0xee
function private function_be30bd79(weapon) {
    foreach (var_86814471 in level.var_dbb10dd8) {
        if (weapon.name == var_86814471) {
            return true;
        }
        if (isdefined(weapon.rootweapon) && isdefined(weapon.rootweapon.name) && weapon.rootweapon.name == var_86814471) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_c96301ee
// Params 12, eflags: 0x0
// Checksum 0xd0e1889d, Offset: 0x46e8
// Size: 0x67c
function function_b59ae4e9(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (isdefined(self.var_522f1d1c) && self.var_522f1d1c) {
        return damage;
    }
    if (isdefined(attacker) && isdefined(attacker.var_13804b27)) {
        damage *= attacker.var_13804b27;
    }
    if (isdefined(level.var_9b5d7667)) {
        n_result = [[ level.var_9b5d7667 ]](inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
        if (isdefined(n_result)) {
            return n_result;
        }
    }
    var_40fbf63a = 0;
    if (!(isdefined(self.candamage) && self.candamage)) {
        self.health += 1;
        return 1;
    }
    if (function_be30bd79(weapon)) {
        var_b5497362 = [];
        foreach (head in self.head) {
            if (head function_d7d05b41()) {
                var_b5497362[var_b5497362.size] = head;
            }
        }
        if (var_b5497362.size > 0) {
            max = 100000;
            var_817400d4 = undefined;
            foreach (head in var_b5497362) {
                distsq = distancesquared(point, self gettagorigin(head.tag));
                if (distsq < max) {
                    max = distsq;
                    var_817400d4 = head;
                }
            }
            if (isdefined(var_817400d4)) {
                if (max < 576) {
                    if (isdefined(level.var_73978b41) && isfunctionptr(level.var_73978b41)) {
                        damage = attacker [[ level.var_73978b41 ]](damage);
                    }
                    var_817400d4.health -= damage;
                    var_40fbf63a = 1;
                    self clientfield::increment(var_817400d4.var_92dc0464);
                    attacker show_hit_marker();
                    if (var_817400d4.health <= 0) {
                        if (isdefined(level.var_64a92274)) {
                            [[ level.var_64a92274 ]](self, weapon);
                        }
                        if (self function_a614f89c(var_817400d4.model, attacker)) {
                            return self.health;
                        }
                    }
                }
            }
        }
    }
    partname = getpartname(self.model, boneindex);
    if (isdefined(partname)) {
        /#
            if (isdefined(self.var_c5dc6229) && self.var_c5dc6229) {
                printtoprightln(partname + "<dev string:x7f>" + damage);
            }
        #/
        var_9c967ca3 = self function_db2d5def(self, partname);
        if (isdefined(var_9c967ca3)) {
            headinfo = self.head[var_9c967ca3];
            if (headinfo function_d7d05b41()) {
                if (isdefined(level.var_73978b41) && isfunctionptr(level.var_73978b41)) {
                    damage = attacker [[ level.var_73978b41 ]](damage);
                }
                if (isdefined(attacker)) {
                    attacker notify(#"margwa_headshot", self);
                }
                headinfo.health -= damage;
                var_40fbf63a = 1;
                self clientfield::increment(headinfo.var_92dc0464);
                attacker show_hit_marker();
                if (headinfo.health <= 0) {
                    if (isdefined(level.var_64a92274)) {
                        [[ level.var_64a92274 ]](self, weapon);
                    }
                    if (self function_a614f89c(var_9c967ca3, attacker)) {
                        return self.health;
                    }
                }
            }
        }
    }
    if (var_40fbf63a) {
        return 0;
    }
    self.health += 1;
    return 1;
}

// Namespace namespace_c96301ee
// Params 2, eflags: 0x4
// Checksum 0x5a7e92a6, Offset: 0x4d70
// Size: 0x70
function private function_db2d5def(entity, partname) {
    switch (partname) {
    case "j_chunk_head_bone_le":
    case "j_jaw_lower_1_le":
        return self.var_5e150e0b;
    case "j_chunk_head_bone":
    case "j_jaw_lower_1":
        return self.var_170dfeda;
    case "j_chunk_head_bone_ri":
    case "j_jaw_lower_1_ri":
        return self.var_b406e5f2;
    }
    return undefined;
}

// Namespace namespace_c96301ee
// Params 0, eflags: 0x4
// Checksum 0x5c02a521, Offset: 0x4de8
// Size: 0x9c
function private function_3133a8cb() {
    if (self.zombie_move_speed == "walk") {
        self.zombie_move_speed = "run";
        blackboard::setblackboardattribute(self, "_locomotion_speed", "locomotion_speed_run");
        return;
    }
    if (self.zombie_move_speed == "run") {
        self.zombie_move_speed = "sprint";
        blackboard::setblackboardattribute(self, "_locomotion_speed", "locomotion_speed_sprint");
    }
}

// Namespace namespace_c96301ee
// Params 0, eflags: 0x0
// Checksum 0x98cbb6ab, Offset: 0x4e90
// Size: 0x3c
function function_8869a77() {
    self.zombie_move_speed = "sprint";
    blackboard::setblackboardattribute(self, "_locomotion_speed", "locomotion_speed_sprint");
}

// Namespace namespace_c96301ee
// Params 1, eflags: 0x4
// Checksum 0xa69a2999, Offset: 0x4ed8
// Size: 0xc
function private function_d357cdce(var_9c967ca3) {
    
}

// Namespace namespace_c96301ee
// Params 0, eflags: 0x0
// Checksum 0x2eac2fc5, Offset: 0x4ef0
// Size: 0x38
function function_33361523() {
    if (!(isdefined(self.var_25094731) && self.var_25094731)) {
        return false;
    }
    if (self.var_a0c7c5f < 3) {
        return true;
    }
    return false;
}

// Namespace namespace_c96301ee
// Params 3, eflags: 0x0
// Checksum 0x47b9066c, Offset: 0x4f30
// Size: 0x8e
function function_30c7c3d3(origin, radius, var_bfc672df) {
    pos = getclosestpointonnavmesh(origin, 64, 30);
    if (isdefined(pos)) {
        self setgoal(pos);
        return true;
    }
    self setgoal(self.origin);
    return false;
}

// Namespace namespace_c96301ee
// Params 0, eflags: 0x4
// Checksum 0x35d62b4d, Offset: 0x4fc8
// Size: 0x18a
function private function_11ba7521() {
    self endon(#"death");
    self.waiting = 1;
    self.var_b830cb9 = 1;
    destpos = self.var_16410986 + (0, 0, 60);
    dist = distance(self.var_e9eccbbc, destpos);
    time = dist / 600;
    if (isdefined(self.var_ea7c154)) {
        if (self.var_ea7c154 > 0) {
            time = dist / self.var_ea7c154;
        }
    }
    if (isdefined(self.var_58ce2260)) {
        self thread function_e9c9b15b();
        self.var_58ce2260 moveto(destpos, time);
        self.var_58ce2260 util::function_183e3618(time + 0.1, "movedone", self, "death");
        self.var_6a46ac61 clientfield::set("margwa_fx_travel_tell", 0);
    }
    self.waiting = 0;
    self.var_3993b370 = 0;
    if (isdefined(self.var_ea7c154)) {
        self.var_ea7c154 = undefined;
    }
}

// Namespace namespace_c96301ee
// Params 0, eflags: 0x0
// Checksum 0x7feb04f2, Offset: 0x5160
// Size: 0x64
function function_e9c9b15b() {
    self endon(#"death");
    self.var_6a46ac61.origin = self.var_16410986;
    util::wait_network_frame();
    self.var_6a46ac61 clientfield::set("margwa_fx_travel_tell", 1);
}

// Namespace namespace_c96301ee
// Params 3, eflags: 0x4
// Checksum 0x241b8c09, Offset: 0x51d0
// Size: 0x162
function private function_2edfc800(vdir, limit, front) {
    if (!isdefined(front)) {
        front = 1;
    }
    orientation = self getplayerangles();
    forwardvec = anglestoforward(orientation);
    if (!front) {
        forwardvec *= -1;
    }
    forwardvec2d = (forwardvec[0], forwardvec[1], 0);
    unitforwardvec2d = vectornormalize(forwardvec2d);
    tofaceevec = vdir * -1;
    tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
    unittofaceevec2d = vectornormalize(tofaceevec2d);
    dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
    return dotproduct > limit;
}

// Namespace namespace_c96301ee
// Params 1, eflags: 0x4
// Checksum 0x63151c0a, Offset: 0x5340
// Size: 0xc8
function private function_4e77203(enemy) {
    var_c06eca13 = self.origin;
    heightoffset = abs(self.origin[2] - enemy.origin[2]);
    if (heightoffset > 48) {
        return false;
    }
    distsq = distancesquared(var_c06eca13, enemy.origin);
    range = 25600;
    if (distsq < range) {
        return true;
    }
    return false;
}

