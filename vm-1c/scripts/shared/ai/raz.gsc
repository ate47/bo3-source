#using scripts/shared/weapons/_weaponobjects;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_behavior;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;

#namespace namespace_8f7980f6;

// Namespace namespace_8f7980f6
// Params 0, eflags: 0x2
// namespace_8f7980f6<file_0>::function_c35e6aab
// Checksum 0xc94ab4bb, Offset: 0xa60
// Size: 0x244
function autoexec init() {
    function_1e18c1b3();
    spawner::add_archetype_spawn_function("raz", &function_4e80e2d0);
    spawner::add_archetype_spawn_function("raz", &namespace_6a90a894::function_8fe3f6c8);
    clientfield::register("scriptmover", "raz_detonate_ground_torpedo", 12000, 1, "int");
    clientfield::register("scriptmover", "raz_torpedo_play_fx_on_self", 12000, 1, "int");
    clientfield::register("scriptmover", "raz_torpedo_play_trail", 12000, 1, "counter");
    clientfield::register("actor", "raz_detach_gun", 12000, 1, "int");
    clientfield::register("actor", "raz_gun_weakpoint_hit", 12000, 1, "counter");
    clientfield::register("actor", "raz_detach_helmet", 12000, 1, "int");
    clientfield::register("actor", "raz_detach_chest_armor", 12000, 1, "int");
    clientfield::register("actor", "raz_detach_l_shoulder_armor", 12000, 1, "int");
    clientfield::register("actor", "raz_detach_r_thigh_armor", 12000, 1, "int");
    clientfield::register("actor", "raz_detach_l_thigh_armor", 12000, 1, "int");
}

// Namespace namespace_8f7980f6
// Params 0, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_1e18c1b3
// Checksum 0x5b252fb7, Offset: 0xcb0
// Size: 0x2d4
function private function_1e18c1b3() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("razTargetService", &function_abcc3970);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razSprintService", &razsprintservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldMelee", &razshouldmelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldShowPain", &razshouldshowpain);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldShowSpecialPain", &razshouldshowspecialpain);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldShowShieldPain", &razshouldshowshieldpain);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldShootGroundTorpedo", &razshouldshootgroundtorpedo);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldGoBerserk", &razshouldgoberserk);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razShouldTraverseWindow", &razshouldtraversewindow);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razStartMelee", &razstartmelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razFinishMelee", &razfinishmelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razFinishGroundTorpedo", &razfinishgroundtorpedo);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razGoneBerserk", &razgoneberserk);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razStartTraverseWindow", &function_364396ba);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razFinishTraverseWindow", &function_86973c57);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razTookPain", &raztookpain);
    behaviortreenetworkutility::registerbehaviortreescriptapi("razStartDeath", &razstartdeath);
    animationstatenetwork::registernotetrackhandlerfunction("mangler_fire", &function_abc3e24);
}

// Namespace namespace_8f7980f6
// Params 0, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_4e80e2d0
// Checksum 0xb7600660, Offset: 0xf90
// Size: 0x24c
function private function_4e80e2d0() {
    blackboard::createblackboardforentity(self);
    self aiutility::function_89e1fc16();
    blackboard::registerblackboardattribute(self, "_gibbed_limbs", "none", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("actor");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_walk", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("actor");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_should_turn", "should_not_turn", &bb_getshouldturn);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("actor");
        #/
    }
    blackboard::registerblackboardattribute(self, "_zombie_damageweapon_type", "regular", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("actor");
        #/
    }
    blackboard::registerblackboardattribute(self, "_gib_location", "legs", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("actor");
        #/
    }
    self.___archetypeonanimscriptedcallback = &function_d218e3b6;
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_d218e3b6
// Checksum 0xde2514d4, Offset: 0x11e8
// Size: 0xd4
function private function_d218e3b6(entity) {
    entity.__blackboard = undefined;
    entity function_4e80e2d0();
    if (isdefined(entity.var_ece78d40) && entity.var_ece78d40) {
        entity.var_815e6068 = undefined;
        blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_sprint");
    }
    if (!(isdefined(entity.var_827ce236) && entity.var_827ce236)) {
        blackboard::setblackboardattribute(entity, "_gibbed_limbs", "right_arm");
    }
}

// Namespace namespace_8f7980f6
// Params 0, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_6da8b16c
// Checksum 0x43c0e8ac, Offset: 0x12c8
// Size: 0x2a
function private bb_getshouldturn() {
    if (isdefined(self.should_turn) && self.should_turn) {
        return "should_turn";
    }
    return "should_not_turn";
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x1 linked
// namespace_8f7980f6<file_0>::function_5eef1eb8
// Checksum 0x340080bc, Offset: 0x1300
// Size: 0x22e
function findnodesservice(behaviortreeentity) {
    node = undefined;
    behaviortreeentity.entrance_nodes = [];
    if (isdefined(behaviortreeentity.find_flesh_struct_string)) {
        if (behaviortreeentity.find_flesh_struct_string == "find_flesh") {
            return 0;
        }
        for (i = 0; i < level.exterior_goals.size; i++) {
            if (isdefined(level.exterior_goals[i].script_string) && level.exterior_goals[i].script_string == behaviortreeentity.find_flesh_struct_string) {
                node = level.exterior_goals[i];
                break;
            }
        }
        behaviortreeentity.entrance_nodes[behaviortreeentity.entrance_nodes.size] = node;
        assert(isdefined(node), "actor" + behaviortreeentity.find_flesh_struct_string + "actor");
        behaviortreeentity.first_node = node;
        behaviortreeentity.goalradius = 80;
        behaviortreeentity.mocomp_barricade_offset = getdvarint("raz_node_origin_offset", -22);
        node_origin = node.origin + anglestoforward(node.angles) * behaviortreeentity.mocomp_barricade_offset;
        behaviortreeentity setgoal(node_origin);
        if (zm_behavior::zombieisatentrance(behaviortreeentity)) {
            behaviortreeentity.got_to_entrance = 1;
        }
        return 1;
    }
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x1 linked
// namespace_8f7980f6<file_0>::function_454504bd
// Checksum 0xea70976c, Offset: 0x1538
// Size: 0x70
function shouldskipteardown(entity) {
    if (isdefined(entity.var_5d32fa1a) && entity.var_5d32fa1a) {
        return true;
    }
    if (!isdefined(entity.script_string) || entity.script_string == "find_flesh") {
        return true;
    }
    return false;
}

// Namespace namespace_8f7980f6
// Params 0, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_af55113b
// Checksum 0x2554564b, Offset: 0x15b0
// Size: 0x54
function private function_af55113b() {
    chunks = undefined;
    if (isdefined(self.first_node)) {
        chunks = zm_utility::get_non_destroyed_chunks(self.first_node, self.first_node.barrier_chunks);
    }
    return chunks;
}

// Namespace namespace_8f7980f6
// Params 2, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_9235fe6a
// Checksum 0xd82c6e29, Offset: 0x1610
// Size: 0x21e
function private function_9235fe6a(entity, var_d150e4b3) {
    if (!(isdefined(var_d150e4b3) && var_d150e4b3)) {
        entity.got_to_entrance = 0;
        entity.var_5d32fa1a = 1;
        entity forceteleport(entity.origin, entity.first_node.angles);
        chunks = entity function_af55113b();
        if (!isdefined(chunks) || chunks.size == 0) {
            entity.var_7f90785e = 1;
            entity.var_938566b2 = entity.angles;
        } else if (isdefined(entity.var_827ce236) && entity.var_827ce236) {
            entity.var_f4caf688 = 1;
        } else {
            entity.var_4fcd0611 = 1;
        }
        return;
    }
    entity.var_7f90785e = 1;
    entity.var_938566b2 = entity.angles;
    if (isdefined(entity.first_node)) {
        chunks = entity function_af55113b();
        if (isdefined(chunks)) {
            for (i = 0; i < chunks.size; i++) {
                entity.first_node.zbarrier setzbarrierpiecestate(chunks[i], "opening", 0.2);
            }
        }
    }
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_abcc3970
// Checksum 0x202b5c51, Offset: 0x1838
// Size: 0x370
function private function_abcc3970(entity) {
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    if (isdefined(entity.var_7f90785e) && entity.var_7f90785e) {
        return 0;
    }
    if (!zm_behavior::inplayablearea(entity) && !shouldskipteardown(entity)) {
        if (isdefined(entity.got_to_entrance) && entity.got_to_entrance) {
            function_9235fe6a(entity);
        } else {
            if (zm_behavior::zombieenteredplayable(entity)) {
                return 0;
            }
            findnodesservice(entity);
        }
        return 0;
    }
    if (level.zombie_poi_array.size > 0) {
        zombie_poi = entity zm_utility::get_zombie_point_of_interest(entity.origin);
        if (isdefined(zombie_poi)) {
            targetpos = getclosestpointonnavmesh(zombie_poi[0], 64, 30);
            entity.zombie_poi = zombie_poi;
            entity.enemyoverride = zombie_poi;
            if (isdefined(targetpos)) {
                self setgoal(targetpos);
                return;
            }
            self setgoal(zombie_poi[0]);
            return;
        } else {
            entity.zombie_poi = undefined;
            entity.enemyoverride = undefined;
        }
    } else {
        entity.zombie_poi = undefined;
        entity.enemyoverride = undefined;
    }
    player = zombie_utility::get_closest_valid_player(self.origin, self.ignore_player, 1);
    entity.favoriteenemy = player;
    if (!isdefined(player) || player isnotarget()) {
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

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_d65e057d
// Checksum 0xf3c5ca2, Offset: 0x1bb0
// Size: 0xd4
function private razsprintservice(entity) {
    if (isdefined(entity.var_ece78d40) && entity.var_ece78d40) {
        return 0;
    }
    if (!isdefined(entity.var_815e6068)) {
        return 0;
    }
    if (gettime() > entity.var_815e6068) {
        entity.var_815e6068 = undefined;
        entity.var_ece78d40 = 1;
        entity.berserk = 1;
        entity thread function_6a229f8d();
        blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_sprint");
    }
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x1 linked
// namespace_8f7980f6<file_0>::function_6e839b7f
// Checksum 0x505e2969, Offset: 0x1c90
// Size: 0xd6
function razshouldmelee(entity) {
    if (isdefined(entity.var_4fcd0611) && entity.var_4fcd0611) {
        return true;
    }
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (distancesquared(entity.origin, entity.enemy.origin) > 5625) {
        return false;
    }
    yaw = abs(zombie_utility::getyawtoenemy());
    if (yaw > 45) {
        return false;
    }
    return true;
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_5fc996e
// Checksum 0x601e170b, Offset: 0x1d70
// Size: 0x60
function private razshouldshowpain(entity) {
    if (isdefined(entity.berserk) && entity.berserk && !(isdefined(entity.var_378298cd) && entity.var_378298cd)) {
        return false;
    }
    return true;
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_d89ebe9f
// Checksum 0x88dc2499, Offset: 0x1dd8
// Size: 0xc4
function private razshouldshowspecialpain(entity) {
    var_23534029 = blackboard::getblackboardattribute(entity, "_gib_location");
    if (var_23534029 == "right_arm") {
        return true;
    }
    if (!razshouldshowpain(entity)) {
        return false;
    }
    if (var_23534029 == "head" || var_23534029 == "arms" || var_23534029 == "right_leg" || var_23534029 == "left_leg" || var_23534029 == "left_arm") {
        return true;
    }
    return false;
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_cc04346d
// Checksum 0x9a0151a4, Offset: 0x1ea8
// Size: 0x60
function private razshouldshowshieldpain(entity) {
    if (isdefined(entity.damageweapon) && isdefined(entity.damageweapon.name)) {
        return (entity.damageweapon.name == "dragonshield");
    }
    return false;
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_b6b3f7ab
// Checksum 0x13999c9f, Offset: 0x1f10
// Size: 0x60
function private razshouldgoberserk(entity) {
    if (isdefined(entity.berserk) && entity.berserk && !(isdefined(entity.var_378298cd) && entity.var_378298cd)) {
        return true;
    }
    return false;
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_1017063
// Checksum 0x382c99cb, Offset: 0x1f78
// Size: 0x2e
function private razshouldtraversewindow(entity) {
    return isdefined(entity.var_7f90785e) && entity.var_7f90785e;
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_c7854a25
// Checksum 0x8e446ba, Offset: 0x1fb0
// Size: 0x20
function private razgoneberserk(entity) {
    entity.var_378298cd = 1;
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_364396ba
// Checksum 0x3b361966, Offset: 0x1fd8
// Size: 0x7c
function private function_364396ba(entity) {
    var_8352f87c = anglestoforward(entity.first_node.angles);
    var_8352f87c = vectorscale(var_8352f87c, 100);
    entity setgoal(entity.origin + var_8352f87c);
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_86973c57
// Checksum 0x7af1f812, Offset: 0x2060
// Size: 0x84
function private function_86973c57(entity) {
    entity setgoal(entity.origin);
    entity.var_7f90785e = undefined;
    entity.first_node = undefined;
    if (!(isdefined(entity.completed_emerging_into_playable_area) && entity.completed_emerging_into_playable_area)) {
        entity zm_spawner::zombie_complete_emerging_into_playable_area();
    }
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_60c76fb5
// Checksum 0x601cc735, Offset: 0x20f0
// Size: 0x34
function private raztookpain(entity) {
    blackboard::setblackboardattribute(entity, "_gib_location", "legs");
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_36948b2
// Checksum 0x3fe12893, Offset: 0x2130
// Size: 0x50c
function private razstartdeath(entity) {
    entity playsoundontag("zmb_raz_death", "tag_eye");
    if (isdefined(entity.var_827ce236) && entity.var_827ce236) {
        entity clientfield::set("raz_detach_gun", 1);
        entity.var_827ce236 = 0;
        entity detach("c_zom_dlc3_raz_cannon_arm");
        entity hidepart("j_shouldertwist_ri_attach", "", 1);
        entity hidepart("j_shoulder_ri_attach");
        wait(0.05);
        if (isdefined(entity)) {
            entity namespace_6a90a894::function_5da90c65();
        }
    }
    if (isdefined(entity)) {
        if (isdefined(entity.var_b6ad73bf) && entity.var_b6ad73bf) {
            entity clientfield::set("raz_detach_helmet", 1);
            entity hidepart("j_head_attach", "", 1);
            entity.var_b6ad73bf = 0;
        }
        if (isdefined(entity.var_f881a5ec) && entity.var_f881a5ec) {
            entity clientfield::set("raz_detach_chest_armor", 1);
            entity hidepart("j_spine4_attach", "", 1);
            entity hidepart("j_spineupper_attach", "", 1);
            entity hidepart("j_spinelower_attach", "", 1);
            entity hidepart("j_mainroot_attach", "", 1);
            entity hidepart("j_clavicle_ri_attachbp", "", 1);
            entity hidepart("j_clavicle_le_attachbp", "", 1);
            entity.var_f881a5ec = 0;
        }
        if (isdefined(entity.var_e3d1a6f8) && entity.var_e3d1a6f8) {
            entity clientfield::set("raz_detach_l_shoulder_armor", 1);
            entity hidepart("j_shouldertwist_le_attach", "", 1);
            entity hidepart("j_shoulder_le_attach", "", 1);
            entity hidepart("j_clavicle_le_attach", "", 1);
            entity.var_e3d1a6f8 = 0;
        }
        if (isdefined(entity.var_4711c856) && entity.var_4711c856) {
            entity clientfield::set("raz_detach_l_thigh_armor", 1);
            entity hidepart("j_hiptwist_le_attach", "", 1);
            entity hidepart("j_hip_le_attach", "", 1);
            entity.var_4711c856 = 0;
        }
        if (isdefined(entity.var_229ae313) && entity.var_229ae313) {
            entity clientfield::set("raz_detach_r_thigh_armor", 1);
            entity hidepart("j_hiptwist_ri_attach", "", 1);
            entity hidepart("j_hip_ri_attach", "", 1);
            entity.var_229ae313 = 0;
        }
    }
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_1187fa6c
// Checksum 0xc2d39429, Offset: 0x2648
// Size: 0x178
function private razshouldshootgroundtorpedo(entity) {
    if (isdefined(entity.var_f4caf688) && entity.var_f4caf688) {
        return true;
    }
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (!(isdefined(entity.var_827ce236) && entity.var_827ce236)) {
        return false;
    }
    time = gettime();
    if (time < entity.var_e56ae26) {
        return false;
    }
    enemy_dist_sq = distancesquared(entity.origin, entity.enemy.origin);
    if (!(enemy_dist_sq >= 22500 && enemy_dist_sq <= 1440000 && entity function_7f7ff86b(entity.enemy))) {
        return false;
    }
    if (isdefined(entity.check_point_in_enabled_zone)) {
        var_ec86edb7 = [[ entity.check_point_in_enabled_zone ]](entity.origin);
        if (!var_ec86edb7) {
            return false;
        }
    }
    return true;
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_7f7ff86b
// Checksum 0xf75344d1, Offset: 0x27c8
// Size: 0x186
function private function_7f7ff86b(enemy) {
    entity = self;
    origin_point = entity gettagorigin("tag_weapon_right");
    target_point = enemy.origin + (0, 0, 48);
    var_9407ef2d = anglestoforward(self.angles);
    var_7815db60 = target_point - origin_point;
    if (vectordot(var_9407ef2d, var_7815db60) <= 0) {
        return false;
    }
    var_3b8d6bb2 = anglestoright(self.angles);
    var_a72ca1b7 = vectordot(var_7815db60, var_3b8d6bb2);
    if (abs(var_a72ca1b7) > 50) {
        return false;
    }
    trace = bullettrace(origin_point, target_point, 0, self);
    if (trace["position"] === target_point) {
        return true;
    }
    return false;
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_90fc2230
// Checksum 0xd0958a24, Offset: 0x2958
// Size: 0x54
function private razstartmelee(entity) {
    if (isdefined(entity.var_4fcd0611) && entity.var_4fcd0611) {
        wait(1.1);
        function_9235fe6a(entity, 1);
    }
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_80581c8b
// Checksum 0x2cdf71ef, Offset: 0x29b8
// Size: 0x1a
function private razfinishmelee(entity) {
    entity.var_4fcd0611 = undefined;
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_d7b7ed6d
// Checksum 0x8122cfb4, Offset: 0x29e0
// Size: 0x30
function private razfinishgroundtorpedo(entity) {
    entity.var_f4caf688 = undefined;
    entity.var_e56ae26 = gettime() + 3000;
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_abc3e24
// Checksum 0xfbbcd6eb, Offset: 0x2a18
// Size: 0x164
function private function_abc3e24(entity) {
    if (!isdefined(entity.enemy) && !(isdefined(entity.var_f4caf688) && entity.var_f4caf688)) {
        println("actor");
        return;
    }
    if (isdefined(entity.var_f4caf688) && entity.var_f4caf688) {
        function_9235fe6a(entity, 1);
        var_8352f87c = anglestoforward(entity.first_node.angles);
        entity function_c5d7b1cd(entity.first_node, vectorscale(var_8352f87c, 100) + (0, 0, 48));
    } else {
        entity function_c5d7b1cd(entity.enemy, (0, 0, 48));
    }
    entity.var_e56ae26 = gettime() + 3000;
}

// Namespace namespace_8f7980f6
// Params 4, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_6a782133
// Checksum 0xaa5ec59a, Offset: 0x2b88
// Size: 0x130
function private function_6a782133(forward_dir, var_f34b6bd5, var_3756d92d, max_angle) {
    vec_to_enemy = var_3756d92d - var_f34b6bd5;
    vec_to_enemy_normal = vectornormalize(vec_to_enemy);
    angle_to_enemy = vectordot(forward_dir, vec_to_enemy_normal);
    if (angle_to_enemy >= max_angle) {
        return vec_to_enemy_normal;
    }
    plane_normal = vectorcross(forward_dir, vec_to_enemy_normal);
    perpendicular_normal = vectorcross(plane_normal, forward_dir);
    var_32015622 = forward_dir * cos(max_angle) + perpendicular_normal * sin(max_angle);
    return var_32015622;
}

// Namespace namespace_8f7980f6
// Params 2, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_c5d7b1cd
// Checksum 0xd8574203, Offset: 0x2cc0
// Size: 0x2b4
function private function_c5d7b1cd(var_7a82f1ae, var_b6ad162c) {
    var_f34b6bd5 = self gettagorigin("tag_weapon_right");
    var_3756d92d = var_7a82f1ae.origin + var_b6ad162c;
    var_169825b6 = spawn("script_model", var_f34b6bd5);
    var_169825b6 setmodel("tag_origin");
    var_169825b6 clientfield::set("raz_torpedo_play_fx_on_self", 1);
    var_169825b6.var_dc16db5e = 0;
    var_169825b6.var_5429c84c = self;
    vec_to_enemy = function_6a782133(anglestoforward(self.angles), var_f34b6bd5, var_3756d92d, 0.7);
    angles_to_enemy = vectortoangles(vec_to_enemy);
    var_169825b6.angles = angles_to_enemy;
    normal_vector = vectornormalize(vec_to_enemy);
    var_169825b6.var_3602f22c = normal_vector;
    var_169825b6.knockdown_iterations = 0;
    var_77748338 = 50;
    max_trail_iterations = int(1200 / var_77748338);
    var_169825b6 thread function_d25d41e8(var_7a82f1ae);
    var_169825b6 thread function_b077c8b0(var_7a82f1ae, var_b6ad162c);
    while (isdefined(var_169825b6)) {
        if (!isdefined(var_7a82f1ae) || var_169825b6.var_dc16db5e >= max_trail_iterations) {
            var_169825b6 thread function_c8b09d11(0);
        } else {
            var_169825b6 function_2e413eea(var_7a82f1ae);
            var_169825b6.var_dc16db5e += 1;
        }
        wait(0.1);
    }
}

// Namespace namespace_8f7980f6
// Params 2, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_b077c8b0
// Checksum 0x4055c23a, Offset: 0x2f80
// Size: 0xc0
function private function_b077c8b0(var_7a82f1ae, var_b6ad162c) {
    self endon(#"death");
    self endon(#"detonated");
    var_169825b6 = self;
    while (isdefined(var_169825b6) && isdefined(var_7a82f1ae)) {
        var_3756d92d = var_7a82f1ae.origin + var_b6ad162c;
        if (distancesquared(var_169825b6.origin, var_3756d92d) <= 4096) {
            var_169825b6 thread function_c8b09d11(0);
        }
        wait(0.05);
    }
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_2e413eea
// Checksum 0x995511f9, Offset: 0x3048
// Size: 0x43c
function private function_2e413eea(var_7a82f1ae) {
    self endon(#"death");
    self endon(#"detonated");
    if (!isdefined(self.var_de9583ed)) {
        var_36984e86 = 13.5;
        self.var_de9583ed = cos(var_36984e86);
    }
    if (isdefined(self.var_3602f22c)) {
        var_f9beb155 = var_7a82f1ae.origin + (0, 0, 48);
        if (isplayer(var_7a82f1ae)) {
            var_f9beb155 = var_7a82f1ae getplayercamerapos();
        }
        vector_to_target = var_f9beb155 - self.origin;
        normal_vector = vectornormalize(vector_to_target);
        var_bfec607e = vectornormalize((normal_vector[0], normal_vector[1], 0));
        var_ee111afc = vectornormalize((self.var_3602f22c[0], self.var_3602f22c[1], 0));
        dot = vectordot(var_bfec607e, var_ee111afc);
        if (dot >= 1) {
            dot = 1;
        } else if (dot <= -1) {
            dot = -1;
        }
        if (dot < self.var_de9583ed) {
            new_vector = normal_vector - self.var_3602f22c;
            angle_between_vectors = acos(dot);
            if (!isdefined(angle_between_vectors)) {
                angle_between_vectors = -76;
            }
            if (angle_between_vectors == 0) {
                angle_between_vectors = 0.0001;
            }
            var_8c49ee9f = 13.5;
            ratio = var_8c49ee9f / angle_between_vectors;
            if (ratio > 1) {
                ratio = 1;
            }
            new_vector *= ratio;
            new_vector += self.var_3602f22c;
            normal_vector = vectornormalize(new_vector);
        } else {
            normal_vector = self.var_3602f22c;
        }
    }
    move_distance = 50;
    move_vector = move_distance * normal_vector;
    move_to_point = self.origin + move_vector;
    trace = bullettrace(self.origin, move_to_point, 0, self);
    if (trace["surfacetype"] !== "none") {
        detonate_point = trace["position"];
        dist_sq = distancesquared(detonate_point, self.origin);
        move_dist_sq = move_distance * move_distance;
        ratio = dist_sq / move_dist_sq;
        delay = ratio * 0.1;
        self thread function_c8b09d11(delay);
    }
    self.var_3602f22c = normal_vector;
    self moveto(move_to_point, 0.1);
}

// Namespace namespace_8f7980f6
// Params 0, eflags: 0x4
// namespace_8f7980f6<file_0>::function_c651415a
// Checksum 0xbb879762, Offset: 0x3490
// Size: 0xc4
function private function_c651415a() {
    self endon(#"death");
    self endon(#"detonated");
    var_f26ead57 = 26;
    if (self.var_dc16db5e >= 1) {
        trace = bullettrace(self.origin + (0, 0, 10), self.origin - (0, 0, var_f26ead57), 0, self);
        if (trace["surfacetype"] !== "none") {
            self clientfield::increment("raz_torpedo_play_trail", 1);
        }
    }
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_329d0429
// Checksum 0x33fbafd9, Offset: 0x3560
// Size: 0x5f0
function private function_329d0429(target) {
    self endon(#"death");
    while (isdefined(self)) {
        if (isdefined(target)) {
            if (isplayer(target)) {
                var_e4c026d4 = target.origin + (0, 0, 48);
            } else {
                var_e4c026d4 = target.origin;
            }
            prediction_time = 0.3;
            if (isdefined(self.knockdown_iterations) && self.knockdown_iterations < 3) {
                if (self.knockdown_iterations == 0) {
                    prediction_time = 0.075;
                }
                if (self.knockdown_iterations == 1) {
                    prediction_time = 0.15;
                }
                if (self.knockdown_iterations == 2) {
                    prediction_time = 0.225;
                }
            }
            self.knockdown_iterations += 1;
            vector_to_target = var_e4c026d4 - self.origin;
            normal_vector = vectornormalize(vector_to_target);
            move_distance = 500 * prediction_time;
            move_vector = move_distance * normal_vector;
            self.angles = vectortoangles(move_vector);
        } else {
            velocity = self getvelocity();
            velocitymag = length(velocity);
            b_sprinting = velocitymag >= 40;
            if (b_sprinting) {
                var_43502fbc = 0.2;
                move_vector = velocity * var_43502fbc;
            }
        }
        if (!isdefined(b_sprinting) || b_sprinting == 1) {
            predicted_pos = self.origin + move_vector;
            a_zombies = getaiarchetypearray("zombie");
            var_abbab1d4 = array::filter(a_zombies, 0, &function_ecaf6b12, self, predicted_pos);
        } else {
            wait(0.2);
            continue;
        }
        if (var_abbab1d4.size > 0) {
            foreach (zombie in var_abbab1d4) {
                zombie.knockdown = 1;
                zombie.knockdown_type = "knockdown_shoved";
                var_716b0dc7 = self.origin - zombie.origin;
                var_1d29c3f8 = vectornormalize((var_716b0dc7[0], var_716b0dc7[1], 0));
                zombie_forward = anglestoforward(zombie.angles);
                zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
                zombie_right = anglestoright(zombie.angles);
                zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
                dot = vectordot(var_1d29c3f8, zombie_forward_2d);
                if (dot >= 0.5) {
                    zombie.knockdown_direction = "front";
                    zombie.getup_direction = "getup_back";
                    continue;
                }
                if (dot < 0.5 && dot > -0.5) {
                    dot = vectordot(var_1d29c3f8, zombie_right_2d);
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
                    continue;
                }
                zombie.knockdown_direction = "back";
                zombie.getup_direction = "getup_belly";
            }
        }
        wait(0.2);
    }
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_d25d41e8
// Checksum 0xbb9652d9, Offset: 0x3b58
// Size: 0x3c
function private function_d25d41e8(var_7a82f1ae) {
    self endon(#"death");
    self endon(#"detonated");
    function_329d0429(var_7a82f1ae);
}

// Namespace namespace_8f7980f6
// Params 0, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_6a229f8d
// Checksum 0xd2eca887, Offset: 0x3ba0
// Size: 0x3c
function private function_6a229f8d() {
    self endon(#"death");
    self notify(#"hash_6a229f8d");
    self endon(#"hash_6a229f8d");
    function_329d0429();
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_c8b09d11
// Checksum 0x9be57ec4, Offset: 0x3be8
// Size: 0x1b4
function private function_c8b09d11(delay) {
    self notify(#"detonated");
    var_169825b6 = self;
    var_5429c84c = self.var_5429c84c;
    if (delay > 0) {
        wait(delay);
    }
    if (isdefined(self)) {
        self function_a3101466();
        w_weapon = getweapon("none");
        explosion_point = var_169825b6.origin;
        var_169825b6 clientfield::set("raz_detonate_ground_torpedo", 1);
        radiusdamage(explosion_point + (0, 0, 18), -128, 100, 50, self.var_5429c84c, "MOD_UNKNOWN", w_weapon);
        function_3412c871(explosion_point + (0, 0, 18));
        self clientfield::set("raz_torpedo_play_fx_on_self", 0);
        wait(0.05);
        if (isdefined(level.var_4c5a7c47) && isdefined(var_5429c84c) && level.var_4c5a7c47) {
            var_5429c84c.var_e56ae26 = gettime();
        }
        if (isdefined(self)) {
            self delete();
        }
    }
}

// Namespace namespace_8f7980f6
// Params 1, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_3412c871
// Checksum 0xc3b0478b, Offset: 0x3da8
// Size: 0x28e
function private function_3412c871(var_18c439cb) {
    players = getplayers();
    v_length = 100 * 100;
    for (i = 0; i < players.size; i++) {
        player = players[i];
        if (!isalive(player)) {
            continue;
        }
        if (player.sessionstate == "spectator") {
            continue;
        }
        if (player.sessionstate == "intermission") {
            continue;
        }
        if (isdefined(player.ignoreme) && player.ignoreme) {
            continue;
        }
        if (player isnotarget()) {
            continue;
        }
        if (!player isonground()) {
            continue;
        }
        n_distance = distance2dsquared(var_18c439cb, player.origin);
        if (n_distance < 0.01) {
            continue;
        }
        if (n_distance < v_length) {
            v_dir = player.origin - var_18c439cb;
            v_dir = (v_dir[0], v_dir[1], 0.1);
            v_dir = vectornormalize(v_dir);
            n_push_strength = getdvarint("raz_n_push_strength", 500);
            n_push_strength = -56 + randomint(n_push_strength - -56);
            v_player_velocity = player getvelocity();
            player setvelocity(v_player_velocity + v_dir * n_push_strength);
        }
    }
}

// Namespace namespace_8f7980f6
// Params 0, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_a3101466
// Checksum 0x9ee1d5d7, Offset: 0x4040
// Size: 0xe6
function private function_a3101466() {
    earthquake(0.4, 0.8, self.origin, 300);
    for (i = 0; i < level.activeplayers.size; i++) {
        distancesq = distancesquared(self.origin, level.activeplayers[i].origin + (0, 0, 48));
        if (distancesq > 4096) {
            continue;
        }
        level.activeplayers[i] playrumbleonentity("damage_heavy");
    }
}

// Namespace namespace_8f7980f6
// Params 3, eflags: 0x5 linked
// namespace_8f7980f6<file_0>::function_ecaf6b12
// Checksum 0xb8178867, Offset: 0x4130
// Size: 0x234
function private function_ecaf6b12(zombie, target, predicted_pos) {
    if (zombie.knockdown === 1) {
        return false;
    }
    if (gibserverutils::isgibbed(zombie, 384)) {
        return false;
    }
    var_c3cb3962 = 48;
    var_11295a10 = zombie.origin;
    if (!isactor(target)) {
        var_11295a10 = zombie getcentroid();
        var_c3cb3962 = 64;
    }
    var_780bea21 = var_c3cb3962 * var_c3cb3962;
    dist_sq = distancesquared(predicted_pos, var_11295a10);
    if (dist_sq > var_780bea21) {
        return false;
    }
    origin = target.origin;
    facing_vec = anglestoforward(target.angles);
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

#namespace namespace_6a90a894;

// Namespace namespace_6a90a894
// Params 0, eflags: 0x5 linked
// namespace_6a90a894<file_0>::function_8fe3f6c8
// Checksum 0x8ca07dac, Offset: 0x4370
// Size: 0x1dc
function private function_8fe3f6c8() {
    self.var_815e6068 = gettime() + 90000;
    self.var_e56ae26 = gettime();
    self.var_827ce236 = 1;
    self.var_b6ad73bf = 1;
    self.var_e3d1a6f8 = 1;
    self.var_f881a5ec = 1;
    self.var_229ae313 = 1;
    self.var_4711c856 = 1;
    self.var_378298cd = 0;
    if (!isdefined(level.var_52e55d88)) {
        level.var_52e55d88 = 500;
    }
    if (!isdefined(level.var_23b3da6c)) {
        level.var_23b3da6c = self.health;
    }
    if (!isdefined(level.var_1f5dd695)) {
        level.var_1f5dd695 = 100;
    }
    if (!isdefined(level.var_be1fdc52)) {
        level.var_be1fdc52 = 100;
    }
    if (!isdefined(level.var_87ab7c6e)) {
        level.var_87ab7c6e = 100;
    }
    if (!isdefined(level.var_1b1e6d7b)) {
        level.var_1b1e6d7b = 100;
    }
    self.maxhealth = level.var_23b3da6c;
    self.var_52e55d88 = level.var_52e55d88;
    self.var_1f5dd695 = level.var_1f5dd695;
    self.var_87ab7c6e = level.var_87ab7c6e;
    self.var_cf83fd38 = level.var_1b1e6d7b;
    self.var_b65cd277 = level.var_1b1e6d7b;
    self.var_be1fdc52 = level.var_be1fdc52;
    self.canbetargetedbyturnedzombies = 1;
    self.var_65eda69a = 1;
    self.flame_fx_timeout = 3;
    aiutility::addaioverridedamagecallback(self, &function_e43cf0de);
    self thread function_6c4ddd98();
}

// Namespace namespace_6a90a894
// Params 0, eflags: 0x5 linked
// namespace_6a90a894<file_0>::function_6c4ddd98
// Checksum 0x15309eda, Offset: 0x4558
// Size: 0x42e
function private function_6c4ddd98() {
    self endon(#"death");
    self endon(#"disconnect");
    while (true) {
        self waittill(#"melee_fire");
        a_zombies = getaiarchetypearray("zombie");
        foreach (zombie in a_zombies) {
            if (isdefined(zombie.no_gib) && zombie.no_gib) {
                continue;
            }
            heightdiff = abs(zombie.origin[2] - self.origin[2]);
            if (heightdiff > 50) {
                continue;
            }
            var_ef2a38b6 = distance2dsquared(zombie.origin, self.origin);
            if (var_ef2a38b6 > 90 * 90) {
                continue;
            }
            var_3095556e = anglestoforward(self.angles);
            var_7815db60 = zombie.origin - self.origin;
            if (vectordot(var_3095556e, var_7815db60) <= 0) {
                continue;
            }
            var_3b8d6bb2 = anglestoright(self.angles);
            var_a72ca1b7 = vectordot(var_7815db60, var_3b8d6bb2);
            if (abs(var_a72ca1b7) > 35) {
                continue;
            }
            b_gibbed = 0;
            val = randomint(100);
            if (val > 50) {
                zombie zombie_utility::zombie_head_gib();
                b_gibbed = 1;
            }
            val = randomint(100);
            if (val > 50) {
                if (!gibserverutils::isgibbed(zombie, 32)) {
                    gibserverutils::gibrightarm(zombie);
                    b_gibbed = 1;
                }
            }
            val = randomint(100);
            if (val > 50) {
                if (!gibserverutils::isgibbed(zombie, 16)) {
                    gibserverutils::gibleftarm(zombie);
                    b_gibbed = 1;
                }
            }
            if (!(isdefined(b_gibbed) && b_gibbed)) {
                if (!gibserverutils::isgibbed(zombie, 32)) {
                    gibserverutils::gibrightarm(zombie);
                    continue;
                }
                if (!gibserverutils::isgibbed(zombie, 16)) {
                    gibserverutils::gibleftarm(zombie);
                    continue;
                }
                zombie zombie_utility::zombie_head_gib();
            }
        }
    }
}

// Namespace namespace_6a90a894
// Params 0, eflags: 0x5 linked
// namespace_6a90a894<file_0>::function_5da90c65
// Checksum 0xeb19c9b5, Offset: 0x4990
// Size: 0x30c
function private function_5da90c65() {
    if (!(isdefined(self.var_827ce236) && self.var_827ce236)) {
        self hidepart("j_shouldertwist_ri_attach", "", 1);
        self hidepart("j_shoulder_ri_attach");
    }
    if (!(isdefined(self.var_f881a5ec) && self.var_f881a5ec)) {
        self hidepart("j_spine4_attach", "", 1);
        self hidepart("j_spineupper_attach", "", 1);
        self hidepart("j_spinelower_attach", "", 1);
        self hidepart("j_mainroot_attach", "", 1);
        self hidepart("j_clavicle_ri_attachbp", "", 1);
        self hidepart("j_clavicle_le_attachbp", "", 1);
    }
    if (!(isdefined(self.var_e3d1a6f8) && self.var_e3d1a6f8)) {
        self hidepart("j_shouldertwist_le_attach", "", 1);
        self hidepart("j_shoulder_le_attach", "", 1);
        self hidepart("j_clavicle_le_attach", "", 1);
    }
    if (!(isdefined(self.var_229ae313) && self.var_229ae313)) {
        self hidepart("j_hiptwist_ri_attach", "", 1);
        self hidepart("j_hip_ri_attach", "", 1);
    }
    if (!(isdefined(self.var_4711c856) && self.var_4711c856)) {
        self hidepart("j_hiptwist_le_attach", "", 1);
        self hidepart("j_hip_le_attach", "", 1);
    }
    if (!(isdefined(self.var_b6ad73bf) && self.var_b6ad73bf)) {
        self hidepart("j_head_attach", "", 1);
    }
}

// Namespace namespace_6a90a894
// Params 12, eflags: 0x5 linked
// namespace_6a90a894<file_0>::function_e43cf0de
// Checksum 0xa0de63a3, Offset: 0x4ca8
// Size: 0x5e4
function private function_e43cf0de(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity = self;
    entity.var_e440b4d1 = 0;
    if (isdefined(attacker) && attacker == entity) {
        return 0;
    }
    if (mod !== "MOD_PROJECTILE_SPLASH") {
        if (isdefined(entity.var_827ce236) && entity.var_827ce236) {
            var_b58c2791 = function_eeca913f(entity, hitloc, point, "right_arm_upper", 81, "j_shouldertwist_ri_attach");
            if (isdefined(var_b58c2791) && var_b58c2791) {
                entity function_66b2e4fe(damage, attacker);
                damage *= 0.1;
                if (!(isdefined(entity.var_827ce236) && entity.var_827ce236)) {
                    var_ef7e3a1e = entity.health - damage;
                    var_251568e7 = entity.maxhealth * 0.33;
                    var_4c8d44cc = (var_ef7e3a1e - var_251568e7) / entity.maxhealth;
                    if (var_4c8d44cc > 0.25) {
                        return (entity.health - entity.maxhealth * 0.25);
                    } else {
                        return var_251568e7;
                    }
                }
                return damage;
            }
        }
        if (isdefined(entity.var_f881a5ec) && entity.var_f881a5ec) {
            var_8e5d1015 = function_eeca913f(entity, hitloc, point, "torso_upper", -112, "j_spine4_attach");
            if (var_8e5d1015 || hitloc === "torso_lower" || hitloc === "torso_mid") {
                entity function_e48123be(damage);
                entity.var_e440b4d1 = 1;
                damage *= 0.1;
                return damage;
            }
        }
        if (isdefined(entity.var_e3d1a6f8) && entity.var_e3d1a6f8) {
            var_50b4997d = function_eeca913f(entity, hitloc, point, "left_arm_upper", 81, "j_shouldertwist_le_attach");
            if (var_50b4997d) {
                entity function_9edbae6c(damage);
                entity.var_e440b4d1 = 1;
                damage *= 0.1;
                return damage;
            }
        }
        if (isdefined(entity.var_229ae313) && entity.var_229ae313) {
            var_9ef21f51 = function_eeca913f(entity, hitloc, point, "right_leg_upper", 81, "j_hiptwist_ri_attach");
            if (var_9ef21f51) {
                entity function_e3ca16cf(damage);
                entity.var_e440b4d1 = 1;
                damage *= 0.1;
                return damage;
            }
        }
        if (isdefined(entity.var_4711c856) && entity.var_4711c856) {
            var_cd90f54f = function_eeca913f(entity, hitloc, point, "left_leg_upper", 81, "j_hiptwist_le_attach");
            if (var_cd90f54f) {
                entity function_8eeac160(damage);
                entity.var_e440b4d1 = 1;
                damage *= 0.1;
                return damage;
            }
        }
        if (isdefined(entity.var_b6ad73bf) && entity.var_b6ad73bf) {
            var_38aebb90 = function_eeca913f(entity, hitloc, point, "head", 121, "j_head");
            if (var_38aebb90 || hitloc === "neck" || hitloc === "helmet") {
                entity function_5d00a425(damage, attacker);
                entity.var_e440b4d1 = 1;
                damage *= 0.1;
                return damage;
            }
        }
    }
    return damage;
}

// Namespace namespace_6a90a894
// Params 6, eflags: 0x5 linked
// namespace_6a90a894<file_0>::function_eeca913f
// Checksum 0xf51e0c5, Offset: 0x5298
// Size: 0xd4
function private function_eeca913f(entity, hitloc, point, location, var_6e7bbf1c, tag) {
    var_d749ca37 = 0;
    if (isdefined(hitloc) && hitloc != "none") {
        if (hitloc == location) {
            var_d749ca37 = 1;
        }
    } else {
        dist_sq = distancesquared(point, entity gettagorigin(tag));
        if (dist_sq <= var_6e7bbf1c) {
            var_d749ca37 = 1;
        }
    }
    return var_d749ca37;
}

// Namespace namespace_6a90a894
// Params 2, eflags: 0x5 linked
// namespace_6a90a894<file_0>::function_66b2e4fe
// Checksum 0xad25ce7, Offset: 0x5378
// Size: 0x30e
function private function_66b2e4fe(damage, attacker) {
    entity = self;
    entity.var_52e55d88 -= damage;
    var_ef7e3a1e = entity.health - damage;
    var_4c8d44cc = var_ef7e3a1e / entity.maxhealth;
    if (entity.var_52e55d88 > 0) {
        entity clientfield::increment("raz_gun_weakpoint_hit", 1);
    }
    if (entity.var_52e55d88 <= 0) {
        entity.var_52e55d88 = 0;
        entity clientfield::set("raz_detach_gun", 1);
        entity.var_827ce236 = 0;
        entity.var_815e6068 = undefined;
        entity.var_ece78d40 = 1;
        entity thread namespace_8f7980f6::function_6a229f8d();
        blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_sprint");
        blackboard::setblackboardattribute(entity, "_gibbed_limbs", "right_arm");
        blackboard::setblackboardattribute(entity, "_gib_location", "right_arm");
        var_e835701f = 0.5 * entity.maxhealth;
        var_98e906d9 = 0.25 * entity.maxhealth;
        weapon = getweapon("raz_melee");
        radiusdamage(self.origin + (0, 0, 18), -128, var_e835701f, var_98e906d9, entity, "MOD_PROJECTILE_SPLASH", weapon);
        self detach("c_zom_dlc3_raz_cannon_arm");
        self hidepart("j_shouldertwist_ri_attach", "", 1);
        self hidepart("j_shoulder_ri_attach");
        function_5da90c65();
        level notify(#"hash_826c20b", attacker);
        self notify(#"hash_826c20b", attacker);
    }
}

// Namespace namespace_6a90a894
// Params 2, eflags: 0x5 linked
// namespace_6a90a894<file_0>::function_5d00a425
// Checksum 0xe8c8a2c0, Offset: 0x5690
// Size: 0xee
function private function_5d00a425(damage, attacker) {
    entity = self;
    entity.var_1f5dd695 -= damage;
    if (entity.var_1f5dd695 <= 0) {
        entity clientfield::set("raz_detach_helmet", 1);
        entity hidepart("j_head_attach", "", 1);
        entity.var_b6ad73bf = 0;
        blackboard::setblackboardattribute(entity, "_gib_location", "head");
        level notify(#"hash_4de460e7", attacker);
    }
}

// Namespace namespace_6a90a894
// Params 1, eflags: 0x5 linked
// namespace_6a90a894<file_0>::function_e48123be
// Checksum 0x79369c9, Offset: 0x5788
// Size: 0x19c
function private function_e48123be(damage) {
    entity = self;
    entity.var_87ab7c6e -= damage;
    if (entity.var_87ab7c6e <= 0) {
        entity clientfield::set("raz_detach_chest_armor", 1);
        entity hidepart("j_spine4_attach", "", 1);
        entity hidepart("j_spineupper_attach", "", 1);
        entity hidepart("j_spinelower_attach", "", 1);
        entity hidepart("j_mainroot_attach", "", 1);
        entity hidepart("j_clavicle_ri_attachbp", "", 1);
        entity hidepart("j_clavicle_le_attachbp", "", 1);
        entity.var_f881a5ec = 0;
        blackboard::setblackboardattribute(entity, "_gib_location", "arms");
    }
}

// Namespace namespace_6a90a894
// Params 1, eflags: 0x5 linked
// namespace_6a90a894<file_0>::function_9edbae6c
// Checksum 0x8bacf320, Offset: 0x5930
// Size: 0x124
function private function_9edbae6c(damage) {
    entity = self;
    entity.var_be1fdc52 -= damage;
    if (entity.var_be1fdc52 <= 0) {
        entity clientfield::set("raz_detach_l_shoulder_armor", 1);
        entity hidepart("j_shouldertwist_le_attach", "", 1);
        entity hidepart("j_shoulder_le_attach", "", 1);
        entity hidepart("j_clavicle_le_attach", "", 1);
        entity.var_e3d1a6f8 = 0;
        blackboard::setblackboardattribute(entity, "_gib_location", "left_arm");
    }
}

// Namespace namespace_6a90a894
// Params 1, eflags: 0x5 linked
// namespace_6a90a894<file_0>::function_8eeac160
// Checksum 0xafaaae6f, Offset: 0x5a60
// Size: 0xfc
function private function_8eeac160(damage) {
    entity = self;
    entity.var_b65cd277 -= damage;
    if (entity.var_b65cd277 <= 0) {
        entity clientfield::set("raz_detach_l_thigh_armor", 1);
        entity hidepart("j_hiptwist_le_attach", "", 1);
        entity hidepart("j_hip_le_attach", "", 1);
        entity.var_4711c856 = 0;
        blackboard::setblackboardattribute(entity, "_gib_location", "left_leg");
    }
}

// Namespace namespace_6a90a894
// Params 1, eflags: 0x5 linked
// namespace_6a90a894<file_0>::function_e3ca16cf
// Checksum 0x6c288447, Offset: 0x5b68
// Size: 0xfc
function private function_e3ca16cf(damage) {
    entity = self;
    entity.var_cf83fd38 -= damage;
    if (entity.var_cf83fd38 <= 0) {
        entity clientfield::set("raz_detach_r_thigh_armor", 1);
        entity hidepart("j_hiptwist_ri_attach", "", 1);
        entity hidepart("j_hip_ri_attach", "", 1);
        entity.var_229ae313 = 0;
        blackboard::setblackboardattribute(entity, "_gib_location", "right_leg");
    }
}

