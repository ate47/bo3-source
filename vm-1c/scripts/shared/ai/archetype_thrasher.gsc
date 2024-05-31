#using scripts/shared/weapons/_weaponobjects;
#using scripts/shared/ai/archetype_thrasher_interface;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_dffbdcc8;

// Namespace namespace_dffbdcc8
// Params 0, eflags: 0x2
// Checksum 0x29456890, Offset: 0x9a0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("thrasher", &__init__, undefined, undefined);
}

// Namespace namespace_dffbdcc8
// Params 0, eflags: 0x1 linked
// Checksum 0xe5a1dc12, Offset: 0x9e0
// Size: 0x24c
function __init__() {
    visionset_mgr::register_info("visionset", "zm_isl_thrasher_stomach_visionset", 9000, 30, 16, 1, &visionset_mgr::ramp_in_thread_per_player, 0);
    function_d83c7355();
    spawner::add_archetype_spawn_function("thrasher", &function_66ddd4b8);
    spawner::add_archetype_spawn_function("thrasher", &function_44ca600a);
    if (ai::shouldregisterclientfieldforarchetype("thrasher")) {
        clientfield::register("actor", "thrasher_spore_state", 5000, 3, "int");
        clientfield::register("actor", "thrasher_berserk_state", 5000, 1, "int");
        clientfield::register("actor", "thrasher_player_hide", 8000, 4, "int");
        clientfield::register("toplayer", "sndPlayerConsumed", 10000, 1, "int");
        foreach (spore in array(1, 2, 4)) {
            clientfield::register("actor", "thrasher_spore_impact" + spore, 8000, 1, "counter");
        }
    }
    namespace_66565bbf::function_347a8745();
}

// Namespace namespace_dffbdcc8
// Params 0, eflags: 0x5 linked
// Checksum 0xd3f9fa18, Offset: 0xc38
// Size: 0x374
function private function_d83c7355() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherRageService", &function_db7ff69e);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherTargetService", &function_bc6753c6);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherKnockdownService", &function_e4c4feab);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherAttackableObjectService", &function_57d6d5c4);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherShouldBeStunned", &function_b4e95fd);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherShouldMelee", &function_4fdbf15);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherShouldShowPain", &function_56b22ed8);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherShouldTurnBerserk", &function_3d0c02cc);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherShouldTeleport", &function_ab95703e);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherShouldConsumePlayer", &function_3bcfda18);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherShouldConsumeZombie", &function_fdcdd8a5);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherConsumePlayer", &function_f8c0f4f7);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherConsumeZombie", &function_394b19ee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherPlayedBerserkIntro", &namespace_5d6075c6::function_2284c497);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherTeleport", &namespace_5d6075c6::function_28290043);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherTeleportOut", &namespace_5d6075c6::function_3e5b31b1);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherDeath", &function_506069f4);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherStartTraverse", &namespace_5d6075c6::function_87d9384);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherTerminateTraverse", &namespace_5d6075c6::function_69ba668d);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherStunInitialize", &namespace_5d6075c6::function_32c6ffcc);
    behaviortreenetworkutility::registerbehaviortreescriptapi("thrasherStunUpdate", &namespace_5d6075c6::function_1d49555);
    animationstatenetwork::registernotetrackhandlerfunction("thrasher_melee", &function_cb3596fd);
}

// Namespace namespace_dffbdcc8
// Params 0, eflags: 0x5 linked
// Checksum 0x678177c, Offset: 0xfb8
// Size: 0x1ec
function private function_66ddd4b8() {
    entity = self;
    blackboard::createblackboardforentity(entity);
    entity aiutility::function_89e1fc16();
    ai::createinterfaceforentity(entity);
    var_93da56da = "locomotion_speed_walk";
    if (entity.var_5b105946 === 1) {
        var_93da56da = "locomotion_speed_run";
    }
    blackboard::registerblackboardattribute(self, "_locomotion_speed", var_93da56da, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("sndPlayerConsumed");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_should_turn", "should_not_turn", &bb_getshouldturn);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("sndPlayerConsumed");
        #/
    }
    blackboard::registerblackboardattribute(self, "_zombie_damageweapon_type", "regular", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("sndPlayerConsumed");
        #/
    }
    entity.___archetypeonanimscriptedcallback = &function_5215214e;
    /#
        entity finalizetrackedblackboardattributes();
    #/
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0x87e960e4, Offset: 0x11b0
// Size: 0x34
function private function_5215214e(entity) {
    entity.__blackboard = undefined;
    entity function_66ddd4b8();
}

// Namespace namespace_dffbdcc8
// Params 0, eflags: 0x5 linked
// Checksum 0xf825ea8, Offset: 0x11f0
// Size: 0x164
function private function_44ca600a() {
    entity = self;
    entity.health = 1000;
    entity.maxhealth = entity.health;
    entity.var_9aee6feb = 0;
    entity.var_5fedb470 = 0;
    entity.var_5b105946 = 0;
    entity.var_3c98f9fa = 10;
    entity.var_47093284 = gettime();
    entity.var_e557ea9b = 3000;
    entity.var_a54844b5 = 0;
    entity.var_3a60f862 = 2;
    entity.var_1cb6b10c = gettime();
    entity.var_ef0082a4 = 3000;
    entity.var_1bb31a5a = 0;
    entity.var_e1f82635 = 1;
    function_a035ff2a();
    namespace_5d6075c6::function_7c8ed1a3(entity, 1);
    aiutility::addaioverridedamagecallback(entity, &namespace_5d6075c6::function_55ee3ac);
}

// Namespace namespace_dffbdcc8
// Params 0, eflags: 0x5 linked
// Checksum 0xe46124ef, Offset: 0x1360
// Size: 0x4a
function private bb_getshouldturn() {
    entity = self;
    if (isdefined(entity.should_turn) && entity.should_turn) {
        return "should_turn";
    }
    return "should_not_turn";
}

// Namespace namespace_dffbdcc8
// Params 0, eflags: 0x5 linked
// Checksum 0x8127ba64, Offset: 0x13b8
// Size: 0x218
function private function_a035ff2a() {
    entity = self;
    assert(array("sndPlayerConsumed", "sndPlayerConsumed", "sndPlayerConsumed").size == array(1, 2, 4).size);
    var_64d28ed0 = array("tag_spore_chest", "tag_spore_back", "tag_spore_leg");
    var_8df8cc2d = array(12, 18, 12);
    var_5a5190cc = array(1, 2, 4);
    entity.var_64d28ed0 = [];
    for (index = 0; index < array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size; index++) {
        var_2e98e037 = spawnstruct();
        var_2e98e037.dist = var_8df8cc2d[index];
        var_2e98e037.health = 100;
        var_2e98e037.maxhealth = var_2e98e037.health;
        var_2e98e037.state = "state_healthly";
        var_2e98e037.tag = var_64d28ed0[index];
        var_2e98e037.clientfield = var_5a5190cc[index];
        entity.var_64d28ed0[index] = var_2e98e037;
    }
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0xe71fad1, Offset: 0x15d8
// Size: 0xd4
function private function_cb3596fd(entity) {
    if (isdefined(entity.var_f92f6f15)) {
        entity thread [[ entity.var_f92f6f15 ]]();
    }
    hitentity = entity melee();
    if (isdefined(hitentity) && isdefined(entity.var_362e85a0)) {
        entity thread [[ entity.var_362e85a0 ]](hitentity);
    }
    if (aiutility::shouldattackobject(entity)) {
        if (isdefined(level.attackablecallback)) {
            entity.attackable [[ level.attackablecallback ]](entity);
        }
    }
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0xf48c2413, Offset: 0x16b8
// Size: 0x212
function private function_62caf126(entity) {
    if (entity.var_9aee6feb) {
        return;
    }
    var_3883bfd8 = 2400 * 2400;
    targets = getplayers();
    if (targets.size == 1) {
        return;
    }
    var_34fe11d7 = [];
    foreach (target in targets) {
        if (!isdefined(target.laststandstarttime) || target.laststandstarttime + 5000 > gettime()) {
            continue;
        }
        if (isdefined(target.var_cfcc93c3) && target.var_cfcc93c3 + 10000 > gettime()) {
            continue;
        }
        if (target laststand::player_is_in_laststand() && !(isdefined(target.var_9d35623c) && target.var_9d35623c) && distancesquared(target.origin, entity.origin) <= var_3883bfd8) {
            var_34fe11d7[var_34fe11d7.size] = target;
        }
    }
    if (var_34fe11d7.size > 0) {
        sortedpotentialtargets = arraysortclosest(var_34fe11d7, entity.origin);
        return sortedpotentialtargets[0];
    }
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0xdf486965, Offset: 0x18d8
// Size: 0x74
function private function_db7ff69e(entity) {
    entity.var_1bb31a5a += entity.var_e1f82635 * 1 + 1;
    if (entity.var_1bb31a5a >= -56) {
        namespace_5d6075c6::function_6c2bbf66(entity);
    }
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0x1302c530, Offset: 0x1958
// Size: 0x428
function private function_bc6753c6(entity) {
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    if (entity ai::get_behavior_attribute("move_mode") == "friendly") {
        if (isdefined(entity.var_f39a7dbc)) {
            entity [[ entity.var_f39a7dbc ]]();
        }
        return 1;
    }
    var_33339d4c = function_62caf126(entity);
    if (isdefined(var_33339d4c)) {
        entity.favoriteenemy = var_33339d4c;
        entity setgoal(entity.favoriteenemy.origin);
        return 1;
    }
    entity.ignore_player = [];
    players = getplayers();
    foreach (player in players) {
        if (isdefined(player.var_9d35623c) && (player isnotarget() || player.ignoreme || player laststand::player_is_in_laststand() || player.var_9d35623c)) {
            entity.ignore_player[entity.ignore_player.size] = player;
        }
    }
    player = undefined;
    if (isdefined(entity.var_9b2031fc)) {
        player = [[ entity.var_9b2031fc ]](entity.origin, entity.ignore_player);
    } else {
        player = zombie_utility::get_closest_valid_player(entity.origin, entity.ignore_player);
    }
    entity.favoriteenemy = player;
    if (!isdefined(player) || player isnotarget()) {
        if (isdefined(entity.ignore_player)) {
            if (isdefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]()) {
                return;
            }
            entity.ignore_player = [];
        }
        entity setgoal(entity.origin);
        return 0;
    }
    if (isdefined(entity.attackable)) {
        if (isdefined(entity.attackable_slot)) {
            entity setgoal(entity.attackable_slot.origin, 1);
        }
        return;
    }
    targetpos = getclosestpointonnavmesh(player.origin, -128, 30);
    if (isdefined(targetpos)) {
        entity setgoal(targetpos);
        return 1;
    }
    entity setgoal(entity.origin);
    return 0;
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0x4cc09f9, Offset: 0x1d88
// Size: 0x3a
function private function_57d6d5c4(entity) {
    if (isdefined(entity.var_67a1573a)) {
        return [[ entity.var_67a1573a ]](entity);
    }
    return 0;
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0xf8674b3f, Offset: 0x1dd0
// Size: 0x1ba
function private function_e4c4feab(entity) {
    velocity = entity getvelocity();
    var_43502fbc = 0.3;
    predicted_pos = entity.origin + velocity * var_43502fbc;
    move_dist_sq = distancesquared(predicted_pos, entity.origin);
    speed = move_dist_sq / var_43502fbc;
    if (speed >= 10) {
        a_zombies = getaiarchetypearray("zombie");
        var_abbab1d4 = array::filter(a_zombies, 0, &function_ae899104, entity, predicted_pos);
        if (var_abbab1d4.size > 0) {
            foreach (zombie in var_abbab1d4) {
                namespace_5d6075c6::function_6f5adf20(entity, zombie);
            }
        }
    }
}

// Namespace namespace_dffbdcc8
// Params 3, eflags: 0x5 linked
// Checksum 0x1ff6c4d4, Offset: 0x1f98
// Size: 0x1ac
function private function_ae899104(zombie, thrasher, predicted_pos) {
    if (zombie.knockdown === 1) {
        return false;
    }
    var_780bea21 = 2304;
    dist_sq = distancesquared(predicted_pos, zombie.origin);
    if (dist_sq > var_780bea21) {
        return false;
    }
    origin = thrasher.origin;
    facing_vec = anglestoforward(thrasher.angles);
    enemy_vec = zombie.origin - origin;
    var_ef095088 = (enemy_vec[0], enemy_vec[1], 0);
    var_331bc04c = (facing_vec[0], facing_vec[1], 0);
    var_ef095088 = vectornormalize(var_ef095088);
    var_331bc04c = vectornormalize(var_331bc04c);
    enemy_dot = vectordot(var_331bc04c, var_ef095088);
    if (enemy_dot < 0) {
        return false;
    }
    return true;
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x1 linked
// Checksum 0x4693d96a, Offset: 0x2150
// Size: 0xee
function function_4fdbf15(entity) {
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.favoriteenemy.origin) > 9216) {
        return false;
    }
    if (entity.favoriteenemy isnotarget()) {
        return false;
    }
    yaw = abs(zombie_utility::getyawtoenemy());
    if (yaw > 60) {
        return false;
    }
    if (entity.favoriteenemy laststand::player_is_in_laststand()) {
        return false;
    }
    return true;
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0x231b7965, Offset: 0x2248
// Size: 0xe
function private function_56b22ed8(entity) {
    return false;
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0xc3065116, Offset: 0x2260
// Size: 0x2c
function private function_3d0c02cc(entity) {
    return entity.var_5fedb470 && !entity.var_5b105946;
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0xfc1b23e8, Offset: 0x2298
// Size: 0xec
function private function_ab95703e(entity) {
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    if (entity.var_1cb6b10c + 10000 > gettime()) {
        return false;
    }
    if (distancesquared(entity.origin, entity.favoriteenemy.origin) >= 1440000) {
        if (isdefined(entity.var_69262db7)) {
            return ([[ entity.var_69262db7 ]](entity.origin) && [[ entity.var_69262db7 ]](entity.favoriteenemy.origin));
        } else {
            return true;
        }
    }
    return false;
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0xbcd705a9, Offset: 0x2390
// Size: 0x124
function private function_3bcfda18(entity) {
    if (!isdefined(entity.favoriteenemy)) {
        return false;
    }
    targets = getplayers();
    if (targets.size == 1) {
        return false;
    }
    if (distancesquared(entity.origin, entity.favoriteenemy.origin) > 2304) {
        return false;
    }
    if (!entity.favoriteenemy laststand::player_is_in_laststand()) {
        return false;
    }
    if (isdefined(entity.favoriteenemy.var_9d35623c) && entity.favoriteenemy.var_9d35623c) {
        return false;
    }
    if (isdefined(entity.var_61d546f4) && !entity [[ entity.var_61d546f4 ]](entity)) {
        return false;
    }
    return true;
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0xd09001f7, Offset: 0x24c0
// Size: 0x12a
function private function_fdcdd8a5(entity) {
    if (entity.var_a54844b5 >= entity.var_3a60f862) {
        return 0;
    }
    if (entity.var_47093284 + entity.var_e557ea9b >= gettime()) {
        return 0;
    }
    var_6991ea91 = 0;
    for (index = 0; index < array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size; index++) {
        var_2e98e037 = entity.var_64d28ed0[index];
        if (var_2e98e037.health <= 0) {
            var_6991ea91 = 1;
            break;
        }
    }
    if (var_6991ea91) {
        if (isdefined(entity.var_fc6aa17)) {
            return [[ entity.var_fc6aa17 ]](entity);
        }
    }
    return 0;
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0x11dc2b78, Offset: 0x25f8
// Size: 0x54
function private function_f8c0f4f7(entity) {
    if (isplayer(entity.favoriteenemy)) {
        entity thread namespace_5d6075c6::function_aaaf7923(entity, entity.favoriteenemy);
    }
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0x1720b8f9, Offset: 0x2658
// Size: 0x24
function private function_506069f4(entity) {
    gibserverutils::annihilate(entity);
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0xb2b27cf3, Offset: 0x2688
// Size: 0x58
function private function_394b19ee(entity) {
    if (isdefined(entity.var_c1f12967)) {
        if ([[ entity.var_c1f12967 ]](entity)) {
            entity.var_a54844b5++;
            entity.var_47093284 = gettime();
        }
    }
}

// Namespace namespace_dffbdcc8
// Params 1, eflags: 0x5 linked
// Checksum 0xe89546dc, Offset: 0x26e8
// Size: 0x2a
function private function_b4e95fd(entity) {
    return entity ai::get_behavior_attribute("stunned");
}

#namespace namespace_5d6075c6;

// Namespace namespace_5d6075c6
// Params 2, eflags: 0x1 linked
// Checksum 0x99d29b4d, Offset: 0x2720
// Size: 0x2b4
function function_6f5adf20(entity, zombie) {
    zombie.knockdown = 1;
    zombie.knockdown_type = "knockdown_shoved";
    var_663c85f3 = entity.origin - zombie.origin;
    var_60c0153c = vectornormalize((var_663c85f3[0], var_663c85f3[1], 0));
    zombie_forward = anglestoforward(zombie.angles);
    zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
    zombie_right = anglestoright(zombie.angles);
    zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
    dot = vectordot(var_60c0153c, zombie_forward_2d);
    if (dot >= 0.5) {
        zombie.knockdown_direction = "front";
        zombie.getup_direction = "getup_back";
        return;
    }
    if (dot < 0.5 && dot > -0.5) {
        dot = vectordot(var_60c0153c, zombie_right_2d);
        if (dot > 0) {
            zombie.knockdown_direction = "right";
            if (math::cointoss()) {
                zombie.getup_direction = "getup_back";
            } else {
                zombie.getup_direction = "getup_belly";
            }
        } else {
            zombie.knockdown_direction = "left";
            zombie.getup_direction = "getup_belly";
        }
        return;
    }
    zombie.knockdown_direction = "back";
    zombie.getup_direction = "getup_belly";
}

// Namespace namespace_5d6075c6
// Params 1, eflags: 0x1 linked
// Checksum 0x6826ba18, Offset: 0x29e0
// Size: 0xac
function function_6c2bbf66(entity) {
    if (!entity.var_5fedb470) {
        entity thread function_5aaa10f7(2.5);
        entity.var_5fedb470 = 1;
        entity.health += 1500;
        entity clientfield::set("thrasher_berserk_state", 1);
        function_7c8ed1a3(entity, 0);
    }
}

// Namespace namespace_5d6075c6
// Params 1, eflags: 0x5 linked
// Checksum 0x1fb02543, Offset: 0x2a98
// Size: 0xc4
function private function_2284c497(entity) {
    entity.var_5b105946 = 1;
    meleeweapon = getweapon("thrasher_melee_enraged");
    entity.meleeweapon = getweapon("thrasher_melee_enraged");
    entity ai::set_behavior_attribute("stunned", 0);
    entity.var_ef0082a4 = 3000;
    blackboard::setblackboardattribute(self, "_locomotion_speed", "locomotion_speed_run");
}

// Namespace namespace_5d6075c6
// Params 12, eflags: 0x1 linked
// Checksum 0x2a04f810, Offset: 0x2b68
// Size: 0x2b4
function function_55ee3ac(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity = self;
    if (hitloc == "head" && !gibserverutils::isgibbed(entity, 8)) {
        entity.var_1bb31a5a += -56;
        entity.var_3c98f9fa -= damage;
        if (entity.var_3c98f9fa <= 0) {
            if (isdefined(attacker)) {
                attacker notify(#"hash_1526f0d7");
            }
            gibserverutils::gibhead(entity);
            function_1e849801(entity);
        }
    } else {
        entity.var_1bb31a5a += 10;
        entity.var_ef0082a4 -= damage;
        if (entity.var_ef0082a4 <= 0) {
            entity ai::set_behavior_attribute("stunned", 1);
            if (isdefined(attacker)) {
                attacker notify(#"hash_451c2882");
            }
        }
    }
    damage = function_c411135f(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
    if (entity.var_1bb31a5a >= -56) {
        function_6c2bbf66(entity);
        if (isdefined(attacker)) {
            attacker notify(#"hash_979c1edb");
        }
    }
    if (isdefined(entity.var_ba462582) && entity.var_ba462582) {
        damage = 1;
    }
    damage = int(damage);
    return damage;
}

// Namespace namespace_5d6075c6
// Params 1, eflags: 0x5 linked
// Checksum 0x87ec0de0, Offset: 0x2e28
// Size: 0x7c
function private function_5aaa10f7(n_time) {
    entity = self;
    entity endon(#"death");
    entity notify(#"hash_59b1cbf8");
    entity.var_ba462582 = 1;
    entity util::waittill_notify_or_timeout("end_invulnerability", n_time);
    entity.var_ba462582 = 0;
}

// Namespace namespace_5d6075c6
// Params 12, eflags: 0x1 linked
// Checksum 0x5d463412, Offset: 0x2eb0
// Size: 0x404
function function_c411135f(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity = self;
    assert(isdefined(entity.var_64d28ed0));
    if (!isdefined(point)) {
        return damage;
    }
    var_f18f322e = 0;
    for (index = 0; index < array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size; index++) {
        var_2e98e037 = entity.var_64d28ed0[index];
        assert(isdefined(var_2e98e037));
        if (var_2e98e037.health < 0) {
            continue;
        }
        tagorigin = entity gettagorigin(var_2e98e037.tag);
        if (isdefined(tagorigin) && distancesquared(tagorigin, point) < var_2e98e037.dist * var_2e98e037.dist) {
            entity.var_1bb31a5a += 10;
            var_2e98e037.health -= damage;
            entity clientfield::increment("thrasher_spore_impact" + var_2e98e037.clientfield);
            if (var_2e98e037.health <= 0) {
                entity hidepart(var_2e98e037.tag);
                var_2e98e037.state = "state_destroyed";
                var_f87d4480 = entity clientfield::get("thrasher_spore_state");
                var_f87d4480 |= var_2e98e037.clientfield;
                entity clientfield::set("thrasher_spore_state", var_f87d4480);
                if (isdefined(entity.var_b3800086)) {
                    entity thread [[ entity.var_b3800086 ]](tagorigin, weapon, attacker);
                }
                entity ai::set_behavior_attribute("stunned", 1);
                damage = entity.maxhealth / array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size;
            }
            /#
                recordsphere(tagorigin, var_2e98e037.dist, (1, 1, 0), "sndPlayerConsumed", entity);
            #/
        }
        if (var_2e98e037.health > 0) {
            var_f18f322e++;
        }
    }
    if (var_f18f322e == 0) {
        damage = entity.maxhealth;
    }
    return damage;
}

// Namespace namespace_5d6075c6
// Params 1, eflags: 0x5 linked
// Checksum 0x2935c7b9, Offset: 0x32c0
// Size: 0x3c
function private function_3e5b31b1(entity) {
    if (isdefined(entity.var_5622f976)) {
        entity thread [[ entity.var_5622f976 ]](entity);
    }
}

// Namespace namespace_5d6075c6
// Params 1, eflags: 0x1 linked
// Checksum 0xc024d678, Offset: 0x3308
// Size: 0x54
function function_87d9384(entity) {
    aiutility::traversesetup(entity);
    if (isdefined(entity.var_87097485)) {
        entity [[ entity.var_87097485 ]](entity);
    }
}

// Namespace namespace_5d6075c6
// Params 1, eflags: 0x1 linked
// Checksum 0xf8b7153, Offset: 0x3368
// Size: 0x3c
function function_69ba668d(entity) {
    if (isdefined(entity.var_8c38eef8)) {
        entity [[ entity.var_8c38eef8 ]](entity);
    }
}

// Namespace namespace_5d6075c6
// Params 1, eflags: 0x1 linked
// Checksum 0x5043328d, Offset: 0x33b0
// Size: 0x32c
function function_28290043(entity) {
    if (!isdefined(entity.favoriteenemy)) {
        println("sndPlayerConsumed");
        return;
    }
    points = util::positionquery_pointarray(entity.favoriteenemy.origin, -128, 256, 32, 64, entity);
    filteredpoints = [];
    var_81b7a825 = getaiarchetypearray("thrasher");
    var_95ef5d1c = -16 * -16;
    foreach (point in points) {
        valid = 1;
        foreach (thrasher in var_81b7a825) {
            if (distancesquared(point, thrasher.origin) <= var_95ef5d1c) {
                valid = 0;
                break;
            }
        }
        if (valid) {
            filteredpoints[filteredpoints.size] = point;
        }
    }
    if (isdefined(entity.var_466626c4)) {
        filteredpoints = entity [[ entity.var_466626c4 ]](filteredpoints);
    }
    var_d7cc1d23 = arraysortclosest(filteredpoints, entity.origin);
    var_61186753 = var_d7cc1d23[0];
    if (isdefined(var_61186753)) {
        v_dir = entity.favoriteenemy.origin - var_61186753;
        v_dir = vectornormalize(v_dir);
        v_angles = vectortoangles(v_dir);
        entity forceteleport(var_61186753, v_angles);
    }
    entity.var_1cb6b10c = gettime();
}

// Namespace namespace_5d6075c6
// Params 1, eflags: 0x5 linked
// Checksum 0x4e326dad, Offset: 0x36e8
// Size: 0x1c
function private function_32c6ffcc(entity) {
    entity.var_e2dee6f5 = gettime();
}

// Namespace namespace_5d6075c6
// Params 1, eflags: 0x5 linked
// Checksum 0x666e896e, Offset: 0x3710
// Size: 0x58
function private function_1d49555(entity) {
    if (entity.var_e2dee6f5 + 1000 < gettime()) {
        entity ai::set_behavior_attribute("stunned", 0);
        entity.var_ef0082a4 = 3000;
    }
}

// Namespace namespace_5d6075c6
// Params 2, eflags: 0x5 linked
// Checksum 0x8c74bc8, Offset: 0x3770
// Size: 0xde
function private function_7c8ed1a3(entity, hide) {
    for (index = 1; index <= 24; index++) {
        tag = "j_spike";
        if (index < 10) {
            tag += "0";
        }
        tag = tag + index + "_root";
        if (hide) {
            entity hidepart(tag, "", 1);
            continue;
        }
        entity showpart(tag, "", 1);
    }
}

// Namespace namespace_5d6075c6
// Params 3, eflags: 0x1 linked
// Checksum 0x9e5e9434, Offset: 0x3858
// Size: 0xe4
function function_6291f979(thrasher, player, hide) {
    entitynumber = player getentitynumber();
    var_663aa8d9 = 1 << entitynumber;
    var_64b27ecc = clientfield::get("thrasher_player_hide");
    var_f15bedd5 = var_64b27ecc;
    if (hide) {
        var_f15bedd5 = var_64b27ecc | var_663aa8d9;
    } else {
        var_f15bedd5 = var_64b27ecc & ~var_663aa8d9;
    }
    thrasher clientfield::set("thrasher_player_hide", var_f15bedd5);
}

// Namespace namespace_5d6075c6
// Params 1, eflags: 0x1 linked
// Checksum 0x27b6a563, Offset: 0x3948
// Size: 0xde
function function_1e849801(entity) {
    for (index = 0; index < array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size; index++) {
        var_2e98e037 = entity.var_64d28ed0[index];
        if (var_2e98e037.health <= 0) {
            entity hidepart(var_2e98e037.tag);
            continue;
        }
        entity showpart(var_2e98e037.tag);
    }
}

// Namespace namespace_5d6075c6
// Params 1, eflags: 0x1 linked
// Checksum 0x4d0617a0, Offset: 0x3a30
// Size: 0x194
function function_15256ff0(entity) {
    for (index = 0; index < array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size; index++) {
        var_2e98e037 = entity.var_64d28ed0[index];
        if (var_2e98e037.health <= 0) {
            var_2e98e037.health = var_2e98e037.maxhealth;
            entity.health += int(entity.maxhealth / array("tag_spore_chest", "tag_spore_back", "tag_spore_leg").size);
            var_f87d4480 = entity clientfield::get("thrasher_spore_state");
            var_f87d4480 &= ~var_2e98e037.clientfield;
            entity clientfield::set("thrasher_spore_state", var_f87d4480);
            break;
        }
    }
    function_1e849801(entity);
}

// Namespace namespace_5d6075c6
// Params 1, eflags: 0x1 linked
// Checksum 0xded70fae, Offset: 0x3bd0
// Size: 0x190
function function_3c72ff88(player) {
    clone = spawn("script_model", player.origin);
    clone.angles = player.angles;
    bodymodel = player getcharacterbodymodel();
    if (isdefined(bodymodel)) {
        clone setmodel(bodymodel);
    }
    headmodel = player getcharacterheadmodel();
    if (isdefined(headmodel) && headmodel != "tag_origin") {
        if (isdefined(clone.head)) {
            clone detach(clone.head);
        }
        clone attach(headmodel);
    }
    var_f1a3fa15 = player getcharacterhelmetmodel();
    if (isdefined(var_f1a3fa15) && headmodel != "tag_origin") {
        clone attach(var_f1a3fa15);
    }
    return clone;
}

// Namespace namespace_5d6075c6
// Params 2, eflags: 0x1 linked
// Checksum 0x95733bbd, Offset: 0x3d68
// Size: 0x44
function function_fc5c5afd(thrasher, player) {
    player endon(#"death");
    player waittill(#"hash_7d8c80e4");
    player hide();
}

// Namespace namespace_5d6075c6
// Params 1, eflags: 0x1 linked
// Checksum 0xd3ea8f13, Offset: 0x3db8
// Size: 0x3a
function function_8259f2c4(revivee) {
    if (isdefined(revivee.var_9d35623c) && revivee.var_9d35623c) {
        return false;
    }
    return true;
}

// Namespace namespace_5d6075c6
// Params 2, eflags: 0x5 linked
// Checksum 0xf65daaf4, Offset: 0x3e00
// Size: 0x74
function private function_1db90449(thrasher, playerclone) {
    thrasher endon(#"hash_d48cf67e");
    thrasher waittill(#"death");
    if (isdefined(thrasher)) {
        thrasher scene::stop("scene_zm_dlc2_thrasher_eat_player");
    }
    if (isdefined(playerclone)) {
        playerclone delete();
    }
}

// Namespace namespace_5d6075c6
// Params 2, eflags: 0x5 linked
// Checksum 0x581a335c, Offset: 0x3e80
// Size: 0xdc
function private function_cf9a26c1(thrasher, playerclone) {
    thrasher endon(#"death");
    thrasher thread function_1db90449(thrasher, playerclone);
    thrasher scene::play("scene_zm_dlc2_thrasher_eat_player", array(thrasher, playerclone));
    thrasher notify(#"hash_d48cf67e");
    targetpos = getclosestpointonnavmesh(thrasher.origin, 1024, 18);
    if (isdefined(targetpos)) {
        thrasher forceteleport(targetpos);
    }
}

// Namespace namespace_5d6075c6
// Params 2, eflags: 0x1 linked
// Checksum 0x187ac39e, Offset: 0x3f68
// Size: 0x5d4
function function_aaaf7923(thrasher, player) {
    assert(isactor(thrasher));
    assert(thrasher.archetype == "sndPlayerConsumed");
    assert(isplayer(player));
    thrasher endon(#"hash_20979ae");
    if (isdefined(player.var_9d35623c) && player.var_9d35623c) {
        return;
    }
    playerclone = function_3c72ff88(player);
    playerclone.origin = player.origin;
    playerclone.angles = player.angles;
    playerclone hide();
    thrasher.var_7e34fa53 = spawn("script_model", thrasher.origin);
    util::wait_network_frame();
    if (isdefined(player.var_9d35623c) && (!isdefined(thrasher) || player.var_9d35623c)) {
        playerclone destroy();
        return;
    }
    function_6291f979(thrasher, player, 1);
    if (isdefined(thrasher.var_e4e88c0d)) {
        [[ thrasher.var_e4e88c0d ]](thrasher, player);
    }
    if (isdefined(player.revivetrigger)) {
        player.revivetrigger setinvisibletoall();
        player.revivetrigger triggerenable(0);
    }
    player setclientuivisibilityflag("hud_visible", 0);
    player setclientuivisibilityflag("weapon_hud_visible", 0);
    player.var_9d35623c = 1;
    player.thrasher = thrasher;
    player setplayercollision(0);
    player walkunderwater(1);
    player.ignoreme = 1;
    player hideviewmodel();
    player freezecontrols(0);
    player freezecontrolsallowlook(1);
    player thread lui::screen_fade_in(10);
    player clientfield::set_to_player("sndPlayerConsumed", 1);
    visionset_mgr::activate("visionset", "zm_isl_thrasher_stomach_visionset", player, 2);
    player thread function_3a5a0044(thrasher, player);
    eyeposition = player gettagorigin("tag_eye");
    eyeoffset = abs(eyeposition[2] - player.origin[2]) + 10;
    thrasher.var_7e34fa53 linkto(thrasher, "tag_camera_thrasher", (0, 0, eyeoffset * -1 + 27));
    player playerlinkto(thrasher.var_7e34fa53, undefined, 1, 0, 0, 0, 0, 1);
    thrasher thread function_384a5701(thrasher, player);
    thrasher.var_9aee6feb = 1;
    thrasher.var_49fb81d5 = player;
    thrasher.var_1cb6b10c = gettime();
    player ghost();
    playerclone show();
    if (isdefined(playerclone)) {
        thrasher thread function_cf9a26c1(thrasher, playerclone);
        playerclone thread function_fc5c5afd(thrasher, playerclone);
        player notify(#"hash_89eb445c");
    }
    thrasher waittill(#"death");
    function_9e2a4fa2(thrasher, player);
}

// Namespace namespace_5d6075c6
// Params 2, eflags: 0x1 linked
// Checksum 0x82132d62, Offset: 0x4548
// Size: 0x6c
function function_3a5a0044(thrasher, player) {
    player endon(#"death");
    player endon(#"hash_4aa8fc8b");
    player waittill(#"bgb_revive");
    if (isdefined(player.thrasher)) {
        player.thrasher kill();
    }
}

// Namespace namespace_5d6075c6
// Params 2, eflags: 0x1 linked
// Checksum 0x6698408e, Offset: 0x45c0
// Size: 0x4b4
function function_9e2a4fa2(thrasher, player) {
    if (!isalive(player)) {
        return;
    }
    if (isdefined(thrasher.var_7e34fa53)) {
        thrasher.var_7e34fa53 unlink();
        thrasher.var_7e34fa53 delete();
    }
    if (isdefined(player.revivetrigger)) {
        player.revivetrigger setvisibletoall();
        player.revivetrigger triggerenable(1);
    }
    if (isdefined(thrasher.var_5e066a4e)) {
        [[ thrasher.var_5e066a4e ]](thrasher, player);
    }
    thrasher.var_49fb81d5 = undefined;
    player setclientuivisibilityflag("hud_visible", 1);
    player setclientuivisibilityflag("weapon_hud_visible", 1);
    player.var_cfcc93c3 = gettime();
    player setstance("prone");
    player notify(#"hash_4aa8fc8b");
    player.var_9d35623c = undefined;
    player.thrasher = undefined;
    player walkunderwater(0);
    player unlink();
    player setplayercollision(1);
    player show();
    player.ignoreme = 0;
    player showviewmodel();
    player freezecontrolsallowlook(0);
    player thread lui::screen_fade_in(2);
    player clientfield::set_to_player("sndPlayerConsumed", 0);
    visionset_mgr::deactivate("visionset", "zm_isl_thrasher_stomach_visionset", player);
    player thread function_5304fc0b();
    targetpos = getclosestpointonnavmesh(player.origin, 1024, 18);
    if (isdefined(targetpos)) {
        newposition = player.origin;
        groundposition = bullettrace(targetpos + (0, 0, -128), targetpos + (0, 0, 128), 0, player);
        if (isdefined(groundposition["position"])) {
            newposition = groundposition["position"];
        } else {
            groundposition = bullettrace(targetpos + (0, 0, -256), targetpos + (0, 0, 256), 0, player);
            if (isdefined(groundposition["position"])) {
                newposition = groundposition["position"];
            } else {
                groundposition = bullettrace(targetpos + (0, 0, -512), targetpos + (0, 0, 512), 0, player);
                if (isdefined(groundposition["position"])) {
                    newposition = groundposition["position"];
                }
            }
        }
        if (newposition[2] > player.origin[2]) {
            player.origin = newposition;
        }
    }
    thrasher notify(#"hash_20979ae");
}

// Namespace namespace_5d6075c6
// Params 0, eflags: 0x1 linked
// Checksum 0x3501fe8, Offset: 0x4a80
// Size: 0x2a
function function_5304fc0b() {
    self endon(#"death");
    self waittill(#"player_revived");
    self notify(#"hash_7afd1ce2");
}

// Namespace namespace_5d6075c6
// Params 2, eflags: 0x1 linked
// Checksum 0x1f92872f, Offset: 0x4ab8
// Size: 0x12c
function function_384a5701(thrasher, player) {
    thrasher endon(#"hash_20979ae");
    thrasher.var_49fb81d5 = undefined;
    characterindex = player.characterindex;
    if (!isdefined(characterindex)) {
        return;
    }
    characterindex = level waittill(#"bleed_out");
    if (isdefined(thrasher.var_5e066a4e)) {
        [[ thrasher.var_5e066a4e ]](thrasher, player);
    }
    if (isdefined(thrasher) && isdefined(player)) {
        function_6291f979(thrasher, player, 0);
    }
    if (isdefined(player)) {
        player showviewmodel();
        player clientfield::set_to_player("sndPlayerConsumed", 0);
        visionset_mgr::deactivate("visionset", "zm_isl_thrasher_stomach_visionset", player);
    }
}

// Namespace namespace_5d6075c6
// Params 4, eflags: 0x1 linked
// Checksum 0x10a803af, Offset: 0x4bf0
// Size: 0x70
function function_91b1c35d(entity, attribute, oldvalue, value) {
    if (value == "normal") {
        entity.team = "axis";
        return;
    }
    if (value == "friendly") {
        entity.team = "allies";
    }
}

