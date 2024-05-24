#using scripts/zm/_zm_powerups;
#using scripts/shared/ai/zombie_death;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm;
#using scripts/zm/_zm_spawner;
#using scripts/zm/archetype_zod_companion_interface;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/ai_squads;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/ai_blackboard;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/archetype_cover_utility;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;

#namespace archetype_zod_companion;

// Namespace archetype_zod_companion
// Params 0, eflags: 0x2
// Checksum 0x17284b84, Offset: 0xa08
// Size: 0xa4
function autoexec main() {
    clientfield::register("allplayers", "being_robot_revived", 1, 1, "int");
    spawner::add_archetype_spawn_function("zod_companion", &zodcompanionbehavior::archetypezodcompanionblackboardinit);
    spawner::add_archetype_spawn_function("zod_companion", &zodcompanionserverutils::zodcompanionsoldierspawnsetup);
    zodcompanioninterface::registerzodcompanioninterfaceattributes();
    zodcompanionbehavior::registerbehaviorscriptfunctions();
}

#namespace zodcompanionbehavior;

// Namespace zodcompanionbehavior
// Params 0, eflags: 0x0
// Checksum 0x436cef15, Offset: 0xab8
// Size: 0x2ac
function registerbehaviorscriptfunctions() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionTacticalWalkActionStart", &zodcompaniontacticalwalkactionstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionAbleToShoot", &zodcompanionabletoshootcondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionShouldTacticalWalk", &zodcompanionshouldtacticalwalk);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionMovement", &zodcompanionmovement);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionDelayMovement", &zodcompaniondelaymovement);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionSetDesiredStanceToStand", &zodcompanionsetdesiredstancetostand);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionFinishedSprintTransition", &zodcompanionfinishedsprinttransition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionSprintTransitioning", &zodcompanionsprinttransitioning);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionKeepsCurrentMovementMode", &zodcompanionkeepscurrentmovementmode);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionCanJuke", &zodcompanioncanjuke);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionCanPreemptiveJuke", &zodcompanioncanpreemptivejuke);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionJukeInitialize", &zodcompanionjukeinitialize);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionPreemptiveJukeTerminate", &zodcompanionpreemptivejuketerminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionTargetService", &zodcompaniontargetservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionTryReacquireService", &zodcompaniontryreacquireservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("manage_companion_movement", &manage_companion_movement);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionCollisionService", &zodcompanioncollisionservice);
}

// Namespace zodcompanionbehavior
// Params 5, eflags: 0x4
// Checksum 0x555de963, Offset: 0xd70
// Size: 0x7c
function private mocompignorepainfaceenemyinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.blockingpain = 1;
    entity orientmode("face enemy");
    entity animmode("pos deltas");
}

// Namespace zodcompanionbehavior
// Params 5, eflags: 0x4
// Checksum 0x483b0f5b, Offset: 0xdf8
// Size: 0x3c
function private mocompignorepainfaceenemyterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.blockingpain = 0;
}

// Namespace zodcompanionbehavior
// Params 0, eflags: 0x4
// Checksum 0x2becaace, Offset: 0xe40
// Size: 0x1a4
function private archetypezodcompanionblackboardinit() {
    entity = self;
    entity.pushable = 1;
    blackboard::createblackboardforentity(entity);
    ai::createinterfaceforentity(entity);
    entity aiutility::function_89e1fc16();
    blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_sprint", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("parasite");
        #/
    }
    blackboard::registerblackboardattribute(self, "_move_mode", "normal", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("left_leg_lower");
        #/
    }
    blackboard::registerblackboardattribute(self, "_gibbed_limbs", undefined, &function_c82dd93c);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("double_points");
        #/
    }
    /#
        entity finalizetrackedblackboardattributes();
    #/
}

// Namespace zodcompanionbehavior
// Params 0, eflags: 0x4
// Checksum 0x592af342, Offset: 0xff0
// Size: 0xa6
function private function_c82dd93c() {
    entity = self;
    rightarmgibbed = gibserverutils::isgibbed(entity, 16);
    leftarmgibbed = gibserverutils::isgibbed(entity, 32);
    if (rightarmgibbed && leftarmgibbed) {
        return "both_arms";
    } else if (rightarmgibbed) {
        return "right_arm";
    } else if (leftarmgibbed) {
        return "left_arm";
    }
    return "none";
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0x81c474f3, Offset: 0x10a0
// Size: 0x44
function private zodcompaniondelaymovement(entity) {
    entity pathmode("move delayed", 0, randomfloatrange(1, 2));
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0x97ffad11, Offset: 0x10f0
// Size: 0x5c
function private zodcompanionmovement(entity) {
    if (blackboard::getblackboardattribute(entity, "_stance") != "stand") {
        blackboard::setblackboardattribute(entity, "_desired_stance", "stand");
    }
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x0
// Checksum 0x4d3ca24a, Offset: 0x1158
// Size: 0x156
function zodcompanioncanjuke(entity) {
    if (!(isdefined(entity.steppedoutofcover) && entity.steppedoutofcover) && aiutility::canjuke(entity)) {
        jukeevents = blackboard::getblackboardevents("robot_juke");
        tooclosejukedistancesqr = 57600;
        foreach (event in jukeevents) {
            if (event.data.entity != entity && distance2dsquared(entity.origin, event.data.origin) <= tooclosejukedistancesqr) {
                return false;
            }
        }
        return true;
    }
    return false;
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x0
// Checksum 0x18865039, Offset: 0x12b8
// Size: 0x31e
function zodcompanioncanpreemptivejuke(entity) {
    if (!isdefined(entity.enemy) || !isplayer(entity.enemy)) {
        return 0;
    }
    if (blackboard::getblackboardattribute(entity, "_stance") == "crouch") {
        return 0;
    }
    if (!entity.shouldpreemptivejuke) {
        return 0;
    }
    if (isdefined(entity.nextpreemptivejuke) && entity.nextpreemptivejuke > gettime()) {
        return 0;
    }
    if (entity.enemy playerads() < entity.nextpreemptivejukeads) {
        return 0;
    }
    if (distancesquared(entity.origin, entity.enemy.origin) < 360000) {
        angledifference = absangleclamp180(entity.angles[1] - entity.enemy.angles[1]);
        /#
            record3dtext(angledifference, entity.origin + (0, 0, 5), (0, 1, 0), "<unknown string>");
        #/
        if (angledifference > -121) {
            enemyangles = entity.enemy getgunangles();
            toenemy = entity.enemy.origin - entity.origin;
            forward = anglestoforward(enemyangles);
            dotproduct = abs(vectordot(vectornormalize(toenemy), forward));
            /#
                record3dtext(acos(dotproduct), entity.origin + (0, 0, 10), (0, 1, 0), "<unknown string>");
            #/
            if (dotproduct > 0.9848) {
                return zodcompanioncanjuke(entity);
            }
        }
    }
    return 0;
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0xe9bbcb3d, Offset: 0x15e0
// Size: 0xae
function private _isvalidplayer(player) {
    if (!isdefined(player) || !isalive(player) || !isplayer(player) || player.sessionstate == "spectator" || player.sessionstate == "intermission" || player laststand::player_is_in_laststand() || player.ignoreme) {
        return false;
    }
    return true;
}

// Namespace zodcompanionbehavior
// Params 2, eflags: 0x4
// Checksum 0x84d9cf2a, Offset: 0x1698
// Size: 0x142
function private _findclosest(entity, entities) {
    closest = spawnstruct();
    if (entities.size > 0) {
        closest.entity = entities[0];
        closest.distancesquared = distancesquared(entity.origin, closest.entity.origin);
        for (index = 1; index < entities.size; index++) {
            distancesquared = distancesquared(entity.origin, entities[index].origin);
            if (distancesquared < closest.distancesquared) {
                closest.distancesquared = distancesquared;
                closest.entity = entities[index];
            }
        }
    }
    return closest;
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0x12b9842d, Offset: 0x17e8
// Size: 0x434
function private zodcompaniontargetservice(entity) {
    if (zodcompanionabletoshootcondition(entity)) {
        return 0;
    }
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    aienemies = [];
    playerenemies = [];
    ai = getaiarray();
    players = getplayers();
    positiononnavmesh = getclosestpointonnavmesh(entity.origin, -56);
    if (!isdefined(positiononnavmesh)) {
        return;
    }
    foreach (index, value in ai) {
        if (value.team != entity.team && isactor(value) && !isdefined(entity.favoriteenemy)) {
            enemypositiononnavmesh = getclosestpointonnavmesh(value.origin, -56);
            if (isdefined(enemypositiononnavmesh) && entity findpath(positiononnavmesh, enemypositiononnavmesh, 1, 0)) {
                aienemies[aienemies.size] = value;
            }
        }
    }
    foreach (value in players) {
        if (_isvalidplayer(value)) {
            enemypositiononnavmesh = getclosestpointonnavmesh(value.origin, -56);
            if (isdefined(enemypositiononnavmesh) && entity findpath(positiononnavmesh, enemypositiononnavmesh, 1, 0)) {
                playerenemies[playerenemies.size] = value;
            }
        }
    }
    closestplayer = _findclosest(entity, playerenemies);
    closestai = _findclosest(entity, aienemies);
    if (!isdefined(closestplayer.entity) && !isdefined(closestai.entity)) {
        return;
    }
    if (!isdefined(closestai.entity)) {
        entity.favoriteenemy = closestplayer.entity;
        return;
    }
    if (!isdefined(closestplayer.entity)) {
        entity.favoriteenemy = closestai.entity;
        return;
    }
    if (closestai.distancesquared < closestplayer.distancesquared) {
        entity.favoriteenemy = closestai.entity;
        return;
    }
    entity.favoriteenemy = closestplayer.entity;
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0xfd51892b, Offset: 0x1c28
// Size: 0x2c
function private zodcompaniontacticalwalkactionstart(entity) {
    entity orientmode("face enemy");
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0xebfc955b, Offset: 0x1c60
// Size: 0x54
function private zodcompanionabletoshootcondition(entity) {
    return entity.weapon.name != level.weaponnone.name && !gibserverutils::isgibbed(entity, 16);
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0xe4b8c005, Offset: 0x1cc0
// Size: 0x2e
function private zodcompanionshouldtacticalwalk(entity) {
    if (!entity haspath()) {
        return false;
    }
    return true;
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0xfc2fb338, Offset: 0x1cf8
// Size: 0xac
function private zodcompanionjukeinitialize(entity) {
    aiutility::choosejukedirection(entity);
    entity clearpath();
    jukeinfo = spawnstruct();
    jukeinfo.origin = entity.origin;
    jukeinfo.entity = entity;
    blackboard::addblackboardevent("robot_juke", jukeinfo, 2000);
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0xce04fbd1, Offset: 0x1db0
// Size: 0x68
function private zodcompanionpreemptivejuketerminate(entity) {
    entity.nextpreemptivejuke = gettime() + randomintrange(4000, 6000);
    entity.nextpreemptivejukeads = randomfloatrange(0.5, 0.95);
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0x913ad5f5, Offset: 0x1e20
// Size: 0x2f2
function private zodcompaniontryreacquireservice(entity) {
    if (!isdefined(entity.reacquire_state)) {
        entity.reacquire_state = 0;
    }
    if (!isdefined(entity.enemy)) {
        entity.reacquire_state = 0;
        return false;
    }
    if (entity haspath()) {
        return false;
    }
    if (!zodcompanionabletoshootcondition(entity)) {
        return false;
    }
    if (entity cansee(entity.enemy) && entity canshootenemy()) {
        entity.reacquire_state = 0;
        return false;
    }
    dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
    forward = anglestoforward(entity.angles);
    if (vectordot(dirtoenemy, forward) < 0.5) {
        entity.reacquire_state = 0;
        return false;
    }
    switch (entity.reacquire_state) {
    case 0:
    case 1:
    case 2:
        step_size = 32 + entity.reacquire_state * 32;
        reacquirepos = entity reacquirestep(step_size);
        break;
    case 4:
        if (!entity cansee(entity.enemy) || !entity canshootenemy()) {
            entity flagenemyunattackable();
        }
        break;
    default:
        if (entity.reacquire_state > 15) {
            entity.reacquire_state = 0;
            return false;
        }
        break;
    }
    if (isvec(reacquirepos)) {
        entity useposition(reacquirepos);
        return true;
    }
    entity.reacquire_state++;
    return false;
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0x34c7f7bf, Offset: 0x2120
// Size: 0x7a4
function private manage_companion_movement(entity) {
    self endon(#"death");
    if (isdefined(level.var_bfd9ed83) && level.var_bfd9ed83.eligible_leader) {
        self.leader = level.var_bfd9ed83;
    }
    if (!isdefined(entity.var_57e708f6)) {
        entity.var_57e708f6 = 0;
    }
    if (entity.bulletsinclip < entity.weapon.clipsize) {
        entity.bulletsinclip = entity.weapon.clipsize;
    }
    if (entity.reviving_a_player === 1) {
        return;
    }
    if (entity.time_expired === 1) {
        return;
    }
    if (entity.var_53ce2a4e === 1 || entity.teleporting === 1) {
        return;
    }
    if (entity.leader.teleporting === 1) {
        entity thread function_34117adf(entity.leader.teleport_location);
        return;
    }
    if (entity.var_c0e8df41 === 1) {
        return;
    }
    if (entity.leader.is_flung === 1) {
        entity thread function_3463b8c2(entity.leader.var_fa1ecd39);
    }
    foreach (player in level.players) {
        if (player laststand::player_is_in_laststand() && entity.reviving_a_player === 0 && player.revivetrigger.beingrevived !== 1) {
            time = gettime();
            if (distancesquared(entity.origin, player.origin) <= 1024 * 1024 && time >= entity.var_57e708f6) {
                entity.reviving_a_player = 1;
                entity zod_companion_revive_player(player);
                return;
            }
        }
    }
    if (!isdefined(entity.var_a0c5deb2)) {
        entity.var_a0c5deb2 = gettime();
    }
    if (gettime() >= entity.var_a0c5deb2 && isdefined(level.active_powerups) && level.active_powerups.size > 0) {
        if (!isdefined(entity.var_34a9f1ad)) {
            entity.var_34a9f1ad = 0;
        }
        foreach (powerup in level.active_powerups) {
            if (isinarray(entity.var_fb400bf7, powerup.powerup_name)) {
                dist = distancesquared(entity.origin, powerup.origin);
                if (dist <= 147456 && randomint(100) < 50 + 10 * entity.var_34a9f1ad) {
                    entity setgoal(powerup.origin, 1);
                    entity.var_a0c5deb2 = gettime() + randomintrange(2500, 3500);
                    entity.next_move_time = gettime() + randomintrange(2500, 3500);
                    entity.var_34a9f1ad = 0;
                    return;
                }
                entity.var_34a9f1ad += 1;
            }
        }
        entity.var_a0c5deb2 = gettime() + randomintrange(333, 666);
    }
    follow_radius_squared = 256 * 256;
    if (isdefined(entity.leader)) {
        entity.companion_anchor_point = entity.leader.origin;
    }
    if (isdefined(entity.pathgoalpos)) {
        dist_check_start_point = entity.pathgoalpos;
    } else {
        dist_check_start_point = entity.origin;
    }
    if (isdefined(entity.enemy) && entity.enemy.archetype == "parasite") {
        height_difference = abs(entity.origin[2] - entity.enemy.origin[2]);
        var_3b804002 = 1.5 * height_difference * 1.5 * height_difference;
        if (distancesquared(dist_check_start_point, entity.enemy.origin) < var_3b804002) {
            entity pick_new_movement_point();
        }
    }
    if (distancesquared(dist_check_start_point, entity.companion_anchor_point) > follow_radius_squared || distancesquared(dist_check_start_point, entity.companion_anchor_point) < 4096) {
        entity pick_new_movement_point();
    }
    if (gettime() >= entity.next_move_time) {
        entity pick_new_movement_point();
    }
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0xf33e182, Offset: 0x28d0
// Size: 0x1d6
function private zodcompanioncollisionservice(entity) {
    if (isdefined(entity.dontpushtime)) {
        if (gettime() < entity.dontpushtime) {
            return true;
        }
    }
    var_5558b624 = 0;
    zombies = getaiteamarray(level.zombie_team);
    foreach (zombie in zombies) {
        if (zombie == entity) {
            continue;
        }
        dist_sq = distancesquared(entity.origin, zombie.origin);
        if (dist_sq < 14400) {
            if (isdefined(zombie.cant_move) && zombie.cant_move) {
                zombie thread function_d04291cf();
                var_5558b624 = 1;
            }
        }
    }
    if (var_5558b624) {
        entity function_1762804b(0);
        entity.dontpushtime = gettime() + 2000;
        return true;
    }
    entity function_1762804b(1);
    return false;
}

// Namespace zodcompanionbehavior
// Params 0, eflags: 0x4
// Checksum 0xf5317ee6, Offset: 0x2ab0
// Size: 0x44
function private function_d04291cf() {
    self endon(#"death");
    self function_1762804b(0);
    wait(2);
    self function_1762804b(1);
}

// Namespace zodcompanionbehavior
// Params 2, eflags: 0x4
// Checksum 0x80851c4, Offset: 0x2b00
// Size: 0x13e
function private function_f62bd05c(target_entity, max_distance) {
    entity = self;
    target_location = target_entity.origin;
    if (distancesquared(entity.origin, target_location) > max_distance * max_distance) {
        return false;
    }
    path = entity calcapproximatepathtoposition(target_location);
    segmentlength = 0;
    for (index = 1; index < path.size; index++) {
        currentseglength = distance(path[index - 1], path[index]);
        if (currentseglength + segmentlength > max_distance) {
            return false;
        }
        segmentlength += currentseglength;
    }
    return true;
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0x4509f5f1, Offset: 0x2c48
// Size: 0x50
function private function_34117adf(var_5935e1b9) {
    self.var_53ce2a4e = 1;
    self setgoal(var_5935e1b9, 1);
    self waittill(#"goal");
    wait(1);
    self.var_53ce2a4e = 0;
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0x9b0a229, Offset: 0x2ca0
// Size: 0xb0
function private function_3463b8c2(var_ee6ad78e) {
    self.var_c0e8df41 = 1;
    var_c9277d64 = getnodearray("flinger_traversal", "script_noteworthy");
    var_292fba5b = arraygetclosest(var_ee6ad78e, var_c9277d64);
    self setgoal(var_292fba5b.origin, 1);
    self waittill(#"goal");
    wait(1);
    self.var_c0e8df41 = 0;
}

// Namespace zodcompanionbehavior
// Params 0, eflags: 0x4
// Checksum 0x55ff1ae9, Offset: 0x2d58
// Size: 0x1cc
function private pick_new_movement_point() {
    queryresult = positionquery_source_navigation(self.companion_anchor_point, 96, 256, 256, 20, self);
    if (queryresult.data.size) {
        if (isdefined(self.enemy) && self.enemy.archetype == "parasite") {
            array::filter(queryresult.data, 0, &function_ab299a53, self.enemy);
        }
    }
    if (queryresult.data.size) {
        point = queryresult.data[randomint(queryresult.data.size)];
        pathsuccess = self findpath(self.origin, point.origin, 1, 0);
        if (pathsuccess) {
            self.companion_destination = point.origin;
        } else {
            self.next_move_time = gettime() + randomintrange(500, 1500);
            return;
        }
    }
    self setgoal(self.companion_destination, 1);
    self.next_move_time = gettime() + randomintrange(20000, 30000);
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0x9511e5c1, Offset: 0x2f30
// Size: 0xb8
function private function_ab299a53(parasite) {
    point = self;
    height_difference = abs(point.origin[2] - parasite.origin[2]);
    var_3b804002 = 1.5 * height_difference * 1.5 * height_difference;
    return distancesquared(point.origin, parasite.origin) > var_3b804002;
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0xaf0d314, Offset: 0x2ff0
// Size: 0x6c
function private zodcompanionsetdesiredstancetostand(behaviortreeentity) {
    currentstance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
    if (currentstance == "crouch") {
        blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
    }
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x0
// Checksum 0x22d4e3c4, Offset: 0x3068
// Size: 0x3e4
function zod_companion_revive_player(player) {
    self endon(#"revive_terminated");
    self endon(#"end_game");
    if (!(isdefined(self.reviving_a_player) && self.reviving_a_player)) {
        self.reviving_a_player = 1;
    }
    player.being_revived_by_robot = 0;
    self thread zod_companion_monitor_revive_attempt(player);
    self.ignoreall = 1;
    queryresult = positionquery_source_navigation(player.origin, 64, 96, 48, 18, self);
    if (queryresult.data.size) {
        point = queryresult.data[randomint(queryresult.data.size)];
        self.companion_destination = point.origin;
    }
    self setgoal(self.companion_destination, 1);
    self waittill(#"goal");
    level.var_46040f3e = 1;
    player.revivetrigger.beingrevived = 1;
    player.being_revived_by_robot = 1;
    vector = vectornormalize(player.origin - self.origin);
    angles = vectortoangles(vector);
    self teleport(self.origin, angles);
    self thread animation::play("ai_robot_base_stn_exposed_revive", self, angles, 1.5);
    wait(0.67);
    player clientfield::set("being_robot_revived", 1);
    self waittill(#"robot_revive_complete");
    if (level.players.size == 1 && level flag::get("solo_game")) {
        self.var_57e708f6 = gettime() + 10000;
    } else {
        self.var_57e708f6 = gettime() + 5000;
    }
    player notify(#"stop_revive_trigger");
    if (isplayer(player)) {
        player allowjump(1);
    }
    player.laststand = undefined;
    player thread zm_laststand::revive_success(self, 0);
    level.var_46040f3e = 0;
    players = getplayers();
    if (isdefined(player.waiting_to_revive) && players.size == 1 && level flag::get("solo_game") && player.waiting_to_revive) {
        level.solo_game_free_player_quickrevive = 1;
        player thread zm_perks::give_perk("specialty_quickrevive", 0);
    }
    self zod_companion_revive_cleanup(player);
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x0
// Checksum 0xde5afc7a, Offset: 0x3458
// Size: 0xd8
function zod_companion_monitor_revive_attempt(player) {
    self endon(#"revive_terminated");
    while (true) {
        if (isdefined(player.revivetrigger) && player.revivetrigger.beingrevived === 1 && player.being_revived_by_robot !== 1) {
            self zod_companion_revive_cleanup(player);
        }
        if (!(isdefined(player laststand::player_is_in_laststand()) && player laststand::player_is_in_laststand())) {
            self zod_companion_revive_cleanup(player);
        }
        wait(0.05);
    }
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x0
// Checksum 0xee5c154b, Offset: 0x3538
// Size: 0x82
function zod_companion_revive_cleanup(player) {
    self.ignoreall = 0;
    self.reviving_a_player = 0;
    if (isdefined(player)) {
        if (player.being_revived_by_robot == 1) {
            player.being_revived_by_robot = 0;
        }
        player clientfield::set("being_robot_revived", 0);
    }
    self notify(#"revive_terminated");
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0x9eb06be3, Offset: 0x35c8
// Size: 0xdc
function private zodcompanionfinishedsprinttransition(behaviortreeentity) {
    behaviortreeentity.sprint_transition_happening = 0;
    if (blackboard::getblackboardattribute(behaviortreeentity, "_locomotion_speed") == "locomotion_speed_walk") {
        behaviortreeentity ai::set_behavior_attribute("sprint", 1);
        blackboard::setblackboardattribute(behaviortreeentity, "_locomotion_speed", "locomotion_speed_sprint");
        return;
    }
    behaviortreeentity ai::set_behavior_attribute("sprint", 0);
    blackboard::setblackboardattribute(behaviortreeentity, "_locomotion_speed", "locomotion_speed_walk");
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0x587d468e, Offset: 0x36b0
// Size: 0xe0
function private zodcompanionkeepscurrentmovementmode(behaviortreeentity) {
    var_ef42515b = 262144;
    var_1be8672c = 147456;
    dist = distancesquared(behaviortreeentity.origin, behaviortreeentity.companion_anchor_point);
    if (dist > var_ef42515b && blackboard::getblackboardattribute(behaviortreeentity, "_locomotion_speed") == "locomotion_speed_walk") {
        return false;
    }
    if (dist < var_1be8672c && blackboard::getblackboardattribute(behaviortreeentity, "_locomotion_speed") == "locomotion_speed_sprint") {
        return false;
    }
    return true;
}

// Namespace zodcompanionbehavior
// Params 1, eflags: 0x4
// Checksum 0x5188172f, Offset: 0x3798
// Size: 0x2c
function private zodcompanionsprinttransitioning(behaviortreeentity) {
    if (behaviortreeentity.sprint_transition_happening === 1) {
        return true;
    }
    return false;
}

#namespace zodcompanionserverutils;

// Namespace zodcompanionserverutils
// Params 4, eflags: 0x4
// Checksum 0x22882d2e, Offset: 0x37d0
// Size: 0x134
function private _trygibbinghead(entity, damage, hitloc, isexplosive) {
    if (isexplosive && randomfloatrange(0, 1) <= 0.5) {
        gibserverutils::gibhead(entity);
        return;
    }
    if (isinarray(array("head", "neck", "helmet"), hitloc) && randomfloatrange(0, 1) <= 1) {
        gibserverutils::gibhead(entity);
        return;
    }
    if (entity.health - damage <= 0 && randomfloatrange(0, 1) <= 0.25) {
        gibserverutils::gibhead(entity);
    }
}

// Namespace zodcompanionserverutils
// Params 4, eflags: 0x4
// Checksum 0xd648e8bf, Offset: 0x3910
// Size: 0x27c
function private _trygibbinglimb(entity, damage, hitloc, isexplosive) {
    if (gibserverutils::isgibbed(entity, 32) || gibserverutils::isgibbed(entity, 16)) {
        return;
    }
    if (isexplosive && randomfloatrange(0, 1) <= 0.25) {
        if (entity.health - damage <= 0 && entity.allowdeath && math::cointoss()) {
            gibserverutils::gibrightarm(entity);
        } else {
            gibserverutils::gibleftarm(entity);
        }
        return;
    }
    if (isinarray(array("left_hand", "left_arm_lower", "left_arm_upper"), hitloc)) {
        gibserverutils::gibleftarm(entity);
        return;
    }
    if (entity.health - damage <= 0 && entity.allowdeath && isinarray(array("right_hand", "right_arm_lower", "right_arm_upper"), hitloc)) {
        gibserverutils::gibrightarm(entity);
        return;
    }
    if (entity.health - damage <= 0 && entity.allowdeath && randomfloatrange(0, 1) <= 0.25) {
        if (math::cointoss()) {
            gibserverutils::gibleftarm(entity);
            return;
        }
        gibserverutils::gibrightarm(entity);
    }
}

// Namespace zodcompanionserverutils
// Params 5, eflags: 0x4
// Checksum 0xf06301e, Offset: 0x3b98
// Size: 0x37c
function private _trygibbinglegs(entity, damage, hitloc, isexplosive, attacker) {
    if (!isdefined(attacker)) {
        attacker = entity;
    }
    cangiblegs = entity.health - damage <= 0 && entity.allowdeath;
    cangiblegs = (entity.health - damage) / entity.maxhealth <= 0.25 && distancesquared(entity.origin, attacker.origin) <= 360000 && (cangiblegs || entity.allowdeath);
    if (entity.health - damage <= 0 && entity.allowdeath && isexplosive && randomfloatrange(0, 1) <= 0.5) {
        gibserverutils::giblegs(entity);
        entity startragdoll();
        return;
    }
    if (cangiblegs && isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), hitloc) && randomfloatrange(0, 1) <= 1) {
        if (entity.health - damage > 0) {
            entity.becomecrawler = 1;
        }
        gibserverutils::gibleftleg(entity);
        return;
    }
    if (cangiblegs && isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), hitloc) && randomfloatrange(0, 1) <= 1) {
        if (entity.health - damage > 0) {
            entity.becomecrawler = 1;
        }
        gibserverutils::gibrightleg(entity);
        return;
    }
    if (entity.health - damage <= 0 && entity.allowdeath && randomfloatrange(0, 1) <= 0.25) {
        if (math::cointoss()) {
            gibserverutils::gibleftleg(entity);
            return;
        }
        gibserverutils::gibrightleg(entity);
    }
}

// Namespace zodcompanionserverutils
// Params 12, eflags: 0x4
// Checksum 0xb8358657, Offset: 0x3f20
// Size: 0x190
function private zodcompaniongibdamageoverride(inflictor, attacker, damage, flags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity = self;
    if ((entity.health - damage) / entity.maxhealth > 0.75) {
        return damage;
    }
    gibserverutils::togglespawngibs(entity, 1);
    isexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTIVLE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
    _trygibbinghead(entity, damage, hitloc, isexplosive);
    _trygibbinglimb(entity, damage, hitloc, isexplosive);
    _trygibbinglegs(entity, damage, hitloc, isexplosive, attacker);
    return damage;
}

// Namespace zodcompanionserverutils
// Params 12, eflags: 0x4
// Checksum 0x75dca24c, Offset: 0x40b8
// Size: 0x230
function private zodcompaniondestructdeathoverride(inflictor, attacker, damage, flags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity = self;
    if (entity.health - damage <= 0) {
        destructserverutils::togglespawngibs(entity, 1);
        piececount = destructserverutils::getpiececount(entity);
        possiblepieces = [];
        for (index = 1; index <= piececount; index++) {
            if (!destructserverutils::isdestructed(entity, index) && randomfloatrange(0, 1) <= 0.2) {
                possiblepieces[possiblepieces.size] = index;
            }
        }
        gibbedpieces = 0;
        for (index = 0; index < possiblepieces.size && possiblepieces.size > 1 && gibbedpieces < 2; index++) {
            randompiece = randomintrange(0, possiblepieces.size - 1);
            if (!destructserverutils::isdestructed(entity, possiblepieces[randompiece])) {
                destructserverutils::destructpiece(entity, possiblepieces[randompiece]);
                gibbedpieces++;
            }
        }
    }
    return damage;
}

// Namespace zodcompanionserverutils
// Params 12, eflags: 0x4
// Checksum 0xfd7b7316, Offset: 0x42f0
// Size: 0xcc
function private zodcompaniondamageoverride(inflictor, attacker, damage, flags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity = self;
    if (hitloc == "helmet" || hitloc == "head" || hitloc == "neck") {
        damage = int(damage * 0.5);
    }
    return damage;
}

// Namespace zodcompanionserverutils
// Params 1, eflags: 0x4
// Checksum 0xb8ef9671, Offset: 0x43c8
// Size: 0x84
function private findclosestnavmeshpositiontoenemy(enemy) {
    enemypositiononnavmesh = undefined;
    for (tolerancelevel = 1; tolerancelevel <= 4; tolerancelevel++) {
        enemypositiononnavmesh = getclosestpointonnavmesh(enemy.origin, -56 * tolerancelevel);
        if (isdefined(enemypositiononnavmesh)) {
            break;
        }
    }
    return enemypositiononnavmesh;
}

// Namespace zodcompanionserverutils
// Params 0, eflags: 0x4
// Checksum 0xdc58d726, Offset: 0x4458
// Size: 0x254
function private zodcompanionsoldierspawnsetup() {
    entity = self;
    entity.combatmode = "cover";
    entity.fullhealth = entity.health;
    entity.controllevel = 0;
    entity.steppedoutofcover = 0;
    entity.startingweapon = entity.weapon;
    entity.jukedistance = 90;
    entity.jukemaxdistance = 600;
    entity.entityradius = 15;
    entity.base_accuracy = entity.accuracy;
    entity.highlyawareradius = 256;
    entity.treatallcoversasgeneric = 1;
    entity.onlycroucharrivals = 1;
    entity.nextpreemptivejukeads = randomfloatrange(0.5, 0.95);
    entity.shouldpreemptivejuke = math::cointoss();
    entity.reviving_a_player = 0;
    aiutility::addaioverridedamagecallback(entity, &destructserverutils::handledamage);
    aiutility::addaioverridedamagecallback(entity, &zodcompaniondamageoverride);
    aiutility::addaioverridedamagecallback(entity, &zodcompaniongibdamageoverride);
    entity.companion_anchor_point = entity.origin;
    entity.next_move_time = gettime();
    entity.allow_zombie_to_target_ai = 1;
    entity.ignoreme = 1;
    entity thread zodcompanionutility::function_cbe73e3d();
    entity thread zodcompanionutility::manage_companion();
}

#namespace zodcompanionutility;

// Namespace zodcompanionutility
// Params 0, eflags: 0x0
// Checksum 0xabe66e86, Offset: 0x46b8
// Size: 0x68
function manage_companion() {
    self endon(#"death");
    while (true) {
        if (!self.reviving_a_player) {
            if (!isdefined(self.leader) || !self.leader.eligible_leader) {
                self define_new_leader();
            }
        }
        wait(0.5);
    }
}

// Namespace zodcompanionutility
// Params 0, eflags: 0x0
// Checksum 0x61d92885, Offset: 0x4728
// Size: 0x9a
function function_cbe73e3d() {
    self.var_fb400bf7 = [];
    self.var_fb400bf7[0] = "double_points";
    self.var_fb400bf7[1] = "fire_sale";
    self.var_fb400bf7[2] = "insta_kill";
    self.var_fb400bf7[3] = "nuke";
    self.var_fb400bf7[4] = "full_ammo";
    self.var_fb400bf7[5] = "insta_kill_ug";
}

// Namespace zodcompanionutility
// Params 0, eflags: 0x0
// Checksum 0x957cfc4b, Offset: 0x47d0
// Size: 0x166
function define_new_leader() {
    if (isdefined(level.var_bfd9ed83) && level.var_bfd9ed83.eligible_leader) {
        self.leader = level.var_bfd9ed83;
        return;
    }
    a_potential_leaders = get_potential_leaders(self);
    closest_leader = undefined;
    closest_distance = 1000000;
    if (a_potential_leaders.size == 0) {
        self.leader = undefined;
        return;
    }
    foreach (potential_leader in a_potential_leaders) {
        dist = pathdistance(self.origin, potential_leader.origin);
        if (isdefined(dist) && dist < closest_distance) {
            closest_distance = dist;
            self.leader = potential_leader;
        }
    }
}

// Namespace zodcompanionutility
// Params 1, eflags: 0x0
// Checksum 0x148dc9ba, Offset: 0x4940
// Size: 0x122
function get_potential_leaders(companion) {
    a_potential_leaders = [];
    foreach (player in level.players) {
        if (!isdefined(player.eligible_leader)) {
            player.eligible_leader = 1;
        }
        if (isdefined(player.eligible_leader) && player.eligible_leader && companion findpath(companion.origin, player.origin)) {
            a_potential_leaders[a_potential_leaders.size] = player;
        }
    }
    return a_potential_leaders;
}

