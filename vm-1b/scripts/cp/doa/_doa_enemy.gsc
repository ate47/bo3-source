#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_arena;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_gibs;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_utility;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace doa_enemy;

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0x2c6c1932, Offset: 0x840
// Size: 0x22
function init() {
    level registerdefaultnotetrackhandlerfunctions();
    level registerbehaviorscriptfunctions();
}

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x870
// Size: 0x2
function registerdefaultnotetrackhandlerfunctions() {
    
}

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0x2d01dc8f, Offset: 0x880
// Size: 0x232
function registerbehaviorscriptfunctions() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("doaUpdateToGoal", &doaUpdateToGoal);
    behaviortreenetworkutility::registerbehaviortreescriptapi("doaUpdateSilverbackGoal", &doaUpdateSilverbackGoal);
    behaviortreenetworkutility::registerbehaviortreescriptapi("doaActorShouldMelee", &function_f31da0d1);
    behaviortreenetworkutility::registerbehaviortreescriptapi("doaActorShouldMove", &function_d597e3fc);
    behaviortreenetworkutility::registerbehaviortreescriptapi("doaSilverbackShouldMove", &function_323b0769);
    behaviortreenetworkutility::registerbehaviortreeaction("doaMeleeAction", &doaLocomotionDeathAction, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreeaction("doaZombieMoveAction", undefined, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreeaction("doaZombieIdleAction", undefined, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreeaction("doaLocomotionDeathAction", &doaLocomotionDeathAction, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreeaction("doavoidAction", undefined, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreeaction("zombieTraverseAction", &zombietraverseaction, undefined, &zombietraverseactionterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("doaZombieTraversalDoesAnimationExist", &doaZombieTraversalDoesAnimationExist);
    behaviortreenetworkutility::registerbehaviortreeaction("doaSpecialTraverseAction", &function_34a5b8e4, undefined, &function_f821465d);
    animationstatenetwork::registeranimationmocomp("mocomp_doa_special_traversal", &function_e57c0c7b, undefined, &function_c97089da);
}

// Namespace doa_enemy
// Params 1, eflags: 0x4
// Checksum 0xb5b1005c, Offset: 0xac0
// Size: 0x8d
function private doaZombieTraversalDoesAnimationExist(entity) {
    if (entity.missinglegs === 1) {
        var_be841c75 = entity astsearch(istring("traverse_legless@zombie"));
    } else {
        var_be841c75 = entity astsearch(istring("traverse@zombie"));
    }
    if (isdefined(var_be841c75["animation"])) {
        return true;
    }
    return false;
}

// Namespace doa_enemy
// Params 2, eflags: 0x4
// Checksum 0xb7d2e78d, Offset: 0xb58
// Size: 0x44
function private function_34a5b8e4(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    entity ghost();
    entity notsolid();
    return 5;
}

// Namespace doa_enemy
// Params 2, eflags: 0x4
// Checksum 0x4fb14deb, Offset: 0xba8
// Size: 0x34
function private function_f821465d(entity, asmstatename) {
    entity show();
    entity solid();
    return 4;
}

// Namespace doa_enemy
// Params 5, eflags: 0x4
// Checksum 0x349cb39b, Offset: 0xbe8
// Size: 0x14e
function private function_e57c0c7b(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity setrepairpaths(0);
    locomotionspeed = blackboard::getblackboardattribute(entity, "_locomotion_speed");
    if (locomotionspeed == "locomotion_speed_walk") {
        rate = 1;
    } else if (locomotionspeed == "locomotion_speed_run") {
        rate = 2;
    } else {
        rate = 3;
    }
    entity asmsetanimationrate(rate);
    if (entity haspath()) {
        entity.var_51ea7126 = entity.pathgoalpos;
    }
    assert(isdefined(entity.traverseendnode));
    entity forceteleport(entity.traverseendnode.origin, entity.angles);
    entity animmode("noclip", 0);
    entity.blockingpain = 1;
}

// Namespace doa_enemy
// Params 5, eflags: 0x4
// Checksum 0x4bf3582f, Offset: 0xd40
// Size: 0x92
function private function_c97089da(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.blockingpain = 0;
    entity setrepairpaths(1);
    if (isdefined(entity.var_51ea7126)) {
        entity setgoal(entity.var_51ea7126);
    }
    entity asmsetanimationrate(1);
    entity finishtraversal();
}

// Namespace doa_enemy
// Params 2, eflags: 0x0
// Checksum 0x69c0bbba, Offset: 0xde0
// Size: 0x24
function zombietraverseaction(behaviortreeentity, asmstatename) {
    aiutility::traverseactionstart(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace doa_enemy
// Params 2, eflags: 0x0
// Checksum 0xb6ab1eaf, Offset: 0xe10
// Size: 0x14
function zombietraverseactionterminate(behaviortreeentity, asmstatename) {
    return 4;
}

// Namespace doa_enemy
// Params 2, eflags: 0x0
// Checksum 0xd7323838, Offset: 0xe30
// Size: 0x22
function function_293af6de(animationentity, asmstatename) {
    animationentity melee();
}

// Namespace doa_enemy
// Params 2, eflags: 0x0
// Checksum 0x50b136e8, Offset: 0xe60
// Size: 0x24
function doaLocomotionDeathAction(behaviortreeentity, asmstatename) {
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace doa_enemy
// Params 2, eflags: 0x0
// Checksum 0x86d92dd6, Offset: 0xe90
// Size: 0x12a
function function_d30fe558(origin, force) {
    if (!isdefined(force)) {
        force = 0;
    }
    if (!isdefined(self.var_99315107)) {
        self.var_99315107 = 0;
    }
    if (force) {
        self.var_99315107 = 0;
    }
    time = gettime();
    var_bea0505e = time > self.var_99315107;
    distsq = distancesquared(self.origin, origin);
    if (distsq < -128 * -128) {
        var_bea0505e = 1;
    }
    if (var_bea0505e) {
        self setgoal(origin, 1);
        frac = math::clamp(distsq / 1000 * 1000, 0, 1);
        if (isdefined(self.zombie_move_speed)) {
            if (isdefined(self.missinglegs) && (self.zombie_move_speed == "walk" || self.missinglegs)) {
                frac += 0.2;
            }
        }
        self.var_99315107 = time + int(frac * 1600);
    }
}

// Namespace doa_enemy
// Params 1, eflags: 0x0
// Checksum 0x27565c2e, Offset: 0xfc8
// Size: 0x45a
function function_b0edb6ef(var_12ebe63d) {
    aiprofile_beginentry("zombieUpdateZigZagGoal");
    shouldrepath = 0;
    if (!shouldrepath && isdefined(self.enemy)) {
        if (!isdefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
            shouldrepath = 1;
        } else if (distancesquared(self.origin, self.enemy.origin) <= -56 * -56) {
            shouldrepath = 1;
        } else if (isdefined(self.pathgoalpos)) {
            distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
            shouldrepath = distancetogoalsqr < 72 * 72;
        }
    }
    if (isdefined(self.keep_moving) && self.keep_moving) {
        if (gettime() > self.keep_moving_time) {
            self.keep_moving = 0;
        }
    }
    if (shouldrepath) {
        goalpos = var_12ebe63d;
        self setgoal(goalpos);
        if (distancesquared(self.origin, goalpos) > -56 * -56) {
            self.keep_moving = 1;
            self.keep_moving_time = gettime() + -6;
            path = self calcapproximatepathtoposition(goalpos, 0);
            /#
                if (getdvarint("<dev string:x28>")) {
                    for (index = 1; index < path.size; index++) {
                        recordline(path[index - 1], path[index], (1, 0.5, 0), "<dev string:x37>", self);
                    }
                }
            #/
            if (isdefined(level._zombiezigzagdistancemin) && isdefined(level._zombiezigzagdistancemax)) {
                min = level._zombiezigzagdistancemin;
                max = level._zombiezigzagdistancemax;
            } else {
                min = 600;
                max = 900;
            }
            deviationdistance = randomintrange(min, max);
            segmentlength = 0;
            for (index = 1; index < path.size; index++) {
                currentseglength = distance(path[index - 1], path[index]);
                if (segmentlength + currentseglength > deviationdistance) {
                    remaininglength = deviationdistance - segmentlength;
                    seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;
                    /#
                        recordcircle(seedposition, 2, (1, 0.5, 0), "<dev string:x37>", self);
                    #/
                    innerzigzagradius = 0;
                    outerzigzagradius = -56;
                    queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 0.5 * 72, 16, self, 16);
                    positionquery_filter_inclaimedlocation(queryresult, self);
                    if (queryresult.data.size > 0) {
                        point = queryresult.data[randomint(queryresult.data.size)];
                        self function_d30fe558(point.origin, 1);
                    }
                    break;
                }
                segmentlength += currentseglength;
            }
        }
        if (isdefined(level._zombiezigzagtimemin) && isdefined(level._zombiezigzagtimemax)) {
            mintime = level._zombiezigzagtimemin;
            maxtime = level._zombiezigzagtimemax;
        } else {
            mintime = 3500;
            maxtime = 5500;
        }
        self.nextgoalupdate = gettime() + randomintrange(mintime, maxtime);
    }
    aiprofile_endentry();
}

// Namespace doa_enemy
// Params 1, eflags: 0x0
// Checksum 0xd4384f86, Offset: 0x1430
// Size: 0x46e
function doaUpdateToGoal(behaviortreeentity) {
    if (level flag::get("doa_game_is_over")) {
        behaviortreeentity function_d30fe558(behaviortreeentity.origin);
        return true;
    }
    if (isdefined(behaviortreeentity.doa) && behaviortreeentity.doa.stunned != 0) {
        if (!(isdefined(behaviortreeentity.doa.var_da2f5272) && behaviortreeentity.doa.var_da2f5272)) {
            behaviortreeentity function_d30fe558(behaviortreeentity.doa.original_origin, behaviortreeentity.doa.stunned == 1);
            behaviortreeentity.doa.stunned = 2;
        } else {
            behaviortreeentity function_d30fe558(behaviortreeentity.origin);
        }
        return true;
    }
    if (isdefined(behaviortreeentity.var_8f12ed02)) {
        behaviortreeentity function_d30fe558(behaviortreeentity.var_8f12ed02);
        return true;
    }
    if (!(isdefined(behaviortreeentity.var_2d8174e3) && behaviortreeentity.var_2d8174e3)) {
        poi = namespace_49107f3a::function_1acb8a7c(behaviortreeentity.origin, level.doa.rules.var_187f2874);
        if (isdefined(poi)) {
            behaviortreeentity.doa.poi = poi;
            if (isdefined(poi.var_111c7bbb)) {
                behaviortreeentity function_d30fe558(poi.var_111c7bbb);
            } else {
                behaviortreeentity function_d30fe558(poi.origin);
            }
            return true;
        }
    }
    if (isdefined(behaviortreeentity.enemy)) {
        time = gettime();
        if (!isdefined(self.var_dc3adfc7)) {
            self.var_dc3adfc7 = 0;
        }
        if (time > self.var_dc3adfc7) {
            self.var_dc3adfc7 = time + -6;
            closest = namespace_831a4a7c::function_35f36dec(self.origin);
            if (isdefined(closest) && behaviortreeentity.enemy != closest) {
                distsq = distancesquared(closest.origin, self.origin);
                if (distsq <= -128 * -128) {
                    behaviortreeentity.favoriteenemy = closest;
                }
            }
        }
        origin = behaviortreeentity function_69b8254();
        point = getclosestpointonnavmesh(origin, 20, 16);
        if (isdefined(point)) {
            behaviortreeentity.lastknownenemypos = origin;
            if (getdvarint("scr_doa_zigzag_enabled", 0)) {
                behaviortreeentity function_b0edb6ef(behaviortreeentity.lastknownenemypos);
            }
        } else {
            point = getclosestpointonnavmesh(origin, 40, 8);
            if (isdefined(point)) {
                behaviortreeentity.lastknownenemypos = point;
                origin = point;
            } else if (isdefined(behaviortreeentity.lastknownenemypos)) {
                origin = behaviortreeentity.lastknownenemypos;
            }
        }
        behaviortreeentity function_d30fe558(origin);
        return true;
    } else {
        players = getplayers();
        foreach (player in players) {
            if (!isdefined(player.doa)) {
                continue;
            }
            if (!isalive(player)) {
                continue;
            }
            behaviortreeentity.favoriteenemy = player;
            behaviortreeentity function_d30fe558(behaviortreeentity.favoriteenemy.origin, 1);
            return true;
        }
        if (isdefined(behaviortreeentity.lastknownenemypos)) {
            behaviortreeentity function_d30fe558(behaviortreeentity.lastknownenemypos);
            return true;
        }
    }
    return false;
}

// Namespace doa_enemy
// Params 1, eflags: 0x0
// Checksum 0x9207c2e, Offset: 0x18a8
// Size: 0x181
function doaUpdateSilverbackGoal(behaviortreeentity) {
    if (isdefined(behaviortreeentity.var_88168473) && behaviortreeentity.var_88168473) {
        return false;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        behaviortreeentity.favoriteenemy = behaviortreeentity.enemy;
        origin = behaviortreeentity function_69b8254();
        point = getclosestpointonnavmesh(origin, 20, 16);
        if (isdefined(point)) {
            behaviortreeentity.lastknownenemypos = origin;
        } else {
            point = getclosestpointonnavmesh(origin, 40, 8);
            if (isdefined(point)) {
                behaviortreeentity.lastknownenemypos = point;
                origin = point;
            } else if (isdefined(behaviortreeentity.lastknownenemypos)) {
                origin = behaviortreeentity.lastknownenemypos;
            }
        }
        behaviortreeentity function_d30fe558(origin);
        return true;
    }
    if (isdefined(behaviortreeentity.var_f4a5c4fe)) {
        point = getclosestpointonnavmesh(behaviortreeentity.var_f4a5c4fe, 20, 16);
        if (isdefined(point)) {
            behaviortreeentity setgoal(behaviortreeentity.var_f4a5c4fe, 1);
        } else {
            behaviortreeentity setgoal(behaviortreeentity.origin, 1);
        }
        behaviortreeentity.var_f4a5c4fe = undefined;
        return true;
    }
    return false;
}

// Namespace doa_enemy
// Params 0, eflags: 0x4
// Checksum 0x16adbee6, Offset: 0x1a38
// Size: 0xdd
function private function_f5ef629b() {
    self endon(#"death");
    self endon(#"hash_d96c599c");
    while (level flag::get("doa_round_spawning")) {
        wait 1;
    }
    if (!isdefined(self.zombie_move_speed)) {
        self.zombie_move_speed = "run";
    }
    while (true) {
        left = namespace_49107f3a::function_b99d78c7();
        if (left <= 5) {
            if (self.zombie_move_speed == "walk") {
                self.zombie_move_speed = "run";
            } else if (self.zombie_move_speed == "run") {
                self.zombie_move_speed = "sprint";
            } else {
                return;
            }
        }
        wait randomfloatrange(1, 4);
    }
}

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0x71de6dd6, Offset: 0x1b20
// Size: 0x106
function updatespeed() {
    self thread function_f5ef629b();
    if (isdefined(self.var_2317157c)) {
        self.zombie_move_speed = "crawl";
        return;
    }
    if (isdefined(self.var_4d621ba4)) {
        self.zombie_move_speed = "walk";
        return;
    }
    if (isdefined(self.var_9c10604e)) {
        self.zombie_move_speed = "run";
        return;
    }
    if (isdefined(self.var_72932907)) {
        self.zombie_move_speed = "sprint";
        return;
    }
    rand = randomintrange(level.doa.zombie_move_speed - 25, level.doa.zombie_move_speed + 20);
    if (rand <= 40) {
        self.zombie_move_speed = "walk";
        return;
    }
    if (rand <= 70) {
        self.zombie_move_speed = "run";
        return;
    }
    self.zombie_move_speed = "sprint";
}

// Namespace doa_enemy
// Params 1, eflags: 0x0
// Checksum 0x5271acd4, Offset: 0x1c30
// Size: 0x19
function function_d597e3fc(behaviortreeentity) {
    return behaviortreeentity haspath();
}

// Namespace doa_enemy
// Params 1, eflags: 0x0
// Checksum 0x21053a5a, Offset: 0x1c58
// Size: 0x19
function function_323b0769(behaviortreeentity) {
    return behaviortreeentity haspath();
}

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0xc68e3ec5, Offset: 0x1c80
// Size: 0xd1
function function_69b8254() {
    if (isdefined(self.enemy)) {
        if (isdefined(self.enemy.doa) && isdefined(self.enemy.doa.vehicle)) {
            if (!isdefined(self.lastknownenemypos) && isdefined(self.enemy.doa.vehicle.groundpos)) {
                self.lastknownenemypos = self.enemy.doa.vehicle.groundpos;
            }
            return self.enemy.doa.vehicle.origin;
        } else {
            return self.enemy.origin;
        }
    }
    return self.origin;
}

// Namespace doa_enemy
// Params 1, eflags: 0x0
// Checksum 0xddfe1189, Offset: 0x1d60
// Size: 0xbd
function function_f31da0d1(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    yaw = abs(namespace_49107f3a::getyawtoenemy());
    if (yaw > 45) {
        return false;
    }
    targetorigin = behaviortreeentity function_69b8254();
    if (distancesquared(behaviortreeentity.origin, targetorigin) > 92 * 92) {
        return false;
    }
    if (distance2dsquared(behaviortreeentity.origin, targetorigin) < 2304) {
        return true;
    }
    return false;
}

// Namespace doa_enemy
// Params 15, eflags: 0x0
// Checksum 0xa0f53657, Offset: 0x1e28
// Size: 0x402
function function_2241fc21(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
    self endon(#"death");
    if (self.team == "allies") {
        namespace_49107f3a::debugmsg("Friendly actor [" + self.archetype + "] took damage:" + idamage);
    }
    if (isdefined(self.allowdeath) && self.allowdeath == 0 && idamage >= self.health) {
        idamage = self.health - 1;
    }
    if (isdefined(eattacker) && (isdefined(einflictor) && einflictor.team == self.team || eattacker.team == self.team)) {
        self finishactordamage(einflictor, eattacker, 0, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, surfacetype, surfacenormal);
        return;
    }
    if (isdefined(self.fx) && self.health <= idamage) {
        self thread namespace_eaa992c::turnofffx(self.fx);
        self.fx = undefined;
    }
    if (isdefined(weapon) && isdefined(level.doa.var_7808fc8c[weapon.name])) {
        level [[ level.doa.var_7808fc8c[weapon.name] ]](self, idamage, eattacker, vdir, smeansofdeath, weapon);
    }
    self namespace_fba031c8::function_15a268a6(eattacker, idamage, smeansofdeath, weapon, shitloc, vdir);
    if (smeansofdeath == "MOD_BURNED") {
        namespace_49107f3a::debugmsg("GAS DAMAGE " + idamage + " Health Left:" + self.health + (idamage > self.health ? " **FATALITY**" : ""));
    }
    if (smeansofdeath == "MOD_CRUSH") {
        if (isdefined(self.boss) && self.boss) {
            idamage = 0;
        } else {
            idamage = self.health;
        }
    }
    if (isdefined(self.overrideactordamage)) {
        idamage = self [[ self.overrideactordamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex);
    } else if (isdefined(level.overrideactordamage)) {
        idamage = self [[ level.overrideactordamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex);
    }
    if (isdefined(self.aioverridedamage)) {
        if (isarray(self.aioverridedamage)) {
            foreach (cb in self.aioverridedamage) {
                idamage = self [[ cb ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex);
            }
        } else {
            idamage = self [[ self.aioverridedamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, timeoffset, boneindex, modelindex);
        }
    }
    if (idamage >= self.health) {
        self zombie_eye_glow_stop();
    }
    if (isdefined(eattacker) && isdefined(eattacker.owner)) {
        eattacker = eattacker.owner;
    }
    self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, surfacetype, surfacenormal);
}

// Namespace doa_enemy
// Params 14, eflags: 0x0
// Checksum 0x7cb99b69, Offset: 0x2238
// Size: 0x3f4
function function_ff217d39(einflictor, eattacker, idamage, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(einflictor)) {
        self.damageinflictor = einflictor;
    }
    self asmsetanimationrate(1);
    if (self.team == "allies") {
        namespace_49107f3a::debugmsg("Friendly actor killed: " + self.archetype);
    }
    if (isdefined(self.fx)) {
        self thread namespace_eaa992c::turnofffx(self.fx);
    }
    if (randomint(100) < 20) {
        switch (randomint(3)) {
        case 0:
            self thread namespace_eaa992c::function_285a2999("headshot");
            break;
        case 1:
            self thread namespace_eaa992c::function_285a2999("headshot_nochunks");
            break;
        default:
            self thread namespace_eaa992c::function_285a2999("bloodspurt");
            break;
        }
    }
    if (isdefined(self.doa) && !(isdefined(self.boss) && self.boss) && !(isdefined(self.doa.var_4d252af6) && self.doa.var_4d252af6)) {
        roll = randomint(isdefined(self.var_2ea42113) ? self.var_2ea42113 : getdvarint("scr_doa_drop_rate_perN", -56));
        if (roll == 0) {
            namespace_a7e6beb5::function_16237a19(self.origin, 1, 85, 1, 0, undefined, level.doa.var_9bf7e61b);
        }
    }
    if (isdefined(self.interdimensional_gun_kill) && self.interdimensional_gun_kill) {
        self namespace_fba031c8::function_7b3e39cb();
        level thread namespace_a7e6beb5::function_16237a19(self.origin, 1, 1, 1, 1);
    }
    if (isdefined(eattacker)) {
        if (isactor(eattacker) && isdefined(eattacker.owner) && isplayer(eattacker.owner)) {
            eattacker = eattacker.owner;
        }
        if (isplayer(eattacker) && isdefined(eattacker.doa) && isdefined(self.doa) && isdefined(self.doa.points)) {
            eattacker globallogic_score::incpersstat("kills", 1, 1, 1);
            eattacker.kills = math::clamp(eattacker.kills + 1, 0, 65535);
            eattacker namespace_64c6b720::function_80eb303(self.doa.points);
        }
    }
    if (smeansofdeath == "MOD_CRUSH") {
        assert(!(isdefined(self.boss) && self.boss));
        self namespace_fba031c8::function_ddf685e8();
        self startragdoll(1);
        if (isdefined(eattacker)) {
            eattacker notify(#"hash_108fd845");
        }
    }
}

// Namespace doa_enemy
// Params 15, eflags: 0x0
// Checksum 0x700a50ea, Offset: 0x2638
// Size: 0x1a2
function function_c26b6656(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(eattacker) && eattacker.team == self.team) {
        idamage = 0;
    }
    if (isdefined(self.playercontrolled) && isdefined(self.owner) && isplayer(self.owner) && self.playercontrolled) {
        if (isdefined(eattacker.var_dcdf7239) && isdefined(eattacker) && eattacker.var_dcdf7239) {
        }
        idamage = 0;
    }
    if (isdefined(self.overridevehicledamage)) {
        idamage = self [[ self.overridevehicledamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    } else if (isdefined(level.overridevehicledamage)) {
        idamage = self [[ level.overridevehicledamage ]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    }
    if (idamage == 0) {
        return;
    }
    self finishvehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, 0);
}

// Namespace doa_enemy
// Params 8, eflags: 0x0
// Checksum 0x7e8f9ff0, Offset: 0x27e8
// Size: 0x1b0
function function_90772ac6(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
    if (isdefined(einflictor)) {
        self.damageinflictor = einflictor;
    }
    if (isdefined(eattacker) && isplayer(eattacker) && isdefined(eattacker.doa) && isdefined(self.doa)) {
        eattacker globallogic_score::incpersstat("kills", 1, 1, 1);
        eattacker.kills = math::clamp(eattacker.kills + 1, 0, 65535);
        eattacker namespace_64c6b720::function_80eb303(self.doa.points);
    }
    params = spawnstruct();
    params.einflictor = einflictor;
    params.eattacker = eattacker;
    params.idamage = idamage;
    params.smeansofdeath = smeansofdeath;
    params.weapon = weapon;
    params.vdir = vdir;
    params.shitloc = shitloc;
    params.psoffsettime = psoffsettime;
    self callback::callback(#"hash_acb66515", params);
    if (isdefined(self.overridevehiclekilled)) {
        self [[ self.overridevehiclekilled ]](einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
}

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0x35947eb7, Offset: 0x29a0
// Size: 0x4e
function function_e77599c() {
    level.doa.var_b351e5fb++;
    self waittill(#"death");
    level.doa.var_b351e5fb--;
    if (level.doa.var_b351e5fb < 0) {
        level.doa.var_b351e5fb = 0;
    }
}

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0xa23cfeba, Offset: 0x29f8
// Size: 0x89
function function_7c435737() {
    self endon(#"death");
    self endon(#"hash_10fd80ee");
    while (isalive(self)) {
        target = namespace_831a4a7c::function_35f36dec(self.origin);
        if (isdefined(target) && !(isdefined(self.ignoreall) && self.ignoreall)) {
            self setentitytarget(target);
        } else {
            self clearentitytarget();
        }
        wait 1;
    }
}

// Namespace doa_enemy
// Params 3, eflags: 0x0
// Checksum 0x4f4bc870, Offset: 0x2a90
// Size: 0x36c
function function_a4e16560(var_1e913765, s_spawn_loc, force) {
    if (!isdefined(force)) {
        force = 0;
    }
    /#
    #/
    if (!force && level.doa.var_b351e5fb >= level.doa.rules.max_enemy_count) {
        return;
    }
    if (!mayspawnentity()) {
        return;
    }
    var_1e913765.count = 9999;
    ai_spawned = var_1e913765 spawner::spawn(1);
    if (!isdefined(ai_spawned)) {
        return;
    }
    ai_spawned.spawner = var_1e913765;
    if (!isdefined(s_spawn_loc.angles)) {
        s_spawn_loc.angles = (0, 0, 0);
    }
    ai_spawned setthreatbiasgroup("zombies");
    ai_spawned.doa = spawnstruct();
    ai_spawned.doa.original_origin = ai_spawned.origin;
    ai_spawned.doa.points = level.doa.rules.var_c7b07ba9;
    ai_spawned.doa.stunned = 0;
    ai_spawned.no_eye_glow = 1;
    ai_spawned.holdfire = 1;
    ai_spawned.meleedamage = 123;
    ai_spawned thread function_e77599c();
    ai_spawned thread function_53055b45();
    ai_spawned thread function_155957e9();
    ai_spawned thread function_755b8a2e();
    ai_spawned thread function_8abf3753();
    ai_spawned thread namespace_49107f3a::function_783519c1("cleanUpAI", 1);
    if (isvehicle(ai_spawned)) {
        ai_spawned.origin = s_spawn_loc.origin;
        ai_spawned.angles = s_spawn_loc.angles;
        return ai_spawned;
    } else {
        self.var_ccaea265 = &function_d30fe558;
        gibserverutils::togglespawngibs(ai_spawned, 1);
    }
    if (isdefined(var_1e913765.script_noteworthy) && issubstr(var_1e913765.script_noteworthy, "has_eyes")) {
        ai_spawned.no_eye_glow = undefined;
        ai_spawned zombie_eye_glow();
    }
    ai_spawned forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
    ai_spawned.goalradius = 8;
    ai_spawned updatespeed();
    ai_spawned.health = level.doa.zombie_health;
    ai_spawned.maxhealth = level.doa.zombie_health;
    ai_spawned.animname = "zombie";
    ai_spawned.var_a7d1d70c = 0;
    ai_spawned.updatesight = 0;
    ai_spawned.maxsightdistsqrd = 512 * 512;
    ai_spawned.fovcosine = 0.77;
    ai_spawned.badplaceawareness = 0;
    ai_spawned setrepairpaths(0);
    return ai_spawned;
}

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0xdecaf842, Offset: 0x2e08
// Size: 0x16
function function_71a4f1d5() {
    self waittill(#"actor_corpse", corpse);
}

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0x5d9688ad, Offset: 0x2e28
// Size: 0x32
function zombie_eye_glow() {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.no_eye_glow) || !self.no_eye_glow) {
        self clientfield::set("zombie_has_eyes", 1);
    }
}

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0x66b1eaeb, Offset: 0x2e68
// Size: 0x32
function zombie_eye_glow_stop() {
    if (!isdefined(self)) {
        return;
    }
    if (!isdefined(self.no_eye_glow) || !self.no_eye_glow) {
        self clientfield::set("zombie_has_eyes", 0);
    }
}

// Namespace doa_enemy
// Params 1, eflags: 0x4
// Checksum 0xe0f870cd, Offset: 0x2ea8
// Size: 0x3a
function private function_8abf3753(time) {
    if (!isdefined(time)) {
        time = 1;
    }
    self endon(#"death");
    wait time;
    self.doa.original_origin = self.origin;
}

// Namespace doa_enemy
// Params 1, eflags: 0x0
// Checksum 0x5c377c32, Offset: 0x2ef0
// Size: 0x8a
function function_8a4222de(time) {
    if (!isactor(self)) {
        return;
    }
    self endon(#"death");
    self endon(#"hash_67a97d62");
    self setavoidancemask("avoid none");
    var_e0bc9b4c = self function_1762804b(0);
    wait time;
    self setavoidancemask("avoid all");
    if (isdefined(var_e0bc9b4c)) {
        self function_1762804b(var_e0bc9b4c);
    }
}

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0xabd7df9, Offset: 0x2f88
// Size: 0xd5
function function_155957e9() {
    self endon(#"death");
    self endon(#"hash_67a97d62");
    if (isdefined(self.boss)) {
        return;
    }
    var_2f36e0eb = 0;
    while (!level flag::get("doa_game_is_over")) {
        wait 1;
        var_d88cc53c = namespace_3ca3c537::function_dc34896f();
        if (!self istouching(var_d88cc53c)) {
            var_2f36e0eb++;
        } else {
            var_2f36e0eb = 0;
        }
        if (var_2f36e0eb == 5) {
            namespace_49107f3a::debugmsg("Enemy at location:" + self.origin + " is suiciding due SafeZoneFailure. Targetname:" + self.spawner.targetname);
            self delete();
        }
    }
}

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0x89ea7dbd, Offset: 0x3068
// Size: 0x6a
function function_755b8a2e() {
    self endon(#"death");
    self endon(#"hash_6dcbb83e");
    wait 1;
    while (level flag::get("doa_round_spawning")) {
        wait 0.05;
    }
    if (namespace_49107f3a::function_b99d78c7() > 5) {
        wait 0.05;
    }
    self thread namespace_49107f3a::function_ba30b321(60);
}

// Namespace doa_enemy
// Params 0, eflags: 0x0
// Checksum 0x31080812, Offset: 0x30e0
// Size: 0x2d5
function function_53055b45() {
    self endon(#"death");
    self endon(#"hash_6e8326fc");
    if (isdefined(self.boss)) {
        return;
    }
    if (isdefined(self.doa.mini_boss)) {
    }
    fails = 0;
    while (!level flag::get("doa_game_is_over")) {
        InvalidOpCode(0xb9, isdefined(self.var_9da96e67) && self.var_9da96e67, isdefined(self.var_dd70dacd) && self.var_dd70dacd);
        // Unknown operator (0xb9, t7_1b, PC)
    LOC_000000cd:
        if (isdefined(self.doa.poi) || self.doa.stunned != 0 || isdefined(self.doa.poi) || self.doa.stunned != 0) {
            wait 1;
            continue;
        }
        if (fails == 0) {
            if (isdefined(self.var_b7e79322) && self.var_b7e79322) {
                checkpos = (self.origin[0], self.origin[1], self.origin[2]);
                time = 2;
            } else {
                checkpos = (self.origin[0], self.origin[1], 0);
                time = 1;
            }
        }
        wait time;
        if (isdefined(self.var_b7e79322) && self.var_b7e79322) {
            mindistsq = 4 * 4;
            var_3faea97b = (self.origin[0], self.origin[1], self.origin[2]);
        } else {
            mindistsq = 32 * 32;
            var_3faea97b = (self.origin[0], self.origin[1], 0);
        }
        distsq = distancesquared(checkpos, var_3faea97b);
        if (distsq < mindistsq) {
            fails++;
            if (fails == 2) {
                self thread function_8a4222de(3);
            }
            if (fails == 5) {
                namespace_49107f3a::debugmsg("Enemy at location:" + self.origin + " is suiciding due to failsafe. Targetname:" + self.spawner.targetname);
                self dodamage(self.health + 666, self.origin);
            }
        } else {
            fails = 0;
        }
        if (level flag::get("doa_round_spawning") || isdefined(self.doa.poi)) {
            continue;
        }
        if (isdefined(self.iscrawler) && (isdefined(self.missinglegs) && self.missinglegs || self.iscrawler)) {
            self dodamage(int(self.maxhealth * 0.1), self.origin);
        }
    }
}

