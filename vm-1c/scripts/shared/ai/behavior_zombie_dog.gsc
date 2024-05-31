#using scripts/shared/math_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/ai/archetype_zombie_dog_interface;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/spawner_shared;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;

#namespace namespace_1db6d2c9;

// Namespace namespace_1db6d2c9
// Params 0, eflags: 0x2
// namespace_1db6d2c9<file_0>::function_a13b795c
// Checksum 0xa551afe6, Offset: 0x3f8
// Size: 0x13c
function autoexec registerbehaviorscriptfunctions() {
    spawner::add_archetype_spawn_function("zombie_dog", &archetypezombiedogblackboardinit);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDogTargetService", &zombiedogtargetservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDogShouldMelee", &zombiedogshouldmelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDogShouldWalk", &zombiedogshouldwalk);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDogShouldRun", &zombiedogshouldrun);
    behaviortreenetworkutility::registerbehaviortreeaction("zombieDogMeleeAction", &zombiedogmeleeaction, undefined, &zombiedogmeleeactionterminate);
    animationstatenetwork::registernotetrackhandlerfunction("dog_melee", &zombiebehavior::zombienotetrackmeleefire);
    namespace_273d1a1c::registerzombiedoginterfaceattributes();
}

// Namespace namespace_1db6d2c9
// Params 0, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_271468a7
// Checksum 0x3f2bf9c1, Offset: 0x540
// Size: 0x1b8
function archetypezombiedogblackboardinit() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self aiutility::function_89e1fc16();
    blackboard::registerblackboardattribute(self, "_low_gravity", "normal", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("_low_gravity");
        #/
    }
    blackboard::registerblackboardattribute(self, "_should_run", "walk", &bb_getshouldrunstatus);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("_low_gravity");
        #/
    }
    blackboard::registerblackboardattribute(self, "_should_howl", "dont_howl", &bb_getshouldhowlstatus);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("_low_gravity");
        #/
    }
    self.___archetypeonanimscriptedcallback = &archetypezombiedogonanimscriptedcallback;
    /#
        self finalizetrackedblackboardattributes();
    #/
    self.kill_on_wine_coccon = 1;
}

// Namespace namespace_1db6d2c9
// Params 1, eflags: 0x5 linked
// namespace_1db6d2c9<file_0>::function_f212af61
// Checksum 0xa802fde6, Offset: 0x700
// Size: 0x34
function private archetypezombiedogonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity archetypezombiedogblackboardinit();
}

// Namespace namespace_1db6d2c9
// Params 0, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_ffca9c96
// Checksum 0xf20ce35d, Offset: 0x740
// Size: 0x8e
function bb_getshouldrunstatus() {
    /#
        if (isdefined(self.ispuppet) && self.ispuppet) {
            return "_low_gravity";
        }
    #/
    if (ai::hasaiattribute(self, "sprint") && (isdefined(self.hasseenfavoriteenemy) && self.hasseenfavoriteenemy || ai::getaiattribute(self, "sprint"))) {
        return "run";
    }
    return "walk";
}

// Namespace namespace_1db6d2c9
// Params 0, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_b361725
// Checksum 0x5ae64f5d, Offset: 0x7d8
// Size: 0xbe
function bb_getshouldhowlstatus() {
    if (isdefined(self.hasseenfavoriteenemy) && self ai::has_behavior_attribute("howl_chance") && self.hasseenfavoriteenemy) {
        if (!isdefined(self.shouldhowl)) {
            chance = self ai::get_behavior_attribute("howl_chance");
            self.shouldhowl = randomfloat(1) <= chance;
        }
        if (self.shouldhowl) {
            return "howl";
        } else {
            return "dont_howl";
        }
    }
    return "dont_howl";
}

// Namespace namespace_1db6d2c9
// Params 1, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_fcaa5774
// Checksum 0x620981f, Offset: 0x8a0
// Size: 0x42
function getyaw(org) {
    angles = vectortoangles(org - self.origin);
    return angles[1];
}

// Namespace namespace_1db6d2c9
// Params 0, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_bb72d5c9
// Checksum 0xd4d00370, Offset: 0x8f0
// Size: 0xa0
function absyawtoenemy() {
    assert(isdefined(self.enemy));
    yaw = self.angles[1] - getyaw(self.enemy.origin);
    yaw = angleclamp180(yaw);
    if (yaw < 0) {
        yaw = -1 * yaw;
    }
    return yaw;
}

// Namespace namespace_1db6d2c9
// Params 0, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_b20db4bd
// Checksum 0x51b27044, Offset: 0x998
// Size: 0x234
function need_to_run() {
    run_dist_squared = self ai::get_behavior_attribute("min_run_dist") * self ai::get_behavior_attribute("min_run_dist");
    run_yaw = 20;
    run_pitch = 30;
    run_height = 64;
    if (self.health < self.maxhealth) {
        return true;
    }
    if (!isdefined(self.enemy) || !isalive(self.enemy)) {
        return false;
    }
    if (!self cansee(self.enemy)) {
        return false;
    }
    dist = distancesquared(self.origin, self.enemy.origin);
    if (dist > run_dist_squared) {
        return false;
    }
    height = self.origin[2] - self.enemy.origin[2];
    if (abs(height) > run_height) {
        return false;
    }
    yaw = self absyawtoenemy();
    if (yaw > run_yaw) {
        return false;
    }
    pitch = angleclamp180(vectortoangles(self.origin - self.enemy.origin)[0]);
    if (abs(pitch) > run_pitch) {
        return false;
    }
    return true;
}

// Namespace namespace_1db6d2c9
// Params 2, eflags: 0x5 linked
// namespace_1db6d2c9<file_0>::function_248d1688
// Checksum 0x51d4d9a5, Offset: 0xbd8
// Size: 0x1ec
function private is_target_valid(dog, target) {
    if (!isdefined(target)) {
        return 0;
    }
    if (!isalive(target)) {
        return 0;
    }
    if (!(dog.team == "allies")) {
        if (!isplayer(target) && sessionmodeiszombiesgame()) {
            return 0;
        }
        if (isdefined(target.is_zombie) && target.is_zombie == 1) {
            return 0;
        }
    }
    if (isplayer(target) && target.sessionstate == "spectator") {
        return 0;
    }
    if (isplayer(target) && target.sessionstate == "intermission") {
        return 0;
    }
    if (isdefined(self.intermission) && self.intermission) {
        return 0;
    }
    if (isdefined(target.ignoreme) && target.ignoreme) {
        return 0;
    }
    if (target isnotarget()) {
        return 0;
    }
    if (dog.team == target.team) {
        return 0;
    }
    if (isplayer(target) && isdefined(level.is_player_valid_override)) {
        return [[ level.is_player_valid_override ]](target);
    }
    return 1;
}

// Namespace namespace_1db6d2c9
// Params 1, eflags: 0x5 linked
// namespace_1db6d2c9<file_0>::function_5a23d5bb
// Checksum 0x58636a97, Offset: 0xdd0
// Size: 0x26e
function private get_favorite_enemy(dog) {
    dog_targets = [];
    if (sessionmodeiszombiesgame()) {
        if (self.team == "allies") {
            dog_targets = getaiteamarray(level.zombie_team);
        } else {
            dog_targets = getplayers();
        }
    } else {
        dog_targets = arraycombine(getplayers(), getaiarray(), 0, 0);
    }
    least_hunted = dog_targets[0];
    closest_target_dist_squared = undefined;
    for (i = 0; i < dog_targets.size; i++) {
        if (!isdefined(dog_targets[i].hunted_by)) {
            dog_targets[i].hunted_by = 0;
        }
        if (!is_target_valid(dog, dog_targets[i])) {
            continue;
        }
        if (!is_target_valid(dog, least_hunted)) {
            least_hunted = dog_targets[i];
        }
        dist_squared = distancesquared(dog.origin, dog_targets[i].origin);
        if (!isdefined(closest_target_dist_squared) || dog_targets[i].hunted_by <= least_hunted.hunted_by && dist_squared < closest_target_dist_squared) {
            least_hunted = dog_targets[i];
            closest_target_dist_squared = dist_squared;
        }
    }
    if (!is_target_valid(dog, least_hunted)) {
        return undefined;
    }
    least_hunted.hunted_by += 1;
    return least_hunted;
}

// Namespace namespace_1db6d2c9
// Params 0, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_2529bdd1
// Checksum 0xf80434a, Offset: 0x1048
// Size: 0x2e
function get_last_valid_position() {
    if (isplayer(self)) {
        return self.last_valid_position;
    }
    return self.origin;
}

// Namespace namespace_1db6d2c9
// Params 1, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_60ea154f
// Checksum 0xe0f97c6e, Offset: 0x1080
// Size: 0x280
function get_locomotion_target(behaviortreeentity) {
    last_valid_position = behaviortreeentity.favoriteenemy get_last_valid_position();
    if (!isdefined(last_valid_position)) {
        return undefined;
    }
    locomotion_target = last_valid_position;
    if (ai::has_behavior_attribute("spacing_value")) {
        spacing_near_dist = ai::get_behavior_attribute("spacing_near_dist");
        spacing_far_dist = ai::get_behavior_attribute("spacing_far_dist");
        spacing_horz_dist = ai::get_behavior_attribute("spacing_horz_dist");
        spacing_value = ai::get_behavior_attribute("spacing_value");
        to_enemy = behaviortreeentity.favoriteenemy.origin - behaviortreeentity.origin;
        perp = vectornormalize((to_enemy[1] * -1, to_enemy[0], 0));
        offset = perp * spacing_horz_dist * spacing_value;
        spacing_dist = math::clamp(length(to_enemy), spacing_near_dist, spacing_far_dist);
        lerp_amount = math::clamp((spacing_dist - spacing_near_dist) / (spacing_far_dist - spacing_near_dist), 0, 1);
        desired_point = last_valid_position + offset * lerp_amount;
        desired_point = getclosestpointonnavmesh(desired_point, spacing_horz_dist * 1.2, 16);
        if (isdefined(desired_point)) {
            locomotion_target = desired_point;
        }
    }
    return locomotion_target;
}

// Namespace namespace_1db6d2c9
// Params 1, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_df671f4d
// Checksum 0xae29f58e, Offset: 0x1308
// Size: 0x3c0
function zombiedogtargetservice(behaviortreeentity) {
    if (isdefined(level.intermission) && level.intermission) {
        behaviortreeentity clearpath();
        return;
    }
    /#
        if (isdefined(behaviortreeentity.ispuppet) && behaviortreeentity.ispuppet) {
            return;
        }
    #/
    if (isdefined(behaviortreeentity.favoriteenemy) && (behaviortreeentity.ignoreall || behaviortreeentity.pacifist || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy))) {
        if (isdefined(behaviortreeentity.favoriteenemy) && isdefined(behaviortreeentity.favoriteenemy.hunted_by) && behaviortreeentity.favoriteenemy.hunted_by > 0) {
            behaviortreeentity.favoriteenemy.hunted_by--;
        }
        behaviortreeentity.favoriteenemy = undefined;
        behaviortreeentity.hasseenfavoriteenemy = 0;
        if (!behaviortreeentity.ignoreall) {
            behaviortreeentity setgoal(behaviortreeentity.origin);
        }
        return;
    }
    if (isdefined(behaviortreeentity.ignoreme) && behaviortreeentity.ignoreme) {
        return;
    }
    if ((!sessionmodeiszombiesgame() || behaviortreeentity.team == "allies") && !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
        behaviortreeentity.favoriteenemy = get_favorite_enemy(behaviortreeentity);
    }
    if (!(isdefined(behaviortreeentity.hasseenfavoriteenemy) && behaviortreeentity.hasseenfavoriteenemy)) {
        if (isdefined(behaviortreeentity.favoriteenemy) && behaviortreeentity need_to_run()) {
            behaviortreeentity.hasseenfavoriteenemy = 1;
        }
    }
    if (isdefined(behaviortreeentity.favoriteenemy)) {
        if (isdefined(level.enemy_location_override_func)) {
            goalpos = [[ level.enemy_location_override_func ]](behaviortreeentity, behaviortreeentity.favoriteenemy);
            if (isdefined(goalpos)) {
                behaviortreeentity setgoal(goalpos);
                return;
            }
        }
        locomotion_target = get_locomotion_target(behaviortreeentity);
        if (isdefined(locomotion_target)) {
            repathdist = 16;
            if (!isdefined(behaviortreeentity.lasttargetposition) || distancesquared(behaviortreeentity.lasttargetposition, locomotion_target) > repathdist * repathdist || !behaviortreeentity haspath()) {
                behaviortreeentity useposition(locomotion_target);
                behaviortreeentity.lasttargetposition = locomotion_target;
            }
        }
    }
}

// Namespace namespace_1db6d2c9
// Params 1, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_5de7a022
// Checksum 0x8c4c8c99, Offset: 0x16d0
// Size: 0x1e8
function zombiedogshouldmelee(behaviortreeentity) {
    if (behaviortreeentity.ignoreall || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy)) {
        return false;
    }
    if (!(isdefined(level.intermission) && level.intermission)) {
        meleedist = 72;
        if (distancesquared(behaviortreeentity.origin, behaviortreeentity.favoriteenemy.origin) < meleedist * meleedist && behaviortreeentity cansee(behaviortreeentity.favoriteenemy)) {
            var_28ae2267 = behaviortreeentity.origin + (0, 0, 40);
            var_b6236d9d = behaviortreeentity.favoriteenemy geteye();
            clip_mask = 1 | 8;
            trace = physicstrace(var_28ae2267, var_b6236d9d, (0, 0, 0), (0, 0, 0), self, clip_mask);
            can_melee = isdefined(trace["entity"]) && (trace["fraction"] == 1 || trace["entity"] == behaviortreeentity.favoriteenemy);
            if (isdefined(can_melee) && can_melee) {
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_1db6d2c9
// Params 1, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_8a5696b5
// Checksum 0x3b6eac05, Offset: 0x18c0
// Size: 0x24
function zombiedogshouldwalk(behaviortreeentity) {
    return bb_getshouldrunstatus() == "walk";
}

// Namespace namespace_1db6d2c9
// Params 1, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_673b9825
// Checksum 0xa7ba0b7b, Offset: 0x18f0
// Size: 0x24
function zombiedogshouldrun(behaviortreeentity) {
    return bb_getshouldrunstatus() == "run";
}

// Namespace namespace_1db6d2c9
// Params 0, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_8a1a0018
// Checksum 0x515f4316, Offset: 0x1920
// Size: 0x166
function use_low_attack() {
    if (!isdefined(self.enemy) || !isplayer(self.enemy)) {
        return false;
    }
    height_diff = self.enemy.origin[2] - self.origin[2];
    low_enough = 30;
    if (height_diff < low_enough && self.enemy getstance() == "prone") {
        return true;
    }
    melee_origin = (self.origin[0], self.origin[1], self.origin[2] + 65);
    enemy_origin = (self.enemy.origin[0], self.enemy.origin[1], self.enemy.origin[2] + 32);
    if (!bullettracepassed(melee_origin, enemy_origin, 0, self)) {
        return true;
    }
    return false;
}

// Namespace namespace_1db6d2c9
// Params 2, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_bfe9b80f
// Checksum 0xc19e23dd, Offset: 0x1a90
// Size: 0xa0
function zombiedogmeleeaction(behaviortreeentity, asmstatename) {
    behaviortreeentity clearpath();
    context = "high";
    if (behaviortreeentity use_low_attack()) {
        context = "low";
    }
    blackboard::setblackboardattribute(behaviortreeentity, "_context", context);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace namespace_1db6d2c9
// Params 2, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_557ae3bc
// Checksum 0xe2f947dc, Offset: 0x1b38
// Size: 0x38
function zombiedogmeleeactionterminate(behaviortreeentity, asmstatename) {
    blackboard::setblackboardattribute(behaviortreeentity, "_context", undefined);
    return 4;
}

// Namespace namespace_1db6d2c9
// Params 4, eflags: 0x1 linked
// namespace_1db6d2c9<file_0>::function_bc8527ab
// Checksum 0x217e011f, Offset: 0x1b78
// Size: 0x44
function zombiedoggravity(entity, attribute, oldvalue, value) {
    blackboard::setblackboardattribute(entity, "_low_gravity", value);
}

