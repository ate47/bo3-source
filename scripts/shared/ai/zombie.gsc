#using scripts/shared/ai/archetype_zombie_interface;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/ai_shared;

#namespace zombiebehavior;

// Namespace zombiebehavior
// Params 0, eflags: 0x2
// Checksum 0xeabd0f58, Offset: 0xd08
// Size: 0x124
function init() {
    initzombiebehaviorsandasm();
    spawner::add_archetype_spawn_function("zombie", &archetypezombieblackboardinit);
    spawner::add_archetype_spawn_function("zombie", &archetypezombiedeathoverrideinit);
    spawner::add_archetype_spawn_function("zombie", &archetypezombiespecialeffectsinit);
    spawner::add_archetype_spawn_function("zombie", &zombie_utility::zombiespawnsetup);
    clientfield::register("actor", "zombie", 1, 1, "int");
    clientfield::register("actor", "zombie_special_day", 6001, 1, "counter");
    zombieinterface::registerzombieinterfaceattributes();
}

// Namespace zombiebehavior
// Params 0, eflags: 0x5 linked
// Checksum 0xaae773bd, Offset: 0xe38
// Size: 0x6f4
function initzombiebehaviorsandasm() {
    behaviortreenetworkutility::registerbehaviortreeaction("zombieMoveAction", &zombiemoveaction, &zombiemoveactionupdate, undefined);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieTargetService", &zombietargetservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieCrawlerCollisionService", &zombiecrawlercollision);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieTraversalService", &zombietraversalservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieIsAtAttackObject", &zombieisatattackobject);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldAttackObject", &zombieshouldattackobject);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldMelee", &zombieshouldmeleecondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldJumpMelee", &zombieshouldjumpmeleecondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldJumpUnderwaterMelee", &zombieshouldjumpunderwatermelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieGibLegsCondition", &zombiegiblegscondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldDisplayPain", &zombieshoulddisplaypain);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isZombieWalking", &iszombiewalking);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldMeleeSuicide", &zombieshouldmeleesuicide);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieMeleeSuicideStart", &zombiemeleesuicidestart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieMeleeSuicideUpdate", &zombiemeleesuicideupdate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieMeleeSuicideTerminate", &zombiemeleesuicideterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldJuke", &zombieshouldjukecondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieJukeActionStart", &zombiejukeactionstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieJukeActionTerminate", &zombiejukeactionterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieDeathAction", &zombiedeathaction);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieJukeService", &zombiejuke);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieStumbleService", &zombiestumble);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieStumbleCondition", &zombieshouldstumblecondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieStumbleActionStart", &zombiestumbleactionstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieAttackObjectStart", &zombieattackobjectstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieAttackObjectTerminate", &zombieattackobjectterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("wasKilledByInterdimensionalGun", &waskilledbyinterdimensionalguncondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("wasCrushedByInterdimensionalGunBlackhole", &wascrushedbyinterdimensionalgunblackholecondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieIDGunDeathUpdate", &zombieidgundeathupdate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieVortexPullUpdate", &zombieidgundeathupdate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieHasLegs", &zombiehaslegs);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zombieShouldProceduralTraverse", &zombieshouldproceduraltraverse);
    animationstatenetwork::registernotetrackhandlerfunction("zombie_melee", &zombienotetrackmeleefire);
    animationstatenetwork::registernotetrackhandlerfunction("crushed", &zombienotetrackcrushfire);
    animationstatenetwork::registeranimationmocomp("mocomp_death_idgun@zombie", &zombieidgundeathmocompstart, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_vortex_pull@zombie", &zombieidgundeathmocompstart, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_death_idgun_hole@zombie", &zombieidgunholedeathmocompstart, undefined, &zombieidgunholedeathmocompterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_turn@zombie", &zombieturnmocompstart, &zombieturnmocompupdate, &zombieturnmocompterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_melee_jump@zombie", &zombiemeleejumpmocompstart, &zombiemeleejumpmocompupdate, &zombiemeleejumpmocompterminate);
    animationstatenetwork::registeranimationmocomp("mocomp_zombie_idle@zombie", &zombiezombieidlemocompstart, undefined, undefined);
    animationstatenetwork::registeranimationmocomp("mocomp_attack_object@zombie", &zombieattackobjectmocompstart, &zombieattackobjectmocompupdate, undefined);
}

// Namespace zombiebehavior
// Params 0, eflags: 0x1 linked
// Checksum 0x474e1c3a, Offset: 0x1538
// Size: 0x5b4
function archetypezombieblackboardinit() {
    blackboard::createblackboardforentity(self);
    self aiutility::function_89e1fc16();
    ai::createinterfaceforentity(self);
    blackboard::registerblackboardattribute(self, "_arms_position", "arms_up", &bb_getarmsposition);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zombieTraversalService");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_walk", &function_f8ae4008);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zombieTraversalService");
        #/
    }
    blackboard::registerblackboardattribute(self, "_has_legs", "has_legs_yes", &bb_gethaslegsstatus);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zombieTraversalService");
        #/
    }
    blackboard::registerblackboardattribute(self, "_variant_type", 0, &bb_getvarianttype);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zombieTraversalService");
        #/
    }
    blackboard::registerblackboardattribute(self, "_which_board_pull", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zombieTraversalService");
        #/
    }
    blackboard::registerblackboardattribute(self, "_board_attack_spot", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zombieTraversalService");
        #/
    }
    blackboard::registerblackboardattribute(self, "_grapple_direction", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zombieTraversalService");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_should_turn", "should_not_turn", &bb_getshouldturn);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zombieTraversalService");
        #/
    }
    blackboard::registerblackboardattribute(self, "_idgun_damage_direction", "back", &bb_idgungetdamagedirection);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zombieTraversalService");
        #/
    }
    blackboard::registerblackboardattribute(self, "_low_gravity_variant", 0, &bb_getlowgravityvariant);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zombieTraversalService");
        #/
    }
    blackboard::registerblackboardattribute(self, "_knockdown_direction", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zombieTraversalService");
        #/
    }
    blackboard::registerblackboardattribute(self, "_knockdown_type", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zombieTraversalService");
        #/
    }
    blackboard::registerblackboardattribute(self, "_whirlwind_speed", "whirlwind_normal", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zombieTraversalService");
        #/
    }
    blackboard::registerblackboardattribute(self, "_zombie_blackholebomb_pull_state", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("zombieTraversalService");
        #/
    }
    self.___archetypeonanimscriptedcallback = &archetypezombieonanimscriptedcallback;
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace zombiebehavior
// Params 1, eflags: 0x5 linked
// Checksum 0xbcdf9e74, Offset: 0x1af8
// Size: 0x34
function archetypezombieonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity archetypezombieblackboardinit();
}

// Namespace zombiebehavior
// Params 0, eflags: 0x1 linked
// Checksum 0xedf73a18, Offset: 0x1b38
// Size: 0x24
function archetypezombiespecialeffectsinit() {
    aiutility::addaioverridedamagecallback(self, &archetypezombiespecialeffectscallback);
}

// Namespace zombiebehavior
// Params 13, eflags: 0x5 linked
// Checksum 0x844b21f7, Offset: 0x1b68
// Size: 0xf8
function archetypezombiespecialeffectscallback(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
    specialdayeffectchance = getdvarint("tu6_ffotd_zombieSpecialDayEffectsChance", 0);
    if (specialdayeffectchance && randomint(100) < specialdayeffectchance) {
        if (isdefined(eattacker) && isplayer(eattacker)) {
            self clientfield::increment("zombie_special_day");
        }
    }
    return idamage;
}

// Namespace zombiebehavior
// Params 0, eflags: 0x1 linked
// Checksum 0xefc1a862, Offset: 0x1c68
// Size: 0x3a
function bb_getarmsposition() {
    if (isdefined(self.zombie_arms_position)) {
        if (self.zombie_arms_position == "up") {
            return "arms_up";
        }
        return "arms_down";
    }
    return "arms_up";
}

// Namespace zombiebehavior
// Params 0, eflags: 0x1 linked
// Checksum 0x3ce7253e, Offset: 0x1cb0
// Size: 0xf2
function function_f8ae4008() {
    if (isdefined(self.zombie_move_speed)) {
        if (self.zombie_move_speed == "walk") {
            return "locomotion_speed_walk";
        } else if (self.zombie_move_speed == "run") {
            return "locomotion_speed_run";
        } else if (self.zombie_move_speed == "sprint") {
            return "locomotion_speed_sprint";
        } else if (self.zombie_move_speed == "super_sprint") {
            return "locomotion_speed_super_sprint";
        } else if (self.zombie_move_speed == "jump_pad_super_sprint") {
            return "locomotion_speed_jump_pad_super_sprint";
        } else if (self.zombie_move_speed == "burned") {
            return "locomotion_speed_burned";
        } else if (self.zombie_move_speed == "slide") {
            return "locomotion_speed_slide";
        }
    }
    return "locomotion_speed_walk";
}

// Namespace zombiebehavior
// Params 0, eflags: 0x1 linked
// Checksum 0x90cffc3c, Offset: 0x1db0
// Size: 0x1a
function bb_getvarianttype() {
    if (isdefined(self.variant_type)) {
        return self.variant_type;
    }
    return 0;
}

// Namespace zombiebehavior
// Params 0, eflags: 0x1 linked
// Checksum 0x1d2bc77f, Offset: 0x1dd8
// Size: 0x1e
function bb_gethaslegsstatus() {
    if (self.missinglegs) {
        return "has_legs_no";
    }
    return "has_legs_yes";
}

// Namespace zombiebehavior
// Params 0, eflags: 0x1 linked
// Checksum 0x58256513, Offset: 0x1e00
// Size: 0x2a
function bb_getshouldturn() {
    if (isdefined(self.should_turn) && self.should_turn) {
        return "should_turn";
    }
    return "should_not_turn";
}

// Namespace zombiebehavior
// Params 0, eflags: 0x1 linked
// Checksum 0x61257325, Offset: 0x1e38
// Size: 0x2a
function bb_idgungetdamagedirection() {
    if (isdefined(self.damage_direction)) {
        return self.damage_direction;
    }
    return self aiutility::bb_getdamagedirection();
}

// Namespace zombiebehavior
// Params 0, eflags: 0x1 linked
// Checksum 0x5fbf48fe, Offset: 0x1e70
// Size: 0x1a
function bb_getlowgravityvariant() {
    if (isdefined(self.low_gravity_variant)) {
        return self.low_gravity_variant;
    }
    return 0;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0xc6cc2638, Offset: 0x1e98
// Size: 0x30
function iszombiewalking(behaviortreeentity) {
    return !(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs);
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x9a38b6a1, Offset: 0x1ed0
// Size: 0x58
function zombieshoulddisplaypain(behaviortreeentity) {
    if (isdefined(behaviortreeentity.suicidaldeath) && behaviortreeentity.suicidaldeath) {
        return false;
    }
    return !(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs);
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x4b04ad93, Offset: 0x1f30
// Size: 0x60
function zombieshouldjukecondition(behaviortreeentity) {
    if (behaviortreeentity.juke == "left" || isdefined(behaviortreeentity.juke) && behaviortreeentity.juke == "right") {
        return true;
    }
    return false;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0xae83b099, Offset: 0x1f98
// Size: 0x28
function zombieshouldstumblecondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.stumble)) {
        return true;
    }
    return false;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x5 linked
// Checksum 0x9d6f04c9, Offset: 0x1fc8
// Size: 0xb6
function zombiejukeactionstart(behaviortreeentity) {
    blackboard::setblackboardattribute(behaviortreeentity, "_juke_direction", behaviortreeentity.juke);
    if (isdefined(behaviortreeentity.jukedistance)) {
        blackboard::setblackboardattribute(behaviortreeentity, "_juke_distance", behaviortreeentity.jukedistance);
    } else {
        blackboard::setblackboardattribute(behaviortreeentity, "_juke_distance", "short");
    }
    behaviortreeentity.jukedistance = undefined;
    behaviortreeentity.juke = undefined;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x5 linked
// Checksum 0x34258b7f, Offset: 0x2088
// Size: 0x24
function zombiejukeactionterminate(behaviortreeentity) {
    behaviortreeentity clearpath();
}

// Namespace zombiebehavior
// Params 1, eflags: 0x5 linked
// Checksum 0x34c6476b, Offset: 0x20b8
// Size: 0x1a
function zombiestumbleactionstart(behaviortreeentity) {
    behaviortreeentity.stumble = undefined;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x5 linked
// Checksum 0xcefcfbfc, Offset: 0x20e0
// Size: 0x20
function zombieattackobjectstart(behaviortreeentity) {
    behaviortreeentity.is_inert = 1;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x5 linked
// Checksum 0x750cd3aa, Offset: 0x2108
// Size: 0x1c
function zombieattackobjectterminate(behaviortreeentity) {
    behaviortreeentity.is_inert = 0;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x1114b66c, Offset: 0x2130
// Size: 0x42
function zombiegiblegscondition(behaviortreeentity) {
    return gibserverutils::isgibbed(behaviortreeentity, 256) || gibserverutils::isgibbed(behaviortreeentity, -128);
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0xf87ab082, Offset: 0x2180
// Size: 0x40c
function zombienotetrackmeleefire(entity) {
    if (isdefined(entity.aat_turned) && entity.aat_turned) {
        if (isdefined(entity.enemy) && !isplayer(entity.enemy)) {
            if (isdefined(entity.enemy.allowdeath) && entity.enemy.archetype == "zombie" && entity.enemy.allowdeath) {
                gibserverutils::gibhead(entity.enemy);
                entity.enemy zombie_utility::gib_random_parts();
                entity.enemy kill();
                entity.n_aat_turned_zombie_kills++;
            } else if (isdefined(entity.enemy.allowdeath) && (entity.enemy.archetype == "zombie_quad" || entity.enemy.archetype == "spider") && entity.enemy.allowdeath) {
                entity.enemy kill();
                entity.n_aat_turned_zombie_kills++;
            } else if (isdefined(entity.enemy.canbetargetedbyturnedzombies) && entity.enemy.canbetargetedbyturnedzombies) {
                entity melee();
            }
        }
        return;
    }
    if (isdefined(entity.enemy.var_ebe6eb3d) && (isdefined(entity.enemy.bgb_in_plain_sight_active) && entity.enemy.bgb_in_plain_sight_active || isdefined(entity.enemy) && entity.enemy.var_ebe6eb3d)) {
        return;
    }
    if (isdefined(entity.enemy.allow_zombie_to_target_ai) && isdefined(entity.enemy) && entity.enemy.allow_zombie_to_target_ai) {
        if (entity.enemy.health > 0) {
            entity.enemy dodamage(entity.meleeweapon.meleedamage, entity.origin, entity, entity, "none", "MOD_MELEE");
        }
        return;
    }
    entity melee();
    /#
        record3dtext("zombieTraversalService", self.origin, (1, 0, 0), "zombieTraversalService", entity);
    #/
    if (zombieshouldattackobject(entity)) {
        if (isdefined(level.attackablecallback)) {
            entity.attackable [[ level.attackablecallback ]](entity);
        }
    }
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0xed32202c, Offset: 0x2598
// Size: 0x24
function zombienotetrackcrushfire(behaviortreeentity) {
    behaviortreeentity delete();
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0xd1a39e1f, Offset: 0x25c8
// Size: 0x2f8
function zombietargetservice(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enablepushtime)) {
        if (gettime() >= behaviortreeentity.enablepushtime) {
            behaviortreeentity function_1762804b(1);
            behaviortreeentity.enablepushtime = undefined;
        }
    }
    if (isdefined(behaviortreeentity.disabletargetservice) && behaviortreeentity.disabletargetservice) {
        return 0;
    }
    if (isdefined(behaviortreeentity.ignoreall) && behaviortreeentity.ignoreall) {
        return 0;
    }
    specifictarget = undefined;
    if (isdefined(level.zombielevelspecifictargetcallback)) {
        specifictarget = [[ level.zombielevelspecifictargetcallback ]]();
    }
    if (isdefined(specifictarget)) {
        behaviortreeentity setgoal(specifictarget.origin);
        return;
    }
    if (isdefined(behaviortreeentity.v_zombie_custom_goal_pos)) {
        goalpos = behaviortreeentity.v_zombie_custom_goal_pos;
        if (isdefined(behaviortreeentity.n_zombie_custom_goal_radius)) {
            behaviortreeentity.goalradius = behaviortreeentity.n_zombie_custom_goal_radius;
        }
        behaviortreeentity setgoal(goalpos);
        return;
    }
    player = zombie_utility::get_closest_valid_player(self.origin, self.ignore_player);
    if (!isdefined(player)) {
        if (isdefined(self.ignore_player)) {
            if (isdefined(level._should_skip_ignore_player_logic) && [[ level._should_skip_ignore_player_logic ]]()) {
                return 0;
            }
            self.ignore_player = [];
        }
        self setgoal(self.origin);
        return 0;
    }
    if (isdefined(player.last_valid_position)) {
        if (!(isdefined(self.zombie_do_not_update_goal) && self.zombie_do_not_update_goal)) {
            if (isdefined(level.zombie_use_zigzag_path) && level.zombie_use_zigzag_path) {
                behaviortreeentity zombieupdatezigzaggoal();
            } else {
                behaviortreeentity setgoal(player.last_valid_position);
            }
        }
        return 1;
    }
    if (!(isdefined(self.zombie_do_not_update_goal) && self.zombie_do_not_update_goal)) {
        behaviortreeentity setgoal(behaviortreeentity.origin);
    }
    return 0;
}

// Namespace zombiebehavior
// Params 0, eflags: 0x1 linked
// Checksum 0x1665c52f, Offset: 0x28c8
// Size: 0x5f4
function zombieupdatezigzaggoal() {
    aiprofile_beginentry("zombieUpdateZigZagGoal");
    shouldrepath = 0;
    if (!shouldrepath && isdefined(self.favoriteenemy)) {
        if (!isdefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime()) {
            shouldrepath = 1;
        } else if (distancesquared(self.origin, self.favoriteenemy.origin) <= -6 * -6) {
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
        goalpos = self.favoriteenemy.origin;
        if (isdefined(self.favoriteenemy.last_valid_position)) {
            goalpos = self.favoriteenemy.last_valid_position;
        }
        self setgoal(goalpos);
        if (distancesquared(self.origin, goalpos) > -6 * -6) {
            self.keep_moving = 1;
            self.keep_moving_time = gettime() + -6;
            path = self calcapproximatepathtoposition(goalpos, 0);
            /#
                if (getdvarint("zombieTraversalService")) {
                    for (index = 1; index < path.size; index++) {
                        recordline(path[index - 1], path[index], (1, 0.5, 0), "zombieTraversalService", self);
                    }
                }
            #/
            if (isdefined(level._zombiezigzagdistancemin) && isdefined(level._zombiezigzagdistancemax)) {
                min = level._zombiezigzagdistancemin;
                max = level._zombiezigzagdistancemax;
            } else {
                min = -16;
                max = 600;
            }
            deviationdistance = randomintrange(min, max);
            segmentlength = 0;
            for (index = 1; index < path.size; index++) {
                currentseglength = distance(path[index - 1], path[index]);
                if (segmentlength + currentseglength > deviationdistance) {
                    remaininglength = deviationdistance - segmentlength;
                    seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;
                    /#
                        recordcircle(seedposition, 2, (1, 0.5, 0), "zombieTraversalService", self);
                    #/
                    innerzigzagradius = 0;
                    outerzigzagradius = 96;
                    queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 0.5 * 72, 16, self, 16);
                    positionquery_filter_inclaimedlocation(queryresult, self);
                    if (queryresult.data.size > 0) {
                        point = queryresult.data[randomint(queryresult.data.size)];
                        self setgoal(point.origin);
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
            mintime = 2500;
            maxtime = 3500;
        }
        self.nextgoalupdate = gettime() + randomintrange(mintime, maxtime);
    }
    aiprofile_endentry();
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x69bdce3b, Offset: 0x2ec8
// Size: 0x216
function zombiecrawlercollision(behaviortreeentity) {
    if (!(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) && !(isdefined(behaviortreeentity.knockdown) && behaviortreeentity.knockdown)) {
        return false;
    }
    if (isdefined(behaviortreeentity.dontpushtime)) {
        if (gettime() < behaviortreeentity.dontpushtime) {
            return true;
        }
    }
    zombies = getaiteamarray(level.zombie_team);
    foreach (zombie in zombies) {
        if (zombie == behaviortreeentity) {
            continue;
        }
        if (isdefined(zombie.knockdown) && (isdefined(zombie.missinglegs) && zombie.missinglegs || zombie.knockdown)) {
            continue;
        }
        dist_sq = distancesquared(behaviortreeentity.origin, zombie.origin);
        if (dist_sq < 14400) {
            behaviortreeentity function_1762804b(0);
            behaviortreeentity.dontpushtime = gettime() + 2000;
            return true;
        }
    }
    behaviortreeentity function_1762804b(1);
    return false;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x8d3ce993, Offset: 0x30e8
// Size: 0x44
function zombietraversalservice(entity) {
    if (isdefined(entity.traversestartnode)) {
        entity function_1762804b(0);
        return true;
    }
    return false;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0xe903db5e, Offset: 0x3138
// Size: 0x200
function zombieisatattackobject(entity) {
    if (isdefined(entity.missinglegs) && entity.missinglegs) {
        return false;
    }
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.favoriteenemy.b_is_designated_target) && isdefined(entity.favoriteenemy) && entity.favoriteenemy.b_is_designated_target) {
        return false;
    }
    if (isdefined(entity.aat_turned) && entity.aat_turned) {
        return false;
    }
    if (isdefined(entity.attackable.is_active) && isdefined(entity.attackable) && entity.attackable.is_active) {
        if (!isdefined(entity.attackable_slot)) {
            return false;
        }
        dist = distance2dsquared(entity.origin, entity.attackable_slot.origin);
        if (dist < 256) {
            height_offset = abs(entity.origin[2] - entity.attackable_slot.origin[2]);
            if (height_offset < 32) {
                entity.is_at_attackable = 1;
                return true;
            }
        }
    }
    return false;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0xf0a619f9, Offset: 0x3340
// Size: 0x14e
function zombieshouldattackobject(entity) {
    if (isdefined(entity.missinglegs) && entity.missinglegs) {
        return false;
    }
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.favoriteenemy.b_is_designated_target) && isdefined(entity.favoriteenemy) && entity.favoriteenemy.b_is_designated_target) {
        return false;
    }
    if (isdefined(entity.aat_turned) && entity.aat_turned) {
        return false;
    }
    if (isdefined(entity.attackable.is_active) && isdefined(entity.attackable) && entity.attackable.is_active) {
        if (isdefined(entity.is_at_attackable) && entity.is_at_attackable) {
            return true;
        }
    }
    return false;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x7c3aa022, Offset: 0x3498
// Size: 0x164
function zombieshouldmeleecondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemyoverride) && isdefined(behaviortreeentity.enemyoverride[1])) {
        return false;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    if (isdefined(behaviortreeentity.marked_for_death)) {
        return false;
    }
    if (isdefined(behaviortreeentity.ignoremelee) && behaviortreeentity.ignoremelee) {
        return false;
    }
    if (distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > 4096) {
        return false;
    }
    yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0xe20e0b6c, Offset: 0x3608
// Size: 0x2f8
function zombieshouldjumpmeleecondition(behaviortreeentity) {
    if (!(isdefined(behaviortreeentity.low_gravity) && behaviortreeentity.low_gravity)) {
        return false;
    }
    if (isdefined(behaviortreeentity.enemyoverride) && isdefined(behaviortreeentity.enemyoverride[1])) {
        return false;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    if (isdefined(behaviortreeentity.marked_for_death)) {
        return false;
    }
    if (isdefined(behaviortreeentity.ignoremelee) && behaviortreeentity.ignoremelee) {
        return false;
    }
    if (behaviortreeentity.enemy isonground()) {
        return false;
    }
    jumpchance = getdvarfloat("zmMeleeJumpChance", 0.5);
    if (behaviortreeentity getentitynumber() % 10 / 10 > jumpchance) {
        return false;
    }
    predictedposition = behaviortreeentity.enemy.origin + behaviortreeentity.enemy getvelocity() * 0.05 * 2;
    jumpdistancesq = pow(getdvarint("zmMeleeJumpDistance", -76), 2);
    if (distance2dsquared(behaviortreeentity.origin, predictedposition) > jumpdistancesq) {
        return false;
    }
    yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    heighttoenemy = behaviortreeentity.enemy.origin[2] - behaviortreeentity.origin[2];
    if (heighttoenemy <= getdvarint("zmMeleeJumpHeightDifference", 60)) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x8d53e452, Offset: 0x3908
// Size: 0x258
function zombieshouldjumpunderwatermelee(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemyoverride) && isdefined(behaviortreeentity.enemyoverride[1])) {
        return false;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    if (isdefined(behaviortreeentity.marked_for_death)) {
        return false;
    }
    if (isdefined(behaviortreeentity.ignoremelee) && behaviortreeentity.ignoremelee) {
        return false;
    }
    if (behaviortreeentity.enemy isonground()) {
        return false;
    }
    if (behaviortreeentity depthinwater() < 48) {
        return false;
    }
    jumpdistancesq = pow(getdvarint("zmMeleeWaterJumpDistance", 64), 2);
    if (distance2dsquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > jumpdistancesq) {
        return false;
    }
    yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    heighttoenemy = behaviortreeentity.enemy.origin[2] - behaviortreeentity.origin[2];
    if (heighttoenemy <= getdvarint("zmMeleeJumpUnderwaterHeightDifference", 48)) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x12859ae1, Offset: 0x3b68
// Size: 0x1d0
function zombiestumble(behaviortreeentity) {
    if (isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
        return false;
    }
    if (!(isdefined(behaviortreeentity.canstumble) && behaviortreeentity.canstumble)) {
        return false;
    }
    if (!isdefined(behaviortreeentity.zombie_move_speed) || behaviortreeentity.zombie_move_speed != "sprint") {
        return false;
    }
    if (isdefined(behaviortreeentity.stumble)) {
        return false;
    }
    if (!isdefined(behaviortreeentity.next_stumble_time)) {
        behaviortreeentity.next_stumble_time = gettime() + randomintrange(9000, 12000);
    }
    if (gettime() > behaviortreeentity.next_stumble_time) {
        if (randomint(100) < 5) {
            closestplayer = arraygetclosest(behaviortreeentity.origin, level.players);
            if (distancesquared(closestplayer.origin, behaviortreeentity.origin) > 50000) {
                if (isdefined(behaviortreeentity.next_juke_time)) {
                    behaviortreeentity.next_juke_time = undefined;
                }
                behaviortreeentity.next_stumble_time = undefined;
                behaviortreeentity.stumble = 1;
                return true;
            }
        }
    }
    return false;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x4e3e8d48, Offset: 0x3d40
// Size: 0x3ca
function zombiejuke(behaviortreeentity) {
    if (!behaviortreeentity ai::has_behavior_attribute("can_juke")) {
        return 0;
    }
    if (!behaviortreeentity ai::get_behavior_attribute("can_juke")) {
        return 0;
    }
    if (isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) {
        return 0;
    }
    if (behaviortreeentity function_f8ae4008() != "locomotion_speed_walk") {
        if (behaviortreeentity ai::has_behavior_attribute("spark_behavior") && !behaviortreeentity ai::get_behavior_attribute("spark_behavior")) {
            return 0;
        }
    }
    if (isdefined(behaviortreeentity.juke)) {
        return 0;
    }
    if (!isdefined(behaviortreeentity.next_juke_time)) {
        behaviortreeentity.next_juke_time = gettime() + randomintrange(7500, 9500);
    }
    if (gettime() > behaviortreeentity.next_juke_time) {
        behaviortreeentity.next_juke_time = undefined;
        if (behaviortreeentity ai::has_behavior_attribute("spark_behavior") && (randomint(100) < 25 || behaviortreeentity ai::get_behavior_attribute("spark_behavior"))) {
            if (isdefined(behaviortreeentity.next_stumble_time)) {
                behaviortreeentity.next_stumble_time = undefined;
            }
            forwardoffset = 15;
            behaviortreeentity.ignorebackwardposition = 1;
            if (math::cointoss()) {
                jukedistance = 101;
                behaviortreeentity.jukedistance = "long";
                switch (behaviortreeentity function_f8ae4008()) {
                case 71:
                case 48:
                    forwardoffset = 122;
                    break;
                case 73:
                    forwardoffset = -127;
                    break;
                }
                behaviortreeentity.juke = aiutility::calculatejukedirection(behaviortreeentity, forwardoffset, jukedistance);
            }
            if (!isdefined(behaviortreeentity.juke) || behaviortreeentity.juke == "forward") {
                jukedistance = 69;
                behaviortreeentity.jukedistance = "short";
                switch (behaviortreeentity function_f8ae4008()) {
                case 71:
                case 48:
                    forwardoffset = 127;
                    break;
                case 73:
                    forwardoffset = -108;
                    break;
                }
                behaviortreeentity.juke = aiutility::calculatejukedirection(behaviortreeentity, forwardoffset, jukedistance);
                if (behaviortreeentity.juke == "forward") {
                    behaviortreeentity.juke = undefined;
                    behaviortreeentity.jukedistance = undefined;
                    return 0;
                }
            }
        }
    }
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x86ce86fc, Offset: 0x4118
// Size: 0xc
function zombiedeathaction(behaviortreeentity) {
    
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x4f7a2abf, Offset: 0x4130
// Size: 0x56
function waskilledbyinterdimensionalguncondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.interdimensional_gun_kill) && !isdefined(behaviortreeentity.killby_interdimensional_gun_hole) && isalive(behaviortreeentity)) {
        return true;
    }
    return false;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0xa729d1fb, Offset: 0x4190
// Size: 0x28
function wascrushedbyinterdimensionalgunblackholecondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.killby_interdimensional_gun_hole)) {
        return true;
    }
    return false;
}

// Namespace zombiebehavior
// Params 5, eflags: 0x1 linked
// Checksum 0x800f8ec9, Offset: 0x41c0
// Size: 0xcc
function zombieidgundeathmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("noclip");
    entity.pushable = 0;
    entity.blockingpain = 1;
    entity pathmode("dont move");
    entity.hole_pull_speed = 0;
}

// Namespace zombiebehavior
// Params 5, eflags: 0x1 linked
// Checksum 0xd022258e, Offset: 0x4298
// Size: 0xd8
function zombiemeleejumpmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face enemy");
    entity animmode("noclip", 0);
    entity.pushable = 0;
    entity.blockingpain = 1;
    entity.clamptonavmesh = 0;
    entity function_1762804b(0);
    entity.jumpstartposition = entity.origin;
}

// Namespace zombiebehavior
// Params 5, eflags: 0x1 linked
// Checksum 0x7b03a47c, Offset: 0x4378
// Size: 0x2b4
function zombiemeleejumpmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    normalizedtime = (entity getanimtime(mocompanim) * getanimlength(mocompanim) + mocompanimblendouttime) / mocompduration;
    if (normalizedtime > 0.5) {
        entity orientmode("face angle", entity.angles[1]);
    }
    speed = 5;
    if (isdefined(entity.zombie_move_speed)) {
        switch (entity.zombie_move_speed) {
        case 69:
            speed = 5;
            break;
        case 70:
            speed = 6;
            break;
        case 72:
            speed = 7;
            break;
        }
    }
    newposition = entity.origin + anglestoforward(entity.angles) * speed;
    newtestposition = (newposition[0], newposition[1], entity.jumpstartposition[2]);
    newvalidposition = getclosestpointonnavmesh(newtestposition, 12, 20);
    if (isdefined(newvalidposition)) {
        newvalidposition = (newvalidposition[0], newvalidposition[1], entity.origin[2]);
    } else {
        newvalidposition = entity.origin;
    }
    groundpoint = getclosestpointonnavmesh(newvalidposition, 12, 20);
    if (isdefined(groundpoint) && groundpoint[2] > newvalidposition[2]) {
        newvalidposition = (newvalidposition[0], newvalidposition[1], groundpoint[2]);
    }
    entity forceteleport(newvalidposition);
}

// Namespace zombiebehavior
// Params 5, eflags: 0x1 linked
// Checksum 0x59f7c3c8, Offset: 0x4638
// Size: 0xcc
function zombiemeleejumpmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.pushable = 1;
    entity.blockingpain = 0;
    entity.clamptonavmesh = 1;
    entity function_1762804b(1);
    groundpoint = getclosestpointonnavmesh(entity.origin, 12);
    if (isdefined(groundpoint)) {
        entity forceteleport(groundpoint);
    }
}

// Namespace zombiebehavior
// Params 5, eflags: 0x1 linked
// Checksum 0x65bb6823, Offset: 0x4710
// Size: 0x3cc
function zombieidgundeathupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (!isdefined(entity.killby_interdimensional_gun_hole)) {
        entity_eye = entity geteye();
        if (entity ispaused()) {
            entity setignorepauseworld(1);
            entity setentitypaused(0);
        }
        if (entity.b_vortex_repositioned !== 1) {
            entity.b_vortex_repositioned = 1;
            v_nearest_navmesh_point = getclosestpointonnavmesh(entity.damageorigin, 36, 15);
            if (isdefined(v_nearest_navmesh_point)) {
                f_distance = distance(entity.damageorigin, v_nearest_navmesh_point);
                if (f_distance < 41) {
                    entity.damageorigin += (0, 0, 36);
                }
            }
        }
        entity_center = entity.origin + (entity_eye - entity.origin) / 2;
        flyingdir = entity.damageorigin - entity_center;
        lengthfromhole = length(flyingdir);
        if (lengthfromhole < entity.hole_pull_speed) {
            entity.killby_interdimensional_gun_hole = 1;
            entity.allowdeath = 1;
            entity.takedamage = 1;
            entity.aioverridedamage = undefined;
            entity.magic_bullet_shield = 0;
            level notify(#"interdimensional_kill", entity);
            if (isdefined(entity.interdimensional_gun_weapon) && isdefined(entity.interdimensional_gun_attacker)) {
                entity kill(entity.origin, entity.interdimensional_gun_attacker, entity.interdimensional_gun_attacker, entity.interdimensional_gun_weapon);
            } else {
                entity kill(entity.origin);
            }
            return;
        }
        if (entity.hole_pull_speed < 12) {
            entity.hole_pull_speed += 0.5;
            if (entity.hole_pull_speed > 12) {
                entity.hole_pull_speed = 12;
            }
        }
        flyingdir = vectornormalize(flyingdir);
        entity forceteleport(entity.origin + flyingdir * entity.hole_pull_speed);
    }
}

// Namespace zombiebehavior
// Params 5, eflags: 0x1 linked
// Checksum 0x5ddb645b, Offset: 0x4ae8
// Size: 0x8c
function zombieidgunholedeathmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("noclip");
    entity.pushable = 0;
}

// Namespace zombiebehavior
// Params 5, eflags: 0x1 linked
// Checksum 0xc34baaee, Offset: 0x4b80
// Size: 0x6c
function zombieidgunholedeathmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (!(isdefined(entity.interdimensional_gun_kill_vortex_explosion) && entity.interdimensional_gun_kill_vortex_explosion)) {
        entity hide();
    }
}

// Namespace zombiebehavior
// Params 5, eflags: 0x5 linked
// Checksum 0x853e9a67, Offset: 0x4bf8
// Size: 0x7c
function zombieturnmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("angle deltas", 0);
}

// Namespace zombiebehavior
// Params 5, eflags: 0x5 linked
// Checksum 0xdc3f97f7, Offset: 0x4c80
// Size: 0xac
function zombieturnmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    normalizedtime = (entity getanimtime(mocompanim) + mocompanimblendouttime) / mocompduration;
    if (normalizedtime > 0.25) {
        entity orientmode("face motion");
        entity animmode("normal", 0);
    }
}

// Namespace zombiebehavior
// Params 5, eflags: 0x5 linked
// Checksum 0x1f398383, Offset: 0x4d38
// Size: 0x6c
function zombieturnmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face motion");
    entity animmode("normal", 0);
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0xc2bb20e3, Offset: 0x4db0
// Size: 0x2c
function zombiehaslegs(behaviortreeentity) {
    if (behaviortreeentity.missinglegs === 1) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x6f91d8f6, Offset: 0x4de8
// Size: 0x70
function zombieshouldproceduraltraverse(entity) {
    return isdefined(entity.traversestartnode) && isdefined(entity.traverseendnode) && entity.traversestartnode.spawnflags & 1024 && entity.traverseendnode.spawnflags & 1024;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x35e021ff, Offset: 0x4e60
// Size: 0xd0
function zombieshouldmeleesuicide(behaviortreeentity) {
    if (!behaviortreeentity ai::get_behavior_attribute("suicidal_behavior")) {
        return false;
    }
    if (isdefined(behaviortreeentity.magic_bullet_shield) && behaviortreeentity.magic_bullet_shield) {
        return false;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    if (isdefined(behaviortreeentity.marked_for_death)) {
        return false;
    }
    if (distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > 40000) {
        return false;
    }
    return true;
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x7b333aa4, Offset: 0x4f38
// Size: 0x44
function zombiemeleesuicidestart(behaviortreeentity) {
    behaviortreeentity.blockingpain = 1;
    if (isdefined(level.zombiemeleesuicidecallback)) {
        behaviortreeentity thread [[ level.zombiemeleesuicidecallback ]](behaviortreeentity);
    }
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0x5f0d1e1, Offset: 0x4f88
// Size: 0xc
function zombiemeleesuicideupdate(behaviortreeentity) {
    
}

// Namespace zombiebehavior
// Params 1, eflags: 0x1 linked
// Checksum 0xba45091, Offset: 0x4fa0
// Size: 0x88
function zombiemeleesuicideterminate(behaviortreeentity) {
    if (isalive(behaviortreeentity) && zombieshouldmeleesuicide(behaviortreeentity)) {
        behaviortreeentity.takedamage = 1;
        behaviortreeentity.allowdeath = 1;
        if (isdefined(level.zombiemeleesuicidedonecallback)) {
            behaviortreeentity thread [[ level.zombiemeleesuicidedonecallback ]](behaviortreeentity);
        }
    }
}

// Namespace zombiebehavior
// Params 2, eflags: 0x1 linked
// Checksum 0xad33b3b7, Offset: 0x5030
// Size: 0x150
function zombiemoveaction(behaviortreeentity, asmstatename) {
    behaviortreeentity.movetime = gettime();
    behaviortreeentity.moveorigin = behaviortreeentity.origin;
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    if (isdefined(behaviortreeentity.stumble) && !isdefined(behaviortreeentity.move_anim_end_time)) {
        stumbleactionresult = behaviortreeentity astsearch(istring(asmstatename));
        stumbleactionanimation = animationstatenetworkutility::searchanimationmap(behaviortreeentity, stumbleactionresult["animation"]);
        behaviortreeentity.move_anim_end_time = behaviortreeentity.movetime + getanimlength(stumbleactionanimation);
    }
    if (isdefined(behaviortreeentity.var_e06dd77b)) {
        behaviortreeentity [[ behaviortreeentity.var_e06dd77b ]](behaviortreeentity);
    }
    return 5;
}

// Namespace zombiebehavior
// Params 2, eflags: 0x1 linked
// Checksum 0x37b8d985, Offset: 0x5188
// Size: 0x1f2
function zombiemoveactionupdate(behaviortreeentity, asmstatename) {
    if (isdefined(behaviortreeentity.move_anim_end_time) && gettime() >= behaviortreeentity.move_anim_end_time) {
        behaviortreeentity.move_anim_end_time = undefined;
        return 4;
    }
    if (!(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs) && gettime() - behaviortreeentity.movetime > 1000) {
        distsq = distance2dsquared(behaviortreeentity.origin, behaviortreeentity.moveorigin);
        if (distsq < -112) {
            behaviortreeentity setavoidancemask("avoid all");
            behaviortreeentity.cant_move = 1;
            if (isdefined(behaviortreeentity.cant_move_cb)) {
                behaviortreeentity [[ behaviortreeentity.cant_move_cb ]]();
            }
        } else {
            behaviortreeentity setavoidancemask("avoid none");
            behaviortreeentity.cant_move = 0;
        }
        behaviortreeentity.movetime = gettime();
        behaviortreeentity.moveorigin = behaviortreeentity.origin;
    }
    if (behaviortreeentity asmgetstatus() == "asm_status_complete") {
        if (behaviortreeentity iscurrentbtactionlooping()) {
            zombiemoveaction(behaviortreeentity, asmstatename);
        } else {
            return 4;
        }
    }
    return 5;
}

// Namespace zombiebehavior
// Params 2, eflags: 0x0
// Checksum 0xa0a7b5ad, Offset: 0x5388
// Size: 0x58
function zombiemoveactionterminate(behaviortreeentity, asmstatename) {
    if (!(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs)) {
        behaviortreeentity setavoidancemask("avoid none");
    }
    return 4;
}

// Namespace zombiebehavior
// Params 0, eflags: 0x1 linked
// Checksum 0x91ae16f3, Offset: 0x53e8
// Size: 0x24
function archetypezombiedeathoverrideinit() {
    aiutility::addaioverridekilledcallback(self, &zombiegibkilledanhilateoverride);
}

// Namespace zombiebehavior
// Params 8, eflags: 0x5 linked
// Checksum 0x5088db3e, Offset: 0x5418
// Size: 0x2f8
function zombiegibkilledanhilateoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
    if (!(isdefined(level.zombieanhilationenabled) && level.zombieanhilationenabled)) {
        return damage;
    }
    if (isdefined(self.forceanhilateondeath) && self.forceanhilateondeath) {
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
        return damage;
    }
    if (isdefined(level.forceanhilateondeath) && (isdefined(attacker.forceanhilateondeath) && attacker.forceanhilateondeath || isdefined(attacker) && isplayer(attacker) && level.forceanhilateondeath)) {
        self zombie_utility::gib_random_parts();
        gibserverutils::annihilate(self);
        return damage;
    }
    attackerdistance = 0;
    if (isdefined(attacker)) {
        attackerdistance = distancesquared(attacker.origin, self.origin);
    }
    isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
    if (isdefined(weapon.weapclass) && weapon.weapclass == "turret") {
        if (isdefined(inflictor)) {
            isdirectexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
            iscloseexplosive = distancesquared(inflictor.origin, self.origin) <= 60 * 60;
            if (isdirectexplosive && iscloseexplosive) {
                self zombie_utility::gib_random_parts();
                gibserverutils::annihilate(self);
            }
        }
    }
    return damage;
}

// Namespace zombiebehavior
// Params 5, eflags: 0x5 linked
// Checksum 0x7f9aeea8, Offset: 0x5718
// Size: 0x11c
function zombiezombieidlemocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1]) && entity != entity.enemyoverride[1]) {
        entity orientmode("face direction", entity.enemyoverride[1].origin - entity.origin);
        entity animmode("zonly_physics", 0);
        return;
    }
    entity orientmode("face current");
    entity animmode("zonly_physics", 0);
}

// Namespace zombiebehavior
// Params 5, eflags: 0x5 linked
// Checksum 0x6788c382, Offset: 0x5840
// Size: 0xd4
function zombieattackobjectmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.attackable_slot)) {
        entity orientmode("face angle", entity.attackable_slot.angles[1]);
        entity animmode("zonly_physics", 0);
        return;
    }
    entity orientmode("face current");
    entity animmode("zonly_physics", 0);
}

// Namespace zombiebehavior
// Params 5, eflags: 0x5 linked
// Checksum 0x383c4c0f, Offset: 0x5920
// Size: 0x6c
function zombieattackobjectmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.attackable_slot)) {
        entity forceteleport(entity.attackable_slot.origin);
    }
}

